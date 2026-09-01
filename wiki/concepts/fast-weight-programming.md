# Fast Weight Programming

**A sequence model whose state is a *weight matrix*: a slow network emits its own key/value patterns and writes them into a fast matrix by outer product, then reads that matrix with a query. Linearised self-attention is exactly this machine, which converts three questions the attention literature treats as engineering — how much can the cache hold, what does a write do to the entries it does not address, and can an entry be corrected — into questions about an *update rule*, with closed-form answers.**

> **Provenance.** Schlag, Irie & Schmidhuber 2021, *Linear Transformers Are Secretly Fast Weight Programmers*, ICML (`raw/schlag-2021-linear-transformers-fast-weight-programmers.md`). The Fast Weight Programmer (FWP) itself is Schmidhuber 1991–1993; this source supplies the equivalence, the capacity argument, the delta-rule instruction, and the measurements.

---

## The machine, and the equivalence

Slow weights `W_k, W_v, W_q` are trained by gradient descent; the **fast weights** `W^(i)` are the state, produced at every step and never trained directly.

| | Fast Weight Programmer (1991) | Linear Transformer (2020) |
|---|---|---|
| Emit | `a^(i), b^(i) = W_a x^(i), W_b x^(i)` | `k, v, q = W_k x, W_v x, W_q x` |
| Write | `W^(i) = σ(W^(i-1) + a^(i) ⊗ b^(i))` | `W^(i) = W^(i-1) + v^(i) ⊗ φ(k^(i))` |
| Read | `y^(i) = W^(i) x^(i)` | `y^(i) = W^(i) φ(q^(i)) / (z^(i)·φ(q^(i)))` |

The derivation that joins them is two lines. Delete the softmax from `y^(i) = V^(i) softmax((K^(i))ᵀ q^(i))` and reassociate:

```
y^(i) = (V^(i) (K^(i))ᵀ) q^(i) = ( Σ_{j≤i} v^(j) ⊗ k^(j) ) q^(i)
```

— the sum *is* a fast weight matrix. Replacing the softmax kernel `κ(k,q) = exp(kᵀq)` by any factorisable `κ'(k,q) = φ(k)ᵀφ(q)` recovers the same form with `φ(k)` in place of `k`, plus a normaliser `z^(i) = Σ_j φ(k^(j))`. So *the family of linear attentions is the family of outer-product FWPs, with attention normalisation*, and every linear-attention paper is proposing a `φ` (Sec. 5) or an update rule (Sec. 4.2) without saying so.

