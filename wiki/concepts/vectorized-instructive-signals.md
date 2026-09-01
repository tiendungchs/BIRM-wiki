# Vectorized Instructive Signals

**A teaching signal is *vectorized* when each neuron receives its own, differently-signed instruction rather than a copy of one broadcast scalar. This is what makes backpropagation scale and what a globally broadcast reward-prediction error cannot do — and it has now been measured in vivo, in the distal apical dendrites of cortical pyramidal cells, with the sign set by each neuron's causal role in the task.**

> **Provenance.** Francioni, Tang, Toloza, Ding, Brown & Harnett 2026, *Vectorized instructive signals in cortical dendrites*, Nature (`raw/francioni-2026-vectorized-instructive-signals-dendrites.md`). Two-photon GCaMP7f imaging of layer-5 pyramidal somata and their paired apical dendrites in mouse retrosplenial cortex (RSC), during a closed-loop neurofeedback brain–computer interface (BCI) task; 6 mice trained, 466 neurons in the decoding analysis, plus 4 NDNF-Cre mice for optogenetics and 5 for LED-only control.

The wiki's credit-assignment machinery ([[wiki/concepts/biologically-plausible-credit-assignment.md]]) is a catalogue of *proposals* for where `δ_l` lives. This page carries the first experiment that measures a candidate `δ_l` in a behaving animal, because it is the first to make the **reward function** an experimenter-owned object rather than an inferred one.

---

## The axis: scalar broadcast vs. per-neuron vector

| | Scalar | Vectorized |
|---|---|---|
| Signal | One number, no address ([[wiki/concepts/reward-prediction-error.md]]) | One number *per neuron*, signed by that neuron's contribution |
| Who receives it | Everyone; specificity comes from which units happen to be active (eligibility) | Each unit separately, by construction |
| Scaling | Variance grows with the number of parameters — the perturbation family's problem | Cost is a delivery channel, not variance |
| Cortical candidate | Midbrain dopamine | **Distal apical tuft input**, this page |

The **separability** requirement rides alongside vectorization: the instructive signal must not be confused with the feedforward drive. Artificial networks separate them **in time** (forward pass, then backward pass) — objection 6, the phase-control signal the wiki keeps failing to pay for. The hypothesis tested here is that cortex separates them **in space**: feedforward input perisomatically and on basal dendrites, feedback input in layer 1 onto the distal tuft.

---

## Why a BCI task, and what it buys

Teaching signals are only defined relative to a reward function mapping neural activity to performance. In a natural task the experimenter does not know that function and may not be entitled to assume the brain represents it at all. A closed-loop neurofeedback BCI **stipulates** it.

| Element | Specification |
|---|---|
| Effectors | 8 or 10 layer-5 RSC pyramidal neurons, split into two spatially intermingled populations of 4–5 |
| Reward function | `P+` activity rotates a Gabor grating toward the 90° target; `P−` activity rotates it away; the controlled variable is the population difference `⟨ΔF/F⟩_{P+} − ⟨ΔF/F⟩_{P−}` |
| Threshold | Set per session from a passive-viewing baseline to give a 50% success rate on day 1, then held at the day-1 *z*-score |
| `P₀` | The surrounding imaged neurons, causally uncoupled from the stimulus — the internal control population |
| Read-out | Somata and their paired apical trunk dendrites, semi-simultaneously at 15.5 Hz per plane via an electrically tunable lens, longitudinally over 14 days |

**The design's real leverage** is not that the reward function is known — it is that `P+` and `P−` neurons are **causally opposite by construction while being anatomically identical and intermingled**. A scalar teaching signal must treat them alike; a vectorized one must not. The experiment therefore has a sign test where every previous dendritic study had only a correlation.

**Behavioural result.** Learning happens by *asymmetric regulation*: `P+` neurons hold their activity while `P−` neurons are downregulated over days, with `P₀` (matched for day-1 activity) falling between them.

---

## The measurement: the somato-dendritic (SD) residual

Somatic and dendritic calcium events are near-perfectly **coincident in time** (pairing threshold `r = 0.6`) but vary widely in *relative magnitude*. Deconvolve both traces (CASCADE), fit a line through all coincident (soma, dendrite) event-magnitude pairs, and take the residual:

```
SD residual = dendritic magnitude − fit(somatic magnitude)
> 0 : dendritically amplified   (distal input biased)
< 0 : dendritically attenuated  (somatic input biased)
```

