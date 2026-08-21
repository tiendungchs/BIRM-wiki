# Spike-Frequency Adaptation (SFA)

**A neuron's own recent firing raises its threshold (or subtracts a current), so the inter-spike interval grows under sustained drive — one extra slow state variable per unit, which turns out to be enough to hold a 1200 ms working memory with no recurrent weight change and no persistent firing.**

> **Provenance.** `raw/ganguly-2024-spike-frequency-adaptation.md` — Ganguly, Bezugam, Abs, Payvand, Dey & Suri, *Spike frequency adaptation: bridging neural models and neuromorphic applications*, Communications Engineering 3:22, 2024. A review; every number below is quoted from the works it surveys, and it reports no experiment of its own except the LIF-vs-ALIF illustration (14 spikes vs 9 for the same 1000 Hz Poisson drive over 150 ms).

The wiki already used SFA twice as a **destabiliser** ([[wiki/entities/adaptive-cann.md]], [[wiki/entities/trnn.md]]) — the same equation subtracted from the drive to stop a bump or a unit from persisting. This page holds the opposite reading, which is the one the neuromorphic literature is built on: the adaptation variable *is* the store ([[wiki/empirical-tensions.md]] T233).

---

## The biology, and its substrate degeneracy

Prolonged stimulation produces a strong onset response then a lengthening ISI. **Three distinct mechanisms produce the same signature:**

| Cause | Locus | Effect on the input–output map |
|---|---|---|
| Short-term depression — synaptic vesicle pool depletion | Presynaptic | Input current itself shrinks ([[wiki/concepts/synaptic-plasticity.md]]) |
| Ca²⁺-activated K⁺ conductance raising the spike threshold | Postsynaptic, intrinsic | **Subtractive** on the input current: the same current no longer fires the cell |
| Delayed lateral and feedback inhibition | Network | Excitation is cancelled after a lag ([[wiki/concepts/inhibitory-control-of-coding.md]]) |

**Prevalence (Allen Institute intracellular data):** SFA in **~20%** of excitatory neurons in mouse visual cortex, **~40%** in human frontal lobe. The review states the gradient and does not interpret it.

**(brainstorm)** The gradient runs the way the wiki's target problem does — twice as much single-cell slow memory in the human associative frontal lobe as in mouse early sensory cortex. If the adaptation variable is a memory (below), then the fraction of cells carrying one is a *measured* estimate of how much of a region's substrate is doing maintenance rather than transformation, available per-area and per-species. Nothing in the wiki uses a number of that kind.

**The degeneracy is an unexploited design fork.** The review's own roadmap names it as open: whether the SFA is implemented as an intrinsic threshold change, as inhibitory input, or as short-term synaptic depression changes *nothing* about the ISI signature and everything about what else the mechanism touches — an intrinsic change is private to the cell, an inhibitory one is shared by every cell the interneuron reaches, a presynaptic one is specific to one incoming axon. The wiki's models pick one silently: [[wiki/entities/stsp-working-memory-rnn.md]] takes the presynaptic route, A-CANN and TRNN the intrinsic one.

---

## Model taxonomy — sorted by number of adaptation state variables

All variants keep the LIF membrane equation `τ du/dt = −(u − v_rest) + R·I(t)` and differ only in what happens to the threshold or to an added current.

| Model | Adaptation state | Update | Arithmetic ops / iteration (isolated neuron) |
|---|---|---|---|
| **LIF** (baseline) | none — fixed `v_th` | — | 10 |
| **Adaptive LIF (ALIF)** | 1 threshold variable `θ(t)`, single exponential `τ_θ` | `v_th(t) = v_th⁰ + θ(t)`, `θ` jumps at each output spike and decays | `6F + 10` |
| **DEXAT** (Shaban et al. 2021) | 2 threshold variables `b_1, b_2` with `τ_b1, τ_b2` and weights `β_1, β_2` | `v_th = v_th⁰ + β_1 b_1 + β_2 b_2` | 29 |
| **Multi-timescale adaptive threshold** | `L` exponentials | `v_th(t) = Σ_i H(t − t_i) + v_rest`, `H(t) = Σ_j α_j e^{−t/τ_j}` | `5LF + 10` |
| **AdEx LIF** | `N_ad` adaptation **currents** `w_k` (not thresholds) + exponential spike-onset term `Δ_T e^{(u−v_th)/Δ_T}` | `τ_k dw_k/dt = a_k(u − v_rest) − w_k`, `w_k ← w_k + b_k` at spike | `2N_ad F + 7N_ad + 13` |
| **SRM** | Filters, not ODEs: `η(t)` refractory kernel, `θ(t)` threshold kernel | `u(t) = Σ_{f∈F} η(t − t^f) + Σ_j w_j Σ_g ε(t − t_j^g) + ∫k(s)I(t−s)ds` | `2NF + 8F_p N` |
| **GLIF-I…V** (Allen Institute) | I: none · II: +spike-induced threshold `θ_s` and multiplicative reset `f_v` · III: +after-spike Na⁺/K⁺ currents `I_j` · IV: II+III · V: +subthreshold-voltage-induced threshold `θ_u` | see review Eqs. 21–25 | 10 / 13 / `4N_ad+10` / `4N_ad+14` / `4N_ad+24` |

