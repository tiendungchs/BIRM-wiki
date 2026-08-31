# Transformer

**A sequence transduction model with no recurrence and no convolution: every layer is `softmax(QKᵀ/√d_k)V` run in `h` parallel low-dimensional heads, wrapped in a residual + LayerNorm shell with a position-wise 2-layer MLP, and given order information only by a vector *added* to the content embedding. Its stated justification is not expressivity but **path length** — the number of hops a gradient must travel between two positions, which recurrence makes `O(n)` and self-attention makes `O(1)`.**

> **Provenance.** Vaswani, Shazeer, Parmar, Uszkoreit, Jones, Gomez, Kaiser & Polosukhin 2017, *Attention Is All You Need*, NeurIPS 2017 (`raw/vaswani-2017-attention-is-all-you-need.md`). Body text and all four tables present; **all figures dropped**, including the appendix's attention-head visualisations — so the paper's interpretability claim ("individual heads clearly learn to perform different tasks … syntactic and semantic structure") is held **from one prose sentence only** and should not be cited as evidence here.

Why the wiki holds this page. The Transformer is cited on ~30 pages as a baseline, a backbone or a foil, and its primary source was never ingested. Three things in it are load-bearing and were being carried second-hand:

1. **The founding argument is about credit-assignment distance, not about content addressing** — and the wiki (and the field) has been reading it the other way round for years. Table 1 below is the entire argument.
2. **Position is injected by vector addition into the content space, and the specific code does not matter** (sinusoid vs. learned: 25.8 vs. 25.7 BLEU). The wiki's structural-address pages assume the address is a separate channel; the founding architecture superposes it.
3. **The `d_k` ablation is the wiki's earliest datapoint for [[wiki/concepts/retrieval-capacity.md]]'s head-width bound**, complete with the authors' own conclusion that the dot product is an inadequate compatibility function.

---

## The object

One layer, `d_model = 512` throughout so that residuals type-check:

```
Attention(Q,K,V) = softmax(QKᵀ / √d_k) V
MultiHead(Q,K,V) = Concat(head_1..head_h) W^O,   head_i = Attention(QW_i^Q, KW_i^K, VW_i^V)
FFN(x)           = max(0, xW_1 + b_1) W_2 + b_2
sublayer out     = LayerNorm(x + Sublayer(x))
```

| Component | Base setting | Note |
|---|---|---|
| Encoder / decoder depth | `N = 6` each | decoder has a third sub-layer: cross-attention onto the encoder output |
| Heads | `h = 8`, `d_k = d_v = d_model/h = 64` | total cost ≈ single-head at full width — heads are bought by *splitting*, not by adding |
| Feed-forward | `d_ff = 2048` | position-wise; equivalently two kernel-1 convolutions |
| Positional encoding | `PE(pos,2i) = sin(pos/10000^{2i/d})`, `cos` for odd | wavelengths geometric from `2π` to `10000·2π`; **added** to the embedding |
| Embeddings | shared input/output/pre-softmax matrix, scaled by `√d_model` | |
| Optimiser | Adam, `lrate = d_model^{−0.5}·min(step^{−0.5}, step·warmup^{−1.5})`, `warmup = 4000` | the warmup is not decoration — see Limitations |
| Regularisation | residual dropout 0.1, label smoothing `ε_ls = 0.1` | |

**Three uses of one operator.** Encoder self-attention (all-to-all), decoder self-attention (masked to `j ≤ i` by setting illegal logits to `−∞`, which is what preserves autoregression), and encoder–decoder cross-attention (queries from the decoder, keys and values from the encoder). The last is the only place the *query set and the key set are different objects* — everywhere else the model is scoring a set against itself.

**Why the `1/√d_k`.** For large `d_k` the dot products grow in magnitude and push the softmax into a saturated, small-gradient regime; additive attention (a one-hidden-layer MLP scorer) does not have this problem and outperforms unscaled dot-product attention at large `d_k`. Dot product is kept because it is a matmul. So the scaling factor is a **numerical repair on a compatibility function chosen for hardware reasons** — worth remembering wherever the wiki treats `qᵀk` as a modelling commitment.

