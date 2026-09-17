import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'detail_screen.dart';
import 'artist_context.dart';
import 'artist_screen.dart';
import 'feed_screen.dart';
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
  final ValueChanged<int>? onInnerEdge;
  final bool active;
  final bool preload;
  final ArtistContext? artist;

  const DetailPage({super.key, required this.illust, this.onInnerEdge, this.active = true, this.preload = false, this.artist});

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
  int _edgeDir = 0;
  bool _chromeVisible = true;
  final Map<String, double> _decodedAspect = {};
  final Set<String> _watching = {};
  List<WebDiscoveryIllust> _related = [];
  List<String> _relatedNext = [];
  bool _relatedLoading = false;
  String? _relatedFailure;
  WebUserFull? _author;
  List<WebDiscoveryIllust> _artistWorks = [];
  List<String> _artistOrder = [];
  int _artistIndex = -1;
  bool _artistLoading = false;
  String? _artistFailure;

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
    _innerController?.dispose();
    super.dispose();
  }

  Future<void> _fetch() async {
    final id = widget.illust.id;
    try {
      final results = await Future.wait([WebSession.instance.client.illustDetail(id), WebSession.instance.client.illustPages(id)]);
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
      final all = (await WebSession.instance.client.userWorksAll(userId)).body;
      if (!mounted) return;
      final illustIds = all.illustIds;
      final mangaIds = all.mangaIds;
      final order = [...illustIds, ...mangaIds]
        ..sort((a, b) => (int.tryParse(b) ?? -1).compareTo(int.tryParse(a) ?? -1));
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
      final windowIllustIds = windowIds.where(illustIds.contains).toList();
      final windowMangaIds = windowIds.where(mangaIds.contains).toList();
      final hydrated = await Future.wait([
        windowIllustIds.isEmpty
            ? Future.value(WebUserProfileWorksResponse(false, body: WebUserProfileWorksBody()))
            : WebSession.instance.client.userProfileWorks(userId, windowIllustIds),
        windowMangaIds.isEmpty
            ? Future.value(WebUserProfileWorksResponse(false, body: WebUserProfileWorksBody()))
            : WebSession.instance.client.userProfileWorks(userId, windowMangaIds, workCategory: 'manga'),
      ]);
      if (!mounted) return;
      final byId = <String, WebDiscoveryIllust>{
        ...(hydrated[0] as WebUserProfileWorksResponse).body.works,
        ...(hydrated[1] as WebUserProfileWorksResponse).body.works,
      };
      setState(() {
        _artistOrder = order;
        _artistIndex = currentIndex;
        _artistWorks = [for (final id in order) if (byId[id] != null) byId[id]!];
        _artistLoading = false;
      });
      try {
        final author = (await WebSession.instance.client.userFull(userId)).body;
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

  void _openNeighbour(int delta) {
    if (_artistIndex < 0 || _artistOrder.isEmpty) return;
    final target = _artistIndex + delta;
    if (target < 0 || target >= _artistOrder.length) return;
    final targetId = _artistOrder[target];
    final hydratedIndex = _artistWorks.indexWhere((w) => w.id == targetId);
    if (hydratedIndex >= 0) {
      _openArtistWork(hydratedIndex);
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
      NetworkImage(url, headers: imageHeaders),
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
      final provider = NetworkImage(url, headers: imageHeaders);
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
    return GestureDetector(
      onTap: _toggleChrome,
      child: Image(
        image: NetworkImage(url, headers: imageHeaders),
        fit: fit,
        alignment: alignment,
        gaplessPlayback: true,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          final expected = progress.expectedTotalBytes;
          final value = expected != null && expected > 0 ? progress.cumulativeBytesLoaded / expected : null;
          return Center(
            child: SizedBox(width: 28, height: 28, child: CircularProgressIndicator(value: value, strokeWidth: 3)),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          debugPrint('detail image failed ${widget.illust.id}: $error');
          return const Icon(Icons.broken_image);
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
        final viewWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width;
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
                        _edgeDir = 0;
                      } else if (notification is OverscrollNotification && notification.dragDetails != null) {
                        _edgeDir = notification.overscroll.sign.toInt();
                      } else if (notification is ScrollEndNotification && _edgeDir != 0) {
                        final direction = _edgeDir;
                        _edgeDir = 0;
                        widget.onInnerEdge?.call(direction);
                      }
                      return false;
                    },
                    child: PageView.builder(
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
                              ? _stillImage(
                                  pages[index].url,
                                  fit: BoxFit.contain,
                                  alignment: Alignment.center,
                                )
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
                          onTap: () => controller.previousPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          ),
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
                          onTap: () => controller.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          ),
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
                                  onTap: () => controller.animateToPage(
                                    i,
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeOut,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 3),
                                    child: Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: i == _innerIndex ? Colors.white : Colors.white38,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (_chromeVisible)
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: TileBadge('${_innerIndex + 1} / ${pages.length}'),
                    ),
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
            children: [
              Text(_failure ?? 'No image'),
              const SizedBox(height: 8),
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
    return ListView(
      children: [
        viewer,
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
            ],
          ),
        ),
        _artistStrip(),
        _relatedSection(),
      ],
    );
  }

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
                child: Text(
                  'Artist works failed to load',
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.error),
                ),
              ),
              TextButton(onPressed: _fetchAuthor, child: const Text('Retry')),
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    }
    final prevId = _artistIndex > 0 ? _artistOrder[_artistIndex - 1] : null;
    final nextId =
        _artistIndex >= 0 && _artistIndex + 1 < _artistOrder.length ? _artistOrder[_artistIndex + 1] : null;
    final prevHydrated = prevId != null && _artistWorks.any((w) => w.id == prevId);
    final nextHydrated = nextId != null && _artistWorks.any((w) => w.id == nextId);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: _openArtist,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text('More from this artist',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
              if (prevId != null)
                TextButton(
                  onPressed: prevHydrated ? () => _openNeighbour(-1) : null,
                  child: const Text('‹ Prev'),
                ),
              if (nextId != null)
                TextButton(
                  onPressed: nextHydrated ? () => _openNeighbour(1) : null,
                  child: const Text('Next ›'),
                ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 96,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _artistWorks.length,
              separatorBuilder: (_, _) => const SizedBox(width: 6),
              itemBuilder: (context, index) {
                final work = _artistWorks[index];
                final selected = work.id == widget.illust.id;
                final url = gridThumbUrl(work);
                return GestureDetector(
                  onTap: selected ? null : () => _openArtistWork(index),
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
                              image: NetworkImage(url, headers: imageHeaders),
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
          ),
        ],
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

  Widget _relatedSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Related', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          if (_related.isEmpty && _relatedLoading)
            const Center(
              child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()),
            )
          else if (_related.isEmpty && _relatedFailure != null)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_relatedFailure!),
                  const SizedBox(height: 8),
                  FilledButton(onPressed: _retryRelated, child: const Text('Retry')),
                ],
              ),
            )
          else if (_related.isEmpty)
            const Text('No related works')
          else
            WaterfallFlow.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 160,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: _related.length,
              itemBuilder: (context, index) => FeedTile(illust: _related[index], onTap: () => _openRelated(index)),
            ),
          if (_related.isNotEmpty && _relatedFailure != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_relatedFailure!),
                    const SizedBox(height: 8),
                    OutlinedButton(onPressed: _retryMoreRelated, child: const Text('Retry')),
                  ],
                ),
              ),
            )
          else if (_relatedLoading && _related.isNotEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_related.isNotEmpty && _relatedNext.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(
                child: OutlinedButton(onPressed: _loadMoreRelated, child: const Text('Load more')),
              ),
            ),
        ],
      ),
    );
  }

  void _retryRelated() => _fetchRelated();

  void _retryMoreRelated() => _fetchRelated(more: true);

  void _loadMoreRelated() => _fetchRelated(more: true);
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
