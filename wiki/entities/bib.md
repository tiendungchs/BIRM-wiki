# BIB — Baby Intuitions Benchmark

**Gridworld violation-of-expectation episodes for the core *agent* system, whose defining design move is to make the implausible continuation the **perceptually more familiar** one — so the intended answer is available only to an observer with an abstract representation of the agent, and a model without one scores measurably *below* chance rather than at it.**

> **Provenance.** Gandhi, Stojnić, Lake & Dillon 2021, *Baby Intuitions Benchmark (BIB): Discerning the goals, preferences, and actions of others* (`raw/gandhi-2021-baby-intuitions-benchmark.md`), NeurIPS 2021 (version of record; the arXiv v2 differs on three rows of Table 1). Data and code: `kanishkgandhi.com/bib`. This is the primary source for the benchmark carried second-hand on [[wiki/entities/hbtom.md]] and [[wiki/entities/irene.md]] since those ingests; the infant validation is in the companion Cognition paper (Stojnić et al. 2023) already used on [[wiki/entities/irene.md]]. Concurrent sibling: [[wiki/entities/agent-benchmark.md]] (AGENT), 3-D and physics-entangled where BIB is gridworld and navigation-only.

---

## Design — what the primary source adds beyond the results table

Three properties are invisible in the accuracy tables the wiki already carries, and all three are transferable to benchmark design outside this domain.

### 1 · The contrast pair is authored *against* perceptual similarity

| | Content |
|---|---|
| **Unexpected outcome** | Perceptually *similar* to familiarization (same trajectory, same terminal location) but conceptually implausible (wrong object) |
| **Expected outcome** | Perceptually *different* from familiarization (new trajectory, new location) with no conceptual violation |

The unexpected member is therefore the one a similarity-matching observer prefers. This inverts the usual benchmark arrangement, in which the shortcut and the intended rule are merely uncorrelated: here they are **anti-correlated by construction**, so the shortcut-following model is pushed below 50%, not to it. BC-MLP's 26.3 on Preference is the designed signature of a location-matching solver, not noise — the paper states the mechanism directly (the model "encod[es] an agent's preference for a goal location instead of a goal object"). This is the sharpest instrument in the wiki for the G17 problem of certifying *which* rule was learned, and it costs nothing beyond authoring the pair the other way round ([[wiki/concepts/shortcut-learning.md]], [[wiki/concepts/violation-of-expectation.md]]).

### 2 · Some outcomes are scored as *no expectation*, not as implausible

Multi-Agent, Inaccessible Goal and the Irrational-Agent efficiency subtask are **three-valued**, following the infant literature they replicate:

| Task | Expected | Unexpected | **No expectation** |
|---|---|---|---|
| Multi-Agent | familiar agent → its preferred object | familiar agent → nonpreferred object | *new* agent → either object (its preference was never observed) |
| Inaccessible Goal | agent → nonpreferred object while the preferred one is walled in | agent → nonpreferred object while both are accessible | — (the accessible case is the contrast) |
| Efficiency: Irrational Agent | — | *rational* agent takes an inefficient path | *irrational* agent takes an inefficient path |

Success is defined as having the right **relative** expectations, including *weak or absent* surprise where the evidence does not license any. Most machine benchmarks admit only "correct" and "incorrect"; this admits "the model should decline to predict", which is a scorable form of calibrated ignorance and the only place in the wiki where a benchmark rewards abstaining. **(brainstorm)** Any latent-variable model gets this readout for free — a posterior that stays at its prior is exactly "no expectation" — while a discriminative scorer has no way to express it, which is one reason every neural entry treats the Multi-Agent new-agent trials as ordinary trials and lands at chance.

### 3 · The train/test split is over *task composition*, and it is single and canonical

**Background training: 28,000 episodes, four tasks, expected outcomes only** (so a violation can never be learned as a category, following IntPhys and ADEPT).

