# Exact Coarse-Graining — Predictable Levels of Irreducible Systems

**A coarse model `B` of a deterministic local system `A` is exact when projecting and then running `B` gives the same result as running `A` and then projecting, `P·f_A^T = f_B·P`, for every initial condition. Many cellular automata (CA) admit such projections, including computationally universal ones, so a system that is undecidable at the cell level can be decidable at a coarse level. The supercell rule's Kolmogorov complexity falls toward zero as block size grows, and the probability that a projection exists rises toward one. Coarse levels are then "forced on the system by the lack of information" in its rule.**

[[wiki/concepts/computational-closure.md]] states when a coarse level is self-contained for a stationary stochastic process. This page is the deterministic, local, all-initial-conditions version with a search procedure attached. It adds three things that page lacks: a split between *relevant* and *irrelevant* discarded detail, a measured rate at which closed levels appear with scale, and a direct answer to computational irreducibility: a bounded predictor does not have to simulate the micro level when a closed coarse variable exists.

> **Provenance.** Israeli & Goldenfeld 2006, *Coarse-graining of cellular automata, emergence, and the predictability of complex systems*, arXiv nlin/0508033 (published as Phys. Rev. E 73:026203; the venue is not in the clip) (`raw/israeli-2006-coarse-graining-cellular-automata-emergence-predictability.md`). The paper combines an exhaustive and heuristic search over one-dimensional CA with an algorithmic-information argument and statistics over random rule tables. The analytical step stops at an upper bound, and the rest of Section V is numerical. The clip is ar5iv HTML. Figures 2–9 survive only as image links with "Refer to caption"; their content is recovered from the prose. Multi-line equations are split into fragments, and the in-text equation numbers ("Eq. (19)", "Eq. (33)") are ar5iv anchors. The 3-SAT result in the discussion is cited as unpublished.

---

## Formalism

Setting: CA `A = (a(t), {S_A}, f_A)`, one dimension, nearest neighbour, `a_n(t+1) = f_A[a_{n−1}, a_n, a_{n+1}]`. Wolfram's 256 elementary CA (ECA) are the binary case.

| Object | Definition | Reading |
|---|---|---|
| **Projection** | `b_k = P(a_{Nk}, …, a_{Nk+N−1})`, `P : {S_A}^N → {S_B}`, irreversible | One supercell of `N` cells becomes one coarse cell. Information is lost only here |
| **Commutativity** (Eq. 1) | `P·f_A^T·a(0) = f_B·P·a(0)` for **every** `a(0)`; iterated, `P·f_A^{T·t} = f_B^t·P` | Running `A` for `T·t` steps and projecting equals projecting and running `B` for `t` steps |
| **Supercell CA** `A^N` | Alphabet `{S_A}^N`; `f_{A^N} : (S^N)³ → S^N`, computed by running `A` for `N` steps on every `3N`-cell configuration | Lossless re-blocking that fixes `T = N` and keeps `B` nearest-neighbour |
| **Construction** (Eq. 3) | `f_B[P(x₁),P(x₂),P(x₃)] = P(f_{A^N}[x₁,x₂,x₃])` | `f_B` is defined by projecting the arguments and the outcome |
| **Single-valuedness** (Eq. 4) | `P(f_{A^N}[x]) = P(f_{A^N}[y])` whenever `P(x_i) = P(y_i)` for all `i` | The whole test. If it fails, `f_B` is multi-valued and that `(N, P)` fails |
| Matrix form (Eq. 5) | `P·A^N = B·P₃` | `S_B·(S^N)³` constraints on `S^N` free parameters: greatly over-determined, so solutions should be rare for a random `A^N` |
| **Compact-able** | Has a coarse-graining (phase-space reduction), decidable or not | |
| **Predictable** | Decidable, or has a decidable coarse-graining | Some coarse aspect can be computed by an algorithm shorter than both the native and the coarse description |

Exactness is required. CA have no small parameter, so there is no perturbative scheme, and an approximate solution of Eq. 1 has no natural meaning here.

