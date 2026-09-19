# Two-Body Dense Associative Memory (Krotov & Hopfield 2021)

**Split the store into `N_f` feature neurons and `N_h` hidden "memory" neurons wired as a bipartite graph with symmetric two-body synapses `ξ_μi`, give each layer a Lagrangian whose gradient *is* its activation function, and the resulting two-timescale dynamical system has a Lyapunov energy whose feature-space minima sit exactly where a Dense Associative Memory's do. The `n`-body synapse that made exponential capacity biologically inadmissible was never a synapse — it is what appears when the hidden neurons are integrated out.** Krotov & Hopfield, *Large Associative Memory Problem in Neurobiology and Machine Learning*, ICLR 2021 (arXiv 2008.06996).

This is the page [[wiki/entities/dense-associative-memory.md]] and [[wiki/entities/dense-sequence-memory.md]] both forward-reference as "the fix — hidden neurons and two-body interactions only — is Krotov & Hopfield 2021". It also supplies the derivation that makes a transformer attention layer one update of an energy-descending recurrent network, from general principles rather than by the heuristic route.

> **Provenance.** `raw/krotov-2020-large-associative-memory-problem-neurobiology-and-machine-learning.md` — ar5iv rendering of arXiv 2008.06996. No byline in the clip; authors and venue recovered from the arXiv record. Figures 1 and 2 are images absent from the clip; every equation below is from the text and Appendices A–B. **No experiments: the paper is theory plus four worked examples of problems that need the capacity.**

---

## The information-counting argument that sets up the whole paper

| Step | Statement |
|---|---|
| Features only | `N_f` feature neurons admit at most `N_f²` synapses |
| Synapse capacity | A cortical synapse is unreliable and holds a few bits |
| Cost of one memory | ≈ `N_f` bits |
| Conclusion | A store written *only* in feature–feature synapses holds `∼N_f` memories; the Hopfield bound `0.14 N_f` is this counting argument made exact |

**So exponential capacity is not a free lunch and the paper says so in the discussion:** the modern-Hopfield gain comes from *unfolding* the effective theory — adding hidden neurons and therefore adding synapses — while each synapse keeps the same information capacity as before. `N_f^{n−1}` is a statement about patterns **per visible neuron**, never per synapse.

---

## The construction

```
τ_f dv_i/dt = Σ_μ ξ_iμ f_μ − v_i + I_i          (feature neurons, currents v_i, input I_i)
τ_h dh_μ/dt = Σ_i ξ_μi g_i − h_μ                (hidden / "memory" neurons, currents h_μ)
```

| Object | Statement | Why it is the load-bearing choice |
|---|---|---|
| Connectivity | Bipartite: **no** feature–feature and **no** hidden–hidden synapses; `ξ_μi = ξ_iμ` | Restricted-Boltzmann-Machine skeleton ([[wiki/entities/boltzmann-machine.md]]), but deterministic and energy-descending rather than sampled |
| Synapse semantics | `ξ_μi` **is the memory pattern itself**, not the outer product `T_ij = Σ_μ ξ_μi ξ_μj` | One synapse per (memory, feature) pair. The classical reading — a memory smeared across an `N×N` matrix — is the *integrated-out* artefact |
| Outputs | `f_μ = ∂L_h/∂h_μ`, `g_i = ∂L_v/∂v_i` for Lagrangians `L_h({h}), L_v({v})` | Activation functions are **derivatives of a potential**, so choosing an activation and choosing an energy are one act. Non-additive `L` gives layer-wide activations (softmax, divisive normalisation) for free |
| Energy | `E = [Σ_i (v_i − I_i) g_i − L_v] + [Σ_μ h_μ f_μ − L_h] − Σ_{μ,i} f_μ ξ_μi g_i` | Two Legendre transforms plus **one manifestly two-body interaction term**. No `T_ijk` anywhere |
| Descent | `dE/dt = −τ_f Σ (dv/dt)ᵀ ∂²L_v (dv/dt) − τ_h Σ (dh/dt)ᵀ ∂²L_h (dh/dt) ≤ 0` | Holds for **arbitrary** `τ_f, τ_h` provided both Hessians are positive semi-definite; in the additive case that reduces to "activation functions are monotonically increasing" |
| Boundedness | Needs a bounded `g` (tanh, sigmoid) separately | Descent alone does not give convergence; this is the second condition |

