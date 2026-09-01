# World Models (V–M–C)

**Split the agent along the credit-assignment axis: ~5M parameters of unsupervised world model (a VAE (Variational Auto-Encoder) `V` compressing frames to `z_t`, an MDN-RNN (Mixture Density Network + Recurrent Neural Network) `M` modelling `P(z_{t+1} | a_t, z_t, h_t)`) and an 867-parameter *linear* controller `C` evolved on the reward — then train `C` entirely inside `M`'s own sampled rollouts and deploy it in the real environment.**

> **Provenance.** Ha & Schmidhuber 2018, *World Models* / *Recurrent World Models Facilitate Policy Evolution*, NeurIPS 31:2451–2463 (`raw/ha-2018-world-models.md`, the interactive worldmodels.github.io version; MathJax flattened by the clipper). Explicitly a simplified modern test of the 1990–2015 RNN-based controller/model line (*Making the World Differentiable*, *Learning to Think*). This is the paper the rest of the wiki's world-model literature cites as its origin ([[wiki/concepts/learned-world-models.md]]).

---

## The three components

| | Role | Form | Trained on | Params (CarRacing / Doom) |
|---|---|---|---|---|
| **V** | Spatial compression | ConvVAE, 64×64×3 → `z ∈ R^32` (Doom `R^64`), 4 conv + 4 deconv, stride 2 | 10,000 rollouts of a **random policy**, 1 epoch, `L²` + KL | 4,348,547 / 4,446,915 |
| **M** | Temporal compression | LSTM (256 / 512 units) + MDN head → 5 diagonal Gaussians over `z_{t+1}`; Doom adds a `done_t` Bernoulli head | the same rollouts, encoded to `z`, 20 epochs, teacher forcing with `z_t ~ N(μ_t, σ_t²I)` resampled per batch | 422,368 / 1,678,785 |
| **C** | Action | `a_t = W_c [z_t ; h_t] + b_c`, `tanh`-clipped — **one linear layer, no hidden units** | CMA-ES (Covariance-Matrix Adaptation Evolution Strategy), population 64, fitness = mean return over 16 seeds | **867 / 1,088** |

**The split is a claim about credit assignment, not about modularity.** Backpropagation can train 10⁷ parameters on a differentiable loss; a reward arriving at the end of 1000 steps cannot. So put every parameter that a dense loss can reach into `V`/`M` and leave the search over the sparse signal a space small enough for a derivative-free optimiser. The 5,000:1 parameter ratio is the whole design.

**Three things follow that no other entry in [[wiki/concepts/learned-world-models.md]] has in one system.**

| | |
|---|---|
| The world model **never sees the reward** (CarRacing) | Its objective is compress-and-predict; only `C` reads reward. This is the transitions/preferences factorization [[wiki/concepts/simulation-based-planning.md]]'s re-goaling test demands, present by construction — and never re-goaled in the paper, so gap `G28` gets an *architecture* and no measurement |
| The data come from a **random policy** | Which is the maximally-excited regime `ρ_tr` wants (`G63`) — the identifiability condition is satisfied here by an accident of the experimental protocol, not by design |
| `V` and `M` are trained **separately and once** | Stated as practical, not principled: no joint end-to-end training, no reward gradient into `V`, so the object is a fixed feature extractor plus a fixed simulator |

---

## Result 1 — the payoff is the predictive state, and no rollout happens at decision time

CarRacing-v0, average over 100 random tracks ("solved" = 900):

| Agent | Score |
|---|---|
| DQN | 343 ± 18 |
| A3C (continuous / discrete) | 591 ± 45 / 652 ± 10 |
| Gym leaderboard best (unpublished) | 838 ± 11 |
| **`C` sees `z_t` only** (linear) | 632 ± 251 |
| **`C` sees `z_t` only** (+ 40-unit hidden layer, 1443 params) | 788 ± 141 |
| **`C` sees `z_t` and `h_t`** | **906 ± 21** |

