# AIXI

**A parameterless universal agent: sequential decision theory (expectimax over future reward) with the unknown environment prior `µ` replaced by the universal semimeasure `ξ`.** Uncomputable. The wiki's formal ceiling for [[wiki/concepts/latent-graph-discovery.md]].

> **Provenance.** Hutter 2000, *A Theory of Universal Artificial Intelligence based on Algorithmic Complexity*. Claims of optimality are the source's own and are explicitly *argued*, not proved — the paper states repeatedly that it cannot even specify what a general optimality theorem should say.

---

## Architecture

| Component | Specification |
|---|---|
| **Interface** | Chronological Turing machine `p` (agent) coupled to `q` (environment). Cycle `k`: agent writes action `y_k`, environment replies `x_k = c_k x'_k` — a regular observation plus a real-valued credit |
| **Objective** | Maximize the credit sum `C_{k:m_k}`, *not* the next credit. Greedy maximization is provably wrong for active environments |
| **Horizon `m_k`** | A dynamic farsightedness parameter; the model's only remaining arbitrariness |
| **AIµ** (known prior) | `ẏ_k = argmax_{y_k} Σ_{x_k} max_{y_{k+1}} … Σ_{x_{m_k}} (c_k + … + c_{m_k}) · µ(ẏẋ_{<k} yx_{k:m_k})` — plain expectimax; optimal by construction |
| **AIXI** | The same expression with `ξ(yx_{1:n}) = Σ_{q : q(y_{1:n}) = x_{1:n}} 2^{−l(q)}` in place of `µ` — a `2^{−(program length)}`-weighted mixture over all computable environments |
| **Equivalent form** | `ξ ≐ Σ_ρ 2^{−K(ρ)} ρ`, summed over all enumerable chronological semimeasures — the mixture-over-deterministic-programs and mixture-over-probabilistic-environments views coincide up to `O(1)` |

Two structural facts: the model has **no learning algorithm** (conditioning the mixture is the learning), and **no separate meta-level** (the two-level hierarchy of [[wiki/concepts/latent-graph-discovery.md]] is absorbed into the environment posterior rather than represented).

---

## Key results

| Result | Statement |
|---|---|
| **Universality** | `ξ^AI(x) ≥ 2^{−K(ρ)} · ρ(x)` for every enumerable chronological semimeasure `ρ`: within a constant of every computable environment model at once |
| **Convergence** | `Σ_k ⟨(µ − ξ)²⟩ ≤ ln 2 · K(µ)`, hence `ξ → µ` with `µ`-probability 1; extends to bounded horizons `ξ(yx_<k yx_{k:k+h}) → µ(…)` |
| **Intelligence order relation `⪰`** | `p ⪰ p'` iff `p` yields higher `ξ`-expected credit in every history. AIXI is maximal under `⪰` **by construction**; whether `⪰` is a *reliable* intelligence order is stated as an open conjecture |
| **Problem-class coverage** | Sequence prediction, strategic games (reduces to minimax against a minimax opponent, and exploits sub-rational opponents), function minimization, supervised learning, classification — each formulated inside the model and shown equivalent to its purpose-built optimal solver |
| **Supervised learning is emergent** | Never designed in; AIXI learns to exploit demonstrations within `O(1)` cycles, because the relation is already compressed into the program predicting the example stream ([[wiki/concepts/universal-induction.md]]) |
| **Exploration is forced** | In the optimization setting, the assumption that the agent tests only finitely many candidates is refuted — the mixture assigns strictly positive probability to any untested candidate being better |
| **Prior knowledge is injectable** | Presenting knowledge `z` in cycle 1 replaces `K(µ)` by `K(µ\|z)` in the bounds — "the boundary between implementation and training is unsharp" |

---

## Limitations

| Limitation | Detail | Consequence for the wiki |
|---|---|---|
| **Uncomputable** | `ξ` and the value are only *enumerable* — approximable from below, with no way to know the limit has been reached, and extremely slowly | Every real architecture is a bounded approximation; the ceiling is unreachable, not merely expensive |
| **No credit bounds in the active case** | Bounds in terms of `K(µ)` exist for prediction and provably **cannot** exist for general agents (Heaven & Hell; the needle construction) | Gap G25: for active environments there is no certificate of optimality — for AIXI or anything else |
| **Horizon is arbitrary** | Known lifetime `T` is unavailable in practice; exponential discounting introduces a timescale `1/λ`; `k^{−α}` introduces a dynamic one; `h_k = β·k` limits farsightedness to a multiple of elapsed time. `m_k → ∞` is definable but *misbehaves*: the paper's own example has AIµ postpone the switch to the rewarding action forever and score zero | Gap G24. The depth-of-rollout question of [[wiki/concepts/simulation-based-planning.md]] is unresolved at the *ideal* level, not just the practical one |
| **`ξ` is only a distribution over inputs** | Not over the agent's own outputs — the reason error bounds do not transfer from prediction to action, and why AIXI does not reduce to the universal predictor even on prediction tasks | Self-model is asymmetric: an agent's own policy is not part of its world model |
| **Reference-machine dependence** | `l(q)` is defined only up to an additive constant | At finite horizons the "unbiased" agent still carries a bias |
| **Incompressible evolutionary knowledge** | The source's own strongest objection: if evolution encoded something like Chaitin's `Ω` into the genome, human competence is not reachable from an `O(1)` program and no simple formal definition of intelligence is possible | The strongest available argument *for* [[wiki/concepts/core-knowledge.md]]-style installed priors, raised by an opponent of them |

