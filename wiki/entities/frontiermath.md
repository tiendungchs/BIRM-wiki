# FrontierMath — the benchmark that hands the model a working verifier and watches it decline to use it

**Hundreds of original, never-published mathematics problems written by 60+ research mathematicians across most of the 2020 Mathematics Subject Classification, each with a definitive answer checkable by a script — integer equality, SymPy simplification, or a *custom verification script* for problems whose answer is not unique. Six frontier models solve under 2% (pass@8 ≈ 6% for the best). Three things here are new to the wiki and none of them is the score. (i) The problems are authored against a stated, quantitative anti-shortcut bound — **guessproofness: no strategy may exceed a 1% chance of the right answer without doing most of the work** — and the second-review audit reports how often that bound was broken (2 of 35). (ii) Difficulty is rated per item on three axes, and two of them are denominated in **expert-hours split into finding the idea and executing it**, which is the wiki's first per-item human denominator that is not a probability. (iii) The evaluation harness gives every model a Python interpreter with results fed back, and the two strongest models **submit a final answer before running anything** — o1-preview averages 1.29 responses per problem against Grok 2 Beta's 3.81.**

> **Provenance.** Glazer, Erdil, Besiroglu, Chicharro, Chen, Gunning, Falkman Olsson, Denain, Ho, de Oliveira Santos, Järviniemi, Barnett, Sandler, Vrzala, Sevilla *et al.* 2024 (Epoch AI), *FrontierMath: A Benchmark for Evaluating Advanced Mathematical Reasoning in AI* (`raw/glazer-2024-frontiermath-benchmark.md`, arXiv 2411.04872v7). All numbers are the paper's own; the benchmark itself is not public, so nothing here is independently checkable. MSC = Mathematics Subject Classification; IMO/AIME = International Mathematical Olympiad / American Invitational Mathematics Examination; MWP = math word problem.

---

## The artefact

| Property | Value |
|---|---|
| Size | "hundreds"; the paper never states `n` (percentages and a 35-item audit are all that constrain it) |
| Authors | >60 mathematicians, >12 countries, graduate student → faculty; 14 IMO golds collectively; one Fields Medalist contributor |
| Coverage | Most top-level MSC2020 codes. Number theory 17.8% of tags / **44% of problems**, combinatorics 15.8% / **39%**, group theory 8.9% / **22%**, then probability, linear algebra, algebraic geometry, special functions (~5% each), algebraic topology, category theory, PDEs (1–3%) |
| Cross-subject | Number theory + combinatorics in 13% of problems; combinatorics + group theory 9%; number theory + group theory 8% |
| Technique diversity | **>200 distinct techniques**, each in <5% of problems; the most frequently co-occurring *pair* appears in at most **3** problems |
| Answer type | Integer (preferred), or an arbitrary SymPy object — symbolic expression, matrix, set |
| Public release | **5 problems**, drawn at random and removed from the set |
| Metadata per item | Background 1–5, creativity hours, execution hours, subjects, techniques, "is programming required?" |

**The technique-diversity row is the design claim.** A benchmark whose most common technique pair occurs three times is one where no vocabulary of solution moves can be learned from the rest of the set — the opposite of a template family and the opposite of [[wiki/entities/math-dataset.md]]'s AMPS, where 100 hand-written generators covering 100 named topics bought a 130× parameter equivalent. FrontierMath's difficulty is placed in the composition and the coverage is deliberately too thin to amortise.

---

## Four authoring requirements, one of which the wiki did not have

| Requirement | Statement | What it buys |
|---|---|---|
| **Originality** | May build on existing ideas only through "clever adaptations that substantially transform" them or "innovative combinations… that obscure their origins" | Removes retrieval-of-a-known-problem as a solution path |
| **Automated verifiability** | Definitive, computable answer; integer where possible, else a SymPy object, else a custom script | Auto-grading without formalisation in Lean or Coq |
| **Guessproofness** | *"there should not be a greater than 1% chance of guessing the correct answer without doing most of the work"* | A **numeric bound on the answer channel**, checked at review |
| **Computational tractability** | Solution ships scripts; cumulative runtime <1 minute on standard hardware | Bounds evaluation cost and rules out brute force as the intended path |

