# Successor Representation

**Represent a state by *where you will go from it* — a discounted sum of expected future occupancies — so that value becomes a linear read-out and multi-step structure is precomputed.**

`S = Σ_n γⁿ Tⁿ`  ·  `v = S r`

`T_ij` is the transition probability from state `j` to `i` under policy `π`; `S_ij` measures connectedness through *all* paths. Value is then a single matrix–vector product against the reward vector: the SR is "one half of the value computation" already done, cached, and reward-independent (Whittington et al. 2022, reviewing Dayan 1993 and Stachenfeld et al. 2017).

---

## Why it sits between model-free and model-based

| | Model-free | **Successor representation** | Model-based |
|---|---|---|---|
| What is stored | `v(s)` or `Q(s,a)` | Expected future state occupancy | `T` and `r` separately |
| Reward moves | Relearn from scratch | **Instant** — recompute `Sr` | Replan |
| Obstacle appears / policy changes | Relearn | **Fails** — `S` was built under the old `π` | Replan correctly |
| Online cost | None | One product | Search |

Policy dependence is the known break point. The **default representation (DR)**, derived from linear RL, repairs it: build a representation for *default* behaviour that can be linearly updated when rewards change to approximate the new optimal policy. The DR resembles the SR, is computable from grid cells, and — the part the wiki cares about — supports building world representations **compositionally** out of component cell types (grid × border cells representing the insertion of a barrier).

---

## The neural claim

| Object | Resembles |
|---|---|
| **Rows of `S`** | Hippocampal place fields (skewed by the policy, deformed by barriers) |
| **Eigenvectors of `S`** | Entorhinal grid cells — matching the separate result that eigenvectors of *place-cell correlation matrices* look like grids |

This is the wiki's second derivation of grid-like coding from first principles, and it is independent of [[wiki/concepts/path-integration.md]]: there, grids fall out of an action-composition update rule; here, out of the spectral structure of a diffusion process. Both land on the same cell type, which is why the eigen-argument below matters — it shows the two are the *same* object seen in two bases.

---

## The human evidence: a discrete non-spatial graph read out as a predictive map

Everything above is theory plus rodent place/grid data. Garvert, Dolan & Behrens 2017 is the wiki's one demonstration that a **human** hippocampal–entorhinal signal carries a weighted-sum-of-future-states metric over a graph with **no continuous dimension at all**.

| Element | Detail | Why it matters here |
|---|---|---|
| Structure | 12-node graph; objects randomly assigned to nodes; day-1 stimulus sequence = random walk on the graph | The only relational information available is transition statistics — nothing to embed a continuum into |
| Task | Report each object's mirror/normal orientation. Structure never mentioned, never useful | The map is built with no reward, no goal, and no use for it |
| Awareness | 0 / 23 subjects reported any structure at debrief | A predictive map can be present, and behaviourally effective, while non-reportable |
| Readout | Day-2 fMRI while viewing a 7-node subgraph in *randomised* order (each of the 42 transitions 10× per block); response to object `i` given predecessor `j` = repetition-suppression → a 7 × 7 similarity matrix | The representational distance matrix is read off directly, not inferred from a decoder |

| Result | Numbers |
|---|---|
| Entorhinal BOLD increases linearly with graph link distance, bilaterally | FWE-corrected within an entorhinal/subiculum mask (left p = 0.014, right p = 0.006); replicated at an ROI coordinate taken from an unrelated **spatial** study (Chadwick et al. 2015), `F₂,₄₄ = 10.04` — the same voxels that measure physical distance measure graph distance |
| Graph distance, not elapsed time | Joint regression: links `t₂₂ = 3.29, p = 0.003`; mean temporal lag `t = 1.27, p = 0.22` |
| The metric is **non-directional** | Experience-frequency-weighted shortest path vs. its symmetrized self: only the symmetrized version predicts (`t = 2.78, p = 0.01` vs. `t = −1.64`) |
| The graph is recoverable | MDS on the 7 × 7 adaptation matrix reproduces the experimental graph (`r = 0.65`, `p = 0.003` against all other 7-link graphs; no crossing links, true of only 13.17% of the null) |
| **Not** Euclidean | Communicability survives with Euclidean distance as a competing regressor (left hippocampal formation, `p = 0.006` SVC) |
| Behaviour agrees, in a separate cohort (n = 26) | log RT scales with communicability (`t₂₅ = 2.77, p = 0.01`), *not* with link distance (`p = 0.69`) or Euclidean distance (`p = 0.40`) |

