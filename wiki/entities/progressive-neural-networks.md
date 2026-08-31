# Progressive Neural Networks

**One frozen column per task, plus lateral connections from every earlier column into every layer of the new one: forgetting is zero by construction, transfer is a per-layer decision the optimiser makes rather than an initialisation the designer picks.** Rusu, Rabinowitz, Desjardins, Soyer, Kirkpatrick, Kavukcuoglu, Pascanu & Hadsell 2016, arXiv:1606.04671 (DeepMind). Source: `raw/rusu-2016-progressive-neural-networks.md`.

This is the wiki's primary source for the **architectural-growth** row of [[wiki/concepts/continual-learning.md]], previously carried second-hand. Two things in it are load-bearing beyond the architecture: a **matched-parameter control** (baseline 4) that isolates growth-with-transfer from growth alone, and **Average Fisher Sensitivity**, a label-free readout of *which column and which layer the final policy actually leans on* — the first instrument in the wiki that measures reuse rather than assuming it.

---

## Architecture

| Component | Form | Role |
|---|---|---|
| Column `k` | a full `L`-layer network with parameters `Θ^(k)`, randomly initialised | solves task `k`; one policy `π^(k)(a∣s) := h_L^(k)(s)` per Markov decision process |
| Freezing | `Θ^(j)`, `j < k`, are constants for the optimiser | no interference ⇒ **no catastrophic forgetting, by construction rather than by penalty** |
| Lateral connection | `U_i^(k:j) ∈ R^{n_i × n_j}` from layer `i−1` of column `j` into layer `i` of column `k`, strictly `j < k` | earlier features are readable at *every* depth, not just at initialisation |
| Adapter | one-hidden-layer MLP on the concatenated anterior features `h_{i−1}^{(<k)}`, preceded by a **learned scalar `α`** initialised small and randomly (`{1, 10⁻¹, 10⁻²}`); `1×1` convolutions for conv layers | dimensionality reduction (keeps lateral parameters `O(∣Θ^(1)∣)`) **and** conditioning — the small `α` neutralises the scale mismatch between a trained column's activations and an untrained one's |

```
h_i^(k) = f( W_i^(k) h_{i−1}^(k) + Σ_{j<k} U_i^(k:j) h_{i−1}^(j) )                     (plain)
h_i^(k) = σ( W_i^(k) h_{i−1}^(k) + U_i^(k:j) σ( V_i^(k:j) α_{i−1}^{(<k)} h_{i−1}^{(<k)} ) )   (with adapter)
```

**The design claim.** Fine-tuning assumes task overlap and pays for it destructively: it incorporates prior knowledge *once*, at initialisation, and then overwrites it. A progressive column is free to **reuse, modify or ignore** each earlier feature independently at each depth, so the source tasks may be orthogonal or adversarial without the transfer decision being made in advance. Training used A3C (Mnih et al. 2016); 3 conv layers of 12 feature maps + a 256-unit fully connected layer per column, `4×10⁷` agent-perceived steps.

---

## Results — transfer score (area under the learning curve, % of a single column trained only on the target)

| | Pong Soup mean / median | Atari mean / median | Labyrinth mean / median |
|---|---|---|---|
| Baseline 1 — single column on target | 100 / 100 | 100 / 100 | 100 / 100 |
| Baseline 2 — pretrained, **output layer** finetuned | 35 / 7 | 41 / 21 | 88 / 85 |
| Baseline 3 — pretrained, **fully** finetuned | 181 / 160 | 133 / 110 | 235 / 112 |
| **Baseline 4 — 2-column progressive, first column random and frozen** | 134 / 131 | 96 / 95 | 185 / 108 |
| Progressive 2 column | **209 / 169** | 132 / 112 | **491 / 115** |
| Progressive 3 column | **222 / 183** | 140 / 111 | — |
| Progressive 4 column | — | **141 / 116** | — |

Three readings the wiki should carry:

- **Baseline 2 is catastrophic in reinforcement learning** (35% on Pong Soup) while being the routine move in supervised vision. Freezing the features and retraining only the head fails because the reward-relevant low-level features change from task to task; the practice imported from ImageNet does not survive the transfer to control.
- **Baseline 4 is the control that matters.** It has the same parameter count and the same lateral wiring as progressive 2-column, and differs only in that the anterior column was never trained. Progressive beats it in all three domains (209 vs 134, 132 vs 96, 491 vs 185), so the gain is *the content of the earlier column*, not the added capacity.
- **Transfer increases with column count** (Atari 132 → 140 → 141 mean), i.e. the accumulation is constructive; and positive transfer occurs in 8/12 Atari targets against baseline 3's 5/12, with only 2 cases of negative transfer.

---

## Average Fisher Sensitivity — the transfer measurement

Because nothing is destroyed, *where* transfer happened is answerable after the fact. Compute a diagonal Fisher of the policy with respect to the **normalised activations** at each layer (not the parameters), then normalise across columns:

```
F̂_i^(k) = E_{ρ(s,a)} [ (∂ log π / ∂ ĥ_i^(k)) (∂ log π / ∂ ĥ_i^(k))ᵀ ]
AFS(i,k,m) = F̂_i^(k)(m,m) / Σ_k F̂_i^(k)(m,m)          AFS(i,k) = Σ_m AFS(i,k,m)
```

AFS is a local approximation to a **perturbation** experiment (APS): inject Gaussian noise scaled to each site's activation variance, find the precision `Λ_i^(k) = 1/σ_i^{2(k)}` that costs 50% of score, and normalise across columns. The two agree closely; APS is the ground truth and is too slow to run at scale.

| What AFS shows | Reading |
|---|---|
| Pong → H-flip: both conv layers reused, fully connected layer relearned | The invariance the task broke sits at a specific depth; transfer is *per-layer*, and nothing about the task label predicts which depth |
| Pong → Zoom: conv1 reused, conv2 relearned | As above at a different depth |
| Pong → Noisy: some conv1 relearned; **Noisy → Pong: all of vision transfers** | Transfer is **asymmetric** — a filter trained on the clean input is not noise-tolerant, but one trained under noise is clean-tolerant. The source ordering is a design variable |
| A single conv1 feature map carries essentially all the reuse — a spatio-temporal filter with a large temporal DC component | The reused object is one motion detector, not a feature hierarchy |
| Across 72 three-column nets, transfer is highest at a **"sweet spot"** of mid-range new-column conv AFS; the *most negative* transfer coincides with total reliance on the source columns' conv layers and **no new visual features learned at all** | Maximal reuse is not maximal transfer. Two proposed causes: source features give fast convergence to a poor local minimum (an inductive bias that hurts), or the transferred representation is good enough for a functional but sub-optimal policy — an exploration failure |
| AFS spectra get **sparser** as columns are added, both over the source columns' features and within the newest column | Each added column both uses less of what exists and contributes less; the quadratic parameter growth is mostly waste, and it is *measurable* |

**Why this matters to the wiki.** The last two rows are the ones to keep. The sweet-spot result is a direct counter to the assumption that a better-matched prior is always better, and it is a *measured* U-shape rather than an argument. The sparsening spectra are the wiki's only per-feature utilisation audit of a growing model — a signal that could drive pruning or a growth-stopping rule, wired to nothing.

---

## Limitations, as the source states them

| Limitation | Consequence for this wiki |
|---|---|
| Parameters grow **quadratically** in the number of tasks (units linearly) | The expansion family's standing objection; the AFS audit says the capacity is not used, so it is a pruning problem rather than a hard bound |
| **Choosing the column at inference requires the task label** | The same failure CN-DPM later prices: storage is solved, retrieval is not (gap G37). Progressive nets do not even attempt the gate |
| Transfer analysis is post-hoc and diagnostic | Nothing in the architecture reads AFS and acts on it — no pruning, no growth decision, no source-column selection |
| Every result is A3C on Atari / Labyrinth, transfer scored by area under the learning curve | Scores learning *speed*, not final competence; and no out-of-distribution test in the sense of G17 |

