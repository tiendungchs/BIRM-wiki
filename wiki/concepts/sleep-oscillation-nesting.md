# Sleep-Oscillation Nesting

**The hippocampo-cortical consolidation channel is not always open: a three-rhythm nesting — ripple inside spindle trough, spindle inside slow-oscillation up-state — is the *timing protocol* that says when a transfer window exists, and the same nesting sets the sign of the plasticity that happens inside it.**

> **Provenance.** Klinzing, Niethard & Born 2019, *Mechanisms of systems memory consolidation during sleep*, Nat Neurosci 22:1598–1610 (`raw/klinzing-2019-mechanisms-of-systems-consolidation-during-sleep.md`). Review of rodent and human neurophysiology and behaviour. [[wiki/concepts/offline-replay.md]] says *what* travels the channel and [[wiki/concepts/complementary-learning-systems.md]] says *between which stores*; this page is *when the channel is open, who opens it, and what happens if the cargo arrives outside the window*.

---

## The three rhythms, and what each contributes

| Rhythm | Generator | Frequency (human) | Spatial extent | Contribution |
|---|---|---|---|---|
| Slow oscillation (SO) | Cortical networks, layers 2/3 and 5; propagates anterior→posterior, reaches hippocampus | <1 Hz | Global | Down-state sets the frame; succeeding up-state is the window of excitability and plasticity |
| Spindle | Thalamus — reticular nucleus (TRN) ↔ relay nuclei interaction; spreads to all neocortex and to hippocampus | ~12–15 Hz | **Local** — more confined than SOs | Opens the cortical plasticity window; localisation is what could *address* a specific memory network |
| Sharp-wave ripple | Hippocampal CA1, on a large depolarising sharp wave | ~80 Hz (human) | Hippocampal, with cortical ripple-like counterparts | Carries the reactivated ensemble; simultaneously **downscales** the hippocampal synapses that generated it |

**The nesting:** SO up-state → thalamic spindle nests in it → hippocampal ripples phase-lock to the spindle's excitable **troughs** (spindle–ripple events). Learning increases the coupling of all three, and the degree of coupling during post-encoding sleep predicts recall.

**The outermost level measured in spikes rather than field potentials** (Ji & Wilson 2007, `raw/ji-2007-coordinated-replay-visual-cortex-hippocampus.md`): identifying up-states from multiunit activity gives **frames** — cortical 0.96 s mean / 0.67 s median, hippocampal 0.78 s / 0.50 s, at ~47 and ~42 min⁻¹ — and the nesting is **one-to-many and loose**, not one ripple per window: a single frame contains none, one, or several ripples, and the cortical-to-hippocampal frame cross-correlogram peaks are broad, so there is no one-to-one frame pairing across the two areas. Two consequences for the protocol above. The conjunction is a *rate* condition, not a per-event pairing — a window can open and carry nothing. And ~93% of frames carry no detectable replay at all ([[wiki/concepts/offline-replay.md]]), so an open window is much commoner than cargo.

---

## The loop has both directions, so no single structure is the scheduler

