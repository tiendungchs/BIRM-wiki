# Neuron-Astrocyte Associative Memory (Kozachkov, Slotine & Krotov 2023)

**Write the tripartite synapse as a three-layer Lagrangian network — neurons `x_i`, synapses `s_ij`, astrocyte processes `p_ij` — and integrating out the two non-neuronal layers leaves a quartic Dense Associative Memory on the neurons alone. The many-body term is again an elimination artefact, but this time the eliminated variables are not hidden *neurons*: they are calcium concentrations inside one astrocyte. The memories live in the process-to-process transport tensor `T_ijkl`, i.e. in glia, not in synaptic weights.** Kozachkov, Slotine & Krotov, *Neuron-Astrocyte Associative Memory*, arXiv 2311.08135 (MIT / MIT-IBM Watson AI Lab).

This is the wiki's **only non-neuronal storage substrate**, and the second answer to the objection that [[wiki/entities/two-body-dense-associative-memory.md]] answers with hidden neurons. It matters for `G42` because it is the first entry there whose capacity-per-compute-unit *grows* with network size.

> **Provenance.** `raw/kozachkov-2023-neuron-astrocyte-associative-memory.md` — ar5iv rendering of arXiv 2311.08135. No byline in the clip body; authors and affiliations recovered from the arXiv record. Figures 1–6 are images absent from the clip, so every number below is from the text and Appendices A–E. Code: `github.com/kozleo/naam`.

---

## The three-layer dynamics

```
τ_n ẋ_i  = −λ x_i + Σ_j g(s_ij) φ(x_j) + b_i                        (neurons, membrane currents)
τ_s ṡ_ij = −α s_ij + f(x_i, x_j, p_ij) + c_ij                       (synaptic facilitation)
τ_p ṗ_ij = −γ p_ij + Σ_kl T_ijkl ψ(p_kl) + κ(s_ij) + d_ij           (astrocyte process Ca²⁺)
```

| Symbol | Biology | Role in the architecture |
|---|---|---|
| `p_ij` | intracellular Ca²⁺ in the astrocytic process wrapping synapse `i→j` | A **per-synapse state variable held outside the synapse** |
| `T_ijkl` | Ca²⁺ (or protein-kinase-A) transport between processes `ij` and `kl` inside one astrocyte | **Where the memories are stored.** Zero entry = no physical connection, so astrocyte morphology *is* the connectivity of the store |
| `κ` | synapse → astrocyte signalling at the tripartite synapse | The write path into the glial layer |
| `g(s_ij)` | gliotransmitter-modulated synaptic efficacy (GABA, D-serine, ATP, glutamate) | The read path back out |
| `d_ij` | astrocytic "tone" | A **neuromodulatory bias**, plausibly from brainstem (norepinephrine, acetylcholine) |

Scale facts the model leans on: a single astrocyte forms `>10⁶` tripartite synapses; astrocytes tile the brain in non-overlapping islands; astrocytic responses span several hundred milliseconds to minutes; astrocytes are necessary for long-term memory formation.

---

## The energy, and what it costs

Pick three Lagrangians `L^[n](x)`, `L^[s](s)`, `L^[p](p)`; activations are their gradients (`φ_i = ∂L^[n]/∂x_i`, `g_ij = ∂L^[s]/∂s_ij`, `ψ_ij = ∂L^[p]/∂p_ij`). Legendre transforms give three layer energies; three bilinear couplings give the rest:

```
E = E^[n] + E^[s] + E^[p] + E^[ns] + E^[ps] + E^[pp]
dE/dt ≤ 0   iff all three Lagrangian Hessians are positive semi-definite
```

**The symmetry bill is larger than in the two-body page and one line of it is free.** Required: `s_ij = s_ji`, `p_ij = p_ji`, `T_ijkl = T_klij = T_jikl = T_ijlk`. The authors' own defence is that unlike Hopfield's weight symmetry — which has *no* known biological interpretation — `T_ijkl = T_klij` is just the symmetry of diffusion. The remaining index symmetries are not defended.

---

## Elimination: the astrocyte is a computational many-neuron synapse

Take `τ_s, τ_p → 0` (mathematically convenient, biologically backwards — the real ordering is `τ_n ≪ τ_s, τ_p`). Fixed points are **independent of all three time constants**, so the reduction is legitimate for locating them even though the kinetics it implies are wrong. With `α = γ = 0`, `λ = 1`:

```
ψ_ij = −φ_i φ_j ,   g_ij = Σ_kl T_ijkl φ_k φ_l
⇒  τ_n ẋ_i = −x_i + Σ_jkl T_ijkl φ_j φ_k φ_l
⇒  E^eff = [Σ_i x_i φ_i − L^[n]] − ¼ Σ_ijkl T_ijkl φ_i φ_j φ_k φ_l
```

