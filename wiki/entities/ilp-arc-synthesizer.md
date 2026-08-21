# ILP-ARC — Program Synthesis for ARC by Inductive Logic Programming

**A symbolic ARC solver in which the hypothesis is a sequence of Horn clauses induced by inductive logic programming over a hand-written object-centric background theory, and the output grid is *constructed* by executing that sequence onto an empty canvas.**

> **Provenance.** Rocha, Dutra & Santos Costa 2024, *Program Synthesis using Inductive Logic Programming for the Abstraction and Reasoning Corpus* (`raw/rocha-2024-ilp-program-synthesis-arc.md`, arXiv 2405.06399v1, INESCTEC–FCUP). **Preprint with an unfinished implementation**: five hand-picked training tasks, no evaluation-set run, no baseline, no timings. Everything below is a *mechanism* report; nothing here is a performance claim. It is the wiki's first ingested source in which inductive logic programming (ILP) is the search engine, and the first ARC attack it holds at source ([[wiki/concepts/program-induction.md]] cost 1).

---

## Architecture

| Component | Instantiation |
|---|---|
| **Background knowledge (the DSL)** | 3 object types — `Point(x,y,color)`, `Line(x1,y1,x2,y2,color,len,orientation,direction)`, `Rectangle(4 corners, color, clean, area)`; 4 relation types — `LineFromPoint`, `Translate`, `Copy`, `PointStraightPathTo`. Hand-authored, typed |
| **Hypothesis class** | Horn clauses in Prolog (Turing-complete host language, but see Limitations — no higher-order construct is induced) |
| **What is learned** | A **relation**, not a function. `line_from_point(Point,Line,Len,Orientation,Direction) :- member(Point,Input_points), equal(Len,5), equal(Orientation,'vertical').` The head's `Line` variable stays free — the clause *generates* the objects that satisfy it |
| **Search** | Top-down ILP (FOIL-style), one call per relation found in the task |
| **Candidate body literals** | Retrieved objects and relations, plus `equal/2`, `greaterThan/2`, `lowerThan/2`, `member/2`, and affine forms `aX+b` with `a,b` from a predefined constant interval. **Typed generation**: only candidates type-compatible with the target relation's variables are enumerated |
| **Program assembly** | A sequence of clauses, executed in order onto an empty grid pre-filled with the background colour |
| **Selection** | Consistency pruning + shortest program (Occam) among those that build a training output and produce *some* valid test output |

**Pipeline.** (1) Retrieve every DSL object in every input and output grid. (2) Retrieve relations, partitioned into Input–Input, Output–Output and Input–Output. (3) Call ILP per relation, **Input–Output first**, since output objects must be built from input information. (4) After each call, the objects it generated are **reclassified as input** and the updated grid becomes the canvas for the next call, so Output–Output relations become usable once anything exists in the output. Input–Input relations may appear in a clause body but are never targets — they generate nothing.

---

## The five mechanisms worth keeping

### 1. Generality is a monotone function of clause length, and it is visible

Dropping the last body literal from the clause above removes the orientation constraint, and the same program then draws lines in *every* orientation from each input point. Each added literal deletes generated objects. This is the [[wiki/concepts/language-of-thought.md]] **overgeneration** problem in machine form, with a dial attached: the induced program's specificity is bought literal by literal, and something must say when to stop adding.

### 2. Negative examples are manufactured from the generator's own overgeneration

ARC supplies positives only. Their construction, under a closed-world assumption:

- **Positives** = objects the clause generates that *do* appear in the training output.
- **Negatives** = objects the clause generates that *do not*.

The rejector is therefore free, internal, and defined over the generator's own output space rather than over the grid — object-centric, so the negative set is `O(#objects)` and not `O(#pixels)`. It sits below the execution rung of [[wiki/concepts/external-verification.md]]'s ladder (deterministic, complete, generator-independent criterion) but it is *not* external in that page's sense: the space of negatives is exactly what the DSL can express, so a transformation the DSL cannot describe produces no informative negatives at all.

### 3. A second rejector needs no ground truth at all: theory consistency

A program that draws two differently-coloured lines through the same cell asserts something the grid cannot satisfy — one occludes the other. Such programs are discarded during the search *without consulting the target output*. This is the cheapest acceptance test in the wiki after [[wiki/concepts/analogical-mapping.md]]'s coherence check, and the same kind: it tests **internal coherence of the hypothesis**, not agreement with data.

