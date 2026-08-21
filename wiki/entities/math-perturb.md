# MATH-Perturb — the perturbation that invalidates the method, and the control that proves the model never checked

**279 level-5 MATH problems, each rewritten twice under a hard constraint: the two rewrites are *lexically indistinguishable* (normalised edit distance and embedding cosine matched; retrieval MRR of the original from the perturbation is 0.995 and 0.986), and one of them keeps the original solution method valid while the other destroys it. Every model tested falls on the method-destroying arm and not on the method-preserving one — o1-mini 94.27 → 94.98 → **78.49**. The failure is not recitation: fewer than 10% of errors reproduce the original answer and essentially none reproduce the original text. It is a *learned technique applied without an applicability test*, and supplying the original problem with its worked solution as an in-context example fixes 24–40% of those errors while creating 18–40% more.**

> **Provenance.** Huang, Guo, Li, Ji, Ge, Li, Guo, Cai, Yuan, Wang, Wu, Yin, Tang, Huang, Jin, Chen, Zhang & Wang 2025, *MATH-Perturb: Benchmarking LLMs' Math Reasoning Abilities against Hard Perturbations* (`raw/huang-2025-math-perturb-benchmark.md`, arXiv 2502.06453v2). Built on [[wiki/entities/math-dataset.md]]. **The archived copy is the main body only** — Appendix A (model versions), C.1 (the other failure cases), C.5 (inference-time scaling) and Tables 3, 5, 6, 7 (per-subject counts, the mode-collapse table, the full ICL table) are not available, so the per-subject and per-model ICL numbers below are the ranges the body states, not a table. ICL = In-Context Learning; MRR = Mean Reciprocal Rank (see [[wiki/glossary.md]]).

---

## The artefact

| Property | Value |
|---|---|
| Seeds | **Level-5 (hardest) MATH problems**, 7 subjects, drawn from **both** the train and the test split |
| Size | **279 triples** (original, simple, hard) — 164 seeds from MATH-train, 115 from MATH-test |
| MATH-P-Simple | Non-essential modification; **the original method still solves it** |
| MATH-P-Hard | Small but fundamental modification; **the original method no longer applies** |
| Constraint 1 — minimal edits | Both arms stay close to the original in text form, so surface novelty is matched between them |
| Constraint 2 — changed answers | Both arms have an answer different from the original, so pattern-matching the memorised answer cannot score |
| Annotators | 12 PhD students, all with a mathematics bachelor's and/or competition background; every item cross-validated by a second annotator; every o1-mini/annotator disagreement manually re-checked |
| Grading | Normalised string match + **sympy** equivalence, as in [[wiki/entities/math-dataset.md]] |
| Protocol | **Zero-shot CoT, no tool use** — explicitly, because a code interpreter trivialises many items by brute force |

**Perturbation strategies, as declared.**

| Arm | Moves used |
|---|---|
| Simple | Numerical modification (the default); ask for a different but related quantity; add or remove a non-essential constraint; swap a concept for its contrasting counterpart |
| Hard | Raise the complexity of the mathematical object (e.g. polynomial degree); push a number past the range where brute force is feasible, forcing a general formula or a deeper theorem; relax a constraint to a more general case; **break the simplifying property the original solution exploited** — symmetry, reducibility, linearity |

---

## The similarity control — the reason this is an instrument and not just a harder test set

The pair is matched on every cheap surface measure the field uses:

| Measure | MATH-P-Simple | MATH-P-Hard |
|---|---|---|
| Normalised edit distance from the original | small, distributions overlapping | small, distributions overlapping |
| Embedding cosine (`text-embedding-3-large`) | high | high |
| **MRR retrieving the original from the perturbation** (over the 279 originals) | **0.995** | **0.986** |

