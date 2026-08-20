# Skill-Acquisition Efficiency

**Intelligence is the rate at which a system converts priors and experience into skill at tasks it has not seen before, weighted by how much those tasks require going beyond what was seen — not the skill itself.**

> **Provenance.** Chollet 2019, *On the Measure of Intelligence* (`raw/chollet-2019-measure-of-intelligence.md`). Formal apparatus is Algorithmic Information Theory (AIT), the same machinery as [[wiki/concepts/universal-induction.md]], turned to a different question: not *what should a learner believe* but *how do we score one*.

This page is the wiki's answer to gap G17 (no evaluation protocol can certify structure discovery). It supplies the missing instrument in a form the earlier candidates lacked: a *quantity* (generalization difficulty) rather than a *test genre*.

---

## The two gaming channels

Skill at a task is not a property of the learner. It is the output artifact of the learner — a *skill program*. The same skill can be bought two ways without any generalization:

| Channel | Mechanism | Wiki reading |
|---|---|---|
| **Unlimited priors** | Developer inspects the task, solves it, hard-codes the solution (DeepBlue; the if/else chatbot; every "psychometric AI" system that hard-coded IQ-test transformations) | The `g` structure is supplied by a mind outside the system; the artifact carries none of the process |
| **Unlimited experience** | Dense sampling of situation space; a locality-sensitive hashtable already suffices to "solve" any task with a generator (OpenAI Five: 45,000 years of play, beaten by non-champion humans within days of public access, and only ever played 16 of 100+ characters) | Local generalization with a fixed radius, independent of data volume |

**Consequence:** *skill measured without controlling priors and experience measures the developer, not the system.* This is the process/artifact confusion — the "AI effect" is not goalpost-moving but a correct detection that the artifact was mistaken for the process.

**The `IS` / skill-program separation is the actionable part.** Chollet's formalism splits the system into a program-synthesis engine (`SkillProgramGen`, `ISUpdate`, `isState`) that possesses intelligence, and the skill program it emits, which possesses none. Reinforcement learning's monolithic "agent" — sensory input to behaviour, one black box — is the thing this separation is set against.

---

## Spectrum of generalization

| Degree | Definition | Wiki reading | Example |
|---|---|---|---|
| **None** | No uncertainty; behaviour enumerable in advance | Graph fully given | Exhaustive tic-tac-toe; a proven sorting algorithm |
| **Local** (robustness) | New points from a *known distribution*, given dense sampling — "known unknowns within one task" | Instance-graph interpolation; the node set and edge vocabulary are fixed | Image classifier; all of supervised deep learning |
| **Broad** (flexibility) | A broad category of tasks and environments without human intervention — "unknown unknowns across related tasks" | Meta-graph transfer within a domain family | L5 self-driving; Wozniak's coffee-cup test. **No system today** |
| **Extreme** (generality) | Entirely new tasks sharing only *abstract commonalities* — "unknown unknowns across an unknown range of domains" | Meta-graph induction over unseen domain families | Humans only |

Two orthogonal cuts on top of the ladder:

- **System-centric** generalization: situations the *system* has not seen. Statistical learning theory's generalization error lives here, and it ignores everything the developer injected.
- **Developer-aware** generalization: situations neither the system *nor its developer* has seen. Equivalent to system-centric generalization when the developer is counted as part of the system. **Only this one is gameable-proof**, and it is what any benchmark claiming to measure abstraction must target.

The ladder maps onto the three strata of the Cattell-Horn-Carroll (CHC) model of human cognitive abilities: task-specific skill (bottom) → broad abilities (middle) → the `g` factor (top). The history of AI is a slow climb up it: symbolic AI (none) → machine learning (local) → the current target (broad).

---

## The AIT formalism

All quantities normalized by `H(Sol^θ_T)`, the algorithmic complexity of the shortest skill program reaching threshold `θ`; all lie in `[0,1]`.