**Guessproofness is the export.** Every shortcut instrument in [[wiki/concepts/certification-instruments.md]] is applied *after* a benchmark exists and measures how much of its score a degenerate strategy recovers; this one is a stated design-time bound on the same quantity, `P(correct | no work) < 0.01`, enforced per item by a reviewer whose job includes trying to break it. It is why the sample answers are objects like `367707` and `1876572071974094803391179` rather than small integers — the answer space is made large on purpose, which is the same move as [[wiki/entities/math-dataset.md]]'s free generation and the opposite of [[wiki/entities/gpqa.md]]'s and [[wiki/entities/raven.md]]'s candidate sets.

**And it is the requirement the paper reports failing.** In the 35 second-reviewed items, reviewers found **2** where "guessing the solution with substantially less effort or computation" was possible, and in the main results section the authors state that on one of the four problems any model ever solved, "running a few simple simulations was sufficient to make accurate guesses without any deeper mathematical understanding". A bound that is stated, audited, and reported violated is worth more to this wiki than an unstated one that is never tested.

---

## The verification design: checking a *witness*, not an answer

Three grading regimes, in the authors' order:

| Case | Test |
|---|---|
| Unique integer answer | Exact match |
| Unique symbolic real answer | SymPy: check that (submitted − actual) simplifies to 0 |
| **Everything else** | **A per-problem custom verification script** |

The third row is a rung [[wiki/concepts/external-verification.md]]'s ladder does not contain. Its worked example is Pell's equation — *find integers with `x² − 7y² = 1`* — which has infinitely many solutions, so there is no key to match against; the script checks the *property*. The general form: **where the answer is a certificate rather than a value, verification is sound, cheap and needs no uniqueness**, and the class of problems this opens (Diophantine tuples, Hamiltonian paths, explicit constructions, counterexamples) is exactly the class where finding is hard and checking is easy.

Two consequences the paper does not draw:

1. It sits *above* the outcome rung and *below* the kernel: sound like a proof assistant, but purchased with a Python predicate instead of a formalised statement. The benchmark's stated reason for avoiding Lean/Coq is cost, and this is what it bought instead.
2. *(brainstorm)* It is the only acceptance test in the wiki that a **brain-inspired reasoner could plausibly own**, because it does not require the reasoner to represent its own derivation. Recognising that a candidate satisfies the goal predicate is a forward evaluation, not an introspection — which is the shape [[wiki/concepts/external-verification.md]]'s closing question ("is there an internal verifier that is not the generator?") keeps failing on. The condition is that the *goal* be stated as a checkable predicate, and the interesting observation is that mathematics supplies these for free while almost nothing else the wiki targets does. Constructing goal predicates for non-mathematical domains is the same problem as [[wiki/concepts/problem-framing.md]]'s, arrived at from the verification side.

---

## The result that belongs to the wiki: a refinement loop offered and declined

The harness is a [[wiki/concepts/refinement-loop.md]] with a *sound* feedback channel: the model writes Python in fenced blocks, the harness executes it (20 s timeout), stdout/stderr and timeout status come back, and the loop continues to a 10,000-token limit before a forced-submission prompt. The prompt tells the model, at length, to experiment, to verify every step of its arithmetic with code, to restart if stuck, and that it need not answer in its first response.

| Model | Mean responses per problem | Hits the 10K token limit | Mean tokens |
|---|---|---|---|
| **o1-preview** | **1.29** | — | 12–17K band |
| Gemini 1.5 Pro 002 | (low; "typically submit before seeing any experimental results") | **16.8%** | ~6,000 |
| Claude 3.5 Sonnet / GPT-4o / Grok 2 Beta | up to **3.81** (Grok) | **>45%** | 12–17K |

**o1-preview and Gemini 1.5 Pro typically submit a final answer before any code has been run.** The verifier is present, free, sound, and unconsulted.

