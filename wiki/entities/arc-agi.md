# ARC — Abstraction and Reasoning Corpus

**A benchmark of ~1,000 hand-authored grid-transformation tasks, each specified by ~3 input/output example pairs, designed so that every evaluation task is novel to the *developer* as well as the system, and so that the only knowledge required is an explicitly enumerated set of Core Knowledge priors.**

> **Provenance.** Chollet 2019, *On the Measure of Intelligence* (`raw/chollet-2019-measure-of-intelligence.md`), part III. Numbers and design rationale as of the 2019 release; ARC has been revised since (`ARC-AGI-1/2/3`, queued in `raw/`) and this page describes the original.

The wiki's first benchmark page, and the first artefact built explicitly to satisfy [[wiki/concepts/skill-acquisition-efficiency.md]]'s requirement list.

---

## Format

| Property | Value |
|---|---|
| Tasks | 400 training · 400 public evaluation · 200 private evaluation; all unique, disjoint |
| Per task | ~3.3 demonstration pairs, usually 1 test input |
| Grid | Symbols from a 10-value alphabet ("colours"), size 1×1 to 30×30, median 9×10 |
| Output | Constructed from scratch — the solver chooses the output grid's height, width and every cell |
| Scoring | Exact match, binary, 3 attempts per test input; feedback is correct/incorrect only |
| Training set role | Development/validation for the builder, or familiarization with the priors — *not* required; the evaluation set assumes nothing learned from it |

The from-scratch output construction is load-bearing: there is no answer set to discriminate over, so the solver must *produce* the transformation's result rather than recognize it. A multiple-choice version would admit elimination shortcuts.

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

## Results and status (2019)

| Result | Note |
|---|---|
| Fully solvable by humans | Every task solved by at least one of three high-IQ subjects working independently, without practice or verbal instruction. Most solved on first try |
| Not approachable by any machine learning technique, including deep learning | Chollet's claim at publication — the evaluation tasks do not appear in training, and few-shot broad generalization is what deep learning does not do |
| No large-sample human data | Validity not established; the psychometric standard ARC invokes is not yet met by ARC |

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
- **Scale and diversity may be too small** — 1,000 tasks with conceptual overlap leaves room for a shortcut that clears the set without abstraction. Mitigation is a public competition on the private set: if a shortcut exists, a competition surfaces it fast.
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
