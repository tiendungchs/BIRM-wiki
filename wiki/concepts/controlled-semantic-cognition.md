# Controlled Semantic Cognition — A Transmodal Bottleneck Plus a Separate Controller

**Concepts are computed in one graded transmodal hub that all modality-specific "spokes" write into and read from; a second, largely separate network decides which parts of the resulting activation propagate for the task at hand. The two are doubly dissociated by lesion, and the dissociating signature is behavioural, cheap, and has never been run on a machine.**

> **Provenance.** Lambon Ralph, Jefferies, Patterson & Rogers 2017, *The neural and computational bases of semantic cognition*, Nature Reviews Neuroscience 18:42–55, doi:10.1038/nrn.2016.150 (`raw/lambonralph-2017-neural-computational-bases-semantic-cognition.md`). A review by the framework's own proponents summarising a decade of their programme; the connectionist model is theirs, and the rival accounts (convergence zones, distributed domain-specific, fully-distributed feature-based) are stated in their words. Boxes 1–4 are absent from the clipping, so the computational motivation for the control half is present only in outline. Abbreviations used below: ATL (Anterior Temporal Lobe), SD (Semantic Dementia), SA (Semantic Aphasia), HSVE (Herpes Simplex Virus Encephalitis), pMTG (posterior Middle Temporal Gyrus), IFS (Inferior Frontal Sulcus) — all in [[wiki/glossary.md]].

The wiki's grounding pages each derive a symbol from a channel: actions ([[wiki/concepts/affordance-grounded-symbols.md]]), graph position ([[wiki/concepts/abstract-structural-codes.md]]), a caption ([[wiki/concepts/cross-modal-grounding.md]]). None of them says **where the modalities meet**. This page is the answer the neuropsychology forces, and it is architectural rather than objective-level: *one* shared bottleneck, not pairwise adapters, and its functional specialization is a consequence of wiring distance rather than of a design decision.

---

## The two systems

| | Representation | Control |
|---|---|---|
| Job | Encode higher-order relationships among sensory, motor, linguistic and affective sources; promote generalization across items and contexts | Constrain how activation propagates through the representation network so that the output fits the current task, time and context |
| Anatomy | Ventrolateral ATL hub (bilateral) + modality-specific spokes distributed across cortex | Distributed: ventral prefrontal, pMTG, IFS, intraparietal sulcus, pre-supplementary motor area, anterior cingulate–ventromedial prefrontal |
| Load profile | Always on; carries the item | Recruited only when the needed information is weakly encoded, a dominant associate must be suppressed, an uncharacteristic feature must be foregrounded, or the input conflicts with the evolving context |
| Lesion syndrome | SD — progressive bilateral ATL atrophy | SA — prefrontal *or* temporoparietal damage, or both |
| Machine analogue | A shared latent all encoders write into | A context-conditioned gate on propagation through that latent |

**The load profile is the design claim worth taking.** Control is not a stage in a pipeline; it is a *demand-triggered* term. In well-practised contexts the representation network alone produces the correct response, and control is called only when the representation is ambiguous, weak, or in conflict with context. This makes the controller's engagement an observable — [[wiki/concepts/adaptive-computation-time.md]]'s halting problem stated as a recruitment problem, with the trigger located in the representation rather than in a separate difficulty estimator.

---

## Why the hub is not optional

The computational argument, in the source's own terms:

- Information relevant to one concept arrives **across modalities, contexts and time points**.
- **Conceptual structure is not transparently reflected in sensory, motor or linguistic structure** — the map from modality features to conceptual similarity is "complex, variable and nonlinear".

A system that encodes only direct associations among modality-specific sources therefore cannot recover conceptual similarity structure; an intermediating layer common to all concepts and all modalities can. The claim is not that a hub is convenient but that generalization requires a representation whose similarity metric is *learned* rather than inherited from any input space. The distributed-only rivals deny exactly this, and the machine version of the comparison has never been run — `T331`.

**The empirical leg is SD.** Item-by-item success in SD is predicted by exactly three factors — **familiarity** (higher is better), **typicality within the domain** (more typical is better), **specificity demanded** (more specific is worse) — and by nothing about modality, response type, or knowledge type. Deficits are consistent across tasks that share almost nothing but the item. Only one number knows all the items: a single store.

| Prediction of the hub view | Instrument | Result |
|---|---|---|
| ATL engages irrespective of input modality (words, objects, pictures, sounds) and category | distortion-corrected fMRI, electrocorticography, cortical grid stimulation, FDG-PET in SD | holds; centre-point is ventral–ventrolateral ATL |
| ATL codes semantic *similarity structure*, not a pointer | MVPA of fMRI and of electrocorticography | representational merging of modality-specific sources in the same area |
| Hub damage is category-general, spoke damage category-specific | inhibitory TMS in intact subjects | lateral-ATL TMS → domain-general slowing; parietal praxis-region TMS → slower naming of man-made objects only |
| Comprehension tracks hub–spoke coupling, not just hub integrity | resting-state fMRI in SD | accuracy reflects both ATL atrophy *and* the reduction in hub–spoke functional connectivity |
| ATL is semantically selective, not just "hard task" cortex | equally demanding non-semantic tasks | ATL not engaged |

