# MATH and AMPS — the benchmark where emitting a chain of thought made the model *worse*

**MATH (Mathematics Aptitude Test of Heuristics) is 12,500 US competition problems (7,500 train / 5,000 test) in LaTeX, each carrying a full natural-language step-by-step solution and a final answer wrapped in `\boxed{}`, which makes a free-generation task automatically scoreable by exact match. AMPS is its 23 GB companion pretraining corpus. The result the wiki needs is not the benchmark: it is that in 2021, letting a model write out its derivation before answering *lowered* accuracy (6.9% → 5.3%), while *training* on the same derivations raised it — and that a model handed 99% of the ground-truth solution still only reached ~40%.**

> **Provenance.** Hendrycks, Burns, Kadavath, Arora, Basart, Tang, Song & Steinhardt 2021, *Measuring Mathematical Problem Solving With the MATH Dataset* (`raw/hendrycks-2021-math-dataset.md`, NeurIPS Datasets & Benchmarks Track). All numbers are the paper's own. The wiki has carried MATH second-hand since [[wiki/concepts/external-verification.md]] (as the substrate for PRM800K and the "90% on MATH" ambiguity complaint); this is the primary source. AoPS = Art of Problem Solving; AMC/AIME/IMO = American Mathematics Competitions / American Invitational Mathematics Examination / International Mathematical Olympiad.

---

## The artefact

| Property | Value |
|---|---|
| Size | 12,500 problems — 7,500 train, 5,000 test |
| Source | AMC 10, AMC 12, AIME and other US competitions, spanning decades |
| Subjects | Prealgebra, Algebra, Number Theory, Counting & Probability, Geometry, Intermediate Algebra, Precalculus |
| Difficulty | Level 1–5 per problem, **inherited from AoPS**, per subject (early AMC 8 items ≈ 1, AIME ≈ 5) |
| Encoding | LaTeX throughout; **figures in the Asymptote vector language, not raster** — so a pure text model can be scored on geometry for the first time |
| Answer | A unique expression inside `\boxed{}`, normalised (fractions, units, spacing, factor order, variable order, decimal/fraction equivalence) |
| Side information | A **full step-by-step human solution for every problem** |
| Metric | Exact match after normalisation |

**AMPS** (Auxiliary Mathematics Problems and Solutions), the pretraining corpus:

| Component | Volume | Step-by-step solutions |
|---|---|---|
| Khan Academy | 693 exercise types, >100,000 problems | Yes, all |
| Mathematica scripts | **100 hand-designed** scripts × ~50,000 = ~5M problems | 37 of 100 scripts |
| Total | 23 GB (vs 16 GB of text for BERT) | — |

---

## Why the format matters: a free-generation task that grades itself

The paper's benchmark-design contribution, and the reason the wiki should hold it separately from the scores. Three prior options and what each costs:

| Approach | Acceptance test | Cost |
|---|---|---|
| Formal theorem proving (HOList, Metamath, Coq) | Kernel — exact | Statement must be formalised first; the model is scored on a language humans do not write mathematics in |
| Multiple choice (AQuA, MathQA) | Index match | A candidate set is a shortcut channel — cf. [[wiki/entities/raven.md]], where the distractors alone are worth >90% |
| Free-form text | BLEU or a human | Heuristic; not automatable |
| **MATH** | **Exact match on a delimited, normalised answer** | Only the *answer* is checked; the derivation is unverified |

The `\boxed{}` delimiter is doing the work: it gives a **unique answer in a well-defined location inside an unconstrained generation**, which is what allows a model to emit an arbitrary derivation and still be graded mechanically. Every rung-0 grader in [[wiki/concepts/external-verification.md]]'s ladder inherits this design, and so does the RLVR training signal built on it.

**And it is the origin of that ladder's bottom-rung failure.** The authors state their normalisation rules "cover nearly all ways that different generated or actual solutions can be equivalent in practice". Raiyan et al. 2026 report that up to **38%** of responses flagged incorrect by rule-based graders were in fact correct. Both claims are about the same instrument; see [[wiki/empirical-tensions.md]] T218.

