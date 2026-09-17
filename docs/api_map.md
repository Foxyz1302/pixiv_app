# Pixiv App API — Web Ajax (verified live)

Web-only since 2026-09-14. Base `https://www.pixiv.net`, clean JSON, auth via
login cookie. Client: `lib/web/pixiv_web_client.dart` (`PixivWebClient`),
models `lib/web/pixiv_web_models.dart` (dart_mappable,
`@MappableClass(caseStyle: CaseStyle.snakeCase)` + explicit
`@MappableField(key: …)` for every camelCase wire field — silent `[]`
defaults bitten before). `lib/web` stays pure-Dart so `dart run tool/*` works.

## Auth — cookie jar (sliding ~30d renewal, verified live)

- Paste `PHPSESSID` once in settings; `WebSession` (`lib/web_session.dart`)
  keeps the full jar in hive (`pixiv_web` box, plain string — personal app).
- Server re-issues `PHPSESSID` (fresh now+30d) plus `c_type`/`yuid_b`/
  `privacy_*`/cf cookies on ordinary API calls — interceptor merges ALL
  `Set-Cookie` pairs, so a PHPSESSID-only paste bootstraps the full jar.
  Re-issue looks throttled, not every response. Proof:
  `tool/check_session_renewal.dart`.
- Every request: desktop Mozilla UA + `Referer: https://www.pixiv.net/`
  (artwork calls → `/artworks/{id}`, user calls → `/users/{id}`, ranking →
  `/ranking.php`, search → `/search.php`). Images/zips on `i.pximg.net` need
  `Referer` only (no cookie — verified for ugoira zips). Cookie values never
  logged. dio null query params stripped (sent as `""` otherwise → 400).

## Endpoints (all live-verified; `dart run tool/check_web_client.dart` → 13/13)

| Method | Wire call | Notes |
|---|---|---|
| `discoveryArtworks({mode, limit})` | `GET /ajax/discovery/artworks?mode=all\|safe\|r18` | Personalized (history/bookmark methods). r18 → 10/10 x=1; all → 7 safe + 3 R18; safe → 10/10 x=0 |
| `illustDetail(id)` | `GET /ajax/illust/{id}` | ~60-key body, inline user works, tag translations, 5-size urls |
| `illustPages(id)` | `GET /ajax/illust/{id}/pages` | Full list, thumb_mini/small/regular/original + w/h |
| `ugoiraMeta(id)` | `GET /ajax/illust/{id}/ugoira_meta` | `src` + `frames[{file, delay ms}]`; entries stored (uncompressed) → range reads are plain GETs |
| `related(id, {limit, nextIds})` | `…/recommend/init?limit=` then `…/recommend/illusts?illust_ids[]=` | Paging via `nextIds` prefetch (not offsets). **Follows seed rating**: safe seed → 18/18 safe, R18 seed → all R18. No mode param. Proof: `tool/check_related_rating.dart` |
| `followLatest({mode, p})` | `GET /ajax/follow_latest/illust` | 60 page ids + 60 hydrated thumbs, `isLastPage`; paging via `p` |
| `ranking({mode, content, p})` | `GET /ranking.php?format=json` | No `{error,body}` envelope; 50/page denormalized; `daily_r18` verified |
| `searchArtworks(word, {mode, sMode, order, p})` | `GET /ajax/search/artworks/{word}` | Body key `illustManga`; R18 search → 59 data (54 R18 + 5 R18G), total ~10.2M, `lastPage` 1000, `relatedTags` |
| `userFull(id)` | `GET /ajax/user/{id}?full=1` | Wire `social` is a map when linked accounts exist, `[]` when bare → coerced to `{}` (same shape-shift class as profile/all categories) |
| `userWorksAll(id)` | `GET /ajax/user/{id}/profile/all` | Full ID maps; empty categories arrive as `[]` → coerced to `{}` |
| `userProfileWorks(userId, ids, {workCategory})` | `GET /ajax/user/{id}/profile/illusts?work_category=illust\|manga&is_first_page=1&lang=en&ids[]=…` | Hydrates ID windows into `WebDiscoveryIllust`-shaped `works` map; chunked 50/req, illust+manga merged client-side, newest-first by numeric id |
| `comments(id, {offset, limit})` | `GET /ajax/illusts/comments/roots` | `{comments, hasNext}` — no mobile equivalent existed |
| `bookmarkAdd(…)` + `ensureCsrfToken()` | `GET /` → `x-csrf-token` → `POST /ajax/illusts/bookmarks/add` | Token regex over `__NEXT_DATA__`, retry on Cloudflare 403. Token acquisition verified; POST **not** exercised (avoids mutating real bookmarks) |
| `discovery/artworks/meta` | — | HTML-head/ads only, not content. Dead end, don't use |

Wire quirks: `nextIds` are ints (stringified pre-decode); `likeData` is
`dynamic` (observed `bool`); `illust_type`/`page_count` string-encoded in
ranking. List-thumb `url`s are square crops (`c/…`, `square1200`/`custom1200`
suffixes); rewriting to `c/540x540_70` + `master1200` (+ `custom-thumb` →
`img-master`) yields aspect-true thumbs fit in 540px — verified live for
single, multi, and ugoira (`gridThumbUrl`). Rate limits: app needs none;
tools space requests ~2s.

## Retired: mobile app-API (2026-08 → 2026-09, superseded)

`lib/pixiv/` (OAuth PKCE `PixivClient`) deleted — zero imports. Why retired:
`/v2/illust/discovery` is 404, `illust/recommended` has no R18 switch, and
global `day_r18` ranking is **not** personalized discovery (earlier doc text
claiming otherwise was wrong). Kept for reference: `docs/samples_appapi/`
(8 app-api response shapes), Magelon-png/PixivApi port notes below.

Port sources (2026-09-14): call patterns from
[Magelon-png/PixivApi](https://github.com/Magelon-png/PixivApi) (recommend
`nextIds` paging, user full/works, bookmarks + CSRF), shapes for
discovery/ranking/comments from PixivNow
[`docs/pixiv-web-api.md`](https://github.com/FreeNowOrg/PixivNow/blob/master/docs/pixiv-web-api.md).
No Dart ajax client exists (pixez/pixes/pixiv_dart_api are all app-API) —
port was necessary. Live `tool/check_*` scripts are the test strategy; no
flutter tests (`test/` empty, stale default deleted).
