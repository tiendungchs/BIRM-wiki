# Elastic Weight Consolidation

**One quadratic spring per parameter, stiffness = diagonal Fisher information of the earlier task: `L(θ) = L_B(θ) + Σ_i (λ/2)·F_i·(θ_i − θ*_{A,i})²`.** Kirkpatrick, Pascanu, Rabinowitz, Veness, Desjardins, Rusu, Milan, Quan, Ramalho, Grabska-Barwinska, Hassabis, Clopath, Kumaran & Hadsell 2017, PNAS 114(13):3521–3526. Source: `raw/kirkpatrick-2017-elastic-weight-consolidation.md`.

The primary source for the **weight-protection** row of [[wiki/concepts/continual-learning.md]], carried second-hand until now. Three things in it are load-bearing beyond the penalty itself, and none of them was in the wiki: an **empirical audit of the importance estimate** that shows it is wrong in a specific direction, an **analytic regime where the protection inverts sign**, and an **unsupervised task-inference module** measured against a task oracle — which contradicts the wiki's own statement of what EWC assumes.

---

## Derivation — three steps, each with a price

| Step | Statement | What it costs |
|---|---|---|
| Bayesian rearrangement | `log p(θ∣D) = log p(D_B∣θ) + log p(θ∣D_A) − log p(D_B)`, so *all* information about task A must be carried by the posterior `p(θ∣D_A)` | Exact; commits the method to summarising A as a distribution over parameters and nothing else |
| Laplace approximation (MacKay) | `p(θ∣D_A) ≈ N(θ*_A, F⁻¹)` — Gaussian at the found minimum | A point estimate of the posterior's variance; the paper names this its "significant weakness" |
| Diagonal Fisher | `F_i` from first derivatives only; equals the second derivative of the loss near a minimum, and is positive semi-definite | Run time **linear** in parameters and in examples — the reason it scales where the prior quadratic-penalty methods (ref. 32 recomputes curvature per sample; ELLA inverts a `\|θ\|×\|θ\|` matrix) did not |

Three or more tasks need no bookkeeping growth: **the sum of two quadratic penalties is a quadratic penalty**, so anchors merge.

**Overparameterisation is the enabling assumption**, stated explicitly: many `θ` give the same performance, so a solution for B is *likely* to exist near `θ*_A`. Nothing checks this, and nothing signals when it fails.

---

## Results

| Setting | Result |
|---|---|
| Random-pattern linear associator (analytic) | Signal-to-noise ratio of the first stored pattern decays as a **power law** under EWC at all times; under plain gradient descent it follows the same `(n/t)^{0.5}` law only up to `t ≈ N = 1,000` synapses and then **exponentially** |
| Permuted MNIST, 3 permutations | Only EWC keeps A while learning B. Plain SGD forgets A catastrophically; **uniform `L²` on every weight keeps A but cannot learn B** — the constraint has to be *per-parameter* or it just trades one task for the other |
| Permuted MNIST, many tasks | EWC error grows modestly with task count; cross-validated SGD + dropout (the prior state of the art, viable on ≤ 2 permutations) does not scale |
| Atari 2600, 10 randomly chosen games, order randomised with revisits | EWC total human-normalised score (max 10) rises well above the SGD agent's, which **never learns more than one game**; but stays **below 10 separately trained DQNs** |

Atari configuration matters for reading the headline "single network, fixed capacity": the agent also carries **per-game biases and per-element multiplicative gains at each layer**, and **a separate replay buffer per inferred task**. The shared object is the weight matrix; the gains, the anchors and the buffers all scale with task count. Fisher recomputed at each task switch from 100 minibatches drawn from the replay buffer; `λ = 400`; penalty activated only after 20M frames on a game.

---

## The importance estimate audits itself, and fails (Fig. 4C)

Train a DQN on one game, then perturb its weights with zero-mean Gaussian noise of three covariances and measure the score:

| Perturbation covariance | Prediction | Observed |
|---|---|---|
| Uniform over all weights | worst | worst ✓ |
| `(F + λI)⁻¹` — the directions EWC would allow | mild | mild ✓ — **the diagonal Fisher is a good relative ranking of importance** |
| Uniform **inside the Fisher's null space** | *no effect at all* | **same damage as the inverse-Fisher perturbation** ✗ |

The null-space result is the wiki's only direct measurement of an importance estimate's error *sign*: the method is **overconfident that parameters are unimportant**, i.e. it underestimates parameter uncertainty. That is the stated candidate explanation for the Atari shortfall against separate networks, and it is a property of the Laplace/diagonal approximation rather than of the penalty — the proposed fix is a Bayesian neural network posterior, not a different loss.

