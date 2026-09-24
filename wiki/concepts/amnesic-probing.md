# Amnesic Probing

**Decide whether a network *uses* a property by erasing it from a representation and measuring how much the network's own downstream prediction changes — the causal complement of a probe, which only shows the property can be read.**

> **Provenance.** Elazar, Ravfogel, Jacovi & Goldberg 2021 (`raw/elazar-2021-amnesic-probing-behavioral-explanation-with-amnesic-counterfactuals.md`), on BERT's masked-language-model (MLM) head, six sequence-tagging properties. Every number on this page is from that source unless marked.

---

## The operation

Model split as `ŷ = c(h(x))`: encoder `h`, downstream reader `c` (here the word-prediction layer). Property `Z` (part-of-speech, dependency label, …) attached to each token.

| Step | Operation |
|---|---|
| **1. Probe** | Train linear classifier `W_i` to predict `Z` from `H`. If it is at majority, stop — an undecodable property cannot be used |
| **2. Project out** | `H ← P_{N(W_i)} H`, so `W_i P_{N(W_i)} H = 0`; each iteration removes `#classes` directions |
| **3. Iterate** | Repeat until no linear classifier beats majority — Iterative Nullspace Projection (INLP). Output `h(x)^{¬Z}` |
| **4. Score** | Feed `h(x)^{¬Z}` to the *frozen* `c`; report task accuracy and `D_KL(p_c(·|h) ‖ p_c(·|h^{¬Z}))` over the whole output distribution |

The encoder is never retrained, so the answer is about *this* model's reader — unlike adversarial removal by gradient reversal, which changes the encoder and is reported not to remove all the information.

### Two controls, each answering a different objection

| Control | Construction | Rules out | Result shape |
|---|---|---|---|
| **Rand** (information) | Remove the *same number* of directions, drawn uniformly at random | "Any rank reduction hurts" | Amnesic drop ≫ Rand drop ⇒ the *specific* directions mattered |
| **Selectivity** (rescue) | Concatenate a learned 32-d embedding of the **gold** `Z` value to `h^{¬Z}`; fine-tune the reader only | "INLP also removed correlated properties" | Performance restored ⇒ the damage is accounted for by `Z` alone |

Hewitt & Liang's control task (random label per word type) is rejected as a control here: erasing its directions erases *lexical identity*, which the LM objective needs, so its slope (steeper than Rand, shallower than amnesic) says nothing about `Z`.

---

## Evidence — BERT, last layer, word prediction

**Non-masked input** (the setting used for probing and fine-tuning):

| Property | Classes | Dirs removed | Majority | Probe acc. | LM acc. vanilla | Rand | **Amnesic** | Selectivity | `D_KL` Rand / Amnesic |
|---|---|---|---|---|---|---|---|---|---|
| dependency label | 41 | 738 | 11.44 | 76.00 | 94.12 | 12.31 | **7.05** | 73.78 | 8.11 / 8.53 |
| fine POS | 45 | 585 | 13.22 | 89.50 | 94.12 | 56.47 | **12.31** | 92.68 | 4.61 / 7.63 |
| coarse POS | 12 | 264 | 31.76 | 92.34 | 94.12 | 89.65 | **61.92** | 97.26 | 0.36 / 3.21 |
| named entity | 19 | 133 | 86.09 | 93.53 | 94.00 | 92.56 | **83.14** | 96.06 | 0.08 / 1.24 |
| phrase start | 2 | 36 | 59.25 | 85.12 | 94.00 | 93.75 | **94.21** | 96.96 | 0.01 / 0.01 |
| phrase end | 2 | 22 | 58.51 | 83.09 | 94.00 | 93.86 | **94.32** | 96.93 | 0.01 / 0.01 |

