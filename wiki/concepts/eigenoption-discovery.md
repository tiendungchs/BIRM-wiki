# Eigenoption Discovery

**Take the eigenvectors of the state-transition graph's Laplacian and read each one as an *intrinsic reward* — `rᵉ(s,s′) = eᵀ(φ(s′) − φ(s))`, positive for any step that climbs that eigenvector — and the optimal policy for it is an option. The environment's reward is never consulted, the subgoal is wherever the eigenvector peaks, and the eigenvalue index sets the option's timescale, so one eigendecomposition yields a whole graded option library instead of a single bottleneck set.**

> **Provenance.** Machado, Bellemare & Bowling 2017, *A Laplacian Framework for Option Discovery in Reinforcement Learning*, ICML 2017 / arXiv:1703.00956 (`raw/machado-2017-laplacian-framework-option-discovery.md`). Tabular experiments in three grid-worlds (10×10 open room, I-Maze, four-rooms) plus a sample-based run on three Atari 2600 games. Everything below is from that source unless marked.

---

## The construction

| Object | Definition | Note |
|---|---|---|
| **Proto-value function** (PVF) | Eigenvector `e` of the normalised graph Laplacian `L = D^{-1/2}(D − A)D^{-1/2}`, `A` the state-adjacency matrix, `D` its row-sum diagonal | Representation learning, Mahadevan & Maggioni 2007; task-independent by construction |
| **Eigenpurpose** | `rᵉᵢ(s,s′) = eᵀ(φ(s′) − φ(s))`; tabular case `= e[s′] − e[s]` | An intrinsic **reward function**, one per eigenvector. Both signs of `e` are used, giving two purposes per eigenvector |
| **Option MDP** | `Mᵉᵢ = ⟨S, A ∪ {⊥}, rᵉᵢ, p, γ⟩` — original dynamics, new reward, action set augmented with *terminate* `⊥` at zero cost | `γ` is free and is what sets the option's timescale |
| **Eigenbehavior** | `χᵉ(s) = argmax_a q*ᵉ(s,a)` — the optimal policy of `Mᵉᵢ` | Solved here by policy iteration; the intrinsic reward is **dense**, so this inner problem has no exploration difficulty |
| **Eigenoption** | `⟨I, π, T⟩` with `q(s,⊥) ≐ 0`, `T = {s : q^ᵉ_χ(s,a) ≤ 0 ∀a}`, `I = {s : ∃a, q^ᵉ_χ(s,a) > 0}` | Initiation and termination are *derived* from the value function, not designed. Options are defined over most of the state space, hence sequenceable |

**Termination is guaranteed** (Thm 3.1): for `γ < 1` and finite `S`, `T` is nonempty. Proof by writing `r = Tw − w` with `w = φ(s)ᵀe`, giving `‖v + w‖_∞ ≤ ‖w‖_∞`, so the argmax state of `w` must have `v ≤ 0`. Holds in the tabular *and* linear-function-approximation cases.

### Sample-based version (no adjacency matrix)

- Store each **new** transition as the row `φ(s′) − φ(s)` in an **incidence matrix** `T`; deduplicate by exact vector equality (a `set`).
- SVD `T = UΣVᵀ`; the columns of `V` are the eigenpurposes.
- **Thm 5.1:** with every transition sampled once and tabular `φ` (one-hot), `TᵀT = 2L`, so `V` holds exactly the Laplacian eigenvectors. The graph is never built.
- This is the step that generalises to **linear function approximation**: nothing in the algorithm needs enumerable states, only feature differences.
- Trade-off named: in sparsely connected MDPs (I-Maze) the incidence matrix is smaller than the adjacency matrix; in dense ones the reverse.

---

## What it buys, measured

