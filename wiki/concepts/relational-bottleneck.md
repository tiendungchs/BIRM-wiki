# Relational Bottleneck

**Restrict the channel from perception to reasoning so that only *relations between* objects cross it, and never the attributes of any single object. Abstraction then does not have to be learned — it is what the wiring leaves the downstream reader able to represent.**

This is the `L2` move stated in its purest form: the design decision is *what is denied to a reader*. Every result on this page follows from a missing wire rather than from a loss term.

> **Provenance.** Webb, Frankland, Altabaa, Segert, Krishnamurthy, Campbell, Russin, Giallanza, Dulberg, O'Reilly, Lafferty & Cohen, *The Relational Bottleneck as an Inductive Bias for Efficient Abstraction*, Trends in Cognitive Sciences 2024 (`raw/webb-2024-relational-bottleneck-inductive-bias.md`, arXiv:2309.06629v5). **A review: it reports no new experiment.** Every number below is carried second-hand from the primary it cites; the ESBN numbers are the only ones the wiki holds at first hand ([[wiki/entities/esbn.md]]).

---

## The principle

Input `X = (x_1 … x_N)` is a set of objects. A **relational signal** is

```
R = { r(x_i, x_j) }_{i ≠ j}
```

for a relation function `r`. A task is **relational** if some such `R` is sufficient for the target: `X → R → Y`. A relational bottleneck is any mechanism restricting the learned compressed representation `Z = f(X)` to be relational.

The argument is [[wiki/concepts/information-bottleneck.md]] with the search space pre-cut rather than the objective re-weighted:

| IB | Relational bottleneck |
|---|---|
| Minimise `I(X;Z) − β·I(Z;Y)` — needs `p(X,Y)`, intractable at high dimension | Constrain `Z ∈ {relational signals}` architecturally; no estimator, no `β` |
| The minimal sufficient statistic is *found* | The restricted space is **guaranteed to contain** a sufficient statistic for any relational task, and to exclude most representations carrying extraneous information about `X` |
| Compression is necessary for generalization (finite-sample bound in `K ≈ 2^{I(X;Z)}`) | The same bound, obtained by fiat — the hypothesis space is smaller before a single gradient step |

**The realizing operation is the inner product.** `⟨φ(x_i), φ(x_j)⟩` is relational by construction: it cannot return anything about `x_i` that is not a comparison. Separate encoders `⟨φ(x_i), ψ(x_j)⟩` give asymmetry, and this family is a universal approximator of relation functions (Altabaa & Lafferty 2024), so the constraint costs no expressiveness *over relation functions* while disentangling feature extraction (`φ`, `ψ`) from comparison (`⟨·,·⟩`).

**The negative control the review leans on twice.** Relation Net compares every pair too, but with an MLP whose parameters are fit to the task — pairwise *access* without a relational *bottleneck*. It overfits to perceptual detail and fails out of distribution, which is the wiki's [[wiki/concepts/shortcut-learning.md]] failure appearing as a consequence of what a channel was *allowed* to carry rather than of the training data.

---

## Three instantiations of one constraint

All three: encoder → object embeddings `O` → keys `K`, queries `Q` → relation matrix `R = QKᵀ` → abstract values `V` that depend on `X` **only through `R`**.

| | [[wiki/entities/esbn.md]] (Webb et al. 2021) | CoRelNet (Kerg et al. 2022) | Abstractor (Altabaa et al. 2024) |
|---|---|---|---|
| Where the bottleneck is | Controller has no input line from the encoder; it sees only retrieved keys | The relation matrix is the *whole* interface to the decoder | Relational cross-attention: `QKᵀ` attends over **learned** values, not projected inputs |
| Processing | Sequential; the read is **one row** of the relation matrix per step | Feed-forward, all pairs in parallel | Attention block; composable with ordinary self-attention |
| Relations expressible | Symmetric, one feature dimension | Symmetric, one feature dimension | **Asymmetric** (separate `K`/`Q` projections), **multi-dimensional** (multi-head) |
| Generative? | No (1-of-`k` choice) | No | Yes — sequence-to-sequence |
| Cost paid | Vanishing gradients: one backprop step dilutes over `T` timesteps | None over ESBN; strictly the parallelised form of it | Standard transformer cost |

CoRelNet is the review's clarifying reframe: **ESBN's memory read *is* a single row of a relation matrix**, so a recurrent external-memory model and a feed-forward similarity matrix are one mechanism at different unrollings. This retires the assumption, visible on the ESBN page, that external memory is doing the work — the review states outright that external memory alone does not enforce the bottleneck (standard memory-augmented networks pass perceptual input straight to the controller and need ~an order of magnitude more data), and that the isolation can be had with no external memory at all.

