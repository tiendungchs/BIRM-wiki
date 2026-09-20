# Prediction-Error Neurons

**Cortical prediction error is computed by two sign-specific comparator circuits with opposite wiring — bottom-up excitation against top-down inhibition for *more than predicted*, top-down excitation against bottom-up inhibition for *less than predicted*. Intracellularly the residual is one signed scalar per cell; the split is in the input wiring and in the spike threshold that rectifies each cell's output to one half of it. The third class the scheme needs, the neurons holding the internal representation those errors are compared against, has never been demonstrated.**

The wiki carries predictive coding as an update rule ([[wiki/concepts/predictive-coding-free-energy.md]]) and as a laminar assignment ([[wiki/concepts/canonical-cortical-microcircuit.md]]). This page is the cell-class layer between them: what functional neuron types the framework *requires*, which of them have been measured, and which single-cell experiments would reject the scheme. It is the `L1`/`L2` content of Keller & Mrsic-Flogel 2018 — a decomposition claim and a signal-flow claim, both stated as falsifiable.

> **Provenance.** `raw/keller-2018-predictive-processing-canonical-cortical-computation.md` — Keller & Mrsic-Flogel, *Neuron* 100(2):424–435, 2018. A perspective, not a new result: it aggregates mouse V1 two-photon work (mismatch responses, visuomotor coupling), auditory and songbird feedback-manipulation studies, and cortical connectivity, and closes with six experiments that would refine or reject the model. Its distinctive move is to insist that "predictive processing" is only a claim about the brain once it names cell classes with wiring.

---

## Three required functional classes

| Class | Encodes | Projects | Measured? |
|---|---|---|---|
| **Internal-representation neuron** | the current model of the world in the *area's own coordinate system* | downward/outward — its activity **is** the prediction sent to other areas | **No clear demonstration exists.** Conjectured to be enriched in deep layers (L5), the main source of top-down output |
| **Positive prediction-error neuron** | bottom-up input **exceeds** prediction | upward — net **excites** internal-representation neurons in the target, activating a new cohort | Consistent with responses to unexpected added stimuli in human V1, marmoset primary auditory cortex, songbird auditory pallium |
| **Negative prediction-error neuron** | bottom-up input **falls short of** prediction (a *mismatch* response) | upward — net **inhibits** internal-representation neurons in the target, suppressing the current model | Yes: mouse V1 L2/3 neurons responding to omitted visual flow or an omitted expected stimulus; present in L5 but more prevalent in L2/3 |

**Why two circuits and not one signed unit.** A single high-baseline neuron could signal both directions by rate increase and decrease, and the dopamine system does exactly that ([[wiki/concepts/reward-prediction-error.md]]). Cortical L2/3 principal cells have baseline rates too low for bidirectional modulation to carry the negative half, so the sign must be split across two populations with opposite wiring. This is a **rate-budget argument, not an anatomical one** — it is the load-bearing premise of the whole decomposition, and it is the cheapest thing on this page to attack. It is not, however, the *only* argument for the split: Rao & Ballard 1999 proposed the same two populations from the signedness of the residual plus the ON-centre/OFF-centre precedent in the early visual pathway, so refuting the rate budget does not by itself collapse the decomposition.

The combined effect of the two: positive errors *add* to the internal representation, negative errors *subtract* from it, and the pair updates it toward the model that best predicts the current input. Recorded against [[wiki/empirical-tensions.md]] **T341**.

---

## The comparator wiring, and what it denies

| Cell | Excitation from | Inhibition from | Consequence |
|---|---|---|---|
| **Negative PE** | top-down prediction (driving) | **bottom-up-driven** interneurons — in mouse V1 L2/3, a subset of somatostatin-expressing cells | Response scales with *prediction strength*: a stronger or more salient prediction makes a larger mismatch |
| **Positive PE** | bottom-up input | **top-down-driven** interneurons (a frequent cortical motif) | Response scales with *unexplained input*; end-stopping and surround suppression are this circuit at the level of one receptive field |

