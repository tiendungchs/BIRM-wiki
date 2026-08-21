# ARC-VSA Solver — object-centric program synthesis in a vector-symbolic algebra

**An ARC solver in which every object is a high-dimensional vector (colour ⊕ SSP centre ⊕ SSP shape), the *object parse itself* is a searched hypothesis ranked by a computable similarity score, the program is a set of `IF condition THEN action` rules over an 11-operation DSL, and each rule's condition is a single unit-norm vector in the same algebra as the data — i.e. a prototype, learned by gradient descent and read by a dot product.**

> **Provenance.** Joffe & Eliasmith 2025, *Vector Symbolic Algebras for the Abstraction and Reasoning Corpus* (`raw/joffe-2025-vector-symbolic-algebras-arc.md`, arXiv 2511.08747v1, Centre for Theoretical Neuroscience, Waterloo). Self-described **preliminary**; code released. All experiments at `N = 4096`. No pre-training of any kind — the ARC training split is used as an evaluation split, not for fitting.

The wiki's third ARC attack held at source, and the first that is neither symbolic search over a logic ([[wiki/entities/ilp-arc-synthesizer.md]]) nor a frozen LLM behind a hand-authored macro menu ([[wiki/entities/corethink-compositional-reasoner.md]]). It is also the first system in the wiki to run [[wiki/concepts/vector-symbolic-binding.md]] as a *working representation for a reasoning task* rather than as a retrieval scorer.

---

## Architecture

| Component | Instantiation |
|---|---|
| **Object** | Three separate properties: **colour** = 1 of 10 fixed random vectors; **centre** = SSP of the object's bounding-box midpoint relative to grid centre, with a blur for partial similarity; **shape** = normalised bundle `⟨Σ_p φ(p − centre)⟩` of the SSPs of its pixel offsets. One colour per object by construction |
| **Object parse** | **Not fixed.** 6 candidate hypotheses (8-connected · 4-connected · vertical runs · horizontal runs · same-colour-anywhere · one-pixel-per-object), searched in a ranked order (below) |
| **Grid size** | 3 hypotheses tried in order: Identity (same as input) · Constant (same across all demonstrations) · Function (left to the program's actions) |
| **DSL** | 11 one-in-one-out operations: `Identity`, `Extract`, `Recolour(COLOUR)`, `Recentre(CENTRE)`, `Reshape(SHAPE)`, `Move(AMOUNT)`, `Gravity(DIRECTION)`, `Grow(DIRECTION)`, `Fill`, `Hollow`, `Generate(COLOUR, CENTRE, SHAPE)` |
| **Program** | A set of rules `IF (criteria over COLOUR/CENTRE/SHAPE, logically composed) THEN (operation, parameters)`. Conditions may be vacuous. One rule per operation; an object may satisfy several rules and emit several output objects |
| **Condition predictor `R_O`** | A **single-layer** net: unit-norm weight vector `w`, output `σ(β(w·o − θ))` with `β, θ` learned. `w` is therefore itself a legal VSA vector — a **prototype** of the objects the operation applies to. Initialised as the outcome-weighted superposition of the training objects, then SGD. Applied at an arbitrary 50% threshold. Skipped entirely when all labels are positive |
| **Learning signal** | Per task only: `2 ≤ \|D\| ≤ 10` demonstrations, no cross-task transfer, no pre-training |

**Three reasoning modes, run in sequence:** *abduction* (find objects + per-demonstration actions) → *induction* (generalise actions into conditioned rules) → *deduction* (execute on the query).

---

## The payload 1 — the object parse is chosen by a computed score

This is the wiki's first mechanism that **selects a discretisation of the input by a criterion computed from the data**, rather than fixing one (CoreThink's 8-connected BFS), authoring a typed superset ([[wiki/entities/ilp-arc-synthesizer.md]]), or leaving it to a learned encoder. Gap G27 has had no candidate of this shape, and the wiki's other two ARC solvers take the two other available positions — carry every parse, or fix one ([[wiki/empirical-tensions.md]] T191).

