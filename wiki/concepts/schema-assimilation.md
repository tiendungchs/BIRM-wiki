# Schema Assimilation and Accommodation

**A schema is any organized network of overlapping representations that (i) makes a fitting new item easier to encode, (ii) is itself modified when a new item challenges it, and (iii) supports inference between elements that were never experienced together. Adding a new experience to one is *assimilation*; rewriting the network to accept it is *accommodation*. The claim that matters for a builder: the amount of accommodation a new experience demands — not how old the memory is — determines which module is required at each stage of its life.**

> **Provenance.** Preston & Eichenbaum 2013, *Interplay of hippocampus and prefrontal cortex in memory*, Curr Biol 23:R764–R773 (`raw/preston-2013-hippocampus-prefrontal-memory.md`). A review reconciling rodent lesion/ephys work with human neuroimaging on associative inference, food-location schemas and remote memory. Piagetian terms (assimilation, accommodation, equilibration) are the authors' own framing, imported deliberately.

Why this earns a page rather than a paragraph on [[wiki/concepts/complementary-learning-systems.md]]: that page indexes consolidation by **time** and by **rate**. This one indexes it by **overlap with what is already stored**, which is a different variable, measured differently, with a different lesion signature — and it is the variable the wiki's core framing already cares about, since overlap with prior knowledge *is* the question of whether the current situation lands inside a known subgraph ([[wiki/concepts/latent-graph-discovery.md]]).

---

## The operational definition, and its graph reading

The authors explicitly reject the "schema = gist, abstraction of common elements only" definition (which would make a schema a semantic average, and consolidation a lossy compression) in favour of a definition by three testable properties. Both readings are live in the literature; the source picks the second and says so.

| Property | Test used | Latent-graph reading |
|---|---|---|
| New information fitting the schema is better remembered | Tse et al. 2007: after a flavour–place schema is built, a *new* flavour–place pair is learned in **one trial** and retained 24 h; no benefit transfers from an equivalent schema in a *different* environment | Adding an edge whose endpoints are already nodes of a known subgraph costs `O(1)`; the subgraph must be the *same* one, so the saving is not generic prior training |
| Information that challenges the schema modifies it | Reconsolidation after a reminder that carries new, conflicting content; extinction as the canonical case | Edge rewriting — the expensive operation, and the one the source assigns to prefrontal cortex |
| The schema supports inference between indirectly related elements | Associative inference (learn A–B, B–C; test A–C) in rats, and the same design in humans under fMRI; transitive inference | Path query through a shared node — the minimal case of multi-hop traversal over a *discovered* rather than given graph |

**Property (iii) is the reason this page exists.** It is the only definition of "prior knowledge" in the wiki that is tested by a *query the training data never contained*, which is exactly the abstract-reasoning criterion the wiki is built around.

---

## The division of labour, by stage

The source's Table 1, restated. Read across a row for what one structure does over the life of a memory; read down a column for who does what at one stage.

| | **Learning** | **Consolidation** | **Expression** |
|---|---|---|---|
| **Hippocampus** | Represent links between the elements of a *new* association | Use the invariant shared element to link overlapping associations in specific neocortical areas | Retrieve links, direct and indirect, *within the schema the prefrontal cortex has selected* |
| **Prefrontal cortex** | Reconcile the new association with existing ones whose elements overlap | Create the schematic organization spanning multiple overlapping memories | **Select** the correct schema for the current situation |

So the composite operation is: `cue → PFC selects schema (A–B–C) → HPC retrieves the path (A–C via B)`. The hippocampus supplies the *binding through the invariant common element*; the prefrontal cortex supplies *which set of bindings is live and how conflicts among them were resolved when they were written*.

---

## The selection result, and why it is the sharpest thing here

Rats use one of two spatial contexts to disambiguate contradictory object–reward associations. Dorsal-hippocampal cells fire for specific objects in specific places per context.

| Manipulation | Result | Reading |
|---|---|---|
| Intact | Context-appropriate object memory retrieved | Baseline |
| **mPFC inactivated** | Dorsal hippocampal neurons retrieve **both** appropriate and inappropriate object representations | The store retrieves fine without the controller; what is lost is *selection among what was retrieved* |

**This is a causal, cellular answer to gap G37's second half.** Every retrieval mechanism in the wiki — geometric subgraph matching, responsibility posteriors, attractor relaxation, context masking — is a scheme for making the *right* structure come back. This experiment says the biology does not do that at the store at all: the store returns everything the cue touches, and a separate module suppresses the part the context does not license. That is a different architecture, with a different failure mode (confident, context-inappropriate output rather than a miss), and it matches the inhibitory reading of the hippocampal→prefrontal channel from the other direction ([[wiki/empirical-tensions.md]] T98).

The human lesion analogue is the A–B, A–C paired-associate task: prefrontal patients learn A–B, then fail to learn A–C with **intrusions of B** — and the same intrusion pattern appears across two lists of *unrelated* associations, so the deficit is not specific to shared elements.

**(brainstorm)** A cheap machine test: on a retrieval-augmented model, measure top-`k` recall *before* the reranker and context-appropriateness *after*. If selection and retrieval are genuinely separable, ablating the reranker should leave recall@k flat and drive the error rate to the base rate of context-inappropriate neighbours — a signature nobody reports because retrieval is scored end-to-end.

---

## The long axis is a generality gradient, and only its general end reaches the controller

| | **Dorsal (rat) / posterior (human) hippocampus** | **Ventral (rat) / anterior (human) hippocampus** |
|---|---|---|
| Coding | Specific objects at specific locations within a context | Generalized representation of *all* events comprising a context; discriminates between contexts better than the dorsal end does |
| Human fMRI | Information content of individual events; retrieval of specific events | Salience/gist of events; retrieval of the general context |
| Projection to mPFC | — | **Direct** |