**Author's own definition of "biologically plausible" is narrow and stated: absence of many-body synapses, nothing more.** The symmetry `ξ_μi = ξ_iμ` binds two physically distinct synapses and is flagged as implausible; it can be dropped from the dynamics at the cost of losing the energy function.

---

## The three limits — one framework, four known models

All three take `τ_h → 0`, so the hidden layer equilibrates instantly at `h_μ = Σ_i ξ_μi g_i` and can be eliminated.

| Model | `L_h` | `L_v` | Effective theory on the feature neurons | Recovers |
|---|---|---|---|---|
| **A** | `Σ_μ F(h_μ)` | `Σ_i \|v_i\|` ⇒ `g_i = Sign[v_i] = σ_i` | `E = −Σ_i I_i σ_i − Σ_μ F(Σ_i ξ_μi σ_i)` | [[wiki/entities/dense-associative-memory.md]] exactly (at `I = 0`); `F(x)=x^n` gives `N_f^{n−1}`, `F = exp` gives exponential capacity (Demircigil et al. 2017); `n = 2` gives [[wiki/entities/hopfield-network.md]] |
| **A′** (Appendix B) | `½ Σ_μ h_μ²` ⇒ `f_μ = h_μ` | `Σ_i ∫^{v_i} g(x)dx` | `τ_f dv_i/dt = Σ_j T_ij g_j − v_i + I_i` with `T_ij = Σ_μ ξ_μi ξ_μj` | Hopfield 1984 continuous graded-response network — the third energy term is a Legendre transform, equal up to a constant to the textbook `∫^{g_i} g⁻¹(z)dz` |
| **B** | `log Σ_μ e^{h_μ}` ⇒ `f_μ = softmax(h_μ)` | `½ Σ_i v_i²` ⇒ `g_i = v_i` | `E = ½Σ_i v_i² − log Σ_μ exp(Σ_i ξ_μi v_i)`; `v^{(t+1)} = Σ_μ ξ_iμ softmax(Σ_j ξ_μj v_j^{(t)})` at `dt = τ_f` | Ramsauer et al. 2020 ("Hopfield Networks is All You Need") — and **one application of that update is dot-product attention** (Bahdanau et al. 2014; Vaswani et al. 2017) |
| **C** (Spherical Memory, new) | `Σ_μ F(h_μ)` | `√(Σ_i v_i²)` ⇒ `g_i = v_i/‖v‖` | `E = −Σ_μ F(Σ_i ξ_μi v_i/‖v‖)` | Nothing — proposed here. `g` is **divisive normalisation** (Carandini & Heeger 2012), the canonical neural computation |

Two structural facts hiding in the table:

- **Zero modes are where the freedom is.** Model B's hidden Hessian has a zero eigenvalue (softmax is shift-invariant); model C's feature Hessian has a zero mode along `v_i` itself, which is why the decay term can be written `−α v_i` for **arbitrary `α`, including zero**. A network with no leak still descends an energy.
- **The derivation of attention is cleaner than the published one.** Ramsauer et al. arrive at the softmax energy by taking `F = exp`, then taking `−log` of the energy and adding a quadratic term to keep it bounded — two heuristic steps. Here both fall out of one choice of Lagrangian, which also keeps the link to Dense Associative Memory explicit.

---

## Capacity, with the ceiling this paper adds

```
N_mem ∼ min( N_f^{n−1} , N_h )
```

