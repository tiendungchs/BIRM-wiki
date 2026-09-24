# Causal Scrubbing

**Test a stated hypothesis about *how* a network computes a behaviour by resampling every activation the hypothesis says is interchangeable, all at once, and measuring how much of the behaviour survives. A hypothesis passes if the scrubbed model performs as well as the original one.**

> **Provenance.** Chan, Garriga-Alonso, Goldowsky-Dill, Greenblatt, Nitishinskaya, Radhakrishnan, Shlegeris & Thomas 2022 (`raw/chan-2022-causal-scrubbing-testing-interpretability-hypotheses.md`), Redwood Research, AI Alignment Forum; main post of a four-post sequence. The appendix and the two worked-results posts are not in `raw/`. The clip dropped the inline math, so the notation below is reconstructed from the pseudocode. Every number is from that source.

---

## The object tested: a hypothesis as a graph correspondence

A hypothesis for behaviour `f` on dataset `D` is a triple `h = (G, I, c)`:

| Component | Constraint | Role |
|---|---|---|
| `G` — computational graph of the model | Extensionally equal to the model on all of `D` | The model rewritten at a chosen granularity (heads, residual-stream terms, positions) |
| `I` — interpretation graph | Single input and output node, mapped input→input and output→output | The human-readable algorithm, e.g. "A = `x₀ > 3`, B = `x₁ > 3`, D = A ∨ B" |
| `c : I → G` | **Injective graph homomorphism**: an edge in `I` must be an edge in `G` | Claims which model node computes which interpretation node. The image of `I` is a union of input→output paths in `G` |

The quantity explained is `E_D[f]`, usually the model's loss on `D`. Choosing `D` chooses the behaviour. For example, a dataset of `…AB…A → B` prompts isolates induction.

**Read in the wiki's terms:** `I` is a latent computational graph, and `c` claims that the model instantiates it. A scrubbing test therefore scores a *named* graph against a trained network. That is the re-representation half of [[wiki/concepts/latent-graph-discovery.md]], not the discovery half.

---

## The algorithm

The hypothesis works as an **intervention blacklist**. Any activation swap the hypothesis does not rule out is allowed, and the test performs as many swaps as it permits.

| Swap type | Rule | Example |
|---|---|---|
| **Semantically equivalent subtree** | Replace the activation at `c(n_I)` with its value on another input `x′` where `n_I(x′) = n_I(x)` | A = `x₀ > 3` is true for both (5,6,7) and (8,0,4), so A's activation on one may stand in for the other |
| **Unimportant parent** | Any parent of a `G` node that has no preimage under `c` is fed from a random `x″ ∈ D`. All unimportant parents of one node share the same `x″` | C, and the unused input components into A and B, are all resampled |

Run recursively from the output toward the input. The graph is **treeified**: each input→output path gets its own copy of the input, so one node can receive the reference input along one path and a resampled input along another. A single scrubbed forward pass on the final paren-balancer hypothesis combines up to 51 different inputs.

```
run_scrub(n_I, x):
    n_G = c(n_I);  if input: return x
    x_rand = sample(D)
    for p in parents(n_G):
        if p ∈ c(parents(n_I)):  inputs[p] = run_scrub(c⁻¹(p), sample{x' : c⁻¹(p)(x') = c⁻¹(p)(x)})
        else:                    inputs[p] = p.value_on(x_rand)
    return n_G(inputs)
```

**Score:** percentage of loss recovered = `(L_perm − L_scrub) / (L_perm − L_model)`. 100% is the unmodified model's loss, and 0% is the loss with labels randomly permuted.

### Why resample instead of zeroing

A claim that "module M is unimportant" does **not** mean M's activations are unused, since replacing them with huge values or NaN would break any model. It means M carries **no input-conditional information** relevant to the task. Swapping in M's activation from a random other input tests exactly that: the activation distribution is preserved and its link to the current input is cut.

| Ablation | Tests | Defect |
|---|---|---|
| Zero | "M's output could be 0" | Takes the model off distribution in an unprincipled way, has unpredictable effects on the measured score, and removes variance |
| Mean | "M's output could be constant" | Same three defects |
| Gaussian noise (causal tracing) | Corruption of M | Off-distribution, and has no effect wherever the activation scale is much larger than the noise |
| **Resampling** | "M's input-specific content is irrelevant" | Needs a dataset with enough coverage to sample from |

