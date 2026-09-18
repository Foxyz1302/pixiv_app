import 'package:flutter/material.dart';

import 'px_cache.dart';

const artistImageHeaders = {'Referer': 'https://www.pixiv.net/'};

class ArtistContext {
  final String userId;
  final String name;
  final String avatarUrl;
  final List<String>? orderIds;

  const ArtistContext({
    required this.userId,
    this.name = '',
    this.avatarUrl = '',
    this.orderIds,
  });
}

class ArtistAvatar extends StatelessWidget {
  final String url;
  final double radius;

  const ArtistAvatar({super.key, required this.url, this.radius = 16});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      backgroundImage: url.isEmpty
          ? null
          : PxImageProvider(
              url,
              headers: artistImageHeaders,
              cacheManager: PxCache.instance.thumbs,
            ),
      onBackgroundImageError: (_, _) {},
      child: url.isEmpty ? Icon(Icons.person, size: radius) : null,
    );
  }
}
