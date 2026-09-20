# State Prediction Error — the Error Term for an Edge That Has No Value

**An error on *which event follows which*, computed where no reward exists and no value can be assigned: `δ_S = x_obs − x̂(·|c)`, the discrepancy between the sensory event that occurred and the one the current cue predicted. Its existence is shown behaviourally by *blocking of sensory preconditioning* — a neutral cue already predicted by another cue fails to acquire the link, so stimulus–stimulus learning tracks contingency, not contiguity. Its carrier in the mammalian brain is the same phasic ventral tegmental dopamine transient the wiki reads as a reward prediction error, which is both sufficient and necessary for writing the valueless link.**

> **Provenance.** Sharpe, Chang, Liu, Batchelor, Mueller, Jones, Niv & Schoenbaum 2017, *Dopamine transients are sufficient and necessary for acquisition of model-based associations*, Nature Neuroscience 20(5):735–742 (`raw/sharpe-2017-dopamine-transients-model-based-associations.md`). Two optogenetic experiments in tyrosine-hydroxylase-Cre rats (AAV5-EF1α-DIO-ChR2-eYFP `n` = 18; AAV5-EF1α-DIO-eNpHR3.0-eYFP `n` = 17; AAV5-EF1α-DIO-eYFP controls `n` = 43; 90% of YFP-expressing ventral tegmental neurons tyrosine-hydroxylase-positive), plus a lithium-chloride devaluation arm (`n` = 10). The term *state prediction error* is the source's own label for the quantity, borrowed from model-based reinforcement learning; everything below is from that source unless marked.

Why this earns a page rather than a row on [[wiki/concepts/reward-prediction-error.md]]. That page's five readings of the dopamine record all put a *value* term in the formula and disagree only about what the value is for. This result removes the value term entirely and keeps the error, which is a different quantity with a different consumer: it writes an edge into a transition model that no policy yet scores. [[wiki/concepts/higher-order-conditioning.md]] established that sensory preconditioning stores a bare identity link; this supplies the learning rule that writes it and the signal that gates it.

---

## The two experiments

| | **Experiment 1 — sufficiency** | **Experiment 2 — necessity** |
|---|---|---|
| Design | blocking *of* sensory preconditioning | standard sensory preconditioning, within-subject control |
| Phase 1 | `A→X` (16 trials), then `A→X` (8), `AC→X` (8), `AD→X` (8), `EF→X` (8); all 10 s cues, no reward | `A→X` (12), `B→Y` (12); no reward |
| Manipulation | 473 nm, 20 Hz, 2 s at **onset of X** on `AC` trials; identical light in the inter-trial interval (120–180 s after X) on `AD` trials | 532 nm continuous, 2.5 s from 500 ms before `B` offset through the first 2 s of `Y`; `A→X` unlit |
| Phase 2 | `X → 2 sucrose pellets`, 24 trials/day × 4 days | `X → US₁`, `Y → US₂` (different flavours), 24 trials/day × 4 days |
| Probe (no reward) | `C`, `D`, `F` × 4 each | `A`, `B` × 6 each |
| Baseline result | `F > D` in **both** groups — blocking of a purely neutral association | `A = B` in eYFP controls |
| Effect | `C > D` in ChR2 only (`F₍₁,₃₅₎ = 8.52`, `p = 0.006`); `C` higher in ChR2 than eYFP (`p = 0.028`); `D` equal across groups | `B < A` in NpHR only (`F₍₁,₃₉₎ = 4.952`, `p = 0.012`); cue × group interaction `p = 0.037` |
| Reading | a dopamine transient at the predicted event **reinstates** the blocked link | removing the transient at the transition **prevents** the link |

**The baseline result is the load-bearing one and is independent of any optogenetics.** `D` — a novel cue compounded with an already-sufficient predictor `A` — does not acquire the `→X` link, while `F` in a novel compound `EF` does. Neutral-cue learning is therefore governed by an error term, not by co-occurrence. The wiki had no prior evidence that Kamin blocking extends to pairings in which nothing motivationally significant occurs.

---

## What rules out the cheaper explanations

| Alternative | Killed by |
|---|---|
| The transient added **cached value** to `C` | `C`'s conditioned responding is abolished by post-training lithium-chloride devaluation of the sucrose pellets (`F₍₁,₈₎ = 6.777`, `p = 0.031`; consumption test `p = 0.006`). Cached value generalises across outcomes and is devaluation-insensitive |
| The transient **reinforced a motor response** | No food-cup response existed during phase 1 — nothing was being emitted to reinforce — and a directly reinforced response would also be devaluation-insensitive |
| The transient raised **salience / associability of X** | Every associability account predicts lasting effects on `X`: ChR2 rats did not respond more to `D`, did not condition faster to `X` in phase 2, and NpHR rats learned `Y` normally. Also the wrong sign against the extinction literature, where the same activation *slows* extinction |
| Light *per se* | `AD` trials carried identical light in the inter-trial interval and produced nothing — the effect is locked to the 2 s at the predicted event |

---

## What the result does to the wiki's reading of `δ`

| Before | After |
|---|---|
| `δ` is an error about reward, formula `r + γV(s′) − V(s)` | `δ` also appears where `r` is undefined; the reward case is plausibly the strongest instance of a general error over *predicted events* |
| Dopamine writes scalar value onto a cue | Dopamine gates the formation of an **associative link between two sensory representations**, whose content is set elsewhere |
| Firing to novel neutral cues is a "novelty bonus" — an additive term bolted onto the value formula | The same firing may be the informational error available when a neutral event is unpredicted, i.e. the signal this page names, with no bonus needed |
| Model-based structure learning has no identified teaching signal in the wiki (`T404` position B) | It has one, and it is the same projection — which is a necessity test on the side of one broadcast signal teaching more than one learning product |

