# Near-Optimal Goal Representation — A Subgoal Space Learned by Action-Conditioned Contrastive Prediction, With a Bound on What It Costs in Return

**HIRO's two-level agent with the goal space learned, not given. A map `f : S → ℝ^d` defines the goal space; an auxiliary *inverse goal model* `φ(s, π)` names the goal that would reproduce the effect of a `c`-step behaviour `π`. The pair is trained so that `K(s′∣s,π) ∝ ρ(s′)·exp(−D(f(s′), φ(s,π)))` matches the true `c`-step state distribution. If it does, the best hierarchical policy using this goal space loses at most `Cε` return against the best hierarchical policy over *all* `c`-step behaviours. The criterion asks one thing: can every behaviour's **effect** be reproduced by some goal? Reconstruction and invertibility are not required. The objective is CPC-like (Contrastive Predictive Coding), conditioned on actions and scored by the same distance the lower level is paid with.**

> **Provenance.** Nachum, Gu, Lee & Levine 2019, *Near-Optimal Representation Learning for Hierarchical Reinforcement Learning*, ICLR 2019 / arXiv:1810.01257 (`raw/nachum-2019-near-optimal-representation-learning-hierarchical-rl.md`, ar5iv clip). **All learning-curve figures (3, 6, 7, 8, 10) are empty tables in the clip; every result below is the text's verbal report, and no success rate is available as a number.** Same authors and code base as [[wiki/entities/hiro.md]] (Nachum et al. 2018), so it is **not independent** of that page. Six MuJoCo tasks, 10 seeds, 10M steps. Everything below is from that source unless marked.

---

## Architecture

| Component | Spec | Note |
|---|---|---|
| **Representation** `f_θ : S → ℝ^d` | MLP, 2 × 100 ReLU; **`d = 2`** | The goal space. `d` is set by the designer to the dimension of the `x,y` oracle |
| **Inverse goal model** `φ_θ(s, π)` | MLP, 400/300; parameterised `φ(s,π) := f_θ(s) + φ_θ(s, a_{t:t+c−1})` | `π` is represented by the `c` actions actually taken, so in practice `Π = A^c` (open-loop). The theory holds for any `Π` |
| **Upper level** `π_hi` | HIRO's TD3 (Twin Delayed Deep Deterministic policy gradient) upper level, every `c` steps | Outputs a **displacement in representation space**, `g ∈ [−10, 10]²`; Gaussian exploration σ = 5 |
| **Lower level** `π_lo(a ∣ s_t, g, s_{t+k}, k)` | HIRO's TD3 lower level, reward below | Receives the **whole observation** (HIRO zeroed the `x,y` coordinates for its lower level: this source's report, not stated in the 2018 paper) |
| **Distance** `D` | Huber | The **same** `D` is used in the representation energy and in the lower-level reward. That is what ties the two objectives together |
| **Training** | `f`, `φ`, `π_hi`, `π_lo` all updated online from one replay buffer, concurrently | No pretraining stage. The behaviour policy is far from optimal while `f` is learned |

### The three objectives (`k ∈ [1, c]`, weights `w_k = 1` for `k < c`, `w_c = (1−γ)⁻¹`)

| Objective | Form | Reading |
|---|---|---|
| Sub-optimality | `SubOpt(Ψ) = sup_s V^{π*}(s) − V^{π*_hier}(s)` | `π*` picks any `c`-step behaviour; `π*_hier` is restricted to behaviours some goal `g` induces via `Ψ(s, g)` |
| **Representation** (Claim 4) | `Σ_k γ^{k−1} w_k · D_KL(P_π(s_{t+k}∣s_t) ‖ K(s_{t+k}∣s_t, π)) ≤ ε²/8` for all `s_t, π` ⟹ `SubOpt ≤ Cε`, `C = 2γ R_max w̄ / (1 − γ^c)` | **The goal space must be a dynamics model**: displacement in `f`-space predicted by `φ` must explain where behaviour actually goes |
| **Lower-level reward** | `−D(f(s_{t+k}), g) + log ρ(s_{t+k}) − log P_π(s_{t+k}∣s_t)` | The standard distance reward plus two terms. Approximated with the trained model as `−D(f(s′), g) + D(f(s′), φ(s_t, π)) + log E_{s̃∼ρ} exp(−D(f(s̃), φ(s_t, π)))` |

