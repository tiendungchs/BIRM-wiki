# The A24b/M2 → V1 Projection

**The wiki's only *measured* prediction channel: a dense, topographic, layer-5-origin cortico-cortical projection that delivers a motor-derived prediction of upcoming visual flow into primary visual cortex — already in visual coordinates, with a bandwidth matching the feedforward thalamic input, carrying no error, and re-learnable in ~10 sessions when the action→consequence map is inverted.**

> **Why this is an entity page and not a section.** Everywhere else the wiki draws a top-down prediction it is a modelling assumption: `predictive-coding-free-energy` supplies the update rule, `canonical-cortical-microcircuit` a laminar assignment, `prediction-error-neurons` the cell classes the errors need. All three are downstream of a prediction whose *source* had never been identified — Leinweber et al. open by stating exactly this: "the source of the motor-related prediction necessary to generate these mismatch signals is still unknown." This page is that source, characterised as an edge with its own anatomy, its own bandwidth, its own coordinate system, its own learning schedule and its own causal test. It is the cortical counterpart to [[wiki/entities/hippocampal-prefrontal-channel.md]] — a projection studied as an object rather than as a wire between two studied endpoints.

> **Provenance.** `raw/leinweber-2017-sensorimotor-circuit-visual-flow-predictions.md` — Leinweber, Ward, Sobczak, Attinger & Keller, *A Sensorimotor Circuit in Mouse Cortex for Visual Flow Predictions*, **Neuron** 95(6):1420–1432, 2017. Mouse; rabies tracing, dual-colour anterograde tracing, channelrhodopsin-assisted circuit mapping in slice and in vivo, two-photon axonal calcium imaging in behaving animals, muscimol inactivation, ibotenic lesion, and optogenetic stimulation during virtual navigation. **A24b/M2** = the dorsal part of area 24b of anterior cingulate cortex (0 to +1 mm from bregma) plus the immediately adjacent medial secondary motor cortex; the authors find no functional or anatomical separation between the two and treat them as one source (57% / 43% of labelled cells).

---

## Anatomy: the channel is as wide as the sensory input it predicts

Monosynaptic rabies tracing from V1 (3 mice; 2,179 ± 877 starter cells, 30,437 ± 6,112 presynaptic cells brain-wide):

| Source of V1 input | Share |
|---|---|
| V1 itself | 25% |
| Secondary visual areas (V2L, V2ML, V2MM) | 20% |
| Retrosplenial cortex | 14% |
| Auditory cortex | 7% |
| **A24b/M2** | **6%** (1,748 ± 501 cells; largest motor-related input; **~2× the cell count of dorsolateral geniculate nucleus**) |

| Property | Measurement |
|---|---|
| Origin layer | Layer 5 of A24b/M2 |
| Axonal termination | Dense in V1 **layer 1 and layer 6** |
| Postsynaptic cell types (Cre-line-restricted rabies) | All tested types receive input; largest fractions from **L2/3 excitatory, L6 excitatory, PV interneurons** |
| Connection *density* (channelrhodopsin-assisted circuit mapping, slice, subthreshold stimulation) | L1 85% (29/34), L2/3 **73%** (35/48), L6 73% (22/30); L5 8% (2/26); **L4 0%** (0/19) |
| Latency | 6.74 ± 3.27 ms — monosynaptic |
| Topography (two AAVs 500 μm apart) | posterior A24b/M2 → medial V1; anterior → lateral V1; medial → anterior V1; lateral → posterior V1 |

**Three architectural constraints a builder can read straight off this table.**

