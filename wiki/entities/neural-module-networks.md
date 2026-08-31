# Neural Module Networks

**A fixed inventory of small, *typed*, jointly-trained neural modules, assembled into a different computation graph for every input by an external layout predictor; specialisation of each module is never supervised and falls out of end-to-end training plus name-level parameter tying (Andreas, Rohrbach, Darrell & Klein 2016).**

> **Provenance.** `raw/andreas-2016-neural-module-networks.md` (*Deep Compositional Question Answering with Neural Module Networks*, arXiv 1511.02799). Primary source. The wiki takes it as the **first architecture in which the routed unit is a sub-problem rather than a token, the modules carry declared type signatures with arity, and the emergent specialisations are relational** — three things [[wiki/concepts/sparse-expert-routing.md]] reports as absent from the whole mixture-of-experts literature. The visual-QA results are of historical interest only; the architecture is the content.

---

## The architecture

| Component | Definition |
|---|---|
| Module inventory `{m}` | Each with own parameters `θ_m`, indexed by **type** (what it computes) and **instance** (over what content) |
| Layout predictor `P` | String → network. **Not learned.** Stanford dependency parse → filter to the dependencies reachable from the wh-word → strip function words → a symbolic query such as `is(circle, next-to(square))` |
| Assembly | Determined entirely by the query's tree shape: leaves → `attend`, internal nodes → `re-attend` (arity 1) or `combine` (arity 2), root → `measure` (yes/no) or `classify` (otherwise) |
| Objective | Maximum likelihood of the answer. Every assembled graph ends in a distribution over labels, so each layout *is* a probability model |
| Training | One graph per example, tied parameters across graphs; layouts of identical shape batch together |

### The type system — the load-bearing part

```
attend    : Image                → Attention
re-attend : Attention            → Attention
combine   : Attention × Attention → Attention
classify  : Image × Attention    → Label
measure   : Attention            → Label
```

Three data types (Image, unnormalised Attention, Label) and five signatures. **A module's signature is what makes free composition legal** — any two modules whose types agree may be wired together, including in configurations never seen at training time. The authors note that almost all interesting composition occurs in Attention, and concede the architecture could be called an "attention-composition network".

`Attention` is deliberately **unnormalised**, which is why `measure` can answer existence and counting questions: the total mass carries information a softmax would destroy.

### Module bodies

| Module | Implementation |
|---|---|
| `attend[c]` | Convolve every image position with a weight vector distinct per `c` → heatmap |
| `re-attend[c]` | Two-layer ReLU MLP over the flattened attention (hidden width 32), weights distinct per `c` |
| `combine[c]` | Merge two attentions into one |
| `classify[c]` | Attention-weighted average of image features → label distribution |
| `measure[c]` | Attention alone → label distribution |

**The instance labels are notation, not specification.** `attend[cat]` is not initialised as a cat detector and `combine[and]` is not fixed to compute an intersection. Each acquires its behaviour as a by-product of (i) end-to-end likelihood and (ii) the fact that the parser emits the same name in many different layouts, which ties the parameters across those uses. Verified by inspection: `re-attend[above]` shifts activation upward, `combine[and]` intersects.

### The hybrid

The deployed model is **NMN ⊗ LSTM**: the module network's answer distribution is combined with that of a plain single-layer 1024-unit LSTM question encoder by a geometric average, dynamically reweighted from text and image features, trained jointly. Two stated reasons, both about what the parse *throws away*:

- **Syntactic residue** — `what is flying?` and `what are flying?` both parse to `what(fly)`, but the answers are *kite* and *kites*.
- **Semantic prior** — with degraded image features, *what colour is the bear?* should still guess *brown*, not *green*. Dataset bias is real signal and the module network has no channel for it.

---

## Results

**shapes** (synthetic: 244 compositional yes/no questions × 15,616 images of coloured shapes; 2–4 attributes/objects/relations per question; LeNet front end trained jointly):

| | size 4 | size 5 | size 6 | All |
|---|---|---|---|---|
| Majority | 64.4 | 62.5 | 61.7 | 63.0 |
| VIS+LSTM | 71.9 | 62.5 | 61.7 | 65.3 |
| **NMN** | 89.7 | 92.4 | 85.2 | **90.6** |
| **NMN, size-6 layouts removed from training** | 97.7 | 91.1 | **89.7** | 90.8 |

