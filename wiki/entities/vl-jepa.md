# VL-JEPA (Joint Embedding Predictive Architecture for Vision–Language)

**A JEPA whose prediction target is a *sentence embedding*: a frozen video encoder and a query-conditioned predictor learn `⟨S_V, X_Q⟩ ↦ Ŝ_Y`, where `S_Y` is a jointly-trained text encoder's embedding of the answer — so language enters as the space the model predicts *into*, never as tokens it must emit, and a decoder is invoked only when a human needs to read the answer.**

> **Provenance.** Chen, Shukor, Moutakanni, Chung, Yu, Kasarla, Bang, Bolourchi, LeCun & Fung, *VL-JEPA: Joint Embedding Predictive Architecture for Vision-language*, arXiv:2512.10942v2, 2025 (`raw/chen-2025-vl-jepa.md`). Meta FAIR + HKUST + Sorbonne + NYU. Claims that go beyond the source are marked `(brainstorm)`.

This is the wiki's first JEPA where the two branches are in **different modalities and the target branch is trained**. Every earlier entry — [[wiki/entities/i-jepa.md]], [[wiki/entities/v-jepa-2.md]], [[wiki/entities/lewm.md]], [[wiki/entities/hit-jepa.md]] — predicts one part of an input from another part of the same input, with the target branch either an EMA copy of the online branch or frozen. Here the target branch is a **separate pretrained network in another modality with its own learning rate**, and the paper measures what that learning rate should be.

---

## Architecture

| Component | Instantiation | Parameters | Trained? |
|---|---|---|---|
| **X-Encoder** `X_V ↦ S_V` | V-JEPA 2 ViT-L, 256² px, uniform frame sampling (images duplicated to fill the clip) | 304M | **frozen** |
| **Predictor** `⟨S_V, X_Q⟩ ↦ Ŝ_Y` | Last 8 transformer layers of Llama-3.2-1B; Llama tokenizer + token embeddings for the query; **causal mask disabled** so vision and query attend jointly; ≤512 query tokens, `[PAD]`-filled; average pool over non-`[PAD]` outputs → linear projection | 490M | yes |
| **Y-Encoder** `Y ↦ S_Y` | EmbeddingGemma-300M, context 512, **learning-rate multiplier ×0.05** | 300M | yes, slowly |
| **Y-Decoder** `Ŝ_Y ↦ Ŷ` | Lightweight text decoder | — | **not in the main training loop at all** |
| Shared space | linear projection head on both sides, `d = 1536` | | |

Total 1.6B. The whole model is one architecture for four tasks: captioning/open-ended VQA (decode `Ŝ_Y`), open-vocabulary classification and discriminative VQA (encode candidate labels with the Y-Encoder, take the nearest), and text-to-video retrieval (encode videos to `Ŝ_Y` under a captioning prompt, rank against the encoded query).

**Objective.** Bidirectional **InfoNCE** between `Ŝ_Y` and `S_Y`, predictor and Y-Encoder descending it jointly. The paper's own framing is the wiki's: InfoNCE decomposes into an alignment term and a **uniformity** term, and the uniformity term is the anti-collapse provision (G34). It explicitly names VICReg and SIGReg as drop-in replacements and does not try them, and names the two alternatives it did not need — EMA on the Y-Encoder ([[wiki/entities/v-jepa-2.md]]) or freezing it (DINO-WM) — both of which it later ablates against and beats.

---

## The founding argument: an ill-posed target made unimodal

Given "What will happen if I flip this switch down?", both *"the lamp is turned off"* and *"the room will go dark"* are correct. **In one-hot token space they are nearly orthogonal** — no shared tokens — so a next-token model must fit several disjoint high-density regions. A text encoder maps them to nearby points, so the same task becomes fitting **one mode in a continuous space**.