This is a claim about **which ablation operationalises "irrelevant"**. It applies to every ablation-based use claim in the wiki, including module lesions in [[wiki/concepts/arbitrary-sensorimotor-mapping.md]] and [[wiki/gaps/g109.md]]'s two-lesion profile.

---

## Evidence

### Paren-balance checker (small transformer, normal-model loss 0.0003)

| Claim tested | Content | Loss recovered |
|---|---|---|
| 1 | Heads 1.0 and 2.0 compute (equal count ∧ starts with `(`); head 2.1 computes (nesting depth never negative); all other residual terms are unimportant | **93%** |
| 1 + 2 | Heads 1.0 and 2.0 read only position 1, which depends on head 0.0's open-proportion (written linearly along one direction) plus the position-1 embedding | 88% |
| 1 + 3 | Head 2.1 reads every position's right-to-left depth sign | 84% |
| 1 + 2 + 3 | All claims together | **72%** |

The score falls as the hypothesis becomes more specific, because more specific claims permit more swaps, stacked several layers deep. So recovered loss measures **specificity × correctness**, not correctness alone. A vaguer hypothesis scores higher by claiming less.

### Induction in a two-layer attention-only language model (OpenWebText, filtered to prompts ending in tokens where 2-token induction beats bigram statistics)

| Hypothesis | Loss recovered |
|---|---|
| Naive: the query and value of a layer-1 induction head come only from token embeddings; the key comes only from the layer-0 previous-token term | **35%** |
| + attention compares a 3-token window, not 1 token<br>+ query and value may also read the layer-0 current-position term<br>+ three layer-0 heads that attend to repeats of the current token are modelled as if their attention were the identity | **86%** |

The textbook induction circuit explains about a third of the induction behaviour. Most of the remainder sits in additional pathways that the textbook description omits.

---

## Limitations the source states

| # | Limitation | Consequence for a reasoning-model builder |
|---|---|---|
| L1 | **Only exact equivalence classes.** A swap is allowed only if the inputs agree *exactly* on the interpretation node, yet hypotheses that do not fully preserve performance are accepted anyway, which the authors call an inconsistency | Continuous features (a position, a magnitude, a graph distance) cannot be tested. The proposed fix, a non-uniform distribution over swaps ("generalized causal scrubbing"), makes the hypothesis space continuous and searchable by SGD, but has no principled union operation |
| L2 | **The test is bounded by dataset coverage.** Agreeing inputs are found by rejection sampling from `D`, so a hypothesis about a rare conjunction has no swap partners | Hypotheses about the long tail, where out-of-distribution reasoning happens, cannot be tested this way. A generator that produces agreeing inputs would lift the bound |
| L3 | **Perfectly correlated features are indistinguishable.** They induce the same equivalence classes, so an A-detector mislabelled as a B-detector passes | This is the identifiability limit of every probe in [[wiki/concepts/representation-probing.md]], restated for mechanisms. Only a dataset that decorrelates the features, like that page's confound-dissociation row, separates them |
| L4 | **Can accept an incomplete hypothesis: omitted inhibition.** If a model suppresses a heuristic where it does not apply (for example, negative name-mover heads in the Indirect Object Identification (IOI) circuit), a hypothesis that omits the suppressor over-credits the heuristic on inputs where the heuristic is right | A passed test does not show that the named circuit is the *only* one running. This is [[wiki/tensions/t158.md]]'s parallel-circuit problem appearing inside the instrument |
| L5 | **Can accept an incomplete hypothesis: scrubbed correlations.** Resampling two correlated terms independently lowers the variance of their sum. If that variance was harmful interference (for example, from polysemanticity), the wrong hypothesis *improves* the score | Recovered loss can exceed what a correct hypothesis would earn. The score is not monotone in correctness |

The authors' framing is that interpretability is **defeasible reasoning**: a passed test can be overturned by a more specific counter-hypothesis. Their proposed repair is an **adversary** who refines the hypothesis in whichever direction most changes the scrubbed behaviour, which forces the hypothesis to name every mechanism that matters. This is untested in the source.

---

## Relevance to building a reasoning model

