# Engram — the Physical Memory Trace

**A memory is stored as a *sparse subset of neurons*, tagged at encoding, whose reactivation is both necessary and sufficient for recall — and whose *overlap* with other such subsets is the substrate of the relation between memories. The trace is a set, not a location; the edge between two traces is the intersection of two sets.**

> **Provenance.** `raw/talk-nd-memory-engram.txt` — an unattributed science-communication video transcript reviewing the engram literature (Semon's coinage; IEG-based tag-and-manipulate; excitability-based allocation; the brain-wide engram complex, attributed to a 2022 *Nature Communications* paper using tissue clearing; co-retrieval linking). **No primary paper was read and no authors, sample sizes or statistics are available, so every empirical number on this page is marked (tentative)** unless it is independently carried by a page-cited source. Where the same claim is sourced to a read paper — Lisman et al. 2018, de Sousa et al. 2026 — that page is [[wiki/concepts/memory-allocation-excitability.md]] and it, not this one, is authoritative.

[[wiki/concepts/memory-allocation-excitability.md]] covers **which cells** get written and why. This page covers what the resulting object *is*: its size, its distribution, its causal status, and — the part that matters most to the core framing — the two ways two of these objects get glued together.

---

## The operational definition: tag-and-manipulate

The construct became testable only when "lasting physical change" (Semon, ~1904) was replaced by a procedure:

| Step | Implementation | What it buys |
|---|---|---|
| **Tag** | Immediate-early gene (IEG) promoter (*Fos*, *Arc*) drives a reporter/effector transgene, so neurons that ran the plasticity program during a window express it | Identifies the write set *post hoc* — an addressable handle on a specific memory |
| **Gate the window** | The cassette is drug-dependent (e.g. tamoxifen-gated TRAP2), off outside a chosen few hours | Without this the label integrates over weeks of home-cage memories and no single trace is isolable |
| **Read out** | Fluorescence under the microscope; or, brain-wide, tissue clearing + whole-brain imaging | Turns "was this cell part of the memory" into a count |
| **Manipulate** | Same handle drives an opsin/DREADD or a cell-death gene | Converts correlation into a necessity/sufficiency test |

The behavioural assay is **fear conditioning** — a neutral conditional stimulus (tone, spatial context, taste) paired with an aversive unconditional stimulus (foot shock); freezing on the next day scores retrieval. Nothing about the paradigm requires aversiveness: the same results are reported for reward pairing **(tentative)**, which is what licenses reading the mechanism as *associative memory* rather than as *fear*.

**(brainstorm) The methodological point is transferable and underrated: the write set is made addressable independently of the content written.** No memory-augmented network in the wiki exposes "the set of parameters/slots this episode touched" as an object you can later index, silence, or intersect. Every result below is downstream of that one affordance, and it is free to implement — a per-episode write mask kept alongside the store.

---

## Necessary *and* sufficient — the reason "engram" is not just a correlate

| Manipulation | Result **(tentative)** | Control that makes it load-bearing |
|---|---|---|
| Same conditional stimulus at test | The tagged population reactivates | — |
| Silence or ablate the tagged cells at test | No freezing to the conditional stimulus | Other memories recall normally → not a general behavioural deficit |
| Silence an equal number of *untagged* cells | Freezing intact | → the effect is about *which* cells, not how many |
| Activate the tagged cells with no sensory cue | Freezing appears | Sufficiency — recall is inducible from the substrate alone |

This is the strongest causal statement about a memory substrate in the wiki: a *named, enumerable set of units* whose activity is the memory. Compare the wiki's model-side stores, where the claim "this is where the memory is" is never testable by deletion because the content is smeared over all weights ([[wiki/entities/hopfield-network.md]]) — the engram literature's methodology is precisely a fix for that, and the fix is sparsity plus a write mask.

---

## Sparsity is a set-point, not a function of the content

| Region | Fraction of eligible neurons allocated **(tentative)** |
|---|---|
| Lateral amygdala | 10–20% |
| Dentate gyrus (hippocampus) | 2–6% |

The counter-intuitive result: **within a region the fraction is conserved across memories.** Raising shock intensity does not enlarge the engram; switching valence from fear to reward does not enlarge it **(tentative)**. Salience, vividness and content move *nothing* about the size of the write.

| Reading | Consequence for a builder |
|---|---|
| The circuit holds a **fixed write budget per episode**, region-specific | Write size is a circuit parameter, not a function of input statistics — the opposite of every attention-based store, where the number of slots touched scales with how much the input matches |
| The budget is defended by **competition**, not by a threshold | Blocking inhibitory interneurons **enlarges** the engram **(tentative)** — so the mechanism is feedback inhibition (the most excitable principal cells recruit interneurons that suppress their neighbours), i.e. a soft `k`-winner-take-all whose `k` is set by the inhibitory gain ([[wiki/concepts/inhibitory-control-of-coding.md]]) |
| The two numbers differ 3–5× across regions | There is no single optimal sparsity; each store is tuned to its own job (de-aliasing in DG, valence binding in LA) |

**The conservation is in tension with every capacity-derived sparsity in the wiki**, all of which make the optimum a function of load or statistics — `p = (2MT)^(−1/3)`, falling as the store fills ([[wiki/entities/sparse-distributed-memory.md]]); `f* ∝ λ`, tracking the recurrence rate of what is being stored ([[wiki/concepts/recall-gated-consolidation.md]]); `a` as a per-context control variable ([[wiki/entities/context-modular-memory-network.md]]). Biology appears to run an open-loop constant ([[wiki/empirical-tensions.md]] T84).

---

## The engram is brain-wide: an engram *complex*

Whole-brain tagging under tissue clearing reports a single fear memory distributed over a wide set of regions — hippocampus and amygdala as expected, but also thalamus, hypothalamus and brainstem **(tentative)**. The working interpretation is a **complex**: one memory = many region-local sparse ensembles, each holding a different *aspect* (amygdala: valence; hippocampus: spatial context; cortex: sensory particulars), with no region holding the whole.

**(brainstorm) This makes an episode a *tuple of codes in different spaces*, not a vector in one.** Two consequences the wiki's stores do not handle: (i) retrieval is a **joint** operation over component stores, so partial cueing is naturally cross-modal — a valence cue can complete a context; (ii) the binding is carried by nothing but *co-allocation in time*, which is exactly the excitability window, so [[wiki/concepts/memory-allocation-excitability.md]]'s tag is doing double duty as the **cross-region binder** and not only as the within-region allocator. The machine form is a multi-module write in which each module runs its own sparse allocator and the only shared variable is the write window — cheap, and it removes the need for a central episode buffer. Untested: whether the component engrams are independently silenceable with dissociable behavioural loss (the aspect decomposition is an interpretation, not a measurement).

---

## Two memories are linked by *sharing neurons* — and there are two ways to arrange that

The load-bearing idea for this wiki: **a relation between memories is stored as the overlap of their engrams**, and that overlap is a separable, silenceable object.

| | **Allocate-to-link** (encoding time) | **Co-retrieval linking** (retrieval time) |
|---|---|---|
| Trigger | Two encodings fall inside one excitability window (< ~6 h) | Two *already-stored, non-overlapping* engrams are repeatedly reactivated together |
| Demonstration **(tentative)** | Two tone–shock memories 6 h apart share cells; extinguishing tone A also reduces freezing to tone B. At 24 h apart, engrams are near-disjoint and extinction is memory-specific | Taste aversion (saccharin→sickness) and auditory fear (tone→shock) trained **4 days** apart; then saccharin + tone presented together repeatedly → mice freeze **to saccharin**, and the two engrams' overlap has grown |
| Edge criterion | *When* it was encoded — content-blind | *That the two were co-activated* — content-blind about the memories, but driven by an external cue structure that appeared later |
| Can it link things not related at encoding? | **No** — the link must be foreseen by temporal proximity | **Yes** — this is the "connect the dots later" case, and it is why the mechanism is needed |
| Is the overlap the relation, or the content? | Shared cells' silencing abolishes the behavioural *interaction* while leaving each memory retrievable (Lisman et al. 2018, amygdala) | Same dissociation, independently: silencing the emergent shared assembly leaves both individual memories intact but **abolishes the saccharin→freezing transfer** **(tentative)** |

**The dissociation is the result.** In both regimes there exists a subpopulation that stores *the edge and nothing but the edge* — remove it and the nodes survive while the relation vanishes. A relation is therefore not an inference computed over retrieved memories at query time; it is a stored object with its own address.

### Why this is the core framing's write rule

[[wiki/concepts/latent-graph-discovery.md]] needs edges between observations never co-observed. This supplies a complete, cheap edge algebra on top of a store the wiki already wants (sparse codes over a shared population):

```
node(A)          := supp(x_A) ⊂ {1..N}, |supp| = k   (fixed budget, § above)
edge_strength(A,B) := |supp(x_A) ∩ supp(x_B)| / k
write edge:  (i) allocate B inside A's tag window        → prospective, blind, free
            (ii) co-activate A,B repeatedly → re-allocate → retrospective, evidence-driven
read  edge: reactivating A partially drives B's units    → traversal is *automatic*, no lookup
```

**(brainstorm)** Three properties no graph-memory model in the wiki has together: the graph is stored **in the same substrate as the nodes** (no edge table, so edge count costs no extra memory); traversal is a *side effect* of retrieval rather than an operation; and the edge is **erasable independently of the nodes**, which is what makes the relation a first-class object rather than an epiphenomenon of similarity. The price is that overlap-as-edge and overlap-as-interference are the same number — every edge written is capacity spent and a step toward pattern completion merging the two memories ([[wiki/concepts/pattern-separation-completion.md]]). The fixed write budget `k` is what bounds the damage, which is a second reason the set-point above may be conserved rather than load-adaptive.

**(brainstorm)** Co-retrieval linking is a Hebbian rule *one level up*: cells-that-fire-together-wire-together applied to whole traces, with the "firing together" supplied by the environment presenting two cues at once. That makes it a plausible substrate for the talk's closing claim — that iterated linking across many episodes underlies abstraction **(tentative, asserted)** — but the claim is exactly the untested step: nothing shows the shared assembly comes to represent *what the linked episodes have in common* rather than merely *that they co-occurred*. Compare [[wiki/concepts/generalization-optimized-consolidation.md]], where abstraction is derived from a predictability criterion rather than from repeated conjunction.

---

## Open problems

- **What sets `k`, and why is it conserved?** No mechanism is offered for the region-specific set-point, and conservation across salience contradicts every load-dependent optimum in the wiki (T84).
- **Does overlap-as-edge scale?** With `m` memories and a fixed budget, pairwise linking must saturate; nothing states the maximum degree of a node, nor what happens when a cell belongs to five engrams. The union arithmetic in [[wiki/concepts/sparse-distributed-representations.md]] gives 4–16 as the order of magnitude before mix-and-match errors bite — if that transfers, an engram can hold roughly a dozen edges.
- **Is the link transitive, and is that desirable?** A→B and B→C share cells with B; whether A and C become behaviourally linked is untested, and unconstrained transitivity collapses the graph.
- **Is the aspect decomposition of the engram complex real?** Region-specific content is inferred from prior regional knowledge, not from component-wise silencing.
- **Does linking produce abstraction?** Asserted in the source, unsupported by any cited experiment.
- **IEG tagging conflates plasticity with activity.** *Fos*/*Arc* mark cells that ran the program; a cell strongly driven but not plastic, or plastic in one dendritic branch only, is mis-scored — the same selectivity worry the two-pathway AND-gate in [[wiki/concepts/memory-allocation-excitability.md]] is designed to answer.

---

## Connections

- **[[wiki/concepts/memory-allocation-excitability.md]]** — the mechanism page for *which* cells are recruited; this page supplies the object that mechanism produces, adds the second (retrieval-time) way to create overlap, and adds the conserved-size and brain-wide-distribution facts that the allocation account does not address.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the actuator of the write budget: engram size is defended by feedback inhibition from principal cells onto interneurons onto their neighbours, and blocking interneurons enlarges the trace, so `k` is an inhibitory gain rather than a firing threshold **(tentative)**.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — supplies the arithmetic this page's overlap-as-edge scheme needs: overlap is simultaneously the relation and the interference, and the union bound (4–16 patterns before mix-and-match errors) is the wiki's only estimate of how many edges one trace can carry.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the direct antagonist: every edge written by increasing overlap moves the pair toward being completed as one memory, so a store doing both needs the two biases on separate axes rather than one transfer curve (G38).
- **[[wiki/concepts/latent-graph-discovery.md]]** — an edge substrate with no edge table: relations are stored as population intersections inside the node codes, traversal is a side effect of partial reactivation, and edges are independently erasable — with two write rules (temporal proximity at encoding, co-activation at retrieval) covering the prospective and retrospective cases.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the engram complex is what the fast store's "sparse conjunctive code" looks like when measured brain-wide: not one hippocampal pattern but a tuple of region-local sparse sets bound only by a shared write window.
- **[[wiki/concepts/offline-replay.md]]** — co-retrieval linking gives replay a job beyond consolidation: any process that reactivates two traces together *edits their overlap*, so offline reactivation is an edge-writing operation and not only a strengthening one.
- **[[wiki/entities/context-modular-memory-network.md]]** — the engineering counterpart of the write budget: a per-context mask choosing a fixed fraction of units, with the derived optimum (~20–30% active) sitting just above the measured amygdala engram fraction (10–20%).
- **[[wiki/entities/hopfield-network.md]]** — the same object under the older vocabulary (Hebb's cell assembly, an auto-associated pattern), but with the causal handle the attractor formulation lacks: an engram is deletable and inducible unit-by-unit, whereas a Hopfield memory is smeared over every weight.
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — the rival account of where abstraction comes from: repeated conjunction of traces (this page, asserted) versus a predictability criterion that decides what may be transferred to a slow learner at all.
- **[[wiki/concepts/synaptic-plasticity.md]]** — supplies the within-engram content: the trace is a set of *cells* selected by excitability, but what is stored inside it is synaptic, and the IEG program (*Fos*, *Arc*) is the transcriptional arm that regulates receptor trafficking downstream of that selection.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — relocates what consolidation has to produce: the controller's return arrow preferentially innervates high-degree hub neurons that *emerge after learning*, so hub formation rather than the trace itself is the addressable object.
- **[[wiki/concepts/multi-token-embedding.md]]** — the machine counterpart of recruitment: a transformer mints a representation of a multi-token entity at its final token and stores its attributes as linear subspaces of that vector, which is allocation-plus-attribute-storage with the allocation performed by a learned map rather than by relative excitability — and with no write available at inference, which is exactly what an engram has and it lacks.
