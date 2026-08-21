# AutoToM — Automated Agent Modeling for Model-Based Mental Inference

**Bayesian inverse planning with the agent model itself made latent: an initial Bayes net over mental variables is proposed, inference is run over it by an LLM estimating every local conditional, and the *structure* is then grown — one mental variable, or one earlier timestep, at a time — until the posterior over the question is sharp enough.**

> **Provenance.** Zhang, Jin, Jia, Zhang & Shu (`raw/zhang-2025-autotom-mental-inference.md`). NeurIPS 2025 Spotlight; arXiv v3, 2026-01-14. Peking University + Johns Hopkins. Code and project page released. Backend for all headline numbers: GPT-4o.

Its interest here is not theory of mind. It is that this is the wiki's **first running structure-discovery loop with a stated selection criterion, an enumerated hypothesis space of models, and a measured price per query** — and the criterion is neither fit nor description length but *answerability of the question asked*.

---

## The formalism it unifies

| Symbol | Meaning |
|---|---|
| `X^t = {s^t, a^t, u^t}` | Observable variables at time `t` — state, action, utterance. `s^t` always present; `a^t` or `u^t` depending on whether the step is physical or verbal |
| `V^t = {o^t, b^t, g^t}` | Latent mental variables — observation, belief, goal |
| `M = (V^{ts:t}, X^{ts:t})` | An **agent model**: a Bayes net over a chosen variable set across a chosen time window `[ts, t]` |
| `q` | The query |

Inference over a latent mental variable, marginalising the rest:

`P(v_i^t | X^{ts:t}) ∝ Σ_{V^{ts:t}_{-i}} P(v_i^t, V^{ts:t}_{-i}, X^{ts:t})`   (Eqn. 3)

and the same machinery predicts a *future observable* by marginalising over all latents instead:

`P(x_i^{t+1} | X^{ts:t}) ∝ Σ_{V^{ts:t}} P(V^{ts:t}, x_i^{t+1}, X^{ts:t})`   (Eqn. 4)

One consequence worth carrying: **belief-inference and action-prediction are the same computation with the marginalisation boundary moved**. MDP, POMDP and I-POMDP are not three models but three points in this space — an MDP is the configuration with no belief node, a POMDP adds `b^t` and `o^t`, an I-POMDP replaces belief-over-state `b(s)` with belief-over-interactive-state `b(is)`.

---

## The model space — enumerated, and searched

Per timestep, the configuration is a product of three authored choices:

| Choice | Options | Count |
|---|---|---|
| Action vs utterance | action · utterance | 2 |
| Belief/observation | none · belief of state · belief of interactive state · either + observation | 5 |
| Goal | action irrelevant to inference · action only · action + goal | 3 |

`2 × 5 × 3 = 30` configurations per timestep, hence **`30^(t−ts+1)` models over a window**. This is the first hypothesis space in the wiki that is over *model structures* and is both explicitly enumerated and actually searched at inference time.

Two named members outside the textbook three: an **Observation Update Model** (actions present but only to update the state; used for ToMi, where the question is about belief and the action is not diagnostic) and a **POMDP without goal**.

---

## Model utility — the selection criterion

`U(M, q) = R(M, q) − C(M)`,  `R(M, q) = −H(P(q | X^{ts:t}))`,  `C(M) = α|M|`

with `|M|` the number of latent mental variables, `α = 0.02`, and acceptance threshold `U_min = −0.693`.

- `−0.693 = −ln 2`, i.e. **one bit**: the search stops as soon as the query posterior carries less than one bit of entropy, less the complexity charge. On a two-way multiple choice that is "any posterior strictly better than a coin flip, if the model is small."
- The reward is **query-conditioned**: the same context yields a different model for "where does she think it is?" than for "what is she trying to do?". This is the property that distinguishes it from every model-selection criterion the wiki holds — description length ([[wiki/concepts/universal-induction.md]], G26) and predictive fit are both computed on the data alone and are the same whatever is asked.
- The reward is **confidence, not correctness**. Nothing in `U` consults an answer. A model that omits the variable which would introduce doubt scores best; the authors' own stated failure mode is exactly this ("model adjustments may sometimes fail to recognize the relevance of certain mental variables, resulting in an insufficient model"). Recorded as [[wiki/empirical-tensions.md]] T189.

### The search

Greedy hill-climb, no backtracking (Algorithm 1):

