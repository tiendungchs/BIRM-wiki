# Universal Induction

**Weight every computable hypothesis by `2^−(length of its shortest program)` and predict by the resulting mixture — a single prior that provably dominates every computable alternative, so no explicit learning procedure is needed.**

This is the wiki's **maximally general inductive bias**: the limit case of the architecture/loss levers ([[wiki/concepts/shortcut-learning.md]], gap G16). Its value here is not that it is implementable — it is not — but that it marks exactly where a bias-only answer stops working. The identifiability guarantee holds on the **passive** slice and provably fails on the **active** one.

> **Provenance.** Formalisms and results as stated in Hutter 2000, which reports Solomonoff's induction theorems and Kolmogorov complexity and generalizes them to the agent case. Primary sources (Solomonoff 1964, Kolmogorov 1965) not ingested.

---

## Formalism

Fix a universal prefix Turing machine `U`.

| Object | Definition | Reading |
|---|---|---|
| **Kolmogorov complexity** | `K(x) = min{ l(p) : U(p) = x }` | Length of the shortest program printing `x` — its incompressible content |
| **Universal semimeasure** | `ξ(x) = Σ_{p : U(p) = x∗} 2^−l(p)` | Probability that `U` fed fair coin flips outputs something starting with `x`; `ξ(x) = 2^−K(x)+O(K(l(x)))` |
| **Dominance (universality)** | `ξ(x) ≥ 2^−K(ρ) · ρ(x)` for **every** enumerable semimeasure `ρ` | One fixed function is within a constant factor of every computable hypothesis at once. The constant is the hypothesis's own description length |
| **Convergence** | `Σ_k ⟨(ξ − µ)²⟩_µ ≤ ln 2 · K(µ) < ∞` | `ξ(x_<n x_n) → µ(x_<n x_n)` with `µ`-probability 1 for any computable `µ`; the sum being *finite* is what forces convergence |
| **Error bound** | `E_n^Θξ − E_n^Θµ` bounded by a function of `K(µ)` alone | Deterministic prediction from `ξ` makes finitely many extra errors when the optimal predictor makes finitely many; otherwise `E_n^Θξ / E_n^Θµ → 1` |

Three properties that matter architecturally:

- **The only property of `µ` in the bounds is `K(µ)`.** Convergence speed is set by the *description length* of the true environment, not by its stochasticity, state-space size, or stationarity. A structurally complex but short-to-describe world is easy; an incompressible one is impossible for any learner.
- **No learning procedure appears anywhere.** Conditioning the mixture *is* the learning. Every explicit update rule in the wiki ([[wiki/concepts/synaptic-plasticity.md]], [[wiki/concepts/biologically-plausible-credit-assignment.md]]) is an attempt to buy this behaviour under a compute budget.
- **`ξ` is a semimeasure, not a measure.** `ξ(x0) + ξ(x1) < ξ(x)`, because some programs print `x` and then halt or run forever. The deficit `g = 1 − Σ_{x_k} ξ(yx_<k yx_k) > 0` is an **evidence gap** — probability mass assigned to "no continuation predicted". **(brainstorm)** This is a native abstention signal: a predictor built this way reports *I have no hypothesis here* as a first-class output, which no softmax-normalized model can express. Worth stealing for a model that must know when its graph estimate runs out.

---

## The passive/active split — where the guarantee dies

This is the load-bearing result of the page.

| Regime | Environment influenced by the agent's output? | Guarantee |
|---|---|---|
| **Passive / inductive** (sequence prediction, classification) | No | Bounds in terms of `K(µ)` only; one-step **greedy** maximization is optimal; problem "essentially solved apart from computation" |
| **Active** (games, optimization, control, any embodied agent) | Yes | **No useful bound in terms of `K(µ)` exists** — and not as a defect of any particular agent |

Two constructions establish the negative side:

- **Heaven & Hell.** Environments `µ_0, µ_1` where the *first* output decides whether all future credit is 1 or 0. Any `µ`-independent policy commits before any evidence exists, so for every unbiased policy there is a member of the class where it scores zero while the informed policy scores `T`. **No unbiased agent can be near-optimal across a class containing an early irreversible decision.**
- **The needle.** A class where exactly one output `y*` is rewarded, `|Y| ≐ 2^{K(µ)}`. Any policy must test outputs one at a time, so `2^{K(µ)}` errors is the *best achievable* bound — and it is vacuous in the regime `k ≪ 2^{K(µ)}` where the agent actually operates.

Consequences the wiki should carry:

1. **Greedy suffices exactly on the passive slice.** Minimizing the next-step expectation is correct for prediction and classification and *provably wrong* for function minimization, because an active agent's trials shape the information it will receive. The exploration/exploitation problem is not an add-on to induction — it is what appears the moment outputs feed back into observations.
2. **Exploration is a theorem, not a heuristic.** Under `ξ`, an optimizing agent can be shown never to cease testing new candidates: assuming it settles on a finite tested set is ruled out, because the mixture always assigns strictly positive probability to an untested candidate being better.
3. **Optimality must be relativized to environment structure.** Since `K(µ)` alone buys nothing, guarantees have to be re-derived per *separability class* — see the hierarchy on [[wiki/entities/aixi.md]]. "Which structural assumptions is this architecture buying its guarantee with" becomes the question to ask of any learner.

