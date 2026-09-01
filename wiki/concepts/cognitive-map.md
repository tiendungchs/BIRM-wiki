# Cognitive Map

**An allocentric representation of an environment that preserves relations (distance, direction, adjacency) among places, such that a route never travelled can be computed from it.**

Tolman's original criterion is behavioural and still the sharpest one available: a rat that has learned a roundabout route switches to a *direct* path when the familiar route is blocked. Detours and shortcuts are what a map buys; nothing else in the wiki's evaluation inventory tests structure this cheaply (Epstein et al. 2017).

The reason this page is not just a neuroscience page: **a cognitive map is a latent graph plus the two operations that make it usable** — anchoring it to the world and searching it. Epstein et al. 2017 decompose map-based navigation into exactly three elements, and the middle one is an operation [[wiki/concepts/latent-graph-discovery.md]] never named.

| Element | What it does | Substrate (human) | LGD role | Machine status |
|---|---|---|---|---|
| **Spatial coding** | Represent position and relations | Hippocampus (place-like, distance-preserving), entorhinal cortex (grid-like) | The graph estimate itself; `g` | Partially — codes emerge in trained models |
| **Anchoring** | Tie map coordinates to perceptual invariants of *this* environment; recover which map and where on it | Retrosplenial complex; boundary/geometry cues | Binding `g` to observations — **gap G39** | Absent, except where the topology is installed and hands over its symmetry group with it ([[wiki/entities/gcq.md]]) |
| **Route planning** | Compute distance and direction to a goal, detour around obstacles | Hippocampus + entorhinal + prefrontal + posterior parietal | Path search — [[wiki/concepts/simulation-based-planning.md]] | Partially |

---

## Element 1 — spatial coding, and that it is a *map*

The claim needing evidence is not "the hippocampus is active during navigation" but "its code preserves relations". Four independent methods, all human:

| Method | Result | Why it is map-evidence |
|---|---|---|
| fMRI adaptation | Hippocampal response to a campus building scales with real-world distance to the building shown on the *previous* trial (Morgan et al. 2011) | Recovery from adaptation ⇒ representational distance tracks physical distance |
| MVPA (Multi-Voxel Pattern Analysis) | Patterns discriminate corners *within* a room while parahippocampal patterns discriminate *rooms* (Hassabis et al. 2009); with a month of life-logged real events, left anterior hippocampal pattern similarity tracks both spatial *and temporal* proximity | Two nested scales carried by different regions; time and space in one metric |
| Encoding model | Entorhinal BOLD is modulated with 60° periodicity by virtual heading — the signature of a population of aligned grid cells (Doeller et al. 2010, [[wiki/concepts/hexadirectional-signal.md]]); also present during *imagined* movement. Right entorhinal only, fast runs only, four-/five-/seven-/eight-fold null, and the *coherence* of the orientation estimate across entorhinal voxels predicts object-replacement accuracy (`ρ` = 0.32) | A periodic code inferred from an aggregate signal — **directional only**: the instrument is blind to position by construction, so it is map evidence about trajectories, not about places |
| Intracranial recording | ~25% of hippocampal units in a taxi-driver game are place-selective and facing-direction-independent; grid-like entorhinal units; view cells; goal-identity cells | Single-unit confirmation in humans |

**Multiple maps in one store.** Global remapping (different cell set per context) and rate remapping (same cells, different rates) let one hippocampus hold many environments. During learning, similar contexts are *not* distinguished for a while and then abruptly are; at retrieval the response is all-or-nothing under ambiguous cues, the signature of attractor dynamics — and human multivoxel patterns show the same attractor-like behaviour under environmental ambiguity. This is [[wiki/concepts/pattern-separation-completion.md]] operating at the level of whole maps rather than single episodes: **the unit that gets separated is a graph, not a node.**

**And the selection between them is an inference, not a response to the environment.** Sanders et al. 2020 ([[wiki/entities/hidden-state-inference-remapping.md]]) make map identity a *hidden state* inferred under a Chinese Restaurant Process prior, which changes what the four remapping categories are: not kinds, but points on one axis of log posterior odds, with partial and rate remapping sitting at the uncertain middle. Three consequences for this page:

- The "not distinguished for a while and then abruptly are" schedule above is the simplicity bias being overcome by accumulating evidence — the same simulation with the opposite ground truth yields map *stabilisation*, and early in training the two are indistinguishable to the learner.
- **Remapping is not controlled by the experimenter's variables.** Morph experiments give opposite answers in different labs, and an attempted exact replication (Colgin et al. 2010 of Wills et al. 2005) reversed the original result. Under this account that is expected: remapping tracks the animal's inferred partition of its entire experiential history, of which the experimenter manipulates a subset ([[wiki/empirical-tensions.md]] T35).
- **There is no causal evidence that map selection drives context-dependent behaviour** — and one report of task-performance transfer *across* near-global remapping ([[wiki/empirical-tensions.md]] T36).

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

**Where the transform might be computed.** Chen et al. 2022 predict a *universal* egocentric→allocentric conversion running across all sensory cortices, since every modality's input arrives self-centred while the map is world- or object-centred. Two candidate substrates: posterior parietal cortex (projects to sensory, entorhinal and frontal cortex, carries spatially-modulated cells, testable by optogenetic inactivation of the rodent S1/V2 grid response), and the thalamus as a **multiplexer** relaying multisensory streams reciprocally to every cortical region, with bursting neurons plus theta/gamma coordination as the multiplexing mechanism. This is the wiki's first biological candidate machinery for G39 — and it is a prediction with no supporting experiment, inside space only ([[wiki/concepts/distributed-reference-frames.md]]).

### Context retrieval vs. orientation

Epstein et al.'s cleanest export, and it splits an operation the wiki treats as one:

| Operation | Question | Spatial form | Dissociating evidence | Wiki status |
|---|---|---|---|---|
| **Context retrieval** | *Which* map? | Recover the map appropriate to this environment | Different behavioural responses to non-geometric cues during reorientation; place cells' sensitivity to non-metric cues; proposed to run on parahippocampal→hippocampal input | G37; [[wiki/concepts/contextual-inference.md]] answers it normatively |
| **Orientation** | *Where and facing where* on it? | Recover coordinates and heading | Responses to geometric cues; metric sensitivity of place cells; proposed to run on retrosplenial computation | **G39 — no page had this** |

Retrieval without orientation is a schema with no binding to the present situation; the wiki's subgraph-matching account ([[wiki/concepts/subgraph-matching.md]]) delivers *which stored structure occurs here* and stops exactly where orientation begins.

**Orientation now has a formal statement, and it is nested inside retrieval rather than following it.** Sanders et al. 2020's treatment of cue-rotation experiments has to insert an alignment stage before any likelihood can be evaluated, because feature vectors of cue *angles* are equivalent up to a common offset:

```
for each candidate map k:   φ_k = argmax_φ  P(y_new − φ ∣ Y_k)      # orient this map
then:                        compare maps using each map's own best φ_k   # retrieve
```

Three things follow that the two-stage reading above does not give:

1. **Every candidate map is oriented separately, and orientation happens *first*.** You cannot pick the map and then align it; the alignment is part of what makes the map fit. Retrieval is a maximisation nested inside a marginalisation.
2. **A map whose best alignment is still a poor fit is evidence for a new map.** The offset search is what converts "this looks wrong" into "this is somewhere else" — so failed orientation is the trigger for allocation, which is the one link between the two operations of the table above.
3. **The offset is exactly the small per-instance parameter the brainstorm above asked for.** `φ_k` is a stored map's pose in the current frame — one cheap number against a large reusable structural code. Reference-direction inference is the concrete, sourced version of the local→global transform, in the one domain (angles) where the transform group is known. What the transform group *is* in an abstract space remains unsaid, which is the residue of G39.

**And the whole operation has been watched running, in a fly.** Seelig & Jayaraman 2015 image the complete ellipsoid-body compass population ([[wiki/entities/fly-central-complex.md]]) and get the three-part decomposition of this table in a circuit of a few dozen identified neurons:

| This page's element | Fly observation |
|---|---|
| Reusable structural code | One bump on an anatomical ring; a 270° arena is mapped onto the ring's full 360°, so the code rescales to the environment instead of inheriting its geometry |
| **Orientation (`φ_k`)** | The bump-to-landmark offset is arbitrary, fly-specific, stable within a trial and re-assigned between trials — the pose parameter and the reusable code are *physically* separable |
| **Context retrieval / landmark selection** | With two indistinguishable stripes the bump commits to one (winner-take-all) rather than splitting or averaging, and occasionally transitions between the two offsets |
| Anchoring under conflict | Landmark beats self-motion: displace the cue and the bump follows it *preserving the offset*; change the closed-loop gain and the bump tracks the cue, not the animal's turning |

Two things this adds that the mammalian literature above does not. First, **failed disambiguation produces a coherent wrong frame, not a degraded one** — the aliased-landmark case is exactly the "map whose best alignment is still a poor fit" of the argmax formulation, but here the system commits anyway and behaves confidently on a wrong offset. Second, **the reset has a time constant**: successive landmark jumps in the same trial were followed once quickly and once slowly, as if the current binding is defended before being overwritten. **(brainstorm)** That is the stability-ranking bias of the row above implemented dynamically rather than as a prior — a landmark earns the right to move the frame in proportion to how well it has predicted so far.

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

---

## Beyond space

The evidence that the map is a general relational substrate — fourteen non-spatial domains, four of them at cellular resolution, one matched control returning a null, and the finding that the three elements above transfer **unequally**: the code and the search generalise, and **anchoring has no non-spatial instance anywhere**. Moved to its own page at the 244-source lint: [[wiki/concepts/nonspatial-maps.md]]. It also holds the two map operations isolated only in non-spatial work — assimilating new nodes without rebuilding the frame, and carrying two unmerged structures over the same objects.

## The model side: what actually builds the map

Whittington et al. 2022 bring the hippocampal-formation models into one language, and four of their claims are architectural rather than neuroscientific.

**1. Map or memory — the models split, and the split may be a schedule.** State-space models ([[wiki/concepts/successor-representation.md]], [[wiki/entities/cscg.md]]) make hippocampus the map: connections between hippocampal cells *are* the graph's edges. Generalisation models ([[wiki/entities/tolman-eichenbaum-machine.md]]) make it a pure index binding cortical codes, with all predictive power in cortex. The proposed reconciliation is temporal: **in novel structure the hippocampus builds a relational map; once cortex has learned how to structure that kind of world, the hippocampus falls back to being memory** — and the transition should track the behavioural onset of generalisation. That is a testable schedule, and it is also the reason the two learn at different speeds ([[wiki/empirical-tensions.md]] T28).

**2. Credit assignment through generalisation.** Reinforcement learning assumes a fixed state space to which value is slowly assigned. Goal-vector cells invert this: once *one* forms at a goal, path integration builds the rest for free, and if these bases were learned with value already attached, a new goal configuration is solved by **composing pre-credit-assigned bases** rather than by learning. The only online work is inferring which bases to compose. Where the bases come from is the interesting part — from the *statistics of behaviour* generated by ordinary striatal RL, giving a cycle: striatum acts badly, cortex learns compositional representations of the resulting sequences, those representations then serve as the state space striatum learns over next.

**3. Replay as offline state-space construction.** To tie a goal-vector cell to every location, path-integrate *offline*: replay trajectories away from a reward, composing a new vector cell onto each location visited and binding it in memory. Re-entering the environment then finds the value map already built. This is a third function for replay beside interleaving and consolidation ([[wiki/concepts/complementary-learning-systems.md]]), and it makes replay pattern a *prediction* rather than an observation.

**4. Representational drift as temporal remapping.** If hippocampal cells are conjunctions of space, sensory content and *time*, then a slowly advancing cortical time code makes the hippocampal code drift while the spatial and sensory factors stay fixed — drift is remapping with time as the changed factor, and the order of drifting cells should therefore not be random. **(brainstorm, following the source)** The upside is a training-signal one: drift makes a single environment present itself to cortex as many environments, which is data augmentation for structure learning — the one place the wiki has seen instability argued to *help* abstraction rather than threaten it.

