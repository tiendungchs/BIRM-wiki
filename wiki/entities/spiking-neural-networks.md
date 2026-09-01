# Spiking Neural Networks (SNNs)

**A network class whose units communicate by binary, temporally-located events rather than by real-valued rates — timing is part of the message, not an implementation detail.**

The wiki's stake in SNNs is not efficiency. It is [[wiki/empirical-tensions.md]] T1: Hassabis et al. 2017 declare Marr's implementation level out of scope, and SNNs are the concrete case where that exclusion is testable — if spike timing carries computational content, a purely functional specification of a reasoning architecture is incomplete (Schmidgall et al. 2023).

---

## Architecture

| Component | Specification |
|---|---|
| **Unit state** | Membrane potential `V(t)`, integrating input across time from pre-synaptic neurons |
| **Dynamics** (leaky integrate-and-fire) | `τ_m dV/dt = −(V(t) − E_L) + R_m · I_inj(t)` — `τ_m` membrane time constant, `E_L` resting potential, `R_m` membrane resistance, `I_inj` injected current |
| **Output** | If `V(t) ≥ V_th` emit a binary spike to all post-synaptic connections and set `V(t) ← V_reset` |
| **Code** | Sparse in time, binary in amplitude. *Which* code — count rate, time-to-first-spike, phase, rank order, burst, synchrony, temporal contrast — is a free choice made at the input and not implied by anything above it; the taxonomy and its trade-offs are in [[wiki/concepts/spike-encoding-schemes.md]] |
| **Native learning rule** | [[wiki/concepts/synaptic-plasticity.md]] — spike-timing-dependent plasticity is defined directly on the inter-spike interval `Δt` |

---

## Key claims and results

| Claim | Status |
|---|---|
| Spikes carry **more information than rate-based representations**, despite being binary and sparse in time | Theoretical demonstration (cited) — the load-bearing claim for T1 |
| **Output timing can be an order of magnitude more precise than the substrate producing it** | Simulation with measured parameters: a leaky integrate-and-fire unit driven by 250 µs postsynaptic potentials, `τ_m ≈ 100 µs` and 40 µs input jitter fires with 20–25 µs precision, because threshold is always crossed on the rising phase of a coherent volley — and the precision depends only weakly on `τ_m` (Gerstner et al. 1996; [[wiki/concepts/temporal-coding.md]]). This is the strongest available form of the row above: the timing content is not inherited from any fast component, so no rate specification of the same circuit can express it |
| Better energy efficiency; capable of processing noisy and dynamic data; more robust and fault-tolerant computation | Modelling studies. The review is explicit that these follow partly from properties *distinguishing SNNs from ANNs*, not from biological plausibility as such |
| Scale is reachable | Large spike-based transformer models exist |
| Trainable by meta-optimized rules | Surrogate gradients make the non-differentiable threshold traversable, enabling a differentiable STDP rule to produce online one-shot continual learning and one-shot image class recognition ([[wiki/concepts/meta-optimized-plasticity.md]]) |
| Unsupervised STDP has a **named objective** in one configuration | Poisson input neurons + a stochastic winner-take-all circuit make STDP an approximate **online expectation-maximization** for a multinomial mixture: an output spike is a sample from the posterior over hidden causes (E-step), applying STDP to the fired neuron's synapses is the M-step (Nessler et al. 2009, 2013; [[wiki/concepts/synaptic-plasticity.md]]). The only entry in the spike-timing family that answers "what quantity improves" |
| Trainable by forward-only local rules | Eligibility propagation (e-prop) — a forward-computable eligibility trace `e_ji(t) = dz_j(t)/dW_ji` multiplied by an online error estimate ([[wiki/concepts/biologically-plausible-credit-assignment.md]]) |

**Neuromorphic hardware.** Intel's Loihi, IBM's TrueNorth, SpiNNaker — specialized architectures for executing SNNs and brain-inspired local learning. The hardware and the local-learning constraint are the same design decision seen from two sides: locality is what makes the parallelism physically realizable, and it is why backpropagation-shaped algorithms do not map onto these chips. A second hardware family sits alongside them and imposes a *different* constraint: **analog in-memory computing** stores the weights as device conductances and does the matrix–vector product in the array, so reads are nearly free and **writes** are the expensive, stochastic operation — which prices an inner loop in devices written rather than in gradient steps ([[wiki/concepts/analog-in-memory-computing.md]]). A recurrent SNN of 250 leaky integrate-and-fire neurons has been run there with its input and recurrent matrices in phase-change memory, adapting to an unseen robot-arm trajectory in **one** on-chip update (Ortner et al. 2025).

---

## Routes to a *deep* SNN, and what each one costs

> Tavanaei, Ghodrati, Kheradpisheh, Masquelier & Maida 2019, *Deep learning in spiking neural networks* (`raw/tavanaei-2019-deep-learning-snn.md`, Neural Networks 111:47–63). A review; every number below is quoted from it, and almost all of them are MNIST.

The limitation "weight optimization is the central open problem" resolves into five distinct routes, which differ in **where the learning happened**:

| Route | How weights are set | Learns *in spikes*? | Best reported |
|---|---|---|---|
| **ANN-to-SNN conversion** | Train a rate ANN offline by backpropagation, copy the weights, replace each activation by a firing rate; weight normalization added to stop saturation loss (Diehl et al. 2015) | **No** | The highest of the family, and the only route reported past MNIST — CIFAR-10 and ImageNet (Rueckauer et al. 2017) |
| **Surrogate-derivative backpropagation** | End-to-end gradient descent with the **membrane potential** used as the differentiable activation value (Lee et al. 2016) | Yes, but offline and non-local | 98.88% MNIST at **~5× fewer operations** than the matched DNN |
| **Layer-wise local representation learning** | Each convolutional layer trained separately by a spike-based sparse-coding rule (SAILnet) or an STDP variant; classifier stacked on top | Yes | 99.05% MNIST (stacked spiking convolutional autoencoders); 98.4% with a hand-crafted difference-of-Gaussian front end + STDP + SVM readout |
| **Spike-based backpropagation converted to a local rule** | BP-STDP rewrites the backpropagation update as temporally local STDP; event-driven random backpropagation (eRBP) uses error-modulated plasticity with every quantity local to the neuron and synapse (Neftci et al. 2017) | Yes, online | "comparable to equal-sized conventional and spiking networks" on MNIST — no advantage claimed |
| **Unsupervised STDP with one trainable layer** | STDP in a two-layer net; classifier readout | Yes | 95% MNIST (Diehl et al. 2015) |