| Quantity | Definition | Reading |
|---|---|---|
| **Generalization difficulty** | `GD^θ_{T,C} = H(Sol^θ_T \| TrainSol^opt_{T,C}) / H(Sol^θ_T)` | How much the shortest program that is optimal on the *curriculum* must be edited to become adequate at *evaluation* |
| **Developer-aware GD** | `GD^θ_{IS,T,C} = H(Sol^θ_T \| TrainSol^opt_{T,C}, IS_{t=0}) / H(Sol^θ_T)` | Same, but the edits may read the initial system — so anything the developer built in stops counting as difficulty |
| **Priors** | `P^θ_{IS,T} = [H(Sol^θ_T) − H(Sol^θ_T \| IS_{t=0})] / H(Sol^θ_T)` | Fraction of the solution already present in the system at `t=0`. *Relevant* information only — irrelevant bulk knowledge is charged only indexing cost |
| **Experience at step t** | `E^θ_{IS,T,t} = H(Sol^θ_T \| IS_t) − H(Sol^θ_T \| IS_t, data_t)` | Uncertainty about the solution that *this step's data could have removed*. Noise is free; repetition is free for a fast learner and charged to a slow one |
| **Intelligence** | `I = Avg_{T∈scope} [ ω_T · θ_T · Σ_{C} P_C · GD^θ_T_{IS,T,C} / (P^θ_T_{IS,T} + E^θ_{IS,T,C}) ]` | Schematically `E[ skill · generalization / (priors + experience) ]`, averaged over a scope of tasks with value weights `ω` |

Read as a conversion rate: **information the system holds about part of situation space → area of *future* situation space it covers.**

Five consequences the formula forces:

- **Intelligence is scope-relative.** No scope, no number. Two systems are comparable only within a shared scope, at a shared skill threshold both can reach, and with comparable priors.
- **A curve-fitter scores zero on hard tasks.** A system emitting the simplest program consistent with the data can only win where `GD = 0`.
- **A system that starts able to solve the evaluation set scores zero.** Its developer-aware `GD` is ≈0 — a pre-trained model on a leaked benchmark is not measured as intelligent, it is measured as absent.
- **Curriculum is part of the measurement.** Expressed intelligence rises with a better curriculum space; curriculum design is therefore an optimization target, not a training detail (gap G32).
- **Efficiency has other axes** — computation, time, energy, risk — foldable as regularizers. Chollet deliberately measures information-efficiency only, as the actionable one today.

---

## Generalization is antagonistic to compression

**The sharpest claim on this page, and it contradicts the wiki's standing simplicity prior.**

`TrainSol^opt` — the *shortest* program optimal on the training situations — by construction discards everything not needed for the training situations, including capabilities that evaluation would need. Being prepared for future uncertainty has a cost, and that cost is paid in description length.

Chollet's worked case: points `(x=−0.75, False), (x=0.15, True)`. Shortest consistent programs include `λx: x > 0`. The next point `(x=−0.1, True)` breaks them, while a nearest-neighbour learner that *stored the raw data* survives. Generalization requires retaining representations that are useless from the past's point of view.

Logged as [[wiki/empirical-tensions.md]] T16 against [[wiki/concepts/universal-induction.md]]: Solomonoff's guarantee is asymptotic and passive, over an infinite mixture; `TrainSol^opt` is a single shortest program at a finite horizon. Both can hold — but the wiki cannot keep asserting "compression is the provably sufficient bias" and "the shortest training-fit program is the wrong object" without marking which regime each belongs to. **(brainstorm)** The reconciliation candidate: compress the *generator over environments* (the meta-graph, which stays live across instances), never the *policy fitted to one curriculum* (the instance-graph). Policy compression at the instance level destroys exactly the residual channel the two-level hierarchy needs — which makes this an argument *for* the factorization, not against simplicity as such.

---

## What an intelligence benchmark must do

Chollet's checklist, and the wiki's use for each:

| Requirement | Why it is not optional | Gap touched |
|---|---|---|
| **State its scope, and its predictiveness over it** (validity) | Without it, "the model reasons" is a claim about no defined set of tasks | G17 |
| **Be reliable** (reproducible across groups and random seeds) | — | — |
| **Contain no task known in advance to the system *or its developers*** | Otherwise measures the developer's priors (channel 1) | G17 |
| **Quantify, or at least qualify, its generalization difficulty** | A benchmark with `GD ≈ 0` cannot detect abstraction at any performance level | G16, G17 |
| **Cap experience; no task with a data generator** | Otherwise the hashtable strategy wins (channel 2) | G6 |
| **Enumerate its assumed priors, exhaustively and explicitly** | Implicit priors hand an unfair advantage to whichever side happens to hold them | G23 |
| **Be fair to humans and machines at once** — same priors, human-sized practice budget | The only way an AI/human comparison means anything | G17 |

**Why this beats the wiki's earlier G17 instruments.** Geirhos et al. 2020 required *constructing a distribution shift with a known intended solution*; Lake et al. 2017 offered shift-free query variation (richness, re-goaling); Spelke & Kinzler 2007 offered signature limits. All three are genre prescriptions. This is the first candidate that assigns a *number* to how much abstraction a task demands — and the first to note that the test must be run against the **developer**, not only the system, which none of the earlier three does.

