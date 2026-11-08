import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'api_cache.dart';
import 'api_cache.dart';
import 'artist_context.dart';
import 'artist_screen.dart';
import 'detail_page.dart';
import 'feed_screen.dart';
import 'inner_minimap.dart';
import 'px_cache.dart';
import 'related_cache.dart';
import 'traversal_guard.dart';
import 'web/pixiv_web_models.dart';
import 'web_session.dart';

class DetailScreen extends StatefulWidget {
  final List<WebDiscoveryIllust> items;
  final int initialIndex;
  final ArtistContext? artist;

  const DetailScreen({super.key, required this.items, this.initialIndex = 0, this.artist});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

/// Release velocity for the outer hold controller when an inner edge-drag
/// ends. Past ~12% of a page toward the neighbour the push commits with a
/// guaranteed fling (keeps the old eager feel for deliberate pushes);
/// below that the real finger velocity passes through and the framework's
/// own page-snapping decides — exactly like a plain PageView. Assumes
/// viewportFraction 1.0, i.e. page i sits at i * viewport.
double resolveEndVelocity({
  required double pixels,
  required double pageOrigin,
  required double viewport,
  required double fingerVelocity,
}) {
  if (viewport > 0) {
    final progress = (pixels - pageOrigin) / viewport;
    if (progress > 0.12) return -1600;
    if (progress < -0.12) return 1600;
  }
  return fingerVelocity;
}

class _DetailScreenState extends State<DetailScreen> {
  late final PageController _controller;
  late final ValueNotifier<double> _pagePos;
  late List<WebDiscoveryIllust> _items;
  late final List<String> _order;
  List<String> _rangeIllustIds = [];
  List<String> _rangeMangaIds = [];
  bool _rangeReady = false;
  bool _loadingNewer = false;
  bool _loadingOlder = false;
  late int _current;
  Drag? _outerHold;
  int? _dragOriginPage;

  @override
  void initState() {
    super.initState();
    _items = List<WebDiscoveryIllust>.of(widget.items);
    _order = List<String>.of(widget.artist?.orderIds ?? []);
    final offset = _hasNewer ? 1 : 0;
    _controller = PageController(initialPage: widget.initialIndex + offset);
    _pagePos = ValueNotifier<double>((widget.initialIndex + offset).toDouble());
    _controller.addListener(_syncPagePos);
    _current = widget.initialIndex + offset;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _precacheNeighbors(_current);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_syncPagePos);
    _endOuterHold();
    _pagePos.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _syncPagePos() {
    if (!_controller.hasClients) return;
    final page = _controller.page;
    if (page == null || page.isNaN) return;
    if ((_pagePos.value - page).abs() > 0.0001) _pagePos.value = page;
  }

  void _precacheNeighbors(int pagerIndex) {
    for (final next in [pagerIndex - 1, pagerIndex + 1]) {
      final item = _workAt(next);
      if (item == null) continue;
      final url = gridThumbUrl(item);
      if (url.isNotEmpty) {
        precacheImage(
          PxImageProvider(url, headers: imageHeaders, cacheManager: PxCache.instance.thumbs),
          context,
          onError: (error, stackTrace) {
            debugPrint('precache failed $url: $error');
          },
        );
      }
      Future.microtask(() {
        try {
          _prefetchNeighbor(item);
        } catch (e) {
          debugPrint('prefetch setup failed ${item.id}: $e');
        }
      });
    }
  }

