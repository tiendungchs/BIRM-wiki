# The M2 → Auditory Cortex Reafference Filter

**The wiki's second measured cortical prediction channel, and the one with an *acquisition* curve: a mouse learns over ~5–9 days that its own running produces a tone of frequency `f`, and secondary motor cortex comes to recruit exactly those auditory-cortical interneurons tuned to `f` — installing a movement-gated notch in the frequency axis that is behaviourally paid for by better detection of everything *outside* the notch.**

> **Why this is an entity page and not a section.** [[wiki/entities/a24b-m2-v1-projection.md]] establishes that a cortical top-down prediction channel exists and can be *rewritten*. It does not show one being **built from nothing**, does not price the cancellation behaviourally, and locates the forward model in the sender. This circuit supplies all three, and its answer to the third is the opposite one — which is why the two are separate objects and why they now carry a tension between them (`T346`).

> **Provenance.** `raw/schneider-2018-cortical-filter-acoustic-consequences-movement.md` — Schneider, Sundararajan & Mooney, *A cortical filter that learns to suppress the acoustic consequences of movement*, **Nature** 561:391–395, 2018. Mouse; head-fixed treadmill "acoustic virtual reality" (aVR), extracellular arrays in auditory cortex and auditory thalamus, two-photon calcium imaging of L2/3 excitatory cells, optogenetic photo-identification of PV⁺/SST⁺/VGAT⁺ interneurons, M2 electrical microstimulation, muscimol inactivation, and two lick-to-tone psychophysical tasks. **M2** = secondary motor cortex; **aVR** = acoustic virtual reality; **AC** = auditory cortex.

---

## The paradigm: reafference installed by the experimenter

| Element | Detail |
|---|---|
| Stimulus | 25 ms tone pips (5 ms cosine ramps), one fixed frequency per mouse from {2, 4, 8, 16, 32, 64} kHz |
| Coupling | inter-tone interval ∝ 1/(median-filtered running speed), scaled to the animal's measured footstep rate; saturates at 100 ms above 30 cm/s |
| Exposure | 2 h/day for 6–9 days; the animal freely alternates running and rest |
| Control on the confound | the treadmill's own running noise is **<1 dB** above rest, so the reafference is entirely the imposed tone |
| Read-out | tuning curves at rest and while running, from the same neurons, with tone frequency randomised after acclimation |

The design's value is that the action→consequence map is **arbitrary and novel** ([[wiki/concepts/arbitrary-sensorimotor-mapping.md]]): nothing in the animal's evolutionary or developmental history says running makes a 16 kHz tone. Whatever forms is therefore built, not revealed.

---

## What forms: a movement-gated notch on the frequency axis

| Measurement | Result |
|---|---|
| Response to the **reafferent** tone while running, after ~1 week | nearly abolished |
| Response to tones **≥1 octave** away while running | modestly suppressed — the same suppression aVR-*naive* mice show |
| Tones **½ octave** away | intermediate → the filter is a **notch with a width** |
| At rest | no difference: same fraction of responsive neurons, same firing rates at reafferent and non-reafferent frequencies |
| Independence of the neuron's best frequency | holds regardless — it is a filter on the *stimulus*, not a re-tuning of the cells |
| Auditory **thalamus** | movement-related suppression **flat** across frequency |
| Laminar profile | reafferent suppression stronger in infragranular than supragranular AC |

The notch width is attributed to the tuning width of AC inhibitory neurons — i.e. **the prediction's resolution is inherited from the actuator's receptive field, not chosen**. That is a design fact a builder cannot get from a soft mask: the granularity of what can be cancelled is set by the granularity of the cancelling channel.

### Three negatives that define the learning signal

| Regime | Tones presented… | Filter forms? |
|---|---|---|
| aVR | during running, at a rate **proportional to speed** | **Yes** |
| Anti-coupled | only at rest, with the same interval statistics | No |
| "Metronome" | during running, at a **fixed ~2/s** rate | **No** |
| 1 h of aVR (~1,000–3,000 tones) | as aVR, briefly | No |

