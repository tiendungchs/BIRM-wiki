# The Default Self-Model — A Capability Estimate Maintained at Baseline, and the Separate Module That Keeps It Honest

**The claim is that a brain maintains, when nothing is asked of it, a running model of *itself* — a trait-level inventory of strengths and weaknesses whose purpose is to condition future action — and that this is what the elevated resting metabolism of medial prefrontal cortex is spent on. The architecturally useful part is not the claim but its failure mode: the default self-model's output is systematically *inflated*, accuracy is not a property of the model that produces it, and the correction comes from a **different, lesionable region** (orbitofrontal cortex). Remove the corrector and the self-model keeps running, fluently, wrong, and with no internal signal that anything changed.**

> **Provenance.** Beer 2007, *The default self: feeling good or being right?*, Trends in Cognitive Sciences 11(5), doi:10.1016/j.tics.2007.02.004 (`raw/beer-2007-default-self.md`). A two-page **Research Focus commentary**, not a primary study: it reports the findings of an fMRI study by Moran et al. on self-referential trait judgment, raises an interpretive objection to it, and cites one lesion study on orbitofrontal damage and self-view accuracy. Effect sizes, sample sizes and statistics are not given in the commentary, so every number-free claim below is inherited at the commentary's own level of precision. Its speculative sections are flagged as such by the author and are marked **(tentative)** here.

Why it earns a page rather than a paragraph on a default-mode page: the wiki's control and evaluation pages ([[wiki/concepts/cognitive-control.md]], [[wiki/concepts/external-verification.md]], [[wiki/concepts/refinement-loop.md]]) all presuppose that a system can tell how well it is doing, and none of them says where that estimate comes from or who checks it. This source is the wiki's first evidence that in the biological case those are **two different circuits**, and that the default one is biased in a consistent direction.

---

## The inference chain, and where it is weak

| Step | Claim | Status |
|---|---|---|
| 1 | Medial prefrontal cortex has higher baseline metabolism than many other regions | Measured (Beer citing the resting-metabolism literature) |
| 2 | A physiological baseline reflects a *psychological* baseline — a default mode of mind when unengaged | **Hypothesis.** An argument from where the energy goes to what the energy computes |
| 3 | That default psychological mode is *generalized, automatic self-evaluation* | Hypothesis, supported by step 4 only by co-localisation |
| 4 | Explicit self-referential judgment recruits the same region | Measured (self-reference paradigm; Moran et al.) |

Steps 2–3 are the load-bearing ones and they are the ones that are not measured. The evidence for them is that the *task* engaging region X overlaps the region that is metabolically expensive *at rest* — a reverse inference of exactly the kind [[wiki/concepts/function-to-structure-inference.md]] catalogues, one level up: a functional label read off a co-localisation, with no test that the resting activity is doing the task-defined thing. A builder should take step 4 as the finding and steps 2–3 as a research programme.

---

### The primary experiment behind step 4, and what it tightens

> Gusnard, Akbudak, Shulman & Raichle 2001, PNAS 98(7):4259–4264 (`raw/gusnard-2001-mpfc-self-referential-default-mode.md`). Blocked fMRI, n = 24; the same affective pictures judged internally (*how does this make me feel*) or externally (*indoors or outdoors*), each against visual fixation.

The commentary above inherits step 4 — "explicit self-referential judgment recruits the same region" — without numbers. This is the experiment, and it strengthens step 4 while leaving steps 2–3 exactly where they were:

| What it adds | Why it matters here |
|---|---|
| The self-referential increase is in **dorsal** medial BA 8/9/10, and it is a *true increase from a passive baseline*, not a smaller decrease | The self-reference finding is not an artefact of using an attention-demanding control task — the failure mode the same paper demonstrates elsewhere in the medial wall |
| **Reaction times matched** (1.14 s vs 1.12 s, p = 0.36) | Kills the effort/time-on-task explanation with a behavioural measure, independently of the latency null the commentary reports |
| **Ventral** medial prefrontal cortex (BA 24/25/32) *decreased* in the self-referential task too | The high-baseline region is not uniformly recruited by self-reference. The tier the commentary's premise leans on (metabolically expensive at rest) and the tier that does the self-judgment are **different tiers** |
| Dorsal BA 8/9/10 activity tracks the count of stimulus-independent thoughts and is highest at rest | The nearest thing in this literature to evidence for step 2 — an idle-time measure correlating with the same region — though the thought counts are self-reports, not an independent behavioural consequence |

