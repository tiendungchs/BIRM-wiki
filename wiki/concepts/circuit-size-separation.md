# Circuit-Size Separation Between Neuron Models

**A proof technique that scores a unit type by *how many of it* a given function costs, rather than by which functions it can compute at all. Its result for this wiki: a single spiking neuron computes a coincidence-detection and an element-distinctness function that provably require Ω(n) sigmoidal hidden units — ~1663 of them at a biologically realistic fan-in — while the two classes remain mutually simulable, so the strongest rigorous case for the spiking substrate is a *density* claim and not an *expressibility* claim.**

> **Provenance.** `raw/maass-1997-spiking-neurons-third-generation.md` — Wolfgang Maass, *Networks of Spiking Neurons: The Third Generation of Neural Network Models*, Neural Networks 10(9):1659–1671, 1997. The paper that introduced the "three generations" framing the wiki uses without attribution. Pure complexity theory: no experiments, no simulations, no measured numbers except the neurobiological motivation quoted below.

---

## The three generations, and what each one is universal for

| Generation | Unit | Output | Universal for | Learning |
|---|---|---|---|---|
| **1st** | McCulloch–Pitts / threshold gate | Digital only | Every boolean function, with one hidden layer | — |
| **2nd** | Sigmoidal, linear-saturated, radial-basis — any continuous activation on a weighted sum | Analog | Every continuous `F` with compact domain and range, to arbitrary `L∞` accuracy, with one hidden layer | Gradient descent (backpropagation) |
| **3rd** | Spiking / integrate-and-fire | A **set of firing times** `F_v ⊂ ℝ⁺` | See below — at least as much as both, with strictly fewer units on some functions | Not addressed by this paper |

The rate interpretation of generation 2 (sigmoid output = firing rate) is what the paper attacks, and it attacks it on **time**, not on plausibility:

| Motivating number | Source cited |
|---|---|
| Human visual pattern analysis and classification complete in **100 ms** | Thorpe & Imbert 1989; Perrett, Rolls & Caan 1982 |
| Minimum synaptic stages retina → temporal lobe | **10** |
| One visual cortical area completes its computation in | **20–30 ms** (Rolls & Tovee 1994) |
| Firing rates of the neurons involved | **< 100 Hz** — so 20–30 ms is spent merely *sampling* one rate |

**The argument is a budget argument.** Ten stages in 100 ms leaves ~10 ms per stage; one rate sample costs 20–30 ms. A rate code cannot be read fast enough for the computation that is observed to happen, so whatever generation 2 is modelling, it is not fast cortical processing. This is the wiki's earliest and cleanest statement of the case for [[wiki/concepts/temporal-coding.md]], and it predates every measurement on that page.

---

## The formal model (SNN)

```
P_v(t) = Σ_{⟨u,v⟩∈E} Σ_{s∈F_u} w_uv · ε_uv(t − s − Δ_uv)
```

`v` fires when `P_v(t)` crosses its threshold function `Θ_v(t − t′)` from below, `t′` = time of `v`'s last firing (so `Θ` carries both refractory periods). Weights `w_uv ≥ 0` with the sign carried by the response function `ε_uv` (excitatory or inhibitory, fixed per presynaptic neuron); `Δ_uv` is the axonal + dendritic **delay**. The noisy variant makes `P_v(t) − Θ_v(t − t′)` govern a firing *probability* and is identical to Gerstner's spike response model.

**Everything below turns on the shape of `ε` and `Θ`, which is the paper's real subject:**

| Type | Response / threshold functions | Physical analogue |
|---|---|---|
| **A** | Piecewise **constant** — rectangular pulses | Pulse-stream VLSI; what digital neuromorphic hardware natively emits |
| **B** | Continuous piecewise **linear** — triangular pulses | Biological EPSP/IPSP shapes, approximable to 4–5 segments |

---

## Linear temporal coding, and why weights survive it

Encode input `x_i` as the firing time `T_in − x_i·c` of input neuron `a_i`; read output `y` off a firing at `T_out − y·c`, with `T_in`, `T_out` independent of the inputs. For type-B neurons in a parameter range, the firing time of `v` is

