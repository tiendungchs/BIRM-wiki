# C-TS — Context–Task-Set clustering, and its nested corticostriatal implementation

**A latent rule is a *cluster over contexts*: an unbounded set of task-sets is grown by a Chinese-restaurant prior, each task-set owning a whole stimulus→action policy rather than a state value — and the same computation falls out of two nested cortex–basal-ganglia gating loops in which the higher loop's prefrontal stripes start with no meaning at all and acquire it only through the actions the lower loop is allowed to take.**

> **Provenance.** Collins & Frank 2013, *Cognitive control over learning: creating, clustering and generalizing task-set structure*, Psychol Rev 120(1):190–229 (`raw/collins-2013-task-set-structure-learning.md`). Three levels in one paper: an approximate nonparametric-Bayesian algorithm (C-TS), a biologically explicit neural network, a quantitative mapping between their parameters, and two human experiments (N=33, N=35) designed from the mapping.

The wiki already carries the allocate-vs-reuse posterior over contexts ([[wiki/concepts/contextual-inference.md]]) and the learned prefrontal gate ([[wiki/entities/pbwm.md]]). This page is where the two meet: it is the wiki's only source in which **a nonparametric clustering prior and a corticostriatal gating circuit are shown to be the same object**, parameter by parameter, and the only one whose clustered unit is a *policy* rather than a scalar.

---

## The algorithm

State is hierarchical by assumption: some input dimensions act as **context** `c_t`, others as **stimulus** `s_t`. A hidden `TS_t` conditions reinforcement:

`P(r_t ∣ s_t, a_t, c_t) = Σ_i P(r_t ∣ s_t, a_t, TS_i) · P(TS_i ∣ c_t)`

| Step | Operation |
|---|---|
| **Prior on structure** | Chinese restaurant process over contexts: a new context joins task-set `i` with probability `∝ N_i` (its popularity **across contexts**, not across trials) and starts a new one with probability `∝ α`, normalised by `A = α + Σ_k N_k` |
| **Selection (a priori)** | Greedy: act under the most probable `TS` given `c_t`. Adding a softmax over task-sets did **not** improve fits to humans |
| **Action** | `Q(s, a_k) = E(r ∣ s_t, a_k, TS_t)`, softmax with inverse temperature `β` |
| **Assignment (a posteriori)** | After the outcome, recompute posterior validity of every `TS_i`, then **collapse onto the mode** — assign the trial definitively to one task-set, update only that one's stimulus–action Beta parameters, and forget the alternative histories |
| **Growth** | On each *first* encounter of a context, add one blank `TS` (uninformative Beta prior) to the candidate set. A blank task-set that is never selected stays blank, so the number of *filled* task-sets does not grow with the number of contexts |

Three approximations, all deliberate, all shared with the neural model: single-particle assignment instead of a particle filter, no backward reassignment of earlier trials, and no trial-to-trial dependence in task-set selection. A large-particle exact filter learns faster and produces the same qualitative pattern.

**The generalized structure model.** Which dimension is context is not given: three experts (C-TS, S-TS, flat) run in parallel and are weighted by predictive validity. It infers C-TS structure over the test phase *and could not have done so had the structure not been built incidentally during training* — the mixture beats every embedded expert on AIC (mean pseudo-`r²` = 0.58 on humans).

---

## The network

Two nested corticostriatal loops, **reinforcement learning at every level** — no supervised signal anywhere, unlike its predecessors ([[wiki/entities/pbwm.md]], Frank & Badre 2011, Rougier et al. 2005, all of which supervise the motor layer).

| Component | Role |
|---|---|
| Context input → **PFC** (fully random connectivity, 3 stripes) | Anterior loop gates one stripe. Stripes are **not** frontal copies of contexts — initially meaningless, they become task-sets only through their effect downstream |
| **PFC × stimulus → parietal cortex** | Multiplexing: the same shape gets a distinct parietal representation per gated stripe. The anterior loop *routes* the stimulus to a destination |
| Parietal → **PMC** loop (4 stripes) | Motor gating, Go/NoGo striatum, GPe/GPi, thalamus, dopaminergic `δ` |
| **Diagonal PFC → motor STN** | Co-active PFC stripes (unresolved task-set) drive STN → global NoGo, so no motor action is gated until the task-set is settled. This is a *sequencing* mechanism between hierarchy levels, not a value mechanism |
| **Diagonal PFC → motor striatum** | Task-set preparation: both actions belonging to the selected task-set are pre-activated *before* the stimulus is processed |
| PFC activation persists across trials | Gives switch costs for free |

