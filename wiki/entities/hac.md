# HAC (Hierarchical Actor-Critic) — Each Level Trained as if the Levels Below Were Already Optimal

**`k` stacked goal-conditioned DDPG (Deep Deterministic Policy Gradient) learners. Each level's action is an *absolute* target state for the level below, and each level gets `H` attempts to reach its own goal. Levels train simultaneously from sparse `−1/0` rewards using three kinds of transition. (i) Hindsight action: the instruction is overwritten with the state the lower levels actually reached, so the upper level learns as if its executor were perfect. (ii) Hindsight goal: HER (Hindsight Experience Replay) at every level. (iii) Subgoal testing: on a random 30% of instructions the lower levels run noise-free, and a miss is penalised `−H`, which restores the feasibility information that (i) removed. First agent in the wiki with three levels learned in parallel in continuous state and action.**

> **Provenance.** Levy, Konidaris, Platt & Saenko 2019, *Learning Multi-Level Hierarchies with Hindsight*, ICLR 2019 / arXiv:1712.00948 (`raw/levy-2019-learning-multi-level-hierarchies-with-hindsight.md`, ar5iv clip). **All learning curves (Figures 4–6) are images and are not legible in the clip; every result below is the text's verbal report, and no success rate is available as a number.** Grid worlds plus four MuJoCo tasks (inverted pendulum, UR5 reacher, ant reacher, ant four rooms), 1/2/3-level agents. Everything below is from that source unless marked.

---

## Architecture

| Component | Spec | Note |
|---|---|---|
| **Levels** | `π_0 … π_{k−1}`, `k` set by the user; each `π_i : S × S → A_i` is deterministic | `G_i = S` at every level; `A_i = S` for `i > 0`, `A_0` = primitive actions. The top goal is the task's |
| **Nesting** | `a_i` becomes `g_{i−1}`. Level `i−1` has at most **`H`** attempts. It stops early when **any** goal `g_n, n ≥ i−1`, is achieved | A higher level's goal interrupts every level below it. So lower levels are terminated by goals they are not conditioned on |
| **Reward, every level** | `0` if the reached state is in the goal, else `−1`. Discount `0` on achievement | The reward depends **only on the reached state and the goal**, never on the lower-level path (needed for the hindsight-action simulation to be valid) |
| **Critic bound** | `Q_i ∈ [−H, 0]` through a negative sigmoid | Each level values only its own `H`-step horizon. Hindsight-reached subgoals are guaranteed to outrank penalised ones |
| **Learners** | One DDPG per level, 3×64 ReLU layers, separate replay per level, **no target networks** for 2- and 3-level agents | No gradient crosses between levels |
| **Exploration** | 20% uniform random action from the level's action space, 80% policy + Gaussian noise | Suspended at all levels below a subgoal under test |
| **Horizon** | `H = 10` for 3-level MuJoCo; `H ∈ [20, 30]` for 2-level | Reach `H^k`: 1000 primitive steps at `k = 3`, 400–900 at `k = 2` |
| **Achievement thresholds** | Hand-crafted per task | The predicate `f_g` of [[wiki/concepts/hindsight-goal-relabelling.md]], designer-set at every level |

### The three transition types

| Type | Built from | Stored tuple (level `i`, instruction `a_i`, reached `s′`) | What it trains |
|---|---|---|---|
| **Hindsight action** | Every instruction | `[s, a = s′, r ∈ {−1, 0}, s′, g_i, γ]`: the instruction is replaced by the state reached | Level `i` against `T_{i∣Π*_{i−1}}`, a **stationary** transition function in which the lower hierarchy is optimal. Its data do not depend on the current or exploring lower policies |
| **Hindsight goal** | Copies of the above (and of level-0 primitive transitions) | Goal replaced by a state reached later in the same `H`-step sequence, reward recomputed | Guarantees at least one `r = 0` transition per sequence at every level (HER inside each level) |
| **Subgoal testing** | Fraction `λ = 0.3` of instructions | All lower levels follow their **current** policy with no noise. If `a_i` is missed: `[s, a_i, r = −H, s′, g_i, γ = 0]` | Whether the *current* lower hierarchy can reach `a_i`. The zero discount keeps this transition free of the non-stationarity problem |

**Effect of testing by case** (`|s − a|` = actions the optimal level-below needs):

| Case | Transitions received | Learned `Q` |
|---|---|---|
| `\|s − a\| > H` | Only penalties (never reachable, so never produced in hindsight) | `−H`: distant subgoals are no longer ignored |
| `\|s − a\| ≤ H`, current lower hierarchy reaches it | Hindsight transitions; testing succeeds | Hindsight target |
| `\|s − a\| ≤ H`, only the optimal hierarchy reaches it | Many hindsight transitions, few penalties | Weighted average, close to the hindsight target. The level still prefers subgoal paths the current executor can do |

