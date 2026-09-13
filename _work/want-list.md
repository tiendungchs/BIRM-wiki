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

### Wave 20 leftovers — the two rows that did not arrive

Wave 20 filed 15 of 17 targets (manifest rows 394–408, `_work/ingest-queue.md`). These two were not clipped and are not unreachable — both are institutional-session HTML. Until they land, `G112` argues its duality with one half in hand and `G101` prices the machine side only.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 9 | Mongillo, Barak & Tsodyks 2008, *Synaptic theory of working memory* | `https://www.science.org/doi/10.1126/science.1150769` | Science 319(5869):1543–1546 (probe returned `403` bot-block, not a paywall verdict; full HTML through the institution) | `clip` | `G112`, `T2` | **The opposing position to Wolff et al. 2017, which is now filed, and the wiki cites it second-hand on the plasticity pages without ever holding it.** Calcium-mediated presynaptic facilitation as the memory buffer, loaded and refreshed by low-rate spiking. `G112`'s duality argument is only as good as its two halves; the Wolff ingest can state the activity side, but not the synaptic one, until this lands | `open` |
| 11 | Elston 2003, *Cortex, cognition and the cell: new insights into the pyramidal neuron and prefrontal function* | `https://academic.oup.com/cercor/article/13/11/1124/274054` | Cereb. Cortex 13(11):1124–1138 (abstract-only to the probe → institutional HTML) | `clip` | `G101` | **The biological twin of Golubeva et al. 2021, which is now filed, and the measurement `G101` was opened on.** Prefrontal pyramidal cells carry up to **23×** the dendritic spines of V1 cells — the per-unit connection count varying by an order of magnitude *within one brain*, at roughly constant cell type. `G101` was written from a 2.75×-volume-on-1.25×-neurons figure quoted second-hand; this is the primary measurement of the quantity | `open` |

**Counts.** 2 targets, both `clip`, both awaiting an institutional session.
