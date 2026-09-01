# CPC (Contrastive Predictive Coding)

**Predict the future in *latent* space, and score the prediction by asking it to pick the true future out of a bag of random ones: an encoder `g_enc` compresses observations to `z_t`, an autoregressive model `g_ar` summarises `z_{≤t}` into a context `c_t`, and a log-bilinear score `exp(z_{t+k}ᵀ W_k c_t)` is trained by categorical cross-entropy over one positive and `N−1` negatives — the loss the wiki has been calling InfoNCE in fifteen places without ever holding its primary source.**

> **Provenance.** van den Oord, Li & Vinyals 2018, *Representation Learning with Contrastive Predictive Coding*, arXiv:1807.03748 (`raw/oord-2018-contrastive-predictive-coding.md`). Four domains in one paper: speech, images, text, reinforcement learning. Lineage claimed explicitly to predictive coding in signal processing (Elias 1955) and in neuroscience (Rao & Ballard 1999; Friston 2005), and to slow feature analysis (Wiskott & Sejnowski 2002).

---

## The objective

```
z_t = g_enc(x_t)                     c_t = g_ar(z_{≤t})
f_k(x_{t+k}, c_t) = exp( z_{t+k}ᵀ W_k c_t )        one W_k per horizon k

L_N = − E_X [ log  f_k(x_{t+k}, c_t) / Σ_{x_j ∈ X} f_k(x_j, c_t) ]
      X = one positive from p(x_{t+k}|c_t), N−1 negatives from p(x_{t+k})
```

| Property | Statement |
|---|---|
| **What the optimum is** | `f_k ∝ p(x_{t+k}|c_t) / p(x_{t+k})` — a **density ratio**, unnormalised, and independent of `N`. Derived by writing the loss as the posterior over which sample is the positive |
| **Why a ratio and not `p(x|c)`** | An image carries thousands of bits; the latent that matters carries ~10. Modelling `p(x|c)` spends capacity reconstructing detail and "often ignores the context `c`". The ratio is the smallest object that preserves `I(x;c)` |
| **The bound** | `I(x_{t+k}; c_t) ≥ log N − L_N`, tighter as `N` grows. Minimising the loss maximises a lower bound on mutual information |
| **Multi-step is the point** | Next-step prediction exploits local smoothness; at longer `k` the shared information is lower and only **slow features** (phonemes, intonation, objects, story line) survive to be predicted |

**The `log N` ceiling is the structural fact.** The bound is capped by `log N` regardless of how well the model does, so the *batch* sets the largest mutual information the objective can certify. At the paper's audio setting (8 GPUs × 8 examples) that is under 5 nats. This is the earliest and cleanest instance of the wiki's recurring complaint that a self-supervised objective's *value* means little in isolation ([[wiki/concepts/divergence-objectives.md]], [[wiki/empirical-tensions.md]] T168).

**And the mutual-information reading is the one part later work overturned.** Wang & Isola 2020 show the InfoMax justification is inconsistent with practice — optimising a *tighter* bound on `I` gives worse representations — and that what the loss provably does at `M → ∞` is align positive pairs plus estimate the entropy of the embedding marginal non-parametrically, with `τ` a von Mises–Fisher kernel bandwidth ([[wiki/concepts/alignment-uniformity.md]]). CPC's derivation is correct and its *interpretation* of what makes the representation good is not.

---

## Architecture, per domain

| Domain | `g_enc` | `g_ar` | Horizon | Negatives drawn from |
|---|---|---|---|---|
| **Speech** (LibriSpeech-100h, 251 speakers) | 5 strided conv layers, strides `[5,4,2,2,2]`, ×160 downsample → one vector per 10 ms, 512 units | GRU, 256-d | 12 steps (120 ms) | the minibatch (8 GPUs × 8 examples) |
| **Vision** (ImageNet) | ResNet-v2-101 (untrained), block 3, mean-pooled per patch → 7×7×1024 from a 7×7 grid of 64×64 crops | PixelCNN-style row-wise autoregressor, top-to-bottom | up to 5 rows below | the batch (32 GPUs × 16) |
| **Text** (BookCorpus) | 1D-conv + ReLU + mean-pool → 2400-d sentence vector | GRU, 2400-d | 3 sentences | the batch |
| **RL** (5 DeepMind Lab tasks) | the A2C agent's own conv encoder + LSTM, unchanged | shared with the agent | up to 30 steps (unroll 100) | the batch; **no replay buffer**, so negatives track the changing policy |

