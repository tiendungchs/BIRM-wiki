# Prediction-Error Neurons

**Cortical prediction error is not one signed quantity on one population: it is computed by two sign-specific comparator circuits with opposite wiring — bottom-up excitation against top-down inhibition for *more than predicted*, top-down excitation against bottom-up inhibition for *less than predicted* — and the third class the scheme needs, the neurons holding the internal representation those errors are compared against, has never been demonstrated.**

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

---

## The efficiency argument is wrong, and the real payoff is simulation

The textbook justification — predictive coding is cheap because only residuals ascend — does not survive counting: **for every bottom-up spike cancelled there must be a top-down spike carrying the prediction that cancelled it.** To first approximation the total spike count is unchanged, so cortex is not more efficient in spikes per bit.

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
- **The two-circuit split rests on a firing-rate budget.** If cortical L2/3 baselines are higher than assumed under natural conditions, or if the negative error is carried subthreshold, the sign-split decomposition is unnecessary and the wiki has one population, not two (**T341**).
- **No experiment separates the cell classes by layer.** The working assumption — errors preponderant in L2/3, representations in L5 — is a convenience forced by the absence of markers, and is the assumption every proposed test inherits.
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
- **[[wiki/concepts/reward-prediction-error.md]]** — the contrast case that makes the split non-arbitrary: dopamine neurons *do* carry a bidirectional error on one population because their baseline rate permits it, which is exactly why the cortical argument has to go the other way.
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — the same object under a different name: a transformation between two areas' coordinate systems is an internal model, forward when motor → sensory and inverse when sensory → motor, and it is what makes activity in one area usable as a prediction in the other.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the proposed rule for building the prediction channel (correlated firing history selects which long-range partners associate) plus the wiki's one measured *elimination* of a candidate site: somatostatin interneuron activity is not experience-dependent, so the plasticity is on one of the two remaining synapses.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — supplies the interneuron taxonomy this page's comparator needs and the constraint on it: the subtraction is done by a local, learned inhibitory circuit rather than by a negative weight, so which interneuron class receives the descending projection *is* the computation.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the counting argument that limits it in neural hardware: every cancelled bottom-up spike is paid for by a top-down spike, so predicting does not by itself reduce transmitted spikes and compression has to be argued from the code.
- **[[wiki/concepts/attention.md]]** — the same gating signal read as attention: a context-dependent modulation of the top-down/bottom-up balance, which makes attentional gain and the licence-to-update-the-motor-program one mechanism.
- **[[wiki/entities/early-visual-system.md]]** — where the framework's earliest evidence lives: end-stopping and surround suppression as positive prediction errors, with somatostatin interneurons in mouse V1 L2/3 shown causally responsible for surround suppression.
- **[[wiki/entities/thousand-brains-theory.md]]** — agrees that every cortical area predicts its own next input and disagrees on the source: there the prediction comes from a movement-updated location code inside the column, here from another area's internal representation delivered over a learned coordinate transformation.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the reduction this page would have to serve: if test 3 finds deviation signals in prefrontal cortex in a *conceptual* coordinate system, then error-driven model revision is available above sensory cortex and the same circuit can update a relational graph; without it, the machinery is a sensory specialisation.
- **[[wiki/concepts/learned-world-models.md]]** — the biological realisation of the model/decoder split: each area's internal representation is a world model in *that area's* coordinate system, so there is no single global model and no single decoder — a distributed factorisation no machine world model in the wiki implements.
- **[[wiki/entities/cerebellum.md]]** — a third locus for the predictive machinery this page localises to cortical layer 2/3, and a *stronger* claim about the error's format: cortical prediction errors are in the receiving area's sensory coordinates, whereas the climbing-fibre error is claimed to arrive already in **motor-command** coordinates — measured as complex spikes whose spatial axes lie on the extraocular muscles while their waveforms carry retinal slip. That is what makes feedback-error learning a credit-assignment scheme and not merely a mismatch detector ([[wiki/empirical-tensions.md]] T342, [[wiki/empirical-tensions.md]] T107).
