# OlymMATH — the same problems in two languages, and the same difficulty tier in two verification paradigms

**350 Olympiad problems hand-copied out of *printed* Chinese magazines and textbooks, then split three ways: OlymMATH-EASY and OlymMATH-HARD (100 each, numerical answers, sympy-graded) and OlymMATH-LEAN (150, formalised in Lean 4). Every problem ships in parallel English and Chinese. Four things here are new to the wiki and none of them is the score. (i) **Language is a content-preserving perturbation axis** — the same reasoning graph under a total rewrite of every surface token — and the EN>ZH gap is significant (Wilcoxon signed-rank) across all subjects and difficulty levels for 14 models. (ii) **The selector has measurably negative value at small scale**: a 1.5B model reaches Pass@64 = 30.0% on EN-HARD and Cons@64 = **0.0%** — every correct solution it finds is out-voted. (iii) **Contamination is fought by sourcing from print**, which is the wiki's third defence strategy and the only one that is both auditable and admittedly perishable; the paper's answer to perishability is to ship the *construction pipeline* rather than a bigger set. (iv) The Lean subset drops the same provers from ~80% on miniF2F to **~10%**, and the error taxonomy says the drop is dominated by plumbing — 62% of Kimina Prover's responses fail to yield an extractable code block at all.**

> **Provenance.** Sun, Min, Chen, Zhao & Wen 2025 (Renmin University of China), *Challenging the Boundaries of Reasoning: An Olympiad-Level Math Benchmark for Large Language Models* (`raw/sun-2025-olymmath-benchmark.md`, arXiv 2503.21380**v3**). The v3 revision post-dates the original by enough that its own construction pipeline uses 2026-era models (Claude Opus 4.5, Gemini 3.0 Flash, DeepSeek V3.2), while its evaluated models are the early-2025 cohort — the paper is a 2025 benchmark with a 2026 tooling layer. EN/ZH = English/Chinese; AoPS = Art of Problem Solving; REPL = read-eval-print loop; P@k / C@k = Pass@k / Cons@k (majority vote over `k` samples). See [[wiki/glossary.md]].

---

## The artefact

| | **EASY** | **HARD** | **LEAN** |
|---|---|---|---|
| Items | 100 | 100 | 150 |
| Languages | EN + ZH | EN + ZH | EN + ZH statements, one Lean 4 formalisation (Mathlib v4.24.0) |
| Answer type | Real number or interval (`[√33,+∞)`); no sets, variables, complex numbers or text | same | Formal theorem, proved or not |
| Grading | sympy | sympy | Lean kernel |
| Format | MATH-compatible | MATH-compatible | miniF2F-compatible |
| Subjects (Alg / Geo / Num / Com) | 25 / 33 / 13 / 29 | 25 / 25 / 25 / 25 | 79 / 15 / 42 / 14 |
| Calibrated against | "standard prompting in mainstream models" | "slow-thinking modes in state-of-the-art models" | — |

**The three subsets are non-overlapping.** This is the design decision that costs the most: the "dual paradigm" is a property of the *suite*, not of any item, so the answer/proof dissociation that [[wiki/concepts/external-verification.md]] records as unclosed (>90% on AIME-style answers vs ~10/42 on USAMO-style proofs) still cannot be measured within-problem here. Formalising the 200 numerical items would make this the only benchmark in the wiki where the same problem is scored at the outcome rung and at the kernel rung by the same solver — and the paper already ships the agent that would do it (below).

**Difficulty placement, from the paper's own cross-benchmark table:** `HARD ≫ EASY ≈ AIME 2024 > OlympiadBench`, with Omni-MATH spanning OlympiadBench-to-slightly-above-AIME. DeepSeek-R1 scores 79.8 on AIME24 and 79.6 on EASY — the EASY subset is deliberately an AIME-equivalent at 3.3× the item count and in two languages.

---

## Results — and the discriminative-power argument

| Model | AIME 2024 | EASY (EN) | **HARD (EN)** |
|---|---|---|---|
| Gemini 2.5 Pro Exp | 92.0 | 92.2 | **58.4** |
| o3-mini (high) | 87.3 | 91.4 | **31.2** |
| GLM-Z1-Air (32B) | 80.8 | 76.8 | 20.1 |
| DeepSeek-R1 | 79.8 | 79.6 | 19.5 |
| QwQ (32B) | 79.5 | 84.0 | 23.1 |
| DeepScaleR-Preview (1.5B) | 43.1 | 22.3 | 4.1 |
| STILL-3-Preview (1.5B) | 32.5 | 18.4 | 3.8 |

