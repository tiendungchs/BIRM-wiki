# Visual Indices (FINSTs) — Reference Without Description

**Early vision assigns a pool of four to five *sticky pointers* to feature clusters. A pointer individuates an item and keeps referring to that same item across arbitrary changes in its properties and its location, while encoding none of them — it is a demonstrative (`that`), not a description. The consequences are architectural: a relation can be computed over individuals that have never been categorised, a newly detected property can be filed against *the very individual* it was detected on, and only indexed items enter any subsequent cognitive process at all.**

> **Provenance.** Pylyshyn 2001, *Visual indexes, preconceptual objects, and situated vision*, Cognition 80(1–2):127–158 (`raw/pylyshyn-2001-visual-indexes-preconceptual-objects.md`). A theoretical synthesis over the author's lab's experiments 1988–2001; no new data. FINST = **FIN**gers of **INST**antiation (Pylyshyn et al. 1978), a name the paper calls purely historical. **Conversion is `LOSSY`** — `pymupdf4llm` returned mojibake on this file's embedded fonts, so it was re-extracted with plain `pymupdf`: page markers, no heading structure, ligature corruption (`fi`/`ffi`). Every number below is one the prose states in words; the seven figures are unrecoverable and are described from their captions.

---

## The argument — why no description picks out an individual

Three empirical assumptions, each doing separate work:

| # | Assumption | Evidence cited | What fails without it |
|---|---|---|---|
| 1 | **A property is detected as a property of an *object***, not as a property present in the field | Object-based attention (Baylis & Driver 1993); object-file priming follows the moving box, not its location (Kahneman, Treisman & Gibbs 1992); inhibition of return is object-specific (Tipper et al. 1991); hemispatial neglect and Balint syndrome in object-centred frames | Nothing says where a newly detected feature should be filed |
| 2 | **Individuation is primitive and *precedes* property encoding** | Individuation has its own psychophysical limit, distinct from resolution (He, Cavanagh & Intriligator 1997); identical items are distinguishable and countable | Relational predicates have no arguments |
| 3 | **Representations are built incrementally** | Relations such as *inside* and *on the same contour* must be acquired serially (Ullman 1984; Tsotsos 1988); percepts assemble in stages | The correspondence problem below never arises — and it does arise |

**The correspondence problem, stated exactly.** On noticing a new property `Q`, what must be found in the current representation is *not* a representation of an individual with certain properties, but the representation of **the very individual** `Q` was detected on — and it must be found **independently of which properties have already been encoded**. Locating a prior representation by unique description requires a description that uniquely identifies it, which is the thing being sought; and the descriptions are partial, may be absent, and may have been invalidated (change blindness — Rensink et al. 1997; Simons & Levin 1997). The alternative is `Q(a)`, where `a` is delivered by a demonstrative rather than constructed by a search.

**The tagging argument — the sharpest line for the wiki.** Recognising `Collinear(X₁…Xₙ)`, `Inside(X₁,C₁)` or `Part-of(F₁,F₂)` requires binding scene elements to argument positions. The standard word for this in the perception literature is *tagging* or *marking* (Ullman 1984; Ballard et al. 1997; Watson & Humphreys 1997; Yantis 1998), and Pylyshyn's objection is that it is usually placed on the wrong object:

> It does no good to tag an internal representation since the relation we wish to encode holds in the world and may not yet be encoded in the representation.

A tag must be placeable on the *world* and must survive to be returned to. Figure 1's case is the load-bearing one: judging that six elements are collinear requires registering them as individuals **while ignoring every local property they have**, including while those properties change and the whole configuration moves.

---

## What an index is — the five theory assumptions