**Higher-order relations by recursion.** Feed the output of one bottleneck into another and the second computes relations *between relations*. Relational convolutional networks (Altabaa & Lafferty 2023) do this hierarchically and are reported to beat both CoRelNet (non-hierarchical relational) and transformers (deep non-relational). This is the wiki's first construction that reaches `n ≥ 3` structure without an `n`-ary comparator — but note what it is: **composition of binary relations**, not estimation of a genuine ternary relation, so `G105`'s measured wall (a Relation Net near chance on ternary tasks whose binary analogues it solves at 100.0) is addressed by stacking, not dissolved.

---

## Two claims about cognition that follow from the constraint

| Claim | Evidence carried by the review |
|---|---|
| **Developmental trajectory, not just endpoint** | Give-N counting: Transformer learns each number in roughly constant time (linear), LSTM in increasing time (exponential), only ESBN shows the human **inductive transition** — slow for `N ≤ 4`, then rapid (Dulberg et al. 2021). The mechanism is explicit: the control pathway learns "stop when the count matches the target", a procedure over a symbol whose *filler* is the target value, so it transfers across values it never saw |
| **Compositionality is the *cause* of capacity limits** | Two representational pools bound dynamically (rapid Hebbian) share a compositional vocabulary by definition, so `blue⊗upper-left` and `blue⊗lower-right` overlap and interfere. Capacity limits in working memory, subitizing and absolute judgment are then the price of the same flexibility that buys abstraction (Frankland, Webb & Cohen 2021) |

The second is the sharper one for this wiki: it turns a capacity limit from a parameter into a derived quantity, and it is the same interference argument [[wiki/concepts/vector-symbolic-binding.md]] prices as superposition crosstalk — arrived at from the cognitive side and read as a *normative* explanation rather than as a defect. Data efficiency is the matching quantity on the benefit side: ESBN learns relational patterns from as few as 4 examples, against ~20 for a young child (Kotovsky & Gentner 1996) and thousands for a standard network.

---

## Where the brain would put it (`L3`/`L4` — no registry row)

The framework needs segregated systems for abstract structure versus concrete entities, and something that binds them.

- **The segregation** is claimed to exist already: parietal cortex for abstract structure (space, events), temporal cortex for concrete entities — the `g`/`x` split of [[wiki/concepts/abstract-structural-codes.md]] read off anatomy.
- **The binder is unsettled, and the review lists three candidates and declines to choose.** (i) *Episodic memory* — rapid hippocampal plasticity binding neocortical features, which is exactly [[wiki/entities/tolman-eichenbaum-machine.md]]'s conjunctive code over medial (structural) and lateral (sensory) entorhinal inputs, and would make ESBN's external memory a hippocampus. Against it: hippocampal damage in developmental amnesia is reported *not* to impair abstract reasoning (Dzieciol et al. 2017). (ii) *Cerebellum*, or any other structure with rapid synaptic plasticity. (iii) *Prefrontal cortex* binding by selective attention or working-memory gating — which fits the lesion record the wiki now holds in force (prefrontal damage severely impairs relational reasoning; Waltz et al. 1999), except that prefrontal involvement may reflect *representing* the abstract structure rather than binding it to content.
- The review's own hedge — that binding may be several mechanisms rather than one — is the honest reading, and the discriminating experiment does not exist.

---

## Open problems

- **The bottleneck is all-or-nothing, and humans are not.** Human reasoning shows **content effects**: the same relational form is easier or harder depending on the entities filling it. A strictly relational channel cannot produce a content effect, because the content never arrives. The review names a *graded* bottleneck — a dial on how much non-relational information passes — as the needed extension, and nothing implements one. This is `G40`'s factorise-versus-entangle dial with the switch located on a wire instead of in a code.
- **The relation vocabulary is still binary and mostly similarity.** Asymmetry and multi-dimensionality are handled; what is not shown is coverage of the space of relations human cognition uses.
- **Nothing here mints a variable.** Abstractor values reference objects by *position* in the simplest scheme, and ESBN's keys are positional by its own PCA — so the abstract side is a slot set, not a variable set, and `G69` is untouched by the whole family.
- **The review omits its strongest result's caveat.** The ESBN generalisation is presented as architectural throughout; the primary's own ablation shows it is at chance on same/different without temporal context normalization (`T322`). A review that carries the claim without the precondition is the mechanism by which an instrument problem disappears from a literature.
- **No parsing, in any of the three.** All architectures receive pre-segmented object embeddings, so the constraint applies to a decomposition that something else supplied (`G75`, `G27`).
- **Orthogonal to core knowledge, by the authors' own statement.** The bottleneck explains domain-general relational induction and says nothing about whether object representations are innate ([[wiki/concepts/core-knowledge.md]]); the review notes object-centric visual processing has already been combined with it.

---

## Connections

