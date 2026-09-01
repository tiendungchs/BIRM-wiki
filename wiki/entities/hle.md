# HLE (Humanity's Last Exam) — the benchmark whose expert disagreement rate is larger than every score reported on it

**2,500 closed-ended questions across 100+ academic subjects, admitted by an *automated* gate: each candidate item is run against a fixed frontier-model ensemble before a human ever sees it, and only items the ensemble fails are forwarded to expert review (>70,000 attempts → ~13,000 stumped → 2,500 accepted). Frontier models score 2.7–13.4%. Three things here are new to the wiki and none of them is the score. (i) The admission gate is [[wiki/entities/anli.md]]'s adversarial loop with the human adversary deleted and the period set to one pass — cost per item collapses from ~5 minutes of paid annotator time to one API call, and what is lost is the try-count and the clock. (ii) **Calibration is a co-reported axis**: every model states a confidence with every answer, and RMS calibration error is 73–89% — the wiki's cleanest measurement that a system does not know what it does not know, at 2,500 items rather than by inference from an abstention rate. (iii) The benchmark **measures its own ground-truth reliability and finds 15.4%** (≈18% on a biology/chemistry/health subset), so the label-noise floor is larger than the best score on the leaderboard — and the same paper shows that number is a property of the *review protocol*, not of the dataset: flagging on a single dissenting expert moves the health subset from 18% to 25%.**

> **Provenance.** Phan, Gatti, Han, Li *et al.* 2025, *Humanity's Last Exam* (`raw/phan-2025-humanitys-last-exam.md`, arXiv preprint, Center for AI Safety + Scale AI) and its journal version, Phan *et al.* 2026, *Humanity's Last Exam*, **Nature** s41586-025-09962-4 (`raw/phan-2026-humanitys-last-exam.md`). The two are ingested together and differ in ways worth recording (see *What changed between the preprint and the journal version*). Dataset public at `huggingface.co/datasets/cais/hle`; harness at `github.com/centerforaisafety/hle`. HLE = Humanity's Last Exam; MMLU = Measuring Massive Multitask Language Understanding; RMS = root mean square.

---

## The artefact

| Property | Value |
|---|---|
| Public items | **2,500**, over 100 subjects grouped into high-level categories, math/STEM over-represented |
| Private items | A held-out set kept from the start, **plus a second** private set built from post-release "late contributions" (Nature version) |
| Formats | **24%** multiple-choice with **five or more** options; **76%** exact-match (model emits an exact string) |
| Modality | **~14%** require reading an image alongside the text |
| Authors | ~**1,000** expert contributors, **500+** institutions, **50** countries; mostly professors, researchers, graduate degree holders |
| Incentive | **$500,000** prize pool — $5,000 × top 50 items, $500 × next 500 — plus co-authorship for any accepted item |
| Required per submission | Question, answer (or options with the key marked), **a detailed solution rationale**, subject, contributor name and affiliation |
| Prohibited | Open-ended questions, subjective interpretation, weapons-of-mass-destruction content |
| Grading | `o3-mini-2025-01-31` as judge under structured decoding, extracting `(extracted_final_answer, reasoning, correct, confidence)` |

---

## The admission gate — an automated model-in-the-loop filter, and its two asymmetries

Every candidate item is scored against a fixed ensemble *before submission*, by the contributor, using the organisers' tooling:

| Question type | Ensemble | Admission rule |
|---|---|---|
| Text + image | GPT-4o, Gemini 1.5 Pro, Claude 3.5 Sonnet, o1 | Exact-match: must stump **all**. Multiple-choice: must stump **all but one** |
| Text only | the four above + o1-mini, o1-preview | same |

Two design details do real work and are cheap to copy:

1. **The multiple-choice rule is a guess correction applied at authoring time.** With five options, chance is 20%, so an item that stumps every model is over-selected for items where the ensemble got unlucky; allowing one model to pass buys back part of that. This is the same problem [[wiki/entities/gpqa.md]] pays for with a four-way format and [[wiki/entities/frontiermath.md]] designs away with a guessproofness bound, solved here by relaxing the filter instead of enlarging the answer space.
2. **Contributors are instructed to defeat *right-answer-wrong-reasoning* by editing the item, not by rejecting it** — "when LLMs provide correct answers with faulty reasoning, authors are encouraged to modify question parameters, such as the number of answer choices". This is a rule-level concern ([[wiki/concepts/rule-level-evaluation.md]]) handled entirely inside the answer format, and it is the only place in the pipeline where the *reasoning* is inspected at all.

