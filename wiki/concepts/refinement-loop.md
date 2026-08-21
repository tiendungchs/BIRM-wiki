# Refinement Loop

**Iteratively transform one program — or one model, or one candidate answer — into a slightly better version of itself, guided by a feedback signal computed on the single task being solved. Not a search over a space of solutions, but a *trajectory* through it, per task, discarded afterwards.**

> **Provenance.** Chollet, Knoop, Kamradt & Landers 2026, *ARC Prize 2025: Technical Report* (`raw/chollet-2025-arc-prize-report.md`), which names it "the defining theme of 2025" and the central mechanism behind every top score on [[wiki/entities/arc-agi-2.md]]. The individual systems cited (TRM, CompressARC, SOAR, Berman, Pang, Poetiq) are **secondary here** — reported by the survey, not read at source.

The wiki has held the pieces of this separately — [[wiki/concepts/test-time-training.md]] as weights, [[wiki/concepts/program-induction.md]] as symbols, [[wiki/concepts/external-verification.md]] as the acceptance test — and this is the claim that they are **one mechanism in four substrates**, which is worth a page because the substrate turns out to be the least important variable.

---

## The unification

Every 2025 ARC result instantiates the same three-part loop: a **current candidate**, a **mutation operator**, and a **feedback signal** computed from the task's own demonstration pairs.

| Substrate | What gets refined | Mutation operator | Feedback signal | Instance |
|---|---|---|---|---|
| **Weight space, pretrained** | The weights of a pretrained model | Gradient descent on the task's demonstration pairs | Training loss on those pairs | TTT (NVARC 24.03%, MindsAI 12.64%) |
| **Weight space, from scratch** | The weights of a randomly-initialised tiny network | Gradient descent, no pretraining at all | Description length (CompressARC) or deep supervision over recursion steps (TRM) | CompressARC 76K params · TRM 7M params |
| **Symbolic program space** | A Python program | LLM-proposed edits, evolutionary selection | Execution against demonstration pairs + a learned abstraction library | Pang, "Efficient Evolutionary Program Synthesis" |
| **Natural-language program space** | A prose description of the transformation | LLM rewriting under evolutionary pressure | Verification phase analysing candidate outputs | Berman, "From Parrots to Von Neumanns" |
| **Chain-of-thought / latent space** | The reasoning trace itself | Continued generation, self-correction | A verifier model, or the model's own consistency check | Gemini 3 Deep Think, Claude Opus 4.5 |
| **Application layer (harness)** | The *calls* to a frozen commercial model | Re-prompting, re-scoring, retry policy | Whatever the harness can check | Poetiq: 31% → 54% on ARC-AGI-2 |

**The load-bearing observation**: the two-phase structure is identical everywhere — an **exploration phase** generating candidates and a **verification phase** producing a feedback signal — repeated per task until the candidate satisfies all training pairs. Evolutionary program synthesis and gradient descent differ in whether the step is discrete or continuous, and in nothing else that the leaderboard can see.

---

## Why this is not just "search with extra steps"

A search enumerates a space and tests members. A refinement loop **carries state**: candidate `n+1` is a function of candidate `n` and of the feedback on candidate `n`. The distinction is measurable in the wiki's own terms:

| | Blind search | Refinement loop |
|---|---|---|
| Sample cost to reach a solution | Exponential in program length | Reported to beat brute force at equal budget (2025), where 2024's LLM-guided search did **not** ([[wiki/entities/arc-agi.md]]) |
| What the feedback buys | Accept/reject, one bit | A *direction* — which edit to make next |
| Requires | A generator and a tester | A generator, a tester, **and a metric on the candidate space** |

That third requirement is the substantive one and it is why the mechanism is not free: gradient descent has a metric by construction, symbolic program space does not, and the 2025 evolutionary systems buy one by having an LLM propose edits *conditioned on the failure*, i.e. by borrowing the metric from the language model's prior over program edits.

**This is the 2024 open bet, resolved sideways.** The ARC Prize 2024 report named "specialist deep models guiding the *branching decisions* of a discrete search, AlphaProof-style" as the untried idea it expected to work. Nobody built that. What worked instead was the LLM guiding *edits to a complete candidate* rather than choices at a branch — refinement rather than steering, which needs no search tree and no per-node value estimate.

---

## Zero-pretraining refinement: the result that should not work

The most surprising entries in the 2025 record, and the ones with the most consequence for the wiki's gap table.

