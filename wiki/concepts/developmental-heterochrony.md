# Developmental Heterochrony

**A lineage can change what a system computes without changing any of its parts, by shifting *when* a subset of its components matures — and the shift is measured as a scalar time-warp `Δ` fitted per component against a conserved trajectory shape, not as a change in the trajectory itself.**

> **Provenance.** Somel et al. 2009, *PNAS* 106(14):5743–5748 (`raw/somel-2009-transcriptional-neoteny-human-brain.md`). Microarray expression in prefrontal cortex across human, chimpanzee and rhesus macaque postnatal development, with mouse as a mammalian control. The wiki takes this source for three things: (i) a **test** — the operational way to ask whether two systems differ in schedule or in mechanism; (ii) the finding that the human shift is **mosaic, not global**, which is the specification `G100` was missing; (iii) the **age-band and tissue** the shift lands in.

The page exists because [[wiki/concepts/emergent-modularity.md]] gives the growth schedule the greatest weight of any evolutionary lever and states it only as gross volume percentages, and because `G100` names a growth schedule as missing without saying what shape one has. This source supplies the shape, and it is not the one the naive reading assumes.

---

## The premise the test needs: shape is conserved, only timing moves

| Quantity | Value | Consequence for a builder |
|---|---|---|
| Genes reliably detected in dorsolateral prefrontal cortex (DLPFC), 39 humans / 14 chimpanzees / 9 macaques | 7,958 | — |
| Variance explained: **age** | **29%** (`P < 0.001`) | — |
| Variance explained: **species** | 17% (`P < 0.001`) | **Which developmental stage a sample is from explains more of its state than which species it is.** (brainstorm) The machine analogue: *which checkpoint* plausibly dominates *which architecture* in any representational comparison, and no wiki comparison of two models controls for training-stage the way this controls for age |
| Variance explained: **sex** | <2%, **not significant** (`P = 0.54`) | The one factor a builder would expect to be a nuisance variable is one |
| Genes changing significantly with postnatal age | **71%** (FDR 10%), enriched in cell adhesion, synaptic transmission, axonogenesis (`P = 0.002`) | Postnatal development is a transcriptome-wide rewrite, not a trim |
| Fraction of total (newborn → 40 yr) change occurring in **year 1** | **~50%** | The schedule is heavily front-loaded on a linear axis — which is why the source analyses on **log₂ age from conception** |
| Trajectory correlation, human vs chimpanzee, per gene | median Pearson `r = 0.90` | |
| Trajectory correlation, human vs **mouse** | median `r = 0.83` | **The shape of the developmental curve is a mammalian invariant.** Two species separated by ~90 Myr run the same curve; evolution moves the argument of the curve, not the curve |
| Age-related genes differing between human and chimpanzee (level *or* trajectory) | **48%** | Half of what develops, develops differently — before any timing question is asked |

**The conserved-shape result is what licenses the whole method.** If the trajectory shape moved, "delayed" would be undefined. It does not move, so the entire human–chimpanzee difference in half the developing transcriptome can be asked of a *one-parameter* family.

---

## The test

For a gene `g` with expression trajectories `f_H(t)`, `f_C(t)` over `t = log₂(age since conception)`:

| | Model | Fitted by |
|---|---|---|
| **H₀ (level)** | `f_H(t) = f_C(t) + c` — a constant expression-level difference | linear regression |
| **H₁ (timing)** | `f_H(t) = f_C(t + Δ)` — a linear age transformation | nonlinear least squares (NL2SOL), `F`-test, `P < 0.05` |

- `Δ < 0` (human matches a **younger** chimpanzee) → **neoteny**; `Δ > 0` → **acceleration**.
- The test additionally requires that the age transformation explain the difference *at least as well* as the constant offset — otherwise a pure level change would score as heterochrony.
- **Polarity requires an outgroup.** Macaque assigns the change to a lineage: the distances from the 9 macaque expression values to the human age curve versus to the chimpanzee curve, one-sided Wilcoxon `P < 0.05`. Without it, "human neoteny" and "chimpanzee acceleration" are the same observation. This yields four **phyloontogenetic categories** — human-neotenic, human-accelerated, chimpanzee-neotenic, chimpanzee-accelerated.
- **Positive control on a known ordering.** Run within humans, prefrontal cortex against caudate nucleus (13 individuals, 0–46 yr): 2,979 genes age-related and region-differential, **2,261 significant for heterochrony**, and **58%** in the direction of slower prefrontal maturation — recovering the anatomically established late maturation of prefrontal cortex from expression alone.
- **Error rates.** Human-vs-human comparison gives FDR ≈ **10%**. Simulation shows a high false-*negative* rate, so every count below is a lower bound.

