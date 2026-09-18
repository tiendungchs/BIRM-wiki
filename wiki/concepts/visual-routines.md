# Visual Routines — the Parse as a Program Assembled Per Task, Not a Setting Chosen at Design Time

**Abstract shape properties and spatial relations are not detected; they are *computed*, by a procedure assembled on demand from a small fixed instruction set (shift of processing focus, indexing, bounded activation, boundary tracing, marking) and run over a bottom-up base representation. The instruction set is fixed and universal; the program is not — it is selected or compiled per goal, and its intermediate results are written to a second, task-dependent store. This is the wiki's only account in which "how to parse the input" ranges over an *open space* (compositions of operations) rather than a menu of parses.**

> **Provenance.** Ullman 1984, *Visual routines*, Cognition 18(1–3):97–159 (`raw/ullman-1984-visual-routines.md`), MIT AI Lab. A computational-theory paper: no new experiments, arguing from task analysis plus the psychophysics and monkey physiology available in 1983. **Conversion is `LOSSY`** — an OCR scan run through `pdf2md`, with visible character corruption; every number below is one the surrounding prose repeats or that is stated in the paper's own summary, and the figures are unrecoverable. Equations: there are none of consequence.

---

## The two-stage split, and the second store nobody builds

| Stage | Produced by | Properties | Wiki page |
|---|---|---|---|
| **Base representation** (primal sketch, 2½-D sketch) | Bottom-up early vision | *Unarticulated* (local descriptions — depth, orientation, colour, motion at a point), viewer-centred, spatially uniform, determined by the input alone: same image twice ⇒ identical representation | [[wiki/entities/early-visual-system.md]] |
| **Visual routines** | A routine processor, top-down but **object-knowledge-free** | Applied only to selected locations, not uniformly; what is made explicit depends on the goal, not the input | this page |
| **Incremental representation** | The routines, as a side effect | Same input + different goal ⇒ *different* contents; retained and reused by later routines | **no wiki architecture has one** |

**The incremental representation is the underrated half.** A routine is not a predicate returning yes/no: running it *writes* structure — a coloured region, a marked location, a traced contour — which later routines read. Two behavioural consequences Ullman uses as its signature: a second inside/outside query on an already-coloured figure should be faster and less sensitive to the figure's complexity than the first; and under instructions to attend to one of two overlapping figures, only the attended one is later recognisable (Rock & Gutman 1981) although the base representation treated both identically.

**(brainstorm)** In transformer terms, the base representation is the token embedding and the incremental representation is a scratchpad that *persists across queries about the same input and is keyed by what was asked*. Every architecture in the wiki has the first and none has the second: a KV cache is not it (it is input-determined, not goal-determined), and a chain-of-thought trace is not it either (it is in the output language, not in the perceptual format the next routine reads). [[wiki/concepts/working-memory.md]]'s stores are addressed by content or by slot; this one is addressed by *location in the base representation* and holds partial parses.

---

## Why a detector cannot do the job — the support argument

A shape property `P` picks out a set `S` of shapes. Recognising `P` by template matching requires storing `S`. The obstruction is not `|S|` but the size of `S`'s **support** — how much of a figure must be inspected to decide membership:

| Property | Support | Verdict |
|---|---|---|
| "contains the marked point `X`" | one point | template matching is fine |
| closure; inside/outside | unbounded — any part of the curve can matter | template matching impossible; the set must have *regularities* a procedure can exploit |

An "abstract" property is then defined exactly: prohibitively large support, nevertheless computable efficiently because the set is compressible (the paper cites Kolmogorov 1968 — a random `S` has no shorter program than itself). Three requirements follow and they are the argument for routines rather than for more detectors:

1. **Abstractness** — no feature-detector hierarchy yields an inside/outside detector.
2. **Open-endedness** — the system must handle relations *specified verbally and never before computed* ("do the green and red elements lie on the same side of the vertical line?"), so it must be able to build new procedures, not select among stored ones.
3. **Complexity/sharing** — operations as expensive as bounded activation cannot be replicated per relation or per location, so routines must share machinery — which is what *forces* sequencing and a mechanism for choosing where each operation is applied.

---

## The worked case: inside/outside