So the map is not one code at one grain: the same structure holds an item-specific and a context-general representation at opposite poles, and **the controller is wired only to the general pole**. The proposed loop closes: ventral hippocampus builds the context representation → mPFC learns the contextual rule over it → on re-entry the ventral signal cues mPFC → mPFC selects the rule and biases dorsal hippocampal retrieval, via perirhinal/lateral entorhinal cortex.

This is the same anatomy [[wiki/entities/medial-prefrontal-cortex.md]] establishes as one-way and inhibitory; this source supplies the *content* on it — a generality-graded context code — which that page listed as unmeasured. It also lands on the wiki's live question of whether one item set gets one map or several ([[wiki/empirical-tensions.md]] T51): here it gets **two**, at different grains, on one axis, with a known consumer for each.

**Two grains understates it — the axis is a continuum, and it carries a second, discrete organization at the same time.** CA3 place-field width grows near-linearly from ~1 m at the dorsal pole to ~10 m at the ventral pole, so "item-specific vs context-general" is the readout of a *scale* gradient rather than a two-way split; and superimposed on that gradient are sharply bordered gene-expression domains plus an abrupt association-fibre and theta-coherence seam at the ventral one-third. The proposed mechanism converting scale into generality — wide fields and slow cell oscillation let more, and more widely separated, assemblies fire inside a single theta cycle, making non-adjacent representations bindable — is carried on [[wiki/concepts/hippocampal-long-axis.md]] (Strange et al. 2014), together with the caveat that nothing has yet tested whether the functional gradient steps where the genetic borders are.

---

## Integration demand, not age, indexes module involvement

The reconciliation the review is built to deliver. The divergent findings are: mPFC needed only at remote delays (contextual fear) vs. mPFC needed from the outset (associative inference, food-location schema, transitive inference — where mPFC damage both slows acquisition of the overlapping pairs and blocks inferential expression).

| Overlap of the new event with existing knowledge | Prefrontal involvement | Example |
|---|---|---|
| **Low** — no pre-existing schema for this context | Absent at learning; grows with time as the memory is progressively assimilated/semanticized | Single-shock contextual fear: the animal has no model of what to expect in the new box |
| **High** — the new event conflicts with stored associations of a shared element | **Required from the outset**, and throughout consolidation and expression | Learn B–C having learned A–B; put a new flavour in a familiar arena |

And a second, independent curve for the hippocampus:

| Episodic detail retained? | Hippocampal involvement |
|---|---|
| High (autobiographical, episodic) | Required across learning, consolidation *and* expression — a flat retrograde gradient |
| Low (memory becomes generic / semanticized on integration) | Confined to the consolidation period |

**Consequence for a builder.** Every consolidation schedule in the wiki is a function of time-since-write. This says the schedule should be a function of **(conflict with stored content, detail required at read time)** — both computable online, neither a clock. The failure mode of a time-indexed scheme is exactly the divergence the literature shows: two experiments with the same delays and opposite results because their integration demands differed.

**(brainstorm)** The conflict term is already available in most architectures and thrown away: it is the disagreement between the fast store's retrieval for the current cue and the new observation. Gate the slow learner's write on it and you get the red/green curve split for free — high-conflict items engage the slow learner immediately (because the slow learner is the only thing that can rewrite the structure), low-conflict items are transported lazily. This is the complement of recall-gated consolidation ([[wiki/concepts/recall-gated-consolidation.md]]), which gates on *agreement*: agreement says "this is worth keeping", conflict says "this needs the expensive module". Nothing in the wiki uses both signs of the same statistic.

The source also raises the species scaling as a prediction: consolidation duration is longest in humans, intermediate in monkeys, shortest in rodents, and the proposed explanation is **schema richness** — rodents have few and simple schemas so few new events incur integration demand, humans process nearly everything against an elaborate prior structure. Under this reading consolidation time is not a biological constant to be matched but a function of how much prior structure the system has.

---

## Assimilate first, differentiate later

The one longitudinal ensemble result. Rats already knowing several goal locations in an environment learn new ones while hippocampal cells are recorded across days.

| Phase | Observation | Piagetian label |
|---|---|---|
| Before | Cells fire at multiple goals, different subsets and patterns per goal | The schema: goals linked *and* distinguished within one spatial scheme |
| During new learning | The cells that fire at new goals are **largely the same cells** already firing at old goals, with **similar patterns** | Assimilation — the new item is initially coded *as* an instance of the old |
| After (days) | Old-goal patterns change (rate changes, dropout); new- and old-goal patterns **gradually diverge** | Accommodation — differentiation is the slow part |

**(brainstorm) This runs opposite to the standard CLS story and is the most importable claim on the page.** Complementary learning systems has the fast store *separate* first (sparse conjunctive codes, minimal overlap) and the slow store generalize later. Here the trajectory is the reverse: maximal overlap at write time, differentiation over days of consolidation. Both cannot be the default. The reconciliation the wiki can state: pattern separation is the policy for events with **no** matching schema, and assimilation-then-differentiation is the policy for events **inside** one — which makes the separate-vs-integrate knob of [[wiki/concepts/pattern-separation-completion.md]] set by schema match rather than by raw input similarity, and gives gap G38 a criterion it currently lacks. Testable and cheap: run a memory model on paired protocols where input similarity is held fixed and prior-structure membership is varied, and check whether write-time overlap moves.

It also identifies which representation the *slow* differentiation acts on — the shared cells' rates, not the identity of the cells — which is a smaller edit than any machine consolidation scheme performs.

---

## Conflict is the trigger, and there are two ways to resolve it

Human associative inference under fMRI (interleaved A–B then B–C, tested on A–C):