The interpretation rests on a slice result: for the same number of triggered action potentials, dendritic GCaMP signals are larger under distal-trunk current injection than under somatic injection, so the residual reads out **which compartment the drive came from**, not how much the cell fired.

**Two independent causal validations that the residual is a real quantity, not a fitting artefact:**

| Manipulation | Prediction | Result |
|---|---|---|
| Anaesthesia (known to suppress top-down drive to the tuft) | Residual should collapse | Strongly reduced, scored against the awake best-fit line |
| Optogenetic activation of layer-1 **NDNF⁺** interneurons (ChRmine, 595 nm), which inhibit apical dendrites | Residual should collapse selectively | Strongly reduced; LED-only controls (`n = 5`) unaffected |

---

## The four conditions, and what was measured against each

| # | Condition for a dendritic teaching signal | Result |
|---|---|---|
| 1 | Dendrites carry information absent from the soma | SD residual predicted from the **surrounding network's** somatic activity in the preceding 2 s (linear SVM). ~20% of 466 neurons show a significant classification-confidence↔residual-magnitude correlation; in those, 61% binary decoding of amplified vs. attenuated (chance 50%). Amplified events also peak *earlier* than attenuated ones relative to the soma |
| 2 | Dendrites encode task-performance variables | Population SD residual decodes reward vs. no-reward at **63%**, and — critically — success vs. failure at **57%** in the 2 s *preceding* the outcome. Both abolished by NDNF⁺ activation |
| 3 | The signal tracks the neuron's own causal role | `P+` dendrites amplified during error-*reduction* epochs; `P−` dendrites amplified during error-*increase* epochs. Present in **6/6 mice**, and it survives restricting the analysis to neurons whose somatic activity is matched across the two epoch types |
| 4 | Disrupting the signal impairs learning | NDNF⁺ activation throughout the task abolished the vectorized error signal *and* blocked performance improvement; LED-only controls learned normally |

The decoding classifier was trained for binary classification only, never on magnitude — so the confidence↔magnitude relation is emergent, and is the reason condition 1 is read as *graded information* rather than a coin flip.

---

## Three findings that change what the wiki should build

**1. The signal is a derivative, not an error.** Epochs were defined by the **sign of the rate of change** of task error over 2 s bins, not by the error's level. So the dendritic quantity has the shape of `dE/dt` — which is exactly the temporal-error class's `ΔW ∝ ẋ_post · x_pre` (Bengio et al. 2015) sitting in an *explicit* compartment rather than being read off across two phases. The temporal/explicit dichotomy on [[wiki/concepts/biologically-plausible-credit-assignment.md]] is not a partition of mechanisms: the brain's candidate is a **derivative rule delivered through a dedicated compartment**, which is one from each column.

**2. It looks more like target propagation than like backpropagation.** The authors' own reading: the dendritic activity contains a **target for the parent soma** as well as error information, which is difference target propagation's object, not backpropagation's. Bartunov et al. 2018 found target propagation's binding constraint is *target diversity* — a 1-hot classification target starves it ([[wiki/concepts/biologically-plausible-credit-assignment.md]]). Here the targets are high-dimensional network states by construction, which is the regime in which target propagation was predicted to do well and has never been tested at scale.

**3. Credit assignment does not require independent branches.** The long-standing tension between "dendritic branches are independent computational units" and "in vivo, somatic and dendritic events almost always co-occur" is dissolved by measuring the **magnitude** channel: the timing is shared, the amplitude is not, and the amplitude alone carries the vector. This is *semi*-independence, and it is a much weaker anatomical demand than the dendritic-error models make ([[wiki/empirical-tensions.md]] T328).

**(brainstorm) The layer-1 interneuron is the write-enable, and it is addressable.** NDNF⁺ activation is a single knob that switches the teaching channel off without stopping the cell from firing. In a built model that is a *per-layer plasticity gate* that is anatomically separate from the forward path — which is the cheapest known answer to objection 6 that does not require an oscillation ([[wiki/concepts/encoding-retrieval-alternation.md]]) or a global controller. It is also gated by a cell type the wiki already knows as a controller in a different circuit: NDNF⁺ neurogliaform cells in CA1 set ensemble overlap under vmPFC→MEC command ([[wiki/concepts/inhibitory-control-of-coding.md]]). One cell class, two jobs, both of them "decide what gets written".