| Direction | Link | Evidence |
|---|---|---|
| Top-down | Cortical SO up-state drives thalamic spindle generation | Steriade's classical result; SO-up-phase-locked spindles are the effective ones |
| Top-down | Spindle synchronises hippocampal ripples to its troughs | Optogenetic thalamic spindles phase-lock ripples **whether or not** an SO up-state is present |
| Bottom-up | Hippocampal ripples can directly induce SOs in medial prefrontal cortex | Ripple precedes the mPFC SO–spindle event by ~130 ms |
| Bottom-up | Thalamic spindles feed back to cortex to facilitate the *next* SO | Matters when several SO cycles run in a row; spindle-generator refractoriness is what ends the cycling |
| Cortex→hippocampus→cortex | Auditory-cortex ensemble patterns in the 400 ms before a ripple predict CA1 spiking **during** it (`P = 2.7 × 10⁻⁶` at −200–0 ms); CA1 patterns during the ripple predict AC spiking **after** it (`P = 1.3 × 10⁻⁵`); **both reverse arms null**, and nothing in either direction outside ripples | Rothschild, Eban & Frank 2017 (`raw/rothschild-2017-cortical-hippocampal-cortical-loop.md`), now read first-hand. Sounds played in NREM sleep bias pre-ripple AC patterns for **2–14 s** after the series ends, and the biased patterns predict ripple content — cortex *tells the store which memory to reactivate*, and an experimenter can set the message |
| Top-down, at the outermost level | Cortical and hippocampal population activity are both organised into **frames** (elevated-activity periods bounded by synchronous silence); cortical frame onsets lead hippocampal ones by ~50 ms and offsets by ~40 ms, and hippocampal ripples fall almost only *inside* frames, ~30 ms after frame onset | Ji & Wilson 2007 (`raw/ji-2007-coordinated-replay-visual-cortex-hippocampus.md`). Hippocampus has no reported intrinsic up/down mechanism, and its interneurons are phase-locked to cortical state transitions — so the store's outermost offline clock is **imposed**, not generated |

So the top-down arm does not only set *when* the hippocampus replays (when cortex is in an excitable up-state) but contributes to *which* memory is replayed — the selection problem [[wiki/concepts/offline-replay.md]] assigns to the store is partly solved by the receiver. See [[wiki/empirical-tensions.md]] T373 for the unresolved question of which structure leads.

**The Rothschild row also answers this page's second open problem halfway.** "What informs the spindle of its target" asked for an addressing variable with the spatial resolution of a spindle and a source other than the slow oscillation. A sound-set bias in the cortical ensemble pattern that persists **seconds** past the stimulus, is set in the target area itself, and measurably shifts what the next ripples contain, is exactly the shape of such a variable — it is local (one sensory area), slow relative to the rhythms it selects among, and independent of the SO. It is not the thalamic attentional tag proposed above, and the two are testable against each other: the tag is laid down at *encoding* and decays, the cortical bias can be *re-set at any time during sleep* by a cue. Cost, stated in the same source: cueing lowers the overall ripple rate (`P = 10⁻⁸⁷`), so addressing is paid for in throughput unless the cue is already familiar.

---

## Inside the window: a circuit condition, with a sign that flips

Two-photon calcium imaging in naturally sleeping mice, during SO–spindle events:

| Population | Activity | Consequence |
|---|---|---|
| Pyramidal cells | Maximal | The target is depolarised |
| Parvalbumin<sup>+</sup> interneurons (**somatic** inhibition) | Maximal | Output firing is clamped — the cell can be written without broadcasting |
| Somatostatin<sup>+</sup> interneurons (**dendritic** inhibition) | Low | The **dendrite is released**, so top-down/hippocampal input reaching it is maximally effective |

This is a **write-enable with the read-out muted**: the same circuit state supports plasticity during wakefulness, so the sleep protocol is not a separate mechanism but a scheduled entry into a state cortex can also occupy awake. It also gives the compartment story a consolidation job — the receptive compartment is the apical dendrite, the standard target of feedback and of hippocampally-originating input ([[wiki/concepts/dendritic-computation.md]]).

**The sign flip:** an SO whose up-state contains **no nested spindle** primarily *depotentiates* cortical synapses. The window is not merely absent when the protocol is violated — the same event with one component missing runs the opposite operation. Four further results make the timing, not the rhythm, the operative variable:

| Manipulation | Result |
|---|---|
| Optogenetic 8 Hz TRN stimulation inducing spindles during post-learning SWS | Enhances context-conditioned fear memory **only** when phase-locked to spontaneous SO up-states |
| Closed-loop / transcranial slow-oscillation stimulation in humans | Enhances retention — plausibly by driving up-state-locked spindles rather than by the SO itself |
| Ageing | Reduced overnight consolidation correlates with **mistimed** spindle-to-SO coupling, not with spindle loss |
| Transcranial direct-current stimulation in mild cognitive impairment | Improves SO–spindle coupling *and* memory together |