`F` = spikes emitted by the target neuron in the interval, `F_p` presynaptic spikes, `N` presynaptic count, `N_ad` adaptation variables, `L` kernels.

**Read the cost column against the network-level one.** When the same neurons are wired into a network (input current from Eq. 3 rather than injected), the whole spread collapses: LIF `2N + 6`, ALIF/LSNN `2N + 17`, DEXAT `2N + 25`, Yin et al. `2N + 18`. **Adaptation is a constant additive cost that does not scale with fan-in** — for any realistic `N` the entire model family is within a few percent of LIF. The review's caveat stands (op counts do not track energy linearly, which depends on memory access), but it cuts the same way: SFA *reduces* spike count, and each avoided spike is an avoided synaptic memory access in the next layer, which is the expensive half.

---

## The result that matters here: adaptation as a working-memory store

| Finding | Number | Source (via review) |
|---|---|---|
| RSNN + adaptive neurons (**LSNN**) matches LSTM | 93.7% sequential MNIST, 66.7% TIMIT | Bellec et al. 2018 |
| STORE-RECALL over a **1200 ms** delay | 95% classification in 50 training iterations | Bellec et al. 2020 |
| Single-exponential ALIF needs `τ_a ≈` the memory span | `τ_a = 1200 ms` for a 1200 ms delay | Salaj et al. 2021 |
| **DEXAT reaches the same span with far shorter constants** | `τ_b1 = 30 ms`, `τ_b2 = 300 ms`; raising `τ_b2` to 500 ms converges *faster still*; 10 LIF + 10 DEXAT neurons suffice | Shaban et al. 2021 |
| DEXAT on sequence tasks | 96.1% SMNIST, 91% Google Speech Commands | Shaban et al. 2021 |
| Two hidden GLIF-II layers with **different** adaptation constants per layer | 92.1% GSC; 85.9% ECG waveform classification | Yin et al. 2021 |
| After-hyperpolarising-current variant | 96.09% SMNIST | Rao et al. |
| Adaptive conductances as a language working memory | memory span scales with the adaptation time constant *and* with baseline excitability; **long adaptation produces interference between items** | Fitz et al. (via review) |

**Three architectural claims fall out, and they are the reason this page exists.**

1. **Memory span is decoupled from the slowest time constant.** The naive reading of a leaky store is that holding `T` costs a time constant of order `T`; ALIF obeys it, DEXAT breaks it — 30 ms and 300 ms hold 1200 ms. Two coupled exponentials are not a slower exponential; they are a *different filter*, and the span comes from the interaction, not from either constant. The price is four hyperparameters instead of two.
2. **The store is read without a retrieval operation.** In the adaptive-conductance account, the memory *is* the reduced firing rate — nothing addresses, matches or completes a pattern. Compare every other store in the wiki ([[wiki/concepts/working-memory.md]], [[wiki/concepts/pattern-separation-completion.md]]): all of them separate write from read. Here the read is the neuron's ordinary response to its next input.
3. **Capacity trades against span through interference.** Longer adaptation → longer span → more interference between items, from the same variable. This is the same shape as the separation/completion bias ([[wiki/architectural-gaps.md]] G38) and is set here by a *time constant* rather than a sparsity level.

---

## SFA as a training aid, not just a representation

SFA supplies a **slow path through the adaptive threshold in the gradient computation**, which is credited with mitigating the vanishing gradient in liquid state machines and RSNNs (Salaj et al. 2021). Two consequences:

