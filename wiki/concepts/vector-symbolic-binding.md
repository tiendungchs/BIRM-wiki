# Vector-Symbolic Binding

**Bind a role to a filler with an invertible, similarity-preserving algebraic operation on two `n`-vectors that returns an `n`-vector; superpose the bound pairs by addition. A nested relational structure of any depth is then one fixed-width vector, and the dot product of two such vectors is a cheap estimate of the similarity of the two *structures* — including, under one extra construction, their structural alignment.**

This is the operation the wiki has been assuming and never named. [[wiki/concepts/latent-graph-discovery.md]] needs an instance-graph to be *held* somewhere; [[wiki/concepts/subgraph-matching.md]] needs a stored structure to be *found*; [[wiki/concepts/abstract-structural-codes.md]] posits a `g`/`x` split and never says what joins the two back together. Vector-symbolic binding answers all three with one algebra, and its failure modes are as informative as its successes.

> **Provenance.** Plate, *Estimating analogical similarity by dot-products of Holographic Reduced Representations*, NIPS 7 (`raw/plate-1993-hrr-analogical-similarity.md`; the Holographic Reduced Representation (HRR) framework itself is Plate 1991/1994). Numbers below are that paper's; the analogy taxonomy and the two-stage retrieval architecture are Gentner & Forbus's MAC/FAC and SME as reported there. Some equations in the source are conversion-mangled and are restated here in their standard form.

---

## The algebra

**Circular convolution** `⊛` as the binding operator, on `x, y ∈ ℝⁿ`:

```
(x ⊛ y)_i = Σ_{k=0}^{n−1} x_k · y_{i−k}          (subscripts mod n)
```

A **compressed outer product**: the `n²` outer-product terms are summed along wrapped diagonals into `n` slots. That compression is the whole trick — a tensor product ([[wiki/entities/tolman-eichenbaum-machine.md]], [[wiki/concepts/tensor-product-representation.md]]) keeps all `n²` terms and grows exponentially with nesting depth; convolution does not grow at all. What the compression costs is now priced from the other end: the uncompressed binder admits an **exact, non-destructive** unbinding under mere linear independence of the role vectors (`Ψ(s)·u_i = f_i` with `{u_i}` the dual basis), probable from the *filler* side as well, where `†` is an approximate inverse in one direction only. Smolensky's own conclusion names the analysis of what discarding binder units costs as an open problem — circular convolution is one answer to it (fold along wrapped diagonals), not an independent scheme.

| Property | Statement | Why it is load-bearing |
|---|---|---|
| **Closure at fixed width** | `ℝⁿ × ℝⁿ → ℝⁿ` | A bound relation is the same size as an object, so it can be a *filler* of another role — recursion is free |
| **Commutative, associative, distributes over `+`** | behaves like multiplication | Superposition and binding form a ring-like structure; order of construction does not matter |
| **Approximate inverse** | `a†_i = a_{−i mod n}` (a permutation), and `a† ⊛ (a ⊛ b) ≈ b` | Unbinding = decoding: the structure can be *read*, not only compared |
| **Similarity-preserving** | `a ≈ a′ ⟹ a ⊛ b ≈ a′ ⊛ b` | Similar fillers in the same role stay similar after binding — this is what makes the dot product mean anything |
| **Randomizing** | `a ⊛ b` is unlike both `a` and `b` | A bound pair does not collide with its own parts in the superposition |
| **Preconditions** | elements i.i.d. `N(0, 1/n)`; `n` in the low thousands; normalise `⟨x⟩ = x/√(x·x)` after each superposition | The inverse and the dot-product statistics are asymptotic in `n`; below that, noise dominates — though the figure is a *decode-by-lookup* precondition and both directions have since been undercut: `D = 28` where nothing is unbound ([[wiki/entities/sigma-pi-reservoir.md]]), `N = 500` for a 630-combination product space where unbinding is done by iterative search ([[wiki/entities/resonator-network.md]]) |

**The two Hummel & Biederman 1992 objections to conjunctive coding are answered separately.** Exponential growth is killed by the compression. Insensitivity to attribute structure is killed by similarity preservation — an HRR *is* a conjunctive code, just one whose similarity structure survives the conjunction.

