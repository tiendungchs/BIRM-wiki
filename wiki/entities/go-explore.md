# Go-Explore — Remember the State, Return to It, Then Explore

**A family of exploration algorithms whose entire content is three steps: keep an *archive* of states already reached, *return* to an archived state without exploring on the way, and only then act randomly. No hierarchy, no options, no subgoal discovery, no intrinsic reward term added to the return — and it is the first system to score above human on all 55 Atari games in OpenAI Gym, to beat the human world record on Montezuma's Revenge, and to take Pitfall from the field's standing `0`.** Primary source: Ecoffet, Huizinga, Lehman, Stanley & Clune 2021, *First return, then explore*, Nature 590:580–586, doi:10.1038/s41586-020-03157-9 (`raw/ecoffet-2021-first-return-then-explore.md`).

---

## The two named failure modes

The paper's claim is that hard exploration has been misdiagnosed. What blocks exploration is not a shortage of exploratory pressure but two properties of how that pressure is applied:

| Failure | Definition | Cause |
|---|---|---|
| **Detachment** | The algorithm stops returning to a region it has evidence is promising | A policy-carried frontier is *overwritten*. Partially explore region A, switch to region B, and the route back to A's frontier is gone — the frontier lives in weights that moved |
| **Derailment** | The exploratory mechanism prevents reaching the state it wants to explore from | Exploration is mixed *into* the return. A long correct prefix is required; high `ε` destroys the prefix, low `ε` destroys the exploration. There is no setting that does both |

Both are consequences of one design decision the field treats as unremarkable: **exploration and returning are the same process**. Go-Explore's whole architecture is the separation of the two, and its performance is the price that conflation was costing.

## Architecture

| Component | Instantiation | Free choice it hides |
|---|---|---|
| **Archive** | One entry per *cell*; entry = one state + the best trajectory reaching it (higher-scoring or shorter wins) | Nothing is ever evicted; memory grows with discovered cells |
| **State→cell map `φ`** | Atari: downscale the 210×160 colour frame to a small greyscale image — *deliberate* conflation, the opposite of standard preprocessing. Width, height and grey-level count **re-optimised at intervals during the run**. Domain-knowledge variant: (level, room, `x`, `y`, items held) | The whole abstraction problem. Too fine = no generalisation of novelty; too coarse = no exploration |
| **Cell selection** | `W = 1/√(C_seen + 1)`, `C_seen` = number of exploration steps in which the cell was visited — the UCT (Upper Confidence bounds applied to Trees) / count-bonus form, used as a *sampling weight over memory* rather than as a reward | — |
| **Go** | Restore the simulator state directly (restorable-environment variant), or run a goal-conditioned policy (policy-based variant) | Restoration is an architectural exemption, see below |
| **Explore** | Uniform random actions for 100 steps (Atari) / 30 (robotics), with **95% action-repeat probability** | Action repeat is load-bearing and hand-set |
| **Robustify** | Learning from demonstrations over the agent's *own* archived trajectories (modified backward algorithm, 10 demonstrations, self-imitation learning), in a stochasticity-injected copy of the environment | Only needed because phase 1 returns an open-loop trajectory |

Domain-knowledge cell selection on Montezuma's Revenge adds a **frontier** statistic, not a bottleneck one: `W_location = (2 − h)/10 + k`, where `h` counts horizontal neighbours already in the archive and `k = 1` for the most-keys cell at a location; then `W_mont_domain = 0.1^{L−l}(W + W_location)`. A cell with *no* neighbours is where the search edge is. Affordance count (`k`, keys held) enters as a direct additive term.

## Results

| Setting | Result |
|---|---|
| Atari, 11 hard-exploration games, robustified, sticky actions | Superhuman and above state of the art on all 11 (Freeway tied at max). 30 billion frames |
| **Montezuma's Revenge**, domain-knowledge cells | Mean > **1,700,000** — 150× state of the art, above the human world record of 1,200,000 |
| **Pitfall** | Mean **102,571** against a state of the art of **0** (max possible 112,000) |
| All 55 Gym Atari games, exploration phase only | Superhuman trajectories on **all**; above state of the art on **85.5%**; above every planning algorithm evaluated on Atari |
| Robotics: 9-degree-of-freedom arm, object into 1 of 4 shelves, 2 behind latched doors, reward only at the target shelf | PPO: **zero rewards in 1 billion frames**. Go-Explore: reliably finds trajectories to all four shelves; robustification succeeds in **99%** of cases |
| **The control that matters**: count-based intrinsic motivation with the *same* domain-knowledge representation | Montezuma's Revenge **12,240** vs Go-Explore's 1.7M. Robotics: **zero** reward found, and a fraction of Go-Explore's cells after 100× the frames |
| Policy-based Go-Explore (no state restoration, stochastic throughout) | Montezuma's Revenge **97,728**, Pitfall **20,093** — both above state of the art and above average human |
| Policy exploration vs random actions in the explore step | The policy discovers **>4× more cells**, and its advantage *grows* over training — skills learned for returning generalise into exploring |