**Communicability — the parameter-free sibling of `S`.** Graph theory calls `(I − γA)⁻¹` the *matrix resolvent*; the SR is exactly that object built from the adjacency matrix `A`. Its close relative is the matrix exponential (Estrada & Hatano 2008):

`e^A = Σ_n Aⁿ / n!`   vs.   `S = Σ_n γⁿ Aⁿ = (I − γA)⁻¹`

Both are weighted sums over all paths, with `Aⁿ_ij` counting paths of length `n`; they differ only in the decay applied to long paths (`1/n!` vs. `γⁿ`). The exponential **has no free parameter**, which is why the paper regressed on it; the SR with the conventional `γ = 0.85/λ_max` fits the same voxels. The data therefore support "a predictive weighting over future states" and do **not** dissociate the two functional forms.

**(brainstorm)** Two exportable consequences. (i) *A cheap probe for models*: to ask whether a trained network has learned a domain's graph, regress its representational similarity matrix on `e^A` — a parameter-free target that needs no discount to fit and no assumption that the model's latent space is Euclidean. (ii) *The warp is the signature, not noise.* Communicability shortens edges lying on many paths and lengthens edges a random walker rarely uses, so the recovered metric is **traffic-weighted rather than topological** — a model whose latent distances match the adjacency matrix exactly would be *less* brain-like than one whose distances are distorted this way. That is a falsifiable target for [[wiki/concepts/representation-probing.md]] and a warning against scoring structure learning by adjacency reconstruction error.

**It is also the human datum the symmetrization result predicts.** Subjects' experience was directional (transitions were not equally frequent in both directions), yet only the *symmetrized* distance predicted the signal — exactly the `α ≈ β` write rule of Keck et al. 2025 below, and evidence that the brain's stored transition matrix is pulled toward reversibility rather than tracking the behavioural policy.

**Where it is thin.** Seven nodes, one undirected graph, BOLD adaptation rather than spikes; the SR/communicability distinction is untested; and because objects were distinct and never aliased, the subject's discovery problem was *edges only* — node identity was given ([[wiki/concepts/latent-graph-discovery.md]]'s hardness source 3 was switched off).

---

## Eigenspaces: one basis for every horizon

Diagonalise `T = V Λ Vᵀ`. Then `Tⁿ s = V Λⁿ Vᵀ s`: **all multi-step transition matrices share the same eigenvectors**, local and non-local alike. Only the eigenvalue matrix changes. Four things drop out of that one fact:

| Choose | Get |
|---|---|
| `Λ` from diffusion | Exploration that spreads outward one step at a time |
| A bespoke diagonal `ϒ` | Turbulent / super-diffusive sampling — **Lévy flights**, the pattern animals use foraging and the pattern seen in hippocampal replay |
| `ϒ = Σ_n γⁿ Λⁿ` | The SR exactly, hence a distance — and with distances, planning is "go to the neighbour closest to the goal". **All you need are the start and goal grid codes** ("intuitive planning") |
| Action-dependent `T_a` (same eigenvectors, different complex eigenvalues) | Path integration = successively *adding eigenvalues*; the eigenvectors are plane waves, exactly the VCO substrate, and the transition matrix is the CANN weight matrix |

So the last row unifies three model families the wiki was carrying as alternatives (predictive maps, oscillator interference, continuous attractors) into one spectral statement — and it makes replay statistics a *design parameter* (`ϒ`) rather than a phenomenon.

