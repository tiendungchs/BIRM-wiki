# Predictive State Representations

**Treat a discrete-time dynamical system as its *system-dynamics matrix* `D`: rows are histories, columns are tests (action-conditioned observation sequences), entries are `p(test | history)`. The rank of `D` is the system's *linear dimension*. A rank-`k` system is modelled exactly by a state made of `k` test predictions, updated by signed linear operators. That class strictly contains every finite hidden Markov model / partially observable Markov decision process (POMDP) and every finite-order Markov model, and a nonlinear state can be exponentially smaller still.**

[[wiki/concepts/causal-states.md]] partitions histories by their conditional futures, for a passive observer. This page keeps the same object, the map from history to predicted futures, and changes two things: it takes the **rank** of that map rather than its **partition**, and it conditions on actions. The result is a state that is a vector of predictions about experiments the agent can run, and it need not be a finite set of nodes.

> **Provenance.** Singh, James & Rudary 2004, *Predictive State Representations: A New Theory for Modeling Dynamical Systems*, UAI 2004, pp. 512–519 (`raw/singh-2004-predictive-state-representations-new-theory-dynamical-systems.md`). Theory paper: theorems and proofs, three toy systems, no learning experiments. PSRs were introduced by Littman, Sutton & Singh 2001 by conversion from POMDPs; this paper re-derives them from `D`. The clip is a `pymupdf4llm` PDF conversion: Figures 1–6 survive only as captions (the float-reset and the 4-state counterexample are recovered from the prose), the proof of Theorem 2 is displaced before its statement, and the update equations (2), (3) and the nonlinear update are garbled. They are reconstructed below from their surviving fragments. Theorem 7 is a proof sketch pointing to Rudary & Singh 2004. The claim that PSRs are easier to learn than POMDPs is made by citation (Shatkay & Kaelbling 1997; Singh et al. 2003; James & Singh 2004) and is not shown here.

---

## Formalism

Setting: discrete time, finite action set `A`, finite observation set `O`. No stationarity assumption. An uncontrolled system is the one-action case.

| Object | Definition | Reading |
|---|---|---|
| **Test** `t` | `a¹o¹ … aᵏoᵏ`; `p(t) = prob(o₁=o¹ … o_k=oᵏ \| a₁=a¹ … a_k=aᵏ)` | An experiment: do these actions, check whether these observations come back |
| **History** `h` | The action–observation sequence since time 0 (a test that has already happened); `φ` = empty history | |
| `p(t \| h)` | `p(ht)/p(h)` | History-conditional prediction |
| **System-dynamics matrix** `D` | `D_ij = p(t_j \| h_i)`, tests and histories ordered by length then lexicographically | **"Not a model of the system but the system itself."** Fully determined by its first row `d = D_φ·`, since numerator and denominator are both entries of `d` |
| Row constraints | `0 ≤ d_i ≤ 1`; `Σ_{t∈T(ā)} p(t) = 1` for each action sequence `ā`; `p(t) = Σ_o p(tao)` | The structure that makes `D` low-rank in practice |
| **Linear dimension** | `rank(D)` | Equals Jaeger's OOM dimension and, uncontrolled, the minimum effective degree of freedom of Ito, Amari & Kobayashi 1992 |
| **Core tests** `Q` | Any `k = rank(D)` tests with linearly independent columns. **Not unique** | The state's coordinates |
| **PSR state** | `p(Q \| h) = [p(q₁\|h) … p(q_k\|h)]`; initial state `p(Q \| φ)` | A sufficient statistic of history made only of observable quantities |
| **Linear read-out** | `p(t \| h) = p(Q \| h)ᵀ m_t` for a fixed weight vector `m_t` per test | Every column of `D` is a fixed combination of the core columns |
| **State update** (eq. 3) | `p(Q \| hao)ᵀ = p(Q \| h)ᵀ M_ao / p(Q \| h)ᵀ m_ao`, where column `j` of `M_ao` is `m_{ao q_j}` | One matrix product and one normalisation per step |
| **Generator** | `m_t = M_{a¹o¹} ⋯ M_{a^{n−1}o^{n−1}} m_{aⁿoⁿ}` | Any column of `D` from the parameters `{M_ao, m_ao}` |
| **Parameters** | `{m_aoq}`, `{m_ao}`; **may be negative** | The difference from a POMDP |
| POMDP, for comparison (eq. 2) | `b(hao)ᵀ = b(h)ᵀ Tᵃ O^{ao} / b(h)ᵀ Tᵃ O^{ao} 𝟏`; `p(a¹o¹…aⁿoⁿ \| h) = b(h)ᵀ T^{a¹}O^{a¹o¹} ⋯ T^{aⁿ}O^{aⁿoⁿ} 𝟏` | Same shape of update, with stochastic, non-negative `Tᵃ` and diagonal `O^{ao}` |
| **Nonlinear PSR** | Tests `N`, `\|N\| < \|Q\|`, with `p(t \| h) = f_t(p(N \| h))` and `f_t` **independent of `h`** | *Nonlinear dimension*: the smallest such `\|N\|` |

