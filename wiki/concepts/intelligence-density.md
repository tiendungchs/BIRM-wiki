# Intelligence Density

**`ℐ(S) = log₂N(S) / C(S)` — independent outputs per bit of description. The criterion is not the value but its scaling: a system *knows* a domain when `C` stays fixed while `log₂N` diverges as the domain grows, and *memorizes* when `C` must grow with the outputs it covers.**

The wiki's other measures score a learner against a task (`GD`/`P`/`E`, [[wiki/concepts/skill-acquisition-efficiency.md]]) or against a data stream (code length, [[wiki/concepts/prediction-compression-equivalence.md]]). This one scores the **system alone** — no environment, no reward, no curriculum, no labels. That is its whole value here and also its whole cost: it says nothing about correctness, and nothing about how the system got there.

> **Provenance.** Choi 2026, *A Quantitative Definition of Intelligence* (`raw/choi-2026-quantitative-definition-intelligence.md`). A philosophy-of-mind paper with worked numerical examples and no experiments; every number below is analytic, none measured.

---

## Formalism

| Object | Definition | Reading |
|---|---|---|
| **Description length** | `C(S)` in bits — program plus data needed to specify `S` | Turing machine: tape before execution. Network: parameters × bits per parameter. Lookup table: entries × bits per entry |
| **Intelligence density** | `ℐ(S) = log₂N(S) / C(S)` | `log₂` follows Boltzmann/Shannon: independent contributions add, so multi-domain coverage gives `log₂N_total = Σᵢ log₂Nᵢ` |
| **Independent outputs** | `o₁ ⊥ o₂` iff `K(o₁ \| o₂) ≈ K(o₁)` and `K(o₂ \| o₁) ≈ K(o₂)` | The filter that does all the work. A pseudo-random generator has `N_eff = 1` (the seed); a paraphrase pair counts once |
| **Knowing** | `S` knows `D` iff `C(S)` stays finite and `ℐ(S,n) → ∞` as domain size `n → ∞` | Applies to a **single fixed system**, not to a family whose `C` grows with `n` |
| **Memorizing** | `ℐ(S,n) → 0`: `C` grows at least as fast as `N` | A new, larger system is required for every expansion of the domain |

**`ℐ` is domain- and level-relative.** `ℐ(S)` is shorthand for `ℐ(S,D)`; the evaluation domain fixes the level of description (a Turing test selects the synaptic level, a study of cellular adaptation the molecular one), and once fixed both `C` and `N` are determined. Rescaling `C` by a constant (float32 vs float16) changes the snapshot value and not the divergence, which is why only the asymptotic reading is load-bearing.

**Kolmogorov complexity is reframed as the *idealized interrogator*.** `K(o₁|o₂)` is what a predictor with unlimited resources and optimal compression would find; real interrogators (compressors, language models, human experts) are computable approximations. Incomputability then blocks the exact value, not the criterion — the same relation the Carnot limit has to real engines.

---

## The four-way partition

| System | `C(S)` | `log₂N` | `ℐ` scaling | Status |
|---|---|---|---|---|
| Rock, river, pseudo-random generator | `>0` | `≈0` | `≈0` | No independent outputs |
| Lookup table (`n` entries) | `Θ(n)` | `Θ(n)` | `→0` | **Memorization** |
| `n`-bit adder circuit (family) | `O(n)` | `Θ(n)` | `Θ(1)` | **Computes, doesn't know** |
| XOR / AND / OR gate | `O(1)` | `Θ(1)` | `0.25` | Computes, fixed domain |
| Addition / multiplication algorithm | `O(1)` | `Θ(n)` | `→∞` | **Knows** |
| Chess engine (`M` squares), LLM, human brain | `O(1)` | diverges | `→∞` | **Knows** |

Worked values: XOR gate `ℐ = log₂2/4 = 0.25` exactly. Multiplication algorithm `C ≈ 667` bits (9×9 table + ~100 bits of carry and decomposition rules), `log₂N ≈ 6.6n`, so `ℐ ≈ 0.011 → 0.1 → 1.0` at `n = 1, 10, 100`. The 99×99 lookup table covering a *subset* of the same outputs costs `C ≈ 137,000` bits for `ℐ ≈ 0.0001`.

