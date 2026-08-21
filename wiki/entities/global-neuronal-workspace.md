# The Global Neuronal Workspace — a Router With a Threshold

**A second computational space, laid over an assembly of specialised local processors: a distributed population of long-axon pyramidal neurons that receives from any processor, and — once a non-linear threshold is crossed — amplifies one representation and broadcasts it back to all of them. The framework's content is not "consciousness"; it is a *routing discipline* with an all-or-none admission gate, a self-sustaining hold, and a claim that global availability of a representation to every consumer is what makes it usable for report, working memory and multi-step action.**

> **Provenance.** Mashour, Roelfsema, Changeux & Dehaene 2020, *Conscious processing and the global neuronal workspace hypothesis*, Neuron 105(5):776–798, doi:10.1016/j.neuron.2020.01.026 (`raw/mashour-2020-global-neuronal-workspace.md`). A 20-year review by three of the framework's authors plus one adversary-turned-collaborator — **no new data**, and self-assessed ("the GNW hypothesis remains robust"). Read the mechanism as the contribution and the evidence rows as inherited. The framework's own lineage: Baars 1988 (psychological global workspace) → Dehaene, Kerszberg & Changeux 1998 (neuronal instantiation + Stroop simulation) → Dehaene et al. 2003 / Dehaene & Changeux 2005 (spiking simulation of masking and inattention).

---

## The architecture

| Component | Specification | What it corresponds to in a machine system |
|---|---|---|
| **Local processors** | Modular, specialised, encapsulated: perceptual, motor, memory, evaluative, attentional. Each computes without consulting the others | Experts / modules / a frozen sensory encoder stack |
| **Workspace neurons** | Widely distributed **excitatory** cells with long-range axons, reciprocally connected. Large layer II/III pyramidal cells, plus layer V | A shared bus with a fixed, sparse, wide fan-out — *not* a learned router |
| **Selection** | Workspace can "selectively mobilize or suppress, through descending connections, the contribution of specific processor neurons" | Read *and* write access to module state, addressed top-down |
| **Anatomy** | Dorsolateral prefrontal + inferior parietal, with anterior temporal, anterior/posterior cingulate, precuneus. Not redundant — each node has its own specificity; the claim is only that anything available to one is quickly available to the others | A heterogeneous set of hub modules, not one homogeneous global vector |
| **Structural warrant** | Macaque tract-tracing (Markov et al. 2013): a **bow-tie** topology with a high-density, high-efficiency parietal/prefrontal core forming a *structural bottleneck* capable of routing between other processors | The bottleneck is inherited from the wiring, and is therefore a prior — see [[wiki/concepts/connectome-hubs-and-cores.md]] |
| **Admission gate** | Non-linear **ignition** — sudden, coherent, *exclusive* activation of the workspace subset coding the current content, with the remaining workspace neurons inhibited | [[wiki/concepts/ignition.md]] |
| **Idle behaviour** | Continuous stochastic spontaneous activity in simulation → endogenous activation of representations with no input; matches the resting fluctuation that vanishes under anaesthesia | A generator that runs when nothing is asked — the thing gap `G90` says no wiki architecture has |

**Explicitly not a localisationist theory.** No node is the seat of anything. Prefrontal cortex is privileged only by *density* of the long-axon cells that make ignition attainable, and V1 becomes a workspace member on tasks that need fine-grained sensory detail (see the figure-ground case below).

---

## What the simulations actually established

