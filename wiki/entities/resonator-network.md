# Resonator Network — factorizing a bound vector when *none* of the factors is known

**Every vector-symbolic decode in the wiki assumes you know what to unbind with. A resonator network is what you run when you do not: given `s = x_{i*} ⊙ y_{j*} ⊙ z_{k*}` and the three codebooks, it finds all three factors at once by holding every candidate for every factor *in superposition* and letting the estimates clean each other up, so a `D^F` combinatorial search is replaced by `F` matrix–vector products per iteration and a few tens of iterations.**

> **Provenance.** Frady, Kent, Olshausen & Sommer 2020, *Resonator networks for factoring distributed representations of data structures* (`raw/frady-2020-resonator-networks.md`, ar5iv 2007.03748; Redwood Center / Intel Neuromorphic). Part 1 of two — the capacity theory and the comparison against standard optimizers are Kent et al., part 2, quoted here at the authors' own summary and **not held at source**.

---

## The problem the wiki had skipped

[[wiki/concepts/vector-symbolic-binding.md]] states the decode operation as *unbind, then clean up*: `P ⊛ bite_agt† → jane + noise`, snapped onto the nearest token by an attractor read. That works because the **role is known**. It does not cover the case where the query returns a product of several *unknown* atoms — which is what the interesting queries return:

| Query | Result | Unknowns |
|---|---|---|
| "what is at position `left,right,left`?" | `b + noise` | 1 — plain cleanup |
| "where is leaf `c`?" | `right ⊙ ρ(right) ⊙ ρ²(left) + noise` | **3** — a path, not an item |
| "what objects are in this scene?" | `Σ_o c_o ⊙ d_o ⊙ v_o ⊙ h_o` | **4 per object**, plus how many objects |

Nearest-neighbour lookup on the second and third rows requires a codebook containing every *combination* — every path in the tree, every colour×shape×position tuple. Prior VSA work "sidestepped this problem by limiting the depth of the data structures or using a brute force approach", which is the stated reason VSAs had not been applied to real problems. **The factorization step, not the algebra, was the blocker.**

---

## The algebra used here: MAP, not HRR

A second binder for the wiki's VSA page, and the cheaper one:

| Operation | MAP (Multiply-Add-Permute) | vs. HRR |
|---|---|---|
| Atoms | bipolar, `±1` uniformly at random, `N ≈ 10³–10⁴` | real Gaussian `N(0,1/n)` |
| Bind | Hadamard `s_i = x_i y_i` | circular convolution `⊛` |
| Unbind | **the same operation** — bipolar vectors are self-inverse | `a†`, a permutation, approximate |
| Superpose | `+`, optionally re-thresholded to `±1` | `+` then renormalise |
| Protect / order | `ρ(·)`, a cyclic shift; `ρ` distributes over both `+` and `⊙`, and `x ⊙ ρ(y) ≠ y ⊙ ρ(x)` | permutation likewise |
| Decode | `a = Xᵀs` — one matrix–vector product against the codebook | same |

Two things MAP contributes that the wiki's HRR account did not have:
- **`ρ` as a third primitive with a job of its own.** Depth in a tree and index in a sequence are *powers of `ρ`*: `s = x₀ + ρ(x₁) + ρ²(x₂)`. Because permutation rotates a vector into near-orthogonal dimensions, `ρ^d(left)` at depth `d` cannot interfere with `left` at depth 0 — position is encoded by an operator rather than by a role vector, so no role vocabulary has to be authored for depth.
- **An identity element that means "nothing here".** `1` (all ones) is the multiplicative unit, so `right ⊙ ρ(right) ⊙ ρ²(left)` and `right ⊙ ρ(right) ⊙ ρ²(left) ⊙ 1 ⊙ 1` are the same vector. Putting `1` in each depth's codebook alongside `ρ^d(left)` and `ρ^d(right)` makes *every* location in a ragged tree a product of exactly `d_max` factors, so one fixed-arity network decodes variable-arity structures. This is the same move as the null row in [[wiki/entities/rims.md]] — make "no content at this slot" a representable value rather than a control exception — arriving here as an algebraic identity rather than an extra parameter.