| System | Parameters | Pretraining | Data | Search | ARC-AGI-1 | ARC-AGI-2 |
|---|---|---|---|---|---|---|
| **CompressARC** (Liao & Gu, Paper Award 3rd) | **76K** | **None** — randomly initialised | **None** — one model per puzzle | **None** — gradient descent only | 20% (reported 20–34%) | 4% |
| **TRM** (Jolicoeur-Martineau, Paper Award 1st) | **7M** | — | — | Recursive deep supervision | 45% | 8% |
| HRM (predecessor of TRM) | ~27M | — | — | Hierarchical recursion | — | — |

**CompressARC's mechanism is [[wiki/concepts/prediction-compression-equivalence.md]] used as a solver rather than as an analysis.** It minimizes the description length of a *single task* at test time, via a VAE loss with decoder regularization that the author derives as a substitute for combinatorial search. One puzzle, ~20 minutes, one consumer GPU, 76K parameters, no external data of any kind.

**TRM's mechanism is recursion depth substituting for parameter count.** Separate answer state `y` and latent state `z`; up to `N_sup = 16` improvement steps; each step recursively updates `z` given `(x, y, z)` `n` times, then updates `y` from `(y, z)`. The claim the authors make and the report endorses: the recursion is what allows a tiny network to correct its own previous errors, and small size is what *prevents overfitting* to the handful of demonstration pairs.

**What these do to the wiki's gap G35** ("no model pays for its own parameters"): they are the first entries in the wiki where the parameter charge is close to free and the score is not zero. A two-part code that counts 76K parameters into the compressed output is a rounding error next to a 70B model's 14008% adjusted rate. The catch is that the *training procedure* is what carries the information — the architecture, the loss, and the 20 minutes of gradient descent per puzzle — which is precisely the prequential accounting G35 names as the unevaluated alternative. Here it is, evaluated, on a benchmark, and it works at 20%.

**`(brainstorm)` The uncomfortable corollary.** If 76K randomly-initialised parameters plus a description-length objective reach 20% on ARC-AGI-1, and a 50,000× pretraining scale-up reached ~0%, then the pretraining corpus was never the vehicle for the relevant competence on this benchmark — the *per-task optimization* was, in both regimes. TTT's vast latent library ([[wiki/concepts/test-time-training.md]]'s memorization/recombination spectrum) may be buying a better *initialisation* for the same loop rather than supplying building blocks, and the two hypotheses are separable by an experiment nobody has run: TTT from a random init versus from a pretrained init, at matched test-time compute, on matched tasks.

---

## The harness result, and why it is an architecture claim

A **model refinement harness** is a refinement loop implemented at the *application layer*, outside the model, over an unchanged frozen commercial system. ARC Prize created a leaderboard category for it in late 2025 and verified one:

| System | Score | Cost/task |
|---|---|---|
| Gemini 3 Pro, baseline | 31% | $0.81 |
| Gemini 3 Pro + Poetiq harness | **54%** | **$31** |
| Claude Opus 4.5 + same harness | ~54% | ~$60 |

**+23 points from code that does not touch the model.** That is the largest single intervention in the wiki's ARC-AGI-2 record, and it costs 38× in inference — a clean point on the score-versus-spend curve that [[wiki/empirical-tensions.md]] T204 says nobody has drawn.

Two structural facts the report attaches:
- The harnesses observed are **domain-specific**. General-purpose ones (GEPA, DSPy) exist as tooling but require "a verifier or environment capable of producing a feedback signal" — the same precondition as everything on this page.
- The report expects harnesses to be **absorbed behind the API**, i.e. the boundary between "the model" and "the loop around the model" is a deployment artefact, not a capability boundary. Any benchmark number that does not state which side of that line it was measured on is ambiguous by construction — which is one reading of [[wiki/empirical-tensions.md]] T206.

---

## What it requires, and therefore what it cannot do

The 2025 report's two conditions for a task domain to be reliably automatable *with no new science*:

1. **Sufficient task knowledge coverage exists in the pretraining corpus.**
2. **The task provides a verifiable feedback signal.**

Condition 2 is this page. Condition 1 is the boundary: a refinement loop cannot manufacture the knowledge it refines over, which is why the report describes current reasoning performance as "fundamentally constrained to knowledge coverage" and human reasoning as not similarly bound. The named open problem — "methods to separate knowledge and reasoning" ([[wiki/concepts/controller-knowledge-vs-process.md]]) — is the statement that nobody can currently run the loop in a domain the base model does not already cover.

Evidence cited across three domains in one year, all with both conditions met: ARC-AGI-2 (24%), IMO Gold 2025, ICPC 100%. And one beyond benchmarks: a generator–verifier refinement loop producing novel results in quantum physics (Hsu, cited) `(tentative)` — the first claim in the wiki of a refinement loop generating knowledge rather than recovering it.

