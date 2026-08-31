# ConceptARC — 16 concept groups in the ARC domain, and the first concept-based benchmark with its own human baseline

**480 hand-authored ARC-format test inputs organised as 16 *concept groups* — 10 tasks per concept, each task a deliberately different instantiation of the same concept, 3 test inputs per task — built so that the unit of measurement is *coverage of a concept* rather than a task count, and made deliberately easy so that solvers separate instead of all bottoming out.**

> **Provenance.** Moskvichev, Odouard & Mitchell 2023, *The ConceptARC Benchmark: Evaluating Understanding and Generalization in the ARC Domain* (`raw/moskvichev-2023-conceptarc-benchmark.md`, Santa Fe Institute). Tasks and per-test-input results public at `github.com/victorvikram/ConceptARC`. Everything reported here about the ARC-Kaggle winners' internals, MiniARC, LARC, DreamCoder-on-ARC and the object-centric graph solver is **second-hand through this paper** and marked where it matters.

This is [[wiki/entities/raven.md]]'s concept-variation instrument (Odouard & Mitchell 2022, two ARC concepts, 26 hand-made tasks, no human baseline) scaled to a standing benchmark and given the baseline it lacked.

---

## Format

| Property | Value |
|---|---|
| Concept groups | **16**, each a spatial or semantic concept central to one or more tasks in the public [[wiki/entities/arc-agi.md]] training/evaluation sets |
| Tasks per group | **10**, each a different instantiation of the concept (different attributes, layouts, object roles) |
| Test inputs per task | **3** ⇒ 480 test inputs total |
| Grid format | Identical to ARC-AGI-1 — arbitrary dimensions, 10-colour alphabet, output constructed from scratch. Black is reserved for background/unfilled |
| Attempts | 3 per test input, for humans and machines alike; credit if any one matches |
| Difficulty | **Deliberately lowered** relative to ARC — "straightforward instances of core concepts", so humans sit near ceiling and machines spread out |
| Extra items | Per group, "minimal" tasks — the simplest possible instantiation — used as attention checks and excluded from the reported scores |
| Authoring | Entirely by hand. No hidden set at publication (one was planned) |

**The design claim in one line:** solving one task that uses a concept is not evidence of holding the concept; solving 10 variations that share nothing but the concept is. This is Barsalou's *"a concept is a disposition for generating infinite conceptualizations of a category"* turned into a scoring unit — see [[wiki/concepts/shortcut-learning.md]].

---

## The 16 concepts, and every score