**The load-bearing distinction is not architecture but *when* learning happened.** The review's own summary of its comparison table: offline (converted) models report higher accuracy, online models offer genuine multi-layer learning at lower accuracy. So every headline accuracy that makes SNNs look competitive was produced by gradient descent on a rate network ([[wiki/empirical-tensions.md]] T231).

**"Multi-layer" ≠ "multi-layer learning".** The whole early hierarchical-STDP line (Masquelier & Thorpe 2007, 2010 and successors) has many layers of *processing* — preprocessing, one learning layer, one classifier layer — and exactly **one trainable layer**. This is the same shape as a reservoir with a linear readout ([[wiki/concepts/autonomous-pattern-generation.md]]) and should be scored the same way.

**The efficiency claim, quantified once.** Neil et al. 2016 ran 522 converted SNNs, all with the identical `784-1200-1200-10` architecture and all reaching 98% MNIST, varying only spiking parameters, and measured total operations against the non-spiking net's requirement. The spread across those 522 is entirely a matter of SNN-side hyperparameters — so "SNNs need fewer operations" is a statement about a *tuned* configuration, not a property of the substrate.

**Update: the surrogate-gradient row has since gone far past MNIST** (Wang et al. 2024, `raw/wang-2024-heterogeneous-snn-learning.md`; full treatment in [[wiki/concepts/neuronal-parameter-heterogeneity.md]]). HIFI — surrogate gradients through the spiking dynamics, no conversion anywhere — reports **95.98% CIFAR-10, 79.32% CIFAR-100 and 69.11% ImageNet at 4 time steps**, above every conversion baseline including QCFS (67.73% ImageNet at 32 steps), and its whole 2021–2024 comparison table (PLIF, Dspike, DSR, GLIF, TET, SLTT, Diet-SNN, OSR, TAB) is spike-native as well. The review's split is a 2019 statement and its "online track never leaves MNIST" half no longer holds ([[wiki/empirical-tensions.md]] T231). What survives of position B: surrogate-gradient BPTT is still **offline, non-local gradient descent** — spike-native in the forward pass, not in the credit assignment — so the row that separates *converted* from *learned in spikes* has moved, while the row separating *offline* from *online* has not.

### The surrogate derivative, concretely

> Kirsanov 2026, *The Smooth Lie That Makes Spikes Learn* (`raw/kirsanov-2026-surrogate-gradients-spikes.md`) — a secondary exposition; everything in this block is marked **(tentative)** where it is not already sourced elsewhere on this page.

The substitution is confined to the backward pass; the forward pass keeps the true Heaviside and the spikes stay binary:

```
forward:   S = Θ(V − V_th)        ∂S/∂V = δ(V − V_th)      ← zero a.e., infinite at threshold
backward:  ∂S/∂V  ←  1 / (1 + β|V − V_th|)²                ← "fast sigmoid" derivative
```

| Requirement on the substitute | Why |
|---|---|
| **Non-zero in a neighbourhood of `V_th`** | Otherwise the chain rule multiplies by zero and nothing reaches the upstream weights — the actual failure mode, since almost every input leaves the neuron away from threshold |
| **Decays with `|V − V_th|`** | Neurons far from threshold should contribute weakly; `β` sets the width and is the only knob |
| **Shape beyond those two** | Reported not to matter much — sigmoid, fast sigmoid, triangular all work **(tentative)** |

**What the true derivative is actually right about.** With `V_th = −50 mV` and a forward pass reaching `−51 mV`, `∂S/∂w = 0` is correct: an *infinitesimal* weight nudge shifts `V` infinitesimally and no spike appears. The surrogate is not a better answer to that question — it answers a different one, about the **finite** step the optimizer will take. This is the cleanest statement of what the whole `τ`-family in [[wiki/concepts/discrete-relaxation-gradients.md]] buys: gradients are used as finite-step direction estimates, so an estimator matched to finite steps can beat the exact infinitesimal one **(brainstorm)**.

**Where this sits among the wrong-backward-operator rules.** A surrogate gradient keeps the exact transposes `Wᵀ` — credit is routed through the true network graph — and falsifies only the *local scalar* derivative at each unit. Feedback alignment does the reverse: exact local derivatives, a random routing matrix `B`. The source offers feedback alignment as an a fortiori argument ("if random projections work, a slightly wrong derivative shape surely works"), and **the wiki's own evidence breaks the analogy**: feedback alignment is 22 top-1 points behind backpropagation on ImageNet and no target-propagation variant beats chance (Bartunov et al. 2018), while surrogate gradients hold the ImageNet spiking leaderboard (Wang et al. 2024). Both substitute a wrong backward operator; only the one that keeps the routing correct scales ([[wiki/concepts/biologically-plausible-credit-assignment.md]]).

---

## Making the unit's own constants parameters

> Wang, Zhang, Li, Dou, Guo & Deng 2024 (`raw/wang-2024-heterogeneous-snn-learning.md`, National Science Review 12(1):nwae301). Full treatment in [[wiki/concepts/neuronal-parameter-heterogeneity.md]].

Every model above shares one `τ_m`, one `V_th` and one `V_reset` across all units, chosen by grid search. HIFI gives each of `K` neurons its own `α^k = [τ^k, γ^k, C^k, u_th^k, u_re^k]` and learns them in a **bi-level program** — weights on a training split, neuron parameters on a held-out split, alternating, with a Laplacian penalty encouraging neighbouring neurons to share parameters. The unit itself is LIF plus a self-inhibiting autapse subtracting `γ^k O^k(t−1)` from the incoming drive.