**Encoding a nested episode.** `bite(spot, jane)` and the full probe *"Spot bit Jane, causing Jane to flee from Spot"*:

```
P_bite  = ⟨ bite + bite_agt ⊛ spot + bite_obj ⊛ jane ⟩
P_flee  = ⟨ flee + flee_agt ⊛ jane + flee_from ⊛ spot ⟩
P_obj   = ⟨ jane + spot ⟩
P       = ⟨ cause + P_obj + P_bite + P_flee + cause_antc ⊛ P_bite + cause_cnsq ⊛ P_flee ⟩
```

Three things to read off this: the relation vector `bite` is added *unbound* so that any episode involving biting is similar to any other; the objects are added *again* at the top level (`P_obj`) so surface similarity is deliberately amplified; and a whole relation (`P_bite`) fills a role of `cause` with no change of format. **What goes into the sum is an architectural choice, and the paper's results are entirely about that choice** — not about the convolution.

Token vectors are themselves superpositions of a type and an identity: `jane = ⟨person + id_jane⟩`, `spot = ⟨dog + id_spot⟩`. Type similarity is therefore built in and graded, which is the property BM25-style sparse codes do not have ([[wiki/concepts/retrieval-capacity.md]]).

---

## Extension: fractional binding, and continuous quantities in the same algebra

> **Provenance.** Joffe & Eliasmith 2025 (`raw/joffe-2025-vector-symbolic-algebras-arc.md`), reporting Komer & Eliasmith's **Spatial Semantic Pointers (SSPs)**; used as the object representation of [[wiki/entities/arc-vsa-solver.md]].

Plain HRRs encode discrete structure. The `n`-th element of a sequence is `ONE^n = ONE ⊛ … ⊛ ONE`, which in the Fourier domain is `F⁻¹{F{ONE}^n}` — element-wise exponentiation. **Nothing in that expression requires `n` to be an integer.** Letting the exponent be real gives an encoding of a continuous space:

```
φ(x) = F⁻¹{ e^{iΘx/l} },        Θ ∈ ℝ^{D×N}  (phase matrix),  l  (length scale)
φ(x,y) = X^x ⊛ Y^y              (D = 2: bind one axis vector per dimension)
```

| Property | Statement | Consequence |
|---|---|---|
| Binding = addition | `φ(x₁) ⊛ φ(x₂) = φ(x₁+x₂)` | Translation is one bind; a displacement and a position have the same type |
| Origin = identity | `φ(0) = I` | The zero of the feature space is the algebra's own unit — no separate convention |
| Inversion = negation | `φ(x)⁻¹ = φ(−x)` | Moving back is unbinding |
| Similarity = kernel | `φ(x₁)·φ(x₂) = k(x₁,x₂)`, shape set by the distribution `Θ` is sampled from | The metric on the encoded space is a **design parameter**, not an accident; `l` is a bandwidth |
| Grid codes | Particular `Θ` produce grid-cell-like activity | The same construction is a model of entorhinal grid cells |
| Scenes | `a = Σ_i ITEM_i ⊛ φ(x_i)` | "What is at `x`" and "where is `ITEM`" are both single unbind + cleanup |

**Why this belongs on this page rather than beside it.** It is the same operator: exponentiating in the Fourier domain *is* repeated convolution, continued to the reals. So one algebra now covers discrete roles, nested relations and continuous magnitudes, with a tunable similarity kernel over the last — which is what a code needs if a "position" and a "part-of" relation are to be superposed in one vector.

**Two things it buys the rest of the wiki.**

1. **A path-integrable code with an explicit construction.** [[wiki/concepts/path-integration.md]] separates the abelian special case (phase addition) from the general order-sensitive one; SSPs *are* the abelian case, written down as a data structure rather than learned — distinctness and path-invariance both hold by algebra, not by training ([[wiki/concepts/abstract-structural-codes.md]], G3).
2. **A continuous knob on graded similarity.** The blur/length-scale `l` sets how much two nearby positions overlap. [[wiki/entities/arc-vsa-solver.md]] measures the cost of not setting it: rule conditions over near-orthogonal colour vectors generalise strictly (100%), the same learner over overlapping shape codes abstracts *and* over-generalises (89%). Same mechanism, opposite sign, one fixed hyperparameter (G38, G40).

