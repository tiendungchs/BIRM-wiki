# Hindsight Goal Relabelling

**A failed trajectory is a successful trajectory for a different goal. Store every transition twice — once under the goal that was pursued, once under a goal the episode actually achieved — and a binary terminal reward becomes dense, with no shaping, no demonstration and no schedule. The curriculum is manufactured out of the agent's own failures.** Primary source: Andrychowicz, Wolski, Ray, Schneider, Fong, Welinder, McGrew, Tobin, Abbeel & Zaremba 2017, *Hindsight Experience Replay*, NeurIPS 30 (`raw/andrychowicz-2017-hindsight-experience-replay.md`).

> **Provenance.** Converted from PDF via `pymupdf4llm` (`LOSSY`). Algorithm 1, the reward definitions, the strategy definitions and every number below are legible in the conversion and internally consistent; the Bellman equation and one figure caption are mangled by column interleaving and are restated here from surrounding prose. An ar5iv cross-check was attempted and the mirror returned no body text.

---

## The setting: a goal is a predicate, not a reward function

| Object | Definition | What it costs the designer |
|---|---|---|
| Goal space `G` | Set of goals; each `g ∈ G` has a predicate `f_g : S → {0,1}` | Choose what *aspect* of a state a goal constrains |
| Reward | `r(s,a,g) = −[f_g(s′) = 0]` — `−1` every step the goal is unmet, `s′` the post-action state | Nothing: no shaping, no weighting of terms |
| **State→goal map** | `m : S → G` with `f_{m(s)}(s) = 1 ∀s` — *every* state names a goal it satisfies | The one non-trivial assumption; `m = id` when `G = S` |
| Policy / critic | Universal value function approximators (Schaul et al. 2015): `π(s‖g)`, `Q(s,a,g)`, `‖` = concatenation | One extra input block |

Manipulation instance: `G = ℝ³`, `f_g(s) = [|g − s_object| ≤ ε]`, `m(s) = s_object`. Bit-flipping instance: `S = G = {0,1}ⁿ`, `f_g(s) = [s = g]`, `r_g(s,a) = −[s ≠ g]`.

## The algorithm

```
for each episode with pursued goal g, rollout s₀ … s_T using π_b(s_t ‖ g):
    for t = 0 … T−1:
        store (s_t‖g, a_t, r(s_t,a_t,g), s_{t+1}‖g)              # ordinary replay
        G' := S(s₀ … s_T)                                         # relabelling strategy
        for g' ∈ G':
            store (s_t‖g', a_t, r(s_t,a_t,g'), s_{t+1}‖g')        # HER: reward RECOMPUTED, not stored
```

**Two structural facts make it legal.** (i) The goal conditions the *policy* and never the environment dynamics, so a trajectory is valid data under any goal — the correction is off-policy in the goal argument as well as the action argument, and therefore needs an off-policy learner (DQN, DDPG, NAF, SDQN). (ii) The reward is *recomputable* from `(s,a,g)` at replay time, so relabelling costs one function call and no extra environment interaction.

## Relabelling strategies

| `S` | Relabel with | Result |
|---|---|---|
| `final` | `m(s_T)`, the goal achieved at the episode's end | Solves pushing and pick-and-place ~perfectly at any `k`; sliding not |
| `future` | `k` random states from the *same episode observed after* the transition | **Best everywhere**; `k = 4`–`8`; the only strategy that nearly solves sliding |
| `episode` | `k` random states from the same episode (any time) | Matches `final` on two tasks, fails sliding |
| `random` | `k` random states from the whole training history | **The one strategy that fails** — worst on all three tasks |
| — | `k > 8` | Degrades: the fraction of *un*relabelled data in the buffer gets too low |

The ordering is the finding: relabelled goals must be **reachable from the transition being relabelled**, and the nearer in the future the better. A goal sampled from the global history is an arbitrary goal, and arbitrary goals carry no gradient. `k` is a mixing ratio, not a data-augmentation factor — the ordinary-replay fraction is load-bearing.

## What was measured

