# Cortical State Bistability — Two Antagonistic Oscillatory Regimes, One Gating Update Against Stability

**A cortical population alternates between two mutually suppressing burst regimes: a beta (20–40 Hz) regime that *synchronises whichever ensemble currently holds the content* and blocks its replacement, and a low-frequency (1–9 Hz) regime that *dissolves that synchrony* and licenses a new ensemble to take over. The state variable is content-free — it says "hold" or "release", never *what* is held — and it moves **first**: the low-frequency regime ramps up ~200 ms before an internally generated content switch, while the content-selective units cross over ~200 ms *after* it. Update is therefore not a consequence of the winning representation getting stronger; it is a permission granted by a global state, and the representations only report the outcome.**

> **Provenance.** Dwarakanath, Kapoor, Werner, Safavi, Fedorov, Logothetis & Panagiotaropoulos 2023, *Bistability of prefrontal states gates access to consciousness*, Neuron 111(10):1666–1683.e4 (`raw/dwarakanath-2023-prefrontal-bistability-consciousness.md`, bioRxiv v4). Two macaques, chronic 10×10 Utah arrays (400 µm pitch, 1 mm electrodes → middle layers) in the ventrolateral prefrontal inferior convexity — the same preparation as [[wiki/entities/global-neuronal-workspace.md]]'s unit-resolution evidence (Kapoor et al. 2022). No-report binocular rivalry with optokinetic nystagmus as the perceptual read-out; 573 spontaneous transitions, 1322 physical alternations, plus piecemeal, sustained-dominance and resting-state controls.

---

## The two states

| | **Beta regime (20–40 Hz)** | **Low-frequency regime (1–9 Hz)** |
|---|---|---|
| Form | Bursts, not sustained oscillation (min. detected duration 25 ms) | Bursts (min. 111 ms), appearing as negative broadband deflections |
| Occupancy | Periods of stable conscious dominance; the default resting regime | Transient, ~300 ms of beta suppression per event |
| Relation to content | **Selective for it indirectly**: after a switch, the *dominant* ensemble's spikes are significantly more coherent with beta (~25–37 Hz) than the suppressed ensemble's | **Blind to it**: a global, array-wide event with no content selectivity of its own |
| Effect on the other | Suppressed during low-frequency bursts | Suppresses beta; burst rates anti-correlated (`r = −0.08, p = 0.0071`) |
| Functional reading | Status-quo lock: shields the incumbent from interference and lowers detection rate for new input | Release: dissolves the beta-coherent coalition, raising the suppressed ensemble's chance to fire |

**The ordering flip is the whole measurement.** The same low-frequency-burst-suppresses-beta motif occurs in both conditions, and its *sign relative to the perceptual change* is what differs:

| Condition | Low-frequency burst timing relative to the perceptual transition |
|---|---|
| Physical alternation (input actually changes) | **After**: +64 ± 147 ms (median ± SD); peak rate +52 to +82 ms. This is the visual evoked potential — a consequence |
| Binocular rivalry (input constant, switch spontaneous) | **Before**: −114 ± 190 ms; peak rate −160 ± 237 ms; last pre-switch burst at −198 ± 133 ms, which is *earlier* than the end of the previous dominance period (−97.4 ± 140 ms, `p < 10⁻⁶⁷`) |

So under a constant input the release event precedes the end of the incumbent's own dominance. The state does not follow the content losing; the content loses because the state released it.

---

## It is a genuine threshold, not a large fluctuation

Four controls, all on the same array, separate "a burst happened" from "enough burst happened":

| Condition | Low-frequency burst rate (events / transition / channel) | Sites recruited | Outcome |
|---|---|---|---|
| Randomly triggered during sustained dominance | **0.015 ± 0.0005** | 51% | No switch — this is the noise floor |
| Before a transition to **piecemeal** (perception favours neither) | 0.147 ± 0.004 | — | Switch *attempted and failed*; beta antagonism absent (`r = −0.007, p = 0.81`) |
| Before a **clean spontaneous** switch | **0.17 ± 0.0016** | **100%** | Switch completes; beta antagonism present |
| After a physical switch | 0.36 ± 0.0046 | — | Evoked, not gating |

