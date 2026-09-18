# Inter-Areal Synchrony — What a Correlation Between Two Modules Actually Licenses

**When two modules' activity is correlated, the frequency band of the correlation identifies the mechanism that produced it: gamma-band synchrony collapses when the direct axons between them are silenced, theta-band synchrony does not — so one band measures synaptic drive on the link, the other measures a clock supplied by a third region.**

> **Provenance.** Sigurdsson & Duvarci 2016, *Hippocampal-prefrontal interactions in cognition, behavior and psychiatric disease*, Front Syst Neurosci 9:190 (`raw/sigurdsson-2016-hippocampal-prefrontal-interactions.md`). A review organized around the *measurement* of an inter-areal interaction rather than around either endpoint. The hippocampus↔prefrontal circuit is the worked case; the argument is about inter-areal coupling generally.

**Canonical home for band claims.** Theta, gamma, alpha/beta and their couplings appear on 24 pages; this is the page that says what a band *licenses*, and any page asserting a band effect should link here rather than restate the rule. Theta in particular is treated here as a **measurement variable, not a concept** — it has no page of its own by decision, because every load-bearing claim about it in this wiki is a claim about what a theta-band correlation does or does not license (lint pass, 128 ingests).

Why this earns a page. The wiki has been treating "module A talks to module B" as a single primitive — one arrow, one wire, one weight matrix ([[wiki/entities/medial-prefrontal-cortex.md]], [[wiki/entities/nucleus-reuniens.md]], gaps G52/G53). The measurements the arrow rests on are correlations, and they decompose. A builder who imports "synchrony coordinates modules" without the decomposition imports two different claims fused into one.

---

## The measures, and what each one licenses

| Measure | What it computes | What it licenses | What it does not |
|---|---|---|---|
| **Spike cross-correlation** | Do neurons in A and B fire within a short window (~100 ms in this circuit) | Directionality: A's spikes can lead or lag B's | Says nothing about content |
| **Phase locking** | Is B's spiking modulated by the phase of A's local field potential | Per-neuron: which cells in B are currently listening to A | Locking to *past* phases is the monosynaptic-drive signature; locking to *future* phases also occurs and is unexplained |
| **Coherence** | Is the phase offset between two field potentials stable over time | A population-level channel-open measure | Field potentials **volume-conduct**; a coherence result without a spike-based companion may be one signal recorded twice |
| **Power correlation** | Do the two amplitude envelopes covary | The measure that bridges to the imaging literature | Slow; loses phase |
| **Functional connectivity (BOLD)** | Do the two haemodynamic signals covary | The only measure available at scale in humans | Confined to **< 0.1 Hz**, two to three orders of magnitude below the 1–100 Hz band of every electrophysiological result |

**The timescale gap is not a detail.** Every cross-species claim in this literature — and every wiki claim that leans on human connectivity to support a rodent circuit — spans that gap. The offered bridge: the BOLD signal tracks local **gamma power**, whose envelope fluctuates slowly, so cross-regional gamma-envelope correlation is the electrophysiological quantity that human functional connectivity is closest to (Schölvinck et al. 2010, in Sigurdsson & Duvarci 2016). Nothing validates the bridge at the level of a specific claim — and the bridge is contested: EEG/MEG studies recover the same resting networks from **alpha/beta** (8–32 Hz) amplitude envelopes whose power correlates *negatively* with BOLD, against the intracranial gamma-positive result, with no whole-brain simultaneous recording available to arbitrate ([[wiki/empirical-tensions.md]] T242, [[wiki/concepts/metastability.md]]).

---

## The band tells you the mechanism

The decisive design is cutting the direct projection and asking which correlations survive.

| Manipulation | Gamma synchrony | Theta synchrony | Source |
|---|---|---|---|
| Optogenetic silencing of ventral-hippocampal terminals in prefrontal cortex | **Abolished** | **Unaffected** | Spellman et al. 2015 |
| Genetic silencing of entorhinal → CA1 monosynaptic input | **Abolished** | **Unaffected** | Yamamoto et al. 2014 |
| Pharmacological inactivation of ventral hippocampus | — | Prefrontal–dorsal-hippocampal theta **disrupted** | O'Neill et al. 2013 |

Reading, stated as a rule: **gamma-band coupling ≈ the strength of direct afferent drive on the link; theta-band coupling ≈ a common input or relay that neither endpoint computes.** Candidate theta sources in this circuit: the medial septum (rhythmic theta drive to both hippocampus and entorhinal cortex), the ventral hippocampus itself as a synchronizer of the other two nodes, the nucleus reuniens ([[wiki/entities/nucleus-reuniens.md]], whose lesions impair the same spatial working-memory tasks), and lateral entorhinal cortex.

Two consequences the wiki has to carry:

- A correlation between modules is **not** evidence that they are connected. Cutting the wire left theta intact in both experiments above.
- The *same anatomical wire* runs several logical channels at once, distinguished by band — content on one, coordination on another. No architecture in the wiki has more than one logical channel per connection ([[wiki/entities/medial-prefrontal-cortex.md]] reaches the same conclusion from Brincat & Miller 2015).

