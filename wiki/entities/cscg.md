# Clone-Structured Cognitive Graph (CSCG)

**A hidden Markov model whose emission structure is fixed and degenerate — every sensory observation owns a private pool of "clone" latent states — so learning transitions *is* learning a de-aliased state space.**

The wiki's requirement list has said "clone cells, or path-integrated identity" for de-aliasing (hardness source 3, gap G2) since the framing page was written. CSCG is the clone half made concrete.

> **Provenance.** George, Rikhye, Gothoskar, Guntupalli, Dedieu & Lázaro-Gredilla 2021, *Clone-structured graph representations enable flexible learning and vicarious evaluation of cognitive maps*, Nat. Commun. 12:2392 (`raw/george-2021-clone-structured-cognitive-graphs.md`) — the primary, ingested after the page was written from Whittington et al. 2022's review and Sun et al. 2025's in-vivo test. **It corrects two limits the second-hand summary asserted:** the model does transfer a learned graph to a new environment (§Schema transfer), and it does yield a hierarchy (§Hierarchy by community detection). Both come with a caveat the review dropped, recorded below.

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
| Learning rule | Baum–Welch expectation-maximisation. E-step `α(n+1)ᵀ = α(n)ᵀ T(x_n, a_n, x_{n+1})`, `β(n) = T(x_n, a_n, x_{n+1}) β(n+1)`; M-step is row-normalisation of the accumulated `ξ_{ikj}` |
| Regularisation | A pseudocount `κ` added to the count statistic before normalising — a Laplacian prior on `T`, so every action has non-zero probability everywhere. Kept as a rank-1 term added to a block-sparse matrix, so it costs nothing. Then re-run with `κ = 0` (Viterbi training) to delete unused clones |
| Cost | `O(M²N)` time and `O(H²+MN)` memory for `M` clones per symbol, versus `O(H²N)` for a plain HMM with `H = ME` states — **independent of alphabet size `E`**, because a frozen 0/1 emission means only one `T(i,·,j)` block is touched per step |

The action is grouped with the *next* hidden state, `p(z_{t+1}, a_t | z_t)`, which removes the loop in the graphical model and leaves a chain — so belief propagation is **exact**, not approximate. Two consequences the model gets for free rather than by design: actions are *observed integers with unknown semantics* (the agent knows `a=0` happened, not that it means "north"), and because the model scores `p(z_{t+1}, a_t | z_t)` rather than `p(z_{t+1} | z_t, a_t)`, it learns which actions are **feasible** in a state, which an action-conditioned formulation cannot ask.

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

## What the primary demonstrates (George et al. 2021)

All experiments: random walks of action–observation pairs in gridworlds where observations are severely aliased and no Euclidean, 2D or metric assumption enters the model. Learning is judged by whether the recovered transition graph is *the* graph — Viterbi decoding uses exactly 48 states on a 6×8 room, the theoretical optimum.

