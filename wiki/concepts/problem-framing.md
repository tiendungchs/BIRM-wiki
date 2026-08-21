# Problem Framing

**Solving a problem decomposes into two stages: *framing* — constructing a representation in which a solution can be looked for (which aspects are relevant, what the variables are, what relates them) — and *optimisation within that representation*. Every benchmark and every architecture in the wiki supplies the first stage and scores the second.**

> **Provenance.** Pfister & Jud 2025, *Understanding and Benchmarking Artificial Intelligence: OpenAI's o3 Is Not AGI* (`raw/pfister-2025-o3-is-not-agi.md`), Lab42 / Munich Center for Mathematical Philosophy. A conceptual analysis with no experiments; the numbers it cites are second-hand from ARC Prize. The authors use *exploration* for the first stage and *exploitation* for the second — a naming collision with the reinforcement-learning pair, and this page keeps their distinction under the neutral label **framing** to avoid it.

---

## The split

| Stage | What it produces | Failure mode | Wiki status |
|---|---|---|---|
| **Framing** | A representation of the task: the set of aspects deemed relevant, plus a model of the relations among them (e.g. *treat route choice as a cost-minimisation over a weighted graph*) | The wrong variables — no amount of optimisation recovers | **Supplied by the designer everywhere** (gap G73) |
| **Optimisation** | The best solution *within* that representation | Compute-bound, well-posed, formally an optimisation problem | Solved-or-searchable; this is what every score measures |

The claim that gives it force: **framing is the harder half, and it is the half that is designed out of every tractable benchmark.** A representation is what turns an ill-posed situation into an optimisation problem; once one exists, the residual difficulty is search, and search is purchasable with compute.

**Restated in the wiki's framing** ([[wiki/concepts/latent-graph-discovery.md]]): optimisation is navigation over a graph whose nodes, edges and vocabulary are already fixed; framing is deciding *what the nodes are* — which is hardness source 2 (unknown vocabulary) plus the prior question of what gets to be a variable at all.

---

## The analysis of ARC-AGI, and why it generalises

Pfister & Jud's argument that [[wiki/entities/arc-agi.md]] scores only the second stage rests on two structural properties of the task format:

| Property | Consequence |
|---|---|
| **The representation is fixed by the format.** Every task is: find the simplest transformation, expressed as a combination drawn from a finite, small, enumerable set of Core Knowledge operations, mapping input grid to output grid | The framing is constant across all 1,000 tasks. Only the *selection and ordering* of operations varies — so the solver never constructs a representation, it searches one it was handed |
| **Candidate solutions are checkable before submission.** Each task has exactly one correct output per input, and a candidate rule is correct exactly when it reproduces every demonstration pair | Unlimited free trialling. A wrong candidate costs compute and nothing else, so a low-quality proposer plus a cheap tester is a complete method |

**A qualification the wiki should carry against the first row, from behavioural data.** The claim that the framing is *constant* across all 1,000 tasks is true of the transformation-search schema and false of one element inside it: **what counts as an object is not fixed by the grid format**. Occlusion, and whether a set of cells is one object or two, leave the parse genuinely ambiguous, and human solvers re-decide it per task — their action traces converge on bottleneck states that are the task's own objects, built one at a time (Johnson et al. 2021, `raw/johnson-2021-human-program-induction-arc.md`; [[wiki/entities/arc-agi.md]]). So a residue of framing survives inside the format, it is the residue [[wiki/entities/arc-vsa-solver.md]] pays for by *searching over six candidate parses*, and it is recorded separately as gap **G75**. This narrows Pfister & Jud's claim rather than refuting it: the framing that varies is one variable of the representation, not the representation.

Neither property survives outside the format. Pressing the wrong button on a coffee machine spoils the drink; driving a car incorrectly crashes it. Their concession is the one that matters architecturally: **simulation restores free trialling only for domains already known well enough to be simulated** — i.e. only where the framing already exists as a skill, which is exactly the case the benchmark was built to exclude. Where a task is too complex to simulate, too expensive, or must be acted on faster than it can be simulated, the free-retry assumption fails outright.

**Consequence for the wiki's own instruments.** The two properties are precisely the preconditions of [[wiki/concepts/refinement-loop.md]] ("a candidate, a mutation operator, and a feedback signal computed from the task's own demonstration pairs") and of [[wiki/concepts/external-verification.md]]'s ladder. So the mechanism the wiki records as *the* thing that worked on ARC in 2025 is domain-restricted by construction, and the restriction is not a property of the method but of the task supply.