---

## The algorithm

For `s = x_{i*} ⊙ y_{j*} ⊙ z_{k*}` with codebooks `X, Y, Z ∈ {±1}^{N×D}`:

```
x̂(0) = Σ_i x_i,   ŷ(0) = Σ_j y_j,   ẑ(0) = Σ_k z_k        # every candidate at once

x̂(t+1) = g( X Xᵀ ( s ⊙ ŷ(t) ⊙ ẑ(t) ) )
ŷ(t+1) = g( Y Yᵀ ( s ⊙ x̂(t) ⊙ ẑ(t) ) )
ẑ(t+1) = g( Z Zᵀ ( s ⊙ x̂(t) ⊙ ŷ(t) ) )                     # g = threshold to ±1
```

**Why this is not enumeration.** Binding distributes over addition, so `x̂(0) ⊙ ŷ(0) = Σ_i Σ_j x_i ⊙ y_j` — the product of two superposed estimates *is* the superposition of all `D²` pairs. At `D = 100` a single Hadamard product carries 10,000 combinations, and inferring `ẑ` tests all of them in one pass. The cost per iteration is `F` matrix–vector products, `O(F·N·D)`; the space searched is `D^F`.

**Why it works.** Superposing that many quasi-orthogonal vectors produces crosstalk noise; `XXᵀ` followed by `g` projects the noisy estimate onto the span of the codebook, returning a **confidence-weighted sum of codebook items** rather than a single symbol. Better estimates ⇒ fewer effective combinations in the next product ⇒ less crosstalk ⇒ better estimates. The two stages cooperate rather than alternate as separate phases.

**What the loop is made of.** `g(XXᵀ · )` is a Hopfield network with an outer-product Hebbian weight matrix, exactly ([[wiki/entities/hopfield-network.md]]) — *except that its output is not fed back to itself but sideways into the other factors' inputs*. A resonator network is `F` associative memories coupled multiplicatively.

| Property | Statement |
|---|---|
| Convergence | **No Lyapunov function, no guarantee.** The state "bounces around in state space" and then transitions abruptly to a fixed point — the authors' phrase is *popping out as if in a moment of insight* |
| Operational capacity | quadratic in `N` (part 2, not held at source); ~**two orders of magnitude** above the alternative optimizers compared there |
| Accuracy inside capacity | 100% on exact input, empirically, with high probability |
| Failure signature | outside capacity it does not converge; there is no separate error signal |

---

## Two worked structures

**Tree.** Leaves `a…g` and turn vectors `left, right`; depth by `ρ`; a leaf's path bound to its label; the whole tree superposed into one vector:

```
tree = a ⊙ left ⊙ ρ(left) ⊙ ρ²(left)  +  b ⊙ left ⊙ ρ(right) ⊙ ρ²(left)  +  …
tree ⊙ (left ⊙ ρ(right) ⊙ ρ²(left)) = b + noise         # location → label: one cleanup
tree ⊙ c = right ⊙ ρ(right) ⊙ ρ²(left) + noise          # label → location: a factorization
```
Five estimators (the depth of the deepest leaf), codebooks `X_d = [ρ^d(left), ρ^d(right), 1]`. **Tree search becomes a settling process on a fixed-size network** — no traversal, no stack, and the cost does not depend on which leaf is asked for.

**Visual scene.** Coloured MNIST digits at quantised positions; `s = Σ_objects c ⊙ d ⊙ v ⊙ h`, four codebooks `C, D, V, H`.