---

## The actual argument: Table 1

`n` sequence length, `d` representation dimension, `k` conv kernel width, `r` restricted-attention neighbourhood.

| Layer type | Complexity per layer | Sequential ops | **Maximum path length** |
|---|---|---|---|
| Self-attention | `O(n²·d)` | `O(1)` | **`O(1)`** |
| Recurrent | `O(n·d²)` | `O(n)` | `O(n)` |
| Convolutional | `O(k·n·d²)` | `O(1)` | `O(log_k n)` |
| Self-attention (restricted to `r`) | `O(r·n·d)` | `O(1)` | `O(n/r)` |

The paper's premise, cited to Hochreiter et al. 2001: *the shorter the forward and backward paths between two positions, the easier the dependency is to learn.* Everything else — parallelism, the `n < d` cost regime that makes quadratic attention cheaper than recurrence for sentences, the constant-time global mixing — follows from the third column.

**The paper also names the price of getting there in one hop:** collapsing all positions into one weighted average gives "reduced effective resolution due to averaging attention-weighted positions", and multi-head attention exists to counteract it. So heads are not primarily a capacity device; they are an **anti-averaging device** — a hedge against [[wiki/concepts/representational-collapse.md]] inside a single layer.

---

## Results

| Task | Result | Comparison |
|---|---|---|
| WMT14 EN→DE | **28.4 BLEU** (big) | >2.0 BLEU over the best prior, *including ensembles*; base model 27.3 beats every published model and ensemble |
| WMT14 EN→FR | **41.8 BLEU** (big, Table 2); 41.0 in text | prior best single model 40.46, at >4× the training cost |
| Training cost | `3.3·10¹⁸` FLOPs (base), `2.3·10¹⁹` (big) | GNMT+RL `2.3·10¹⁹` / ConvS2S ensemble `7.7·10¹⁹`; base is ~100× cheaper than the top ensembles |
| Wall clock | 12 h (base) / 3.5 days (big) on 8 P100 | the result that made the architecture spread |
| WSJ constituency parsing, **40K sentences only** | 91.3 F1 | beats BerkeleyParser (90.4) and every prior discriminative WSJ-only model except RNN Grammars (91.7); semi-supervised 92.7 |

The parsing row is the one worth keeping for this wiki. The output is a **linearised tree** — strong structural constraints, output longer than input — and RNN sequence-to-sequence models had specifically failed in this small-data regime. So the architecture's first evidence of transfer beyond translation was a *structured-output* task at 40K examples with no task-specific tuning.

### Ablations (Table 3, EN→DE dev, newstest2013)

| Arm | Setting | BLEU (dev) | Reading |
|---|---|---|---|
| base | `h`=8, `d_k`=64 | 25.8 | |
| (A) heads at **constant compute** | 1 / 4 / 8 / 16 / 32 | 24.9 / 25.5 / 25.8 / 25.8 / 25.4 | **Interior optimum.** One head is 0.9 worse; 32 narrow heads are 0.4 worse. Neither "more parallel reads" nor "wider reads" is monotone |
| (B) key width alone | `d_k` = 16 / 32 / 64 | 25.1 / 25.4 / 25.8 | Narrowing the *scoring* space hurts with `d_v` untouched — the loss is in addressing, not in payload |
| (C) size | `N`=2 / `d_model`=256 / `d_ff`=4096 | 23.7 / 24.5 / 26.2 | bigger is better, dully |
| (D) dropout | 0.0 / 0.1 / 0.2 | 24.6 / 25.8 / 25.5 | 0.0 costs 1.2 BLEU at 65M parameters on 4.5M sentence pairs |
| (E) **learned** positional embeddings | replaces sinusoids | 25.7 | ≈ identical to 25.8 |

