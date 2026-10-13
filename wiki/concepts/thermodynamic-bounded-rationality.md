# Thermodynamic Bounded Rationality — Decision as a Priced Change of Distribution

**A bounded decision-maker does not pick an action; it moves a prior distribution `p₀` toward the utility, and pays for the move in information. The move maximises `E_p[U] − (1/β)·KL(p‖p₀)`, whose solution is `p ∝ p₀·e^{βU}` and whose value is the log-partition `(1/β)·log Σ p₀e^{βU}`. One resource parameter `β` then spans the range from "act on the prior" to "take the argmax". Its sign separates optimism from pessimism, and it can be read as a number of samples.**

> **Provenance.** Ortega & Braun 2013, *Thermodynamics as a theory of decision-making with information-processing costs*, Proceedings of the Royal Society A 469:20120683 (arXiv 1204.6481; `raw/ortega-2013-thermodynamics-decision-making-information-processing-costs.md`). Theory paper: axioms, theorems and worked illustrations, with no fitted data. The clip is the ar5iv HTML rendering, and the **Supplementary Material is absent**: the Ellsberg, Allais and diffusion-to-bound derivations and the proof of Theorem 4 are carried below as the paper's stated claims. The sequential theorems (5–7) are proved in Ortega's 2011 thesis, which the paper cites and the wiki does not hold. Two source typos are corrected here: Corollary 3's `Z` omits `p₀` (Eq. 9 restores it), and the sign of `−ΔF` is written both ways.

[[wiki/concepts/resource-rationality.md]] holds the objective (the best program for a machine) and leaves the cost function free. [[wiki/concepts/default-policy-regularization.md]] uses a `KL`-from-default cost and justifies it by what it does to multi-task learning. This page **derives** that cost form from three axioms, and shows that a single variational principle with per-node `β` recovers four standard controllers.

---

## Derivation

**Axioms on a transformation cost `ρ(A|B)`** (the cost of refining information state `B` to `A ∩ B`):

| # | Axiom | Content |
|---|---|---|
| 1 | `ρ(A\|B) = f(p(A\|B))` | Cost depends only on the conditional probability of the refinement |
| 2 | `ρ(A∩B\|C) = ρ(A\|C) + ρ(B\|A∩C)` | Costs of successive refinements add |
| 3 | `ρ(A\|B) > ρ(C\|D) ⟺ p(A\|B) < p(C\|D)` | Less probable refinements cost more |

**Theorem 1.** `f(·) = −(1/β)·log(·)`. Cost is proportional to the bits fixed, and `β` is the conversion factor.

**Physical reading (Landauer).** Isothermally compressing a one-molecule gas into fraction `p` of its volume costs `W = −kT ln p = −γ log p`. Coins, doors and trains are the same device with larger `γ`. So `1/β` is an energy-per-bit price set by the substrate.

| Object | Form |
|---|---|
| Cost potential | `φ(A∩B) = φ(B) + ρ(A\|B)`; over a partition `𝒳` of `S`: `φ(S) = −(1/β) log Σ_x e^{−βφ(x)}` |
| Gibbs measure | `p(x\|S) = e^{−βφ(x)} / Σ_x e^{−βφ(x)}` |
| Gain or loss | `U(x) = φ₀(x) − φ(x)`, a *difference* of potentials, not an absolute level |
| Variational principle (Cor. 3) | `max_q  Σ q(x)U(x) − (1/β) Σ q(x) log(q(x)/p₀(x))` |
| Solution | `p(x) = p₀(x)·e^{βU(x)} / Z`, `Z = Σ_x p₀(x)e^{βU(x)}` |
| Value = certainty equivalent | `V = (1/β) log Z` (the physical analogue is free-energy difference = work) |
| Decomposition | `−ΔF = E[U] − E[R]`, `R = ρ − ρ₀`: expected gain minus the extra information cost of reaching it |

The principle has two readings. With `U` constrained, it is **maximum entropy**, which the authors use for an observer estimating. With entropy constrained, it is **minimum expected loss**, which is acting under a relative-entropy budget.

---

## One parameter, three regimes, two roles

| `β` | Acting (`p₀` = prior policy) | Observing (`p₀` = prior belief) | `V` |
|---|---|---|---|
| `→ +∞` | Perfectly rational: `δ(x − argmax U)` | Extreme optimist: believes the best outcome | `max U` |
| `→ 0` | No resources: acts on `p₀` | Risk-neutral Bayesian: uses `p₀` unchanged | `E_{p₀}[U]` |
| `→ −∞` | Perfectly anti-rational: `argmin U` | Extreme pessimist: believes the worst | `min U` |

**The same equation covers choice and belief.** On an action variable, `β` is the agent's own rationality. On an observation variable, `β` is the *environment's* rationality as the agent models it: positive means a cooperative environment (the environment acts as an extension of the agent), negative means an adversarial one.

---

## `β` as a number of samples (§4)

