# The Default Mode Network — Two Subsystems Meeting on a Hub, and a Function Its Own Design Cannot Identify

**A specific, anatomically defined cortical system — ventral and dorsal medial prefrontal cortex, posterior cingulate/retrosplenial cortex, inferior parietal lobule, lateral temporal cortex, hippocampal formation — that is *most* active when nothing is being asked of the organism and *deactivates* under nearly every externally directed task. Three architecturally load-bearing facts: (i) it is not one system but **two subsystems that are anticorrelated with each other** — a medial temporal lobe subsystem supplying stored associations, a dorsomedial prefrontal subsystem doing self-referential construction — sharing a common set of hubs (posterior cingulate/retrosplenial, ventral medial prefrontal, inferior parietal); (ii) the same network is engaged by autobiographical recall, imagining the future, theory of mind and personal moral dilemmas, which differ in tense and in whose perspective is taken and agree only in requiring a **simulation of a perspective other than the present**; and (iii) the function is *not identified* by any experiment reported here, because passive tasks change two things at once — mental content and breadth of external attention — so a simulation engine and an environmental sentinel predict the same data.**

> **Provenance.** Buckner, Andrews-Hanna & Schacter 2008, *The Brain's Default Network: Anatomy, Function, and Relevance to Disease*, Ann. N.Y. Acad. Sci. 1124:1–38, doi:10.1196/annals.1440.011 (`raw/buckner-2008-default-network-anatomy.md`). A review, not a primary study: it aggregates three meta-analyses of task-induced deactivation (18 datasets, 195+ subjects for the blocked PET arm alone), functional-connectivity maps seeded on posterior cingulate and on hippocampal formation, macaque tract-tracing for the connectional anatomy, and the clinical literature on autism, schizophrenia and Alzheimer's disease. Every effect below is **correlational**; the authors state plainly that no lesion study has yet been designed against the network. This is the anchor page for the wiki's default-mode wave — later sources attach their claims here.

---

## The anatomy

| Region | Abbrev | Brodmann areas | Status in the network |
|---|---|---|---|
| Ventral medial prefrontal cortex | vMPFC | 24, 10m/10r/10p, 32ac | **Hub** — near-complete convergence across all three definition methods |
| Posterior cingulate / retrosplenial cortex | PCC/Rsp | 29/30, 23/31 | **Hub** — the strongest and most consistent node |
| Inferior parietal lobule | IPL | 39, 40 | **Hub** |
| Dorsal medial prefrontal cortex | dMPFC | 24, 32ac, 10p, 9 | Subsystem head (self-referential) |
| Hippocampal formation + entorhinal/parahippocampal | HF+ | — | Subsystem head (mnemonic); weaker under task-induced deactivation than under connectivity |
| Lateral temporal cortex | LTC | 21 | Consistent but weakest; the authors call it the most tentative estimate |
| Precuneus | area 7m | 7m | **Provisionally *not* a member** — see below |

**Three independent definition methods converge** — and their convergence is the paper's core anatomical claim:

| Method | Data | What it adds |
|---|---|---|
| Blocked task-induced deactivation | 195 subjects / 18 studies, PET + fMRI; verbal and nonverbal, visual and auditory | The original map (Shulman 1997, Mazoyer 2001) |
| **Event-related** task-induced deactivation | 49 subjects, jittered 2–10 s trials | The mode difference emerges **within seconds**, not over sustained epochs — it is a fast switch, not a slow drift |
| Functional connectivity, hippocampal-formation seed | 4 datasets | Recovers most of the neocortical network from a *medial temporal* seed, independent of any task contrast |

Sparing sensory and motor cortex entirely, and including the medial temporal memory system, is what the function hypotheses have to respect.

**The precuneus exclusion is the useful negative result.** Area 7m is routinely called a default-network region in the imaging literature; the authors argue it is not one. Its macaque connections run to occipital/parietal visual areas and to frontal motor-planning areas; medial temporal regions that project heavily to PCC and Rsp barely touch it; and the deactivation maps usually stop short of the parietal midline edge. Their reading: "precuneus" in the literature is often a loose label for a region that includes areas 29/30. This directly qualifies [[wiki/concepts/connectome-hubs-and-cores.md]], where precuneus is a top-ranked member of the cortical structural core on six graph measures — logged as [[wiki/empirical-tensions.md]] T256.

**Cross-species.** Posterior components (PCC/Rsp, IPL, HF) have macaque homologues recoverable by the same connectivity method, and the network is present under deep anaesthesia. The two regions that are *disproportionately expanded* in humans are exactly the two that carry the self-referential and integrative load: medial prefrontal area 10 (expanded even relative to great apes) and IPL, among the greatest expansions across the 23 mapped homologies.

---

## The subsystem decomposition — the transferable architecture

Seeding intrinsic correlations separately on HF+, dMPFC and vMPFC gives a structure that is **not** a single densely coupled cluster:

| | Medial temporal lobe subsystem | Dorsomedial prefrontal subsystem |
|---|---|---|
| Members | HF, parahippocampal cortex | dMPFC |
| Job (authors' hypothesis) | Supplies associations, relational detail and prior episodes — the **building blocks** | Constructs the **self-referenced** simulation from them |
| Coupling to hubs (PCC/Rsp, vMPFC, IPL) | Strong | Strong |
| Coupling to each other | **Negative** — functionally dissociated |
| Task signature | Rises with retrieval of strong traces carrying remembered associations and details | Rises with judgments about agents conceived as social/interactive/emotive *like oneself*; does **not** rise for an inanimate object (a camera), an unfamiliar public figure, or a person described as socio-politically dissimilar |

Two tasks separate them: **theory-of-mind** engages the dMPFC subsystem with minimal medial temporal involvement, while **autobiographical memory and future-imagining** engage both. The authors' proposal is that the dMPFC subsystem recruits the medial temporal one *to the degree that past episodic information constrains the simulation being built*, and that PCC exists to hold the interface open for that recruitment.

**Why this shape matters to a builder (brainstorm).** This is a **retrieval-augmented generator with a shared bus**, specified anatomically: a content store and a constructor that do not talk directly, both writing to and reading from a small set of hubs, with recruitment of the store *graded by how much the construction must be constrained by real episodes*. Every retrieval-augmented architecture in the wiki wires retriever→generator directly and retrieves unconditionally. The biological version routes both through a third component and makes the retrieval call a function of the construction's evidential demands — and the store and the constructor are *mutually suppressing*, which no wiki architecture's retriever and generator are.

Normative correlation strengths and a spring-embedded graph are given: a red core (PCC/Rsp, vMPFC, IPL) all correlated with each other, LTC positioned distant on weak correlations, the medial temporal pair attached to the core but not to dMPFC.

---

## The two function hypotheses, and why the design cannot separate them

Going from an active task to a passive one changes **two** things simultaneously: what the mind's content is (stimulus-independent thoughts rise) and how attention is distributed (focused → diffuse). The authors draw this explicitly as the reason the literature is stuck.

| Hypothesis | Claim | Evidence for | Evidence against |
|---|---|---|---|
| **Internal mentation / simulation** | The network constructs self-relevant mental simulations from stored episodes, used for remembering, prospection, mentalizing, moral evaluation | Autobiographical memory meta-analysis (24 PET/fMRI studies) recovers the network; future-imagining, theory-of-mind and personal moral dilemmas all activate it; anatomy includes memory structures and excludes sensory ones; PCC responds to stories requiring another's *thoughts* but not their bodily sensations or appearance | All correlational; the network's low-frequency fluctuations persist in sleep and under burst-suppression anaesthesia, when no mentation is available |
| **Sentinel / watchfulness** | The network supports broad, low-level monitoring of the environment when focused attention is relaxed | Consistent with classical posterior parietal function; fast responses in a target-detection task came *with* raised default-network activity (Hahn 2007) | Does not explain the coupling to medial temporal memory structures at all |

**The lapse evidence, which mostly favours mentation:** attention lapses (slow responses) are preceded by reduced activity in attentional-control regions and accompanied by raised PCC/Rsp; default-network activity at encoding predicts words that will be **forgotten**; MPFC and PCC/Rsp rise on trials just before go/no-go errors (replicated). Against it, the Hahn result runs the other way.

**Stimulus-independent thoughts scale with the signal:** rest vs a tone-detection task produced ~6× more reported stimulus-independent thoughts alongside raised default activity; a parametric difficulty manipulation produced ~2× more on the easiest than the hardest task with a strong correlation to network activity; and *individual differences* in self-reported daydreaming correlate with PCC/Rsp activity in a mind-wandering-conducive condition.

**But the intrinsic fluctuations are probably not the thoughts.** Three reasons the authors give for decoupling the slow signal from cognition: spontaneous correlated activity exists in every system including primary sensory and motor; it persists in sleep and deep anaesthesia; and it is slower than one cycle per 10 s, slower than cognitive events. Their intermediate position — the rest signal is *both* a physiological process that runs regardless and a cognitive process that dominates content when awake — is a hypothesis, not a result.

---

## Anticorrelation: two modes, and the missing arbitrator

The default network is **negatively correlated** with the dorsal attention system used for focused external processing: as one rises the other falls. The authors read this as two competing modes of information processing — internally generated simulation vs external information extraction — and pose the question the wiki inherits: *is there a separate controller that assigns the network, or do the two systems settle it locally between themselves?* The only candidate offered is preliminary: a frontoparietal system anatomically interposed between the two (Vincent 2007b).

**The methodological caveat is stated by the authors and matters.** Correlations are computed after removing global signal variation, which centres the correlation distribution near zero and therefore *forces* negative values to exist. How much of anticorrelation survives without that normalisation is unresolved here.

Two further competition results: spontaneous default-network correlations **persist through** stimulus blocks rather than being abolished by them, and individuals with the strongest intrinsic default correlations showed the most **attenuated sensory-evoked responses** — a direct cost of the internal mode paid in sensory gain.

---

## Metabolism, and the failure of the "absolute baseline" claim

- Resting glucose metabolism in PCC is ~**20% above** most other cortical regions (normalised to pons); regional blood flow is likewise high. But high metabolism is **not selective** to the network — a region at or near primary visual cortex is equally high, and the authors note that no systematic in-network vs out-of-network comparison of resting metabolism has been done.
- The oxygen extraction fraction (OEF) argument for an *absolute physiological baseline* — that OEF is constant across the network at rest — does not hold up on inspection: individually tested default regions showed OEF decreases at `p < 0.05`, and regional OEF variation replicated across datasets at `r = 0.89`, where a genuinely constant OEF would give zero correlation. The variation is small (most regions within 5–10% of each other), so the honest statement is *modulated but weakly*, not *constant*. The primary tables are now on the page — see the Raichle et al. 2001 section below and [[wiki/concepts/activity-baseline.md]] — and they support the critique: left area 40 replicates at 0.90 of the hemisphere mean across both groups (p = 0.07, 0.04), and global OEF itself differs by a third between the two scanners.
- A metabolism-based connectivity map — FDG-PET across 163 adults, correlating regional glucose metabolism, with regions defined in postmortem tissue — recovers the network from **ventral PCC specifically**, without relying on vascular coupling at all. This is the cleanest control in the paper against the objection that the default network is a haemodynamic artefact, and it *narrows* the posterior hub below the resolution of the fMRI maps.

---

## Clinical dissociations, read as control failures

The value here is not the clinical detail but the shape: the same network appears **under-engaged** in one disorder and **over-engaged** in another, with the network itself possibly intact in both.

| Disorder | Finding | Reading |
|---|---|---|
| Autism spectrum | Task-induced deactivation absent during passive tasks (vMPFC, PCC); the individuals with the most atypical vMPFC activity had the greatest social impairment; intrinsic default correlations weaker; **differences also in the frontoparietal system proposed to control the switch** | The authors' own suggestion: the network may be largely intact but *under-utilised*, because the control system that assigns it fails |
| Schizophrenia | Three studies converge on an **overactive** network — positive symptoms (hallucinations, delusions) correlate with raised default activity during passive epochs; poor performance correlates with MPFC activation; inter-regional correlations *higher* than controls | Failure of the same arbitration in the opposite direction: the boundary between simulated and perceived is exactly what a mode controller maintains |
| Alzheimer's disease | Amyloid deposition and later atrophy fall on the young-adult default-network map; hypometabolism tracks severity; rest-state glycolysis maps correlate with plaque distribution; synaptic activity raises extracellular Aβ in transgenic mice | The **activity → pathology** direction: sustained high baseline activity as a risk factor, not just a marker |

**(brainstorm)** The autism/schizophrenia pair is the strongest argument in the paper for a *separate arbitrator* rather than local mutual inhibition: under-use and over-use of the same network are two settings of one control variable, and the autism data locate a frontoparietal abnormality alongside the default abnormality. A local winner-take-all between two systems would fail more symmetrically.

---

## Menon 2023 — what the next fifteen years added

> Menon 2023, *20 years of the default mode network: A review and synthesis*, Neuron 111(16), doi:10.1016/j.neuron.2023.04.023 (`raw/menon-2023-default-mode-network-20-years.md`). A Perspective by the author who, with Greicius, coined "default mode network" in 2003. It reports almost no effect sizes; read it as a hypothesis with an anatomy attached, and grade each claim by the method column below.

**Three of the seven open problems above have moved.**

| Buckner 2008 open problem | Status after Menon 2023 |
|---|---|
| "No lesion study has ever been designed against this network" | **Partly answered.** Patients with **left angular gyrus lesions** show markedly reduced mind wandering — the first causal-grade human evidence attaching a default-mode node to an internally generated process. Still one node, one function |
| The deactivation might be a baseline/threshold or vascular artefact | **Closed.** Intracranial EEG in patients with intractable epilepsy: selective **high-gamma (76–200 Hz)** power increase in medial prefrontal cortex and posterior cingulate/precuneus at rest relative to finger movement, vision and speech; transient high-gamma *suppression* in the same nodes during spatial attention and word reading, and in posterior cingulate/retrosplenial during mental arithmetic. The suppression is neuronal, fast, and visible without any subtraction |
| "How to activate default nodes *above* their resting baseline" — the reason the direct role was untestable | **Solved for three nodes.** Self-referential trait judgments raise medial prefrontal cortex, posterior cingulate and left angular gyrus above resting baseline; area **PGp** of the angular gyrus is one of the few regions in the brain that exceeds resting baseline during semantic judgment (5-study analysis). The network is no longer defined only by what suppresses it |
| What controls the switch | **A candidate with an anatomy**: the salience network (anterior insula + dorsal anterior cingulate) as causal outflow hub, validated by rodent optogenetics — [[wiki/entities/salience-network.md]] |

**The node-level dissociation, which is the review's strongest negative result.** Meta-analyses over 8,000+ task fMRI studies give each node a different profile — this is the evidence that the network has no unitary function *as cognitive functions are currently labelled*:

| Node | Preferential engagement |
|---|---|
| Posterior cingulate cortex (PCC) | Autobiographical recall; self–other distinction; hub that *upregulates* other default nodes during self-related processing (effective connectivity) |
| Retrosplenial cortex (RSC) | Spatial memory and navigation |
| Precuneus | Visual imagery |
| Medial prefrontal cortex (mPFC) | Value judgments, emotion regulation, cognitive elaboration/reappraisal, generation of stimulus-independent thought; monitoring one's own *and* others' mental states |
| Hippocampus | Episodic memory formation |
| Anterior temporal cortex (ATC) | Semantic memory and categorisation |
| Left angular gyrus (AG) | Language-related semantic judgments; retrieval of personally relevant semantics; elaboration of memory content |
| Right AG / temporoparietal junction | "Other-relevant" information — others' mental states, beliefs, predicted behaviour |
| Left middle temporal gyrus (MTG) | Monitoring internal speech; with superior temporal sulcus, speech comprehension |

Two consequences the review draws and the wiki should keep: (i) the same nodes serve *both* internally directed and externally driven processing, so the internal/external dichotomy is not a partition of the anatomy; (ii) the network fractionates into **interdigitated subnetworks** — dorsal PCC, ventral PCC and RSC anchor distinct ones with distinct couplings to the control networks — linked by **convergence zones** acting as connector hubs. The single-hub reading of PCC on this page is therefore too coarse.

**The proposed unifying function: integrate-and-broadcast an internal narrative.** Menon's model is that the network binds episodic memory, semantic memory and language into an ongoing internal narrative — "part monolog and part dialog" — constituting the epistemic self, and *broadcasts* it globally to maintain subjective continuity; the broadcast is paused when external stimuli must be attended to and resumes with updated representations. Four supporting observations, in descending grade:

| Observation | What it supports |
|---|---|
| Default nodes have **net causal outflow** exceeding inflow to all other networks, including sensory and motor, at rest *and* during episodic memory formation, with interaction strength **higher during memory formation** (information-theoretic analysis of distributed depth electrodes) | The broadcast direction, and that it is task-modulated rather than idle chatter |
| PCC activation patterns **persist** through naturalistic movie watching and change at perceived **event boundaries**; patterns generalise across *externally* signalled boundaries and *internally* generated boundaries during unguided recall, most strongly in PCC and RSC | "Frames of thought": the broadcast is discretised, and the same boundary code serves perceived and imagined streams |
| The network integrates over **slower timescales** than other systems in narrative speech processing | The frame rate is set by an integration window, not by the stimulus |
| Speaker–listener coupling: listener mPFC activity **predicts** the speaker's activity while listener PCC *lags* it, and prediction strength correlates with narrative comprehension | The narrative machinery runs in *anticipation* during comprehension, i.e. it is a generative model being used predictively — not a passive recall store |
| Rodent two-photon imaging: task information is shared across areas within **200 ms** and a **global fluctuation mode** conveys the animal's response to every area imaged within **1 s**, in a subspace **orthogonal** to the one carrying sensory data | A concrete broadcast mechanism that does not corrupt the sensory channel — the one mechanistic proposal here a builder can copy directly |

**(brainstorm)** The orthogonality result is the most transferable line in the review. A broadcast that shares a state variable with the representation being broadcast *over* will destroy it; putting the global mode in an orthogonal subspace is a population-geometry solution to a bandwidth-sharing problem ([[wiki/concepts/population-geometry.md]]) and is exactly what a wiki architecture with a shared bus lacks — every residual-stream broadcast in a transformer competes for the same directions as the content. Pairing it with the event-boundary result gives a specification with no wiki instance: *a slow, discretised, orthogonally coded global state that updates only at boundaries*.

**Ontogeny (tentative, speculative in the source).** Menon proposes the internal narrative originates in Vygotskian internalisation — self-directed private speech in early childhood becoming voiceless inner monologue. No developmental data is offered; it is offered as a research programme.

**What the review does not deliver.** No adjudication between its own two directional claims (salience network switches the default network off; default network has the largest net outflow, including *to* frontoparietal, even at rest) — [[wiki/empirical-tensions.md]] T257. No operational definition of "narrative" that would let the model fail. And the measurement obstacle it names is structural: internal mental processes cannot be probed without external stimuli, which alter the state being probed.

---

## Azarias et al. 2025 — the developmental layer, and ten hypotheses where there were two

> Azarias, Almeida, de Melo, Rici & Maria 2025, *The Journey of the Default Mode Network: Development, Function, and Impact on Mental Health*, Biology 14(4):395, doi:10.3390/biology14040395 (`raw/azarias-2025-default-mode-network-development.md`). **Grade it low.** A narrative literature review with no new data, no effect sizes anywhere, no meta-analytic pooling, and several garbled attributions (the self-construction hypothesis credited to Dennett, associative memory theory to "Levine and Tulving"). Its value to this wiki is not evidence but two things the higher-grade reviews above do not supply: an enumeration of *how many* mutually compatible function hypotheses the field is actually carrying, and a developmental/plasticity account of where the network's connectivity comes from.

**Ten function hypotheses, not two.** Buckner 2008 above frames the non-identification as mentation vs sentinel. The field's own claim set is wider, and the review lists it without adjudicating any of it:

| Hypothesis | Claimed function | Distinct from "construct a perspective other than the present"? |
|---|---|---|
| Sentinel | Broad low-level monitoring of the environment at rest | **Yes** — the one genuine rival |
| Internal mental activity / spontaneous cognition | Generate and manipulate internal thoughts when not externally engaged | No — the parent claim |
| Associative memory | Events stored with their relational neighbours; contextual cues reactivate the network | No — this is the *store* the constructor reads |
| Self-construction | Continuous re-evaluation of past experience into an identity/self-concept | No — perspective = self, tense = integrated over life |
| Social connection | Intention attribution, empathy, theory of mind | No — perspective = another agent |
| Autobiographical memory | Retrieval and consolidation of personal episodes | No — perspective = self, tense = past |
| Creative imagination | Association of disconnected concepts into novel combinations | No — unconstrained construction, no perspective anchor |
| Self-reflection | Introspection on one's own states | No — perspective = self, tense = present |
| Mental foresight | Simulate future events, recombining episodic elements | No — perspective = self, tense = future |
| Temporal coherence | Bind past/present/future into one continuous narrative | No — this is Menon's integrate-and-broadcast claim, stated 15 years earlier without a mechanism |

**(brainstorm) The table is a compression result.** Eight of the ten collapse onto one mechanism with two free parameters — *whose* perspective and *which* tense — which is exactly the parameterisation [[wiki/concepts/simulation-based-planning.md]] lacks, and it is now supported not by one review's synthesis but by the observation that the field independently named eight faculties that differ only in those two slots. The two that do not collapse are the sentinel (a different job entirely) and associative memory (the *store*, i.e. the medial temporal subsystem, not the constructor). This does not resolve the identification problem — ten hypotheses fitting one deactivation map is *worse* non-identification than two — but it changes what a discriminating experiment must do: separate a simulator from a monitor, then vary perspective and tense *within* the simulator.

**The connectivity is developmentally set, and stays plastic.** This is the layer the anchor reviews do not have. Every claim below is correlational and reported without effect sizes; the direction is what matters.

| Input | Reported effect on the network | Architectural reading |
|---|---|---|
| Childhood abuse, neglect, abandonment | Abnormal within-network functional connectivity — **hypo- *or* hyper-**, direction not predicted by the source | The set-point is written by developmental input statistics, and adversity moves it in either direction |
| Poverty / socioeconomic stress | Altered medial prefrontal ↔ posterior cingulate connectivity; self-regulation and memory affected | The *specific* edge altered is the constructor↔hub edge, not the store↔hub edge |
| Unstable family structure | Posterior cingulate ↔ precuneus **hyper**connectivity, read by the source as a stress adaptation | An adaptation, i.e. a set-point moved *by* a policy, not damage |
| Enriched environment, early-childhood education (incl. animal work) | Improved connectivity in regions tied to executive function and emotional processing | The set-point is trainable in the beneficial direction too |
| Chronic stress → cortisol | Inhibited oligodendrocyte proliferation and differentiation → **reduced myelin** → slowed, less reliable conduction; long-term white-matter integrity differences | A *developmental* route to changing conduction delays and integration timescales, distinct from any synaptic-weight change — see [[wiki/concepts/learnable-synaptic-delays.md]] |
| Mindfulness meditation (adults) | Reduced resting network activity; reorganised within-network connectivity | The set-point remains plastic after development, by explicit training |
| Cognitive-behavioural therapy, transcranial magnetic stimulation, EMDR (adults) | Normalised activity / reduced hyperconnectivity, tracking symptom improvement | Same, by external intervention |

**(brainstorm) What this does to `G90`.** The gap as logged asks for an arbitrator between an internal and an input-driven mode. This review says the arbitration variable is not a fixed constant of the architecture but a **trained set-point** with a developmental critical window and residual adult plasticity — and that its two failure directions are *quantitative settings of one variable* rather than missing machinery. That is a stronger specification than "add a switch": the component a builder needs is a mode-assignment gain with (i) its own slow learning signal, (ii) a distinct timescale from the fast switch it controls, and (iii) an observable pathology at each extreme. No wiki architecture has any control parameter that is itself learned on a slower schedule than the policy it gates, except the outer loop of [[wiki/concepts/meta-learning.md]] — which optimises the whole fast learner rather than a single arbitration gain, and has no analogue of a critical window.

**The failure directions, as this review reports them.** The clinical table is the reason to read the set-point as a scalar with two bad ends — but note it does not agree with the anchor review on schizophrenia:

| Condition | Direction reported here | Behavioural correlate |
|---|---|---|
| Depression, generalised anxiety, PTSD (re-experiencing) | **Stuck internal** — hyperconnectivity/hyperactivity, failure to deactivate under task | Rumination, excessive worry, perseverative negative thought; unhappiness correlates with mPFC/PCC/IPL hyperconnectivity in a *non-clinical* sample, scaling with rumination trait |
| ADHD | **Cannot hold internal** — hypoconnectivity of mPFC and PCC at rest, correlating with inattention and impulsivity severity | The source also reports DMN intrusion during task, i.e. failure of the switch in *both* directions |
| Schizophrenia | **Hypo**connectivity within the network (mPFC, PCC), and reduced dorsolateral-prefrontal↔PCC coupling tracking disorganisation | Directly opposed to Buckner 2008's three-study convergence on an *overactive*, more strongly inter-correlated network — [[wiki/empirical-tensions.md]] T258 |
| Alzheimer's disease | Reduced within-network connectivity, *increased* default↔executive-control connectivity, and reduced **temporal variability** of the network tracking cognitive impairment | The temporal-variability result is the one worth keeping: what degrades is the network's capacity to *change state*, not its mean level — [[wiki/concepts/dynamic-repertoire.md]] |
| PTSD (avoidance) | mPFC↔PCC **hypo**connectivity correlating with avoidance and re-experiencing | Same network, opposite sign to the anxiety row, within one diagnosis |

**States of consciousness, and an apparent conflict with the anchor review that is not one.** The review reports network activity *reduced* in sleep (notably REM), reduced under meditation, and *disorganised* under psychedelics with ego dissolution as the correlate. Buckner 2008 above uses the persistence of the network's low-frequency fluctuations in sleep and anaesthesia as an argument that the intrinsic signal is not the cognition. These are different measurements — correlation structure persisting vs activity level falling — and taken together they sharpen the anchor argument rather than contradicting it: **the coupling survives loss of consciousness while the drive does not**, which is what one expects if the anatomy is a standing bus and the mentation is traffic on it. The psychedelic result adds the only reported manipulation in which the *self* representation degrades in step with the network's organisation rather than its level.

---

## Satpute et al. 2026 — the network read as a *shape* rather than a function

> Satpute et al. 2026, *The default mode network in a hierarchical generative model of the brain*, Current Opinion in Behavioral Sciences 69:101656, doi:10.1016/j.cobeha.2026.101656 (`raw/satpute-2026-dmn-hierarchical-generative-model.md`). A theoretical review with **no new data**; its anatomy is inherited (Paquola et al. on laminar profiles of cortical networks, Barbas' structural model of cortico-cortical connections) and its architecture is an argument. Its move is to stop asking which psychological category the network maps onto and ask what its wiring *can compute* — which is the one strategy the four reviews above do not try.

**The diagnosis of why the function question is stuck is methodological, and it is the right one.** The competing accounts (social cognition vs emotion vs memory; self vs other; episodic vs semantic) are drawn from **incommensurate ontologies** — they are not rival answers to one question but answers phrased in currencies that cannot be exchanged, which is why the same node (anteromedial prefrontal cortex) is claimed by self-representation, fear and semantic processing at once. Adding parcellation grain does not help: finer parts make the synthesis problem worse unless the parts are described in a shared *neurocomputational* vocabulary. This is the same defect [[wiki/concepts/function-to-structure-inference.md]] names, one level up — not "which structure implements this function" but "the function labels do not form a space".

**The architectural claim: conductor, not commander.** Given as two rival readings of the same hierarchical position, with the second endorsed — see [[wiki/concepts/broadcast-hierarchy.md]] for the full treatment.

| | Chain of command | **Orchestra conductor** (endorsed) |
|---|---|---|
| Downward | sequential, layer by layer | **diffuse long-range output across multiple networks and laminar types simultaneously** |
| Upward | from the level immediately below | **selective — proportionally more input from high-level association cortex (eulaminate I) than from sensory areas** |
| Global model revision | `O(L)` relays | one act |

The supporting anatomy: the network is not more densely connected than other networks, it is **broader** in cross-network reach; and it is the only network whose laminar composition spans agranular, dysgranular *and* eulaminate I–III while containing **no koniocortex** — high hierarchical position (no primary sensory tissue) with unusually wide laminar coverage. For comparison, the visual network is dominated by koniocortex and eulaminate III, the frontoparietal network by eulaminate II and I.

| Global feature | Reported characteristic |
|---|---|
| Laminar profile | Mixed agranular / dysgranular / eulaminate I–III; less granular than most networks on average, and *more varied* than limbic cortex (largely agranular) |
| Connectivity | Selective input from mid-to-high association areas; broad, multilevel output |
| Neuron / neurite density | Lower than primary sensory — reduced local processing, enhanced integrative capacity |
| Myelination | Hypomyelinated relative to primary sensory and motor cortex → slower, temporally extended integration |
| Macroscale gradients | At or near the apex of structural and functional gradients, measured as distance from visual sensory input |

**Three axes of internal organisation** — offered as an anatomical alternative to fMRI-derived parcellations, whose membership varies with data quantity, fixed-vs-dynamic assignment, individual-vs-group level, task demand and mood:

| Axis | Content | Architectural reading |
|---|---|---|
| **Longitudinal (anterior–posterior)** | Posterior medial complex (precuneus, PCC, retrosplenial) is more connected to **visual cortex**, higher neuron density, more myelinated, faster, MEG alpha-dominant. Anterior medial complex (perigenual anterior cingulate, vm/am/dmPFC) is more connected to **subcortical autonomic structures (e.g. hypothalamus)**, lower density, hypomyelinated, slower, MEG delta/theta-dominant | The two ends face different data sources — high-dimensional exteroceptive input vs interoceptive/bodily state — and run at different integration timescales *by conduction physics*, not by a decay parameter |
| **Local hierarchical** | Each complex contains its own agranular→eulaminate III gradient: retrosplenial (agranular) → PCC (intermediate) → precuneus (Eu-III); perigenual anterior cingulate (agranular) → dmPFC / amPFC / vmPFC | Each complex is a *self-contained* generative model over its own nearby cortical and subcortical targets — the apex is recursive, not flat |
| **Layered communication** | Barbas' **laminar type rule**: areas preferentially connect to areas of similar laminar profile. Applied within the network, anterior and posterior complexes exchange **level-matched and in parallel**, not through a single serial pathway — a **heterarchy** | Coupling eligibility is set by a property of the endpoints' own internal structure; no wiki architecture types edges this way |

**What the three axes are for.** The prediction is that the fMRI literature's disagreement about how many default networks there are is a **projection artefact**: a task that emphasises one axis yields a partition along that axis, and the resulting "networks" are configurations rather than parts. Person-specific interdigitated networks (DMNa/DMNb) are attributed, speculatively, to individual variation in laminar organisation. This is a testable reframe of [[wiki/concepts/node-definition-problem.md]] as applied to this network — the parts are not being mis-drawn, they are being drawn on a system with more than one legitimate decomposition.

**The function, restated in one variable: depth of update.** Most of the time the immediate past predicts the present well and only local adjustments are needed — the network is on **autopilot**, holding the global model steady. When the immediate past predicts badly, a **global** revision is required, sourced from *endogenous* prior knowledge rather than from the input. The listed triggers — scene changes in film (time, place or goal shifts), goal changes (thermoregulatory → metabolic), switching which agent is being modelled, affective state changes — are all [[wiki/concepts/event-segmentation.md]] boundaries. The heterogeneity of the domains (memory, social cognition, semantics, emotion, arousal) then reduces to one claim: they are the domains in which a large model revision is frequently required.

**Precuneus.** Treated here as a full member — the eulaminate III end of the posterior medial complex's local laminar gradient — with Table 2 assigning it neurite density, myelination and non-DMN connectivity values alongside PCC and retrosplenial. Against the anchor review's provisional exclusion; added to [[wiki/empirical-tensions.md]] T256 Position A.

**What it does not deliver.** No data. The layered-communication axis — the one that carries the heterarchy claim — is conceded to be untestable with current methods, since parsing laminar types in a way that informs task fMRI is still developing. The autopilot/global-update distinction has no threshold, so "poorly predicted by the immediate past" is not yet a measurable condition. And the source simultaneously places the network at the **apex** of macroscale gradients and denies it a chain-of-command position, without measuring both on one graph.

**The methodological demand it makes on everyone else** is worth recording because it applies to the wiki's benchmark habits: if psychological categories are *products* of generative processes, then (i) predictions are not separable from the mental phenomena they constitute, (ii) predictions are trained in naturalistic multisensory environments and stripped-down laboratory tasks may not engage their dynamics at all, and (iii) prediction and prediction error depend on skeletomotor and visceromotor activity, so action is not downstream of the generative model but inside it.

---

## Raichle et al. 2001 — the founding measurement, and what its primary tables actually support

> Raichle, MacLeod, Snyder, Powers, Gusnard & Shulman 2001, *A default mode of brain function*, PNAS 98(2):676–682, doi:10.1073/pnas.98.2.676 (`raw/raichle-2001-default-mode-brain-function.md`). The paper that named the default mode, ingested here *after* the reviews that cite it. Primary quantitative positron-emission tomography: two independent groups of 19 awake adults at eyes-closed rest on two different scanners (blood flow, blood volume, oxygen extraction fraction, oxygen metabolic rate), plus 11 adults compared between eyes-closed rest and passive visual fixation. Regions of interest were taken verbatim from Shulman et al. 1997's deactivation meta-analysis — the map above is inherited, not produced here.

**What the paper contributed was not the map but a licence to read it.** Its target is the objection that any control state is just another task state, which makes every reported "deactivation" re-describable as a hidden activation in the control. The move — define the zero from a within-condition physiological equilibrium rather than from a subtraction — is treated in full at [[wiki/concepts/activity-baseline.md]]. Three results from it that belong on this page:

| Result | Numbers | Consequence for this network |
|---|---|---|
| The task-decrease regions are **at** baseline during eyes-closed rest, not covertly activated | Oxygen extraction fraction ratios 0.98–1.04 (all n.s.) in both groups for medial 31/7, left 39/19, right 40; regional pattern replicating across groups at `r = 0.89` | The deactivations are decreases from a true zero. This is the paper the network's existence claim rests on |
| **Tonic metabolic level is orthogonal to engagement state** | Medial 31/7 (posterior cingulate/precuneus) at **1.374×** global blood flow and **1.397×** global oxygen consumption *while at baseline*; medial 10 likewise; left 39/19 at 0.81× and left 9 also below, also at baseline | The network's signature high resting metabolism does **not** by itself mean the network is doing something at rest — a claim four of this page's five sources make and none of them separates from the equilibrium |
| The choice of passive control does not manufacture the map | Eyes-closed rest vs passive fixation (n=11, five paired measurements): no significant blood-flow change in any of the four regions | Rules out the cheapest artefact explanation for the deactivations, in the two controls the literature actually uses |

**The one region whose baseline is *not* rest.** The whole-brain search for deviations found no activations anywhere and only four deactivations per group, all but one in bilateral extrastriate visual cortex (Brodmann 18/19, oxygen extraction ratios 1.145–1.217; area 11 in right gyrus rectus at 1.491 in group I only, unreplicated). Blood flow there rises on eye opening. So **eyes-closed rest sits below baseline for visual cortex** — a region's zero is its ecologically ordinary condition, not its no-input condition, which is a caveat for every eyes-closed resting-state dataset in the wave-12 sources.

**The sentinel hypothesis in its original form**, stated here before the mentation account existed: posterior cingulate + precuneus as continuous, unrequested monitoring (peripheral-field dorsal-stream connectivity, task-irrelevant responses to large textured stimuli, Balint's simultanagnosia after medial parietal damage, restoration of parietal metabolism heralding recovery of external awareness from vegetative state), and medial prefrontal cortex as the evaluator of what the monitor returns (wide-band bodily and environmental input, dense limbic/autonomic interconnection, reward/non-reward coding in orbital and medial prefrontal neurons). The William James "sentinels" quotation is the argument's core: broad monitoring must run *uncalled*, because a call presupposes something that already noticed.

**The cost, and where it is paid.** Posterior cingulate and precuneus are selectively vulnerable in carbon-monoxide poisoning, diffuse ischaemia and Alzheimer's disease. The standard account is vascular (arterial watershed), and this paper adds the suggestion that the exceptionally high tonic rate is itself the risk factor — the component that runs continuously at ~40% above the mean fails first when supply drops. That puts the Alzheimer's row of the clinical table above on a *metabolic* footing independent of the amyloid argument.

**Where the anchor review's critique lands.** Buckner et al. 2008 above argue the absolute-baseline claim does not survive inspection, and the primary tables agree: left area 40 sits at 0.90 of the hemisphere mean in **both** groups (p = 0.07 and 0.04), a replicated ~10% decrease that survives only the multiple-comparison correction, and global oxygen extraction differs between the two groups (0.40 vs 0.30) on the same protocol with different scanners. The invariant is spatial and within-session, not absolute — [[wiki/empirical-tensions.md]] T260. What survives regardless is the strategy and the two dissociations, neither of which needs the invariant to be exact.

---

## Relevance to a reasoning model

- **A default mode is a resource-allocation policy, not a resting state.** The network's activity is a *default*: what the machine does with a moment when no input demands it. The paper's closing proposal is that this budget is spent constructing, replaying and exploring event scenarios in order to derive expectations about the future — which puts it in direct competition with [[wiki/concepts/offline-replay.md]]'s use of the same idle period for consolidation, and with [[wiki/concepts/default-self-model.md]]'s use of it for competence self-assessment. Three literatures, one budget, no arbitration rule anywhere in the wiki.
- **Task generality is the finding to copy.** Remembering, prospecting, mentalizing and moral evaluation are studied as separate faculties and share one substrate. If a single mechanism — construct an alternative perspective to the present, constrained by stored episodes — covers all four, then the corresponding machine component is *one* simulator with a parameterised perspective (whose? when? counterfactual or actual?), not four modules. The wiki's [[wiki/concepts/simulation-based-planning.md]] has the roll-forward but no perspective parameter and no social case.
- **The mode switch is fast and it is a switch.** Event-related deactivation within seconds, plus anticorrelation, plus measured attenuation of sensory-evoked responses in strong-default individuals: internal generation and external processing trade off on a timescale a system could actually control. Logged as [[wiki/architectural-gaps.md]] `G90`.
- **The rodent mechanism the review points at is the only causal-grade one in it.** Hippocampal place-cell ensembles sweep ahead of the animal at high-cost choice points, first down one arm then the other (~10% of time at the choice point), and sweep back down the correct path after errors — a concrete implementation of "simulate the alternatives before committing" that the human imaging cannot supply. See [[wiki/concepts/offline-replay.md]].
- **Content comes from elsewhere.** The network excludes sensory cortex, yet imagined episodes have modality-specific content — visual and auditory cortex activate for the recall of objects and sounds, the amygdala for emotionally charged futures. The proposal (Hassabis & Maguire's "scene construction") is that the network's job is to *retrieve and integrate components stored in modality-specific areas into a coherent spatial context*, which makes the default network a **binder over frozen modality stores**, not a store itself.

---

## Open problems

| Problem | Why it is open |
|---|---|
| **No lesion study has ever been designed against this network** | The authors state it directly: unlike every other brain system, this one was characterised entirely by correlational imaging, with no neurological syndrome initiating its study and no behavioural probe motivated by its anatomy. Nothing here is causal. **Partly answered since** (Menon 2023): left angular gyrus lesions reduce mind wandering, and rodent optogenetics can drive the switch — one node and one non-human preparation, not a lesion programme |
| **The two directional claims are not reconciled** | The salience network is said to *cause* default-mode suppression, while the default network is said to have the greatest net causal outflow of any network, at rest and during memory formation, including to frontoparietal cortex. Both estimates come from fitted models on observational data ([[wiki/empirical-tensions.md]] T257) |
| **Which grain the network is** | Node-level meta-analyses give nine nodes nine different preferential functions, and the posterior medial cortex fractionates into dorsal-PCC / ventral-PCC / RSC subnetworks with distinct control-network couplings — so "the default mode network" may name a family of systems sharing convergence zones rather than one system ([[wiki/concepts/node-definition-problem.md]]) |
| Mentation vs sentinel is not identified | Passive tasks move mental content and attentional breadth together; no experiment reported here breaks the confound — and the confound is wider than two-way: the field carries **ten** function hypotheses over the same map, eight of which are one mechanism at different perspective/tense settings (Azarias et al. 2025) |
| **Where the network's connectivity comes from is a separate question from what it does, and only the first has a developmental answer** | Adversity, poverty, family instability and enriched environments all move within-network connectivity, in directions the source cannot predict a priori (hypo *and* hyper both reported for adversity); cortisol-driven hypomyelination gives a route that changes conduction rather than coupling; and meditation/CBT/TMS move it back in adults. Nothing in this literature states what the set-point is a set-point *of*, so "altered DMN connectivity" is currently a finding with no forward prediction (Azarias et al. 2025) |
| Clinical direction is not stable across reviews | Schizophrenia is over-engaged and hyper-correlated in Buckner 2008 and hypoconnected in Azarias et al. 2025; PTSD is hyperactive on re-experiencing and hypoconnected on avoidance within one source ([[wiki/empirical-tensions.md]] T258) |
| Whether the intrinsic low-frequency signal is the cognition | It persists in sleep, anaesthesia and primary sensory cortex, and is too slow for cognitive events — so the correlation between default activity and mind-wandering may hold at a different frequency band than the one being measured |
| What controls the switch | Local competition vs a frontoparietal arbitrator is unresolved, and the only evidence for the arbitrator was preliminary at the time of writing |
| Anticorrelation may be partly manufactured | Global-signal normalisation centres correlations at zero and forces negatives; the effect's magnitude without it is unknown |
| Precuneus membership | Connectional anatomy says area 7m is not a member; the structural-core literature ranks precuneus among the highest-degree cortical nodes ([[wiki/empirical-tensions.md]] T256) |
| Boundaries are approximate | Every region in the anatomy table spans multiple architectonic areas with uncertain borders, and LTC is the authors' own most tentative estimate |
| **Whether the function question is even well-posed** | The competing accounts are drawn from incommensurate ontologies (psychological domain, within-domain contrast, unifying construct), so they are not rival answers in one currency; and refining the parcellation makes synthesis harder rather than easier unless the parts get a shared neurocomputational description. Satpute et al. 2026's proposal — describe the parts by what their anatomy can compute — is untested |
| **Is the network at the apex, or off the chain?** | Satpute et al. 2026 assert both: at or near the apex of macroscale structural and functional gradients (by distance from sensory input), *and* not in a chain-of-command hierarchy at all (diffuse multilevel output, selective high-level input, laminar-type-matched lateral exchange). Nothing measures hierarchical position and connection type on the same graph ([[wiki/concepts/broadcast-hierarchy.md]]) |
| **The heterarchy claim rests on the one axis that cannot currently be tested** | The layered communication axis needs laminar-type parsing that informs task fMRI, which the source concedes does not yet exist; the anterior–posterior and local-hierarchical axes have functional dissociations, this one has none |

---

## Connections

- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — supplies the structural half of this page's hub claim (every posterior default component is in the cortical structural core, medial prefrontal cortex is the sole exclusion) and takes the one disagreement: precuneus is a top-ranked core member there and a provisional non-member here.
- **[[wiki/concepts/default-self-model.md]]** — the dorsomedial prefrontal subsystem is the constructor whose self-referential output that page says is signed-inflated and calibrated by a *different* region, so the two pages describe the same idle-time process from the anatomy side and the failure-mode side.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — this page splits the human medial wall by *network role* (dorsal = self-referential constructor, ventral = shared hub) where that page splits the rat medial wall by output port, and the two axes have not been reconciled.
- **[[wiki/concepts/simulation-based-planning.md]]** — the internal-mentation hypothesis makes this network the biological simulator, and adds the parameter machine planners lack: whose perspective and which tense the roll-forward is run from, with remembering, prospecting and mentalizing as settings of one mechanism.
- **[[wiki/concepts/offline-replay.md]]** — both claim the same idle budget, and this page supplies the review's only causal-grade mechanism for it: hippocampal forward sweeps down each arm at a choice point, plus corrective sweeps after errors.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the default network is the wiki's largest instance of a system named for a function that its own experimental design cannot identify, with the mentation/sentinel confound as the concrete failure.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the medial temporal subsystem is the episodic store supplying building blocks to a neocortical constructor, which is the CLS division of labour appearing at rest rather than during consolidation.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the medial-temporal↔prefrontal edge documented there is the one this network routes *indirectly*, through PCC/Rsp and vMPFC hubs, since the two subsystem heads are anticorrelated and not directly coupled.
- **[[wiki/concepts/integration-segregation-balance.md]]** — anticorrelation between the default and dorsal attention systems is a segregation event with a specific pair of participants, and the missing arbitrator is the same control variable that page says nothing here reads or sets.
- **[[wiki/concepts/parallel-timescale-streams.md]]** — the default mode is one letter of that page's 126-mask alphabet, and its co-activation with dorsal attention and frontoparietal masks among the most frequent states qualifies the strict anticorrelation reported here.
- **[[wiki/concepts/cognitive-control.md]]** — the open question this page hands to the control layer: whether a separate controller assigns the network or the two modes settle it locally, with autism (under-use) and schizophrenia (over-use) as the two failure directions of one setting.
- **[[wiki/entities/salience-network.md]]** — the field's candidate answer to this page's arbitration question: a third system (anterior insula + dorsal anterior cingulate) whose salience detection is claimed to switch this network off and the frontoparietal one on by one mechanism, and which also supplies the intracranial-EEG evidence that the deactivation is neuronal.
- **[[wiki/concepts/event-segmentation.md]]** — this network carries the boundary code: posterior cingulate patterns persist through a naturalistic stream and change at perceived boundaries, and the same code generalises to *internally* generated boundaries during unguided recall, which is the wiki's only evidence that one segmenter serves perceived and imagined streams alike.
- **[[wiki/concepts/population-geometry.md]]** — the review's one copyable broadcast mechanism is geometric: a global fluctuation mode reaching every area within ~1 s in a subspace *orthogonal* to the one carrying sensory data, so broadcasting costs no sensory bandwidth.
- **[[wiki/concepts/learnable-synaptic-delays.md]]** — the developmental route into that page's parameter: chronic childhood cortisol inhibits oligodendrocyte proliferation and differentiation, so conduction delay and integration timescale are altered by *myelination* rather than by any synaptic weight, on a schedule set by the environment.
- **[[wiki/concepts/dynamic-repertoire.md]]** — the Alzheimer's finding that survives translation: what degrades with cognitive impairment is the network's **temporal variability**, i.e. its capacity to change state, not its mean activation level.
- **[[wiki/concepts/meta-learning.md]]** — the only wiki machinery with a control parameter learned on a slower schedule than the policy it gates, and therefore the nearest thing to the developmentally trained arbitration set-point this page now requires — but it optimises the whole fast learner rather than a single gain, and has no critical window.
- **[[wiki/concepts/broadcast-hierarchy.md]]** — the shape this network is the wiki's evidence for: selective input from high-level association cortex, diffuse output across many networks and laminar types, so a global model revision costs one hop rather than `L` relays — and the laminar-type rule that turns its internal "levels" into a heterarchy.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the anatomy that implements it here: fewer, less dense, hypomyelinated units with convergent input and long integration windows recode high-dimensional input into the low-dimensional priors this network broadcasts — lossily, into approximations sufficient for action rather than reconstructions.
- **[[wiki/concepts/node-definition-problem.md]]** — the precuneus dispute is that problem in its most consequential form: whether a canonical network has a member depends on whether "precuneus" names area 7m or a region that includes areas 29/30.
- **[[wiki/concepts/activity-baseline.md]]** — the founding argument that licenses this whole page: the deactivations are decreases from a physiologically defined zero rather than returns from an unnoticed activation, established by the spatial uniformity of the oxygen extraction fraction — together with the dissociation that undercuts the network's high-resting-metabolism claim, since posterior cingulate runs ~40% above the global mean *while at baseline*.
