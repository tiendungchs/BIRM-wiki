# BlindTest — a Visual-Acuity Exam for Geometric Primitives, and the Only Wiki Instrument That Prices Perception With No Rule Attached

**Seven tasks over lines, circles, squares, letters and coloured paths, each requiring zero world knowledge and solvable by a five-year-old, on which four frontier vision-language models average 58.07% against a random baseline of 24% and a human expectation of 100%. The failures are not blur: pushing the same primitives apart restores near-100% accuracy, and a linear probe on the *frozen vision-encoder features* solves two of the tasks at ≥99.47% while the full model scores 33–84% on them. The information is encoded and not read.**

> **Provenance.** Rahmanzadehgervi, Bolton, Taesiri & Nguyen 2024, *Vision language models are blind: Failing to translate detailed visual features into words* (`raw/rahmanzadehgervi-2024-vision-language-models-are-blind.md`, arXiv 2407.06581v6, ACCV 2024; Auburn University + University of Alberta). Data and code at `vlmsareblind.github.io`. Clip carries HTML residue; all figures are unrecoverable and the model-identifying icons in every table were stripped, so per-model columns below are recovered from the prose rather than read off the tables where the two disagree (noted inline).

---

## Why the benchmark exists in this form

| Design constraint | Why it is imposed | What it buys the wiki |
|---|---|---|
| Tasks **authored from scratch**, not taken from human eye exams | Existing acuity charts (Snellen, tumbling `E`) are on the internet and GPT-4o already passes them; they also present *isolated* symbols, which is the easy case | A benchmark with no distributional-leakage route in — the `F1`/`F14` channel of [[wiki/concepts/benchmark-contamination.md]] is closed by construction rather than by audit |
| **Minimal-to-zero world knowledge**, minimal commonsense | A strong language model should be worth nothing here; the images are ones humans cannot naturally describe in words | Separates the reader from the prior: unlike [[wiki/entities/gpqa.md]]-style benchmarks, a null cannot be blamed on missing knowledge |
| Primitives are **interacting** — overlapping, nested, adjacent, intersecting | Models already count *disjoint* shapes and read *isolated* words at ceiling | The independent variable is *spatial interaction between primitives*, not object identity |
| Two semantically equivalent prompts per image; 3 image sizes; 2–3 line widths | Prompt and resolution are the standard confounds | A null cannot be attributed to phrasing or to input resolution, which is what `T291` demands of every capability absence |
| No prompt engineering, then 2-shot / chain-of-thought / meta-prompting tried separately | Same | All three give no gain — the models understand the questions and do not benefit from thinking aloud |

**Against ARC.** The authors state the relation exactly: ARC gives abstract images made of simple shapes and asks for a *rule* over them, thereby **assuming** the shapes can be identified; BlindTest measures that assumption directly. This makes it the wiki's first instrument that scores the perceptual stage of [[wiki/entities/arc-agi.md]] in isolation from any mapping — the factorisation [[wiki/concepts/rule-level-evaluation.md]] achieves by manual rule classification, obtained here by removing the rule instead.

---

## The seven tasks

| # | Task | Images | Random | 4-VLM mean |
|---|---|---|---|---|
| 1 | Count intersections (0/1/2) of two 2-segment piecewise-linear plots | 1,800; `C ∈ {384, 768, 1152}` px, endpoints fixed at `{0, C/2, C}`, `y` sampled on an invisible 12×12 grid | 33.33 | **56.84** |
| 2 | Are two equal circles overlapping / touching? | 224 per config; diameter `φ ∈ {C/4…C/7}`, boundary-to-boundary gap `φ·d`, `d ∈ [−0.25, 0.5]`, 4 orientations | 50.00 | **86.70** |
| 3 | Which letter is circled? (red oval over one letter of `Acknowledgement`, `Subdermatoglyphic`, `tHyUiKaRbNqWeOpXcZvM`) | 360 / 408 / 480; 3 oval thicknesses × 2 fonts × 4 paddings | 5.77 | **79.36** |
| 4 | Count overlapping circles ○ (Olympic-logo arrangement), `N ∈ {5…9}` | 240 | 20.00 | **39.44** |
| 4′ | Same with pentagons ⬠ | 240 | 20.00 | **30.99** |
| 5 | Count nested squares, `N ∈ {2…5}`, each 75% of its container, non-touching | 120; 1000×1000 px, line widths `{3,4,6}` px | 25.00 | **74.99** |
| 6 | Count rows and columns of a grid, `N ∈ {3…10}`, empty or one random word per cell | 264 | 4.55 | **47.35** |
| 7 | Count single-coloured paths between two of four stations on a subway map (2–8 paths, DFS-generated on an invisible 18×18 lattice) | `C ∈ {512, 1024}` px | 33.33 | **48.90** |

