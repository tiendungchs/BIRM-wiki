# HLE-Verified — the post-release audit that ran T225's decisive experiment, and the circularity it did not control

**A two-stage expert-plus-model audit of all 2,500 [[wiki/entities/hle.md]] items that decomposes each item into three independently-validated components (problem / answer / rationale) and returns a three-valued status per item: 668 gold (26.7%, unmodified), 1,143 revised (45.7%, repaired under an evaluation-intent-preservation constraint), 689 uncertain (27.6%, indeterminate and released *as* indeterminate with a required-expertise tag). Three things here are new to the wiki. (i) It supplies the wiki's first **post-release repair** instrument — every other instrument in [[wiki/concepts/certification-instruments.md]] admits or scores items, none fixes them — together with a 19-category component-wise defect taxonomy. (ii) It runs the measurement T225 names as decisive and nobody had run: re-score the leaderboard with the flawed items corrected. The answer is split — **the full-set ordering survives exactly** (7 of 7 models keep rank) while the *offset is not constant* (+7.78 to +11.50) and on the flawed items alone the ordering reshuffles and the between-model spread collapses from **2.5× to 1.22×**. (iii) Its own repair loop is **model-in-the-loop and its reported metric is model accuracy**, so the +30–40 point gain on the repaired subset is not separable from a repair pipeline that could have moved answer keys toward the frontier consensus — and the paper reports no control that would separate them.**

> **Provenance.** Zhai, Wang, Wang, Yang, Li, Xu *et al.* 2026 (Alibaba Group + Qwen Team), *HLE-Verified: A Systematic Verification and Structured Revision of Humanity's Last Exam* (`raw/zhai-2026-hle-verified.md`, arXiv 2602.13964v3). Data at `huggingface.co/datasets/skylenage/HLE-Verified`. The authors position it as "dataset infrastructure: not a new benchmark task". HLE = Humanity's Last Exam; RMS = root mean square; GEMV/GEMM = general matrix-vector / matrix-matrix multiply.

---

## The artefact

| Subset | Items | Share | Definition |
|---|---|---|---|
| **Gold** | 668 | 26.7% | Both problem *and* answer judged unproblematic, no high-risk ambiguity; retained unmodified |
| **Revised** | 1,143 | 45.7% | Flawed but repairable; corrected and re-verified with the original evaluation objective preserved |
| **Uncertain** | 689 | 27.6% | Validity not establishable; kept with an **uncertainty-source label** and a **required-expertise tag** |

The three-valued status is the design move. Every other benchmark in the wiki forces a binary label and absorbs indeterminacy into the noise floor; this one **separates a capability limit from a benchmark indeterminacy** at the dataset level and publishes the second as a work item.

---

## The protocol

**Stage I — component-wise binary verification.** Each item is split into problem (statement + image), final answer, and rationale. Problem and answer are the correctness targets; the rationale is a *diagnostic* signal used to detect contradictions and missing assumptions, not a grading target. Three evidence sources in a serial-hybrid workflow:

| Source | What it contributes |
|---|---|
| External domain-expert screening | Component-wise binary judgements + notes |
| **Model-assisted replication, pass@8** | Multiple frontier multimodal solvers, answers normalised and compared under a fixed equivalence protocol; flags **extreme human–model disagreement** |
| Internal expert adjudication | Conservative inclusion — gold requires both problem and answer clean |

**Stage II — repair.** Two *independent* expert teams propose fixes in a fixed order — **Problem Fix → Solution Fix → Answer Fix** — with change notes; multi-model sampling supplies auxiliary repair candidates; internal experts adjudicate to one canonical version under **objective preservation, correctness, minimal necessary edits**. Anything needing substantive alteration of what the item tests is marked non-repairable and routed to uncertain. Scope is restricted by verifiability: mathematics, physics, chemistry, biomedicine, computer science only — domains with "weak verification boundaries or subjective conventions" go to uncertain by default.

**The prompt-level guard is worth copying.** Both the repair prompt ("If uncertain, set `empty_answer` to true. **Do not guess**") and the adjudication prompt ("**Prefer EMPTY over fabrication**") make abstention the default output of an LLM asked to judge ground truth. This is the cheapest instance in the wiki of an acceptance test built to fail closed ([[wiki/concepts/external-verification.md]]).

---

## The defect taxonomy — 19 categories, and item validity is not binary

