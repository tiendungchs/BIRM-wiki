# O-Information — One Signed Scalar That Says Whether a Group Is Redundant or Synergistic

**`Ω(Xⁿ) = C(Xⁿ) − B(Xⁿ) = (n−2)H(Xⁿ) + Σ_j [H(X_j) − H(X⁻ʲ)]` — the excess of *collective constraints* over *shared randomness* in a set of `n` variables. `Ω > 0` means the group is redundancy-dominated (many variables carrying copies of the same thing), `Ω < 0` means synergy-dominated (the regularity lives only in the combination). It is symmetric — no predictor/target split — it costs `2n+1` entropy terms rather than a super-exponential lattice, and it is the wiki's first estimator that reads a property of a group of three or more variables directly off data instead of composing pairwise scores.**

> **Provenance (251st ingest).** Rosas, Mediano, Gastpar & Jensen 2019, *Quantifying high-order interdependencies via multivariate extensions of the mutual information*, Phys. Rev. E 100:032305, arXiv:1902.11239 (`raw/rosas-2019-high-order-interdependencies-o-information.md`). Analytical throughout — lemmas, propositions with proofs in appendices — plus Monte-Carlo checks on random distributions and one data case study (Baroque scores). No neural data: the authors defer the continuous-variable and neural application to a separate publication.

---

## The two halves, and why they are the right basis

The total information a discrete system can hold splits into what its statistics already forbid and what a measurement still reveals: `Σ_j log|𝒳_j| = 𝒩(Xⁿ) + H(Xⁿ)`, with negentropy `𝒩(Xⁿ) := Σ_j log|𝒳_j| − H(Xⁿ)`. Each half then splits again into an individual and a collective part:

| Quantity | Definition | Reading | Other names |
|---|---|---|---|
| **`C(Xⁿ)`** collective constraints | `𝒩(Xⁿ) − Σ_j 𝒩(X_j) = Σ_j H(X_j) − H(Xⁿ)` | How much of the constraint budget acts on groups rather than on single variables | total correlation, multi-information |
| **`R_j`** private randomness | `H(X_j | X⁻ʲ)` | Information reachable *only* by measuring `X_j` | residual / erasure entropy |
| **`B(Xⁿ)`** shared randomness | `H(Xⁿ) − Σ_j R_j` | Information reachable by measuring more than one variable | dual total correlation, binding information, excess entropy |
| **`Ω(Xⁿ)`** O-information | `C − B` | Which of the two descriptions is more parsimonious | "enigmatic information" in the reference the authors rename |

Intuition behind the sign: a redundant system needs *many* constraints to keep its copies aligned (`C` large) while any one variable already reveals the rest (`B` small); a synergistic system is ruled by few, weak collective constraints (`C` small) with almost all of its randomness only jointly accessible (`B` large).

---

## Properties (Lemma 1, Propositions 1–2, Lemma 3)

| Property | Statement | Why a builder cares |
|---|---|---|
| **Symmetry** | `Ω` is invariant to the ordering of `X_1…X_n` | No division into predictors and a target. Every other higher-order measure in the wiki's reach (partial information decomposition, transfer-entropy-style quantities) needs that division imposed by hand |
| **Pairwise-blind** | `Ω(X_1,X_2) = 0` for *every* `p_{X₁X₂}` | It scores nothing that a pairwise estimator already sees; the number is purely about order ≥ 3 |
| **Agrees at `n = 3`** | `Ω(X³) = I(X_1;X_2;X_3)`, the interaction information | Inherits the one case where synergy-minus-redundancy is agreed on |
| **Generalises where interaction information fails** | `Ω ≠ I(X_1;…;X_n)` for `n > 3`; on an `n`-bit xor, `Ω = 2−n` decreases monotonically while `I = (−1)^{n+1}` oscillates between `±1` | The reason to replace the classical quantity rather than extend it |
| **Path decomposition** | Every source→sink path in the partition lattice gives `W(p;v_s) = Ω`, and it is always a **sum of triple interaction informations**; the assembly path gives `Ω(Xⁿ) = Σ_{k=2}^{n−1} I(X_k; X^{k−1}; X^n_{k+1})` | The higher-order number is built from three-way terms, not from pairs — and the decomposition is order-invariant |
| **Bounds, tight** | `(n−2)log|𝒳| ≥ Ω ≥ (2−n)log|𝒳|`; `(n−1)log|𝒳| ≥ C, B ≥ 0` | Normalisation: divide by `(n−2)log|𝒳|` to compare groups of different size and alphabet |
| **Extremes are unique** | For binary `Xⁿ`, `n ≥ 3`: `Ω = n−2` **iff** `Xⁿ` is an `n`-bit copy (`X_1` a fair coin, `X_1 = … = X_n`); `Ω = 2−n` **iff** `Xⁿ` is an `n`-bit xor (`X_1…X_{n−1}` i.i.d. fair coins, `X_n = Σ_{j<n} X_j mod 2`). For alphabet size `m`: `±(n−2)log m`, xor replaced by mod-`m` sum | Two labelled reference points for any measurement on a learned representation — "the units are copies" and "the information is only in the combination" |
| **Continuity** | `Ω` is a linear combination of Shannon entropies, hence continuous in `p` | Distributions *near* a copy have `Ω > 0`, near an xor `Ω < 0`; the extremes are not isolated |
| **Additivity** | For independent subsystems, `Ω(Xⁿ) = Σ_k Ω(X^{α_k})` | Lets a system be scored part-wise — and creates the ambiguity below |