**The content problem is not solved and the source says so.** The manipulation activates or silences a general, virally and optically determined subset of ventral tegmental dopamine neurons ([[wiki/entities/ventral-tegmental-area.md]]), yet the resulting link is *specific* — `C→X`, not `C→anything`. So the identity of what gets linked cannot be in the scalar. The source's own proposal is that it comes from (i) subtle variation in the content of the signal across dopaminergic ensembles and (ii) specialization of the downstream target, which is the address problem of [[wiki/concepts/reward-prediction-error.md]] restated for structure rather than for credit.

---

## What a builder takes

| Finding | Consequence for an architecture |
|---|---|
| Edge acquisition is **error-gated**, not co-occurrence-gated | A transition model trained on every observed pair is doing something the animal does not. The biological learner writes an edge only when the successor was *unpredicted*, which is a free sparsification and an automatic stop on redundant edges (`G17`, [[wiki/concepts/latent-graph-discovery.md]]) |
| One broadcast scalar gates the write, the pair being written supplies the address | The cheapest possible structure-learning rule: a global "this was unpredicted" pulse times a local conjunction. No per-edge error, no backward pass, no identity in the signal |
| The signal that scores edges and the signal that gates writing them are the same projection | An agent can be built with **one** modulator serving both the value head and the transition model; the wiki's architectures give the transition model its own reconstruction loss and never test whether a gate would do |
| Structure is written before any value exists, then valued wholesale by one terminal episode | Graph *acquisition* and graph *scoring* are separable operations over the same observations, and the separation is now mechanistic rather than behavioural (see [[wiki/concepts/higher-order-conditioning.md]]) |
| Blocking applies to valueless pairings | A structure learner that already predicts `X` from `A` should refuse to learn `C→X` in the `AC` compound. No wiki world-model does; all would fit both edges, which is the redundancy the biology prices |
| Timing window is ~2 s at the successor's onset | The gate is aligned to the *predicted event*, not to the cue and not to the trial. A model-based analogue needs a write-enable clocked by successor onset |

---

## Open problems

- **No recording.** Both experiments are interventions; nothing here measures a dopamine transient during an un-blocked neutral-cue transition, so the error signature (present on unpredicted `X`, absent once `A` predicts it) is inferred from behaviour rather than observed.
- **Stimulation is not physiology.** 2 s of 20 Hz drive exceeds the natural peak duration, and the activated cells are selected by viral expression and light penetration — the source states outright that no optogenetic pattern reproduces normal activity.
- **Inference versus mediated learning is undecided.** The probe response to `C` is consistent with chaining at test (`C→X`, `X→US`, so `C→US`) or with mediated conditioning during phase 2 (`X` evokes the memory of `C`, which is then paired with the US directly). Dopamine acts on the phase-1 association either way, but the two differ in *when* the chain is composed — which is exactly the question [[wiki/concepts/simulation-based-planning.md]] cares about.
- **Where the specificity comes from is unmeasured** — the ensemble-content and downstream-specialization proposals above are speculation in the source, and the calcium-imaging experiment that would separate them is named and not run.
- **The error is never written as a formula.** `δ_S` at the head of this page is the wiki's reconstruction; the source argues for its existence and never states what quantity is differenced, which matters because a sensory error is a vector and the carrier measured here is a scalar.
- **Aversive and appetitive structure learning are not compared.** Only appetitive outcomes are used downstream, so whether the same transient writes edges into a structure later valued negatively is untested.

---

## Connections

- **[[wiki/concepts/reward-prediction-error.md]]** — the same firing record with the value term deleted: this page's error exists where `r` is undefined, and its carrier is that page's projection, so either the reward error is a special case of an error over events or the projection carries two error types. It also supplies the necessity test that page's reading 1 had been missing in the non-incentive direction (`T404`).
- **[[wiki/concepts/higher-order-conditioning.md]]** — supplies the learning rule for that page's third paradigm: sensory preconditioning writes a bare identity link, and this page shows the write is gated by an error and by a dopamine transient, so the valence-free link is not a passive record of co-occurrence.
- **[[wiki/concepts/latent-graph-discovery.md]]** — an edge estimator with a stopping rule: an edge is written only when the successor was unpredicted, which is the biological answer to the coactivity-counting failure that page logs, and it arrives with an identified broadcast gate rather than a per-edge loss.
- **[[wiki/entities/ventral-tegmental-area.md]]** — the structure manipulated, and the tension between the two results: the channels there are near-disjoint labelled lines selected by afferent, while the manipulation here is deliberately unaddressed and still produces a specific link — so either the content is supplied downstream or the relevant line was hit by chance.
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — the other error in the wiki computed against something that is not primary reward; that one is still an error about *value*, over a subgoal, while this one is an error about *which event occurs*, and the two make the same demand on the architecture — a second error term that must not be allowed to update the root value function (`T367`).
- **[[wiki/concepts/prediction-error-neurons.md]]** — the cortical counterpart of the same quantity, and the contrast that matters: there the error over sensory events is computed locally, per feature, with the sign split across two cell classes; here it arrives as one subcortical broadcast pulse with no feature identity at all.
- **[[wiki/concepts/sign-tracking-and-goal-tracking.md]]** — the opposing necessity test on the same projection: there receptor blockade during acquisition leaves the predictive cue–outcome map intact, here optogenetic suppression across a cue–cue transition removes it, and the pair is the live content of `T404`.
- **[[wiki/concepts/incentive-salience.md]]** — the complement, not the rival: that page's cue-bound pull carries no outcome identity, while the link written here is devaluation-sensitive and therefore identity-bearing, so one projection is implicated in producing both an identity-free pull and an identity-preserving edge.
