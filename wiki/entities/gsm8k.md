# GSM8K, GSM-Plus and GSM-Symbolic — the benchmark that built the verifier, and the two perturbation sets that unbuilt its score

**GSM8K is 8,500 hand-written grade-school word problems (7.5K train / ~1.3K test), each solved in 2–8 elementary arithmetic steps with a natural-language derivation. Three results matter here and none of them is the dataset. (i) Pairing a generator with a *separate* verifier and reranking 100 samples was worth about a **30× parameter increase** — the wiki's origin point for [[wiki/concepts/external-verification.md]]. (ii) On this distribution, forcing the model to emit its derivation is worth **4×** (20.6% → 5.2% when removed) — the exact opposite sign to [[wiki/entities/math-dataset.md]] in the same year, which turns T217 from a disagreement into a task-difficulty threshold. (iii) The score it certified does not survive re-instantiating the same problems: one irrelevant clause costs up to **65%**, and for 21 of 25 models the original GSM8K number sits in the right tail of the distribution over matched variants.**

> **Provenance.** Three primary sources, ingested together because the second and third are defined on the first.
> - Cobbe, Kosaraju, Bavarian, Chen, Jun, Kaiser, Plappert, Tworek, Hilton, Nakano, Hesse & Schulman 2021 (OpenAI), *Training Verifiers to Solve Math Word Problems* (`raw/cobbe-2021-gsm8k-verifiers-math-word-problems.md`).
> - Li, Cui, Zhao, Kong & Bi 2024 (HKU / Tencent AI Lab), *GSM-Plus: A Comprehensive Benchmark for Evaluating the Robustness of LLMs as Mathematical Problem Solvers* (`raw/li-2024-gsm-plus-benchmark.md`). *The archived copy ends at §3.2, so the per-perturbation result table is not available to the wiki — only the taxonomy, the construction protocol and the headline numbers.*
> - Mirzadeh, Alizadeh, Shahrokhi, Tuzel, Bengio & Farajtabar 2024 (Apple / WSU), *GSM-Symbolic: Understanding the Limitations of Mathematical Reasoning in Large Language Models* (`raw/mirzadeh-2024-gsm-symbolic-benchmark.md`).
>
> The wiki has carried GSM-Symbolic's 65% NoOp figure second-hand via [[wiki/concepts/external-verification.md]] and [[wiki/concepts/shortcut-learning.md]] since the Raiyan survey; this is the primary source. MWP = Math Word Problem; CoT = Chain of Thought (see [[wiki/glossary.md]]).

---

## The three artefacts

| | GSM8K (2021) | GSM-Plus (2024) | GSM-Symbolic (2024) |
|---|---|---|---|
| Unit | A problem | A problem **variant** | A **template** |
| Size | 8.5K (7.5K train / 1K test, 1,319 test items as distributed) | 1,319 seeds × 8 perturbations = **10,552** | 100 templates × 50 instantiations = **5,000**, read as 50 matched datasets of 100 |
| Authored by | Humans, from scratch | GPT-4 draft → human revision (18.85% revised) | Humans, by variabilising 100 GSM8K items |
| Difficulty control | None (fixed items) | None (fixed variants) | **Yes** — add/remove clauses: GSM-M1 / Symb / P1 / P2 |
| Reports | One accuracy | One accuracy per perturbation | A **distribution** (mean and variance over 50 draws) |
| Answer | Open-form number | Open-form number, or *"unanswerable"* | Open-form number |

The progression is the point: **a point estimate → a point estimate per named perturbation → a sampling distribution over the same problem**. Only the third makes "the model's accuracy" a random variable and so lets a single reported number be tested against its own null.

---

## GSM8K: four design principles, one of which was later reversed