**The row that carries the architectural content is the third.** An `n`-bit adder computes addition correctly at every width and still does not *know* it, because doubling the input width requires a new circuit. This is the uniform / non-uniform divide of complexity theory: one Turing machine for all input sizes versus a different circuit per size. Two systems with **identical input-output behaviour on any finite domain** are classified differently — the paper's one novel prediction, and the only place its definition is falsifiable against ordinary engineering practice.

**Iteration is the minimal requirement for knowing.** Reuse is what separates the algorithm from the table — a carry rule stored once and applied at every digit position, for every pair, at every scale — and the mechanism that enables reuse is a loop. Choi's explicit consequence: *a feedforward network without recurrence, like a combinational circuit, has fixed input dimension, fixed domain, `ℐ = Θ(1)`*. This is weaker than Turing completeness (a bounded loop suffices) but strictly stronger than function evaluation.

**Overfitting gets a formal statement.** The 9,720 entries the 99×99 table holds beyond the 9×9 core are derivable from the smaller mechanism: they raise `C` without raising `N`, so `ℐ` falls. Same argument predicts that overparametrised networks prune and quantize with little loss — the removed parameters were redundant, and removing them *raises* `ℐ`.

---

## Duality with Kolmogorov complexity

|  | `K` | `ℐ` |
|---|---|---|
| Direction | output → minimum program | program size → maximum independent outputs |
| Measures | meaning **density** of one output | meaning **breadth** of one system |
| High value | non-redundant, incompressible | generative, generalizing |
| Low value | redundant | memorizing, lookup table |
| Incomputable because | finding the shortest program | deciding output independence (needs `K`) |

The compression literature ([[wiki/concepts/prediction-compression-equivalence.md]], [[wiki/concepts/universal-induction.md]]) establishes *compression requires intelligence*; this is the converse leg, *generalization constitutes intelligence*. Relation to minimum description length: MDL finds the optimal `C` for given data, `ℐ` measures the generative power of a given `C`. Whether the duality is more than rhetorical — an adjunction, a Galois connection — is left open.

---

## Against the wiki's other definitions

| Measure | What it needs | What `ℐ` claims |
|---|---|---|
| **Legg-Hutter `Υ`** ([[wiki/entities/aixi.md]]) | An environment class, a reward, a Solomonoff prior; uncomputable even for one XOR gate | `Υ` is a **special case**: under a fixed environment, reward = expected survival, and selection–mutation equilibrium, `Υ` is monotone in `ℐ` and induces the same ordering (Proposition 2). Evolution supplies the evaluator that `ℐ` does not require |
| **Skill-acquisition efficiency** ([[wiki/concepts/skill-acquisition-efficiency.md]]) | Priors, a task distribution, a curriculum, a developer to control for | Shares the core claim (intelligence is generalization, not memorization) but measures the **final state, not the path**. Chollet's own worry — that unlimited data buys arbitrary skill — is answered directly: a lookup table has `ℐ → 0` however much data produced it |
| **Integrated information `Φ`** | A partition of the system; measures consciousness, not intelligence | Aaronson's objection (grids of XOR gates score arbitrarily high `Φ`) does not transfer: minimal computation gets minimal `ℐ` |
| **Putnam's triviality** | — | Blocked by the independence condition. Relabelling physical states post hoc does not create independent outputs: if `t₁` dynamics determine `t₂` dynamics then `K(o_{t₂}\|o_{t₁}) ≪ K(o_{t₂})`, so a wall has `N ≈ 0` |

The Chinese Room falls out of the same move. The set of arithmetic questions expressible in Chinese is countably infinite, the rulebook has finite pages, therefore the arithmetic portion cannot be a table and must be an algorithm (Proposition 1). Intelligence is located **in the rulebook**, not in the person executing it — the executor is a CPU. Block's Blockhead is diagnosed by the same measure: `C = V^L·b`, `N = V^L`, `ℐ(L) = L log₂V / (V^L·b) → 0`; and at `V = 10⁴`, `L = 100`, `C > 10⁴⁰⁰` bits against ~`10⁸⁰` atoms in the observable universe. A second, cheaper kill: **a table cannot answer at the intersection of domains it did not store**, while one finite algorithm handles arbitrary cross-domain combinations for free.