Concatenating the RNN's hidden state to the input of a *linear* controller is worth **274 points and a 12× reduction in variance**, and it beats adding capacity to the `z`-only policy (788) by more than adding capacity beat the linear baseline. Nothing is simulated at decision time: `h_t` already parameterises the mixture over `z_{t+1}`, so the agent "can just query the RNN instinctively" — the authors' own baseball/Formula-One framing.

**This is the wiki's sharpest measurement that a world model can pay off entirely as a *state*, with the search deleted** — and it sits against a page whose framing is search over a graph. Recorded as [[wiki/empirical-tensions.md]] **T327**. It is the same shape as [[wiki/entities/cpc.md]]'s reinforcement-learning result (a latent predictive loss helps exactly where the policy needs state the current frame lacks), at 4× the effect size and with the predictive head *used* rather than discarded after training.

---

## Result 2 — training inside the dream, and what the temperature buys

VizDoom *Take Cover*: wrap `M` in a `gym.Env` interface (it predicts `z_{t+1}` **and** `done_{t+1}`), evolve `C` inside it with `V` never invoked — the agent trains **entirely in latent space**, no pixels rendered, no game engine running — then deploy to the real environment. Solved = 750 steps survived.

| `τ` (sampling temperature of `M`) | Score **in** the dream | Score **in** the real environment |
|---|---|---|
| 0.10 | 2086 ± 140 | 193 ± 58 |
| 0.50 | 2060 ± 277 | 196 ± 50 |
| 1.00 | 1145 ± 690 | 868 ± 511 |
| **1.15** | 918 ± 546 | **1092 ± 556** |
| 1.30 | 732 ± 269 | 753 ± 139 |
| random policy | — | 210 ± 108 |
| Gym leaderboard | — | 820 ± 58 |

**Read the two columns against each other: over `τ ∈ [0.1, 1.15]` they are *anti-correlated*.** The agent that scores best on the only quantity it can compute — its own return, under its own model, which is the most control-relevant score anyone has proposed — is the one that performs *worse than a random policy* in the world. This is the strongest version of `G62`/`T144` in the wiki: not that a *prediction* metric fails to order models by planning utility, but that a **realised-return-under-the-model** metric fails too, and fails with the sign flipped.

**Why low `τ` is fatal: mode collapse, not blur.** At `τ = 0.1` the MDN-RNN is effectively a deterministic LSTM and cannot transition into the mixture component in which a monster shoots; fireballs are never generated, every policy scores ~2100, and the learned behaviour is worthless. This is the primary source for the deterministic row of that page's transition trichotomy, and it makes the failure *categorical* (an event type disappears from the model's support) rather than an averaging artefact.

**Why high `τ` is not free either.** `τ = 1.30` transfers worse than 1.15 — the dream becomes too noisy to learn a policy in — but with **lower variance** (± 139 vs ± 556), i.e. it selects a less risky strategy. So stochasticity-as-defence is an **inverted U with a second axis**: `τ` trades exploitability against learnability, and separately trades mean return against return variance. It is a hyperparameter tuned by *looking at the real environment*, which is exactly the loop `G62` says does not exist.

---

## Result 3 — the adversarial policy, observed rather than hypothesised

In initial runs `C` discovered a policy under which the monsters inside `M` **never fire**, and which *extinguishes* fireballs already forming. Two mechanisms are named, and the second is the one the wiki has been missing:

1. `M` is an approximate probabilistic model, so it generates trajectories that violate the real environment's laws; the optimiser finds them.
2. **Handing `C` the model's hidden state hands it the game engine's internals.** `C` is not restricted to the observations a player would get — it can drive `h_t` directly, so it can search for manipulations of the simulator's state rather than of the simulated world.

Point 2 generalises past this system: *any* architecture that feeds a world model's internal state to the policy it optimises (which includes the 906-score CarRacing agent above, and every RSSM actor trained on imagined rollouts) gives the search a strictly larger attack surface than the environment has. The wiki's [[wiki/concepts/shortcut-learning.md]]-pointed-inward framing had the first mechanism and not the second.

