# ANLI and HAMLET — the benchmark defined relative to the model that is being tested

**Adversarial NLI (ANLI) is not a fixed set of items but the *fixed point of a loop*: a human writer is shown a context and a target label and paid to write a hypothesis the current best model gets wrong; two further humans verify the label; the surviving items become a test set and the rest become training data; a new model is trained and the loop turns again. Three rounds produced 162,865 training and 3,200 test items. The reported score is the **model's error rate on freshly authored items** (18.33% → 8.07% → 8.60% verified), which is a quantity a benchmark cannot saturate, because the benchmark is regenerated against whatever the model has become.**

> **Provenance.** Nie, Williams, Dinan, Bansal, Weston & Kiela 2020, *Adversarial NLI: A New Benchmark for Natural Language Understanding* (`raw/nie-2020-adversarial-nli.md`, UNC Chapel Hill + Facebook AI Research). All numbers are the paper's own; appendices A–C are in the ingested text only as summary. NLI = Natural Language Inference: given a context (premise), label a hypothesis *entailment* / *contradiction* / *neutral* — presented to annotators as "definitely correct" / "definitely incorrect" / "neither".

The task is linguistic and the models are 2019 masked language models, so nothing here is architecturally load-bearing for this wiki. What is load-bearing is the **protocol**: HAMLET is the wiki's first benchmark-construction loop in which difficulty is *measured per item at authoring time* rather than asserted per benchmark, and the first in which the data-collection policy is conditioned on the learner's own failures with the resulting coefficient measured at matched budget.

---

## HAMLET — Human-And-Model-in-the-Loop Enabled Training

| Step | Actor | Output |
|---|---|---|
| 1. Write | Human **writer**, given `(context, target label)` and live model probabilities as feedback | A hypothesis, retried up to 5 (round 1) or 10 (rounds 2–3) times until the model misclassifies; plus a free-text **reason** why the writer thinks it was fooled |
| 2. Model feedback | Current model (round 2–3: a **random member of an ensemble** of differently-seeded models, drawn per turn) | Predicted label. Model-correct → item goes to *training* data, unverified |
| 3. Verify | Two human **verifiers**, third as tie-break; verifiers may overrule the writer's target label | Model-wrong *and* verified → dev/test. Disagreement after tie-break → discarded |
| 4. Retrain | — | New model on all prior data + this round; test set restricted to label-balanced items from **exclusive** annotators never present in training |

Two structural properties, both of them the point:

- **The adversary is a human, not an optimizer.** Gradient-based adversarial examples perturb an input off the data manifold; a paid human writes a *new, well-formed, human-verifiable* item. So the found weakness is by construction one that matters, which no `ε`-ball attack can guarantee.
- **The loop has a proposer and a rejector, and they are different agents.** The writer maximises model error; the verifiers reject items whose label is wrong. §"Verification is where the value is" below measures what happens when the rejector is removed, and the answer is: the data becomes worthless.

---

## Dataset and the difficulty read-outs

| Round | Context genre | Train / Dev / Test | Model error rate, unverified | verified | Tries mean/median | Sec. per verified item |
|---|---|---|---|---|---|---|
| A1 | Wikipedia (via HotpotQA) | 16,946 / 1,000 / 1,000 | 29.68% | **18.33%** | 3.4 / 2.0 | 199.2 / 125.2 |
| A2 | Wikipedia | 45,460 / 1,000 / 1,000 | 16.59% | **8.07%** | 6.4 / 4.0 | 355.3 / 189.1 |
| A3 | News, fiction, spoken, procedural, Wiki | 100,459 / 1,200 / 1,200 | 17.47% | **8.60%** | 6.4 / 4.0 | 284.0 / 157.0 |
| A3, Wiki subset only | Wikipedia | 19,920 / 200 / 200 | 14.79% | **6.92%** | 7.4 / 5.0 | 337.3 / 189.6 |

Base models: A1 = BERT-Large trained on SNLI+MNLI; A2 = RoBERTa on SNLI+MNLI+FEVER+A1; A3 = RoBERTa ensemble with A2 added.

