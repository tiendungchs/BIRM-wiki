# Tensor Product Representation

**Represent a structure as the superposition of its filler/role bindings, and each binding as the outer product of a distributed filler pattern with a distributed role pattern: `Ψ(s) = Σ_i f_i ⊗ r_i`. Three parameters are then separable and can be designed independently — the *role decomposition* of the structure, the operator representing *conjunction*, and the *codes* for fillers and roles. Nearly every connectionist representation of structured data, from a one-hot slot to a fully distributed vector-symbolic code, is one setting of those three.**

The wiki has cited this construction second-hand for a long time — as the uncompressed foil that circular convolution improves on ([[wiki/concepts/vector-symbolic-binding.md]]), as the `g ⊗ x` layer of [[wiki/entities/tolman-eichenbaum-machine.md]], and as the source of the crosstalk theorems that transfer to linear attention ([[wiki/concepts/fast-weight-programming.md]]). The primary source carries four things none of those inherited: a **design space for roles**, an **exact non-destructive unbinding operator**, an **algebraic impossibility result** that no dimensionality repairs, and the claim that **symbolic operations are linear maps on the role factor alone**.

> **Provenance.** Smolensky, *Tensor product variable binding and the representation of symbolic structures in connectionist systems*, Artificial Intelligence 46 (1990) 159–216 (`raw/smolensky-1990-tensor-product-variable-binding.md`). Conversion is **lossy** (pdf2md): equation glyphs and figures are mangled; every formula below is restated from the surrounding proof text, and theorem numbers are given so they can be checked. Results attributed to Dolan & Smolensky's Tensor Product Production System (TPPS), Smolensky 1987 (optimal role vectors, the recirculation learner) and Treisman & Schmidt 1982 are reported **through** this paper.

---

## The construction: three independent parameters

| Parameter | Smolensky's choice | Alternatives already in the wiki |
|---|---|---|
| **Role decomposition** `F/R` | positional, `k`-neighbour context, `car`/`cdr` bit-strings | authored role vocabularies ([[wiki/concepts/vector-symbolic-binding.md]]), learned key projections ([[wiki/concepts/fast-weight-programming.md]]) |
| **Conjunction** | vector addition (real scalars) | Boolean OR over sparse codes ([[wiki/concepts/sparse-distributed-representations.md]]); the paper flags the Boolean variant as a genuinely different algebra, exact under thresholding at light load |
| **Filler / role codes** | arbitrary vectors in `V_F`, `V_R` | one-hot, features, random i.i.d., learned |

```
Ψ(s)  =  Σ_{(f,r) ∈ β(s)}  Ψ_F(f) ⊗ Ψ_R(r)         b_{φρ} = f_φ · r_ρ
```

Binding is a **sigma-pi unit** or a multiplicative (triangular) junction: one binder per (filler-unit, role-unit) pair, taking the product of its two inputs. The same junctions run **backwards** for unbinding — no second circuit.

---

## 1. Role decomposition — the design step, formalised

**Definition (2.4).** A role decomposition of a set of structures `S` is `(F, R)` plus a predicate `f/r(s)`, "`f` fills role `r` in `s`". Properties, each of which is a separate design commitment:

| Property | Meaning | Consequence |
|---|---|---|
| **single-valued** | at most one filler per role per structure | unbinding a role returns one filler, not a superposition |
| **faithful** | `s ↦ {bindings}` is one-to-one | distinct structures are distinguishable *before* any vectors are chosen |
| **finite** | each structure has finitely many bindings | the sum converges |
| **recursive** | `F = S` — fillers are themselves structures | the `car`/`cdr` case; roles become operators `S → S` |

**The result the wiki does not have anywhere: faithfulness for one structure and faithfulness under superposition are different properties, and they trade off** (§2.3.1).

| Decomposition of strings | `aba` becomes | Single structure | Two superposed structures |
|---|---|---|---|
| **positional** `r_i` = "`i`-th element" | `{a/r₁, b/r₂, a/r₃}` | faithful | `ab` ∪ `cd` = `{a/r₁, b/r₂, c/r₁, d/r₂}` — **indistinguishable from** `ad` ∪ `cb` |
| **1-neighbour context** `r_xy` = "preceded by `x`, followed by `y`" | `{a/r_<b, b/r_aa, a/r_b>}` | *not* faithful (`aᵏ` collisions), not single-valued | `ab` ∪ `cd` = `{a/r_b, c/r_d}` — not confusable |

