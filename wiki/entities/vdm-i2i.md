# VDM-I2I — a pretrained video diffusion model adapted to grid reasoning as a two-frame transition

**Every input→output pair is rendered as a short video whose first frame is the input and last frame is the output; a frozen video diffusion model is LoRA-adapted to denoise that transition, and the answer is read off the final frame — which beats a scale-matched LLM given the same grids as JSON on 4 of 5 puzzle games, on route planning by up to **10× fewer training examples**, and on ARC-AGI (16.75% vs 8.00%, two attempts).**

> **Provenance.** Acuaviva, Davtyan, Hassan, Stapf, Rahimi, Alahi & Favaro 2025, *Rethinking Visual Intelligence: Insights from Video Pretraining* (`raw/acuaviva-2025-rethinking-visual-intelligence-video-pretraining.md`, arXiv 2510.24448v2; Univ. Bern + EPFL). The paper names no system; `VDM-I2I` is this wiki's label for the adaptation framework.

The paper adopts [[wiki/concepts/skill-acquisition-efficiency.md]]'s definition of intelligence verbatim and designs to it: the measured quantity is *how many examples* a family needs to reach a skill, not the endpoint score.

---

## Architecture

| Component | Instantiation | What it is for |
|---|---|---|
| **Transition video** | `v_{i,1} = I(x_i)`, `v_{i,F} = I(y_i)`; intermediate frames by an interpolation `φ`. Two variants: convex `v_{i,f} = (1−α)I(x)+αI(y)`, `α = (f−1)/(F−1)`, and **discrete** (hold the input for `f ≤ F/2`, switch to the output after). Discrete is used for all reported comparisons, "to avoid introducing any biases" | Turns a static image-to-image problem into the thing the backbone was pretrained on — a temporal transformation — without inventing a motion trajectory the task does not have |
| **Conditioning** | First frame `v⁰₁` plus a **neutral fixed text embedding** `e_text` | No language channel carries task information; the text encoder is present and deliberately uninformative |
| **Objective** | `L_VDM = E[‖ε − ε_θ(v^t, t, c)‖²]`, `c = {v⁰₁, e_text}` — standard noise prediction, unmodified | Nothing task-specific enters the loss |
| **Adaptation** | **LoRA only**, rank 64 (α 32–64), QKVO + FFN projections; backbone frozen | The comparison's controlled variable: the pretrained weights are the hypothesis, the adapter is the concession |
| **Inference** | Reverse diffusion from `N(0,I)` conditioned on `c_test`; prediction is `v⁰_F`, the **final frame** | The answer is a rendered image, decoded back to a grid by exact match |
| **LLM counterpart** | Same tasks as JSON→JSON, teacher-forced cross-entropy, LoRA rank 32 on the same projection set, Qwen3-4B-Instruct-2507 / Qwen3-8B / Llama3.1-8B | Modality is the variable; adaptation method, frozen backbone, data splits and scale band are held fixed |

Serialization on both sides is deliberately **neutral** — a compact JSON grid, a deterministic RGB render — so neither family is handed a domain-specific prior at the interface.

**On ARC the adaptation *is* test-time training** `(inferred — the paper states LoRA adaptation and a 2–5-demonstration regime but does not name the per-task loop)`: 450 GPU-hours for CogVideoX1.5-5B over the ARC-AGI evaluation set, against 475 for Qwen3-4B, is only consistent with a per-task fit. See [[wiki/concepts/test-time-training.md]].

---

## Key results

### ARC-AGI (evaluation set, official protocol)

| Model | Two attempts | Single attempt |
|---|---|---|
| **CogVideoX1.5-5B (VDM)** | **16.75** | 12.50 |
| Qwen3-4B-Instruct-2507 (LLM) | 8.00 | 6.75 |
| OpenAI o1-preview | — | 21.00 |
| Claude 3.5 Sonnet | — | 21.00 |
| GPT-4o / Gemini 1.5 | — | 9.00 / 8.00 |

The scale-matched comparison is the first two rows: **2.1× at the same adapter, same splits, same parameter band**. The commercial rows are quoted from the ARC Prize 2024 report and are not matched on anything.

### ConceptARC (3 attempts, 16 concepts × 10 tasks × 3 test inputs)

| | LTX-2B | LTX-13B | CogVideoX1.5-5B | **Wan2.1-14B** | Qwen3-4B | Qwen3-8B | Llama3.1-8B | GPT-4 [IC] |
|---|---|---|---|---|---|---|---|---|
| **Average** | 0.19 | 0.24 | 0.33 | **0.41** | 0.24 | 0.24 | 0.18 | 0.19 |

