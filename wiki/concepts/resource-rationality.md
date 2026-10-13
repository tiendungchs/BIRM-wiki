# Resource Rationality — Bounded Optimality as a Design Criterion

**The target is not the optimal *behaviour* but the optimal *program for a given machine*: among the algorithms an architecture can run, pick the one that maximises expected utility net of the time and resources it consumes. The standard is attainable by definition, so every gap between a system and it is a fact about the system and not about intractability.**

> **Provenance.** Lieder & Griffiths 2020, *Resource-rational analysis: understanding human cognition as the optimal use of limited computational resources*, Behavioral and Brain Sciences 43:e1 (`raw/lieder-2020-resource-rational-analysis-optimal-use-limited-computational-resources.md`). Target article (a review: almost every result below is cited to its original and carried here **second-hand**), 25 open peer commentaries, and the authors' response. The clip is a lossy PDF conversion: Equations 3–4 are garbled in the source and are reconstructed here from the article's own prose definitions of each term. The formal root is bounded optimality (Russell & Subramanian 1995; Horvitz 1987), carried here through this source.

The wiki has carried pieces of this criterion under other names — a priced control signal ([[wiki/concepts/expected-value-of-control.md]]), a priced arbitration between planner and cache ([[wiki/concepts/amortized-inference.md]], `T135`), a priced backup ([[wiki/concepts/replay-prioritisation.md]]). This page is the common objective they are each an instance of, plus the argument for who solves it.

---

## The objective

| # | Form | Reading |
|---|---|---|
| 1 | `a* = argmax_a ∫ u(o)·p(o\|a) do` | Expected-utility rationality — optimal behaviour, cost of computing it ignored |
| 2 | `m* = argmax_{m ∈ M_B} E_{P(T, l_T \| E, A_t = m(l_t))}[ u(l_T) ]` | **Bounded optimality.** Optimise the *mind* `m` over `M_B`, the minds brain `B` can run; `l_t` is the life history, `T` the unknown lifetime. The world keeps moving while `m` deliberates, so slowness is penalised inside `u` |
| 3 | `h*(s₀,B,E) = argmax_{h ∈ H_B} E[u(result) \| s₀,h,E,B] − E[cost(t_h, ρ, λ) \| h,s₀,B,E]` | **Per-episode form.** `H_B` = heuristics `B` can execute; `s₀ = (o, b₀)` = observation plus initial internal state; `cost` = opportunity cost of holding resources `ρ` for duration `t_h`, at `λ` per unit resource per unit time |
| 4 | `h*(s₀,B,i) = argmax_{h ∈ H_B} E_{E\|i}[ E[u(result)] − E[cost] ]` | **Robust form.** Optimise against the posterior over environments given information `i` from experience, culture and evolution — a heuristic selected for a *distribution* of environments, not one |

**Three structural commitments, each a design decision for a builder:**

| Commitment | Content | Consequence |
|---|---|---|
| **The agent does not solve Eq. 3** | Evolution, development and lifetime learning solve it; the agent *runs* `h*`, usually a simple rule. Distinguishes this from Stigler-style information economics, where the decision-maker optimises information gathering online | The cost–benefit computation lives in the **outer loop**, so the online regress that [[wiki/concepts/expected-value-of-control.md]] lists ("what does estimating EVC cost?") never arises at run time |
| **The cost is an opportunity cost, i.e. a rate** | `λ` prices a unit of resource per unit time by what else it could have bought | Same quantity as the average reward rate that sets vigour ([[wiki/concepts/effort-based-decision-making.md]]); the wiki's fixed `Cost(signal)` is the special case where `λ` is constant |
| **Eq. 4 is a meta-learning objective with a compute term** | Expected performance over `E ~ p(E|i)` of an inner procedure `h` — exactly [[wiki/concepts/meta-learning.md]]'s `θ*` — minus the inner procedure's running cost | **(brainstorm)** Every meta-RL outer loop in the wiki scores the inner learner's return and never its compute. Adding `−λ·t_h` to the outer loss is the one-line change that turns "learn to learn" into "learn a resource-rational learner", and it predicts the inner algorithm should *change class* (sample-based → heuristic) as `λ` rises, not merely speed up |