| Training task | Episodes | Deliberately withheld |
|---|---|---|
| **Single-Object** — agent navigates to one object at varied locations | 10,000 | Two objects; no preference to bind |
| **No-Navigation Preference** — two objects adjacent to the agent, one consistently chosen | 10,000 | Navigation is trivial, so *navigating to a preferred object* is never trained |
| **Single-Object Multiple-Agent** — a second agent replaces the first mid-episode | 4,000 | Two objects; the new agent appears during familiarization, not only at test |
| **Agent-Blocked Instrumental Action** — key → lock → removable barrier | 4,000 | The barrier confines the **agent**, never the **object** |

Each evaluation is solvable only by *recombining* two training tasks — Preference needs navigation (Single-Object) × preference (No-Navigation) — so the generalisation demanded is compositional over task structure rather than i.i.d. over inputs. The authors contrast this explicitly with AGENT's many leave-out splits with "relatively minor differences between the training and test sets": **one canonical split, maximally distant**, versus a lattice of small ones. The two choices trade coverage against strength of claim, and the wiki now has a worked instance of each ([[wiki/entities/agent-benchmark.md]], [[wiki/entities/pgm.md]]).

The stated design intent is that background training is a *stand-in for in-lab familiarization*, not a curriculum: models may be pretrained or endowed with priors on top of it. The authors flag the asymmetry themselves — infants need eight videos where models are given tens of thousands — and note that no one has tested whether infants would *also* benefit from background training.

**Excluded by construction: RL, IL and IRL.** A model may not sample the environment; it sees only the frames in the episode, and there is no observable reward. This is not an oversight but a match to the infant condition (inference from observation without interaction), and it is why the baselines are behaviour cloning and video prediction. Meta-IRL, which the authors name as the promising direction, cannot be run for exactly this reason.

---

## The five tasks and their infant sources

| Task | Infant source | Latent the model must carry | Familiarization → test manipulation |
|---|---|---|---|
| **Preference** | Woodward 1998 | object identity of the goal, not its location | 8 trials, preferred object at a roughly fixed location; at test the two objects **swap positions** |
| **Multi-Agent** | Buresh & Woodward 2007 | preference **keyed to an agent identity** | objects at widely varying locations; at test either the same or a **new** agent acts |
| **Inaccessible Goal** | Scott & Baillargeon 2013 | goal availability under solidity | at test the preferred object is walled in on all sides, or not |
| **Instrumental Action** | Sommerville & Woodward 2005 | the *object* is the goal, the key-fetch is a means | at test the green removable barrier is absent / inconsequential / blocking |
| **Efficiency** | Gergely et al. 1995; Liu & Spelke 2017 | rationality as a property of the agent | barrier removed or moved; agent takes the efficient path, the old (now inefficient) path (*path control*), or an equal-duration inefficient path (*time control*); familiarization agent is rational or irrational |

The *time control* is the subtler of the two efficiency contrasts: the goal object starts closer so that the inefficient path takes the **same number of steps** as the efficient one, removing trial duration as a cue. Stimuli are also instantiated in 3-D (appendix A) as a perceptual-difficulty lever, unused in this paper.

---

## Baselines and the failure mechanism

Three models, all trained by passive observation: **BC-MLP** and **BC-RNN** (behaviour cloning, familiarization encoded by MLP / bidirectional LSTM), **Video-RNN** (next-frame U-Net conditioned on an RNN agent-characteristic embedding, after ToMnet, Rabinowitz et al. 2018). An offline-RL baseline (Siegel et al. 2020) with a hand-engineered distance-to-goal reward performs like BC and is dropped. Action space is 8-connected; transitions deterministic.

| BIB task | BC-MLP | BC-RNN | Video-RNN |
|---|---|---|---|
| Preference | **26.3** | 48.3 | 47.6 |
| Multi-Agent | 48.7 | 48.2 | 50.3 |
| Inaccessible Goal | 76.9 | 81.6 | 74.0 |
| Efficiency: path control | 94.0 | 92.8 | 99.2 |
| Efficiency: time control | 99.1 | 99.1 | 99.9 |
| Efficiency: irrational agent | 73.8 | 56.5 | 50.1 |
| *Efficient action average* | 88.8 | 82.5 | 83.1 |
| Instrumental: no barrier | 98.8 | 98.8 | 99.7 |
| Instrumental: inconsequential barrier | 55.2 | 78.2 | 77.0 |
| Instrumental: blocking barrier | 47.1 | 56.8 | 62.9 |
| *Instrumental action average* | 67.0 | 77.9 | 79.9 |

