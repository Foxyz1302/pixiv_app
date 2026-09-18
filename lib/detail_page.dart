import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:signals/signals_flutter.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'detail_screen.dart';
import 'artist_context.dart';
import 'artist_screen.dart';
import 'feed_screen.dart';
import 'api_cache.dart';
import 'px_cache.dart';
import 'ugoira_player.dart';
import 'web/pixiv_web_models.dart';
import 'web_session.dart';

double innerViewportHeight(List<double> heights, double pos) {
  if (heights.isEmpty) return 0;
  final maxIndex = heights.length - 1;
  final clamped = pos.clamp(0.0, maxIndex.toDouble());
  final lo = clamped.floor().clamp(0, maxIndex);
  final hi = clamped.ceil().clamp(0, maxIndex);
  final t = clamped - lo;
  if (lo == hi || t == 0) return heights[lo];
  return heights[lo] * (1 - t) + heights[hi] * t;
}

class SnappyPagePhysics extends PageScrollPhysics {
  const SnappyPagePhysics({super.parent});

  @override
  SnappyPagePhysics applyTo(ScrollPhysics? ancestor) {
    return SnappyPagePhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => SpringDescription.withDampingRatio(mass: 0.35, stiffness: 220.0, ratio: 1.15);
}

class DetailPage extends StatefulWidget {
  final WebDiscoveryIllust illust;
  final VoidCallback? onInnerDragStart;
  final ValueChanged<double>? onInnerDragUpdate;
  final ValueChanged<double>? onInnerDragEnd;
  final bool active;
  final bool preload;
  final ArtistContext? artist;