1. Extract `X^{1:t}` from the context **once** (LLM); identify the target agent; build timesteps from *that agent's* actions and utterances.
2. Set `ts ← t` — **start with the last timestep only**.
3. Propose a minimal initial `V^{ts}` (LLM), including the required recursion level.
4. Run inference; compute `U`.
5. **Variable adjustment:** `v_new = argmax_{v ∉ V} U(M + v, q)` over the four addable types (goal, belief, observation, interactive state), each with an authored local-conditional rewrite (Table A1, e.g. adding belief turns `P(a^t|s^t)` into `P(a^t|b^t)P(b^t|s^t,b^{t−1})`). Accept only if `U` strictly increases; repeat.
6. **Timestep adjustment:** if `U < U_min` and variables are exhausted, `ts ← ts − 1` and go to 3.

Context is therefore a **cost recruited on demand, backwards in time** — the opposite posture from every long-context method, and the ablations say the posture is load-bearing rather than merely cheap.

### The LLM's five jobs

| Job | Role in the wiki's vocabulary |
|---|---|
| Information extraction (once per question) | Symbol grounding: text → typed observable variables on a timeline |
| Initial model proposal | Structure prior — which variables plausibly matter, and at what recursion order |
| Hypothesis sampling per latent | **Amortised proposal** ([[wiki/concepts/amortized-inference.md]]) — a small set of candidate values instead of an enumerable hypothesis space; when `s^t` is not given, the LLM runs as the world model and rolls the state forward |
| Hypothesis reduction | A **rejector**: drop hypotheses with low local conditional (e.g. `P(o_1^t\|s^t) = 0.01`) before the expensive joint is assembled |
| Local conditional estimation | The numbers in the Bayes net — every `P(a\|b,g)`, `P(b\|b′,o)`, `P(o\|s)` is an LLM likelihood, not a learned or authored distribution |

Recursion is handled by **sampling one state from `b(s)` at level `l` to stand in for the state at level `l−1`**, recursively down to level 0, then running ordinary BIP there. This is what makes arbitrary order cheap: a nested posterior is replaced by a single sampled world.

---

## Results

Accuracy (%), GPT-4o backend throughout for AutoToM and all scaffolded baselines.

| Method | ToMi | BigToM | MMToM-QA | MuMA-ToM | Hi-ToM | All |
|---|---|---|---|---|---|---|
| GPT-4o | 77.00 | 82.42 | 44.00 | 63.55 | 50.00 | 63.39 |
| Gemini 2.0 Pro | 71.90 | 86.33 | 50.84 | 62.22 | 57.50 | 65.76 |
| SymbolicToM | **98.60** | — | — | — | 44.50 | — |
| SimToM | 79.90 | 77.50 | 51.00 | 47.63 | 71.00 | 65.41 |
| DeepSeek-R1 | 89.40 | 86.25 | 49.67 | 63.44 | 56.50 | 69.05 |
| Gemini 2.0 Flash Thinking | 78.00 | 82.83 | 54.00 | **82.56** | 73.50 | 74.18 |
| o3-mini-high | 73.10 | 86.92 | 64.67 | 70.00 | **75.00** | 73.94 |
| BIP-ALM (fixed model) | 55.60 | 50.33 | 56.17 | 33.90 | 14.50 | 42.10 |
| LIMP (fixed model) | 44.60 | 61.67 | 55.33 | 76.60 | 6.50 | 48.94 |
| **AutoToM** | 88.30 | **86.92** | **83.00** | 81.44 | 72.50 | **82.43** |

**Read the two fixed-model rows first.** BIP-ALM and LIMP are hand-specified Bayesian inverse planners — the same family as [[wiki/entities/hbtom.md]] — and off their home benchmark they score **below the raw LLM** (42.10 and 48.94 against 63.39), bottoming out at 6.5–14.5 on higher-order recursion. A structured model applied outside the domain its structure was authored for is worse than no model at all. That is the result the paper is built on, and it is the sharpest statement in the wiki of what an authored graph costs.

**Where it does not win.** SymbolicToM, a domain-specific belief tracker, beats it by 10 points on ToMi and collapses to 44.50 on Hi-ToM. Gemini 2.0 Flash Thinking is ahead on MuMA-ToM, o3-mini-high on Hi-ToM. The claim the table supports is *lowest variance across domains*, not a per-domain ceiling.

