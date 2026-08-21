# Conceptors — a concept as a soft subspace of a recurrent network's own state space

**Drive a reservoir with a pattern, take the correlation matrix `R = E[xx']` of the states it visits, and regularise it into `C = R(R + α⁻²I)⁻¹`. `C` is a positive semi-definite matrix with all singular values in `[0,1]` — an ellipsoid inside the unit sphere. Insert it back into the update loop, `x(n+1) = C tanh(Wx(n) + b)`, and the network re-generates that pattern and no other. Because every `C` has the same type, they can be combined with `∧ ∨ ¬` and ordered by abstraction — so a logic is *read off* a running dynamical system rather than *coded into* one.**

> **Provenance.** `raw/jaeger-2014-conceptors.md` — Herbert Jaeger, *Controlling Recurrent Neural Networks by Conceptors*, Jacobs University technical report, arXiv:1403.3369 (v4, revision note dated November 2024). A single-author 200-page report: theory, ~10 simulation demonstrations, proofs. One machine-learning benchmark (Japanese Vowels); everything else is synthetic. Reservoirs are `N = 10–500` units throughout.

This is the wiki's only mechanism where **the same object is simultaneously a filter on the dynamics, a description of the data, and a term in a logic** — and the only one where a store's own occupancy is a readable number.

---

## The object

| Component | Statement |
|---|---|
| Substrate | Standard reservoir: `x(n+1) = tanh(W*x(n) + W^in p(n))`, `W*` random, `W^out` a trained linear observer |
| **Loading** | Recompute `W*` → `W` by ridge regression so that `W x^j(n) ≈ W*x^j(n) + W^in p^j(n)` for **all** loaded patterns `j` — the driver is internalised into the recurrence. Standalone this is useless: a loaded reservoir run free cannot decide which pattern to emit |
| **Conceptor** | `C(R, α) = R(R + α⁻²I)⁻¹`, `R = E[xx']` the state correlation matrix under driver `p` |
| Equivalent definition | The unique minimiser of `Σ_n ‖x(n) − Cx(n)‖²/L + α⁻²‖C‖²_fro` — a **regularised identity map** on the visited states. First term pulls `C → I`, second pulls `C → 0` |
| **Retrieval** | `x(n+1) = C^j tanh(Wx(n) + b)`, no input. State components in low-singular-value directions are damped; the loop settles into `p^j` |
| Aperture `α` | `C(R, α) = C(α²R, 1)` — scaling `α` *is* scaling the reservoir signal energy by `α²`. The optical metaphor is exact |
| Singular values | `s_i = σ_i/(σ_i + α⁻²)`; the `tanh` nonlinearity drives most `s_i` toward 0 or 1, so `C` comes out "almost a projector" |

Two design facts that matter more than the algebra. **The pattern is not stored in the landscape.** `W` holds a superposition of every loaded pattern and by itself produces unpredictable dynamics; what selects a pattern is a matrix *in the feedback path*. And **retrieval is by constraint, not by relaxation**: nothing settles to a fixed point — the network runs a periodic or chaotic orbit that `C` confines to a subspace.

### Aperture is the only hyperparameter, and it has an intrinsic criterion

| | |
|---|---|
| Too small | The loop is over-constrained; patterns **de-differentiate** |
| Too large | The loop is over-excited |
| Setting it without held-out data | **Attenuation** — the damping ratio `C` imposes on the reservoir signal. Its *minimum* over `α` marks conceptor/reservoir resonance |
| Tolerance | Visibly good re-generation over ~1 order of magnitude in `α`; ~3 orders once small singular values are zeroed |

The attenuation criterion is the payload for the wiki: a hyperparameter set from a quantity **computed inside the loop, with no task performance, no labels and no validation split**. Every gain, temperature and sparsity level elsewhere here is exogenous ([[wiki/concepts/attractor-dynamics.md]], G38).

---

## Boolean operations, and what they are actually for

If a reservoir is driven by randomly alternating epochs of `p` and `q`, then `C(R_r, 1) = C((R_p + R_q)/2, 1)` — the OR of two conceptors is *derived* from a statistical fact about the driving signal, not stipulated:

```
C₁ ∨ C₂ := (R₁ + R₂)(R₁ + R₂ + I)⁻¹        ¬C := I − C        C₁ ∧ C₂ := ¬(¬C₁ ∨ ¬C₂)
A \ B := A ∧ ¬B
```

Associativity, commutativity, double negation, De Morgan and *some* absorption laws hold — Jaeger claims "many laws of Boolean logic", not a Boolean algebra.

**Abstraction ordering.** `A ≤ B` in the Löwner order (`B − A` positive semi-definite). Then: `A` is a conceptor iff `0 ≤ A ≤ I`; and `A ≤ B` ⟺ `∃C: A ∨ C = B` ⟺ `∃C: A = B ∧ C`. That is the textbook definition of "B is more abstract than A", obtained from a matrix inequality on data-derived operators. Conceptors therefore form a lattice-like hierarchy that is **computed, not authored** — the wiki's other abstraction hierarchies ([[wiki/concepts/policy-abstraction-hierarchy.md]], core-knowledge domains) are all stipulated by the designer.

### The semantics claim: no ontological gap

In classical logic a symbol's meaning is its *extension* — a set of entities of a different ontological type from the symbol. For a conceptor, the meaning of `C` is the shape of the neural state cloud it came from, i.e. `R`; and `C` and `R` are **the same type of object** (PSD matrices of the same dimension). Jaeger formalises this as *intrinsic conceptor logic* in the framework of institutions, with two consequences worth carrying:

- The logic is a **dynamical system in its own right** — its symbols evolve over time, unlike the static tokens of every other logic.
- It is **decidable**, and concept subsumption is `O(N)`: with random-feature conceptors it reduces to checking `c_i ≤ c'_i` componentwise, one pass. Jaeger offers this as an account of why human classification judgements are near-instantaneous.

This is the closest thing in the wiki to a mechanism where a symbol and its referent are not connected by an interface. Jaeger's framing of the contrast: prior neuro-symbolic work *codes* a logic **into** a specialised network; conceptors *instantiate* the logic **of** a generic one.

---

## What was demonstrated

| Demo | Setup | Result |
|---|---|---|
| **Multi-pattern generation** | `N = 100`, 4 drivers (two near-identical sines, two near-identical 5-periodic randoms), `α = 10` | MSE 3.3e-05 / 1.4e-05 / 0.0040 / 0.0019. Separates both near-twin pairs |
| **Chaotic attractors** | `N = 500`, Lorenz + Rössler + Mackey-Glass + Hénon in **one** reservoir | Re-generated from the minimum-attenuation aperture. Jaeger notes training a single RNN on several chaotic attractors had not been attempted before |
| **Morphing / extrapolation** | `M = Σ μ^j C^j`, `Σμ^j = 1`, `μ` swept from −0.5 to 1.5 | Interior `μ` interpolate; **negative `μ` extrapolate outside the convex hull of the four loaded prototypes and still produce coherent patterns** |
| **Incremental memory** (integer-periodic) | 16 patterns, periods 3–15, `N = 100`, `α = 1000` | Patterns 5–7 were replicas of 1–3 and consumed **zero** additional quota. Failure at `j = 16` when quota ≈ 0.99; previously loaded patterns **unharmed**. Incremental mean NRMSE 0.078 vs 0.063 simultaneous |
| **Incremental memory** (2-parameter family, irrational periods) | 16 patterns, `N = 100`, `α = 1.5` | First 4 patterns cost quota 0.52; the next 12 cost only 0.26 — the reservoir has learned "how to oscillate in sine mixes" and pays only for the new instance. 0.136 vs 0.131 simultaneous |
| **Incremental memory** (mixed/arbitrary) | Alternating 5-periodic and parametric-family patterns | **Breaks down** unless the conceptor singular value spectra are first rectangularised (`σ̃ = tanh(50(2σ−1))/2`). With that fix: incremental 0.094 vs **simultaneous 0.19** |
| **Classification** | Japanese Vowels: 9 speakers, 12 channels, 30 train recordings each, 370 test; reservoir of **10 units**; patterns *not* loaded | 3.4 misclassifications (mean of 50 random reservoirs) vs state of the art 4–10. Positive evidence alone: 8.4. Negative alone: 5.9. Training takes a fraction of a second |
| **Content-addressable memory** | `N = 200`, 5 patterns from a 2-parameter family; 30-step cue then 10,000 steps of free-running auto-adaptation, **state noise at SNR = 1** | log10 NRMSE −0.4 (post-cue) → −1.1 (post-adaptation). Auto-adaptation provably drives many singular values to zero, which is exactly what kills the noise in those directions |
| **Class learning effect** | Same reservoir loaded with `k = 2…100` patterns from one family, then cued with **unloaded** patterns from the same family | Novel-pattern recall is worse than loaded-pattern recall only for small `k`; **above a threshold the two are equal** — the network stops rote-storing instances and represents the parametric class |
| **Hierarchical de-noising + classification** | 3 random-feature layers, 4 candidate generators, SNR = 0.5 (noise twice the signal) | Settles on the correct hypothesis and emits near-clean output; beats a linear transversal filter with the *same number of trainable parameters* (`K = 2600`) on both accuracy and response time |