**A competing rule assigns the bands by distance rather than by mechanism, and one model depends on it.** Knowlton, Hummel & Holyoak 2012 read the same band split as a conduction fact — low-band coherence is what survives over several millimetres, gamma is what local circuits do — and build on it a *content* channel: posterior semantic activity reaches prefrontal binding units by theta, whose phase then modulates local gamma amplitude and so schedules which role bindings are loaded ([[wiki/entities/lisa.md]]). The two rules give opposite answers to whether an observed fronto-temporal theta coherence means the two areas are exchanging semantics. Logged as [[wiki/empirical-tensions.md]] T333; the discriminating experiment is this section's own design (cut the direct projection) with phase–amplitude coupling rather than per-band coherence as the read-out.

---

**A second, orthogonal band rule: the band also types the *direction* of a hierarchical message.** Feedforward inter-areal influence is carried at higher frequencies than feedback (Bosman et al. 2012), and within a column the superficial layers are gamma-dominated while the deep layers are alpha/beta-dominated (Roopun et al. 2006; Maier et al. 2010; Buffalo et al. 2011), with strong coherence *within* each compartment and weak coherence *across* them. The wiki held this rule second-hand until the Bastos et al. 2015 ingest; **the measurement is the next section**. Predictive coding derives this rather than fitting it: expectations accumulate prediction errors, integration is a low-pass filter, and the nonlinear prediction map re-creates high frequencies on the way down, so **error must run faster than the estimate that absorbs it** (Bastos et al. 2012, [[wiki/concepts/predictive-coding-free-energy.md]]). The two rules compose: the band identifies *whether* the correlation is carried by the direct axons (gamma vs. theta, above) and, among those that are, *which way up the hierarchy* the message runs.

**(brainstorm)** This makes a spectral statistic a **weight-free probe of computational role**: in any recurrent model with two interacting populations, the one whose power spectrum is shifted low is the integrator and the one shifted high is the residual — measurable from activity alone, with no access to parameters and no laminar labels.

---

## The direction rule, measured: a correlation spectrum against the anatomy

> **Provenance.** `raw/bastos-2015-feedforward-feedback-frequency-channels.md` — Bastos, Vezoli, Bosman, Schoffelen, Oostenveld, Dowdall, De Weerd, Kennedy & Fries, *Neuron* 85(2):390–401, 2015. 252-electrode subdural ECoG over **8 macaque visual areas** (V1, V2, V4, TEO, DP, 7A, 8L, 8m) in **2 monkeys**, 28 area pairs, during a cued visuospatial attention task; Granger-causal (GC) influence spectra from nonparametric spectral matrix factorization on 0.5 s epochs. The anatomical term is SLN from an **independent set of 25 monkeys** ([[wiki/concepts/counterstream-organization.md]]) — dynamics and anatomy are measured in different animals and correlated across pathways, which is why this is a head-to-head and not a re-description.

**The estimator.** For each area pair and each frequency, the *directed influence asymmetry index*

```
DAI(f) = [GC(A→B, f) − GC(B→A, f)] / [GC(A→B, f) + GC(B→A, f)]
```

is correlated (Spearman, across all pairs) with that pathway's SLN. A **positive** DAI–SLN correlation at frequency `f` means `f` carries feedforward influence; **negative** means feedback. The output is a *correlation spectrum* — the band assignment is read off it rather than assumed.

| Band | DAI–SLN correlation | Direction carried |
|---|---|---|
| **Theta ~4 Hz** | positive | feedforward |
| **Beta 14–18 Hz** | negative | **feedback** |
| **Gamma 60–80 Hz** | positive | feedforward |
| Broadband > 80 Hz, to 250 Hz | **not systematic** | none — the high-frequency asymmetry is not a generic power effect |

Three narrow bands, not a continuum: interareal *coherence* in the same data has exactly three peaks (theta, beta, gamma), and the spectrum is essentially unchanged before the cue and **before stimulus onset**, so the channel assignment is a property of the circuit and not of the stimulus.

**Cross-checks that matter for what the bands license.** A **conditional** GC analysis — removing influence mediated by any one of the other recorded areas — left gamma and beta unchanged and *degraded theta*, "suggesting the involvement of larger networks for theta". That is this page's first rule (gamma ≈ direct axonal drive, theta ≈ a clock supplied by a third party) recovered from an independent dataset and a different measure, in visual cortex rather than the hippocampal–prefrontal circuit. The authors' own alternative for theta is peripheral rather than cortical: theta-rhythmic **microsaccades** produce retinal image motion and a fresh feedforward volley. Excluding microsaccade epochs left gamma unchanged; the same control is not reported as clearing theta.

### A functional hierarchy built from dynamics alone

Averaging the three bands' DAIs after sign-flipping beta gives a multiband `mDAI` per pair, which correlates with SLN at **R = 0.6** (`p < 1e−8`). Rescaling `mDAI` into ten levels and averaging over target areas yields a **functional hierarchy** with small standard errors — i.e. pairwise influences are mutually consistent with one global ordering, the same global-model test the anatomy passes.