**Ancestry of the first commitment** (Simon 1955, [[wiki/concepts/satisficing.md]]). The organism does not know the cost of discovering alternatives, nor weights across its goals. Without them there is no complete ordering to optimise, so it searches until an aspiration level is met. Simon also asks for a "broader criterion" to rank such procedures against each other; Eq. 2 is that criterion. **Ancestry of Eq. 4** (Simon 1956): which simple mechanism suffices is set by the environment's structure. Rare, randomly placed goal sites plus clues let a short look-ahead, a reserve and one search chain per need survive with no utility function. Eq. 4's `p(E|i)` is that environment structure made formal.

**Is the cost term needed?** Lewis & Howes (commentary) argue the separate cost in Eq. 3 adds no expressive power over Eq. 2, since any speed–accuracy pressure can be written into `u` over world histories; what Eq. 3 *does* add is that utility can depend on the agent's **internal state**. Lieder & Griffiths reply that Eq. 3 follows from Eq. 2: a belief state is worthless at death but valuable mid-life because it informs later decisions, so the value of an internal state is grounded in its effect on future world states — and `b` must include *every* internal variable that affects future decisions, not only beliefs.

---

## The method (five steps)

1. State the computational-level problem and its ideal solution.
2. Posit the architecture: a class of algorithms, the cost of each elementary operation, the utility of a closer approximation.
3. Derive the algorithm in that class that optimally trades cost against accuracy (Eq. 3/4) — by hand, or by automatic strategy discovery.
4. Test the resulting process model (responses *and* reaction times) against data.
5. Refine the problem or the architecture; iterate, or stop once the assumed constraints are realistic.

**The bounded-optimality assumption is a search heuristic over mechanisms, not a claim that the mind is optimal** (authors' response, conceding Rahnev's commentary): successes show the assumption useful, never true. It is the same move [[wiki/concepts/neuroscience-ai-transfer.md]] makes with biological plausibility, applied one level down — it is what selects among the infinitely many algorithms consistent with a behaviour.

---

## What the criterion derives — instantiations

All second-hand, via Lieder & Griffiths 2020.