The end-stopping row has a primary and a quantitative mechanism: the suppression is a prediction *learned from the training distribution*, since natural-image autocorrelation along the locally dominant orientation stays high out to ±50 pixels, so a bar's flanks predict its centre and the residual vanishes; cutting the descending feedback in the model removes end-stopping from 28/32 error units down to 5/32 (Rao & Ballard 1999, [[wiki/concepts/predictive-coding-free-energy.md]]). The caveat that page also supplies: in the linear case the descending term is algebraically interchangeable with within-level lateral inhibition, so an ablation attributes to feedback a share the tissue may reconstitute laterally ([[wiki/empirical-tensions.md]] **T343**).

Both errors are computed **inside the target area**. The descending projection is glutamatergic; the subtraction is done by a *local, learned* inhibitory circuit. A machine analogue therefore cannot implement the prediction as a negative weight on the descending link — the same conclusion [[wiki/concepts/canonical-cortical-microcircuit.md]] reaches from Bastos et al. 2012's effective-connectivity data.

**Feature-specificity is a hard requirement, and it has been met once.** A prediction-error neuron must report *what kind* of deviation occurred, not that one occurred — otherwise it is a novelty detector and carries no information the internal representation could be updated with. Mouse V1 mismatch signals are retinotopically organised and match visual signals in magnitude and spatial resolution, i.e. they are computed from *local* visual cues rather than from a global surprise signal. Everything the wiki reads off a "surprise" scalar ([[wiki/concepts/violation-of-expectation.md]]) is the aggregate of quantities that at this level are typed.

---

## The subthreshold measurement: the signed variable is per-cell, the two populations are what survives the spike threshold

> **Provenance.** `raw/jordan-2020-opposing-topdown-bottomup-layer23-v1.md` — Jordan & Keller, *Neuron* 108(6):1194–1206, 2020. Blind whole-cell current-clamp in mouse V1 (32 mice, 54 cells, 46 putative excitatory after excluding input resistance >100 MΩ or spike half-width <0.6 ms), head-fixed in the same closed-loop virtual tunnel, with 1 s visual-flow halts as mismatch and, after decoupling, 1 s open-loop flow at fixed or four speeds. 32 cells at <400 µm (putative L2/3), 14 at 480–750 µm (putative L5/6). This is the **intracellular** version of the two-photon literature every claim above rests on, and it is the first measurement that sees the error variable *below* the spike threshold.

The scheme's central prediction — that the two inputs enter a prediction-error cell with **opposing** signs — is here measured directly, per cell, as a correlation of membrane potential with visual-flow speed against a correlation with locomotion speed:

| Quantity | L2/3 | L5/6 |
|---|---|---|
| Significant subthreshold mismatch response | **78%** (25/32) | 36% (5/14) |
| Mean mismatch response | +0.8 ± 2.4 mV | **−1.5 ± 2.0 mV** (p < 0.01 vs L2/3) |
| Depolarizing (dMM, >1 mV) / hyperpolarizing (hMM, <−1 mV) | 17 / 6 | **1** / 7 |
| corr(`V_m`, visual flow) vs corr(`V_m`, locomotion), across cells | **R = −0.65** (p < 0.001, n = 22) | positive on both axes |
| Cells in an *opposing*-sign quadrant | **17/22** | 2/12 (p < 0.002) |
| corr(`V_m`,loco) − corr(`V_m`,visual) predicts mismatch response | R = 0.58 (p < 0.01) | R = −0.10 (p = 0.75) |
| Visual-flow response magnitude | 1.3 ± 2.8 mV | 2.0 ± 1.9 mV (**n.s.**) |
| Locomotion-onset depolarization | 3.5 ± 2.2 mV | 2.8 ± 2.2 mV (**n.s.**) |

Mapping to the two classes above: **dMM = negative prediction error** (motor-related excitation, visually driven inhibition — `V_m` falls as flow speed rises, mean R = −0.54 ± 0.21), **hMM = positive prediction error** (visually driven excitation growing with flow speed, motor-related inhibition). dMM and hMM visual responses are of opposite sign (−0.3 ± 1.6 vs +3.5 ± 3.0 mV, p < 0.003), and mismatch response is anticorrelated with visual response across cells at R = −0.49, rising to **R = −0.81** once the separate depolarizing response to visual-flow *offset* is subtracted out. So the mismatch response is largely the withdrawal of a visual input whose sign the cell's wiring fixes — not an inherited mismatch-triggered input.

