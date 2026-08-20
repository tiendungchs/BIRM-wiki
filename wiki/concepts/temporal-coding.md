# Temporal Coding and Coincidence Detection

**Information carried by *when* a spike occurs relative to other spikes — at a resolution finer than any time constant of the circuit that produced it.**

Every other page treating spikes as a substrate ([[wiki/entities/spiking-neural-networks.md]]) asserts that timing carries computational content and cites the claim to a review. This page holds the mechanism and the numbers. Its core result is negative in a useful way: **the precision of a temporal code is not bounded by the speed of the neurons implementing it**, so "the substrate is slow" is not an argument against reading time as the message.

---

## The paradox, stated quantitatively

Barn owl azimuthal sound localization (Gerstner et al. 1996):

| Quantity | Value |
|---|---|
| Behavioural accuracy | 1–2° of azimuth |
| Interaural time difference (ITD) that implies | **< 5 µs** |
| Width of a single excitatory postsynaptic potential (laminar nucleus, modelled) | 250 µs at half-maximum |
| Effective membrane time constant `τ_m` | ~100 µs |
| Presynaptic jitter `σ` (noise + tuning bandwidth) | 40 µs |
| Presynaptic transmission delays, before tuning | 2.5 ± 0.3 ms — spread ≫ the 200 µs period of a 5 kHz tone |
| Mean presynaptic rate | 667 Hz — each afferent skips most cycles |

Every element of the machinery is one to two orders of magnitude coarser than the signal it resolves. Three mechanisms close the gap.

---

## Mechanism 1 — threshold crossing on the rising phase

A leaky integrate-and-fire unit ([[wiki/entities/spiking-neural-networks.md]]) driven by ~154 phase-locked afferents:

```
dv/dt = −v/τ_m + I(t) ,   I(t) = Σ_j J_j · I_j(t) ,   I_j(t) = (1/τ_s) exp(−(t − t_j^f)/τ_s)
```

Coherent arrival makes `v` oscillate at the stimulus period `T`; threshold is always reached **during the rising phase**, where `v̇` is large, so arrival jitter is compressed into a much smaller output jitter.

| Result | Value |
|---|---|
| Output spike precision (vector strength 0.75–0.97) | **20–25 µs** — ~10× finer than the EPSP width |
| Dependence on `τ_m` | Weak (Fig. 3d) — precision survives slower membranes |
| Dependence on coherence | Total. Randomly-phased input gives aperiodic `v` and a uniform output phase distribution |

**The two roles of `τ_m` dissociate.** Output *precision* barely depends on `τ_m`; ITD *tuning* — the modulation depth `(f_max − f_min)/f_max` that makes the cell selective at all — collapses once `τ_m` exceeds 0.1 ms. Short time constants buy **selectivity of the coincidence detector**, not precision of its output. A builder who wants a temporal-difference-selective unit must pay for a fast membrane; one who only wants precise output timing need not.

---

## Mechanism 2 — Hebbian selection over a repertoire of delays

The tuning problem is that a broad delay distribution destroys any phase information. The fix is a plasticity rule that **selects** a subset of an existing random delay bank rather than creating delays:

```
ΔJ_j = ε · J_j · [ γ + Σ_f W(t_j^f − t^n) ]
```

- `W(s)` — learning window, `s` = presynaptic arrival minus postsynaptic firing. Positive for `s < 0` (pre before post → potentiate), negative for `s > 0`. This is [[wiki/concepts/synaptic-plasticity.md]]'s spike-timing-dependent plasticity kernel, **written down two years before it was measured** — the measurement gave ±20 ms lobes separated by a ~5 ms transition zone, with no modification outside a 40 ms total width (Bi & Poo 1998). Both the model's several-millisecond `W` and the measured 40 ms window are far wider than the 200 µs period being tuned, which is the point of the width row below.
- `γ` — a small nonspecific potentiation of every active synapse, justified by depolarization-induced potentiation. Together with `W`'s depressing lobe it makes total input strength **self-normalizing**; no explicit normalization step is needed and zero-efficacy synapses simply vanish.
- `J_j` multiplying the bracket makes the rule multiplicative: the strongest synapses gain the most.

**The multiplicative form is where the model and the measurement part company.** Delay selection here is *self-reinforcing* precisely because the increment scales with `J_j` — strong synapses grow fastest, incoherent ones are driven to zero and removed. The measured spike-timing rule does the opposite: potentiation falls off steeply with the existing weight (`r = −0.72` against log initial excitatory postsynaptic current, essentially absent above 500 pA) while depression is strength-independent (Bi & Poo 1998). A rule with `A₊(w)` decreasing cannot run a winner-take-all over delays by amplitude alone, since the winners stop growing first ([[wiki/empirical-tensions.md]] T76). What survives the substitution is the *sign structure* and the nonspecific term `γ`, which still kill the mistimed synapses; what is lost is the runaway that saturates the survivors **(brainstorm)**.