  void _prefetchNeighbor(WebDiscoveryIllust item) {
    final detailFuture = ApiCache.instance.illustDetail(item.id);
    final pagesFuture = ApiCache.instance.illustPages(item.id);
    detailFuture.then((_) {}, onError: (e) {
      debugPrint('prefetch detail failed ${item.id}: $e');
    });
    pagesFuture.then((_) {}, onError: (e) {
      debugPrint('prefetch pages failed ${item.id}: $e');
    });
    if (item.illustType == 2) {
      ApiCache.instance.ugoiraMeta(item.id).then((meta) {
        final src = meta.body.originalSrc.isNotEmpty ? meta.body.originalSrc : meta.body.src;
        if (src.isEmpty) return;
        PxCache.instance.ugoira.getSingleFile(src, headers: pxImageHeaders).then((_) {}, onError: (e) {
          debugPrint('prefetch ugoira failed ${item.id}: $e');
        });
      }, onError: (e) {
        debugPrint('prefetch ugoira meta failed ${item.id}: $e');
      });
    }
    final neighborUserId = item.userId;
    if (neighborUserId != null && neighborUserId.isNotEmpty) {
      ApiCache.instance.userWorksAll(neighborUserId).then((_) {}, onError: (e) {
        debugPrint('prefetch works failed $neighborUserId: $e');
      });
    }
    WebSession.instance.client.related(item.id, limit: 18).then((r) {
      RelatedCache.put(item.id, r.body.illusts, r.body.nextIds);
    }, onError: (e) {
      debugPrint('prefetch related failed ${item.id}: $e');
    });
    Future.wait([detailFuture, pagesFuture]).then((results) {
      if (!mounted) return;
      if (_controller.hasClients && _controller.position.isScrollingNotifier.value) return;
      final pages = (results[1] as WebIllustPagesResponse).body;
      String fullUrl = '';
      if (pages.isNotEmpty) {
        final first = pages.first;
        fullUrl = first.urls.regular.isNotEmpty ? first.urls.regular : first.urls.original;
      } else {
        fullUrl = (results[0] as WebIllustDetailResponse).body.urls.regular;
      }
      if (fullUrl.isEmpty) return;
      precacheImage(
        PxImageProvider(fullUrl, headers: imageHeaders, cacheManager: PxCache.instance.fulls),
        context,
        onError: (error, stackTrace) {
          debugPrint('precache full failed $fullUrl: $error');
        },
      );
    }, onError: (_) {});
  }

  WebDiscoveryIllust _currentWork() {
    final work = _workAt(_current);
    if (work != null) return work;
    return _items.first;
  }

  void _openArtist() {
    final artist = widget.artist;
    final current = _currentWork();
    final userId = artist?.userId ?? current.userId;
    if (userId == null || userId.isEmpty) return;
    if (artist != null) {
      Navigator.of(context).maybePop();
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ArtistScreen(
          userId: userId,
          initialName: current.userName,
          initialAvatarUrl: current.profileImageUrl,
          initialOrderIds: artist?.orderIds != null && artist!.orderIds!.isNotEmpty
              ? List<String>.of(artist.orderIds!)
              : null,
        ),
      ),
    );
  }

  String _artistPosition(WebDiscoveryIllust current) {
    if (_order.isNotEmpty) {
      final global = _order.indexOf(current.id);
      if (global >= 0) return '${global + 1} / ${_order.length}';
    }
    final offset = _hasNewer ? 1 : 0;
    final wi = (_current - offset).clamp(0, _items.length - 1);
    return '${wi + 1} / ${_items.length}';
  }

