# AIME — American Invitational Mathematics Examination

> **Provenance.** Wikipedia, *American Invitational Mathematics Examination* (`raw/wikipedia-nd-aime-competition.md`, retrieved 2026-06-23). A tertiary source: the format, scoring and score tables are administrative facts reproduced from the contest organiser, and are marked `(tentative)` where the wiki depends on them for a quantitative claim. **AIME is not an AI benchmark and was never designed as one** — it is a 1983 human *selection* instrument that the field adopted wholesale. This page exists because the wiki quotes AIME numbers on eight pages and had never read the instrument. AMC = American Mathematics Competitions; USAMO/USAJMO = USA (Junior) Mathematical Olympiad; USAMTS = USA Mathematical Talent Search; OMR = optical mark recognition.

---

## Format

| Property | Value |
|---|---|
| Items | **15** per contest, ordered by increasing difficulty |
| Time | 3 hours, no calculator (pencil, eraser, ruler, compass only) |
| Answer type | **integer 000–999**, entered on an OMR sheet with leading zeros |
| Scoring | 1 point per correct answer, no penalty, **no partial credit** → integer score 0–15 |
| Topics | elementary algebra, geometry, trigonometry, number theory, probability, combinatorics |
| Administrations | AIME I and AIME II per year since 2000; **a student may take only one** |
| Purpose | selection: `USAMO index = AMC score + 10 × AIME` (**20 ×** from the 2025–26 cycle), eight published cutoffs per year |
| Pool | top 5% of AMC 12 (top 2.5% of AMC 10 from 2010); **widened to ~top 13–15% / 6–8% in 2022**; or ≥68/75 on USAMTS |

**The answer format is the wiki's earliest anti-shortcut bound, and it is a format rule rather than an audit.** A 000–999 integer gives `P(correct | no work) = 0.1%` per item — tighter than the `<1%` *guessproofness* criterion [[wiki/entities/frontiermath.md]] states as a design requirement and audits per item (finding 2 of 35 violations) — while preserving mechanical grading. Every auto-graded mathematics benchmark in the wiki inherits this trade: [[wiki/entities/math-dataset.md]]'s `\boxed{}` normalised exact match, [[wiki/entities/gsm8k.md]]'s final numeric answer, [[wiki/entities/olymmath.md]]'s sympy check, [[wiki/entities/frontiermath.md]]'s integer/SymPy/witness ladder. The cost is also inherited: **the derivation is never scored**, which is the answer/proof dissociation [[wiki/concepts/external-verification.md]] records as unclosed (>90% on AIME-style final answers against ~10/42 on USAMO-style proofs). AIME's own designers did not treat the score as a measurement of proof ability — that is what the USAMO it selects *for* is.

---

## The human denominator

Mean and median score, by administration `(tentative — organiser-reported, no methodology published)`:

| Year | I (mean / median) | II (mean / median) |
|---|---|---|
| 2026 | 6.26 / 6 | 6.55 / 6 |
| 2025 | 6.16 / 6 | 6.24 / 6 |
| 2024 | 5.89 / 5 | 5.45 / 5 |
| 2023 | 4.28 / 4 | 4.40 / 4 |
| 2022 | 4.82 / 4 | 4.40 / 4 |
| 2021 | 5.44 / 5 | 5.42 / 5 |
| 2020 | 5.70 / 6 | 6.13 / 6 |
| 2019 | 5.88 / 6 | 6.47 / 6 |
| 2018 | 5.09 / 5 | 5.48 / 5 |
| 2017 | 5.69 / 5 | 5.64 / 5 |
| 2016 | 5.83 / 6 | 4.43 / 4 |
| 2015 | 5.29 / 5 | 6.63 / 6 |
| 2014 | 4.88 / 5 | 5.49 / 5 |