**Three quantities here are benchmark-difficulty measurements that cost nothing extra, and no other benchmark in the wiki reports any of them.** Verified model error rate (does the model fail?), **tries per success** (how hard was it to make it fail?) and **seconds per verified error** (what did that cost?). The last two are *continuous, per-item, collected during authoring*, so difficulty is a measured property of each item rather than a claim about the set. This is exactly the audit gap G17 records against ARC-AGI-1 — "difficulty is asserted per-benchmark and never measured per-task", with 49% of its private set falling to blind brute-force search ([[wiki/entities/arc-agi.md]], [[wiki/empirical-tensions.md]] T205). ANLI's analogue of a `GD ≈ 0` item is one solved on try 1, and it is visible in the log.

The A3 rise (8.07 → 8.60) against a *stronger* base model is domain shift, not regression: on the Wikipedia subset, held fixed across rounds, the error rate fell to 6.92%.

---

## Results

RoBERTa unless noted. `S` = SNLI, `M` = MNLI, `F` = FEVER-as-NLI, `ANLI` = A1+A2+A3, `-E` = the exclusive-annotator test subset. Chance = 33.3% (label-balanced).

| Training data | A1 | A2 | A3 | ANLI | ANLI-E | SNLI | MNLI-m/-mm |
|---|---|---|---|---|---|---|---|
| S,M | 47.6 | 25.4 | 22.1 | 31.1 | 31.4 | 92.6 | 90.8 / 90.6 |
| S,M,F,**A1** *(base model for round 2)* | 68.7 | **19.3** | 22.0 | 35.8 | 36.8 | 92.8 | 90.9 / 90.7 |
| S,M,F,A1,**A2** *(base model for round 3)* | 71.2 | 44.3 | **20.4** | 43.7 | 41.4 | 92.9 | 91.0 / 90.7 |
| S,M,F,ANLI | **73.8** | 48.9 | 44.4 | 53.7 | 49.7 | 92.6 | 91.0 / 90.6 |
| BERT, S,M,F,ANLI | 57.4 | 48.3 | 43.5 | 49.3 | 44.2 | 91.3 | 86.0 / 85.8 |
| XLNet, S,M,F,ANLI | 67.6 | **50.7** | **48.3** | 55.1 | 52.0 | 91.8 | 89.6 / 89.4 |

**Every base model scores *below chance* on the round it authored** (19.3, 20.4; round 1 is 0.0 by construction). Below chance, not at chance, is the finding: annotators did not find noise, they found *systematic* wrong beliefs, and they found them in an ensemble of differently-seeded models, so the vulnerabilities are properties of the model class rather than of one parameter vector. This is the same signature [[wiki/entities/hbtom.md]] shows at 26.3% on a paired violation-of-expectation task — a below-chance score is the only kind of score that proves the learner acquired *an* opposite rule rather than no rule.

**And the counter-evidence in the same table.** BERT and XLNet, trained on identical data, beat RoBERTa on A2 and A3 — the rounds RoBERTa itself seeded. So the collected data is simultaneously model-class-general (below-chance base) and model-specific (a different architecture finds it easier). Both readings are true of the same table; see [[wiki/empirical-tensions.md]].

**Annotator style is not the signal.** ANLI-E (writers held out of training entirely) tracks ANLI within ~4 points, which rules out the Geva et al. 2019 failure mode of modelling annotator artefacts instead of the phenomenon.

---

## Adversarially-collected data is more data-efficient — measured at matched budget

Table 5, RoBERTa dev, with SNLI+MNLI downsampled so each pair of rows has *identical* training-set size:

| Training data | A1 | A2 | A3 | SNLI | MNLI-m/mm |
|---|---|---|---|---|---|
| SM (half) + SM (half) | 45.1 | 26.1 | 27.1 | 92.5 | 89.8 / 89.7 |
| SM (half) + **ANLI** | **72.6** | **42.9** | **42.0** | 92.3 | 90.3 / 89.6 |
| SM (full) | 48.0 | 24.8 | 31.1 | 93.2 | 90.8 / 90.6 |
| SM (reduced) + **ANLI**, same total | **73.3** | **42.4** | **40.5** | **93.3** | 90.8 / 90.7 |

**+27.5 / +16.8 / +14.9 points for the same number of gradient steps, and the i.i.d. scores do not move.** Substituting failure-conditioned examples for i.i.d. examples is close to a free lunch in this setting. Separately, ANLI alone (163k items) matches BERT trained on the fully in-domain SNLI+MNLI (943k) on MNLI, both ≈86.