```
t_v = T_out − Σ_{⟨u,v⟩∈E} sign(ε_uv) · w_uv · x_u        (Eq. 1)
```

**A weighted sum has become a shift of a firing time, and `w_uv` plays exactly the role it plays in generations 1 and 2.** This is the load-bearing enabler of every positive result below: it means a temporal-coding network inherits the entire linear-algebraic vocabulary of rate networks for free, rather than needing a new one. It is also why the separations are *not* free — see the reference-signal problem at the end.

---

## The two witness functions

Both are chosen so that **a single spiking neuron computes them**, and both are biologically motivated rather than adversarial constructions.

### CD_n — coincidence detection / pattern matching

```
CD_n(x₁..x_n, y₁..y_n) = 1  iff  x_i = y_i = 1 for some i ∈ {1..n}        {0,1}^2n → {0,1}
```

*One* type-A neuron, all weights 1: choose delays so `Δ_{a_i,v} = Δ_{b_i,v}` for each `i`, and so that the non-zero parts of `ε_{a_i,v}` and `ε_{a_j,v}` do not overlap for `i ≠ j`. Set `Θ_v(0) = 1.5 ×` (peak of one EPSP), and the computation is **noise-robust**: perturbations of the input firing times, the delays, the weights and the threshold all leave the output correct.

| Model computing CD_n | Lower bound on units |
|---|---|
| Spiking neuron (type A or B, deterministic *or* noisy) | **1** |
| Threshold circuit | `≥ n / log(n+1)` gates *with an edge from the `b`-inputs* |
| Sigmoidal net, piecewise-**polynomial** activation | `Ω(n^{1/2})` — from `n = O(s²)` (Goldberg & Jerrum 1995) |
| Sigmoidal net, piecewise-**exponential** activation (i.e. the actual sigmoid) | `Ω(n^{1/4})` — from `n = O(s⁴)` (Karpinski & Macintyre) |

### ED_n — element distinctness

```
ED_n(x₁..x_n) = 1 if x_i = x_j for some i ≠ j ;  0 if |x_i − x_j| ≥ 1 for all i ≠ j ;  arbitrary otherwise
```

*One* spiking neuron again, this time with **all delays equal** — the input arrives in linear temporal coding, and the threshold is placed strictly between the peak of a single EPSP and the peak of two EPSPs arriving less than `c` apart. The `arbitrary` clause is the design trick: because nothing is required when `0 < min|x_i − x_j| < 1`, no **hair-trigger** situation exists and the noise-robustness survives.

| Model computing ED_n | Lower bound |
|---|---|
| Spiking neuron | **1** |
| Layered threshold circuit | `Ω(n log n)` gates **on the first hidden layer** (halfspace/polytope counting argument) |
| Sigmoidal net (Theorem 3) | `≥ n − 1` hidden units; the proof yields `k ≥ (n−4)/2` computation nodes, and `k ≥ (n−15)/6` for nets mixing sigmoidal and threshold gates |

**Theorem 3 is the paper's own headline outside the SNN question:** `Ω(n)` was, at publication, the largest lower bound known for a sigmoidal net on *any* concrete function, improving Koiran's `Ω(n^{1/4})`. It is also the first use of Sontag's `2w+1` bound — the "Sontag dimension", dual to VC dimension (`for all` sets of `d` inputs, rather than `there exists`).

### ED′_n — the version that survives dendritic realism

The linear-summation assumption in `P_v(t)` is false: isolated distal EPSPs decay exponentially before the trigger zone, while EPSPs arriving **synchronously at adjacent synapses** are boosted at dendritic hot spots ([[wiki/concepts/dendritic-computation.md]]). Maass therefore restates ED_n so that a neuron must fire only when **two blocks of three adjacent synapses** each receive synchronous EPSPs, and must stay silent only when at most three EPSPs arrive in any interval of length `c` — i.e. six coincident EPSPs to fire, which is the figure Valiant argues is realistic.

**Plugging `n = 10 000` synapses into the resulting `k ≥ (n−15)/6` gives ≥ 1663 sigmoidal hidden units for what one cortical neuron does.** That number is the paper's abstract in a single figure, and it is robust to reasonable changes of the constants.

---

## The A/B split — pulse *shape* is a computational decision