**(brainstorm) This is an instrument the wiki does not have, and it is not about biology.** The general form is: *given two systems whose learning curves have the same shape, is the difference between them a re-parameterisation of time, a constant offset, or neither?* Nothing in [[wiki/concepts/certification-instruments.md]] asks this. It is directly runnable on any pair of training runs — two model sizes, two data mixtures, a distilled student against its teacher — with per-unit or per-probe trajectories in place of per-gene ones, and it returns a **signed, per-component `Δ`** rather than a scalar gap at one checkpoint. The wiki's standing complaint that a benchmark number is a single point on an unmeasured curve is answered by fitting the curve and reporting `Δ`.

---

## The result: mosaic, not global

| Category (DLPFC, 14 v 14, FDR criteria) | Genes | SFG (9 v 9, different individuals, different array platform) |
|---|---|---|
| **Human-neotenic** | **114 (38%)** | **234** |
| Human-accelerated | 65 | 25 |
| Chimpanzee-accelerated | 46 | 127 |
| Chimpanzee-neotenic | 74 | 70 |
| Binomial `P` for neoteny | `2 × 10⁻⁴` | `5 × 10⁻⁴⁴` |
| Binomial `P` for human specificity | `4 × 10⁻⁸` | `1 × 10⁻⁸` |

- The excess is **robust to every knob the source could turn**: `P`-value cutoff (stringent `P<0.01` / relaxed `P<0.10`), the polynomial model class fitted per gene, the neoteny criterion, linear versus log age, using all 39 humans instead of a 14-subject age/sex-matched subset, and the assumed human–chimpanzee gestation-time difference (0 / 20 / 51 days — and the conservative choice, equal gestation, **biases against** the finding).
- **Replicated across brain region, subject set and measurement platform**, with the gene-level overlap between the two regions ~2× chance (`P < 0.01`).
- **And it touches ~4% of the cortical transcriptome.** Simulation lets the source *exclude* a transcriptome-wide neotenic shift. The classical formulation of the neoteny hypothesis — a single global slowdown of the organism (Bolk) — is measurably false at the expression level, exactly as it was progressively narrowed at the morphological level.

**Mosaic evolution, previously argued for brain structures, holds for expression schedules too: the clock is per-component, and most components did not move.**

**This puts the source at odds with how the wiki was reading its own growth-schedule lever.** [[wiki/concepts/emergent-modularity.md]] states the lever as prolongation of the *infant* window (neonatal brain 27% of adult, fetal growth rate through year 1, payoff dated to triadic joint attention at ~9 months); this source attributes human brain *size* to rapid early growth rather than an extended growth period, and locates the measurable delay a decade later, in a different tissue compartment, in ~4% of genes. Both can hold — they are claims about different variables — but the composite "the human schedule is slower" is under-specified until the variable and the age band are named ([[wiki/empirical-tensions.md]] T294).

---

## Where the shift lands — tissue and age band

| Axis | Finding | Reading |
|---|---|---|
| **Tissue** | Human-neotenic genes are over-represented among **gray-matter-specific** genes (`P = 0.06` DLPFC, `P = 0.0001` SFG) and **not** among white-matter-specific genes (`P > 0.6`) | The delayed subset is **local circuitry — synapses, dendrites, neuropil — not long-range wiring.** The tract-level connectivity runs on the ancestral clock while the thing it connects stays plastic |
| **Function** | Tendency to cluster in growth/development GO categories; **not significant per dataset** (`P > 0.1`) | The honest status: suggestive, unreplicated |
| **Age band** | Human–chimpanzee divergence is small at birth and grows for all categories; **neotenic genes diverge fastest in early adolescence, peaking ≈10 years** | The shift is **not a uniform stretch of the lifespan.** It is concentrated at one point, and the delay is spent *there* |
| **Coincidence** | That window is the period of falling gray-matter volume attributed to **synaptic elimination**, whose pace tracks cognitive-skill development (and, when abnormal, attention-deficit/hyperactivity disorder) | The delayed process is **pruning**, i.e. commitment. What is prolonged is the interval before capacity is spent |
| **Second coincidence** | The same window is sexual maturation, delayed in humans relative to chimpanzees | The source's own hypothesis: cognitive and reproductive schedules are shifted by one lever, not two |

**The source's conclusion, stated as a design claim:** delayed gray-matter maturation extends the period of neuronal plasticity associated with active learning, buying additional time to acquire knowledge and skills — the exact motivation `G100` was built on, now with a subset, a tissue and an age band attached.

---

## Reading in the core framing

| This page | Latent-graph reading |
|---|---|
| Conserved trajectory shape | The **order** in which structure is acquired is a mammalian invariant; a schedule prior does not have to specify what is learned when, only how fast the shared curve is traversed |
| Scalar `Δ` per component | The growth schedule `G100` asks for is a **vector of per-module time-warps over a shared curve**, not a global learning-rate schedule — one parameter per module, which is cheap enough to be learnable |
| Mosaic (~4%) | The prior is **sparse**: almost every component keeps the ancestral clock. A schedule that delays everything is the version the data reject |
| Gray-matter selectivity | Delay the components that **refine local connectivity**; leave the components that **route between regions** unchanged. In a modular network: freeze the routing schedule, prolong the within-module plasticity window |
| Peak at pruning | The delayed operation is **capacity commitment**, so the machine target is the schedule of whatever irreversibly spends capacity — pruning, quantisation, distillation, weight consolidation ([[wiki/concepts/continual-learning.md]]) — not the learning rate |
| Age ≫ species in variance | An architecture comparison run at one checkpoint is confounded by schedule; the comparable object is the **trajectory**, and `Δ` is the statistic that compares two of them |
| log₂ age from conception | The natural time axis for a developmental schedule is **logarithmic and origin-shifted**, which no wiki schedule uses (brainstorm) |

