# ARC — Abstraction and Reasoning Corpus

**A benchmark of ~1,000 hand-authored grid-transformation tasks, each specified by ~3 input/output example pairs, designed so that every evaluation task is novel to the *developer* as well as the system, and so that the only knowledge required is an explicitly enumerated set of Core Knowledge priors.**

> **Provenance.** Chollet 2019, *On the Measure of Intelligence* (`raw/chollet-2019-measure-of-intelligence.md`), part III, for the design rationale. **Updated with the benchmark's own five-year record**: Chollet, Knoop, Kamradt & Landers 2024, *ARC Prize 2024: Technical Report* (`raw/chollet-2024-arc-prize-report.md`), plus the ARC Prize series and ARC-AGI-1 overview pages (`raw/arcprize-nd-arc-agi-series.md`, `raw/arcprize-nd-arc-agi-1-overview.md`, both undated site material, `(tentative)` where they are the only source). **Human-side behavioural data** — the baseline rows, the process trace and the error analysis — come from Johnson, Vong, Lake & Gureckis 2021 (`raw/johnson-2021-human-program-induction-arc.md`), the first behavioural study run on this benchmark. The benchmark was renamed **ARC-AGI-1** when successors appeared; the successors now have their own pages ([[wiki/entities/arc-agi-2.md]], [[wiki/entities/arc-agi-3.md]]). This page is ARC-AGI-1 from 2019 to the end of 2024.

The wiki's first benchmark page, and the first artefact built explicitly to satisfy [[wiki/concepts/skill-acquisition-efficiency.md]]'s requirement list.

---

## Format

| Property | Value |
|---|---|
| Tasks | 1,000 total, all unique and disjoint. **As of 2024**: 400 public training (easy) · 400 public evaluation (hard) · 100 **semi-private** evaluation (hard, introduced mid-2024) · 100 private evaluation (hard). The 2019 paper's split was 400/400/200 — the 200 was later halved to create the semi-private set |
| Per task | Two or more demonstration pairs, **median 3**, one or more test inputs |
| Grid | Symbols from a 10-value alphabet ("colours"), size 1×1 to 30×30, median 9×10 |
| Output | Constructed from scratch — the solver chooses the output grid's height, width and every cell |
| Scoring | Exact match, binary; **2 attempts** per test input in competition (the 2019 paper specified 3); feedback is correct/incorrect only |
| Training set role | Development/validation for the builder, or familiarization with the priors — *not* required; the evaluation set assumes nothing learned from it |

The from-scratch output construction is load-bearing: there is no answer set to discriminate over, so the solver must *produce* the transformation's result rather than recognize it. A multiple-choice version would admit elimination shortcuts.

**Why there are two hidden sets.** The **private** set evaluates standalone submissions running offline (Kaggle: one P100, 12 hours, no internet) and is theoretically leakage-free. The **semi-private** set exists because evaluating a closed commercial API means *sending the tasks to the vendor*, so those 100 tasks are assumed compromised by construction and are used only where that is unavoidable. Public-eval and semi-private scores are reported together, and a submission is called overfit if they differ by more than ±10 absolute points — a cheap, generalizable contamination check any benchmark could adopt.

---

## The declared priors

ARC's central design move: state the entire prior set, and use nothing else. Directly Spelke's four systems ([[wiki/concepts/core-knowledge.md]]).

| Prior | Content as instantiated in grids |
|---|---|
| **Objectness** | *Cohesion* — parse grids into objects by colour continuity or spatial contiguity, and into zones/partitions. *Persistence* — objects survive noise and occlusion, and usually reappear in the output, transformed. *Influence via contact* — translation-until-contact; lines that grow and rebound off obstacles |
| **Goal-directedness** | Input and output read as start and end states of an intentional process (e.g. reaching a goal efficiently). ARC has no time axis, so this prior is useful but not strictly required |
| **Number and counting** | Counting, sorting by size, most/least frequent, same-count, largest/smallest, addition/subtraction, repeating *n* times. All quantities ≲10 — inside the Core Knowledge small-number range |
| **Geometry and topology** | Lines and rectangles; symmetry, rotation, translation; up/down-scaling and elastic distortion; containment and inside/outside; drawing lines, connecting points, orthogonal projection; copying and repetition |