**5. The hierarchy above space is a sketch.** A prefrontal module coding "location in task" (before the oven, after the chopping) would contextualise the entorhinal-hippocampal system and let a recipe transfer across kitchens; the link would run through hippocampal memory as before. Prediction: **route-dependent goal-vector cells** — vector cells modulated by position in task, splitter cells generalised off the maze. Nothing implements it (gap G40).

### The map watched forming, and what it turns out to be made of

Sun et al. 2025 is the only source in the wiki that records a hippocampal map through its entire construction (mouse dorsal CA1, 3,000–5,000 cells tracked for weeks, [[wiki/entities/cscg.md]]). Four claims that bear on this page's three elements.

| Claim | Content | Which element |
|---|---|---|
| **The map is a state machine, not a chart** | The learned object is a set of near-orthogonal population states, one per *latent task state*, with transitions driven by the animal's own movement — so short-term memory of the indicator cue is carried by *which state the population is in*, not by sustained activity. The classical finite-state-machine reading is explicit, and the loop is closed through the body: states set behaviour (speed, licking), behaviour changes the sensory input, input drives the transition | Element 1 |
| **Cell types are a continuum, and cells move along it** | Place, splitter and remapping-splitter responses are three regions of one difference-score × correlation plane, populated continuously, and individual cells migrate between them across sessions. The source's proposal is to stop treating them as types: they are **state cells** whose tuning is whatever the currently inferred latent state requires | Element 1 |
| **An established map is reused, and only the leaf is rebound** | Swapping the indicator pair for an unfamiliar one is learned in 147 ± 39 trials against 483 ± 70 for the first; population-vector correlation between old and new trials is high everywhere except the indicator region itself. Structure transfers, sensory identity is rewritten | Element 2 — this is *anchoring*, in the one form where the wiki has a number for how much it buys |
| **Under distortion the map snaps to discrete states rather than rescaling** | Lengthen the grey zones and cells do not stretch their fields uniformly. On near trials the pre-near-reward tuning persists through the extension (the animal behaves as though still in that state); on far trials cells jump to the pre-far-reward state, then reset when the first reward cue appears | Element 1, and direct evidence on T27 (metric vs topological) |

**The fourth row is the sharpest thing here for a builder.** A metric map deforms continuously under a metric distortion; a topological state machine does the two things observed instead — hold a state past its usual extent, or jump to the next plausible state — and then re-anchor on the first disambiguating observation. That is inference over discrete latent states with an observation-triggered reset, which is [[wiki/entities/hidden-state-inference-remapping.md]]'s posterior running inside a *single* map rather than between maps.

**The price.** The task is one-dimensional, deterministic, and its latent structure is a 26-symbol cycle; nothing here tests whether the same account survives a branching or a two-dimensional environment, and the "state machine" description is fitted post hoc to a task the experimenters designed as a state machine.

### The one machine model that implements all three elements — by installing two of them

[[wiki/entities/gcq.md]] (Peng et al. 2025) is worth a note here because it is the only entry in the wiki where the three-element decomposition above is *completely* covered by one trained system, and because of how cheaply it gets there.

| Element | How GCQ covers it | What that costs |
|---|---|---|
| Spatial coding | The map **is** the attractor set of a toroidal continuous attractor network — installed by translation-invariant weights before any data arrive | Topology is a designer's claim about the domain (G47); every dataset was chosen to be a product of cycles |
| **Anchoring** | `argmax` over the torus's translation group — pick the base bump `e_k` whose action-integrated trajectory best fits the *whole* initialisation observation sequence in L2 | **Batch, not online.** All `n` observations vote once; the rollout never re-anchors afterwards, the opposite of the fly's discrete landmark reset ([[wiki/entities/fly-central-complex.md]]) and of TEM's retrieve-to-correct loop |
| Route planning | Greedy descent `s_i ⊖ s_j = argmin_{a∈A} ‖s_j + a − s_i‖`, one valid displacement per step, constant cost, terminating on a no-op | The map has **every** edge — a bump on a torus always moves in all four directions — so nothing represents a wall, and the "detour around obstacles" half of Tolman's own criterion has no mechanism (results are qualitative) |