---

## Comparison

| | Progressive nets | Fine-tuning (baseline 3) | [[wiki/entities/cn-dpm.md]] | Elastic weight consolidation | [[wiki/entities/vector-hash.md]] |
|---|---|---|---|---|---|
| Forgetting | **0 by construction** | destructive | ≈0 (per-expert 88.20 → 88.20) | penalised, not prevented | 0 by address separation |
| Transfer between tasks | per-layer, learned, at every depth | at initialisation only | forward-only (gradients blocked on laterals) | via shared weights, uncontrolled | **none** — orthogonality forbids it |
| When to add capacity | **given** (one column per task boundary) | never | **inferred** — Chinese-restaurant likelihood ratio, no task label | never | on entering a new environment |
| Which component at test time | **given** (task label) | n/a | inferred, and this is the bottleneck (48.18% at 5 experts) | n/a | inferred from the code |
| Cost | quadratic parameters | none | linear experts + a density model each | Fisher matrix | exponential address space |

Read together, progressive nets and CN-DPM partition the expansion family's two open decisions: CN-DPM supplies **when to grow** and measures that **which one to use** is where it fails; progressive nets are handed both and instead measure **what growth actually buys**, per layer.

---

## Connections

- **[[wiki/concepts/continual-learning.md]]** — the primary source for that page's architectural-growth row, and the row's matched-parameter control: freezing plus lateral access beats a same-size progressive net whose anterior column is random (209 vs 134 / 132 vs 96 / 491 vs 185), so the gain is the stored content rather than the added capacity.
- **[[wiki/entities/cn-dpm.md]]** — the same expansion family with the two decisions swapped: CN-DPM infers when to add a component and cannot pick one at test time, progressive nets are given both and instead measure per-layer what the earlier components contribute; CN-DPM's gradient-blocked laterals are this architecture's lateral connections with the transfer made strictly forward-only.
- **[[wiki/concepts/representation-probing.md]]** — supplies the Average Fisher Sensitivity / Average Perturbation Sensitivity pair, an instrument that attributes the policy's reliance across *sources* rather than decoding content, needs no labels and no fitted decoder, and comes with its own slow causal ground truth.
- **[[wiki/concepts/meta-learning.md]]** — the growth architecture is the non-meta answer to the same question: rather than optimising an initialisation for fast adaptation, keep every previous solution intact and let the optimiser read from all of them, which is why forward transfer here needs no task distribution to be trained over.
- **[[wiki/concepts/cross-embodiment-transfer.md]]** — the adapter's small randomly-initialised scalar `α` on each lateral is the wiki's cheapest device for the initialisation-transient problem (G65): it protects the *new* column from a scale mismatch with trained anterior features without switching any learning off, while the trained side is protected the field-standard way — by freezing.
- **[[wiki/entities/dqn.md]]** — the same Atari suite and the same one-network-per-game constraint that this architecture is built to remove; progressive nets replace DQN with A3C for throughput and score learning speed rather than final performance.
- **[[wiki/concepts/shortcut-learning.md]]** — the sweet-spot result is a shortcut in transfer form: complete reliance on source features with no new vision learned is exactly the negative-transfer regime, so a prior that is *too* readily reusable produces a functional but sub-optimal policy the learner never leaves.
- **[[wiki/entities/elastic-weight-consolidation.md]]** — the same lab's opposite answer on the same suite: share the weights and penalise movement rather than freeze and grow. Both measure reuse with a Fisher (over activations across columns there, over parameters across tasks here) and both find reuse is per-layer and set by how much the tasks actually overlap; the trade is fixed capacity with imperfect retention against exact retention with quadratic growth and an oracle at test time.
