# Pixiv App Roadmap (agent-maintained)

Source of truth for scope. User's `docs/wishlist.md` is git-ignored; agents
CONSUME it (mark items [x] as they land) and mirror status here. Standing
rule: a problem the user stops mentioning is fixed — mark it off.

## v1 — usable state

- [x] Discovery feed (`GET /ajax/discovery/artworks?mode=`, `lib/web/`) + Load-more footer (endpoint ignores offset/page — appends de-duplicated fresh samples; refresh = replace)
- [ ] New from followed (`followLatest`, 60 ids + 60 hydrated thumbs per page, `p` paging — grid needs nothing, detail hydrates on tap)
- [ ] Popular R18 (`ranking(mode=daily_r18)`, 50/page denormalized)
- [ ] Artist following (`GET /ajax/user/{id}/following`)
- [ ] "More from this artist" on followed artists (`userWorksAll`, full ID dump)
- [ ] Favoriting (`bookmarkAdd` + CSRF implemented, POST unexercised live; jar auto-completes from PHPSESSID-only paste)
- [ ] "More like this" on favorite (seed `related()` with favorited id — design TBD)
- [x] Related artworks + pagination (`related()` + `nextIds`, Load-more footer; follows seed rating — safe seed stays safe, R18 seed stays R18)
- [x] Author header on detail (avatar instant from list item, upgraded via `userFull`) + "More from this artist" strip with prev/next (generic entry only; `userWorksAll` order, window hydrated via `userProfileWorks`; strip tap switches into artist-scoped detail, section title opens the artist grid)
- [x] Artist view + Illustrations/manga (`userFull` + `userWorksAll` + `userProfileWorks` hydration, `lib/artist_screen.dart`; single combined grid newest-first, header with avatar/counts/comment, follow button placeholder; chunked: first 48 render, rest via Load-more)
- [ ] Tag search with autocomplete + tappable tags (autocomplete UNKNOWN — research; display is web-style RichText blue `#tag` + gray EN, taps come with search)

## UX principles (settled)

- Manual pagination: "Load more" footer button appending de-duplicated items (niggabooru `lib/search_view.dart`, NOT page-number controls, no auto infinite-scroll).
- Masonry grid: `waterfall_flow` (user-adjustable width 140–480px, persisted),
  natural aspect via payload w/h, aspect-true `gridThumbUrl` thumbs, tiles
  clamped at `minTileAspect`, Referer on pximg.
  Disk image cache: LIVE — `lib/px_cache.dart` (own Dio-backed `PxFileService`
  + `PxImageProvider`, three per-class managers; no `cached_network_image`
  by decision). API responses: `lib/api_cache.dart` (Hive TTLs). Details:
  `docs/caching.md`.
- Detail swipes within its entry list (feed, related, or artist works newest-first);  artist-scoped detail shows a slim artist bar (`n / N`, tap pops back) and hides
  the redundant "More from this artist" strip (agreed 2026-09-17, supersedes the
  old never-artist-scoped rule). Multi-page posts get an
  INNER pager with per-page full-bleed aspect + animated height transition
  (a fixed shared viewport was tried — pillarbox regression, reverted).
  Inner-edge overscroll hands the gesture to the outer pager through a real
  held-drag activity (`position.drag`, deltas negated into `primaryDelta`):
  no spring while held, and on release the framework's own page-snapping
  settles with the finger velocity (`resolveEndVelocity` forces a commit
  fling past ~12% of a page). NEVER drive the outer with `jumpTo` here —
  it ends in `goBallistic(null)` and `PageScrollPhysics` turns that into a
  spring back to the nearest page (verified by hold test; plain lists are
  unaffected because their simulation returns null). Framework PR #181761
  may one day offer opt-in overscroll delegation; until then the manual
  handoff stays. Neighbours prefetch detail+pages JSON ahead of arrival.
- Ugoira: single minimal one-line bottom bar (loading + position); tap on the
  animation toggles playback; holds at loaded frontier, loops only when
  complete; per-frame delays exact. Loading: PRELOAD when a ugoira post is
  close in the feed (neighbor prefetch); CANCEL on swipe-away and stay
  cancelled until explicit user load, resuming from the kept position/frames
  (no auto-restart, no re-download of kept frames). Zip on disk
  (`px_ugoira`, 30 objects) + 2-entry decoded-frame session store; in-page
  scroll NEVER cancels (viewer `_ViewerKeepAlive`) — only page-exit does.