This is the cleanest coefficient the wiki has on gap **G32** (nothing designs the experience stream) from the *supervised* side, and it sits beside the two existing measurements — the non-monotone curriculum ablation of [[wiki/entities/irene.md]] and the ×3.5 pair-sampler swing of [[wiki/entities/i-jepa.md]]. Its distinguishing property: the sampler here is **closed-loop on the current model's errors**, where those two are open-loop choices made before training. The price is that the sampler is a paid human at ~5 minutes per accepted item.

---

## Verification is where the value is

Verified-only, unverified-only, and combined training sets, downsampled to equal size (Fig. 3): **verified examples are worth much more, and unverified data drops to random on the later rounds.** So the model-wrong signal alone is not the asset — the asset is *model-wrong ∧ human-right*, which requires a second, independent human pass costing roughly as much as the first.

Stated in the wiki's terms, HAMLET is a **proposer + rejector pair** in which the rejector is load-bearing and is not automatable — the gap G68 shape ("every architecture in the wiki is a proposer; nothing is a rejector"), instantiated with the rejector's marginal value measured. *(brainstorm)* The natural automation target is not the writer but the verifier: an acceptance test with a false-positive rate low enough to replace two humans would make the loop self-running, and this is the same requirement [[wiki/concepts/external-verification.md]] states for RLVR-style training. The paper offers no such test and notes the cost objection honestly.

---

## The hypothesis-only result — a benchmark so hard the strong baseline catches the model

A hypothesis-only model sees the hypothesis and never the context, so it can only exploit surface artefacts of how annotators phrase each label. It is the [[wiki/concepts/shortcut-learning.md]] "surprisingly strong baseline" instrument.

| Model | A1 | A2 | A3 | SNLI | MNLI-m/mm |
|---|---|---|---|---|---|
| Full, ALL | 73.8 | **48.9** | **44.4** | 92.6 | 91.0 / 90.6 |
| **Hypothesis-only**, ALL | 49.7 | **46.3** | **42.8** | 71.4 | 60.2 / 59.8 |
| Hypothesis-only, S+M | 33.1 | 29.4 | 32.2 | 71.8 | 62.0 / 62.0 |

Two readings, both worth carrying:

1. **ANLI resists the artefact** the SNLI/MNLI hypothesis-only score of 71.4 exposes: trained on SNLI+MNLI only, hypothesis-only sits at chance on ANLI, and hypothesis-only performance *decreases across rounds* as the loop turns.
2. **On A2 and A3 the full model beats the partial-input baseline by 2.6 and 1.6 points.** The authors verify the training data is fine (the ANLI-only model matches a 943k-item model), so the conclusion is that a state-of-the-art model is barely reading the context at all on these items. **A benchmark where the strong-baseline instrument converges on the full model is one where the instrument has stopped discriminating** — this is the failure mode [[wiki/entities/conceptarc.md]] states from the other side (a benchmark that floors every solver destroys the ordering it exists to produce). Adversarial authoring against the current model drives directly toward that regime, because that is what it optimises for.

---

## What actually fooled the models

Manual annotation of 500 dev items per round against a six-type inference ontology (multi-label; every item has ≥1 tag):

| Round | Numerical & quant. | Reference & names | Standard (conjunction, negation, cause/effect, comparatives) | Lexical (synonym, antonym) | Tricky (wordplay, syntactic reordering, writer intent) | Reasoning & outside facts | Quality flagged |
|---|---|---|---|---|---|---|---|
| A1 | 38% | 13% | 18% | 13% | 22% | **53%** | 4% |
| A2 | 32% | 20% | 21% | 21% | 20% | **59%** | 3% |
| A3 | 10% | 18% | 27% | 27% | 27% | **63%** | 3% |

