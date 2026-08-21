# Mean-Field Reduction — From Spiking Ensembles to Neural Masses and Fields

**Replace a population of spiking neurons by the *density* of its states, and the dynamics become linear and deterministic however chaotic the individual neurons are; keep progressively fewer moments of that density and you descend a ladder — density model → neural mass (first moment only) → neural field (first moment as a function of cortical position, with finite conduction delay) — where each rung buys tractability by discarding one *named* quantity.** This is the machinery every whole-brain model in the wiki runs on, and the page exists to say which rung a given model occupies and what it threw away to get there.

> **Provenance.** Deco, Jirsa, Robinson, Breakspear & Friston 2008, *The Dynamic Brain: From Spiking Neurons to Neural Masses and Cortical Fields*, PLoS Comput Biol 4(8):e1000092 (`raw/deco-2008-dynamic-brain-neural-masses-fields.md`). A derivation-first review that carries the reduction end to end, plus its own microscopic-vs-mesoscopic simulation comparison (250 neurons) that *measures* what the reduction costs, and three applications (decision-making, auditory streaming, absence seizure).

---

## The ladder

| Rung | State object | Evolution | What the step assumes / discards | What it buys |
|---|---|---|---|---|
| **1. Spiking** | `V_i(t)` per neuron | `τ dV_i/dt = −(V_i − V_L) + R I_i(t)`, threshold `θ` + reset | Nothing | Nothing tractable: `O(10⁴)–O(10⁸)` coupled ODEs per column, each neuron contacting `O(10⁴)` others; the map from connectivity to dynamics is not analysable |
| **2. Ensemble density** | `p(ν,t)`, a density over the neuron's phase space `ν = {V, I, T}` | Fokker–Planck `∂_t p = −∂_ν(f p) + ∂²_ν(D p)`, i.e. `ṗ = Qp` with `Q` a **linear** operator | *Mean-field approximation*: afferent currents into a population are uncorrelated, so two neurons at the same `V` are indistinguishable (ergodicity). *Diffusion approximation*: drop Kramers–Moyal terms `k > 2` — exact as `N → ∞` with `J → 0`, `NJ² → const` | **The density evolves linearly and deterministically even when every neuron is chaotic.** The stationary solution is the Ricciardi transfer function `Q_i = φ(μ_i, σ_i)`, so equilibria are found by solving `N` coupled self-consistency equations instead of simulating |
| **3. Modes / moments** | Coefficients `μ = η⁻p` on a basis of eigenfunctions of `Q` | `μ̇ = λμ`, `λ` the eigenvalue matrix | Modes below the spectral gap | All real eigenvalues `≤ 0` (probability is conserved); real part = decay rate, imaginary part = ringing frequency. **Most modes dissipate fast, so a handful suffice** |
| **4. Neural mass** | One number per population — the density collapsed to a point mass | `μ̈_v + 2γμ̇_v + γ²μ_v = κ ς(μ_v)`; equivalently a convolution `μ_v = W(t) ⊗ ς(μ_v)` | **All coupling between moments.** The mean of ensemble A can no longer be affected by the *variance* of ensemble B | The sigmoid `ς` is the compensation: it is the population's threshold distribution reinserted as a static nonlinearity. Cost drops enough to simulate many ensembles |
| **5. Neural field** | `μ(t) → μ(x,t)` on the cortical sheet | Wave equation `(∂_t² + 2γ∂_t + γ²(1 − r²∇²))μ = …`, `γ = c/r`; delayed kernel `W(\|x−x′\|)` evaluated at `T_c = t − \|x−x′\|/c` | Translation-invariant connectivity (true of intracortical fibres, false of corticocortical ones — see below) | Lateral spread, travelling pulses, spiral and target waves, and **finite conduction delay as an explicit parameter**. Subcortical structures enter via a topographic map onto the same coordinate `x` |

