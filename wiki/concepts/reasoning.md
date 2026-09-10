# Reasoning

**Seven definitions in the wiki, of which four are notational variants of one operation — find a path, minimise an energy, induce a program, condition a stochastic program — one is a *precondition* on the representation rather than an operation, one locates reasoning entirely upstream of the other six, and one defines it by an invariance and can therefore only ever falsify. The load-bearing observation: all four operation-definitions take the vocabulary as given, so every "cannot be learned" argument in [[wiki/overview.md]] bites on the definition the wiki does not operate under.**

> **Provenance.** Assembled from wiki material rather than from a new ingest, following [[wiki/concepts/program-induction.md]]. Quoted definitions come from `raw/lecun-2022-autonomous-machine-intelligence.md` §3.1, `raw/holyoak-2012-analogy-relational-reasoning.md`, `raw/mirzadeh-2024-gsm-symbolic-benchmark.md` §4.2 and `raw/pfister-2025-o3-is-not-agi.md`.

---

## The census

| # | Definition | Statement | Held in |
|---|---|---|---|
| **R1** | **Navigation** | Recover a latent relational graph from observations and traverse it; reasoning is path-finding over structure that was never given | [[wiki/concepts/latent-graph-discovery.md]] |
| **R2** | **Constraint satisfaction** | "We use the term *reasoning* in a broad sense here to mean constraint satisfaction (or energy minimization). Many types of reasoning can be viewed as forms of energy minimization" (LeCun 2022 §3.1) | [[wiki/concepts/energy-based-models.md]] |
| **R3** | **Program induction** | Search a space of compositions of primitives for the one that reproduces the observed pairs, then execute it | [[wiki/concepts/program-induction.md]] |
| **R4** | **Probabilistic language of thought** | Thought is a stochastic program; reasoning is conditioning it and reading the posterior | [[wiki/concepts/language-of-thought.md]] |
| **R5** | **Role-based relational inference** | "The core property of role-based relational reasoning is that inferences about elements depend on commonalities (and sometimes differences) in the **roles** they play, rather than solely on perceptual features of individual elements" (Holyoak 2012) | [[wiki/concepts/analogical-mapping.md]] |
| **R6** | **Framing** | Reasoning is the construction of a representation in which a solution can be looked for; what happens afterwards is search | [[wiki/concepts/problem-framing.md]] |
| **R7** | **Invariance (negative)** | Reasoning is whatever survives a content-preserving perturbation. Where it is absent, "models attempt to perform a kind of in-distribution pattern-matching… as no formal reasoning is involved in this process, it could lead to high variance across different instances of the same question" (Mirzadeh et al. 2024) | [[wiki/entities/gsm8k.md]], [[wiki/entities/math-perturb.md]] |

---

## R1–R4 are one definition in four notations

[[wiki/concepts/latent-graph-discovery.md]] already concedes this for R2 — "the energy rival is the closest to a translation rather than a competitor: an edge label and a latent variable are the same free variable, and path search is `argmin` over a sequence of them." Stated as a dictionary, the same holds for all four:

| | The free variable | The operator | What "the answer" is | Where the alphabet comes from |
|---|---|---|---|---|
| **R1** Navigation | An edge sequence | Search over adjacency | A path | The edge vocabulary — hardness source 2, latent by assumption but never *constructed* |
| **R2** Constraint satisfaction | The unobserved components of `y` | `argmin_y F(x, y)` | A configuration | The latent's information capacity — set by discretisation, rank, sparsity or noise |
| **R3** Program induction | A composition of primitives | Posterior search under a length prior | The winning program's output | An authored library (gap `G4`) |
| **R4** Probabilistic LoT | A program with stochastic primitives | Conditioning | A posterior over outputs | The primitive set |

**The last column is the point.** Four notations, four different names for the same missing object, and in every one it is supplied by the designer. R1's edge vocabulary, R2's capacity knob, R3's library and R4's primitives are one variable wearing four costumes — which is why translating between the four buys nothing: the translation is exact precisely on the part that works.