| Finding | Number |
|---|---|
| **Probe accuracy does not predict use** | Spearman 0.085, `p` = 0.871 across the six properties |
| **Decodable and unused — erasure *helps*** | Phrase boundaries decode ~25 points above majority; erasing them raises LM accuracy +0.21 / +0.32, above Rand |
| **Barely decodable and used** | Named entity decodes only 7.4 points above majority; erasing it costs 10.9 LM points against 1.4 for Rand |
| **The dependency result is uninformative** | 738 random directions already drop LM to 12.31; amnesic 7.05 is barely below, and selectivity recovers only to 73.78 — too much of the space was removed to attribute the damage |
| **Selectivity can overshoot** | Coarse POS: 97.26 restored vs 94.12 vanilla — the gold label is extra information, so the rescue control tests *sufficiency*, not equivalence |

**Masked input** (the pre-training regime; vanilla 56.98 / 57.71): same ordering, dependency now fully uninformative (Rand = amnesic = 4.67; selectivity 20.46), fine POS 6.01 vs Rand 24.69, coarse POS 33.28 vs 54.55, NER 48.39 vs 56.88, phrase markers ≤ 1.1 below Rand. Per-iteration curves show a consistently steeper amnesic slope than Rand.

### Which predictions depend on the property

Masked input, coarse-POS erased, LM accuracy by gold POS of the target word:

| Class | Vanilla → amnesic | Δ |
|---|---|---|
| particle | 96.40 → 18.74 | 77.66 |
| conjunction | 78.01 → 4.28 | 73.73 |
| determiner | 82.29 → 16.64 | 65.66 |
| pronoun / adposition / punctuation | — | 37.06 / 35.93 / 33.68 |
| verb / noun / numeral | 46.72 → 34.99 / 42.91 → 34.26 / 40.32 → 33.41 | 11.73 / 8.65 / 6.91 |

- Erasure turns **function words into content words**: "and", "of", "a" → "rotate", "say", "final". Of 12,700 determiner/conjunction/punctuation targets, predictions tagged noun/verb go 200 → 3,982.
- Erasing only one label-vs-rest distinction: determiner 5.94, punctuation 3.86, adposition 3.58; noun 1.19, verb 1.38, adjective 1.03 (Rand within 0.92 of vanilla).
- **(brainstorm)** The category code is read almost exclusively to predict *closed-class* tokens — the structural scaffold of a sentence — while open-class content is predicted from something else. That is a structure/content (`g`/`x`) factorization expressed at the *reader*, and erasure is the instrument that shows it; decoding cannot, because the category is equally decodable at every token.

### Across layers — where it is used is not where it is readable

Erase at layer `i` with a projection fitted to layer `i`, then run the remaining layers.

| Measurement | Non-masked | Masked |
|---|---|---|
| **Re-decodability downstream** (coarse POS) | Erased in layers 1–7: later layers recover to within 5.72–12.69 points of normal probing. Erased in layers 8–12: 16.57–46.39 lost | Opposite: erased at layer 2, later layers reach only 32.7–42.1 |
| **Layer of largest LM damage** | Coarse POS **layer 11** (−40.99); NER layer 11 (−31.09); erasure *improves* LM at some layer for every property | Coarse POS layer 3 (and 12); NER layer 4; phrase start 5/7; phrase end 6 |

- Coarse POS is linearly readable above 80% at every layer, yet its use peaks at layer 11 — against the "BERT rediscovers the NLP pipeline" localisation (Tenney et al. 2019), which placed POS early from *extractability*. Readable-where and used-where are different maps.
- **Downstream recomputation.** Early-layer erasure is largely repaired by later layers (the property is regenerated from non-linear residue INLP cannot touch). So an erasure at layer `l` *under*-states use whenever layers above `l` can recompute the property — a confound for every ablation-based use claim, not just this one.
- **The analysis regime is part of the result.** Masked and non-masked inputs give different layer profiles and opposite recovery trends; conclusions from the probing regime do not transfer to the training regime. Same shape as the task-distribution contingency on [[wiki/concepts/representation-probing.md]] (Matsuzaka et al. 2012, T111).

