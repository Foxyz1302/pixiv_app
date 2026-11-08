# pixiv_app

Flutter Pixiv client (Android/desktop). Feed grid → DetailScreen outer pager → DetailPage inner multi-image pager.

## Commands

- `flutter test` — full suite, zero network
- `flutter run`

## Structure

- `lib/detail_screen.dart` — outer pager, nested-drag handoff (`resolveEndVelocity`), minimap jumps
- `lib/detail_page.dart` — artwork viewer, artist strip, related grid
- `lib/inner_minimap.dart` — post strip (`PostMinimap`)
- `lib/traversal_guard.dart` — static guard suppressing intermediate fetch during distant jumps
- `lib/feed_screen.dart` — `gridThumbUrl` / `thumbAspect` / `imageHeaders` / `TileBadge` live here
- `lib/web_session.dart` — persisted signals (`tileWidth`, `miniTileSize`, `reverseDetails`): signal + Hive persist + setter

## Gotchas

- `onPageChanged` fires mid-drag on every `ScrollUpdateNotification` that crosses a rounding boundary — never use live `_current` as a drag origin; snapshot at drag start.
- `test/inner_edge_drag_test.dart` pins the 0.12 commit threshold and the hold/end handoff contract; its harness snapshots the origin page like production must.
- `ExtendedPageView` vendors official `PageView` mechanics; only `cacheExtent` / `shouldIgnorePointerWhenScrolling` differ.
- Artist `DetailScreen` pager indices include a leading load-more cell when newer works remain — pager index = work index + 1; always map via `_workAt`, never `widget.items[i]`.
- `PostMinimap` follow is absolute (fractional page → centered strip offset via `jumpTo` on every tick); settle-only `ensureVisible` is transition-gated, never per-tick.
- Viewer cap (`viewerMaxHeight` from pager `LayoutBuilder`) must wrap every `_buildViewer` branch including failure — an uncapped `AspectRatio` sizes to full width and overflows the pager on landscape; `test/detail_viewer_cap_test.dart` pins it.
- Warm thumbs sequentially for all pages before the single adjacent full (`_precacheInnerPage(1)`); firing thumbs+fulls in one burst saturates the shared Dio pipe and thumbs land after fulls.
- Outer-pager keep-alive is conditional (`active || preload`); `didUpdateWidget` must call `updateKeepAlive()` when those flags flip. Pages ≥2 from `_current` unmount on purpose and their images leave the live image set — the cache budget never evicts live images, so an unconditional keepalive here was the OOM. `test/detail_loading_pager_test.dart` pins it.
- Keepalive notifications bubble (`AutomaticKeepAlive` returns false): `_ViewerKeepAlive`'s notification must be stopped by the `NotificationListener<KeepAliveNotification>` around the detail ListView or it registers with the outer pager's page wrapper too, deadlocking the outer release (page pins until route pop).
- Multi-image posts page-swipe through cover-thumb placeholders while `illustPages` is in flight (`illust.pageCount` pre-creates `_innerController`); `_fetch` must never reset `_innerIndex` when the pager pre-exists, or placeholder swipes are lost. Ugoira mounts the same way, before detail (`illustType == 2` from the feed item), and `_precacheNeighbors` warms meta+zip for ugoira neighbors — the zip itself is all-or-nothing (central directory sits at the file end).
