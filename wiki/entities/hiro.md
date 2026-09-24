# HIRO (HIerarchical Reinforcement learning with Off-policy correction) — Subgoals Stated in Raw State Coordinates, and an Upper Level That Rewrites Its Own Past Instructions

**Two off-policy TD3 (Twin Delayed Deep Deterministic policy gradient) learners on two clocks. Every `c = 10` steps the upper level emits a goal `g_t ∈ ℝ^{d_s}`, a *desired displacement in the raw observation*. The lower level is paid `−‖s_t + g_t − s_{t+1}‖₂` for producing it and never sees the environment reward. Old upper-level transitions go stale as the lower level learns, so the upper level **relabels each stored instruction with the goal the *current* lower level would most plausibly have been following to produce the recorded actions**. No subgoal vocabulary, no pretraining, no hand-built detector.**

> **Provenance.** Nachum, Gu, Lee & Levine 2018, *Data-Efficient Hierarchical Reinforcement Learning*, NeurIPS 2018 / arXiv:1805.08296 (`raw/nachum-2018-data-efficient-hierarchical-reinforcement-learning.md`, ar5iv clip; Figure 4 learning curves are not legible in the clip, so the ablation outcomes below are the text's verbal reports). Four MuJoCo ant tasks, 10 seeds, 10M-step budget, comparison against re-implemented FuN (FeUdal Networks) components, SNN4HRL (Stochastic Neural Networks for Hierarchical Reinforcement Learning), VIME (Variational Information Maximizing Exploration) and option-critic. Everything below is from that source unless marked.

---

## Architecture

| Component | Spec | Note |
|---|---|---|
| **Upper level** `μ^hi` | Samples `g_t ∼ μ^hi(s_t)` when `t ≡ 0 (mod c)`, `c = 10` | Trained on the **environment reward** only: transition `(s_t, g̃_t, Σ R_{t:t+c−1}, s_{t+c})`, reward scale 0.1 |
| **Goal format** | `g_t` = desired *relative* change in the positional observations (torso `x,y,z`, orientation, all limb angles) | No goal subspace chosen by hand; ranges are hand-scaled (±10 for `x,y`, ±0.5 for `z`, ±1 for orientation, limb ranges from the robot file) |
| **Goal transition** `h` | `g_{t+1} = h(s_t, g_t, s_{t+1}) = s_t + g_t − s_{t+1}` | Re-expresses the fixed *absolute* target `s_t + g_t` relative to the current state, every step, between upper-level decisions |
| **Lower level** `μ^lo` | `a_t ∼ μ^lo(s_t, g_t)`; goal concatenated to the full state | Trained on the **intrinsic reward only**: `r_t = −‖s_t + g_t − s_{t+1}‖₂`. It never sees `R` |
| **Learners** | Two TD3 instances, (300,300) layers, separate replay buffers (2·10⁵ each), no gradient between levels | Lower trains every step, upper every 10 steps; both `γ = 0.99` |
| **Off-policy correction** | Relabel `g_t → g̃_t = argmax log μ^lo(a_{t:t+c−1} ∣ s_{t:t+c−1}, g̃_{t:t+c−1})`, intermediate `g̃` rolled forward by `h` | Under Gaussian exploration, `log μ^lo ∝ −½ Σ ‖a_i − μ^lo(s_i, g̃_i)‖²`. Argmax over **10 candidates**: the original `g_t`, the achieved `s_{t+c} − s_t`, and 8 Gaussian draws around the achieved one |

**The correction, stated as a question:** *for which instruction would the current lower level have taken the actions actually recorded?* Answering it turns an upper-level transition collected under a past lower level into a valid transition for the present one, which is what makes the upper level trainable off-policy at all.

### Off-policy correction variants (appendix)

| Variant | Rule | Outcome |
|---|---|---|
| **Direct importance weighting** | `w_t = Π_i μ^lo(a_i∣s_i,g_i) / μ^lo_β(a_i∣s_i,g_i)` on the target | Unbiased, variance too high in continuous action; does not work |
| **Importance-based relabelling** (used) | Pick `g̃_t` making `w_t ≈ 1` | Biased (an exact `g̃` need not exist), low variance |
| **Model-based relabelling** | Assume the lower level completes goals: `p^hi(s̃_{t+c}∣s_t,g_t) = N(s_t + g_t, Σ)` | Resembles FuN's transition policy gradient; did not beat the used variant |

---

## Results

Best policy within 10M steps, mean ± standard error over 10 seeds. Gather = reward (apples − bombs); others = success rate (within L2 distance 5 of target at the last step).

| | Ant Gather | Ant Maze | Ant Push | Ant Fall |
|---|---|---|---|---|
| **HIRO** | **3.02 ± 1.49** | **0.99 ± 0.01** | **0.92 ± 0.04** | **0.66 ± 0.07** |
| FuN learned-representation goals | 0.03 | 0.0 | 0.0 | 0.0 |
| FuN transition policy gradient | 0.41 | 0.0 | 0.56 ± 0.39 | 0.01 |
| FuN cosine-similarity reward | 0.85 ± 1.17 | 0.16 ± 0.33 | 0.06 ± 0.17 | 0.07 ± 0.22 |
| FuN (all three) | 0.01 | 0.0 | 0.0 | 0.0 |
| SNN4HRL (25M pretrain + 15M) | 1.92 ± 0.52 | 0.0 | 0.02 | 0.0 |
| VIME (15M) | 1.42 ± 0.90 | 0.0 | 0.02 | 0.0 |
| Option-critic (continuous variants) | no reasonable performance, omitted | | | |

**Tasks.** Maze: ⊃-shaped corridor. Push: the greedy move pushes a block into the path, so the ant must go left and then push the block right. Fall: the ant must push a block into a chasm and walk across it. **Reward in the navigation tasks is dense**: `−‖(x,y) − target‖` every step, so the difficulty is *deception* (greedy approach blocks the route), not sparsity.

### Ablations (verbal, from the text)

| Arm | Outcome | What it isolates |
|---|---|---|
| **No HRL** (flat TD3, same budget) | "almost no progress" on all tasks | Hierarchy vs. same learner flat, **at matched interaction budget** |
| **No off-policy correction** (stale upper transitions used as-is) | Does "quite well" on the easier tasks; clearly worse on Push and Fall | The value of the correction grows with task depth |
| **Pretrain lower 2M steps on Gaussian-random goals, then freeze** | **Detrimental on Maze/Push/Fall**; **better than HIRO on Gather** | Severance vs. simultaneous training *on one architecture*. Authors' reading: navigation needs stage-specific lower-level specialisation as new regions are reached; homogeneous Gather does not |
| **Lower-level goal relabelling** with *randomly sampled* goals (HER-style) | Initial speed-up, then early plateau | Hypothesis: the lower level must then learn almost every goal, not only the ones the upper level issues |
| **FuN learned representation** (2-layer embedding, goals and reward in it) | ~0 everywhere | Raw-state goals give the lower level a usable reward *before* the upper level or the task reward carries any information |

---

## Limitations

| Limitation | Consequence |
|---|---|
| **Low-dimensional, fully observed state** | Raw-state goals are cheap only because `s` is joint angles and positions. The paper does not say what `g` would be over pixels. The FuN dilated LSTM was dropped as irrelevant here, so the comparison is not against FuN's own regime |
| **Goal space is the *positional* subset with hand-scaled ranges** | "No manual design" still means the designer picked positions over velocities and set per-dimension ranges from the robot file. A designer choice of `m : S → G`, as in HER |
| **Fixed `c = 10`, no termination** | The upper level re-decides on a clock. No learned commitment, no interruption, no granularity learning |
| **Two levels only** | Deeper stacks untested; the formalism is stated for two |
| **Lower level sees full `s_t` plus `g_t`** | Bypass (`G59`) is architecturally available. Here the lower level has no `R` to bypass *toward*, so concealment does the work that denial of `s` would |
| **Baselines re-implemented, not native** | No official FuN code existed; the "FuN" rows are HIRO with one component swapped. SNN4HRL and VIME run with official code but on-policy TRPO (Trust Region Policy Optimization), so the off-policy vs. on-policy gap and the hierarchy gap are confounded in those rows |
| **No relabelled-flat or archive control** | The flat arm is plain TD3, not TD3 with hindsight relabelling, and no archive-and-return baseline is run (`T402`; the tasks are also dense-reward, outside that row's scope) |
| **Correction is approximate** | 10-candidate argmax; the pretrained-lower arm's win on Gather is read by the authors as evidence the correction is "still not perfect" |

---

## Comparison

| | **HIRO** | [[wiki/entities/feudal-networks.md]] | [[wiki/entities/h-dqn.md]] | [[wiki/entities/option-critic.md]] | [[wiki/entities/diayn.md]] |
|---|---|---|---|---|---|
| Subgoal | displacement in **raw** state | unit direction in a **learned** latent | detected object | none | discriminator region |
| Lower-level reward | `−‖s + g − s′‖₂` (graded, distance) | cosine to `g` + `αR` | binary "reached" | `R` only | `log q(z∣s) − log p(z)` |
| Lower level sees `R`? | **no** | yes, gain `α` | no | yes (only reward) | no (disjoint phases) |
| Upper-level training | off-policy TD3 + **instruction relabelling** | on-policy A3C, transition policy gradient | off-policy DQN, no correction | on-policy option gradients | on-policy, frozen skills |
| Commitment | clock, `c = 10` | re-emitted every step, pooled over `c` | goal predicate or episode end | learned `β` | clock, `k` |
| Schedule | simultaneous; severance arm run and **loses** on navigation | simultaneous | random-goal pretrain → joint (unablated) | simultaneous | severance only |
| Matched-budget flat control | **yes** (TD3) | yes (A3C-LSTM) | no (cited) | DQN (cited) | — |

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| `g_t` | A **node named by coordinates**: the target vertex is `s_t + g_t`, in the observation space itself, so there is no node-definition step ([[wiki/concepts/node-definition-problem.md]]) — the observation space *is* the vertex set |
| `h` | Keeps the target vertex fixed while the agent moves: an allocentric target carried in an egocentric code |
| Lower level | Learns the edge family "from here, reach the vertex at offset `g` within `c` steps", which is a goal-conditioned local reachability model |
| Off-policy correction | Re-annotates a stored coarse edge `(s_t → s_{t+c})` with the label the *current* edge-follower would assign it. The coarse graph's edge labels are kept consistent with a changing low-level policy |

---

## Brainstorm

**(brainstorm)** HIRO's correction and HER relabel opposite ends of the same tuple. HER rewrites the *lower level's goal* to what was achieved, so the executor learns from its failures. HIRO rewrites the *upper level's action* to what the current executor would have been told, so the instructor's memory stays valid as the executor changes. A hierarchy with both has two relabellers pointing at each other. The paper runs HER-style relabelling only with *random* goals, the one strategy HER itself shows fails, so the `future`-strategy combination remains unrun.

**(brainstorm)** The correction is an **inverse model of the lower level**, used as a memory-maintenance operation. It is the machine form of "what was I trying to do when I did that?" asked of one's own past behaviour, answered by the current skill set. A brain-inspired analogue is replay that re-labels stored episodes with the task-set the current policy would have inferred. That would put intention inference ([[wiki/entities/hbtom.md]]'s inverse planning) inside the agent, aimed at itself. No source in the wiki builds it.

**(brainstorm)** The severance arm's split result (loses on navigation, wins on homogeneous Gather) gives a rule a builder can use: **freeze the lower level only when the upper level's goal distribution is stationary over training.** Navigation moves the frontier, so the goals issued late are unlike those issued early, and a frozen executor is trained on the wrong distribution. This is the stale-library failure of [[wiki/concepts/temporal-abstraction-options.md]] measured as a schedule effect.

---

## Connections

- **[[wiki/entities/feudal-networks.md]]** — the design HIRO dismantles component by component on its own tasks: learned-representation goals score ~0 on all four, cosine reward and the transition policy gradient each lose to raw-state displacement with L2 distance. This conflicts with FuN's own ablation, where directional goals beat absolute ones on Atari (`T406`).
- **[[wiki/entities/h-dqn.md]]** — the same two-reward, two-learner, disjoint-replay arrangement with the designer-given object vocabulary replaced by the raw state space. HIRO ablates the pretrain-then-freeze schedule h-DQN left unablated, and pretraining loses on the tasks that need stage-specific skills.
- **[[wiki/entities/option-critic.md]]** — the failed baseline: every continuous-action variant tried gave no reasonable performance, and the authors attribute it to intra-option policies learning from the external reward alone. That is evidence that the lower level needs a reward of its own, the opposite end of `T367` from option-critic.
- **[[wiki/concepts/hindsight-goal-relabelling.md]]** — the relabelling trick moved up one level: HER rewrites the lower level's goal to what was reached, HIRO rewrites the upper level's instruction to what the current executor would have followed. HIRO's lower-level HER variant used *random* goals, the strategy HER itself shows fails, and plateaued.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — a goal-state family with no discovery step: the subgoal set is the observation space, the upper level selects from it every 10 steps, and the ablations price two things that page names: stale lower-level skills (the pretrain arm) and non-stationarity of the level above.
- **[[wiki/entities/diayn.md]]** — the severance schedule, tested: DIAYN freezes a pretrained skill library by design, HIRO's pretrain-and-freeze arm is that schedule on the same architecture as its simultaneous arm, and it loses on the navigation tasks.
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — a graded pseudo-reward `−‖s + g − s′‖` against a machine-set subgoal, delivered from the first step, to a learner that never sees primary reward, so the `r̃` : `r` ratio has no referent (the two rewards never meet in one learner).
- **[[wiki/entities/go-explore.md]]** — the unrun control: both store states and return to them, HIRO by instructing a learned executor, Go-Explore by restoring or following an archived trajectory; HIRO's tasks are dense-reward and neither is run on the other's benchmark (`T402`).
- **[[wiki/entities/hac.md]]** — the rival repair for the same stale-upper-replay problem, developed at the same time: HIRO relabels an instruction for the *current* executor by action likelihood, HAC overwrites it with the state reached (one of HIRO's ten candidates) as if the executor were optimal, and restores feasibility with noise-free subgoal tests penalised `−H`. HAC 2-level beats HIRO on three HAC tasks, confounded by HAC's added HER at both levels (Levy et al. 2019).
