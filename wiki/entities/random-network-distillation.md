# Random Network Distillation — Novelty as the Error of Chasing a Fixed Random Function

**An exploration bonus `i_t = ‖f̂(s_{t+1}; θ) − f(s_{t+1})‖²`, where `f` is a frozen, randomly initialised network and `f̂` is a predictor trained by gradient descent on the states the agent visits. The target is deterministic and lies inside the predictor's model class, so what remains of the error is mostly the amount of training data. The bonus is a learned visitation count with no dynamics model: it reads the next state only, never the action or the transition. It goes with a PPO (Proximal Policy Optimization) agent that has two value heads: the intrinsic stream is non-episodic and the extrinsic stream is episodic, each with its own discount.**

> **Provenance.** Burda, Edwards, Storkey & Klimov 2018, *Exploration by Random Network Distillation*, arXiv:1810.12894 / ICLR 2019 (`raw/burda-2018-exploration-by-random-network-distillation.md`). Six hard-exploration Atari games, sticky actions (`p = 0.25`), 128 parallel environments, ~1.97B frames per run by default. Seeds per figure: 3–10. Everything below is from that source unless marked.

---

## Architecture

| Component | Spec | Note |
|---|---|---|
| **Target `f : 𝒪 → ℝᵏ`** | Convolutional encoder (the DQN (Deep Q-Network) stack) + dense layers; random init, **never trained** | Sets the prediction problem. It is deterministic, so there is no aleatoric error by construction |
| **Predictor `f̂`** | Same encoder family, trained on the MSE to `f` over visited observations | Trained on 25% of each batch. The keep probability is cut to 0.125 / 0.03125 at 256 / 1,024 environments so the bonus **decays at a fixed rate** whatever the scale |
| **Input** | 1 frame, whitened per pixel by running mean and std, clipped to `[−5, 5]`; the normalisation is fitted on a random-agent warm-up | "Crucial": a frozen target cannot adapt to the input scale, and without whitening its embedding carries almost no variance |
| **Reward normalisation** | `i_t` divided by a running std of the intrinsic *return*; not clipped. Extrinsic reward clipped to `[−1, 1]` | Keeps the bonus on one scale across games and across training time |
| **Value** | Two heads, `V = V_E + V_I`, fitted separately on `R_E` and `R_I`; advantages summed, `A = A_I + A_E`, with coefficients 2 (extrinsic) and 1 (intrinsic) | Legal because the return is linear in the rewards. It allows a different `γ` and a different episode boundary per stream |
| **Episode boundary** | `R_E` episodic (`γ_E = 0.999`). `R_I` **non-episodic** (`γ_I = 0.99`): game over does not truncate it. Loss of a life is not terminal in either stream | The non-episodic `R_I` treats death as a restart cost, not a loss of all future bonus |
| **Policy** | PPO. CNN, or CNN + GRU (Gated Recurrent Unit) with a matched parameter count | GRU helps only at `γ_E = 0.999` |

### Why the error measures novelty

The paper sorts prediction error into four sources:

| # | Source | Kind | RND |
|---|---|---|---|
| 1 | Too few similar training examples | epistemic, the wanted one | kept |
| 2 | Stochastic target | aleatoric, the noisy-TV trap | **removed**: `f` is deterministic |
| 3 | Missing information or too small a model class | misspecification | **removed**: `f` lies inside `f̂`'s class |
| 4 | The optimiser fails to find the best fit | learning dynamics | kept |

**Bayesian reading.** Take Osband et al.'s randomised prior functions with the regression targets set to zero. Minimising `‖f_θ(x) + f_{θ*}(x)‖²` then distils a random draw from the prior. Each output coordinate acts as one ensemble member with shared parameters, and the MSE estimates the ensemble's predictive variance. So the bonus approximates **epistemic uncertainty about the constant-zero function**, not uncertainty about the dynamics.

**MNIST (Modified National Institute of Standards and Technology) toy.** Hold the training-set size fixed and vary the share of a target class mixed with zeros. Test MSE on held-out target-class examples falls as that class's count rises, so the error behaves like a count. The feared failure, a predictor that learns `f` everywhere (the target itself would do), does not occur under ordinary gradient descent.

---

## Results

### Montezuma's Revenge