- It is one of the few cases in the wiki where a **substrate detail fixes an optimisation problem** rather than creating one — the usual direction for spiking models is the reverse ([[wiki/entities/spiking-neural-networks.md]]: the threshold nonlinearity breaks backpropagation). Evidence for position B of [[wiki/empirical-tensions.md]] T1 from an unexpected side: the mechanism is inexpressible in the rate specification and it changes what is *learnable*, not only what is representable.
- **It degrades with depth, and for a mechanical reason.** As layers are added, fewer spikes exhibit SFA, so the SFA-based pseudo-gradient becomes costly and less effective (review, "Learning algorithms and adaptive neurons"). The mechanism that makes the network trainable is fed by the spikes the mechanism itself suppresses.

Training rules actually used with adaptive neurons: BPTT with membrane-potential pseudo-derivatives (Bellec, Shaban, Yin), **e-prop** as the online alternative ([[wiki/concepts/biologically-plausible-credit-assignment.md]]), and unsupervised STDP variants where the adaptive threshold is homeostatic instead — Diehl & Cook's 95% MNIST at 6400 neurons, Querlioz et al.'s 93.5% with adaptive threshold + lateral inhibition tolerating 50% device-parameter variation, SWAT (BCM+STDP) at 95.3%/96.7%/95.25% on Iris/Wisconsin/TI46.

**The homeostatic reading is the third use of the same variable.** In Diehl & Cook and Querlioz et al. the adaptive threshold's job is to stop any one output neuron winning every stimulus — it is a firing-rate regulariser enforcing division of labour, not a memory and not a destabiliser. One equation, three jobs, distinguished only by the ratio of `τ_θ` to the task timescale.

---

## Hardware

| Route | Status |
|---|---|
| **Multi-compartment LIF on COTS chips** | The standard workaround: build an SFA neuron from several LIF compartments. Costs neuron count, which is the resource being saved (Bezugam et al. — reduced neuron count demonstrated) |
| **Native ALIF in silicon** | Intel **Loihi-2** adds ALIF models directly |
| **CMOS analog AdEx / Mihalas–Niebur circuits** | Widely reported |
| **Digital / FPGA** | Quantised DEXAT threshold circuits; a **pre-synaptic-spike-driven architecture** that cuts resource use and event-caching buffer size at equal task performance |
| **Emerging NVM** | RRAM, PCM, CBRAM; also superconducting and 2D-material devices showing SFA intrinsically. The key claim: the **nonlinear conductance change of the device *is* the threshold adaptation** — no capacitor, and the adaptation time constant is tuned by programming current |
| **Simulators** | AdEx: PyNN, BRIAN2, NEST. ALIF for recurrent SNNs: Neko, FABLE, Norse (PyTorch-based, membrane voltage and threshold as per-step state) |

**(brainstorm) The NVM row is the strongest form of the neuromorphic argument in the wiki.** Elsewhere the case is that a biological rule is *cheap* on the substrate ([[wiki/entities/btsp-cam.md]], [[wiki/entities/hami.md]]). Here the device's parasitic nonlinearity — normally an error to be calibrated away — is exactly the function wanted, so the mechanism costs *negative* area. That inverts the usual plausibility-vs-efficiency framing: the biological detail is not tolerated, it is free and its analog counterpart in a rate model would have to be simulated.

---

## Open problems

- **Nothing sets the adaptation time constants** ([[wiki/architectural-gaps.md]] G78). `τ_θ` (or the four DEXAT parameters) fixes memory span, interference, and gradient flow, and is chosen by grid search; the review proposes Bayesian or gradient-based optimisation as future work. A store whose capacity is a hand-tuned hyperparameter cannot meet a task whose span is discovered at run time.
- **The encoders do not match the neurons.** Poisson, rate and population encoding "struggle to capture the complex dynamics inherent to SFA". SFA neurons are *more* timing-sensitive than LIF ones, so small presynaptic jitter that a non-adaptive neuron absorbs causes information loss here — which sharpens [[wiki/empirical-tensions.md]] T232: the choice of code is not independent of the neuron model reading it, and the jitter-fragility measured for rank-order coding compounds with the jitter-fragility of the adaptive unit.
- **SFA and sparsity conflict.** Sparse connectivity means low input firing, which is precisely the regime where an adaptation variable never charges. *Where* in a network SFA neurons should sit is stated as an open selection problem, unanswered.
- **Adaptation across layers is unstudied.** How adaptation in one region propagates to and shapes computation downstream — the review's own listed unknown, and the question a hierarchical reasoning architecture would have to answer first.
- **Learning rules ignore most of what SFA does.** Temporal sensitivity, adaptation to input statistics, and independent firing transitions are all absent from every learning rule used with these neurons; BPTT and e-prop see the adaptive threshold only as another differentiable state.
- **Claimed but untested transfers.** The review lists SFA as a candidate for adversarial robustness ("selective responsiveness … acting as a form of firewall"), for regularisation against overfitting, and for meta-learning against catastrophic forgetting ([[wiki/concepts/continual-learning.md]]). None has an experiment attached — record them as hypotheses, not findings.

