# Contextual Inference

**One posterior over "which context am I in" simultaneously controls memory *creation*, *expression* and *updating* — so a change in behaviour decomposes into two mechanisms that no adaptation curve can separate: *proper* learning (a stored state changed) and *apparent* learning (only the weights on unchanged stored states changed).**

Source: Heald, Lengyel & Wolpert 2021 (Nature), which formalises the principle as the COIN model ([[wiki/entities/coin-model.md]]) and tests it on human sensorimotor adaptation. The claim is explicitly domain-general — the authors close by saying the proper/apparent distinction "is likely to be relevant to all forms of learning in which experience can be usefully broken down into discrete contexts".

For the wiki this is the **retrieval-and-allocation policy** the graph framing has been missing: contexts are nodes of a rule-graph, the posterior over them says which stored meta-graph fragment is live, and a nonparametric prior says when to allocate a new one.

---

## The three operations, one computation

Let `c_t` be the (unobserved, discrete, unbounded) context at time `t`, `q_t` a sensory cue, `y_t` state feedback obtained *after* acting.

| Operation | Driven by | Timing | Formal statement |
|---|---|---|---|
| **Expression** | *predicted probability* `p(c_t = j ∣ q_t, …)` — posterior after the cue, **before** feedback | pre-action | output is a probability-weighted **mixture** of all memories, not a selected one: `u_t = Σ_j p(c_t=j∣q_t,…) · E[x_t^(j)]` |
| **Creation** | *responsibility* of the **novel** context `p(c_t = ∅ ∣ q_t, y_t, …)` | post-feedback | a new memory is instantiated with probability equal to that responsibility, initialised from the novel context's stationary state distribution |
| **Updating** | *responsibility* of each known context | post-feedback | **every** memory updates, each by its own Kalman gain **scaled by its responsibility**: `Δmean_j ∝ λ_j · k_j · e_j` |

The two probabilities differ only in what has been conditioned on: expression uses cue evidence alone (you must act before you learn the outcome), creation and updating use cue **and** feedback. Everything else — savings, interference, recovery — falls out of the dynamics of that single posterior.

---

## Proper vs. apparent learning

| | **Proper learning** | **Apparent learning** |
|---|---|---|
| What changes | the inferred state `x^(j)` of a memory | the predicted probabilities `p(c_t = j ∣ …)` |
| Classical reading | "learning" | also read as "learning", wrongly |
| Rate parameter | Kalman gain `k_j` (a real learning rate) | none — no memory is touched |
| Reversible in one trial | no | yes (evoked recovery) |

Heald et al. reproduce **savings**, **anterograde interference** and the **environmental-consistency effect on single-trial learning** with parameters fit to *other* experiments (parameter-free predictions), and show that in all three the Kalman gains and underlying states are essentially unchanged — the entire effect sits in the context probabilities. Three canonical "learning rate" findings are therefore **not** findings about learning rate.

**Consequence for this wiki (gap G17).** Any curve of behaviour-vs-trials — motor adaptation, few-shot fine-tuning, in-context learning — confounds "the model acquired structure" with "the model re-weighted structure it already had". An evaluation that reports only the curve cannot tell a learner from a retriever ([[wiki/empirical-tensions.md]] T24). **(brainstorm)** The experimental cure is the one used here: insert a single unambiguous context-signalling trial (an *evoker*) and see whether behaviour jumps. A jump larger and more persistent than any plausible one-trial update is apparent learning by elimination — a cheap, general probe applicable to an in-context-learning model as easily as to a hand at a manipulandum.

---

## Where new memories come from

The generative model puts a **sticky hierarchical Dirichlet process** on context transitions (details on [[wiki/entities/coin-model.md]]). Three hyperparameters do work no other mechanism in the wiki does:

| Hyperparameter | Controls | What it buys |
|---|---|---|
| `γ` (GEM concentration) | rate of decay of global transition probabilities | the **effective number of contexts** — small `γ`: few, high-probability contexts; large `γ`: many rare ones. A granularity knob |
| `κ` (self-transition bias) | probability mass on `c_t = c_{t−1}` | contexts *persist*: the prior that the world does not re-roll its rules every step |
| `α` (DP concentration) | how much each context's local transition row resembles the global row `β` | the **two-level split**: `β` is shared across contexts (meta), `π_j` is per-context (instance) |