Either `z_t` or `c_t` can be the representation: `c_t` when past context is needed (phonetic content exceeds `z_t`'s receptive field), `z_t` otherwise, pooled when the task wants one vector per sequence. **The read-out is a free choice the objective does not make**, and the paper is explicit about it.

---

## Results

| Domain | Metric | CPC | Best prior | Supervised / ceiling |
|---|---|---|---|---|
| Speech, phone classification (41 classes) | linear probe on `c_t` | **64.6** | MFCC 39.7; random init 27.6 | 74.6 |
| Speech, speaker ID (251 classes) | linear probe on `c_t` | **97.4** | MFCC 17.6; random init 1.87 | 98.5 |
| ImageNet | linear top-1 | **48.7** | Colorization 39.6 | — |
| ImageNet | linear top-5 | **73.6** | MS+Ex+RP+Col *combined* 69.3 | — |
| BookCorpus → TREC | logistic | **96.8** | skip-thought 91.4 | — |
| BookCorpus → MR / CR / Subj / MPQA | logistic | 76.9 / 80.1 / 91.2 / 87.7 | skip-thought+LN 79.5 / 82.6 / 93.4 / 89.0 | — |
| DeepMind Lab (5 tasks) | A2C return @1B frames | **improves 4/5** | — | — |

**One code, two nested factors, both linear.** The same 256-d `c_t` gives 97.4% speaker identity *and* 64.6% phone content under separate linear probes without averaging over time. A representation trained to predict the future does not have to choose which factor to keep, which is the cleanest counter-example in the wiki to the assumption that a bottleneck necessarily discards the nuisance variable ([[wiki/concepts/information-bottleneck.md]]: the relevance variable here is "the future", and speaker identity is relevant to it).

**The RL result has a negative control the paper draws the right conclusion from.** The one task where the auxiliary loss neither helps nor hurts is `lasertag_three_opponents_small`, which "does not require memory and thus yields a purely reactive policy". A predictive auxiliary objective pays exactly where the policy needs state that the current frame does not carry — which makes it an instrument for detecting memory demand in a task, not just a regulariser ([[wiki/concepts/working-memory.md]], [[wiki/concepts/learned-world-models.md]]).

---

## The three ablations, which are worth more than the headline numbers

**1. Prediction horizon is a lever with an interior optimum** (phone classification, everything else fixed):

| steps predicted | 2 | 4 | 8 | **12** | 16 |
|---|---|---|---|---|---|
| accuracy | 28.5 | 57.6 | 63.6 | **64.6** | 63.8 |

A factor of **2.3** from a single scalar in the pair-construction step, with both ends losing: too short and the objective is solved by local smoothness, too long and the target is unpredictable. This is [[wiki/empirical-tensions.md]] T167's pair-sampler lever in a third method, a third modality and a third axis — and the *only* one of the three whose axis is a scalar with a shape, so it is the one place the lever could plausibly be set by a rule rather than by search.

**2. The noise distribution is worth ~8 points and nobody reports it as a parameter** (all at 12 steps):

| negatives drawn from | accuracy |
|---|---|
| same speaker | **65.5** |
| current sequence only | 65.2 |
| mixed speaker (default) | 64.6 |
| same speaker, current sequence excluded | 64.6 |
| mixed speaker, current sequence excluded | **57.3** |

Excluding the current sequence costs 7.3 points when the negatives are also from other speakers, and nothing when they are from the same speaker. So what matters is that some negatives are **hard** — near the positive in the nuisance factors — and the two ways of supplying hardness substitute for each other. This is the direct measurement behind [[wiki/concepts/energy-based-models.md]]'s claim that a contrastive method's noise distribution `p_n` is a free parameter reported as an implementation detail.

**3. The linear probe under-reads by 7.9 points.** Swapping the linear read-out for a **single hidden layer** moves phone classification 64.6 → 72.5, against a fully supervised 74.6 — so a linear probe attributes to the encoder about 60% of the gap it has actually closed, and the field's default instrument is measuring linear accessibility rather than content ([[wiki/concepts/representation-probing.md]]). Every ranking in gap `G34` is by linear probe.

---

## What it started, and what it cannot do

| | |
|---|---|
| **Ancestor of the JEPA line** | Predicting a *representation* of the future rather than the observation, with the target produced by the model's own encoder, is [[wiki/entities/i-jepa.md]]'s and [[wiki/entities/v-jepa-2.md]]'s defining move, five years earlier and with negatives instead of an EMA asymmetry. The differences that remain are the anti-collapse provision and the pair sampler, not the architecture |
| **Ancestor of the contrastive family** | SimCLR, MoCo and CLIP are this loss with the temporal pair replaced by an augmentation pair or a caption pair; locus 1 of [[wiki/concepts/representational-collapse.md]] |
| **The temporal pair is the biologically motivated one** | Positives are *adjacent in time*, not two crops of one array. That is the pairing rule gap `G95` says biology uses and machine methods replace with a declared augmentation list — CPC is the wiki's clearest case of a machine method that never declares one ([[wiki/concepts/manifold-untangling.md]]) |
| **No decoder, so no inspection** | Nothing renders `c_t`; the paper evaluates by probe and t-SNE only |
| **No account of what `N` should be** | The bound wants `N` large, compute wants it small, and the ablation shows the *identity* of the negatives matters more than the count over the range tested |
| **The text results are the weak ones** | Below skip-thought+LN on 4 of 5 tasks. The paper's own reading is that these transfer targets are near-bag-of-words; the alternative reading, which the wiki has independent evidence for, is that a contrastive objective on sentence-adjacency pairs is where this family is weakest ([[wiki/concepts/alignment-uniformity.md]]'s 3–4 point text loss, same pair type) |

