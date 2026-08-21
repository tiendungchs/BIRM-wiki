# Liquid State Machine (LSM)

**A computational model in which a generic, untrained, high-dimensional recurrent circuit is used *as a filter* — its continuously-changing transient state, never a stable one, is the memory — and all task-specific content lives in memoryless readouts trained on top of it. Universal for time-invariant fading-memory filters on continuous time and on spike trains, given two properties: separation in the liquid and approximation in the readout.**

> **Provenance.** `raw/maass-2002-liquid-state-machine.md` — Wolfgang Maass, Thomas Natschläger & Henry Markram, *Real-Time Computing Without Stable States: A New Framework for Neural Computation Based on Perturbations*, Neural Computation 14:2531–2560, 2002. Two theorems (proved via Stone–Weierstrass, sketched only) plus simulations of a 135-neuron integrate-and-fire column. The independently-discovered artificial-network twin is Jaeger's echo state network (2001), cited here as concurrent.

The wiki has held this architecture's *shape* on several pages ([[wiki/concepts/autonomous-pattern-generation.md]], [[wiki/entities/simple-cycle-reservoir.md]], [[wiki/entities/hag-reservoir.md]]) and referred to "the liquid state machine" without a page. This is the original, and it is the only version of it whose liquid is a **spiking cortical microcircuit** rather than a rate net.

---

## The model

| Component | Definition |
|---|---|
| Input | `u(·)` — a continuous function of time, or a vector of spike trains (0/1-valued point events) |
| **Liquid filter** `L^M` | An operator mapping input functions to state functions: `x^M(t) = (L^M u)(t)`. Untrained, not task-specific, may be "evolved or found" |
| **Liquid state** `x^M(t)` | *Everything a readout can see at time `t`* — not a state in the finite-automaton sense. In the neural implementation: the vector of contributions of all liquid neurons to a generic readout neuron's membrane potential, i.e. each liquid spike train low-pass filtered with `τ = 30 ms` |
| **Readout** `f^M` | `y(t) = f^M(x^M(t))` — **memoryless**. Every dependence on `u(s), s ≤ t` must already be in `x^M(t)`. Task-specific, and many `f^M` may share one `L^M` |

Two macroscopic properties are argued to be necessary and sufficient:

| Property | What it constrains | Depends on |
|---|---|---|
| **SP** — separation | How far apart the state trajectories `x_u^M(·)`, `x_v^M(·)` are driven by different inputs `u ≠ v` | Complexity/diversity of the liquid |
| **AP** — approximation | The readout's resolution: its ability to map distinct liquid states onto given target outputs | Adaptability of the readout |

### The two theorems

Formalised (appendix A) as the **pointwise separation property** on the class `C_B` of basis filters — for any `u ≠ v` there is *some* `B ∈ C_B` with `(Bu)(0) ≠ (Bv)(0)` — and the **approximation property** on the readout class `C_F` (uniform approximation of continuous functions on compacta).

| | Statement |
|---|---|
| **Thm 1** | If `C_B` is any class of time-invariant fading-memory filters with pointwise separation and `C_F` satisfies approximation, then **any** time-invariant fading-memory filter `F` on uniformly bounded Lipschitz inputs is approximated to any `ε` by an LSM with `L^M = ⟨B_1u, …, B_mu⟩`, `B_i ∈ C_B`, `f^M ∈ C_F` |
| **Converse** | If `C_F` is continuous, anything approximable this way *is* time-invariant with fading memory — a complete characterisation |
| **Thm 2** | The same, for inputs that are spike trains with a minimum inter-spike distance, under a redefined fading memory: the output is determined to `ε` by the approximate times of the **last few spikes** |

Example classes with pointwise separation named in the paper: delay filters `u ↦ u^{t₀}`, exponential-impulse-response linear filters `h(t) = e^{−at}`, and **standard models of dynamic synapses**.

**The point of Thm 1 is negative and that is what makes it useful.** Nothing is required of the basis filters except separation, so the theorem licenses computing with circuitry that was not designed, and shifts every design question off "which recurrent structure" and onto SP, AP and class membership — the same conclusion [[wiki/entities/simple-cycle-reservoir.md]] reaches 22 years later by construction rather than by existence.

---

## The neural implementation

