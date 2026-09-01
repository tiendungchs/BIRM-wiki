# ARC-AGI-2 — the same format, re-authored against the solvers that beat version 1

**A 2025 rebuild of [[wiki/entities/arc-agi.md]] that keeps the grid format bit-for-bit and changes only the task population: brute-forceable items removed, every eval task human-calibrated by first-party testing, and the difficulty moved from *one rule per task* to *several interacting rules, applied conditionally, over symbols whose meaning is defined inside the task*.**

> **Provenance.** Four sources, one pass. Chollet, Knoop, Kamradt, Landers & Pinkard 2025, *ARC-AGI-2: A New Challenge for Frontier AI Reasoning Systems* (`raw/chollet-2025-arc-agi-2.md`, arXiv 2505.11831) for design and human study; Chollet, Knoop, Kamradt & Landers 2026, *ARC Prize 2025: Technical Report* (`raw/chollet-2025-arc-prize-report.md`) for the competition record and the knowledge-overfitting claim; the ARC Prize site's ARC-AGI-2 page (`raw/arcprize-nd-arc-agi-2-overview.md`, undated, `(tentative)` where sole source); and a third-party leaderboard aggregator (`raw/llmstats-2026-arc-agi-2-leaderboard.md`, `(tentative)` — self-reported vendor numbers, see T206).

The wiki's first benchmark page that exists because a *previous benchmark page's flaw table got acted on*. Every row of [[wiki/entities/arc-agi.md]]'s "Known flaws" section is a design goal here, which makes the pair the cleanest worked example the wiki holds of `GD` being maintained against an adapting opponent.

---

## What changed, flaw by flaw

| ARC-AGI-1 flaw | ARC-AGI-2 fix | Verified? |
|---|---|---|
| 49% of private eval fell to 2020 brute-force search (T205) | **All tasks solved in the 2020 Kaggle contest were removed from the eval sets**, and new tasks authored to resist naive enumeration | Partly — icecuber (the 2020 brute-force winner) scores **1.6%** here against 17% on ARC-AGI-1 |
| No first-party human baseline | 407 participants, 515 sessions, three sessions Nov 2024 – May 2025, 13,405 test-pair attempts, paid ($115–150 + $5/task) | Yes — the wiki's only benchmark with a first-party human study at source |
| Inconsistent difficulty across subsets | Per-task **empirical difficulty index** = proportion of participants achieving full correctness; subsets assembled so mean human accuracy differs by **≤ 1 percentage point** | Yes, by construction |
| Private set eroded by ~10,000 leaderboard queries | Leaderboard set (semi-private) **separated from** the final-scoring set (private), both enlarged 100 → 120 | Structural; erosion restarts from zero rather than being prevented |
| Saturates below human ceiling (97–98% trivially) | Every task now requires deliberate thought — **median 2.3 min** per attempted test pair, mean completion 2.7 min | Yes |
| Only 100 private tasks | 120 private + 120 semi-private | Marginal — sampling noise still ~±4 points |

Unchanged on purpose: grids 1×1 to 30×30, 10 colours, exact-match binary scoring, `pass@2`, Core Knowledge as the only assumed prior, hand-authored tasks, no data generator.

---

## Dataset composition — and a discrepancy the sources do not resolve

| Subset | Tasks | Calibrated | Role |
|---|---|---|---|
| Public training | **1,000** per the site page · **400, "imported from ARC-AGI-1"** per the 2025 technical report | No | Expose the Core Knowledge priors; spans the full difficulty range; not all tasks human-tested |
| Public evaluation | 120 | Yes | Local testing |
| Semi-private evaluation | 120 | Yes | Live leaderboard; **assumed exposed to commercial APIs by construction** |
| Private evaluation | 120 | Yes | Final Kaggle standing; never sent to a third party |