---

## Open problems

- **Nothing consolidates.** The loop runs per task and its product is discarded — G14 in the same form [[wiki/concepts/test-time-training.md]] has it. **One 2025 exception, and it is the most important system on this page for that reason**: SOAR (Pourcel, Colas & Oudeyer, Paper Award 2nd) **fine-tunes the LLM on its own search traces**, improving open-source ARC-AGI-1 performance by up to 52% with no human-engineered DSL and no solution dataset. That is the instance level writing back to the meta level, closing the loop the rest of the table leaves open — and it is the wiki's first measured consolidation channel of that shape.
- **No stopping criterion and no allocation policy.** Gemini 3 Pro used **96** reasoning tokens on ARC-AGI-1 task `4cd1b7b2`; Gemini 3 Deep Think used **138,000** on the same task. Higher reasoning modes correlate with longer traces "even when not strictly necessary for task completion". So the loop length is set by a mode switch rather than by the problem — the adaptive-allocation problem [[wiki/concepts/external-verification.md]] names, now with a 1,400× spread measured on a single item.
- **The feedback signal is the demonstration pairs, which are also the training data.** Every substrate above verifies against the same ~3 pairs it fits. There is no held-out check inside the loop, so "refined until it satisfies all training pairs" is a memorization criterion whenever the hypothesis class is expressive enough — and the small-network results are best read as the field discovering that the cheapest defence is a capacity bound.
- **The metric on candidate space is unaccounted-for prior.** Gradient descent's metric is the parameterization; the evolutionary systems' metric is an LLM's edit prior over programs, trained on human code. Neither is priced in any efficiency figure, which is the same complaint [[wiki/concepts/skill-acquisition-efficiency.md]] makes about the augmentation group in TTT.
- **Is refinement a mechanism or a description?** Every iterative optimizer fits the template, including plain SGD, which makes the category's predictive content thin. The report's own operational content is narrower and worth holding to: *the loop runs per task, at test time, on a signal computed from that task alone*. Anything true of ordinary training is not evidence for this page.

---

## Connections

- **[[wiki/entities/arc-agi-2.md]]** — the benchmark where the mechanism was isolated: every 2025 top score is a refinement loop in some substrate, and the harness result (31% → 54% on a frozen model) is the cleanest evidence that the loop, not the model, is doing the work.
- **[[wiki/concepts/test-time-training.md]]** — the weight-space instance, and the first one discovered; this page's claim is that TTT, evolutionary program synthesis and chain-of-thought self-correction are the same loop with different mutation operators, which makes "gradient or symbol?" the wrong question about it.
- **[[wiki/concepts/program-induction.md]]** — the symbolic substrate, with the 2025 change being that programs are *edited under feedback* rather than enumerated, and that the LLM supplies the edit metric that discrete program space lacks.
- **[[wiki/concepts/external-verification.md]]** — supplies the loop's second half: a refinement loop is exactly a proposer plus an acceptance test that returns more than one bit, and the report's "verifiable feedback signal" precondition is that page's ladder stated as an automatability criterion.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — CompressARC turns the equivalence into a solver: minimize the description length of one ARC task at test time with 76K randomly-initialised parameters and no search, reaching 20% on ARC-AGI-1.
- **[[wiki/concepts/amortized-inference.md]]** — the opposite trade, and SOAR is the bridge: amortisation compiles search into a forward pass, refinement spends inference to buy a better answer, and fine-tuning the model on its own search traces converts the second into the first.
- **[[wiki/concepts/meta-learning.md]]** — what the loop is missing: an outer loop that shapes the inner one. Every system here hand-designs its mutation operator and stopping rule, which is meta-learning's job left to the developer.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the loop is a fast-level learner with no slow-level write-back in every instance but SOAR, which is why G14 recurs verbatim across four substrates.
- **[[wiki/concepts/controller-knowledge-vs-process.md]]** — the loop is process; the report's finding that its reach is bounded by pretraining-corpus knowledge coverage is the sharpest evidence in the wiki that the two are not separated in any current system.
- **[[wiki/entities/arc-agi.md]]** — the benchmark whose 2024 report predicted learned *branch* guidance and got learned *edit* guidance instead, and where the pre-refinement baseline (blind DSL search ≈ LLM-guided search ≈ 40%) is the control this mechanism improves on.
- **[[wiki/entities/transformer.md]]** — the substrate for the LLM-driven variants, and the object being refined in the harness case, where it is frozen and the loop lives entirely outside it.
