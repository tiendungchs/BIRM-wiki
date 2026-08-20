# Hidden-State Inference Model of Remapping

**Place-field remapping is not a response to the environment; it is a read-out of a posterior over *which hidden state generated the observations*. A Chinese Restaurant Process prior supplies the allocate-vs-reuse decision, and the *uncertainty* of that posterior — not its winner — is what the graded remapping categories measure.** Sanders, Wilson & Gershman 2020, *eLife* 9:e51140. Theory paper; no new data, all figures are simulations against published datasets.

Principle: [[wiki/concepts/contextual-inference.md]]. This page carries the model, the phenomena it covers, and its stated limits.

The paper's own one-line summary of its relation to the mechanistic hippocampal literature: **"The attractor network describes *how* pattern separation and completion work. The hidden state inference model describes *why* pattern separation and completion work the way they do."**

---

## Generative model

| Object | Form |
|---|---|
| Observation | `y = [y_1,…,y_D]`, a feature vector; one observation ≈ one recording *session* in all simulations |
| Hidden state `c` | discrete, unbounded; **one hidden state ↔ one hippocampal map** |
| Real-valued features | multivariate normal likelihood, conjugate normal-Wishart prior (`µ₀=0`, `κ₀=0.001`, `ν₀=0.02`, `T₀=0.02·I`) |
| Circular features (heading, cue angle) | Von Mises likelihood, normal-gamma prior; marginalised numerically |
| Prior over partitions | **Chinese Restaurant Process**, `P(c_t=k ∣ c_{1:t−1}) = m_k/(t−1+α)` for existing `k`, `α/(t−1+α)` for new |

```
P(Y_c ∣ c)  = ∫ ∏_t P(y_t ∣ c, θ_c) P(θ_c) dθ_c            (2)   marginal likelihood of one state
P(Y ∣ c)    = ∏_k P(Y_{c_k} ∣ c_k)                          (3)   of a whole partition
log P(c)    = K log α + Σ_k log Γ(m_k) + log Γ(α) − log Γ(T+α)   (5)
```

`α` is the **Occam dial**: `α=0` ⇒ one state forever, `α→∞` ⇒ a new state per observation, expected states after `N` observations `= α log N`. All figures use `α = 0.1` except the animal-variability figure.

## The two read-outs

Both are log posterior odds, and both are interpreted as a *degree* of remapping rather than a decision:

| Quantity | Eq. | Compares | Used for |
|---|---|---|---|
| **Partition evidence ratio** | (7) `log [P(Y∣c)P(c)] / [P(Y∣c′)P(c′)]` | two whole partitions of all observations so far | learning curves — "have I come to believe there are two environments here?" |
| **State evidence ratio** | (11) `log [P(y_{t+1}∣c,·)P(c∣c_{1:t})] / [P(y_{t+1}∣c′,·)P(c′∣c_{1:t})]` | two assignments of **one new** observation | probe trials — "is this the same room?" |

The posterior predictive `P(y_{t+1} ∣ Y_{c_k})` (Eq. 9) is a generalized Student-t (Eq. 10) whose scale widens with the *observed variance within that state* — the mechanism behind the model's sharpest prediction (see below).

**The mapping onto remapping categories is a single axis:**

| Evidence ratio | Predicted phenomenon |
|---|---|
| strongly positive | no remapping |
| weakly positive | rate remapping |
| **near 0** | **partial remapping + heterogeneous population response** |
| strongly negative | global remapping |

So the field's four "types" of remapping are one continuum in *state uncertainty*, and the paper's position is that the categories have no strict boundaries because there is nothing there to have a boundary.

---

## Phenomena covered

