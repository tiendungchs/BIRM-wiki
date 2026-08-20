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
| **Code** | Sparse in time, binary in amplitude |
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
| Trainable by forward-only local rules | Eligibility propagation (e-prop) — a forward-computable eligibility trace `e_ji(t) = dz_j(t)/dW_ji` multiplied by an online error estimate ([[wiki/concepts/biologically-plausible-credit-assignment.md]]) |

**Neuromorphic hardware.** Intel's Loihi, IBM's TrueNorth, SpiNNaker — specialized architectures for executing SNNs and brain-inspired local learning. The hardware and the local-learning constraint are the same design decision seen from two sides: locality is what makes the parallelism physically realizable, and it is why backpropagation-shaped algorithms do not map onto these chips.

---

## Limitations

- **Weight optimization is the central open problem.** Backpropagation fails on the discrete, sparse nonlinearity of the threshold; every route above (surrogate gradients, e-prop, evolutionary search, plasticity rules) is a workaround with its own cost.
- **e-prop is blind to the future.** It requires a real-time error signal at each time step and cannot learn from delayed errors extending beyond individual-neuron timescales — unlike REINFORCE / node perturbation, which handle exactly that case.
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