This answers the open problem left standing on [[wiki/concepts/event-segmentation.md]] — "the compression criterion is unspecified: no clustering objective, no granularity control, no stopping rule". Here all three are one prior, and the allocation decision is a probability rather than a threshold. It also produces a non-obvious empirical prediction that holds: a perturbation introduced **abruptly** creates a new memory, the **same perturbation introduced gradually does not** (existing memories can absorb it), which is why deadaptation after gradual introduction is slower.

**The boundary detector is the posterior.** Contrast the two accounts the wiki now carries:

| | Butz 2016 ([[wiki/concepts/event-segmentation.md]]) | Heald et al. 2021 |
|---|---|---|
| A boundary is | a lasting change in the active set of predictive encodings | a shift of posterior mass to a different (possibly new) context |
| Detector | hand-set thresholds, or LSTM gates trained by backpropagation through time | Bayes' rule under a nonparametric prior |
| Granularity set by | unspecified | `γ`, `κ`, `α` |
| Handles noise-vs-boundary | "a precision judgement the theory does not specify" | the likelihood ratio *is* the precision judgement |
| Scales to | rich multimodal streams (in principle) | a scalar state per context (in fact) |

They are not rivals so much as the same idea at opposite ends of the expressiveness/principle trade: one has the representation and no criterion, the other has the criterion and no representation.

---

## Two evidence channels, fused

Context evidence arrives in two forms with different timing and different reliability:

- **Sensory cues** `q_t` — available before acting, so they are the only thing expression can use. Cheap, but a cue only indicates a context to the extent it has been *paired* with it.
- **State feedback** `y_t` — available only after acting. Directly diagnostic of the dynamics.

Heald et al. put them in conflict (the light-but-large-cup manipulation) and measure single-trial learning of one memory under all four cue×perturbation combinations. Result: graded updating, with **both** channels significant and additive (cue `F(1,23)=10.35, p=3.8×10⁻³`; perturbation `F(1,23)=21.16, p=1.26×10⁻⁴`; no interaction), and **no** gradation before training — the gradation is *learned*, not built in. Feedback outweighed the cue, as predicted, because washout trials had paired both cues with the null field and thereby degraded their diagnosticity.

This is direct evidence against winner-take-all retrieval: **all** stored structures update on every trial, in proportion to how much they explain the observation.

---

## What this contributes to the core framing

| Wiki claim | What contextual inference adds |
|---|---|
| G37 — nothing decides which stored structure applies | A graded posterior over a growing library, computed from `p(cue∣context) × p(context∣previous context) × p(feedback∣context state)`. Compare [[wiki/concepts/subgraph-matching.md]]: that answers *does this pattern occur here* geometrically and deterministically; this answers *which of my models is generating this* probabilistically and sequentially. They are the structural and the statistical version of the same retrieval step |
| G27 — nothing supplies the discretisation | A stopping rule and a granularity knob for node creation, at the cost of assuming the within-node state is a scalar |
| Hardness 6 — non-stationary topology | `c_t` **is** the "rule-config" the lifting argument asks for, made a first-class latent with its own Markov dynamics. A rule change is literally an edge in a rule-graph — the reification gap G8 wanted, implemented and fit to data (in a scalar world) |
| G1 — two-level separation | The hierarchical Dirichlet process is the hierarchy: global `β` pooled across contexts, local `π_j` per context, coupled by `α`. Same shape as [[wiki/entities/hbtom.md]]'s hyperprior, again hand-written rather than discovered |
| Continual learning's task-boundary problem | Dissolved: boundaries are not needed as input, they are the thing being inferred. And responsibility-scaled updating is **relevance**-gated plasticity rather than **importance**-gated (elastic weight consolidation) — protection comes from a memory not being responsible for the current data, which needs no Fisher matrix and no task label |
| Working memory | Heald et al. identify working memory with **maintenance of the current context probabilities** — a distractor task disrupts them and thereby produces evoked recovery. That gives fast **M** a specific content: not the instance-graph itself, but the *mixing weights over stored graphs* |