**(brainstorm) The builder's version is a two-signal gate, and no machine consolidation scheme has the second signal.** Every replay implementation in the wiki writes whenever a sample is drawn. Here the write requires a conjunction of (i) a global *window* signal from the slow learner and (ii) a local *address* signal that says this subnetwork is the one being updated, with the default outside the conjunction being **decay**, not no-op. That is implementable as: a periodic phase variable over the slow learner; a per-module receptivity mask; write only in-phase-and-masked; apply weight decay to the in-phase-but-unmasked. It makes forgetting a *by-product of the same schedule* that does the writing, which is what [[wiki/gaps/g014.md]]'s add-only mechanisms lack.

---

## The transfer is embedded in global downscaling

The synaptic homeostasis hypothesis: waking encoding upscales glutamatergic synapses globally; sleep downscales average connectivity back to baseline (reduced axon–spine contact area, reduced synaptic AMPA receptor levels, falling firing rates and cortical excitability). Consolidation is the *local exception* to this global decline — overall synapse number falls while specific spines are preserved, enlarged or newly formed.

| Stage | Proposed division of labour |
|---|---|
| Slow-wave sleep | Primarily **strengthens** engram ensembles; protects and promotes new spines in reactivated cells (rotarod motor cortex, reactivation-dependent); LTP-like increase in evoked responses |
| REM sleep | Primarily **global downscaling and pruning**, while *protecting* a subset of newly formed spines; blocking dendritic calcium spikes blocks both the strengthening and the elimination |

Two caveats the source states: the functional evidence for downscaling (firing rates, excitability) is confounded with cell-intrinsic plasticity and with an excitation/inhibition shift; and the scaling is regulated **per dendritic branch**, not per synapse and not per cell — the branch is the unit of the consolidation bookkeeping.

**The sequential hypothesis, with a mechanism:** natural REM is always preceded by non-REM, and the ripple/spindle content of the preceding SWS predicts the REM-associated firing-rate decreases and immediate-early-gene expression. Reading: SWS **tags** what to keep, REM **prunes everything else**. REM theta phase is the proposed selector — place cells for a *novel* location reactivate at the theta **peak** (strengthening), the same cells shift to the **trough** (weakening) once the environment is familiar, so novelty sets the sign of a cell's REM update. The source flags the tag→prune link as speculative.

---

## The thalamus may be the addresser, not the relay

The received picture makes the thalamus a spindle generator under cortical command. Five observations push against it:

- Spindle activity predicts sleep-dependent memory gains **more consistently than SOs** do; stage-2 spindles support consolidation with no prominent SOs present.
- In development, spindles appear **before** slow waves, and consolidation in human infants correlates with spindle activity rather than with SO or delta activity.
- Spindles are **localised** where SOs are global, so they are the only one of the three with the spatial resolution to target a specific memory network.
- **The SO's location does not predict the location of the spindle nested in its up-state** — so something other than the SO tells the spindle *which* network to enhance.
- Sensory thalamus can be the **source** of the consolidated content: a novel oriented grating produces orientation-specific response potentiation in LGN *during encoding*, the matching potentiation appears in V1 only **after sleep**, and optogenetically silencing V1 layer-6 corticothalamic neurons destroys the LGN–V1 spindle/slow-wave coherence and blocks it. A relay nucleus encoded stimulus-specific information fast and instructed cortex offline.

**The shared-gate argument.** TRN neurons divide by projection target: *sensory-projecting* TRN cells lock to alpha during waking attention and to spindles during sleep (at opposite phases of the two rhythms); *limbic-projecting* TRN cells gate anterior thalamic nuclei, are unmodulated by spindles or attention, and are **strongly suppressed during SWS** — releasing the limbic route exactly when hippocampal output must flow. Spindle power correlates positively with sensory-projecting and negatively with limbic-projecting TRN firing. The proposal (explicitly speculative in the source): waking attention leaves a *tag* in the thalamic network it selected, and the same local network generates the spindles that address consolidation to that cortical target — **one gating circuit serving attention awake and memory-selection asleep**.