**The named shortcut is distance.** Both RNN models predict the agent moves to the **closer** of the two objects in about **70%** of trials, regardless of the preference established over eight familiarization trials — this single heuristic accounts for the Preference and Multi-Agent floors together. BC-MLP fails differently, binding preference to a *location* (below chance, 26.3). Two further diagnoses the paper offers, both about the training/evaluation mismatch rather than about capacity:

- The No-Navigation Preference training task places objects adjacent to the agent, so familiarization trials there are **short**; the characteristic-encoder RNN may simply not generalise to the evaluation's longer sequences. Preference is learned in training and lost at evaluation length.
- Instrumental Blocking Barrier fails because training confines the **agent** and evaluation confines the **object** — the same relation, different argument binding.

Both are relational-argument failures, not perceptual ones, and they sit next to 94–99.9% on every subtask decidable inside a single trajectory. The efficiency result is the clearest over-generalisation in the set: the models learn "agents take shortest paths" *as a law*, and therefore apply it to the **irrational** agent, where the correct response is no expectation at all (Video-RNN 50.1).

---

## The `max_t` choice, in the authors' own words

Expectedness of a test trial is the model's error at **the single step with the highest prediction error**, and the stated reason is that alternatives such as the mean over steps "consistently resulted in lower VOE scores". This is the primary-source confirmation of what [[wiki/empirical-tensions.md]] **T146** could previously only infer: the free parameter of the protocol was fixed **by the scores it produced**, at the benchmark's origin, and every number quoted on [[wiki/entities/irene.md]] and [[wiki/entities/hbtom.md]] inherits that choice. `max_t` is also the statistic most favourable to a model with one correct instant and an otherwise wrong trace.

---

## What BIB certifies, and what it does not

| Certifies | Does not certify |
|---|---|
| A relative surprise judgement with no labels, no distribution shift, no calibration | That the surprise is computed by an agent representation — [[wiki/entities/irene.md]] produces the infant-aligned direction on four tasks with no agent variable anywhere |
| **Which** rule was learned, when the pair is anti-aligned with perceptual similarity: below chance = the opposite rule | An absolute capability level: the error statistic (above), the subtask averaging, and what the model is handed (T21) are all free |
| Compositional generalisation over *task structure*, by a single maximally-distant split | Perception: the gridworld is fully observable and low-dimensional, and the structured entries read symbolic JSON. AGENT's derenderer ablation prices this and BIB has no equivalent |
| A protocol runnable on infants and machines with the same stimuli — the comparison the machine literature usually lacks | That the 28,000 background episodes are comparable to eight familiarization trials in a lab |

---

## Comparison to the sibling and successor benchmarks

| | **BIB** | [[wiki/entities/agent-benchmark.md]] (AGENT) |
|---|---|---|
| Stimuli | 2-D gridworld, overhead, minimal animacy cues | 3-D ThreeDWorld scenes with gravity, jumping, ramps |
| Core systems entangled | agent only (navigation, solidity as walls) | agent **×** object **×** physics, by design |
| Extra competencies tested | multi-agent binding, inaccessible goals, instrumental action, rational-vs-irrational agents | cost–reward trade-offs, unobserved constraints |
| Split | one canonical, maximally distant | 2×2 lattice of leave-one-type / leave-one-scenario-out |
| Human data | infants (companion paper, Stojnić et al. 2023) | 300 MTurk adults, single-rater .91, ensemble 1.00 |
| Ceiling reported | none — no adult or infant accuracy on the full battery | yes |
| Perception ablation | none | yes (.96 → .65, .90 → .51) |
| Absent | beliefs, perceptual access, false belief | same |

The two are complementary and the authors say so; no published model has been scored on both, and [[wiki/entities/irene.md]] reports that AGENT's data and code were unavailable to them.

---

## Open problems