| Component | Categories | Full list |
|---|---|---|
| **Problem** | 5 | Q1 Semantic Error (ambiguous/contradictory/underspecified) · Q2 Knowledge Error (false factual premise) · Q3 Missing Information · Q4 Theoretical Invalidity · Q5 Format Semantic Error |
| **Rationale** | 10 | S1 Non-Redundancy Violation · S2 Circular Reasoning · S3 Empirical Soundness Violation · S4 Step Inconsistency · S5 Domain Misapplication · S6 Overconfidence Bias · S7 Missing Prerequisite · S8 Deceptive Similarity (superficially plausible, subtly corrupted) · S9 Multi-Solution Inconsistency · S10 Format Semantic Error |
| **Answer** | 4 | A1 Incorrect Answer · A2 Incomplete Answer · A3 Ambiguous / Ill-defined · A4 Format Semantic Error |

**The taxonomy's rationale half is a catalogue of the failure modes the wiki attributes to *models*, applied to the benchmark's own authoritative text.** S2 circular reasoning, S6 overconfidence, S7 missing prerequisite and S8 deceptive similarity are the same categories [[wiki/concepts/external-verification.md]] uses to type mathematical hallucination (≈40% unjustified leaps, ≈25% circular/invalid structure). They are here being applied to expert-written reference solutions.

---

## Where the defects are

Component validity, measured on the **problematic subset** (the 1,832 items that failed Stage I), not on all 2,500:

| Component | Finding |
|---|---|
| **Problem** | Most reliable — the majority of statements are structurally valid; explicit structural errors are a small fraction |
| **Answer** | About **half** valid; the rest incorrect or unverifiable |
| **Rationale** | **Invalid outnumbers valid** — logical gaps, unsupported inferences, incorrect derivations, *even where the problem statement is acceptable* |

**Cross-domain, the defect *type* changes, not just the rate:**

| Domain | Problem valid | Answer valid | Rationale |
|---|---|---|---|
| Mathematics | >92% | 59.6% (36.8% invalid) | **65.9% invalid** |
| Biology/Medicine | >92% | 58.6% (38.2% invalid) | **66.4% invalid** |
| Chemistry | 73.3% | 67.3% | **70.3% invalid** |
| Computer Science/AI | — | 65.1% | format-dominated |
| Physics | **30.0%** | <30% | 67.0% *uncertain*, 10.9% invalid |
| Engineering / Humanities / Other | 22–27% | <30% | **73–77% *uncertain***, ~0 explicit invalid |

The split is the finding: **formal domains produce decidable errors, soft domains produce indeterminacy.** In mathematics and chemistry the audit can say "this is wrong"; in engineering and the humanities it can only say "I cannot tell", and 67–77% of those items land in *uncertain*. A single aggregate error rate averages over two categorically different things.

Dominant defect per component (within-component share, revised subset):

| Subject | Problem | Rationale | Answer |
|---|---|---|---|
| Mathematics | Format Semantic (40.0%) | Information Missing (40.1%) | **Incorrect Answer (89.4%)** |
| Physics | Semantic Error (57.1%) | Information Missing (25.0%) | **Incorrect Answer (80.0%)** |
| Chemistry | Format Semantic (56.5%) | Format Semantic (40.0%) | **Incorrect Answer (71.4%)** |
| Biology/Medicine | Knowledge Error (33.3%) | Information Missing (45.0%) | **Incorrect Answer (97.2%)** |
| Computer Science | Format Semantic (**94.6%**) | Format Semantic (63.3%) | **Incorrect Answer (78.1%)** |

Four regularities the authors draw, and all four are actionable for anyone building a benchmark:

1. **Answer-key instability is deterministic, not ambiguous** — A1 dominates every subject at 71–97%. These are sign/value/boolean inversions, not judgement calls.
2. **Rationale instability is structural or representational** — missing intermediate steps (S3) and format-semantic misalignment (S10) outweigh classical logical contradiction.
3. **Representation sensitivity is discipline-dependent** — format-semantic errors are 94.6% of CS problem defects and 56.5% of chemistry's, i.e. the LaTeX/notation layer is a first-order source of benchmark noise in symbol-heavy fields.
4. **Conceptual invalidity is *not* the driver** — Q4 (theoretical invalidity) is nowhere dominant. The items are mostly good ideas badly specified.

**Case 1 is worth carrying as a general failure mode.** A speculative-decoding item asked for the acceptance rate when draft and target are the *same* model. The reference solution answered "less than 1" because GPU kernels (GEMV vs GEMM) produce slightly different logits — conflating an implementation artefact with a property of the algorithm, where `r = min(1, P_target(t)/P_draft(t)) = 1` exactly. **Theoretical–implementation confusion** is a defect class that only appears when the item author is also a practitioner, which is exactly the population HLE recruited.

