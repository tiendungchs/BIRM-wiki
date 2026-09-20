# Optimal Hierarchy Criterion

**A subgoal decomposition is not a heuristic to be chosen by taste — it is a *model*, and the best one is the option inventory with the highest Bayesian model evidence for the ensemble of behaviours the agent will have to produce; that single quantity is provably equivalent to the shortest code for those behaviours and to the fewest trial-and-error attempts needed to find them, and its optimum lands on the task graph's topological bottlenecks.**

> **Provenance.** Solway, Diuk, Córdova, Yee, Barto, Niv & Botvinick 2014, *Optimal Behavioral Hierarchy*, PLoS Comput Biol 10(8):e1003779 (`raw/solway-2014-optimal-behavioral-hierarchy.md`). Formal framework + four human behavioural experiments (`n` = 40, 10, 21, 35). Everything below is from that source unless marked.

> **Clipping caveat.** The source was clipped from the PLoS HTML; all display equations are figure images and most inline numerals (percentages, `p`-values, evidence ranges) were stripped. Equations below are **reconstructed from the surviving prose** and marked `(reconstructed)`; effect sizes that did not survive are marked `[value lost in clip]`. Verify against the published PDF before quoting.

---

## The construction

| Bayesian model selection slot | What it is here |
|---|---|
| Model `M` | An **option inventory** — a decomposition of the state-transition graph into connected components (regions), with one subtask per available way of transitioning between regions |
| Data `D` | The **optimal flat policies** for a whole task *ensemble* `𝒯`, written as a concatenated stream of state–action pairs, plus task-unique symbols marking where each task begins |
| Parameters `θ` | A complete hierarchical policy assignment: one root-level policy per task in `𝒯`, plus one policy per option in the inventory |

```
P(D | M) = ∫_Θ P(D | θ, M) · P(θ | M) dθ                      (1)
         = Σ_{θ ∈ Θ(M)} P(D | θ) · P(θ | M)     (discrete θ)   (2, reconstructed)
```

The optimal hierarchy is `argmax_M P(D | M)`.

**The mechanism that makes the integral discriminate — free parameters.** `D` is the *flat* optimal behaviour; `θ` ranges over *hierarchical* policies. In a state covered by a running option, the root-level policy is irrelevant: it can take any value and still reproduce `D`. Many settings of `θ` are therefore compatible with the data, and that multiplicity is what raises the marginal likelihood. **A good decomposition is one that absorbs the most constraint into reusable option policies and leaves the most root parameters free.** This is the whole selection principle; bottlenecks are its consequence, not its definition.

### Closed form

