# Shortcut Suite

**A controlled-shortcut benchmark built by *logical conjunction*: append a universally true statement to the premise, and the label is preserved by proof rather than by an annotator's judgement — so any accuracy drop is attributable to the injected surface cue and to nothing else (Yuan, Zhao, Zhang, Zheng & Liu 2024).**

6 shortcut types × 5 metrics × 4 prompt settings, over 8 LLMs (GPT-3.5-Turbo, GPT-4, Gemini-Pro, LLaMA2-Chat-7B/13B/70B, ChatGLM3-6B, Mistral-7B; LLaMA3-8B/70B-Instruct in the appendix). Substrate: MultiNLI (3,000 balanced development items) and HANS (Heuristic Analysis for NLI Systems, 3,000 per heuristic). Extended to Sentiment Analysis (SST-2) and Paraphrase Identification (QQP → PAWS). NLI, ICL, CoT, SST-2, HANS: see [[wiki/glossary.md]].

---

## The construction

Given premise `q`, hypothesis `h` with gold label `l`, and a statement `s ≡ ⊤`:

```
q ∧ s ≡ q ∧ ⊤ ≡ q     ⇒     {(q ∧ s, h, y) | y = l}
```

The item now carries **two sufficient mappings to `l`**: the semantic relation `x → l` and the injected cue `s → l`. Which one the model uses is unobservable in-distribution and is exactly what the drop measures.

**Why the tautology matters and is not a detail.** Every rewrite-based instrument in [[wiki/concepts/certification-instruments.md]] must *establish* that the rewrite preserved the intended answer — GSM-Plus needed human revision on **18.85%** of its GPT-4-drafted variants, MATH-Perturb needs two expert rewrites per item. Here label preservation is a theorem about `∧`, so the perturbation costs a string concatenation and admits no annotation error. Three of the six shortcut types are literally `strcat`.

| Shortcut | Injected cue | Source |
|---|---|---|
| **Lexical Overlap** | premise entails any hypothesis built from its own words | HANS |
| **Subsequence** | premise entails its contiguous subsequences | HANS |
| **Constituent** | premise entails every complete subtree of its parse | HANS |
| **Negation** | append a negation-bearing tautology to the hypothesis (`and green is not red`, `and nothing comes from nothing`, …) | `strcat` on MultiNLI |
| **Position** | append `and red is red` ×5 at one of four sites (premise/hypothesis × start/end) | `strcat` on MultiNLI |
| **Style** | transfer the premise to Bible English (STRAP) | style-transfer model |

The Position set is the sharpest control in the suite and has no analogue elsewhere in the wiki: **content, label and inserted string are all held identical and only the insertion site varies**, so whatever it measures cannot be semantics.

---

## Accuracy (selected; full grid in the source)

Chance is 50% on the three HANS sets (`E` / `¬E` only), 33.3% on MultiNLI-derived sets.

| Setting | Model | Standard | Constituent `E` / `¬E` | Negation |
|---|---|---|---|---|
| zero-shot | GPT-4 | 85.6 | 96.7 / 80.0 | 54.3 |
| zero-shot | Gemini-Pro | 76.2 | 77.9 / **47.2** (below chance) | 53.1 |
| zero-shot | LLaMA2-Chat-13B | 54.3 | 95.9 / **0.8** | 54.6 |
| few-shot ICL | GPT-3.5-Turbo | 61.7 | 96.7 / **9.3** | 50.0 |
| zero-shot CoT | LLaMA2-Chat-13B | 56.3 | 53.9 / **41.7** (+40.9) | 49.2 |
| zero-shot CoT | GPT-4 | **81.3** (−4.3) | 96.0 / 94.0 (+14.0) | 58.3 |

**Few-shot ICL produces degenerate constant classifiers.** ChatGLM3-6B answers `entailment` on **100.0 / 0.0** for all three HANS heuristics; LLaMA2-Chat-70B reaches 100.0 / 99.8 / 99.6 on `E` against **3.6 / 3.1 / 1.6** on `¬E`. A benchmark reporting only the balanced mean would score these ~50% and call it chance-level competence; the `E`/`¬E` split shows the model has no decision rule at all.

**Negation and Style cost the frontier model too.** GPT-4 loses 15–35 points to Negation across all four prompt settings and up to 15.6 to Bible-English style transfer — on items whose truth conditions are untouched.

**Position.** The lowest per-model accuracy usually falls where the tautology is prepended to the premise (Gemini-Pro 50.7 start vs 62.8 end; LLaMA2-70B 51.8 vs 62.0; LLaMA2-13B 50.0 vs 57.9) — a primacy bias in relevance allocation. It is a majority pattern, not a law: GPT-3.5-Turbo runs the other way on the premise (61.3 vs 56.0) and GPT-4 on the hypothesis (76.4 vs 71.2).