| Puzzle | Model account | Data |
|---|---|---|
| **Cue constellations, not cues** | Each feature contributes to one joint likelihood; changing 1 of 4 features moves the ratio to ≈0 (partial remapping), changing all 4 drives it negative | O'Keefe & Conway 1978; Shapiro 1997 |
| **Remapping appears only with experience** | Evidence must accumulate to overcome the CRP simplicity bias before a 2-state partition wins | Lever 2002 — square/circle diverge only after weeks |
| **Maps *stabilise* with experience** | Same simulation, opposite ground truth: with one true state, the ratio accumulates toward 1-state. Early in training the animal *cannot tell which of the two regimes it is in* | Law 2016; Frank 2004 |
| **Non-sensory (behavioural) remapping** | Observation = running direction as a circular variable; directed foraging = two Von Mises modes (2-state wins), random foraging = uniform (1-state wins). No sensory difference between conditions | Markus 1995 |
| **Rate remapping always co-occurs with partial remapping** | A Beta distribution over per-cell rate modulation with `b−a` = the evidence ratio makes mean modulation and fraction-fully-remapped move together | Leutgeb 2005a rank-ordering; the one exception (Allen 2012) has a rate change so small it lands on the predicted no-partial-remapping corner |
| **Population heterogeneity tracks uncertainty** | Spread of the same Beta distribution is maximal at evidence ratio ≈0 | Leutgeb 2005b (heterogeneous, partial regime) vs Wills 2005 (coherent, global regime) |
| **Animal-to-animal variability** | Per-animal `α`. Under the Wills 2005 schedule, different `α` select different preferred partitions — reproducing the fact that 2 of 6 rats partitioned the training in the two "wrong" ways and were excluded | Wills 2005 supp. |
| **Morph experiments disagree across labs** | The divergent results are the *partial* vs *global* regimes of one continuum; predicted to be reproducible within one lab by running the morph probe early vs late in training | Wills 2005 / Leutgeb 2005b / Colgin 2010 |

## Cue rotation: an alignment stage before inference

Rotation experiments force an extra operation the rest of the model does not need. Feature vectors of cue *angles* are equivalent up to a common offset, so before any likelihood can be computed the animal must choose a reference direction — **per hidden state**:

```
φ_k = argmax_φ  P(y_{t+1} − φ ∣ Y_{c_k})            (posterior predictive, Eq. 9)
state evidence ratio is then computed using each state's own best offset φ_k
```

| Manipulation (Rotenberg & Muller 1997) | Model | Data |
|---|---|---|
| Card rotated 180°, animal absent, maze cleaned | best offset −175°, ratio favours same state | no remapping, fields rotate ~180° |
| Card rotated 180°, animal present, maze dirty (5 extra low-fidelity cues, σ×3) | best offset −2°, same state, but ratio **much closer to 0** | no remapping, no rotation; heterogeneity predicted and untested |
| Card rotated 45°, animal present, dirty | best offset 22°, same state | no remapping, ~45° rotation |

**This is a *correspondence* problem solved by maximisation, nested inside a state-identity problem solved by marginalisation** — and it is the wiki's first formal statement of the anchoring operation ([[wiki/concepts/cognitive-map.md]], gap G39): a stored map is not comparable to the present observation until an alignment has been chosen for it, and different stored maps get different alignments.

---

## The novel prediction: training variance sets tolerance

Two groups, same probe. Group A trained with high variance on feature 1 and low on feature 2; group B the reverse. Probe with a novel value of feature 1.

> **A is *less* likely to remap than B**, because the posterior predictive of A's state is wide along the axis that moved.

The generative model, not similarity, does the work: remapping tolerance is set by *what has varied before*, cue by cue. The paper's analogy is a conference room whose chairs are always rearranged versus one whose layout never changes. Independently posted as a preprint by Plitt & Giocomo 2019 during review. The same logic retro-explains Knierim 1995 (a cue repeatedly moved in an unstructured way loses control of place-field alignment) and the training-variance direction is the model's cleanest separation from any similarity-threshold or similarity-recall account, including [[wiki/entities/temporal-context-model.md]].

**Proposed behavioural test of remapping's relevance.** Train one group in a daily-changing morph box (predicted: no remapping between circle and square) and one alternating only the extremes (predicted: remapping). Verify neurally, then fear-condition in one configuration and measure generalisation to the other. There is currently **no causal demonstration that remapping drives context-dependent behaviour**, and Jeffery 2003 reports task-performance transfer *across* near-global remapping.

---

## Limitations (stated by the authors)