## Policy-based variant: how a goal-conditioned policy is made to reach a distant state

The archive is not handed to the policy as a target. It is handed as a **path**:

- Collapse the archived trajectory to non-repeated cells; condition the policy on successive cells along it.
- **Soft window** `N_w = 10`: reaching the current goal *or any of the next nine* counts, and the next goal is the one after the cell actually reached (after the last occurrence, if it repeats — cycle handling).
- Trajectory reward `r^τ = 1` per intermediate goal met, `3` at the final cell; environment reward clipped to `[−2, 2]` so in-game reward dominates path-following.
- Cell weight changes to `W = 1/(0.5·C_steps + 1)` — decays far faster than `1/√C_seen`, deliberately over-weighting recently discovered cells, because a new cell must be *learned to be reachable* before it is useful.
- Explore-step goals: 10% an adjacent cell **not** in the archive, 22.5% any adjacent cell, 67.5% an archive cell by the standard weight.
- **Dynamic entropy increase**, eq. 8: `e_t(t̂) = 1 + [max(0, t̂ − e^T_t)·e_f]^{e_p}` (`e_f = 0.01`, `e_p = 2`) divides the policy logits when the agent has gone `t̂` steps without reaching a goal or finding a new cell. The threshold `e^T_t` while returning is *the number of actions the archived trajectory needed for that leg* — so the stuck-detector is calibrated by a stored memory of how long this should take.

The entropy term is the one piece of machinery here with no counterpart elsewhere in the wiki: a **failure-triggered, memory-calibrated exploration gain**, distinct from any additive novelty bonus, that is released by the *absence* of expected progress rather than by the presence of novelty.

## Comparison

| | Selects intermediate targets? | Where the frontier lives | Needs a simulator? | Montezuma's Revenge |
|---|---|---|---|---|
| **Go-Explore** | Yes — but by *novelty over a designer-given cell map*, never by task structure | External non-parametric archive | Restorable variant yes; policy variant no | 1.7M / 97,728 |
| [[wiki/entities/dqn.md]] | No | Weights only | No | 0 |
| [[wiki/entities/neural-episodic-control.md]] | No | External store of *returns*, not of states to return to | No | 42.1 @ 10M frames |
| [[wiki/entities/feudal-networks.md]] | Yes — learned latent directions | Manager's policy (parametric) | No | ~2,600 |
| [[wiki/entities/option-critic.md]] | No — policies, not targets | Option parameters (parametric) | No | not reported |
| [[wiki/entities/diayn.md]] | Yes — discriminator regions, pre-task | Frozen skill set | No | not reported |
| Count-based intrinsic motivation, same cell map | No | Weights + counts | No | 12,240 |

---

## Why this matters for a reasoning model