---

## Meaning as correct function composition

The paper's semantic claim, and the part that touches [[wiki/concepts/compositionality.md]] directly:

- A task over domain `D` is a map from inputs to correct outputs; any system performing it implements `f_k ∘ … ∘ f₁`. **Syntax comprises exactly two things — the *selection* of primitives and their *ordering*.** Meaning over `D` is the selection and ordering that produces correct outputs for all of `D`. Nothing further.
- Multiplication: change the selection (swap carry for something else) or the ordering (accumulate before carrying) and outputs go wrong. That arrangement *is* what knowing multiplication consists of.
- Searle's Premise 3 ("syntax is not sufficient for semantics") is given a **conditional** answer rather than a refutation: syntax fails to constitute semantics exactly when the arrangement does not generalize (`C` grows with the domain); syntax *is* semantics when it does.
- **Sensorimotor grounding is one route, not a requirement.** For an embodied system the wall is the evaluator — a wrong composition produces observer-independent physical damage. For a multiplication algorithm the structure of arithmetic is the evaluator. Symbol grounding is a way to guarantee correctness, not a constituent of meaning. A Blockhead robot storing every sensor-motor pair fails on the same storage argument.
- Lineage claimed: Montague's compositional semantics, Curry-Howard (propositions as types, proofs as programs), and the distributional tradition (Saussure, Wittgenstein, Firth) with word embeddings as the empirical leg.

**Correctness is deliberately outside the measure.** `ℐ` counts independent outputs; whether they are right is the evaluator's business. "Creativity and hallucination are the same generative capacity, judged by different evaluators." A system with `ℐ(n) → ∞` producing wrong outputs is a *poorly calibrated generalizer*, not an unintelligent one.

---

## What this buys the framing

| Question the wiki asks | What `ℐ` supplies |
|---|---|
| Is there a labels-free, task-free score for a system? | Yes, and cheaper than [[wiki/concepts/prediction-compression-equivalence.md]]'s: no data stream needed either. But only the *qualitative* verdict (diverge / vanish) is obtainable |
| Does a model reuse structure or store answers? | The reuse/storage ratio *is* `ℐ`. **(brainstorm)** This is the closest thing in the wiki to a direct instrument for gap G26 — measure whether a model's coverage of a domain scales while its description stays fixed, rather than whether it predicts well |
| Why is the recurrence question architectural rather than aesthetic? | Because without a loop, domain size is pinned to input dimension, and `ℐ` cannot diverge. Recurrence is promoted from an efficiency choice to the minimal condition for knowing |
| What is the objective slot missing? ([[wiki/concepts/three-component-framework.md]], G30) | Not filled. `ℐ` is a *diagnostic*, not a trainable objective: `N` is defined through `K`, and the criterion is asymptotic, so there is no gradient to ascend |

**(brainstorm)** The genuinely portable idea is the **independence filter**, not the ratio. Every instrument in the wiki counts outputs, tasks or bits without asking whether they are the same output in different clothes; `K(o₁|o₂) ≈ K(o₁)` is a stated criterion for deduplicating a benchmark, a replay buffer, or a curriculum. A compression-based approximation of it is implementable today and would give [[wiki/concepts/skill-acquisition-efficiency.md]]'s scope-averaging a way to stop double-counting near-identical tasks — which is a smaller and more useful claim than the definitional one this paper is built around.

---

## Open problems