| Quantity | Value |
|---|---|
| Atomic parameters | 23 (10 digit, 7 colour, 3 vertical, 3 horizontal) |
| Distinct objects | 630 |
| Distinct 1–3-object scenes | 250,444,530 |
| Vector dimension `N` | **500** — *less than the number of objects*, eight orders below the scene count |
| Encoder | 2-hidden-layer fully-connected net, pixels → scene vector, backprop against the generated ground-truth VSA code, 100k train / 10k test |

Two mechanisms come out of this example that the algorithm statement does not contain:

1. **Deflation as a serial read-out.** A multi-object scene has several valid factorizations superposed. The network converges on *one* of them — which one is not controlled — after which that object is subtracted from `s`, the estimates are reset to full superposition, and the loop is re-run on the remainder. So a fixed-width parallel code yields objects **one at a time**, and the serial bottleneck is a consequence of the read mechanism rather than an added attentional stage.
2. **The factorizer repairs the encoder.** The feedforward encoder's output degrades with object count (occlusion). Correct-factorization probability is a logistic function of cosine similarity to the ground-truth scene vector, i.e. the resonator absorbs a wide band of encoding error before failing — the discrete stage cleans up the continuous one, at no extra training cost.

---

## What it contributes

| To | Contribution |
|---|---|
| `G75` | An object decomposition where the **object count is a free variable** (deflate until nothing decodes) while the **attribute factorization is hand-declared** (four codebooks, fixed). It splits that gap cleanly into "how many parts" — answered here without a menu — and "along which axes" — untouched |
| `T293` | The missing half of Position B. That row's cost for scheduled unbinding is "a policy over `†` — what to unbind, when, against which cleanup memory". A resonator needs no policy over *what*: it unbinds against every candidate simultaneously and lets the dynamics choose |
| Hybrid architectures | The concrete recipe: train a network to emit a **structured symbolic code** instead of a class label, then let an algebraic stage parse it. The gradient path and the combinatorial path meet at one vector |
| The binding problem | A solution that does **not expand the representation**. Synchrony and attention accounts attach binding information to feature representations, growing the code in dimension or in time; conjunctive VSA binding keeps a compound the same width as an atom, and relocates the difficulty entirely into unbinding — which is Feldman's point that sensory processing is fundamentally *un*binding, since a photoreceptor's signal is already a product of illumination, reflectance and orientation |

**(brainstorm) The transferable idea is *search in superposition*, and it is not specific to VSAs.** The move is: represent an entire hypothesis set as one vector, apply the forward model to that vector, and rely on the model's distributivity to evaluate every hypothesis at once — then denoise by projection onto the legal set. Any bilinear or multilinear generative model has this structure. Where the wiki's other searches enumerate candidates and score them ([[wiki/entities/arc-vsa-solver.md]]'s six parses, program synthesis, MAC/FAC's two stages), this one never instantiates a candidate at all, and the price it pays for that is the guarantee.

## Limits

- **Nothing is discovered.** Codebooks, the number of factors, the maximum tree depth and the assignment of factors to semantic roles are all authored. The network solves the inverse problem for a generative model it is handed (G4, G73).
- **No convergence proof and no certificate.** It cannot report which of "the answer is X" and "I did not converge" it is in — the same missing instrument as every approximate matcher here (G17, G68), and worse, since non-convergence is silent for a fixed iteration budget.
- **Which factorization it lands on is uncontrolled.** In a multi-object scene the order of read-out is whatever the dynamics prefer; there is no query, no bias and no top-down selection — the same hole [[wiki/entities/hopfield-network.md]] leaves.
- **Capacity is quadratic, and the scene example is small.** `N = 500` with 630 combinations is comfortable; the authors state the representation "will begin to break down for more than a few objects", and defend it by analogy to human working-memory limits — an analogy, not a result.
- **Biologically an abstraction, by the authors' statement.** Dense bipolar codes and element-wise multiplication are not neural. The offered reconciliations are sparse VSA variants with sigma-pi binding in dendritic trees ([[wiki/entities/sigma-pi-reservoir.md]], [[wiki/concepts/dendritic-computation.md]]) and complex-valued VSAs mapped to spike timing ([[wiki/concepts/temporal-coding.md]]) — all cited as ongoing work.
- **Part 2 is not held.** The capacity law, the comparison against alternative optimizers and the two-orders-of-magnitude claim are quoted from the authors' summary of a paper not in `raw/`.