| Result | Setup | Why it matters here |
|---|---|---|
| **Map from aliasing alone** | 6×8 room, 48 locations, **4** distinct observations, 50k steps | The state space is recovered when observation carries almost no location information. Degrades gracefully with size: a 9×11 room's periphery is exact, a few interior cells stay merged. Partial recovery even with actions withheld |
| **Transitive inference by stitching** | Two 8×6 rooms sharing a 3×3 corner patch, experienced in two *separate* 10k random walks, one CSCG trained on both as independent sequences | The overlap is merged and the combined map supports navigation between regions **no trajectory ever connected**. A second patch in room 1 that is *observationally identical* to the overlap stays unmerged — sequential context, not local appearance, decides identity. During the first traversal of the overlap, clones of both candidate patches are simultaneously active; stepping out resolves it |
| **Schema transfer** | Freeze `T` learned in room 1, re-initialise the emission matrix, learn only `E` in a new room from **20 action–observation pairs** along its periphery | Shortest-path queries return correct action sequences through cells **never visited**; blocking the path returns the next Dijkstra-optimal route. Viterbi decoding of a path in room 2 recovers the same hidden states as the same path in room 1. With `T` reused, the new room is fully learned the moment every cell has been visited once |
| **Hierarchy by community detection** | InfoMap run on the learned `T`, twice: 4×4 grid of aliased rooms joined by corridors, itself grouped into four hyper-rooms | Communities **respect room boundaries** (a room may split, no community straddles rooms); a second pass recovers the hyper-rooms. Planning top-down through the hierarchy gives paths **25% shorter** than flat Dijkstra on the same graph; surrogate communities that ignore room boundaries give paths **35% longer** — so the gain is in the partition, not in being hierarchical |
| **The negative control for the row above** | Successor representation computed on *observations*, same maze | Community detection and multidimensional scaling on the SR **fail** to recover the communities. Partitioning must run on the de-aliased latent graph; under partial observability a first-order model of the observation stream has no modularity to find |
| **Remapping as two knobs** | One CSCG trained on five 5×5 rooms (identical 25 observations, permuted) and on five mazes, switched at unsignalled irregular intervals | Global remapping = EM run to convergence (clone sets maximally disjoint). Partial remapping = partial training. **Rate remapping = smoothing/soft evidence at convergence** — the same clones fire, at lower rates, because uncertainty spreads evidence across clones of one observation. Environment identity is decodable from the population despite every observation being shared |
| **Error correction** | 20% of symbols corrupted uniformly | Forward-pass MAP fixes 50/55 corrupted symbols in rooms and 46/54 in mazes, corrupting none of the clean ones — de-aliasing and denoising are the same operation run on the same messages |
| **Lap cells and splitters** | 4 laps of a rectangular track before reward; T-maze figure-of-eight | Distinct clones per lap with **no lap-boundary marker in the input**, and graded cross-lap activity (a signature of event-specific representation) falling out of smoothing rather than being fitted. Elongating the maze preserves the lap-specific traces — the repeated observation is explained away as noise at the previous step |

**Planning is one algorithm, not a family.** Clamp the current clone and a goal (specified as an observation *or* as a specific clone), run belief propagation, read the action sequence off the backward pass; a forward pass says at what horizon the goal becomes feasible. The same machinery, with no retraining and only a change of which variables carry evidence, answers: where am I, which actions are feasible here, what will I see `k` steps ahead marginalising over unseen actions, which actions get me there, generate a plausible trajectory. Goals are arbitrary and chosen at test time.

---

## Neurobiological circuit

The mapping is stated by the authors, not derived from data — but it is unusually literal, and it is what makes the model's cost local.

| Model object | Circuit claim |
|---|---|
| One clone | One neuron (or a small assembly — the representation is unchanged) |
| Transition matrix `p(z_{t+1}\|z_t)` | **Lateral** connections among clone neurons; axonal branches are the graph's directed edges |
| Emission `C(x)` | The shared **bottom-up** input: all clones of one observation receive the same afferent |
| Forward message | Clone output = weighted sum of lateral inputs **×** bottom-up input — a multiplicative gate, so context selects among the sequences an observation participates in |
| Soft evidence | Graded activation over observation neurons; ambiguity shows as a spread population code over clones, in proportion to posterior probability |
| Learning | EM approximated by spike-timing-dependent plasticity |
| Anatomy | Representation learning in CA3/CA1; CSCG-based decision-making in orbitofrontal cortex |
| Replay | Two distinct roles — post-learning Viterbi consolidation of trajectories, and behaviour-time sampling for vicarious evaluation of multiple goals |

**Grid cells are demoted to an input.** In this account the grid code is "just another sensory modality" feeding the sequencer, useful because it gives a periodic tiling when other cues are degenerate — not a scaffold the map is built on. The authors go further: SR eigenvectors look grid-like because *any* method with a transition matrix has such eigenvectors, and they suspect the property has no behavioural relevance. That is an explicit challenge to [[wiki/concepts/abstract-structural-codes.md]]'s spectral derivation, offered as a suspicion with a supplementary result behind it.

---

## What it cannot do

