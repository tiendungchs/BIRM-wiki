# Language of Thought (LoT) / Probabilistic Language of Thought (PLoT)

**Thought is conducted in a compositional symbol system with a syntax: a finite stock of concepts, recursively combinable, whose combinations inherit their meaning from their parts. The probabilistic version puts a distribution over expressions in that system, so learning is Bayesian inference over sentences of an internal language.**

The wiki's core framing names *probabilistic language of thought* as one of the rival one-problem reductions to latent graph discovery ([[wiki/concepts/latent-graph-discovery.md]]). This page is that rival stated in full. It is assembled from material the wiki acquired for a different argument — the developmental dispute over where compositional machinery comes from — and its load-bearing content is that **the dispute is not about whether the format exists but about whether it is installed or acquired**, with both horns costed.

> **Provenance.** **Goodman, Gerstenberg & Tenenbaum 2024** (`raw/goodman-2024-probabilistic-programs-language-thought.md`, ch. 18 of *Bayesian Models of Cognition*) is the first-hand statement of the PLoT hypothesis and the source of everything in *The formal core* and *What the formalism buys* below. One ingested source also **builds** an instance: [[wiki/entities/neo-neural-theorizer.md]] names its VQ codebook a *learned Language of Thought* and is the first machine in the wiki whose vocabulary, syntax and semantics are all fitted rather than stipulated. The developmental dispute is folded from Spelke 2022 and Revencu & Csibra 2023 (via [[wiki/concepts/core-knowledge.md]]), Fodor & Pylyshyn 1988 as cited there, and Lake et al. 2017 (via [[wiki/entities/bayesian-program-learning.md]], whose stochastic programs are a PLoT instance in all but name). Fodor 1975 is still not in the wiki.

---

## The commitment

| Element | LoT statement |
|---|---|
| **Format** | Discrete, typed, recursively structured expressions — not vectors, not positions in a space |
| **Semantics** | Compositional: the meaning of a complex expression is a function of its parts and their arrangement |
| **The two diagnostics** | **Productivity** (unboundedly many novel thoughts from finitely many primitives) and **systematicity** (representing `X prefers Y` guarantees representing `Y prefers X`) — Fodor & Pylyshyn 1988 |
| **What learning is** (PLoT) | Inference over expressions: a prior over well-formed formulae plus a likelihood, so a concept is a *posterior over sentences*, not a decision boundary |
| **What is innate** | Contested — this is the whole live question (see below) |

The systematicity diagnostic is what the wiki elsewhere uses to separate real composition from association: animals combine core representations, but the combination is *neither productive nor systematic*, and being able to represent `X prefers Y` does not guarantee the converse ([[wiki/concepts/core-knowledge.md]]). Humans, alone, get productivity.

---

## The formal core

**The whole system is the λ-calculus plus one binary coin.** Terms are `v`, `(λ(x) M)`, `(M N)`, and `(M ⊕ N)`; reduction is α-conversion, β-reduction, η-conversion, and **choice-reduction** — replace `(M ⊕ N)` by one side uniformly at random. The distribution a term induces is

`µ_M(N) = Σ_{r ∈ R_{M,N}} 2^(−C(r))`

where `R_{M,N}` is the set of finite reduction sequences from `M` to `N` and `C(r)` counts choice-reductions. If `Σ_N µ_M(N) = 1` the term **represents** that distribution; a term with uncountably many non-halting reduction sequences represents a sub-distribution and nothing else. Reduction order is not free as it is in the deterministic calculus — Church–Rosser fails once `⊕` is present (`((λ(x)(= x x)) (0 ⊕ 1))` is always true under call-by-value and sometimes false otherwise), so **eager evaluation is a semantic commitment, not a convention**.

| Result | Statement | What it settles |
|---|---|---|
| **Lemma** | Every computable Bernoulli distribution is a stochastic λ-term: `(flip p)` is `(L p 0)`, a recursion that compares a lazily-sampled uniform against `p` digit by digit, halting at the first disagreement | A biased coin of arbitrary computable weight is built from unbiased ones — arbitrary primitive distributions need not be primitive |
| **Theorem** | Any computable distribution is represented by some stochastic λ-term | The model class is closed at exactly the computability boundary |
| **Thesis (Universality)** | Any computable probabilistic *model* is a stochastic λ-term. A thesis rather than a theorem because "computable probabilistic model" is deliberately left open — the Church–Turing thesis for probability | **Expressivity is free.** Every empirical commitment therefore lives in the prior and the inference schedule, never in the model class |