The paper states the causality paradox exactly: *an object is a group of pixels transformed cohesively, but actions are ill-defined without objects to transform*. Its resolution is top-down — propose parses first, and let the **cost of the actions they imply** reject them:

```
for each of 6 parses, for each output object o_j:
    s = softmax( [ sim(o_j, o_i) for input objects o_i ] , padded with 0 and 1 )
    score contribution = max(s)
rank parses by mean over all output objects, descending
```

Two properties are folded into one number, and both are read off the softmax:
- **Few objects.** Every extra input object adds a finite similarity term to the softmax denominator, so parses that shatter the grid are penalised.
- **Unambiguous correspondence.** Two input objects of near-equal similarity split the mass, so parses producing ambiguous mappings are penalised.

The score is a *representation-selection* criterion — it never consults whether the task gets solved. It is also only computable where both grids are visible, i.e. it works on demonstrations and cannot rank a parse of the query. Search stops at the first parse whose action set is found and whose cost is "acceptable"; the acceptance threshold is not given.

**(brainstorm)** The same quantity is a ready-made abstention signal: a task whose best parse has a low mean max-softmax is one where *no* available discretisation makes the demonstrations look like an object mapping. Nothing in the paper reads it that way, and it costs nothing extra (G17, G68).

---

## The payload 2 — a non-length simplicity criterion, defined across demonstrations

Each output object is explained by *many* candidate actions (`Recentre((1,1))` and `Move((5.5,−1.5))` are both correct for the same object). Choosing among them is cast as a **minimum hitting set**:

```
S = { A_k }  — one candidate action set per output object, over all demonstrations
find A ⊆ U with A ∩ A_k ≠ ∅ ∀k, minimising f(A)
f penalises each distinct operation and each distinct operation–parameter pair
```

The stated principle: *"simplicity is determined by the relative frequency of the actions; recurring operations and parameters have greater explanatory power."* NP-complete, exactly solved fast in practice.

**Why this matters for G26.** The wiki's standing complaint is that hypotheses are ranked by description length, which Chollet's own ARC sketch already refuses. This criterion is not length-of-one-program: it is **reuse across the whole demonstration set**, which is a length measure over a *jointly* coded corpus of actions and cannot be evaluated on a single demonstration at all. It is the same move [[wiki/entities/corethink-compositional-reasoner.md]] found to be worth +5.5 points — *count agreement over hypotheses across demonstrations* — arriving here as an exact combinatorial objective instead of a vote, and doing the choosing rather than the filtering. It remains a coding-cost criterion (fewer distinct symbols ⇒ shorter code), so it does not exit G26's family; what it changes is the *unit* the code is charged over.

Two heuristics prune before the hitting set runs, both pure VSA reads:
| Heuristic | Rule | What it assumes |
|---|---|---|
| Correspondence | Consider only the **most similar** input object as the source of each output object | Dissimilar objects are not connected by simple transforms |
| Operation | Consider only operations touching the **least similar property** | Actions need only alter what differs |

---

## The payload 3 — the learned condition is a vector in the same algebra

`R_O`'s weight vector is unit-norm, so the classifier is `similarity to a prototype, thresholded by a learned sigmoid`. Consequences the wiki should keep:

- **The learned abstraction is inspectable in the representation's own terms** — a condition can be decoded and compared against object codes, unlike any learned condition elsewhere in the wiki ([[wiki/concepts/representation-probing.md]], [[wiki/concepts/linear-representation-hypothesis.md]] — the linear read here is *by construction*, not a finding).
- **Generalisation behaviour is inherited from the code's similarity structure, not learned.** Measured directly on Sort-of-ARC: colour-conditioned tasks **100.0%**, shape-conditioned tasks **89.0%**, because distinct colour vectors are near-orthogonal while distinct shape SSP bundles are not. The failure mode is *over-generalisation* — with no near-miss negatives among the demonstrations, a prototype for "O-shaped" also fires on U-shaped objects. The authors call this the price of the capacity that solves harder tasks.
- That trade is [[wiki/concepts/pattern-separation-completion.md]]'s dial (G38) measured on rule induction rather than on memory, and nothing here sets it: the blur width and the SSP length-scale `l` are fixed hyperparameters.
- **Property selection is by leave-one-demonstration-out cross-validation.** Which of `{COLOUR, CENTRE, SHAPE}` the predictor sees is itself searched, scored by held-out demonstration performance — an explicit anti-[[wiki/concepts/shortcut-learning.md]] device, and the wiki's cleanest small instance of a *rejector* (G68) that consumes no ground truth beyond the demonstrations it already has. It needs `|D| ≥ 2` and the authors note some tasks need all demonstrations jointly, so the device and the data are in direct competition.