| Principle | Implementation | Consequence |
|---|---|---|
| High quality | Human writers, answer-agreement QC; <2% breaking errors | The error floor every later derivative inherits |
| **High diversity** | *"actively avoid designing problems that are drawn from the same linguistic template or differ only in superficial details"* | Held-out accuracy is meaningful **because** no test item is a re-skin of a train item |
| Moderate difficulty | 2–8 steps, `+ − × ÷`, no variable definition needed for most items | Sits in the band where data-scaling trends are measurable |
| Natural-language solutions | Writers explain their work in their own style | The trace is trainable, readable, and (later) checkable step-by-step |

**Anti-templatisation and GSM-Symbolic's templatisation are not in conflict — they are the same instrument used at two scopes.** Cobbe forbids templates *across items* so that the train/test split is not a memory test. Mirzadeh imposes templates *within an item* so that the 50 draws share the reasoning graph exactly and differ only in surface bindings. What Cobbe removed is a leak; what Mirzadeh added is a control. A benchmark that wanted both would ship one instantiation per template in the public set and keep the generator.

Also from the same paper and easy to lose: models are trained to **call a calculator** via injected annotations, with the interpreter overriding sampling at test time. Arithmetic execution was factored out of the benchmark from day one — this is the execution rung of [[wiki/concepts/external-verification.md]] wired in as a training-time convention rather than as a checker.

---

## The verifier result — the wiki's origin point for the rejector

Pipeline: finetune a generator 2 epochs → sample 100 completions per training problem → label each by **final answer only** → train a separate verifier 1 epoch → at test time sample 100, rank, return the top.

| Finding | Number | What it means for a builder |
|---|---|---|
| Verification vs finetuning | 6B + verifier slightly beats finetuned 175B | **A rejector is worth ~30× the parameters of a better proposer** |
| Scaling in *data* | Verifier curve steeper than finetuning curve; 175B verifiers "take off" at fewer training problems | The rejector is the component that keeps paying as the corpus grows |
| Small-data regime | Verification is *not* beneficial below a dataset threshold | With few problems the verifier overfits to *the correct answer* faster than it learns *properties of correct reasoning* |
| Token-level vs solution-level | Token-level (a value function, a prediction after every token) wins late despite noisier, slower training; solution-level overfits early | The **PRM/ORM split, four years before the name** — and the mechanism given is auxiliary supervision, not localisation |
| Auxiliary language-modelling loss on the verifier | Strict improvement | The checker must model the language it is checking |
| **Size asymmetry** | Large generator + small verifier ≫ small generator + large verifier | The rejector can be much cheaper than the proposer — and the authors read this as evidence the verifier is using **coarse heuristics**, not verifying |
| Generator training length | test@100 peaks in the first few epochs and then collapses while test@1 still rises | Sampling diversity is a *separate* quantity from accuracy and is destroyed by the same training that improves accuracy |
| Regularisation | 20% residual dropout helps both; solution-level + dropout ≈ token-level | Most of the token-level win is an overfitting win |

**Two of these rows are load-bearing beyond mathematics.** The size asymmetry says the missing component in G68 need not be large — a small, cheap rejector on a strong proposer is the configuration that wins here, which is the opposite of the wiki's usual assumption that verification is the expensive half. And the coverage/accuracy divergence (test@1 up, test@100 down, same run) says that **a system intended to be searched over must be trained differently from a system intended to answer once**: the checkpoint you sample from and the checkpoint you deploy greedily are not the same checkpoint.

**The verifier's supervision is outcome-only, and the paper says the false positives are real** — "some solutions will reach the correct final answer using flawed reasoning". Every downstream use of an outcome-labelled verifier inherits that label noise; the same failure is [[wiki/concepts/rule-level-evaluation.md]]'s subject in the ARC setting.

---

## The inverted U: more search makes a learned verifier *worse*

| Completions ranked per test problem | 6B verifier accuracy |
|---|---|
| increasing to ~400 | rising |
| beyond ~400 | **falling** |