**What this changes about T341.** Three results pull the two positions apart onto different levels:

| Observation | Reads as |
|---|---|
| The distribution of subthreshold mismatch responses is **unimodal**, spanning hyperpolarizing to depolarizing with no gap | One graded signed residual, as Position A's formalisms write it — the sign is a number on a continuum, and `V_m` in a single cell moves both ways |
| The distribution of input-sign *angles* is **bimodal** in L2/3 | Two populations, as Position B wires them — the continuum is in the response, the discreteness is in the input wiring |
| Only **10%** of L2/3 cells spike to mismatch, against 78% subthreshold | The spike threshold **rectifies**: each cell transmits only the half of its signed residual that depolarizes it; and none of 78 / 20–30 / 10 can be placed on one axis with the others (**T380**) |

The synthesis the wiki should carry: **the residual is a signed scalar inside each cell and a half-wave-rectified pair of channels between cells.** A machine layer that wants the biological arithmetic computes one signed quantity per unit (Position A's algebra, cheap) and transmits it as `[e]⁺` on one channel and `[−e]⁺` on another (Position B's wiring, which is what the receiver actually sees). The rate-budget argument that Position B rested on is confirmed rather than refuted — baselines are low, spiking mismatch responses are rare — but it turns out to constrain the *output stage*, not the comparator.

**The sign type is predictable from intrinsic biophysics, which is the closest thing yet to a marker.** Six electrophysiological properties measured in the first 60 s of each recording — resting `V_m`, input resistance, `V_m` variance while stationary, baseline spike rate, membrane time constant, spike threshold — jointly explain **77%** of the variance in mismatch response (leave-one-out predicted-vs-actual r = 0.65 ± 0.06 against −0.06 ± 0.21 shuffled), with no single property contributing more than 25%. The open problem above — that the scheme's cell classes have no genetic handle — now has a purely physiological handle that a patch-seq experiment could convert into one.

**The deep layers do something else, and it is not a weaker version of the same thing.** L5/6 cells receive visual-flow drive and locomotion drive of *comparable magnitude* to L2/3 (both n.s.) yet integrate them with the **same** sign, so they carry a positively weighted sum of self-motion and visual flow rather than a difference — closer to a speed-through-the-world estimate, and consistent with the internal-representation role the table at the top of this page assigns to deep layers by elimination. The absence of depolarizing mismatch responses in L5/6 is therefore not attributable to missing inputs: it is a missing *opposition*. This is the wiki's first direct evidence that the comparator is laminarly confined.

**Two limits that the method imposes and the conclusion has to carry.** (i) Current clamp cannot distinguish more excitation from less inhibition, so no row above identifies a synaptic sign — only a net effect on `V_m`. (ii) Somatic recording under low in-vivo input resistance is blind to distal dendritic and shunting inhibition, and the bottom-up inhibition the negative-error circuit needs comes from somatostatin cells that target **apical dendrites** — so the inhibition is systematically underestimated, which is the most likely reason overt visually driven hyperpolarization appears in only a subset of dMM cells. Both point at the same successor experiment: genetically encoded voltage indicators in the tuft ([[wiki/concepts/dendritic-computation.md]], [[wiki/concepts/apical-amplification.md]]).

**Why split the signs across cells at all, given that dopamine does not** — the paper's own answer, and it is an argument a builder can use: besides the rate budget, keeping the two signs on separate populations means **the error cell's own activity is directly usable as the plasticity signal**, with no downstream stage needed to decode a sign from a rate deviation. Rectified-and-split is the format a local learning rule can read ([[wiki/concepts/biologically-plausible-credit-assignment.md]]).

**The error code is typed per predictor, not per modality.** V1 receives separable predictions from locomotion, spatial location in a virtual environment, visual surround, head direction, vestibular and auditory input, and the cells responding to omission of a *location*-predicted stimulus are **not** the cells responding to visuomotor mismatch. So the population is partitioned by which predictor was violated, and the visuomotor mismatch protocol probes one small slice of it — which is a second reason the measured fractions above are lower bounds, and a reason L5/6 may still compute differences in a dimension this protocol never opened (e.g. vestibular against visual).

---

## The instrument problem: the two frameworks coincide under trial-averaging