### Relevant vs irrelevant degrees of freedom

| Kind | Condition | Effect of swapping `x ↔ y` (same projection) in `a(0)` | What the coarse CA keeps |
|---|---|---|---|
| **Irrelevant DOF (Degrees Of Freedom)** | `f_{A^N}[x] = f_{A^N}[y]` whenever `P(x_i) = P(y_i)` (implies Eq. 4) | The micro difference **decays** within a few steps | **Every** long-time trajectory. The Wolfram class is unchanged |
| **Relevant DOF** | Eq. 4 holds while the line above fails | The micro difference persists, often **unbounded in space and time**, and the projections stay identical | Only the projected aspect. The class **can drop**. What counts as "redundant" now depends on the chosen description |

The authors' analogy: near two limit cycles, irrelevant-DOF coarse-graining maps every initial condition to its cycle. With two strange attractors, sensitivity rules that out, and relevant-DOF coarse-graining keeps *which attractor* while discarding the trajectory.

### Two search procedures

| Strategy | Procedure | Coverage |
|---|---|---|
| **Maximal loss** | Project back onto the binary alphabet: `2^{2^N} − 2` non-constant `P` | Exhaustive for `N ≤ 4`. A smaller `S_B` makes each pairwise constraint easier to satisfy (violation probability `1/2` at `S_B = 2`), at the cost of keeping less |
| **Minimal loss (seed and close)** | Merge one seed pair `z₁, z₂`. Whenever `P_n(x_i) = P_n(y_i)` but `P_n(f_{A^N}[x]) ≠ P_n(f_{A^N}[y])`, merge the two outputs `r₂` into `r₁`'s class. Repeat until Eq. 4 holds. Non-trivial iff the result is non-constant | Trying every seed pair is **guaranteed** to find a valid projection at scale `N` if one exists. The output is often a many-coloured, non-elementary CA |

---

## Results on one-dimensional CA

| Rule (class) | Coarse-graining | What it shows |
|---|---|---|
| **240 / 256 ECA** | Coarse-grained at some `N`, `P`, with members of all four classes. Not found: rules **30, 45, 106, 154** and their symmetries (16 rules; 30/45/106 class 3, 154 class 2). The authors suspect computing limits | Exact coarse levels are common among structured rules |
| Additive rules 0, 60, 90, 102, 150, 170, 204, 240 (`αx_{n−1} ⊕ βx_n ⊕ γx_{n+1}`) | Each coarse-grains to **itself** | Fixed points of the flow. In any dimension, additive CA with prime alphabet size do the same (Barbe et al.) |
| 128 (class 1) | `N = 2`, `P` = "both black" → rule 128 | Scale invariance |
| 105 (class 2) | `N = 2`, `P` = "pair equal" → **rule 150** | Extended regions survive and the black–white decoration is dropped. 150 is a fixed point, so 105 coarse-grains to every scale |
| **146 (class 3)** | `N = 3`, `P` = "all three black" → **rule 128 (class 1)** | Relevant DOF: swapping `□■□ → □■■` gives an unbounded, complex difference with identical projections. Phase space and complexity are both reduced |
| 146 | `N = 6` → 62-state CA; alphabet reductions at `N = 6…11`: 2/64, 9/128, 33/256, 97/512, 261/1024, 652/2048 | **Irrelevant** DOF only: the swapped difference decays within a few steps |
| 184 (traffic) | `N = 2`, local car density → 3 states (empty / free flow / jam). At larger `N`: `k²/2 + 3k/2 + 1` states for `N = 2k`, `k² + 3k + 2` for `N = 2k+1` (empirical) | The coarse states are a partition of local density, not density itself. Mostly relevant DOF |
| **110 (class 4, universal, undecidable)** | `N = 6` → 63 states; reductions at `N = 7…12`: 6/128, 22/256, 67/512, 182/1024, 463/2048, 1131/4096 (irrelevant DOF only) | Fraction removed grows with `N` |
| 110 | **→ rule 0** via "Garden of Eden" blocks: `□■□■□` at `N = 5`, and a 13-cell block at `N = 13` that can appear only in the first 12 steps | The only proven undecidable → decidable transition found among ECA. The decidable aspect is **trivial** |
| 110, Garden of Eden statistics | The fraction of `2^N` blocks that are Garden of Eden grows almost linearly with `N`, and every scale has new ones containing no smaller one. A supercell table restricted to reachable blocks is ≈ 3% of the full table at `N = 21` | Constant-factor speed-up per scale, not decidability ("superficial reducibility" unless the curve tends to 100%) |
| Lindgren–Nordahl 7-state / 4-state, Wolfram 19-state universal CA | With some completions of their free table entries → trivial (rule-0-like) CA | Same as 110 → 0 |
| **Albert–Culik 14-state universal CA**, free entries filled with copy `f = x_n` | Many transitions to decidable **copy** CA. At `N = 2`, a 4-state copy CA | The coarse level tracks **three types of persistent structure** and nothing else: a non-trivial decidable level of a universal system |

