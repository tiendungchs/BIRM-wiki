# Three-Factor Key-Value Memory (Tyulmankov et al. 2021)

**A slot-based key-value store whose write is a *biologically admissible* plasticity rule rather than a controller decision: the key matrix is written by a **non-Hebbian, presynaptic-only** rule gated by a per-hidden-unit local third factor (a dendritic plateau), the value matrix by a Hebbian rule gated by the same event, and forgetting is the *same* multiplicative term that performs the write. Reading is one feedforward step — `h = softmax(Kx̃)`, `ỹ = Vh` — with no attractor settling anywhere.**

The wiki's first store in which **both** stages of the Sparse Distributed Memory split are plastic. [[wiki/entities/sparse-distributed-memory.md]] freezes the address matrix and learns only the contents; [[wiki/entities/btsp-cam.md]] learns the address stage and has no separate value stage at all; this network writes the address (key) and the content (value) in one gated event, with a different rule on each side — and the difference between the two rules is recovered, not assumed, when the rule is meta-learned.

> **Provenance.** `raw/tyulmankov-2021-biological-learning-in-key-value-memory-networks.md` — ar5iv rendering of arXiv 2110.13976, NeurIPS 2021. The clip carries no byline; authors Tyulmankov, Fang, Vadaparty & Yang (Columbia), recovered from the arXiv record. All figures are images absent from the clip, so every number below is from the text or the appendix, not read off a plot.

---

## Architecture

| Component | Symbol | Role | Biological reading offered |
|---|---|---|---|
| Input | `x_t ∈ {±1}^d` | The key being stored, or the query `x̃` | — |
| Hidden | `h_t ∈ ℝ^N` | One unit **per memory slot**; approximately one-hot at read time | — |
| Output | `y_t ∈ {±1}^m` | The value | — |
| Key matrix | `K_t` (`N × d`) | Row `i` = key stored in slot `i` | Input→hidden synapses (dendrites of hidden cells) |
| Value matrix | `V_t` (`m × N`) | Column `i` = value stored in slot `i` | Hidden→output synapses (axons of hidden cells) |
| Local third factor | `[γ_t]_i ∈ {0,1}` | **Selects which slot is written.** Gates all input synapses onto hidden unit `i` | Dendritic spike/plateau, largely independent of somatic firing `h_t` |
| Global third factor | `q_t ∈ {0,1}` (or `10`) | **Decides whether to write at all** | Neuromodulator (acetylcholine), driven by novelty, salience or attention |

```
read      h  = softmax(K_t x̃)            ỹ = V_t h            (one step)
write K   K_{t+1} = (1 − η^K_t) ⊙ K_t + η^K_t ⊙ [1 x_tᵀ]      [η^K_t]_ij = q_t [γ_t]_i
                                                               ← pre-only: no h_t term
intermed. h'_t = softmax(K_{t+1} x_t)     ≈ one-hot at slot i
write V   V_{t+1} = (1 − η^V_t) ⊙ V_t + η^V_t ⊙ y_t (h'_t)ᵀ   [η^V_t]_ki = q_t [γ_t]_i
                                                               ← Hebbian
```

Three structural facts a builder needs, none of which the equations advertise:

1. **Erase and write are the same operation.** `(1 − η)⊙K` zeroes exactly the synapses the very next term writes. There is no decay constant, no eviction policy and no separate clear signal: the slot is emptied *by being chosen*, and a slot nobody chooses is never touched. This is the wiki's only store where forgetting costs nothing and is scheduled by the allocation gate ([[wiki/concepts/memory-read-and-erase.md]]).
2. **The write is ordered within the event.** `h'_t` is computed from `K_{t+1}`, not `K_t` — the key must already be in the slot for the value write to find the slot. A one-shot store therefore needs a *two-phase* write, and the second phase's addressing is done by the first phase's product.
3. **The value write needs the output clamped to the target.** Offered mechanisms: strong one-to-one residual connections input→output, or a common circuit driving both layers. Neither is demonstrated; this is the model's weakest wiring assumption.

