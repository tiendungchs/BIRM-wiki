# LearningMatch

**A Siamese network that replaces an exact similarity *function* with a learned one: two shared-weight encoders over the parameters of a pair of gravitational-wave templates, combined not by a distance but by a deep head that also receives the pair's raw difference-squared and its raw **mean**, because the target metric's curvature varies over the manifold (Green, Lundgren & Morice-Atkinson 2025).**

> **Provenance.** Green, Lundgren & Morice-Atkinson 2025, *LearningMatch: Siamese Neural Network Learns the Match Manifold*, arXiv:2502.01361 (`raw/green-2025-learningmatch-siamese-match-manifold.md`). Domain is gravitational-wave template-bank generation; what transfers is the architecture of the comparator and the ledger that prices it.

---

## The target function

The **match** between two waveform templates `h₁, h₂` is an inner product weighted by the detector's noise PSD (Power Spectral Density) and maximised over the two extrinsic parameters (coalescence time `t_c`, coalescence phase `φ_c`):

```
M(h₁,h₂) = max_{φ_c,t_c} (h₁|h₂),    (h₁|h₂) = 4 Re ∫₀^∞ h̃₁*(f) h̃₂(f) / S_h(f) df
```

so `M ≈ 1` for near-identical intrinsic parameters and `M ≈ 0` for distant ones. The induced map from intrinsic parameters to `M` is the **match manifold**. Two properties make it the interesting case for this wiki:

- It is a **ground-truth** similarity, computable exactly — unlike every self-supervised similarity in the wiki, where "similar" is *defined* by an augmentation or a masking policy and there is nothing to check against.
- It is **inhomogeneous**: an equal parameter step changes the match drastically in the low-chirp-mass region and negligibly in the high-mass region. The metric depends on *where* the pair sits, not only on how far apart it is.

---

## Architecture

| Component | Choice | Note |
|---|---|---|
| **Input** | `(λ₀, η, χ)` per template — `λ₀ = (M_c/M_ref)^(−5/3)` with `M_ref = 5 M_☉`, `η = m₁m₂/(m₁+m₂)²`, equal aligned spin `χ₁ = χ₂` | 3 intrinsic parameters per side; `λ₀` chosen over chirp mass so the network's resolution is spent on the low-mass region |
| **Embedding layers** (the twins) | 4 × 1024, ReLU, linear final layer, shared weights | Depth swept: **no significant effect on accuracy** (Fig. 5) |
| **Combination** | Concatenate `[emb(θ₁), emb(θ₂), (θ₁−θ₂)², (θ₁+θ₂)/2]` — the last two are **raw parameters, 4 extra dimensions, bypassing the encoders** | `(θ₁−θ₂)²` encodes "identical ⇒ match 1"; the **mean** is what tells the head where on the manifold the pair sits |
| **Crunch layers** (the comparator) | 5 × 1024, ReLU, linear output → scalar match | Depth swept: 5 is the knee, 6 adds latency without accuracy (Fig. 6) |
| **Loss** | Mean squared error against the exact match | Supervised regression — no collapse risk, no anti-collapse term, no negatives |
| **Training** | Adam, lr `10⁻⁶`, batch 1024, 5000 epochs, ≈31 h on one A100 | Train/validation curves never separate: **no overfitting at 5000 epochs**, because the label oracle can generate unlimited data |

**The architectural point.** This is neither a two-tower model (score `⟨f(θ₁), f(θ₂)⟩`) nor a cross-encoder (one network over the concatenated raw pair). It is the **middle**: encoders that could be cached per item, plus an un-factorised learned head over the pair. The head is where the depth ablation says the work is done, and the head is the part that cannot be precomputed.

---

## Dataset: sampling is the design

| Split | Uniform sampler | "Diffused" sampler | Total |
|---|---|---|---|
| Train | 1M | 1.5M | 2.5M |
| Validation | 100k | 150k | 250k |
| Test | 100k | 150k | 250k |

- **Uniform sampler:** both templates' parameters drawn i.i.d. uniform. Produces almost no pairs near `M = 1` — the region every downstream decision lives in.
- **Diffused sampler:** draw one template uniformly, then draw three partners at small offsets — `σ(λ₀) ∈ {10⁻⁴, 10⁻³}`, `σ(η) ∈ {0.01, 0.02}`, `σ(χ) = 0.01`, hand-tuned "to identify which combination produced the largest number of match values close to 1". This is **hard-positive mining priced against a known metric**: the perturbation scale is chosen so the induced similarity lands in the decision band, which is the quantity augmentation design in self-supervised learning sets blind.
- 2.5M training points were needed for the target accuracy; smaller datasets plateau higher (Fig. 3).

---

## Results

| Measurement | Value |
|---|---|
| Error over the whole manifold | within **3.3%** of the exact match |
| Error for true match > 0.95 | within **1%** |
| Inference | **20 µs** per match (mean maximum, one A100, large batch) |
| Exact calculation | **40 ms** per match (one CPU core, PyCBC — includes generating both templates) |
| Speed-up | ≥ **3 orders of magnitude**, excluding training |

**The break-even ledger, which is the transferable part.** The paper states the up-front costs and declines to combine them; combined, at 40 ms per exact call:

| Item | Cost |
|---|---|
| Generate 3M labelled pairs (train + val + test) | ≈ 33 CPU-hours |
| Train | ≈ 31 GPU-hours |
| Total up-front | ≈ **64 h**, i.e. ≈ 2.3 × 10⁵ s |
| Saving per query | 40 ms − 20 µs ≈ 40 ms |
| **Break-even** | ≈ **5.8M matches**, ≈ 2× the size of the training set |

So amortisation pays here only because the application is a stochastic template bank, where each proposed template is matched against every template already accepted — 10⁵–10⁶ templates per bank, i.e. ≳10¹⁰ matches for one bank. The paper says so plainly: "not a computationally feasible option when only one or two calculations of the match are needed". This is the wiki's only source that writes down both sides of the amortisation trade in the same units.

---

## Limitations

- **The error band straddles the decision threshold.** The stochastic bank algorithm accepts a proposal iff its match to every existing template is < 0.97; the model's 1% band around 0.97 flips accept/reject for a true match in `[0.96, 0.98]`. Accuracy is reported against the *function*, never against the *decision* it feeds — and there is no certificate, the same un-flagged-error hole as [[wiki/entities/neuromatch.md]].
- **No parameterisation covers the manifold.** Uniform in `λ₀` starves the high-mass region; uniform in `(m₁, m₂)` starves the low-mass region. Each choice of chart determines which region a uniform sampler under-covers, and the mass range had to be **constrained by hand** (`M_c ∈ [5, 20] M_☉`) because the high-mass end could not be learned. The right sampling measure is the one induced by the target metric itself, and nobody computes it (gap **G66**).
- **One extra degree of freedom breaks it.** Relaxing `χ₁ = χ₂` to independent aligned spins was attempted first and abandoned: "some areas of the match manifold were learned to a lesser degree of accuracy than desired (or not at all)". The failure is **regional**, not a uniform accuracy drop — exactly the shape amortisation's coverage problem predicts, and exactly the shape that a scalar test-set error hides.
- **Architecture by trial and error.** No principled account of why 5 comparator layers, why ReLU, why the mean rather than another position feature.
- **Never tested against the pipeline.** Integration into template-bank generation or Markov-chain Monte Carlo sampling is proposed throughout and run nowhere; every claimed application is hypothetical.
- **(tentative)** Single application domain, one template family (IMRPhenomXAS), one simulated noise curve, no seed variance reported.

---

## Comparison

| System | Score form | What is cacheable | Evidence on where the work lives |
|---|---|---|---|
| **LearningMatch** | `MLP([f(θ₁), f(θ₂), (θ₁−θ₂)², (θ₁+θ₂)/2])` | The twin encodings, not the score | **Comparator depth matters (5 layers), encoder depth does not** |
| **[[wiki/entities/neuromatch.md]]** | `‖max{0, z_q − z_u}‖²` — a coordinate test, no module at query time | Everything but the comparison | **The opposite:** learned comparators (MLP, neural tensor network) were *less* accurate and 10× slower than the fixed order-embedding form |
| **Two-tower retrieval** ([[wiki/concepts/retrieval-capacity.md]]) | `⟨f(q), g(x)⟩` | Everything but the dot product | Rank-`d` bilinear form ⇒ a hard ceiling on realizable answer sets |
| **Cross-encoder** | `F(q, x)` over the raw pair | Nothing | Solves what every two-tower model fails (LIMIT 100%), at `O(n)` full forward passes |
| **JEPA family** ([[wiki/entities/i-jepa.md]], [[wiki/entities/lejepa.md]]) | Fixed `ℓ₂`/cosine in a shaped space | Everything | LeJEPA argues the *space* should be shaped so the simplest read-out is optimal — the inverse prescription to this page's |

---

## Connections

- **[[wiki/concepts/amortized-inference.md]]** — a fifth thing to amortise, after the posterior, the plan and the latent: a **pairwise function**, compiled from an exact oracle rather than from a generative model, and the wiki's only case where the break-even query count is computable from stated numbers (≈5.8M).
- **[[wiki/concepts/retrieval-capacity.md]]** — occupies the middle of that page's escape-route table: keep the two towers, replace the dot product with a learned head, and the rank-`d` bilinear ceiling stops applying while the encoders stay precomputable — a cheaper exit than a cross-encoder and one nobody has priced.
- **[[wiki/entities/neuromatch.md]]** — the same amortisation with the opposite verdict on where similarity structure should live: NeuroMatch's ablations make the fixed geometric form both faster *and* more accurate than a learned comparator, this page's make the learned comparator the only part that matters ([[wiki/empirical-tensions.md]] T173).
- **[[wiki/entities/lejepa.md]]** — the rival prescription for the same problem: shape the embedding distribution so a simple probe is optimal, rather than growing the probe; the discriminator is whether the target relation is homogeneous over the space.
- **[[wiki/concepts/subgraph-matching.md]]** — the structural version of the same query ("how similar are these two objects?") over a discrete relation with an algebraic property (transitivity of containment) that a geometry can encode exactly; a curved metric has no such property to exploit.
- **[[wiki/concepts/population-geometry.md]]** — the wiki's home for "the geometry of a code is what makes read-outs easy"; this page is the case where the read-out was made hard instead, because the quantity being read out is position-dependent.
- **[[wiki/concepts/energy-based-models.md]]** — a Siamese energy trained by regression onto exact targets rather than by contrast: the label oracle removes the collapse problem entirely, which is what makes it a clean control on the anti-collapse literature.