---

## The intelligence definition it comes from

Pfister & Jud build on Chollet's skill/intelligence split ([[wiki/concepts/skill-acquisition-efficiency.md]]) and state a deliberately non-quantified version:

> **An agent is the more intelligent, the more efficiently it can achieve the more diverse goals in the more diverse worlds with the less knowledge.**

with *knowledge* read pragmatically — everything the agent holds, true or not, including its skills — and:

- **Skill** = the ability to achieve a specific goal under specific *known* conditions.
- **Intelligence** = the ability to create new skills for conditions not known in advance.
- **Skills and intelligence are substitutes** wherever conditions are known. Intelligence is needed only to the extent conditions are unknown, or skills for known conditions cannot be supplied for cost reasons — which is why a benchmark that fixes the framing can always be beaten by a skill.

Four axes are named — goal diversity, world diversity, efficiency, knowledge — and the source explicitly declines to specify how any of them is quantified or weighted, which is where it is weaker than the `GD`/`P`/`E` formalism it extends. What it adds is the **world** axis: Chollet's `I` averages over a scope of *tasks*, this averages over environments in which the tasks sit, and the two come apart exactly when the framing is task-invariant (ARC: 1,000 tasks, one world).

**The No Free Lunch reconciliation, and the dilemma it exposes.** NFL says no algorithm beats another averaged over all optimisation problems, so a general intelligence looks impossible. The escape is standard — intelligence targets only the subset of worlds that *have regularities*, and beating the average on a subset requires the subset's characteristics to be built into the algorithm. The dilemma is the useful part, and it is a design constraint rather than a philosophical one:

> The more assumptions about regularity are built in, the smaller the covered subset and the more efficient the algorithm — and the higher the chance the assumptions do not hold in the world it is deployed to, at which point performance drops.

This is the priors term `P` re-read as a **risk** rather than as a debt: installed structure is not merely something to be discounted when scoring, it is a bet that can be wrong. It is gap G23's entry-test problem stated as a scaling law — stacking priors is not monotonically good, so a prior needs both an entry condition and a way of being withdrawn.

---

## What a benchmark that scored framing would look like

The source's proposal, kept here because it is the only concrete design in the wiki aimed at the framing stage:

- `N ≈ 10` **arbitrary simulated worlds**, nothing known in advance, sharing only the property of *having some regularities*. Non-human physics, other dimensionalities, altered causality are all admissible; the agent gets any embodiment or none.
- **A goal per world**, of any kind, with only the requirement that degree of fulfilment be measurable (build the habitat; synthesise the element; win against human players; predict future states with no ability to act).
- **No world is ever reused for the same approach**, so a score cannot be carried between runs as knowledge.
- Score = efficiency of goal fulfilment, aggregated over worlds. Training time and *compactness* of the approach are proposed as additional charged terms.
- **Human core knowledge must not be installed** — in an arbitrary world a wrong prior is worse than no prior, so any world-specific commitment (objectness, contact causality, classical physics) is a liability. This inverts [[wiki/concepts/core-knowledge.md]]'s role from *the thing that equalises the comparison* to *the thing that must be withheld*, and is logged as [[wiki/empirical-tensions.md]] T211.

**Admitted residual.** The generated worlds still share the properties of being formalisable, executable within current compute, and *imagined by humans* — so a skill tailored to that conformity remains theoretically available, and the proposal's answer is charged training time plus a compactness requirement, which is gap G35's parameter charge re-appearing as a benchmark rule.

**(brainstorm)** The design is not implementable as stated for one reason the source does not address: **it also has no criterion for what counts as success in a world nobody has framed**, since "degree of goal fulfilment must be measurable" requires the measurer to have framed the world. That is gap G72 (nothing infers what counts as success) applied to the *benchmark author* rather than to the agent — and it is why [[wiki/entities/arc-agi-3.md]], which withholds the objective inside a world whose framing is still supplied, is the closest thing actually built.

---

## The split, measured

The page's two stages are ordinarily inseparable in a score. Beger et al. 2025 separate them on [[wiki/entities/conceptarc.md]] by requiring the solver to emit its rule alongside its answer and classifying the rule against the concept the task was authored around ([[wiki/concepts/rule-level-evaluation.md]]). The 2×2 of (rule intended?) × (grid correct?) is the decomposition:

| Cell | Reading in this page's terms | o3, medium + tools |
|---|---|---|
| Intended rule, correct grid | Both stages succeeded | 55.0% textual / 20.4% visual |
| **Intended rule, wrong grid** | **Framing succeeded, optimisation failed** | 2.3% textual / **19.6% visual** |
| Unintended rule, correct grid | Optimisation succeeded inside a different framing that happens to fit the demonstrations | **15.8% textual** / 5.6% visual |
| Wrong rule, wrong grid | Neither | 8.8% textual / 32.5% visual |

Two things this does to the page's argument. **It supports the claim in text and complicates it in vision.** In the textual modality the residual framing decision is where the failures concentrate — the model settles on a representation (colours as *ordinal integers*, cells rather than objects, bounding boxes rather than shapes) that reproduces the demonstrations and is not the intended one, and its optimisation inside that representation is near-perfect (rule–grid alignment 98.1%). That is exactly "no criterion decides that a framing is wrong": nothing in the demonstration pairs distinguishes the two framings, so the free-retry channel this page identifies as the benchmark's gift is *silent* on precisely the stage this page says is harder. **In the visual modality the roles invert** — the intended framing is found on 40% of tasks and lost in application, mostly to perception (grid dimensions misread; visual-error rate 49%), which is a stage this page's two-way split does not have a name for and which sits *upstream* of framing rather than downstream.

---

## Where the framing comes from in each wiki architecture

| Source of the representation | Instances |
|---|---|
| **Hand-authored DSL / predicate set** | [[wiki/entities/ilp-arc-synthesizer.md]] (7 predicates), [[wiki/entities/bayesian-program-learning.md]] (stroke primitives), brute-force ARC solvers |
| **Fixed by the task format** | [[wiki/entities/arc-agi.md]], [[wiki/entities/raven.md]], [[wiki/entities/pcfg-set.md]] — the grid, the matrix, the grammar |
| **Fixed by the observation encoding** | [[wiki/entities/arc-vsa-solver.md]] (geometry and number arrive with the spatial-semantic-pointer format), convolutional and attentional biases generally |
| **Supplied as a symbolic state space** | [[wiki/entities/hbtom.md]], [[wiki/entities/autotom.md]] — hand-written PDDL, with the modelling problem starting after it |
| **Learned, but over a fixed variable set** | [[wiki/entities/cscg.md]], [[wiki/entities/tolman-eichenbaum-machine.md]], world models generally: the *graph* is discovered, the observation vocabulary is not |
| **Constructed by the system** | None |

The last row is the gap. The nearest partial mechanisms the wiki holds are [[wiki/concepts/event-segmentation.md]] (carves a stream into typed edges, but with a hand-thresholded detector — G27) and [[wiki/entities/spelkenet.md]] (computes the objectness entry test from video rather than declaring it), each of which builds *one* element of a representation whose type was chosen in advance.

---

## Open problems

- **Nothing in the wiki constructs a representation** (gap G73). Every discovery result is discovery of structure *over a given variable set*.
- **Nothing chooses a parse of the input either** (gap G75), which is the one framing decision that survives inside a format designed to fix the framing, and the one humans are observed making per task.
- **No criterion decides that a framing is wrong**, as opposed to that a solution within it failed. A learner that cannot distinguish these will spend unbounded compute optimising inside a bad representation — which is the shape of every reported large-compute ARC failure.
- **The cost of a wrong attempt is unpriced everywhere** (gap G74). Every score in the wiki is obtained under free retries; no benchmark here reports first-attempt performance separately, except where exact-match scoring at `pass@2` forces it.
- **The assumption dilemma has no calibration procedure.** How many regularity assumptions to install, and how to withdraw one that is failing, is stated as a trade-off and left unquantified.
- **Goal specification in an unframed world.** The proposed benchmark requires measurable goal fulfilment in worlds nobody has represented, and no mechanism supplies it (G72).

---

## Connections

