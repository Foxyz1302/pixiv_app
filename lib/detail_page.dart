import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'detail_screen.dart';
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

  const DetailPage({super.key, required this.illust, this.onInnerEdge, this.active = true, this.preload = false});

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
    } catch (e, stack) {
      debugPrint('detail failed $id: $e\n$stack');
      if (!mounted) return;
      setState(() {
        _failure = e.toString();
        _loading = false;
      });
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
    var url = thumbUrl(illust);
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

  Widget _stillImage(String url) {
    if (url.isEmpty) return const Icon(Icons.broken_image);
    return GestureDetector(
      onTap: _toggleChrome,
      child: Image(
        image: NetworkImage(url, headers: imageHeaders),
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
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
        final heights = <double>[];
        for (final page in pages) {
          final aspect = _aspectFor(page.url, page.width, page.height);
          heights.add(viewWidth / (aspect <= 0 ? 1 : aspect));
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
                          child: _stillImage(pages[index].url),
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
    final author = detail?.userName ?? illust.userName ?? '';
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
      final imageUrl = first.url.isNotEmpty ? first.url : thumbUrl(illust);
      viewer = AspectRatio(
        aspectRatio: _aspectFor(imageUrl, detail?.width ?? illust.width, detail?.height ?? illust.height),
        child: UgoiraPlayer(illustId: illust.id, posterUrl: imageUrl, active: widget.active, preload: widget.preload),
      );
    } else {
      final pages = _pageImages(illust, detail);
      if (pages.length > 1 && _innerController != null) {
        viewer = _multiViewer(pages);
      } else {
        final single = pages.first;
        viewer = AspectRatio(
          aspectRatio: _aspectFor(single.url, single.width, single.height),
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
              if (author.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 4), child: Text(author)),
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
        _relatedSection(),
      ],
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