Accuracy over the 30 test inputs in each group. Humans: mean over participants per test input, averaged. Machines: fraction of test inputs solved. `K1`/`K2` are the first- and second-place ARC-Kaggle 2020 programs (21% and 19% on ARC's hidden set), GPT-4 is the language-only API model, zero-shot, temperature 0, grids serialised as space-separated integers.

| Concept | Humans | K1 | K2 | GPT-4 |
|---|---|---|---|---|
| Above and Below | 0.90 | 0.70 | 0.33 | 0.23 |
| Center | 0.94 | 0.50 | 0.20 | 0.33 |
| Clean Up | 0.97 | 0.50 | 0.20 | 0.20 |
| Complete Shape | 0.85 | 0.47 | 0.30 | 0.23 |
| Copy | 0.94 | 0.23 | 0.27 | 0.23 |
| Count | 0.88 | 0.60 | 0.40 | 0.13 |
| Extend To Boundary | 0.93 | 0.77 | 0.47 | 0.07 |
| Extract Objects | 0.86 | 0.43 | 0.43 | 0.03 |
| Filled and Not Filled | 0.96 | 0.73 | 0.43 | 0.17 |
| Horizontal and Vertical | 0.91 | 0.43 | 0.10 | 0.27 |
| Inside and Outside | 0.91 | 0.57 | 0.10 | 0.10 |
| Move To Boundary | 0.91 | 0.37 | 0.30 | 0.20 |
| Order | 0.83 | 0.27 | 0.23 | 0.27 |
| Same and Different | 0.88 | 0.53 | 0.17 | 0.17 |
| Top and Bottom 2D | 0.95 | 0.60 | 0.57 | 0.23 |
| Top and Bottom 3D | 0.93 | 0.50 | 0.03 | 0.20 |

Summary statistics the paper draws:

- **Human − K1 = 40 percentage points** mean per-concept gap. Humans >0.90 on 11/16, >0.80 on the other 5. K1 never above 0.80, below 0.60 on 11/16. K2 never reaches 0.60, below 0.50 on 15/16. GPT-4 below 0.30 on 15/16.
- **Human variance across concepts is 0.83–0.97 — a 14-point band.** Machine variance is 0.23–0.77 for K1 alone. The per-concept spread *is* the signal: a single benchmark number averages it away.
- **Concept difficulty does not transfer across solvers.** K1's best concept (*Extend To Boundary*, 0.77) is GPT-4's worst (0.07); K1's worst (*Copy*, 0.23) is mid-range for both others. So the per-concept profile is a property of the (solver, concept) pair, not an intrinsic difficulty ordering — which is why a concept profile carries information a scalar cannot.

**Later scores on this benchmark, for the record.** [[wiki/entities/poe-arc-solver.md]] (Franzen et al. 2025) reports **73.3%** 2-guess accuracy over the 480 tasks, run zero-shot at the hyperparameters tuned on ARC-AGI-1 and with ConceptARC explicitly *excluded* from its training data to avoid conceptual leakage — so it is a clean transfer measurement and not a fit. That closes most of the 40-point human−machine gap this paper opened (humans ~0.91 mean per concept), on the two-guess protocol rather than the paper's per-test-input one, and it is a transduction system with no object parse and no concept vocabulary: the score says nothing about *coverage* of the 16 concepts, which is the quantity this benchmark was built to report. Per-concept numbers are not given, so the discriminability the design buys is unused.

**The 2025 frontier re-run, and the first evaluation to use the concept labels as a *scoring target*** (Beger et al. 2025, `raw/beger-2025-conceptarc-abstract-reasoning-modalities.md` — see [[wiki/concepts/rule-level-evaluation.md]]). All 480 test inputs, `pass@1`, both modalities, with the solver required to state its rule and each rule hand-classified against the concept group's intended abstraction.

| | Textual accuracy | Visual accuracy | Intended rule stated (any grid) | Correct-unintended share of correct rules |
|---|---|---|---|---|
| o3, medium + tools | **75.6** | 29.2 | 57.3% t / 40.0% v | **29%** |
| o4-mini, medium + tools | **77.7** | 25.0 | not classified | — |
| Gemini 2.5 Pro, medium + tools | 60.4 | 5.8 | 46.1% t / 23.6% v | 22% |
| Claude Sonnet 4, medium + tools | 55.0 | 6.9 | 57.5% t / 14.4% v | 15% |
| GPT-4o / Llama 4 Scout / Qwen 2.5 VL 72B | 14.6 / 6.7 / 9.2 | **0.0** for all three | — | — |
| **Humans** (same 480 items, images) | | **73** | 90.3% of classifiable | **2.7%** |

Four things this adds to the page. **(i)** The 40-point gap this benchmark opened is closed *on accuracy* in the textual modality — and reopened on the quantity the benchmark exists to measure, since a solver at or above human accuracy reaches ~27% of its correct answers by a rule the concept group is not about, against ~8% for humans. **(ii)** The human baseline now has a second, much lower number attached: **73% `pass@1`** on the same items, from an unpublished re-analysis of the 2023 study's own data, against the ~91% mean-per-concept 3-attempt figure this page reports — logged as [[wiki/empirical-tensions.md]] T214. **(iii)** Coverage, the per-concept quantity this design was built for, finally measured: humans cover **476/480** tasks with at least one intended rule; o3 covers 412 (85.8%) in text and 281 (58.5%) in vision; pooling all three frontier models adds only +9 points over the best of them, so their intended-rule failures are **correlated**. **(iv)** The per-concept profile is used as intended and returns two extremes — *Count* (small outputs) where o3 beats humans by 32.3 points in text, and *Clean Up* (reproduce the whole grid minus some cells) where it loses by 46.3 in text and 65.7 in vision. Output-grid **construction cost** is therefore a confound in every score on this page, and nothing separates it from rule discovery.

One corpus defect the re-run found and this page should carry: **task 5 of the *Order* group contains a training demonstration with a misplaced grid cell.** Removing it changes nothing above 0.5 points.

---

## The three things this design buys that a task count does not

**1. Coverage per concept, i.e. the first standing instrument for gap G31's per-*concept* half.** [[wiki/entities/arc-agi.md]]'s unquantified `GD` limitation is usually read as per-task difficulty. This measures the orthogonal quantity — given that a solver answers *some* task using concept `c`, what fraction of `c`'s instantiation space does it cover — and reports it for 16 concepts at once. Ten variations make a shortcut that clears the whole group implausible even where individual tasks admit one.

**2. Discriminability, recovered by making the benchmark easier.** K1 and K2 score 21% and 19% on ARC's hidden set — indistinguishable. On ConceptARC they are **23 percentage points apart** in mean per-concept accuracy. A benchmark hard enough that everything sits near the floor compresses the rank order it exists to produce; lowering difficulty until the ceiling is human-only restores it. Stated as a design principle: *the informative regime is the one where humans are near ceiling and machines are not*, which is the opposite of the frontier-benchmark instinct that drove ARC-AGI-2 and -3 upward in difficulty.

**3. A first-party human baseline on the variations.** 415 participants (204 Mechanical Turk, 211 Prolific), ~17 test inputs each in ~45-minute sessions, 8–14 participants per test input, 67 of 482 excluded by two pre-registered criteria (failing ≥2 minimal tasks; empty or nonsensical solution descriptions). Each participant saw only *one* of a task's three test inputs, so no within-task practice effect. This closes the caveat the 2022 concept-variation study carried in full — its variations were "believed easy for humans" with no baseline collected.

Note what the exclusion criteria imply: **it was faster for a participant to fake failure than to solve**, so an unfiltered crowd baseline on a constructed-answer benchmark is biased downward by an unknown amount. Any human number on this task family without an attention-check protocol should be read as a lower bound.

---

## Error structure — the evidence channel binary scoring discards

| Solver | Error profile |
|---|---|
| **Humans** | Three named classes, all interpretable: careless slips (off-by-one output dimensions), giving up (copy the input, or emit a blank grid), and **near-misses** — the concept is visibly grasped and mis-applied (copies the object into the target rectangle correctly but also deletes the original; extends the line to the boundary correctly but thickens the source object into a rectangle) |
| **K1 / K2** | "Harder to categorise" — the outputs do not indicate that the notion of *copying* or *extending to a boundary* was represented at all. Expected, since both construct pipelines of pre-designed grid transformations and there is no object in them that could be a partial grasp of a concept |
| **GPT-4** | Uncategorisable, but **always correctly formatted** — every failure is a wrong answer, never a malformed one, so the score is not a parsing artefact |

**Why this matters architecturally.** A near-miss is a *graded* signal about which part of a hypothesis is right, available from the output alone with no extra instrumentation, and ARC-family exact-match scoring deletes it. It is also the only evidence in the ARC literature that a solver's internal object is a concept rather than a program: humans fail in ways that presuppose the concept, search-based solvers fail in ways that presuppose nothing. **(brainstorm)** Any architecture whose error distribution is uninterpretable in this sense has, by this test, no concept-level representation to be partially correct about — which makes "are the model's errors near-misses under the intended concept?" a cheap, label-free probe for [[wiki/concepts/representation-probing.md]] to run on any generative benchmark.

---

## The authoring bind

The authors state directly why the corpus is hand-made and small: *"we do not believe that interesting, diverse task variations on a particular concept could be constructed automatically, unless we were able to create an automated system that understands the concept in a general way — and the challenge of developing such a system is what inspired the benchmark in the first place."*

This is the sharpest statement in the wiki of a circularity that constrains gap G17. The instrument that would certify concept possession requires, to be *generated at scale*, the very capacity it is meant to certify. Consequences:

- Benchmark size is bounded by human authoring throughput (480 test inputs, versus RAVEN's 70,000 from a grammar), so per-concept sample sizes stay small and sampling noise is structural.
- The concept inventory and every variation are the authors' — the developer-authorship problem [[wiki/entities/arc-agi.md]] carries is inherited whole, and here it is *concentrated*, since 30 test inputs hang off one author's reading of "Sameness".
- **(brainstorm)** The escape is the one Chollet also declines: a teacher–student construction where variations are proposed by a second system and admitted only if they pass a human-solvability gate. [[wiki/entities/arc-agi-3.md]]'s authoring pipeline does exactly this for *environments* (a description-length similarity gate plus a ≥2-of-10 human-solvability admission test); nobody has run it for *concept variations*, where the admission criterion would have to be "same concept, different instantiation" — which is a similarity judgement in concept space and has no computable form in the wiki.

---

## Acknowledged defects

| Defect | Statement | Consequence |
|---|---|---|
| **Ambiguous tasks** | A small number of test inputs have more than one reasonable solution | Exact-match scoring charges a solver for a defensible answer; unquantified |
| **Shortcut tasks** | A small number are solvable by copying the input — a default output for both Kaggle programs and an easy pattern for GPT-4 | The group-level design is the mitigation: a shortcut clears a task, not 10 variations |
| **Small N** | 8–14 participants per test input (one with 7), 30 test inputs per concept | Per-concept human accuracies carry several points of noise; the 40-point gap does not |
| **Crowd sample** | 415 US/UK participants, English-fluency-filtered, self-selected on paid platforms | Not a population estimate; the paper says so |
| **No hidden set** | Public at release | Contaminated for any model trained after 2023 — the same depleting-resource problem [[wiki/entities/arc-agi.md]] logs for its private set, but starting from zero |

---

## Related results the paper puts on the record

These are second-hand but load-bearing for the wiki and appear nowhere else in it.

| Result | Numbers | Why it matters here |
|---|---|---|
| **LARC** (Acquaviva et al. 2022) — 354 ARC tasks paired with human-written natural-language instructions sufficient to solve the task *without the demonstrations* | Instructions let a **second human** solve the task **~88%** of the time. The best program-synthesis system trained/evaluated on those same instructions solves **~12%** | The concept is fully transmissible between humans through language, and the transmission channel is worth ~88% — while the machine cannot use the *same* message. This localises the deficit: not in the information content of the concept description, but in the receiver. Directly [[wiki/concepts/language-of-thought.md]] and G21's "if language supplies the common format" horn, with a 76-point price on it |
| **Object-centric graph search** (Xu et al. 2022) | Grids → graphs (nodes = heuristically grouped objects, edges = relations); search over graph operations instead of grid operations solves **~⅓ of 160** object-centric ARC tasks | The representation change is worth a comparable score to grid-DSL search on a filtered subset, with the object parse still heuristic and authored — G73's representation supplied, one level up |
| **DreamCoder on ARC** (Banburski et al. 2020; Alford et al. 2022) | Library learning over hand-defined grid primitives, demonstrated on a small symmetry-focused task set | The only ARC-side instance of the learned-prior proposal disputed at [[wiki/empirical-tensions.md]] T155; scale reported as small |
| **MiniARC** (Kim et al. 2022) | 150 tasks fixed at 5×5, six broad categories (movement, color, object, number, geometry, common sense) | The complementary axis: MiniARC bounds the *grid*, ConceptARC bounds the *concept*. Both are attempts to make ARC's difficulty legible rather than merely high |
| **Human ARC study** (Johnson et al. 2021) — **now held first-hand**, `raw/johnson-2021-human-program-induction-arc.md` | 95 participants × 10 of 40 public *training* tasks, 3 attempts; **83.8%** mean per-task accuracy (SD 16.7); K1 on the same 40 tasks **57.5%**; human/K1 per-task difficulty Spearman `ρ = 0.35`; human errors are near-misses that respect the object priors, K1's violate them (elongated shapes, wrap-around) | The near-miss finding on the *original* tasks, two years earlier and independent of ConceptARC's authoring — and the per-solver difficulty finding this page reports per concept (K1's best concept is GPT-4's worst) appearing per *task*: `ρ = 0.35` is the same claim at the task level |

---

## Comparison

| | ARC-AGI-1 | ARC-AGI-2 | RAVEN | 2022 concept variations | **ConceptARC** |
|---|---|---|---|---|---|
| Unit of measurement | Task | Task, with an empirical difficulty index | Item | Concept (2) | **Concept (16)** |
| Items | 1,000 tasks | 1,120 tasks | 70,000 items | 26 tasks | 160 tasks / 480 test inputs |
| Generated by | Hand | Hand | Master grammar | Hand | Hand |
| Difficulty target | Hard for machines | Harder for machines, calibrated on humans | i.i.d. with training | Believed easy | **Easy for humans, by design** |
| Human baseline | 97–99%, union over testers | 407 participants, per-task index | 84% mean | **none** | **415 participants, per-test-input** |
| Answer | Constructed | Constructed | Choose from 8 | Constructed | Constructed |
| What a high score licenses | Broad generalization over the sampled tasks | The same, with contamination and brute-force channels closed | ≤ nothing (context-blind >90%) | Use of 1 concept across instantiations | **Coverage of 16 named concepts** |

---

## Connections

- **[[wiki/entities/arc-agi.md]]** — the parent format and the source of the 16 concepts, which are drawn from tasks already in its public sets; ConceptARC re-authors them as groups so that the score becomes per-concept coverage rather than a task count, and it supplies the discriminability finding that ARC's difficulty was masking a 23-point difference between its own two Kaggle winners.
- **[[wiki/entities/raven.md]]** — the same instrument's first run, on two ARC concepts and two RAVEN relations, whose stated weaknesses (hand-authored, tiny, *no human baseline*) are exactly what this page closes: 16 concepts, 10 variations each, 415 participants.
- **[[wiki/concepts/shortcut-learning.md]]** — supplies that page's concept-based-evaluation instrument at benchmark scale, and turns its "shortcuts survive because a concept is tested once" objection into a design rule: 10 instantiations per concept make a per-task shortcut worthless at the group level.
- **[[wiki/entities/arc-agi-2.md]]** — the opposite response to the same 2023 situation: ARC-AGI-2 raises difficulty and calibrates it against humans per task, ConceptARC lowers difficulty and calibrates coverage per concept, and both report first-party crowd studies of ~400 participants — so the pair is the wiki's cleanest statement that a benchmark chooses between frontier headroom and diagnostic resolution.
- **[[wiki/entities/arc-agi-3.md]]** — holds the authoring machinery ConceptARC says cannot exist for concept variations (a computable similarity gate plus a human-solvability admission test), applied to environments rather than concepts; the gap between the two is a similarity judgement in concept space.
- **[[wiki/concepts/core-knowledge.md]]** — the 16 concept groups are the most concrete inventory in the wiki of what the objectness, number and geometry priors look like *as separable, individually scorable competences*, and the measurement is that a solver can hold one and not its neighbour.
- **[[wiki/concepts/program-induction.md]]** — the negative result for the whole family: two DSL-search programs and one LLM, none of which represents a concept as an object that can be partially right, fail 40 points below humans on tasks designed to be easy, with uninterpretable errors.
- **[[wiki/concepts/language-of-thought.md]]** — via LARC: a human's natural-language rendering of an ARC concept is sufficient for another human ~88% of the time and for the best program-synthesis receiver ~12%, which prices the format claim rather than merely asserting it.
- **[[wiki/concepts/representation-probing.md]]** — proposes a label-free probe this page's error analysis makes concrete: score whether a system's *failures* presuppose the intended concept (near-misses) rather than whether its successes match, which humans pass and every solver tested here fails.
- **[[wiki/entities/arc-vsa-solver.md]]** — the wiki's only architecture evaluated on this benchmark (20.5 on a 176-test-input subset, comparable to GPT-4's ~0.19 mean here), and it attributes its own per-concept failures to two separable causes — an object parse its hypothesis set cannot express, and reasoning its DSL cannot express — which is the per-concept profile being used exactly as this benchmark intends.
- **[[wiki/concepts/nameability.md]]** — the LARC numbers this page puts on record (~88% human receiver vs ~12% machine receiver of the same written instruction) are that page's transmission measurement, and its per-task difficulty index would be scorable *per concept* on this benchmark, which nobody has run.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the prior term `P` is held fixed as in ARC, but the *experience* term is what this benchmark manipulates: 10 instantiations of one concept is the minimum sample at which a claim about `GD` for that concept can be made at all.
- **[[wiki/entities/poe-arc-solver.md]]** — the highest machine score on this benchmark in the wiki (73.3% 2-guess, zero-shot at ARC-AGI-1 hyperparameters, with ConceptARC deliberately kept out of training), which closes most of the 40-point gap this page opened while reporting only a scalar — the per-concept profile the design exists to produce is not measured.
- **[[wiki/concepts/rule-level-evaluation.md]]** — the instrument this benchmark's concept labels make possible and that nobody had run on it: classify the solver's *stated rule* against the group's intended abstraction, which converts "coverage of 16 named concepts" from a design intention into a measured quantity (humans 476/480, o3 412/480 in text, 281/480 in vision) and shows that the frontier's textual accuracy overstates its abstraction while its visual accuracy understates it.
- **[[wiki/entities/pgm.md]]** — the same idea reached from the generated side: a held-out-concept split specified formally over `[relation, object, attribute]` triples instead of authored by hand, which buys eight declared regimes and a measured answer-set floor at the cost of the human baseline and the naturalistic concept inventory this page has (Barrett et al. 2018).
- **[[wiki/entities/anli.md]]** — this page's discriminability argument running in reverse: ConceptARC deliberately lowers difficulty until humans are at ceiling so solvers spread out, while adversarial authoring optimises directly for items the best model fails, and the measured consequence is that by round 2 a context-blind baseline is within 2.6 points of the full model — the ordering-destroying regime, reached from the hard end.
- **[[wiki/entities/agent-benchmark.md]]** — the same measurement philosophy in the intuitive-psychology domain: many instantiations per concept, scored per concept against a per-concept human profile, with the aggregate treated as the least informative summary — and a worked case of why, a model at the single-human aggregate whose per-type correlation with humans is 0.06.
- **[[wiki/entities/math-dataset.md]]** — the human-baseline contrast that bounds a common claim: MATH's "hard for humans too" spread (40%–90%) rests on `n = 1` per level over 20 items, against this page's 415 participants — so the two benchmarks' human numbers are not the same kind of measurement, and only one of them can carry a gap argument.
- **[[wiki/entities/gsm8k.md]]** — the same design move in the arithmetic domain: GSM-Symbolic holds the reasoning graph fixed and resamples the instantiation 50 times, reporting a distribution rather than a point — and adds the contamination read this page cannot make, since the published seed's position inside its own distribution is measurable without corpus access.
- **[[wiki/entities/gpqa.md]]** — ships for free the asset this page's near-miss error typology had to be hand-annotated: every distractor is written by the question's author as a specific one-hop-wrong trajectory with a stated reason, so *which* distractor a model picks partitions its errors by the step it dropped, at zero annotation cost.
- **[[wiki/concepts/certification-instruments.md]]** — instrument `I10` scaled and given the human baseline that closed its standing weakness, and the source of failure mode `F7`: a benchmark hard enough to floor every solver destroys the ordering it exists to produce.
- **[[wiki/concepts/human-baseline.md]]** — the wiki's worked example — same 415 participants, same 480 items, 73% at `pass@1` against ~91% at three attempts — which is why the attempt budget is the parameter the convention pins first.
- **[[wiki/entities/math-perturb.md]]** — the missing arm of this benchmark's own design: ConceptARC varies the instantiation and holds the concept, MATH-Perturb runs both directions on the same seed, and the grid domain has no counterpart that holds the instantiation and edits the concept out from under a solved task.
- **[[wiki/entities/baba-is-ai.md]]** — the same small-grid visual family with the latent transformation moved into the grid as a pushable object, so the question changes from *which rule generated this* to *which rule should I install*.
- **[[wiki/entities/cfq.md]]** — the opposite answer to the same question: where this page authors the out-of-distribution axis by hand as concept groups, CFQ *computes* it as a divergence over derivation subgraphs and sweeps it continuously — available only because its items are generated, which is the price this page's hand-authoring buys out of.
