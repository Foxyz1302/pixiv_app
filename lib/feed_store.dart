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
}