| | Result for this page |
|---|---|
| **The gain is initialization-insensitivity, not accuracy** | Heterogeneous learning beats homogeneous learning of the same network across every swept `V_th` and `τ` **initialization**, including bad ones. What the mechanism removes is the hyperparameter sweep that [[wiki/concepts/spike-frequency-adaptation.md]] `G78` names |
| **It is separable from the neuron model** | Applying the same bi-level loop to an **SNU**-based network improves that too, so heterogeneity is a training method rather than a property of the autapse |
| **One free parameter per neuron is nearly all of it** | Reducing `α` from 5 degrees of freedom to 1 costs little, and still beats the state-of-the-art baselines — the expensive biophysics buys the last few tenths |
| **The learned constants match measured biology** | Trained membrane time constants and resting potentials recover the recorded distributions for human middle temporal gyrus (`n=236`), mouse V1 layer 4 (`n=164`) and mouse cochlear nucleus (`n=172`) — task optimization landing on the biological distribution rather than importing it |
| **Heterogeneity buys transfer, not only fit** | Best-in-comparison held-out-speaker accuracy on SHD, best SHD↔SSC cross-data-set transfer (where STBP collapses to one class), and correct identification of 0.09%-prevalence cell types in single-cell RNA-seq that two other SNNs and a task-specific ANN all miss |

---

## How many of these units a function costs

> Maass 1997, *Networks of Spiking Neurons: The Third Generation of Neural Network Models* (`raw/maass-1997-spiking-neurons-third-generation.md`) — the origin of the "generations" framing and the only rigorous statement in the wiki of what this substrate buys. Full treatment in [[wiki/concepts/circuit-size-separation.md]].

| Function | Spiking units | Threshold gates | Sigmoidal hidden units |
|---|---|---|---|
| `CD_n` — coincidence detection (`∃i: x_i = y_i = 1`) | **1**, delays only, all weights 1, noise-robust | `≥ n/log(n+1)` | `Ω(n^{1/2})` piecewise-polynomial, `Ω(n^{1/4})` sigmoid |
| `ED_n` — element distinctness (`∃i≠j: x_i = x_j`) | **1**, equal delays, temporal coding | `Ω(n log n)` on the first hidden layer | `≥ n − 1` |
| `ED′_n` — the dendritically realistic version (six EPSPs synchronous across two blocks of three adjacent synapses) | **1** | — | `≥ 1663` at `n = 10 000` synapses |

**Three things this changes on this page.** First, the substrate's proven advantage is **unit count**, not accuracy — and no benchmark in the tables above reports units-to-competence. Second, the advantage is not expressibility: spiking neurons with piecewise-linear postsynaptic potentials simulate any `s`-gate threshold circuit on real-valued input in `O(s)` neurons and approximate any continuous `F: [0,1]^n → [0,1]^k` with **one hidden layer**, so the two classes are mutually simulable and only the constants differ ([[wiki/empirical-tensions.md]] T234). Third, all of it is cashed in **linear temporal coding** (`x_i` ↦ firing time `T_in − x_i·c`), where Eq. 1 makes a firing time an affine function of a weighted sum — so weights keep their generation-1/2 meaning, and the code keeps time-to-first-spike's need for an onset reference ([[wiki/architectural-gaps.md]] G77).

**Postsynaptic-potential shape is a hard boundary inside this substrate.** Rectangular pulses (type A — what pulse-stream neuromorphic hardware natively emits) *cannot* simulate the 3-gate threshold circuit computing `x₁ + x₂ ≤ x₃` on `[0,1]³` at **any** network size or runtime; triangular ones (type B) do it in `O(s)`. The dividing capability is that a continuous PSP shifts a firing time continuously. Type B pays for it with a **synchronization defect**: the slope of `P_v(t)` depends on how many EPSPs arrived, so a layer fed a synchronized boolean volley does not fire synchronously, and multi-layer boolean simulation needs an explicit re-synchronization stage between layers — one that appears in no size bound and in no model on this page.

**The motivating budget argument, which the review-based rows above only gesture at.** Human visual categorization completes in 100 ms over ≥10 synaptic stages (~10 ms per stage), a single visual cortical area completes in 20–30 ms, and the neurons involved fire below 100 Hz — so 20–30 ms is what it costs merely to *sample* one rate. The case against rate coding here is a timing budget, not a plausibility appeal.

---

## Supervised learning directly on spike trains

The unsolved sub-problem is prior to credit assignment: **what is the error between a desired and an observed spike train?** Six answers, and they reduce to two tricks.

| Method | Error definition | Limitation |
|---|---|---|
| **SpikeProp** (Bohte et al.) | Output spike-*timing* error, spike-response-model neurons; hidden units' output modelled as continuous postsynaptic potentials so no spike derivative is ever taken. First backpropagation in an SNN; solves temporally-encoded XOR in 3 layers | Each output unit must emit **exactly one** spike; continuous values become long spike delays |
| **Tempotron** | Binary 0/1 output within a predetermined window | The output carries no timing, so a Tempotron cannot send its output to another Tempotron — the composability failure |
| **Chronotron** | The **Victor–Purpura distance** — minimum cost of transforming one spike train into the other by creating, removing or moving spikes — made piecewise differentiable and used as the cost | Single neuron |
| **ReSuMe** | Widrow–Hoff `Δw ∝ x(y^d − y^o)` reformulated for spikes, which expands to `Δw^STDP(pre, desired) + Δw^aSTDP(pre, observed)`. The teacher has no physical connection to the trained synapse — hence "remote" | Single neuron; constrained to STDP eligibility windows |
| **SPAN** | Widrow–Hoff applied after convolving every spike train with an alpha kernel `t·e^{−t/τ}` — a digital-to-analog conversion of the spike train | Single neuron |
| **Narrow-support gate** (Huh & Sejnowski 2018) | Replace the hard threshold with `g(v) ≥ 0`, `∫g dv = 1`, so postsynaptic current is released as `v` approaches threshold and spike generation becomes continuous | The first of these to free the *number and times* of output spikes from being prespecified; weight updates concentrate near spike times, "bearing close resemblance to reward-modulated STDP" |

