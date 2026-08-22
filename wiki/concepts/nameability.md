# Nameability

**How easily a task's solution can be put into words predicts how hard the task is to solve — measured, on ARC, at `r = −0.50` between mean human description length and mean human accuracy. If the correlation is causal in the direction its authors propose, natural language is a *scaffold for generating hypotheses*, not a report of a hypothesis arrived at by other means.**

> **Provenance.** Johnson, Vong, Lake & Gureckis 2021, *Fast and flexible: Human program induction in abstract reasoning tasks* (`raw/johnson-2021-human-program-induction-arc.md`, CogSci) — the first behavioural study of humans on [[wiki/entities/arc-agi.md]], and the source of every first-hand number below. It imports the construct from Lupyan 2012 and Lupyan & Zettersten 2020 (not in the wiki), whose claim is that difficulty rises as nameability falls and that language biases perceptual processing toward certain concepts. Two further data points are second-hand: **LARC** (Acquaviva et al. 2022, via [[wiki/entities/conceptarc.md]]) and **LAPS** (Wong et al. 2022, via [[wiki/concepts/language-of-thought.md]]).

---

## The measurements

All from 95 Amazon Mechanical Turk participants × 10 of 40 ARC public-training tasks, ~23.5 participants per task, three attempts per task, with a free-form written description of the transformation collected after the first submission and again after the last.

| Quantity | Definition | Value |
|---|---|---|
| **Description length → success** | Logistic mixed-effects model over (participant, task) pairs; fixed effect = the task's mean description length, random intercepts for participant and task | `b = −0.17`, 95% CI `[−0.315, −0.020]`, `p = .03` |
| **Description length → task accuracy** | Correlation across the 40 tasks | `r = −0.50` |
| **Mean description length** | Words per description, correct and incorrect pooled | 20 (SD 5) |
| **Naming divergence** | `# unique words / # total words` within a task, over correct solvers' final descriptions, stop-words removed | **0.41** observed vs **0.68** shuffled (SD 0.003 over 1,000 permutations), `p < .001` |

**What naming divergence buys.** It is a *consistency* measure and it is the one that makes the difficulty result more than a length artefact: different participants describe the same task with substantially overlapping vocabulary, so the descriptions are tracking a shared object rather than each solver's idiosyncratic route. A concept that many people name the same way is a concept, and the wiki has no other operational test of that.

---

## The vocabulary humans actually use

Nine content classes, hand-assigned, over the descriptions of correctly solved tasks.

| Class | Top unigrams (counts) |
|---|---|
| Color | blue (396), color (353), red (244), colors (158) |
| Object | squares (388), square (221), blocks (124) |
| Geometric | line (136), lines (77), corner (52), diagonal (51) |
| Relation | same (200), match (36), part (22), between (22) |
| Number | one (139), number (114), 3 (59), two (54) |
| Location | right (122), left (98), bottom (82), where (80) |
| Transform | make (105), fill (87), extend (51), copy (49) |
| Size | size (58), 2x2 (33), 3x3 (33), 4x4 (21) |
| Abstract | tetris (5), paint (4), vessel (2), flower (2) |

Two distributional facts, and they point in opposite directions:

- **By total word count, colour dominates** — it is relevant to nearly every task, so it is the class people *lean on* most.
- **By unique word count, geometric and transform are the largest** — so they are the classes over which people command the widest *range* of distinct concepts. This is the paper's evidence against a small fixed primitive set: the breadth is in exactly the two classes an ARC DSL would have to enumerate.

**The abstract class is tiny and load-bearing.** Some participants named the pixel beside a box a *"tail"*; others reached for *tetris*, *vessel*, *flower*. These are mappings of general-purpose conceptual knowledge onto coloured cells on a grid, invented on the spot, and nothing in the four declared Core Knowledge priors ([[wiki/concepts/core-knowledge.md]]) contains them. The hypothesis space humans draw from is therefore not the benchmark's stated prior set — it is whatever conceptual background is retrievable and applicable, which is a much larger and unbounded object.

---

## What it decides for a builder

**1. A candidate for gap G26 — a prior over programs that is not description length of the *program*.** ARC's intended solver concedes that ranking by simplicity alone is insufficient and asks for a *learned* prior ([[wiki/entities/arc-agi.md]] step 3). Nameability says what that prior could be a function of: the length of the shortest *natural-language* rendering, which is a length in a vocabulary that already carries the world's conceptual structure rather than in a hand-built DSL. LAPS is the one built instance in the wiki — a joint prior over programs and their language translations — and it was not built for this reason.

**2. The cheapest proxy the wiki has for `GD` (gap G31).** Chollet's own proposed workaround for uncomputable generalization difficulty is *human success rate per task*. Description length is strictly cheaper: it needs only that a participant attempt the task and write a sentence, not that they succeed, and it is available for tasks nobody solves. It correlates at `−0.50` with the quantity it stands in for. **(brainstorm)** The version worth testing is *machine*-side: ask a language model to describe a task's transformation, measure the description length, and use it as a per-task difficulty index that requires no solver and no labels — the same move [[wiki/concepts/prediction-compression-equivalence.md]] makes with bits-per-position, one representational level up.