| Quantity | Anatomy (SLN) | Dynamics (mDAI) |
|---|---|---|
| Pairwise direction agreeing with the fitted global hierarchy | 80% (36/45 pathways) | 86% (24/28 pairs) — not different, `p = 0.79` |
| Robustness | — | Removing V1 leaves the other seven positions at `R = 0.96`; survives removing 3 areas from the bottom or 2 from the top |
| Correlation between the two hierarchies | — | `R = 0.93` postcue, `R = 0.91` precue, **n.s. (`p = 0.2`) prestimulus** |

**The dissociation is the result.** Posterior areas V1 → V2 → V4 → TEO → DP → 7A hold their order across all three task epochs. The two frontal-eye-field subdivisions do not: **8L drops in the precue period and both 8L and 8m fall to the bottom of the hierarchy before the stimulus**, and V1/V2/V4 compress together. A hierarchy read off dynamics is therefore *partly* a fixed property of the wiring and *partly* a task variable, and the task-variable part is concentrated in exactly the frontal areas where the anatomical ruler also fails to be consistent between injections ([[wiki/empirical-tensions.md]] **T378**) — two independent methods locating the same boundary. Carried into **T252**.

### The control knob the paper names

Because gamma is supragranular and beta infragranular, the authors state a mechanism for moving an area's level without touching an axon: **drive an area's superficial layers and its gamma output rises → it moves *down* the hierarchy; drive its deep layers and its beta output rises → it moves *up*.** Hierarchical position becomes a per-area scalar set by the laminar balance of drive. Untested — it needs simultaneous multi-area *multilayer* recording, which this ECoG study cannot supply.

Consistent with it: directing attention to the contralateral stimulus enhanced **top-down beta** (grand average `p < 0.001`; all 13 pairs with a significant effect) **and bottom-up gamma** (`p < 0.001`; 13/14 pairs). Top-down and bottom-up channels rise *together*, which is why the paper refuses to operationalize feedback by a cognitive contrast and anchors on anatomy instead: enhanced top-down drive causes enhanced bottom-up drive, so an attention contrast cannot separate them ([[wiki/concepts/attention.md]]).

**A counterexample to the frequency-*ordering* reading of the rule.** Predictive coding derives that errors must run *faster* than the expectations that integrate them — a statement about relative frequency. Bastos et al. 2015 find feedforward at **theta, 4 Hz**, which is far *slower* than the 14–18 Hz feedback band. The rule that survives is channel identity (three named bands with fixed direction labels), not frequency order. Either theta feedforward is a sampling artefact imported from the eye and the cortical rule is intact, or cortex has a second, slow feedforward channel the integration argument does not predict. Logged as [[wiki/empirical-tensions.md]] **T379**.

**(brainstorm) What a builder gets is a routing tag that is free to read.** Direction here is not an edge attribute but a *carrier frequency* on a bidirectional link — one pair of nodes, three channels, each channel's direction fixed and its gain task-set. The machine analogue is frequency-division multiplexing over a symmetric edge: a message's role (error vs. prediction) is encoded in how fast it is modulated, so a receiver can demultiplex by filtering rather than by knowing which port it came from, and a controller can retune the whole graph's depth ordering by changing three gains per node. That is a much cheaper dynamic-routing primitive than rewriting a weight matrix, and it is the concrete form of what [[wiki/concepts/network-communication-models.md]] asks for.


---

---

## The lag is not the wire, and the direction is not the architecture

> Eichenbaum 2017 (`raw/eichenbaum-2017-prefrontal-hippocampal-episodic-memory.md`), full treatment at [[wiki/entities/hippocampal-prefrontal-channel.md]].

Cross-correlation with the two signals time-shifted against each other is the standard way this literature assigns a *direction* to a coupling. Three facts constrain what that measurement licenses.

- **The measured lead is ~30 ms in every hippocampal–prefrontal study that reports one**, in either direction, and the monosynaptic conduction delay on that pathway is **~15 ms**. So the lag is not the wire's latency. Two readings: theta synchronises the two areas and information moves in **one-gamma-cycle packets** of ~30 ms; or the transfer is polysynaptic at the target even on the "monosynaptic" route (interneuron → pyramidal cell). Either way, **a directed lag is not a conduction time and cannot be used to infer path length.**
- **Direction reverses within a trial.** Hippocampus leads prefrontal cortex by ~30 ms at context entry and across a memory delay; prefrontal cortex leads hippocampus by ~30 ms at object sampling and at the choice point — same animals, same task, and *both* directions present only on correct trials. A single-number directionality index computed over a whole session would report zero.
- **The band of the return leg is not stable across tasks.** One study puts the prefrontal→hippocampal lead in low gamma (30–80 Hz) at the choice point; another puts it in theta in the same epoch of a different task. This is an unresolved problem for the band-types-the-mechanism rule above, which was derived from the *forward* leg only.

One control from these studies worth importing wholesale: the correct/error comparison is restricted to trials on which the animal made the **same behavioural response**, so the connectivity difference cannot be a motor or reward-expectation confound. Most "coupling predicts performance" claims in the wiki do not have this.