So the more obvious decomposition is the one that fails first, and it fails at exactly the operation the whole scheme is built on. Two design rules fall out:

1. **Choose the role set against the number of structures to be held at once**, not against the expressiveness needed for one. A slot-indexed code (which is what a positional decomposition is) is safe for a single item and produces illusory conjunctions the moment two are superposed.
2. **Contextual roles put the task's regularities into the address.** Rumelhart & McClelland's past-tense model needs rules conditioned on phonological neighbours (`x/r_y_> → {x/r_y_ᵻ, ᵻ/r_x_d, d/r_ᵻ_>}` if `x` is dental), and the context decomposition hands the network exactly that predicate as a coordinate. Positional roles would require it to be learned.

**(brainstorm)** This is the wiki's `κ_c` contextualization knob ([[wiki/concepts/vector-symbolic-binding.md]]) arrived at from the opposite direction and 3 years earlier: Plate blends context into the *filler* to make role co-occurrence a surface feature; Smolensky builds context into the *role index* so the same information is a coordinate. Plate's is per-query tunable, Smolensky's is baked into the address space — and Smolensky's is the one that fixes the superposition confusion, which Plate's does not.

---

## 2. Local, semi-local and fully distributed are one operator

| Case | `Ψ_F` | `Ψ_R` | What it looks like | Wiki instance |
|---|---|---|---|---|
| **purely local** | local | local | one active unit per binding | NETtalk input; interactive-activation letter level |
| **semi-local** (*role register*) | distributed | local | a copy of the filler pattern in a pool dedicated to the role — **a slot** | [[wiki/entities/pbwm.md]] stripes; a transformer's per-position residual stream |
| **fully distributed** | distributed | distributed | every unit participates in every constituent | HRR/VSA codes; [[wiki/entities/tolman-eichenbaum-machine.md]]'s `g ⊗ x` |

**Definitions 2.13–2.16, §2.4.** The only difference between the three is the relation between the representing vectors and the *distinguished basis* (the units). Under **linear dynamics the three are isomorphic** — a change of basis maps them into each other. The isomorphism fails on three counts, all of which are the interesting ones:

- **nonlinear units** break it outright;
- **locality of damage** is not preserved by the change of basis, so lesion behaviour differs;
- **what local learning rules can learn** differs, because the rules are defined in the distinguished basis.

And a capacity difference that is not about dynamics at all: with a finite network, purely local admits a fixed finite filler and role inventory; semi-local admits unboundedly many *fillers* but finitely many *roles* (one pool each); fully distributed admits a continuous infinity of both, since a finite-dimensional space holds infinitely many distinct vectors.

**This puts the wiki's routing-vs-algebra opposition in dispute.** [[wiki/entities/pbwm.md]] is described here as solving binding by *where a filler is gated*, against a vector-symbolic code that solves it by *how the filler is transformed*. On Smolensky's taxonomy a gated stripe **is** a tensor product binding with a one-hot role code, and the two differ in the choice of `Ψ_R`, not in mechanism — logged as [[wiki/empirical-tensions.md]] T317.

---

## 3. Unbinding: two procedures, two preconditions

| Procedure | Probe vector | Precondition | Result |
|---|---|---|---|
| **exact** (Thm 3.1) | the **unbinding vector** `u_i` from the dual basis, `u_i · r_j = δ_ij` | role vectors **linearly independent** | `Ψ(s) · u_i = f_i` exactly |
| **self-addressing** (Thm 3.3) | the role vector `r_i` itself | role vectors **orthogonal** for exactness; defined for any roles | `f_i` plus intrusions |

**Intrusion of role `j` into role `i`** — the relative weight of the wrong filler `f_j` in what comes back:

```
(r_j · r_i)/(r_i · r_i)  =  cos θ_ji · ‖r_j‖ / ‖r_i‖
```

Three properties the wiki's `†` (a fixed permutation, approximate) does not have:

1. **Exactness is bought by linear independence, not orthogonality.** `{u_i}` is the inverse of the role matrix. Orthogonality is only needed if you insist on reusing `r_i` as its own probe.
2. **The read is non-destructive.** `Ψ(s) · u_i` is a partial inner product; `Ψ(s)` is unchanged and can be probed again, on any role, in any order.
3. **It is symmetric in filler and role.** Probing with a *filler* returns the superposition of every role that filler occupies — so "where does atom `a` occur in this tree?" is one linear operation, not a traversal (§3.7.2). Since role decompositions are usually single-valued and fillers are not, the asymmetry is in the answer's cardinality, not in the operator.

**The unbinding vectors are learnable** (§3.4.2). Train a linear associator `r_i ↦ e_i` (the one-hot role code) by Widrow-Hoff — always possible under linear independence — then make the connections symmetric and **run `r_i` forwards and the result backwards through the same weights**; what appears on the input units is `u_i`. So the exact inverse is obtainable by a local rule from the role codes alone, with no analytic matrix inversion.

---

## 4. Capacity: this construction has three numbers, and the wiki counts one

**(a) Graceful saturation** (Def 3.4, Thm 3.5). Role vectors drawn uniformly on the unit sphere in `N` dimensions:

```
E[|intrusion|]  =  √( 2 / (π(N−1)) )   ~  N^(−1/2)
n_max           =  √( π(N−1)/2 ) + 1   ~  N^( 1/2)      (bindings held before total intrusion = signal)
```

Capacity of a superposition of tensor-product bindings scales as **√N, not N** — and the paper notes this is conservative, since it sums absolute intrusions while real errors are signed and cancel. `Ψ` **saturates** (unfaithful past some size) while retaining **unbounded sensitivity** (every filler still moves the representation): the formal content of "graceful degradation".

**(b) Generation capacity vs. maintenance capacity are independent, and the wiki has never separated them** (§3.4.1). Two numbers:

| Quantity | Set by | Character |
|---|---|---|
| **generation** `N` | number of parallel filler/role unit pools feeding the binders | **sharp** — hardware; `N` bindings can be *created* per step, more only serially |
| **maintenance** `n` | dimension of the role space | **graded** — how many bindings the binder layer can *hold* superposed, per (a) |

A local or semi-local architecture forces `N = n` (each role is its own region, so each is written in parallel by construction). A fully distributed one makes them free, because *the same binder hardware creates every binding* — which is the concrete payoff of distributing the roles. Reported human asymmetry: `N ≪ n`. Vision maintains an enormous number of feature-to-location bindings while establishing them only for a small region per ~50 ms, and mis-binding under time pressure is Treisman & Schmidt's illusory conjunctions; discourse maintains many constituent/role bindings and generates few at a time. **A model of extended reasoning has to price these separately**; [[wiki/concepts/working-memory.md]] and [[wiki/concepts/retrieval-capacity.md]] both report a single capacity, which silently assumes `N = n`.

**(c) Crosstalk when the structures are stored in an associator** (Thm 3.14). Hebbian association of `{Ψ(s^(k))} → {t^(k)}` with orthogonal fillers and roles: the output for `s^(l)` is `t^(l)` plus `Σ_{k≠l} μ_lk t^(k)`, where

```
μ_lk  =  [ Σ_{i : f_i^(k) = f_i^(l)} ‖f_i^(l)‖² ‖r_i‖² ]  /  [ Σ_i ‖f_i^(l)‖² ‖r_i‖² ]
```

— crosstalk **monotonic in the fraction of shared filler/role bindings**. Structures that share constituents interfere in proportion to how much they share, which is the desirable behaviour for similarity and the fatal one for exact recall.

---

## 5. The annihilator — a crosstalk no dimension can fix

**Definition 3.15.** An *annihilator* of a sequence of structures `k ↦ s^(k)` is a set of reals `a^(k)`, not all zero, such that for **every** filler/role binding `f/r`,

```
Σ_{k : f/r ∈ β(s^(k))}  a^(k)  =  0
```

**Theorem 3.16.** If no annihilator exists (and filler and role vectors are linearly independent), the representations `{Ψ(s^(k))}` are linearly independent and can all be associated with arbitrary targets by Widrow-Hoff. If one **does** exist, they are linearly dependent — **for every choice of filler and role vectors, at every dimension.**

The canonical case, under positional roles:

| Set | Annihilator | Verdict |
|---|---|---|
| `{ax, bx, ay, by}` | `(+1, −1, −1, +1)` | linearly **dependent**; cannot be associated with arbitrary patterns by *any* learning rule |
| `{ax, bx, ay}` | none | independent; learnable |

Every binding in the first set (`a/r₁`, `b/r₁`, `x/r₂`, `y/r₂`) is covered exactly twice with opposite signs. **Why this matters more than it looks:**

- It is a **structural**, not statistical, limit. Every other capacity result in the wiki — dot-product variance ([[wiki/concepts/vector-symbolic-binding.md]]), `d_dot` orthogonality ([[wiki/concepts/fast-weight-programming.md]]), the rank-`d` retrieval bound ([[wiki/concepts/retrieval-capacity.md]]) — is bought off with more dimensions. This one is not: it is a rank deficiency in the *set of structures*, prior to any encoding.
- The failing configuration is a **complete factorial grid**: all combinations of two fillers in role 1 crossed with two fillers in role 2, and the annihilator is the parity/XOR contrast. That is precisely the design of the wiki's relational benchmarks — a Raven's matrix is an attribute × position grid, a [[wiki/entities/pgm.md]] triple is `(relation, object, attribute)` fully crossed. **(brainstorm)** A superposition-of-bindings code over a factorial stimulus set is linearly dependent *by construction*, so a linear read-out over it cannot assign independent values to the cells — which is one candidate mechanism for why these benchmarks resist exactly the models built on such codes, and it is checkable directly by computing the rank of the encoded item matrix. Logged as `G106`.
- The escape the source names is **hidden units** capturing higher-order conjunctions beyond the second-order product — i.e. the failure is specific to the *rank* of the representation, not to conjunctive coding as such.

---

## 6. Symbolic operations are linear maps on the role factor alone

With positional roles (`pop`/`push`) or `car`/`cdr` bit-string roles:

| Operation | Representation | Type |
|---|---|---|
| `pop` (Thm 3.9) | `Σ f_i ⊗ r_i ↦ Σ f_i ⊗ r_{i−1}` | **linear** |
| `push_a` (Thm 3.9) | `Σ f_i ⊗ r_i ↦ a ⊗ r₀ + Σ f_i ⊗ r_{i+1}` | **affine** |
| `car`, `cdr` (Thm 3.12) | `Σ f_x ⊗ r_x ↦ Σ f_x ⊗ T_{0/1} r_x`, with `T_0 : r_{x0} ↦ r_x, r_{x1} ↦ 0, r_ε ↦ 0` | **linear** |
| `cons` (Thm 3.13) | `(u₀, u₁) ↦ Σ f_x ⊗ r_{x0} + Σ q_y ⊗ r_{y1}` — the unique `v` in the non-atomic subspace with `car v = u₀`, `cdr v = u₁` | linear in each argument |

Two consequences worth carrying:

1. **The operator touches only the role factor**: `f ⊗ r ↦ f ⊗ Tr`. Structural manipulation is **content-independent by construction** — which is exactly the property [[wiki/concepts/abstract-structural-codes.md]] posits for `g` and asserts rather than derives. Here it is a theorem about the representation, not a training outcome. (The paper notes the one thing that breaks it: an *ad hoc* stipulation like "`cdr(nil) = nil`" makes the role transformation depend on its filler.)
2. **These are one-shot parallel operations on the whole structure**, not a serial interpreter stepping over it — explicitly contrasted with Touretzky's BoltzCONS. `pop` is a matrix multiply, regardless of the stack's depth. Combined with §3's filler-side probe, "does atom `a` appear anywhere in this tree, and where" is one linear read.

**Costs, stated.** Unbounded depth needs a linearly independent role vector per `car`/`cdr` bit-string, hence an infinite-dimensional `V_R` for genuinely unbounded structures; bounded depth `n` needs `n` dimensions. The subsets that behave like S-expressions (`V_S`) and like lists (`V_L`) are **not closed under vector addition** — superposing two valid list representations generally yields a vector that is not a list — so the vector space is larger than the data type and nothing in the algebra enforces well-formedness.

---

## 7. Binding units *are* connection weights

§3.5. Accumulating products over sequentially presented pairs is **formally identical to Hebbian learning** of the role→filler associations; self-addressing unbinding is formally identical to recall through the Hebbian matrix. The tensor-product activity pattern and a fast weight matrix are the same object read two ways, which McClelland's **Connection Information Distribution (CID)** exploits directly: binder-unit *activities* set the *weights* between role and filler units, so the represented structure becomes a machine that maps roles to fillers.

