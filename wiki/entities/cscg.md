# Clone-Structured Cognitive Graph (CSCG)

**A hidden Markov model whose emission structure is fixed and degenerate — every sensory observation owns a private pool of "clone" latent states — so learning transitions *is* learning a de-aliased state space.**

The wiki's requirement list has said "clone cells, or path-integrated identity" for de-aliasing (hardness source 3, gap G2) since the framing page was written. CSCG is the clone half made concrete (George et al. 2021, as reviewed by Whittington et al. 2022).

**It is also, since Sun et al. 2025, the only model in the wiki matched to a brain on its *learning trajectory* rather than on its endpoint** — see "The in-vivo test" below.

---

## Architecture

| Element | Form |
|---|---|
| Latent states | `Z = {z_1 … z_T}`, **discrete**; each `z_i` is a clone of one observation. 4 observations × 5 clones = 20 states |
| Emission | Deterministic and fixed: `p(x \| z_i ∈ C(x)) = 1`, `p(x \| z_i ∉ C(x)) = 0` |
| Transition | `p(z_t, a_t \| z_{t-1})` — learned; this is the state graph |
| Objective | `p(X, A) = Σ_Z Π_t p(x_t \| z_t) p(z_t, a_t \| z_{t-1})`, trained by expectation–maximisation |
| Inference | Which clone is active now (Bayes), given the sequence |
| Planning | **By inference**: condition the model on a start and a goal clone, infer the distribution over intervening action sequences |

The whole trick is in the emission. Because `p(x|z)` is frozen at 0/1, no capacity is spent learning what a state looks like, and the only free parameters are the edges. Aliasing is handled structurally: a frog seen in two places is two different clones with different neighbours.

---

## What it buys

| Property | Statement |
|---|---|
| **De-aliasing without supervision** | The state space is *learned*, not supplied by the modeller — the strongest available answer to G2 |
| **Local, fast, biologically plausible** | Learning rules are local; the whole latent space lives in hippocampus rather than in cortical input to it |
| **One-environment speed** | A new map is built from a single traversal-length experience |
| **Planning without search** | Conditioning a probabilistic model on start and goal, then reading off actions — "planning by inference", an alternative to tree search |
| **Predicts the non-spatial cell zoo** | Splitter cells and other trajectory-dependent responses fall out as clones of the same observation with different futures |

---

## What it cannot do

| Limit | Consequence |
|---|---|
| **Learns each map *de novo*** | No benefit from having learned a structurally identical world before — zero transfer, the meta-graph level is absent. Measured against biology this is now a *quantified* deficit and not a stylistic one: mice reuse an established state machine for a new cue pair at 147 vs 483 trials, rebinding only the sensory leaf (Sun et al. 2025) |
| **Predicts nothing about the order of learning without the modeller's help** | The one thing the model uniquely gets right — the decorrelation sequence — inverts if the reward and reward-cue symbols are presented in the other order, a choice the task itself does not fix (Sun et al. 2025, G46) |
| **No place cells for space** | Without extra assumptions it learns splitter cells but *not* the spatial cells that co-exist with them, because it cannot profit from generalising the structure of space ([[wiki/empirical-tensions.md]] T29) |
| **Clone pool is a hyperparameter** | Capacity per observation is set by hand — the allocate-vs-reuse threshold of gap G38 in its crudest form |
| **Discrete and flat** | No hierarchy, no compositional bases, no continuous interpolation |

---

## The in-vivo test (Sun et al. 2025)

The first dataset that watches a hippocampal map *form* at cell resolution over its whole learning period, and then asks which model reproduces the sequence of intermediate states rather than the final one.

