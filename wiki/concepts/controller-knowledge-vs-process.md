# Controller Knowledge vs. Controller Process

**Does the control layer *store* anything, or is it a general-purpose procedure operating on knowledge held elsewhere? A representational answer says the controller's parameters are memories of goal-structured event sequences; a processing answer says the controller is an algorithm with no knowledge base — and "process" then reduces to *a set of representations that stay active*.**

> **Provenance.** Wood & Grafman 2003, *Human prefrontal cortex: processing and representational perspectives*, Nature Reviews Neuroscience 4:139–147 (`raw/wood-2003-prefrontal-representational-perspectives.md`). A review that scores eight theories of prefrontal function against five criteria and argues for the representational side; the authors are the proponents of one of the eight (the structured event complex).

The wiki's control-layer pages have so far described *what a controller does* — hold a task model, bias competitions ([[wiki/concepts/cognitive-control.md]]), maintain and update items ([[wiki/concepts/working-memory.md]]), bind cues to actions ([[wiki/concepts/arbitrary-sensorimotor-mapping.md]]). This page asks the prior architectural question: **does the controller have its own parameters?** The answer decides whether a machine control module is a *memory* to be trained on structured experience or a *mechanism* to be wired and left contentless.

---

## The two positions, stated so they can be built

| | Representational controller | Processing controller |
|---|---|---|
| What is in the module | Memories — localized encodings that, when activated, give access to stored information | Computational procedures, independent of the modality or nature of what is processed |
| What it holds at run time | A retrieved unit of long-term knowledge, activated | A temporary operating space, re-derived per task |
| Where the knowledge lives | Partly here, partly posterior | Entirely posterior |
| Machine analogue | A parameterised policy/schema library indexed by goal | A contentless attention/gating mechanism over a frozen backbone |
| What a lesion predicts | Loss of *specific knowledge* — this class of plans, that category of scripts | Loss of *control in general*, graded by demand, contents unaffected |

**The reduction that makes the debate tractable.** In the representational view, a *process* is not a different kind of thing — it is "a set of representations that, when activated, remain activated over a period of time". Working memory becomes the activation of a set of representations over a limited window rather than a buffer with an occupancy. This is the same move the wiki already made when it argued the control variable is carried by activity rather than weights ([[wiki/concepts/cognitive-control.md]]) — but run in the opposite direction: there, sustained activity was defended as a *format* for a task model; here, sustained activity *is what a process is*, so nothing is left over to call an algorithm.

**(brainstorm)** The reduction is falsifiable in a machine and nobody has run the test. Take any controller module and ask whether its run-time state lies in the span of states reachable by activating stored items, or whether it visits states no stored item produces. A pure processing controller must visit off-manifold states — an operating space assembled for the task. A pure representational controller cannot. This is a population-geometry measurement ([[wiki/concepts/population-geometry.md]]), not a new experiment: fit the manifold of retrieval-evoked states, then test whether control states are inside it.

---

## The five criteria a theory of the control layer must meet

The review's scoring rubric, restated as design constraints on a machine control module:

| Criterion | As a constraint on an architecture |
|---|---|
| **Explicit about what is stored** | The module's parameters must be nameable — knowledge, procedure, or a stated mix. "It learns whatever it needs" is not an answer |
| **Consistent with stimulus representation elsewhere** | The controller's code must compose with the posterior representation format it biases, or the inconsistency must be paid for |
| **Evolutionarily reachable** | The control layer must be a modification of a nearby earlier system, not a new kind of machine. Lateral prefrontal cortex is argued to derive from motor regions, which *store motor programs* — so the newer region should also store, and a representation→computation switch is the step the argument disallows |
| **Predictive** | It must forbid something |
| **Supported** | Lesion, recording and imaging data must discriminate it |

**The evolutionary criterion is the one the wiki has never used, and it is a real filter.** It rules against contentless-controller designs on the grounds that no gradual path leads from a store of motor programs to a store of nothing. Taken seriously by a builder it is an argument for initialising the control layer as a *sequence memory* and letting control fall out, rather than designing a gating mechanism and hoping knowledge accumulates around it.

---

## How the eight theories score

The review's own table, kept because it is the only place in the wiki where the control-layer candidates are lined up against a common rubric.

