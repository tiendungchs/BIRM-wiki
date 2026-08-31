# CFQ — the compositional split as a *computed quantity* rather than a hand-picked holdout

**239,357 rule-generated English questions paired with SPARQL queries, each shipping the DAG of rule applications that produced it — so a train/test split can be *optimised* to maximise the divergence of compound (subgraph) distributions while holding the atom (rule) distributions matched, turning "out-of-distribution" from a choice into a dial (Keysers et al. 2020).**

> **Provenance.** `raw/keysers-2020-cfq-measuring-compositional-generalization.md`, ICLR 2020 (arXiv 1912.09713), Google Research Brain Team. CFQ = **C**ompositional **F**reebase **Q**uestions; DBCA = **D**istribution-**B**ased **C**ompositionality **A**ssessment; MCD = **M**aximum **C**ompound **D**ivergence. Glossary: [[wiki/glossary.md]].

The reason this page exists: every o.o.d. instrument in the wiki picks a holdout by hand — a verb ([[wiki/entities/scan.md]]), a length, a triple ([[wiki/entities/pgm.md]]), a concept ([[wiki/entities/conceptarc.md]]) — and then reports one number for it. DBCA is the only construction in the wiki that **measures the size of the shift it induces**, on the same scale for every split method, and therefore the only one that can ask whether a benchmark's difficulty is the shift or something else. It also re-measures SCAN's published splits on that scale, and the re-measurement corrects the wiki.

---

## The two principles and their formalisation

Each example is a DAG of rule applications. **Atoms** = individual rules (443 in CFQ, 38 in SCAN). **Compounds** = subgraphs of the DAG, weighted so a compound highly predicted by one of its supergraphs is not double-counted: `w(G) = max_{g∈occ(G)} (1 − max_{G′: g≺g′∈occ(G′)} P(G′|G))`.

| Principle | Formal | Why that α |
|---|---|---|
| **Similar atom distribution** | `D_A(V‖W) = 1 − C_0.5(F_A(V) ‖ F_A(W))`, required `≤ 0.02` | Chernoff at α = 0.5 is the Bhattacharyya coefficient — symmetric, so it penalises *any* mismatch in rule frequency. This is the control: it forbids the split from being a domain shift over the primitives |
| **Different compound distribution** | `D_C(V‖W) = 1 − C_0.1(F_C(V) ‖ F_C(W))`, maximised | α = 0.1 weights *whether* a compound occurs in train far above whether the two probabilities match — presence, not calibration, is what a compositional test is about |

Split construction is a greedy alternation (add `u` to train or test so that `D_C` and `D_A` stay closest to target, with occasional removals to escape local optima, first example random). Target divergences can be *swept* in 0.1 increments, which is what makes the dose-response curve below possible.

**The single most exportable line for a builder:** the intended solution is not declared by naming what was held out; it is *induced* by an objective over distributions of derivation subgraphs. Any generator that logs its own derivation supports it — the method is task-independent, and the paper demonstrates that by applying it to a benchmark it did not build.

---

## What the split methods actually measure, side by side

Same 40% train / 10% test on both datasets. The four right columns are the point: they show the hand-picked splits are each maximal on *one* observable and near-zero on the others.

| | Split | `D_A` | `D_C` | Output-pattern coverage | Input-pattern coverage | Output-length ratio |
|---|---|---|---|---|---|---|
| **CFQ** | Random | 0.000 | 0.000 | 0.726 | 0.705 | 1.007 |
| | Output length | 0.033 | 0.176 | 0.000 | 0.004 | 0.486 |
| | Input length | 0.047 | 0.062 | 0.285 | 0.047 | 0.584 |
| | Output pattern | 0.000 | 0.008 | 0.000 | 0.516 | 0.977 |
| | Input pattern | 0.000 | 0.005 | 0.636 | 0.000 | 1.028 |
| | **MCD₁₋₃** | 0.020 | **0.694 / 0.713 / 0.704** | 0.079 / 0.023 / 0.034 | 0.032 / 0.007 / 0.027 | 0.732 / 0.838 / 0.807 |
| **SCAN** | Random | 0.000 | 0.047 | 1.000 | 1.000 | 0.998 |
| | Output length | 0.034 | 0.437 | 0.000 | 1.000 | 0.367 |
| | Output pattern | 0.003 | 0.221 | 0.000 | 0.967 | 1.081 |
| | **MCD₁₋₃** | 0.014–0.020 | **0.734–0.736** | 0.259–0.318 | 0.009–0.357 | 0.632–0.757 |