**Why it does not close G17.** `GD`, `P`, and `E` are all defined through Kolmogorov complexity and are therefore uncomputable; Chollet supplies no approximation, and ARC — his own instantiation — does not quantify the generalization difficulty of a single one of its tasks (gap G31). The proposed workaround is empirical: use human success rate per task as a proxy for `GD` and check whether it correlates with an AIT approximation once solvers exist.

---

## Alternative benchmark constructions

Two designs offered beyond a hand-built task set, both directly usable in the framing:

- **Repurposed skill benchmarks.** Train on game `X`; evaluate on unpublished variants `X_1…X_n` built so the optimal program for `X` is *not* optimal for `X_i` — related-yet-novel gameplay, not new levels. Score = experience needed to reach a skill threshold on each variant, weighted by that variant's `GD`. This is the environment-family identifiability condition ([[wiki/concepts/latent-graph-discovery.md]]) turned into a measuring device: the variants are instance-graphs over a shared meta-graph, and only a system that recovered the meta-graph transfers cheaply.
- **Teacher–student open-endedness.** A learning *teacher* program generates tasks optimized for novelty and difficulty-just-past-the-student's-reach, in a loop with student solvers. Solves the diversity and scalability limits of hand-authored tasks, and doubles as curriculum optimization. Requires the teacher to draw on an external incompressible source (the real world), else the task space's complexity is capped by the teacher's own description length — the same ceiling that makes programmatic generation from a static master program gameable.

---

## Open problems

