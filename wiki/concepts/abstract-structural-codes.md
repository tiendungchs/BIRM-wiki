# Abstract Structural Codes

**A code that represents an item's *position in a relational structure*, invariant to the objects, individuals or scene elements that fill the structure — the wiki's `g`, as opposed to the content code `x`.**

If far transfer means reusing structure across domains that share no surface features, then something must represent the structure separately from what fills it. This page tracks the candidates and the evidence, which is currently thin (Hassabis et al. 2017).

---

## The requirement

| Requirement | Statement |
|---|---|
| **Content invariance** | The code must not change when the objects populating the domain change |
| **Relational content** | It must code relations among patterns of input, not the inputs |
| **Path consistency** | The same structural position must be reached by any route to it (gap G3) |
| **Decomposability** | It should decompose a state space in a way that exposes subgoals, so hierarchical planning has something to plan over |

Requirement 4 is what makes structural codes an efficiency claim and not just a representational one.

---

## Grid codes as the leading biological candidate

| Fact | Source status |
|---|---|
| Entorhinal cells encode allocentric space with a periodic "grid" code, receptive fields tiling the local space in a hexagonal pattern | Established |
| Grid codes decompose state spaces efficiently, in a way that could support subgoal discovery and hierarchical planning | Theoretical argument |
| Functional neuroimaging shows grid-*like* codes in humans performing an **abstract categorization** task — periodic coding as a general hallmark of knowledge organization, not a spatial specialization | One report, explicitly flagged as requiring much further work |
| Direct evidence for object-invariant relational codes in the mammalian brain | **Absent** — the paper states we currently lack it |
| The `g`/`x` invariance split is measurable cell by cell: object-vector cells in the structural layer generalise over object identity within and across environments, while landmark cells in the conjunctive layer stay object-specific — same architecture, same training, opposite invariance, matching recordings | Model plus supporting recordings (Whittington et al. 2018) |

The tension between rows 3 and 4 is recorded as T4 in [[wiki/empirical-tensions.md]]: the same review both advances periodic conceptual coding and states that codes of this kind have no direct evidence.

---

## Mapping to the core framing

| Structural-code property | Latent-graph element |
|---|---|
| Position in a relational structure | `g` — position in the meta-graph |
| Content filling the structure | `x` — node content |
| Conjunction of the two | `p = f(g, x)` — content anchored to graph position |
| Periodic tiling / multi-scale grids | A hierarchy of resolutions over one space: coarse scales are the jumpy level for planning, fine scales the step level |
| Transfer of an abstract schema to a new domain | Reuse of `g` with a new `x` binding — instantiation as binding, not learning |

**(brainstorm)** A periodic code is attractive for path consistency for a mechanical reason: positions are updated by *adding* a displacement to a phase, and addition commutes, so any route accumulating the same total displacement lands on the same code. Path consistency would then be a property of the update rule rather than something a loss must enforce — which is the only concrete proposal the wiki has so far for gap G3.

---

## Abstraction as long-range predictability

The wiki's first *training signal* for abstraction, as opposed to an architectural stipulation of one ([[wiki/entities/h-jepa.md]]):

> A representation is abstract because it is what stays predictable at long range. Detail is discarded not to save capacity but because it cannot be predicted far ahead.

| Consequence | Statement |
|---|---|
| **Abstraction level = prediction horizon** | Low-level codes carry detail and predict a short way; high-level codes drop detail and predict far. The two are one axis, not two |
| **The level structure is emergent** | Stack predictors, pool over time between levels, and the hierarchy of abstraction falls out of the objective rather than being designed |
| **The trade-off is explicit** | Two criteria pull against each other: maximise the representation's information about its input, *and* make it predictable from the previous representation. Where the balance lands decides what is abstracted away |
| **Driving example** | Given wheel and pedal commands, a driver predicts the trajectory accurately for seconds; over an hour only the abstract route survives (arrival time, the path as drawn on a map), and alternative routes are a discrete latent |

**(brainstorm)** This is a candidate objective for gap G30, arriving from an unexpected direction. It does not directly reward path-consistency, but it does reward *content invariance* for a reason: content that varies unpredictably across instances of the same structure is exactly the content a long-horizon predictor is penalised for keeping. So `g` would be what survives a predictability filter, and `x` what the filter discards — measurable from trajectories alone, with no labels and no environment partition. What it still does not supply is commutativity: nothing in the criterion prefers a code that assigns the same value to a position reached by two different routes (gap G3).

**The counterweight.** What gets kept is decided *implicitly* by the encoder's and predictor's inductive biases, and the source concedes it does not know how to set them, offering only auxiliary prediction heads on task-relevant derived variables. So the objective selects *among* representations the architecture can express, which puts the burden back on the architecture lever (gap G16).

---