| Method | How | Why it is not what humans do |
|---|---|---|
| **Ray intersection** (Evans 1968; Winston 1977) | Cast a ray from the point, count crossings, odd ⇒ inside | Requires the curve to be *closed* and *isolated*; breaks on nested curves; and the variants humans find trivial are the ones it cannot do at all — "do any of these dots lie inside `C`", "do these two dots lie inside the *same* curve", "find a point inside all three curves" |
| **Colouring / bounded activation** | Activate outward from a point, do not cross boundaries; test whether an "infinity point" got activated | Much better — it explains why most of a curve can be ignored when the activation *leaks out* of a corridor and reaches infinity, which is the cheap case humans exhibit. **But it predicts computation time rising with figure size, and human in/out judgement is close to scale-independent** (a slight RT increase with size, under investigation at the time). The paper leaves this unresolved |

**The failure is the useful part.** Both candidate algorithms are *specified enough to be refuted by a reaction-time curve* — which is a standard no architecture in the wiki meets: no wiki model of grid-relation extraction predicts how its own cost should scale with the size of the configuration, so none can be falsified this way. Also note which strategy is right depends on the stimulus (start at the `X`, or start at infinity and trace), so **even a single relation needs a selection step before the routine runs** — the paper's *assembly problem*.

---

## The elemental operations — a proposed instruction set

Explicitly *not* a comprehensive list; chosen for usefulness plus partial empirical support.

| Operation | What it does | Evidence / cost | Wiki counterpart |
|---|---|---|---|
| **Shift of processing focus** | Apply the same operation at a different location; a *family* of operations, not one | Cued detection at 7° eccentricity gains ~30 ms (Posner et al. 1978); peripheral-cue facilitation saturates at the shift duration and the saturation point grows ~8 ms per degree of visual angle (Tsal 1983); identification cost ~100 ms at 3° (Eriksen & Schultz 1977) | [[wiki/concepts/attention.md]], [[wiki/concepts/priority-map.md]] |
| **Indexing** | Shift *to an odd-man-out*: locations that differ from their surround in one pre-computed property, used as anchors where a routine starts | Constant-time pop-out for colour and simple shape up to ~30 distractors; **conjunctions are not indexable** — detection time grows linearly (Treisman & Gelade 1980). Julesz's textons (colour, oriented blobs of given size/aspect, and their terminators) are the same list from texture | the selection stage of [[wiki/concepts/priority-map.md]] |
| **Bounded activation ("colouring")** | Spread activation over a surface from a point or contour, stopped by discontinuity boundaries; defines a *region* as a unit in an unarticulated representation | Must cope with fragmented boundaries (a dashed curve still blocks it, at a cost of ~20 ms against a mean RT of ~540 ms, Varanese 1983) and must sometimes cross *internal* boundaries — so "boundary" may be defined differently per routine | none |
| **Boundary tracing / contour activation** | Follow a contour, or activate many contours in parallel; supplies a *sameness* operator ("are these two marks on the same curve?") | RT grows roughly **linearly with separation along the curve**, ~24 ms per degree, at 250 ms presentation so not eye movements; fastest condition ~750 ms total. Subjects report the answer was "simply seen" and deny scanning (Jolicoeur, Ullman & Mackay 1984) | none; the closest is [[wiki/concepts/subgraph-matching.md]]'s connectivity queries |
| **Marking** | Remember a location so processing can return to it; multiple markers give counting and closure tests | Closure = mark the start, trace, test for return. Counting = index the strongest signal, switch it off, repeat. Marking must survive eye movements to be useful, and its *spatial resolution* is the proposed cause of crowding (the `N` in `TNT` is unreadable at an eccentricity where an isolated `N` is not) | [[wiki/concepts/memory-read-and-erase.md]]'s address side |

**The instruction set is the answer to open-endedness and the reason sequencing exists.** Different relations share operations; shared hardware cannot be run everywhere at once; therefore the locations and the order must be controlled. That control requirement — not a capacity limit — is where the paper puts attention.

---

## Essential vs non-essential sequentiality — the claim with teeth

Two operations that *could* run in parallel may be run in sequence (non-essential: total work unchanged). **Essential** sequentiality is when parallelism is impossible or wasteful by the nature of the task, and the paper's warrant is a theorem rather than an RT curve: Minsky & Papert (1969) prove that inside/outside — and connectedness — **cannot be computed at all by any diameter-limited or order-limited perceptron**, i.e. by any fixed-depth reader each of whose units sees a bounded region or a bounded number of inputs, however many units there are.

The standard account of serial vision (Kahneman 1973; Rumelhart 1970) makes sequentiality a *capacity limit* — a spotlight to avoid overload. Ullman's inversion: it is a **property of the computation**, so it does not go away with more hardware, and it requires machinery for concatenating and controlling operation sequences that a capacity story does not.