**A pattern-based split is a compound-divergence near-zero.** Holding out every output query pattern (the standard "query split" of the semantic-parsing literature) yields `D_C = 0.008` on CFQ — it removes surface forms while leaving the *compound* distribution almost untouched. So the field's default hard split is, on this scale, barely a compositional test at all; it is hard for a different reason.

**MCD splits are not observationally distinct.** Appendix D.1 prints 20 random train and 20 random test questions from MCD₁ (`D_C = 0.694`) and they cannot be told apart by eye — same question shapes, same length range. The difficulty is in the *combinations*, not in anything a length filter or a pattern anonymiser would catch.

---

## The result: accuracy is a function of compound divergence

Three encoder-decoders (LSTM+attention, Transformer, Universal Transformer), hyperparameters tuned once on a random split and then frozen, 5 replicas, ~96k train (CFQ) / ~8k (SCAN).

| | CFQ random | CFQ MCD | SCAN random | SCAN MCD |
|---|---|---|---|---|
| LSTM+attention | 97.4 ± 0.3 | **14.9 ± 1.1** | 99.9 ± 2.7 | **6.1 ± 2.2** |
| Transformer | 98.5 ± 0.2 | **17.9 ± 0.9** | 100.0 ± 0.0 | **1.1 ± 0.5** |
| Universal Transformer | 98.0 ± 0.3 | **18.9 ± 1.4** | 99.9 ± 0.2 | **1.2 ± 0.7** |

Sweeping the target `D_C` from 0 to max in 0.1 steps gives a monotone decreasing curve for all three architectures on both datasets:

- `R² = 0.81–0.88` for accuracy against compound divergence.
- `R² = 0.11–0.22` for accuracy against input/output length ratio.
- SCAN holds ~100% up to `D_C ≈ 0.2`; CFQ does not — consistent with 38 rules against 443, i.e. the number of atoms sets how much compound novelty a memorising solution can absorb.
- **Scale does not fix it** (Appendix H): the correlation holds at every training size, and the accuracy gain flattens at ~80k examples (CFQ) / ~6k (SCAN). More of the same distribution buys nothing past that point.
- Random-split accuracy stays >95% with **10× less** training data — so the i.i.d. number carries almost no information about the compositional one.

**One scalar computed from the derivation graphs gives direct control of mean accuracy, on two datasets and three architectures, without the examples looking different.** That is the strongest statement in the wiki that o.o.d. difficulty is *measurable in advance of running a model* — see T312 for what it costs.

---

## The re-measurement of SCAN's splits, and the correction it forces

Appendix G maps the *published* SCAN splits (Lake & Baroni 2018; Loula et al. 2018) onto the re-created generator and computes their divergences. Two rows change what the wiki says:

| Published split | `D_A` | Train coverage | Reported accuracy |
|---|---|---|---|
| `primitive<jump>` | **0.08** | 63% of data | ~0 |
| `primitive<turn left>` | **0.07** | 94% of data | ~90 |