**This is the only human baseline in the wiki that is re-collected every year, on a fresh item set, at population scale.** Against [[wiki/concepts/human-baseline.md]]'s B1–B5 specification it reads: B1 pool = self-selected students already filtered to the top few percent of a national contest (thousands per administration; <2,000 qualifiers through the 1990s, larger since); B2 = one attempt; B3 = arithmetic mean over all takers; B4 = no exclusions; B5 = the identical 15 items the score is reported on. It is a **naturally occurring** baseline — nobody paid for it and nobody designed it — and it is stronger on B2/B5 than any commissioned baseline in the wiki, weaker on B1 (an unspecified, self-selecting, drifting pool).

**The number the wiki needed and did not have.** The AIME-qualifier mean is **≈5.7/15 = 38%** for 2024 and **≈6.2/15 = 41%** for 2025. The frontier machine numbers the wiki carries against "AIME 2024" are 74% greedy for o1 and 93% verifier-selected ([[wiki/concepts/external-verification.md]]), against 12% for GPT-4o. So the crossing of this particular human population happened between GPT-4o and o1 — one model generation — and the *median* qualifier (5 or 6 of 15) has been below the frontier since 2024. Two cautions before that reading is used: the human pool is not the general population but a competition-selected tail, and the machine figure is almost always AIME I + II pooled (30 items) against a human who sat **one** contest (15).

---

## What this source corrects and adds

**1. The item count is 15, not 30.** [[wiki/concepts/certification-instruments.md]] `F11` was stated as "AIME ships 30 problems ⇒ 3.33 points per item". That is the *machine* evaluation convention (both contests pooled); the instrument as administered is 15 items, **6.67 points per item**, with a binomial standard error at `p ≈ 0.5` of `√(0.25/15) = 12.9` percentage points — ≈**3.7×** that of a 200-item benchmark, not 2.6×. Reported one-contest AIME scores separated by fewer than ~2 items are noise.

**2. The instrument is re-authored every administration and its difficulty is not held constant.** The human mean spans **4.28 to 6.63** across 25 administrations — a 2.35-point (15.7 percentage-point) range on the same nominal benchmark — and the two contests *within one year* differ by up to 1.4 points (2016: 5.83 vs 4.43; 2015: 5.29 vs 6.63). Yet "AIME 2024" and "AIME 2025" model scores are compared as though one instrument. This is a failure mode the wiki's inventory did not have and is now `F13` there.

**3. Renewal buys contamination-immunity and spends comparability.** AIME is the wiki's clearest instance of the only structural answer `F1` has (developer-blindness as a depleting stock): a 2026 item set cannot be in a 2025 training corpus, so blindness is restored *annually and for free* rather than defended by a private held-out split. The price is exactly `F13` — a benchmark that renews itself has no fixed scale, so a cross-year improvement and a drift in item difficulty are not separable. **The two properties are the same property viewed from either end**, and no benchmark in the wiki has both. `(brainstorm)` The repair is available and cheap: an annually renewed benchmark that reuses a small anchor set of retired items, or reports the concurrent human mean with every machine score, converts the drift from a confound into a measured covariate — the human sample is the scale.

**4. Placement discipline satisfied by accident.** `F7` says a benchmark that floors every solver destroys its ordering. AIME sits its target population at ~40% and its median at 5–6 of 15 *because it is a selection device* that must rank the top few hundred of its takers — the design pressure is discrimination in the upper tail, not difficulty. That is the placement [[wiki/entities/olymmath.md]] argues for on purpose and [[wiki/entities/frontiermath.md]] deliberately abandons, arrived at forty years earlier from a completely different requirement.

**5. The pool widened and the mean rose.** Qualification moved from top 5% of AMC 12 to ~top 13–15% in 2022; means went 4.82/4.40 (2022) → 6.26/6.55 (2026). A diluted pool scoring *higher* means item difficulty fell over that window by more than the dilution `(brainstorm — the source gives no per-item difficulty data, and the inference assumes the AMC's own scale is stable)`. Either way it is a second, independent reason the score is not a fixed scale.

---

## What AIME does not measure

