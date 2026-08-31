# Deep Q-Network (DQN)

**One convolutional network mapping raw pixels to an action-value vector, trained by Q-learning made stable through two purely statistical devices — a uniformly sampled replay buffer and a periodically frozen target network.** Mnih, Kavukcuoglu, Silver, Rusu, Veness, Bellemare, Graves, Riedmiller, Fidjeland, Ostrovski, Petersen, Beattie, Sadik, Antonoglou, King, Kumaran, Wierstra, Legg & Hassabis 2015, *Nature* 518:529–533. Source: `raw/mnih-2015-dqn-human-level-control.md`.

The wiki has carried DQN second-hand on five pages as the sample-inefficiency foil and as the origin of experience replay ([[wiki/index-entities.md]] listed it under "referenced but not yet paged"). The primary source changes two of those readings. **Replay was introduced to decorrelate the gradient stream, not to consolidate and not to plan** — neither position of [[wiki/empirical-tensions.md]] T30 names the reason the artefact they both claim was actually built. And **the deployed sampling rule is uniform**; prioritisation appears only as a paragraph of future work naming prioritised sweeping.

---

## Architecture

| Stage | Spec | Why |
|---|---|---|
| Preprocessing `ϕ` | Per-pixel max over the current and previous frame → luminance (Y) channel → rescale to 84×84; stack the `m = 4` most recent (robust at `m` = 3 or 5) | The max removes Atari's alternate-frame sprite flicker; the stack is the entire state-abstraction mechanism |
| Conv 1 | 32 filters 8×8, stride 4, ReLU | |
| Conv 2 | 64 filters 4×4, stride 2, ReLU | |
| Conv 3 | 64 filters 3×3, stride 1, ReLU | |
| FC | 512 ReLU units | The layer the t-SNE analysis reads |
| Output | Linear, **one unit per action** (4–18 per game) | All action-values in one forward pass; cost independent of `\|A\|`, against history-and-action-as-input designs whose cost scales linearly with `\|A\|` |

```
L_i(θ_i) = E_(s,a,r,s′)~U(D) [ ( r + γ·max_{a′} Q(s′,a′; θ_i⁻) − Q(s,a; θ_i) )² ]

D    replay memory, last N = 10⁶ frames, sampled uniformly, minibatch 32
θ⁻   target-network parameters, cloned from θ every C steps and frozen between clones
γ    0.99;  RMSProp;  ε-greedy 1.0 → 0.1 over the first 10⁶ frames, then fixed
```

**Model-free and off-policy.** No estimate of `p(s′|s,a)` or of `r` is ever formed; off-policy is *forced* by replay, because stored transitions come from older parameters — which is why the algorithm has to be Q-learning rather than a policy-gradient method.

## The instability being fixed, and what each fix addresses

| Cause of divergence under nonlinear approximation | Device | What it is a claim about |
|---|---|---|
| Consecutive observations are correlated → high-variance, non-i.i.d. gradients | Uniform replay | The **data distribution**, not the representation |
| Small `Q` updates swing the policy, which swings the data distribution (self-generated feedback loop; the training set follows whichever action currently maximises) | Uniform replay averages the behaviour distribution over many past parameter settings | **Non-stationarity of the input stream** |
| Target `r + γ·max Q` moves with the parameters being fitted; raising `Q(s,a)` raises `Q(s,a′)` for all `a′` and so raises the target | Frozen target network `θ⁻` | **Bootstrapping**, i.e. the loss has no fixed labels — the delay is the whole mechanism |
| Large residuals | Error clipped to `[−1, 1]` (i.e. `L²` inside, `L¹` outside) | Optimisation hygiene |

All four are statistical. **None of them touch state abstraction, transition structure or reward semantics** — which is exactly the register in which DQN's failures show up.

## Results