*(brainstorm)* This is the sharpest evidence in the wiki that a proposer does not become a searcher by being handed a rejector — the loop has to be *in* the policy. Three readings, and they are separable by experiment: (i) the model has no representation of "I am uncertain enough that evidence would change my answer", which is the calibration failure [[wiki/entities/math-dataset.md]] measures as AUROC 68.8% on the generator's own confidence and [[wiki/entities/gpqa.md]] finds inverted (search raises abstention 4%→37% while leaving accuracy flat); (ii) the training distribution rewards answering, and an inference-time instruction cannot outweigh it; (iii) the model *cannot* generate a useful experiment for a problem it does not understand, so the loop is unusable rather than unused. Note the correlation runs the wrong way for a simple "better models use tools better" story — **the two models that use the loop least are the two that were most heavily trained to reason**, and the one that uses it most (Grok, 3.81 responses) scores no better. The cheap discriminating experiment is to force one code execution before any submission is accepted and re-score; nobody has run it, and the harness already supports it.

---

## Results

| Benchmark | Fraction unsolved by the best model |
|---|---|
| MMLU College Mathematics | 1.9% |
| GSM8K | 3.6% |
| MATH | 5.2% |
| MathVista | 26.1% |
| AIME 2024 | 26% |
| Omni-MATH | 39.5% |
| **FrontierMath** | **>98%** |

Six models — o1-preview, o1-mini, GPT-4o (2024-08-06), Claude 3.5 Sonnet (2024-10-22), Grok 2 Beta, Gemini 1.5 Pro 002 — none above **2%** mean accuracy over 8 runs. Pass@8: **~6%** (o1-preview), ~2% (Grok 2 Beta).

**Exactly four problems were solved even once by any model.** Re-run five times each:

| Problem | Grok 2 Beta | o1-preview | o1-mini | GPT-4 | Gemini 1.5 Pro | Claude 3.5 Sonnet | MSC |
|---|---|---|---|---|---|---|---|
| 1 | 60% | 40% | 20% | 0% | 0% | 20% | probability, approximations |
| 2 | 0% | **100%** | 20% | 20% | 0% | 80% | algebraic topology, manifolds |
| 3 | 0% | 80% | 0% | 0% | 60% | 0% | group theory, field theory |
| 4 | 0% | 0% | 20% | 0% | 0% | 0% | algebraic geometry, combinatorics |

One row of five is deterministic. **A benchmark this far into the floor reports a Bernoulli sample, not an ordering** — the authors say so ("the precise ordering of model performance should be interpreted with significant caution") — which makes FrontierMath the wiki's cleanest instance of failure mode **F7** in [[wiki/concepts/certification-instruments.md]]: a benchmark hard enough to floor every solver destroys the ordering it exists to produce. ConceptARC establishes that the diagnostic regime is *humans at ceiling*; FrontierMath deliberately occupies the opposite corner and pays the stated price, on the argument that the floor is temporary.

---

## The benchmark measures its own error rate — and its own difficulty ratings do not survive it

Every accepted item gets **one** blind peer review (statement, solution, verification code, difficulty, tags). Beyond that: 30 randomly chosen items got a second blind review, and 5 were removed as public samples — 35 items with scrutiny past round one.

| Second-review finding | Count / 35 | Rate |
|---|---|---|
| **Incorrect answer** given by the author, missed in review 1 | 2 | Jeffreys posterior `(2+0.5)/(35+1) ≈ 6.9%`; authors call **~10%** reasonable allowing for undetected errors |
| Missing hypotheses (not fully rigorous, imputable by a domain expert) | 6 | 17% |
| Guessproofness violated | 2 | 6% |

Context the paper supplies: >6% label error in the ImageNet validation set, >9% error in MMLU on a 3,000-item expert review. So a ~10% ground-truth error rate is *normal*, and normal is the problem — it is roughly five times the entire spread between the six evaluated models.

**The QA reform is worth stealing.** The authors diagnose *passive review* — the reviewer sees the full solution and approves — and move to **active review**: confirm the property directly where the answer is a certificate; check that a heuristic estimate approximates the claimed value where it is a symbolic real; and for abstract problems, **have the reviewer solve it given only the key steps and ideas, not the write-up**. That last protocol is [[wiki/entities/math-dataset.md]]'s hint curve — accuracy as a function of how much of the derivation is supplied — repurposed from a model instrument into a human QA gate, and it is the same measurement in both roles.