### Conditioning needs no new operator

`query` is **definable inside the language**, as a rejection-sampling recursion:

`(define (condition dist pred) (define sample (dist)) (if (pred sample) sample (condition dist pred)))`

- **Inference is an expression, not a machine bolted onto the representation.** The closure property that makes the language universal also makes it closed under conditioning — so a model *of an inferring agent* is a term like any other, which is what makes §1 below possible at all.
- **Definition ≠ implementation.** Rejection sampling *defines* `query`; Metropolis–Hastings, sequential Monte Carlo, Hamiltonian Monte Carlo, exact enumeration and neural variational encoders all *implement* it ([[wiki/concepts/amortized-inference.md]]). Reading the definition as the algorithm is what makes the account look absurdly expensive.
- **One bit per rejection is the semantics' own cost.** Cost 4 of [[wiki/concepts/program-induction.md]] — a rejected candidate returns one bit where a gradient returns a direction — is not an incidental property of discrete search. It is what conditioning *is*, before any implementation improves on it.

### The three non-λ additions, and why they matter more than they look

| Construct | What it is | Why it is load-bearing |
|---|---|---|
| **ERPs** | Elementary random procedures replacing `⊕`: `(flip 0.7)`, `(gaussian 10 3)`. Every call resamples | Fresh randomness per call is what makes a function a *distribution over executions* rather than a value |
| **Symbols / `gensym`** | Values whose only property is self-equality (`(equal? 'bob 'bob)`), mintable during execution | Individuation without declaration — an identity token to hang properties on, created at first mention |
| **`mem`** | Wrap a function so its random choice is made once per distinct argument and cached thereafter | **Persistence.** `(define strength (mem (λ (person) (gaussian 10 3))))` is what makes "Bob's strength" a property of Bob rather than a fresh draw each time he is asked about |

`mem` + `gensym` is the wiki's cleanest statement of a mechanism it has repeatedly said nobody supplies: **a Church program is a specification from which infinitely many different Bayes nets can be built.** A Bayes net declares `strength-of-bob` in advance and is finite; a Church program instantiates the variable on first mention and is not. Productivity, in this formalism, is *unbounded random-variable creation with persistent identity* — operationally an allocation-on-demand associative store keyed by a symbol. Recorded as gap G69.

---

## What the formalism buys

### 1. Nested query — inference about inference

Because `query` is a term, one `query` may appear inside another and the nesting is formally well-defined. This is the general pattern for intuitive psychology (Stuhlmüller & Goodman 2014):

- `(define (choose-action goal? transition state) (query (define action (action-prior)) action (goal? (transition state action))))`
- `(define (inferred-goal? action transition state) (query (define goal? (goal-prior)) goal? (equal? action (choose-action goal? transition state))))`

- **Inferential-role semantics for belief–desire concepts falls out.** A *goal* is a predicate over world states that governs action choice; a *belief* is the `transition` function the agent's planning query conditions on. Neither is defined by its content; each is defined by its position in an inference. This is what the page's "semantics" row looks like when written down.
- **Rationality becomes a term in the model rather than a hyperparameter of one.** In the tug-of-war extension, laziness stops being `(flip 0.1)` and becomes an embedded query whose action-prior parameter `L` encodes a principle of efficiency — the same job done by the single scalar `β_n` in [[wiki/entities/hbtom.md]], one level of description up.
- **Nobody in the wiki runs the recursion past one level, or reports its cost** ([[wiki/empirical-tensions.md]] T183).

### 2. Counterfactuals as re-execution of a conditioned trace

The three-step algorithm, of which the wiki was carrying only the middle step:

1. **Condition every random choice in the program** on what actually happened — recover the execution trace of the actual world.
2. **Intervene** mid-execution: set a function's input to the counterfactual value, breaking the normal control flow.
3. **Re-evaluate everything downstream** of the intervention point; repeat for a distribution over counterfactual worlds.

Judgements of actual causation then track the probability that the candidate cause was **necessary** — that the outcome, which did occur, would not have occurred without it (Gerstenberg et al. 2021: identical ball trajectories, judgements flipping with the position of an off-path brick or the on/off state of a teleport, so the difference is carried entirely by the counterfactual and not by the observed motion).