**Coarse-graining hierarchy.** Transitions are transitive (`A →_{N₁} B →_{N₂} C ⇒ A → C` with `N ≤ N₁N₂`), and apparent rule complexity **never increased** along any transition found. That gives a partial order on rules, which is well defined where Wolfram's classes are subjective. It can split a class: rule 128 sits above rule 0 within class 1. It is neither topological (trajectory-based) nor parametric (Langton's `λ`). It is algebraic: `A ⪰ B` when some coarse aspect of `A` is the full dynamics of `B`.

---

## Why closed levels are common: the Kolmogorov argument

| Quantity | Value | Reading |
|---|---|---|
| Table size of `f_{A^N}` | `S^{3N}·N·log₂S` bits | Grows exponentially with `N` |
| Program generating it | `L̃ ≈ S³·log₂S` bits (the table of `f_A` plus loops) | Constant in `N` |
| **Normalised complexity bound** | `K(f_{A^N}) ≤ K̃ = N^{−1}·S^{3(1−N)} → 0` | Large-scale rules carry the information of the cell rule spread over an exponentially larger table |
| Base rate | At `N = 2`, ≈ 1/3 of ECA project to a binary alphabet; a **random** 4-colour CA projects once per ≈ 1.6 × 10⁷ tries | Supercell rules are far from random |
| **Garden of Eden scaling** | `R_ge(N,S)` = fraction of rules whose `A^N` misses a state (10,000 rules per point). Collapses onto `ξ = K̃·C^S`, `R_ge = 1/(1 + (ξ/ξ₀)^α)`, `α ≈ 0.7` | Any missing state gives a trivial projection to rule 0 |
| **Emergent scale** | Slope at the transition grows as `log S`, so at large `S` `R_ge` is a step at `N_c(S) ~ S/log S` | A length scale present in no rule. Measure-one of all CA coarse-grain to rule 0 at `N_c` |
| Bounded-`K` random rules | First `l` bits random, the rest generated by a random `G : {0,1}^l → {0,1}`; `K̄ = (l + 2^l)/(S³log₂S)` | A controlled knob on rule complexity (tight only for small `l`) |
| **Projection probability** | `R_proj` (10,000 rules; 200 at `S = 32`) collapses on `ξ = K̄·C^S`, `C = 1.02`, same form with `α ≈ 1`. It holds also when `P` is restricted to **equal partitions**, which excludes the trivial Garden of Eden projections; the transition shifts slightly | Projection probability → 1 as `K̄` → 0. The emergence scale depends on the type of pattern sought |
| Complex fraction | Rules labelled complex (class 3/4 plus complex perturbation sensitivity), 100 per `(S, l)`: depends on `l` only, not `S` | Supports Dubacq et al. (low-`K` tables → simple behaviour). Larger alphabets turn complex at lower `K̄`, so many projectable rules are complex, more so as `S` grows |
| 3-SAT (unpublished) | Instances deep in the unsatisfiable region but built by generating functions are satisfiable with the same universal function of `K` | The `K`-driven collapse may hold for over-constrained problems in general |