  void _comingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SignalBuilder(
      builder: (context) {
        final reversed = WebSession.instance.reverseDetails.value;
        if (!reversed) {
          return Scaffold(
            appBar: _buildBar(context),
            body: Column(
              children: [
                _buildPostMinimap(),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) => _buildPager(constraints.maxHeight),
                  ),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          bottomNavigationBar: _buildBottomBar(),
          body: Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => _buildPager(constraints.maxHeight),
                ),
              ),
              _buildPostMinimap(),
            ],
          ),
        );
      },
    );
  }

  ({String avatarUrl, String authorName, String subtitle}) _barData() {
    final artist = widget.artist;
    final current = _currentWork();
    final authorName = artist?.name.isNotEmpty == true
        ? artist!.name
        : (current.userName ?? '');
    final avatarUrl = artist?.avatarUrl ?? current.profileImageUrl ?? '';
    final subtitle = artist != null
        ? _artistPosition(current)
        : current.title;
    return (avatarUrl: avatarUrl, authorName: authorName, subtitle: subtitle);
  }

  AppBar _buildBar(BuildContext context) {
    final data = _barData();
    return AppBar(
      titleSpacing: 0,
      title: _buildBarTitle(context, avatarUrl: data.avatarUrl, authorName: data.authorName, subtitle: data.subtitle),
      actions: _buildBarActions(),
    );
  }

  // Bottom bar for reverse mode. Deliberately NOT an AppBar widget: an
  // AppBar in Scaffold.bottomNavigationBar collapses the Scaffold body to
  // zero height (reproduced headless, both primary values), leaving a void
  // page under a lone bar. Same content, plain Material shell.
  Widget _buildBottomBar() {
    final data = _barData();
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surface,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: kToolbarHeight,
          child: Row(
            children: [
              const BackButton(),
              Expanded(
                child: _buildBarTitle(context,
                    avatarUrl: data.avatarUrl, authorName: data.authorName, subtitle: data.subtitle),
              ),
              ..._buildBarActions(),
            ],
          ),
        ),
      ),
    );
  }

  bool get _hasNewer =>
      _order.isNotEmpty && _items.isNotEmpty && _order.indexOf(_items.first.id) > 0;

  bool get _hasOlder {
    if (_order.isEmpty || _items.isEmpty) return false;
    final last = _order.indexOf(_items.last.id);
    return last >= 0 && last < _order.length - 1;
  }

  int get _newerRemaining {
    if (!_hasNewer) return 0;
    return _order.indexOf(_items.first.id);
  }

  int get _olderRemaining {
    if (!_hasOlder) return 0;
    return _order.length - 1 - _order.indexOf(_items.last.id);
  }

  int get _pageCount => _items.length + (_hasNewer ? 1 : 0) + (_hasOlder ? 1 : 0);

  WebDiscoveryIllust? _workAt(int page) {
    final wi = page - (_hasNewer ? 1 : 0);
    if (wi < 0 || wi >= _items.length) return null;
    return _items[wi];
  }

  Future<bool> _ensureRange() async {
    if (_rangeReady) return true;
    final artist = widget.artist;
    if (artist == null) return false;
    try {
      final all = (await ApiCache.instance.userWorksAll(artist.userId)).body;
      if (!mounted) return false;
      _rangeIllustIds = all.illustIds;
      _rangeMangaIds = all.mangaIds;
      _rangeReady = true;
      return true;
    } catch (e, stack) {
      debugPrint('detail range failed ${artist.userId}: $e\n$stack');
      return false;
    }
  }

  Future<Map<String, WebDiscoveryIllust>> _hydrateIds(Set<String> ids) async {
    final userId = widget.artist?.userId ?? '';
    final cached = ApiCache.instance.getCachedWorks(ids.toList());
    final missing = ids.where((id) => !cached.containsKey(id)).toSet();
    if (missing.isEmpty) return cached;
    final illustChunk = missing.where(_rangeIllustIds.contains).toList();
    final mangaChunk = missing.where(_rangeMangaIds.contains).toList();
    final hydrated = await Future.wait([
      illustChunk.isEmpty
          ? Future.value(WebUserProfileWorksResponse(false, body: WebUserProfileWorksBody()))
          : ApiCache.instance.userProfileWorks(userId, illustChunk),
      mangaChunk.isEmpty
          ? Future.value(WebUserProfileWorksResponse(false, body: WebUserProfileWorksBody()))
          : ApiCache.instance.userProfileWorks(userId, mangaChunk, workCategory: 'manga'),
    ]);
    return <String, WebDiscoveryIllust>{
      ...cached,
      ...(hydrated[0] as WebUserProfileWorksResponse).body.works,
      ...(hydrated[1] as WebUserProfileWorksResponse).body.works,
    };
  }

  Future<void> _growNewer() async {
    if (_loadingNewer || _loadingOlder || !_hasNewer) return;
    final firstIndex = _order.indexOf(_items.first.id);
    if (firstIndex <= 0) return;
    setState(() => _loadingNewer = true);
    try {
      if (!await _ensureRange()) {
        if (!mounted) return;
        setState(() => _loadingNewer = false);
        return;
      }
      final start = (firstIndex - 24).clamp(0, firstIndex);
      final ids = <String>{for (var i = start; i < firstIndex; i++) _order[i]};
      final byId = await _hydrateIds(ids);
      if (!mounted) return;
      final fresh = [for (var i = start; i < firstIndex; i++) if (byId[_order[i]] != null) byId[_order[i]]!];
      setState(() {
        _items = [...fresh, ..._items];
        _loadingNewer = false;
      });
    } catch (e, stack) {
      debugPrint('detail grow newer failed: $e\n$stack');
      if (!mounted) return;
      setState(() => _loadingNewer = false);
    }
  }

  Future<void> _growOlder() async {
    if (_loadingNewer || _loadingOlder || !_hasOlder) return;
    final lastIndex = _order.indexOf(_items.last.id);
    if (lastIndex < 0 || lastIndex >= _order.length - 1) return;
    setState(() => _loadingOlder = true);
    try {
      if (!await _ensureRange()) {
        if (!mounted) return;
        setState(() => _loadingOlder = false);
        return;
      }
      final end = (lastIndex + 25).clamp(lastIndex + 1, _order.length);
      final ids = <String>{for (var i = lastIndex + 1; i < end; i++) _order[i]};
      final byId = await _hydrateIds(ids);
      if (!mounted) return;
      final fresh = [for (var i = lastIndex + 1; i < end; i++) if (byId[_order[i]] != null) byId[_order[i]]!];
      setState(() {
        _items = [..._items, ...fresh];
        _loadingOlder = false;
      });
    } catch (e, stack) {
      debugPrint('detail grow older failed: $e\n$stack');
      if (!mounted) return;
      setState(() => _loadingOlder = false);
    }
  }

  Widget _buildPostMinimap() {
    if (_pageCount < 2) return const SizedBox.shrink();
    return PostMinimap(
      items: [
        if (_hasNewer)
          PostMinimapItem(
            thumbUrl: '',
            id: '__newer__',
            isLoadMore: true,
            loadCount: _newerRemaining,
            loadNewer: true,
          ),
        for (final item in _items)
          PostMinimapItem(
            thumbUrl: gridThumbUrl(item),
            id: item.id,
            pageCount: item.pageCount,
            isUgoira: item.illustType == 2,
            isR18: item.xRestrict == 1,
          ),
        if (_hasOlder)
          PostMinimapItem(
            thumbUrl: '',
            id: '__older__',
            isLoadMore: true,
            loadCount: _olderRemaining,
            loadNewer: false,
          ),
      ],
      currentIndex: _current,
      initialIndex: _current,
      onJump: _jumpToPost,
      visible: true,
      dragPosition: _pagePos,
    );
  }

  Future<void> _jumpToPost(int index) async {
    if (!_controller.hasClients) return;
    if (index < 0 || index >= _pageCount || index == _current) return;
    if ((index - _current).abs() <= 1) {
      _controller.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      final distance = (index - _current).abs();
      final duration = Duration(milliseconds: (250 + 60 * distance).clamp(0, 900));
      TraversalGuard.enter();
      try {
        await _controller.animateToPage(index, duration: duration, curve: Curves.easeOut);
      } finally {
        TraversalGuard.exit();
      }
    }
  }

  Widget _buildBarTitle(BuildContext context,
      {required String avatarUrl, required String authorName, required String subtitle}) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: _openArtist,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Row(
          spacing: 8,
          children: [
            ArtistAvatar(url: avatarUrl, radius: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    authorName.isNotEmpty ? authorName : 'Pixiv',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBarActions() {
    return [
      IconButton(
        icon: const Icon(Icons.favorite_border),
        tooltip: 'Favorite',
        onPressed: () => _comingSoon('Favoriting posts'),
      ),
      IconButton(
        icon: const Icon(Icons.person_add_outlined),
        tooltip: 'Follow artist',
        onPressed: () => _comingSoon('Following artists'),
      ),
    ];
  }

  void _onPageChanged(int index) {
    setState(() => _current = index);
    if (_workAt(index) == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _precacheNeighbors(index);
    });
  }

  Widget _buildPager(double pagerHeight) {
    return ExtendedPageView.builder(
        // Stays hittable mid-animation (framework PageView ignores pointer
        // while driven, which used to route inner grabs to the outer here).
        shouldIgnorePointerWhenScrolling: false,
        physics: const SnappyPagePhysics(),
        controller: _controller,
        itemCount: _pageCount,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          final work = _workAt(index);
          if (work == null) {
            final newer = _hasNewer && index == 0;
            return _LoadMorePage(
              key: ValueKey(newer ? '__newer__' : '__older__'),
              newer: newer,
              count: newer ? _newerRemaining : _olderRemaining,
              loading: newer ? _loadingNewer : _loadingOlder,
              onTap: newer ? _growNewer : _growOlder,
            );
          }
          return DetailPage(
            key: ValueKey(work.id),
            illust: work,
            onInnerDragStart: _onInnerDragStart,
            onInnerDragUpdate: _onInnerDragUpdate,
            onInnerDragEnd: _onInnerDragEnd,
            active: index == _current,
            preload: (index - _current).abs() == 1,
            artist: widget.artist,
            viewerMaxHeight: pagerHeight,
          );
        },
      );
  }

  // Nested-pager handoff, done with the framework instead of against it.
  //
  // jumpTo is the WRONG primitive here: it ends with goBallistic(null) and
  // PageScrollPhysics turns a zero-velocity ballistic into a spring back to
  // the nearest page — the outer visibly fights the thumb during holds.
  // Instead the outer position is put into a real held-drag activity while
  // the inner pushes past its edge: no spring while held, and on release the
  // framework's own page-snapping settles with the finger's velocity.
  //
  // The hold is created LAZILY on the first edge excess, not on drag start:
  // an eager hold would freeze an in-flight outer settle for the whole inner
  // drag even when the inner never reaches its edge.
  void _onInnerDragStart() {
    if (!mounted || !_controller.hasClients) return;
    _endOuterHold();
    _dragOriginPage = _controller.page?.round() ?? _current;
  }

  void _onInnerDragUpdate(double excess) {
    if (!_controller.hasClients || excess == 0) return;
    final hold = _outerHold ??=
        _controller.position.drag(DragStartDetails(), () {});
    // Positive overscroll = pushing past the inner trailing edge = moving
    // toward the next post. ScrollDragController consumes primaryDelta with
    // the pointer-motion sign (a forward push moves the finger in -x), so
    // the excess is negated to produce increasing outer pixels.
    hold.update(
      DragUpdateDetails(
        globalPosition: Offset.zero,
        delta: Offset(-excess, 0),
        primaryDelta: -excess,
      ),
    );
  }

  void _onInnerDragEnd(double velocity) {
    final hold = _outerHold;
    _outerHold = null;
    final origin = _dragOriginPage ?? _current;
    _dragOriginPage = null;
    if (hold == null || !_controller.hasClients) return;
    final position = _controller.position;
    final endVelocity = resolveEndVelocity(
      pixels: position.pixels,
      pageOrigin: origin * position.viewportDimension,
      viewport: position.viewportDimension,
      fingerVelocity: velocity,
    );
    hold.end(
      DragEndDetails(
        primaryVelocity: endVelocity,
        velocity: Velocity(pixelsPerSecond: Offset(endVelocity, 0)),
      ),
    );
  }

  void _endOuterHold() {
    final hold = _outerHold;
    _outerHold = null;
    hold?.cancel();
  }
}

class _LoadMorePage extends StatelessWidget {
  final bool newer;
  final int count;
  final bool loading;
  final VoidCallback onTap;

  const _LoadMorePage({
    super.key,
    required this.newer,
    required this.count,
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: InkWell(
        onTap: loading ? null : onTap,
        child: Center(
          child: loading
              ? const SizedBox(width: 28, height: 28, child: CircularProgressIndicator(strokeWidth: 3))
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(newer ? Icons.arrow_back : Icons.arrow_forward, size: 28),
                    const SizedBox(height: 8),
                    Text('+$count', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    Text(newer ? 'newer' : 'older', style: const TextStyle(fontSize: 13)),
                  ],
                ),
        ),
      ),
    );
  }
}
