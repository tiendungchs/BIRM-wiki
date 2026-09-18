# Dendritic Integration Theory — the Broadcast Is Gated Inside the Cell, by a Third Party

**One switch, one cell, three compartments. A layer-5 pyramid's apical compartment (internal variables: context, expectation, semantic and episodic knowledge, attention, task set) and its basal compartment (feature-specific feedforward drive) are joined by a *coupling compartment* in layer 5a whose conductance is set by neither stream. Coupled, a match between the streams produces a burst and the activation can propagate into cortico-thalamo-cortical loops; decoupled, the same apical input does not reach the soma at all and a local perturbation stays local. General anaesthesia is decoupling. The controller is the higher-order thalamus, acting through metabotropic glutamate receptors.**

> **Provenance.** `raw/aru-2020-cellular-mechanisms-of-conscious-processing.md` — Aru, Suzuki & Larkum, *Trends Cogn. Sci.* 24(10):814–825, 2020. An **opinion article**, not a report: it names the theory and assembles it around one core experiment by two of its three authors (Suzuki & Larkum 2020, *Cell* 180:666–676) plus corroborating recordings. Read the coupling result as the evidence and everything above "From a Local Switch to a Global Reverberation" as a proposal. The cellular mechanism it gates is [[wiki/concepts/apical-amplification.md]] (Larkum 2013, same last author); this page carries the *control* layer that page's coupling compartment `C` had no controller for.

---

## The architecture

| Component | Receives | Role |
|---|---|---|
| **Apical compartment** (tuft, layer 1) | Cortico-cortical and thalamocortical feedback: context, expectation, semantic and episodic knowledge about the feature, attention, working memory, task set | The internal / higher-order stream |
| **Coupling compartment** (~layer 5a) | Higher-order thalamic axons; metabotropic glutamate receptors | **The switch.** Sets whether apical activity reaches the soma at all. Not a data path — a permission |
| **Basal compartment** (perisomatic; the axon exits here) | Feedforward drive from areas lower in the hierarchy (also some long-range feedback) | The external / first-order stream; controls spike output |
| **Output** | — | A **burst** = "the feature this column codes is confirmed by both streams". L5p is the cortex's only export cell, so the match is directly what leaves the area |

Two variables, cleanly separated, which is the whole architectural content:

| Variable | Carried by | Controlled by | Ranges over |
|---|---|---|---|
| **What** is represented | Which L5p cells are active, and which project to higher-order thalamus | The two data streams | Contents |
| **Whether** anything can propagate | Coupling at the coupling compartment | Higher-order thalamus, via metabotropic receptors — *neither* data stream | State |

This is the wiki's cleanest instance of a gate whose controller is a third party. [[wiki/concepts/precision-weighting.md]] derives its gain from the streams it modulates; [[wiki/concepts/ignition.md]] derives take-off from the evidence being admitted; here the permission is issued by a structure that does not carry the content.

---

## The evidence, and its grade

| Result | What it shows | Grade |
|---|---|---|
| Optogenetic stimulation of the apical compartment of L5p cells drives high-frequency somatic firing **awake**; under anaesthesia the identical stimulation **does not reach the soma**. Replicated across anaesthetics with different molecular targets and across frontal, somatosensory and primary visual cortex (Suzuki & Larkum 2020) | Decoupling is a general property of unconscious states, not a drug idiosyncrasy or an area idiosyncrasy | Causal, mouse — **the theory's single load-bearing experiment** |
| Blocking **metabotropic** receptors in *awake* animals reproduces the decoupling | The switch has a named receptor class and can be thrown without anaesthesia | Causal |
| Inactivating **higher-order thalamus** breaks the coupling | The switch has a named controller, external to the cell | Causal |
| Apical and basal activity are strongly correlated during waking, and the correlation is **unaffected by locomotion or by visual stimulation** (Beaulieu-Laroche et al. 2019; Francioni et al. 2019) | Coupling tracks *state* (conscious vs not) and not manipulations *within* a state — the dissociation the two-variable table above needs | Correlative, but the null is the informative half |
| Stimulating higher-order/central thalamus wakes mice (Ren et al. 2018) and monkeys from anaesthesia (Redinbaugh et al. 2020; Bastos et al. 2020) and improves behaviour in a human disorder-of-consciousness patient (Schiff et al. 2007); in monkeys recovery came with increased deep-layer firing and increased cortico-cortical and thalamocortical efficacy | The controller is causal in the reverse direction too, across three species | Causal, mixed quality (the human result is `n = 1`) |
| Threshold whisker-detection task: L5p spiking **and** apical Ca²⁺ events track the animal's report; pharmacological or optogenetic modulation of the apical compartment changes detection behaviour; a chemogenetic block isolates the **L5p → higher-order thalamus** branch as the output that matters (Takahashi et al. 2016, 2020) | Dendritic integration is causal for *contents*, not only for state, and the critical axon is the one back to the controller | Causal on content |