- **It is the wiki's strongest null for `G33`.** Every family on that row — bottleneck partitioning, eigenoptions, grammar induction over demonstrations, option-critic terminations, feudal directions, DIAYN regions — is motivated by the claim that sparse long-horizon tasks require a *decomposition*. Go-Explore performs no decomposition of any kind and beats all of them on the canonical instance by two to three orders of magnitude. What it substitutes is memory plus the ability to re-enter a remembered state. Any decomposition claim now owes a comparison against an archive-and-return baseline at matched budget, and the wiki has none.
- **The 12,240-vs-1.7M control isolates *what* is doing the work.** Count-based intrinsic motivation was given the identical domain-knowledge representation and lost by 140×. So the gain is not the abstraction and not the novelty statistic — both are shared — it is that the novelty signal is consumed by a **selector over an external store** rather than by a gradient into a policy. The same quantity `1/√(N+1)` succeeds as a read-address and fails as a reward. This is the second instance in the wiki of a signal that works in one consumer and not another ([[wiki/concepts/replay-prioritisation.md]] reports the converse for `|δ|`), and it generalises into a design rule: *a frontier must be stored, not learned.*
- **Detachment is catastrophic forgetting of the frontier, and names a cost no continual-learning page prices.** [[wiki/concepts/continual-learning.md]] measures forgetting of *performance*; detachment is forgetting of *where I had got to*, which is unmeasured everywhere and is, on this evidence, the binding constraint in sparse-reward domains.
- **Derailment is the argument against mixing exploration into execution, stated as an architecture.** [[wiki/concepts/explore-exploit-division-of-labour.md]] proposes a *temporal* separation of exploring from exploiting across development; Go-Explore performs the same separation at the granularity of a single episode, and the reason is mechanical rather than ecological — a stochastic policy cannot reliably reproduce a long prefix, so any system whose plan is longer than its noise correlation must be able to execute open-loop.
- **The archive is a planning frontier, and the paper says so.** Cells are nodes, the explore step is node expansion, the selection weight is the priority function — Go-Explore is best-first search with a learned-by-nothing heuristic, ported into a domain where classical planners fail because the space is too large to prune and stochastic transitions make "fully expanded" undefined ([[wiki/concepts/simulation-based-planning.md]]).
- **Robustification is self-generated demonstration learning, and it closes a loop the wiki has been missing.** Phase 1 produces open-loop trajectories with no policy; phase 2 trains a closed-loop policy by learning from demonstrations where the demonstrator is the agent's own archive. A system that can search *without* a policy and then compile the search result *into* a policy has the same shape as the wake/sleep split of [[wiki/entities/dreamcoder.md]] and the consolidation channel of [[wiki/concepts/complementary-learning-systems.md]] — search in an episodic store, distil into a parametric one.
- **(brainstorm) The entropy-increase rule is a frustration signal with a stored set-point.** `e^T_t` = how many actions this leg took last time; exceed it and exploration gain rises superlinearly. This is a *comparator against episodic memory* driving a neuromodulatory-style gain, which is the arrangement [[wiki/concepts/neuromodulatory-metaparameters.md]] wants a source for and does not have. No source in the wiki measures an analogous biological signal, and the experiment is cheap: hold a familiar route, block it, and ask whether the exploration increase is scaled by the route's remembered length.

## Limitations