| Simulation | Setup | Result that matters for building |
|---|---|---|
| Dehaene et al. 1998 | Stroop, workspace + processor units | Workspace activation rises during **novel task acquisition, effortful execution, and after errors** — i.e. the bus is engaged exactly where a cached policy fails. Sustained workspace activity bridges stimulus-offset → delayed response |
| Dehaene et al. 2003; Dehaene & Changeux 2005 | Spiking neurons, receptor dynamics, 4-level cortical hierarchy, 2 representations per level, bottom-up + top-down | Two-stage dynamics: fast **AMPA** feedforward wave whose amplitude tracks the input, then slower **NMDA** feedback that amplifies its own input in a cascade → global self-sustained reverberation, gamma power up locally and synchronised across areas. Masking and inattention are simulated as failures to reach this state |
| Joglekar et al. 2018 | Macaque connectivity from tracing, theoretically independent starting point | Ignition **emerges** in a reciprocally connected network — not built in. Requires **balanced amplification**: feedforward excitation carefully offset by local inhibition, else the cascade either dies or runs away |
| Mejias et al. 2016 | Adds laminar-specific connectivity | Frequency-band-specific causality falls out: bottom-up **gamma** from supragranular layers, top-down **alpha/beta** from infragranular. Matches human and macaque recordings — the band split is a *consequence* of laminar wiring, not a separate assumption |

**(brainstorm) The engineering statement.** A workspace is a shared latent slot plus three rules: (1) admission is thresholded and winner-take-all, so at most one coalition occupies it; (2) occupancy is maintained by recurrence, not by a copy, so the slot's contents are *live* and can be operated on; (3) occupancy is broadcast to every module at once, so no module needs a wire to any other. Rule (3) turns an `O(n²)` inter-module routing problem into `O(n)` — which is the same saving [[wiki/concepts/broadcast-hierarchy.md]] extracts from the anatomy, arrived at from the dynamics instead.

---

## Ignition, measured

The full mechanism, its timing and its threshold identity live on [[wiki/concepts/ignition.md]]. The evidence anchors:

| Preparation | Finding |
|---|---|
| Human EEG/MEG, multiple modalities | Divergence between reported and unreported trials at **200–300 ms**, not earlier; the first ~200 ms is preserved on unreported trials. Late ignition is the **only** signature common to auditory, visual and audiovisual (Noel et al. 2018) and the only one whose decoder generalises across vision, audition and touch (Sanchez et al. 2019) |
| Cross-modal decoding | Supramodal conscious-perception patterns include late activity in *other* modalities' sensory regions — auditory detection decodable from visual areas. Direct evidence of broadcast rather than of a frontal decision |
| Human single units | Medial-temporal concept cells fire stronger and longer for consciously perceived (or recalled) stimuli; masked-invisible stimuli elicit no response (Quiroga et al. 2008) |
| Macaque PFC, no-report binocular rivalry | Prefrontal firing encodes the *current content*, unconfounded by report or working memory (Panagiotaropoulos et al. 2012) |
| Macaque V1 / V4 / dlPFC, contrast detection (van Vugt et al. 2018) | Both seen and unseen stimuli drive V1 and V4; only seen ones produce sudden sustained PFC activity. **False alarms show spontaneous PFC ignition.** Propagation fails at different stages by stimulus strength: very weak lost V1→V4, stronger lost V4→PFC |
| Macaque V1, texture figure–ground (Supèr et al. 2001) | Initial feedforward response identical for figure and ground; only the *late* enhancement discriminates them, and only on hits. Failure of figure-ground perception = failure of recurrence involving V1 |
| Mouse somatosensory (Manita et al. 2015; Sachidhanandam et al. 2013) | Optogenetic silencing of M2→S1 feedback selectively removes the late S1 amplification and **prevents perception** — one of the few causal, not correlational, results in the set |

---

## The signal-detection identity

`van Vugt et al. 2018` collapses two theories into one mechanism:

| Signal detection theory construct | Global workspace realisation |
|---|---|
| Decision threshold | The **ignition threshold in PFC** — a minimum amount of activity must arrive before the cascade takes off |
| Sensitivity `d′` | How efficiently the sensory signal is *propagated* to PFC (fidelity of the V1→V4→PFC chain) |
| Response bias | **Pre-stimulus state**: higher pre-stimulus firing across all recorded regions sits the system nearer threshold → more false alarms. Also predictable from motivation and EEG band power *before* the stimulus |