**What makes this possible is the execution trace, not the distribution.** A monolithic `p(x)` records no steps, so there is nothing to intervene on. This is a sharper reason to prefer the program form than the compositionality argument usually given.

### 3. The quantitative case, and where it actually comes from

| Study | Fit |
|---|---|
| Ping-pong tournaments, single- and two-player, 20 trial patterns (Gerstenberg & Goodman 2012, Exp. 1) | `r = .98` on mean strength judgements; median `r = .92` against **individual** participants |
| Same, plus a truthful commentator reporting who was lazy in which match (Exp. 2) | `r = .97` mean; median `r = .86` individual |

The individual-level correlations are the load-bearing numbers: the fit is not an aggregation artefact.

**But the fit is bought by four authored lines, not by universality:** `strength` (memoized Gaussian), `lazy` (memoized flip), `teamstrength` (sum with a ½ penalty for laziness), `winner` (comparison). Those four cover arbitrary team sizes, players never previously mentioned, asymmetric 3-vs-6 matches, and conditions compounded out of inequalities between *latent* strengths — and the modeller wrote them. **The universality theorem does no work in any reported result.** Same split the wiki already records for [[wiki/entities/aixi.md]]: a completeness result on one side, all the empirical content in a hand-authored restriction on the other.

### 4. The effective language of thought changes with learning

Concept learning is program induction: a stochastic **program-generating program** proposes candidate expressions composed from the primitives learned so far, and learning is `query` for the expression whose output matches the examples. The consequence to carry:

> Adding a learned concept to the library leaves mathematical expressivity **unchanged** and changes which thoughts are *short*. The prior over programs — and therefore the inductive bias — evolves with the library, so concepts unreachable for a naive learner become cheap later. Proposed as a driver of both cognitive development and adult expertise (Rule, Tenenbaum & Piantadosi 2020).

- **DreamCoder** (Ellis et al. 2021) abstracts subcomponents shared across previously solved tasks into new library entries — heuristic hierarchical Bayesian inference of *the prior itself*, and the only concrete proposal the wiki holds for gap G26 (a *learned* prior over programs). Its claim that compression over solved tasks yields good primitives conflicts head-on with the wiki's only measurement of a length prior's effect on primitiveness ([[wiki/empirical-tensions.md]] T182).
- **LAPS** (Wong et al. 2022) learns a joint prior over programs **and their natural-language translations**. This is a third position in this page's own installed/acquired dispute: language is neither the source of the compositional format (Spelke) nor irrelevant to it (Revencu & Csibra) — it is a **second observation channel on the prior**. That is a buildable reading of bootstrapping, and the first one the wiki holds.
- **Atoms first is allowed.** The PLoT view is explicitly compatible with concepts starting as unanalysed placeholder symbols — prompted by hearing a new word — that accrete causal content later. `gensym` is that operation, which means the format does not require a concept to be defined before it can be referred to.


---

## Relation to the other three rival reductions

**PLoT and program induction are the same machine with different labels on one part.** A stochastic program over primitives *is* a sentence in a language of thought; a library of primitives *is* the conceptual stock. The difference is whose choice the vocabulary is: [[wiki/concepts/program-induction.md]] treats the DSL as a modelling decision the engineer makes, PLoT claims the DSL is a psychological fact about the thinker. This has a consequence the wiki should carry: **every objection to one lands on the other with the terms renamed.** The overgeneration objection below is the prior-over-programs problem (gap G26) in developmental clothing, and the "who authors the library" cost is the innateness question in engineering clothing.

**Against the graph framing**, the translation is worse than program induction's, and informatively so:

| Latent graph discovery | LoT |
|---|---|
| Node | An expression? A proposition? — no stable mapping; propositions are not states one is *in* |
| Edge | Inference step, or a function symbol applied to arguments |
| Composition | Variable binding — the operation the graph vocabulary has no term for |
| Path consistency | Substitution invariance |

This is the **non-embeddable symbolic slice** the graph framing lists as its own untested bet, and LoT is the account built for exactly that slice. Where the graph framing is biologically warranted (metric, transition-sampled structure), LoT has no substrate story in the wiki at all — no cell type, no code, no plasticity rule is anywhere claimed to implement variable binding. The two are close to complementary rather than competing, which is the reason to keep both pages.