- **Restoration is an exemption, not a mechanism.** The headline Atari and robotics numbers assume the environment can be rewound. The paper's defence is that simulators are ubiquitous in reinforcement learning practice — true, and irrelevant to any claim about how an organism explores. The policy-based variant removes the exemption and costs roughly an order of magnitude of score on Montezuma's Revenge (1.7M → 97,728).
- **The cell map is the designer's, and it is the whole abstraction.** Downscaling parameters are searched, but *over the space of downscalings*; the domain-knowledge variant is hand-authored (room, `x`, `y`, keys) and worth 150× in score. Learning `φ` is listed as the first item of future work. This is the same unfilled slot as [[wiki/concepts/hindsight-goal-relabelling.md]]'s projection `m : S → G` and [[wiki/concepts/node-definition-problem.md]]'s vertex set, arrived at from a third direction.
- **Nothing infers the objective.** Go-Explore's exploration phase ignores reward entirely except for tie-breaking which trajectory is stored per cell; it discovers *everything reachable* and then reports the highest-scoring path found. This is coverage, not goal inference (`G72`) — it works because Atari and the shelf task pay off somewhere inside a reachable set small enough to exhaust.
- **30 billion frames.** The sample cost is at the ceiling of distributed reinforcement learning, and the archive grows monotonically.
- **No nesting, no reuse across tasks.** The archive is per-environment and per-run; nothing is abstracted out of it. Contrast [[wiki/entities/hisd.md]], whose entire output is a reusable library.
- **Stochastic rewards, and stochasticity during the restorable exploration phase, are untested** (the authors' own list).

## Open problems

- Learn `φ` — compression, contrastive-predictive coding, auxiliary tasks are the authors' three candidates. Whether a learned cell map preserves the property that makes the archive work (novelty under `φ` correlating with *reachability-frontier-ness*) is untested.
- Learn the cell-selection weight, and learn which cells to aim at in the explore step. Both are currently fixed formulas.
- A continuous density-based archive instead of discrete cells — which would make the abstraction a resolution parameter rather than a partition, and connects the row to [[wiki/concepts/node-definition-problem.md]]'s hard-vs-soft axis.
- Robustification from a single demonstration; use of *all* transitions rather than one trajectory per cell.
- Whether the "remember, return, explore" decomposition survives when the environment is non-stationary — every archived trajectory is a cached plan, and nothing audits a cached plan for staleness.

## Connections

- **[[wiki/entities/dqn.md]]** — the null this page dethrones by changing one thing: DQN has every non-structural ingredient and scores 0 on Montezuma's Revenge, which the wiki has read as evidence that sparse long-horizon tasks need hierarchy or a model; Go-Explore adds neither and scores 1.7M, relocating the missing ingredient to an external frontier store (`T402`).
- **[[wiki/entities/neural-episodic-control.md]]** — the same bet on non-parametric memory with the contents swapped: NEC stores *returns* for states it happens to revisit and gets 42.1 on Montezuma's Revenge, Go-Explore stores *states and the routes to them* and gets 1.7M — so what an episodic store should hold for exploration is the address, not the value.
- **[[wiki/entities/feudal-networks.md]]** — the decomposition answer to the problem this page answers with memory, on the same game: FuN's learned latent directions produce interpretable waypoints and ~2,600 points; an archive with no waypoints, no levels and no intrinsic reward produces 1.7M, which prices what the hierarchy is actually buying on this benchmark (`G33`, `T402`).
- **[[wiki/entities/option-critic.md]]** — both architectures refuse to name intermediate targets, for opposite reasons: option-critic dissolves the subgoal into option policies learned from the return, Go-Explore externalises it into an archive keyed by novelty and never learns it at all, and only the second solves the sparse-reward games the option literature is motivated by.
- **[[wiki/entities/diayn.md]]** — the same "explore first, use later" schedule with the coverage objective swapped: DIAYN maximises state–skill mutual information and freezes a skill library, Go-Explore maximises raw cell coverage and freezes a trajectory archive; DIAYN's ant skills score below doing nothing while Go-Explore's archive contains the optimal path, because coverage over a *cell map* is anchored to the environment's states and coverage over a *latent index* is not.
- **[[wiki/concepts/hindsight-goal-relabelling.md]]** — the two cheapest non-hierarchical answers to sparse reward, with the same hole: HER manufactures dense signal by relabelling under a designer-given projection `m : S → G`, Go-Explore manufactures it by storing states under a designer-given cell map `φ`, and neither infers its own abstraction — the wiki's clearest sign that the missing piece is the state-to-target map rather than the goal generator.
- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — a measured dissociation this page's reward-formula format cannot express: `1/√(C_seen+1)` is the UM count bonus exactly, and with the representation held fixed it yields 12,240 as an additive reward and 1,700,000 as a selection weight over an external archive, so a curiosity formula's value depends on which module consumes it (Ecoffet et al. 2021).
- **[[wiki/concepts/simulation-based-planning.md]]** — Go-Explore is best-first search with the archive as frontier and the explore step as node expansion, ported to a space where classical planners fail (too large to prune, stochastic transitions leave "fully expanded" undefined); it therefore sits on the planning pole of that page's dichotomy while using no transition model whatsoever.
- **[[wiki/concepts/continual-learning.md]]** — detachment names a forgetting cost that page does not measure: not loss of performance on an old task but loss of the *address* of the frontier, which a parametric agent suffers silently and an archive cannot suffer at all.
- **[[wiki/concepts/explore-exploit-division-of-labour.md]]** — the same separation argued from mechanism rather than ecology: derailment says a stochastic exploration policy cannot reproduce a long correct prefix, so exploring and executing must be separated in *time* even within one episode, which is that page's developmental phase boundary rescaled to seconds.
- **[[wiki/concepts/node-definition-problem.md]]** — the vertex-set choice made in a reinforcement-learning setting and measured: the cell map is the parcellation, coarser cells swallow exploration targets and finer cells destroy novelty generalisation, and the one mitigation Go-Explore adds that connectomics lacks is **re-optimising the granularity during the run** against a legibility criterion.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the framing's extreme case: the archive *is* the discovered graph — cells as nodes, stored trajectories as edges — built by exhaustive coverage with no model, no inference and no abstraction beyond `φ`, which sets the floor any inference-based method must beat when the reachable set is small enough to exhaust.
- **[[wiki/concepts/replay-prioritisation.md]]** — the converse pairing: `|δ|` works as an action bonus and fails as a rehearsal priority, while `1/√(C+1)` fails as an action bonus and works as a memory-selection priority — two data points for the rule that an intrinsic quantity must be specified together with its consumer.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the two-phase structure in an engineered system: a fast non-parametric store searches and accumulates specific trajectories, then a slow parametric learner is trained from them offline in a noisier copy of the world, with the store acting as its own demonstrator — consolidation with the teacher removed.