**This is the wiki's cleanest statement that a decision threshold is not a free parameter of a read-out but a property of the network's own dynamics.** [[wiki/concepts/evidence-accumulation.md]] lists "the threshold itself is unmodelled" as an open problem; here the threshold is the bifurcation point of a recurrent cascade, and the bias term is the distance of the resting state from it — a quantity you can set by gain rather than by a comparator constant.

---

## Level of consciousness: what breaking the workspace looks like

The framework is tested twice — on *content* (above) and on *state*. The state evidence is the stronger structural claim, because it is drug-invariant.

| State | Observation | Reading |
|---|---|---|
| **General anaesthesia** | Propofol (GABA_A), sevoflurane (GABA_A + diverse), ketamine (NMDA antagonist + HCN1) — molecularly disjoint agents — all functionally disconnect prefrontal from posterior parietal/precuneus cortex in human fMRI, all preferentially attenuate **feedback** connectivity, replicated monkey → ferret → rodent → *Drosophila* | A **common proximate cause** with diverse root causes: the frontoparietal loop is the shared failure point. This is the framework's best argument — the target is a *network property*, not a receptor |
| **Anaesthesia, dynamics** | Awake cortex explores a functional-connectivity repertoire far more diverse than the anatomical matrix; all three anaesthetics collapse it toward patterns that "adhere" to anatomy, especially across workspace nodes (Barttfeld et al. 2015; Uhrig et al. 2018), generalising to vegetative/minimally conscious humans (Demertzi et al. 2019) | The state variable is **deviation of functional from structural connectivity** — see [[wiki/concepts/dynamic-repertoire.md]] and [[wiki/concepts/effective-connectivity.md]]. Anaesthesia also *stabilises* cortical dynamics and moves them away from criticality (Solovey et al. 2015; Lee et al. 2019) |
| **Anaesthesia, evoked** | Short-latency evoked potentials preserved, long-latency ones preferentially abolished; sensory processing intact after loss of responsiveness | "Fragmented cortical representations that are not experienced because, without a functional workspace, they cannot be broadcast" — a module can be right and unread |
| **Disorders of consciousness** | Weighted symbolic mutual information at mid/long range indexes level across vegetative → minimally conscious → recovered (Sitt et al. 2014, n = 181). Perturbational complexity index (TMS + high-density EEG) separates vegetative from minimally conscious and healthy, consistently across pathology, sleep and anaesthesia (Casali et al. 2013) | The index was born from a *rival* theory and is compatible with both — see the tension below |
| **Lesions** | Focal lesions rarely abolish consciousness (the population is distributed), but any reduction in workspace neuron count, interconnectivity or synaptic strength **raises the ignition threshold** in simulation; elevated perceptual thresholds are observed in frontal-lobe syndrome, neglect, multiple sclerosis and schizophrenia, correlated with abnormal long-distance tracts on diffusion imaging | Graceful degradation with a measurable cost: the system does not fail, it becomes harder to ignite |
| **Causal restoration** | Central thalamic stimulation reverses the anaesthetised state in monkeys with return of corticocortical connectivity (Redinbaugh et al. 2020; Donoghue et al. 2019) and produced long-term recovery in a minimally conscious patient (Schiff et al. 2007). Cholinergic stimulation of **medial prefrontal** — but not two posterior parietal sites — restores wakefulness in rats under continuous sevoflurane (Pal et al. 2018) | The reverberant loop is **not purely cortical**; the thalamus is inside it. Note the negative control: restoring behaviour by cortical stimulation does **not** restore EEG connectivity measures (Pal et al. 2019) |
| **Sleep** | First ~200 ms of auditory processing preserved (weakened) in stage 1–2; the loss is specifically of late ignition and the P3 (Strauss et al. 2015). REM dreaming correlates with posterior low-frequency reduction *plus* frontal gamma; **lucid** dreaming adds further dlPFC gamma and coherence, and entraining low gamma during REM increases lucidity (Voss et al. 2009, 2014) | Content can be present without input; the workspace can be partially engaged. Lucidity as a *dial* on prefrontal engagement is the closest biological analogue of a metacognitive switch |