---

## The measurement: what verification does to a leaderboard

8 frontier models, HLE's official system prompt, each model's default decoding, **avg@5** over five independent rollouts, text-only subset. Calibration error is the official HLE smoothed `L2` estimator (`p=2, β=100`) over the model's self-reported confidence.

| Model | Full: raw Acc | Full: verified Acc | Δ | Full: raw Cali | Full: verified Cali | Subset: raw Acc | Subset: verified Acc | Subset: Δ | Subset Cali |
|---|---|---|---|---|---|---|---|---|---|
| Gemini3-pro | 40.42 | 48.2 | +7.78 | 56 | 49 | 18.99 | 48.93 | +29.94 | 74 → 45 |
| GPT-5.2-High | 33.35 | 43.3 | +9.95 | 45 | 36 | 14.44 | **52.48** | **+38.04** | 63 → 28 |
| Claude-Opus4.5 | 30.00 | 38.8 | +8.80 | 55 | 46 | 14.20 | 48.16 | +33.96 | 70 → 39 |
| Grok 4.1-fast-reasoning | 19.94 | 29.0 | +9.06 | 73 | 63 | 8.25 | 43.07 | +34.82 | 83 → 47 |
| Claude-Opus4.6 | 38.95 | 46.8 | +7.85 | 40 | 32 | **20.03** | 50.16 | +30.13 | 59 → 27 |
| DeepSeek-V3.2 | 24.90 | 36.4 | **+11.50** | 56 | 46 | **7.87** | 47.45 | **+39.58** | 70 → 28 |
| Qwen3-Max-Thinking | 30.00 | 38.2 | +8.20 | 66 | 57 | 14.2 | 48.48 | +34.28 | 79 → 44 |

### 1. T225's decisive experiment, answered in three parts

**(a) The full-set ordering survives, exactly.** All seven models hold rank. This is evidence for T225's position A and it is the first such evidence in the wiki — no other self-auditing benchmark ([[wiki/entities/gpqa.md]], [[wiki/entities/frontiermath.md]]) re-scored anything after measuring its own floor.

**(b) The offset is not constant, and it compresses the mid-field.** The gains span 3.7 points (+7.78 to +11.50), so mislabelled items were *not* equally hard for every model. Adjacent gaps move accordingly: Claude-Opus4.5 over DeepSeek-V3.2 goes 5.10 → **2.40**, i.e. the raw benchmark reported a gap twice its corrected size. Position A's "constant offset that cancels in a difference" is false as stated, and the residual is the same order as the differences routinely claimed.