- **It is the only instrument in the wiki whose input is a whole algorithm rather than a single feature.** A linear probe tests one variable at a site, while activation addition and amnesic erasure each test one direction. Scrubbing tests a graph of intermediate variables *and* the claim that nothing else matters. This makes it the natural acceptance test for an `L1` decomposition claim, such as "this module computes the structural code `g` and that one the content `x`", which the wiki currently certifies only by diagrams ([[wiki/gaps/g109.md]]).
- **Specificity is priced.** Every claim added to a hypothesis costs recovered loss unless the claim is right, so a hypothesis ladder (1 → 1+2 → 1+2+3) makes it possible to see *which* claim lost the points. The 93 → 72 ladder is the pattern to copy.
- **Per-subset scoring is built in.** `D` defines the behaviour, so running the same hypothesis on two subsets gives two scores. **(brainstorm)** This is the missing experiment for [[wiki/tensions/t158.md]]: scrub OthelloGPT under the hypothesis "legal moves are computed only from the board direction", separately on opening and end-game positions. If recovery falls on end games, the parallel cheap circuit is carrying load there. The approach inherits L4, so the complementary hypothesis, which names the cheap features, must be scrubbed as well.
- **Path-wise resampling is a machine analogue of disconnection.** Treeification lets one node receive the reference input along one path and a random input along another. That separates a node's role as a *computation* from its role as a *route*, which is the distinction [[wiki/concepts/arbitrary-sensorimotor-mapping.md]] says lesions cannot make without a crossed-hemisphere disconnection. **(brainstorm)** The two readings of a relay node `R` become two hypotheses. "`R` relays `u`" allows swaps only among inputs agreeing on all of `u`. "`R` computes `φ(u)`" allows swaps among inputs agreeing only on `φ(u)`. If behaviour survives the coarser equivalence, `R` computes `φ(u)` rather than relaying `u`.
- **(brainstorm) Designed architectures should be scrubbable by construction.** A model whose modules are defined by the interpretation graph the builder intends, such as the separate structure/content streams in [[wiki/concepts/abstract-structural-codes.md]], can be scrubbed against that graph at every checkpoint. Recovered loss then tracks *whether training kept the intended decomposition*, the failure the wiki's modular designs cannot currently detect.

---

## Open problems

- **No calibration of the score.** 72% and 86% are reported without a null. There is no distribution of recovered loss for random hypotheses of matched specificity, unlike amnesic probing's matched random-direction control. So "reasonably, but not completely, accurate" has no significance threshold.
- **The score depends on graph granularity.** The shared-`x″` rule for unimportant parents exists because otherwise the result would depend on whether an attention layer is represented as one node or one node per head. Equivalent hypotheses written at different granularities can therefore score differently, and the source defers the resolution to its appendix.
- **Hypothesis search is manual.** The 35% → 86% induction refinement was researcher-driven. The source mentions automated search over a hypothesis space but reports none, and without search the instrument certifies only what someone thought to write down, like every probe.
- **Linear-direction claims enter as residual splits.** Claim 2 and the "identity-attention" heads are expressed by splitting an activation into a claimed part plus a residual that is resampled. So a direction-level claim ([[wiki/concepts/linear-representation-hypothesis.md]]) is tested only through how its residual was defined.

---

## Connections

- **[[wiki/concepts/representation-probing.md]]** — the step after a probe: a probe establishes that a variable is present at a site, while scrubbing tests a whole graph of such variables together with the claim that everything outside the graph carries no task-relevant input-conditional information, so it answers "is *this* the computation" where the probe table stops at "is this there".
- **[[wiki/concepts/amnesic-probing.md]]** — the one-feature, erase-side sibling: amnesic probing removes a named property's linear span and scores the frozen reader against a matched random-direction null, while scrubbing resamples every non-claimed pathway at once and has no such null; both break when two features are correlated in the data, which the rescue control addresses there and L3 leaves open here.
- **[[wiki/entities/othellogpt.md]]** — the model on which per-subset scrubbing could settle whether the verified board direction or the cheaper legality circuit carries end-game predictions (T158); L4 is the reason the cheap-feature hypothesis must be scrubbed too.
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — supplies the lesion confound that treeified resampling addresses: ablating a node removes both its computation and every route through it, while path-wise resampling can keep a route and cut its input-specific content.
- **[[wiki/concepts/certification-instruments.md]]** — the inventory this instrument sits beside: every entry there certifies *what* a system represents or does, and this one certifies a claim about *how*, with the same defeasibility, since a passed test is overturned by a more specific hypothesis just as a benchmark score is overturned by a harder item set.