### 4. Multiple overlapping parses are kept, and the explanation selects the parse

A rectangle in a grid *is also* a set of lines, and also a set of points. The system does not choose: an image representation is a list of possibly-overlapping objects plus a background colour, and all readings are carried forward until a program exists. Whether the task's logic is `Copy(rectangle)` or `LineFromPoint(point)` decides which parse was the right one, **after** the fact.

This is a concrete posture on gap G27 (nothing supplies the discretisation the graph formalisation assumes): do not commit the node set — hand the search a *superset* of candidate nodes and let the edge that explains the transformation pick its own endpoints. It defers rather than solves — the superset is generated by three authored object types — but it is the wiki's only worked instance of parse selection by downstream explanatory success, and it is cheap exactly because objects are typed (a type mismatch prunes a parse before any clause is built).

### 5. Execution is order-dependent, so the program is a sequence with side effects — and the order is searched

Once an object is drawn, nothing drawn later may intersect it. So the same clause sequence covers different amounts of grid depending on application order — the paper calls the resolution *deductive search*: at test time apply the whole program in the order that **covers the most grid surface**, on the argument that the program provably covers the whole training output, so a maximum-coverage ordering should reproduce the whole test output.

Two consequences for the wiki's framing. First, these "edges" do not commute: [[wiki/concepts/latent-graph-discovery.md]]'s path is here a *write* sequence onto a shared canvas, and occlusion makes the composition non-associative in a way a pure transition graph has no vocabulary for. Second, maximum-coverage is an **authored selection criterion smuggled in below the prior** — nothing derives it, and it is doing work that the ranking over programs is elsewhere supposed to do (G26).

---

## Results

| Task (ARC training set) | Source of demand |
|---|---|
| `08ed6ac7`, `a48eeaf7`, `7e0986d6` | Three tasks with visibly different logic, all expressible in the 7-predicate DSL |
| `0a938d79` | The partial-unification case (below) |
| `150deff5` | The case where the output grid is more informative than the input, motivating the ordering search |

**All five are training-set tasks, hand-selected on the criterion that they need no primitive outside the authored seven.** No evaluation-set number exists; the authors state the full run waits on finishing the implementation. Prolog solutions per task are in the paper's appendices.

---

## The deliberate under-fit — a program is required to cover **two** examples, not all

Task `0a938d79` has four training pairs: two with vertical output lines, two with horizontal, and a test needing vertical. A program unifying all four requires the general rule (*draw a line from each point to the opposite border, then translate it perpendicularly across the grid*); a program unifying only the first two is much shorter and **also solves the test**. The system therefore constrains ILP to clauses that unify across **≥2** training examples and stops there.

| | Claim | Cost |
|---|---|---|
| **For** | The fully general program can be strictly more complex than the test needs, and search cost is the binding constraint | — |
| **Against** | Nothing selects *which* two examples. The horizontal pair yields an equally valid, equally short program that fails this test. The reported success is a coin-flip the paper does not price | An un-scored 50% gamble on a 4-example task; worse as example counts grow |

This is a direct break with the consistency-with-all-data criterion assumed by every other program inducer in the wiki, and it is recorded as [[wiki/empirical-tensions.md]] T188.

---

## Limitations

| Limitation | Consequence |
|---|---|
| **No higher-order constructs** | No `Do Until`, `Repeat While` or recursion is induced. Repeated translation is emitted as *n* copies of the same clause, so the program works on the test grid only if the test needs **≤ n** repetitions. A larger test grid breaks it. Stated as future work; the wiki records it as gap **G70** |
| **DSL is authored and tiny** | 3 objects, 4 relations. Task selection was conditioned on the DSL, which makes the 5/5 result a statement about the tasks chosen, not about coverage. Automating DSL creation is listed as future work — i.e. gap G4 is untouched |
| **Unfinished implementation** | No full training/evaluation run, no runtime, no ablation of any of the five mechanisms above |
| **Colour and background are given** | The background colour and the palette are read off the grid; nothing induces them |
| **Search cost unreported** | The three complexity reducers claimed (object-centric abstraction, typed candidate generation, restricting ILP targets to relations actually observed) are all plausible and none is measured |

---

## Comparison