- **No computable approximation of `GD`.** The whole framework's actionability depends on one, and none is offered (gap G31).
- **Scope is stipulated, not derived.** `Avg_{T∈scope}` and the value weights `ω_T` are chosen by the measurer; nothing constrains them, so any two intelligence numbers are comparable only by convention.
- **Priors quantified as a scalar.** `P` collapses "what the system knows" to one number homogeneous with experience — which is what lets a low-prior system be judged more intelligent at equal skill, but discards *which* priors, and Chollet himself retreats to "only compare systems with similar priors" because full quantification is impractical.
- **Is human `g` universal or scoped?** If universal, reverse-engineering the brain is the shortest path and AI is close-ended; if scoped (Chollet's position, by analogy to physical fitness), AI is an open-ended anthropocentric pursuit and must be benchmarked *against humans*. Logged as [[wiki/empirical-tensions.md]] T17 against [[wiki/entities/aixi.md]].
- **The one measured correlate of `I` is a representation, not a rate.** Across 203 humans aged 8–25, entorhinal grid-code strength and the prefrontal distance code both load on Raven's Standard Progressive Matrices score (`β` = 0.55, 0.52) — the reasoning subtest specifically, not working memory or coding — and Raven's score predicts *how few training sessions* a subject needed to reach criterion (`r` = −0.34), which is this page's efficiency quantity measured directly (Qu et al. 2026, [[wiki/concepts/abstract-structural-codes.md]]). It is a correlation in brains, not a machine result, but it is the only evidence in the wiki that the structural-code bet and the conversion-rate definition of intelligence pick out the same thing.
- **Curriculum optimization is named, never specified.** "A better curriculum raises expressed intelligence" is asserted; no procedure generates one (gap G32).

---

## Connections

- **[[wiki/entities/arc-agi.md]]** — this page's requirements list made concrete: the one benchmark built to satisfy it, and the source of its known failures to.
- **[[wiki/concepts/universal-induction.md]]** — the same AIT toolkit aimed at belief instead of scoring, and the direct antagonist on whether the shortest program generalizes (T16).
- **[[wiki/entities/aixi.md]]** — the rival AIT definition of intelligence: expected reward over a universal mixture, scope-free and prior-free, against which this page argues that any intelligence measure is scope-relative (T17).
- **[[wiki/concepts/abstract-structural-codes.md]]** — the only quantity known to track this page's score in a real system: a structural code's *strength*, which predicts matrix-reasoning ability and training sessions to criterion across a developing human population.
- **[[wiki/concepts/shortcut-learning.md]]** — the empirical case that skill is routinely bought without generalization; this page prices the purchase, naming priors and experience as the two currencies and `GD` as what they fail to buy.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the missing scoring axis: an architecture's row in the hardness table is meaningless unless the benchmark it was scored on has non-zero developer-aware generalization difficulty.
- **[[wiki/concepts/core-knowledge.md]]** — the concrete content of `P`: to compare a machine against a human fairly, the prior term must be equalized, and Core Knowledge is the only enumerated candidate for what humans start with.
- **[[wiki/concepts/meta-learning.md]]** — the training-time counterpart: an outer loop over a task distribution is the optimization of exactly the quantity this page measures, and the curriculum this page says is under-specified is that loop's task sampler.
- **[[wiki/concepts/compositionality.md]]** — the mechanism proposed for actually scoring well: recombine sub-programs that worked on earlier tasks, so experience is amortized as reusable vocabulary rather than as data.
- **[[wiki/concepts/three-component-framework.md]]** — this page fills the objective slot the wiki's rows leave nearly empty (gap G30): a computable approximation of `I` would be an objective function for building a reasoner, not merely a yardstick.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — makes T16 empirical: the models argued to be compressing away what evaluation needs are measured, and their bits-saved-per-position curve is the cheapest computable proxy for the conversion rate `GD`/`P`/`E` cannot deliver (gap G31).
- **[[wiki/concepts/intelligence-density.md]]** — the rival on what intelligence is a property *of*: this page scores the process against a curriculum and a developer, that one scores the finished artifact's scaling with neither, and answers the unlimited-experience channel differently (a lookup table has `ℐ → 0` however much data built it) — [[wiki/empirical-tensions.md]] T20.
- **[[wiki/concepts/contextual-inference.md]]** — a concrete failure mode for any score read off a learning curve: adaptation decomposes into *proper* learning (structure acquired) and *apparent* learning (stored structure re-weighted), and three canonical "learning rate" effects turn out to be entirely the latter (Heald et al. 2021).
- **[[wiki/concepts/representation-probing.md]]** — the internal instrument that does *not* substitute for this page's requirement: a probe can pass on a task whose developer-aware generalization difficulty is zero, since it only confirms containment of a structure the experimenter already had.
- **[[wiki/concepts/recall-gated-consolidation.md]]** — makes the practice schedule a mechanism rather than an empirical curve: the optimal inter-repetition interval is set by the tuning of the consolidation gate, and a set of gates tuned to different recall strengths predicts retention timescale growing smoothly with the spacing used during training.
- **[[wiki/concepts/manifold-constrained-learning.md]]** — the mechanistic content of the `priors` term, and an argument that a scalar is the wrong shape for it: what predicts learning in a real population is not how much prior structure is held but whether the required solution lies in its *span*, which also yields a computable per-(learner, task) proxy for generalization difficulty where `GD` itself is uncomputable (G31; Sadtler et al. 2014).
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — a task family whose generalization difficulty is known by construction instead of estimated: arbitrary cue→action pairs give zero transfer between edges, so the training solution provably excludes the test solution — making it the control condition a reasoning score must beat, since a system matching its own binding rate has been measured on binding, not inference (Wise & Murray 2000).
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — also the sharpest constraint on benchmark format the wiki has: with two alternatives a Repeat-Stay/Change-Shift heuristic is a *complete* solution and with three it still removes 33 points of error, so any binding benchmark in two-alternative forced-choice form scores strategy rather than binding — the review's own field ran every rodent experiment at `k = 2` (Murray et al. 2000).
- **[[wiki/concepts/cognitive-control.md]]** — the conversion this page measures, stated as a change of substrate: repeatedly biasing a pathway strengthens it until it runs without the controller, so acquiring a skill is moving it out of a capacity-limited activity-based control state into direct connections — which makes "how much control does it still consume" a usable cost unit, and predicts that the acquisition curve and the release of controller capacity are the same curve (Miller et al. 2002).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — puts a receiving address on the controlled→automatic transition: overtraining moves control from prelimbic to infralimbic cortex, so the conversion this page prices is a transfer between prefrontal subregions rather than a release of prefrontal capacity, and the cost model must charge for the receiver ([[wiki/empirical-tensions.md]] T94).
- **[[wiki/concepts/controller-knowledge-vs-process.md]]** — attacks the release side of this page's accounting: prefrontal cortex responds to known actions and overlearned tasks merely shift its activation posteriorly, so practice may relocate a behaviour within the control layer instead of freeing controller capacity, and no theory supplies the transfer step either way (gap G51).
- **[[wiki/concepts/control-unity-and-diversity.md]]** — constrains the currency this page spends: every control operation draws on one common factor, so controller load is a single budget — but the components that draw on it are pharmacologically anticorrelated, so the budget cannot be reallocated between maintenance and switching without paying at the other end (Friedman & Robbins 2021).
