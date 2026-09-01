# Metacognitive Efficiency — Separating What a System Knows About Its Own Answers From How Good the Answers Are

**A self-assessment is not one quantity but three, and they are independently manipulable: *bias* (how confident the system is overall), *sensitivity* (how well its confidence discriminates its own correct outputs from its own incorrect ones) and *efficiency* (sensitivity measured against the ceiling that task performance itself imposes). Only the third is a property of the introspective machinery rather than of the task — and every confidence number in this wiki is one of the first two, reported without the correction that would make it comparable across models or across benchmarks.**

> **Provenance.** Fleming & Lau 2014, *How to measure metacognition*, Frontiers in Human Neuroscience 8:443 (`raw/fleming-2014-how-to-measure-metacognition.md`). A **methods review**, not a primary study: it inventories measures, states what each confounds, and recommends one. Every number attributed below to Galvin, Maniscalco, Jang, Murphy or Yaniv is the review's report of their work. The domain is human psychophysics; the machine readings in the penultimate section are this wiki's and are marked.

Why this earns a page: [[wiki/concepts/default-self-model.md]] argues that competence self-knowledge is an architectural component and that its calibrator must sit outside the estimating loop (`G89`), and [[wiki/concepts/external-verification.md]] prices the independent acceptance test. Neither says **how to score a self-assessment**, and the wiki has been quoting three mutually incomparable confidence statistics — an RMS calibration error, an AUROC, an abstention rate — as if they measured the same thing. They measure different terms of the same decomposition.

---

## The type-2 table — the object every measure is a function of

Type 1 = discriminating states of the world. Type 2 = discriminating one's own correct responses from one's own errors, conditioned on the *response*, not on the stimulus (Clarke et al. 1959).

| Type 1 decision | High confidence | Low confidence |
|---|---|---|
| **Correct** | type 2 hit `H2` | type 2 miss `M2` |
| **Incorrect** | type 2 false alarm `FA2` | type 2 correct rejection `CR2` |

Every measure below is an operation on `P(confidence, accuracy)`. The design precondition for all of them: **stimulus strength held constant**, so that fluctuations in accuracy come from noise inside the observer rather than from the input. A confidence statistic pooled over a difficulty range is measuring the difficulty range.

---

## The ladder of measures, and what each one still confounds

| Measure | Definition | Removes | Still confounded by |
|---|---|---|---|
| **φ (phi)** | Pearson `r` between the accuracy vector `[0 1 1 0 …]` and the binarised confidence vector | — | **Bias** and performance. "Margin sensitive": its value depends on the row and column sums of the table |
| **Goodman–Kruskal γ** | Rank-order association, extends to rating scales; adopted because it assumes no distributional form (Nelson 1984) | Distributional assumptions | **Bias** — shown by simulation (Masson & Rotello 2009); and performance. Most classic metamemory findings rest on it |
| **type 2 `d′`** | `d′₂ = z(H2) − z(FA2)` (Kunimoto et al. 2001, as `a′`) | Bias, *if* the type-2 distributions were equal-variance Gaussian | **They are not.** If equal-variance Gaussian holds at type 1, Galvin et al. 2003 show the type-2 distributions are unequal-variance and non-Gaussian, so the correction fails and bias leaks back in (Evans & Azzopardi 2007) |
| **AUROC2** | Area under the type-2 ROC, built by treating each confidence level as a criterion splitting high from low and plotting the resulting `(FA2, H2)` pairs | Bias, **non-parametrically** — no distributional assumption to be wrong about | **Task performance.** Galvin et al. 2003 prove AUROC2 depends on type 1 `d′` *and* on type 1 criterion placement; confirmed experimentally (Higham et al. 2009) |
| **meta-`d′`** | The type 1 `d′` that a *metacognitively ideal* observer would need in order to produce the observed type-2 data. Well-posed because the family of ideal type-2 ROCs indexed by type 1 `d′` is non-overlapping, so one criterion point identifies the curve | Bias, and the parametric problem | Cannot separate *causes* (below) |
| **meta-`d′`/`d′`** | **Metacognitive efficiency.** Ratio of the evidence available to the confidence rating over the evidence available to the decision | Bias **and** performance | Unstable when `d′` is small (ratio blow-up); use `log(meta-d′/d′)`, or `meta-d′ − d′` |
| **SDRM** | Two correlated evidence samples per item — one driving the response, one driving the confidence — drawn from a bivariate distribution with correlation `ρ`, plus explicit trial-to-trial criterion variability (Jang, Wallsten & Huber 2012) | Bias and performance, **and it separates the two causes** | Requires interpreting parameter fits; heavier than meta-`d′` |