**A caution the dictionary hides.** The four are interchangeable as *specifications* and not as *costs*. R2 can represent a one-to-many transition without predicting it, which R1 stated as an explicit prediction cannot; R3 pays one bit per rejected candidate, which R1 and R2 do not; R4's posterior is a distribution where R1's path is a point. Choosing a notation is choosing which of these is cheap.

---

## R5 is not an operation — it is a condition on the node and edge format

Holyoak's definition names no procedure. It constrains what the objects being reasoned over must be: *inferences depend on the roles elements play, not on their features*. Read against the census, it is a requirement that R1–R4 sit on top of a relational representation rather than a feature vector, and it is the only definition here that can be violated by a system that computes the right answer.

Three things it does to the wiki:

- **It is the strongest available argument for why `g`/`x` factorisation is not optional** — a role is exactly a position defined without reference to its filler, which is [[wiki/concepts/abstraction.md]]'s sense F1.
- **It names the operation the wiki has never built.** Deciding *which* element plays *which* role is analogical mapping, and [[wiki/concepts/analogical-mapping.md]] records that every schema mechanism in the wiki assumes it and none performs it. R5 is therefore a definition of reasoning whose central step is unimplemented here.
- **It has no test.** There is no instrument in the wiki that certifies a representation is role-based rather than feature-based; the format ladder in [[wiki/concepts/abstraction.md]] scores *variables*, and there is no cross-condition generalisation measure for an edge.

---

## R6 is the actual rival, and it is the one the wiki's own arguments are about

R1–R4 are all *optimisation within a representation*: a path over a given adjacency, a minimisation over given variables, a search over a given library. [[wiki/concepts/problem-framing.md]]'s split names that half exactly, and assigns the other half — deciding what the variables are — to nobody. So R6 is not a fifth notation but the complement of the other four.

The consequence for the wiki's central thesis is direct and is not stated on any existing page:

| Argument in [[wiki/overview.md]] | Which half it is about |
|---|---|
| Identifiability — no objective on one environment prefers the structural rule (`G16`) | Framing |
| The simplicity prior identifies a short program, not a factorization of it (`G26`) | Framing |
| Gradient descent optimises weights inside a fixed structure (`G29`) | Framing |
| No quantity is maximised when `g` is path-consistent (`G30`) | Framing |

All four are arguments that the *representation* cannot be obtained by optimisation. None of them is an argument about search. The wiki's four operation-definitions of reasoning are definitions of the half that is not in dispute — which is why "every component is buildable except the factorization itself" and "every benchmark scores optimisation" are the same sentence.

**And the split has been measured once.** [[wiki/concepts/rule-level-evaluation.md]] on ConceptARC: 15.8% of o3's textual answers are correct grids produced by an *unintended* rule (optimisation succeeded inside a framing that fits the demonstrations and is not the one the task was authored around), against 19.6% of visual answers that state the intended rule and produce the wrong grid. One number per half, moving in opposite directions by modality — and the demonstration-pair verifier that makes every retry free is silent on the framing error.

---

## R7 defines reasoning by what it is not, and is the only definition testable on a closed system

Mirzadeh et al.'s move is to hold the reasoning content of a problem fixed and vary only the surface: proper names, then numeric values. Variance across instances of one template is then read as evidence that no content-independent procedure ran. The design is the negative image of family U in [[wiki/concepts/abstraction.md]] — instead of asking whether one concept survives many instantiations, it asks whether one *procedure* does.

| Property | Consequence |
|---|---|
| Needs no access to internals | The only definition here applicable to an API-only system |
| Names varied gives lower variance than numbers varied | The surface features are not equally inert, which is itself a decomposition of where the pattern-match binds |
| **Can only falsify** | Invariance to every perturbation an author thought of is not evidence of a procedure; it is absence of evidence of its absence. Contrast [[wiki/entities/math-perturb.md]], where the perturbation is designed so that the *correct* response is to abandon the framing — a positive test, and one no model performs as a separate step |

