import 'dart:convert';
import 'dart:io';

import 'package:pixiv_app/web/pixiv_web_client.dart';

Future<void> main(List<String> args) async {
  final cookiePath = args.isEmpty ? 'cookies.json' : args[0];
  final rawText = await File(cookiePath).readAsString();
  final cleaned = rawText.replaceAllMapped(
    RegExp(r',\s*([\}\]])'),
    (m) => m.group(1)!,
  );
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
  }
  if (!cookies.containsKey('PHPSESSID')) {
    stderr.writeln('ERROR: no PHPSESSID');
    exit(2);
  }
  final client = PixivWebClient(
    cookie: cookies.entries.map((e) => '${e.key}=${e.value}').join('; '),
  );
  try {
    final discovery = await client.discoveryArtworks(
      mode: WebDiscoveryMode.safe,
      limit: 10,
    );
    final safeSeeds = discovery.body.thumbnails.illust
        .where((t) => t.xRestrict == 0)
        .toList();
    stdout.writeln('[safe-seeds] ${safeSeeds.map((t) => t.id).take(5).toList()}');
    if (safeSeeds.isEmpty) {
      stderr.writeln('ERROR: no safe seed');
      exit(1);
    }
    await Future.delayed(const Duration(seconds: 2));
    final seed = safeSeeds.first.id;
    final rel = await client.related(seed, limit: 18);
    final hist = <int, int>{};
    for (final t in rel.body.illusts) {
      hist[t.xRestrict] = (hist[t.xRestrict] ?? 0) + 1;
    }
    stdout.writeln(
      '[related-from-safe seed=$seed] count=${rel.body.illusts.length} '
      'xRestrict=$hist',
    );
    stdout.writeln('OK');
  } finally {
    client.dispose();
  }
}
