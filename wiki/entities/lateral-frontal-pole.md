# Lateral Frontal Pole (FPl) — the Multi-Filter Decomposer

**The lateral subdivision of human Brodmann area 10: the one cortical area whose connectivity profile has no match anywhere in the macaque brain. Its proposed function is not "the most abstract rule" but a *transform* — decompose high-dimensional, poorly structured input into several low-dimensional features in parallel, then hand the features to older regions that combine or contrast them. Its lesion signature is invisible to every standard neuropsychological test.**

> **Provenance.** Chau, Law, To, Shum & Mars 2025, *Complex functions of human lateral frontopolar cortex*, Brain 148(11):3833 (`raw/chau-2025-lateral-frontopolar-functions.md`). A review, not a primary study: every result below is reported second-hand, the proposed model in **A model of the FPl** is the authors' own synthesis and is untested, and the patient series it rests on are single cases or `n = 3–45` with lesions that extend well beyond FPl. Written by authors of one of the two load-bearing studies (Law et al. 2025).

This page is the FPl seen from decision-making. [[wiki/entities/lateral-frontoparietal-network.md]] holds the same tissue seen from analogy, under the name **RLPFC** — that page's "frontopolar second-order integrator" and this page's "multi-filter decomposer" are two functional descriptions of one region, and they are not obviously the same function ([[wiki/concepts/node-definition-problem.md]]).

---

## Anatomy: the human-unique subdivision

| Fact | Measurement | Grade |
|---|---|---|
| Human BA10 occupies **14% of brain volume**, vs **2–3%** in other great apes | Volumetric | Contested allometrically — the relative increase is called modest, but absolute neuron count in the region is far greater than in any other species |
| BA10 splits into **FPl** (lateral) and **FPm** (medial), by observer-independent cell staining *and*, independently, by connectivity-based parcellation | Bludau et al.; Neubert et al. 2014; Garcia-Cabezas et al. | Two methods agreeing on one boundary — the strongest anatomical claim here |
| **The FPl connectivity profile has no preferential match in the macaque; FPm does** | Diffusion-tractography connectivity fingerprints, human vs macaque (Neubert et al. 2014) | The page's central claim, and a null in a cross-species fingerprint match |
| Human FPl carries **additional sulci absent in monkeys** (dorsal/ventral paraintermediate frontal sulcus, vertical rami of the intermediate frontal sulcus); chimpanzees and other great apes share the human pattern | Sulcal morphometry in a large primate sample (Amiez et al.) | Functional implications explicitly unknown — and note this row makes the feature *ape*-general, not human-unique, which sits awkwardly beside the connectivity row |
| FPl is functionally connected to **anterior and posterior cingulate cortex** and is usually assigned to the frontoparietal resting-state network | Seed-based functional connectivity; resting-state parcellation | Standard |

---

## The lesion paradox, and why it is an instrument

Frontal-pole patients pass the tests built to detect frontal damage and fail at life.

| Patient set | Passes | Fails |
|---|---|---|
| Focal FP lesion, single case (Hoffmann & Bar-On) | Wisconsin Card Sorting, Tower of London, Trail Making, Rey–Osterrieth, Frontal Systems Behavioral Scale, Emotional Quotient Inventory | Reported real-life difficulty |
| Anterior frontal incl. FP, architect (Goel & Grafman) | Average or above on a wide neuropsychological battery | Could not *generate* designs; on a simulated interior-design task, structured the problem from prior knowledge and then made no progress. Forced to retire |
| `n = 18` FP lesions (Goel et al.) | Delis–Kaplan Tower Task (structured planning) — normal | Real-life travel planning under cost and time constraints |
| `n = 3` extended frontal (Shallice & Burgess) | Wechsler verbal and performance IQ **> 112** | Six Element Test; Multiple Errands Test (both lack imposed structure) |
| `n = 45` mixed lesions (Volle et al.) | Retrospective memory, general intelligence | Prospective memory for **time-based** responses; the critical voxels sit on the FPl/FPm border |
| Patient Z.P. | Recalled *both* action sets and recalled the instructions accurately | Could not recall **which** set he had been asked to reproduce; missed the cued responses. Content retained, enactment lost |
| Focal frontal lesions, `n = 27`, VLSM (Urbanski et al. 2016) | Frontal Assessment Battery, Stroop interference, lexical and semantic fluency, Mini-Mental State Examination, naming and semantic matching — **impaired and preserved analogy groups are indistinguishable on all of them** | Visuospatial **analogy** (match two sets on the relation among their elements) with a perceptual-matching control on the same stimuli held normal. Primary read at [[wiki/entities/lateral-frontoparietal-network.md]] |