**(brainstorm)** The perturbation protocol is cheap, label-free and applies to *every* importance-weighted method in the wiki (synaptic intelligence, metaplasticity gates, Average Fisher Sensitivity in [[wiki/entities/progressive-neural-networks.md]]): perturb inside the claimed-irrelevant subspace and see whether performance survives. Nobody else runs it, so no other importance estimate in the wiki has been shown to be even *directionally* right.

---

## Fisher overlap — does protection partition the network or share it?

Normalise two tasks' Fishers to unit trace and take one minus the squared Fréchet distance, `overlap = 1 − ½tr(F̂₁ + F̂₂ − 2(F̂₁F̂₂)^{1/2}) ∈ [0,1]`. Measured across depth on permuted MNIST:

| Condition | Early layers | Layers near the output |
|---|---|---|
| Small permutation (8×8 patch) — nearly the same task | high overlap | high overlap |
| Large permutation (26×26 patch) — very different inputs | **low overlap — separate weights allocated** | still reused |

So EWC neither partitions nor shares by fiat: **sharing is decided per layer by how much the tasks actually have in common**, and the reuse concentrates where the domains agree (here, the label space). This is the same per-layer, task-dependent picture Average Fisher Sensitivity gives for progressive networks, obtained without freezing anything — and it is why the paper's claim is that protection is *compatible* with transfer rather than opposed to it.

---

## Task boundaries were never assumed — they were inferred, and the oracle is worth little

The Atari agent treats task context as the **latent variable of a hidden Markov model**, one generative model of the observations per task, with new models added when they explain recent data better than the existing pool — an online unsupervised clustering trained by a **forget-me-not process**. Its output selects which quadratic anchors are active, which anchor to update at a switch, which per-layer gains apply, and which replay buffer to fill.

Measured against the same agent **handed the true task label**: the improvement is "only modest". Read against the rest of the wiki:

| Source | What the routing signal selects | Value of a task oracle |
|---|---|---|
| **EWC (here)** | which penalty anchors and gains are active | small positive |
| [[wiki/entities/cn-dpm.md]] | **which expert answers** | decisive — the gate is the whole remaining error (48.18% at 5 experts) |
| [[wiki/entities/continual-dreamer.md]] | nothing (task-agnostic) vs. an `L²` anchor | **negative** — the task-aware baseline loses |
| [[wiki/entities/progressive-neural-networks.md]] | **which column answers** | required; left to an oracle and named as a limitation |

**(brainstorm)** The pattern is a design rule, not a coincidence: *a routing error is catastrophic when the router selects the computation and benign when it selects a regulariser.* EWC's inferred context can be wrong on a given step and cost only a slightly mis-anchored gradient; CN-DPM's cannot be wrong at all. That predicts the cheapest way to use an unreliable task-inference module (G37) is to spend it on plasticity gating rather than on component selection — and it means EWC's boundary requirement, which [[wiki/concepts/continual-learning.md]] listed as an open problem, is better stated as *a boundary at which to recompute `F`, which may be inferred*.

---

## Where it inverts: past capacity, protection is worse than no protection

The random-pattern analysis is run to saturation and the sign flips. Once the number of stored patterns exceeds network capacity (`t > N`), **EWC retains a smaller fraction of memories than plain gradient descent**, and the network shows **blackout catastrophe** as in a saturated Hopfield net — neither retrieving old memories nor storing new ones.