An order of magnitude separates the noise floor from a completing switch, and the piecemeal row sits between them — a **sub-threshold commit**, which is the cleanest instance in the wiki of the failure mode [[wiki/concepts/ignition.md]] predicts and no wiki architecture can produce (a continuous mixture degrades smoothly; it has no "half-committed and therefore incoherent" state).

**Two build-up modes run at once, and they differ in shape:**

| Quantity | Before a spontaneous switch | Before a physical switch |
|---|---|---|
| Low-frequency burst **amplitude** | **Linear ramp**, slope 0.61, adjusted `R² = 0.34` | Flat, `R² = −0.003` |
| **Number of prefrontal sites** bursting (early −500…−333 ms → late −167…0 ms window) | **Abrupt, non-linear increase** (`p < 0.01`) | — |

A graded scalar and a discrete recruitment event in one process: the amplitude integrates, the spatial spread ignites. This is the accumulate-then-commit decomposition [[wiki/concepts/evidence-accumulation.md]] assumes and rarely gets to see separated, and it is running here on **no external evidence at all**.

---

## The state leads the content, and by how much

| Event | Time relative to the perceptual transition |
|---|---|
| Low-frequency burst times | −114 ± 190 ms |
| Low-frequency peak burst *rate* | −60 ± 222 ms |
| **Crossover of the two competing ensembles' population firing rates** | **+209 ± 295 ms** |

The spiking crossover follows the low-frequency peak in **86.2%** of transitions and the burst times in **89%**. The source's conclusion, stated flatly: *"the driver of perceptual reorganisation and update is not the spiking activity of selective neuronal ensembles; rather it is a global state signal (the neurons only seem to report the active percept)."*

**Why this is architecturally sharp.** Every competition account in the wiki — [[wiki/concepts/attractor-dynamics.md]]'s adaptation-plus-noise hopping, winner-take-all softmax, mutual inhibition between coding populations — puts the switch *inside* the content-coding layer: the incumbent adapts, the challenger wins, and any global signal is a downstream consequence. Here the global signal is upstream by ~300 ms. That is a two-layer design — **a content layer and a content-free permission layer with its own dynamics** — and nothing in the wiki has the second layer as a separate object. Logged as [[wiki/empirical-tensions.md]] T273.

---

## The handover mechanism: phase, not gain

The most implementable result on the page. Spike–LFP phase locking in the low-frequency band, measured per site by preference:

| Site preference | Locked phase | Consequence |
|---|---|---|
| Prefers the **currently suppressed** stimulus (about to win) | **169.2°** — the depolarising phase | Membrane pushed *toward* threshold; firing probability up |
| Prefers the **currently dominant** stimulus (about to lose) | **−147.6°**, from ~750 ms before the switch | Membrane pushed *away* from threshold; firing probability down |

One shared oscillation, two populations riding opposite phases of it, and the handover is complete without any change in synaptic weights, any change in input, or any explicit inhibition of the incumbent. **The gate is multiplicative in time rather than in amplitude.**

**(brainstorm) The machine import.** A layer-wide low-frequency carrier `cos(ωt + φ_i)` with a per-unit phase offset `φ_i` gives a *free, weight-free* scheduler: units at φ ≈ π are gain-boosted this cycle, units at φ ≈ 0 are attenuated, and re-assigning φ is a one-dimensional, differentiable action that hands control from one sub-population to another. Compare the alternatives already in the wiki: a softmax over units is `O(n)` parameters of arbitration re-computed every step, and a gating vector must be *produced* by something. A phase offset is one scalar per unit, persists between events, and — the property that matters — makes "who is next" representable **before** the switch, which is exactly the ~750 ms lead the recording shows. What no source here supplies is how φ is learned or assigned; it is the same missing write-rule as [[wiki/concepts/ignition.md]]'s threshold (gap `G91`).

---

## It runs with no input at all

Resting-state recordings, no visual stimulus, no task:

| Quantity | Resting state | Binocular rivalry (psychophysics) |
|---|---|---|
| Regime | Same low-frequency bursts suppressing beta | Same |
| Dwell time of uninterrupted beta | **1.2 ± 1.44 s**, gamma-distributed (BIC 2.3×10⁵ gamma vs 2.9×10⁵ exponential) | **1.54 ± 1.28 s**, gamma-distributed |