| Setting | Result |
|---|---|
| **Intrinsic reward only**, non-episodic `γ_I = 0.999` | Finds more than half of the 24 rooms. One run finds 21. Best return 6,700 in 4 of 5 runs. Return rises, then falls: "no incentive to keep doing the same once such interactions become repetitive" |
| Episodic vs non-episodic intrinsic stream (intrinsic only) | Non-episodic explores more rooms and earns more return |
| Same, combined with extrinsic reward | Non-episodic still finds more rooms, with similar return. The gap shrinks because extrinsic reward preserves useful behaviour |
| Two value heads vs one, both streams episodic | **No benefit**. One head is slightly better. Two heads are kept only because mixed episode boundaries and mixed `γ` need them |
| `γ_E` 0.99 → 0.999 at `γ_I = 0.99` | Large gain |
| `γ_I` 0.99 → 0.999 with extrinsic reward present | **Hurts**, although it helped under intrinsic-only reward |
| Scale: 32 → 1,024 environments, predictor batch held fixed | Higher return per update and higher final return; saturates earlier for CNN. RNN at 32 environments, 1.6B frames: mean **7,570**, one run visits **all 24 rooms** and passes level 1 once (best **17,500**). RNN at 1,024 environments: mean **10,070**, best run mean 14,415 |

### Six hard-exploration games (Table 1, final mean; RNN policy, 3 seeds)

| | Gravitar | Montezuma | Pitfall! | Private Eye | Solaris | Venture |
|---|---|---|---|---|---|---|
| **RND** | **3,906** | **8,152** | −3 | **8,666** | 3,282 | **1,859** |
| PPO, no bonus | 3,426 | 2,497 | 0 | 105 | 3,387 | 0 |
| Forward-dynamics bonus, **everything else identical** | 3,371 | **400** | 0 | 33 | 3,246 | 1,712 |
| Prior state of the art (cited) | 2,209 | 3,700 | 0 | 15,806 | 12,380 | 1,813 |
| Average human | 3,351 | 4,753 | 6,464 | 69,571 | 12,327 | 1,188 |

- According to the authors, this is the first result above average human on Montezuma's Revenge **without demonstrations or emulator-state access**.
- **Controlled ablation of the prediction problem.** The only change is that the predictor gets `(s_t, a_t)` and must predict `f(s_{t+1})`. Montezuma falls from 8,152 to 400, and Private Eye and Solaris also degrade. At convergence the dynamics agent **oscillates across a room boundary**. Sticky actions make it impossible to know whether one more step crosses the boundary, so the error there is irreducible. The same behaviour appears in Private Eye and Pitfall!.
- **An autoencoder-reconstruction bonus** (it also removes source 2, but not necessarily source 3) scores below RND and above PPO (Appendix Figure 8).
- **Pitfall!:** no positive reward is ever found, by any method.

### "Dancing with skulls"

Once the agent has every extrinsic reward it can get reliably, **it keeps interacting with dangerous objects**. It jumps back and forth over a moving skull, moves between laser gates, and steps on and off disappearing bridges. Pitfall! shows the same pattern. The authors' explanation: dangerous states are hard to reach, so they stay under-represented in the predictor's training data.

---

## Limitations

| Limitation | Consequence |
|---|---|
| **Local, not global, exploration**, as the authors state it | Level 1 has 4 keys and 6 doors, and any key opens any door but is used up. To reach the last room the agent must *skip* two easy doors that would pay at once. The bonus never pays enough to save the keys, so the agent "only stumbles upon it rarely" |
| **Exhaustible by design** | The bonus is meant to disappear: "transitory rewards … act as stepping-stones". The predictor batch is sub-sampled so the decay rate stays fixed across scales. So the decay rate is a hyperparameter held constant, not a property of the domain (`G129`) |
| **Blind to action-caused stochasticity only because it ignores the action** | Aleatoric error is removed because the target reads only `s_{t+1}`. The price is that it also ignores *which* transitions are novel: a new state reached by an old route and an old state reached by a new route score the same |
| **Source 4 is kept** | Optimisation failures still produce error. Hard-to-reach states stay high-error, which is one reading of the skull-dancing |
| **Two value heads are not shown to help by themselves** | The only measured gain comes from what the two heads *allow*: a separate `γ` and a separate episode boundary per stream |
| **Budget** | ~2B frames per run, 3–10 seeds. The best single numbers (17,500; all 24 rooms) are one run each |
| **Nothing logs `V_I` across the extrinsic reward's arrival** | The architecture already keeps the intrinsic value separate, which is the extra scalar `T400` asks for, but no curve of it is reported |

---

## Comparison