---

## Open problems

- **The contexts are atoms.** Nothing is shared *between* contexts except the transition prior: context 5 cannot be "context 3 with one edge flipped". There is no `g`/`x` factorization inside the library, so the model gets retrieval and allocation right while giving up compositionality ([[wiki/concepts/compositionality.md]]). A repertoire that grows one atom per novel situation is exactly the memorising regime [[wiki/concepts/intelligence-density.md]] scores at `ℐ → 0`.
- **Scalar states.** Each memory holds one number (force-field strength). The whole apparatus is untested where a context's content is a graph, a program, or an image.
- **Exact inference is infeasible**; the fit uses particle learning (sequential Monte Carlo). No neural implementation is proposed, and it is not known which of the operations a plausible substrate could carry.
- **Cue vocabulary is given.** `q_t` is a discrete observation from a known alphabet; discovering *what counts as a cue* is the vocabulary problem (hardness 2) and is not addressed.
- **How much is prior, how much is inferred?** `γ`, `κ`, `α`, the state-dynamics prior and the noise variances are fit per participant (7–8 free parameters). The granularity knob is real, but here it is turned by the experimenter's optimiser, not by the learner.

---

## Connections

- **[[wiki/entities/coin-model.md]]** — the model this page abstracts: full generative model, inference scheme, experiments and model comparison.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the retrieval-and-allocation policy the framing assumes: a posterior over which stored structure is live, and a nonparametric prior deciding when to create a new one; the context variable is hardness source 6's rule-config lifted into an explicit latent.
- **[[wiki/concepts/event-segmentation.md]]** — the rival account of where node boundaries come from: a lasting change in active predictive encodings versus a shift of posterior mass under a sticky nonparametric prior, which supplies exactly the clustering objective and stopping rule that account lacks (tension T23).
- **[[wiki/concepts/continual-learning.md]]** — dissolves the task-boundary assumption and replaces importance-gated plasticity with relevance-gated plasticity: a memory is protected by having low responsibility for the current observation, so no Fisher matrix or task label is needed.
- **[[wiki/concepts/complementary-learning-systems.md]]** — a third answer to the interference problem: rather than one fast store plus one slow store, a *growing set* of slow stores with an inference process deciding which is being written to.
- **[[wiki/concepts/working-memory.md]]** — gives fast **M** a specific content: the mixing weights over stored memories rather than the memories themselves, which is what a distractor task disrupts.
- **[[wiki/concepts/meta-learning.md]]** — the hierarchical Dirichlet process is the outer/inner loop written as a prior: global transition probabilities are the meta level, per-context rows the instance level, and adaptation is conjugate inference rather than gradient descent.
- **[[wiki/concepts/subgraph-matching.md]]** — the structural counterpart of the same retrieval step: containment tested geometrically and deterministically there, generative identity tested probabilistically and sequentially here.
- **[[wiki/concepts/amortized-inference.md]]** — expression is the amortised half (a weighted read-out computed before acting) and updating the deliberative half (after feedback), split by *what has been observed* rather than by compute budget.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — same residual-driven update, with the residual routed by a discrete latent: prediction error is assigned to contexts in proportion to responsibility instead of being absorbed by one model.
- **[[wiki/entities/hbtom.md]]** — the same two-level Bayesian shape in another domain (hyperprior over agents rather than over contexts), with the same limitation: the hierarchy is authored, not discovered.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — sharpens the measurement problem: an adaptation curve conflates acquiring structure with re-weighting stored structure, so a conversion-rate score computed from a learning curve is only valid if apparent learning has been ruled out (gap G17).
- **[[wiki/concepts/intelligence-density.md]]** — the cost of the atomic repertoire: a system that answers novelty by allocating a new context grows description length with the world, which is the `ℐ(n) → 0` memorising asymptote.