---

## The results

| # | Statement | What it means for a model |
|---|---|---|
| **Thm 1** | An `n`-th-order Markov model has linear dimension `≤ (\|A\|\|O\|)ⁿ` | It has at most that many distinct rows of `D`. A matrix of finite rank can have **infinitely many distinct rows**, so finite rank does not imply a finite history window |
| **Thm 2 / Cor 3** | A POMDP or HMM with `k` nominal states has linear dimension `≤ k` | `D = BU`: an `∞×k` belief matrix times a `k×∞` matrix of per-state test predictions |
| Jaeger 1998 (cited, not reproduced) | An uncontrolled system of linear dimension 3 that **no finite HMM** models | Finite linear dimension does not imply a finite hidden state set. With Thm 1: some finite-dimensional systems have no finite POMDP and no finite-order Markov model |
| **Lemma 4, Lemma 5, Thm 6** | Linear PSRs with `k` core tests ⟺ systems of linear dimension `k` | The PSR is exact for the whole class. **Why it beats POMDPs: its update parameters are not constrained to be non-negative** |
| **Float-reset** (Littman et al. 2001) | 5-state POMDP; `float` moves left or right with equal probability and always shows 0; `reset` jumps to the far-right state and shows 1 only if already there; starts far right. Linear PSR needs ≥ 5 core tests, e.g. `{r1, f0r1, f0f0r1, f0f0f0r1, f0f0f0f0r1}`, initial value `[1, .5, .5, .375, .375]`. Under `float` the vector shifts left and the last entry becomes `.0625·p₁ − .0625·p₂ − .75·p₃ + .75·p₄ + p₅`, a signed combination | After the first float, `p(r1\|h)` repeats each value twice and decreases monotonically. So `(p(r1\|h), p(f0r1\|h))` indexes the sequence, and a **2-test nonlinear PSR** exists. The source argues this from the series and does not write `f_t` out |
| **Thm 7** (sketch) | Nonlinear dimension can be **exponentially smaller** than linear dimension. `k`-bit rotate register, only the leftmost bit visible, actions rotate-left / rotate-right / flip: POMDP `2ᵏ` states, linear PSR `2ᵏ` core tests, nonlinear PSR `k+1` | Linear read-out of every future can cost exponentially more state than a compact nonlinear code |
| **Thm 8** | Uncontrolled: interpretable and uninterpretable OOMs of dimension `k` ≡ linear PSRs with `k` core tests | Equivalent in power. The authors report (and omit) efficient conversion algorithms |
| **Thm 9 / Cor 10** | Controlled: a finite-linear-dimension system that **no interpretable IO-OOM of any dimension** models; so PSRs are strictly more general than interpretable IO-OOMs | See next table |