**Equivalences.** Mathematically an [[wiki/entities/continuous-modern-hopfield-network.md]] restricted to the heteroassociative setting, with fixed activation functions and recurrent dynamics run for **exactly one step**; alternatively a differentiable [[wiki/entities/sparse-distributed-memory.md]] with softmax replacing the step function. The contribution is not the architecture — it is that this architecture, alone among modern Hopfield variants, is given a write rule that a synapse could execute.

---

## Capacity: measured, and the number is not the headline

Capacity `C` = maximum stored patterns at ≥98% recall accuracy, autoassociative task, 60% of query entries zeroed, `d = N = 40`.

| Store | Scaling | Overload behaviour |
|---|---|---|
| **This network, sequential `γ`** (`[γ_t]_i = 1` iff `t ≡ i mod N`) | `C ≈ 1.0 N` — analytically expected, one pattern per slot | Graded: patterns overwritten **one at a time**, oldest first |
| **This network, random `γ`** (`Bernoulli(p)`) | `C ≈ 0.16 N` | Graded; degrades sooner, from random collisions |
| [[wiki/entities/hopfield-network.md]] (outer product) | `C ≈ 0.14 N`, matching Amit et al. 1985 | **Blackout catastrophe** — past capacity *all* stored patterns are lost, not the marginal one |

**The honest accounting, which the paper states itself.** At matched `N` this network has *twice* the connections of the Hopfield net (`Nd + mN` vs `N²`), so the random-gate version's capacity **per connection** is no better than Hebbian Hopfield. This independently re-derives Keeler's 1988 result that SDM and outer-product Hopfield have the same capacity per storage element ([[wiki/entities/sparse-distributed-memory.md]]) — for a third architecture, with a third write rule. What key-value structure buys is therefore **not density**; it is:

- **No cliff.** Graded overload at arbitrary network size, because an overwrite destroys one slot rather than corrupting a shared energy landscape. `G42`'s real complaint — that failure is silent and total — is answered by the storage scheme, not by the bound.
- **Capacity decoupled from input dimension.** `N` is free; Hopfield capacity is capped by the pattern size, since the pattern *is* the network ([[wiki/concepts/retrieval-capacity.md]]).
- **Tolerance of correlated data.** At `corr(x_t, x_t') = 0.6` performance is near-identical to the uncorrelated case (minor spurious recall of similar items), where correlated patterns merge Hopfield attractors and cut capacity. Distinct slots do not interfere by construction.
- **Per-memory policy.** Individual memories can be treated differently — see flashbulb, below — which a single superposed weight matrix cannot do.

**The gate policy is worth 6× and has no biological mechanism.** Sequential (least-recently-used) allocation gives `C ≈ 1.0N`; independent per-unit stochastic allocation gives `C ≈ 0.16N`. The paper offers three justifications for sequencing — a per-neuron internal timer firing every `N` steps, a priming chain `i → i+1`, or an external coordinating circuit — and demonstrates none. For the random gate, `p ≈ 4/N` is the empirical optimum (probability of *no* slot being selected < 2%, while minimizing collisions), and scaling `p` with `N` beats any fixed `p`. See `T391`.

---

## Meta-learning recovers the hand-designed rule

The rule is re-parameterized as a generic "pre-times-post" update with each firing rate passed through a learned affine transfer function — `[f^K(x)]_j = ã^{f^K} x_j + b̃^{f^K}`, and analogously `g^K, f^V, g^V` — which interpolates continuously between Hebbian, anti-Hebbian and pre-only or post-only rules:

```
K_{t+1} = (1 − η^K_t) ⊙ K_t + η^K_t ⊙ [ g^K(h_t) f^K(x_t)ᵀ ]
V_{t+1} =      λ_t    ⊙ V_t + q_t η̃^V ⊙ [ g^V(y_t) f^V(h'_t)ᵀ ]
```

Trained by Adam on the benchmark task (sequence lengths `N/2` to `2N`, i.e. above capacity, so accuracy never reaches 1.0), the parameters converge to:

| Synapse group | Learned parameters | Rule recovered |
|---|---|---|
| Input → hidden (keys) | `ã^{f^K} ≈ 0.5, b̃^{f^K} ≈ 0`; `ã^{g^K} ≈ 0, b̃^{g^K} ≈ 0.5` | **Pre-only** — the postsynaptic slope goes to zero and stays there |
| Hidden → output (values) | `ã^{g^V} ≈ ã^{f^V} ≈ 1`, `b̃ ≈ 0` | **Hebbian** |

Two riders. (i) The *asymmetry* between the two synapse groups is the recovered object — meta-learning is not told which side should be non-Hebbian and finds the split anyway, which is the strongest evidence in the wiki that a key stage and a value stage want *different* write rules ([[wiki/concepts/meta-optimized-plasticity.md]]). (ii) Biological realism was *increased* before meta-learning, not after: the hidden→output synapses were denied access to `γ_t` on the grounds that an axon cannot see its own cell's dendritic spikes, and the resulting rapid gated erase was replaced by a uniform passive decay `λ_t = (1 − q_t) + q_t λ̃` applied on every store event. Performance did not drop, and improved slightly for long sequences. The networks also generalize to sequence lengths outside the training range.

---

## What the slot structure buys, task by task

| Task | Result | Why it works here and not in a superposed store |
|---|---|---|
| **Continual recall** (ongoing stream, recall the item shown `R` steps ago) | Both gates beat Hopfield throughout. Sequential accuracy falls in **steps of width `N`**; random falls smoothly | The erase-by-write *is* the forgetting mechanism, so a continual regime needs no extra machinery. The step structure is an artifact of the cycling gate advancing even when `q_t = 0` |
| **Flashbulb memories** (5 salient items at `q_t = 10`) | Retained with **minimal cost** to ordinary recall | A metaplasticity bit: `[S_t]_ij ← 1` permanently once `[η_t]_ij > 1`, suppressing all later plasticity at that synapse. Hopfield must instead write flashbulb items at large magnitude and pays a direct trade-off against regular capacity, because synaptic stability in a superposed matrix is itself damaging |
| **Correlated stimuli** (`ρ = 0.6`) | Near-uncorrelated performance | Distinct slots; no shared energy landscape to merge |
| **Heteroassociative** (`m ≠ d`) | **Unaffected**; Bidirectional Associative Memory deteriorates | `K` and `V` are separate matrices, so the key→value map is unconstrained. Autoassociation is the special case `V = Kᵀ`, not the default |
| **Sequence recall** (`x_{t+1} = ỹ_t`, recurrent loop) | Error-free until the capacity limit; BAM worse | No error propagation while each read is exact; a pointer chain in the sense of SDM |
| **Copy-paste** (memory module + learned controller emitting `x_t`, `y_t`, `q_t`) | Sequential version learns and **generalizes past trained sequence lengths**; BAM learns but does not generalize | The module is composable: a controller can learn to *drive* the third factors without learning the write itself |

The flashbulb result is the sharpest architectural claim on the page: **a store whose items are independent can be given a per-item retention policy, and a store whose items are superposed cannot.** That is a property of the decomposition, not of the learning rule.

---

## Limitations

| Limit | Consequence |
|---|---|
| **Sequential allocation has no mechanism** | The 6× capacity advantage rests on cross-unit coordination that biology is not shown to supply, and the two demonstrated advantages in the copy-paste and sequence tasks both use it (`T391`) |
| **One-hot `h` assumes uncorrelated keys** | The read's exactness comes from `x_t·x_t = d` dominating near-zero off-diagonal dot products. Correlated *keys* (as opposed to correlated stimuli stored in distinct slots) erode this, and nothing measures where |
| Softmax is asserted to be biological | "Can be approximated biologically with inhibitory recurrent connections" — not implemented, not measured. The read's normalization is doing real work ([[wiki/concepts/inhibitory-control-of-coding.md]]) |
| Value write requires clamping the output to the target | Needs either one-to-one residual input→output wiring or a common drive to both layers; neither is demonstrated |
| **Artificial stimuli only** | Random binary vectors and a template-flip correlation model. No naturalistic data, no comparison to neural recordings or memory behaviour — the paper states validation as a true brain model is outstanding |
| Not competitive with engineered memory networks | The stated aim is parity with the classical Hopfield network, not with the state of the art |
| Capacity per connection is not improved | The gain is in overload behaviour, flexibility and correlation tolerance — not in density |
| No structure discovery | Stores, retrieves and chains. Nothing notices that two stored pairs share a relational form ([[wiki/concepts/latent-graph-discovery.md]]) |

