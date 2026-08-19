# Spiking Tolman–Eichenbaum Machine (Spiking TEM)

**The same generative/inference factorisation as [[wiki/entities/tolman-eichenbaum-machine.md]], rebuilt out of leaky integrate-and-fire neurons, binary spike latents, spike-timing-dependent plasticity and an 8 Hz theta rhythm — so that the model produces not only *what* the code represents but *when* each cell fires.**

Kawahara & Fujisawa 2025 (bioRxiv 2025.10.16.682754; code at `github.com/kdaisuke0203/spikingTEM`). This is the wiki's only case where a computational-level architecture it already holds has been re-derived at Marr's implementation level, so it is the sharpest available test of [[wiki/empirical-tensions.md]] T1 — does the substrate carry computational content, or is it detail?

**The answer this paper gives is unambiguous: substrate mechanisms are load-bearing.** Grid cells collapse from 59.6% to 0.0% without a learnable neuromodulatory gain, to 10.1% without STDP, to 25.6% without theta-phase inhibition. None of these terms exists in the rate-based TEM, and none is expressible in its computational-level specification.

---

## Architecture

| Component | Specification | Difference from rate TEM |
|---|---|---|
| **Unit** | Leaky integrate-and-fire: `τ_m dV/dt = −(V − V_rest) + I(t)`, spike + reset at `V_th` | TEM units are real-valued rates |
| **Input gain** | `I(t) = G · Σ_j w_ij s_j(t) + I_θ(t)`, with `G` a **learnable neuromodulatory factor** (dopamine/acetylcholine analogue, init 1.0) applied to the MECII and MECIII output layers | New — no analogue in TEM |
| **Oscillatory inhibition** | `I_θ(t) ∝ −α_θ(sin 2πf_θ t + 1)`, `f_θ = 8 Hz`, sign-constrained negative throughout the cycle (septal GABAergic + interneuron analogue) | New |
| **Latents `g`, `p`** | Binary spike vectors, sampled by **autoregressive Bernoulli spike sampling**: `kC` candidate neurons in `k` groups of `C`, one drawn per group, equivalent to Bernoulli with `p_c` = mean of the `k` candidates | TEM samples Gaussian continuous latents |
| **Memory `M`** | STDP on the synapses binding `p_gen,t` to `p_CA1,t`: `Δw(Δt)` with amplitudes `A_±`, constants `τ_±`, `Δt = t_post − t_pre` | TEM writes a Hebbian outer product; here the write rule is *timing*-dependent, so it needs the spikes to be ordered |
| **Anatomy** | LECII, LECIII, MECII, MECIII, MECV, DG, CA3 (recurrent), CA1 as separate populations wired per rodent anatomy | TEM has one `g` module and one `p` module |
| **Credit assignment** | Surrogate gradient (smooth approximation to `∂H(v−v_θ)/∂v`, spread `γ`) + BPTT, alongside the local STDP write | TEM: plain BPTT |

**The anatomical unrolling is where the new predictions come from.** TEM's single `g` becomes two populations with different jobs: **MECII** carries the current structural state, **MECIII** is trained to predict MECII *one step ahead*. CA1 integrates CA3 and LECIII; CA3 recurrently combines DG, MECII and LECII with its own previous state; DG receives MECII and LECII. Splitting `g` into a present and a one-step-ahead copy is what buys the predictive-grid and the phase-precession results below — a rate model has nowhere to put the difference.

**The conjunction was removed.** TEM's load-bearing line is `p_CA1,t = f(g_t ⊙ x_LEC,t)`. In the spiking model that elementwise product **produced place cells but no grid cells at all**, and was dropped. See [[wiki/empirical-tensions.md]] T42 — this is a direct architectural contradiction with the model this one is a re-implementation of.

---

## Results

