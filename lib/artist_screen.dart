import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'artist_context.dart';
import 'detail_screen.dart';
import 'feed_screen.dart';
import 'web/pixiv_web_models.dart';
import 'web_session.dart';

int _numericId(String id) => int.tryParse(id) ?? -1;

class ArtistScreen extends StatefulWidget {
  final String userId;
  final String? initialName;
  final String? initialAvatarUrl;

  const ArtistScreen({
    super.key,
    required this.userId,
    this.initialName,
    this.initialAvatarUrl,
  });

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  WebUserFull? _user;
  bool _userFailed = false;
  List<WebDiscoveryIllust> _works = [];
  List<String> _orderIds = [];
  int _illustCount = 0;
  int _mangaCount = 0;
  bool _worksLoading = true;
  String? _worksFailure;

  @override
  void initState() {
    super.initState();
    _fetchUser();
    _fetchWorks();
  }

  Future<void> _fetchUser() async {
    try {
      final user = (await WebSession.instance.client.userFull(widget.userId)).body;
      if (!mounted) return;
      setState(() => _user = user);
    } catch (e, stack) {
      debugPrint('artist user failed ${widget.userId}: $e\n$stack');
      if (!mounted) return;
      setState(() => _userFailed = true);
    }
  }

  Future<void> _fetchWorks() async {
    final userId = widget.userId;
    try {
      final all = (await WebSession.instance.client.userWorksAll(userId)).body;
      if (!mounted) return;
      final illustIds = all.illustIds;
      final mangaIds = all.mangaIds;
      setState(() {
        _illustCount = illustIds.length;
        _mangaCount = mangaIds.length;
      });
      final results2 = await Future.wait([
        illustIds.isEmpty
            ? Future.value(
                WebUserProfileWorksResponse(false, body: WebUserProfileWorksBody()),
              )
            : WebSession.instance.client.userProfileWorks(userId, illustIds),
        mangaIds.isEmpty
            ? Future.value(
                WebUserProfileWorksResponse(false, body: WebUserProfileWorksBody()),
              )
            : WebSession.instance.client.userProfileWorks(
                userId,
                mangaIds,
                workCategory: 'manga',
              ),
      ]);
      if (!mounted) return;
      final worksById = <String, WebDiscoveryIllust>{
        ...(results2[0] as WebUserProfileWorksResponse).body.works,
        ...(results2[1] as WebUserProfileWorksResponse).body.works,
      };
      final works = [
        for (final id in [...illustIds, ...mangaIds])
          if (worksById[id] != null) worksById[id]!,
      ]..sort((a, b) => _numericId(b.id).compareTo(_numericId(a.id)));
      setState(() {
        _works = works;
        _orderIds = [for (final w in works) w.id];
        _worksLoading = false;
      });
    } catch (e, stack) {
      debugPrint('artist works failed $userId: $e\n$stack');
      if (!mounted) return;
      setState(() {
        _worksLoading = false;
        _worksFailure = e.toString();
      });
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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetailScreen(
          items: items,
          initialIndex: index,
          artist: ArtistContext(
            userId: widget.userId,
            name: user?.name ?? widget.initialName ?? '',
            avatarUrl: _avatarUrl,
            orderIds: List<String>.of(_orderIds),
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
            expandedHeight: 200,
            leading: const BackButton(),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(_displayName, overflow: TextOverflow.ellipsis),
              titlePadding: const EdgeInsetsDirectional.only(start: 56, bottom: 16),
              background: Padding(
                padding: const EdgeInsets.fromLTRB(16, 76, 16, 56),
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
                    children: [
                      Text(_worksFailure!),
                      const SizedBox(height: 8),
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
                  (context, index) => FeedTile(
                    illust: _works[index],
                    onTap: () => _openWork(index),
                  ),
                  childCount: _works.length,
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
        children: [
          ArtistAvatar(url: _avatarUrl, radius: 28),
          const SizedBox(width: 12),
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
        children: [
          const SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          const SizedBox(height: 12),
          Text(
            total > 0 ? 'Loading $total works…' : 'Loading works…',
            style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