**The two strongest models are 4.7 points apart on AIME24 and 27.2 points apart on HARD.** That is the benchmark's actual claim, and it is the mirror image of failure mode **F7** in [[wiki/concepts/certification-instruments.md]]: [[wiki/entities/frontiermath.md]] floors everything below 2% and loses the ordering; OlymMATH-HARD lands the frontier in the 19–58% band, which is where an ordering is a measurement rather than a Bernoulli sample. Placing a benchmark is a choice of *where the solvers currently are*, and it is separable from making it hard.

**The size argument is stated quantitatively and belongs to the wiki.** AIME ships 30 problems, so one item is worth 3.33 points and the binomial standard error is ≈2.6× that of a 200-item benchmark. Every AIME number the wiki carries is quoted to a precision its `n` does not support (see F9, added to [[wiki/concepts/certification-instruments.md]] from this source).

---

## The coverage/selection split, measured across three model sizes

DeepSeek-R1-Distill-Qwen, English:

| Model | Subset | P@1 | P@4 | P@16 | **P@64** | **C@64** |
|---|---|---|---|---|---|---|
| 1.5B | Easy | 16.0 | 37.5 | 62.2 | 78.0 | 32.0 |
| 1.5B | **Hard** | 1.5 | 5.1 | 14.2 | **30.0** | **0.0** |
| 7B | Easy | 47.5 | 78.4 | 91.8 | 97.0 | 77.0 |
| 7B | **Hard** | 11.1 | 29.6 | 53.4 | **74.0** | **22.0** |
| 32B | Easy | 67.3 | 90.8 | 97.4 | 100.0 | 89.0 |
| 32B | **Hard** | 16.9 | 38.7 | 59.0 | **75.0** | **25.0** |

Three readings, in ascending order of how much they cost the wiki's picture:

1. **Coverage saturates before pass@1 does.** 7B and 32B are 1.5× apart at P@1 on HARD (11.1 vs 16.9) and **one point apart at P@64** (74.0 vs 75.0). Four and a half times the parameters buy almost no new solvable problems — they buy a higher probability of surfacing the ones already reachable. This is [[wiki/concepts/external-verification.md]]'s selector-is-binding claim reproduced by a scale sweep rather than by an ablation, and it is the cleanest instance in the wiki of a *parameter count converted into a sampling rate*.
2. **The gap between P@64 and C@64 is the model's inability to recognise its own correct answer.** 74.0 vs 22.0 for the 7B. Majority vote is the second rung of the ladder and it discards three-quarters of the coverage the generator paid for.
3. **At 1.5B on HARD the vote returns *nothing*.** P@64 = 30.0, C@64 = **0.0**. Not "the selector is weak" but "the selector is anti-correlated with correctness at this capability level" — every one of the 30% of problems the model can solve at least once is solved by a minority of its own samples, and the plurality is always wrong. **Gap G68's premise, at its extreme:** a rejector is not a refinement on a good proposer, it is the entire difference between 30% and 0% here.

*(brainstorm)* The 7B/32B coverage tie predicts something testable and cheap: if scale buys sampling rate rather than reach, then a 7B run at 4.5× the sample budget should match the 32B at matched cost — and the released 582,400 trajectories from 28 models are enough to check it without a single new inference. The paper does not run this comparison, and it is the compute-matched control that [[wiki/empirical-tensions.md]] T204's budget/score curve keeps lacking.

---

## Language as a perturbation axis

Every EASY/HARD item exists in Chinese (original) and English (translated: Claude Sonnet 3.7 draft → GPT-4o refinement → two expert human annotators). This is a perturbation of the surface that leaves the reasoning graph **exactly** fixed, and it changes 100% of the tokens — a strictly stronger version of `I14`'s *rephrasing* axis ([[wiki/entities/gsm8k.md]]).

