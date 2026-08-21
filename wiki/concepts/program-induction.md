# Program Induction

**Reasoning is search over a space of programs: infer the shortest / highest-prior composition of primitives that reproduces the observed input–output pairs, then run it to answer the query.**

The wiki's core framing names *program induction* as one of the rival one-problem reductions to latent graph discovery ([[wiki/concepts/latent-graph-discovery.md]]). This page is that rival stated in full, assembled from the wiki's existing material — it has been the operating frame of four pages ([[wiki/entities/bayesian-program-learning.md]], [[wiki/entities/arc-agi.md]], [[wiki/entities/aixi.md]], [[wiki/concepts/universal-induction.md]]) without ever being stated as one commitment.

> **Provenance.** **Goodman, Gerstenberg & Tenenbaum 2024** now supplies the family's own foundational statement — concept learning *is* program induction, run as a query over the outputs of a stochastic **program-generating program** ([[wiki/concepts/language-of-thought.md]]). **Baek et al. 2026 ([[wiki/entities/neo-neural-theorizer.md]]) is the first ingested source that *is* about program induction as such**, and it changes three of the four costs below. Everything else on this page is folded from sources ingested for other reasons: Lake, Salakhutdinov & Tenenbaum 2015 via Lake et al. 2017 (BPL), Chollet 2019 (the ARC solver sketch), Hutter 2000 (the formal limit), Taniguchi et al. 2023 (symbols distilled to PDDL rules). **Rocha, Dutra & Santos Costa 2024 ([[wiki/entities/ilp-arc-synthesizer.md]]) is the first ingested source that attacks ARC by this route**, and it supplies the family's opposite corner from NEO: an entirely authored library, and rejection for free. Other machine-learning statements of the tradition remain unread in `raw/` (`johnson-2021-human-program-induction-arc.md`, `das-2025-compositional-neurosymbolic-arc.md`, `franzen-2025-product-of-experts-arc.md`); see Open Problems.

---

## The commitment

| Element | Program-induction statement |
|---|---|
| **What a concept is** | A procedure. To have the concept is to hold a program that generates its instances (BPL: a concept is a stochastic motor program) |
| **What learning is** | Posterior inference over program space: `p(π \| D) ∝ p(D \| π) · p(π)`, where `p(π)` is a prior over compositions, usually length-based |
| **What the primitives are** | A **library** / domain-specific language (DSL), fixed in advance or grown across tasks |
| **What generalization is** | Re-use: a sub-program that worked on an earlier task is recombined into a new one, so transfer is *literal* code sharing rather than a shared representation |
| **What the answer is** | The program's *output* — obtained by execution, not by retrieval or interpolation |

The whole family is one design choice repeated at three budgets: keep the full computable program class and lose computability ([[wiki/entities/aixi.md]]), bound the class by proof length ([[wiki/entities/aixi.md]], AIXItl), or hand-restrict it to a domain DSL and make search feasible ([[wiki/entities/bayesian-program-learning.md]]).

---

## Translation to the graph framing

The two reductions are mutually foldable — which is exactly why neither is a finding. The dictionary:

| Latent graph discovery | Program induction |
|---|---|
| Edge label | A primitive, or a one-line program |
| Edge vocabulary (hardness 2) | The DSL / primitive library |
| Path (composed sequence) | The program |
| Meta-graph | The library shared across tasks |
| Instance-graph | The per-task program |
| Navigation / path search | Program search, ranked by `p(π)` |
| Node content | Intermediate values on the execution trace |

**Where the dictionary is exact.** ARC-AGI is the clean case: the benchmark is described in the wiki as pure edge-label-latent with a co-latent vocabulary, and Chollet's intended solver is a DSL search that recombines sub-programs from earlier tasks ([[wiki/entities/arc-agi.md]]). Those are the same sentence in two vocabularies. Likewise BPL's library/program split *is* the two-level hierarchy, drawn at `program vs. library` rather than at `g vs. x`.

**Where it is not.** Three asymmetries, and they run in both directions:

- **Programs have binding and recursion; paths do not.** A program can bind a variable, call itself, and type-check its arguments. This is precisely the **non-embeddable symbolic slice** the graph framing lists as its own open bet — so on that slice program induction is not a rival account but the *only* account the wiki holds. What it buys there is real: modular arithmetic and syntactic recursion are short programs and are not short walks.
- **Paths have a state the walker is *in*; programs do not.** Hardness sources 3 and 4 — observation aliasing and simultaneity (infer the structure *while* navigating it) — have no statement in program-induction terms, because program search assumes a corpus of complete input–output pairs and a clean discovery-then-use separation. Both BPL and the ARC solver score `Not addressed` on those rows.
- **A program is selected by length, a path by traversal cost.** These come apart, and the wiki has the case on record: Chollet's own step 3 refuses ranking by simplicity alone and asks for a *learned* prior over programs instead, which is gap G26 (nothing selects hypotheses by structure rather than by length) receiving its first concrete proposal.

---

## The formal spine, and its ceiling

Program induction has the wiki's only reduction with a *proved* limit case, and both halves of the result matter.

| Result | Statement | Where |
|---|---|---|
| **The ideal inductor exists** | Weight every computable hypothesis by `2^−(shortest program length)`; the mixture dominates every computable alternative within a constant equal to that alternative's description length | [[wiki/concepts/universal-induction.md]] |
| **Learnability = compressibility** | The only property of the environment entering the convergence bounds is `K(µ)` — description length, not size, stochasticity or stationarity | [[wiki/concepts/universal-induction.md]] |
| **Uncomputability is removable** | AIXItl enumerates programs of length `≤ l̃` carrying a proof they never overrate their own value; `O(2^l̃·t̃)` per cycle | [[wiki/entities/aixi.md]] |
| **The active wall is not** | For any agent whose actions influence its observations, **no** credit bound in terms of `K(µ)` exists — proved, not merely unfound (gap G25) | [[wiki/concepts/universal-induction.md]] |
| **Short ≠ navigable** | The simplicity prior selects a short program, not a structured one, so even the ideal inductor need not expose the graph in usable form (gap G26) | [[wiki/entities/aixi.md]] |

The last two rows are what a builder should carry. Program induction is *complete* on the passive slice — sequence prediction and classification are "essentially solved apart from computation" — and provably has no such guarantee the moment the learner's outputs shape the data it will see. Any architecture in this family that operates in a loop with an environment is buying its guarantee from environment assumptions (separability class), not from the induction principle.

---

## Instantiations in the wiki