The authors' own conclusion from (B): *"determining compatibility is not easy and a more sophisticated compatibility function than dot product may be beneficial."* That sentence has gone essentially unacted-on for eight years, and it is the same limitation [[wiki/concepts/retrieval-capacity.md]] later derives a bound for.

---

## What this changes in the wiki

### 1. The path-length argument is the founding claim, and S4 falsified its strong form

The paper's justification for attention is that `O(1)` path length makes long-range dependencies learnable. [[wiki/entities/s4.md]] is a model with **`O(L)`-deep information flow and a fixed content-independent kernel** that carries a 16,384-step dependency (Path-X 96.35%) where all 11 Transformer variants sit at chance, and beats them on every Long Range Arena task by >20 average points. Short paths are therefore neither necessary nor sufficient for long-range learning ([[wiki/empirical-tensions.md]] T179).

What survives the falsification is the *other* property, the one the paper barely argues for: a read whose target is chosen by the current content. That is what an LTI kernel structurally cannot do and what every wiki page reading attention as retrieval actually depends on ([[wiki/concepts/attention.md]]).

`(brainstorm)` The two properties were bundled by accident of history — the 2017 case was made against RNNs, where content-dependent reads and short paths arrive together. Split apart, the wiki's design space has a fourth cell nobody occupies: **short paths without content-dependent reads** (a global fixed mixing layer — which is what an S4 layer is) and **content-dependent reads without short paths** (a recurrent cell with a learned query, i.e. a gated SSM). The 2017 architecture is the corner that took both and paid `O(n²)`.

### 2. Structural address by superposition, and the code does not matter

The position of a token is a vector **added into the same `d_model` space as its content**, and swapping a hand-designed sinusoidal basis for a freely learned one changes nothing measurable (25.7 vs 25.8). Two consequences for the wiki's `g`/`x` pages:

- The wiki's structural-code pages ([[wiki/concepts/abstract-structural-codes.md]]) treat `g` and `x` as separate factors to be bound; the founding attention architecture keeps them in **linear superposition** in one vector and lets each head's `W^Q`/`W^K` projections pull out whichever component it needs. That is a *fourth* binding option next to conjunction, factorisation and slotting, and it works only because the read is a learned linear projection before the score.
- **Which** basis carries the address is not the interesting variable — that it is a *smooth, translation-linear* one is. The paper's stated reason for the sinusoid is that `PE_{pos+k}` is a linear function of `PE_pos` for fixed `k`, i.e. relative displacement is a linear operator on the code. That is the same commutative-displacement property [[wiki/concepts/path-integration.md]] and [[wiki/concepts/abstract-structural-codes.md]] name as the mechanism for path consistency (G3) — here on a 1-D chain, with the extrapolation hope stated and never tested in the paper.

### 3. Heads are an anti-averaging device with a measured interior optimum

Row (A) is the wiki's cleanest statement that the number of parallel read channels is a *tuned* quantity at fixed compute, not a monotone resource: 1 head loses 0.9 BLEU to averaging, 32 heads lose 0.4 to `d_k = 16`. The trade is exactly the two capacity models the wiki holds — the softmax's occupancy dilution ([[wiki/concepts/attention.md]], row entropy) is relieved by adding heads, and the head-width bound ([[wiki/concepts/retrieval-capacity.md]], `C(n,k) ≤ (1+1/γ)^{d_k}`) is tightened by it. **The optimum is where those two curves cross**, which is a prediction neither page had a second axis for and which nothing in the wiki has measured deliberately.

### 4. What the architecture does *not* have

The wiki keeps discovering that transformers lack a persistent controller state, and this page is where that is architecturally explicit: there is no register anywhere in the layer stack. The query is recomputed from the current token at every step, the KV cache is append-only and never rewritten, and the only state that survives a step is the tokens themselves. Compare the biology on [[wiki/concepts/attention.md]] — a template held through an 800 ms delay *and across saccades that replace the entire input* — and the gap is not a matter of degree.

### 5. Early layers softly specialise in local processing — measured, in a trained model

