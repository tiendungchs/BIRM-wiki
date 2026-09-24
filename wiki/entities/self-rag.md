# Self-RAG — A Learned Gate on the Read, and a Self-Critique That Picks Among Parallel Reads

**Self-RAG (Self-Reflective Retrieval-Augmented Generation) trains one language model to emit four kinds of extra tokens alongside its text: whether to retrieve, whether a retrieved passage is relevant, whether the segment just written is supported by that passage, and how useful the whole answer is. At inference the retrieve token gates the read. When the gate opens, each of `K` passages drives its own candidate segment, and the critique tokens rank the candidates in a segment-level beam. The number of reads is therefore a model output, not a schedule. That is the half of the controller [[wiki/entities/ircot.md]] lacks. But the gate is only half-learned: on PopQA the model's own retrieve decision scores 28.3, a hand-set threshold on the same token scores 45.5, and never retrieving scores 24.7. So a hand-set criterion does most of the work (`G15`, `G107`). The critique is distilled into the generator, so the acceptance test runs on the same weights it checks.**

> **Provenance.** Asai, Wu, Wang, Sil & Hajishirzi 2023, *Self-RAG: learning to retrieve, generate, and critique through self-reflection*, arXiv:2310.11511v1, ICLR 2024 (`raw/asai-2023-self-rag-learning-to-retrieve-generate-and-critique.md`, arxiv HTML clip). Everything below comes from that source unless marked. The clip lost every inline token glyph, the segment-score equation (Eq. 4) and the threshold equation (App. A.3). The formulas below are rebuilt from the surrounding prose, which states both. Figures 3(b), 3(c) and 4(a–c) are image-only in the clip. Their results are quoted from the text and carry no numbers. **"ARC" on this page is ARC-Challenge, the AI2 grade-school science multiple-choice set. It is not [[wiki/entities/arc-agi.md]].**

---

## Architecture

| Component | Spec | Note |
|---|---|---|
| **Generator `M`** | Llama2 7B or 13B. The vocabulary is expanded with the reflection tokens | Trained by next-token loss on `D_gen`. Retrieved passages are masked out of the loss |
| **Critic `C`** | Llama2-7B, trained by conditional LM loss `max E log p_C(r \| x, y)` on GPT-4 labels | Used **offline only**, to insert tokens into the training corpus. It is not hosted at inference |
| **Retriever `R`** | Off-the-shelf Contriever-MS MARCO, frozen. Default top-5 passages; up to 10 at training | +5 web-search passages for biographies and open QA. GTR-XXL top-5 for ASQA (same passages for all baselines) |
| **Segment** | One sentence | Beam search runs over segments. Decoding inside a segment is greedy |
| **Read cue** | `(x, y_{t−1})`: the input plus the previous segment | Also the model's own last output, the same key family as IRCoT's `s_t` |

### Reflection tokens (Table 1)

| Type | Conditioned on | Values | Emitted |
|---|---|---|---|
| **Retrieve** | `x` or `x, y` | yes / no / continue (reuse the passage already held) | Before each segment |
| **IsRel** | `x, d` | relevant / irrelevant | After each passage |
| **IsSup** | `x, d, y` | fully / partially / no support (contradictory) | After each segment |
| **IsUse** | `x, y` | 5 … 1 ("perceived utility", scored independently of factuality) | Once, at the end |

### Inference

- **Gate.** Retrieve if `p(Retrieve=yes) / Σ_v p(Retrieve=v) > δ`. By default `δ = 0.2`. For ALCE it is `δ = 0`, because citations are required. Hard mode retrieves iff the argmax token is `yes`.
- **Parallel reads.** `K` passages each produce one candidate `y_t`, plus the IsRel and IsSup tokens for that passage.
- **Segment score:** `f(y_t, d) = p(y_t | x, d, y_{<t}) + Σ_G w^G s_t^G`, with `G ∈ {IsRel, IsSup, IsUse}`.
  - `s_t^G = p_t(r̂) / Σ_{i=1}^{N^G} p_t(r_i)`, where `r̂` is the most desirable value of group `G`.
  - Default `w = 1.0 / 1.0 / 0.5`. The weights can be changed at test time with no retraining.
