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

## Wave 16 — the arrangement, the objective, and the parts that reject

20 targets, none of them overlapping wave 15. Wave 15 buys the **router**; this wave buys the
three things a router cannot fix: the **objective** the factorization would be trained toward
(`G30`, the wiki's deepest gap), the **arrangement** gaps `P2` says no better component closes
(`G84`, `G85`, `G88`, `G90`, `G93`), and the **rejector** the wiki has never had (`G68`, `G74`,
`G89`, `G102`). Five blocks, one INGEST each unless marked.

### 16a — the objective slot (`G30`, `P10`)

`G30` states the wiki's deepest gap in one sentence: **no page names a quantity that is
maximized when `g` is path-consistent and minimized when it is content-contaminated.** The
factorization can be built and not trained toward. Nothing in `raw/` is an objective *paper* —
seventeen joint-embedding entity pages use an objective none of them derives.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 1 | Tishby & Zaslavsky 2015, *Deep Learning and the Information Bottleneck Principle* | `https://ar5iv.labs.arxiv.org/html/1503.02406` | arXiv (ar5iv) | `clip` | `G30`, `G34` | The **candidate quantity**, and the only one with a variational form: `min I(X;T) − βI(T;Y)`. `G30` asks for something for a learning rule to ascend; this is the wiki's first. Read for whether the compression term penalises content contamination or merely nuisance | open |
| 2 | Locatello et al. 2019, *Challenging Common Assumptions in the Unsupervised Learning of Disentangled Representations* | `https://ar5iv.labs.arxiv.org/html/1811.12359` | arXiv (ar5iv) | `clip` | `G16`, `G30`, `G95` | **Theorem 1 is an impossibility result** — unsupervised disentanglement is un-identifiable without inductive bias on *both* model and data — over 12,000 trained models. `G16` currently asserts un-identifiability from data; this proves it, and so re-prices every "emergent factorization" claim in the wiki | open |
| 3 | Schölkopf et al. 2021, *Toward Causal Representation Learning* | `https://ar5iv.labs.arxiv.org/html/2102.11107` | arXiv (ar5iv) | `clip` | `G30`, `G45`, `G95` | The rival answer to row 2's impossibility: independent causal mechanisms as the **inductive bias that makes the factorization identifiable**. Also the only framing in which `G45` (no architecture can be told its latent structure) is a design choice rather than an omission | open |
| 4 | van den Oord, Li & Vinyals 2018, *Representation Learning with Contrastive Predictive Coding* | `https://ar5iv.labs.arxiv.org/html/1807.03748` | arXiv (ar5iv) | `clip` | `G30`, `G34`, `L6` | InfoNCE and its bound `I(x,c) ≥ log N − L_N`. The objective the joint-embedding block runs on, with the **proof the wiki cites second-hand**, and the bound's `log N` ceiling is the quantitative version of `G34`'s "cheapest solution is to represent nothing" | open |

### 16b — the arrangement: topology as a read variable (`G84`, `G85`, `G88`, `G93`, `P2`)

The six arrangement gaps are flagged in [[wiki/architectural-gaps.md]] as **not closable by
building a better component**, and `P2` has been carried unsorted for nine passes. `G84` names
a diagnostic (`P_i = 1 − Σ_s (κ_is/k_i)²`) that **no model in the wiki reports**.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 5 | Gu et al. 2015, *Controllability of structural brain networks* | `https://www.nature.com/articles/ncomms9414` | Nat. Commun. (open access, 303 → institutional) | `clip` | `G84`, `G85` | **Topological position computed as a control variable**, which is exactly what `G84` says no architecture has: average controllability (many easy states, default-mode hubs), modal (hard-to-reach states, control systems), boundary (integrate/segregate, attention systems). Three scalars readable off the adjacency matrix before the system runs | open |
| 6 | Bassett & Sporns 2017, *Network neuroscience* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC5485642/` | Nat. Neurosci. (PMC) | `clip` | `G84`, `G85`, `P2` | The **survey `P2` needs to sort the table**: what a graph-level property *is*, and the measure vocabulary (participation, module role, hub taxonomy) the wiki uses informally on twelve pages and defines nowhere | open |
| 7 | Goyal et al. 2019, *Recurrent Independent Mechanisms* | `https://ar5iv.labs.arxiv.org/html/1909.10893` | arXiv (ar5iv) | `clip` | `G93`, `G21`, `G91` | The **closest machine object to an addressed context channel**: `k_A` of `k_T` modules win a competition to read the input, and the losers do not update — inter-module communication is key-value addressed, not broadcast. `G93` says every wiki architecture has one global scalar or a hand-supplied label; this has neither. Note the overlap with wave 15's router block is *only* apparent — the arbitration here is over **which module runs**, not which expert scores | open |
| 8 | Seguin, Sporns & Zalesky 2023, *Brain network communication: concepts, models and applications* | `https://www.nature.com/articles/s41583-023-00718-5` | Nat. Rev. Neurosci. (gated → institutional) | `clip` | `G88`, `G85` | `G88`'s missing taxonomy. [[wiki/entities/koller-2024-connectome-traveling-waves.md]] gives the wiki **one** structure-derived routing rule (flow runs low → high instrength); this is the review of all of them — shortest path, diffusion, navigation — with the cost and delay terms. Turns `G88` from one result into a menu with a selection criterion | open |

### 16c — variables, loops and the decomposability of a compound (`G69`, `G70`, `G104`, `T287`, `T293`)

`T293` is `LIVE` and its own source hedges (*"seems to"*). `G104` says no structural code in the
wiki holds role and filler independent **during** binding. `G70` says every induced program here
is straight-line — nothing induces a loop.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 9 | Smolensky 1990, *Tensor Product Variable Binding and the Representation of Symbolic Structures in Connectionist Systems* | `https://www.sciencedirect.com/science/article/pii/000437029090007M` | Artificial Intelligence 46:159–216 | `pdf` **LOSSY** | `G104`, `T293` | The one construction where role-filler independence is **exact and provable** — `r ⊗ f`, recoverable by the unbinding vector — and the reason nothing uses it: dimension multiplies. `T293` is a disagreement about whether independence requires preserved constituents, and this is the position that answers *yes, at exponential cost*. Pre-1995 Elsevier: no HTML anywhere. Download the PDF into `raw/`, then `./tools/pdf2md.sh --layout` | open |
| 10 | Frady, Kent, Olshausen & Sommer 2020, *Resonator networks for factoring distributed representations of data structures* | `https://ar5iv.labs.arxiv.org/html/2007.03748` | arXiv (ar5iv) / Neural Computation | `clip` | `T287`, `T293`, `G104` | The **operational test `T287` is missing**: decomposability is not a property you assert, it is a factorization problem you either solve or fail. Resonator dynamics solve it in superposition with capacity quadratic in `N` — so `T287`'s separating variable gets a number, and the wiki's vector-symbolic pages (Plate, Kanerva, Joffe) get the unbinding algorithm they assume | open |
| 11 | Webb, Sinha & Cohen 2021, *Emergent Symbols through Binding in External Memory* | `https://ar5iv.labs.arxiv.org/html/2012.14601` | arXiv (ar5iv) | `clip` | `G69`, `G104` | **`G69`'s "creates variables on demand", built**: keys and values in separate memories, so the key is a content-free pointer that can bind to any filler. ≥95% on four relational tasks out of distribution. The one architecture whose abstraction is a *slot* rather than a learned feature | open |
| 12 | Dehghani et al. 2019, *Universal Transformers* | `https://ar5iv.labs.arxiv.org/html/1807.03819` | arXiv (ar5iv) | `clip` | `G70`, `G74` | The **induced loop `G70` says nothing has**: recurrence in depth with a per-position halting probability. The transformer entity pages in the wiki all have fixed depth, which is what makes every program they induce straight-line | open |
| 13 | Graves 2016, *Adaptive Computation Time for Recurrent Neural Networks* | `https://ar5iv.labs.arxiv.org/html/1603.08983` | arXiv (ar5iv) | `clip` | `G74`, `G70`, `G13` | The **ponder cost** — the wiki's first explicit price on a step of thought. `G74` says every search and refinement mechanism here assumes a wrong attempt is free; this is the term that makes it not free, and it is differentiable | open |

### 16d — the rejector, and a model of its own competence (`G68`, `G74`, `G89`, `G102`, `T291`)

`G68`: *every architecture in the wiki is a proposer; nothing is a rejector.* `G89`: nothing
models its own competence. `T291` (new, wave 14) says a failed capability test is ambiguous
between absent and undeployed, and `G102` asks for the state in which a model **holds a
capability and declines to use it** — which is what a rejector is.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 14 | Fleming & Lau 2014, *How to measure metacognition* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC4097944/` | Front. Hum. Neurosci. (PMC) | `clip` | `G89`, `T291`, `S9` | **The instrument, and it is the one that separates the two readings `T291` cannot choose between**: meta-d′ is the type-1 sensitivity a subject's *confidence* implies, so meta-d′ < d′ is precisely "holds the capability, fails to deploy it" (`G102`) measured rather than argued | open |
| 15 | Guo, Pleiss, Sun & Weinberger 2017, *On Calibration of Modern Neural Networks* | `https://ar5iv.labs.arxiv.org/html/1706.04599` | arXiv (ar5iv) | `clip` | `G89` | `G89` says nothing calibrates the estimates that come closest to a competence model. Expected calibration error is the metric and temperature scaling is the one-parameter fix — and the finding that **modern networks are worse calibrated than old ones** is the wiki's counterexample to "better representation ⇒ better decision" (`G87`) | open |
| 16 | Geifman & El-Yaniv 2017, *Selective Classification for Deep Neural Networks* | `https://ar5iv.labs.arxiv.org/html/1705.08500` | arXiv (ar5iv) | `clip` | `G68`, `G74`, `G102` | **The rejector as a trained object with a guarantee**: set the risk, get the coverage (2% top-5 ImageNet error at ~60% coverage, `p = 0.999`). The risk–coverage curve is the exchange rate `G74` needs — it is what a wrong attempt costs, in coverage | open |
| 17 | Lightman et al. 2023, *Let's Verify Step by Step* | `https://ar5iv.labs.arxiv.org/html/2305.20050` | arXiv (ar5iv) | `clip` | `G68`, `G74`, `G22` | The rejector moved **inside** the trajectory: process supervision (78.2%) over outcome supervision (72.4%) on MATH, 800k step-level labels. `G22` asks what selects which compositions get built; a per-step reward model is the first answer in the wiki that scores a partial construction rather than a finished one | open |

### 16e — who owns `τ`, and what runs when nothing is asked (`G67`, `G78`, `G94`, `G90`)

The three timescale rows were linked at the 284-source audit and **none of them has a source
that measures a `τ` hierarchy or derives one.** `G90` has no machine-side anchor at all: every
architecture in the wiki does nothing when given nothing.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 18 | Murray et al. 2014, *A hierarchy of intrinsic timescales across primate cortex* | `https://www.nature.com/articles/nn.3862` | Nat. Neurosci. (303 → institutional) | `clip` | `G67`, `G78` | **The measurement**: intrinsic `τ` ordered sensory → parietal → prefrontal, 26 monkeys, seven areas, from spike-count autocorrelation alone. `G67` asks how many timescales a model needs and where the boundaries go; this is the only answer in the record that is *measured* rather than chosen. PDF fallback: `https://johndmurray.org/papers/murray_2014_nn.pdf` | open |
| 19 | Chaudhuri, Knoblauch, Gariel, Kennedy & Wang 2015, *A Large-Scale Circuit Mechanism for Hierarchical Dynamical Processing in the Primate Cortex* | `https://www.cell.com/neuron/fulltext/S0896-6273(15)00765-5` | Neuron (403 bot block → institutional) | `clip` | `G78`, `G94`, `G88`, `G85` | Row 18's `τ` hierarchy **derived, not fitted**: one gradient of excitatory strength over a directed, weighted tract-tracing connectome, and the timescales fall out. This is the wiki's answer to *who sets `τ`* — the topology does — and it is the same claim `G88` makes about direction, on a second variable. HTML fallback: `https://www.biorxiv.org/content/10.1101/017137v1.full` | open |
| 20 | Ha & Schmidhuber 2018, *World Models* | `https://worldmodels.github.io/` | interactive article | `self` | `G90`, `G15`, `G62` | The only artefact in reach where the **internally generated mode is the training environment**: a controller learned entirely inside the model's own hallucination and transferred back. `G90` asks for an idle-time policy and an arbitrator; this supplies the generated mode and, in *Cheating the World Model*, the reason an arbitrator is not optional. Also `G62` — it is the wiki's one case of scoring a world model by what a policy can do with it | open |

**Probe notes.** Rows 5, 18 and 19 returned `303`/`403` — the Nature institutional redirect and
the Cell bot block, both already seen at wave 15 — so the rule holds: gated pages are `clip`
whatever the probe returns. Rows 1–4, 6–8, 10–17 rendered as full HTML with equations inline.
Row 20 rendered faithfully enough to take the `self` route (its interactive demos are the only
loss). Row 9 is the wave's only `pdf`: Elsevier serves no HTML for a 1990 article, and the
target is canonical enough to accept the conversion.

**Wave shape: 18 `clip`, 1 `self`, 1 `pdf` (`LOSSY`).**

---

## Archive — clipped and filed

| # | Target | Closes | Filed as |
|---|---|---|---|