The 1,000-vs-400 conflict is not a rounding difference — it is the difference between "we authored a large new training corpus" and "the training set is version 1's". Flagged rather than resolved; every training-set-dependent claim below is `(tentative)`.

**Calibration guarantee**: 100% of eval tasks solved by ≥ 2 independent non-expert humans in ≤ 2 attempts, each task attempted by 2–10 people. Aggregated by task, 75% of human attempts succeeded; aggregated over all attempts, 66%. So the human ceiling is *certified solvability*, not a per-subject accuracy — the same union-over-testers caveat that applies to version 1's 99% NYU figure.

---

## The finding inside the human study

**No self-reported demographic factor** — occupation, industry, technical experience, programming proficiency, mathematical background, puzzle aptitude — showed a statistically significant relationship with performance, across 407 participants.

This is the strongest evidence the wiki holds for the `P`-equalization claim that [[wiki/concepts/skill-acquisition-efficiency.md]] needs and that ARC-AGI-1 asserted by design intent alone: if crystallized skill mattered, programmers would beat non-programmers, and they do not. It converts "requires only Core Knowledge" from an authoring rule into a measured property of the task set ([[wiki/concepts/core-knowledge.md]]).

The second measurement worth carrying: speed and accuracy across participants are **positively correlated**. Humans who solve more tasks solve them *faster*, which is the opposite of the AI regime where score is bought with test-time compute — and it is the empirical content of the efficiency axis below.

---

## The four difficulty axes — a taxonomy of compositional failure

The design payload, and the most reusable part of the paper. Version 1 could usually be solved by naming **one** high-level transformation ("objects fall down"). Version 2 authors tasks against four specific ways that fails.