Representational framework — response `R` of a neuron is a function of the bottom-up input `x`:

```
R = V(x)                                    (1)
```

Predictive-processing framework — prediction-error neurons additionally subtract a function of the top-down input:

```
R = V(x) − P(top-down prediction of x)      (2)
```

Experimenters control `x` and do **not** control `P`. Under any protocol in which `P` is constant — trial-averaging over many trials whose predictions differ, or anaesthesia, which gates top-down input off — (2) reduces to (1), and *both* internal-representation neurons and positive prediction-error neurons have responses identical to those the feature-detector account predicts. Predictive processing is an **extension** of the representational framework, not a rival to it, so no receptive-field measurement can separate them.

The escape is to supply a proxy for `P` that the experimenter *does* control: **self-generated movement**, on the assumption that the animal has learned how sensory feedback couples to its own motion. The representational account predicts no response difference between externally generated and self-generated versions of the same stimulus; the predictive account predicts a subset of cells signalling the deviation. This is why the entire empirical literature is about mismatch under closed-loop coupling rather than about tuning curves — and why the negative error is the load-bearing observation: a response to the *absence* of an expected input has no reading under (1) at all.

Bears on [[wiki/empirical-tensions.md]] **T277** (whether the single-neuron receptive field is the right unit above thalamus) and **T118** (what a superficial pyramidal spike means): the argument above says the standard instrument is *constitutively* unable to decide either, independent of how much data is collected.

**The escape has its own leak.** Motor-related activity in mouse V1 L2/3 persists in complete darkness and even after complete retinal lesion, and the same is true (reduced, not abolished) of the identified prediction-carrying projection ([[wiki/entities/a24b-m2-v1-projection.md]]). With no visual input there is nothing to represent and nothing predictable to predict, so this component is outside both frameworks — which means the movement proxy for `P` is a *sum* of a predictive term and a sensation-independent term, with only the sum measured ([[wiki/empirical-tensions.md]] **T345**).

---

## The efficiency argument is wrong, and the real payoff is simulation

The textbook justification — predictive coding is cheap because only residuals ascend — does not survive counting: **for every bottom-up spike cancelled there must be a top-down spike carrying the prediction that cancelled it.** To first approximation the total spike count is unchanged, so cortex is not more efficient in spikes per bit.

**The counting argument now has a behavioural measurement on its side.** In auditory cortex, a week of imposed running→tone reafference did not *reduce* movement-related suppression; it **redistributed** it along the frequency axis — more at the reafferent frequency, less at every other — and the animal's tone-detection deficit during locomotion was correspondingly abolished for a non-reafferent tone and retained for the reafferent one ([[wiki/entities/m2-auditory-cortex-filter.md]]). A roughly conserved budget reallocated by predictability is exactly what "no net spike saving" predicts, and it names the real payoff: not cheapness, but **sensitivity to the unpredicted**.

What the architecture buys instead:

| | Representational | Predictive processing |
|---|---|---|
| How the internal representation is updated | bottom-up drive only | a **combination** of bottom-up input and top-down prediction |
| Can it be updated with no bottom-up input? | No | **Yes** — decouple it from sensation and the model runs as a simulation |

Keller & Mrsic-Flogel's own gloss: running the model decoupled from input "is likely what we refer to as thinking." This is the same switch [[wiki/concepts/simulation-based-planning.md]] needs and [[wiki/concepts/predictive-coding-free-energy.md]] states as `γ → 0`, arrived at here as the *reason the architecture exists* rather than as a mode it happens to support. **(brainstorm)** It also reprices [[wiki/concepts/prediction-compression-equivalence.md]] for any neural substrate: if prediction does not reduce transmitted spikes, then compression is a property of the code, not a consequence of predicting, and the two must be argued separately.

---

## Predictions need not descend a hierarchy

An area's **coordinate system** is the basis its peripheral connectivity gives it — Gabor filters in primary visual cortex, spectro-temporal filters in primary auditory cortex, motor commands in motor cortex, objects in inferotemporal cortex. Each spans only part of the total space. A transformation from one area's coordinate system to another's **is** an internal model: motor → sensory is a forward model, sensory → motor an inverse model ([[wiki/concepts/arbitrary-sensorimotor-mapping.md]]).