**The difficulty ratings are the part that fails.** Three axes per item:

| Axis | Scale | What it isolates |
|---|---|---|
| Background | 1 (high school) → 5 (research level) | Prior knowledge required |
| **Creativity** | Hours for an expert to find the key ideas; no upper bound | **Search** |
| **Execution** | Hours to compute the answer once the ideas are found; no upper bound | **Step execution** |

Reliability: *"ratings rarely matched and often showed substantial differences"* between first and second reviewers; the authors call them "rough guidance" and say human solution-time data would be needed to support stronger claims. Validity evidence is one weak correlational note (Appendix C): easier problems *outside* the benchmark carrying higher difficulty ratings are less often solved by GPT-4o.

*(brainstorm)* The creativity/execution split is nonetheless the right decomposition and the wiki should keep it even though this instance is unreliable. It is the same two-way split that [[wiki/entities/math-dataset.md]]'s 99%-hint ceiling (40% with the derivation handed over) and [[wiki/entities/neo-neural-theorizer.md]]'s primitiveness-vs-transferability dissociation (T156) obtain by intervention rather than by rating — and it is directly measurable here rather than estimated, because the harness already logs the model's trajectory. **Creativity-hours against execution-hours, plotted against model success, is a free experiment on data Epoch AI already holds**, and it would say whether machine failure on research mathematics is a search failure or an execution failure. The paper rates both axes and never crosses them with the results.

---

## Contamination: solved by never publishing, at a price the paper does not price

| Defence | Implementation |
|---|---|
| Novel items | Originality is an authoring requirement, checked by reviewers familiar with the competition and research literature |
| Secure handling | Encrypted communication platforms; password-protected archives; discouragement of any plaintext online copy |
| Automated check | Quetext and Copyscape plagiarism scans across the whole dataset — no significant matches beyond standard terminology |
| Release policy | 5 sample problems; the rest never published; Epoch AI runs the evaluations |

This is the strongest contamination defence in the wiki's benchmark inventory and it inverts the usual failure. [[wiki/concepts/certification-instruments.md]]'s **F1** (developer-blindness is a depleting stock) and **F2** (item-blindness ≠ distributional blindness) both describe what happens to a *published* training set with a *private* test set; FrontierMath publishes neither, so F2 has no channel at all. What it buys instead is that **no external party can audit the ~10% error rate, reproduce a score, or check the guessproofness of an item** — the benchmark's ground truth and its evaluation are held by one organisation, and the only public evidence about item quality is the organisation's own 35-item self-audit. See [[wiki/empirical-tensions.md]] T222.

---

## What the mathematicians said, and the one number in it

Interviews with Terence Tao, Timothy Gowers, Richard Borcherds and Evan Chen. `(tentative — expert opinion, not measurement)`

- **The training-data claim.** Tao: for many of these problems the relevant training data is *"almost nonexistent… you're talking like a dozen papers with relevant things"*. Gowers: solving them needs "the tricks of the trade of some particular branch of maths". In [[wiki/concepts/skill-acquisition-efficiency.md]]'s accounting this is the regime where the `P` term **cannot be bought** — MATH's exchange rate (curated generators ≈ 130× parameters) presupposes a curator who knows the primitives, and at research level nobody does. The proposed escapes are synthetic generation and formal verification, i.e. manufacturing the corpus.
- **The collaboration ratio, and it is the only quantity in the section.** Tao: guiding a current system to a correct solution on advanced graduate-level questions costs *"about five times as much effort"* as solving it directly, with an expectation that the ratio falls below 1 on some problems within a few years. **A human-in-the-loop cost ratio is the right unit for a tool claim** and the wiki has no other instance of one; note it is defined against the human's own solving time, which makes it the same denominator as the creativity+execution rating.
- **Timeline and format.** Tao expects the benchmark to "resist AIs for several years at least"; Chen and Tao both expect human–AI collaboration to reach these problems ~3 years before autonomy. Borcherds: the numerical-answer format "aren't quite the same as coming up with original proofs" — the answer/proof split [[wiki/concepts/external-verification.md]] records as unclosed (>90% on AIME-style answers vs ~10/42 on USAMO-style proofs).
- **The cost caveat.** Tao on AlphaProof: *"if your amazing tool takes three days of compute off of all of Google to solve each problem… then that's less of a useful tool"* — the same reporting axis [[wiki/entities/arc-agi-2.md]] made mandatory.

