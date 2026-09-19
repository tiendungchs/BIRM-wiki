# Associative Memory

**A store addressed by *content*: a query that is a partial, corrupted or merely similar version of a stored item returns the item. One read — `v̂ = σ(S(K, q))·V` — and four decisions that are independent of each other: the **code** items are written in, the **kernel** `S` that scores a query against an address, the **separation operator** `σ` that sharpens the score, and the **write rule** that puts an item in. Every capacity number in the wiki fixes three of the four and reports the fourth; almost none of them survive changing which population is counted.**

> **Provenance.** This is a **synthesis page**, not an ingest. It states what wave 25 (thirteen sources, `priority-ingest.md`) established across the pages that carry the individual sources — six machine stores ([[wiki/entities/dense-associative-memory.md]], [[wiki/entities/two-body-dense-associative-memory.md]], [[wiki/entities/continuous-modern-hopfield-network.md]], [[wiki/entities/neuron-astrocyte-associative-memory.md]], [[wiki/entities/three-factor-key-value-memory.md]], [[wiki/concepts/key-value-memory.md]]) and four rodent recordings read into [[wiki/concepts/attractor-dynamics.md]], [[wiki/concepts/pattern-separation-completion.md]] and [[wiki/concepts/synaptic-plasticity.md]]. No claim here is new evidence; every number is sourced on the page named beside it.

**What this page is for, against its three neighbours.** [[wiki/concepts/key-value-memory.md]] carries the address/content *split* and the `(S, σ)` taxonomy. [[wiki/concepts/attractor-dynamics.md]] carries relaxation as a *mechanism*. [[wiki/concepts/retrieval-capacity.md]] carries the query-set bound. None of them states the thing the wave is actually about: **which of the four decisions a given result is a result about**, and what happens to it when the accounting unit changes.

---

## The four decisions, and where each one's knob sits

| Decision | Knob | What the wave settled | Page |
|---|---|---|---|
| **Code** | bipolar / continuous / slot | Capacity per *visible* neuron is not capacity per synapse, and a slot store decouples item count from pattern size entirely (`N` slots are free hardware) | [[wiki/entities/three-factor-key-value-memory.md]] |
| **Kernel `S`** | dot product / Hamming ball / any PSD kernel | "A better address match" and "a feature transform on the keys" are the same move, so the rank bound on factorised scores applies to the whole family | [[wiki/concepts/retrieval-capacity.md]] |
| **Separation `σ`** | `n` (polynomial), `β` (softmax), threshold, `max` | `σ = max` is optimal and unusable; every real store is a point on a separability–robustness curve, and `n`, `β` and the pattern radius `M` are one dial seen three times | [[wiki/entities/dense-associative-memory.md]], [[wiki/entities/continuous-modern-hopfield-network.md]] |
| **Write** | Hebbian / pre-only / gated / backpropagated | The modern-Hopfield line has **no write rule at all** (patterns are supplied or backpropagated); the one wave source that supplies one recovers a *different rule on each side* of the split without being told the split exists | [[wiki/entities/three-factor-key-value-memory.md]] |

**The decisions are orthogonal and the literature conflates them.** `n` in a dense associative memory and `β` in a continuous one are both `σ`, not code choices; the astrocyte store changes only the substrate of the write and inherits `σ` from `F(z) = ¼z⁴` unchanged; sharpening `σ` is what [[wiki/concepts/pattern-separation-completion.md]] calls moving along the transfer curve, applied at the read-out with the code untouched.

---

## The elimination principle

**The wave's single most transferable result, and it is a methodological one: whenever an associative store looks architecturally exotic, the exotic object is an artefact of having eliminated a faster variable.** Four instances, three of them new in this wave:

| Apparently exotic object | What it is the trace of | Consequence |
|---|---|---|
| Degree-`n` energy `E = −Σ_μ F(ξ^μ·σ)` — an "`n`-body synapse" | Hidden neurons in a bipartite two-body network, at `τ_h → 0` | The standing biological objection to exponential capacity is dissolved, *exactly* rather than approximately ([[wiki/entities/two-body-dense-associative-memory.md]]) |
| Quartic energy `F(z) = ¼z⁴` | Ca²⁺ concentrations in the processes of **one astrocyte**, at `τ_s, τ_p → 0` | A higher-order term flags an eliminated fast variable *of any kind*, not specifically a neuron ([[wiki/entities/neuron-astrocyte-associative-memory.md]], `G105`) |
| The Hopfield matrix `T_ij = Σ_μ ξ_μi ξ_μj` | The bipartite weights `ξ_μi` folded once | "A memory smeared across every synapse" is the folded view; unfolded, one synapse holds one (memory, feature) pair and inhibiting one hidden unit deletes one item |
| A softmax attention layer | Model B of the Lagrangian framework, run one step at `dt = τ_f` | Attention is derived, with an energy, a convergence proof for iterating it, and a capacity ceiling attached ([[wiki/entities/continuous-modern-hopfield-network.md]]) |
| A gradient-trained linear layer | A key-value store whose keys are its training inputs and whose values are its own **error signals** — an identity, not an empirical claim | Every trained MLP layer in the wiki is already an associative store, and what continual training destroys is *access*, not the trace ([[wiki/concepts/key-value-memory.md]], `T392`) |