**HierQ** (Hierarchical Q-Learning), the tabular variant, replaces testing with **pessimistic initialisation** `Q_i ≤ −H^{i+1}` and updates every goal in `S` after each primitive step.

---

## Results (verbal; curves not legible)

| Comparison | Report | Trials |
|---|---|---|
| 3-level vs 2-level vs flat, all tasks | **3 > 2 > flat in every task.** Flat = Q-learning + HER (discrete) or **DDPG + HER** (continuous), taking the better of with/without target networks | 50 (discrete), ≥ 7 (continuous); error bars ±1 SD |
| HAC 2-level vs HIRO | HAC "significantly outperformed" on inverted pendulum, UR5 reacher and ant reacher | Same as above |
| **Ablation: no subgoal testing** (3-level) | Significantly worse. Levels learn to propose unrealistic subgoals out of reach in `H` actions. Inspected `Q` values for them are *high*, because no transition says otherwise | — |
| **Ablation: penalise every miss, including under noisy lower levels** (3-level) | Significantly worse. Authors' reading: noise makes distant subgoals miss more often, so the level proposes overly **conservative** subgoals and has to learn longer subgoal sequences | — |

---

## Limitations

| Limitation | Consequence |
|---|---|
| **No numbers in the clip** | The size of the depth effect and of the HIRO gap cannot be carried into the wiki's tables. Only the orderings are recorded |
| **`H` differs across depths** (10 at `k = 3`, 20–30 at `k = 2`) | The 3-vs-2 comparison changes both the number of levels and the per-level horizon. Depth is not isolated |
| **`k`, `H`, `λ`, thresholds all user-set** | The number of levels and the granularity are not learned. The same unset integers as [[wiki/entities/feudal-networks.md]]'s `c` and [[wiki/entities/hiro.md]]'s `c` |
| **Goals are raw states, `G_i = S`** | Workable because `S` is joint angles and velocities. No pixel or partial-observation variant. Every level must be able to output a whole state vector |
| **HIRO comparison confounded** | HAC adds HER at both levels *and* changes the relabelling rule, and runs on its own sparse-reward tasks. HIRO's own tasks (dense, deceptive) are not run. The gap cannot be attributed to either change alone |
| **Budget matching not stated in the text** | Axes of the curves are not legible, so whether flat and hierarchical agents share an interaction budget is unverified here |
| **Ant tasks are reacher / four-rooms** | Sparse reward, but not the deceptive Push/Fall family. No archive-and-return control (`T402`) |
| **Lower levels see the full state** | Goal concatenated to `s` at every level: the standard `G59` violation |
| **Hindsight-action bias** | Assumes the optimal executor reaches exactly what the noisy executor reached. Correct only when the reward depends on the endpoint alone, which is why the reward is restricted to `−1/0`. A path cost (energy, time within `H`) would break it |
| **Three-level selection still without a world model** (`G33`) | First datum that more levels pay on top of relabelling (flat arm is DDPG + HER), but goals are raw states and nothing predicts them, so `G33`'s clause is failed on the same counts as HIRO |
| **The `−H` penalty is not an opponent term** (`G126`) | It suppresses *infeasible* subgoals (tested misses), never *unbacked* ones: it fires when the executor cannot reach the target, not when reaching it fails to pay |

---

## Comparison

| | **HAC** | [[wiki/entities/hiro.md]] | [[wiki/entities/h-dqn.md]] | [[wiki/entities/feudal-networks.md]] |
|---|---|---|---|---|
| Levels | **`k` (3 tested)**, in parallel | 2 | 2 | 2 |
| Subgoal | **absolute** raw state | raw-state **displacement** | detected object | direction in a learned latent |
| Lower-level reward | binary `−1/0`, thresholded | graded `−‖s + g − s′‖₂` | binary "reached" | cosine + `αR` |
| Upper-level relabelling | instruction ← **state reached** (optimal-executor assumption) | instruction ← argmax likelihood of recorded actions under the **current** executor (10 candidates, one of which is the reached displacement) | none | none (transition policy gradient) |
| Feasibility signal | subgoal testing, `−H`, `λ = 0.3` | implicit in the likelihood | none; meta-controller re-selects after failure | none |
| HER within levels | **every level**, goals drawn from states reached in the same `H`-attempt sequence | lower level only, `random` goals, plateaued | none | none |
| Lower level sees task reward? | no | no | no | yes, gain `α` |
| Commitment | `H` attempts, or any higher goal reached | clock `c = 10` | goal predicate or episode end | re-emitted every step |
| Flat control | **DDPG + HER** (relabelled) | TD3 (unrelabelled) | cited DQN | A3C (Asynchronous Advantage Actor-Critic)-LSTM |

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| Level `i` | A goal-conditioned reachability model at radius `H` in level-`(i−1)` steps. Stacking gives a **multiscale reachability graph** whose edge length grows as `H^i` |
| Hindsight action | Writes the edge actually traversed, `s → s′`, instead of the edge requested. Every stored coarse edge is real |
| Subgoal testing | Writes **non-edges**: `(s, a)` pairs the current executor cannot traverse in `H` get value `−H`. HER's `random` strategy fails because it writes edges that do not exist. Testing is the opposite repair: it labels the missing edges explicitly |
| Bounded `Q ∈ [−H, 0]` | Each level stores only local distances. Long-range structure exists only across levels, never inside one critic |

