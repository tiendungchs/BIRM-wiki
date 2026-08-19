# Context-Modular Memory Network

**Keep one weight matrix and one population, and let an external discrete *context* signal impose a binary mask on it — silencing neurons (rows and columns) and/or synapses (individual entries). Each context is then a different effective connectivity, a different energy landscape, and a different set of stable attractors: the memories of the active context are recallable and every other stored memory is *hidden*. Capacity rises (≈7× the Hopfield limit for random neuronal gating at 100 contexts, ≈30–40× for optimised synaptic masks) and, more importantly, memory *accessibility* becomes a controllable variable rather than a constant.** Podlaski, Agnes & Vogels 2025, *Physical Review X* 15, 011057.

The wiki's first associative memory in which **retrieval is a precondition imposed from outside rather than a search driven by a cue**, and its first source to treat *hiding* a memory as a design objective on equal footing with storing one.

> **Provenance.** `raw/podlaski-2025-gated-associative-memory-capacity.md` — *High Capacity and Dynamic Accessibility in Associative Memory Networks with Context-Dependent Neuronal and Synaptic Gating*, Phys. Rev. X 15, 011057 (2025).

---

## The model

`N` binary neurons, `s` discrete contexts, exactly one context `k` active at a time. `p` patterns stored per context, `P = s·p` total, patterns i.i.d. Rademacher (`Pr(ξ = ±1) = ½`).

| Object | Definition |
|---|---|
| Update | `S_i^(k) = sgn( a_i^k Σ_j a_j^k c_ij^k J_ij S_j^(k) )`, with `sgn(0) = 0` |
| Energy | `H^(k) = −Σ_ij a_i^k a_j^k c_ij^k J_ij S_i S_j` — one landscape per context |
| **Neuronal gate** `a_i^k ∈ {0,1}` | Removes whole rows *and* columns. Gated neurons go to `0`, not to `−1` (equivalent to inactivation in a `{0,1}` formulation) |
| **Synaptic gate** `c_ij^k ∈ {0,1}` | Removes individual entries; symmetric (`c_ij = c_ji`) for tractability |
| Allocation fraction | `a = N_cxt/N` (neurons live per context); `c = K/N_cxt` (connection density) |
| Gating ratios | neuronal `1−a`, synaptic `1−c` (the latter is classical *dilution*) |
| Single-context load | `α_cxt = p/N_cxt` |
| Total load | `α = P/N = α_cxt · s · a` |
| Accessibility | stability parameter `κ = ξ_i · (Σ_j a_j^k c_ij^k J_ij ξ_j)/‖J_i^k‖`, averaged separately over accessible (`σ = k`) and inaccessible (`σ ≠ k`) patterns. `κ̄` estimates basin size |
| Information | `I* = a·α*·f_m(m*)`, `f_m(m) = 1 + ½(1+m)log₂(1+m) + ½(1−m)log₂(1−m)` — capacity *discounted by recall fidelity* |

Standard Hopfield is `s = 1`, `a = c = 1`. Analysis is mean-field: the gated matrix is rewritten as an ungated Hopfield matrix plus a Gaussian noise term of variance `Δ₀²α_cxt/(aN)`, so every result is the classic Amit–Gutfreund–Sompolinsky calculation evaluated at an inflated noise `1 + Δ₀²`.

**The structural claim in one line:** a fully connected network with a per-context inhibitory mask `a_i a_j c_ij` is an *effectively modular* network whose module boundaries can be redrawn on demand at no synaptic cost.

---

## Two ways to set the mask

| | **Random allocation** | **Synaptic refinement** |
|---|---|---|
| When the mask is fixed | At *learning* time — gates decide which synapses store which context, and the same gates must be reinstated at recall | After learning, at *recall* time only — the weight matrix is untouched |
| Rule | `a_i^σ, c_ij^σ` drawn i.i.d. Bernoulli(`a`), Bernoulli(`c`) | `c_ij^σ = 1` iff `sgn(J_ij) = sgn(J_ij^(σ))`, where `J^(σ)` is the *isolated* weight matrix that context `σ`'s patterns alone would have produced. Gate off any synapse whose sign disagrees with the correlation structure of the memories you want stable |
| Free parameter | `c` is chosen | `1−c` is *derived*, not chosen |
| Biological reading | Engram allocation by excitability at encoding + contextual reinstatement at recall | Ongoing post-encoding plasticity / inhibitory masking; each recall event can rewrite the mask |

