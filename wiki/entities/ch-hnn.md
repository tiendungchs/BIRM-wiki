# CH-HNN — Corticohippocampal Hybrid Neural Network

**An ANN reads the input and emits a per-neuron binary mask for an SNN that does the actual class learning; the mask is trained only to make *similar inputs produce similar masks*, so the router is a function of the stimulus rather than of a task index — and the task oracle disappears.** Shi, Liu, Li, Li, Shi & Zhao 2025, *Nature Communications*, `s41467-025-56405-9` (`raw/shi-2025-corticohippocampal-hybrid-continual-learning.md`). Code: `github.com/qqish/CH-HNN`.

This is the direct successor to the HMN of [[wiki/concepts/cross-paradigm-interface.md]] (Zhao et al. 2022, same lab), and it is worth an ingest for one reason: that page's headline open problem was that the task-similarity function `S_ta` driving the whole mechanism was **computed from permutation indices the modeller happened to hold**, which the authors called an open problem in general. CH-HNN computes it from the data — cosine similarity between PCA-reduced statistics of (CLIP) feature maps — and therefore runs at test time on a sample whose task is unknown. The gate becomes a *perceptual* operation, which is the shape gap **G37** has been asking for.

---

## The biological claim being imported

| Circuit | Role claimed | Machine counterpart |
|---|---|---|
| **mPFC–CA1** (a deliberate collapse of mPFC → MTL → EC → CA1) | represents **regularities across related episodes**; slow, offline or long-timescale formation | ANN generating the modulation signal |
| **DG–CA3** | encodes **specific memories**, selective per episode | SNN incrementally learning classes/tasks |
| **Feedforward** mPFC-CA1 → DG-CA3 | prior regularities modulate novel encoding | mask gates which SNN neurons may fire and learn |
| **Feedback** DG-CA3 → mPFC-CA1 | new embeddings improve the cortical generalisation | ANN retrained incrementally on the accumulating classes |
| **LPC (angular gyrus) / lPFC → DG-CA3** | reduces false alarms between highly similar episodes | metaplasticity: per-synapse learning-rate decay |

The proposal that concerns the wiki is the **side-effect claim**: transmitting episode regularities to the fast store *increases* confusion between similar episodes, because similar regularities produce similar synchrony downstream. Metaplasticity is introduced as the corrective, and the ablation below shows the correction is needed exactly and only when the regularity signal is poor.

---

## Architecture

**ANN (episode inference).** Three fully-connected layers (64 or 256 units), each decoder emitting a **binary** vector, softmax-normalised: `R = A(x; θ_A)`, `R ∈ {0,1}^{n×c}`, `c` = hidden width of the SNN layer being masked.

Trained with **no task labels and no output supervision** — a similarity-matching plus sparsity objective over sample pairs:

```
min_θA  E_{x,x̃∼D} Σ_i [ | cos(R_i, R̃_i) − sim(x, x̃) |^p  +  β·| ‖R_i‖₁ − ρc | ]
```

with `ρ ≈ 1/n` the target sparsity. `sim(x, x̃)` has two regimes, and the difference is the page's main caveat:

| Regime | `sim` | Task-agnostic? |
|---|---|---|
| All class-incremental settings; pMNIST task-incremental | `cos(x_*, x̃_*)` over PCA-reduced statistics of raw pixels (MNIST/DVS) or **CLIP feature maps** (CIFAR-100, Tiny-ImageNet) | Yes — computed from data |
| Task-incremental on sMNIST / sCIFAR-100 (no natural inter-task relation) | **hand-set**: 1 within task, 0 between | No — the designer supplies the relation |

**SNN (concept learning).** Three layers, batch-norm after the first two, mask applied multiplicatively to the activations:

```
out = W₃ ( Π_{l=1,2}  R_l ⊙ θ^l( BN(W_l x) ) ),      R_l = A_l(x; θ_A)
```

`θ^l` ∈ {EIF, LIF, IF}; rate coding; surrogate-gradient training with cross-entropy.

**Metaplasticity** (used in the SNN, and in the ANN when the ANN itself learns incrementally):

```
W_{i+1} = W_i − α·f(m, W_i)·∇,     f(m, W) = e^{−|mW|}
```

Learning rate per synapse decays from 1 to 0 as `|W|` grows — the exponential meta-function of Laborieux et al. / Soures et al., i.e. importance = weight magnitude, requiring no Fisher matrix and no task boundary. `m` = 15 (sCIFAR-100), 10 (sTiny-ImageNet).

---

## Results