---

## Open problems

| # | Problem | Status |
|---|---|---|
| DH1 | **The test cannot separate a shift in *onset* from a difference in *rate*.** The source states this outright and blames sample size. Three heterochrony types are recognised (onset, rate, duration) and the instrument resolves one composite of two | Open, and it is the load-bearing ambiguity for a builder: "start module `m` later" and "run module `m` slower" are different architectures with the same signature here |
| DH2 | **4% is a lower bound of unknown tightness.** Simulation establishes a high false-negative rate but not a corrected estimate, so "mosaic" is secure and "how mosaic" is not | Open |
| DH3 | **No causal direction.** Nothing shows the delay *produces* the cognitive difference rather than accompanying it, or being a consequence of the delayed sexual maturation it coincides with | Open — the source is explicit that causes and consequences are unknown |
| DH4 | **Transcript abundance is not circuit state.** Every quantity here is bulk mRNA from postmortem tissue at 90–95% gray matter; a delayed expression curve is consistent with delayed synaptogenesis, delayed pruning, or a shifted cell-type composition, which the assay cannot distinguish | Open — single-cell data would separate them and did not exist for this design |
| DH5 | **The wiki has never fitted a `Δ`.** The instrument is cheap, needs no new machinery, and every ingredient exists (checkpointed training runs, per-unit probes). Nothing has run it, so the claim that model differences are re-parameterisations of time is untested in both directions | Open — the cheapest experiment this page implies |

---

## Connections

- **[[wiki/concepts/emergent-modularity.md]]** — supplies the molecular specification for that page's developmental lever: where it has gross volume percentages (neonatal brain 27% / 36% / 70% of adult) and a global "the human schedule is slower", this page shows the delay is carried by ~4% of the transcriptome, is gray-matter-specific, and peaks at ~10 years — so the lever that page gives the most weight to is a sparse per-component warp, not a slowdown of the organism.
- **[[wiki/concepts/continual-learning.md]]** — names what the delay is a delay *of*: the neotenic window coincides with synaptic elimination, i.e. with the operation that irreversibly commits capacity, which is the biological counterpart of importance-gated consolidation — so a growth schedule is a schedule over the *protection* operator rather than over the learning rate.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the fast/slow split there is a *rate* difference between two components that both exist from step 0; this page's split is a **phase** difference in when components stop being plastic, which is a second axis on the same factorisation and the one `G100` asks for.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — supplies the mechanism behind that page's schedule term: two learners with identical priors and identical experience can differ in acquired skill by a per-module `Δ` alone, and this page gives the first measured magnitude and the tissue it applies to.
- **[[wiki/concepts/certification-instruments.md]]** — adds an instrument the inventory lacks: fit a scalar time-warp `Δ` between two systems' trajectories and test it against a constant-offset null, which converts "system A is behind system B" from a single-checkpoint gap into a signed, per-component, falsifiable statistic (DH5).
- **[[wiki/concepts/synaptic-plasticity.md]]** — the timescale ladder there is within-lifetime and mechanism-indexed; this page adds the evolutionary timescale above it and shows that the variable selection actually moved was *when the plasticity window closes*, not which rules operate inside it.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — the natural home for a learned `Δ`: if a plasticity rule can be discovered by an outer loop, so can the per-module time-warp that decides when the rule stops applying, which is a one-parameter-per-module extension rather than a new rule class.
- **[[wiki/concepts/human-baseline.md]]** — the same protocol defect one level down: an expression profile has no meaning until the age is fixed, exactly as a benchmark score has none until the human protocol is fixed, and here age explains 29% of variance against species' 17% — the confound is larger than the effect being compared.
- **[[wiki/concepts/motivation-representation-synergy.md]]** — the other lineage-level re-weighting account, and this page constrains it: whatever motivational parameter shifted, the transcriptional evidence says the shift was carried by a small, tissue-specific subset on a conserved developmental curve rather than by a global change of pace.
- **[[wiki/concepts/core-knowledge.md]]** — bears on that page's open question about what sets developmental tuning: the shared/unique split there is content-indexed, and this page says the evolvable variable is the **schedule** on a curve whose shape is invariant from mouse to human, so a "new" competence can appear with no new content and no new mechanism.
- **[[wiki/concepts/memorisation-vs-generalisation.md]]** — the prolonged window is time spent *before* commitment, which is the same trade this page's opponent measures within a single training run; a delayed pruning schedule is the developmental version of not committing to the memorising solution early.