1. **A prediction channel cannot be a low-dimensional gain.** The paper's framing is an explicit two-hypothesis test: motor-related activity in V1 is either a *gain modulation* of visual responses — which a neuromodulatory scalar can carry — or a *prediction of visual flow*, which requires bandwidth comparable to the feedforward input. The measurements land on the second: more cells than the thalamic relay, contacting >73% of the neurons in three of five layers. Any machine top-down path implemented as a per-layer scalar, a FiLM-style affine modulation, or a small conditioning vector is implementing the hypothesis this paper rejects for this circuit. ([[wiki/concepts/precision-weighting.md]] describes a channel that *is* legitimately low-dimensional; the point is that the two are different channels, and the wiki has been letting one stand in for the other.)
2. **The prediction bypasses the input layer.** Zero of 19 layer-4 cells were driven. The prediction enters where the comparison happens (L2/3) and where the feedback loop originates (L6), never where the feedforward signal arrives. A machine analogue that adds the top-down term to the input embedding is wiring the circuit the tissue explicitly does not.
3. **Topography is preserved, so the coordinate transform is done before delivery.** See below.

---

## Where the forward model sits: the disambiguation this paper was designed for

A motor→sensory prediction requires a coordinate transform — from *which muscles are activated* to *how the image changes*. This is a **forward model** ([[wiki/entities/cerebellum.md]], [[wiki/concepts/arbitrary-sensorimotor-mapping.md]]). Two anatomies are possible, and the paper states them as the experiment's target:

| Anatomy | The efference copy arrives in V1 as… | The forward model is… | Signature in axonal recordings |
|---|---|---|---|
| **A — transform at the synapse** | a motor command, in myotopic coordinates | the A24b/M2-axon → V1-neuron connectivity matrix | axon activity tracks the *movement*, identically across retinotopic locations |
| **B — transform upstream** | an already-converted prediction, in retinotopic coordinates | internal to A24b/M2 or its inputs | axon activity is **retinotopically biased**: axons in a given part of V1 prefer the movements that maximise flow *there* |

**The data give B.** In mice navigating a 2D virtual tunnel (left V1: 153 sites, 34,533 axons; right V1: 55 sites, 7,476 axons; 22% ± 1.4% of axons task-related): axons in **left** monocular V1 were biased toward **left** turns (0.60 vs 0.40, p = 4×10⁻¹³), axons in right V1 toward right turns (0.64 vs 0.36, p = 2×10⁻⁵) — ipsiversive turns, which maximise flow in the *contralateral* visual field, i.e. the field that part of V1 sees.

**Why this matters more than it looks.** The wiki's standing description of a top-down prediction — on [[wiki/concepts/prediction-error-neurons.md]], on [[wiki/entities/cerebellum.md]] — is *a transformation between two areas' coordinate systems*, with the transformation's location unspecified. This result says the receiver gets the finished product: V1 is handed a prediction in its own basis and does nothing but subtract. The comparator is therefore genuinely local and genuinely dumb, and everything expensive — the model of how actions change images — lives in the sender. That is a **module-interface** claim, and it is the opposite of the arrangement in which a generic efference copy is broadcast and each receiver decodes it.

---

## The learning result: invert the world and the channel inverts

The retinotopic bias could be an artefact — motor and striatal activity is known to be biased toward movement laterality regardless of sensory consequence. The control is to change the action→consequence map and see whether the channel follows.

Mice were trained in a **left–right inverted** virtual environment (up to 10 sessions, one per day; learned, more slowly than normal), with A24b/M2 axons in right V1 imaged on the first and last day:

| Condition | Axon turn preference in right V1 |
|---|---|
| Day 1, inverted environment | ipsiversive (right) — same as normal training |
| Last day, inverted environment | **contraversive (left)** — the turn that, under inversion, maximises flow in the *left* visual field |
| Magnitude of the shift | scales with the animal's behavioural performance in the inverted environment |
| Same mice, **no visual flow** (grey corridor, free running) | **no reversal** in either training group |
| Same mice, **independent visual flow** (playback, uncoupled) | preference *equalises*, does not reverse |

The reversal is specific to the condition in which flow is **coupled to movement**. It is not a reversal of motor tuning and not a reversal of visual tuning; it is a reversal of the *map between them*. This is the wiki's cleanest demonstration that a cortical forward model — an action→sensory-content map — is **learned, in cortex, on a scale of days, with no hippocampal component named anywhere in the circuit**.

---

## The signature that makes it a prediction rather than a correlate