The transferable point is that G39's missing ingredient is a *group*: anchoring is computable here precisely because installing the topology also installs the symmetry group that relates a stored frame to the present one. That is why the operation exists on a torus and nowhere abstract.

---

## Open problems

- **Is the map amodal at all?** The one design that matches relational demand across domains finds the hippocampus only in the spatial version, and the mentalising network carrying the social one (Kumaran & Maguire 2005, [[wiki/empirical-tensions.md]] T45). Every "beyond space" row above is an unmatched contrast; until one of them is re-run against a domain-matched control, the generality of the map is asserted, not measured. The strongest thing the positive side has added since is *novelty of the structure*, not domain matching: a social space built inside the experiment yields hippocampal-entorhinal distance coding and a grid code (Park et al. 2021), which shifts the live variable from spatial-vs-social to old-vs-new.
- **What supplies the metric in a non-spatial domain?** The discrete-transition result says a continuum is not required. The one direct answer is a *predictive* one — a weighted sum over future states, warped away from the topological distance by how much traffic each edge carries (Garvert et al. 2017) — which relocates the question to why the brain stores a traffic-weighted rather than a shortest-path metric.
- **How do metric and topological codes combine?** Explicitly unresolved ([[wiki/empirical-tensions.md]] T27).
- **How many maps are there over one item set, and what selects among them?** (`G12` — the selector is the routing policy, and no model here has one.) Two relational structures over the same objects are held in anatomically separate parts of the hippocampal formation rather than fused (Zheng et al. 2024), so "retrieve the map" (G37) is under-specified: retrieval must pick a *structure over the current items*, not only a context. Nothing in the source or the wiki says what performs that selection, how many parallel maps a node set can support, or what happens when a query needs both at once ([[wiki/empirical-tensions.md]] T51).
- **Anchoring in abstract spaces** — no landmark, boundary or geometry analogue exists, and while the argmax-over-offset formulation gives anchoring a general shape (maximise the posterior predictive over the symmetry group relating stored frame to present frame), nothing says what that group is when the space is not spatial (G39).
- **What computes the local→global transform?** Named as the key question for future work on the perceptual side too: how landmark information *selects, aligns and positions* a map is unspecified.
- **What decides whether to extend a map or rebuild it?** New nodes inserted into a known map are assimilated by *preserving* the existing entorhinal frame, and how well a subject preserves it predicts their inference over the new items (Qu et al. 2026). Nothing says what would license the opposite decision — a genuinely incompatible addition should force a re-fit, and no criterion for that switch exists here or in any model (G38 asked at map scale rather than at item scale).
- **Does the hippocampal formation hold the graph at all, or only the instances it is abstracted from?** A prefrontal columnar planner reproduces detour "insight" with the hippocampus reduced to a redundant localisation input, and finds every unit type a graph-planner needs in medial prefrontal recordings ([[wiki/entities/pfc-columnar-planning-model.md]], [[wiki/empirical-tensions.md]] T107). Whether cortical chunking duplicates the multi-scale entorhinal code or is orthogonal to it — chunking by *action structure* rather than by distance — is open.
- **What happens in over-familiar environments?** Hippocampal involvement drops once a route is known; whether the map is bypassed or merely quiet decides whether the map is the substrate of skilled behaviour or a scaffold for acquiring it — the [[wiki/concepts/amortized-inference.md]] question in navigational form.

- **Element 2's anchoring operation has two incompatible readings and no paradigm measures both.** Under metric distortion the map either rescales (grid and place fields stretching with the walls) or snaps to a discrete task state (Sun et al. 2025: extended grey zones produce persistence on near trials and a *jump* to the far-reward state on far trials, both reset by the first disambiguating cue). The two are measured in different paradigms — open-field boundary manipulation vs. a 1-D corridor with strong task-state structure — so the honest reading is that the map's format depends on whether the task defines discrete states, which is itself untested ([[wiki/empirical-tensions.md]] T54, and T27 behind it). It decides whether the machine analogue is a continuous chart with a scale parameter or a state machine with an observation-triggered reset.