The consequence is structural: **any** two areas with a learned transformation between them can exchange predictions, in both directions, whether or not either is "above" the other. Cortex as a whole is not arranged as a hierarchy, and systematic audio-visual correlations mean an auditory area can predict visual input as readily as the reverse. Predictions of V1 input have been observed based on locomotion, spatial location in a virtual environment, head direction, vestibular signals and stimulus timing — any signal explaining variance in the input can serve.

This is a **third position** on [[wiki/empirical-tensions.md]] **T259** (chain of command vs broadcasting apex): a non-hierarchical graph in which every edge carries predictions one way and errors the other *simultaneously*, so the direction of a message is a property of the cell class, not of the edge. It also names a class of models that reverse the standard flow — predictions up, errors down — as a live variant.

---

## What is known about how the circuit is learned

Predictive responses in rodent visual cortex emerge with experience, in three separable forms: passive exposure makes responses predictive of upcoming stimuli; visuomotor-coupling experience installs predictions of visual flow; experience in a spatial environment installs responses predictive of the visual input at a given location. The proposed rule is the same activity-dependent one that links co-firing nearby neurons into recurrent subnetworks, extended to long-range inter-areal connections: **a history of correlated firing decides which neurons in two areas become associated** ([[wiki/concepts/synaptic-plasticity.md]]).

**The site of plasticity is partially constrained** — the wiki's sharpest instance of a learning question narrowed by elimination rather than by measurement. In the mouse V1 L2/3 negative-error circuit:

| Element | Experience-dependent? |
|---|---|
| Somatostatin interneuron activity (the bottom-up inhibition) | **No** — measured |
| Interneuron → prediction-error-neuron synapse | Unknown — candidate |
| Top-down prediction → prediction-error-neuron synapse | Unknown — candidate |

**The visuomotor-coupling row now has a measured channel and a measured relearning schedule**, one synapse upstream of this table: the A24b/M2 → V1 projection's turn preference *reverses* when mice are trained in a left–right inverted virtual environment, within ≤10 sessions, by an amount that scales with behavioural performance, and only in the condition where visual flow is coupled to movement ([[wiki/entities/a24b-m2-v1-projection.md]]). So the action→sensory-content map is stored in cortex and is rewritable on a timescale of days — but nothing identifies the synapse that changed or the error signal that changed it, so the elimination logic below has not been run on the sending side at all.

**The same table, built from scratch in a second modality, with the "which interneuron" half measured** ([[wiki/entities/m2-auditory-cortex-filter.md]]). A mouse given an arbitrary running→tone contingency for 5–9 days (1 h is not enough; co-occurrence without speed-yoking is not enough) acquires a movement-gated notch at exactly that frequency in auditory cortex. The mechanism is this page's rule made visible: secondary motor cortex comes to recruit **PV⁺ and SST⁺ interneurons tuned to the reafferent frequency**, with divisive and subtractive components; the correlation between an interneuron's tone tuning and its M2 drive is strong in experienced animals and weak in naive ones. Because the M2 drive was applied as *bulk electrical stimulation*, sender-side selectivity is bypassed and the alignment is a fact about the projection's synapses onto tuned inhibition. So "which interneuron class receives the descending projection" is not only the computation — it is **what experience writes**. What it does not do is decide the table: M2→interneuron, an interposed cell, and interneuron→pyramidal remain all three compatible, so the second circuit inherits the same unresolved candidates.

Since the circuit as a whole is experience-dependent and the first row is not, the plasticity must sit on one of the other two. Deciding between them means blocking plasticity cell-type-selectively during sensorimotor learning. This is the concrete version of what [[wiki/gaps/g019.md]] asks for at the level of one measured circuit: *which* synapse a local rule is allowed to write.

---

## The gating signal, and why it is not optional

Prediction errors during passive observation must not update the motor program — listening to a conspecific's vocalisation should not retune one's own. So the error must be **gated on** only during self-generated action, which means a third signal beyond predictions and errors. Its required signature:

| Property | Why |
|---|---|
| Selectively alters the **coupling** between prediction-error and internal-representation neurons | It sets how much the model is revised, not how much error is computed |
| Correlated with **movement** in sensory and motor regions | That is the condition under which errors are motor-relevant |
| Manipulating it shifts the **top-down/bottom-up balance** and the gain of error responses | Otherwise it is not the precision term |

Candidate sources: classical neuromodulators (acetylcholine, noradrenaline) and higher-order thalamus, both of which change the operating regime of cortical circuits. This is [[wiki/concepts/precision-weighting.md]]'s `Π` restated as an experimental target with a behavioural condition attached — and it is the one place this page's framework makes a *dissociable* prediction, since a scheme with no gate cannot explain why passive experience leaves the motor program intact.

The same gate explains why experience-dependent predictive responses in visual cortex appear under quiet wakefulness but **not** when the animal is active, and why sensory adaptation depends on the task-relevance of the stimulus.

---

## The falsification programme

The paper's own list, condensed to what a modeller can use as a test battery:

| # | Test | Rejects the scheme if |
|---|---|---|
| 1 | Photostimulate putative internal-representation neurons (deep layers) while recording functionally identified L2/3 error neurons | Negative-error cells are not net **excited** and positive-error cells not net **inhibited** by them; and driving error cells does not update the local representation with the predicted sign |
| 2 | Look for prediction-error cells for *every* behaviourally meaningful cross-area correlation — eye, head, limb, whisker movement, each with its own sensory consequence | Errors exist only for whole-body translation, i.e. the motif is not canonical |
| 3 | Look for the same signals **outside** primary sensory cortex — prefrontal cells signalling deviation from a learned conceptual rule or an expected social pattern, in that area's own coordinate system | Prediction errors are a sensory-cortex specialisation, not a cortical computation |
| 4 | Block plasticity cell-type-selectively during sensorimotor learning | Neither candidate synapse above is the site |
| 5 | Manipulate the modulatory system | No shift in top-down/bottom-up balance follows |
| 6 | Characterise anti- and pro-psychotic drugs against predictions, errors and bottom-up signals | No common signature in the positive/negative error balance |
| 7 | Drive L2/3 cells with stimuli **constructed to violate the training statistics** rather than to be optimal for a filter — the residual's drive is deviance from the learned prior, so the strongest stimulus is the least natural one (Rao & Ballard 1999) | Peak responses track filter-optimality rather than statistical deviance |

Test 3 is the one that matters most for the wiki's purposes: it is the difference between predictive processing as a story about sensory cortex and as the **canonical cortical computation** that [[wiki/concepts/latent-graph-discovery.md]] could be built on. It has not been run. The nearest existing evidence is a subset of motor-cortex neurons signalling a deviation between intended and actual motor state.

---

## Where the framework is claimed to break

Read as a knob rather than a mechanism, the top-down/bottom-up balance gives a two-sided failure model: representation driven too strongly by predictions → perceiving what is not there and reading intention into noise (positive symptoms of schizophrenia); driven too weakly → inability to predict input, with stereotyped repetitive behaviour as a strategy that makes input predictable (an account of autism). Anti-NMDA-receptor encephalitis producing schizophrenia-like symptoms in adults and autism-like symptoms in children, plus a shared dysregulated gene network reported to move in opposite directions, is the offered support. **(tentative)** — the two-ends-of-one-knob claim is speculation in the source and is carried here only because it names the *one scalar* the architecture would be most sensitive to.

---

## Open problems

