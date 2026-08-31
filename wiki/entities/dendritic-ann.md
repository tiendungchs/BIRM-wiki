# Dendritic ANN (dANN)

**A standard two-hidden-layer feedforward network with two boolean masks applied to it: the first hidden layer's units ("dendrites") each see only 16 of the input pixels, and each second-layer unit ("soma") reads only its own private, disjoint set of dendrites. Nothing else changes — same optimiser, same activation, same loss — and the result matches or beats the fully connected network on six image benchmarks with 1–3 orders of magnitude fewer trainable parameters, with no overfitting at any size tested.**

The interest here is not the accuracy. It is that the *only* thing imported from biology is a **connectivity graph** — no dendritic nonlinearity, no local learning rule, no plateau potential, no multiplicative interaction — and that graph alone acts as a stronger regulariser than dropout, early stopping or learning-rate tuning, and flips the network's internal coding strategy from class-specific to mixed-selective.

> **Provenance.** `raw/chavlis-2025-dendritic-anns.md` — Chavlis & Poirazi, *Dendrites endow artificial neural networks with accurate, robust and parameter-efficient learning*, Nature Communications, 2025. Image classification only (MNIST, FMNIST, KMNIST, EMNIST-balanced, CIFAR-10); no reasoning task, no sequence task beyond class-blocked presentation.

---

## Architecture

| Layer | Units | Connectivity | Biological reading |
|---|---|---|---|
| Input | 784 (or 3072) | — | Visual scene |
| **Dendritic** | many | Each unit reads **16** input pixels; mask `M₁` | A dendritic branch with a restricted receptive field |
| **Somatic** | fewer | Each unit reads only *its own* dendrites — a disjoint tree partition; mask `M₂` | Cable weights from branches to soma |
| Output | #classes | Fully connected | — |

Implementation is three lines on top of an ordinary network:

| Step | Equation |
|---|---|
| Mask the weights at init | `W_k ← W_k ⊙ M_k` |
| Forward | `A_k = f(W_k X_k + b_k)`, `f` = LeakyReLU(0.1) |
| Mask the gradients each step | `∂L/∂ϑ ← ∂L/∂ϑ ⊙ M_k` |

The masks are **handcrafted before training and never change** — no pruning, no evolutionary search, no sparsity regulariser. Adam, lr `1e-3`, batch 128, cross-entropy.

### The four input-sampling regimes (the second dendritic feature)

| Code | Rule | Result |
|---|---|---|
| **LRF** | Each *dendrite* picks a random centre pixel; its 16 inputs are the 4×4 neighbourhood. Dendrites of one soma need not be near each other | **Best everywhere** — accuracy, loss, noise, sequential |
| **GRF** | Each *soma* picks a centre; its dendrites' centres are drawn around it | Second |
| **R** | 16 pixels drawn at random from the whole image | Third — still far better than dense |
| **F** (pdANN) | Dendrites fully connected to the input; tree structure kept | Reduced overfitting, **no efficiency gain** — parameter count explodes |

The LRF/GRF distinction is the model's one non-obvious biological claim: dendrites of a single cell sample **feature-clustered but spatially scattered** input, not a single contiguous patch — which is why dANN-LRF is *not* a convolution and not a locally-connected net (no weight sharing, receptive-field centres are drawn per dendrite from a uniform distribution).

---

## Results

| Finding | Number |
|---|---|
| Parameters to match the best vanilla net (vANN) | **1–3 orders of magnitude fewer**; ≥1 order on FMNIST |
| Overfitting | vANN test loss rises with model size; **dANN and pdANN do not overfit at any size tested** |
| vs. regularised vANN | Dropout, LR tuning and early stopping reduce vANN overfitting but by *less* than the architecture does |
| vs. sparse random nets (sANN) | dANN-LRF/GRF win on efficiency; gap **narrows for large models** and for sampling-matched sANNs |
| Noise (Gaussian, increasing σ on FMNIST) | dANN accuracy and loss efficiency degrade **more slowly**; LRF best |
| Class-blocked sequential input (50 epochs, gradients from one class at a time) | dANNs more accurate, **less variable across seeds**, far more efficient |
| Depth | Performance improves or stays stable as layers are added — unlike other bio-inspired architectures |
| Hardest dataset (CIFAR-10) | Largest gap in both parameters and accuracy — **the advantage grows with task difficulty** |

### The mechanism the authors identify: a different learning strategy