**Two things a builder must carry out of this.**

1. **"Is this biologically admissible?" is a question about the chosen frame, not about the model.** The same fixed points, the same capacity, and a different verdict, depending on which layer is integrated out.
2. **The capacity denominator is frame-dependent, and the two headline numbers of this wave do not contradict each other.** Counting neurons gives `N_mem ∼ min(N_f^{n−1}, N_h)`, i.e. total capacity **linear in the neuron count**. Counting neurons + synapses + astrocytic processes (`∼N²` units) against `K^max ∼ N³` gives memories per compute unit **growing as `N`**. Both are correct about their own unit. The honest per-parameter number is flat in both: storing `K` memories of `N` bits needs `∼KN` parameters, which is what `r = K/N` says.

---

## The capacity ledger

All rows assume i.i.d. patterns unless noted; that assumption is the standing caveat on the whole table (`T61`), and its measured failure is qualitative rather than quantitative.

| Store | Item capacity | What sets it | Overload |
|---|---|---|---|
| [[wiki/entities/hopfield-network.md]] | `≈0.14N` | pattern size = network size | **cliff** |
| [[wiki/entities/dense-associative-memory.md]] | `α_n N^{n−1}`, with `K^max_{no err} ≈ N^{n−1}/(2(2n−3)!!·ln N)` | read-out exponent `n`; **interior optimum in `n`** at fixed `N` | cliff |
| [[wiki/entities/two-body-dense-associative-memory.md]] | `min(N_f^{n−1}, N_h)` | hidden-unit count — a hidden unit *is* a memory | cliff |
| [[wiki/entities/continuous-modern-hopfield-network.md]] | `N ≥ √p·c^{(d−1)/4}` (random), `2^{2(d−1)}` (placed) | dimension `d`, with the base set by the pattern radius `M = K√(d−1)`; retrieval error `∝ exp(−βΔ_i)` | cliff; and **more modes than patterns** are possible |
| [[wiki/entities/neuron-astrocyte-associative-memory.md]] | `K^max ∼ N³` at `∼N²` compute units | `r = K/N` connections per astrocytic process — **an anatomical measurement** | not characterised |
| [[wiki/entities/three-factor-key-value-memory.md]] | `C ≈ 1.0N` (sequential gate) / `0.16N` (random gate) | slot count `N`, free of pattern size | **graded, one item at a time** |
| [[wiki/concepts/retrieval-capacity.md]] | `C(n,k) ≤ (1+1/γ)^d` *retrieval sets* | embedding dimension and score margin | — |

Four readings:

- **Capacity per connection has not moved since 1982.** The slot store is `C ≈ 0.16N` at twice the connections — Keeler's 1988 equality re-derived for a third architecture with a third write rule. What the wave bought is **overload behaviour**, not density: graded rather than catastrophic, per-item retention policy, and correlated-input tolerance (`ρ = 0.6` near-free).
- **Every bound is still design-time.** `α_n`, `β`, `M`, `d`, `N_h` are chosen before anything is stored; nothing in a running store reads its own occupancy or refuses a write. `G42` does not move.
- **The one run-time occupancy signal the wave produced is `Δ_i = x_iᵀx_i − max_{j≠i} x_iᵀx_j`** — computable from the keys alone, with no query, and the exponent every retrieval bound is stated in. Its honest cost is `O(N²)` to maintain exactly, in a store whose point is that `N` is large.
- **The one forgetting *rate*** is `−γ(t−i)` inside the `lse` — one addend in the energy, descent guarantee intact, and no schedule for `γ` anywhere.

---

## The write is the half nobody supplies

| Store | Write | One-shot? |
|---|---|---|
| Dense / two-body / continuous modern Hopfield | patterns supplied, or learned by backpropagation over thousands of epochs | **No** — the defining property of a fast store is absent from the whole modern-Hopfield line (`T62` untouched) |
| Neuron-astrocyte | four-way outer product `T_ijkl = Σ_μ ξ_iξ_jξ_kξ_l` | Nominally; a four-way coincidence is not local in any sense a synapse is |
| Three-factor key-value | `K`: **pre-only**, gated by `q_t·[γ_t]_i`; `V`: Hebbian, same gate; erase is the write's own `(1−η)` factor | **Yes**, in two ordered phases (the key must be in the slot before the value write can address it) |
| Behavioural-timescale plasticity (measured) | presynaptic eligibility trace × a plateau-broadcast instructive signal, both seconds long (`τ_ET ≈ 864 ms`, `τ_IS ≈ 543 ms`), through two saturating processes with opposite weight dependence | **Yes**, and *bidirectional* |