The architecture gives every layer the same `O(1)` reach over the whole context. It does not use it uniformly. Nanda et al. 2023 (`raw/nanda-2023-fact-finding-5-early-layers.md`) take Pythia 2.8B on Pile text, recompute each token's residual stream with the prompt **truncated** to the most recent `k ∈ [1,10]` tokens (plus a BOS token, so that attention heads keep their resting position), subtract the per-layer mean residual, and take the cosine similarity with the full-context residual.

| Finding | Detail |
|---|---|
| **Early layers are near-local, late layers are not** | With `k = 5`, cosine similarity is high in early layers and falls gradually from layer 0 to ~10, then plateaus. It is never 1, so the specialisation is **soft** — some prior context is admitted from the first layer |
| **Not a trivial consequence of residual dominance** | `k = 5` is much closer to full context than `k = 1` already *after layer 0*, so the layers are genuinely integrating nearby tokens rather than leaving the current-token embedding untouched |
| **Locality is token-class dependent, and the split is large** | After layer 0 with `k = 10`: word fragments and ordinary alphabetic tokens are extremely local; punctuation is substantially non-local; common function words (`the`, `of`, `they`, …) and residual "other" tokens are notably non-local |
| **An uptick in the final layer** | Long-range content is *removed* at the end. The authors' reading: a residual stream serves both the literal next token and future tokens, and the last layer discards the latter |

Squared cosine similarity is the usable intuition: 0.9 means ~81% of the residual's norm is shared with the truncated version.

**A sharper version of the same specialisation, measured causally on one task.** On Pythia 2.8B's athlete→sport recall, mean-ablating **every attention output from layer 2 onward** at the name position costs little accuracy, while layers 0–1 carry far more heads with significant total effect (Rajamanoharan et al. 2023, `raw/rajamanoharan-2023-fact-finding-2-circuit.md`). So for this task the architecture's uniform all-to-all reach is used in a strictly two-phase schedule: cross-token movement happens in the first two layers, and the next five layers are a **pure MLP stack with skip connections** that never looks at another position. Two consequences for the architecture page. (i) The `O(1)`-path-length property that motivates the design is being spent, at least here, on a *fixed short-range gather* that a much cheaper mechanism could implement — the depth-vs-reach division of labour is not just soft, it is locally degenerate. (ii) It gives the locality result above a causal complement: post 5 shows early residual streams *depend* mostly on nearby tokens, post 2 shows the later layers of an early circuit do not need attention at all.

**Two things this adds to the architecture page.** First, **depth is a soft proxy for context radius in a trained transformer**, with no mechanism enforcing it — the layer stack discovers a division of labour the design does not encode, which is why "the first 10–20% of layers" is a usable heuristic for locating detokenization and why a multi-token entity's "embedding" is assembled before any long-range circuitry runs. Second, **the unit of locality is the token class, not the layer**: a comma and a word fragment at the same depth are doing computations with radii differing by an order of magnitude, so any claim of the form "layer `L` is local" is an average over a bimodal population. `(brainstorm)` The proposed causes are all consequences of the tokeniser and of the [summarisation motif](https://arxiv.org/abs/2310.15154) — fragments must be detokenized before long-range work is worth doing, punctuation carries clause-level summaries, pronouns track entities — which makes context radius a property of the *input format* rather than of the architecture. A model with a semantically clean input alphabet should show a flatter curve, and nobody has run that control.

---

## Comparison

| | **Transformer** | [[wiki/entities/s4.md]] | [[wiki/entities/ltc.md]] | [[wiki/entities/differentiable-neural-computer.md]] |
|---|---|---|---|---|
| State across steps | **none** (context re-scored per step) | `N`-dim linear state | `N`-dim continuous state | external memory matrix + link matrix |
| Read target chosen by | **current content** (`qᵀk`) | fixed kernel | fixed (rate is content-set) | content, *and* write-order traversal |
| Path length between positions | **`O(1)`** | `O(L)` through the recurrence | `O(L)` | `O(1)` via addressing |
| Training | parallel, `O(n²d)` | parallel (FFT), `Õ(N+L)` | BPTT + stiff solver | BPTT |
| Inference per step | `O(L²H + H²L)`, cache grows in `L` | `O(H²)`, constant memory | `O(N·p)` | `O(N·M)` |
| Order information | added positional vector | intrinsic to the recurrence | intrinsic (continuous time) | write-order link matrix |
| Long range measured | fails at 16,384 (all variants at chance) | **96.35%** | conceded no | untested at length |
| Writes | **none** | none | state update | explicit, gated, erasable |

