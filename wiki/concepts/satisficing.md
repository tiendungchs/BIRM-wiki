# Satisficing — Choice by Aspiration Level

**Replace "find the best alternative" with "find an alternative whose every possible outcome clears an aspiration level". Then let that level move with how hard satisfactory alternatives are to find. This turns an optimisation into a feasibility test. It needs no probabilities, no complete ordering of payoffs and no price on search, and the aspiration dynamics guarantee that a solution exists.**

> **Provenance.** Simon 1955, *A behavioral model of rational choice*, Quarterly Journal of Economics 69(1):99–118 (`raw/simon-1955-behavioral-model-of-rational-choice.md`). A theoretical paper. Its evidence is "casual empiricism" plus one chess estimate, and it says so. The clip is a lossy PDF conversion with interleaved columns. Rules A–E below are rebuilt from the source's prose definitions. The appendix equations (A.1–A.10) are unreadable, so only their stated interpretation is carried. Figures I–II carry no data. The sequel on the environment's side of the problem is Simon 1956 (queued).

[[wiki/concepts/resource-rationality.md]] carries the modern objective: bounded optimality, solved by an outer loop. This page is its root. Simon's argument is the *reason* that outer loop exists: the organism does not know the costs or the weights it would need to optimise online.

---

## Primitives

| Symbol | Meaning |
|---|---|
| `A` | Behaviour alternatives |
| `Å ⊆ A` | Alternatives the organism actually **considers** |
| `S` | Possible outcomes (future states) |
| `V(s)` | Payoff on outcomes. Only an ordering is needed; a cardinal `V` is assumed for convenience |
| `S_a ⊆ S` | Outcomes that may follow alternative `a` — **set-valued** information, no probabilities |
| `P_a(s)` | Probability of `s` given `a`, `Σ_{s∈S_a} P_a(s) = 1` — a strictly stronger kind of information than `S_a` |

**Internal constraints are givens.** "The environment may lie, in part, within the skin": limits on computation and prediction enter the definition of rational choice exactly as a maximum running speed bounds the action set. The state of information is "as much a characteristic of the decision-maker as of his environment".

---

## The rules

| Rule | Definition | What it demands |
|---|---|---|
| **A. Max-min** | `V(â) = max_{a∈A} min_{s∈S_a} V(s)` | `S_a` for every `a`; a complete ordering |
| **B. Probabilistic** | `max_{a∈A} Σ_{s∈S_a} V(s) P_a(s)` | `P_a` for every `a` |
| **C. Certainty** | `max_{a∈A} V(s_a)` | A known single outcome per `a` |
| **D. Satisficing** | `V ∈ {1, 0}` (satisfactory / not). (i) Find `S′ ⊆ S` with `V(s) = 1 ∀ s ∈ S′`; (ii) find `a` with `S_a ⊆ S′` | Only a detector of `S′`, and the mapping refined *only where it touches* `S′` |
| **E. Vector satisficing** | `V = (V_1,…,V_n)`; satisfactory iff `V_i ≥ k_i ∀ i`. Find `S′`, then `a` with `S_a ⊆ S′` | Per-component aspiration levels `k_i`; **no weights** across components |

All of these can be run over `Å` in place of `A`. Rules D and E guarantee neither existence nor uniqueness; Section 3 adds rules that do.