For an agent whose actions are deterministic, reversible transitions on an undirected graph, the evidence collapses to a per-datum sum (source's Eq. 3):

```
log P(D | M) = Σ_i [ 1ᵀ(i)·(−log dᵢ) + 1ˢ(i)·(−log kᵢ) ]      (3, reconstructed)

  i   ranges over vertex identifiers in the data stream
  dᵢ  degree of the vertex appearing as data element i
  kᵢ  1 + the number of subtasks initiable at that vertex
  1ᵀ, 1ˢ  indicators: does element i constrain the task-level policy, or a subtask-level policy?
```

Every term is computable from the target data and the graph alone — no simulation, no learning run.

---

## Three quantities, one optimum

| Reading | Claim | Status in source |
|---|---|---|
| **Statistical** | `M*` maximises the model evidence of the target behaviour | Definition |
| **Learning-theoretic** | `M*` minimises the **geometric mean number of trial-and-error attempts** to discover the optimal policy of a randomly drawn task *or subtask* | Proved (online supplement) |
| **Information-theoretic** | `M*` minimises the **expected number of bits** to specify a hierarchical policy consistent with `D` under a Shannon code | Proved (online supplement) |

All three follow from one fact: each candidate hierarchy induces a probability distribution over behaviours, and the maximum-evidence hierarchy puts the most mass on the target behaviour — hence the shortest code and the fewest samples to hit it. **Ease of learning and descriptive complexity are the same axis**, which is why the compression-based option-discovery methods were on the right track without a justification.

### Measured, on the four-rooms grid

| Agent's option set | Model evidence | Expected search time (geometric mean trials) |
|---|---|---|
| **Doorway subgoals** (optimal partition) | highest | lowest |
| Alternative partition | lower | higher |
| Whole graph as one region (= flat) | lower still | higher |
| Corner subgoals (singleton regions) | lowest | highest — **worse than flat** |

Search time ranged 685 → 65 947 trials across the four; evidence and code length ranged over log scales `[values lost in clip]`. The corner agent learning *more slowly than the flat agent* is the quantitative form of "hierarchy per se buys nothing" — see the negative-transfer result on [[wiki/concepts/temporal-abstraction-options.md]].

---

## Where the optimum lands

- **Topological bottlenecks** — narrow segments bridging densely interconnected clusters. Four-rooms → the doorways. Tower of Hanoi → three regions, one per position of the *largest* disk.
- The resulting partitions closely resemble those from **graph community detection**, and compression of random walks on graphs is itself a community-detection method (the InfoMap family).
- **This is the normative licence for the graph-partitioning option-discovery family.** Bottleneck and community heuristics were previously justified only by intuition ("carve at the joints") and by working; here they are shown to *approximate* a partition that provably maximises discovery efficiency.
- The two are complementary rather than rival: this criterion says which partition is best, bottleneck detection says how to find it without enumerating hierarchies. The source explicitly flags that they **will not always coincide** and does not characterise when they diverge.

---

## Humans find the optimal parse without being told to

| Exp | `n` | Domain | Probe | Result |
|---|---|---|---|---|
| 1 | 40 | 10-vertex "town", **every vertex degree 3**, equal exposure, learned from local adjacency drill only — never a bird's-eye view | Choose where to place a "bus stop" you can teleport to | The two bottleneck vertices chosen first **4.4× chance rate**; among participants who later drew the graph perfectly, `[proportion lost in clip]` chose a bottleneck first |
| 2 | 10 | 19-vertex town, map shown | "Name all / any one location on the shortest path from A to B" | Strong tendency to name the **bottleneck first**, in both the all-locations and single-location conditions (Monte Carlo test, `[p lost in clip]`) |
| 3 | 21 | same graph | "Going A→B, would you pass through C?" | Correct RTs **faster for bottleneck probes** than non-bottleneck; 98% accuracy; effect not explained by probe frequency |
| 4 | 35 | Tower of Hanoi (colour-coded, 3 beads) | Start/goal pair with **two shortest paths of equal length**, crossing 1 vs 2 region boundaries | Participants took the single-boundary route `[% lost in clip]`; 17 subjects favoured it, 7 the opposite |

The design of Exp 1 is the load-bearing one: degree, exposure and visual salience were all equalised, and no global view was ever given, so the bottleneck had to be inferred from local adjacency statistics alone.

**What Exps 2–4 add beyond "people find bottlenecks":** they show bottlenecks are used *in the order of planning* — the transition point is retrieved before the fine-grained steps, and a tie between equal-length paths is broken by **boundary-crossing count**, implying subgoals held in memory are costly. That is a behavioural signature of region-first, then within-region refinement.

---

## Limits — read before building on this

| Limit | Why it matters |
|---|---|
| **The data are the solutions.** `D` is the set of *already optimal* flat policies for the whole ensemble | The criterion **scores** a hierarchy; it is not a discovery procedure. An agent that could supply `D` has already solved every task it needs the hierarchy for. Same circularity as [[wiki/entities/dreamcoder.md]]'s "compress what you already solved" |
| **The task ensemble is fixed, known and uniform** — all shortest-path problems on the graph, edge costs sampled once and held constant | The optimum is defined relative to `𝒯`. Nothing says how an agent estimates `𝒯`, or re-derives the hierarchy when it shifts. The optimality proofs are claimed for arbitrary ensembles; only shortest-path ensembles are computed |
| **Graph must be deterministic, reversible, undirected, tabular** | Every result. Stochastic or irreversible transitions are untested |
| **Implementation is one level deep**, with termination non-zero in a single subgoal state | Tractability restriction only — the framework is claimed to extend to nested hierarchies unchanged, but no deep hierarchy is ever computed |
| **Finding `argmax_M` is a search problem with no guarantee.** Reformulated as binary integer programming over one on/off variable per edge (after Brandes et al.), searched by a genetic algorithm: 2000 individuals/generation, halt after 20 generations without improvement, restarted 1000× (navigation graphs), 500× (Tower of Hanoi), 20× (rooms) | The normative criterion is cheap to *evaluate* and expensive to *optimise*. Any agent using it needs the heuristics it was meant to justify |
| **Symmetric graphs produce ties** — in Exps 2–3 the bottleneck vertex can be assimilated to either region with identical evidence | The criterion does not always return a unique parse |
| **The authors deny humans compute Eq. 3** | Explicitly: the framework says what to approximate, not how. Their own suggested approximator is **predictive statistical learning** — learning to predict future events recovers community structure and bottlenecks on its own, which is the [[wiki/concepts/successor-representation.md]] route |

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| Model `M` | A **partition of the discovered graph** — the same object [[wiki/entities/cscg.md]] gets from InfoMap, now with a score attached |
| Data `D` | The navigation problems the graph will be asked to serve |
| Model evidence | A **label-free score on a decomposition**, computable from the adjacency estimate and the task ensemble alone — no reward, no rollout, no held-out set |
| Bottleneck | Not a primitive: a derived property of the partition that wins |
| Negative transfer | Low model evidence, quantified in trials — options over corner states put mass on behaviours the ensemble never needs |

**(brainstorm)** This is the missing *objective* for `G33`, and it changes what the gap is asking for. The wiki has seven option-discovery families and no way to say which is right; this criterion makes them commensurable — recurrence-based discovery ([[wiki/entities/hisd.md]]), program compression ([[wiki/entities/dreamcoder.md]]) and bottleneck partitioning ([[wiki/entities/cscg.md]]) are all minimising description length, differing only in *what stream* they code (episode symbol strings / solved programs / walks on the adjacency matrix). The interesting prediction is that they should agree wherever those streams carry the same structure and diverge where they do not — e.g. a task graph with a heavily reused corridor that is *not* a bottleneck should be a subgoal for the recurrence families and not for the topological one. Nobody has run that comparison, and this criterion is what would adjudicate it.

**(brainstorm)** The circularity limit is less fatal than it looks if `D` is replaced by a *sample* of solved tasks rather than the full ensemble: the evidence is a per-datum sum (Eq. 3), so it accepts partial data and can be recomputed incrementally as tasks are solved. That makes "when to re-derive the option set" — the scheduling question [[wiki/concepts/temporal-abstraction-options.md]] leaves open — answerable by a stopping rule on the evidence, rather than by the experimenter running the partitioner once offline.

---

## Open problems

- **No online form.** Every evaluation is batch, offline, over a complete ensemble of solved tasks. A learner needs an incremental estimate.
- **When do bottleneck detection and maximum evidence diverge?** Flagged by the authors as open; a graph exhibiting the divergence would be the sharpest test of which one human behaviour tracks.
- **What approximator do humans run?** The predictive-learning hypothesis (successor-like statistics recovering community structure) is proposed and untested against these four experiments.
- **Depth is never selected.** One-level hierarchies only in practice; the criterion in principle ranks nested inventories but nothing here computes one, so the level-count question ([[wiki/concepts/temporal-abstraction-options.md]], [[wiki/entities/cscg.md]]) stays open.
- **Ensemble estimation.** `𝒯` is handed to the criterion. An agent must infer the distribution of tasks it will face, which is a second inference problem of the same size.

---

## Connections

- **[[wiki/concepts/temporal-abstraction-options.md]]** — supplies the objective that page's seven option-discovery families were all groping for: each family is a heuristic search for the option inventory that maximises model evidence, and the page's negative-transfer result (corner options learning slower than flat) is exactly a low-evidence inventory measured in trials rather than in bits.
- **[[wiki/concepts/latent-graph-discovery.md]]** — closes the arrow from a discovered graph to a subgoal set with a *score* rather than a heuristic: given an adjacency estimate and the task ensemble it must serve, the best decomposition is computable from the two with no reward signal and no rollout.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the same two-part-code identity applied to *behaviour* instead of to a symbol stream: the option library is part one, the residual root-level choices are part two, and the hierarchy minimising the total is the one that learns fastest.
- **[[wiki/entities/cscg.md]]** — the built instance of the family this page licenses: InfoMap over a learned clone-structured transition matrix returns room-respecting communities, which this criterion says are near-optimal subgoal boundaries for a shortest-path ensemble rather than merely convenient ones.
- **[[wiki/entities/hisd.md]]** — the rival stream: subgoals from recurrence in an observation corpus rather than from graph topology, minimising a description length over episode symbol strings instead of over walks on an adjacency matrix — same objective, different data, and this page is what would adjudicate them.
- **[[wiki/entities/dreamcoder.md]]** — the same "compress the solved behaviour" move in program space, and it inherits the same circularity this page makes explicit: the criterion needs the solutions before it can score the abstraction over them.
- **[[wiki/concepts/simulation-based-planning.md]]** — the behavioural evidence for how a hierarchical plan is *ordered*: correct-response times are faster for bottleneck probes and equal-length paths are broken by boundary-crossing count, so the region-level route is fixed first and the within-region steps after.
- **[[wiki/concepts/successor-representation.md]]** — the authors' own candidate for the approximation humans actually compute: learning to predict future states recovers community structure and bottlenecks without any model-evidence calculation, which would make the optimal parse a by-product of predictive learning rather than a separate optimisation.
- **[[wiki/concepts/eigenoption-discovery.md]]** — the measurement that puts this criterion's optimum on trial: on the same four-rooms graph a doorway-only option set *raises* random-walk diffusion time above primitive actions, and the Laplacian spectrum finds room centres before doorways (first doorway option is the fifth), so minimising trials-to-discover and maximising state-space coverage select different inventories (`T365`, Machado et al. 2017).
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — the learning signal this criterion presupposes and never supplies: model evidence scores a decomposition whose subtask policies are *already optimal*, and the pseudo-reward prediction error is the term that would train them — so the two are a selection rule plus a gradient with nothing yet joining them, and the joint version would have to price the pseudo-reward against primary reward, which neither source does.
- **[[wiki/concepts/conditioned-reinforcement.md]]** — the term this criterion is missing: model evidence charges nothing for adding a level, while segmenting a fixed interval into two stimuli measurably lowers its value, more strongly for an early cut (2 s / 28 s of 30 s) than a central one — a per-boundary cost with a location dependence the source says no theory of conditioning explains (Leung & Winton 1988).
- **[[wiki/concepts/higher-order-conditioning.md]]** — a second term missing from the score, distinct from the per-boundary cost: adding a level changes the *type* of the representation stored, from an outcome-identity-bearing link to a US-general affective one, so two decompositions with identical model evidence can differ in whether the upper level can name its goal at all (`T395`).
- **[[wiki/concepts/token-reinforcement.md]]** — the currency this criterion should charge in: with responses-per-reinforcer (unit price) held constant and the cost of reaching a redemption opportunity raised, behaviour fell anyway (Bullock & Hackenberg 2006), so a decomposition's price is paid per *redemption episode* and depends on where the cash-out boundaries fall, not on the total work the decomposition implies.
- **[[wiki/entities/option-critic.md]]** — the architecture whose missing objective is this page's: a termination gradient on a single task's discounted return collapses options into primitives, and is kept from doing so by a hand-set `ξ = 0.01` advantage margin — a scalar standing in for the task-ensemble model evidence that says why an option should exist at all (Bacon, Harb & Precup 2017).