The authors' reading: *"the benefits of search are eventually outweighed by the risk of finding adversarial solutions that fool the verifier."* This is Goodhart measured as a curve rather than asserted, and it contradicts the shape the wiki has been carrying from later systems — o1 at 93% with 1,000 candidates, DeepSeek-Prover-V2 at 88.9% with 8,192, all monotone. The distinguishing variable is not the budget but **what kind of acceptance test is at the top**: a Lean kernel and an invariance-pooling veto ([[wiki/entities/poe-arc-solver.md]]) cannot be fooled by a candidate that is merely persuasive; a learned scalar can. See [[wiki/empirical-tensions.md]] T220.

The paired result is the wiki's first concrete allocation policy for the vote rung: with 100 samples the optimal number of top-ranked solutions allowed to vote is **3–5**; with 3,200 it is **~30**. The number of voters scales with the budget, roughly as a small fraction of it — a rule of thumb for the adaptive-allocation problem [[wiki/concepts/external-verification.md]] leaves open, and evidence that verifier rank and answer frequency are complementary signals rather than substitutes.

---

## The trace result, and what it does to T217

| Intervention | Model | Effect |
|---|---|---|
| Finetune 6B to emit the natural-language solution, then the answer | GPT-3 6B | **20.6%** |
| Finetune 6B to emit the final answer directly, no intermediate steps | GPT-3 6B | **5.2%** |

A 4× loss from deleting self-generated scratch space, in the same year and at a comparable scale as [[wiki/entities/math-dataset.md]]'s 6.9% → 5.3% *loss from adding it*. Both are within-model controlled ablations; they disagree in sign; the datasets differ in difficulty by roughly the distance between grade school and the AIME.

*(brainstorm)* This is the sharpest available support for the per-step-reliability threshold `p*` proposed on the MATH page. Under that reading the two experiments are one experiment at two values of `p`: a 2–8-step problem over `+ − × ÷` with a calculator bolted on has `p` high enough that decomposition dominates prefix contamination; a competition problem does not. What makes the pair almost a controlled comparison is that GSM8K *removes the arithmetic failure mode by construction* (the calculator annotation), i.e. it raises `p` by an explicit intervention. The prediction is that re-running Cobbe's ablation with the calculator disabled moves GSM8K toward MATH's sign, and that the crossing point is where the wiki should put `p*`. Nobody has run it. T217's status is updated accordingly.

---

## GSM-Plus: eight perturbations as a reusable o.o.d. recipe

Five perspectives from Pólya's problem-solving principles, eight perturbations, applied to all 1,319 test seeds.

| Perspective | Perturbation | Tests |
|---|---|---|
| Numerical variation | Numerical substitution (`16→20`) | Overfitting to specific values |
| | Digit expansion (`16→1600`) | Whether the procedure is magnitude-invariant |
| | Integer–decimal–fraction conversion (`2→2.5`, `three→1/4`) | Whether the operation survives a type change |
| Arithmetic variation | Adding operation | Composition depth, holding vocabulary fixed |
| | **Reversing operation** (turn a given into the unknown) | Whether the relation is represented, or only the forward computation |
| Problem understanding | Rephrase | Sensitivity to wording at fixed semantics |
| Distractor insertion | Add a topic-related, numerically-loaded, useless sentence | Statement *evaluation* — deciding what is relevant |
| **Critical thinking** | Delete a statement the solution needs | Whether the model objects instead of answering |

Headline results: a gap of **up to 20 points** between reported GSM8K accuracy and GSM-Plus accuracy, with GPT-3.5-Turbo at **61.19%**; human performance unaffected, because the inherent difficulty of the questions is unchanged; failures occur on problems the same model solves in seed form; 25 models × 4 prompting techniques.

**Three exports.**

