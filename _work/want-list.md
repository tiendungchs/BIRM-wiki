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

**Wave 29 (continued) — the `P36` targets the user's drop did not cover.** The five clipped files
(`T407`, perirhinal page, `T408`) are filed as wave 29 in `_work/ingest-queue.md`. These four rows
serve the rest of `P36`: `G101` (the cross-species check that its primate exponent holds for great
apes and for edges per unit, not only units), `T405` (whether the habit store has a teaching signal
that is not reward prediction error) and `T406` (whether a learned goal space loses because it is
learned or because it is co-trained). Each lands in wave 29's block when filed.

**Probe results, 2026-10-06.** `pmc.ncbi.nlm.nih.gov/articles/PMC8463089/` renders Sherwood et al.
2020 in full with tables. `P36` records this paper as unreachable, but that was the Oxford
(`academic.oup.com`) route; the PMC mirror is the skill's first choice for that venue.
`pmc.ncbi.nlm.nih.gov/articles/PMC3064932/` renders Herculano-Houzel & Kaas 2011 in full.
`nature.com` answers `303` to its identity provider for Greenstreet et al. 2025. It is **gated, so
`clip`**, as in the wave-27/28 precedent; an author copy is at UCL Discovery eprint 10216059.
`ar5iv.labs.arxiv.org/html/1810.01257` renders Nachum et al. 2019 with 235 MathML blocks
(`arxiv.org/html/` serves the same ar5iv page). **`T405` design (i)** (elicited repetition with
outcomes equalised, then a free-choice test) **found no source**. One extended search found only
reward-bearing designs, so that half of `T405`'s `Closes when` stays unsettled.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| P1 | Sherwood et al. 2020, *Invariant synapse density and neuronal connectivity scaling in primate neocortical evolution* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC8463089/` | Cereb. Cortex (2020) | `clip` | `G101` | **What `G101` asks for, measured across primates and including great apes.** Synapse density is roughly constant (1.9-fold range) across 25 species, humans and chimpanzees among them, in layers II–III and V–VI of V1 and inferior temporal cortex. Neuron density falls with brain mass, so synapses per neuron rise with brain expansion. `G101` currently rests on Herculano-Houzel 2009's claim that primates add units at constant wiring per unit, with no great apes in the cortical fit. This source measures the edge-per-unit axis directly and reports a positive primate slope, which is a tension with [[wiki/concepts/cellular-scaling-rules.md]]'s invariant-density reading. `L3`, so it lands as prose (`P25`) | `open` |
| P2 | Herculano-Houzel & Kaas 2011, *Gorilla and orangutan brains conform to the primate cellular scaling rules: implications for human evolution* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC3064932/` | Brain Behav. Evol. (2011) | `clip` | `G101` | **The cellular-scaling lab's own answer to "no great apes in the fit".** It counts cerebellar cells in 1 gorilla and 3 orangutans by isotropic fractionator and places them on the primate linear neuron-scaling rule. Caveat for the ingest: **cerebral-cortex neuron counts are extrapolated from the cerebellum, not measured**. It therefore tests whether a hominid departure exists in units only, and says nothing about edges per unit. Pair it with P1 | `open` |
| P3 | Greenstreet, Martinez Vergara, Johansson, … Clopath & Stephenson-Jones 2025, *Dopaminergic action prediction errors serve as a value-free teaching signal* | `https://www.nature.com/articles/s41586-025-09008-9` | Nature 643(8074) | `clip` | `T405` | **A measured, causally tested teaching signal for Position B's store.** In tail-of-striatum dopamine, movement-related activity encodes an *action* prediction error. Causal manipulation shows that it reinforces repeated stimulus–action pairings without value, and modelling shows it cannot drive reward-guided learning alone. `T405`'s "Where it bites" table cannot fill its first row ("teaching signal for the habit store: RPE vs none") for biology; this fills it. It also bears on the Status note that B may be two stores, because the source pairs the APE with the RPE circuit. It is **not** design (i): reward is present in the task | `open` |
| P4 | Nachum, Gu, Lee & Levine 2019, *Near-optimal representation learning for hierarchical reinforcement learning* | `https://ar5iv.labs.arxiv.org/html/1810.01257` | ICLR 2019 | `clip` | `T406` | **The domain crossing `T406` lacks, run inside one agent.** HIRO's displacement-goal agent is run with five goal spaces: raw x,y (oracle), whole raw observation, end-to-end RL-trained (co-trained), VAE and E2C (both fitted afterwards on a fixed policy's experience), and a learned representation with a bounded-suboptimality objective. These run on state-based **and** 5×5×3 top-down-image Ant tasks. The `E2E` arm against the frozen and objective-trained arms is the "learned vs co-trained" split the `Closes when` names. The cosine-direction arm is missing, so FuN's format is still not crossed | `open` |

Four rows, all `clip`. Block closes nothing alone. It gives `G101` its first great-ape and
edges-per-unit data, gives `T405` its first neural measurement of a value-free teaching signal, and
gives `T406` one agent run across both domains.