**(brainstorm) This is the cleanest candidate in the wiki for an architecture that reuses its attention mechanism as its consolidation scheduler**, and it is cheap to test: let the same key-query machinery that selected a subnetwork online determine which modules are unmasked in the offline phase, with the mask decaying over the interval. It predicts a signature nothing else does — offline updates should be *most* concentrated exactly where online attention was, independent of prediction error or reward. Contrast [[wiki/concepts/replay-prioritisation.md]], where priority is recomputed from value at sample time.

---

## What consolidation does to the *content*, and on what timescale

| Claim | Evidence | Caveat |
|---|---|---|
| Sleep yields gist, categories and rules, not just retention | Infant word-category and grammar abstraction; adult category formation and linguistic rules; sequence-rule abstraction correlated with spindle and SO activity; insight into hidden rules | Nap studies (3 h) do not replicate the insight effects; DRM results are inconsistent, one study finding gist memory *reduced* after sleep |
| Abstraction needs a **long** delay unless a schema is available | Visual DRM gist benefit appears at 1 year and not at 1 day; rodent object-recognition benefit appears at 2 weeks; rapid (<24 h) cortical assimilation happens only with a suitable pre-existing schema | This makes most of the sleep-and-generalisation literature under-powered by design — it measures at the wrong delay |
| Near-term, sleep *strengthens* the episodic/contextual representation | Context-binding at recall is enhanced after short retention intervals in humans and rodents | So "decontextualisation" is not a transformation of a cortical copy but the **fading of the hippocampal one**; while it is intact it dominates retrieval and hides the abstracted representation |
| The fading may itself be active | Ripples downscale the hippocampal synapses of the ensembles they reactivate; spindles reaching hippocampus are expected to *support downscaling* there while doing the opposite in cortex | Preliminary; one behavioural result (sleep accelerates decontextualisation, visible only at 3 days) |

