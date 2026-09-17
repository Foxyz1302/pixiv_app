// Read-only probe for Pixiv web discovery (R18).
// Run from the project root:
//   dart run tool/probe_discovery.dart [cookies.json] [mode] [limit]
//
// Reads login cookies from a LOCAL file only and never prints cookie values.
// Prints only redacted histograms + artwork IDs/titles.
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

Future<void> main(List<String> args) async {
  final cookiePath = args.isEmpty ? 'cookies.json' : args[0];
  final mode = args.length > 1 ? args[1] : 'r18';
  final limit = args.length > 2 ? int.tryParse(args[2]) ?? 10 : 10;

  final rawText = await File(cookiePath).readAsString();
  // Tolerate trailing commas from browser cookie exports.
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
    // Either {"PHPSESSID": "..."} or {"cookies": [...]}, handle both.
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
  stdout.writeln(
    '[cookies] ${cookies.length} names: ${cookies.keys.toList()} '
    '(values hidden, PHPSESSID len ${cookies['PHPSESSID']!.length})',
  );

  final cookieHeader = cookies.entries.map((e) => '${e.key}=${e.value}').join('; ');
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.pixiv.net',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
            '(KHTML, like Gecko) Chrome/126.0 Safari/537.36',
        'Referer': 'https://www.pixiv.net/',
        'Accept': 'application/json',
        'Cookie': cookieHeader,
      },
    ),
  );

  try {
    final res = await dio.get<Map<String, dynamic>>('/ajax/discovery/artworks', queryParameters: {'mode': mode, 'limit': limit.toString()});
    summarize('discovery/artworks mode=$mode limit=$limit', res.data!);
  } on DioException catch (e) {
    stderr.writeln(
      '[discovery/artworks] FAIL status=${e.response?.statusCode} '
      'body=${_redactedSnippet(e.response?.data)}',
    );
    exit(1);
  } finally {
    dio.close();
  }
  stdout.writeln('OK');
}

void summarize(String label, Map<String, dynamic> data) {
  stdout.writeln('[$label] error=${data['error']} message=${data['message']}');
  final body = data['body'];
  if (body is! Map) {
    stdout.writeln('[$label] no body map, keys=${data.keys.toList()}');
    return;
  }
  final bodyMap = body as Map<String, dynamic>;
  stdout.writeln('[$label] body keys=${bodyMap.keys.toList()}');

  // thumbnails.illust[] entries
  var thumbs = const <dynamic>[];
  final thumbnails = bodyMap['thumbnails'];
  if (thumbnails is Map && thumbnails['illust'] is List) {
    thumbs = thumbnails['illust'] as List;
  }
  final restrict = <dynamic, int>{};
  for (final t in thumbs) {
    if (t is Map) {
      final x = t['xRestrict'] ?? t['x_restrict'] ?? '?';
      restrict[x] = ((restrict[x] ?? 0) + 1);
    }
  }
  stdout.writeln('[$label] thumbnails.illust=${thumbs.length} xRestrict=$restrict');
  for (final t in thumbs.take(8)) {
    if (t is Map) {
      stdout.writeln(
        '  id=${t['id']} x=${t['xRestrict'] ?? t['x_restrict']} '
        'title=${_clip(t['title']?.toString(), 60)}',
      );
    }
  }

  // recommendedIllusts[] (personalization signals)
  final rec = bodyMap['recommendedIllusts'];
  if (rec is List) {
    final methods = <String, int>{};
    for (final r in rec) {
      if (r is Map) {
        final m = r['recommendMethods'] ?? r['recommend_methods'];
        if (m is List) {
          for (final x in m) {
            methods[x.toString()] = (methods[x.toString()] ?? 0) + 1;
          }
        } else if (m != null) {
          methods[m.toString()] = (methods[m.toString()] ?? 0) + 1;
        }
      }
    }
    stdout.writeln('[$label] recommendedIllusts=${rec.length} methods=$methods');
  } else {
    stdout.writeln('[$label] no recommendedIllusts list');
  }
}

String _clip(String? s, int n) => s == null ? '?' : (s.length <= n ? s : '${s.substring(0, n)}…');

String _redactedSnippet(dynamic data) {
  final s = data is String ? data : jsonEncode(data ?? '');
  // Never echo a plausible session value.
  final masked = s.replaceAll(RegExp(r'PHPSESSID=[^;\s"]+'), 'PHPSESSID=***');
  return masked.length <= 500 ? masked : '${masked.substring(0, 500)}…';
}