This is a claim about the *target distribution*, not about capacity, and it inverts a position the wiki has carried since [[wiki/entities/h-jepa.md]]: there, a latent variable `z` exists so the predictor can *represent* multiple plausible futures; here, multi-modality of the target is treated as surface variability to be **quotiented away by the choice of target encoder**. Recorded as **T170**.

---

## The controlled comparison — token space vs embedding space

The wiki's second isolated price on prediction space, after [[wiki/entities/i-jepa.md]]'s latent-vs-pixel 66.9 vs 40.7, and the first one that is cross-modal.

| Held fixed | Perception Encoder ViT-L-14 @336², frozen, 16 frames · same iterations · effective batch 128 · same LR schedule · same pretraining mixture |
|---|---|
| **Varied** | VL-JEPA: embedding target, **0.5B** predictor · VLM baseline: next-token cross-entropy through a **1B** Llama-3.2-1B under the PerceptionLM recipe |

| Samples seen | VL-JEPA CIDEr / top-5 | VLM CIDEr / top-5 |
|---|---|---|
| 500K | 1.23 / 14.9% | 1.35 / 14.0% |
| 5M | 14.7 / 35.3% | — |
| 15M | **14.8 / 41.0%** | 7.1 / 27.2% |

Captioning CIDEr averaged over YouCook2, MSR-VTT, PVD-Bench; classification top-5 over CrossTask-Step, CrossTask-Task, EgoExo4D (VL-JEPA by nearest embedding, VLM by lowest perplexity). The two are equal at 500K and diverge immediately after; the loser has **twice** the trainable parameters.

**What this does and does not isolate.** It is the cleanest matched-data comparison of *where the loss lives* that the wiki has for language targets. It is **not** a target-space ablation in I-JEPA's strict sense: the loss changes (cross-entropy → InfoNCE), the trainable parameter count changes, and VL-JEPA's captions come from a separately trained decoder while the VLM's come from the trained path. So "predict an embedding" and "train against a jointly-learned target encoder with a contrastive loss" are confounded here — the same confound [[wiki/entities/v-jepa-2.md]]'s page names for stage 1.

---

## Results

### Zero-shot classification and retrieval (VL-JEPA<sub>BASE</sub>, 3.3B pairs seen)

| | Avg top-1, 8 video classification sets | Avg R@1, 8 text→video retrieval sets | Pairs seen |
|---|---|---|---|
| CLIP ViT-L (389M) | 30.7 | 35.3 | 12.8B |
| SigLIP2 ViT-g (1.9B) | 39.8 | 47.5 | 40B |
| PE-Core ViT-G (2.3B) | 44.7 | 58.1 | 86B |
| **VL-JEPA<sub>BASE</sub>** (1.6B) | **52.5** | **63.7** | **3.3B** |
| VL-JEPA<sub>SFT</sub> (not zero-shot) | 75.4 | 63.8 | 3.6B |

The split is the same one [[wiki/entities/v-jepa-2.md]] reports and inherits through the frozen X-Encoder: **motion-centric wins are enormous** (SSv2 19.3 vs 9.0, EK-100 21.8 vs 6.4, EgoExo4D 33.2 vs 13.6, COIN step-recognition 47.4 vs 29.0, CrossTask step-recognition 64.5 vs 40.3), **appearance-centric are losses** (K400 64.8 vs 76.4, COIN task-recognition 79.4 vs 86.0, CrossTask task-recognition 89.6 vs 97.2) — at **26× fewer image–text pairs** than the model it beats.

### VQA (VL-JEPA<sub>SFT</sub>, 1.6B, discriminative: encode candidate answers, take nearest)

| GQA (compositional) | TallyQA (counting) | POPE (hallucination) | POPEv2 |
|---|---|---|---|
| 61.5 — above InstructBLIP-Vicuna-13B (49.5), Qwen-VL-7B (59.3), below LLaVA-1.5-7B (62.0) | 69.9 — above InstructBLIP-13B (68.0), PaLI-17B (71.9) above it | 85.7 ≈ LLaVA-1.5-7B (85.9) | 86.3 — above LLaVA-1.5-13B (72.7), InternVL2-26B (76.1) |