**Task mean: 58.07%** (GPT-4o 50.23 · Gemini-1.5 Pro 58.48 · Claude-3 Sonnet 45.73 · Claude-3.5 Sonnet **77.84**; random 24.00). Eight open-source models, 0.5B–72B, across LLaVA-OneVision, Phi-3.5-vision and InternVL-2, all underperform the four closed models.

---

## The four results that carry architectural weight

### 1. The encoder is not blind — the readout is (the paper's own title is wrong)

Linear probing, tasks 1 and 2, on **frozen** features average-pooled over image patches, logistic regression, 1,000 epochs, `L₂` weight 1.0. Train/val/test: 8,880 / 1,110 / 1,110 (two circles, 11,100 images) and 4,410 / 945 / 945 (line intersections, 6,300 images).

| Probe site | Two circles | Line intersections |
|---|---|---|
| **Before** the projection layer (vision encoder output) | 99.47 · 100.0 | 99.82 · 100.0 |
| **After** the projection layer | 99.58 · 100.0 | 99.73 · 100.0 |
| **Whole VLM**, same tasks | **33.14 · 37.78** | **73.21 · 83.63** |

Two encoders, chosen as the field's two defaults: SigLIP (in the 0.5B LLaVA-OneVision-qwen2-si) and CLIP (in the 4.2B Phi-3.5-vision-instruct) — *the source's Table 5 caption assigns these the other way round from its own Models paragraph; the pairing does not affect the conclusion, which holds for both encoders.* The smallest models were chosen deliberately: if their encoders retain enough, larger ones do too.

**The statement this licenses, and its precise scope.** For these two tasks, the visual information sufficient for a *linear* decision is present in the encoder output and survives the projection layer intact; the language model has access to it and fails to convert it into the right token. The failure is located at the **interface**, not at the sensor and not at the reasoner — which is neither position of `T215` and is the reason that row now carries a third stance. Scope: two of seven tasks, both binary/3-way, both with a *linearly* decodable answer; tasks 4–7 are counting tasks whose answers are unlikely to be linear in a pooled feature vector, and no probe is reported for them.

**Corroborating within-family evidence.** In LLaVA-OneVision the 0.5B and 72B models share an *identical* 400M SigLIP encoder and differ only in the Qwen2 decoder; the 72B substantially outperforms the 0.5B on tasks 3 and 4. With the encoder held fixed, the decoder moves the score — so the decoder is acting as an extended vision encoder, "reading out" what SigLIP already wrote.

### 2. Space is a dial, and the failure mode is spatial interaction

Every task recovers when the primitives are separated, with the amount of recovery differing by model:

| Manipulation | Result |
|---|---|
| ≥1 ASCII space inserted between letters (task 3) | All VLMs improve; two models gain >+20 points (72→92, 46→72). Sonnet-3.5 reaches **95%** at 3 spaces. Its residual 40 errors: 12 adjacent-letter, 13 confusing the red oval as part of the letter (`@` for `a`), 15 predicting `g` for `q` |
| Circles/pentagons pushed apart until disjoint (task 4) | Sonnet-3 and Sonnet-3.5 reach **≥96%** at `dx = 0.75`; Δ = **+91** for Sonnet-3, **+22** for GPT-4o. Gemini-1.5 does not benefit, because its error is the prior below, not the spacing |
| Straight-run probability in path generation raised `P = 0.33 → 0.9` (task 7) | +2 for GPT-4o, **+30** for Sonnet-3.5; three models reach 0.95–0.99 |
| One random English word added to each grid cell (task 6) | Accuracy roughly **doubles** (GPT-4o 26.13 → 53.03); Sonnet-3.5 59.84 empty → 88.68 text-filled. Columns are counted better than rows (70.53 vs 60.83) |

This is the ablation that rules out "the question is out of distribution" and "the prompt is bad", leaving *primitives close together* as the operative variable. It also supplies something the wiki has been missing: **a continuous difficulty parameter over a perceptual task with a measured accuracy curve on it** — the clearance between primitives, which is the same quantity [[wiki/concepts/incremental-grouping.md]] uses to *select a processing scale*. The Mollard et al. architecture predicts exactly this curve and cancels it by moving grouping up a scale; a VLM has no scale to move to.

### 3. Longer inference buys nothing

| Model | Task mean | Slow-thinking counterpart | Task mean |
|---|---|---|---|
| Gemini 2.0 Flash | 72.75 | Gemini 2.0 Flash-Thinking | **71.59** |
| Qwen2-VL 72B | 54.13 | QVQ-Preview 72B | **42.48** |

Inspection of Gemini's thinking traces: the hidden thoughts are **in text space** and have nothing to operate on. This is the cleanest available demonstration that a serial deliberation budget spent in the *wrong representation* is worthless — the failing operations (trace this path, count these rows) are ones [[wiki/concepts/visual-routines.md]] places in an image-addressed store, and no amount of token-space iteration reaches it. Compare [[wiki/concepts/adaptive-computation-time.md]]: a ponder budget is only a fix if the extra steps run over the representation that holds the answer.

### 4. A memorised configuration overrides the parse

All four models count **5** overlapping circles at ≥83%; at `N = 6` accuracy falls to near zero for every model except Sonnet-3.5. When Gemini-1.5 is wrong it answers "5" **99.74%** of the time regardless of the true count. Pentagons — the same task with a shape carrying no famous 5-instance configuration — are *harder at every `N`*, including `N = 5`, where three of four models are at or below chance. The 5-circle score is therefore not evidence of counting; it is the Olympic logo. Textbook [[wiki/concepts/shortcut-learning.md]], and a worked case of a prior that is only visible because the benchmark varies the shape while holding the task fixed.

Related familiarity effects: models score +0.46 to +13 points higher on the two English words than on the random string (task 3), and grids nearly double when filled with text (task 6) — in both cases the language prior substitutes for a parse it cannot perform.

---

## What it measures against the wiki's operation sets

The tasks map almost one-to-one onto [[wiki/concepts/visual-routines.md]]'s proposed elemental operations, which is what makes this a usable instrument rather than a list of failures:

| BlindTest task | Elemental operation it isolates |
|---|---|
| 7 (path following), 1 (line intersections) | **Boundary tracing** — "are these two marks on the same curve?" |
| 4, 4′, 6 (counting shapes, rows, columns) | **Marking** — index the strongest signal, switch it off, repeat; limited by the spatial resolution of the mark |
| 5 (nested squares), 2 (overlap) | **Bounded activation / colouring**, and the inside/outside predicate Minsky & Papert prove unavailable to any order-limited reader |
| 3 (circled letter) | **Indexing** to a local odd-man-out, then reading a property *at* that index |

The profile is the one [[wiki/concepts/visual-routines.md]] predicts from the Minsky–Papert result: connectivity and containment predicates in clutter are floored, local predicates over well-separated items are at ceiling, and the floor does not lift with model scale or inference length — it lifts only when the *clutter* is removed. That is the prediction being confirmed by a benchmark authored without reference to it.

