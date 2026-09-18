# Want-list — sources to acquire

Produced by the `wiki-acquire` skill, part A. Consumed by the human's Obsidian Web Clipper.
Nothing is clipped that is not on this list; every row names the registry row it settles.

**This file holds the ACTIVE want-list only.** A row leaves it the moment it is filed
(it is then tracked in `_work/manifest.tsv` and `_work/ingest-queue.md`) or the moment it
is judged unreachable (recorded once under the wave's *Not acquired* line in
`_work/ingest-queue.md`, then dropped). No archive, no history — the gitlog is the changelog.

**Access:** institutional (UBO Brest) — a paywall is not a filter. The filter is **HTML vs PDF**:
a PDF conversion is lossy on exactly the equations and figures the wiki needs.

**Route column:** `clip` = human, Obsidian Web Clipper · `self` = Claude fetches and writes `raw/` ·
`pdf` = last resort, `./tools/pdf2md.sh`, flagged `LOSSY`.

**Status column:** `open` → `clipped` → `filed` (then the row is deleted from this file).

After clipping, drop the files in `raw/` and run:

```bash
./tools/clip-check.sh              # validate every untracked file in raw/
./tools/clip-check.sh --manifest raw/<file>.md   # then file the manifest row
```

---

## Active

### Wave 24 — the parse itself (closed)

All 11 reachable targets landed and are filed — manifest rows 453–463, `_work/ingest-queue.md` wave 24.
Nothing is open.

**Dropped as unreachable.** Row 2, Roelfsema 2006, *Cortical algorithms for perceptual grouping*
(Annu. Rev. Neurosci. 29:203–227) — `annualreviews.org` is outside the UBO Brest subscription.
Recorded under wave 24's *Not acquired* line in `_work/ingest-queue.md`; the venue is now in the
skill's excluded-venues table. `G27`, `T278` and `T151` keep their second-hand citation of the
base- vs incremental-grouping split — though `mollard-2026` (row 3, re-clipped from PLOS after the
bioRxiv URL returned a stub) carries the incremental-grouping mechanism into the wiki by another route.

*No active want-list. Run ACQUIRE part A to build wave 25.*