---

## Limitations

- **No `n`.** The paper never states the benchmark's size, so every percentage on this page has an unstated denominator and the 35-item audit covers an unknown fraction.
- **Not public, not reproducible.** One organisation holds the items, the answers, the verification scripts and the evaluation harness.
- **~10% estimated critical error rate**, on a single-blind-review pipeline, against a 0–2% spread between models. Self-reported.
- **Difficulty ratings are unreliable between raters** and validated only by one indirect correlation on out-of-benchmark items.
- **No human accuracy baseline at all** — the human denominator is an *estimated time*, unvalidated by any timing study, from the person who wrote the problem.
- **Floored.** Four problems solved once each; the model ordering is noise and the authors say so.
- **No proofs, and no long horizons.** Auto-verifiability excludes proof-writing and open-ended exploration; hours-scale problems exclude the weeks-to-years horizon of actual research, which the paper names as the crucial untested skill.
- **10,000 tokens and 20 seconds.** The evaluation budget is small by 2025 standards and the authors list raising it as future work, so the <2% figure is a joint measurement of the models and a tight harness.

---

## Comparison

| | **FrontierMath** | [[wiki/entities/math-dataset.md]] | [[wiki/entities/gsm8k.md]] | [[wiki/entities/gpqa.md]] | [[wiki/entities/arc-agi.md]] |
|---|---|---|---|---|---|
| Item origin | **Written to order by research mathematicians** | Decades of public competitions | Hand-written by crowdworkers | Written to order by in-domain PhDs | Hand-authored to a prior spec |
| Anti-shortcut rule | **Stated numerically (`P(guess) < 1%`) and audited** | Format-level (free generation, no candidate set) | Anti-templatisation across items | Payment-level (non-experts paid to break items) | Priors enumerated |
| Grading | Exact / SymPy / **witness predicate** | Normalised exact match | Exact match | Index match | Grid exact match |
| Difficulty measured | **Per item, in expert-hours, split search/execution** — unreliable between raters | Inherited from AoPS, levels 1–5 | None | **Per item, 3 non-expert attempts, timed** | Asserted per benchmark |
| Human baseline | **None** (a time estimate, not an accuracy) | `n = 1` per level | Asserted | 65% / 34%, measured as a control | 60–99% depending on protocol |
| Contamination defence | **Never published** | None | None | Canary string + norm | Private evaluation set |
| Ground-truth error rate | **~10%, self-measured** | Not measured | <2% breaking errors | **73.6–76.4% objectivity, measured** | Assumed exact |
| Discriminates between models | **No — floored** | Yes, then saturated | Yes, then saturated | Weakly (~10-point effects for 80% power) | Yes |

The two rows that pull against each other are *contamination defence* and *ground-truth error rate*. FrontierMath and GPQA are the wiki's only two benchmarks that measure their own reliability, and they land at ~10% wrong and ~26% non-objective respectively — but GPQA's items can be checked by anyone and FrontierMath's cannot. **A measured error rate is a property of the audit, not of the benchmark, and only one of these two audits is repeatable by a third party.**

---

## Connections