Authors' conclusions: undecidability and computational irreducibility are poor measures of *physical* complexity, which should be judged on the coarse degrees of freedom that matter. On objectivity they side with Shalizi & Moore ([[wiki/concepts/emergent-macrostates.md]]): the system fixes the set of valid projections, and the observer chooses among them.

---

## What it says for building a reasoning model

| Consequence | Detail |
|---|---|
| **An irreducible world can still be predictable at the level the agent cares about** | Rule 146 (class 3) has an exact class-1 coarse level, and the Albert–Culik universal CA has an exact decidable level tracking its persistent structures. **(brainstorm)** For a bounded predictor ([[wiki/concepts/resource-rationality.md]]), the question for each target variable is whether a closed coarse variable exists that predicts it, not whether the world is reducible. Simulating the cell level is the fallback, and its cost is what the coarse level saves |
| **Persistent structures are a candidate closed variable** **(brainstorm)** | In the one non-trivial universal case, the closed level is exactly the inventory of persistent structures. That points to object-like units (things that persist and move) as where exact coarse dynamics live in rich systems. It is one example, with the free table entries chosen to be copies |
| **Relevant vs irrelevant merges as an instrument** **(brainstorm)** | For any learned abstraction with simulator access: take two micro states the abstraction maps to the same code and evolve both. If the micro difference **decays**, the merge was irrelevant (lossless for the future, so the micro states were one causal state, [[wiki/concepts/causal-states.md]]). If it **persists while the codes stay equal**, the abstraction is a genuine relevant level. If the codes **diverge**, it is not closed. Three outcomes from one paired rollout, with no labels |
| **Mapping onto closure** **(brainstorm)** | Eq. 1 for every initial condition is computational closure in its automaton form ([[wiki/concepts/computational-closure.md]] Def. 5). For deterministic dynamics, holding for every initial distribution makes the partition a congruence of the transition map, the deterministic case of strong lumpability. It is stronger than closure in two ways: the coarse rule must also be **local** (radius 1 in supercells) and **translation-invariant**. Irrelevant-only coarse-grainings lose nothing about the future (`Δ ≈ 0`, the computational-equivalence case), which matches their unchanged Wolfram class |
| **A level-discovery algorithm for discrete learned dynamics** **(brainstorm)** | Seed and close is the coarsest congruence containing a seed pair, computed by union–find. Run on a learned deterministic transition table (a discrete-latent world model), it lists every exactly closed coarse alphabet at a given block size. Cost: `O(S^{2N})` seeds × a `(S^N)³` table, exponential in `N`; the source hit the wall at `N ≤ 4` for binary sweeps. The Kolmogorov argument suggests the escape: keep the compact cell rule and generate supercell table entries on demand |
| **Where to look is predictable from the rule's description length** **(brainstorm)** | Closure probability is a universal function of `K̃·C^S` with a sharp step at large `S`. So the scale at which closed levels appear is set by the micro rule's information content, a scale **prior** instead of an authored band edge (cf. `G67`, which asks the same about timescales; here `T = N` ties time to space). The caveat is that the cleanest scaling result counts trivial Garden of Eden projections |
| **Simplicity of the generator guarantees that abstractions exist** **(brainstorm)** | A world produced by a short local rule cannot be complex at large scale: the large-scale rule is too compressible. That is the existence half of the bet [[wiki/concepts/simplicity-principle.md]] makes on the learner's side. If the generator is simple, there are coarse levels for a simplicity-seeking learner to find |
| **A difficulty order for rule-based tasks** **(brainstorm)** | The coarse-graining hierarchy orders rules by "some coarse aspect of `A` is all of `B`". Task suites built from CA rules could be stratified on it rather than on Wolfram class, which is subjective and coarser |

---

## Open problems