Human average on the same items is **0.91** ([[wiki/entities/conceptarc.md]]), so the entire spread here sits in the bottom half of the instrument.

**The per-concept profile is the load-bearing part, because it anticorrelates:**

| Concept | Best VDM | Best LLM | Sign |
|---|---|---|---|
| **Count** | **0.83** (Wan) | 0.17 | VDM +0.66 |
| Extend To Boundary | 0.50 | 0.17 | VDM +0.33 |
| Top and Bottom 3D | 0.47 | 0.20 | VDM +0.27 |
| Center | 0.57 | 0.33 | VDM +0.24 |
| Inside and Outside | 0.37 | 0.20 | VDM +0.17 |
| **Order** | **0.07** | **0.27** | LLM +0.20 |
| Move To Boundary | 0.17 | 0.23 | LLM +0.06 |
| Copy | 0.20 | 0.23 | LLM +0.03 |
| Extract Objects | 0.23 | 0.10 | VDM +0.13, both near floor |

On ARC-AGI the same structure appears as a Venn diagram: each family solves tasks the other does not. **The two representations are not ordered; they are complementary, per concept** — which is `G73` with the handed-in representation shown to be a per-task handicap whose sign flips inside one benchmark, and `G21` with two complementary competencies present and nothing composing them.

### Structured visual tasks (CogVideoX1.5-5B vs Qwen3-4B, accuracy as a function of `n` training examples)

| Family | Result |
|---|---|
| Puzzle games — Sudoku, Mini Sudoku, Hitori 5×5, Connect 4, Chess mate-in-1 | VDM wins **4 of 5**; advantage largest on Sudoku and Hitori (grid layout + global consistency). **Chess is the exception**, attributed to chess notation being abundant in text corpora |
| Route planning — Maze 21×21, Shortest Path | VDM constructs valid paths with **up to 10× fewer supervised examples** in the low-sample regime |
| Maze **generalization** — train 13×13, test 21×21 | VDM generalises across scale far sooner; the LLM needs substantially more data to transfer at all |
| 1D elementary cellular automata (4 rules per Wolfram class) | **Roughly tied** — VDM better on some rules, worse on others, across all four complexity classes |
| 2D life-like CA (Day & Night, Maze, Seeds, Life) and Langton's ant | VDM reaches `δ ≥ 0.9` with far fewer examples, and **the gap grows with prediction horizon** (2 → 3 → 5 → 10 steps) |

The 1D/2D split is the sharpest internal control in the paper: the *rule* is equally local in both, and the VDM advantage appears only once the state is two-dimensional. Whatever video pretraining supplies is a property of the **spatial** layout, not of the update rule's complexity.

### The VLM control — and it is a null

Gemma-3-4B fine-tuned on Sudoku with `n = 1000`, three input configurations, everything else fixed:

| Configuration | Relative accuracy | Accuracy |
|---|---|---|
| Text-only | 0.79 | 0.06 |
| Combined image–text | 0.78 | 0.06 |
| **Image-only** | **0.12** | **0.00** |

Adding the image is worth **nothing**; the image alone is worse than a trivial baseline. Trained instead on the easier task of *transcribing its own image input back to the textual grid*, at `n = 3, 5, 10` the image-only model reproduces training samples verbatim regardless of input — it memorises rather than reads. So a multimodal encoder in front of a language model does not deliver the visual prior that a generative video backbone does, which is why the paper's baseline is an LLM and not a VLM. This bounds `T215` position B's prescription from the same side `T388` does: supplying a parser is not satisfied by supplying an encoder.

### Where the prior transfers outside grids

Same framework, same hyperparameters, `n = 1`–`30` paired examples on natural images: 1-shot style transfer, `n = 30` binary segmentation, human pose, depth, plus inpainting, colorization and jigsaw. Few-shot success is used as a **probe of what pretraining already contained** — if 30 pairs suffice, the ability was there.

---

## Limitations