- During B–C encoding, subjects **reinstate the A representation** — a retrieval running inside an encoding episode, presumably by hippocampal completion. The conflict is created, not avoided.
- Ventromedial prefrontal–hippocampal coupling **increases across repeated presentations** of the overlapping pairs.
- Greater vmPFC recruitment **in the presence of greater mnemonic conflict predicts better later inference** — conflict is not noise to be suppressed, it is the signal that the expensive integration is worth running.
- vmPFC–hippocampal coupling **persists into post-task rest**, and correct use of a newly acquired conceptual rule is predicted by hippocampal–vmPFC connectivity.

**The primary source for the first two bullets is now on its own page** ([[wiki/concepts/retrieval-mediated-learning.md]], Zeithamova et al. 2012), and it corrects the review's summary in two ways this page should carry. The reinstatement is *measured*, by a classifier reading the unseen third element during re-presentation of the first pair — null on the first repetition, significant on the second and third — and it is **anterior MTL cortex, not hippocampus**, whose learning-related change tracks reinstatement magnitude (r = 0.54, the only one of 13 regions). And the conflict claim is weaker than "greater recruitment under greater conflict": what is shown is that vmPFC activation *increases* across repetitions in better inferrers, surviving a partial correlation for premise memory (partial r = 0.53), while the hippocampal effect largely does not survive it (r = 0.51 → 0.22 n.s., right hemisphere only at p = 0.05). Mnemonic conflict is still not measured within a trial — the open problem below stands.

Against this, lateral prefrontal cortex resolves the *same* competition the other way — by making individual memories more **distinctive** and hence less interference-prone.

| | Ventromedial PFC | Lateral PFC |
|---|---|---|
| Resolution strategy | **Integrate**: build one structure spanning the conflicting items | **Separate**: encode/retrieve so the items stop competing |
| Downstream capability | Inference between indirectly related elements | Interference resistance, veridical recall of the individual item |
| Cost | Loss of item distinctiveness; the schema can distort the item (Bartlett) | No inferential path is built |

**These are two policies over one conflict signal, and the source states no arbitration rule** — nor does it know whether their time courses differ. That is a clean open question with an obvious machine analogue: on encountering a new item that conflicts with a stored one, a system may merge them under a common structure or push them apart, and every wiki mechanism that touches this (dentate expansion recoding, memory allocation by excitability, engram linking) implements one policy without a selector between them.

---

## The human substrate, and a wider definition of what is in a schema

> **Provenance (second ingest).** Lieberman & Meyer 2018 (`raw/lieberman-2018-mpfc-social-self-affective.md`). The page above rests on rodent lesion work plus the "rat mPFC ≈ human vmPFC" homology it flags as unfinished. This source supplies the human half from four method families at once, and arrives at the schema from an unexpected direction: a region of ventromedial prefrontal cortex that is *non-selective* across five psychological domains ([[wiki/entities/medial-prefrontal-cortex.md]]).

| Evidence | Result |
|---|---|
| Brodmann-area-11 lesions | **Diminished assimilation of new information into existing schemas**; less schema-biased recall |
| Functional imaging, encoding schema-congruent material | Greater ventromedial activity and connectivity |
| Disambiguating cue (an ambiguous vignette plus a picture that makes it interpretable) | Higher **inter-subject correlation** in the same region when the cue is the correct one — the situation model is shared across people who have understood the same thing |
| Reverse inference against 3107 terms | The non-selective cluster's top terms include `scene` and `events`; the neighbouring ventral cluster's top terms are `social`, `social cognitive`, `interpersonal`, `beliefs`, `traits` |

**The definitional move.** The authors call the content **situational processing**, and define it wider than either "scene" or "schema": *how a situation is represented in terms of its spatial, temporal, causal, evaluative and social aspects together, as an integrated set of situational associations.* Scene construction and schema-based cognition are then components of it rather than rivals to it.

| This page's schema | Lieberman & Meyer's situation model |
|---|---|
| Defined by three *functional* tests (fit-benefit, modifiability, inference between indirectly related elements) | Defined by *content type* — the five aspect classes an integrated situation must carry |
| Silent on what a schema is made of | States the slot list, and it includes evaluative and social dimensions that no navigation-derived schema in the wiki has |
| Selected by prefrontal cortex, retrieved via hippocampus | Same region, plus the claim that this is *why* it shows up in social, self, value, emotion and mental-time-travel studies alike — those are five queries against one representation |

**(brainstorm) The set-difference test is the cheap version of this claim, and it is the one the source did not run.** If the region holds an amodal situation model rather than five domain functions, then within any one domain its engagement should track *situational demand* and not the domain label — a mentalizing task that requires knowing whether the actors are in public or private should recruit it, and one that does not should not. Restated for a builder: **the situation slot is a variable a task either binds or leaves free, and the wiki has no benchmark that manipulates it.** Every reasoning benchmark here specifies the situation completely in the prompt; none tests whether a model *retrieves* the unstated spatial/causal/evaluative/social surround that makes an underdetermined observation interpretable — which is the operation this region is proposed to perform and the one that makes one-trial schema-fitted learning possible at all.

**A caution the tension table now carries.** The claim is an educated guess by the authors' own statement, and its central variable is never manipulated — which is exactly the criticism this page already levels at *integration demand* under Preston & Eichenbaum. Two independent literatures have now named the schema's trigger and neither has measured it.

---

## A schema can be induced from two examples, and comparison is the operation that does it

> **Provenance (third ingest).** Holyoak 2012 (`raw/holyoak-2012-analogy-relational-reasoning.md`). This page's schemas arrive by consolidation over many episodes; the analogy literature builds one from **two**, in minutes, by aligning them.

Comparison here is not passive accumulation of feature statistics across examples — it is active generation of structural correspondences ([[wiki/concepts/analogical-mapping.md]]), and the schema is the *intersection* the mapping exposes.