| Element | Detail |
|---|---|
| **Task (2ACDC)** | 230 cm virtual linear track, two trial types. An indicator cue (near/far) at the start perfectly predicts which of two visually **identical** reward cues will be rewarded; four featureless "grey" regions are visually identical within and across trial types. Reward requires licking in the correct zone; no penalty for licking in the wrong one |
| **Recording** | Two-photon mesoscope, dorsal CA1, 11 mice, ~4,700 cells per session, **3,034–5,354 cells tracked longitudinally** across weeks |
| **Behaviour** | Four overlapping strategies in fixed order — random licking → lick at both reward zones → lick–stop after reward → expert. Gradual waves, not discrete switches (coefficient of partial determination; the four regressors explain 36.5 ± 5.9% of lick variance) |
| **Neural result** | Population-vector correlation between corresponding track positions falls to ≈0 (population-vector angle → 90°) in an **ordered** sequence: the four within-track grey regions decorrelate first (by session 3), then the region before the far reward (pre-R2), then the region before the near reward (pre-R1). Track start and end stay correlated in most mice — correctly, since the animal has no trial-type information there |
| **Single cells** | Multi-grey-region cells become single-region cells; place-like responses at ambiguous positions become splitter responses. In a difference-score × correlation plane the categories are a **continuum**, not types, and individual cells migrate across it during learning — the paper's term is **state cells** |
| **Endpoint** | An orthogonalized state machine (OSM): one near-orthogonal population state per latent task state, with the indicator's short-term memory carried as *state identity* rather than as sustained activity |

**The model comparison — and the discriminating variable is the order, not the endpoint.**

| Model | Final representation orthogonal? | Reproduces the decorrelation *order*? |
|---|---|---|
| **CSCG** (100 clones/symbol, Baum–Welch expectation–maximisation, 20 iterations per step on 20 trials) | Yes | **Yes** — off-diagonal → pre-R2 → pre-R1, the only model that does |
| RNN, softmax activation (soft winner-take-all) | Yes | No — pre-R1 before or with pre-R2 |
| Spiking RNN + soft winner-take-all + timing-based Hebbian rule, no task and no end-to-end training | Yes | No |
| RNN, ReLU or sigmoid | **No** | — |
| LSTM | **No**, unless the loss explicitly penalises between-trial-type correlation | — |
| Transformer (minGPT, GPT-micro, context ≥ 4 sufficient) | **No** | — |

Three readings the wiki should carry:

1. **Orthogonalization is not required to solve the task.** Every model above predicts the next observation accurately. Perfect performance only needs the population to be separable in the low-dimensional subspace the readout uses, which leaves the remaining dimensions free; the brain nonetheless orthogonalizes fully. So decorrelation is a *choice* made by architecture and cost function, not a consequence of the objective ([[wiki/empirical-tensions.md]] T53, [[wiki/concepts/objective-identifiability.md]]).
2. **Two independent routes reach the same endpoint.** Gradient descent with a soft winner-take-all nonlinearity, and purely local Hebbian plasticity with feedback inhibition, both orthogonalize. Neither needs the other, and the biologically plausible one needs no error signal at all — which places recurrent inhibition, not the learning rule, as the load-bearing component ([[wiki/concepts/inhibitory-control-of-coding.md]]).
3. **The trajectory match is contingent on the modeller's encoding.** CSCG is trained on a hand-written symbol sequence, and the paper reports that presenting the water symbol *before* the reward-zone visual symbol flips the model's order to pre-R1 before pre-R2 — the wrong one. The final transition graph is identical under all four encodings tried. So the wiki's one dynamics-level match is one input-format decision deep (gap G46).

**Flexible reuse — the property CSCG does not have.** After the state machine is learned, replacing the indicator pair with an unfamiliar one is learned in **147 ± 39 trials against 483 ± 70** for the original, and population-vector correlation between old-cue and new-cue trials is high **everywhere except the indicator region**: the state machine is reused wholesale and only the sensory leaf is rebound. Under stretched trials (grey zones lengthened, reward moved) the representation settles into *discrete* inferred states rather than rescaling — on near trials pre-R1 tuning persists through the extension, on far trials cells jump to the pre-R2 state as if anticipating the far reward, then reset when the first reward cue appears. Both are structure reuse across task variants, which is exactly the transfer a per-environment clone model has to learn again from scratch.

---

## Comparison