**The bearing on the inference chain is negative for the premise as stated.** "Medial prefrontal cortex has high baseline metabolism, therefore something self-related runs at baseline there" runs the two tiers together. Split them and the argument loses its subject: the ventral tier is the one whose resting metabolism is quoted, and it goes *down* when a person is asked to be self-referential. Any machine reading of the default self-model has to say which tier it is copying.

**The confound the commentary's design objection does not reach.** In this paradigm the self-referential judgment is an *affective* judgment — every internally cued trial reports a feeling. So the founding evidence for a self-referential medial prefrontal function cannot separate self-reference from affect, which is a second non-identification stacked under the valence/content one below.

---

## The dissociation: content axis vs valence axis

Moran et al. scanned participants rating themselves on positive (e.g. *sincere*) and negative (e.g. *liar*) personality traits on a 4-point scale (1 = not at all like me → 4 = very much like me).

| Finding | Result | What it rules out |
|---|---|---|
| Self-descriptiveness ↔ activity | Medial prefrontal cortex **and** posterior cingulate cortex activity increased with higher self-description ratings | — |
| Response latency ↔ activity | **Null.** Latency did not track medial prefrontal activity | The region is not a time-on-task / effort index — a confound that would explain the whole literature away |
| Valence ↔ activity | Ventral anterior cingulate cortex, **not** medial prefrontal cortex, tracked positive vs negative valence, most strongly for highly self-descriptive traits | Medial prefrontal cortex as an affect-driven flattery generator |

**The transferable structure: a self-judgment factors into two separately-carried quantities** — *does this predicate apply to me* (content, medial prefrontal + posterior cingulate) and *is that good* (valence, ventral anterior cingulate) — and the two are read out by different populations. Compare [[wiki/concepts/subjective-value.md]], where value is the thing being computed; here value is a **second channel alongside** the applicability estimate rather than the estimate itself. For an architecture this is the difference between a self-model that emits `p(trait | self)` and one that emits `p(trait | self)` paired with an independently-sourced `v(trait)` — the second can be ablated, re-weighted or audited without touching the first.

---

## The calibration result — the reason this page exists

| Group | Self-reported social skill vs expert judges' ratings |
|---|---|
| Orbitofrontal lesion | **Unrealistically positive** |
| Lateral frontal lesion | Not inflated |
| Healthy controls | Not inflated |

Three things a builder should extract, in increasing order of usefulness:

1. **Accuracy is not intrinsic to the self-model.** The system that generates self-descriptions and the system that keeps them true are anatomically separable, and the lesion is *specific* — lateral frontal damage does not do it.
2. **The uncorrected default is optimistic, not noisy.** The failure is a signed bias, not a variance increase. More self-evaluation by the same machinery does not fix it; the evaluator and the evaluated are the same estimator.
3. **The error is invisible from inside.** The lesion patients' self-reports are only detectable as wrong against *expert judges* — an external referent. This is [[wiki/concepts/external-verification.md]]'s thesis arriving in the self-assessment domain: an acceptance test only works if its correctness criterion is independent of the generator.

**Beer's two candidate mechanisms for what orbitofrontal cortex is doing**, which make different predictions and are not adjudicated **(tentative)**:

| Mechanism | Statement | Wiki reading |
|---|---|---|
| **A — prior attenuation** | Positive illusions are *bottom-up*, arising from assumptions built into a default social-cognition generative model, exactly as visual illusions arise from assumptions in the visual system; orbitofrontal cortex attenuates the prior against contextual constraints | A precision term: down-weight the self-prior when contextual evidence is available ([[wiki/concepts/precision-weighting.md]], [[wiki/concepts/predictive-coding-free-energy.md]]). Consistent with orbitofrontal monitoring/inhibitory function |
| **B — suppressed evidence** | Illusions arise when *negative information is suppressed* by executive control; orbitofrontal cortex is the region that processes negative information, and rose-tinted self-views come from top-down processes that fail to engage or actively suppress it | A gating failure on one *sign* of evidence — the estimator never sees the disconfirming half. Consistent with orbitofrontal involvement in negative-information processing |

