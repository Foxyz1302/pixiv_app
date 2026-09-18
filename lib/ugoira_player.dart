import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:koni_archive/io.dart';

import 'api_cache.dart';
import 'px_cache.dart';
import 'web/pixiv_web_models.dart';
import 'web_session.dart';

class UgoiraSessionStore {
  static final UgoiraSessionStore instance = UgoiraSessionStore._();
  UgoiraSessionStore._();

  static const maxEntries = 2;

  final _metas = <String, List<WebUgoiraFrame>>{};
  final _frames = <String, List<Uint8List>>{};
  final _expected = <String, List<int>>{};
  final _totals = <String, int>{};
  final _order = <String>[];

  bool sameMeta(String id, List<WebUgoiraFrame> meta) {
    final stored = _metas[id];
    if (stored == null || stored.length != meta.length) return false;
    for (var i = 0; i < meta.length; i++) {
      if (stored[i].file != meta[i].file) return false;
    }
    return true;
  }

  void restore(
    String id,
    List<Uint8List> frames,
    List<int> expected,
  ) {
    frames.addAll(_frames[id] ?? const []);
    expected.addAll(_expected[id] ?? const []);
    _touch(id);
  }

  int totalFor(String id) => _totals[id] ?? 0;

  void store(
    String id,
    List<WebUgoiraFrame> meta,
    List<Uint8List> frames,
    List<int> expected,
    int total,
  ) {
    _metas[id] = List.of(meta);
    _frames[id] = List.of(frames);
    _expected[id] = List.of(expected);
    _totals[id] = total;
    _touch(id);
    while (_order.length > maxEntries) {
      final evicted = _order.removeAt(0);
      _metas.remove(evicted);
      _frames.remove(evicted);
      _expected.remove(evicted);
      _totals.remove(evicted);
    }
  }

  void _touch(String id) {
    _order.remove(id);
    _order.add(id);
  }
}

class UgoiraPlayer extends StatefulWidget {
  final String illustId;
  final String posterUrl;
  final bool active;
  final bool preload;

  const UgoiraPlayer({
    super.key,
    required this.illustId,
    this.posterUrl = '',
    this.active = true,
    this.preload = false,
  });

  @override
  State<UgoiraPlayer> createState() => _UgoiraPlayerState();
}

class _UgoiraPlayerState extends State<UgoiraPlayer> {
  List<WebUgoiraFrame> _meta = const [];
  final List<Uint8List> _frames = [];
  final List<int> _frameExpected = [];
  int _partialBytes = 0;
  int _totalBytes = 0;
  DateTime _lastProgressPaint = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime? _nextFire;
  DateTime? _lastFire;
  int _index = 0;
  bool _playing = true;
  bool _done = false;
  String? _failure;
  bool _dead = false;
  Timer? _timer;
  Archive? _archive;
  int _gen = 0;
  bool _started = false;
  bool _loading = false;
  bool _cancelled = false;
  bool _everActive = false;

  @override
  void initState() {
    super.initState();
    _everActive = widget.active;
    if (widget.active || widget.preload) {
      _beginLoad();
    }
  }