---

## Brainstorm

**(brainstorm)** HIRO and HAC answer one question in opposite ways: **which executor should the instructor's memory describe?** HIRO answers the current one. It rewrites the instruction to what the present executor would have been told, which keeps the memory exact but ties it to a moving target. HAC answers the optimal one: it rewrites the instruction to what was achieved. That is stationary and free, but optimistic, so HAC needs a second, sparse, honest channel (testing) to put the executor's actual limits back in. HIRO's candidate set already contains HAC's relabel as one of its ten candidates. So the difference is how the candidate is chosen, not whether it is available.

**(brainstorm)** Hindsight action is **effect-coded action**. The upper level stores "I caused `s′`", not "I asked for `a`". It is a machine form of representing an action by its outcome, and it removes the executor from the upper level's model entirely. Subgoal testing is then a **sampled self-audit**: on a fixed fraction of trials the system acts without exploration noise, to learn what it can actually do. A brain-inspired analogue would separate exploratory from committed execution, and would let only committed failures lower the value of a subgoal. The "penalise every miss" ablation measures what goes wrong otherwise: failures caused by the agent's own exploration noise get charged to the subgoal, and the agent becomes conservative.

**(brainstorm)** The two ablations bracket a calibration: with no testing, subgoals are over-ambitious; with testing on every noisy miss, they are over-cautious. `λ` and the noise-free condition set where the level's ambition sits between the two. That is a third-party parameter of the same kind as FuN's `α` and option-critic's `ξ`. None of the three is derived.

---

## Connections

- **[[wiki/entities/hiro.md]]** — the rival repair for the same non-stationarity, developed at the same time. HIRO relabels a stored instruction for the *current* executor by likelihood. HAC relabels it to the achieved state, i.e. for an *optimal* executor, and restores feasibility by testing. HAC 2-level beats HIRO on three tasks, confounded by HAC also adding HER at both levels. HAC also pairs within-trajectory HER with upper-level relabelling. HIRO's brainstorm lists that pairing as unrun, although HAC uses its own relabel rule rather than HIRO's correction.
- **[[wiki/concepts/hindsight-goal-relabelling.md]]** — HER applied twice per level. Once on the goal field at every level (hindsight goal), and once on the *action* field of every level above the bottom (hindsight action). The flat control is DDPG + HER, so this is the first hierarchy in the wiki credited against a relabelled flat learner.
- **[[wiki/entities/h-dqn.md]]** — the same binary achievement reward and goal-conditioned executor, with the designer object set replaced by the raw state and with relabelling added. h-DQN fixed sparsity structurally, with 2.3M steps of random-goal pretraining. HAC trains all levels from the start and fixes sparsity label-side.
- **[[wiki/entities/feudal-networks.md]]** — the opposite goal format on every axis: FuN uses a learned direction with cosine reward and continuous emission; HAC uses a raw absolute state with a thresholded binary reward and `H`-attempt commitment. FuN names deeper hierarchies as future work; HAC builds three levels (`T406`).
- **[[wiki/concepts/temporal-abstraction-options.md]]** — a goal-state option family with no discovery step, nested to three levels. Each option is "reach `g` within `H`", and termination is the goal predicate of *any* level above. That is the options framework's options-within-options, built with a fixed granularity `H` per level.
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — every level below the top is paid a binary pseudo-reward for a machine-set subgoal and never sees primary reward. The testing penalty `−H` is a second, negative pseudo-reward for proposing an unreachable subgoal, charged to the instructor rather than the executor.
- **[[wiki/entities/never-give-up.md]]** — the same UVFA (Universal Value Function Approximator) construction with a different conditioning input: HAC conditions each level on a target state, NGU conditions one network on an exploration weight `β_i`. In both, the input is set from outside (by the level above, or by a fixed per-actor rule), and nothing learns to choose it from the agent's own state (`G61`).