**Fleming & Lau's recommendation is meta-`d′`**, with AUROC2 as the non-parametric fallback and φ/γ deprecated. Normative tests (Barrett, Dienes & Seth 2013) find meta-`d′` robust to bias changes and able to recover simulated changes in sensitivity.

---

## Why efficiency has to exist — the performance ceiling

The argument is one line and it is the whole reason the ratio is defined:

> A system performing a two-choice task **at chance** gets half its trials right *by fluke*. There is nothing internal that distinguishes a fluke-correct trial from a fluke-incorrect one. So at `d′ = 0`, ideal type 2 sensitivity is **also 0**.

Ideal type-2 performance is therefore *bounded by* type-1 performance, monotonically. Consequences:

| Consequence | Statement |
|---|---|
| **Interpretation** | meta-`d′` is in units of `d′`, so the two are directly comparable: `meta-d′ = d′` is the ideal observer; `meta-d′/d′ = 0.7` means **30% of the evidence used for the decision is lost on the way to the confidence rating** |
| **Cross-domain comparison** | Efficiency is the only one of the three that can be compared across tasks whose difficulty cannot be matched — visual vs memory metacognition, patients vs controls, adolescents vs adults (efficiency rises through adolescence, Weil et al. 2013), species vs species |
| **The Dunning–Kruger artefact** | Kruger & Dunning 1999's "the incompetent cannot recognise their incompetence" has **two** readings, and their one-shot discrepancy score cannot separate them: (i) a mechanical consequence of type 2 sensitivity being bounded by type 1 `d′` — worse performers *must* make noisier ratings; (ii) a genuine reduction in *efficiency* with skill. Only trial-by-trial efficiency distinguishes them, and it has not been run |
| **What meta-`d′` still cannot do** | It cannot separate **criterion noise** (trial-to-trial jitter in where the confidence boundaries sit) from **evidence noise** (extra noise in the signal the rating reads). Both show up as lower efficiency, and they prescribe different fixes. SDRM's `ρ` plus explicit criterion variance is the model that separates them |

---

## The same result from the forecasting literature

The judgment-and-decision field derived the identical warning independently, via proper scoring rules.

```
PS   = (f − c)²                                   probability score; f = stated probability, c ∈ {0,1}
Brier = mean PS over items                         (Brier 1950)
PS   = O + C − R                                   (Murphy 1973)
O    = c̄(1 − c̄)                                    outcome index — the variance of correctness itself
C    = (1/N) Σⱼ Nⱼ (fⱼ − c̄ⱼ)²                       calibration — do stated 80%s come true 80% of the time (lower better)
R    = (1/N) Σⱼ Nⱼ (c̄ⱼ − c̄)²                       resolution — do corrects and errors land in different bins (higher better)
```

**`O` is a pure task-performance term** — maximal at chance, minimal at ceiling — and it sits additively inside the aggregate score. So the Brier score is contaminated by performance for exactly the reason φ is: **a raw confidence-accuracy association is partly an accuracy score.** The field's fix is the same in shape as meta-`d′`/`d′`: a bias-free discrimination index normalised for performance (ANDI, Yaniv, Yates & Smith 1991).

**The dictionary that makes the two literatures one page:**

| Probability-scoring term | Metacognition term | What it answers |
|---|---|---|
| Calibration `C` | Metacognitive **bias** | Does the stated number match the base rate? |
| Resolution `R` | Metacognitive **sensitivity** | Do correct and incorrect answers get *different* numbers? |
| Outcome `O` | Type 1 `d′` (the confound) | How hard was the task? |
| ANDI | meta-`d′`/`d′` | Sensitivity net of the two above |

Calibration and resolution are **doubly dissociable**, and the worked example is the one a builder should keep: a subject rating every correct answer 90% and every error 80%, at 60% true accuracy, is badly *calibrated* and has excellent *resolution* — one affine correction turns her into an ideal forecaster, because the information is present and the mapping onto the scale is wrong. Fleming & Lau note the learning of that mapping is barely studied.

---

## What the wiki's existing confidence numbers actually measure

Every reading below was already in the wiki; the decomposition is what this ingest adds. **None of the three is an efficiency measure, and no two of them are comparable.**