**The loop closes on itself.** Higher-order thalamus controls coupling within L5p cells; L5p cells drive higher-order thalamus through the branch Takahashi's block isolates; excitatory recurrent loops are formed between L5p cells of a column and the corresponding higher-order thalamic neurons. DIT reads that loop as the maintenance mechanism for [[wiki/concepts/working-memory.md]] — contents held for as long as needed — and as the reason state and contents are not independent: contents are the subset of L5p cells coding a feature *and* projecting to higher-order thalamus, but they contribute only while coupled, which that same thalamus decides.

---

## The cell-to-network bridge (Table 1 of the source)

The theory's actual work is claiming that five macroscale observations are downstream of one cellular variable:

| Global observation | DIT's account |
|---|---|
| Consciousness correlates with sustained, complex, integrated dynamics | Coupling is what lets activity be coordinated across thalamocortical loops at all |
| Transcranial magnetic stimulation spreads widely when conscious, stays focal when not (Massimini et al. 2005; perturbational complexity index) | A local perturbation can only grow and propagate through cells that are coupled |
| Conscious perception diverges from unconscious at 200–300 ms, with ignition | Unconscious stimuli drive **basal only**; recruiting the apical compartment and getting it maintained in the thalamocortical loop takes time and requires coupling |
| Prefrontal/parietal "hub" regions are activated in conscious tasks | L5p cells in areas more densely connected to higher-order thalamus and to other cortex are more easily coupled and recruited — a **density** claim, not a locus claim |
| Slow oscillations under anaesthesia; alpha–beta rhythms awake | Decoupled basal compartments participate in slow-oscillation generation; coupled cells' intrinsic properties drive higher frequencies |

**The perturbational row is the one that transfers unchanged.** "Does a local perturbation propagate?" is measurable in any network, needs no report and no consciousness vocabulary, and here it is given a per-unit mechanism rather than a connectivity one.

---

## Against the wiki's other consciousness frameworks

| | Where the decisive variable lives | What a commit is | Relation to DIT |
|---|---|---|---|
| **DIT** (this page) | Inside one cell, at one compartment | A burst, when both streams agree and the cell is coupled | — |
| **[[wiki/entities/global-neuronal-workspace.md]]** / [[wiki/concepts/ignition.md]] | A distributed long-axon population; a network threshold | Network-wide reverberation at 200–300 ms | **Enabling, not competing.** Attentional amplification and global broadcast are "impotent if the pyramidal cells are decoupled" — DIT supplies the precondition and inherits the gap that neither has a learning rule (`G91`) |
| **[[wiki/entities/integrated-information-theory.md]]** | The maximally irreducible cause–effect structure | No commit event | Shutting the coupling compartment collapses the cause–effect repertoire, so DIT is offered as the *cellular knob* on Φ |
| **Higher-order theories** | A second-order representation, usually located in prefrontal cortex | — | **Reframed.** The higher-order representation is a **data stream targeting apical compartments**, not an area. It may partly originate in prefrontal cortex, but its relevance is at the L5p cells that receive it |
| **[[wiki/concepts/predictive-coding-free-energy.md]]** | Error units, layer-wise | — | Compatible *only with a sign flip*: the L5p cell intrinsically computes the **match** and amplifies it; turning that into suppression requires an added inhibitory connection. The source concedes flexibility but insists the match is the constraint neurobiology imposes (`T374`) |
| **Adaptive resonance theory** (Grossberg 1976, 2013) | Resonance between a bottom-up code and a top-down expectation | Resonance onset | The closest precedent: DIT is resonance with a named compartment and a named off switch |

