# Apical Amplification (BAC Firing)

**A layer-5 pyramidal cell has *two* spike-initiation zones — the axonal Na⁺ zone at the soma and a Ca²⁺ zone at the apical nexus — and each one, once it crosses threshold, lowers the other's. Feedforward drive arrives at the basal/perisomatic pole, inter-areal feedback arrives on the apical tuft in layer 1, and their coincidence within ~30 ms halves the current threshold for a dendritic Ca²⁺ spike, converting a single action potential into a burst of 2–4 spikes at ~200 Hz. Association is therefore a *site inside one neuron*, not an operation a circuit performs on the outputs of neurons.**

The wiki carries the apical/basal split as anatomy ([[wiki/concepts/canonical-cortical-microcircuit.md]]) and as a detector bank ([[wiki/concepts/dendritic-computation.md]]). This page carries the coupling rule *between* the two compartments — the step that decides whether distal feedback has any effect on output at all — and the architectural claim built on it: one operation (compare internal expectation against external evidence), performed identically at every cortical stage, massively in parallel, with no read-out stage.

> **Provenance.** `raw/larkum-2013-cellular-mechanism-for-cortical-associations.md` — Larkum, *Trends Neurosci.* 36(3):141–151, 2013. A hypothesis paper, not a new result: it assembles the author's *in vitro* L5 work (Larkum et al. 1999, 2001, 2004) with awake-animal dendritic imaging (Murayama & Larkum 2009; Xu et al. 2012) and two older perceptual recordings (Cauller & Kulics 1991; Supèr et al. 2001), and is explicit that the perceptual half "remains to be shown definitively". **Clip defect:** the bodies of Box 1 (thalamo-cortical interaction) and Box 2 (does the hippocampus use the same cellular mechanism?) are images in the source HTML and are *not* in the clip — the thalamic and hippocampal extensions of the hypothesis are therefore absent from this page.

---

## Two initiation zones, one cell

| | Perisomatic zone | Apical (nexus) zone |
|---|---|---|
| Current | Na⁺ | Ca²⁺ |
| Input it integrates | Feedforward / driving: thalamic and ascending cortical input on basal and proximal dendrites | Feedback: long-range cortico-cortical and matrix-thalamic axons in layer 1, onto the distal tuft |
| Event | Single action potential, ~1 ms | Broad Ca²⁺ plateau, **up to 50 ms *in vitro*** |
| Effect on the other zone | Backpropagating spike **halves** the dendritic current threshold | Plateau depolarisation spreads to the axon → **high-frequency burst** |
| Somatic read-out | One spike | **2–4 spikes at ~200 Hz** — a burst *is* the report that a distal event occurred |

**The problem this solves.** Distal tuft synapses are the electrically most remote on the cell; a naïve cable reading says the 90% of layer-1 synapses that come from long-range feedback are inconsequential. The second initiation zone inverts that: feedback is *closer* to the Ca²⁺ zone than feedforward drive is, so under coincidence the distal stream can dominate the input/output function rather than perturb it.

---

## The rule, and the three-compartment reduction

Larkum et al. 2001's model, which is the form a builder would import:

| Compartment | Integrates | Has |
|---|---|---|
| **A** | apical tuft (feedback) | own threshold `θ_A` |
| **B** | basal/perisomatic (feedforward); the axon exits here | own threshold `θ_B` |
| **C** | oblique dendrites | couples A↔B in both directions |

| Input | Output |
|---|---|
| Distal only, sub-threshold | No dendritic spike, **virtually no somatic effect** |
| Somatic only | Action potential; backpropagates; still no dendritic spike |
| **Distal + somatic within ~30 ms** | Ca²⁺ spike → **burst** |

So the cell is not an `integrate-and-fire` unit with extra inputs: it processes two streams **separately**, then combines them with an intrinsic nonlinearity — "reducing the burden on the network complexity", i.e. an AND/coincidence term that a single-compartment architecture must otherwise buy with extra units and extra wiring.

**With realistic input the switch becomes a gain.** Under noisy continuous barrages rather than stereotyped current steps, weak tuft input raises the *slope* of the output-vs-basal-input curve dramatically (Larkum et al. 2004); distal Ca²⁺ channels contribute to firing rate even when no plateau is visible. Larkum renames the mechanism **backpropagation-activated coupling** for this regime. Two operating points of one mechanism:

