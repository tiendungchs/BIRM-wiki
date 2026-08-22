# Want-list — sources to acquire

Produced by the `wiki-acquire` skill, part A. Consumed by the human's Obsidian Web Clipper.
Nothing is clipped that is not on this list; every row names the registry row it settles.

**Access:** institutional (UBO Brest) — a paywall is not a filter. The filter is **HTML vs PDF**:
a PDF conversion is lossy on exactly the equations and figures the wiki needs.

**Route column:** `clip` = human, Obsidian Web Clipper · `self` = Claude fetches and writes `raw/` ·
`pdf` = last resort, `./tools/pdf2md.sh`, flagged `LOSSY`.

**Status column:** `open` → `clipped` → `filed` (manifest + queue) → `ingested`.

After clipping, drop the files in `raw/` and run:

```bash
./tools/clip-check.sh              # validate every untracked file in raw/
./tools/clip-check.sh --manifest raw/<file>.md   # then file the manifest row
```

---

## Wave 15 — the router, the edge, and the artefacts nobody filed

20 targets. Every row names the registry row it settles and the decision that row cannot
currently make. Five blocks, one INGEST each unless marked.

### 15a — the router and the gate (`P17`)

`T283` is `LIVE` between two wiki entities that have never been run head-to-head, and the
whole machine-learning literature on the question is absent from `raw/`. `G12` has one
running router (a hand-set 0.70 threshold) and `G91` has no learning rule for a gate at all.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 1 | Jacobs, Jordan, Nowlan & Hinton 1991, *Adaptive Mixtures of Local Experts* | `https://direct.mit.edu/neco/article/3/1/79/5560/Adaptive-Mixtures-of-Local-Experts` | Neural Computation | `clip` | `T283`, `G12` | The origin of the **discriminative** gate and its objective. `T283`'s position B needs a prior: was the gate ever anything but a classifier over a fixed label set? | open |
| 2 | Shazeer et al. 2017, *Outrageously Large Neural Networks: The Sparsely-Gated Mixture-of-Experts Layer* | `https://ar5iv.labs.arxiv.org/html/1701.06538` | arXiv (ar5iv) | `clip` | `T283`, `G12` | Whether a learned gate over a **growing** expert set is trainable at all, and what it costs — the load-balancing loss is the wiki's missing answer to "how is the threshold set" | open |
| 3 | Fedus, Zoph & Shazeer 2022, *Switch Transformers* | `https://ar5iv.labs.arxiv.org/html/2101.03961` | arXiv (ar5iv) — JMLR page is a stub | `clip` | `G91`(a), `T283` | **top-1 routing is the wiki's only candidate discrete commit at scale.** Whether exclusivity is stable under training, and at what capacity factor tokens get dropped | open |
| 4 | Fedus, Dean & Zoph 2022, *A Review of Sparse Expert Models in Deep Learning* | `https://ar5iv.labs.arxiv.org/html/2209.01667` | arXiv (ar5iv) | `clip` | `T283`, `G12` | The survey column `T283` lacks: every routing algorithm tried, and which failed. Read for the **cost** dimension `G12` says every framing states in accuracy terms only | open |
| 5 | Andreas et al. 2016, *Neural Module Networks* | `https://ar5iv.labs.arxiv.org/html/1511.02799` | arXiv (ar5iv) | `clip` | `G12` | The only architecture that routes **by type** rather than by score — the structure-type arbitration `G12` asks for, and the one Zheng et al. 2024's parallel maps demand a reader for | open |
| 6 | Jang, Gu & Poole 2016, *Categorical Reparameterization with Gumbel-Softmax* | `https://ar5iv.labs.arxiv.org/html/1611.01144` | arXiv (ar5iv) | `clip` | `G91`(b) | **The learning rule for a discrete commit.** `G91` concedes that nothing says how credit reaches an admission decision; this is the mechanism, and the temperature is the continuity/commit dial the wiki has never priced | open |

### 15b — edge density, not unit count (`P25`)

`G101` is new and has **no source of its own**: 2.75× cortical volume on 1.25× the neurons,
and no result in the wiki says what a higher synapse-per-unit ratio buys.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 7 | Herculano-Houzel 2009, *The Human Brain in Numbers: A Linearly Scaled-up Primate Brain* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC2776484/` | Front. Hum. Neurosci. (PMC) | `clip` | `G101` | The **null hypothesis** for `G101`: the human brain is numerically unexceptional for its order, so whatever human cognition costs is not paid in units. Removes unit count as the free variable | open |
| 8 | Ardesch et al. 2022, *Scaling Principles of White Matter Connectivity in the Human and Nonhuman Primate Brain* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC9247419/` | Cerebral Cortex (PMC) | `clip` | `G101` | 14 primates, 350× brain-size range. It **contradicts** the neuropil reading in `G101`: bigger brains get *sparser* long-range connectivity, longer paths, higher local clustering — 1 cm² corpus callosum per 211 cm² cortex in humans. Turns `G101` from a gap into a head-to-head | open |
| 9 | Beniaguev, Segev & London 2021, *Single Cortical Neurons as Deep Artificial Neural Networks* | `https://www.cell.com/neuron/fulltext/S0896-6273(21)00501-8` | Neuron | `clip` | `G101`, `G80` | The **exchange rate**: how many artificial layers one dendritic tree is worth (5–8 layers, and NMDA is what makes it deep). This is edge density priced in units, which is exactly what `G101` says no result supplies. Fallback URL: `https://www.biorxiv.org/content/10.1101/2019.12.31.891820v2.full` | open |

### 15c — controlled shortcuts: the `I1` instrument (`P19`)