**Cost** (MMToM-QA): 8.0K tokens / 8.5 s per question, against o3-mini-high's 10.9K / 21.6 s at 64.67 accuracy. The scaffold is cheaper than reasoning-token scaling and 18 points better on that benchmark.

### Recursion order — Hi-ToM, per order

| | 0 | 1 | 2 | 3 | 4 |
|---|---|---|---|---|---|
| GPT-4o | 92.50 | 65.00 | 40.00 | 27.50 | 25.00 |
| o3-mini-high | 100.00 | 72.50 | 65.00 | 60.00 | **77.50** |
| **AutoToM** | 95.00 | 75.00 | 70.00 | **67.50** | 55.00 |

The wiki's first *run and priced* nested mental inference past depth one ([[wiki/empirical-tensions.md]] T183): order 4 is reachable, degrades from 95 → 55, and costs ~12.0K tokens / 36.5 API calls per question on Hi-ToM against ~6.5K / 13.8 on the depth-1 BigToM. Sampling one state per level is what keeps that linear rather than multiplicative.

### Ablations — the load-bearing parts

| Variant | Accuracy (all) | Tokens (K) | API calls |
|---|---|---|---|
| **AutoToM** | **82.43** | 10.0 | 27.03 |
| w/o hypothesis reduction | 81.15 | 15.3 | 43.59 |
| w/ POMDP always | 72.59 | 13.1 | 30.26 |
| w/o variable adjustment (initial proposal only) | 77.49 | 9.3 | 23.80 |
| w/ last timestep only | 69.11 | 6.7 | 15.97 |
| w/ all timesteps | 77.92 | 19.0 | 47.32 |

Three things fall out:

1. **A fixed POMDP — the "obviously general" choice — costs 9.8 points and *more* compute than the adaptive search.** Over-modelling is not merely wasteful, it is wrong: the extra latents add hypotheses to marginalise over and dilute the posterior.
2. **Using all available context is worse than choosing the context** (77.92 vs 82.43) *and* nearly twice the tokens, with an outlier at MMToM-QA — 44.5K tokens and 101 API calls for 76.17, against 8.0K/17.6 for 83.00. Evidence against the default assumption that evidence is monotone ([[wiki/concepts/evidence-accumulation.md]]).
3. **The rejector strictly dominates.** Hypothesis reduction buys +1.28 accuracy at −35% tokens and −38% API calls. It is internal (the generator scores its own candidates), so it does not satisfy G68's externality condition, but it is the wiki's first *price* on what an internal rejector is worth.

### Backend sensitivity — MMToM-QA

| Backend | Backend alone | + AutoToM |
|---|---|---|
| GPT-4o | 44.0 | **83.0** |
| Qwen3-235B-A22B | 45.0 | 67.5 |
| DeepSeek-V3-0324 | 34.8 | 71.1 |
| Gemini-2.5-Flash (no thinking) | 44.7 | 71.7 |

Every backend gains 23–39 points with no prompt re-engineering, and the backends are indistinguishable *unscaffolded* (34.8–45.0) while spanning 15.5 points *scaffolded*. The structure does not erase the backend; it makes a latent difference between backends visible — most plausibly calibration of the local conditionals, which is the one quantity the scaffold consumes and never validates.

### Human confidence profiles (Baker et al. 2009, 2017; frames captioned to text)

| Task | AutoToM | GPT-4o | o3-mini-high |
|---|---|---|---|
| Online goal inference (full obs.) | 0.93** | 0.81** | **0.97**** |
| Desire inference (partial obs.) | **0.88**** | 0.30 | 0.52* |
| Belief inference (partial obs.) | **0.73**** | 0.04 | 0.03 |

Pearson `r`; `*: p ≤ .05`, `**: p ≤ .001`. Under **full** observability a reasoning model matches or beats the structured one; under **partial** observability the LLMs fall to `r ≈ 0`. The whole value of the explicit belief node is at the point where what the agent knows diverges from what is true — which is also the point where an entropy-guided search has a reason to add the node.

### Embodied assistance (Online Watch-And-Help, 20 episodes × 3 runs)

Goal inference re-run **at every step while acting**, with the goal posterior carried by Sequential Monte Carlo: speedup **27.7%** vs GPT-4o 6.8% vs random goal 6.3% (the random baseline is negative in half the episodes). The helper's planner is held fixed (the uncertainty-aware planner from the O-WAH paper), so the comparison is on the inference alone. Large reasoning models were excluded outright — >1 min per timestep makes them unusable online.