This is the result the wiki had no page for and no vocabulary to express.

| Question | Type A (rectangular) | Type B (triangular) |
|---|---|---|
| Simulate a threshold circuit on **boolean** input | Yes, same architecture, one neuron per gate | Yes, but needs a **synchronization module** (below) |
| Simulate a threshold circuit on **analog** input | **Impossible.** There is *no* function `f: ℕ → ℕ` such that an `s`-gate threshold circuit is simulable by `f(s)` type-A neurons. Witness: `x₁ + x₂ ≤ x₃` on `[0,1]³` — three threshold gates, and **no** type-A network of any size or runtime computes it | **Yes, in `O(s)` neurons** (Theorem 5) |
| Approximate any continuous `F: [0,1]^n → [0,1]^k` | No | **Yes, one hidden layer**, and in `O(s)` neurons whenever a linear-saturated sigmoidal net of `s` units suffices |
| Characterization of its power | A restriction of the random access machine called **N-RAM** (Maass & Ruf 1995) | A different N-RAM restriction (Maass 1995a,c) |

**What type B actually needs is far less than "piecewise linear":** the positive results require only that EPSPs have *some* small linearly increasing segment and IPSPs *some* small linearly decreasing segment — properties real postsynaptic potentials have. The capability being bought is that **incoming potentials shift a firing time continuously**; a rectangular pulse can only move a crossing discontinuously, and that is the whole difference.

**The synchronization defect is type B's price, and it is the mirror image.** Feed a layer of type-B neurons a synchronized boolean volley: their outputs are *not* synchronized, because `P_v(t)` is piecewise linear and the **slope** of each piece depends on how many EPSPs arrived — so the crossing time depends on the input bits. Simulating a multi-layer boolean circuit therefore requires an explicit re-synchronization stage between layers. Type A, whose potential is piecewise constant, has no such dependence and no such need.

**(brainstorm) Read the two rows together and the split is a clean trade the wiki can reuse: continuous shift-ability buys analog computation and costs self-synchronization; discreteness buys self-synchronization and forfeits analog computation.** Nothing in the wiki's spiking pages chooses a side, because they all assume an exponential PSP — which is type B — and then read boolean-ish codes off it. That combination is exactly the one that needs the synchronization module nobody has specified.

---

## Delays beat weights, per parameter

| Programmable parameter set on one type-A neuron | VC dimension |
|---|---|
| `n` variable **weights** | `Θ(n)` |
| `n` variable **delays** | `Θ(n log n)` |

(Maass & Schmitt 1997, cited here.) A delay is a strictly more expressive parameter than a weight at equal count — and CD_n's construction uses **only** delays, with all weights fixed at 1. This is the theorem behind [[wiki/concepts/temporal-coding.md]]'s design rule that delays are the learnable variable, which until now rested on one owl model.

**The bound now has an optimiser, and a measurement that qualifies it** ([[wiki/concepts/learnable-synaptic-delays.md]], Mészáros et al. 2025). Exact event-based gradients on delays exist, and the paper's smallest experiment is this page's `CD_n` construction made trainable: two LIF neurons into two leaky integrators, **every weight fixed at 1**, only the 2×2 delay matrix learned, worst-case initialisation, 100% accuracy after six presentations per class — and what it computes is not coincidence but **order**, which no weight configuration of that circuit can express. The qualification is empirical: at *matched parameter count* delays and weights performed equally on Yin-Yang, and delays gave no benefit to large recurrent networks on SSC and Braille, helping only as unit count fell. So the `Θ(n log n)` bound predicts what a delay *can* express, not what gradient descent extracts from one on these tasks ([[wiki/empirical-tensions.md]] T237).

---

## Noise

- CD_n, ED_n and ED′_n are all computable by a **single noisy** spiking neuron of type A or B.
- With very noisy type-A or type-B neurons, arbitrary **digital** computation is achievable at any desired reliability (Maass 1996b).
- Noise *does* restrict the analog case (Maass & Orponen 1997) — the one place the paper concedes ground.

The robustness is not incidental to the separations: it comes from the same slack that makes the functions cheap. `Θ_v(0) = 1.5 ×` peak-EPSP for CD_n and the `arbitrary` band in ED_n are both explicit safety margins, and both are *specification* choices rather than mechanism choices.