| Result | Number |
|---|---|
| Schema induced by comparing **two** disparate analogs, improving transfer to a third (Gick & Holyoak 1983) | — |
| Schemas form as a *side effect* of applying one solved problem to an unsolved one (Novick & Holyoak 1991; Ross & Kennedy 1990) | — |
| Abstraction training over three convergence analogs, then the tumour problem **one week later, in a different experiment, with no hint** (Catrambone & Holyoak 1989) | **>80%** solve |
| Stating the solution principle abstractly alongside each story | Facilitates induction (Gick & Holyoak 1983) |
| A schema acquired *later* makes analogous episodes stored *earlier* easier to retrieve (Gentner et al. 2009) | Works backwards in memory |

**Two mechanisms worth importing.**

- **Progressive alignment** (Kotovsky & Gentner 1996): order the comparisons easy-to-hard, where early pairs share salient surface similarity **and** the relational match, and later pairs share only the relational match. Surface similarity bootstraps the correspondence, which then survives its own removal. This is a curriculum specified by the *relation between consecutive examples* rather than by difficulty — the concrete proposal gap G32 asks for, and it is cheap to run.
- **Focus determines schema quality**: schemas built while attending to goal-relevant relations transfer; schemas built on incidental detail do not.

**And the counterweight — a schema you already have can silently rewrite the situation.** Bassok, Wu & Olseth 1995: formally isomorphic permutation problems where an "assign" relation is read through an overlearned **get** schema (the person receives the object) regardless of the roles the stated relation assigns. Transfer is **89%** when source and target share the object→person direction and **0%** when they do not. Assimilation is not a benign fit-benefit here: the schema fires unconditionally on object *types* and re-parses the input, and every downstream step then works correctly on the wrong structure. This is the sharpest measurement in the wiki of gap G23 (a prior with no entry test) and it lands squarely on this page's unresolved item — **schema identity is unoperationalised**, so nothing decides whether the get schema applies.

---

## Relational access is bought by uniform encoding, not by indices

> **Provenance.** Forbus, Gentner & Law 1995 ([[wiki/entities/macfac.md]]). Why some people retrieve the structurally right schema and most people do not.

Retrieval of a stored structure on relational grounds is rare in general (~.12 against ~.53 for surface matches) but rises reliably under two conditions, and the proposed cause is the same in both:

| Condition | Evidence | Mechanism proposed |
|---|---|---|
| **Domain expertise** | experts retrieve structurally similar problems more often, and reject surface-similar ones faster (Novick 1988) | experts have a comprehensive domain theory, which promotes a **uniform relational vocabulary**; every item encoded with the same higher-order predicates shares index terms with every other |
| **Intensive encoding** | comparing two prior analogs rather than reading them (Gick & Holyoak 1983; Catrambone & Holyoak 1987/89), writing out a proverb's meaning, studying themes before judging story pairs (Seifert et al. 1986), intensive LISP training (Faries & Reiser 1988) | the same: encoding operations that force explicit relational structure put those relations into the index for free |

**The claim worth taking: an index that is *computed from* the representation updates automatically when the representation improves, so schema retrieval can be improved by changing how episodes are encoded rather than by building an indexing scheme.** With enough domain structure the behaviour converges on a case-based reasoner with rich hand-built indices, without anyone building indices. The failure route is the same mechanism run backwards — Bassok's finding that a verb's interpretation depends on the nouns attached to it means relational encodings are idiosyncratically tied to surface content, which is offered here as a *cause* of poor relational access rather than a separate defect, and it is the same result this page already records as G23's sharpest measurement (the **get** schema, 89% → 0%).

This is a live disagreement with the case-based reasoning tradition, which buys relational access by indexing on themes and principles: [[wiki/empirical-tensions.md]] T199.

---

## The primary source, and the process this page was missing: instantiation

> **Provenance (fourth ingest).** Gilboa & Marlatte 2017, *Neurobiology of schemas and schema-mediated memory*, Trends Cogn Sci 21(8):618–631 (`raw/gilboa-2017-neurobiology-of-schemas.md`). The schema literature's own review, with an activation-likelihood-estimation meta-analysis over two contrast families (132 foci / 12 experiments for instantiation; 96 foci / 15 experiments for schema-related encoding). Everything above arrived second-hand through Preston & Eichenbaum or through the analogy literature; this is the source that defines the object.

The page above treats a schema as a store that new items are written into. This source splits off a **separate, earlier process** that the page has no name for: the schema is *reinstated* as a template of variables and their interrelations, and then **instantiated** — its variables bound to the particulars of the current input. Mnemonic effects are downstream of that.

| | **Reinstatement / instantiation** | **Schema-mediated encoding** |
|---|---|---|
| What runs | activate an abstracted template; populate its slots from the input stream | bind the now-interpreted event for later retrieval |
| Timing | pre-stimulus tonic effects; stimulus-locked from **170 ms** | **~400 ms** (online integration), then a congruence-*insensitive* subsequent-memory effect at **~650 ms** |
| Peak sites (ALE) | vmPFC (posterior medial orbitofrontal, subcallosal, rostral anterior cingulate), bilateral anterior temporal, TPJ/angular gyrus (R>L), bilateral hippocampus, fusiform/parahippocampal, posterior cingulate/retrosplenial | anterior cingulate, **left ventrolateral** PFC, superior/inferior parietal + angular gyrus, right anterior hippocampus/parahippocampal |
| Separable? | neuroimaging finds prior-knowledge effects and subsequent-memory effects as independent contributions within the same network; ERP signatures differ in latency and scalp topography | — |

**Why a builder should care about the split.** The wiki's schema mechanisms are all write-side or read-side: assimilation, accommodation, replay selection, index building. Instantiation is neither — it is a *slot-binding pass over the input*, run before anything is stored, whose output is the interpretation the rest of the pipeline then operates on. It is the operation [[wiki/concepts/analogical-mapping.md]] performs between two representations, applied here between a stored template and a live percept, and it is the earliest point at which prior structure can be wrong ([[wiki/concepts/latent-graph-discovery.md]]: which subgraph you decide you are in determines every later query).

### The template is a bound set, and the binder is vmPFC