| System | Program space | Library origin | What it demonstrates |
|---|---|---|---|
| [[wiki/entities/bayesian-program-learning.md]] | Stochastic motor programs over strokes, sub-parts, relations | **Authored** — relation types given by the prior, primitives learned in pre-training | One-shot human-level classification and generation from 5 alphabets of pre-training, where matched convolutional nets have ~5× the error. The wiki's clearest existence proof that a two-level factorization pays in sample efficiency when it is *installed* |
| [[wiki/entities/arc-agi.md]] | An unbuilt DSL over four core-knowledge priors | **Forbidden to author** — supplying it in combinable program form is stated as the unsolved subproblem | That the priors are not the hard part: the *combinable program form* is (gap G21 as an engineering deliverable) |
| [[wiki/entities/aixi.md]] | All computable environments | Universal machine | The ceiling and its two walls |
| [[wiki/concepts/affordance-grounded-symbols.md]] | Probabilistic PDDL rules distilled from an effect predictor, handed to an off-the-shelf planner | **Induced from interventions** — categories carved by consequence rather than appearance | The one route on the wiki where the symbols a program is written over are grounded rather than authored, which makes rollout depth a symbolic search parameter |
| [[wiki/entities/neo-neural-theorizer.md]] | Sequences of VQ codebook symbols, length chosen per instance by MDL | **Induced from raw observation pairs** — no DSL, no program labels, no task grouping, and the semantics supplied by one shared executor rather than stipulated | That the library is *learnable*: primitiveness 1.000 including primitives never observed in isolation, and 0.933 compositional-OOD transfer where monolithic latent-action baselines score 0.000. Toy domains, frozen pretrained encoder |
| [[wiki/entities/ilp-arc-synthesizer.md]] | Sequences of Horn clauses over 3 object and 4 relation predicates, executed as ordered writes onto a grid | **Authored** — 7 predicates, with task selection conditioned on them | That a *generative* hypothesis class pays for itself: leaving head variables free makes the clause generate a set, so a positives-only dataset yields negatives (the objects generated that are absent from the output) and clause length becomes a visible generality dial. 5 hand-picked ARC training tasks, unfinished implementation, no evaluation run |
| [[wiki/entities/arc-vsa-solver.md]] | Sets of `IF condition THEN action` rules over 11 one-in-one-out operations on vector-symbolic objects, with the object parse itself a searched hypothesis | **Authored** — 11 operations, 6 object parses, 3 grid-size hypotheses, all finite and fixed | That the *selection criterion* need not be program length: the action set is chosen by minimum hitting set penalising each distinct operation and operation–parameter pair **across all demonstrations jointly**, so reuse rather than brevity does the ranking. Also the family's sharpest measurement of what demonstration-consistency buys — 48.8% of ARC-1-Train tasks reproduced in full, 10.8% solved |
| [[wiki/entities/neuromatch.md]] | — (retrieval, not synthesis) | — | The discriminative counterpart of the same query: order-embedding subgraph matching buys millisecond retrieval of a stored structure with an un-flagged error rate where program search buys a posterior with search cost ([[wiki/concepts/subgraph-matching.md]]) |

---

## The measured alternative: transduction, and the fact that it is complementary

The reduction has a rival that skips program space entirely — **transduction**: condition on the demonstration pairs *and* the test input, emit the answer directly, no program object at any point. On ARC-AGI-1 the two are equally good and *not interchangeable* (Chollet et al. 2024, [[wiki/entities/arc-agi.md]]):

| | Best single approach | Solves |
|---|---|---|
| Induction (program search, any flavour) | ≈40% private eval | one set of tasks |
| Transduction (test-time-trained LLM) | ≈40% | a **significantly distinct** set |
| Ensemble of both | 53.5–55.5% | the union — and every 2024 top score is one |

Three things follow, and none of them is comfortable for this page.

- **The disjointness is a fact about the tasks, not about the methods' quality.** Two approaches at the same score solving different problems means the benchmark is not one competence, and nothing routes between them (gap G12). The state of the art pays for both and takes the union.
- **The two are the same operation at opposite settings of one dial** — the *memorization/recombination spectrum* ([[wiki/concepts/test-time-training.md]]): program search does **deep** recombination of a **small** set of generic primitives; test-time training does **shallow** recombination (one gradient trajectory) of a **vast** set of specialised vector functions already in the weights. Cost 1 (somebody authors the library) does not disappear on the transduction side, it becomes invisible: the library is the pretraining corpus, and the priors are supplied as an *augmentation group* rather than as an operation set.
- **The residual advantage of an explicit program is inspectability and reuse, not accuracy.** The transduced answer arrives with no object that can be stored, named, or recombined into the next task's solution — which is why the transduction side has no analogue of library learning and starts every task from the same base weights (gap G14).

---

## The four standing costs