- **Absolute scores are low.** 16.75% on ARC-1 against [[wiki/entities/varc.md]]'s 60.4% from an 18M ViT with *no* pretraining corpus at all. Video pretraining beats text pretraining at matched scale and loses badly to installed invariances plus the task corpus — `T154`'s two columns measured on one public benchmark for the first time.
- **No in-context adaptation.** Every task costs a LoRA fit; the paper names this as the gap between VDMs and LLMs it most wants closed. ARC's own protocol is few-shot, so the format is being satisfied by gradient descent rather than by conditioning.
- **Sampling cost.** Iterative reverse diffusion, with ARC needing long schedules "to maintain structural consistency"; 450–1650 GPU-hours per benchmark family.
- **The tokenizer bounds the grid.** LTX-2B/13B underperform the other VDMs and the authors attribute it to **aggressive VAE compression discarding structural information** — the visual prior is delivered through a lossy latent, and how lossy is a design parameter nobody tuned for grids. This is the substrate the whole claim rides on and it is measured only by the score it costs.
- **No mechanism is identified.** "Spatiotemporal inductive bias" is inferred entirely from data-efficiency curves; nothing is probed, ablated inside the backbone, or named — so the invariance group is inherited and never stated, which is `G95` on the discovery side with the same residue CPC and SAYCam carry. The paper's own future-work section asks for exactly this.
- **Interpolation choice is unexamined.** Discrete interpolation is chosen to avoid bias; the convex alternative — which would make the intermediate frames a *trajectory* — is defined and never scored, so the claim that temporal structure is doing the work is untested against the version that uses it most.
- **Wan2.1-14B is the ConceptARC winner but is not carried forward**; all structured-task results use the weaker CogVideoX1.5-5B, so the best-measured VDM is never put on the efficiency curves.

---

## Comparison — three ways to give an ARC-format task a visual prior

| | [[wiki/entities/varc.md]] | **VDM-I2I** | VLM (Gemma-3-4B, this paper's control) |
|---|---|---|---|
| Where the prior comes from | Declared invariance group (2D position, patchification, translation, scale) on a canvas | **Generative pretraining on natural video** | Multimodal pretraining on image–text pairs |
| Pretraining corpus | **None** | Internet video | Image–text |
| Params | 18M / 73M ensemble | 5B–14B frozen + LoRA | 4B |
| Output format | Per-pixel label field | **Final frame of a denoised video** | Text tokens |
| Adaptation | TTT, 51 auxiliary tasks, ~70 s/task | LoRA per task | LoRA |
| ARC-AGI-1 | **60.4** | 16.75 | — |
| What it shows | Invariances can be installed for 4.8 GPU-hours | A corpus can deliver them, at 2.1× a text corpus | An image input alone delivers **nothing** |

---

## Connections

- **[[wiki/entities/varc.md]]** — the same reformulation of ARC as an image-to-image problem reached from the opposite end, and the direct disagreement: VARC removes pretraining entirely and scores 60.4% where this paper's pretrained-video route scores 16.75%, so the two together say the *format* is what matters and the *corpus* is a comparatively weak way to deliver it (`T154`).
- **[[wiki/entities/conceptarc.md]]** — where this paper's most discriminating measurement lives: a concept-by-concept profile that anticorrelates between modalities (Count 0.83 VDM / 0.17 LLM, Order 0.07 / 0.27), which is the instrument doing exactly what its designers built it for — separating solvers instead of letting them all bottom out.
- **[[wiki/entities/arc-agi.md]]** — scored under the official two-attempt protocol, with the scale-matched pair (16.75 vs 8.00) rather than the commercial leaderboard as the claim.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the rare paper that measures this page's quantity rather than citing it: `n`-to-threshold curves per task family, with the 10× route-planning figure and the maze 13×13→21×21 transfer as conversion rates with priors held as fixed as two backbones allow.
- **[[wiki/concepts/test-time-training.md]]** — the adaptation mechanism, here a per-task LoRA fit on a frozen generative backbone rather than on a task-corpus model, and the paper's named failure: the VDM has no in-context route, so every task is paid for in gradient steps.
- **[[wiki/concepts/inductive-bias.md]]** — the complement of VARC's price list: where VARC prices each prior by adding it one at a time, this prices a whole *delivery mechanism* (a video corpus) by the examples it saves downstream, and finds the saving is a function of the input's dimensionality (null on 1D cellular automata, large on 2D).
- **[[wiki/entities/blindtest.md]]** — the same VLM null from the other side: BlindTest shows frontier VLMs fail rule-free grid perception, this paper shows that giving a VLM the image instead of the text costs it everything (0.00 vs 0.06 on Sudoku), so the image channel into a language model is not a perception channel.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the survey's "a video model downgrades to an image model" concern inverted: here the *absence* of a caption channel is the design, the text embedding is held neutral, and what transfers is spatial structure rather than described content.
- **[[wiki/concepts/learned-world-models.md]]** — a generative next-frame model used as a reasoner rather than as a simulator: the same weights that predict video dynamics are asked to emit the answer to a puzzle, which makes "world model" and "problem solver" the same object for the length of one LoRA.