**The distinguishing claim against the older associative-memory literature** (Hebb; Hopfield; bidirectional associative memories; Smolensky's tensor product representations) is not the outer product, which they all use, but that the patterns being bound are **self-invented**: the roles and fillers are outputs of a trained network rather than a symbol table supplied in advance. That is the entire difference between a tensor-product representation of a structure you already have and one a model discovers ([[wiki/concepts/vector-symbolic-binding.md]], [[wiki/concepts/latent-graph-discovery.md]]).

---

## Capacity is `d_dot`, and the failure is silent

Retrieval `W^(i) φ(q)` returns a linear combination of every stored value whose key is non-orthogonal to `q`. At most `d_dot` vectors can be mutually orthogonal in `R^{d_dot}`, so **storing more than `d_dot` associations guarantees retrieval error** — the same crosstalk Smolensky 1990 (Thms 3.1, 3.3) proves for second-order tensor product representations. Whenever sequence length `L > d_dot` the model is in an **overcapacity regime**, and nothing in the architecture reports it.

Measured (Sec. 6.1.1: retrieve the value for a query key presented *after* `L = S` random pairs, so nothing can be deferred to the query; `d_key = 64`):

| `φ` | `d_dot` | Where error starts |
|---|---|---|
| Linear attention, `ELU(x)+1` (Katharopoulos et al. 2020) | 64 | ~60 associations |
| DPFP-1 / -2 / -3 (below) | 128 / 256 / 384 | at their respective bounds |
| FAVOR+ / Performer, `m` = 64, 128, 512 random features | `2m` | **never reaches zero loss at any `S`** — the sampling variance is a noise floor |
| Softmax | grows with `L` (keys are concatenated, not summed) | best everywhere; strains past 500 |

Three consequences a builder should carry:

- **The bound is a design-time number, exactly matched by the breakdown point.** This is the wiki's cleanest instance of gap **G42**'s demand — a fast store whose capacity is derived rather than tuned, and whose measured cliff sits where the derivation puts it.
- **Softmax attention's advantage here is that it is not a fixed-size store at all.** It concatenates immutable key/value pairs and grows linearly in `L`; the price is the quadratic read. So the standard trade is *unbounded capacity with quadratic cost* against *bounded capacity with constant state*, and the capacity term is usually left out of the comparison ([[wiki/entities/transformer.md]]).
- **A `φ` that only rectifies (`ELU+1`) leaves capacity untouched**, because it is element-wise: `d_dot = d_key`. Raising capacity requires a dimension-expanding `φ`, which is what the third row below is for.

---

## The three update rules, and why only one is a `replace`

Given a new pair `(k, v)` for a key that is already bound, three published instructions:

| Rule | Write | What it does to an *unrelated* association `(k₁, v₁)`, `k₁ ⊥ k` |
|---|---|---|
| **Sum** (linear Transformer) | `W ← W + v ⊗ φ(k)` | intact — but the old value for `k` is never removed, so the read returns `v_old + v_new` |
| **Gated** (Peng et al. 2021) | `W ← (1-β) W + β v ⊗ φ(k)` | **`W'k₁ = (1-β) v₁`** — every entry is decayed by the same scalar; at `β → 1` the store is erased |
| **Delta** (this source) | `v̄ = W φ(k)`; `W ← W + β (v - v̄) ⊗ φ(k)` | **`W'k₁ = v₁`, exactly** |

Both the gated and the delta rule interpolate the *addressed* value identically to `(1-β) v_old + β v_new`. They differ only off the address, and that difference is the whole content of Appendix B: a gate is a global decay wearing the costume of a write, while the delta rule is a genuine **content-addressed replace** — it reads what is currently at `k`, subtracts it, and writes the interpolant, so the erase lands on the association being overwritten and nowhere else.

```
W^(i) = W^(i-1)  + v_new^(i) ⊗ φ(k^(i))   [write]   - v̄^(i) ⊗ φ(k^(i))   [remove]
      = W^(i-1)  + β^(i) ( v^(i) - v̄^(i) ) ⊗ φ(k^(i))
```

This is the Widrow–Hoff delta rule with a **learned, per-step learning rate** `β^(i) = σ(W_β x^(i))`, `W_β ∈ R^{1×d}` — one extra row of parameters (16K / 33K in the two language-model configurations). The write strength is emitted by the controller from the current token; in layers above the first, `x^(i)` already carries context, but in layer 1 it does not, which is the mechanism's one structural under-specification.

**Normalisation is not optional and the usual choice is wrong here.** The accumulator `z^(i) = Σ_j φ(k^(j))` ("attention normalisation") grows monotonically and, for the delta rule, still fails to balance the write against the remove term. The fix is **sum normalisation** — divide `φ(k)` and `φ(q)` by the sum of their components before use, so `Σ_j k_j = 1` and matrix–vector reads become genuine convex mixtures of the matrix's columns (Appendix A.2). Without it the models diverged; *with* it, attention normalisation on top makes perplexity worse.

---

## `φ`: three ways to buy orthogonality

| `φ` | `d_dot` | Cost |
|---|---|---|
| `ELU(x)+1` | `d_key` | free; no capacity gain; positivity only |
| FAVOR+ `h(x)/√m · [exp(Rx); exp(-Rx)]`, `R` Gaussian | `2m` | unbiased softmax approximation, but **sampling variance in the model's output**, and slower (57K vs 63K words/sec) |
| **DPFP-ν** (this source): `φ_{iν}(k) = r([k; -k])_i · r([k; -k])_{i+ν}`, `r = max(0,·)` | `2 d_key ν` | deterministic, parameter-free, three lines of PyTorch; products of rectified pairs make disjoint supports, so distinct keys land on near-disjoint coordinates |

DPFP's design principle is worth separating from its formula: **manufacture orthogonality by sparsity**. Two rectified factors are simultaneously non-zero only in one orthant-like cell, so the projection partitions the key space rather than rotating it — the same trick as expansion-then-thresholding in a sparse conjunctive code ([[wiki/concepts/sparse-distributed-representations.md]], [[wiki/concepts/pattern-separation-completion.md]]), arrived at from the linear-algebra end.

---

## Measurements

**WMT14 En–De, "big" configuration, no per-model tuning (test BLEU):**

| `d_dot` | 64 | 256 | 512 |
|---|---|---|---|
| Standard Transformer | **27.7** | – | – |
| Linear (`ELU+1`) | 26.8 | – | – |
| Performer | 24.4 | 25.3 | 27.7 |
| DPFP | – | 26.9 | 27.1 |

DPFP wins at small `d_dot`; Performer needs `m ≈ d_key log d_key` to catch up, i.e. the random-feature route buys accuracy only by spending the capacity dimension it was meant to save.

**WikiText-103, 16 layers, limited context (test perplexity):**

| Model | Update | small (`D`=128, `L`=256, 40M) | medium (`D`=256, `L`=384, 90M) |
|---|---|---|---|
| Transformer | – | 34.1 | 29.6 |
| Linear Transformer | sum | 38.3 | 33.0 |
| **Delta Network** | delta | **35.5** | **31.5** |
| Performer | sum | 39.6 | 33.8 |
| Performer | delta | 37.2 | 31.8 |

The update rule is worth ~1.5–3 perplexity at matched parameters and matched `φ` — a larger effect than the choice of `φ`. Best medium configuration (delta, no positional encoding, no attention normalisation): **31.1**.

**Unbounded context** — carry the fast weights across training segments, backpropagate only within one; evaluate with no truncation:

| Model | State size | Test ppl |
|---|---|---|
| Linear Transformer (sum) | 0.13M | **>260 — breaks** |
| Delta Network | 0.13M | 29.4 |
| Transformer-XL | 0.13M / 1.05M / 2.10M / 6.29M | 65.5 / 30.1 / 27.4 / 25.5 |

This is the sharpest result in the paper and the one that generalises past language modelling. **A purely additive store cannot be run for an unbounded number of steps** — it saturates and the model collapses — while the same architecture with an error-correcting write survives indefinitely at constant state. Transformer-XL still wins outright, but only by spending 16–48× the state; at matched state it is far worse. Overhead of the delta rule: 63K vs 66K words/sec, 14 vs 13 GB (the PyTorch Transformer baseline: 33K words/sec, 17 GB).

---

## Reading in the core framing

| FWP object | Latent-graph reading |
|---|---|
| Fast weight matrix `W^(i)` | The **instance graph** as a matrix of bindings, written during the episode and thrown away after |
| Slow weights `W_k, W_v, W_q, W_β` | The **meta-graph**: what counts as a key, what counts as a value, and when a binding is worth overwriting |
| Outer-product write | Adding an edge |
| `d_dot` | How many edges the instance graph can hold before edges start bleeding into each other |
| Delta write | **Re-labelling an edge without disturbing the rest of the graph** — the operation a store must have if the environment's bindings change mid-episode |

**(brainstorm) The delta rule is the cheapest known answer to "what happens when the world changes under you".** Every fast store in the wiki that binds `key → value` must at some point rebind, and the two available primitives are a global decay (which forgets everything a bit) and a slot overwrite (which needs slots, hence discrete addressing). The delta rule is neither: it is a *distributed* store with an exact targeted replace, obtained by reading before writing. The cost is one extra read per step and one row of parameters, which is close to nothing.

**(brainstorm) The controller emits a write *strength*, and that is a fourth output field.** [[wiki/concepts/memory-read-and-erase.md]] argues the controller's output format is an address plus a lead time plus a removal type; `β^(i)` adds a scalar confidence-of-write on the same channel, and it is the only one of the four that anything in the wiki currently learns end-to-end. What it still cannot express is `suppress` — `β = 1` with `v = 0` erases the key's binding but is not distinguishable from binding it to zero, and nothing in the rule frees capacity.

---

## Open problems

| # | Problem |
|---|---|
| 1 | **The store never reports its own occupancy.** `d_dot` is known at design time and the overcapacity regime is entered silently; nothing computes how close `W` is to rank-saturated, though the singular values are right there (G42, [[wiki/entities/conceptor.md]] does exactly this for a different store) |
| 2 | **`β` sees only the current token.** In the first layer the write strength is decided with no context at all; the natural fix — condition `β` on `‖v - v̄‖`, i.e. on how wrong the store already is — is not tried |
| 3 | **Only `replace` exists.** No `suppress`, no capacity reclamation, no read schedule; the read is still a pure function of the current query (G49) |
| 4 | **Nothing chooses *what* to store.** Keys and values are emitted from every token unconditionally, so an overcapacity store is filled by the input stream rather than by a write policy ([[wiki/entities/pbwm.md]] is the write gate this lacks) |
| 5 | **Higher-order instructions are unexplored, and the paper says so.** The outer product is a second-order tensor; Smolensky's representations go to arbitrary order, and no one has asked what a third-order programming instruction buys or costs |
| 6 | **The delta rule is one step of gradient descent on a squared reconstruction loss.** Whether the fast level should be running an *optimiser* rather than an *update rule* is left open, and is the same question [[wiki/entities/mm-tem-hippoformer.md]] answers the other way |

---

## Connections

- **[[wiki/concepts/attention.md]]** — the identity that reframes this page's subject: removing the softmax and reassociating turns an attention layer into a running sum of outer products, so a linear attention head *is* a weight matrix being programmed, and the head's capacity, its inability to correct an entry, and the effect of a write on unrelated entries all become properties of the update rule rather than of "attention".
- **[[wiki/concepts/memory-read-and-erase.md]]** — supplies the `replace` primitive that page specifies and finds missing everywhere: the delta rule reads the current value at the key, subtracts it, and writes the interpolant, so the removal is addressed at the association being overwritten and provably leaves every orthogonal association exact — where the gated alternative decays the whole store by `(1-β)`.
- **[[wiki/concepts/retrieval-capacity.md]]** — the same dimension bounding a different quantity: that page caps how many distinct *retrieval sets* a `d`-dimensional similarity read can address, this one caps how many *items* a `d_dot`-dimensional outer-product store can hold before crosstalk; both are geometry, both bind before training, and a builder needs the smaller of the two.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the algebra this store is a second-order instance of, with one difference that is the point: a tensor-product representation is built from role and filler vectors given in advance, while an FWP's keys and values are emitted by a trained network, so the crosstalk theorems transfer intact and the symbol table does not have to.
- **[[wiki/entities/transformer.md]]** — the architecture whose cost is usually stated as quadratic-in-length and whose *storage* is rarely stated at all: it concatenates immutable key/value pairs and so has capacity growing with `L` and no way to edit an entry, which is the exact complement of the constant-state, editable store here.
- **[[wiki/entities/s4.md]]** — the other constant-state alternative to attention, and the contrast that locates what this page buys: a linear time-invariant kernel cannot make its read depend on the current content at all, where an FWP's read `W^(i)φ(q)` is content-addressed and its *state* is a full matrix rather than a diagonal recurrence — the price being a capacity bound `S4` does not have to pay because it never claims to store bindings.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — this page is that page's "attention as a weight update" bridge made exact and given a rule: slow **W** are the projections that invent the patterns, fast **M** is the matrix they write into, and the delta instruction is a plasticity rule with a network-emitted learning rate — meta-optimised in the trivial sense that `W_β` is trained by the outer loop.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the same Hebbian outer-product store used for the same purpose (bind this environment's `g`–`x` pairs) and with the same untreated capacity problem; its hand-designed memory-management heuristics are what a learned `β` and an error-correcting write are proposing to replace.
- **[[wiki/entities/mm-tem-hippoformer.md]]** — the rival answer to problem 6 above: replace the outer product with a small MLP whose fast weights take a *gradient step* on a surprise-gated reconstruction loss. The delta rule is one gradient step on a linear reconstruction loss, so the two differ in whether the fast level is linear (closed-form, one read, capacity `d_dot`) or nonlinear (iterative, no capacity result at all).
- **[[wiki/entities/hopfield-network.md]]** — the pre-wired ancestor: same outer-product write, same crosstalk-limited capacity, but the patterns are supplied and the store is autoassociative, so nothing in it learns *what to bind* and nothing can correct a binding without relearning the whole matrix.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the slotted alternative to a distributed store: it gets a targeted erase by carrying explicit addresses, usage weightings and a free list, where the delta rule gets one from linear algebra alone, with no bookkeeping and no addressing — at the price of no capacity reclamation and no `suppress`.
- **[[wiki/entities/spiking-hippocampal-cam.md]]** — the same replace-by-reading-first, implemented in spikes: writing onto an occupied cue makes it recall its old content one step early, and the resulting post-before-pre depression removes exactly the old association — a physical instance of `- v̄ ⊗ φ(k)`, with the selectivity supplied by a refractory period instead of by orthogonality.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the principle DPFP re-derives from the linear-algebra side: expand the code and rectify so that distinct inputs occupy near-disjoint coordinates, since orthogonality is what caps an outer-product store and sparsity is the cheap way to buy it.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the fast level of the framing with an edge-editing operation: the fast weights are the instance graph, the slow projections are the meta-graph that decides what counts as a node and what a binding is worth, and the delta rule is the first primitive here that can re-label one edge without perturbing the others.
- **[[wiki/entities/lru.md]]** — the two constant-state routes at opposite extremes, and the price separation between them: a linear-attention head's state is an `N×N` matrix written by outer products and read by a query, LRU's is an `N`-vector updated by element-wise multiplication with no write rule at all, and LRU carries 16,384 steps with `2N` recurrent parameters — so the matrix state and its `d_dot` capacity bound are paying entirely for the content-addressed read, not for the temporal range.
- **[[wiki/concepts/tensor-product-representation.md]]** — the primary source for the crosstalk theorems this page transfers (Smolensky 1990, Thms 3.1/3.3), plus the duality it drops: accumulating outer products *is* Hebbian learning, so a fast-weight state and a tensor-product activity pattern are one object read two ways (McClelland's Connection Information Distribution makes the binder activities set the weights) — which means `W` can be treated as a manipulable representation of a structure, not only as a store to be queried. It also prices the delta-rule upgrade the classical algebra lacked: Widrow-Hoff relaxes exact retrieval from orthogonality to linear independence but requires all pairs present at once, destroying the independence of generation and maintenance capacity.