| Measure | Value |
|---|---|
| Games | 49 Atari 2600 titles; **one network trained per game**, identical architecture, hyperparameters and learning rule across all of them |
| Training budget | 50M agent steps at frame-skip `k = 4` = **200M emulator frames ≈ 38 days of game experience per game** (this reconciles the 200M-frame / ~924 h figure the wiki carries second-hand from Lake et al. 2017 with the paper's "50 million frames": they count agent steps and emulator frames respectively) |
| Human reference | A professional games tester after **~2 h practice per game**, same emulator, audio disabled so sensory input is matched — a ~460× experience ratio |
| vs. prior RL | Better on **43/49**, with none of the Atari-specific prior knowledge the baselines used |
| vs. human | **≥75% of the human score on 29/49** |
| Evaluation | 30 episodes × 5 min, random no-op starts, `ε = 0.05` |
| Ablations | Replay, target network and the deep convolutional network are each shown load-bearing by disabling them (Extended Data Table 3); a linear function approximator is far worse (Table 4). **The main text reports no numbers for either** — the tables were not in the ingested body |
| Prior knowledge assumed | Input is visual; the score; the action count (*not* what the actions do); the life counter |

**Reward clipping.** All positive rewards → +1, all negative → −1, zeros unchanged, during training only. This is what makes one learning rate work across 49 score scales, and the authors state the cost plainly: **the agent cannot distinguish rewards of different magnitude.** The objective actually optimised is therefore not the game's, which the evaluation nonetheless scores ([[wiki/concepts/objective-identifiability.md]]).

**Partial observability, handled by stacking.** A single screen is perceptually aliased, so the paper defines the state as the whole action-observation sequence, then replaces it with the fixed-length `ϕ` (4 frames). The MDP is thus over sequences in principle and over a 4-frame window in practice — a hard horizon on any latent state that takes longer than ~0.27 s of game time to disambiguate. This, and not the value-learning machinery, is where DQN's inability to represent an instance graph is installed ([[wiki/concepts/latent-graph-discovery.md]]).

## What the representation learned

- t-SNE over the 512-unit layer maps perceptually similar states nearby **and** maps perceptually dissimilar states of similar expected reward nearby. The metric that emerges is **value-shaped, not structure-shaped**: end-to-end reward shapes the convolutional features toward whatever supports value estimation ([[wiki/concepts/population-geometry.md]]).
- Embeddings of states from *human* play overlap the agent's own, so the representation is not policy-private.
- Value traces are legible: in Breakout the predicted state value climbs as the agent tunnels through to the top of the brick wall and jumps once it breaks through; in Pong the 'down' action's value drops to −0.9 one step before the ball would be missed.
- Breakout's tunnelling strategy is discovered, so *some* long-horizon structure is reachable by value backup alone. **Montezuma's Revenge is not** — the paper names temporally extended planning as unsolved for DQN and for every agent it compares against.

## Limitations

| Limitation | Statement |
|---|---|
| **No transfer, no re-goaling** | A separate network per game; nothing composes the learned dynamics with a new objective. The base case for gap G28 — even reward *magnitude* is clipped away, so the objective is not a manipulable object at all |
| **Sample efficiency** | ~460× the human's practice for parity, and the human had watched the game work rather than pressing buttons for 38 days |
| **State abstraction is a 4-frame stack** | Everything the wiki calls de-aliasing is delegated to a fixed window over pixels |
| **Uniform buffer, no structure** | The paper's own critique: the buffer "does not differentiate important transitions", always overwrites the oldest, and weights all transitions equally at sampling — prioritised sweeping named as the fix |
| **No offline plasticity, no transport** | Replay stabilises *one* learner; nothing moves from a fast store into a slow one ([[wiki/concepts/complementary-learning-systems.md]], G14) |
| **Model-free by construction, not by compilation** | An architecture that is model-free from the start and one that became so by consolidating rollouts present the same interface ([[wiki/concepts/amortized-inference.md]]) |

## Comparison

| System | State | What is learned | Re-goaling | Replay rule |
|---|---|---|---|---|
| **DQN** | 4 stacked frames | `Q(s,·)` only | Retrain from scratch | Uniform over the last 10⁶ frames |
| **Episodic control** (MFEC/NEC) | Same pixels, embedded | `(s,a,G)` tuples, keep-the-max return, `k`-NN read | Retrain | The store *is* the policy |
| **[[wiki/entities/continual-dreamer.md]]** | Learned recurrent latent | Transition model + reward + policy in imagination | Fails even with layout held fixed and only the goal moved | Reservoir admission (uniform coverage) beats FIFO, reward and surprise |
| **[[wiki/entities/meta-rl-agent.md]]** | Recurrent activity | A second RL algorithm in the dynamics | Within the trained task family, no weight change | None |
| **[[wiki/entities/deep-active-inference-agent.md]]** | Latent from a (C)HMM | Expected free energy | Depends on the EFE definition | DQN is the control baseline it is scored against |

## Why this matters for a reasoning model

**(brainstorm) DQN is the wiki's clean null.** It has essentially every non-structural ingredient — deep features, off-policy value learning, a memory buffer, a stable optimisation loop — and none of the structural ones: no transition model, no factorisation, no state abstraction beyond a sliding window, no objective it can be handed. It reaches human parity on the half of Atari where dense reward makes value backup sufficient, and fails exactly where the wiki predicts: sparse reward requiring temporally extended plans (Montezuma), and any change of goal. That makes it the right baseline to *subtract* — an architectural addition earns its keep only if it moves the Montezuma-shaped half, and 49 games with one hyperparameter set is a demanding control for anything claiming generality.

**(brainstorm) The replay device is over-interpreted in both directions.** The biological story (hippocampal SWR replay updating value via basal ganglia) is stated by this paper as an analogy *after* the engineering, and the engineering reason — breaking gradient correlation — has no biological counterpart anyone has argued for. A replay buffer weighted by inverse visitation ([[wiki/concepts/offline-replay.md]]) would serve the decorrelation goal at least as well as uniform sampling, so the two readings are not actually in competition at DQN's level of description; they diverge only once replay is asked to *transport* something.

---

## Connections

- **[[wiki/concepts/complementary-learning-systems.md]]** — supplies the primary source for the machine-instantiations table's first row, and narrows the claim: DQN's replay borrows interleaving for optimisation stability only, with no second learner to transport into.
- **[[wiki/concepts/offline-replay.md]]** — the biological object the machine buffer is named after; DQN's deployed rule (uniform over a 10⁶-frame FIFO window) is closer to biology's "upsample the under-visited" than the prioritised variants it inspired, but only by accident of it being the simplest thing to code.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the track record's cleanest "training schedule, not architecture" entry, now with its author's own framing: the neurobiology (SWR replay, reward shaping of visual cortex representations) is cited as convergent support for a device motivated by optimisation stability.
- **[[wiki/concepts/simulation-based-planning.md]]** — the model-free pole of that page's dichotomy, primary-sourced: no transition model is ever formed, so the re-goaling test is failed by construction rather than by degree.
- **[[wiki/concepts/causal-model-building.md]]** — the quantitative sample-efficiency gap on Frostbite, now with the paper's own budget (200M emulator frames, ~38 days per game, one network per game) against a human's ~2 h.
- **[[wiki/concepts/amortized-inference.md]]** — the reference point for that page's inversion: DQN is model-free from the start, and nothing in its interface distinguishes it from a system that became model-free by compiling rollouts.
- **[[wiki/concepts/population-geometry.md]]** — evidence that a reward signal alone will build a representational metric: last-layer embeddings group perceptually dissimilar states of equal expected value, which is the same "abstraction created rather than inherited" pattern that page tracks in the deep-Q context-coding result.
- **[[wiki/concepts/objective-identifiability.md]]** — reward clipping to `{−1, 0, +1}` makes the optimised objective provably different from the scored one, in the most-cited result in deep RL.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the null architecture for the framing: perceptual aliasing is acknowledged explicitly and then answered with a 4-frame window rather than with any inferred state.
- **[[wiki/entities/continual-dreamer.md]]** — the world-model successor that keeps the buffer and makes its selection rule the experimental variable; it also inherits DQN's re-goaling failure in a setting where only the goal location moves.
- **[[wiki/entities/deep-active-inference-agent.md]]** — the ablation ladder that uses DQN as its control, i.e. the standard against which an expected-free-energy objective has to justify itself.
- **[[wiki/entities/meta-rl-agent.md]]** — the same reward-driven training run at a second timescale: what DQN puts in weights, meta-RL puts in recurrent activity, which is where the re-goaling DQN lacks reappears.
- **[[wiki/entities/basal-ganglia.md]]** — the biological value-learning system whose dopaminergic prediction error DQN's TD target is the engineering analogue of, and which the paper names as replay's partner in updating value functions offline.
