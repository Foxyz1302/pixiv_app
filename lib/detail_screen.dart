import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'api_cache.dart';
import 'artist_context.dart';
import 'artist_screen.dart';
import 'detail_page.dart';
import 'feed_screen.dart';
import 'px_cache.dart';
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
  late int _current;
  Drag? _outerHold;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialIndex);
    _current = widget.initialIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _precacheNeighbors(widget.initialIndex);
    });
  }

  @override
  void dispose() {
    _endOuterHold();
    _controller.dispose();
    super.dispose();
  }

  void _precacheNeighbors(int index) {
    for (final next in [index - 1, index + 1]) {
      if (next < 0 || next >= widget.items.length) continue;
      final item = widget.items[next];
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
      ApiCache.instance.illustDetail(item.id).then((_) {}, onError: (e) {
        debugPrint('prefetch detail failed ${item.id}: $e');
      });
      ApiCache.instance.illustPages(item.id).then((_) {}, onError: (e) {
        debugPrint('prefetch pages failed ${item.id}: $e');
      });
    }
  }

  void _openArtist() {
    final artist = widget.artist;
    final current = widget.items[_current];
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
        ),
      ),
    );
  }

  String _artistPosition(WebDiscoveryIllust current) {
    final order = widget.artist?.orderIds;
    if (order != null && order.isNotEmpty) {
      final global = order.indexOf(current.id);
      if (global >= 0) return '${global + 1} / ${order.length}';
    }
    return '${_current + 1} / ${widget.items.length}';
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
        final bar = _buildBar(context);
        return Scaffold(
          appBar: reversed ? null : bar,
          bottomNavigationBar: reversed ? _buildBottomBar() : null,
          body: _buildPager(),
        );
      },
    );
  }

  AppBar _buildBar(BuildContext context) {
    final artist = widget.artist;
    final current = widget.items[_current];
    final authorName = artist?.name.isNotEmpty == true
        ? artist!.name
        : (current.userName ?? '');
    final avatarUrl = artist?.avatarUrl ?? current.profileImageUrl ?? '';
    final subtitle = artist != null
        ? _artistPosition(current)
        : current.title;
    return AppBar(
      titleSpacing: 0,
      title: _buildBarTitle(context, avatarUrl: avatarUrl, authorName: authorName, subtitle: subtitle),
      actions: _buildBarActions(),
    );
  }

  // Bottom bar for reverse mode. Deliberately NOT an AppBar widget: an
  // AppBar in Scaffold.bottomNavigationBar collapses the Scaffold body to
  // zero height (reproduced headless, both primary values), leaving a void
  // page under a lone bar. Same content, plain Material shell.
  Widget _buildBottomBar() {
    // _current is valid here: _buildBar indexes the same list first and
    // would throw before the Scaffold builds if it weren't.
    final artist = widget.artist;
    final current = widget.items[_current];
    final authorName = artist?.name.isNotEmpty == true
        ? artist!.name
        : (current.userName ?? '');
    final avatarUrl = artist?.avatarUrl ?? current.profileImageUrl ?? '';
    final subtitle = artist != null
        ? _artistPosition(current)
        : current.title;
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
                    avatarUrl: avatarUrl, authorName: authorName, subtitle: subtitle),
              ),
              ..._buildBarActions(),
            ],
          ),
        ),
      ),
    );
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

  Widget _buildPager() {
    return ExtendedPageView.builder(
        // Stays hittable mid-animation (framework PageView ignores pointer
        // while driven, which used to route inner grabs to the outer here).
        shouldIgnorePointerWhenScrolling: false,
        physics: const SnappyPagePhysics(),
        controller: _controller,
        itemCount: widget.items.length,
        onPageChanged: (index) {
          setState(() => _current = index);
          _precacheNeighbors(index);
        },
        itemBuilder: (context, index) => DetailPage(
          key: ValueKey(widget.items[index].id),
          illust: widget.items[index],
          onInnerDragStart: _onInnerDragStart,
          onInnerDragUpdate: _onInnerDragUpdate,
          onInnerDragEnd: _onInnerDragEnd,
          active: index == _current,
          preload: (index - _current).abs() == 1,
          artist: widget.artist,
        ),
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
    if (hold == null || !_controller.hasClients) return;
    final position = _controller.position;
    final endVelocity = resolveEndVelocity(
      pixels: position.pixels,
      pageOrigin: _current * position.viewportDimension,
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