---

## Connections

- **[[wiki/concepts/vector-symbolic-binding.md]]** — the operation that page's decode account presupposes and never supplies: `†` needs a known key, and the queries that make a data structure worth having ("where is `c`?", "what is in this scene?") return products of *unknown* atoms, which is `D^F` by lookup and `F` matrix–vector products per iteration here.
- **[[wiki/entities/hopfield-network.md]]** — the same circuit rewired: `g(XXᵀ·)` is an outer-product Hebbian cleanup, but its output goes sideways into the other factors instead of back to itself, which destroys the symmetry and therefore the Lyapunov function — and that loss is the *point*, because a search must move where a memory must halt.
- **[[wiki/concepts/attractor-dynamics.md]]** — a fixed-point computation with no energy function behind it: solutions are stable states of a coupled multiplicative system, reached after a chaotic transient, so "answer = attractor" survives here while "retrieval = descent" does not.
- **[[wiki/entities/arc-vsa-solver.md]]** — the same algebra with the opposite search discipline: that solver enumerates six parses and scores each, where this one holds all candidates superposed and never instantiates one — and it is the natural missing component there, since a rule condition that fires on an object could instead be *factored out* of the object code.
- **[[wiki/entities/lisa.md]]** — the rival solution to the same binding problem, priced on the same axis: synchrony keeps role and filler separately addressable but adds a temporal dimension and caps at 2–3 propositions, while conjunctive binding keeps the compound the width of an atom and moves the entire cost into the factorization this page performs (`G104`, `T293`).
- **[[wiki/entities/sigma-pi-reservoir.md]]** — the substrate argument for this page's binder and a bound on its dimensioning: Pi-type multiplicative units implement Hadamard binding directly and are the dendritic mechanism the authors point to for biological plausibility, while that page's `D = O((pR/ε)²)` prices what a *never-unbound* superposition costs — this page shows what unbinding costs when done by search rather than lookup.
- **[[wiki/entities/rims.md]]** — the same design move in a different formalism: an identity element (`1`) and a null row are both ways of making "nothing at this slot" a representable value, so a fixed-arity mechanism can process variable-arity structure without a control exception.
- **[[wiki/concepts/tensor-product-representation.md]]** — the uncompressed binder for which this problem does not arise (constituents stay separately addressable and are read by a partial inner product) and the reason it is not used: the binder count grows multiplicatively, so the compressed code plus this search is the trade being made.
- **[[wiki/concepts/pattern-separation-completion.md]]** — completion used as a *subroutine of search* rather than as retrieval: each factor's cleanup is a completion step, and the separation between codebook atoms is what makes the superposed guess decodable at all.
- **[[wiki/entities/early-visual-system.md]]** — the framing this page imports from Feldman: a receptor signal is already a product of illumination, reflectance, orientation and atmosphere, so the first job of sensory processing is *unbinding*, and demultiplication rather than feature detection is the operation to look for.
- **[[wiki/concepts/amortized-inference.md]]** — the un-amortised counterpart: no encoder is trained to output the factors, the factorization is solved afresh by iteration for each input, and the feedforward encoder is used only to *reach* the symbolic space, not to invert it.
- **[[wiki/concepts/compositionality.md]]** — the read side of productivity: a fixed-width code composes unboundedly by construction, and this page is the evidence that the composition is *invertible in practice*, which is what separates a compositional code from a merely compressive one.
- **[[wiki/concepts/latent-graph-discovery.md]]** — navigation of a held structure at last made cheap: tree search becomes settling on a fixed-size network whose cost is independent of which node is queried — with the structure still authored, so this is the navigate half only.