The metronome row is the sharp one. Temporal co-occurrence of movement and sound is **not** sufficient; the sound's rate had to be a *function of* the movement's magnitude. So the quantity the learner requires is a **parametric contingency in a continuous variable**, not a correlation between two states — the same lesson [[wiki/entities/a24b-m2-v1-projection.md]] reaches from its uncoupled-playback control, where preference equalised instead of reversing.

**An asymmetry worth flagging: the contingency demanded is richer than the filter measured.** Learning required speed-yoking, but the read-out is a frequency-specific, movement-gated gain; whether the resulting suppression is itself *graded by speed* was not tested. If it is not, the circuit discards the very variable that taught it.

### It is not adaptation, and it is not the notch drifting into existence at rest

- Enhanced reafferent suppression is present **as soon as the animal begins to move**; stimulus-specific adaptation at the non-reafferent frequency emerges only after several tone presentations.
- Longitudinal two-photon imaging of L2/3 excitatory cells across the first 5 days: **resting** tuning curves stable (`r = 0.53`); the reafferent suppression index `RSI = (α − β)/(α + β)` (α, β = rest−run response differences at the reafferent frequency and two octaves away) grows monotonically with day.
- Tracking 241 tone-responsive neurons (of 577) across consecutive day pairs: tuning changed **only at the reafferent frequency and only in the running condition**.

**The filter is built in a gated copy of the tuning curve.** The same cell's rest tuning is untouched while its run tuning is edited at one point. A machine analogue is not a change to the encoder; it is a state-conditioned residual applied to the encoder's output — and the conditioning variable is not learned, it is the behavioural state itself.

---

## The mechanism: motor cortex learns *which* interneurons to recruit

Photo-identified PV⁺, SST⁺ and VGAT⁺ interneurons in aVR-experienced mice:

| Observation | Value / result |
|---|---|
| During running, spontaneous firing rate rises | **only** in interneurons responsive to the reafferent frequency |
| Size of that rise | scales with the strength of the interneuron's response to the reafferent tone |
| Putative excitatory cells | spontaneous rate falls slightly during running |
| Form of the suppression | **both divisive and subtractive** components — consistent with PV⁺ and SST⁺ both participating |
| M2 microstimulation (100 μs, 300 μA; response window 13–40 ms) | interneurons responding strongly to the reafferent frequency are driven **more strongly** by M2 than weakly-responding ones |
| Cross-check | PV⁺/SST⁺ cells most strongly M2-driven *at rest* show the largest running-related spontaneous increases |
| Excitatory cells | same correlation, weaker — consistent with M2 exciting both types but acting net-suppressively via feedforward inhibition |
| **aVR-naive mice** | only a **weak** correlation between tone-evoked and M2-evoked responses in interneurons |

The last row is what makes this a learning result rather than an anatomy result. **M2 stimulation here is bulk electrical**, so it bypasses any frequency-selectivity M2's own activity might carry: every M2 output cell in range is driven equally, and the reafferent-tuned interneurons still come out ahead — in experienced animals and not in naive ones. The specificity therefore lives in the **M2 → AC-interneuron connectivity**, and experience is what aligned it with the auditory tuning axis.

This is the wiki's clearest case of [[wiki/concepts/prediction-error-neurons.md]]'s rule that "the subtraction is done by a local, learned inhibitory circuit rather than by a negative weight" being *measured*, including the "learned" half: **which interneuron class the descending projection recruits is the computation, and that assignment is written by sensorimotor experience over days.**

---

## The behavioural price and payoff

Lick-to-tone detection, auditory-cortex-dependent (bilateral muscimol abolishes it):

| Manipulation | Effect on detection |
|---|---|
| Running (aVR-naive) | worse than at rest at **intermediate intensities, 10–40 dB**; motivation matched |
| Optogenetic activation of AC interneurons in a **resting** mouse | reproduces the deficit, at the same intensities |
| Optogenetic activation of **M2 axon terminals in AC** in a resting mouse | reproduces the deficit |
| Controls: V1 interneurons, GFP-expressing M2 terminals, bare skull illumination | all null |

So the movement-related suppression is not epiphenomenal — it *costs* hearing, and the same two circuit elements the aVR experience modifies are sufficient to impose that cost.