**The rung the wiki already lives on without saying so.** Take rung 5, send `c → ∞` (instantaneous propagation), and a centre-on/surround-off kernel gives Amari's one-bump solution of width `a` — i.e. **every continuous attractor in this wiki is the zero-delay limit of a neural field** ([[wiki/concepts/attractor-dynamics.md]], [[wiki/entities/adaptive-cann.md]]). Restore finite `c` and the *same kernel* yields travelling pulses instead of a parked bump. The stability of the bump was never a property of the weights alone; it was a property of the weights at infinite conduction speed.

---

## What the mass reduction actually costs — measured, not argued

Their own comparison: 250 planar (2-D) Hodgkin–Huxley neurons, all-to-all coupling, static parameters throughout, sensory current on from 1000 to 3000 ms.

| | Microscopic ensemble | Neural mass at the same operating point |
|---|---|---|
| Onset | Each neuron bifurcates from noise-driven firing onto a limit cycle; phase locking then **emerges** (nothing in the noise or the coupling changed) | Abrupt transition from noise-perturbed fixed point to large-amplitude oscillation |
| During stimulus | Spike-timing variance contracts **progressively**, not step-wise; kurtosis goes from meso- to leptokurtotic (sub- to super-Gaussian) while the mean-field amplitude keeps growing — moments 1, 2 and 4 evolving *interdependently* with fixed parameters | One dynamical state, held until offset |
| After offset | Damped mean-field ringing for ≈800–1300 ms, because the ensemble ends more synchronised than it began | Oscillation simply stops |

That is the discarded quantity made concrete: **moment coupling is a real, time-dependent computation the mean cannot express.**

**And the reduction is not strictly weaker.** Adding the inhibitory population's mean gives the mass model a *third* degree of freedom, so it can express chaos — which the planar microscopic neuron cannot, chaos needing three dimensions. The coarse-graining trades cross-moment structure for degrees of freedom in the mean, and buys the compute to extend the model spatially. A builder should read the ladder as a menu of trades, not as a series of approximations to a ground truth.

---

## Delay and topology set stability

Split the connectivity `W = W_hom(|x−y|) + W_het(x,y)`, with `W_het = Σ_ij ν_ij` a sum of two-point long-range connections, and ask when the resting state `μ₀(x) = 0` loses stability as a function of the eigenvalues of `W` and the delay `τ = d/c`.

| Finding | Statement |
|---|---|
| **The local kernel does not change the sign of the effect** | Every change to the extrinsic pathways has the same *qualitative* effect on stability regardless of the local architecture. Non-trivial: extrinsic fibres are always excitatory, so an inhibition-dominated local kernel could have flipped the net effect, and does not |
| **Ranking of local kernels by size of the stable region** | purely inhibitory > local-inhibitory/lateral-excitatory > local-excitatory/lateral-inhibitory (the Mexican hat, the one computational neuroscience actually uses) > purely excitatory. The realistic mixed kernels sit in the middle |
| **Non-oscillatory instability ignores delay** | Zero frequency means every part of the system evolves in unison, so transmission speed cannot matter. The only route in is raising the heterogeneous coupling strength `ν` past a critical value |
| **Oscillatory instability is delay-driven** | Raising extrinsic transmission speed — i.e. the myelination ratio `c/c_hom` — *always* enlarges the stable volume. Delay destabilises; speed stabilises |
| **The anatomy behind the split** | Intracortical: unmyelinated, ≤1 cm reach, translation-invariant, mixed E/I. Corticocortical: myelinated (≈10× faster), up to 20 cm, **patchy and not translation-invariant**, delays 50–100 ms |

For a builder this is the cleanest available statement that **conduction delay is a first-class stability parameter of a modular network, separable from weight magnitude, with a different failure mode**: too much coupling gives runaway, too much delay gives oscillation, and the two are independently correctable. It is also why a whole-brain model needs its delay matrix and not only its connectome ([[wiki/concepts/learnable-synaptic-delays.md]], gaps G52/G54).

---

## Input as reorganisation of ongoing activity, not addition to it

A sheet of mesoscopic masses with scale-free internal coupling `C_sheet`, driven through a single sensory node with coupling `C_sens`. Same stimulus current throughout.