- **The scheme's central population is unobserved.** Internal-representation neurons have no demonstration, no genetic handle, and by construction look like feature detectors under most protocols. Every "the cortex holds the model" claim in the wiki rests on a cell class identified only by the role the theory assigns it.
- **The negative error *is* carried subthreshold, and it did not collapse the split.** Whole-cell recording finds hyperpolarizing mismatch responses in cells whose visual and motor drives oppose, so the rate budget holds at the output while the comparator itself runs on a continuum (**T341**). What is now unmeasured is the tuning test: nobody has quantified mismatch responses and visual tuning curves in the *same* cells, so "the two sign classes have non-overlapping feature preferences" remains asserted, and a purely visual account (e.g. relief from cross-orientation suppression) is excluded only by the locomotion-side anticorrelation, not by tuning data.
- **No experiment separates the cell classes by layer.** The working assumption — errors preponderant in L2/3, representations in L5 — is a convenience forced by the absence of markers, and is the assumption every proposed test inherits.
- **The population fractions do not agree across instruments.** Calcium imaging says 20–30% of L2/3 cells are mismatch-responsive, whole-cell says 78% subthreshold and 10% spiking, and the candidate reconciliations (intracellular dialysis, presentation rate, spike-independent calcium) are all untested — so "prediction-error neuron" may name the tail of a dense graded variable rather than a cell type (**T380**), and every cell count on this page inherits the ambiguity.
- **Nothing says how many modulatory signals there are or how they combine.** Attention, task relevance, movement gating and plasticity gating are all assigned to "the" precision signal without an argument that one quantity covers them ([[wiki/concepts/precision-weighting.md]] carries the same problem from the theory side).
- **The framework has no account of where a *new* internal representation comes from.** Errors update an existing representation; nothing here creates one, which is [[wiki/gaps/g023.md]] and [[wiki/gaps/g027.md]] at the level of one cortical area.
- **Non-hierarchical exchange is asserted, not modelled.** If every correlated pair of areas exchanges predictions and errors bidirectionally, the loops are cyclic and nothing in the paper says the resulting inference converges — the same problem [[wiki/concepts/loopy-belief-propagation.md]] names.

---

## Connections

- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the update rule this page supplies cell classes for, whose 1999 primary already proposed this page's two-population split (from the residual's signedness, not from a rate budget) and supplied the parameter-free end-stopping result that is the positive-error circuit's oldest evidence; and the one correction it forces: that formalism has a single error population `ξ` carrying a signed residual, while the low cortical baseline rate requires the sign to be split across two oppositely wired circuits, so a machine implementation choosing one signed unit is making a claim about baseline activity it has not stated.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the rival assignment of the same cells: Bastos et al. 2012 give L2/3 inhibitory interneurons *hidden-state expectations*, while this page gives a somatostatin subset the **bottom-up drive** that a negative-error cell is compared against — so the two schemes predict opposite effects of silencing the same population.
- **[[wiki/concepts/precision-weighting.md]]** — supplies the behavioural condition that turns `Π` from a free parameter into a measurable: the gate must be movement-correlated and must act on the error→representation coupling, because passive observation demonstrably fails to update the motor program.
- **[[wiki/concepts/simulation-based-planning.md]]** — the payoff this page argues the architecture exists for: because the internal representation is updated by top-down as well as bottom-up input, it can be run with sensation decoupled, which is the switch a rollout needs and which a purely feedforward representation cannot provide.
- **[[wiki/concepts/violation-of-expectation.md]]** — the behavioural instrument whose signal this page types: a scalar surprise score aggregates two quantities of opposite sign computed by different circuits, and mouse V1 mismatch responses are retinotopic and feature-specific, so a single scalar discards the information the brain's own error code preserves.
- **[[wiki/concepts/reward-prediction-error.md]]** — the contrast case that makes the split non-arbitrary: dopamine neurons *do* carry a bidirectional error on one population because their baseline rate permits it, which is exactly why the cortical argument has to go the other way — and the contrast now has a measured midpoint: cortical cells *do* carry the bidirectional error, as membrane potential, and lose the negative half only at the spike threshold (Jordan & Keller 2020).
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — the same object under a different name: a transformation between two areas' coordinate systems is an internal model, forward when motor → sensory and inverse when sensory → motor, and it is what makes activity in one area usable as a prediction in the other.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the proposed rule for building the prediction channel (correlated firing history selects which long-range partners associate) plus the wiki's one measured *elimination* of a candidate site: somatostatin interneuron activity is not experience-dependent, so the plasticity is on one of the two remaining synapses.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — supplies the interneuron taxonomy this page's comparator needs and the constraint on it: the subtraction is done by a local, learned inhibitory circuit rather than by a negative weight, so which interneuron class receives the descending projection *is* the computation.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the counting argument that limits it in neural hardware: every cancelled bottom-up spike is paid for by a top-down spike, so predicting does not by itself reduce transmitted spikes and compression has to be argued from the code.
- **[[wiki/concepts/attention.md]]** — the same gating signal read as attention: a context-dependent modulation of the top-down/bottom-up balance, which makes attentional gain and the licence-to-update-the-motor-program one mechanism.
- **[[wiki/entities/early-visual-system.md]]** — where the framework's earliest evidence lives: end-stopping and surround suppression as positive prediction errors, with somatostatin interneurons in mouse V1 L2/3 shown causally responsible for surround suppression.
- **[[wiki/entities/thousand-brains-theory.md]]** — agrees that every cortical area predicts its own next input and disagrees on the source: there the prediction comes from a movement-updated location code inside the column, here from another area's internal representation delivered over a learned coordinate transformation.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the reduction this page would have to serve: if test 3 finds deviation signals in prefrontal cortex in a *conceptual* coordinate system, then error-driven model revision is available above sensory cortex and the same circuit can update a relational graph; without it, the machinery is a sensory specialisation.
- **[[wiki/concepts/learned-world-models.md]]** — the biological realisation of the model/decoder split: each area's internal representation is a world model in *that area's* coordinate system, so there is no single global model and no single decoder — a distributed factorisation no machine world model in the wiki implements.
- **[[wiki/entities/a24b-m2-v1-projection.md]]** — the source of the prediction this page's comparator subtracts, identified at last: a dense topographic layer-5 projection from anterior cingulate / secondary motor cortex to V1 that carries a motor-conditioned prediction of visual flow, shows **no mismatch response** (confirming that prediction and error are on different cells), and whose inactivation *shrinks* the V1 mismatch response — the directional test the subtraction account demands. It also settles the coordinate question this page leaves open: the motor→sensory transform is completed in the sender, so the receiving area is handed a prediction already in its own basis, and the local comparator does nothing but subtract.
- **[[wiki/entities/m2-auditory-cortex-filter.md]]** — this page's "the subtraction is done by a local, learned inhibitory circuit" turned into a measurement, in a second modality and built from nothing: a week of an arbitrary movement→tone contingency makes secondary motor cortex preferentially recruit the auditory interneurons tuned to that tone (divisively *and* subtractively), an alignment absent in naive animals and present after training even under bulk electrical drive of the sender. It also supplies test 2's second positive case, and the behavioural payoff the spike-counting argument implies — suppression redistributed, not reduced, with detection improving exactly where it was withdrawn.
- **[[wiki/entities/cerebellum.md]]** — a third locus for the predictive machinery this page localises to cortical layer 2/3, and a *stronger* claim about the error's format: cortical prediction errors are in the receiving area's sensory coordinates, whereas the climbing-fibre error is claimed to arrive already in **motor-command** coordinates — measured as complex spikes whose spatial axes lie on the extraocular muscles while their waveforms carry retinal slip. That is what makes feedback-error learning a credit-assignment scheme and not merely a mismatch detector ([[wiki/empirical-tensions.md]] T342, [[wiki/empirical-tensions.md]] T107).
- **[[wiki/concepts/apical-amplification.md]]** — the opposite sign on identical anatomy: the same descending glutamatergic input to the same tuft produces a burst when it *matches* the feedforward drive rather than a cancellation, so the ascending message is the confirmed content instead of the residual, and the local inhibitory circuit this page needs to convert excitation into subtraction is not required (`T374`).
- **[[wiki/concepts/neuronal-parameter-heterogeneity.md]]** — the strongest functional case in the wiki for treating intrinsic constants as a code rather than as noise: six passive and threshold properties of a mouse V1 L2/3 cell predict 77% of the variance in its mismatch response, so the sign class a cell belongs to is legible in its biophysics before any stimulus is shown (Jordan & Keller 2020).
- **[[wiki/concepts/dendritic-computation.md]]** — the compartment the somatic measurement cannot reach, and therefore the limit on every number on this page: the bottom-up inhibition a negative-error cell subtracts arrives on the apical dendrite from somatostatin cells, where shunting and distal hyperpolarization are invisible to a low-input-resistance whole-cell recording at the soma.
- **[[wiki/concepts/state-prediction-error.md]]** — the same quantity computed the other way: an error over sensory events delivered as one subcortical broadcast pulse with no feature identity, versus this page's local, per-feature cortical error with its sign split across two cell classes — which makes the pair a direct test of whether structural learning needs a vector error or a scalar write-gate.