The credit-assignment problem is genuinely hard and not papered over: with both loops gating randomly at the start, one scalar error is ambiguous between "wrong task-set" and "wrong action within the task-set". The network nevertheless reaches criterion in **22.1 ± 2.6** repetitions per input — the same order as the humans' **18.6 ± 1**.

---

## Results

| Result | Number |
|---|---|
| **Clustering pays when structure is real** (16 contexts → 2 task-sets) | C-TS builds mean **N = 2.16** task-sets, not 16, and beats flat; robust to 0.2 outcome noise (`N = 2.92`, `t = 9.46`) |
| **Networks discover the clusters** | 75% (147/197) gated a *common* stripe for the two contexts sharing a rule; all networks separated the third. Clusterers learned faster (`t = 9.4`), non-clusterers showed no advantage (`t = 0.3`, n.s.), and within clusterers the proportion of common-stripe trials predicted the advantage (`r = 0.72`) |
| **Positive transfer** | New context C3 signalling an old task-set: >70% of networks re-selected the old stripe despite random initial weights from C3; humans learn C3 faster than C4 (`t = 2.37, p = 0.024`; replicated `t = 2.12, p = 0.036`) |
| **Negative transfer** | New context C4 whose correct policy *overlaps* both old task-sets: humans make significantly more neglect-context errors than either other error type, only in C4 (interaction `F = 3.58, p = 0.03`). Networks recruit a blank stripe less often for C4 than for the fully incongruent C5 (`E(N_new)` = 0.84 vs 0.99; C3 = 0.05) — **partial reward for a wrong rule is worse than no reward at all** |
| **STN is load-bearing** | Lesioning the diagonal PFC→STN projection slows learning from 22.1 to **37 ± 2.3** iterations, purely by letting motor selection run before the task-set is chosen |
| **Structure costs, and it is paid anyway** | The structured solution needs **6 links** (2 context→TS, 2 stimulus→action per TS) where flat needs **4**, and the flat single-loop network learns the task *faster*. Humans build the structure regardless, with no knowledge that a transfer phase exists |

### The level-linking table — the transferable methodology

Each biological parameter was swept and the network's choices refit with C-TS. Every sweep loaded on **one** algorithmic parameter and no other.

| Neural parameter varied | C-TS parameter recovered | Correlation |
|---|---|---|
| Diagonal PFC → motor STN strength | `β_TS` — reliability of task-set selection | `r = 0.62, p = 0.01` (all others `r < 0.33`) |
| Diagonal PFC → motor striatum strength | `ε_TS` — *within*-task-set noise (neglect-stimulus errors) | `r = 0.97, p = 3×10⁻⁴` |
| Context→PFC connectivity (random ↔ one-to-one) | `α` — the clustering prior | `r = 0.76, p < 2×10⁻⁴` |
| Motor corticostriatal learning rate | `n₀` — stimulus–action learning speed | `r = 0.85, p = 0.0008` |

The STN row is the sharp one: STN strength changes *learning speed*, and the fit correctly attributes it to task-set-selection noise rather than to a learning rate. A one-to-one context→PFC wiring **is** a large `α`. So "how strongly does this system prefer to reuse a rule" is a connectivity statistic, not a hyperparameter someone chose — the first mechanistic answer in the wiki to what sets the allocate-vs-reuse knob (gap G38).

### The behavioural read-out that identifies the structure without fitting

Because the asymptotic phase is a self-instructed task-switching experiment, **reaction-time switch cost on a dimension says that dimension is being used as context.** The C-minus-S switch-cost difference, measured before the test phase and never shown to the fitting procedure, predicts the size of each subject's transfer effect (`r = 0.39, p = 0.019`); splitting subjects by it recovers exactly the predicted C-TS / S-TS / flat model-fit ordering. In Experiment 2 the switch cost was computed online and used to *choose* which dimension to make novel at test.

Two further dynamics predicted by the network and confirmed in both experiments:

- Errors after a context switch are predominantly **within**-task-set (neglect the stimulus), not perseverative — the opposite of the standard reading of switch costs, and invisible in the two-alternative tasks the task-switching literature uses, where every error is the same error.
- Neglect-context errors are **faster** than neglect-stimulus errors (`t = 4.08, p < 10⁻⁴`), i.e. fast errors are impulsive re-application of the old rule and slow errors follow a *successful* switch. Hierarchical level is therefore also a **temporal** order within the trial, which is direct evidence on the rostro-caudal-gradient debate (abstraction vs. time) that it is both.

