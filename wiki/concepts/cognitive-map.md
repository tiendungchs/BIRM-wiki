# Cognitive Map

**An allocentric representation of an environment that preserves relations (distance, direction, adjacency) among places, such that a route never travelled can be computed from it.**

Tolman's original criterion is behavioural and still the sharpest one available: a rat that has learned a roundabout route switches to a *direct* path when the familiar route is blocked. Detours and shortcuts are what a map buys; nothing else in the wiki's evaluation inventory tests structure this cheaply (Epstein et al. 2017).

The reason this page is not just a neuroscience page: **a cognitive map is a latent graph plus the two operations that make it usable** — anchoring it to the world and searching it. Epstein et al. 2017 decompose map-based navigation into exactly three elements, and the middle one is an operation [[wiki/concepts/latent-graph-discovery.md]] never named.

| Element | What it does | Substrate (human) | LGD role | Machine status |
|---|---|---|---|---|
| **Spatial coding** | Represent position and relations | Hippocampus (place-like, distance-preserving), entorhinal cortex (grid-like) | The graph estimate itself; `g` | Partially — codes emerge in trained models |
| **Anchoring** | Tie map coordinates to perceptual invariants of *this* environment; recover which map and where on it | Retrosplenial complex; boundary/geometry cues | Binding `g` to observations — **gap G39** | Absent |
| **Route planning** | Compute distance and direction to a goal, detour around obstacles | Hippocampus + entorhinal + prefrontal + posterior parietal | Path search — [[wiki/concepts/simulation-based-planning.md]] | Partially |

---

## Element 1 — spatial coding, and that it is a *map*

The claim needing evidence is not "the hippocampus is active during navigation" but "its code preserves relations". Four independent methods, all human:

| Method | Result | Why it is map-evidence |
|---|---|---|
| fMRI adaptation | Hippocampal response to a campus building scales with real-world distance to the building shown on the *previous* trial (Morgan et al. 2011) | Recovery from adaptation ⇒ representational distance tracks physical distance |
| MVPA (Multi-Voxel Pattern Analysis) | Patterns discriminate corners *within* a room while parahippocampal patterns discriminate *rooms* (Hassabis et al. 2009); with a month of life-logged real events, left anterior hippocampal pattern similarity tracks both spatial *and temporal* proximity | Two nested scales carried by different regions; time and space in one metric |
| Encoding model | Entorhinal BOLD is modulated with 60° periodicity by virtual heading — the signature of a population of aligned grid cells (Doeller et al. 2010); also present during *imagined* movement | A periodic code inferred from an aggregate signal |
| Intracranial recording | ~25% of hippocampal units in a taxi-driver game are place-selective and facing-direction-independent; grid-like entorhinal units; view cells; goal-identity cells | Single-unit confirmation in humans |

**Multiple maps in one store.** Global remapping (different cell set per context) and rate remapping (same cells, different rates) let one hippocampus hold many environments. During learning, similar contexts are *not* distinguished for a while and then abruptly are; at retrieval the response is all-or-nothing under ambiguous cues, the signature of attractor dynamics — and human multivoxel patterns show the same attractor-like behaviour under environmental ambiguity. This is [[wiki/concepts/pattern-separation-completion.md]] operating at the level of whole maps rather than single episodes: **the unit that gets separated is a graph, not a node.**

**The map is not all in the hippocampus.** Premorbidly learned maps survive medial temporal damage but in *schematized* form, and retrosplenial/medial parietal cortex is the candidate cortical store — the [[wiki/concepts/complementary-learning-systems.md]] consolidation gradient applied to structure, with detail as the part that stays hippocampus-dependent.

---

## Element 2 — anchoring: the operation the wiki was missing

A coordinate system is useless until its axes are pinned to something identifiable. Anchoring = determining the **orientation** and **displacement** of the map from perceptual input.

| Finding | Statement |
|---|---|
| **Distal cues set orientation** | Rotating extra-maze cues or wall cue cards rotates place fields, grid fields and head-direction tuning with them — in animals that still know which way they are facing |
| **Geometry takes over when lost** | After disorientation, rodents, birds, fish and human infants reorient by the *shape* of the enclosure, making 180° "geometric errors" in a rectangle even when non-geometric cues would disambiguate; place maps and head-direction cells realign to chamber geometry, and the alignment predicts the behaviour |
| **Boundaries set displacement** | Place-field locations are determined primarily by distances to walls; grid fields distort when walls move; human and rat search locations *translate* with a displaced boundary |
| **Stability is the criterion** | Boundaries dominate because they are fixed to the ground. Objects anchor only once learned to be stable, and only if the navigator's location is already known or the object has distinguishable façades — geometry defines an axis from its own shape |
| **Division of labour** | Parahippocampal place area and occipital place area do perceptual analysis of landmarks (layout, boundaries, navigational affordances); retrosplenial complex uses them to anchor — its response scales with viewpoint change in the *environmental* frame and is selectively enhanced for the most permanent objects |
| **Local↔global transform** | Retrosplenial heading codes generalise across geometrically similar subspaces (a *local* frame), while adjacent Brodmann area 29/30 codes heading globally across connected environments. Rodent retrosplenial cortex has both: classical head-direction cells and **bidirectional cells** that fire facing opposite ways in the two oppositely-polarised halves of an environment (Jacob et al. 2017) |