Additional benchmarks: FANToM first-order false belief 72.7 (GPT-4o 57.5); OpenToM attitude Macro-F1 0.56 (GPT-4o 0.48, o3-mini-high 0.60), by extending the causal structure with attitude and preference nodes and leaving everything else unchanged — the authors note attitude needs *forward* estimation, not inversion, which is why the margin collapses there.

---

## What is discovered and what is supplied

The audit this page exists for.

| Component | Status |
|---|---|
| Which mental variables the model contains | **Searched**, per query, per timestep |
| How many timesteps of context are relevant | **Searched**, backwards from the present |
| Recursion order | **Proposed** by the LLM at initialisation, not searched |
| The *menu* of variable types (goal, belief, observation, interactive state) | **Authored** — four types, from "typical causal structures in prior decision-making models" |
| The local-conditional rewrite for each addition (Table A1) | **Authored** — each edit to the graph comes with its factorisation written out by hand |
| The rationality assumption | **Implicit in the LLM's `P(a\|b,g)`.** Unlike [[wiki/entities/hbtom.md]]'s `β_n`, there is no rationality variable and no way to infer that an agent is irrational |
| Every probability in the network | **LLM-estimated**, never calibrated against anything |
| The hypothesis set for each latent | **LLM-proposed** — if the true answer is not sampled, no amount of inference recovers it |
| Perception | **Outside the system.** "AutoToM currently requires a separate process to first fuse information from different modalities into text before inference" — MMToM-QA and MuMA-ToM use the fusion modules from their own papers, and the two cognitive studies were run on **hand-captioned frames** |
| `α = 0.02`, `U_min = −0.693` | **Hand-set**, no sensitivity analysis |

So the discovery is real but bounded: it is search over *which of an authored set of variables to instantiate, and over how long a window* — node-set selection within a given vocabulary, not vocabulary discovery. In the taxonomy of [[wiki/concepts/latent-graph-discovery.md]] this moves the *node set* and the *edge set* from supplied to inferred, while node types, edge semantics and the observation grounding stay supplied.

---

## Comparison

| | **AutoToM** | [[wiki/entities/hbtom.md]] | BIP-ALM / LIMP | [[wiki/entities/spacetime-attractor.md]] |
|---|---|---|---|---|
| Agent model | Searched per query | Authored, fixed | Authored, fixed, domain-specific | None — no explicit posterior |
| Beliefs | Explicit node, added on demand | **Absent** (MDP only; false belief out of reach) | BIP-ALM: manual belief update; LIMP: none | Implicit in the coupled dynamics |
| Rationality | Implicit in an LLM likelihood | Continuous inferred latent `β_n` | Assumed | Assumed (both sides optimise) |
| Recursion | Arbitrary order, run to 4, sampled per level | Depth 1 | Not supported (6.5–14.5 on Hi-ToM) | Fixed point of mutual best response |
| Environment dynamics | LLM as world model | Hand-written PDDL | Hand-written per domain | Learned attractor |
| Inference | LLM local conditionals + explicit marginalisation | Exact conjugacy + 5-point grid + A\* | Amortised LM likelihoods over a fixed net | Relaxation |
| Perception | Text only; fusion is a separate hand-built stage | Noise-free symbolic JSON | Fused to symbols per domain | Sketch only |
| Cost per query | ~10K tokens, ~27 API calls, 8.5 s | Milliseconds | Comparable | Unreported |

The row that matters: HBToM buys exactness by refusing generality (conjugacy needs the conjugate model), AutoToM buys generality by making every conditional an uncalibrated LLM call. Nobody has the pair.

---

## Open problems

- **Confidence is not correctness.** `U` maximises posterior sharpness on the query; a model missing a doubt-creating variable wins. No experiment separates "the search found the right model" from "the search found the model that makes the LLM sure" (T189).
- **The hypothesis set is a hard ceiling and is never audited.** Every posterior is over LLM-proposed values. The benchmarks are multiple choice, so the correct hypothesis is effectively handed over in the prompt; FANToM and the open-ended BigToM conditions are the only partial checks, and neither reports recall of the true value in the sampled set.
- **Greedy, single-variable, no backtracking.** The search accepts only strict improvements, so a pair of variables that helps only jointly (belief + observation is precisely such a pair, and is why the Table A1 rewrite for observation presupposes belief) is reachable only through the authored ordering.
- **Recursion order is proposed, not searched.** The one structural choice with the steepest cost curve is the one left to a single LLM call.
- **Perception is excluded by construction**, and the cognitive-study replication inherits it: hand-written captions supply the object individuation and the event segmentation that [[wiki/concepts/event-segmentation.md]] and G27 say nothing supplies.
- **No calibration study.** The entire method is arithmetic over numbers the backend invents; the 15.5-point spread across backends at matched scaffold is the only evidence about them, and it is indirect.
- **The utility's two hyperparameters are unswept.** `α` trades accuracy against variables and `U_min` sets when to stop; both are single values with no reported sensitivity, in a paper whose central claim is that the *right amount of model* matters.

