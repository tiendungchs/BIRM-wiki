# Intrinsic Curiosity Module — Prediction Error in a Feature Space Carved by Inverse Dynamics

**A curiosity bonus `rⁱ = (η/2)‖φ̂(s_{t+1}) − φ(s_{t+1})‖²`. It is a forward model's prediction error, measured in a feature space `φ` that is trained *only* to predict the agent's own action from two consecutive observations. The predictive-novelty reward (NM) is unchanged. What changes is the space the error is measured in: whatever the action does not explain is filtered out before the error is taken. The claim is that this defeats the stochastic trap without any learnability estimate.**

> **Provenance.** Pathak, Agrawal, Efros & Darrell 2017, *Curiosity-driven Exploration by Self-supervised Prediction*, ICML 2017 / arXiv:1705.05363 (`raw/pathak-2017-curiosity-driven-exploration-by-self-supervised-prediction.md`). Environments: VizDoom `DoomMyWayHome-v0` and Super Mario Bros. Most learning curves exist only as figures, so the values below are from the text and the two tables. Everything below is from that source unless marked. The paper calls it "ICM". This wiki's glossary already uses ICM for Independent Causal Mechanisms, so this page spells the name out.

---

## Architecture

| Component | Spec | Note |
|---|---|---|
| **Encoder `φ`** | 4 conv layers (32 filters, 3×3, stride 2, ELU); `φ(s) ∈ ℝ²⁸⁸`. Input = 4 stacked 42×42 greyscale frames | Trained by the inverse loss and the forward loss together |
| **Inverse model `g`** | `â_t = g(φ(s_t), φ(s_{t+1}); θ_I)`; fully connected 256 → softmax over actions; `L_I` = cross-entropy | The only term that defines *what* `φ` keeps |
| **Forward model `f`** | `φ̂(s_{t+1}) = f(φ(s_t), a_t; θ_F)`; fully connected 256 → 288; `L_F = ½‖φ̂(s_{t+1}) − φ(s_{t+1})‖²` | Its error is the reward |
| **Reward** | `r_t = rⁱ_t + rᵉ_t`, `rⁱ_t = (η/2)‖φ̂ − φ‖²` | Additive. `rᵉ` is sparse or absent |
| **Joint objective** | `min_{θ_P,θ_I,θ_F} [−λ E_π[Σ r_t] + (1−β)L_I + βL_F]`, `β = 0.2`, `λ = 0.1` | The policy gradient and the curiosity module are trained on one loss, each with its own weight |
| **Policy** | A3C (Asynchronous Advantage Actor-Critic): same conv stack → LSTM 256 → value and policy heads; 20 asynchronous workers | The module is claimed to be policy-agnostic, but A3C is the only policy learner tested |

**The three-way partition the design rests on.** Sources of observation change are (1) controlled by the agent, (2) not controlled but affecting the agent, (3) neither. A good curiosity space models (1) and (2) and ignores (3). The inverse loss is the proposed filter.

**(brainstorm) The objective guarantees (1) only.** An inverse model needs only the features that discriminate *which action was taken*. A vehicle driven by another agent (class 2) helps predict `a_t` only if it changes what the action does. So nothing in `L_I` forces `φ` to keep it. The paper claims (1)+(2) and tests only (3), via the white-noise distractor. Class (2) is untested and is where the filter should leak. It matters: class (2) is exactly the content a theory-of-mind or physics module needs.

**(brainstorm) The inverse loss is also the anti-collapse provision.** A forward loss taken alone over a learned `φ` has a trivial minimiser: constant `φ`, zero error, zero reward. The action-prediction term is what holds `φ` up. It supervises the embedding against an external label, the agent's own efference copy. That is not one of the self-supervised loci on [[wiki/concepts/representational-collapse.md]], and the paper never raises it. `β = 0.2` makes the inverse term the larger weight.

---

## Results

### Sparse extrinsic reward — VizDoom, 9 rooms, +1 at the vest, 2,100-step cap