- **Beam.** Segment-level beam width `B = 2`. The best full sequence is returned.
- **Hard constraint (alternative).** Drop any continuation whose IsSup token is `no support`.

### Training (Alg. 2–3)

1. **Critic labels.** GPT-4 is prompted per token type, with an instruction plus demonstrations, at temperature 1. After format filtering the counts are 12,594 / 11,181 / 19,317 (relevance) / 3,831 (utility). The clip drops the first two type names.
   - Author spot-check of 20 items per type: agreement 95% relevance, 95% retrieval necessity, 90% support, 80% utility.
2. **Critic accuracy against held-out GPT-4 labels** (Fig. 5, column labels lost in the clip):
   - Llama2-7B: 93.8 / 93.5 / 80.2 / 73.5 (utility).
   - FLAN-3B: 85.6 / 73.1 / 82.0 / 72.1.
   - Utility errors are mostly 4-vs-5 confusions.
3. **Generator corpus.** 145,619 instruction–output pairs: Open-Instruct subsets, Natural Questions, Wizard of Wikipedia, FEVER, OpenBookQA, ARC-Easy and ASQA.
   - The critic decides per sentence whether to retrieve. If yes, the query is (input, that sentence).
   - Among the retrieved passages it keeps the highest-retrieval-score one marked relevant and fully or partially supported. If there is none, it samples one at random.
4. **Generator training.** Standard next-token loss over text plus tokens. 3 epochs on 4 A100s. There is no RL and no reward model in the loop.

---

## Key results

### Main table (Table 2, zero-shot)

| Model | PopQA acc | TriviaQA acc | PubHealth acc | ARC-Challenge acc | Bio FactScore | ASQA str-em | ASQA cite prec | ASQA cite rec |
|---|---|---|---|---|---|---|---|---|
| Llama2-7B, no retrieval | 14.7 | 30.5 | 34.2 | 21.8 | 44.5 | 7.9 | – | – |
| Llama2-7B + retrieval | 38.2 | 42.5 | 30.0 | 48.0 | 78.0 | 15.2 | 2.9 | 4.0 |
| Llama2-FT-7B + retrieval (same 150k data, no tokens, no passages in training) | 48.7 | 57.3 | 64.3 | 65.8 | 78.2 | 31.0 | 5.0 | 7.5 |
| Alpaca-13B + retrieval | 46.1 | 66.9 | 51.1 | 57.6 | 77.7 | 34.8 | 2.0 | 3.8 |
| ChatGPT | 29.3 | 74.3 | 70.1 | 75.3 | 71.8 | 35.3 | – | – |
| Ret-ChatGPT | 50.8 | 65.7 | 54.7 | 75.3 | – | **40.7** | 65.1 | **76.6** |
| **Self-RAG 7B** | 54.9 | 66.4 | 72.4 | 67.3 | **81.2** | 30.0 | 66.9 | 67.8 |
| **Self-RAG 13B** | **55.8** | 69.3 | **74.5** | 73.1 | 80.2 | 31.7 | **70.3** | 71.3 |

- **Retrieval alone does not help where the answer cannot be copied.** On PubHealth and ARC-Challenge the retrieval baselines barely move from no-retrieval, and Llama2-7B drops 34.2 → 30.0 on PubHealth. Self-RAG gains there.
- **The citation columns are where the tokens pay.** Open retrieval baselines cite at 2–8% precision. Self-RAG cites at 67–70%, above Ret-ChatGPT on precision and below it on recall.
- **The 7B beats the 13B on FactScore** (81.2 vs 80.2), because the 7B writes shorter, precisely grounded outputs. So a grounding score can be bought with length.
- **Not only the data.** Llama2-FT-7B is trained on the same 150k pairs without tokens or passages. It trails Self-RAG 7B on every column. Its scores barely move from 50k to 150k, while Self-RAG's keep rising, most on PopQA and ASQA (figure-only).

### Ablations (Table 3a; 7B trained on 50k pairs; ASQA on 150 sampled items)

