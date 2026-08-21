# ARC-AGI-3 — the benchmark stops handing over the task

**An interactive turn-based benchmark of hand-built 64×64 grid environments in which the agent is told nothing — not the action semantics, not the mechanics, not the win condition — and is scored not on whether it wins but on how many *actions* it spent relative to a human meeting the same environment for the first time.**

> **Provenance.** Six sources, one pass. ARC Prize Foundation 2026, *ARC-AGI-3: A New Challenge for Frontier Agentic Intelligence*, April 20 2026 (`raw/arcprize-2026-arc-agi-3-paper.md`) is the primary source for design, scoring, validation and human calibration. Supporting: the ARC Prize site's ARC-AGI-3 page (`raw/arcprize-nd-arc-agi-3-overview.md`, undated) and the Kaggle competition's overview, data, rules and leaderboard pages (`raw/arcprize-2026-kaggle-competition-*.md`, `raw/arcprize-2026-arc-agi-3-{data,leaderboard}.md`) — all site/platform material, `(tentative)` where they are the only source.

This is the wiki's first benchmark where **hardness sources 2 and 4** of [[wiki/concepts/latent-graph-discovery.md]] are switched on deliberately rather than designed out, and the first where the agent's own actions are the measured resource. [[wiki/entities/arc-agi.md]] and [[wiki/entities/arc-agi-2.md]] hand over a task and score the answer; this hands over a control interface and scores the trajectory.

---

## What changed from the static format

| | ARC-AGI-1 / -2 | ARC-AGI-3 |
|---|---|---|
| Presentation | ~3 demonstration pairs, static | Turn-based interactive environment, ≥6 levels, no instructions |
| Grid | 30×30, 10 colours | **64×64, 16 colours**; a turn may return a *frame sequence* (non-interactive animation) |
| What is latent | The transformation rule | The action semantics, the mechanics, **and the win condition** |
| Action set | None (emit an output grid) | 5 key actions + Undo + one coordinate-select action (`ACTION6(x,y)`); **which subset is live, and what each does, varies per environment and is never stated** |
| Feedback | Correct/incorrect, 2 attempts | Level state only: `NOT_FINISHED` / `WIN` / `GAME_OVER` |
| Scoring | Exact match, binary | **RHAE** — relative human action efficiency, continuous |
| Human ceiling | Certified solvability (≥2 of 2–10 testers) | Certified solvability (**≥2 of 10 testers**) |
| Public : private | ~10 : 1 | **25 : 110 — inverted on purpose** |

**Why turn-based.** The environment never changes asynchronously from the agent's actions. The stated reason is that the intended difficulty is reasoning, not perception or reflex — and the same choice removes real-time compute pressure, which has a price (see T209 below).

---

## The four functional components it claims to isolate

The paper's own decomposition of "agentic intelligence", and it is the most useful list on the page because three of the four map onto standing gaps.