| Parameter | Value |
|---|---|
| Column | 135 leaky integrate-and-fire neurons on a `15 × 3 × 3` integer grid; **20% inhibitory** |
| Connection probability | `C · exp(−(D(a,b)/λ)²)`; `C =` 0.3 (EE), 0.2 (EI), 0.4 (IE), 0.1 (II). `λ` sets both mean degree and mean connection *length* |
| Neuron | `τ_m = 30 ms`, threshold 15 mV, reset 13.5 mV, refractory 3 ms (E) / 2 ms (I), `I_b = 13.5 nA`, `R = 1 MΩ` |
| Synapses | **Tsodyks–Markram dynamic synapses**, `U, D, F` drawn per connection from Gaussians fitted to measured data, SD = 50% of mean; `τ_s = 3 ms` (E) / 6 ms (I); delays 1.5 ms (EE), 0.8 ms (other) |
| Input | One or more spike trains injected into **30% randomly chosen** liquid neurons, with per-neuron Gaussian amplitudes (a "topographic injection") |
| Readout | A pool of ~50 unconnected I&F neurons; output = fraction firing per 20 ms bin (space-rate code). Trained by the **p-delta rule** (population delta rule, ≤2 bits of global communication) or, for single perceptrons, by **linear regression** |
| Noise | Spike-time jitter in the input + randomly drawn initial membrane potentials each trial |

Everything task-specific is in the last row. The liquid is never trained anywhere in the paper.

---

## Results

| # | Result | Numbers |
|---|---|---|
| 1 | **SP holds and is graded, not chaotic.** State distance `‖x_u^M(t) − x_v^M(t)‖` sits well above the same-input/different-initial-condition floor and is, after the first 30 ms, roughly **proportional to** input spike-train distance `d(u,v)` | `λ = 2`, one column, `d(u,v) ∈ {0, 0.1, 0.2, 0.4}` |
| 2 | **Spatiotemporal classification** of 5 noise-corrupted 40-channel/0.5 s spike patterns, a harder version of a task Hopfield & Brody 2001 solved with a **hand-designed** network limited to one spike per channel | 5 readout pools × 50 neurons, 20 noisy training examples each, spike jitter SD 32 ms; output correct as soon as the liquid has absorbed enough input, and available **at every time `t`** |
| 3 | **Fading memory is deep and recoverable after overwriting.** Four readouts classify, at `t = 1000 ms`, which of two templates generated each of four *independent* 250 ms segments of a single input spike train | Correctness falls monotonically with segment age but stays above chance for segment 1 — 750 ms back, through three uncorrelated overwriting segments, with `τ_m = 30 ms` everywhere |
| 4 | **Dynamic synapses are what carry result 3.** Replacing them with static synapses (rescaled to matched firing activity) loses significant performance on **every segment except the last** | Raster plots: with dynamic synapses the circuit's response to each of four input spikes differs; with static synapses it is stereotypical |
| 5 | **Connection-length distribution has an interior optimum.** Sweeping `λ`: `λ = 0` (no recurrence) is poor — recurrence is necessary for SP; large `λ` is also poor, homogenising the circuit and facilitating chaos | Best around `λ ≈ 2`: mostly local connections plus a few long-range ones — between a cellular automaton and a Hopfield net |
| 6 | **Two ways to buy SP, and they are not equivalent.** Adding *connections* within one column (`λ = 8`) raises separation for large and small `d(u,v)` alike — quasi-chaotic, so noise and signal are amplified together. Adding *uninterconnected columns* (4 × `λ = 2`) raises separation only in the range that distinguishes classes | 4-column liquid wins across input jitter 0–16 ms |
| 7 | **Parallel multitasking on one liquid.** Six readouts trained independently on a 2-column liquid: sum of rates over 30 ms; its integral over 200 ms; spatiotemporal pattern detection; detection of a switch in the spatial distribution of rates; spike coincidences for two different input pairs over 75 ms | All six accurate in real time — and demonstrated on a test input drawn from **outside** the training distribution (base rate, amplitude, frequency and phase each set in the gap between the two training intervals) |
| 8 | **Readout-assigned equivalence classes.** With the liquid's population rate visibly varying, the trained readout's firing is nearly constant at the target value — and *not* because it sampled a few unusual neurons (its weight distribution is broad, and weights are frozen after training) | The readout has learned its own notion of *equivalent liquid state*; different readouts on the same liquid impose **different** equivalences |

Result 8 is the paper's own headline claim, and the one with no counterpart elsewhere in the wiki: **a stable output does not require a stable state.** Invariance is manufactured at the readout by collapsing a high-dimensional trajectory, so a circuit may never revisit a state and still answer the same question the same way.

---

## Comparison

