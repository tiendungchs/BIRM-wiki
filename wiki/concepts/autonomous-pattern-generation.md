# Autonomous Pattern Generation

**Emit a precise extended temporal signal when the input carries none of the target's structure — the pattern lives in the dynamics, not in the stimulus.** Birdsong, a pitched throw, hearing a remembered tune with silent eardrums: a stereotyped multi-second trajectory produced by a network that is not being told what to produce (`raw/talk-nd-reservoir-computing.txt`, **(tentative)** — explainer talk, no paper read).

The wiki has extensive machinery for *reading* a temporal stream ([[wiki/entities/simple-cycle-reservoir.md]], [[wiki/entities/s4.md]], [[wiki/entities/ltc.md]]) and for *holding* a state ([[wiki/concepts/working-memory.md]], [[wiki/concepts/attractor-dynamics.md]]). This page is the third case: output with no informative input. It matters for a reasoning model because the *use* half of latent-graph discovery — running a plan, executing a program, replaying a derivation — is exactly this: a long structured output whose structure comes from an internal store rather than from what is currently arriving.

---

## The reservoir formulation

| Component | Statement |
|---|---|
| Reservoir | `x_i[t+1] = σ(Σ_j W_ij x_j[t] + μ_i z(t))`, `W` random and **untrained**, `n ~ 10³` |
| Driver | `z(t)` a simple periodic signal (sine, "background clock"); `μ_i` a per-neuron gain that gives every unit a different phase/amplitude response to the same clock |
| Readout | `y[t] = w_out · x[t]`, a single non-recurrent unit; **the only trained parameters**, fitted by linear/ridge regression in one closed-form sweep |
| Target | `y*(t)` — the song, the motor command; arbitrary within the class below |
| Stability | Weights tuned to the echo state property (ESP): every input leaves a trace that fades. Crank them up and the network self-sustains but becomes chaotic — a one-millisecond misfire diverges into a different pattern, so the output is unreproducible ("you cannot compute with an explosion") |

### Why an untrained random `W` suffices — the Fourier argument

The claim is not that the reservoir computes the song. It is that the reservoir supplies a **basis**, and the readout does a change of basis:

1. Fourier's move on the heat equation: the hard initial profile is unsolvable, but sines are trivial and *span*, so solve per-sine and sum. Sines are a basis; polynomials (Taylor) are another; the choice is free.
2. A random recurrent net driven by one clock emits `n` different squiggles — a **random temporal basis**, a "library of Babel of temporal shapes".
3. If `n` is large enough, the target lies (near enough) in the span, and finding the coefficients is least squares.

The consequence is the reservoir-computing thesis in its sharpest form: **a tangled untrained connectome is not a bug to be trained away but the thing that makes the span rich** — precision engineering of the recurrent coupling is not what produces complex behaviour (`raw/talk-nd-reservoir-computing.txt`, **(tentative)**). This is the *functional* companion to the formal result on [[wiki/entities/simple-cycle-reservoir.md]] that recurrent structure inside the fading-memory class carries no expressive power at all.

---

## The load-bearing point: a periodic driver turns the ESP from a liability into a licence

The ESP says every echo decays, so an unforced contractive reservoir falls silent and can generate nothing of its own. The talk's fix is to keep injecting energy with a clock. What that buys, and what it costs, is exact:

| | Statement |
|---|---|
| **Buys** | Under ESP + a periodic drive, the state converges to a **unique periodic orbit of the driver's period, independent of initial condition**. Generation length is therefore unbounded even though memory is fading — the readout can emit forever without the trajectory drifting or needing any stored state |
| **Costs** | Everything emitted is **period-locked to `z`**. The clock supplies reproducibility by destroying history-dependence: any two moments at the same phase have the same state, so the output at phase `φ` cannot depend on what happened last cycle |
| **So** | The fading-memory horizon is not defeated, it is **relabelled**. The target must be periodic at the driver period (or a rational multiple). Aperiodic, branching, or context-conditioned sequences need something the contractive reservoir does not have |

This is the same boundary [[wiki/entities/simple-cycle-reservoir.md]] draws from the theory side, reached from the generation side rather than the memory side, and it localises what a reasoning-capable sequence generator must add:

- **A phase-breaking variable** — a slow state that differs between cycles, so phase `φ` of cycle 1 and cycle 2 are distinguishable. Non-fading by definition, hence outside the reservoir class ([[wiki/concepts/working-memory.md]]).
- **Selection among stored patterns** — one reservoir plus one readout is one song. `k` songs is `k` readouts, or one readout plus a pattern-index input, and nothing in the formulation says which; the talk does not raise it.
- **Where `z` comes from** — the driver is supplied by the experimenter. Biologically it is attributed to theta/gamma pacemaker rhythms (`raw/talk-nd-reservoir-computing.txt`, **(tentative)**), which relocates the question rather than answering it: something must generate, gate and phase-align the clock, and that something is not in the model.

---

## Placement against what the wiki already holds

