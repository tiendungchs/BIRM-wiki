# Neuronal Parameter Heterogeneity

**Give every unit its own biophysical constants — membrane time constant, capacitance, threshold, resting potential, self-inhibition gain — and *learn them*, on an optimization loop separate from the one that learns the weights.**

> **Provenance.** Wang, Zhang, Li, Dou, Guo & Deng 2024, *Biologically inspired heterogeneous learning for accurate, efficient and low-latency neural network*, National Science Review 12(1):nwae301 (`raw/wang-2024-heterogeneous-snn-learning.md`). The model is **HIFI** (Heterogeneous spIking Framework with self-Inhibiting neurons). Note on extraction: the source's five neuron equations and the bi-level objective appear as empty `(2)`–`(8)` markers, so every equation below is reconstructed from the paper's own prose descriptions of its terms, not copied.

Every spiking page in the wiki fixes `τ`, `v_th` and `v_reset` once, globally, by grid search — and [[wiki/architectural-gaps.md]] `G78` is the observation that memory span *is* that constant. This page holds the mechanism that makes those constants parameters instead of hyperparameters, and the price: the loop is still offline and per-task, so the row narrows rather than closes.

---

## The two levels, and why they cannot share one objective

| Level | Object | Count | Learned on |
|---|---|---|---|
| **Network (macro)** | Synapse weights `W` | `O(K²)` | Training split `D_t` |
| **Neuron (micro)** | `α^k = [τ^k, γ^k, C^k, u_th^k, u_re^k] ∈ R⁵`, one vector **per neuron** | `5K` | Validation split `D_v` |

A homogeneous network shares one prefixed intra-neuron system across all `K` units, so a single objective over `W` is sufficient — that is every SNN elsewhere in the wiki. Once `α` varies per unit, it is a second variable *hierarchy*, and fitting both on the same data is the standard overfitting setup. HIFI's answer is bi-level programming with **orthogonal sub-training and sub-validation splits** carved from the training set:

```
min_α   L_v(D_v; W*(α), α)  +  λ · Ω(W*(α), α)
s.t.    W*(α) = argmin_W  L_t(D_t; W, α)
```

Solved by alternating two loops:

```
W ← W − ξ₁ ∇_W L_t(D_t; W, α)        surrogate gradient (triangle-function pseudo-derivative)
α ← α − ξ₂ ∇_α L_u(D_v; W*(α), α)    W*(α) approximated by its one-step update
```

The `∇_α` term is hard because `W*` is itself a function of `α`; the chain rule produces a second-order derivative, approximated by finite difference `W^± = W ± ε ∇_{W′} L_u(W′, α)`. Setting `ξ₁ = 0` collapses it to the **first-order approximation** `∇_α L_u(W, α)` — which the paper reports as cheaper *without sacrificing accuracy*, and uses throughout. This is the DARTS machinery (Liu et al. 2019, cited as ref. 67) pointed at neuron biophysics rather than at architecture choice.

**`Ω` is a Laplacian smoother: neighbouring neurons are encouraged to share similar `α`.** The motivation is empirical, from the group's spatial-transcriptomics work — neurons of similar genotype are spatially grouped on brain tissue. So heterogeneity is *not* i.i.d. across units; it is a smooth field over the network's index space.

---

## The unit: LIF plus one self-inhibiting autapse

The neuron model is LIF with exactly one structural addition — an autapse from axon to soma that subtracts the unit's own last output from its incoming drive.

| Step | Statement | Learned per-neuron |
|---|---|---|
| External stimuli | `S^k(t) = Σ_{i∈N(k)} w_{ik} · O^i(t−1)` | — (`W` is network-level) |
| **Self-inhibition** | `I^k(t)` combines `S^k(t)` with the unit's own last output `O^k(t−1)`, scaled by `γ^k` | `γ^k` |
| Membrane potential | `u^k(t)` from `I^k(t)` via a Leaky-ReLU `f(·)`, with membrane decay `τ^k`, capacitance `C^k`, resting potential `u_re^k` | `τ^k, C^k, u_re^k` |
| Spike | `O^k(t) = Θ(u^k(t) − u_th^k)` | `u_th^k` |
| Reset | Fire ⇒ `u^k ← u_re^k`; else hold | `u_re^k` |

So `O^k(t) = F_{α^k}(S^k(t), O^k(t−1))` — a **per-neuron recurrence of state size 1**, which is where the paper's "neuron-level memory" claim comes from.

**This is spike-frequency adaptation with the sign of the coupling kept and the location moved.** [[wiki/concepts/spike-frequency-adaptation.md]]'s ALIF adds the unit's recent firing to its *threshold*; the autapse subtracts it from the unit's *input current*. The review on that page lists both as producing the identical ISI signature and calls the choice between them an unexploited design fork. HIFI picks the input-current branch and — unlike every model on that page — does not fix the coupling strength: `γ^k` is learned per unit alongside `τ^k`.

---

## What heterogeneity is worth

**Accuracy and latency** (Table 1 of the source; all HIFI numbers are ResNet-18/SEW-ResNet-34, all baselines spike-native surrogate-gradient or conversion methods 2021–2024):