---

## Connections

- **[[wiki/concepts/nonspatial-maps.md]]** — this page's evidence base outside physical space, split off at the 244-source lint: the same three elements tested in concept, social, discrete-graph, rank, gaze and evidence spaces, where two of them generalise and anchoring does not — which is why `G39` is a gap with no biological template rather than an unbuilt mechanism.

- **[[wiki/entities/vector-hash.md]]** — the strongest argument in the wiki that the map machinery is not *for* space: spatial and episodic memory are co-localised because a low-dimensional vector-updatable code is what high-capacity sequence memory requires, whatever the episode contains — non-spatial sequences are stored on the same scaffold by choosing an arbitrary trajectory through it.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the storage side of the same anatomy: mixed continuous/discrete attractors bind an object to a place, many charts coexist in one network so map selection is attractor selection, and grid codes are treated as *unsuitable* for binding until dentate competitive learning converts them into place-like conjunctions.

- **[[wiki/concepts/latent-graph-discovery.md]]** — the cognitive map is this page's framing instantiated in its home domain, and it contributes the operation the framing lacked: anchoring a recovered structure to the present observation (G39), distinct from both discovery and navigation.
- **[[wiki/concepts/abstract-structural-codes.md]]** — supplies the code this page's element 1 is made of, and the developmental result that makes its *strength* the mediating variable behind inferential ability (Qu et al. 2026); conversely this page supplies the second and third demonstrations of grid-like coding outside space (concept morphs, social vectors) that the "is periodic coding general?" question needed, and now also the matched-domain null that bounds them (hippocampus for spatial but not social chain-search, same people, same graph).
- **[[wiki/concepts/compositionality.md]]** — supplies the factorise-vs-entangle trade-off this page's parallel-maps result adjudicates: two relational structures over one item set stay in separate hippocampal territory instead of being fused into a conjunctive code, so biology declines the entangled option even where the items always co-occur (Zheng et al. 2024, G40).
- **[[wiki/concepts/simulation-based-planning.md]]** — element 3 is that page's path search with the neural read-outs attached: a Euclidean heuristic, graph centrality features for pruning, breadth-first search cost in lateral prefrontal cortex, and goal direction represented by re-pointing the heading system rather than by a goal-direction vector.
- **[[wiki/concepts/pattern-separation-completion.md]]** — remapping is that page's transfer curve applied to whole maps: attractor-like all-or-nothing selection under ambiguous cues is completion at the level of a graph, and the abrupt appearance of distinct codes for similar environments is separation at the same level.
- **[[wiki/concepts/contextual-inference.md]]** — context retrieval is that page's responsibility posterior; this page adds that retrieval alone is insufficient, because a retrieved map still has to be oriented before it can be read, and it takes from that page the causal evidence that the non-spatial latent-context code is *necessary* for the strategy it supports (Mishchanchuk et al. 2024).
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — makes map selection an explicit posterior over hidden states and, in doing so, supplies this page's missing orientation operation as an argmax over rotational offsets computed per candidate map, nested inside retrieval rather than following it.
- **[[wiki/concepts/subgraph-matching.md]]** — matching decides *which* stored structure is present and stops there; anchoring is the next step, fixing the correspondence's orientation and offset so coordinates can be read off.
- **[[wiki/concepts/complementary-learning-systems.md]]** — maps consolidate: premorbidly learned environments survive medial temporal damage in schematized form, with retrosplenial/medial parietal cortex the cortical store and the hippocampus retained for fine detail.
- **[[wiki/concepts/core-knowledge.md]]** — the reorientation literature's geometric module is this page's anchoring element seen as an installed prior; boundary-primacy after disorientation is the same experiment read from the developmental side.
- **[[wiki/concepts/event-segmentation.md]]** — temporal boundaries cut memory the way walls cut space, which is the one anchoring analogue that does transfer out of the spatial domain.
- **[[wiki/concepts/shortcut-learning.md]]** — anchoring gives the shortcut problem a second site: a model can learn the right structure and still bind it to the least stable cue in the scene, which is stability-ranking failure rather than rule failure.
- **[[wiki/concepts/working-memory.md]]** — the shortest-path-over-a-subway-map task that page carries is element 3 with the map handed over; this page is where the map comes from.
- **[[wiki/concepts/continual-learning.md]]** — the map's version of the stability/plasticity problem, and the one setting where biology's answer is measured: hold the structural frame fixed and write only the new bindings and the distance readout, with frame constancy predicting how well the new items can be reasoned about (Qu et al. 2026).
- **[[wiki/concepts/amortized-inference.md]]** — hippocampal involvement falls away in highly familiar environments, the navigational form of a plan being compiled into a cached policy.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the model that produces this page's element 1 from next-observation prediction alone, and the source of the map-vs-memory position that makes hippocampus an index rather than a graph.
- **[[wiki/concepts/path-integration.md]]** — the mechanism under element 1 and the reason element 2 exists at all: an integrator has no absolute reference, so it must be reset by anchoring or it drifts.
- **[[wiki/concepts/successor-representation.md]]** — the predictive-map reading of the same cells: place fields as rows of a discounted future-occupancy matrix, which explains their policy-dependent skew and barrier deformation.
- **[[wiki/entities/cscg.md]]** — the opposite of the index view: hippocampal edges *are* the map, learned de novo per environment, fast and local but with no transfer. It is also the only model matched against this page's map *forming* rather than formed, and the one that predicts the state-cell continuum, the ordered de-aliasing and the snap-to-discrete-state behaviour under task distortion (Sun et al. 2025).
- **[[wiki/concepts/offline-replay.md]]** — the map's offline maintenance: replayed sequences respect the current barrier configuration and preserve topology rather than metric proximity, which is evidence that what is reinstated is the graph rather than the trajectory.
- **[[wiki/concepts/offline-replay.md]]** — and the map's offline *extension*: ripple co-activation for a cue and an outcome never experienced together grows across days, which is how a map comes to stretch beyond direct experience rather than merely being maintained (Barron et al. 2020).
- **[[wiki/concepts/distributed-reference-frames.md]]** — the rival architecture to this page's single anchored-and-searched map: grid coding replicated per cortical area and anchored to *objects* rather than to the world, with recognition as consensus across frames. It also supplies this page's first candidate machinery for the anchoring operation (a universal egocentric→allocentric transform in posterior parietal cortex, multiplexed by thalamus) and the detector caveat that qualifies the "beyond space" table.
- **[[wiki/entities/temporal-context-model.md]]** — the strongest form of "the map is a memory mechanism run on a spatial task": one drift equation given velocity inputs yields the entorhinal place code and given word inputs yields free-recall contiguity, which is this page's domain-generality argument made from the mechanism side.
- **[[wiki/concepts/population-geometry.md]]** — supplies this page's only human single-unit "beyond space" entry and its only *formation* result (an abstract latent-context code appears in hippocampus when and only when inference is performed, and can be installed by verbal instruction in four minutes, Courellis et al. 2024); and the measured version of this page's reusable-code-plus-pose decomposition: 69–75% of a CA1 manifold's geometry transfers between animals through a single `SO(5)` rotation, so `φ_k` is realised as 10 parameters against a 5-dimensional structure — and it supplies the single-unit evidence-accumulation entry the "beyond space" table lacked.
- **[[wiki/entities/fly-central-complex.md]]** — element 2 observed end-to-end in a complete population: a reusable ring code plus one arbitrary, re-assignable landmark offset, winner-take-all selection between aliased landmarks, and landmark-over-self-motion arbitration implemented as an offset-preserving reset with its own time constant.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the map's features have separate causes from the map itself: place-field stability, context generalization and selectivity each covary with a different interneuron family and are each changed by activating that family alone, and interneuron populations decode position as well as size-matched pyramidal populations (T52) — so element 1 is built by the excitatory machinery and *shaped* by an inhibitory one.
- **[[wiki/entities/stp-flickering-cann.md]]** — a map switch is neither instantaneous nor clean: for seconds after a cue change, which map is live is decided per theta cycle by a competition between sensory input and a synaptic gain trace, with the animal's distance from the switch point one of the terms.
- **[[wiki/entities/thousand-brains-theory.md]]** — the claim that this page's machinery is the *ancestor* of cortex rather than a specialisation: entorhinal what/where streams and hippocampal binding miniaturised into layers 4/6 and 2/3 of every column, which turns the single-map-versus-many-frames rivalry into one mechanism instantiated at two scales.
- **[[wiki/entities/differentiable-neural-computer.md]]** — route planning with the map handed over: shortest paths and traversals on a subway map read from memory-stored edge triples, which is the boundary this page's non-spatial and inferential findings sit beyond.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — where the map is read as *context* rather than as position: medial prefrontal cortex receives ventral/intermediate hippocampal output, whose fields are large enough to code which environment the animal is in, so the controller inherits environment identity with no place fields of its own — and its cells are nonetheless modulated by ~1 cm position differences, which must therefore arrive by another route (Euston et al. 2012).
- **[[wiki/concepts/schema-assimilation.md]]** — the long axis read as a generality gradient with a named consumer for each end: dorsal/posterior hippocampus codes specific items at specific places, ventral/anterior codes what all events of a context share and discriminates contexts better, and only the ventral end projects to the controller — so the map exists at two grains simultaneously rather than one ([[wiki/empirical-tensions.md]] T51).
- **[[wiki/entities/nucleus-reuniens.md]]** — the map has a second writer: prefrontal lesions degrade hippocampal place-cell spatial firing, and the prefrontal→reuniens→hippocampus arm carries the *future path* during goal-directed behaviour, so goal information enters the map in the map's own code rather than being applied to its read-out (Jin & Maren 2015).
- **[[wiki/entities/spacetime-attractor.md]]** — the same structural knowledge indexed by *time-to-arrival* instead of by place, and held in prefrontal rather than hippocampal circuits: one copy of the map per planning step, which is what lets the map be queried about *when* rather than only *where* (Jensen et al. 2026).
- **[[wiki/entities/pfc-columnar-planning-model.md]]** — supplies a circuit for this page's route-planning read-outs: distance-to-goal as the amplitude of an attenuating retrograde wave rather than a stored quantity, and hierarchical chunking implemented as a second, coarser column population recruited at self-motion change-points (Martinet et al. 2011).
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the read port onto this map: the channel originates in the ventral/anterior pole, whose fields are large enough to code global context, so the controller receives the map's coarse level and never its places.
- **[[wiki/entities/gcq.md]]** — element 2 implemented, for once: anchoring as `argmax` over the torus's own translation group, the offset being the base bump index chosen by L2 fit over the *whole* initialisation sequence. It is batch anchoring rather than an online reset, the group exists only because the topology was installed, and elements 1 and 3 come free with it — the map is the CANN's state space and route planning is greedy bump displacement at constant cost per step.
- **[[wiki/entities/hit-jepa.md]]** — metric structure supplied by the tokeniser rather than learned by the encoder: positions are H3 hexagonal cells (six equidistant neighbours) whose embeddings are pretrained by node2vec on the adjacency graph, and because the tiling resolution is a free parameter the same trained encoder transfers from city blocks (res 11) to ocean basins (res 4) — the transfer result is a property of that basis, not of the JEPA above it (Li et al. 2025).
- **[[wiki/concepts/convergent-circuit-motifs.md]]** — the comparative census of structures that build the allocentric map this page defines, across vertebrates, cephalopods, insects, spiders and crustaceans; its contribution here is that the reusable-code-plus-instance-offset factorisation recurs across phyla, which is evidence the decomposition is right rather than a hippocampal accident.
- **[[wiki/concepts/hexadirectional-signal.md]]** — the instrument behind this page's Element-1 encoding-model row, unpacked: what a six-fold BOLD modulation is derived from, which controls make it a detector, and why it can supply directional map evidence but never positional map evidence.
