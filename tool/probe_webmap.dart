// Read-only live probe of Pixiv web ajax endpoints (R18 webmap).
// Run from the project root:
//   dart run tool/probe_webmap.dart [cookies.json]
//
// Reuses tool/probe_discovery.dart cookie/header/redaction pattern.
// GETs only, ~2s spacing, one call per endpoint, small limits.
// Never prints cookie values. Writes FULL redacted output to
// docs/webmap_probe.txt (titles/URLs truncated to 80 chars).
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

const _ua =
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
    '(KHTML, like Gecko) Chrome/126.0 Safari/537.36';
const _referer = 'https://www.pixiv.net/';
const _artId = '147850798';

final _out = StringBuffer();

void _log(String s) {
  stdout.writeln(s);
  _out.writeln(s);
}

String _clip(String? s, int n) => s == null ? '?' : (s.length <= n ? s : '${s.substring(0, n)}…');

// Recursively clip all strings to 80 chars (titles/URLs) for file safety.
dynamic _sanitize(dynamic v) {
  if (v is String) return v.length <= 80 ? v : '${v.substring(0, 80)}…';
  if (v is List) return v.map(_sanitize).toList();
  if (v is Map) {
    return v.map((k, val) => MapEntry(k.toString(), _sanitize(val)));
  }
  return v;
}

String _redactedSnippet(dynamic data) {
  final s = data is String ? data : jsonEncode(_sanitize(data ?? ''));
  final masked = s.replaceAll(RegExp(r'PHPSESSID=[^;\s"]+'), 'PHPSESSID=***');
  return masked.length <= 2000 ? masked : '${masked.substring(0, 2000)}…';
}

// Count xRestrict / x_restrict values in a list of illust-like maps.
Map<dynamic, int> _xHist(List<dynamic> items) {
  final h = <dynamic, int>{};
  for (final t in items) {
    if (t is Map) {
      final x = t['xRestrict'] ?? t['x_restrict'] ?? '?';
      h[x] = (h[x] ?? 0) + 1;
    }
  }
  return h;
}

// Find illust-like lists nested under common keys for histogram purposes.
// List<dynamic> _findIllustLists(Map<String, dynamic> body) {
//   for (final k in ['illusts', 'illustManga', 'data', 'contents', 'thumbnails', 'works']) {
//     final v = body[k];
//     if (v is List) return v;
//     if (v is Map && v['data'] is List) return v['data'] as List;
//   }
//   return const [];
// }

