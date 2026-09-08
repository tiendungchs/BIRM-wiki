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

Anchor: the user's query on `analogical-mapping` / `working-memory` / Penn, Holyoak & Povinelli 2008. The wiki's whole neural account of relational reasoning is second-hand through Holyoak 2012 and now Knowlton et al. 2012 (filed, row 364). Every row below supplies either a **primary** for a region claim those two pages make, or the **mechanism** evidence Knowlton's synchrony hypothesis admits it lacks.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 1 | Vendetti & Bunge 2014, *Evolutionary and Developmental Changes in the Lateral Frontoparietal Network: A Little Goes a Long Way for Higher-Level Cognition* | `https://www.cell.com/neuron/fulltext/S0896-6273(14)00893-9` | Neuron (institutional; open fallback `https://pmc.ncbi.nlm.nih.gov/articles/PMC4527542/`) | `clip` | `T289`, `G21` | **The anatomical correlate `T289` says the behavioural discontinuity has never been given.** Position "re-weighting, not new component" stated with an anatomy: strengthened rostrolateral-prefrontal ↔ inferior-parietal connectivity plus association-cortex expansion, no new area. Read for whether it predicts anything Penn's falsification appendix could test | open |
| 2 | Hobeika, Diard-Detoeuf, Garcin, Levy & Volle 2016, *General and specialized brain correlates for analogical reasoning: a meta-analysis of functional imaging studies* | `https://onlinelibrary.wiley.com/doi/10.1002/hbm.23149` | Human Brain Mapping (institutional; open fallback `https://pmc.ncbi.nlm.nih.gov/articles/PMC6867453/`) | `clip` | `G21`, `T289` | **Turns the region table on `analogical-mapping.md` from a review's list into a pooled measurement** (27 experiments, 506 subjects): left rostrolateral prefrontal cortex domain-general; ventral (inferior frontal) for semantic vs dorsal (middle frontal) for visuospatial analogies; matrix problems on a dissociable fronto-parietal system. For `G21`: one domain-general integrator over domain-specific inputs is the composer topology the row lacks a biological instance of | open |
| 3 | Urbanski et al. 2016, *Reasoning by analogy requires the left frontal pole: lesion-deficit mapping and clinical implications* | `https://academic.oup.com/brain/article/139/6/1783/1753948` | Brain (gated → institutional) | `clip` | `T289`, `T92` | **The only causal human evidence for the "integrator" cell of the table** — 27 focal frontal patients, voxel-based lesion mapping, tractography: left rostrolateral damage or its long-range tracts specifically impairs analogy, with a manipulation that isolates relational integration. Imaging (rows 2) only correlates | open |
| 4 | Mole, Ruffle, Nelson, Chan, Shallice, Nachev & Cipolotti 2025, *A right frontal network for analogical and deductive reasoning* | `https://academic.oup.com/brain/article/148/5/1757/8104772` | Brain (full HTML) | `clip` | `T289` (opens a row) | **Contradicts row 3 on hemisphere with nine times the sample** — 247 unilateral-lesion patients, lesion-deficit + graph-network mapping: *right* frontal network, resembling the fluid-intelligence network. With row 3 this is a lesion-mapping tension (left frontal pole vs right frontal network) to be opened at ingest; read for task differences (verbal analogy vs computerised AR/DR) before opening it | open |
| 5 | Chau, Law, To, Shum & Mars 2025, *Complex functions of human lateral frontopolar cortex* | `https://academic.oup.com/brain/article/148/11/3833/8226004` | Brain (full HTML) | `clip` | `T289`, `G21` | **The region Penn's prediction points at, reviewed after the wiki's sources stop** — lateral frontopolar cortex as the uniquely expanded human area; lesion, imaging and stimulation; claim that it manages multiple information streams and decomposes high-dimensional input into simpler features, coupled to posterior/anterior cingulate. Read for whether "relational integration" survives as its computational description or is replaced | open |
| 6 | Roux & Uhlhaas 2014, *Working memory and neural oscillations: alpha–gamma versus theta–gamma codes for distinct WM information?* | `https://www.sciencedirect.com/science/article/pii/S1364661313002313` | Trends Cogn. Sci. (gated → institutional) | `clip` | `G104`, `T293` | **The oscillation code Knowlton's synchrony mechanism rests on, stated as a testable partition**: gamma for maintenance, theta for temporal ordering of items, alpha for inhibiting task-irrelevant activity, with cross-frequency coupling as the binding mechanism. `G104`'s only worked instance (LISA) is a phase code; this is the evidence base for whether the brain has one, and which band would carry role–filler separation | open |
| 7 | Zeithamova, Dominick & Preston 2012, *Hippocampal and ventral medial prefrontal activation during retrieval-mediated learning supports novel inference* | `https://www.cell.com/neuron/fulltext/S0896-6273(12)00445-X` | Neuron (gated → institutional) | `clip` | `T203`, `T100` | **Knowlton Box 1's open question — prefrontal dynamic binding vs hippocampal binding — with a measured division of labour**: medial prefrontal biases which memory is reinstated, hippocampus binds current experience to it, and the integrated representation is what supports A→C inference. Read for `T203`: whether the abstract (integrated) format appears prefrontally or hippocampally first | open |
| 8 | Lambon Ralph, Jefferies, Patterson & Rogers 2017, *The neural and computational bases of semantic cognition* | `https://www.nature.com/articles/nrn.2016.150` | Nat. Rev. Neurosci. (cookie-gated → institutional) | `clip` | `G21`, `T289` | **The "semantic units are posterior" premise of LISA, given a model**: hub-and-spoke — a bilateral anterior-temporal hub that *learns* to map between modality-specific spokes, with semantic *control* on a separate left inferior-frontal / posterior-temporal network. For `G21`: a learned composer over encapsulated modality modules, in the brain; for the region table: what "anterior temporal stores the relations" actually means | open |
| 9 | Parsons et al. 2022, *The Neural Correlates of Analogy Component Processes* | `https://onlinelibrary.wiley.com/doi/10.1111/cogs.13116` | Cognitive Science (403 bot block → institutional) | `clip` | `G37` | **Separates retrieval, mapping and inference neurally** — the three-process table on `analogical-mapping.md` argues retrieval is where the cost falls; this is the first source that could show whether the stages have distinct signatures or one shared frontopolar one | open |
| 10 | Waltz et al. 1999, *A system for relational reasoning in human prefrontal cortex*, Psychological Science 10(2) 119–125 | user downloads PDF → `./tools/pdf2md.sh` | Psychological Science (pre-2000, PDF only) | `pdf` | `G104`, `T293` | **Cited second-hand on four pages and filed nowhere** (`analogical-mapping`, `working-memory`, `relational-reinterpretation`, `lisa`): frontal patients fail two-relation Raven's-type problems and are normal on zero/one-relation ones. It is the datum Penn's falsification protocol is built on and the load-variable claim every capacity argument in `working-memory.md` cites. Flag `LOSSY` | open |

**Order of ingest once filed:** 1 · 5 · 8 (surveys) → 6 (framework) → 2 · 3 · 4 · 7 · 9 · 10 (results, oldest first). Knowlton et al. 2012 (row 364, filed) goes first in the wave.

Run the `wiki-acquire` skill to build the next wave.
