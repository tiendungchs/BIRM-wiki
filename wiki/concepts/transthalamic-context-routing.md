# Transthalamic Context Routing

**Every direct cortico-cortical edge `A → B` is mirrored by a disynaptic one `A → higher-order thalamus → B`, and the two do not carry the same thing: the direct edge carries the *content*, the transthalamic edge carries the sender's *state* — an addressed, glutamatergic, area-specific copy of a variable that elsewhere in the brain is broadcast diffusely by chemistry.**

> **Provenance.** Neske & Cardin 2025, *Higher-order thalamic input to cortex selectively conveys state information*, Cell Reports 44(2):115292 (`raw/neske-2025-higher-order-thalamic-state-input.md`). Awake head-fixed mice on a wheel; two-photon calcium imaging of layer 2/3 cell bodies in the higher-order visual area PM (posterior medial) plus simultaneous imaging of V1→PM, LM→PM and LP→PM axon terminals in the same field of view (soma-targeted riboGCaMP6m in cell bodies, GCaMP6s in terminals, one imaging channel); pathway-specific terminal silencing with the inhibitory opsin eOPN3; Cre-dependent caspase ablation of projection neurons as an independent causal test. LP = lateral posterior nucleus, the mouse analogue of the primate pulvinar.

Why this earns a page. [[wiki/concepts/canonical-cortical-microcircuit.md]] carries transthalamic routing as an *unresolved alternative* to the direct edges — a second wire whose cargo nobody had measured. Here the cargo is measured on both edges at once, in the same animals, with the same indicator, and it is **not the same cargo**. That converts a routing curiosity into an architectural primitive: a per-edge context channel.

---

## The two streams, measured side by side

| | **Direct cortico-cortical** (V1→PM, LM→PM) | **Transthalamic** (LP→PM) |
|---|---|---|
| Share of feedforward input to PM | V1+LM = **72–90%** (mean 82%) of cortico-cortical projection neurons | The only thalamic source; dLGN (first-order) sends nothing to PM |
| Visual response magnitude | V1→PM strongest of all afferents, comparable to PM cell bodies themselves | Significantly weaker across orientation, spatial/temporal frequency, size and motion-coherence stimulus sets |
| Calcium event rate | Lower | **Higher** than either cortico-cortical pathway *and* than PM somata |
| Time-locking to PM somatic events | Strong | **Weak** — comparable to LP→V1, a canonically modulatory pathway |
| Silencing terminals (eOPN3) → PM visual responses | **Robustly decreased** | Only slightly affected |
| Ablating the projection neurons → PM visual responses | Reduced (V1→PM) | Not reduced (LP→PM) |
| Silencing terminals → PM modulation by **pupil diameter** | No effect | **Significantly reduced** |
| Silencing terminals → PM modulation by **locomotion** | — | **No effect** |
| State modulation of the axons themselves | V1→PM the **weakest** of all populations | Strongest of the three afferents |

Two dissociations in one preparation: content survives removing the thalamic edge, state survives removing the cortical edges. Neither is a generic excitability loss, which is the standard confound of a silencing experiment — the two manipulations damage *different* response properties in the same cells.

**The driver/modulator test, in a form a model can copy.** LP axons fire *more* than the cortical ones and matter *less*. Firing rate and causal influence come apart, and the quantity that tracks influence is **temporal alignment to the target's own events**, not amount of activity. Anything that infers connectivity from co-activity magnitude ([[wiki/concepts/effective-connectivity.md]], [[wiki/concepts/function-to-structure-inference.md]]) would have ranked LP→PM as the dominant input.

---

## Where the state signal comes from — the sender splits its own output

V1 projects to both PM and LP, but through **different cell populations**, and the paper compares them:

| V1 projection class | Soma location | Modulation by pupil-linked arousal during quiescence |
|---|---|---|
| Cortico-cortical (V1→PM) | — | Weaker |
| Cortico-thalamic (V1→LP) | Layer 5 and lower layer 6 | **Stronger** |