| Learned condition | Outcome |
|---|---|
| Before learning | 600 synapses, delays ~ `N(2.5 ms, 0.3 ms)`; no phase locking at 2 or 5 kHz |
| After 2 kHz exposure | Surviving delays differ by multiples of `T = 500 µs`; vector strength 0.97 → **20 µs** |
| After 5 kHz exposure | 154 saturated synapses survive, delays spaced by `T = 200 µs`; `v = 0.75` → **25 µs** |
| Binaural, fixed ITD during learning | The rule selects left-ear and right-ear synapses jointly coherent **at that ITD**; output rate and vector strength peak there and drop to a minimum at `ITD = T/2` |

The last row is the one that matters beyond audition: **an unsupervised local rule discovers a latent variable (source azimuth) from timing structure alone**, with no error signal, no target and no supervision — the tuning curve is a by-product of which delays survive competition.

---

## Mechanism 3 — population decoding

A single tuned neuron is precise to 20–25 µs and its ITD tuning curve is only weakly modulated. Behaviour needs 5 µs within one ~100 ms reaction time. Population-vector decoding over `N` independent neurons with ITD-shifted tuning curves:

```
x̂ = (T/2π) · arg( Σ_k n_k · e^{2πi x_k / T} )      accuracy ∝ 1/√(t·N)
```

**~100 neurons over 100 ms suffices for 5 µs.** Weak shared-input correlations rescale the constant without changing the scaling. Two consequences: the single spike is *not* the message even in the wiki's most extreme timing-based code; and the required precision is bought by an integration window 20 000× longer than the resolution achieved.

---

## Design rules a builder can take

| Rule | Statement | Why |
|---|---|---|
| **Place the kernel peak at `s ≈ −t_r/2`** | `t_r` = rise time of the postsynaptic potential | If surviving synapses share a delay modulo `T`, the postsynaptic spike lands ~`t_r/2` after coherent arrival; peaking there means the already-strongest synapses receive the largest increment, which is what makes the selection self-reinforcing rather than diffusive |
| **Kernel width ≠ resolvable structure** | `W(s)` spans several ms while tuning a 200 µs period | Resolution comes from *competition among delays*, not from kernel sharpness. So a 20 ms STDP window does not cap a model's temporal resolution at 20 ms — a standing assumption in rate-based readings of STDP |
| **Shape is generic** | Results do not depend on the specific form of `W`, only on its sign structure and peak location | Frees the kernel from being a fitted object; see [[wiki/concepts/synaptic-plasticity.md]] for the complementary claim that its parameters are *derivable* from membrane dynamics |
| **Delays are the learnable variable** | Plasticity prunes a random delay repertoire; it never creates a delay | A cheap, gradient-free way to make a network temporally selective: over-provision delay lines, let a local rule kill the incoherent ones **(brainstorm)** — the temporal analogue of [[wiki/entities/dendritic-ann.md]]'s fixed sparse connectivity |
| **The mechanism is scale-free** | Multiply all time constants by ~100 → cortical `τ_m` of 10–20 ms → a temporal code accurate to **1–3 ms** | The owl is not a specialist exception; the same construction predicts millisecond cortical codes, which is the paper's own extension to hippocampus, cerebellum and cortex |

---

## Why this matters for a reasoning model

- **It is the quantitative core of [[wiki/empirical-tensions.md]] T1.** The claim "spikes carry information a rate specification cannot express" is here a measured 20–25 µs with an explicit account of where the precision comes from — and, critically, a demonstration that the precision is *not* inherited from fast components. A functional specification that abstracts to rates loses the variable that carries the answer.
- **Coincidence detection is a latent-variable estimator.** The ITD case is the wiki's simplest instance of unsupervised discovery: a hidden scalar (azimuth) is recovered from relative timing by a local rule with no teacher ([[wiki/concepts/latent-graph-discovery.md]]). The estimated object is a single continuous latent rather than a graph, which is exactly the limitation to note — nothing here indexes *which* latent is being estimated, so a network of such units builds a bank of detectors and no relations between them.
- **Delay lines are a memory the wiki does not otherwise have.** A tuned axonal delay stores a *temporal offset* in the wiring, not in a weight matrix, and it is read out for free by any downstream coincidence detector.
- **Periodicity buys precision and costs uniqueness.** A `T`-periodic code is exact within a cycle and ambiguous across cycles — resolved only by combining channels of different `T` (the 2 kHz and 5 kHz populations). This is the residue-code argument for grid modules ([[wiki/concepts/path-integration.md]]) in the time domain, and it arrives with the same unsolved half: nothing here says how multiple periods are combined **(brainstorm)**.