---

## System 1 / System 2 — the wiki uses the labels and has never defined them

The pair appears in [[wiki/concepts/analogical-mapping.md]] and in the parse-commitment argument at [[wiki/empirical-tensions.md]] T191, always as an unexplained appeal. Two incompatible operationalisations are available, and the difference matters architecturally:

| Reading | Criterion | Source |
|---|---|---|
| **Architectural** | Mode-1 produces an action directly from perception plus a short-term memory access; Mode-2 runs an *optimisation over the world model* before acting (model-predictive control). The discriminator is **whether an inference-time optimisation loop runs at all** | LeCun 2022 §3.1 |
| **Representational** | System 1 is relational *priming* — similarity computed without correspondence; System 2 is deliberate mapping, which computes the correspondence | Holyoak 2012, via [[wiki/concepts/analogical-mapping.md]] |

These come apart in both directions: a search over object parses is an inference-time optimisation loop (architecturally System 2) that computes no correspondence at all; a one-shot relational retrieval computes a correspondence with no loop. **The architectural reading is the one this page recommends**, because it is checkable from the architecture without a theory of what the system represents, and because it comes with the compilation direction already named — a Mode-2 solution "compiled into a reactive policy module that no longer requires careful planning," which is [[wiki/concepts/amortized-inference.md]] as a definition rather than an analogy.

---

## What this page proposes the wiki commit to

**(brainstorm)** Keep R1 as the operation, because the wiki's instruments are built for it — but with two amendments, both of which change what a page is allowed to claim:

1. **Reasoning, unqualified, means the *pair* — framing then search — and any result is reported against one half.** Every score in the wiki is a search score; saying so per result costs one clause and prevents the standing error of reading an ARC number as evidence about abstraction.
2. **R5 is adopted as a requirement on the graph's format, not as a rival.** Nodes and edges must be role-typed for R1 to be reasoning rather than pattern completion over a lattice — which makes "there is no CCGP for edges" a gap rather than a curiosity.

R2–R4 stay as notations to be chosen per problem by which cost they make cheap, not as competing theories: the dictionary above is exact.

---

## Open problems

- **No definition here covers deduction.** All seven are inductive or abductive: they select a structure that fits observations. Nothing in the wiki defines a truth-preserving step, and no concept page holds logical inference — [[wiki/entities/ilp-arc-synthesizer.md]] and [[wiki/entities/frontiermath.md]] use proof machinery without the wiki ever stating what it is a definition of. **The one empirical constraint the wiki now holds says the missing definition may not need to be a separate one**: in 247 focal-lesion patients, relational syllogisms and visuospatial four-term analogies are damaged by the *same* right frontal network, and the split *inside* deduction does not follow validity — **determinate** items (premises fix one linear ordering) behave like the non-lateralised analogy items, while **indeterminate** items (premises leave two independent relations) are right-lateralised, as is an odd-one-out analogy rule (Mole et al. 2025, [[wiki/entities/lateral-frontoparietal-network.md]]). What the anatomy separates is therefore *how many mutually irreducible structures must be held at once*, not deductive-versus-inductive — which is a load variable this page's R1 already has a place for and a truth-preservation criterion it does not.
- **The framing half has no operation at all.** R6 names a stage and no procedure occupies it (`G73`); the nearest partial mechanisms build *one* element of a representation whose type was chosen in advance.
- **Mode-1/Mode-2 is never reported as a variable.** No entity page in the wiki states whether the system runs an inference-time optimisation loop, though it is the cheapest architectural fact to record and it partitions the entity list.
- **R5 has no instrument.** Certifying a role-based representation is [[wiki/concepts/abstraction.md]]'s format ladder applied to edges, which nobody has built.
- **R7 cannot be strengthened without a framing criterion.** A perturbation test can only ever fail a system; making it positive requires knowing which framing was intended, which is `G17` at the framing level.

