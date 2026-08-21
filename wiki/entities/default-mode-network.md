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

## Gusnard et al. 2001 — the default mode is not one knob: two medial prefrontal tiers moving on two different variables

> Gusnard, Akbudak, Shulman & Raichle 2001, *Medial prefrontal cortex and self-referential mental activity: relation to a default mode of brain function*, PNAS 98(7):4259–4264, doi:10.1073/pnas.071043098 (`raw/gusnard-2001-mpfc-self-referential-default-mode.md`). The companion paper to Raichle et al. 2001 above, from the same group and the same issue-year. Primary blocked fMRI, n = 24 (12 M / 12 F, ages 20–35), 1.5 T, 12 runs over 2.25 h. Two judgments on the same International Affective Picture System photographs: **internally cued** (pleasant vs unpleasant — *how does this make me feel*) and **externally cued** (indoors vs outdoors — *what does the picture show*), each alternating in 36 s blocks against **visual fixation**. The design's whole point is the third condition: the prior PET study (Lane et al.) contrasted only the two tasks against each other and could therefore not tell an increase from a smaller decrease.

**Three contrasts, three different answers, in one anterior-midline strip running BA 6/32 → BA 24/25/32:**

| Locus | Contrast pattern | Reading |
|---|---|---|
| **BA 6/32** (dorsal anterior cingulate + pre-SMA/SMA) | Increase vs fixation in **both** tasks, equally (Z = 6.63 ICC, 6.92 ECC; interaction Z = 1.43, n.s.) | Motor execution + attentional demand — common to any keypress task, not default-mode content |
| **Dorsal–mid medial BA 8, 9, 10** | Increase specific to the internally cued task (ICC > ECC), with only limited adjacent anterior cingulate involvement | The self-referential constructor. Reaction times were **matched** (1.14 s vs 1.12 s, p = 0.36), so this is not time-on-task |
| **Ventral BA 24/25/32** | **Decrease** vs fixation in **both** tasks; no significant ICC/ECC difference (visual inspection suggests a smaller decrease in ICC, with greater between-subject variance there) | Attenuated by attentional demand regardless of content |