**The gate's cost structure is the point.** [[wiki/entities/anli.md]]'s loop needs ~5 minutes of paid annotator time per accepted item, forever, and returns a try count and a clock as a by-product — a *measured* per-item difficulty. HLE's gate needs one API call per attempt and returns a bit. The 70,000→13,000 ratio says the gate rejected ~81% of attempts, which is an *aggregate* yield, not a per-item difficulty: nothing distinguishes an item that stumped six models by one hop from one that stumped them by five. The wiki's per-item difficulty problem (`F3` in [[wiki/concepts/certification-instruments.md]]) is therefore untouched here, and traded away deliberately for throughput — 2,500 items at a fraction of ANLI's marginal cost.

---

## Results

| Model | Accuracy (%) | RMS calibration error (%) |
|---|---|---|
| GPT-4o | 2.7 | 89 |
| Grok 2 | 3.0 | 87 |
| Claude 3.5 Sonnet | 4.1 | 84 |
| Gemini 1.5 Pro | 4.6 | 88 |
| Gemini 2.0 Flash Thinking | 6.6 | 82 |
| o1 | 8.0 | 83 |
| DeepSeek-R1 *(text-only subset)* | 8.5 | **73** |
| o3-mini (high) *(text-only subset)* | **13.4** | 80 |

Multiple-choice accuracy is elevated relative to exact-match (Nature, Extended Data) — the residual of the guess correction above.

**The authors disclaim their own ordering.** Non-zero accuracy is attributed to inference noise rather than competence, the true capability floor is called an open question, and "small inflections close to zero accuracy are not strongly indicative of progress". This is `F7` of [[wiki/concepts/certification-instruments.md]] stated by the benchmark's own authors, as [[wiki/entities/frontiermath.md]] also does — a benchmark hard enough to floor every solver destroys the ordering it exists to produce.

---

## The three measurements worth keeping

### 1. Calibration error 73–89%, measured directly

The evaluation prompt requires three fields — `Explanation`, `Answer`, `Confidence: {00%–100%}` — and RMS calibration error is reported next to accuracy for every model. A well-calibrated system at 5% accuracy would say ~5%; these say something near certain. The wiki's other evidence on this axis is indirect and has to be argued for: [[wiki/entities/math-dataset.md]]'s AUROC 68.8% on a generator's own confidence, and [[wiki/entities/gpqa.md]]'s abstention rising 4%→37% under a search tool with accuracy flat. HLE makes it a first-class number on 2,500 items.

**A share of this number is the benchmark, not the model.** Repairing the flawed items lowers calibration error for every model tested — 7–10 points on the full set, 29–42 on the repaired subset ([[wiki/entities/hle-verified.md]]). A model that gives a defensible answer disagreeing with a wrong key is recorded as confidently incorrect when it was neither. The conclusion survives the correction (73–89 minus ~9 is still catastrophic), but the number is an upper bound rather than a measurement.

**The ordering inside the column is the interesting part and the paper does not comment on it.** The two lowest calibration errors (DeepSeek-R1 at 73, o3-mini at 80) belong to the two highest-accuracy models, and both are reasoning models. Either (i) the reasoning trace supplies evidence about its own reliability that a direct answer does not, or (ii) calibration error is partly mechanical — a model at 13.4% has more correct answers for its confident predictions to land on. These are separable by re-scoring the calibration error on the *matched* subset each model gets right, and nobody has done it. **Option (ii) is a named and quantified confound, and the matched-subset design is its ad-hoc form**: task performance sits additively inside every confidence–accuracy statistic (`PS = O + C − R`, Murphy 1973) and ideal confidence *sensitivity* is bounded by first-order performance (Galvin et al. 2003), so the principled version is `meta-d′/d′` on this benchmark's 24% multiple-choice slice — where a `d′` is defined — and it needs no subsetting ([[wiki/concepts/metacognitive-efficiency.md]]). *(brainstorm)* If (i) survives, then a self-produced trace is a **precision signal** ([[wiki/concepts/precision-weighting.md]]) and not only a computation, which is a different argument for chain-of-thought than the one T217 is about.

**One component of that signal has since been isolated.** On items whose *statement* was broken, every model's self-reported confidence is lower before repair and recovers by +1.83 to +11.08 points after it, with ≈0 shift on unchanged items ([[wiki/entities/hle-verified.md]]) — so the confidence field is partly reporting the well-posedness of the *question*, a quantity independent of the model's chance of being right on a well-posed one.