void _summarize(String label, dynamic data, {int? status}) {
  _log('=== $label === status=${status ?? 200}');
  if (data is Map<String, dynamic>) {
    _log('[$label] top keys=${data.keys.toList()}');
    if (data.containsKey('error')) {
      _log('[$label] error=${data['error']} message=${_clip(data['message']?.toString(), 80)}');
    }
    final body = data['body'];
    if (body == null) {
      // Non-ajax wrapper (e.g. ranking.php) — describe top level directly.
      for (final k in ['contents', 'illusts', 'data', 'comments', 'illustManga']) {
        if (data[k] is List) {
          final l = data[k] as List;
          _log('[$label] $k=${l.length} xRestrict=${_xHist(l)}');
        }
      }
      for (final k in ['page', 'pagination', 'next', 'prev', 'hasNext', 'next_url', 'lastPage', 'total', 'count']) {
        if (data.containsKey(k)) {
          _log('[$label] pag $k=${_clip(data[k]?.toString(), 80)}');
        }
      }
      _log('[$label] snippet=${_redactedSnippet(data)}');
      return;
    }
    if (body is Map) {
      final bm = body as Map<String, dynamic>;
      _log('[$label] body keys=${bm.keys.toList()}');
      // Generic list counters.
      for (final e in bm.entries) {
        if (e.value is List) {
          final l = e.value as List;
          var extra = 'len=${l.length}';
          if (l.isNotEmpty && l.first is Map) {
            extra += ' xRestrict=${_xHist(l)} firstKeys=${(l.first as Map).keys.toList()}';
          }
          _log('[$label] body.${e.key}: $extra');
        }
      }
      // Nested illustManga.data (search shape).
      if (bm['illustManga'] is Map) {
        final im = bm['illustManga'] as Map;
        _log('[$label] illustManga keys=${(im).keys.toList()}');
        if (im['data'] is List) {
          final l = im['data'] as List;
          _log('[$label] illustManga.data=${l.length} xRestrict=${_xHist(l)}');
          for (final t in l.take(5)) {
            if (t is Map) {
              _log(
                '  id=${t['id']} x=${t['xRestrict'] ?? t['x_restrict']} title=${_clip(t['title']?.toString(), 80)} userId=${t['userId']}',
              );
            }
          }
        }
        for (final k in ['total', 'lastPage', 'hasNext']) {
          if (im.containsKey(k)) _log('[$label] illustManga.$k=${im[k]}');
        }
      }
      // Single-illust detail fields.
      if (bm.containsKey('illustId') || bm.containsKey('id') && bm.containsKey('userId')) {
        _log(
          '[$label] id=${bm['illustId'] ?? bm['id']} title=${_clip(bm['illustTitle'] ?? bm['title']?.toString(), 80)} '
          'userId=${bm['userId']} userName=${_clip(bm['userName']?.toString(), 80)} '
          'xRestrict=${bm['xRestrict']} restrict=${bm['restrict']} illustType=${bm['illustType']} '
          'pageCount=${bm['pageCount']} aiType=${bm['aiType']}',
        );
        if (bm['tags'] is Map) {
          final tags = (bm['tags'] as Map)['tags'];
          if (tags is List) {
            _log(
              '[$label] tags=${tags.length}: ${tags.take(8).map((t) => t is Map ? _clip(t['tag']?.toString(), 80) : t.toString()).toList()}',
            );
          }
        }
        if (bm['urls'] is Map) {
          _log('[$label] urls keys=${((bm['urls']) as Map).keys.toList()}');
        }
      }
      // Recommend shape: illusts + nextIds.
      for (final k in ['nextIds', 'hasNext', 'page', 'lastPage', 'total']) {
        if (bm.containsKey(k)) {
          final v = bm[k];
          final s = v is List ? 'len=${v.length} first=${v.take(3).toList()}' : _clip(v?.toString(), 80);
          _log('[$label] pag $k=$s');
        }
      }
      // Follow-latest shape often: {page:{...}, illusts?/thumbnails?} — dump page subkeys.
      if (bm['page'] is Map) {
        _log('[$label] page keys=${((bm['page']) as Map).keys.toList()} page=${_redactedSnippet(_sanitize(bm['page']))}');
      }
      // User detail shape.
      if (bm.containsKey('user') || bm.containsKey('profile')) {
        _log('[$label] user/profile snippet=${_redactedSnippet(bm)}');
      }
      // Comments shape.
      if (bm['comments'] is List) {
        final l = bm['comments'] as List;
        _log('[$label] comments=${l.length} hasNext=${bm['hasNext']}');
        for (final c in l.take(3)) {
          if (c is Map) {
            _log('  c id=${c['id']} userId=${c['userId']} stampId=${c['stampId']} comment=${_clip(c['comment']?.toString(), 80)}');
          }
        }
      }
      _log('[$label] body snippet=${_redactedSnippet(bm)}');
    } else if (body is List) {
      _log('[$label] body is List len=${body.length}');
      if (body.isNotEmpty && body.first is Map) {
        _log('[$label] first keys=${((body.first) as Map).keys.toList()} xRestrict=${_xHist(body)}');
        for (final p in body.take(3)) {
          if (p is Map) {
            _log('  w=${p['width']} h=${p['height']} urls keys=${p['urls'] is Map ? ((p['urls']) as Map).keys.toList() : '?'}');
            if (p['urls'] is Map) {
              final u = p['urls'] as Map;
              _log('    original=${_clip(u['original']?.toString(), 80)}');
            }
          }
        }
      }
      _log('[$label] snippet=${_redactedSnippet(body)}');
    } else {
      _log('[$label] body scalar=${_clip(body?.toString(), 80)}');
    }
  } else if (data is List) {
    _log('[$label] top-level List len=${data.length}');
    _log('[$label] snippet=${_redactedSnippet(data)}');
  } else {
    _log('[$label] scalar=${_clip(data?.toString(), 80)}');
  }
}

Future<dynamic> _get(Dio dio, String label, String path, [Map<String, dynamic>? query]) async {
  final qp = query == null ? '' : ' query=$query';
  _log('--- GET $path$qp ($label) ---');
  try {
    final res = await dio.get<dynamic>(path, queryParameters: query);
    _summarize(label, res.data, status: res.statusCode);
    return res.data;
  } on DioException catch (e) {
    final st = e.response?.statusCode;
    _log('=== $label === status=$st FAIL');
    final d = e.response?.data;
    if (d is Map<String, dynamic>) {
      _summarize('$label-err', d, status: st);
    } else {
      _log('[$label-err] body=${_redactedSnippet(d)}');
    }
    return null;
  }
}