- **Outside knowledge dominates and grows** (53 → 63%). The majority of what defeats a language model on an inference task is not inference — it is a fact the model does not have. For this wiki that is the [[wiki/concepts/controller-knowledge-vs-process.md]] split, measured on a benchmark whose name says it is testing process: roughly 60% of the items are knowledge-limited, so ANLI's headline number is not a reasoning score.
- **Numerical/quantitative collapses 38 → 10%** as the loop turns, and the stress-test table below shows why: this is a weakness the loop *fixed*, so writers stopped being able to use it. **The composition of an adversarial benchmark is a read-out of which weaknesses have been closed** — a diagnostic that no static benchmark can produce, and the strongest argument on this page for running the loop rather than publishing a set.
- **Standard, lexical and tricky all rise** as numerical falls: the writers were pushed up the difficulty ladder. (The prose reports 17% and 31% where the table gives 10% and 27%; the table is used here.)

---

## Transfer to independent stress tests

Adding ANLI to the training mix, evaluated on test sets ANLI's authors did not build:

| | SNLI-Hard | Antonym (m/mm) | Numerical reasoning | Negation | Word overlap | Spelling error |
|---|---|---|---|---|---|---|
| Prior published models | 72.7 | 14.4 / 10.2 | 28.8 | 48.8 / 46.6 | 50.0 / 50.2 | 58.3 / 59.4 |
| RoBERTa S+M+F | 84.5 | 81.6 / 77.2 | 62.1 | 61.9 / 61.9 | 67.9 / 66.2 | 86.2 / 86.5 |
| RoBERTa **+ANLI** | **84.7** | 85.9 / 82.1 | **80.6** | 62.2 / 61.9 | 67.4 / 65.6 | 86.3 / 86.7 |

**+18.5 points on numerical reasoning** from data collected with no numerical-reasoning intent, by writers who simply found that numbers worked. The weakness class the annotators discovered generalises to a differently-authored probe of the same class — which is the evidence that the loop finds *categories* of failure rather than items, and the strongest single result on this page.

---

## Comparison to the wiki's other benchmark-construction protocols

| | ANLI | [[wiki/entities/arc-agi.md]] / [[wiki/entities/arc-agi-2.md]] | [[wiki/entities/conceptarc.md]] | [[wiki/entities/pgm.md]] |
|---|---|---|---|---|
| Items authored by | Paid non-experts, adversarially | Experts, to a prior spec | Experts, around 16 named concepts | A symbolic generator |
| Item difficulty | **Measured per item** (tries, seconds, model-wrong) | Asserted per benchmark | Asserted, humans at ceiling by design | Declared as a held-out abstraction |
| Difficulty is relative to | **The current model** | The stated Core Knowledge priors | A concept inventory | The generator's `[r,o,a]` triples |
| Saturation | Impossible by construction; run another round | Structural (5 years, ~10,000 leaked scores) | Fixed set | Fixed generator |
| Held-out abstraction nameable? | **No** — only post-hoc, by manual annotation | Partly | Yes, by construction | Yes, formally |
| Human baseline | Implicit: every test item was verified by ≥2 humans | Measured separately | 415 participants | None |
| Marginal cost per item | **~5 min writer + 2 verifiers** | High, one-off | High, one-off | ~zero |

**The trade the table makes visible.** ANLI buys non-saturation and per-item difficulty, and pays with *nameability*: it cannot say what abstraction its test set withholds, because the set is defined extensionally as "whatever the model got wrong". PGM is the exact converse — every held-out abstraction is a named triple, and the whole item distribution is developer-known. *(brainstorm)* These are complementary and nobody has run them together: use a generator to author candidates, and use HAMLET's model-in-the-loop filter as the *selection* step over generated items. That gives a named held-out abstraction *and* a per-item difficulty measurement, and it removes the human writer — the loop's dominant cost — while keeping the verifier, which is the part the data says is load-bearing. Its precondition is the same computable "same concept, different instantiation" generator that G17 already records as missing.

---

## Limitations

- **Task and models are dated.** BERT / RoBERTa / XLNet, 2019; the protocol is the export, not the numbers.
- **No round 4.** "Never-ending learning" is proposed and demonstrated for three iterations; whether error rate keeps falling, or whether writers exhaust their strategies, is untested. The A1→A2 drop (18.3 → 8.1) is far larger than A2→A3 (8.1 → 6.9 on matched genre), which is one data point in the direction of diminishing returns.
- **Training items are unverified**, by design and by cost. The authors flag this as a known source of label noise.
- **Catastrophic forgetting and online updating are named open problems, not addressed** — every round retrains from scratch, which is precisely the cost that makes the loop unattractive to run continuously ([[wiki/concepts/continual-learning.md]]).
- **The method does not obviously extend to generation.** The authors say so: the loop needs a discrete label a verifier can agree or disagree with. This is the same precondition [[wiki/concepts/refinement-loop.md]] identifies as a property of the *task supply* rather than of the method.
- **Adversarial authoring optimises for the current model's blind spots, and nothing checks that those coincide with the intended ability.** The hypothesis-only convergence above is the first symptom.

