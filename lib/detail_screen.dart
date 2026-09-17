import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'feed_screen.dart';
import 'web/pixiv_web_models.dart';

class DetailScreen extends StatefulWidget {
  final List<WebDiscoveryIllust> items;
  final int initialIndex;

  const DetailScreen({super.key, required this.items, this.initialIndex = 0});

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
      final url = thumbUrl(widget.items[next]);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView.builder(
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
        ),
      ),
    );
  }

  void _onInnerEdge(int direction) {
    if (direction > 0) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