**Limits.** The kernel is stationary — `k` depends on `x₁−x₂` only, so an SSP space has no place where similarity behaves differently, and no way to express that one region is more finely discriminated than another. Magnitudes are similarities and not counted symbols, which is a plausible reason the solver built on them fails ARC's counting and ordering tasks. And `Θ` and `l` are chosen, never fitted.

---

## A second binder, and the decode case this page had skipped

> **Provenance.** Frady, Kent, Olshausen & Sommer 2020 (`raw/frady-2020-resonator-networks.md`); see [[wiki/entities/resonator-network.md]].

**MAP (Multiply-Add-Permute)** is the cheap member of the family: atoms are bipolar `±1`, binding is the **Hadamard product** `s_i = x_i y_i`, and because a bipolar vector is its own inverse, **unbinding is the same operation as binding** — no `†`, no approximation in that step. Permutation `ρ` is a first-class third primitive rather than a convenience: it distributes over both `+` and `⊙`, it is non-commutative with binding (`x ⊙ ρ(y) ≠ y ⊙ ρ(x)`), and successive powers `ρ^d` index depth in a hierarchy or position in a sequence, so *ordinal position needs no role vocabulary at all*. And `1` (all ones) is a genuine identity element, which makes "no factor at this slot" expressible inside the algebra — a ragged tree's paths all become products of exactly `d_max` terms.

**The decode statement above is incomplete.** `P ⊛ bite_agt† → jane + noise` works because the *role is known*. The queries that make a data structure worth having return products of unknown atoms:

| Query | Returns | Unknown factors |
|---|---|---|
| "what fills role `R`?" | `filler + noise` | 1 — cleanup suffices |
| "which path leads to `c`?" | `right ⊙ ρ(right) ⊙ ρ²(left) + noise` | 3 |
| "what is in this scene?" | `Σ_o colour ⊙ shape ⊙ v ⊙ h` | 4 per object, count unknown |

Cleanup against a codebook of *atoms* cannot read rows 2–3; it needs a codebook of every **combination**, which is `D^F` entries. This is why VSA applications had been confined to shallow structures. The fix is to factorize rather than enumerate — `F` coupled Hopfield cleanups whose estimates start as the superposition of whole codebooks and denoise each other, `O(F·N·D)` per iteration over a `D^F` space ([[wiki/entities/resonator-network.md]]). It buys the missing read direction and pays with the convergence guarantee: the coupled system has no Lyapunov function.

**What this does to brainstorm 5 below.** "A vector-symbolic store plus an associative cleanup memory is a fast `M` supporting both similarity retrieval and slot-level query" is true only for single-unknown queries. The general read needs a *third* component — a factorizer — and with it the same store also answers queries whose key is not known in advance.

---

## The task: analogical retrieval, and the four kinds of similarity

Probe: *Spot bit Jane, causing Jane to flee from Spot.* Memory:

| Episode | Type | Text |
|---|---|---|
| E1 | **LS** (Literal Similarity) | Fido bit John, causing John to flee from Fido |
| E2 | **AN^cm** (cross-mapped Analogy) | Fred bit Rover, causing Rover to flee from Fred |
| E3 | **AN** (True Analogy) | Felix bit Mort, causing Mort to flee from Felix |
| E6 | **SS** (Surface Similarity / Mere Appearance) | John fled from Fido, causing Fido to bite John |
| E7 | **FA** (False Analogy) | Mort bit Felix, causing Mort to flee from Felix |

The taxonomy is a 2×2 over two independent axes, and it is a reusable instrument well beyond analogy:

| | Object attributes shared | Object attributes not shared |
|---|---|---|
| **Higher-order structure shared** | LS | AN |
| **Higher-order structure not shared** | SS | FA |

AN^cm is the diagnostic cell: same *types* of objects as the probe, but the correspondence swaps them (people bite dogs). Any scorer that reads only the bag of surface features cannot separate AN^cm from LS.

**Whether human retrieval is structure-sensitive at all is unsettled** — Gentner & Forbus report little effect of analogical similarity on reminding, Wharton et al. 1994 report some, and the effect where found is greater in the presence of surface similarity. Plate's result reframes the question: a structure-sensitive first stage costs one dot product, so structure-blindness at access is not forced by tractability ([[wiki/empirical-tensions.md]] T185).