- **`N` has never been measured for any real system.** For an LLM `C` is trivial (parameters × bits) and `N` requires pairwise independence judgements over an unbounded output set via compression proxies — not attempted at scale, here or elsewhere. Every non-toy row of the partition table is asserted, not computed.
- **The paper's own two claims about frozen feedforward systems do not sit together.** §3.5 puts a non-recurrent network in the `ℐ = Θ(1)` "computes, doesn't know" class because its input dimension is fixed; §3.7 says a fixed-context LLM is "strictly speaking a very large fixed function" and still knows. Both cannot hold under Definition 3 without an account of what makes the context window an engineering constraint and the input layer a domain bound. Unresolved in the source, and it bears directly on [[wiki/entities/h-jepa.md]] and on the frozen-parameter compression results.
- **Binary independence is admitted to be wrong.** Under the graded reading (`K(o₁|o₂)/K(o₁)`) *every* fixed algorithm has `ℐ_eff = Θ(1)`, because the base facts are finite and all outputs are recombinations — the divergence in the headline table depends on counting recombinations as new. The lookup-table contrast survives (`Θ(1)` vs `→0`); the "brains and LLMs are on the `→∞` branch" claim is the part that is doing rhetorical work.
- **No account of construction.** `ℐ` scores an arrangement, not the capacity to build one — a hand-written algorithm and a network that learned the same function score identically, and the paper names *knowing vs. understanding* as future work. This is the wiki's process/artifact split arriving from the other side ([[wiki/empirical-tensions.md]] T20, gap G36).
- **Falsifiability is stated but untested.** The proposed empirical test — measure `ℐ` across calculators, expert systems, language models and humans, correlate against human judgements controlling for anthropomorphism — has not been run, and the paper concedes that a discrepancy could be read either as a defect of the metric or as a bias in human judgement, which is not a pre-registered criterion.

---

## Connections

- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the stated dual: that page measures how few bits a system needs to describe a stream, this one how many independent outputs a fixed description generates, and both bottom out in the same incomputable `K` from opposite sides.
- **[[wiki/concepts/universal-induction.md]]** — supplies the `K` that both the independence condition and the idealized-interrogator reading are defined through; where that page uses `K(µ)` to bound *learnability*, this one uses `K(o₁|o₂)` to decide what counts as a distinct *output*.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the direct rival on what intelligence is a property of: a conversion rate measured over a curriculum against a developer, versus a scaling property of the finished artifact with no curriculum and no developer in the picture ([[wiki/empirical-tensions.md]] T20).
- **[[wiki/entities/aixi.md]]** — claimed to subsume it: Legg-Hutter `Υ` is what `ℐ` becomes once an evolutionary environment supplies the reward signal `ℐ` does not require (Proposition 2), which is also the tightest statement in the wiki of what a reward specification actually adds.
- **[[wiki/concepts/compositionality.md]]** — the semantic half of this page: meaning over a domain *is* the correct selection and ordering of primitive functions, which makes compositional structure constitutive of knowing rather than a mechanism that happens to help.
- **[[wiki/concepts/latent-graph-discovery.md]]** — offers a scaling test for whether a recovered structure is real: a system holding the meta-graph covers an unbounded family of instance-graphs at fixed `C`, while one holding memorised instances needs `C` to grow with the family.
- **[[wiki/concepts/working-memory.md]]** — prices recurrence architecturally: without a loop the domain is pinned to the input dimension and `ℐ` cannot diverge, so an iterative controller is the minimal condition for knowing rather than an efficiency choice.
- **[[wiki/concepts/three-component-framework.md]]** — a candidate for the empty objective slot that does not qualify: `ℐ` is asymptotic and defined through `K`, so it diagnoses a finished design without supplying anything to optimise.
- **[[wiki/concepts/contextual-inference.md]]** — the memorising asymptote made architectural: a learner that answers novelty by allocating a new context grows its description length with the world, so a purely nonparametric repertoire sits at `ℐ(n) → 0` unless the contexts share structure (Heald et al. 2021).
- **[[wiki/entities/dendritic-ann.md]]** — a measured cut to the denominator: matching a dense network's outputs with 1–3 orders of magnitude fewer trainable parameters lowers `C(S)` without lowering `log₂N(S)`, and the saving comes from the architecture's *description* (two boolean masks) rather than from data or training (Chavlis & Poirazi 2025).
- **[[wiki/entities/kan-ode.md]]** — the second measured cut to the denominator, and the one with a *scaling exponent* rather than a single number: learning per-edge univariate basis functions instead of node weights gives `N⁻⁴` error-vs-parameters against an MLP's `N⁻²`, so the same outputs cost roughly the square root of the description length — and the curve **saturates** at 240 parameters, which is the finite-`C` behaviour this page's *knowing* criterion demands rather than the growing-`C` behaviour of memorising (Koenig et al. 2024).