| Domain | Constraint priced | Derived mechanism / result |
|---|---|---|
| **Sampling** (Vul et al. 2014) | Time per mental simulation vs time per action | Optimal number of samples is small; **one sample** (= probability matching) is optimal when executing the action takes ≤ ~3× as long as simulating it. More samples as stakes rise relative to opportunity cost — matched by the shift from probability matching to maximising as incentives grow |
| **Stopping on noisy evidence** (Bogacz et al. 2006) | Reward rate | The drift-diffusion threshold that maximises points per second; against it, humans gather **too much** evidence (Holmes & Cohen 2014) — the opposite of the "people think too little" reading |
| **Numerical estimation** (Lieder et al. 2018) | Opportunity cost of time | Anchoring-and-adjustment as **truncated Markov-chain Monte Carlo**: propose adjustments, accept/reject so the chain converges to the Bayes-optimal estimate, stop at the speed–accuracy optimum. Anchoring bias = chain stopped early on purpose |
| **Hypothesis generation** (Dasgupta et al. 2017, 2018) | Same sampler | Explains sub- and super-additivity in probability judgment; generated hypotheses are **memorised and reused** on related queries — amortised inference in humans ([[wiki/concepts/amortized-inference.md]]) |
| **Frame problem** (Icard & Goodman 2015) | Cost per variable entering the reasoning model | Usually optimal to consider only the **1–3 most relevant** variables; predicts more neglect of alternative causes in predictive ("what will happen if…") than in diagnostic ("why did…") reasoning |
| **Sparse attention to variables** (Gabaix 2014–2017) | Cost of attending | Attend a few variables, replace the rest by defaults, partially adjust partly-attended ones; one model yields base-rate neglect, insensitivity to sample size, overconfidence, projection bias |
| **Planning strategies** (Callaway et al. 2018; Lieder et al. 2017) | Cost per planning operation, non-myopic | Strategy discovery by solving a **meta-level Markov decision process** over computations. Humans reach **~86%** of the best achievable quality–time trade-off and agree with the bounded-optimal strategy **~55%** of the time; strategies shift across environments as predicted |
| **Strategy discovery** (Lieder et al. 2017) | Same | A previously unknown heuristic — satisficing plus Take-The-Best (SAT-TTB): inspect payoffs only for the most probable outcome, stop at the first above an aspiration level — derived, then confirmed in people **only** on the problems where it is bounded-optimal. The aspiration-level stop is Simon 1955's Rule D ([[wiki/concepts/satisficing.md]]) |
| **Myopic metareasoning** (Gabaix & Laibson 2005) | Immediate cost vs immediate gain of each operation | Greedy one-step value of computation; predicts suboptimal search in a bandit task |
| **Habits** (Keramati et al. 2011, 2016; Huys et al. 2015) | Time available; planning cost | Arbitration by cost–benefit; people **plan a few steps then hand off to habitual values, with the depth set by time available**; sequential problems decomposed into sub-problems to trade planning savings against decision quality |
| **Goals** | Planning cost | An unbounded expected-utility maximiser has no reason to have goals. Backward planning from a goal (means–ends analysis) ignores most states and action sequences — goals as a **tractability device** |
| **Working memory** (Sims et al. 2012; van den Berg & Ma 2018) | Rate–distortion capacity; neural cost | Capacity flexibly split (few items precise / many coarse); the **total** resource is itself set by a cost–benefit, not fixed |
| **Multitasking** (Musslick et al. 2016, 2017; Feng et al. 2014) | Shared representations | Resource-constrained *parallel* processing yields serial-looking limits; the bottleneck itself is rational because **shared representations learn faster** through generalisation, at the price of interference |
| **Number of subsystems** (Milli et al. 2017, 2019) | Cost of selecting among strategies | Derives the coexistence of a fast error-prone and a slow accurate system — few modules, not one per situation |
| **Representation format** (Wei & Stocker 2015, 2017; Bhui & Gershman 2017) | Allocation of a fixed coding resource | Perceptual bias *away* from the prior; utilities coded by smoothed rank — "irrational" representations as bounded-optimal codes |
| **Metabolism** (Lennie 2003) | ~1% of neurons can sustain high activity at once | Pressure propagates up to selective attention |

**What the table says for a builder.** The bounded-optimal answer is rarely a smarter version of the ideal computation — it is usually a **different algorithm class**: one sample instead of a posterior, a truncated chain instead of a converged one, 1–3 variables instead of the full graph, a goal instead of a utility surface, a habit instead of a plan. The criterion picks the class.

---

## The constraint space is under-specified — the commentaries' main result

**Ma & Woodford: five axes on which "resource-rational" models silently differ.**

| Axis | Options | Why it matters |
|---|---|---|
| Performance term | task-specific loss vs general-purpose mutual information | MI suits early sensory codes and is suboptimal for almost any specific task |
| Resource term | information-theoretic / algorithmic intensity / explicitly neural | different costs, different optimal algorithms |
| Cost form | **hard constraint** (fixed budget) vs **increasing cost** (variable budget) | predict different responses to environmental change; only the variable form can explain allocation of precision across locations |
| What is limited | number of distinct signal types vs rate of signals actually sent | — |
| Timescale of optimisation | trial-by-trial (attention) vs natural-statistics (efficient coding) | most models are non-committal |

**Space is not in the equations.** Eq. 3 charges for resources held over time. A cache is the opposite trade: storage paid once, time saved on every later query. Dasgupta & Gershman 2021 ([[wiki/concepts/computational-reuse.md]]) list memory's role in the accuracy–cost trade-off as open, and nothing above prices storage. That is one more resource that is not time, on the many-currencies side of the split below.

**One currency or many.** Bates, Sims & Jacobs: without "constraints on constraints" each domain gets its own cost and the unification is lost; they propose a single information-theoretic channel-capacity constraint everywhere, and report that capacity-limited reinforcement learners acquire compressed policies that **generalise better** (Lerch & Sims 2019). Lieder & Griffiths: constraints are genuinely plural — time is not working-memory capacity, and some limits are on computation per representation, not on representation. The wiki's nearest row is `T397` (one cost block or two, for cognitive vs physical effort).