| Setting | A3C | pixel-space curiosity + A3C | **ICM + A3C** |
|---|---|---|---|
| "Dense" (spawn in any of 17 rooms) | learns slowly | learns | fastest |
| "Sparse" (Room 13, ~270 optimal steps) | fails | converges, like ICM | converges |
| "Very sparse" (Room 17, ~350 steps) | never succeeds | **never succeeds** | perfect score in **66%** of runs |
| "Sparse" + **40% of the image replaced by white noise** | — | "suffers significantly" | perfect score |

Three seeds per curve, and no tuning of random seeds.

| "Sparse", at convergence | Mean (median) success |
|---|---|
| TRPO | 26.0% (0.0%) |
| A3C | 0.0% (0.0%) |
| VIME + TRPO | 46.1% (27.1%) |
| **ICM + A3C** | **100.0% (100.0%)** |

The TRPO and VIME (Variational Information Maximizing Exploration) numbers are taken from concurrent work, not re-run. **Sanity control:** random-noise "curiosity" drawn from uniform, Gaussian or Laplacian distributions, swept over parameters, never reaches the goal.

### No extrinsic reward

| Domain | Result |
|---|---|
| VizDoom | Navigates corridors and often traverses the whole map, reaching rooms >250 optimal steps away within 2,100 steps. Random exploration gets stuck on walls |
| Mario Level-1 | Crosses **>30%** of the level. Learns to kill and dodge enemies with no reward for doing so. The authors' explanation: death ends the episode and so saturates future curiosity |
| Mario ceiling | A pit at **38%** needs a 15–20-press sequence. Failing it kills the agent, and nothing tells it there is anything beyond |

### Transfer — Mario (Table 1, trained on Level-1 with curiosity only)

| | L-1 scratch (1.5M) | L-2 as is | L-2 fine-tuned (1.5M) | L-2 scratch (1.5M / 3.5M) | L-3 as is | L-3 fine-tuned (1.5M) | L-3 scratch (1.5M / 5.0M) |
|---|---|---|---|---|---|---|---|
| Mean distance ± s.e. | 711 ± 59.3 | 31.9 ± 4.2 | **466 ± 37.9** | 399.7 / 455.5 | **319.3 ± 9.7** | 97.5 ± 17.4 | 11.8 / 42.2 |

- **Level-2** (night world) fails as is and recovers under curiosity-only fine-tuning. Fine-tuning beats training from scratch even with more steps than pretraining plus fine-tuning combined (3.5M).
- **Level-3** (day world, as in Level-1) transfers as is (319) and **gets worse under fine-tuning (97.5)**. The agent reaches a point it cannot pass. It has already learned everything before that point, so the intrinsic reward drops to ~0 and the policy degenerates. The authors call this "curiosity blockade" and compare it to **boredom**.
- **VizDoom**: pretrain with curiosity only on a different map with different textures, then fine-tune on the "very sparse" test map. This beats ICM trained from scratch on curiosity + extrinsic reward. The pixel-space variant does not transfer at all.

---

## Limitations

| Limitation | Consequence |
|---|---|
| **The reward is exhausted by learning, and the paper measures the damage** | Level-3 fine-tuning: 319 → 97.5 once the forward model has fitted everything reachable. The wiki's clearest measurement of `G129`'s failure mode |
| **Three seeds, curves only, baselines partly borrowed** | TRPO/VIME are not budget-matched, by the authors' own statement ("different setups") |
| **Only class (3) nuisance is tested** | Fixed-region white noise. No moving distractor, no agent-affecting but uncontrollable source (class 2), and no noise injected *through* the action channel (e.g. a remote the agent can press to change a noisy screen) |
| **The filter is a learned invariance, not a learnability estimate** | Stochasticity that *is* action-caused stays in `φ`, and its forward error stays irreducible. So the trap is removed only for noise the agent cannot influence |
| **No hierarchy, no memory of rare events** | The authors defer both: exploration skills as low-level primitives, and a replay memory for rare "opportunities for interaction" |
| **The pit** | A single long, exact action sequence with death on failure lies outside any prediction-error bonus. Contrast [[wiki/entities/go-explore.md]]'s derailment diagnosis and its return-then-explore fix |
| **Additive mixing, intrinsic term not logged separately** | `r = rⁱ + rᵉ` is `T400`'s position-A arrangement by construction. The VizDoom curiosity-then-extrinsic schedule is run, but no curve reads `rⁱ`'s magnitude across the introduction of `rᵉ`, which is the measurement that row needs |