**The measured rule removes the postsynaptic term by experiment, not by abstraction.** Depolarising a silent cell into 4.8 Hz firing produces potentiation at every position and no depression anywhere; hyperpolarising a place cell to 0.06 Hz in-field produces full-amplitude depression anyway. Direction is set by the synapse's own current weight, not by postsynaptic activity — which is the experimental licence for the pre-only key write that meta-learning independently recovers on the machine side ([[wiki/concepts/synaptic-plasticity.md]], [[wiki/entities/three-factor-key-value-memory.md]]).

Three consequences the wave makes concrete:

- **Erase need not be a primitive.** `(1−η)⊙K` clears exactly the synapses the write then fills; forgetting costs nothing and is scheduled entirely by the allocation gate. The biological counterpart has an asymmetry the idealisation does not: `k⁺ = 2.27 ± 0.49 s⁻¹` against `k⁻ = 0.33 ± 0.11 s⁻¹`, i.e. **erase ~7× slower than write** — the wiki's first numeric forgetting rate for a fast store.
- **The write rule is self-limiting with no homeostatic operator.** `W_eq = W_max·k⁺ΔQ⁺/(k⁺ΔQ⁺ + k⁻ΔQ⁻)`; potentiation vanishes at `W_max`, depression at `0`. Every Hebbian rule in the wiki needs a separate normalisation; this one does not, and the price is a fixed point imposed rather than learned.
- **Allocation policy is worth 6× and has no mechanism on either side.** Sequential (least-recently-used) gating gives `C ≈ 1.0N`, independent stochastic gating `C ≈ 0.16N`. The machine source demonstrates no mechanism for the sequencing; the biological source finds the plateau gate *regulated by the circuit* (raised by entorhinal feedback, lowered by local inhibition) rather than Poisson, which contradicts the input-independent gate the binary idealisation depends on (`T391`).

---

## What the tissue does that no store here does

The wave's rodent half is not a set of biological illustrations of the machine half. Each row is an operation the machine stores cannot express.

| Finding | Number | What it denies the machine stores |
|---|---|---|
| **CA3 completes on a destroyed input** | dentate Std-vs-Mis coherence gone above 45°; CA3 coherent to 135°, ns at 180° | The completion basin is measured in *input-decorrelation units*, and it has a breakdown point a store could in principle report — none does ([[wiki/concepts/pattern-separation-completion.md]], `G42`) |
| **The attractor is seeded by the weakest afferent** | local-cue-dominated CA3 fields `n = 101` vs global `n = 40`; separator's own spatial information 0.6 against CA3's 0.9 | The **query channel and the content channel are separable by gain alone**. Every fast store in the wiki projects the retrieval cue from the same embedding that was written (`G39`) |
| **Allocate-vs-reuse is decided upstream, on a variable carrying no stimulus information** | identical stimuli; global remapping only in the arm that could assign different path-integrator coordinates (`r = 0.03 ± 0.11`, sigmoid slope 35.2 vs 7.4) | The landscape is not built by associating content. `G38`'s knob is not inside the store at all ([[wiki/concepts/attractor-dynamics.md]], `T394`) |
| **The read is re-decided at 8 Hz** | 1.25% mixed cycles (below a unit shuffle); 30.8% of flickers replace the whole chart between adjacent cycles, complete at onset | Every retrieval in the wiki is one settling event per query, so **nothing can revise a commitment it has already made** (`G123`) |

**Read together with the machine half, the two point the same way.** The machine result is that `σ` — the separation operator — is where completion and separation are set, at the read-out, with the code untouched. The biological result is that *which* stored state is entered is set by a low-gain indexing channel and by an allocation decision made before any cue arrives, i.e. **not by `σ` at all**. Those are compatible only if a store has two query terms with independently settable gains, and no store here has two.

**(brainstorm) The buildable test is one line and nobody has run it.** Give a modern-Hopfield or key-value read two additive query terms — a high-information content term and a low-information indexing term — with separate gains, and check whether the low-gain term can steer retrieval against the high-gain one. If it can, "what to retrieve" and "how much to trust the input" become separately addressable, which is what `G38` and `G39` both need. The corollary is a warning: a store read out by its weakest afferent reorients on noise in that afferent, which is what the 180° condition shows.