- **[[wiki/concepts/external-verification.md]]** — adds a rung the ladder lacked: a **per-problem witness predicate** (verify that `x² − 7y² = 1`, not that the answer matches a key), which is sound like a kernel, costs a Python function, and works where the answer is not unique; and supplies the loop's sharpest negative result — a free, sound, in-context verifier that the two strongest models decline to consult (o1-preview 1.29 responses per problem, submitting before executing anything).
- **[[wiki/concepts/refinement-loop.md]]** — the loop offered and not entered: the harness executes code and returns stdout, stderr and timeouts to the model with explicit instructions to experiment, and the models that were trained hardest to reason are the ones that answer in one turn, which localises the loop in the *policy* rather than in the availability of feedback.
- **[[wiki/concepts/certification-instruments.md]]** — supplies the quantitative form of that page's requirement 3 (guessproofness, `P(correct | no work) < 1%`, enforced per item and reported violated on 2 of 35 audited items), the wiki's cleanest instance of failure mode **F7** (a floored benchmark reports a Bernoulli sample instead of an ordering), and the partial answer to **F3** that shows why it is hard — difficulty *is* rated per item here, on three axes, and the ratings "rarely matched" between reviewers.
- **[[wiki/concepts/human-baseline.md]]** — the wiki's only human denominator that is not a probability: expert-hours, split into hours-to-find-the-idea and hours-to-execute, estimated by the problem's author and never validated by a timing study; plus the only human-in-the-loop *cost ratio* in the wiki (guiding a model to a solution ≈ 5× the effort of solving directly, Tao, tentative).
- **[[wiki/concepts/shortcut-learning.md]]** — the design-time counterpart to every instrument on that page: instead of measuring after the fact how much of a score a degenerate strategy recovers, bound it at authoring (`<1%`) and pay a reviewer to break it — with the honest failure report attached, since one of the four problems any model solved fell to "a few simple simulations".
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the regime where the `P` term cannot be purchased: >200 techniques with the most common pair appearing in 3 problems, and Tao's estimate that the relevant training data for a given item is "a dozen papers", which is the exact complement of MATH's AMPS result that a curated corpus over 100 named topics is worth 130× the parameters.
- **[[wiki/entities/math-dataset.md]]** — the direct successor and the same instrument reused twice: MATH's saturation is FrontierMath's stated motivation, and MATH's hint curve (how much of the derivation must be supplied) reappears here as the *active review* protocol, where the reviewer is given only the key ideas and must reach the answer before the item is accepted.
- **[[wiki/entities/gsm8k.md]]** — the opposite end of the same axis and the untaken experiment: GSM-Symbolic makes an accuracy a distribution by re-instantiating a template, which is unavailable here because FrontierMath's items are deliberately one-of-a-kind — so the wiki's cheapest contamination test cannot be run on the benchmark with the strongest contamination defence.
- **[[wiki/entities/gpqa.md]]** — the wiki's other self-auditing benchmark and the reason the audits are not comparable: both measure their own ground-truth reliability (~10% error here, 73.6–76.4% objectivity there), both are authored to order by credentialed experts against an explicit anti-shortcut incentive, and only GPQA's items can be re-checked by anyone outside the authoring organisation.
- **[[wiki/entities/arc-agi.md]]** — the same private-evaluation strategy taken to its limit: ARC withholds the evaluation set and publishes a calibrated training set, which is where F2's distributional leakage enters; FrontierMath publishes five items total, closing that channel and closing external auditability with it (T222).
- **[[wiki/entities/arc-agi-2.md]]** — the cost-reporting norm this paper's interviewees arrive at independently (Tao on AlphaProof: a tool that costs three days of Google's compute per problem is less of a tool), and the same argument for making $/task a mandatory axis rather than a footnote.
- **[[wiki/entities/neo-neural-theorizer.md]]** — the search/execution split obtained by intervention rather than by rating: NEO separates a complete primitive vocabulary from the ability to search it (T156), FrontierMath rates *creativity-hours* against *execution-hours* per item and never crosses either with the model results, which is a free experiment on data already collected.
- **[[wiki/entities/olymmath.md]]** — the same design problem solved from the opposite corner, and the pair brackets the placement question: FrontierMath floors every solver (F7) and bounds guessing by enlarging the answer space; OlymMATH lands the frontier in a 19–58% band and bounds guessing by choosing problems where the natural heuristic yields a specific wrong number. It is also the control for this page's declined-loop result — the same class of sound feedback (a compiler, in-sandbox, errors returned) is consumed to convergence when the exit condition belongs to the verifier rather than to the policy — and it measures the contamination this page only defends against.
- **[[wiki/concepts/problem-framing.md]]** — where the witness-predicate rung stops: verification is cheap exactly where the goal is already expressible as a checkable predicate, so exporting this rung out of mathematics is the framing problem approached from the verifier's side.
- **[[wiki/empirical-tensions.md]]** — T222 (whether a permanently private benchmark solves contamination or relocates the failure into unauditability).