---

## Comparison

| | This network | [[wiki/entities/btsp-cam.md]] | [[wiki/entities/sparse-distributed-memory.md]] | [[wiki/entities/hopfield-network.md]] |
|---|---|---|---|---|
| Address stage | **Plastic** (pre-only, gated) | **Plastic** (binary involution, gated) | Frozen random | None — content is the address |
| Content stage | **Plastic** (Hebbian, gated) | Random feedback, one-shot Hebbian | Plastic counters | Same matrix as address |
| Items per write | **One slot** | Many cells (`f_q N`) | `pM` locations | The whole matrix |
| Write gate | `γ` (local) `× q` (global) | Plateau probability `f_q` only | None — the cue decides | None |
| Postsynaptic term in the key rule | **Absent** | **Absent** | Absent (fixed addresses) | Present (it is the rule) |
| Forgetting | Erase-by-write, free | Depression branch of the involution | Counter saturation | None |
| Read | One feedforward step | One feedforward step | One step, or iterate for denoising | ~100 settling iterations |
| Overload | Graded, one item at a time | Graded | Graded | **Cliff** |
| Per-item policy | **Yes** (metaplasticity bit) | No | No | No |
| Heteroassociation | Native | No | `U ≠ N` | Needs BAM, degrades |

The three feedforward stores agree on the two things that matter and differ on the third: all reject recurrent settling, all reject a postsynaptic term in the address write, and they split on **how many units one memory occupies** — one slot here, a distributed trace in BTSP-CAM and SDM. That split is exactly what makes per-item policy possible here and impossible there, and what makes the capacity here linear in slots rather than in the combinatorics of trace overlap.

**(brainstorm) The two third factors are a complete write-policy interface, and no machine store exposes it.** `q_t` answers *whether* (novelty, salience, surprise — a scalar a controller can learn, as the copy-paste task shows) and `γ_t` answers *where* (allocation). Every machine fast store in the wiki fuses these into one decision or hardcodes both. Splitting them is what lets the same store be an episodic buffer (`q` on, `γ` cycling) and a salience-weighted long-term store (`q` large, metaplasticity latching) with no architectural change — and it gives `G19`'s missing write-selectivity a two-signal shape: a global scalar that is cheap to learn and a local address that need not be learned at all.

**(brainstorm) The graded overload is purchasable in any attention layer.** Since the read is one-step attention, the difference between this store and a transformer's key-value cache is entirely in the *write*: a cache appends until evicted by recency, this network overwrites by an allocation gate with a metaplasticity latch. A cache with a learned `q` (write-worthiness) and a latch (never evict this one) is a small change with the flashbulb property attached, and nothing in the wiki has built it.

---

## Connections