- **[[wiki/concepts/information-bottleneck.md]]** — the parent principle with the intractable half removed: IB has to *find* a minimal sufficient statistic by optimising `I(X;Z) − β·I(Z;Y)` against a joint distribution nobody can estimate, while this page pre-restricts the hypothesis space to relational signals, which is guaranteed to contain a sufficient statistic for any relational task and needs no `β`, no estimator and no relevance variable.
- **[[wiki/entities/esbn.md]]** — the wiki's first-hand instance, reframed: the controller's entity-blindness *is* a relational bottleneck, and the memory read is one row of a relation matrix, so the external store is incidental and the isolation of the two pathways is what does the work.
- **[[wiki/concepts/attention.md]]** — a fourth attention variant defined by what its values are made of: self-attention and cross-attention both project the values from the inputs, so perceptual content rides through; relational cross-attention keeps `Q`, `K` perceptual and makes `V` a set of learned vectors, which converts the attention matrix from a routing weight into the entire message.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the same interference accounted for with the opposite sign: superposition crosstalk is a cost to be engineered around there, and here it is the *explanation* of why working memory, subitizing and absolute judgment are capacity-limited — compositional codes are shared by definition, so overlap is the price of flexibility (Frankland et al. 2021).
- **[[wiki/concepts/abstract-structural-codes.md]]** — the split enforced on a wire rather than induced by an objective: the value/control pathway is `g` and the key/perceptual pathway is `x`, with the review's anatomical bet being parietal `g` over temporal `x`, and the honest cost that the split is hand-drawn rather than discovered (`G1`).
- **[[wiki/concepts/analogical-mapping.md]]** — the review's own open conjecture about this wiki's central mechanism: because a relational bottleneck re-represents inputs as patterns of similarity (inner products), it may bias a network toward *learning to implement* structure-mapping rather than having it authored, which would place SME-style mapping downstream of an architectural constraint instead of beside it.
- **[[wiki/concepts/compositionality.md]]** — compositionality priced on both sides at once: the shared vocabulary that lets a code recombine is the same overlap that makes concurrent bindings interfere, so this page derives a capacity bound from the property that page treats as the goal.
- **[[wiki/concepts/shortcut-learning.md]]** — the negative control that makes the constraint load-bearing: Relation Net has pairwise comparison but its comparator is a task-fit MLP, so it can and does encode perceptual detail and fails out of distribution, while an inner product cannot represent a shortcut through an individual object's attributes.
- **[[wiki/concepts/program-induction.md]]** — the reconciliation this page claims: symbolic accounts get data efficiency and pay with intractable search over programs, connectionist accounts get scalable gradient training and pay with data hunger, and an architectural constraint buys the first without giving up the second — no pre-specified primitives, end-to-end differentiable.
- **[[wiki/concepts/working-memory.md]]** — a normative origin for the capacity limit rather than a mechanism for it: the limit is not a slot count or a noise bound but the interference cost of using a compositional vocabulary, so any architecture that gains flexibility by sharing representations inherits a limit of the same shape.
- **[[wiki/concepts/tensor-product-representation.md]]** — the same role/filler factorisation with the binding refused: TPR forms an outer product and pays multiplicatively in dimension, where a relational bottleneck keeps roles and fillers in separate pathways and passes only their inner products, so nothing is ever combined and nothing must be undone.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the brain-side candidate for the missing binder: TEM's hippocampal conjunction of medial-entorhinal structure with lateral-entorhinal sensory content is the mechanism the review nominates for binding abstract to perceptual pathways, which would make an ESBN-style memory a hippocampus — contested by developmental-amnesia evidence that abstract reasoning survives hippocampal damage.
- **[[wiki/entities/lateral-frontal-pole.md]]** — the alternative binder and the one the lesion record supports: prefrontal damage severely impairs relational reasoning, but the review flags the ambiguity this wiki's wave-18 sources sit inside — prefrontal cortex may be *representing* the abstract structure (the value pathway) rather than binding it to content.
- **[[wiki/concepts/core-knowledge.md]]** — declared orthogonal by the authors: the bottleneck explains domain-general relational induction and takes no position on innate object representations, and object-centric processing has already been stacked in front of it, so the two are composable rather than competing accounts of infant competence.
- **[[wiki/entities/recursive-npi.md]]** — the same `L2` denial bought for a different currency: replacing a neural program's two observed values with the single bit `Q(i₁) ≤ Q(i₂)` collapses the space of reachable step inputs to a verifiable size and makes the learned sorter work on arbitrary comparable elements, so the bottleneck buys *provability and type generality*, not sample efficiency.
- **[[wiki/concepts/numerosity.md]]** — the competing account of the ~4-item signature this page explains as binding interference: subitizing is described there as a *separate regime* — an object-file/pointer system that does not obey Weber's law — sitting beside an analogue magnitude code that does, which predicts a discontinuity at the boundary where this page predicts a graded interference cost (Nieder 2016).