The alternation is **intrinsic**: rivalry does not create it, it merely gives the alternation something to alternate between. A gamma (not exponential) dwell distribution means the switch is not a memoryless Poisson event — hazard rises with time held, which is the signature of an accumulating process, and it matches the ramp above.

**This is the cheapest available generator for gap `G90`.** The wiki's previous best instance (Kapoor et al. 2022) showed an internally generated *content* change under constant input. This one shows the underlying oscillator running **with the input removed entirely**, at the same rate, which is stronger: the internal mode is not a re-reading of ambiguous input, it is a free-running clock that the input is merely sampled by. And the dwell-time match gives an architecture a calibration target that costs nothing to measure — the idle-mode alternation rate and the task-mode alternation rate should be the *same number*, and any system where they differ has a stimulus-driven scheduler rather than an intrinsic one.

---

## Where it sits relative to ignition

| | This page's low-frequency event | [[wiki/concepts/ignition.md]]'s ignition |
|---|---|---|
| Trigger | Endogenous ramp, or an external stimulus change (VEP) | Sensory evidence crossing threshold |
| Content | **None** — content-free release signal | The committed content itself |
| Timing | ~200 ms **before** the content changes | ~200–300 ms **after** the stimulus |
| Evidence of all-or-none | Piecemeal failure, 51%→100% site recruitment | P3 step, seen/unseen trajectory divergence |
| What it does to competitors | Dissolves the incumbent's beta coherence | The winner suppresses them |

The source's own proposal is that they are the same event seen at two levels — *"prefrontal gating could be the consequence of such an ignition event"* — with the low-frequency transient as the mesoscopic correlate of the ignition, and the feature-selective ensembles' non-linear rise **130–220 ms after the mean low-frequency burst** as the broadcast that follows. That ordering is consistent with the framework and adds the piece it lacked: **an admission event that fires with no admission request**, which no formulation of ignition-from-sensory-evidence predicts.

**The residual disagreement with the companion recording.** Kapoor et al. 2022, same lab and same tissue, report that the strong transient accompanying *externally imposed* dominance is **absent** at spontaneous switches. This paper reports a low-frequency transient that is *present* before spontaneous switches. Both are true and they are different signals — the first is a spiking transient in feature-selective units (a content event), the second a perisynaptic field event (a state event), and the whole point of this page is that they dissociate. A builder should read the pair as: *the content layer shows no onset burst when the switch is internal; the state layer does.*

---

## What this gives an abstract-reasoning architecture

| Property | Design consequence |
|---|---|
| **A content-free hold/release variable with its own dynamics** | Separates "what is being held" from "may it be replaced", which every wiki architecture fuses. A system can then protect a partial result from interference *without* raising its activation, and can release it without a competitor being ready |
| **Release leads content by ~200–300 ms** | A step boundary is predictable in advance from a signal that carries no content — so a controller can pre-fetch, pre-commit resources, or veto a switch before the switch exists |
| **Sub-threshold release produces incoherence, not a smooth blend** | Gives the failure mode a name and a detector: piecemeal is what a half-executed commit looks like. Architectures should be able to *report* this state rather than emitting an averaged answer |
| **Handover by phase offset** | Scheduling as a one-scalar-per-unit, weight-free, persistent assignment (above) |
| **Intrinsic, input-independent alternation at a matched rate** | An idle-time clock that does not need to be started, and a calibration identity (idle rate = task rate) that is checkable in any implementation |
| **Beta occupancy lowers sensitivity to new input** | The status-quo state has a *measurable cost* — in rats, higher spontaneous beta burst rate lowers true-positive detection of a vibrotactile stimulus (Karvat et al. 2020) — so stability and openness trade off on one axis, and a system that never releases is a system that stops perceiving |

**(brainstorm) The same machinery is claimed for cognitive control.** The source notes rule-selective prefrontal ensembles are beta-coherent, with low-frequency activity inhibiting a rule that is about to be de-selected (Jensen & Bonnefond 2013) — i.e. the identical hold/release pair, with a rule in the slot instead of a percept. If that generalises, then *task-set switching and perceptual switching are one mechanism operating on different payloads*, and [[wiki/concepts/cognitive-control.md]]'s task-set bias should be implementable as an occupancy of this same state variable rather than as a separate module. The testable consequence: a system's perceptual alternation rate and its task-switch cost should be governed by one parameter.