1. **Reversing operation and critical thinking are the two perturbations the literature had not tested**, and they are the two that are not about surface form at all. Reversal asks whether the model holds a *relation* (`price × count = revenue`) or a *procedure* (`multiply the two numbers you were given`) — the same discrimination [[wiki/concepts/latent-graph-discovery.md]] draws between an edge and a path, and the same one [[wiki/entities/pgm.md]] draws with held-out `[relation, object, attribute]` triples.
2. **Critical thinking makes "unanswerable" a correct answer.** This is rare in the wiki's benchmark inventory and it is the only cheap instrument here that scores *framing* rather than solving: the model must detect that the problem as posed does not determine an answer ([[wiki/concepts/problem-framing.md]]). The authors' framing is anti-sycophancy; the architectural reading is that an agent without a consistency check over its own premises has no way to emit that answer.
3. **GPT-4 is an unreliable benchmark generator, quantified.** Five named failure modes — the perturbation not applied; extra unrequested changes; invalid questions; difficulty pushed past grade school; wrong answers — and **18.85% of GPT-4's variations needed human revision** (inter-annotator agreement 90.02% on a 10% cross-annotated sample). Any wiki claim resting on a synthetically perturbed benchmark should carry roughly a fifth of its items as suspect unless a human pass is documented.

---

## GSM-Symbolic: accuracy is a distribution, and the published number is its right tail

Setup: 100 GSM8K items converted to parsable templates with typed variables, domains and satisfiability conditions (e.g. divisibility, so answers stay whole); numeric ranges deliberately kept near the originals so that **arithmetic competence is held fixed and only the reasoning is varied** (verified in their appendix); 50 instantiations per template; ~25 models from 2B to 27B plus GPT-4o-mini/4o/o1-mini/o1-preview; 8-shot CoT, greedy; ~500 evaluations.

| Result | Measurement | Reading |
|---|---|---|
| **Variance across matched instantiations** | Best-minus-worst dataset spread >12% (Gemma2-9B), ~15% (Phi-3.5-mini) | The same reasoning graph, re-bound to different names and numbers, is not the same problem to the model |
| **Position of the published number** | GSM8K accuracy lies right of the GSM-Symbolic distribution's centre, often >1 SD, for **21 of 25 models** | A contamination signature that needs no access to the training corpus — the seed is special, and the only thing special about it is that it was published |
| **Names vs numbers** | Variance under name changes < under number changes < under both; the original score sits near the centre of the *names-changed* distribution | Surface identity is nearly free; **quantity binding is not** |
| **Clause count** | M1 → Symb → P1 → P2: mean falls, variance rises, and the *rate* of fall increases | Required steps grow linearly; accuracy falls faster than linearly — not what executing a procedure looks like |
| **GSM-NoOp** (add a seemingly relevant but inconsequential clause) | Up to **65%** drop (Phi-3-mini); significant drops including o1-preview | Models "convert statements to operations without truly understanding their meaning" — a *discount* becomes a multiplication regardless of context |
| **NoOp-Symb** (8 shots of *the same question*, each supplying the correct reasoning chain) | Recovery stays within one SD | **The failure is not a missing demonstration.** In-context supply of the exact reasoning chain does not restore it |
| **NoOp-NoOp** (8 shots of *other* NoOp problems, all requiring the clause be ignored) | Llama-3-8B unchanged; Phi-3 slightly worse | Nor is it a missing instruction to ignore irrelevant text |

**NoOp-Symb is the strongest single row and the wiki did not have it.** Every "just give it better prompts / more examples" answer to a robustness result predicts that showing the model eight worked instances of the identical question makes the ninth easy. It does not. That places the defect below the in-context-learning layer, which is where a *training* or *architectural* fix would have to live — and it is the closest thing in the wiki to the causal-intervention instrument [[wiki/concepts/external-verification.md]] says the robustness debate needs, obtained by intervening on the *context* rather than on the trace.

**The variance result is a G17 instrument, and a cheap one.** Given any benchmark item, variabilise it and report `(mean, SD)` over `n` instantiations plus the seed's z-score within that distribution. It needs no human rater, no second model, no ontology and no held-out concept — and it returns two things at once: a robustness measure (the SD) and a contamination measure (the seed's position). The wiki's G17 instrument list did not contain either.

---

## What a builder should take