---

## Comparison

| | CPC (2018) | [[wiki/entities/i-jepa.md]] (2023) | [[wiki/entities/barlow-twins.md]] (2021) | [[wiki/entities/vl-jepa.md]] (2025) |
|---|---|---|---|---|
| Pair source | **time** (`t` → `t+k`) | two blocks of one image | two augmentations | image → answer sentence |
| Prediction target | latent `z_{t+k}` | EMA-encoder latent | own embedding | text-encoder embedding |
| Score | log-bilinear + InfoNCE | L2 | cross-correlation → `I` | InfoNCE |
| Anti-collapse | negatives | EMA + predictor asymmetry | off-diagonal term + batch standardisation | InfoNCE uniformity + scaled target LR |
| Coefficients | `τ`, `N`, horizon `k` | 0 | 1 | `τ`, LR ratio |
| Horizon | **explicit, ablated, optimum at 12** | not a variable | not a variable | ablated, 1 s → 10 s |

---

## Connections

- **[[wiki/concepts/alignment-uniformity.md]]** — the correction to this page's headline justification: the loss is an alignment term plus a non-parametric entropy estimate of the embedding marginal, not a mutual-information bound to be tightened, and the `τ` this page treats as a softness knob is a kernel bandwidth.
- **[[wiki/concepts/representational-collapse.md]]** — this is locus 1's primary source: negatives as the anti-collapse provision, later shown to be a distribution-matching term with target `σ_{m-1}` in disguise.
- **[[wiki/concepts/energy-based-models.md]]** — supplies the derivation this loss is an instance of (NCE substituting an arbitrary noise distribution for the intractable model term), and this page supplies that page's missing measurement: varying `p_n` alone is worth 7.3 points.
- **[[wiki/concepts/divergence-objectives.md]]** — the rate–distortion reading of what this objective does: the temporal pairing is the transformation `f` that fixes the rate, and the density-ratio score is a distortion term that charges only for confusing the true future with a batch-mate.
- **[[wiki/concepts/information-bottleneck.md]]** — the self-supervised substitution that page names as the open move: the relevance variable `Y` is set to "the observation `k` steps ahead", which imports that surrogate's blind spots — anything predictable from the past is kept, including speaker identity.
- **[[wiki/concepts/representation-probing.md]]** — the measurement that prices the instrument: linear 64.6 vs one hidden layer 72.5 vs supervised 74.6, on the same frozen features.
- **[[wiki/concepts/manifold-untangling.md]]** — the machine method whose pairing rule is temporal adjacency rather than a declared augmentation list, which is the slowness principle implemented as a loss (gap `G95`).
- **[[wiki/concepts/timescale-hierarchy.md]]** — the horizon ablation is a timescale being *chosen* rather than emerging: predicting further makes the code slower, and 12 steps is where the trade turns for phonemes.
- **[[wiki/entities/i-jepa.md]]** — the same architecture with the temporal pair replaced by a spatial one and the negatives replaced by an EMA asymmetry; the ancestry makes the two comparable on exactly the pair sampler that T167 is about.
- **[[wiki/entities/v-jepa-2.md]]** — the video descendant: same "predict a representation of the future" move, no negatives, and at a scale CPC's 8-GPU batch could not reach.
- **[[wiki/entities/vl-jepa.md]]** — the cross-modal descendant that keeps the InfoNCE score and adds a trainable target encoder in another modality, where CPC's target encoder is the same network.
- **[[wiki/entities/barlow-twins.md]]** — the negative-free alternative to this page's provision, and the entropy-estimator reading that makes the two comparable: this loss is the non-parametric estimator, that one its Gaussian-parametrised proxy.
- **[[wiki/entities/directclr.md]]** — the later measurement that a trained contrastive embedding is rank-deficient anyway, so the negatives here buy freedom from *complete* collapse and nothing more.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the neuroscience the name is borrowed from, and the point where they part: predictive coding propagates a residual in observation space, CPC never computes one and scores a discrimination in latent space instead.
- **[[wiki/concepts/learned-world-models.md]]** — the RL result as a claim about world models: a latent predictive loss added to a model-free agent improves 4 of 5 tasks and does nothing on the one that needs no memory, so the benefit is state-carrying rather than planning.
- **[[wiki/entities/world-models-vmc.md]]** — the same finding with the predictive head kept and used: concatenating an MDN-RNN's recurrent state to a *linear* controller is worth 632 → 906 on CarRacing, so a latent predictive model pays as state rather than as search on both sides of the loss function (`T327`).