---

## Two claims about where knowledge enters

**Prior knowledge is interchangeable with first-cycle input.** If extra knowledge `z` makes the environment easy to describe, presenting `z` as the *first observation* replaces `K(µ)` by `K(µ | z)` in the bounds. As long as the code that interprets `z` is `O(1)`, the agent absorbs it within a few cycles. Hutter's own summary: **the boundary between implementation and training is unsharp.** This is a direct challenge to the innateness framing in [[wiki/concepts/core-knowledge.md]] — see [[wiki/empirical-tensions.md]] T10.

**Demonstrations are cheaper than reward by `K(R)`.** For learning a relation `R` from examples:

| Channel | What must be transported | Information required in the credit signal |
|---|---|---|
| **Supervised (examples shown)** | `R` is already compressed into the short program that predicts the example stream — the observation channel pays for it, independent of any reward | `O(1)` — only the `O(1)` extension "extract `z_k`, output a matching `y`" has to be learned from credit |
| **Reinforcement (credit only)** | No example stream to compress, so `R` must be reconstructed from the credit bits alone | `≈ K(R)`, and in practice worse, since early credits are almost all zero |

So supervised learning is an **emergent** capability of a pure reinforcement learner, acquired in `O(1)` cycles once examples are present, and the reason to teach by demonstration is quantitative: the observation channel carries `K(R)` bits for free that the reward channel would have to spend. This is the information-theoretic version of the sample-budget argument in [[wiki/concepts/latent-graph-discovery.md]].

---

## Relation to the wiki's structure

| Universal induction says | Wiki translation |
|---|---|
| Mixture over all computable `µ` | The meta-graph is not learned but *integrated over*; every latent graph is a hypothesis with prior `2^−(description length)` |
| `ξ → µ` needs no update rule | Slow **W** disappears as a separate mechanism — it exists only because the mixture is uncomputable |
| Bounds depend on `K(µ)` | The learnable domains are the *compressible* ones; hardness source 6's "no compressible generator ⇒ unsolvable" is the same statement |
| Passive guarantee, no active guarantee | Structure discovery is well-posed for an observer and ill-posed for a participant — G16's identifiability problem, restated where it cannot be blamed on the architecture |

---

## Open problems

- **Uncomputability.** `ξ` is only enumerable (approximable from below): a sequence converging to the right answer exists, but no way to know it has arrived, and convergence is extremely slow. Every practical descendant (minimum description length, resource-bounded complexity, finite-automaton restrictions) is a downscaling that gives up dominance.
- **Machine dependence.** `K` and hence `ξ` are defined only up to an additive constant set by the choice of `U`. Universality is asymptotic; at any finite horizon the choice of reference machine *is* an inductive bias, and nothing in the theory selects it.
- **No active-case bounds.** The main open theoretical problem the source names: general credit bounds, or tighter ones for restricted environment classes.
- **Compression ≠ structure.** The mixture identifies a *short program* for the data, not a factorization of it into `g` and `x`. Nothing forces the shortest program's internal variables to correspond to the graph the wiki wants to recover, so even the ideal inductor may not expose the meta-graph in usable form. **(brainstorm)** This may be the sharpest statement of why compression-optimal models are not automatically reasoning models.

---

## Connections

- **[[wiki/entities/aixi.md]]** — the agent built by substituting this page's `ξ` for the unknown true prior in an expectimax decision maker; it inherits the dominance property and the active-case failure of guarantees.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the formal ceiling for the framing: a graph is learnable to the extent it is compressible, and `K(µ)` is the only quantity that enters the passive bounds.
- **[[wiki/concepts/shortcut-learning.md]]** — the simplicity prior is the one inductive bias that is provably sufficient, and it is sufficient *only* where the learner's outputs do not shape the data; on the active slice the identifiability problem survives even a perfect Occam bias.
- **[[wiki/concepts/simulation-based-planning.md]]** — expectimax over the mixture is the idealized form of rollout-based planning, and the horizon question this page cannot answer is exactly gap G15's control policy.
- **[[wiki/concepts/core-knowledge.md]]** — formal competition: installed priors and first-cycle inputs are interchangeable up to `O(1)` interpretation code, so "innate" may be a claim about timing rather than architecture ([[wiki/empirical-tensions.md]] T10).
- **[[wiki/concepts/meta-learning.md]]** — a Bayesian mixture over environments is the non-parametric limit of an outer loop over a task distribution; meta-learning is what remains when the mixture must be represented in finite weights.
- **[[wiki/concepts/synaptic-plasticity.md]]** — every local update rule is an attempt to approximate, under a compute and locality budget, the belief update this page performs by conditioning.
- **[[wiki/concepts/causal-model-building.md]]** — the formal counterweight to causal fidelity: the provably sufficient bias selects the *shortest* program for the data, which need not be the one whose steps match the world's generative steps (gap G26).
- **[[wiki/concepts/three-component-framework.md]]** — the rival compactness argument: it bounds the description length of the *design* (genome bottleneck) and grants the environment unlimited entropy, where this page bounds learnability by the environment's own `K(µ)`.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the same AIT toolkit aimed at scoring rather than believing, and the direct antagonist ([[wiki/empirical-tensions.md]] T16): the shortest program consistent with the training curriculum is argued to be precisely the one that fails at evaluation.