---

## Results

All GPT-2 models pretrain on AMPS; GPT-3 models do not (API limit). `*` = few-shot (8 problems, answers only), otherwise fine-tuned. Beam search, beam 20 for answer-only.

| Model | Prealg. | Alg. | Num. Th. | Count. & Prob. | Geom. | Int. Alg. | Precalc. | **Average** |
|---|---|---|---|---|---|---|---|---|
| GPT-2 0.1B | 5.2 | 5.1 | 5.0 | 2.8 | 5.7 | 6.5 | 7.3 | **5.4** |
| GPT-2 0.3B | 6.7 | 6.6 | 5.5 | 3.8 | 6.9 | 6.0 | 7.1 | **6.2** (+15% rel.) |
| GPT-2 0.7B | 6.9 | 6.1 | 5.5 | 5.1 | 8.2 | 5.8 | 7.7 | **6.4** (+19%) |
| GPT-2 1.5B | 8.3 | 6.2 | 4.8 | 5.4 | 8.7 | 6.1 | 8.8 | **6.9** (+28%) |
| GPT-3 13B* | 4.1 | 2.4 | 3.3 | 4.5 | 1.0 | 3.2 | 2.0 | **3.0** (−44%) |
| GPT-3 13B | 6.8 | 5.3 | 5.5 | 4.1 | 7.1 | 4.7 | 5.8 | **5.6** (+4%) |
| GPT-3 175B* | 7.7 | 6.0 | 4.4 | 4.7 | 3.1 | 4.4 | 4.0 | **5.2** (−4%) |

By difficulty (GPT-2 1.5B): ~15% at level 1, ~4% at level 5.

**Human baseline** — 20 randomly sampled test problems, 1 hour, calculations by hand, university students, `n = 1` per row:

| Participant | Score |
|---|---|
| Dislikes mathematics (CS PhD student) | 8/20 = **40%** |
| Ambivalent | 13/20 |
| Likes mathematics | 14/20, 15/20 |
| Perfect AMC 10, several USAMO appearances | 18/20 |
| **Three-time IMO gold medalist** | 18/20 = **90%** (misses were arithmetic slips) |

---

## The scratch-space inversion — the load-bearing result

Three interventions, all using the same step-by-step solutions, in opposite directions:

| Intervention | Model | Effect |
|---|---|---|
| **Generate** a full solution, then the boxed answer | GPT-2 1.5B | 6.9% → **5.3%** — *worse* |
| **Train** on solutions (vs. answer-only fine-tuning) | GPT-2 1.5B | 6.3% → **6.9%** — better, ~10% relative |
| **Read** a partial ground-truth solution as a hint | GPT-2 0.7B | 0% of solution ≈ 6% → 99% of solution ≈ **40%** |

The authors' hypothesis for row 1 is **snowballing**: a partially generated solution containing a mistake derails the subsequent generation. Their qualitative read is consistent — generated LaTeX is well-formed and the steps are on-topic, and the logic is wrong (Fig. 3 shows a solution reaching the correct answer `8` through an invalid QM-AM step).

**Why this belongs to the wiki rather than to history.** [[wiki/concepts/refinement-loop.md]] defines the mechanism as *candidate `n+1` is a function of the feedback on candidate `n`*, and lists "chain-of-thought / latent space" as one of six substrates carrying the 2025 ARC results. MATH 2021 is that loop run **with the feedback channel removed**: the model conditions on its own previous tokens with nothing checking them. The three rows above are the cleanest decomposition in the wiki of what a trace is worth in each role:

- as **training signal** (a correct trace, external): positive;
- as **conditioning input** (a correct trace, external): very positive, +34 points;
- as **self-generated context** (an unverified trace, internal): negative.

