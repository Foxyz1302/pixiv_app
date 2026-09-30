import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'artist_context.dart';
import 'detail_screen.dart';
import 'api_cache.dart';
import 'feed_screen.dart';
import 'web/pixiv_web_models.dart';
import 'web_session.dart';

int _numericId(String id) => int.tryParse(id) ?? -1;

class ArtistScreen extends StatefulWidget {
  final String userId;
  final String? initialName;
  final String? initialAvatarUrl;
  final WebUserFull? initialUser;
  final List<String>? initialOrderIds;
  final List<String>? initialIllustIds;
  final List<String>? initialMangaIds;
  final Map<String, WebDiscoveryIllust>? initialWorks;

  const ArtistScreen({
    super.key,
    required this.userId,
    this.initialName,
    this.initialAvatarUrl,
    this.initialUser,
    this.initialOrderIds,
    this.initialIllustIds,
    this.initialMangaIds,
    this.initialWorks,
  });

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  static const _chunkSize = 48;

  WebUserFull? _user;
  bool _userFailed = false;
  List<WebDiscoveryIllust> _works = [];
  List<String> _orderIds = [];
  List<String> _allIllustIds = [];
  List<String> _allMangaIds = [];
  List<String> _pendingIds = [];
  int _illustCount = 0;
  int _mangaCount = 0;
  bool _worksLoading = true;
  bool _loadingMore = false;
  String? _worksFailure;

  @override
  void initState() {
    super.initState();
    if (widget.initialUser != null) {
      _user = widget.initialUser;
    } else {
      _fetchUser();
    }
    if (widget.initialOrderIds != null &&
        widget.initialOrderIds!.isNotEmpty &&
        widget.initialIllustIds != null &&
        widget.initialMangaIds != null) {
      _seedFromInitial();
    } else {
      _fetchWorks();
    }
  }

  Future<void> _fetchUser() async {
    try {
      final user = (await ApiCache.instance.userFull(widget.userId)).body;
      if (!mounted) return;
      setState(() => _user = user);
    } catch (e, stack) {
      debugPrint('artist user failed ${widget.userId}: $e\n$stack');
      if (!mounted) return;
      setState(() => _userFailed = true);
    }
  }

  Future<Map<String, WebDiscoveryIllust>> _hydrateChunk(
    String userId,
    List<String> ids,
    List<String> illustIds,
    List<String> mangaIds,
  ) async {
    final cached = ApiCache.instance.getCachedWorks(ids);
    final missing = ids.where((id) => !cached.containsKey(id)).toList();
    if (missing.isEmpty) return cached;
    final illustChunk = missing.where(illustIds.contains).toList();
    final mangaChunk = missing.where(mangaIds.contains).toList();
    final results = await Future.wait([
      illustChunk.isEmpty
          ? Future.value(
              WebUserProfileWorksResponse(false, body: WebUserProfileWorksBody()),
            )
          : ApiCache.instance.userProfileWorks(userId, illustChunk),
      mangaChunk.isEmpty
          ? Future.value(
              WebUserProfileWorksResponse(false, body: WebUserProfileWorksBody()),
            )
          : ApiCache.instance.userProfileWorks(
              userId,
              mangaChunk,
              workCategory: 'manga',
            ),
    ]);
    return <String, WebDiscoveryIllust>{
      ...cached,
      ...(results[0] as WebUserProfileWorksResponse).body.works,
      ...(results[1] as WebUserProfileWorksResponse).body.works,
    };
  }

  Future<void> _seedFromInitial() async {
    final order = List<String>.of(widget.initialOrderIds!);
    final illustIds = List<String>.of(widget.initialIllustIds!);
    final mangaIds = List<String>.of(widget.initialMangaIds!);
    final seeded = Map<String, WebDiscoveryIllust>.of(widget.initialWorks ?? {});
    setState(() {
      _allIllustIds = illustIds;
      _allMangaIds = mangaIds;
      _illustCount = illustIds.length;
      _mangaCount = mangaIds.length;
      _pendingIds = order.skip(_chunkSize.clamp(0, order.length)).toList();
    });
    final first = order.take(_chunkSize).toList();
    try {
      final byId = Map<String, WebDiscoveryIllust>.of(seeded);
      final missing = first.where((id) => !byId.containsKey(id)).toList();
      if (missing.isNotEmpty) {
        final fresh = await _hydrateChunk(widget.userId, missing, illustIds, mangaIds);
        byId.addAll(fresh);
      }
      if (!mounted) return;
      setState(() {
        _works = [for (final id in first) if (byId[id] != null) byId[id]!];
        _orderIds = [for (final w in _works) w.id];
        _worksLoading = false;
      });
      if (_pendingIds.isNotEmpty) _loadMoreChunk();
    } catch (e, stack) {
      debugPrint('artist seed failed ${widget.userId}: $e\n$stack');
      if (!mounted) return;
      setState(() {
        _works = [for (final id in first) if (seeded[id] != null) seeded[id]!];
        _orderIds = [for (final w in _works) w.id];
        _worksLoading = _works.isEmpty;
        _worksFailure = _works.isEmpty ? e.toString() : null;
      });
    }
  }

