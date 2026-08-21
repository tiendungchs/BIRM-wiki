# Sparse Distributed Representations (SDRs)

**A binary code of very high dimension `n` in which only a tiny fraction `a/n` of bits is active, and whose distinguishing property is *not* efficiency but the arithmetic of overlap: a random subsample of ~25 bits identifies a 300-bit pattern out of a million stored ones with a false-positive rate below 1 in 10⁹, and the same subsample tolerates corruption of half the bits it looks at.**

The wiki has assumed sparse codes everywhere — dentate output, CA3 storage, SDM hard locations, the fast store in [[wiki/concepts/complementary-learning-systems.md]] — and priced them in *capacity* (how many patterns fit). This page carries the other half of the account: the **recognition** side, where sparsity plus high dimensionality buys the ability to detect a pattern from a fraction of it, and where the error rates are closed form.

> **Provenance.** `raw/ahmad-2016-sparse-representations-active-dendrites.md` — Ahmad & Hawkins, *How do neurons operate on sparse distributed representations? A mathematical theory of sparsity, neurons and active dendrites*, Numenta, 2016. A theory paper: scaling laws derived analytically, verified by 10⁷–10⁸-sample Monte Carlo, then used to predict a measured biological constant.

---

## The formalism

| Symbol | Meaning | Biological range |
|---|---|---|
| `n` | Dimension — number of *potential* connections | 10³–10⁵ |
| `A_t` (`a = \|A_t\|`) | Presynaptic activity, binary, sparse | `a/n` = 0.5–3% |
| `D` (`s = \|D\|`) | The stored pattern: a binary vector of *actual* connections, `s ≪ a` | `s` = 20–300 |
| `θ` | Detection threshold | 8–20 |
| Match | `D · A_t ≥ θ` — a binary dot product, i.e. **set overlap** | NMDA spike |

Three departures from the wiki's default memory model, all consequential:

1. **The stored pattern is a subsample of the pattern to be recognised** (`s ≈ 30` synapses for `a = 300` active cells — a tenth). Storage cost is decoupled from pattern size.
2. **Non-connected activity has no effect.** Unlike a weight vector with zeros, a bit outside `D` cannot contribute — the comparison is over `s` coordinates, not `n`. This is what makes the store cheap and what makes the union property below work.
3. **The metric is overlap on binary vectors, not Euclidean distance on scalars.** Prior sparse-coding theory (Rolls & Treves 1990; Babadi & Sompolinsky 2014) used a weighted linear sum, which is why it did not find these error rates.

Given the model, the overlap of a random `s`-subset with an `a`-subset of `n` is hypergeometric, so `P(false match) = P(overlap ≥ θ)` is a tail sum of hypergeometric terms and `P(false negative)` is the same tail evaluated after `v` active bits are swapped out. Both were verified against 10⁷–10⁸ random trials with "virtually no difference between theoretical and experimentally observed" rates.

---

## The scaling laws — what actually buys the robustness

| Result | Statement | Numbers |
|---|---|---|
| **Error falls faster than exponentially in `n`** | Holding sparsity and `s` fixed, increasing dimension collapses the false-positive rate | Essentially zero once `n > 2000` |
| **Error falls exponentially in `s`** | Each added synapse multiplies the error down; the curve saturates | 20–25 synapses suffice for extremely low error **at `θ = s/2`, i.e. tolerating 50% noise** |
| **Dense codes cannot do this at all** | At 50% activity the same subsampling gives high error at every `n` | The dashed line in every figure |
| **Small-and-sparse also fails** | `a = 32, n = 128` is high-error | Both conditions are needed, neither alone |
| **Population capacity** | `M` independent segments, each storing one pattern: `P(A ∈ S) ≤ M · P(match)` — a tight bound | `n = 10⁴`, `a = 300`, `s = 30`, `θ = 15` → **10⁶ patterns discriminated at a false-positive rate better than 1 in 10⁹** |

**The headline for a builder.** Convert anything into decorrelated high-dimensional SDRs, store a ~25-bit subsample of each, and near-perfect classification of ~10⁶ patterns follows *with no learned weights, no training, and no distance computation over the full vector*. The cost is entirely in the encoder that produces the SDR — the same conclusion Kanerva reached from the other direction ([[wiki/entities/sparse-distributed-memory.md]]: "the encoder is the major function").

---

## The union property — one slot, many patterns

