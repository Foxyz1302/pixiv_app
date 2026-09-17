import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:signals/signals_flutter.dart';

import 'web/pixiv_web_client.dart';

class WebSession {
  static final WebSession instance = WebSession._();
  WebSession._();

  static const String _boxName = 'pixiv_web';
  static const String _cookieKey = 'cookie';
  static const String _tileWidthKey = 'tileWidth';
  static const double minTileWidth = 140;
  static const double maxTileWidth = 480;
  static const double defaultTileWidth = 280;

  late final Box _box;
  late final Dio dio;
  late final PixivWebClient client;

  final cookie = signal('');
  final tileWidth = signal(defaultTileWidth);

  late final Computed<bool> loggedIn = computed(() => cookie.value.isNotEmpty);

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
    dio = Dio(
      BaseOptions(
        baseUrl: PixivWebClient.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'User-Agent': PixivWebClient.userAgent,
          'Referer': PixivWebClient.defaultReferer,
          'Accept': 'application/json',
        },
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final current = cookie.peek();
          if (current.isNotEmpty) {
            options.headers['Cookie'] = current;
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          _captureSetCookie(response.headers);
          handler.next(response);
        },
        onError: (error, handler) {
          final response = error.response;
          if (response != null) {
            _captureSetCookie(response.headers);
          }
          handler.next(error);
        },
      ),
    );
    client = PixivWebClient(dio: dio);
    final stored = _box.get(_cookieKey, defaultValue: '') as String;
    if (stored.isNotEmpty) {
      cookie.value = stored;
      dio.options.headers['Cookie'] = stored;
    }
    final storedWidth = _box.get(_tileWidthKey, defaultValue: defaultTileWidth);
    tileWidth.value = storedWidth is num
        ? storedWidth.toDouble().clamp(minTileWidth, maxTileWidth).toDouble()
        : defaultTileWidth;
  }

  void setCookie(String raw) {
    final header = _normalize(raw);
    if (header.isEmpty) return;
    cookie.value = header;
    dio.options.headers['Cookie'] = header;
    _box.put(_cookieKey, header);
  }

  void clear() {
    cookie.value = '';
    dio.options.headers.remove('Cookie');
    _box.delete(_cookieKey);
  }

  void setTileWidth(double width) {
    final clamped = width.clamp(minTileWidth, maxTileWidth).toDouble();
    tileWidth.value = clamped;
    _box.put(_tileWidthKey, clamped);
  }

  String _normalize(String raw) {
    final trimmed = raw.trim().replaceAll('"', '');
    if (trimmed.isEmpty) return '';
    if (trimmed.contains('=')) return trimmed;
    return 'PHPSESSID=$trimmed';
  }

  void _captureSetCookie(Headers headers) {
    final updates = <String, String?>{};
    for (final entry in headers.map.entries) {
      if (entry.key.toLowerCase() != 'set-cookie') continue;
      for (final raw in entry.value) {
        final first = raw.split(';').first;
        final eq = first.indexOf('=');
        if (eq <= 0) continue;
        final name = first.substring(0, eq).trim();
        if (name.isEmpty) continue;
        updates[name] = first.substring(eq + 1).trim();
      }
    }
    if (updates.isEmpty) return;
    _mergeCookies(updates);
  }

  void _mergeCookies(Map<String, String?> updates) {
    final pairs = <String>[];
    final indexByName = <String, int>{};
    final current = cookie.peek();
    if (current.isNotEmpty) {
      for (final part in current.split(';')) {
        final eq = part.indexOf('=');
        if (eq <= 0) continue;
        final name = part.substring(0, eq).trim();
        if (name.isEmpty) continue;
        indexByName[name] = pairs.length;
        pairs.add('$name=${part.substring(eq + 1).trim()}');
      }
    }
    var changed = false;
    updates.forEach((name, value) {
      final existing = indexByName[name];
      if (value == null || value.isEmpty) {
        if (existing != null) {
          pairs.removeAt(existing);
          indexByName.clear();
          for (var i = 0; i < pairs.length; i++) {
            final eq = pairs[i].indexOf('=');
            if (eq > 0) indexByName[pairs[i].substring(0, eq).trim()] = i;
          }
          changed = true;
        }
        return;
      }
      final entry = '$name=$value';
      if (existing == null) {
        indexByName[name] = pairs.length;
        pairs.add(entry);
        changed = true;
      } else if (pairs[existing] != entry) {
        pairs[existing] = entry;
        changed = true;
      }
    });
    if (!changed) return;
    final header = pairs.join('; ');
    cookie.value = header;
    dio.options.headers['Cookie'] = header;
    _box.put(_cookieKey, header);
    debugPrint('session cookies updated: ${updates.keys.join(',')}');
  }
}