  Future<void> _fetchWorks() async {
    final userId = widget.userId;
    try {
      final all = (await ApiCache.instance.userWorksAll(userId)).body;
      if (!mounted) return;
      final illustIds = all.illustIds;
      final mangaIds = all.mangaIds;
      final order = [...illustIds, ...mangaIds]
        ..sort((a, b) => _numericId(b).compareTo(_numericId(a)));
      setState(() {
        _allIllustIds = illustIds;
        _allMangaIds = mangaIds;
        _illustCount = illustIds.length;
        _mangaCount = mangaIds.length;
        _pendingIds = order.sublist(_chunkSize.clamp(0, order.length));
      });
      final first = order.take(_chunkSize).toList();
      final byId = await _hydrateChunk(userId, first, illustIds, mangaIds);
      if (!mounted) return;
      setState(() {
        _works = [for (final id in first) if (byId[id] != null) byId[id]!];
        _orderIds = [for (final w in _works) w.id];
        _worksLoading = false;
      });
      if (_pendingIds.isNotEmpty) _loadMoreChunk();
    } catch (e, stack) {
      debugPrint('artist works failed $userId: $e\n$stack');
      if (!mounted) return;
      setState(() {
        _worksLoading = false;
        _worksFailure = e.toString();
      });
    }
  }

  Future<void> _loadMoreChunk() async {
    if (_loadingMore || _pendingIds.isEmpty) return;
    final userId = widget.userId;
    setState(() => _loadingMore = true);
    try {
      final chunk = _pendingIds.take(_chunkSize).toList();
      final byId = await _hydrateChunk(userId, chunk, _allIllustIds, _allMangaIds);
      if (!mounted) return;
      setState(() {
        _works = [..._works, for (final id in chunk) if (byId[id] != null) byId[id]!];
        _orderIds = [for (final w in _works) w.id];
        _pendingIds = _pendingIds.skip(chunk.length).toList();
        _loadingMore = false;
      });
    } catch (e, stack) {
      debugPrint('artist chunk failed $userId: $e\n$stack');
      if (!mounted) return;
      setState(() => _loadingMore = false);
    }
  }

  void _retryWorks() {
    setState(() {
      _worksLoading = true;
      _worksFailure = null;
    });
    _fetchWorks();
  }

  void _openWork(int index) {
    final items = List<WebDiscoveryIllust>.of(_works);
    final user = _user;
    final fullOrder = [..._allIllustIds, ..._allMangaIds]..sort((a, b) => _numericId(b).compareTo(_numericId(a)));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetailScreen(
          items: items,
          initialIndex: index,
          artist: ArtistContext(
            userId: widget.userId,
            name: user?.name ?? widget.initialName ?? '',
            avatarUrl: _avatarUrl,
            orderIds: fullOrder.isNotEmpty ? fullOrder : List<String>.of(_orderIds),
          ),
        ),
      ),
    );
  }

  String get _avatarUrl {
    final user = _user;
    if (user != null && user.imageBig.isNotEmpty) return user.imageBig;
    if (user != null && user.image.isNotEmpty) return user.image;
    return widget.initialAvatarUrl ?? '';
  }

  String get _displayName {
    final user = _user;
    if (user != null && user.name.isNotEmpty) return user.name;
    return widget.initialName ?? 'Artist';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final nothingYet =
        _worksLoading && _works.isEmpty && _user == null && !_userFailed && _worksFailure == null;
    if (nothingYet) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 168,
            leading: const BackButton(),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _displayName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              titlePadding: const EdgeInsetsDirectional.only(start: 56, bottom: 14),
              background: Padding(
                padding: const EdgeInsets.fromLTRB(16, 64, 16, 50),
                child: _headerBody(scheme),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Text(
                _worksLoading
                    ? 'Illustrations and Manga…'
                    : 'Illustrations and Manga (${_works.length})',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          if (_worksLoading)
            SliverToBoxAdapter(child: _worksProgress(scheme))
          else if (_worksFailure != null && _works.isEmpty)
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      Text(_worksFailure!),
                      FilledButton(onPressed: _retryWorks, child: const Text('Retry')),
                    ],
                  ),
                ),
              ),
            )
          else if (_works.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: Text('No works')),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
              sliver: SliverWaterfallFlow(
                gridDelegate: const SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 160,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == _works.length) {
                      if (_pendingIds.isEmpty) return const SizedBox.shrink();
                      if (_loadingMore) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: OutlinedButton(
                            onPressed: _loadMoreChunk,
                            child: Text('Load more (${_works.length} of ${_illustCount + _mangaCount})'),
                          ),
                        ),
                      );
                    }
                    return FeedTile(
                      illust: _works[index],
                      onTap: () => _openWork(index),
                    );
                  },
                  childCount: _works.length + 1,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _headerBody(ColorScheme scheme) {
    final user = _user;
    if (user == null) {
      final knownTotal = _illustCount + _mangaCount;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          ArtistAvatar(url: _avatarUrl, radius: 28),
          Expanded(
            child: Text(
              knownTotal > 0
                  ? '$_illustCount illustrations · $_mangaCount manga'
                  : 'Loading artist…',
              style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ArtistAvatar(url: _avatarUrl, radius: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$_illustCount illustrations · $_mangaCount manga',
                style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
              ),
              if (user.comment.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    user.comment,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        FilledButton.tonal(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Following artists coming soon')),
          ),
          child: Text(user.isFollowed ? 'Following' : 'Follow'),
        ),
      ],
    );
  }

  Widget _worksProgress(ColorScheme scheme) {
    final total = _illustCount + _mangaCount;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          const SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          Text(
            total > 0 ? 'Loading $total works…' : 'Loading works…',
            style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