Setup: 8 × 8 arena, five actions (up/down/left/right/stay), 10,000 episodes of unsupervised random exploration, one-hot sensory vectors randomly assigned to positions and **randomly reassigned before evaluation**, so the test inputs are novel. No reward, no context input, no spatial target anywhere in the loss.

| Result | Number | Reading |
|---|---|---|
| **Grid cells emerge in MECII** | 59.6% ± 18.0 with gridness > 0.8, from ~0% at initialisation, rising monotonically with training iterations | A periodic `g` from next-observation prediction alone, in a spiking net |
| **Place cells in CA1** | Localised fields, but spatial information **does not change with training** | The place code is not learned here — it is a consequence of theta-gated sparsity plus the grid input (below) |
| **Theta inhibition creates the place code** | With `I_θ` removed at initialisation, CA1 spatial information collapses | Place fields in this model are an *oscillatory* phenomenon before they are a learned one |
| **Realignment vs remapping reproduced** | Switching one-hot → two-hot sensory codes: MECII keeps gridness (regression `p = 1.3×10⁻⁵`, `2.6×10⁻¹⁸`, two seeds) with phase/orientation shifts; CA1 fields relocate | The `g`/`x` dissociation survives the spiking rewrite ([[wiki/entities/hidden-state-inference-remapping.md]]) |
| **Predictive grid cells in MECIII** | Gridness computed at the *current* position is low; computed at the position one step ahead it rises significantly (`p = 3.0×10⁻⁶`) | A cell whose tuning is only visible in the future — matches reported MECIII predictive coding |
| **Phase precession and phase locking** | On a 40-position linear track: MECII grid cells mostly **precess** (80.2% ± 19.3), MECIII grid cells mostly **phase-lock** (86.7% ± 11.5), matching recordings | Two temporal codes in one circuit, from one training objective |
| **The two temporal codes have separable causes** | `G` on + MECIII `I_θ` off → *all* cells precess. `G` off + MECIII `I_θ` on → *all* cells lock. Both on → the recorded mixture | Neuromodulation advances spikes; oscillatory inhibition pins them. A dial, not an emergent accident |
| **Sparsity matches biology unforced** | 50.3% of hippocampal units silent (in vivo ≈60%); 90.0% of DG units silent (in vivo 163/190 = 85.8%) | Sparsity was imposed as a loss term but its *value* was not tuned to these numbers |
| **Learned weights are predominantly inhibitory** | MECII→MECIII transition matrices for all five actions come out net-inhibitory from Glorot-uniform (signed) init, two seeds; MECIII→CA1 is mostly inhibitory with a sparse excitatory subset | Matches the experimental finding that grid circuits are largely inhibitory; the sparse excitatory subset is what localises a place field |

### The ablation table — an emergence audit that was actually run

Proportion of MECII grid cells, four runs per condition:

| Condition | Grid cells | Consequence |
|---|---|---|
| Baseline (all mechanisms) | **59.6% ± 18.0** | — |
| No neuromodulation `G` | **0.00% ± 0.00** | Total abolition. A learnable input gain is not a detail |
| No hippocampal sparsity term | **0.875% ± 1.75** | Sparse `p` is what structures MECII→DG input |
| Mean-squared-error loss instead of the ELBO | **0.250% ± 0.353** | The objective's *form*, not just its content, is load-bearing (G30) |
| No STDP | **10.1% ± 16.6** | Grid formation requires associative memory to already work |
| No theta inhibition `I_θ` | **25.6% ± 20.6** | Acts *through* sparsity: removing `I_θ` reduces CA1 spatial information and firing sparsity, which degrades the MECII pattern |
| No CA1→MECV→MECII feedback | 43.4% ± 17.5 (`p = 0.244`, n.s.) | The one anatomical loop that turns out **not** to matter |