---

## Workspace, attention and working memory: the framework's strongest architectural claim

The review's substantive commitment is that these are **not three systems**:

| Function | Claim | Machine consequence |
|---|---|---|
| **Attention** | A "diverse set of temporal, spatial and cognitive filters", most of which operate non-consciously; only the **final** one gates entry to the workspace | Selection is a pipeline, and only its last stage is the admission gate. Most of a system's attention can and should be pre-conscious |
| **Object-based binding** | Attentional selection of one feature co-selects the other features of the same object across areas; enhanced activity *spreads* through corticocortical connections, in either direction (IT/frontal → retinotopic for visual search; location → shape for cued identification) | Binding as **label propagation over the module graph**, not as a separate binding operator. Explains why workspace contents are coherent multi-feature multi-modal objects |
| **Working memory** | The **attended** item is conscious and uses the workspace; unattended items in the store are carried by weaker local persistent firing or by **activity-silent** synaptic traces (Mongillo et al. 2008) | A two-tier store where only the top tier is globally visible |
| **The transformability claim** | *Only active neural states can be mentally transformed* (e.g. mental rotation); activity-silent states merely store what was already computed and should be called short-term memory. Whenever the content must be transformed, an active decodable state re-emerges with conscious-access signatures (Trübutschek et al. 2017, 2019) | **The sharpest testable design rule in the source.** A weight-based fast memory is a *register file*, not an ALU input; computation requires re-instating activity. See the tension logged below against the wiki's synaptic working-memory models |
| **Reasoning, explicitly** | Raven's Progressive Matrices is given as the worked example: hypotheses about relations between cells, feature counting via successive feature-based attention, comparison of spatial configurations — all requiring exchange between processors that have no direct wires to each other | The framework's own claim to abstract reasoning: the workspace is what makes a *serial sequence of attentional operations over distributed representations* possible at all |
| **Mental simulation** | Medial-temporal cells code **transitions** between working-memory states and show prospective coding for upcoming list items; "subjects can navigate through sequences of working memory states to explore the future consequences of actions" | Workspace occupancy as one step of a search; the association network supplies the successor — the same object as [[wiki/concepts/successor-representation.md]] read as a workspace transition operator |

---

## Comparison to the rival theories (the source's own table, plus what separates them empirically)

| | **Global neuronal workspace** | **Integrated information (IIT)** | **Recurrent processing (RPT)** | **Higher-order thought (HOT)** |
|---|---|---|---|---|
| A conscious process is | Information from a local processor entering a large-scale reverberant network and being globally accessed | Information both integrated and differentiated, irreducible to causally independent parts | Any code shaped by recurrent loops from higher to lower areas | A first-order representation entering a second-order metacognitive representation |
| Mechanism | Sudden ignition of a brain-scale network linked by long-distance re-entrant loops | A posterior sensory/association "hot zone" | Feedback within sensory pathways | Circuits that meta-represent other areas' information |
| Role of prefrontal cortex | Important hub; contributes non-linear ignition | **Not essential** — post-conscious processing only | **Not essential** — post-conscious only | **Essential** (e.g. BA10): it generates the meta-representation |
| Measured by | Late (~300 ms) global ignition, long-distance information sharing | Φ surrogates; perturbational complexity index | Top-down signals reaching sensory areas | Not determined |
| Broken by | Disruption of hubs or reverberant connectivity, particularly top-down amplification | Suppression of integration or differentiation → smaller state repertoire | Selective suppression of re-entrant processing | Suppression of anterior prefrontal meta-representation |
| Stance | **Representational**; consciousness is an evolved neurocomputational system for sharing representations; a *function* is assigned | **Non-representational**; the system is closed, information is generated by and for the system; framed mathematically | Representational, restricted to sensory hierarchy | Representational, metacognitive |