*(brainstorm)* The natural reading is a **threshold on per-step reliability**. If a trace of `k` steps is generated autoregressively and each step is independently valid with probability `p`, conditioning on the prefix buys decomposition and costs `1 − p^k` of contaminated context; the intervention is net-positive only above some `p*` set by how strongly a wrong prefix attracts the continuation. Everything that made chain-of-thought work after 2021 — scale, instruction tuning, RL on verified outcomes, sampling many traces and voting, process reward models — is a way of raising `p` or of *escaping* the single-trajectory regime by adding the missing rejector. This predicts that the 2021 result should be reproducible today at any fixed model by degrading `p` (temperature, a weak base model), and that no amount of "reasoning mode" helps a system whose steps are below `p*`. Nobody has drawn that curve; it is the sharpest version of [[wiki/empirical-tensions.md]] T217.

**The 99%-hint ceiling is a second, separate finding, and it is worse than it looks.** Given the entire ground-truth derivation minus the final answer, the model gets 40%. So the failure is not only in *finding* a derivation — it is in *executing* one that has been handed over. Search and step-execution fail separately, which is the same two-way split [[wiki/entities/neo-neural-theorizer.md]] shows for vocabulary-vs-search ([[wiki/empirical-tensions.md]] T156), here obtained by conditioning rather than by sampling. It is also a cheap, general instrument: **the hint curve** — accuracy as a function of the fraction of the ground-truth derivation supplied — is collectable on any benchmark with worked solutions, needs no distribution shift and no ontology, and reads out where in the pipeline the competence is missing. The wiki's G17 instrument list does not contain it.

---

## Curated data substitutes for scale, and real-world data does not

| Comparison | Result |
|---|---|
| GPT-2 **0.1B** + AMPS pretraining vs GPT-3 **13B** fine-tuned without AMPS | 5.4% vs 5.2% (§4.2 text; the results table gives 5.6% for the same row) — **AMPS ≈ a 130× parameter increase** |
| GPT-2 0.3B, AMPS alone vs AMPS + Math StackExchange (~3 GB of real questions and answers) | **6.2% vs 6.0%** — adding diverse real-world mathematics *hurt* |

The second row is the more interesting one. A hand-designed generator over 100 named topics beat a larger, messier, genuinely human corpus at the same task. In [[wiki/concepts/skill-acquisition-efficiency.md]]'s accounting, AMPS is a **`P` term the developer authored** — 100 Mathematica scripts covering conic sections, divergence and curl, KL divergence, eigenvalues, polyhedra, Diophantine equations — and its measured exchange rate against parameters (130×) is one of the few explicit prices in the wiki for injected prior versus scale. It is also a data point for [[wiki/concepts/latent-graph-discovery.md]]'s framing: what the curated corpus supplies is *coverage of the primitive vocabulary*, and what it does not supply is the composition, which is where MATH's difficulty lives.

---

## The scaling extrapolation, and what happened to it

Fitting a log-linear trend to the GPT-2 series, the authors project that **~10³⁵ parameters** would be needed for 40% accuracy, conclude that scale will not solve MATH, and state that "new algorithmic advancements" are required. Their framing: while enormous Transformers were solving SuperGLUE, LogiQA, symbolic integration and (per Henighan et al. 2020) most of the DeepMind Mathematics dataset automatically, MATH resisted.

**MATH was above 90% within roughly three years** — via chain-of-thought that works, verifier-selected sampling, and RL on verifiable rewards, with PRM800K's step labels built directly on this dataset `(external to this source; see [[wiki/concepts/external-verification.md]])`. The authors' *conclusion* was right and their *curve* was void, and the two facts are the same fact: **a scaling extrapolation holds the algorithm fixed, so it is a statement about one algorithm family and never about a task.** The specific irony belongs on the record — the intervention that broke the extrapolation is generating a step-by-step derivation before answering, the exact intervention this paper measured as *negative*.