---

## Limitations

| Limitation | Consequence |
|---|---|
| **`O(n²·d)` per layer** | The paper concedes it and proposes restricted attention (`r`-neighbourhood, path length `O(n/r)`) as future work — i.e. the efficient-attention literature is pre-announced in §4 and the `O(1)` path length is the first thing it gives back |
| **No state, no writes** | Nothing persists across a step except the token sequence; there is no variable to bind and no slot to overwrite |
| **Dot-product compatibility conceded inadequate** | By the authors, from ablation (B), with no proposed replacement |
| **The interpretability claim is one sentence and the figures are gone** | "Individual attention heads clearly learn to perform different tasks" is asserted with the appendix visualisations dropped from this extract; the wiki should source head-level claims from [[wiki/entities/maze-solving-transformers.md]] or [[wiki/entities/othellogpt.md]], which ran causal instruments |
| **Optimisation is fragile enough to need a bespoke schedule** | 4000 warmup steps and an inverse-square-root decay, presented without justification; the architecture does not train under plain Adam |
| **Label smoothing trades the objective against the metric** | Explicitly: it *hurts perplexity* — the quantity being optimised — and improves BLEU and accuracy. A small, clean instance of [[wiki/concepts/objective-identifiability.md]]'s problem in a paper nobody reads that way |
| **Text only, ≤ ~100 tokens** | Both translation datasets are sentence-level; nothing here supports the long-context claims later attached to the architecture |
| **No abstract reasoning task** | Parsing is the closest, and it is a supervised structured-output task with a fixed grammar, not a novel-rule task |
| **Compositional generalisation is the weakest facet, and it is not fixed by winning the task** | On PCFG SET the Transformer beats both an LSTM and a convolutional seq2seq on 6 of 7 measures — and its 0.92 sequence accuracy sits above 0.72 systematicity (held-out function pairs), 0.50 productivity (longer sequences), 0.54 localism (feeding it its own intermediate results) and 0.34 error-consistency under synonym substitution. Attention buys recombination and synonymy far more than it buys length extrapolation or parse-tree traversal; the one facet where it loses is **localism**, to the convolutional model whose operator is local by construction (Hupkes et al. 2020, [[wiki/entities/pcfg-set.md]]) |
| **Two internal numeric mismatches** | EN→FR is 41.0 in the text and 41.8 in Table 2; the parsing text says "better than all previously reported models except RNN Grammars" while Table 4 also lists three multi-task/semi-supervised entries at or above the WSJ-only Transformer. Cite with the table specified |

---

## Connections

