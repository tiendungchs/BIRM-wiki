# Perception–Reasoning Dissociation

**A score on a visual reasoning benchmark is a product, not a measurement: `P(parse correct) × P(rule induced | parse) × P(rule applied | rule)`. The dissociation instruments are the designs that factor it — substitute one stage, hold the others fixed, and read the difference. Run on Mini-ARC, ACRE and Bongard-LOGO, stage substitution moves accuracy by **+11 to +12.5 points** with the same model on both sides, and manual attribution puts **84–89% of one-stage failures** at the perception steps (Wang et al. 2026).**

> **Provenance.** Wang, Huang, Zhang, Wang & Ma 2026, *Your Reasoning Benchmark May Not Test Reasoning: Revealing Perception Bottleneck in Abstract Reasoning Benchmarks* (`raw/wang-2026-perception-bottleneck-abstract-reasoning-benchmarks.md`, arXiv 2512.21329v2). Three benchmarks, four models (GPT-4o, LLaVA-1.5, o1, Claude Sonnet 4.5), error attribution on 50 randomly selected tasks per configuration (100 for Bongard-LOGO), attribution **manual** with no automated procedure offered.

---

## The instrument: stage substitution with a leakage control

| Step | Specification | Why the clause is load-bearing |
|---|---|---|
| 1 | Define transformations `g_X : X → X̃`, `g_Y : Y → Ỹ` that convert each image into a natural-language description, applied **uniformly** across all tasks in a benchmark | A per-task transformation is a hand-parse and smuggles the answer |
| 2 | **No cross-image inductive-signal leakage** — `g` sees exactly one image, never a pair, never the task | The single design clause that makes the comparison admissible: a describer that sees two images can state the *relation*, which is the quantity being measured |
| 3 | Describe with **generic** human perceptual priors only — objects, colours, shapes — never task-specific features | Keeps `g` a perception stage rather than a solver |
| 4 | Feed the enriched task `T̃ = {(x_i, g_X(x_i), y_i, g_Y(y_i)), …, (x_{n+1}, g_X(x_{n+1}))}` to a reasoner `h` | Image is **retained** alongside the description, so the reasoner is never denied information |
| 5 | Compare `h(T̃)` against one-stage `f(T)` — same model (Setting 1) or strong-describer/weak-reasoner (Setting 2) | Setting 1 attributes the delta to perception by construction; Setting 2 prices the strong/weak model gap |

**Four-step error taxonomy**, applied to reasoning traces by hand: perception (demonstration) → reasoning (inductive) → perception (test) → reasoning (deductive), errors attributed to the **earliest failing step**.

---

## What it returns

**Setting 1 — same model both stages** (GPT-4o; LLaVA-1.5 on ACRE). Success rate %:

| Benchmark | one-stage | two-stage | Δ |
|---|---|---|---|
| Mini-ARC | 8.05 | **20.13** | +12.08 (2.5× relative) |
| Bongard-LOGO | 62.00 | 73.00 | +11.00 |
| ACRE | 22.00 | 34.50 | +12.50 |

**Setting 2 — stronger describer, weak reasoner.** `(c)` = strong `g` + weak `h`; `(d)` = strong model end-to-end:

| Benchmark | (a) weak e2e | (b) weak+weak | (c) strong-`g` + weak-`h` | (d) strong e2e |
|---|---|---|---|---|
| Mini-ARC | 8.05 | 20.13 | 31.54 (o1) / 32.89 (Sonnet 4.5) | **52.03** (o1) / 34.22 (Sonnet 4.5) |
| Bongard-LOGO | 62.00 | 73.00 | **80.00** | 78.00 |
| ACRE | 22.00 | 34.50 | 82.50 | **93.00** |

**Error attribution**, % of errors (one-stage → two-stage):

| Benchmark | Total errors | Perception (demo) | Reasoning (inductive) | Perception (test) | Reasoning (deductive) |
|---|---|---|---|---|---|
| Mini-ARC | 44 → 37 | 86.4 → 59.5 | 9.1 → 24.3 | 2.3 → 5.4 | 2.3 → 10.8 |
| Bongard-LOGO | 38 → 27 | 65.8 → 37.0 | 13.2 → 44.4 | 18.4 → 11.1 | 2.6 → 7.4 |
| ACRE | 38 → 32 | 76.3 → 68.8 | 15.8 → 21.9 | 7.9 → 9.4 | 0 → 0 |
| ACRE, LLaVA-`g` → GPT-4o-`g` | 32 → **9** | 68.8 → **0** | 21.9 → **100** | 9.4 → **0** | 0 → 0 |