| # | Assumption | Consequence for a design |
|---|---|---|
| 1 | Early vision segments the field into **feature clusters** that tend to be reliable proximal counterparts of distal objects | The clusterer is upstream of, and not part of, the indexing mechanism |
| 2 | Recently activated clusters **compete for a pool of 4–5 indexes** | Capacity is a *pool of referring devices*, not a bandwidth or a store size |
| 3 | Assignment is **primarily stimulus-driven** — with one conceded cognitive route: scanning focal attention until an object that elicits an index is encountered | The concession is the whole of `T387`'s reconciliation (below) |
| 4 | An index stays bound to the same object **as its properties and location change** | Reference is maintained by *persistence*, not re-derived per frame |
| 5 | **Only indexed objects enter subsequent cognitive processes** — recognising their individual or relational properties, moving focal attention or gaze to them, making motor gestures to them | A hard architectural denial: unindexed content is unreadable by anything downstream |

Assumption 5 with assumption 3 is the two-stage architecture: **the stimulus proposes a small candidate set, and cognition may only bind among that set.**

**The reference is weaker than a name, by design.** It allows reference to a particular individual, but *ceases to exist when the referent leaves the field of view* — which is why the paper calls it a demonstrative rather than a name, and why it is not a memory mechanism.

---

## Evidence

| Paradigm | Result | What it rules out |
|---|---|---|
| **Subset search** (Burkell & Pylyshyn 1997) | 3–5 late-onset cues among 11 placeholders; whether RT×set-size behaves as feature or conjunction search is determined by **the cued subset alone**, not by the whole display — and **increasing the spatial dispersion of the cued items does not increase search time per item** | The subset is not found by scanning the display; access to indexed items is direct (pointer-like), even when the examination is serial |
| **Multiple object tracking** (Pylyshyn & Storm 1988; ~12 replications cited) | 4–5 independently, unpredictably moving targets among 8–24 **identical** items tracked for ~10 s at **>85%** correct | A simulation of the serial alternative (scan focal attention, store each location, return to the nearest) run on the *actual* trajectories switches targets often and scores far below the observed data, so tracking is not stored-location bookkeeping — and location is the only unique descriptor the items have |
| **Convex-hull probe** (Sears & Pylyshyn 2000; Intriligator & Cavanagh 1992; Awh & Pashler 2000) | Change detection inside the hull of the target set is no better than outside it | Zoom-lens / spread-of-attention accounts of the same capacity |
| **Occlusion-form manipulation** (Scholl & Pylyshyn 1999; Yantis 1998) | Targets that vanish and return by **deletion/accretion along a contour** (as behind an occluder) are tracked; the same targets that pop out of existence, or shrink to a point and regrow, at matched times and places are **not** | Objecthood is set by the *manner* of disappearance, not by spatiotemporal coincidence |
| **Property change during tracking** (Scholl, Pylyshyn & Franconeri 2001) | Colour and shape changes made behind an occluder are neither noticed nor reportable | Tracking reads properties |
| **Feature-space tracking** (Blaser, Pylyshyn & Holcombe 2000, *Nature* 408:196) | Two superimposed objects sharing one spatial locus are tracked as they move through **feature space** | The index is a location |
| **Attentional resolution** (He, Cavanagh & Intriligator 1997; Intriligator 1997) | Items can be resolved yet not individuated: at such spacings observers cannot count them or follow "move up one, right one, right one, down one…" | Individuation is discrimination |
| **Subitizing** (Trick & Pylyshyn 1994) | Squares **side by side** subitize; the *same* squares **concentrically nested** do not (no break in the RT×`n` function). Precuing item locations does not speed subitizing but does speed counting of larger sets | Subitizing is a fast count; it is reading off how many indexes are active, so it requires preattentive individuation as its entry condition |

---

## Implementation — one circuit, and what it deliberately does not use

A winner-take-all network over a spatiotopic map (Koch & Ullman 1985; applied to index theory in Acton 1993, Pylyshyn & Eagleson 1994): the most active region receives an enabling signal, which lets it be probed for specific properties. Two properties matter and both are `L3`:

- **The probe is routed using no encoded property of the target — not even its location.** Being probeable depends only on being instantaneously most active in a feature map. "What is the orientation of the red bar?" is answered by routing, not by tuning — the same conclusion [[wiki/concepts/visual-routines.md]] reaches from a bandwidth argument.
- **Stickiness is cheap.** Two candidate rules are offered: treat successive clusters as the same cluster if a majority of contributing points persist; or spread a cluster's activation to neighbouring elements, which biases the winner toward continuously moving clusters. Neither is fitted or tested.