Two follow-ons:

- **Widrow-Hoff instead of Hebb** upgrades self-addressing unbinding from requiring orthogonality to requiring only linear independence — but the delta rule needs repeated presentation of the whole set, or a relaxation with all filler/role pairs present simultaneously, which **destroys the independence of generation and maintenance capacity** from §4(b). A genuine trade, not an improvement.
- The paper insists the primary purpose is *not* to be an associator: the point is a **pattern of activity standing for the structure as a whole**, available to be processed as an object. The wiki's fast-weight literature ([[wiki/concepts/fast-weight-programming.md]]) has taken the associator reading and dropped the other; nothing in the wiki treats a weight matrix as a *manipulable representation of a structure*.

---

## 8. Two extensions the wiki has re-derived since

**Values as variables** (§3.6). A filler pattern extracted from one binding can serve as the *role* pattern of a second binding — the same activity vector, used on the other side of the product. So "a relation tokened as an object filling a role in another relation" is available in the algebra, which is one of the four properties [[wiki/concepts/relational-reinterpretation.md]] classes as human-only (`G104`). The paper's own open problem: doing this **without first unbinding** the original.

**Continuous roles** (§3.3, Def 3.6). Replace the sum with an integral over a measure on `R`:

```
Ψ(s) = ∫_{supp_R(s)} f(r) ⊗ r  dμ(r)
```

A continuum of positions, a continuum of fillers, and infinite-dimensional role codes (Gaussians over an interval rather than finite vectors) all work with no change of framework, reducing to the discrete case when the fillers are step functions. This is the ancestor of the fractional-binding / Spatial Semantic Pointer construction on [[wiki/concepts/vector-symbolic-binding.md]] — same commitment (magnitudes live in the role code, similarity is a kernel over them), reached without the Fourier machinery.

---

## Limits, stated by the source

- **The binder count is `dim V_F · dim V_R` and grows multiplicatively with rank.** Every practical model in the paper's own survey **throws binding units away** — Rumelhart & McClelland discard most of the third-order product; Touretzky & Hinton keep only `N` "diagonal" units of `N³`. The paper's conclusion names the analysis of *what discarding costs* as missing. **(brainstorm)** Circular convolution is exactly that missing analysis for one particular discard rule (fold the `n²` terms along wrapped diagonals), which reframes HRR as a principled answer to Smolensky's own open problem rather than a rival scheme.
- **Nothing here discovers structure.** The role decomposition, the filler features and the operators are all supplied by the modeller. Role *vectors* can be learned — by backpropagation through the multiplicative junctions, or by the recirculation algorithm of Smolensky 1987 that gradient-descends an error measure over non-linear-independence — but the decomposition itself is authored. Same boundary as every other structural code in the wiki ([[wiki/concepts/latent-graph-discovery.md]]).
- **Second order is not enough for content-addressed storage.** For auto-associative memory the paper concedes hidden units are needed for higher-order conjunctions that distinguish structures the second-order product confounds — the annihilator case being the clean example.
- **Recursion is analysed, not exercised.** Representations in the paper are *defined* by non-recursive decompositions; recursive decompositions are analysed through `car`/`cdr` but the paper says "further development is needed to ensure that embedded structures can be effectively processed."
- **No account of the dynamics.** Restrictions on unit activation values are explicitly set aside as not representational — so the entire analysis is about a vector space, with nothing said about what network settles into these states or how.

---

## Connections

