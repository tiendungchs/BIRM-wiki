# CoreThink Compositional Reasoner — object abstraction + pattern proposal + consensus, in front of a frozen LLM

**A four-stage ARC-AGI-2 pipeline that never trains anything: deterministic connected-component parsing, a frozen LLM detecting which of 22 hand-authored parameterized "unit patterns" explains each demonstration, a cross-example agreement filter, and a second frozen LLM solving the test grid conditioned on the surviving patterns as a natural-language hint.**

> **Provenance.** Das, Ghugarkar, Bhat & Aali 2025, *Compositional Neuro-Symbolic Reasoning* (`raw/das-2025-compositional-neurosymbolic-arc.md`, CoreThink AI + Stanford). ARC-AGI-2 public evaluation set, official `pass@2`. Code released. **No training, no fine-tuning, no reinforcement learning** — every learned component is an off-the-shelf frontier model called through an API. The authors state the absolute scores have since been surpassed.

The wiki's second ARC attack held at source, and the exact opposite of the first: [[wiki/entities/ilp-arc-synthesizer.md]] authors 7 predicates and induces a Prolog program that *executes*; this authors 22 parameterized macro-patterns and induces **a hint**, which an LLM executes by reading it.

---

## Architecture

| Stage | What runs | Deterministic? |
|---|---|---|
| **1 — Scene abstraction** | Background `c_bg = argmax_c Σ 1[I[y,x]=c]` (mode); 8-connected components by BFS; per object: bounding box, centroid, canonical shape (bbox-origin-normalized coordinate set), 10-bin colour histogram, cavities (maximal connected `B ⊂ B_j` with no cell on `∂B_j`). Output `S(I) = {o_1…o_K}` | **Mostly.** Claude Opus 4 (32K tokens) is called for ambiguous shape/cavity cues and as background-colour fallback; the paper renames the stage *structured symbolic abstraction* rather than a parser to admit this |
| **2 — Hypothesis proposal** | `q_θ(π \| S(I_i), S(O_i))` over programs `π = p_{a_m} ∘ … ∘ p_{a_1}`, `a_ℓ ∈ {1…22}`. Realised as `o4-mini` at temperature 0 emitting structured JSON: per pattern, `{pattern_detected, params, reason}`. **5 repetitions per example**, 5 parallel calls | No — sampled, then counted |
| **3 — Consensus filter** | Stated objective: `Π* = ⋂_i Π_i` where `Π_i = {π ∈ Π_i : render(π(S(I_i))) = O_i}`. Tie-break `π* = argmin_{π∈Π*} depth(π)`. **Operationally:** keep the **top-3 patterns by detection count** across the 5×k detections and forward them as a text hint | No — see T190 |
| **4 — Guided solution** | `r_ψ(I_test, H_test)`: Grok-4 conditioned on the demonstrations + the hint, sampled 3–10 times, aggregated by **cell-wise majority vote**. Bypassed by a rule-based jigsaw solver when a symmetry score `> 0.70` | Vote is; the sampler is not |
| **Ensemble** | Grok-4 as meta-classifier picks 1 of 4 candidate grids (2 from this pipeline, 2 from ARC Lang Solver), run twice without replacement to fill `pass@2` | No |

**The DSL's grain is the design choice.** The 22 patterns are not primitives in the `Rotate90` sense — each is a parameterized macro with 3–7 categorical slots whose *values are also enumerated by hand* (`Connecting Bridges` has `source_object`, `target_object`, `bridge_color`, `connection_shape`, `path_direction`, `thickness`, each a 2–4 item menu). The consequence: rule induction becomes **classification into a finite labelled menu**, not search over a compositional space, and Stage 2 is a detector rather than a synthesiser. (Figure 2 says 23 patterns, the text and appendix say 22.)

---

## Results — ARC-AGI-2 public eval, pass@2

| System | Category | Score |
|---|---|---|
| Human panel | — | 100.0 |
| **CoreThink meta-classifier** | Neuro-symbolic + ensemble | **30.8** |
| J. Berman / NVARC | Hybrid | 29.4 / 27.6 |
| ARC Lang Solver alone | — | 26.6 |
| **Compositional Reasoner alone** | Neuro-symbolic | **24.4** |
| GPT-5-Pro / Grok-4 (thinking) | LLM | 18.3 / 16.0 |
| Claude Opus 4 (16K) / o3 (high) / Gemini 2.5 Pro (32K) | LLM | 8.6 / 6.5 / 4.9 |