| Data set | Best baseline | HIFI | HIFI time steps |
|---|---|---|---|
| CIFAR-10 | 95.40 (DSR, 20 steps) | **95.98** | 6 — and **95.67 at 2 steps**, already above every baseline |
| CIFAR-100 | 78.50 (DSR, 20 steps) | **79.32** | 6 |
| ImageNet | 69.00 (Diet-SNN VGG-16, 5 steps) | **69.11** | 4 |
| MNIST | 98.2-ish (QCFS, 65 steps) | **98.23** | **5** — 13× lower latency at matched accuracy |

Also: five neuromorphic sets (N-MNIST, DVS128-Gesture, DVS-CIFAR10, SHD, SSC) at up to +8 points and 4× lower latency against STBP/SNU/TSSL-BP on a matched shallow convolutional architecture; 9.83× energy reduction against the matched ANN at 4 time steps (17.83× at 2, 85.73× under fixed-point accounting); operational-complexity analysis showing the autapse adds *slightly* to per-inference cost.

**The ablations are the load-bearing part, and there are three:**

| Ablation | Result | Reading |
|---|---|---|
| Heterogeneous vs. homogeneous learning of the **same** HIFI network, swept over `V_th` and `τ` **initializations** (CIFAR-10) | Heterogeneous wins at every initialization, including bad ones | The mechanism's product is not accuracy, it is **insensitivity to the hyperparameter that G78 says nothing sets**. A learned per-unit constant repairs a badly chosen global one |
| Heterogeneous learning applied to **SNU** — a different neuron model, its original algorithm as control (CIFAR-10/100) | Improves SNU too | The bi-level loop is **separable from the autapse**. Heterogeneity is a training method, not a property of this neuron |
| Degrees of freedom in `α` reduced to 1, 2, 5 | Performance "only slightly affected"; **at 1 free parameter HIFI still beats the SOTA baselines** | Most of the gain comes from *any* per-unit variation, not from the full 5-D biophysics. The expensive part of the model is buying the last few tenths |

**Generalization, which is the part this wiki should care about more than the accuracy table.** Heterogeneity buys out-of-distribution transfer, not just fit: best accuracy on two held-out SHD speakers; best cross-*data-set* transfer training on SHD and testing on SSC and vice versa, where STBP collapses to classifying nearly everything as digit 0; and on single-cell RNA-seq, correct identification of cell types at **0.09%** prevalence (*Sncg*, *Serpinf1*, *Astro*) that two other SNNs and a task-specific ANN all miss, plus cross-species transfer (mouse ALM / mouse V1 → human MTG).

---

## The measurement that makes this more than a tuning trick

After training on each neuromorphic data set, HIFI's learned **membrane time constants** and **resting membrane potentials** are compared against experimentally recorded distributions: human middle temporal gyrus (spiny cells, `n=236`), mouse V1 layer 4 (spiny, `n=164`), mouse cochlear nucleus (mixed types, `n=172`). The trained distributions and the measured ones are reported as very similar — from priors that did not have that shape before training.

**(brainstorm) This runs [[wiki/concepts/neuroscience-ai-transfer.md]] backwards, and it is the rarer direction.** The wiki's standard move is *import* a biological mechanism and check whether the task improves. Here a task objective was optimized freely over a biophysical parameter space and *landed on the measured biological distribution*. That is a weak but real argument that the observed heterogeneity of cortical time constants is task-optimal rather than developmental noise — and it is a certification instrument nothing else in the wiki uses: score a learned parameter against the distribution of its biological counterpart, not against a benchmark. Its weakness is that the paper reports visual similarity of distributions and no distance statistic, so it cannot currently be scored.

---

## Comparison: four ways a unit gets its timescale

| | Set how | Varies across units? | Varies within an episode? | Where |
|---|---|---|---|---|
| Global constant | Design-time grid search | No | No | Every LIF/ALIF model in the wiki |
| Hand-distributed | Author assigns a different constant per **layer** | Coarsely | No | Yin et al. 2021 (92.1% Google Speech Commands), via [[wiki/concepts/spike-frequency-adaptation.md]] |
| **Learned per-unit constant** | Bi-level gradient descent on a held-out split | **Yes, per neuron, smoothed over neighbours** | No | **HIFI** |
| Input-conditioned per-unit | `τ_sys = τ / (1 + τ·f(x, I, t, θ))`, recomputed every instant | Yes | **Yes** | [[wiki/entities/ltc.md]] |

**A fifth entry sits outside this table, and it is the one that is not a time constant at all.** A learned synaptic **delay** sets *when* a spike arrives rather than how long a unit integrates, it is per-*synapse* rather than per-unit, and it is trained in the ordinary task loop by an exact gradient rather than on a held-out split ([[wiki/concepts/learnable-synaptic-delays.md]]). Mészáros et al. 2025 deliberately held `τ_m` and `τ_s` homogeneous and fixed "so that the independent effect of delays would be clear", so the two mechanisms have never been composed — and they are not obviously substitutes: `τ` sets how long evidence persists, `d` sets when it shows up **(brainstorm)**.