**What it does not measure.** Nothing here requires a rule, a mapping, or generalisation to a held-out transformation — deliberately. A BlindTest score is therefore a **floor report** to be printed beside an ARC score, not a substitute for one, and it says nothing about `G36`'s construction question: a perfect BlindTest score would certify a parser, not a reasoner.

---

## Use as an instrument

- **`I`-row candidate for [[wiki/concepts/certification-instruments.md]]**: report a perception floor on the same model, under the same harness, alongside any ARC-format score. Cost: 7 task generators, zero human labels, zero world knowledge, and a ground truth that is exact by construction. It is one of the very few wiki instruments whose human baseline is not a protocol dispute ([[wiki/concepts/human-baseline.md]]) — it is 100% by design, and the authors verify that the models can read the same strings and count the same shapes when presented in isolation.
- **The spacing dial makes it a graded instrument, not a pass/fail one**: reporting the *clearance at which a model reaches 95%* is a scalar summarising a model's effective spatial acuity, comparable across architectures, and far more informative than the aggregate 58.07%. No source in the wiki reports it, and it is free from the released data.
- **Re-scoring existing ARC results against it is unrun.** The wiki's ARC scores are overwhelmingly on the *textual* serialisation, which `T215` establishes is the easier modality; this benchmark prices the visual modality's floor, and the two have never been placed on one axis.

---

## Limitations

- **Four closed models plus eight open ones, all mid-2024 to early-2025 vintage.** Sonnet-3.5's 77.84% against Sonnet-3's 45.73% is a 32-point jump inside one model family within months, so the absolute numbers are a snapshot, not a property of the architecture class. The *pattern* — recovery with spacing, null from slow thinking, probe/model gap — is what should be treated as the finding.
- **The linear probe covers two tasks and two small open models.** The claim "the LM fails to decode" is established for a binary and a 3-way decision, both linearly separable in pooled features; it is *extrapolated* to the counting and tracing tasks, where a linear probe would probably fail for reasons that have nothing to do with the readout.
- **Average pooling over patch features is itself a readout choice.** That a pooled representation supports a linear classifier trained on 8,880 in-distribution images does not show the *same* information is addressable by a model that has never been given a supervised signal for this decision. The probe measures presence, not accessibility — and accessibility is the architectural quantity. `(brainstorm)` The honest version of the claim is a channel statement: the information survives the projection layer, and the language model lacks a *routine* for querying it at a location — which is precisely the narrow-read-out-channel argument [[wiki/concepts/visual-routines.md]] derives from the conjunction-search result, arrived at from the opposite direction.
- **One incidental finding worth keeping.** Training the probe only on the *hard* split (circle gap `d = ±0.05`) yields 100% on easy splits (`d = ±0.25`); training on the easy split transfers poorly to the hard one. Curriculum asymmetry on a purely perceptual decision, consistent with [[wiki/concepts/curriculum-learning.md]]'s hard-example arguments and obtained with no rule in the loop.
- **Human 100% is asserted, not measured.** The authors argue from task design (a five-year-old can do these) rather than from a run. Under [[wiki/concepts/human-baseline.md]]'s own rule that a baseline is a protocol, this is the one number in the paper with no protocol attached — it is almost certainly close to right, and it is still an estimand nobody specified.

---

## Connections