| Theory | Type | Consistent with biology | Testable | Supported | Evolution |
|---|---|---|---|---|---|
| Adaptive coding (Duncan) | Processing | Partial | Yes | Mixed | Unclear |
| Attentional control / supervisory attentional system (Norman & Shallice) | Processing | Partial | No | Mixed | No |
| Connectionist (Burnod et al.) | Representational | Yes | Partial | Yes | Yes |
| **Structured event complex (Grafman)** | Representational | Yes | Yes | Yes | Yes |
| Guided activation (Miller & Cohen) | Representational | Yes | Yes | Mixed | Partial |
| Somatic marker (Damasio) | Hybrid | Yes | Yes | Yes | Unclear |
| Temporal organization (Fuster) | Hybrid | Yes | Yes | Mixed | Yes |
| Working memory (Goldman-Rakic) | Hybrid | Yes | Yes | Mixed | Unclear |

Read as a self-scored table by the winner's authors — the SEC row is the only clean sweep and it is theirs. What survives the discount is the *pattern*: every theory with a representational component clears the biology criterion, and both pure-processing theories fail it partially or wholly. The review's conclusion is the weak, defensible one: **no single theory accounts for all the data**, and the representational framing is preferred because it forces the modeller to name the stored content and thereby generates testable predictions, not because it has won empirically.

### The specific failures worth carrying

| Theory | The datum it does not survive | Consequence for a machine controller |
|---|---|---|
| **Adaptive coding** — the same prefrontal neurons flexibly code whatever the current task needs, so there is little regional specialization | A survey of 275 imaging studies finds *consistent* prefrontal localization differences between attention, episodic memory, working memory, language and semantic memory; some recordings show selectivity to particular tasks or stimulus classes | A single homogeneous controller pool is the wrong default. Specialization by content class is the empirical picture, and it is what a *stored-knowledge* controller predicts and a contentless one does not |
| **Supervisory attentional system** — control is engaged for novel situations with no available schema; routine behaviour runs on the contention scheduler | Prefrontal lesions impair knowledge *about routine behaviour* (script and sequence knowledge); prefrontal cortex is engaged by event knowledge; novel tasks activate anterior prefrontal cortex while overlearned tasks activate medial and slightly more posterior prefrontal cortex | Novelty is the wrong gate on the controller. Well-learned procedures are still *held* in the control layer — they move within it, they do not leave it |
| **Guided activation** — the controller's role approaches nil for frequently used rules; the switch operator is unnecessary when the train always takes the same track | Prefrontal neurons respond to *known* actions, not only new ones; and the theory never specifies how a representation is transferred to the posterior store that will run it | Directly disputes the automaticity story the wiki has been carrying ([[wiki/empirical-tensions.md]] T94); and the transfer step it omits is an unfilled slot in every machine design that assumes practice moves a skill out of the controller (gap G51) |
| **Temporal organization** — prefrontal representation is reserved for actions that are not habitual | Prefrontal cortex is implicated in both novel and well-learned tasks | Same failure as above from the opposite theory: two independent frameworks both put automatic behaviour outside the controller, and both are contradicted |
| **Working memory (Goldman-Rakic)** | Selective attention is in some cases intact after prefrontal damage; the model is topographically confined to dorsolateral prefrontal cortex and never says how spatial codes there differ from parietal ones | A store-only reading of the control layer under-determines the architecture: "maintains representations" does not say what distinguishes the controller's copy from the sensory region's ([[wiki/empirical-tensions.md]] T92) |

---

## The structured event complex: what a representational controller would actually store

An **SEC** is *a goal-oriented set of events, structured in sequence*. The stored unit is not a rule, a category or a cue→action pair — it is a **plan-shaped episode**: thematic knowledge, morals, abstractions, concepts, social rules, event features, event boundaries and grammars. Aspects are represented independently but encoded and retrieved *as an episode*.

This is the wiki's event-schema formalism ([[wiki/concepts/event-segmentation.md]]) claimed as the **contents of the control layer**. The correspondence is exact enough to be useful:

| Event-segmentation term | SEC term | What the SEC framework adds |
|---|---|---|
| Event | Single event within an SEC | Meaning and features are computed for it separately from the sequence |
| Event schema ⟨condition, event, final⟩ | Sequential dependency between adjacent events | The dependency is a stored property, not re-derived |
| Episode (compressed path) | The SEC itself | It has a **goal**, and its maintenance terminates on goal completion |
| — | Category of SEC (social / mechanistic) | Storage location follows the posterior region the content connects to |

**Four orthogonal storage axes.** The framework's localization claims, which are what makes it testable — and which read, for a builder, as a specification for how to *partition* a controller's memory:

| Axis | One pole | Other pole |
|---|---|---|
| Left / right prefrontal | Single-event processing: meaning and features of one event; sequential dependencies between *adjacent* events; fast activation, strong inhibition of neighbouring events | Integration across events: cross-temporal integration of meaning over *multiple* events; slow activation, weak facilitation of neighbours |
| Lateral / medial | Adaptive **partial-order** SECs — sequences frequently modified to adapt to special circumstances | Predictable **total-order** SECs — rarely modified, with a predictable relation to sensorimotor sequences |
| Dorsolateral / ventromedial | Category-specific *non-social*: mechanistic plans, actions, mental sets | Category-specific *social*: social rules, attitudes, scripts, knowledge |
| Anterior / posterior | More events per SEC, longer duration per SEC | Fewer events, shorter duration |

The anterior–posterior axis is a **temporal-abstraction gradient stated in units a model can be measured in**: events per stored unit, and duration per stored unit. The lateral–medial axis is the one with no analogue anywhere in the wiki — a *partial order vs. total order* distinction over stored sequences, i.e. whether the plan commits to an ordering or leaves it open for the situation to settle.

**(brainstorm) The partial-order axis is the most importable idea on this page and nothing in the wiki implements it.** Every sequence model here stores total orders: a trajectory, a replayed path, a token sequence. A partial-order plan stores *which events must precede which* and leaves the rest free — the classical partial-order planning representation, obtained here as a claim about biological storage. The payoff is compositional: two partial-order SECs can interleave without either being rewritten, which is exactly what total-order episodes cannot do and exactly what [[wiki/concepts/compositionality.md]] asks for at the level of plans. A cheap test: train a sequence model on tasks whose valid orderings vary, and ask whether its stored representation is closer to the *set* of valid orders or to the modal one.

**What the framework predicts and what supports it:**

| Prediction | Evidence offered |
|---|---|
| Categories of SEC localize by the posterior/subcortical region they connect to | Social-behaviour impairment follows ventromedial damage; mechanistic/reflective impairment follows dorsolateral damage; dissociable networks for emotional vs. non-emotional and social vs. non-social content |
| Online processing of an SEC lets a person **predict subsequent events** | Prefrontal damage disrupts day-to-day behaviour through failure to detect behavioural and social errors — i.e. loss of the forward prediction the stored sequence supplies |
| Maintenance persists until the behavioural goal is completed, and is interruptible by a supervening goal | Consistent with sustained prefrontal firing; the *termination condition* is goal completion, not decay |

**That last row is a specification the wiki's stores do not have.** Every fast store here ends an item by decay, by overwrite, or by an erase signal ([[wiki/concepts/working-memory.md]], gap G49). An SEC ends when its *goal is achieved* — the maintenance duration is a function of the stored content's own structure, and interruption by a supervening goal is a typed event rather than capacity pressure. A controller whose maintenance is goal-terminated needs no timer and no explicit clear.

---

## The category axis, tested

> **Provenance (second ingest).** Lieberman & Meyer 2018 (`raw/lieberman-2018-mpfc-social-self-affective.md`). The SEC framework's third storage axis — dorsolateral (mechanistic) vs. ventromedial (social) — is a *prediction*, and its evidence in the review above is lesion neuropsychology plus forward-inference imaging. This source re-runs the question with an instrument that is valid in the required direction ([[wiki/concepts/representation-probing.md]]) and confines itself to the medial wall.