The distinction matters for a machine: under **A** the fix is a calibration term applied to an otherwise-complete estimate; under **B** the fix is upstream, in what reaches the estimator at all, and no post-hoc calibration recovers evidence that was filtered out.

---

## The design objection Beer raises, and why it generalizes

Moran et al. tested positivity bias as a **main effect of valence** (positive vs negative traits) and as its interaction with self-description. Beer's objection: a self-esteem-maintaining mechanism could act on *both* valences through one route — treat positive attributes as important **and** negative attributes as irrelevant — which produces a main effect of self-description with **no** valence interaction. That is exactly the observed pattern. So the reported dissociation between "cognitive" and "emotional" self-evaluation is **not identified** by this design: a bias operating symmetrically on deviation-from-neutral is indistinguishable from unbiased content processing when the design has only two valence levels.

**Proposed fix:** add a **neutral** trait condition and test the three-level interaction (positive / neutral / negative × self-description).

The general form of this, worth carrying to the wiki's evaluation pages: **a two-level factor with no neutral midpoint cannot separate a content effect from a bias that is symmetric about the midpoint.** Any benchmark contrasting only two poles of a dimension — correct/incorrect, familiar/novel, positive/negative — inherits the same non-identifiability ([[wiki/concepts/certification-instruments.md]], [[wiki/concepts/counterfactual-probing.md]]). Beer also notes the residual that even a three-level design will not fix: whether a person's claiming of positive attributes reflects their *true* personality or an inflated self-view requires an external criterion, not a better contrast.

---

## What this buys a reasoning model **(brainstorm)**

The functional story — use idle time to maintain a model of your own strengths and weaknesses so future actions can be planned in light of them — is a component the wiki wants and does not have. Its machine analogue is **competence self-knowledge for routing**: when to abstain, when to call a tool, when to spend more inference, which sub-problems this system is bad at. Three observations:

- **The compute has to come from somewhere.** The biological claim is that this runs on "cognitive downtime" at high baseline cost. That is the same budget [[wiki/concepts/offline-replay.md]] spends on consolidation, and the two are proposed *uses of the same idle period* by different literatures. Whether a machine should run a self-audit pass offline, or derive competence estimates online from the task trace, is unasked here.
- **Trait granularity is probably wrong for a machine.** The biological self-model is a stable trait inventory updated slowly; what a reasoning system needs is per-problem-class competence, which is closer to a meta-level posterior over task families ([[wiki/concepts/meta-learning.md]]) than to a personality vector.
- **The optimistic default is a prediction, not just a bug report.** If self-serving inflation is what an *uncorrected* self-model does in a system whose self-model also feeds its motivation, then any architecture that (a) estimates its own competence and (b) is trained on a signal correlated with claimed competence should be expected to inflate — and would need its calibrator to sit outside the trained loop, with an external referent. This is a testable prediction about self-evaluating machine systems that the wiki has not tested.

---

## Open problems

| Problem | Why it is open |
|---|---|
| **Which tier the premise is about** | The resting-metabolism claim is quoted for medial prefrontal cortex as a whole, but ventral medial prefrontal cortex *decreases* during self-referential judgment while dorsal medial BA 8/9/10 increases (Gusnard et al. 2001); the argument from baseline cost to self-modelling does not survive the split intact |
| Nothing tests that the resting activity computes the task-defined function | Steps 2–3 of the inference chain rest on co-localisation. A test would need the *resting* signal to predict something about later self-relevant behaviour |
| The two orbitofrontal mechanisms (prior attenuation vs suppressed negative evidence) are not separated | They prescribe different fixes — post-hoc calibration vs upstream evidence gating — and the lesion result is compatible with both |
| No account of what the idle-time update *writes* | "Chronic, generalized updates on the self" names an output with no format, no write rule and no capacity |
| Whether accurate self-evaluation or positive illusion is normative is unsettled in the underlying psychology | Beer flags this as a longstanding debate; the neural data does not resolve it, so a builder cannot read a target calibration off biology |
| No architecture in the wiki has either half | Neither the default competence model nor its external calibrator exists in any page here — logged as `G89` in [[wiki/architectural-gaps.md]] |