| System | Program space | Library origin | Rejector | Handles ordering / state |
|---|---|---|---|---|
| **ILP-ARC** | Horn clauses over 7 authored predicates, straight-line sequence | **Authored** (7 predicates) | Manufactured negatives + theory consistency, both free | **Yes** — occlusion-ordered writes onto a canvas, order searched |
| [[wiki/entities/neo-neural-theorizer.md]] | Concatenations of ≤8 VQ codebook symbols | **Induced** from observation pairs | Majority vote @1024 (~180× cost) | No — untyped concatenation |
| [[wiki/entities/bayesian-program-learning.md]] | Stochastic motor programs over strokes | **Learned primitives, authored relation types** | Posterior score | Partly — strokes are ordered, order is part of the generative model |
| [[wiki/entities/arc-agi.md]] (Chollet's sketch) | An unbuilt DSL over four core-knowledge priors | **Forbidden to author** | Learned prior over programs (unspecified) | Unspecified |

The row that matters: ILP-ARC is the only entry whose rejector costs nothing *and* whose vocabulary is entirely authored. Those two facts are the same fact — negatives are cheap precisely because the DSL bounds what a hypothesis can say.

---

## What a builder should take

1. **A generative hypothesis manufactures its own negative set.** Any inducer whose clauses leave head variables free gets a discriminative signal out of a positives-only dataset for free. This is the cheapest thing on the verification ladder that returns more than one bit, and it needs no learned model.
2. **Do not commit the parse.** Carrying a superset of typed candidate nodes and letting the explaining relation select among them costs a type check and removes an unforced decision that every object-centric pipeline in the wiki currently makes up front.
3. **(brainstorm) The two rejectors are separable and the second is the transferable one.** Manufactured negatives need ground truth; theory consistency does not — it only needs the hypothesis to assert something the *world's* constraints forbid (two colours, one cell). A brain-inspired reasoner has no kernel ([[wiki/concepts/external-verification.md]]), but it does have installed constraints ([[wiki/concepts/core-knowledge.md]]) — cohesion, continuity, contact — which are exactly of this form: a proposal violating solidity can be rejected before any outcome is observed. That would make core knowledge a **rejector** rather than a generator of hypotheses, which is a role the wiki has never assigned it.
4. **Straight-line programs cannot extrapolate a count.** Unrolling is what forces the test grid to be no larger than the training grids. Every induced program in the wiki has this property (G70).

---

## Connections

- **[[wiki/concepts/program-induction.md]]** — the family this instantiates, and its first ingested ARC member: it pays cost 1 in full (7 authored predicates) and in exchange gets costs 2 and 4 cheaply — typed candidate generation prunes the search, and a rejected clause returns a whole *set* of named negative objects rather than one bit.
- **[[wiki/entities/arc-agi.md]]** — the benchmark, attacked by exactly the route its author sketched (build a DSL, search it), with the result that the DSL is where all the difficulty went: task selection had to be conditioned on the seven authored predicates.
- **[[wiki/concepts/external-verification.md]]** — supplies two rejectors below the execution rung: negatives manufactured from the hypothesis's own overgeneration under a closed-world assumption, and a consistency check that needs no ground truth at all.
- **[[wiki/concepts/language-of-thought.md]]** — the overgeneration objection made mechanical: each body literal deletes generated objects, so "how specific should the hypothesis be" is a clause-length choice and the negatives are what set it.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a case the framing's path vocabulary does not cover: the edges are *writes onto a shared canvas* and later writes are occluded by earlier ones, so composition is order-dependent and the ordering is itself searched.
- **[[wiki/concepts/core-knowledge.md]]** — the objectness prior supplied as three authored types, and the source of the observation that a grid admits several equally valid object parses, which the priors alone do not adjudicate.
- **[[wiki/entities/neo-neural-theorizer.md]]** — the exact complement: NEO induces its vocabulary and pays for search with 1024 samples and a vote; this system authors its vocabulary and gets rejection for free. Between them they show the vocabulary and the rejector are traded against each other, not obtained together.
- **[[wiki/entities/bayesian-program-learning.md]]** — the same authored-library / per-instance-program split, with the relations here induced as logic clauses rather than sampled from a prior, and with an ordered side-effecting execution semantics in place of stroke composition.
- **[[wiki/concepts/compositionality.md]]** — composition here is sequential grid-state update, not function application, so the parts do not compose independently of the order they are applied in.
- **[[wiki/concepts/subgraph-matching.md]]** — the retrieval step it does by brute force: relations are found by enumerating candidate object pairs in and across grids, which is the matching problem at a scale small enough that no approximation is needed.