**Rival constraints, same bias.** Sanborn, Zhu, Spicer & Chater: averaging of event probabilities (robust to noise), quantum probability (conserves representational resources) and sampling (time cost) each explain the conjunction/disjunction errors with mutually exclusive constraints — so the criterion **cannot adjudicate between them**; only an experiment where they predict differently can. They rank sampling as the best-attested constraint.

**Competing processes.** Haas & Klein: single-process analyses miss resource competition between processes (multiplexed control representations, Botvinick & Cohen 2014) on episodic, developmental and evolutionary timescales; an atomistic analysis leaves free parameters where the competition would sit.

---

## Learning to be resource-rational

| Point | Source | Content |
|---|---|---|
| Must be learned | Ma & Woodford | Knowing which mechanism is optimal requires knowing the environment's statistics, never known exactly from finite experience — bounds the efficiency attainable even asymptotically |
| The authors' programme | target article + response | Metacognitive reinforcement learning (Krueger et al. 2017): learn which computations to run; resource rationality reported to grow with experience in a new environment |
| **Heuristic lock-in** | Persaud et al. | A learner whose small working memory favoured a local-search heuristic adopts it as a habit; when capacity grows, nothing triggers re-evaluation toward the now-better global search |
| Constraints can help learning | Bejjanki & Aslin | "Less is more": networks that start resource-limited learn grammar better (Elman 1993); 6–7-year-olds integrate cues optimally once task complexity is reduced |
| Evolution as selector | Schulz | Computationally intensive processes adapt more easily to new environments at a time cost — so deliberation is resource-rational exactly where evolved heuristics fail |
| Habits from deliberation | response | Deliberation re-values past experience and updates habits (Krueger & Griffiths 2018) — regret as the teaching signal that makes the cheap system more resource-rational |

---

## Objections that bound the claim

- **Overfitting by constraint choice** (Rahnev; Dimov). Step 5 lets the modeller add constraints until behaviour looks optimal; a substantive claim needs zero-free-parameter models with independently measured constraints. Lieder & Griffiths agree constraints should be measured independently; Dimov proposes inverting the method — ask *under which constraints* an observed algorithm would be optimal, to infer the constraints.
- **Anti-Bayesian updating** (Mandelbaum et al.): belief polarisation and the size–weight illusion move *against* the prior. Reply: a mass estimate formed as inferred density × inferred volume, each with ordinary priors, reproduces the size–weight illusion including the "box A heavier than A+B+C" case.
- **Everyday failures** (Davis & Marcus). Reply: the criterion is optimal *on average over the environment distribution*; single-situation errors do not refute it, and optimal meta-decision-making is itself intractable, so a resource-rational agent will sometimes overthink and sometimes be impulsive.
- **Representation generation is open-ended** (Szollosi & Newell): people invent problems and representations, so the function in step 1 is not fixed. Reply: representational flexibility is one more resource the criterion can price.

---

## Open problems

- **No machine instance of Eq. 4.** Meta-learning optimises the inner learner's performance; nothing in the wiki also charges its compute in the outer loss. Whether the inner algorithm would change class as `λ` rises is untested (see the brainstorm above).
- **The meta-level problem is solved offline here.** The 86% / 55% planning numbers come from a strategy derived by solving a meta-level Markov decision process outside the agent; how a learner reaches it is the open half ([[wiki/architectural-gaps.md]] `G15`).
- **The cost currency is unsettled** — one information-theoretic capacity, or several incommensurable resources (Bates et al. vs Lieder & Griffiths; `T397`).
- **Hard budget or priced budget.** The two forms predict different responses to a changed environment (Ma & Woodford), and the working-memory evidence favours a priced budget (van den Berg & Ma 2018) — which bears on whether a capacity limit is a ceiling at all (`T104`).
- **Re-evaluation trigger.** Nothing says when a learned heuristic is re-optimised after the resources it was fitted to have changed (Persaud et al.) — the cost-side analogue of the knowledge-boundedness limit on [[wiki/concepts/meta-learning.md]].
- **(brainstorm) The frame problem is subgraph selection.** In [[wiki/concepts/latent-graph-discovery.md]] terms, Icard & Goodman's result says a reasoner should instantiate only the 1–3 highest-relevance nodes of the causal graph per query, and that which nodes are dropped depends on query *direction* (predictive drops alternative causes more than diagnostic). A testable demand on any graph-based reasoner: its effective query subgraph should shrink with time pressure and differ by query direction.

