# Image + ugoira caching (decision doc for future agents)

Wishlist 0.1.1 wants disk caching (same artwork currently redownloads every
visit). Decision: `flutter_cache_manager` (+ `cached_network_image` for
widgets). Verified against the local pub cache (3.4.1), not just docs.

## The byte-cap problem (and the answer)

`Config` evicts by `stalePeriod` and `maxNrOfCacheObjects` (object count).
There is **no total-byte limit**, so one manager for everything can balloon
(fulls are MBs, ugoira zips tens of MBs). Mitigation: split managers per
content class, size the object counts from typical file sizes, keep stale
periods short for the heavy classes. Starting budgets (tune on device):

| Manager key | Content | Typical file | maxObjects | stale | ~Worst case |
|---|---|---|---|---|---|
| `px_thumbs` | Grid/strip thumbs (`gridThumbUrl`, ~540px) | ~30 KB | 1000 | 30 d | ~30 MB |
| `px_fulls` | Detail fulls (`urls.regular`, pages) | ~3 MB | 100 | 7 d | ~300 MB |
| `px_ugoira` | Ugoira zips (`originalSrc`) | ~20 MB | 10 | 7 d | ~200 MB |

All requests need `Referer: https://www.pixiv.net/` — the manager's
per-request `headers` / `authHeaders` params cover this (no cookie needed,
same as today).

## Stills: what changes

- Tiles, strip thumbs, avatars, detail fulls: `NetworkImage`/`ResizeImage` →
  `cached_network_image` with a per-class `cacheManager` + `httpHeaders`.
  Its `progressIndicatorBuilder` also covers wishlist "loading progress with
  text" — print the percent there.
- `precacheImage` calls (neighbor prefetch, inner-page prefetch) go through
  the same managers so prefetch warms the same files.
- Loading placeholders stay as-is; `errorWidget` keeps the current
  broken-image + retry pattern (wishlist "refetch failed images").

## Ugoira: how the hell we cache it

The zip is a static file, so cache the zip, not the frames:

1. `await pxUgoiraManager.getSingleFile(zipUrl, headers: refererHeaders)` —
   downloads once, returns the cached `File`.
2. `Archive.open(await FileByteSource.open(file.path))` instead of today's
   `HttpRangeByteSource.open(zipUrl)`. Both verified to exist in
   koni_archive 0.9.0 / koni_archive_core 0.9.0 (`Archive.openBytes` over
   `MemoryByteSource` also exists if file I/O ever misbehaves).
3. `Archive.close()` already closes the owned source — the player's existing
   dispose path keeps working; mirror the early-exit `source.close()` calls
   for `FileByteSource` on cancelled loads.
4. Decoded frames stay memory-only per player session (as today); disk holds
   only the zip. Do NOT cache individual frames to disk.

## Non-goals / traps

- Don't add a fourth manager or share one across classes — the whole point
  is per-class budgets.
- Web platform has a separate `Config` impl; this app doesn't target web,
  don't contort the plan for it.
- `leaf_widgets` has no cache deps (checked); the managers live in this app,
  e.g. `lib/px_cache.dart` (flat layout, like `web_session.dart`).
- Ugoira zips are the balloon risk: if 10 objects still hurts, drop
  `px_ugoira` stale to 3 d before touching anything else.