---

## The payload: voting in hypothesis space is cheaper *and* better than voting in answer space

The ablation is the reason to keep this paper. Two aggregation mechanisms are separated with the solver LLM held fixed.

| Configuration | Score | Latency | Cost |
|---|---|---|---|
| **Full (hints + self-consistency)** | **24.4** | `T_sym + N·T_llm` | `C_sym + N·C_llm` |
| Hints only, greedy decode | 20.5 | `T_sym + T_llm` | `C_sym + C_llm` |
| Self-consistency only, no hints | 17.5 | `N·T_llm` | `N·C_llm` |
| Baseline greedy LLM | 15.0 | `T_llm` | `C_llm` |

Read as marginal value per unit of cost:

| Where the aggregation happens | Marginal gain | Cost scaling | Gain per multiplicative factor |
|---|---|---|---|
| **Hypothesis space** — vote over *which pattern label explains the demonstrations*, 5 detections, top-3 kept | **+5.5** (15.0 → 20.5) | **Additive** (`+C_sym`, stated modest against LLM inference) | ∞ — no multiplicative factor is paid |
| **Answer space** — vote over *output grid cells*, `N` = 3–10 solver samples | **+2.5** (15.0 → 17.5) | **Multiplicative** (`N×`) | ≈ 0.3–0.8 points per extra full solve |

The two compose almost additively (+5.5 and +2.5 alone; +9.4 together), so they are not redundant. This is a direct, priced instance of [[wiki/concepts/external-verification.md]]'s ladder claim, run in a domain the survey did not cover, and it sharpens it: **the majority-vote rung is much better value when the objects being voted on are hypotheses rather than answers**, because the hypothesis is short, the ballots are cheap, and agreement across *demonstrations* is a different kind of evidence from agreement across *samples of the same question*.

Symmetric statement of the same table: symbolic hints are the dominant term (removing them costs 6.9 points, removing self-consistency costs 3.9), and the cheap configuration (hints, greedy) captures 5.5 of the available 9.4 points at no multiplicative cost.

---

## Where the claimed mechanism and the running mechanism part company

The paper's stated contribution is *deterministic* cross-example consistency in place of the "probabilistic aggregation" it criticises LLM solvers for. Four places where the implementation is not that, all conceded in the source:

| Stated | Actually run |
|---|---|
| `Π* = ⋂_i Π_i` with `π \|=_i` iff `render(π(S(I_i))) = O_i` | Patterns ranked by **detection count** over 5 stochastic detections per example; top-3 forwarded. No program is executed against a demonstration output anywhere in the deployed pipeline |
| Programs `π` as compositions of deterministic operators `p_r : S → S` | Hypotheses "maintained as ranked UnitPattern descriptions and candidate parameterizations rather than as an exhaustively enumerated program tree". The composition operator `∘` is never applied |
| Symbolic scene graph from grid structure | Shape labels, cavity coordinates and ambiguous backgrounds come from prompted Claude Opus 4 |
| `π* = argmin_{π∈Π*} depth(π)` selected "if `Π* = ∅`" | As written the rule is vacuous (an argmin over an empty set); the running selector is the detection-count ranking, and no complexity term is computed |

So Stage 4's `r_ψ` is an LLM instructed to "follow the hint steps in order, exactly as described, with no additions or omissions" — the DSL is a **vocabulary for describing the transformation to another model**, not a machine that performs it. Recorded as [[wiki/empirical-tensions.md]] T190. This does not weaken the ablation, which is a controlled comparison of *what is actually run*; it changes what the 6.9 points are evidence for — a strong structural prior expressed in language, not symbolic execution.

---

## Two mechanisms the wiki did not previously have an instance of

### 1. A run-time router between structure types, with a scalar threshold (G12)

