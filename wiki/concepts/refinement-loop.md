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

## The biological version keeps the verifier disconnectable

> Tripathi et al. 2025, Biol Psychiatry Cogn Neurosci Neuroimaging 10(4):359–368 (`raw/tripathi-2025-dmn-connectivity-biomarker.md`) — a narrative review, direction-of-effect only. See [[wiki/entities/default-mode-network.md]].

The two-phase structure above — an exploration phase generating candidates, a verification phase scoring them — appears in the brain not as two stages of one program but as **two wirings of the same two systems, with the coupling sign as the variable**:

| Phase | Default-mode ↔ frontoparietal coupling |
|---|---|
| Creative **idea generation** (bottom-up) | Negative (anticorrelated) |
| Creative **idea evaluation** (filtering candidates) | Correlation *increases* — the two cooperate |
| Sustained attention, between-subject | Negative; stronger negativity → less variable reaction time |
| Goal-directed self-generated thought, semantic retrieval, scene construction | Positive; the control network tracks trial-to-trial difficulty of the *internal* operation |

**(brainstorm) What this costs the systems on this page.** Every substrate in the table above holds the generator and the feedback signal permanently wired: the loss, the executor, the verifier model or the harness is attached at all times, and each candidate is born under evaluation. The biological arrangement decouples them for the generation phase and couples them for the filtering phase. If that is functional rather than incidental, the prediction is specific and testable in an ordinary ablation: an always-coupled critic costs **candidate diversity**, not filtering quality — a proposer that is scored while proposing regresses to whatever the scorer already ranks highly, which is the failure mode evolutionary program synthesis spends population size to avoid. It also adds a scheduling variable no loop here has: *when* the verifier is connected, as distinct from how strong its signal is.

## Open problems

- **Nothing consolidates.** The loop runs per task and its product is discarded — G14 in the same form [[wiki/concepts/test-time-training.md]] has it. **One 2025 exception, and it is the most important system on this page for that reason**: SOAR (Pourcel, Colas & Oudeyer, Paper Award 2nd) **fine-tunes the LLM on its own search traces**, improving open-source ARC-AGI-1 performance by up to 52% with no human-engineered DSL and no solution dataset. That is the instance level writing back to the meta level, closing the loop the rest of the table leaves open — and it is the wiki's first measured consolidation channel of that shape.
- **No stopping criterion and no allocation policy.** Gemini 3 Pro used **96** reasoning tokens on ARC-AGI-1 task `4cd1b7b2`; Gemini 3 Deep Think used **138,000** on the same task. Higher reasoning modes correlate with longer traces "even when not strictly necessary for task completion". So the loop length is set by a mode switch rather than by the problem — the adaptive-allocation problem [[wiki/concepts/external-verification.md]] names, now with a 1,400× spread measured on a single item.
- **The feedback signal is the demonstration pairs, which are also the training data.** Every substrate above verifies against the same ~3 pairs it fits. There is no held-out check inside the loop, so "refined until it satisfies all training pairs" is a memorization criterion whenever the hypothesis class is expressive enough — and the small-network results are best read as the field discovering that the cheapest defence is a capacity bound.
- **The metric on candidate space is unaccounted-for prior.** Gradient descent's metric is the parameterization; the evolutionary systems' metric is an LLM's edit prior over programs, trained on human code. Neither is priced in any efficiency figure, which is the same complaint [[wiki/concepts/skill-acquisition-efficiency.md]] makes about the augmentation group in TTT.
- **The loop's two preconditions are properties of the task supply, not of the method.** It needs a candidate that can be *checked before it is committed to* and a retry that costs only compute. ARC supplies both by construction (one correct output per input; demonstration pairs given), and outside that format neither is generic: an irreversible action returns its verdict only after it is too late to iterate (Pfister & Jud 2025, [[wiki/concepts/problem-framing.md]], gap G74). This bounds the mechanism more tightly than the report's own knowledge-coverage condition does, because it cannot be relaxed by better pretraining.
- **Is refinement a mechanism or a description?** Every iterative optimizer fits the template, including plain SGD, which makes the category's predictive content thin. The report's own operational content is narrower and worth holding to: *the loop runs per task, at test time, on a signal computed from that task alone*. Anything true of ordinary training is not evidence for this page.

---

## Connections