| Regime | Reading |
|---|---|
| Stereotyped, near-threshold | A **binary coincidence detector** — burst = "both streams agree here" |
| Noisy, in vivo-like | A **multiplicative gain** on the feedforward transfer function, set by the distal stream |

Consequence for import: the same biology licenses both a gating term and a `f(x_basal) · g(x_apical)` product, and the source does not decide between them — which is the same ambiguity [[wiki/concepts/precision-weighting.md]] has at the circuit level.

---

## The gate on the gate

Association is not free-running: dendrite-targeting inhibition can veto it, and does so on two timescales.

| Channel | Timescale | Source / locus |
|---|---|---|
| GABA_A | tens of ms | Dendrite-targeting interneurons, e.g. Martinotti cells |
| GABA_B | **hundreds of ms** (~0.5 s) | Suppression of dendritic Ca²⁺ channels; some of the machinery is localised *specifically to the apical dendrite* |

Because background dendritic inhibition is normally present, the hypothesis makes association require **release from inhibition**, not merely coincidence — a third input, on a slower timescale than either stream. Larkum notes the ~0.5 s GABA_B suppression is far longer than synaptic integration and close to the build-up time of the readiness (*Bereitschafts*) potential, and proposes the disinhibitory mechanism as unknown. **This is the wiki's cleanest instance of a control variable that is neither of the two data streams**: a per-compartment permission signal with a half-second hold, which no architecture here exposes ([[wiki/concepts/inhibitory-control-of-coding.md]]).

---

## The controller the coupling compartment turned out to have

> Aru, Suzuki & Larkum 2020, *Trends Cogn. Sci.* 24(10):814–825 (`raw/aru-2020-cellular-mechanisms-of-conscious-processing.md`), around Suzuki & Larkum 2020, *Cell* 180:666–676. Full treatment: [[wiki/entities/dendritic-integration-theory.md]].

Compartment `C` above is written as a fixed conductance. It is not: it is a **controlled variable**, and the controller is outside the cell.

| | Measured |
|---|---|
| Optogenetic stimulation of the apical compartment, **awake** | Large effect at the soma — high-frequency firing |
| Same stimulation, **anaesthetised** | Does not propagate to the soma at all. Apical and basal are *decoupled* |
| Generality | Replicated across anaesthetics with disjoint molecular targets and across frontal, somatosensory and primary visual cortex |
| Where | Localised to the coupling compartment, ~layer 5a |
| By what | **Metabotropic** receptors — blocking them in an *awake* animal reproduces the decoupling |
| Under whose control | **Higher-order thalamus** — inactivating it breaks the coupling; stimulating it restores waking in mice and monkeys |
| What does *not* move it | Locomotion and visual stimulation leave apical–basal correlation unchanged (Beaulieu-Laroche et al. 2019; Francioni et al. 2019) — the variable tracks *state*, not content |

**Consequence for this page's import.** The three-compartment model needs a fourth term: `burst = coupling · AND(apical, basal)`, where `coupling` is set by a third party on a slow timescale and by neither data stream. The page already names the fast per-compartment veto (GABA_B, ~0.5 s); this adds a slow permissive gain with a different source and a different timescale, and whether *selection* lives in the fast veto or the slow gain is `T376`.

---

## Why the wiring matches the cell

| Anatomical fact | What the mechanism makes of it |
|---|---|
| Feedforward terminates in middle layers; feedback terminates in layer 1 (Rockland & Pandya 1979; Felleman & Van Essen 1991) | The two streams are delivered to the two initiation zones — the hierarchy's laminar rule *is* the wiring of the coincidence detector |
| Only ~10% of layer-1 synapses are local; ~90% are long-range feedback | Hubel's "crowning mystery" becomes the address bus for the apical port |
| Feedback to a level comes from *many* higher areas and from thalamus, carried by horizontal fibres running along layer 1 — not only from the level immediately above | Any area can write to any level's apical port without a relay. **This is a broadcast port, not a chain link** (`T259`) |
| Pyramidal cells are 70–80% of cortical neurons and are the only cells projecting out of an area | The associative element and the export element are the same cell, so an association is *directly* what leaves the area |

---

## What it buys an architecture