**The two-stage retrieval architecture (MAC/FAC).** Stage 1 (*Many Are Called*) scores every episode in memory cheaply; stage 2 (*Few Are Chosen*, = SME (Structure Mapping Engine)) searches for an optimal consistent mapping among the survivors. Two stages exist because alignment search does not scale to a whole memory — the same argument that motivates [[wiki/concepts/subgraph-matching.md]]'s order embeddings and [[wiki/concepts/amortized-inference.md]] generally. MAC's feature-count dot product gives `(LS, AN^cm, SS) > (AN, FA)`; the full pipeline gives `LS ≈ AN > (SS, FA)`. The wiki now holds the primary source ([[wiki/entities/macfac.md]], Gentner & Forbus 1991), which sharpens what stage 1 is: the content vector counts *functor occurrences*, and its dot product is an analytic over-estimate of the number of match hypotheses SME would generate — the cheap stage approximates the expensive stage's **search-space size**, not its score. That makes the two schemes rivals on a specific point: Plate's stage 1 is a better proxy for the *answer*, MAC's is a derived one-sided bound on the *work*, and only the latter comes with an argument for why a survivor is never wrongly dropped.

---

## Result 1 — a plain HRR dot product already beats the deployed first stage

`n = 2048`, 100 runs with fresh random base vectors each time.

| Episode | Type | Expt 1 (plain) | sd | Expt 2 (memory contextualized, probe not) | Expt 3 (both contextualized) |
|---|---|---|---|---|---|
| E1 | LS | 0.70 | 0.016 | 0.63 | 0.81 |
| E2 | AN^cm | 0.47 | 0.022 | 0.47 | 0.69 |
| E3 | AN | 0.39 | 0.024 | 0.39 | 0.61 |
| E6 | SS | 0.47 | 0.018 | 0.44 | 0.53 |
| E7 | FA | 0.39 | 0.024 | 0.39 | 0.39 |

Plain HRRs: `LS > (AN^cm, SS) > (FA, AN)` in **94/100** runs at `n=2048`, **99/100** at `n=4096` — order violations are dot-product variance and are bought off with dimension. This separates LS from SS, which MAC cannot. But **AN and FA are tied**: with no shared object attributes, structure is invisible to the dot product. The reason is precise and worth stating as a general principle:

> A dot product can only score what is present as a **surface feature** of the vector. In a plain HRR, *which other roles an object fills* is not a surface feature — it is recoverable only by unbinding, i.e. by computation, not by comparison.

---

## Result 2 — contextualization: making a structural property into a surface feature

Replace the filler in each role by a blend of the filler and its **context**, where the context of an object in one role is the *typical filler* of the other roles that same object fills in the episode. Typical fillers are obtained by unbinding: `typ^R_r = R ⊛ r†`.

```
P_bite = ⟨ bite + bite_agt ⊛ (κ_o·spot + κ_c·typ^flee_from)
                + bite_obj ⊛ (κ_o·jane + κ_c·typ^flee_agt) ⟩
```

Reading: *Spot* in the biter slot is no longer `spot` but "`spot`, who is also a fled-from thing". Role co-occurrence has been **pre-computed into the code** so that a comparison can see it.

With both probe and memory contextualized (`κ_o = κ_c = 1/√2`), the ranking is

```
LS > AN^cm > AN > SS > FA          in 100/100 runs
```

— strictly the ideal ordering, the one the full MAC/FAC or ARCS pipeline produces, from a single dot product with no alignment search anywhere.

| Scorer | LS | AN | SS | FA |
|---|---|---|---|---|
| MAC (feature counts) | High | Low | High | Low |
| Plain HRR dot product | High | Low | **Med** | Low |
| Contextualized HRR dot product | High | **Med-High** | **Med-Low** | Low |
| Ideal (SME) | High | Med-High | Med-Low | Low |

**The asymmetry is the architecturally important part.** `κ` can be set differently on the two sides. Memory is encoded *once* at a fixed `(κ_o⁻, κ_c⁻)`; the salience of role alignment for a particular query is then tuned by changing only `(κ_o⁺, κ_c⁺)` **in the probe** — Experiment 2 (uncontextualized probe against contextualized memory) reproduces the *plain* ordering, Experiment 3 (contextualized probe, same memory) reproduces the ideal one. Re-encoding a whole memory to change what similarity means is impractical; re-weighting a query is free. The same device tunes the salience of any other component of the sum.