1. **A rejector bought more than 30× the parameters, and it can be the small component.** The measured configuration is a strong proposer plus a cheap checker — not two large models (G68).
2. **Coverage and accuracy are separate quantities that the same training destroys and improves respectively.** If the architecture searches at inference time, the sampling policy needs its own objective and its own early stop.
3. **More search is only monotone above a sound acceptance test.** A learned scorer has a peak — here at ~400 candidates — past which the search is optimising the checker (T220).
4. **A number reported on a fixed item set is a sample of size one from a distribution nobody drew.** Templatise, report `(mean, SD)`, and read the published seed's z-score as a contamination test.
5. **The failure that survives everything is deciding what is relevant.** Distractor insertion (GSM-Plus) and NoOp (GSM-Symbolic) are the same probe from two labs, they produce the largest drops in both, and neither few-shot demonstrations of the identical question nor demonstrations of the identical *failure mode* repair it. In [[wiki/concepts/latent-graph-discovery.md]]'s terms this is not navigation failing — it is the model refusing to leave any node out of the graph.

---

## Limitations

- **Cobbe's numbers are GPT-3-era** (6B / 175B, no instruction tuning, no RL). The ablation *structure* is the export; the accuracies are a 2021 snapshot, and the 10¹⁶-parameters-for-80% extrapolation was void within two years for the same reason [[wiki/entities/math-dataset.md]]'s was (T219).
- **Outcome-only verifier labels.** Correct-answer-via-flawed-reasoning is labelled positive by construction, and the paper says so.
- **GSM-Plus's archived copy is partial** — the wiki holds the taxonomy, the protocol and the headline gap, not the per-perturbation table, so no ranking among the eight perturbations is quotable here.
- **GSM-Symbolic evaluates 8-shot CoT greedy only.** No verifier, no sampling, no reranking. It therefore measures the *proposer* under perturbation and is silent on whether any rung of the verification ladder repairs the drop — which is precisely the open question its own conclusion implies.
- **100 templates, and their selection is not described as random.** The right-tail result is over 25 models on those 100 seeds.
- **Contamination is inferred, not shown.** The right-tail position is consistent with training-set overlap and also with the (untested) possibility that the published items are easier than typical draws from their own templates — the templates' variable ranges were chosen by annotators, not by matching the seed's difficulty.
- **…and it has since been shown, by a third party.** Xu et al. 2024 ([[wiki/concepts/benchmark-contamination.md]]) measure verbatim recall directly: Qwen-1.8B reproduces all five sampled 5-grams in **223** GSM8K *training* items, and the train-vs-test familiarity ranking over 31 models puts Qwen, InternLM-2 (non-Base) and Aquila2 at the top — two of which document GSM8K training. The GSM8K **test** split survives that instrument (0 suspicious items for every model under exact match), but Aquila2-34B is *known* to have ingested the whole test split and also reads 0, so the split's apparent cleanliness is not evidence.

---

## Comparison

| | GSM8K | GSM-Plus | GSM-Symbolic | [[wiki/entities/math-dataset.md]] | [[wiki/entities/anli.md]] | [[wiki/entities/conceptarc.md]] |
|---|---|---|---|---|---|---|
| What is held fixed | — | The seed problem | **The reasoning graph** | — | The task | **The concept** |
| What is varied | — | 8 named skills | Surface bindings, clause count | — | The adversary's items | 10 instantiations per concept |
| Instrument returned | Accuracy | Accuracy per skill | **(mean, SD, seed z-score)** | Accuracy; hint curve | Per-item difficulty at authoring | Per-concept coverage |
| Human baseline | Implicit ("a bright middle school student") | Stated unaffected, no `n` given | None | `n = 1` per level | Verifier agreement | 415 participants |
| Contamination detectable | **Yes, by a likelihood differential** (Xu et al. 2024) — but not by the score | No | **Yes, without corpus access** | Same instrument applies | Not by construction | No |
| Saturated | Yes, by ~2023 | No | No | Yes, by ~2024 | Not by construction | No |