**The last row is the result worth carrying.** Removing every 6-module layout from the training set *raises* size-6 accuracy from 85.2 to 89.7. The model composes at a depth it has never been trained at, and does so better than when the depth was in-distribution — because the parser supplies the structure and the modules only have to be locally correct. This is [[wiki/concepts/compositionality.md]]'s **productivity** facet, measured over layout depth, and passed. The baseline sits at the majority class on the same split.

**VQA** (≈200K COCO images, crowd-sourced questions; frozen VGG-16 conv5):

| | Yes/No | Number | Other | All (test-dev) | All (test) |
|---|---|---|---|---|---|
| LSTM (no image) | 78.2 | 35.7 | 26.6 | 48.8 | – |
| VIS+LSTM | 78.9 | 35.2 | 36.4 | 53.7 | 54.1 |
| **NMN alone** | 69.4 | 30.7 | 22.7 | **42.7** | – |
| **NMN+LSTM** | 77.7 | 37.2 | 39.3 | **54.8** | 55.1 |

**The ablation is more informative than the headline.** NMN alone is beaten by an LSTM that never sees the image (42.7 vs 48.8). All of the architecture's advantage over VIS+LSTM (+1.1) arrives only in the hybrid, and it is localised to Number and Other — precisely the answer types where a bias prior cannot substitute for looking. Structured composition did not subsume the unstructured channel; it was **additive to it and insufficient without it**.

Layout statistics show why the natural-image case is weak: VQA layouts reach max depth 3 and max size 4 over 1,995 module instances, where shapes reaches depth 5 / size 6 over 8 instances. The natural questions barely compose.

---

## What breaks it

| Failure | Evidence in the source |
|---|---|
| **The layout predictor is the bottleneck and is not learned** | Hand inspection of 50 training parses: 80–90% correct for simple object-property questions, degrading sharply on complex ones. *are these people most likely experiencing a work day?* parses to `be(people, likely)` instead of `is(people, work)`. The authors name joint learning of the parser as the fix and do not attempt it |
| **Uncertainty over structure is never represented** | A single layout is committed to before any module runs; no posterior over graphs at training or decoding |
| **Overfitting concentrates in one module** | Yes/No is the one category where the hybrid loses to the sequence baseline, diagnosed from train-set accuracy as `measure` overfitting |
| **Heterogeneous update frequency** | Modules appear in wildly different numbers of layouts, so weights receive gradient at very different rates. Plain SGD performed substantially worse; AdaDelta (adaptive per-weight rates) was required. **A generic tax on any dynamic-layout architecture**, and the reason a rare module cannot be trained alongside a common one under a single learning rate |
| **The type system is closed and authored** | Five signatures over three types, chosen by hand for one task family. Nothing induces a type, an arity, or a new signature |
| **Parse depth is task-tuned** | The traversal distance from the wh-word "varies depending on the task" — shallow expressions for VQA, deeper for shapes |

---

## Reading in the core framing

| NMN component | Latent-graph reading |
|---|---|
| Layout predictor `P` | An *instance-graph proposer* run from language alone, before any observation is consulted — the one architecture here where structure discovery and structure execution are cleanly separated and can be blamed separately |
| Module inventory | The meta-graph's operator vocabulary, given rather than discovered ([[wiki/concepts/program-induction.md]] cost 1, paid in full) |
| Type signatures | The **edge-legality relation** of the meta-graph, stated declaratively — the only architecture in the wiki where "which composition is well-formed" is decidable without running anything |
| Attention maps as messages | The intermediate node values: a partially-evaluated set over image positions, not a label and not a symbol |
| Depth extrapolation | Navigation of a path longer than any traversed in training, which works because path legality is a type check rather than a learned statistic |

**(brainstorm) The reason NMN gets relational modules where a mixture-of-experts router never does.** Both architectures partition parameters and select a subset per input. The differences are exactly two: NMN's routed unit is a *sub-question* rather than a token, and NMN's assignment is supplied by a parser rather than learned from the loss. Either could be the operative one, and no experiment in the wiki separates them. But the type system gives a third candidate that neither literature discusses: **`combine[and]` can only ever be a relation because its signature has arity 2.** A learned router over identical experts has no arity anywhere, so there is no position in the architecture that a relation could occupy even in principle. If that is the operative difference, the fix for the mixture-of-experts finding is not a better router but *heterogeneous experts with declared arities* — which [[wiki/concepts/sparse-expert-routing.md]] lists as unattempted for hardware reasons.