**The Theorem 9 system.** 4-state POMDP. From `s₀`, either action moves to `s₁`, `s₂` or `s₃` with equal probability and emits `oᵢ` on entering `sᵢ`, so every odd step's state is known from history. Every return to `s₀` emits `o₄` or `o₀`, deterministic given state and action: `a` emits `o₄` only from `s₁`, and `b` emits `o₄` only from `s₂`. An interpretable IO-OOM's state is the probability of a partition of tests that **all share one action sequence `ā`**. Under `ā = a`, `s₂` and `s₃` predict identically, so the outcome of `b` is lost. Under `ā = b`, `s₁` and `s₃` are confused. Longer `ā` adds nothing because the system resets to `s₀` every second step. **A state built from one experiment cannot separate what only a different experiment separates.** The source adds that uninterpretable IO-OOMs are not verifiable against data, and Jaeger's IO-OOM learning algorithm works only for the interpretable version.

---

## Rival representations, by what they can model

| Representation | State | Parameters | Models exactly |
|---|---|---|---|
| `n`-th-order Markov | Last `n` action–observation pairs | `\|A\|` matrices `Oᵃ`, `k\|A\|\|O\|` entries | Linear dimension `≤ (\|A\|\|O\|)ⁿ`, and only window-shaped systems within that |
| POMDP / HMM, `k` states | Belief `b(h)` over hidden nominal states | Non-negative `Tᵃ`, diagonal `O^{ao}` | A strict subset of linear dimension `≤ k` |
| **Linear PSR**, `k` core tests | `p(Q \| h)` | Signed `M_ao`, `m_ao` | **Exactly** linear dimension `k` |
| Interpretable OOM (uncontrolled) | Stochastic vector over `k` union-tests of one length `m` | — | Same as linear PSR (Thm 8) |
| Interpretable IO-OOM (controlled) | Stochastic vector over union-tests sharing one action sequence `ā` | — | Strictly less than linear PSR (Thm 9) |
| Nonlinear PSR | `p(N \| h)`, `\|N\| < k` | Nonlinear `f_t` | Same systems, smaller state: 2 vs 5 (float-reset), `k+1` vs `2ᵏ` (rotate register) |
| Causal states (ε-machine), passive stationary case **(brainstorm)** | The class of `h` with identical row `D_h·` | Unifilar labelled transitions | Each distinct row is one causal state, so linear dimension ≤ number of causal states. The float-reset already has infinitely many distinct rows (`p(r1\|h)` takes infinitely many values) at linear dimension 5. A finite ε-machine is itself a finite HMM, so Jaeger's rank-3 system has an **infinite** causal-state set |

---

## What it says for building a reasoning model

| Consequence | Detail |
|---|---|
| **The minimal finite carrier is not always a graph** (`G27`) | A node set is a partition; this page's state is a point in a `k`-dimensional space. Some systems have finite `k` and no finite node set (Jaeger's rank-3 system; Thm 1's infinitely many distinct rows). For those, asking which discretisation to carve has no finite answer, and the finite object is a vector of predictions plus one signed operator per action–observation pair. The non-negativity that makes an HMM's state a probability over nodes is exactly what costs it this class (Thm 6 discussion). **(brainstorm)** [[wiki/concepts/latent-graph-discovery.md]]'s node-set bit then has two values, not one: *carve a partition* or *fit a rank*. The graph exists only when the system's predictive rows fall into finitely many classes |
| **State defined by experiments, identified up to a basis** (`G16`, `G2`) | Hidden nominal states are not a property of the observed process (as on [[wiki/concepts/causal-states.md]]). Core-test predictions are, and any two choices of core tests are related by an invertible linear map, because both span the same column space of `D`. **(brainstorm)** This gives a de-aliasing check that needs no ground-truth latent: two histories are one state for a linear predictor iff their rows of `D` coincide, and a learned model can be audited by regressing its hidden state onto estimated `p(Q \| h)` on held-out histories |
| **Linear read-out of every future has a dimension price** | A linear PSR makes every test prediction a linear read-out of the state. That is [[wiki/concepts/linear-representation-hypothesis.md]]'s premise realised exactly, for *all* futures. Its cost is proved: the rotate register needs `2ᵏ` linear dimensions and `k+1` nonlinear ones (Thm 7). **(brainstorm)** A network trained to predict and found to be linearly decodable for every future quantity must have width ≥ `rank(D)`. A compact network on a high-rank system cannot be linearly decodable for all of them. Probe failures on such systems are then expected, not anomalous |
| **Condition on actions instead of predicting them** (`G63`) **(brainstorm)** | `p(t \| h)` conditions on the test's actions. If the policy depends only on the observable history, `D` is a property of the environment alone. Contrast [[wiki/concepts/causal-states.md]]'s actions-in-the-stream reading and [[wiki/entities/cscg.md]]'s `p(z′, a \| z)`: in both, the identified graph moves with the policy. Estimation still needs data on the core tests' action sequences, so `G63`'s excitation requirement does not vanish. It moves from "every action direction at every state" to "every action sequence in `Q`, from enough histories". A small `Q` makes that a finite, checkable data-collection target |
| **A complete state must hold predictions for experiments not being run** | Thm 9: no single probing action sequence separates all states. The state needs predictions under several *different* action sequences at once, i.e. counterfactual predictions. **(brainstorm)** Read for active perception: an agent whose state only predicts the outcome of its habitual next probe aliases states that another probe would split |
| **`rank(D)` as a model-class-free size** | Thm 1 and Thm 2 bound each model class by the linear dimension. **(brainstorm)** The numerical rank of a finite `D` sub-block estimated from data is a size for a benchmark's hidden structure that does not presuppose nodes, which is a candidate difficulty knob for synthetic latent-structure tasks (`G17`) |

