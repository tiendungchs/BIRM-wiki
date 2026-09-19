# VARC — Vision ARC

**ARC as image-to-image translation: a vanilla ViT, trained from scratch on ARC data only, doing per-pixel classification on a 64×64 canvas, adapted per task by test-time training — 60.4% on ARC-AGI-1, matching the reported average human (60.2%) with no pretraining corpus, no program, no recurrence and no parse.**

> **Provenance.** Hu, Cy, Qiu, Ding, Wang, Zhu, Andreas & He 2025, *ARC Is a Vision Problem!* (`raw/hu-2025-arc-is-a-vision-problem.md`, arXiv 2511.14761, MIT). All numbers are the authors'; ARC-1 single-model result is `54.5 ± 0.7` over four runs, ARC-2 `8.3 ± 0.4`.

---

## Architecture

| Component | Instantiation | What it is for |
|---|---|---|
| **Formulation** | Per-pixel cross-entropy, `L(θ) = E_{T,i}[D(y_i, f_θ(x_i | T))]` — semantic segmentation, not sequence modelling | The output grid is a label field, not a token stream; no autoregressive commitment order ([[wiki/entities/poe-arc-solver.md]]'s named defect) |
| **Canvas** | Fixed 64×64 field of a `(C+1)`-th background token `[BG]`; the raw grid is randomly rescaled by an integer ratio `s` (pixel → `s×s`) and randomly translated onto it | Makes a discrete 10-symbol grid behave like a natural image, and is what *enables* the scale and translation augmentations |
| **Patchification** | 2×2 patches → sequence length 32² ; each discrete colour index first mapped to a learnable embedding | Raises the token alphabet from `C = 10` to `O(C^4)` local configurations, so a patch cannot be memorised as a symbol |
| **Positional code** | **Separable 2D** — first half of `D` channels for `x`, second half for `y`; both absolute and RoPE variants | The grid's own topology; 1D RoPE in the final model costs **3.5 points** (54.5 → 51.0) |
| **Backbone** | ViT, 512 wide × 10 deep, **18M params**, 28 GFLOPs. U-Net (55M) also works | Standard vision architecture, unmodified |
| **Task conditioning** | One learnable **task token** per task; all 400 training tasks share every other parameter | The only per-task state during offline training; re-initialised randomly for each unseen task |
| **Shape handling** | Output canvas carries a border token `[BD]` along the right and bottom one-pixel edges; inference crops at the outermost `[BD]` | Input and output grids differ in size — the "construct the output's dimensions" requirement, solved as a label rather than as a decision |
| **Background masking** | Additive `−∞` on keys at `[BG]` positions; loss computed only on non-`[BG]` locations | Keeps the dominant background from absorbing attention |
| **Adaptation** | [[wiki/concepts/test-time-training.md]] per task: the single test task is expanded to **51 auxiliary tasks** (2 flips or 3 rotations × 10 colour permutations), each with its own task embedding, 100 epochs ≈ 15.3k samples, **~70 s on one H100** | Flips/rotations get *separate* embeddings because they are not the same rule (gravity under 90° is not gravity) — translation and scale do not, being assumed invariances |
| **Inference** | **510 random views** (scale × translation), softmax outputs average-pooled per raw location, views consolidated by majority vote, top-2 kept for pass@2 | Feedforward, no recurrence anywhere once TTT is done |

Offline training: ARC-1's 400 training tasks + 1,000 RE-ARC pairs per task ≈ 400k pairs; 100 epochs, 8×H100, 4.8 h.

---

## Key results

| Benchmark | VARC ViT-18M | VARC ensemble (ViT-18M + U-Net-55M, TTT ×4 each; 73M) | Reference |
|---|---|---|---|
| **ARC-AGI-1** (pass@2, eval set) | **54.5** | **60.4** | avg. human 60.2 · TRM 44.6 · HRM 40.3 · GPT-5 44.0 · Grok-4-thinking 66.7 · Bespoke(Grok-4) 79.6 |
| **ARC-AGI-2** | 8.3 | 11.1 | TRM 7.8 · HRM 5.0 · Grok-4-thinking 16.0 · Bespoke(Grok-4) 29.4 |

Against the from-scratch field ([[wiki/concepts/refinement-loop.md]]'s recurrent column) the comparison is controlled — same data, no pretraining on either side — and VARC is ~10 points above TRM on ARC-1 at 2.6× its parameters.

### The visual priors, priced

The ablation ladder on ARC-1 eval (ViT-18M), each row modifying the one above:

| Step | Δ | Running score |
|---|---|---|
| (a) naïve baseline, 1×1 patches on 32×32, 1D positional embedding | — | 26.8 `(inferred: 54.5 − 27.7)` |
| (b)(c) 1D → **2D positional embedding** (absolute, then relative) | +16.2 `(inferred)` | 43.0 |
| (d) 1×1 on 32×32 → **2×2 patches on 64×64** (same FLOPs) | **+2.4** | 45.4 |
| (e) full **translation augmentation** on the canvas | **+2.9** | 48.3 |
| (f) **scale augmentation** | **+6.2** | **54.5** |

Total **+27.7**, of which the canvas-enabled designs (c→f) are **+11.5**. The authors' reading of the largest single term: patchification is a convolution and therefore already buys locality and translation equivariance, whereas **a ViT has essentially no scale prior at all**, so scale has to be installed by data.

### Scaling and data

| Axis | Measurement |
|---|---|
| Model size | 6M → 44.4 · 18M → **54.5** · 66M → 53.0 (66M has *higher training* accuracy — overfitting, not capacity) |
| Backbone | ViT beats U-Net at every size (44.4/54.5/53.0 vs 42.8/47.5/48.3), but all U-Nets are "decent": the result is not ViT-specific |
| Offline data per task (RE-ARC pairs) | 0 → **31.5** · 10 → 38.6 · 100 → 52.3 · 1,000 → 54.0; diminishing |
| Offline **task diversity** | 0 → **26.4** · 16 → 43.1 · 80 → 49.6 · 400 → **54.5** |
| Inference views | single-view pass@1 **35.9** → multi-view pass@1 **49.8** → pass@2 **54.5** → pass@300 **66.3** |

Two of these carry more than they look. **26.4% with no offline training at all** — TTT from random initialisation on 2–4 demonstration pairs — is the from-scratch floor of this architecture and says a quarter of ARC-1 is solvable tabula rasa given only the right invariances. And **TTT run independently per test task beats TTT run jointly over all test tasks by ~10 points**, despite the joint setting assuming strictly more (all test tasks available at once); the authors hypothesise forgetting of the offline-acquired priors under overtraining — which is [[wiki/concepts/continual-learning.md]] appearing as a *penalty for having more data*.

---

## What it says it is doing, read from the inside

| Probe | Observation | Reading |
|---|---|---|
| Pixel-to-pixel attention | A query pixel attends to the palette pixel it must copy from, correctly, across layers | The copy relation is computed as an attention edge — a pointer without an object ([[wiki/concepts/visual-indices.md]]) |
| Layer-wise attention (mean over queries) | Layers specialise: some on the 3×3 neighbourhood of a pattern's core, layers 7–9 on the outward-radiating rays along eight directions | A *sequence* of operations distributed over depth rather than over time — the feedforward compilation of what [[wiki/concepts/visual-routines.md]] runs serially |
| t-SNE of the 400 learned task tokens | Nearby tokens share semantics — colouring tasks cluster, AND/OR/XOR tasks cluster — with no supervision on the labels | The task embedding space is a learned similarity metric over *rules*, which is the nearest thing in the wiki to an emergent task taxonomy on ARC |
| Pass@k gap | 66.3 at `k = 300` vs 54.5 at `k = 2` | The correct answer is produced in *some* view for 12 points' worth of tasks, and lost at the voting step — the selector, not the model, is the binding constraint there |
| Ambiguous tasks | The two retained answers correspond to two defensible rules ("lines *pass through* the box" vs "lines *touch* the box") | Pass@2 is partly absorbing genuine task ambiguity rather than model error |

---

## Limitations

- **The parse is never made.** No object, no segmentation, no individuation, no variable — per-pixel classification end to end. Nothing downstream can be handed "the object"; see `G75` below.
- **The priors are declared, only in a different currency.** Objectness/geometry do not enter as a DSL; they enter as the invariance group (translation, scale, flip, rotation, colour permutation) plus the canvas. That is [[wiki/concepts/test-time-training.md]]'s relocation of the authored prior, one notch further — from an augmentation *list on tokens* to a geometry *on an image plane*.
- **ARC-2 is barely moved.** 11.1% against a human-calibrated benchmark whose 5% floor is its own noise threshold: whatever the visual formulation buys, it is largely an ARC-1 property.
- **Capacity is already past its useful point.** 66M overfits at 400 tasks; the authors name generalisation, not scale, as the next problem.
- **No recurrence, no iteration, no stopping.** Inference is one forward pass per view. Nothing in the system can spend more time on a harder grid ([[wiki/concepts/adaptive-computation-time.md]]).
- **The adapted model is still discarded**, and now so are 51 auxiliary task embeddings per task — `G14` in the same form the TTT page names.
- **Prior art distinction**: ViT-ARC (cited by the authors, not read here) fitted training tasks and solved no unseen test task; the difference is TTT plus the canvas, not the choice of a vision backbone.

---

## Comparison to the from-scratch field

| System | Params | Pretraining | Inference | ARC-1 | ARC-2 |
|---|---|---|---|---|---|
| **VARC (ensemble)** | 73M | ARC + RE-ARC only | Feedforward × 510 views + vote | **60.4** | **11.1** |
| **VARC (ViT)** | 18M | ARC + RE-ARC only | as above | 54.5 | 8.3 |
| TRM | 7M | none | Recursive deep supervision | 44.6 | 7.8 |
| HRM | 27M | none | Hierarchical recursion | 40.3 | 5.0 |
| CompressARC | 76K | none | Description-length descent per puzzle | 20–34 | 4 |
| [[wiki/entities/poe-arc-solver.md]] | 8B | internet-scale | TTT + DFS + product-of-experts over 16 frames | 71.6 (public eval) | — |

The axis VARC adds to this table is **modality**, not scale or search: it is the only entry whose input is treated as an image with a metric, and it is the only one of the from-scratch entries that reaches the reported average human.

---

## Connections

- **[[wiki/entities/arc-agi.md]]** — the benchmark, and the first result on it that reaches the reported average human (60.4 vs 60.2) from scratch on ARC data alone, which reframes the five-year record's "what actually moved" as a question about *input format* rather than about search or pretraining.
- **[[wiki/entities/arc-agi-2.md]]** — where the same system gets 11.1%, so the vision reformulation is shown to be a largely ARC-1-specific gain against a benchmark built to defeat single-insight solutions.
- **[[wiki/concepts/test-time-training.md]]** — the adaptation mechanism, run here with *no pretrained library to dredge*: the page's "vast latent building blocks" account cannot explain a 54.5% from 400 tasks of offline data, and this system supplies two facts the page lacked — independent-per-task TTT beats joint TTT by ~10 points, and TTT from random initialisation alone reaches 26.4%.
- **[[wiki/concepts/refinement-loop.md]]** — the direct counterexample to 2025's "defining theme": once TTT is finished VARC's inference is a single feedforward pass with no propose-and-check at all, and it beats both recurrent from-scratch systems, so recursion is not what the from-scratch column was buying.
- **[[wiki/concepts/inductive-bias.md]]** — the wiki's cleanest *price list* for a bias: each visual prior (2D position, patchification, translation, scale) is added one at a time to a fixed architecture and data budget, and the total is +27.7 points, with scale — the one a ViT has no architectural claim on — the most expensive single item.
- **[[wiki/concepts/visual-routines.md]]** — the same claim about ARC from the opposite end: Ullman says the parse is a program assembled per task, VARC gets human-average score with no program and no parse, and its layer-wise attention shows the operation sequence compiled into *depth* instead of time.
- **[[wiki/concepts/visual-indices.md]]** — what the attention maps look like when there are no indices: the copy relation is a pixel-to-pixel attention edge recomputed every forward pass, so nothing persists to be bound, counted or re-referred to.
- **[[wiki/entities/blindtest.md]]** — the complementary half of the perception argument: BlindTest shows frontier VLMs fail grid counting and path tracing with no rule attached, VARC shows a task-specific vision model with the right invariances clears the rules once the perception is native — together they price `T215`.
- **[[wiki/concepts/core-knowledge.md]]** — objectness and geometry installed as an invariance group over an image plane rather than as an operation set, which is the weakest form in which the wiki has seen those priors supplied and still enough for 60%.
- **[[wiki/entities/transformer.md]]** — an unmodified ViT: the only ARC-specific changes are 2D positional encoding, the canvas and the task token, so nothing about the result is a new architecture.
- **[[wiki/entities/poe-arc-solver.md]]** — the same multi-frame consolidation with a weaker aggregator: VARC majority-votes 510 views where PoE takes a product of 16 likelihoods, and VARC's pass@300 = 66.3 vs pass@2 = 54.5 gap is exactly the headroom a better aggregator addresses.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the cheapest well-scored entry in the wiki on the `P` axis: 400 tasks + RE-ARC and no internet-scale corpus, 4.8 GPU-hours offline and 70 s per task, against LLM systems three to four orders of magnitude larger for comparable ARC-1 scores.