---

## What the numbers say that the paper's headline does not

- **The single cleanest row is the last one.** Swap the describer on ACRE and perception errors go to **exactly zero**; all nine residual errors are inductive. That is the only configuration in the wiki where a visual reasoning failure has been driven to a pure reasoning residue, and it certifies the taxonomy rather than merely applying it.
- **…and the same row prices the reasoning deficit the perception claim hides.** With perception errors at zero, the hybrid still scores 82.50 against GPT-4o end-to-end at 93.00. That 10.5-point gap cannot be perceptual — the perception stage is shared-or-better — so it is LLaVA-1.5's inductive reasoning, measured. Perception being the *dominant* term does not make the reasoning term small.
- **Absolute reasoning errors rise while their share is what gets reported.** Mini-ARC inductive errors go 4 → 9 and deductive 1 → 4 as perception is repaired. Perception was *masking* reasoning failures, so every prior estimate of model reasoning on these benchmarks was an underestimate of the deficit as well as of the capability.
- **Setting 2's claim fails on the one ARC-format benchmark.** The paper reports `(c)` and `(d)` as "mostly close". On Bongard-LOGO 80.00 vs 78.00 — closed and reversed. On ACRE 82.50 vs 93.00. On **Mini-ARC 31.54 vs 52.03**, a 20.5-point gap in which strong perception recovers well under half of the strong/weak model difference. Grid induction is where the reasoning stage still costs the most, which is the opposite of the ordering the abstract implies.
- **Ceiling, not just delta.** Mini-ARC with perception aided is 20.13% (31.54% with an o1 describer). Repairing perception this way lifts an ARC-format score by a factor and leaves it nowhere near human. The result bounds attribution; it does not license "perception is the whole gap".

## The methodological objection the row must carry

**Earliest-step attribution plus a sequential dependency graph guarantees perception the count.** The protocol declares steps 1→2→3→4 dependent and assigns every failure to the first step that breaks. Any trace in which perception *and* induction are both wrong is scored perceptual by construction, and there is no configuration in the paper that measures induction on a *guaranteed-correct* parse — the describer is another VLM, not an oracle, and its output is checked by the same rater reading the same trace. The 80% figure is therefore an upper bound on the perceptual share under the most perception-favourable admissible accounting, not a point estimate. The authors concede the attribution is manual and subjective; they do not concede that the attribution rule has a direction.

**And the substitution is not information-preserving.** A natural-language description is a *lossy, discrete, already-conceptualised* re-encoding: it fixes an object vocabulary before the rule is known, which is precisely the query-relativity [[wiki/concepts/visual-routines.md]] argues a parse cannot have. The authors state this as limitation 1 — language is "not an optimal or canonical intermediate representation". Two consequences pull opposite ways and neither is measured: the description can **destroy** a relation nobody thought to name (depressing the two-stage score, so the delta understates the perceptual share), or it can **quantise** a continuum into exactly the predicates the rule needs (inflating it). `g` is uniform across tasks, which bounds the second, and nothing bounds the first.

---

## Where this sits in the dissociation family

Four designs now factor the same product, each removing a different term:

| Design | What is held at zero | Reads | Source |
|---|---|---|---|
| **Remove the rule** | Reasoning demand | Absolute perceptual floor: 58.07% mean, 24% chance, human 100% | [[wiki/entities/blindtest.md]] |
| **Substitute the parse** | Perception difficulty (partially) | Δ accuracy +11 to +12.5; 84–89% of failures perceptual | this page (Wang et al. 2026) |
| **Classify the rule** | Nothing — scores both channels from one run | Rule stated but grid wrong (19.6% of tasks, o3 visual) vs grid right but rule unintended (15.8%, textual) | [[wiki/concepts/rule-level-evaluation.md]] |
| **Remove the reasoner** | Reasoning *capacity* | 60.4% on ARC-1 from an 18M ViT with no language model at all | [[wiki/entities/varc.md]] |