Deliberately **excluded**: language, learned symbols (arrows), real-world object categories, common sense, anything requiring practice. This is what makes the human/machine comparison meaningful — the prior term `P` in the intelligence formula is equalized by construction rather than estimated.

---

## What it does differently from an IQ test

| Against psychometric tests | Against multi-task ML benchmarks |
|---|---|
| Assesses fluid intelligence only — no crystallized abilities (reading, vocabulary, acquired concepts) | Evaluation tasks are unknown to developers, so hard-coding is blocked (a private set enforces it) |
| Hundreds of low-overlap tasks, not a handful of item types, so per-task hard-coding is not a practical shortcut | Experience is capped: ~3 examples per task, and tasks are chosen to resist synthetic data generation |
| Tasks are **hand-authored, not programmatically generated** — a static master generator would let a solver reverse-engineer one simple program and clear the whole set (Chollet's stated objection to the C-Test) | Priors are enumerated instead of implicit |

---

## Position in the latent-variable taxonomy

Fills the placeholder row in [[wiki/concepts/latent-graph-discovery.md]]:

| Latent variable | ARC status |
|---|---|
| Node content | Given — grids are fully observed, no aliasing, no partial state |
| Edge existence / topology | Not applicable — a single edge connects input to output |
| **Edge label** (the rule) | **Latent — the whole task.** Induce one transformation from ~3 endpoint pairs |
| **Edge vocabulary** | **Latent in practice.** The primitive set is *described* (the four priors) but not *given* in program form; supplying it as a composable DSL is the unsolved half |
| Path (composition) | Latent where a task needs several chained operations, over a vocabulary the solver must have built itself |
| Goal node | Latent — the output grid must be constructed, including its dimensions |

**So ARC is the pure edge-label-latent case with a co-latent vocabulary**: exactly hardness sources 1 (two-level entanglement — a meta-graph of transformation types instantiated per grid pair) and 2 (unknown vocabulary), with sources 3–6 designed out. That narrowness is a feature: it isolates the variables the wiki's other benchmarks confound.

---

## Human baseline

| Sample | Result |
|---|---|
| 2019, three high-IQ subjects, independently | Every task solved by at least one; most on first try, no practice, no verbal instruction |
| Private evaluation set, two testers | **97% and 98%**; together 100% |
| Public evaluation set, Mechanical Turk, 10 workers per task (NYU study, secondary) | **99%** of tasks solved by at least one worker |
| **Public *training* set, 40 tasks, 95 Mechanical Turk participants, 10 tasks each, 3 attempts** (Johnson et al. 2021, first-hand) | **83.8%** mean per-task accuracy (SD 16.7); **8.38 of 10** tasks per participant (SD 2.7, modal 10/10); every task solved by at least one participant; 65% of tasks at ≥80% accuracy, the hardest at 38.1% |
| Average human on the evaluation set, per the 2025 ARC Prize figures | **60.2%** |

The "no large-sample human data" limitation Chollet listed in 2019 is partly closed by the NYU study — but note what it measures: *union over ten workers*, not per-subject rate, so it establishes solvability, not difficulty calibration. The report's own admission is that the four subsets are **not drawn from a consistent human difficulty distribution**, which makes public-eval and private-eval scores not directly comparable.

**There is no single human baseline for this benchmark, and the spread is 60% to 99%** — union-over-testers on the private set, per-subject on the training set, and the reported average on the evaluation set are three different quantities collected on three different task pools ([[wiki/empirical-tensions.md]] T213). Every "above/below human" claim in the wiki inherits the ambiguity, including the ARC Prize's own framing of [[wiki/entities/poe-arc-solver.md]]'s 71.6% as super-human.

**The same-tasks machine comparison, which is the part that does not depend on the choice of baseline.** Johnson et al. ran the 2020 Kaggle winner on their own 40 tasks: **57.5% against 83.8% human**, versus 21% on the hidden test set. Two readings, both worth carrying — the training set is much easier for machines than the score usually quoted for this benchmark, and the residual 26-point gap survives on tasks a machine already handles at more than half.

**Human and machine difficulty orderings barely agree**: Spearman `ρ = 0.35` (`p < .05`) between per-task human accuracy and Kaggle-program accuracy, and the paper attributes even that to the algorithm failing the hardest tasks while catching some of the easiest. Human difficulty was highest on tasks needing **logic, rotations and flips**, lowest on **colour manipulations** (inversion, filling). This is the same finding [[wiki/entities/conceptarc.md]] reports per concept — difficulty is a property of the (solver, task) pair — arrived at independently on the original task set, and it is why a human-calibrated difficulty index (which [[wiki/entities/arc-agi-2.md]] adopts) predicts machine difficulty poorly by construction.

---

## What the human solution process looks like

Johnson et al. logged every editing action, not just the final grid, which makes this the wiki's only trace-level record of anything solving ARC.

| Observation | Number | What it constrains |
|---|---|---|
| Time per task | 3 min 06 s (SD 2 min 37 s) | — |
| **Time before the first action** | **36 s (SD 1 min 07 s)**, ~19% of the solve | Hypothesis formulation happens *before* any output is constructed, and it is a substantial fraction of the budget. No solver in the wiki has a phase that produces nothing |
| Attempts used | 1.59 of 3 (SD 0.46) | The three-attempt allowance is mostly unused; a `pass@1` human number would be close to the reported one |
| Pairwise Levenshtein distance between participants' action sequences on a task | 74 edits (SD 53), over correct attempts | Routes to the same grid vary widely — and more than output size alone explains |

**Object-based sub-goals, visible as bottlenecks.** Rendering all participants' action sequences for one task as a state-space graph (nodes = output states, edges = actions) shows heavy convergence on a few paths through common intermediate states, and those bottleneck states are **task-relevant objects**: the first action is almost always either resize-the-output-grid or copy-the-input, and thereafter participants complete one object at a time. The decomposition is into *objects*, not into grid regions or into DSL operations — which is [[wiki/concepts/temporal-abstraction-options.md]]'s bottleneck-subgoal story appearing in human behaviour on this benchmark, with the partition supplied by the object parse rather than by graph connectivity.

**Errors respect the object priors; DSL-search errors do not.** Human wrong answers on the box-alignment task get the shapes, the colours and one of the two alignment axes right. The Kaggle program's wrong answers get the colours right and violate objectness outright — shapes egregiously elongated, one shape wrapped around the grid edge. Two consequences:

- Exact-match binary scoring deletes a **graded, label-free signal about which part of a hypothesis is right**, available from the output alone. Independently replicated at concept level by [[wiki/entities/conceptarc.md]], whose near-miss analysis this predates.
- A solver whose errors violate the declared priors was never constrained by them, whatever its score. This is the cheapest available audit of whether the four priors are in the system or only in the benchmark description.

---

## Five-year record: what actually moved

| Year | State of the art (private eval) | What produced it |
|---|---|---|
| 2019 | — | Benchmark released. GPT-3 by direct prompting: **0%** on public eval |
| 2020 | **20%** (icecuber, Kaggle) | Brute-force search over a DSL. **No deep-learning entry above 1%** |
| 2020, post-hoc | *49%* solved by at least one entry | Ensembling all 2020 submissions — see Flaws below |
| 2021–2023 | 33% | Improved DSLs (notably Hodel's). Advent of GPT-3/3.5/4 changed nothing |
| 2024 (ARC Prize) | **55.5%** (MindsAI, not open-sourced) · 53.5% (ARChitects, 1st place) | Test-time training; LLM-guided program synthesis; ensembles of both |
| 2025 | **71.6%** public eval, open weights ([[wiki/entities/poe-arc-solver.md]]) at **$0.02/task** | The 2024 winner rebuilt: TTT + DFS candidate enumeration + product-of-experts selection over 16 augmentations. Above the 60.2% average human, below o3's 82.8% at $17/task |
| Dec 2024 | 75% (low compute) → **87.5%** (high compute) on semi-private, o3-preview `(tentative — vendor-reported)` | The first Large Reasoning Model. ARC-AGI-1 was the benchmark that isolated the arrival of test-time reasoning |

**The interpretive claim the report makes, and it is the one worth carrying:** ARC-AGI-1 stayed near-flat through a **~50,000× scale-up of LLM pretraining**. If a benchmark's score is insensitive to four orders of magnitude of the field's dominant lever, either the benchmark measures nothing or the lever does not touch what it measures — and every other benchmark of the period moved. This is [[wiki/concepts/skill-acquisition-efficiency.md]]'s unlimited-experience channel closed empirically rather than by argument.

---

## What the top approaches are

Three families, and the report's finding is that the first two are complementary rather than competing ([[wiki/concepts/test-time-training.md]]).

| Family | Mechanism | Best reported |
|---|---|---|
| **Brute-force DSL search** | Exhaustive enumeration over a hand-built DSL | 40% private (alijs), still competitive in 2024 |
| **LLM-powered program generation** | Prompt an LLM for thousands of candidate Python programs per task, run them on the demonstration pairs, keep what fits; iteratively debug near-misses (Greenblatt, GPT-4o) | 42–43% |
| **LLM-guided DSL search** | Use the LLM to prune/steer branching inside a DSL rather than to emit whole programs (Ouellette) | Paper award |
| **Test-time training (transduction)** | Fine-tune on the task's own demonstration pairs, predict the output grid directly | 53.5–55.5% private; **71.6% public eval** ([[wiki/entities/poe-arc-solver.md]], 2025) |
| **Ensemble of induction + transduction** | Both, union of solutions | **Every** 2024 top score |

Two facts constrain any solver design here:

- **Induction-only ≈ 40%, transduction-only ≈ 40%, and they solve different tasks.** Only the ensemble competes for state of the art (Li et al., 1st-place paper).
- **Deep-learning-guided program synthesis does not yet beat brute force** — both are around 40% at comparable budgets. The advertised advantage of learned search is unrealized on this benchmark.

The one approach the report names as untried and expects to work: **specialist deep models guiding the branching decisions of a discrete search**, AlphaProof-style. That is [[wiki/concepts/amortized-inference.md]] applied to the search tree rather than to the hypothesis, and it remains the field's open bet.

---

## Score is not a property of an approach

The report's sharpest methodological claim, and it generalizes past ARC: **any search-based method scores higher with more compute, so a score attaches to (approach, compute budget) and never to an approach alone.** Its worked estimate: Greenblatt's method would reach ~85% at roughly **10⁸ generated-and-evaluated programs per task** — a multi-million-dollar bill for 100 tasks.

Against which the same report reports the opposite: the two 2024 leaderboards differed by **~1,000× in compute per task** ($10 of Kaggle compute vs. up to $10,000 in API credits) and their top scores landed within 0.1 points of each other (53.5% vs. 53.6%). Logged as [[wiki/empirical-tensions.md]] T204 — the two claims are not formally contradictory (one is about the shape of the tail, the other about the current frontier) but they license opposite research bets, and the report draws the optimistic one: *"algorithmic improvements towards AGI hold significant power and massive compute may not be necessary."*

**The o3 line, priced** `(tentative — cost estimates are ARC Prize's, reported second-hand by Pfister & Jud 2025)`:

| Setting | Semi-private score | Total compute cost | Per task |
|---|---|---|---|
| o3 low-compute | 75.7% | ~$2,012 | **~$20** |
| o3 high-compute | 87.5% | ~$346,000 | **~$3,460** |

**A number conflict the wiki was carrying.** [[wiki/concepts/external-verification.md]] quotes ~**$30,000** per task for o3-high on this benchmark; the ARC Prize figures above give ~$3,460, and they are internally consistent (the high-compute run is reported as ~172× the low-compute run's $20). The order of magnitude is not settled here — both figures are second-hand and neither source states its accounting — so any argument that turns on the exact price should be read as turning on "thousands of dollars per task", which both support. Flagged rather than reconciled.

Consequence for the wiki: every benchmark row here needs an inference-budget column, which is the same discipline [[wiki/concepts/external-verification.md]] extracts from the mathematics literature (report pass@1, majority@`k`, the selection mechanism, and the token budget).

---

## Known flaws of ARC-AGI-1

The report's own list, all of which bear on the wiki's use of ARC as its G17 instrument.

| Flaw | Evidence | Consequence |
|---|---|---|
| **A large fraction of the set is brute-forceable** | 49% of the private eval set was solved by *some* 2020 submission, all of them brute-force DSL search | Roughly half the benchmark "does not carry a useful signal towards AGI". Any score below ~50% may be measuring coverage of the tractable half — [[wiki/empirical-tensions.md]] T205 |
| **The private set is being eroded by measurement** | 100 tasks, unchanged since 2019, with ~10,000 scores reported across four competitions; each score leaks a small amount of information about hidden task content | Developer-blindness has a **half-life proportional to leaderboard queries**. The fix adopted for ARC-AGI-2: separate the leaderboard set from the final-scoring set, and enlarge both |
| **Inconsistent human difficulty across subsets** | Anecdotal, per the report | Cross-subset score comparisons are not licensed |
| **Only 100 private tasks** | — | Sampling noise of several points is structural |

**A second flaw list, from outside the ARC Prize Foundation** (Pfister & Jud 2025, `raw/pfister-2025-o3-is-not-agi.md`). These are not defects of execution but of the *format*, and the authors state that none is removable by adjustment within it.

| Flaw | Mechanism | Consequence |
|---|---|---|
| **The problem representation is supplied, identically, by every task** | Every task is "find the simplest transformation composed from a finite, small set of Core Knowledge operations, mapping input grid to output grid". Only the selection and ordering vary | The benchmark scores optimisation within a given representation and never the *construction* of one, which the source argues is the harder half of most real problems ([[wiki/concepts/problem-framing.md]], gap G73) |
| **Candidates are free to test before submission** | Single correct output per input + given demonstration pairs ⇒ a rule is verifiable exactly when it reproduces every pair | Massive trialling of low-quality candidates is a complete method. Domains where an attempt is irreversible (a physical action, a one-shot decision) admit none of the wiki's search or refinement mechanisms (gap G74) |
| **Training cost is not charged** | Competition rules cap *inference* compute (one P100, 12 h) and say nothing about pretraining or synthetic-task generation; 2024 entrants trained on large volumes of artificially generated ARC-like tasks | The unlimited-priors channel [[wiki/concepts/skill-acquisition-efficiency.md]] names, relocated to a line item the rules do not read. Training on generated ARC tasks is by the source's own definition the acquisition of a *skill*, which is the thing the benchmark intends to exclude |
| **Goodhart's Law, observed** | Prize money made the score the target: optimised core-knowledge representations, synthetic ARC training corpora, hundreds of submissions used to probe the private set | The measure/target gap becomes an optimisation surface. The source's prescription is not a better benchmark but *maximal correspondence between measure and target* — "the best benchmark for intelligence is intelligence itself" |

**Reading.** These are not incidental defects: the first is Chollet's own 2019 "a shortcut may exist that clears the set without abstraction" objection *confirmed at 49%*, and the second is a failure mode intrinsic to the developer-aware design — a hidden set is a depleting resource, and nothing in [[wiki/concepts/skill-acquisition-efficiency.md]]'s checklist prices its depletion.

---

## Status of the 2019 claims

| 2019 claim | 2024 status |
|---|---|
| Not approachable by any ML technique | **Falsified in the strong form.** Approachable, unsolved: 55.5% vs. an 85% target, against ~98% human |
| Deep learning cannot do it | Holds for *frozen* deep learning: no static-inference transduction solution exceeds 11% |
| A public competition will surface any shortcut fast | **Vindicated** — the shortcut (brute-force reach) was surfaced by ensembling the first competition's entries |
| Validity not established | Still open; no demonstrated predictiveness outside ARC |

---

## The intended solution shape

Chollet frames ARC as a **program synthesis** benchmark, and sketches the solver:

1. Build a domain-specific language (DSL) expressing every possible ARC solution — i.e. hard-code the four Core Knowledge priors in sufficiently abstract, *combinable* program form. Chollet: "solving this specific subproblem is critical to general AI progress."
2. Search the DSL for programs mapping the demonstration inputs to their outputs, **reusing and recombining sub-programs that worked on earlier tasks**.
3. Rank candidates by simplicity or learned likelihood — *not* by simplicity alone, since the shortest training-consistent program is the object his own `GD` argues against.
4. Emit the top three.

**Wiki reading.** Step 1 is gap G21 (compose the outputs of pre-installed modules) stated as an engineering deliverable rather than a developmental puzzle: the priors are not the problem, the *combinable program form* is. Step 2 is the meta-graph accumulating as a growing library — the same object as [[wiki/entities/bayesian-program-learning.md]]'s primitive library, but with the library to be discovered rather than authored. Step 3 concedes that selection by description length is insufficient and offers a *learned* prior over programs in its place, which is gap G26 (nothing selects hypotheses by structure rather than by length) receiving its first concrete, if under-specified, proposal.

---

## Limitations (Chollet's own list)

- **Generalization difficulty is not quantified** — for the set or per task. The benchmark built to operationalize `GD` does not measure it. Proposed fix: use human success rates as an empirical proxy and correlate with an AIT approximation, once solvers exist to supply one.
- **Validity not established** — no large-sample human study, no demonstrated predictiveness for anything outside ARC.
- **Scale and diversity may be too small** — 1,000 tasks with conceptual overlap leaves room for a shortcut that clears the set without abstraction. Mitigation is a public competition on the private set: if a shortcut exists, a competition surfaces it fast. **Confirmed, and the mitigation worked**: the 2020 competition's pooled entries reached 49% by brute force, which is the shortcut arriving on schedule and being detected by exactly the mechanism proposed (Chollet et al. 2024).
- **Binary, close-ended scoring** — 0 or 1 per task, no partial credit. The proposed better format is *interactive*: the solver requests new test inputs at will, proposes, receives feedback, iterates, and is scored on the *amount of interaction* needed. That is a direct measurement of `E` (experience) rather than of skill.
- **The priors may be wrong** — the actual inventory of innate human knowledge is unsettled ([[wiki/concepts/core-knowledge.md]] open problems), and whether the four systems are faithfully captured in grid form is untested.

**(brainstorm) A weakness not on Chollet's list.** ARC's tasks are hand-authored by a small group, so its "meta-graph" is the *author's* concept vocabulary. A solver could recover that vocabulary — a psychometrics of Chollet — without recovering anything about abstraction in general. The teacher–student construction he offers as an alternative is precisely the escape, and it is the one part of the proposal never built here.

---

## Comparison

| Benchmark | Controls developer knowledge | Caps experience | Priors stated | Measures |
|---|---|---|---|---|
| **ARC** | Yes (private evaluation set) | Yes (~3 examples/task, no generator) | Yes (four Core Knowledge systems) | Broad generalization, edge-label + vocabulary latent |
| Omniglot | Partly | Yes (one example) | No | One-shot concept induction with a known primitive type (pen strokes) |
| ImageNet / ImageNet-C / ObjectNet | No | No | No | Local generalization; robustness to a specified nuisance axis |
| Atari / DotA2 / StarCraft | No | No (unbounded self-play) | No | Skill. Zero generalization difficulty once a generator exists |
| CoinRun / Obstacle Tower | No (level generator is public) | No | No | Local generalization — new samples from a known distribution, not a new task |
| Raven's Progressive Matrices | No (item types public and hard-codable) | Yes | No (implicit) | Fluid intelligence in humans; gameable for machines |

The column that matters is the first: it is the only one no benchmark before ARC has a "yes" in, and the only one that cannot be retrofitted by better scoring.

---

## Connections

- **[[wiki/entities/pcfg-set.md]]** — the complementary instrument: ARC withholds the tasks from the developer and returns one number, PCFG SET withholds combinations, lengths and contexts from the model and returns five facet scores, so a failure can be attributed to systematicity, productivity, substitutivity, localism or overgeneralisation rather than to "reasoning".
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the theory this benchmark instantiates; ARC is the checklist made concrete, and its unquantified `GD` is the checklist's one unmet item.
- **[[wiki/concepts/core-knowledge.md]]** — supplies ARC's entire prior set; ARC is in turn the first machine-side operationalization of the four systems, listing what each looks like as a grid operation.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the pure edge-label-latent task with a co-latent vocabulary: hardness sources 1 and 2 isolated, 3–6 designed out.
- **[[wiki/concepts/compositionality.md]]** — the proposed solver is a DSL search that recombines sub-programs found on earlier tasks, which is compositional generalization made the *evaluation criterion* rather than an emergent property.
- **[[wiki/entities/bayesian-program-learning.md]]** — the closest existing architecture: a library of primitives plus per-instance stochastic programs. The difference is that ARC forbids authoring the library, which is exactly what BPL does by hand.
- **[[wiki/concepts/shortcut-learning.md]]** — built as the answer to "dataset ≠ ability": every design choice (private set, capped examples, no generator, hand-authoring) removes one shortcut channel, and the residual risk Chollet admits is that an unforeseen one survives.
- **[[wiki/entities/aixi.md]]** — the opposite pole of the same AIT tradition: AIXI maximizes reward over all computable environments with unbounded resources; ARC scores a finite learner on a scoped, prior-equalized task set, which is what makes it measurable.
- **[[wiki/entities/hbtom.md]]** — the opposite evaluation design: ARC hides the transformation from the developer and supplies nothing, BIB hides an agent's dispositions and supplies the modeller the entire state space, so one probes discovery and the other probes use.
- **[[wiki/entities/irene.md]]** — evidence that the supply-the-state design is nonetheless unsaturated: a model handed the symbolic scene graph is still at chance on the BIB task requiring a preference bound to an agent across trials.
- **[[wiki/concepts/program-induction.md]]** — the reduction the intended solver assumes, with this benchmark supplying its two hardest constraints: the library may not be authored (G4) and ranking by description length is conceded insufficient (G26).
- **[[wiki/entities/spelkenet.md]]** — what would have to run first if this benchmark's tasks arrived as pixels rather than as grids: the objectness prior this page declares and then supplies by fiat, computed instead by poking a video world model and clustering the co-moving pixels (Venkatesh et al. 2025).
- **[[wiki/entities/neo-neural-theorizer.md]]** — the explicit contrast on this benchmark's central data assumption: ARC hands the solver ~3 pairs known to share one program, and OTIB withholds exactly that, training on i.i.d. phenomena where even *which examples share a mechanism* is latent — so it induces a library where ARC's intended solver is handed one.
- **[[wiki/concepts/external-verification.md]]** — what this benchmark's frontier scores are actually purchased with: ~$30,000 per task at o3-high, 1,024 candidates of ~137 pages each, so the selector rather than the policy is doing the work — and the same pass@1 / vote / verifier-selected decomposition applies here as to every math leaderboard (Raiyan et al. 2026).
- **[[wiki/entities/ilp-arc-synthesizer.md]]** — the first attack on this benchmark the wiki holds at source, and a demonstration of where its difficulty sits: with seven authored predicates the search, the rejection and the ranking all become cheap, and the *task selection* has to be conditioned on the predicate set.
- **[[wiki/entities/corethink-compositional-reasoner.md]]** — this benchmark's successor version (ARC-AGI-2, `pass@2`) attacked with no training at all, and a measurement of where the difficulty sits now: a 22-item authored pattern menu plus cross-example consensus lifts a frozen LLM from 15–18% to 24.4%, and the residual failures are the compositional tasks the menu cannot name.
- **[[wiki/entities/arc-vsa-solver.md]]** — the first attack on this benchmark that supplies two of its four declared priors as properties of the *representation format* (geometry and number arrive with the SSP encoding, where binding is translation) rather than as DSL entries; also the source of the wiki's sharpest price on demonstration-consistency, reporting demonstrations and queries separately (48.8 → 10.8 on Train, 33.5 → 3.0 on Eval).
- **[[wiki/entities/mlc.md]]** — the same task shape (infer a latent transformation from a handful of demonstrations, apply it to a held-out input) with an episode generator supplied, which is exactly what ARC withholds: MLC's result is an argument that part of ARC's difficulty is the absence of a `p(T)` to meta-train on, and its 100% error on length-extrapolation splits is the warning that a sampler buys only the facets it varies.
- **[[wiki/concepts/test-time-training.md]]** — the technique this benchmark produced and the measurement that makes it load-bearing: no frozen-inference transduction solution exceeds 11% here, while fine-tuning on each task's own demonstration pairs reaches 53.5%, so the benchmark's five-year resistance is specifically a resistance to *static* deep learning (Chollet et al. 2024).
- **[[wiki/entities/arc-agi-2.md]]** — the successor built from this page's own flaw table: brute-forceable tasks removed (icecuber 17% → 1.6%), 407-participant first-party human calibration, leaderboard and final-scoring sets separated, cost-per-task made mandatory — and the 2024 winner here (56%) carrying over at 2.5% is the certificate that the repair changed what is being measured.
- **[[wiki/concepts/refinement-loop.md]]** — what this benchmark's 2024 report predicted (learned guidance of *branch* decisions inside a search) arriving in a different form in 2025 (learned guidance of *edits* to a complete candidate), against this page's blind-search ≈ LLM-guided-search ≈ 40% control.
- **[[wiki/entities/arc-agi-3.md]]** — this page's own limitations list delivered: the "binary, close-ended scoring" bullet proposes an *interactive* format in which the solver acts, receives feedback, iterates, and is scored on the amount of interaction needed, which is exactly what ARC-AGI-3 does with actions as the interaction unit and a human's action count as the denominator.
- **[[wiki/concepts/problem-framing.md]]** — the sharpest external critique of this benchmark's format: the transformation-from-Core-Knowledge-operations representation is identical across all 1,000 tasks and demonstration pairs make every candidate free to test, so a high score is evidence about search within a supplied representation and about nothing upstream of it (Pfister & Jud 2025).
- **[[wiki/entities/raven.md]]** — the multiple-choice benchmark this page's from-scratch output design was aimed at, with the measurement that vindicates it (attribute-wise majority vote over RAVEN's candidate set alone exceeds the human baseline), plus the same concept-variation instrument run here: ARC-Kaggle2 at 19% overall moves to 29% on *top/bottom* and 8% on *boundary*, so the benchmark number is a mean over a concept mixture and per-concept coverage is unmeasured (Odouard & Mitchell 2022).
- **[[wiki/entities/conceptarc.md]]** — this benchmark's own concepts re-authored as 16 groups of 10 variations each, which converts a task count into per-concept coverage and supplies the measurement this page's difficulty was hiding: the two Kaggle winners, 21% and 19% here and therefore indistinguishable, sit 23 percentage points apart there (Moskvichev et al. 2023).
- **[[wiki/concepts/nameability.md]]** — the per-task difficulty index this page's limitations list says does not exist, obtained from the *describers* rather than from the solvers: mean human description length correlates `−0.50` with per-task accuracy and is collectable from participants who fail (Johnson et al. 2021).
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the human trace data read as a subgoal decomposition: participants' action sequences converge on bottleneck states that are task-relevant *objects*, so the partition that makes this benchmark tractable for humans is the object parse and not the grid.
- **[[wiki/entities/poe-arc-solver.md]]** — the highest open-weights score on this benchmark (71.6% public eval, above the 60.2% average human) at $0.02/task, and the primary source for the 2024 first-place team whose method this page had only second-hand; it also supplies the benchmark's sharpest cost comparison, 850× cheaper than o3 for 11.2 fewer points.
- **[[wiki/concepts/rule-level-evaluation.md]]** — the re-examination of this benchmark's headline o3 result on an easier relative: the same prompt and model family, scored on the stated rule rather than the grid, reaches or beats human accuracy while grounding ~27% of its correct answers in rules the tasks were not authored around, so the score and the abstraction claim come apart (Beger et al. 2025).
- **[[wiki/entities/pgm.md]]** — the opposite design point (generated items, 8 candidates, a training set of hundreds of thousands) and the capability ARC lacks: because PGM's abstract content is an explicit symbolic structure, its test set can withhold a *named* abstraction and report eight separate generalisation numbers, which is the unquantified-`GD` limitation approached from the generator side (Barrett et al. 2018).
- **[[wiki/entities/anli.md]]** — the per-task difficulty audit this page's own retrospective says it lacks (49% of the private set fell to blind brute-force search, unmeasured by any part of the protocol) obtained as a free by-product of collection: an adversarially-authored item carries the annotator's try count and clock, so the analogue of a `GD ≈ 0` task is one solved on try 1 and it is visible in the log (Nie et al. 2020).
- **[[wiki/concepts/certification-instruments.md]]** — the instrument built to `I5`'s specification, and the source of failure modes `F1` (developer-blindness as a depleting stock, ~10,000 scores against 100 private tasks) and `F3` (49% of that set brute-forceable, unaudited by the protocol).
- **[[wiki/concepts/human-baseline.md]]** — the canonical instance of aggregation ambiguity: 99% union-over-workers, 83.8% per-subject on the easy split and 60.2% crowd-mean on the hard split are three statistics on three task pools, and none of them is *the* baseline.
- **[[wiki/entities/frontiermath.md]]** — the private-evaluation strategy taken to its limit and the trade it makes visible: ARC publishes a calibrated training set alongside a withheld evaluation set, which is where `F2`'s distributional leakage enters; FrontierMath publishes five items in total, closing that channel and closing external auditability with it (T222).
- **[[wiki/entities/dreamcoder.md]]** — the library-learning system the benchmark's step 3 asks for, working on eight other domains and not on this one: it grows a DSL by compressing solved programs and its neural proposer beats brute-force enumeration there, while on ARC-AGI-1 guided synthesis and blind search stay level at ≈40% ([[wiki/empirical-tensions.md]] T309).