| Finding | Evidence |
|---|---|
| Every model tested scores higher on EN than ZH | Figure 2, all points above parity |
| The gap is not sampling noise | Wilcoxon signed-rank over the released 582k trajectories, 14 models (1.5B / 7B / 14B), **significant across all subjects and all difficulty levels** |
| Part of the gap is not reasoning | **Answer-extraction failures are disproportionately frequent among incorrect ZH responses** — a presentation-layer defect, not a derivation defect |

**The extraction result is the important one and the paper under-sells it.** The bottom rung of [[wiki/concepts/external-verification.md]]'s ladder — normalised exact match — is assumed language-neutral everywhere in the wiki, and it is not: the grader's ability to *find* the answer in the response depends on the language the response was written in. Any cross-lingual score difference is therefore a joint measurement of the model and the harness, and no source in the wiki separates them. See [[wiki/empirical-tensions.md]] T223.

**And the obvious confound is unavailable, for an instructive reason.** One would want to attribute the EN advantage to greater English exposure — but the paper's own leakage metric (`δ`, below) is *also* higher in EN than ZH for OlymMATH, whose English version is an author-produced translation that could not have been in any pretraining corpus. So `δ` is measuring English n-gram fluency as much as exposure, is comparable only within a language, and supplies no leakage-based explanation for the accuracy gap. The instrument that would settle it does not exist: the wiki has no benchmark whose *native* language is Chinese and whose translation is into a lower-resource language.

---

## Contamination: sourced from paper

| Defence | Instance | Auditable by a third party? | Decays? |
|---|---|---|---|
| Never publish the items | [[wiki/entities/frontiermath.md]] | **No** | No (T222) |
| Publish a calibrated train set, withhold the eval set | [[wiki/entities/arc-agi.md]] | Partially | Yes — F1, and F2 leaks through calibration |
| **Copy from printed magazines and textbooks that were never digitised** | **OlymMATH** | **Yes — the items are public and the sources exist** | **Yes, from the moment of release** |

Quantified with the Omni-MATH `n`-gram protocol: concatenate problem + answer, sample 5 starting points, score the model's prediction of the next 5-gram, and compare against three LLM-rewritten versions of the same item; the normalised difference `δ` indexes familiarity with the *original* wording.

| Base model | Lang | PolyMath `δ` | **OlymMATH `δ`** |
|---|---|---|---|
| InternLM2-Math-7B | EN | 34.84% | **0.90%** |
| InternLM2-Math-7B | ZH | 12.29% | **0.88%** |
| Qwen2.5-7B | EN | 38.81% | **17.59%** |
| Qwen2.5-7B | ZH | 10.27% | **3.42%** |

This is **the wiki's first benchmark that measures its own contamination rather than asserting a defence**, and the measurement comes with its own honest limit: `δ`'s absolute value depends on the rewriting model, so only *relative* comparisons between benchmarks are meaningful. Note that Qwen2.5-7B's EN `δ` of 17.59% on a manually-print-sourced set is not small — the defence is a reduction, not an elimination.

**The paper's answer to perishability is the transferable part.** It concedes that "no static benchmark can permanently avoid data leakage once publicly released" and open-sources the *machinery* — the Lean formalisation agent, the visualisation tool, the sourcing protocol — so the benchmark can be **refreshed** from new printed material. *(brainstorm)* That reframes a benchmark from an artefact into a renewable process, and it is the only escape from **F1** (developer-blindness is a depleting stock) that does not require the escape [[wiki/entities/anli.md]] chose — paying human adversaries forever. The cost is a different one: whoever refreshes the set controls the difficulty calibration, so successive editions are not comparable unless an anchor subset is carried over. Nobody has proposed the anchor.

---

## Two anti-guessing devices, neither of which is FrontierMath's

The paper documents *empirical guessing* — heuristics, symmetry assumptions, fabrication — in state-of-the-art reasoning models on genuine competition mathematics. Its worked case: o3-mini (high) assumes `b = c` by symmetry in an optimisation problem, never proves this is optimal, and reaches the answer. On an OlymMATH-HARD item the same move yields **3081 against a true answer of 2625**.

