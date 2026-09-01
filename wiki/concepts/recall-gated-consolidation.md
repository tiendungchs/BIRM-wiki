# Recall-Gated Consolidation

**Write to the slow store only when the fast store already recognises what is being written: `Δw_LTM ∝ g(w_STM · w*)`. Selectivity — not durability — is what distinguishes *systems* consolidation from *synaptic* consolidation, and gating on the fast store's own recall is a selection rule that is population-level, task-agnostic, and computable online (Lindsey & Litwin-Kumar 2024).**

[[wiki/concepts/complementary-learning-systems.md]] names a channel from the fast store to the slow one and leaves the valve unspecified. [[wiki/concepts/offline-replay.md]] measures what comes out of the valve ("keep what recurs, suppress the idiosyncratic") without deriving it. This page is the derivation: the valve is a **familiarity threshold read off the fast store itself**, and the reason it exists is that reliable and unreliable synaptic updates are indistinguishable *at a single synapse* but separable *across a population*.

---

## The model

| Symbol | Meaning |
|---|---|
| `w* ∈ ℝ^N` | A **memory** — a pattern of candidate potentiation/depression events, i.e. the update the learning rule proposes |
| `w` | Current synaptic state; the population is partitioned into `w_STM` and `w_LTM` (no coupling between the two halves' *contents*) |
| `r_STM = w_STM · w*_STM` | **Recall factor** — the overlap between the proposed update and what the fast store already holds |
| `g(r_STM)` | **Gating function** on long-term plasticity. Baseline: `g = 1` for `r_STM ≥ θ`, else `0` |
| `λ` | Rate at which a *reliable* memory recurs; all other timesteps present a fresh random *unreliable* memory |
| `SNR = w·w* / √E_rand[(w·w*_rand)²]` | Performance measure (Fusi et al. 2005; Benna & Fusi 2016) |

The environment model is the whole point: experience is a mixture of **patterns of synaptic update that recur** and **patterns that occur once**. Nothing local to a synapse can tell them apart on first presentation. The recall factor can, because it integrates over `N` synapses at once — for large `N` the unreliable-memory overlap distribution concentrates (Gaussian) while the reliable one separates, so a threshold buys arbitrary purity as `N` grows.

**Effective interarrival time seen by the slow store:**

```
τ_LTM ≈ [ P(I < m⁻¹(θ)) / (1 − Φ(θ)) ] · τ
```

`I` = interval between presentations of the same reliable memory, `m(t)` = the underlying synapse model's forgetting curve, `Φ` = standard normal CDF. Raising `θ` filters unreliable memories *faster* than it filters reliable ones, so LTM purity rises; the price is false negatives, which are affordable precisely because reliable memories recur.

---

## The gating signal is already a broadcast scalar — one per learning problem

The recall factor looks like it needs privileged access to `w*`. It does not: for each standard learning rule it reduces to a quantity the circuit computes anyway.

| Problem | Memory (learning rule) | Recall factor `r` | Reads as |
|---|---|---|---|
| Supervised | `W* = y xᵀ` (associative Hebb) | `y · ŷ`, `ŷ = Wx` | **Prediction accuracy** of the fast pathway |
| Reinforcement | `W* = reward · a xᵀ` (three-factor) | `reward · π_a` | **Reward × decision confidence** (log-likelihood of the action actually taken) |
| Autoassociative | `W* = x xᵀ` (Hopfield-like) | `x · (Wx)` | **Familiarity** — attractor agreement between feedforward and recurrent input |

Three consequences for a builder:

- The gate needs **one scalar per event**, broadcastable — the same channel shape as a neuromodulator or the third factor of [[wiki/concepts/synaptic-plasticity.md]]. It is not a per-synapse importance estimate, and it needs no task label, no boundary detection and no offline pass.
- In the autoassociative case `x·(Wx)` could be read directly if separate dendritic compartments carry feedforward and recurrent drive ([[wiki/concepts/dendritic-computation.md]]) — speculative in the source — or approximated by a **novelty readout** `u·x` trained alongside, with `u* = x`. The simulations use the readout.
- "Recall" is familiarity **of the update pattern**, not of the stimulus. A well-predicted stimulus paired with a *new* label produces low recall, which is the desired behaviour and is not what a stimulus-novelty detector would report.

Simulated on binary classification, three-action RL and autoassociative recall, gating beats an ungated two-module control in all three.

---

## The scaling result: population gating buys what no synapse can

Let `R` = number of times a reliable memory is reinforced, and define the **learnable timescale** `τ_β^ε` as the largest mean interarrival `τ` for which recall SNR exceeds `β` with probability `1−ε`.

| Underlying synapse model | Learnable timescale vs `R`, ungated | With recall gating |
|---|---|---|
| Binary switch | ~**invariant** in `R` | **linear** in `R` |
| Cascade (Fusi et al. 2005) | ~**log R** | **linear** in `R` |
| Multivariable (Benna & Fusi 2016) | **linear** in `R`, but needs internal states growing exponentially with the target timescale | **linear**, better by a large constant factor |
| *Any* synapse-local mechanism, bursty arrivals (Weibull `k < 1`) | **≲ linear** in `R` — proven upper bound | **`R^{1/k}` — superlinear** |

Two readings, and the second is the important one:

1. **Systems gating substitutes for synaptic complexity.** Simple two-state synapses plus a population-level gate reach the scaling that otherwise demands an elaborate multi-timescale synapse. The mechanisms are complementary, not rival — gating improves *every* underlying synapse model.
2. **Bursty experience is where the gate is not substitutable.** When reinforcement arrives in clusters separated by droughts — one context visited intensely, then abandoned; a study session — recall gating achieves a power law that *no* synapse-local consolidation rule can, because the decision requires comparing an event to the population state rather than to the synapse's own history. Real experience is bursty. **(brainstorm)** This is the sharpest existing argument in the wiki that the fast/slow split must be *two systems with a channel between them* rather than two timescales inside one synapse — a distinction [[wiki/concepts/synaptic-plasticity.md]] previously left as a matter of level of description ([[wiki/empirical-tensions.md]] T2).

---

## Spacing effects fall out of the gating function's shape

If unreliable memories can themselves repeat over a short window, the threshold gate is wrong: the evidence for reliability is now **intermediate** overlap, so the optimal `g` is **non-monotonic** — a band-pass on recall strength, implementable with units tuned to a range of recall values.

| Prediction | Match |
|---|---|
| Inverted-U dependence of retention on spacing interval | Flies (Beck et al. 2000), rodents (Glas et al. 2021), humans (Rovee-Collier et al. 1995; Verkoeijen et al. 2005) |
| **Multiple LTM sub-populations with gates tuned to different recall strengths** → memory lifetime increases smoothly with training spacing, up to a threshold | Optimal spacing scales with the training→test delay (Cepeda et al. 2006, 2008); intermediate-timescale memory traces reported across species |
| Consolidation *rate* rises with experience and with environment reliability | Songbird AFP→SMP consolidation tracks performance (Tachibana et al. 2022); ripple rate rises within a session and with trajectory regularity (Jackson et al. 2006) |
| Recall responsibility shifts from fast to slow store; STM inactivation stops mattering | The systems-consolidation signature generally |

**The mechanistic discriminator between synaptic and systems accounts of spacing.** Multi-timescale synapses also produce spacing effects, but by *saturation of fast internal variables* — so interposing other plasticity events between the spaced repetitions destroys the effect. Recall gating sets its timescale from population-level forgetting curves, so spacing survives arbitrary intervening plasticity. **Spacing effects observed over long intervals in a busy life are therefore evidence for the systems mechanism specifically**, and this is a cheap experiment to run in silico.

---

## The sparsity prediction: the two stores should not share a coding level

Let memories potentiate a fraction `f` of synapses (depression scaled by `f/(1−f)` to stay balanced). In the low-`f` limit the SNR-optimal coding level is

```
f* ∝ λ
```

— sparser codes for less frequently reinforced memories. Because gating amplifies the *effective* `λ` reaching the slow store, `f*_LTM > f*_STM`. And when `f_STM` is optimised for total system SNR rather than for the fast store alone, it becomes **sparser still**, because the fast store's job is now discrimination for the gate rather than storage. The gap therefore opens from both ends.

| | Fast store | Slow store |
|---|---|---|
| Optimal coding level | Sparse, and *sparser* when supporting consolidation | Substantially denser |
| Why | Maximises separability of reliable vs unreliable overlaps at low `λ` | Sees an enriched stream, so pays no capacity premium for density |
| Side effect | — | Denser codes generalise better under input noise (Babadi & Sompolinsky 2014) |

This is an independent derivation of the CLS sparse-hippocampus / dense-cortex asymmetry from **reliability filtering alone**, with no appeal to interference or to pattern separation ([[wiki/concepts/pattern-separation-completion.md]], [[wiki/concepts/sparse-distributed-representations.md]]). It also predicts the asymmetry should *grow* when the environment is unreliable, which is a measurable statement.

---

## Circuit evidence

| System | Motif | Status |
|---|---|---|
| **Drosophila mushroom body** | Short-term aversive learning suppresses the inhibitory γ1 MBON, which **disinhibits the dopamine neuron innervating the α2 (long-term) compartment** — so short-term recall literally licenses long-term plasticity (Awata et al. 2019) | The one near-exact circuit implementation; repeated pairings consolidate, single pairings do not |
| **Songbird** | AFP(LMAN)→song-motor-pathway consolidation extent correlates with performance at the time (Tachibana et al. 2022) | Consistent; does not test the stronger rate prediction |
| **Rodent motor** | Motor cortex disengages from practised skills, transferring to basal ganglia; disengagement tracks trajectory variability (Kawai et al. 2015; Hwang et al. 2021; Dhawale et al. 2021) | Consistent; rate prediction untested |
| **Hippocampus** | CA3→CA1 axons responding to a **fixed-location** cue are recruited into sharp-wave ripples more readily than randomly-presented-cue axons (Terada et al. 2022); parietal recruitment strengthens with experience in a static but not a changing environment (Brodt et al. 2016) | The same datum [[wiki/concepts/offline-replay.md]] reads as "the filter suppresses the idiosyncratic", here read as "the gate passes the familiar" — one observation, now with a normative derivation |

---

## Why this matters for a reasoning model

- **It is a write-gate for slow W that a deployed agent can actually compute.** [[wiki/concepts/continual-learning.md]]'s families need a Fisher matrix, a task boundary, a stored replay set or a growing parameter count. This needs one scalar — the fast learner's own accuracy/confidence/familiarity on the current event — and gates the slow write on it. Gap G14 asked for a consolidation channel with a specification; this is the valve.
- **It is the first selectivity mechanism in the wiki that is not synapse-local.** [[wiki/concepts/synaptic-plasticity.md]]'s standing complaint is that no local rule is selective about *what* it writes, so a shortcut correlation is written as eagerly as a causal edge. Recall gating does not fix this at the synapse — it accepts that the synapse cannot know — and moves the decision to the only place the information exists, the population. **(brainstorm)** Applied to [[wiki/concepts/shortcut-learning.md]]: a shortcut that is *stably* predictive within the training distribution passes this gate as easily as structure, so recurrence-filtering separates noise from signal but **not shortcut from cause**. It is a reliability filter, not a causality filter, and reading it as the latter would be the error ([[wiki/concepts/objective-identifiability.md]]).
- **It is partial knowledge distillation, derived.** The slow store's updates are partly dictated by the fast store's outputs, which the source identifies as *tutoring* (Murray & Escola 2020) and as the biological cousin of knowledge distillation (Hinton et al. 2015). The theory here supplies the missing normative reason distillation helps: the teacher's confidence is a **reliability estimate on the update**, and the student is being shielded from the teacher's one-off noise.
- **It runs online, with no replay.** This detaches the *selection* function from the *offline* schedule that [[wiki/empirical-tensions.md]] T34 disputes. Recall gating can be implemented as selective replay, but need not be.

---

## Open problems

- **Fixed random representations are assumed.** Real update patterns are correlated and structured; whether the overlap statistic still separates reliable from unreliable memories when memories overlap each other is untested, and it is exactly the regime a reasoning model lives in.
- **No representation learning in either store.** Decorrelating consolidated traces online — instead of assuming they arrive orthogonal — is named as the obvious extension and is the same question as [[wiki/empirical-tensions.md]] T61.
- **Two modules, one direction.** Reciprocal interaction, or a chain of three or more stores with successively stricter gates, is unexplored; the heterogeneous-gate extension gestures at it without modelling the dynamics.
- **This is the wiki's one *learned-in-principle* write gate, and it gates the second store rather than the first** — the fast store still writes on anything, so `G19` is moved downstream rather than closed.
- **Who sets `θ`?** The threshold implicitly encodes an estimate of environmental reliability and of the expected repetition count `R`. Neither is known to an agent in a novel environment, so the gate needs its own meta-learner ([[wiki/concepts/meta-optimized-plasticity.md]]).
- **A reliable memory that must be overwritten.** The gate is monotone in familiarity, so it is maximally resistant to exactly the update a changed world requires — the same stability/plasticity failure [[wiki/concepts/contextual-inference.md]] handles by inferring a new context instead of gating harder.

- **Synaptic saturation produces the same inverted-U curve, and the cheap discriminator has not been run** ([[wiki/empirical-tensions.md]] T72). Multi-timescale synapse models get spacing effects unaided from fast internal variables saturating at short intervals (Benna & Fusi 2016), but that mechanism requires *few intervening plasticity events* between repetitions, while a population-level gate is indifferent to them. Since real inter-repetition intervals are full of intervening experience, spacing measured across days over intervals dense with other learning discriminates the two directly — and decides whether a machine's spaced-repetition schedule is a per-weight learning-rate state or a write-gate on a second module.

---

## Connections

- **[[wiki/concepts/complementary-learning-systems.md]]** — supplies the missing valve on that page's coupling channel, plus an independent derivation of its sparse-fast / dense-slow asymmetry from reliability filtering rather than from interference; and its scaling proof is the wiki's strongest argument that two *systems* are needed rather than two timescales inside one synapse.
- **[[wiki/entities/inhibitory-replay-filter.md]]** — the same criterion reached without this page's gate: inhibition potentiated by a ~3 ms symmetric kernel accumulates on representations whose co-active partners vary across episodes, so "keep what recurs" is computed as a synapse-local variance statistic during behaviour instead of as a population-recall test at write time — a second, cheaper implementation of the reliability filter, and one that needs no broadcast scalar.
- **[[wiki/concepts/offline-replay.md]]** — turns that page's measured filter ("keep what recurs, suppress the idiosyncratic") into a normative rule with a computable statistic, and adds that the selection need not run offline at all, since the same gate works event-by-event during waking.
- **[[wiki/concepts/synaptic-plasticity.md]]** — accepts that page's conclusion that a local rule cannot be selective, and relocates the selection to the population: the gate is a third factor whose value is the fast pathway's own accuracy, confidence or familiarity. It also prices the trade: population gating gives simple binary synapses the retention scaling that otherwise requires a multi-timescale synapse.
- **[[wiki/concepts/continual-learning.md]]** — a write-gate for slow **W** that needs no Fisher matrix, no task boundary, no stored exemplars and no growth: the criterion is the fast learner's recall of the proposed update, computable from one broadcast scalar per event.
- **[[wiki/concepts/memory-allocation-excitability.md]]** — the rival criterion for what gets consolidated, and they are cleanly separable: an excitability tag is set at *encoding* and is content-blind (temporal proximity groups episodes), whereas recall gating is evaluated at *each recurrence* and is content-specific (overlap with what is stored). The tag says "these episodes belong together"; the gate says "this one has earned a long-term write".
- **[[wiki/concepts/sparse-distributed-representations.md]]** — derives an optimal coding level `f* ∝ λ` from a reliability-filtering objective rather than from interference, and therefore predicts a *specific* sparsity gap between the two stores instead of sparsity in general.
- **[[wiki/concepts/pattern-separation-completion.md]]** — a second reason for the fast store to be sparse: separability of reliable from unreliable *update patterns* for the gate, which is a different objective from non-overlap of stored items and points the same way.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — the gating function `g` is exactly the kind of object that family learns: its shape (threshold vs band-pass) encodes an assumption about the environment's recurrence statistics, so `g` should be meta-learned rather than hand-set.
- **[[wiki/concepts/shortcut-learning.md]]** — bounds what this gate can do: it filters non-recurring noise, and a shortcut that recurs stably passes it unimpeded, so reliability filtering is orthogonal to causal validity.
- **[[wiki/concepts/attractor-dynamics.md]]** — supplies the autoassociative instance's recall factor: `x·(Wx)` is high exactly when the input sits in a stored basin, so attractor agreement *is* the familiarity signal the gate reads.
- **[[wiki/entities/hopfield-network.md]]** — the concrete substrate for that instance: the Hebbian outer-product write is the memory vector `W* = xxᵀ`, and gating it on `x·(Wx)` is a one-line change that makes the store consolidate only patterns it has already begun to store.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a criterion for which candidate edges are promoted from the instance-graph into the meta-graph: an edge that recurs across encounters, measured by the fast store's own recall, not by reward or by error magnitude.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the spacing results are a training-schedule lever with a mechanism behind them: the optimal inter-repetition interval is set by the gating function's tuning, and the model predicts retention timescale grows smoothly with the spacing used during practice.
- **[[wiki/entities/btsp-cam.md]]** — the opposite answer to the same question of which writes survive: this page keeps what the store already partly holds, while BTSP's involution (`w_i ← 1 − w_i` on every gated active input) means a trace survives to the extent its inputs have *not* been re-presented under a plateau — capacity spent on the not-recently-written, with no population statistic and no gate **(brainstorm)**.
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — the rival answer to what opens the same valve, cleanly separable from this one: recall gating passes what *recurs*, Go-CLS passes only what the slow learner can *model*, so a reliably recurring but unmodellable relation (a nonlinear teacher met daily) is consolidated here and refused there — and Go-CLS's frequency-heuristic warning is aimed precisely at a recurrence-defined gate ([[wiki/empirical-tensions.md]] T81).
- **[[wiki/concepts/schema-assimilation.md]]** — the opposite sign of this page's statistic, computed from the same comparison: recall gating writes when the fast store *agrees* with the proposed update, whereas prefrontal recruitment scales with *disagreement* between the retrieved associate and the new observation and predicts successful inference — agreement says the item is worth keeping, conflict says it needs the expensive module.
- **[[wiki/concepts/encoding-retrieval-alternation.md]]** — the same statistic (the fast store's own recall of the current item) read with the opposite sign: this page uses recall *success* as the license to write to the slow store, that one uses recall *failure* as the error signal for writing to the fast store, so one measurement can gate both writes.