| Wiki measurement | Term it is | What it does *not* license |
|---|---|---|
| [[wiki/entities/hle.md]]: **RMS calibration error 73–89%** at 2.7–13.4% accuracy, 2,500 items | Calibration `C` — a pure **bias** measure | Any claim that these models cannot *discriminate* their own errors. A system with perfect resolution and a broken scale reads exactly like this |
| [[wiki/entities/math-dataset.md]]: **AUROC 68.8%** separating GPT-2's correct from incorrect answers by its own mean token probability | **AUROC2**, literally — the wiki's one sensitivity measurement | Reading it as near-useless *without* the performance correction — Galvin et al. 2003 show `AUROC2` moves with type 1 `d′` and with criterion placement, and at 6.9% accuracy that term is not small. Its **sign is not known here**: the ceiling result assumes a bounded response set where low-`d′` correct answers are flukes, and free generation into an unbounded answer space has chance ≈0, which is the same property that leaves `d′` undefined on this benchmark |
| [[wiki/entities/gpqa.md]]: **abstention 4.0% → 37.2%** under a search tool, accuracy flat (+0.7) | A **criterion shift** — pure bias, at matched type 1 performance | The wiki's own brainstorm reading (the tool "improved the system's self-knowledge by ~33 points"). A bias change at matched `d′` is only interpretable as awareness/self-knowledge if sensitivity is separately shown to be positive and unchanged — the Schwiedrzik et al. 2011 logic. Nobody measured sensitivity in either arm |
| [[wiki/entities/hle.md]]'s unexplained ordering — the two *best* models have the two lowest calibration errors, and the page's rival explanation (ii) is that "calibration error is partly mechanical" | The **performance confound**, rediscovered | The page's proposed fix — re-score calibration on the subset each model gets right — is an ad-hoc matched-difficulty design. meta-`d′`/`d′` is the principled version and needs no subsetting |

**The blocking problem for importing the measure, stated honestly.** Type-2 SDT presupposes a type 1 `d′`, which presupposes a bounded response set with a definable hit and false-alarm rate. HLE, MATH and ARC are open-ended generation: there is no false-alarm rate, so `d′` — and therefore meta-`d′` and the efficiency ratio — is **undefined as stated** for most of the wiki's benchmarks. Three routes, none run *(brainstorm)*: (i) score the multiple-choice subsets only (HLE ships 24% multiple-choice with 5+ options, GPQA is 4-way throughout) and accept that the efficiency estimate covers a non-random slice; (ii) treat *abstention* as the type 1 response and correctness as the state, which gives a well-formed 2×2 at the cost of measuring the abstention policy rather than the confidence scale; (iii) recover a `d′` from a best-of-`k` sample by treating the model's own answer distribution as the internal evidence variable. Until one of these is done the wiki can report calibration and resolution — both of which are defined on any confidence-plus-correctness log — but not efficiency.

---

## What this buys a reasoning model **(brainstorm)**

