import 'dart:convert';
import 'dart:io';

import 'package:pixiv_app/web/pixiv_web_client.dart';

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
  stdout.writeln(
    '[cookies] ${cookies.length} names: ${cookies.keys.toList()} '
    '(values hidden, PHPSESSID len ${cookies['PHPSESSID']!.length})',
  );

  final client = PixivWebClient(cookie: cookies.entries.map((e) => '${e.key}=${e.value}').join('; '));
  var failures = 0;
  Future<void> check(String name, Future<void> Function() fn) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      await fn();
    } catch (e) {
      failures++;
      stderr.writeln('[$name] FAIL: $e');
    }
  }

  String seedId = '';
  String? seedUserId;
  try {
    final discovery = await client.discoveryArtworks(mode: WebDiscoveryMode.r18, limit: 5);
    final illusts = discovery.body.thumbnails.illust;
    final hist = <int, int>{};
    for (final t in illusts) {
      hist[t.xRestrict] = (hist[t.xRestrict] ?? 0) + 1;
    }
    stdout.writeln(
      '[discovery] count=${illusts.length} xRestrict=$hist '
      'recommended=${discovery.body.recommendedIllusts.length}',
    );
    stdout.writeln('[discovery] ids=${illusts.map((t) => t.id).toList()}');
    if (illusts.isEmpty) {
      stderr.writeln('ERROR: empty discovery result');
      exit(1);
    }
    seedId = illusts.first.id;

    await Future.delayed(const Duration(seconds: 2));

    final detail = await client.illustDetail(seedId);
    final d = detail.body;
    seedUserId = d.userId;
    stdout.writeln(
      '[detail] id=${d.id} xRestrict=${d.xRestrict} '
      'pageCount=${d.pageCount} illustType=${d.illustType} '
      'tags=${d.tags.tags.length} userId=${d.userId}',
    );

    await check('related-init', () async {
      final rel = await client.related(seedId, limit: 5);
      final rhist = <int, int>{};
      for (final t in rel.body.illusts) {
        rhist[t.xRestrict] = (rhist[t.xRestrict] ?? 0) + 1;
      }
      stdout.writeln(
        '[related-init] count=${rel.body.illusts.length} '
        'xRestrict=$rhist nextIds=${rel.body.nextIds.length} '
        'firstNext=${rel.body.nextIds.take(3).toList()}',
      );
      if (rel.body.illusts.isEmpty) {
        throw StateError('empty related illusts');
      }
      final page2 = await client.related(seedId, nextIds: rel.body.nextIds.take(5).toList());
      stdout.writeln(
        '[related-more] count=${page2.body.illusts.length} '
        'ids=${page2.body.illusts.map((t) => t.id).take(5).toList()}',
      );
      if (page2.body.illusts.isEmpty) {
        throw StateError('empty related page 2');
      }
    });

    await check('follow-latest', () async {
      final feed = await client.followLatest(mode: 'all', p: 1);
      stdout.writeln(
        '[follow-latest] pageIds=${feed.body.page.ids.length} '
        'isLastPage=${feed.body.page.isLastPage} '
        'thumbs=${feed.body.thumbnails.illust.length} '
        'firstIds=${feed.body.page.ids.take(3).toList()}',
      );
      if (feed.body.page.ids.isEmpty) {
        throw StateError('empty follow_latest page');
      }
    });

    await check('ranking', () async {
      final rank = await client.ranking(mode: 'daily_r18', content: 'illust', p: 1);
      final types = <String, int>{};
      for (final c in rank.contents) {
        types[c.illustType] = (types[c.illustType] ?? 0) + 1;
      }
      stdout.writeln(
        '[ranking] contents=${rank.contents.length} page=${rank.page} '
        'date=${rank.date} illustType=$types '
        'top3=${rank.contents.take(3).map((c) => c.illustId).toList()}',
      );
      if (rank.contents.isEmpty) {
        throw StateError('empty ranking contents');
      }
    });

    await check('search', () async {
      final search = await client.searchArtworks('R-18', mode: 'r18', sMode: 's_tag', order: 'date_d', p: 1);
      final shist = <int, int>{};
      for (final t in search.body.illustManga.data) {
        shist[t.xRestrict] = (shist[t.xRestrict] ?? 0) + 1;
      }
      stdout.writeln(
        '[search] total=${search.body.illustManga.total} '
        'lastPage=${search.body.illustManga.lastPage} '
        'data=${search.body.illustManga.data.length} xRestrict=$shist '
        'relatedTags=${search.body.relatedTags.length} '
        'firstId=${search.body.illustManga.data.firstOrNull?.id}',
      );
      if (search.body.illustManga.data.isEmpty) {
        throw StateError('empty search data');
      }
    });

    if (seedUserId != null && seedUserId.isNotEmpty) {
      final uid = seedUserId;
      await check('user-full', () async {
        final user = await client.userFull(uid);
        stdout.writeln(
          '[user-full] userId=${user.body.userId} nameLen=${user.body.name.length} '
          'following=${user.body.following} isFollowed=${user.body.isFollowed}',
        );
        if (user.body.userId.isEmpty) {
          throw StateError('empty userFull body');
        }
      });

      await check('user-works-all', () async {
        final works = await client.userWorksAll(uid);
        stdout.writeln(
          '[user-works-all] illusts=${works.body.illustIds.length} '
          'manga=${works.body.mangaIds.length} '
          'novels=${works.body.novelIds.length} '
          'first=${works.body.illustIds.take(3).toList()}',
        );
        if (works.body.illustIds.isEmpty && works.body.mangaIds.isEmpty) {
          throw StateError('empty profile/all ID maps');
        }
      });
    }

    await check('comments', () async {
      final comments = await client.comments(seedId, offset: 0, limit: 3);
      stdout.writeln(
        '[comments] count=${comments.body.comments.length} '
        'hasNext=${comments.body.hasNext} '
        'firstUser=${comments.body.comments.firstOrNull?.userId}',
      );
    });

    await check('csrf-token', () async {
      final ok = await client.ensureCsrfToken();
      stdout.writeln('[csrf-token] acquired=$ok (POST not exercised)');
      if (!ok) {
        throw StateError('CSRF token not acquired');
      }
    });

    if (failures > 0) {
      stderr.writeln('DONE with $failures failure(s)');
      exit(1);
    }
    stdout.writeln('OK');
  } finally {
    client.dispose();
  }
}

extension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