Both exceed DBCA's `D_A ≤ 0.02` admission threshold by 3–4×. **The `add primitive` splits are not clean compositionality experiments on their own terms**: they shift the atom distribution as well as the compound distribution, and the two verbs additionally differ in compound divergence *and* in how much of the space training covers (63% vs 94%). The wiki's SCAN page and `I31` attribute the 1.2%/90.3% asymmetry entirely to output-symbol frequency (`LTURN` appears inside composed action sequences, `JUMP` does not); that mechanism is still the sharpest single explanation, but it is now known to be **confounded with a 31-point coverage difference and a divergence difference**, and neither source can separate them. Every low-accuracy-at-low-`D_C` point in Figure 7 is likewise a split with elevated `D_A` — i.e. targeted holdouts buy their difficulty partly by violating the atom-matching control.

Two smaller corrections from the same appendix: both transformers score **0%** on SCAN's length split where the LSTM gets ~14% (the wiki quotes 13.8–20.8% from recurrent models only), and all three architectures reach **100% on the few-shot filler task at one example**, where the original report has a slowly rising curve.

---

## Error analysis (MCD₁, accuracies 29–37%)

- **68% of errors are on the same samples** across all three architectures — the failure is a property of the split, not of the architecture. (Compare `I30`, [[wiki/concepts/error-consistency.md]]: this is a raw overlap rate, undifferenced, so part of it is the shared accuracy level.)
- Outputs are ~20% **too short** when wrong; the dominant error is an **omitted clause** (43–49% of test samples): a dropped conjunct ("executive produced and edited M0, M1, M2" → one predicate lost) or a dropped adjective ("female Spanish film producer" → the adjective vanishes).
- Deletion dominates insertion by ~5× (clause `del` 43.1–49.2% vs `ins` 8.0–9.8%).
- Order-equivalent-but-not-identical queries account for only 0.6–1.8% — the exact-match metric is not doing the damage.

**(brainstorm)** Systematic under-generation of conjuncts is the sequence-domain signature of a decoder that has learned *one* clause-emission habit per question shape rather than a map from parse constituents to clauses — the same shape as PCFG SET's `copy-for-length-≤5` ([[wiki/concepts/compositionality.md]]). It predicts that any architecture emitting a set of constraints rather than a token sequence should lose this error class, which is a cheap and unrun test.

---

## The protocol rule the wiki did not have

> Hyperparameters must be tuned on a **random split** (or a random subset of train), never on the o.o.d. validation set — tuning on a validation set drawn from the test distribution "amounts to optimizing for a particular type of compound divergence", so the number reported is *this architecture's ability to be made to generalise in one known way* rather than the model's generalisation to an unknown shift.

CFQ enforces this and additionally freezes the training-step count across all splits. This is a leakage channel distinct from every one on [[wiki/concepts/shortcut-learning.md]] — it leaks through the *hyperparameters*, needs no test items, and is invisible in any released score. **(brainstorm)** It generalises to the whole `F1`/`F2` family on [[wiki/concepts/certification-instruments.md]]: developer-blindness must cover the hyperparameter search, not just the item set, and no benchmark in the wiki reports where its baselines were tuned.

---

## Limitations

