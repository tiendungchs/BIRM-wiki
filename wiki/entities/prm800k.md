# PRM800K / Process Supervision

**A dataset of 800,000 human step-level correctness labels on model-generated MATH solutions, and the controlled comparison it was built to run: at matched data scale, supervising *every step* trains a strictly better selector than supervising *the answer* — the margin being credit assignment, not accuracy.**

> **Provenance.** Lightman, Kosaraju, Burda, Edwards, Baker, Lee, Leike, Schulman, Sutskever & Cobbe 2023, *Let's Verify Step by Step* (`raw/lightman-2023-lets-verify-step-by-step.md`, OpenAI). All numbers are the paper's own. The wiki has carried this result second-hand since [[wiki/concepts/external-verification.md]] ("~78% on a representative subset"); this is the primary source. ORM/PRM = Outcome- / Process-supervised Reward Model; RM = reward model; MV = majority vote; QC = quality control; AP = Advanced Placement; AMC = American Mathematics Competitions. Dataset at `github.com/openai/prm800k`.

---

## What was built

| Component | Specification |
|---|---|
| **Generator** | GPT-4 finetuned for one epoch on correct few-shot solutions, *only* to fix a newline-delimited step format. Frozen. **No RL on the generator anywhere in the paper.** |
| **MathMix** | 1.5B-token math pretraining stage before any finetuning (275M problems+solutions, ~880M free-form discussion, 130M synthetic, 500M critiques). No general language data mixed in; contrast Minerva's 38.5B tokens with 5% natural language |
| **PRM800K** | 800K filtered step labels / 75K solutions / 12K problems (unfiltered: 1,085,590 labels over 101,599 samples). Labels are `positive` / `negative` / `neutral` — neutral = "reasonable and correct but does not progress", deferring the ambiguity decision to test time |
| **PRM** | Predicts the label token after the last token of each step; one forward pass scores every step. Solution score = **∏ step-correctness probabilities**, neutral counted positive |
| **ORM** | Trained on 100 uniform samples/problem, target = final-answer check, score = last-token prediction. Method of Cobbe et al. 2021 ([[wiki/entities/gsm8k.md]]) |
| **Evaluation** | Best-of-`N` over uniform generator samples on a **500-problem** held-out MATH subset ([[wiki/entities/math-dataset.md]]); the RM picks, the answer is auto-graded |

**The labelling rule that carries the paper's cost argument: supervision stops at the first incorrect step.** For a correct solution both regimes assert the same thing (every step is correct); for an incorrect one both reveal that a mistake exists and process supervision adds only its *location*. The stated consequence is the load-bearing one for the wiki's ladder — *"without relying on an easy-to-check final answer, determining the correctness of a solution is equivalent to identifying its first mistake."*

---

## Results

| Measurement | ORM | PRM | Majority vote |
|---|---|---|---|
| MATH-500, best-of-1860 | — (slightly above MV) | **78.2%** | baseline |
| Best-of-`N` trend | above MV, flat-ish | **gap widens with `N`** | — |
| OOD: AP Calculus / Chemistry / Physics / AMC10-12, best-of-100 | 63.8% | **72.9%** | 61.3% |
| MATH-500 scoring reduction (PRM only) | — | ∏·neutral=pos **78.2** > min·neutral=neg 77.8 > min·neutral=pos 77.6 > ∏·neutral=neg 77.4 | — |