**(brainstorm) A dwell budget is the missing parameter, and it is cheaper than everything proposed for `G42`.** The tissue does not settle once; it commits per theta cycle and re-decides for seconds on unchanged input. A store that re-ran its read on a free-running clock and reported the *fraction of cycles that returned the same item* would have a per-query confidence signal computed from the store's own dynamics, with no margin to maintain and no `O(N²)` bookkeeping — the run-time occupancy read that `Δ_i` gives only at `O(N²)` and that `|s_u|` gives only per-read.

---

## Open problems

- **No store reads its own occupancy** (`G42`). Four capacity derivations in one wave, all design-time. The two candidates the wave produced are `Δ_i` (per-store, keys only, `O(N²)`) and the graded-overload slot scheme (which degrades informatively without ever reporting anything).
- **"Full" may be a property of the query, not of the store.** If forgetting is retrieval interference — the trace present, the address swamped — then occupancy is the wrong quantity and the right one is a per-query match score. The demonstration needs an oracle to pick which keys to amplify, which is exactly `G49`/`G60`'s hole.
- **The separation operator has no scheduler.** `n`, `β` and the dentate threshold are three names for one scalar that should move with load, with retrieval confidence, or with the allocate-vs-reuse call — and is exogenous in every model here (`G38`).
- **Correlated patterns break the bounds qualitatively, not quantitatively.** Every row of the capacity ledger is i.i.d.-patterns; the one measurement of the gap finds stores well inside their bound recalling nothing.
- **Spurious states survive exponential capacity.** The continuous energy is a Gaussian mixture, and a mixture with `N` components can have more than `N` modes.
- **The write and the read have never been sourced from the same paper.** The line that derives capacity supplies no write rule; the line that supplies a synapse-executable write matches the classical capacity per connection. Nothing in the wiki holds both at once (`T62`).

---

## Connections

- **[[wiki/entities/hopfield-network.md]]** — the baseline all four decisions are read against: `K = V`, dot-product kernel, `sgn` separation, one-shot Hebbian write, and every later store on this page changes exactly one of those and reports the result as a capacity theorem.
- **[[wiki/entities/dense-associative-memory.md]]** — the separation decision isolated: raising `F`'s growth exponent `n` takes `0.14N` to `α_n N^{n−1}` with the code, the state space and the write rule untouched, which is why this page treats `σ` as a decision rather than as an implementation detail — and the `f = F′` duality is the first instance of the elimination principle (a hidden unit is a stored memory).
- **[[wiki/entities/two-body-dense-associative-memory.md]]** — the elimination principle stated in its general form, with the Lagrangian recipe that makes "choose an activation" and "choose an energy" one act, and the ceiling `N_mem ≤ N_h` that fixes this page's capacity denominator for the neuron-counting frame.
- **[[wiki/entities/continuous-modern-hopfield-network.md]]** — the separation decision taken to `F = exp` and continuous states, supplying the three fixed-point regimes, the one-step retrieval condition that lets a store be a feedforward layer, the only run-time occupancy candidate on this page (`Δ_i`), the only forgetting rate (`−γ(t−i)`), and the measurement that trained attention heads sit in the regime the capacity theorem excludes (`T390`).
- **[[wiki/entities/neuron-astrocyte-associative-memory.md]]** — the elimination principle run on a non-neuronal population, which is what makes the capacity denominator a *choice of accounting unit* rather than a fact about the architecture, and which turns a capacity knob (`r`) into an anatomical measurement.
- **[[wiki/entities/three-factor-key-value-memory.md]]** — the write decision, and the only store on this page that has one a synapse could execute: pre-only keys, Hebbian values, erase folded into the write's own `(1−η)`, graded overload instead of a cliff, and the 6× allocation-policy gap (`T391`) that neither this page nor biology can mechanise.
- **[[wiki/concepts/key-value-memory.md]]** — the address/content split that makes the four decisions independent in the first place: `K = V` is a *constraint*, so every capacity number derived for an autoassociative store is a number for the constrained case, and the review supplies the identity that makes an ordinary trained linear layer an instance of this page.
- **[[wiki/concepts/retrieval-capacity.md]]** — the complementary count and the one this page's ledger cannot express: items stored versus questions askable, with the second fixed by embedding dimension and score margin before any training, so a store can be exponentially deep and still unaskable.
- **[[wiki/concepts/attractor-dynamics.md]]** — the mechanism half: what relaxation buys (search-free retrieval, completion = recognition, no certificate) and the two design axes that generate the landscape, plus the in-vivo results that decide against content-defined fixed points and put the discrete/continuous distinction inside one circuit at theta pace.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the biological name for this page's separation decision, with the two things the machine framing cannot state: the transfer curve is measured against a *recorded* input only once, and what seeds the completed state is the store's weakest afferent rather than its most informative one.