**Against free-energy attractor dynamics** ([[wiki/concepts/predictive-coding-free-energy.md]]) the contrast is sharpest, because that page's proposal for composition is *relaxation*: hold two concepts' predictive encodings active and let mutual constraint satisfaction settle into a joint free-energy minimum, with the relative spatial encoding as the binding term ("a ball lies in a bowl": the two temporal interaction predictions cancel, and that cancellation *is* the semantics of "lies"). This needs **no shared symbolic format at all**, only that the fragments predict into each other. It is the wiki's only mechanistic rival to a syntax — and it buys consistency, not truth: a low-energy configuration is a coherent one, not a correct one.

---

## The first machine instance, and what it does to the dispute

[[wiki/entities/neo-neural-theorizer.md]] instantiates the format without taking either horn of the installed/acquired dispute, which is the interesting part.

| LoT element | NEO's realisation |
|---|---|
| Conceptual stock | A VQ codebook `E = {e_1,…,e_{M'}}` of symbols with **no predefined semantics**; `M'` is a hyperparameter and may be 6× the true primitive count without harm |
| Syntax | The theory programmer `q_φ(z_k \| s_k, y)` — a goal-conditioned policy that decides which symbol comes next |
| Semantics | One **shared executor** `f_θ(s, z)`: a symbol means whatever this network does with it, so meaning is *operational* and jointly learned with the syntax |
| Prior over expressions | `λ_MDL^k · ℓ(y, ŷ_k)` — an exponential length penalty, selecting `k*` per instance |
| Productivity | Demonstrated: programs of length 4–8 composed from primitives seen only in length 1–3 programs, 0.845 transfer |
| Systematicity | **Still not tested** — OTIB scores composition coverage, not the `X prefers Y` / `Y prefers X` symmetry |

Three consequences for this page:

- **Neither installed nor acquired-from-language.** The vocabulary is acquired, from raw non-linguistic observation pairs, with no corpus and no teacher. That is a third position the developmental dispute does not contain, and it is available to a machine because a machine can be *given a shared executor* — the thing that forces distinct symbols to have distinct, reusable effects. Whether an infant has an analogue of `f_θ` is exactly the question the dispute is about, and this does not answer it; what it shows is that the format does not need to be either innate or linguistic to be learnable.
- **The prior *can* carry the pruning load — inside a band.** This page's last open problem asks whether a prior over expressions can do the pruning overgeneration demands without being the innate content the argument was avoiding. Here it can: an exponential length prior with one scalar. But the sweep shows the scalar is two-sided — at `λ_MDL = 1.2` the prior prunes so hard that it selects *entangled composites* (primitiveness 1.000 → 0.213), i.e. an over-strong simplicity prior does not merely fail to help, it destroys the vocabulary it was meant to organise ([[wiki/empirical-tensions.md]] T155).
- **The overgeneration argument gets a second, cheaper pruner nobody named.** The state-grounding loss removes from the composition space every expression whose *intermediate* results are not decodable observations. That is not a prior over sentences at all — it is a well-formedness constraint on the execution trace — and removing it collapses the model completely (primitiveness 0.002). **(brainstorm)** If this generalises, the reason a mind never builds most available compositions may be less that they are improbable than that their intermediate states are not states of anything.

---

## The live dispute: installed or acquired (T8)

Full table and evidence: [[wiki/concepts/core-knowledge.md]]. The compressed form, because it is what makes LoT a *design* question rather than a philosophical one:

| | **Acquired** (Spelke 2022) | **Innate** (Revencu & Csibra 2023) |
|---|---|---|
| Where the syntax comes from | The syntax and compositional semantics of a natural language, learned from linguistic input | Core-system outputs are *already* in a common format; a general composer plus logical operators is bolted on top |
| Innate endowment | Language-*learning* capacities only: sensitivity to speech and prosody, an abstract content-word / function-word distinction | Semantics + syntax sufficient to underlie both language acquisition and cross-system composition |
| Fatal objection to the rival | An innate LoT **overgenerates** — the infant could not know which concepts are useful in its culture, which apply in a situation, or which propositions are true: a combinatorial explosion | The language route **undergenerates** — core concepts are taken for granted and so rarely uttered, while logical operators, tense/aspect and modals have no core-system counterpart; the interface is not bidirectional |

