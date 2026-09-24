# Sparse Evolutionary Training (SET) — The Edge Set as a Trained Variable at Fixed Unit Count

**A replacement for any fully-connected bipartite layer: start it as a sparse Erdős–Rényi graph with `ε(n^k + n^{k−1})` edges, and after every training epoch delete the fraction `ζ` of weights closest to zero and regrow the same number at random positions. Width and edge count stay fixed. Only *which* edges exist is learned. On 15 datasets across restricted Boltzmann machines, MLPs and CNNs, the sparse layer matches or beats the dense one at 1–4% of its weights. It always beats a random sparse layer of the same density that is never rewired.**

> **Provenance.** Mocanu, Mocanu, Stone, Nguyen, Gibescu & Liotta 2018, *Scalable training of artificial neural networks with adaptive sparse connectivity inspired by network science*, Nat. Commun. 9:2383 (`raw/mocanu-2018-sparse-evolutionary-training-adaptive-sparse-connectivity.md`). The clip lost Box 1 (the algorithm), Tables 1–3 (datasets, RBM results, MLP results) and every figure. Numbers below come from the running text only. No per-dataset RBM table and no layer sizes are available. Everything below is from that source unless marked.

---

## Architecture

| Component | Spec | Note |
|---|---|---|
| **Sparse layer `SC^k`** | `W^k ∈ ℝ^{n^{k−1}×n^k}`, initial edge probability `p(W^k_ij) = ε(n^k + n^{k−1}) / (n^k n^{k−1})` | Edge count `n^W = ε(n^k + n^{k−1})` is **linear** in units; dense is `n^k n^{k−1}`. `ε` is edges per unit, i.e. the synapse-per-unit ratio as a hyperparameter |
| **Remove** (each epoch end) | Delete fraction `ζ` of the smallest positive weights and of the largest negative weights | Magnitude closest to zero. The authors call it "selection" |
| **Regrow** | Add the same number of edges at uniformly random empty positions | Edge count constant through training. The authors call it "mutation" |
| **Stop** | After the final removal, do not regrow | The last step is a pure prune: the commitment step |
| **Training** | Contrastive divergence (RBM) or stochastic gradient descent (MLP, CNN); unchanged | SET touches only the mask |
| **Hyperparameters** | `ζ = 0.3` everywhere; `ε = 11` (RBM), `20` (MLP, CNN) | Tuned by a small random search **on MNIST only**, then used on all 15 datasets |

The authors place it on a four-scale evolutionary ladder: phylogenic, ontogenetic, epigenetic, inferential. SET evolves connections **at the epigenetic scale only**, inside a fixed multi-layer skeleton. Their contrast is NEAT (NeuroEvolution of Augmenting Topologies), which searches topology and node count jointly and does not scale.

---

## Results

### Restricted Boltzmann machines — 11 datasets, generative log-likelihood

5000 epochs, contrastive divergence at 1/3/10 steps, log-probability estimated by annealed importance sampling (AIS). Hidden units 100/250/500 (UCI suite) and 500/2500/5000 (MNIST, CalTech 101 Silhouettes).

| Comparison | Result |
|---|---|
| SET-RBM vs dense RBM | Better on **7 / 11** datasets |
| SET-RBM vs XBM (complex Boltzmann machine: sparse, **fixed** scale-free topology; the prior sparse state of the art) | Better on **10 / 11** |
| MNIST | **−86.41 nats** at **2%** of the dense parameter count |
| Stability, DNA dataset | SET-RBM flat at ~−85 nats once reached. Dense RBM peaks within a few epochs, then oscillates down to **−160 nats** (overfitting, worse with more hidden units) |
| Where the stability comes from | RBM_FixProb (random sparse, never rewired) is **also stable in almost all cases**, so the stability belongs to sparsity, not to rewiring |
| Unit count at the optimum | RBM_FixProb always peaks at the **largest** hidden count. SET-RBM peaks at a **medium** count on 3 / 11 (DNA, Mushrooms, CalTech 28×28) at the same edge budget |

### MLPs — MNIST, CIFAR-10, HIGGS; Fashion-MNIST control

SGD, learning rate 0.01, momentum 0.9, weight decay 0.0002, dropout 0.3, SReLU (S-shaped rectified linear unit). The three models differ in topology only.