| | **RND** | [[wiki/entities/intrinsic-curiosity-module.md]] | Forward-dynamics bonus (RND's ablation) | Count / pseudo-count | [[wiki/entities/go-explore.md]] |
|---|---|---|---|---|---|
| Typology cell ([[wiki/concepts/intrinsic-motivation-typology.md]]) | UM computed by a predictor: NM in form, a count in behaviour | NM | NM | UM | UM, consumed as a selection weight |
| Reads the action? | No | Yes, through the inverse loss that shapes `φ` | Yes | No | No |
| Stochastic-trap defence | **Deterministic target**: remove the noise source, keep the raw error | Filter the input to action-relevant features | none | none | not needed; nothing is predicted |
| Fails on | Global, key-saving exploration; persistent skull-dancing | Action-caused noise; exhaustion (319 → 97.5) | Sticky-action room-boundary oscillation (Montezuma 400) | Noisy features make every state novel | Needs a designer cell map; the restorable variant needs a simulator |
| Montezuma's Revenge | 8,152 mean; 17,500 best | not run | 400 | 3,700 (cited SOTA); 12,240 on Go-Explore's cell map | 1.7M / 97,728 (policy-based) |
| Profile over training | Falls, at a rate held fixed on purpose | Falls to ~0 ("boredom") | Stays high where noise is irreducible | Falls | Cell weight `1/√(C+1)` falls; the archive does not forget |

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| The bonus | A soft visitation count over **nodes** only. No edge is scored, so it cannot tell a new edge between known nodes from an old one |
| The failure on keys | The key/door problem is a constraint over **resources** carried along a path. Scoring a path needs something that counts along it; a per-node novelty signal cannot price a path |
| Skull-dancing | Nodes near an absorbing state are rare in the data because reaching them is costly, so they keep a high count-based bonus indefinitely. **(brainstorm)** This is a systematic bias of any visitation estimator toward the edge of the lethal set. |

**(brainstorm) What the page offers `T358`.** The ICM Mario agent learned to *avoid* death, and the authors' explanation is that death ends the episode and with it all future bonus. RND removes that mechanism on purpose: its intrinsic stream is non-episodic, so death costs only a replay of the level. The observed behaviour is then **repeated approach to lethal objects**. That is the prediction position A of `T358` makes once termination no longer supplies the safety, and it comes out of one design choice made for other reasons. Only a matched episodic-intrinsic control can confirm it. Figure 4 has that control, but for room counts only; skull-dancing is not scored in either arm.

**(brainstorm) The sticky-action trap is where ICM's filter leaks.** The dynamics baseline's error comes from the agent's **own** action being randomly repeated. A room crossing is action-relevant, so an inverse-dynamics feature space would keep it. The ICM page predicts the leak for action-caused noise, and this is the first measured instance of that kind of noise, although the baseline here uses random features, not ICM's features.

---

## Connections

- **[[wiki/entities/intrinsic-curiosity-module.md]]** — a second defence against the stochastic trap, with the opposite choice about the action: ICM keeps the forward model and filters its input to what the action explains, while RND drops the transition and predicts a deterministic function of the next state alone. RND's forward-dynamics ablation falls to 400 on Montezuma through sticky-action noise, which is action-caused noise, the kind ICM's filter is predicted to let through.
- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — a formula that looks NM and behaves UM: the reward is a predictor's residual, but the target is deterministic, so the residual tracks how often similar states were seen. That puts a count-like quantity in the NM cell's form and shows the typology's families are defined by what the error *can* contain, not by the formula's shape (brainstorm).
- **[[wiki/entities/go-explore.md]]** — the same benchmark with the novelty statistic moved from a reward into a store: RND's bonus reaches 8,152 on Montezuma and fails on key-saving, which the authors call global exploration. Go-Explore's archive reaches 1.7M with a cruder count, so the global exploration RND lacks is the *addressable frontier* Go-Explore keeps.
- **[[wiki/concepts/multi-horizon-value-learning.md]]** — two value heads on one torso, split by reward stream rather than by horizon: each stream gets its own `γ` and its own episode boundary. On that page's hazard reading, a non-episodic intrinsic stream assumes zero hazard from game over for the curiosity return, and the measured `γ_I` effect flips sign when an extrinsic stream is added.
- **[[wiki/concepts/general-danger-channel.md]]** — the machine behaviour position A of `T358` predicts once the episode boundary no longer protects the agent: with a non-episodic intrinsic return, the bonus agent repeatedly approaches skulls, laser gates and disappearing bridges, because rarely visited states near death keep a high bonus (brainstorm on the mechanism).
- **[[wiki/concepts/self-boosting-knowledge-acquisition.md]]** — the exhaustible supply stated as a design goal: the authors want the bonus to decay and sub-sample the predictor's batch to keep its decay rate constant across scales. It is the clearest case of `G129`'s profile being a tuned schedule rather than a property of domain size.
- **[[wiki/entities/continual-dreamer.md]]** — the same epistemic quantity reached from the other side: Plan2Explore scores ensemble disagreement about dynamics, and RND's MSE is, on its randomised-prior reading, the variance of a parameter-shared ensemble predicting zero. So both are ensemble-variance bonuses, differing in whether transitions enter.