---

## Limitations

| Limit | Consequence |
|---|---|
| No backward reassignment | A trial mis-assigned to the wrong task-set stays mis-assigned; the model cannot retrospectively reorganise learning-phase experience (offered as one explanation of the ambiguous Group 2) |
| Contexts→task-sets assumed stationary | No account of a context whose rule changes; the sticky-transition machinery of [[wiki/entities/coin-model.md]] is absent |
| No trial-to-trial dependence in the algorithm | Cannot do 1-2-AX-style working memory at all; the switch costs come from the *network's* persistent activation, not from C-TS |
| Network learns only about the gated task-set | No counterfactual updating of unselected rules. Tested: restricting C-TS to the same regime cost little, but the task may not be sensitive |
| Clustering prior in the network is minimal | The Dirichlet popularity term is not really implemented — random-vs-organised connectivity is a crude stand-in, and whether humans reuse rules *in proportion to popularity across contexts* is untested |
| Which dimension is context is handed to both models | The mixture-of-experts version infers it, but from a set of three authored structures |

---

## Comparison

| | C-TS | COIN ([[wiki/entities/coin-model.md]]) | PBWM ([[wiki/entities/pbwm.md]]) | Options / hierarchical RL |
|---|---|---|---|---|
| Clustered object | A **policy** (`s→a` map) | A scalar state (force-field strength) | Nothing — stripes are slots | A temporally extended action |
| Prior | Chinese restaurant, `α` | Sticky hierarchical Dirichlet process, `γ, κ, α` | None | None |
| Posterior handling | Collapse to mode, update one | Responsibility-weighted, update **all** | n/a | n/a |
| Hierarchy axis | **Within-trial**, over the state space | Over time | Over stripes | **Across time**, semi-MDP |
| Generalisation to a new context | Reuse an existing cluster | Reuse an existing context | Not addressed | Impossible — options key on identical states |
| Neural implementation | Two nested corticostriatal loops, RL throughout | None | One loop, supervised motor layer | None |

The options comparison is the paper's own and matters for the wiki's planning pages: hierarchical RL structures the **action** space in time, C-TS structures the **state** space within a decision, and only the latter can cluster two different situations onto one policy. In preliminary (unshown) simulations C-TS matched the options framework's advantage on the rooms grid-world.

## Reading in the core framing

| Element | Latent-graph reading |
|---|---|
| Task-set | A meta-graph *fragment* — a subgraph of stimulus→action edges reified as one navigable node |
| Context | An observable that indexes the fragment; the context→TS link is itself a learned, many-to-one edge |
| `α` | The node-creation rate for the meta-graph, and a wiring statistic rather than a chosen constant |
| PFC stripe | A **content-free address** that becomes a rule only through the downstream policy it licenses — the closest thing in the wiki to a rule-node built rather than observed (gap G8) |
| STN global NoGo | A *scheduling* edge: the lower level may not traverse until the upper level has committed |
| Negative transfer | The cost of a wrong retrieval that is *partially* confirmed — the failure mode a responsibility posterior smooths over and an argmax does not |

---

## Open problems

- **The abstract state is created, but not *derived*.** The network answers the half of gap G8 that PBWM does not — a prefrontal representation with no a priori meaning becomes a rule under pure reinforcement — but only because the stripe pool is fixed at three and their contents are defined entirely by downstream consequences. Nothing here scales the pool, names what a stripe means outside the loop, or reads one out.
- **Why build structure at all?** The paper offers three answers and settles none: (i) a long-run bet on generalisation that happens to be right about the world; (ii) structure separates otherwise-interfering conjunctive input representations; (iii) divide-and-conquer — one four-way decision becomes two two-way decisions. Only (iii) is a computational claim about the decision itself, and it is untested.
- **The two levels are not the same computation.** C-TS infers the task-set *a posteriori* including ones it did not select; the network cannot. The paper shows the difference costs little in this task and explicitly declines to claim the network implements the algorithm.
- **Group 2 is unresolved.** A third of subjects showed transfer with no detectable switch cost and no better-than-flat model fit. Either the read-out is insensitive, or they performed *backward* inference at test — retrospectively imposing structure on already-stored flat experience, which neither model can do.
- **Nothing decides the granularity online.** `α` was fit per subject (mean 4.5) and did **not** differ between groups; the individual differences lived entirely in the *structural priors* (which dimension, or none). So the paper measures two knobs and supplies a controller for neither.