**(c) On the flawed items alone, the leaderboard is manufactured.** *(This is the wiki's reading; the paper reports the numbers but does not draw it.)* Raw, the revised subset spreads models over 7.87–20.03 — a **2.5× ratio**, and the widest apparent capability gap anywhere in the table. Repaired, the same items and the same models give 43.07–52.48, a **1.22× ratio**, and the top rank changes hands (Claude-Opus4.6 → GPT-5.2). A quarter of the benchmark was producing a large, confidently-reported, and almost entirely spurious ordering.

**A derived number the paper does not state, and it is unusually stable.** The ratio Δ(full) / Δ(subset) estimates what fraction of the evaluated set is scoring-relevant-defective, and it lands at **0.24–0.29 for all seven models independently** (7.78/29.94 = 0.26; 9.95/38.04 = 0.26; 8.80/33.96 = 0.26; 11.50/39.58 = 0.29; 8.20/34.28 = 0.24). So **~26% of HLE items carry a problem- or answer-level defect large enough to change the grade** — against the benchmark's own self-audited **15.4%** expert disagreement. See T226.

### 2. About nine points of measured miscalibration belonged to the benchmark

Calibration error falls on **every model on both sets**: −7 to −10 points on the full set, and −29 to −42 on the revised subset (GPT-5.2 63 → 28; DeepSeek 70 → 28; Claude-Opus4.6 59 → 27). This qualifies the wiki's headline calibration claim directly. [[wiki/entities/hle.md]] reports RMS calibration error of 73–89% as "the cleanest measurement that a system does not know what it does not know" — a fraction of that number is the *benchmark* not knowing what it does not know. **A model penalised for confidently giving a defensible answer that disagrees with a wrong key is being scored as overconfident when it was right.** The correction is large enough to matter and small enough that the original conclusion survives: 73–89% minus ~9 is still catastrophic.

### 3. Confidence is a detector of ill-posedness, separable from confidence in an answer

The cleanest mechanism result here. Take only items whose **problem statement** was flagged as erroneous, and compare each model's self-reported confidence on the raw versus the repaired version of the *same* item:

```
ΔConf = E[c_Verified − c_Raw]
  Problem-Error Subset:  +1.83 … +11.08   (positive for every model)
  Full Set:              ≈ 0, occasionally slightly negative (diluted by unchanged items)
```

Models were **already less confident on the broken items**, before anyone told them the items were broken, and confidence recovered when the statement was repaired. That is a signal about the *well-posedness of the input*, not about the model's chance of being right — and it is the first evidence in the wiki that the two are separable. Practically it yields a screen: aggregate low confidence across independent models flags candidate ill-posed items at API cost, which is the same trick I17's searchability screen plays for a different property.

*(brainstorm)* This is the one place the [[wiki/concepts/precision-weighting.md]] framing pays a concrete dividend on a language model. An underspecified problem is a *high-variance likelihood* — many hidden states are consistent with the observation — and a system representing precision as a first-class quantity should report low precision without needing to be told which of the two sources (its own ignorance, or the question's) is responsible. The measurement above says the confidence field is at least partly carrying that. The unrun follow-up: regress ΔConf per item against the **defect category** (Q1 semantic ambiguity vs Q3 missing information vs Q5 format), because those are three different variance sources and a system with one undifferentiated confidence scalar should not distinguish them, while a system with a represented precision over latents should.

---

## The circularity, and the control that is missing

**The pipeline uses frontier models to decide what is broken and what the repair is, and then reports frontier-model accuracy as the measure of success.** Concretely: Stage I flags items by pass@8 model–reference disagreement; Stage II takes "model-assisted auxiliary repair proposals" and runs a multi-model adjudication prompt; and the headline result is that models score 30–40 points higher afterwards. Every item where the frontier consensus is *confidently and uniformly wrong* while the original key was right is a candidate for being "repaired" into agreement with the models — and that class is not empty, since it is precisely the class HLE's admission gate selected for.

The authors' guards are real but unmeasured: expert adjudication is stated to be authoritative over model output ("Model outputs serve as auxiliary evidence and do not replace expert adjudication"), two independent expert teams repair each item, and the prompts prefer EMPTY over fabrication.

*(brainstorm)* **The tight post-repair clustering is the signature to worry about.** After repair, seven models spanning a 2.5× accuracy ratio on the raw subset land inside 43.07–52.48. If repairs were independent of model behaviour, correcting a key should raise each model roughly in proportion to how often *it* had the defensible answer — a heterogeneous lift. Convergence onto a nine-point band is what you would see if a material share of new keys equals the modal model answer. Two cheap controls, neither run:

1. **Report the fraction of revised items whose new answer equals the plurality pass@8 model answer**, against the base rate on gold items where the models were also wrong. The pass@8 outputs are already collected.
2. **Repair a random sample blind** — a third expert team given the item and no model outputs — and report key agreement with the model-assisted repair. Disagreement is a direct estimate of the contamination.

Until one of these exists, "+30–40 points on flawed items" and "the frontier was right and the key was wrong" are not distinguishable, and the second is what the paper claims.

---

## Limitations

| | |
|---|---|
| **Scope** | Stage II covers only math / physics / chemistry / biomedicine / CS. The domains with the *worst* measured validity (Engineering, Humanities/Social Science, Other: 22–27% valid problems) are excluded from repair by construction and become most of the uncertain set. The audit is least able to fix what is most broken |
| **Modality** | All evaluation is on the **text-only** subset; HLE's ~14% multimodal items are unmeasured here |
| **The uncertain set is dropped, not scored** | 689 items are removed from evaluation rather than kept with abstention credit. Keeping them and scoring "I cannot determine this" would turn the set into a calibration probe for free — the same signal [[wiki/entities/gpqa.md]] discarded when it backed off to the closed-book answer |
| **No human re-baseline** | Accuracy is re-measured for models only. Whether the repaired items are still at the intended difficulty *for a human* is asserted by the objective-preservation constraint, not measured ([[wiki/concepts/human-baseline.md]]) |
| **The judge is unchanged** | Grading still runs through HLE's LLM judge, so T218's unmeasured false-negative rate is inherited whole |
| **Repair is one-shot and dated** | The set is now a *third* artefact (raw HLE, HLE-Verified, HLE-Rolling) with no anchor subset shared across them — [[wiki/entities/olymmath.md]]'s comparability problem, now with three editions instead of two |

---

## Comparison — what an audit protocol reports about the same dataset

| | HLE self-audit | HLE-Verified | [[wiki/entities/gpqa.md]] | [[wiki/entities/frontiermath.md]] |
|---|---|---|---|---|
| Unit of judgement | The **item**, binary | The **component** (problem / answer / rationale), three-valued | The item, "objective" vs not | The item, "critical error" |
| Sample | 2×200 sampled items | **All 2,500** | 448 | Internal |
| Reported floor | 15.4% (18% / 25% by subset and rule) | ~26% scoring-relevant *(derived)*; 45.7% repaired; 27.6% indeterminate | 23.6–26.4% non-objective | ~10% critical |
| Repairs? | No — flagged and routed to consensus | **Yes**, 1,143 items | No | No |
| Indeterminacy | Folded into the disagreement rate | **A published subset with expertise tags** | Folded in | Not separated |
| Effect on scores measured? | No | **Yes** — the only one | No | No |

The row that matters: **the same dataset yields 15.4% or ~26% depending on who audits it and how**, which is `F12` demonstrated a second time by a second party rather than argued.

---

## Connections

- **[[wiki/entities/hle.md]]** — the audited object: this page supplies the external check on HLE's own 15.4% self-audit (a derived ~26% scoring-relevant defect rate), the correction to its headline calibration column (~9 of the 73–89 RMS points are benchmark noise, not model overconfidence), and the first direct evidence that its leaderboard ordering survives its own noise floor while its *gaps* do not.
- **[[wiki/concepts/certification-instruments.md]]** — supplies **I18**, the only instrument in the inventory that repairs items rather than admitting or scoring them, and the second independent demonstration of **F12** (the measured error rate is a property of the audit protocol: component-wise-and-three-valued returns ~26% where item-wise-and-binary returned 15.4% on the same 2,500 items).
- **[[wiki/empirical-tensions.md]]** — runs T225's stated decisive experiment and splits it (ordering preserved, offset non-constant, sub-leaderboard spurious), and opens **T226** on whether a model-in-the-loop repair pipeline can measure its own effect on model scores.
- **[[wiki/concepts/precision-weighting.md]]** — the mechanism finding: self-reported confidence tracks the **well-posedness of the input** (+1.83 to +11.08 confidence points recovered when a broken statement is repaired, ≈0 on unchanged items), which separates uncertainty-about-the-question from uncertainty-about-the-answer for the first time in the wiki.
- **[[wiki/concepts/external-verification.md]]** — two contributions in opposite directions: the repair prompts are an acceptance test built to **fail closed** ("Prefer EMPTY over fabrication"), and the rationale audit shows the *reference* chains benchmarks ship — the raw material for process supervision and distillation — are majority-invalid on the problematic subset, with the same defect types (circularity, missing prerequisite, deceptive similarity) that ladder attributes to model traces.
- **[[wiki/entities/gpqa.md]]** — the other benchmark that measured its own reliability (23.6–26.4% non-objectivity) and, unlike this one, never re-scored anything against it; also the discarded-abstention precedent that the 689-item uncertain set could still redeem.
- **[[wiki/entities/frontiermath.md]]** — the inversion: a ~10% self-reported critical error rate that no outside party can audit because the items are unpublished (T222), against 2,500 published items audited by a second organisation with the full defect record released.
- **[[wiki/entities/anli.md]]** — the cost contrast at the other end of the pipeline: ANLI pays per item *at authoring* and gets validity as a by-product, HLE pays nothing at authoring and pays here instead, twice (two independent expert repair teams plus adjudication) and for a subset it can only partly fix.
- **[[wiki/entities/olymmath.md]]** — the comparability problem inherited and worsened: raw HLE, HLE-Verified and HLE-Rolling are three editions of one benchmark with no shared anchor subset, so no score trend across them means anything.
- **[[wiki/concepts/human-baseline.md]]** — the missing half of the repair guarantee: "the original evaluation objective is preserved" is a claim about difficulty for a solver, and no human solved the repaired items to check it.
- **[[wiki/concepts/rule-level-evaluation.md]]** — the S-series defect taxonomy is rule-level evaluation pointed at the benchmark's own authoritative solution instead of at the solver's, and it finds the reference rule invalid more often than valid.
- **[[wiki/concepts/benchmark-contamination.md]]** — the same two-step method aimed at a different defect: measure the flaw, then recompute what it did to scores already published. `I18` does this for label errors; nobody has done it for leakage, which is that page's `K4`.