---

## A third band rule: the frame band types the *content format*, and the ratio is a capacity

The two rules above type a correlation by **mechanism** (direct drive vs relayed clock) and by **direction** (feedforward fast, feedback slow). A third types it by **what is being held** (Roux & Uhlhaas 2014, `raw/roux-2014-wm-oscillations-alpha-gamma-theta-gamma.md`).

| Content in the delay | Coupling observed | Sites | Proposed generator |
|---|---|---|---|
| Sequentially ordered items (verbal, Sternberg) | **theta–gamma** phase–amplitude coupling, load-dependent (Axmacher et al., human hippocampal depth electrodes); stronger on correct trials (Holz et al.) | fronto-temporal, hippocampal | fronto-hippocampal networks |
| Simultaneous visual/spatial arrays | **alpha–gamma** — asserted, **never measured** in a delayed-match task | parietal–occipital | thalamo-cortical |

Two claims a builder can use, and they are separable from the WM framing:

- **Cross-frequency coupling is a slot mechanism with an arithmetic capacity.** One gamma cycle carries one item; the slower rhythm is the frame; the number of slots is the frequency ratio. **(brainstorm)** ≈5–6 gamma cycles per 7 Hz theta cycle against ≈4 per 10 Hz alpha cycle, offered as the origin of the higher span for sequential than for simultaneous material. A band claim thereby becomes a *quantitative* claim about a store rather than an interpretive one ([[wiki/concepts/working-memory.md]]).
- **Switching content format switches the band and the recording site together.** Replacing ordered items with a discrete visual array replaces delay theta with delay alpha, at different electrodes — so a band difference between two conditions can be a difference of *network*, not of coupling strength on one network. Any experiment reading a band amplitude across conditions with different material inherits this confound.

**Where this sits against the page's other rules.** It is compatible with the distance rule and with the direct-drive rule, and it sharpens the discriminating experiment for T333: the format manipulation moves the theta *without* moving the anatomy of the semantic store, so measuring whether prefrontal gamma amplitude follows theta phase under a *sequential* load and alpha phase under a *simultaneous* one tests whether the slow band is carrying content or supplying a clock, without cutting anything.

---

## A fourth band rule: within one band, the sub-band names *which afferent stream* is driving the receiver

> Shin & Jadhav 2016 (`raw/shin-2016-hippocampal-prefrontal-interaction-modes.md`), reviewing Colgin et al. and Schomburg et al.

The three rules above type a coupling by mechanism (direct vs. relay), by direction (feedforward vs. feedback) and by content format. A fourth cut runs *inside* the gamma band and types the **source** of the drive on a receiver with two afferents:

| Sub-band | Theta phase it occupies in CA1 | Afferent it indexes |
|---|---|---|
| **Slow gamma, 40–60 Hz** | one phase | Internally driven — CA3 recurrent input |
| **Fast gamma, 80–120 Hz** | a different phase | Externally driven — entorhinal input |

Slow gamma additionally accompanies sharp-wave-ripple replay, where it is proposed to shape the attractor states the replay passes through.

**What a builder takes from it.** The wiki's read-out proposals so far ask *whether* a receiver is coupled to a source. This says a receiver whose two input streams are separated in **frequency and in phase of a shared frame** can be read for *which stream currently dominates* from the receiver's own spectrum, with no access to either source — and, since the two phases are non-overlapping, that the streams are **time-division multiplexed** rather than summed. That is the concrete mechanism behind [[wiki/concepts/encoding-retrieval-alternation.md]]'s phase-scheduled switch between storing external input and reading internal recurrence, and it makes the schedule measurable in an artificial network: band-pass the hidden state, check whether recurrent-dominated and input-dominated timesteps fall at consistent phases of a slower carrier.

**A caveat this source raises against its own band rule, and it bounds this page's headline claim.** Prefrontal gamma is coordinated with hippocampal *theta*, and silencing the direct hippocampal terminals abolishes prefrontal gamma — but hippocampal–prefrontal gamma **coherence** has, on the review's own statement, "yet to be shown". So the "gamma = direct drive" rule in the section above is supported by an *abolition* result at one endpoint, not by a demonstrated inter-areal gamma coupling that the abolition removes. The content channel is inferred from what disappears, not from what was measured passing.

---

## Synchrony predicts which neurons carry the task variable

| Observation | Detail | Source |
|---|---|---|
| Prefrontal cells phase-locked to dorsal-hippocampal theta are the ones whose firing **predicts the animal's upcoming choice**; non-locked cells largely do not | T-maze working memory | Fujisawa & Buzsáki 2011; also Hyman et al. 2011, Remondes & Wilson 2013 |
| Phase-locking to **ventral** (not dorsal) hippocampal theta selects the cells with anxiety-related firing | Elevated plus maze | Adhikari et al. 2011 |
| Silencing the direct input **abolishes goal-specific prefrontal firing** during encoding, together with gamma phase-locking | Four-goal T-maze | Spellman et al. 2015 |