| Route to an extended output | Mechanism | What supplies persistence | Failure mode |
|---|---|---|---|
| **Driven random reservoir** (this page) | Contractive `W`, periodic `z(t)`, trained linear readout | The external clock | Nothing distinguishes cycles; chaotic if `ρ(W)` pushed up |
| Autonomous limit cycle | `ρ(W) ≥ 1` self-sustained dynamics | Internal instability | Chaos: sensitivity to initial conditions, unreproducible |
| Antisymmetric coupling `J^A` ([[wiki/concepts/attractor-dynamics.md]]) | Rotation in a fixed landscape | The weight matrix | Direction fixed; a stored trajectory cannot be reversed |
| Trajectory as a fixed point ([[wiki/entities/spacetime-attractor.md]]) | Delay axis in the tuning curve, adjacency-wired delay subspaces | The attractor itself | Trajectory length bounded by the delay axis |
| Chained attractors ([[wiki/concepts/working-memory.md]]) | Noise-driven hops between basins | Basin structure | Timing is not controlled |
| **Conceptor-selected orbit** ([[wiki/entities/conceptor.md]]) | Many drivers internalised into one `W`; a PSD filter `C` in the feedback loop confines the state to one pattern's subspace | The recurrence plus the inserted filter — **no clock needed**, and `C` can be generated on the fly from a 30-step cue | Contractive substrate unchanged, so still one orbit at a time and no cross-cycle state; `C` is `N×N` unless approximated by random features |

The driven reservoir is the **cheapest** of these — no gradient, no backpropagation through time, one regression — and the **least conditional**: the only one whose output cannot depend on anything except the phase of the clock.

---

## Open problems

| # | Problem |
|---|---|
| 1 | **Bootstrapping the clock.** Every version of this hands the network a driver. A self-contained generator has to produce its own, which is the chaos problem again |
| 2 | **Multi-pattern storage and switching** — *answered* ([[wiki/entities/conceptor.md]], Jaeger 2014). Internalise `K` drivers into `W` by ridge regression, then select among them by inserting a data-derived positive semi-definite filter into the loop: `x(n+1) = C^j tanh(Wx(n)+b)`. Four patterns including two near-identical pairs separated at MSE ~1e-5 to 4e-3 in `N=100`; four different chaotic attractors in one `N=500` reservoir. The selector is addressable (one matrix, or one feature-space neuron), blendable (`Σμ^j C^j` morphs, and **negative `μ` extrapolate outside the loaded prototypes**), and combinable by `∧ ∨ ¬`. Residual: the terminate/switch *decision* is still external |
| 3 | **Conditional continuation** — *partly answered by the same mechanism, and the limit is now sharp.* The conceptor supplies a run-time conditioning variable the driver-only formulation lacks, and it can be **generated from the signal itself**: a 30-step cue followed by online auto-adaptation produces a conceptor that recovers the cued pattern (log10 NRMSE −0.4 → −1.1) at SNR = 1. But what is conditioned is *which* stored orbit runs, not what comes next *given* what just ran — the state is still a function of phase within the selected orbit, so cross-cycle dependence remains outside the class |
| 4 | **How many clocks, at what periods.** A bank of drivers at different frequencies is the crudest possible temporal hierarchy and nothing sets its size — [[wiki/architectural-gaps.md]] G67 |
| 5 | **(brainstorm) A clock as a first-class architectural component.** The wiki's models take timescale from a decay constant (`λ`, `τ`, `Δ`), i.e. from *how fast state is forgotten*. A driver sets timescale by *what is re-injected*, which is an independent and unexploited knob: it costs one scalar per unit (`μ_i`), leaves `W` untouched, and — unlike a decay constant — is a signal, so it can be gated, phase-shifted, or itself generated by another network |

---

## Connections

- **[[wiki/entities/simple-cycle-reservoir.md]]** — the formal statement of this page's substrate and its boundary: within the fading-memory class recurrent topology is expressively free, so the random tangle here is doing exactly what a one-parameter ring would do; and the same contractivity that makes the readout fittable is what forces this page's period-locking.
- **[[wiki/entities/hag-reservoir.md]]** — the opposite reading of the same random `W`: this page treats untrained randomness as the source of basis richness, HAG treats it as "the antithesis of the optimal" and grows the edges instead — and HAG's best variants land at `ρ(W) = 1.24–2.89`, i.e. in the self-sustaining regime this page calls unreproducible, held stable only by a saturation rescaling.
- **[[wiki/concepts/attractor-dynamics.md]]** — the rival route to an extended output: a periodically driven contractive network gets a stable trajectory with **no** multistability and no `J^A`, so the pattern is not stored in the landscape at all — the price being that it cannot be conditioned on anything but clock phase.
- **[[wiki/concepts/working-memory.md]]** — names precisely what this page cannot supply: a variable that survives a cycle. Under ESP + periodic drive the state is a function of phase alone, so any generator whose next phrase depends on the last one needs the non-fading store that page is about.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — a temporal hierarchy built from *drivers* rather than from decay constants or termination conditions: `k` clocks at `k` periods with per-unit gains `μ_i` is a bank of timescales that is a signal rather than a parameter, hence gateable at run time (G67).
- **[[wiki/entities/thousand-brains-theory.md]]** — the talk's framing of that theory as a *reservoir of independent cortical columns* (`raw/talk-nd-reservoir-computing.txt`, **(tentative)**): if columns are basis elements and cortical output is a learned mixture, then the theory's consensus step is a readout and its thousands of frames are the span — a reading that theory never states and that would make column *diversity*, not column agreement, the load-bearing property.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the execution half of the framing: once a path through the graph is chosen, emitting it is an autonomous-generation problem, and this page's period-locking result says a fading-memory substrate can emit a fixed cycle but not a path selected at run time.
- **[[wiki/entities/conceptor.md]]** — the run-time conditioning variable this page names as missing, built and measured: `K` drivers internalised into one weight matrix and selected among by a data-derived PSD filter in the feedback loop, addressable by a single neuron, blendable into interpolations *and* extrapolations, and generable from a brief cue instead of from an experimenter-supplied clock. It closes open problems 2 and 3 above as far as a contractive substrate allows, and leaves this page's period-locking boundary exactly where it was.