- **No human ceiling on the battery.** The infant validation covers a subset and yields a *direction*, not an accuracy, so "above chance" has no upper reference point — the property AGENT's rater ensemble supplies and BIB does not.
- **The animacy question the authors raise is unanswered for humans too.** Whether adults or infants read these cue-free shapes (no eyes, no gaze, no sound) as intentional agents at all is untested; a low human score would reinterpret every model number here.
- **Navigation vs reaching.** The infant studies BIB adapts mostly involve *reaching* with minimal navigation. Whether a navigation context itself shifts attention from objects to locations — the exact failure BC-MLP shows — is an open empirical question about the humans, not the models.
- **The distance shortcut has no matched control.** Nothing in the benchmark isolates it: there is no version of Preference in which the preferred object is systematically the *farther* one during familiarization, which would separate "learned the preference" from "learned to go far".
- **No untrained-network null.** Every number here shares the defect [[wiki/concepts/violation-of-expectation.md]] records: chance is assumed to be 50%, never measured against randomly-initialised networks run through the same surprise pipeline.

---

## Connections

- **[[wiki/entities/hbtom.md]]** — the benchmark this page describes primarily and that page is scored on; its 96–99.7 across the battery is the only uniform column, and this page supplies what its baselines' failures actually were (a distance heuristic in ~70% of trials, and a location-bound preference).
- **[[wiki/entities/irene.md]]** — the matched-symbolic-input neural entry on these episodes, whose curriculum ablation dissects this page's four background-training tasks and finds transfer between them non-monotone; it also found the error-statistic swing this page's authors introduced.
- **[[wiki/entities/agent-benchmark.md]]** — the concurrent sibling from the same DARPA programme: same core system and same VoE protocol, but 3-D and physics-entangled, with a lattice of small splits where this page has one large one, and with the human ceiling and perception ablation this page lacks.
- **[[wiki/concepts/violation-of-expectation.md]]** — the protocol page; this page is the primary source for the `max_t` choice recorded there as an open free parameter, and it adds the design rule that makes the protocol diagnostic rather than merely label-free: author the implausible member to be the perceptually familiar one.
- **[[wiki/concepts/shortcut-learning.md]]** — the anti-aligned contrast pair is a shortcut *trap*, so below-chance scores are positive evidence of a specific wrong rule; the named shortcut here (nearest object, ~70% of trials) is the mechanism behind the wiki's below-chance Preference number.
- **[[wiki/concepts/core-knowledge.md]]** — five of the agent system's expectations turned into machine stimuli one-for-one from the infant literature that page draws on, including the rational/irrational distinction no other machine battery tests.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the graph is fully visible (gridworld, deterministic, 8-connected) and exactly two latents are hidden: which object an agent wants, and how rational it is, with the binding to agent identity as the part every neural model loses.
- **[[wiki/concepts/complementary-learning-systems.md]]** — Multi-Agent is a fast-**M** probe in benchmark form: a per-entity latent written from eight observations, retrieved by identity, and discarded when the identity changes.
- **[[wiki/concepts/compositionality.md]]** — the split is compositional over *tasks*: each evaluation is the conjunction of two training tasks (navigate × prefer), which is systematic generalisation stated at the level of the training distribution rather than of the input.
- **[[wiki/concepts/simulation-based-planning.md]]** — the benchmark's exclusion of RL/IL/IRL (no environment sampling, no observable reward) is what forces every entrant to invert a plan from observation alone rather than learn one by acting.
- **[[wiki/entities/pgm.md]]** — the other benchmark in the wiki whose split is declared over the abstraction rather than the inputs; BIB does it over task composition, PGM over `[relation, object, attribute]` triples.
- **[[wiki/entities/autotom.md]]** — the direction this page's discussion asks for and does not have: BIB stops at intentional states, and its stated natural extension (perceptions and beliefs, false belief) is exactly the variable AutoToM makes searchable.
- **[[wiki/concepts/human-baseline.md]]** — the infant baseline with no reported ceiling — looking time yields a direction, not a rate, so "above chance" on this benchmark is unbounded above.
