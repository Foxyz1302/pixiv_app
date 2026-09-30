import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'feed_screen.dart';
import 'px_cache.dart';
import 'web_session.dart';

class PostMinimapItem {
  final String thumbUrl;
  final String id;
  final int pageCount;
  final bool isUgoira;
  final bool isR18;
  final bool isLoadMore;
  final int loadCount;
  final bool loadNewer;

  const PostMinimapItem({
    required this.thumbUrl,
    required this.id,
    this.pageCount = 0,
    this.isUgoira = false,
    this.isR18 = false,
    this.isLoadMore = false,
    this.loadCount = 0,
    this.loadNewer = false,
  });
}

class PostMinimap extends StatefulWidget {
  final List<PostMinimapItem> items;
  final int currentIndex;
  final int initialIndex;
  final ValueChanged<int> onJump;
  final bool visible;
  final ValueListenable<double>? dragPosition;

  const PostMinimap({
    super.key,
    required this.items,
    required this.currentIndex,
    this.initialIndex = 0,
    required this.onJump,
    required this.visible,
    this.dragPosition,
  });

  @override
  State<PostMinimap> createState() => _PostMinimapState();
}

class _PostMinimapState extends State<PostMinimap> {
  static const double _padH = 12;
  static const double _separator = 6;

  late final ScrollController _strip;
  int _lastEnsured = -1;

  @override
  void initState() {
    super.initState();
    _strip = ScrollController();
    _lastEnsured = widget.initialIndex.clamp(0, widget.items.length - 1);
    widget.dragPosition?.addListener(_onTick);
    WidgetsBinding.instance.addPostFrameCallback((_) => _jumpToInitial());
  }

  @override
  void didUpdateWidget(PostMinimap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dragPosition != widget.dragPosition) {
      oldWidget.dragPosition?.removeListener(_onTick);
      widget.dragPosition?.addListener(_onTick);
    }
  }

  @override
  void dispose() {
    widget.dragPosition?.removeListener(_onTick);
    _strip.dispose();
    super.dispose();
  }

  double _tileSize() => WebSession.instance.miniTileSize.peek();

  double _centerFor(double pos, double tile) {
    final last = (widget.items.length - 1).toDouble();
    final clamped = pos.clamp(0.0, last < 0 ? 0.0 : last);
    return _padH + tile / 2 + clamped * (tile + _separator);
  }

  void _jumpToInitial() {
    if (!mounted || !_strip.hasClients) return;
    final position = _strip.position;
    final target = (_centerFor(widget.initialIndex.toDouble(), _tileSize()) - position.viewportDimension / 2)
        .clamp(position.minScrollExtent, position.maxScrollExtent);
    if ((target - position.pixels).abs() > 0.5) _strip.jumpTo(target);
  }

  void _onTick() {
    final pos = widget.dragPosition?.value;
    if (pos == null || !_strip.hasClients || widget.items.isEmpty) return;
    final position = _strip.position;
    final target = (_centerFor(pos, _tileSize()) - position.viewportDimension / 2)
        .clamp(position.minScrollExtent, position.maxScrollExtent);
    if ((target - position.pixels).abs() > 0.5) _strip.jumpTo(target);
  }

  @override
  Widget build(BuildContext context) {
    return SignalBuilder(
      builder: (context) {
        final tile = WebSession.instance.miniTileSize.value;
        final drag = widget.dragPosition;
        if (drag == null) return _shell(context, widget.currentIndex.toDouble(), tile);
        return ValueListenableBuilder<double>(
          valueListenable: drag,
          builder: (context, pos, _) => _shell(context, pos, tile),
        );
      },
    );
  }

  Widget _shell(BuildContext context, double pos, double tile) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedOpacity(
      opacity: widget.visible ? 1 : 0,
      duration: const Duration(milliseconds: 200),
      child: IgnorePointer(
        ignoring: !widget.visible,
        child: SizedBox(
          height: tile + 8,
          child: ListView.separated(
            controller: _strip,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: _padH, vertical: 4),
            itemCount: widget.items.length,
            separatorBuilder: (_, _) => const SizedBox(width: _separator),
            itemBuilder: (context, index) {
              final item = widget.items[index];
              final t = (pos - index).abs().clamp(0.0, 1.0);
              final scale = 1.12 - 0.12 * t;
              final ring = 1.0 - t;
              final selected = index == widget.currentIndex;
              final settled = (pos - widget.currentIndex).abs() < 0.02;
              final Widget cell = item.isLoadMore
                  ? _loadCell(context, item, tile)
                  : Transform.scale(
                      scale: scale,
                      child: SizedBox(
                        key: ValueKey(item.id),
                        width: tile,
                        height: tile,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Opacity(
                                opacity: 0.6 + 0.4 * ring,
                                child: _thumbImage(item.thumbUrl),
                              ),
                              if (item.isR18) const Positioned(top: 2, left: 2, child: TileBadge('R18')),
                              if (item.isUgoira)
                                const Positioned(top: 2, right: 2, child: TileBadge('', icon: Icons.play_arrow)),
                              if (item.pageCount > 1)
                                Positioned(
                                    bottom: 2, right: 2, child: TileBadge('${item.pageCount}', icon: Icons.photo_library)),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: scheme.primary.withOpacity(ring), width: 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
              final tappable = GestureDetector(
                onTap: selected ? null : () => widget.onJump(index),
                child: cell,
              );
              if (!selected || !settled || _lastEnsured == index) return tappable;
              return Builder(
                builder: (itemContext) {
                  _lastEnsured = index;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (itemContext.mounted) {
                      Scrollable.ensureVisible(
                        itemContext,
                        alignment: 0.5,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                      );
                    }
                  });
                  return tappable;
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _loadCell(BuildContext context, PostMinimapItem item, double tile) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      key: ValueKey(item.id),
      width: tile,
      height: tile,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: scheme.surfaceContainerHighest,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item.loadNewer ? Icons.arrow_back : Icons.arrow_forward, size: 18),
                Text('+${item.loadCount}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _thumbImage(String url) {
    if (url.isEmpty) return const ColoredBox(color: Colors.black12, child: Icon(Icons.broken_image, size: 20));
    return Image(
      image: PxImageProvider(
        url,
        headers: imageHeaders,
        cacheManager: PxCache.instance.thumbs,
      ),
      fit: BoxFit.cover,
      gaplessPlayback: true,
      errorBuilder: (context, error, stackTrace) =>
          const ColoredBox(color: Colors.black12, child: Icon(Icons.broken_image, size: 20)),
    );
  }
}