| SEC prediction | What the reverse-inference data say |
|---|---|
| SEC categories localize by the posterior/subcortical region supplying their content | **Supported, and finer than predicted.** Within medial Brodmann areas 9–11 alone there are *three* content territories, not one social pole: social/mentalizing dorsally, self and value anteromedially, value and emotion ventrally ([[wiki/entities/medial-prefrontal-cortex.md]]) |
| Social content is ventromedial | **Half wrong.** The strongest social territory is *dorso*medial; the ventral social cluster is real but small and was invisible to forward inference. A builder taking "ventromedial = social" from the SEC axis would have partitioned the store on the wrong boundary |
| The controller stores content, so specialization by content class should be the empirical picture | **Supported as a majority-preference, refuted as a modular decomposition.** Only 17% of medial-wall voxels prefer one domain over all four rivals at the strong threshold; 88% do at the weak one |

**This is the sharpest available reading of [[wiki/empirical-tensions.md]] T96 and it does not resolve it — it re-specifies it.** The adaptive-coding position (one homogeneous pool) and the partitioned-by-content position are both true of the same tissue at different thresholds. What a builder gets is a *shape* rather than a verdict: a control layer that is largely shared with domain-preferring gradients laid over it, plus one region that is shared by construction — the non-selective situational cluster every domain reads and none owns.

**(brainstorm) That shape is a concrete architecture and the wiki has not proposed it.** Not a bank of category modules (the SEC axes as stated), not a single undifferentiated controller (adaptive coding), but **one shared situation buffer plus soft domain-preferring read heads over a common substrate** — soft in the measurable sense that ~83% of the substrate is claimed by no single domain. The falsifiable difference from a modular design: ablating a preferred region should degrade its domain *most* but not *only*, and ablating the shared region should degrade every domain roughly equally. Both are cheap in a machine and neither is reported for any control module in the wiki.

---

## Reading in the core framing

| This page | Latent-graph reading |
|---|---|
| Representational controller | The meta-graph has **parameters in the control layer**: stored subgraphs indexed by goal, not merely a pointer into a posterior store |
| Processing controller | The control layer holds only a *selection* over a graph stored entirely elsewhere |
| SEC | A goal-labelled **path template** — an ordered (or partially ordered) set of nodes with a terminal condition |
| Anterior→posterior gradient | Path length: how many nodes one stored unit spans |
| Lateral (partial order) | A path template with only *some* edges committed — a constraint set, not a walk |
| Category axis (social / mechanistic) | Storage partitioned by *edge type*, with the partition determined by which posterior region supplies the node contents |
| Goal-terminated maintenance | An active path is released when its terminal node is reached — a stopping rule the wiki's stores lack |

---

## Open problems

- **The debate is not decidable by the evidence presented.** Every argument for the representational side is an argument from *consistency* (with connectivity, with neurophysiology, with evolution), not from a discriminating experiment. The review says as much: no single theory explains all the data.
- **Nothing measures how much is stored.** "The controller has parameters" gives no capacity, no acquisition rate, no forgetting curve. A machine version would need at least the number of SECs storable and the cost per event of one.
- **The transfer step is missing from every theory in the table.** How a representation formed in the control layer is moved to the posterior store that will later run it automatically is stated as an omission of guided activation, and no theory here supplies it (gap G51).
- **The category axis's *pole assignment* is now in doubt independently of the axis itself.** Social content's strongest medial territory is dorsal, not ventral, so "storage location follows the connected posterior region" may be right while every specific location the framework names is wrong — and the framework offers no way to derive a location from a connectivity map, only to assert one (Lieberman & Meyer 2018).
- **The localization axes are four independent claims with no stated interaction.** A long social partial-order SEC should be left-anterior-lateral-ventromedial, which over-determines the anatomy; nothing says how the axes compose or what happens when they conflict.
- **The SEC has no acquisition story.** The framework specifies what is stored and where, never how a goal-structured sequence is extracted from experience — the same gap [[wiki/concepts/event-segmentation.md]] carries for episodes (no learned boundary detector, no compression criterion).
- **"Representation" and "process" may not be separable by any experiment.** If a process just *is* a persistently active set of representations, then every processing model can be re-described representationally and the distinction is a modelling convention rather than a fact about the substrate — which would make the five criteria a style guide.

---

## Connections

