# Rule-Level Evaluation

**Score the *rule a solver states* alongside the answer it produces, and classify that rule against the abstraction the task was authored to elicit — `correct-intended` / `correct-unintended` / `incorrect`. On ConceptARC this splits a single accuracy number into two quantities that move in opposite directions: accuracy *overestimates* abstraction in the textual modality (27% of o3's correct grids rest on rules that are not the intended one, against ~8% for humans) and *underestimates* it in the visual modality (o3 states the intended rule on 40% of tasks while producing 29% correct grids).**

> **Provenance.** Beger, Yi, Fu, Denton, Moskvichev, Tsai, Rajamanickam & Mitchell 2025, *Do AI Models Perform Human-like Abstract Reasoning Across Modalities?* (`raw/beger-2025-conceptarc-abstract-reasoning-modalities.md`, arXiv 2510.02125v4; Sandia/BANYAN + Santa Fe Institute). All 480 [[wiki/entities/conceptarc.md]] test inputs, `pass@1`, one independent prompt per task, textual prompt copied verbatim from ARC Prize's o3-preview evaluation. Human rules are a re-analysis of **unpublished** data from Moskvichev et al. 2023. Every rule classification is **manual**: one rater, second-rater review, group consensus on disagreements — there is no algorithmic classifier and the authors say they know of none.

---

## The instrument

| Step | What it costs |
|---|---|
| 1. Require the solver to emit, in the same JSON object, the output grid **and** a natural-language rule describing the transformation | One prompt field |
| 2. Classify each rule: **correct-intended** (matches the abstraction the concept group was authored around) · **correct-unintended** (reproduces every demonstration but by other means) · **incorrect** (does not describe the demonstrations) · not-classified | Human judgement, ~480 items per condition |
| 3. Cross the classification with grid correctness — 2 × 4 cells rather than one accuracy | Free once step 2 exists |
| 4. **Faithfulness control:** check whether the emitted grid is what the stated rule would produce (*rule–grid alignment*) | Manual, same pass |

**Step 4 is what makes the instrument admissible.** A stated rule is a self-report, and self-reports of neural networks are not generally faithful. Measured alignment, medium effort + tools:

| Model | Rule–grid alignment, textual | Rule–grid alignment, visual | Visual-error rate |
|---|---|---|---|
| o3 | 98.1% | 97.4% | 49.1% |
| Claude Sonnet 4 | 92.4% | 96.6% | 59.7% |
| Gemini 2.5 Pro | 94.5% | 93.6% | 77.3% |

Above 90% everywhere — so on this task family the rule is a usable proxy for the executed computation, and the residual is bounded and reported rather than assumed away. **Visual error** is the separately-scored case where the grid's wrongness traces to perception (missed grid dimensions, misplaced objects, colour↔integer mis-mapping) rather than to a rule/grid mismatch.

---

## The two-way distortion of accuracy

Percentages of the 480 tasks, medium effort + Python tools. `CI` = correct-intended, `CU` = correct-unintended, `I` = incorrect, `NC` = not classified.

| Solver | | Correct grid: CI / CU / I / NC | Incorrect grid: CI / CU / I / NC |
|---|---|---|---|
| o3 | textual | **55.0** / 15.8 / 4.8 / 0.0 | 2.3 / 12.7 / 8.8 / 0.6 |
| o3 | visual | 20.4 / 5.6 / 3.1 / 0.0 | **19.6** / 12.9 / 32.5 / 5.8 |
| Claude Sonnet 4 | textual | 44.2 / 5.2 / 5.0 / 0.6 | **13.3** / 9.4 / 16.3 / 6.1 |
| Claude Sonnet 4 | visual | 4.0 / 0.4 / 2.1 / 0.4 | 10.4 / 2.5 / 66.5 / 13.8 |
| Gemini 2.5 Pro | textual | 43.8 / 11.9 / 4.8 / 0.0 | 2.3 / 10.0 / 25.6 / 1.6 |
| Gemini 2.5 Pro | visual | 4.6 / 0.2 / 1.0 / 0.0 | **19.0** / 5.4 / 67.1 / 2.7 |
| Humans | visual (images) | 53.7 / **2.7** / 3.0 / 13.6 | — / — / — / 27.0 |
| Humans, excluding NC | | **90.3** / 4.6 / 5.1 | — |

Two readings of the same table, and the paper's central claim is that both are needed:

- **Textual — accuracy overestimates.** o3 at 75.6–77.1% textual accuracy is at or above the human `pass@1` of 73%, but 20.6 of its 75.6 correct-grid points (**27%**) sit on `CU` or `I` rules. The human figure is ~8%. Correct-unintended *rule* share over all correct rules: o3 **29%**, Gemini **22%**, Claude **15%**, humans **2.7%** — a five- to ten-fold difference in how often a right answer is reached by a rule the task was not about.
- **Visual — accuracy underestimates.** o3's visual accuracy is 29.2% but it states the intended rule on 40.0% of tasks; 19.6 points of intended rules are attached to *wrong grids*. Gemini states the intended rule on 23.6% of tasks at 5.8% accuracy — a 4× discrepancy. The rule is found and the application fails.

**The generalisable statement.** An exact-match score is the *product* of finding the rule and executing it, and a benchmark that reports only the product cannot say which factor is missing. Rule-level classification factorises it, at the price of manual labour.

---

## Where the unintended rules come from

| Channel | Mechanism | Evidence |
|---|---|---|
| **The integer encoding is not arbitrary to the model** | ARC's 10 colours are serialised as the integers 0–9, which are *ordered*. Rules sort objects "by colour value ascending", "return the second-smallest value", "take the minimum frequency then break ties numerically" — using an encoding artefact as a feature | Multiple worked examples; the textual modality's dominant `CU` family |
| **No objectness prior** | ConceptARC is built on core-knowledge priors including objectness, yet model rules "often focused on colors, individual pixels, and other low-level features rather than objects"; models recognise alternating line patterns and fail to individuate shapes | Appendix L; the same deficit [[wiki/entities/conceptarc.md]] reports for the 2020 Kaggle programs |
| **A general-purpose shortcut toolbox** | Recurring across concepts and not specific to any: bounding boxes, 4-/8-connectivity, stepping to the grid edge or an object boundary, density heuristics | Appendix L |
| **Local overfit to the demonstrations** | Case-by-case logic covering the three demonstrations, correct on them and not on a fourth | Appendix D examples |

**The `CU` rate is concentrated, not uniform.** Over correct rules, textual mean 29.8% (SD 16.4): *Top/Bottom 3D* **70.6%**, *Clean Up* 52.3%, *Horizontal/Vertical* 45.1%. Visual mean 27.0% (SD 13.9): *Top/Bottom 3D* 62.5%, *Same/Different* 47.8%, *Clean Up* 40%. Top/Bottom 3D is also among the lowest-accuracy concepts in both modalities — **shortcut use rises where the intended abstraction is not available to the model**, which is the behaviour a prior-deficit predicts and a capability-deficit does not.

---

## The modality result, and which lever moves which modality

Accuracy (`pass@1`, %), textual / visual:

| Model | low | medium | low + tools | medium + tools |
|---|---|---|---|---|
| o3 | 68.3 / 6.7 | 77.1 / 5.6 | 67.9 / 18.1 | 75.6 / **29.2** |
| o4-mini | 52.1 / 3.8 | 70.8 / 8.1 | 57.3 / 6.7 | **77.7** / 25.0 |
| Claude Sonnet 4 | — | 60.2 / 5.2 | — | 55.0 / 6.9 |
| Gemini 2.5 Pro | — | 66.0 / 4.2 | — | 60.4 / 5.8 |
| Humans | | **73** (`pass@1`, images) | | |
| GPT-4o / Llama 4 Scout / Qwen 2.5 VL 72B (non-reasoning) | | 14.6 / 6.7 / 9.2 textual; **0.0** visual for all three | | |

- **Reasoning effort buys the textual modality; tools buy the visual one.** Low→medium in text: +9 to +19 points. Low→medium in vision without tools: ~0. Adding Python (i.e. OpenCV-style parsing of the image) in vision: +12 to +24. The models spend the extra visual budget *executing more code*, not thinking longer — consistent with the reported failure of test-time scaling to transfer to visual modalities.
- **A perception bottleneck, quantified.** Visual-error rate 49–77% with rule–grid alignment above 93%, and the commonest single failure is not recognising the grid's dimensions from the image. The wiki should stop treating the ARC-in-text presentation as the handicap: for frontier models, **rendering the same task as an image costs 40–60 accuracy points**, so serialising 2-D structure into row-major text is the *cheap* channel ([[wiki/empirical-tensions.md]] T212, T215).
- **Format leniency is not the story.** Re-scoring outputs in non-requested-but-unambiguous grid formats moves most cells by <3 points; the largest single change is Claude medium textual, 60.2 → 72.5.

---

## Coverage, and the panel that does not help

A task counts as *covered* if the solver produced the intended rule in any of its solutions for that task in that modality.

| | Textual | Visual |
|---|---|---|
| o3 | 85.8% | 58.5% |
| Claude Sonnet 4 | 72.1% | 17.3% |
| Gemini 2.5 Pro | 67.9% | 29.3% |
| **Any of the three** | **94.6%** | **66.7%** |
| Humans (any participant, images) | **99.2%** (476/480) | |

Pooling three frontier models adds **+9 points** over the best of them in text and +8 in vision — the three miss largely the *same* tasks, so their intended-rule failures are correlated. The human panel leaves 4 of 480 tasks uncovered, and that is a lower bound (rules were never collected for humans who produced wrong grids). **(brainstorm)** Correlated failure across three independently-trained frontier systems is the strongest evidence in the wiki that the missing prior is *shared and structural* rather than a per-model training accident — the same conclusion [[wiki/concepts/core-knowledge.md]] argues from developmental data, arrived at from the machine side.

---

## Per-concept: the two extremes name the deficit

| Concept | o3 textual − human | o3 visual − human | What the tasks require |
|---|---|---|---|
| **Count** | **+32.3** | −7.7 | Output is a single small row/column encoding a count — the grid is nearly free to construct |
| **Clean Up** | **−46.3** | **−65.7** | Remove several colours/shapes/stray pixels and **reproduce the rest of the input grid exactly** |

The paper's reading, and the wiki should carry it: *"models struggle significantly with producing complex output grids", regardless of modality.* Construction cost is a confound in every ARC-family score — a solver may hold the rule and lose the point to output length. No benchmark in the wiki separates the two, and this is the cheapest evidence that they need separating.

---

## What it decides for a builder

1. **A tenth instrument for [[wiki/concepts/shortcut-learning.md]], and the first that needs no distribution shift, no second model, no controlled dataset and no partition of the item set** — only that the solver be asked to say what it did, plus a faithfulness check. Its cost is the mirror image: it needs a human rater and an author-declared intended abstraction, so it runs only on benchmarks built around named concepts.
2. **It scores the framing stage separately from the optimisation stage** ([[wiki/concepts/problem-framing.md]]). "Intended rule stated, wrong grid emitted" is framing-correct-and-optimisation-failed, measured; "wrong rule, correct grid" is the reverse. That is the wiki's only quantitative decomposition of a score into the two halves that page argues are conflated everywhere.
3. **It supplies a training target, not just a metric.** The authors' stated next step is process-based reward models or direct inclusion of human reasoning traces — i.e. supervising the *rule* rather than the answer. That is the loss lever from `shortcut-learning`'s control surface, aimed at the one place where an accuracy-shaped loss is silent: two rules that agree on the demonstrations are indistinguishable to it.
4. **`pass@1`, reported for humans and machines on the same items** — which is the commensurable first-attempt number [[wiki/empirical-tensions.md]] T213 says nobody had collected for ARC (gap G74).

---

## Open problems

- **The classification has no algorithmic form.** Manual, subjective, consensus-mediated; the authors state they know of no objective procedure. Until one exists the instrument does not scale, and the intended/unintended boundary is the rater's.
- **Faithfulness is measured, not guaranteed.** >90% alignment on this task family says nothing about a domain where the answer is not a checkable artefact the rule visibly generates.
- **Only one benchmark, and the easiest one.** The authors concede ARC's own test sets may be more shortcut-resistant, and that nobody has looked. Compositional tasks (ARC-AGI-2) would need the intended abstraction disentangled into several, which is why ConceptARC was chosen.
- **Solicited rules may not be the rules used.** The rule is generated in the same forward pass as the grid, so it is a *joint output*, not a post-hoc report — which helps alignment and makes it impossible to say whether requesting the rule changed the solution.
- **High effort untested.** o3-high and larger Claude/Gemini budgets were not run for cost reasons, and effort is the lever that moves textual rule correctness.
- **Rules were never collected from failing humans**, so every human/machine comparison on the incorrect-grid half of the table is one-sided.

---

## Connections

- **[[wiki/entities/conceptarc.md]]** — the benchmark this instrument runs on, and the reason it can: the 16 concept groups supply the *author-declared intended abstraction* without which "correct-unintended" has no referent; this page is that benchmark's first evaluation to use the concept labels as a scoring target rather than as a reporting axis.
- **[[wiki/concepts/shortcut-learning.md]]** — supplies that page's tenth diagnostic and its cleanest human/machine calibration: on identical items, humans reach a right answer by an unintended rule 2.7% of the time and frontier models 15–29%, so shortcut *propensity* is measured rather than inferred from an o.o.d. drop.
- **[[wiki/concepts/problem-framing.md]]** — the quantitative decomposition that page's split predicts: rule-correct/grid-wrong is framing without optimisation (o3 visual, 19.6% of tasks) and rule-wrong/grid-correct is optimisation without framing (o3 textual, 15.8%), and only a two-channel score sees either.
- **[[wiki/concepts/nameability.md]]** — the machine-side counterpart of that page's human descriptions: both collect a natural-language rendering of an ARC rule from the solver, one to predict difficulty and one to classify strategy, and neither has a semantic (rather than lexical or manual) scoring procedure.
- **[[wiki/concepts/representation-probing.md]]** — a probe that needs no decoder, no labels over activations and no ontology, because the system emits the hypothesis itself; its faithfulness question (does the report describe the computation?) is answered here by rule–grid alignment, which is the behavioural analogue of that page's decoded-but-unused test.
- **[[wiki/entities/arc-agi.md]]** — the benchmark whose headline o3 result this paper re-examines on an easier relative: the same prompt and the same model family, scored on the abstraction rather than the grid, gives a materially weaker claim than 87.5% supports.
- **[[wiki/concepts/core-knowledge.md]]** — the negative measurement: on a corpus built around objectness, number and geometry, model rules operate on pixels, colour integers and connectivity heuristics, and the three frontier systems fail on largely the *same* tasks — a shared missing prior rather than three independent training gaps.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the modality result in that page's terms: a vision-language model that states the correct relational rule and then mis-reads the grid it must apply it to has bound the concept and not the percept, which is the reverse of the noun-binds/relation-fails pattern that page reports.
- **[[wiki/concepts/external-verification.md]]** — the rule is the checkable intermediate that page's ladder wants: it can be tested against the demonstrations before the test grid is answered, and 12.7% of o3's textual tasks are `CU`-rule-with-correct-grid, i.e. cases a demonstration-side verifier would pass and a concept-side verifier would not.
- **[[wiki/concepts/test-time-training.md]]** — the modality asymmetry bounds it: test-time compute buys 9–19 points in text and ~0 in vision, where the same budget is spent invoking computer-vision libraries instead, so scaling inference is a lever on search and not on perception.
- **[[wiki/entities/poe-arc-solver.md]]** — the contrast case on the same benchmark: 73.3% two-guess accuracy from an 8B transduction model with no rule, no object parse and nothing to classify — high score, zero rule-level evidence, which is exactly the reporting regime this page argues against.
- **[[wiki/entities/pgm.md]]** — the 2018 precedent for this page's proposed training lever, with its limit already measured: supervising a 12-bit symbolic encoding of the matrix's relations, objects and attributes alongside the answer is worth +13.9 points and nearly doubles the recombination regimes, while moving the novel-constituent regimes by ≤2 points — and the accuracy split by whether that rule was predicted correctly (87.4% vs 34.8%) is this page's find-the-rule/apply-it factorisation obtained from the training target instead of from a human rater.
- **[[wiki/entities/gsm8k.md]]** — the same certification failure at training time rather than at scoring time: the verifier's labels come from the final answer alone, so a solution reaching the right number through invalid reasoning is a *training positive* by construction — the authors say so, and every outcome-supervised reward model inherits it.
