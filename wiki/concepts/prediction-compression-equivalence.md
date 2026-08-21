# Prediction–Compression Equivalence

**Minimising log-loss *is* minimising code length: arithmetic coding turns any next-symbol predictor into a lossless compressor, and any lossless compressor into a next-symbol predictor — so every model in this wiki already has a compression rate, and that rate is a measurable stand-in for how much structure the model found.**

The value of the identity here is instrumental. `K(µ)` on [[wiki/concepts/universal-induction.md]] is the uncomputable ceiling; the compression rate of an actual model is a *computed* number on the same axis, obtainable for any predictor, on any byte stream, with no task authoring and no labels.

> **Provenance.** Formalism and all quantitative results from Delétang et al. 2023 (Google DeepMind), which evaluates offline in-context compression of enwik9, ImageNet patches and LibriSpeech (1 GB each, chunked to 2048 bytes).

---

## The identity

| Direction | Construction | Cost |
|---|---|---|
| **Predictor → compressor** | Arithmetic coding: recursively split `[0,1)` by `ρ̂(x_k \| x_<k)`, emit the shortest binary `λ` in the final interval | Code length `−⌈log₂ ρ̂(x_1:n)⌉ + 1` bits; `O(n2^−B)` extra at `B`-bit precision (negligible at 32/64 bit) |
| **Compressor → predictor** | `ρ̂(x_i \| x_<i) = 2^{ℓ_c(x_<i) − ℓ_c(x_<i x_i)}` — query the compressor once per candidate symbol, renormalise | `\|X\|` compressor calls per symbol; biased for dictionary coders (gzip's multi-byte tokens are invisible to a one-step-ahead query) |
| **Optimum** | Source coding theorem: `L ≥ H(ρ)`; with a model `ρ̂` the expected length is the cross-entropy `H(ρ, ρ̂) = E_{x∼ρ}[Σ_i −log₂ ρ̂(x_i \| x_<i)]` | Exactly the log-loss used to train every foundation model — **current language-model training is a maximum-compression objective, unmodified** |
| **Limit case** | Set `ℓ_c = K` (Kolmogorov complexity) and the induced predictor *is* Solomonoff's | Uncomputable; this is the top of [[wiki/concepts/universal-induction.md]] |

Consequence for the wiki's slot table ([[wiki/concepts/three-component-framework.md]]): the objective slot is not empty by default — it is silently filled with *code length*, for every autoregressive model, whether or not the designer meant to choose it.

---

## Evidence: compression rates (compressed / raw, %, lower is better)

Chunked to 2048 bytes for all rows so the context budgets match; `∞` rows are the classical compressors run unchunked.

| Compressor | enwik9 | ImageNet | LibriSpeech | Random |
|---|---|---|---|---|
| gzip (∞ / 2048) | 32.3 / 48.1 | 70.7 / 68.6 | 36.4 / 38.5 | 100.0 / 100.1 |
| LZMA2 (∞) | 23.0 | 57.9 | 29.9 | 100.0 |
| PNG (∞) | 42.9 | **58.5** | 32.2 | 100.0 |
| FLAC (2048) | 88.9 | 60.9 | **30.3** | 107.2 |
| Transformer 3.2 M *(trained on enwik8)* | **17.0** | 215.8 | 228.2 | 224.0 |
| Chinchilla 1 B | 11.3 | 62.2 | 24.9 | 108.8 |
| Chinchilla 70 B | **8.3** | **48.0** | **21.0** | 100.8 |
| Llama 2 7 B | 8.9 | 53.4 | 23.1 | 103.2 |

Four readings that matter for building a reasoning model:

- **A text model beats the domain-specific codecs on image and audio.** Chinchilla 70 B, trained on internet text and books, compresses ImageNet patches to 48.0% (PNG: 58.5%) and speech to 21.0% (FLAC: 30.3%). Whatever it holds is not text-specific — it is modality-general sequence structure, applied to byte streams it was never trained on. This is the wiki's first *quantitative* measurement of far transfer that required no benchmark to be authored.
- **Generality is a property of scale, not of the architecture.** The same architecture at 3.2 M parameters trained on enwik8 reaches 17.0% on text and **expands** image and audio (215.8%, 228.2% — worse than storing the raw bytes). Specialisation to the training modality is the default; cross-modal compression appears only with size and data diversity.
- **The random column is the sanity check.** Every neural model sits at ~100–108% on incompressible data, i.e. it does not hallucinate structure that is not there. The overhead above 100% is the price of being wrong about a uniform source.
- **Compression rate is directly comparable across systems that share no task.** No labels, no prompts, no scoring rubric — one number per (model, byte stream) pair. Contrast the instrument problem on [[wiki/concepts/skill-acquisition-efficiency.md]] (gaps G17/G31), where the target quantity is uncomputable and the benchmark must be hand-authored and kept from the developer.

---

## The two-part code: paying for your own parameters

Raw compression rate ignores that the decoder needs the model. The **adjusted** rate counts parameters (float16, 2 bytes each) as part of the compressed output — a two-part code, i.e. minimum description length applied to the model itself.

| Model | Raw (enwik9) | Adjusted (enwik9) |
|---|---|---|
| gzip | 32.3 | 32.3 |
| Transformer 3.2 M | 17.0 | 17.7 |
| Chinchilla 1 B | 11.3 | 211.3 |
| Chinchilla 70 B | 8.3 | **14008.3** |

- Parameters are themselves nearly incompressible: gzip and LZMA2 reach only 92.2% and 89.1% on a 38 M-parameter Transformer's float16 weights. There is no cheap fix by post-hoc compression of the model.
- **Every dataset has an optimal model size, and scaling past it makes the adjusted rate worse.** Scaling laws hold for the log-loss term but not for the total code length: the parameter term is a constant that only a larger corpus can amortise. Foundation models would need corpora in the terabytes before their adjusted rate becomes non-trivial.
- The alternative accounting is **prequential (online) coding**: charge the *training script* rather than the parameters, and train the model on the stream being compressed. Overparametrised networks do better under this accounting — but encoder and decoder must both run training, which is why it was not evaluated here.

**Why the wiki should carry the adjusted number and not the raw one.** The compactness argument on [[wiki/concepts/three-component-framework.md]] (the genome bottleneck: the *design* must be short, the environment may be arbitrarily rich) is the same two-part code with the split placed differently — design in part one, experience in part two. Under the paper's split (parameters in part one) today's models fail catastrophically; under the genome split they are not scored at all, because nobody counts the description length of the training pipeline. **(brainstorm)** The right instrument for a brain-inspired model is a *third* split: charge the architecture + learning rule + objective (the genome), charge nothing for the parameters (the lifetime), and measure code length on a held-out environment family. A meta-graph that transfers is exactly a short part-one code that keeps part two small across instances — which is [[wiki/concepts/latent-graph-discovery.md]]'s two-level hierarchy stated as a coding problem, and the constrained-description-length candidate gap G26 asks for.

---

## In-context compression is meta-learning, measured in bits

The offline setting fixes the parameters and compresses each 2048-byte chunk with no history and no gradient step. All compression beyond the model's marginal statistics is therefore in-context.

- **Compression rate falls monotonically with position in the sequence**, for Chinchilla, for the small enwik8 Transformer, and for gzip — the model is acquiring the chunk's statistics inside the forward pass. The *slope* of that curve is a per-model, per-modality measure of in-context learning rate.
- The paper's own framing: foundation models "achieve their impressive compression performance by conditioning a (meta-)trained model to a particular task at hand via in-context learning". This is [[wiki/concepts/meta-learning.md]]'s outer/inner loop with the inner loop's output priced in bits.
- **Classical and neural compressors sit at opposite corners of the same trade.** gzip: kilobytes of program, 32 kB of context, no adaptation beyond a dictionary. Chinchilla: hundreds of GB of parameters, 2 kB of context, heavy adaptation inside it. The wiki's slow-**W** / fast-**M** split is this trade-off — and the neural corner has bought its fast level by making the slow level enormous.
- **Context length is the hard capacity bound on the fast level.** A Transformer compresses only a few kilobytes at a time; algorithmic reasoning and long-term memory need long contexts, which is exactly where these models are known not to generalise. An in-context inner loop cannot be the whole answer to fast **M** while its store is a fixed byte budget with quadratic cost ([[wiki/concepts/working-memory.md]], gap G14 — nothing consolidates what the context learned into the parameters). And the *usable* bound is below the byte budget: on `N`-back tasks whose whole sequence fits in 24 tokens, accuracy still falls logarithmically with the retrieval offset, because the limit is the dispersion of the attention read rather than the length of the store (Gong & Zhang 2024; [[wiki/concepts/attention.md]]).

**(brainstorm)** Compression-rate-vs-position is the cheapest usable proxy in the wiki for skill-acquisition efficiency: it is the conversion rate from experience (bytes seen in context) into skill (bits saved per byte), computable for any model on any stream. What it cannot do is separate a recovered structural rule from a well-fitted surface statistic — the same blindness as every other i.i.d. measurement (gap G17). Its honest use is as a *necessary condition*: a model whose in-context curve is flat on a structured stream has found nothing, whatever it scores on a benchmark.

---

## Tokenization is pre-compression

Transformers are trained on tokens, so a tokenizer is a lossless pre-compressor sitting in front of the model, and it changes what the model's objective is computed over.

| Effect | Direction |
|---|---|
| Larger vocabulary | Shorter sequence ⇒ more information inside a fixed context window; and fewer steps, which matters because attention is quadratic and long-context generalisation is poor |
| Larger vocabulary | Harder prediction problem: lowering the entropy of `ρ(x_i \| x_<i)` gets harder as the alphabet grows |
| Net, small models | Bigger vocabulary **helps** compression (context budget is the binding constraint) |
| Net, large models | Bigger vocabulary **hurts** compression (prediction difficulty is the binding constraint) |

In theory the two effects cancel exactly, since the tokenization is lossless; in practice they do not, and which one wins is a function of model size. Two consequences: (i) any comparison of models across tokenizers is confounded, and (ii) the discretisation gap G27 — where nodes come from — has a measurable version here, because a token vocabulary *is* a hand-chosen discretisation of the stream and its cost is visible in bits.

---

## Compressors as generative models

Running the identity backwards makes gzip a conditional generative model: sample `x_i ∼ 2^{ℓ_c(x_<i) − ℓ_c(x_<i x_i)}` and append. Conditioned on the first 250 pixels of each ImageNet row, Chinchilla 70 B produces visually plausible continuations that degrade as autoregressive error accumulates; gzip produces noise. Two caveats the paper states:

- A good compression rate carries **no guarantee** of good autoregressive samples; the empirical correlation between lower log-loss and better generation is all there is.
- One-step-ahead sampling is biased for dictionary compressors, whose gains live in multi-byte tokens — the bias is in the sampling procedure, not in the compressor.

This is the cleanest available demonstration that "understanding" claims and "compresses well" claims are not interchangeable in the direction people usually want them: the mapping compressor → generator is *defined*, but its quality is unbounded by the compression rate.

---

## What this does and does not settle for the framing

| Claim | Status after this source |
|---|---|
| Learnability = compressibility | **Reinforced, and now measurable.** The uncomputable `K(µ)` bound has a computable shadow: a model's rate on a stream |
| Compression ⇒ generalization | **Supported in the aggregate** (the paper's rationale, following the Hutter Prize framing), **and confounded by the parameter term**: only the adjusted rate is a generalization claim, and no neural model wins on it |
| Compression ⇒ *structure* | **Unchanged, and sharpened (gap G26).** Chinchilla compresses ImageNet better than PNG while having no object model, no depth, no 2-D adjacency — the patches were flattened, so even row-to-row correlation was destroyed. Excellent code length coexists with the absence of the graph the wiki wants |
| Scaling is the route to generality | **Bounded.** Larger models compress better raw and worse adjusted; the optimal size is set by the corpus, so "scale it up" is not a free move once the model counts as part of the answer |

---

## Open problems

- **The rate does not decompose.** No procedure attributes a model's saved bits to memorised marginals vs. in-context adaptation vs. recovered structure. Without that decomposition the instrument measures the sum of what the wiki wants to distinguish.
- **Adjusted rate has no fair split for a learner.** Parameters-in-part-one is the strict reading and kills every neural model; script-in-part-one (prequential) requires training during decoding. Neither corresponds to the genome-bottleneck accounting the wiki actually cares about.
- **Context length is the binding constraint on in-context compression** and no result here extends it; the paper names long-context extension as the open engineering problem.
- **Cross-modal compression is unexplained.** *Why* a text model models speech bytes better than FLAC is not answered — shared low-level statistics, a genuinely modality-general sequence prior, or contamination are all live, and the paper only rules contamination unlikely.

---

## Connections

- **[[wiki/concepts/universal-induction.md]]** — the computable shadow of that page's ceiling: set `ℓ_c = K` and the compressor-induced predictor is Solomonoff's, so every measured compression rate is a lower-bounded distance from the ideal inductor.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the antagonist made empirical: this page's models are near-optimal compressors of their curricula, which is exactly the object Chollet argues discards what evaluation needs ([[wiki/empirical-tensions.md]] T16), and the in-context rate curve is a computable proxy for the conversion rate that page cannot compute.
- **[[wiki/concepts/three-component-framework.md]]** — identifies what is already in the objective slot: autoregressive log-loss *is* minimum code length, and the adjusted rate is the same two-part code the genome-bottleneck argument uses with the design/parameter split moved.
- **[[wiki/concepts/meta-learning.md]]** — offline compression with frozen parameters is an inner loop with no weight update, and its bits-saved-per-position curve is the first quantitative readout of one in the wiki.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the sharpest counterexample to "compress and the graph appears": world-class code length on flattened image patches with no object, depth or adjacency structure recovered (gap G26).
- **[[wiki/concepts/working-memory.md]]** — prices the fast level: an in-context store is a fixed byte budget with quadratic cost, and compression rate vs. sequence length is a direct measurement of what that store buys.
- **[[wiki/concepts/amortized-inference.md]]** — the parameter term is amortisation made visible: hundreds of GB of weights are a cached, up-front payment that only a terabyte-scale stream repays.
- **[[wiki/entities/aixi.md]]** — the same identity at the ideal end: expectimax over `ξ` is what the compressor→predictor construction converges to when the compressor is optimal, and it inherits the same structure-blindness.
- **[[wiki/concepts/energy-based-models.md]]** — the discrete counterpart of latent-capacity regularisation: bounding a latent's information content and charging a model for its own parameters are the same description-length move in two representations.
- **[[wiki/concepts/event-segmentation.md]]** — tokenization is the engineered version of the discretisation problem (gap G27), and this page prices a vocabulary choice in bits: more tokens helps small models and hurts large ones.
- **[[wiki/concepts/intelligence-density.md]]** — the stated dual of this page: code length asks how few bits describe a stream, `ℐ = log₂N/C` asks how many independent outputs a fixed description generates, and the two face the same incomputable `K` from opposite sides (Choi 2026).
- **[[wiki/concepts/divergence-objectives.md]]** — the same identity in probability units rather than bits: the log-loss trained here *is* `H(P,Q)`, and the excess over the source-coding floor `H(P)` is `KL(P‖Q)`, so a compression rate and a divergence are one number twice.
- **[[wiki/concepts/representation-probing.md]]** — the outside-in / inside-out pair: code length says how much structure a model exploited without naming it, a probe names a structure without showing it was used, and gap G26 sits between them.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — a prediction objective is what a local inverse-based rule needs to work at all: target propagation is bottlenecked by the entropy of its output target, so a 1-hot label starves it and a next-state or reconstruction target does not (Bartunov et al. 2018).
- **[[wiki/concepts/attention.md]]** — prices the fast level's store from the read side rather than the length side: within a context that comfortably holds the sequence, retrieval accuracy still decays with offset and tracks the entropy of the attention matrix, so the byte budget is an upper bound on capacity and not the operative one (Gong & Zhang 2024).
- **[[wiki/entities/pfc-columnar-planning-model.md]]** — this page's criterion arrived at by simulation: a place-code compression cascade is run until retained task-relevant information starts falling (~85% of the bound), and the stage past that point is demonstrably unable to plan on its own (Martinet et al. 2011).
- **[[wiki/entities/hisd.md]]** — the equivalence applied to action streams: the task hierarchy is a by-product of losslessly compressing a corpus of behaviour, so "better decomposition" and "shorter description of the demonstrations" are one objective, with the number of unique parse trees as the readout — 9 against a ground truth of 9 where compression succeeds, 500 against 293 where it fails (Harvey et al. 2026).
- **[[wiki/concepts/learned-world-models.md]]** — where the stand-in fails: prediction error is reported not to order world models by downstream control performance, so log-loss measures structure found without measuring structure *usable*, which is the wiki's first named limit on this page's proxy ([[wiki/empirical-tensions.md]] T144, gap G62).
- **[[wiki/entities/gcq.md]]** — compression as the mechanism rather than as a diagnostic: an `n`-frame observation–action sequence is represented by `m` integers given the actions, because the rest of the trajectory is regenerated by the codebook's own dynamics — so the tokeniser and the world model are literally the same object.
- **[[wiki/entities/i-jepa.md]]** — the boundary of this page's identity: a JEPA regresses onto a *learned, moving* target, so its loss is not a code length of anything and the compression stand-in for "how much structure was found" is unavailable to the family the wiki is most interested in — while its own ablation shows why the family wants that (pixel targets, which *do* have a code length, lose 26.2 points).
- **[[wiki/entities/s4.md]]** — the constant-memory end of the same trade: the recurrent view holds the entire past in an `N`-dimensional coefficient vector — a HiPPO projection of the input history onto an orthogonal polynomial basis — and generates at `O(H²)` per token against a Transformer's exact but linearly-growing cache (60× faster on WikiText-103, within 0.8 perplexity). The compression is lossy by construction and its loss profile is fixed by the choice of basis rather than by any learned criterion (Gu et al. 2022).
- **[[wiki/concepts/refinement-loop.md]]** — the equivalence used as a solver rather than as an analysis: CompressARC minimizes the description length of a *single* ARC task at test time with 76K randomly-initialised parameters, no pretraining, no dataset and no search, reaching 20% on ARC-AGI-1 — the wiki's first non-trivial score whose two-part code it could actually afford to pay.