### The two evidence channels — negation earns its keep

`E⁺(p,j) = x'C^j x` (how well the response fits `C^j`'s ellipsoid) and `E⁻(p,j) = x'N^j x` where `N^j = ¬(C¹ ∨ … ∨ C^{j−1} ∨ C^{j+1} ∨ … ∨ C⁹)`. Combined evidence more than halves the error of either channel alone. Two things follow.

The rejector is **constructed by logic from the positive models**, not trained. Every discriminative classifier gets its contrast by seeing the other classes' data during training; here `N^j` is a Boolean expression over already-built `C^i`, so adding a tenth speaker requires only that speaker's data — the recogniser is **pattern-locally trained and incrementally extensible**, which Jaeger notes is missing from essentially all state-of-the-art classifiers. This is a concrete instance of the rejector G68 asks for, and its cost is one OR-fold per class.

---

## Trust: precision weighting, derived from a different direction

The hierarchical architecture carries a scalar `τ_{[l,l+1]} ∈ [0,1]` between each pair of layers, adapted online from locally observable noise ratios:

```
u_{[l]}  = τ_{[l−1,l]} · y^auto_{[l]} + (1 − τ_{[l−1,l]}) · y_{[l−1]}     (which signal to believe)
c_{[l]}  = (1 − τ_{[l,l+1]}) · c^auto_{[l]} + τ_{[l,l+1]} · c_{[l+1]}     (which hypothesis to believe)
c_{[3]}(n) = γ¹(n)c¹ ∨ … ∨ γ⁴(n)c⁴,  Σγ = 1                              (the top-layer belief)
```

High trust ⇒ the layer ignores what arrives from below and self-generates. `τ → 1` is **confabulation** — a perfectly clean signal produced under a possibly wrong hypothesis, and Jaeger says so explicitly. In the run, `τ_{[2,3]}` drops briefly at each pattern switch, letting the external signal permeate upward, then rises back to ~1.

Jaeger's own generalisation: *"maintaining a measure of trust … is an intrinsically necessary component in any signal processing architecture which hosts a top-down pathway of guiding hypotheses."* That is [[wiki/concepts/precision-weighting.md]]'s central claim reached from control theory and signal-to-noise ratios rather than from variational inference, in a system with no probability distribution anywhere in it. The convergence is the interesting part: **precision is what any top-down architecture needs, not what Bayes specifically needs.**

---

## Random feature conceptors — the biologically-not-impossible version

Matrix conceptor adaptation needs non-local computations, and a `C` is `N×N`, i.e. the size of `W`: *storing a concept costs a network*. The fix replaces `W` by a dyad of random projections `F` (reservoir → feature space) and `G` (back), with the conceptor becoming a **vector** of scalar *conception weights* `c_i`, one per feature neuron, multiplied into that neuron's own state.

| | |
|---|---|
| Locality | Every quantity needed to adapt `c_i` is available at that unit. All Boolean operations and aperture laws carry over |
| Compression | A whole dynamical pattern = **one neuron's outgoing connections to feature space**, so a pattern can be addressed by a single unit |
| Feature count | 2–5× the reservoir size |
| Cost | Same re-generation accuracy, but **aperture setting becomes more sensitive** |

---

## Limitations (all stated at source)

| Limitation | Detail |
|---|---|
| Matrix conceptors are network-sized and non-local | Biologically implausible; RFC is the escape and pays in aperture sensitivity |
| Incremental loading is not general | Fails for arbitrary patterns unless singular value spectra are rectangularised by thresholding — an extra, hand-set step (`tanh(50(2σ−1))`) |
| Scale | `N = 10–500`, ≤16 stored patterns, one real benchmark. "The usefulness of conceptors … will only be established by a suite of successful applications" |
| Signal class | Almost everything is stationary, single-channel, periodic or chaotic. Japanese Vowels is the only non-stationary, multi-dimensional, finite-duration case |
| **No composition operator across modules** | Conceptors have `∧ ∨ ¬` but no *product*. Building an architecture from several conceptor modules of different dimension would need "semi positive-definite tensors", a theory Jaeger says is in its infancy. So the mechanism does not compose the way a symbol system must |
| Linearity | `C` is a PSD linear map. Affine (`μ, C`) and nonlinear filter versions are proposed and immediately disclaimed: it is not clear how the logic transfers to either |
| Autoconceptor stability | The fixed-point analysis is explicitly "preliminary and incomplete"; the reservoir–conceptor interaction off the fixed point is not characterised |
| The reservoir is still a reservoir | Contractive, fading-memory, driver-locked ([[wiki/entities/simple-cycle-reservoir.md]]) — conceptors select *which* orbit, not what class of orbits is reachable |

---

## Comparison

| | Hopfield / attractor CAM | Conceptor CAM | Vector-symbolic binding |
|---|---|---|---|
| What is stored | Static patterns as fixed points of `W` | **Dynamical patterns**, as subspaces selecting among orbits of a shared `W` | Role–filler structures as one vector |
| Incremental storage | No — the rule rewrites all weights | **Yes**, with an explicit quota and no damage to prior items | Yes (superposition), until crosstalk |
| Combination operator | None (mixtures are spurious states) | `∧ ∨ ¬` + Löwner abstraction order, with a semantics | `⊛` bind, `+` superpose; no negation, no ordering |
| Retrieval | Relaxation to a fixed point | Constraint of an ongoing orbit — nothing settles | Unbinding + clean-up memory |
| Knows when it is full | `p_max` known a priori, overload catastrophic | **Reads its own occupancy at run time**, overload spills onto the last item only | Crosstalk grows silently |
| Graded / partial membership | No | `α` and the singular value spectrum are continuous | Similarity is a dot product |

---

## Relevance to a reasoning model

- **A store that reports its own occupancy.** `A^j = C¹ ∨ … ∨ C^j`, `q = (Σ_i s_i(A^j))/N ∈ [0,1]`. Nothing else in the wiki lets a fast store answer "how full am I?" at run time from its own contents (G42), and the number is *derived from the logic*, not instrumented separately. What it enables is the missing half of allocation: write the **logical difference** `C^{j+1} \ A^j` into the **unclaimed space** `¬A^j`, so allocate-vs-reuse is decided by the geometry of what has already been stored rather than by a designer-set sparsity or novelty threshold (G38). The redundancy measurement is the proof it works: an exact replica costs nothing, and the 5th–16th member of a parametric family costs half what the first four did.
- **The discretisation is a lattice of soft regions, not a set of nodes.** G27 asks what supplies the nodes and edges a graph formalisation presupposes. Conceptors supply something of a different type — a partially ordered family of *overlapping* subspaces with graded membership, closed under `∧ ∨ ¬`, and computed from a continuous stream with one hyperparameter. The abstraction order is a genuine discovered edge set, but it is over *concepts*, not over states, and it has no relational structure: `C_dog ≤ C_animal` is expressible, `bites(dog, man)` is not.
- **Extrapolation from a handful of examples, with the knob exposed.** Negative mixing coefficients leave the convex hull of the prototypes and still produce coherent patterns; this is generalisation *outside* the training data obtained by arithmetic on stored descriptions rather than by more data. The cost of admission is that the prototypes must share a substrate.
- **Memorisation and generalisation are the two ends of one load axis.** The class-learning effect says a store transitions from rote instance recall to representing the parametric class **as it is overloaded**, and after the transition unloaded members of the class are recalled as well as loaded ones. Every capacity account in the wiki treats approaching capacity as approaching failure.
- **(brainstorm)** The one transplant worth trying outside reservoirs: `C = R(R + α⁻²I)⁻¹` needs only a state correlation matrix, so it is definable for *any* recurrent or layered system whose activations can be collected under a condition — and `∨` needs only `R₁ + R₂`. That makes "the set of directions this network uses when doing X" a first-class, composable, orderable object for a transformer as much as for a reservoir. The revision-4 note that the incremental-learning scheme has since been carried into deep feedforward networks (Xu 'Owen' He) is the first evidence the substrate is not load-bearing. What does not transplant is the *retrieval* half: inserting `C` into the loop presupposes an autonomous generative dynamics to constrain.

---

## Connections

- **[[wiki/concepts/attractor-dynamics.md]]** — the rival account of "a stable state the network can be put into", and the one conceptors answer a standing objection to: because the selected orbit is defined by a matrix in the feedback path rather than by the weights, changing `C` *leaves* it, which is Jaeger's response to the perennial problem that a cognitive trajectory cannot depart an attractor without contradicting what makes it one.
- **[[wiki/concepts/autonomous-pattern-generation.md]]** — supplies the two things a driven reservoir provably cannot do on its own: hold many trajectories in one substrate and select among them at a commanded time, and start a pattern from a brief cue rather than from a clock. The conceptor is the run-time conditioning variable that page names as missing.
- **[[wiki/entities/simple-cycle-reservoir.md]]** — the boundary that still applies: conceptors control a contractive fading-memory substrate, so they choose which orbit is expressed and cannot enlarge the class of expressible orbits.
- **[[wiki/entities/hopfield-network.md]]** — the content-addressable memory conceptors are explicitly positioned against: same job, but static patterns, no incremental storage and no combination operator, where conceptor CAM has all three and additionally works at SNR = 1.
- **[[wiki/concepts/continual-learning.md]]** — a solution family that page did not have: subspace allocation by logical difference, with occupancy readable, redundancy exploited automatically, no task boundary, no importance estimate and no exemplars — plus the anomaly that on mixed patterns incremental loading *beat* simultaneous loading (0.094 vs 0.19).
- **[[wiki/concepts/precision-weighting.md]]** — the same quantity derived without Bayes: `τ` is a per-link scalar mixing bottom-up signal against top-down hypothesis, adapted online from noise ratios, with `τ → 1` producing confabulation — an independent arrival at precision as the thing any top-down architecture must carry.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — a hierarchy with a top-down pathway carrying *hypotheses* (a conceptor is passed down as a prior on which subspace the layer below should occupy) and a bottom-up pathway carrying progressively de-noised signal, built with no generative model and no free energy.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the other route from vectors to symbols in the wiki, and the complementary one: VSAs bind roles to fillers and cannot negate or order concepts; conceptors negate, order and subsume but have no binding operator and, by Jaeger's own account, no product with which to build one.
- **[[wiki/concepts/population-geometry.md]]** — the measurement this mechanism turns into a control signal: a conceptor *is* the shape of a population's state cloud, so the geometry that page reads out becomes an operator that can be inserted back into the dynamics, combined logically and ordered by abstraction.
- **[[wiki/concepts/external-verification.md]]** — supplies a rejector built by construction rather than trained: `N^j = ¬(∨_{i≠j} C^i)` is a negative-evidence channel assembled from the positive models already stored, and combining it with positive evidence more than halves the classification error of either alone (G68).
- **[[wiki/concepts/linear-representation-hypothesis.md]]** — the same commitment to directions-in-activation-space as the carrier of content, taken one step further: a *set* of directions with graded weights is the represented object, and the operations on it are logical rather than arithmetic.
- **[[wiki/concepts/latent-graph-discovery.md]]** — contributes a node-set of a different type from the framing's: overlapping soft regions ordered by abstraction and closed under Boolean operations, discovered from a continuous stream — with no relational edges between the entities inside them.
- **[[wiki/concepts/memory-read-and-erase.md]]** — supplies the precondition a removal policy needs and that no other machine store has: quota `q = Σs_i(A^j)/N` read from the store's own contents, with novelty as the Boolean difference `C^{j+1} ∧ ¬A^j` — a relevance-like test computed at *write* time, where every biological result on that page places it at *erase* time.