- Zoom removed for now (pinch kept losing the gesture arena to pagers;
  reintroduce recognizer-level, not physics toggles).
- Cookie auth: paste-once PHPSESSID in settings, jar auto-persists Set-Cookie re-issues (sliding ~30d). Plain hive_ce string, no secure storage (personal app, browse-only).
- Bottom-focus experiment: details list reversible (`reverseDetails` persisted signal, Display dialog toggle) — artwork pinned to the bottom, info/strip/related scroll upward, a custom bottom bar replaces the AppBar (never host an AppBar widget in `bottomNavigationBar` — it zeroes the Scaffold body); strip keeps top-down order (too short to reverse). Related zone sits in a tinted full-bleed card (both modes). Default off; evaluate one-handed feel before expanding.

## 0.1.1 polish (mirrored from git-ignored `docs/wishlist.md`)

- [x] Disk caching for images + ugoira (was: same artwork redownloaded)
- [x] Large-image loading progress with text (% under the spinner)
- [~] Refetch failed images (detail fulls have Retry; grid/strip thumbs don't yet)
- [ ] Momentary page indicator on page change / when chrome hidden
- [ ] Chrome animate in/out instead of snap (batch with the indicator above)
- [ ] Thumbnail as background while the full loads
- [ ] Ugoira neighbor preload already live; still-image neighbor full
  prefetch (detail+pages JSON) live, full-image precache pending

## Research queue

- [x] Inner mid-animation grab routes to outer (FIXED via `ExtendedPageView`
  `shouldIgnorePointerWhenScrolling: false`; feels like one pager that
  occasionally switches posts; outer hold is lazy on first edge excess).
  Companion bug found by the same work: an AppBar widget hosted in
  Scaffold.bottomNavigationBar collapses the Scaffold body to zero height
  (void page under a lone bar, no throw — reproduced headless). Reverse
  mode now uses a purpose-built bottom bar (plain Material + BackButton,
  same content) instead. Regression: `test/detail_reverse_body_test.dart`
  (reverse + non-reverse control).
- [ ] Detail chrome direction — pinned viewer (info always visible, costs
  space) vs auto-hide immersion (current tap-toggle is inner-viewer only).
  Pulls opposite ways; awaiting user call before building either.
- [x] Thumbnail dimensions — natural aspect (0.52–1.78 live), waterfall grid live
- [x] Ugoira progressive playback via koni_archive `HttpRangeByteSource` (stored entries, Referer-only, ~2s first frame)
- [x] Related rating lock — follows seed rating server-side, no mode param (`tool/check_related_rating.dart`)
- [x] Aspect-true thumbs — list `url`s are square crops; `c/540x540_70` + `master1200` rewrite verified live for single/multi/ugoira (`gridThumbUrl`); tiles clamp at `minTileAspect` (1:2, tunable)
- [x] Disk caching — LIVE: Dio-backed `PxFileService` + own `PxImageProvider`
  (three managers, ugoira 30), zip+`FileByteSource` for ugoira, Hive-TTL API
  cache. Full state: `docs/caching.md`
- [ ] Tag autocomplete endpoint (candidates: `/rpc/cps.php?keyword=`, ajax autocomplete — sniff devtools)
- [ ] `recommend/init` `details` field role; `sexual:2`↔xRestrict mapping

## Layout (flat, no folders-per-file)

`main.dart` bootstrap · `feed_screen.dart` feed+tiles+dialogs ·
`detail_screen.dart` outer pager + AppBar · `detail_page.dart` fetch/viewer/tags/author/strip/related ·
`artist_screen.dart` artist header + works grid · `artist_context.dart` shared
artist nav param + avatar · `px_cache.dart` Dio file service + managers +
provider · `api_cache.dart` Hive-TTL response cache ·
`feed_store.dart` · `web_session.dart` · `ugoira_player.dart` · `web/` pure-Dart client.