---

## Local O-information: the part that could point at *which* triple

`ω_ij(Xⁿ) := I(X_i; X_j; X⁻ⁱʲ)`, so that `Ω` decomposes into a matrix of local terms — for `n = 4`, `Ω(X⁴) = I(X_i;X_j;X_k,X_l) + I(X_k;X_l;X_i,X_j)`.

- A local term may carry the **opposite sign to the global `Ω`**: local synergy inside a globally redundant system, or the reverse.
- Cost is `O(n²)` local terms, each still an entropy combination over the whole joint.
- This is the closest thing here to a higher-order *structure* readout rather than a single system-level score: it produces a signed network over pairs whose value is a three-or-more-way quantity, which is a different object from a correlation matrix even though it is indexed the same way.

---

## What the sign and magnitude constrain at other scales

| Regime | Constraint (Corollaries 3–4) |
|---|---|
| `Ω ≥ 0` | `min_{|γ|=m} C(X^γ) ≥ Ω − (n−m−1)log|𝒳|` — strong redundancy **forces** every large-enough subgroup to be correlated |
| `Ω ≤ 0` | `max_{|γ|=m} C(X^γ) ≤ Ω + (n−2)log|𝒳|` — strong synergy **caps** the correlation of every subgroup |
| Converse | Fixing one `m`-subset's `C(X^γ)` shrinks the achievable range of `Ω` from `2(n−2)` to `2(n−2) − (m−1)` |

So the sign chooses whether the constraint is a floor or a ceiling, and `|Ω|` chooses how small a subgroup it can reach — smaller groups need larger `|Ω|`. **The honest caveat**: for binary variables and pairs (`m = 2`) the bounds bite only when `n−3 ≤ |Ω| ≤ n−2`, i.e. only near the extremes. For a mid-range `Ω` the scale bounds say nothing.

---

## Against the wiki's existing integration measure