An MRR of 0.986 is the paper's sharpest sentence stated as a number: **a semantic-retrieval policy returns the original problem and its solution for the hard perturbation essentially every time.** Any system whose competence is "find the nearest solved problem and reuse its method" is *by construction* unable to tell the two arms apart, and the simple arm is the control that says so — because the same retrieval succeeds there, and there it is correct.

---

## Results (zero-shot CoT, accuracy %)

| Model | Original | MATH-P-Simple | **MATH-P-Hard** | Hard − Original |
|---|---|---|---|---|
| o1-mini | 94.27 | 94.98 | **78.49** | −15.78 |
| Gemini-2.0-flash-thinking-exp | 92.47 | 91.04 | **78.14** | −14.33 |
| o1-preview | 87.81 | 87.81 | **72.40** | −15.41 |
| Gemini-2.0-flash-exp | 88.17 | 82.80 | **67.03** | −21.14 |
| Gemini-1.5-pro | 77.78 | 77.42 | **56.63** | −21.15 |
| GPT-4o | 67.03 | 62.01 | **39.43** | −27.60 |
| Claude-3.5-Sonnet | 64.52 | 58.42 | **38.71** | −25.81 |
| Qwen2.5-Math-7B-Instruct | 58.78 | 51.61 | **27.24** | −31.54 |
| NuminaMath-7B-CoT | 43.73 | 40.14 | **17.20** | −26.53 |
| Llama-3.1-8B-Instruct | 36.56 | 31.54 | **10.04** | −26.52 |
| **MetaMath-13B-V1.0** | 21.15 | **7.53** | 5.73 | −15.42 |

Three readings.