**Gradient in practice.** Attractive term `D(f(s_{t+k}), φ(s_t, a_{t:t+c−1}))` on the experienced future state. Repulsive term `exp(−D(f(s̃), φ) − stopgrad(L))` on replay-buffer negatives `s̃`, where `L` is the minibatch estimate of the log-partition. Negatives come from the replay distribution, so the prior `ρ` *is* the buffer.

### Theorem 1 (the single-step criterion, `c = 1`)

`∃ φ : S × A → G` with `sup_{s,a} D_TV(P(s′∣s,a) ‖ P(s′∣s, Ψ(s, φ(s,a)))) ≤ ε` ⟹ `SubOpt(Ψ) ≤ 2γR_max ε / (1−γ)²` (`D_TV` = total variation distance).

| Requirement | Strength | Status under the theorem |
|---|---|---|
| `Ψ` invertible (`Ψ(s, φ(s,a)) = a`) | Strongest | Sufficient for `SubOpt = 0`, **not necessary** |
| **Every action's effect recoverable** by some goal | Weaker | **Sufficient** for bounded loss |
| `f` reconstructs `s` | Unrelated | Not required. A VAE (Variational Autoencoder) meets it and fails |

---

## Results (verbal; curves not legible)

Tasks: Point Maze, Ant Maze (⊃ corridor), Ant Push, Ant Fall, Ant Block (push a small block in a 16 × 16 room), Ant Block Maze. "Images" variants zero the agent's `x,y` and append a **5 × 5 × 3 agent-centred top-down map**, one pixel per corridor-width block, channels = walls / movable blocks / chasms.

| Arm | Representation | Outcome |
|---|---|---|
| **XY oracle** | agent `x,y` | Reference |
| **This method** | `f` learned online by Claim 4 | "Outside of simple point environments", the **only** arm that approaches the oracle, on raw and image variants |
| End-to-end (E2E) | `f` trained by gradients of the upper level's RL objective | Fails ("most baseline methods completely fail to make any progress"). The authors' diagnosis: the space is **under-defined**, since not every sub-task is expressible as a goal |
| Whole observation | raw `s` as the goal space | Fails outside point tasks |
| VAE; β-VAE (Appendix E) | reconstruction | Works only on Point Maze. Reconstruction spends capacity on high-variance, task-irrelevant features (ant joint velocities) |
| E2C (Embed to Control: locally linear latent dynamics) | variational | Fails |
| **HIRO original** (Appendix H) | hand-picked positional subset | ≈ XY oracle on non-image tasks; **"much worse" on image tasks** |
| CPC-style variants (Appendix D) | dot-product energy `f(s′)ᵀ M_k f(s)` | **Detrimental**; several distance-based variants perform similarly to the main one |

| Probe | Result |
|---|---|
| 2D embedding, Ant Maze (Fig. 2) | Recovers a near-`x,y` layout of the corridor, **including from the image observation**. VAE and E2C do not |
| Same, data from a **random** upper-level policy (Fig. 9) | Still near-ideal. The objective does not need task-competent behaviour to shape the space |
| Ant Block Maze, perturbation sensitivity (Fig. 4) | `f` is **more sensitive to block coordinates than to ant coordinates**, with a "healthy mix" early in the episode. The task reward depends on block position |
| **Transfer, `f` frozen** (Appendix F) | `f` learned on Ant Maze, frozen, then used to train a new hierarchy on Reflected Ant Maze (⊃ → ∩) and Ant Push: "robust", policies learn well |

---

## Limitations