**(brainstorm) The 20% number is the load-bearing weakness.** Four fifths of recorded neurons show no significant network-predictability of their residual, and the decoders that do work run at 57–63%. Either the teaching channel is genuinely sparse — only a minority of cells are instructed at any time, which would be a strong and testable architectural claim — or the calcium/deconvolution pipeline is throwing away most of the signal. Nothing in the paper separates these, and the two readings imply opposite designs: a sparse instructed subset (cheap, and it needs a selection rule) versus a dense low-SNR channel (expensive, and it needs averaging).

---

## Open problems

- **Teaching signal or online control?** The authors flag it: dendritic error signals need not be about plasticity at all. In control-theoretic framings the error steers the system *during* operation. Distinguishing these requires manipulating dendritic activity at different phases of learning, and was not done.
- **Where does the signal come from?** Glutamatergic feedback from higher-order cortex, neuromodulation, or local recurrent excitation/inhibition — all live. Dopamine is the named candidate, which would make the vectorized signal a *product* of a scalar broadcast and a local factor rather than an independently addressed vector.
- **Local or propagated?** Whether each layer computes its own error or receives one from the layer above — the difference between a deep credit-assignment scheme and a stack of shallow ones — is untested here, and it is the question that decides whether this mechanism reaches depth at all.
- **Is an external feedback stimulus required?** Degrading the activity→feedback contingency is known to block BCI learning. Whether an animal can access the cost function from internal state alone is unknown, and a reasoning agent has no experimenter-supplied grating.
- **Does the sign test survive outside a stipulated reward function?** The whole design rests on the experimenter owning `P+`/`P−`. In a natural task there is no such label, so the result certifies the *existence* of the mechanism without supplying a way to observe it anywhere else.
- **One-to-one interneuron mapping is still unpaid.** The dendritic-error models need a specific pyramidal→interneuron correspondence; NDNF⁺ layer-1 activation is a blanket manipulation and says nothing about whether that wiring exists.

---

## Connections

- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — supplies the biological evidence that page's dendritic-error column was assumed to have: an apical compartment carrying a signed, cell-specific, pre-outcome error whose removal blocks learning — and it lands *across* that page's temporal/explicit dichotomy, since the measured quantity is a derivative of error held in a dedicated compartment.
- **[[wiki/concepts/dendritic-computation.md]]** — turns one entry of that page's "what is a dendritic match *for*" list into a measured answer, and weakens its independence premise: the credit channel rides on the *magnitude* of events whose *timing* is shared with the soma, so semi-independence suffices and full branch autonomy is not required.
- **[[wiki/concepts/reward-prediction-error.md]]** — the exact contrast case: a broadcast scalar with no address, versus a per-neuron signal whose sign is set by that neuron's causal contribution. The two are not rivals so much as the two ends of the axis this page defines, and dopamine is a candidate *source* for the vectorized signal, which would collapse them.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the wiring the result presupposes and now uses causally: feedback terminates in layer 1 on distal apical tufts while drive arrives perisomatically, and the layer-1 inhibitory population is the switch that turns the feedback channel off.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the same cell class in a second control job: NDNF⁺ neurogliaform cells gate the apical teaching channel in cortex here, and set ensemble overlap in CA1 there — so "which inhibitory family controls what gets written" is one question with two measured instances.
- **[[wiki/entities/pbwm.md]]** — the engineered version of this page's axis: a broadcast scalar is *made* vectorized by multiplying it with each stripe's own gating activation (`δ_j = snr_j·δ`), which is structural credit assignment as an anatomical product. This page's result says cortex may not need that trick because the vector arrives already addressed.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the alternative reading of the same channel: if the dendritic signal is dopaminergic in origin, it is a metaparameter delivered with spatial specificity rather than a teaching signal computed locally, and the two are distinguishable only by tracing the input.
- **[[wiki/concepts/latent-graph-discovery.md]]** — what the mechanism would be for: the slow-**W** learner needs per-synapse direction, and a broadcast scalar cannot supply it; this is the only cortical mechanism the wiki carries that delivers signed, addressed instruction without a backward pass.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — a rare case of the transfer running *backwards* and paying: a machine-learning concept (vectorization of the teaching signal) supplied the hypothesis, the experimental design and the four falsification conditions, and the biology answered.