The stated cause is structural, not a tuning failure: in EWC the diagonal Fisher only accumulates, so **weights can only ever become less plastic**. The method models retention and has no forgetting operator, so it has no steady state. Cascade models of synaptic consolidation (the paper's refs. 14–15), which EWC is otherwise the machine analogue of, differ exactly here — synapses move *both* ways along the plasticity chain, which is what buys them a steady state at infinite stimulus count.

Two consequences the wiki should carry:

- The **capacity gap (G42) has teeth here**: a system running EWC has no way to detect that it has crossed the point where its own protection mechanism became harmful, and the failure is total rather than graded.
- The cascade/EWC difference is an **experimentally distinguishing prediction** the paper offers back to neuroscience: in a cascade model a synapse's plasticity depends on its rate of potentiation/depression *events*; under EWC it depends on **task relevance**. Two different measurements on the same synapse.

---

## Three numbers per synapse

EWC stores, per parameter: the current weight, the anchor `θ*` (a mean), and `F` (a precision). The proposed biological mapping — aligned with the weight-uncertainty proposal the paper cites, where postsynaptic-potential amplitude variability is sampling from a weight posterior and the more variable synapses are the more potentiable ones:

| EWC quantity | Candidate biological register |
|---|---|
| current weight | early-phase plasticity |
| anchor / mean | late-phase (consolidated) plasticity |
| variance / precision | state of short-term plasticity |

**(brainstorm)** This is a three-register synapse arrived at from the algorithm side, and it lines up with `G52`/`G56`'s demand for per-connection state variables that are not the weight — with the difference that here the extra registers are *statistics of the weight itself* rather than a gain or a writability flag. A synapse carrying `(w, μ, τ)` supports importance-gated plasticity with no outer loop and no task label, since `τ` is updated from the same local gradient stream that updates `w`.

---

## Comparison

| | **EWC** | [[wiki/entities/progressive-neural-networks.md]] | [[wiki/entities/continual-dreamer.md]] | [[wiki/entities/cn-dpm.md]] | [[wiki/entities/ch-hnn.md]] |
|---|---|---|---|---|---|
| What is carried forward | a diagonal precision over parameters | every earlier column, frozen | raw transitions, reservoir-sampled | one classifier + density model per regime | an input→mask function |
| Forgetting | reduced, not prevented | **0 by construction** | reduced by buffer size | ≈0 per component | reduced |
| Capacity | **fixed** (plus per-task gains and buffers) | quadratic growth | buffer size | linear growth | fixed |
| Task boundary | inferred (hidden Markov model + forget-me-not) | given | none needed | inferred (Chinese restaurant) | none needed (per-sample) |
| Transfer between tasks | via shared weights, per-layer, uncontrolled | per-layer, learned | via the shared world model | none (experts disjoint) | via overlapping gates |
| Failure mode | overconfident null space; **inverts past capacity** | unread waste; oracle at test time | goal change (G28) | the gate (G37) | gate quality |

---

## Limitations

- **Only ever less plastic.** No forgetting operator, no steady state, no backward transfer — later evidence cannot improve an earlier solution.
- **The Laplace posterior is measurably too confident** (Fig. 4C), which is the paper's own explanation for not matching separate networks.
- **`λ` is a hand-set scalar** (400 on Atari) trading old against new with no rule for setting it and no run-time read-out of whether it is right.
- **Importance is computed over parameters, not over roles.** Under non-stationary topology what must persist is a rewrite generator rather than object-level structure; a Fisher diagonal cannot express that distinction ([[wiki/concepts/continual-learning.md]] open problems).
- **The evaluated streams have boundaries to infer.** Permuted MNIST and a game schedule are piecewise-stationary by construction; reversal learning and set-shifting, where the contingency changes *inside* a task, are not tested.

---

## Connections

- **[[wiki/concepts/continual-learning.md]]** — the primary source for that page's weight-protection row, and the corrections it forces: the boundary is inferred rather than given, uniform `L²` is the control that isolates *per-parameter* stiffness as the working ingredient, and the protection reverses sign once the network passes capacity.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the mechanism this algorithm reimplements as a loss term, and the one place they come apart testably: cascade metaplasticity keys writability on the synapse's own potentiation history and runs in both directions, EWC keys it on task relevance and only ratchets down.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the wiki's cleanest mechanism-to-objective conversion, now with the return arrow attached: the algorithm hands neuroscience a distinguishing prediction (event-rate vs task-relevance metaplasticity) and a three-register synapse (weight, mean, precision) to look for.
- **[[wiki/entities/progressive-neural-networks.md]]** — the same lab's opposite answer on the same Atari suite: grow and freeze rather than share and penalise. Both measure reuse with a Fisher, one over activations across columns and one over parameters across tasks, and both find reuse is a per-layer property of how much the tasks overlap.
- **[[wiki/entities/dqn.md]]** — the base agent EWC is bolted onto, and the reason the comparison is legible: DQN's one-network-per-game constraint is exactly what this paper is removing, with the residual gap against 10 separate DQNs the price of the approximation.
- **[[wiki/entities/cn-dpm.md]]** — the routing contrast that makes the design rule: an inferred task label costs little when it selects a penalty (here) and costs everything when it selects the expert that answers (there), which is why an unreliable gate is safest spent on plasticity regulation.
- **[[wiki/entities/continual-dreamer.md]]** — the direct rival result in reinforcement learning: grid-searched `L²` protection with a task oracle loses to task-agnostic reservoir replay, so weight protection's advantage over rehearsal is not established outside the fixed-capacity regime this paper works in.
- **[[wiki/entities/ch-hnn.md]]** — measures what this page's mechanism is worth as an *addition*: metaplasticity contributes 0.02 accuracy points when the gate is accurate and 4.3 when the priors are off-distribution, so weight protection behaves as insurance against routing failure rather than as an independent defence.
- **[[wiki/concepts/contextual-inference.md]]** — the same boundary problem solved one level up: responsibility-scaled updating gates plasticity by *relevance* of a memory to the current observation rather than by *importance* of a parameter to a past task, so no Fisher matrix and no anchor are needed.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the alternative this paper argues against on cost grounds: system-level consolidation by replay requires stored memories proportional to the number of tasks, which is the scaling objection that motivates a per-parameter penalty instead.