---

## What it licenses

| Claim | Licensed? |
|---|---|
| "The reader `c` uses the *linearly* present part of `Z`" | **Yes**, if amnesic ≫ Rand and selectivity restores |
| "The model does not use `Z`" | **No** — only that it does not use the linear part at this site; non-linear residue and downstream recomputation remain |
| "`Z₁` matters more than `Z₂`" | **No** — directions removed differ by property (22 vs 738), and the authors decline to rank |
| "`Z` is used at layer `i`" | **Only as a lower bound**, because later layers can regenerate it |

---

## Relevance to building a reasoning model

- **The use half of T25 in a second domain.** OthelloGPT showed a decoded direction *is* used via activation addition; this shows, with intervention, that decodability and use are uncorrelated across properties in a language model ([[wiki/empirical-tensions.md]] T25).
- **Erase is the dual of write.** Activation addition ([[wiki/entities/othellogpt.md]]) tests use by pushing along a direction; amnesic probing tests it by removing the direction's span. Both depend on the feature being linear ([[wiki/concepts/linear-representation-hypothesis.md]]); only erasure gives a matched-magnitude null (Rand).
- **(brainstorm) A factorization certificate.** Fit INLP for a structural-position code `g` and for content `x` at the same site; erase each and score both a structure-dependent and a content-dependent read-out. A real `g`/`x` split predicts a crossed double dissociation — a finer tool than module ablation for [[wiki/gaps/g109.md]]'s two-lesion profile, because it lesions a subspace rather than a component.
- **(brainstorm) Unused content can be interference.** Erasing phrase markers improves prediction. A design reading: content a reader does not need should sit in that reader's null space ([[wiki/concepts/output-null-subspace.md]]); amnesic probing measures when it does not.

---

## Open problems

- **Linear only.** INLP removes linearly present information; the authors name non-linear erasure as the missing tool, and downstream recovery shows the residue is used.
- **Removed-dimension count is uncontrolled across properties**, so the dependency and fine-POS results sit near the Rand floor and cross-property comparison is closed off.
- **Probe-direction ≠ reader-direction.** INLP removes whatever directions *a probe* found predictive of `Z`; if the reader uses a correlated direction the probe did not pick first, the iteration still catches it only because it runs to majority — at the price of removing correlates (selectivity < vanilla for dependency).
- **One model, one objective, one reader.** BERT word prediction only.

---

## Connections

- **[[wiki/concepts/representation-probing.md]]** — supplies step 1 and the decoded-but-unused problem this page answers causally: a probe is the precondition, and erasing what it found converts "present" into "used by this reader", with a matched random-direction null the other intervention rows lack.
- **[[wiki/concepts/linear-representation-hypothesis.md]]** — the assumption the instrument rests on: erasure by nullspace projection is complete only if the property is a set of directions, and the downstream recovery of an erased property is a measured case of that assumption's limit.
- **[[wiki/entities/othellogpt.md]]** — the write-side twin: activation addition tests use by pushing along a probe direction, amnesic probing by projecting its span out, and the two together bracket the causal status of one linear feature.
- **[[wiki/concepts/output-null-subspace.md]]** — the same geometry from the reader's side: INLP builds a subspace the property reader cannot see and asks whether the *task* reader needed it, so an erasure that improves performance marks content that should have been in the task reader's null space.
- **[[wiki/concepts/causal-scrubbing.md]]** — the whole-algorithm generalisation: it replaces this page's erasure with resampling from inputs that agree on each claimed variable, and tests a graph of them at once, but it has no counterpart of the Rand null, so its recovered-loss scores are uncalibrated where this page's are not.
- **[[wiki/concepts/counterfactual-probing.md]]** — the input-side counterpart: both are interventions, but that page clamps an input and clusters responses with no named property, while this edits the representation along a named property and needs its labels.