---

## Results

**ARC-AGI (task accuracy, exact match):**

| Split | Demonstrations solved (task) | **Queries solved (task)** |
|---|---|---|
| ARC-AGI-1-Train (400) | 48.8 | **10.8** |
| ARC-AGI-1-Eval (400) | 33.5 | **3.0** |
| ARC-AGI-2-Train (1000) | 35.9 | **5.8** |
| ARC-AGI-2-Eval (120) | 11.7 | **0.0** |

**Reduced benchmarks:**

| Benchmark | Score | Comparison |
|---|---|---|
| Sort-of-ARC (1000) | **94.5** (colour 100.0 / shape 89.0) | Condition-action learning in isolation |
| 1D-ARC (900) | **83.1** | Beats direct-prompted GPT-4 "at a tiny fraction of the computational cost"; failures concentrate on `Flip`/`Mirror` — reflection is absent from the DSL |
| KidsARC (26, one demonstration each) | **57.7** (simple 66.7 / concept 37.5) | Aggregate LLMs 33.2 / 11.9 |
| ConceptARC (176) | **20.5** | Comparable to GPT-4. Strong on spatial concepts (Above/Below, Filled/Not Filled, Horizontal/Vertical), weak on Count, Order, Same-and-Different |
| MiniARC (149) | **13.4** (demonstrations 55.0) | 5×5 grids, unconstrained content |

**The gap between the two ARC columns is the result.** On ARC-AGI-1-Train the solver constructs a program reproducing *every* demonstration for 48.8% of tasks and generalises on 10.8% — a 4.5× drop; on Eval, 33.5% → 3.0%, an 11× drop. Explaining all demonstrations is achieved four to eleven times more often than solving the task, which prices demonstration-consistency as an acceptance test: it is cheap to pass and weakly predictive ([[wiki/empirical-tensions.md]] T188). The paper reports this split deliberately and calls the first column "some understanding" and the second "true, generalizable understanding".

**What the score is *not* evidence about.** ConceptARC's failures are attributed to two separable causes — parses the object hypothesis set cannot express (Copy, Complete Shape, Clean Up) and reasoning the DSL cannot express (Count, Order, Same-and-Different) — so, as with NEO ([[wiki/entities/neo-neural-theorizer.md]]), a low score does not license a claim about the representation.

---

## Comparison — the wiki's three ARC solvers held at source

| | **ARC-VSA** (Joffe & Eliasmith 2025) | [[wiki/entities/ilp-arc-synthesizer.md]] (Rocha et al. 2024) | [[wiki/entities/corethink-compositional-reasoner.md]] (Das et al. 2025) |
|---|---|---|---|
| Representation | Distributed VSA vectors, graded similarity | Typed Prolog terms, exact match | JSON scene dicts + natural language |
| Object parse | **Searched**, 6 hypotheses ranked by a computed score | Authored superset — all overlapping parses kept | Fixed: 8-connected BFS (+ LLM for ambiguity) |
| Vocabulary grain | 11 fine primitives, parameterised | 7 predicates | 22 macro-patterns with enumerated value menus |
| Hypothesis selection | Minimum hitting set on operation/parameter reuse across demonstrations | Maximum coverage, ≥2 demonstrations | Top-3 by detection count across 5 samples × demonstrations |
| Rule conditions | **Learned** — prototype vector + sigmoid | Clause body literals, induced | Categorical parameter slots, LLM-detected |
| Execution | Deterministic, per-object | Deterministic ordered writes with occlusion | An LLM reads the hint and writes the grid |
| Trained parameters | Per task, ~`N`+2 per rule | None | None |
| ARC score | 3.0 (ARC-1-Eval), 0.0 (ARC-2-Eval) | 5 hand-picked training tasks | 24.4 alone / 30.8 ensembled (ARC-2-Eval, pass@2) |
| Compute | Small — no brute force, no large net | Small | Many frontier-LLM calls |

