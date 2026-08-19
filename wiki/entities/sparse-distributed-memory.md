# Sparse Distributed Memory (SDM)

**A random-access memory whose address space is too large to build, so a random sample of ~10⁶ *hard locations* stands in for 2¹⁰⁰⁰ addresses: every read and write activates the small set of locations within a Hamming ball of the cue, writes deposit the word into all of them by up–down counters, and reads take a majority vote over the same set. Addressing is fixed and random; only the contents are plastic.**

The wiki's earliest closed-form capacity model for a fast store, and the source of the design split every later store on this wiki repeats — **a fixed addressing stage that decides *where* a memory goes, and a plastic contents stage that decides *what* is there** ([[wiki/entities/vector-hash.md]], [[wiki/entities/rolls-treves-hippocampal-model.md]]). Its distinctive payloads are quantitative: the optimal sparsity is a function of *load* rather than a constant, and the read-out carries its own per-bit reliability estimate.

> **Provenance.** `raw/kanerva-1993-sparse-distributed-memory.md` — Kanerva, *Sparse Distributed Memory and Related Models*, in Hassoun (ed.), *Associative Neural Memories*, Oxford University Press, 1993, pp. 50–76. A synthesis chapter: it presents SDM (Kanerva 1988) and derives its statistics, then shows Jaeckel's designs, Hassoun's pseudorandom memory, Marr's codon model and Albus' CMAC as variants of one architecture, and maps all of them onto the cerebellar cortex.

---

## Architecture

Two matrices and two thresholds. Everything else is bookkeeping.

| Component | Symbol | Sample value | Role |
|---|---|---|---|
| Address length | `N` | 1,000 bits | Input dimension; the cue |
| Word length | `U` | 1,000 bits | Output dimension; the content. `U = N` gives autoassociation and pointer chains |
| Hard locations | `M` | 1,000,000 | Rows of the memory. `M ≪ 2^N` — an exceedingly sparse sample of the address space |
| Hard-address matrix | `A` (`M × N`, ±1) | Uniform random | **Fixed, never trained.** Row `A_m` is the address that location `m` decodes |
| Activation | `y = 1[Ax ≥ D]` | `H = 447`, `D = N − 2H = 106` | Location `m` fires iff Hamming distance `h(x, A_m) ≤ H`, equivalently `A_m·x ≥ D`. ~445 of 10⁶ locations active |
| Contents matrix | `C` (`M × U` counters) | Range `±15` | **The only plastic layer.** Saturating up–down counters |
| Write | `C := C + y wᵀ` | — | Outer-product (Hebbian) rule: add `w` (in ±1) to every activated location. Overflow is lost |
| Read | `s = Cᵀy`, `z = sign(s)` | — | Pool the activated locations, threshold at zero: a majority vote over everything ever written near `x` |

**Ordinary RAM is the degenerate case**: take all `2^N` addresses, `H = 0`, and 1-bit counters, and the write overwrites rather than accumulates. SDM is a random-access memory that has given up exact addressing in exchange for tolerating cues it has never seen.

**As a neural network** it is a three-layer feed-forward net (`N` inputs → `M` hidden units → `U` outputs) with a hard step nonlinearity, in which the first weight matrix is frozen random and the hidden layer is *much wider than the input* — the inverse of the back-propagation convention of the same era, and the reason training is one-shot rather than iterative.

---

## The statistics — the part worth stealing

Read at the storage address `X_T`. The retrieved sum is a weighted vote over all `T` stored words, and **the weights are activation-set overlaps**: `Y_t·Y_T` locations were activated by both `X_t` and `X_T`.