**The sign asymmetry is the most useful thing here for a builder.** The *same* event — a spindle-nested ripple — is proposed to potentiate in the cortical target and depotentiate in the hippocampal source. Transport and erasure are one operation, not two scheduled ones, which is the missing half of every replay implementation in the wiki: they copy from the fast store without ever emptying it, and then need a separate capacity policy ([[wiki/concepts/memory-read-and-erase.md]], [[wiki/entities/rolls-treves-hippocampal-model.md]]'s reallocation-by-overwriting).

---

## Open problems

- **Which structure leads the loop** ([[wiki/empirical-tensions.md]] T373 for the cortex-vs-thalamus arm, T377 for the cortex-vs-hippocampus one) — and with it, whether a machine consolidation scheduler belongs in the slow learner or in a separate relay. The frame result above split the cortex-vs-hippocampus question in two; both halves now point the same way (window opened by cortex, pre-ripple content predicted by cortex), so what survives is the cortex-vs-thalamus arm and the absence of any *clamp* experiment.
- **What informs the spindle of its target.** The SO does not; the attentional-tag proposal is untested. A *cortical* addressing variable is now measured one level out — a seconds-persistent sensory-cued bias in the pre-ripple cortical ensemble pattern that predicts ripple content (Rothschild et al. 2017) — but nobody has shown it is the thing spindles read, and the two candidate addressers (thalamic encoding-time tag vs. re-settable cortical state) have never been run against each other.
- **How hippocampal information enters the thalamic scheme at all** — the source's own most pressing question, with nucleus reuniens the only named candidate ([[wiki/entities/nucleus-reuniens.md]]).
- **The SWS-tag → REM-prune sequence is inferred from correlations**, and the immediate-early-gene evidence for it is cortical while the theta-phase selection evidence is hippocampal.
- **Downscaling is confounded** with intrinsic plasticity and with an E/I shift; no measurement separates them.
- **Human spindle/SO frequencies are species-specific**, so the protocol's constants do not transfer even if the architecture does.

---

## Connections

- **[[wiki/concepts/offline-replay.md]]** *(also)* — supplies the addressing variable this page's protocol lacks, and its price: a sensory cue delivered during non-rapid-eye-movement sleep sets a pre-ripple cortical ensemble bias that persists 2–14 s and predicts what the next ripples contain, while simultaneously suppressing the ripple rate — so the channel's *content* selector and its *throughput* are coupled knobs, not independent ones (Rothschild et al. 2017).
- **[[wiki/concepts/offline-replay.md]]** — supplies the cargo this page schedules: replay says which sequences are reinstated, this page says the reinstatement only becomes a cortical write inside a spindle nested in an SO up-state, and depotentiates cortex when that nesting fails. It also supplies the occupancy figure that makes the window cheap and the cargo rare — ~7–8% of frames carry a detectable sequence (Ji & Wilson 2007).
- **[[wiki/concepts/cortical-state-bistability.md]]** — the frame-level result read as a state variable rather than a clock: the up/down alternation identified from spikes is present in hippocampus with no intrinsic generator and lagging cortex by ~50 ms, so this page's outermost rhythm is exported to the store rather than shared with it (Ji & Wilson 2007).
- **[[wiki/concepts/complementary-learning-systems.md]]** — turns that page's coupling channel into a duty-cycled one: the fast→slow transfer is licensed by a rhythm generated in the *receiver*, which is why prefrontal slow-wave amplitude and not offline time predicts overnight retention.
- **[[wiki/concepts/schema-assimilation.md]]** — the same two-stage sleep division seen from the content side (SWS builds/refines, REM disbands), with spindle density the measured variable predicting accelerated hippocampal disengagement for schema-congruent material.
- **[[wiki/concepts/dendritic-computation.md]]** — names the compartment the protocol acts on: the window is opened by *withdrawing* somatostatin-mediated dendritic inhibition while parvalbumin cells clamp the soma, so the consolidation write is an apical-dendritic event with the axonal output muted.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the interneuron-class taxonomy that this protocol uses as its switch: PV and SST are driven in *opposite* directions within one oscillatory event, which is a functional read-out of the class distinction rather than an anatomical one.
- **[[wiki/concepts/transthalamic-context-routing.md]]** — the same thalamic gating circuit doing the waking job: TRN cells that lock to alpha during attention lock to spindles during sleep, which is the concrete proposal that a system's attention mechanism and its consolidation scheduler can be one circuit.
- **[[wiki/entities/nucleus-reuniens.md]]** — the only named route by which hippocampal information could enter the thalamic scheduling scheme, and the source's stated open question.
- **[[wiki/entities/mediodorsal-thalamus.md]]** — the higher-order analogue of the relay-instructs-cortex result: a thalamic nucleus that maintains and amplifies a cortical state rather than relaying content, here doing it offline and at a fixed phase.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the plasticity rules this page gates: same rule, opposite sign depending on the phase and on the presence of the nested spindle, with the dendritic branch rather than the synapse as the unit of scaling.
- **[[wiki/concepts/replay-prioritisation.md]]** — the rival specification of *what* to replay: `EVB = Gain × Need` is recomputed at sample time, where this page's selection is a stale local tag laid down by attention at encoding.
- **[[wiki/concepts/memory-read-and-erase.md]]** — the erase half, supplied by the same event: ripples downscale the hippocampal ensemble they reactivate, so transport and clearance share one trigger instead of needing a separate capacity policy.
- **[[wiki/concepts/cortical-state-bistability.md]]** — the same up/down alternation read as a state variable rather than a clock; this page adds that the down-state is not idle time but the frame that makes the following up-state a discrete window.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — where the protocol is measured on a named wire: hippocampal ripples lead mPFC SO–spindle events by ~130 ms, unlike the tight simultaneous coupling in central-parietal cortex, so the channel's phase relationship is target-specific.