The `N_f^{n−1}` bound assumes **no limit on the hidden count**. In every model of this class the capacity is *also* capped by `N_h`, because a hidden neuron is a stored memory ([[wiki/entities/dense-associative-memory.md]]'s duality read backwards). So:

| Reading | Consequence for a builder |
|---|---|
| Total capacity is **linear in the total neuron count** | The exponential claim is always relative to a chosen feature dimension; it never beats a per-neuron count |
| The regime where the gain is real is `N_h ≫ N_f^{n−1}` | i.e. **low-dimensional feature space, many memories** — which is exactly the shape of all four examples below |
| Capacity is still a **design-time** number | Nothing in the running store reads its occupancy, refuses a write, or reports a margin (`G42` unmoved) |

---

## The four large-associative-memory problems

The paper's argument for why `O(N_f)` stores are the wrong object, by example:

| System | `N_f` | Memories required | Gap |
|---|---|---|---|
| 64×64 greyscale patterns | 4096 | Kuzushiji-Kanji alone has 3832 classes (140k characters); a literate Japanese reader recognises 3000–5000, plus digits, emoji, … | Classical bound `0.14·4096 ≈ 573` |
| Immune-repertoire classification (Widrich et al. 2020) | 32 (sequence embedding `d_k`) | `≫ 10⁴` repertoire sequences | Three orders of magnitude |
| Human colour vision | **3** (cone types) | ~10⁶ discriminable colours, many named | The starkest case: capacity must be unbounded in `N_f` or the system is inexplicable |
| Cortico-hippocampal system | — | — | See below |

**The hippocampal mapping, offered as a hypothesis and hedged.** Two readings of which cells are which:

| Reading | Feature neurons | Memory (hidden) neurons | Support cited |
|---|---|---|---|
| Within CA3 | Some CA3 pyramidal cells | The remaining CA3 pyramidal cells — **place cells as memory neurons**, since a place field is an aggregation of grid-cell and environmental-feature input | CA3 recurrent collaterals ≈3×10⁵ pyramidal cells in rat, 2.3×10⁶ in human, with inhibitory rate control; "silent cells" that no place-cell protocol drives are the unaccounted population |
| EC ↔ CA1 | Entorhinal cortex **layer III** | CA1 pyramidal cells | CA1 receives direct EC input alongside CA3 input and projects back, mainly to layer V but also to layers II/III |

The hedge is explicit and matters for the wiki: the hippocampus also imagines futures (Hassabis et al. 2007), so the retrieval motif cannot presently be separated from the rest of the circuitry. The colour example carries the same caveat in its strongest form — colour memories live in higher areas, so "direct associative memory" there is only correct *after* integrating out every intervening neuron, which is the same unfolding operation the paper is about.

---

## What this contributes to the wiki

| Claim | Why it matters |
|---|---|
| **A many-body energy is an artefact of elimination, not a commitment** | The wiki's standing objection to Dense Associative Memory — "a degree-`n` energy is an `n`-body synapse, biologically inadmissible" — is dissolved. Any effective `n`-body term of the rank-one-sum form `Σ_μ F(ξ^μ·σ)` **is** a bipartite two-body network plus hidden units, and the conversion is exact, not approximate (`G105`) |
| **Activation function ⇄ Lagrangian ⇄ energy, as a design procedure** | [[wiki/entities/dense-associative-memory.md]] gives `f = F′` for additive, per-unit activations. This generalises it to *layer-wide* activations: softmax and divisive normalisation are gradients of non-additive Lagrangians, so normalisation layers are energy terms and inherit the descent guarantee |
| **Attention derived as the fast-hidden limit of a recurrent energy net** | A transformer attention layer is model B at `τ_h → 0`, run for one step at `dt = τ_f`. The wiki already carries "attention ≈ modern Hopfield retrieval" second-hand ([[wiki/entities/tem-transformer.md]]); this is the derivation, from a stated energy, with a convergence proof for the iterated version |
| **Convergence for arbitrary time constants** | `dE/dt ≤ 0` needs only positive semi-definite Hessians — not `τ_h → 0`. So the *finite*-`τ_h` network is a legitimate, convergent architecture that is none of the known models |
| **Spherical Memory (model C)** | An untried associative store whose read-out nonlinearity is the canonical divisive normalisation, with a zero mode that permits a leak-free feature layer |
| **The capacity ceiling `N_mem ≤ N_h`** | Names the price of every exponential-capacity claim in the wiki in one symbol |

**(brainstorm) `τ_h/τ_f` is an unexplored architectural dial, and every model in the table is its degenerate end.** All four reductions assume the hidden layer equilibrates instantly. At finite `τ_h` the hidden units have their own state and the network is a two-timescale recurrent system that still provably descends an energy — i.e. *an attention layer whose keys and values have inertia*, in which a read is influenced by what the layer was reading a moment ago. That is a one-line change to the softmax-attention update (`h ← h + (dt/τ_h)(ξ v − h)` instead of `h = ξ v`) with a free Lyapunov argument attached, and nothing in the wiki has tried it. It is also the natural place for [[wiki/concepts/working-memory.md]]'s persistence to live in a transformer: the hidden currents *are* a short-horizon state.

**(brainstorm) The mapping suggests where to look for the hidden layer in any trained network: the units nothing decodes.** The paper's CA3 reading needs a population of pyramidal cells that place-cell protocols fail to drive — the "silent cells" — to be the memory neurons. The machine analogue is direct: in a trained network the hidden units that no probe decodes to a task variable are candidate *memory* units, not dead units, and the test is whether inhibiting one removes exactly one stored item. [[wiki/entities/dense-sequence-memory.md]] already shows that gating a hidden unit deletes exactly one transition, so the intervention exists; it has never been run as a diagnostic on a network trained for something else ([[wiki/concepts/representation-probing.md]]).

---

## Limitations

| Limit | Consequence |
|---|---|
| **No experiments at all** | Theory and four motivating examples. Nothing is trained, no capacity is measured, no hippocampal prediction is tested |
| **No learning rule** | `ξ_μi` is assumed given. The paper explicitly leaves write rules to the RBM literature it borrows the skeleton from, so the one-shot-write question (`T62`) is untouched |
| **Symmetry `ξ_μi = ξ_iμ`** | Two physically different synapses forced equal — the paper's own named residual implausibility. Relaxing it destroys the energy function and hence every guarantee here |
| **All model reductions need `τ_h → 0`** | The general theory is convergent at any `τ_h`, but nothing is known about what it computes there |
| **"Biologically plausible" is defined as one property** | Absence of many-body synapses. Says nothing about locality of the write, sign constraints, spiking, or the fact that `ξ` can be negative |
| **The hippocampal mapping is a suggestion, not a model** | Which CA3 cells are features and which are memories is unconstrained by any measurement; the paper says the retrieval circuitry cannot currently be separated from the rest |
| **Capacity claims are inherited, not re-derived** | `N_f^{n−1}` and the exponential case are quoted from Krotov & Hopfield 2016 and Demircigil et al. 2017, with all of their i.i.d.-pattern assumptions intact ([[wiki/empirical-tensions.md]] T61) |
| **Model C is stated and dropped** | No capacity, no dynamics analysis, no simulation — only its energy and its zero mode |

---

## Connections

- **[[wiki/entities/dense-associative-memory.md]]** — the model this page makes admissible: the same feature-space minima and the same `N_f^{n−1}` capacity, reached as the `τ_h → 0`, `L_v = Σ|v_i|` limit of a bipartite network, so the `n`-body synapse that page is charged with is what appears when this page's hidden neurons are eliminated; it also adds the ceiling `N_mem ≤ N_h` that page's bound assumes away.
- **[[wiki/entities/hopfield-network.md]]** — recovered twice over: `n = 2` in model A gives the binary network, and Appendix B derives the 1984 continuous graded-response network as model A with `L_h = ½Σh²`, with `T_ij = Σ_μ ξ_μi ξ_μj` emerging as the integrated-out form of the bipartite weights rather than as the primitive.
- **[[wiki/entities/dense-sequence-memory.md]]** — the asymmetric continuation: it adapts this page's bipartite reformulation to sequences by using two weight matrices instead of a matrix and its transpose, which buys per-transition gating but gives up the symmetry this page's energy function requires.
- **[[wiki/entities/boltzmann-machine.md]]** — the same bipartite visible/hidden skeleton with the stochastic sampling removed: states are deterministic currents descending a Lyapunov function instead of visiting states at rate `exp(−E/T)`, and the activations may be layer-wide (softmax, divisive normalisation) rather than per-unit sigmoids.
- **[[wiki/concepts/energy-based-models.md]]** — a constructive recipe for the formalism's central object: pick two Lagrangians, take their gradients as activation functions, and the Legendre transforms plus one bilinear coupling term give an energy that provably decreases — so "design the energy" and "choose the nonlinearity" are one decision.
- **[[wiki/concepts/attention.md]]** — attention derived rather than analogised: softmax attention is one update of this page's model B at `τ_h → 0` and `dt = τ_f`, which attaches an energy function, a convergence proof for the iterated read, and the capacity ceiling `N_mem ≤ N_h` to an attention layer.
- **[[wiki/concepts/higher-order-interactions.md]]** — the constructive half of the complaint: an `n`-body interaction of the rank-one-sum form is *exactly* a two-body bipartite network with hidden units, so higher-order structure is realisable in pairwise hardware — while the restriction to sums of rank-one terms is unchanged, so arbitrary hyperedges stay out of reach (`G105`).
- **[[wiki/concepts/attractor-dynamics.md]]** — a discrete-attractor store whose fixed points are guaranteed by two Hessian conditions instead of by weight symmetry among the state units, and whose feature-space minima are unchanged by adding the hidden layer that carries the capacity.
- **[[wiki/concepts/pattern-separation-completion.md]]** — supplies the anatomical reading this page's hippocampal mapping depends on: CA3 as the completing recurrent store, here re-partitioned into feature cells and memory cells (with place cells proposed as the latter, since a place field aggregates grid and sensory input).
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the rival reading of the same tissue: there CA3 is one recurrent population whose capacity is set by fan-in `p_max ≈ kC/(a ln(1/a))`, here it is a bipartite feature/memory pair whose capacity is set by the hidden count — the two disagree about what a CA3 pyramidal cell is, and the numbers this page quotes for CA3 cell counts come from the same anatomy.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the biological control port this architecture exposes: inhibiting one hidden memory neuron removes exactly one stored item, which is a per-memory switch that a folded `T_ij` store cannot offer at any price.
- **[[wiki/entities/continuous-modern-hopfield-network.md]]** — model B of this page's table, published independently and one year earlier: the same energy and the same softmax update, reached by the two heuristic steps this page replaces with a Lagrangian choice. What it supplies that this page does not is everything downstream of the energy — the capacity theorem `N ≥ √p c^{(d−1)/4}`, one-step retrieval at error `∝ exp(−βΔ_i)`, the three fixed-point regimes selected by `β`, and the only experiments either paper has (Ramsauer et al. 2020).
- **[[wiki/entities/neuron-astrocyte-associative-memory.md]]** — the same elimination argument run on a non-neuronal population: there the quartic term is what astrocytic Ca²⁺ processes and synapses leave behind rather than what hidden neurons leave behind, which moves the capacity denominator from neurons to neurons+synapses+processes and turns this page's `N_mem ∼ min(N_f^{n−1}, N_h)` ceiling from "capacity is linear in the neuron count" into "memories per compute unit grow as `N`" — the two are consistent, they count different units (Kozachkov, Slotine & Krotov 2023).
