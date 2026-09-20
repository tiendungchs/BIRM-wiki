# Empowerment

**A state is worth being in to the extent that the agent's actions from it can make a *perceptible* difference. Formally, empowerment is the channel capacity of the interventional actuator→sensor channel, `𝔈 := C(Aₜ → Sₜ₊₁) = max_{p(aₜ)} I(Sₜ₊₁; Aₜ)` — a scalar per state, computed from local dynamics alone, with no reward, no goal and no reference to channel meaning.**

> **Provenance.** Salge, Glackin & Polani 2013, *Empowerment — an introduction*, arXiv:1310.1863 (`raw/salge-2013-empowerment-an-introduction.md`). A review of the programme begun by Klyubin, Polani & Nehaniv 2005/2008; every experimental result below is cited by it to a primary source (Klyubin 2005/2008, Anthony 2008/2011, Capdepuy 2007/2010/2012, Jung, Polani & Stone 2011, Salge et al. 2012). No new experiment.

This is the cell [[wiki/concepts/intrinsic-motivation-typology.md]] declares missing: a *competence*-like quantity with no goals, no episodes and no predictor — control capacity rather than knowledge or achievement.

---

## The formalism

| Object | Definition | Note |
|---|---|---|
| Channel | `p(s\|â)`, the **interventional** conditional (Pearl's `do`), not the observed `p(s,a)` | Requires ruling out common causes and any `s → a` influence; otherwise the agent's own policy contaminates the estimate |
| Empowerment | `𝔈 = max_{p(â)} I(Â; S)` | Channel **capacity**, not mutual information: the maximising `p*(a)` is *not* the agent's policy. Empowerment scores *potential* flow the agent need never realise |
| `n`-step | `A = (Aₜ,…,Aₜ₊ₙ₋₁)`, `S = Sₜ₊ₙ` | Open-loop by convention — the whole sequence is an atomic action with no inner structure. `\|A\| = \|𝒜\|ⁿ`, so cost is exponential in the horizon |
| State-dependent | `𝔈(r) = max_{p(a)} I(S; A \| r)` | The map that action selection reads |
| Contextual | `𝔈(K) = Σ_k p(k) 𝔈(k)` for a coarse context `k` the agent can actually resolve | The realistic case: the agent cannot index the true world state |
| Closed form, discrete + deterministic | `𝔈 = log \|𝒮_𝒜\|` | **Empowerment is the log count of distinguishable states reachable in `n` steps.** `H(S\|A)=0`, so capacity is attained by any `p(a)` inducing a uniform distribution over the reachable set |

**Two structural facts worth more than the formula.**

1. **Controllability × observability.** Empowerment is zero if the agent cannot affect the world *or* cannot sense what it affected — the information-theoretic (real-valued, non-manifold) version of the control-theoretic pair. Vanishing empowerment is the formalism's definition of death, which makes death-aversion a derived rather than a stipulated drive.
2. **Resolving states is worth capacity.** `𝔈_free ≤ 𝔈(K) ≤ 𝔈(R)` (Jensen), so there is a **minimal optimal context**

   `K_opt = argmin_{K : 𝔈(K) = 𝔈(R)} H(K)`

   — the cheapest state abstraction that loses no control capacity. This is a state-abstraction criterion derived from the agent's own sensorimotor loop, with no task and no labels.

---

## What it buys: the behavioural record

| Scenario | Result | Why it matters |
|---|---|---|
| Grid maze, `n`-step | `𝔈` is negatively correlated with a location's **average distance to all other locations** (Klyubin 2005) | A quantity computed inside a local `n`-step cone tracks a *global* graph property |
| Box-pushing grid; scale-free random transition graphs | `𝔈` correlates with **closeness centrality** of the state node (Anthony 2008) | The same local↔global claim on an explicit labelled transition graph |
| Box perceivable × box pushable (2×2) | pushable+perceivable: `𝔈 ∈ [5.93; 7.79]` bits, peaked *near the box*; pushable but not perceivable: flat `log₂ 61 ≈ 5.93`; non-pushable: `𝔈` *lowered* near the box, and **identical whether or not it is perceived** | A manipulable object raises empowerment only if sensed; an unaffectable one is worthless to sense. Sensor and actuator repertoires are co-selected by one quantity |
| Sensor evolution (genetic algorithm maximising `𝔈`, small per-sensor cost) | Sensor layout switches *modality*: a 2-D positional "blob" around the world centre collapses into a 1-D **heading** sensor as the agent's start moves far from the centre | Dimensionality and modality of the sensorium fall out of one information quantity with no assumption about either |
| Actuator evolution | Placement is **extremely unspecific** — many configurations tie at maximum | Asymmetry: sensors must match the environment's information structure; actions are the agent's free variable. Motivates *digested information* — another agent's actions are a denser source of relevant information than the environment (Salge & Polani 2011) |
| Multi-agent | Selfish `𝔈`-maximisation produces zero-sum, mutual-gain and Nash-like regimes; a density-sensing swarm self-organises into structures from the tension between needing neighbours to sense and needing space to act (Capdepuy) | Structure from one scalar, no coordination term |
| Pendulum, acrobot, bicycle, mountain-car (continuous) | Greedy `𝔈`-maximisation **swings up and stabilises the pendulum**, including multi-swing swing-ups, learning only *transition dynamics along the path taken* (Jung 2011) | The states a human would designate as goals score high without being designated; no value function over the whole phase space is ever learned |

---

## Computation

| Regime | Method | Cost / assumption |
|---|---|---|
| Discrete, deterministic | `log\|𝒮_𝒜\|` — count the reachable set | Exact, trivial |
| Discrete, noisy | **Blahut–Arimoto**: `p_k^v ∝ p_{k−1}^v exp(d_{v,k−1})`, `d_{v,k} = Σ_s p(s\|r,a_v) log[p(s\|r,a_v) / Σᵢ p(s\|r,aᵢ)p_k^i]`, `𝔈_k(r) = Σ_v p_k^v d_{v,k}` | Expectation-maximisation-type; iterate to `\|𝔈_k − 𝔈_{k−1}\| < ε` |
| Continuous, general | **Binning** | Introduces artefacts that are *pure* (rounding to integers makes a state at 1.5 look more empowered than one at 1.0 with uniform underlying dynamics); too-fine bins drive `𝔈 → log\|𝒜\|` everywhere |
| Continuous, general | **Monte Carlo integration** (Jung 2011): replace `d_{v,k}` by an `N_MC`-sample average, `p(s\|r,a_v) ~ 𝒩(μ_v, Σ_v)` | No bin artefacts; needs an explicit noise model; all published runs were offline |
| Continuous, locally linear | **Quasi-linear Gaussian (QLG)**: assume `S = TA + Z`, `Z ~ 𝒩(0,K_s)`; whiten the noise, SVD `T = UΣVᵀ`, then `C = max_{Pᵢ} Σᵢ ½ log(1 + σᵢPᵢ)` under `ΣᵢPᵢ ≤ P`, solved by **water-filling** | Fast — one SVD of sensor×actuator size. Cannot represent locally non-linear relations, so the *abrupt appearance of a new degree of freedom* (the thing empowerment is best at finding) is smeared by the Gaussian |

The Kraskov–Stögbauer–Grassberger mutual-information estimator, the robust default elsewhere, is **unusable here**: it needs the joint distribution given in advance, while capacity estimation reselects the input distribution each iteration and so feeds its own estimator.

---

## Degeneracies — the part a builder must read first

- **The Tragedy of the Greek Gods.** Whenever one side of the channel dominates, `𝔈` saturates at the *smaller* variable's max entropy for every state, and the landscape goes **flat** — no gradient, no behaviour. Concretely: 100-step empowerment in a 10×10 maze is `log 100` everywhere; an agent that can sense its entire action history is maximally empowered everywhere. **Meaningful structure requires bounded sensing and bounded acting.** No principle currently sets those bounds.
- **Infinite capacity in the continuum.** Noiseless real-valued action and sensing gives infinite channel capacity (a Dirac channel has `h(S\|A) = −∞`). Continuous empowerment is *defined* only relative to an assumed noise level and a power constraint `E(A²) ≤ P` — two free parameters that carry no independent justification.
- **The ranking is not parameter-invariant.** Varying `P` can **invert** the empowerment order of two states, and varying `Δt` trades horizon length against linearisation error. The same world under the same formalism yields swing-up, steady oscillation, or resting at the bottom.
- **Empowerment is not a value function.** Greedy ascent does not optimise any cumulated reward, and `E[𝔈(S)\|a] = Σ_s 𝔈(s)p(s\|a)` is not the empowerment of the averaged dynamics. In the pendulum the greedy trajectory *passes through lower-empowered regions* because the system cannot hold its position; in the maze, where any state can be held by doing nothing, greedy ascent halts at the first local maximum. **Whether local ascent approximates global optimisation is an open question with no characterisation, only the observation that dynamic (non-holdable) systems seem to do better.**
- **The stated contraindication.** If an externally desired goal state is not highly empowered, an empowerment maximiser will not go there. How to combine empowerment with an explicit goal is, in the authors' words, fully open. Whether the agreement between high-`𝔈` states and task goals (pendulum upright, maze centre) is a property of the quantity or of the parameter setting is logged as [[wiki/empirical-tensions.md]] `T363`.
- **Locality is an assumption, not a theorem.** The `𝔈`↔centrality correspondence breaks as soon as the relevant structure sits outside the `n`-step cone (the box-pushing case with a distant box), and no partial characterisation of when it holds exists.

---

## The three hypotheses, separated

| Hypothesis | Claim | Testable as |
|---|---|---|
| **Behavioural** | Absent specific goals, evolved organisms behave *as if* maximising empowerment | Does `𝔈`-driven behaviour match default animal behaviour in analogous situations? The strong version — the organism *computes* `𝔈` — needs a mechanism nobody has proposed |
| **Evolutionary** | Adaptation increases an organism's average empowerment | Evolve agents under an unrelated objective, track `𝔈` over generations; expect useless sensors (blind-cavefish eyes) to be selected away because they carry no capacity |
| **AI** | Empowerment is a task-independent motivation whose behaviour is useful across many later goals | Run it on many tasks, record where the default solution coincides with the intended one — and where it does not |

---

## Open problems

- **No integration with explicit goals.** The formalism has no slot for one, and the authors name this as fully open. Every use of empowerment in a reward-bearing agent is therefore an unprincipled sum.
- **No principle sets the sensor/actuator/horizon resolutions**, and the landscape is degenerate on both sides of the correct setting.
- **No characterisation of when local ascent reaches the global optimum**, nor of when the local↔global (centrality) correspondence holds.
- **Cost.** Action sequences grow as `\|𝒜\|ⁿ`. *Impoverished empowerment* (Anthony 2011) keeps only the few `n`-step sequences contributing most to `𝔈` and re-expands from their endpoints, building long sequences from a skeleton — and a *small amount of noise helps*, because it favours sequences whose endpoints overlap least, i.e. spread over the state space. This is the closest thing in the wiki to a principled generator of macro-actions from dynamics alone.
- **Model uncertainty and true stochasticity are conflated.** A poorly-modelled state looks noisy and therefore unempowered. The authors' own untested hypothesis: if the agent modelled how *learning* would change its own model, empowerment maximisation would generate exploration — which would fold the knowledge-based intrinsic-motivation family into this one quantity. Nothing has tried it.
- **(brainstorm) The permutation test it passes, and the one it fails.** `𝔈` is invariant to relabelling every sensory and motor channel, so it is intrinsic by [[wiki/concepts/intrinsic-motivation-typology.md]]'s criterion. But it is *not* invariant to re-binning or re-parameterising those channels, and empowerment landscapes are demonstrably binning-dependent — so the formalism is invariant to the labels and sensitive to the coordinates, which is the opposite of what a structural objective (`G30`) needs.
- **(brainstorm) Empowerment prices nodes, not edges.** In the deterministic case it is exactly `log` of the `n`-step reachable-set size on the transition graph — a *node* statistic. A graph code needs edge-level constraints (which paths compose), and no empowerment variant expresses one. The complement is worth stating: empowerment is the cheapest state-value in the wiki that requires no reward, no goal and no policy, and a plausible use is not as the objective but as the **default value function to fall back on once the terminal reward has been collected** (`R5`).

---

## Connections

- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — the row that page declares empty: a competence-like drive with no goals, no episodes and no achievement measure, scoring *control capacity* rather than knowledge or performance, and passing the typology's own permutation test while fitting none of its three families.
- **[[wiki/concepts/information-sampling-vs-search.md]]** — an answer for the *search* regime that does not price queries at all: instead of valuing information about an unknown task, it values being in states from which many perceptible outcomes remain reachable, which is terminable and computable precisely because no hypothesis space is enumerated.
- **[[wiki/concepts/epistemic-value.md]]** — the sibling quantity with the arrow reversed: epistemic terms score what an action tells the agent about the world, empowerment scores what the agent's actions can *do* to the world and still perceive — and unlike `E1`–`E4` it needs no belief over a hidden state, only the interventional transition kernel.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a reward-free node score read straight off the transition graph: in the deterministic case `𝔈 = log` (size of the `n`-step reachable set), which correlates with the node's closeness centrality, so a purely local computation ranks states by a global property of a graph the agent never represents — and the failure mode (structure outside the `n`-step cone) is the same horizon limit that bounds every local graph estimator here.
- **[[wiki/concepts/node-definition-problem.md]]** — a criterion for the node set that comes from control rather than from prediction: `K_opt = argmin H(K)` subject to `𝔈(K) = 𝔈(R)` is the coarsest state partition that preserves the agent's capacity to act perceptibly, so two world states must be distinguished exactly when distinguishing them buys control.
- **[[wiki/concepts/network-control-theory.md]]** — the same controllability/observability pair in the other currency: control theory asks the minimum *energy* to drive a linear network to a named target state, empowerment asks the number of *distinguishable* outcomes reachable with bounded action power and no target at all — and both degenerate in the same direction, one through an unusable Gramian inverse, the other through a flat landscape when capacity is unbounded.
- **[[wiki/concepts/successor-representation.md]]** — the policy-dependent counterpart: an SR row is discounted expected occupancy *under the current policy*, while empowerment maximises over the input distribution and so measures what the agent *could* reach rather than what it does reach; the two coincide only for a maximally exploratory policy.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — where impoverished empowerment lands: selecting the few `n`-step sequences that contribute most to capacity and re-expanding from their endpoints is macro-action discovery driven by reachability spread, with noise acting as the term that keeps the selected endpoints apart.
- **[[wiki/concepts/information-bottleneck.md]]** — the shared machinery and the contrast: both are solved by an Arimoto–Blahut-style alternation and both are non-convex, but the bottleneck *compresses* an input subject to preserving information about a target, while empowerment *maximises* the capacity of a channel the agent owns.
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the same "what can I do here" content arrived at without categories: the box experiments show empowerment rises near a manipulable object only if it is also perceivable, which is an affordance detected as a change in channel capacity rather than as a learned category.
- **[[wiki/concepts/homeostatic-need-signal.md]]** — the drive empowerment is proposed to sit *beside*: a need signal is defined over a named channel and is satiable, empowerment is channel-agnostic and unsatiable, so an agent with both has two incommensurable currencies and the formalism supplies no exchange rate.
- **[[wiki/concepts/expected-value-of-control.md]]** — the price term to this page's capacity term, with the opposite sign: empowerment scores what a state's actuators can achieve and is climbed, `Cost(signal)` scores what the controller must spend and is subtracted — an agent holding both has a capacity and a price that no source in the wiki places on one axis.
- **[[wiki/concepts/eigenoption-discovery.md]]** — the rival reward-free source of macro-actions, differing in what is scored: empowerment ranks *states* by control capacity and grows action sequences from the highly-empowered ones, eigenoptions rank *directions* by graph frequency and take each one's optimal policy — and where this page's landscape can flatten or invert with resolution, horizon and action power (`T363`), the eigenvector ordering is fixed by the graph alone (Machado et al. 2017).
- **[[wiki/entities/diayn.md]]** — this page's capacity objective applied one level up, as that source states outright: maximising `I(S;Z)` between the skill index and visited states is the empowerment of a hierarchical agent whose action space is the skill set, so DIAYN manufactures the macro-action alphabet whose absence makes `n`-step empowerment degenerate — and inherits the same complaint, that reachability is ranked and worth is not.