| Claim | Measurement |
|---|---|
| Subgoals without reward | Eigenoptions in the open grid go to corners; in the I-Maze, down corridors; in four-rooms, to **room centres first** — the first option terminating at a doorway is the *fifth* |
| Exploration | **Diffusion time** (new metric: expected steps for a random walk to get between two randomly chosen states) drops well below primitive-only once enough options are added |
| Few options *hurt* | The first options added **increase** diffusion time — a uniformly random policy over options + primitives skews time toward the options' trajectories, and one long option can undo dozens of primitive steps |
| Bottleneck options hurt | A doorway-only option set raises four-rooms diffusion time above the primitive-only random walk; the agent shuttles between rooms and rarely reaches outer corners |
| Reward accrual | Q-learning (`α = 0.1`, `γ = 0.9`) with 64 eigenoptions (32 eigenvectors × 2 signs) in the behaviour policy learns fastest; performance "fairly robust" across option counts, and fails only when too few are used |
| Task-independence | The *same* 64 eigenoptions speed learning across different start/goal pairs in four-rooms; swapping start and goal changes nothing. Bottleneck options win only when the goal sits near a doorway |
| Not just "go somewhere" | **Random options** (policy to a uniformly chosen terminal state) raise diffusion time by *orders of magnitude* over 24 random orderings until the option graph is nearly complete, and no individual run's learning curve is competitive — so the gain is in the diffusion model, not in having temporally extended actions |
| Scales past tabular | Atari RAM (1,024 bits) as `φ`, 25,000-row incidence matrix, options executed **myopically** (`γ = 0`, one-step emulator look-ahead). Freeway: options with visibly different target lanes; **option #445 scores 28 points having never seen the game's reward**, near state-of-the-art for the time. Montezuma's Revenge: options targeting staircases, ropes and doors — close to the hand-designed set of Kulkarni et al. 2016 |

---

## Why this is the reward-free extreme of the subgoal problem

- **Top-down discovery** (the dominant family) starts from trajectories that already reached an informative reward and refines them. In a large sparse-reward MDP that is circular: if the reward is unreachable with primitives, it is equally unreachable with options derived from reaching it.
- **Bottom-up discovery** builds the option set *before* any informative reward is seen. Eigenoptions are the purest case: the only input is the set of observed transition *differences*.
- The eigenvalue ordering hands over a **timescale ladder for free** — PVFs are a frequency basis, so higher-frequency eigenpurposes give shorter options. In the 10×10 grid the fourth eigenoption terminates about twice as often as the second. Nothing else in the wiki's option-discovery families produces graded timescales without a separate mechanism.
- **(brainstorm)** The pairing with the wiki's other Laplacian page is exact and, as far as the source knows, unnoticed: [[wiki/concepts/anatomical-harmonic-modes.md]] takes eigenvectors of a Laplacian built from *anatomy* and uses them as a **basis for state**; this page takes eigenvectors of a Laplacian built from *transitions* and uses them as a **basis for purposes**. Same operator, two readings — a coordinate and a gradient to climb along it. An architecture holding one spectral decomposition could serve both, which would make "where do subgoals come from" a *read* of the representation rather than a second system.

---

## Limits the source states or implies

- **The eigenvector selection problem returns under approximation.** In the tabular case, take the smallest eigenvalues (smoothest). Under function approximation with an incomplete transition set that intuition is not known to hold, and the authors simply examined all 1,024 Atari options by hand and reported the good ones. **No criterion picks the option set automatically** — the number of options is explicitly called a model-selection problem.
- **Options are compiled from a fixed graph estimate.** No incrementality: the decomposition is not updated as the graph estimate changes, and the paper names "incremental discovery with incomplete graphs" as future work.
- **Atari options were run with `γ = 0` and emulator look-ahead** — a privileged one-step model, not a learned option policy. The function-approximation result is anecdotal by the authors' own word.
- **Deduplication by exact vector equality** is brittle for continuous or noisy features; the authors call the approach naïve.
- **Never hierarchical.** Options over options are listed as future work; one flat library is produced.
- **Eigenpurposes are defined over the feature difference,** so a representation that does not change when the agent does something important silently denies that direction an option — the option library inherits every blind spot of `φ`.
- **The library is produced but never *sequenced*.** One flat set is emitted with no ordering over it and nothing selecting which member to invoke for a given task — the reason `G33` stays `PARTIAL` on this source rather than closing: the decomposition is discovered, the subgoal *sequence* is not.
- **Exploration gets a learned inventory but not a learned rate.** Eigenoptions enter the behaviour policy as extra actions and measurably lower diffusion time, so *where* to explore is read off the representation; *how much* remains a Q-learning `ε` set outside the selector, which is exactly the half of `G61` an option library cannot reach.

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| Eigenpurpose | A direction in the graph's spectral embedding, promoted to a reward |
| Eigenbehavior | The policy that moves along that direction as fast as the graph allows |
| Subgoal | The eigenvector's extremum — a position in the *spectrum*, not in the topology; bottlenecks appear only if they happen to be extrema |
| Diffusion time | A direct measurement of how fast the graph can be *explored*, computable from the graph alone, with no task |

---

## Connections