**Why the local/global pair matters computationally.** If you can read your heading relative to *local* geometry, and you know how the local geometry is oriented within the global map, you compose the two and recover global heading. That is a **two-stage anchoring chain**: a cheap, generalisable, content-blind local estimate plus a stored local→global rotation. The bidirectional cell is the reusable half — the same code fires in every subspace with the same shape.

**(brainstorm)** This is a concrete recipe for anchoring an abstract `g` and it costs no new machinery. Give the model (i) a *local* structural code computed from the currently visible relational skeleton alone, invariant to which instance it is, and (ii) a per-instance stored transform placing that local frame in the global structure. Retrieval then only needs to identify the transform, not re-derive the structure — one small per-instance parameter against a large reusable code, which is the meta/instance split of [[wiki/concepts/latent-graph-discovery.md]] applied to *reference frames* rather than to contents.

**(brainstorm)** Boundary-primacy is an inductive bias worth importing directly: rank candidate anchors by **stability**, not by salience or predictiveness, and prefer extended structure (relations that constrain many positions at once) over point features. In a reasoning model the analogue of a wall is a constraint that holds everywhere in the instance — a conserved quantity, an invariant, a type signature — and the analogue of a movable object is a surface feature. A model that anchors on the latter is exhibiting [[wiki/concepts/shortcut-learning.md]] in the anchoring stage rather than in the rule.

### Context retrieval vs. orientation

Epstein et al.'s cleanest export, and it splits an operation the wiki treats as one:

| Operation | Question | Spatial form | Dissociating evidence | Wiki status |
|---|---|---|---|---|
| **Context retrieval** | *Which* map? | Recover the map appropriate to this environment | Different behavioural responses to non-geometric cues during reorientation; place cells' sensitivity to non-metric cues; proposed to run on parahippocampal→hippocampal input | G37; [[wiki/concepts/contextual-inference.md]] answers it normatively |
| **Orientation** | *Where and facing where* on it? | Recover coordinates and heading | Responses to geometric cues; metric sensitivity of place cells; proposed to run on retrosplenial computation | **G39 — no page had this** |

Retrieval without orientation is a schema with no binding to the present situation; the wiki's subgraph-matching account ([[wiki/concepts/subgraph-matching.md]]) delivers *which stored structure occurs here* and stops exactly where orientation begins.

---

## Element 3 — route planning, and what the brain measures

| Quantity | Where | Detail |
|---|---|---|
| **Euclidean distance to goal** | Entorhinal cortex | Tracks change when a *new goal* is set; barrier-independent (Howard et al. 2014) |
| **Path distance to goal** | Posterior hippocampus | Tracked during travel; interacts with goal direction — greatest when the goal is close *and* directly ahead. Bat hippocampus has single cells for goal distance × direction, oversampling near and straight-ahead |
| **Local branching** | Posterior hippocampus | Response on entering a street scales with its degree centrality (how many onward paths) |
| **Global connectivity** | Anterior hippocampus | Scales with closeness centrality of the street in the whole network |
| **Search cost** | Lateral prefrontal cortex | Scales with the demands of a **breadth-first search** through the street network when a route must be replanned (Javadi et al. 2017) |
| **Hierarchical planning** | Rostrodorsal medial prefrontal cortex | Engaged by grouping the environment into chunks, independent of goal distance |
| **Egocentric conversion** | Posterior parietal cortex | Allocentric goal direction → "45° to the left" |

Three things a machine planner can take from this:

1. **The metric and the topology are computed by different structures and are not reconciled.** Entorhinal Euclidean distance is a *heuristic* — an admissible lower bound on path length — while hippocampal path distance and centrality measures are graph quantities. That is A\* with a learned heuristic, arrived at biologically; the review states the relation between the topological and Euclidean codes is unclear ([[wiki/empirical-tensions.md]] T27).
2. **Graph-theoretic features are represented explicitly.** Degree and closeness centrality are read out of the map before the search, which is exactly the information a search needs to prune — a candidate for the "which branch" half of gap G15.
3. **The predicted allocentric goal-direction cell does not exist.** Computational models require a code for "the direction of the goal in world coordinates"; no such neuron has been reported. Human entorhinal patterns for *facing* direction north and *goal* direction north are similar, suggesting the head-direction system is transiently re-pointed at the imagined heading instead — planning by **simulating being there**, not by computing a vector. That is [[wiki/concepts/simulation-based-planning.md]] winning over a vector-algebra account at the level of the code.