For the wiki this is a discipline claim, not a historical note: every "scale will/won't solve X" argument in the ARC pages ([[wiki/entities/arc-agi.md]], [[wiki/entities/arc-agi-2.md]]) is the same shape of extrapolation, and MATH is the case where it is settled and the answer is that the curve told you nothing about the discontinuity. See [[wiki/empirical-tensions.md]] T219.

---

## Self-confidence is not a verifier — measured

Confidence defined as the mean token probability of the generated answer. GPT-2 1.5B is **highly overconfident** (confidences often ~100%), and the AUROC for separating correct from incorrect answers is **68.8%** (50% = chance, 100% = perfect).

This is the wiki's first direct measurement of the question [[wiki/concepts/external-verification.md]] closes on — *is there an internal verifier that is not the generator?* — and the answer here is a number close to useless. It is the negative control that justifies the entire verifier apparatus built on this dataset afterwards: outcome reward models, process reward models, best-of-`k` reranking all exist because the generator's own likelihood ranks its outputs at 68.8%.

**This number is a type-2 ROC and it is reported uncorrected.** `AUROC2` — the area under the curve traced by sweeping a confidence criterion over the (correct, incorrect) split — is the metacognition literature's standard bias-free *sensitivity* measure, and Galvin et al. 2003 prove it depends on first-order task performance as well as on introspective ability ([[wiki/concepts/metacognitive-efficiency.md]]). At 6.9% accuracy the correction is not a small one, and its **sign is not known here**: the ceiling result is derived for a bounded response set, where a low-`d′` solver's correct answers are flukes with no internal correlate, and MATH is free generation into an unbounded answer space where chance is ≈0 and a correct answer is therefore *not* a fluke. That is the same property that leaves type 1 `d′` — and hence `meta-d′/d′` — undefined on this benchmark. So the reading the page uses the number for survives (a same-forward-pass confidence is not a verifier), and the reading "this model has poor self-knowledge" does not: the shortfall from 100% has an unmeasured task component, and separating it needs the multiple-choice slice of some benchmark, not this one.

---

## Limitations

- **Human baseline is `n = 1` per level over 20 items.** Every human number on this page is a single participant's score on a 20-problem sample; the 40–90% spread is real but its endpoints are anecdotes. Contrast [[wiki/entities/conceptarc.md]] (415 participants) and [[wiki/entities/arc-agi-2.md]] (407, calibrated to ≤1pp).
- **Only the answer is graded.** A correct answer via an invalid derivation scores full marks, and Fig. 3 contains one. This is the answer/proof split [[wiki/concepts/external-verification.md]] records as an unclosed gap (>90% on AIME-style final answers vs ~10/42 on USAMO-style proofs).
- **Difficulty is inherited, not measured.** Levels 1–5 come from AoPS annotators; no per-item difficulty statistic is collected at authoring time — the same audit gap G17 records against ARC and that [[wiki/entities/anli.md]] closes by construction.
- **No contamination audit.** The problems are drawn from decades of public competitions and are extensively discussed on the open web, including on AoPS itself. The paper does not measure train/pretrain overlap; every later score on MATH inherits that. **A third party has since supplied one, and the test split fails it**: Xu et al. 2024 ([[wiki/concepts/benchmark-contamination.md]]) find models reproducing all five sampled 5-grams in MATH *test* items — 25 for Qwen-1.8B, 8 for Qwen-14B, 7 for Aquila2-34B under exact match, rising ~2× under a lenient match — which is the split-voiding cell of the leakage taxonomy, not the disclosed-training cell. Contrast GSM8K, whose test split shows zero such items.
- **Models are dated.** GPT-2 and GPT-3, beam search, no instruction tuning. The dataset and the three trace experiments are the export; the accuracies are a 2021 snapshot.

---

## Comparison