- **Exact and deterministic only.** No approximate version: probabilistic CA, coupled maps and partial differential equations are named as future work. A learned model never satisfies Eq. 1 exactly, and nothing here says what an almost-commuting projection buys (the quasi-lumpability gap on [[wiki/concepts/computational-closure.md]]).
- **The rule must be known, so the first alphabet is still not supplied** (`G27`). Every search runs on `f_A`. Learning `f_A` from observed trajectories, and how estimation error propagates through `f_{A^N}`, are not addressed.
- **Search is exponential in `N`.** Binary projections number `2^{2^N}`, and the supercell table has `S^{3N}` rows.
- **The `K` → projection link is empirical.** `K̃` and `K̄` are upper bounds, and the data collapse is a fit. The conjecture is stated as unproved.
- **Trivial vs non-trivial closure is not separated by a measure.** Rule 110 → 0 counts as decidable. The equal-partition restriction removes Garden of Eden cases but not other low-information projections. Theory-space deduplication ([[wiki/concepts/computational-closure.md]]) is the missing filter.
- **No selection among valid projections.** The system supplies a set and the observer picks, with no stated criterion (as on [[wiki/concepts/emergent-macrostates.md]] and [[wiki/concepts/computational-closure.md]]).
- **Monotone complexity is observed, not proved.** "Apparent complexity" is judged by eye over the transitions found with `N ≤ 4`.
- **Generic or exceptional?** Rosas et al. call lumpability "the exception and not the rule" over coarse-grainings of one system. Here, over systems, a closed coarse-graining exists with probability → 1 at large enough scale. The two counts differ in quantifier (most partitions fail; most rules have at least one that succeeds), so they are compatible. For a builder this means the cost lies in **finding** the projection, not in whether one exists.
- **16 ECA unresolved** (rules 30, 45, 106, 154 and symmetries).

---

## Connections

- **[[wiki/concepts/computational-closure.md]]** — the stochastic, stationary counterpart: Eq. 1 is that page's automaton-form computational closure, required for every initial condition and with a local, translation-invariant coarse rule. This page supplies a search procedure, the relevant/irrelevant split and the rate at which closed levels appear with scale. That page supplies the theory-space filter that would separate this page's trivial Garden of Eden levels from non-trivial ones.
- **[[wiki/concepts/emergent-macrostates.md]]** — the observer-side companion the authors cite for their objectivity position: the system fixes which projections are valid and interest picks among them. Irrelevant-DOF merges are that page's case 3 (distinctions that make no difference to the future). Relevant-DOF merges are the lossy levels that page's emergence criterion would rank.
- **[[wiki/concepts/causal-states.md]]** — an irrelevant-DOF merge joins micro blocks whose futures coincide after a few steps, so it is a causal-state merge in a deterministic setting **(brainstorm)**. A relevant-DOF merge joins states with different futures and so is a coarser level, not a better estimate of the ε-machine.
- **[[wiki/concepts/simplicity-principle.md]]** — the generator-side half of the same bet: a short local rule forces its large-scale rule toward zero Kolmogorov complexity (`K̃ = N^{−1}S^{3(1−N)}`), and the probability of an exact coarse level rises with it. So a simple world guarantees that the coarse structure a simplicity-seeking learner looks for exists.
- **[[wiki/concepts/resource-rationality.md]]** — computational irreducibility sets the cost of predicting the micro level at the cost of running it. A closed coarse variable is the cheaper program a bounded-optimal predictor should look for first, and rule 110's Garden of Eden table (≈ 3% of full size at `N = 21`) is a constant-factor saving of that kind.
- **[[wiki/concepts/mean-field-reduction.md]]** — the continuous, approximate ladder beside this exact, discrete one: each rung there discards a named moment and is not closed (moment coupling), while each transition here is exact and its discarded detail is labelled relevant or irrelevant by a paired-rollout test.
- **[[wiki/concepts/abstraction-graph.md]]** — **(brainstorm)** the paired-rollout test is the one instrument for that page's per-concept error register (row 4): two micro states sharing a code give three outcomes, irrelevant merge, relevant level, or not closed. The relevant/irrelevant split is what lets that page keep `ε` to one quantity, the edge's closure error, and put the discarded fine-state detail on the node as its grain attribute (the unprocessed information `Δ`).
