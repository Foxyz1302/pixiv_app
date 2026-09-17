import 'package:flutter/foundation.dart';
import 'package:signals/signals_flutter.dart';

import 'web/pixiv_web_client.dart';
import 'web/pixiv_web_models.dart';
import 'web_session.dart';

class FeedStore {
  static final FeedStore instance = FeedStore._();
  FeedStore._();

  final mode = signal(WebDiscoveryMode.all);
  final items = signal<List<WebDiscoveryIllust>>([]);
  final isLoading = signal(false);
  final error = signal<String?>(null);
  final isLoadingMore = signal(false);
  final moreError = signal<String?>(null);

  Future<void> load() async {
    if (isLoading.peek()) return;
    final currentMode = mode.peek();
    isLoading.value = true;
    error.value = null;
    try {
      final response = await WebSession.instance.client.discoveryArtworks(
        mode: currentMode,
        limit: 60,
      );
      if (response.error) {
        error.value = response.message.isEmpty
            ? 'Request failed'
            : response.message;
        items.value = [];
      } else {
        items.value = response.body.thumbnails.illust;
      }
    } catch (e, stack) {
      debugPrint('feed load failed: $e\n$stack');
      error.value = e.toString();
      items.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isLoading.peek() || isLoadingMore.peek()) return;
    final requestMode = mode.peek();
    isLoadingMore.value = true;
    moreError.value = null;
    try {
      final response = await WebSession.instance.client.discoveryArtworks(
        mode: requestMode,
        limit: 60,
      );
      if (requestMode != mode.peek()) return;
      if (response.error) {
        moreError.value = response.message.isEmpty
            ? 'Request failed'
            : response.message;
      } else {
        final seen = {for (final item in items.peek()) item.id};
        final fresh = [
          for (final item in response.body.thumbnails.illust)
            if (seen.add(item.id)) item,
        ];
        if (fresh.isEmpty) {
          moreError.value = 'No new works — try again';
        } else {
          items.value = [...items.peek(), ...fresh];
        }
      }
    } catch (e, stack) {
      debugPrint('feed loadMore failed: $e\n$stack');
      if (requestMode != mode.peek()) return;
      moreError.value = e.toString();
    } finally {
      isLoadingMore.value = false;
    }
  }
}