---

## Why this matters to the rest of the wiki

**1. It is a partial answer to G37 with a cost model attached.** "Which stored structure applies here?" is answered by one `O(n)` dot product per stored item against a precomputed index, with structural sensitivity included rather than deferred to a second stage. That is strictly cheaper than [[wiki/concepts/subgraph-matching.md]]'s order embedding (which needs a GNN encoder and only answers *containment*) and vastly cheaper than SME.

**2. It relocates the wiki's structure-vs-similarity argument.** [[wiki/concepts/retrieval-capacity.md]] proves that a read of the form `rank stored vectors by ⟨q, v⟩` cannot address arbitrary subsets — and concludes that a store must therefore "be addressed by structure rather than by similarity". Plate's result is the third option that page's table does not contain: **keep the bilinear score and change the code until the structural property is linearly readable.** Contextualization buys expressivity without raising `d` and without un-factorising the score. What it spends instead is *precision*: every additional component folded into the superposition is additional variance in every dot product, which is why `n=4096` halves the ordering violations. The bound is not evaded — it is paid in signal-to-noise rather than in dimension. See [[wiki/empirical-tensions.md]] T173.

**3. It supplies the missing join in the `g`/`x` split.** [[wiki/concepts/abstract-structural-codes.md]] argues for a content-invariant structural code `g` and a content code `x`, and Whittington et al.'s derivation says `g` is an *address*. Role vectors (`bite_agt`, `cause_antc`) are `g`; token vectors are `x`; `⊛` is the operator that recombines them, `†` reads them apart, and `+` holds many at once. Notably `g` here is **random and content-free by construction**, which is exactly [[wiki/entities/vector-hash.md]]'s condition for exponential address capacity.

**4. (brainstorm) Contextualization is a controllable setting of the factorise/entangle knob (G40).** `κ_c = 0` is fully factorised (fillers independent of the roles they occupy); `κ_c > 0` deliberately entangles role structure into the filler code. The wiki's statement of G40 has no dial; this is one, it is continuous, it is settable per-query, and its cost is measurable as dot-product variance. Nothing in Plate sets it adaptively — but *what* would need to be measured to set it is now concrete: how much of the discriminative work in the current retrieval falls on structure versus attributes.

**5. (brainstorm) The decode direction is unused here and is the more valuable half.** The paper only ever compares HRRs. But `†` means the same vector that was ranked can then be *interrogated* — "who was the agent?" is `P_bite ⊛ bite_agt†` followed by a cleanup step against the token inventory. That cleanup is an attractor read ([[wiki/entities/hopfield-network.md]], [[wiki/concepts/pattern-separation-completion.md]]): a noisy decode snapped onto the nearest stored item. **A vector-symbolic store plus an associative cleanup memory is a fast `M` that supports both similarity retrieval and slot-level query on the same representation** — which no other memory in the wiki does.

---

## Limits, stated by the source