Axonal calcium imaging, 6,007 axons in 10 mice, head-fixed on a spherical treadmill with a toroidal screen (closed-loop / open-loop / dark):

| Observation | Value | What it rules out |
|---|---|---|
| Activity **precedes** running onset | by ~900 ms at the population level; 30% (508/1,675) of axons have onsets before running onset | a sensory or reafferent signal |
| Onset is earlier than in V1 L2/3 | mean latency 0.28 ± 0.13 s vs 0.43 ± 0.06 s post-onset; the population effect is a **broader** onset distribution (FWHM 1.08 ± 0.18 s vs 0.52 ± 0.16 s) | that V1's motor signal is generated locally |
| Amplitude grows with running speed | monotonic | a binary brain-state switch |
| **No response to visuomotor mismatch** | zero change at mismatch, where V1 L2/3 responds strongly | that these axons carry an error |
| Amplitude tracks the *predicted change* in flow | highest when a **static** grating preceded running onset; reduced when flow was already moving (open loop, within a 3 s window) or in darkness; drops when the lights go out mid-run | a movement-locked efference copy indifferent to the current image |
| Delayed visual responses also present | ~1,000 ms after flow onset, uncorrelated in strength with an axon's motor response | that the channel is purely motoric |

The fourth and fifth rows are the load-bearing ones. **Carries prediction, never error** is the sign convention the whole predictive-coding literature assumes and had not measured on an identified projection; and **amplitude ∝ predicted change, not ∝ movement** is what separates a prediction from an efference copy. A model whose top-down path emits `f(action)` fails the fifth row; it needs `f(action, current state)` — the forward model consumes the current sensory estimate, not just the command.

---

## Causal tests: three, in both directions

| Manipulation | Result |
|---|---|
| **In vivo** channelrhodopsin-assisted mapping (ChrimsonR in A24b/M2, GCaMP6f in V1): stimulate axons locally, read L2/3 | 82/648 (13%) of L2/3 neurons driven; **those neurons have stronger running-onset activity** than non-driven ones, and not merely higher activity overall |
| **Muscimol** inactivation of A24b/M2, and separately **ibotenic-acid lesion** | V1 running-onset responses **and** mismatch responses both significantly reduced (running speed matched by subsampling; effect size an underestimate, since the inactivation covered only part of A24b/M2) |
| **Optogenetic drive** of A24b/M2 axons in monocular V1 during virtual navigation | stimulating **left** V1 makes the mouse turn **right**, and vice versa — the corrective response to *illusory* flow in the corresponding hemifield (bilateral stimulation used as the control, since any stimulation slows running) |

The second row is the sharpest: removing the prediction reduces the **error** signal. Mismatch responses in V1 are the difference between an excitatory prediction and inhibitory visual drive, so subtracting the excitatory term must shrink them — a directional prediction that a gain-modulation account does not make. The third row is the wiki's only case of a top-down prediction being **written** into a sensory area and read out behaviourally, which is the closest existing analogue of injecting a hypothesis into a perceptual module and watching the agent act on it.

That the reductions are *partial* is itself informative: A24b/M2 is one of several prediction sources. The authors' own list of others, each with a distinct conditioning variable — secondary visual areas (higher-level visual features), auditory cortex (learned audio-visual associations), retrosplenial cortex (vestibular head/body rotation), and A24b/M2 itself also carrying a prediction conditioned on **spatial location** in the virtual environment. The general form they propose: **any top-down input is a prediction of the feedforward input, conditioned on whatever variable that sender explains variance with.**

---

## The darkness residual

A24b/M2 axon activity during running in **complete darkness** is reduced but not zero, and V1 L2/3 motor-related activity in darkness persists even after **complete retinal lesion**. The authors state plainly that this "cannot, strictly speaking, be explained in either the representation framework or the predictive processing framework": with no visual input there is nothing to represent and nothing predictable to predict. Their offered resolution — that low light shifts processing onto predictions, and total darkness is an unevolved-for singularity — is a hypothesis, not a result.