| | **LSM** | Echo state network (Jaeger 2001) | [[wiki/entities/simple-cycle-reservoir.md]] | Attractor network | Turing machine / FSM model of a circuit |
|---|---|---|---|---|---|
| Liquid / state dynamics | Spiking I&F microcircuit with dynamic synapses, continuous time | Rate units, discrete time | Linear ring, one weight `λ` | Multistable, symmetric | Constructed per task |
| What is trained | Readout only | Readout only | Readout only | The landscape | Nothing — built |
| Memory | Transient perturbation, fading | Fading | `λ`-exponential fading | Stable states; needs 2¹⁰ attractors for 10 bits | Unbounded, discrete |
| Universality claim | Time-invariant fading-memory filters, continuous time **and spike trains** (Thms 1–2) | Existential | **Constructive**, linear systems | — | Turing-complete, off-line |
| Real-time output | Yes, at every `t` | Yes | Yes | No — must converge first | Requires a central clock |
| Parallel tasks on one substrate | **Yes**, `k` readouts | Yes | Yes | No | No |
| Noise | Tolerated by construction | Tolerated | Tolerated | Tolerated | Breaks down under realistic analog noise (Maass & Sontag 1999) |

The three-column argument the paper actually makes: Turing/FSM models need a clock and per-task construction and die under analog noise; attractor networks are noise-robust but have an uncontrollable landscape, an exponentially wasteful memory code, must wait for convergence, and cannot support several concurrent computations on one circuit. LSMs give up stable states and get real-time, multi-task, noise-tolerant computation on found circuitry.

---

## Limitations

| Limitation | Consequence |
|---|---|
| **Fading memory is the class, and it is the class the wiki keeps hitting** | Thm 1's converse makes this exact: an LSM approximates a filter *iff* the filter has fading memory. Variable binding held indefinitely, a rule applied 10⁶ steps later, a counter or a stack — all outside, for the same reason as [[wiki/entities/simple-cycle-reservoir.md]]. Result 3 (750 ms) is a long horizon, not a non-fading one |
| **No learning in the liquid** | Conceded in the discussion as a simplification: liquid synapses "are also likely to be plastic", to be shaped by input statistics rather than by task, "most prominent during development". Nothing is implemented or measured |
| **SP has no constructive theory** | The paper lists knobs — neuron diversity, synaptic architecture, connectivity, more columns — and measures three of them, but there is no procedure that takes an input distribution and returns a liquid. `λ` was swept, not derived |
| **The separation/noise-robustness trade-off is unresolved in principle** | Result 6 shows raising intrinsic SP raises noise sensitivity in lockstep; the escape (more columns) is a *replication* trick, and nothing says how many columns at what `λ` for a given input distribution |
| **Readout is memoryless by fiat** | Footnote 2 concedes real readouts are plastic and would themselves contribute memory; the division is "for conceptual clarification" |
| **Hierarchies untested** | "Information processing capabilities of hierarchies or other structured networks of LSMs remain to be explored" — the whole compositional question is named and left open |
| **Small and old** | 135 neurons; classification tasks with 2–5 classes; no comparison to a trained recurrent network of any kind |

---

## Why this matters for a reasoning model

- **It is the wiki's cleanest separation of *substrate* from *task*.** One circuit, `k` independently trained readouts, each defining its own equivalence relation over the same trajectories. That is the architecture a multi-task reasoner wants — and it comes with the price stated exactly: everything shareable must be inside the fading-memory class, so nothing that must *persist* can be shared this way.
- **Result 8 changes what "a representation" has to be.** The wiki's default is that a stable readable code is stored somewhere and then read. Here the code exists only relative to a readout, is never stable in the circuit, and is nonetheless invariant at the output. Applied to [[wiki/concepts/representation-probing.md]]: a probe that finds a decodable variable in a transient trajectory has not found a stored variable, and the LSM is the constructive demonstration that the two come apart.
- **It prices the "found circuitry" claim.** Thm 1 says an arbitrary un-designed recurrent circuit is usable if it separates. This is the strongest formal support in the wiki for building a reasoner on top of a substrate that was not designed for the task — and simultaneously the tightest statement of what such a substrate can never supply.
- **The dynamic-synapse result is a mechanism claim, not a performance claim** (result 4). Short-term plasticity is what makes the same input spike processed *differently depending on context set hundreds of milliseconds earlier*. In the wiki's terms, `u·x` is a per-synapse state variable that multiplies the memory horizon of a circuit whose every time constant is 30 ms ([[wiki/concepts/synaptic-plasticity.md]]).
- **(brainstorm) Result 6 is a scaling law nobody followed up.** "Add columns, not connections" says capacity should be grown by **replicating a module at fixed internal complexity**, because that raises class separation without raising noise amplification — the exact opposite of scaling a single recurrent network's density. If it generalises, it is an argument for column-structured architectures ([[wiki/entities/thousand-brains-theory.md]]) from dynamics rather than from anatomy, and it predicts a measurable failure mode for wide monolithic recurrent models: sensitivity to input perturbations rising at the same rate as sensitivity to input *classes*.
- **(brainstorm) The paper's own machine-learning translation is a warning about itself.** In the discussion it says that for engineering purposes one may replace the microcircuit with a tapped delay line plus any static classifier — the liquid's only job being a nonlinear expansion that makes a **linear** readout sufficient, hence a single global optimum and on-line trainability. Read strictly, that concedes the biological detail (heterogeneity, dynamic synapses, connection-length statistics) is buying SP quality, not computational kind — which is [[wiki/empirical-tensions.md]] T1 and T234 in the author's own words, on the side of the substrate being detail.