Task-incremental (sMNIST 5×2, pMNIST 40 tasks, sCIFAR-100 20×5), class-incremental (sMNIST, sCIFAR-100, sTiny-ImageNet 40×5, split DVS Gesture). Baselines: fine-tuned ANN/SNN, EWC, SI, XdG, and for class-IL also iCaRL and FOSTER (ResNet32).

| Claim | Number |
|---|---|
| Task-IL, sCIFAR-100, **inter-episode disparity** (max − min task accuracy at the end) | **17.32%** vs XdG **48.76%** |
| Class-IL, sTiny-ImageNet, full model | **70.72%**; inter-episode disparity 44.34% |
| Class-IL, sCIFAR-100, inter-episode disparity | 21.47% |
| Neuron-model ordering | EIF > LIF > IF, attributed to nonlinearity; EIF costs +8.35–8.58% power on Tianjic |
| Power | SNN concept learning uses **60.82% less** than the ANN equivalent (cycle-accurate simulator); float32 → int8 loses little |
| Transfer | ANN pretrained on ImageNet **with CIFAR/Tiny-ImageNet-overlapping classes removed** still beats all baselines on both — the regularity extractor generalises off its training distribution |
| Robot arm, sCIFAR-100 objects, 30 trials × 5 objects, varied position and angle | 82% ± 7.25% |

**XdG is the informative baseline, not EWC.** XdG is the same idea with a *random* mask indexed by a task oracle. It matches or beats CH-HNN on sMNIST and on class-IL sCIFAR-100, and collapses on sTiny-ImageNet as task count rises — attributed to neuron overlap accumulating under random allocation. So the learned, similarity-consistent mask does not beat a random mask at small library sizes; it beats it **at scale**, and it does so without the oracle.

### The lesion result: the two mechanisms are substitutes, not additive

| Condition | Episode inference | Metaplasticity | Both |
|---|---|---|---|
| pMNIST, mean accuracy | 70.41% | — | — |
| pMNIST, inter-episode disparity | 29.77% | **12.53%** | — |
| sTiny-ImageNet class-IL | **70.70%** | limited effect | 70.72% |
| sTiny-ImageNet, **less-relevant priors** | 42.89% | — | **47.23%** |

Read as a design rule: **metaplasticity's contribution is inversely proportional to the gate's accuracy.** When episode inference is good it contributes ~0.02 points; when the prior is off-distribution it is worth 4.3 points. Weight protection is the fallback for a bad router, not a parallel defence — which is a statement about the whole [[wiki/concepts/continual-learning.md]] table that no other source in the wiki makes.

### The feedback loop, measured

The ANN is normally trained offline. Running it *incrementally* instead (first half of the classes, then the rest, with metaplasticity to protect it):

- CH-HNN's accuracy **improves as the ANN accumulates classes**;
- the correlation matrix between modulation signals moves closer to the correlation matrix between samples after all classes are seen.

That is the wiki's only direct measurement of a slow generaliser getting *better at generalising* from the stream its own fast learner is being trained on — the DG-CA3 → mPFC-CA1 arrow, and the missing write-back of gap **G14** in a running system, albeit two-stage rather than continuous.

---

## Comparison