So the state signal in LP is largely *inherited*: an area's layer-5/6 output neurons are more state-modulated than its layer-2/3-targeting output neurons, and the thalamus relays that difference onward. Candidate amplifiers the source names but does not test: superior colliculus (which itself controls pupil dilation), neuromodulatory and GABAergic inputs specific to higher-order thalamus, and deepest-layer-6 cortico-thalamic cells that are orexin-sensitive, orexin being tightly coupled to pupil-linked arousal.

**(brainstorm) The architectural object is a typed fan-out at the sender, not a filter at the receiver.** One area emits two streams from two cell classes — a fast, tuned, time-locked content stream and a slow, untuned, high-rate state stream — and only the second is routed through a relay that can re-address it to a *different* area than the first. In a model this is cheap: give each module two output heads, route head 2 through a shared low-dimensional bus with its own destination table, and constrain head 2 to be a slow, non-time-locked signal (the biology enforces this with synaptic dynamics; a model can enforce it with a low-pass filter or a bottleneck). What it buys is a context channel that scales as *edges* rather than as a global scalar — see the contrast table below.

---

## "Behavioural state" is not one variable

The sharpest number on this page is a null. Silencing LP→PM terminals cuts PM's modulation by **pupil diameter** and leaves its modulation by **locomotion** intact.

| Consequence | For what |
|---|---|
| Arousal and motor state reach the same cortical cells by **different routes** | Any model with a single "state" or "context" input vector is mis-specified — removing that vector would remove both, which is not what happens |
| The routes are separable *at the target*, not just at the source | So the receiver holds two independently addressable modulatory registers, not one summed one |
| PM's own state modulation exceeds V1's, and exceeds that of any single afferent | State representation is **built** at the higher area by integration, not passed through — the same conclusion the size-tuning data force for content (PM lacks surround suppression that *all three* of its inputs have) |

That last row is a general caution for [[wiki/concepts/representation-probing.md]]: a property present in a target and absent in every measured input is evidence of local construction, and it appeared here for both a sensory feature and a state feature.

---

## Contrast with the wiki's other context channels

| Channel | Source of the context variable | Address | Cargo |
|---|---|---|---|
| **Diffuse neuromodulation** ([[wiki/concepts/neuromodulatory-metaparameters.md]]) | Small brainstem nucleus, from global statistics | None — broadcast to everything | One scalar per chemical |
| **[[wiki/entities/mediodorsal-thalamus.md]]** (Rikhye et al. 2018) | Pooled **from the prefrontal population it will gate** — a closed loop | Back to the same area, two signed channels | Cueing context, task-defined |
| **Transthalamic (this page)** | Pooled from the **upstream sender's** deep layers — a feedforward copy | To a specific downstream area, and target-dependent | Global arousal, sender-derived |
| **[[wiki/entities/nucleus-reuniens.md]]** | Hippocampal–prefrontal content, collateralised | Two structures at once | Content (goal-conditioned path), not context |

Reading the first three together: the thalamus is not one thing doing one job. It is a **re-addressing layer for non-content variables**, and which variable it carries depends on which cortical population feeds it and which it feeds. MD closes a loop and returns the context to its own source; LP opens one and hands the sender's state to a *different* receiver. The wiki has no architecture with either.

**(brainstorm) The strongest single import.** The source's own closing observation is that higher-order thalamocortical axons "convey state-modulated signals reminiscent of canonical neuromodulatory pathways" — but they are glutamatergic, fast, and *anatomically addressed*. That is an arousal signal delivered with a destination field. Every metaparameter in [[wiki/concepts/neuromodulatory-metaparameters.md]] is global because its carrier is chemistry; this route shows biology also builds a **per-edge** version of the same broadcast, which means a model need not choose between one global temperature and `N` independent ones. The middle option — a small set of state variables with a learned routing table over module pairs — has a substrate. That middle option is opened as [[wiki/architectural-gaps.md]] `G93`.