**Reading (this wiki's).** Rule D is Rule A applied to a binary payoff. "Every outcome of `a` is satisfactory" is a worst-case guarantee, so satisficing needs no `P_a`. It is robust choice with the threshold set by aspiration rather than by the worst case.

**Three cases Rule E handles with one test**, where the maximising model breaks for want of a complete ordering:

| Case | Components of `V` | Classical patch | Rule E reading |
|---|---|---|---|
| Group decision | One payoff per member | `n`-person game theory; weak welfare principles | A **viable** solution |
| Incommensurable values (salary, climate, pleasantness, prestige) | One per value | Indifference curves imposed on the space | Per-value **aspiration levels** |
| Uncertainty | One per possible consequence of `a` | Probability weights, or minimax regret | With all `k_i` equal, a **minimum guaranteed payoff** |

**Feasibility, not optimality.** In linear programming the aspiration is one more linear inequality. Once a feasible programme meets it, there is no need to check whether a better one exists.

---

## Search with a coarse map

Rule D streamlines information gathering when the `A → S` mapping is unknown (each `a` initially maps onto all of `S`):

1. Start from a very coarse mapping of `A` on `S`.
2. Find an `S′` on which `V = 1`.
3. Refine only the part of the mapping that involves `S′`.
4. Look for an `a` that maps into `S′`.

When step 4 succeeds, more information **cannot improve the choice**, so the cost of further information never has to be estimated.

**Chess** (the source's one quantitative case). Player-side categories are *clearly won / clearly lost / clearly drawn / won-or-drawn / drawn-or-lost*, not the objective three. White picks a move whose replies all land in "clearly won". Black's replies explore the move's mapping, and new clearly-won positions found on the way are added to `S′`. The evaluation only has to detect **transitions between the three states**. It does not need a graded valuation from −1 to 1, which Simon allows may suit the opening. Simon's estimate: a 16-move sequence (8 per side) has ~10²⁴ legal variations; on two middle-game positions, this procedure examined **fewer than 100**. The simplification works only if "clearly won" covers a large share of the objectively won positions, which is an empirical fact about the game.

---

## Making a solution exist: two adjustable quantities

Alternatives are examined **sequentially**, and the first satisfactory one is chosen. That is well defined where the environment fixes the order (offers on a house arrive in time) and unpredictable where the organism fixes it (which of several forced mates a player finds first).

| Quantity | Easy to find satisfactory alternatives | Hard to find them | Effect |
|---|---|---|---|
| **Aspiration level** `k` | Rises | Falls | "Near-uniqueness" when easy; existence guaranteed when hard, because failure lowers `k` until solutions exist |
| **Considered set** `Å` | Narrows | Broadens: search for new alternatives to adjoin | The same refinement process as information gathering (`A∖Å` = alternatives mapped onto all of `S`) |

- **Persistence** = the share of adjustment carried by `Å` rather than by `k`. A persistent organism searches for new options rather than lowering its standard. Simon expects an up/down asymmetry.
- "Difficulty" could be expressed as the cost of refining the `A → S` map, or as its combinatorial size. The adjustment rule is left unformalised.
- **Anecdote** (footnote 6): given a multi-payoff problem whose payoff hung on one very uncertain event, students and friends refused to stay inside the alternatives the problem allowed. They avoided the big-profit-or-ruin option and invented new alternatives less sensitive to that event. That is broadening `Å` instead of computing the probability.

**The central claim.** If payoff and the cost of discovering alternatives were both measurable in one currency, a weighted sum would restore a complete ordering, and there would be an optimal degree of persistence. The organism knows **neither the costs nor the weights**, and that is why the limited models matter. "How to behave rationally given these limitations" is a different question from "how to raise the limits".

**A hierarchy of rational mechanisms.** The aspiration-adjustment rule may itself be rational "in some dynamic sense". Comparing two procedures needs a broader criterion that treats both as approximations, and the level being analysed has to be stated. Footnote 7 offers one such criterion: "the survival value of its choice mechanism".

---

## Dynamics

| Complication | Full treatment | Simon's middle ground |
|---|---|---|
| Payoff of trial `t` depends on earlier choices | Vector payoff over the whole sequence, so a strategy chosen at the start (intractable) | **Two-component per-trial payoff**: immediate payoff + the *position* left for future trials (saving, liquidity) |
| Finite planning horizon | Carry the strategy past the horizon to value the end state exactly | Estimate the "goodness" of position at the horizon, like the depreciated value of an asset. Chess example: pay-off every ten moves by piece values. Time-discounting shrinks the cost of errors in these horizon values |
| The payoff function is learned | — | "It doesn't know how well it likes cheese until it has eaten cheese" |
| Choosing in order to learn | — | Part of an alternative's payoff is the information it yields about the mapping or about `V` |

---

## Appendix: optimal stopping versus the bounded seller

A seller sets an acceptance price `d(k)` each day `k`. They accept the day's highest offer if it exceeds `d(k)`; otherwise they keep the house.

| | Optimal seller | Bounded seller |
|---|---|---|
| Rule | `d(i)` = the expected sale price if the house is not sold on day `i` and later prices are set optimally — the continuation value. With a terminal day `n` whose reservation price sells for certain, it is solved **backward from `n`**, with no simultaneous equations (the result is also attributed to Darling & Kincaid) | Fix a horizon by assuming a price at which the house will certainly sell by day `n`. Start `d` high, watch the offers and **adjust `d` up or down gradually** until an offer is accepted |
| Information needed | "Virtually complete" knowledge of the distribution of offers for every later period | None beyond the offers observed |
| Probability calculations | Required | None |

The convergence condition for the infinite-horizon sum: the offer distribution must shift down fast enough (expected falling prices, or offers read as present values under a high interest rate).

The appendix is the paper's example of **rationality at two levels**: choosing rationally within limits, and setting those limits rationally. Its last line is the claim of the whole paper: this is "the kind of rational adjustment that humans find 'good enough'".

---

## Instantiations elsewhere in the wiki

| Where | What satisfices | Aspiration set by |
|---|---|---|
| [[wiki/concepts/resource-rationality.md]] (SAT-TTB, Lieder et al. 2017) | Inspect payoffs for the most probable outcome; stop at the first above an aspiration level | Derived as bounded-optimal for a problem class, then confirmed in people only on those problems (second-hand) |
| [[wiki/concepts/evidence-accumulation.md]] | Commit when the normalised log-posterior crosses a threshold | Fixed error rate (unmodelled) or reward-rate optimum |
| [[wiki/entities/universal-transformer.md]] / [[wiki/concepts/adaptive-computation-time.md]] | Stop pondering when halting mass passes a threshold | Hand-set (`G107`) |
| [[wiki/entities/alphazero.md]] | — the counter-case: a graded `v ∈ [−1, 1]` on every leaf, the evaluation Simon proposed to avoid | n/a (fixed 800 simulations) |

---

## Reading in the core framing

| Element | Latent-graph reading |
|---|---|
| `S′` | A **goal region** of the state graph, recognised by a coarse detector rather than scored |
| `S_a ⊆ S′` | Every edge out of the chosen action lands in the goal region, i.e. a guaranteed reachability query |
| Refine only near `S′` | Graph discovery restricted to the edges that touch the goal region — what is learned is set by the query |
| Broadening `Å` | Adding candidate edges or actions to the graph when search fails, instead of lowering the bar |
| Two-component payoff | Immediate reward + a value on the node reached: the bootstrapped value at the planning horizon |

---

## What this changes for a builder

- **The stopping criterion can be a level instead of a price.** `G107` asks for an exchange rate between compute and accuracy. Simon's answer is that the rate is unknowable, and he replaces it with a threshold driven by search difficulty. Per-input search then ends at the first success, and the threshold drifts until success arrives at some rate.
- **The level of success is endogenous; its content is not.** The aspiration level is a success criterion the agent sets from its own search history, which is half of `G72`. The payoff `V` it thresholds is still given.
- **(brainstorm) Aspiration dynamics implies a success-rate set-point.** Let `k` rise after easy success and fall after a failed search. Then the stationary `k` is where the per-episode success probability balances the up and down step sizes, so the step sizes (and their asymmetry) *are* a target success rate. That is a mechanism for the 70–80% free-play set-point ([[wiki/concepts/information-sampling-vs-search.md]], `T370`). The set-point becomes a ratio of two step sizes, not a constant. Untested; it predicts that the set-point moves when the cost of a failed attempt changes.
- **(brainstorm) A three-valued evaluator is a cheaper training target than a value function.** A detector of "clearly won / lost / drawn" only needs to fire on *transitions* between classes. That is a classification target with sharp boundaries, against a regression target that must be calibrated everywhere. Nothing in the wiki trains one and compares sample cost against a graded value head.
- **Vector aspirations dodge the common-currency requirement.** Rule E needs no weights across objectives. That contrasts with the single measured scalar in [[wiki/concepts/subjective-value.md]], whose evidence covers one commensurable pair (money × delay), while Simon's cases are the incommensurable ones.

---

## Open problems

- **The adjustment rule is not formalised.** Step sizes, asymmetry, and what "difficulty" is measured in (map-refinement cost or combinatorial size) are all left open. Without them the existence guarantee is only qualitative.
- **Search order decides the answer.** When several alternatives satisfy, the first one examined wins, and "we have no theory that predicts the order". A satisficer needs a proposal distribution, which the paper does not supply.
- **The "clearly won" detector's coverage is assumed.** The ~10²⁴ → <100 reduction depends on how much of the objective win set the coarse detector recognises. Nothing says how such a detector is learned, or what happens where it covers little.
- **What level is optimised is left to the analyst.** The hierarchy of rational mechanisms (choose within limits → set limits → judge by survival value) has no stopping point. [[wiki/concepts/resource-rationality.md]] places the cost–benefit in an outer loop, which names a level but does not derive one.
- **No measurement.** The paper has no data beyond the chess count and an anecdote. Its own disclaimer: no claim is made about when, or how much, humans use these simplifications.

---

## Connections

- **[[wiki/concepts/resource-rationality.md]]** — the modern successor: bounded optimality supplies the "broader criterion" Simon says is needed to rank satisficing against optimising. Its first structural commitment (the agent does not solve the cost–benefit online) follows from Simon's argument that the organism does not know the costs of search or the weights across goals.
- **[[wiki/concepts/evidence-accumulation.md]]** — the same commit rule on a stream of evidence instead of a stream of alternatives: act at the first threshold crossing. Simon's aspiration adjustment is a candidate setter for the threshold that page leaves unmodelled, driven by search difficulty rather than by a fixed error rate.
- **[[wiki/concepts/simulation-based-planning.md]]** — supplies a *when is the answer good enough* rule for game-tree search: stop at the first move whose every reply lands in a recognised goal region. On two chess positions this cut ~10²⁴ variations to <100 lines. Simon's two-component payoff (immediate + position) is the value-at-horizon bootstrap that page's depth question presupposes.
- **[[wiki/entities/alphazero.md]]** — the opposite design: a graded value `v ∈ [−1, 1]` on every leaf, at a fixed 800 simulations. Simon's alternative is a three-valued detector that only has to fire on transitions between won, lost and drawn, plus search that stops at the first satisfactory move.
- **[[wiki/concepts/subjective-value.md]]** — the common-currency scalar that Rule E does without. That page measures one scalar for commensurable money × delay outcomes; Simon's cases are the incommensurable ones (salary vs climate), handled by per-component aspiration levels with no weights.
- **[[wiki/concepts/information-sampling-vs-search.md]]** — aspiration dynamics as a candidate mechanism for that page's 70–80% free-play set-point `(brainstorm)`. A level that rises after easy success and falls after failure settles at a success rate fixed by its two step sizes (`T370`).
- **[[wiki/concepts/adaptive-computation-time.md]]** — a learned halting unit that crosses a hand-set threshold. Simon's argument is that such a threshold cannot be priced, and should instead be moved at run time by how hard success was to reach (`G107`).
- **[[wiki/concepts/latent-graph-discovery.md]]** — satisficing search refines the graph only where it touches a goal region, so the query decides which part of the latent graph is discovered. When search fails, it adds candidate edges (broadening `Å`) instead of lowering the bar.
