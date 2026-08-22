# Hopfield Network (classical binary/bipolar)

**`N` bipolar units, all-to-all *symmetric* weights with zero diagonal, asynchronous threshold updates, and one-shot Hebbian outer-product storage. The dynamics monotonically decrease a scalar `E = −½ Σ_{i≠j} w_ij s_i s_j`, so the state descends into a stored pattern: memory is content-addressable because retrieval *is* relaxation, and the address of a memory is any state inside its basin.** Hopfield 1982, *PNAS* 79:2554.

This page exists as the wiki's **baseline**. Nine other pages quote "≈`0.14N`", "spurious minima", "Hebbian outer product" or "energy landscape" as the thing they improve on ([[wiki/entities/vector-hash.md]], [[wiki/entities/sparse-distributed-memory.md]], [[wiki/entities/dense-sequence-memory.md]], [[wiki/entities/context-modular-memory-network.md]], [[wiki/entities/fcann.md]], [[wiki/entities/rolls-treves-hippocampal-model.md]], [[wiki/entities/tolman-eichenbaum-machine.md]], [[wiki/entities/tem-transformer.md]], [[wiki/concepts/energy-based-models.md]]); the object being improved on had no page.

> **Provenance.** `raw/crouse-2022-hopfield-networks-memory-machines.md` — Crouse, *Hopfield Networks: Neural Memory Machines*, Towards Data Science, 2022-05-18. A **tutorial exposition**, not a primary source: the mathematics is textbook (Hopfield 1982; Amit–Gutfreund–Sompolinsky 1985; the energy-decrease argument is the author's write-up of a Carnegie Mellon lecture), and the demonstrations are the author's own MNIST/64×64-image simulations. Claims sourced *only* here are marked `(tentative)`.

---

## Architecture

| Component | Statement | Constraint that does the work |
|---|---|---|
| State | `s ∈ {−1, +1}^N`; the pattern **is** the population state, one bit per unit | Information is stored *directly* in activity, not in a code — hence the representation cost below |
| Weights | `W` (`N × N`), `w_ij = w_ji`, `w_ii = 0` | **Symmetry** is what guarantees a Lyapunov function; **zero diagonal** stops a unit from holding itself in place |
| Activation | `y_i = Σ_j w_ij s_j` | Purely local: a unit sees only its own weighted input field |
| Update | `s_i ← sgn(y_i)`, **asynchronously** (one unit, or a random subset, per generation) | Synchronous update of all units can enter a 2-cycle; the descent argument is per-flip |
| Write (Hebbian) | `w_ij = (1/n) Σ_{p=1}^{n} ξ_i^p ξ_j^p`, `i ≠ j`; matrix form `W = (1/n)(YᵀY − n·I)` | **One shot**: the whole weight matrix is computed in one operation from one exposure per pattern. No error signal, no iteration, no gradient |
| Energy | `E = −½ Σ_{i≠j} w_ij s_i s_j = −½ Σ_i s_i y_i` | Not thermodynamic — a Lyapunov function the update rule is constructed to descend |

**Why the energy falls (the whole proof in one line).** A unit flips only when `s_i y_i < 0`; a flip sets `s_i^{new} = −s_i^{old}`, so the term `s_i y_i` changes by `−2 s_i^{old} y_i > 0`, and `E = −½ Σ_i s_i y_i` therefore strictly decreases. `y_i` is unaffected by `s_i` itself precisely because `w_ii = 0`. Bounded below and strictly decreasing ⟹ convergence to a fixed point in finite time.

**The Ising ancestry is load-bearing, not decorative.** Units are spins, weights are couplings, the update is alignment to the local field, and retrieval is a quench. Everything the wiki says about attractor memory — basins, landscape, capacity as a signal-to-noise ratio, spurious states as glassy minima — is imported from that physics with the couplings made *learnable*, which is the single move Hopfield 1982 contributes.

**The architecture was specified verbally in 1949, and the verbal version already contains the negative weights.** Hebb's *cell assembly* is a group of neurons that become inter-associated by repeated coactivity and thereafter sustain "reverberatory activity"; Allport's gloss makes the auto-association explicit — each element "will tend to turn on every other element and (with negative weights) to turn off the elements that do not form part of the pattern", and a learned auto-associated pattern is an **engram** (Wikipedia, *Hebbian theory*). That is this page's `w_ij = ξ_i ξ_j` outer product read off a bipolar code: same-sign pairs potentiate, opposite-sign pairs get negative weights. So the classical network contributes the Lyapunov argument and the capacity theory, not the idea — and the "cell assembly / engram" vocabulary of the memory-allocation literature ([[wiki/entities/context-modular-memory-network.md]]) and this page's attractor vocabulary name the same object.

---

## What the design buys, and the price of each

| Property | Mechanism | Price paid elsewhere in the wiki |
|---|---|---|
| **Content-addressable retrieval** | The cue is an *initial condition*, not a key; any state in a basin retrieves the whole pattern | Nothing indexes the store — you cannot ask *which* memory is nearest without running the dynamics ([[wiki/concepts/subgraph-matching.md]] G37) |
| **Pattern completion from a partial or noisy cue** | Descent from a corrupted state; the author's 4096-unit net restores 64×64 images from heavy distortion, updating 7.2% of units per generation `(tentative)` | Completion is unconditional — a store biased this way returns a neighbour instead of reporting a miss (G38, [[wiki/concepts/pattern-separation-completion.md]]) |
| **One-shot learning** | `W` is closed-form in the patterns | The rule is *only* correct for near-orthogonal patterns; correlated data breaks it (below) |
| **Fully local computation** | Each unit knows its own state and its input field | No global signal is available either — so no capacity estimate, no fullness test, no confidence read-out (G42) |
| **Distributed storage** | Every pattern lives in every synapse | Erasing or hiding one memory is not an operation the architecture has ([[wiki/entities/context-modular-memory-network.md]] adds a mask to get it) |

---

## The three classical failures — the wiki's entire attractor-memory research programme is these three

| Failure | Statement | Where the wiki answers it |
|---|---|---|
| **Capacity `≈0.138N`, then a cliff** | Random patterns are stable up to `p_max ≈ 0.14N`; past it, retrieval fails for *most* stored patterns, not just the marginal one. Storage is `0.14N` patterns of `N` bits over `N²/2` synapses — **≈0.14 bits per synapse**, and capacity is capped by the *word size* because the pattern and the network are the same object | Decouple pattern size from capacity ([[wiki/entities/sparse-distributed-memory.md]]: `τ ≈ 0.10M`, `M` free); prestructure the fixed points ([[wiki/entities/vector-hash.md]]: exponential, graceful overload); gate by context ([[wiki/entities/context-modular-memory-network.md]]: ≈7–40×); steepen the read-out nonlinearity ([[wiki/entities/dense-sequence-memory.md]]: polynomial/exponential); orthogonalise the write ([[wiki/entities/fcann.md]], Kanter–Sompolinsky) |
| **Spurious minima** | Correlated or overloaded patterns produce basins for *mixtures* nobody stored; the net converges confidently to an in-between state | Randomise the address before writing (mossy-fibre hash, [[wiki/entities/rolls-treves-hippocampal-model.md]]); fix the landscape with content-free states so content never touches the recurrent dynamics ([[wiki/entities/vector-hash.md]]) |
| **Binary states waste units** | One unit per bit: a 28×28 8-bit greyscale image needs **6,272 units**; 1024×1024 needs **>8×10⁶** — and capacity is `0.14N` *patterns*, so the store is exponentially outmatched by the data it must hold | Continuous/Modern Hopfield networks (Ramsauer et al. 2020, *Hopfield Networks is All You Need*): float states, exponential capacity, **one-step** convergence, and the update *is* transformer self-attention — the identity [[wiki/entities/tem-transformer.md]] runs on |

**Reconciling the two capacity numbers already in the wiki.** `0.138N` (Amit et al., "essentially all patterns recalled") and Kanerva's `0.15N` ([[wiki/entities/sparse-distributed-memory.md]], quoted at bit-fidelity `φ = 0.995`) are the same curve read at two error criteria, not a disagreement. Capacity in an associative store is never a number without a fidelity target attached — which is the form in which every later capacity claim on this wiki should be read.

---

## Why it stays in the wiki after all of it is superseded

| Claim | Content |
|---|---|
| **It is the minimal existence proof of the wiki's core memory move** | Distributed, one-shot, content-addressable recall from local rules and no supervisor. Every later store adds structure; none removes a requirement from this list |
| **Retrieval as *dynamics* rather than lookup** | The strongest architectural export: the read operation is the same operation as the write substrate running forward. [[wiki/concepts/energy-based-models.md]]'s "reasoning is relaxation" and [[wiki/concepts/predictive-coding-free-energy.md]]'s "thinking is settling" are both this mechanism at a higher level of abstraction |
| **It sets the biological anchor** | The CA3 recurrent collateral system is standardly modelled as exactly this network with sparse coding and diluted connectivity ([[wiki/entities/rolls-treves-hippocampal-model.md]]); Hebbian LTP is the write rule as measured ([[wiki/concepts/synaptic-plasticity.md]]) |
| **One-shot storage is the right shape for episodic memory, and backpropagation is the wrong one** | The source's sharpest framing: an episodic memory is by definition acquired in one episode, so a rule needing 10⁴–10⁶ exposures cannot be the mechanism — and the hippocampus, the structure with attractor-like recurrence, is the structure recruited during one-shot learning | 

**(brainstorm) The bits-per-synapse figure is the number to carry forward, not the pattern count.** At `0.14` bits/synapse the classical net is ~2 orders below the ~1 bit/synapse ceiling that sparse-coded and prestructured stores approach. Read that way, the whole sequence of successors on this wiki is a single optimisation — *raise the information per synapse without giving up one-shot, local writes* — and the three tactics that work (sparsify the code, randomise the address, sharpen the read-out) are all ways of reducing the *overlap* between stored patterns' active sets. That reframes G42 as one quantity rather than a family of unrelated capacity theorems.

**(brainstorm) Symmetry is the axis, and it is a two-sided trade.** `W = Wᵀ` buys the Lyapunov function and therefore the guarantee of convergence; it also makes the network incapable of going anywhere. Every mechanism the wiki wants on top of memory — sequences, replay, simulation, search — is motion, and motion requires either an asymmetric term ([[wiki/entities/dense-sequence-memory.md]]), a slow adaptation current ([[wiki/entities/adaptive-cann.md]]), short-term depression ([[wiki/entities/stp-flickering-cann.md]]) or noise. The classical Hopfield network is best read as the *stability* half of an architecture whose other half has to be added back, and the wiki now holds four different ways of adding it.

---

## The same memory for fewer synapses: the hybrid-Boltzmann equivalence

A **hybrid Boltzmann machine** — a restricted Boltzmann machine whose hidden units take continuous values while the visible units stay binary — is *thermodynamically equivalent* to this page's network once the functions are marginalized over the hidden units (via Tavanaei et al. 2019, citing Barra et al.):

| Hopfield object | Hybrid Boltzmann object |
|---|---|
| `N` binary stochastic neurons | `N` binary **visible** units |
| `P` stored patterns | `P` **hidden** units |
| `N(N−1)/2` synapses to update | `H·P` synapses to update |

The stored patterns stop being coefficients baked into a dense `N×N` matrix and become *units*. Two consequences for this page. **It is a direct attack on the bits-per-synapse number above**: at `P ≪ N` the same associative memory runs on far fewer synapses, so the wiki's "raise information per synapse" framing has a fourth tactic — **factorize the weight matrix through the pattern set** — alongside sparsifying the code, randomising the address and sharpening the read-out. **And it makes the capacity question visible**: `P` is an explicit architectural quantity here rather than an emergent limit discovered by overload, which is what G42 (no store knows when it is full) asks for — though nothing in the equivalence says how to *choose* `P`, so the parameter is exposed rather than solved.

---

## The continuous variant is *trainable*, not merely writable (Scellier & Bengio 2017)

This page's network has no learning in the machine-learning sense: `W` is a closed-form function of the patterns to be stored, and there is no input–output mapping to fit. Make the units continuous — `E(u) = ½Σᵢuᵢ² − ½Σ_{i≠j}W_ijρ(uᵢ)ρ(u_j) − Σᵢbᵢρ(uᵢ)`, `ρ` a rate nonlinearity — clamp a subset of units as input, and the same energy becomes a supervised learner under **equilibrium propagation**: relax with the output free (`u⁰`), add an external potential `βC = ½β‖y − d‖²` and relax again (`u^β`), then update `ΔW_ij ∝ (1/β)(ρ(u_i^β)ρ(u_j^β) − ρ(u_i⁰)ρ(u_j⁰))`. That is the *gradient* of the squared output error, for any symmetric connectivity. Permutation-invariant MNIST with 1–3 hidden layers of 500 units: 0.00% training error, 2–3% test error.

Two consequences for this page. **Symmetry is not purely a cost.** The `W = Wᵀ` constraint was scored above as buying the Lyapunov function at the price of immobility; it also buys trainability — the recurrence that forbids motion is exactly what lets a perturbation applied at the output travel backwards through the hidden units, so the error reaches every synapse with no backward pass and no weight transport. **The bill moves to inference.** The free-phase relaxation takes 20 / 100 / 500 iterations for 1 / 2 / 3 hidden layers, so what a feedforward net pays once per forward pass this network pays hundreds of times, and the cost grows ~×5 per layer with no accuracy gained ([[wiki/concepts/biologically-plausible-credit-assignment.md]]).

---

## Open problems it leaves (all inherited by its successors)

- **Nothing sets the number of stored patterns.** The write rule cannot refuse, so overload is silent and catastrophic (G42).
- **No similarity structure among memories.** Basins are shaped by pattern correlations, which is exactly the wrong dependence: similar memories should be *distinguishable*, and here they merge.
- **No mechanism for *which* memory to seek.** Retrieval is decided by whatever the initial state happens to be near; there is no query, no bias, no top-down control (until [[wiki/entities/context-modular-memory-network.md]]'s mask).
- **The equivalence exposes `P` without setting it.** The hybrid-Boltzmann form makes the number of stored patterns an architectural parameter instead of an emergent breaking point; nothing says how to choose it, and a hidden unit per pattern must still be allocated by some other system.
- **The stored patterns must be supplied.** As with every store on this wiki, what gets written is another system's problem ([[wiki/concepts/latent-graph-discovery.md]] G1).

---

## Connections

- **[[wiki/entities/spiking-neural-networks.md]]** — where the hybrid-Boltzmann equivalence was noticed and why it matters there: the spiking-generative line needs a store that fits on a chip, and re-expressing this network as `H+P` neurons with `H·P` synapses is a device-count argument, not a capacity one (Tavanaei et al. 2019).

- **[[wiki/concepts/energy-based-models.md]]** — the classical network is the simplest complete instance of the formalism: a quadratic `F(s) = −½ sᵀWs` with inference as descent to a minimum, and its Hebbian write is the source of the "overlapping basins and spurious minima" row that page contrasts with orthogonal (Kanter–Sompolinsky) storage.
- **[[wiki/entities/fcann.md]]** — the same equations with the couplings *measured* rather than learned (`J = −Σ⁻¹` from resting-state fMRI) and the states made continuous, which is what lets a whole brain be treated as one Hopfield landscape; `β → ∞` there recovers exactly this page's binary network.
- **[[wiki/entities/dense-sequence-memory.md]]** — drops the symmetry constraint (`J_ij = Σ_μ ξ_i^{μ+1} ξ_j^μ`) so the fixed points become transitions, and then attacks this page's `0.14N` by steepening the overlap nonlinearity rather than changing the code.
- **[[wiki/entities/context-modular-memory-network.md]]** — keeps this page's weight matrix intact and multiplies it by a context mask, converting one fixed landscape into one landscape per context and making *accessibility* a controllable variable this architecture has no notion of.
- **[[wiki/entities/vector-hash.md]]** — the direct rebuttal of the Hebbian write: here content decides where the minima sit, how deep and how wide, which is the cause of both uneven basins and spurious states; prestructuring the fixed points from a frozen grid code makes them convex, uniform and spurious-free before any data arrives.
- **[[wiki/entities/sparse-distributed-memory.md]]** — the same capacity *per storage element* (Keeler 1988) reached by a different architecture, with the storage elements decoupled from the pattern size, so capacity becomes a hardware choice instead of a property of the word being stored.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — this network as biology: CA3 recurrent collaterals as the weight matrix, with sparse coding and dilution added, giving `p_max ≈ kC/(a ln(1/a))` in place of `0.14N` — capacity set by fan-in rather than by population size.
- **[[wiki/entities/tem-transformer.md]]** — the modern continuation of the last row of this page's failure table: the Modern Hopfield update with a softmax *is* transformer self-attention, so the classical relaxation and the attention layer are one mechanism at two temperatures.
- **[[wiki/concepts/pattern-separation-completion.md]]** — this page supplies the completion half in its purest form (descent from a corrupted state) and none of the separation half, which is why every biologically grounded successor bolts a separating stage onto its input.
- **[[wiki/concepts/energy-based-models.md]]** — where the trainable continuous version is developed in full: `F = E + βC` makes the target a second potential energy, weak clamping (rather than full clamping) keeps both fixed points in one basin, and the resulting contrastive update is the time-integral of an STDP rule.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the outer-product write is the Hebbian rule taken literally and applied once; the network is the clearest demonstration that a purely local, correlation-based rule can install a *global* computational structure (a landscape). The verbal specification predates the formalism: Hebb's cell assembly plus Allport's auto-association already state the same write, including the negative weights for anti-correlated units.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the one-shot write is the fast system's defining capability, and the argument that gradient-based learning cannot be the episodic mechanism (10⁴–10⁶ exposures vs. one episode) is the strongest form of this page's motivation for a two-system architecture.
- **[[wiki/entities/adaptive-cann.md]]** — the continuous-state relative that adds the motion this page's symmetry forbids: a slow adaptation current destabilises the fixed point and turns a static memory into tracking, oscillation or a travelling wave.
- **[[wiki/entities/boltzmann-machine.md]]** — this network with `sgn` replaced by a sampled sigmoid and hidden units added: the landscape is untouched, but the state now *visits* states at rate `∝ exp(−E/T)` instead of halting, which turns recall into generation and buys back the motion this page's symmetry forbids without any asymmetric weight.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the same recognition question answered feed-forward instead of by relaxation: a thresholded overlap against a ~25-bit subsample decides membership in one step with a false-positive rate below 1 in 10⁹ over 10⁶ patterns and degrades gradually, against energy descent that returns the stored pattern itself but pays a capacity cliff and can land in spurious minima.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the regime that makes this model's input semantics the biologically right one: thalamic synapses are <10% of the excitatory synapses in layer 4 and are no stronger individually, yet drive cortex, which forces reading the input as a *cue selecting a basin* under recurrent amplification rather than as a drive summed into the output (Douglas & Martin 2004).
- **[[wiki/concepts/attractor-dynamics.md]]** — the general mechanism this network is the canonical instance of — energy descent to a content-defined fixed point, with its capacity limit and spurious states as the discrete-regime baseline.
- **[[wiki/concepts/recall-gated-consolidation.md]]** — a one-line modification with a proved payoff: keep the outer-product write `W* = xxᵀ` but scale it by `g(x·(Wx))`, so the network consolidates only patterns it has already partly stored, which filters single-presentation patterns out of the weight matrix and raises recall signal-to-noise for the recurring ones.
- **[[wiki/entities/btsp-cam.md]]** — the rival that beats this page's capacity table without any of its machinery: one-shot writes at **1 bit per weight**, matching or exceeding continuous-weight Hopfield recall and reconstruction on sparse patterns, read in one step instead of ~100, with no symmetry constraint, no energy function and no recurrence — while a binary-weight Hopfield network on the same items provides no working CAM at all. The cost is that its capacity is *sequence*-dependent (a later item can depress an earlier one's weights), so this page's set-based capacity theory does not carry over.
- **[[wiki/concepts/engram.md]]** — the same object (Hebb's cell assembly) with a causal handle this formulation cannot offer: an IEG-tagged population is deletable and inducible unit by unit, and silencing it abolishes one memory while sparing all others, whereas a stored pattern here is smeared across every weight and has no address.
- **[[wiki/concepts/equilibrium-propagation.md]]** — what this page's energy becomes when it is asked to learn, and the source of the method's worst number: the free phase costs ×5 iterations per added hidden layer under *this* energy, a fact about the Hopfield landscape rather than about the rule.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the cleanup memory that an unbinding step requires: the approximate inverse returns a noisy filler that must be snapped onto the nearest stored token, which is exactly this page's attractor read, and pairs a compositional code with an item store.
- **[[wiki/entities/conceptor.md]]** — the content-addressable memory this page's construction is explicitly measured against: same cue-and-recall job, but the stored items are *dynamical* patterns rather than static ones, storage is incremental with a readable occupancy quota and no damage to earlier items, and the stored descriptions combine with `∧ ∨ ¬` — three properties an auto-associative network has none of. The price is that nothing settles: retrieval confines an ongoing orbit rather than relaxing to a fixed point (Jaeger 2014).
- **[[wiki/concepts/encoding-retrieval-alternation.md]]** — what this store lacks: writes here are unconditional and content-blind, so a redundant episode costs capacity, whereas alternating a completion read with the encoding write makes the update proportional to what the store did *not* already predict.