**Timing, and a coarse-to-fine signature.** Detailed semantic information is present in ventral ATL from ~250 ms; coarse domain-level distinctions may be available at ~120 ms. **(brainstorm)** That ordering is what an iterative settling process looks like from outside, and it is the cheapest available discriminator between a hub that is *read once* and a hub that is *relaxed to*: a feed-forward bottleneck should not produce a domain code 130 ms before it produces an item code. The source's own listed unknown — "are the core components of a concept available when the hub is first activated, or do they require ongoing interaction between hub and spokes?" — is this question, and it is the same relaxation-versus-lookup fork that `G21` runs on.

---

## Graded specialization is a consequence of connectivity, not a partition

The ATL is not a module and is not a set of modules. Cytoarchitecture is graded (Brodmann's own caveat: temporal and parietal regions "undergo gradual transitions"), the major fasciculi terminate in *partially overlapping* ATL territories, and dense local U-fibres smear whatever differentiation remains.

| ATL subregion | Dominant long-range connection | Functional tilt |
|---|---|---|
| Ventrolateral (centre-point) | equally to all | domain- and modality-general; the hub proper |
| Medial | inferior longitudinal fasciculus ← visual | picture-based material, concrete concepts |
| Anterior superior temporal sulcus/gyrus | extreme capsule ← prefrontal language; middle longitudinal fasciculus ← inferior parietal | auditory, spoken words, abstract concepts, combinatorial semantics |
| Temporal pole | uncinate fasciculus ← orbitofrontal | social concepts, affect |

The mechanism is Plaut's: give the hidden units **distance-dependent connection strengths** to the spokes, and a unit's importance to a function follows its connectivity to the relevant spoke. Units furthest from every input contribute equally to everything; units near the visual spoke contribute more to picture naming and less to sound-cued naming. No unit is dedicated. The graded-hub extension replaces "distance in a model" with "long-range cortical connectivity", and the same story is claimed to hold in the visual and auditory streams — connectivity-induced graded function as a general cortical principle.

**What a builder gets for free.** Category-specific behaviour need not be designed. Weight the connections from a shared latent to each modality encoder by anything monotone in distance, and (a) the latent is domain-general at its centre, (b) it is modality-tilted at its edges, (c) ablating an edge produces a category-specific deficit while ablating the centre produces a category-general one. This is the cheapest existing answer to [[wiki/concepts/emergent-modularity.md]]'s question of where specialization comes from without a specialization objective — and it is a *wiring prior*, not a loss term.

**And what it costs.** The graded story denies the wiki's usual working assumption that a region is a node with a job. It is [[wiki/concepts/node-definition-problem.md]] with a behavioural arbiter attached: the discrete alternative (convergence zones, one zone per category or per task) is rejected here not on parcellation grounds but because it cannot explain a pan-category, pan-modality deficit from one lesion site.

---

## The lesion-schedule result, and why it should worry a continual-learning designer

SD and HSVE damage highly overlapping ATL territory (HSVE more medially). SD gives a category-general deficit. HSVE reliably gives **better knowledge of man-made artefacts than of natural kinds** — but only at the basic level (`dog`, `knife`); at the subordinate level (`poodle`, `bread knife`) HSVE cases are equally and severely impaired for both.

The same connectionist model reproduces both from **the schedule of damage alone**:

| Damage regime | Model outcome | Reading |
|---|---|---|
| Progressive degradation, no relearning | category-general loss | SD; the disease outruns any re-consolidation |
| *En masse* hub damage **followed by retraining** | artefacts recover, animates do not | HSVE; with reduced representational resources the network cannot recapture enough "semantic acuity" to separate conceptually tightly-packed neighbourhoods |

**(brainstorm)** Read without the clinical vocabulary this is a statement about capacity and neighbourhood density under recovery, and it is a prediction the wiki can test on any over-parameterised encoder: prune a shared latent hard, then fine-tune, and the classes that fail to come back should be the ones whose neighbours are nearest in the *pre-damage* representational geometry — not the rarest, not the least trained. The measurable is a rank correlation between per-class recovery and per-class local density, and if it holds it makes "catastrophic forgetting" partly a resolution problem rather than an interference problem ([[wiki/concepts/continual-learning.md]], [[wiki/concepts/representational-collapse.md]]). The clinical version also warns that *when* the capacity is removed changes what is lost from the same lesion, which no continual-learning benchmark in the wiki varies.

---

## The double dissociation, restated as a certification instrument

This is the most transferable thing in the source. Two lesions to one system produce qualitatively — not quantitatively — different profiles, and the contrast is measurable with items alone.

| Probe | Degraded representation (SD) | Disordered control (SA) |
|---|---|---|
| Consistency of the same item across different tasks | **high** — the same items fail everywhere | **low** — inconsistent across tests |
| Sensitivity to item frequency/familiarity | **strong** | **absent** |
| Sensitivity to typicality | strong | weak/reversed |
| Effect of executive demand of the task | small | **largest effect** |
| Word ambiguity / semantic diversity (`bark`, `pen`, `chance`) | little effect | **strong impairment** |
| Phonemic cue (picture of a tiger, cue "t") | still fails | often succeeds |
| **Mis**cue (same picture, cue "l") | still nothing | says "lion" |
| Error type in naming | coordinate, superordinate | **associative** ("milk" for a cow) — essentially never seen in SD |
| Category fluency | within-category, impoverished | drifts by association: "cat, dog, horse, saddle, whip…" |
| Inhibition of strong competitors | intact | fails |

The cue/miscue row is the sharpest: **an intact store with a broken controller is exactly a system that is driven by whatever partial evidence is supplied**, correct or not. A degraded store cannot be driven at all. Two directions of the same manipulation, opposite signs, no modelling assumptions.

**Nothing in the wiki has been scored on this.** Every architecture here that claims a knowledge/control separation — [[wiki/concepts/controller-knowledge-vs-process.md]]'s representational and processing controllers, [[wiki/entities/pbwm.md]]'s gate over a maintained content, sparse-expert routing over a shared trunk ([[wiki/concepts/sparse-expert-routing.md]]) — asserts the separation architecturally and tests it, if at all, by ablation accuracy. The table above is a *profile*, not a score, and a model whose "controller" ablation lowers accuracy while leaving the frequency sensitivity intact has not demonstrated a controller. Opened as `G109`.

---

## The control network is graded too

SA arises from prefrontal *or* temporoparietal lesions with only small behavioural differences, which dissolved the original puzzle (imaging said prefrontal, the classical patients were temporoparietal). Within the network:

| Axis | Inferior/anterior: ventral prefrontal, pMTG | Superior/posterior: IFS, intraparietal sulcus |
|---|---|---|
| Responds to | retrieval of **weak** semantic associations | high **selection** demand |
| Domain | semantic-specific | domain-general (multiple-demand) |
| Connectivity to ATL | robust, structural and functional | absent |
| Inhibitory TMS | slows semantic judgements only | slows difficult semantic **and** non-semantic decisions |
| Lesion side-effect | — | anterior lesions add refractory effects (proactive interference across trials) and perseveration |

Mid-lateral prefrontal correlates with both, i.e. the same graded-not-partitioned organisation as the hub.

**The two-term reading a builder should take.** The domain-general controller ([[wiki/entities/lateral-frontoparietal-network.md]], [[wiki/concepts/cognitive-control.md]]) does not touch the representation network directly; it acts *through* semantic-specific intermediaries (ventral prefrontal, pMTG) whose only qualification is that they are wired to the hub. So the control interface is not "the controller biases the representation" but **"a general controller biases a domain-specific adapter that is wired into one representation store"** — a three-layer arrangement, and the middle layer is the part no machine architecture in the wiki has. Its predicted signature is recruitment *from below*: pMTG and ventral prefrontal should fire when the semantic system's own activation is ambiguous or unexpected, with no top-down goal change at all.

---

## Reading in the core framing

| CSC object | Latent-graph reading |
|---|---|
| Spokes | Modality-specific observation channels; each an incomplete view of the same latent |
| ATL hub | The shared latent whose metric *is* conceptual similarity — the node embedding, learned so that generalization is a nearest-neighbour operation |
| Graded hub periphery | Node embeddings partially tied to one channel — the price of wiring, and the source of category effects |
| Semantic control | Context-conditioned gating of propagation through the graph: which edges from the current node are traversed given the task |
| SD | The node embedding degrades; edges are fine and useless |
| SA | The embedding is intact; traversal is unconstrained, hence associative drift — a random walk where a directed one is needed |

**Associative drift as an unconstrained walk is the cleanest bit of this mapping.** "cat, dog, horse, saddle, whip" is a walk on the semantic graph with the category constraint dropped after step three. The controller's job in graph terms is to keep the walk inside a subgraph the task specifies — which is [[wiki/concepts/subgraph-matching.md]]'s constraint applied online rather than as a search.

---

## Open problems

- **Feature-based representation cannot express relation *type*, and the source says so.** `car`→`vehicle` (class inclusion) and `car`→`wheels` (possession) are both feature co-occurrences and license opposite inductions: "all vehicles move" generalizes to `car`; "all wheels are round" does not. Nothing in the hub-and-spoke architecture types an edge. This is the wiki's own central problem arriving as an admission from the strongest distributed-semantics programme, and the review's answer is that "a comprehensive understanding of the neural systems that support relational knowledge awaits future work."
- **The ventral/dorsal double-extraction hypothesis.** Two orthogonal statistical extraction processes are proposed: the ventral (temporal) pathway integrates *over time and contexts* to yield item-based concepts; the dorsal (parietal) pathway integrates *over items* to yield item-independent structure — syntax, time, space, number. **(brainstorm)** This is the wiki's `g`/`x` split with an anatomy and, more usefully, with a *training recipe* for each half: the same data, two different marginalisations. Nothing in the wiki trains two encoders on one stream that differ only in which index they average over, and it is a cheap ablation.
- **Hub–spoke interaction dynamics are unmeasured.** The relative contribution of hub versus spokes, and the time course of settling, are named as open by the authors.
- **What recruits control is unknown.** "Very little is known about the circumstances and neural systems that recruit semantic control" — the trigger for the demand-gated term above is the framework's least specified part, and it is exactly the part a machine implementation must make explicit.
- **Abstract, social and emotional concepts.** How they sit on the graded hub, and whether they load the control network differently, is listed as future work; the abstract–concrete distinction is reported to be multidimensional rather than a single axis.

---

## Connections

- **[[wiki/concepts/cross-modal-grounding.md]]** — supplies the architectural answer that page's rate–distortion frame leaves open: modalities are not paired encoder-to-encoder but all routed through one transmodal store whose metric is learned, so the caption is one spoke among many rather than the alignment target — and the graded-hub result predicts that a shared latent wired unequally to its channels will show that page's category-tilted failures without any objective encoding them.
- **[[wiki/concepts/controller-knowledge-vs-process.md]]** — the SD/SA double dissociation is the strongest evidence that page's debate has: a control lesion leaves item knowledge intact and frequency sensitivity absent, which is the processing-controller signature, while the representational-controller reading has to explain why miscueing *drives* SA patients to the wrong answer rather than failing to retrieve.
- **[[wiki/concepts/node-definition-problem.md]]** — the same problem with a behavioural arbiter: the ATL is graded in cytoarchitecture, connectivity and function, so any parcellation into "the semantic regions" invents boundaries the tissue does not have — and the discrete alternative (convergence zones, one per category) is rejected because it cannot produce a pan-category deficit from one lesion.
- **[[wiki/concepts/cognitive-control.md]]** — adds a layer that page's bias account does not have: the domain-general multiple-demand controller (IFS, intraparietal sulcus) has no connectivity to the semantic store and acts through semantic-specific intermediaries (ventral prefrontal, pMTG), so "biasing a competition" requires an adapter wired to the representation being biased.
- **[[wiki/entities/lateral-frontoparietal-network.md]]** — the overlapping and the non-overlapping halves: intraparietal sulcus and inferior frontal sulcus appear in both networks as the domain-general term, while the semantic-control-specific nodes (pMTG, ventral prefrontal) do not appear in the relational-reasoning set at all — evidence that the control network is per-representation-store, not one supermodule.
- **[[wiki/concepts/continual-learning.md]]** — a lesion-schedule result that no benchmark there varies: the same network, damaged progressively versus damaged at once and retrained, loses *different categories*, and the retrained case fails specifically on classes whose representational neighbours are nearest.
- **[[wiki/concepts/emergent-modularity.md]]** — the cheapest known route to functional specialization without a specialization objective: distance-dependent connection strengths from a shared hidden layer to modality-specific inputs make central units domain-general and peripheral units modality-tilted, purely as a wiring prior.
- **[[wiki/concepts/information-bottleneck.md]]** — the hub as a bottleneck with an unusual justification: it is required not to discard nuisance information but because conceptual similarity is a nonlinear, non-transparent function of every input space, so the metric has to be learned somewhere that sees all of them.
- **[[wiki/concepts/abstraction.md]]** — a ninth operationalisation of the word, from the clinical side: a concept is abstract to the extent that its retrieval is invariant to input modality and response modality, which is what makes SD's cross-task consistency a *measurement* of abstraction rather than of severity.
- **[[wiki/concepts/subgraph-matching.md]]** — the SA fluency profile is that page's constraint failing online: "cat, dog, horse, saddle, whip" is a walk that leaves the specified subgraph, so semantic control is the operation that keeps a traversal inside a task-specified region rather than a search over stored structures.
- **[[wiki/concepts/adaptive-computation-time.md]]** — the same halting question with the trigger relocated: control is recruited by properties of the *representation* (ambiguity, weak encoding, conflict with context) rather than by a separate difficulty estimator, which makes recruitment observable and gives a demand-gated controller a stopping rule for free.