| Limit | Consequence |
|---|---|
| **Transfers only when the modeller performs the transfer** | Not "zero transfer" — the primary reuses `T` across rooms and relearns only `E`, which is genuine structural transfer and buys shortcut planning through unvisited cells (§Schema transfer). What is absent is every part that would make it autonomous: nothing stores more than one `T`, nothing **selects** which stored `T` fits the new environment, nothing detects that no stored `T` fits, and the reuse is *identity* on the graph rather than a deformation of it (which is why G83 still stands). The environments must also share topology exactly. Measured against biology the autonomy is what is missing: mice reuse an established state machine for a new cue pair at 147 vs 483 trials, rebinding only the sensory leaf, with no experimenter freezing anything (Sun et al. 2025) |
| **Predicts nothing about the order of learning without the modeller's help** | The one thing the model uniquely gets right — the decorrelation sequence — inverts if the reward and reward-cue symbols are presented in the other order, a choice the task itself does not fix (Sun et al. 2025, G46) |
| **No place cells for space** | Without extra assumptions it learns splitter cells but *not* the spatial cells that co-exist with them, because it cannot profit from generalising the structure of space ([[wiki/empirical-tensions.md]] T29) |
| **Clone pool is a hyperparameter** | Capacity per observation is set by hand — the allocate-vs-reuse threshold of gap G38 in its crudest form. The pseudocount does some of the work automatically (20 clones allocated where 7 suffice, redundant ones removed by the regulariser plus Viterbi training), but the ceiling is still the modeller's |
| **Hierarchy is extracted, not represented** | Community detection does recover the room/hyper-room nesting, but it runs *outside* the model, offline, on the finished `T` — the CSCG's own state space stays flat and single-scale. Nothing in the model schedules re-partitioning when the graph estimate changes, and the number of levels is set by how many times the modeller re-runs InfoMap |
| **Discrete and non-compositional** | No compositional bases, no continuous interpolation; a state is an index, so two states cannot be *partly* the same |
| **Vocabulary is given** | Observations arrive as integers and actions as integers with unknown semantics — the model never has to decide what counts as an observation or an action, which is hardness source 2 handed to the modeller (gap G4) |

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
| Generalises to a new world of the same shape | Only if the modeller freezes `T` and relearns `E` | Yes, automatically | No |
| Inference | **exact** (chain, belief propagation) | approximate — the representational complexity forbids exact | closed form, but for a fixed policy |
| Goal chosen at test time | Yes — clamp any clone or observation and infer | No | Requires recomputing `S` when the policy or the goal moves |
| Native handling of ambiguous or erroneous observations | Yes (soft evidence; 50/55 corrupted symbols repaired) | Not stated | No |
| Recovers latent hierarchy | Yes, by partitioning `T` offline | Not demonstrated | Only under **full** observability |
| De-aliases | Yes | Yes (via `g`) | No |

**The primary's own comparison** is sharper than the review's, and the four rows above the de-aliasing row are its claims. Against TEM: arbitrary test-time goals, exact inference, native uncertainty. Against SR: the SR aggregates future occupancy *under a policy*, so dynamic planning means recomputing it, and it is first-order over observations, so it cannot find communities when observations are aliased.

**The proposed merge.** Both models use multiple clone cells per observation, and both are probabilistic, so they compose directly: a TEM-like architecture in which hippocampus additionally predicts *future hippocampal states*. Fast per-task map construction from CSCG, transfer from TEM. Whittington et al. state this as the unification, not as a result — nobody has built it.

**Hardness-source coverage** ([[wiki/concepts/latent-graph-discovery.md]]): source 3 (aliasing) ✓ · source 4 (simultaneity) ✓ (online Bayesian filtering while acting) · source 1 (two-level) ~ (a nesting *is* recovered, but by an external partitioner run on the finished graph, not by the learner) · source 2 (vocabulary — observations and actions are given as integers) ✗ · source 5 (spurious edges) ✗ · source 6 (non-stationary topology) ✗.

---

## Connections