---

## Iterative training, and the curiosity signal that comes free

For environments a random policy cannot cover, the paper proposes (adapted from *Learning to Think*): initialise `M`, `C`; roll out `N` times in the **real** environment; train `M` on `P(x_{t+1}, r_{t+1}, a_{t+1}, d_{t+1} | x_t, a_t, h_t)` and `C` inside `M`; repeat. Demonstrated on pixel pendulum swing-up (iteration 1 → 20 visibly extends `M`'s coverage into the swung-up half of the state space).

| Element | Why it matters here |
|---|---|
| **Flip the sign of `M`'s loss in the real environment** | High predictive loss = unfamiliar region, so the model's own training objective *is* the exploration bonus. No separate curiosity module, no ensemble ([[wiki/concepts/epistemic-value.md]]) |
| **`M` predicts `a_{t+1}` as well** | So the world model absorbs the controller's own motor skill; `C` can then be re-tasked to higher-level decisions over skills the model already executes. This is a hierarchy proposal in which the *lower* level lives inside the world model — inverted relative to every option-based scheme on [[wiki/concepts/temporal-abstraction-options.md]] (gap `G33`) |
| **(brainstorm) The loop is `G63`'s failure mode in its purest form** | Iteration 1's data come from a random policy (`ρ_tr` maximal); every later iteration's come from an increasingly competent `C`. The proposal that makes the method scale is the same proposal that anneals the conditional action excitation its model needs — and `M`'s training loss falls throughout. The pendulum figure shows coverage *improving*, because the policy is still bad; nobody has run the iteration far enough for the degradation to appear |

**Biology cited for the loop:** hippocampal replay during rest and sleep as memory consolidation ([[wiki/concepts/offline-replay.md]]), with Foster's "less like dreaming and more like thought"; and, for the motor-skill absorption row, muscle memory freeing working-memory capacity.

---

## Limitations the paper states about itself

| Limitation | Wiki reading |
|---|---|
| **`V` is task-blind by construction.** The VAE reproduced irrelevant brick-tile patterns on Doom walls and *failed* to reproduce task-relevant road tiles in CarRacing. "Unsupervised learning cannot, by definition, know what will be useful for the task at hand" | The primary source for the object-vanishing mechanism on [[wiki/concepts/learned-world-models.md]]'s decoder question, from the origin paper and eight years before the wiki's other citations for it (`T18`). The proposed fix — train `V` jointly with a reward-predicting `M` — is priced correctly: the VAE then stops being reusable across tasks |
| **Neuroscience note on the same row** | Primary sensory neurons are released from inhibition when reward is received, i.e. even early sensory learning is task-relevant rather than generic |
| **Capacity and catastrophic forgetting.** An LSTM's weights cannot hold what an iterative procedure records | Names external memory ([[wiki/entities/differentiable-neural-computer.md]]) and higher-capacity models as the fix; [[wiki/concepts/continual-learning.md]] is the missing half |
| **"Simulates possible futures time step by time step, without profiting from human-like hierarchical planning or abstract reasoning"** | The authors' own statement that this is not a reasoning architecture. The gestured alternative is `C` learning to call *subroutines* of `M`'s weight matrix rather than rolling it forward — which nothing in the wiki does either (gaps `G15`, `G24`) |
| **Never trained on the real VizDoom** | `DoomRNN` results are dream-trained, real-tested; there is no real-environment training baseline to compare against |

---

## Comparison

| | **World Models** (2018) | [[wiki/entities/continual-dreamer.md]] (RSSM lineage) | [[wiki/entities/v-jepa-2.md]] | [[wiki/entities/gcq.md]] |
|---|---|---|---|---|
| Transition | Stochastic (5-component MDN over `z`), temperature-adjustable | Hybrid RSSM (deterministic carrier + stochastic latent) | Deterministic | Fixed group action `z' = z + a` |
| Decoder | Yes (VAE), and **unused during dream training** | Yes (reconstruction ELBO) | None | Yes (decode only) |
| `V`/`M` trained | Separately, once, on random-policy data | Jointly, on a persistent replay buffer | Two stages, action-free then action-conditioned | Single quantisation over observation–action stream |
| Controller trained | **CMA-ES on 867 params**, inside the model | Policy gradients on imagined rollouts | No policy — cross-entropy-method planning at decision time | Greedy latent subtraction |
| Rollout at decision time | **None** (reactive on `z_t, h_t`) | None (policy is amortised) | Yes | One step |
| Defence against planner exploitation | `τ`, tuned externally | Stochastic latent | None stated | Transition is not learned |

---

## Connections

- **[[wiki/concepts/learned-world-models.md]]** — the origin paper of that page's object, and the primary source for three of its claims it was citing secondhand: planner exploitation (observed, with the extra mechanism that the policy is handed the model's hidden state), the deterministic-transition failure as *mode collapse* rather than blur, and the pixel-loss weighting that drops task-relevant detail while keeping wall texture.
- **[[wiki/concepts/simulation-based-planning.md]]** — the counter-instance to that page's framing: the world model's measured payoff here (632 → 906) is the predictive hidden state used *reactively*, with no rollout at decision time, while the rollout is used only offline to generate training episodes (`T327`).
- **[[wiki/concepts/amortized-inference.md]]** — dream training is Mode-2 → Mode-1 compilation with the environment replaced too: the expensive object is not a search but the real world, and what is amortised into `C`'s 867 parameters is experience the agent never had.
- **[[wiki/concepts/offline-replay.md]]** — the paper's own analogy for the dream loop, cited to hippocampal replay and consolidation; the disanalogy the wiki should keep is that replay reinstates *recorded* trajectories while `M` samples novel ones from a fitted distribution.
- **[[wiki/concepts/epistemic-value.md]]** — the cheapest exploration bonus in the wiki: negate the world model's own predictive loss in the real environment, so no separate uncertainty estimator, ensemble or information-gain term is needed.
- **[[wiki/concepts/shortcut-learning.md]]** — the observed adversarial policy: the optimiser found a behaviour under which the model's monsters never fire, which is shortcut learning with the search as the agent and the model's error as the reward channel.
- **[[wiki/entities/cpc.md]]** — the same finding on the other side of the loss function: a latent predictive objective pays by supplying state the current frame does not carry, measured there as 4-of-5 DeepMind Lab tasks and here as 632 → 906 with the recurrent state concatenated to a linear policy.
- **[[wiki/entities/continual-dreamer.md]]** — the direct descendant of the dream-training move, with the temperature knob replaced by a hybrid RSSM and the evolutionary controller by policy gradients; it inherits this page's exploitability problem without inheriting its explicit control over it.
- **[[wiki/entities/v-jepa-2.md]]** — the opposite settlement of every choice here: no decoder, deterministic transition, planning at decision time rather than a compiled controller — and no analogue of `τ`, so nothing blunts the exploitation this page demonstrates.
- **[[wiki/entities/gcq.md]]** — the far end of the transition axis: where this page makes the transition *more* stochastic to keep the planner honest, GCQ removes learning from the transition entirely, and pays with exactly the multi-modality that `τ = 0.1` shows is load-bearing.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the external-memory fix the paper names for its own capacity limit: an LSTM's weights cannot hold what an iterative data-collection procedure records.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the inverted hierarchy proposal: absorb motor skills into `M` by having it predict `a_{t+1}`, so the low level lives inside the world model and the controller composes over skills the model already executes (gap `G33`).
- **[[wiki/concepts/continual-learning.md]]** — the limitation the paper flags and does not address: an iteratively retrained `M` is a single network overwritten across data distributions, which is the catastrophic-forgetting setting.
