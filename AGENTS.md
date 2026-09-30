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