---

## Open problems

- **No learning rule for either the threshold or the phase assignment** — same gap as [[wiki/concepts/ignition.md]] (`G91`). What sets the burst rate at which a switch completes, and what assigns a unit its phase, is unmeasured and unmodelled.
- **The anti-correlation is weak in absolute terms** (`r = −0.08`). The state antagonism is highly significant across ~10⁴ events but explains little single-event variance, so "bistable" describes the regime statistics, not a per-event switch that could be read off one channel.
- **Correlational throughout.** Nothing is stimulated; the ~300 ms precedence licenses "the state is not a consequence" but not "the state is the cause". The discriminating experiment — drive low-frequency bursts and ask whether switch rate rises — is not run here, and is exactly the perturbation instrument [[wiki/concepts/perturbation-elicitability.md]] describes (whose prefrontal elicitation rate is 0%, though it perturbs *sites*, not *rhythms*).
- **Two animals, one cortical patch, one feature dimension** (direction of motion), middle layers only. Whether the same two states gate non-perceptual content is asserted from a different literature, not measured.

---

## Connections

- **[[wiki/concepts/ignition.md]]** — the same commit measured one level down and one step earlier: this page supplies the admission *event* that the unit-resolution rivalry recording could not see, and it fires ~200 ms before the content changes with no stimulus to trigger it, which no evidence-crossing-threshold formulation predicts.
- **[[wiki/entities/global-neuronal-workspace.md]]** — the framework the two states are offered as a mesoscopic mechanism for: low-frequency release as the ignition correlate, feature-selective ensembles rising 130–220 ms later as the broadcast, and beta coherence as the maintenance of the currently broadcast content.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — a third band rule, orthogonal to that page's two: beta indexes *occupancy* (whose spikes are coherent with it identifies the current content-holder) and low frequency indexes *release*, so a band can type a computational state and not only a channel or a direction.
- **[[wiki/concepts/metastability.md]]** — the dwell-time statistic given a mechanism: gamma-distributed beta occupancy of 1.2 s at rest, matching 1.54 s perceptual dominance, is `σ_R`'s churn measured as an explicit hold/release alternation rather than inferred from an order parameter.
- **[[wiki/concepts/evidence-accumulation.md]]** — accumulation running with no evidence: a linear amplitude ramp plus a non-linear spatial recruitment, terminating in a commit, driven entirely by intrinsic dynamics under constant input — and piecemeal transitions are the sub-threshold arm the drift-diffusion account has no state for.
- **[[wiki/concepts/attractor-dynamics.md]]** — the rival account, and the tension: adaptation-plus-noise hopping puts the switch inside the content-coding populations, whereas the ensembles here cross over ~300 ms *after* the state event, so the landscape whose basins are being escaped may not be the content layer's ([[wiki/empirical-tensions.md]] T273).
- **[[wiki/concepts/temporal-coding.md]]** — phase used as a control variable rather than as a code: opposite phase locking (169.2° vs −147.6°) hands excitability from the incumbent to the challenger with no weight change, which is scheduling by phase offset.
- **[[wiki/concepts/cognitive-control.md]]** — the claimed generalisation: beta-coherent *rule* ensembles de-selected by low-frequency activity would make task switching and perceptual switching one mechanism with different payloads, collapsing task-set bias into occupancy of this state variable.
- **[[wiki/concepts/activity-baseline.md]]** — where the alternation lives when nothing is asked: the same low-frequency/beta cycle runs in resting state at a matched rate, so the idle mode is this oscillator free-running rather than a distinct network state.
- **[[wiki/concepts/perturbation-elicitability.md]]** — the missing instrument for this page's causal claim: precedence by 300 ms is not causation, and the untried experiment is to drive the rhythm rather than the site — which is a different perturbation from the one that returns 0% in prefrontal cortex.
- **[[wiki/concepts/working-memory.md]]** — the protection problem stated in this page's terms: beta occupancy shields the held item from replacement while *lowering* sensitivity to new input, so maintenance is not free and the cost is paid in detection.
