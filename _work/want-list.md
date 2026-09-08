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

### Wave 18 — the relational supermodule, located: where in the human brain System 2 relational reasoning runs, and by what mechanism

Anchor: the user's query on `analogical-mapping` / `working-memory` / Penn, Holyoak & Povinelli 2008. The wiki's whole neural account of relational reasoning is second-hand through Holyoak 2012 and now Knowlton et al. 2012 (filed, row 364). Eight of the ten targets are filed (manifest rows 365–372) and queued; the two below remain.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 8 | Lambon Ralph, Jefferies, Patterson & Rogers 2017, *The neural and computational bases of semantic cognition* | `https://www.nature.com/articles/nrn.2016.150` | Nat. Rev. Neurosci. (cookie-gated → institutional) | `clip` | `G21`, `T289` | **The "semantic units are posterior" premise of LISA, given a model**: hub-and-spoke — a bilateral anterior-temporal hub that *learns* to map between modality-specific spokes, with semantic *control* on a separate left inferior-frontal / posterior-temporal network. For `G21`: a learned composer over encapsulated modality modules, in the brain; for the region table: what "anterior temporal stores the relations" actually means | open |
| 10 | Waltz et al. 1999, *A system for relational reasoning in human prefrontal cortex*, Psychological Science 10(2) 119–125 | user downloads PDF → `./tools/pdf2md.sh` | Psychological Science (pre-2000, PDF only) | `pdf` | `G104`, `T293` | **Cited second-hand on four pages and filed nowhere** (`analogical-mapping`, `working-memory`, `relational-reinterpretation`, `lisa`): frontal patients fail two-relation Raven's-type problems and are normal on zero/one-relation ones. It is the datum Penn's falsification protocol is built on and the load-variable claim every capacity argument in `working-memory.md` cites. Flag `LOSSY` | open |

**Order of ingest for what is already filed** is fixed in `_work/ingest-queue.md`. Row 8 slots into the survey tier (after Vendetti 2014); row 10 into the result tier, first (1999).

Run the `wiki-acquire` skill to build the next wave.