This is the wiki's first source that reports its own conditions-under-which-it-emerges table in the form [[wiki/concepts/objective-identifiability.md]] demands. It satisfies audit item 1 partially (mechanism ablations across four seeds, not an architecture/optimizer sweep) and — crucially — item 2 fully: the training target is a one-hot categorical over randomly-reassigned sensory identities, so there is no readout correlation matrix with a centre–surround shape for the Schaeffer et al. mechanism to exploit. It fails items 3, 5 and 6 (no heterogeneous-readout test, no toroidal population analysis, no filtered-noise control).

### The sensory-ambiguity result

Varying the number of sensory neurons against 64 arena positions, holding everything else fixed:

| Sensory neurons | Grid cells |
|---|---|
| Few (≪ 20) | Low |
| **≈ 20** | **Peak** |
| 64 (one-to-one with positions) and above | Falls sharply |

**The claim: a periodic internal code is a compensation for sensory aliasing, and it is switched off when aliasing goes away.** When observations uniquely identify position, `g` is redundant and does not form; when they are wholly uninformative there is nothing to anchor it. Grid coding is the interior of that range.

**(brainstorm)** This is the most useful single number in the paper for this wiki, because it converts hardness source 3 of [[wiki/concepts/latent-graph-discovery.md]] from a problem the architecture solves into a *quantity that determines whether a structural code appears at all*. Two consequences worth testing: (i) a curriculum lever — to make a learner build a `g`, deliberately alias the observations rather than enrich them, which is the opposite of standard practice; (ii) an explanation of why structural codes are hard to elicit in richly-observed machine domains — with an informative enough observation, the cheapest solution really is to have no meta-graph, and no objective will select one ([[wiki/concepts/shortcut-learning.md]]). It also predicts that entorhinal gridness in an animal should *decline* under an artificially unambiguous sensory environment, which is a recordable experiment.

---

## Limitations

| Limit | Consequence |
|---|---|
| **Grids are square/diamond, not hexagonal** | The canonical 6-fold symmetry never appeared. The paper's own diagnosis: non-negativity constraints on the entorhinal→hippocampal weights are what produce the 4-fold→6-fold transition elsewhere, and they were not imposed. Consistent with [[wiki/concepts/path-integration.md]] |
| **No grid-phase diversity → no torus** | Because spatial offsets of the grid pattern do not vary across cells, the population never forms the toroidal manifold observed in recordings. This is audit item 5 failing: the *relational* population invariant, which is the one first-principles models actually predicted, is absent |
| **Grid scale is not controlled** | Larger-scale grids appeared in 1 run of 20, gesturing at the dorsoventral scale gradient. What sets the scale is unknown |
| **Place cells do not learn** | Spatial information is flat across training. This model derives place fields from theta gating plus grid input, not from the binding operation TEM makes central |
| **Time is coarse-grained** | Simulated at an enlarged time step to keep BPTT tractable, so the temporal-coding results are qualitative in their timing values |
| **BPTT + surrogate gradients** | Global, non-local, and offline over the sequence — the biological-plausibility argument stops at the neuron model and does not reach the learning rule ([[wiki/concepts/biologically-plausible-credit-assignment.md]]) |
| **Replay absent** | The paper names one-shot replay-based BPTT alternatives and continuous-attractor replay as the obvious next step ([[wiki/concepts/offline-replay.md]]) |
| **Spatial only** | None of TEM's non-spatial results (transitive inference, social hierarchies, lap cells) were attempted, so whether the spiking rewrite preserves the *abstract* generalisation — the reason this wiki cares about TEM — is untested |

**Hardness-source coverage** ([[wiki/concepts/latent-graph-discovery.md]]): source 1 ✓ (inherited) · source 3 ✓ and *quantified* (the ambiguity curve) · sources 2, 4, 5, 6 ✗.

---

## Comparison