Three things the wiki has already extracted from this, and they are the transferable content:

- **The dilemma is symmetric and neither horn is free.** Externally driven composition undergenerates because the supervision does not cover the primitives — what everyone assumes is what nobody says. Internally driven composition overgenerates because nothing explains why only a handful of the astronomically many available compositions are ever built. Spelke's own account inherits the second horn the moment composition is granted, so the explosion is **postponed, not solved** (gap G22).
- **The escape hatch closes.** Language-deprived deaf children reinvent a gestural language, so the needed features may be only those a child can *reinvent* — at which point they are indistinguishable from the pre-linguistic LoT the account was built to avoid.
- **The equivocation problem is the one a builder pays.** If language brings core systems into a common format, then core concepts are of a *different kind* from the concepts used as building blocks, so seeded priors cannot serve as compositional primitives without a translation layer. **No source in the wiki supplies one.** Any architecture that installs priors and expects a general composer over them owes that layer.

**Why the debate is undecidable as currently posed** (T8, `LIVE`): neither side has a criterion separating productive composition from associative combination, so no evidence discriminates them. That is a testable-instrument gap, not a data gap — and it is the same instrument gap that stops the wiki scoring any model on systematicity.

---

## What this decides for a machine

- **Whether the architecture must *contain* a composer or may expect one to emerge.** On the acquired reading, training on a symbolic corpus supplies the machinery, and a large language model is a candidate answer to gap G22 (pruning the composition space) rather than to G21 (performing the composition). On the innate reading it answers neither.
- **(brainstorm, carried from [[wiki/concepts/core-knowledge.md]])** A machine is not forced onto either horn: give it an internal composer *and* an external corpus, and the corpus's job becomes **selection over an internally generated composition space** rather than its source. That reading predicts the thing such a model lacks is the composer, not the pruner — and it is exactly the PLoT shape, with the prior doing the pruning that the overgeneration argument demands.
- **The format decides what a "concept" is stored as**, and therefore what every other mechanism on the wiki must interface with: an attractor ([[wiki/concepts/attractor-dynamics.md]]), a position in a structural code ([[wiki/concepts/abstract-structural-codes.md]]), and a typed expression are three different objects, and only the third supports binding.

---

## Open Problems

- **~~No ingested primary source on the psychological claim.~~** Closed by Goodman, Gerstenberg & Tenenbaum 2024. What it replaced the second-hand statements with is a *computational-level* account and nothing else — see the next two items.
- **No substrate, and the source concedes it.** Church models "are intended to capture the knowledge people use to reason about the world and the inferences supported by this knowledge, but not in any precise way the algorithmic processes underlying inference, much less their neural instantiation." Connecting levels is named as the key future challenge. Three forward pointers are given and none is a result: amortised inference in deep networks (Pyro), programmable inference mixing symbolic and neural motifs (Gen), and **sequential Monte Carlo compiled into the dynamics of biologically realistic spiking neurons** (Bolton, Matheos et al., in prep) — which is the only one that would be a substrate claim, and it is unpublished. Nothing in the wiki proposes a neural implementation of variable binding, the operation the whole account rests on.
- **Universality is inert.** The theorem guarantees the class contains the right model and says nothing about which one, and every reported fit comes from a hand-authored four-line lexicon. An expressivity result cannot be evidence for a psychological hypothesis, and the chapter's own argument for PLoT over rival formalisms is therefore *compositionality and explicit generative structure*, not universality — the same two properties [[wiki/concepts/program-induction.md]] already claims.
- **Nothing sets the depth of nested query.** The formalism permits arbitrary recursion, no reported model uses more than one level, and no cost is stated for going further (T183).
- **No instrument.** Productivity and systematicity are the diagnostics, and no benchmark here measures either — the reason T8 cannot be adjudicated.
- **~~Whether the prior can carry the pruning load.~~** Partly answered in a toy setting: an MDL length prior with one scalar does the pruning, and the scalar has a wrong side ([[wiki/entities/neo-neural-theorizer.md]]). What is unaddressed is whether it scales past ≤8 primitives and ≤8-step programs, and whether anything sets `λ` other than a sweep against ground truth the learner is not supposed to have.
- **No arity, no binding, still.** NEO's expressions compose by concatenation: symbols take no arguments, nothing is bound, nothing recurses. So the machine instance realises the *productivity* diagnostic and not the operation — variable binding — that this page says the whole account rests on.

