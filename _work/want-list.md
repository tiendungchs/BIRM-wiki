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

### Wave 22 — how the cortex computes, and how it is wired to the hippocampus

Two blocks from one part-A pass on the user's request: **what the cortex does** (block A, `L1`/`L2`
rows on laminar wiring, hierarchy direction, and the prediction-error population) and **how it
connects to the hippocampus** (block B, `L1`/`L2` rows on the medial-temporal funnel, indexing vs
map, and the consolidation channel). The wiki already holds Douglas & Martin 2004 (manifest 164),
Bastos 2012 (059), Rao & Ballard 1999 (384), Keller & Mrsic-Flogel 2018 (382), Witter 2017 (381)
and Sun 2023 (176); every row below is chosen because it supplies something those six do not.

**Probe results, all fetched 2026-09-18.** Nature-family URLs answer `303 → idp.nature.com`
(session wall to `WebFetch`, not a paywall verdict); `cell.com` and `onlinelibrary.wiley.com`
answer `403` (bot-block, likewise not a verdict) — all `clip` through the institution, and all
three venues have precedent in `raw/`. Only the PMC mirror rendered full text to the probe; it is
still `clip`, not `self`, because the row is wanted for its laminar figures. Cerebral Cortex and
`science.org` were avoided by construction — Buzsáki 1996 and Tse 2007 were dropped at resolution
rather than routed to an excluded venue, and the schema question is carried instead by row 14.

#### A — how the cortex works

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 1 | Harris & Shepherd 2015, *The neocortical circuit: themes and variations* | `https://www.nature.com/articles/nn.3917` | Nat. Neurosci. 18(2):170–181 | `clip` | `T244`, `T252` | **The wiring diagram the wiki argues from but does not hold.** [[wiki/concepts/canonical-cortical-microcircuit.md]] is built on Douglas & Martin 2004, which states the canonical circuit as a *theme*; this is the cell-class-by-cell-class input/output table plus the **variations** — which laminar motifs change between sensory, motor and associative areas. `T244` asks whether cortex is units-with-borders or a continuum with axes, and cannot be worked while the wiki holds only the invariant half | `open` |
| 2 | Markov et al. 2014, *Anatomy of hierarchy: feedforward and feedback pathways in macaque visual cortex* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC4255240/` | J. Comp. Neurol. 522(1):225–259 | `clip` | `T252`, `T259` | **`T252` asks whether the direction of cortical flow is fixed by anatomy or set dynamically, and the anatomical side has never been put in the wiki as a number.** SLN (fraction of supragranular labelled neurons) gives every interareal pathway a continuous hierarchical distance rather than a rank — which turns "is the hierarchy a chain or an apex" (`T259`) into a measurable question about one parcellation | `open` |
| 3 | Bastos et al. 2015, *Visual areas exert feedforward and feedback influences through distinct frequency channels* | `https://www.cell.com/neuron/fulltext/S0896-6273(14)01099-X` | Neuron 85(2):390–401 | `clip` | `T252`, `T259` | The dynamic side of the same row, from the same group as Bastos 2012: feedforward influence rides theta and gamma, feedback rides beta, and the two directions are **separable by frequency in the same pair of areas**. Paired with row 2 this is `T252`'s head-to-head — anatomy and dynamics on one visual hierarchy — which is exactly what the row has never had | `open` |
| 4 | Larkum 2013, *A cellular mechanism for cortical associations: an organizing principle for the cerebral cortex* | `https://www.cell.com/trends/neurosciences/fulltext/S0166-2236(12)00203-2` | Trends Neurosci. 36(3):141–151 | `clip` | `T259`, `T302` | **Where feedback meets feedforward, stated as a site rather than as an arrow.** Coincident basal (bottom-up) and apical-tuft (top-down) input triggers a dendritic calcium spike and a burst; the association is a property of one pyramidal cell, gated by local inhibition. `T259`'s `Closes when` needs a criterion for a level *broadcasting* rather than relaying, and a per-cell coincidence rule is the mechanism that would make a level do either | `open` |
| 5 | Aru, Suzuki & Larkum 2020, *Cellular mechanisms of conscious processing* | `https://www.cell.com/trends/cognitive-sciences/fulltext/S1364-6613(20)30175-3` | Trends Cogn. Sci. 24(10):814–825 | `clip` | `T269`, `T272` | `T269` (7 citations, `LIVE`) asks whether prefrontal cortex *constitutes* content or only routes it, and every source the wiki holds on it argues at the area level. This argues at the **cell** level — apical-dendrite coupling as the gate — which is the one framing under which "constitute" and "route" stop being the only two options | `open` |
| 6 | Jordan & Keller 2020, *Opposing influence of top-down and bottom-up input on excitatory layer 2/3 neurons in mouse primary visual cortex* | `https://www.cell.com/neuron/fulltext/S0896-6273(20)30748-0` | Neuron 108(6):1194–1206 | `clip` | `T341` | **`T341`'s `Closes when` almost verbatim.** Whole-cell recording in awake closed-loop mice, so subthreshold membrane potential — not rate — reports whether a single L2/3 cell subtracts predicted from actual flow, and whether sub-baseline suppression exists. One population vs two sign-specific populations is decidable from intracellular data and not from the calcium imaging the wiki's four `T341`-citing pages rest on | `open` |