`symmetry_score > 0.70` on the input triggers a **rule-based jigsaw solver and bypasses the LLM entirely**. This is the wiki's first architecture that decides at query time which of two structurally different solvers gets the problem, and it makes the shape of the gap concrete: the router is a hand-set scalar on a hand-chosen statistic, applies to exactly one pattern family, and nothing generalises it. G12 asks for a policy; this is a single if-statement, but it is the first one, and it shows the payoff a router buys is *cost* (a symmetry task never pays for an LLM call) at least as much as accuracy.

### 2. A selector that is a proposer of the same kind (G68)

The meta-classifier gains +4.2 over the best single solver (26.6 → 30.8) while generating nothing new — it picks one of four already-produced grids. But it is Grok-4, the same model family that produced two of the candidates, shown the same demonstrations, with no execution and no independent criterion. On [[wiki/concepts/external-verification.md]]'s ladder this sits at *agent consensus*, and its failure mode is the one that page names: shared misconception. The gain is attributed by the authors to **structural diversity of the generators** rather than to selector quality — tasks solved uniquely by this pipeline cluster on cavity reasoning, structured fills, symmetry; tasks solved uniquely by ARC Lang Solver cluster on semantic reinterpretation of object groupings. That attribution is untested (no ablation replaces the meta-classifier with random selection among the four, which is the control that would price the selector against `pass@2`'s own free two-shot).

---

## Limitations

| Limitation | Consequence |
|---|---|
| **DSL authored from the training sets** | The 22 patterns were "identified through manual analysis of the ARC-AGI-1 and ARC-AGI-2 training sets" and *called* a core-knowledge set. G4 untouched; and the priors are here derived from the benchmark rather than from the cognitive literature ARC derived them from |
| **Failures cluster outside the DSL** | Named residual: deeply compositional multi-stage relational transformations and implicit latent grouping. The 22-item menu is the ceiling |
| **No component is trained or evaluated in isolation** | The ablation varies configuration, not stages. There is no measurement of Stage 1 parse accuracy, Stage 2 detection precision/recall, or how often the "consensus" pattern is the correct one |
| **Baseline figures disagree** | Abstract says base LLM 16%, the ablation baseline says 15.0, the leaderboard row says Grok-4 (thinking) 16.0. The headline delta is ±1 point ambiguous |
| **Heterogeneous frozen stack** | Four vendors, key-pool rotation, 72,000 s timeouts. Results are not reproducible against fixed model versions and are not attributable to the architecture alone |
| **Cost never reported in absolute terms** | `T_sym`, `C_sym`, `N` appear only as symbols. The single most useful number for [[wiki/concepts/external-verification.md]] — dollars or tokens per task — is absent |

---

## Comparison