---

## What it does not license

The paper is unusually explicit that its result should not be generalised to "higher-order thalamus":

- **Target-dependence.** LP→postrhinal cortex (a lateral higher visual area) is reported elsewhere to carry robust, precise visual information; LP→AL axons are optic-flow sensitive and locomotion-suppressed while LP→PM axons are variably modulated by both. The same nucleus is a content relay for one target and a state channel for another. Any claim of the form "higher-order thalamus does X" is under-specified without naming the postsynaptic area.
- **Layer-dependence.** Only layer 2/3 was imaged. Thalamocortical axons also terminate in layer 1 on apical tufts ([[wiki/concepts/dendritic-computation.md]]) and in layer 5; those inputs could carry something else. Light penetration means the optogenetic effect is likely dominated by superficial terminals.
- **Content vs. transmission.** LP axons *do* have visual responses; they simply do not shape PM's. The paper offers two readings and does not settle them — the visual information is redundant, or the synaptic/temporal dynamics of the LP→PM connection low-pass the signal, passing slow state fluctuations and rejecting fast visual ones. The second reading would make the content/state split a **filter property of the edge**, which is a much stronger and more portable claim than a labelled-line one; the discriminating experiment (fast vs slow modulated identical carriers on the same axons) is unrun.

---

## Limitations

| Limit | Consequence |
|---|---|
| Calcium imaging, deconvolved to "events" | Functional connectivity, not synaptic; event rates are not spike rates and the indicator's kinetics bound every time-locking claim — which is the measurement the driver/modulator verdict rests on |
| eOPN3 is a presynaptic-release suppressor with a ~5–6 min half-life | Requires a two-session (dark, then LED, 2 h apart) design rather than interleaved controls; suppression is partial by construction, so "only slightly affected" is a floor on the residual LP contribution, not a zero |
| V1 deep-layer activity read from layer-1 apical dendrites | A proxy for somatic spiking (back-propagating action potentials), with possible contamination by synaptically driven dendritic events |
| No task | State is measured as pupil, facial motion and locomotion in a freely-behaving-but-unengaged animal. Nothing here shows the channel carrying a *task* context, which is what a reasoning architecture would need |
| Visual responses were not split by behavioural state | So the headline question a modulatory channel raises — does the state signal set the **gain** on the content stream? — is explicitly left to future work. The wiki gets a context wire whose downstream multiplicative effect is undemonstrated |
| Mouse visual system; >10 higher visual areas, LP itself retinotopically subdivided | One `(sender, relay, receiver)` triple, generalised at the reader's risk |

---

## Connections

- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — resolves half of that page's open transthalamic question with a measurement rather than an anatomy: the disynaptic mirror of a feedforward cortico-cortical edge does not carry a re-typed copy of the content, it carries the sender's arousal state, so a model that treats inter-areal edges as direct is not merely missing a route but missing a *different variable* ([[wiki/empirical-tensions.md]] T276).
- **[[wiki/entities/mediodorsal-thalamus.md]]** — the same organ with the loop topology reversed: there the context is pooled from the population it gates and returned to it as two signed channels; here it is pooled from the sender's deep layers and delivered to a *different* area, so thalamus is better read as a re-addressing layer for non-content variables than as a nucleus with a fixed job.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the addressed version of that page's broadcast argument: arousal reaches cortex here through a glutamatergic, area-specific, target-dependent wire, which shows the metaparameter/neuromodulator topology argument ("a quantity that must reach everything and address nothing") is a design choice biology does not always make, and opens the middle option of a routing table over module pairs.
- **[[wiki/concepts/effective-connectivity.md]]** — a clean counterexample to activity-magnitude inference: the afferent with the *highest* event rate has the *lowest* causal influence on visual responses, and the statistic that tracks influence is time-locking to the target's own events, validated against terminal silencing and projection-neuron ablation.
- **[[wiki/concepts/precision-weighting.md]]** — supplies a candidate carrier for the gain term and simultaneously shows what is missing: a dedicated anatomical channel whose removal deletes arousal-dependent modulation without touching the content responses is exactly the separated precision wire the theory wants, but the experiment never tested whether the channel multiplies the sensory response.
- **[[wiki/concepts/attention.md]]** — separates attentional *state* from attentional *selection* at the level of wiring: the pathway that sets the higher visual area's arousal-linked modulation is not the pathway that supplies the stimulus it would select over, and cutting one leaves the other intact.
- **[[wiki/concepts/contextual-inference.md]]** — a context signal obtained with no inference at all and no uncertainty: a slow scalar relayed from an upstream area's deep layers, which is the cheapest possible implementation of that page's latent and the one with no capacity to allocate, revise or doubt a context.
- **[[wiki/concepts/latent-graph-discovery.md]]** — argues the inferred graph needs **typed edges with distinct cargo**: the same node pair is connected twice, directly and through a relay, and the two edges carry different variables at different timescales, so a single adjacency entry between two modules is a lossy summary of what biology wires.
- **[[wiki/concepts/dynamic-network-connectivity.md]]** — a second substrate for state-dependent coupling changes alongside the neuromodulatory one: an anatomically addressed thalamic input that could reconfigure which cortical areas interact without any diffuse chemical signal, and whose contribution is separable from locomotion-linked modulation.
- **[[wiki/concepts/integration-segregation-balance.md]]** — pupil diameter appears in both pages as the arousal index, and this one names a route for it that the noradrenergic-gain account does not include: pupil-linked modulation of a cortical area that survives removing its cortical inputs and dies when a single thalamic projection is silenced.
- **[[wiki/concepts/representation-probing.md]]** — a construction test in two registers: PM lacks the surround suppression that *all three* of its measured afferents have, and PM's state modulation exceeds that of any single afferent, so a property present in a target and absent in every input is evidence of local integration rather than inheritance.
- **[[wiki/concepts/parallel-timescale-streams.md]]** — a timescale split enforced by the route rather than by the unit: the direct edge passes fast, time-locked, tuned signals and the transthalamic edge passes slow, untuned, high-rate ones, with the low-pass reading of that split ("the edge filters") the more portable of the two hypotheses the source leaves open.
- **[[wiki/concepts/broadcast-hierarchy.md]]** — a hierarchy fact that the laminar-origin rules do not predict: an area's position determines what its *cortico-cortical* output means, but its layer-5/6 cortico-thalamic output carries a different variable to a different destination, so hierarchical depth types the content stream and says nothing about the state stream.
- **[[wiki/concepts/dendritic-computation.md]]** — the compartment this page's measurement cannot resolve: higher-order thalamic axons terminate on layer-1 apical tufts as well as in layer 2/3, so the state signal may be integrated in the separately gated distal compartment rather than alongside the drive, and somatic imaging cannot tell the two apart.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the worked counterexample this page supplies to that inference: the afferent with the highest event rate is the causally irrelevant one, so structure read off co-activation inverts the driving and modulatory edges; only pathway-specific silencing plus projection-neuron ablation separates them.
- **[[wiki/entities/nucleus-reuniens.md]]** — the third topology in the thalamic routing contrast: reuniens collateralises one content-bearing spike train to two structures, whereas the higher-order visual thalamus hands one cortical area's *state* to a downstream one — same cell class, different cargo and different fan-out.
- **[[wiki/concepts/emergent-modularity.md]]** — the cross-species asymmetry that supports this page's higher-order/relay distinction: humans gained neurons in the anterior principal, mediodorsal and pulvinar nuclei while sensory relay nuclei did not change, and the human dorsal thalamus uniquely receives GABAergic interneurons migrating from the telencephalic ganglionic eminence — the higher-order thalamus was rebuilt in human evolution and the relay thalamus was not.
