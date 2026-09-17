# Contextual browsing (agent-maintained)

You browse the list you tapped — never a random one. A **context** is the
ordered work list owned by a `DetailScreen`: swipe stays inside it, and
reaching anything outside means back + a new entry. `DetailScreen` owns the
list; `DetailPage` renders one work. Cross-links (related grid, artist strip,
titles) push a **new** context; they never mutate the current one.

`ArtistContext` (`lib/artist_context.dart`) marks artist-scoped detail. Its
`orderIds` carries the full ID order so windowed contexts can still label the
honest global position (`7 / 99`) instead of a window-local one.

## Rules

- Minimap jumps **within** the context (outer pager `animateToPage`, no route).
- Strip / grids / titles push a **new** context (new route).
- Counts are shown only when the total is actually known (`orderIds` or a
  completed fetch). Window position is never presented as a total.
- End of list offers to grow **that** list, in the direction it can grow.

## Contexts

| Context | Entry | Order | Grows forward | Grows backward | Count | Minimap | Status |
|---|---|---|---|---|---|---|---|
| Discovery feed | Feed grid tap | Server sample order | Load-more footer, dedup append (live) | N/A (list head) | Exact, grows (`N shown`) | Proposed | List paging done; viewer extras pending |
| Related | Related grid tap in detail | Server `recommend` order | Load-more via `nextIds` (live) | N/A | Exact, grows | Proposed | Same as feed |
| Artist grid | Artist screen tap (from AppBar title, strip title, author row) | Newest-first, numeric id | No — full catalogue hydrated upfront | N/A | Exact after `profile/all` | Proposed | Works; hydration is all-upfront — see below |
| Artist window | Strip / Prev-Next tap from generic detail | Same artist order, hydrated window (neighbours + 12 recent) | No (dead end at window edge) | No (dead end) | Global via `orderIds` (`i / N`) | Proposed | Window scope is a wart — see below |

## Known gaps (proposed, not built)

1. **Minimap in every context — ON HOLD pending real-world testing.** The
   web-app habit may not transfer: back-to-previous-screen plus predictable
   contexts may be enough. Design if revived: one horizontal thumb strip fed
   by the `DetailScreen` list (`contextItems` + `contextIndex` + `onJump`),
   windowed ±20 around current for long lists, auto-scrolled to current,
   current highlighted. Same widget for feed / related / artist / window.
   Artist mode gets its strip back through this — synced to the actual list,
   not a separate fetch.
2. **Artist window → full list.** The window exists because hydrating a
   700-work catalogue on every strip tap is ~14 requests. Options: (a) keep
   the window and let the strip title → grid path serve full browsing
   (current); (b) hydrate in background after push and splice into the local
   list; (c) chunked upfront hydration shared with the grid. No decision yet.
3. **Artist grid chunked hydration.** Big artists currently block the grid on
   the full hydrate. Progressive: render after the first 48, Load-more footer
   hydrates the next chunk. Counts already arrive early via `profile/all`.
4. **End-of-list offer in viewer.** A trailing page in the outer pager when
   the context can grow forward (feed sample, related `nextIds`); artist
   contexts instead offer "open full list" at window edges. Not built.