- **Contextualization is not general.** It distinguishes analogous from non-analogous structures **only when no two entities fill the same set of roles**. Two boys bitten by two dogs, each fleeing the dog that did *not* bite him, is indistinguishable from each fleeing the dog that *did*. Type-level context cannot individuate tokens of the same type — this sharpens G69 from "nothing creates variables on demand" to the harder form: *nothing keeps two variables of the same type distinct under superposition*.
- **Scaling in episode size.** Similarity is a sum of structural-feature matches, which becomes a worse measure as episodes grow — big structures wash out into a mean. The proposed fix is chunking: represent an episode as several HRR chunks, one per node in a spreading-activation network. Unimplemented.
- **Counter-intuitive rankings are constructible.** The estimator has no certificate; like every approximate matcher in the wiki, it cannot say when it is wrong (G37, G17).
- **The code is functionally, not concatenatively, compositional — and one reading makes that a ceiling rather than a design choice.** `a ⊛ b` is unlike both `a` and `b` (the randomizing property, above), so the constituents are recoverable only by *computing* an unbinding, never by *comparing*. That is van Gelder 1990's functional compositionality exactly — and Penn, Holyoak & Povinelli 2008 assign functional compositionality to every taxon examined while claiming that role-filler *independence during binding* requires the constituents to stay separately addressable, which convolution by construction does not deliver ([[wiki/concepts/relational-reinterpretation.md]]). The escape is that `†` exists and a controller could schedule it; nobody in the wiki schedules it, and whether scheduled unbinding substitutes for simultaneous addressability is [[wiki/empirical-tensions.md]] T293.
- **All structure is authored.** Role vocabularies (`bite_agt`, `cause_cnsq`), the decomposition into relations, and the choice of what to superpose at the top level are hand-specified. The algebra makes structure *representable* at fixed width; it discovers none of it.
- **Not a model of analogy-making.** Explicitly a first-stage reminder, not a mapper. The correspondence itself — which object goes to which — is never computed, only scored. The mapping step, and the cost of doing it in the same algebraic style, is [[wiki/concepts/analogical-mapping.md]]; notably that construction needs neither an inverse nor the *content* of the neighbouring roles, only their labels ([[wiki/empirical-tensions.md]] T186, T187).

---

## A limit that dimension does not buy off

Every capacity statement above is statistical — order violations are dot-product variance, and `n = 4096` halves them. Smolensky 1990's **annihilator** condition is not ([[wiki/concepts/tensor-product-representation.md]], Thm 3.16). If a set of structures admits reals `a^(k)`, not all zero, with `Σ_{k : f/r ∈ s^(k)} a^(k) = 0` for every binding, their superposition-of-bindings representations are linearly **dependent at every dimension and for every choice of role and filler vectors**. The smallest case is `{ax, bx, ay, by}` with `(+1,−1,−1,+1)`: a 2×2 fully crossed grid, annihilated by the parity contrast. The wiki's relational benchmarks are fully crossed grids by design, so this is a live and cheaply checkable hypothesis about why they resist codes of this shape — `G106`. It is proved for the uncompressed tensor product; whether convolution's diagonal folding inherits it, escapes it, or worsens it is not addressed by either source.

- **`G60` — unbinding is addressed by a cue the caller already holds.** `a ⊛ (a ⊛ b)⁻¹ ≈ b` requires knowing which role vector to probe with, so every read here is a fixed function of the query the goal supplies; nothing proposes a probe, scores it on how well it would separate the stored items, or reloads it after a failed clean-up.
- **`G104` — no structural code here holds role-filler independence *during* binding.** Once a role and a filler are bound by circular convolution (or any conjunctive product), neither is separately addressable without an unbinding step that destroys the compound. [[wiki/concepts/relational-reinterpretation.md]] makes this the one property separating the four representational features every taxon has from the four claimed human-only; `T293` asks whether a scheduled unbinding step is an adequate substitute for genuine persistence.

## Connections