The two bottom rows are the interesting pair. LTC makes the horizon a function of the input and pays for it by fusing the content and timing channels into one `f` (that page's objection under `G54`). HIFI keeps them separate — `W` carries content, `α` carries timing — and pays by freezing `α` at deployment. **Neither one has a timescale that is both endogenous and separable**, which is what a run-time-discovered retention interval would need.

---

## Open problems

- **`G78` narrows, it does not close.** The constants are now *learned* rather than *searched*, and learned per-unit rather than per-network — but the loop is offline, per-task, and gradient-based over a held-out split. At deployment the span is as fixed as it ever was. An agent whose required retention interval is discovered mid-traversal still has no mechanism.
- **Nothing sets `λ` or the neighbourhood.** The Laplacian smoother's weight, and what counts as "neighbouring" in a network whose units have no spatial embedding, are both unstated — a hyperparameter introduced by the mechanism that removes hyperparameters.
- **The bi-level split needs a validation set.** Heterogeneity is bought with data held out from `W`'s objective; there is no online or single-stream version, and no statement of how the split size trades against either level.
- **`α` is learned, `W`'s *structure* is not.** The paper's own biological rationale for bi-level learning — "synapses can eliminate or form with the evolution of neurons" — describes structural plasticity, which the model does not implement. Connectivity is fixed throughout.
- **Depth of freedom is unpriced against the alternative spend.** If 1 free parameter per neuron already beats the state of the art, the comparison that matters is 1 learned neuron parameter versus the same parameter budget spent on weights — and it is not run.
- **Computational cost is conceded.** The paper's own limitations section names memory and processing demand as blocking deployment on embedded targets, which is the environment the efficiency argument was for.

---

## Connections

- **[[wiki/entities/spiking-neural-networks.md]]** — the substrate this mechanism edits, and the source of its strongest claim on that page's own terms: HIFI is a **spike-native** network (surrogate gradients through the spiking dynamics, no conversion) reporting CIFAR-100 79.32% and ImageNet 69.11% at 4 time steps, which is the first result in the wiki past MNIST on the track that page's routes table said had never gone past it ([[wiki/empirical-tensions.md]] T231).
- **[[wiki/concepts/spike-frequency-adaptation.md]]** — the same slow per-unit variable with the design fork taken the other way (self-inhibition on the input current rather than adaptation of the threshold) and the coupling strength `γ^k` made learnable rather than swept; this is the first mechanism in the wiki that *sets* the constants that page's `G78` says nothing sets.
- **[[wiki/concepts/meta-learning.md]]** — the two-level shape with the levels drawn at an unusual place: the slow loop optimizes **neuron biophysics** and the fast loop optimizes weights, so the meta-graph/instance-graph split runs along a substrate boundary rather than along a task boundary, and both loops are gradient descent on the same forward pass.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — the adjacent slot: that page's outer loop searches over *plasticity-rule* parameters, this one over *cell* parameters, and the two are composable in principle (a learned rule updating weights inside a learned neuron) with nothing having tried it.
- **[[wiki/entities/ltc.md]]** — the rival treatment of the same variable: LTC recomputes each unit's horizon from its input at every instant, HIFI learns it once per unit and freezes it, and the trade is input-conditioning against keeping the content and timing channels separable (`G54`).
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the transfer running in the reverse direction: rather than importing a measured biological constant, task optimization over a free biophysical parameter space *recovers* the measured distributions of membrane time constant and resting potential in human middle temporal gyrus and mouse V1 layer 4 — evidence that cortical heterogeneity is task-optimal rather than incidental.
- **[[wiki/concepts/latent-graph-discovery.md]]** — what heterogeneity supplies to the target: a distribution of private timescales across units with no architectural hierarchy imposed, so partial paths of different lengths can persist in the same layer — plus the measured out-of-distribution result (cross-speaker, cross-data-set SHD↔SSC, cross-species) that says the diversity buys transfer and not only fit.
- **[[wiki/concepts/certification-instruments.md]]** — a candidate instrument the inventory does not hold: score a model's *learned parameters* against the empirical distribution of their biological counterparts, independently of any task metric. HIFI reports it qualitatively (distribution overlays, no distance statistic), which is why it is a candidate rather than an entry.
- **[[wiki/concepts/spike-encoding-schemes.md]]** — where the heterogeneity argument meets the encoder problem: an adaptive unit's elevated timing sensitivity makes the code choice neuron-model-dependent (T232), and HIFI varies the neuron model *per unit*, so a single global input code is now facing a population of readers with different time constants — a mismatch nothing in either page's evidence measures.
- **[[wiki/concepts/learnable-synaptic-delays.md]]** — the same programme applied to the other temporal parameter, with every design choice taken the other way: per-synapse rather than per-neuron, arrival time rather than integration window, exact event-based gradient in the main loop rather than a bi-level program on a held-out split. The authors there froze the time constants precisely to isolate the delay effect, so the composition of learned `α^k` with learned `d_ji` — the obvious next experiment on both pages — is untried.