The score column and the mechanism columns point in opposite directions, and that is the honest reading: the system with the most machinery of its own scores lowest, and the system that outsources the reasoning scores highest. What ARC-VSA buys instead is that **every intermediate object is a nameable, decodable state** — the parse, the action set, the condition prototype and the predicted object are all in one algebra.

---

## Where the core-knowledge priors live

A distinctive architectural claim, worth separating from the results ([[wiki/concepts/core-knowledge.md]]):

| Prior | How supplied |
|---|---|
| **Geometry** | By the **encoding**, not by primitives: in SSP space binding *is* translation in feature space (`φ(x)⊛φ(y) = φ(x+y)`), the origin is the identity vector, and inversion is negation. `Move` is a bind |
| **Number** | Implicitly, by SSP kernel structure — magnitudes are similarities, not counted symbols. This is also why Count/Order tasks fail |
| **Objectness** | Explicitly and separately, by the parse-hypothesis search |
| **Goal-directedness** | **Absent.** Left for future work |

So two of ARC's four declared priors are delivered as *properties of the representation format* rather than as rules or DSL entries — the strongest instance in the wiki of a prior installed as an algebra. It is also where the entry-test problem (G23) is dodged rather than solved: an SSP prior is unconditional, always on, and cannot decline a grid.

---

## Limitations (the authors' list, plus one)

- **Not DSL-open.** The grid-size, object and action hypothesis sets are finite and fixed; nothing is generated on the fly. The paper states plainly that this disqualifies it as an AGI solution, and that *how those conceptualisations came to be* is not addressed — cost 1 of [[wiki/concepts/program-induction.md]] paid in full, again.
- **No chained operations on one object.** Each input object gets one operation per rule; composition survives only inside `Generate`. This is the compositionality the DSL nominally has and the search structurally forbids.
- **No repeated instantiation** of one operation on one object (one rule per operation).
- **No many-to-one or many-to-many object mappings** — so tasks requiring comparison *between* objects are out of scope by construction, which covers most of ConceptARC's Same-and-Different and Count families.
- **No multi-coloured objects** — a direct consequence of factorising an object into independent colour/centre/shape.
- **No conditions on high-level properties** (exact pixel count, symmetry). Justified as cognitive plausibility — the claim that humans encode these only *after* their relevance appears is asserted, not tested.
- **(wiki) Every heuristic is a similarity read with no calibration.** The correspondence, operation and parse heuristics are all `argmax`/`max` over dot products whose scale depends on `N`, the blur width and the length-scale `l`; none has a rejection threshold, and the one threshold that exists (50% on `R_O`) is stated as arbitrary.
- **(wiki) Cognitive plausibility is an argument, not a measurement.** The System 1 / System 2 mapping, the claim that humans propose parses top-down, and the claim that the solver's search is human-like are motivations; no human data is collected, and the human action-trace studies cited (Johnson et al., LeGris et al.) are used as design constraints rather than as fits.

---

## Connections