- **[[wiki/concepts/visual-routines.md]]** — the benchmark is an unwitting test of that page's operation set: each task isolates one elemental operation (tracing, marking, bounded activation, indexing), and the measured failure profile — connectivity and containment floored in clutter, local predicates at ceiling, no lift from scale or inference length — is the Minsky–Papert prediction for an order-limited reader, confirmed by authors who never cite it.
- **[[wiki/concepts/visual-indices.md]]** — the same capacity signature from the opposite side: the pool is 4–5 pointers and models count 5 overlapping circles at ≥83% then collapse at 6, while *concentrically nested* squares — the arrangement Trick & Pylyshyn show humans cannot subitize either — are the one counting task where models do best, so the machine and human limits are not the same limit despite both landing near five.
- **[[wiki/concepts/numerosity.md]]** — the machine counterpart of the subitizing/estimation split: accuracy holds to `N = 5` and falls off a cliff rather than degrading with Weber-scaled imprecision, which is the signature of a retrieved configuration (the Olympic logo) rather than of either the exact serial routine or the tuned approximate code.
- **[[wiki/concepts/incremental-grouping.md]]** — supplies the missing scale mechanism this benchmark's spacing dial exposes: clearance between target and distractor is the quantity that selects a processing level there and the quantity that moves VLM accuracy from floor to ceiling here, and a VLM has no scale hierarchy to move grouping into.
- **[[wiki/concepts/rule-level-evaluation.md]]** — the same factorisation of an accuracy score into perception and rule, obtained by removing the rule instead of by classifying it: that page's separately-scored 49.1–77.3% visual-error rates and this benchmark's 58.07% are two measurements of one quantity, one manual and task-coupled, one automatic and rule-free.
- **[[wiki/entities/arc-agi.md]]** — prices the assumption every ARC score rests on: ARC asks for a rule over shapes it assumes are identifiable, and path tracing and row/column counting — the operations an ARC grid demands most — are precisely the two tasks scored lowest here.
- **[[wiki/entities/conceptarc.md]]** — the complementary instrument at the other end of the same pipeline: ConceptARC varies the *concept* with perception held easy, BlindTest varies the *perceptual clutter* with the concept removed entirely, so a joint report separates which of the two a modality gap lives in.
- **[[wiki/concepts/shortcut-learning.md]]** — a worked case of a prior overriding a parse, visible only because the benchmark varies the shape while holding the task fixed: Gemini-1.5 answers "5" 99.74% of the time when it miscounts circles, and the same models are worse on pentagons at every `N`.
- **[[wiki/concepts/benchmark-contamination.md]]** — the design closes the leakage channel by construction rather than by audit (tasks authored from scratch, absent from the internet, requiring no retrievable knowledge), which is why a null here is stronger evidence than a null on a knowledge-loaded benchmark.
- **[[wiki/concepts/certification-instruments.md]]** — a candidate instrument with an unusually low price: no human labels, exact ground truth, a continuous difficulty dial (inter-primitive clearance), and a human baseline that is 100% by construction rather than by protocol.
- **[[wiki/concepts/adaptive-computation-time.md]]** — the negative control that page needs: a deliberation budget spent in token space over a visual failure buys nothing (71.59 vs 72.75; 42.48 vs 54.13), so extra steps only help when they run over the representation that holds the answer.
- **[[wiki/concepts/cross-modal-grounding.md]]** — localises the late-fusion cost the training-family taxonomy leaves abstract: features are extracted before the question is seen, and a linear probe recovers ≥99.47% of what the full model then fails to report, so the defect is in the encoder→decoder interface rather than in either component.
- **[[wiki/concepts/human-baseline.md]]** — the rare case where the baseline is uncontested in value and still unspecified as a protocol: 100% is asserted from task design with no run behind it.
- **[[wiki/concepts/active-vision.md]]** — names what a fix would cost: every failing task is one a human solves by moving the eye or the processing focus and re-reading the display, which a single forward pass over a pooled feature map denies, and the spacing dial is a measure of how much clutter that denial can tolerate.
- **[[wiki/entities/varc.md]]** — the constructive half of the same argument: this page shows frontier VLMs floor on grid counting and path tracing with no rule attached, and VARC shows that a small vision model given the grid as an *image* with translation and scale invariance clears the rules at human-average level — together they make `T215`'s perceptual reading the one with evidence on both signs.
- **[[wiki/entities/vdm-i2i.md]]** — the same VLM null reached from the training side: a Gemma-3-4B fine-tuned on Sudoku scores 0.06 on text, 0.06 on image+text and 0.00 on image alone, and when asked merely to transcribe its own image input it memorises training samples verbatim — so the channel this page shows is *computed but not read* is also *not learnable* by fine-tuning through it.