### 2. A computable searchability screen, and the null result it produced

Post-release, the organisers operationalised "non-searchable" as a **model-difference test**: an item is *potentially searchable* if a model **with** search tools answers it correctly and the **same** model without search does not (GPT-4o mini / GPT-4o search, Perplexity Sonar). Flagged items were then hand-audited and removed if a web search found them easily.

Two things follow. First, this is the cheapest non-searchability instrument in the wiki: [[wiki/entities/gpqa.md]] buys the same property with paid PhDs from other fields given unrestricted web access and unlimited time (median 30 min per item); HLE buys a screening approximation with two API calls. Second, **removing the searchable items barely moved frontier performance** — the authors report post-audit performance "similar to" pre-audit. Combined with GPQA's +0.7 points from a search tool, the wiki now has two independent measurements that retrieval does not substitute for whatever these benchmarks measure, which is evidence on the B side of G17.

### 3. Accuracy scales log-linearly in reasoning tokens and then turns down at 2^14

The Nature version bins model outputs (reasoning + response tokens) on a `log2` scale and reports **log-linear accuracy growth that reverses beyond 2^14 ≈ 16,384 tokens**. This is a second inverted-U in inference budget, and it is mechanistically distinct from [[wiki/entities/gsm8k.md]]'s (best-of-`k` peaking near 400 candidates because a large search finds solutions that fool the learned verifier): **there is no verifier and no selection here — the budget is spent inside one trajectory.** Goodhart cannot be the explanation.

*(brainstorm)* The natural candidate is T217's per-step reliability. If a trace of length `L` is correct with probability ~`(1−ε)^L` and each extra step buys a diminishing amount of decomposition, the product has an interior maximum whose location is set by `ε` — so `2^14` is a read-out of the frontier's per-step error rate, not a universal constant, and it should *move right* as models improve. That is a falsifiable prediction and the data to check it (the same binning re-run per model generation) is already collected. It also predicts the two curves in T220 have different asymptotics: the verifier's peak is a Goodhart threshold and can be pushed out by a sounder checker, while this one can only be pushed out by raising `ε`-reliability.

---

## The noise floor, and why it is a protocol rather than a number

| Quantity | Value | How it was obtained |
|---|---|---|
| Expert disagreement, public set | **15.4%** | Two audit rounds of 200 sampled questions each; US university students solve them in full; flagged errors routed between organisers, original authors and auditors until consensus |
| Same, biology/chemistry/health subset | **~18%** | Targeted third-party peer review |
| Same subset, **single-reviewer flagging rule** | **25%** | Counting a question as flagged on one dissenting expert, with no rebuttal round |

The 18→25 swing is the finding. **The measured error rate of a benchmark is a function of the audit protocol — how many reviewers, whether the author gets a rebuttal, whether "best of the given options" is understood as the task** — and is therefore not comparable across benchmarks that audited themselves differently. The authors name three specific reasons the audit is hard, and each is a design choice made upstream: items are deliberately drawn from contributors' unpublished hands-on research experience (unverifiable by literature search *by construction* — the same property that makes them non-searchable); some multiple-choice items ask for the *most plausible* option, which an external reviewer unfamiliar with the design tries to refute against sources instead; and a single expert routinely misses the decades-old paper another expert knows.

**Against the leaderboard, this floor is decisive.** Every reported score (2.7–13.4%) is smaller than the disagreement rate (15.4%), so the benchmark's ranking is being read inside its own noise band. This is not the same defect as `F11` (too few items — HLE has 2,500, so binomial error is ~0.7pp); it is a *bias* term of unknown sign that does not shrink with `n`. See G17.

**An outside audit puts the floor higher still, and then re-scores the leaderboard against it.** Zhai *et al.* 2026 ([[wiki/entities/hle-verified.md]]) verify all 2,500 items component-wise and find only **668 (26.7%)** usable unmodified, 1,143 repairable, 689 indeterminate; the ratio of full-set to repaired-subset accuracy gain puts the **scoring-relevant** defect rate at **~26%**, stable to ±0.03 across seven independent models, against this paper's 15.4%. Three consequences land directly on the sections above. (i) The ordering *survives* — all seven models hold rank after repair — but the gains span +7.78 to +11.50, so the offset is not the constant G17's position A needs, and adjacent gaps halve (Claude-Opus4.5 over DeepSeek: 5.10 → 2.40). (ii) On the repaired items alone the models compress from a **2.5× to a 1.22× spread** and the top rank changes hands, so the defective quarter of the benchmark was generating a large spurious ordering. (iii) **Part of the calibration column below belongs to the benchmark**, not the models — calibration error falls 7–10 points on the full set and 29–42 points on the repaired subset for every model tested.