The proposed functional anatomy: long-term representations distributed over posterior neocortex (retrosplenial, middle temporal gyrus/STS, anterior temporal lobe, TPJ) are **temporarily bound together by vmPFC** into a superordinate template, with the binding context-sensitive — vmPFC biases the context-relevant associative pathways and leaves (or inhibits) the contextually irrelevant ones. The angular gyrus is separately implicated as a **convergence zone** binding low-level perceptual features to high-level decision rules within one schema.

So the schema has no single storage site: it is a *transient coalition* over posterior stores, addressed by a prefrontal index. That is a different architecture from every schema mechanism above, which treats the schema as content held somewhere.

### The top-down influence is causal, and it reaches early sensory cortex

| Evidence | Result |
|---|---|
| Expert cardiologists/pulmonologists verifying a diagnosis against an ECG or chest radiograph | domain expertise predicts **N170** amplitude — an organized knowledge structure changes *early perceptual* processing of complex images |
| Self-schema task (endorse only personally known faces) | N170 discriminates known from unknown |
| Same task, **vmPFC lesion** | the N170 familiarity modulation is **abolished**, though it source-localizes to inferior posterior cortex (fusiform) |
| vmPFC lesion + confabulation, judging whether a word belongs to an everyday schema | impaired **with memory unchallenged** — the deficit is in holding an active template |
| vmPFC lesion or mPFC TMS, DRM word lists | **protected** against the false-lure effect: no meta-mnemonic theme is built, so the lure is never activated and memory is paradoxically more accurate |
| Pre-stimulus interval, healthy controls vs vmPFC lesion | controls show **decreased** vmPFC↔inferior/lateral temporal low-frequency (theta) coherence before stimulus onset; patients do not |

**The mechanism proposed is tonic low-frequency *desynchronization*, not synchronization** — vmPFC holds schema-relevant posterior networks in a decoupled state that lets them express fine-grained codes, rather than driving them into a shared rhythm. This is the opposite sign from the wiki's default communication-through-coherence reading ([[wiki/concepts/inter-areal-synchrony.md]]) and it is a *prestimulus, stimulus-independent* setting — i.e. a precision/gain state ([[wiki/concepts/precision-weighting.md]]) rather than a message.

**(brainstorm)** The pair "lesion abolishes the sensory effect / lesion protects against the false memory" is the cleanest available demonstration that a prior is not a free win: the same top-down edge that makes the expert's N170 informative is the edge that manufactures the lure. A machine ablation with this shape is cheap and nobody runs it — remove the retrieval conditioning from a retrieval-augmented model and measure *both* accuracy on in-schema items and hallucination rate on schema-adjacent distractors; the prediction is that the two move together, so the operating point is a choice and not a bug.

### Acquisition does not stop at vmPFC

The one long-training study (nine months, ten arrays of object–location paired associates, with empty slots later trainable inside the learned array):

| Elapsed | Retrieval substrate |
|---|---|
| Pre-sleep, day 1 | hippocampal |
| After the **first night** | shift to **vmPFC** |
| **3 months** | **no vmPFC**; ventrolateral PFC + anterior temporal lobe + angular gyrus/TPJ |

