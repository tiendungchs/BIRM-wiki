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

**The timescale gap is not a detail.** Every cross-species claim in this literature — and every wiki claim that leans on human connectivity to support a rodent circuit — spans that gap. The offered bridge: the BOLD signal tracks local **gamma power**, whose envelope fluctuates slowly, so cross-regional gamma-envelope correlation is the electrophysiological quantity that human functional connectivity is closest to (Schölvinck et al. 2010, in Sigurdsson & Duvarci 2016). Nothing validates the bridge at the level of a specific claim.

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

---

**A second, orthogonal band rule: the band also types the *direction* of a hierarchical message.** Feedforward inter-areal influence is carried at higher frequencies than feedback (Bosman et al. 2012), and within a column the superficial layers are gamma-dominated while the deep layers are alpha/beta-dominated (Roopun et al. 2006; Maier et al. 2010; Buffalo et al. 2011), with strong coherence *within* each compartment and weak coherence *across* them. Predictive coding derives this rather than fitting it: expectations accumulate prediction errors, integration is a low-pass filter, and the nonlinear prediction map re-creates high frequencies on the way down, so **error must run faster than the estimate that absorbs it** (Bastos et al. 2012, [[wiki/concepts/predictive-coding-free-energy.md]]). The two rules compose: the band identifies *whether* the correlation is carried by the direct axons (gamma vs. theta, above) and, among those that are, *which way up the hierarchy* the message runs.

**(brainstorm)** This makes a spectral statistic a **weight-free probe of computational role**: in any recurrent model with two interacting populations, the one whose power spectrum is shifted low is the integrator and the one shifted high is the residual — measurable from activity alone, with no access to parameters and no laminar labels.

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
| **Match the measurement timescale before comparing systems** | A < 0.1 Hz correlation and a 40 Hz coherence are not the same quantity; the gamma envelope is the only offered bridge. |

---

## Open problems

- **No content decoding.** Every measure here is a correlation of *amounts*; none states what is on the wire. The wiki's standing gap (G52) is untouched — a context label, a gain signal and an episodic sample all produce coherence.
- **Locking to future phases is unexplained.** Prefrontal cells lock on average to *past* hippocampal theta phases (consistent with monosynaptic drive), but some lock to future ones, which no mechanism in the source accounts for.
- **The theta relay is inferred, never demonstrated.** Septum, ventral hippocampus, reuniens and lateral entorhinal cortex are all candidates; the experiment — inactivate each, measure the surviving coupling — has not been run.
- **Direction of the human effects is unstable.** Load-dependent connectivity goes both ways across studies, and in disease the same circuit shows reduced *positive* connectivity in some studies and increased *negative* connectivity in others, so the sign of the human measure is not a reliable constraint on a model.
- **Volume conduction is a live confound** for every field-potential-only result, which is most of the imaging-adjacent literature.

---

## Connections

- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the worked case: this page's band split is what its "frequency-multiplexed channel" section asserts, now with the cut-the-wire experiment that grounds it, and its theta-at-choice row is re-read as evidence for an *indirect* route rather than for the direct one.
- **[[wiki/entities/nucleus-reuniens.md]]** — the leading candidate for the theta clock and for the surviving choice-phase coupling: theta synchrony persists when the direct hippocampus→prefrontal terminals are silenced, so the coordination band must be carried by a relay, and a collateralising relay generates shared phase without either endpoint computing it.
- **[[wiki/concepts/working-memory.md]]** — supplies the band-typed version of that page's phase dissociation: gamma on the direct link at encoding, theta at the choice point on a route that survives cutting the link, so the encoding and retrieval requirements are carried by *different pathways*, not just different phases.
- **[[wiki/concepts/temporal-coding.md]]** — the single-neuron mechanism under these population measures: a phase-locked cell is a coincidence detector whose input volley is already coherent, which is precisely the assumption that page lists as unexplained — and here the coherence is supplied by a named third region rather than computed locally.
- **[[wiki/concepts/representation-probing.md]]** — a probe method the wiki does not have: band-limited coupling between a unit and a candidate source module identifies *where a representation is arriving from*, without ablation or a trained classifier.
- **[[wiki/concepts/offline-replay.md]]** — the same measurement logic applied at rest: hippocampal sharp waves and cortical spindles co-occur within a few hundred milliseconds, which is a cross-correlation claim with the same directionality caveat, and hippocampal activity leads prefrontal activity during sleep.
- **[[wiki/concepts/cognitive-control.md]]** — a constraint on how a controller could be biased by its inputs: whether a control signal is being *delivered* or merely *timed* is decidable from the band, so "top-down bias" is two testably different operations. It also supplies this page's only *interventional* entry: electrically driving the fibre bundle into the control loop raises induced theta and improves conflict performance, which makes band power a candidate control resource rather than a read-out — a claim this page's coupling results neither support nor exclude ([[wiki/empirical-tensions.md]] T113, Widge et al. 2019).
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — supplies the one *derived* band rule on this page: taking the Fourier transform of the update equation shows expectations low-pass their own prediction errors, so a population's high/low power ratio reads off whether it holds the estimate or the residual, independently of the cut-the-wire test.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the within-column version of the same measurement: superficial and deep compartments are each internally coherent and weakly coherent with one another, in gamma and beta respectively, so the laminar spectral split is the intra-areal instance of this page's inter-areal band typing.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the channel this page's coherence measures are almost always taken on, and the case where a band dissociation becomes a routing claim: silencing the direct terminals abolishes gamma at encoding and leaves choice-point theta intact, so the two phases run on different pathways rather than different bands of one.
- **[[wiki/entities/lisa.md]]** — what this page's coding assumption buys one level up: if role-filler bindings are phases, relational reasoning inherits a hard capacity bound from the number of resolvable phases, and routing a binding between the temporal store that holds the relation and the frontal integrator becomes a phase-alignment problem rather than a message-passing one.