---

## Connections

- **[[wiki/concepts/expected-value-of-control.md]]** — that page's `EVC = Σ Pr·Value − Cost(signal)` is Eq. 3 with the heuristic slot occupied by a control signal and `cost` collapsed to a function of intensity; this page supplies the third answer to its "what does estimating EVC cost?" regress — the cost–benefit is solved by the outer loop and the agent only runs the result.
- **[[wiki/concepts/effort-based-decision-making.md]]** — measures the cost term this page's equations leave free, and both land on opportunity cost: Eq. 3's `λ` per unit resource per unit time is the rate quantity that page endorses and leaves unmeasured.
- **[[wiki/concepts/amortized-inference.md]]** — the same trade from the cache side: Eq. 3 prices the expensive computation, and Dasgupta et al.'s memorised hypotheses are amortisation shown in people, with the plan-then-habit depth set by available time giving `T135` position B its time-pressure evidence.
- **[[wiki/concepts/simulation-based-planning.md]]** — the criterion applied to rollouts: the meta-level Markov decision process over planning operations is the formal object that page's "rollout over computations" brainstorm calls for, and it has been solved for humans (~86% of optimal trade-off).
- **[[wiki/concepts/replay-prioritisation.md]]** — `EVB = Gain × Need` is a myopic value of computation for one Bellman backup, the same greedy approximation as Gabaix & Laibson's one-step metareasoning, so both inherit the myopia the non-myopic strategy-discovery methods remove.
- **[[wiki/concepts/meta-learning.md]]** — Eq. 4 is that page's `θ*` with a running-cost term on the inner procedure added, and Botvinick et al.'s evolution → development → learning cascade is the set of outer loops this page says solve Eq. 3 so the agent does not have to.
- **[[wiki/concepts/evidence-accumulation.md]]** — the one case where this page's criterion has a closed-form answer: the reward-rate-optimal threshold on a drift-diffusion process, against which humans over-sample — which makes the threshold a priced quantity rather than a fixed error rate.
- **[[wiki/concepts/information-bottleneck.md]]** — the candidate single currency for this page's cost term: rate–distortion with a task-defined distortion is the constraint Bates, Sims & Jacobs propose for every domain, and their capacity-limited policies generalising better is that page's "compression is necessary for generalisation" claim restated for control.
- **[[wiki/concepts/universal-induction.md]]** — the ideal prior this criterion is applied to by its own founder: Solomonoff 1964 caps each description at `τ` operations so every term is computable, and would adopt a computable approximation as a *better* explication than the uncomputable ideal. That is bounded optimality applied to the hypothesis prior rather than to action selection.
- **[[wiki/entities/aixi.md]]** — the opposite standard: AIXI is optimal and uncomputable, bounded optimality is optimal relative to a given machine and attainable by definition, so it converts that page's "every real architecture is a bounded approximation" from a concession into the objective itself.
- **[[wiki/concepts/computational-reuse.md]]** — the resource this page's objective does not price: a cache spends storage to save future time, so memoization is a trade along an axis Eq. 3 lacks. That page's stale-cache account of habits is the partial-update case of this page's prioritised computation, repaired as time, resources or incentive grow.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the same methodological move one level down: that page uses biological plausibility as a search heuristic over architectures, this one uses bounded optimality as a search heuristic over algorithms, and the source proposes compute-limited benchmarks as the channel back to AI.
- **[[wiki/concepts/satisficing.md]]** — the root this page's objective descends from: Simon 1955 argues the organism knows neither the cost of finding alternatives nor the weights across its goals, so it cannot optimise online and instead searches until an aspiration level is met. That argument is why this page puts the cost–benefit in an outer loop, and SAT-TTB is Simon's Rule D derived as bounded-optimal. Its 1956 sequel supplies the environment side that Eq. 4 formalises: the environment's statistics (goal density, branching, clue availability) decide how simple a sufficient mechanism can be.