`I1` is the first row of the instrument inventory and has **no primary source for its image
half**. `raw/geirhos-2020-shortcut-learning.md` is the review that names these and nothing else.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 10 | Arjovsky et al. 2019, *Invariant Risk Minimization* | `https://ar5iv.labs.arxiv.org/html/1907.02893` | arXiv (ar5iv) | `clip` | `I1`, `G17` | The **planted-confound generator** `I1` describes, with the numbers: ERM 17.1% vs IRM 66.9% under a colour cue at ρ=0.9/0.1. Replaces Shift-MNIST as the canonical construction — the intended rule is known because it was authored | open |
| 11 | Geirhos et al. 2019, *ImageNet-trained CNNs are Biased Towards Texture* | `https://ar5iv.labs.arxiv.org/html/1811.12231` | arXiv (ar5iv) | `clip` | `I1`, `P6` | Cue-conflict is the one o.o.d. family that is **directly human-comparable**, so it supplies `L6`'s missing column and the human-baseline protocol `S9` demands | open |
| 12 | Hendrycks & Dietterich 2019, *Benchmarking Neural Network Robustness to Common Corruptions* (ImageNet-C) | `https://ar5iv.labs.arxiv.org/html/1903.12261` | arXiv (ar5iv) | `clip` | `I1` | The corruption axis quoted in `wiki/entities/dinov3.md` (19.6 / 24.1 / 22.7 / 30.0) with **no source behind the metric** — mCE's definition is currently taken on trust | open |
| 13 | ObjectNet | `https://objectnet.dev/` | benchmark site | `self` | `I1` | The controls (background, rotation, viewpoint randomised), 313 classes / 50k images, no training set by design, 40–45% drop. Thin page, but it is the construction `I1` needs, and the NeurIPS paper is PDF-only | open |

### 15d — the artefacts cited second-hand and never filed (`P20`)

Each of these is named on ≥3 wiki pages with **no file in `raw/`**. Wave 13 ingested the
continual-learning theory and left the artefacts themselves unread.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 14 | Kirkpatrick et al. 2017, *Overcoming Catastrophic Forgetting in Neural Networks* (EWC) | `https://pmc.ncbi.nlm.nih.gov/articles/PMC5380101/` | PNAS (PMC) | `clip` | `P20`, `G37` | Second-hand on five pages across nine passes. The Fisher diagonal is a **per-weight importance**, i.e. the wiki's only existing answer to "which structure is protected" — the rate-level sibling of `G52`'s writability flag | open |
| 15 | Mnih et al. 2015, *Human-level control through deep reinforcement learning* (DQN) | `https://www.nature.com/articles/nature14236` | Nature (gated → institutional) | `clip` | `P20`, `T30` | The artefact `T30` says replay licensed. Position A's engineering ancestor, and the uniform-sampling baseline wave 13 says beat every priority rule | open |
| 16 | Schaul et al. 2016, *Prioritized Experience Replay* | `https://ar5iv.labs.arxiv.org/html/1511.05952` | arXiv (ar5iv) | `clip` | `T30`, `P16` | The priority rule itself, `p_i ∝ \|δ\|^α` with importance-sampling correction. `T30`'s position B claims biology does the **opposite** — this is the object that claim is about | open |
| 17 | Rusu et al. 2016, *Progressive Neural Networks* | `https://ar5iv.labs.arxiv.org/html/1606.04671` | arXiv (ar5iv) | `clip` | `P20`, `G91` | Capacity added per task with **lateral connections and frozen columns** — the only wiki-adjacent architecture whose inter-module edge is a first-class trained object (`G52`), and a growth schedule of a crude kind (`G100`) | open |
| 18 | Pritzel et al. 2017, *Neural Episodic Control* | `https://ar5iv.labs.arxiv.org/html/1703.01988` | arXiv (ar5iv) | `clip` | `P20`, `G37`, `G38` | A differentiable neural dictionary with an explicit **write rule and an eviction rule** — the write-mask experiment (`P9`/`G52`) has a precedent here, and its allocate-vs-reuse threshold is `G38` set at design time | open |
| 19 | Silver et al. 2017, *Mastering Chess and Shogi by Self-Play* (AlphaZero / MCTS) | `https://ar5iv.labs.arxiv.org/html/1712.01815` | arXiv (ar5iv) | `clip` | `P20`, `G13` | MCTS is the wiki's most-cited unread search procedure. Read for the **PUCT selection rule** as an explicit compute-allocation policy — `G91` says the gate is also the compute-allocation signal and nothing here allocates | open |

### 15e — the replay filter (`P18`)

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 20 | Liao, Losonczy et al. 2024, *Inhibitory plasticity supports replay generalization in the hippocampus* | `https://www.nature.com/articles/s41593-024-01745-w` | Nat. Neurosci. (gated → institutional) | `clip` | `T30`, `G38` | `wiki/concepts/offline-replay.md` asserts inhibitory plasticity as the filter's substrate **on modelling grounds only**, and `T30` cannot be adjudicated from a review. This is the primary source, and it is the 2024 paper — the wiki's `P18` row says "Liao et al. 2022", which is the preprint | open |

**Probe notes.** Rows 1, 9, 14-alt and 20 returned `403`/`303` to `WebFetch`. In every case
that is a bot block or an institutional redirect, **not** a JavaScript shell or an
abstract-only stub, so the rule applies: gated pages are `clip` whatever the probe returns.
The JMLR page for Switch Transformers *was* a true stub (abstract + PDF link) and was
re-resolved to ar5iv. Row 13 is the only `self`.

---

## Archive — clipped and filed

| # | Target | Closes | Filed as |
|---|---|---|---|