- **[[wiki/concepts/cognitive-control.md]]** — the theory this page scores and partly disputes: guided activation is credited as representational, testable and consistent with prefrontal biology, but its prediction that the controller approaches irrelevance for well-learned behaviour is contradicted by prefrontal responses to known actions, and it never says how a control representation is handed to the posterior store ([[wiki/empirical-tensions.md]] T94, gap G51).
- **[[wiki/concepts/event-segmentation.md]]** — supplies the stored unit this page's representational controller would hold: an SEC *is* that page's episode, with three additions — a goal, a termination condition on goal completion, and a storage location determined by the content category.
- **[[wiki/concepts/working-memory.md]]** — the reduction that dissolves this page's own subject: if a process is a set of representations held active, working memory is not a buffer with an occupancy but a *duration* over retrieved long-term items, which is a different capacity claim from either the slot bound or the softmax bound.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the same partition question answered from anatomy rather than from theory: that page's dorsal/ventral output-port split is the rat homologue of this page's dorsolateral (mechanistic) / ventromedial (social) storage axis, and both say the controller is factorized by *what it connects to* rather than by what it computes.
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — the smallest possible stored unit, against this page's largest: a cue→action edge with no internal structure versus a goal-oriented event sequence, both claimed to be prefrontal contents, with nothing stating how one scales into the other.
- **[[wiki/concepts/compositionality.md]]** — the partial-order storage axis is a compositional claim about plans: two partially ordered event sequences can interleave without rewriting either, which is what total-order episodes cannot do.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — *(second link, human arm)* the closest thing to a test of this page's category-storage axis: five candidate content domains run head-to-head across three subdivisions of the human medial wall confirm that the controller partitions by content, relocate the social pole from ventromedial to dorsomedial, and put a number on how much of the substrate is domain-preferring at all (17% strong / 88% weak).
- **[[wiki/concepts/representation-probing.md]]** — the instrument this page's whole evidence base was missing: every localization claim scored here is forward-inference ("damage to X impairs Y", "Y activates X"), and a stored-content partition is a statement in the reverse direction, which needs the candidate functions compared head-to-head on the same activations.
- **[[wiki/concepts/population-geometry.md]]** — the measurement that would decide the representation/process question in a machine: whether the controller's run-time states lie inside the manifold spanned by retrieval-evoked states, or visit an operating space no stored item produces.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — costs the transfer step this page finds missing: if practice does not move a behaviour *out* of the control layer but only to a different part of it, the controller-capacity release that skill accounting assumes never happens.
- **[[wiki/concepts/meta-learning.md]]** — the processing controller is the meta-learning default (fixed contentless machinery, task knowledge in activations); the representational controller says the outer loop should be writing *stored plans* into the control module itself, which is a different place to put the meta-graph.
- **[[wiki/concepts/simulation-based-planning.md]]** — an SEC read as a plan library: online processing of a stored sequence *is* prediction of subsequent events, so retrieval substitutes for rollout wherever a matching stored path exists.
- **[[wiki/concepts/control-unity-and-diversity.md]]** — the same partition question cut on a different axis: that page factorizes the controller by *operation* (one common component plus updating- and shifting-specific ones, dissociable by lesion, drug and gene) rather than by stored content, and supplies the multiple-demand network as the shared component both readings compete over ([[wiki/empirical-tensions.md]] T96).
- **[[wiki/entities/arc-agi-2.md]]** — the distinction arriving from the benchmark side as the field's named open problem ("methods to separate knowledge and reasoning"): AI reasoning performance is reported as bounded by pretraining-corpus knowledge coverage in a way human reasoning is not, which is this page's separation failing in every deployed system.
- **[[wiki/concepts/refinement-loop.md]]** — the loop is pure process, and its measured reach is set by whether the base model's knowledge covers the domain, which makes it the cleanest demonstration that the two are entangled rather than layered.
- **[[wiki/entities/arc-agi-3.md]]** — the separation tested by removing the knowledge side entirely: environments are authored to resemble no existing game and no other environment in the set, and the frontier models whose reasoning is knowledge-bound score 0.1–0.5% while two small purpose-built searchers reach 6.7–12.6% on the preview set.
- **[[wiki/entities/anli.md]]** — the split priced by manual annotation of what actually defeats a model on a benchmark named for inference: 53% → 63% of the items that fooled successive state-of-the-art models required an outside fact rather than an inference step, so most of the apparent process gap on ANLI is a coverage gap, and the headline number is not a reasoning score (Nie et al. 2020).
