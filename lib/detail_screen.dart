import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'artist_context.dart';
import 'artist_screen.dart';
import 'detail_page.dart';
import 'feed_screen.dart';
import 'web/pixiv_web_models.dart';

class DetailScreen extends StatefulWidget {
  final List<WebDiscoveryIllust> items;
  final int initialIndex;
  final ArtistContext? artist;

  const DetailScreen({super.key, required this.items, this.initialIndex = 0, this.artist});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final PageController _controller;
  late int _current;

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
    _controller.dispose();
    super.dispose();
  }

  void _precacheNeighbors(int index) {
    for (final next in [index - 1, index + 1]) {
      if (next < 0 || next >= widget.items.length) continue;
      final url = gridThumbUrl(widget.items[next]);
      if (url.isEmpty) continue;
      precacheImage(
        NetworkImage(url, headers: imageHeaders),
        context,
        onError: (error, stackTrace) {
          debugPrint('precache failed $url: $error');
        },
      );
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
    final artist = widget.artist;
    final current = widget.items[_current];
    final authorName = artist?.name.isNotEmpty == true
        ? artist!.name
        : (current.userName ?? '');
    final avatarUrl = artist?.avatarUrl ?? current.profileImageUrl ?? '';
    final subtitle = artist != null
        ? _artistPosition(current)
        : current.title;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: _openArtist,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: Row(
              children: [
                ArtistAvatar(url: avatarUrl, radius: 16),
                const SizedBox(width: 8),
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
        ),
        actions: [
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
        ],
      ),
      body: PageView.builder(
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
          onInnerEdge: _onInnerEdge,
          active: index == _current,
          preload: (index - _current).abs() == 1,
          artist: artist,
        ),
      ),
    );
  }

  void _onInnerEdge(int direction) {
    if (direction > 0) {
      _controller.nextPage(duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
    } else {
      _controller.previousPage(duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
    }
  }
}