#### B — how the cortex connects with the hippocampus

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 7 | Lavenex & Amaral 2000, *Hippocampal-neocortical interaction: a hierarchy of associativity* | `https://onlinelibrary.wiley.com/doi/10.1002/1098-1063(2000)10:4%3C420::AID-HIPO8%3E3.0.CO;2-5` | Hippocampus 10(4):420–430 | `clip` | `T347`, `T28` | **The funnel itself, which the wiki has never ingested as anatomy.** Perirhinal → parahippocampal → entorhinal associational networks integrate unimodal and polymodal input *before* anything reaches the hippocampal formation, so the interface is a processing hierarchy and not a cable. `T347` asks what the entorhinal-hippocampal code de-aliases; the answer is constrained by how much has already been mixed upstream | `open` |
| 8 | Teyler & Rudy 2007, *The hippocampal indexing theory and episodic memory: updating the index* | `https://onlinelibrary.wiley.com/doi/10.1002/hipo.20350` | Hippocampus 17(12):1158–1169 | `clip` | `T28` | **`T28` position B has no primary source.** The wiki states indexing theory through [[wiki/entities/tolman-eichenbaum-machine.md]], a model that assumes it. This is the theory's own statement and its 20-year update — what the index is an index *of*, and what the theory predicts that a map account does not. `T28` is `LEANING` with 8 citations and cannot be re-priced from a model that presupposes one side | `open` |
| 9 | Kumaran, Hassabis & McClelland 2016, *What learning systems do intelligent agents need? Complementary learning systems theory updated* | `https://www.cell.com/trends/cognitive-sciences/fulltext/S1364-6613(16)30043-2` | Trends Cogn. Sci. 20(7):512–534 | `clip` | `G14`, `T81` | The wiki holds O'Reilly 2011 (manifest 063) for CLS, which predates the update that matters here: replay is **selective and schema-dependent**, with the consolidation *rate* set by consistency with existing cortical knowledge. `G14`'s `Closes when` demands replay selected by transferability rather than recency; this is the statement of that rule, and `T81`'s "recurs vs can be modelled" is its dichotomy | `open` |
| 10 | Frankland & Bontempi 2005, *The organization of recent and remote memories* | `https://www.nature.com/articles/nrn1607` | Nat. Rev. Neurosci. 6(2):119–130 | `clip` | `T97`, `T82` | **`T97`'s `Closes when` is "re-examine the selective-remote-role experiments for a weak recent one" — this is the review that tabulates them.** Lesion, imaging and immediate-early-gene results ordered by memory age across hippocampus and prefrontal cortex, which is the evidence base `T97` (`LEANING`, 1 citation) was opened against without ever being read | `open` |
| 11 | Rothschild, Eban & Frank 2017, *A cortical–hippocampal–cortical loop of information processing during memory consolidation* | `https://www.nature.com/articles/nn.4457` | Nat. Neurosci. 20(2):251–259 | `clip` | `T34`, `T81`, `T97` | **The single best row in this wave for the user's question, because it measures the channel in both directions on the same ripples.** Auditory-cortex activity *precedes and predicts* hippocampal sharp-wave-ripple content, and ripple content then predicts subsequent cortical activity — so cortex is an input to replay selection, not only its recipient. `T81`'s "does the slow learner gate what consolidates" becomes a measurement rather than a hypothesis | `open` |
| 12 | Ji & Wilson 2007, *Coordinated memory replay in the visual cortex and hippocampus during sleep* | `https://www.nature.com/articles/nn1825` | Nat. Neurosci. 10(1):100–107 | `clip` | `T34`, `T30` | The primary observation row 11 revises: cortical and hippocampal replay of the same experience, coordinated within slow-wave frames. `T34` (sleep vs waking transfer) is `LEANING` on three citing pages that all cite this result second-hand, and `T30` (replay for planning vs for a transferable map) needs the sleep case stated by the source that established it | `open` |
| 13 | Klinzing, Niethard & Born 2019, *Mechanisms of systems memory consolidation during sleep* | `https://www.nature.com/articles/s41593-019-0467-3` | Nat. Neurosci. 22(10):1598–1610 | `clip` | `T34`, `T81`, `G14` | The mechanism layer under rows 11–12: slow oscillation / spindle / ripple nesting as the **timing protocol** that says when the channel is open, plus the qualitative-transformation claim. `T82`'s `Closes when` calls for slow-oscillation stimulation with predictability varied — this is the review that defines the stimulation target | `open` |
| 14 | Gilboa & Marlatte 2017, *Neurobiology of schemas and schema-mediated memory* | `https://www.cell.com/trends/cognitive-sciences/fulltext/S1364-6613(17)30086-4` | Trends Cogn. Sci. 21(8):618–631 | `clip` | `T82`, `G14` | [[wiki/concepts/schema-assimilation.md]] exists with no primary source: Tse 2007 is `science.org`, an excluded venue, and is cited second-hand. This carries the same content — schema instantiation, the ventromedial-prefrontal locus, and **accelerated** consolidation for schema-consistent material — and is the source `T82`'s "optimal refusal vs transport failure" needs, because a schema is what decides whether transport is even possible | `open` |

**Counts.** 14 targets, **all `clip`**, none `self`, none `pdf`. Block A closes work on `T244`,
`T252`, `T259`, `T269`, `T302` and `T341`; block B on `T28`, `T30`, `T34`, `T81`, `T82`, `T97`,
`T347` and `G14`. Dropped at resolution rather than routed to an excluded venue: Buzsáki 1996
*The hippocampo-neocortical dialogue* (Cereb. Cortex) and Tse et al. 2007 *Schemas and memory
consolidation* (Science) — `T82` and `G14` keep their second-hand citation of the latter until
row 14 lands.