Refinement is one signed comparison per synapse and needs no gradient — but it needs `J^(σ)`, i.e. knowledge of which patterns belong to the target context.

---

## Results

### Random gating — neuronal beats synaptic, and information does not follow capacity

| Quantity | Random **neuronal** gating (`c = 1`) | Random **synaptic** gating (`a = 1`) |
|---|---|---|
| Single-context capacity `α*_cxt` | Falls with `s`, but the fall becomes *gradual* at high gating | Falls with `s` and falls further with gating; → ~0 quickly as `s` grows |
| Total capacity `α*` | Up to **≈ an order of magnitude** above Hopfield at `s = 100` (paper's headline: ≈7×) | Increases, but **much less effectively** |
| Optimal gating ratio | `1 − a_opt ≈ 1 − (√(2s−1) − 1)/(s−1)` — more contexts ⇒ gate more neurons. Same optimum for capacity and for information | `1 − c_opt ≈ 1 − √(1/s)` for capacity; **saturates at ½** for information |
| Information per synapse `I*` | Generally **lower** than standard Hopfield (patterns are smaller); modest gains only in narrow parameter ranges | **Lower** than Hopfield, for a different reason: overlap `m*` collapses at capacity |
| Shared contexts per synapse at optimum | `s·a² ≈ 1 + (1−a)²`, i.e. **1–2** | `s·c ≈ 1/c`, **>10** at `s = 100` |

Two numbers worth carrying: at optimal random neuronal gating the sharing distribution is `B(s, a²)`, so **>50% of synapses still serve 2–5 contexts** — the capacity gain is *not* the trivial one of giving each context its own private synapses (which yields nothing) — while **~20% of synapses serve no context at all**, so random allocation is provably suboptimal and a smarter allocation rule exists but is not built.

### Accessibility separates, but only under heavy gating

`κ̄_acc` rises and `κ̄_inacc` falls as either gating ratio rises; the ratio `κ̄_acc/κ̄_inacc` is the control quantity. Under light gating the two are indistinguishable — **there is no cheap regime in which memories are merely "backgrounded"**; hiding a memory costs the same masking that buys the capacity.

### Synaptic refinement — the strong result

| Result | Value |
|---|---|
| Derived gating ratio | `1 − c → ½` as `s → ∞` (and approached fast). Once the weight matrix carries enough cross-context noise, exactly half the entries have the sign the active context wants — **so the number of contexts can grow indefinitely without changing the fraction of usable synapses** |
| Effective noise | `1 + Δ₀² = ([1 + a²(s−1)]π²c + πa√(s−1)) / (πc + a√(s−1))²` → `π²/2` in the `a²s → ∞` limit |
| Limiting capacity | `α*_cxt → α*_Δ(π²/2)`, `m* → m*_Δ(π²/2)` — a *finite floor*, not a decay to zero |
| Total capacity / information | Grow **roughly linearly in `s`**; `α* ≈ 5` at `s = 100`, i.e. ~30–40× the Hopfield `0.14` |
| Optimal neuronal gating | `a_opt = 1` — **adding neuronal gating on top of refinement helps nothing**. The two mechanisms are not complementary |
| Accessibility | `κ̄_acc = √(2/(π²α_rand))`, `κ̄_inacc = 0` in the limit — inaccessible memories are not merely weakened, they are *not attractors at all* |

### The result that reframes where memory lives

Set `J_ij = η_ij`, a symmetric Gaussian random matrix containing **no information about any pattern**. Apply refinement. Arbitrary chosen patterns become stable attractors, with exactly the same `m*_rand`, `α*_rand`, `κ̄_acc`, `κ̄_inacc` as the infinite-context limit above.

Consequences the paper draws:
- Memory content can reside **entirely in the gating mask**; the weight matrix needs only "minimal structure" (zero-mean, randomly distributed).
- Synaptic weights may be **corrupted substantially** with no loss, as long as the mask survives.
- **Bounded / binary synapses become sufficient** for reliable recall — the long-standing biological objection to Hebbian capacity arguments.
- Because refinement acts only at recall, the **same memory can be made accessible in several contexts**, and context membership can be reassigned after storage: start from an unstructured pool of `P` patterns stored without contexts, then carve arbitrary subsets into contexts by choosing masks (works while `α*_cxt` stays below the load-dependent ceiling).

---

## What it contributes

| Claim | Why it matters here |
|---|---|
| **Accessibility is a separate axis from capacity, and it is the one worth optimising** | Every store in the wiki reports how much it holds. This reports how much it can *withhold*, and shows the two trade off: the accessible fraction falls as `1/s` exactly as total capacity rises. The authors state the capacity gain is a side effect, not the point |
| **Retrieval as a mask, not as a search** | G37's three existing answers (geometric containment, responsibility posterior, attractor relaxation) all *compute* which structure applies from the cue. Here the answer is supplied externally and acts by deleting the competition from the dynamics — `O(1)` in library size, with no comparison step and no certificate |
| **A memory can be stored in a binary mask over a random substrate** | Separates *what is remembered* from *what the weights are*. Every other store in the wiki puts the content in the plastic matrix ([[wiki/empirical-tensions.md]] T59) |
| **A concrete, local, sign-based gating rule** | `c_ij = 1 iff sgn(J_ij) = sgn(J_ij^(σ))` — one bit per synapse per context, no gradient, no rate constant. The cheapest write rule in the wiki that is not Hebbian |
| **Capacity conditioned on a control signal** | All capacity numbers here are *conditional on an externally imposed context*, which the authors flag as making comparison with classical bounds invalid. The wiki should read the 30–40× as "per context, given the context", not as free storage |
| **Neuronal gating levels match measured engram sparsity** | Optimal `1−a` for tens-to-hundreds of contexts corresponds to ~20–30% active neurons, the range observed for excitability-based memory allocation in amygdala and hippocampus — and silencing allocated neurons is known to impair recall, matching random neuronal gating applied at both encoding and retrieval |

**(brainstorm) A context is a subgraph selector, and this is the cheapest multigraph store the wiki holds.** [[wiki/concepts/latent-graph-discovery.md]] needs many graphs over one substrate with edges shared between them. That is exactly `a_i^k a_j^k c_ij^k`: one fixed edge set, one binary mask per graph, edges reused across masks (>50% of synapses serve 2–5 contexts), and switching graphs costs no plasticity. The random-matrix result says the substrate need not even be learned — a fixed random reservoir plus a learned mask per environment is a complete architecture, and the learned object per environment is `N²` bits rather than `N²` reals. What is missing is the addressing: contexts here are named by fiat, so nothing indexes the mask library by content.

**(brainstorm) Refinement is a discriminative correction to a generative store, run at read time.** Hebbian writing is generative — it accumulates whatever arrives. The refinement mask is fitted afterwards to *one* target subset and asks a discriminative question per synapse: does this weight help the patterns I want stable? Splitting the two lets a system write indiscriminately and cheaply, then pay separately, per context, for a clean read. That is the same slow-write/fast-select division [[wiki/concepts/complementary-learning-systems.md]] draws between systems, drawn instead between *two operations on the same synapse* — and it predicts that recall practice should sharpen a mask without changing a weight, which is a testable dissociation.

**(brainstorm) The 20% dead synapses are a free capacity multiplier nobody has claimed.** Random allocation leaves ~20% of synapses in no context and gives >50% to 2–5 contexts. An allocation rule that equalises participation (the authors' own suggested future work) would raise capacity with no change to the mechanism. A balanced combinatorial design over contexts — each synapse in exactly `⌈s·a²⌉` contexts — is a one-line substitute for i.i.d. Bernoulli sampling.

---

## Comparison — how the wiki's stores select what is retrievable

| | Context-modular | [[wiki/entities/vector-hash.md]] | [[wiki/entities/sparse-distributed-memory.md]] | [[wiki/entities/stp-flickering-cann.md]] | [[wiki/entities/dense-sequence-memory.md]] |
|---|---|---|---|---|---|
| Selection mechanism | External binary mask on neurons/synapses | Address-space separation (random init per map) | Hamming-ball around the cue | Attractor competition, `input × gain` | Nonlinearity `f` sharpening overlap |
| Selection cost in library size | `O(1)` — the mask is applied, not searched | `O(1)` | `O(1)` | `O(1)` | `O(P)` per step |
| Can it *hide* a memory? | **Yes, provably (`κ̄_inacc → 0`)** | No — everything stays retrievable | No | Transiently, via recency | No |
| Where the content lives | Mask (weights may be random) | Plastic matrix over fixed addresses | Plastic counters over fixed addresses | Plastic matrix | Plastic matrix + read-out shape |
| Capacity gain over Hopfield | ≈7× (random neuronal), ≈30–40× (refinement), *conditional on context* | Exponential in address space | `τ ≈ 0.10·M`, size-independent | — | Polynomial/exponential in `N` (sequences) |
| Overload behaviour | Not characterised past `α*` | Graded (resolution falls) | Graded (cross-talk) | — | Cliff |
| Interference control | Mask removes other contexts from the dynamics | Orthogonal addresses | Sparse activation | Global inhibition | Steep `f` |
| Who supplies the selector | **Nobody — imposed externally** | The environment (random init) | The cue | The cue + history | The cue |

The last row is the shared limitation and the reason this model does not close G37: it prices what a context signal *buys* without saying where it comes from.

---

## Limitations

| Limit | Consequence |
|---|---|
| **Context is exogenous throughout** | Every capacity, stability and information number is conditional on an externally imposed `k`. There is no context-encoding network, no inference, no cue→context mapping |
| **And pricing the context network kills the strong result** | The authors' own estimate: a Hopfield-like context encoder is cheap for *neuronal* gating (scales with `s`), but synaptic gating requires neurons whose activity controls other neurons' *weights*, scaling as `s·N` — a context network orders of magnitude larger than the memory network, dropping total capacity **below the Hopfield limit after a few contexts**. Refinement, the mechanism carrying the 30–40× headline, is the one that does not pay for itself |
| **Per-synapse gating is biologically implausible** | The authors concede this; the defensible version is dendritic-branch-level gating (dendrite-targeting interneurons, dendritic clustering, localised inhibition and neuromodulation). Relaxing gating precision is stated as future work and not done |
| **Refinement needs the isolated per-context weight matrix `J^(σ)`** | The rule is local in form but requires knowing which patterns belong to the context — i.e. the grouping is given, exactly the operation a memory system would need to discover |
| **Random uncorrelated patterns only** | The wiki already holds a demonstration that i.i.d.-pattern capacity bounds can fail *qualitatively* on correlated data ([[wiki/entities/dense-sequence-memory.md]]). Nothing here is tested on structured patterns |
| **Information per synapse is often *worse* than Hopfield under random gating** | The capacity headline hides a fidelity cost: gained patterns are smaller (neuronal gating) or recalled at low overlap (synaptic gating). Only refinement raises information content |
| Symmetric connectivity and symmetric masks | Assumed throughout for tractability; asymmetric weights (the sequence case) need different analysis |
| Binary units, no dynamics | No spiking, no rates, no timing; the neuronal-gating/engram comparison is made across this gap |
| Nothing is ever forgotten or evicted | Contexts accumulate; there is no rate, schedule, or capacity-triggered eviction |
| No basin-size or convergence analysis | `κ̄` is a proxy for basin size, not a measurement; convergence from perturbed states is not studied |

---

## Connections

- **[[wiki/concepts/energy-based-models.md]]** — one weight matrix carrying a *family* of energy functions indexed by a discrete control variable: `H^(k) = −Σ a_i^k a_j^k c_ij^k J_ij S_i S_j`, so the landscape is reshaped by masking rather than by relearning, and the minima that vanish under one mask are exactly the memories the system wants hidden.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the computational payoff for the dendrite-targeting inhibitory channels that page catalogues: an inhibitory mask applied per context is not sparsification or gain control but *selective deletion of stored attractors*, and the paper's own concession — per-synapse gating is implausible, per-dendritic-branch gating is not — sets the resolution at which that page's channels would have to act.
- **[[wiki/concepts/contextual-inference.md]]** — the mechanism half of the same operation with the inference removed: there a responsibility posterior decides which stored structure is live and expresses a *mixture*; here the context is imposed and acts by *deleting* the alternatives from the dynamics, which is winner-take-all by construction — and this page prices what that costs (`1/s` of memories accessible at any moment) while that page supplies the missing selector.
- **[[wiki/entities/coin-model.md]]** — the two halves that would compose into a full system: COIN computes `p(context)` from cues and feedback but stores one scalar per context; this stores a full attractor set per context but takes the context as given, so its `s` discrete masks are the substrate COIN's context library lacks.
- **[[wiki/concepts/continual-learning.md]]** — a fifth interference solution alongside importance-gating, replay, code separation and address-space separation: **mask separation**. Contexts share both neurons and synapses (>50% of synapses serve 2–5 contexts) yet do not interfere, because interference is removed at recall rather than prevented at write — so unlike orthogonal-address schemes it does not forbid transfer between tasks, and unlike Fisher-based protection it needs no importance estimate.
- **[[wiki/entities/sparse-distributed-memory.md]]** — the same fixed-substrate/selective-access skeleton with the selector moved: SDM selects a *subset of locations* by Hamming distance from the cue and stores content in plastic counters; this selects a *subset of synapses* by an external context and can store the content in the selection itself, with the weights left random.
- **[[wiki/entities/dense-sequence-memory.md]]** — the adjacent per-edge gating result: there, silencing one hidden memory neuron deletes one stored *transition*; here, a context mask deletes a whole *set of states* from the landscape — edge-level versus subgraph-level control over the same kind of store, and neither supplies the signal that drives the gate.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the biological capacity theory this one modifies rather than replaces: capacity is still bought by reducing effective activity, but here the reduction is imposed per context and reversible (`p_max ≈ kC/(a ln(1/a))` with `a` set by anatomy versus `a` set by a control signal), and the optimal gating level it derives coincides with the ~20–30% engram sparsity that model treats as fixed.
- **[[wiki/entities/stp-flickering-cann.md]]** — the same "which of several stored maps is expressed" question answered without a controller: there, gain competition plus short-term plasticity makes expression history-dependent and transiently wrong; here, a mask makes it exact and externally dictated — the two bracket the spectrum from self-organised to imposed attractor selection.
- **[[wiki/concepts/pattern-separation-completion.md]]** — separation moved out of both the code and the read-out into the *connectivity*: patterns from other contexts are not orthogonalised or suppressed, they are removed from the energy function, so the separation/completion bias (G38) becomes a mask density rather than a sparsity or a threshold, and the accessible/inaccessible stability ratio `κ̄_acc/κ̄_inacc` is a direct read-out of where the network sits on that axis.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the strongest challenge in the wiki to weights-as-memory: a Gaussian random matrix plus the right binary mask stores arbitrary chosen patterns as stable attractors, so learning could reside in a per-context sign-agreement gate rather than in weight change, and bounded or binary synapses become sufficient ([[wiki/empirical-tensions.md]] T59).
- **[[wiki/concepts/complementary-learning-systems.md]]** — the same fast/slow split relocated inside a single synapse: the Hebbian weight is the slow, indiscriminate, generative write and the context mask is the fast, discriminative, reversible select — which is why recall practice could sharpen a memory here without any weight changing.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a multigraph store with the discovery layer absent: one fixed edge set, one binary mask per graph, edges shared between graphs, switching graphs free — exactly the substrate the framing needs for a library of environment structures, and exactly missing the two operations that make it a library (which mask applies now, and where new masks come from).
- **[[wiki/concepts/working-memory.md]]** — the context signal is a control variable that changes what is retrievable without holding any content, which is the storage/control separation that page argues for, implemented at the connectivity rather than at the buffer: the controller's state is `s` bits and its effect is a whole landscape.
- **[[wiki/entities/fcann.md]]** — the rival way to buy capacity in one weight matrix: orthogonalise the stored states (the free-energy learning rule drives attractors toward the eigenvectors of `J`, giving Kanter–Sompolinsky capacity with no gate at all) instead of masking the couplings per context — no control signal to supply, but also no accessibility knob.
- **[[wiki/entities/hopfield-network.md]]** — the unmasked baseline: this page keeps its weight matrix and update rule unchanged and multiplies by a binary context mask, turning one fixed landscape into one landscape per context and making accessibility a variable the classical network has no notion of.

- **[[wiki/concepts/memory-allocation-excitability.md]]** — the biological counterpart of this page's per-context mask: which cells are available to store the next memory is set by a decaying CREB-dependent excitability scalar rather than by a chosen mask density `c`, so the mask is inherited from *when* the previous memory was encoded instead of being a free parameter.