- **The OOD set is uncontaminated by construction**: 234 questions (the text says 224; the table's rows sum to 234 — an unreconciled discrepancy in the source) from exams released *after* the pretraining cutoff. The ordering survives the shift.
- **RM-weighted voting (PRM × frequency) did not beat the PRM alone** — unlike Cobbe et al., where rank and frequency were complementary at 100 samples.

**The large-scale comparison is confounded and the authors say so:** the ORM's training set is an order of magnitude larger, has no overlap with PRM800K, and is uniformly sampled, while PRM800K is actively selected and 86% wrong-answer. The clean experiment is the synthetic one.

### The clean ablation: a large PRM as a labelling oracle

Human feedback is too expensive to ablate, so `PRM_large` supervises small models (~200× less pretraining compute) on *identical* solution sets, varying only the supervision. A step counts negative if `PRM_large` gives it >20% negative probability — a threshold chosen because **`PRM_large` is itself miscalibrated toward positive labels** ([[wiki/concepts/confidence-calibration.md]]).

| Supervision of the small RM | Best-of-500 result |
|---|---|
| Process, from `PRM_large` | **Best at every data scale** |
| Outcome, from `PRM_large` | Middle |
| Outcome, from final-answer checking | Worst |

Two things fall out. (i) Process wins *at matched data*, so the large-scale margin is not an artefact of the active-learning bias. (ii) The gap between the two outcome rows is the **false-positive channel** priced in isolation: final-answer grading rewards correct answers reached by invalid reasoning, and removing just that defect — while keeping the signal outcome-shaped — recovers part of the process margin. The authors decline to say which outcome baseline is "correct" and note that MATH over-represents false positives relative to harder domains.

### Active learning: 2.6× data efficiency

Surface to labellers the **convincing wrong-answer** solutions — highest-scoring under the current best PRM among those with an incorrect final answer, so the PRM is *known* to be wrong about at least one step. In the ablation, `N` samples per problem chosen 80% most-convincing-wrong / 20% most-convincing-remaining, scored by `PRM_large`: **≈2.6× the data efficiency of uniform labelling**, read off the slopes of the fitted lines.

Two negative results ship with it, and both are worth more than the headline:

| Negative result | What it bounds |
|---|---|
| The largest active-learning point (200 of a 1000-sample selection pool) **falls below its own trend line** | Active selection has a **diversity ceiling** set by the pool: once the selected fraction is large, "most informative" and "representative" collide. The efficiency multiplier is not a constant |
| Iteratively retraining `PRM_selector` during collection was **unstable, gave no gain, and the instability was never diagnosed** | The obvious closed loop (select → label → retrain the selector → select) does not just work. The paper's own large-scale collection *did* retrain across 10 generations; the controlled version of that loop failed |

Also on the pipeline: finetuning an LM into a step classifier is *"a large distribution shift"* requiring low learning rates for stable training; and the ∏ reduction carries **a bias against solutions with more steps**, i.e. the selector has a length prior nobody asked for.

### Difficulty breakdown — the result that constrains T220

Split by generator pass-rate quintile, the PRM/ORM gap is present at **every** difficulty, not only the hard end. And on the **easiest** quintile the **ORM's accuracy decreases as `N` grows** — "adversarial examples that fool the ORM" — while **the PRM stays flat-to-rising out to `N` = 1,860**. Two learned scorers, one paper, one candidate pool, opposite signs of `d(score)/d N` ([[wiki/empirical-tensions.md]] T220).

---

## The prior contradiction, and how it resolves

Uesato et al. 2022 found process and outcome supervision reached **similar** final-answer error on GSM8K. This paper finds process ≫ outcome on MATH. The reconciliation offered is **scale of supervision**, and the data-scaling ablation supports it directly: at small supervision volumes the two curves coincide; process pulls away as it is scaled. This is a resolved disagreement rather than a live tension, and the shape of the resolution is worth keeping — *"a small amount of process supervision and a large amount of outcome supervision lead to similar performance."*

---

## What the wiki should take

1. **The ladder's cost column is wrong outside auto-checkable domains.** [[wiki/concepts/external-verification.md]] prices the ORM rung as cheap (a trained model) and the PRM rung as expensive (step-level labels). That ordering holds *only* because MATH has a machine-checkable final answer. Where it does not, a human establishing outcome correctness must find the first mistake anyway — so the two rungs cost the same and the outcome rung has no reason to exist. **The cheap-outcome-supervision regime is a property of benchmark design, not of supervision.** Every domain this wiki actually targets (perception, planning, world modelling) is on the wrong side of that line.
2. **The credit-assignment argument is the transferable part, and it is architecture-agnostic.** The stated mechanism: on hard problems nearly every sampled trace contains *some* error, so the marginal information in a negative outcome label goes to zero, while a process label always returns *how many leading steps were correct* plus *where it broke*. This is a statement about the information content of a scalar reward at the end of a long trajectory — the same quantity that makes long-horizon RL hard and that [[wiki/concepts/biologically-plausible-credit-assignment.md]] exists to address. **A rejector that returns one bit at the end is nearly useless exactly where reasoning is hard.**
3. **The frozen-generator scope closes the Goodhart channel by construction.** No RL on the generator: the PRM is only ever a *reranker* over uniform samples it did not shape. So the paper's "process supervision incurs a **negative alignment tax**" (safer *and* stronger) is measured in the one setting where a policy cannot learn to exploit the scorer. It is evidence about verifier *reliability*, and it is not evidence on [[wiki/empirical-tensions.md]] T181 — which is about what happens when a policy is optimised against the verifier. *(brainstorm)* The two results in the paper that would most change if RL were added run in opposite directions: the PRM's step-locality gives an optimising policy a much richer surface to hack (each step is now an independently satisfiable target), while the ORM's easy-quintile turn-down shows a policy-free search already finding its adversarial region at `N` ≈ 10³.
4. **`(brainstorm)` "Convincing wrong-answer" is a general active-learning rule for any proposer/rejector pair, and it is the rejector's own residual.** The selection criterion is *the rejector scores it high ∧ an independent test says it is wrong* — i.e. label exactly where the two acceptance tests on [[wiki/concepts/external-verification.md]]'s ladder disagree. It needs no uncertainty estimate, no ensemble, no gradient: only two rungs and a disagreement. This is directly portable to any wiki architecture with both a cheap learned scorer and an expensive sound check, and it is the counterpart of [[wiki/entities/anli.md]]'s "model-wrong ∧ human-right" rule, obtained without human authoring.
5. **The dataset's construction voids the MATH test split for anyone who uses it.** 4,500 of MATH's 5,000 test problems were moved *into* PRM800K's training set to avoid overfitting the 7,500 training problems; evaluation runs on the remaining 500. Any downstream system trained on PRM800K and evaluated on full MATH-test is reporting a contaminated number by inheritance ([[wiki/concepts/benchmark-contamination.md]]), and PRM800K is one of the most widely reused process-supervision corpora in existence.

---

## Limitations

| Limitation | Consequence |
|---|---|
| Generator never trained with the RM | The paper measures a **selector**, not a reasoner — Position A of [[wiki/empirical-tensions.md]] T180 by construction |
| One domain, one dataset | The alignment-tax and process-margin claims are MATH-only; the authors state generalisation is unknown |
| MATH test contamination unquantifiable | String-matching decontamination of MathMix only; the argument against it is indirect (low generator pass-rates, OOD replication) |
| Labellers had ground-truth final answers | Step labels are conditioned on knowing the destination — the annotator is doing backward reasoning the PRM must learn to do forward |
| Labeller agreement floor: **75%** with gold on 30 QC items | The PRM's ceiling is a noisy human process; no inter-annotator agreement figure is reported for the corpus |
| No result past the PRM's own maximum | Best-of-`N` stops at 1,860; whether the PRM has a peak is unmeasured (T220) |

---

## Connections

- **[[wiki/concepts/external-verification.md]]** — the primary source for that page's ORM→PRM rung, and a correction to its cost column: step-level labels are only *more* expensive than outcome labels where the final answer is machine-checkable, since establishing outcome correctness by hand is the same act as finding the first mistake. It also supplies the clean version of the comparison (a large PRM as a labelling oracle for small models, so supervision varies with the data held fixed) and prices the false-positive channel separately from the localisation channel.
- **[[wiki/entities/math-dataset.md]]** — the substrate: every solution here is a GPT-4 sample on a MATH problem, graded by that dataset's `\boxed{}` normalised exact match. The relationship is also a hazard — 4,500 of MATH's 5,000 test problems live inside PRM800K's *training* set, so the benchmark and its most-reused supervision corpus overlap by construction.
- **[[wiki/entities/gsm8k.md]]** — the ORM this paper trains is Cobbe et al.'s token-level verifier unchanged, and the two papers' disagreement resolves on supervision scale: process ≈ outcome at the volumes GSM8K-era work used, process ≫ outcome when scaled. The inverted-U that page reports at ~400 candidates reappears here only for the ORM, and only on the easiest problems.
- **[[wiki/concepts/benchmark-contamination.md]]** — a contamination route that no detector on that page can see: the leak is not a corpus overlap but a *deliberate, documented* migration of 4,500 test items into a public training set, inherited by every model finetuned on PRM800K and invisible to a train-vs-test familiarity difference because both splits are now training data.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — the same problem stated for a supervision signal rather than for a weight update: a scalar at the end of a long trace carries almost no information about which step to blame, which is why a per-step label is worth more than an order of magnitude more outcome labels here.
- **[[wiki/concepts/confidence-calibration.md]]** — the oracle used to replace human labels is *known to be miscalibrated toward positive*, and the correction is a hand-picked 20% threshold rather than a fitted temperature; the whole synthetic-supervision result rests on that constant.
- **[[wiki/concepts/selective-prediction.md]]** — the complementary reading of the step-level score: a per-step correctness probability is exactly the ingredient a selection function needs to abstain *mid-derivation* rather than at the end, and no experiment here uses it that way.
- **[[wiki/concepts/rule-level-evaluation.md]]** — the same move one level up: supervise the stated reasoning rather than the answer. This paper is that proposal executed at industrial scale in a domain where steps are enumerable; [[wiki/entities/pgm.md]] is the 2018 precedent with the rule compressed to 12 bits.
- **[[wiki/entities/hle-verified.md]]** — the supply-side objection to this paper's premise: reference rationales in benchmarks are majority-invalid where audited, and their dominant defect is a *missing* intermediate step. A step-label corpus collected on such traces would teach a PRM to accept gaps; PRM800K's labellers judged model traces against a known answer, which is a different and better-controlled process than reusing shipped reference solutions.
- **[[wiki/entities/anli.md]]** — the same active-learning principle with a human in the rejector's seat: label where a cheap scorer is confident and a sounder test disagrees. There the disagreement is "model-wrong ∧ human-right" at the cost of an authoring pass; here it is "PRM-confident ∧ answer-wrong" at the cost of one automatic check.
- **[[wiki/entities/pgm.md]]** — the 2018 precedent, and the contrast that dates the idea: supervising the symbolic structure behind the answer instead of the answer, worth +13.9 points with the target compressed to a 12-bit vector and generated for free by the task generator. Five years later the same move needs 800K hand-placed labels because the intermediate object is a natural-language step rather than a declared triple — the price of process supervision is set by whether the process is machine-representable.