The column that matters is *what is held fixed*. GSM-Symbolic and ConceptARC are the wiki's two benchmarks that hold an abstraction constant and resample its surface — one over arithmetic word problems, one over grid puzzles — and both report the same shape of result: accuracy on a named abstraction is not a property of the model alone but of the model and the particular instantiation it was shown.

---

## Connections

- **[[wiki/concepts/external-verification.md]]** — the primary source for the page's origin claim: a separate verifier reranking 100 samples ≈ 30× parameters, the ORM/PRM split prefigured as solution-level vs token-level scoring, the first measured *price* of the rejector relative to the proposer (it can be the smaller model), the first allocation rule for the vote rung (3–5 voters of 100, ~30 of 3,200), and the inverted-U that bounds the whole ladder wherever the acceptance test is learned.
- **[[wiki/concepts/shortcut-learning.md]]** — supplies the cheapest general o.o.d. recipe in the wiki: hold the reasoning graph fixed and perturb the surface along eight named axes, or re-instantiate from a template and read the SD. Both are the "cheap o.o.d. test" that page lists as an open problem, and GSM-NoOp is the shortcut caught in the act — statements converted to operations by keyword regardless of meaning.
- **[[wiki/entities/math-dataset.md]]** — the opposite-signed half of T217, measured in the same year at comparable scale: deleting the self-generated trace costs 4× here, adding it costs 1.6 points there, and the difficulty gap between grade school and competition mathematics is the free variable that reconciles them.
- **[[wiki/concepts/refinement-loop.md]]** — the 20.6% → 5.2% ablation is the loop's substrate measured at its cheapest (write tokens, check nothing) on a distribution where it works, which localises the loop's value in per-step reliability rather than in the feedback signal alone.
- **[[wiki/concepts/rule-level-evaluation.md]]** — the same defect one level up: outcome-only verifier labels certify the answer and never the derivation, so "correct final answer via flawed reasoning" is a training-set positive here exactly as an unintended-but-correct rule is a scoring-set positive there.
- **[[wiki/concepts/problem-framing.md]]** — the *critical thinking* perturbation is the wiki's only cheap instrument that scores framing directly: a statement the solution needs is deleted, and the correct response is to report that the problem is underdetermined rather than to produce a number.
- **[[wiki/concepts/latent-graph-discovery.md]]** — GSM-Symbolic is the framing's control condition: the latent graph is *held identical* across 50 draws by construction, so any variance is the model failing to recover a structure it has already recovered once — and the reversing-operation perturbation separates holding an edge from having memorised one traversal of it.
- **[[wiki/entities/poe-arc-solver.md]]** — the resolution candidate for the inverted-U: pooling over provable invariances is a *sound* acceptance test that a persuasive-but-wrong candidate cannot fool, which is why its curve does not turn down where a learned scalar verifier's does.
- **[[wiki/entities/conceptarc.md]]** — the same design move in the grid domain: hold the abstraction, resample the instantiation, report the spread rather than the point — and the same conclusion, that a benchmark of one instantiation per concept measures the instantiation.
- **[[wiki/entities/pgm.md]]** — the structural counterpart to the reversing-operation perturbation: PGM withholds `[relation, object, attribute]` triples at the level of the abstraction, GSM-Plus inverts which term of a known relation is the unknown, and both ask whether the relation was represented or only one direction of its use.
- **[[wiki/entities/anli.md]]** — the other route to a non-saturating benchmark, and the expensive one: ANLI pays humans to find the failures, GSM-Symbolic generates them from a template for free — at the cost that its failures are all of one kind (surface rebinding) while ANLI's are open-ended.
- **[[wiki/concepts/test-time-training.md]]** — the negative control for in-context adaptation: NoOp-Symb supplies eight demonstrations of the *same question with its reasoning chain* and the drop persists within one SD, so whatever is failing is not reachable by conditioning on task-matched examples.
- **[[wiki/empirical-tensions.md]]** — T217 (a self-generated trace helps or hurts — this source is the strongest evidence on the *helps* side and converts the row into a threshold), T220 (whether best-of-`k` is monotone in `k`).
- **[[wiki/entities/gpqa.md]]** — the perturbation protocol's most obvious untaken target: every GPQA item ships an expert-written explanation stating its hop chain, so each hop is a legal GSM-Symbolic-style perturbation site, and whether graduate-science competence survives matched re-instantiation is the experiment that would settle [[wiki/empirical-tensions.md]] T221.
- **[[wiki/entities/olymmath.md]]** — `I14` exported to a new axis and to a harder tier: a parallel-language item pair changes every token and no relation, which is the limit case of the *rephrasing* perturbation — and it exposes the precondition this page's instruments leave unstated, since the Chinese versions' extraction failures cluster among the incorrect responses, so a meaning-preserving perturbation must also preserve the **grader's** competence (T223).
- **[[wiki/concepts/benchmark-contamination.md]]** — this benchmark is one of that page's two testbeds, and the source that turns its own "contamination is inferred, not shown" limitation into a measurement: 223 training items reproduced verbatim by a 1.8B model, and a 31-model leakage ranking whose top group matches the labs that disclosed GSM8K training.
- **[[wiki/concepts/certification-instruments.md]]** — supplies instrument `I14` — the named-perturbation sweep and template re-instantiation — including the contamination test that needs no access to the training corpus.
- **[[wiki/entities/frontiermath.md]]** — the opposite end of the same axis, and where I14 runs out: template re-instantiation needs items that can be re-instantiated, and FrontierMath's are deliberately one-of-a-kind (>200 techniques, the commonest pair in 3 problems) — so the wiki's cheapest contamination test is unavailable on the benchmark with the strongest contamination defence.
- **[[wiki/concepts/human-baseline.md]]** — the asserted baseline ("a bright middle-school student"), i.e. none, on a benchmark whose scores drove five years of method development.
- **[[wiki/entities/math-perturb.md]]** — `I14` run in the opposite direction, and the defect it cannot see: GSM-Symbolic holds the reasoning graph and resamples the surface, MATH-P-Hard holds the surface (retrieval MRR 0.986) and breaks the graph, so the first detects a model keyed on tokens and only the second detects one keyed on problem identity — and its contamination read-out is cheaper still, the method-preserving arm's drop restricted to train-split seeds, needing no template and no variable typing.
- **[[wiki/entities/hle.md]]** — the second inverted-U in inference budget, and the control for this page's: HLE's accuracy turns down beyond 2^14 output tokens **with no verifier and no selection in the loop**, so a Goodhart-on-a-learned-scorer mechanism cannot explain it and T220 needs two separate causes.
- **[[wiki/entities/aime.md]]** — the far end of the difficulty interval this page's trace ablation brackets: 15 competition items in 3 hours with a calculator forbidden against 2–8 elementary steps with the arithmetic annotated away, which is the span T217's per-step-reliability threshold `p*` has to be located inside; both grade the final answer only.
- **[[wiki/entities/shortcut-suite.md]]** — NoOp's third replication, in a different task family and with the demonstration manipulation GSM-Symbolic did not run: shots drawn from the *shortcut-laden distribution itself* recover ICL's own damage (9.3 → 35.0 on Constituent `¬E`) and still fall short of zero-shot (40.2), so the relevance-selection defect sits below the in-context-learning layer in NLI as well as in arithmetic — and its construction removes the 18.85% draft-correction cost this page's perturbation sweep pays, at the price of a conspicuous rather than plausible distractor.
- **[[wiki/entities/prm800k.md]]** — this page's token-level verifier reused unchanged as the ORM baseline, and the resolution of the disagreement it seeded: Uesato et al. found process ≈ outcome on *this* benchmark, Lightman et al. found process ≫ outcome on MATH, and the data-scaling ablation reconciles them on supervision volume (the curves coincide at small scale and separate as process supervision is scaled). This page's inverted-U at ~400 candidates also reappears there, but only for the ORM and only on the easiest difficulty quintile, while the PRM shows none out to 1,860 (T220).