- **[[wiki/entities/default-mode-network.md]]** — the loop's two phases measured as two network configurations rather than two stages: default↔frontoparietal coupling is negative while ideas are generated and rises while they are evaluated, so biology treats the proposer–verifier link as a per-phase gain where every substrate in the table above leaves it permanently closed.
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
- **[[wiki/concepts/problem-framing.md]]** — the domain restriction: this loop refines a candidate *inside* a representation it was handed, and its feedback signal exists only where trialling is free, so both halves of the mechanism are inherited from the task format.
- **[[wiki/entities/arc-agi-3.md]]** — the benchmark this mechanism cannot be run against as stated: candidate `n+1` is a function of the feedback on candidate `n`, and an interactive environment returns nothing until a level terminates, so the loop has to manufacture its own intermediate signal before it can turn.
- **[[wiki/entities/poe-arc-solver.md]]** — the same per-task check applied to *re-parameterisations of one candidate* instead of to retries of the generation, so it costs one forward pass per view rather than one generation per iteration; the authors read the need for it as a defect of left-to-right decoding, which makes this loop and augmentation pooling two repairs for one cause.
- **[[wiki/entities/anli.md]]** — the same propose-and-verify structure run one level up, on the *benchmark* rather than on a candidate answer: the mutation operator is a paid human writer conditioned on the model's live output probabilities, the feedback signal is the model's own error, and the loop's two preconditions (a candidate checkable before commitment, a retry costing only effort) are inherited by benchmark authoring exactly as they are by solving — with 3.4 → 6.4 mean tries per success as the measured hardening across three rounds.
- **[[wiki/entities/math-dataset.md]]** — the negative control for the chain-of-thought row of the substrate table: with the verification half removed, conditioning on a self-generated trace *costs* 1.6 points (6.9% → 5.3%, GPT-2 1.5B on MATH) while the same solutions used as training data or as supplied context both help — which localises this page's value in the feedback signal rather than in the extra computation, and puts a per-step-reliability precondition on the loop ([[wiki/empirical-tensions.md]] T217).
- **[[wiki/entities/gsm8k.md]]** — the positive control for the same row: on a distribution of 2–8 elementary steps with arithmetic offloaded to a calculator, removing the self-generated trace costs 4× (20.6% → 5.2%), so the substrate's value is set by per-step reliability rather than by the extra tokens.
- **[[wiki/concepts/certification-instruments.md]]** — the inventory's third conclusion runs this page's loop on benchmark authorship itself — the only answer anyone offers to developer-blindness depleting, with a stopping criterion ("easy for humans, hard for AI becomes impossible") rather than a completion criterion.
- **[[wiki/entities/olymmath.md]]** — the control condition for the row below, and it isolates the variable: the *same* class of sound feedback (a Lean compiler in a sandbox, errors returned) is consumed to convergence over 150 problems by an agent that formalises each statement, because the exit condition is "the compiler accepted it" rather than "the policy decided to stop". **A loop a policy may exit at will is a loop the policy exits immediately**; termination has to belong to the verifier. Same feedback channel, opposite outcome, and the difference is neither the model nor the domain.
- **[[wiki/entities/frontiermath.md]]** — the loop supplied and refused: a Python interpreter wired into the evaluation with stdout, stderr and timeouts fed back and an explicit instruction to experiment before answering, and o1-preview averages **1.29 responses per problem** while Gemini 1.5 Pro typically submits before running anything — so the loop is a property of the policy, not of the harness that offers it.
- **[[wiki/entities/hle.md]]** — the loop applied to benchmark authorship and conceded in public: the preprint calls itself "the final closed-ended academic benchmark", the Nature version demotes that to "an expert-level" one and ships HLE-Rolling, a continuously refreshed fork — the maintenance-schedule answer `F1` forces on anyone who tries to build the last exam.
- **[[wiki/concepts/discrete-infinity.md]]** — the direct negation of this page's premise: the generative operator is conjectured to satisfy *minimal search and no backtracking*, which turns `G74`'s cost-of-wrong-attempts problem into a representation-design question — choose the representation such that greedy composition is correct and the retry cost disappears.
- **[[wiki/concepts/sparse-expert-routing.md]]** — supplies the granularity mismatch this page is positioned to fix: every sparse expert model routes *tokens*, and its measured deficit is exactly on reasoning-heavy downstream tasks, which is what one predicts if the routed unit is not the unit over which the problem decomposes — routing a step of a refinement loop rather than a token is the untried experiment.
- **[[wiki/entities/switch-transformer.md]]** — the sharpest datapoint for the granularity argument above: against FLOP-matched dense baselines a token-routed sparse model gains on SuperGLUE, Winogrande and ANLI, and the *only* benchmarks where it loses are ARC-Easy and ARC-Challenge, the two most explicitly multi-step tasks in its fine-tuning set — which is what one predicts when parameters are allocated per token and the problem decomposes into steps.
- **[[wiki/concepts/adaptive-computation-time.md]]** — makes the step count of a loop a trained per-input variable rather than a fixed budget or a wall-clock cutoff, inside a single differentiable graph instead of around a generate-and-test harness; composing the two — halt the refinement when the halting unit fires, rather than after `k` passes — is unattempted, and the ponder trace would make the loop's per-instance depth a readable number (Graves 2016).