This is an instrument problem, not only a biological curiosity, and it is recorded as [[wiki/empirical-tensions.md]] **T345**. The entire empirical case for predictive processing in sensory cortex rests on self-generated movement as a controllable proxy for the (uncontrollable) prediction term `P` ([[wiki/concepts/prediction-error-neurons.md]], "the instrument problem"). If movement drives the channel when there is provably nothing to predict, then movement-correlated activity in sensory cortex is a *contaminated* estimator of `P`, and an unknown share of every result read through it — including several rows in the table above — is a behavioural-state signal wearing a prediction's clothes.

---

## Comparison: the wiki's three loci for predicting the sensory consequence of an action

| | **A24b/M2 → V1** | [[wiki/entities/cerebellum.md]] | [[wiki/entities/thousand-brains-theory.md]] |
|---|---|---|---|
| Prediction generated in | anterior cingulate / secondary motor cortex | cerebellar microzone (Purkinje cell) | inside the receiving column itself |
| Delivered to | primary sensory cortex, L1/L2/3/L6 | brainstem/cortical motor targets; the plant model | L4/L2/3 of the same column |
| Conditioned on | motor output **and** current visual state | efference copy + current state estimate | a movement-updated **location** on an object (L6) |
| Coordinate system on the wire | **sensory (retinotopic) — measured** | motor-command coordinates for the error (climbing fibre) | object-centred reference frame |
| What it predicts | upcoming **sensory content** | the plant's next **state**, and its reafference | the column's own next **input** |
| Learned? | yes — reverses in ≤10 sessions under inverted coupling | yes — climbing-fibre-driven | asserted, not measured |
| Evidence class | measured circuit, causal in both directions | measured circuit, error format disputed (`T342`) | architectural proposal, no simulation |

The wiki has been treating "where does the prediction come from" as one question. It is at least three, and they differ on the one thing a builder must choose: **what is on the wire.** Only this row has been measured.

---

## What this settles, and what it does not

**Settles (for one modality, one species, one coupling):**
- A cortical top-down projection carrying a motor-conditioned prediction of sensory *content* exists, is dense, is topographic, and is learned.
- The motor→sensory transform happens **before** delivery; the receiving area is handed its own coordinates.
- The prediction is not an error and does not respond to mismatch — the two directions are on different cells, as [[wiki/concepts/prediction-error-neurons.md]] requires.
- Removing the prediction shrinks the error, which is the sign the subtraction account demands.

**Does not settle:**
- **Where inside A24b/M2 the forward model is, or how it is learned.** Nothing here identifies a synapse, a plasticity rule, or an error signal that could train the map. The reversal experiment shows the map *changes*; it does not show what changed it. This is [[wiki/concepts/prediction-error-neurons.md]]'s "site of plasticity" table, one synapse further upstream, and with no elimination performed.
- **Whether the primate has this edge at all.** Mouse A24b is likely homologous to primate A24b, but no A24b → V1 projection has been described in primates, and classical tracing estimated the rat projection as far weaker than rabies tracing finds it. Either classical tracing underestimates long-range cortical projections, or in rats and primates this communication is mostly indirect. The one human datum is functional connectivity between anterior cingulate and early visual cortex.
- **Whether the projection is *only* a prediction.** The same axons are implicated in surround suppression and in location-conditioned prediction, and carry delayed visual responses. "One projection, one function" is not on offer.
- **How this composes above sensory cortex.** Every result here is about predicting *flow*, a low-dimensional consequence of a low-dimensional action. Nothing says the same machinery predicts the consequence of an abstract operation on an abstract state, which is the version [[wiki/concepts/latent-graph-discovery.md]] needs.

---

## Connections