| Device | Mechanism | What it catches |
|---|---|---|
| [[wiki/entities/frontiermath.md]]'s **guessproofness** | Bound the answer channel: `P(correct \| no work) < 1%`, enforced by making the answer space large | Guessing the *value* |
| OlymMATH's **heuristic-hostile selection** | Choose problems where the natural heuristic (symmetry, extremality) yields a *specific wrong number* | Guessing the *method* — the shortcut is not merely unlikely to work, it is actively punished |
| OlymMATH's **solution-set aggregation** | Where a problem has several answers, ask for a summary over all of them (sum, sum of squares) | **Incomplete case enumeration, at the outcome rung** |

The third device is a genuine addition to [[wiki/concepts/external-verification.md]]'s ladder and it costs one line of problem editing. An exact-match grader is blind to a derivation that found three of four cases; make the required answer a function of the *whole solution set* and the omission changes the number. **Completeness of search becomes checkable by string equality** — the cheapest instrument in the wiki for a property that otherwise needs a proof assistant. *(brainstorm)* It generalises past mathematics wherever the task has an enumerable answer set: report the count of valid ARC transformations rather than one grid, the number of distinct causal structures consistent with the evidence rather than the best one. The precondition is that the answer set be finite and the aggregation be order-invariant.

---

## The Lean subset: the kernel rung, measured through a fragile channel

Three specialised provers, 32 attempts per problem:

| Metric | Kimina Prover (8B) | DeepSeek Prover V2 (7B) | Goedel Prover V2 (8B) |
|---|---|---|---|
| P@1 | 4.33 | **6.40** | 5.29 |
| P@32 | **14.00** | 8.67 | 10.00 |
| *P@32 by subject (Alg / Geo / Num / Com)* | 11.4 / **53.3** / 7.1 / **7.1** | 5.1 / **53.3** / 2.4 / **0.0** | 6.3 / **53.3** / 4.8 / **0.0** |
| **miniF2F P@32 (reference)** | **78.3** | **75.6** | **84.6** |

**The 8× drop from miniF2F is the headline and the subject profile is the diagnosis.** All three provers land on exactly 53.3% of the 15 geometry problems (= 8/15) — the paper's explanation is that Olympiad geometry is frequently reducible to algebraic manipulation, which Lean tactics handle. Combinatorics is 0.0% at every `k` for two of the three provers across 14 problems. *(brainstorm)* That profile is the formal-methods restatement of a pattern the wiki already has from [[wiki/entities/frontiermath.md]] (combinatorics 39% of problems, near-zero solve rate) and [[wiki/entities/arc-agi-2.md]]: the failures cluster where the solution requires **constructing an object or a case decomposition** rather than transforming an expression. A tactic library is a set of rewrite rules, and rewriting is exactly the operation combinatorics does not reduce to.

**But the score is not measuring proving.** Error distribution over 4,800 responses per model:

| Error type | Kimina | DS V2 | Goedel V2 |
|---|---|---|---|
| Valid | 4.3% | 6.4% | 5.3% |
| `sorry` (placeholder, incomplete proof) | 8.0% | 0.1% | 4.4% |
| Compile (syntax, imports, types) | 8.4% | **43.9%** | 24.5% |
| Logic (tactic failure, unsolved goals) | 17.2% | **44.9%** | 22.5% |
| Server | 0.1% | 4.5% | 0.1% |
| **Extract (no parseable ` ```lean4 ` block)** | **62.0%** | 0.3% | **43.3%** |

Kimina's 62% extraction failure is mostly *hitting `max_tokens`*. Among responses that do yield code, compilation succeeds 51.5–77.7% of the time. So the top rung of the verification ladder — the one the wiki treats as sound and complete — is reported here through a channel where **the modal outcome is a formatting or budget failure**, and the three provers' ranking flips between P@1 and P@32 partly because of it. This is the same complaint [[wiki/concepts/external-verification.md]] makes about reporting discipline (report pass@1, the vote, the selector *and* the token budget), arriving from the formal side: a kernel score without a token budget and an extraction rate is not interpretable.

**And the kernel's precondition is unverified.** The Lean statements were produced by an agent loop (below), then checked for semantic alignment with the informal statement by **three independent Gemini 3.0 Flash calls**, with human review reserved for formalisations containing axiom declarations. The kernel certifies that the proof establishes the formal statement; nothing sound certifies that the formal statement means the informal problem. **The ladder's top rung sits on an autoformalisation step adjudicated by a majority vote of language models** — which is the agent-consensus rung, three rungs down, holding up the one above it.

---

## The formalisation agent: a refinement loop that was entered

The construction pipeline is itself a result. Raw problems → format cleanup (Claude Opus 4.5) → three independent verification rounds (DeepSeek V3.2 Speciale) for translation accuracy, statement precision and solution rigour → **a Claude Opus 4.5 agent iteratively interacting with a Kimina Lean REPL server in an isolated sandbox, refining code against compiler feedback until it compiles** → three Gemini 3.0 Flash semantic checks → human review for axiom-bearing cases.

**Set against [[wiki/entities/frontiermath.md]], this is the control condition the wiki has been missing.** There, a sound interpreter is wired into the evaluation loop, results are fed back, the prompt explicitly instructs the model to experiment — and o1-preview averages **1.29 responses per problem**, answering before executing anything. Here the *same class of feedback channel* (a compiler, in-sandbox, errors returned) is consumed to convergence over 150 problems. The difference is not the model, the domain, or the availability of the verifier. **The difference is that the loop is in the scaffold and termination is defined by the verifier rather than by the policy.** A refinement loop that a policy may exit at will is a refinement loop that a policy will exit immediately; one whose exit condition is "the compiler accepted it" cannot be exited early. See [[wiki/concepts/refinement-loop.md]].

---

## Limitations

- **The three subsets are disjoint**, so the answer/proof gap is not measured within-item — the paper's central "dual paradigm" claim is a property of the suite.
- **The Lean scores are confounded by extraction and token budget** (62% for the best P@32 model), and no ablation separates prover competence from harness fit.
- **Two languages, both high-resource**, one of which is a translation produced by the authors. Nothing here speaks to low-resource reasoning.
- **`δ` is not comparable across languages** and its absolute value depends on the rewriting model; the leakage claim is strictly "lower than PolyMath".
- **No human baseline of any kind.** Not asserted, not estimated, not timed. Three Olympiad medallists verified the items; none of them was scored on them. Against [[wiki/concepts/human-baseline.md]]'s protocol this is a benchmark whose denominator is entirely absent — and the items are competition problems, so a human distribution *exists in the world* and was not collected.
- **Guessing is documented by case study and never quantified.** The paper says so, and names scalable detection of natural-language reasoning shortcuts as open.
- **Geometry problems were text-reformulated from diagrams**, and non-convertible ones excluded — a selection effect on the geometry subset in an unknown direction.
- **8 samples, not 64, for the six most expensive models** — including every closed-source model and DeepSeek-R1, i.e. the rows that carry the headline discriminative-power claim.

---

## Comparison

| | **OlymMATH** | [[wiki/entities/frontiermath.md]] | [[wiki/entities/math-dataset.md]] | [[wiki/entities/gsm8k.md]] | [[wiki/entities/gpqa.md]] |
|---|---|---|---|---|---|
| Item origin | **Printed, non-digitised Chinese Olympiad material** | Written to order by research mathematicians | Public competitions | Crowdworkers | Written to order by in-domain PhDs |
| Contamination defence | **Print-sourcing + a refresh pipeline** | Never published | None | None | Canary string |
| Contamination **measured** | **Yes — `n`-gram `δ` against rewrites** | No (defence asserted) | No | **Indirectly** — the item's z-score in its own template distribution | No |
| Verification | sympy **and** Lean kernel, on different items | Exact / SymPy / witness predicate | Normalised exact match | Exact match | Index match |
| Anti-shortcut device | **Heuristic-hostile item selection + solution-set aggregation** | `P(guess) < 1%`, audited | Free generation | Anti-templatisation | Non-experts paid to break items |
| Surface perturbation available | **Yes — full-token, meaning-preserving (language)** | No (one-of-a-kind items) | No | **Yes — 8 named axes + template redraw** | No (but the hop chains ship) |
| Human baseline | **None** | None (expert-hours estimate) | `n = 1` per level | Asserted | 65% / 34%, measured |
| Discriminates at the frontier | **Yes — 27.2 points between the top two** | No — floored | Saturated | Saturated | Weakly |

The row that matters is *contamination measured*. FrontierMath has the strongest defence and no measurement; GSM-Symbolic has the cheapest measurement and no defence; OlymMATH is the first to carry both — and its own number (17.59% for Qwen2.5-7B in English) says the defence is partial. **A contamination defence that is never measured should be read as an intention.**

---

## Connections

- **[[wiki/concepts/external-verification.md]]** — three additions to the ladder from one source: a **completeness check at the outcome rung** (ask for a sum over the whole solution set, and an incomplete case enumeration changes the number), the finding that the **bottom rung is not language-neutral** (answer-extraction failures cluster in incorrect Chinese responses), and the finding that the **top rung rests on an unverified precondition** — the Lean kernel certifies the proof, while the informal→formal translation is adjudicated by three Gemini calls, i.e. the agent-consensus rung holding up the kernel rung.
- **[[wiki/concepts/certification-instruments.md]]** — extends `I14` with the strongest meaning-preserving perturbation available (translation changes every token and no relation), and supplies **F9**: 30-item AIME grants 3.33 points of resolution and a binomial standard error ≈2.6× a 200-item benchmark, so every AIME-derived number in the wiki is quoted past its own precision.
- **[[wiki/concepts/refinement-loop.md]]** — the control condition for FrontierMath's declined loop: the *same* class of sound feedback (a compiler in a sandbox, errors returned) is consumed to convergence over 150 problems because the exit condition belongs to the verifier and not to the policy, which localises the failure in *who owns termination* rather than in the availability of feedback.
- **[[wiki/concepts/shortcut-learning.md]]** — the shortcut caught in the act at Olympiad level: an unproved symmetry assumption (`b = c`) that reaches an answer, plus the design counter-move — select problems where the natural heuristic yields a *specific wrong number* (3081 against 2625), which converts a shortcut from "usually fails" into "detectably fails".
- **[[wiki/concepts/human-baseline.md]]** — a benchmark of genuine competition problems, verified by three Olympiad medallists, that collects no human accuracy at all: the denominator existed in the world and was not measured.
- **[[wiki/entities/frontiermath.md]]** — the same problem attacked from the opposite corner: FrontierMath floors every solver (F7) and bounds guessing by enlarging the answer space, OlymMATH places the frontier in a 19–58% band and bounds guessing by making the heuristic wrong; and its declined interpreter loop is the negative to this paper's formalisation agent.
- **[[wiki/entities/gsm8k.md]]** — the perturbation instrument (`I14`) exported to a new axis: GSM-Symbolic redraws numbers and names inside one language, OlymMATH swaps the language entirely and holds the reasoning graph fixed — and the ZH extraction-failure result is the reminder that a "meaning-preserving" perturbation must also preserve the *grader's* competence.
- **[[wiki/entities/math-dataset.md]]** — the format ancestor (MATH-compatible items, sympy grading) and the saturation this benchmark is a response to; also the calibration target — OlymMATH-EASY is placed where a strong 2025 model sits, which is the discipline MATH's authors did not have available.
- **[[wiki/entities/gpqa.md]]** — the other benchmark whose difficulty is set against a measured population rather than against a model; the contrast is that GPQA measures its non-expert control and OlymMATH measures its *contamination*, and neither measures both.
- **[[wiki/entities/arc-agi-2.md]]** — the same discriminative-power argument in the grid domain (place the benchmark where the frontier is, not below it), and the same combinatorics-shaped failure profile: the tasks that resist are the ones requiring an object or a case decomposition to be *constructed* rather than an expression to be rewritten.
- **[[wiki/entities/anli.md]]** — the other escape from **F1**: ANLI pays human adversaries in perpetuity, OlymMATH ships a re-sourcing pipeline and a formalisation agent so the set can be refreshed from new printed material — cheaper, but with no anchor subset to keep successive editions comparable.
- **[[wiki/empirical-tensions.md]]** — T223 (whether a cross-lingual score gap measures the model's reasoning or the harness's answer extraction), T204 (the compute-matched budget/score control that the released 582k trajectories would settle), T222 (this benchmark is the third position on contamination defence: auditable, measured, and admittedly perishable).
- **[[wiki/entities/math-perturb.md]]** — the opposite extreme of the same perturbation axis: OlymMATH changes every token and no relation (translation), MATH-P-Hard changes almost no tokens and one relation, and the pair brackets what `I14` can be asked to vary.