- **[[wiki/concepts/temporal-abstraction-options.md]]** — the eighth option-discovery family on that page's table, and the only reward-free one that also grades options by timescale: every option is the optimal policy of an eigenvector-derived intrinsic reward, with the initiation and termination sets falling out of the sign of `q` rather than being designed.
- **[[wiki/concepts/optimal-hierarchy-criterion.md]]** — the direct empirical clash: Solway's evidence-maximising partition lands on topological bottlenecks, while this source measures bottleneck-only option sets *raising* random-walk diffusion time above primitives, with room-centre options discovered first (`T365`). The two are reconcilable only if planning efficiency and exploration efficiency select different inventories.
- **[[wiki/concepts/latent-graph-discovery.md]]** — closes the graph→subgoal arrow without a partitioner: a spectral decomposition of the estimated transition structure yields both the state basis and the option set, and the incidence-matrix form means the graph itself never has to be materialised.
- **[[wiki/concepts/successor-representation.md]]** — the same spectrum reached from the predictive side: the SR's eigenvectors and the Laplacian's PVFs are the eigenvectors of the same diffusion operator, so an agent that already maintains an SR holds the eigenpurposes implicitly and needs no second estimation step to obtain an option library.
- **[[wiki/concepts/anatomical-harmonic-modes.md]]** — the same operator used for the opposite job: there a Laplacian's low eigenvectors are a *basis to represent state in*, here they are *rewards to climb*, so one spectral decomposition could supply both a coordinate system and the goals expressed in it.
- **[[wiki/concepts/empowerment.md]]** — the rival reward-free option generator: empowerment scores states by control capacity and builds macro-actions from reachability, eigenoptions score *directions* by graph frequency; both need no reward, but empowerment's landscape can flatten or invert with its free parameters (`T363`) while the eigenvector ordering is fixed by the graph.
- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — a case the typology's three families do not cover: the intrinsic reward is neither knowledge-based (no uncertainty, no prediction error, no learning progress) nor competence-based (no goal, no achievement measure) nor morphological — it is a *representational* reward, a linear functional of the state-feature difference.
- **[[wiki/concepts/offline-replay.md]]** — where the recompute would be scheduled: the incidence matrix and its SVD are batch operations over stored transitions, so re-deriving the option library after the graph estimate shifts is offline work, which is the one mechanism that could supply the incrementality this source lacks.
- **[[wiki/entities/cscg.md]]** — the same graph, partitioned instead of diagonalised: InfoMap communities over a learned clone-structured transition matrix give a nested bottleneck hierarchy, eigenoptions give a flat graded-timescale library from the spectrum of that same matrix — and CSCG's de-aliasing is the prerequisite both share, since an aliased `φ` corrupts the incidence matrix exactly as it corrupts the adjacency matrix.
- **[[wiki/concepts/hindsight-goal-relabelling.md]]** — the same reachability structure harvested trajectory-locally instead of spectrally: eigenpurposes diagonalise the transition Laplacian to derive intrinsic goals, hindsight relabelling samples goals from states the agent actually reached `k` steps later — no graph, no eigendecomposition and no option count, but also no timescale ladder and no reuse of a goal across start states.
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — the same object from the opposite end: an eigenpurpose `rᵉ(s,s′) = eᵀ(φ(s′) − φ(s))` *is* a pseudo-reward derived from graph structure with the environment reward never consulted, and that page shows the brain emits the corresponding error — but the eigenpurpose is a per-step reward while the measured signal is a per-step error against `γ^{sd}`, and no source runs the pair together.
- **[[wiki/concepts/conditioned-reinforcement.md]]** — the rival origin for a subgoal's *value*: eigenpurposes derive it from graph structure with no reward consulted, conditioned reinforcement inherits it from the primary reward by pairing and therefore cannot exist before one has been met. The two bracket the design space, and only the second has a mechanism by which a subgoal's worth can fall (`G125`).
- **[[wiki/entities/option-critic.md]]** — the opposite pole of the discovery axis: eigenoptions never consult the reward and read options off the Laplacian, option-critic consults nothing but the reward and reads them off its own gradient — and where the eigenvalue index supplies a graded timescale ladder for free, option-critic's option length is set by whatever a `ξ` margin sustains against a termination gradient that would otherwise shrink every option to a primitive (Bacon, Harb & Precup 2017).
- **[[wiki/entities/diayn.md]]** — the other reward-free extreme, differing in what is scored and in what must be estimated: eigenpurposes are *directions* read off the transition Laplacian via an incidence matrix, DIAYN's skills are *regions* read off the agent's own occupancy via a discriminator, so DIAYN forms no matrix at all — and where the eigenvalue index hands this page a graded timescale ladder for free, every DIAYN skill lasts exactly one episode.
