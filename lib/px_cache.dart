import 'dart:async';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'web_session.dart';

const pxImageHeaders = {'Referer': 'https://www.pixiv.net/'};

class PxFileService extends FileService {
  Dio get _dio => WebSession.instance.dio;

  final Map<String, CancelToken> _activeTokens = {};
  final Map<String, int> _requestSeq = {};

  void cancelRequest(String url) {
    _requestSeq[url] = (_requestSeq[url] ?? 0) + 1;
    _activeTokens.remove(url)?.cancel();
  }

  @override
  Future<FileServiceResponse> get(String url, {Map<String, String>? headers}) async {
    final seq = (_requestSeq[url] ?? 0) + 1;
    _requestSeq[url] = seq;
    final token = CancelToken();
    _activeTokens[url] = token;
    try {
      final response = await _dio.get<ResponseBody>(
        url,
        options: Options(headers: headers, responseType: ResponseType.stream),
        cancelToken: token,
      );
      return _PxFileServiceResponse(response);
    } finally {
      if (_requestSeq[url] == seq && _activeTokens[url] == token) {
        _activeTokens.remove(url);
      }
    }
  }
}

class _PxFileServiceResponse implements FileServiceResponse {
  final Response<ResponseBody> _response;

  _PxFileServiceResponse(this._response);

  @override
  Stream<List<int>> get content => _response.data!.stream;

  @override
  int? get contentLength {
    final value = _response.headers.value('content-length');
    return value == null ? null : int.tryParse(value);
  }

  @override
  String? get eTag => _response.headers.value('etag');

  @override
  String get fileExtension {
    final contentType = _response.headers.value('content-type');
    if (contentType != null) {
      final ext = _extensionFromMime(contentType.split(';').first.trim().toLowerCase());
      if (ext != null) return ext;
    }
    return '.bin';
  }

  @override
  int get statusCode => _response.statusCode ?? 200;

  @override
  DateTime get validTill {
    final cacheControl = _response.headers.value('cache-control');
    if (cacheControl != null) {
      final match = RegExp(r'max-age=(\d+)').firstMatch(cacheControl);
      if (match != null) {
        final seconds = int.tryParse(match.group(1)!);
        if (seconds != null && seconds > 0) {
          return DateTime.now().add(Duration(seconds: seconds));
        }
      }
    }
    return DateTime.now().add(const Duration(days: 30));
  }

  static String? _extensionFromMime(String mime) {
    switch (mime) {
      case 'image/jpeg':
        return '.jpg';
      case 'image/png':
        return '.png';
      case 'image/gif':
        return '.gif';
      case 'image/webp':
        return '.webp';
      default:
        return null;
    }
  }
}

class PxCache {
  static final PxCache instance = PxCache._();
  PxCache._();

  late final PxFileService fileService = PxFileService();

  late final CacheManager thumbs = CacheManager(
    Config(
      'px_thumbs',
      stalePeriod: const Duration(days: 30),
      maxNrOfCacheObjects: 1000,
      fileService: fileService,
    ),
  );

  late final CacheManager fulls = CacheManager(
    Config(
      'px_fulls',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
      fileService: fileService,
    ),
  );

  late final CacheManager ugoira = CacheManager(
    Config(
      'px_ugoira',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 30,
      fileService: fileService,
    ),
  );

  void cancelDownload(String url) => fileService.cancelRequest(url);
}

@immutable
class PxImageProvider extends ImageProvider<PxImageProvider> {
  final String url;
  final Map<String, String>? headers;
  final CacheManager? cacheManager;
  final int reloadToken;

  PxImageProvider(
    this.url, {
    this.headers,
    this.cacheManager,
    this.reloadToken = 0,
  });

  CacheManager get _manager => cacheManager ?? PxCache.instance.fulls;

  @override
  Future<PxImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture(this);
  }

  @override
  ImageStreamCompleter loadImage(PxImageProvider key, ImageDecoderCallback decode) {
    final chunkEvents = StreamController<ImageChunkEvent>();
    final codec = _loadAsync(key, decode, chunkEvents);
    final completer = MultiFrameImageStreamCompleter(
      codec: codec,
      chunkEvents: chunkEvents.stream,
      scale: 1.0,
      debugLabel: key.url,
    );
    completer.addOnLastListenerRemovedCallback(() {
      PxCache.instance.cancelDownload(key.url);
    });
    return completer;
  }

  Future<ui.Codec> _loadAsync(
    PxImageProvider key,
    ImageDecoderCallback decode,
    StreamController<ImageChunkEvent> chunkEvents,
  ) async {
    try {
      final stream = key._manager.getFileStream(
        key.url,
        headers: key.headers,
        withProgress: true,
      );
      await for (final response in stream) {
        if (response is DownloadProgress) {
          chunkEvents.add(
            ImageChunkEvent(
              cumulativeBytesLoaded: response.downloaded,
              expectedTotalBytes: response.totalSize,
            ),
          );
        } else if (response is FileInfo) {
          await chunkEvents.close();
          return await decode(await ui.ImmutableBuffer.fromFilePath(response.file.path));
        }
      }
      throw StateError('Image stream ended without a file: ${key.url}');
    } catch (e) {
      await chunkEvents.close();
      scheduleMicrotask(() {
        PaintingBinding.instance.imageCache.evict(key);
      });
      rethrow;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PxImageProvider &&
          url == other.url &&
          reloadToken == other.reloadToken;

  @override
  int get hashCode => Object.hash(url, reloadToken);
}