  const DetailPage({
    super.key,
    required this.illust,
    this.onInnerDragStart,
    this.onInnerDragUpdate,
    this.onInnerDragEnd,
    this.active = true,
    this.preload = false,
    this.artist,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with AutomaticKeepAliveClientMixin {
  WebIllustDetail? _detail;
  List<WebIllustPage> _pages = [];
  String? _failure;
  bool _loading = true;
  PageController? _innerController;
  int _innerIndex = 0;
  bool _dragging = false;
  bool _chromeVisible = true;
  final Map<String, double> _decodedAspect = {};
  final Set<String> _watching = {};
  final Map<String, int> _reloadTokens = {};
  List<WebDiscoveryIllust> _related = [];
  List<String> _relatedNext = [];
  bool _relatedLoading = false;
  String? _relatedFailure;
  WebUserFull? _author;
  List<WebDiscoveryIllust> _artistWorks = [];
  List<String> _artistOrder = [];
  int _artistIndex = -1;
  int _rangeLo = 0;
  int _rangeHi = 0;
  bool _artistLoading = false;
  bool _extending = false;
  bool _extendingOlder = false;
  String? _artistFailure;
  List<String> _rangeIllustIds = [];
  List<String> _rangeMangaIds = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _fetch();
    _fetchRelated();
  }

  @override
  void dispose() {
    if (_dragging) {
      _dragging = false;
      widget.onInnerDragEnd?.call(0);
    }
    _innerController?.dispose();
    super.dispose();
  }

  Future<void> _fetch() async {
    final id = widget.illust.id;
    try {
      final results = await Future.wait([ApiCache.instance.illustDetail(id), ApiCache.instance.illustPages(id)]);
      if (!mounted) return;
      setState(() {
        _detail = (results[0] as WebIllustDetailResponse).body;
        _pages = (results[1] as WebIllustPagesResponse).body;
        _loading = false;
        if (_pages.length > 1 && _innerController == null) {
          _innerController = PageController();
          _innerIndex = 0;
        } else if (_innerController != null) {
          if (_pages.length <= 1) {
            _innerController!.dispose();
            _innerController = null;
            _innerIndex = 0;
          } else if (_innerIndex >= _pages.length) {
            _innerIndex = _pages.length - 1;
            if (_innerController!.hasClients) {
              _innerController!.jumpToPage(_innerIndex);
            }
          }
        }
      });
      _precacheInnerPage(1);
      _fetchAuthor();
    } catch (e, stack) {
      debugPrint('detail failed $id: $e\n$stack');
      if (!mounted) return;
      setState(() {
        _failure = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _fetchAuthor() async {
    if (widget.artist != null) return;
    final userId = _detail?.userId ?? widget.illust.userId;
    if (userId == null || userId.isEmpty) return;
    if (_author != null || _artistLoading) return;
    setState(() {
      _artistLoading = true;
      _artistFailure = null;
    });
    try {
      final all = (await ApiCache.instance.userWorksAll(userId)).body;
      if (!mounted) return;
      final illustIds = all.illustIds;
      final mangaIds = all.mangaIds;
      final order = [...illustIds, ...mangaIds]..sort((a, b) => (int.tryParse(b) ?? -1).compareTo(int.tryParse(a) ?? -1));
      final currentId = widget.illust.id;
      final currentIndex = order.indexOf(currentId);
      final windowIds = <String>{};
      if (currentIndex >= 0) {
        for (var i = currentIndex - 1; i <= currentIndex + 1; i++) {
          if (i >= 0 && i < order.length) windowIds.add(order[i]);
        }
      }
      for (final id in order.take(12)) {
        windowIds.add(id);
      }
      _rangeIllustIds = illustIds;
      _rangeMangaIds = mangaIds;
      final byId = await _hydrateIds(userId, windowIds, illustIds, mangaIds);
      if (!mounted) return;
      setState(() {
        _artistOrder = order;
        _artistIndex = currentIndex;
        _artistWorks = [
          for (final id in order)
            if (byId[id] != null) byId[id]!,
        ];
        _artistLoading = false;
      });
      try {
        final author = (await ApiCache.instance.userFull(userId)).body;
        if (!mounted) return;
        setState(() => _author = author);
      } catch (e, stack) {
        debugPrint('author user failed $userId: $e\n$stack');
      }
    } catch (e, stack) {
      debugPrint('author failed $userId: $e\n$stack');
      if (!mounted) return;
      setState(() {
        _artistLoading = false;
        _artistFailure = e.toString();
      });
    }
  }

  Future<Map<String, WebDiscoveryIllust>> _hydrateIds(String userId, Set<String> ids, List<String> illustIds, List<String> mangaIds) async {
    final windowIllustIds = ids.where(illustIds.contains).toList();
    final windowMangaIds = ids.where(mangaIds.contains).toList();
    final hydrated = await Future.wait([
      windowIllustIds.isEmpty
          ? Future.value(WebUserProfileWorksResponse(false, body: WebUserProfileWorksBody()))
          : ApiCache.instance.userProfileWorks(userId, windowIllustIds),
      windowMangaIds.isEmpty
          ? Future.value(WebUserProfileWorksResponse(false, body: WebUserProfileWorksBody()))
          : ApiCache.instance.userProfileWorks(userId, windowMangaIds, workCategory: 'manga'),
    ]);
    return <String, WebDiscoveryIllust>{
      ...(hydrated[0] as WebUserProfileWorksResponse).body.works,
      ...(hydrated[1] as WebUserProfileWorksResponse).body.works,
    };
  }

  void _mergeWorks(Map<String, WebDiscoveryIllust> byId) {
    final seen = {for (final w in _artistWorks) w.id};
    final merged = [
      for (final id in _artistOrder)
        if (byId[id] != null || seen.contains(id)) byId[id] ?? _artistWorks.firstWhere((w) => w.id == id),
    ];
    setState(() => _artistWorks = merged);
  }

  int get _hydratedLo {
    var lo = _artistOrder.length;
    for (final w in _artistWorks) {
      final i = _artistOrder.indexOf(w.id);
      if (i >= 0 && i < lo) lo = i;
    }
    return lo;
  }

  int get _hydratedHi {
    var hi = -1;
    for (final w in _artistWorks) {
      final i = _artistOrder.indexOf(w.id);
      if (i > hi) hi = i;
    }
    return hi;
  }

  Future<void> _extendStrip({required bool older}) async {
    if (_extending || _artistOrder.isEmpty) return;
    final userId = _detail?.userId ?? widget.illust.userId;
    if (userId == null || userId.isEmpty) return;
    final lo = _hydratedLo;
    final hi = _hydratedHi;
    final ids = <String>{};
    if (older) {
      for (var i = hi + 1; i < hi + 25 && i < _artistOrder.length; i++) {
        ids.add(_artistOrder[i]);
      }
    } else {
      for (var i = lo - 24; i < lo; i++) {
        if (i >= 0) ids.add(_artistOrder[i]);
      }
    }
    if (ids.isEmpty) return;
    setState(() {
      _extending = true;
      _extendingOlder = older;
    });
    try {
      final byId = await _hydrateIds(userId, ids, _rangeIllustIds, _rangeMangaIds);
      if (!mounted) return;
      final merged = <String, WebDiscoveryIllust>{for (final w in _artistWorks) w.id: w, ...byId};
      setState(() {
        _extending = false;
        _extendingOlder = false;
      });
      _mergeWorks(merged);
    } catch (e, stack) {
      debugPrint('strip extend failed $userId: $e\n$stack');
      if (!mounted) return;
      setState(() {
        _extending = false;
        _extendingOlder = false;
      });
    }
  }

  void _openArtist() {
    final userId = _detail?.userId ?? widget.illust.userId;
    if (userId == null || userId.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ArtistScreen(
          userId: userId,
          initialName: _author?.name ?? _detail?.userName ?? widget.illust.userName,
          initialAvatarUrl: _authorAvatar() ?? widget.illust.profileImageUrl,
        ),
      ),
    );
  }

  String? _authorAvatar() {
    final author = _author;
    if (author == null) return null;
    if (author.imageBig.isNotEmpty) return author.imageBig;
    if (author.image.isNotEmpty) return author.image;
    return null;
  }

  ArtistContext? _stripContext() {
    final userId = _detail?.userId ?? widget.illust.userId;
    if (userId == null || userId.isEmpty) return null;
    return ArtistContext(
      userId: userId,
      name: _author?.name ?? _detail?.userName ?? widget.illust.userName ?? '',
      avatarUrl: _authorAvatar() ?? widget.illust.profileImageUrl ?? '',
      orderIds: _artistOrder.isNotEmpty ? List<String>.of(_artistOrder) : null,
    );
  }

  void _openArtistWork(int index) {
    final items = List<WebDiscoveryIllust>.of(_artistWorks);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetailScreen(items: items, initialIndex: index, artist: _stripContext()),
      ),
    );
  }

  Future<void> _openNeighbour(int delta) async {
    if (_artistIndex < 0 || _artistOrder.isEmpty) return;
    final target = _artistIndex + delta;
    if (target < 0 || target >= _artistOrder.length) return;
    final targetId = _artistOrder[target];
    final hydratedIndex = _artistWorks.indexWhere((w) => w.id == targetId);
    if (hydratedIndex >= 0) {
      _openArtistWork(hydratedIndex);
      return;
    }
    final userId = _detail?.userId ?? widget.illust.userId;
    if (userId == null || userId.isEmpty || _extending) return;
    setState(() {
      _extending = true;
      _extendingOlder = false;
    });
    try {
      final byId = await _hydrateIds(userId, {targetId}, _rangeIllustIds, _rangeMangaIds);
      if (!mounted) return;
      setState(() => _extending = false);
      final work = byId[targetId];
      if (work == null) return;
      _mergeWorks({for (final w in _artistWorks) w.id: w, ...byId});
      final index = _artistWorks.indexWhere((w) => w.id == targetId);
      if (index >= 0) _openArtistWork(index);
    } catch (e, stack) {
      debugPrint('neighbour hydrate failed $targetId: $e\n$stack');
      if (!mounted) return;
      setState(() => _extending = false);
    }
  }

  Future<void> _fetchRelated({bool more = false}) async {
    if (_relatedLoading) return;
    if (more && _relatedNext.isEmpty) return;
    setState(() {
      _relatedLoading = true;
      _relatedFailure = null;
    });
    try {
      final response = await WebSession.instance.client.related(widget.illust.id, limit: 18, nextIds: more ? _relatedNext : null);
      if (!mounted) return;
      setState(() {
        _related = more ? [..._related, ...response.body.illusts] : response.body.illusts;
        _relatedNext = response.body.nextIds;
        _relatedLoading = false;
      });
    } catch (e, stack) {
      debugPrint('related failed ${widget.illust.id}: $e\n$stack');
      if (!mounted) return;
      setState(() {
        _relatedLoading = false;
        _relatedFailure = e.toString();
      });
    }
  }

  void _precacheInnerPage(int index) {
    if (_pages.isEmpty || index < 0 || index >= _pages.length) return;
    final page = _pages[index];
    final url = page.urls.regular.isNotEmpty ? page.urls.regular : page.urls.original;
    if (url.isEmpty) return;
    precacheImage(
      PxImageProvider(url, headers: imageHeaders),
      context,
      onError: (error, stackTrace) {
        debugPrint('precache inner failed $url: $error');
      },
    );
  }

  void _onInnerPageChanged(int index) {
    setState(() => _innerIndex = index);
    _precacheInnerPage(index + 1);
  }

  void _toggleChrome() {
    setState(() => _chromeVisible = !_chromeVisible);
  }

  List<({String url, int width, int height})> _pageImages(WebDiscoveryIllust illust, WebIllustDetail? detail) {
    if (_pages.isNotEmpty) {
      return [
        for (final page in _pages)
          (url: page.urls.regular.isNotEmpty ? page.urls.regular : page.urls.original, width: page.width, height: page.height),
      ];
    }
    var url = gridThumbUrl(illust);
    if (detail != null && detail.urls.regular.isNotEmpty) {
      url = detail.urls.regular;
    }
    return [(url: url, width: detail?.width ?? illust.width, height: detail?.height ?? illust.height)];
  }

  double _aspectFor(String url, int width, int height) {
    if (width > 0 && height > 0) return width / height;
    final decoded = _decodedAspect[url];
    if (decoded != null && decoded > 0) return decoded;
    if (url.isNotEmpty && !_watching.contains(url)) {
      _watching.add(url);
      final provider = PxImageProvider(url, headers: imageHeaders);
      final stream = provider.resolve(createLocalImageConfiguration(context));
      ImageStreamListener? listener;
      listener = ImageStreamListener(
        (info, _) {
          stream.removeListener(listener!);
          _watching.remove(url);
          if (!mounted) return;
          if (info.image.width > 0 && info.image.height > 0) {
            setState(() {
              _decodedAspect[url] = info.image.width / info.image.height;
            });
          }
        },
        onError: (error, stackTrace) {
          stream.removeListener(listener!);
          _watching.remove(url);
          debugPrint('detail size probe failed ${widget.illust.id}: $error');
        },
      );
      stream.addListener(listener);
    }
    return 1;
  }

  Widget _stillImage(String url, {BoxFit fit = BoxFit.cover, Alignment alignment = Alignment.topCenter}) {
    if (url.isEmpty) return const Icon(Icons.broken_image);
    final token = _reloadTokens[url] ?? 0;
    return GestureDetector(
      onTap: _toggleChrome,
      child: Image(
        image: PxImageProvider(url, headers: imageHeaders, reloadToken: token),
        fit: fit,
        alignment: alignment,
        gaplessPlayback: true,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          final expected = progress.expectedTotalBytes;
          final value = expected != null && expected > 0 ? progress.cumulativeBytesLoaded / expected : null;
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 28, height: 28, child: CircularProgressIndicator(value: value, strokeWidth: 3)),
                if (value != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text('${(value * 100).round()}%', style: const TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          debugPrint('detail image failed ${widget.illust.id}: $error');
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.broken_image),
                TextButton(onPressed: () => setState(() => _reloadTokens[url] = token + 1), child: const Text('Retry')),
              ],
            ),
          );
        },
      ),
    );
  }