---

## Connections

- **[[wiki/entities/simple-cycle-reservoir.md]]** — the same theorem two decades later with the existence quantifier removed: Maass proves *some* composition of separating basis filters approximates any fading-memory filter, Li, Fong & Tiňo construct the approximant as a single ring with one weight. Both draw the identical boundary (fading memory in, non-fading dependencies out), and together they say the LSM's biological richness cannot be buying representable functions — leaving SP quality, conditioning and unit count as the only things it can buy.
- **[[wiki/concepts/autonomous-pattern-generation.md]]** — the same reservoir-plus-linear-readout architecture used for output rather than input: this page reads a stream with an input-driven liquid, that page emits one from a clock-driven liquid, and both inherit the fading-memory ceiling. The Fourier/basis argument stated there is the informal version of SP stated here.
- **[[wiki/entities/hag-reservoir.md]]** — the direct descendant of result 5, doing by growth what this paper does by sweeping `λ`: both claim the recurrent graph is a lever worth pulling, and both are in tension with the SCR universality theorem ([[wiki/empirical-tensions.md]] T174). This paper's contribution to that row is a *within-class, fixed-`n`* demonstration — 135 neurons throughout, only the connectivity statistic changing.
- **[[wiki/concepts/circuit-size-separation.md]]** — the same author's preceding result and the gap this fills: Maass 1997 proves what small type-B spiking networks can compute with every construction hand-built and no learning anywhere; the LSM turns that into a trainable architecture by refusing to build the circuit at all and training only a linear readout on top of it.
- **[[wiki/entities/spiking-neural-networks.md]]** — the substrate, and the paper that made a generic spiking circuit usable without designing it: this is the first stable general method for getting a wide family of real-time computations out of a recurrent I&F network, and it is why "reservoir" recurs throughout the neuromorphic literature (LSNN, NeuCube).
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the biological claim attached: an 80:20 excitatory/inhibitory recurrent circuit with distance-decaying connectivity is proposed as a *liquid*, making the cortical column the computational unit and neighbouring columns each other's readouts. The paper's own suggestion is a cortical model in which every column serves both liquid and readout roles.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the load-bearing mechanism result (result 4): with dynamic synapses removed and firing rate matched, a 135-neuron circuit loses its memory of everything but the last 250 ms, so Tsodyks–Markram `u·x` is what lets a `τ_m = 30 ms` circuit condition its response to a spike on context set 750 ms earlier. Dynamic synapses are also named in appendix A as a class of filters with the pointwise separation property.
- **[[wiki/concepts/attractor-dynamics.md]]** — the rival this paper is written against, with the objections itemised: an uncontrollable landscape, `2^k` attractors to store `k` bits, latency to convergence, and no support for concurrent computations on one circuit. Its counter-claim is that the transient *is* the memory and that stability belongs at the readout, not in the state.
- **[[wiki/concepts/working-memory.md]]** — the complement, sharpened by result 3: 750 ms of recoverable trace through three overwriting segments is the strongest fading-memory horizon in the wiki, and Thm 1's converse proves it can never become a non-fading one. Anything that must survive arbitrarily long has to come from outside this architecture.
- **[[wiki/concepts/population-geometry.md]]** — a limit case of the page's premise: here the trajectory is not required to be low-dimensional, structured, or repeatable at all, and the only geometric property that matters is that different input classes land far apart relative to noise. Result 6 makes that a two-sided requirement — separation must grow for *between-class* distances and not for within-class ones.
- **[[wiki/concepts/temporal-coding.md]]** — the timing budget met by a different route than the same author's 1997 argument: the LSM never decodes a rate or a latency, it lets a memoryless readout take a weighted sum of exponentially-filtered spike trains at the instant it is asked, so "real-time" is bought by never having to wait for a code to complete.
- **[[wiki/concepts/spike-train-error-metrics.md]]** — the same exponential filter used for the opposite purpose: the liquid convolves spike trains into a continuous state so the readout's loss can be ordinary regression, while the supervised rules there convolve the *error* instead and keep the spiking output — and the measured result is that filtering costs no timing precision (0.2 ms), which is the assumption the liquid's readout makes without testing.
