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

## Limits

- **Policy dependence** (above), only partly repaired by the DR, and DR's optimality holds under linear-RL assumptions.
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