1. **The drop is universal and it survives the reasoning models.** The long-CoT frontier of the day loses 13–16 points where it loses ~0–1 on the method-preserving arm. The gap is not closed by more inference tokens in the class of models that were built to spend them.
2. **The simple-arm drop is concentrated in the MATH *train* split.** For most models, MATH-P-Simple accuracy on test-split seeds ≈ original accuracy on test-split seeds, while train-split seeds lose points. A method-preserving rewrite should cost nothing if the method was learned; it costs something exactly where the item itself was in the fine-tuning data. **This is a contamination instrument that costs one rewrite pass and no templating** — see the exports below. (The authors also note the *simple*-arm drops are far smaller than Functional-MATH's 58–80% relative drops against GPT-4-era models, and read that as genuine progress in robustness to surface perturbation.)
3. **Math-specialised fine-tuning buys the most fragile version of the skill.** MetaMath-13B is the only row whose collapse is on the *simple* arm (21.15 → 7.53, −64% relative), i.e. it has memorised the items rather than the methods; Qwen2.5-Math-7B has the largest hard-arm drop of any model above 40 on the original. Narrow supervised fine-tuning on a fixed distribution of problem settings is the mechanism the paper's closing hypothesis blames.

---

## The failure mode — memorisation of a *technique*, not of a string

Analysis is restricted to the diagnostically clean subset: problems the model **fails on hard but solves on the original or the simple arm** — **20–47% of all items**, depending on the model. The correct solution to the easy version is then available as a reference against which to read the wrong one.

| Signature | What the model does | Example datum |
|---|---|---|
| **Assumption reversion** | Silently reduces the modified condition back to the original condition, then runs the original derivation | Claude-3.5-Sonnet: 50% pass rate over 20 repeated trials on one item; 30% of the failures are this |
| **Unchecked technique transfer** | Applies the original problem's technique without asking whether its preconditions still hold | The paper's Figure 1 case (GPT-4o) |
| **Outcome memorisation** | Answers the *original* question, whose text is not in the context — e.g. returns all integer values where the modified problem asks for the smallest | o1-mini: 75% pass rate over 20 trials on one item; **100% of the failures** are this |

**Estimated share of all errors attributable to memorisation: ~40% for o1-mini, ~25% for Claude-3.5-Sonnet** (manual inspection of 20 error cases each). And the share *rises* with capability, because the general failure modes — arithmetic slips, unjustified claims, missed cases, absent knowledge — are what strong models have already removed.

**The mode-collapse control rules out the boring explanation.** Counting `n_same`, the items where the final answer equals the *original's* ground-truth answer: under 10% of errors for all but three models, and in exactly **one** problem pair across the whole study (gemma-2-9b-it) is the generated text itself a near-copy of the response to the original. So this is not verbatim recall of training material. The collapse is at the level of the **method**: the response is a different text implementing the same plan.

*(brainstorm)* This is the failure the wiki's shortcut taxonomy does not have a slot for. [[wiki/concepts/shortcut-learning.md]] defines a shortcut as a *decision rule* — a mapping from features to answers that holds i.i.d. and breaks o.o.d. Here the retrieved object is a **procedure with unstated preconditions**, and the intended solution and the shortcut share the same first move (recognise the problem type) and diverge only at a step no model performs: *check that the precondition still holds*. In [[wiki/concepts/latent-graph-discovery.md]]'s terms, a simple perturbation re-binds the nodes of the latent graph and a hard perturbation **deletes an edge while leaving every surface cue that indexed it**; the model is keyed on the index. And the wiki already has the name for what is missing: G23's **entry test**. [[wiki/concepts/core-knowledge.md]] argues that a prior without an applicability gate is actively wrong outside its domain, and [[wiki/entities/poe-arc-solver.md]] shows a hand-installed invariance group vetoing correct answers on the tasks where colour carries meaning. MATH-P-Hard is the same defect measured for a **learned** skill rather than an installed one, and it is the first quantity in the wiki for what the missing gate is worth: 13–16 points at the frontier, 25–32 in the tier below.

---

## In-context learning is two-signed, and the two signs nearly cancel

One-shot ICL with **the original problem and its correct solution** as the demonstration:

| Arm | Effect |
|---|---|
| MATH-P-Simple | Helps nearly every model, as it should — the demonstration *is* the method |
| MATH-P-Hard, **ICL effect** (`n_wrong→correct`) | The demonstration supplies genuinely useful mathematical knowledge: **24–40%** of prior errors repaired for large closed models, 2–15% for small open ones |
| MATH-P-Hard, **misleading effect** (`n_correct→wrong`) | The model fails to notice the difference and is dragged onto the demonstrated path: **18–40%** of previously correct items broken for large models, 4–15% for small ones |
| MATH-P-Hard, net | **<5% for most models** |

Two things follow, and the second is the paper's own extrapolation.

- **The misleading effect scales with the model.** The systems best able to use a demonstration are the ones most damaged by a demonstration of a method that does not apply. Capability at in-context learning and vulnerability to an inapplicable in-context example are the same capability.
- **The authors' hypothesis, marked as such:** since ICL is test-time training, *"any naive fine-tuning technique with a limited distribution of problem settings will hurt the generalization of the language models against hard perturbations."* This is a direct prediction against [[wiki/concepts/test-time-training.md]]'s central move — fine-tune on the instance's own neighbourhood, read the answer out — and nobody has tested it in that setting.

**This contradicts a result the wiki already holds.** [[wiki/entities/math-dataset.md]]'s hint curve reads *conditioning on a correct external trace* as the strongly positive third of its three-way trace decomposition (+34 points from 99% of the ground-truth derivation). Here a correct external trace for a problem at cosine-0.99 distance is worth approximately zero. The reconciling variable is whether the supplied trace is a trace **of the problem being asked**; the wiki had been treating "external and correct" as the sufficient condition. See [[wiki/empirical-tensions.md]] T224.

---

## What a builder should take

1. **A perturbation set needs a method-preserving arm.** A drop on a harder rewrite is uninterpretable alone: it can be difficulty. The simple arm at matched edit distance is what converts the drop into a statement about *applicability judgement*, and it is cheap — the same annotator, the same seed, one extra rewrite.
2. **Retrieval-indistinguishability is the design target.** MRR 0.986 is not a statistic about the dataset, it is the property that makes the probe work. Any benchmark aiming at method memorisation should report it.
3. **Compare the perturbation drop on train-split seeds against test-split seeds.** If a method-preserving rewrite only costs points where the seed was in the training data, the seed-specific advantage was memorised. This needs no template, no variable typing, no generator — only a benchmark that shipped a train/test split, which most do.
4. **The missing computation is an applicability test on a retrieved procedure**, and it is separable from both finding the method and executing it. It is the step that has no representation in any architecture in the wiki.
5. **Do not assume a related worked example is safe.** Retrieval-augmented and few-shot pipelines select demonstrations by embedding similarity, which is exactly the criterion that cannot separate the two arms here — so the retrieved example is as likely to be a trap as a hint, at a rate that grows with model capability.

---

## Limitations

- **Hard perturbation changes difficulty *and* applicability at once.** The design cannot fully separate "the model lacks the deeper skill" from "the model failed to notice the skill changed". The failure-mode analysis and the simple arm bound the confound; they do not remove it. *(brainstorm)* The missing control is a **lateral** perturbation — one that invalidates the original method and substitutes a *different method of equal difficulty*. If the drop survives that, applicability judgement is isolated; nobody has built it.
- **The memorisation percentages are `n = 20` manual inspections on two models.** The 40%/25% figures are the paper's own estimate from hand-reading 20 error cases each.
- **279 items, 7 subjects, so the per-subject `n` is ~40 and no per-subject claim here is resolvable** — the certification page's F11 (item count as a resolution limit) applies with force, and the per-subject table is not in the archived copy anyway.
- **No verifier, no sampling, no reranking.** The benchmark measures the proposer under perturbation, exactly as GSM-Symbolic does; whether any rung of [[wiki/concepts/external-verification.md]] repairs the drop is untested here (the inference-time-scaling section is in the unavailable appendix).
- **Contamination is assumed, not measured.** The seeds are decades-old public competition problems; no corpus overlap statistic is computed. The train/test-split asymmetry is the paper's evidence and it is indirect.
- **The annotators judged "the same method applies".** Requirements 1 and 2 are enforced by expert judgement, not by a formal criterion — there is no mechanical test that a solution path has been invalidated.
- **A 2025 model snapshot.** 18 models, versions in the unavailable appendix.

---

## Comparison

| | MATH-P-Simple | **MATH-P-Hard** | GSM-Symbolic ([[wiki/entities/gsm8k.md]]) | GSM-Plus | [[wiki/entities/conceptarc.md]] | MATH² (Shah et al.) |
|---|---|---|---|---|---|---|
| What is held fixed | The solution method | **The surface** | The reasoning graph | The seed problem | The concept | — |
| What is varied | The surface | **The solution method** | Surface bindings, clause count | 8 named skills | 10 instantiations | Skill pairs composed |
| Original problem available as a reference | Yes | **Yes** | Yes | Yes | No | **No** |
| Detects surface overfitting | Yes | — | Yes | Yes | Yes | No |
| Detects **method memorisation** | No | **Yes** | No | No | No | No |
| Difficulty vs the seed | Equal | **Higher, by construction** | Equal | Stated equal | Equal | Higher |
| Contamination read-out | Train/test-split asymmetry | Train/test-split asymmetry | Seed z-score in its own distribution | None | None | None |

The column that matters is *what is varied*. Every other perturbation benchmark in the wiki varies the surface and holds the reasoning fixed, which detects a model keyed on tokens. MATH-P-Hard is the wiki's first benchmark to run the perturbation **the other way round** — hold the surface, change the reasoning — which detects a model keyed on *problem identity*, and those are different defects. MATH² is the near-miss the authors name explicitly: it composes MATH skills into harder problems, but with no original problem to serve as the reference, so it measures difficulty and cannot measure memorisation.

---

## Connections

- **[[wiki/entities/math-dataset.md]]** — the seed corpus, the grading pipeline and the contradiction: this page's items are level-5 MATH problems rewritten twice, and its near-zero ICL gain on the hard arm is the counterweight to MATH's hint curve, since a correct external trace at embedding-cosine 0.99 buys nothing when it is a trace of a *different* problem (T224).
- **[[wiki/entities/gsm8k.md]]** — the complementary half of instrument `I14`, run in the opposite direction: GSM-Symbolic holds the reasoning graph and resamples the surface, this holds the surface and breaks the graph, and only the second can detect a model that retrieved the right method for the wrong problem — and the two contamination read-outs differ in cost, a template plus 50 draws there against one extra rewrite and a train/test split here.
- **[[wiki/concepts/shortcut-learning.md]]** — extends the taxonomy to an object it does not cover: the shortcut here is a **retrieved procedure with unchecked preconditions** rather than a feature-to-answer rule, and the paired arms are what make it visible, since the identical retrieval is correct on one arm and wrong on the other.
- **[[wiki/concepts/certification-instruments.md]]** — supplies instrument `I16` (paired method-preserving / method-invalidating perturbation at matched lexical distance) and the split-asymmetry contamination test that needs neither a corpus nor a template.
- **[[wiki/concepts/core-knowledge.md]]** — the G23 entry-test argument transposed from installed priors to learned skills, and priced: a technique retrieved without an applicability gate costs 13–16 points at the frontier and 25–32 below it, on problems whose preconditions were edited by one clause.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the two arms are the framing's two failure modes made separable: a simple perturbation re-binds the nodes and a hard perturbation deletes an edge while leaving every surface cue that indexed it, so a model that scores on the first and fails the second is navigating an index rather than a graph.
- **[[wiki/concepts/test-time-training.md]]** — the paper's closing hypothesis aimed directly at it: ICL *is* test-time training, and on the hard arm it repairs 24–40% of errors while breaking 18–40%, from which the authors predict that any naive fine-tuning on a narrow distribution of problem settings degrades robustness to method-invalidating shift — untested in the TTT setting.
- **[[wiki/concepts/problem-framing.md]]** — the framing decision made *inside* a fully specified problem: the framing is supplied and the only question is whether the framing the model already has still applies, which is the cheapest scored instance in the wiki of framing as an act of rejection rather than of construction.
- **[[wiki/concepts/external-verification.md]]** — a failure the ladder is silent on, because it is not a step error: every step of the derivation can be locally valid while the whole derivation answers a problem that was not asked, which is a *precondition* check no rung below a proof kernel performs.
- **[[wiki/concepts/analogical-mapping.md]]** — the same operation the analogy literature calls a *near-miss*: the retrieved source is maximally similar and structurally wrong, and MRR 0.986 is the statement that the retrieval stage (MAC) cannot be the one that rejects it, so the rejection has to happen at mapping time.
- **[[wiki/entities/olymmath.md]]** — the neighbouring perturbation extreme: OlymMATH changes every token and no relation (translation), this changes almost no tokens and one relation, and the pair brackets the axis `I14` runs along.
- **[[wiki/entities/conceptarc.md]]** — the same hold-one-vary-the-other discipline in the grid domain, and the missing arm: ConceptARC varies the instantiation and holds the concept, and has no counterpart that holds the instantiation and changes the concept.
- **[[wiki/empirical-tensions.md]]** — T224 (whether a correct external worked solution helps or hurts).
- **[[wiki/concepts/rule-level-evaluation.md]]** — the instrument that would make this page's failure-mode analysis mechanical rather than manual: the memorisation signatures are read out of hand-inspected traces here, where asking the solver to state the method it is applying — and whether it still applies — would score the same thing at scale.
- **[[wiki/concepts/benchmark-contamination.md]]** — this page's train-split-concentrated drop is a contamination read-out from the *accuracy* side, complementary to the likelihood-side differential (`I19`): it costs expert authoring, and in exchange it survives the reformatting that defeats every token-matching detector.