- **[[wiki/concepts/vector-symbolic-binding.md]]** — the algebra this system runs on, extended here in two directions: continuous quantities via fractional binding (SSPs), and a use of the code as a *working representation* for search and learning rather than as a similarity scorer over a stored memory.
- **[[wiki/entities/arc-agi.md]]** — the benchmark, with two of its four declared priors supplied here as properties of the representation format (binding = translation) rather than as DSL entries, and its demonstration/query split reported separately as evidence about what consistency buys.
- **[[wiki/concepts/program-induction.md]]** — the family: an authored DSL searched per task, with a simplicity criterion charged over *reuse across demonstrations* rather than over one program's length, and its costs 1 and 3 both visible in one system.
- **[[wiki/entities/ilp-arc-synthesizer.md]]** — the same task attacked from the exact-symbolic corner: identical object-centric commitment, opposite handling of the parse (typed superset kept vs. six hypotheses ranked and one chosen) and of similarity (exact unification vs. graded dot product).
- **[[wiki/entities/corethink-compositional-reasoner.md]]** — the same cross-demonstration agreement principle at a different grain and a different price: a vote over macro-pattern labels forwarded as a hint, against an exact minimum-hitting-set over fine primitives that is the selection itself.
- **[[wiki/concepts/core-knowledge.md]]** — the wiki's clearest case of priors installed as an *algebra*: geometry and number arrive with the SSP encoding and are therefore unconditional, which is gap G23's entry-test problem sidestepped rather than answered.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the separation/completion dial measured on rule induction: near-orthogonal colour codes give strict rules and 100% accuracy, overlapping shape codes give abstraction *and* over-generalisation at 89%, with nothing setting the trade-off (G38).
- **[[wiki/concepts/shortcut-learning.md]]** — its remedy applied at the level of input selection rather than the loss: leave-one-demonstration-out cross-validation over which object properties the condition predictor may see, so a spurious property is rejected before it can be fit.
- **[[wiki/concepts/latent-graph-discovery.md]]** — an instance where the *node set* is an explicit ranked hypothesis rather than an assumption: the six object parses are candidate discretisations of one observation, scored by how cleanly they make the demonstrations look like a node-to-node mapping (G27).
- **[[wiki/concepts/path-integration.md]]** — the abelian special case made into a data structure: SSP binding adds displacements in feature space and the identity vector is the origin, so a position code is path-integrated by construction and `Move` is a single bind.
- **[[wiki/concepts/linear-representation-hypothesis.md]]** — a system in which linear readability is a design constraint rather than an empirical finding: the learned condition is a unit-norm vector in the same space as the data, so "the concept" and "a direction" are the same object by construction.
- **[[wiki/concepts/compositionality.md]]** — a case where the representation composes and the *search* does not: fixed-width binding permits arbitrary composition, while the one-operation-per-object restriction forbids chained transforms, so the ceiling is in the synthesiser, not the code.
- **[[wiki/entities/spiking-neural-networks.md]]** — the substrate claim the VSA line carries: the same algebra is implementable in spiking neurons (the Neural Engineering Framework, Spaun), which is what "cognitively plausible" is doing in this paper's argument.
- **[[wiki/concepts/external-verification.md]]** — three acceptance tests at different rungs in one pipeline: parse rejected by action cost, action set rejected by hitting-set cost, property subset rejected by held-out demonstration — none of which consults the query, and all of which the results show to be weak predictors of it.
- **[[wiki/concepts/representation-probing.md]]** — the degenerate case of that page's method: because the learned rule condition is a unit-norm vector in the data's own algebra, it is read by a dot product against object codes rather than by an externally fitted read-out, so there is no probe to over-fit and no probe/behaviour gap to argue about.
- **[[wiki/entities/arc-agi-2.md]]** — what the re-authored benchmark does to a method whose vocabulary is a fixed spatial-semantic algebra: 11.7% on demonstrations and **0.0%** on queries, against 48.8/10.8 on version 1, which is the coverage-vs-abstraction question of T205 answered by a benchmark rather than by an argument.
- **[[wiki/entities/conceptarc.md]]** — the benchmark behind this page's 20.5 on a 176-test-input subset, and the design that makes the per-concept attribution above meaningful: 10 instantiations per concept, so "weak on Count, Order, Same-and-Different" is a coverage statement rather than three task outcomes.
- **[[wiki/entities/poe-arc-solver.md]]** — the same rejector question asked over augmented frames of one task rather than over demonstrations, at 71.6% against this page's 3.0% on ARC-AGI-1 Eval, which isolates how much of an ARC score is the pretrained prior rather than the selection machinery.
- **[[wiki/concepts/problem-framing.md]]** — the wiki's only architecture that treats the object parse as a *variable*: searching six candidate parses jointly with the rule is the sole partial answer to G75, the framing decision that survives inside a format designed to fix the framing.
