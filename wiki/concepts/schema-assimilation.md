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

Against this, lateral prefrontal cortex resolves the *same* competition the other way — by making individual memories more **distinctive** and hence less interference-prone.

| | Ventromedial PFC | Lateral PFC |
|---|---|---|
| Resolution strategy | **Integrate**: build one structure spanning the conflicting items | **Separate**: encode/retrieve so the items stop competing |
| Downstream capability | Inference between indirectly related elements | Interference resistance, veridical recall of the individual item |
| Cost | Loss of item distinctiveness; the schema can distort the item (Bartlett) | No inferential path is built |

**These are two policies over one conflict signal, and the source states no arbitration rule** — nor does it know whether their time courses differ. That is a clean open question with an obvious machine analogue: on encountering a new item that conflicts with a stored one, a system may merge them under a common structure or push them apart, and every wiki mechanism that touches this (dentate expansion recoding, memory allocation by excitability, engram linking) implements one policy without a selector between them.

---

## Open problems

- **No arbitration between integration and separation** (above). Both are prefrontal, both are triggered by conflict, and nothing predicts which fires.
- **The trigger has no formal statement.** "Integration demand" is defined by the experimenter's design, never measured within a trial. Until it is a computable quantity, the reframing of consolidation as demand-indexed rather than time-indexed is a research programme, not a schedule.
- **Timescales are short.** Nearly all evidence for schema formation and expression is collected immediately or within days of learning, which is the wrong window to test claims about consolidation trajectories; the source says so.
- **Accommodation has no mechanism.** The review assigns it to prefrontal cortex and describes its behavioural signature; it names no plasticity rule that rewrites an existing structure without destroying it — which is the continual-learning problem ([[wiki/concepts/continual-learning.md]]) stated in memory terms.
- **Schema identity is unoperationalised.** "The same schema" is defined ostensively — the same arena, the same list. Two experiences overlapping in some features and not others have no defined membership, and property (i) (one-trial learning) was shown to fail across environments, so the boundary is doing real work while remaining undefined (this is G37/G27 in another vocabulary).
- **Homology.** "mPFC in rats ≈ vmPFC in humans" carries the entire cross-species argument and the source flags it as unfinished.

---

## Connections

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
- **[[wiki/concepts/cognitive-map.md]]** — the long-axis generality gradient in its home domain: item-in-place coding at the dorsal/posterior pole, context-discriminating coding at the ventral/anterior pole, with only the latter projecting to the controller — two grains of one map with a different consumer each.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the machine version of property (iii) without the conflict machinery: it answers first-presentation transitive inference from a learned structural code, so it delivers the inference that defines a schema while having no assimilation/accommodation distinction and nothing that rewrites a structure when a new observation contradicts it.