| Regime | Effect of the identical sensory current |
|---|---|
| `C_sens > C_sheet` | Spontaneous sheet activity is spatially incoherent; the stimulus **synchronises** it and the array-averaged current rises |
| `C_sens ≈ C_sheet` | Prestimulus activity is already coherent (a stronger internally determined state); the stimulus **desynchronises** it, the array average *falls*, and spatial entropy — the information content of the state — rises |
| `I_noise` below threshold | Spontaneous sheet activity dies out, and its feedback then **completely suppresses** the stimulus-evoked response in the sensory node |

Three transferable claims. (i) Whether a stimulus raises or lowers a network's information content is set by one ratio of internal-to-input coupling, not by the stimulus. (ii) **Top-down gating comes for free** — no gating variable, no attention signal, no third module: the amount of ongoing activity in the recipient population *is* the gate, and driving it to zero closes the input off entirely. (iii) Spontaneous activity is therefore not a baseline to be subtracted, which is the assumption of essentially every evoked-response analysis.

**(brainstorm)** `C_sens/C_sheet` is a candidate answer to the set-point problem [[wiki/concepts/precision-weighting.md]] keeps hitting (G50, G56). What is missing there is a rule for *how much* to weight an input; what this supplies is that the quantity with the two clean regimes is not a gain on the input channel but the **ratio** of internal to external coupling — "input drives the state" versus "input perturbs a computation already running" — which is a comparison a module can make locally from its own activity statistics.

---

## Where multistability has to live: two applications

**Decision-making** (two-interval vibrotactile discrimination, ventral premotor cortex). Method: solve the rung-2 self-consistency equations first to *select* a parameter region where the desired attractors are stable, then run the full spiking network there. Results worth carrying:

- The specific populations' firing rate depends only on `sign(f2 − f1)` and `|f2 − f1|`. **Weber's law is therefore not encoded in the rate — it is encoded in the probability of reaching that rate.**
- Weber's law is reproduced **iff the spontaneous (undecided) state is also stable** — i.e. the operating point must be *multistable*, not merely bistable between the two answers. The "no answer yet" attractor is load-bearing, not a failure mode.

**Auditory streaming** (one stream vs two). A tonotopic neural field feeds a *separate*, non-tonotopic scalar system `y(t)` driven by `I(t)`, the spatiotemporally integrated dispersion of the field. Reproduces van Noorden's diagram — fission boundary, temporal coherence boundary, and the bistable region between them with hysteresis — and the crossing-vs-bouncing percept is simply whether `y(t)` crosses zero. The authors' own emphasis: **bistability and hysteresis are properties of the classification subsystem, not of the neural field.**

The design point those two share: *the representation does not have to be multistable for the percept to be*. One scalar summary statistic of a high-dimensional field, read into a low-dimensional multistable classifier, is far cheaper than engineering multistability into the field itself — and it puts the discrete decision in a place where an "undecided" state can be given its own basin.

---

## Relevance to a reasoning model

- **It names the rung, and the wiki has been silent about which one it is on.** [[wiki/entities/fcann.md]] takes a functional connectome as a coupling matrix and relaxes; that is a rung-4/5 object whose nodes are populations, and everything in the moment-coupling row above is what its dynamics cannot represent about the spiking networks underneath.
- **A derived answer to "how many timescales" (G67).** The eigenvalue spectrum of `Q` supplies both the number of levels worth keeping (modes above the spectral gap) and their time constants (real parts) and frequencies (imaginary parts). Almost everywhere else in the wiki a level count is *chosen*; here it is read off an operator. What the ladder does not supply is the same for a *learned* network, since `Q` is derived from a hand-specified neuron model.
- **A caution for [[wiki/concepts/population-geometry.md]].** Everything population geometry measures is the shape of this page's density. The rung-4 result says that shape carries computation of its own — variance and kurtosis evolving on the stimulus timescale with parameters fixed — so a geometry summarised by its centroid, or a model that only propagates means, is provably blind to it.
- **Delay before weights.** Of the two parameters that decide whether a modular network holds still or oscillates, the wiki optimises one and does not represent the other.