Hippocampal replay preserves the **topological** structure of connected tracks, and place cells fire ahead along each available arm at a choice point — the rollout mechanism the planning page already carries, here shown to respect adjacency rather than metric proximity.

---

## Beyond space

The review's reason for taking the map seriously as a general reasoning substrate, and the wiki's second and third instances of grid-like coding outside navigation:

| Domain | Finding |
|---|---|
| **Concept space** | Hexadirectional entorhinal modulation while viewing sequences of morphed birds (neck × leg lengths) aligned vs. misaligned to a sixfold axis; also in ventromedial prefrontal cortex, where signal strength correlates with task performance (Constantinescu et al. 2016) |
| **Social space** | Hippocampal response scales with the *angle* of the vector to a character in a power × affiliation space, posterior cingulate with its *magnitude* (Tavares et al. 2015) — a polar decomposition across two regions |
| **Discrete spaces** | Hippocampal-entorhinal coding of spaces defined by transitions between discrete items, with no underlying continuum |
| **Time / context** | Episodic memory is cut by temporal boundaries the way it is cut by spatial ones — [[wiki/concepts/event-segmentation.md]] |
| **Non-spatial cells** | Odour, elapsed-time and sound-frequency cells when those are the task's ordering dimension; human concept cells firing for a person independent of the evoking stimulus |

**And the anchoring element does not transfer.** There are no reports of cells coding the "boundary" of a concept or a social milieu, and the review states it is not clear what landmark, boundary or local geometry even mean in a non-spatial domain. So the two elements a machine can copy today (a metric-ish code, a search over it) are the two that already have machine analogues, and the one that is genuinely missing is also the one with no biological template outside space. This is gap G39's real content.

---

## Open problems

- **What supplies the metric in a non-spatial domain?** The discrete-transition result says a continuum is not required, but nothing says what distance *is* when items are related only by observed transitions.
- **How do metric and topological codes combine?** Explicitly unresolved ([[wiki/empirical-tensions.md]] T27).
- **Anchoring in abstract spaces** — no landmark, boundary or geometry analogue exists (G39).
- **What computes the local→global transform?** Named as the key question for future work on the perceptual side too: how landmark information *selects, aligns and positions* a map is unspecified.
- **What happens in over-familiar environments?** Hippocampal involvement drops once a route is known; whether the map is bypassed or merely quiet decides whether the map is the substrate of skilled behaviour or a scaffold for acquiring it — the [[wiki/concepts/amortized-inference.md]] question in navigational form.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — the cognitive map is this page's framing instantiated in its home domain, and it contributes the operation the framing lacked: anchoring a recovered structure to the present observation (G39), distinct from both discovery and navigation.
- **[[wiki/concepts/abstract-structural-codes.md]]** — supplies the code this page's element 1 is made of; conversely this page supplies the second and third demonstrations of grid-like coding outside space (concept morphs, social vectors) that the "is periodic coding general?" question needed.
- **[[wiki/concepts/simulation-based-planning.md]]** — element 3 is that page's path search with the neural read-outs attached: a Euclidean heuristic, graph centrality features for pruning, breadth-first search cost in lateral prefrontal cortex, and goal direction represented by re-pointing the heading system rather than by a goal-direction vector.
- **[[wiki/concepts/pattern-separation-completion.md]]** — remapping is that page's transfer curve applied to whole maps: attractor-like all-or-nothing selection under ambiguous cues is completion at the level of a graph, and the abrupt appearance of distinct codes for similar environments is separation at the same level.
- **[[wiki/concepts/contextual-inference.md]]** — context retrieval is that page's responsibility posterior; this page adds that retrieval alone is insufficient, because a retrieved map still has to be oriented before it can be read.
- **[[wiki/concepts/subgraph-matching.md]]** — matching decides *which* stored structure is present and stops there; anchoring is the next step, fixing the correspondence's orientation and offset so coordinates can be read off.
- **[[wiki/concepts/complementary-learning-systems.md]]** — maps consolidate: premorbidly learned environments survive medial temporal damage in schematized form, with retrosplenial/medial parietal cortex the cortical store and the hippocampus retained for fine detail.
- **[[wiki/concepts/core-knowledge.md]]** — the reorientation literature's geometric module is this page's anchoring element seen as an installed prior; boundary-primacy after disorientation is the same experiment read from the developmental side.
- **[[wiki/concepts/event-segmentation.md]]** — temporal boundaries cut memory the way walls cut space, which is the one anchoring analogue that does transfer out of the spatial domain.
- **[[wiki/concepts/shortcut-learning.md]]** — anchoring gives the shortcut problem a second site: a model can learn the right structure and still bind it to the least stable cue in the scene, which is stability-ranking failure rather than rule failure.
- **[[wiki/concepts/working-memory.md]]** — the shortest-path-over-a-subway-map task that page carries is element 3 with the map handed over; this page is where the map comes from.
- **[[wiki/concepts/amortized-inference.md]]** — hippocampal involvement falls away in highly familiar environments, the navigational form of a plan being compiled into a cached policy.