| Quantity | Expression | Sample memory |
|---|---|---|
| Signal (target's own copies) | `μ = Λ = pM` | 445 |
| Cross-talk per stored word | `λ = p²M` | 0.2 |
| Noise | `σ² ≈ pM[1 + pT(1 + p²M)]` | — |
| Bit fidelity | `φ = Φ(μ/σ)` | — |
| **Optimal activation probability** | **`p = (2MT)^(−1/3)`** | 0.000368 |
| Asymptotic capacity | `τ = T_max/M = 1/[Φ⁻¹(φ)]²` | 0.105 at `φ = 0.999` (0.096 at `M = 10⁶`) |
| Practical guide | `T` = 1–5% of `M` | — |

Three consequences:

1. **Separation is quantified with no plasticity involved.** Two dissimilar cues share `p²M` locations against the `pM` a cue shares with itself — a factor `1/p ≈ 2,000` — purely because the address space is high-dimensional. The transfer curve of [[wiki/concepts/pattern-separation-completion.md]] here is set by one scalar, `H`, and computed rather than tuned.
2. **The optimal sparsity is a function of load.** `p ∝ (MT)^(−1/3)` falls as the store fills: the correct separation/completion bias for an *empty* store is not the correct one for a full store, and the schedule is explicit (`p ∝ T^(−1/3)`). It also moves with the data — larger than `(2MT)^(−1/3)` (up to ~2×) when retrieval cues are noisy, smaller when the data are clustered.
3. **Capacity is decoupled from pattern size.** Keeler (1988) showed SDM and the binary Hopfield network trained by the outer-product rule have the *same capacity per storage element*; Hopfield's `0.15N` corresponds to `φ = 0.995` (one bit in 200 wrong). The architectural difference is that SDM's storage elements number `M × U` with `M` free, so doubling the hardware doubles the words stored, while Hopfield capacity is capped by the word size itself.

**The read-out reports its own reliability.** Each output bit comes with `|s_u|`, its distance from threshold — the memory's evidence for that bit, available at runtime with no labels and no ground truth. This is the only per-retrieval confidence signal in the wiki's memory inventory (gap G42).

---

## What it does

| Behaviour | Mechanism | Demonstrated |
|---|---|---|
| **Prototype extraction** | Store nine 20%-corrupted copies of one 256-bit pattern autoassociatively; read with a tenth noisy cue and feed the output back as the next address | 20% → 6% → 2% noise, then a fixed point. The prototype was never stored |
| **Iterative denoising = attractor dynamics without recurrent weights** | The feedback loop is *address → contents → address*, not a recurrent weight matrix | Same experiment; convergence in 2–3 reads |
| **Sequence storage** | Pointer chain: store `W_t` at address `X_t = W_{t−1}` | Six-element sequence recalled from a 30%-noisy cue at the middle, noise falling 30% → 20% → 3% → 0% along the chain |
| **Graceful degradation of the cue** | Activation by Hamming ball, not by match | Cue noise costs signal smoothly; the failure mode is a wrong bit, not a lost memory |

---

## Mapping to the cerebellum

The correspondence was noticed after the model was built, and is the sharpest anatomy-to-algorithm match in the wiki outside the hippocampal formation.

| SDM | Cerebellar cortex | Numbers (cat) |
|---|---|---|
| Address bits `x` | Mossy fibres | Several million → `N ~ 10⁶` |
| Hard locations / address decoders `A` | **Granule cells** | Billions → `M ~ 10⁹`, few active at a time |
| Counters `C` | Parallel-fibre → Purkinje synapses | ~10⁵ parallel fibres cross one Purkinje dendritic tree, so one output bit is computed from ~10⁵ counters |
| Output bits `z` | Purkinje cells | ~10⁶ cells; ~10⁵ effective output dimensions (one olivary cell drives ~10 climbing fibres) |
| Word-in line (the value being written) | **Climbing fibre** | Paired one-to-one with the Purkinje cell it teaches — exactly the pairing the storage rule requires, since the bit must be present at every synapse of its column |
| Activation threshold `H` | **Golgi cells** | Feedback inhibition onto granule cells; in Marr's model it holds 500–5,000 of 200,000 codon cells active *regardless of how many inputs are firing* |

**Two discrepancies, and both are informative.** A granule cell receives 3–5 mossy fibres, not `N` — so activation is not a Hamming ball but a conjunction of a few selected coordinates. Jaeckel's *selected-coordinate* design (`k = 10` signed coordinates, `p = 0.5^k`) and *hyperplane* design (`k = 3` ones, `p ≈ (L/N)^k`) formalise this, and both achieve **better signal-to-noise than the basic design while needing three orders of magnitude fewer connections**. Marr's codon cells and Albus' CMAC are further special cases of the same family. And the Golgi feedback makes the activation threshold a *runtime variable driven by current network activity* rather than a design constant — a working controller for the knob gap G38 says nothing sets.

---

## Limitations

| Limit | Consequence |
|---|---|
| **Uniform-random data is assumed, and no real data is uniform** | Clustered data leaves most hard locations never activated (wasted) and hammers a few until their counters are noise. This is a standing argument against generic random projection as a separation mechanism ([[wiki/empirical-tensions.md]] T55) |
| Fixes are all *data-dependent addressing* | Draw hard addresses from the data distribution (Keeler 1988; best NETtalk results from using data addresses as hard addresses, Joglekar 1989; spoken-digit recognition improved "dramatically", Danforth 1990; self-organising-map placement, Saarinen et al. 1991), or keep random addresses and adapt the activation rule — a per-location radius `H_m` (Pohja & Kaski 1992) or a per-cue weighted Hamming distance (Kanerva 1991) |
| Capacity is ~10% of `M` | Much hardware per stored pattern — but at 1-bit addresses and 5-bit counters, so the resolution per element is minimal |
| **Nothing is learned about the input** | The memory "assigns no meaning to the data beyond the reliability estimate". Its usefulness depends entirely on an encoder for which Hamming distance ≈ semantic distance — all views of an object close, different objects far. Kanerva's own conclusion: the encoder is the major function, not preprocessing |
| No structure discovery, no relational inference | It stores, denoises and chains. Nothing notices that two stored patterns share a form ([[wiki/concepts/latent-graph-discovery.md]] sources 1–2, 4–6 all untouched; source 3, aliasing, is handled only in the weak sense that dissimilar cues get near-disjoint location sets) |
| Sequences are chains, not graphs | A pointer chain has no branching: an address with two successors averages them. Same shortfall as [[wiki/entities/vector-hash.md]]'s unstructured 2-D shift |
| Error-correcting variants overfit | Training `C` by the delta rule (CMAC, Prager & Fallside, Joglekar, Danforth) compensates for clustering in both addresses and words, and introduces the possibility of overfitting the training set — the one place the model stops being one-shot |

---

## Comparison

| | SDM | Hopfield (outer-product) | [[wiki/entities/rolls-treves-hippocampal-model.md]] | [[wiki/entities/vector-hash.md]] |
|---|---|---|---|---|
| Where fixed points come from | The **address sample** `A`, fixed before data | Stored content | Stored content in CA3 | Prestructured grid code |
| Plastic layer | Contents only (`C`) | The single recurrent matrix | Perforant path + CA3 recurrence | Hippocampus↔cortex only |
| Capacity | `τ ≈ 0.10 · M`, independent of `N`, `U` | `≈0.14N`, capped by pattern size | `p_max ≈ kC/(a ln(1/a))` | Exponential in scaffold size |
| Overload | Graded — cross-talk grows as `pT`, `|s_u|` shrinks | Cliff, total loss | Cliff | Graded (resolution, not identity) |
| Sparsity set by | `p = (2MT)^(−1/3)`, **derived and load-dependent** | Not a parameter | `a`, hand-set | `N_h` at design time |
| Addresses movable by action | **No** — no algebra on the address space | No | No | **Yes** — velocity shifts on the grid torus |
| Runtime confidence read-out | **Yes** (`|s_u|`) | No | No | Recognition via mean rate |
| Structure discovery | None | None | None | None |

The last two rows are where three decades went. Vector-HaSH is SDM with the random address sample replaced by a *path-integrable* one, which buys exponential capacity and zero-shot inference at the cost of assuming the code; SDM's addresses are cheaper and assume nothing, and there is no way to move from an address to a neighbouring address except by already holding the neighbour.

**(brainstorm) The load-dependent sparsity schedule is directly portable and nothing uses it.** Every fast store in the wiki fixes its sparsity at design time. `p ∝ (MT)^(−1/3)` says a store should *start* dense — few locations, wide basins, strong completion when almost nothing is stored — and sparsify as it fills, with an exponent, not a heuristic. In a machine store the count `T` is known exactly, which makes this the one G38 controller that requires no error signal, no neuromodulator and no extra machinery: read the write counter, set the threshold.

**(brainstorm) `|s_u|` is the missing half of a write policy.** A store that knows its per-bit evidence can refuse: if reading `x` before writing returns a confident answer already, the write is redundant; if the sums are near zero everywhere, the region is unclaimed and the write is safe. CMAC already does the first half of this (correct the counters only if the retrieval error is too large, by `g(p̂_u − s_u)/K`) — error-gated writing, from 1971, which is precisely the write-selectivity that gap G19 says no local rule has.

---

## Connections

- **[[wiki/entities/vector-hash.md]]** — the same two-stage design thirty years later, with the fixed random address sample replaced by a prestructured grid code: this page shows what the split buys with *no* assumption about the address space (capacity `0.1M`, no algebra, no transfer), which is the baseline the scaffold's exponential capacity should be read against.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the biological counterpart with the opposite topology: a diluted recurrent attractor whose fixed points are the stored content, versus a feed-forward memory whose fixed points are the address sample; both price capacity in synapses, and the dentate's mossy-fibre randomisation is this page's address decoder in the hippocampus.
- **[[wiki/concepts/pattern-separation-completion.md]]** — separation derived rather than measured: expansion into a much wider layer plus a hard threshold makes two dissimilar cues share `p²M` of the `pM` locations they each activate, and the position on the transfer curve is one scalar (`H`) with a known optimum that *moves as the store fills*.
- **[[wiki/concepts/energy-based-models.md]]** — retrieval as relaxation with the recurrence outside the weights: feeding the read-out back as the next address gives attractor behaviour (noisy cue → prototype in 2–3 steps) from a purely feed-forward network, so "attractor" is a property of the read loop rather than of a symmetric weight matrix.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the outer-product rule with two additions a builder needs: saturating counters (bounded weights, oldest-information loss rather than runaway) and the fact that the *address* layer never learns, which is what keeps one-shot writes non-interfering.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — a supervised local rule with the teacher wired in: the climbing fibre presents the target bit at every synapse of one Purkinje cell's column, and CMAC's `g(p̂_u − s_u)/K` update is a delta rule that needs no backward pass because the error is delivered on its own axon.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the fast store's price list: one-shot writes, graded overload and a capacity of ~10% of the location count, against a slow learner that needs iterative training — the same division of labour, argued from memory engineering rather than from interference.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a complete storage-and-addressing layer with the discovery layer absent by construction, and an explicit statement of what that costs: the memory is only as good as an encoder that maps semantic similarity onto Hamming distance, which is the representation problem exported to whatever sits in front of it.
- **[[wiki/entities/dense-sequence-memory.md]]** — the same bipartite skeleton (one wide fixed layer, matrix in and matrix out) used for *transitions* rather than items: the read-out matrix names each stored pattern's successor instead of its content, which is what a pointer chain does with addresses — and the nonlinearity that page places in the hidden unit is the knob this page derives as a load-dependent sparsity schedule.
- **[[wiki/entities/context-modular-memory-network.md]]** — the same fixed-substrate/selective-access skeleton with the selector moved from the cue to an external control signal: SDM selects a subset of *locations* by Hamming distance and stores content in plastic counters, that model selects a subset of *synapses* by context — and can leave the weights random, putting the content in the selection itself.
- **[[wiki/entities/hopfield-network.md]]** — the store with the same capacity *per storage element* (Keeler 1988) reached from the opposite direction: there the pattern and the network are the same object so capacity is capped by word size, here the location count `M` is free, so capacity becomes a hardware choice.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the same overlap statistics derived for *recognition* instead of storage, and with the roles reversed: here the sparse random object is the address set and the data are dense-ish words, there it is the stored pattern itself that is a ~25-bit random subsample of the cue, which is why that page gets `10⁶` patterns discriminated with no counters and no write.
- **[[wiki/concepts/dendritic-computation.md]]** — the cerebellar mapping's neocortical counterpart: Marr's codon cells and Jaeckel's selected-coordinate design (a conjunction over `k` chosen coordinates, three orders of magnitude fewer connections than a Hamming ball) are the same object as a dendritic segment sampling `s ≈ 30` synapses, arrived at from memory engineering rather than from anatomy.
