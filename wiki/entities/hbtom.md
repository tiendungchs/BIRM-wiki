# HBToM — Hierarchically Bayesian Theory of Mind

**Bayesian inverse planning with a *hierarchy* on top: per-agent priors over goal preferences and over action efficiency, so that eight observation trials fix an agent's dispositions, and the ninth trial can be scored as plausible or surprising.**

> **Provenance.** Zhi-Xuan, Gothoskar, Pollok, Gutfreund, Tenenbaum & Mansinghka 2022 (`raw/zhixuan-2022-bayesian-theory-of-mind-baby-intuitions.md`). Unrefereed 5-page arXiv preprint, v1, never revised; DARPA Machine Common Sense. Code: `probcomp/SolvingBIB.jl`. The wiki's first *primary* source for Bayesian inverse planning, previously carried second-hand through Lake et al. 2017 on [[wiki/concepts/core-knowledge.md]] and [[wiki/concepts/simulation-based-planning.md]].

Its interest here is not the accuracy table but the shape: the intuitive-psychology core system, written out as an explicit generative model, with the two-level hierarchy of [[wiki/concepts/latent-graph-discovery.md]] realised **architecturally** rather than emerging from training.

---

## The task it is scored on — Baby Intuitions Benchmark (BIB)

Gandhi et al. 2021 (secondary description here; primary source queued at `raw/gandhi-2021-baby-intuitions-benchmark.md`). Gridworld videos of agents moving toward objects, built to test expectations infants already hold.

| Task set | Infant expectation being tested |
|---|---|
| **Efficiency** | Agents act efficiently toward their goals unless evidence says otherwise |
| **Preference** | Agents prefer object goals they have sought before |
| **Multi-Agent** | Separate agents have separate preferences |
| **Inaccessible Goals** | An accessible goal is chosen over an inaccessible preferred one |
| **Instrumental Actions** | Agents take instrumental steps (fetch key → unlock barrier) to reach goals |

**Protocol — violation of expectation, paired.** Each episode = 8 familiarization trials + 1 test trial. Episodes come in pairs sharing the familiarization trials and differing only in the test trial (one plausible, one implausible). Score = *pairwise* accuracy: did the model rate the plausible member higher? This is the wiki's first evaluation protocol that needs **no ground-truth label and no distribution shift** — only a relative judgement between two continuations of an identical history (gap G17).

---

## The generative model

`N` agents across `M` trials. Per agent `n`: a preference vector `θ_n` and an efficiency scalar `β_n`. Per trial `m`: an agent identity, a goal, a policy, a trajectory.

| Level | Variable | Distribution |
|---|---|---|
| **Agent (slow)** | Preference `θ_n` | `Dir(α₁…α_G)`, flat (`α_i = 1`) — equal preference for all objects |
| **Agent (slow)** | Efficiency `β_n` | `Inv-Gamma(a=b=1)` — weak bias toward efficient rather than random |
| **Trial (fast)** | Goal `g_m` | `Categorical(θ̃_{n_m})` |
| **Trial (fast)** | Policy `π_m` | Boltzmann over MDP Q-values: `π_m(a\|s) = exp(β_n Q(s,a)) / Σ_{a'} exp(β_n Q(s,a'))` |
| **Step** | Action, state, observation | `P(a_{m,t}\|s_{m,t−1}, π_m)`, `P(s_{m,t}\|s_{m,t−1},a_{m,t})`, `P(o_{m,t}\|s_{m,t})` |

`β_n = ∞` is optimal action, `β_n = 0` is uniformly random — so "how rational is this agent" is a single continuous latent, inferred rather than assumed.

**FEASIBILIZE.** Before goal selection, the preference vector is renormalised over goals that are actually reachable: `θ̃_{n_m} = FEASIBILIZE(θ_{n_m})` — zero out inaccessible objects, rescale the rest. This one operation is what makes the model predict that an agent reaches for an accessible dispreferred object over an inaccessible preferred one, and it leaves the *preference* posterior unchanged while changing the *goal* posterior.