---

## Connections

- **[[wiki/entities/lateral-frontoparietal-network.md]]** — the reason this page's missing deduction definition is a smaller hole than it looks: analogy, relational deduction and Raven's matrices depend on one right frontal network in the same patients, and the deficit tracks the number of simultaneously irreducible structures rather than the presence of a truth-preserving step.

- **[[wiki/concepts/latent-graph-discovery.md]]** — definition R1 and the wiki's operating commitment; this page's contribution is that R1 is a definition of the *search* half only, so the core framing's hardness sources 1–6 are all downstream of a representation nothing constructs.
- **[[wiki/concepts/energy-based-models.md]]** — definition R2, and the cleanest statement that the translation to R1 is exact: an edge label and a latent variable are the same free variable, so the choice between them is a choice of which cost (one-to-many transitions, capacity control) is cheap.
- **[[wiki/concepts/program-induction.md]]** — definition R3, and the template this page follows: a rival reduction assembled from existing wiki material and stated as one commitment; its authored-library cost is the vocabulary column of this page's dictionary.
- **[[wiki/concepts/language-of-thought.md]]** — definition R4, the same operation with the answer taken as a posterior rather than a point, which is what makes it the only notation that prices uncertainty over outputs rather than over candidates.
- **[[wiki/concepts/analogical-mapping.md]]** — definition R5's home, and the reason it is the sharpest of the seven: it names the correspondence step as the operation, and records that every schema mechanism in the wiki assumes it while none performs it.
- **[[wiki/concepts/problem-framing.md]]** — definition R6, the only genuine rival on this page: it partitions solving into framing and optimisation and shows that R1–R4 are all the second, which is what makes the wiki's four impossibility arguments arguments about framing.
- **[[wiki/concepts/abstraction.md]]** — the companion census: this page's definitions score an *operation*, that one's score the representation the operation runs on, and R5 is the point where they touch — a role is a position defined without reference to its filler, which is that page's strongest format rung.
- **[[wiki/concepts/rule-level-evaluation.md]]** — the only measurement that separates R6's two halves, and therefore the only place a wiki number is attributable to framing rather than to search.
- **[[wiki/entities/gsm8k.md]]** — definition R7's origin: variance across instances of one template, with names and numbers dissociating, read as evidence that no content-independent procedure ran.
- **[[wiki/entities/math-perturb.md]]** — R7 made positive: the perturbation is built so the correct response is to abandon a framing that no longer applies, which converts an invariance test into a test with a right answer.
- **[[wiki/concepts/amortized-inference.md]]** — the compilation direction of the Mode-2/Mode-1 distinction: an optimisation run at inference is replaced by a network trained to emit its result, which is what makes "System 1" an architectural claim rather than a psychological label.
- **[[wiki/entities/h-jepa.md]]** — the architecture in which R2 is the definition of reasoning and the Mode-1/Mode-2 split is a wiring diagram rather than a metaphor.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the fourth rival reduction named by the core framing, and the one that folds R2's minimisation into a single quantity that also governs perception and action, so that reasoning stops being a separately-defined operation at all.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — what a score means once R6 is accepted: a benchmark that supplies the framing measures skill, and only the developer-aware condition makes a result informative about the half this page says is in dispute.
- **[[wiki/concepts/simulation-based-planning.md]]** — R1 and R2 running forward through a learned model, and the concession that bounds it: simulation restores free trialling only in domains already known well enough to simulate, which is exactly where the framing already exists.
- **[[wiki/entities/frontiermath.md]]** — one of the two pages that run proof machinery the census cannot classify: its problems are graded by a truth-preserving step that none of R1–R7 defines, which is where this page's "no definition covers deduction" reading comes from.
- **[[wiki/entities/ilp-arc-synthesizer.md]]** — the same absence in the other notation: inductive logic programming is R3 written as clause search, and the deductive half of what its solver executes has no definition anywhere on this page.