**Trick 1 — convert the spike train to a continuous function before differentiating.** Either by a postsynaptic-potential kernel (SpikeProp, SPAN, and the narrow-support gate) or by reading the membrane potential itself as the activation (Lee et al. 2016; Panda & Roy 2016). Every gradient method on this page is one of these two.

**Trick 2 — make a metric on spike trains the loss.** Only the Chronotron does this, and it is the more interesting move: a spike-train *distance* is defined without reference to any neuron model, so the loss survives a change of substrate that the kernel trick does not ([[wiki/concepts/temporal-coding.md]]).

**What none of them supply.** ReSuMe, Chronotron, SPAN and the Tempotron all train **one** postsynaptic neuron from many presynaptic ones. Deep credit assignment in the timing domain is untouched by the whole family.

**Trick 3 — derive the rule instead of positing it** (Gardner & Grüning 2016, `raw/gardner-2016-snn-precise-temporal-encoding.md`; full treatment in [[wiki/concepts/spike-train-error-metrics.md]]). Every entry above is a spike-based reinterpretation of Widrow–Hoff or a hand-made differentiable metric. Start instead from the log-likelihood of emitting a specified train under an exponential escape rate — concave in `w`, because `SRM₀` is linear — ascend it, then take `Δu → 0` to recover a deterministic LIF neuron. Three results this page did not have:

| | Result |
|---|---|
| **The presynaptic eligibility kernel is fixed by the derivation** | It is the postsynaptic **potential** `ε`, not the postsynaptic **current** `α` that SPAN and PSD chose arbitrarily — and SPAN's own grid search had already landed on an α-shaped kernel that closely resembles a PSP |
| **Instantaneous errors fail for a structural reason, not a noise reason** | Phase portrait of `Δw` against `w` for one synapse: the instantaneous rule's attractor sits at `w/ϑ = 1`, the threshold-crossing point, which is a property of the PSP peak and **carries no information about the target time**; the true solution `w*` is a *repeller*. Filtering the postsynaptic error with `τ_q ≈ τ_m` moves the attractor onto `w*` and makes it stable |
| **The choice of error is worth 2× capacity per synapse** | `α_m = p_m/n_i` at 1 ms precision: instantaneous 0.07, filtered (van Rossum) **0.14**, Chronotron 0.15. Below `Δt = 0.8 ms` the instantaneous rule memorises **nothing**, while the filtered rule still holds ≈0.07 at 0.2 ms. Max target spikes per pattern above 90%: 1 / 3 / 4 |

This partly answers `G76` and **contradicts** the reading [[wiki/concepts/temporal-coding.md]] had been carrying — that kernel-smoothing an error makes it rate-like and blind ([[wiki/empirical-tensions.md]] T236). It does not touch "what none of them supply": the derived rule also trains one neuron.

---

## The sixth route: an exact gradient, computed event-based

> Mészáros, Knight & Nowotny 2025 (`raw/meszaros-2025-snn-delay-learning.md`, Nature Communications 16). Full treatment in [[wiki/concepts/learnable-synaptic-delays.md]].

The routes table above has five entries and every one of them either learns outside the spikes (conversion) or approximates the gradient inside them (surrogate derivatives). A sixth exists and belongs in the table: **EventProp** — the adjoint method of optimal control applied to the hybrid dynamics of a spiking network, giving the *exact* gradient of a loss `L = l_p(𝒮) + ∫ l_V(V,t) dt` with a backward pass that is a system of ODEs for the adjoint variables `λ_V, λ_I` plus purely **event-based** transmission of error at saved spike times.

| Property | Consequence for this page |
|---|---|
| **No surrogate anywhere** | The threshold's non-differentiability is handled by splitting the loss integral at spike times, not by smoothing the threshold. The "weight optimization is the central open problem" limitation below is a statement about *approximate* gradients; this route does not need one |
| **Memory does not scale with sequence length** | Surrogate-gradient BPTT stores every neuron state at every timestep, capping trials at a few hundred steps. EventProp stores spike times, so long sequences and fine timesteps are affordable — which is what made 150 ms delay ranges at 1 ms resolution practical |
| **Delays become trainable parameters** | Extending the event set with spike *arrival* times yields `dL/dd_ji = −w_ji Σ_k (λ_I,j − λ_V,j)\|_{t_k+d_ji}` off the same adjoint trajectories, closing the mechanism half of [[wiki/architectural-gaps.md]] `G80` |
| **Multi-layer, multi-spike, recurrent** | This is the family's first deep credit assignment in the timing domain — every rule in the "supervised learning directly on spike trains" section below trains one postsynaptic neuron |
| **Implementable on the hardware** | EventProp has been run on SpiNNaker 2; the GPU implementation (mlGeNN/GeNN) uses a hybrid schedule — neurons updated every timestep, synapses only when a presynaptic spike occurs |

Results with learned delays: **SHD 93.24 ± 1.0%** at ~5× fewer parameters than the delay-line state of the art it matches; SSC 76.1 ± 1.0% with two feedforward hidden layers; Braille letter reading 83.1 ± 1.5%, above the published recurrent model, and 81.0 ± 0.7% at half its parameters. Against dilated-convolution delay learning in PyTorch: **<½ the memory and up to 26× faster**, because the delay range is a per-neuron ring buffer rather than a per-synapse kernel.

**Two cautions this page should carry.** First, exact ≠ complete: EventProp gradients contain no information about spike *creation or deletion*, which is why the SHD/SSC line needs loss shaping and spike-rate regularisation (target 14 spikes per example here) to control training dynamics. Second, the benchmark numbers above are held-out-validated, and the higher published figures on SHD are not — the authors document that leading models select on the test set, and that at `n = 2264` test items the Bayesian confidence intervals for 93%, 94% and 95% overlap. Their own best *observed* test accuracy was 95.32%.