| | MATH | [[wiki/entities/arc-agi.md]] | [[wiki/entities/anli.md]] | [[wiki/entities/pgm.md]] |
|---|---|---|---|---|
| Item origin | Human competitions, decades of them | Hand-authored to a prior spec | Human, adversarial vs. the model | Symbolic generator |
| Prior required | **Years of mathematics education** | Core Knowledge only | Language + world knowledge | Visual, minimal |
| Answer format | Free generation, delimited | Grid, exact | 3-way label | 8-way choice |
| Derivation supplied? | **Yes, for every item** | No | Free-text "reason", not a derivation | Symbolic `[r,o,a]` triples as auxiliary target |
| Auto-gradeable | Yes, by normalisation | Yes | Yes | Yes |
| Difficulty measured per item | Inherited from AoPS | No | **Yes** (tries, seconds) | Declared as held-out abstraction |
| Saturated | **Yes, by ~2024** | Version 1 yes, replaced | Not by construction | Partly |

The row that matters is *derivation supplied*. MATH is the wiki's only benchmark that ships a worked solution for every item, which is what makes the three-way trace experiment (train / read / generate) possible at all — and PGM's auxiliary-triple supervision is the only comparable side channel, worth +13.9 points there and ≤+2 on every novel-constituent regime, i.e. the same pattern: an external symbolic trace helps in-distribution and does not buy generalisation.

---

## Connections