**The tuning is inherited from the input, and the phase-lock is the receipt.** This is the strongest interpretive claim in the source: a neuron's response properties reflect which afferents currently drive it, and synchrony is the observable of that drive.

**(brainstorm) Synchrony as a routing probe.** This converts an untestable question in machine terms — *which module is this unit's representation coming from?* — into a cheap measurement: correlate a unit's activity with each candidate source module's band-limited population signal and read off the source. It is a routing readout that needs no ablation, no probe classifier and no gradient ([[wiki/concepts/representation-probing.md]]). The biological version predicts tuning; a network version would predict which pathway an ablation will damage before running it.

---

## What modulates it

| Variable | Effect | Source |
|---|---|---|
| **Task phase** | Theta coupling peaks at the **choice** point; gamma peaks during the **sample/encoding** phase | Jones & Wilson 2005; Spellman et al. 2015 |
| **Correctness** | The choice-phase theta increase is **absent on error trials** | Jones & Wilson 2005 |
| **Learning** | Theta synchrony rises **across acquisition**, in parallel with performance — the edge is trained, not fixed | Sigurdsson et al. 2010 |
| **Rule acquisition** | Synchrony is greatest at the choice point *after* a new rule is acquired, alongside the emergence of prefrontal cell assemblies | Benchenane et al. 2010 |
| **Decision, not memory** | Coupling peaks at choice points in tasks with **no working-memory demand**, when both regions carry most trajectory information | Remondes & Wilson 2013 |
| **Outcome** | In monkeys, theta after **errors**, alpha/beta (9–16 Hz) after **correct** trials — the band, not the amount, codes outcome | Brincat & Miller 2015 |
| **Memory load (human)** | Coupling **increases** with load in some studies, **decreases** in others; unresolved | Axmacher et al. 2008; Rissman et al. 2008; Finn et al. 2010 vs. Meyer-Lindenberg et al. 2005 |
| **Anatomical origin** | Coupling with the **ventral** pole exceeds the dorsal, matching the monosynaptic projection's origin | Adhikari et al. 2010; O'Neill et al. 2013 |
| **Exogenous stimulation of the pathway (human)** | Continuous 50–130 Hz deep brain stimulation of the ventral internal capsule/ventral striatum raises **induced** prefrontal theta power *during* a conflict task and leaves resting theta and the time-domain evoked potential unchanged; alpha and beta barely move | Widge et al. 2019 |

The stimulation row adds a distinction the measures table above does not make: **induced (non-phase-locked) band power versus evoked (phase-locked) response.** Averaging in the time domain keeps only what is time-locked to the stimulus; the entire effect here lives in the part that averaging destroys, and the interference effect lives in the part it keeps (a dorsal anterior cingulate evoked deflection at 291–473 ms). A model that reads a band's *amplitude envelope* and a model that reads a stimulus-locked transient are reading disjoint halves of the same recording, and here they respond to different manipulations.

The learning row is the one with no machine analogue. Every inter-module connection in the wiki is either fixed wiring or a weight matrix trained by the same rule as everything else (gap G52); here the *coordination* between two modules is itself acquired over training and its magnitude tracks competence, which makes it a candidate progress signal rather than a parameter.

---

## Design rules a builder can take

| Rule | Statement |
|---|---|
| **Never call a correlation a channel** | Before attributing a measured inter-module correlation to the link, cut the link. Whatever survives is a third module's clock. |
| **Type your channels by band, not by endpoint pair** | One wire, ≥2 concurrent logical channels: a content channel whose gain is the afferent drive, and a coordination channel supplied externally. |
| **Give the clock a source** | If an architecture needs two modules aligned in time, the biology does not have them negotiate it — a third region broadcasts it (septum, midline thalamus). **(brainstorm)** A shared phase signal is cheaper than any mutual-synchronization scheme and is exactly the collateralised-bus motif of [[wiki/entities/nucleus-reuniens.md]]. |
| **Read the source of a unit's tuning off its coupling** | Phase-locking selects the cells carrying the task variable; use band-limited coupling as a routing diagnostic. |
| **Never read a lag as a path length** | The measured lead is ~30 ms where the monosynaptic delay is ~15 ms; a directed lag indexes a transfer quantum or a polysynaptic hop, not conduction. |
| **Estimate direction per epoch, never per session** | The same module pair reverses direction inside one trial; a session-level directionality index averages the two reversals to nothing. |
| **Match the measurement timescale before comparing systems** | A < 0.1 Hz correlation and a 40 Hz coherence are not the same quantity; the gamma envelope is the only offered bridge. |

---

## The metric decides the verdict — a preregistered demonstration

> Ferrante et al. (COGITATE consortium) 2025, Nature, doi:10.1038/s41586-025-08888-1 (`raw/ferrante-2025-gnwt-iit-adversarial-testing.md`). `n = 256`, fMRI + MEG + iEEG. Two theories of consciousness staked opposite connectivity predictions on the same data ([[wiki/entities/integrated-information-theory.md]], [[wiki/entities/global-neuronal-workspace.md]]); the outcome is the sharpest available case of an inter-areal connectivity claim being decided by the choice of measure.