| Experiment | Result |
|---|---|
| Bit-flipping, DQN | Without HER: solved only for `n ≤ 13`. With HER: `n` up to **50**. Exploration bonuses (VIME, count-based, bootstrapped DQN) do **not** help — the problem is not state diversity, it is that `2ⁿ` states cannot be enumerated |
| 3 Fetch-arm tasks (pushing, sliding, pick-and-place), MuJoCo, DDPG, binary reward | DDPG alone: **0** on all three. DDPG + count-based exploration: partial progress on sliding only. DDPG + HER: all three ~perfectly. DQN without HER: 0 |
| **Single**-goal version of the same three tasks (goal identical every episode) | DDPG+HER ≫ DDPG; and HER learns *faster in the multi-goal setting than in the single-goal setting it was being evaluated on* — train on many goals even when one is wanted (`T366`) |
| Shaped reward `r = λ\|g − s_object\|^p − \|g − s′_object\|^p`, `λ ∈ {0,1}`, `p ∈ {1,2}`, plus rescaling/clipping/gripper terms | **Neither DDPG nor DDPG+HER solves any task under any shaped variant.** Sparse binary beats every shaped reward tried |
| Sim-to-real transfer, pick-and-place, no finetuning, box position from a CNN on head-camera images | 2/5 trials; retrained with `σ = 1 cm` Gaussian observation noise → **5/5** (critic trained on exact observations — it is not deployed) |

**Why the shaped rewards lost**, per the authors: (i) the optimised quantity and the success condition diverge (distance integral vs. "inside `ε` at the end"); (ii) a shaped penalty punishes *inappropriate* behaviour, and an agent that cannot yet manipulate precisely learns to **stop touching the object at all** — observed. The shaping term suppresses exactly the exploration the sparse reward leaves free.

---

## Why this matters for a reasoning model