| Limitation | Consequence |
|---|---|
| **"Images" are a 75-value semantic map** | Channels are authored object classes (wall / movable / chasm) at corridor resolution. Not pixels. The high-dimensional, partially observed regime `T406` needs is approached, not reached |
| **`d = 2` set to the oracle's dimension** | The designer supplies the goal space's dimension, the one fact that makes `x,y` recoverable. No `d` sweep |
| **Curves illegible; outcomes verbal** | No effect size for any arm |
| **Bound is uniform (`sup_{s,π}`), training is an average over the replay buffer** | The guarantee covers states and behaviours never sampled. The trained objective does not |
| **Constant is numerically vacuous** | At `γ = 0.99`, `c = 10`: `w_c = 100`, `1/(1−γ^c) ≈ 10.5`. The value is the *form* of the objective, not the number |
| **Goal format is displacement; no direction/cosine arm** | Learned-vs-fixed is varied, direction-vs-displacement is not (`T406`) |
| **Lower level sees the whole observation** | `G59` violated as in HIRO, with the source reporting that HIRO had zeroed `x,y` at that level |
| **Same lab, same tasks as HIRO** | Comparison against HIRO is internal, on HIRO's benchmark |
| **Navigation only** | Every task is "get agent or block to `(x,y)`". The oracle is 2D by construction |

---

## Comparison

| | **This page** | [[wiki/entities/hiro.md]] | [[wiki/entities/feudal-networks.md]] | [[wiki/entities/hac.md]] | [[wiki/entities/cpc.md]] |
|---|---|---|---|---|---|
| Goal space | learned `f`, `d = 2` | hand-picked positional subset of `s` | learned `f^Mspace` | raw `s` | — (no hierarchy) |
| Goal format | displacement in `f` | displacement in `s` | unit direction | absolute target | — |
| What trains the space | **action-conditioned contrastive prediction** of the `c`-step future | nothing | the Manager's transition policy gradient (environment return) | nothing | contrastive prediction of the future, **not action-conditioned** |
| Energy / score | `exp(−D(f(s′), φ(s,π)))`, `D` = lower-level distance | — | `exp(d_cos)` (von Mises–Fisher) | — | `exp(z′ᵀ W_k c)` |
| Lower-level reward | `−D(f(s′),g)` + density-ratio correction | `−‖s + g − s′‖₂` | cosine + `αR` | binary reached | — |
| Guarantee | `SubOpt ≤ Cε` | none | none | none | `I ≥ log N − L_N` |

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| `f` | **Defines the nodes** of the coarse graph the upper level plans over ([[wiki/concepts/node-definition-problem.md]]) |
| Claim 4 | A node-set criterion from control, not from prediction or compression: keep exactly enough distinctions that **every `c`-step edge the agent can traverse is still nameable** as a target |
| `φ(s, π)` | An edge labeller: given a source node and a behaviour, it returns the target node's label |
| Bound | Prices the coarsening in **return**, the first such price in the wiki for a learned node set |

---

## Bearing on `T406`

| `T406` arm | This source's nearest arm | Result |
|---|---|---|
| (i) direction in a learned space, co-trained | — | Not run |
| (ii) displacement in fixed coordinates | Whole obs; HIRO's positional subset | Whole obs fails beyond point tasks; HIRO's subset ≈ oracle on raw state, **much worse on images** |
| (iii) displacement in a frozen pretrained embedding | `f` learned on Ant Maze, frozen, transferred | Works on two new tasks |
| — (new) displacement in a learned space, co-trained **by a predictive objective** | Main method | ≈ oracle on raw and on images |
| — (new) displacement in a learned space, co-trained **by the RL gradient** | E2E | Fails |

**What this moves.** HIRO's "learned representation ≈ 0" arm is a 2-layer embedding whose training signal HIRO does not state. This source's E2E arm, trained explicitly by the RL gradient, also fails. A space that is also learned and also co-trained works when its training signal is a dynamics model. So the cost in `T406` Position B is located in **what trains the goal space**, not in learned-vs-fixed and not in co-training as such. The row stays `LIVE`: no direction arm, no true-pixel domain, and the two sources share a lab and a benchmark.