---

## Connections

- **[[wiki/entities/spiking-neural-networks.md]]** — this is the one modification to the LIF unit that changes the results on that page's own benchmarks: LSNN's LSTM-matching sequential-MNIST and TIMIT numbers, and its 1200 ms store-and-recall, come from the adaptive threshold rather than from the recurrence, and the extra cost is a constant `+11` to `+19` arithmetic operations that does not scale with fan-in.
- **[[wiki/entities/trnn.md]]** — the same equation with the opposite intent: there `V` is a low-pass copy of the unit's activity subtracted from its drive to *prevent* persistence and force a moving trajectory, here the identical variable is the medium the memory is stored in ([[wiki/empirical-tensions.md]] T233).
- **[[wiki/entities/adaptive-cann.md]]** — the destabiliser reading again and with a threshold attached: `m > τ/τ_v` turns the bump into a travelling wave, which says the memory/destabiliser distinction is a *parameter regime* of one mechanism, not two mechanisms — the quantitative form of the tension this page opens.
- **[[wiki/concepts/working-memory.md]]** — a third maintenance design beside persistent firing and activity-silent synaptic traces: the store is a per-cell slow conductance, and it is read with no retrieval operation at all, because the memory *is* the depressed firing rate the next input meets.
- **[[wiki/concepts/synaptic-plasticity.md]]** — one of the three biological causes of SFA is presynaptic vesicle depletion, so short-term depression and spike-frequency adaptation are the same functional variable measured at different ends of the synapse; which end it sits on decides whether the adaptation is private to a cell or specific to one incoming axon.
- **[[wiki/concepts/memory-allocation-excitability.md]]** — the same K⁺ conductance seen from the write side: CREB *reduces* SFA to tag a cell for the next memory, so allocation and adaptation are opposite manipulations of one knob, and a network using SFA as a store is spending the variable the allocation mechanism wants to spend.
- **[[wiki/concepts/spike-encoding-schemes.md]]** — the encoder problem does not survive the swap to adaptive units: Poisson, rate and population coding are named as inadequate for SFA dynamics because an adaptive neuron's elevated timing sensitivity converts small presynaptic jitter into information loss, so the choice of code cannot be made independently of the neuron model.
- **[[wiki/concepts/temporal-coding.md]]** — SFA is a timing mechanism with no reference problem: the adaptation variable measures the neuron's own recent ISIs, so it is self-referenced by construction, which is exactly the property [[wiki/architectural-gaps.md]] G77 says the high-performing global codes lack.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — where the substrate helps rather than hinders: the adaptive threshold provides a slow path through the gradient computation that mitigates vanishing gradients in recurrent SNNs and liquid state machines, and e-prop is the online rule paired with it — but the effect thins with depth, since deeper layers emit fewer of the spikes the mechanism runs on.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the network-level cause of SFA (delayed lateral and feedback inhibition) and its homeostatic use (Diehl & Cook, Querlioz et al.: adaptive threshold + lateral inhibition forcing different output neurons onto different stimuli) are the same mechanism used to enforce division of labour rather than to store anything.
- **[[wiki/entities/stsp-working-memory-rnn.md]]** — the presynaptic sibling: that model holds a memory in short-term synaptic facilitation, this one in a postsynaptic conductance, and the review states the two are interchangeable as SFA substrates — so the wiki's activity-silent-memory argument is not specific to synapses.
- **[[wiki/concepts/continual-learning.md]]** — a claimed but unmeasured application: adaptive thresholds are proposed as a way to discern patterns shared across tasks and so resist catastrophic forgetting; there is no experiment behind it and it is recorded here as a hypothesis.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the relevance to the target: SFA gives a unit a private, self-referenced timescale, so a network of adaptive units carries a *distribution* of timescales without any architectural hierarchy — a candidate substrate for holding partial paths through a graph while the traversal continues elsewhere **(brainstorm)**.
- **[[wiki/concepts/cross-paradigm-interface.md]]** — the same variable, driven from outside: a separate rate network emits the threshold vector as a *task* gate rather than letting the neuron's own firing set it, which yields the continual-learning result this page proposes and does not measure — and raises the question the two readings share, how a neuron using its threshold as a store would keep that use separate from a controller writing the same variable (T233).