---

## Connections

- **[[wiki/entities/hbtom.md]]** — the same computation with the model handed over instead of searched: HBToM has no belief node and no nesting, which is exactly what AutoToM's variable adjustment adds on demand, and the fixed-model baselines here (BIP-ALM, LIMP) price what that authoring costs off-domain.
- **[[wiki/concepts/simulation-based-planning.md]]** — the inverse-planning row with its *model* made latent: the forward planner is still a POMDP policy, but which variables the policy is conditioned on is decided per question by an entropy criterion rather than by the modeller.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a running instance of the node-and-edge-set half of the problem: the vocabulary of variable types is supplied, and the search decides which of them exist and over how long a window, which is the narrowest form of discovery that is still discovery.
- **[[wiki/concepts/amortized-inference.md]]** — hypothesis sampling is amortisation without a recognition network: the LLM's forward pass proposes the small candidate set that an enumerable hypothesis space would otherwise have to be searched over, and hypothesis reduction prunes it against the local conditionals.
- **[[wiki/concepts/language-of-thought.md]]** — the nested-`query` construction actually executed: recursion to order 4, made linear rather than multiplicative by sampling one state per level instead of maintaining a nested posterior (T183).
- **[[wiki/concepts/causal-model-building.md]]** — model building where the object being built is a causal graph over *another agent's* mental variables, with the build step driven by the uncertainty of the question rather than by fit to data.
- **[[wiki/concepts/evidence-accumulation.md]]** — the counterexample to monotone evidence: adding all available timesteps loses 4.5 points and doubles the cost against adaptively recruiting them backwards from the present.
- **[[wiki/concepts/external-verification.md]]** — hypothesis reduction is a rejector priced for the first time (+1.28 accuracy, −35% tokens) but scored by the generator itself, so it sits on the Goodhart rung of that page's ladder rather than the external one.
- **[[wiki/concepts/violation-of-expectation.md]]** — the alternative readout of the same posteriors: HBToM converts them to surprise for a paired-continuation test, AutoToM converts them to a confidence profile correlated against human judgements, and only the latter needs the study's human data to exist.
- **[[wiki/concepts/core-knowledge.md]]** — the agent core system again, but with the intuitive-psychology *schema* (goal, belief, observation, interactive state) supplied as a menu and its instantiation left to search, which is closer to what an installed prior with an entry test would look like (G23).
- **[[wiki/entities/spacetime-attractor.md]]** — the circuit-level rival for the same function: mutual best response as a relaxation fixed point, against an explicit sampled recursion whose per-level cost is now measured.
- **[[wiki/entities/transformer.md]]** — the backend, used here as five separate estimators (extractor, structure proposer, world model, hypothesis sampler, likelihood oracle) rather than as an answerer, which is what turns a 44.0 into an 83.0 on MMToM-QA.
- **[[wiki/concepts/precision-weighting.md]]** — the same quantity promoted from a weight to an objective: posterior confidence here does not gate an update, it *decides the model*, which is that page's Goodhart failure mode with no likelihood term beside it (T189).
- **[[wiki/concepts/expected-free-energy.md]]** — the closest formal relative of the model-utility criterion, and the contrast that isolates what is missing: the entropy term there scores an imagined future and is one of two terms, here it scores a model structure and is the only one.
- **[[wiki/entities/agent-benchmark.md]]** — the fixed-model predecessor in the physical domain: rewards and a two-term force cost are the only latents, the factorisation is authored, and belief is declared out of scope — the three things this page's model search removes; its derenderer ablation (.96 → .65) also prices the noise-free state both approaches assume.
- **[[wiki/entities/bib.md]]** — the benchmark whose closing discussion asks for exactly this page's extension: BIB tests intentional states only and names perceptions, beliefs and false belief as the natural next benchmark, which is the variable this page makes searchable rather than authored.