**The common factor is stated by the authors and is the machine-relevant part: failure appears only when the task is naturalistic, information-rich and/or poorly structured.** Every test these patients pass supplies the problem's decomposition in the instructions. Every test they fail requires them to produce the decomposition themselves.

> **`L0-INSTR`.** This is a *benchmark-insensitivity* result of a kind the wiki has been asserting without evidence: a battery can be at ceiling on a capability's structured form while the capability is destroyed. Recorded as `I37` on [[wiki/concepts/certification-instruments.md]] — pair a structured and an unstructured presentation of the *same* nominal competence and read the gap, rather than scoring either alone.

---

## What activates it

| Function | Key result | Causal evidence |
|---|---|---|
| **Directed exploration** | Step change in FPl activity when the richest option is forgone (Daw et al. 2006); parametric tracking of the **value of unchosen alternatives** (counterfactual value) | Inhibitory TMS disrupts **directed** exploration and leaves **random** exploration intact (Zajkowski et al.) — the cleanest causal dissociation on this page |
| **Relative uncertainty** | FPl tracks the *difference* in uncertainty between two options, **not** total uncertainty (Tomov et al.) | — |
| **Prospective memory** | Time-based prospective memory; FPl/FPm border. Imaging localises maintenance of a future intention here | Lesion (Volle et al.), patient Z.P. |
| **Temporal control** | In the caudal→rostral control ladder, FPl carries *temporal* control (integrating past information into future action) above mid-DLPFC's contextual control and the inferior frontal junction's feature control; activity ramps over an instruction sequence and scales with proximity-to-end × reward size | TMS to FPl, but not premotor cortex, raises error rate on the instruction-execution task |
| **Analogical reasoning** | Present in every analogy contrast; social and non-social | Urbanski et al. 2016 lesion mapping — a 0.33 cc left BA 10/47 cluster (MNI −31/51/−3), specific to analogy over a matched perceptual control, with severed-afferent count grading the deficit (but see the discrepancy below) |
| **High-dimensional choice** | See next section | — |

**The exploration comparison is the sharpest evolutionary argument here.** A POMDP model dissociating exploratory from exploitative signals found humans and macaques using the *same computational mechanism*, but the human implementation additionally recruits FPl; macaques do the counterfactual bookkeeping in ACC/dorsomedial frontal cortex, and humans show the ACC-adjacent signal **plus** an FPl one, specifically when chosen and unchosen outcomes are revealed simultaneously. So the human-unique area is not doing a human-unique computation — it is an *added parallel stage* on a computation both species run ([[wiki/concepts/epistemic-value.md]], `T289`).

---

## The load-bearing experiment: multi-filter decomposition

Law et al. 2025, and it is the only result on this page stated at the level of a mechanism.

**Design.** Choose between two complex options, each a bundle of **20 gambles** at different win probabilities, in fMRI; contrast against choices between two **single**-gamble options.

| Condition | Value signal in | Functional connectivity |
|---|---|---|
| Complex (20-gamble bundles) | **FPl** + posterior cingulate cortex (dorsal areas d23/d31) | FPl↔PCC stronger |
| Simple (single gamble) | **vmPFC** + PCC — the classical value pattern | vmPFC↔PCC stronger |