  void _refresh() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void didUpdateWidget(UgoiraPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !oldWidget.active) {
      _everActive = true;
      if (!_cancelled) {
        if (!_started || (!_loading && !_done && _failure == null)) {
          _beginLoad();
        }
        _schedule();
      }
      _refresh();
    } else if (!widget.active && oldWidget.active) {
      _timer?.cancel();
      _timer = null;
      _playing = false;
      if (_loading) {
        _gen++;
        _loading = false;
        _cancelled = true;
        _partialBytes = 0;
      }
      _nextFire = null;
      _refresh();
    } else if (!widget.active &&
        !widget.preload &&
        oldWidget.preload &&
        !_everActive &&
        _loading) {
      _gen++;
      _loading = false;
      _partialBytes = 0;
      _refresh();
    } else if (!widget.active &&
        widget.preload &&
        !oldWidget.preload &&
        !_started &&
        !_cancelled &&
        !_loading &&
        !_done) {
      _beginLoad();
      _refresh();
    }
  }

  @override
  void dispose() {
    _dead = true;
    _timer?.cancel();
    _archive?.close();
    super.dispose();
  }

  void _beginLoad() {
    if (_loading) return;
    _started = true;
    _loading = true;
    _gen++;
    _load(_gen);
  }

  Future<void> _load(int gen) async {
    try {
      if (_meta.isEmpty || _archive == null) {
        final meta = await ApiCache.instance.ugoiraMeta(
          widget.illustId,
        );
        if (gen != _gen || _dead) return;
        if (meta.body.frames.isEmpty) throw StateError('empty ugoira meta');
        if (UgoiraSessionStore.instance.sameMeta(widget.illustId, meta.body.frames)) {
          UgoiraSessionStore.instance.restore(widget.illustId, _frames, _frameExpected);
          if (gen != _gen || _dead) return;
          setState(() {
            _meta = meta.body.frames;
            _totalBytes = UgoiraSessionStore.instance.totalFor(widget.illustId);
          });
          if (_frames.length >= _meta.length) {
            _loading = false;
            if (mounted) setState(() => _done = true);
            _lastFire = null;
            _nextFire = null;
            _schedule();
            return;
          }
        }
        final zipUrl = meta.body.originalSrc.isNotEmpty
            ? meta.body.originalSrc
            : meta.body.src;
        final file = await PxCache.instance.ugoira.getSingleFile(zipUrl, headers: pxImageHeaders);
        if (gen != _gen || _dead) return;
        final source = await FileByteSource.open(file.path);
        if (gen != _gen || _dead) {
          await source.close();
          return;
        }
        final archive = await Archive.open(source);
        if (gen != _gen || _dead) {
          await archive.close();
          return;
        }
        _archive = archive;
        var totalBytes = 0;
        for (final frame in meta.body.frames) {
          totalBytes += archive.entry(frame.file)?.uncompressedSize ?? 0;
        }
        if (gen != _gen || _dead) return;
        setState(() {
          _meta = meta.body.frames;
          _totalBytes = totalBytes;
        });
      }
      final archive = _archive!;
      for (var i = _frames.length; i < _meta.length; i++) {
        if (gen != _gen || _dead) return;
        final entry = archive.entry(_meta[i].file);
        if (entry == null) {
          debugPrint(
            'ugoira missing entry ${widget.illustId}: ${_meta[i].file}',
          );
          continue;
        }
        try {
          final builder = BytesBuilder();
          var received = 0;
          await for (final chunk in archive.openRead(entry)) {
            if (gen != _gen || _dead) return;
            builder.add(chunk);
            received += chunk.length;
            final now = DateTime.now();
            if (now.difference(_lastProgressPaint).inMilliseconds >= 80) {
              _lastProgressPaint = now;
              if (mounted) setState(() => _partialBytes = received);
            }
          }
          if (gen != _gen || _dead) return;
          final bytes = builder.takeBytes();
          _frames.add(bytes);
          _frameExpected.add(
            entry.uncompressedSize > 0 ? entry.uncompressedSize : bytes.length,
          );
          _partialBytes = 0;
          UgoiraSessionStore.instance.store(
            widget.illustId,
            _meta,
            _frames,
            _frameExpected,
            _totalBytes,
          );
          if (_frames.length == 1) {
            _lastFire = null;
            _nextFire = null;
            _schedule();
          } else if (_playing && (_timer == null || !_timer!.isActive)) {
            _nextFire = null;
            _schedule();
          }
          if (mounted) setState(() {});
        } catch (e) {
          if (gen != _gen || _dead) return;
          debugPrint('ugoira frame failed ${widget.illustId} #$i: $e');
        }
      }
      if (gen != _gen || _dead) return;
      _loading = false;
      if (mounted) setState(() => _done = true);
    } catch (e, stack) {
      if (gen != _gen) return;
      debugPrint('ugoira failed ${widget.illustId}: $e\n$stack');
      if (_dead || !mounted) return;
      _loading = false;
      setState(() => _failure = e.toString());
    }
  }

  Duration _delayFor(int index) {
    final delay = _meta[index % _meta.length].delay;
    return Duration(milliseconds: delay <= 0 ? 50 : delay);
  }

  void _schedule() {
    _timer?.cancel();
    if (_dead ||
        !_playing ||
        !widget.active ||
        _frames.isEmpty ||
        _meta.isEmpty) {
      return;
    }
    final now = DateTime.now();
    _nextFire ??= now.add(_delayFor(_index));
    if (_nextFire!.isBefore(now.subtract(const Duration(milliseconds: 500)))) {
      _nextFire = now.add(_delayFor(_index));
    }
    var wait = _nextFire!.difference(now);
    if (wait.isNegative) wait = Duration.zero;
    _timer = Timer(wait, _tick);
  }

  void _tick() {
    if (_dead || !_playing || !widget.active || _frames.isEmpty) return;
    final now = DateTime.now();
    if (_lastFire != null) {
      final expected = _delayFor(_index).inMilliseconds;
      final actual = now.difference(_lastFire!).inMilliseconds;
      if ((actual - expected).abs() > expected ~/ 5 + 15) {
        debugPrint(
          'ugoira timing ${widget.illustId} #$_index '
          'expected ${expected}ms actual ${actual}ms',
        );
      }
    }
    _lastFire = now;
    if (_index + 1 < _frames.length) {
      setState(() => _index++);
      _nextFire = (_nextFire ?? now).add(_delayFor(_index));
      _schedule();
    } else if (_done) {
      setState(() => _index = 0);
      _nextFire = (_nextFire ?? now).add(_delayFor(_index));
      _schedule();
    } else {
      _nextFire = now.add(const Duration(milliseconds: 120));
      _pollFrontier();
    }
  }

  void _pollFrontier() {
    _timer?.cancel();
    if (_dead || !_playing || !widget.active) return;
    var wait = _nextFire!.difference(DateTime.now());
    if (wait.isNegative) wait = Duration.zero;
    _timer = Timer(wait, () {
      if (_dead || !_playing || !widget.active) return;
      if (_frames.length > _index + 1) {
        if (mounted) setState(() => _index++);
        _lastFire = null;
        _nextFire = null;
        _schedule();
      } else if (!_done) {
        _nextFire = DateTime.now().add(const Duration(milliseconds: 120));
        _pollFrontier();
      } else {
        _lastFire = null;
        _nextFire = null;
        _schedule();
      }
    });
  }

  void _onTap() {
    if (_failure != null) return;
    if (_cancelled) {
      _cancelled = false;
      _playing = true;
      _lastFire = null;
      _nextFire = null;
      if (!_loading && !_done) {
        _beginLoad();
      } else {
        _schedule();
      }
      if (mounted) setState(() {});
      return;
    }
    if (_frames.isEmpty) return;
    _toggle();
  }

  void _toggle() {
    setState(() => _playing = !_playing);
    if (_playing) {
      _index = _frames.isEmpty ? 0 : _index % _frames.length;
      _lastFire = null;
      _nextFire = null;
      _schedule();
    } else {
      _timer?.cancel();
      _timer = null;
      _nextFire = null;
    }
  }

  void _retry() {
    _timer?.cancel();
    _timer = null;
    _gen++;
    _loading = false;
    _archive?.close();
    _archive = null;
    setState(() {
      _meta = const [];
      _frames.clear();
      _frameExpected.clear();
      _partialBytes = 0;
      _totalBytes = 0;
      _nextFire = null;
      _lastFire = null;
      _index = 0;
      _playing = true;
      _done = false;
      _failure = null;
      _cancelled = false;
    });
    _beginLoad();
  }

  double _loadedFraction() {
    if (_meta.isEmpty) return 0;
    if (_totalBytes > 0) {
      var done = _partialBytes;
      for (final expected in _frameExpected) {
        done += expected;
      }
      return done / _totalBytes;
    }
    return _frames.length / _meta.length;
  }

  double _playedFraction() {
    if (_meta.isEmpty) return 0;
    if (_totalBytes > 0) {
      var done = 0;
      for (var i = 0; i < _index && i < _frameExpected.length; i++) {
        done += _frameExpected[i];
      }
      return done / _totalBytes;
    }
    return _index / _meta.length;
  }

  @override
  Widget build(BuildContext context) {
    if (_failure != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Text(_failure!),
            FilledButton(onPressed: _retry, child: const Text('Retry')),
          ],
        ),
      );
    }
    if (_frames.isEmpty) {
      final loaded = _loadedFraction().clamp(0.0, 1.0);
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (widget.posterUrl.isNotEmpty)
              Image(
                image: PxImageProvider(widget.posterUrl, headers: pxImageHeaders),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            if (_cancelled)
              const Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.play_arrow,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            else
              const Center(
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: 3,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(height: 3, color: Colors.white24),
                    FractionallySizedBox(
                      widthFactor: loaded,
                      child: Container(height: 3, color: Colors.white38),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    final holding = _playing && !_done && _index >= _frames.length - 1;
    final loaded = _loadedFraction().clamp(0.0, 1.0);
    final played = _playedFraction().clamp(0.0, 1.0);
    Widget? glyph;
    if (holding) {
      glyph = const SizedBox(
        width: 14,
        height: 14,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    } else if (!_playing || _cancelled) {
      glyph = const Icon(Icons.play_arrow, size: 22, color: Colors.white);
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.memory(
            _frames[_index % _frames.length],
            fit: BoxFit.contain,
            gaplessPlayback: true,
            errorBuilder: (context, error, stackTrace) {
              debugPrint(
                'ugoira decode failed ${widget.illustId} #$_index: $error',
              );
              return const Icon(Icons.broken_image);
            },
          ),
          if (glyph != null)
            Center(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.black38,
                  shape: BoxShape.circle,
                ),
                child: Padding(padding: const EdgeInsets.all(6), child: glyph),
              ),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 3,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(height: 3, color: Colors.white24),
                  FractionallySizedBox(
                    widthFactor: loaded,
                    child: Container(height: 3, color: Colors.white38),
                  ),
                  FractionallySizedBox(
                    widthFactor: played,
                    child: Container(height: 3, color: Colors.lightBlueAccent),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