Future<void> main(List<String> args) async {
  final cookiePath = args.isEmpty ? 'cookies.json' : args[0];
  final rawText = await File(cookiePath).readAsString();
  final cleaned = rawText.replaceAllMapped(RegExp(r',\s*([\}\]])'), (m) => m.group(1)!);
  final decoded = jsonDecode(cleaned);

  final cookies = <String, String>{};
  if (decoded is List) {
    for (final entry in decoded) {
      if (entry is Map) {
        final name = entry['name']?.toString();
        final value = entry['value']?.toString();
        if (name != null && value != null && value.isNotEmpty) {
          cookies[name] = value;
        }
      }
    }
  } else if (decoded is Map) {
    final inner = decoded['cookies'] ?? decoded;
    if (inner is List) {
      for (final entry in inner) {
        if (entry is Map) {
          final name = entry['name']?.toString();
          final value = entry['value']?.toString();
          if (name != null && value != null && value.isNotEmpty) {
            cookies[name] = value;
          }
        }
      }
    } else if (inner is Map) {
      for (final e in (inner).entries) {
        final v = e.value;
        if (v is String && v.isNotEmpty) cookies[e.key.toString()] = v;
      }
    }
  }

  if (!cookies.containsKey('PHPSESSID')) {
    stderr.writeln(
      'ERROR: no PHPSESSID in $cookiePath '
      '(found names: ${cookies.keys.toList()}). '
      'Re-export cookies while logged in on pixiv.net.',
    );
    exit(2);
  }
  _log(
    '[cookies] ${cookies.length} names: ${cookies.keys.toList()} '
    '(values hidden, PHPSESSID len ${cookies['PHPSESSID']!.length})',
  );

  final cookieHeader = cookies.entries.map((e) => '${e.key}=${e.value}').join('; ');
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.pixiv.net',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'User-Agent': _ua, 'Referer': _referer, 'Accept': 'application/json', 'Cookie': cookieHeader},
    ),
  );

  Future<void> pause() => Future.delayed(const Duration(seconds: 2));

  try {
    // a. detail
    final aData = await _get(dio, 'a-illust-detail', '/ajax/illust/$_artId');
    await pause();

    // b. pages
    await _get(dio, 'b-illust-pages', '/ajax/illust/$_artId/pages');
    await pause();

    // c. ugoira_meta (expect failure on non-ugoira)
    await _get(dio, 'c-ugoira-meta', '/ajax/illust/$_artId/ugoira_meta');
    await pause();

    // d. recommend init
    await _get(dio, 'd-recommend-init', '/ajax/illust/$_artId/recommend/init', {'limit': '5'});
    await pause();

    // e. follow feed
    await _get(dio, 'e-follow-latest', '/ajax/follow_latest/illust', {'mode': 'all', 'p': '1'});
    await pause();

    // f. R18 ranking (classic endpoint, not ajax wrapper)
    await _get(dio, 'f-ranking-r18', '/ranking.php', {'format': 'json', 'mode': 'daily_r18', 'content': 'illust', 'p': '1'});
    await pause();

    // g. R18 search
    await _get(dio, 'g-search-r18', '/ajax/search/artworks/R-18', {
      'word': 'R-18',
      'type': 'all',
      'order': 'date_d',
      'mode': 'r18',
      's_mode': 's_tag',
    });
    await pause();

    // h. user detail + works (userId from (a))
    String? uid;
    if (aData is Map<String, dynamic>) {
      final b = aData['body'];
      if (b is Map) uid = b['userId']?.toString();
    }
    _log('[h] extracted userId=$uid from (a)');
    if (uid != null) {
      await _get(dio, 'h-user-detail', '/ajax/user/$uid', {'full': '1'});
      await pause();
      await _get(dio, 'h-user-profile-all', '/ajax/user/$uid/profile/all');
      await pause();
    } else {
      _log('[h] SKIP — no userId extracted');
    }

    // i. top page r18
    await _get(dio, 'i-top-illust-r18', '/ajax/top/illust', {'mode': 'r18'});
    await pause();

    // j. discovery meta
    await _get(dio, 'j-discovery-meta', '/ajax/discovery/artworks/meta', {'mode': 'r18'});
    await pause();

    // k. comments
    await _get(dio, 'k-comments', '/ajax/illusts/comments/roots', {'illust_id': _artId, 'offset': '0', 'limit': '3'});

    _log('OK');
  } finally {
    dio.close();
    await File('docs/webmap_probe.txt').writeAsString(_out.toString());
    stderr.writeln('[wrote docs/webmap_probe.txt ${_out.length} chars]');
  }
}