**(brainstorm) "Visual SQL" is an operator-exposure claim (`G99`).** The authors observe that once training is done, the modules can be assembled by any outside caller with no natural language involved — `IS(cat) AND NOT(IS(dog))`, or mixed with non-visual predicates (`IS(cat) and date > 2014-11-5`). This is a learned module's *operation* being invoked by a caller outside the system that trained it, which is what `G99` asks for, and it is stated but never run. What keeps it short of closing the row: the types are closed, so a caller can only ever hand a module an argument of the type it was declared over. The `date > 2014-11-5` example is precisely the case that the type system forbids, and the source does not say how it would be admitted.

---

## Comparison

| System | Structure per input | Who chooses it | Modules typed? | Modules heterogeneous? |
|---|---|---|---|---|
| **NMN** | Yes — a different DAG per question | External parser, **not learned** | Yes, 5 signatures with arity | Yes — 5 distinct computations |
| Recurrent / recursive nets | Yes, but shape only | Input length / syntax | No | No — one cell repeated |
| Memory networks | No — fixed `attend`×k → `classify` | — | Implicitly | No |
| Sparse mixture-of-experts ([[wiki/concepts/sparse-expert-routing.md]]) | Which parameters, not which graph | Learned router (or a hash) | No | No — identical by construction |
| [[wiki/entities/differentiable-neural-computer.md]] | No — fixed controller + addressing | — | No | No |
| [[wiki/entities/neo-neural-theorizer.md]] | Yes — program length chosen per instance by MDL | **Learned**, from observation pairs alone | **No** — concatenation only, no arity | No — one shared executor |

The last row is the informative one: NEO and NMN are the two halves of the same missing system. NEO induces its vocabulary and cannot type it; NMN types its vocabulary and cannot induce it. Nothing in the wiki does both.

---

## Connections

- **[[wiki/concepts/compositionality.md]]** — the productivity facet measured over *layout depth* and passed: withholding all size-6 layouts from training raises size-6 accuracy (85.2 → 89.7), because legality of a composition is decided by a type check rather than by a learned statistic over structures.
- **[[wiki/concepts/program-induction.md]]** — the direct answer to that page's "nothing types the primitives": five signatures over three data types, with arity determining which module a parse node becomes — bought by authoring the type system outright, which is cost 1 paid in full.
- **[[wiki/concepts/sparse-expert-routing.md]]** — the counterexample to two of its open problems at once: the specialisations here *are* relational (`combine[and]`, `re-attend[above]`) and the experts *are* heterogeneous — with the routed unit changed from a token to a sub-question and the router replaced by an unlearned parser, so what buys the difference is unseparated.
- **[[wiki/concepts/attention.md]]** — promotes an attention map from a read-weight to a **first-class typed value** that modules consume and emit; keeping it unnormalised is what lets a downstream module answer existence and counting, which a softmax would erase.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the cleanest separation in the wiki between proposing an instance-graph and executing it: the parser proposes, the modules execute, and the source blames the parser by inspection, which is a diagnosis no end-to-end architecture here can make.
- **[[wiki/entities/neo-neural-theorizer.md]]** — the complementary half: NEO induces a primitive vocabulary from raw observation pairs but composes by concatenation with no arity or binding; NMN has arity and binding by declaration but induces nothing.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the opposite answer to composition over data structures: the DNC keeps one controller and makes *memory* addressable, NMN keeps memory implicit and makes the *computation graph* per-instance — so the DNC's learned program reads as assembly while NMN's is a parse tree by construction.
- **[[wiki/entities/mlc.md]]** — the two routes to compositional generalisation in one architecture class: MLC restructures the *task distribution* and leaves a monolithic seq2seq unchanged, NMN restructures the *architecture* and leaves the training corpus unchanged; both reach depth extrapolation the corresponding baseline fails, and no source compares them.
- **[[wiki/entities/transformer.md]]** — the architecture that absorbed this one's mechanism and dropped its structure: attention as a dense learned adjacency recomputed every layer, with no types, no arity, and no per-input graph — which is why depth extrapolation has to be hoped for there and is guaranteed here.
- **[[wiki/entities/sparsely-gated-moe.md]]** — the same year's opposite bet, and the concrete system behind this page's three-way ambiguity: thousands of identical arity-free experts routed per token by a learned noisy top-`k` gate, whose emergent specialisations are lexical — the contrast that makes granularity, learned-vs-given layout, and declared arity the three candidate explanations for why relational modules appear here and nowhere there.
- **[[wiki/entities/dreamcoder.md]]** — the complement on the typing axis: NMN authors every module signature and gets composition legality as a decidable check, DreamCoder learns its primitives inside a typed λ-calculus but never chooses a new primitive's signature from task demand, so the two halves of "learn the primitives *and* type them" remain in separate papers.