  double? _viewerCap(BuildContext context) {
    final viewport = MediaQuery.sizeOf(context);
    if (viewport.width <= viewport.height) return null;
    final cap = viewport.height - kToolbarHeight - 16;
    return cap > 200 ? cap : null;
  }

  double? _cappedHeight(double aspect, double viewWidth, double? cap) {
    if (cap == null || aspect <= 0) return null;
    return viewWidth / aspect > cap ? cap : null;
  }

  Widget _multiViewer(List<({String url, int width, int height})> pages) {
    final controller = _innerController!;
    final desktop =
        !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.linux ||
            defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.macOS);
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
        final cap = _viewerCap(context);
        final heights = <double>[];
        final contained = <bool>[];
        for (final page in pages) {
          final aspect = _aspectFor(page.url, page.width, page.height);
          final capped = _cappedHeight(aspect, viewWidth, cap);
          heights.add(capped ?? viewWidth / (aspect <= 0 ? 1 : aspect));
          contained.add(capped != null);
        }
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            var pos = _innerIndex.clamp(0, pages.length - 1).toDouble();
            final raw = controller.hasClients ? controller.page : null;
            if (raw != null && !raw.isNaN) pos = raw;
            final height = innerViewportHeight(heights, pos);
            final showArrows = desktop && _chromeVisible;
            return SizedBox(
              width: double.infinity,
              height: height,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollStartNotification) {
                        _dragging = true;
                        widget.onInnerDragStart?.call();
                      } else if (notification is OverscrollNotification && notification.dragDetails != null) {
                        widget.onInnerDragUpdate?.call(notification.overscroll);
                      } else if (notification is ScrollEndNotification) {
                        if (_dragging) {
                          _dragging = false;
                          widget.onInnerDragEnd?.call(notification.dragDetails?.primaryVelocity ?? 0);
                        }
                      }
                      return false;
                    },
                    child: ExtendedPageView.builder(
                      // Same reason as the outer pager in detail_screen.dart:
                      // grabs mid-animation must stay on this pager.
                      shouldIgnorePointerWhenScrolling: false,
                      physics: const SnappyPagePhysics(),
                      controller: controller,
                      itemCount: pages.length,
                      onPageChanged: _onInnerPageChanged,
                      itemBuilder: (context, index) => OverflowBox(
                        maxWidth: viewWidth,
                        maxHeight: double.infinity,
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: viewWidth,
                          height: heights[index],
                          child: contained[index]
                              ? _stillImage(pages[index].url, fit: BoxFit.contain, alignment: Alignment.center)
                              : _stillImage(pages[index].url),
                        ),
                      ),
                    ),
                  ),
                  if (showArrows && _innerIndex > 0)
                    Positioned(
                      left: 4,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: _NavChevron(
                          icon: Icons.chevron_left,
                          onTap: () => controller.previousPage(duration: const Duration(milliseconds: 250), curve: Curves.easeOut),
                        ),
                      ),
                    ),
                  if (showArrows && _innerIndex < pages.length - 1)
                    Positioned(
                      right: 4,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: _NavChevron(
                          icon: Icons.chevron_right,
                          onTap: () => controller.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeOut),
                        ),
                      ),
                    ),
                  if (_chromeVisible && pages.length <= 20)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 8,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (var i = 0; i < pages.length; i++)
                                GestureDetector(
                                  onTap: () =>
                                      controller.animateToPage(i, duration: const Duration(milliseconds: 250), curve: Curves.easeOut),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 3),
                                    child: Icon(Icons.circle, size: 8, color: i == _innerIndex ? Colors.white : Colors.white38),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (_chromeVisible) Positioned(bottom: 8, right: 8, child: TileBadge('${_innerIndex + 1} / ${pages.length}')),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final illust = widget.illust;
    final detail = _detail;
    final title = detail?.title ?? illust.title;
    final tagViews = detail != null
        ? [
            for (final t in detail.tags.tags)
              (
                tag: t.tag,
                translated:
                    t.translation?['en'] ??
                    (t.translation != null && t.translation!.values.isNotEmpty ? t.translation!.values.first : null),
              ),
          ]
        : [for (final t in illust.tags) (tag: t, translated: null as String?)];
    final isUgoira = (detail?.illustType ?? illust.illustType) == 2;
    final viewWidth = MediaQuery.sizeOf(context).width;
    final cap = _viewerCap(context);
    final Widget viewer;
    if (_loading) {
      viewer = const AspectRatio(aspectRatio: 1, child: Center(child: CircularProgressIndicator()));
    } else if (_failure != null) {
      viewer = AspectRatio(
        aspectRatio: 1,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Text(_failure ?? 'No image'),
              FilledButton(
                onPressed: () {
                  setState(() {
                    _loading = true;
                    _failure = null;
                  });
                  _fetch();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    } else if (isUgoira) {
      final pages = _pageImages(illust, detail);
      final first = pages.first;
      final imageUrl = first.url.isNotEmpty ? first.url : gridThumbUrl(illust);
      final aspect = _aspectFor(imageUrl, detail?.width ?? illust.width, detail?.height ?? illust.height);
      final capped = _cappedHeight(aspect, viewWidth, cap);
      final player = UgoiraPlayer(illustId: illust.id, posterUrl: imageUrl, active: widget.active, preload: widget.preload);
      viewer = capped != null
          ? SizedBox(width: double.infinity, height: capped, child: player)
          : AspectRatio(aspectRatio: aspect, child: player);
    } else {
      final pages = _pageImages(illust, detail);
      if (pages.length > 1 && _innerController != null) {
        viewer = _multiViewer(pages);
      } else {
        final single = pages.first;
        final aspect = _aspectFor(single.url, single.width, single.height);
        final capped = _cappedHeight(aspect, viewWidth, cap);
        viewer = capped != null
            ? SizedBox(
                width: double.infinity,
                height: capped,
                child: _stillImage(single.url, fit: BoxFit.contain, alignment: Alignment.center),
              )
            : AspectRatio(
                aspectRatio: aspect,
                child: Stack(fit: StackFit.expand, children: [_stillImage(single.url)]),
              );
      }
    }
    final infoChildren = [
      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      if (tagViews.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Wrap(
            spacing: 10,
            runSpacing: 6,
            children: [
              for (final t in tagViews)
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '#${t.tag}',
                        style: const TextStyle(color: Colors.blue, fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      if (t.translated != null && t.translated!.isNotEmpty)
                        TextSpan(
                          text: ' ${t.translated!}',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
    ];
    return SignalBuilder(
      builder: (context) {
        final reversed = WebSession.instance.reverseDetails.value;
        final info = Padding(
          padding: const EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: reversed ? infoChildren.reversed.toList() : infoChildren),
        );
        if (!reversed) {
          return ListView(
            children: [
              _ViewerKeepAlive(child: viewer),
              info,
              _artistStrip(),
              _relatedSection(false),
            ],
          );
        }
        return ListView(
          reverse: true,
          children: [
            _ViewerKeepAlive(child: viewer),
            info,
            _artistStrip(),
            _relatedSection(true),
          ],
        );
      },
    );
  }

  // The strip keeps its top-down order in both modes: it is short enough
  // that reversing it buys nothing.
  Widget _artistStrip() {
    if (widget.artist != null) return const SizedBox.shrink();
    if (_artistLoading && _artistWorks.isEmpty) {
      return const Padding(
        padding: EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: Center(
          child: Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator()),
        ),
      );
    }
    if (_artistWorks.isEmpty) {
      if (_artistFailure != null) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
          child: Row(
            children: [
              Expanded(
                child: Text('Artist works failed to load', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.error)),
              ),
              TextButton(onPressed: _fetchAuthor, child: const Text('Retry')),
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    }
    final prevId = _artistIndex > 0 ? _artistOrder[_artistIndex - 1] : null;
    final nextId = _artistIndex >= 0 && _artistIndex + 1 < _artistOrder.length ? _artistOrder[_artistIndex + 1] : null;
    final header = Row(
      children: [
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: _openArtist,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text('More from this artist', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
          ),
        ),
        if (prevId != null) TextButton(onPressed: _extending ? null : () => _openNeighbour(-1), child: const Text('‹ Prev')),
        if (nextId != null) TextButton(onPressed: _extending ? null : () => _openNeighbour(1), child: const Text('Next ›')),
      ],
    );
    final lo = _hydratedLo;
    final hi = _hydratedHi;
    final newerLeft = lo;
    final olderLeft = _artistOrder.length - 1 - hi;
    final hasNewer = newerLeft > 0;
    final hasOlder = olderLeft > 0;
    final thumbs = SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _artistWorks.length + (hasNewer ? 1 : 0) + (hasOlder ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(width: 6),
        itemBuilder: (context, index) {
          if (hasNewer && index == 0) {
            return _stripMoreCell(newer: true, count: newerLeft);
          }
          final workIndex = index - (hasNewer ? 1 : 0);
          if (workIndex < 0 || workIndex >= _artistWorks.length) {
            return _stripMoreCell(newer: false, count: olderLeft);
          }
          final work = _artistWorks[workIndex];
          final selected = work.id == widget.illust.id;
          final url = gridThumbUrl(work);
          return GestureDetector(
            onTap: selected ? null : () => _openArtistWork(workIndex),
            child: Container(
              width: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: selected ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2) : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (url.isEmpty)
                      const ColoredBox(color: Colors.black12, child: Icon(Icons.broken_image))
                    else
                      Image(
                        image: PxImageProvider(url, headers: imageHeaders, cacheManager: PxCache.instance.thumbs),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const ColoredBox(color: Colors.black12, child: Icon(Icons.broken_image)),
                      ),
                    if (work.illustType == 2)
                      const Positioned(top: 4, left: 4, child: TileBadge('UGOIRA'))
                    else if (work.pageCount > 1)
                      Positioned(top: 4, right: 4, child: TileBadge('${work.pageCount}')),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 4, children: [header, thumbs]),
    );
  }

  Widget _stripMoreCell({required bool newer, required int count}) {
    final loading = _extending && _extendingOlder == !newer;
    return SizedBox(
      width: 96,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Material(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: InkWell(
            onTap: _extending ? null : () => _extendStrip(older: !newer),
            child: Center(
              child: loading
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(newer ? Icons.arrow_back : Icons.arrow_forward, size: 20),
                        const SizedBox(height: 2),
                        Text('+$count', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        Text(newer ? 'newer' : 'older', style: const TextStyle(fontSize: 11)),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void _openRelated(int index) {
    final items = List<WebDiscoveryIllust>.of(_related);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetailScreen(items: items, initialIndex: index),
      ),
    );
  }

  Widget _relatedSection(bool reversed) {
    const header = Center(
      child: Text('Related', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
    );
    final Widget content;
    if (_related.isEmpty && _relatedLoading) {
      content = const Center(
        child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()),
      );
    } else if (_related.isEmpty && _relatedFailure != null) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Text(_relatedFailure!),
            FilledButton(onPressed: _retryRelated, child: const Text('Retry')),
          ],
        ),
      );
    } else if (_related.isEmpty) {
      content = const Text('No related works');
    } else {
      content = WaterfallFlow.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        reverse: reversed,
        gridDelegate: const SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 160,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: _related.length,
        itemBuilder: (context, index) {
          // No index flip here: builder positions must stay stable across
          // Load-more appends, or every visible tile re-maps and the grid
          // visibly reshuffles under the finger. Appends land at the top
          // builders, right under the button, and existing tiles keep
          // their offsets. Most-relevant stays nearest the title below.
          return FeedTile(illust: _related[index], onTap: () => _openRelated(index));
        },
      );
    }
    final Widget footer;
    if (_related.isNotEmpty && _relatedFailure != null) {
      footer = Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Text(_relatedFailure!),
              OutlinedButton(onPressed: _retryMoreRelated, child: const Text('Retry')),
            ],
          ),
        ),
      );
    } else if (_relatedLoading && _related.isNotEmpty) {
      footer = const Padding(
        padding: EdgeInsets.only(top: 12),
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (_related.isNotEmpty && _relatedNext.isNotEmpty) {
      footer = Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Center(
          child: OutlinedButton(onPressed: _loadMoreRelated, child: const Text('Load more')),
        ),
      );
    } else {
      footer = const SizedBox.shrink();
    }
    final scheme = Theme.of(context).colorScheme;
    final zoneColor = Theme.of(context).brightness == Brightness.dark ? scheme.surfaceContainerHigh : scheme.surfaceContainerLow;
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 16),
      child: Container(
        decoration: BoxDecoration(color: zoneColor, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // Reverse mode reads bottom-up: title first at the entry,
            // then the grid, then the action at the far end where the
            // scroll — and the appended items — end up.
            children: reversed
                ? [
                    if (footer is! SizedBox) footer,
                    content,
                    const SizedBox(height: 8),
                    header,
                  ]
                : [header, const SizedBox(height: 8), content, footer],
          ),
        ),
      ),
    );
  }

  void _retryRelated() => _fetchRelated();

  void _retryMoreRelated() => _fetchRelated(more: true);

  void _loadMoreRelated() => _fetchRelated(more: true);
}

/// Keeps the viewer subtree (image/ugoira player state) alive when it
/// scrolls out of the inner ListView viewport. A bare [KeepAlive] widget
/// CANNOT be used here: ListView's child delegate wraps each child in a
/// RepaintBoundary, which breaks KeepAlive's parent-data contract (crash).
/// The mixin talks to the delegate's own keepalive machinery instead.
class _ViewerKeepAlive extends StatefulWidget {
  final Widget child;

  const _ViewerKeepAlive({required this.child});

  @override
  State<_ViewerKeepAlive> createState() => _ViewerKeepAliveState();
}

class _ViewerKeepAliveState extends State<_ViewerKeepAlive> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

class _NavChevron extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavChevron({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onTap,
      ),
    );
  }
}
