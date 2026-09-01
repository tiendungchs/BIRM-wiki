# PoE-ARC (the ARChitects) — one fine-tuned LLM used twice, as generator and as its own ensemble of rejectors

**Fine-tune an 8B model on ARC grids at 64 tokens of vocabulary, fine-tune it again on the single task's own demonstration pairs, enumerate every solution whose running probability stays above a threshold `T` by depth-first search, then re-score each surviving candidate under all 16 symmetry/colour/order augmentations and keep the one with the highest *product* of augmented likelihoods — 71.6% on the ARC-AGI-1 public evaluation set at $0.02 per task.**

> **Provenance.** Franzen, Disselhoff & Hartmann 2025, *Product of Experts with LLMs: Boosting Performance on ARC Is a Matter of Perspective* (`raw/franzen-2025-product-of-experts-arc.md`, arXiv 2505.07859v2). Weights and code public. This is the **primary source for the ARChitects**, the 2024 ARC Prize first-place team, whose method [[wiki/concepts/test-time-training.md]] has so far carried second-hand from Chollet et al. 2024's survey. The system reported here is the post-competition version: 71.6% public eval, against the 53.5% private-set score of the competition entry.

---

## The pipeline

| Stage | What it does | Cost |
|---|---|---|
| **Tokenization** | One token per grid cell; vocabulary cut from >120,000 to **64**; no delimiters beyond the minimum; a fixed pre-prompt (`A…Za…z`) prepended to the first example | Removes the embedding matrix and, with it, digit-merge tokenization artefacts |
| **Initial fine-tuning** | Mistral-NeMo-Minitron-8B-Base, LoRA rank 256 on **all** layers including input/output embeddings, 4-bit quantized; trained **only on RE-ARC** (Hodel's generators for the 400 public *training* tasks) | 98 H100-hours |
| **Test-time training** | LoRA rank 32, 64 steps, batch 1, on the single task's own demonstration pairs under the full augmentation group | 51 s/task on one RTX 4090 |
| **Candidate generation** | DFS over the solution tree, pruning any partial path whose accumulated probability falls below `T`; run under each of 16 augmentations; identical solutions merged | 9:32 h for 400 tasks at `T=9%`, 7.3 GB VRAM |
| **Candidate selection** | Re-score every candidate under 16 *freshly randomised* augmentations, rank by `∏_j P̂(φ_j(s) \| φ_j(p))`, submit the top two | — |

Gradients are taken only on outputs `y_i` for `i>1` and on the answer — the model is never asked to predict an input grid, and the first output is exempt because it is unpredictable before any example has been seen.

**Only RE-ARC is used as extra data, deliberately.** ARC-Heavy (400,000 LLM-generated tasks) and ConceptARC are refused on the grounds of *conceptual leakage*: a synthetic corpus that happens to contain an evaluation task's concept silently converts a developer-novel task into a familiar one. RE-ARC only re-samples instances of tasks already in the public training split, so the experience cap moves on the instance and not on the task — the same accounting [[wiki/concepts/skill-acquisition-efficiency.md]] insists on, here enforced by the authors against themselves.

---

## Product of experts: the mechanism, with a proof

The augmentation family `Φ = {φ_1,…,φ_m}` is defined by the property that it preserves the solution distribution:

```
P(s | p) = P(φ_j(s) | φ_j(p))    for all (p, s), all j
```

`Φ` therefore *is* a statement of prior knowledge — the D₈ symmetries, colour permutations and example re-orderings are the geometry/objectness priors ([[wiki/concepts/core-knowledge.md]]) written as invariances rather than as operations. The true `P` obeys them exactly; the learned `P̂` does not, and the method turns that failure into the selection signal.

Write `P̂_j(s) := P̂(φ_j(s) | φ_j(p))` and pool them log-linearly:

```
P̄(s) = (1/Z) ∏_{j=1..m} [P̂_j(s)]^{1/m}
```

**Theorem (log-pooled augmentations).** `KL(P ‖ P̄) = (1/m) Σ_j KL(P ‖ P̂_j) + log Z`, with `log Z ≤ 0` and equality iff all `P̂_j` are identical.

The ensemble's divergence from the truth is the *average* single-view divergence **minus** a non-negative term that grows with how much the views disagree. Three consequences the wiki should keep:

1. Pooling is never worse in expectation than picking one augmentation at random, and is strictly better whenever the model is inconsistent across views.
2. **Disagreement is the resource.** The usual ensemble intuition (average away independent noise) is replaced by: a candidate must be jointly plausible under *every* valid view, so a single dissenting view kills it. This is a rejector with a multiplicative veto, not a vote.
3. It fails only where the correct solution gets near-zero probability under some view — the one case where the veto is wrong.

The authors' stated cause of the inconsistency is the autoregressive factorization itself: a left-to-right decoder must commit to cell 1 before it has computed the information that determines cell 1, and once wrong it conditions on its own error and stays confidently wrong. Re-reading the same answer under a permuted frame changes which cell comes first, so a different set of commitments is being tested each time. **(brainstorm)** That makes `Φ` a cheap substitute for the bidirectional or iterative-refinement decoding the task actually wants — the same repair [[wiki/concepts/refinement-loop.md]] buys with retries, bought instead with re-parameterisation and no extra generation.

**Aggregator matters, and the ordering is stable** (2-guess accuracy, DFS `T=9%`, same candidates throughout):

| `max_j P̂_j` | `Σ_j P̂_j` (mean) | `min_j P̂_j` | `∏_j P̂_j` (PoE) |
|---|---|---|---|
| 63.5% | 66.6% | 68.8% | **71.6%** |

`max` — believe the most confident view — is the *worst* rule, 8.1 points below the product. The two aggregators that let one bad view veto (`min`, `∏`) are the two that win. Averaging sits between.

---

## The ablation ladder

2-guess accuracy on the ARC-AGI-1 public evaluation set, components added left to right:

| Model | Baseline | + TTT | + 16× augment | + PoE | + DFS |
|---|---|---|---|---|---|
| Llama-3.2-3B | 14.9% | 40.9% | 52.9% | 59.5% | 61.4% |
| NeMo-Minitron-8B | 18.3% | 44.5% | 62.5% | 67.6% | **71.6%** |

Reading, in the wiki's terms: **+26.2 points from adaptation, +18.0 from generating in multiple frames, +5.1 from pooling those frames as a rejector, +4.0 from replacing sampling with threshold search.** The generator's own quality (`Baseline`) accounts for 18.3 of 71.6 points; everything else is inference-time machinery over a frozen pretrained prior. Model size buys 10.2 points at the top of the ladder and 3.4 at the bottom — the machinery is worth more on the larger model, so it is not a small-model crutch.

Reference points: average human **60.2%**, best open prior work (TTT+BARC) 62.8%, o3 82.8% at **$17/task** against this system's **$0.02/task** — an 850× cost ratio for 11.2 points, which is the sharpest single price in the wiki on where ARC-AGI-1 performance is being bought.

---

## Search: DFS beats beam search, and coverage is not the binding constraint

`C_{p,T} := { s : ∃φ_j ∈ Φ, P̂(φ_j(s) | φ_j(p)) > T }` — DFS with probability-threshold pruning enumerates *exactly* this set, so nothing above `T` is missed and nothing below it is ever scored. Only one path is held in memory, and after the first augmentation the best candidate so far is fed in as an initial guess and verified in a single forward pass before backtracking begins.

| Method | Correct solution present | Candidates/task | Generation runtime | VRAM | Final score |
|---|---|---|---|---|---|
| Greedy | 70.8% | 6.7 | 9:39 | 7.0 GB | 67.6% |
| Stochastic 4× | 77.3% | 17.6 | 39:47 | 7.0 GB | 70.8% |
| Beam search 4× | 79.0% | 34.7 | 37:36 | 14.0 GB | 71.6% |
| **DFS `T=20%`** | 73.5% | 4.9 | 5:58 | 7.3 GB | 70.0% |
| **DFS `T=9%`** | 76.0% | 9.3 | 9:32 | 7.3 GB | 71.6% |
| **DFS `T=0.5%`** | 83.5% | 84.7 | 80:56 | 7.3 GB | 71.8% |

**The most important row in the paper is the last one.** Lowering the threshold from 9% to 0.5% raises the fraction of tasks whose candidate set *contains* the right answer by **7.5 points** (76.0 → 83.5) and raises the final score by **0.2** (71.6 → 71.8), at **6.5× total runtime** (20:50 → 134:43 h). The proposer is not the bottleneck; the rejector is. Equivalently: the system's ceiling is set by the 11.7-point gap between what it generates and what it can recognise.

Two smaller findings: DFS at equal score uses half the VRAM and a quarter of the generation time of beam search, because beam search explores a fixed width regardless of accumulated probability while DFS prunes; and DFS returns roughly half as many false positives as 4× stochastic sampling at comparable coverage, which also halves the downstream scoring bill.

---

## Transfer: ConceptARC and Sudoku

| Domain | Setup | Result |
|---|---|---|
| **[[wiki/entities/conceptarc.md]]** | Identical hyperparameters to DFS `T=9%`; no retraining | **73.3%** 2-guess — highest score on that benchmark in the wiki, against 21%/19% for the 2023 Kaggle winners and ~91% for humans |
| **Sudoku 3M** | ARC-pretrained Llama-3B, fine-tuned on 128,000 puzzles, **no TTT** (the rules are constant across instances, so there is nothing instance-specific to adapt to), DFS `T=1%` | **53%** top-1 on 1,000 unseen puzzles, against <3% for frontier LLMs on comparable benchmarks |

The Sudoku run is the cleanest statement of what PoE is doing. **When the correct solution is present in the candidate set, PoE selects it 100% of the time** — generation accuracy and final accuracy coincide exactly. The authors' explanation: Sudoku correctness is locally checkable, so an incorrect grid is *visibly* incorrect from most augmented views, and the veto never misfires. On ARC the same selector recovers only ~86% of the solutions it generated (71.6 of 83.5 at `T=0.5%`), because ARC has no local consistency law for a wrong grid to violate.

**This is the wiki's cleanest decomposition of a verifier's power into a property of the domain rather than of the verifier** ([[wiki/concepts/external-verification.md]]): the same pooling rule is a perfect rejector where the domain supplies a checkable invariant and a partial one where it does not. The TTT-free Sudoku setup makes the complementary point — test-time training buys nothing when the rule is shared across instances, which is a statement about *where the latent variable lives* rather than about the technique.

---

## Limitations

- **The invariance group is authored**, and the theorem's guarantee is conditional on every `φ_j` being *valid*. On a task whose rule is not colour-permutation-invariant (counting, ordering, "green means go"), the veto rejects the truth. Nothing detects this; `Φ` is fixed by hand and the same for every task.
- **`T` is a hyperparameter with no principled setting** — the sampling probability of the correct solution is unknown in advance, and the useful range (5–20%) was found on the public split, which is a developer-side prior on a developer-aware benchmark.
- **Nothing accumulates.** Both LoRAs are discarded per task; G14 unchanged.
- **The 11.7-point generate/select gap is unexplained.** No analysis of *which* tasks have the answer in `C_{p,T}` and lose it at selection, so it is not known whether the residue is ambiguous tasks (multiple defensible answers), invalid augmentations, or genuine selector error.
- **ARC-AGI-1 only.** The unmodified 2024 version of this stack scored 2.5% on ARC-AGI-2 ([[wiki/entities/arc-agi-2.md]]); this paper does not report an ARC-AGI-2 number.

---

## Comparison

| System | Selection signal | Population voted over | Where the prior lives | ARC-1 public eval |
|---|---|---|---|---|
| **PoE-ARC** | Product of likelihoods across augmentations | 16 augmented *frames* of one task | Augmentation group `Φ` | **71.6%** |
| [[wiki/entities/corethink-compositional-reasoner.md]] | Count of demonstrations explained by a hypothesis label | Demonstration pairs | 22 authored unit patterns | — (ARC-2: 24.4/30.8) |
| [[wiki/entities/arc-vsa-solver.md]] | Minimum hitting set over operation reuse + leave-one-demonstration-out | Demonstration pairs | 11-op DSL + SSP algebra | 3.0 (Eval) |
| [[wiki/entities/ilp-arc-synthesizer.md]] | Coverage of manufactured negatives under closed-world assumption | Hypothesis's own overgeneration | 7 hand-written predicates | — |

One mechanism, four populations to agree over. This page is the version with a **proof** that pooling beats a single view, and the only one whose selector is the generator itself evaluated under a group action — so no second model is trained, and the rejector costs one forward pass per candidate per view.

---

## Connections

- **[[wiki/concepts/test-time-training.md]]** — the primary source for that page's top-scoring instantiation, and the correction to how it states the ARChitects' contribution: the criterion is not "prefer the candidate stable under augmentation" but a specific log-linear pooling rule, `∏` beating `mean` by 5.0 points and `max` by 8.1, with a theorem saying disagreement between views strictly improves the ensemble.
- **[[wiki/concepts/external-verification.md]]** — a rejector built with no second model and no labels: the generator re-read under a group action, occupying a rung the ladder lacked (self-consistency across *problem representations* rather than across samples), whose power is shown to be a property of the domain — 100% selection on Sudoku, ~86% on ARC.
- **[[wiki/entities/arc-agi.md]]** — the benchmark measured, and the source of the state-of-the-art open-model number (71.6% public eval, above the 60.2% average human) at $0.02/task against o3's 82.8% at $17.
- **[[wiki/entities/conceptarc.md]]** — evaluated zero-shot at identical hyperparameters and scoring 73.3%, which is both the highest machine score on that benchmark in the wiki and a control against ARC-1 overfitting.
- **[[wiki/concepts/core-knowledge.md]]** — the priors installed purely as an invariance group `Φ` with a formal statement of what that means (`P(s|p) = P(φ(s)|φ(p))`), so the prior constrains without enumerating — and fails silently on tasks the group's assumptions do not hold for.
- **[[wiki/concepts/refinement-loop.md]]** — the same per-task loop, with the check applied to *re-parameterisations of one answer* rather than to retries of the generation, which is why it costs one forward pass per view instead of one generation per retry.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the `P` term restricted on principle (RE-ARC only, no ARC-Heavy, to avoid conceptual leakage) and the cost term reported per task, making this the wiki's cheapest high-scoring ARC system by three orders of magnitude.
- **[[wiki/concepts/program-induction.md]]** — the transduction pole of the induction/transduction split, here without any induction partner: the answer is emitted directly and never as an executable program, so nothing about the recovered rule is inspectable or reusable.
- **[[wiki/entities/arc-vsa-solver.md]]** — the same rejector question answered over demonstrations rather than augmented frames, and at 1/20th the score, which isolates how much of ARC performance is the pretrained prior rather than the selection machinery.
- **[[wiki/entities/corethink-compositional-reasoner.md]]** — the priced comparison of *where to spend a vote*: hypothesis labels across demonstrations there, likelihoods across augmentations here, with this page supplying the analytic reason the product beats the mean.
- **[[wiki/entities/transformer.md]]** — the autoregressive factorization named as the *cause* of cross-view inconsistency: a left-to-right decoder must commit to the first cell before computing what determines it, and augmentation re-scoring is a repair applied from outside the architecture.
- **[[wiki/concepts/rule-level-evaluation.md]]** — the reporting regime this system sits outside: it produces a grid and no rule, so its 73.3% on ConceptARC admits no classification of *which* abstraction it used, where the frontier models scored the same way turn out to reach ~27% of their correct answers by a rule the task was not about.
- **[[wiki/entities/gsm8k.md]]** — the reason this system's budget curve does not turn down: a learned scalar verifier over GSM8K peaks at ~400 candidates and then *falls* as the search finds solutions that fool it, while invariance pooling is a sound criterion a merely-persuasive candidate cannot satisfy ([[wiki/empirical-tensions.md]] T220).
- **[[wiki/concepts/selective-prediction.md]]** — the acceptance-threshold sweep `T = 9% → 0.5%` is a `θ` sweep along a risk–coverage curve reported as two points; and this system's aggregator ordering (`∏` > `min` > mean > `max`) is a comparison of confidence rates over *views*, orthogonal to max-softmax over *classes*, so the "max is worst" result here and the "max-softmax is best" result there are about different maxima.