| System | Vocabulary | Grain | Rejector | Does a program execute? |
|---|---|---|---|---|
| **CoreThink** | 22 authored macro-patterns, each with enumerated categorical parameter menus | **Coarse** — one pattern ≈ one whole ARC transformation family | Detection-count vote + cell-wise vote + LLM meta-selector — all on the majority-vote rung | **No** (except the jigsaw fallback) |
| [[wiki/entities/ilp-arc-synthesizer.md]] | 7 authored predicates (3 object types, 4 relations) | **Fine** — programs are clause sequences | Manufactured negatives + theory consistency, both free and deterministic | **Yes** — ordered writes onto a canvas |
| [[wiki/entities/neo-neural-theorizer.md]] | VQ codebook, **induced** | Fine, semantics learned by a shared executor | Majority vote @1024 (~180× cost) | Yes |
| [[wiki/entities/bayesian-program-learning.md]] | Learned stroke primitives, authored relation types | Fine | Posterior score | Yes (as a generative model) |
| [[wiki/entities/arc-agi.md]] (Chollet's sketch) | A DSL over four core-knowledge priors, forbidden to author | Unspecified | Learned prior over programs | Yes |

The column that separates this row from every other: **grain**. Coarsening the vocabulary until one symbol covers a whole task family converts induction into classification, which is why a frozen LLM with no search can do the proposal step at all — and is also exactly why the failures are the compositional tasks. The 22 patterns do not compose in practice; `∘` is defined in the paper and never invoked.

---

## What a builder should take

1. **Move the vote from the answer to the hypothesis.** +5.5 additive versus +2.5 multiplicative, same solver, same benchmark. Any architecture currently paying `N×` inference for self-consistency should first ask whether there is a shorter object upstream whose agreement across *demonstrations* can be counted instead.
2. **Grain is a free parameter of a DSL and it trades search against coverage monotonically.** Fine grain (7 predicates) → real search, real execution, real rejection, and a task-selection problem. Coarse grain (22 macros) → no search, no execution, no rejection, and a hard ceiling at whatever the macros cover. Nothing in the wiki sets this parameter by principle.
3. **(brainstorm) The hint is a channel, and the channel is language.** What this pipeline actually shows is that a structured perceptual parse plus a named hypothesis, expressed in text, is worth more to a frozen reasoner than nine extra samples of itself. If the symbolic layer's whole contribution is *conditioning* rather than *computing*, then the interface between a perceptual module and a reasoning module can be a lossy natural-language summary and still carry most of the value — which is T8's "acquired composer" position given an unexpected piece of engineering support, and a much weaker requirement on the symbolic layer than executability.
4. **A router pays for itself in cost before it pays in accuracy.** The symmetry bypass is worth noting less for the points it wins than for the LLM calls it never makes.

---

## Connections

- **[[wiki/entities/arc-agi.md]]** — the benchmark's successor version attacked at source, and a measurement of where the difficulty moved: on ARC-AGI-2 the frontier LLM baseline is 15–18% and a 22-item authored pattern menu plus consensus filtering adds ~9 points without training anything.
- **[[wiki/entities/ilp-arc-synthesizer.md]]** — the same benchmark from the opposite end of the grain axis: 7 fine predicates that execute and reject for free versus 22 coarse macros that neither execute nor reject, with the trade being search cost against coverage ceiling.
- **[[wiki/concepts/external-verification.md]]** — supplies a priced comparison the survey's ladder does not contain: the *same* rung (majority vote) applied to hypotheses instead of answers is worth 2.2× the points at additive rather than multiplicative cost, and the meta-classifier is a textbook agent-consensus rung with the shared-misconception channel open.
- **[[wiki/concepts/program-induction.md]]** — the family it belongs to nominally and departs from operationally: the hypothesis space is a finite labelled menu rather than a compositional program space, so cost 2 (search) is paid by making search unnecessary, and cost 4 (a rejection returns one bit) is dodged by never rejecting.
- **[[wiki/concepts/core-knowledge.md]]** — a second, competing operationalization of the priors ARC declares: 22 transformation *families* mined from the training sets and called core knowledge, against Chollet's four cognitive systems — the same word for a benchmark-derived inventory and a developmental one.
- **[[wiki/concepts/compositionality.md]]** — the negative result: `π = p_{a_m} ∘ … ∘ p_{a_1}` is defined and never executed, the top-3 patterns are forwarded as an unordered hint, and the residual failures are exactly the multi-stage compositional tasks.
- **[[wiki/concepts/latent-graph-discovery.md]]** — an instance in which the edge-label vocabulary is authored coarsely enough that edge-label inference becomes classification, at the price of a hard coverage ceiling; node discovery (G27) is likewise handed to connected components plus a prompted LLM.
- **[[wiki/concepts/amortized-inference.md]]** — the extreme case: the proposer is a frozen model that was never trained on this task distribution, so amortisation is bought entirely from pretraining, and the "structural prior" is delivered as conditioning text rather than as parameters.
- **[[wiki/entities/arc-vsa-solver.md]]** — the same cross-demonstration agreement principle at the opposite grain: where this pipeline counts macro-pattern detections across demonstrations and forwards the top three as a hint, that solver makes reuse-across-demonstrations an exact minimum-hitting-set objective over fine primitives, so agreement performs the selection rather than filtering it.
- **[[wiki/entities/arc-agi-2.md]]** — the benchmark this system is built against, held at source: its four authored difficulty axes name exactly the residual failures reported here, and its cost-per-task reporting rule is what makes this page's hypothesis-space-vs-answer-space cost table comparable to any other entry.
- **[[wiki/entities/poe-arc-solver.md]]** — the third population to agree over (augmented frames, against this page's demonstrations and samples), and the only one with an analytic reason for the aggregator: a product of likelihoods beats their mean by 5.0 points on a fixed candidate set because it lets one dissenting view veto, which is the formal case for counting agreement rather than averaging confidence.