**(brainstorm)** The exportable engineering claim is that a single learned basis can serve exploration, planning, replay sampling and position updating, with a per-use diagonal reweighting as the only thing that varies. That is a very cheap form of the "one representation, many downstream tasks" property the wiki keeps asking architectures for — and it is testable: fit one basis, then check whether four behaviours differ only in a diagonal.

---

## The temporal symmetry of the write rule selects *which* transition matrix gets stored

Keck et al. 2025 make the local write rule's sensitivity to temporal order an explicit parameter and derive what each setting stores. One rule, two coefficients:

```
ΔW = α (p_post(t+1) − W p_pre(t)) p_pre(t)ᵀ  +  β (p_post(t) − W p_pre(t+1)) p_pre(t+1)ᵀ
```

The first term is the standard predictive/decorrelative rule (Hebbian outer product minus the synapse's own predicted input); the second is the same rule run on the time-reversed pair. `α = β` makes the update invariant under reversing the order of pre/post activity. At convergence the network encodes the SR **of a mixed transition matrix**:

`P_{α,β} = (α/(α+β)) P_forward + (β/(α+β)) P_backward` ·  `S = Σ_k γᵏ (P_{α,β})ᵏ`

| `(α, β)` | Stored object | Property |
|---|---|---|
| `(1, 0)` | Classical SR under the behavioural policy | Policy-dependent (the break point above) |
| `(0, 1)` | **Predecessor representation** | Postdictive; proposed for exploration |
| `(½, ½)` | SR under the **time-reversible** symmetrization `½(P_f + P_b)` | Policy-*insensitive*: a clockwise and an anticlockwise walk on a ring give the same matrix |
| `α = −β` | — | Unstable; no convergence (stability requires `\|α\| > \|β\|`) |

So a continuum, not two mechanisms: `α = 1/(1+s), β = s/(1+s)` sweeps predecessor↔successor, and generalisation improved monotonically in `s`. Results survive per-transition heterogeneous `α, β` and per-timestep noise on them — the bias does not require the rule to be exactly symmetric anywhere.

**Why symmetrization repairs policy dependence.** `P_{½,½}` is provably closer to the *uniform*-policy transition matrix than the observed `P` is, and the uniform-policy SR is closely related to shortest-path distance. That is the property re-goaling needs: in a reversible state space the optimal policy to *any* target is a function of the metric alone. Empirically (tabular TD agent, SR frozen after the goal moves, only the reward vector `r` relearned) the symmetric agent reaches new targets in fewer steps than the classical one — in open grids and in mazes whose corridors were blocked between train and test. Controls: the effect persists when the symmetric SR is learned from the *asymmetric* agent's own trajectories and when update norms are matched, so it is the representation and not the exploration that carries it.

| | Classical SR (Stachenfeld et al. 2017) | **Symmetrized SR** (Keck et al. 2025) | Default representation / linear RL |
|---|---|---|---|
| Whose policy | Current | Current, pulled toward uniform | A *default* policy, stored separately |
| Needs an exploration phase | No | **No** — the map is acquired while solving the current task | Yes, in effect: the default must be learned |
| Re-goaling | Poor | Better (symmetric spaces) | Good, under linear-RL assumptions |

This is the wiki's cheapest answer to gap G28: the correction to policy contamination is **one coefficient in a local plasticity rule**, not a second stored representation.

**The bias is an assumption, and it is falsifiable in the same experiment.** On a directed graph (tree with one-way returns from leaves to the root, `d(s,s′) ≠ d(s′,s)`) the ordering *reverses* — the classical asymmetric rule generalises better. Symmetry of the write rule is an inductive bias asserting symmetry of the state space; it pays where the world is metric and costs where it is not. The symmetric agent also has higher policy entropy while learning the first target (the source of its slower, higher-variance acquisition) and is more sensitive to small learning rates.

**Two synapses, two rules (the anatomical claim).** A two-population rate model — `p₁` recurrent (CA3), `p₂` feedforward-only (CA1) — trained with the same rule at both sites learns successor features of each population's *own* input: `p₁ = (1−γ₁)SF_{ϕ₁}`, `p₂ = (1−γ₂)SF_{ϕ₂}`, with CA1's predictions conditioned on CA3's already-predictive output. The `γᵢ` in the dynamics `ṗ = −p + σ(γ W p + (1−γ)ϕ)` *are* the SR discounts, and are read as an encoding/retrieval gain (low `γ`: externally driven, learn; high `γ`: recurrently driven, retrieve) — acetylcholine is the proposed controller. Setting CA3 symmetric and CA1 asymmetric reproduces the recorded dissociation in backward place-field shift on a linear track: CA1 fields drift opposite the direction of travel, CA3 fields much less (Dong, Madar & Sheffield 2021). The mechanism is direct — a field shifts toward its predecessors only if the policy is directional, and symmetrization removes directionality — and it fails to appear if CA3 is given the asymmetric rule. Both rules present at once would give the brain a **predictive and a geometric map of the same space, side by side** ([[wiki/empirical-tensions.md]] T43 records the environment-dependence this account does not cover).

**(brainstorm)** Read as an engineering primitive this is a *symmetry dial on a replay/plasticity kernel*, and it generalises past navigation: whenever a domain's relations are known to be invertible (kinship, spatial layout, physical rearrangement) symmetrize the write rule and get metric structure for free; where they are not (causation, syntax, time, one-way state machines) leave it asymmetric. That makes G12's routing question answerable by a cheap online test — compare `P_f` and `P_b` empirically and set `β` to their agreement, per-edge if necessary, since the paper shows heterogeneous per-transition coefficients still work.

---

## Limits

- **Policy dependence** (above), only partly repaired by the DR (whose optimality holds under linear-RL assumptions) and partly by symmetrizing the write rule (Keck et al. 2025) — which moves `P` toward uniform without ever reaching it, and inverts into a *cost* on non-reversible state spaces.
- **Precision.** The paper's own footnote: it is unclear whether hippocampal neurons could represent the vanishingly small SR differences between sometimes-adjacent states that accurate reward-guided behaviour requires. A quantity that is mathematically a distance may not be a *readable* distance in spikes ([[wiki/empirical-tensions.md]] T29).
- **It presupposes the state space.** `T` is over states someone already supplied. SR is a *representation* choice made after [[wiki/concepts/latent-graph-discovery.md]]'s discovery problem is solved — which is also the opening: any model that builds a de-aliased state space ([[wiki/entities/cscg.md]], [[wiki/entities/tolman-eichenbaum-machine.md]]) can be fed to it.
- **No generalisation across environments.** `S` is per-graph; nothing carries to a structurally similar world.

---

## Connections

- **[[wiki/concepts/simulation-based-planning.md]]** — the cached-computation end of the planning spectrum: `v = Sr` replaces rollout with a matrix product, and the eigen-argument turns replanning under a moved reward into a re-read rather than a search.
- **[[wiki/concepts/path-integration.md]]** — the same machinery in a different basis: action-dependent transition matrices share eigenvectors and differ only in eigenvalues, so integrating a path is adding eigenvalues.
- **[[wiki/concepts/abstract-structural-codes.md]]** — a second, spectral derivation of grid-like codes: eigenvectors of a diffusion process over the state graph, with no periodicity assumed and no action algebra required.
- **[[wiki/concepts/cognitive-map.md]]** — supplies the "predictive map" reading of place fields: a place cell is a row of `S`, which explains policy-dependent field skewing and barrier deformation that a pure position code cannot.
- **[[wiki/concepts/amortized-inference.md]]** — the clearest worked example of compiling model-based computation into a cached object: half the Bellman computation stored ahead of time, with the failure mode (obstacle insertion) showing exactly what caching costs.
- **[[wiki/entities/cscg.md]]** — supplies the state space this page assumes: learn a de-aliased discrete graph first, then run the SR over its clone states.
- **[[wiki/concepts/complementary-learning-systems.md]]** — replay sampling statistics are the `ϒ` knob of this page's eigen-decomposition, which makes "what gets replayed" a design parameter rather than an unexplained phenomenon.
- **[[wiki/concepts/compositionality.md]]** — the DR variant is the wiki's one case of representations that compose *at the level of cell types*: grid × border to represent a barrier, without retraining either.
- **[[wiki/concepts/offline-replay.md]]** — where the `ϒ` reweighting earns its keep: replay serves five jobs with five incompatible sampling policies, and one eigenbasis under different diagonal reweightings is the only unification currently available.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — the proposed content of that model's unspecified feature vector: if the hippocampal input is a predictive-map state feature, then map selection should be sensitive to changed *transition* structure even when sensory input is identical — a stated, untested prediction.
- **[[wiki/entities/temporal-context-model.md]]** — the backward-looking twin: retrieved temporal context builds a distance-like inner product out of *past* co-occurrence rather than discounted future occupancy, so it recovers a graph metric with no policy, no reward and no prediction objective.
- **[[wiki/concepts/objective-identifiability.md]]** — the derivation that survives the emergence critique differently: eigenvectors of a transition operator need no hand-chosen centre–surround readout, but they are a *population*-level claim, which is the only level that page says a task-trained model may legitimately predict.
- **[[wiki/concepts/distributed-reference-frames.md]]** — supplies the cheapest explanation for why grid-like codes turn up in areas with no entorhinal circuitry: any area running this page's spectral decomposition over its *own* transition statistics gets them, so replication needs no shared circuit motif (Chen et al. 2022).
- **[[wiki/concepts/synaptic-plasticity.md]]** — supplies the write rule whose temporal-symmetry coefficients `α, β` decide which transition matrix this page's `S` is built from, and receives back the rare case of a local rule whose fixed point is a *named* computational object.
- **[[wiki/concepts/offline-replay.md]]** — a second route to the same symmetrization: applying the classical asymmetric rule to forward *and* reverse replayed trajectories in equal proportion yields the reversible SR, making the forward/reverse replay ratio a control on how policy-contaminated the stored map is (Keck et al. 2025).
- **[[wiki/concepts/representation-probing.md]]** — supplies this page's cheapest empirical test and takes back a target: regress a representational similarity matrix on the parameter-free matrix exponential `e^A` of the task graph, which asks for a *traffic-weighted* rather than topological metric and so discriminates a predictive map from a plain adjacency reconstruction (Garvert et al. 2017).
- **[[wiki/concepts/latent-graph-discovery.md]]** — the measured biological graph estimate is this page's object, not the topology: what a human reads out of an implicitly learned object graph is a symmetric, non-Euclidean weighted sum over paths, so discovery in the brain terminates in a predictive metric rather than an edge set.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the recurrent layer's read-out `p₁ = SF_{ϕ₁}(ϕ̃₁)` on a novel input is pattern completion with a predictive component: the attractor returns not the stored pattern but its discounted future.
- **[[wiki/concepts/manifold-constrained-learning.md]]** — biological support for this page's central division of labour: within-session learning in M1 rewrites which intent evokes which population activity pattern while leaving the repertoire of patterns intact, which is the `M`-changes-while-features-are-fixed regime, and it comes with a measured cost — performance recovers only partially, because a re-associated lookup cannot reach behaviours its fixed pattern set does not contain (Golub et al. 2018).
- **[[wiki/concepts/control-unity-and-diversity.md]]** — nominates this page's representation as the third control mode between goal-directed and habitual, and gives the arbitration an individual-differences anchor: a measured compulsivity factor tracks a bias toward model-free responding on the two-stage task, so the arbitration weight is a trait-level quantity, not just a task parameter (Friedman & Robbins 2021).
- **[[wiki/entities/spacetime-attractor.md]]** — the failure this page's time-marginalisation implies, made into a task: because `S` is a time-averaged occupancy it cannot say *when* the agent is where, so an SR agent fails to intercept a goal that moves within a trial while a network holding one copy of the state space per future timestep succeeds — a straight memory-for-flexibility trade (Jensen et al. 2026).