**The architectural claim, which is what the wiki wants from this paper: default-mode suppression is at least two control variables, not one gain.** The ventral tier tracks *attentional demand* — one-signed, content-blind, down under any task. The dorsal tier tracks *where attention is pointed* — up when the target of processing is the self, down under externally directed load (the paper's citation of the stimulus-independent-thought literature: BA 8/9/10 activity correlates with the number of reported stimulus-independent thoughts, is highest at rest, and falls as externally directed cognitive load rises). A machine that models the internal/external switch as a single scalar cannot produce this pattern: it needs an **orientation** parameter separate from a **load** parameter, because the two tiers dissociate on the same trials.

**The dorsal tier has a bidirectional dynamic range around its own baseline** — increases here and in a mood-induction study, decreases in the large Shulman meta-analysis, both from a *passive* baseline. Logged as [[wiki/empirical-tensions.md]] T261. The paper's own resolution is that the sign is set by task content rather than being a property of the region, which is a different statement from "this region deactivates".

**The measured instance of the control-state artefact.** One mid-medial-prefrontal focus appeared as an *increase* in the ICC > ECC contrast — and the three-way breakdown shows ICC did not differ from fixation at all while ECC *decreased* from it. The apparent activation is entirely the control task's deactivation. This is the confound Raichle et al. 2001 argue about, caught in primary data on the same subjects, and it is the concrete reason the authors insist that "what others report as an increase should on occasion more properly be regarded as a decrease". Treated as a method result at [[wiki/concepts/activity-baseline.md]].

**What the ventral tier is claimed to compute**, on anatomy rather than on this experiment: wide-band sensory input from body and environment via orbital prefrontal cortex, dense interconnection with amygdala, ventral striatum, hypothalamus, periaqueductal grey and brainstem autonomic nuclei → integration of visceromotor emotional processing with internal and external state, i.e. **salience/valence evaluation running by default unless attenuated**. Its behavioural corollary, and the paper's only converging non-imaging evidence: cognitive activity attenuates the experience and expression of distress. This is the same assignment [[wiki/concepts/activity-baseline.md]] carries from the companion paper's sentinel argument — the monitor is posterior, the evaluator is ventral medial prefrontal.

**The dorsal tier's function claim, in the form the wiki can use.** The authors adopt Ingvar's proposal that spontaneous resting activity is not noise but a continuous **"simulation of behaviour"** — inner rehearsal and optimization of cognitive and behavioural serial programs for the individual's future — and add that dorsal medial prefrontal cortex processes representations embodying the temporally extended *narrative* or *autobiographical* self (awareness of a personal past, present and future). Non-imaging support offered: lesion studies of dorsal medial prefrontal cortex and its connections. Note the direction of the argument — the self is inferred from the region rather than measured, so this is a hypothesis attached to a replicated contrast, not a result.

**Outside the medial wall**, replicating Lane et al.: frontal operculum/left insula and right insula for ICC > ECC (−43, 21, −6, Z = 4.44; 37, 21, −2, Z = 3.43), right cerebellum (25, −75, −30, Z = 3.59); bilateral parieto-occipital cortex for ECC > ICC (39, −77, 22, Z = 3.45; −31, −79, 32, Z = 3.25). The right temporal pole reported by Lane et al. did **not** replicate.

**Limits.** Blocked design, 1.5 T, 8 mm slices; the dorsal/ventral grouping is the authors' own coarse binning and they state it "may blur subtle functional distinctions"; the ventral decrease does not differ statistically between tasks, so the individual-variability story is offered from visual inspection and unpublished single-subject data; and the self-referential manipulation confounds *self-reference* with *affective* judgment — every ICC trial is an emotion report, so nothing here separates "about me" from "about my feelings".

---

## Gao et al. 2013 — the membership list is state-dependent, and it fractionates by *behaviour* rather than by anatomy

> Gao, Gilmore, Alcauter & Lin 2013, *The dynamic reorganization of the default-mode network during a visual classification task*, Front Syst Neurosci 7:34, doi:10.3389/fnsys.2013.00034 (`raw/gao-2013-default-mode-network-visual-task.md`). A primary experiment: 19 adults (16 with all four usable runs), four 5 min steady-state functional-connectivity MRI runs in fixed order — pre-task rest `R1`, relaxed-pace task `T1`, speeded task `T2` (order of `T1`/`T2` counterbalanced), post-task rest `R2`. Task: classify the global or the local letter (H vs S) of a hierarchical letter figure overlaid on a scenic photograph, self-paced continuous, congruent and incongruent trials. Seed-based analysis from a posterior cingulate seed (MNI 0, −53, 26; 8 mm radius) cross-checked against group independent component analysis; spatial correlation between the two methods' maps 0.71 / 0.54 / 0.50 / 0.68 for `R1`/`T1`/`T2`/`R2`. **Grade it as a small-`N` primary result with an unusually clean internal control** (two independent pipelines recovering the same partition, and a within-subject return-to-baseline), and see the limits below before using the correlation coefficients.

Every other source on this page treats the network as a fixed region list whose *activity* or *within-network coupling* is modulated. This experiment asks the prior question — **which regions are in it right now** — and the answer is that one third of the map changes with brain state, in both directions, reversibly.

**The three-way partition, recovered by a repeated-measures ANOVA over the union of the four states' significant maps:**

| Class | Regions | `R1` → `T1` → `T2` → `R2` | Reading |
|---|---|---|---|
| **Stable core** | Posterior cingulate, medial prefrontal, bilateral inferior parietal lobule, bilateral lateral temporal cortex | Significant in all four maps, no significant change in any comparison; within-class coupling high and flat | The invariant part — and the class that persists in anaesthesia and sleep on this page's earlier evidence |
| **Disengaging periphery** | **Precuneus**, bilateral **angular gyrus**, cerebellar **vermis** | Mean coupling to the core `0.43 ± 0.047` → `0.35 ± 0.034` (`p = 0.02`) → `0.24 ± 0.041` (`p = 0.0058`) → `0.45 ± 0.042` (`p = 0.0026`) | Members at rest, non-members under load, members again afterwards |
| **Recruited outsiders** | Bilateral insula / inferior frontal cortex, anterior cingulate, middle cingulate — i.e. the **salience network** plus its cingulate extension | `0.05 ± 0.028` → `0.30 ± 0.037` (`p < 0.001`) → `0.34 ± 0.035` (n.s.) → `0.03 ± 0.028` (`p < 0.001`) | Not members at rest (coupling ≈ 0, several pairs negative), full members under load |

Three properties of this partition matter more than the region lists:

- **Reversible and demand-graded.** `R1` vs `R2` differ on *no* measure tested; and the deeper demand (`T2`, speeded) pushes both directions further than the shallow one (`T1`), significantly so for the disengaging class. So this is a dial with a rest set-point, not a task-vs-rest dichotomy.
- **Not a seed artefact.** The same pattern holds between each of the five other stable regions and both changing classes, and between the changing classes and each other — so it is network-level behaviour, not a property of the posterior cingulate seed. The one partial exception is bilateral inferior parietal lobule, which changes least with the spatially adjacent angular gyrus/precuneus (8 mm smoothing kernel; adjacency is a plausible confound).
- **The within-class coupling of the changing classes moves too.** Coupling *among* the disengaging regions falls with task and coupling *among* the recruited regions rises, while the stable core's internal coupling stays flat.

**The double dissociation, which is the transferable result.** Signed change in system-level coupling from rest to task, correlated across subjects (`N = 19`) with the two performance measures:

| Predictor | Reaction time | Accuracy |
|---|---|---|
| Δ coupling (core ↔ **disengaging**) | `r = 0.60` (`T1`, `p = 0.0064`, bootstrap CI `[0.29, 0.79]`); `r = 0.57` (`T2`, `p = 0.01`, CI `[0.16, 0.80]`) — deeper desynchronization → **faster** | none |
| Δ coupling (core ↔ **recruited**) | none | `r = 0.49` (`T1`, `p = 0.03`, CI `[0.07, 0.85]`); `r = 0.59` (`T2`, `p = 0.0082`, CI `[0.27, 0.79]`) — more integration → **more accurate** |
| Δ coupling *within* any class | none | none |

Two components of one reconfiguration, each predicting a different behavioural quantity, with the crossed cells empty and the within-class cells empty. **(brainstorm)** That is the strongest argument in the wave-12 default-mode material for treating disengagement and recruitment as **two separately controlled operations rather than one mode switch**: an architecture that implements "suppress the internal mode" as a single gain gets the speed effect and cannot get the accuracy effect, because the accuracy effect is carried by edges to regions that were not in the network to begin with. The pair maps cleanly onto [[wiki/concepts/integration-segregation-balance.md]]'s decomposition — releasing bandwidth (speed) and acquiring bandwidth (throughput on the harder decision) are different edges of the same budget.

**What this does to the "network with a function" framing.** The authors' own inferential move is worth flagging because it is the weak joint: they *assume* the resting topology is the true network and the task topology is transient coupling, then label the changes accordingly. Reverse the assumption and the same data read as a task network that sheds nodes at rest. Nothing in the design breaks the symmetry — see [[wiki/concepts/node-definition-problem.md]], for which this is the temporal case: the vertex set is fixed by a state, and the state is chosen by the experimenter.

**Limits.**

| Limit | Consequence |
|---|---|
| `N = 19` for correlations of `r ≈ 0.5–0.6` | Brain–behaviour correlations at this sample size are the canonical inflated-effect regime; the bootstrap CIs are resampled from the same 19 subjects and cannot correct for it. Treat the *dissociation pattern* as the finding and the coefficients as unusable point estimates |
| Fixed run order (`R1` first, `R2` last) | Rest→task→rest is confounded with time in scanner and with practice; the `R1 = R2` null is the only control, and three subjects were dropped from `R2` for motion |
| Global signal regression | Repeating without it shifts all values positive but leaves the state-dynamics unchanged (authors' check) — so the *changes* survive, the absolute signs at rest (negative core↔salience coupling) do not |
| Signal-to-noise ratio changes with state | Could inflate or deflate correlations; the authors' defence is that the same stable regions show *both* increases and decreases in the same state shift, which a uniform SNR change cannot produce |
| One task, one network | The recruited set is salience/cingulate because this task demands conflict monitoring and self-paced control; a different task should recruit a different set, and the paper cites a working-memory study with the *opposite* sign (Sala-Llonch et al.: default↔working-memory coupling becomes more negative with task, and more negative predicts better performance) — [[wiki/empirical-tensions.md]] T262 |

---

## Tripathi et al. 2025 — the anticorrelation as a graded, phase-reversing, trainable variable

> Tripathi, Batta, Zamani, Atad, Sheth, Zhang, Wager, Whitfield-Gabrieli, Uddin, Prakash & Bauer 2025, *Default mode network functional connectivity as a transdiagnostic biomarker of cognitive function*, Biol Psychiatry Cogn Neurosci Neuroimaging 10(4):359–368, doi:10.1016/j.bpsc.2024.12.016 (`raw/tripathi-2025-dmn-connectivity-biomarker.md`). A narrative review with **no new data** except one illustrative HCP connectivity matrix; it reports no effect sizes and sources its edge-level claims to supplementary tables of prior studies. Grade every row below as *direction of an effect reported by others*, not as a measurement. Its value to this page is that it is the only source here that treats **DMN–FPN coupling as a scalar with a value**, and asks what that value predicts across states, ages and diagnoses.

**The strict double dissociation is dead, and what replaces it is sign-reversal within a task.** Earlier sources on this page treat the default/frontoparietal relation as fixed-sign competition. The review's own summary of the newer literature:

| Regime | DMN ↔ FPN coupling | Source class |
|---|---|---|
| Sustained-attention task, between-subject | Negative; **stronger negativity → less variable reaction time** on a flanker task, replicated in a large population dataset with fewer reported attention problems | Two studies, one a direct replication |
| Goal-directed self-generated thought, semantic processing, episodic retrieval, scene construction | **Positive / co-activated**; FPN tracks trial-to-trial difficulty in internal-mentation paradigms; parts of the DMN are recruited during task switching | Task fMRI, several labs |
| Creative **idea generation** (bottom-up) | Negative | Creativity fMRI |
| Creative **idea evaluation** | Correlation *increases* — the two systems cooperate to filter candidates | Same paradigm, later phase |

**(brainstorm) This is the wiki's only biological measurement of a proposer/verifier pair whose coupling sign is itself the controlled variable.** [[wiki/concepts/refinement-loop.md]] holds that every 2025 ARC result is one exploration phase plus one verification phase, and treats the two as stages of one program. Here the same two-phase structure appears as *two different network configurations of the same two systems*, switching sign within a single creative act. An architecture that hard-wires "generator feeds verifier" implements the evaluation phase only; the generation phase is measured to require the verifier **decoupled**, which is exactly what a fixed critic-in-the-loop cannot provide. It also predicts a failure mode: a system whose critic is always coupled should show reduced diversity of candidates, not reduced quality of filtering.

**Neither network is sufficient, and the predictive signature is whole-brain.** Connectome-based predictive modelling of sustained attention and of mind-wandering loads on visual, cerebellar, motor, somatomotor, dorsal- and ventral-attention networks alongside DMN and FPN — so "DMN vs FPN" is a two-node summary of a many-node signature, and a mode variable defined on that pair is under-specified. DMN anticorrelations were, separately, highly predictive of *within-subject* variation in mind wandering.

**Trait level: one shared direction across unrelated pathologies.**

| Condition | Reported DMN connectivity change | Common form |
|---|---|---|
| Healthy aging | Within-DMN FC **decreases**; DMN–DAN FC **increases** | Loss of segregation |
| ADHD | Reduced PCC↔ACC anticorrelation; DMN "intrusion" into cognitive-control operation → attentional lapses | Failure to hold the network off |
| Major depression | Increased intra- *and* inter-network FC; anticorrelation with sensory/attention networks replaced by abnormally **positive** correlation; same for CEN/FPN; salience network spatially **expands and shrinks the DMN** | Failure to hold the network off, plus a topographic change |
| Schizophrenia | Increased mPFC↔PCC coupling; increased DMN↔insula; insufficient deactivation in target detection; impaired cognition tracks inefficient DMN suppression; hypothesised mPFC↔superior temporal gyrus increase → source misattribution of self-generated audition | Failure to suppress, and a boundary failure between generated and perceived |
| Parkinson's | Within-DMN FC **negatively** correlated with cognitive composite scores; less DMN deactivation during executive tasks | Failure to suppress |
| Alzheimer's | DMN FC decreased (PCC, precuneus); DMN–SAL increased; DMN–DAN anticorrelation decreased; DMN–FPN mixed | Loss of the anticorrelation |
| Autism | Children: increased within-DMN FC; adolescents/adults: decreased; mixed-age samples: both — developmental sign flip | Direction not fixed |

The review's own reading is the one this page has been converging on from the other side: the shared deficit is **reduced control over intrinsic activity and reduced ability to switch between extrinsic and intrinsic modes**, with the pathophysiologies distinct. That is `G90`'s arbitration variable observed to fail in six unrelated ways — which raises the possibility that it is one variable, and lowers the diagnostic value of any single measurement of it (the authors concede the transdiagnostic convergence means DMN FC "cannot parse disorder-specific patterns" as it stands).

**The set-point is trainable in adults.** Meditation moves it as a *state* (reduced DMN node activity during practice, beyond task-induced deactivation; altered within-DMN FC) and as a *trait* (reduced DMN activity at rest in experienced practitioners; increased PCC↔dlPFC FC at rest and during practice; increased DMN–FPN anticorrelation following practice, associated with better sustained-attention performance; stronger DAN–DMN anticorrelation in experienced meditators). The within-DMN direction is inconsistent across studies (decreases and increases both reported); the cross-network direction is not. **(brainstorm)** Read alongside Azarias et al. 2025's developmental writing of the same set-point, this makes the arbitration gain a parameter with a *slow, experience-driven learning signal in both childhood and adulthood* — which is what [[wiki/concepts/meta-learning.md]]'s outer loop would be if it optimised one gain rather than the whole fast learner.

**Three measurement facts that bound everything above.**

| Fact | Consequence |
|---|---|
| Up to **62% of the variance in simulated group-level FC network matrices is explained by cross-subject spatial variation** in where the networks sit (Bijsterbosch et al. 2018) | A group-level DMN FC biomarker is majority topography. The fix is precision fMRI per subject, whose barrier is scan time — see [[wiki/concepts/node-definition-problem.md]] |
| Global signal regression changes anticorrelation estimates, and the review declines to call the result an artefact: the global signal is a **composite of neural and non-neural sources**, removal increases anticorrelations "by virtue of mean centering", and a TMS meta-analysis found subgenual-ACC FC↔treatment-response associations driven specifically by patients with large global-signal fluctuations | The anticorrelation caveat carried since Buckner 2008 is now two-sided: GSR may manufacture negatives *and* removing shared trends may be what makes a real effect detectable. The review's recommendation is to report both ([[wiki/empirical-tensions.md]] T264) |
| Bivariate correlation measures only the **redundant** information carried jointly by two sources; synergistic information requires partial-entropy-style multivariate measures, "with particular relevance for transmodal networks" | Every FC number on this page is a redundancy statistic. If the default network's job is to *integrate* components stored elsewhere, the quantity that would show it is exactly the one correlation cannot see |

---

## Paquola et al. 2025 — the anatomy every argument above was borrowing, measured

> Paquola, Garber, Frässle, Royer, Zhou, Tavakol, Rodriguez-Cruces, Cabalo, Valk, Eickhoff, Margulies, Evans, Amunts, Jefferies, Smallwood & Bernhardt 2025, *The architecture of the human default mode network explored through cytoarchitecture, wiring and signal flow*, Nat Neurosci 28:654–664, doi:10.1038/s41593-024-01868-0 (`raw/paquola-2025-dmn-cytoarchitecture-signal-flow.md`). **This is the primary source Satpute et al. 2026 above and [[wiki/concepts/broadcast-hierarchy.md]] inherit their laminar anatomy from**, ingested after them. Four data layers: (1) the Von Economo cortical-type atlas overlaid on the Yeo network atlas, tested against 10,000 spin-rotated null networks; (2) **BigBrain** — a single cell-body-stained postmortem brain (65-year-old man, 7,400 × 20 μm coronal sections, 100 μm 3D reconstruction) profiled vertex-wise and reduced by nonlinear manifold learning; (3) in vivo diffusion tractography scored by **navigation efficiency** `E_nav` plus whole-cortex **regression dynamic causal modelling** (rDCM) over 400 isocortical parcels of resting fMRI; (4) a 7-T replication in **8** individuals with quantitative T1 relaxometry standing in for histology. Grade it as the strongest anatomical evidence on this page and note the sample structure: the cytoarchitecture is `n = 1`, the individual-level replication is `n = 8`, and the connectivity is group in vivo.

**The composition result: the network is cytoarchitecturally heterogeneous, and uniquely so.**

| Measure | Value |
|---|---|
| Cortical types present | **5 of 6** (eulaminate III → II → I → dysgranular → agranular; **no koniocortex**) |
| Eulaminate share | ~**90%** of the network, against a cortex-wide **84%** |
| Over-representation vs 10,000 spin nulls | **Eulaminate I (heteromodal) +18%**, `P_spin = 0.006` |
| Uniqueness | Every functional network has a distinct type composition (all pairwise KS > 0.11, `P < 0.001`); the default mode has the **most balanced** representation of the three eulaminate types |
| Unequal within the network | `χ² = 1,497`, `P < 0.001` — the types are present, not evenly |

This is what "spans agranular through eulaminate III with no koniocortex" on [[wiki/concepts/broadcast-hierarchy.md]] rests on, with the effect size and the null model attached.

**The data-driven axis `E1`, and why it is not the sensory-fugal gradient.** Manifold learning on intracortical staining-intensity profiles gives a first eigenvector running from **peaked** profiles (high cellular density: retrosplenial, posterior middle temporal — eulaminate III) to **flat** profiles (medial parahippocampus, anterior cingulate — agranular). Its *endpoints* are the network's extreme cortical types, so it looks like the macroscale gradient; in between it does not:

| Property | Cortical types (sensory-fugal) | `E1` (data-driven) |
|---|---|---|
| Layers carrying the signal | mainly neuronal density in layers **II/III** | mainly **mid-to-deep** layers |
| Defined by | topology — spatial relations between areas | agnostic to space |
| Shape inside the network | monotone gradient | **mosaic** — neighbouring points sometimes distinct, distant points sometimes similar; follows neither subregion boundaries nor the anterior–posterior neuronal-density gradient |

The authors' conclusion is the one the wiki should carry: **organisation *within* the network is relatively unconstrained by large-scale spatial gradients** — which is the measured version of Buckner & Krienen's "parallel to the sensory-fugal hierarchy" claim and cuts against reading the network as the top of one smooth axis.

**Two topographic motifs, quantified.** Smoothness = variance in `E1` explained by spatial axes; waviness = deviation from the local mean (a mechanical-engineering surface metric, validated on simulations). Subregions differ significantly on both — smoothness `F = 14.5 / 14.9 / 20.1` (second/third/fourth-order, `P < 0.004`), waviness `F = 48.3`, `P = 0.001`:

| Subregion | Motif | Integration mode it implies |
|---|---|---|
| **Parahippocampus** | High smoothness — a clean local gradient | Progressive **convergence**: signals transformed step by step toward higher-order representations |
| **Dorsal prefrontal cortex** | High waviness, poor spatial-regression fit — repeated back-and-forth between contrasting cytoarchitecture | **Interdigitation**: disparate sources placed adjacent so they can be linked, the substrate for both domain specialisation and cross-domain binding |

Since >90% of cortico-cortical connections are between neighbouring microcircuits, the local topography *is* a wiring statement. Treated as a concept at [[wiki/concepts/microarchitectural-topography.md]].

**Receivers on the periphery, an insulated core, and an output that ignores the difference.** Both connectivity measures covary with `E1`, and only on the input side:

| Quantity | Relation to `E1` (peaked → flat) | Numbers |
|---|---|---|
| Navigation efficiency to the rest of cortex | **Falls** — peaked-profile areas (anterior cingulate, anterior precuneus) communicate most efficiently | `r = −0.60`, `P_spin = 0.001`; coefficient of variation within the network 18% |
| …specifically to perceptually coupled types | Falls more steeply | koniocortex / eulaminate III / eulaminate II: `r = −0.63 / −0.60 / −0.38`, `P_spin < 0.025` |
| Effective **input** (rDCM) | **Falls** — same subunits (inferior parietal, precuneus) receive; flat-profile subunits are insulated | `r = −0.54`, `P < 0.001`; CoV 24%; **limited discrimination by source type** — externally and internally focused types all converge on the same receivers |
| Effective **output** (rDCM) | **No relation** | `r = −0.18`, `P_spin = 0.064`; CoV 29% |
| Within-network connectivity | **No relation** — the covariation holds only for network↔non-network edges | Extended Data Fig. 6 |

**The output result is the paper's distinctive finding and the one a builder should copy.** Across all functional networks, the default mode has the **lowest KL divergence from the null** for communication across cortical types, and the decomposition is asymmetric: **output is balanced across every cortical type — every level of the sensory hierarchies — while input is not.** No other cortical network shows this. Selective in, flat-spectrum out, measured on one graph: `read from a filtered set of levels, write to all of them at equal strength`.

**The hierarchical position, stated as a third option.** The paper's own reading against the two the wiki already carries:

| Position | Claim | Status here |
|---|---|---|
| Apex of the macroscale gradient (Margulies) | The network is the top of the sensory-fugal axis | Partly — it has an insulated end, but internal organisation is not gradient-structured |
| Parallel to the sensory-fugal hierarchy (Buckner & Krienen) | A separate system running alongside | Partly — but its connectivity *is* organised by a laminar-type-like axis |
| **Protrudes from the sensory-fugal hierarchy** (this paper) | Neither nested nor parallel: the network attaches to the hierarchy with **strong afferent convergence at one end and insulation at the other**, an *association hierarchy* possessing the two defining properties — connectivity organisable by levels, and an apex insulated from external input — but with balanced rather than increasingly-intersecting interfacing across levels | The endorsed reading; logged as [[wiki/empirical-tensions.md]] T265 |

**Insulation has a functional correlate already in the literature.** Subunits high on `E1` (medial prefrontal cortex) are suppressed for **longer** during externally oriented tasks than subunits low on it (temporoparietal junction) — so the anatomical insulation gradient and the deactivation-duration gradient are the same ordering, which converts `E1` from a histological axis into a candidate readout of how far each subunit sits from the input stream. The receivers, having more supragranular neurons, are the plausible feedforward end; granular areas also have faster intrinsic timescales, so the efficient-communication end is also the fast end.

**Individual-level replication (7 T, `n = 8`, qT1 for myelin instead of cell bodies).** Moderate but consistent: microstructural axis vs histological axis `r_avg = 0.34` (`P_avg < 0.001`); subregion **waviness** `r_avg = 0.74` (`P = 0.011`), **smoothness** `r_avg = 0.51` (`P = 0.09`, n.s.); navigation efficiency vs the axis `r_avg = −0.38` (`P_avg-spin = 0.015`), and to koniocortex/eulaminate III `−0.40 / −0.37`; functional input `r_avg = −0.26` (`P = 0.101`, **not significant**). Repeating with individual-specific network definitions gave highly similar axes, so the heterogeneity is not an artefact of fitting a group atlas onto individual brains.

**Limits, in the order they bite.**

| Limit | Consequence |
|---|---|
| The cytoarchitecture is **one brain** | BigBrain is a single 65-year-old male specimen; every `E1` claim is `n = 1` histology with an `n = 8` different-modality check |
| `E1` is sensitive to profiling choices | The authors concede curvature, resolution and interpolation may bias superficial vs deep layers, and that higher components (E4, E5) may be the ones matching cortical types — so "the axis is not the sensory-fugal gradient" is partly a statement about which component was read |
| Navigation efficiency is a proxy | A decentralised routing heuristic over diffusion tractography, not measured signal flow; tractography has known biases against long and crossing tracts |
| rDCM is linear with a fixed haemodynamic response | The price paid for 400 parcels ([[wiki/concepts/effective-connectivity.md]]) — the balanced-output claim is a property of a linear model's fitted couplings |
| The output result is a **null-model comparison** | "Balanced" means lowest KL divergence from a null across types, not a measured equality of transmitted influence |
| Cross-modal registration | Histology from one person combined with in vivo imaging from different cohorts; the 7-T arm addresses this and weakens two of the four effects (input, smoothness) to non-significance |

---

## Relevance to a reasoning model

- **A default mode is a resource-allocation policy, not a resting state.** The network's activity is a *default*: what the machine does with a moment when no input demands it. The paper's closing proposal is that this budget is spent constructing, replaying and exploring event scenarios in order to derive expectations about the future — which puts it in direct competition with [[wiki/concepts/offline-replay.md]]'s use of the same idle period for consolidation, and with [[wiki/concepts/default-self-model.md]]'s use of it for competence self-assessment. Three literatures, one budget, no arbitration rule anywhere in the wiki.
- **Task generality is the finding to copy.** Remembering, prospecting, mentalizing and moral evaluation are studied as separate faculties and share one substrate. If a single mechanism — construct an alternative perspective to the present, constrained by stored episodes — covers all four, then the corresponding machine component is *one* simulator with a parameterised perspective (whose? when? counterfactual or actual?), not four modules. The wiki's [[wiki/concepts/simulation-based-planning.md]] has the roll-forward but no perspective parameter and no social case.
- **The switch has at least two dials, and they are anatomically separate.** Ventral medial prefrontal cortex falls under *any* attentionally demanding task; dorsal medial prefrontal cortex (BA 8/9/10) falls under externally directed load but *rises* when the same load is self-referential, with reaction times matched (Gusnard et al. 2001). So "suppress the default mode" is not one gain: a machine needs an **orientation** parameter (is the object of processing internal or external?) independent of a **load** parameter (how much is being asked?), and only the second is what [[wiki/architectural-gaps.md]] `G90` currently describes.
- **Membership is a runtime variable, and the switch has two separately controlled halves.** A third of the map changes class with brain state, reversibly and graded by demand: precuneus, angular gyrus and cerebellar vermis leave, insula/inferior frontal, anterior and middle cingulate join, the core does not move (Gao et al. 2013). The two halves predict *different* behavioural quantities with the crossed correlations empty — depth of disengagement → speed, degree of outside-recruitment → accuracy. So a machine analogue needs the mode variable to address **edges, not units**, and needs two of them: a release gain on the internal periphery and an acquisition gain on whichever external system the current task needs.
- **The coupling *sign* is a controlled variable, not a constant of the wiring.** Within one creative act, default↔frontoparietal coupling is negative during idea generation and rises during idea evaluation; across subjects, stronger negativity during sustained attention predicts less variable reaction time (Tripathi et al. 2025). A machine whose critic is permanently wired to its generator implements only the second phase — [[wiki/concepts/refinement-loop.md]]'s exploration phase is measured here to require the evaluator *decoupled*, which makes "when is the verifier connected?" a scheduling question no refinement loop in the wiki asks.
- **The same failure appears in six unrelated pathologies, which is weak evidence that it is one variable.** ADHD, depression, schizophrenia, Parkinson's, Alzheimer's and aging all reduce either the network's suppression under load or its anticorrelation with task-positive systems, with distinct pathophysiologies (Tripathi et al. 2025). And the set-point is trainable in adults: meditation increases default↔frontoparietal anticorrelation as a *trait*, associated with better sustained attention — so `G90`'s arbitration gain has a slow experience-driven learning signal at both ends of life.
- **The mode switch is fast and it is a switch.** Event-related deactivation within seconds, plus anticorrelation, plus measured attenuation of sensory-evoked responses in strong-default individuals: internal generation and external processing trade off on a timescale a system could actually control. Logged as [[wiki/architectural-gaps.md]] `G90`.
- **The rodent mechanism the review points at is the only causal-grade one in it.** Hippocampal place-cell ensembles sweep ahead of the animal at high-cost choice points, first down one arm then the other (~10% of time at the choice point), and sweep back down the correct path after errors — a concrete implementation of "simulate the alternatives before committing" that the human imaging cannot supply. See [[wiki/concepts/offline-replay.md]].
- **Selective in, flat-spectrum out — measured, and unique to this network.** Effective input to the network is concentrated on a cytoarchitecturally defined subset (`r = −0.54` with the microstructural axis) while output is distributed across *every* cortical type at roughly equal strength, a balance no other cortical network shows (Paquola et al. 2025). The architectural instruction is precise and no wiki model follows it: **filter what the top level reads, do not filter what it writes**. A transformer's top block reads everything through the residual stream and writes into the same shared space; the biological arrangement inverts both halves.
- **The network has a depth axis and an insulated apex, but its interior is a mosaic rather than a gradient.** The data-driven cytoarchitectural axis `E1` runs peaked→flat, orders both structural communication efficiency and effective input, and predicts how long a subunit stays suppressed under external task — yet inside the network it follows neither subregion boundaries nor any spatial axis (Paquola et al. 2025). So a builder gets a *usable* level variable (each module's own compression statistic, not its index) together with a warning: level order need not be spatial order, and the modules at the same level need not be adjacent.
- **Two integration motifs coexist in one system, and they are distinguishable by a cheap surface statistic.** Smooth local gradient in parahippocampus (progressive convergence) vs high waviness in dorsal prefrontal cortex (interdigitation, linking disparate sources), `F = 48.3` for the difference. Since >90% of cortico-cortical connections are local, arranging modules by similarity vs interleaving them is a *wiring* decision with different computational products — see [[wiki/concepts/microarchitectural-topography.md]].
- **Content comes from elsewhere.** The network excludes sensory cortex, yet imagined episodes have modality-specific content — visual and auditory cortex activate for the recall of objects and sounds, the amygdala for emotionally charged futures. The proposal (Hassabis & Maguire's "scene construction") is that the network's job is to *retrieve and integrate components stored in modality-specific areas into a coherent spatial context*, which makes the default network a **binder over frozen modality stores**, not a store itself.

---

## Open problems

| Problem | Why it is open |
|---|---|
| **No lesion study has ever been designed against this network** | The authors state it directly: unlike every other brain system, this one was characterised entirely by correlational imaging, with no neurological syndrome initiating its study and no behavioural probe motivated by its anatomy. Nothing here is causal. **Partly answered since** (Menon 2023): left angular gyrus lesions reduce mind wandering, and rodent optogenetics can drive the switch — one node and one non-human preparation, not a lesion programme |
| **The two directional claims are not reconciled** | The salience network is said to *cause* default-mode suppression, while the default network is said to have the greatest net causal outflow of any network, at rest and during memory formation, including to frontoparietal cortex. Both estimates come from fitted models on observational data ([[wiki/empirical-tensions.md]] T257) |
| **Which grain the network is** | Node-level meta-analyses give nine nodes nine different preferential functions, and the posterior medial cortex fractionates into dorsal-PCC / ventral-PCC / RSC subnetworks with distinct control-network couplings — so "the default mode network" may name a family of systems sharing convergence zones rather than one system ([[wiki/concepts/node-definition-problem.md]]). **And the grain is not stable in time**: with a fixed vertex set, one third of the map changes membership between rest and a visual classification task and changes back afterwards (Gao et al. 2013), so any region list is indexed by the state it was measured in |
| Mentation vs sentinel is not identified | Passive tasks move mental content and attentional breadth together; no experiment reported here breaks the confound — and the confound is wider than two-way: the field carries **ten** function hypotheses over the same map, eight of which are one mechanism at different perspective/tense settings (Azarias et al. 2025) |
| **Where the network's connectivity comes from is a separate question from what it does, and only the first has a developmental answer** | Adversity, poverty, family instability and enriched environments all move within-network connectivity, in directions the source cannot predict a priori (hypo *and* hyper both reported for adversity); cortisol-driven hypomyelination gives a route that changes conduction rather than coupling; and meditation/CBT/TMS move it back in adults. Nothing in this literature states what the set-point is a set-point *of*, so "altered DMN connectivity" is currently a finding with no forward prediction (Azarias et al. 2025) |
| Clinical direction is not stable across reviews | Schizophrenia is over-engaged and hyper-correlated in Buckner 2008 and hypoconnected in Azarias et al. 2025; PTSD is hyperactive on re-experiencing and hypoconnected on avoidance within one source ([[wiki/empirical-tensions.md]] T258) |
| **The self-referential manipulation is confounded with affect** | Gusnard et al. 2001's internally cued condition asks how a picture makes you feel; every self-reference trial is also an emotion report, and the ventral tier that would carry the affective half is decreasing in both conditions. Nothing in the founding self-reference experiment separates "about me" from "about my feelings" |
| Whether the intrinsic low-frequency signal is the cognition | It persists in sleep, anaesthesia and primary sensory cortex, and is too slow for cognitive events — so the correlation between default activity and mind-wandering may hold at a different frequency band than the one being measured |
| What controls the switch | Local competition vs a frontoparietal arbitrator is unresolved, and the only evidence for the arbitrator was preliminary at the time of writing |
| Anticorrelation may be partly manufactured | Global-signal normalisation centres correlations at zero and forces negatives; the effect's magnitude without it is unknown — and the sign of the worry is now disputed, since the global signal is part neural and removing shared trends may be what makes a genuine effect detectable (Tripathi et al. 2025, [[wiki/empirical-tensions.md]] T264) |
| **Nothing states what sets the sign of default↔frontoparietal coupling** | The pair is negative in sustained attention and in creative generation, positive in goal-directed self-generated thought, semantic retrieval, scene construction and creative evaluation. No source names the variable that flips it; "internal vs external content" does not separate the cases, since generation and evaluation share content (Tripathi et al. 2025) |
| **A group-level connectivity biomarker is majority topography** | Up to 62% of the variance in simulated group-level functional-connectivity matrices is explained by cross-subject spatial variation in where the networks sit, and that variance is largest in exactly the transmodal cortex this network occupies; precision fMRI is the proposed fix and scan time is its barrier ([[wiki/concepts/node-definition-problem.md]]) |
| **Correlation cannot see integration** | Bivariate functional connectivity measures redundant information only; synergistic information — the quantity a binder over modality-specific stores would produce — needs partial-entropy-style multivariate measures, which the review flags as most relevant precisely for transmodal networks and which no result on this page uses |
| Precuneus membership | Connectional anatomy says area 7m is not a member; the structural-core literature ranks precuneus among the highest-degree cortical nodes ([[wiki/empirical-tensions.md]] T256). A third answer is that the question is ill-posed as a yes/no: precuneus and angular gyrus are the two cortical regions that *leave* the network under external load and rejoin it at rest, so membership is a state-conditioned property of those particular nodes (Gao et al. 2013) |
| **Which state defines the network** | Gao et al. 2013 assume the resting topology is the true network and the task topology transient coupling, then name the changes accordingly; the reverse assumption fits the same data as a task network that sheds nodes at rest. Nothing in a design with no independent criterion for membership can break the symmetry |
| Boundaries are approximate | Every region in the anatomy table spans multiple architectonic areas with uncertain borders, and LTC is the authors' own most tentative estimate |
| **Whether the function question is even well-posed** | The competing accounts are drawn from incommensurate ontologies (psychological domain, within-domain contrast, unifying construct), so they are not rival answers in one currency; and refining the parcellation makes synthesis harder rather than easier unless the parts get a shared neurocomputational description. Satpute et al. 2026's proposal — describe the parts by what their anatomy can compute — is untested |
| **Is the network at the apex, or off the chain?** | Satpute et al. 2026 assert both: at or near the apex of macroscale structural and functional gradients (by distance from sensory input), *and* not in a chain-of-command hierarchy at all (diffuse multilevel output, selective high-level input, laminar-type-matched lateral exchange). **Partly answered**: Paquola et al. 2025 measure microarchitecture, structural communication and effective connectivity on the same parcellation and get a third position — the network *protrudes* from the sensory-fugal hierarchy, with strong afferent convergence at one end of its own cytoarchitectural axis and insulation at the other, output balanced across all levels. What remains open is that the resolving axis `E1` is `n = 1` histology whose sensitivity to superficial-vs-deep profiling the authors concede, and that no measurement of laminar *type* of the connections themselves exists ([[wiki/concepts/broadcast-hierarchy.md]], [[wiki/empirical-tensions.md]] T265) |
| **Nothing explains why the two internal motifs are where they are** | Parahippocampus is a smooth gradient, dorsal prefrontal cortex is interdigitated, and the difference is significant (`F = 48.3`) — but no source says what determines which subregion gets which motif, whether the assignment is developmental or functional, or what a mixed system computes that neither motif computes alone (Paquola et al. 2025) |
| **The balanced output is a null-model statistic, not a measured equality of influence** | "Output balanced across cortical types" means lowest KL divergence from a spin null among all networks, computed on couplings fitted by a **linear** dynamic causal model with a fixed haemodynamic response. The claim that the network can update all hierarchical levels in one act needs an intervention, and none exists |
| **The heterarchy claim rests on the one axis that cannot currently be tested** | The layered communication axis needs laminar-type parsing that informs task fMRI, which the source concedes does not yet exist; the anterior–posterior and local-hierarchical axes have functional dissociations, this one has none |

---

## Connections

- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — supplies the structural half of this page's hub claim (every posterior default component is in the cortical structural core, medial prefrontal cortex is the sole exclusion) and takes the one disagreement: precuneus is a top-ranked core member there and a provisional non-member here.
- **[[wiki/concepts/default-self-model.md]]** — the dorsomedial prefrontal subsystem is the constructor whose self-referential output that page says is signed-inflated and calibrated by a *different* region, so the two pages describe the same idle-time process from the anatomy side and the failure-mode side.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — this page splits the human medial wall by *network role* (dorsal = self-referential constructor, ventral = shared hub) where that page splits the rat medial wall by output port, and the two axes have not been reconciled; the founding measurement of that split — dorsal BA 8/9/10 up on self-reference, ventral BA 24/25/32 down under any load, reaction times matched — is Gusnard et al. 2001, carried in full there.
- **[[wiki/concepts/simulation-based-planning.md]]** — the internal-mentation hypothesis makes this network the biological simulator, and adds the parameter machine planners lack: whose perspective and which tense the roll-forward is run from, with remembering, prospecting and mentalizing as settings of one mechanism.
- **[[wiki/concepts/offline-replay.md]]** — both claim the same idle budget, and this page supplies the review's only causal-grade mechanism for it: hippocampal forward sweeps down each arm at a choice point, plus corrective sweeps after errors.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the default network is the wiki's largest instance of a system named for a function that its own experimental design cannot identify, with the mentation/sentinel confound as the concrete failure.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the medial temporal subsystem is the episodic store supplying building blocks to a neocortical constructor, which is the CLS division of labour appearing at rest rather than during consolidation.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the medial-temporal↔prefrontal edge documented there is the one this network routes *indirectly*, through PCC/Rsp and vMPFC hubs, since the two subsystem heads are anticorrelated and not directly coupled.
- **[[wiki/concepts/integration-segregation-balance.md]]** — anticorrelation between the default and dorsal attention systems is a segregation event with a specific pair of participants, and the missing arbitrator is the same control variable that page says nothing here reads or sets; Gao et al. 2013 supplies the same axis measured on one network's own edges, and one disagreement — within-class coupling of this network's changing subsets *does* move with state, where that page's 375 parcels show zero within-module change ([[wiki/empirical-tensions.md]] T263).
- **[[wiki/concepts/parallel-timescale-streams.md]]** — the default mode is one letter of that page's 126-mask alphabet, and its co-activation with dorsal attention and frontoparietal masks among the most frequent states qualifies the strict anticorrelation reported here.
- **[[wiki/concepts/cognitive-control.md]]** — the open question this page hands to the control layer: whether a separate controller assigns the network or the two modes settle it locally, with autism (under-use) and schizophrenia (over-use) as the two failure directions of one setting.
- **[[wiki/entities/salience-network.md]]** — the field's candidate answer to this page's arbitration question: a third system (anterior insula + dorsal anterior cingulate) whose salience detection is claimed to switch this network off and the frontoparietal one on by one mechanism, and which also supplies the intracranial-EEG evidence that the deactivation is neuronal — but the two systems' *coupling* runs the other way from the switching story: insula, anterior and middle cingulate go from ≈0 or negative correlation with this network at rest to `0.30–0.34` under task, and the size of that increase predicts accuracy (Gao et al. 2013).
- **[[wiki/concepts/event-segmentation.md]]** — this network carries the boundary code: posterior cingulate patterns persist through a naturalistic stream and change at perceived boundaries, and the same code generalises to *internally* generated boundaries during unguided recall, which is the wiki's only evidence that one segmenter serves perceived and imagined streams alike.
- **[[wiki/concepts/population-geometry.md]]** — the review's one copyable broadcast mechanism is geometric: a global fluctuation mode reaching every area within ~1 s in a subspace *orthogonal* to the one carrying sensory data, so broadcasting costs no sensory bandwidth.
- **[[wiki/concepts/learnable-synaptic-delays.md]]** — the developmental route into that page's parameter: chronic childhood cortisol inhibits oligodendrocyte proliferation and differentiation, so conduction delay and integration timescale are altered by *myelination* rather than by any synaptic weight, on a schedule set by the environment.
- **[[wiki/concepts/dynamic-repertoire.md]]** — the Alzheimer's finding that survives translation: what degrades with cognitive impairment is the network's **temporal variability**, i.e. its capacity to change state, not its mean activation level.
- **[[wiki/concepts/meta-learning.md]]** — the only wiki machinery with a control parameter learned on a slower schedule than the policy it gates, and therefore the nearest thing to the developmentally trained arbitration set-point this page now requires — but it optimises the whole fast learner rather than a single gain, and has no critical window — and the schedule does not close with development: meditation moves the default↔frontoparietal anticorrelation as a *trait* in adults, with the change tracking sustained-attention performance (Tripathi et al. 2025).
- **[[wiki/concepts/microarchitectural-topography.md]]** — the two ways this network's subregions lay out their microarchitecture in space — a smooth parahippocampal gradient and an interdigitated prefrontal mosaic — measured here by smoothness and waviness, and read there as two different local-wiring strategies for integration.
- **[[wiki/concepts/broadcast-hierarchy.md]]** — the shape this network is the wiki's evidence for: selective input from high-level association cortex, diffuse output across many networks and laminar types, so a global model revision costs one hop rather than `L` relays — and the laminar-type rule that turns its internal "levels" into a heterarchy; Paquola et al. 2025 supply the measurement that page was arguing from, with output balanced across every cortical type (uniquely among networks) while input is concentrated on the peaked-profile end of one cytoarchitectural axis.
- **[[wiki/concepts/effective-connectivity.md]]** — the instrument that carries the input/output asymmetry here: regression dynamic causal modelling over 400 isocortical parcels, whose linearity and fixed haemodynamic response are exactly the price that page says whole-cortex scale is bought with, so the balanced-output claim inherits that model class.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the anatomy that implements it here: fewer, less dense, hypomyelinated units with convergent input and long integration windows recode high-dimensional input into the low-dimensional priors this network broadcasts — lossily, into approximations sufficient for action rather than reconstructions.
- **[[wiki/concepts/refinement-loop.md]]** — the biological measurement of that loop's two phases as two *wirings* rather than two stages: default↔frontoparietal coupling is negative while candidate ideas are generated and rises while they are evaluated, so the proposer/verifier link is a gain the brain sets per phase and every wiki implementation leaves permanently closed.
- **[[wiki/concepts/node-definition-problem.md]]** — the precuneus dispute is that problem in its most consequential form: whether a canonical network has a member depends on whether "precuneus" names area 7m or a region that includes areas 29/30; and its temporal case is here too — with the parcellation held fixed, membership itself changes between rest and task and returns, so a region list carries a hidden state index as well as a hidden atlas choice (Gao et al. 2013).
- **[[wiki/concepts/activity-baseline.md]]** — the founding argument that licenses this whole page, plus the companion paper's measured demonstration that one mid-medial-prefrontal "activation" was entirely the control task's deactivation: the deactivations are decreases from a physiologically defined zero rather than returns from an unnoticed activation, established by the spatial uniformity of the oxygen extraction fraction — together with the dissociation that undercuts the network's high-resting-metabolism claim, since posterior cingulate runs ~40% above the global mean *while at baseline*.
