import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

const _ua =
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
    '(KHTML, like Gecko) Chrome/126.0 Safari/537.36';
const _referer = 'https://www.pixiv.net/';

String _maskSetCookie(String raw) {
  final parts = raw.split(';');
  final first = parts.isEmpty ? raw : parts[0];
  final eq = first.indexOf('=');
  final name = (eq < 0 ? first : first.substring(0, eq)).trim();
  String? expires;
  String? maxAge;
  for (var i = 1; i < parts.length; i++) {
    final attr = parts[i].trim();
    final aeq = attr.indexOf('=');
    final aName = (aeq < 0 ? attr : attr.substring(0, aeq)).trim().toLowerCase();
    final aVal = aeq < 0 ? '' : attr.substring(aeq + 1).trim();
    if (aName == 'expires') {
      expires = aVal;
    } else if (aName == 'max-age') {
      maxAge = aVal;
    }
  }
  final dispName = name.isEmpty ? '?' : name;
  return '$dispName=*** expires=${expires ?? '-'} max-age=${maxAge ?? '-'}';
}

List<String> _setCookies(Response<dynamic> res) {
  final out = <String>[];
  for (final e in res.headers.map.entries) {
    if (e.key.toLowerCase() == 'set-cookie') out.addAll(e.value);
  }
  return out;
}

void _report(String label, int? status, List<String> sc) {
  stdout.writeln('--- $label status=${status ?? '?'} ---');
  if (sc.isEmpty) {
    stdout.writeln('[$label] set-cookie: (none)');
  } else {
    stdout.writeln('[$label] set-cookie count=${sc.length}');
    for (final c in sc) {
      stdout.writeln('[$label]   ${_maskSetCookie(c)}');
    }
  }
}

Future<void> main(List<String> args) async {
  final cookiePath = args.isEmpty ? 'cookies.json' : args[0];
  final rawText = await File(cookiePath).readAsString();
  final cleaned = rawText.replaceAllMapped(RegExp(r',\s*([\}\]])'), (m) => m.group(1)!);
  final decoded = jsonDecode(cleaned);

  final cookies = <String, String>{};
  double? storedExp;
  if (decoded is List) {
    for (final entry in decoded) {
      if (entry is Map) {
        final name = entry['name']?.toString();
        final value = entry['value']?.toString();
        if (name != null && value != null && value.isNotEmpty) {
          cookies[name] = value;
        }
        if (name == 'PHPSESSID') {
          final exp = entry['expirationDate'] ?? entry['expires'];
          if (exp is num) storedExp = exp.toDouble();
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
          if (name == 'PHPSESSID') {
            final exp = entry['expirationDate'] ?? entry['expires'];
            if (exp is num) storedExp = exp.toDouble();
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
      '(found names: ${cookies.keys.toList()}).',
    );
    exit(2);
  }
  if (storedExp != null) {
    final dt = DateTime.fromMillisecondsSinceEpoch((storedExp * 1000).round(), isUtc: true);
    stdout.writeln('[stored] PHPSESSID expirationDate=$storedExp -> $dt (UTC)');
  } else {
    stdout.writeln('[stored] PHPSESSID expiry attribute: (absent in file)');
  }
  stdout.writeln('[cookies] ${cookies.length} names: ${cookies.keys.toList()} (values hidden)');

  final cookieHeader = cookies.entries.map((e) => '${e.key}=${e.value}').join('; ');
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.pixiv.net',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'User-Agent': _ua, 'Referer': _referer, 'Accept': 'application/json', 'Cookie': cookieHeader},
      validateStatus: (_) => true,
    ),
  );

  Future<void> probe(String label, String path, [Map<String, dynamic>? query]) async {
    try {
      final res = await dio.get<dynamic>(path, queryParameters: query);
      _report(label, res.statusCode, _setCookies(res));
      final data = res.data;
      if (data is Map && data.containsKey('error')) {
        stdout.writeln('[$label] body error=${data['error']}');
      }
    } on DioException catch (e) {
      final res = e.response;
      if (res != null) {
        _report('$label-err', res.statusCode, _setCookies(res));
      } else {
        stdout.writeln('--- $label FAIL no-response type=${e.type} ---');
      }
    }
  }

  try {
    await probe('1-discovery-safe', '/ajax/discovery/artworks', {'mode': 'safe', 'limit': '3'});
    await Future.delayed(const Duration(seconds: 3));
    await probe('2-top-safe', '/ajax/top/illust', {'mode': 'safe'});
    await Future.delayed(const Duration(seconds: 3));
    await probe('3-illust-detail', '/ajax/illust/147850798');
    await Future.delayed(const Duration(seconds: 3));
    await probe('4-discovery-safe-repeat', '/ajax/discovery/artworks', {'mode': 'safe', 'limit': '3'});
    stdout.writeln('OK');
  } finally {
    dio.close();
  }
}