**The four agree on sign and disagree on magnitude**, and the disagreement is informative: rule-removal and reasoner-removal both put the whole gap in perception, while parse-substitution — the only one that repairs perception *in situ* and leaves the reasoner in place — recovers 12 points of an ~80-point gap on Mini-ARC. **(brainstorm)** The reconciliation is that the substitutable object is not the parse. A VLM handed a text description has been given *a* parse, once, in a vocabulary chosen before the question; VARC was given a metric on the input and computed its own, per task, under the rule's pressure. If that is right, the wiki's perceptual deficit is not "the parse is absent" but "the parse is not re-computable under a query", which is `G75` and [[wiki/concepts/visual-routines.md]]'s query-relativity requirement stated as a measurement result.

---

## Open problems

- **No oracle-parse condition exists.** Every dissociation so far substitutes a *model-generated* intermediate. Supplying a ground-truth object list — `T215`'s stated `Closes when` — remains unrun, and until it is, the reasoning stage has never been scored on a parse known to be correct.
- **Attribution has no algorithmic form** — same limit as [[wiki/concepts/rule-level-evaluation.md]], reached independently, and the two are the only rule/parse-level instruments in the wiki. Neither scales.
- **The describer's own errors are unscored.** `g` is never evaluated against the image; its failures are visible only through downstream errors, so perception accuracy is inferred from the reasoner's behaviour rather than measured.
- **Benchmarks are not ARC.** Mini-ARC (reduced colours, smaller grids), ACRE (causal induction, not grid transformation) and Bongard-LOGO (binary concept classification). The paper does not run ARC-AGI-1 or -2, and Mini-ARC's own 8.05% one-stage baseline is far below reported GPT-4o performance on larger ARC evaluations under other harnesses.
- **`n = 50` per configuration.** Every attribution percentage rests on 27–44 errors; the reported cell differences of a few points are inside sampling noise.

---

## Connections

- **[[wiki/concepts/rule-level-evaluation.md]]** — the same factorisation obtained by *classifying* the rule instead of *replacing* the parse, and the two are complementary halves of one instrument: that page reads the rule off a run where perception is broken, this one repairs perception and reads what is left; both bottom out in a human rater and neither has an algorithmic classifier.
- **[[wiki/entities/blindtest.md]]** — the zero-reasoning limit of this page's design: instead of easing the perception stage, remove the rule entirely, which turns a delta into an absolute floor (58.07% against 24% chance) and needs no describer and no attribution rater.
- **[[wiki/entities/varc.md]]** — the constructive opposite: rather than describing the grid *to* a reasoner, give a vision model the grid as an image with a metric and delete the reasoner, which reaches 60.4% where description reaches 20.13% — the evidence that a fixed verbal parse is not what the missing perception is made of.
- **[[wiki/concepts/visual-routines.md]]** — names what a uniform `g` cannot supply: a routine is assembled *per query* over a base representation, so a description fixed before the rule is known is a parse in the wrong tense, which is this page's best explanation for why the repair lifts an ARC-format score by 12 points and not by 60.
- **[[wiki/concepts/certification-instruments.md]]** — this page is instrument `I47`, the inventory's only stage-substitution design, and the only one whose admissibility rests on a stated *leakage* clause rather than on a held-out split.
- **[[wiki/concepts/problem-framing.md]]** — the four-step taxonomy is that page's framing/optimisation split given a measurement protocol on visual tasks: steps 1 and 3 build the representation the problem is posed over, steps 2 and 4 search within it, and the finding is that the wiki's benchmarks price the first pair while claiming to measure the second.
- **[[wiki/concepts/human-baseline.md]]** — the paper's motivating observation is a baseline claim with no measurement behind it: that humans find the serialised presentation of an ARC task far harder than the 2-D one is asserted from Figure 1 and never run, although it is the entire premise of the perceptual hypothesis.
- **[[wiki/entities/conceptarc.md]]** — the benchmark where the same attribution was reached from the opposite direction (49.1–77.3% separately-scored visual-error rates with rule–grid alignment above 93%), on frontier models and 480 items rather than 50.
- **[[wiki/entities/arc-agi.md]]** — what the result does to every score on that page: an ARC-family number is a joint measurement of parse and rule, so the wiki's ARC table ranks systems on a quantity whose dominant term is not the one the benchmark was authored to isolate.
