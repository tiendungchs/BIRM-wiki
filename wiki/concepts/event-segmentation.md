# Event Segmentation and Event Schemata

**Cut a continuous sensorimotor stream into discrete units by watching which predictive encodings are active: an *event* is a set of encodings that holds over an extended period, an *event boundary* is a significant lasting change in that set.**

This is where the wiki's graph gets its **nodes and edges** when experience arrives as a continuous stream rather than as pre-tokenised states. Every task in [[wiki/concepts/latent-graph-discovery.md]] so far assumed the discretisation was given. Source: Butz 2016, unifying the theory of event coding (Hommel et al. 2001) with event segmentation theory (Zacks et al. 2007).

---

## The set-based definition

| Term | Definition | Graph reading |
|---|---|---|
| **Event** | an active set of predictive encodings applying over an extended period | a **node** (a state that persists) |
| **Static event** | non-empty set of *spatial* + *top-down* encodings, no change predicted | a node with no self-transition — a scene |
| **Dynamic event** | the above plus *temporal* encodings predicting change | an **edge in progress** — a transition being traversed |
| **Event boundary** | a state at which encodings become applicable or stop being applicable | a **node boundary** — where one state ends and the next begins |
| **Event schema** | ⟨conditional encodings, event encodings, final event encodings⟩ | a **typed edge**: precondition → transition → postcondition |
| **Episode** | a set of event schemata and their typical ordering in time | a **path**, compressed into a single reusable encoding |

The definition is *derived*, not stipulated: it needs no segmentation module, only a change detector over the active set of [[wiki/concepts/predictive-coding-free-energy.md]] encodings. One detector then catches a wide and otherwise heterogeneous range of boundaries:

| Boundary kind | Example | Which encoding changes |
|---|---|---|
| motion onset / offset / reversal | a person starts running | temporal |
| appearance / disappearance | an object is occluded then revealed | top-down + spatial |
| property change | a bottle becomes light when emptied | top-down |
| affordance change | an object rotates into a graspable orientation | spatial → enables new temporal |
| contact | hand reaches the object, distance → 0 | spatial |

---

## Event schemata are the wiki's missing edge type

The triple ⟨condition, event, final⟩ is precondition–action–effect. Three things follow that the wiki's plain (node, edge, label) formalisation does not supply:

- **Backward chaining is free.** Because the *final* encodings of one schema are the *conditional* encodings of the next, schemata chain inversely: given a desired final event, activate whatever establishes its preconditions, recursively. This is path search expressed as constraint propagation rather than as forward rollout — "no food in reach, food consumption is the goal ⇒ find food, move it into reach". Same structure as hierarchical model-based reinforcement learning, without an explicit option framework.
- **Multi-scale nodes come for free.** Repeated schema clusters compress into *episodes* (eating, drinking, walking, grasping-to-hold), which themselves compose in parallel, in sequence, or **recursively** — "attending a lecture" ⊂ "studying at university" ⊂ "working on a career". This is exactly the coarse graph that jumpy, multi-scale planning needs ([[wiki/concepts/simulation-based-planning.md]]), obtained by compression of experience rather than by hand-designed temporal abstraction.
- **Partial observation is enough to identify the edge.** Because encodings co-occur systematically, seeing a fragment licenses inference of the whole episode — pantomime, occluded action, a movie shot implying years. Recognition and goal attribution are the *same* inference: activate the episode encoding that best explains the observed fragment. Action understanding and plan recognition are one mechanism.

**Motor primitives fit the slot.** Habitual, dynamic motion primitives are dynamic-event encodings; the schema's conditional encodings say when a primitive applies, and the mismatch between achieved and desired final event *is* the reinforcement signal. This makes the affordance-competition view (objects afford competing habitual interactions, arbitrated by current motivation) a statement about which edges are currently active in the graph.

---

## How boundaries get detected

Butz 2016 states plainly that deriving segmentation from free-energy inference **remains a future challenge**. Three working mechanisms are offered instead, plus one that segments without a detector at all:

| Mechanism | How it works | Cost |
|---|---|---|
| **Multiplicative gates (long short-term memory)** | a near-linear unit accumulates evidence; a saturating non-linear unit decides when the accumulation is passed on; identity recurrence maintains it until further notice. Linear part ≈ event progression, gate ≈ event boundary | trained by backpropagation through time — non-local, so the biological story is unpaid |
| **Explicit boundary monitors** | watch the continuous activation of predictive encodings; flag onset after prolonged inactivity, or cessation after prolonged activity | robust under very large sensory noise (demonstrated on doorway detection in the four-rooms task); but the thresholds are hand-set, not learned |
| **Driver/modulator wiring** | multiplicatively interacting predictive encodings, distinguishing driving from modulating inputs | shows the interaction is *expressible* in a predictive-coding substrate; not shown to segment anything |
| **Dynamical priors** | in a hierarchical dynamical model, the coupling between orders of motion (generalised coordinates) *is* what parses the stream: cutting those within-level self-connections in a synthetic songbird preserves frequency tracking but destroys sequential structure — the stream stops being segmented at all (Friston & Kiebel 2009) | no boundary is ever named or read out; segmentation is implicit in the flow, so nothing downstream can be indexed by it |

The honest summary: the *definition* of a boundary is principled and the *detector* is not. The dynamical-prior row sharpens what is missing: a system can *behave* as if segmented without any explicit boundary variable, and the surprise of the lesion result is that this implicit route matters **more** than the top-down structural prior.

---

## Why this is a gap the wiki did not have

The graph formalisation assumes the node set exists. On a continuous stream it does not, and nothing else in the wiki supplies it — grid codes presuppose a metric space already carved up, core knowledge presupposes entities already individuated, and attention selects among items already formed. Event segmentation is the first mechanism the wiki has for **where discrete states come from**. Recorded as gap G27.

Secondary consequence for aliasing (gap G2): because an event is a *set*, two identical observations belonging to different active sets are different events. Set membership is a de-aliasing tag that costs nothing extra, in the same way module membership does in [[wiki/concepts/core-knowledge.md]].

---

## Open problems

- **No learned boundary detector.** Between hand-set thresholds and backpropagation-through-time gates there is nothing local, learned, and derived from the objective.
- **The compression criterion is unspecified.** "Frequently encountered types of interaction may be clustered into episodes" names no clustering objective, no granularity control, and no stopping rule — so the depth of the temporal hierarchy is as unpinned as the planning horizon (gap G24).
- **Recursive composition is asserted, not demonstrated.** The lecture ⊂ studies ⊂ career example is the paper's own illustration; nothing shows a learned system building a recursion of that depth.
- **Boundary detection vs. surprise.** A boundary is a *lasting* change in active encodings, but so is a large prediction error from noise. What separates a real boundary from an outlier is a precision judgement the theory does not specify.

---

## Connections

- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the substrate this page abstracts over: events are sets of *its* active encodings, so segmentation needs no machinery beyond a change detector on that set; its hierarchical-dynamical form also supplies the implicit alternative, where priors on *motion* parse the stream and lesioning them costs more than lesioning the top-down priors (Friston & Kiebel 2009).
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the discretisation the graph formalisation assumes: events are nodes, event schemata are typed edges with preconditions and effects, episodes are compressed paths.
- **[[wiki/concepts/simulation-based-planning.md]]** — episode encodings are the coarse level that jumpy multi-scale planning needs, and backward chaining through schema preconditions is path search run in reverse from the goal.
- **[[wiki/concepts/working-memory.md]]** — the multiplicative gate that detects a boundary is the same gate that maintains an item, so segmentation and maintenance are one mechanism seen at two timescales.
- **[[wiki/concepts/attention.md]]** — a boundary is where the currently relevant set of encodings changes, i.e. an event boundary is a re-selection signal.
- **[[wiki/concepts/abstract-structural-codes.md]]** — an event schema is content-invariant in the same sense `g` is: the schema "reaching to contact" is defined by relative distance reaching zero, whatever object fills it.
- **[[wiki/concepts/core-knowledge.md]]** — the rival account of where discrete entities come from: individuation by entry-gated core systems rather than by temporal change in the active encoding set (tension T12).
- **[[wiki/concepts/meta-learning.md]]** — episode encodings are the meta-graph level made concrete: what is shared across instances is the schema, what varies is the binding of items to its slots.
- **[[wiki/entities/h-jepa.md]]** — the alternative to a boundary detector: fixed temporal pooling between prediction levels coarse-grains time without ever naming a boundary, which is cheaper and cannot produce variable-length events.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the engineered stand-in for boundary discovery: a token vocabulary is a hand-chosen discretisation of the stream (gap G27), and its cost is measurable in bits — larger vocabularies help small models and hurt large ones.
- **[[wiki/entities/hbtom.md]]** — supplies a typed boundary signal: surprise decomposed per latent (goal / rationality / whole-model likelihood) says not only that prediction broke but which variable to re-infer, which a monolithic predictor cannot produce.
- **[[wiki/concepts/subgraph-matching.md]]** — mechanises the step that fires a schema: testing whether a schema's precondition pattern occurs in the current state is a subgraph query, and the encoder's depth bounds how large a precondition may be.
- **[[wiki/concepts/contextual-inference.md]]** — the rival boundary criterion, and the one that supplies what this page lacks: a new node is created when the *novel-context* responsibility is high under a sticky hierarchical Dirichlet process, so the clustering objective, the granularity control (`γ`) and the stopping rule are one prior — paid for with a scalar node content (Heald et al. 2021; tension T23).
- **[[wiki/concepts/pattern-separation-completion.md]]** — the graded counterpart of a boundary decision: when experience gets a fresh code is set by a continuous separation bias rather than a discrete test, and the cholinergic storage/recall switch is a candidate boundary signal (Yassa & Stark 2011).
- **[[wiki/concepts/cognitive-map.md]]** — temporal boundaries cut episodic memory the way walls cut space, which is the only anchoring cue that has been shown to carry out of the spatial domain (Epstein et al. 2017).
- **[[wiki/concepts/offline-replay.md]]** — the same discretisation question one level up: what sets the boundaries of a replayed *sequence* (its length, where it is cut from the continuous trajectory) is explicitly unknown, as is what licenses a new node here.
- **[[wiki/entities/temporal-context-model.md]]** — the graded alternative to a boundary detector: context drifts continuously and the similarity between two context states *is* the segmentation, so "same event?" is a distance rather than a change-point decision.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — shows the timescale question is unavoidable rather than incidental: that model fixes "one observation = one session" by fiat while acknowledging hippocampal map switches at 100 ms–1 s, and names event segmentation as a candidate rule for when the posterior is recomputed at all.

- **[[wiki/concepts/memory-allocation-excitability.md]]** — a purely temporal segmentation running underneath the predictive-encoding one: everything encoded inside an hours-long excitability window is bound into one linked unit whether or not the active encoding set changed, so a boundary detector and an allocation tag can disagree about where an episode ends.

- **[[wiki/concepts/controller-knowledge-vs-process.md]]** — claims this page's episodes as the *contents of the control layer* and adds three properties they lack: a goal, a maintenance window that terminates on goal completion rather than by decay, and a partial-order variant that commits only some of the ordering (Wood & Grafman 2003).

- **[[wiki/concepts/schema-assimilation.md]]** — the same stored object indexed by overlap instead of by time, and with a content specification this page lacks: the situational reading of ventromedial prefrontal cortex says the stored unit carries spatial, temporal, causal, **evaluative and social** aspects bound together, and no prediction-error boundary detector produces the last two (Lieberman & Meyer 2018).
- **[[wiki/entities/pfc-columnar-planning-model.md]]** — the spatial instance of this page's boundary rule: a change-point in a self-motion statistic (probability of a sharp turn) recruits a new coarse column, chunking a whole corridor into one graph node exactly as a prediction-error boundary chunks a stream into one episode (Martinet et al. 2011).