**The review's honest admission:** anaesthetic suppression of recurrent processing is "broadly consistent with all four theories", and the perturbational complexity index — born from IIT — is equally compatible with the workspace account. The four are not currently separable with available instruments; a preregistered adversarial collaboration (GNW vs IIT, fMRI + MEG + intracranial, passive viewing and dual-task) was underway at the time of writing. **The relevant part for this wiki is that the *architectural* differences are sharp even where the empirical ones are not:** whether a shared global bus is required, or local recurrence suffices, is a design decision with a measurable cost.

---

## Limitations, as a design document

| Limitation | Detail |
|---|---|
| **No account of self-representation** | "There is currently no good theory of how the brain achieves such meta-representations." The proposal on offer — error awareness as a **consistency check between a fast non-conscious perception→action route and a slower conscious route computing the intended response** (Charles et al. 2013) — is a mechanism for one narrow case, generalised only by hope. Graziano's "attention schema" (an internal model of one's own attention, by analogy to the body schema) is cited as a direction |
| **Recursion is asserted, not explained** | Human recursive/self-embedded representations in language, mathematics and theory of mind are named as the missing higher level; other animals are said to lack them. No mechanism proposed. This is the same boundary [[wiki/concepts/compositionality.md]] and [[wiki/concepts/language-of-thought.md]] run into from the other side |
| **The workspace has no learned content** | Every simulation hand-specifies which processors exist and what they compute. Nothing in the framework says how a processor comes to be modular, or how the workspace learns *what is worth broadcasting* — the credit-assignment problem for an admission gate is untouched |
| **Phenomenal/access distinction dodged** | The framework replaces "consciousness" with conscious *access* and questions the distinction rather than resolving it; RPT's proposal (local feedback → phenomenal, global → access) is called untestable "short of an experimental method for producing conscious experience in the absence of conscious access" |
| **Development is thin** | Ignition-homologous late slow waves are present in 5-, 12- and 15-month-olds (Kouider et al. 2013), starting ~900 ms at 5 months and accelerating to ~750 ms, against ~300 ms in adults. All long-distance tracts exist at birth but are unmyelinated. So the gate exists early and its *speed* matures — but nothing says what maturation changes computationally beyond conduction delay |
| **Self-assessment** | Written by the framework's authors. The Feynman line closing the paper — "what I cannot create, I cannot understand" — is the correct standard, and the review concedes the framework has not met it: nothing has been "implemented in an actual computational device" |

---

## The causal test the framework has not passed

> **Second source (260th ingest).** Raccah, Block & Fox 2021, J Neurosci 41(10):2076–2087 (`raw/raccah-2021-pfc-consciousness-stimulation.md`). Written by opponents; read the rates, not the verdict. Method and full gradient: [[wiki/concepts/perturbation-elicitability.md]].

Every row in the evidence tables above is correlational except the mouse feedback-silencing result. Intracranial electrical stimulation is the one causal handle available in humans, and applied to prefrontal cortex it returns the framework's worst result:

| Prediction the framework should make | What stimulation finds |
|---|---|
| Perturbing the prefrontal workspace population alters, interrupts or replaces the content currently broadcast | Stimulation of **anterolateral and frontopolar prefrontal cortex — the sites prefrontal theories name — has the lowest elicitation rate in the entire brain** (0% at the frontal pole; ~67% in primary visual and somatomotor cortex; 17% in orbitofrontal cortex across 172 sites) |
| The elicited change should be *about* the ongoing percept, since the workspace is holding it | The rare prefrontal effects bear **no relation to the immediate environment**: smells, tastes, visceral sensations, emotions, motivational states, content-free thoughts. Fusiform stimulation, by contrast, distorts the face the patient is looking at |
| Prefrontal cortex is privileged by long-axon density, not by locality | Consistent — but so is the null. Low elicitability is shared with posterior cingulate and the transmodal networks generally, so the gradient tracks hierarchical depth rather than singling prefrontal cortex out |