### WorldPrediction-WM — inverse dynamics as a nearest-neighbour query

Two images (initial and final world state), four candidate action video clips, pick the action that explains the transition. VL-JEPA needs **no architecture change**: concatenate-and-duplicate the two states through the X-Encoder to get a state embedding, encode each candidate action, take the nearest.

| GPT-4o | Claude-3.5-Sonnet | Gemini-2.0 | Qwen2.5-VL-72B | Llama-4 400B | **VL-JEPA<sub>BASE</sub>** | **VL-JEPA<sub>SFT</sub>** |
|---|---|---|---|---|---|---|
| 52.0 | 53.3 | 55.6 | 57.0 | 53.6 | **63.9** | **65.7** (SoTA) |

**(brainstorm) Read in the core framing this is edge labelling done by coordinate comparison.** Two states are the endpoints of a latent-graph edge, the action clip is the edge's label, and the shared embedding space turns "which label fits this edge?" into a dot product — the amortised-retrieval move of [[wiki/concepts/subgraph-matching.md]] applied to the *edge* slot rather than the subgraph slot. Nothing here was trained on inverse dynamics; the capability falls out of the state and action descriptions landing in one space. What it does **not** supply is the vocabulary — the four candidates are given (gap **G4**).

### Action anticipation — the horizon result

EPIC-KITCHENS-100, Recall@5, fine-tuned. Anticipation time `t` is the gap between the end of the context clip and the onset of the action.

| Model | Encoder | `t=1s` | `t=2s` | `t=4s` | `t=10s` |
|---|---|---|---|---|---|
| V-JEPA 2 | ViT-g-384px | **39.7** | **28.6** | 19.3 | 8.2 |
| V-JEPA 2 | ViT-L-256px | 32.7 | 23.4 | 15.9 | 7.1 |
| **VL-JEPA** | ViT-L-256px | 34.2 | 26.0 | **19.4** | **11.7** |

**(brainstorm) This is the wiki's first horizon-differential measurement of prediction granularity, and it is monotone.** At *matched encoder*, swapping the target from masked visual features to a sentence embedding is worth **+1.5, +2.6, +3.5, +4.6** R@5 at 1, 2, 4 and 10 seconds — the advantage grows with every step of the horizon. Against the 3× larger ViT-g it *loses* by 5.5 at 1 s and *wins* by 3.5 at 10 s, crossing over between 2 s and 4 s.