| Component | Demand | Wiki hook |
|---|---|---|
| **Exploration** | Information must be *taken*, not received; the action budget spent learning the mechanics is charged to the score | **G61** — every exploration schedule in the wiki is external to the selector; here the schedule *is* the thing being scored |
| **Modeling** | Turn observations into a predictor of future states | inherited from versions 1–2; [[wiki/concepts/learned-world-models.md]] |
| **Goal-Setting** | "The agent is **never told the objective nor provided instructions**" — it must identify desirable future states unprompted | **G72** (new, below). No architecture in the wiki does this |
| **Planning and Execution** | Map a path to the inferred goal, and course-correct on feedback | **G15**/**G24** (when to plan, how deep), **G33** (subgoals) |

The paper's framing of the whole: the benchmark demands autonomous navigation of "unknown unknowns", which is [[wiki/concepts/skill-acquisition-efficiency.md]]'s **extreme generalization** rung stated as an interface rather than as a task list.

---

## RHAE — the scoring function

The wiki's first benchmark metric in which the *experience* term of the intelligence formula is the denominator rather than a reported side column.

For level `l` of environment `e`, with `a` = agent actions and `h` = the **upper-median best first-run human** action count:

```
S_l,e = min(h_l,e / a_l,e , 1.15)²                       level efficiency score
E_e   = min( Σ_{l≤k} l / Σ_{l≤n} l ,  Σ_l l·S_l,e / Σ_l l )   environment score
T     = (1/|D|) Σ_{e∈D} E_e                              benchmark score
```

with `k` = levels completed (levels are sequential, `S = 0` for uncompleted), `n` = levels in the environment, and the first term of `E_e` the **per-environment cap**: the maximum environment score is the weighted fraction of levels completed (5 of 5 → 100%, 4 of 5 → 10/15 ≈ 66.7%, 3 of 5 → 6/15 = 40%). The cap binds only when some level scored above 1.0.

Five design decisions, each with a stated reason worth reusing:

| Decision | Reason given |
|---|---|
| **Normalize to a human, not to an optimum** | Makes the score a direct human-AI comparison; 100% *means* "matched a first-time human", not "solved it" |
| **Upper-median best**, not best or mean | Outlier-resistant while still representing strong human play (e.g. 3rd of 4–5 completions) |
| **Per level, then aggregate** | Long levels otherwise dominate (`vc33` level 6 needs 10× level 1's actions), and a single environment number cannot say *where* the agent broke |
| **Square the ratio** | Linear credit is too generous — 2× the human action count would score 50%. Squared, 10× human → 1% |
| **Linear level weights** `w_l = l` | Early levels are tutorials and are sometimes reachable by luck, so they must contribute least |

Inspired by robotics' **Success weighted by Path Length (SPL)**. Reported against cost on the X-axis, as with versions 1–2. Evaluation runs impose an action budget of **5× the human median per level** (cost control; the power-law decay makes the truncation nearly free).

**(brainstorm) What the metric is really doing.** `min(h/a, ·)²` is a *ratio of experience to a human's experience on the same task*, which is `E` in [[wiki/concepts/skill-acquisition-efficiency.md]]'s formula with the human as the normalizing constant. `GD` and `P` are handled not by measurement but by construction — priors equalized by the Core-Knowledge-only rule, difficulty equalized by the "≥2 of 10 humans" gate. So the uncomputable formula is being approximated by *holding two of its three terms fixed by authoring and measuring the third*. That is the cheapest attack on **G31** the wiki has seen, and it works only because the benchmark controls the task-generation process.

---

## Dataset composition

| Set | Environments | Role |
|---|---|---|
| Public demo | **25** | Format demonstration and human entry point. Deliberately easier, deliberately **not representative** of the private mechanics |
| Semi-private | **55** | Frontier models behind an external API — leakage assumed possible |
| Fully private | **55** | Official competition; released to a very limited set of partners |

The inversion is a direct answer to [[wiki/empirical-tensions.md]] T207. Version 2 wanted subsets drawn from similar distributions (so scores transfer) while also wanting distributional novelty (so training on the public set does not leak); the two are incompatible. **Version 3 picks the second horn and abandons the first**: the public set is a demonstration interface, is materially easier, is *not* a sample from the private distribution, and public-set scores **will never be reported on the official leaderboard**. Cross-subset comparability is given up on purpose.

`(tentative)` The Kaggle data page describes the competition's 110 private games as split 50/50 into public-leaderboard and private-leaderboard halves, which is a different partition from the paper's semi-private/fully-private split. The two are not reconciled by either source.

---

## Environment design constraints

**Core Knowledge priors only** ([[wiki/concepts/core-knowledge.md]]) — and the declared list has *changed* from ARC-AGI-1's:

| ARC-AGI-1 declared | ARC-AGI-3 declared |
|---|---|
| Objectness | Objectness |
| Goal-directedness | **Agentness** (objects that act with intent) |
| **Number and counting** | — *dropped* |
| Geometry and topology | Geometry and topology |
| — | **Basic physics** (gravity, momentum, bouncing) |

Explicitly banned: numbers, letters, recognizable clip-art, and cultural conventions — the paper names "green meaning go" as a specific exclusion. **(brainstorm)** Dropping number while adding physics is not a neutral edit: it removes the one core system the wiki calls a `g`-side installed code with a measurable signature limit, and adds the one whose machine status is contested (V-JEPA reaching intuitive physics with no installed prior at all, T161). A solver that succeeds here therefore cannot be credited with, or debited for, a number system.

Other authored constraints:

- **Novelty, with an operational test.** Two environments are *insufficiently distinct* if a single program can solve both while being **≥50% shorter than the concatenation of two independent solution programs**. This is a joint-vs-separate description-length test used as an authoring gate — a computable, if approximate, proxy for the mutual algorithmic information between two tasks ([[wiki/concepts/prediction-compression-equivalence.md]]).
- **Difficulty through composition**, not obscurity or scale: later levels require integrating concepts acquired in earlier ones.
- **Tutorial first level**, intentionally easy — random agents stumbling through it is acceptable by design.
- **Multiple mechanics per environment**; a single mechanic scaled up is called an anti-pattern.
- **≥6 levels per environment.** `(tentative)` The scoring section works its examples at `n = 5`; the two statements are not reconciled.
- **Human solvable within ~20 minutes**, most in a few minutes.
- Four-character environment IDs, with the descriptive names withheld so the name leaks no semantics.

Built in a custom Python engine at a **1,000 frames/second** floor; Unity was tried and rejected as too slow to iterate on.

---

## The validation pipeline — and why it matters to G17

This is the part of the paper that goes furthest beyond benchmark administration, because the authors build the ground-truth object that [[wiki/concepts/latent-graph-discovery.md]] says nobody has.

**Deterministic qualification.** Random-policy sweeps at 50,000 steps (no level beatable by accident), then 1,000,000 steps (non-tutorial levels must remain unbeaten under uninformed random play), then a third 1,000,000-step sweep across all levels doubling as a fuzzing harness for crashes, malformed transitions and inconsistent hidden state. Developer-recorded win and loss traces are replayed to confirm the engine serializes and re-executes deterministically.

**Explicit state-graph construction.** Each level is expanded into a **directed graph over reachable states**: nodes are hash-identified environment states (so trajectories reaching the same state *merge*), edges are valid actions, terminal states are marked, invalid actions are recorded as self-loops. Expansion runs to a step/time/node/edge budget, tracking merge density, maximum depth, cycles and whether the reachable graph was fully enumerated.

Two things fall out:

- **An exact win probability under a random policy.** `ls20` level 1: `P_win = 1/355` exactly, with three repeating states visible in the graph as the artefact of a three-lives mechanic. Where the graph cannot be fully enumerated, the system still returns *mathematically grounded bounds* on `P_win`.
- **An acceptance threshold**: a random policy must not solve a level more often than **1 in 10,000**.

**Why this is the wiki's best answer yet to G17.** Every earlier instrument in that row asks the *evaluator* to certify that a learner recovered structure. Here the *benchmark author* holds the structure — the full transition graph, its cycles, its depth, its chance-solvability — for every level, and can therefore say exactly how much of any score is luck. That is a certificate no i.i.d. or o.o.d. protocol in the wiki can produce. It does not close G17 (holding the graph does not tell you whether the agent recovered it), but it removes an entire class of false positive: "solved by accident" is now bounded rather than argued about. **(brainstorm)** The unexploited follow-on is obvious and cheap: the authors could publish, per level, the *shortest path length* and the agent's realized trajectory, which would turn RHAE from one scalar into a comparison between the agent's path and the graph geodesic — i.e. a direct measurement of how much of the true graph the agent had at each moment, which is exactly [[wiki/concepts/latent-graph-discovery.md]]'s nodes-visited-versus-edges-taken axis.

---

## Human calibration

| Quantity | Value |
|---|---|
| Participants / candidate environments / attempts | **486 / 414 / 2,893** |
| Total recorded play | 427.9 hours |
| Testers per environment | Exactly 10 |
| Inclusion bar | **≥2 of 10 independently complete every level on first contact**; many environments solved by ≥6 |
| Median attempt | 7.4 min (successful 8.1, unsuccessful 5.9) |
| Session protocol | San Francisco testing centre, Mon/Wed/Fri, 90-minute sessions, ~9 environments each, 20-min soft and 30-min hard per-environment limits |
| Attempt definition | >30 actions and <30 minutes; one attempt per environment; level resets allowed, no revisiting completed levels |
| Pay | $115–140 per session + $5 per environment solved |
| Efficiency distribution | n = 1,614 level completions across 340 sessions, plotted against the median human |

Three reference points are tracked per environment: **optimal playthrough** (lower bound once mechanics are known), **best first-run playthrough** (per-level best across participants), and **human baseline** (upper-median best first-run, the scoring denominator). The gap between the first two is *the cost of exploration itself* — the wiki's only direct measurement of what discovering an unknown environment's rules costs in the same units as executing them.

Procedure changes from version 2 worth copying: continuous small-cohort testing three times a week instead of batched sessions months apart, per-level completion rates used to locate drop-off points, and **full video replay review** of stuck participants to diagnose whether a difficulty spike is unintended. Low-effort sessions (rapid cycling to farm the per-environment bonus) were excluded.

**The caveat is the same one versions 1 and 2 carry, and it is larger here.** "100% human-solvable" means *at least 2 of 10 testers finished*. A 20% pass rate certifies solvability and says nothing about difficulty calibration, so the phrase "easy for humans" is doing more work than the data supports.

---

## Score record

**Official leaderboard, semi-private set, at release (March 2026)** — no harness, no tools, one fixed system prompt for every model:

| Provider | Model | Score |
|---|---|---|
| Anthropic | Opus 4.6 (Max) | **0.50%** |
| Google | Gemini 3.1 Pro Preview | 0.40% |
| OpenAI | GPT 5.4 (High) | 0.20% |
| xAI | Grok-4.20 (Beta 0309 Reasoning) | 0.10% |

The entire system prompt: *"You are playing a game. Your goal is to win. Reply with the exact action you want to take. The final action in your reply will be executed next turn. Your entire reply will be carried to the next turn."*

**Preview agent competition** (30 days, July–August 2025; 3 public environments, 3 held-out, scored only on the held-out set):

| Entry | Score | Mechanism |
|---|---|---|
| StochasticGoose (Tufa Labs) | **12.58%**, 18 levels | 4-layer CNN over the 64×64 frame + reinforcement learning, trained to predict **which actions change the frame** |
| Blind Squirrel | 6.71% | A directed state graph built from observed frames |

Both are informed search — "exploring as much of the action space as possible in the hope of encountering a winning combination by chance". Note the ordering this produces: **two small purpose-built searchers beat every frontier LRM by more than an order of magnitude**, on a preview set and a preview metric that are not directly comparable to the release numbers, but not by a margin that comparability could explain. On this benchmark the frontier's advantage in knowledge buys almost nothing.

**Kaggle public leaderboard, July 2026** `(tentative — mid-competition, ~50% of test data, units not stated on the page but almost certainly percent)`: top team 1.40, 49th place 0.88; 8,838 entrants, 1,556 teams, 12,762 submissions. The open community, with a full development cycle against the format, sits within a factor of ~3 of the best zero-preparation frontier model and four orders of magnitude below the human baseline the metric is normalized to.

---

## The harness question, and the bimodality result

The paper's sharpest empirical finding, and it lands directly on a claim the wiki carries from version 2.

The foundation hired researchers to build general harnesses against three public environments (`ls20`, `ft09`, `vc33`), then tested those harnesses on the *full* public set, which the researchers had not seen. Result, same frontier model throughout:

| Environment | Opus 4.6, no harness | Opus 4.6, Duke harness |
|---|---|---|
| variant of `TR87` (seen class) | **0.0%** | **97.1%** |
| `BP35` (unseen) | 0.0% | **0.0%** |

Two conclusions the authors draw, both load-bearing:

1. **Perception and API format are not the bottleneck.** With the right hand-crafted strategy a frontier model can solve these environments through the existing interface. Whatever is missing is not "it cannot see the grid".
2. **Harness performance does not transfer.** A configuration that takes an environment class from 0% to 97% moves an unseen environment not at all.

So the official leaderboard **uses no harness and gives no tools**, on the position that "future AGI systems will not need task-specific external handholding to approach new tasks". Two overfitting modes are named as the things being defended against: *task-specific* (built with knowledge of the public environments — the foundation open-sourced a replay-driven harness that scores **100%** on the public set, precisely to demonstrate the number is meaningless) and *domain-specific* (built to play ARC-AGI-3 in general, by synthetic lookalike environments or ARC-specific harness strategies).

A separate **community leaderboard** exists for harness work: public, self-reported, unverified by default, with the explicit caution not to read it as AGI progress. The authors' prediction is that good harness ideas migrate — third-party harness → first-party harness → model — citing chain-of-thought's path from a DeepMind prompt wrapper to o1.

**This contradicts how the wiki has been reading version 2's harness result** (Gemini 3 Pro 31% → 54% at 38× cost, taken as the cleanest evidence that the rejector rather than the proposer is binding, G68). See [[wiki/empirical-tensions.md]] T208.

---

## Context management is the named engineering bottleneck

64×64 grids at one frame per turn exhaust a model's context budget quickly, and a naive rolling window is the failure mode. Two harnesses solved it differently:

| System | Mechanism |
|---|---|
| **Duke University harness** | The model **executes arbitrary Python over its own action history** to selectively retrieve and transform past states |
| **Arcgentica** (Symbolica AI) | Orchestrator–subagent split: the orchestrator never touches the environment, delegating to subagents that return **compressed textual summaries**, so context growth is bounded and the high-level plan survives |

Both solved all three public environments; the Duke harness did so with action counts comparable to humans. **Wiki reading:** these are G49's missing primitive — a store that schedules its own relevance-addressed reads — appearing as an engineering necessity rather than as a design proposal, and the second is the same operation implemented as a hierarchy of agents instead of as a memory operation. That the benchmark's first-order difficulty for LRMs is *what to keep* rather than *what to do* is itself a finding about where the architecture is thin.

---

## The competition

| | ARC Prize 2026, ARC-AGI-3 track |
|---|---|
| Prize pool | $850,000 of a $2M total across two tracks (ARC-AGI-2's final year runs in parallel) |
| Structure | $75,000 final leaderboard + $75,000 across two milestones + **$700,000 bonus, unlocked only by a 100% score** |
| Compute | Kaggle notebooks, ≤9 h CPU or GPU, **internet disabled**, RTX 6000 (`g4-standard-48`) added to the pool |
| Submission | Automatically generated — an agent that acts on *any* game produces a submission for all games |
| Open-source condition | Prize-eligible solutions must be open **system, model, and weights** per the Open Source Initiative's Open Source AI definition, licensed CC-BY 4.0 |

The last row is structural rather than administrative: it means the competition track **cannot be won by a closed frontier API**, so the leaderboard and the official model leaderboard measure disjoint populations by construction. The 100%-only bonus threshold is also new in kind — versions 1–2 set the grand prize at 85%, here it is a demand to *match the human baseline exactly*, which given RHAE's squaring is a far harder target than "solve everything".

---

## Why the LRM recipe does not apply here

The paper's own account of when a Large Reasoning Model automates a domain: (i) the base model has sufficient **knowledge coverage** of the domain, and (ii) the domain supplies an **exact correctness feedback measure** — a *verifiable domain*. ARC-AGI-1 and -2 satisfy (ii) by construction, which is what made the generate-verify-train-on-traces loop viable against them and is the mechanism behind the knowledge-overfitting claim on [[wiki/entities/arc-agi-2.md]].

ARC-AGI-3 removes both:

- **(i) is removed by novelty** — environments are authored to resemble no existing video game and no other environment in the set, with the ≥50%-shorter-program test as the gate.
- **(ii) is removed by sparsity** — the only correctness signal is terminal (`WIN` / `GAME_OVER`) and arrives after an unknown number of actions. There is no per-action verifier, so there is nothing to check a candidate against mid-trajectory.

The wiki's consequence: the [[wiki/concepts/refinement-loop.md]] mechanism that produced every 2025 ARC-AGI-2 score requires a feedback signal computed from the task's own data, and this benchmark deliberately does not provide one. Whatever solves ARC-AGI-3 must either construct its own intermediate feedback signal — which is [[wiki/concepts/expected-free-energy.md]]'s epistemic term, with the *preference* term still missing — or work without one.

The paper's framing of why this matters beyond the benchmark: *human reasoning capability is not bound by domain knowledge, and LRM reasoning is*. That is [[wiki/concepts/controller-knowledge-vs-process.md]]'s distinction stated as the diagnosis for a sub-1% score.

---

## Limitations

- **"100% human-solvable" is a 2-of-10 bar.** Union-over-testers again, at a stricter format and a looser threshold than version 2's.
- **Compute is free by construction.** Only environment-changing actions are counted; "internal operations that do not alter the environment, such as tool calls, reasoning steps, or retries within the model itself, are **not counted**". A system with unbounded per-action deliberation is, by RHAE, maximally efficient. See T209.
- **The metric is scored against humans, so it inherits human variance.** The denominator is the upper-median *best* first-run count over the subset of ≤10 testers who finished a level — on levels where 2 finished, that is essentially one person's trajectory.
- **`n = 5` in the scoring examples against "≥6 levels" in the design constraints**, and the Kaggle 110-game split against the paper's 55/55 split. Neither is reconciled by the sources.
- **The four functional components are authored intuitions, not measured factors** — the same complaint version 2's four difficulty axes attract. RHAE returns a per-level breakdown, which localizes *where* an agent broke but not *which of exploration, modeling, goal-setting or planning* broke.
- **No AI system has scored high enough for the metric's discriminating range to be tested.** Every property claimed for the squaring, the cap and the weights concerns behaviour near the human baseline; all reported scores are below 1.5%.
- **`(brainstorm)` The exploration/execution split is measured for humans and not for machines.** The authors already compute optimal-vs-best-first-run per environment, which is the exploration cost in actions. Applying the same subtraction to an agent's trajectory would decompose its RHAE score into "spent learning" and "spent executing badly" — two failures with completely different fixes, currently summed into one number.

---

## Connections

- **[[wiki/entities/arc-agi.md]]** — the predecessor, and the source of this benchmark's own proposal: version 1's limitations list names a better format as *interactive* — the solver requests inputs, proposes, receives feedback, and is scored on the amount of interaction needed — which is RHAE delivered seven years later with actions as the interaction unit.
- **[[wiki/entities/arc-agi-2.md]]** — the immediate predecessor, whose unresolved calibration-versus-contamination conflict (T207) this benchmark settles by choosing a side: the public set is made deliberately non-representative and public scores are never reported, abandoning cross-subset comparability to buy distributional novelty.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the first benchmark whose *scoring function* is the efficiency ratio rather than a reported side column: `min(h/a, 1.15)²` puts a human's experience in the numerator and the agent's in the denominator, with priors and difficulty held fixed by authoring instead of measured.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the first benchmark to switch hardness sources 2 and 4 on deliberately: the action alphabet's semantics are latent per environment, and structure must be inferred *while* navigating, with the authors' own hash-merged state graph as the ground truth the wiki has always lacked.
- **[[wiki/concepts/core-knowledge.md]]** — the declared prior set changes here (number and counting dropped, basic physics added, goal-directedness sharpened into agentness), which changes what a score can be credited to; also the strictest cultural-symbol exclusion in the wiki, naming "green means go" as a specific ban.
- **[[wiki/concepts/expected-free-energy.md]]** — the closest mechanism the wiki holds to what this benchmark demands, and the diagnosis of what is missing: the epistemic term supplies exploration under uncertainty, but the preference distribution `C` is supplied by the designer, which is exactly the input this benchmark withholds (G72).
- **[[wiki/concepts/external-verification.md]]** — the benchmark removes the resource that page prices: feedback is terminal-only (`WIN`/`GAME_OVER`) after an unknown number of actions, so there is no per-candidate acceptance test, and the two conditions the ARC reports give for LRM automation (knowledge coverage, a verifiable signal) are both designed out.
- **[[wiki/concepts/refinement-loop.md]]** — the mechanism behind every 2025 ARC-AGI-2 score, shown here to be inapplicable as-is: candidate `n+1` is a function of the feedback on candidate `n`, and this environment computes no feedback until the level ends.
- **[[wiki/concepts/memory-read-and-erase.md]]** — G49's missing primitive appearing as an engineering necessity: 64×64 frames exhaust context, and both successful harnesses solve it by relevance-addressed reads over the agent's own history (arbitrary Python over the action log; orchestrator–subagent summary compression).
- **[[wiki/concepts/shortcut-learning.md]]** — a benchmark that names its own two shortcut channels and builds against both: task-specific overfitting (demonstrated by open-sourcing a replay harness that scores 100% on the public set) and domain-specific overfitting (synthetic lookalike environments, ARC-specific harness strategies), with the countermeasure being a leaderboard policy rather than a data property.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — supplies an authoring gate rather than a solver: two environments are too similar if one program solves both while being ≥50% shorter than the two independent solutions concatenated, which is joint-versus-separate description length used as a computable novelty test.
- **[[wiki/concepts/controller-knowledge-vs-process.md]]** — the paper's diagnosis of the sub-1% frontier score: LRM reasoning is bound to domain knowledge and human reasoning is not, so a domain with no knowledge to cover leaves the process with nothing to stand on.
- **[[wiki/concepts/problem-framing.md]]** — the critique this benchmark half-answers: version 1 was faulted for supplying an identical problem representation to every task and for letting candidates be tested for free, and this format withholds the objective and the action semantics while still supplying the state space, the action-alphabet size and the turn structure (Pfister & Jud 2025).