- **[[wiki/concepts/vector-symbolic-binding.md]]** — the compressed descendant, and now with the trade priced from both ends: convolution folds the `n²` binders into `n` and pays in decode noise plus an only-approximate inverse, where this construction keeps all `n²`, admits an **exact non-destructive** unbinding under mere linear independence, and makes the constituents separately probable from either side — so the wiki's principal structural code is a discard rule applied to this one.
- **[[wiki/concepts/retrieval-capacity.md]]** — a capacity limit of a different kind from the rank-`d` bound: the annihilator condition makes certain *sets of structures* linearly dependent at every dimension, so unlike the bilinear bound it cannot be paid off by raising `d`, and unlike dot-product variance it is not statistical at all.
- **[[wiki/concepts/fast-weight-programming.md]]** — the primary source for the crosstalk theorems that page transfers to linear attention (3.1, 3.3), plus the duality it drops: binder activities *are* the weight matrix (CID), so a fast-weight state can be read as a structure to be manipulated rather than only as a store to be queried.
- **[[wiki/entities/pbwm.md]]** — the same operator with a one-hot role code: a gated stripe is a *semi-local* tensor product (distributed filler, local role), which makes routing and algebra two settings of `Ψ_R` rather than two mechanisms, and explains the stripe scheme's two known limits — finitely many roles in a finite net, and generation capacity forced equal to maintenance capacity (T317).
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the wiki's live instance of the uncompressed binder: `g ⊗ x` in the hippocampal layer is `Ψ_R ⊗ Ψ_F` with `g` the role, and its Hebbian outer-product memory is precisely the activity/weight duality of §7.
- **[[wiki/concepts/abstract-structural-codes.md]]** — supplies a derivation for the `g`/`x` split that page asserts: structural operators act as `f ⊗ r ↦ f ⊗ Tr`, touching only the role factor, so content-independence of structural manipulation is a property of the representation rather than something training must deliver.
- **[[wiki/concepts/compositionality.md]]** — concatenative composition realised in a vector space: constituents remain separately addressable inside the compound, `cons`/`car`/`cdr` are linear maps, and recursion costs dimensions rather than fidelity — the opposite corner from convolution's functional compositionality.
- **[[wiki/concepts/relational-reinterpretation.md]]** — the property the comparative ladder makes human-specific, delivered algebraically: values serve as variables (§3.6), and both role and filler stay separately readable while bound, which is what `G104` asks for — at a binder count multiplicative in rank, and still requiring a computed read rather than a comparison.
- **[[wiki/concepts/higher-order-interactions.md]]** — the representational answer to `n`-ary relations made explicit: recursive decomposition of roles gives tensors of rank 3 and above whose units stand for `n`-way feature conjunctions, and the reduction of `left_of(a,b)` to nested one-place roles shows relation-arity is syntactic sugar over role decomposition — leaving discovery, not storage, as `G105`.
- **[[wiki/concepts/working-memory.md]]** — the capacity split it lacks: how many bindings can be *generated* per step (sharp, set by parallel binder hardware) and how many can be *maintained* (graded, `~√N`) are independent quantities, and the human asymmetry `N ≪ n` is what illusory conjunctions measure.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the conjunction operator taken the other way: Boolean-OR superposition over sparse codes is the same construction over Boolean scalars, exact under thresholding at light load, where real-valued addition buys graded similarity and pays interference.
- **[[wiki/entities/sigma-pi-reservoir.md]]** — the same multiplicative unit, 35 years on and with an approximation theory: Pi neurons are Smolensky's sigma-pi binders, and the dimensioning rule `D = O((pR/ε)²)` is the modern statement of the `√N` saturation law derived here.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a structure format with an explicit boundary: an arbitrary-depth relational structure is one activity pattern that can be probed from either side and transformed by matrix multiplication, and the role decomposition that makes it possible is authored, never discovered.
- **[[wiki/concepts/language-of-thought.md]]** — the original technical answer to Fodor & Pylyshyn: constituent structure with a systematic, recursive syntax realised as vector algebra, offered as a way to have the compositional structure without an implementation of serial symbol manipulation.
- **[[wiki/entities/resonator-network.md]]** — what the compressed binder has to pay for discarding the binding units: with the constituents no longer separately addressable, reading a compound whose factors are *all* unknown becomes a `D^F` search, solved by cross-coupled cleanups holding whole codebooks in superposition — a cost the uncompressed product never incurs, and the reason the exponential binder count is a live trade rather than a settled loss.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the same trade at the design step: contextual roles separate superposed structures that positional roles confuse, so choosing the role set *is* choosing where on the separation/completion axis a superposition sits, before any code is picked.
- **[[wiki/entities/esbn.md]]** — the non-algebraic limit of this construction: role-filler independence held by never forming a product at all, so it escapes both the multiplicative binder count and the annihilator obstruction (`G106`) — at the cost that the binding is a table row rather than a tensor, with no partial inner product to probe and nothing to superpose.