| Variant | PopQA | PubHealth | ASQA em |
|---|---|---|---|
| **Self-RAG (50k)** | **45.5** | **73.5** | **32.1** |
| *Train:* no retriever (instruction-tuned, no passages) | 43.6 | 67.8 | 31.0 |
| *Train:* no critic (always top-1 passage, no tokens; ≈ SAIL (Search-Augmented Instruction Learning)) | 42.6 | 72.0 | 18.1 |
| *Test:* no retrieval | 24.7 | 73.0 | – |
| *Test:* hard constraints (retrieve iff argmax = yes) | 28.3 | 72.6 | – |
| *Test:* retrieve top-1 always, no critique ranking | 41.8 | 73.1 | 28.6 |
| *Test:* drop the IsSup term from the beam score | 44.1 | 73.2 | 30.6 |

The "IsSup" label in the last row comes from §3.3 and §5.2 context. The clip dropped the token glyph.

**The gate row, read against the no-retrieval row.** On PopQA, retrieval is worth 20.8 points (24.7 → 45.5).
- The model's own argmax decision recovers 3.6 of them (28.3).
- Moving the criterion to `δ = 0.2` on the same token probability recovers the rest.

So the token carries a usable *ranking* of when retrieval is needed. But its built-in criterion is set far too conservatively for PopQA's long-tail entities. The threshold that fixes this is hand-set, and it is set differently per task (`0.2`; `0` for ALCE). Fig. 3(c) shows that retrieval frequency swings widely with `δ`. It also shows that the accuracy cost of retrieving less is small on PubHealth and large on PopQA, so no single `δ` suits both. The clip gives no numbers for that figure. **The comparison the gate needs, learned gate against always-retrieve-with-critique at matched `K` and `B`, is not in the clip's numbers.**

### Other measurements

- **Parametric vs retrieved answers (App. C.1).** Among correct TriviaQA and PopQA answers, the share *not* a substring of the provided passages:
  - Self-RAG 7B 2%, Alpaca 15%, Llama2-chat-13B 18%, a third Alpaca model 20% (the text says "Alpaca 30B").
  - When passages are irrelevant, Self-RAG emits `irrelevant`, while the baselines keep producing plausible answers.
- **Test-time weights (Fig. 3b, figure-only).** Raising `w^IsSup` raises ASQA citation precision and lowers MAUVE fluency: longer, more fluent text makes more unsupported claims.
- **Human check (50 samples each, Fig. 4d):**

  | | PopQA | Bio |
  |---|---|---|
  | Supported-and-plausible | 92.5 | 70.0 |
  | IsRel agreement with humans | 95.0 | 90.0 |
  | IsSup agreement with humans | 90.0 | 85.0 |

  Instances where the model predicted `irrelevant` or `no support` are excluded from the supported-and-plausible score.
- **A labelled failure (Table 6).** *"Who is the author of The Lie?"* retrieves a passage about Sam Harris's *Lying*. The model tags the passage `relevant` and the answer `fully supported`. Both tags are wrong. IsSup certifies that the segment matches the passage. It does not certify that the passage is about the entity asked for.

---

## Limitations

- **The gate's criterion is hand-set.** The learned token supplies a ranking. The operating point (`δ`) and the critique weights (`w^G`) are per-task constants. The authors present this as a feature: customisation with no retraining. For `G107` it is the same hole moved one level: the price of a read is still external.
- **Not a re-read.** The cue `(x, y_{t−1})` changes every segment. The `K` passages at one step are `K` *different* reads, ranked against each other. The `continue` token reuses a passage *without* reading again. Nothing re-presents the same cue to the same store (`G123`).
- **Not compute-matched.** Each open gate costs `K` generator passes plus critique tokens. "Retrieve top-1" differs from the full model in both passage count *and* ranking, so the −3.7 (PopQA) and −3.5 (ASQA) points do not split between them.
- **The acceptance test shares weights with the proposer.** The critique labels come from GPT-4, which is outside the generator. At inference, though, the tokens are sampled from the generator itself. The critic's own accuracy is only measured as agreement with GPT-4 labels, and human agreement is measured on 50 items. Neither measures whether a critique token *discriminates* the model's correct segments from its incorrect ones ([[wiki/concepts/metacognitive-efficiency.md]]).
- **Provenance is emitted, not kept.** Each segment carries a passage pointer and a support grade at generation time. Nothing stores the tag with the content downstream or tests it after a delay (`G71`).
- **Retriever frozen, index fixed.** No write. The Wikipedia dump matters: the 2018 dump lacks entities that PopQA's 2022 WikiData questions need, so PopQA was run on a Dec-2020 dump.