---

## Connections

- **[[wiki/concepts/contextual-inference.md]]** — the same allocate-vs-reuse posterior with the clustered object upgraded from a scalar state to a whole policy, and with the inference done by argmax collapse rather than responsibility-weighted mixture ([[wiki/empirical-tensions.md]] T108); it also supplies what that page lists as missing — a neural circuit that approximates a Dirichlet-process mixture, with `α` identified as a connectivity statistic rather than a fitted hyperparameter.
- **[[wiki/entities/coin-model.md]]** — the nonparametric sibling: richer prior (stickiness, hierarchical pooling, non-stationary contexts) over poorer contents (one number per memory), where this model has a bare Chinese restaurant process over contents that are stimulus–action maps.
- **[[wiki/entities/pbwm.md]]** — the direct predecessor, extended in three ways: a second nested loop, reinforcement learning at the motor level too (no supervision anywhere), and prefrontal stripes that are *clustered over contexts* instead of holding items — so what a stripe stores stops being a maintained input and becomes a rule with no sensory content.
- **[[wiki/concepts/cognitive-control.md]]** — the empirical answer to that page's "control is applied when needed": it is applied when it is *not* needed, at a measured price (6 links against 4, slower initial learning), and the payoff arrives only in a transfer phase the subject does not know exists. It also converts that page's task-set row from a recorded baseline shift into a learned, countable latent.
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — the level above an arbitrary edge: several such edges are bundled into one task-set that a *new* context can point at, so the zero-transfer property of an individual cue→action binding does not prevent transfer of the bundle. That is the only route in the wiki by which structureless edges become reusable.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a worked instance of rule-config lifting (hardness 6) in which the lifted variable is discovered rather than supplied, the lifted space stays small because contexts *cluster*, and the cost of lifting is measured (negative transfer when a new situation partially matches an old rule).
- **[[wiki/concepts/meta-learning.md]]** — the two-loop shape realised anatomically rather than in one recurrent net: the slow loop's product is a *library of policies* indexed by context, and the fast operation is selecting one, which is retrieval rather than adaptation.
- **[[wiki/concepts/attention.md]]** — the mixture-of-experts weights over C-TS / S-TS / flat are dimensional attention read as a structural hypothesis: what "attend to colour" buys here is not gain on colour but the decision that colour is the dimension that indexes rules.
- **[[wiki/concepts/simulation-based-planning.md]]** — the within-trial hierarchy that is *not* an option: task-set selection constrains which actions are viable without extending the decision in time, so it fills the state-space half of hierarchy that the options framework leaves out and cannot cluster.
- **[[wiki/concepts/working-memory.md]]** — persistence of the gated prefrontal stripe across trials is the whole source of switch costs here, so a maintenance mechanism is being priced by the *errors* it causes on switch trials rather than by the delay it bridges.
- **[[wiki/concepts/population-geometry.md]]** — the missing measurement: task-set identity here is a discrete stripe, so nothing tests whether the learned abstract states form the parallel, content-invariant coding direction that page's criterion requires.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the anatomical basis of the diagonal projections this model turns into computation: cross-loop convergence between rostrocaudally adjacent cortico-striatal circuits is what lets a higher loop's conflict gate a lower loop's output.
- **[[wiki/concepts/policy-abstraction-hierarchy.md]]** — the human imaging counterpart of this model's nested loops, agreeing that the hierarchical hypothesis is entertained from the outset and disagreeing about what happens when it is not rewarded: there the 2nd-order frontal band withdraws within ~120 trials on a set with no higher-order structure, here subjects keep imposing a hierarchy and pay for it ([[wiki/empirical-tensions.md]] T110).
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the framework this model's authors define themselves against, now paged: hierarchical RL structures the action space **in time** and cannot cluster two different states onto one policy, while this model structures the state space **within a decision** and cannot extend it in time. Their negative-transfer results also differ in kind — a wrongly imposed task-set costs learning speed, a wrong option set can make the optimal path unreachable (Botvinick, Niv & Barto 2009).
- **[[wiki/entities/cn-dpm.md]]** — the shape neither side of T108 had: the same model uses **argmax for the allocate-or-not decision** (a new component is created only when the novel hypothesis is the mode) and a **responsibility-weighted mixture for expression and for updating** (every existing component's gradient is scaled by `ρ_k`), so commit-vs-mix splits by *operation* rather than by model — and unlike this page it reports the resulting retrieval accuracy directly against ground-truth labels rather than inferring it from error types.