| | CSCG | [[wiki/entities/tolman-eichenbaum-machine.md]] | [[wiki/concepts/successor-representation.md]] |
|---|---|---|---|
| Hippocampus is | the **map** (its edges are the graph) | a **memory index** binding cortical codes | the map (rows of `S`) |
| State space | learned per environment | reused across environments | supplied |
| Learning | local, EM, fast | gradient, slow, many environments | TD or closed form |
| Generalises to a new world of the same shape | No | Yes | No |
| De-aliases | Yes | Yes (via `g`) | No |

**The proposed merge.** Both models use multiple clone cells per observation, and both are probabilistic, so they compose directly: a TEM-like architecture in which hippocampus additionally predicts *future hippocampal states*. Fast per-task map construction from CSCG, transfer from TEM. Whittington et al. state this as the unification, not as a result — nobody has built it.

**Hardness-source coverage** ([[wiki/concepts/latent-graph-discovery.md]]): source 3 (aliasing) ✓ · source 4 (simultaneity) ✓ (online Bayesian filtering while acting) · source 1 (two-level) ✗ · source 2 (vocabulary — observations and actions are given) ✗ · source 5 (spurious edges) ✗ · source 6 (non-stationary topology) ✗.

---

## Connections

- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the same write-side problem solved without a decision: clone allocation is explicit bookkeeping, mossy-fibre projection gets orthogonality by random hashing and pays for it by not recognising repeats.

- **[[wiki/concepts/latent-graph-discovery.md]]** — the concrete instantiation of "clone cells" that hardness source 3 and gap G2 had been naming without a mechanism: a frozen 0/1 emission turns state-space discovery into transition learning.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the same operation with the biology stripped out: allocating a fresh clone *is* separation, and the clone-pool size is the separation/completion bias set by hand rather than tuned (G38).
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the complementary failure: CSCG learns any single map fast and transfers nothing; TEM transfers and cannot build a novel map quickly. Both use per-observation clones, which is what makes the proposed merge trivial to state.
- **[[wiki/concepts/successor-representation.md]]** — the natural consumer: CSCG's discrete de-aliased states are exactly the state space the SR presupposes.
- **[[wiki/concepts/simulation-based-planning.md]]** — planning by inference rather than by rollout: condition a generative model on start and goal and infer the action sequence, which needs no value function and no search tree.
- **[[wiki/concepts/complementary-learning-systems.md]]** — puts the *map* in the fast store: hippocampus holds the relational graph itself, so consolidation becomes cortex learning the statistics of already-de-aliased maps rather than of raw episodes.
- **[[wiki/concepts/contextual-inference.md]]** — the same allocate-or-reuse question answered structurally (a fixed clone pool per observation) instead of statistically (a posterior over an unbounded context set).
- **[[wiki/concepts/objective-identifiability.md]]** — the reason this page's in-vivo test is built around a *trajectory*: matching endpoints leaves the objective unidentified, and here five architectures with different objectives reach the same orthogonal endpoint while only one reproduces the order in which it is reached.
- **[[wiki/concepts/population-geometry.md]]** — the same dataset read at the level of manifold shape: the decorrelation sequence appears as a topological progression (unstructured cloud → hub-and-spoke → ring → split-shank ring), which is what makes "state machine" a measured description rather than a metaphor.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the mechanism that turns out to be sufficient for this model's endpoint: soft winner-take-all through feedback inhibition orthogonalizes under a purely local Hebbian rule, with no task, no error signal and no expectation–maximisation.
- **[[wiki/concepts/cognitive-map.md]]** — supplies the map this model claims to be; Sun et al. 2025 is the only place where that claim is tested against the map's whole formation rather than its finished form.
- **[[wiki/entities/temporal-context-model.md]]** — the graded rival on same-place-different-history: leaky integration of past movements separates two visits automatically but never completely, where clone allocation separates them discretely and exactly but only within one environment.
- **[[wiki/entities/spacetime-attractor.md]]** — the other planning-by-inference model in the wiki, with the roles swapped: there the transition model is a learned clone matrix conditioned on a start and goal to infer actions sequentially; here copies of the adjacency matrix are wired between delay-subspaces so the whole action sequence settles at once, and reward is represented explicitly (Jensen et al. 2026).
