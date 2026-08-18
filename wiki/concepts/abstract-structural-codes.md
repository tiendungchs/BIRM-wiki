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

- **Is periodic coding general or spatial?** One neuroimaging report on abstract categorization is the whole case for generality.
- **Format vs. precision.** Core number keeps a ratio-limited *format* fixed for life while its precision improves from a Weber ratio of 2.0 to 1.15–1.3 (Spelke & Kinzler 2007). If structural codes work the same way, what a model must install is the format and what it must train is the resolution — nothing here says which parts of a grid code are which.
- **What supplies the metric?** Grid codes presuppose a space with a distance; the non-embeddable symbolic slice (modular arithmetic, syntactic recursion) offers none.
- **How is the structure discovered?** Nothing here says how the code arises for a *new* domain, which is the discovery half of LGD.
- **Transfer mechanisms are unknown on both sides.** How humans or animals achieve far transfer of abstract structure is stated as an open question in neuroscience, and it is the one place the transfer channel currently has nothing to send.

---

## Connections

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