## Open problems

- **Is periodic coding general or spatial?** One neuroimaging report on abstract categorization (morphed birds, a neck × leg feature plane) is still the whole case for a *periodic* abstract code, now with the added detail that the same sixfold signal appears in ventromedial prefrontal cortex and that its strength correlates with task performance (Constantinescu et al. 2016, via Epstein et al. 2017). The nearest independent evidence is *not* periodic: a social power × affiliation space is coded as hippocampal angle plus posterior-cingulate magnitude, i.e. a vector, not a hexagonal tiling — so "maps outside space" is better supported than "grids outside space" ([[wiki/concepts/cognitive-map.md]]).
  - **The evidence base has since widened and its detector has been undercut in the same source.** Chen et al. 2022 add: grid-like fMRI modulation over a *discrete* social-hierarchy decision space (Park et al. 2021) and over angular positions of newly learned words in a "word space" (Viganò et al. 2021); grid-like coding of *gaze* in monkey entorhinal cortex with no locomotion (Killian et al. 2012); and grid, place and head-direction cells recorded in rat primary somatosensory and secondary visual cortex that survive whisker trimming and darkness (Long & Zhang 2021; Long et al. 2021a). Against that: grid identification is "a relatively arbitrary threshold phenomenon", spatial autocorrelation generates false positives without spike-shuffle controls, BOLD is not spiking, and **no single-unit grid code in a conceptual space has ever been recorded** ([[wiki/empirical-tensions.md]] T37, [[wiki/concepts/distributed-reference-frames.md]]). So the row above gets more instances and no better instrument.
  - **And what a grid code *is* has moved.** Grid firing is argued to support a learned topology of ordered experience rather than a rigid coordinate frame tied to physical measurement (Rueckemann et al. 2021, via Chen et al. 2022) — which is what makes the code portable to domains with no continuum, and which puts it on the topological side of [[wiki/empirical-tensions.md]] T27.
- **The metric may not be needed at all.** The hippocampal-entorhinal system also codes spaces defined only by transitions between discrete items, with no underlying continuum — which weakens the row above and reopens what "distance" means when the only data are observed transitions (Epstein et al. 2017).
- **Format vs. precision.** Core number keeps a ratio-limited *format* fixed for life while its precision improves from a Weber ratio of 2.0 to 1.15–1.3 (Spelke & Kinzler 2007). If structural codes work the same way, what a model must install is the format and what it must train is the resolution — nothing here says which parts of a grid code are which.
- **What supplies the metric?** Grid codes presuppose a space with a distance; the non-embeddable symbolic slice (modular arithmetic, syntactic recursion) offers none.
- **How is the structure discovered?** Nothing here says how the code arises for a *new* domain, which is the discovery half of LGD.
  - **One concrete proposal: don't discover it, reweight it.** Grid, band, border and object-vector cells are one family of **basis functions for transition statistics**, and which basis a network develops is set by the *transition distribution* it is trained on — dwell near boundaries and border cells appear, bias toward particular stimuli and object-vector cells appear, walk an unbiased 2D graph and grids and bands appear (Whittington et al. 2018, [[wiki/entities/tolman-eichenbaum-machine.md]]). A new domain would then need only an on-line reweighting of an already-learned basis set, inferred from observed transitions or from performance — inference over coefficients rather than gradient learning of a code. Untested: nothing in that paper actually performs the reweighting, and no procedure is given for guessing the initial structure.
- **Transfer mechanisms are unknown on both sides.** How humans or animals achieve far transfer of abstract structure is stated as an open question in neuroscience, and it is the one place the transfer channel currently has nothing to send.

---

## Connections

- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the dissenting use of the same code: grid firing is argued to be the wrong format for episodic binding, and a competitive-learning stage in dentate gyrus converts it into place-like conjunctions — with simulations showing untrained sparse projection is *not* enough, Hebbian training in the perforant path is required.

- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the biological candidate for `g`, the structural half of the factorized code, and the only concrete proposal for making it path-consistent.
- **[[wiki/concepts/simulation-based-planning.md]]** — the state-space decomposition claimed for grid codes is exactly what jumpy, multi-scale planning needs to plan over.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the hippocampal-entorhinal system is one anatomy: the sparse instance store and the structural code are neighbours, which is why binding content to position is cheap there.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — a *representation* being imported (state-space decomposition by periodic codes) rather than an algorithm, matching the pattern of every successful transfer so far.
- **[[wiki/concepts/meta-learning.md]]** — a content-invariant structural code is what would make the outer loop's learned regularity reusable in a domain with entirely new objects.
- **[[wiki/concepts/shortcut-learning.md]]** — a shortcut is a rule that reads content `x` where the intended rule reads structure `g`; a content-invariant code is the *architecture* lever that makes the structural rule the cheaper one to learn.
- **[[wiki/concepts/core-knowledge.md]]** — shows what `g` looks like when it is installed rather than trained: a code whose domain is fixed in advance is content-invariant by construction, at the cost of covering only its own domain. It also supplies the two sharpest behavioural measurements of the split — the number system's cross-modal comparisons, as accurate as within-modality, i.e. one code shared across `x` types; and the reorientation literature's dissociation of a content-blind geometric channel from an associative landmark-to-object channel (Spelke & Kinzler 2007).
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — a second candidate for `g`, learned rather than periodic: *spatial predictive encodings* that map one frame of reference onto another posture-dependently, acquired from multimodal correlation and localised to posterior parietal cortex. It is content-invariant by role rather than by geometry, and it carries no commutativity guarantee, so it answers the requirement grid codes answer for gap G3 less cleanly (Butz 2016).
- **[[wiki/concepts/event-segmentation.md]]** — an event schema is content-invariant in the same sense `g` is: "reaching to contact" is defined by a relative distance reaching zero, whatever object fills the slot.
- **[[wiki/concepts/compositionality.md]]** — a part-and-relation description is content-invariant by construction: the same relation vocabulary applies to pen strokes, wheels and ice floes, so compositional structure is one way of realising `g` without a metric embedding.
- **[[wiki/concepts/three-component-framework.md]]** — locates this page in the *architecture* slot and names what the other two slots lack: no objective function is maximized by a path-consistent `g` and no learning rule ascends toward one (gap G30).
- **[[wiki/entities/h-jepa.md]]** — supplies the first candidate objective for `g`: content that cannot be predicted at long range is penalized out of the representation, so abstraction becomes a consequence of a predictability/completeness trade-off rather than a design decision.
- **[[wiki/concepts/subgraph-matching.md]]** — the most degenerate `g` that still pays: a one-hot anchor marking *which node the embedding is about* is what lifts a message-passing encoder above the Weisfeiler-Lehman limit on `d`-regular graphs (Ying et al. 2020).
- **[[wiki/entities/maze-solving-transformers.md]]** — emergent metric structure with nothing metric supplied: embedding distance tracks lattice Manhattan distance at short range although every input token is orthogonal and adjacency order is randomised, and the lattice-wide geometry lands in the *weights* while per-instance connectivity can only live in activations (Ivanitskiy et al. 2023).
- **[[wiki/concepts/representation-probing.md]]** — makes this page's requirements measurable: content-invariance is a cross-position probe transfer test and path-consistency (gap G3) is a residual between codes decoded after distinct routes.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the other de-aliasing route in the same anatomy: `g` distinguishes repeated content by *position*, pattern separation distinguishes it by orthogonalizing the code itself, with no metric and no commutativity requirement.
- **[[wiki/concepts/cognitive-map.md]]** — supplies two further instances of grid-like coding outside physical space (hexadirectional entorhinal and ventromedial-prefrontal modulation over morphed-bird concept space; hippocampal angle / posterior-cingulate magnitude coding of a social power × affiliation space), and the matching negative: no anchoring analogue — no cell has been reported coding the boundary of a concept (Epstein et al. 2017).
- **[[wiki/concepts/path-integration.md]]** — turns this page's central speculation into a mechanism: `g` commutes because it is built by accumulating action displacements, so gap G3 is answered by the update rule — provided the domain's actions compose at all, a precondition this page did not state.
- **[[wiki/concepts/successor-representation.md]]** — an independent derivation of the same code: grid-like patterns as eigenvectors of a diffusion process over the state graph, with no periodicity or action algebra assumed, and eigenvalue reweighting as the knob that turns one basis into exploration, planning or replay.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the demonstration that `g` can be *learned* from next-observation prediction across an environment family, and reused across worlds by rebinding rather than retraining (Whittington et al. 2022); its 2018 precursor adds the two things this page most lacked — a mechanism for the multi-scale row above (frequency bands wired low→high so fine-scale statistics are reused across the whole space, keeping weight count independent of arena size) and a route to a `g` for a *new* domain (reweight learned transition-statistic bases rather than learn a code).
- **[[wiki/concepts/distributed-reference-frames.md]]** — answers this page's generality question with "replicated, not general": the same periodic primitive run separately in every cortical area over its own input space, which converts `g` from one code into many concurrent codes needing arbitration — and it supplies the false-positive caveat that qualifies every abstract-grid row here.
- **[[wiki/concepts/objective-identifiability.md]]** — removes one leg of this page's support: hexagonal codes in trained networks are produced by a centre–surround supervised target rather than by the structural task (grids appear in almost none of >11,000 path-integrating networks and vanish under heterogeneous place-cell-like readouts), so `g`'s periodicity rests on recordings plus attractor theory, not on emergence experiments.