---

## Connections

- **[[wiki/concepts/shortcut-learning.md]]** — supplies both halves of the surprisingly-strong-baseline instrument in one paper: a partial-input model that is at chance on ANLI while scoring 71.4 on SNLI (the benchmark blocks the artefact), *and* the case where the instrument stops working, since on rounds 2–3 the full model beats hypothesis-only by under 3 points.
- **[[wiki/concepts/external-verification.md]]** — the loop's rejector is two paid humans, and the measurement of what they are worth (unverified data drops to random) is a price tag on the acceptance test that page's automatable-verification ladder is trying to lower.
- **[[wiki/concepts/refinement-loop.md]]** — the same propose/verify structure run one level up: the object refined is the *benchmark* rather than a candidate answer, the mutation operator is a human writer conditioned on the model's live probabilities, and the feedback signal is the model's own error — so the loop's two preconditions (checkable candidate, cheap retry) are inherited by benchmark authoring exactly as they are by solving.
- **[[wiki/entities/arc-agi-2.md]]** — the same conclusion reached from the static side: its authors treat benchmark authorship as a refinement loop run against the field, with the stopping criterion "authoring tasks easy for humans and hard for AI becomes impossible". ANLI is that loop run against one model on a fixed schedule instead, which makes the stopping criterion a *measured error rate* rather than an authoring intuition — and shows the leakage problem being paid for in annotator wages rather than in benchmark lifetime.
- **[[wiki/entities/pgm.md]]** — the exact converse protocol, and the pairing worth building: PGM names the withheld abstraction formally and cannot say how hard any item is; ANLI measures how hard every item is and cannot name what it withholds.
- **[[wiki/entities/conceptarc.md]]** — the discriminability argument from the other direction: ConceptARC's diagnostic regime is humans-at-ceiling and solvers spread out, while adversarial authoring drives *toward* the regime where every solver is floored and the ordering collapses, which is what the A2/A3 hypothesis-only convergence records.
- **[[wiki/entities/arc-agi.md]]** — the per-task difficulty audit ARC's own retrospective says it lacks (49% of the private set fell to blind search) is a by-product of ANLI's collection procedure, obtained for free from the annotator's try count and clock.
- **[[wiki/entities/hbtom.md]]** — the other below-chance result in the wiki, and the same reading: a score under chance is positive evidence of an acquired wrong rule, which no accuracy above chance can supply.
- **[[wiki/concepts/controller-knowledge-vs-process.md]]** — the composition analysis prices the split on a benchmark that claims to test inference: 53–63% of the items that defeat the model need an outside fact, so most of what looks like a reasoning gap is a coverage gap.
- **[[wiki/concepts/continual-learning.md]]** — the loop's unpaid bill: every round retrains from scratch because nothing supports adding a round's data without forgetting, and the authors name this as the obstacle to running HAMLET continuously.
- **[[wiki/concepts/meta-learning.md]]** — the environment family here is *generated by a human adversary conditioned on the current learner*, which is the closed-loop version of the multi-environment signal that makes invariant rules identifiable, and the one variant no outer loop in the wiki implements.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the developer-awareness argument with the developer removed from the loop: because items are authored against the deployed model rather than against a spec, no prior the builder injected can be pre-purchased — but the difficulty is defined relative to that model, so the score is not comparable across systems, which is the price.
- **[[wiki/empirical-tensions.md]]** — T216: whether a human paid to fool one model finds that model's idiosyncratic blind spots or the model class's, with below-chance base-model scores on one side and BERT/XLNet beating RoBERTa on the rounds RoBERTa seeded on the other.
- **[[wiki/entities/math-dataset.md]]** — the converse difficulty measurement: MATH's levels 1–5 are inherited from an external annotator community and are therefore stable across systems but unmeasured per item, where this page's are measured per item at authoring time and are relative to one model.