**What this costs the wiki's architectures.** Every fixed-depth feedforward or fixed-layer attention stack falls inside the class the theorem constrains, in the relevant sense (bounded receptive fields, bounded fan-in per unit, no data-dependent iteration). The prediction is specific and testable on existing benchmarks: *connectivity* and *containment* predicates in clutter should fail in a way that scale does not fix, while local predicates (colour, count of isolated items) scale normally. That is precisely the profile BlindTest reports — path tracing and row/column counting floored while frontier models handle everything with bounded support (`T215`, queued at `raw/rahmanzadehgervi-2024-vision-language-models-are-blind.md`). It is also the sharpest theoretical version of [[wiki/concepts/adaptive-computation-time.md]]'s empirical point and of the argument in [[wiki/concepts/circuit-size-separation.md]], one class further down: there the separation is `Ω(n)` *units*; here it is not a size separation at all but an impossibility for the whole order-limited class.

Not all of a routine is serial: bounded activation is itself massively spatially parallel, and the paper notes that solving inside/outside *tactually* — a fingertip over a relief — is far harder precisely because the parallel step is unavailable.

---

## Indexing, and a binding mechanism derived from a read-out constraint

The proposed circuit (the paper's Fig. 7) is worth stating because it derives selection from *communication bandwidth* rather than from capacity:

1. Local detectors compute a small set of properties `P₁…P₃` everywhere.
2. Local **comparisons** generate difference signals — a location is indexable if it differs from its *surround*, which also predicts that a *local* odd-man-out (one green item ringed by red in a field of equal green and red) is indexable while a global count is irrelevant.
3. The strongest difference signal inhibits the others, so only the winning location's properties are mapped into a **central common representation** that later stages can read.

The conjunction result then follows without a capacity assumption: the central processor is computationally powerful, so if the signals reaching it supported conjunction search it would use them; since it does not, **the channel from local detectors to the centre is narrow by construction**. And the answer to "what is the orientation of the red bar?" is obtained *with no red-vertical-bar detector anywhere* — the question is answered by routing, not by tuning.

**(brainstorm)** This is a binding mechanism built from a bottleneck rather than from synchrony or from a tensor product ([[wiki/concepts/tensor-product-representation.md]]): one location's feature vector at a time is admitted to a shared register, so conjunctions are available *serially and only serially*. It makes Treisman's illusory conjunctions a prediction of the wiring rather than an anomaly, and it is the same architecture as [[wiki/concepts/priority-map.md]]'s two-stage similarity-then-argmax with the argmax's output re-read as a *gate on the read-out channel* rather than as a saccade command.

---

## Counting: the argument against a dedicated primitive

Minsky & Papert's perceptron-style networks *can* compute "exactly `M` items" in parallel, so a dedicated subitizing detector is possible in principle. Ullman argues against it on economy: counting by **index → mark (switch off) → re-index** reuses operations that exist for other reasons, whereas a counting network is dedicated hardware for a task not important enough to justify it. Two distinguishing predictions: counting-by-routine is decomposable into a sequence *even at `n = 1`* (single-point detection is the first step of the loop), and its accuracy should be limited by the **spatial resolution of marking** — which is why eye movements help counting on large (2°) displays and hurt on small ones (Kowler & Steinman 1979), if marking is sharpest near fixation and degrades across saccades.

**This is a live disagreement with the wiki's own numerosity page.** [[wiki/concepts/numerosity.md]] reports number neurons peak-tuned to a preferred cardinality, invariant across modality and across simultaneous vs sequential presentation (Nieder 2016) — i.e. exactly the dedicated detector Ullman calls implausible, found. The reconciliation the two sources jointly support, and which neither states: the tuned code is the *estimation* system (large `n`, Weber-scaled, approximate) and the routine is the *subitizing* system (small `n`, exact, serial, marking-limited) — which is the two-regime structure `G27` records with no criterion selecting between them, now with a candidate criterion (whether the answer must be exact, hence whether individuals must be marked one at a time).

---

## Selection, assembly, compilation — the four problems left open

The paper's own list, and the wiki's status on each:

| Problem | Ullman's statement | Wiki status |
|---|---|---|
| **Elemental operations** | Which operations form the instruction set | Partly supplied (five candidates); no machine architecture implements the set |
| **Integration** | How operations combine into a routine; which can run concurrently | Untouched anywhere |
| **Control** | What triggers a routine and fixes execution order | The *initial access problem*: before anything is recognised, which routine runs? Proposed answer: **universal routines** applied to any scene to get enough structure to index into recognition memory, which then selects specialised routines. Evidence: with no instruction, only the *bounding contour* of a figure is reliably available for later comparison even after 5 s of viewing (Rock et al. 1972) — so the default parse is a specific, narrow one, not a full description |
| **Compilation** | How new routines are generated, stored, and improved with practice | Proposal: store routines **skeletonised**, let the assembly mechanism fill in details; practice moves work from assembly time to retrieval time. This is [[wiki/concepts/program-induction.md]]'s library problem stated for perception, and [[wiki/concepts/amortized-inference.md]]'s cache stated for a parser |

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| Base representation | The observation stream, before any node exists |
| Elemental operations | The *vocabulary of the framing language* — not the vocabulary of the answer |
| A routine | A program in that language, chosen per query; the parse is its by-product, not its input |
| Incremental representation | The partial graph built so far, keyed to the query that built it |
| Marking map + incremental representation | "Where" and "what" held separately, so a scene is a set of pointers plus summaries rather than a panoramic image — no full state ever exists |
| Indexing | Where traversal starts when nothing is known: the anchor is chosen by local surprise, not by content |

**The consequence for `G75`.** The wiki has been asking *which parse* a model should choose, from a menu ([[wiki/entities/arc-vsa-solver.md]]'s six hypotheses) or by post-hoc read-out ([[wiki/entities/spelkenet.md]]). Ullman's claim is stronger and re-poses the row: **there is no parse independent of the question**, so a fixed menu of parses is a degenerate compilation — six pre-compiled routines where the space is all compositions of the operation set. What `G75` asks for ("chooses its decomposition from an open space") gets, for the first time, a specification of what the space is *made of*.

---

## Limitations

- **No implementation.** Nothing in the paper is run. The operations are proposed on usefulness plus scattered psychophysics; the assembly mechanism, which is the part the wiki needs most, is four paragraphs of desiderata.
- **The scale-independence failure is unresolved** (above), and it is the one place the paper's own preferred mechanism is contradicted by the data it cites.
- **The base/routine boundary is asserted, not measured.** Ullman argues that collinear arrangements of tokens are found by a *tracing routine* rather than made explicit by early grouping (against Marr 1976), while conceding grouping processes do exist in the base representation. Which grouping lives where is left open — the question `T151` asks in machine form, and the one Mollard, Bohte & Roelfsema answer with a *learned* criterion inside a recurrent early-visual circuit (queued at `raw/mollard-2026-multiscale-incremental-grouping.md`).
- **Physiology of 1983.** The shift-related evidence (superior colliculus, area 7, frontal eye fields, inferotemporal TE) is catalogued honestly and mostly rejected as *saccade*-related rather than routine-related; the pulvinar is nominated as the only plausible task-independent "shift controller" on connectivity grounds alone. Treat as `L4`.
- **Eye movements are excluded rather than modelled.** The tracing and indexing results are all obtained under presentations too brief for saccades, so the account is of *internal* shifts; how routines schedule actual fixations is the deictic question, not this one (queued at `raw/ballard-1997-deictic-codes-for-embodiment-of-cognition.md`).

---

## Open problems

- **Nothing assembles a routine.** The assembly problem is unsolved in 1984 and unsolved in the wiki: no architecture here compiles a per-task procedure over its input from an operation set. `G75`, `G73`.
- **No architecture has an incremental representation** — a goal-dependent, spatially addressed store of partial parses that survives to the next query on the same input.
- **The operation set has never been implemented as a differentiable or learnable module bank**, so "is this set sufficient?" has never been tested on any benchmark. The cheapest test available: score the five operations against the seven BlindTest tasks and against ARC's grid operations, and report which grid predicates are *not* expressible (`T215`, `G17`).
- **Where the boundary between base and routine falls** is unmeasured, and the two sides have opposite implications for whether a perceptual front end can be frozen.
- **Nothing prices a routine.** The paper's currency is operations and milliseconds per degree; every wiki architecture's currency is parameters and passes, and no ARC result in the wiki reports a per-task *operation count* that could be compared to a human RT curve.

---

## Connections

- **[[wiki/concepts/problem-framing.md]]** — supplies the only mechanism-level account of the framing stage this page's parent gap says nothing constructs: framing is a program in a fixed operation language, assembled per goal, so "constructing a representation" becomes "compiling a routine" and inherits a compilation/caching story rather than remaining a primitive.
- **[[wiki/concepts/attention.md]]** — the same object under the rival explanation: attention here is *not* a capacity-limited spotlight but the sequencing and location-selection machinery that shared elemental operations force, so the serial order is essential (a theorem about the task) rather than protective (a limit of the hardware).
- **[[wiki/concepts/priority-map.md]]** — the indexing operation measured 30 years later and at the right grain: local comparison → difference signal → winner inhibits the rest → the winner's properties reach a central register is the similarity-then-argmax decomposition, with the argmax re-read as a gate on a narrow read-out channel rather than as a saccade target.
- **[[wiki/entities/early-visual-system.md]]** — the base representation this page's routines run *on*, and the source of the indexable-property list (orientation, colour, motion, disparity, terminators) that decides where a routine is allowed to start.
- **[[wiki/concepts/numerosity.md]]** — the direct rival account of small-`n` number perception: this page derives subitizing from index-and-mark and argues a dedicated counting network is not worth building, where the tuned number code is exactly such a network measured; jointly they suggest the exact/small and approximate/large regimes are different mechanisms rather than one code at two grains.
- **[[wiki/concepts/circuit-size-separation.md]]** — the same proof technique one class harder: a size separation says a function costs `Ω(n)` units of the weaker type, Minsky & Papert's inside/outside result says connectivity predicates are *unavailable* to the whole diameter- and order-limited class however many units it has.
- **[[wiki/concepts/adaptive-computation-time.md]]** — the machine form of essential sequentiality: a learned, input-dependent step count is what an order-limited reader needs to escape the class, and tracing's `24 ms` per degree is what its ponder curve should look like if the routine is the one biology runs.
- **[[wiki/concepts/program-induction.md]]** — the same architecture with the program pointed at perception instead of at output: a fixed primitive set, per-task composition, and a library that caches skeletons — so `G4`'s "who writes the library" question applies verbatim to the elemental operations.
- **[[wiki/concepts/amortized-inference.md]]** — the compilation half of this page: routines stored skeletonised and expanded by an assembler is a cache over a search, with practice moving cost from assembly time to retrieval time.
- **[[wiki/entities/arc-vsa-solver.md]]** — recast by this page as a *degenerate compilation*: six ranked object hypotheses are six pre-compiled routines over a space whose generators (shift, index, colour, trace, mark) this page names, which is why enlarging the menu is the wrong repair.
- **[[wiki/entities/spelkenet.md]]** — the opposite commitment on the same question: objectness computed once per input by a counterfactual probe, where this page computes a region only when a routine needs one and keeps it only in the incremental representation, so "what the objects are" is query-relative rather than scene-relative.
- **[[wiki/concepts/subgraph-matching.md]]** — boundary tracing is the perceptual form of a connectivity query, and it comes with the cost curve the graph-matching literature reports in operations: linear in path length along the curve, not in the number of distractor paths, if activation spreads in parallel.
- **[[wiki/concepts/working-memory.md]]** — names the store this page needs and does not have: the incremental representation is goal-dependent, spatially addressed and holds *partial* structure, where every store on that page is content- or slot-addressed and holds completed items.
- **[[wiki/concepts/memory-read-and-erase.md]]** — marking is the address half of that protocol implemented in a spatial frame, and the counting routine is its erase half at its cheapest: "switch off the element under the focus" is a `clear` addressed by current location rather than by content.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the operation set is a candidate vocabulary for the *framing* language rather than for the graph: nodes are created by running an operation (a coloured region, a marked point), so the vertex set is an output of traversal instead of its precondition.
- **[[wiki/concepts/node-definition-problem.md]]** — the same problem with the answer refused: rather than choosing a granularity for the units, the units are whatever the current routine's bounded activation encloses, so the choice is deferred to query time and paid for per query.
- **[[wiki/entities/dorsal-visual-stream.md]]** — where the operations would have to live: spatial relations, tracing and marking are the parieto-prefrontal pathway's traffic, and this page is the computational job description that pathway's anatomy has never been given.
- **[[wiki/concepts/mental-imagery.md]]** — the complementary use of the same substrate: imagery drives the base representation top-down from memory, where a routine leaves task-dependent structure on it without changing what it depicts — two distinct ways the same sheet carries something other than the current retinal input.
- **[[wiki/concepts/compositionality.md]]** — compositionality asserted of *procedures* rather than of representations: the reuse claim is that routines share elemental operations, which is what makes the set small, and the cost is that shared hardware cannot be run at two places at once.