| | TEM (rate) | TEM-t (transformer) | Spiking TEM |
|---|---|---|---|
| Latent `g` | Gaussian continuous | Recurrent position encoding | Binary spike vector, Bernoulli-sampled |
| Memory write | Hebbian outer product | Key/value cache | STDP, timing-dependent |
| Place cell | `g̃ ⊙ x̃` conjunction | Memory index neuron | **Neither** — the product was removed; fields come from grid input filtered by theta-gated sparsity |
| Grid cells | Multiple modules, band cells | Grid and band cells | Single scale, square/diamond, 59.6% of units |
| Temporal code | None | None | Phase precession and phase locking, dissociated by two named mechanisms |
| Predictive code | Implicit in the generative step | Implicit | **Explicit population** (MECIII), measurable as future-position gridness |
| Non-spatial tasks | Transitive inference, hierarchies, lap cells | Yes | Untested |
| What it buys | The factorisation | Scaling and additive conjunction cost | Timing as an observable, and an ablation table |

---

## Connections

- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the architecture this page reimplements at the implementation level, and the source of its one substantive contradiction: the `g̃ ⊙ x̃` conjunction that page treats as load-bearing had to be *deleted* here or no grid cells formed (T42), which means the conjunction is either not required for the entorhinal code or not realisable in binary spikes.
- **[[wiki/entities/spiking-neural-networks.md]]** — the substrate page's strongest positive result: a full cognitive-map architecture trained in spikes, with an ablation table showing that three substrate-only mechanisms (theta inhibition, STDP, neuromodulatory gain) are each necessary for a representation the rate model gets without any of them.
- **[[wiki/concepts/synaptic-plasticity.md]]** — STDP used not as a plasticity demonstration but as the *memory write of a generative model*, and shown to be necessary: removing it drops grid emergence to 10.1%, so the structural code cannot form until the associative store works.
- **[[wiki/concepts/offline-replay.md]]** — supplies the theta cycle this model runs on, and receives back the mechanistic dissociation that page lacked: precession and locking are produced by neuromodulatory gain and oscillatory inhibition respectively, and either can be dialled to 100% of cells.
- **[[wiki/concepts/path-integration.md]]** — the update rule realised in spikes, plus a new determinant of whether it is built at all: grid coding peaks at intermediate sensory ambiguity and vanishes when observations uniquely identify state.
- **[[wiki/concepts/latent-graph-discovery.md]]** — turns hardness source 3 (aliasing) into a control variable: the amount of observation ambiguity sets whether a structural code emerges, so aliasing is the *cause* of the meta-graph rather than only an obstacle it overcomes.
- **[[wiki/concepts/objective-identifiability.md]]** — the first source in the wiki to run the audit rather than be subjected to it: mechanism-by-mechanism ablations over four seeds, and a one-hot categorical target with no centre–surround structure for the readout-correlation mechanism to exploit — while still failing the heterogeneous-readout, toroidal-invariant and filtered-noise items.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — an explicit predictive population (MECIII predicts MECII one step ahead) whose tuning is only measurable against the *future* state, which is what a prediction-carrying layer should look like in recordings.
- **[[wiki/concepts/pattern-separation-completion.md]]** — reproduces the sparsity side quantitatively without fitting it: 90% silent dentate units against 85.8% in vivo, and the sparsity term is what makes the entorhinal code form at all.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — the realignment/remapping dissociation reproduced in a spiking substrate under a pure sensory-recode manipulation, so any hidden-state account must also explain why the two populations respond to the same context change in structurally different ways.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — the model's honest boundary: biology reaches the neuron and the write rule, while the weights are still set by surrogate-gradient BPTT, which the paper names as the outstanding problem.
- **[[wiki/entities/mm-tem-hippoformer.md]]** — the other 2025–26 rewrite of the same architecture, moving the opposite way (fast-weight MLPs and pixel input rather than leaky integrate-and-fire units and STDP), and disagreeing about the conjunction: this page must *delete* `g̃ ⊙ x̃` to obtain a grid code, while that model never forms an explicit conjunction at all — it concatenates `g` and `x` and lets a meta-learned MLP discover the binding under auxiliary bidirectional-retrieval losses.