---

## What this changes for a reasoning model

- **It converts T1 from an argument into a theorem, and simultaneously weakens what the theorem can say.** For type-B neurons the function classes coincide: spiking nets simulate threshold and sigmoidal nets in `O(s)` units, and sigmoidal nets can be built to compute anything a spiking net computes. So the rigorous form of "the substrate matters" is **`Ω(n)` fewer units for the same function**, not "a function the rate model cannot express" ([[wiki/empirical-tensions.md]] T234). Every wiki claim of the inexpressibility form ([[wiki/entities/spiking-tem.md]], the barn-owl case) is a stronger claim than this paper supports and needs its own evidence.
- **Both witness functions are latent-graph primitives.** CD_n asks *do these two patterns share an active element* — one-step [[wiki/concepts/subgraph-matching.md]] — and ED_n asks *are any two of these observations the same value*, which is precisely the **state-aliasing test** every graph-discovery model must run to decide whether two observations are one node ([[wiki/concepts/latent-graph-discovery.md]], [[wiki/entities/cscg.md]]). That the aliasing test costs one neuron in time and `Ω(n)` units in rate is the most directly relevant fact on this page **(brainstorm)**.
- **Density, not accuracy, is the metric the substrate wins on.** The wiki's SNN scoreboard is entirely MNIST accuracy ([[wiki/entities/spiking-neural-networks.md]]); this paper says accuracy is the wrong axis and unit count is the right one, which is the same move [[wiki/concepts/intelligence-density.md]] makes for description length. No published SNN benchmark reports units-to-competence.
- **The separations are all cashed in linear temporal coding, which needs `T_in`.** `x_i ↦ T_in − x_i·c` presupposes a stimulus-onset reference the system is not given — this is time-to-first-spike under another name, and [[wiki/architectural-gaps.md]] G77 is exactly the objection. **So the strongest formal argument for the spiking substrate is built on the code with the weakest biological grounding**, and nothing here or elsewhere shows the separations survive a self-referenced code (rank order, inter-spike interval) **(brainstorm)**.

---

## Open problems

- **No learning — and the delay half now has an answer.** The paper proves what small spiking networks *can* compute and says nothing about reaching those weights and delays. [[wiki/architectural-gaps.md]] `G80` opened on that observation and has since moved to `PARTIAL`: delays are now trainable by an exact event-based gradient, in feedforward and recurrent networks, setting values no repertoire had to contain ([[wiki/concepts/learnable-synaptic-delays.md]]). What is still hand-built is everything else here — the thresholds, the response-function shapes, the `1.5×`-peak safety margins and the `arbitrary` bands that make the constructions noise-robust are all specification choices no optimiser touches.
- **The synchronization module is asserted, not costed.** Type B's boolean-circuit simulation needs one between every pair of layers; its unit count is not in the size bounds quoted above.
- **The lower bounds are for feedforward nets.** All generation-1/2 comparisons assume a layered feedforward architecture; nothing is said about recurrent rate networks, which is what the wiki's actual competitors are.
- **`Ω(n)` is polynomial.** The separations are large at biological fan-in and unimpressive asymptotically; no exponential separation between generations 2 and 3 is known.
- **Nothing here composes.** Both witness functions are single-neuron computations. The paper exhibits no *network* of spiking neurons that is `Ω(n)` smaller than the corresponding rate network for a task, which is what a builder actually needs.

---

## Connections