---

## Open problems

- **The founding assumption is violated by the phenomenon.** Rung 2 requires afferent currents to be uncorrelated; the paper's own microscopic simulation shows a stimulus *creating* spike-timing correlation as its main effect. Logged as [[wiki/empirical-tensions.md]] T239.
- **Linear mean-field models predict evoked responses well without any nonlinear dynamics**, while microscopic accounts require bifurcations — the paper calls this "one of the key outstanding problems" and offers two unsatisfying fixes: a multiscale hierarchy with self-consistent equations at every scale (elaborate), or recursively enslaving fine scales to the predicted macroscopic field (which generates spurious sustained mesoscopic oscillations and a possible causal inconsistency).
- **Nothing on the ladder learns.** Every rung is a forward/observation model to be inverted against data. There is no plasticity rule anywhere on it, and the heterogeneous connectivity `W_het` that does most of the work is supplied by anatomy, never recovered. *Partially answered by* [[wiki/concepts/excitation-inhibition-balance.md]] (Schirner et al. 2023): at rung 4, `W_het` is split into an excitatory-targeting and an inhibitory-targeting share per edge, and both are learned online by a homeostatic Hebbian rule whose error signal is the mismatch between simulated and empirical functional connectivity — with the caveat that ~143,000 parameters so fitted are non-identifiable even though their predictions are not.
- **The reduction is one-way.** Given a fitted mass or field model there is no stated procedure for recovering which microscopic ensembles are compatible with it, so an inverted whole-brain model constrains its own parameters and not the circuit.

---

## Connections