- **Binding with no read-out stage and no tag.** The neurons whose feedforward drive matches the arriving feedback fire fastest and burst; by virtue of firing most they exert the most influence downstream. Nothing needs to detect the coincidence *afterwards* — there is no homunculus, no grouping operation, no synchrony tag ([[wiki/concepts/vector-symbolic-binding.md]] buys the same function with an algebraic operator instead).
- **A positive feedback loop over one cycle.** The bursting subset supplies stronger feedforward drive upward, which sharpens the feedback prediction, which recruits further coincidences — an iterative settling implemented in rates, not in a separate relaxation phase.
- **One operation at every stage.** The same compare-internal-against-external step runs at V1 and at inferior temporal cortex with no change of machinery, which is the cellular version of the uniformity premise ([[wiki/concepts/canonical-cortical-microcircuit.md]]).
- **The engram is a firing-rate subset, not a set of active cells.** Larkum's own explanation for why conventional recordings see so little: only the cells receiving *both* streams change their behaviour, and region-averaged signals wash them out. **(brainstorm)** In machine terms the content is carried by the *top tail* of the activation distribution, so any read-out that averages a layer's activity is measuring the wrong statistic; the analogous probe is a burst-vs-rate distinction, which no artificial unit has because it has one output channel.

---

## The in vivo evidence, and its grade

| Result | What it shows | Grade |
|---|---|---|
| Dendritic Ca²⁺ activity **~10× larger awake than anaesthetised** (4× even without movement), fibre-optic periscope over L5 tufts; **absent in nearby L2/3** (Murayama & Larkum 2009) | The mechanism is state-dependent and layer-specific, not an in vitro artefact | Direct, population-level |
| Whisker *position* encoded by tuft plateaus in L5 cells during active touch; largest at the preferred position; **abolished by silencing motor cortex** (Xu et al. 2012) | A feedback stream (motor → L1) is necessary for the distal events, and the coincidence is with feedforward touch input | Direct, causal on the feedback arm |
| Surface-negative current sink in upper layers, present for consciously perceived touch, **absent in sleeping and anaesthetised monkeys** (N1, ~50 ms; Cauller & Kulics 1991) | Distal excitatory input correlates with perceptual report | Correlative, pre-dates the hypothesis |
| Figure–ground in V1: statistically identical figure and ground, difference emerges ~50 ms, feedback-dependent, absent on misses (Supèr et al. 2001) | Contextual modulation requires feedback and tracks report | Correlative |

The causal test the hypothesis asks for — block dendritic Ca²⁺ activity specifically and measure binding/report — is named as future work, and the paper's own two predictions are: **overactivation** of dendritic activity (neuromodulation, channelopathy, loss of dendritic inhibition, feedback overdrive) → faulty perception, i.e. hallucination and dreaming; **underactivation** → loss of contextualisation.

---

## Where it collides with predictive coding

Both accounts wire the same two streams into the same two compartments and then disagree about the sign of the result:

| | Larkum 2013 | Predictive coding ([[wiki/concepts/predictive-coding-free-energy.md]], [[wiki/concepts/prediction-error-neurons.md]]) |
|---|---|---|
| Feedback meets matching drive | **Burst** — maximal output | **Silence** — the prediction explains the input away |
| What ascends | The confirmed content itself | The residual |
| Population that matters | The most active cells | The cells that failed to be cancelled |
| Delivery of feedback | Glutamatergic, directly to the tuft | Glutamatergic to the tuft, but converted to *subtraction* by a local learned inhibitory circuit |

Recorded as [[wiki/empirical-tensions.md]] **T374**. Note the two are not trivially reconcilable by "different cells": Larkum's claim is about the L5 pyramid, which the laminar assignment types as the *state/representation* unit, so a hybrid in which L2/3 subtracts and L5 amplifies is the obvious peace treaty and is exactly what nobody has measured in one preparation.

---

## Limitations

| Limit | Consequence |
|---|---|
| Hypothesis paper; the association→perception link is explicitly speculative | The cellular rule is solid *in vitro*; everything above "BAC firing and cortical information processing" is a proposal |
| Demonstrated in rat primary sensory L5 | Whether association-cortex and hippocampal pyramids do the same is open — and is the content of the Box 2 the clip lost |
| No learning rule | What makes a *particular* tuft synapse carry the right prediction is untouched; the mechanism is a read operation with no stated write |
| Timing window fixed at ~30 ms by construction | Association is possible only between streams whose latencies already match; nothing here aligns them |
| Two compartments, one product | Larkum's cell is depth-3; fitting the same cell's full I/O needs 5–8 layers (`T302`), so this reduction is known to be lossy where NMDA-mediated cross-branch interaction lives |