---

## Open problems

- **No learning theory in this paper.** Core-test discovery and parameter learning are cited, not given. The paper offers no estimator of rank from a noisy finite sub-block of `D`, no sample complexity, and no account of history distributions that never visit some rows.
- **Signed parameters have a cost the paper does not price.** **(brainstorm)** The update can produce predictions outside `[0,1]` once parameters are estimated with error, and nothing in the formalism constrains them back.
- **Nonlinear dimension has no general procedure.** The two examples are hand-derived. The authors' stated next step is estimating nonlinear dimension directly from `D`.
- **Finite actions and observations, discrete time.** Continuous sensorimotor streams are outside the theory as stated.
- **Single level.** One `D`, one state. Nothing here produces a hierarchy or a structure shared across systems (`G1`, `G9`).

---

## Connections

- **[[wiki/concepts/causal-states.md]]** — the same history-to-future map read two ways: that page partitions histories by identical rows of `D`, this page takes the rank of `D`. Because rank ≤ number of distinct rows, a process with infinitely many causal states can still have a finite linear state (float-reset). This page also supplies the controlled version that page lists as missing.
- **[[wiki/concepts/latent-graph-discovery.md]]** — contests the framing's carrier: for systems of finite linear dimension with no finite HMM, the exact finite model is a vector of test predictions with signed operators, not a node set. "Discover the graph" then presupposes that the predictive rows fall into finitely many classes.
- **[[wiki/entities/cscg.md]]** — that model is an HMM, so by Thm 2 a pool of `k` clones can model linear dimension at most `k`, with non-negative transitions. It also predicts actions (`p(z′, a \| z)`) where a PSR conditions on them, which is the difference between a policy-dependent and a policy-free identified object.
- **[[wiki/concepts/linear-representation-hypothesis.md]]** — a linear PSR is the hypothesis realised exactly for every future test: each prediction is a fixed linear read-out of the state. Thm 7 puts a price on that premise, `2ᵏ` linear against `k+1` nonlinear dimensions on the rotate register.
- **[[wiki/concepts/learned-world-models.md]]** — a transition design point that page's taxonomy lacks: the latent is pinned to predictions of observable action-conditioned outcomes and updated by a normalised linear operator, so every coordinate has a ground-truth target. Thm 8 makes an uninterpretable linear state equivalent in power to an interpretable one in the uncontrolled case.
- **[[wiki/concepts/successor-representation.md]]** — both represent a state by predictions about its future. The SR row is indexed by the current state and averages over a fixed policy. A PSR state is indexed by the whole history and conditions on actions, so it needs no supplied de-aliased state space and does not go stale when the policy changes.