**Setting.** Find the largest of i.i.d. draws `U₁, U₂, …` from `μ`. After `m` draws the best-so-far has CDF `F_m(v) = F₀(v)^m`. Expected maximum rises with `m` at a diminishing rate. With a price `c` per draw, the penalised expectation has a finite optimum (the paper's example: `c = 0.02` gives `M = 35` over a truncated Poisson on 1…10).

**Log-odds.** `log p_m(v)/p_m(v′) = (m − 1)·log F₀(v)/F₀(v′) + log μ(v)/μ(v′)`. The exponential-family form gives `α(U(v) − U(v′)) + log μ(v)/μ(v′)`. So `α` plays the role of `m`.

**Theorem 4.** Let `Q` and `M` be strictly positive distributions on a finite `𝒳`, and let `M_α` be the distribution of the maximum of `α` samples from `M`. Then `|Q(x)e^{αU(x)}/Σ Q e^{αU} − M_α(x)| ≤ e^{−(α−ξ)δ}`, with `δ, ξ > 0` depending only on `M`. `M` only needs the same support as `Q`. For negative `α`, take the minimum of `−α` samples.

**Satisficing without regress.** If the bounded agent solved a constrained optimisation, its problem would be *harder* than the unbounded agent's. The paper resolves this by having the agent **not reason about its constraints**: it searches at random until its resources run out. The stochastic choice rule is then what an observer sees. The agent acts deterministically and still looks stochastic given its resource `m`. Anytime algorithms are the stated example.

---

## Sequential decisions: per-node `β` (§5–6)

**Theorem 5 (change of temperature).** If the inverse temperature changes from `α` to `β` while `P` and `Q` stay fixed, the utility becomes `V(x) = U(x) − (1/α − 1/β)·log(P(x)/Q(x))`. This lets every node of a decision tree carry its own `β(x_{<t})`.

**Recursion (Theorems 6–7).**

```
V(x_<t) = (1/β(x_<t)) · log Σ_{x_t} Q(x_t|x_<t) · exp{ β(x_<t) · [R(x_t|x_<t) + V(x_≤t)] }
P(x_t|x_<t) ∝ Q(x_t|x_<t) · exp{ β(x_<t) · [R(x_t|x_<t) + V(x_≤t)] }
```

The free energy nests, with the latest step innermost, so the recursion is solved backwards in time.

| Controller | `β` on action nodes | `β` on observation nodes | Recovers |
|---|---|---|---|
| **KL control** | constant `β` (all variables treated as actions) | — | `z`-iteration / linearly solvable MDPs (Todorov). Here the stochasticity comes from bounded control, not from passive dynamics |
| **Optimal stochastic control** | `→ +∞` | `→ 0` | Bellman optimality equation |
| **Risk-sensitive control** | `→ +∞` | `≠ 0` | Log-partition "stress function". `β < 0` discounts variability (risk-averse) and `β > 0` adds value to it (risk-seeking). Mean–variance criteria follow |
| **Robust control** | `→ +∞` | `→ −∞` | Minimax against a perfectly rational adversary. Risk-sensitive and robust control are derived from one principle |

In the risk-sensitive literature the stress function is *assumed*; here it falls out of the principle.

---

## Relations claimed to other models

| Model | Relation (as stated in the source) |
|---|---|
| Quantal response equilibrium (QRE) | Special case with uniform `p₀`. The prior is what lets the certainty equivalent range from min to max through the expectation |
| Luce / logit / softmax choice | Same exponential form. Independence of irrelevant alternatives (IIA) need not hold, because a change of choice set can change `p₀` **and** `β` |
| Diffusion-to-bound | Choice probabilities are identical when the decision bound is related to `β`, and `β` is then proportional to decision time (derivation in the absent Supplementary Material) |
| Variational / multiplier preferences | The log-partition certainty equivalent is an instance. The difference is that the choice is *stochastic* in the certainty equivalent, which lets one model cover bounded rationality and model uncertainty together |
| Ellsberg paradox | Ambiguity aversion = partial minimaxing (observation `β < 0`) (Supplementary) |
| Allais paradox | Not straightforward. Possible routes are a context-dependent `β`, or a generalised quasi-linear mean model (Supplementary) |
| Variational free energy (Friston) | Maximising `ln P(y,h\|a)` is one choice of potential `φ`. The bound comes from restricting `Q` to a model class, so variational Bayes is **bounded inference** |
| Bayes' rule | Prior `p₀`, likelihood `e^{βU}`, posterior `p`. Control and inference share one form |
| Replicator dynamics | A population pushed through a fitness function has the same update form. Hypotheses compete for probability mass across iterations |

---

## What a builder takes from this

| Property | Consequence |
|---|---|
| **The cost form is derived, not chosen** | Any system whose refinement cost depends only on probability and adds over steps must charge `−(1/β) log p`. A `KL`-to-prior penalty is then the cost function, not a regulariser chosen for convenience. This is the axiomatic backing that [[wiki/concepts/default-policy-regularization.md]]'s `KL(π_i‖π₀)` lacked |
| **`β` has units** | Theorem 4 turns the inverse temperature into a sample count, so a softmax temperature is a compute budget. For `G107` the exchange rate gets an operational meaning (samples per decision), but it remains an external constant |
| **Per-node `β` is per-state compute allocation** | The recursion lets every node of a plan carry its own budget, so "where to think harder" is a field over the tree. **(brainstorm)** It is the shape of answer `G15`'s *which branch / how deep* asks for, but nothing in the source sets `β(x_<t)` |
| **One scalar per node type spans four controllers** | **(brainstorm)** For a learned world model, `β` on observation nodes is a dial for trust in the model. `0` plans on the model's own predictions, `< 0` plans robustly against model error, and `→ −∞` is minimax. This is a candidate knob for planning with a model known to be wrong (`G62`), and untested |
| **The prior is load-bearing** | Every price is a distance from `p₀`, so a different prior gives different costs for the same behaviour. The paper treats `p₀` as given. Default-policy distillation is one learning rule for it |
| **The value is the normaliser** | **(brainstorm)** `V = (1/β) log Σ p₀e^{βU}`, so with uniform `p₀`, the MSPRT (multihypothesis sequential probability ratio test) normaliser `S(T) = ln Σ e^{y_j}` ([[wiki/concepts/evidence-accumulation.md]]) is `β·V` of the current choice set. The subthalamic–pallidal loop would then compute the certainty equivalent of the options, not only a normaliser. A non-uniform `p₀` enters as a per-channel offset `log p₀(i)`, which is the term that page lists as unmeasured |

---

## Open problems

- **Nothing sets `β`.** The paper is descriptive (it fits any degree of sub-optimality) and prescriptive given `β`. What fixes `β`, per agent or per node, is outside it. This is the same hole as `G107`.
- **Theorem 4 covers one algorithm.** The sample interpretation is proved for random sampling plus keep-the-max. Whether gradient descent, tree search or Markov-chain Monte Carlo chains map onto `β` the same way is not shown.
- **The cost is information only.** Axiom 1 makes cost depend on probability alone, not on the representation or the algorithm that does the refining. The authors list linking it to time and space complexity as future work. [[wiki/concepts/resource-rationality.md]]'s Ma & Woodford axes (resource term, cost form) are exactly where this choice is made.
- **The partition is given.** `ρ` is defined over a fixed partition `𝒳`. **(brainstorm)** Re-carving the outcome space changes `p₀` and so changes every price. The cost of a decision is therefore relative to a discretisation the theory does not supply (`G27`).
- **The observation-node `β` is unexplained.** Reading a negative `β` as "the environment's rationality" names the parameter and does not say how an agent would estimate it.
- **No data in this paper.** The Ellsberg, diffusion-to-bound and stochastic-choice links are argued, with derivations in Supplementary Material the wiki does not hold. Allais is conceded as not straightforward.

---

## Connections

- **[[wiki/concepts/resource-rationality.md]]** — supplies a closed-form cost for that page's Eq. 3: the cost of a computation is the information it fixes, `(1/β)·KL(p‖p₀)`. It also gives the outer-loop commitment a mechanism: the agent does not reason about its constraints, it samples until the resource runs out, and `β` counts the samples.
- **[[wiki/concepts/default-policy-regularization.md]]** — derives that page's cost form from three axioms (`ρ = −(1/β)log p`, so the price of moving a policy is `KL` to the prior). That page supplies what this one leaves as given: a learning rule for `p₀` (distillation from the task policies).
- **[[wiki/concepts/satisficing.md]]** — formalises the anytime reading of Simon's search: stop drawing when the marginal gain from another sample falls below its price, and the choice distribution of a searcher stopped after `m` draws is a Boltzmann distribution with `β ≈ m` (Theorem 4).
- **[[wiki/concepts/divergence-objectives.md]]** — a third case of "divergence as a *term*": `KL(p‖p₀)` puts neither data nor world in either argument and is derived as the price of changing a distribution. Its direction is fixed by the axioms, with the expectation under the new distribution.
- **[[wiki/concepts/evidence-accumulation.md]]** — the same log-sum-exp from two sides. MSPRT's normaliser `S(T)` is this page's `β·V` with a uniform prior, and the source claims the diffusion bound maps onto `β`, with `β` proportional to decision time.
- **[[wiki/concepts/expected-value-of-control.md]]** — takes a side in that page's open choice of cost function. A derived information cost depends on how far the controlled distribution moves from the prior, not on intensity alone, so two equally intense signals cost differently if they sit at different distances from `p₀`.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — re-reads the variational free energy as one instance of this page's principle. Surprise minimisation is the choice of potential, and restriction to a model class `Q` is what makes the inference bounded.