---

## Brainstorm

**(brainstorm)** `φ` is HIRO's off-policy correction amortised. HIRO asks, by argmax over 10 candidates, *which instruction would the current executor have followed to produce these actions?* `φ` asks, by a trained network, *which instruction would produce these actions' effect?* One inverts the policy, the other inverts the dynamics. A hierarchy holding a trained `φ` could relabel its upper-level replay in one forward pass, with no candidate search. Nothing here tests that use.

**(brainstorm)** Claim 4's criterion and [[wiki/concepts/empowerment.md]]'s `K_opt` are the same kind of object: the coarsest state abstraction that loses no *control*. Empowerment scores capacity over reachable states. This criterion scores whether each reachable `c`-step distribution has a goal that reproduces it. Both make the node set a consequence of what the agent can cause. Neither uses a task label, though this source's Ant Block probe shows the trained `f` still leans toward the reward-relevant object. That lean has two candidate sources: the replay distribution (behaviour is shaped by reward) or the energy. The source does not separate them.

**(brainstorm)** The FuN Manager also learns its space with an energy, `exp(d_cos(s_{t+c} − s_t, g))`, but trains it through the return. This source trains the same kind of energy through a likelihood over experienced futures. If the E2E failure generalises, FuN's goal space works *despite* its training signal, helped by the Worker's intrinsic reward shaping it, and a FuN with a Claim-4 space is the missing crossing of `T406`.

---

## Connections

- **[[wiki/entities/hiro.md]]** — the agent this page modifies: identical two-level TD3 arrangement and tasks, with HIRO's hand-picked positional goal subset replaced by a learned `f`. HIRO's "learned representation ≈ 0" arm is matched here by the E2E arm (RL-gradient-trained, fails) and not by the predictively trained arm (≈ oracle), and HIRO's subset degrades on image observations where the learned space does not.
- **[[wiki/entities/feudal-networks.md]]** — the other learned goal space, trained differently: FuN shapes its space through the return with a cosine energy, this page through a contrastive likelihood over experienced `c`-step futures with the lower level's own distance as energy. The E2E failure here is the closest test in the wiki of FuN's training signal, on a different domain (`T406`).
- **[[wiki/entities/hac.md]]** — the fixed-coordinate pole this page's learned space competes with: HAC's goals are absolute raw states with no representation step, and its domains are the low-dimensional ones where this source finds raw positional goals ≈ oracle.
- **[[wiki/entities/cpc.md]]** — the objective this page derives from a return bound and arrives near: the same positive-vs-replay-negatives contrastive estimator, but conditioned on the action sequence and scored by a distance energy; the dot-product energy CPC uses is measured here to be detrimental for goal spaces.
- **[[wiki/concepts/empowerment.md]]** — a second control-derived state-abstraction criterion: empowerment's `K_opt` keeps the coarsest context that loses no channel capacity, Claim 4 keeps the coarsest goal space in which every `c`-step behaviour's effect stays nameable, and this page attaches a return bound to the coarsening.
- **[[wiki/concepts/abstraction.md]]** — sense O2's state-abstraction half with a loss attached: the abstraction is lossy for reconstruction and bounded-lossy for return, and the VAE arm shows the two criteria select different representations.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the goal-state family with its goal space learned: the options are "reach `g` in `f`-space within `c` steps", and the bound states how much the restriction to goal-reachable `c`-step behaviours costs against all `c`-step behaviours.
- **[[wiki/concepts/node-definition-problem.md]]** — an answer from control for a coarse graph's node set: `f` keeps the distinctions needed to name every traversable `c`-step edge, learned online and with no reward label, and its quality is scored in return rather than in reconstruction or prediction.
- **[[wiki/entities/intrinsic-curiosity-module.md]]** — the other feature space carved by action: ICM keeps what an inverse model needs to recover `a` from `(s, s′)`; this page keeps what a forward energy needs to predict `s_{t+k}` from `(s, a_{t:t+c−1})`, and both drop high-variance features the agent does not cause.