---

## Separability hierarchy — the vocabulary for "which environments are learnable"

Because no bound holds for arbitrary `µ`, guarantees must be relativized to structural conditions on the environment. The source's classes, roughly decreasing in generality:

| Class | Condition | Relevance |
|---|---|---|
| **Relevant** | Excludes pathological `µ` "irrelevant from the perspective of AI" | Frankly informal; the escape hatch in the asymptotic-optimality claim |
| **Asymptotically learnable** | Probability of deviating from the informed agent's action → 0 | The optimality notion the paper actually claims: count each bad decision *once*, on the history the agent itself generated, rather than charging it the full lost credit |
| **Farsighted** | `lim_{m_k→∞} ẏ_k` exists | Without it, no horizon-free policy is even well defined |
| **Forgetful** | Dependence on `yx_{<l}` vanishes as `k → ∞` | What makes bounded context admissible |
| **Uniform** | `ξ → µ` convergence holds uniformly over *counterfactual* actions and credits, not only the realized ones | Sufficient for asymptotic optimality at bounded horizon — and the paper concedes relevant environments violate it |
| **(Generalized) Markovian** | Dependence only on the last (or last `l`) interactions | The assumption almost every practical architecture makes |
| **Stationary** | Markovian with `µ_k ≡ µ_1` | |
| **Factorizable / (pseudo) passive** | Independent episodes / environment unaffected by the agent's outputs | The only classes where `K(µ)`-style bounds actually hold |

**Why this matters here.** The wiki has been scoring architectures by which *hardness sources* they reach. This table supplies the complementary axis: which *environment assumptions* an architecture must buy to obtain any guarantee at all. Hardness source 6 (non-stationary topology) is the statement that useful domains sit above the Markovian line; the uniformity result says the guarantee machinery stops working right about there.

---

## AIXItl — the computable reduction

The construction that makes the ceiling finite, at absurd cost.

1. Enumerate all binary strings of length `≤ l_P`, keep those that are proofs of `VA(p)` — the **valid approximation** predicate: `p` outputs both an action `y_k` and a self-assigned lower bound `w_k` on its own expected credit, and *never overrates itself* (`w_k ≤ C_{k:m_k}(p)`).
2. Discard programs longer than `l̃`; force a stop after `t̃` steps per cycle (`w_k := 0` on timeout).
3. Each cycle, run all surviving programs and emit the action of the one claiming the highest `w_k`.

| Property | Value |
|---|---|
| Size of `p*` | `O(ln(l̃ · t̃ · l_P))` |
| Setup time | `O(l_P · 2^{l_P})` — dominates, and `l_P ≫ l̃` |
| Time per cycle | `O(2^{l̃} · t̃)` |
| Guarantee | Effectively more intelligent (under `⪰^c`, the order induced by *claimed* credit) than **any** agent of length `≤ l̃` and per-cycle time `≤ t̃` whose validity has a proof of length `≤ l_P` |

**The transferable idea is the selection criterion, not the enumeration.** Dovetailing all short programs is folklore; what is new is scoring candidate policies by a **self-justification they must prove** — an action is only as good as the credit bound its author can certify. Two consequences:

- The guarantee only covers policies that *can* justify themselves. A policy that acts well but cannot prove a high `w_k` — or whose proof is longer than `l_P` — is not dominated. The source explicitly doubts that good behaviour is ever fully separable from some justification process, but concedes the justification may not be translatable into a credit bound in reasonable time.
- **(brainstorm)** This is the one part of AIXI that scales down to a buildable mechanism: require a reasoning model to emit `(action, certified lower bound on value)` pairs and select on the bound. Verifier-scored candidate generation is the same shape, with a learned verifier replacing the proof checker — and it inherits the same failure mode (unverifiable-but-correct proposals are discarded).

Also noted: an inconsistent policy must be able to *continue a strategy started by another policy*, which the source flags as problematic outside episodic (factorizable) environments — swapping controllers mid-episode is not free.

---

## Scoring against the six hardness sources

From [[wiki/concepts/latent-graph-discovery.md]]. AIXI is the reference row of that table.