| Axis | Task demand | Why current systems fail | Wiki hook |
|---|---|---|---|
| **Multi-rule compositional reasoning** | Several rules apply *simultaneously* and interact — crop to a framed region, rescale the loose objects, insert each into the hole of matching shape (task `898e7135`) | Search is over single transformations; a conjunction of three interacting rules is not reachable by extending a one-rule hypothesis | G21 (nothing composes two modules' outputs) as a scored benchmark axis |
| **Multi-step compositional reasoning** | State after step *N* depends on the outcome of step *N−1*; the position of object *N+1* is **not predictable without executing the previous N steps** (task `cbebaa4b`) | A one-shot forward pass cannot represent an unrolled dependency chain; and the chain length is set by the data, not the program | G70 (no induced program has a loop) — this is that gap turned into an eval axis |
| **Contextual rule application** | The *same* transformation is gated by a contextual cue — stack shapes left or right depending on outline colour (task `b5ca7ac4`) | "Systems fixate on superficial patterns rather than the underlying selection principles"; requires composing a transformation rule with a *selection* rule, i.e. control flow | G37 (nothing decides which stored structure applies), G12 (no routing policy) |
| **In-context symbol definition** | An object stands for something other than itself, and the correspondence is **defined inside the task** — rectangles with *n* holes encode the colour for shapes with *n* holes (task `e3721c99`) | Named by the authors as "a major challenge for frontier AI systems": the vocabulary is not merely latent, it is *created per task and discarded* | G4 (vocabulary co-discovery) in its hardest form, and G69 (nothing creates variables on demand) |

**(brainstorm) Why the fourth axis is the interesting one.** Axes 1–3 are harder instances of what version 1 already asked. Axis 4 is a different demand: the solver must *install a temporary symbol table* from the demonstrations and then interpret the test grid under it. That is [[wiki/concepts/vector-symbolic-binding.md]]'s bind-and-retrieve with the binding pairs themselves inferred, and it is the only ARC axis for which "recombine core-knowledge priors" is plainly not a sufficient description of the competence — no rotation, count or topology operation constructs a *referential* relation. If a single mechanism is worth building against this benchmark, it is one that can allocate a fresh symbol, bind it to an observed regularity within the episode, and dereference it later.

What the four axes do *not* supply is a computable difficulty score: they are a taxonomy an author applies by hand, so per-task difficulty is still asserted rather than predicted, and `G31` is untouched by the redesign.

Also stated: version 2 tasks carry **more information content** — larger grids, more objects, more concepts per task — so "any attempt at compressing ARC-AGI-2 tasks would result in more bits per task". Relevant to [[wiki/concepts/prediction-compression-equivalence.md]]: the benchmark's difficulty is partly a description-length increase, which is measurable and which nobody has measured against solver scores.

---

## Efficiency becomes a reported axis

**Starting with ARC-AGI-2, every ARC reporting line carries a cost-per-task figure**, and the public leaderboard is a 2×2 of score against cost per task. The stated rationale is the wiki's own: brute force could eventually solve any of this, and "intelligence is about finding the solution efficiently, not exhaustively".

This is the first benchmark in the wiki to *institutionalize* the inference-budget column that [[wiki/empirical-tensions.md]] T204 says every score needs, and it is the closest anything comes to `G35` — the charge is levied on inference and still not on the solver's own parameters or pretraining, and it retires half of that tension's methodological complaint — though not its empirical one, since nobody has still swept one method's budget across orders of magnitude.

The site page's own summary of the resulting curve: **"log-linear scaling is insufficient to beat ARC-AGI-2"** `(tentative)` — i.e. cost must fall by more than the score rises, which is a claim about the *slope* of the score-vs-spend curve rather than about any point on it.

---

## Score record

**Verified, ARC Prize's own measurements** (semi-private / private eval):

| Date | Score | System | Cost/task |
|---|---|---|---|
| May 2025 | 3.0% | o3 (medium), o3-mini (high) | — |
| May 2025 | 2.5% | the ARChitects, the 2024 ARC-AGI-1 winner at 56% | — |
| May 2025 | 1.6% | icecuber, the 2020 brute-force winner at 17% | — |
| Nov 2025 | **24.03%** | NVARC — 2024 ARChitects TTT stack + heavy synthetic data generation (Kaggle 1st) | **$0.20** |
| Nov 2025 | 16.53% | the ARChitects — 2D-aware **masked-diffusion** LM, recursive self-refinement, perspective-based scoring | Kaggle budget |
| Nov 2025 | 12.64% | MindsAI — TTT + augmentation ensembles + tokenizer dropout | Kaggle budget |
| Late 2025 | 31% | Gemini 3 Pro, baseline | $0.81 |
| Late 2025 | **54%** | Gemini 3 Pro + Poetiq **refinement harness** (application-layer, open-sourced, ARC-Prize-verified) | **$31** |
| Late 2025 | ~54% | Claude Opus 4.5 + same harness | ~$60 |
| 2025 papers | 8% | Tiny Recursive Model, **7M parameters** | — |
| 2025 papers | 4% (20–34% on ARC-AGI-1) | CompressARC, **76K parameters, no pretraining, no dataset, no search** | ~20 min/puzzle, one RTX 4070 |

**Interpretation rule from the paper**: scores below **5%** are not meaningful — "noise-level heuristics or incidental pattern fits". Consistent signal begins above that. This retroactively voids most of the May-2025 table as measurement.

**Third-party aggregator** (`llm-stats.com`, July 2026, 16 models, **0 verified / 13 self-reported**) `(tentative)`: GPT-5.5 0.850 · Gemini 3.1 Pro 0.771 · GPT-5.4 0.733 · Claude Opus 4.6 0.688 · Claude Sonnet 4.6 0.583 · GPT-5.2 Pro 0.542 · Claude Opus 4.5 0.376 · Gemini 3 Pro 0.311 · Grok-4 0.159 · o3 0.065.

The top of that table sits **at the 85% Grand Prize threshold** while ARC Prize's verified open-source frontier is 24% under a Kaggle budget and 54% at $31/task. See [[wiki/empirical-tensions.md]] T206 — this is not a small discrepancy to be averaged, it is a question about what a reported benchmark number denotes.

---

## Knowledge overfitting — the failure mode a private set does not stop

The 2025 report's sharpest claim, and it is an admission against interest.

> A private eval set blocks *memorization* of its items. It does **not** block a model from being trained on a large public corpus that is **independent and identically distributed with** the private set.

Because reasoning systems now have non-zero fluid intelligence, they can adapt to tasks "somewhat removed from their precise knowledge base" *provided the base covers the broader domain*. So a benchmark can be perfectly leak-proof at the item level and still be overfit at the **distribution** level, purely by the public training set being public.

The report asserts this is now happening to ARC-AGI-1 and -2 — accidentally or deliberately, they cannot tell — and offers one piece of direct evidence: their verification harness never mentions ARC or colour formats, yet Gemini 3 Deep Think emits *correct ARC colour names* while reasoning over raw 2-D JSON integer arrays.

| Contamination mode | Blocked by | Status here |
|---|---|---|
| Item memorization | Private eval set | Blocked |
| Format familiarity | Nothing — the format is the paper's own continuity goal | **Open, evidenced** |
| Distribution familiarity (public train ≈ private test) | Only by making the eval set non-IID with the training set, which destroys calibration | **Open, and in direct conflict with the ≤1pp calibration goal above** |

**The design tension this creates is structural, not incidental.** Goal 6 of the benchmark is that subsets be drawn from demonstrably similar distributions so scores transfer across them. Knowledge overfitting says that *exact property* is the leak. A benchmark cannot simultaneously guarantee cross-subset comparability and distributional novelty against a model trained on one of its subsets. Logged as [[wiki/empirical-tensions.md]] T207.

The report's own answer is not a fix but a policy: **continual benchmark adaptation** — treat benchmark authorship as itself a refinement loop ([[wiki/concepts/refinement-loop.md]]) run against the field, with Chollet's stopping criterion:

> "You'll know AGI is here when the exercise of creating tasks that are easy for regular humans but hard for AI becomes simply impossible."

---

## Where the remaining gap sits

The report's own decomposition, worth quoting because it splits a single number into two differently-bottlenecked problems:

| Gap | Bottleneck | Reading |
|---|---|---|
| **Accuracy** (24% → 85% Grand Prize) | *Engineering* | Known methods, scaled and combined, are expected to get there |
| **Efficiency** (54% at $31/task vs. humans at ~2.7 min and no API bill) | *Fundamental science and new ideas* | This is where the benchmark still refuses to move |

Paired with the 2025 report's two conditions for reliable automation with no new science — (i) sufficient task knowledge coverage in the pretraining corpus, (ii) a verifiable feedback signal — the diagnosis is that **AI reasoning is knowledge-bound in a way human reasoning is not**, and that the named open problem is "methods to separate knowledge and reasoning". That is [[wiki/concepts/controller-knowledge-vs-process.md]]'s question arriving from the benchmark side.

---

## Comparison to ARC-AGI-1

| | ARC-AGI-1 | ARC-AGI-2 |
|---|---|---|
| Eval sets | 100 private + 100 semi-private (from 2024) | 120 + 120, difficulty-matched to ≤1pp |
| Human data | 2 testers (97%, 98%); third-party MTurk | 407 participants, 13,405 attempts, first-party |
| Brute-force reach | 49% of private eval | 1.6% (icecuber) |
| Typical human time | Often instantaneous | Median 2.3 min, mean 2.7 min |
| Rules per task | Usually one | Several, interacting, conditionally applied |
| Efficiency reporting | Absent | Mandatory, on every line |
| Best open score | 55.5% (2024) | 24.03% (2025) |
| Frontier LLM, no harness | 87.5% (o3-preview, high compute) | 31% (Gemini 3 Pro) |
| Grand Prize | Unclaimed at retirement | Unclaimed; competition continues into 2026 |

The 56% → 2.5% drop for the ARChitects' unchanged 2024 system is the number that certifies the rebuild: whatever version 1 rewarded at the top of its leaderboard, version 2 does not reward at all.

---

## Limitations

- **The training-set size is inconsistent between the two primary sources** (1,000 vs. 400) — see above.
- **Distribution-level contamination is admitted and unquantified.** "We cannot precisely quantify the magnitude of this effect."
- **Human calibration certifies solvability, not difficulty.** The empirical difficulty index is a proportion over 2–10 testers per task; with `n = 2` on some tasks, per-task difficulty carries enormous variance even though the subset *means* are matched.
- **Leaderboard erosion has restarted.** 1,455 teams and 15,154 entries against the semi-private set in 2025 alone — the same query-leakage channel version 1 suffered, at ~1.5× the annual rate, with the private set now protected from it but the semi-private set not.
- **The four difficulty axes are authored intuitions, not measured factors.** No factor analysis, no per-axis subscore, no evidence that a system failing axis 3 tasks fails them *for the stated reason*. The benchmark still returns one number, so it cannot attribute a failure — which is exactly what [[wiki/entities/pcfg-set.md]]'s five facet scores do and this does not.
- **`(brainstorm)` The axes are stated as demands on the solver, but they are also a specification for a task generator** — multi-rule, multi-step, gated, symbol-defining — which is precisely the thing the benchmark forbids itself to build. The reason given (a generator lets a solver reverse-engineer one program) is version 1's, but a *held-out* generator used only for authoring, never released, would let the authors sample difficulty rather than intuit it and would give the per-axis subscores the previous bullet asks for.

---

## Connections

- **[[wiki/entities/arc-agi.md]]** — the predecessor whose flaw table is this benchmark's design document; the pair is the wiki's only worked example of a benchmark being repaired against measured leakage, and the 56% → 2.5% carry-over of the 2024 winner is the repair's certificate.
- **[[wiki/concepts/refinement-loop.md]]** — the mechanism that produced every 2025 score on this benchmark, and, per the report, the mechanism the benchmark's own authors run when they rebuild it.
- **[[wiki/concepts/test-time-training.md]]** — still the top of the open leaderboard here (NVARC 24.03%, built on the 2024 ARChitects stack), which makes version 2 evidence that TTT was not a version-1 artefact, while the 2.5% carry-over of the unmodified 2024 system shows the technique transfers and its *tuning* does not.
- **[[wiki/concepts/core-knowledge.md]]** — the prior-equalization claim tested rather than asserted: across 407 participants, no measured background variable (programming, maths, puzzles) predicts performance, which is what "requires only Core Knowledge" should imply and what version 1 never checked.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the first benchmark to make the efficiency term of the intelligence formula a mandatory reporting axis rather than an argument, and the first to supply a first-party human `E` measurement (median 2.3 min) to compare against.
- **[[wiki/concepts/compositionality.md]]** — supplies a four-way taxonomy of compositional failure (simultaneous rules, sequential state dependence, contextual gating, in-context symbol definition) authored specifically against systems that already handle single-rule composition.
- **[[wiki/concepts/shortcut-learning.md]]** — introduces a contamination mode the shortcut literature does not cover: not a spurious feature inside the data but a *distributional* overlap between a public training set and a private test set, which no held-out protocol detects because the held-out protocol is what guarantees it.
- **[[wiki/concepts/latent-graph-discovery.md]]** — moves version 1's position in the taxonomy: the edge label is now a *composition* over a per-task vocabulary that includes symbols defined inside the episode, so path-latency (hardness 1) and vocabulary-latency (hardness 2) are joined by a within-episode reference relation that the taxonomy has no row for.
- **[[wiki/entities/corethink-compositional-reasoner.md]]** — the wiki's one at-source attack on this benchmark, scoring 24.4% alone and 30.8% ensembled on the *public* eval set with 22 authored macro-patterns and no training; its residual failures are precisely the multi-rule and contextual axes above.
- **[[wiki/entities/arc-vsa-solver.md]]** — the same benchmark at the other extreme of the difficulty transfer: 11.7% on ARC-AGI-2-Eval demonstrations and **0.0%** on its queries, against 48.8/10.8 on version 1, which is what the re-authoring did to a method whose vocabulary is a fixed spatial-semantic algebra.
- **[[wiki/concepts/external-verification.md]]** — the report's two conditions for automation-without-new-science name a verifiable feedback signal as one of them, and the 31% → 54% jump from an application-layer harness on an unchanged model is the largest single measurement in the wiki of what an acceptance test is worth on this benchmark.
- **[[wiki/concepts/controller-knowledge-vs-process.md]]** — the report's stated open problem, "methods to separate knowledge and reasoning", is this distinction restated as the reason frontier scores are knowledge-bound and human scores are not.
- **[[wiki/entities/pcfg-set.md]]** — the attribution instrument this benchmark lacks: five facet scores against one exact-match number, so a version-2 failure can be blamed on a design axis only by the authors' intuition.
- **[[wiki/entities/arc-agi-3.md]]** — the successor that settles this page's structural conflict (T207) by choosing a horn: the public set is made deliberately non-representative of the private mechanics, the public-to-private ratio inverts from ~10:1 to 25:110, and public-set scores are never reported — cross-subset comparability given up to buy distributional novelty. It also contradicts this page's harness reading (T208): the same class of intervention that bought +23 points here is shown there to be bimodal and non-transferring.
- **[[wiki/entities/conceptarc.md]]** — the opposite response to the same 2023 situation, and the pair states the design trade-off: this page raises difficulty and calibrates it per task against 407 humans, ConceptARC lowers difficulty until humans are at ceiling and calibrates coverage per concept against 415, so frontier headroom and diagnostic resolution are bought with the same currency.
- **[[wiki/entities/anli.md]]** — this page's "benchmark authorship as a refinement loop run against the field" with the field replaced by one deployed model and the schedule made explicit: three rounds, retrained between each, stopping criterion a *measured* error rate (18.33% → 8.07% → 6.92% on matched genre) rather than an authoring intuition. The leakage this page cannot escape is instead paid for continuously, in annotator wages at ~5 minutes per accepted item.
- **[[wiki/entities/math-dataset.md]]** — the settled instance of this page's own argument form: MATH also read a flat scaling curve as evidence about the ability (~10³⁵ parameters projected for 40%), and was above 90% within three years on an algorithmic change rather than a parameter count — which licenses "not this method" and never "not this ability" ([[wiki/empirical-tensions.md]] T219).
- **[[wiki/concepts/certification-instruments.md]]** — the source of failure mode `F2`: item-level developer-blindness does not imply distributional blindness, and the difficulty calibration that makes subset scores comparable is precisely what guarantees the leak.
- **[[wiki/concepts/human-baseline.md]]** — the wiki's only first-party human study at source, and the only case where the baseline is used as a *design constraint* — subsets assembled so mean human accuracy differs by ≤1pp — rather than reported as a scoreboard line.
- **[[wiki/entities/frontiermath.md]]** — the cost-reporting norm arrived at independently by this page's opposite number in mathematics: its interviewed mathematicians reject a tool that costs three days of a datacentre per problem, which is the $/task axis argued from the user's side rather than the leaderboard's.
- **[[wiki/entities/olymmath.md]]** — the same placement argument made in mathematics: put the benchmark where the frontier currently is rather than on the floor, and the top two models separate by 27.2 points where AIME separates them by 4.7. Its Lean subset also reproduces this benchmark's failure profile in a formal setting — the resistant problems are the ones needing an object or a case decomposition to be *constructed* (combinatorics at 0.0% for two of three provers) rather than an expression rewritten.