**What survives, and what it costs the framework.** The result is compatible with prefrontal cortex being the **router** and incompatible with it holding the **payload**: breaking a router degrades throughput without changing what any message says — and lateral prefrontal transcranial magnetic stimulation and lesions do impair perceptual and metacognitive *performance* while stimulation changes no reported content (Rounis et al. 2010; Del Cul et al. 2009; Fleming et al. 2014). Since the framework's own claim is a routing discipline rather than a seat of content, that reading is available to it at a price: the workspace's contents would then be constituted elsewhere, and "ignition in PFC" indexes admission rather than occupancy. The source's authors do not offer this reading. Live limits on the null: sub-reportable effects are untested (the proposed fix is iES *during a task*, scored on performance), and patients may be mind-wandering. Logged as [[wiki/empirical-tensions.md]] T269.

**The one positive prefrontal finding is affective, not perceptual.** Orbitofrontal and anterior cingulate stimulation reliably elicits emotional and motivational states — including a reproducible "push harder … I have to make it through" in anterior midcingulate (Parvizi et al. 2013) — with subjective intensity rising linearly over 2–8 mA (Yih et al. 2019). That dose–response is also the method's positive control: where prefrontal stimulation has power, it is graded, so the anterolateral nulls are not instrument failure.

---

## The adversarial test, and the framework's reply

> **Third source (262nd ingest).** Naccache, Sergent, Dehaene, Wang, Farisco & Changeux 2025, *GNW theoretical framework and the "adversarial testing of global neuronal workspace and integrated information theories of consciousness"*, Neurosci Conscious 2025(1):niaf037 (`raw/naccache-2025-gnw-adversarial-testing.md`). A commentary — **no new data** — written by the framework's authors in reply to the COGITATE consortium's preregistered adversarial collaboration (Cogitate et al. 2025, Nature; fMRI + MEG + iEEG, GNW vs IIT). This is the collaboration the 2020 review announced as "underway". Read the concessions and the *reasons given* for the failures; the verdict is self-assessed.

**What the adversarial test confirmed** — non-trivial, and the first multicentre preregistered support the framework has:

| Prediction | Outcome as reported here |
|---|---|
| Transient ignition after stimulus onset, 200–800 ms | Observed |
| Ignition is **independent of stimulus duration** | Observed (500 / 1000 / 1500 ms) |
| Ignition is **independent of task relevance** | Observed on task-irrelevant non-target stimuli, i.e. under no-report conditions |
| Conscious content decodable in visual, ventrotemporal **and inferior frontal** cortex, with sustained responses | Observed, with **content-specific synchronisation between frontal and early visual areas** — the broadcast claim measured as a channel, not just as a frontal activation |

**What it failed, and the reply's three moves.** Each is a different kind of defence and they should not be scored alike:

| Reported failure | Reply | Kind of move |
|---|---|---|
| No second ignition at stimulus **offset**, which the collaboration's formalisation of the theory had drawn as a core prediction | Offset ignition is predicted **only if the participant consciously attends the offset**, and no simulation (1998–2011) or recording ever produced one. With long, variable-duration, task-irrelevant stimuli there was no reason to attend the offset | **Deflection with a check**: the claim is auditable against the framework's own published simulations, and the reply names the condition that would make the null count — enforce awareness of the offset, then look |
| Stimulus **category and orientation could not be decoded from prefrontal cortex** — the collaboration's "key challenge" | The asymmetry is a property of the **read-out**, not of the content: visual areas have mesoscopic columnar organisation (neighbouring cells share selectivity), prefrontal cortex has no strong columnar organisation and **mixed selectivity** instead (Wang 2022). Field-potential-scale instruments (fMRI, MEG, iEEG) average over the mixture. Counter-point with teeth: decoding from visual areas succeeds **even for non-conscious stimuli** (Dehaene et al. 2001; Salti et al. 2015; King et al. 2016), so the posterior decoding read as positive evidence for IIT may index non-conscious processing. Proposed fix: single-cell-resolution recording (Neuropixels) | **Instrumental**, and it cuts both ways — it disarms the negative prefrontal result *and* the positive posterior one. Logged as T272 |
| Transient "silent states" — gaps in the decoding of an ongoing stimulus | The framework predicts a content is decodable from workspace areas **exactly as long as it occupies the workspace**; long monotonic task-irrelevant stimuli make lapses of awareness likely, and no subjective reports were collected, so occupancy is unknown | **Unfalsifiable as stated** — with no report, any decoding gap can be attributed to a lapse and any decoding to occupancy. The framework's no-report paradigm and its explicit-encoding claim are in tension: the first removes the only measurement that could license the second |