- **[[wiki/concepts/subgraph-matching.md]]** — the same retrieval question with the labour placed at the opposite end: matching keeps the code plain and makes the comparator structural (order embedding, anchored neighbourhoods, voting), where this page keeps the comparator a dot product and makes the *code* structural via contextualization; MAC/FAC is the two-stage architecture both are trying to collapse.
- **[[wiki/concepts/retrieval-capacity.md]]** — supplies the third escape route missing from that page's table: the rank-`d` bilinear bound applies to what the vectors *are*, so re-encoding structural properties as surface features raises what a fixed-`d` dot product can express, paying in dot-product variance instead of dimension.
- **[[wiki/concepts/abstract-structural-codes.md]]** — supplies the operator the `g`/`x` split never had: role vectors are `g`, tokens are `x`, `⊛` binds them at fixed width and `†` reads them apart, with `g` random and content-free exactly as the capacity argument requires.
- **[[wiki/concepts/compositionality.md]]** — productivity with an explicit arity and an inverse, which vector *addition* alone cannot give: superposition composes, convolution binds arguments to roles, and nesting costs no extra dimensions, so a finite vocabulary generates unboundedly deep structures inside one fixed-width vector.
- **[[wiki/concepts/language-of-thought.md]]** — the connectionist rebuttal to Fodor & Pylyshyn's dilemma: recursively structured typed expressions with compositional semantics, realised in a distributed vector with graded similarity, so productivity is bought without giving up a metric space.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the rival superposition regime: a Boolean-OR union over sparse binary codes tests set membership without a binding operator and is limited to 4–16 patterns by mix-and-match error, where dense HRR superposition is limited by dot-product variance and buys graded type similarity the sparse union cannot express.
- **[[wiki/concepts/attention.md]]** — attention's `softmax(qKᵀ)V` scores content similarity against a flat key set; an HRR probe scores *nested relational* similarity with the same operation, so the difference between the two is entirely in how the keys were built, not in the read.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the wiki's other binding operator, the uncompressed one: an outer product `g ⊗ x` in the hippocampal layer with dimension `|g|·|x|`, which is what circular convolution compresses back to `n` at the cost of decode noise.
- **[[wiki/entities/hopfield-network.md]]** — the cleanup memory an unbinding step requires: `a† ⊛ (a ⊛ b)` returns a noisy `b` that must be snapped onto the nearest stored token, which is exactly an attractor read.
- **[[wiki/entities/vector-hash.md]]** — the capacity argument for why role vectors must be random and content-free: a fixed random projection makes exponentially many stable addresses, and any content leaking into the address destroys the scaling.
- **[[wiki/entities/macfac.md]]** — the architecture this page's single dot product would collapse, read from its primary source: the same first-stage cost buys structure-sensitivity here and is spent on functor counts there, so the disagreement is about what a cheap score should approximate (the alignment's result vs. its workload), not about the budget.
- **[[wiki/concepts/amortized-inference.md]]** — the two-stage retrieval architecture is amortisation with a named split: expensive alignment search is unaffordable per candidate, so a cheap precomputed score filters first, and this page's contribution is moving structural sensitivity *into* the cheap stage.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the same tension in the same representation: superposition needs components to interfere little (separation) while graded type similarity needs them to interfere usefully (completion), and `κ_c` is a continuous dial between the two.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a concrete instance-graph format: a relational graph of arbitrary depth as one fixed-width vector, comparable, decodable, and superposable — with the boundary drawn sharply, since the algebra represents graphs and discovers none.
- **[[wiki/entities/pbwm.md]]** — the routing answer to the same binding problem: a control signal gates a filler into a memory stripe, so binding is *where* the item is stored, where here it is *how* it is transformed — and the stripe version needs every reader to learn to decode every stripe, while `†` is one fixed permutation.
- **[[wiki/concepts/working-memory.md]]** — what a fast `M` would hold if built this way: one vector per episode supporting both similarity ranking and slot-level interrogation, rather than a set of unstructured content slots.
- **[[wiki/entities/arc-vsa-solver.md]]** — the algebra put to work as a *working representation* rather than a memory index: objects encoded as colour ⊕ SSP centre ⊕ SSP shape, search heuristics that are dot products, and a learned rule condition that is itself a unit-norm vector in the same space — so the concept a classifier learned can be decoded with `†` like any other filler.
- **[[wiki/concepts/path-integration.md]]** — fractional binding is that page's abelian case supplied as a construction: `φ(x)⊛φ(y) = φ(x+y)` makes a position code path-integrated by algebra, with distinctness and path-invariance holding without any training.
- **[[wiki/concepts/analogical-mapping.md]]** — the operation this page explicitly declines to perform: correspondence rather than ranking, obtained by `argmax` of the same kind of dot product over a *sparse binary* code whose binder (context-dependent thinning) has no inverse, which puts the necessity of `†` in question (T187) and offers a second, content-free way to make role structure a surface feature (T186).
- **[[wiki/entities/lisa.md]]** — the rival binding carrier, and the trade stated plainly: synchrony gives a hard, psychologically calibrated capacity limit and a natural site for inhibitory competition, but a phase code has no fixed vector, so none of this page's similarity machinery applies to it and retrieval has to be run on a separate distributed semantic pathway.
- **[[wiki/entities/conceptor.md]]** — the complementary route from vectors to symbols, and an exact division of labour: a conceptor negates, subsumes and orders concepts by abstraction (`0 ≤ A ≤ B ≤ I` in the Löwner order, subsumption decidable in one componentwise pass) but has **no binding operator** and, by its author's own statement, no product with which to build one — the tensor theory it would need is missing. Conversely a VSA binds roles to fillers and has no negation and no ordering. Neither is a symbol system on its own (Jaeger 2014).
- **[[wiki/entities/sigma-pi-reservoir.md]]** — the approximation theory under this page's algebra: binding is exactly an unbiased randomized feature map for the polynomial kernel (`E[⟨φ_p(x),φ_p(y)⟩] = ⟨x,y⟩^p`, for Hadamard, circular-convolution and block-convolution binders alike) and superposition-plus-permutation is concatenation, which turns the dot-product variance priced here into a dimensioning rule `D = O((pR/ε)²)` — and simultaneously undercuts this page's `n`-in-the-low-thousands precondition, since `D = 28` matches a 28-feature explicit basis when nothing is ever unbound (Kleyko et al. 2025).
- **[[wiki/concepts/loopy-belief-propagation.md]]** — the rival account of what a shared latent space is for: binding by algebraic superposition with an exact inverse, against binding by iterated probabilistic agreement between modules, with the second paying rounds where this page pays dimensionality.
- **[[wiki/concepts/multi-token-embedding.md]]** — the same compound-from-parts problem solved the opposite way by a trained language model: where binding makes the compound *invertible* (unbind to recover each filler), early transformer MLPs deliberately destroy the recoverability of `Michael` and `Jordan` from `Michael Jordan`, because a compound that stays similar to its parts would license `Michael Duncan plays basketball` (T287).
- **[[wiki/concepts/relational-reinterpretation.md]]** — the comparative ladder this algebra is scored against, and where it lands: binding without preserved constituent identity is the representational level assigned to honeybees and scrub-jays, so the wiki's principal structural code sits below the line the human-specific operation is defined by.
- **[[wiki/concepts/shared-intentionality.md]]** — supplies the missing binding *authority*: status functions are bindings created by a joint declaration, scoped to the episode and revoked when it ends, whereas the algebra here represents which items are bound and never who asserted the binding or when it lapses.
- **[[wiki/concepts/fast-weight-programming.md]]** — a second-order tensor-product store whose roles and fillers are *self-invented*: Smolensky's crosstalk theorems (3.1, 3.3) transfer intact to a linear-attention head, but the symbol table does not have to be supplied, since keys and values are emitted by trained projections — and the delta-rule write adds the operation the classical algebra lacks, correcting one binding without re-deriving the representation (Schlag et al. 2021).
- **[[wiki/entities/sme.md]]** — the symbolic engine whose own authors proposed this page's move: §6.2.2 recasts the match-hypothesis graph as an excitation/inhibition network settled by relaxation, dropping the algorithm to `O(N²)` — so the disagreement with a code-based matcher is not search-vs-settling but hard-vs-soft structural consistency.
- **[[wiki/concepts/tensor-product-representation.md]]** — the uncompressed ancestor this page's binder is a discard rule over, and the source of three things it lacks: an exact non-destructive inverse under linear independence alone, the **role decomposition** as an explicit design step (a positional role set is *less* faithful than a contextual one the moment two structures are superposed), and the annihilator obstruction that no dimension repairs (`G106`).
- **[[wiki/entities/resonator-network.md]]** — the missing read operation: `†` requires a known key, so a query returning a product of several *unknown* atoms is a `D^F` search that this page's cleanup step cannot do, and a resonator solves it by holding every candidate for every factor in superposition — supplying at the same time the MAP binder (Hadamard, self-inverse) and `ρ`-powers as an ordinal code needing no role vocabulary (Frady et al. 2020).
- **[[wiki/concepts/higher-order-interactions.md]]** — the discovery-side complement to this algebra: a simplex or a hyperedge is the analytic object for a relation among more than two elements, and this page's binder is the representational one — but every estimator in the wiki that *finds* structure (correlation, attention, co-activity, transition counts) returns pairs, so nothing produces the `n`-ary relations this algebra is built to hold (`G105`).
- **[[wiki/entities/esbn.md]]** — the design point that refuses this page's compression entirely: key and value are appended to two aligned memory columns and the binding *is* the shared row index, so both constituents stay separately addressable with no `†` and no decode noise — and every operation this page is built on (superposition, nesting, similarity on the bound object) is forfeited in exchange (Webb et al. 2021).
