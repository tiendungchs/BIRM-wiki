# Universal Induction

**Weight every computable hypothesis by `2^−(length of its shortest program)` and predict by the resulting mixture — a single prior that provably dominates every computable alternative, so no explicit learning procedure is needed.**

This is the wiki's **maximally general inductive bias**: the limit case of the architecture/loss levers ([[wiki/concepts/shortcut-learning.md]], gap G16). Its value here is not that it is implementable — it is not — but that it marks exactly where a bias-only answer stops working. The identifiability guarantee holds on the **passive** slice and provably fails on the **active** one.

> **Provenance.** Formalisms and results as stated in Hutter 2000, which reports Solomonoff's induction theorems and Kolmogorov complexity and generalizes them to the agent case. The section *The 1964 constructions* is from the primary source, Solomonoff 1964 Part I (*Information and Control* 7:1–22; `raw/solomonoff-1964-formal-theory-of-inductive-inference-part-1.md`). That clip is a lossy PDF conversion: Eqs. 1–3, 7 and 10–14 are garbled and are rebuilt below from the paper's prose definitions of each term. The paper states **no theorems**; its claims rest on "plausibility arguments and numerous specific examples". Part II (Bernoulli, Markov-chain and phrase-structure-grammar applications) and Kolmogorov 1965 are not ingested.

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

## The 1964 constructions (Solomonoff)

The founding paper gives four formulations, not one. The problem is to extrapolate one very long symbol string `T` that "contains all of the information to be used". The author claims, without proof, that every induction problem, discrete or continuous, can be put in this form. Notation: `r` is the output alphabet size, `N(·)` the bit length of a description, and a *description* `S` of `T` is an input with `M(S) = T`.

| § | Construction | Probability that `a` follows `T` | Status in the paper |
|---|---|---|---|
| **3.1** | Every description of `T a` *and of every continuation* `T a C_{n,k}`, on an unconstrained universal machine `M₁` | `lim_{ε→0} lim_{n→∞} Σ_k Σ_i [(1−ε)/2]^{N((S_{TaC_{n,k}})_i)}`, normalised over all `a` (Eq. 1). The `(1−ε)` damping is needed because the number of length-`m` descriptions of any string grows at least as `2^m`, so the undamped sum diverges | Existence of the limit not shown; equivalence to the other three uncertain |
| **3.2** | A 3-tape machine `M₂` with one-way input and output, fed an infinite random input (fair coin, or any finite-order Markov chain). `S` is a *minimal code* of `T` if it is a code of `T` and dropping its last symbol stops it being one | `P′(a,T) = Σ_i 2^{−N(Ta,i)} / Σ_i 2^{−N(T,i)}` (Eq. 7). Both sums are ≤ 1, so no `ε` is needed. Continuations are handled automatically, because extending a minimal code still yields a code of `T` | This is the form Hutter reports as `ξ` (Formalism above). The paper calls it the *optimum* model of a lifetime sensory record |
| **3.3** | All binary inputs of a fixed length `R`, with `2^R ≫ r^m` | Prior `P(T) = N_T / N_R`: the fraction of halting length-`R` inputs whose output begins with `T` (Eq. 9) | Proved identical to 3.2; the paper reads it as the **principle of indifference** over causes |
| **3.4** | A weighted mean over all normalised **probability evaluation methods** (PEMs), i.e. every computable predictor | `P‴(a,T) = Σ_i f_i P_i(Ta) / Σ_j f_j P_j(T)` (Eq. 13), where `f_i` is the limiting fraction of length-`R` strings that describe `Q_i` (≈ `2^{−description length}`). The weight `f_i P_i(T)` is prior × past success | Plausibly ≈ 3.3. `P‴` is itself normalised but not computable, so it is not among the methods it averages |

**Five points the wiki should carry that the Hutter summary omits:**