- **[[wiki/entities/spiking-neural-networks.md]]** — the substrate this page scores, and the source of its "three generations" framing; supplies the formal `P_v(t)` model that page's LIF equation is one instance of, and the result that page's efficiency claims should be stated as: the proven advantage is unit count on coincidence-type functions, not accuracy on MNIST.
- **[[wiki/concepts/temporal-coding.md]]** — the mechanism side of the same claim: this page proves that a coincidence detector is `Ω(n)` cheaper than its rate equivalent, that page measures how precisely one can be built (20–25 µs) and how its delays get tuned. The delay VC-dimension result `Θ(n log n)` vs `Θ(n)` for weights is the theorem behind that page's "delays are the learnable variable" design rule.
- **[[wiki/concepts/spike-encoding-schemes.md]]** — names this page's coding assumption: linear temporal coding *is* time-to-first-spike, so every separation result here inherits that scheme's requirement for an externally supplied onset, and none has been re-derived under a self-referenced code.
- **[[wiki/concepts/dendritic-computation.md]]** — the reason the ED′_n variant exists: linear summation of postsynaptic potentials is false, distal isolated EPSPs decay and synchronous adjacent ones are boosted at hot spots, so the witness function was rewritten to need six coincident EPSPs in two adjacent-synapse blocks — and the `≥1663` figure comes from that corrected version, not the idealised one.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the two witness functions are graph-discovery primitives in disguise: CD_n is one-step overlap detection between two patterns, ED_n is the state-aliasing test that decides whether two observations index the same latent node.
- **[[wiki/concepts/subgraph-matching.md]]** — CD_n is the atomic case of that page's operation (does any element of one pattern coincide with the corresponding element of another), and the result is that its atomic case is free in time and `Ω(n^{1/4})`–`Ω(n^{1/2})` in sigmoidal units.
- **[[wiki/concepts/intelligence-density.md]]** — the same scoring move one level up: both pages evaluate a system by outputs per unit of description rather than by correctness on a benchmark, and this page supplies the only worked lower bounds in the wiki for that ratio.
- **[[wiki/entities/hodgkin-huxley-model.md]]** — where the type A/B distinction bites the wiki's abstraction ladder: the LIF simplification retains an exponential postsynaptic potential and is therefore type B, but neuromorphic hardware emitting rectangular pulses is type A and hits a proven ceiling (no analog threshold-circuit simulation at any size) — so pulse *shape*, usually treated as the most disposable biophysical detail, is a hard computational boundary.
- **[[wiki/entities/spiking-tem.md]]** — the strong form of the claim this page proves the weak form of: that model's ablations argue three spiking mechanisms are *necessary* for a representation, whereas the theory here says spiking and rate networks compute the same functions and differ only in unit count ([[wiki/empirical-tensions.md]] T234).
- **[[wiki/concepts/autonomous-pattern-generation.md]]** — the same author's next construction and the answer to this page's last open problem: liquid state machines take the type-B expressiveness proved here and add a *usable* learning story by fixing the recurrent weights and training a readout.
- **[[wiki/entities/liquid-state-machine.md]]** — the same author's next construction and the direct answer to this page's closing complaint that every network here is hand-built with no learning: the LSM stops building the circuit altogether, requires of it only the pointwise separation property, and puts all task content in a linear readout trained by regression or a delta rule. The type-B expressiveness proved here is what licenses treating an arbitrary found circuit as a usable basis.
- **[[wiki/entities/cscg.md]]** — that model's founding operation priced on this page's substrate: deciding whether two identical observations are one latent state or two is element distinctness, `ED_n`, which one spiking neuron computes in temporal coding and a sigmoidal network provably cannot without `Ω(n)` hidden units — so the clone-pool construction is the rate-level answer to a problem the spiking level solves in a single unit.
- **[[wiki/concepts/spike-train-error-metrics.md]]** — the gap between what the substrate can express and what anything can train toward: delays carry `Θ(n log n)` VC dimension against a weight's `Θ(n)`, yet every supervised spike-train rule in the wiki modifies weights only, and the best of them stores 0.14 patterns per synapse at 1 ms precision.
- **[[wiki/concepts/learnable-synaptic-delays.md]]** — the optimiser this page's delay bound calls for and its closing complaint says does not exist: an exact gradient `dL/dd_ji = −w_ji Σ_k (λ_I,j − λ_V,j)|_{t_k+d_ji}`, obtained by adding spike *arrival* times to EventProp's event set, which trains the `CD_n`-shaped circuit (all weights 1, delays only) from a worst-case initialisation in six examples — and reports the units-to-competence number this page complains no benchmark supplies: equal SHD accuracy at ~5× fewer parameters.
- **[[wiki/concepts/convergent-circuit-motifs.md]]** — an existence bound from biology rather than from complexity theory: route planning to an unobserved goal is performed by a nervous system of <5×10⁵ neurons, which brackets from above the circuit this page asks the size of `(tentative)`.