Reinstatement of even highly learned schemas still requires vmPFC (lesion evidence above), so the two are not in conflict: what moves off vmPFC with over-training is the *specific paired associate*, which has become denotational semantic content ([[wiki/concepts/controlled-semantic-cognition.md]]'s ATL hub), while the *template* function stays. The source's own caution: training protocols that repeat specific associations may produce semantic representations rather than schemas, and a genuine schema needs variable encoding episodes so that both nodes and interrelations are abstracted.

**Consequence for the wiki's consolidation timeline.** Every retrograde table on [[wiki/entities/medial-prefrontal-cortex.md]] and [[wiki/concepts/complementary-learning-systems.md]] is two-stage (hippocampus → cortex). This is **three**-stage, with the middle stage a prefrontal way-station that is later vacated — and the last transition happens between 1 and 3 months, past the end of essentially every consolidation experiment in the wiki.

### Rapid neocortical integration has two stated preconditions

The claim `T82` and `G14` both need, from the source that states it:

| Precondition | Statement |
|---|---|
| **Simultaneity** | rapid neocortical consolidation is greatly enhanced when prior knowledge is **activated at the same time** as the incoming information; amodal hubs (vmPFC, ATL) may need to potentiate synchronous neocortical activity for it to happen at all |
| **Related but non-overlapping** | catastrophic interference is avoided only when the new associations are *related* to stored ones and do **not overlap** them; congruent-but-overlapping material still interferes |
| **Which layers** | integration occurs through rapid change in **representational** layers rather than hidden layers, mapped to lateral/inferior temporal cortex and TPJ |

**This is directly implementable and contradicts how the wiki's consolidation machinery is built.** `G14`'s transport writes into the slow learner's parameters generally; this says the safe write is confined to the read-out/representational layer, is licensed by a *conjunction* (related ∧ non-overlapping) rather than by a similarity scalar, and requires the prior to be *co-active* — i.e. the write is a Hebbian coincidence between a reinstated template and a live input, not a replayed sample. The related-but-non-overlapping condition is also the missing arbitration rule the section above asks for: **overlap** with a stored association is what forces the expensive hippocampal/integration route, **relatedness without overlap** is what licenses the cheap cortical one.

### Sleep does two opposite things to a schema

| Stage | Operation | Evidence |
|---|---|---|
| **Slow-wave sleep** | build/refine: slow oscillations synchronize cortex, thalamic spindles open plasticity windows, hippocampal ripples reinstate; synaptic downscaling then keeps only the strongly potentiated — so *shared* elements of several reactivated memories survive and idiosyncrasies are lost | associating new material with prior knowledge is **essential** for successful reactivation and integration, via increased spindle activity; spindle density predicts **accelerated hippocampal disengagement** in schema-dependent consolidation |
| **REM** | **disintegrate**: preexisting schemas are broken up so new ones can form; proposed substrate of associative/creative recombination | REM-associated consolidation benefit for **tonal** melodies (Western musical schema) but not atonal ones |
| **Wake** | preselection: wake-dependent replay tags memories for later sleep reactivation, and this tagging is proposed to be **biased by currently activated schemas** | — |

**The wake-tagging claim is what `G14` asks for, in a form nobody has implemented**: the replay *selector* reads the currently instantiated schema, so what gets consolidated is chosen by fit to the active template rather than by recency, salience or reward. And the REM half gives the schema an explicit **decay/dissolution** operator, which no consolidation mechanism in the wiki has — every one of them only ever adds structure.

---

## The exception needs no mechanism: it is gradient descent in a network that already knows something

> **Provenance (fifth ingest).** Kumaran, Hassabis & McClelland 2016 (`raw/kumaran-2016-complementary-learning-systems-updated.md`), reporting McClelland 2013 and a deep-linear-network analysis (Saxe et al.). Everything above treats the one-trial-cortical-learning result as an *exception* to slow cortical learning that some mechanism must produce. This says it is what the unmodified mechanism does.

The simulation uses the same architecture and content domain MMO95 used to argue that cortical learning must be slow — a network trained to acquire animal properties (*canary is a bird, can fly*), paralleling the multi-week initial phase of the event arena.

| New item `X` | Learning | Interference |
|---|---|---|
| **Consistent** (`X is a bird and can fly`) | rapid | none; existing knowledge undisrupted |
| **Inconsistent** (`X is a bird but swims, not flies`) | slow | catastrophic unless interleaved with known examples |

**The measurement that matters: the learning-rate parameter was the same small value in both conditions, and the weight changes were large only for the consistent item** — reproducing the schema-dependent neocortical plasticity-gene expression Tse et al. 2011 measured 80 min after learning. The general statement from the linear analysis: the rate of learning in a multilayer network always depends on the current state of knowledge and on the compatibility of the new input with the structure that knowledge represents.

Three consequences for this page.

- **Congruence does not need a licence, a template or a co-activation.** Gilboa & Marlatte's three preconditions (simultaneity, related-but-non-overlapping, representational layers) are conditions for *rapid integration in the brain*; this result says a bare gradient learner already shows the rate split. The preconditions are therefore claims about the biological implementation, not about why the phenomenon exists — and a builder testing them needs the plain-gradient result as the null model, which no wiki source treats it as.
- **The "cortex builds wiring, hippocampus reweights existing synapses" account of the rate split** ([[wiki/concepts/complementary-learning-systems.md]], Frankland & Bontempi 2005) predicted the schema exception and was recorded here as its best mechanism. It is now over-determined: gradient magnitude alone suffices. The discriminating measurement is unchanged — whether schema-consistent consolidation carries synaptogenesis markers — but it now has to beat a mechanism-free baseline.
- **The exception propagates to the fast store.** Because hippocampal input *is* the cortical representation, hippocampal learning is also prior-knowledge-dependent. Nothing above says this, and it predicts that the one-trial benefit in a familiar arena is partly an *encoding* benefit rather than wholly a consolidation benefit — separable by measuring day-1 hippocampal binding, which the event-arena experiments do not.

**(brainstorm) The cheap machine version has never been reported.** Pretrain any network on a structured domain, then measure the per-condition **gradient norm** for a consistent versus an inconsistent new item at identical learning rate. If the split reproduces, every schema result in this page's Preston & Eichenbaum column has a one-line explanation, and "integration demand" — the quantity this page lists as unoperationalised — has a candidate estimator that is already computed on every training step.

---

## Open problems

- **No arbitration between integration and separation** (above). Both are prefrontal, both are triggered by conflict, and nothing predicts which fires.
- **The trigger has no formal statement.** "Integration demand" is defined by the experimenter's design, never measured within a trial. Until it is a computable quantity, the reframing of consolidation as demand-indexed rather than time-indexed is a research programme, not a schedule.
- **Timescales are short.** Nearly all evidence for schema formation and expression is collected immediately or within days of learning, which is the wrong window to test claims about consolidation trajectories; the source says so.
- **Accommodation has no mechanism.** The review assigns it to prefrontal cortex and describes its behavioural signature; it names no plasticity rule that rewrites an existing structure without destroying it — which is the continual-learning problem ([[wiki/concepts/continual-learning.md]]) stated in memory terms.
- **Schema identity is unoperationalised.** "The same schema" is defined ostensively — the same arena, the same list. Two experiences overlapping in some features and not others have no defined membership, and property (i) (one-trial learning) was shown to fail across environments, so the boundary is doing real work while remaining undefined (this is G37/G27 in another vocabulary).
- **Homology.** "mPFC in rats ≈ vmPFC in humans" carries the entire cross-species argument and the source flags it as unfinished.
- **Competition or cooperation between controller and store is unresolved, and the deciding variable is the same unmeasured one** ([[wiki/empirical-tensions.md]] T372). SLIMM has vmPFC inhibiting medial-temporal binding when the input resonates with a schema; the associative-inference literature has the two coupling more, and the coupling predicting inference. The source's reconciliation is an inverted U over relatedness — weak coupling for arbitrary material *and* for very strongly schematic material, peak in between — which no study has tested because none varies relatedness at more than two levels.
- **How schemas are *constructed and accommodated* is barely studied at all.** The source says so directly: almost all work is on assimilation of new information into an existing schema. Accommodation still has no mechanism (above), and now neither does construction.
- **Whether general-form schemas are the same object as the low-level knowledge structures actually tested.** Nearly every paradigm uses informationally specific prior knowledge (a trained array of paired associates, a weather-prediction rule set). Whether a superordinate template recruits a broader compilation of the same subprocesses or something qualitatively different is stated as unknown — which is the source's own version of this page's *schema identity is unoperationalised*.
- **Statistical learning alone, or a prior that constrains it?** Open in the source: whether detection of regularities can by itself yield structured symbolic schemas, or whether prior abstract knowledge must be assumed to constrain acquisition — the [[wiki/concepts/inductive-bias.md]] question stated inside the memory literature.
- **The schema's slot list is asserted, not derived.** "Spatial, temporal, causal, evaluative and social" is a plausible enumeration with no principle behind it and no test that the five are separable or exhaustive; nothing says what a sixth aspect would look like or how the aspects are bound into one representation (Lieberman & Meyer 2018).

---

## Connections

- **[[wiki/concepts/inter-areal-synchrony.md]]** — carries the opposite-sign prediction this page now rests on: the schema template is held over posterior cortex by *tonic pre-stimulus de*synchronization of vmPFC↔temporal theta, absent after vmPFC lesion, so preparing a network to express a fine-grained code looks like decoupling rather than coherence (Gilboa & Marlatte 2017).
- **[[wiki/concepts/precision-weighting.md]]** — what instantiation is, in gain terms: a stimulus-independent, sustained prefrontal setting over posterior stores that biases which associations can be expressed, measurable before the input arrives and causally necessary for the earliest sensory signature of expertise (N170).
- **[[wiki/concepts/controlled-semantic-cognition.md]]** — the destination of an over-trained schema: at three months the object–location associates are read from ventrolateral PFC + anterior temporal lobe + angular gyrus and vmPFC has dropped out, so repeated encoding of *specific* associations converts a schema into denotational semantic content while the template function stays with vmPFC.
- **[[wiki/concepts/event-segmentation.md]]** *(also)* — supplies the missing dissolution operator from the other side: REM sleep is proposed to *disband* existing schemas so new ones can form (tonal-melody benefit, absent for atonal), which is the only mechanism in the wiki that removes stored structure rather than adding to it.
- **[[wiki/concepts/retrieval-mediated-learning.md]]** — the primary source for this page's conflict trigger, with the reinstatement measured rather than presumed: it supplies the classifier read-out of the absent element, the anterior-MTL/hippocampus split between reporting reactivation and doing the binding, and the partial correlation that makes integration-at-encoding non-vacuous.
- **[[wiki/entities/remerge.md]]** — supplies a route to property (iii) that needs no schema at all: inference between indirectly related elements falls out of recirculating an episodic store's own retrievals until they settle, so the page's defining test can be passed by retrieval dynamics rather than by an organized structure.
- **[[wiki/concepts/nonspatial-maps.md]]** — the map operation isolated there and covered by no other: insert new nodes into a map already in use and keep the frame, rather than rebuild it.

- **[[wiki/concepts/priority-map.md]]** — where a selected schema goes once it is selected: a learned face↔scene pairing retrieved in ventrolateral prefrontal cortex during the cue is installed over the following delay as the *attentional template* in the inferior frontal junction and as sensory gain in the associate's own category area, so "prefrontal cortex selects the schema" and "prefrontal cortex sets the search query" are the same operation observed at two stages (Zhou & Geng 2025).

- **[[wiki/concepts/complementary-learning-systems.md]]** — indexes the same fast/slow transport by a different variable: not elapsed time or learning rate but *overlap with what is already stored*, which turns the standard slow-cortical-learning claim into a special case (the no-schema condition) and makes one-trial cortical learning the schema-matched case (Tse et al. 2007, via Preston & Eichenbaum 2013).
- **[[wiki/concepts/latent-graph-discovery.md]]** — the biological statement of the page's central problem in memory terms: a schema is a known subgraph, assimilation is adding an edge between existing nodes, accommodation is rewriting existing edges, and the inference test (A–C never observed) is a path query over a *discovered* graph.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — supplies the content on that page's one-way hippocampal channel: a generality-graded context code from the ventral/anterior pole, and the causal demonstration that the controller *selects* rather than retrieves — mPFC inactivation leaves dorsal hippocampal retrieval intact but indiscriminate.
- **[[wiki/concepts/pattern-separation-completion.md]]** — proposes what sets that page's separate-vs-complete knob: schema membership rather than input similarity, because events inside a known structure are written to the *same* cells with similar patterns and only differentiate over days, which is the opposite trajectory to sparse-conjunctive separation (gap G38).
- **[[wiki/concepts/contextual-inference.md]]** — the same context-selects-which-memory-is-expressed logic, with the selection localised to a controller rather than to a posterior: the store returns all context-matched and context-mismatched candidates and prefrontal cortex suppresses the wrong ones, so responsibility is applied downstream of retrieval instead of inside it.
- **[[wiki/concepts/offline-replay.md]]** — adds an *online* reinstatement to the replay inventory: during encoding of an overlapping pair the prior associate is retrieved into the episode, so the conflict that drives integration is manufactured by replay at write time rather than resolved offline afterwards.
- **[[wiki/concepts/recall-gated-consolidation.md]]** — the opposite sign of one statistic: that page gates the slow write on the fast store *agreeing* with the proposed update, this one engages the expensive module when it *disagrees*, and both are computed from the same retrieval-vs-observation comparison.
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — a second reason the optimal transport is not "everything": beyond the generalization-error stopping rule, the demand for transport depends on whether the new item conflicts with stored structure, and on whether its episodic detail must survive — two inputs that page's objective does not have.
- **[[wiki/concepts/cognitive-control.md]]** — extends the controller's job description backwards in time: the same bias signal that selects a task set is here selecting a *memory structure*, and its trigger is measured (mnemonic conflict, with vmPFC recruitment under conflict predicting successful inference).
- **[[wiki/concepts/continual-learning.md]]** — names the operation neither literature has a rule for: accommodation is a targeted rewrite of an existing structure to admit a conflicting item, which is what importance-gated plasticity is designed to *prevent*, so the two mechanisms want opposite things from the same weights.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — *(second link, human arm)* localises this page's schema operations in humans and widens their content: Brodmann-area-11 damage removes schema assimilation and schema-biased recall, and the tissue that does it is the one region of the medial wall that no psychological domain can claim, which is what an amodal situation model should look like (Lieberman & Meyer 2018).
- **[[wiki/concepts/event-segmentation.md]]** — the same stored object approached from time rather than from overlap: an event model and a situation model have the same slot problem, and the situational reading adds evaluative and social dimensions that a boundary-detection account has no way to produce.
- **[[wiki/concepts/cognitive-map.md]]** — the long-axis generality gradient in its home domain: item-in-place coding at the dorsal/posterior pole, context-discriminating coding at the ventral/anterior pole, with only the latter projecting to the controller — two grains of one map with a different consumer each.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the machine version of property (iii) without the conflict machinery: it answers first-presentation transitive inference from a learned structural code, so it delivers the inference that defines a schema while having no assimilation/accommodation distinction and nothing that rewrites a structure when a new observation contradicts it.
- **[[wiki/entities/nucleus-reuniens.md]]** — supplies the write channel the selection account needs: the controller reaches the hippocampus only through a midline-thalamic relay, and that relay carries a goal-conditioned future path, so "suppress the context-inappropriate candidate" can be implemented as constraining the store's dynamics rather than filtering its output (Jin & Maren 2015).
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — supplies the cargo type on the channel: the hippocampal long axis is a generality gradient and the controller is wired only to its general end, so what crosses the edge is what all events of a context share rather than an event.
- **[[wiki/concepts/analogical-mapping.md]]** — the slot-filling mechanism assimilation assumes: mapping binds the current situation's elements to the schema's roles by similarity of role-augmented codes, and copy-with-substitution-and-generation is what the schema then projects onto the new instance, including inventing entities the instance does not yet have.
- **[[wiki/entities/lisa.md]]** — the only mechanism in the wiki that produces a schema *as an operation* rather than as a consolidation outcome: intersection discovery over a completed analogical mapping, running inside a working-memory budget of two to three propositions.
- **[[wiki/entities/macfac.md]]** *(also)* — supplies this page's account of why relational retrieval improves with expertise and with intensive encoding: the index is computed from the representation, so uniform relational encoding *is* a good index, and no separate indexing machinery is built. Followed by: the retrieval step that decides *which* schema gets assimilated, measured and found structure-blind: humans retrieve mere-appearance matches at .53 against .12 for true analogies and then rate the very matches that came to mind as unsound, so assimilation is routinely triggered by shared object attributes with no shared relational structure.
- **[[wiki/entities/ch-hnn.md]]** — an operational reading of assimilation in which the schema supplies an *address* rather than content: prior regularities decide which units a new concept may occupy, and transfer is measured by whether ImageNet-derived addresses (with target-overlapping classes removed) still help on disjoint CIFAR-100 / Tiny-ImageNet classes — they do (Shi et al. 2025).
- **[[wiki/concepts/memorisation-vs-generalisation.md]]** — the coding-theoretic statement of what a schema is worth: "memorisation with rules of thumb" is the regime where macrofeatures carry most of the mapping and only exceptions must be stored, and the correlated-attribute case (two individually arbitrary facts that co-vary, so storing them jointly costs less than storing them apart) is the minimal instance of assimilation stated without any psychology.
- **[[wiki/entities/sme.md]]** — a two-pass slot-filling schedule: align on observable behaviour first, then re-run the matcher on the theory with those correspondences frozen as hard match-constructor constraints, so the cheap alignment collapses the expensive one's search rather than merely proposing it.
- **[[wiki/entities/lateral-frontoparietal-network.md]]** — where the induction half of this page's loop is manipulated rather than assumed: presenting a source as an instance the rule must be extracted from, instead of as the stated rule, raises inferior-frontal-sulcus (BA 45) activity and slows verbal responses — and the cost vanishes over repeated extraction trials, which is assimilation running inside the experiment's control condition (Aichelburg et al. 2016; Wendelken et al. 2008b, via Parsons & Davies 2022).
- **[[wiki/concepts/hippocampal-long-axis.md]]** — supplies the anatomy and the proposed mechanism under this page's generality gradient: fields widen and cell oscillation slows toward the ventral/anterior pole, so more and more widely separated assemblies co-fire inside one theta cycle and become bindable — and it adds a second, *discrete* organization on the same axis (gene-expression domains, a 2/3–1/3 association-fibre seam) that the generality reading does not predict.
- **[[wiki/entities/cscg.md]]** — this page's three properties as two matrices, and one mismatch worth keeping: reusing a learned transition matrix while relearning only the emission matrix is assimilation (a new room is mastered from 20 steps, and paths through never-visited cells are planned correctly), running expectation-maximisation on both is accommodation, and property (iii) is met directly — two rooms experienced in separate walks are stitched at their shared patch and then navigated between along trajectories that were never taken. The mismatch: Tse et al.'s rats get **no** benefit from a schema built in a different environment, where the model's whole transfer result is precisely cross-environment reuse of the same structure. Nothing in the model selects which schema to apply, which is this page's prefrontal column.
- **[[wiki/concepts/sleep-oscillation-nesting.md]]** — the physiology under this page's two-stage sleep table: the slow-wave "plasticity window" is a ripple-in-spindle-in-up-state conjunction whose failure depotentiates instead, and the rapid-cortical-integration exception is what lets abstraction appear within 24 h rather than at the source's usual delays of weeks to a year.
- **[[wiki/concepts/explore-exploit-division-of-labour.md]]** — locates where assimilation becomes irreversible: high-level schemas constrain the hypotheses below them and get better confirmed with age, so they become the hardest thing to overturn *while low-level revision continues normally* — which makes the developmental cooling per level of abstraction, and makes the accommodation that matters the one that has to re-cut the schema itself (Gopnik 2020).