---

## What changed between the preprint and the journal version

| | Preprint (2025) | Nature (2026) |
|---|---|---|
| Claim | "the **final** closed-ended academic benchmark of its kind" | "**an** expert-level closed-ended academic benchmark"; the name is demoted to the initialism "HLE" |
| Forecast | "plausible that models could exceed 50% accuracy by the end of 2025" | Removed |
| Calibration | "RMS calibration errors above 70% across all models" | "**most** models exhibiting RMS calibration errors above 70%" |
| Compute | Token counts reported descriptively | The `log2` binning and the **turn-down at 2^14** |
| Self-audit | Not present | Expert disagreement 15.4% / 18% / 25%, the searchability screen, the late-contribution private set |
| Successor | — | **HLE-Rolling**, a dynamic fork updated continuously "once frontier models begin to hit the noise ceiling" |

The retreat from "final" and the addition of a rolling fork are the same admission, and it is the one [[wiki/concepts/certification-instruments.md]] reaches independently (conclusion 3): a benchmark is a maintenance schedule, not an artefact. HLE-Rolling inherits [[wiki/entities/olymmath.md]]'s unsolved comparability problem — successive editions share no anchor subset, so a score trend across refreshes means nothing unless one is pinned.

---

## Limitations, stated and unstated

| | |
|---|---|
| **Stated** | Closed-ended and structured; high accuracy "would not alone suggest autonomous research capabilities or AGI"; math/STEM over-represented |
| **Selection artefact** | Items are selected *because* a 2024-vintage ensemble failed them. What that ensemble found hard is not a random sample of what is hard — the benchmark is defined relative to six specific systems, exactly ANLI's problem (G17), but with no retrain-and-repeat round to average over |
| **The gate cannot be re-run** | The admission ensemble is frozen in the artefact. A 2026 model that trivially solves an item cannot cause its removal, so the set decays in a direction the protocol cannot see |
| **Judge in the loop** | Grading is `o3-mini`; the false-negative rate of an LLM judge on exact-match answers is unmeasured here and is up to 38% for rule-based graders on adjacent tasks (T218) |
| **No human baseline** | Auditors solved sampled items to find *errors*, not to produce a score. There is no per-item human accuracy, so the "expert human frontier" in the abstract is an assertion, not a measurement ([[wiki/concepts/human-baseline.md]]) |

---

## Comparison

| | HLE | [[wiki/entities/gpqa.md]] | [[wiki/entities/frontiermath.md]] | [[wiki/entities/anli.md]] |
|---|---|---|---|---|
| Difficulty defined against | A frozen 6-model ensemble | A **timed human** with a search engine | Research mathematicians' hours | The current best model, re-fit each round |
| Items | 2,500 public + 2 private sets | 448 (198 Diamond) | Hundreds, 5 public | 3,200 test |
| Self-measured reliability | **15.4%** disagreement (protocol-dependent) | 73.6–76.4% objectivity | ~10% critical error rate, unauditable | 2-of-3 verifier agreement per item |
| Per-item difficulty | Not measured (a bit per item) | Not measured | Rated on 3 axes; raters "rarely matched" | **Measured** (tries, seconds) |
| Saturation defence | A private set + a rolling fork | A canary string | Permanent non-publication | The loop itself |
| Marginal cost per item | One API call + review | ~2 in-domain + 3 out-of-domain PhD-hours | Expert authoring + 2 reviews | ~5 min paid annotation |

---

## Connections

