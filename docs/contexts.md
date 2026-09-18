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
| Discovery feed | Feed grid tap | Server sample order | Load-more footer, dedup append (live) | N/A (list head) | Exact, grows (`N shown`) | On hold | List paging live; viewer trailing offer pending |
| Related | Related grid tap in detail | Server `recommend` order | Load-more via `nextIds` (live) | N/A | Exact, grows | On hold | Same as feed |
| Artist grid | Artist screen tap (AppBar title, strip title) | Newest-first, numeric id | Chunked: first 48 render, 2nd streams in, rest via Load-more footer | N/A | Exact after `profile/all` | On hold | Chunked hydration live |
| Artist window | Strip / Prev-Next tap from generic detail | Same artist order, hydrated window (neighbours + 12 recent) | Inline "+N older" end-cell extends +24; Prev/Next hydrates on demand | Inline "+N newer" start-cell extends −24 | Global via `orderIds` (`i / N`) | On hold | Cursor live; viewer edge offer still pending |

## Known gaps (proposed, not built)

1. **Minimap in every context — ON HOLD pending real-world testing.** The
   web-app habit may not transfer: back-to-previous-screen plus predictable
   contexts may be enough. Design if revived: one horizontal thumb strip fed
   by the `DetailScreen` list (`contextItems` + `contextIndex` + `onJump`),
   windowed ±20 around current for long lists, auto-scrolled to current,
   current highlighted. Same widget for feed / related / artist / window.
   Artist mode gets its strip back through this — synced to the actual list,
   not a separate fetch.
2. **Artist window → full list — PARTIAL: cursor + on-demand hydrate live.**
   The strip grows ±24 per tap via inline end-cells into the full order and
   Prev/Next hydrates missing neighbours on demand, so the window walks the
   whole catalogue. Inner-edge overscroll hands the gesture to the outer
   pager via a lazily-created held-drag activity (created on first edge
   excess so mid-list inner drags never freeze an in-flight outer settle;
   framework settles natively, commit fling past ~12%, see
   `resolveEndVelocity`). `test/inner_edge_drag_test.dart`
   locks the mechanism (1:1 follow, hold-stability, boundary cross, tremor)
   plus framework probes (ballistic stays grabbable; driven-ignore trap
   documented) and `resolveEndVelocity` unit tests.
   What remains: a viewer edge offer (trailing page) instead of the dead
   end; the strip-title → grid path still serves full browsing.
3. **Artist grid chunked hydration — DONE.** Renders after the first 48,
   second chunk streams in, rest via Load-more footer with live counts.
4. **End-of-list offer in viewer.** A trailing page in the outer pager when
   the context can grow forward (feed sample, related `nextIds`); artist
   contexts instead offer "open full list" at window edges. Not built.
5. **Browsing tree — IDEA, needs real-world use first.** Browser-style
   long-press on back showing the route trail (feed → artwork → artist → …),
   needs named routes first (all anonymous today). The always-visible
   Explorer breadcrumb is out (burns AppBar space). Home drawer (Discovery /
   New from followed / Popular) is the real "get home" fix, blocked on those
   feeds existing, not on navigation. Parked alongside minimap.