| Quantity | vANN | dANN |
|---|---|---|
| Layer-1 weight distribution | Gaussian, centred at 0 — many weights near zero, i.e. unused | Broader range |
| Layer-2 (cable) weights | Gaussian at 0 | **Bimodal**, few near zero — every parameter carries load |
| Node entropy over classes | Low — **class-specific** units | High — **mixed-selective** units in *both* hidden layers |
| Selectivity index (# classes a node fires for) | Mostly 1 | Mostly many |
| Separability across layers (silhouette, neighbourhood score) | Increases layer 1 → 2 | Increases layer 1 → 2, **from a lower start** |

So the dANN reaches the same terminal separability *without* becoming class-specific early. Fewer parameters, all of them used, each shared across classes.

---

## Why this matters for a reasoning model

**Sparsity that is chosen, not searched.** The wiki's other efficiency results ([[wiki/entities/sparse-distributed-memory.md]], [[wiki/concepts/sparse-distributed-representations.md]]) price sparsity in capacity or recognition error. This one prices it in *optimisation*: the space of sparse networks of a given size is astronomically large, finding a good one normally costs pruning or evolutionary search, and the paper's claim is that **evolution already located one and it is describable in two sentences** (tree partition + restricted receptive fields). That is an architectural prior obtained for free — the cheapest kind of installed prior the wiki has seen.

**(brainstorm) The regularisation is a graph, not a penalty.** Dropout, weight decay and early stopping regularise by perturbing or shrinking a dense hypothesis class. A mask regularises by *deleting hypotheses that mix distant inputs at layer 1*. For latent-graph discovery ([[wiki/concepts/latent-graph-discovery.md]]) this is the more useful form: the prior says which variables may interact before which interactions are learned, which is exactly a prior over the edge set of the latent graph rather than over its weights. A dANN's mask is a hypothesis about the observation graph; a learned mask would be the discovery step itself.

**(brainstorm) Mixed selectivity is here an *effect* of restricted fan-in, not of expansion.** [[wiki/concepts/population-geometry.md]] documents mixed/conjunctive coding as a property of large expanded populations in prefrontal and hippocampal circuits. Here it arises in a *small* network purely because no unit sees enough of the input to be class-specific — each unit must be reused across classes to be worth its parameters. If that generalises, mixed selectivity may be diagnostic of **fan-in starvation** rather than of dimensional expansion, and the two mechanisms make opposite predictions about what happens when you widen the layer.

**Where it does not go.** No abstraction, no relational task, no compositional generalisation is tested. The result is "structured sparsity is a better inductive bias for image classification than dense connectivity", and every claim about reasoning is extrapolation.

---

## Comparison

| Model | Dendritic feature imported | Learning rule | Cost |
|---|---|---|---|
| **dANN** (this page) | Structured connectivity + restricted sampling | Backpropagation, masked | Extra mask multiply per step; discarded gradients |
| Ahmad & Hawkins 2016 ([[wiki/concepts/dendritic-computation.md]]) | Segment **nonlinearity** (`D·A ≥ θ`), independent detectors | None specified | Neuron output function undefined |
| Active-dendrite continual learners (Iyer et al. 2022, cited) | Dendrites as a gating/pooling layer | Backpropagation | Very large parameter counts |
| Jones & Kording 2021 (cited) | Dendrite as an extra weighted layer | Backpropagation | Very simple tasks only |
| Dendritic credit-assignment models (Guerguiev, Sacramento; cited) | Apical/basal split as an error channel | Local | Does not scale to ML workloads |

The dANN sits at the "least biology, most scale" end: it is the only one in the list that is a drop-in replacement for a fully connected block in a convolutional net or transformer, which the authors propose but do not test.

---

## Limitations

| Limit | Consequence |
|---|---|
| **The dendrite is linear-plus-LeakyReLU** | The paper's "dendrites" have none of the properties [[wiki/concepts/dendritic-computation.md]] argues are the point (coincidence detection, regenerative spikes, long plateaus). The transferred content is topology only |
| Image classification only | No sequence, relational, compositional or reasoning benchmark; the "difficulty" axis is Gaussian noise and CIFAR-10 |
| Masks are fixed and hand-designed | Where the mask comes from in a domain without a spatial metric is unanswered — the LRF construction presupposes pixel neighbourhoods |
| Efficiency is in *parameters*, not FLOPs | Masked training costs an extra Hadamard product per step and discards gradients; the savings are realised only on hardware that can skip the zeros |
| Cable weights unconstrained (can be negative) | Biologically wrong — dendrite→soma coupling is positive; the authors flag this |
| sANN gap narrows with scale | The structured-vs-random advantage is clearest for small models; the load-bearing claim may be *density*, not *tree structure* ([[wiki/empirical-tensions.md]] T64) |
| Gradients zeroed on absent connections | Potentially discards useful descent directions; a genuinely local rule is claimed to be better but was not implementable |

---

## Connections

- **[[wiki/concepts/dendritic-computation.md]]** — the same biological object stripped to its cheapest transferable part: that page's claim is that the *nonlinearity* is what dendrites contribute, this model imports only the *wiring* and still gets 1–3 orders of magnitude in parameters, which separates the two contributions and shows topology alone is worth something.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the complementary sparsity account: that page prices restricted fan-in in recognition error over sparse binary codes (`s ≈ 30` of `a ≈ 300`), this one prices a structurally identical restriction (16 of 784) in generalisation gap and parameter count on a dense-valued supervised task.
- **[[wiki/concepts/population-geometry.md]]** — supplies a competing origin for mixed selectivity: here conjunctive coding emerges in a *small* network from restricted fan-in rather than from population expansion, and it improves generalisation rather than merely enabling linear readout. That page returns a bound: prefrontal firing rates are measured at their design-ceiling dimensionality, so whatever the mixing is computed by, it cannot stay hidden inside units — a dendritic expansion feeding a low-dimensional rate code is excluded (Rigotti et al. 2013, [[wiki/empirical-tensions.md]] T67).
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — an unusually clean transfer datum: the imported content is a connectivity mask with no biophysics attached, so the experiment isolates how much of the dendritic advantage survives at the architectural level (T1's cheapest possible import).
- **[[wiki/concepts/continual-learning.md]]** — the class-blocked training scenario is a catastrophic-interference stress test passed by architecture alone: mixed-selective, fully utilised units are more stable under single-class gradients than class-specific ones, with no replay, no regularisation and no dedicated module.
- **[[wiki/concepts/intelligence-density.md]]** — a direct measurement of the ratio's denominator: the same outputs obtained with 1–3 orders of magnitude fewer described parameters is `C(S)` cut without cutting `log₂N(S)`, and the gain comes from the architecture's description rather than from the data.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a prior over the *edge set* rather than over weights: the mask states which input variables are allowed to interact before any interaction is learned, which is the discovery problem's hypothesis space fixed by hand.
- **[[wiki/entities/hag-reservoir.md]]** — the exact complement of this page's design choice: both claim a sparse, task-shaped graph is what matters, but here the mask is handcrafted before training and the values are learned by gradient, there the graph is grown from input correlations by a local homeostatic rule and no recurrent value is ever gradient-trained.
- **[[wiki/entities/spiking-neural-networks.md]]** — the deployment target the paper argues for: a fixed, handcrafted sparse graph with no pruning phase maps directly onto neuromorphic hardware where absent connections cost nothing, which is where the parameter saving becomes an energy saving.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the same wiring-cost argument made from cortical volume rather than parameter count: lamination is described there as a scaffold that constrains which neurons *may* connect, buying roughly an order of magnitude in volume over an undivided cortex (Mitchison 1991), which is the biological form of this model's demonstration that a constrained connectivity template beats a matched unconstrained one.
- **[[wiki/entities/kan-ode.md]]** — the wiki's other measured cut to parameter count, by the opposite move: this page *removes* connections with fixed binary masks, a KAN reallocates the same budget from node weights into per-edge learned basis functions and reports a better scaling exponent (`N⁻⁴` vs an MLP's `N⁻²`) rather than a constant-factor saving. The two are orthogonal and have never been combined.
- **[[wiki/entities/imagenet-c.md]]** — the opposite sign on parameter count, measured at scale: pruning a convolutional network for size costs accuracy *and* corruption robustness (CondenseNet 80.8 → 84.6 mCE) while width and feature aggregation improve both, so this page's noise-robustness gain must be attributed to the *pattern* of the sparse graph rather than to smallness (T64, [[wiki/empirical-tensions.md]] T300).
- **[[wiki/concepts/neuron-complexity-index.md]]** — the complementary ablation on the same organ: this model imports the dendritic connectivity graph with no nonlinearity and buys 1–3 orders of magnitude in parameter efficiency, while fitting an L5PC's I/O holds morphology fixed and toggles the NMDA nonlinearity, finding that is what sets required *depth* (7 layers with, 1 without) — topology buys efficiency, the receptor buys depth (T64, T302).