**3. The price of the language channel is measured, and the deficit is in the receiver.** Via LARC: a human's written instruction for an ARC task, given *without* the demonstration pairs, lets a second human solve the task ~88% of the time and the best program-synthesis system ~12%. So natural language demonstrably carries the concept; nothing in a synthesiser can read it. Nameability is therefore not an argument that language is a weak medium — it is an argument that the wiki's solvers are weak listeners.

**4. It cuts against the small-DSL commitment directly.** If hypothesis generation ran over a compact primitive set, description length would track *composition depth* and little else. That the largest unique-word classes are geometric and transform, and that the abstract class exists at all, is the paper's stated challenge to language-of-thought accounts with a pre-specified grammar ([[wiki/concepts/language-of-thought.md]]).

---

## Open problems

- **Direction of causation is untested.** Description length correlating with failure is equally consistent with *hard tasks are hard to describe* (nameability is an effect) and with *undescribable tasks are hard to think* (nameability is a cause). The paper asserts the second reading, from Lupyan; nothing here discriminates. The discriminating experiment — supply the description and measure the solve rate — is LARC, and LARC's ~88% is evidence for the causal reading that the wiki should carry as suggestive rather than settled.
- **Naming divergence is lexical, not semantic.** Two descriptions of the same rule in disjoint synonyms score as maximally divergent. A meaning-space version (embed and measure dispersion) would be trivial to run and nobody has.
- **Nothing conditions an ARC program prior on a description.** LAPS exists in a different domain; no ingested ARC solver reads or emits language about the rule it is applying, so the mechanism this page proposes has no instance on the benchmark that motivated it.
- **20 words is not an instruction.** The descriptions collected here are post-hoc summaries written for a bonus; LARC's are elicited to be sufficient. Whether the difficulty correlation survives when the description is *required to be executable by a reader* is unmeasured.

---

## Connections

- **[[wiki/entities/arc-agi.md]]** — the benchmark the construct is measured on, and where the correlation lands: this page supplies a per-task difficulty index for a benchmark whose own limitations list concedes that generalization difficulty is quantified for no task in the set.
- **[[wiki/concepts/language-of-thought.md]]** — the account this measurement is aimed at: if hypothesis generation is scaffolded by natural language rather than by a fixed symbolic primitive set, the "language" in language of thought is the spoken one, which is Spelke's horn of the installed/acquired dispute arriving with a number attached.
- **[[wiki/concepts/program-induction.md]]** — supplies cost 3 (the prior is doing unadvertised work) with a candidate that is neither program length nor cross-demonstration reuse: length in a natural-language vocabulary, which is the only ranking on the wiki whose units come from outside the solver's own DSL.
- **[[wiki/entities/conceptarc.md]]** — the source of the LARC numbers that turn this page's correlation into a transmission measurement (~88% human receiver, ~12% machine receiver), and the benchmark whose per-concept design would let nameability be scored per concept rather than per task.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — gap G31's cheapest empirical proxy: `GD` is uncomputable and its proposed stand-in is human success rate, where description length is obtainable from participants who fail and correlates at `−0.50`.
- **[[wiki/concepts/core-knowledge.md]]** — the negative result for the prior set as a *hypothesis space*: the words humans reach for include "tail", "tetris" and "vessel", none of which is derivable from objectness, number, geometry or goal-directedness, so the priors bound what the tasks require and not what solvers use.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the same move at the level of bits rather than words: a cheap, label-free, solver-independent index of how much structure a task contains, differing in that this one is measured on a *describer* and that one on a *predictor*.
- **[[wiki/concepts/shortcut-learning.md]]** — the reason a consistency measure matters: naming divergence at 0.41 against a 0.68 shuffled baseline is evidence that participants converged on one concept rather than on many task-specific tricks, which is the thing a single accuracy number cannot distinguish.
- **[[wiki/concepts/rule-level-evaluation.md]]** — the same channel opened on the machine side: frontier models are made to write the ARC rule they used, and the descriptions are then classified rather than measured for length, which answers a question this page cannot (was it *the* concept?) and forgoes the one this page answers (how hard was it?) — neither has a semantic scoring procedure, and both are hand-coded.
- **[[wiki/concepts/emergent-modularity.md]]** — sharpens what "shared" costs in a shared arbitrary symbol: the source grounds shared-ness in the consumer inferring the producer's communicative intent, which puts a theory-of-mind term *inside* a name's semantics rather than downstream of it, and separates the honeybee dance (displaced but iconic) from Kanzi's lexigrams (arbitrary and displaced but scaffolded and absent in the wild).
- **[[wiki/concepts/shared-intentionality.md]]** — the developmental source of the variable this page measures: one referent admits many simultaneously-available descriptions (`dog`/`animal`/`pet`/`pest`), and from ~2 years the speaker selects among them by the *addressee's* estimated state — so a description's length is a property of a communicative choice, not of the referent, and a per-task nameability score averages over that choice.