- **[[wiki/entities/hle-verified.md]]** — the external component-wise audit of this dataset: it puts the scoring-relevant defect rate at ~26% against this paper's self-audited 15.4% (`F12` twice over), repairs 1,143 items and publishes 689 as indeterminate, re-scores the leaderboard to show the ordering survives while the gaps do not, and attributes 7–10 points of the RMS calibration column above to the benchmark rather than the models.
- **[[wiki/concepts/certification-instruments.md]]** — supplies **I17** (the automated pre-submission ensemble gate plus the model-difference searchability screen, the cheapest admission filter in the inventory) and **F12** (a benchmark's measured ground-truth error rate is a property of its audit protocol: 18% → 25% on the same items under a single-reviewer rule), and is a second author-stated instance of `F7`.
- **[[wiki/entities/anli.md]]** — the same model-in-the-loop principle with the human adversary and the retrain-and-repeat period removed: HLE buys throughput and loses the try count, the clock and the averaging over adversary generations that makes G17 answerable.
- **[[wiki/entities/gpqa.md]]** — the two benchmarks bracket the non-searchability requirement from opposite ends of the cost curve (paid out-of-field PhDs with unlimited web access vs a two-API-call model-difference screen) and produce the same null: retrieval buys ~0 accuracy. Both also measure their own reliability and both find a floor (15.4% vs 23.6–26.4%) larger than the differences being reported.
- **[[wiki/entities/frontiermath.md]]** — the other benchmark that floors every solver and disclaims its own ordering; the pair sit on opposite sides of G17's privacy/auditability trade, and HLE's protocol-dependent 15.4% is the auditable counterpart to FrontierMath's unauditable ~10%.
- **[[wiki/concepts/metacognitive-efficiency.md]]** — names what the RMS column is and is not: it is the *calibration* term alone, a statement about the confidence scale, so it licenses no claim that these models fail to discriminate their own errors — a system with perfect resolution and a broken scale reads identically. It also supplies the principled replacement for this page's unrun matched-subset experiment.
- **[[wiki/concepts/precision-weighting.md]]** — supplies the wiki's largest direct measurement of confidence miscalibration (RMS 73–89% at 2.7–13.4% accuracy), and the unrun experiment that would tell whether a reasoning trace is itself a precision signal.
- **[[wiki/concepts/external-verification.md]]** — the inverted-U at `2^14` output tokens is a turn-down in inference budget with **no verifier in the loop**, which separates the Goodhart mechanism from a per-step-reliability mechanism (T220).
- **[[wiki/entities/gsm8k.md]]** — the other inverted-U in inference budget (best-of-`k` peaking near 400 candidates against a learned verifier); the two peaks have different causes and are predicted to move under different interventions.
- **[[wiki/entities/math-dataset.md]]** — the saturation case that motivates HLE's existence, and the wiki's other calibration number (AUROC 68.8% on the generator's own confidence) that HLE's RMS column supersedes in directness.
- **[[wiki/concepts/refinement-loop.md]]** — HLE-Rolling is benchmark authorship run as a refinement loop against the field, the response `F1` forces and the preprint's "final exam" framing denied.
- **[[wiki/entities/olymmath.md]]** — the benchmark-as-renewable-process position HLE-Rolling adopts, and the source of the comparability problem it inherits: refreshed editions with no shared anchor subset cannot support a score trend.
- **[[wiki/concepts/human-baseline.md]]** — the missing measurement: HLE's auditors solved items to find label errors, not to produce a per-item accuracy, so "the expert human frontier" is the only quantity in the abstract with no number behind it.
- **[[wiki/concepts/rule-level-evaluation.md]]** — the pipeline's one contact with reasoning rather than answers, handled by editing the answer format ("modify the number of answer choices") rather than by reading the rule.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the negative case for the framing: HLE is knowledge-loaded by design and its items are selected for being *hard for humans too*, which is the quadrant the design rule "easy for humans, hard for AI" excludes (G17).
- **[[wiki/entities/aime.md]]** — the opposite contamination defence: HLE renews nothing and admits items through an automated model gate, AIME renews its entire item set twice a year and admits by human authorship, so blindness is restored for free rather than defended by a held-out split — and neither yields a scale a cross-edition trend can be read on (`F13`).
- **[[wiki/concepts/benchmark-contamination.md]]** — the channel `I17` opens by construction: every candidate item is submitted to a frozen frontier-model ensemble through a provider's API *before* publication, so the admission gate is also a disclosure of the item set to the models it will later score.
- **[[wiki/entities/shortcut-suite.md]]** — the overconfidence result localised: this page measures RMS calibration error of 73–89% as a property of the model, that one measures the confidence–accuracy gap *widening on the shortcut arm relative to a matched standard arm*, which makes miscalibration conditional on shortcut availability rather than a uniform offset — and therefore a candidate shortcut statistic.
- **[[wiki/concepts/confidence-calibration.md]]** — prices this page's RMS calibration column: on closed-set tasks the term it measures is one parameter wide and rank-preserving, so 73–89% licenses no claim about error discrimination and could be removed without changing a single answer; it also flags the column as a binned deviation statistic quoted without a bin count, and puts this page's unexplained ordering (most accurate models best calibrated) against a controlled capacity sweep that runs the other way (`T325`).