**(brainstorm)** FEASIBILIZE is the closest thing in the wiki to the **entry test** G23 asks for, run on the other side: not "does this entity qualify for the prior?" but "does this hypothesis survive the current world state?". A prior conditioned on feasibility is a prior that can be locally disabled without being unlearned — the property G23 says every machine inductive bias lacks. It is also a *masking* operation on a categorical latent, which is cheap enough to sit inside any softmax-headed architecture.

---

## Inference — why it is tractable

| Trick | Effect |
|---|---|
| **Conditioning on states directly** | BIB observations are noise-free JSON; agent identity, states and actions are read off, so `P(o\|s)` is bypassed entirely |
| **Agent independence** | Each agent's `(θ_n, β_n)` inferred separately; trials with other agents ignored |
| **Dirichlet–categorical conjugacy** | `θ_n` is marginalised *exactly*; `P(g_m \| g_{1..m−1})` is a closed-form conjugate update, so few-shot preference learning costs no sampling |
| **Discretised efficiency** | `β_n ∈ {0.2, 0.2√2, 0.4, 0.4√2, 0.8}` — a 5-point grid replaces sampling; enumerate, then marginalise goal ↔ efficiency against each other |
| **Value function by A\*** | Deterministic environment ⇒ `V(s) = −(cost of cheapest plan)`, computed by A\* with a Euclidean heuristic only for *visited* states, instead of full value iteration |

Trial-by-trial: the goal posterior after trial `m−1` becomes the goal prior for trial `m`. That recursion *is* the habituation the benchmark tests.

---

## Plausibility readout

Three surprise metrics, each squashed by its own logistic classifier `f(x) = 1/(1+exp(wx+b))`, then **multiplied**:

| Metric | Formula | Surprise it captures |
|---|---|---|
| Goal | `max_t ‖P_t(g_m) − P₀(g_m)‖_TV` | The agent pursued a goal other than the predicted one |
| Efficiency | `max_t ‖P_t(β_n) − P₀(β_n)‖_TV` | The agent acted more or less rationally than expected |
| Observation | `max_t [log P(o_{m,0}) − log P(o_{m,t}\|o_{m,0:t−1})]` | The trial is inexplicable under the model as a whole |

Fitted weights: goal `w=−11.81, b=5.96`; efficiency `w=−9.42, b=5.90`; log-likelihood `w=−0.2, b=2.0` (the last hand-tuned for outliers).

The product form encodes *surprising on any axis ⇒ surprising overall*. The paper's own hypothesis is that no single metric suffices — goal TV is blind when there is only one goal, efficiency TV is blind when the agent stays efficient but re-goals — and the promised ablation was deferred "to a future version" and never run.

**(brainstorm)** The readout is the interesting export, independent of the model behind it: **prediction-error decomposed by latent variable**. A scalar surprise says a trial was odd; a per-latent surprise vector says *which* part of the world model was violated, which is exactly the routing signal an event-segmentation boundary detector would need to decide what to re-infer ([[wiki/concepts/event-segmentation.md]]). Any architecture holding an explicit posterior over several latents gets this readout for free; a monolithic predictor cannot produce it at all.

---

## Results — pairwise accuracy on BIB (%)

| Task | **HBToM** | BC-MLP | BC-RNN | Video-RNN |
|---|---|---|---|---|
| Efficiency | **96.0** | 88.8 | 82.5 | 83.1 |
| — Path Control | 94.9 | 94.0 | 92.8 | **99.2** |
| — Time Control | 97.2 | 99.1 | 99.1 | **99.9** |
| — Irrational | **96.6** | 73.8 | 56.5 | 50.1 |
| Preference | **99.7** | 26.3 | 48.3 | 47.6 |
| Multi-Agent | **99.2** | 48.7 | 48.2 | 50.3 |
| Inaccessible Goals | **99.7** | 76.9 | 81.6 | 74.0 |
| Instrumental Actions | **98.5** | 67.0 | 77.9 | 79.9 |
| — No Barrier | 98.8 | 98.8 | 98.8 | **99.7** |
| — Inconsequential | **97.0** | 55.2 | 78.2 | 77.0 |
| — Blocking Barrier | **99.7** | 47.1 | 56.8 | 62.9 |