| Measure | What it is sensitive to | Verdict on the same recordings |
|---|---|---|
| **Pairwise phase consistency** (preregistered, chosen because both theories are stated in terms of oscillatory phase) | Consistency of relative phase, unbiased by trial count | Supported **neither** theory. Content-selective synchrony between category-selective sites and V1/V2 existed but was **early, brief (<0.75 s) and confined to 2–25 Hz**, with no sustained gamma (`BF₀₁ = 1.15–4.9`); no content-selective coupling to prefrontal cortex in the predicted window (`BF₀₁ = 2.62–5.32`) |
| **Dynamic functional connectivity** (exploratory: amplitude co-modulation, evoked response regressed out) | Envelope covariation, insensitive to phase estimation noise | Found **gamma-band** coupling between prefrontal cortex and both face- and object-selective sites inside the predicted 0.3–0.5 s window, task-independently, plus brief alpha–beta coupling in MEG |

Three rules follow, and they generalise past this experiment.

| Rule | Why |
|---|---|
| **State whether your channel claim is a phase claim or an envelope claim** | They are not interchangeable and here they disagree in sign. Phase estimation from macroscopic recordings is noise-sensitive; envelope coupling is robust but says nothing about spike-timing alignment, so it cannot support a *coincidence-detection* mechanism even when it supports a *routing* one |
| **Regress out the evoked response before calling it connectivity** | Most of the observed low-frequency synchrony here was explained by the stimulus-evoked response — two areas driven by the same input look coupled. This is the "never call a correlation a channel" rule above, in the one form a builder actually meets: the third module is the *stimulus* |
| **Report the sampling asymmetry** | The strongest null in the study — no sustained posterior gamma coupling — rests on **12 iEEG electrodes in V1/V2** against **472 in prefrontal cortex**. A connectivity null is a statement about the sparser endpoint |

**(brainstorm) What survives for an architecture.** The channel that replicated across metric and modality is not a sustained one: content-specific coupling between frontal and early visual sites is *brief* and *early*. If broadcast is real, it is a **transient hand-off**, not a maintained link — which fits a bus that publishes once and lets consumers latch, and does not fit any design in which downstream modules keep reading a live wire.

---

## Open problems

- **No content decoding**, and it is what makes `G54` unresolvable from this literature: the measures cannot say whether a coupled pair is transporting a representation or only aligning windows, so the two channel types the gap asks a builder to separate are indistinguishable in the evidence. Every measure here is a correlation of *amounts*; none states what is on the wire. The wiki's standing gap (G52) is untouched — a context label, a gain signal and an episodic sample all produce coherence.
- **Locking to future phases is unexplained.** Prefrontal cells lock on average to *past* hippocampal theta phases (consistent with monosynaptic drive), but some lock to future ones, which no mechanism in the source accounts for.
- **The theta relay is inferred, never demonstrated.** Septum, ventral hippocampus, reuniens and lateral entorhinal cortex are all candidates; the experiment — inactivate each, measure the surviving coupling — has not been run.
- **Direction of the human effects is unstable.** Load-dependent connectivity goes both ways across studies, and in disease the same circuit shows reduced *positive* connectivity in some studies and increased *negative* connectivity in others, so the sign of the human measure is not a reliable constraint on a model.
- **Volume conduction is a live confound** for every field-potential-only result, which is most of the imaging-adjacent literature.

---

## Connections