---

## The third option at the rate/spike boundary: don't convert, interface

> Zhao et al. 2022 (`raw/zhao-2022-hybrid-neural-networks-framework.md`, Nature Communications 13:3427). Full treatment in [[wiki/concepts/cross-paradigm-interface.md]].

The routes table above offers two ways to relate a rate network to a spiking one — copy the weights (conversion) or train through the threshold (surrogate gradients). A third keeps **both networks** and makes the boundary a trained module `Y = Q·F·H·W(X)`, with a windowing stage reconciling the two clocks and an intermediate representation belonging to neither side. Three consequences for this page:

| | Result |
|---|---|
| **Streaming beats offline accuracy** | Under real hardware latency and bandwidth on Tianjic chips, a pure ANN tracker falls from 0.85 mIoU offline to **0.33**; the hybrid holds **0.679** by letting an SNN "where" pathway predict only the feature *change* `ΔDF(Δt)` and an interface add it to the ANN's static features. The efficiency argument is finally cashed as accuracy — the SNN's event-driven throughput buys frames the ANN never got to see, which no offline benchmark on this page can express |
| **The substrate can be the *controlled* network, not the computing one** | An ANN backbone emits a per-neuron threshold vector into an SNN branch, and that gate — not any weight protection — is what stops catastrophic forgetting across 40 tasks ([[wiki/concepts/continual-learning.md]]) |
| **A spiking reasoner past MNIST, with nothing learned in spikes** | The HRN scores 91.65 / 95.27 / 85.96 / 78.81% on CLEVRER's four question types with a **hand-authored** graph of integrate-and-fire symbol nodes, Hebbian binding for the object–attribute edges, and all gradient learning in the ANN front ends. A fourth path to the same conclusion as T231, and a different one: the accuracy is not borrowed from a converted rate network, it is borrowed from a designer |

**(brainstorm)** The paper's two claimed substrate wins for the reasoning case do not survive separately. Flat latency in the number of objects is a property of graph propagation, not of spike timing — a rate-valued relaxation over the same graph is equally parallel. Graceful degradation under a corrupted symbol *is* structural, but the structure is the graph's priors, not the spikes. So this result belongs on the ledger as evidence for **graph-shaped execution**, and as a null for T1.

---

## Recurrent SNNs

| Model | Construction | Result |
|---|---|---|
| **LSNN** (Bellec et al. 2018) | Reservoir `R` (excitatory + inhibitory) + module `A` of **adaptive-threshold** excitatory neurons maintaining excitatory–inhibitory balance in `R` + linear readout `Y`; trained by BPTT with membrane-potential pseudo-derivatives | Matches LSTM on **sequential MNIST** (784 pixels delivered one per step) and on TIMIT, and inherits LSTM's ability to learn a function from a teacher *without weight change*, using short-term memory instead |
| **subLSTM** (Costa et al. 2017) | The LSTM's **multiplicative** gates replaced by **subtractive** ones, implementable by lateral inhibition in cortex; rate-coded LIF units so it runs in standard deep-learning frameworks | Matches — never beats — LSTM on sequential MNIST and a language benchmark |
| **Spiking LSTM on TrueNorth** (Shrestha et al. 2017) | Signed values carried on two spike channels; rate coding throughout **except the cell state**, which needed higher precision and got a spike-*burst* code | No accuracy reported; the contribution is the chip mapping |
| **Phased LSTM** (Neil et al. 2016) — not spiking | Adds a **time gate** on an independent oscillation per unit; closed → hidden and cell vectors are frozen, so different units quantize the input at different timescales | Trains faster than a regular LSTM at equal accuracy on event-driven, asynchronously-sampled data |
| **NeuCube** | A 3D reservoir whose connectivity is set by *macro-scale* human structural (DTI) and functional (fMRI) connectivity rather than by a microcircuit model, trained by an STDP-like rule | Proposed as a unifying architecture for multimodal spatiotemporal data (EEG); the claim being made is that the brain's macro connectivity itself has reservoir properties |

**(brainstorm) The recurrent row is the cleanest *negative* evidence for T1 on this page.** subLSTM shows that swapping multiplicative gating for the inhibitory-circuit-implementable subtractive version costs nothing and gains nothing — so *that* piece of the substrate really is implementation detail, which is what position A of T1 predicts and what the spiking TEM result contradicts elsewhere. The two results are compatible only if the substrate matters for **what is represented** (grid codes, phase precession) and not for **how a gate is computed**. That is a sharper statement of T1 than either side currently makes.

**(brainstorm) And the TrueNorth LSTM contains the exception that proves it.** Every variable in that model rate-coded fine *except the cell state* — the one variable that has to be held, not computed, needed a burst code. Precision demands concentrate at the **memory**, which is exactly the wiki's target component ([[wiki/concepts/working-memory.md]]).

---

## Spiking generative models