- **[[wiki/entities/sparse-distributed-memory.md]]** — the same three-layer expansion-then-readout skeleton with the frozen half unfrozen: SDM fixes the address matrix and learns only the counters, this network writes the address by a gated pre-only rule — which replaces SDM's derived-but-static sparsity `p = (2MT)^{−1/3}` with an allocation *gate*, and independently reproduces Keeler's capacity-per-storage-element equality against Hopfield.
- **[[wiki/entities/btsp-cam.md]]** — the same refusal of a postsynaptic term and the same dendritic-plateau gate, applied to a distributed trace rather than a single slot: that page's `f_q` and this page's `[γ_t]_i` are the same parameter, but there an input-independent stochastic gate is the *feature* (uniform load, no retrograde interference) and here it costs 6× capacity against a sequenced gate (`T391`).
- **[[wiki/entities/continuous-modern-hopfield-network.md]]** — the architecture this network is a special case of (heteroassociative, fixed activations, one update step), supplied with the one thing that line lacks: a write a synapse could execute. Read together they close a loop — that page derives attention's capacity from the read, this one derives the read's *contents* from a local rule.
- **[[wiki/entities/hopfield-network.md]]** — the baseline it is built to replace, beaten on overload behaviour (graded vs blackout), correlated inputs, heteroassociation and per-item policy, and matched — not beaten — on capacity per connection (`C ≈ 0.16N` at 2× the connections, against `C ≈ 0.14N`).
- **[[wiki/concepts/synaptic-plasticity.md]]** — the rule family's key missing member: a **pre-only** write whose third factor selects an *address* rather than licensing a coactivity, which is the page's rule 6 (BTSP) used for allocation instead of for receptive-field creation — and the split, recovered by meta-learning, that the address write and the content write want different rules.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — the cleanest positive result in the wiki for rule recovery: an affine pre/post parameterization spanning Hebbian, anti-Hebbian and pre-/post-only rules converges to the hand-designed asymmetry (pre-only keys, Hebbian values) rather than to something unreadable, which is the counterexample to the complaint that meta-learned rules are not interpretable.
- **[[wiki/concepts/memory-allocation-excitability.md]]** — the machine statement of what allocation *is worth*: sequenced (least-recently-used) versus independent stochastic selection of the writing unit is a 6× capacity difference at matched hardware, which is the quantity the biological allocation literature describes mechanistically and never prices.
- **[[wiki/concepts/memory-read-and-erase.md]]** — a store where erase is not a primitive at all: the `(1 − η)` factor clears exactly the synapses the write then fills, so forgetting is free, synchronous with the write, and scheduled entirely by the allocation gate — and the metaplasticity bit adds the one removal-policy primitive the page's inventory lacks, *refuse to be erased*.
- **[[wiki/concepts/retrieval-capacity.md]]** — the item-count side of capacity with the input dimension decoupled from it: `N` slots are free hardware, so the binding resource stops being the pattern size and becomes the slot count — leaving that page's query-set bound as the constraint that still applies.
- **[[wiki/concepts/fast-weight-programming.md]]** — the same one-step key-value write over a fast matrix, with the machine-learning version's controller-issued write replaced by two biological gates, and its sum-over-writes replaced by an overwrite: the interference that bounds a fast-weight store at `d_dot` associations is here traded for the loss of exactly one slot.
- **[[wiki/concepts/attention.md]]** — the read is `softmax(Kx̃)` followed by a linear readout, i.e. one attention layer; what this page adds is the *write*, which attention leaves to whatever produced the cache — and a two-signal write policy (`q` whether, `γ` where) that a cache could adopt directly.
- **[[wiki/concepts/continual-learning.md]]** — continual recall handled with no replay, no regularizer and no task boundary, because slot reuse is the forgetting mechanism; the cost is that retention is set by the allocation rate rather than by the item's value, which the metaplasticity latch then patches per item.
- **[[wiki/concepts/complementary-learning-systems.md]]** — a fast store that does the fast half without attractor dynamics, and prices it: one-shot writes, graded overload, capacity linear in slots, and a salience gate on the write that decides what the slow system will ever see.
- **[[wiki/concepts/dendritic-computation.md]]** — the local third factor is a dendritic spike acting *largely independently of somatic output*, which is what makes the address write non-Hebbian: the compartment that decides where a memory goes is not the compartment that computes the read.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the global third factor `q_t` used as a write-enable driven by novelty or salience rather than by reward, and a rare case where its *magnitude* matters (`q_t = 10` latches a flashbulb memory), so one broadcast scalar carries both a gate and a priority.
- **[[wiki/concepts/key-value-memory.md]]** — the framing this network is the write rule for: keys and values are separate representations with different objectives, which is why meta-learning here recovers *different rules* on the two synapse groups — and the review cites this page's key rule as the machine counterpart of behavioural-timescale plasticity.