That is the shape [[wiki/entities/h-jepa.md]] predicts for a higher level of its stack — a coarser representation is worth less at short range and more at long range, because it discards precisely what stops being predictable — and both [[wiki/entities/hit-jepa.md]] and [[wiki/entities/v-jepa-2.md]] are on record in this wiki as *not* testing it (HiT-JEPA's levels differ in sequence resolution, not horizon). Here two granularities are compared at four horizons with the encoder held fixed. The caveat that keeps it from closing the question: these are two separately fine-tuned systems, not two levels of one stack passing predictions between them, and "sentence embedding" is a coarser code by assumption rather than by construction.

COIN next-step forecasting, same story at 1.6B: **56.2** against ProVideLLM-8B's 53.6, VideoLLM-MoD-8B's 49.7, VideoLLM-online-8B's 49.1.

### Y-Encoder text-only hard negatives (TOT protocol — no image involved)

Triplets `(p1, p2, n)`: two paraphrases of one image description and one negative made by altering an object, attribute or relation. Score = fraction where `sim(p1,p2) > sim(p1,n)` and `> sim(p2,n)`.

| Model | Text-encoder params | SugarCrepe++ avg | Swap-Object | VISLA avg | VISLA Spatial |
|---|---|---|---|---|---|
| CLIP ViT-L | 85M | 44.5 | 13.5 | 34.5 | 31.3 |
| SigLIP2 ViT-g | 708M | 56.5 | 30.6 | 40.4 | 32.1 |
| PE-Core ViT-G | 537M | 58.6 | 26.5 | 38.3 | 31.4 |
| **VL-JEPA<sub>BASE</sub>** | **300M** | **63.9** | **42.0** | **42.9** | **35.9** |
| VL-JEPA<sub>SFT</sub> | 300M | 58.4 | 29.8 | 39.5 | 34.2 |

**This is a partial answer to the question [[wiki/concepts/cross-modal-grounding.md]] leaves open** — *is the relation deficit the rate or the objective?* The corpora are the same web caption pools everyone uses, so the **rate is unchanged**; only how the caption is consumed changed, and the hard-negative scores go up. **Where** they go up matters: the gain is concentrated in the **swap** categories (Swap-Object 42.0 against 13.5–30.6; Swap-Attribute 62.9 against 27.0–58.4), which perturb *arrangement* while holding the word bag fixed; **Replace-Relation is a tie** (52.2 against SigLIP2's 52.1) and Replace-Object is at parity with PE-Core (90.1 vs 90.6). So the improvement is on the word-order axis, not on relational vocabulary. Two further caveats that keep it partial: (i) this is a **text-only** evaluation, so it shows a better *text* encoder and not better image↔relation binding — Winoground and PUG, where the negative has a paired image, are still unrun by any JEPA; (ii) these are `argmax` triplet discriminations, exactly the family where a collapsed model can score high on ties, and the source reports no tie-handling.

**And supervised fine-tuning destroys 5.5 points of it.** VL-JEPA<sub>SFT</sub> beats VL-JEPA<sub>BASE</sub> by 22.9 on classification and loses to it on every relational text score. Instruction data buys task accuracy and costs relational sensitivity in the same run.

---

## Ablations — the target space is a design surface with a price list

All at 10K steps, batch 512 (5M samples), SFT-stage data. Columns: classification top-1 / retrieval R@1 / VQA accuracy.

**(a) The caption pretraining stage is most of the model.** Dropping it: **−21.7 / −17.3 / −3.6**. Alignment is bought in stage 1; VQA barely notices.

**(b) Y-Encoder learning-rate multiplier — both endpoints lose.**

| Multiplier | Δ classification | Δ retrieval | Δ VQA |
|---|---|---|---|
| 1.00 (full speed) | −3.6 | −1.4 | −1.8 |
| **0.05 (default)** | — | — | — |
| 0.10 | −0.4 | 0.0 | +0.4 |
| 0.01 | −1.7 | −2.5 | −1.5 |
| **0.00 (frozen)** | **−7.3** | **−4.3** | −1.1 |

The stated reason for slowing it: early in training the predictions are bad, so a fast-moving target encoder chases noise. **(brainstorm) This is [[wiki/entities/byol.md]]'s finding in a new place.** BYOL's conclusion was that the operative anti-collapse quantity is a **rate ratio between two networks** — a predictor kept near-optimal relative to its target — and that both stabilisers were substitutable by other ways of setting that ratio. Here the ratio is a literal scalar multiplier with an **interior optimum**, and the two regimes the JEPA lineage actually ships are the two endpoints: EMA/joint training at the fast end, [[wiki/entities/lewm.md]]-style and DINO-WM-style freezing at the slow end (T154 is the argument for freezing). Freezing costs 7.3 points here. G34's answer column has catalogued *provisions*; this row says the provision has a **continuous knob** and nobody has been tuning it.

**(c) Loss function** (frozen text encoder, no projection head), and the one inversion in the table:

| Loss | Classification | Retrieval | VQA |
|---|---|---|---|
| InfoNCE | 23.3 | 30.3 | 44.3 |
| Cosine | −6.8 | −10.1 | **+2.3** |
| L1 | −8.5 | −14.8 | −2.4 |
| L2 | −9.8 | −18.6 | −0.6 |

Pure regression losses are catastrophic for *alignment* read-outs and roughly neutral for VQA — and **cosine beats InfoNCE on VQA**. The uniformity term is what builds a space you can retrieve in; it is not what answers the question. Only InfoNCE carries an anti-collapse provision, so it is the only one usable with an unfrozen Y-Encoder — which is also the setting worth 7.3 points in (b), so (b) and (c) are coupled and the source does not cross them.

**(d) Predictor.** More layers monotonically better, mostly on VQA (0-16: +0.1/+0.8/+3.0 over 8-16; 0-2: −3.0/−2.4/−2.4). Restoring the causal mask costs **−1.9 VQA** — query tokens are appended after visual tokens, so under causal attention the visual tokens cannot see the question at all. Dropping the Llama-3 initialisation *helps* alignment (+0.8 classification) and costs **−1.9 VQA**: language-model weights buy question-answering, not vision–language alignment.

**(e) Y-Encoder swap — the trade-off that names the design surface.** Every alternative beats the default on alignment; the *visually-aligned* text encoders win biggest and lose VQA.

| Y-Encoder | Δ classification | Δ retrieval | Δ VQA |
|---|---|---|---|
| Qwen3-Embedding-8B | +10.1 | +5.4 | −0.6 |
| PE<sub>core</sub>-B (356M) | +9.9 | **+10.4** | **−6.6** |
| PE<sub>core</sub>-G (539M) | **+14.4** | +7.9 | −0.7 |

**(brainstorm)** The wiki's objective slot (gap **G30**) has been almost empty, and this is a lever that sits squarely in it: *what space you predict into* changes which read-outs work, by up to 14 points, with the architecture, data and loss all fixed. A text encoder already aligned to images makes the prediction task easier at the cost of the answer-selection task — i.e. the target encoder is doing part of the model's abstraction, and how much it does is a free parameter. Note the direction of the confound the whole page rests on: **VL-JEPA's headline is that the target encoder simplifies the target distribution, and its own ablation says the amount of simplification is un-derived.**

---

## Selective decoding — an event-boundary detector on a semantic stream

The model emits a continuous stream of `Ŝ_Y` in sliding windows with **no autoregression**, so the semantics of the answer exist before any token does. Decode only where the stream changes:

1. Agglomerative clustering with a **temporal connectivity constraint** over the embedding sequence, merging by **Ward distance** (within-segment variance) into `N` segments.
2. Decode once per segment, at its midpoint, from the exact or the **average-pooled** embedding (pooling denoises and helps both strategies).

Benchmark: EgoExo4D validation, 218 procedural videos, ~6 min each, ~143 atomic-action annotations per video; align each ground-truth annotation to its nearest decode in time, score CIDEr on matched pairs, sweep decode frequency 2.0 Hz → 0.01 Hz.

**Adaptive selection Pareto-dominates uniform sampling across the entire range**; 0.35 Hz adaptive matches 1 Hz uniform, i.e. **2.85× fewer decodes at equal quality**.

This is [[wiki/concepts/event-segmentation.md]]'s definition implemented and priced: *an event boundary is a significant lasting change in the active set of predictive encodings*, here operationalised as variance in a semantic embedding stream, with the boundaries recovered good enough that half of them can be skipped. Two things it does not supply: the **granularity** is `N`, set by hand (the row's standing complaint — nothing sets the number of clusters), and the segmentation is **offline agglomerative**, so a streaming system needs an online change detector this does not give.

---

## Comparison

| | **VL-JEPA** | [[wiki/entities/i-jepa.md]] | [[wiki/entities/v-jepa-2.md]] | CLIP-family (JEA) | Generative VLM |
|---|---|---|---|---|---|
| Target of prediction | **another modality's embedding** | own EMA encoder's patches | own EMA encoder's patches | — (no predictor) | raw tokens |
| Target branch | separate net, **trained at 0.05× LR** | EMA copy | EMA copy / frozen | trained jointly | n/a |
| Conditioning | **text query into the predictor** | mask positions | action + state | none | text prompt |
| Anti-collapse | InfoNCE uniformity | none (EMA asymmetry) | EMA asymmetry | InfoNCE | n/a (likelihood) |
| Generation | via optional decoder | no | no | **no** | yes |
| Retrieval | yes | n/a | n/a | **yes** | **no** |
| Inference | one forward pass; decode on demand | — | — | one pass | autoregressive |

Table 8 of the source is the point in one line: CLIP does retrieval and not generation, VLMs do generation and not retrieval, VL-JEPA does both because the predicted object is an embedding that a decoder *may* read.

---

## Limitations

- **The X-Encoder is frozen, so every ceiling in [[wiki/entities/v-jepa-2.md]] is inherited** — including the appearance/motion split, which shows up unchanged in the per-dataset scores. Nothing here tests whether a jointly-trained X-Encoder would do better.
- **No latent variable, no stack, no actions, no cost.** As a world model this is one level, deterministic, and conditioned by a text query rather than by an action ([[wiki/empirical-tensions.md]] T152). WorldPrediction-WM is scored by *retrieval among four given candidates*, not by rollout.
- **The multi-modality argument is asserted, not measured.** No experiment shows that the Y-Encoder actually maps the semantically-equivalent answers close and the semantically-distinct ones apart; if it maps *distinct* answers close, the model is averaging over real alternatives and the metric cannot tell (T170).
- **Reasoning is explicitly out of scope.** The conclusion states the goal is not a universal VLM replacement: tasks requiring reasoning, tool use and agentic behaviour are where token-generative models still win, and none is evaluated.
- **The uniformity term is a batch property.** InfoNCE's negatives are the other targets in the batch, which is the noise-distribution design problem [[wiki/concepts/cross-modal-grounding.md]] blames for relation blindness — and the paper names VICReg/SIGReg as the fix and leaves it to future work.
- **Scaling untested.** Both parameters and data are said to help and neither curve is reported.

---

## Reading in the core framing

| VL-JEPA object | Latent-graph reading |
|---|---|
| `S_V` | the instance-graph state, read by a frozen encoder |
| `X_Q` (query) | the **query into** the graph — which projection of the state is wanted |
| `S_Y` (target embedding) | a *node in a semantic space*, and the equivalence class that space induces on answers |
| Y-Encoder LR multiplier | how fast the answer space is allowed to be re-carved by the task |
| WorldPrediction-WM | edge labelling: `(s₀, s₁)` as an edge, action clips as candidate labels, nearest neighbour as the classifier |
| Selective decoding | node boundaries in a stream, detected by variance in the semantic code (G27) |
| Anticipation at `t` | how far along an edge a coarse code stays predictive — measured, and it goes further than a fine one |

**The transferable conclusion for a builder:** *choosing the space you predict into is a first-class architectural decision with a 14-point spread*, and the wiki has been treating it as either given (the input's own space) or as an implementation detail. VL-JEPA makes it the design surface, and every one of its own results — the sample efficiency, the relational text sensitivity, the horizon crossover, the VQA/alignment trade-off — is a property of that choice rather than of the predictor.

---

## Connections

- **[[wiki/entities/v-jepa-2.md]]** — supplies this page's frozen X-Encoder, so every appearance/motion asymmetry is inherited; and is beaten by it at *matched encoder* on action anticipation by a margin that grows monotonically with horizon (+1.5 at 1 s to +4.6 at 10 s), which is the first horizon-differential comparison of prediction granularity in the wiki.
- **[[wiki/entities/i-jepa.md]]** — the strict version of this page's headline experiment: there the target space is swapped (latent vs pixel) with everything else identical, 66.9 vs 40.7; here the swap is token-vs-embedding across modalities and drags the loss and the parameter count with it, so it is a system-level replication of the same conclusion rather than a second ablation (T162).
- **[[wiki/entities/h-jepa.md]]** — instantiates the conditioned-predictor half of the design with a *text query* in the configurator's slot, and inverts its latent-variable clause: multi-modality of the target is quotiented by the target encoder instead of represented by a `z` (T170); its horizon/abstraction claim gets its first measurement here.
- **[[wiki/entities/hit-jepa.md]]** — the stack whose levels differ in sequence resolution rather than prediction horizon, which is what left the stacking argument untested; this page tests the horizon differential across two *systems* instead of two levels, and finds the coarser code wins from ~4 s out.
- **[[wiki/entities/byol.md]]** — the rate-ratio finding with a continuous knob attached: the target branch's learning rate has an interior optimum (0.05–0.10), and the two settings the JEPA lineage actually ships — jointly trained and frozen — are the two endpoints, worth −3.6 and −7.3 respectively (G34, T164).
- **[[wiki/entities/lewm.md]]** — the frozen-target end of that same knob, and the objective this page names as its own untried replacement: SIGReg is offered as a drop-in for InfoNCE's uniformity term and left to future work, so the two are the same architecture with a different anti-collapse family.
- **[[wiki/entities/lejepa.md]]** — the other named-and-untried alternative, and the one whose moment-ladder framing predicts what the swap would cost: InfoNCE's uniformity is a sample-contrastive way to spread a batch, SIGReg pins the marginals to a target shape without negatives, which would remove this page's batch-dependent noise distribution.
- **[[wiki/entities/vicreg.md]]** — the per-branch form that fits this architecture better than any other JEPA in the wiki: the two branches here have different weights, architectures *and* modalities, which is exactly the setting where VICReg's separately-regularised branches were shown to beat a cross-branch criterion by 2–3 points.
- **[[wiki/concepts/cross-modal-grounding.md]]** — a partial answer to that page's central open question: with the caption corpora and hence the *rate* unchanged, changing how the caption is consumed lifts relation-sensitive text discrimination above every contrastive baseline, which favours the objective over the rate — but only on text-only triplets, so image↔relation binding is still unmeasured.
- **[[wiki/concepts/event-segmentation.md]]** — an implemented, priced boundary detector on a semantic stream: Ward-variance agglomerative clustering with temporal connectivity, Pareto-dominating uniform sampling and matching 1 Hz decoding at 0.35 Hz, with the granularity `N` still supplied by hand.
- **[[wiki/concepts/divergence-objectives.md]]** — the loss ablation as a divergence question: InfoNCE beats cosine, L1 and L2 by 7–19 points on retrieval and *loses to cosine on VQA*, so the uniformity term builds the space rather than the answer.
- **[[wiki/concepts/learned-world-models.md]]** — a world model whose conditioning interface is a natural-language query and whose "dynamics" query is answered by nearest-neighbour retrieval in the shared space: SoTA on WorldPrediction-WM at 1.6B against 400B token models, with no rollout anywhere.
- **[[wiki/concepts/latent-graph-discovery.md]]** — edge labelling done by coordinate comparison: `(s₀, s₁)` embedded as one state code and candidate action clips as label codes in the same space, so inverse dynamics is a dot product — with the candidate set given, so the vocabulary problem (G4) is untouched.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the empirical shape an abstraction hierarchy is supposed to have, measured for once: a coarser prediction target is worth less at 1 s and more at 10 s than a finer one at matched encoder, which is the case for stacking stated as a curve rather than an argument.
- **[[wiki/concepts/amortized-inference.md]]** — the inference-side payoff of a non-autoregressive answer: the semantics of `Ŷ` exist after one forward pass and the decoder is a *read-out* invoked on demand, so deliberation cost and answer cost are separated rather than serialised.
- **[[wiki/concepts/shortcut-learning.md]]** — the fine-tuning cost this page measures: supervised instruction data lifts classification by 22.9 and drops every relational text score (SugarCrepe++ 63.9 → 58.4, Swap-Object 42.0 → 29.8), so in-domain accuracy and relational sensitivity move in opposite directions in the same run.