- **[[wiki/concepts/refinement-loop.md]]** — the negative control for its chain-of-thought substrate: with the verification half removed, conditioning on a self-generated trace costs 1.6 points rather than buying any, which localises the loop's value in the *feedback signal* and not in the extra tokens.
- **[[wiki/concepts/metacognitive-efficiency.md]]** — identifies this page's AUROC 68.8% as an `AUROC2`, the wiki's only measurement of confidence *sensitivity* (as opposed to calibration), and states the correction it is missing: `AUROC2` moves with task performance, and the ratio that divides that out is undefined for free generation.
- **[[wiki/concepts/external-verification.md]]** — supplies the ladder's bottom rung as an artefact (the `\boxed{}` + normalisation grader every RLVR pipeline inherits), the benchmark PRM800K and the ORM/PRM comparison are defined on, and the measurement that motivates the whole ladder: the generator's own confidence ranks its answers at AUROC 68.8%.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — an explicit exchange rate between the `P` term and parameters: 100 hand-designed generator scripts plus Khan Academy are worth a 130× parameter increase, and a larger *uncurated* real-world corpus is worth slightly less than nothing on top of them.
- **[[wiki/concepts/shortcut-learning.md]]** — the format-level defence and its price: free generation with a delimited answer removes the candidate-set channel entirely, at the cost that nothing checks the derivation, so a correct answer through an invalid argument is unobservable to the metric.
- **[[wiki/concepts/test-time-training.md]]** — the same "spend inference on the task" instinct, four years earlier and in its cheapest form (write more tokens), measured as harmful; the difference is that TTT's extra computation is scored against the demonstration pairs and this one is scored against nothing.
- **[[wiki/entities/neo-neural-theorizer.md]]** — the other place in the wiki where finding a derivation and executing one separate: NEO holds a complete primitive set at near-zero pass@1, MATH hands over 99% of the derivation and still gets 40%, and both say that possessing the pieces is not the binding constraint.
- **[[wiki/entities/anli.md]]** — the per-item difficulty measurement MATH lacks, and the converse trade: MATH's levels are inherited from an external annotator community and are stable across systems, ANLI's are measured at authoring time and are relative to one model.
- **[[wiki/entities/conceptarc.md]]** — the human-baseline contrast: 415 participants against `n = 1` per level here, which is why MATH's 40–90% spread cannot support the "MATH is hard for humans too" claim as strongly as it is stated.
- **[[wiki/entities/arc-agi-2.md]]** — the live version of the extrapolation MATH settled: both argue from a flat scaling curve that scale will not deliver the ability, and MATH is the case where that argument was correct about the mechanism and useless as a forecast.
- **[[wiki/entities/pgm.md]]** — the other benchmark that ships a symbolic trace as an auxiliary target, with the same signature: supervising the explanation helps in-distribution and does not transfer to the held-out abstraction.
- **[[wiki/concepts/latent-graph-discovery.md]]** — MATH's difficulty is composition, not vocabulary: AMPS covers the primitives (5M generated exercises over 100 named topics) and buys ~1.5 points, because what the benchmark withholds is which heuristics to chain, which is the navigate half of the framing.
- **[[wiki/concepts/problem-framing.md]]** — a domain where framing is *supplied* and the task is still unsolved: a competition problem arrives fully specified with a known answer format, so MATH scores optimisation-within-a-representation alone, which is why it saturated and ARC-style framing tasks did not.
- **[[wiki/empirical-tensions.md]]** — T217 (a self-generated trace helps or hurts), T218 (whether normalised exact match is an adequate grader), T219 (what a scaling extrapolation can be evidence for).
- **[[wiki/entities/gsm8k.md]]** — the opposite-signed measurement of the same intervention in the same year: deleting the self-generated trace costs 4× on GSM8K (20.6% → 5.2%) where adding it costs 1.6 points here, which turns T217 into a per-step-reliability threshold with a point on each side — and GSM8K raises that reliability explicitly by offloading arithmetic to a calculator.
- **[[wiki/entities/gpqa.md]]** — the adjacent format decision made the other way: MATH buys auto-gradeable *free generation* with a `\boxed{}` delimiter and pays in grader false negatives (T218); GPQA buys exact grading with a 4-way candidate set and pays in the elimination-by-plausibility channel, which its surface-feature classifier check does not rule out.
- **[[wiki/entities/frontiermath.md]]** — the successor built on this benchmark's saturation, and the place the hint curve reappears in a second role: FrontierMath's *active review* protocol accepts an item only if a reviewer given the key ideas but not the write-up can reach the answer, which is this page's instrument used as a human quality gate rather than as a model probe.
- **[[wiki/concepts/human-baseline.md]]** — the `n = 1`-per-level baseline — five people, twenty items, one hour — whose 40–90% spread across expertise is real and whose endpoints are anecdotes.
- **[[wiki/concepts/benchmark-contamination.md]]** — the audit this page's limitations list said was missing, run by a third party in 2024, and the one that comes back positive on the **test** split: verbatim 5-gram recall of MATH test items by several open models, which is a stronger finding than anything the train-vs-test differential returns.
- **[[wiki/entities/olymmath.md]]** — the format's direct descendant (MATH-compatible items, sympy grading) and the calibration this page could not do: OlymMATH-EASY is placed where a strong 2025 reasoning model actually sits (DeepSeek-R1: 79.8 on AIME24, 79.6 here) and OlymMATH-HARD 27 points below the frontier's AIME score, which is the discipline a saturating benchmark lacks.
- **[[wiki/entities/math-perturb.md]]** — this benchmark's level-5 items rewritten twice at matched edit distance, and the qualification the hint curve needed: an external correct worked solution is worth +34 points when it is a trace *of the problem being asked* and approximately zero when it is a trace of a problem at embedding-cosine 0.99 whose method no longer applies, where it repairs 24–40% of errors and creates 18–40% more (T224).
- **[[wiki/entities/hle.md]]** — the benchmark built on this one's (and MMLU's) saturation, and the direct version of this page's calibration finding: instead of an AUROC on the generator's own confidence, every model states a 0–100% confidence with every answer and RMS calibration error is reported next to accuracy for all eight (73–89% against 2.7–13.4% accuracy).
- **[[wiki/entities/aime.md]]** — the top rung of the competition ladder this dataset is drawn from and the anchor of its difficulty scale (an AIME item is level 5); it is also the origin of the answer-only grading contract this page inherits, and a live human denominator (mean ≈5.7/15 for 2024 qualifiers) against the `n = 1`-per-level baseline this page could only assemble.
