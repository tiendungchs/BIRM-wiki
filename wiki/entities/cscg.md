# Clone-Structured Cognitive Graph (CSCG)

**A hidden Markov model whose emission structure is fixed and degenerate — every sensory observation owns a private pool of "clone" latent states — so learning transitions *is* learning a de-aliased state space.**

The wiki's requirement list has said "clone cells, or path-integrated identity" for de-aliasing (hardness source 3, gap G2) since the framing page was written. CSCG is the clone half made concrete (George et al. 2021, as reviewed by Whittington et al. 2022).

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
| **Learns each map *de novo*** | No benefit from having learned a structurally identical world before — zero transfer, the meta-graph level is absent |
| **No place cells for space** | Without extra assumptions it learns splitter cells but *not* the spatial cells that co-exist with them, because it cannot profit from generalising the structure of space ([[wiki/empirical-tensions.md]] T29) |
| **Clone pool is a hyperparameter** | Capacity per observation is set by hand — the allocate-vs-reuse threshold of gap G38 in its crudest form |
| **Discrete and flat** | No hierarchy, no compositional bases, no continuous interpolation |

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
- **[[wiki/entities/temporal-context-model.md]]** — the graded rival on same-place-different-history: leaky integration of past movements separates two visits automatically but never completely, where clone allocation separates them discretely and exactly but only within one environment.
