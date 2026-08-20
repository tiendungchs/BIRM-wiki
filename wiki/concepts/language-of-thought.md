# Language of Thought (LoT) / Probabilistic Language of Thought (PLoT)

**Thought is conducted in a compositional symbol system with a syntax: a finite stock of concepts, recursively combinable, whose combinations inherit their meaning from their parts. The probabilistic version puts a distribution over expressions in that system, so learning is Bayesian inference over sentences of an internal language.**

The wiki's core framing names *probabilistic language of thought* as one of the rival one-problem reductions to latent graph discovery ([[wiki/concepts/latent-graph-discovery.md]]). This page is that rival stated in full. It is assembled from material the wiki acquired for a different argument — the developmental dispute over where compositional machinery comes from — and its load-bearing content is that **the dispute is not about whether the format exists but about whether it is installed or acquired**, with both horns costed.

> **Provenance.** No *ingested* source is about LoT as a philosophical proposal, but one now **builds** one: [[wiki/entities/neo-neural-theorizer.md]] names its VQ codebook a *learned Language of Thought* and is the first machine in the wiki whose vocabulary, syntax and semantics are all fitted rather than stipulated (see below). Everything below is folded from Spelke 2022 and Revencu & Csibra 2023 (via [[wiki/concepts/core-knowledge.md]]), Fodor & Pylyshyn 1988 as cited there, and Lake et al. 2017 (via [[wiki/entities/bayesian-program-learning.md]], whose stochastic programs are a PLoT instance in all but name). Fodor 1975 and the probabilistic-programming statements of PLoT are **not** in the wiki, though `raw/goodman-2024-probabilistic-programs-language-thought.md` is present and unread; see Open Problems.

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

- **No ingested primary source on the psychological claim.** The wiki holds the *dispute* about LoT without the proposal itself. This costs nothing to fix: `raw/goodman-2024-probabilistic-programs-language-thought.md` is already present and unread, and it is the one file that would replace every second-hand statement on this page with a first-hand one.
- **No substrate.** Nothing in the wiki proposes a neural implementation of variable binding, which is the operation the whole account rests on.
- **No instrument.** Productivity and systematicity are the diagnostics, and no benchmark here measures either — the reason T8 cannot be adjudicated.
- **~~Whether the prior can carry the pruning load.~~** Partly answered in a toy setting: an MDL length prior with one scalar does the pruning, and the scalar has a wrong side ([[wiki/entities/neo-neural-theorizer.md]]). What is unaddressed is whether it scales past ≤8 primitives and ≤8-step programs, and whether anything sets `λ` other than a sweep against ground truth the learner is not supposed to have.
- **No arity, no binding, still.** NEO's expressions compose by concatenation: symbols take no arguments, nothing is bound, nothing recurses. So the machine instance realises the *productivity* diagnostic and not the operation — variable binding — that this page says the whole account rests on.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — the named rival reduction, stated in full; it is the account built for the *non-embeddable symbolic slice* that the graph framing lists as its own untested bet, so the two are closer to complementary than competing.
- **[[wiki/concepts/program-induction.md]]** — the same machine with the vocabulary relabelled: a sentence in the language of thought is a program, the conceptual stock is the library, and every objection to one lands on the other — overgeneration *is* the prior-over-programs problem (G26).
- **[[wiki/concepts/core-knowledge.md]]** — the source of the whole dispute: the composition problem, the Spelke / Revencu & Csibra table, the equivocation problem, and the escape hatch that closes.
- **[[wiki/concepts/compositionality.md]]** — the mechanism-agnostic statement of what LoT claims is achieved by syntax; productivity and systematicity are its diagnostics on both pages.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the mechanistic rival to a syntax: compose by relaxation into a joint free-energy minimum with the relative spatial encoding as the binding term, requiring no shared symbolic format — and buying consistency rather than truth.
- **[[wiki/entities/bayesian-program-learning.md]]** — a PLoT instance in all but name: a prior over structured expressions (parts, sub-parts, relations) with concepts as posterior programs, and the wiki's one demonstration that the format pays in sample efficiency.
- **[[wiki/entities/neo-neural-theorizer.md]]** — the first machine instance of the format with nothing stipulated: codebook symbols as the conceptual stock, a goal-conditioned policy as the syntax, a shared executor as the semantics, and an MDL length prior doing the pruning that the overgeneration objection demands.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the competing answer to "what is a concept stored as": a position in a relational code, invariant to content, which supports transfer and path consistency but has no binding operation.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the negative control for the claim that a compositional format can be absorbed from compositional input: models trained on hundreds of millions of natural-language captions recover the lexicon and not the syntax, naming objects at supervised-ImageNet level while scoring at chance on which relation holds between them.