| Dataset | SET-MLP | Reference |
|---|---|---|
| All three | Beats dense MLP at ~**2 orders of magnitude** fewer weights; always beats MLP_FixProb | Same widths, same training |
| CIFAR-10 | **74.84%**, ~0.3M weights | Literature MLPs: 74.1% at 31M; 78.62% at ~12M **with** pre-training |
| HIGGS | **78.47%**, ~90k weights | Literature MLP: 78.54% at ~3× the weights |
| Fashion-MNIST, 3 × 1000 units, regulariser × momentum × activation grid | Best with SReLU, no Nesterov, no or L2 weight penalty; **L1 hurts** | SET > FixProb in every cell |

### CNN — CIFAR-10, 6 conv layers (287,008 weights) + 2 sparse or dense layers on top

| Model | Top layers' weights | Max accuracy |
|---|---|---|
| CNN (dense top) | 8,413,194 | 87.48% |
| CNN_FixProb | 184,842 | 88.26% |
| **SET-CNN** | 184,842 | **90.02%** |

The weight counts give 2.2% for the top layers; the paper's own figure is "about 4% of the CNN connections". FixProb **beats dense** here. So a sparsity-as-regulariser gain (+0.8) sits under the rewiring gain (+1.8).

### Topology

| Finding | Detail |
|---|---|
| **Hidden-unit degree → power law** | Initial degree is binomial. During training a test against a power law crosses `p < 0.05` in **70 / 99** RBM cases. Small hidden layers fail to get there; the largest always do. The same drift is shown for SET-MLP |
| **Input-unit degree → data map** | MNIST: visible units in the centre, where digits fall, gain many edges. Border units end with **zero or few**. CalTech: the same pattern, but weaker. So the edge set learns a feature-importance map with no term asking for one |

### Ablations on the removal criterion (text only, no numbers)

| Removed each epoch | Outcome |
|---|---|
| Smallest magnitude (SET) | As above |
| Random | "Dramatic reductions in accuracy" |
| **Largest** magnitude | SET-MLP "not able to learn at all", i.e. chance |

---

## Limitations

| Limitation | Consequence |
|---|---|
| **No `ε` sweep is reported** | Only two densities are compared per model: `ε` (one value) and dense. The density–accuracy curve at fixed width, which is `G101`'s experiment, is absent. It may be in the lost Table 3 or supplement, but not in the clip |
| **Dense vs sparse confounds edges with regularisation** | The paper states it: sparse models do not overfit because they have few parameters. So "sparse ≥ dense" does not show extra edges are useless. It shows that on these datasets the regularisation from removing edges outweighs what the edges add |
| **Power-law test is under-specified** | Rejecting the null is read as "approaches a power law". In the cited Clauset–Shalizi–Newman framework, a small `p` *rules a power law out*. No likelihood comparison against lognormal or exponential is reported. The claim has the same instrument problem as `T254` |
| **i.i.d. benchmarks only, seeds not stated** | Nothing compositional, no distribution shift, no robustness score (cf. `T300`) |
| **Speed is notional** | Every run used dense-hardware libraries (Keras/Theano, MATLAB). Training-time reduction "may" follow on sparse hardware; no timing is measured |
| **Regrowth is blind** | New edges are uniform random. The only selection is on the erase side, so the search on growth is undirected exploration. **Priced since:** replacing random regrowth with largest-`\|∇L\|` regrowth lifts ResNet-50/ImageNet at 80% sparsity from 72.9 to 74.6. SET also saturates around 75% under longer training, where the gradient-grown net reaches 76.6 at 5× (Evci et al. 2020, [[wiki/entities/rigl.md]]) |
| **Post hoc biological analogy** | The link to sleep-time shrinking of the weakest synapses was found after the method was designed. It is an analogy, not a derivation |

---

## Comparison

| | **SET** | Static random sparse (FixProb; [[wiki/concepts/width-versus-parameter-count.md]]) | [[wiki/entities/dendritic-ann.md]] | [[wiki/entities/hag-reservoir.md]] | Dense layer |
|---|---|---|---|---|---|
| Edge set | Learned during training | Drawn once, frozen | Hand-built from morphology, frozen | Grown from empty | All present |
| Edge count | Constant, `ε(n^k + n^{k−1})` | Constant | Constant | Grows until homeostasis | `n^k n^{k−1}` |
| Erase criterion | **Smallest magnitude** | — | — | **Random** | — |
| Growth criterion | **Random** | — | — | **Max correlation** | — |
| Training signal | Gradient / contrastive divergence | Gradient | Gradient (masked) | Unsupervised, local; readout only | Gradient |
| Beats random sparse at matched density? | **Yes, every model and dataset** | — (it is the baseline) | Yes, narrowing with scale (`T64`) | Not compared | — |