- **Generated, single-domain, disambiguated by construction.** One name → one entity, no ambiguous parses, no plural/negation/quantifier/comparative constructions; a filter discards questions that are unnatural or unanswerable in Freebase. The "realistic" claim is about *language* surface, not about the messiness of real queries.
- **Atoms are defined by the authors' rule set.** Divergence is a function of the grammar's factorisation — a coarser or finer rule set would move every number in the tables above, and there is no independent criterion for the right granularity. This is `G16` reappearing inside the *instrument*: the intended decomposition is a design decision, not a fact about the data.
- **Only a compound-divergence axis is dialled.** Nothing separates the five Hupkes facets; a MCD split mixes systematicity, productivity and substitutivity in unknown proportion (Table 3's right-hand columns confirm the mixture varies across MCD₁₋₃).
- **The output-length split scores worse than its `D_C` predicts** — the authors attribute this to length ratio plus a slightly elevated `D_A`. So `D_C` is not a complete account even in the paper's own data.
- **2020 model set, no pretraining.** Three seq2seq architectures, `tensor2tensor` defaults, no pretrained encoder; the authors name unsupervised pretraining as the obvious untried direction.
- **Requires a generator that logs derivations.** Inapplicable to any naturally-occurring corpus, which is the class of data the method's own "realistic" motivation points at.

---

## Comparison

| Benchmark | Split declared over | Shift magnitude measurable? | Facets separable | Difficulty tunable |
|---|---|---|---|---|
| **CFQ** | An *optimised* divergence over derivation subgraphs | **Yes — `D_C ∈ [0,1]`, comparable across split methods and datasets** | No (mixture) | **Yes, continuously** |
| [[wiki/entities/scan.md]] | The interpretation function (length, primitive) | Only retrospectively, by this page | 2 | No — three fixed splits |
| [[wiki/entities/pcfg-set.md]] | Function pairs, length, synonyms, sub-expressions | No | 5 + consistency score | No |
| [[wiki/entities/pgm.md]] | `[relation, object, attribute]` triples | No | Recombination vs constituent novelty | No — 8 fixed regimes |
| [[wiki/entities/conceptarc.md]] | Concept groups, authored by hand | No | Per-concept coverage | No |

---

## Connections

- **[[wiki/entities/scan.md]]** — the benchmark this page re-measures on its own scale, and corrects: the `add primitive` splits carry `D_A` = 0.07–0.08 against DBCA's ≤0.02 admission threshold, and `turn left` covers 94% of the data against `jump`'s 63%, so the 90%/1.2% asymmetry is confounded with atom-distribution shift and coverage as well as with output-symbol frequency.
- **[[wiki/concepts/compositionality.md]]** — supplies the continuous axis the facet decomposition lacks: one computed scalar over derivation subgraphs predicts accuracy at `R² = 0.81–0.88` where length ratio predicts it at 0.11–0.22, which is a claim about how *many* dimensions compositional generalisation has (T312).
- **[[wiki/concepts/certification-instruments.md]]** — supplies `I32`, the only instrument in the inventory whose output is a *dial* rather than a reading, and the hyperparameter-tuning leakage channel that `F1`/`F2` do not cover.
- **[[wiki/concepts/shortcut-learning.md]]** — the leakage channel this page names: tuning hyperparameters on an o.o.d. validation set optimises for one known compound divergence, so the reported number measures a searched-for generalisation rather than an unknown one, and it leaves no trace in the score.
- **[[wiki/entities/pcfg-set.md]]** — the facet-vector alternative: five separately failable behaviours against this page's single tunable scalar, and the two disagree about whether length extrapolation is its own facet or a region of the compound-divergence axis.
- **[[wiki/entities/mlc.md]]** — the method that buys SCAN's lexical splits outright and scores 100% error on its length split; read on this page's axis, that is a system whose episode sampler covers one *direction* of compound divergence and not another, which is `G66` stated over compounds.
- **[[wiki/entities/pgm.md]]** — the visual analogue with the same design move (split declared over an explicit symbolic structure) and without the divergence measure, so its eight regimes cannot be ordered by shift magnitude.
- **[[wiki/concepts/error-consistency.md]]** — the 68% shared-error rate here is exactly the undifferenced overlap statistic that page's `κ` corrects; at 29–37% accuracy the chance-expected overlap is large, so the "same failure" claim is weaker than it reads.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the derivation DAG *is* the latent structure, published with every example, so CFQ is the rare case where the intended graph is not hidden and the difficulty is entirely in recombining its subgraphs.
- **[[wiki/entities/conceptarc.md]]** — the opposite answer to the same question: this page *computes* the out-of-distribution axis as a compound divergence over derivation subgraphs and sweeps it continuously, available only because its items are generated, where ConceptARC authors the axis by hand as concept groups and pays for it in coverage rather than in naturalness.