- **[[wiki/concepts/attractor-dynamics.md]]** — supplies the ladder rung every continuous attractor here occupies: Amari's one-bump solution is a neural field with a centre-on/surround-off kernel at infinite conduction speed, so bump *stability* is a consequence of deleting delay, and restoring finite `c` turns the same kernel into a travelling pulse.
- **[[wiki/concepts/evidence-accumulation.md]]** — the spiking/mean-field instance of a decision: multistability including the *undecided* state is what reproduces Weber's law, and the discriminating quantity lives in the probability of reaching a firing rate rather than in the rate, which no threshold-on-the-accumulator formulation represents.
- **[[wiki/entities/fcann.md]]** — the wiki's whole-brain attractor model, and the page that this one places on the ladder: its coupling matrix is a rung-4/5 object whose units are populations, so the moment-coupling that rung 4 discards is precisely what it cannot say about the spiking networks it summarises.
- **[[wiki/concepts/learnable-synaptic-delays.md]]** — the delay result at network scale: conduction delay is what decides whether a modular network's resting state loses stability through an oscillatory route, and raising transmission speed (myelination) always stabilises, so a delay is a stability parameter and not only a memory or coincidence parameter.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — a mechanism for the correlations that page measures: in the mesoscopic sheet, stimulus-driven synchronisation is emergent under constant coupling and constant noise, so a rise in coherence between two populations licenses no inference about a change in the link between them.
- **[[wiki/concepts/precision-weighting.md]]** — a candidate set-point rule for G50/G56: the ratio of internal to input coupling `C_sens/C_sheet` has two clean regimes (input synchronises an incoherent sheet; input desynchronises a coherent one and raises its spatial entropy), and it is computable locally from a population's own activity statistics.
- **[[wiki/concepts/population-geometry.md]]** — the density on rung 2 *is* what population geometry measures; the rung-4 result bounds what a mean-only summary can carry, since variance and kurtosis evolve interdependently on the stimulus timescale with every parameter held fixed.
- **[[wiki/entities/spiking-neural-networks.md]]** — rung 1, and the level this page exists to escape: the same leaky integrate-and-fire dynamics, with the reduction stated as an explicit price list rather than as a loss of biological detail.
- **[[wiki/entities/hodgkin-huxley-model.md]]** — the microscopic model used in the comparison, in its planar (two-variable) reduction, which is also why the microscopic system cannot express chaos and the three-variable neural mass can.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — supplies the population identities (pyramidal cells, interneurons, layer of origin) that a neural mass model indexes with its subscript `a`, and the laminar target of the field model's synaptodendritic terms.
- **[[wiki/concepts/temporal-coding.md]]** — the ladder's blind spot stated as a code: rung 4 keeps a rate and discards the spike-timing distribution, and the microscopic simulation shows that distribution contracting progressively during a stimulus while the rate summary shows one abrupt state change.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the ladder is entirely on the *navigate* side: it says how a graph of populations with weights and delays behaves, and supplies no mechanism at all for recovering the nodes, the weights or the delays from observation.
- **[[wiki/concepts/dynamic-repertoire.md]]** — this ladder's rungs assembled on a real connectome and left running: the delay term that appears here as a stability parameter turns out to be a *generator* — zero it in an otherwise identical whole-brain model and the ultraslow structure and anticorrelation disappear, because a network of simple coupled oscillators without delays has a repertoire of exactly one state (Deco, Jirsa & McIntosh 2011).
- **[[wiki/concepts/metastability.md]]** — six of this ladder's rungs assembled on connectomes and compared on one axis: chaotic mass, damped oscillator, Wilson–Cowan limit cycle, phase oscillator, spiking attractor network and linearised rate fluctuations all fit empirical resting functional connectivity best at the edge of a bifurcation, which makes the operating point a stronger constraint than the choice of rung (Cabral, Kringelbach & Deco 2014).
- **[[wiki/concepts/node-definition-problem.md]]** — the coarse-graining choice this ladder does not make: the ladder decides how many moments of a population's density to keep, and that page decides which patch of cortex is a population in the first place — a spatial partition that redistributes relational content between nodes and edges and is made independently of, and before, the choice of rung.
- **[[wiki/concepts/effective-connectivity.md]]** — the inverse direction of this ladder, and the answer to the "reduction is one-way / `W_het` is never recovered" problem above: the same rung-4 mass model plus the Balloon haemodynamic observation model becomes a *generative model to invert*, so long-range coupling, intra-regional recurrence and their signs are estimated from fMRI rather than supplied by anatomy — with every order of magnitude of scale paid for by simplifying the rung (Li & Yap 2022).
- **[[wiki/concepts/structured-flows-on-manifolds.md]]** — the same homogeneous/heterogeneous connectivity split read for a second consequence: here it decides whether the resting state loses stability, there it decides whether the *reduced* dynamics have any structure at all, since a translationally-invariant kernel leaves the system equivariant and its low-dimensional flow degenerate (Hashemi et al. 2025).
- **[[wiki/entities/virtual-brain-twin.md]]** — this ladder built per-individual and priced: the mass→field step costs three orders of magnitude of throughput (25 M vs 25 k iterations/s on one desktop GPU) for a factor of ~1000 in spatial units, and what the finer rung actually forfeits is not simulation but *inversion*.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — the first mechanism in the wiki that *learns* on this ladder, and the answer to the open problem above: the heterogeneous long-range coupling `W_het` this page says is "supplied by anatomy, never recovered" is recovered per edge as an excitatory/inhibitory-targeting mixture by a Hebbian rule driven by a functional-connectivity error — which works only because a local rate-homeostasis rule (Feedback Inhibition Control) first makes the parameter→observable map monotone (Schirner et al. 2023).
- **[[wiki/concepts/anatomical-harmonic-modes.md]]** — this ladder's `W = W_hom(|x−y|) + W_het(x,y)` split measured in human anatomy (`λ = 0.162 mm⁻¹`; `W_het` = weights >3 SD above their distance bin, >40 mm) and used to build an orthogonal basis instead of to test resting-state stability (Vohryzek et al. 2024).
- **[[wiki/concepts/cortical-traveling-waves.md]]** — this ladder's neural-field row taken to the network, with the missing ingredient supplied: restoring finite `c` turns a parked bump into a travelling pulse, but a pulse has no preferred *direction* until the coupling kernel's row sums vary across space — and the effect survives a rung up, with Jansen–Rit masses producing instrength-directed waves 71.8% of the time (Koller et al. 2024).