| Model | Statement |
|---|---|
| **Spiking RBM** (Neftci et al. 2014) | Stochastic integrate-and-fire neurons replace the memoryless stochastic units; a variant of STDP **approximates contrastive divergence**, and the learned distributions capture the same statistical properties as the non-spiking original ([[wiki/entities/boltzmann-machine.md]]) |
| **Spiking DBN** (O'Connor et al. 2013) | A trained DBN converted to LIF neurons for MNIST; later made noise-robust and hardware-constrained. Conversion again — nothing learned in spikes |
| **Hybrid Boltzmann machine ≡ Hopfield network** | An RBM with continuous hidden units and binary visible units is *thermodynamically equivalent* to a Hopfield network once marginalized over the hidden units: `N` visible units ↔ the Hopfield binary neurons, `P` hidden units ↔ the stored patterns. Simulating the same associative memory costs `H·P` synapses instead of `N(N−1)/2` ([[wiki/entities/hopfield-network.md]]) |

---

## Limitations

- **Weight optimization is the central open problem — with one exception.** Backpropagation fails on the discrete, sparse nonlinearity of the threshold; every route above (surrogate gradients, e-prop, evolutionary search, plasticity rules) is a workaround with its own cost. The exception is the adjoint route: EventProp computes the *exact* gradient by splitting the loss at event times rather than smoothing the threshold, at the price of being offline, non-local, and blind to spike creation and deletion ([[wiki/concepts/learnable-synaptic-delays.md]]).
- **e-prop is blind to the future.** It requires a real-time error signal at each time step and cannot learn from delayed errors extending beyond individual-neuron timescales — unlike REINFORCE / node perturbation, which handle exactly that case.
- ~~**The accuracy leadership belongs to networks that never learned in spikes.**~~ **Superseded for the accuracy half, kept for the locality half.** As of Tavanaei et al. 2019 the best deep SNNs were ANN-to-SNN conversions and nothing spike-native was reported past MNIST; by 2024 the leaderboard on CIFAR-10/100 and ImageNet is entirely surrogate-gradient and beats conversion at 4–8× fewer time steps (Wang et al. 2024). The claim that still holds is narrower: those gradients are computed offline, non-locally, by backpropagation through time — so the accuracy is evidence about spiking **inference and spiking forward dynamics**, and still not about *local* or *online* spiking learning ([[wiki/empirical-tensions.md]] T231).
- **Most "deep" spiking hierarchies have one trainable layer.** Depth of processing has been repeatedly reported as depth of learning; the preprocessing + single-STDP-layer + classifier shape is a reservoir, not a deep network.
- **No error metric on spike trains is agreed on (gap G76).** Eight proposals exist (timing error, Victor–Purpura distance, alpha-kernel regression, Widrow–Hoff as STDP+anti-STDP, instantaneous and filtered maximum-likelihood, …), one of them derived rather than posited, and all of them train a *single* neuron ([[wiki/concepts/spike-train-error-metrics.md]]). **The single-neuron half of that complaint is spent**: the adjoint route trains hidden layers, recurrent connections and multiple spikes per neuron with an exact gradient — but its non-toy experiments all use a first-spike latency or a max-voltage objective, so a *train distance* has still never been backpropagated through depth.
- **Some surrogate derivatives are not local, which voids the reason for using them.** Using the presynaptic membrane potential as the substitute derivative makes the update depend on a quantity not available at the synapse (Tavanaei et al. 2019) — such a model keeps the engineering benefit and loses the biological argument entirely.
- **Early stage.** The review classifies SNNs as not yet ready for wide use.
- **The efficiency case is partly an artefact of the substrate.** On dense synchronous hardware, sparse binary events are not cheap; the advantage is contingent on neuromorphic deployment.

---

## Comparison

| | ANN (rate) | SNN (event) |
|---|---|---|
| Message | Real-valued activation | Binary spike + its time |
| Time | Absent unless architecturally added (recurrence, positional codes) | Intrinsic to the unit |
| Data assumption | i.i.d., timeless | Temporally and spatially correlated — the physical case |
| Learning after training | None | Native, via local plasticity |
| Credit assignment | Backpropagation | Surrogate gradients / e-prop / plasticity / evolution |
| Energy | High; a practical barrier at scale and on edge devices | Low on matched hardware |
| Directional edge detection | Requires an architectural mechanism | Free — the STDP sign flip at `Δt = 0`, over a measured ±20 ms with a ~5 ms transition zone. Stronger than a timing lookup: on a synapse strong enough to drive the postsynaptic spike, the *caused* spike sets the sign and an injected anti-causal spike 10 ms earlier is overridden (+31.9 ± 9.3%; Bi & Poo 1998) |

**(brainstorm)** The last row is the one that should interest this wiki most. A latent graph's edges are *directed*, and the cheapest known detector of "A caused B" rather than "A correlates with B" is a temporal asymmetry. A rate-coded network has to learn directionality as content; a spiking network gets it from the substrate. That is a candidate answer to the T1 question about what the implementation level buys — and it is an argument nobody in the reviewed literature appears to make.

---

## Connections

- **[[wiki/entities/hag-reservoir.md]]** — why a non-negative-weight constraint is worth accepting on this substrate: hardware realising only positive weights otherwise needs `w = w⁺ − w⁻` differential pairs (double the devices), and grown excitatory-only connectivity recovers the decorrelation the missing sign would have supplied.
- **[[wiki/concepts/synaptic-plasticity.md]]** — STDP is defined on spike times, so the rule family and this substrate presuppose each other; the substrate is what makes the timing term meaningful. It also holds the measured curve (Bi & Poo 1998) and the three dependencies the `Δw(Δt)` equation omits — current weight, postsynaptic cell type, and whether the synapse actually caused the spike — each of which changes what a spiking implementation gets for free.
- **[[wiki/concepts/temporal-coding.md]]** — the quantitative case for this page's central claim, plus its ceiling: 20–25 µs single-unit precision from a 250 µs postsynaptic potential, but behaviour-level 5 µs only after population-vector decoding over ~100 units and 100 ms, so the single spike time is not the message even here.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — SNNs are the hard case that forces the issue: backpropagation does not merely lack a biological story here, it fails outright on the discrete nonlinearity, so local rules are mandatory rather than optional.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — surrogate gradients let the outer loop reach into a spiking inner loop, producing this substrate's strongest result (online one-shot learning).
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the test case for that page's implementation-level exclusion: SNNs claim the excluded level carries information a functional specification cannot express.
- **[[wiki/concepts/latent-graph-discovery.md]]** — offers a substrate-level primitive for *directed* edges (temporal asymmetry) that rate-coded architectures must learn as content.
- **[[wiki/entities/spiking-tem.md]]** — this substrate's strongest evidence for T1: a whole cognitive-map architecture trained in spikes, whose ablation table shows three substrate-only mechanisms (theta-phase inhibition, STDP, a learnable neuromodulatory gain) are each necessary for a structural code that the rate-based original obtains without any of them — so here the implementation level is not detail, it is the cause.
- **[[wiki/entities/aixi.md]]** — the opposite pole of the specification/implementation axis: AIXI is a substrate-free optimality specification with no implementation, spiking networks are an implementation-first commitment with no optimality guarantee.
- **[[wiki/entities/fly-central-complex.md]]** — the density argument met from biology: a complete heading compass — anchoring, angular integration and >30 s persistence — in a few dozen identified neurons, which is the scale claim this substrate makes and rarely gets to demonstrate.
- **[[wiki/concepts/dendritic-computation.md]]** — a computation a spiking substrate gets for free and a rate model must add by hand: the dendritic segment detects `θ` co-active synapses within a 1–5 ms window, which is a spike-timing coincidence test, and its 50–200 ms plateau is a state variable no rate unit carries.
- **[[wiki/entities/dendritic-ann.md]]** — the argument for why a *handcrafted* sparse graph is the neuromorphic-friendly one: connectivity fixed before training needs no pruning phase and its absent connections can simply be omitted in hardware, turning a parameter saving into an energy and area saving (Chavlis & Poirazi 2025).
- **[[wiki/entities/hodgkin-huxley-model.md]]** — the substrate this page abstracts away: LIF is the Hodgkin–Huxley membrane equation with the three gating variables deleted and the spike restored by hand, so the efficiency case here is bought by discarding multiplicative conductance input, reversal-bounded saturation and the inactivation state — a T1 concession made silently inside the unit.
- **[[wiki/entities/btsp-cam.md]]** — the clearest case in the wiki of a biological rule being *cheaper* in hardware rather than merely more plausible: a local, two-state, one-shot write rule is what memristor crossbars can run on-chip, where Hopfield-style content-addressable memory needs off-chip training and many distinguishable resistance states (which caps existing implementations below ~1000 stored patterns).
- **[[wiki/entities/stsp-working-memory-rnn.md]]** — where the efficiency argument becomes load-bearing rather than rhetorical: LSTM and GRU beat plastic-synapse networks on both robustness measures while being the least brain-like, so the functional case for the biological mechanism reduces to metabolic cost (spikes are needed only to read the store, not to hold it) and to structural robustness.
- **[[wiki/entities/hami.md]]** — the same neuromorphic constraint pointed at the memory array instead of the compute: a fixed-width discrete key makes episodic retrieval a single-cycle non-volatile content-addressable-memory search (2T2R RRAM/MRAM/PCM/FeFET), which is an argument that the format of the store, not the spiking of the units, is where the energy and latency win lives (Poursiami et al. 2025).
- **[[wiki/entities/simple-cycle-reservoir.md]]** — the deployment argument this page's efficiency case needs, with a proof attached: a ring of identical weights driven by `±1` input signs stores no weights at all and maps directly onto photonic and delay-line neuromorphic substrates, and Li, Fong & Tiňo 2024 show the constraint costs no expressivity over fading-memory filters — only device count.
- **[[wiki/entities/ltc.md]]** — the non-spiking half of the same biophysics, and a T1 datum from an unusual direction: the LTC equation *is* the graded-potential *C. elegans* neuron with conductance synapses (`dv/dt = −g_l v + f(v,I)(A − v)`), so the imported detail is the reversal potential in the driving force — which has no rate-model description, is what produces the model's state-stability theorem, and makes its neuromorphic deployment (sparse LTCs as Neural Circuit Policies on Loihi-2) a return to the substrate rather than a port to it.
- **[[wiki/entities/boltzmann-machine.md]]** — the generative half of this substrate, and its cleanest equivalence result: stochastic integrate-and-fire units replace the memoryless stochastic ones, and a variant of STDP approximates contrastive divergence closely enough that the learned distributions carry the same statistics as the non-spiking machine (Neftci et al. 2014).
- **[[wiki/entities/hopfield-network.md]]** — a synapse-count argument that arrives from the spiking-generative side: the hybrid Boltzmann machine is thermodynamically equivalent to a Hopfield network with stored patterns as hidden units, so the same associative memory costs `H·P` synapses instead of `N(N−1)/2`.
- **[[wiki/concepts/autonomous-pattern-generation.md]]** — the shape most "deep" SNNs actually have: many processing layers, one trainable layer, linear readout. Reservoir models make that structure explicit and prove what it can express; the STDP hierarchies inherited it without saying so.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — what the liquid state machine was built to model: a recurrent excitatory/inhibitory reservoir with ~80:20 ratio and distance-decaying connection probability, offered as the computation running inside the cortical minicolumn — and NeuCube's rival claim that it is the *macro*-scale connectome, not the microcircuit, that has reservoir properties.
- **[[wiki/concepts/working-memory.md]]** — where the substrate's precision demand concentrates: in the TrueNorth spiking LSTM every variable rate-coded acceptably except the **cell state**, which needed a burst code — so the maintenance component, not the compute, is what a coarse spiking code fails first.
- **[[wiki/entities/arc-vsa-solver.md]]** — the substrate claim carried by the vector-symbolic line: the same bind/superpose algebra is implementable in spiking neurons (Neural Engineering Framework, Spaun), which is what "cognitively plausible" is doing in that solver's argument — though the solver itself is not spiking.
- **[[wiki/concepts/spike-encoding-schemes.md]]** — the input stage this page's architecture table leaves blank, and the reason two of its rows need re-reading: the conversion route's accuracy lead belongs to the **count rate** code specifically (the only scheme equivalent to a ReLU activation), while the same converted networks re-coded as time-to-first-spike or phase preserve accuracy at fewer spikes and lower latency — so code and training route are separable choices the literature has been varying together — which is also why no published accuracy comparison can arbitrate between codes ([[wiki/empirical-tensions.md]] T232; Auge et al. 2021).
- **[[wiki/concepts/spike-frequency-adaptation.md]]** — the one edit to this page's LIF unit that moves its own numbers: an activity-dependent threshold gives the LSNN row its LSTM-matching sequential-MNIST and TIMIT results and a 1200 ms store-and-recall, it supplies a slow path that mitigates the vanishing gradient this substrate otherwise suffers, and at network level it costs a constant `+11` to `+19` arithmetic operations that does not scale with fan-in (Ganguly et al. 2024).
- **[[wiki/concepts/circuit-size-separation.md]]** — the only rigorous account of what this substrate buys, and a correction to how this page states it: the proven advantage is `Ω(n)` fewer *units* on coincidence-type functions (`≥1663` sigmoidal hidden units for what one neuron does at 10,000 synapses), not a function a rate network cannot express — and postsynaptic-potential shape turns out to be a hard boundary, with rectangular pulses unable to simulate a 3-gate threshold circuit on analog input at any size (Maass 1997).
- **[[wiki/entities/liquid-state-machine.md]]** — the first stable, generally applicable method for getting complex real-time computation out of a *generic* recurrent circuit on this substrate, and the origin of the reservoir shape that recurs throughout this page (LSNN, NeuCube): fix nothing, train nothing inside the circuit, and fit memoryless readouts to the exponentially-filtered spike trains. It also supplies this page's sharpest measurement of what dynamic synapses buy — removing them at matched firing rate costs the circuit everything but the last 250 ms of its memory.
- **[[wiki/concepts/cross-paradigm-interface.md]]** — the alternative to conversion, and the only construct in the wiki that treats the rate/spike boundary as a module with its own parameters and its own objective: it is what lets this substrate's event-driven throughput and a rate network's precision appear in one system instead of forcing a choice between them.
- **[[wiki/concepts/continual-learning.md]]** — the interference problem met at this substrate's own control port: a spiking neuron's threshold gates whether it can participate at all, so raising it protects whatever it holds without an importance estimate, a replay buffer or a weight penalty.
- **[[wiki/concepts/spike-train-error-metrics.md]]** — the sub-problem this page names and does not own: what the error between two spike trains *is*. It consolidates the eight proposals listed above, adds the only one derived from a likelihood rather than reinterpreted from Widrow–Hoff, and prices the choice — 2× stored patterns per synapse, and the entire difference between sub-millisecond output coding working and returning zero capacity.
- **[[wiki/entities/spiking-hippocampal-cam.md]]** — the substrate cashed as a *capability* rather than as efficiency, and in an unusual place: a memory whose four operations are demultiplexed by a 1 ms delay comparison between two input volleys, so the opcode is coincidence detection — the one function this page prices at one spiking unit against `Ω(n)` sigmoidal ones — applied to memory control instead of to classification (Casanueva-Morato et al. 2024).
- **[[wiki/concepts/neuronal-parameter-heterogeneity.md]]** — the edit that makes this page's architecture table's constants into parameters: `τ`, `C`, `v_th`, `v_reset` and a self-inhibition gain become a per-neuron vector learned in a bi-level program on a held-out split, which is what supplies this page's first spike-native results past MNIST (69.11% ImageNet at 4 time steps) and, more usefully, removes the sensitivity to the `τ`/`v_th` initialization that every other model here resolves by grid search.
- **[[wiki/concepts/learnable-synaptic-delays.md]]** — the sixth route into this page's routes table and the only exact one: the adjoint method applied to the network's hybrid dynamics, with a backward pass whose synaptic work is event-based and whose memory does not scale with sequence length, which is what makes it the only gradient method here that is also a *neuromorphic* algorithm rather than a GPU one. It also adds a parameter this page's architecture table does not have — the per-synapse transmission delay — and reports the units-to-competence trade the efficiency rows never do: matched SHD accuracy at ~5× fewer parameters.
- **[[wiki/entities/sigma-pi-reservoir.md]]** — what Loihi 2's programmable neuron engine and 24-bit graded spikes actually buy: a *Pi* neuron (product of two accumulated channels) alongside the usual Sigma neuron, which is enough to run vector-symbolic binding on-chip and therefore to carry a compositional structure over an event-based fabric — with the representation chosen *because of* the chip's sparsity preference (sparse block codes at `K=10`, `L=20`, `D=200`) and on-chip results tracking their CPU counterparts closely.
- **[[wiki/concepts/analog-in-memory-computing.md]]** — the other neuromorphic substrate, and the one that constrains *learning* rather than execution: weights live in ≈4-bit drifting analog devices whose write energy dominates, so this page's local-rule requirement is re-derived from physics — and the surprise is how little the substrate costs, a full recurrent SNN adapting on-chip in one update at a few centimetres of end-effector error, with meta-training done in software at full precision and no device model anywhere in the loop.
- **[[wiki/concepts/mean-field-reduction.md]]** — the escape route from this page's level, priced item by item: replacing the spiking population with its state density makes the dynamics linear and deterministic however chaotic the neurons are, at the cost of assuming afferent currents are uncorrelated, and the further collapse to a neural mass discards all coupling between moments while *gaining* a degree of freedom that makes chaos expressible. The reduction is a menu of trades, not a series of approximations to a ground truth (Deco et al. 2008).
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — why this substrate is where multi-modulator proposals are written: the effective control variable in striatum is a *phase relationship* between dopamine and acetylcholine waves, which a rate-coded network cannot express at all, and the reviewed conceptual model is accordingly a spiking actor–critic with an R-STDP third factor plus a surprise-triggered second modulator (Mei et al. 2025).
- **[[wiki/entities/ch-hnn.md]]** — the substrate carrying the incremental half of a hybrid continual learner: 60.82% less power than the rate equivalent on a cycle-accurate Tianjic-class simulator, float32 → int8 at little cost, and a monotone benefit from neuron-model complexity (EIF > LIF > IF) at the task level — with the EIF's exponential term costing only 8.35–8.58% extra power via a look-up table.
- **[[wiki/concepts/discrete-relaxation-gradients.md]]** — the same manoeuvre arrived at independently in another literature: this page's surrogate gradients smooth a threshold crossing exactly as Gumbel-Softmax smooths an argmax, which makes EventProp's exact event-based adjoint the dissenting position of [[wiki/empirical-tensions.md]] T298 rather than a spiking-specific detail. The general recipe stated there — replace the derivative and only the derivative — makes this page's fast-sigmoid `1/(1+β|V−V_th|)²` one instance of a five-literature family.