- **The feature space is unspecified.** Features are "abstract idealizations" chosen per simulation. A biological theory must say what the hippocampal input vector is; the suggested candidate is [[wiki/concepts/successor-representation.md]] state features, which would make remapping sensitive to *predictive* relations — untested.
- **"What is an observation?"** Fixed at one session by fiat, because within-session continuity bounds variability. Map switches occur at 100 ms–1 s (Jezek 2011; Kelemen & Fenton 2016), so the timescale is a free choice, not a derivation. How often beliefs are recomputed (every theta cycle? at event boundaries?) is open — the paper points at [[wiki/concepts/event-segmentation.md]].
- **Exact inference is intractable**, so all results compare a handful of hand-picked partitions. The authors call the whole paper **"an analytical heuristic rather than an algorithmic theory"**. *Proposal generation* — where the candidate partitions come from — is named as the unsolved key step.
- **No hierarchy, and no factors.** States are independent atoms; a remap is therefore all-or-nothing, whereas measured remaps are *partial by dimension* — spatial position re-shuffles while lap identity survives in the same cells (Whittington et al. 2020, [[wiki/entities/tolman-eichenbaum-machine.md]]) — which a conjunctive `g ⊙ x` code predicts and a single discrete `c` does not; nothing lets state 5 be "state 3 with one wall moved", though McKenzie 2014's nested representational similarity and the dorsoventral place-field-size gradient are offered as places a hierarchy would live.
- **Long-term place-field drift** (Ziv 2013; Rubin 2015) is not accounted for; the generative model has no time.
- **~~No causal link from remapping to behaviour~~ — the adjacent claim is now causal, the literal one is not.** Mishchanchuk et al. 2024 ablate ventral CA1 pyramidal neurons in mice performing a reversing probabilistic bandit and shift behaviour from state inference toward Q-learning, while removing the state-inference signature from accumbens dopamine; the same population is shown by miniscope imaging to carry an abstract, cross-generalizing code for the task's two latent contexts ([[wiki/concepts/contextual-inference.md]]). So *the hippocampal latent-context code is necessary for context-dependent behaviour* is established. What is still not established is this page's own claim: nobody has shown that **remapping** — the switch between codes — is the causal event, because the lesion removes the code and the posterior together, and the fitted inference model has **fixed cardinality (2 states)**, so nothing tests the allocation half at all.

## Sampling as the missing algorithm

The one algorithmic suggestion, and the reason the paper matters for implementation: represent the posterior by **sampling** — each theta cycle draws one hidden state, so a hypothesis is visited at a rate proportional to its probability. This predicts the observed rapid flickering between maps (Jezek 2011; Kelemen & Fenton 2016; Kay 2019), and predicts that **overdispersion / map-switching rate should decline over training** as the evidence ratio moves away from 0. That converts an abstract uncertainty into a measurable dynamical quantity, and is the concrete alternative to computing a posterior explicitly.

**The mechanistic rival takes the same data away.** Mark et al. 2017 reproduce the Jezek 2011 flickering with no posterior anywhere: two competing attractor maps whose recurrent synapses carry short-term plasticity, so the abandoned map keeps a transient *gain* advantage (a `τ_f > τ_r` synaptic rebound) that theta troughs periodically let win a cycle ([[wiki/entities/stp-flickering-cann.md]]). Both accounts predict a decaying switch rate, so the decline this page offers as its signature does not discriminate. Two things do: the STP account predicts flicker rate falls with **distance travelled from the switch position** (partial `r = −0.157`, `p = 0.027`, velocity-confounded) — sampling has no reason to care where the animal is — and it predicts flickering is keyed to the *recency* of the abandoned map rather than to its probability. Logged as [[wiki/empirical-tensions.md]] T56.

---

## Comparison to related models

| Model | What a "context" is | Allocation rule | Uncertainty representation | Domain |
|---|---|---|---|---|
| **This model** | a hidden state = one map, atomic | CRP concentration `α` | graded remapping across a *population* | hippocampal place cells |
| [[wiki/entities/coin-model.md]] | a context with scalar state + Markov transitions + cues | sticky hierarchical Dirichlet process (`γ, κ, α`) | mixture weights on motor output | human sensorimotor adaptation |
| Fuhs & Touretzky 2007 | a hidden Markov model per context | Bayesian model comparison | not emphasised | the acknowledged predecessor; "technical differences are subtle" |
| [[wiki/entities/temporal-context-model.md]] | a drifting context vector, continuous | none — no discrete allocation | none | free recall + entorhinal drift |
| Attractor / [[wiki/entities/rolls-treves-hippocampal-model.md]] | a basin of attraction | none — set by storage | none (all-or-none selection) | CA3 mechanism |
| Similarity-threshold accounts | a fixed feature set | fixed change-detection threshold | none | — |

The paper's explicit verdict on the last two rows: a similarity threshold "cannot account for any of the ways in which learning affects remapping", and an attractor network is a candidate *implementation* of this model, connectable through the Boltzmann-machine reading (basins = feature configurations of distinct hidden states; a mixture of Boltzmann machines = a state-dependent energy function plus a distribution over states).

---

## Connections