| Missing | Consequence |
|---|---|
| The derivation | A correct integer from an invalid argument scores full marks — the same defect [[wiki/entities/math-dataset.md]] documents in its own Figure 3 |
| Partial credit | The score is a sum of 15 Bernoulli outcomes, so it carries no information about *how close* a failure was — the near-miss typology [[wiki/entities/conceptarc.md]] collects has no analogue here |
| Per-item difficulty | Ordering is asserted ("increasing difficulty"), never published per item — `F3`, and unlike [[wiki/entities/anli.md]] the try count and clock exist (thousands of takers) and are not released |
| Cross-year anchoring | No item is reused, no scale is maintained — `F13` |
| Framing | Every item arrives pre-formalised in competition notation; the search is inside a supplied representation (G73, [[wiki/concepts/problem-framing.md]]) |

**Sample items, for what the format actually asks.** `((3!)!)!/3! = k·n!` with `n` maximal, find `k+n` (2003 I #1, answer 839); find the number of ordered pairs `(a,b)` making `3,4,5,a,b,30,40,50` strictly increasing with **no four terms in arithmetic progression** (2022 I #6, answer 228); complex roots of `z³+qz+r` with `|a|²+|b|²+|c|²=250` forming a right triangle, find `h²` (2012 I #14, answer 375). The second is a constrained enumeration whose difficulty is a *completeness* obligation — every four-subset must be excluded — which is the failure the wiki's only completeness instrument targets ([[wiki/entities/olymmath.md]]'s sum-over-the-whole-solution-set trick, where an incomplete case enumeration becomes visible at the outcome rung). The first and third are single-idea items: find the right rewriting and the arithmetic is mechanical, which is the `find the idea / execute the idea` split [[wiki/entities/frontiermath.md]] makes its human denominator out of.

---

## Connections

- **[[wiki/concepts/human-baseline.md]]** — supplies the wiki's only *annually re-collected, population-scale, `pass@1`, same-items* baseline (mean 4.28–6.63 / 15 over 25 administrations), which is the direct counterexample to open problem `H3` (a fixed baseline compared against a moving machine) and simultaneously shows why re-collection is not free: the item set moves too.
- **[[wiki/concepts/certification-instruments.md]]** — corrects `F11`'s arithmetic to the instrument as administered (15 items, 6.67 points each, SE ≈3.7× a 200-item set) and supplies `F13`, the renewal/comparability trade: annual re-authoring is the only structural fix for `F1`'s depleting blindness stock and it destroys the fixed scale that cross-year claims presuppose.
- **[[wiki/concepts/external-verification.md]]** — the benchmark that page's headline 74 → 83 → 93 ladder is measured on; this page supplies the missing denominator (≈38% for the 2024 qualifier population) and the reason the ladder's own instrument cannot resolve differences below ~2 items.
- **[[wiki/entities/math-dataset.md]]** — MATH draws its items from this ladder and inherits both its answer-only grading and its difficulty scale (AIME items are MATH level 5); this page is the primary source for the top rung MATH's difficulty labels are anchored on.
- **[[wiki/entities/olymmath.md]]** — the benchmark built explicitly as an AIME-equivalent at 3.3× the item count (EASY: DeepSeek-R1 79.6 here vs 79.8 on AIME24) and the source of the resolution-limit argument this page corrects and sharpens.
- **[[wiki/entities/frontiermath.md]]** — states `P(correct | no work) < 1%` as an audited design bound; AIME reaches 0.1% by a format rule alone, so the guessproofness criterion is a formalisation of a 1983 answer-sheet decision rather than a new instrument.
- **[[wiki/entities/gsm8k.md]]** — the same final-answer auto-grading contract at the opposite end of the difficulty ladder (2–8 elementary steps against a 15-item, 3-hour competition), which is the interval `T217`'s per-step-reliability threshold `p*` has to be located inside.
- **[[wiki/entities/hle.md]]** — the modern inversion of this instrument: HLE renews nothing and admits items by an automated model gate, where AIME renews everything and admits by human authorship; the contamination defences are exact opposites and neither yields a stable scale.
- **[[wiki/concepts/benchmark-contamination.md]]** — the only defence on that page's table that costs nothing per audit: renewal rather than secrecy or detection, buying immunity annually and paying in the fixed scale `F13` records.