Baselines: two behavioural-cloning nets (MLP, RNN) and a video-prediction RNN, from the benchmark paper.

**Later neural entries, on the same episodes** (Bortoletto et al. 2023, [[wiki/entities/irene.md]]; Hein & Diepold 2022, VT). VT: Preference **80.8**, Multi-Agent 49.2, Irrational Agent **34.1**. IRENE: Preference 48.5, Multi-Agent **74.9**, Irrational Agent **85.7**. Neither is above chance on both Preference and Irrational Agent, and IRENE consumes the *same symbolic JSON* this model does — so the handed-state-space objection (T21) does not account for the remaining gap. Note both use `max_t` MSE as expectedness while HBToM uses fitted per-latent surprise classifiers, so the columns are not strictly comparable.

**Read the baseline column, not the HBToM column.** The deep baselines sit at or *below* chance on Preference (26.3–48.3) and at chance on Multi-Agent (48.2–50.3) — the two task sets requiring information to be carried *across* familiarization trials and *keyed to an agent identity*. Where a subtask is decidable within a single trajectory (Path Control, Time Control, No Barrier) every method including Video-RNN is at 94–99.9. This is a clean dissociation: the baselines have not failed at perception, they have failed at **binding a persistent latent to an entity across episodes** — the fast-**M** function of [[wiki/concepts/complementary-learning-systems.md]]. Below chance on Preference means the nets learned the *opposite* rule, i.e. a shortcut that anti-correlates with the intended one ([[wiki/concepts/shortcut-learning.md]]).

---

## Supplied vs. learned

The audit the paper's own limitation section invites, and the reason this page does not close any gap.