`TSE(Xⁿ) := Σ_k [(k/n)C(Xⁿ) − C_n(k)]` (Tononi, Sporns & Edelman's complexity, the convexity of the average subset total correlation) is shown to be, empirically, a measure of **strength** and not of **kind**:

- `TSE ∝ C + B` — correlation consistently above `0.97` against the exact TSE on distributions drawn uniformly from the probability simplex, and a better approximation than previously proposed ones.
- On a linear mixture between a 3-bit copy and a 3-bit xor, **TSE takes exactly the same value at both ends** while `Ω` runs from `+1` to `−1`. TSE conflates redundancy with synergy.
- The pair is a change of basis: `Ω = C − B` (kind), `TSE ∝ C + B` (strength). They are complementary, not competing.

**Consistency with statistical mechanics.** Ensembles of `n = 5` spins with random `k`-th-order Hamiltonians (`J_γ ~ N(0,1)` i.i.d., `β = 0.1`): `Ω ≈ 0` at `k = 2` and becomes increasingly negative as `k` grows. Synergy as measured by `Ω` tracks the interaction order written into the generating Hamiltonian.

---

## The one data case study, and what it demonstrates

Four-part Baroque scores as 13-valued time series (12 notes + silence), joint distribution of the simultaneous four-note chord estimated by empirical frequency; ≈4×10⁴ chords (Bach chorales, four voices) and ≈8×10⁴ (Corelli op. 1, 3–6, two violins/viola/cello); logarithms base 13, unit called a *mut*.

| System | `Ω` | Local structure |
|---|---|---|
| **Bach chorales** | negative — synergy-dominated | *All six* `ω_ij` negative (`−0.02` to `−0.05`); every pair's mutual information (0.12–0.17) is smaller than its conditional mutual information (0.16–0.22) |
| **Corelli** | positive — redundancy-dominated | Five of six `ω_ij` positive, largest viola–cello `ω = 0.17` (MI 0.630) — the two instruments are realising the *same* basso continuo line; the two violins are the exception at `ω = −0.04` |

The point for a builder is not the music. It is that (i) the measure recovers a known *generative* fact — two parts doubling one written line — from the joint statistics alone, without being told which variables to compare; and (ii) a globally redundant system contained a locally synergistic pair, which no single system-level scalar would have shown.

---

## What it does not do

- **It is not a structure learner.** `Ω` scores a *given* set of variables. Finding *which* subset is synergistic still means searching subsets, which is combinatorial; the `O(n²)` local map is the only cheap localiser offered, and it is indexed by pairs.
- **It is a net quantity, not a decomposition.** `Ω = 0` is ambiguous between "disjoint pairwise interactions only" (sufficient, not necessary) and "redundancy and synergy cancelling by destructive interference". Resolving that needs the `C`/`B` pair separately, or the O-information of sub-systems.
- **The joint distribution is the real cost.** Every term is an entropy of an `n`-variable marginal; the case study estimates a `13⁴ ≈ 2.9×10⁴`-cell table from `4×10⁴` samples by plug-in frequencies, with no bias correction reported beyond circular block-bootstrap standard errors. The `2n+1`-term complexity is cheap *given* the joint; the joint is not cheap.
- **Discrete only, here.** The continuous-variable extension and the neural application are announced, not delivered.
- **Redundancy and synergy can coexist within the same variables**, not only in disjoint subsystems, and `Ω` reports only their net.
- **The scale bounds are near-vacuous away from the extremes** (see the caveat above).

---

## Relevance to a reasoning model

- **`G105`'s first computable discriminator.** The row asks for a mechanism that infers an `n`-ary relation from data rather than by composing or thresholding pairwise scores. `Ω` is not that mechanism — it is a *measure*, not a learner — but it is the first thing in the wiki that reads an order-≥3 property off data with no pairwise composition step and no predictor/target split, and it supplies the discriminator any candidate learner would be scored with. The row stays open; its "nothing estimates a three-way relation the way covariance estimates a pair" now has a named, cheap counterexample at the *measurement* level.
- **The xor is the wiki's cleanest statement of why a pairwise graph estimator can be exactly blind.** In an `n`-bit xor every pairwise mutual information is **zero** — a correlation-based edge estimator returns the empty graph — while `Ω = 2−n`, the most negative value attainable. Any architecture whose structure discovery is a covariance, a precision matrix, an attention score or a transition count sees nothing at all in a system whose entire regularity is present. **(brainstorm)** This is the same blindness as the *cavity* on [[wiki/concepts/higher-order-interactions.md]], now with a scalar attached.
- **A label-free probe for learned representations.** `Ω` normalised by `(n−2)log|𝒳|` over a set of units, heads or experts scores where the population sits between "copies" and "combination-only" — which is a different axis from the rank/anti-collapse criteria the wiki uses for checkpoint selection (`G108`). **(brainstorm)** A collapsed representation and a maximally redundant one are both `Ω`-positive, but a *high-rank, high-redundancy* code is possible and would be invisible to a spectral criterion.
- **A design target that is not "maximise integration".** The Bach reading — strong global constraints with weak pairwise ones, so each part contributes unique material while the ensemble stays coherent — is the profile the wiki's modular architectures want and their measurements cannot currently distinguish from plain integration. **(brainstorm)** For a mixture-of-experts or a multi-module world model, "experts are not duplicating each other *and* their outputs are only jointly meaningful" is `Ω < 0` over expert outputs, and it is directly computable from activations with no labels and no task identity.
- **It reprices integration/segregation measurement.** Any claim in the wiki that rests on TSE-style complexity, or on a global coupling statistic, is a claim about `C + B` and is silent on the redundancy/synergy axis — see [[wiki/concepts/integration-segregation-balance.md]].

---

## Connections

- **[[wiki/concepts/higher-order-interactions.md]]** — supplies the measurement that page's vocabulary lacks: simplicial complexes and persistent homology *analyse* a complex obtained by thresholding an already-estimated pairwise matrix, while `Ω` is computed from the joint distribution directly and returns a signed scalar per group, so the two are complementary (topology says *where* the non-dyadic structure sits, `Ω` says *what kind* it is).
- **[[wiki/concepts/node-definition-problem.md]]** — names the measure that page asks for: its "the edge estimator sees redundancy only" complaint is exactly the statement that correlation-based edges measure a piece of `C` and never `B`, and `Ω = C − B` is the multivariate statistic that separates them — inheriting, unchanged, that page's prior problem of which variables to put in the set.
- **[[wiki/concepts/integration-segregation-balance.md]]** — a correction to the measurement it and the TSE literature share: `TSE ∝ C + B` (correlation > 0.97) is a *strength* statistic that takes the same value on a 3-bit copy and a 3-bit xor, so an integration score cannot tell a network that duplicates information from one whose information is only joint; `Ω = C − B` is the orthogonal coordinate.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the sharpest existing bound on its estimation half: the `n`-bit xor has zero pairwise mutual information at every pair while carrying maximal higher-order structure, so the discovery step's failure there is not a precision problem to be improved but a hypothesis-space exclusion.
- **[[wiki/concepts/disentanglement.md]]** — the objective side of the same decomposition: FactorVAE and β-TCVAE penalise **total correlation**, i.e. `C` alone, so they push on the collective-constraints half of `Ω` without touching shared randomness `B` — which means a low-`C` representation can still be redundancy- or synergy-dominated, and the penalty does not distinguish them.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the pairwise-recovery ceiling this page's xor makes unimprovable in one corner: that page prices edge recovery on a sparse graph at ≈6–28% precision with a *correct* pairwise model, and `Ω` identifies the regime where the correct pairwise model is not merely imprecise but identically zero.
- **[[wiki/entities/integrated-information-theory.md]]** — the same lineage's other multivariate scalar, and a separation from it: TSE complexity, `Φ`'s ancestor, is shown here to measure interdependency *strength* rather than irreducibility-in-kind, and `Ω` is tractable (`2n+1` entropy terms) where `Φ` is not.