- **The prior rewards multiplicity, not only shortness.** A string gets high prior from short descriptions *and* from many descriptions — "if an occurrence has many possible causes, then it is more likely". So the construction is a sum over programs, not the single shortest one. §3.4 makes the same point at the level of hypotheses. As `T` grows, `f_i P_i(T)/f_j P_j(T)` grows without bound for the better method, so the mixture hands almost all its weight to one predictor. Here "better" is McCarthy 1956's criterion, `P_i(T) > P_j(T)`, which is log-loss. **(brainstorm)** Committing to one program, i.e. minimum description length (MDL), is therefore the *long-data limit* of this construction, not the construction itself. At finite `T` the mixture still spreads its bets, and that hedging is what [[wiki/empirical-tensions.md]] `T16` position B says a single shortest program lacks.
- **Only the measure-valued formulation is normalised.** The §3.4 mixture over *normalised* methods is normalised. The §3.2 form, which admits codes that stall, is the semimeasure. So the evidence gap in the Formalism section exists only if hypotheses that fail to continue are admitted.
- **The machine is a sufficient statistic of the past** (§3.1.3). For any `T` and later data `D`, some universal `M₂` satisfies `P(a, TD, M₁) = P(a, D, M₂)`, so the past can be folded into the machine and only new data coded. The existence proof is useless: finding short codes for `Da` on that `M₂` is as hard as for `TDa`. A *useful* summary must be approximate, and an approximate one can be wrong about the future. A symbol-frequency table summarises a Bernoulli-like `T` well, but it cannot notice that `T` later repeats exactly. This is the converse of Hutter's "prior knowledge = first-cycle input" (next section): there, knowledge moves into the data stream; here, data moves into the machine. Both are exact only when nothing is summarised away.
- **Raw data beats laws.** A scientific law is a compact code for the data that produced it. Writing the laws into the sequence instead of the raw data gives similar predictions. Keeping the raw data gives predictions "at least as good, and usually better", because "summaries of the data are almost always imperfect". The founding paper of the compression-as-induction view therefore argues *against* storing only the compressed form: compression is applied at prediction time, over a corpus that is kept. This bears on `T16` and on which knowledge belongs in an addressable store (`G98`).
- **Intermediate codes are chunk definitions that pay only when reused.** `D = abcdabcd…ab` is long when coded directly. Define `α = abcd` and it becomes `Bααααab`, where `B` is the definition. The continuation `cd` makes the code shorter still (`Bααααα`), because the symbols `a` and `b` disappear from the intermediate code, and rarely used symbols are expensive in the final code. Two consequences: (i) the prior favours a continuation that completes a reusable chunk, and (ii) a definition is cheap only in proportion to its reuse. That is the "length under enforced re-use" criterion `G26`'s DreamCoder candidate measures ([[wiki/concepts/program-induction.md]]).

**Validation stance (§2.1).** No induction method can be proved correct. One can only be refuted, by internal inconsistency or by gross disagreement with intuition. The evidence the paper ranks highest is agreement with strong intuitions across many diverse problems, which then licenses trust where intuitions are weak. Optimality (§3.4) and consistency arguments rank below it. **(brainstorm)** This is the `L0-INSTR` problem stated in 1964: "intuitively reasonable on cases where we already know the answer" is still the only validation available for an inductive bias (`G17`).

**Computable approximation is the intended use** (§3.1.2.1). Eq. 1 is conjectured uncomputable. The proposed fix counts only inputs that finish their output in fewer than `τ` operations: every term is then computable and the sums are finite, and one takes `τ → ∞` before `ε → 0`. The author would adopt a computable approximation that gives reasonable values as a *better* explication than Eq. 1. In 1964 different problem types use different approximations, and "a unified, useful approximation" is listed as hoped-for. **(brainstorm)** So the founder treats the ideal as a generator of approximations, not as a target, which is the bounded-optimality stance on [[wiki/concepts/resource-rationality.md]] applied to the prior itself. The time cap `τ` is the first resource-bounded version of the prior.