**(brainstorm) The one architectural fact under the offset dispute.** The reply's position is that the commit fires on **change in attended content**, not on change in the input. Those coincide at onset (a new stimulus captures attention) and come apart at offset (nothing new arrives; the old content merely stops being supported). A machine event-segmenter built on input change would emit two boundaries per stimulus; one built on workspace occupancy emits one, and emits a second only when something else wins the bus. This is a testable difference between the two candidate step-boundary generators in [[wiki/concepts/event-segmentation.md]], and the reply commits the framework to the second. Logged as T271.

**The molecular grounding, offered as the framework's distinguishing asset.** Allosteric transitions of postsynaptic receptors, balanced excitatory/inhibitory receptors, the AMPA/NMDA ratio, hierarchical reward and vigilance modulation, and spontaneous activity as the driver of ignition (Dehaene & Changeux 2005). The claim is that this makes the theory testable in animals and in pathology in a way a purely mathematical rival is not. **It also updates this page's harshest limitation row**: the 2020 review conceded nothing had been "implemented in an actual computational device"; two formal models are now cited (Volzhenin et al. 2022; Klatzmann et al. 2025), neither read here.

**The methodological demand, which is the part worth importing.** Adversarial testing should confront the **"formal organisms"** — run each theory's simulation on the same behavioural task and compare outcomes — rather than compare each theory's verbal predictions against one shared dataset. The wiki's version of this complaint: a theory that is only ever fit to neural recordings can absorb a null by renaming a prediction, and the three moves tabulated above are exactly that failure mode in its mild form. A theory that has to *pass the task* cannot.

---

## Connections