- **[[wiki/entities/pcfg-set.md]]** — scores this architecture on five separately failable facets of compositionality rather than on one accuracy: best of three on almost all of them, and still at 0.50 productivity and 0.54 localism, with the local-operator convolutional model beating it on exactly the facet that asks about locality.
- **[[wiki/concepts/attention.md]]** — the primary source for that page's central operator, and it reframes it: `softmax(QKᵀ/√d_k)V` was introduced as a **path-length** device (Table 1: `O(1)` vs recurrence's `O(n)`), with content-addressable retrieval — the property the wiki actually uses it for — never argued for in the paper; multi-head is introduced as a repair for the resolution lost to averaging, not as extra capacity; and the `1/√d_k` is a numerical patch for softmax saturation, so the softmax's occupancy limit is present in the architecture from the first page.
- **[[wiki/concepts/retrieval-capacity.md]]** — the earliest measurement of that page's bound, from the architecture that made the read ubiquitous: at constant `d_v` and constant total compute, narrowing the *scoring* dimension alone costs 0.7 BLEU (`d_k` 64 → 16), and the authors conclude that dot-product compatibility itself may be insufficient — which is exactly the factorised-bilinear-form limitation the theorem later prices.
- **[[wiki/entities/s4.md]]** — the direct rebuttal of this page's founding argument: `O(1)` path length is presented here as the reason long-range dependencies are learnable, and a fixed content-independent convolution with `O(L)`-deep flow carries 16,384 steps where every Transformer variant is at chance (T179); read together, the two isolate content-dependent reading — not path length — as attention's irreducible function.
- **[[wiki/entities/ms-ssm.md]]** — supplies the instrument this paper's Table 1 lacked: maximum path length is a *worst-case* graph property of the architecture, where the mean mixing distance is the realised receptive field of a trained model, and it is computable for attentional and non-attentional layers alike; it also splits input-dependence into selection over positions (what this architecture does, ListOps 36.37) and selection over timescales (which beats it by ~25 points).
- **[[wiki/concepts/abstract-structural-codes.md]]** — the founding architecture's answer to `g` vs `x`, and it is the option that page does not list: the structural address is a vector **added into the content vector**, recovered per head by a learned linear projection before scoring, and the specific basis is empirically irrelevant (learned 25.7 vs sinusoidal 25.8) — what matters is that displacement acts linearly on the code.
- **[[wiki/concepts/path-integration.md]]** — the stated design rationale for sinusoidal positions is that `PE_{pos+k}` is a linear function of `PE_pos` for every fixed offset `k`, i.e. relative displacement is a linear operator and offsets compose additively — a 1-D chain instance of this page's commutative-update mechanism, arrived at for engineering reasons and with its extrapolation hope untested.
- **[[wiki/entities/tem-transformer.md]]** — the derivation of this page's operator from a memory: self-attention is recovered as one read of a Hebbian associative store with structural addresses in the keys, which turns the added positional vector here into a path-integrated `g` and the arbitrary `h = 8` into a modelling choice with a substrate.
- **[[wiki/entities/maze-solving-transformers.md]]** — the causal, head-level interpretability this paper asserts and does not show: a head placing its mass on tokens at path-length 1 is the measured version of "individual heads learn to perform different tasks", obtained with direct logit attribution rather than by inspecting attention maps.
- **[[wiki/entities/othellogpt.md]]** — the other causal reading of the same layer, and the one that inverts it: `Emb[m] @ V @ O` shows first-layer heads *writing* "this square is played" into every position, so an attention head is a broadcast as much as a read — a use of the operator this paper never describes.
- **[[wiki/concepts/representational-collapse.md]]** — the paper's own reason for multi-head attention: a single head's weighted average over positions gives "reduced effective resolution", so heads are an anti-averaging device, and row (A)'s interior optimum (1 head −0.9 BLEU, 32 heads −0.4) is a collapse/addressability trade measured at constant compute.
- **[[wiki/concepts/working-memory.md]]** — the negative case in its sharpest form: there is no register anywhere in the stack, the query is recomputed from the current token every step, and the cache is append-only and never rewritten — so a Transformer has a growing verbatim log and no maintained variable, which is the distinction S4's long-range result forces the wiki to keep separate from horizon length.
- **[[wiki/concepts/objective-identifiability.md]]** — a small clean instance in an unexpected place: label smoothing is adopted *because* it improves BLEU and accuracy while explicitly worsening the perplexity being optimised, so the shipped model is not the minimiser of its own loss.
- **[[wiki/entities/cfc.md]]** — the efficiency case against this architecture on irregularly sampled physical data (+18% for CfC on Walker2D, `O(K̃)` vs quadratic), with its authors conceding language modelling to attention — the discriminator being data type, not sequence length.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the contemporaneous architecture that kept everything this one dropped: an addressable memory that is written, erased and traversed by write-order links, against a model whose only memory is the input itself.
- **[[wiki/entities/autotom.md]]** — this architecture used as five separate estimators inside a Bayes net (information extractor, structure proposer, world model, hypothesis sampler, local-conditional oracle) rather than as an answerer: 44.0 → 83.0 on MMToM-QA for the same weights, and four different backends indistinguishable unscaffolded (34.8–45.0) spread over 15.5 points once the scaffold consumes their likelihood estimates.
- **[[wiki/entities/mlc.md]]** — this architecture used unmodified at 1.4M parameters, and the measurement that its compositional ceiling belongs to the training distribution rather than to attention: 0% exact match on a systematic-generalization task when trained on a static corpus, 100% on the same task after meta-training over a stream of latent grammars.
- **[[wiki/concepts/test-time-training.md]]** — the substrate modification this architecture needs for grid reasoning, and it is not in the training loop: 2D attention and 2D positional encodings in place of the 1D sequence assumption, which is what the ARC Prize 2024 test-time-training entries converged on (Chollet et al. 2024).
- **[[wiki/concepts/refinement-loop.md]]** — the substrate for the LLM-driven variants and, in the harness case, the object being refined while frozen: +23 points on ARC-AGI-2 from application-layer code that never touches the weights, which locates the 2025 gain outside the architecture entirely.
- **[[wiki/entities/poe-arc-solver.md]]** — the autoregressive factorization named as a *causal* defect rather than a design choice: a left-to-right decoder must commit to the first output cell before computing what determines it, then conditions on its own error, and the repair applied is external (re-score the finished answer under 16 problem transformations and take the product) rather than architectural.
- **[[wiki/concepts/memorisation-vs-generalisation.md]]** — what this architecture's MLP sublayers turn out to be doing in the one case where a subnetwork was isolated and probed to exhaustion: five consecutive `FFN` blocks implementing a name→attribute lookup that resisted circuit decomposition entirely, plus the measurement that they break the residual stream's additive structure two to three times harder than shuffled weights would, and the locality result of section 5 above.
- **[[wiki/concepts/multi-token-embedding.md]]** — a three-stage division of labour across depth that the architecture does not encode and gradient descent nevertheless produced: attention layers 0–1 sum the tokens of a name onto its last token, MLPs 2–6 convert that sum into an entity representation, and a sparse set of mid-to-late heads project one attribute out of it — with only the middle stage resisting interpretation — and, causally, the two phases are *sequential*: ablating attention from layer 2 on leaves the task nearly intact, so the middle stage is a pure MLP stack that never reads another position.
- **[[wiki/concepts/sparse-expert-routing.md]]** — where conditional parameters can be inserted into this architecture, and where they cannot: sparse expert layers substitute for the feed-forward block at a frequency of 0.25–1.0 (0.5 is the convention) with large wall-clock gains, while the same substitution on the `q`/`k`/`v` projections was found materially more unstable — so the position-wise block is the separable component and the attention projections are not (Fedus, Dean & Zoph 2022).
- **[[wiki/entities/neural-module-networks.md]]** — the immediately preceding attempt at the same job, and the inventory of what this architecture dropped: per-input computation graphs, typed modules with arity, and heterogeneous parameter blocks — replaced by one dense learned adjacency recomputed at every layer, which is why compositional depth extrapolation is guaranteed by a type check there and only hoped for here.
- **[[wiki/entities/sparsely-gated-moe.md]]** — the conditional-parameter layer this architecture later absorbed, and evidence that it is not a Transformer idea: the original sits between stacked LSTM layers and is applied *convolutionally* over positions, so what the Transformer supplied was a position-wise block of the right shape to substitute for, not the mechanism.
- **[[wiki/entities/switch-transformer.md]]** — the primary source for the previous entry, and it makes the attention result sharper than the survey does: replacing the `q`/`k`/`v` weight matrices with expert layers *improves* quality (−1.513 vs −1.548 negative log perplexity for FFN-experts alone) and diverges only under bfloat16, so conditional parameters inside attention are blocked by numerics rather than by the architecture, and the position-wise block is the convenient site rather than the only viable one.