---

## Open problems

- **Selection, not construction.** The delay repertoire is given. Nothing states where a repertoire adequate for an arbitrary latent comes from, or whether delays can themselves be learned.
- **One latent per sensitive period.** The rule tunes to *the* stimulus present during learning; a 2 kHz cell and a 5 kHz cell are different cells. There is no mechanism for one population to hold several temporal hypotheses at once, and therefore none for re-tuning after the sensitive period.
- **Precision is a population property.** Single-unit precision falls 4–5× short of behaviour; the shortfall is closed by averaging over ~100 cells and 100 ms. Any architecture that reads a single spike time as a symbol is claiming more than this evidence supports.
- **Coherence is assumed at the input.** Mechanism 1 requires an already-phase-locked volley; the model does not explain how the *first* stage in the pathway achieves phase locking.

---

## Connections

- **[[wiki/concepts/synaptic-plasticity.md]]** — also the source of this page's one direct empirical conflict: delay selection here needs a *multiplicative* window (`ΔJ ∝ J_j`, strong synapses gain most), while the measured window potentiates only weak synapses and depresses independently of strength (Bi & Poo 1998, [[wiki/empirical-tensions.md]] T76). Otherwise it supplies the rule this page uses and receives from it a design constraint the rule family otherwise lacks: the learning window's *peak location* (`s ≈ −t_r/2`, half the postsynaptic rise time) is what makes delay selection self-reinforcing, and the window's *width* turns out to be unrelated to the temporal resolution the rule can achieve.
- **[[wiki/entities/spiking-neural-networks.md]]** — the substrate whose central claim (timing is the message) this page quantifies: 20–25 µs output precision from 250 µs postsynaptic potentials, with the precision shown to be almost independent of the membrane time constant.
- **[[wiki/concepts/dendritic-computation.md]]** — the same coincidence-detection primitive one level down: a dendritic segment tests for `θ` co-active synapses in a 1–5 ms window, while here a whole neuron tests for coherent arrival in a sub-millisecond window over selected delays, so the two are the same operation at different spatial scales and different `τ`.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the cheapest existence proof in the wiki that a *latent* variable can be estimated by a purely local unsupervised rule (interaural time difference → azimuth), and the sharpest statement of what that does not buy: a bank of detectors with no relations between them.
- **[[wiki/concepts/path-integration.md]]** — the same periodicity trade in a different variable: a code with period `T` is precise within a cycle and ambiguous across cycles, so both pages need several coexisting periods to be unique over a range, and neither has a mechanism that builds them.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — the contrast case: everything here is achieved with no error signal, no target and no backward pass, which sets the bar for what an unsupervised timing-based rule can reach before credit assignment is needed at all. Timing also supplies the missing control signal on the other side: relaxation-based schemes need something to say which phase the network is in, and alpha/gamma rhythms are the standing proposal for multiplexing a feedforward sweep and a gradient relaxation into one continuously-driven circuit (Millidge et al. 2020).
- **[[wiki/concepts/manifold-constrained-learning.md]]** — order as a constraint rather than a code: beyond bounding *which* population patterns are reachable, the measured system also fixes the *direction* in which a sequence of them can be traversed, which is a limit on any model that treats a stored sequence as replayable either way for free (talk-nd-brain-learning-limits, **(tentative)**).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — two downstream junctions where timing, not summed amplitude, is the operative variable: the relative arrival time of ventral-hippocampal and basolateral-amygdalar input sets an mPFC neuron's firing probability, and the same convergence recurs on single nucleus-accumbens neurons where coincidence gates goal-directed action; the ~50 ms hippocampus-leads-prefrontal theta phase lag is the interval a monosynaptic pathway would impose (Spedding & Jay 2012) — and the same wire is **frequency-multiplexed**: theta phase-locking carries the coordination while gamma (30–70 Hz) tracks whether the cue was successfully encoded, with distinct bands carrying distinct functional roles during associative learning (Spellman et al. 2015; Brincat & Miller 2015, in Jin & Maren 2015), so one anatomical connection supports several concurrent logical channels — a construct no wiki architecture has.
- **[[wiki/concepts/contextual-inference.md]]** — where that window becomes a computational constraint: if context and valence evidence must coincide to be fused, an inference scheme that sums channels whenever they arrive is over-permissive relative to the biology.
- **[[wiki/entities/nucleus-reuniens.md]]** — synchrony without a phase computation: a single midline-thalamic axon collateralising to both hippocampus and prefrontal cortex delivers the same spike to both, so coordinated timing between two modules can be a wiring property rather than something either module estimates.