- **[[wiki/concepts/ignition.md]]** — the mechanism this framework is built on, extracted as a reusable primitive: the non-linear all-or-none admission gate, its ~300 ms latency, its AMPA/NMDA two-stage structure, and its identity with a signal-detection threshold.
- **[[wiki/concepts/broadcast-hierarchy.md]]** — the same selective-in/diffuse-out saving derived from anatomy rather than dynamics; this page adds the *gate* that page lacks (which of the competing contents gets to use the diffuse output) and that page adds the laminar-type routing prior this one leaves unspecified.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — supplies the structural warrant: the bow-tie core of high-density parietal/prefrontal areas (Markov et al. 2013) is a routing bottleneck given by the wiring, so the workspace's fan-out is a prior rather than a learned adjacency.
- **[[wiki/concepts/working-memory.md]]** — the framework's two-tier store: the attended item is globally broadcast and transformable, everything else is weak local persistent firing or an activity-silent synaptic trace that can only be *stored*, not operated on.
- **[[wiki/concepts/attention.md]]** — attention is decomposed here into a stack of mostly non-conscious filters whose *last* stage is the workspace admission gate, and object-based binding becomes label propagation over the module graph rather than a separate binding operator.
- **[[wiki/concepts/cognitive-control.md]]** — the 1998 Stroop simulation puts workspace engagement exactly where control is needed (novel task, effortful execution, post-error), which makes the workspace the substrate for a task model rather than a separate resource.
- **[[wiki/concepts/evidence-accumulation.md]]** — supplies the missing threshold: the decision criterion is the bifurcation point of a recurrent cascade in prefrontal cortex, and response bias is the distance of the *pre-stimulus* state from it, both measurable before the stimulus arrives.
- **[[wiki/concepts/dynamic-repertoire.md]]** — the state-level signature: waking cortex explores far more functional-connectivity patterns than anatomy predicts, and three molecularly disjoint anaesthetics all collapse the repertoire back onto the structural matrix, most strongly across workspace nodes.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — the condition under which ignition exists at all: Joglekar et al.'s balanced amplification requires feedforward excitation offset by local inhibition, so the same knob that sets speed–accuracy sets whether a cascade takes off, dies or runs away.
- **[[wiki/concepts/metastability.md]]** — conscious access described as a trajectory through a series of metastable states rather than a single attractor, with seen and unseen trials diverging as trajectories, which is what makes ignition decodable rather than merely energetic.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — the broadcast's carrier: ignition raises gamma power locally and synchronises it across areas, and the laminar simulations derive the bottom-up gamma / top-down alpha-beta split from wiring rather than assuming it.
- **[[wiki/entities/default-mode-network.md]]** — an overlapping but differently motivated hub set (medial prefrontal, posterior cingulate, precuneus): the workspace claims those hubs for *broadcasting current content*, the default mode literature claims them for *internally generated content*, and no source in the wiki reconciles the two assignments.
- **[[wiki/concepts/default-self-model.md]]** — the framework's stated frontier and its weakest section: self-consciousness as a consistency check between a fast unconscious route and a slow conscious one, plus an "attention schema", with no mechanism for recursion.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the review's own preferred functional interpretation of the broadcast: workspace neurons hold a compressed high-level model, top-down signals are its predictions, bottom-up signals amplify or contradict them — with the local/global oddball dissociation (mismatch negativity survives coma, the P3 global-violation response does not) as its evidence.
- **[[wiki/concepts/successor-representation.md]]** — medial-temporal cells coding *transitions* between working-memory states and prospectively activating upcoming items make the workspace a step operator over an association graph, which is what turns broadcast into search.
- **[[wiki/entities/h-jepa.md]]** — the wiki's nearest machine analogue: a configurator that modulates every other module for the task at hand, explicitly credited to Dehaene's self-monitoring level — but it has no threshold, no exclusivity and no broadcast, so it is the bus without the gate.
- **[[wiki/entities/thousand-brains-theory.md]]** — the architectural rival: thousands of parallel models voting to consensus over long-range connections, with no privileged core and no admission threshold, so the two disagree about whether a distinguished global bus is needed at all.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the workspace is the framework's answer to the *navigation* half: Raven's matrices solved by a serial sequence of attentional operations over distributed representations, each step's result broadcast so the next can use it.
- **[[wiki/concepts/perturbation-elicitability.md]]** — the causal test this framework has not passed: intracranial stimulation of lateral and anterior prefrontal cortex yields the lowest rate of reportable content change in the entire brain (0% at the frontal pole against ~67% in unimodal cortex), and the rare prefrontal effects insert new content rather than perturbing the ongoing percept the workspace is supposed to be holding.
- **[[wiki/entities/integrated-world-modeling-theory.md]]** — the framework that accepts this one and constrains it: broadcast is kept wholesale, workspace occupancy is given a computational identity (the MAP estimate of a converged loopy posterior over coupled latents), and sufficiency is denied — integration and availability do not make a world model without spatial, temporal and causal coherence for an embodied controller.
- **[[wiki/concepts/population-geometry.md]]** — the read-out argument that both rescues and costs this framework: prefrontal mixed selectivity is cancelled by field-scale instruments while columnar visual cortex is legible to them even for non-conscious stimuli, so neither the failed prefrontal decoding nor the successful posterior decoding says what the adversarial collaboration read into it ([[wiki/empirical-tensions.md]] T272).
- **[[wiki/concepts/loopy-belief-propagation.md]]** — what the bus is claimed to be carrying: the broadcast content becomes the argmax of an approximate joint posterior computed by iterated message passing across chained autoencoder bottlenecks, which supplies the *why now* this framework leaves as a free threshold.