**(brainstorm) SET and HAG are mirror images.** SET selects on erase and explores on growth. HAG selects on growth and explores on erase. Each lacks a criterion for the operation the other has one for. Neither has run the obvious hybrid: magnitude-based erase plus correlation-based growth. **RigL runs a version of it** ([[wiki/entities/rigl.md]]): magnitude erase plus growth where `|∇_{W_ij} L| = |Σ_batch δ_i x_j|` is largest, i.e. a correlation between presynaptic activity and postsynaptic *error* rather than postsynaptic activity. It beats SET at every tested sparsity.

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| Mask | A hypothesis about which variable pairs interact, revised once per epoch |
| Remove-smallest | Evidence-based edge deletion: an edge the gradient never grew is taken as a spurious edge |
| Regrow-random | Proposal distribution over missing edges. It is uniform, so the search ignores every structural prior the wiki holds (locality, small-world shortcut placement) |
| Input-degree map | A learned **node-relevance** statistic: degree reads out which inputs the task uses |

**(brainstorm) Degree as a free relevance readout.** Degree is available at every epoch at no cost. SET shows it separates task-relevant from irrelevant inputs (MNIST centre vs border) with no loss asking for it. Degree could serve as the saliency signal that the wiki's attention and parsing gaps (`G75`) ask for, with one caveat: it is computed over the *whole* training set, so it is a prior over inputs, not a per-trial parse.

---

## Connections

- **[[wiki/concepts/width-versus-parameter-count.md]]** — SET is the complementary experiment. That page fixes the weight count and varies width. SET fixes width and edge count and varies which edges exist. Its FixProb control is that page's static random mask, and learned topology beats it at every tested point.
- **[[wiki/entities/dendritic-ann.md]]** — both answer `T64` (structure vs sparsity), from opposite sources. There the structure is copied from dendritic morphology. Here it is found by magnitude-guided rewiring. Both beat a random mask at matched density, so what matters is having *some* structure, not its biological origin.
- **[[wiki/entities/hag-reservoir.md]]** — the mirror-image rule for learning the edge set. HAG grows edges by correlation and prunes at random. SET prunes by magnitude and grows at random. Each has a criterion for the operation the other runs blind.
- **[[wiki/concepts/synaptic-plasticity.md]]** — a partial answer to that page's "erasure has no local criterion" problem. Weight magnitude is local and works as an erase criterion, while random erase and largest-first erase both fail. But this is measured in accuracy under gradient training, not in any population-code property.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — SET is exactly the pruning scheme that page warns about. It deletes the weakest edges first and reports only accuracy. Its ablation shows weak-first beats random at *accuracy*, but the reachable-set cost the page predicts is never measured.
- **[[wiki/concepts/small-world-topology.md]]** — the degree side of the missing trained-network measurement. SET reports a heavy-tailed hidden-unit degree emerging in training, but no clustering, no path length, and no fit against lognormal or exponential. So its topological claim is as weak as the `σ` claims that page criticises.
- **[[wiki/concepts/sleep-oscillation-nesting.md]]** — the biological process the authors link to after the fact. Under the synaptic homeostasis account, sleep weakens synapses globally while tagged spines survive. SET removes the weakest edges outright and protects by magnitude alone, with no tag and no second signal.
- **[[wiki/concepts/cellular-scaling-rules.md]]** — `ε` is the synapse-per-unit ratio as a hyperparameter. SET holds it at ~11–20 edges per unit and matches or beats dense layers. At fixed unit count, then, the machine side reports no gain from the rodent-style move of adding wiring per unit, on these benchmarks (`G101`).
- **[[wiki/entities/rigl.md]]** — the same smallest-magnitude drop with growth changed from random to largest `|∇L|`. That isolates the growth criterion: it is worth +1.7 points on ResNet-50 at 80% sparsity and removes SET's saturation under longer training.