- **[[wiki/entities/alphazero.md]]** — the complementary halves of the framing: CSCG learns the graph and then plans by conditioning a generative model with no value function and no tree, AlphaZero is handed an exact graph and does nothing but search it.

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
- **[[wiki/concepts/path-integration.md]]** — the other solution to the same de-aliasing problem, and the slow half of the trade: integrating actions is expensive to acquire but transfers across environments, where a clone pool is fast, local and per-environment.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — the same inference run one level down, over states *within* a single map rather than over maps: a metrically stretched track makes CA1 hold the current state past its usual extent or jump to the next plausible one, then reset on the first disambiguating cue.
- **[[wiki/entities/hami.md]]** — the same discrete-allocation answer to aliasing one level out: clones are allocated over latent states inferred from transitions, symbols over sensory identities scored by a frozen contrastive metric, and both then get de-aliasing free from the allocation bookkeeping — with the clone pool's hand-set size and HAMI's similarity threshold being the same free parameter (Poursiami et al. 2025).
- **[[wiki/concepts/circuit-size-separation.md]]** — the cost of this model's founding operation on a different substrate: deciding whether two identical observations are one latent state or two is element distinctness, which one spiking neuron computes in temporal coding and a sigmoidal net provably needs `Ω(n)` hidden units for (Maass 1997).
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the graph-partitioning family of option discovery, built and measured: InfoMap on this model's learned `T` returns a room/hyper-room nesting that respects the true boundaries and plans 25% shorter paths, and the SR-on-observations control shows the partition has to run on the *de-aliased latent* graph rather than on the observation stream (George et al. 2021).
- **[[wiki/concepts/schema-assimilation.md]]** — assimilation and accommodation as two matrices: reusing `T` and relearning only `E` is assimilation of a new world into an existing schema, running EM on both matrices is accommodation, and the model has no rule that chooses between them.
- **[[wiki/concepts/loopy-belief-propagation.md]]** — the reason this model's inference is exact rather than approximate: grouping the action with the next hidden state removes the loop and leaves a chain, so one forward and one backward sweep answer every query, and the "loopy" caveats do not apply.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the claim aimed directly at that page: George et al. suspect grid-like SR eigenvectors are a generic property of *any* transition matrix with no behavioural relevance, and treat the grid code as one more sensory input to the sequencer rather than as the scaffold the map is built on.
- **[[wiki/entities/visual-predictive-coder.md]]** — the same aliasing problem left as a side-effect instead of made the learning target: there the de-aliasing is whatever an attention layer happens to do and the map is only decodable by a probe, where clone pools de-alias by construction and the transition matrix *is* the map, routable as it stands.
- **[[wiki/concepts/optimal-hierarchy-criterion.md]]** — the normative account of why this system's InfoMap partition is the right one and not merely a convenient one: for an ensemble of shortest-path tasks, the maximum-model-evidence decomposition lands on topological bottlenecks, so room-respecting communities approximate a provably search-minimising subgoal set (Solway et al. 2014).
- **[[wiki/concepts/eigenoption-discovery.md]]** — the alternative use of this system's learned transition matrix: diagonalise it instead of running InfoMap on it, and each eigenvector yields an intrinsic reward whose optimal policy is an option with its own timescale — a flat graded library rather than a nested bottleneck hierarchy, sharing this system's de-aliasing prerequisite, since an aliased feature map corrupts the incidence matrix exactly as it corrupts the adjacency matrix (Machado et al. 2017).
- **[[wiki/entities/option-critic.md]]** — the same doorway subgoals reached without a graph: where this page's InfoMap pass needs a de-aliased transition estimate and an offline partitioner to find room boundaries, option-critic's termination probabilities concentrate near four-rooms doorways from return pressure alone — which leaves open whether the return route survives aliasing, since it has no state model to be aliased (Bacon, Harb & Precup 2017).
- **[[wiki/entities/feudal-networks.md]]** — the same waypoint structure from an incompatible starting point: this page partitions an estimated transition graph offline and gets room boundaries, FuN emits directions online in a space that is never a graph and its Montezuma's Revenge goals land on the waypoints a human designer had hand-placed — a third objective recovering bottleneck-like structure, which weakens any claim that bottleneck-ness belongs to one discovery principle (Vezhnevets et al. 2017).
- **[[wiki/entities/diayn.md]]** — the same partition sought without the de-aliaser, which makes this page's control experiment a prediction about it: CSCG recovers room communities by running InfoMap on a learned clone transition matrix, DIAYN learns a soft region assignment straight from rollouts and forms no matrix — so its discriminator should fail exactly where the successor representation over raw aliased observations failed, on observations two regions share.