- **It names the right training target for a routing head.** A system that decides *when to abstain, verify, re-plan or call a tool* ([[wiki/concepts/external-verification.md]], `G89`) needs resolution, not calibration: it needs corrects and errors to land in different bins. Calibration is an affine post-hoc fix on a scale; resolution is information that must be there or not. The two failure modes need different engineering, and a single scalar "confidence error" hides which one a system has.
- **The ceiling argument supplies a free null.** Any claim that an architecture "knows what it does not know" has an ideal-observer bound computable from its own accuracy — the machine analogue of the randomly-initialised-network null [[wiki/concepts/certification-instruments.md]] demands for violation-of-expectation scores. A confidence read-out that merely tracks its own accuracy is at the bound and has added nothing.
- **The evidence-loss framing is architecturally concrete.** `meta-d′/d′ < 1` says the confidence path sees *less* of the evidence than the decision path. In a transformer reading confidence off the same forward pass that produced the answer, the ratio should be ~1 by construction and the interesting question is why it is not; in an architecture where the monitor is a separate module ([[wiki/concepts/default-self-model.md]]'s orbitofrontal corrector), a ratio below 1 is the price of the separation and the ratio *is* the interface bandwidth. That makes efficiency a measurement of an architectural boundary rather than of a personality trait.
- **`meta-d′ > d′` is possible and is a positive result.** Nothing forbids the confidence path from reading evidence the decision path did not use — post-decisional accumulation, a second retrieval, a tool call. A ratio above 1 is the signature of a monitor that is not a read-out, which is precisely what `G89` asks for.
- **Efficiency is the comparison currency across problem classes.** [[wiki/concepts/default-self-model.md]] argues a machine wants per-problem-class competence rather than a trait vector. Per-class competence estimates are useless if each class has a different difficulty, because sensitivity moves with difficulty; the ratio is what makes "this system knows itself better on geometry than on chemistry" a statement about the system.

---

## Open problems

| Problem | Why it is open |
|---|---|
| **`d′` is undefined for open-ended generation** | The blocking problem above. The three proposed routes each measure something slightly different from what the ratio was defined to measure |
| **Criterion noise vs evidence noise is unseparated** | meta-`d′` collapses them; SDRM separates them at the cost of parameter interpretation, and has never been fitted to a machine system |
| **The scale-learning problem is unstudied** | How the mapping from an internal discrimination onto a probability scale is *learned* — the calibration half — "has received relatively little attention" even in humans, and it is the half a machine can fix cheaply if resolution is present |
| **Low sensitivity does not imply no awareness** | Fleming & Lau's caution: metacognitive sensitivity is scored against the *world*, so a system hallucinating vividly and rating its hallucination confidently is indistinguishable from one with no internal state to introspect. The measure indexes agreement with the environment, not the presence of a representation. Bears on `T269` and on [[wiki/entities/global-neuronal-workspace.md]]'s error-awareness proposal |
| **The Dunning–Kruger reading is undecided** | Mechanical ceiling vs genuine efficiency loss with skill; the discriminating experiment (trial-by-trial efficiency across a skill range) is described here and not run — and it is the same experiment that would settle `T315` |
| **No architecture in the wiki has been measured on any of the three** | `G89`. The instrument now exists in the wiki; the measurement does not |

---

## Connections

- **[[wiki/concepts/default-self-model.md]]** — supplies the measurement theory that page's central result lacks: the orbitofrontal-lesion inflation finding is a *one-shot discrepancy score*, exactly the design Fleming & Lau show cannot separate a signed bias from a loss of sensitivity, which is `T315`.
- **[[wiki/concepts/external-verification.md]]** — the two halves of one question: that page asks whether an acceptance test is independent of the generator, this one asks how much of the generator's evidence the test actually sees, and `meta-d′/d′` is that quantity.
- **[[wiki/concepts/certification-instruments.md]]** — contributes `I33` (confidence-resolution measurement corrected against the ideal-observer ceiling) and a third instance of `F15`: a raw confidence–accuracy association is partly an accuracy score, and `PS = O + C − R` is the arithmetic fix.
- **[[wiki/concepts/precision-weighting.md]]** — precision is the quantity a confidence rating is supposed to report; this page says the report factors into a gain term (bias) and an information term (sensitivity), and only the second tells you whether the precision estimate was ever computed.
- **[[wiki/concepts/evidence-accumulation.md]]** — the type 1 side: a decision variable crossing a bound produces both the response and the raw material for confidence, and `meta-d′ < d′` measures how much of that accumulated evidence fails to reach the confidence read-out.
- **[[wiki/entities/hle.md]]** — its RMS calibration column is the calibration term `C` alone, so the wiki's largest confidence measurement licenses a claim about the scale and not about discrimination; and its unexplained calibration-vs-accuracy ordering is the performance confound this page names.
- **[[wiki/entities/math-dataset.md]]** — its AUROC 68.8% *is* AUROC2, the wiki's only sensitivity measurement, reported without the type-1 correction that Galvin et al. 2003 show it needs.
- **[[wiki/entities/gpqa.md]]** — the 4% → 37% abstention shift at matched accuracy is a pure criterion move, so it is bias evidence rather than self-knowledge evidence until sensitivity is measured in both arms.
- **[[wiki/concepts/human-baseline.md]]** — the reference-system problem in its self-assessment form: comparing metacognition across groups requires matching type 1 performance or dividing it out, and no human/machine confidence comparison in the wiki does either.
- **[[wiki/entities/global-neuronal-workspace.md]]** — its one concrete meta-representation proposal (error awareness as a consistency check between a fast and a slow route) is a *sensitivity* mechanism, and this page's ceiling argument bounds what such a check can deliver at a given level of first-order performance.
- **[[wiki/concepts/selective-prediction.md]]** — the policy this page's measurement licenses, and a narrowing of what it must deliver: a threshold on any confidence rate absorbs every monotone re-scaling of the scale, so an abstention policy needs **sensitivity only** — calibration is irrelevant to it — and the risk–coverage curve is that sensitivity reported where `d′` is undefined. It also supplies a hard counter-baseline: raw max-softmax, a same-forward-pass read-out whose efficiency should be ~1 by construction, beats MC-dropout by a factor of two on ImageNet (`T320`).