---

## Connections

- **[[wiki/concepts/external-verification.md]]** — the lesion result is this page's thesis in the self-assessment domain: an inflated self-view is detectable only against expert judges, i.e. an acceptance test whose criterion is independent of the generator, and orbitofrontal cortex is the biological instance of that test being a separate module.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the inference from high resting metabolism in medial prefrontal cortex to a default *psychological* mode is a reverse inference of the same shape this page prices at the connectivity level: a function read off a co-localisation with no test that the resting signal does the task-defined thing.
- **[[wiki/concepts/precision-weighting.md]]** — Beer's mechanism A makes orbitofrontal cortex a precision term that down-weights an optimistic self-prior against contextual constraints, making positive illusions the social-cognition analogue of a visual illusion produced by an unattenuated prior.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the "self-perception illusions arise from bottom-up assumptions, like visual illusions" framing places the default self-model as a generative model whose priors dominate when the correction term is absent.
- **[[wiki/concepts/offline-replay.md]]** — both literatures claim the same resource, the idle period: replay spends it on consolidating experience into transferable structure, the default self-model spends it on updating a competence inventory, and no source in the wiki says how the budget is split.
- **[[wiki/concepts/subjective-value.md]]** — the ventral-anterior-cingulate valence channel is value computed *alongside* the applicability estimate rather than as the estimate, so a self-judgment carries two separately-readable quantities instead of one scalar.
- **[[wiki/concepts/cognitive-control.md]]** — the control layer is assumed to know how well it is doing; this page says the estimate it would use is generated by one circuit and calibrated by another, so a single controller module is the wrong factorization for self-assessment.
- **[[wiki/concepts/certification-instruments.md]]** — Beer's design objection generalizes to any instrument here: a two-level contrast with no neutral midpoint cannot distinguish a content effect from a bias symmetric about that midpoint.
- **[[wiki/concepts/counterfactual-probing.md]]** — the neutral-trait condition is the missing counterfactual level that would identify which of the two accounts generated the observed main effect.
- **[[wiki/concepts/activity-baseline.md]]** — the founding self-reference experiment's own method result cuts against this page's premise: it shows the medial wall's dorsal and ventral tiers moving in opposite directions on the same trials, so the pooled "high resting metabolism of medial prefrontal cortex" has no single tier to attach to.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — supplies the human-self-evaluation function for a region the wiki so far documents only as the rat dorsoventral control pair, and adds posterior cingulate cortex as its co-active partner in that role.
- **[[wiki/concepts/meta-learning.md]]** — the machine analogue of a trait inventory is a meta-level posterior over task families rather than a personality vector, which is where competence self-knowledge would actually live in an architecture here.
- **[[wiki/entities/default-mode-network.md]]** — the anatomy this page's default self-model runs on: the dorsomedial prefrontal subsystem is the self-referential constructor, and it is anticorrelated with the medial temporal subsystem that supplies its episodic material, so the estimator and its evidence source are not directly coupled.
- **[[wiki/concepts/activity-baseline.md]]** — the measurement this page's premise rests on: medial prefrontal cortex is metabolically expensive at rest, but the same data show tonic rate and engagement state are orthogonal (posterior cingulate runs ~40% above the global mean *at baseline*), so "high resting metabolism" alone does not establish that anything is being computed there.
- **[[wiki/entities/global-neuronal-workspace.md]]** — the same paralimbic set (medial prefrontal/anterior cingulate, medial parietal/posterior cingulate, temporoparietal junction) reached from the access side, together with the framework's admission that it has no theory of meta-representation: its one concrete proposal is error awareness as a consistency check between a fast unconscious perception→action route and a slower conscious route computing the intended response.
