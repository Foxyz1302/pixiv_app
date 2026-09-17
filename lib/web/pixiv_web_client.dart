import 'package:dio/dio.dart';

import 'pixiv_web_models.dart';

enum WebDiscoveryMode {
  all('all'),
  safe('safe'),
  r18('r18');

  final String value;
  const WebDiscoveryMode(this.value);
}

class PixivWebClient {
  static const String baseUrl = 'https://www.pixiv.net';
  static const String userAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/126.0 Safari/537.36';
  static const String defaultReferer = 'https://www.pixiv.net/';

  static String artworkReferer(String artworkId) =>
      'https://www.pixiv.net/artworks/$artworkId';

  static String userReferer(String userId) =>
      'https://www.pixiv.net/users/$userId';

  static const String rankingReferer = 'https://www.pixiv.net/ranking.php';
  static const String searchReferer = 'https://www.pixiv.net/search.php';
  static const String origin = 'https://www.pixiv.net';

  static final RegExp _csrfPattern = RegExp(
    r'''token\\?["']\\?:\\?["']([^"\\]+)\\?["']''',
  );
  static final RegExp _csrfFallback = RegExp(r'"token"\s*:\s*"([^"]+)"');

  final Dio _dio;
  String? _csrfToken;

  PixivWebClient({String? cookie, Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: baseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 15),
              headers: {
                'User-Agent': userAgent,
                'Referer': defaultReferer,
                'Accept': 'application/json',
              },
            ),
          ) {
    if (cookie != null) {
      setCookie(cookie);
    }
  }

  void setCookie(String cookie) {
    _dio.options.headers['Cookie'] = cookie;
  }

  void clearCookie() {
    _dio.options.headers.remove('Cookie');
  }

  Future<WebDiscoveryResponse> discoveryArtworks({
    WebDiscoveryMode mode = WebDiscoveryMode.all,
    int? limit,
  }) async {
    final data = await _get(
      '/ajax/discovery/artworks',
      query: {'mode': mode.value, 'limit': limit},
    );
    return WebDiscoveryResponse.fromMap(data);
  }

  Future<WebIllustDetailResponse> illustDetail(String id) async {
    final data = await _get('/ajax/illust/$id', referer: artworkReferer(id));
    return WebIllustDetailResponse.fromMap(data);
  }

  Future<WebIllustPagesResponse> illustPages(String id) async {
    final data = await _get(
      '/ajax/illust/$id/pages',
      referer: artworkReferer(id),
    );
    return WebIllustPagesResponse.fromMap(data);
  }

  Future<WebUgoiraResponse> ugoiraMeta(String id) async {
    final data = await _get(
      '/ajax/illust/$id/ugoira_meta',
      referer: artworkReferer(id),
    );
    return WebUgoiraResponse.fromMap(data);
  }

  Future<WebRecommendResponse> related(
    String id, {
    int? limit,
    List<String>? nextIds,
  }) async {
    if (nextIds == null || nextIds.isEmpty) {
      final data = await _get(
        '/ajax/illust/$id/recommend/init',
        query: {'limit': limit ?? 18},
        referer: artworkReferer(id),
      );
      _stringifyBodyList(data, 'nextIds');
      return WebRecommendResponse.fromMap(data);
    }
    final qs = nextIds
        .map((e) => 'illust_ids[]=${Uri.encodeComponent(e)}')
        .join('&');
    final data = await _get(
      '/ajax/illust/recommend/illusts?$qs',
      referer: artworkReferer(id),
    );
    _stringifyBodyList(data, 'nextIds');
    return WebRecommendResponse.fromMap(data);
  }

  Future<WebFollowLatestResponse> followLatest({
    String mode = 'all',
    int p = 1,
  }) async {
    final data = await _get(
      '/ajax/follow_latest/illust',
      query: {'mode': mode, 'p': p},
    );
    final body = data['body'];
    if (body is Map) {
      final page = body['page'];
      if (page is Map && page['ids'] is List) {
        page['ids'] = (page['ids'] as List).map((e) => '$e').toList();
      }
    }
    return WebFollowLatestResponse.fromMap(data);
  }

  Future<WebRankingResponse> ranking({
    String mode = 'daily',
    String content = 'illust',
    int p = 1,
  }) async {
    final data = await _get(
      '/ranking.php',
      query: {'format': 'json', 'mode': mode, 'content': content, 'p': p},
      referer: rankingReferer,
    );
    return WebRankingResponse.fromMap(data);
  }

  Future<WebSearchArtworksResponse> searchArtworks(
    String word, {
    String mode = 'all',
    String sMode = 's_tag',
    String order = 'date_d',
    int p = 1,
  }) async {
    final data = await _get(
      '/ajax/search/artworks/${Uri.encodeComponent(word)}',
      query: {
        'word': word,
        'order': order,
        'mode': mode,
        's_mode': sMode,
        'p': p,
      },
      referer: searchReferer,
    );
    return WebSearchArtworksResponse.fromMap(data);
  }

  Future<WebUserFullResponse> userFull(String id) async {
    final data = await _get(
      '/ajax/user/$id',
      query: {'full': 1},
      referer: userReferer(id),
    );
    final body = data['body'];
    if (body is Map && body['social'] is List) {
      body['social'] = <String, dynamic>{};
    }
    return WebUserFullResponse.fromMap(data);
  }

  Future<WebUserWorksAllResponse> userWorksAll(String id) async {
    final data = await _get(
      '/ajax/user/$id/profile/all',
      referer: userReferer(id),
    );
    final body = data['body'];
    if (body is Map) {
      for (final key in ['illusts', 'manga', 'novels']) {
        if (body[key] is List) {
          body[key] = <String, dynamic>{};
        }
      }
    }
    return WebUserWorksAllResponse.fromMap(data);
  }

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
      final qs = [
        'work_category=${Uri.encodeComponent(workCategory)}',
        'is_first_page=1',
        'lang=en',
        for (final id in chunk) 'ids[]=${Uri.encodeComponent(id)}',
      ].join('&');
      final data = await _get(
        '/ajax/user/$userId/profile/illusts?$qs',
        referer: '${userReferer(userId)}/illustrations',
      );
      final response = WebUserProfileWorksResponse.fromMap(data);
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

  Future<WebCommentsResponse> comments(
    String id, {
    int offset = 0,
    int limit = 30,
  }) async {
    final data = await _get(
      '/ajax/illusts/comments/roots',
      query: {'illust_id': id, 'offset': offset, 'limit': limit},
      referer: artworkReferer(id),
    );
    return WebCommentsResponse.fromMap(data);
  }

  Future<bool> ensureCsrfToken() async {
    if (_csrfToken != null && _csrfToken!.isNotEmpty) {
      return true;
    }
    for (var attempt = 0; attempt < 3; attempt++) {
      if (attempt > 0) {
        await Future.delayed(const Duration(seconds: 2));
      }
      final response = await _dio.get<String>(
        '/',
        options: Options(
          responseType: ResponseType.plain,
          validateStatus: (_) => true,
          headers: {'Accept': 'text/html,application/xhtml+xml'},
        ),
      );
      if (response.statusCode != 200) {
        continue;
      }
      final html = response.data ?? '';
      final match =
          _csrfPattern.firstMatch(html) ?? _csrfFallback.firstMatch(html);
      final token = match?.group(1) ?? '';
      if (token.isEmpty) {
        continue;
      }
      _csrfToken = token;
      _dio.options.headers['x-csrf-token'] = token;
      return true;
    }
    return false;
  }

  Future<int> bookmarkAdd(
    String illustId, {
    bool isPrivate = false,
    String comment = '',
    List<String> tags = const [],
  }) async {
    final ok = await ensureCsrfToken();
    if (!ok) {
      throw StateError('CSRF token unavailable');
    }
    final response = await _dio.post<Map<String, dynamic>>(
      '/ajax/illusts/bookmarks/add',
      data: {
        'illust_id': illustId,
        'restrict': isPrivate ? 1 : 0,
        'comment': comment,
        'tags': tags,
      },
      options: Options(
        headers: {
          'Referer': artworkReferer(illustId),
          'Origin': origin,
          'Content-Type': 'application/json',
        },
      ),
    );
    final data = response.data!;
    if (data['error'] == true) {
      throw StateError('${data['message']}');
    }
    final body = data['body'];
    if (body is Map) {
      final value = body['last_bookmark_id'];
      if (value is int) {
        return value;
      }
      return int.tryParse('$value') ?? 0;
    }
    return 0;
  }

  Future<Map<String, dynamic>> _get(
    String path, {
    Map<String, dynamic>? query,
    String? referer,
  }) async {
    final filtered = <String, dynamic>{};
    query?.forEach((key, value) {
      if (value != null) {
        filtered[key] = value;
      }
    });
    final response = await _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: filtered.isEmpty ? null : filtered,
      options: referer == null ? null : Options(headers: {'Referer': referer}),
    );
    return response.data!;
  }

  void dispose() {
    _dio.close();
  }

  void _stringifyBodyList(Map<String, dynamic> data, String key) {
    final body = data['body'];
    if (body is Map && body[key] is List) {
      body[key] = (body[key] as List).map((e) => '$e').toList();
    }
  }
}