**Scale runs the wrong way, and only under some prompts.** Under few-shot ICL, LLaMA2-Chat `¬E` accuracy falls monotonically with size — Lexical Overlap 75.3 → 48.5 → **3.6** and Subsequence 59.5 → 12.4 → **3.1** for 7B → 13B → 70B — and it persists in a newer family (LLaMA3 zero-shot Constituent `¬E`: 8B 40.1 → 70B **11.1**) while the same models' Standard scores *rise*. Under CoT the ordering reverses and LLaMA2-70B leads its family on most sets. Recorded as T228 in [[wiki/empirical-tensions.md]].

**Prediction distributions are skewed on balanced data.** GPT-3.5-Turbo, LLaMA2-7B and Mistral-7B over-predict `neutral` on the Standard set; LLaMA2-13B and ChatGLM3-6B over-predict `entailment`. On the Negation set GPT-4 and LLaMA2-13B shift toward `contradiction`, which is the classic negation-word artefact reproduced in a model that was never fine-tuned on the corpus.

---

## The label-free metrics

Three of the five need no gold answers, which is what makes them interesting for [[wiki/concepts/certification-instruments.md]].

| Metric | Definition | What it returned |
|---|---|---|
| **SFS** (Semantic Fidelity) | cosine similarity of BERT embeddings of prompt and output | 83.2 – 93.3 across every model × dataset cell — a ~10-point range with no discrimination. **Uninformative as published** |
| **ICS** (Internal Consistency) | fraction of chains with *no* pair of steps `(cᵢ, cⱼ), i<j` scoring `p_contra > 1/3` under an off-the-shelf NLI model; the answer is the last step | Mostly **below 50%** — over half of all CoT chains contradict themselves — and it *collapses precisely on the shortcut-answering subset*: Lexical Overlap `¬E` gives 5.3 (GPT-3.5), 4.1 (LLaMA2-7B), 6.9 (LLaMA2-70B), 11.3 (GPT-4) |
| **EQS** | `0.5·SFS + 0.5·ICS` | Tracks accuracy across models; inherits SFS's dead range, so it is ICS diluted by a constant |
| **CFS** (Confidence) | self-reported percentage confidence | Rarely below 60%, routinely far above the model's actual accuracy, **and the gap widens on the shortcut sets** |

**ICS is the contribution.** It needs no labels, no distribution shift, no second model of the system under test, no human rater and no known invariance — only one NLI classifier run pairwise over the emitted steps. Every label-free instrument the wiki already holds needs more: `I9` needs a declared meaning-preserving transform, `I6` needs authored contrast pairs, `I8` needs a generator that emits two instances of one mechanism. And its signal is in the right place — the chain is *most* self-contradictory exactly where the shortcut is being exercised, which is what converts it from a fluency score into a shortcut detector.

**CFS restated as a differential.** The interesting quantity is not overconfidence — [[wiki/entities/hle.md]] already measures RMS calibration error of 73–89% — but that the confidence–accuracy gap is **larger on the shortcut arm than on the matched standard arm**. Miscalibration is therefore not a uniform offset; it is a function of whether a shortcut was available, which means a paired calibration gap is a candidate shortcut statistic in its own right. `(brainstorm)` It needs labels on both arms, so it is dearer than ICS, but unlike accuracy it does not require the two arms to be equally difficult — the model's own confidence supplies the normalisation.

**Two data-quality caveats, stated because the wiki quotes these numbers.** The EQS table prints **126.8** for LLaMA2-70B on Subsequence `E`, which is impossible under `0.5·SFS + 0.5·ICS` with both terms ≤ 100. And §5.2.1's prose attributes "41.5% Standard → 13.5% Negation" to LLaMA2-Chat-70B while Table 4 shows those two values on LLaMA2-Chat-**13B** (70B reads 33.9 → 25.4). The qualitative claim survives either reading; the specific figures should not be re-quoted from the prose.

---

## Three error types (hand-classified from CoT traces)

| Error | Mechanism | Evidence |
|---|---|---|
| **Distraction** | attention captured by the repeated tautology, original content dropped; local rather than global context | the Position set, and the start-of-sentence bias |
| **Disguised comprehension** | word- and structure-level distinctions collapsed — `that`/`believed` swapped and read as synonymous; Bible style not parsed | the Style and Constituent sets |
| **Logical fallacy** | intricate inference reduced to an over-general rule ("knows of the lawyer thanking the actor" ⇒ "knows the lawyer") | the Subsequence set |

These are the *unintended rules* [[wiki/concepts/rule-level-evaluation.md]] classifies by hand on ARC, obtained here on a corpus with a machine-generatable shortcut — so the two instruments compose: this construction supplies the items, that instrument reads the rule.

