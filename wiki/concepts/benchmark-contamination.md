# Benchmark Contamination

**A benchmark item that sat in the training corpus is not withheld from the model, so its score measures recall rather than the ability the benchmark names — and the standard detector for this (compare the model's familiarity with the train split against the test split) returns the *same* signature for a clean model and for the worst case, a model that saw both.**

This page is the wiki's account of the leakage channel that sits underneath every score it carries. It is separate from [[wiki/concepts/certification-instruments.md]] on purpose: that page asks *did the system discover the structure?* and is aimed at architectures; this one asks the prior question *was the item withheld at all?* and is aimed at corpora. Failure modes `F1` (developer-blindness is a depleting stock) and `F2` (item-blindness is not distributional blindness) live there and are this page's two boundary conditions.

> **Primary source.** Xu, Wang, Fan & Liu 2024 (Shanghai Jiao Tong University / Shanghai AI Lab / GAIR), *Benchmarking Benchmark Leakage in Large Language Models* (`raw/xu-2024-benchmark-leakage-llms.md`, arXiv 2404.18824v1). 31 open-source LLMs, [[wiki/entities/gsm8k.md]] and [[wiki/entities/math-dataset.md]] as the testbed, leaderboard and predictions released. This is the **primary source for a protocol the wiki already carried second-hand**: the `n`-gram-against-LLM-rewrite `δ` that [[wiki/entities/olymmath.md]] uses to measure its own contamination is this pipeline. SFT = Supervised Fine-Tuning; ROUGE-L = longest-common-subsequence overlap; ppl = perplexity (see [[wiki/glossary.md]]).

---

## Why this benchmark pair was chosen, and the criterion is reusable

The authors state three requirements for a leakage testbed, and they are the requirements for *any* contamination study:

1. **It ships both a train and a test split** — without two splits there is nothing to difference.
2. **Improving on it is hard and clean data for it is scarce** — which is what creates the incentive to train on it. Contamination is not primarily an accident; it is a *return on a cheap action*.
3. **It is a standard reported metric** — so the leak has consequences.

Point 2 is the one the wiki had not stated. The benchmarks most worth trusting are exactly the ones most worth contaminating, and the pressure rises as a benchmark becomes load-bearing.

---

## Taxonomy: two axes, four cells

| | **Input leak** (question only) | **Input–output leak** (question + answer) |
|---|---|---|
| **Train split in the corpus** | Format and phrasing adaptation | The disclosed-and-normal case: GPT-4's technical report states GSM8K and MATH training sets were mixed in; Aquila2 documents GSM8K training; InternLM-2 (non-Base) continued pre-training on STEM data including suspected GSM8K train | 
| **Test split in the corpus** | Item familiarity without the key | **The case that voids the benchmark.** Measured here on MATH's test split and on GSM8K's for at least one model |

Two consequences a builder should carry:

- **Training on the *train* split is legitimate and still breaks comparison.** A model that used the train split and one that did not are not comparable on the test split even if neither ever saw a test item, because the two are at different points on the benchmark's own distribution. Opacity, not misconduct, is the defect.
- **Input-only leakage is not benign.** The model has been fitted to the item's phrasing and format, which is precisely the channel [[wiki/entities/gsm8k.md]]'s GSM-Symbolic z-score picks up: the published seed is special only because it was published.

---

## The four detection challenges, and the one that is structural

| # | Challenge | Why it bites |
|---|---|---|
| 1 | **The test split cannot be assumed clean** | Every train-vs-test comparison assumes a clean reference. If both splits leaked, the comparison returns the clean model's answer |
| 2 | **No universal threshold** | The score difference that indicates leakage varies with model size, training strategy and corpus mixture; retraining a control model per audited model is unaffordable. And a model trained on the train split **generalises to the test split**, which moves the reference too |
| 3 | **Unknown utilisation** | The benchmark may have been paraphrased, reformatted, augmented, or used only for hyperparameter selection — each of which defeats a different detector |
| 4 | **Weights inaccessible** | Closed models return no logits, so every perplexity-based method is unavailable on exactly the models whose corpora are least documented |

**Challenge 1 is the structural one and it deserves a name.** For any statistic differencing the two splits, `clean` and `both-splits-leaked` are the same point. The detector's null hypothesis and its worst case are indistinguishable, so a *low* reading is uninformative in the direction that matters. This is not a tuning problem; it is the sign structure of the instrument.

---

## `I19` — the reference-paraphrase differential

The escape from Challenge 1 is a control the model provably never saw. Fresh exam questions are the usual choice and cannot be distribution-matched; the substitute is to **synthesise** one from the benchmark itself.

**Step 1 — reference synthesis.** Paraphrase the surface of every item with an external model (`gpt-3.5-turbo-0125`, temperature 0.7, top-p 0.9), *preserving structure, numbers and reasoning difficulty*. Generate **three** versions per split and average, to damp synthesis noise.

**Step 2 — two atomic metrics on original and reference.**

| Metric | Definition | Computed over | Needs logits? |
|---|---|---|---|
| **Perplexity** | `PPL(X) = exp(−(1/t) Σᵢ log p_θ(xᵢ ∣ x_<ᵢ))` | The **answer part only** (question and answer joined by `" Answer: "`), because training may have masked the question | Yes |
| **`n`-gram accuracy** | `(1/SK) Σᵢ Σⱼ I(X_{sⱼ:sⱼ+n}, X̂_{sⱼ:sⱼ+n})` — sample `K = 5` start points uniformly in `[2, ∣X∣]`, prompt with the prefix, greedily decode the next `n` tokens, exact-match against the gold | The **whole** concatenated question + answer | **No** — works through an API |

The two are the continuous and discrete readings of the same quantity: `p(n-gram ∣ prompt) = Π_k p_M(x_{sⱼ+k} ∣ x_{<sⱼ+k})`, so falling perplexity mechanically raises `n`-gram hit rate. Their **disagreements** are the informative part (below).

**Step 3 — normalise and difference.**

```
Δ = M_ori − M_ref                    (reversed for perplexity: M_ref − M_ori)
δ = Δ / M_ori × 100%                 (normalised so models of different size compare)
δ_train-test = δ_train − δ_test      (the reported statistic)
```

`δ_train-test` cancels the bias the paraphraser itself introduces, which is the step that makes synthesis usable as a control at all. **A large positive value indicates train-split leakage; a negative value indicates test-split leakage; a value near zero is ambiguous between clean and both-leaked.**

**Validation (a real meta-experiment, which most detection papers skip).** Mistral-7B-v0.1 trained on a 1,000-item "seen" set with a 1,000-item "unseen" held out, under two regimes — pre-training (full loss) and SFT (loss on the solution only), 20 epochs on GSM8K / 8 on MATH.

| Observed | Reading |
|---|---|
| Untrained → `δ_seen-unseen ≈ 0` | The null behaves |
| Trained → both `δ_seen` **and** `δ_unseen` rise | Training on a split *generalises* onto its sibling split, so the reference moves; this is Challenge 2 measured |
| `n`-gram `δ` higher under pre-training; ppl `δ` higher under SFT | Because `n`-gram spans the question and ppl does not — **the metric pair identifies the training regime, not just its presence** |
| `δ_seen-unseen` higher under SFT than pre-training | Fine-tuning on a benchmark is *easier* to detect than dissolving it into a pre-training mixture — so the undetectable case is the one a large lab is most able to run |
| Ordering consistent across both metrics and both datasets | The statistic is a ranking instrument, not a calibrated one |

---

## What it found: 31 models on GSM8K

5-gram accuracy, `δ_train-test`, selected rows (full ranking in the source; the ppl ordering agrees on the top group):

| Model | `δ_train` | `δ_test` | `δ_train-test` | Note |
|---|---|---|---|---|
| Qwen-7B | 58.64 | 14.35 | **44.29** | |
| Qwen-14B | 67.64 | 24.21 | **43.43** | |
| InternLM2-20B | 72.94 | 33.21 | **39.73** | Documented STEM continued pre-training |
| InternLM2-7B | 71.64 | 32.28 | **39.36** | |
| Aquila2-7B | 81.68 | **54.62** | 27.06 | Documented GSM8K training |
| Aquila2-34B | 76.07 | **49.09** | 26.98 | Known exposure to the **whole GSM8K test set** |
| Qwen-1.8B | 72.17 | **49.40** | 22.77 | |
| Phi-2 | 21.37 | 0.72 | 20.65 | `Δ` tiny — ratio unreliable |
| **ChatGLM3-6B** | **36.85** | **36.30** | **0.55** | **Both splits high, disparity ~0** |
| Orca-2-7b | 44.96 | 36.45 | 8.51 | Same signature, weaker |
| LLaMA-7B | 13.10 | 9.93 | 3.17 | |
| Llama-3-8B | 0.10 | 0.10 | 0.00 | |
| Mistral-7B-v0.1 | 15.65 | 8.01 | 7.64 | |
| InternLM2-20B-Base | 6.16 | 11.94 | **−5.78** | Negative → test-split familiarity |

**Three readings the ranking alone does not give.**

1. **The ordering statistic hides the worst case, and there is an example.** ChatGLM3-6B sits near the clean end by `δ_train-test` (0.55) with an absolute `δ` of ~36 on **both** splits — nearly three times LLaMA-7B's. The repair is to report the triple `(δ_train, δ_test, δ_train-test)` and never the disparity alone; a high-and-flat pair is the both-leaked signature.
2. **A ratio on a small denominator is not a measurement.** Phi-2's `δ` of 21.37 rests on `Δ = 1.84`. Report `Δ` beside `δ` or the ranking is partly noise.
3. **The two metrics disagree diagnostically.** A high `δ_train-test` with *poor* `n`-gram accuracy indicates the benchmark entered training **reformatted or paraphrased**, because ppl tracks a rewritten item and exact-match `n`-grams do not.

---

## Instance-level detection, and its false negative on a known positive

`n`-gram accuracy is per item, so an item where **all 5 sampled 5-grams** are reproduced is individually suspect. Counts of such items (3,000 sampled per split), tightening to loosening the match rule:

| Model / split | Exact match | Edit-distance sim > 0.9 | ROUGE-L > 0.75 |
|---|---|---|---|
| Qwen-1.8B, GSM8K **train** | **223** | 266 | 384 |
| Qwen-1.8B, MATH **train** | 67 | 83 | 136 |
| Qwen-1.8B, MATH **test** | **25** | 29 | 51 |
| Qwen-14B, MATH **test** | 8 | 17 | 48 |
| Aquila2-34B, MATH **test** | 7 | 12 | 35 |
| Aquila2-34B, GSM8K **test** | **0** | **0** | 0 |

**This table contains the instrument's own falsification.** Aquila2-34B is *known* to have been exposed to the entire GSM8K test set, and scores **zero** suspicious items on it. The cause is visible in the predictions: where the gold continuation is `\n#### 12`, the model emits `The answer is`; ChatGLM-2 emits `Answer: \boxed` where the gold is `\n### 12`. The model learned the **content** under a different **format**, and an exact-match `n`-gram detector keys on format. Loosening to ROUGE-L raises counts by roughly 1.5–2× and does not recover this case, because the divergence is in the answer *delimiter*, not in the wording.

Two exports:
- **An instance-level leakage detector has a format prior it does not declare.** It can only see items ingested in their published serialisation.
- **The loosening threshold is a free parameter fitted after the fact** (exact / 0.9 / 0.75), the same defect `F9` records for violation-of-expectation statistics. Pre-register it or report the whole curve.

---

## The wiki's contamination instruments, consolidated

| Instrument | Needs | Detects | Blind to | Source |
|---|---|---|---|---|
| **Corpus `n`-gram overlap** (GPT-3, LLaMA-2 era) | **The pre-training corpus** | Verbatim inclusion | Everything, once the corpus is closed | Prior work |
| **`I19` reference-paraphrase differential** | Split pair; logits *or* API access | Train-vs-test asymmetry; instance-level verbatim recall | Both-splits leakage; reformatted ingestion | This page |
| **Template re-instantiation z-score** (`I14`) | A parseable item | The published seed sitting in its own distribution's right tail — 21 of 25 models | Any leakage that is not seed-specific; needs re-instantiable items | [[wiki/entities/gsm8k.md]] |
| **Method-preserving perturbation** (`I16`) | Two expert rewrites | Drop concentrated in **train-split** seeds | Needs paid expert authoring | [[wiki/entities/math-perturb.md]] |
| **Cross-benchmark `δ` comparison** | A rival benchmark and one rewriting model | Relative familiarity (PolyMath 38.81% vs OlymMATH 17.59%, Qwen2.5-7B EN) | Absolute level — `δ` depends on the rewriter | [[wiki/entities/olymmath.md]] |
| **Inert per-item marker** (ObjectNet's one-pixel red border, stripped on the fly at test time) | A dataset whose items can carry a semantically inert, exactly-searchable mark | Presence of a published test item in **any** corpus, by reverse image search, run by anyone — not a statistic over model behaviour, so `F14`'s degeneracy does not apply | Ingestion that re-renders, crops or re-encodes the item; and it detects rather than prevents | [[wiki/entities/objectnet.md]] |
| **Never publish the items** | A closed submission channel | Nothing — it *prevents* rather than detects, and makes third-party audit impossible (T222) | — | [[wiki/entities/frontiermath.md]] |
| **Annual re-authoring** (`F13`) | A standing authoring budget | Nothing — prevents, at the cost of a fixed scale | — | [[wiki/entities/aime.md]] |

**OlymMATH's `δ` is this pipeline with the disparity step unavailable.** It has no train/test split, so it cannot compute `δ_train-test` and its `δ` carries the paraphraser's bias uncorrected — which is exactly why its own limitation note says only *relative* comparisons between benchmarks are meaningful. The two papers agree on magnitude where they overlap: Qwen-7B here reads `δ_test = 14.35` on GSM8K, Qwen2.5-7B there reads `δ = 17.59` on OlymMATH-EN.

---

## The remedy the paper actually pushes: documentation, not detection

Detection is a losing game against an opaque corpus; the authors' primary proposal is a disclosure artefact. The **Benchmark Transparency Card**, a supplement to the Model Card and Data Card, in three sections:

| Section | Fields that matter |
|---|---|
| **Basic model details** | Name/version, creator, release date, **timespan of the training data** |
| **Benchmark utilisation statement** (one per benchmark) | Was train / validation / **test** used, and how many samples in what organisation; what **augmentation or reformatting** was applied; was the benchmark used for **hyperparameter tuning**, and on which split |
| **Benchmark evaluation details** | Benchmark versions and modifications; per-benchmark scores; **any benchmark-specific optimisation, stopping condition, or special step taken to reach the reported number**; non-standard metric definitions; artefact availability |

The augmentation field and the hyperparameter field are the two that no existing card carries, and they are the two that defeat every detector on this page.

The paper's remaining recommendations, each of which is a channel the wiki should treat as open:

- **Build benchmarks from the newest corpus available**, and refresh them — the process view [[wiki/entities/olymmath.md]] and [[wiki/entities/aime.md]] reach independently.
- **Do not upload paired question–answer files.** Encrypt the test set, or keep it behind a leaderboard.
- **Submitting benchmark items to a proprietary API is itself a leakage event** — the provider may train on the submission. *This makes evaluating a closed model a way of destroying the benchmark*, which is `F1`'s depletion mechanism operating through the evaluation act rather than through published scores, and nobody in the wiki's benchmark inventory accounts for it.

---

## Open problems

| # | Problem |
|---|---|
| K1 | **No instrument detects simultaneous train+test leakage.** The absolute `(δ_train, δ_test)` pair is the only signal and it has no threshold — Challenge 2 says the scale depends on model size and corpus mixture, and no reference model is affordable |
| K2 | **Every detector here has an undeclared format prior.** A benchmark ingested reformatted is invisible; the only proposed fix is knowing the training data's serialisation in advance, which is the thing being audited |
| K3 | **Contamination and difficulty calibration are the same variable.** A benchmark whose public split is i.i.d. with its private split leaks distributionally by construction (`F2`); a benchmark that breaks the i.i.d. relation loses cross-split comparability |
| K4 | *(brainstorm)* **The measurement is of the corpus, and the thing we want to know is about the score.** `δ_train-test = 44` does not say how many points of a reported accuracy it bought. [[wiki/entities/hle-verified.md]] shows the shape the answer would take — recompute the score on the clean subset and difference — and the analogous experiment here (score each model on its own low-`δ` item subset) is cheap and unrun |

---

## Connections

- **[[wiki/concepts/certification-instruments.md]]** — supplies `I19` to that inventory and takes back `F1` and `F2` as its boundary conditions; the division of labour is that page certifies a *system*, this page audits a *corpus*, and `I19`'s null-equals-worst-case degeneracy is a failure mode the instruments there inherit whenever they assume a withheld set.
- **[[wiki/entities/gsm8k.md]]** — one of the two testbeds, and the page whose "contamination is inferred, not shown" limitation this source closes directly: 223 GSM8K training items reproduced verbatim by Qwen-1.8B, and a `δ_train-test` ranking that agrees with the two labs that documented their GSM8K use.
- **[[wiki/entities/math-dataset.md]]** — the other testbed, and the page whose "no contamination audit" limitation is now audited by a third party: MATH's **test** split shows verbatim recall in several models (25 items for Qwen-1.8B under exact match), which is the split-voiding case rather than the disclosed-training case.
- **[[wiki/entities/olymmath.md]]** — the wiki's second-hand carrier of this pipeline, now given its primary source; its `δ` is `I19` with the train−test cancellation unavailable, which is why its own note restricts it to cross-benchmark comparison.
- **[[wiki/entities/math-perturb.md]]** — the complementary contamination read-out: `I16`'s method-preserving arm concentrates its drop in train-split seeds, which is the same train-vs-test asymmetry read from the *accuracy* side rather than from the likelihood side, and it survives reformatting because it never matches tokens.
- **[[wiki/entities/frontiermath.md]]** — the maximal prevention and the audit it forecloses; this page's API-submission channel is the residual leak even there, since items reach closed models through a provider's endpoint.
- **[[wiki/entities/aime.md]]** — prevention by renewal rather than by secrecy, and the only defence here that costs nothing per audit; it pays in `F13`'s missing fixed scale.
- **[[wiki/entities/hle-verified.md]]** — the same move applied to *label* defects rather than *leakage* defects: measure the flaw, then recompute what it did to published scores. K4 is that method asked for here.
- **[[wiki/concepts/shortcut-learning.md]]** — contamination is the limiting shortcut: the cheapest rule consistent with the observations is *retrieve the answer*, and it is invisible to every i.i.d. metric, which is why that page's cheap-o.o.d. instruments double as contamination tests.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the framing's cost of being wrong here: a memorised answer and a recovered mechanism are behaviourally identical on the item that was memorised, so a contaminated benchmark cannot distinguish the two hypotheses the framing exists to separate.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the reason `n`-gram accuracy and perplexity carry the same signal (`p(n-gram) = Π p_M(xᵢ ∣ x_<ᵢ)`), and the reason low loss on a benchmark item is uninterpretable without knowing whether the item was in the corpus.
- **[[wiki/entities/hle.md]]** — the benchmark whose `I17` admission gate has this page's channel by construction: every candidate item is submitted to a frozen frontier-model ensemble through an API before publication.
- **[[wiki/empirical-tensions.md]]** — T227 (whether a near-zero train−test disparity licenses a clean verdict), T222 (whether a permanently private evaluation set solves contamination).
- **[[wiki/concepts/learnable-synaptic-delays.md]]** — this page's defect found independently in the neuromorphic literature: leading Spiking Heidelberg Digits results select and early-stop on the **test set**, a practice defended in print as fair-by-convention, and at `n = 2264` test items the Bayesian confidence intervals for 93%, 94% and 95% overlap — so the top of that leaderboard is not ordered by its own evidence (Mészáros et al. 2025).
- **[[wiki/entities/objectnet.md]]** — the cheapest detector in this page's table and the only non-statistical one: a one-pixel red border on every published test image makes its appearance in any training corpus findable by reverse image search, which sidesteps `F14` entirely because it reads the *corpus* rather than the model — and `(brainstorm)` the untried text analogue is a per-item nonce token.