Take the Boolean OR of `M` patterns into a single vector `X`. Membership is tested by the same `θ`-threshold overlap.

| Property | Consequence |
|---|---|
| **No false negatives, ever** | Any stored pattern still fires the detector, with up to `s − θ` bits of noise |
| False positives come from *mix-and-match* | `θ` bits drawn from several different stored patterns fire it spuriously |
| Occupancy after `M` unions | `P(bit still 0) = (1 − q)^M` with `q = a/n`; expected ON bits `= n(1 − (1 − q)^M)` — **identical to the Bloom-filter false-positive calculation** (Bloom 1970), and to Willshaw-network analysis |
| It works because the vector stays mostly empty | `n = 20,000`, `a = 100`, `s = 25`, `θ = 15`, `M = 10`: under 250 synapses, **98.75% of bits still zero**, negligible false-positive rate |
| Dimension is the critical parameter | Same union at `n = 1000` → high error; at `n = 20,000` → extremely low error |

**The union is the wiki's cheapest set representation.** It answers "is `y` one of these `M` things" in one thresholded dot product, with `O(1)` read cost independent of `M`, and degrades by a computable error rate rather than by losing members. Compare the alternatives on this wiki: attention over a cache is `O(M)` per query ([[wiki/concepts/attention.md]]); a Hopfield store answers by relaxation and pays a capacity cliff ([[wiki/entities/hopfield-network.md]]).

**(brainstorm) A union is a *disjunctive* node type the wiki does not have.** Every stored item on this wiki is a point (a pattern, an attractor, a clone). A union is a set membership test with no enumerable members — exactly the right primitive for "any of the states that satisfy this predicate", which is what a rule or a schema needs when it is applied to an unbounded instance set ([[wiki/concepts/compositionality.md]], gap G18 on rule reification). The known price is stated and quantified: `M` between 4 and 16 before mix-and-match errors bite, and the threshold must *rise* with `M`.

---

## Errors are per-segment; classification is per-population

The paper's own scoping caveat, and it matters for how these numbers are read: every error rate above is for a single detector. Correct classification is always done by a population, which "can contain a significant number of incorrect false-positive activations without error in classification of the entire population". So a detector operating in an unacceptable error regime may still be a component of an accurate system — and conversely, no single-unit error rate licenses a system-level claim.

---

## What the theory assumes, and where that bites

| Assumption | Status |
|---|---|
| **Random, decorrelated activity** | The load-bearing one. Defended by decorrelation evidence (Hebbian learning + inhibition → principal components, Oja 1982; low measured pairwise correlation even for overlapping receptive fields; V1 sparsification and decorrelation under natural stimuli, Vinje & Gallant 2000). Correlation raises overlap above chance; the equations quantify how much is tolerable but were never extended to non-uniform distributions. Same exposure as T55 |
| **Binary synapses and binary activity** | Argued to be a lower bound: an `m`-valued code maps into `n log₂ m` binary dimensions, so scalar codes "can only add" — a bound, not a tight one. Whether real synapses are binary is unsettled (Petersen et al. 1998 vs. Enoki et al. 2009) |
| **Static — no learning rule** | The entire paper is recognition accuracy given a stored subsample. *Which* subsample gets stored, and when, is out of scope. Structural plasticity is invoked (the potential-connection pool ≫ actual connections) but not modelled |
| **Prototype = subsample** | Assumes the learning process picked `s` synapses onto cells active in the target pattern. Any allocation policy that does this at all inherits the error rates |

---

## Why this belongs to the core framing

For [[wiki/concepts/latent-graph-discovery.md]] the relevant operation is **node identification under aliasing and noise**: deciding that the current observation is (or is not) an already-known graph position. This page prices that operation exactly — the decision is a thresholded overlap over ~25 bits, the false-merge rate is computable, and the cost does not grow with the number of known positions until the union limit. It supplies nothing about where the codes come from (hardness sources 1–2 and 4–6 untouched) and everything about source 3, aliasing: two distinct positions with distinct SDRs will not be confused, at a rate you can name in advance.

---

## Connections