1. **Somebody authors the library — but it is now demonstrably payable.** Every working instantiation *except one* is handed its vocabulary; the one benchmark that forbids this is unsolved by the method it proposes. This is gap G4 (vocabulary co-discovery at scale) in its original clothing. **The exception is [[wiki/entities/neo-neural-theorizer.md]]**, which induces the symbols *and* their operational semantics from i.i.d. observation pairs and recovers primitives that never appear in isolation in training — at the price of synthetic domains, ≤8 primitives, ≤8-step programs and a frozen pretrained encoder. What makes it work is not scarcity of codes (a 6× over-complete codebook is slightly *better*) but two terms: a state-grounding loss forcing intermediate results to stay decodable, and an MDL weight inside a narrow band. The wiki's two partial answers to G4 — an edge alphabet induced from ~2000M video frames ([[wiki/entities/adaworld.md]]) and a node set installed as attractor states ([[wiki/entities/gcq.md]]) — both come from the *continuous* side and neither yields anything a program could be written in. **And the authored end is now measured on ARC itself**: [[wiki/entities/ilp-arc-synthesizer.md]] authors seven predicates, then selects the tasks it reports on by whether they need anything more — which is cost 1 stated as an experimental protocol, and the reason its 5/5 is a claim about the tasks and not about coverage.
2. **Search is intractable, and the remedy is amortization.** Inference over programs is an intractable search in general; [[wiki/concepts/amortized-inference.md]] exists to pay it down — a recognition network proposing hypotheses inside the structured model, or a parametric guess that initializes rather than replaces the relaxation. **The gap this leaves is now measured.** NEO's amortised programmer holds a complete primitive set (primitiveness 1.0) and still scores 0.019–0.038 on 6-step arithmetic programs; sampling 1024 candidates and majority-voting recovers 0.696–0.707 at ~180× inference cost. The vocabulary and the search over it fail *separately*, which means a low benchmark score does not license a claim about the representation ([[wiki/empirical-tensions.md]] T156). **And on the benchmark built for this family, amortisation has not yet paid**: after five years, deep-learning-guided program synthesis and blind brute-force DSL search both score around 40% on ARC-AGI-1 at comparable compute budgets (Chollet et al. 2024). The report's own diagnosis is that the learned component has been put in the wrong place — it writes whole programs, or steers between DSL entries, but nobody has trained a specialist model on the *branching decisions* of the search itself, AlphaProof-style, which is the one variant expected to pull away from enumeration.
3. **The prior is doing unadvertised work, and the direction of the error is now known.** Length is known to be the wrong ranking (ARC step 3), and the wiki now holds one candidate for a *learned* one: **library learning** — DreamCoder abstracts subcomponents shared across previously solved tasks into new primitives, which is heuristic hierarchical Bayesian inference of the prior itself, and LAPS learns that prior jointly with natural-language translations of the programs (Goodman et al. 2024, reporting Ellis et al. 2021 and Wong et al. 2022). The mechanism it proposes — *compression across the solved corpus* — is the opposite sign to the wiki's only measurement of compression pressure on a library ([[wiki/empirical-tensions.md]] T182), and the difference between them is across-task shared-subcomponent abstraction versus within-instance description length. The consequence that survives either way: **adding a learned concept to the library leaves expressivity unchanged and changes which programs are short**, so the inductive bias is a moving target and "the DSL" is not a fixed object. Whatever replaces `2^−l(π)` is where the domain knowledge actually lives. **And the failure is not that length is too weak a bias but that it can be too strong**: NEO's sweep of `λ_MDL^k · ℓ` shows `λ = 1.2` driving primitiveness from 1.000 to 0.213 — a stronger simplicity pressure buys *shorter, entangled* programs, because one code for `Left-Down` is a cheaper explanation than two codes ([[wiki/empirical-tensions.md]] T155). Description length and primitiveness are in tension, and only a band of `λ` gets both. **And a second non-length criterion is now on record, cheap and exactly solvable:** [[wiki/entities/arc-vsa-solver.md]] ranks candidate action sets by a minimum hitting set whose cost counts *distinct operations and operation–parameter pairs used across the whole demonstration set* — "recurring operations and parameters have greater explanatory power". This is still a coding cost, but charged over the demonstrations jointly rather than over one program, so it cannot be evaluated on a single example and it prefers a redundant-looking program that reuses one parameterisation over a shorter one that does not. It is the same quantity [[wiki/entities/corethink-compositional-reasoner.md]] measures as worth +5.5 points when spent as a vote.
4. **Discrete search inherits nothing from the failure of the previous candidate.** A rejected program returns one bit; a gradient returns a direction. This is the standing efficiency argument for the energy reading ([[wiki/concepts/energy-based-models.md]]), where the vocabulary question becomes a *latent-capacity* question with a knob attached — `k` discrete values give at most `k` labels — rather than a discrete-search question with none.