- **[[wiki/entities/arc-agi.md]]** — the benchmark this page's analysis is aimed at: the transformation-from-Core-Knowledge-operations framing is constant across all tasks and the demonstration pairs make candidates free to test, so the benchmark scores search within a supplied representation and never its construction.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the definition this page extends: skill/intelligence as substitutes, with a *world* diversity axis added to the task scope and the No Free Lunch escape (regularity-bearing worlds only) made explicit, at the cost of dropping the AIT formalism.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the framing stage is the prior question the graph formalisation assumes answered: navigation and even vocabulary discovery presuppose that *something* has decided which aspects of the stream are variables.
- **[[wiki/concepts/refinement-loop.md]]** — the mechanism whose two preconditions this page identifies as properties of the task supply rather than of the method: a checkable candidate and a free retry, both absent the moment an attempt is irreversible.
- **[[wiki/concepts/external-verification.md]]** — the same restriction from the verifier side: every rung of the ladder assumes consulting the checker is cheap and repeatable, which is a claim about the domain and not about the architecture.
- **[[wiki/concepts/core-knowledge.md]]** — the direct antagonist: this page's benchmark proposal argues that installed human priors are *detrimental* in an arbitrary world, where the wiki's use of core knowledge is as the term that equalises a human/machine comparison (T211).
- **[[wiki/concepts/universal-induction.md]]** — the same No Free Lunch move with the opposite conclusion drawn: the ideal inductor answers by weighting all computable environments, this answers by restricting to worlds with regularities and admits that the restriction is an assumption that can be wrong.
- **[[wiki/concepts/event-segmentation.md]]** — the wiki's nearest mechanism for building part of a representation from a stream, and a demonstration of the residual: the *type* of the carved-out object (an event schema ⟨precondition, transition, effect⟩) is chosen by the designer.
- **[[wiki/entities/arc-agi-3.md]]** — the partial delivery: the objective is withheld and the action semantics are latent, so one element of the framing is genuinely constructed by the agent, while the state space (64×64 grid, 16 colours) and the action alphabet's *size* are still supplied.
- **[[wiki/concepts/objective-identifiability.md]]** — the measurement-side twin: attributing a behaviour to an objective requires the architecture and constraints to be specified, just as attributing a score to intelligence requires knowing who supplied the representation.
- **[[wiki/concepts/program-induction.md]]** — the reduction that presupposes this page's first stage: a library of primitives *is* a framing, so "the library may not be authored" (G4) is the framing problem stated one level down.
- **[[wiki/concepts/rule-level-evaluation.md]]** — the only measurement in the wiki that separates this page's two stages: classifying the solver's stated rule against the intended abstraction puts numbers on "framing right, optimisation wrong" (o3 visual, 19.6% of tasks) and "framing wrong, optimisation right" (o3 textual, 15.8%), and shows that the demonstration-pair verifier this page calls the benchmark's free-retry channel cannot see the framing error at all.
- **[[wiki/entities/math-dataset.md]]** — the control condition for this page's split: a competition problem arrives fully framed (specified quantities, a known answer format, a mechanical acceptance test), so MATH scores optimisation-within-a-representation alone — which is consistent with its saturating within three years while framing-heavy benchmarks did not.
- **[[wiki/entities/gsm8k.md]]** — the wiki's only cheap instrument that scores framing directly: GSM-Plus's *critical thinking* perturbation deletes a statement the solution needs, so the correct answer is that the problem is underdetermined, and a solver with no consistency check over its own premises cannot emit it.
- **[[wiki/entities/gpqa.md]]** — the expertise gap read as a framing gap, measured between two populations with equal access to the information: the retrieved facts are available to a PhD in a neighbouring science, the selection of which fact binds is not, and the difference is 23.5–40.6 points depending on domain.
- **[[wiki/concepts/certification-instruments.md]]** — this page supplies failure mode `F5`, the framing axis: an instrument that hands every task the same problem representation measures search inside it and cannot see abstraction upstream, which sits above every other failure in that inventory.
- **[[wiki/concepts/human-baseline.md]]** — a human and a machine handed the same benchmark are not handed the same problem representation, so matching the item pool (B5) does not by itself make the comparison fair.
- **[[wiki/entities/arc-vsa-solver.md]]** — the wiki's only architecture that treats the object parse as a *variable* rather than a given: six candidate parses searched jointly with the rule, which is the sole partial answer this page has to G75.
- **[[wiki/entities/frontiermath.md]]** — the framing problem reached from the verifier's side: a witness predicate makes checking sound and nearly free, but only where the goal is already expressible as a checkable condition, so exporting that acceptance test out of mathematics is exactly the work this page names.