Three firing-rate functions on the right-hand side where a conventional rate model has one; four in the energy where a Hopfield net has two. **The computational function of the astrocyte is to bring the state of distant synapses to each tripartite synapse, producing an effective four-neuron synapse between neurons that may be far apart.** Setting `T_ijkl = Σ_μ ξ^μ_i ξ^μ_j ξ^μ_k ξ^μ_l` makes `E^eff = [Σx_iφ_i − L^[n]] − Σ_μ F(ξ^μ·φ)` with `F(z) = ¼z⁴` — exactly [[wiki/entities/dense-associative-memory.md]] at `n = 4`.

---

## Capacity: supralinear per compute unit, and the denominator that buys it

| Quantity | Value |
|---|---|
| Compute units (authors' conservative count) | `N` neurons + `N²` synapses + `N²` processes `∼ N²` |
| Storage capacity (quartic DAM, quoted from Krotov & Hopfield 2016) | `K^max ∼ N³` |
| **Memories per compute unit** | `∼ N` — **grows linearly with network size** |
| Same metric for the hidden-neuron implementation ([[wiki/entities/two-body-dense-associative-memory.md]]) | `constant`, independent of `N` |

**This is the sharpest claim in the paper and it does not contradict the `N_mem ≤ N_h` ceiling — it changes the denominator.** Krotov & Hopfield 2021 count *neurons* and conclude total capacity is linear in the neuron count; this paper counts neurons + synapses + processes and finds capacity superlinear in that count. Both are right about their own accounting unit. The honest per-*parameter* number is in the paper's own connectivity argument and it is flat: storing `K` memories of `N` bits needs `∼KN` parameters, the astrocyte supplies `rN²` where `r` is connections per process, hence

```
r = K/N
```

So `r = const` (isolated processes, no intra-astrocyte transport) buys only `K = N`; supralinear storage requires process-to-process connectivity to grow, up to `r = N²` for all-to-all. **`r` is an experimentally measurable anatomical quantity that reads out directly as a capacity number** — the rarest property in `G42`, where nearly every bound is a design-time constant. Whether intra-astrocyte communication is that detailed is stated as an open experimental question.

---

## Attention, derived a second way — and the normaliser is conserved calcium

Set `T_ijkl = 1` (pure diffusion, no stored memories) in the general equations, with a global read/write scalar `r ∈ {0,1}` the authors attribute to a neuromodulator (acetylcholine):

| Stage | Result | Why it works |
|---|---|---|
| Astrocyte | `p_ij → p* = (1/NM) Σ p_ij(0)` exponentially at rate `NM/τ_p` | Total calcium `z = Σ p_ij` is **conserved** under diffusion; `L = ½(p_ij−p_kl)²` decays as `e^{−2NMt/τ_p}` |
| Synapse | `s*_ij = c_ij/p*` | `τ_s ṡ_ij = −p_ij s_ij + c_ij`, i.e. the astrocyte sets the synapse's **decay rate**, not its target |
| Neuron (write, `r=0`) | `x*_i = v_i`, and `Δc_ij = x_i I_j/M` | Plain Hebbian write between two neuron groups |
| Neuron (read, `r=1`) | `x*_i = Σ_j c_ij I_j / p*` | Divides a Hebbian sum by a global calcium average |

With `c_ij = (1/M) Σ_β V_βi K̃_βj` and `p_ij(0) = Q̃_μj Σ_σ K̃_σj`, this fixed point equals the feature-map approximation of self-attention `A_μi` (Performer-style `φ(x)ᵀφ(y) ≈ exp(xᵀy)`).

**What this adds that [[wiki/entities/two-body-dense-associative-memory.md]]'s model B does not.** There, softmax attention comes from choosing `L_h = log Σ e^{h_μ}` — the normaliser is a *choice of Lagrangian*. Here the numerator is a Hebbian outer-product fast weight `c_ij` and the denominator is **the conserved total calcium in one astrocyte, reached by diffusion**. Attention's normalisation is therefore realisable as a conservation law over a physically diffusing quantity, on a substrate distinct from the neurons doing the association — which is a different answer to "where does the softmax denominator come from" than any other page in the wiki gives. Note also that this route yields *linear* attention (`d_dot`-bounded, see [[wiki/concepts/fast-weight-programming.md]]), not softmax attention, so it inherits the random-feature noise floor rather than the exponential-separation bound.

---

## Experiments

| Experiment | Setup | Result |
|---|---|---|
| Energy-based, Hebbian write | CIFAR-10 encoded by a custom autoencoder into a **binary** 768-d latent (straight-through sign activation), `K = 25` memories written by the quartic outer product | Converges to the correct neural attractor; energy monotonically decreasing along all four shown retrievals |
| BPTT, no symmetry | Tiny ImageNet 64×64, 15 random 10×10 masked patches (≈40% of pixels), random init, Backpropagation-Through-Time on least-squares reconstruction, batch 64 | Masked regions inpainted; RMS distance to ground truth falls with network time |

The second experiment is the load-bearing one: **strong symmetry is sufficient but not necessary** for associative-memory function, which matters because exact symmetry on noisy biological hardware is not available. The energy-based model can also be trained by recurrent backpropagation / implicit differentiation at the fixed point.

---

## The falsifiable prediction

**Selectively block intracellular Ca²⁺ diffusion within astrocytes → memory recall should be significantly impaired**, while leaving synaptic transmission intact. This is the wiki's cleanest test of a storage-substrate claim: it targets `T_ijkl` (the store) without touching `g(s_ij)` (the read-out). Not run in the paper.

---

## What this contributes to the wiki

| Claim | Why it matters |
|---|---|
| **Memory need not live in synaptic weights** | Every store in the wiki puts the content in a weight between two neurons. Here weights *emerge* from neuron–astrocyte interaction and the content sits in a glial transport tensor — a whole class of substrate the wiki had no page for |
| **A many-body term can be the trace of eliminated *non-neuronal* variables** | [[wiki/entities/two-body-dense-associative-memory.md]] showed `n`-body ⇒ hidden neurons. The general lesson is stronger: a higher-order interaction is the generic signature of *any* eliminated fast variable, including one that is not a cell (`G105`) |
| **Capacity per compute unit is not a fixed property of dense associative memory** | It depends on which population is counted, and `r = K/N` turns the question into an anatomy measurement |
| **A capacity knob that is an anatomical measurement** | `r` (connections per astrocyte process) is in principle countable in tissue and converts directly to `K` — unlike `β`, `n`, `d`, or the address-space size |
| **A third derivation of attention, with a physical normaliser** | Conserved calcium under diffusion supplies the denominator; a Hebbian synaptic bias supplies the numerator; a global neuromodulatory scalar supplies the read/write switch |
| **A three-timescale architecture whose fixed points are timescale-free** | Neurons (ms) / synapses (s) / astrocytes (s–min) descend one energy; where the minima sit does not depend on the ratios, only the trajectories do |

**(brainstorm) The read/write scalar `r` is the wiki's cheapest encoding–retrieval switch, and it is one global number.** [[wiki/concepts/encoding-retrieval-alternation.md]] carries theta-phase alternation as a biological schedule with no machine counterpart that is not a hand-written control flow. Here `r ∈ {0,1}` multiplies one term in the neuron equation and swaps the input population between `k̃` and `q̃`; the same layer is a writer or a reader depending on a scalar a neuromodulator could set. That is a one-parameter interface for "am I storing or recalling", attached to an architecture that provably converges in both modes, and nothing in the wiki has tried making it continuous (`r ∈ [0,1]` = simultaneous partial write and partial read).

**(brainstorm) The store's connectivity is a morphology, which makes it growable.** `T_ijkl`'s non-zero pattern is where astrocytic processes physically touch. Astrocyte morphology is activity-dependent and remodels on hours-to-days. So this architecture has a natural reading in which **capacity itself is plastic on a third, slower timescale** — a store that grows its own address space by extending processes, rather than one that discovers it is full. Nothing here models that; the paper writes `T` once by an outer product. It is the closest thing in `G42` to an answer to "what does a store do when full" that is neither eviction nor graded degradation.

---

## Limitations

| Limit | Consequence |
|---|---|
| **The write rule is a four-way outer product** | `T_ijkl = Σ_μ ξ_i ξ_j ξ_k ξ_l` requires a *four-way* coincidence to be detected at one process. Called "Hebbian-like"; it is not local in any sense a synapse is, and the paper offers it "for transparency of the theoretical argument" rather than as biology (`T62` untouched) |
| **All-to-all process connectivity for the headline number** | `r = N²` is assumed for the supralinear claim; whether intra-astrocyte transport is that detailed is unknown and flagged as such |
| **Capacity is quoted, not derived or measured** | `K^max ∼ N³` is imported from Krotov & Hopfield 2016 with its i.i.d.-pattern assumption intact (`T61`); no capacity experiment is run — the energy-based demo stores `K = 25` at `N = 768`, ~5 orders of magnitude below the quoted bound |
| **Still a design-time number** | Nothing reads its own occupancy, refuses a write, or reports a margin. `G42` does not move off `PARTIAL` |
| **Symmetry bill** | Four index symmetries on `T` plus symmetric `s` and `p`; only `T_ijkl = T_klij` is given a biological justification. BPTT experiment shows symmetry is not *needed*, but then there is no energy and no guarantee |
| **`α = γ = 0` in the reduction** | The elimination that produces the quartic DAM sets both leak terms to zero "for simplicity"; the effect of non-zero leak on the effective theory is not worked out |
| **The attention result uses `T_ijkl = 1`** | I.e. the memory-storage tensor is switched off entirely. The associative-memory model and the attention model are two disjoint parameter settings of the same equations, not one system doing both |
| **Inter-astrocyte coupling is excluded** | Gap junctions between astrocytes are named and deferred to future work; everything here is a single-astrocyte mini-circuit |
| **No biological data** | Astrocyte biology enters as motivation for the equation forms; nothing is fit to or compared against a recording |

---

## Connections

- **[[wiki/entities/two-body-dense-associative-memory.md]]** — the same objection answered with a different eliminated population: there the `n`-body term is what hidden *neurons* leave behind and capacity is capped at `N_h`, here it is what astrocytic processes and synapses leave behind and capacity per compute unit grows as `N` — the two disagree only about the denominator, and both use the identical Lagrangian-gradient-is-activation machinery.
- **[[wiki/entities/dense-associative-memory.md]]** — the effective theory this page reduces to: `T_ijkl = Σ_μ ξ_iξ_jξ_kξ_l` gives `F(z) = ¼z⁴`, i.e. the `n = 4` member of that page's family, so the quartic capacity `α_4 N³` and the `(2n−3)!!` interior optimum in `n` both apply verbatim to a neuron-astrocyte circuit.
- **[[wiki/concepts/energy-based-models.md]]** — extends the Lagrangian recipe from two layers to three, with the new layer being a non-neuronal chemical concentration: any set of coupled variables whose activations are gradients of convex potentials descends a Legendre-transform energy, so "how many layers" and "what the layers are made of" are both free.
- **[[wiki/concepts/higher-order-interactions.md]]** — generalises the elimination argument beyond neurons: a quartic interaction among firing rates is what a diffusing chemical between synapses looks like after the chemistry is integrated out, so a higher-order term flags *an eliminated fast variable of any kind*, while the realisable class stays sums of rank-one terms (`G105`).
- **[[wiki/concepts/attention.md]]** — a third derivation of the attention read, in which the softmax denominator is a **conservation law**: total astrocytic Ca²⁺ is invariant under diffusion, the processes synchronise exponentially to its mean, and dividing the Hebbian numerator by that mean reproduces the feature-map approximation of self-attention — plus a global read/write scalar attributed to acetylcholine.
- **[[wiki/concepts/fast-weight-programming.md]]** — names what `c_ij` is: an outer-product fast weight written Hebbianly during the write phase and read linearly during the read phase, so this circuit is a linear-attention store and inherits the `d_dot` orthogonal-key capacity bound and the random-feature noise floor rather than the exponential-separation bound.
- **[[wiki/concepts/dendritic-computation.md]]** — the sibling proposal the paper names in its own discussion: both relocate computation off the point neuron into sub-cellular structure, but a dendritic segment adds *nonlinear fan-in to one cell* while an astrocytic process adds *lateral transport between synapses of different cells*, which is why only the latter produces a many-neuron effective synapse.
- **[[wiki/concepts/encoding-retrieval-alternation.md]]** — supplies a one-scalar machine implementation of the alternation: `r ∈ {0,1}` swaps the input population and one term of the neuron equation, converging in both modes, against a concept page whose biological schedule has no machine counterpart that is not hand-written control flow.
- **[[wiki/concepts/attractor-dynamics.md]]** — a discrete-attractor store whose fixed-point locations are provably independent of all three time constants, so the kinetics (ms neurons, second-to-minute glia) and the memory landscape are separately designable.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the substrate claim stated against it: the synapse here has no persistent state of its own (`s_ij` relaxes to `c_ij/p*` on the fast timescale), and what is durable sits in the astrocytic transport tensor — so "the engram is in the weights" is the position this page contradicts ([[wiki/empirical-tensions.md]] `T59`, where this is the third position beside weights and masks-over-weights).
- **[[wiki/concepts/associative-memory.md]]** — the page that reconciles this one's supralinear claim with the `N_mem ≤ N_h` ceiling by making the accounting unit explicit: both are correct about their own denominator, the per-parameter number (`r = K/N`) is flat in both, and this page's quartic term is the elimination principle's sharpest instance because the eliminated variable is not a cell.