| Component | Status |
|---|---|
| Environment dynamics `P(s'\|s,a)` | **Hand-written** in PDDL: discretised gridworld, unit action cost, `√2` diagonals, pick-up and key/lock semantics |
| Object and agent individuation | **Given** — "the BIB dataset provides noise-free observations… assume direct access to state variables" |
| Rationality assumption (Boltzmann-over-Q) | **Assumed**, structurally |
| Preference / efficiency *values* | **Inferred**, few-shot, from 8 trials |
| Which object is the goal on a trial | **Inferred** |
| Classifier weights `(w,b)` ×3 | **Fitted** on 220 synthetic episodes built specifically to contain implausible examples (BIB's own training split lacks them) |
| Preprocessing | Removable barriers assumed to vanish instantly; zig-zag trajectories smoothed into diagonals |

So HBToM performs no structure discovery: the graph is supplied, and what is inferred are *parameters of an agent moving over it*. In the taxonomy of [[wiki/concepts/latent-graph-discovery.md]] only **goal node** is latent; node content, edge existence, edge labels and vocabulary are all given. The comparison against pixel-level baselines is therefore not matched on inputs — a point the paper concedes only as "more upfront conceptual and engineering work" (see [[wiki/empirical-tensions.md]] T21). **The matched-input control now exists**: [[wiki/entities/irene.md]] reads the same noise-free JSON scene description, learns its dynamics implicitly, and is still at chance on Preference and 25 points down on Multi-Agent — so most of the gap is not bought by the state space. **The matched-*perception* control answers differently.** On the sibling benchmark [[wiki/entities/agent-benchmark.md]], the same two model classes run behind a trained Mask R-CNN + ResNet-34 derenderer instead of ground-truth 3-D state fall from .96 to **.65** (inverse planning) and from .90 to **.51 = chance** (neural), at a mean bounding-box IoU of 0.07. So the state space is nearly free when the alternative is *other symbols* and expensive when the alternative is *pixels*, and every number on this page is quoted in the first regime.

A variant converting 3-D observations to symbolic states is reported to perform similarly on the DARPA MCS version of BIB; no numbers are given.

---

## What it is evidence for

| Claim | Strength |
|---|---|
| **A hierarchical prior turns habituation into a conjugate update** | Strong within the domain. Dirichlet–categorical conjugacy makes "learn this agent's preference from 8 trials" exact and free; no gradient step, no replay, no capacity spent |
| **Per-entity latents solve what per-frame prediction cannot** | Strong, by the Multi-Agent dissociation: 99.2 vs. ~48–50 |
| **Structured priors beat minimal-bias learners on infant intuitions** | Real but unmatched — the structured model is handed the state space (above) |
| **Interpretability is a design payoff** | Asserted; the promised qualitative analysis (posterior reversion on a new agent, habituation to an irrational agent) was never published |

---

## Comparison to related wiki entities

| | HBToM | [[wiki/entities/bayesian-program-learning.md]] | [[wiki/entities/h-jepa.md]] |
|---|---|---|---|
| Latent object | Another agent's preferences and rationality | A stochastic motor program | A world state trajectory |
| Hierarchy | Hyperprior → per-agent params → per-trial goal | Library → concept program → token | Timescale levels of one encoder |
| Inference | Exact conjugate + 5-point grid enumeration | Approximate posterior over programs | Gradient descent on latents/actions |
| Environment model | Hand-written PDDL | Learned primitives, given relation types | Learned end-to-end |
| Evidence | 96–99.7 on BIB, benchmark hand-built for it | Human-level one-shot, passed visual Turing test | None |

---

## Open problems

- **The ablation was never run.** No evidence that all three surprise metrics are needed, or that the product form beats a sum or a max.
- **Where do the environment dynamics come from?** The stated limitation — "approximately veridical models of environmental dynamics… increases in difficulty with more realistic environments" — is the whole of latent graph discovery, restated as engineering cost.
- **Rationality is assumed, not inferred at the structural level.** `β_n` grades *how* rational; nothing entertains an agent that is not a Boltzmann planner at all (habits, norms, mistaken beliefs). Beliefs are absent from the model entirely — this is inverse planning over an MDP, not a POMDP, so false-belief tasks are out of reach.
- **Recursive nesting is claimed for the family, not demonstrated here.** No agent in HBToM reasons about another agent's reasoning.
- **The classifier is a supervised patch on a generative model.** Three fitted logistic units convert posteriors into a plausibility rating; the model itself does not say what counts as "too surprising". A fully generative account would score the test trial by its marginal likelihood alone.

---

## Connections

- **[[wiki/concepts/simulation-based-planning.md]]** — the first quantitative instance of the inverse-planning row on that page: planning is forward over an MDP, and running it backwards recovers the utilities that best explain the observed trajectory.
- **[[wiki/concepts/core-knowledge.md]]** — an explicit computational model of the **agent** core system, scored on stimuli built from the infant literature it is drawn from; and its baselines are the first deep networks in the wiki actually run on inverse-planning scenarios.
- **[[wiki/concepts/meta-learning.md]]** — hierarchical Bayes as the transfer route, made concrete: the hyperprior is the meta-graph, the per-agent parameters are the instance-graph, and the conjugate update is the inner loop with no gradient in it.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the goal-node-latent corner of the taxonomy in isolation: everything else about the graph is hand-supplied, which is exactly what makes the result readable as a claim about *use* rather than discovery.
- **[[wiki/concepts/causal-model-building.md]]** — the passive-agency channel with numbers on it: watching another agent act yields its utilities without a single action of one's own.
- **[[wiki/concepts/amortized-inference.md]]** — the counter-example that structured inference need not be slow: conjugacy plus a 5-point grid plus A\*-on-visited-states replaces sampling, so no amortisation network is required at this scale.
- **[[wiki/concepts/shortcut-learning.md]]** — below-chance behavioural cloning on Preference (26.3%) is a shortcut that anti-correlates with the intended rule, and the paired-episode protocol is what makes that visible at all.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the Multi-Agent dissociation localises the baselines' failure to fast-**M**: a per-entity latent that persists across trials and is keyed to an identity.
- **[[wiki/concepts/event-segmentation.md]]** — the per-latent surprise vector is a typed boundary signal: it says not only *that* the prediction broke but which latent to re-infer.
- **[[wiki/entities/bayesian-program-learning.md]]** — the sibling architecture from the same research programme, with the hierarchy over motor programs instead of over agents; both make the two-level split structural rather than emergent.
- **[[wiki/entities/arc-agi.md]]** — the contrasting evaluation design: ARC hides the transformation and gives the developer nothing, BIB hides an agent's dispositions and gives the modeller the entire state space, so they probe opposite halves of the discovery/use split.
- **[[wiki/entities/coin-model.md]]** — the wiki's other hierarchical-Bayes worked instance: same two-level shape (hyperprior → per-context/per-agent parameters) and the same limitation, an authored hierarchy over a hand-specified state space; it adds an *unbounded* lower level, so the number of latent entities is itself inferred.
- **[[wiki/concepts/language-of-thought.md]]** — the general form this model is a depth-one, hand-tractabilised instance of: in a universal probabilistic language `query` is itself a term, so a planning query nests inside a goal-inference query and `β`-style rationality becomes an action prior *inside the model* rather than a hyperparameter of one — at a recursion depth nobody has run past one level or costed (T183).
- **[[wiki/entities/spacetime-attractor.md]]** — the circuit-level competitor for the same function: two coupled spacetime attractors, each taking the other's inferred plan as its reward input, relax to a mutual best response — theory of mind as a fixed point rather than as an explicit posterior over utilities and rationality (Jensen et al. 2026, sketch only).
- **[[wiki/entities/irene.md]]** — the matched-input control on the same benchmark: a relational GNN + transformer reading the identical symbolic JSON, with no goal or rationality variable anywhere in it, which is what isolates the authored agent model as the source of the remaining gap (T21).
- **[[wiki/concepts/contextual-inference.md]]** — the same two-level Bayesian shape in the context domain rather than the agent domain, with the same limitation: the hierarchy is authored, not discovered.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the mechanised form of that page's social route to option discovery: inverse planning already recovers *goals* from observed trajectories, and running the same inversion over intermediate states is how a learner would import a subgoal library from a demonstrator rather than deriving one from its own rewarded trajectories (Botvinick, Niv & Barto 2009).
- **[[wiki/concepts/violation-of-expectation.md]]** — the page for the instrument this model introduced to the wiki, now with its free parameters enumerated, its untrained-network null specified, and its use on the physical domain as well as the agent one.
- **[[wiki/entities/autotom.md]]** — the same inverse-planning computation with the agent model made *latent*: variables (including the belief node this page lacks) and the length of the context window are searched per question by a posterior-entropy criterion, which is what closes the "beliefs are absent" and "recursion is claimed for the family, not demonstrated" rows above — and its fixed-model baselines (BIP-ALM 42.10, LIMP 48.94, both below a raw GPT-4o at 63.39) price what this page's authored graph costs when carried off its home domain.
- **[[wiki/entities/agent-benchmark.md]]** — the sibling benchmark from the same DARPA programme, testing the same core system in 3-D physics with cost-reward trade-offs and unobserved constraints instead of gridworld mazes; its BIPaCK baseline is this page's model class without the per-agent hierarchy, and its derenderer ablation supplies the price of the noise-free state this page is scored on.
- **[[wiki/entities/anli.md]]** — the wiki's other below-chance result and the same reading: three differently-seeded RoBERTa ensembles score 19.3 and 20.4 against a 33.3 chance level on the rounds they themselves authored, which is positive evidence of a systematic wrong belief rather than of noise — obtained there by paying humans to find it, here by pairing two continuations of one history.