---

## The four accounts of a pointer now in the wiki

| Account | Who sets it | What it holds | Capacity | Tied to gaze |
|---|---|---|---|---|
| **Visual index / FINST** (this page) | The stimulus (assumption 3) | **Nothing** — a bare reference | 4–5 | No |
| **Object file** (Kahneman, Treisman & Gibbs 1992) | Same event | Accumulated features, for later retrieval | ~4 | No |
| **Deictic code** ([[wiki/concepts/active-vision.md]], Ballard et al. 1997) | The current step of a top-down program | The one or two values that step needs | 2–3 | Usually yes |
| **Indexing operation** ([[wiki/concepts/visual-routines.md]], Ullman 1984) | An odd-man-out on a pre-computed property | Nothing — an anchor where a routine starts | not stated | No |

Pylyshyn accepts Kahneman's own reconciliation — a FINST is "the initial phase of a simple object file before any features have been attached to it" — so the difference between rows 1 and 2 is **what is being studied** (the referring mechanism vs. what eventually gets filed), not two mechanisms.

**Two corrections he makes to the deictic account**, both of which the wiki should carry:

1. *"Deictic code"* is a misnomer: it suggests the pointer **encodes** a property of the scene, where its entire function is to provide **access** to properties it does not hold.
2. A deictic reference **need not be a fixation**, and there must be **several at once** — Ullman's relational routines and MOT both require plural simultaneous reference, which a single fovea cannot supply.

---

## Grounding, and the inversion of object and place

**Concept grounding.** If everything is picked out by description, concepts relate only to concepts and the regress never bottoms out; sense-data grounding has been abandoned. Indexes bottom it out causally: one can have *demonstrative thoughts* — pick out one speck among countless identical specks — and, critically, **decide whether a description `D` is satisfied by a particular thing**, which requires an independent way of selecting the thing. The motor version is the crispest statement in the paper:

> your motor system cannot be commanded to reach for something that is red, only to reach for a particular individual object.