The higher-order row is the one the wiki needed. `T269` ("does prefrontal cortex constitute conscious content or only route it?") offers two options that both presuppose the relevant object is an *area*; DIT supplies a third in which the higher-order role is a **projection type** — so prefrontal cortex could be a major source of the apical stream while none of the content is constituted there, which is neither position as stated.

---

## What it buys an architecture

- **A binary mode switch on the top-down port, set by neither stream.** Every model here mixes top-down and bottom-up continuously. DIT makes the *admission of the top-down stream* a separate variable with its own controller. In a machine: give each module two input ports and a scalar `c` that zeroes the top-down port; `c` is written by a shared controller module, not by the data.
- **An ablation instrument that comes free with it.** Run the same task with `c = 0` and see which behaviours survive. Biology's answer is: feedforward processing, local responses, slow-wave dynamics and a great deal of unconscious discrimination survive; propagation, contextual modulation and report do not. **(brainstorm)** This is a cleaner interpretability probe than most in [[wiki/concepts/representation-probing.md]] because it removes a *pathway* rather than a representation, and the two are confounded in every probe that ablates units.
- **The failure mode is specified, in both directions.** Decoupled → inattentional blindness: the basketball-pass counter does not see the gorilla because the feature has basal activation and no apical match. Apical-dominant → dreaming and hallucination, where the top-down stream generates the content with no drive to match. One variable, two clinical signs, which is the shape a control parameter should have ([[wiki/concepts/neuromodulatory-metaparameters.md]]).
- **A per-column "confirmed" signal with no read-out stage**, inherited wholesale from [[wiki/concepts/apical-amplification.md]]: the burst *is* the report that the column's feature matched, and bursting cells dominate their targets by firing hardest.
- **(brainstorm) Two channels on one wire, at no cost.** L5p output is single-spike or burst. If the burst means "confirmed by context" and the single spike means "driven but unconfirmed", the ascending wire carries content and confidence in one train, decodable by a downstream integrator with a short time constant. No artificial unit has a second output channel, and adding one is cheaper than adding a confidence head because it needs no extra parameters — only a nonlinearity that separates the two regimes ([[wiki/concepts/confidence-calibration.md]], [[wiki/concepts/spike-encoding-schemes.md]]).

---

## Limitations

| Limit | Consequence |
|---|---|
| Opinion article; one load-bearing experiment | Everything in the Table-1 bridge is a proposed explanation, not a tested one. The theory is currently *one decoupling result plus a reading of it* |
| Anaesthesia only | The source's own first outstanding question is whether decoupling occurs in deep sleep, coma or traumatic brain injury — and whether cells are coupled in REM sleep, where there *is* experience. Untested; a negative in REM would remove the state claim |
| Coupling measured as a global state | Whether coupling is homogeneous across cortex or locally controllable is unanswered and is the difference between a mode switch and an attention mechanism (`T376`) |
| The controller has one named structure and one named receptor class | Whether cortical long-range projections can also target the coupling compartment is open; if they can, the gate is addressable by cortex and the thalamic story is one route among several ([[wiki/concepts/transthalamic-context-routing.md]]) |
| No learning rule | Same hole as [[wiki/concepts/apical-amplification.md]]: nothing says what the apical synapses should come to predict, nor how the coupling threshold is set or trained. Both halves of the mechanism are read operations |
| No non-invasive measure of coupling | Named as an outstanding question. So the theory currently cannot be tested in humans at all, and the human evidence (thalamic stimulation, `n = 1`) is causal at the wrong grain |
| The target concept is not operationalisable for a machine | "Conscious" adds nothing a builder can check. What imports is the gate, the controller and the propagation test — the label is separable and should be dropped on import |

---

## Connections