- **[[wiki/concepts/attention.md]]** — the consumer of the beta/gamma direction assignment, and the reason the assignment had to be anchored on anatomy: attending enhances top-down beta and bottom-up gamma influence *together*, so an attention contrast cannot isolate the descending arm even when stimuli and difficulty are matched (Bastos et al. 2015).
- **[[wiki/concepts/counterstream-organization.md]]** — the anatomy this page's direction rule is measured *against*: SLN supplies the fixed per-pathway feedforward/feedback score that the per-frequency Granger asymmetry is correlated with, so the band assignment is read off the wiring rather than off a cognitive contrast. It also says why the two estimates come apart where they do — supragranular gamma and infragranular beta map onto compartments rather than onto directions, and every short-range pathway mixes both, which is the slack the task-dependent functional hierarchy moves inside.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the worked case: this page's band split is what its "frequency-multiplexed channel" section asserts, now with the cut-the-wire experiment that grounds it, and its theta-at-choice row is re-read as evidence for an *indirect* route rather than for the direct one.
- **[[wiki/entities/nucleus-reuniens.md]]** — the leading candidate for the theta clock and for the surviving choice-phase coupling: theta synchrony persists when the direct hippocampus→prefrontal terminals are silenced, so the coordination band must be carried by a relay, and a collateralising relay generates shared phase without either endpoint computing it.
- **[[wiki/concepts/working-memory.md]]** — supplies the band-typed version of that page's phase dissociation: gamma on the direct link at encoding, theta at the choice point on a route that survives cutting the link, so the encoding and retrieval requirements are carried by *different pathways*, not just different phases — and the consumer of this page's third rule: gamma carries the item, alpha keeps the irrelevant regions out, theta orders, and the frame/slot frequency ratio *is* the capacity number (Roux & Uhlhaas 2014).
- **[[wiki/concepts/temporal-coding.md]]** — the single-neuron mechanism under these population measures: a phase-locked cell is a coincidence detector whose input volley is already coherent, which is precisely the assumption that page lists as unexplained — and here the coherence is supplied by a named third region rather than computed locally.
- **[[wiki/concepts/representation-probing.md]]** — a probe method the wiki does not have: band-limited coupling between a unit and a candidate source module identifies *where a representation is arriving from*, without ablation or a trained classifier.
- **[[wiki/concepts/encoding-retrieval-alternation.md]]** — the mechanism this page's fourth band rule supplies: CA1's internal (CA3, slow gamma) and external (entorhinal, fast gamma) streams occupy different theta phases, which makes that page's storage/recall alternation a time-division multiplex readable off the receiver's own spectrum.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the worked edge these rules are mostly derived from, now with the mode taxonomy attached: which logical channel is open is set by behavioural state, and no coupling measure on this page can say what any of them carries. It is also the source of the two limits on directed lags: the ~30 ms lead exceeds the ~15 ms monosynaptic delay, and it reverses inside a single trial.
- **[[wiki/concepts/offline-replay.md]]** — the same measurement logic applied at rest: hippocampal sharp waves and cortical spindles co-occur within a few hundred milliseconds, which is a cross-correlation claim with the same directionality caveat, and hippocampal activity leads prefrontal activity during sleep.
- **[[wiki/concepts/cognitive-control.md]]** — a constraint on how a controller could be biased by its inputs: whether a control signal is being *delivered* or merely *timed* is decidable from the band, so "top-down bias" is two testably different operations. It also supplies this page's only *interventional* entry: electrically driving the fibre bundle into the control loop raises induced theta and improves conflict performance, which makes band power a candidate control resource rather than a read-out — a claim this page's coupling results neither support nor exclude ([[wiki/empirical-tensions.md]] T113, Widge et al. 2019).
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — supplies the one *derived* band rule on this page: taking the Fourier transform of the update equation shows expectations low-pass their own prediction errors, so a population's high/low power ratio reads off whether it holds the estimate or the residual, independently of the cut-the-wire test. The derivation half-passes its direct test: beta-feedback and gamma-feedforward are what the correlation spectrum shows, but the same spectrum puts a *second* feedforward channel at theta — slower than the feedback band, which the ordering argument forbids ([[wiki/empirical-tensions.md]] **T379**).
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the within-column version of the same measurement: superficial and deep compartments are each internally coherent and weakly coherent with one another, in gamma and beta respectively, so the laminar spectral split is the intra-areal instance of this page's inter-areal band typing.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the channel this page's coherence measures are almost always taken on, and the case where a band dissociation becomes a routing claim: silencing the direct terminals abolishes gamma at encoding and leaves choice-point theta intact, so the two phases run on different pathways rather than different bands of one.
- **[[wiki/entities/lisa.md]]** — what this page's coding assumption buys one level up: if role-filler bindings are phases, relational reasoning inherits a hard capacity bound from the number of resolvable phases, and routing a binding between the temporal store that holds the relation and the frontal integrator becomes a phase-alignment problem rather than a message-passing one. It is also this page's one live dependent: its authors' distance-sets-the-band rule makes long-range theta the semantic channel, where the cut-the-wire experiments here make theta the signature of a relay neither endpoint computes (T333). Its nesting is also the inverse of the third rule's — gamma as the frame rather than as the slot — so the two phase accounts agree on a 4–6 capacity and disagree on which clock sets it.
- **[[wiki/concepts/mean-field-reduction.md]]** — the null model this page's measures need: in a sheet of coupled neural masses with **constant** coupling and constant noise, a sensory input drives the population from spatially incoherent to synchronised entirely as an emergent effect, so a rise in coherence between two populations licenses no inference that anything about the link between them changed (Deco et al. 2008).
- **[[wiki/concepts/dynamic-repertoire.md]]** — the same null model at whole-brain scale, plus the reason a metabolic signal can measure coherence at all: cluster synchronisation waxes and wanes under fixed weights and fixed noise, and mean population activity and synchronisation are tightly coupled across nearly all of parameter space, so a BOLD-derived connectome is partly a coherence measurement wearing an activity measurement's units (Deco, Jirsa & McIntosh 2011).
- **[[wiki/concepts/metastability.md]]** — contests this page's one offered bridge across the timescale gap and explains why the dispute cannot be settled with fMRI: external recordings (EEG/MEG) recover the same resting networks from **alpha/beta** amplitude envelopes, *negatively* correlated with BOLD, against the intracranial gamma-positive result ([[wiki/empirical-tensions.md]] T242) — and the haemodynamic transform is measured to be a 0.35 Hz low-pass, so every candidate carrier is filtered out of the observable that would arbitrate between them.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — the anatomical prior this page asks for: which region pairs have a direct tract at all, how strong it is, and the fact that cross-hemisphere coherence has only ~4% of the cortical edge mass to run on.
- **[[wiki/concepts/function-to-structure-inference.md]]** — this page's warning with a measured error rate: thresholding resting BOLD correlations to declare an anatomical connection yields ≈6% precision at 80% recall, and ≈28% even when the correlations were generated by the very matrix being recovered.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — the generative counterpart of this page's caution: sweeping the ratio of long-range excitatory-to-excitatory versus excitatory-to-inhibitory projection strength moves two nodes' correlation monotonically from full antisynchronisation to full synchronisation with the structural edge between them held fixed, so a change in measured synchrony is what a change in *input composition* looks like from the outside (Schirner et al. 2023).
- **[[wiki/concepts/cortical-traveling-waves.md]]** — what a phase relation licenses when it is spatially organised: a consistent non-zero lag across a spatial gradient is a travelling wave rather than a coupling artefact, and the resting-MEG fits put the non-zero-lag component of synchrony overwhelmingly in the alpha band (phase-lag-index fit 0.46 alpha vs 0.14 gamma) (Koller et al. 2024).
- **[[wiki/concepts/parallel-timescale-streams.md]]** — a large-scale use of band-limited envelopes that inherits this page's limits and states the cost explicitly: source-leakage correction by orthogonalisation shrinks every effect because it removes real zero-lag long-range coupling, so the main analysis is run uncorrected and the corrected version is the conservative bound (Alderson et al. 2026).
- **[[wiki/concepts/ignition.md]]** — the broadcast's carrier: ignition shows as increased local gamma power plus cross-area gamma synchrony, and adding laminar-specific connectivity to the simulation *derives* the bottom-up gamma / top-down alpha-beta split rather than assuming it (Mejias et al. 2016).
- **[[wiki/entities/integrated-world-modeling-theory.md]]** — the strongest band-to-message-type assignment in the wiki, offered as hypothesis: gamma carries quantised prediction-error packets, beta specific predictions, alpha predictions integrated in an egocentric frame, theta action-conditioned predictions — plus the claim that entrainment direction flips from periphery-drives-core to core-drives-periphery at the commit, which is a dated, measurable signature.
- **[[wiki/concepts/loopy-belief-propagation.md]]** — synchrony as a *scheduler* rather than a carrier: phase alignment decides which regions participate in the current round of message passing and when that round is allowed to have converged, which is the one role for a band that this page does not otherwise license.
- **[[wiki/concepts/cortical-state-bistability.md]]** — a third band rule orthogonal to this page's two (direct-drive vs common-input; feedforward vs feedback): beta indexes **occupancy** — spike-field coherence at 25–37 Hz identifies which ensemble currently holds the content — and 1–9 Hz indexes **release**, so a band can type a computational state and not only a channel.
- **[[wiki/entities/integrated-information-theory.md]]** — the theory that stakes its one distinctive prediction on this page's mechanism: sustained gamma coupling between V1/V2 and category-selective areas throughout an experience, which the preregistered phase measure did not find, on 12 V1/V2 electrodes.
- **[[wiki/entities/global-neuronal-workspace.md]]** — the rival prediction on the same data: brief late long-range coupling to prefrontal cortex, found on the amplitude metric and absent on the phase metric, so the framework's broadcast channel is currently evidenced as envelope covariation rather than as synchrony.
- **[[wiki/concepts/connectivity-scaling-bottleneck.md]]** — the physical channel this page's cross-hemisphere claims must run on, and how scarce it is: corpus callosum cross-section per unit cortical surface falls 2.3-fold from galago to human, so interhemispheric coherence is measured in the species with the least callosal bandwidth per cortex (Ardesch et al. 2022).
- **[[wiki/concepts/network-communication-models.md]]** — the two halves of one unsolved problem, named as such by Seguin et al. 2023: graph-theoretic communication models say which polysynaptic path a signal takes through the whole connectome but nothing about what gates a given link, while coherence-based accounts say what gates a link but only for small motifs of directly connected elements — bridging them is the review's stated crucial open direction.
- **[[wiki/concepts/timescale-hierarchy.md]]** — the defect this page's mechanism is offered as the fix for: in a rate-based large-scale cortical model, activity attenuates substantially as it climbs the hierarchy, and synchronous firing (or stronger feedback) is the named candidate for propagating signals without amplitude loss (Chaudhuri et al. 2015).
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — a band used as an *address* rather than as a measurement: prefrontal beta selects when a held item may be expressed and posterior alpha selects which region may not process, the second scaling with distractor count and improving capacity when driven exogenously at 10 Hz — so a rhythm here is an actuator, which is the one reading this page's correlation-based rules cannot supply on their own.
- **[[wiki/concepts/schema-assimilation.md]]** — a case where the preparatory setting is *de*synchronization: before a schema-relevant stimulus, healthy controls show **decreased** vmPFC↔inferior/lateral temporal low-frequency (theta) coherence and vmPFC-lesion patients do not, with the decrease read as letting posterior stores express fine-grained codes — so the same measurement supports an opposite functional sign depending on whether a channel is being opened or a representation is being freed (Gilboa & Marlatte 2017).