**Object primacy (the paper's own speculation, and it inverts a wiki default).** We normally take space-time as the matrix and objects as occupants of places. The evidence here supports the reverse: **objecthood is detected first, and location is recovered as a property *of* the detected object**, the way colour or shape is. Every spatial-code page in the wiki ([[wiki/concepts/vector-coding.md]], [[wiki/concepts/cognitive-map.md]], [[wiki/concepts/path-integration.md]]) assumes the standard order — a frame, then things in it.

**(brainstorm)** Taken seriously, this reverses the construction order of a grid parser: the primitive is not a cell with an address and a colour but an individual with an identity, whose row/column indices are two of the attributes a later probe can fetch. Under this order, "the same shape translated by (2,3)" is one individual with a changed location attribute and needs no correspondence search; under the standard order it is two cell-sets that must be matched. Nothing in the wiki builds the first kind.

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| A cluster winning an index | A **vertex created with empty content** — identity before attributes |
| The 4–5 pool | The maximum number of vertices simultaneously *addressable*, which bounds the arity of any relation computable in one step |
| Stickiness | Vertex identity maintained across observations **without re-matching**, so the correspondence problem is never solved — it is never posed |
| Property probe through an index | An attribute read that is *addressed*, not searched |
| Assumption 5 | An architectural denial: content that has no vertex is invisible to the traversal |
| Index lost when the referent leaves view | The graph has **no persistence layer** — this is a working parse, not a map |

---

## Consequences for open rows

- **`T387` (bottom-up vs top-down pointer assignment) — position A's primary source arrives and partly concedes.** Assignment is *primarily* stimulus-driven, with a cognitively mediated route conceded in the theory's own assumption 3, and assumption 5 states the two-stage structure the row recorded as "stated by neither". What does **not** concede is the format claim: the pointer holds no description at any stage.
- **`G39` (nothing anchors a retrieved structure).** Every mechanism on that row anchors by an `argmax` over a group. This one anchors by **persistence** — correspondence is never re-derived because the binding was never released. Cost: 4–5 items, and it dies when the referent leaves the field, so it buys anchoring by giving up the retrieval case entirely.
- **`G48` (content register vs attentional pointer).** The wiki's cleanest instance of the separation the row asks for: a FINST is a pointer *with no content register at all*, and the object-file literature is the same mechanism after content has been attached — so the two are dissociable by construction rather than by a decoding trick.
- **`G27` (discretisation)** and [[wiki/concepts/numerosity.md]]: the nested-vs-adjacent squares result is a criterion for when the subitizing regime is available — **preattentive individuability**, a property of the display, not of set size.
- **`G75` / `T151` / `T191` (the parse).** Objecthood is defined **operationally, by trackability**, and the paper says so: a sequence of locations is one object if early vision groups it that way. This is neither an architectural slot count nor a post-hoc read-out — it is a *criterion a designer cannot use*, because it presupposes the grouping mechanism being designed.

---

## Limitations

- **Nothing is implemented.** The theory is five assumptions plus a sketch of a WTA circuit borrowed from Koch & Ullman; no model in the paper is run, fitted or ablated.
- **What counts as an indexable object is conceded open** — "remains an open empirical question". The known facts are a list (simple figures yes; some well-defined feature clusters no; occlusion-form disappearance yes; shrink-and-regrow no), not a rule.
- **The preconceptual claim is defended partly on grounds of interest.** The author states he adopts it partly because "it is the alternative with the more far-reaching consequences and therefore the more interesting hypothesis to pursue" — and it is a claim about *format* (no encoding of properties is used), not about cost or task-independence: assignment does depend on objects having the right properties, and MOT is effortful.
- **"Preattentive" is explicitly withdrawn** in this paper. Tracking is attention-demanding; indexes may decay and need periodic reactivation. So the label carries less than the earlier literature's use of it.
- **Every MOT target set is *cued* by the experimenter** (flashing). The bottom-up finding is therefore partly built into the paradigm: no experiment here leaves the to-be-tracked set to the task, which is precisely `T387`'s `Closes when`.
- **The conceptual-penetration counter-evidence is left unresolved.** Eight-month-olds fail to track as individuals things they have seen poured from a beaker or disassembled and reassembled (Chiang & Wynn 2000; Carey & Xu 2001; Huntley-Fenner et al. 2001) despite identical visual properties. The paper's deflationary reply — recent *visual history* modulates a preconceptual mechanism, as occlusion form does — is offered as a possibility and is untested.
- **Cross-saccade survival is asserted on informal evidence**: that MOT works equally well with saccades free and prevented, plus object-specific priming across fixations (Henderson & Anes 1994). No experiment tracks indexes *through* a measured saccade.
- **The number 4–5 has no derivation**, here or anywhere in the wiki.

---

## Open problems

- **No machine architecture in the wiki holds a reference that survives the referent's properties changing.** Slot models re-infer slot contents each step, attention recomputes selection from the current query, and a segmentation map is re-derived per frame; none has a binding whose *identity* is the thing maintained. This is the mechanism `G39` and `G48` each ask for half of.
- **Nothing builds the clusterer** that assumption 1 hands the indexing mechanism — which is the same residue [[wiki/concepts/visual-routines.md]] leaves at its base representation and `T151` argues about.
- **Index decay and reactivation are named and unmodelled**, so nothing predicts how long an unattended binding lasts or what refreshes it ([[wiki/concepts/memory-read-and-erase.md]]).
- **Whether the index pool is contested *by task* is untested** — assumption 5 makes it the sole gateway to cognition, which predicts that two concurrent tasks needing different individuals should collide at exactly 4–5, and no experiment here runs that.
- **No benchmark reports how many individuals a solver had to hold at once.** ARC's transformations are relations over `n` objects; `n` is never reported, and the human capacity bound is a small integer that a solver with unbounded addressing does not face (`G17`, [[wiki/entities/arc-agi-3.md]]).

---

## Connections

- **[[wiki/concepts/visual-routines.md]]** — the operation set and the pointers it operates on, from the two sides: Ullman's *indexing* and *marking* need something for a mark to be placed on and something that survives the focus moving away, and this page is that thing specified independently, with a measured capacity and a stickiness criterion — while disagreeing with Ullman's *query-relativity*, since an index is assigned before any question is asked.
- **[[wiki/concepts/active-vision.md]]** — the same pointer with an effector attached and the disagreement the two authors state in print: Ballard's pointer is bound by the current step of a top-down program and holds the value that step needs, Pylyshyn's is seized by the stimulus and holds nothing, and Pylyshyn's reply is that "deictic code" misnames a mechanism whose function is access rather than encoding, and that reference must be plural and need not be a fixation (`T387`).
- **[[wiki/concepts/attention.md]]** — the dissection that page's object-based results assume: selection is decomposed into a preconceptual individuation stage and a subsequent access stage, which is why tracked items show no spread of facilitation into the region between them, and why "attention" and "individuation" come apart (items resolvable but not individuatable).
- **[[wiki/concepts/working-memory.md]]** — a store's contents versus its pointers, with the pointer isolated: a FINST holds no content at all, so the capacity limit here is a limit on *how many things can be referred to*, not on how much can be held, and the two limits happen to be the same small integer.
- **[[wiki/concepts/core-knowledge.md]]** — the mechanism under that page's object system: the 3–4 trackable entities and the cohesion/continuity entry conditions are read here as the assignment and stickiness rules of an index pool, with the infant numerosity results (Leslie et al. 1998) as index assignment operating before any property is encoded — and Chiang & Wynn 2000 as the unresolved case where prior knowledge appears to decide what counts as an individual.
- **[[wiki/concepts/numerosity.md]]** — the subitizing regime's entry condition, measured: items must be *preattentively individuable* (nested squares fail where the same squares side by side succeed), so the small-`n` mechanism is "count the active indexes" rather than a fast version of counting, which is the criterion `G27` records as missing between the regimes.
- **[[wiki/concepts/relational-bottleneck.md]]** — the rival reading of the same ~4 limit: interference among simultaneous bindings there, a fixed pool of referring devices here, and this page adds the discriminating detail that the limit applies to *referring* even when nothing is bound to the referent.
- **[[wiki/concepts/priority-map.md]]** — the winner-take-all stage read as an index-assignment mechanism rather than as a saccade selector: the map's argmax enables a probe to a location whose properties are never encoded, so the same circuit serves selection-for-action and reference-without-description.
- **[[wiki/concepts/memory-read-and-erase.md]]** — an address with no content behind it: marking a location is the write, losing the index when the referent leaves view is a `clear` triggered by the world rather than by the controller, and index decay is the unmodelled half of that protocol.
- **[[wiki/concepts/node-definition-problem.md]]** — the node question answered operationally and therefore circularly: a unit is whatever early vision can track as one thing, which is a criterion a designer cannot apply because it names the mechanism being designed.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the opposite trade on the same job: a VSA binds role to filler by spending representational dimensions and can hold many bindings at once, where an index binds by maintained causal contact and spends nothing on the code — at four or five items, and with no way to bind two indexes to each other.
- **[[wiki/entities/spelkenet.md]]** — the same object question with the answer computed instead of maintained: a counterfactual probe re-derives an objectness map per input, where an index is assigned once and *persists* through exactly the property changes that would break a re-derived segmentation.
- **[[wiki/concepts/latent-graph-discovery.md]]** — vertices created before they have attributes: the index supplies node identity with empty content, so a relation can be evaluated over individuals that have never been described, and the correspondence problem across successive observations is dissolved rather than solved.
- **[[wiki/concepts/incremental-grouping.md]]** — the other half of what a relational predicate needs, and the sharper contrast in the wiki: an index individuates without describing and persists across change, where a spreading grouping tag establishes *sameness* over locations without individuating anything and dies with the cue — so `Collinear(X₁…Xₙ)` needs the indices and "are these two marks one object?" needs the flood, and nothing here binds one mechanism to the other.