- **[[wiki/concepts/contextual-inference.md]]** — the principle this model instantiates, and the wiki's second independent domain for it: the same nonparametric posterior, here with a *neural* read-out (remapping) instead of a behavioural one.
- **[[wiki/entities/coin-model.md]]** — the sensorimotor sibling: same CRP-family prior and same allocate-vs-reuse logic, richer (transitions, cues, state dynamics) but with no population read-out of uncertainty, which is exactly what this model supplies.
- **[[wiki/concepts/pattern-separation-completion.md]]** — supplies the *why* for that page's *how*: the transfer curve is the compiled form of this posterior, and the allocate-vs-reuse knob is `α`.
- **[[wiki/concepts/cognitive-map.md]]** — answers the "which map?" half of that page's context-retrieval/orientation split, and formalises the orientation half as an argmax over rotational offsets computed separately per candidate map.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the map-selection step of the framing: before a graph can be navigated, the agent must decide which stored graph is generating the current observations, and whether to allocate a new one.
- **[[wiki/concepts/event-segmentation.md]]** — leaves the segmentation timescale as an explicit free choice ("what is an observation?"), and names event segmentation as one candidate answer for when beliefs are recomputed.
- **[[wiki/entities/temporal-context-model.md]]** — the similarity-based rival for the same phenomena; the two diverge on training variance, where only a generative model predicts that a previously variable cue is tolerated.
- **[[wiki/concepts/successor-representation.md]]** — the proposed content of the unspecified feature vector, which would make remapping sensitive to predictive relationships between states rather than to sensory ones.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the complementary constraint this model does not supply: allocating a new hidden state says *that* a new map is made, not *which* one, and the recordings show the new map is not free — place-to-grid relationships are preserved across a global remap, so the new state inherits the old structural code ([[wiki/empirical-tensions.md]] T39), now replicated in a second dataset and extended to a non-spatial dimension: in two sensory versions of a 4-lap task, cells remap spatially while *preserving* lap preference, so a remap is selective per factor of the code rather than being a new atom — which is precisely what an atomic hidden state cannot express (Whittington et al. 2020).
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the mechanistic account this one sits above: attractor selection as the implementation of state selection, with the Boltzmann-machine formulation as the stated bridge.
- **[[wiki/concepts/energy-based-models.md]]** — the bridge itself: a mixture of Boltzmann machines is a state-dependent energy function plus a distribution over states, which is this generative model written as energies.
- **[[wiki/concepts/offline-replay.md]]** — theta-cycle sampling makes map flickering a *posterior sample*, so hippocampal alternation between maps is an inference algorithm rather than noise.
- **[[wiki/entities/spiking-tem.md]]** — the realignment/remapping dissociation reproduced in a spiking substrate under a pure sensory recode (one-hot → two-hot) with geometry and parameters fixed: entorhinal cells keep gridness and shift phase, hippocampal fields relocate, so any hidden-state account must explain why one population treats the change as the same state and the other as a new one.
- **[[wiki/entities/cscg.md]]** — the same inference run one level down, over states *within* a single map rather than over maps: when the 2ACDC track is metrically stretched, CA1 either holds the current state past its usual extent or jumps to the next plausible one, then resets on the first disambiguating cue (Sun et al. 2025) — a discrete posterior with an observation-triggered reset, which is this page's mechanism without the remapping.
- **[[wiki/entities/stp-flickering-cann.md]]** — the mechanistic rival to this page's one algorithmic proposal: the same theta-paced map alternation produced by short-term synaptic facilitation in the abandoned map plus an inhibitory reset, with no posterior and no allocation, so map flickering is evidence for a sampler only if the recency-driven account is excluded (T56).
- **[[wiki/entities/adaptive-cann.md]]** — the same alternation produced with no posterior anywhere: near a bifurcation an attractor's state sweeps or jumps because its own adaptation destabilises it, so revisit *rate* is a function of gain and noise rather than of probability — which sharpens what this page's sampling account has to predict that a dynamical account does not (T56, T58).
- **[[wiki/entities/boltzmann-machine.md]]** — the component of the proposed *mixture*: one state-dependent energy function plus stochastic sampling of it, so a basin is the feature configuration of one inferred hidden state and the mixture weight is the state posterior.
- **[[wiki/concepts/population-geometry.md]]** — the same latent-context variable read out by a different instrument: remapping is the *identity* of the map expressing the posterior, CCGP/PS are the *format* of the context direction within one map, and neither sees what the other does.