- **[[wiki/entities/hag-reservoir.md]]** — an empirical ceiling on the expansion-recoding premise this page shares with Cover's theorem: in grown reservoirs, effective dimensionality and class separability come apart, and past a dataset-dependent point extra principal components add noise rather than linear separability (Cazalets et al. 2025).
- **[[wiki/entities/sparse-distributed-memory.md]]** — the same statistics reached from the storage side rather than the recognition side: Kanerva's `pM` signal against `p²M` cross-talk is this page's overlap arithmetic with the roles of address and content swapped, and the two agree that high dimension plus sparsity, not plasticity, is what does the separating.
- **[[wiki/concepts/dendritic-computation.md]]** — the biological instantiation this theory was written for: each dendritic segment *is* one `θ`-threshold overlap detector, which is what turns these scaling laws into a prediction about a measurable constant.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the transfer curve for a subsampling detector, derived: `θ/s` sets the position on it (low `θ` completes and risks false positives, high `θ` separates and risks misses), and this page adds the constraint that *no* setting works at 50% density — separation is a property of the code's sparsity before it is a property of any threshold.
- **[[wiki/concepts/population-geometry.md]]** — the opposite regime and the reason the two must be kept apart: this page needs codes that are high-dimensional and decorrelated to make recognition cheap, while abstraction wants a low-dimensional manifold that makes generalisation cheap; the same population cannot maximise both, so where each is required is an architectural decision (T50).
- **[[wiki/concepts/complementary-learning-systems.md]]** — quantifies "sparse conjunctive code", the property that page's fast store is asserted to need: the interference-avoidance it invokes is the `p²M`-style overlap floor, and the numbers say ~25 bits per item is enough.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — supplies the actuator these laws presuppose: the active fraction `a/n` must be *held* near 0.5–3% for the error rates to hold, and inhibition is the only mechanism on the wiki that regulates it at runtime.
- **[[wiki/concepts/attention.md]]** — the contrast on read cost: attention scores every entry in a cache to retrieve one, whereas a union answers set membership in one thresholded dot product independent of set size — cheaper, but it returns a bit rather than a value.
- **[[wiki/entities/hopfield-network.md]]** — recognition without relaxation: the same job (is this cue one of the stored patterns) done by a feed-forward threshold with a computable false-positive rate and graded overload, against energy descent with a capacity cliff.
- **[[wiki/concepts/latent-graph-discovery.md]]** — prices the de-aliasing operation (hardness source 3): node identity from a fixed-size subsample, with the false-merge rate a named number rather than an empirical observation.
- **[[wiki/concepts/continual-learning.md]]** — the mechanistic reason sparse codes reduce catastrophic interference: two random sparse patterns overlap in almost no coordinates, so a write for one is nearly invisible to the detector for the other, and the residual interference rate is exactly the false-positive formula.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the same variables (`a`, fan-in, threshold) entering a *storage* capacity bound rather than a *recognition* error bound; read together they say a sparse code is bought once and paid for twice, and they disagree about what a neuron is (T63).
- **[[wiki/entities/dendritic-ann.md]]** — the same restricted-fan-in geometry (16 of 784 inputs per unit) priced in a different currency: not recognition error over binary codes but generalisation gap and parameter count on dense-valued supervised learning, where the structural sparsity outperforms dropout and early stopping as a regulariser (Chavlis & Poirazi 2025).
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — where the sparsity is enforced mechanically and what it costs: soft winner-take-all through perisomatic inhibition is the operation that holds the active fraction in the band these results require, and the 10–20% symmetric-synapse fraction — conserved from rat somatosensory to human temporal cortex — is a measured budget for it (Douglas & Martin 2004).
- **[[wiki/concepts/attractor-dynamics.md]]** — sparsity is what drives stored states near-orthogonal, and therefore what sets basin separation at write time.
- **[[wiki/concepts/recall-gated-consolidation.md]]** — derives a coding level from a different objective: `f* ∝ λ` (the recurrence rate of the memory being stored), obtained by maximising the separability of reliable from unreliable *update patterns* rather than by minimising interference between stored items — and it therefore predicts a specific sparsity *gap* between a fast and a slow store rather than sparsity as such (Lindsey & Litwin-Kumar 2024).
- **[[wiki/entities/btsp-cam.md]]** — a store whose entire capacity argument is downstream of this page's regime: at `f_p = 0.005` (CA3 recordings, matched independently by <0.5% active in monkey V1 for natural images) binary weights and a single threshold suffice for Hopfield-class content-addressable recall, and the result is stated only for sparse codes.
- **[[wiki/concepts/engram.md]]** — the biological store that runs on these statistics, and the one place where overlap is *wanted*: relations between memories are stored as intersections of sparse write sets, which makes this page's union bound (4–16 patterns before mix-and-match errors) the wiki's only estimate of how many edges one trace can carry before the relation becomes indistinguishable from interference.
- **[[wiki/entities/trnn.md]]** — sparsity applied to the *connectivity* rather than the code: a 0.8 inter-block / 0.9–1.0 intra-block connection ratio is one of three knobs that push a trained recurrent net out of persistent firing, with a non-linear effect on the transient index (Liu et al. 2025).
- **[[wiki/entities/pfc-columnar-planning-model.md]]** — sparsification measured along a cascade rather than assumed: hippocampal place cells → fine columns → coarse columns raises field size and per-unit information while cutting population size, with the fine stage retaining ~85% of the theoretical population-information bound — an operational stopping point for how far to compress (Martinet et al. 2011).
- **[[wiki/concepts/compositionality.md]]** — the consumer of this page's disjunctive primitive: a Boolean-OR union tests membership in a pattern set without enumerating it, which is the representation a rule needs over an unbounded instance set — bounded at 4–16 patterns per slot before mix-and-match errors bite.
- **[[wiki/entities/hami.md]]** — the opposite bet on the same interference problem: rather than making overlap improbable in a high-dimensional sparse code, quantise each factor to a short exact-match symbol so overlap is *impossible*, which is what makes the read an O(1) content-addressable-memory query in silicon — at the cost of every graded-similarity property this page relies on (Poursiami et al. 2025).
- **[[wiki/concepts/retrieval-capacity.md]]** — the same dimension variable priced for a different property (how many distinct top-`k` subsets are addressable, not how accurately one item is recognised), and the measured cost of this page's regime: a high-dimensional sparse lexical store near-solves a task that 4096-dimensional dense embeddings fail, then loses >89% of that when the items are replaced by synonyms.
- **[[wiki/entities/barlow-twins.md]]** — the dense counterpart of the same redundancy-reduction principle (Barlow 1961 is the common ancestor): decorrelating the *components* of a dense code and near-disjointing the *supports* of a sparse one are two readings of "remove redundancy", and only the second buys this page's overlap arithmetic.
- **[[wiki/entities/simple-cycle-reservoir.md]]** — a second, non-statistical justification for expansion recoding: dimension is what literally *buys* architectural simplicity in the constructive universality proof (dilation depth `N+1` for memory, replication factor `k > nm` for sign-quantised input weights), independently of any Cover's-theorem separability argument.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the dense rival to the Boolean-OR union: superposition of convolution-bound pairs carries role structure and graded type similarity that a sparse union cannot express, and is limited by dot-product variance (bought off with dimension) rather than by mix-and-match error.
- **[[wiki/concepts/analogical-mapping.md]]** — the binding operator this regime was missing: context-dependent thinning composes sparse binary codes with OR, AND and fixed permutations at unchanged width, and — unlike a convolution binding — leaves the composite *similar to its constituents*, which is what makes nested structural similarity readable without unbinding; this page's chance-overlap formula is what tells it when two elements do not correspond at all.
- **[[wiki/entities/macfac.md]]** — the symbolic instance of this regime's scaling problem and two fixes it does not have: a content vector over a plausible 10⁵–10⁶-predicate vocabulary is reduced either by taking a *quotient of the representation language* (counting each predicate together with everything below it in a specialisation lattice) or by factorising into several per-subset vectors — dimension reduction by abstraction and by modularity rather than by random projection (Forbus, Gentner & Law 1995).
- **[[wiki/concepts/spike-encoding-schemes.md]]** — the temporal reading of this construct: in the spiking-encoding taxonomy an SDR is a *synchrony* code, its message being which subset is co-active at an instant rather than a static binary vector, with one-active-neuron-per-value (amplitude coding) as its degenerate limit (Auge et al. 2021).
- **[[wiki/entities/sigma-pi-reservoir.md]]** — sparsity chosen by the hardware rather than by coding theory: sparse block codes are picked for Loihi 2 because the chip charges for synapses, buying a `1/L` factor on the input embedding (`dD/L`) at the cost of `L`× more multiplicative neurons (`DL`) — a rare explicit exchange rate between a code's sparsity and its circuit size (Kleyko et al. 2025).
- **[[wiki/concepts/perturbation-elicitability.md]]** — what sparsity plus topographic contiguity costs in the other direction: a code whose active subset sits under one electrode is *locally addressable*, so a focal perturbation is itself a legal code word and reads out as content — the reason unimodal cortex is steerable by stimulation and transmodal cortex is not.