**The payoff, in the two-tone task.** Mice were trained to detect two tones two octaves apart (4 and 16 kHz), randomly interleaved, then given 7 days of aVR using one of them:

| | Reafferent tone (A) | Non-reafferent tone (B) |
|---|---|---|
| Before aVR | locomotion deficit | locomotion deficit |
| After aVR | locomotion deficit **retained** | locomotion deficit **abolished** |

Its L2/3 correlate is on the imaging side already: aVR experience *decreased* locomotion-related suppression at non-reafferent frequencies while increasing it at the reafferent one.

**This is the wiki's only measured instance of the claim every predictive account makes and none price: cancelling the predictable buys sensitivity to the unpredicted.** It is a within-animal, within-task, frequency-resolved trade — and note its shape. Total movement-related suppression was not reduced; it was **redistributed** along the frequency axis. A builder should read that as a conserved budget, not a free lunch, which is the opposite of the usual "predict it away and the channel is cheaper" story ([[wiki/concepts/prediction-compression-equivalence.md]]; and see the spike-counting argument on [[wiki/concepts/prediction-error-neurons.md]]).

---

## Comparison: the wiki's two measured cortical prediction channels

| | **M2 → AC** (Schneider et al. 2018) | **A24b/M2 → V1** (Leinweber et al. 2017) |
|---|---|---|
| Conditioned on | locomotion state (learning required speed-yoking) | motor output **and** current visual state |
| What is predicted | *which frequency channel* will be driven | the **magnitude and direction** of upcoming flow |
| Form of the top-down term | an **addressed gain**: a notch on a labelled line, gated by movement | a graded prediction of sensory content, ∝ predicted *change* |
| Where the specificity is stored | in the **sender→receiver synaptic matrix** (bulk M2 stimulation still selective) | in the **sender's activity** (axons retinotopically biased before delivery) |
| Anchor to the receiver's coordinates | tonotopy, but the *point* on the axis is learned | retinotopy, installed developmentally by topographic wiring |
| Delivered onto | PV⁺ / SST⁺ interneurons tuned to the reafferent frequency | L2/3 and L6 excitatory cells and PV interneurons; 0% of L4 |
| Learning shown | **de novo acquisition**, 5–9 days; 1 h insufficient | **reversal** of an existing map, ≤10 sessions |
| Behavioural read-out | detection of non-reafferent tones improves; reafferent stays impaired | optogenetic drive produces corrective steering |
| Locus test | thalamic suppression flat across frequency ⇒ cortical | muscimol/lesion of source shrinks V1 mismatch |

The row that generates a registry entry is **where the specificity is stored** — the two measurements land on opposite sides, and it is the one choice a machine implementation cannot defer. Recorded as [[wiki/empirical-tensions.md]] `T346`.

---

## What this settles, and what it does not

**Settles (one modality, one species, one imposed contingency):**
- A cortical movement→sensory-consequence filter can be built **de novo**, in cortex, in days, for an arbitrary and novel pairing, with **no hippocampal structure named anywhere in the circuit** — cortex-side evidence for `T28` position B, and an acquisition curve where [[wiki/entities/a24b-m2-v1-projection.md]] gave only a relearning curve.
- The learning signal must be a **parametric contingency**, not co-occurrence.
- The cancellation is implemented by **recruiting stimulus-tuned inhibition**, with divisive and subtractive components, and the tuning→recruitment alignment is what experience writes.
- Cancelling the predictable **improves detection of the unpredicted**, measured behaviourally, by redistributing a roughly conserved suppression budget rather than reducing it.