---

## Connections

- **[[wiki/entities/pcfg-set.md]]** — the negative control for this page's argument, measured: systems with no discrete recombinable expressions fail exactly where a language of thought predicts they should — recombining unseen constituent pairs (0.53–0.72) and traversing a parse tree (0.46–0.59) — while scoring 0.79–0.92 on the task itself.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the named rival reduction, stated in full; it is the account built for the *non-embeddable symbolic slice* that the graph framing lists as its own untested bet, so the two are closer to complementary than competing.
- **[[wiki/concepts/program-induction.md]]** — the same machine with the vocabulary relabelled: a sentence in the language of thought is a program, the conceptual stock is the library, and every objection to one lands on the other — overgeneration *is* the prior-over-programs problem (G26).
- **[[wiki/concepts/core-knowledge.md]]** — the source of the whole dispute: the composition problem, the Spelke / Revencu & Csibra table, the equivocation problem, and the escape hatch that closes.
- **[[wiki/concepts/compositionality.md]]** — the mechanism-agnostic statement of what LoT claims is achieved by syntax; productivity and systematicity are its diagnostics on both pages.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the mechanistic rival to a syntax: compose by relaxation into a joint free-energy minimum with the relative spatial encoding as the binding term, requiring no shared symbolic format — and buying consistency rather than truth.
- **[[wiki/entities/bayesian-program-learning.md]]** — a PLoT instance in all but name: a prior over structured expressions (parts, sub-parts, relations) with concepts as posterior programs, and the wiki's one demonstration that the format pays in sample efficiency.
- **[[wiki/entities/neo-neural-theorizer.md]]** — the first machine instance of the format with nothing stipulated: codebook symbols as the conceptual stock, a goal-conditioned policy as the syntax, a shared executor as the semantics, and an MDL length prior doing the pruning that the overgeneration objection demands.
- **[[wiki/concepts/memory-allocation-excitability.md]]** — the biological counterpart of `mem` + `gensym`: minting a new individual and caching its properties is an allocation problem, solved there by transient excitability and CREB competition, and here by an unbounded symbol table with no capacity limit at all.
- **[[wiki/entities/hbtom.md]]** — the wiki's worked inverse-planning model is the outer half of this page's nested `query` written out with a fixed depth of one: goal prior + rationality scalar + Boltzmann planner, made tractable by conjugacy and a 5-point grid instead of by recursion.
- **[[wiki/concepts/counterfactual-probing.md]]** — supplies the missing first step of that page's operation: a counterfactual is well-defined only against a *conditioned execution trace*, so clamp-and-resample marginalises over the actual world where the three-step algorithm conditions on it.
- **[[wiki/concepts/amortized-inference.md]]** — the reason the rejection-sampling definition of `query` is not a cost estimate: the definition fixes the semantics, and Metropolis–Hastings, sequential Monte Carlo, Hamiltonian Monte Carlo and neural variational encoders all implement the same term.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the competing answer to "what is a concept stored as": a position in a relational code, invariant to content, which supports transfer and path consistency but has no binding operation.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the negative control for the claim that a compositional format can be absorbed from compositional input: models trained on hundreds of millions of natural-language captions recover the lexicon and not the syntax, naming objects at supervised-ImageNet level while scoring at chance on which relation holds between them.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the connectionist answer to Fodor & Pylyshyn's format dilemma: recursively structured typed expressions with compositional semantics realised as one fixed-width distributed vector, so productivity is bought without giving up graded similarity — and structural *alignment* becomes a dot product once role co-occurrence is folded into the code.
- **[[wiki/entities/ilp-arc-synthesizer.md]]** — the overgeneration objection with a dial on it: every body literal added to an induced clause deletes generated objects, so hypothesis specificity is literally clause length, and what sets it is a manufactured negative set rather than a prior.
- **[[wiki/entities/autotom.md]]** — the nested-`query` construction executed rather than defined: recursion to order 4 on Hi-ToM, made linear in depth by sampling *one* state from `b(s)` at each level to stand in for the level below instead of maintaining a nested posterior — which is the first cost figure the wiki has for depth ≥ 2 (T183), and also the first demonstration that the accuracy degrades (95 → 55) while the token count does not explode.