| Hardness source | AIXI | AIXItl |
|---|---|---|
| 1. Two-level entanglement | ✓ absorbed into the posterior — but *not factorized*, so nothing is transportable | ✓ same, within `l̃` |
| 2. Unknown vocabulary | ✓ mixture ranges over all computable observation/action semantics | ✓ within `l̃` |
| 3. Observation aliasing | ✓ conditioning on the full history | ✓ (incremental programs re-use their working tape) |
| 4. Simultaneity | ✓ belief update and expectimax run in the same cycle | ✓ |
| 5. Spurious edges | ✓ in the passive slice (dominance ⇒ the compressible rule wins); **not certified** in the active slice | as AIXI |
| 6. Non-stationary topology | ✓ a rewriting environment is just another computable `q` | ✓ if the generator fits in `l̃` |
| *Computability* | ✗ | ✓ at `2^{l̃}·t̃` per cycle plus `l_P·2^{l_P}` setup |
| *Certifiable optimality* | ✗ (no active-case bounds) | ✗ (dominance is over *self-justifying* policies only) |

Reading: the ceiling is not one wall but two. Uncomputability is the famous one; AIXItl removes it. **The absence of active-case guarantees is not removed by anything** — it is a property of the problem, and it is what makes the wiki's bounded, biased, biologically-derived architectures a legitimate response rather than a concession.

---

## Comparison

| | AIXI | Meta-learning ([[wiki/concepts/meta-learning.md]]) | Complementary learning systems |
|---|---|---|---|
| Where structure lives | Implicit in the posterior over programs | Slow weights, explicit | Cortex, explicit |
| Instance binding | Conditioning on history | Fast inner loop | Hippocampal one-shot store |
| Hypothesis space | All computable environments | Whatever the architecture spans | Whatever the cortical code spans |
| Transfer mechanism | None needed — nothing is ever "relearned" | Shared slow parameters | Consolidation by replay |
| Guarantee | Dominance (passive); conjecture (active) | None | None |
| Cost | Uncomputable | Trainable | Biological |

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — AIXI is the formal ceiling of the framing: the only system covering all six hardness sources, and the source of the scoring table's reference row.
- **[[wiki/concepts/universal-induction.md]]** — supplies the `ξ` that AIXI substitutes for the unknown prior; every guarantee AIXI has, and every one it lacks, is inherited from there.
- **[[wiki/concepts/simulation-based-planning.md]]** — AIµ's expectimax *is* idealized rollout planning, and AIXI's unresolved horizon is gap G15 at the ideal level.
- **[[wiki/concepts/core-knowledge.md]]** — two-way: the `K(µ|z)` result argues installed priors are replaceable by first-cycle input, while the `Ω`-in-the-genome objection argues they may be irreplaceable.
- **[[wiki/concepts/meta-learning.md]]** — AIXI shows the two-level split is not logically necessary (a full posterior needs no meta-level); meta-learning is what the split becomes under finite capacity.
- **[[wiki/concepts/shortcut-learning.md]]** — the passive/active asymmetry is the identifiability problem restated where the architecture is optimal by construction, so it cannot be blamed on the learner.
- **[[wiki/entities/spiking-neural-networks.md]]** — the opposite pole of the same axis: AIXI is a substrate-free specification with no implementation, spiking networks are an implementation-first commitment with no guarantee.
- **[[wiki/entities/bayesian-program-learning.md]]** — the same program-induction framing at the tractable end of the trade: restrict the program space by hand and keep computability, instead of keeping the full computable class and losing it.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the rival AIT definition of intelligence: reward-over-a-universal-mixture with unbounded resources versus skill-acquisition efficiency over a stipulated human-relevant scope, which is the whole content of [[wiki/empirical-tensions.md]] T17.
- **[[wiki/entities/arc-agi.md]]** — the measurable end of the same tradition: where this page maximizes over all computable environments, ARC scores a finite learner on a scoped, prior-equalized, experience-capped task set.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the same predictor/compressor identity at the practical end: any lossless compressor induces a conditional distribution, and this agent is what that construction converges to when the compressor achieves `K`.
- **[[wiki/concepts/intelligence-density.md]]** — claims to subsume this page: under a fixed environment, reward-as-survival and selection–mutation equilibrium, `Υ` is monotone in `ℐ` and orders agents identically (Choi 2026, Proposition 2), so the environment and reward specification adds an *evaluator* rather than a capacity.
- **[[wiki/concepts/expected-free-energy.md]]** — this page's impossibility (no optimality bound for an agent that shapes its own data) met with a weaker instrument: the active-inference loop is recast as a performative fixed point that provably *exists* by Brouwer, with the obstruction to reaching it localised to one missing quantity — a uniform lower bound on state coverage under the deployed policy (Milosevic et al. 2026).
- **[[wiki/concepts/program-induction.md]]** — the reduction this page is the ceiling of; the two corrections it carries from here are that uncomputability is removable (AIXItl) and that the active wall and the short-≠-navigable problem (G26) are not.