**Does not settle:**
- **The synapse.** M2 → interneuron, an interposed cell, or the interneuron → pyramidal synapse are all compatible with the data; the authors say so. This is [[wiki/concepts/prediction-error-neurons.md]]'s site-of-plasticity table, still unresolved, now with a second circuit that inherits the same three candidates.
- **The error signal that trains it.** Nothing here identifies what tells the circuit its prediction was wrong. A filter that only ever *suppresses* has no measured mechanism for growing back when the contingency is removed.
- **Whether M2's activity is also frequency-specific.** M2 axon tuning in AC was never recorded, so a *sender-side* component cannot be excluded — only shown to be unnecessary for the observed selectivity. This is the honest limit on `T346` position B.
- **Whether the filter is graded by speed**, i.e. whether it retains the continuous variable that taught it.
- **Whether this generalises above a labelled line.** The predicted quantity is a coordinate on a one-dimensional sensory axis with an inhibitory population already tiling it. Nothing says the same machinery predicts the consequence of an abstract operation, which is the version [[wiki/concepts/latent-graph-discovery.md]] needs — the same limit [[wiki/entities/a24b-m2-v1-projection.md]] carries.

---

## Connections

- **[[wiki/entities/a24b-m2-v1-projection.md]]** — the same computation in a second modality, agreeing on everything except the one thing a builder must choose: there the motor→sensory transform is completed in the sender and V1 is handed a prediction in its own basis, here bulk electrical stimulation of the sender still selectively recruits reafferent-tuned interneurons, placing the map in the sender→receiver synaptic matrix (`T346`). It also supplies what that page lacks — a *de novo* acquisition schedule (5–9 days; 1 h insufficient) rather than a relearning schedule, and a behavioural price for the cancellation.
- **[[wiki/concepts/prediction-error-neurons.md]]** — the measured instance of that page's rule that the descending projection is glutamatergic and the subtraction is performed by a *local, learned* inhibitory circuit: which interneurons M2 recruits is the computation, the alignment between an interneuron's tuning and its M2 drive is absent in naive animals and present after a week, and the suppression carries both divisive and subtractive components. It leaves that page's site-of-plasticity table unresolved with the same three candidate synapses.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — an inhibitory channel with a *content address* that was learned rather than wired: PV⁺ and SST⁺ cells recruited by a long-range cortical input specifically at one point on the tonotopic axis, with the notch's width set by their tuning width — so the resolution of what can be suppressed is a property of the actuator's receptive field, and the fan-in rule that page derives for generalise-vs-split acquires a second dimension (*where* on the sensory axis, not only *how broadly*).
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — a forward model for an association with no structure to exploit: running → 16 kHz is arbitrary and novel, and the cost shows in the schedule, days rather than the tens of trials that page reports for cue→action binding, which separates "learn an edge" from "learn to predict an edge's sensory consequence".
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — a descending term that is neither a scalar gain nor a full content prediction but an **addressed gain**: a movement-gated notch on a labelled line, which is a third functional form alongside the two that formalism's implementations usually offer.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — prices the cancellation and finds a conserved budget: aVR experience did not reduce total movement-related suppression, it moved it off the non-reafferent frequencies onto the reafferent one, with detection improving exactly where suppression was withdrawn.
- **[[wiki/concepts/attention.md]]** — the same trade under a different name and without a task: predictability alone, with no instruction, cue or reward, reallocates sensitivity across the frequency axis — so the wiki's selection machinery has a competitor that needs no controller.
- **[[wiki/concepts/precision-weighting.md]]** — a case where the low-dimensional channel and the content channel are hard to separate: what is delivered is close to a gain, but it is *addressed* to one band, so bandwidth alone does not classify it and the distinction has to be made by whether the address is learned.
- **[[wiki/entities/cerebellum.md]]** — the classical home of reafference cancellation via efference copy, and the contrast: this filter is cortical (auditory thalamic suppression is flat across frequency), is built for an arbitrary contingency, and cancels *sensory content* rather than predicting the plant's state.
- **[[wiki/gaps/g039.md]]** — the case where the anchor is only *half* free: the group is installed in the substrate (tonotopy), but the point on the axis is not — which frequency gets suppressed is learned over days by aligning the projection against a population whose receptive fields already enumerate the group's elements. So an installed topology supplies the domain of the argmax and not the argmax, and an anchoring mechanism needs both the group and a population that tiles it.
- **[[wiki/concepts/latent-graph-discovery.md]]** — one edge (action → sensory consequence) shown to be **acquirable from scratch in cortex** and stored on a wire, with the sharp caveat that the consequence is a coordinate on a pre-existing one-dimensional sensory axis, which is the case the framing least needs.