---

## Comparison to related models

| | Standard RAG | [[wiki/entities/ircot.md]] | **Self-RAG** | [[wiki/concepts/adaptive-computation-time.md]] |
|---|---|---|---|---|
| When to read | always, once | after every sentence | learned token `>` hand-set `δ` | — (halts computation, not reads) |
| Read cue | `x` | last generated sentence `s_t` | `x` ⊕ last segment `y_{t−1}` | — |
| Reads per step | 1 | 1 (`K` paragraphs appended) | `K` in parallel, one candidate each | — |
| Selection after the read | none | none; append-only buffer | self-critique beam over `K` candidates | — |
| Stop | fixed length | `"answer is:"` / step cap | end of generation | halting unit `> 1−ε`, price `τ` |
| Trained | reader only (or none) | nothing (frozen, few-shot) | generator on critic-labelled corpus | end to end |
| Hand-set constant | `K` | step cap | `δ`, `w^G`, `B`, `K` | `τ` |

**(brainstorm) The gate and IRCoT's schedule are complements, and nobody has run the product.** IRCoT shows that re-keying each read on the reasoner's last derived statement is worth up to +22.6 recall. Self-RAG shows that a trained token can rank *when* a read is needed, and that ranking the `K` outcomes of a read by self-critique beats taking the top one. IRCoT fires every sentence, and Self-RAG's multi-hop performance is not reported. The untested prediction: on the IRCoT multi-hop sets, putting Self-RAG's gate on IRCoT's loop should cut the number of reads substantially with little recall lost on comparison questions, where the second hop is often unnecessary. Bridge questions should keep nearly every read.

---

## Connections

- **[[wiki/entities/ircot.md]]** — the mechanism this page puts a controller over. Both key the next read on the model's own last sentence. IRCoT reads after every sentence and keeps everything it reads. Self-RAG decides per segment whether to read and ranks the `K` outcomes by self-critique. Neither re-reads on a fixed cue.
- **[[wiki/entities/default-mode-network.md]]** — the first machine instance of that page's "retrieval graded by how much the construction must be constrained by real episodes". The retrieve token is trained on GPT-4's judgement of whether a continuation needs factual grounding. But retriever and generator are still wired directly, with no hub between them and no mutual suppression.
- **[[wiki/concepts/external-verification.md]]** — a rung where the acceptance test is *internalised*. The critique labels originate outside the generator (GPT-4 → critic), but at inference they are sampled from the generator's own weights. So the rung prices well (−14.0 ASQA em without the critic in training) yet shares the generator's misreadings, as in the entity-mismatch case tagged `fully supported`.
- **[[wiki/concepts/metacognitive-efficiency.md]]** — the gate is a type-2 decision ("does my parametric memory suffice?") whose *criterion* is miscalibrated while its *ranking* is usable. Moving `δ` from argmax to 0.2 is a pure bias shift worth 17.2 PopQA points. The critic's quality is reported only as agreement rates, the bias-confounded measure that page deprecates.
- **[[wiki/concepts/adaptive-computation-time.md]]** — the same price-of-computation constant on the retrieval axis. `δ` plays ACT's `τ`: a hand-set exchange rate between another read and accuracy, retuned per task (`G107`).
- **[[wiki/concepts/analogical-mapping.md]]** — a generation-time answer to that page's provenance-loss result. Every segment carries a passage pointer and a support grade, and answers not grounded in retrieved text fall from 15–20% to 2%. The tag certifies overlap with the passage rather than truth, and it is never shown to survive downstream (`G71`).

---

**Sources:** Asai et al. 2023 (`raw/asai-2023-self-rag-learning-to-retrieve-generate-and-critique.md`).
