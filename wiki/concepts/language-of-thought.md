# Language of Thought (LoT) / Probabilistic Language of Thought (PLoT)

**Thought is conducted in a compositional symbol system with a syntax: a finite stock of concepts, recursively combinable, whose combinations inherit their meaning from their parts. The probabilistic version puts a distribution over expressions in that system, so learning is Bayesian inference over sentences of an internal language.**

The wiki's core framing names *probabilistic language of thought* as one of the rival one-problem reductions to latent graph discovery ([[wiki/concepts/latent-graph-discovery.md]]). This page is that rival stated in full. It is assembled from material the wiki acquired for a different argument — the developmental dispute over where compositional machinery comes from — and its load-bearing content is that **the dispute is not about whether the format exists but about whether it is installed or acquired**, with both horns costed.

> **Provenance.** No *ingested* source is about LoT as a computational proposal. Everything below is folded from Spelke 2022 and Revencu & Csibra 2023 (via [[wiki/concepts/core-knowledge.md]]), Fodor & Pylyshyn 1988 as cited there, and Lake et al. 2017 (via [[wiki/entities/bayesian-program-learning.md]], whose stochastic programs are a PLoT instance in all but name). Fodor 1975 and the probabilistic-programming statements of PLoT are **not** in the wiki, though `raw/goodman-2024-probabilistic-programs-language-thought.md` is present and unread; see Open Problems.

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

- **No ingested primary source.** The wiki holds the *dispute* about LoT without the proposal itself. This costs nothing to fix: `raw/goodman-2024-probabilistic-programs-language-thought.md` is already present and unread, and it is the one file that would replace every second-hand statement on this page with a first-hand one.
- **No substrate.** Nothing in the wiki proposes a neural implementation of variable binding, which is the operation the whole account rests on.
- **No instrument.** Productivity and systematicity are the diagnostics, and no benchmark here measures either — the reason T8 cannot be adjudicated.
- **Whether the prior can carry the pruning load.** PLoT's answer to overgeneration is a prior over expressions. Whether any such prior is learnable from a child's (or an agent's) input, rather than being the innate content the argument was trying to avoid, is unaddressed.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — the named rival reduction, stated in full; it is the account built for the *non-embeddable symbolic slice* that the graph framing lists as its own untested bet, so the two are closer to complementary than competing.
- **[[wiki/concepts/program-induction.md]]** — the same machine with the vocabulary relabelled: a sentence in the language of thought is a program, the conceptual stock is the library, and every objection to one lands on the other — overgeneration *is* the prior-over-programs problem (G26).
- **[[wiki/concepts/core-knowledge.md]]** — the source of the whole dispute: the composition problem, the Spelke / Revencu & Csibra table, the equivocation problem, and the escape hatch that closes.
- **[[wiki/concepts/compositionality.md]]** — the mechanism-agnostic statement of what LoT claims is achieved by syntax; productivity and systematicity are its diagnostics on both pages.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the mechanistic rival to a syntax: compose by relaxation into a joint free-energy minimum with the relative spatial encoding as the binding term, requiring no shared symbolic format — and buying consistency rather than truth.
- **[[wiki/entities/bayesian-program-learning.md]]** — a PLoT instance in all but name: a prior over structured expressions (parts, sub-parts, relations) with concepts as posterior programs, and the wiki's one demonstration that the format pays in sample efficiency.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the competing answer to "what is a concept stored as": a position in a relational code, invariant to content, which supports transfer and path consistency but has no binding operation.