- **[[wiki/concepts/prediction-error-neurons.md]]** — supplies the missing input to that page's comparator: the top-down prediction its negative-error cells are excited by, delivered by a named, dense, topographic projection whose axons carry prediction and **no mismatch signal**, and whose silencing shrinks the mismatch response — the sign test the subtraction account demands. It also constrains that page's coordinate-system argument: the motor→sensory transform is completed *upstream*, so the receiving area is handed a prediction already in its own basis rather than decoding an efference copy locally.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — turns the formalism's descending term from an assumption into a measurement, and prices it: the prediction path has more source cells than the thalamic input and contacts >73% of neurons in three layers, so a machine implementation cannot realise `top-down` as a low-rank or scalar modulation; it also supplies the state-dependence the equations already imply and most implementations drop — the descending signal scales with the *predicted change* given the current input, not with the action.
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — the same forward model with its location settled and its plasticity shown: the motor→sensory transformation that page calls an internal model is computed in the sending area (A24b/M2), delivered in sensory coordinates, and **re-learned within ~10 sessions** when left–right visuomotor coupling is inverted — with the shift's magnitude tracking behavioural performance.
- **[[wiki/entities/cerebellum.md]]** — a second locus for the same computation with an opposite interface: the cerebellar forward model predicts the *plant's state* and its error is claimed to arrive in motor-command coordinates, while this projection predicts *sensory content* and is measured to arrive in retinotopic coordinates — so the two cannot be the same module in a machine version, and `T107`'s "which structure predicts the consequence of an action" has at least two answers depending on what is being predicted.
- **[[wiki/entities/early-visual-system.md]]** — names a large part of the ≥60–80% of a V1 cell's variance that is not thalamic: one cortical projection with roughly twice the dorsolateral-geniculate cell count contacts most neurons in L1, L2/3 and L6 while touching **no** layer-4 cell, so the descending prediction and the ascending drive enter at disjoint laminar ports.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — a concrete laminar termination pattern to test the canonical scheme's feedback assignment against: L1 and L6 dense, L2/3 and L6 excitatory cells plus PV interneurons as the main postsynaptic targets, L5 8% and L4 0%.
- **[[wiki/concepts/precision-weighting.md]]** — separates two channels the wiki has been conflating: `Π` may legitimately be low-dimensional and neuromodulatory, but the *content* channel cannot be, and this paper's whole design is the test that distinguishes them (bandwidth, density, topography, state-dependence).
- **[[wiki/entities/thousand-brains-theory.md]]** — the same claim (every area predicts its next input from movement) with the opposite anatomy: there the movement-updated location code is internal to the column, here the prediction is manufactured in a distant motor-related area and shipped in, so the two are distinguishable by whether silencing an external source removes the prediction — and it does.
- **[[wiki/concepts/learned-world-models.md]]** — a biological world model that is explicitly *partial and addressed*: it models only how the agent's own movement changes one modality's input, is delivered only to the retinotopic sector it applies to, and is one of several such models converging on the same target — the opposite of a single global latent-dynamics model.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the wiki's other projection-as-entity, and the contrast that makes both legible: that edge carries *context* from a fast store to a controller and has its own gate and plasticity; this one carries *predicted content* from a controller to a sensory area and has its own coordinate system and topography. Between them they establish that an inter-module wire is a designed object, not a matrix.
- **[[wiki/concepts/simulation-based-planning.md]]** — the missing ingredient in a decoupled rollout, measured: running the sensory model without sensation requires something to supply the prediction, and here that something is an identified projection whose artificial activation produces behaviour appropriate to visual flow that never happened.
- **[[wiki/concepts/violation-of-expectation.md]]** — sharpens the instrument: the surprise signal a probe reads out is the residual after subtraction by *this* channel, so a violation-of-expectation score measures the sender's model, not the sensory area's.
- **[[wiki/gaps/g039.md]]** — the wiki's one case where anchoring a retrieved structure to the present situation is **free**: the projection's topography performs the argmax over the group once, at development time, so a prediction arrives at exactly the retinotopic sector it applies to. Inverting the visuomotor coupling rewrites the *contents* and leaves the anchor untouched — the same lesson as GCQ, from the substrate side.
- **[[wiki/concepts/latent-graph-discovery.md]]** — one edge of the latent graph — action → next observation — shown to be stored in cortical wiring, re-learnable under inversion, and delivered as a prediction to the observation's own representation; the reduction it does not license is any abstract edge, since flow is a low-dimensional consequence of a low-dimensional action.
