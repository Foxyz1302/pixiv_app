import 'web/pixiv_web_models.dart';

class RelatedEntry {
  final List<WebDiscoveryIllust> illusts;
  final List<String> nextIds;

  RelatedEntry(this.illusts, this.nextIds);
}

class RelatedCache {
  static const int maxEntries = 20;
  static final Map<String, RelatedEntry> _entries = {};

  static RelatedEntry? get(String id) => _entries[id];

  static void put(String id, List<WebDiscoveryIllust> illusts, List<String> nextIds) {
    if (_entries.containsKey(id)) {
      _entries[id] = RelatedEntry(
        List<WebDiscoveryIllust>.of(illusts),
        List<String>.of(nextIds),
      );
      return;
    }
    while (_entries.length >= maxEntries) {
      _entries.remove(_entries.keys.first);
    }
    _entries[id] = RelatedEntry(
      List<WebDiscoveryIllust>.of(illusts),
      List<String>.of(nextIds),
    );
  }
}