A **double dissociation on whether decomposition is required**, not on value, not on difficulty, and not on reward magnitude. Simple gambles also need probability × magnitude combined; vmPFC covers the decompositions that complete automatically.

**The analysis is worth copying.** Train an artificial neural network on the human choice data until it chooses like the subjects, then correlate each *stage* of the network with each brain region by representational similarity analysis. Result: visual cortex ↔ the network's input layer; **FPl ↔ the intermediate stage that decomposes high-dimensional input into low-dimensional features (mean, variance)**; PCC ↔ the stage that recombines those features into a decision. This is a trained model used as a *staged* measuring instrument for anatomy rather than as a black-box encoder ([[wiki/concepts/neuroscience-ai-transfer.md]]).

**The ablation is the result a builder should carry.** The network that matched FPl used **four filters**. Reducing the filter count toward one degraded the FPl representational similarity *monotonically*. So the signature is **multi-feature parallel decomposition** — not decomposition as such, and not a single learned summary statistic. A one-filter bottleneck is not what this tissue does.

Wittmann et al. replicate the pattern in a social task: information about four agents is compressed into a 3-D space of basis functions, FPl tracks the **two basis functions relevant to the decision**, and a non-social control produces the same FPl signal — so the compression is content-general.

**Unresolved by the experiment:** whether the multiple decompositions run *simultaneously* in FPl or are time-multiplexed by cognitive branching (put one feature's decomposition on hold, run another). fMRI cannot tell; the authors name EEG/MEG as the discriminator. For a machine the two are entirely different architectures — parallel filter bank vs one filter plus a stack.

---

## A model of the FPl (the authors' proposal, untested)

| Edge | When it is used | Function |
|---|---|---|
| **mid-DLPFC → FPl** | Always | Defines the action goal and thereby **shapes the filter weights** — i.e. the decomposition is task-conditioned by a top-down signal rather than fixed |
| **FPl ↔ PCC** | Features serve **one** goal | Recombine the feature branches into a single value (mean and variance decomposed separately, then combined) |
| **FPl ↔ ACC** | Features serve **alternative** goals | Keep multiple action values updating concurrently — exploration, counterfactual learning |

Two families of FPl-linked function, per the authors: (i) **managing concurrent information streams** (prospective memory, cognitive branching, counterfactual updating) — but ACC does this too in monkeys, so it cannot be what is human-unique; (ii) **decomposing high-dimensional information into features** — their candidate for the unique part.

> **`(brainstorm)` — what this is, in machine terms.** A learned, goal-conditioned, multi-head projection to a low-dimensional feature basis, inserted between perception and valuation, whose *heads* are then routed to one of two downstream combiners depending on whether they describe one option or several. The head weights are set by a separate controller. Three things in that sentence are absent from every architecture in this wiki: the decomposition is *conditioned on the goal* rather than learned once; the number of heads is the load-bearing hyperparameter (the ablation says so); and there is an explicit switch on *whether the features belong to one object or to alternatives*, which is exactly the same-object/different-object distinction a value network normally has no representation of.

**This is a composition proposal, and it is filed as one.** `G21` asks what joins the outputs of two encapsulated modules; this model answers *nothing does* — each source is projected into a shared low-dimensional basis first and an older region sums the projections, so composition is legal because everything has been rewritten rather than because a binder exists. Added as the fifth rival on [[wiki/architectural-gaps.md]] `G21`, and it does not close the row: the things being projected here are attributes of one stimulus set, not independently-acquired vocabularies.

> **`(brainstorm)` — and the negative prescription is stronger than the positive one.** vmPFC handles the decompositions that complete automatically; FPl engages only when they do not. A single value head trained end-to-end on all choices is the architecture this dissociation says does not exist in the reference system. Whether the prefrontal switch is binary or graded with complexity is explicitly open, and it is cheap to ask of a model — sweep option dimensionality and watch whether a head's contribution turns on abruptly.

---

## The hierarchy dispute: FPl is the apex on activation and is not the apex on connectivity

Two literatures place the same region at opposite ends of the same hierarchy.

| Position | Ordering criterion | Result |
|---|---|---|
| **FPl at the apex** | Abstractness of the controlled representation, read from activation | Rule Abstraction model (Badre & D'Esposito): premotor = concrete stimulus–response, mid-DLPFC = abstract rules, FPl = remapping of the rules themselves. Information Cascade model (Koechlin): rostral stages consume bottom-up output from caudal ones, and lesion data are asymmetric — premotor lesions impair concrete *and* abstract, mid-DLPFC lesions impair only abstract |
| **mid-DLPFC at the apex** | Efferent-minus-afferent connectivity strength ("hierarchical strength"), from dynamic causal modelling | The greatest efferent/afferent asymmetry is at **mid-DLPFC**, not FPl (Nee et al.; Pitts & Nee) — so the caudal-to-rostral gradient is not supported by the causal-influence data, and FPl's "abstract" functions frequently co-activate mid-DLPFC |

Badre & Nee's reconciliation: mid-DLPFC is the **domain-general controller** (connected to both internally- and externally-oriented networks, allocating resources), and FPl is a specialised service it calls — which is what Chau et al. then build into their model as *DLPFC shapes FPl's filters*. Recorded as `T332`.

**The general lesson the authors draw is the one that generalises past this pair:** multiple hierarchies coexist over one anatomy, and which one you recover depends on the ordering criterion, because cortex is wired with long- and short-range **loops** rather than as a layered feedforward stack. A hierarchy read off activation abstractness and a hierarchy read off effective connectivity are different objects and need not agree ([[wiki/concepts/effective-connectivity.md]], [[wiki/concepts/broadcast-hierarchy.md]]).

---

## The analogy lesion discrepancy

| Study | Sample | Result |
|---|---|---|
| Urbanski et al. 2016 | 27 focal frontal patients, voxel-based lesion mapping | Left frontal pole (incl. FPl) causally required for visuospatial **analogy**, not for a perceptual match on the same stimuli |
| Mole et al. 2025 | **247** patients, diverse lesion sites | Analogy impairment mapped to a frontal network **posterior to** FPl |

Chau et al.'s proposed reconciliation — and they have an interest in it — is that Mole's task required *identifying* an analogy rather than *applying* one to a new problem, and only the latter needs the high-dimensional decomposition they attribute to FPl. Not tested. The tension is opened at the Mole 2025 ingest; this row is its first half.

**Reading the Urbanski primary weakens the reconciliation without settling it.** That study crossed its analogy task with exactly one supplied-versus-derived manipulation — *AnalogyApply* states the schema in words, *AnalogyFind* requires extracting it — and the frontopolar-lesion patients were impaired **equally** on the two (and equally on cross- versus intra-dimensional trials). The deficit therefore survives handing the subject the decomposition, which is the opposite of what a demand-for-decomposition account predicts, and is why the authors read the region as doing *relational matching/integration* rather than inference or schema induction. Find/Apply is not identify/apply, and the null rests on `n = 5` patients in the cluster, so this bounds the reconciliation rather than refuting it. Two further facts from the same study sit on Mole's side of the discrepancy: analogy-preserved patients' lesions overlapped in **right** prefrontal cortex, and no right-hemisphere tract disconnection predicted any deficit.

---

## Open problems

| Problem | Why it is open |
|---|---|
| **Simultaneous or branched decomposition** | fMRI cannot separate a parallel filter bank from a serially branched one; no EEG/MEG study has been run on the paradigm |
| **Binary switch or gradient between FPl and vmPFC** | The double dissociation used two extreme complexity levels and nothing in between |
| **Nothing is known about the FPl-centred network's cognitive contribution** | The connectivity uniqueness is established; no study relates that specific network to any capability, though the analytic machinery exists (it is routine for the default-mode network) |
| **The temporal confound on the decomposition result** | FPl activates in many tasks requiring integration *across time*; the Law et al. design has a temporal structure, and the network used as its instrument has none. Adding one and re-testing representational similarity is the stated remedy |
| **No uniquely human cognitive ability is securely identified** | Communication, tool use and abstraction have all been found in other species to some degree; the anatomical uniqueness of FPl is far better established than any behaviour to attach to it |
| **Every lesion series is contaminated** | Focal FPl lesions are near-nonexistent; all the patient evidence above comes from lesions extending into FPm or neighbouring frontal cortex |

---

## Connections

- **[[wiki/entities/lateral-frontoparietal-network.md]]** — holds the primary for this page's Urbanski et al. 2016 rows (lesion coordinates, tract-disconnection dose-response, the Find/Apply null, the clinical difference score), and is the same tissue under the wiki's other name for it (RLPFC), with a different function assigned: that page's *second-order relational integrator* and this page's *goal-conditioned multi-filter decomposer* are rival descriptions of one region, and the decomposition account subsumes the relational one only if comparing relations is a special case of projecting onto a learned feature basis — which nobody has argued.
- **[[wiki/concepts/certification-instruments.md]]** — supplies `I37`: the frontal-pole patients pass every structured test of the very competences they have lost, so a capability score is only interpretable against the *same* capability tested without an author-supplied decomposition.
- **[[wiki/concepts/abstraction.md]]** — a fourth entry for family O2 with a measured parameter attached: abstraction as dimensionality reduction, but *multi-headed*, with a filter-count ablation showing the plurality is the part that matches the tissue.
- **[[wiki/concepts/broadcast-hierarchy.md]]** — that page states abstraction as anatomical dimensionality reduction defined by endpoints; this page adds that the reduction's *filters are set by a separate controller per task*, so the anatomy fixes the compression site without fixing the compression.
- **[[wiki/concepts/policy-abstraction-hierarchy.md]]** — the rostro-caudal ladder this region sits at the top of on the activation criterion and does *not* sit at the top of on the effective-connectivity criterion (`T332`), plus the third rung that page never names: temporal control, integrating past information into future action, above contextual control.
- **[[wiki/concepts/effective-connectivity.md]]** — the methodological payload of `T332`: two orderings of the same regions, one from activation abstractness and one from efferent-minus-afferent influence, disagree about which node is apical, and cortical long-range loops mean neither is wrong.
- **[[wiki/concepts/epistemic-value.md]]** — the causal dissociation this page contributes to that page's ablation record: TMS to FPl removes *directed* exploration and leaves random exploration intact, so the strategic and the stochastic exploration terms are separately damageable and only one has a dedicated region.
- **[[wiki/concepts/subjective-value.md]]** — the boundary condition on that page's common-currency scalar: the vmPFC value signal appears only when the option's decomposition is automatic, and is replaced by an FPl+PCC signal when it is not — so a single represented value is the *easy-case* architecture, not the general one.
- **[[wiki/concepts/cognitive-control.md]]** — the top-down edge that page's bias signal needs a target for: mid-DLPFC is proposed to set the *filter weights* of the decomposition rather than to bias a response, which is control acting on a representation's basis instead of on a competition between outputs.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — a transfer in the under-used direction, with a method: train a network on the subjects' own choices, then map its *stages* onto regions by representational similarity, and ablate a structural hyperparameter (filter count) to test which stage-property the region has.
- **[[wiki/concepts/analogical-mapping.md]]** — the causal lesion evidence for that page's frontopolar integrator, and the challenge to it: 27 patients put analogy in the left frontal pole, 247 patients put it in a network posterior to it, with a task difference (identify vs apply) the proposed but untested reconciliation.
- **[[wiki/concepts/node-definition-problem.md]]** — a worked case: FPl exists as a distinct node under cytoarchitecture and under connectivity fingerprinting, both agreeing, while every patient series that tests it has lesions crossing the boundary — so the parcellation is sharper than any evidence about its function.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the ACC end of this page's model, and where the macaque does the counterfactual bookkeeping that humans additionally route through FPl; the same computation with an extra parallel stage is a weaker evolutionary claim than a new computation, and this is the wiki's clearest instance of it.