- **It is the baseline any claim about invented intermediate goals must beat** (`G33`). HER invents no subgoals at all: it changes the *label* on data already collected. It nonetheless delivers what subgoal decomposition is usually sold for — a dense learning signal under a terminal-only reward — at the cost of one line in the replay loop. Any decomposition mechanism should be run against a HER-relabelled flat learner with the same interaction budget before its hierarchy is credited.
- **It is an *implicit* curriculum, and it is the wiki's only self-paced one derived from failure rather than from competence** ([[wiki/concepts/curriculum-learning.md]]): the relabelled goal distribution starts at whatever a random policy reaches and moves outward as the policy improves, with no control over the initial-state distribution and no easiness measure. It violates Bengio's monotonicity conditions (the goal distribution's support moves, it does not nest) — another entry in that page's pattern that the effective schedules fall outside the definition.
- **What it does *not* supply is the objective** (`G72`). `f_g` and `m` are given. HER manufactures a goal *distribution* from a goal *space* the designer parameterised, and its own failure case is exactly the one where that parameterisation is wrong: `random` relabelling — goals drawn without regard to reachability from the current transition — is worse than nothing. So "generate your own goals" is cheap; "generate goals that are reachable-but-not-yet-reached" is the whole content, and here it is bought by *sampling from the agent's own future*, which is a reachability oracle obtained for free from the trajectory.
- **(brainstorm) `future` relabelling is local graph annotation** ([[wiki/concepts/latent-graph-discovery.md]]). Every `(s_t, g' = m(s_{t+k}))` pair is a measured edge "from this state, `k` steps to that one, under these actions" — a sample of the environment's reachability relation written into a value function rather than into a graph. It is the same object a successor representation estimates and the same object the diffusion-based option families eigendecompose ([[wiki/concepts/eigenoption-discovery.md]]), collected with no model and no bonus. The reason `random` fails is that it writes edges that do not exist.
- **(brainstorm) The recomputable-reward requirement is the real interface constraint.** HER needs `r(s,a,g)` evaluable offline for *counterfactual* goals. Any architecture that wants to reuse experience under re-labelled objectives — a configurator changing the cost module, an agent re-inferring a non-stationary objective — needs the same property: **the cost function must be a queryable module, not a channel the environment emits.** This is a concrete, cheap design rule the wiki can apply to G72's non-stationary-objective designs.
- **The sparse-beats-shaped result is a warning about the wiki's own cost modules.** Hand-designed intermediate costs did not merely underperform here — they produced a qualitatively wrong behaviour (avoidance), and did so for both learners. Where a terminal predicate is available and relabelling is possible, shaping is the intervention to try *last*.

## Open problems

- **`m` is a projection chosen by the designer.** `m(s) = s_object` discards the arm entirely; a different `m` defines a different goal space and therefore a different curriculum. Nothing infers `m`, and the paper does not study sensitivity to it.
- **Goals must be states.** Everything relabellable is a configuration the agent has physically occupied; a goal that is a *relation*, a *rule*, or a state the body cannot enter is outside `G` by construction.
- **No termination or achievement detection beyond `f_g`.** The predicate is an oracle with a hand-set tolerance `ε` (7 cm / 20 cm at evaluation).
- **Orthogonal to prioritisation and untested against it jointly** — the authors note it composes with prioritised replay ([[wiki/concepts/replay-prioritisation.md]]) and do not run the combination; relabelled transitions change the `|δ|` distribution, which is the statistic that page's rule reads.
- **Pick-and-place needed a demonstration state** (half the episodes started from a single recorded grasped state), later found unnecessary if the goal is sometimes on the table and sometimes in the air — i.e. the manufactured curriculum was insufficient until the *goal sampler* was widened, which is the designer choice this page says nothing infers.

---

## Connections

- **[[wiki/concepts/curriculum-learning.md]]** — the implicit, self-paced, failure-driven curriculum that page lists as missing: `Q_λ` is a distribution over *goals* rather than examples, `λ` is the competence of the current policy, no oracle easiness measure is needed, and the schedule violates both of Bengio's monotonicity conditions while delivering the largest effect of its family (0 → solved).
- **[[wiki/concepts/replay-prioritisation.md]]** — the other first-class knob on the same buffer, and the orthogonal one: prioritisation changes *which* stored transitions are sampled, relabelling changes *what a stored transition is an example of* — one reweights `P(i)`, the other rewrites the tuple, and the authors state they compose without running it.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the flat alternative to option discovery: HER gets a dense signal under a terminal-only reward with no `⟨I, π_o, β⟩`, no bottleneck statistic and no library, which is the baseline every discovery family on that page owes a comparison to (`G33`).
- **[[wiki/concepts/eigenoption-discovery.md]]** — the same reachability structure harvested two ways: eigenpurposes diagonalise the transition Laplacian to *derive* intrinsic goals, HER samples goals from the agent's own realised futures — spectral-global versus trajectory-local estimates of "what is reachable from here", with the latter needing no graph, no eigendecomposition and no option count.
- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — a competence-based mechanism with the typology's reward slot left empty: goals are self-generated and scored by achievement exactly as that family specifies, but there is no competence-progress term — the motivational content is carried entirely by the *sampler* (`future` over the agent's own trajectory), which is a design that typology has no cell for.
- **[[wiki/concepts/latent-graph-discovery.md]]** — relabelled transitions are sampled edges of the environment's reachability relation, written into a goal-conditioned value function instead of a graph; the `random`-strategy failure is what it costs to write edges that were never traversed.
- **[[wiki/entities/dqn.md]]** — one of the two off-policy learners HER is demonstrated on, and the demonstration that the buffer is the lever: same network, same loss, same interaction budget, with only the goal field of the stored tuple rewritten, takes bit-flipping from `n ≤ 13` to `n = 50`.
- **[[wiki/entities/irene.md]]** — the opposite sign on the same design question: HER finds training on many goals faster than training on the one goal that is wanted, IRENE finds adding a third training task destroys a capability the previous two conferred (`T366`).
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — a second exponential-scale sample-complexity result produced by the schedule rather than the model class, and one that costs no extra environment interaction at all — so a sparse-reward failure has two scheduling explanations to rule out before it is called representational.
- **[[wiki/entities/v-jepa-2.md]]** — the same three-task manipulation regime approached from the model side, and the contrast that prices this page: V-JEPA 2-AC plans to hand-chosen *goal images* with no achievement detector and horizon 1, where HER needs an explicit predicate `f_g` and a state→goal map but then generates its entire goal curriculum itself.
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — the other way to get gradient between sparse rewards, and the pair brackets the design space: relabelling manufactures intermediate signal *offline and label-side* by rewriting the goal on stored transitions, a pseudo-reward error emits it *online and critic-side* against a second value function — so one needs a replay buffer and a state→goal map, the other needs a subgoal and a second value table, and neither needs the other.
- **[[wiki/concepts/learning-progress.md]]** — the same self-paced curriculum reached without any progress signal at all: there the ordering comes from a competence estimate and its derivative, here from the reachability of relabelled goals, and no experiment compares the two — which matters because only the progress term has been shown to reject a region with no learnable structure in it (Ten et al. 2021).
- **[[wiki/concepts/conditioned-reinforcement.md]]** — the other way to manufacture intermediate reward, and the contrast that makes `G125` sharp: a relabelled goal's reward is recomputed from a designer-given predicate and is unaffected by how often it is claimed, where a conditioned reinforcer is a Pavlovian association that devalues itself on every delivery the primary reward does not back.
- **[[wiki/concepts/token-reinforcement.md]]** — the contrast on redemption and withdrawal: a relabelled goal's reward is credited the instant the predicate holds and can never be taken back, where a token is held as a balance the policy can see, spent on its own schedule, and removed as a conditioned punisher whose suppression exceeds the reinforcement-density change it causes (Raiff et al. 2008).