---

## Connections

- **[[wiki/concepts/dendritic-computation.md]]** — supplies the missing half of that page's explicitly unmodelled step: it stops at "how a dendritic spike becomes a somatic spike is out of scope", and this is the answer — bidirectional threshold lowering between two initiation zones, with a burst as the somatic signature of a distal event.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the wiring read as the specification of a cellular AND gate: the laminar feedforward/feedback rule delivers the two streams to the two initiation zones of one cell, which makes the layer-1 termination zone a data port rather than a modulatory afterthought.
- **[[wiki/concepts/prediction-error-neurons.md]]** — the rival sign convention on identical anatomy: feedback that matches drive produces a burst here and a cancellation there, so the two schemes predict opposite firing for the same stimulus in the same cell (`T374`).
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — a candidate physical implementation of the descending term with its sign flipped: the prediction is delivered as a multiplicative gain on the receiving cell's own drive rather than as a subtrahend, which removes the need for a local inhibitory circuit to convert an excitatory projection into a negative one.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the veto that makes the association conditional: GABA_A on tens of ms and GABA_B on ~0.5 s, with the Ca²⁺-channel-suppressing machinery localised to the apical dendrite, so dendrite-targeting interneurons hold a per-compartment permission signal that is neither of the two data streams.
- **[[wiki/concepts/ignition.md]]** — the same commit operation one level down: ignition is a network-wide threshold crossing carried by voltage-dependent NMDA feedback, this is a cell-wide threshold crossing carried by voltage-dependent Ca²⁺ feedback, and both make take-off depend on the *joint* state of the two ends of a loop; the ~0.5 s dendritic disinhibition needed before a cell can associate is a cellular counterpart of the several-hundred-millisecond build-up ignition takes.
- **[[wiki/concepts/broadcast-hierarchy.md]]** — the cellular reason a level can be addressed without being relayed to: layer-1 horizontal fibres carry feedback from many higher areas and from thalamus onto every level's apical port, so a broadcast has a physical destination that costs no extra stage.
- **[[wiki/concepts/neuron-complexity-index.md]]** — the same cell measured by fitting rather than by mechanism, and it prices this page's reduction: three compartments against 5–8 fitted layers, with the excess attributed to NMDA-mediated interaction *between* branches that the A/B/C model assumes away (`T302`).
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — the same compartment claimed for a different job: dendritic-error schemes read the apical compartment as holding `δ_l`, this page reads it as holding a prediction whose *match* is amplified, and the two differ in whether the burst reports an error or a confirmation.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the same binding function bought with hardware instead of algebra: coincidence at two poles of one cell fuses two streams without an operator, a tag or a read-out, at the cost of being able to bind only the pairs the anatomy already delivers to that cell.
- **[[wiki/concepts/attention.md]]** — a multiplicative gain applied at the receiving cell by a descending stream is what an attentional modulation is, and here it has a locus (the apical Ca²⁺ zone), a timescale (~30 ms coincidence, ~50 ms plateau) and a hard-wired off switch (dendritic inhibition) that the standard attention block has no counterpart for.
- **[[wiki/entities/global-neuronal-workspace.md]]** — a cell-level alternative to the framework's central question: if the cells receiving both streams simply fire hardest and therefore dominate their targets, "what is currently broadcast" needs no dedicated long-axon workspace population, only a rate threshold.
- **[[wiki/concepts/three-component-framework.md]]** — an architecture-slot contribution with the other two slots empty: the coincidence nonlinearity and the compartment topology are specified precisely, and no objective and no learning rule are offered for what the apical synapses should come to predict.
- **[[wiki/entities/dendritic-integration-theory.md]]** — supplies the controller this page's coupling compartment `C` lacks: coupling between the two initiation zones is itself a variable, set at layer 5a by higher-order thalamus through metabotropic receptors and abolished by general anaesthesia across three cortical areas and several chemically disjoint anaesthetics, so whether a coincidence produces a burst at all is decided by neither data stream (Suzuki & Larkum 2020; Aru et al. 2020, `T376`).