---

## Comparison

| | **This module** | Pixel-space curiosity (its ablation) | VIME | Count / pseudo-count | [[wiki/concepts/learning-progress.md]] | [[wiki/concepts/realised-information-gain.md]] |
|---|---|---|---|---|---|---|
| Typology cell ([[wiki/concepts/intrinsic-motivation-typology.md]]) | NM | NM | IGM | UM | CPM | IGM |
| Where the error is measured | learned action-relevant `φ` | raw pixels | posterior over dynamics parameters | visitation counts | own achievement record | Dirichlet posterior |
| Stochastic-trap defence | **filter the input space** (inverse dynamics) | none | information gain is bounded | none | **take a derivative** | prior arithmetic `1/(j−1+K)` |
| Fails on | action-caused noise; exhaustion | any irreducible pixel noise | continuous high-D cost | noise makes every state novel | needs activity regions | non-stationarity |
| Profile over training | falls to ~0 ("boredom") | stays high on noise | falls | falls | falls to 0 at mastery | falls |

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| `φ` | A node space induced by *what the agent's actions can distinguish*: a vertex-set definition drawn from the action stream rather than from pixels or a designer ([[wiki/concepts/node-definition-problem.md]]) |
| Forward model `f` | The action-labelled edge set over those nodes |
| `rⁱ` | "This edge is not yet in the model", so it is a frontier signal, but only over action-relevant structure |
| Inverse model `g` | An edge-label decoder: given two nodes, which action connects them |
| What is lost | Every edge the agent cannot influence. The graph of *world* dynamics that does not pass through the agent is invisible by construction |

**(brainstorm) Closest thing in the wiki to a learned agent/world boundary (`G92`), and why it is not one.** `φ` is carved by an efference-copy statistic learned with no supervision, which is what Safron's proposal asks for ([[wiki/entities/integrated-world-modeling-theory.md]]). But it is a *feature filter*, not a partition of variables. It discards the uncontrolled world instead of representing it as "observable, not settable". It is never tested on an intervention the observational model gets wrong. The cheap next step: add a second forward model on the *residual* features (what `φ` throws away) and compare the two errors. That yields a controllable/uncontrollable split, like Iso-Dream's, with the controllable branch's definition learned rather than assumed.

---

## Connections

- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — the predictive-novelty (NM) cell with its stochastic-trap failure repaired without leaving the cell: the reward is still raw forward error, and the input space is restricted to what the action explains. That is a third defence alongside progress (LPM/CPM) and information gain (IGM), and the typology has no axis for it.
- **[[wiki/concepts/learning-progress.md]]** — two opposite answers to the unlearnable-activity problem: learning progress keeps the raw space and takes a derivative, so it abandons `A4`; this module keeps the raw error and shrinks the space, so it never sees `A4` if `A4`'s noise is action-independent, and is trapped by it if the noise is action-caused.
- **[[wiki/concepts/realised-information-gain.md]]** — the third stochastic-trap defence. There a Dirichlet prior's `1/(j−1+K)` decay shrinks posterior jitter under noise; here a learned invariance deletes the noise before any belief is updated. Only the second survives a non-stationary source, and only if that source is not action-caused.
- **[[wiki/concepts/learned-world-models.md]]** — a forward model trained in a feature space chosen by an inverse model, which adds a row to that page's factorisation table: action-relevant versus action-irrelevant features. It is the learned-filter ancestor of Iso-Dream's controllable/non-controllable split, with the uncontrollable branch discarded rather than modelled.
- **[[wiki/entities/world-models-vmc.md]]** — the same idea with opposite design choices: that page proposes flipping the sign of `M`'s own loss as an exploration bonus with "no separate curiosity module". This page shows why a separate module was needed: a raw-space loss is maximised by irreducible noise, as its pixel-space ablation fails on very sparse and noisy VizDoom.
- **[[wiki/concepts/representational-collapse.md]]** — an anti-collapse provision that page does not list: a forward loss over a jointly learned `φ` is minimised by constant `φ`, and the inverse-dynamics term holds the embedding up by supervising it against the agent's own action label rather than by a term over samples, dimensions or marginals (brainstorm).
- **[[wiki/entities/go-explore.md]]** — the same sparse-reward target reached by storing a frontier instead of rewarding one. This module's Mario pit (a 15–20-press sequence with death on failure) is Go-Explore's derailment case, and its Level-3 "curiosity blockade" is detachment's cause seen from the inside: the reward that would bring the agent back to the frontier has been spent.
- **[[wiki/concepts/empowerment.md]]** — both quantities are built on how much actions determine later sensors. Empowerment maximises `I(A_t; S_{t+1})` as the reward itself. This module trains `p(a_t | s_t, s_{t+1})` only to choose the space where a different quantity, forward error, is rewarded. So the channel empowerment scores is the one this module uses as a filter.
- **[[wiki/entities/integrated-world-modeling-theory.md]]** — the unsupervised controllability statistic that framework proposes for deriving the self/world boundary, learned in practice as a by-product of curiosity: `φ` keeps what the efference copy explains. It stops short of `G92` because it drops the uncontrolled world instead of representing it as observable but not settable.
- **[[wiki/concepts/replay-prioritisation.md]]** — the same forward-error quantity with a different consumer: here it is an action reward and it works, which is half of the pair that page reports (`|δ|` works as a bonus and fails as a rehearsal priority).
- **[[wiki/entities/h-dqn.md]]** — the other 2016–17 use of "intrinsic motivation" in deep reinforcement learning, with the word meaning something different: there it is a binary reward for reaching a designer-given goal (competence family), here a dense prediction error with no goal at all (knowledge family). The authors propose this module's learned exploration skill as a low-level primitive for exactly such a hierarchy, and nobody here has built it.
- **[[wiki/concepts/self-boosting-knowledge-acquisition.md]]** — the measured failure that page's store-reading reward is built to avoid. Here Level-3 fine-tuning falls 319 → 97.5 once the forward model has fitted everything reachable. A reward that reads the frontier of the agent's store would still be non-zero at the blockade, provided the store records the unreached region as unheld (`G129`).
- **[[wiki/concepts/general-danger-channel.md]]** — the sign question from the machine side: a positive per-step bonus plus episode termination makes death a *loss of future reward*, and the Mario agent learns to dodge enemies with no penalty anywhere. So a bonus agent is not simply drawn into irreversible states, which `T358`'s irreversibility measure has to control for.
- **[[wiki/entities/random-network-distillation.md]]** — the opposite design against the same trap: this page keeps the forward model and filters its input to what the action explains, while RND drops the transition and predicts a frozen random function of the next state alone. RND's forward-dynamics ablation falls to 400 on Montezuma because the agent's own action is randomly repeated (sticky actions). That is action-caused noise, the class this page's limitations table says the inverse-dynamics filter lets through, though that ablation ran in random features, not in `φ`.
- **[[wiki/entities/never-give-up.md]]** — this page's inverse-dynamics embedding kept and its forward model dropped: NGU rewards `k`-nearest-neighbour sparsity in `f` instead of forward error in `φ`. Its Random Disco Maze repeats this page's white-noise control with wall colours resampled at every step; an untrained `f` fails it (oscillates between two cells) and the learned one produces depth-first coverage, so the inverse loss is what makes the filter (Badia et al. 2020).