**Inversion of Huffman coding** (§2). Huffman takes a distribution and returns the minimal code. This construction takes the minimal codes and returns the distribution. That is the earliest statement of [[wiki/concepts/prediction-compression-equivalence.md]], run from the code side.

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
3. **The founding model already hid the active case inside the passive one.** Solomonoff 1964 §3.2 writes a person's whole sensory record, "including the interaction of the man with his environment", as the one sequence to extrapolate. Actions then appear only as data. Hutter's split is what shows the guarantee does not survive once those actions are *chosen* by the predictor.
4. **Optimality must be relativized to environment structure.** Since `K(µ)` alone buys nothing, guarantees have to be re-derived per *separability class* — see the hierarchy on [[wiki/entities/aixi.md]]. "Which structural assumptions is this architecture buying its guarantee with" becomes the question to ask of any learner.

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
- **Machine dependence.** `K` and hence `ξ` are defined only up to an additive constant set by the choice of `U`. Universality is asymptotic; at any finite horizon the choice of reference machine *is* an inductive bias, and nothing in the theory selects it. Solomonoff 1964's own heuristic argument (§3.1.2.3) names when the choice washes out. The two shortest codes differ by at most the translation length `N_a`, and that constant cancels between numerator and denominator when three conditions hold: (1) one machine is appreciably better at the regularities in `T`; (2) the translation is short; (3) `T` is long enough that its shortest code is much longer than `N_a`. Its practical advice is to *choose* `M₁` to be efficient on the domain, e.g. LISP. That is the reference machine picked by hand as a domain prior, not derived ([[wiki/concepts/inductive-bias.md]]).
- **No active-case bounds** (`G25`). The main open theoretical problem the source names: general credit bounds, or tighter ones for restricted environment classes. The passive case is settled and the active one is not, which is the wiki's ceiling on certifying any agent whose own actions choose its next observation.
- **The regularity assumption is a bet, and nothing calibrates its size.** The standard No Free Lunch escape — a learner may beat the average only on the subset of environments that carry regularities, and only by having that subset's characteristics built in — is what licenses this page's simplicity prior in the first place. Its cost is stated as a dilemma with no procedure attached: more built-in assumptions ⇒ smaller covered subset, higher efficiency, and higher probability that the assumptions are false in the world actually met (Pfister & Jud 2025, [[wiki/concepts/problem-framing.md]]). Machine dependence above is the formal version of this; the dilemma is the engineering version, and neither says how many bits of assumption to spend.
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
- **[[wiki/concepts/problem-framing.md]]** — the same No Free Lunch move with the opposite conclusion: where this page answers by weighting all computable environments, that one restricts to worlds bearing regularities and treats the restriction as a falsifiable design bet with an unquantified failure cost.
- **[[wiki/concepts/three-component-framework.md]]** — the rival compactness argument: it bounds the description length of the *design* (genome bottleneck) and grants the environment unlimited entropy, where this page bounds learnability by the environment's own `K(µ)`.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the same AIT toolkit aimed at scoring rather than believing, and the direct antagonist ([[wiki/empirical-tensions.md]] T16): the shortest program consistent with the training curriculum is argued to be precisely the one that fails at evaluation.
- **[[wiki/concepts/energy-based-models.md]]** — the same simplicity argument in continuous form: bounding a latent variable's information content bounds the number of hypotheses it can name, so volume-minimising regularisers are description length applied to an energy landscape rather than to a program.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the computable descent from this page: replace `K` by an actual model's code length and the Solomonoff construction becomes a measurement, with Chinchilla 70 B beating PNG and FLAC on modalities it never saw (Delétang et al. 2023).
- **[[wiki/concepts/intelligence-density.md]]** — the same `K` turned on outputs instead of environments: `K(o₁\|o₂) ≈ K(o₁)` is used there as an independence filter deciding what counts as a distinct output, with `K` reinterpreted as the limit an ever-better interrogator approaches rather than a quantity to compute.
- **[[wiki/concepts/divergence-objectives.md]]** — the practical floor and the ideal one: the unestimated `H(P)` term dropped from every cross-entropy loss is exactly the irreducible uncertainty this page bounds convergence toward via `K(µ)`.
- **[[wiki/concepts/program-induction.md]]** — the tractable family this page is the limit of: bounding the program class by a hand-authored domain-specific language is what buys computability, and the passive/active split is the guarantee those systems inherit.
- **[[wiki/entities/neo-neural-theorizer.md]]** — the simplicity prior out of the limit and into a working system, with a measured wrong side: `λ_MDL^k · ℓ` selects program length per instance, and raising the weight 20% buys short *entangled* programs instead of short compositional ones ([[wiki/empirical-tensions.md]] T155).
- **[[wiki/concepts/representational-collapse.md]]** — the continuous form of the same description-length move: restricting a latent's information content is bounding the bits available to name a hypothesis.
- **[[wiki/concepts/external-verification.md]]** — the limit case in verifier vocabulary: the ideal inductor's acceptance test is an internal prior over programs rather than an external check, which is exactly why completeness holds on the passive slice and dies the moment the learner's outputs shape its data.
- **[[wiki/concepts/independent-causal-mechanisms.md]]** — the criterion this page's simplicity prior is missing, in this page's own currency: causal structure is an *additive decomposition of the joint Kolmogorov complexity*, so the requirement is not that the description be short but that its modules not help compress each other — vanishing algorithmic mutual information, orthogonal to shortness, and the version of "compression ≠ structure" that names what the extra constraint would be.
- **[[wiki/concepts/computational-reuse.md]]** — Solomonoff 1964's incremental induction is a cache: the past is folded into a modified machine so only new data is coded. The paper's warning, that a useful summary is lossy and a frequency table cannot see an exact repeat, is that page's correctness-of-cache condition: a cache of sufficient statistics is exact only under the model that licensed it.
- **[[wiki/concepts/resource-rationality.md]]** — the founder's stance on the ideal prior is bounded optimality applied to the prior itself: a time-capped, computable approximation that gives reasonable values is to be preferred to Eq. 1. The cap on operations `τ` is a resource term inside the hypothesis prior.
- **[[wiki/concepts/inductive-bias.md]]** — the finite-capacity descent from this page: replace the mixture over all computable environments with a *family* of hypothesis spaces and `K(µ)` with a covering number `C(ε, H)`, and dominance is lost but the bias becomes estimable from a sample of tasks; the arbitrary choice of reference machine `U` here is the arbitrary hyper-bias there (Baxter 2000).
- **[[wiki/concepts/causal-states.md]]** — the ensemble alternative argued for *against* this page's object: Kolmogorov complexity is defined on one sequence, demands exact reproduction, is uncomputable and is maximal for random strings, so it measures randomness rather than pattern. Causal states keep the passive, stationary slice, are computed from `P(↔S)`, and select the minimal predictive partition rather than the shortest program (Shalizi & Crutchfield 2001).
- **[[wiki/concepts/predictive-information.md]]** — the ensemble, continuous-parameter case this page's bound does not reach. Solomonoff's cumulative squared error converges because a computable `µ` has a finite description. A parameter drawn from a continuous prior has none, so specifying it to the precision the data support costs `½log₂N` bits per effective dimension, and the learner's cumulative excess code length grows as `(d/2)log₂N`, or as a power for nonparametric classes. That source's objection to Kolmogorov complexity, that it tracks entropy and so measures randomness, targets `K(x)` of a sequence, not `K(µ)` of the environment, which is the quantity in this page's bounds (Bialek, Nemenman & Tishby 2001).
- **[[wiki/concepts/simplicity-principle.md]]** — this page's prior offered as a psychological hypothesis, with evidence from perception, concept learning, language and similarity. Its two obstacles to testing are this page's machine dependence (the *representation* problem: at finite data the code language decides which pattern is shortest) and uncomputability (the *search* problem: the mind prefers the simplest pattern it can find) (Chater & Vitányi 2003).
