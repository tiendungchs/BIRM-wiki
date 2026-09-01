# Continual-Dreamer

**A world model *is* the continual learner: keep the replay buffer across tasks, make the buffer's admission rule reservoir sampling, and take exploration from the model's own prediction disagreement — no task boundary, no task index, no weight penalty.** Kessler, Ostaszewski, Bortkiewicz, Żarski, Wołczyk, Parker-Holder, Roberts & Miłoś 2023, 2nd Conference on Lifelong Learning Agents (CoLLAs). Source: `raw/kessler-2023-world-models-continual-rl.md`.

Continual-Dreamer is not a new architecture. It is DreamerV2 with two substitutions — FIFO → reservoir sampling in the replay buffer, and the per-task exploration schedule → Plan2Explore latent disagreement — and its value to the wiki is that it turns three things the wiki has been arguing about into measured quantities: **which replay-selection rule actually works** (uniform coverage, not reward and not surprise), **what a task oracle is worth** (negative), and **where the stability–plasticity trade-off lives when nothing is protected** (in the buffer's size, as a single readable scalar).

---

## Why a world model is already a continual learner

Four properties of the Dreamer family, none added for this paper:

| Property of DreamerV2 | What it supplies for free |
|---|---|
| Trained by reconstructing state/action/reward trajectories **sampled from a replay buffer** | The buffer persists across tasks, so rehearsal is the default rather than a bolt-on |
| The policy is trained **inside** the model, on imagined rollouts from a frozen RSSM | Generative rehearsal: the policy sees earlier environments through the model, not through stored frames — and the agent is sample-efficient because the trial-and-error is offloaded to imagination |
| Nothing in the loss or the architecture reads a task identifier | Task-agnostic by construction — no head selection, no boundary detector |
| Rollout uncertainty is computable from a deep ensemble over next latents | An intrinsic reward that adapts to a task change *without being told one happened* |

The fourth is the load-bearing one. **Every prior continual-RL exploration strategy needs the boundary**: EWC-style DQN agents reset an `ε`-greedy schedule per task, SAC-based ones re-tune an entropy regulariser per task. Latent disagreement has no schedule to reset — novelty rises when the environment changes because the model's predictions get worse, which is the same event.

```
r = α_i · r_i + α_e · r_e          α_i = α_e = 0.9 (grid-searched over {0.1, 0.5, 0.9})
r_e = extrinsic reward predicted by the world model
r_i = variance of an ensemble of networks predicting the next RSSM features [z_{t+1}, h_{t+1}]
      (world model frozen while the ensemble trains)
```

---

## The selective-replay study — the paper's real payload

Two decisions, studied separately: **what gets into the buffer** and **what gets into the mini-batch**.

| Method | Where it acts | Rule | Result on 4-task Minihack |
|---|---|---|---|
| **FIFO** (DreamerV2 default) | admission | drop oldest | Early-task episodes are gone by 4M steps; forgetting of both Room tasks |
| **Reservoir sampling** (`rs`) | admission | store with probability `min(n/t, 1)`, `t` = trajectories seen, `n` = buffer size | **Best.** Robustly mitigates forgetting; retains the most uniform task distribution. This *is* Continual-Dreamer |
| **Coverage maximization** (`cm`) | admission | embed trajectories with a fixed convolutional LSTM, priority = median `L²` distance to 1000 stored trajectories | Less forgetting than FIFO, but **inconsistent on performance** (up with DreamerV2, down with +Plan2Explore), and it retains *fewer* intermediate-task samples because their embeddings resemble task 0's |
| **Uncertainty sampling** (`us`) | mini-batch | sample episodes ∝ their Plan2Explore intrinsic reward (the "surprise"/TD-error analogue), computed once at insertion | **Worst — performs like Impala**: low performance, low forward transfer, high forgetting |
| **Reward sampling** (`rwd`) | mini-batch | sample episodes ∝ environment reward | **No improvement over uniform random sampling** |
| **50:50** | mini-batch | half uniform from the buffer, half from a triangular distribution favouring recent experience (the CLEAR on-/off-policy ratio) | Inconsistent: on Continual-Dreamer it raises forgetting at constant performance (better learning of hard tasks); on Continual-Dreamer + Plan2Explore both get worse. On 8 tasks it helps both |

**The ranking is the finding, and it inverts the single-task result.** The same criterion family — sample in proportion to the model's own surprise — is worth ~2× learning speed and 41/49 games on single-task Atari (Schaul et al. 2016, [[wiki/concepts/replay-prioritisation.md]]); here it is the worst rule tried. Three differences could carry the sign flip and none has been isolated: the objective (within-task efficiency vs. across-task retention), the statistic (TD error, refreshed on every replay, vs. ensemble disagreement computed **once at insertion** and never updated), and the bias correction (annealed importance-sampling weights vs. none). Filed as [[wiki/empirical-tensions.md]] T299. Prioritising by reward buys nothing and prioritising by the model's own uncertainty is actively harmful, while a rule whose only goal is *uniform coverage of everything seen* wins. This is a machine-side replication of what biological replay was independently observed to do ([[wiki/concepts/offline-replay.md]]: upsample the under-visited, suppress the salient-but-idiosyncratic), and it is direct evidence against the position that licensed prioritised experience replay ([[wiki/empirical-tensions.md]] T30).

**Reservoir sampling is uniform over *episodes*, not over transitions — and that leaks.** Whole episodes are stored. A mastered task produces short episodes (straight to the goal); a new task produces long ones (up to the 100-transition cutoff). Admitting one new episode therefore evicts several old ones, so earlier tasks are systematically under-represented even under a correct reservoir rule. **(brainstorm)** The fix nobody ran is to reservoir-sample at transition granularity, or to weight the eviction by episode length; the wiki should not read "reservoir sampling solves admission" as more than "reservoir sampling solves admission for equal-length items".

---

## Results

**3-task Minigrid** (DoorKey-9x9, SimpleCrossing-S1N9, LavaCrossing-9x9; 0.75M interactions each; 2M buffer; 20 seeds):

| | Avg. performance ↑ | Avg. forgetting ↓ | Avg. forward transfer ↑ |
|---|---|---|---|
| Impala | 0.00 | 0.00 | 0.00 |
| CLEAR | 0.03 | 0.01 | 0.03 |
| Impala ×10 (7.5M steps/task) | 0.16 | 0.06 | — |
| CLEAR ×10 | 0.64 | 0.00 | — |
| **DreamerV2** | **0.72** | **−0.11** | **0.49** |
| DreamerV2 + Plan2Explore | 0.46 | 0.05 | 0.43 |

Three readings. (i) **Sample efficiency**: CLEAR needs 10× the environment interactions to reach a lower score, because Dreamer's policy learns inside the model. (ii) **Negative forgetting**: DreamerV2 ends *better* on earlier tasks than it was when it left them. (iii) **The intrinsic reward costs 0.26 performance here** and gains it on the harder benchmark below — see the tension.

**8-task Minihack ablation** (5 seeds), which is also where the design recommendations come from:

| Plan2Explore | reconstruct `ô` only | `π_exp = π_eval` | Avg. performance ↑ | Avg. forgetting ↓ | Avg. forward transfer ↑ |
|---|---|---|---|---|---|
| – | – | – | 0.09 | 0.37 | 0.56 |
| ✔ | – | – | 0.28 | 0.13 | 0.11 |
| ✔ | ✔ | – | 0.39 | 0.19 | **0.87** |
| ✔ | ✔ | ✔ | 0.38 | 0.22 | 0.76 |

**Dropping the reward and discount reconstruction terms, keeping only observation reconstruction, is worth +0.11 average performance and 8× the forward transfer.** That is the decoder-weighting question of [[wiki/concepts/learned-world-models.md]] answered in the *opposite* direction from HarmonyDream's — here the fix is to delete two of the three reconstruction targets, not to rebalance them.

**Scaling and transfer.** On 8 Minihack tasks the Dreamer variants solve River-v0, River-Monster-v0 and HideNSeek-v0, which neither Impala nor CLEAR solves; CLEAR retains the earliest tasks better than any Dreamer variant and cannot learn the later ones. The stability–plasticity split appears here as a *split between methods*, not as a dial inside one. Single-task DreamerV2 solves River-Monster-v0 **less** often than the continual agent does, attributed to warm-starting from Room-Monster and River ([[wiki/empirical-tensions.md]] T195).

---

## The task oracle is worth less than nothing

The task-aware baseline is `L²` regularisation of the world model and actor–critic toward the previous task's optimal weights (the EWC family without the Fisher), with the scale grid-searched over `{10⁻⁴ … 100}`. It **underperforms every task-agnostic variant** on 4-task Minihack, attributed to rigidity: the first tasks' pull prevents learning the last two.

Read against [[wiki/concepts/continual-learning.md]]'s solution table, this is the sharpest available statement that the weight-protection family and the rehearsal family are not interchangeable when the task sequence is long and the later tasks are the hard ones — and that the supervision the protection family demands does not even pay for itself.

---

## Stability–plasticity as one readable scalar

The wiki's cleanest instance of the trade-off with a single knob (8-task Minihack, buffer size swept, 5 seeds):

| Buffer size ↑ | Avg. forgetting | Avg. performance | Forward transfer | Hard-exploration tasks |
|---|---|---|---|---|
| larger | **falls** | **rises** | **falls** | **not solved** |

And in the other direction (3-task Minigrid, buffer ∈ {10⁴, 10⁵, 10⁶, 2×10⁶}): at 10⁴ and 10⁵ every variant under-performs, and **DreamerV2 + Plan2Explore cannot learn at all** while plain DreamerV2 still can — the exploration bonus needs a buffer large enough to hold what it discovers. DoorKey-9x9 is solved by the +Plan2Explore agent only from 10⁶ upward.

**(brainstorm)** This is a continual learner whose capacity variable is *data* rather than *parameters*, and it is monotone in both directions — which makes it the one entry in the wiki's continual-learning table where an agent could plausibly *control its own* stability–plasticity setting online, by growing or shrinking a buffer, instead of having it fixed by a penalty coefficient at design time. Nobody has run that; the sweep is offline and per-configuration.

---

## Limitations the authors state

| Limitation | Evidence | Why it matters here |
|---|---|---|
| **Interference** — replay of past data *prevents* learning a new task when only the reward or goal changes | Minigrid FourRooms-v0, identical layout and start state, goal moved between the two tasks: across seeds **only one of the two tasks is ever solved**, with one seed oscillating | Reservoir sampling addresses forgetting, not interference. The failure is exactly the re-goaling problem (gap **G28**): a world model whose buffer encodes the old objective cannot be given a new one |
| **Task imbalance** | 0.4M steps of Room-Random then 2.4M of River-Narrow with a 0.4M buffer: `rs` saturates with the longer task and forgets the first as badly as FIFO; `cm` retains a few first-task samples, not enough | The admission rule is uniform over *arriving* trajectories, not over tasks. `cm`-type distance criteria are named as the promising direction and are not developed |
| Continuous control untested | Only Minigrid and Minihack — discrete, image-based, sparse-reward grid worlds | The ContinualWorld / robot-manipulation regime is future work |

---

## Comparison

| | **Continual-Dreamer** | CLEAR | EWC / `L²` | [[wiki/entities/cn-dpm.md]] |
|---|---|---|---|---|
| Family | rehearsal, over a *world model's* buffer | rehearsal, model-free actor–critic with V-trace | weight protection | expansion |
| Task identity needed | no | no | **yes** | no |
| What is carried forward | raw episodes, uniformly covered | raw episodes | an importance estimate over parameters | a whole expert per regime |
| Exploration | latent disagreement, boundary-free | `ε`/entropy schedule per task | `ε` schedule per task | n/a (supervised) |
| Where the residual error sits | **interference** (new goal, old buffer) and task imbalance | plasticity — cannot learn the hard later tasks | rigidity — the first tasks dominate | **retrieval** — the gate is 48.18% / 31.14% right |
| Sample cost | 1× | 10× for a lower score | 1× | n/a |

**The Continual-Dreamer / CN-DPM pair is the useful one.** Both are task-agnostic, and their failures are disjoint: the expansion learner shares nothing, so it forgets nothing and loses everything at the gate that picks a component; the world model shares everything, so it has no gate to fail and loses instead to interference between objectives inside one shared model. **(brainstorm)** That is the same trade in the two extreme positions — the wiki has no system between them, i.e. one that shares a world model across tasks *and* keeps an addressable partition of the objective, which is what would close both failure modes at once.

---

- **`T284` — does a world model's own predictive uncertainty help or hurt across a task sequence?** This page holds both halves of the answer from one architecture: latent disagreement works as an exploration bonus and fails as a replay priority. The cheapest hypothesis that fits both is that an exploration bonus is *consumed* by acting on it while a replay priority is not, which nothing here tests.

## Connections

- **[[wiki/concepts/continual-learning.md]]** — the rehearsal row instantiated in reinforcement learning with the selection rule specified and the task-aware alternative measured *and beaten*: `L²` protection with a grid-searched coefficient underperforms plain reservoir replay, so the supervision the weight-protection family requires does not pay for itself over a long task sequence.
- **[[wiki/concepts/offline-replay.md]]** — the machine-side test of that page's central claim: uniform coverage of everything seen beats prioritisation by reward (no gain) and by the model's own uncertainty (worse than the non-continual baseline), which is biology's "upsample the under-visited, suppress the salient" arriving from a completely different direction.
- **[[wiki/concepts/learned-world-models.md]]** — a seventh role for the object: the model *as the continual-learning mechanism*, since its training buffer is the rehearsal store and its imagination is generative replay — and a decoder-weighting result that cuts against HarmonyDream's, since deleting the reward and discount reconstruction terms outperforms keeping them.
- **[[wiki/concepts/epistemic-value.md]]** — the one exploration signal in the continual-RL literature that needs no task boundary, because model disagreement rises when the environment changes without anyone announcing it; and the sharpest available demonstration that the *same* uncertainty quantity is useful as an action bonus and harmful as a replay priority.
- **[[wiki/entities/cn-dpm.md]]** — the opposite extreme of the same task-agnostic problem: share nothing and pay at retrieval, versus share everything and pay in interference between objectives.
- **[[wiki/concepts/simulation-based-planning.md]]** — the rollout here is not a search at decision time but a *training-data generator*: policy gradients are taken entirely inside imagination, which is why the agent needs 1/10 the environment interactions of a model-free rehearsal baseline.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the buffer/model pair read as fast store and slow learner, with the admission rule playing the role the biological replay filter plays, and the measured cost of getting that filter wrong.
- **[[wiki/concepts/reward-prediction-error.md]]** — the negative result that matters for prioritisation: sampling replay in proportion to reward is indistinguishable from sampling uniformly, so reward magnitude carries no usable information about what should be rehearsed.
- **[[wiki/entities/v-jepa-2.md]]** — the same world-model-for-control question with the continual axis removed; Continual-Dreamer supplies the axis and shows that on it, sample efficiency and forward transfer come from training the policy *inside* the model rather than from the prediction space.
- **[[wiki/entities/dqn.md]]** — the ancestor of this system's buffer, and the reason its replay-selection study is a correction rather than an extension: DQN's buffer is uniform over a FIFO window and was motivated by gradient decorrelation, so no prior claim was ever made about *which* transitions matter.
- **[[wiki/concepts/replay-prioritisation.md]]** — the single-task result this page's buffer sweep contradicts, and the paper that proposed the *admission*-side prioritisation this page actually ran, expecting error-shaped admission to win where reservoir sampling does (T299).
- **[[wiki/entities/elastic-weight-consolidation.md]]** — the weight-protection method this page's `L²` baseline stands in for, in its actual form: per-parameter Fisher stiffness rather than a uniform coefficient, with an inferred rather than given task boundary. The two results are compatible and the boundary is not what separates them — what this page shows is that under a persistent replay buffer, protection is not where the win is.

- **[[wiki/entities/world-models-vmc.md]]** — the ancestor of the move this page is built on: train the policy inside the model's own sampled rollouts and deploy it outside. It also carries the control this page does not — an explicit sampling temperature blunting the exploitation of model error — which the RSSM lineage replaced with a stochastic latent and stopped tuning.