| | **CN-DPM** ([[wiki/entities/cn-dpm.md]]) | **XdG** | **HMN** ([[wiki/concepts/cross-paradigm-interface.md]]) | **CH-HNN** |
|---|---|---|---|---|
| What is separated | whole experts | units, by random mask | units, by learned threshold | units, by learned binary mask |
| Router input | per-expert generative likelihood `p(x)` | **task ID (oracle)** | task index → similarity matrix | **the sample itself** |
| Router training signal | none (Bayes' rule) | none | similarity between task indices | similarity between input statistics |
| Router output | hard argmax over `K` | binary mask | real-valued thresholds | binary mask |
| Memory growth with tasks | linear | none | none | **none** |
| Retrieval accuracy reported | **yes** (48.18% at 5, 31.14% at 20) | n/a (oracle) | indirectly (t-SNE, activation correlation) | **indirectly** (correlation-matrix agreement) |

The last row is the honest weakness. CH-HNN beats CN-DPM end-to-end on comparable class-incremental splits, and its router is soft and graded where CN-DPM's is a hard argmax over a growing label set — but it never reports gate accuracy against ground truth, so the quantity that [[wiki/empirical-tensions.md]] T282 turns on is measured in one system and inferred in this one.

---

## Limitations

- **The prior-knowledge imbalance is admitted.** The ANN is trained on 700 held-out permutations, or on ImageNet, or on CLIP features of the target dataset. On CIFAR-100 and Tiny-ImageNet the *perception* is done by a frozen foundation model and the continual learning happens on 768-channel CLIP features — so the comparison against iCaRL/FOSTER trained on pixels with ResNet32 is not matched, and the paper says the comparison "may seem imbalanced".
- **It needs correlations to exist.** Stated by the authors: the method fails where incremental episodes have no natural or designed correlation. In exactly that case (task-IL on sMNIST/sCIFAR-100) they hand-specify a 0/1 similarity matrix, which reintroduces a task oracle at training time even though inference stays task-agnostic.
- **Class-incremental uses an output mask** that activates only the current classes during training — a boundary signal.
- **The neuroscience is a simplification the authors flag**: EC's role in regularity representation and the anterior/posterior hippocampal split are both left out, and the LPC→DG-CA3 metaplasticity route is a hypothesis the model motivates rather than tests.

---

## Connections

- **[[wiki/concepts/cross-paradigm-interface.md]]** — the same lab's HMN with its central open problem addressed: the task-similarity function `S_ta`, previously read off permutation indices, is computed from PCA-reduced feature statistics of the input, so the modulation flow becomes a stimulus-driven router that runs without a task oracle at inference.
- **[[wiki/concepts/continual-learning.md]]** — supplies the cross-paradigm-modulation row's task-agnostic form and one design rule the rest of the table lacks: weight protection and gating are **substitutes**, with metaplasticity worth 0.02 points when episode inference is accurate and 4.3 points when the prior is off-distribution.
- **[[wiki/entities/cn-dpm.md]]** — the same relocation of forgetting into a retrieval step, with the opposite router: a hard argmax over per-expert generative likelihoods with a memory that grows linearly, against a soft per-neuron mask over one fixed-size network — and only CN-DPM scores its own gate against ground truth ([[wiki/empirical-tensions.md]] T282, T108).
- **[[wiki/concepts/complementary-learning-systems.md]]** — a machine CLS with the fast/slow roles assigned by *paradigm* rather than by learning rate, and with the feedback arrow actually run: retraining the cortical generaliser on the classes the fast store has been learning improves its regularity extraction, which is the direction CLS asserts and rarely measures.
- **[[wiki/entities/spiking-neural-networks.md]]** — the substrate half: the spiking network carries the incremental class learning at 60.82% lower power than its rate equivalent, and the neuron model matters monotonically (EIF > LIF > IF), which is a rare case of the extra nonlinearity paying at the task level rather than in unit count.
- **[[wiki/concepts/synaptic-plasticity.md]]** — metaplasticity as an implementable optimiser modification: `f(m,W) = e^{−|mW|}` makes each synapse's own magnitude its importance estimate, so consolidation costs one scalar per synapse and needs no Fisher matrix, no task boundary and no exemplar buffer.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the separation/completion bias arriving as a *learned* function of input similarity rather than a fixed sparsity level: the mask's overlap between two inputs is trained to equal their perceptual similarity, which is the closest thing in the wiki to a run-time answer to gap G38.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the sparsity of the gate is an explicit loss term (`β·|‖R‖₁ − ρc|`, `ρ ≈ 1/n`) rather than an architectural constant, making the code's density a trained quantity balanced against similarity fidelity.
- **[[wiki/concepts/contextual-inference.md]]** — the same job done discriminatively: instead of a posterior over which stored context generates the data, one feedforward pass emits the mask directly, which is cheap and amortised but produces no uncertainty and cannot report that *no* stored structure applies.
- **[[wiki/concepts/schema-assimilation.md]]** — an operational reading of assimilation: prior regularities do not supply content to the new learner, they supply an *address* — which neurons the new concept is allowed to use — and transfer is measured by whether the ImageNet-derived addresses still help on disjoint classes.
- **[[wiki/entities/mediodorsal-thalamus.md]]** — the biological twin of the gating network, with the two differences that matter: the thalamic gate is two-signed (sustaining the in-context representation while suppressing the out-of-context one) and its input is pooled from the gated population itself, where CH-HNN's is one-signed and comes from a separate perceptual pathway.
- **[[wiki/entities/context-modular-memory-network.md]]** — the same mask-separation mechanism with the mask made a learned function of the stimulus instead of an index: contexts share neurons and synapses, interference is removed at recall, and here the per-context bit pattern is *predicted* rather than stored.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the region this model assigns the regularity-extraction role to, collapsed together with MTL, EC and CA1 into a single pathway; the anatomy page's asymmetry (hippocampus addresses the controller directly, the controller returns only through EC or thalamus) is exactly what the collapse discards.