- **[[wiki/concepts/apical-amplification.md]]** — the mechanism this page controls: that page's three-compartment reduction has a coupling compartment `C` with no controller, and this supplies one — higher-order thalamus acting on metabotropic receptors in layer 5a, so whether coincidence produces a burst at all is a variable set outside the cell and outside both data streams.
- **[[wiki/concepts/ignition.md]]** — the same commit two scales up, and its precondition: global broadcast and attentional amplification are "impotent if the pyramidal cells are decoupled", so ignition's network threshold is conditional on a cellular one that no formulation of it includes; the two also make opposite bets about where the all-or-none character comes from (a population cascade versus a per-cell Ca²⁺ regenerative event).
- **[[wiki/entities/global-neuronal-workspace.md]]** — compatible by construction and pointed at the framework's weakest joint: the workspace needs a reason its long-axon population can propagate at all, and this gives one that predicts the anaesthesia and transcranial-magnetic-stimulation results without invoking the bus — which also means a hub's privilege becomes a claim about *density of couplable cells*, not about locus.
- **[[wiki/entities/integrated-information-theory.md]]** — the cellular knob on that page's quantity: closing the coupling compartment collapses the cause–effect repertoire of the whole thalamocortical complex from inside the units rather than by cutting edges, which is a mechanism for Φ collapse that a connectivity-level account cannot express.
- **[[wiki/concepts/transthalamic-context-routing.md]]** — the same organ, a third cargo: that page measures higher-order thalamus delivering the *sender's state* to a downstream area's layer 2/3, and this has it delivering a *permission to integrate* to layer 5a of the cell it targets — so "higher-order thalamus carries state" and "higher-order thalamus gates coupling" may be one signal read at two compartments, which somatic imaging cannot separate.
- **[[wiki/concepts/constitutive-vs-enabling.md]]** — a textbook enabling condition with a mechanism: decoupling abolishes report without being *about* anything, so any correlate that vanishes under anaesthesia is at risk of indexing the gate rather than the content — and the theory's own claim to be constitutive rests entirely on the Takahashi content manipulations, not on the anaesthesia result.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — restates `T374` from the cell's side: the L5p cell intrinsically amplifies the match, so a predictive-coding reading of the same anatomy must buy the sign flip with an added inhibitory circuit, and the source treats that cost as a constraint neurobiology places on the framework rather than a free parameter.
- **[[wiki/concepts/attention.md]]** — the theory's own strongest untested prediction: if coupling can be controlled locally rather than globally, then selective attention *is* per-column control of the coupling compartment, which would make attention and the state of consciousness one mechanism at two spatial scales (`T376`).
- **[[wiki/concepts/working-memory.md]]** — a maintenance substrate that is neither persistent cortical activity nor a synaptic trace: an excitatory recurrent loop between a column's L5p cells and the matching higher-order thalamic neurons, where the same structure that holds the content also licenses its integration.
- **[[wiki/concepts/cortical-state-bistability.md]]** — the same hold/release logic measured at the population rather than derived from the cell: a content-free beta regime that holds and a low-frequency regime that releases, against this page's content-free coupling variable that permits and blocks — and this page's last Table-1 row predicts exactly that pairing, decoupled cells generating slow oscillations and coupled cells driving higher frequencies.
- **[[wiki/concepts/perturbation-elicitability.md]]** — supplies a per-unit reason the perturbational complexity index works: a focal perturbation grows only through coupled cells, so "how far does a poke spread" measures the gate rather than the connectivity, and the same instrument reads differently under the two interpretations.
- **[[wiki/concepts/dendritic-computation.md]]** — the compartment bank given a global on/off: that page's segments compute regardless of state, and this makes the route from the distal bank to the axon a separately controlled variable, so a cell can hold its detections and be unable to report any of them.
- **[[wiki/entities/mediodorsal-thalamus.md]]** — the neighbouring topology with the opposite job: mediodorsal thalamus returns a task-context signal to the prefrontal population it pooled from, while the higher-order thalamus here returns a content-free permission to the cortical cells that drive it — same loop shape, one carrying *what* and one carrying *whether*.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the second, faster controller on the same switch: dendrite-targeting inhibition vetoes association on tens of milliseconds and ~0.5 s, where this page's metabotropic control sets a state, so the coupling compartment plausibly has a slow permissive gain and a fast selective veto — two controllers nobody has measured together.
