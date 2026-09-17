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
- [x] Artist view + Illustrations/manga (`userFull` + `userWorksAll` + `userProfileWorks` hydration, `lib/artist_screen.dart`; single combined grid newest-first, header with avatar/counts/comment, follow button placeholder)
- [ ] Tag search with autocomplete + tappable tags (autocomplete UNKNOWN — research; display is web-style RichText blue `#tag` + gray EN, taps come with search)

## UX principles (settled)

- Manual pagination: "Load more" footer button appending de-duplicated items (niggabooru `lib/search_view.dart`, NOT page-number controls, no auto infinite-scroll).
- Masonry grid: `waterfall_flow` (user-adjustable width 140–480px, persisted),
  natural aspect via payload w/h, aspect-true `gridThumbUrl` thumbs, tiles
  clamped at `minTileAspect`, Referer on pximg.
  Disk image cache: was deliberately skipped, now DECIDED — see
  `docs/caching.md` (not yet implemented).
- Detail swipes within its entry list (feed, related, or artist works newest-first);
  artist-scoped detail shows a slim artist bar (`n / N`, tap pops back) and hides
  the redundant "More from this artist" strip (agreed 2026-09-17, supersedes the
  old never-artist-scoped rule). Multi-page posts get an
  INNER pager with per-page full-bleed aspect + animated height transition
  (a fixed shared viewport was tried — pillarbox regression, reverted).
- Ugoira: single minimal one-line bottom bar (loading + position); tap on the
  animation toggles playback; holds at loaded frontier, loops only when
  complete; per-frame delays exact. Loading: PRELOAD when a ugoira post is
  close in the feed (neighbor prefetch); CANCEL on swipe-away and stay
  cancelled until explicit user load, resuming from the kept position/frames
  (no auto-restart, no re-download of kept frames).
- Zoom removed for now (pinch kept losing the gesture arena to pagers;
  reintroduce recognizer-level, not physics toggles).
- Cookie auth: paste-once PHPSESSID in settings, jar auto-persists Set-Cookie re-issues (sliding ~30d). Plain hive_ce string, no secure storage (personal app, browse-only).

## Research queue

- [x] Thumbnail dimensions — natural aspect (0.52–1.78 live), waterfall grid live
- [x] Ugoira progressive playback via koni_archive `HttpRangeByteSource` (stored entries, Referer-only, ~2s first frame)
- [x] Related rating lock — follows seed rating server-side, no mode param (`tool/check_related_rating.dart`)
- [x] Aspect-true thumbs — list `url`s are square crops; `c/540x540_70` + `master1200` rewrite verified live for single/multi/ugoira (`gridThumbUrl`); tiles clamp at `minTileAspect` (1:2, tunable)
- [ ] Disk caching — DECIDED, not built: `flutter_cache_manager` split per class, ugoira via cached-zip + `FileByteSource` (both APIs verified local). Full plan: `docs/caching.md`
- [ ] Tag autocomplete endpoint (candidates: `/rpc/cps.php?keyword=`, ajax autocomplete — sniff devtools)
- [ ] `recommend/init` `details` field role; `sexual:2`↔xRestrict mapping

## Layout (flat, no folders-per-file)

`main.dart` bootstrap · `feed_screen.dart` feed+tiles+dialogs ·
`detail_screen.dart` outer pager + AppBar · `detail_page.dart` fetch/viewer/tags/author/strip/related ·
`artist_screen.dart` artist header + works grid · `artist_context.dart` shared
artist nav param + avatar ·
`feed_store.dart` · `web_session.dart` · `ugoira_player.dart` · `web/` pure-Dart client.
