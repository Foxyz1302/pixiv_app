import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import 'web/pixiv_web_client.dart';
import 'web/pixiv_web_models.dart';
import 'web_session.dart';

const apiImmutableTtl = Duration(days: 7);
const apiArtistTtl = Duration(hours: 1);

class ApiCache {
  static final ApiCache instance = ApiCache._();
  ApiCache._();

  static const String boxName = 'pixiv_api';

  late final Box _box;

  Future<void> init() async {
    _box = await Hive.openBox(boxName);
  }

  Future<T> _get<T>(
    String key,
    Duration ttl,
    Future<T> Function() loader,
    Map<String, dynamic> Function(T) encode,
    T Function(Map<String, dynamic>) decode,
  ) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final raw = _box.get(key);
    if (raw is Map) {
      final at = raw['at'];
      final data = raw['data'];
      if (at is int && data is Map && now - at < ttl.inMilliseconds) {
        try {
          return decode(Map<String, dynamic>.from(data));
        } catch (e, stack) {
          debugPrint('api cache decode failed $key: $e\n$stack');
        }
      }
    }
    final fresh = await loader();
    try {
      _box.put(key, {'at': now, 'data': encode(fresh)});
    } catch (e, stack) {
      debugPrint('api cache store failed $key: $e\n$stack');
    }
    return fresh;
  }

  PixivWebClient get _client => WebSession.instance.client;

  Future<WebIllustDetailResponse> illustDetail(String id) => _get(
        'illust:$id',
        apiImmutableTtl,
        () => _client.illustDetail(id),
        (r) => r.toMap(),
        WebIllustDetailResponse.fromMap,
      );

  Future<WebIllustPagesResponse> illustPages(String id) => _get(
        'pages:$id',
        apiImmutableTtl,
        () => _client.illustPages(id),
        (r) => r.toMap(),
        WebIllustPagesResponse.fromMap,
      );

  Future<WebUgoiraResponse> ugoiraMeta(String id) => _get(
        'ugoira:$id',
        apiImmutableTtl,
        () => _client.ugoiraMeta(id),
        (r) => r.toMap(),
        WebUgoiraResponse.fromMap,
      );

  Future<WebUserFullResponse> userFull(String userId) => _get(
        'user:$userId',
        apiArtistTtl,
        () => _client.userFull(userId),
        (r) => r.toMap(),
        WebUserFullResponse.fromMap,
      );

  Future<WebUserWorksAllResponse> userWorksAll(String userId) => _get(
        'works:$userId',
        apiArtistTtl,
        () => _client.userWorksAll(userId),
        (r) => r.toMap(),
        WebUserWorksAllResponse.fromMap,
      );

  Future<WebUserProfileWorksResponse> userProfileWorks(
    String userId,
    List<String> ids, {
    String workCategory = 'illust',
  }) async {
    final works = <String, WebDiscoveryIllust>{};
    var error = false;
    var message = '';
    for (var i = 0; i < ids.length; i += 50) {
      final chunk = ids.sublist(i, (i + 50).clamp(0, ids.length));
      final key = _chunkKey(userId, workCategory, chunk);
      final response = await _get(
        key,
        apiArtistTtl,
        () => _client.userProfileWorks(userId, chunk, workCategory: workCategory),
        (r) => r.toMap(),
        WebUserProfileWorksResponse.fromMap,
      );
      if (response.error) {
        error = true;
        message = response.message;
      }
      works.addAll(response.body.works);
    }
    return WebUserProfileWorksResponse(
      error,
      message: message,
      body: WebUserProfileWorksBody(works: works),
    );
  }

  String _chunkKey(String userId, String category, List<String> chunk) {
    final head = chunk.take(3).join('.');
    final tail = chunk.length > 3 ? chunk.skip(chunk.length - 3).join('.') : '';
    return 'pworks:$userId:$category:${chunk.length}:$head:$tail';
  }
}