---

## Open Problems

- **~~No ingested machine-learning source in this family.~~ ~~No ARC-specific one.~~** Closed by [[wiki/entities/neo-neural-theorizer.md]] and then by [[wiki/entities/ilp-arc-synthesizer.md]] — which does *not* push cost 1 but pays it in full and reports what that buys (free rejection, typed pruning, 5 hand-picked tasks). `das-2025`, `franzen-2025` and `johnson-2021` are still unread. Original statement: Everything above is second-hand or adjacent, and the gap is an *unread-file* gap rather than an acquisition gap: `raw/` already holds inductive-logic-programming and neurosymbolic attacks on ARC (`rocha-2024-ilp-program-synthesis-arc.md`, `das-2025-compositional-neurosymbolic-arc.md`, `franzen-2025-product-of-experts-arc.md`) and a human-side study of the same task (`johnson-2021-human-program-induction-arc.md`). Until they are ingested the wiki cannot say how far cost 1 has actually been pushed.
- **Nothing scores a program inducer on the aliasing and simultaneity rows.** The two hardness sources with no statement in this vocabulary are also the two the biological evidence is strongest on.
- **~~What a *learned* prior over programs is a function of.~~** One candidate at last: a function of the *solved corpus*, via abstraction of shared subcomponents (DreamCoder), optionally with language as a second channel on the same prior (LAPS). Neither is ingested first-hand, neither is scored against a structural alternative, and both are compression-driven, which T182 says is the disputed part.
- **Whether the library can be grown from a continuous stream.** The wiki's other alphabet-induction results are all over continuous latents; nothing converts them into typed primitives a search could compose. NEO does produce composable typed primitives from a stream in principle — its stated data assumption is `(x_t, x_{t+t'})` with the lag unobserved — but every reported experiment uses a curated pair generator, so the stream case is a claim and not a result.
- **Nothing types the primitives.** NEO's symbols compose by concatenation only: there is no arity, no argument, no binding, so the *non-embeddable symbolic slice* (G11) is untouched by the one system here that learns its own vocabulary.

---

## Connections

- **[[wiki/entities/pcfg-set.md]]** — the behavioural signature of a *non*-program-like solution to a program-like task: feeding a seq2seq model its own intermediate results changes the final answer 41–54% of the time, and functions fail outright on arguments longer than those seen in training, so the model holds length-indexed behaviours rather than operators over variables (G69, G70).
- **[[wiki/concepts/latent-graph-discovery.md]]** — the named rival reduction, stated in full: program ↔ path, DSL ↔ edge vocabulary, library ↔ meta-graph, and the two places the dictionary breaks (binding/recursion on one side, aliasing and simultaneity on the other).
- **[[wiki/concepts/language-of-thought.md]]** — the same reduction with the DSL identified as the mind's own concept format rather than as a modeller's choice; the probabilistic version *is* this page's posterior over programs, and its overgeneration objection is this page's prior problem (G26) in developmental clothing. It also supplies the family's formal ceiling from the other direction: **any** computable distribution is a stochastic λ-term, so the program class is never the binding constraint and cost 3 is where all the content sits.
- **[[wiki/concepts/universal-induction.md]]** — the limit case: the full computable program class with a length prior, which supplies both the completeness result on the passive slice and the proof that no such guarantee survives on the active one.
- **[[wiki/entities/aixi.md]]** — the ceiling as an agent, and the source of the two corrections this page carries: uncomputability is removable, the active wall is not, and short ≠ navigable.
- **[[wiki/entities/bayesian-program-learning.md]]** — the worked tractable instantiation: hand-restricted program space, learned primitive library, one-shot results, and the honest admission that the relation types are given by the prior.
- **[[wiki/entities/arc-agi.md]]** — the benchmark built to forbid the one step every instantiation relies on (authoring the library), and the source of the concession that ranking by description length is insufficient.
- **[[wiki/concepts/compositionality.md]]** — what program re-use *is*: productivity by recombination of parts, with the ARC solver making it the evaluation criterion rather than an emergent property.
- **[[wiki/concepts/amortized-inference.md]]** — the standing remedy for cost 2: compile the expensive posterior over programs into a fast proposer, at the price of a recognition net only as good as what it was trained on.
- **[[wiki/concepts/energy-based-models.md]]** — the continuous competitor for the same job: an edge label and a latent variable are the same free variable, so vocabulary size becomes a capacity knob a regulariser can turn instead of a discrete space a search must enumerate.
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the one route in the wiki where the symbols the program is written over are induced from intervention outcomes rather than authored, which is a partial answer to cost 1 on the robotic slice.
- **[[wiki/concepts/subgraph-matching.md]]** — the retrieval half of the same architecture: before a library entry can be recombined it must be *found* and aligned, which is NP-complete in general and is what order-embedding matching approximates.
- **[[wiki/concepts/causal-model-building.md]]** — why the program form is chosen over a discriminative one: parameterizing a concept by its production process makes appearance-only rules inexpressible, at the cost of needing causal (e.g. stroke) data.
- **[[wiki/entities/neo-neural-theorizer.md]]** — the family's first ingested primary source and the one instantiation that authors nothing: symbols from a VQ codebook, semantics from a shared executor, program length from MDL, all fitted to raw observation pairs — which converts costs 1–3 from standing objections into measured trade-offs.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the shared algorithmic-information vocabulary: generalization difficulty and program length are the same measure, which is why this family and the wiki's scoring function come from one tradition.
- **[[wiki/entities/ilp-arc-synthesizer.md]]** — the family's authored-library corner worked on ARC, and the one instantiation whose rejector is free: negatives are the objects its own clauses generate but the output lacks, and inconsistent theories (two colours in one cell) are discarded without consulting the target at all.
- **[[wiki/concepts/external-verification.md]]** — costs 2 and 4 restated as a design axis rather than an objection: the ladder of acceptance tests is graded by how many bits a rejection returns, process-level scoring is what lifts it above one, and the survey it comes from reads the whole history of machine mathematics as generation plus a progressively stronger external check (Raiyan et al. 2026).
- **[[wiki/entities/arc-vsa-solver.md]]** — the family run inside a vector-symbolic algebra: an authored DSL searched per task, but with two of the four costs visibly moved — selection by cross-demonstration *reuse* instead of program length (cost 3), and search pruned by graded similarity reads instead of enumeration (cost 2) — while cost 1 is paid in full and stated as the reason the system is not an AGI solution.
- **[[wiki/entities/corethink-compositional-reasoner.md]]** — the family's degenerate corner: coarsen the vocabulary until one symbol covers a whole ARC transformation family (22 parameterized macro-patterns with enumerated value menus) and induction collapses into classification — cost 2 disappears because there is no search, and cost 4 disappears because nothing is ever executed or rejected, at the price of a hard ceiling wherever the macros do not reach.
- **[[wiki/entities/macfac.md]]** — the **tiered identicality** doctrine (Forbus, Gentner & Law 1995): two non-identical relations are matched not by a graded similarity table but by *re-representing* them into a canonical language until a part of them is identical (decomposition, minimal ascension), which makes the choice of primitive vocabulary the load-bearing decision in a matcher exactly as it is in a synthesiser.
- **[[wiki/entities/mlc.md]]** — the case that separates recovering a grammar's *behaviour* from representing its program: a frozen transformer reproduces a latent interpretation grammar's outputs at 100% exact match without ever emitting a rule, so execution accuracy is not evidence that a program was induced — and the same system cannot extrapolate a length the episode sampler never showed it, which is where an explicit program would have been free.
- **[[wiki/concepts/test-time-training.md]]** — the family's measured rival and its mirror image on one dial: deep recombination of few authored primitives against shallow recombination of a vast latent library, equal at ≈40% on ARC-AGI-1, solving disjoint task sets, and state of the art only as an ensemble — which makes cost 1 a choice of *where* to put the authored prior rather than a cost only this side pays.
