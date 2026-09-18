# Image + ugoira caching (implemented — keep this doc in sync)

Disk caching is live (`lib/px_cache.dart`, `lib/api_cache.dart`). No
`cached_network_image` anywhere — deliberate: the app uses its own
`PxImageProvider` over a Dio-backed `PxFileService`, same shape as the
niggabooru neighbor project but NOT copied 1:1 (its cache-clear path and
single-bucket layout were suspect there).

## Layout

- `PxFileService extends FileService` — downloads through
  `WebSession.instance.dio` (shared UA/cookie/interceptors), per-URL
  `CancelToken`s with a request-seq guard so a cancelled download's
  `finally` can't evict a newer request's token. Scroll-away cancels
  downloads for free via `addOnLastListenerRemovedCallback`.
- Three managers, per-class budgets (`Config` has object-count eviction
  only — NO byte cap — so the split IS the balloon protection):

| Manager | Content | maxObjects | stale | ~Worst case |
|---|---|---|---|---|
| `px_thumbs` | Grid/strip thumbs, avatars, precache | 1000 | 30 d | ~30 MB |
| `px_fulls` | Detail fulls (`urls.regular`, pages) | 100 | 7 d | ~300 MB |
| `px_ugoira` | Ugoira zips (`originalSrc`) | 30 | 7 d | ~600 MB |

- `PxImageProvider(url, {headers, cacheManager, reloadToken})` — custom
  `ImageProvider` feeding `DownloadProgress` into standard `ImageChunkEvent`s,
  so all existing `loadingBuilder`s keep working. Cache hits emit NO
  progress events (manager returns `FileInfo` directly) — the phantom
  progress-bar-on-cache-hit class of complaints is gone structurally.
  `reloadToken` busts the in-memory entry for manual retry (detail
  fulls show Retry next to the broken-image icon).
- All requests carry `Referer: https://www.pixiv.net/` (`pxImageHeaders`).
  No cookie needed for pximg, same as before.

## Ugoira

- The zip is a static file: cache the zip, not the frames.
  `getSingleFile` → `FileByteSource.open(file.path)` → `Archive.open`.
  `Archive.close()` closes the owned source; early-exit paths mirror it.
- `UgoiraSessionStore` (in `ugoira_player.dart`, LRU of 2 entries) keeps
  decoded frames + meta + totals per illust id. Returning to a disposed
  ugoira page restores frames without touching the network; partial loads
  resume from the kept frame count.
- INVARIANT: a load must never cancel while its page is alive. In-page
  scrolling is not navigation — the detail viewer sits under a
  `_ViewerKeepAlive` (`AutomaticKeepAliveClientMixin`) so scrolling to
  related/strip and back never disposes the player mid-load. (A bare
  `KeepAlive` widget is WRONG here: ListView's delegate wraps children in
  a RepaintBoundary and it crashes — see the class comment.)
  Swipe-away cancel (active flips) is still by design.

## API responses (`lib/api_cache.dart`, Hive box `pixiv_api`)

- Immutable (7 d TTL): `illustDetail`, `illustPages`, `ugoiraMeta`.
- Artist-scoped (1 h TTL): `userFull`, `userWorksAll`, `userProfileWorks`
  chunks (keyed by user + category + length + head/tail ids).
- NEVER cached: discovery/related/ranking/search (live samples),
  CSRF/bookmark calls. No manual invalidation in v1 — TTLs only.

## Traps for future agents

- Don't add a fourth manager or share one across classes.
- Decode failures evict the memory entry but KEEP the disk file (a corrupt
  download would otherwise loop forever; `removeFile` on error was tried
  in niggabooru and risks exactly that).
- Web platform has a separate `Config` impl; this app doesn't target web.
- Ugoira zips are the balloon risk: drop `px_ugoira` stale to 3 d before
  touching anything else.
- Hive returns every stored map as Map<dynamic, dynamic>; dart_mappable
  demands Map<String, dynamic> at EVERY nesting level. Reads must go through
  `deepStringKeys` (`lib/api_cache.dart`) — a shallow top-level `Map.from`
  still explodes one level down, and only on cached reads (fresh jsonDecode
  output is fine), so the failure looks endpoint-specific when it isn't.

## Not built (proposed, not approved)

- Cache stats + clear UI (niggabooru-style live MB readout in settings).
  Visibility complement to the per-class budgets, not a replacement.
  Needs user greenlight before adding the settings surface.