---

## The result that transfers furthest: the fix is not in the prompt

| Prompt (GPT-3.5-Turbo) | Standard | Constituent `¬E` |
|---|---|---|
| zero-shot | 56.7 | **40.2** |
| few-shot ICL, demonstrations drawn from MultiNLI | 61.7 | **9.3** |
| few-shot ICL, demonstrations drawn from *the same shortcut-laden set* | 61.7 | **35.0** |

Matched demonstrations recover most of what mismatched ones destroy and still do not reach zero-shot. **In-context examples are a net negative here regardless of how well they are chosen**, and the authors' reading is that the shortcut is inherited from pre-training and outweighs anything eight examples can install.

This is the **third independent replication** of the wiki's sharpest robustness claim, in a task family and with a prompt manipulation that neither earlier one used:

| Source | Manipulation | Result |
|---|---|---|
| [[wiki/entities/gsm8k.md]] NoOp-Symb | 8 shots of *the identical question* with its correct chain | drop persists within one SD |
| [[wiki/entities/gsm8k.md]] NoOp-NoOp | 8 shots of *other* items all requiring a clause be ignored | no help |
| **this page** | 8 shots drawn from *the same shortcut distribution* | recovers ICL's own damage, never reaches zero-shot |

Whatever selects relevant evidence sits **below the in-context-learning layer** and is not reachable by conditioning. Compare [[wiki/entities/math-perturb.md]], where one-shot ICL is actively two-signed (repairs 24–40%, creates 18–40% more) — across three benchmarks the sign of ICL's contribution to robustness is zero or negative.

---

## Limitations

- **NLI-anchored.** Six shortcuts, one task family; SA and PI are one shortcut each. Question-answering and coreference are named as untested.
- **No mitigation.** The paper proposes nothing beyond "fine-tune on unbiased data, prompt with CoT, add retrieval" — none of which its own Table 7 supports for the ICL half.
- **The tautology is *conspicuous*.** `and red is red` ×5 is not a natural distractor; GSM-NoOp's clause looks pertinent and is the harder test. The trade is legibility for realism, and this construction buys the legible end.
- **CoT is confounded with output length and with the CoT trace being scored by ICS**; no length-matched control.
- **Style is measured through a transfer model (STRAP)**, so a Style drop may partly measure transfer artefacts rather than style sensitivity — the only one of the six shortcuts whose label preservation is *not* a theorem.

---

## Connections

- **[[wiki/concepts/shortcut-learning.md]]** — supplies that page's cheapest construction (label preservation by `q ∧ ⊤ ≡ q`, so a controlled shortcut costs a string concatenation and no annotation), the Position set's content-identical positional control, and the finding that the confidence–accuracy gap is larger where a shortcut is available.
- **[[wiki/concepts/certification-instruments.md]]** — supplies `I20` (tautological conjunction injection) and `I21` (intra-chain contradiction rate), the two cheapest instruments in that inventory: one needs no annotator, the other needs no labels at all.
- **[[wiki/entities/gsm8k.md]]** — the same conclusion from the other task family, and this page is its third replication with a manipulation GSM-Symbolic did not run (demonstrations drawn from the shortcut distribution itself); conversely GSM-NoOp supplies the realism this page's conspicuous tautologies give up.
- **[[wiki/entities/math-perturb.md]]** — the complementary sign on ICL: there one-shot demonstrations both repair and mislead with the misleading rate rising with capability, here demonstrations are uniformly worse than none, so no reading of ICL as a robustness fix survives either.
- **[[wiki/entities/anli.md]]** — the same substrate (MultiNLI, and HANS as the artefact diagnosis that motivated adversarial collection) with the opposite economics: ANLI pays ~5 minutes of annotation per item to *remove* an artefact, this pays one `strcat` to *install* one with a known identity.
- **[[wiki/concepts/rule-level-evaluation.md]]** — the natural pairing: this construction generates items whose unintended rule is known by construction, that instrument reads the rule the solver states — together they close the loop between the shortcut installed and the shortcut used.
- **[[wiki/entities/hle.md]]** — the overconfidence result at a different scale (RMS calibration error 73–89% on expert-authored items); this page adds that the miscalibration is *conditional on shortcut availability* rather than a constant offset.
- **[[wiki/concepts/external-verification.md]]** — a self-contradiction rate over 50% inside emitted chains bounds what any trace-reading verifier can be worth, and ICS is a rejector cheap enough to run on every sample.
- **[[wiki/empirical-tensions.md]]** — T228: model scale amplifies shortcut reliance under zero-shot and few-shot ICL and reverses it under CoT, so the sign of the scaling effect on robustness is a property of the prompt.
