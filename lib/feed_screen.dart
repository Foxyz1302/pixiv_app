import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'detail_screen.dart';
import 'feed_store.dart';
import 'web/pixiv_web_client.dart';
import 'web/pixiv_web_models.dart';
import 'web_session.dart';

const imageReferer = 'https://www.pixiv.net/';
const imageHeaders = {'Referer': imageReferer};

String thumbUrl(WebDiscoveryIllust illust) {
  if (illust.url.isNotEmpty) return illust.url;
  for (final value in illust.urls.values) {
    if (value.isNotEmpty) return value;
  }
  return '';
}

double thumbAspect(WebDiscoveryIllust illust) {
  if (illust.width > 0 && illust.height > 0) {
    return illust.width / illust.height;
  }
  return 1.0;
}

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    if (WebSession.instance.cookie.peek().isNotEmpty) {
      FeedStore.instance.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixiv'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: FeedStore.instance.load),
          IconButton(icon: const Icon(Icons.grid_view), onPressed: () => showTileWidthDialog(context)),
          IconButton(icon: const Icon(Icons.settings), onPressed: () => showCookieDialog(context)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SignalBuilder(
              builder: (context) {
                return SegmentedButton<WebDiscoveryMode>(
                  segments: const [
                    ButtonSegment(value: WebDiscoveryMode.all, label: Text('All')),
                    ButtonSegment(value: WebDiscoveryMode.safe, label: Text('Safe')),
                    ButtonSegment(value: WebDiscoveryMode.r18, label: Text('R18')),
                  ],
                  selected: {FeedStore.instance.mode.value},
                  onSelectionChanged: (selection) {
                    FeedStore.instance.mode.value = selection.first;
                    FeedStore.instance.load();
                  },
                );
              },
            ),
          ),
          Expanded(
            child: SignalBuilder(
              builder: (context) {
                final loggedIn = WebSession.instance.loggedIn.value;
                final loading = FeedStore.instance.isLoading.value;
                final failure = FeedStore.instance.error.value;
                final feedItems = FeedStore.instance.items.value;
                final tileWidth = WebSession.instance.tileWidth.value;
                if (!loggedIn && feedItems.isEmpty && !loading) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Paste your PHPSESSID to start'),
                        const SizedBox(height: 12),
                        FilledButton(onPressed: () => showCookieDialog(context), child: const Text('Open settings')),
                      ],
                    ),
                  );
                }
                if (loading && feedItems.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (failure != null && feedItems.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(failure),
                        const SizedBox(height: 12),
                        FilledButton(onPressed: FeedStore.instance.load, child: const Text('Retry')),
                      ],
                    ),
                  );
                }
                if (feedItems.isEmpty) {
                  return const Center(child: Text('No works'));
                }
                return RefreshIndicator(
                  onRefresh: FeedStore.instance.load,
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(4),
                        sliver: SliverWaterfallFlow(
                          gridDelegate: SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: tileWidth,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                          ),
                          delegate: SliverChildBuilderDelegate((context, index) {
                            final illust = feedItems[index];
                            return FeedTile(
                              illust: illust,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => DetailScreen(items: feedItems, initialIndex: index),
                                  ),
                                );
                              },
                            );
                          }, childCount: feedItems.length),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FeedTile extends StatelessWidget {
  final WebDiscoveryIllust illust;
  final VoidCallback onTap;

  const FeedTile({super.key, required this.illust, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final url = thumbUrl(illust);
    final tileWidth = WebSession.instance.tileWidth.peek();
    return AspectRatio(
      aspectRatio: thumbAspect(illust),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (url.isEmpty)
              const ColoredBox(color: Colors.black12, child: Icon(Icons.broken_image))
            else
              Image(
                // image: NetworkImage(url, headers: imageHeaders),
                image: ResizeImage.resizeIfNeeded(
                  (tileWidth * MediaQuery.devicePixelRatioOf(context)).round(),
                  null,
                  NetworkImage(url, headers: imageHeaders),
                ),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('thumb failed ${illust.id}: $error');
                  return const ColoredBox(color: Colors.black12, child: Icon(Icons.broken_image));
                },
              ),
            Positioned.fill(
              child: Material(
                type: .transparency,
                child: InkWell(onTap: onTap),
              ),
            ),
            if (illust.illustType == 2)
              const Positioned(top: 4, left: 4, child: TileBadge('UGOIRA'))
            else if (illust.pageCount > 1)
              Positioned(top: 4, right: 4, child: TileBadge('${illust.pageCount}')),
          ],
        ),
      ),
    );
  }
}

class TileBadge extends StatelessWidget {
  final String label;

  const TileBadge(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
      child: Text(label, style: const TextStyle(fontSize: 10, color: Colors.white)),
    );
  }
}

Future<void> showTileWidthDialog(BuildContext context) {
  return showDialog<void>(context: context, builder: (context) => const _TileWidthDialog());
}

class _TileWidthDialog extends StatelessWidget {
  const _TileWidthDialog();

  @override
  Widget build(BuildContext context) {
    final session = WebSession.instance;
    return AlertDialog(
      title: const Text('Grid item width'),
      content: SignalBuilder(
        builder: (context) {
          final width = session.tileWidth.value;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: width <= WebSession.minTileWidth ? null : () => session.setTileWidth(width - 20),
                  ),
                  Expanded(
                    child: Slider(
                      value: width,
                      min: WebSession.minTileWidth,
                      max: WebSession.maxTileWidth,
                      divisions: 17,
                      label: '${width.round()}',
                      onChanged: session.setTileWidth,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: width >= WebSession.maxTileWidth ? null : () => session.setTileWidth(width + 20),
                  ),
                ],
              ),
              Text('${width.round()} px'),
            ],
          );
        },
      ),
      actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close'))],
    );
  }
}

Future<void> showCookieDialog(BuildContext context) {
  return showDialog<void>(context: context, builder: (context) => const _CookieDialog());
}

class _CookieDialog extends StatefulWidget {
  const _CookieDialog();

  @override
  State<_CookieDialog> createState() => _CookieDialogState();
}

class _CookieDialogState extends State<_CookieDialog> {
  late final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = WebSession.instance;
    final hasCookie = session.cookie.peek().isNotEmpty;
    return AlertDialog(
      scrollable: true,
      title: const Text('Session'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hasCookie ? 'Logged in' : 'Not logged in'),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'PHPSESSID',
              hintText: 'Paste cookie value or full header',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            session.clear();
            FeedStore.instance.items.value = [];
            Navigator.of(context).pop();
          },
          child: const Text('Clear'),
        ),
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        FilledButton(
          onPressed: () {
            final text = _controller.text;
            Navigator.of(context).pop();
            if (text.trim().isEmpty) return;
            session.setCookie(text);
            FeedStore.instance.load();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
