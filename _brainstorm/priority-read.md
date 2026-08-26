# Priority Read — ordered reading list for the BIRM spec

**Purpose.** The wiki is 302 sources, 136 concept pages, 118 entity pages. Reading it flat dilutes context and loses the subtle rows. This file fixes a **wave order**: read one wave, fill the spec sections it feeds, then read the next. Later waves may supersede earlier fills — that is the point (`birm-spec-template.md` §11, R2).

**Rules for using this file**

| Rule | Statement |
|---|---|
| K1 | Read waves in order. Do not read ahead "for context". |
| K2 | The three registries (`wiki/overview.md`, `wiki/architectural-gaps.md`, `wiki/empirical-tensions.md`) are **reference, not prose** — never read whole; `grep` the id you need (`grep -n 'G62' wiki/architectural-gaps.md`). |
| K3 | After each wave, write ledger rows before reading further. An unfilled wave is a stop condition. |
| K4 | `raw/` reads are always allowed and never counted against the budget — but only after the page that cites the source has been read. |
| K5 | A page listed here that turns out not to feed a spec section gets struck through, with the reason, rather than deleted. |

Column `§` = the spec section the page feeds.

---

## Wave 1 — Framings (read in full; ~6 pages)

Nothing else is legible until these are held.

| # | Page | § | Why it is first |
|---|---|---|---|
| 1 | `wiki/concepts/latent-graph-discovery.md` | 1, 6 | The problem BIRM is claimed to solve, its taxonomy, and its six sources of hardness. Every other page is a mechanism for one row of it. |
| 2 | `wiki/concepts/three-component-framework.md` | 3, 9 | The spec's grammar: objective / learning rule / architecture. Every organ row in §3 is these three slots. Also supplies the task-set requirement in §1. |
| 3 | `wiki/concepts/problem-framing.md` | 1, 5.2 | Framing vs. search. Decides whether BIRM's controller is choosing actions or choosing a representation to act in. |
| 4 | `wiki/concepts/abstract-structural-codes.md` | 6 | What `g` is, and the three preconditions it needs. Read immediately before §6 is attempted. |
| 5 | `wiki/concepts/node-definition-problem.md` | 2, 6 | Why the adapter's encoding choice silently absorbs part of the graph — the strongest argument against pushing "just encoding" outside the model. |
| 6 | `wiki/concepts/skill-acquisition-efficiency.md` | 1, 10 | What "reasoning" is being scored as, and why a score without a generalization-difficulty term is uninterpretable. |

**Registry pass (grep only):** `G1 G2 G3 G16 G26 G29 G30 G34 G92` in `architectural-gaps.md`; `T14 T16 T20` in `empirical-tensions.md`.

---

## Wave 2 — Neuroscience: the organs (~10 pages)

Fills §3. Read as "what part is this, and what is it denied".

| # | Page | § | What it decides |
|---|---|---|---|
| 7 | `wiki/concepts/complementary-learning-systems.md` | 3, 9 | The two-timescale split as **two organs**, not one model with two learning rates. Decides whether S exists separately from M. |
| 8 | `wiki/concepts/cognitive-control.md` | 3-C, 4 | Controller = a sustained task model broadcast as bias into the systems doing the work. This is the shape of the C organ. |
| 9 | `wiki/concepts/working-memory.md` | 3-C, 3-S | Store vs. the process operating on it — the cut the spec's C/S boundary has to make. |
| 10 | `wiki/concepts/control-unity-and-diversity.md` | 3-C | Controller factorization axis 1: one common component + operation-specific parts, and **no** inhibition-specific part. |
| 11 | `wiki/concepts/policy-abstraction-hierarchy.md` | 3-C, 3-X | Axis 3: rostro-caudal levels searched in parallel and pruned by reward; a level exists only while it has a live choice. Feeds the arbitrator's second job. |
| 12 | `wiki/entities/medial-prefrontal-cortex.md` | 3-C, 4 | Axis 2: which code a cell carries is set by **where it projects** and is invisible in the rate. The single best argument for typing buses by reader. |
| 13 | `wiki/entities/basal-ganglia.md` | 3-C, 4-V | Action selection plus one broadcast scalar with opposite effects on two pathways. The V-bus's biological form. |
| 14 | `wiki/entities/pbwm.md` | 3-S, 5.1 | The write-enable made buildable: store in cortex, gate in basal ganglia, gating policy learned by reinforcement. The cheapest existing template for BIRM's S write. |
| 15 | `wiki/concepts/memory-read-and-erase.md` | 3-S, 5.1 | The read protocol: scheduled reads with a lead time, typed erasure. Where every machine store in the wiki is one primitive and biology runs four. |
| 16 | `wiki/concepts/default-self-model.md` + `wiki/entities/default-mode-network.md` | 3-X, 5.2 | The internally generated mode that competes with the input-driven one. This is what the arbitrator arbitrates. |

**Registry pass:** `G48 G49 G55 G58 G60 G90 G96 G98` ; `T98 T104`.

---

## Wave 3 — Neuroscience: the protocols and the buses (~9 pages)

Fills §4 and §5. The wiki's own conclusion is that the unbuilt pieces are protocols between modules, not modules — so this wave is where the spec earns most of its novelty.

| # | Page | § | What it decides |
|---|---|---|---|
| 17 | `wiki/concepts/precision-weighting.md` | 4-U, 8 | Precision as a represented quantity, read in four places. The U-bus, and the reason attention/salience/value/learning-rate may be one number. |
| 18 | `wiki/concepts/reward-prediction-error.md` | 4-V | One broadcast scalar with **no address**. Constrains what the V-bus can possibly carry. |
| 19 | `wiki/concepts/neuromodulatory-metaparameters.md` | 3-N, 8, 9 | Every hyperparameter has the topology of a diffuse broadcast; compute each set-point from the learner's own second-order statistics. The N organ. |
| 20 | `wiki/concepts/broadcast-hierarchy.md` | 4 | Depth without a chain: the top level need not reach the bottom by relay. Decides bus fan-out. |
| 21 | `wiki/entities/global-neuronal-workspace.md` + `wiki/concepts/ignition.md` | 4, 5.4 | The discrete commit: what gets broadcast and when. The arbitrator's commit discipline. |
| 22 | `wiki/concepts/transthalamic-context-routing.md` | 4 | Every direct edge mirrored by a context-carrying one — content and context on separate wires. Direct template for the Bg/Bx split. |
| 23 | `wiki/concepts/inhibitory-control-of-coding.md` | 5.1 | A single step is time-multiplexed inside itself; representation properties are set by separable inhibitory channels. Feeds the intra-step phase decision. |
| 24 | `wiki/concepts/offline-replay.md` + `wiki/concepts/recall-gated-consolidation.md` | 5.3, 9 | The S→M transport: its sampling filter, and the criterion that gates a write to the slow store. |
| 25 | `wiki/concepts/encoding-retrieval-alternation.md` | 5.1, 5.3 | Read and write cannot happen at once, and alternating fast enough makes the write gate fall out of the learning rule. |

**Registry pass:** `G14 G50 G52 G53 G54 G56 G57 G59 G64 G91` ; `T119`.

---

## Wave 4 — Neuroscience: the specific answers your design needs (~7 pages)

Targeted. Each of these answers a question you asked directly.

| # | Page | § | Question it answers |
|---|---|---|---|
| 26 | `wiki/concepts/path-integration.md` | 6 | How a structural code becomes path-consistent *by construction* rather than by a loss. |
| 27 | `wiki/concepts/arbitrary-sensorimotor-mapping.md` | 7 | "The same action does different things in different environments." The class where zero leverage exists, its dedicated network, and the trial budget (~8 trials/cue). |
| 28 | `wiki/concepts/core-knowledge.md` | 2.2, 6 | What an "instinct" actually is: domain-specific structural priors with entry conditions — and why they are structure, not encoding. Decides what may not be pushed into the adapter. |
| 29 | `wiki/concepts/motivation-representation-synergy.md` | 2.1, 8 | `expressed competence ≈ representation × motivation`. Makes your "kickstarter" a first-class second factor rather than a hack. |
| 30 | `wiki/concepts/affordance-grounded-symbols.md` | 2, 6 | Discretisation supervised by the agent's own action consequences — the only carving criterion in the wiki that comes from outside the observation stream. |
| 31 | `wiki/concepts/contextual-inference.md` | 5.4, 7 | One posterior over "which context am I in" controlling memory creation, expression and updating at once. The cheapest candidate for the rebinding trigger. |
| 32 | `wiki/concepts/attractor-dynamics.md` | 5.1, 3-S | Relaxation as the wiki's most reusable primitive, with closed-form capacity and a self-test needing no data. |

**Registry pass:** `G11 G27 G37 G38 G41 G43 G45 G47 G102 G103`.

---

## Wave 5 — Machine learning: the instantiations (~10 pages)

Only now. Each entity here is a *worked example of a wave 2–4 mechanism*; reading them earlier makes the spec a survey of models rather than a design.

| # | Page | § | What it supplies |
|---|---|---|---|
| 33 | `wiki/concepts/learned-world-models.md` | 3-M | The M organ's design space and its scoring problem. |
| 34 | `wiki/entities/tolman-eichenbaum-machine.md` | 6, 3-M | The `g`/`x` factorization actually built, and the price it pays. |
| 35 | `wiki/entities/cscg.md` | 6, 3-S | De-aliasing fast, locally, without transfer — the exact complement of #34. The merge of the two is named in the wiki as an obvious unbuilt model. |
| 36 | `wiki/entities/v-jepa-2.md` | 3-M, 5.2 | Prediction in representation space, planned on a *measured* energy surface; the only place a planner's substrate is characterised. |
| 37 | `wiki/entities/adaworld.md` | 7, 4-Act | An action alphabet induced rather than given — the action-vocabulary problem attacked from the data side. |
| 38 | `wiki/concepts/representational-collapse.md` | 6 | The filter every factorization objective must pass first. Read before writing §6's anti-collapse row. |
| 39 | `wiki/concepts/expected-free-energy.md` + `wiki/concepts/epistemic-value.md` | 8 | Exploration as a derived convex term, and the four incompatible quantities circulating under one name. |
| 40 | `wiki/concepts/temporal-abstraction-options.md` | 3-C, 5.2 | A compiled path reified as one edge — the wiki's only mechanism that *adds* structure. |
| 41 | `wiki/entities/h-jepa.md` | 3, 5 | The nearest existing whole-agent proposal to BIRM. Read as a competitor to be beaten on specifics, not as a template. |
| 42 | `wiki/concepts/cross-embodiment-transfer.md` | 7 | The five families for cutting the shared level above the body and shrinking the decoder below it. |

**Registry pass:** `G4 G5 G15 G28 G33 G62 G63 G66 G68 G69 G73` ; `T144 T157 T167 T168 T284`.

---

## Wave 6 — Measurement: the acceptance tests (~6 pages)

Fills §10. Do this **before** any implementation, not after: the wiki's standing result is that measurement, not mechanism, is the binding constraint.

| # | Page | § | What it supplies |
|---|---|---|---|
| 43 | `wiki/concepts/certification-instruments.md` | 10 | The inventory of every protocol proposed for "did it discover the structure", and why each fails. The menu §10 must choose from. |
| 44 | `wiki/concepts/objective-identifiability.md` | 10, 11 | Which loss a system optimises is not recoverable from its representations — the reason a ledger of *decisions* replaces claims about what emerged. |
| 45 | `wiki/concepts/shortcut-learning.md` | 10, 6 | Why a well-fit predictor is the default failure, not the exception. |
| 46 | `wiki/entities/arc-agi-3.md` | 1, 7, 10 | An interactive benchmark where the agent is told nothing — not the action semantics, not the goal. The closest existing instrument to BIRM's stated deployment condition. |
| 47 | `wiki/concepts/human-baseline.md` | 10 | The denominator, and the fact that it is a protocol rather than a number. |
| 48 | `wiki/concepts/rule-level-evaluation.md` | 10 | Scoring the rule a solver states alongside the answer — the cheapest instrument that is not a probe. |

**Registry pass:** `G17 G25 G31 G44 G72 G74 G89` ; `T105 T291`.

---

## Deferred — read only if a specific spec row demands it

| Cluster | Pages | Trigger for reading |
|---|---|---|
| Neuromorphic / spiking substrate | `spiking-neural-networks`, `spike-encoding-schemes`, `spike-train-error-metrics`, `circuit-size-separation`, `temporal-coding` | Only if the substrate becomes a spec decision. Wiki's own position: the advantage is unit count, not expressive power, and three of four holes are in the specification. |
| Whole-brain / connectome scale | `connectome-hubs-and-cores`, `anatomical-harmonic-modes`, `dynamic-repertoire`, `virtual-brain-twin`, `parallel-timescale-streams` | Only if §4 needs a topology argument for bus layout. |
| Consciousness theories | `integrated-information-theory`, `integrated-world-modeling-theory`, `perturbation-elicitability` | Only if the arbitrator's commit discipline (§5.4) needs more than ignition. |
| Benchmarks beyond the target set | the mathematics / graduate-science / NLI families | Only when §1 names them. |
| Credit assignment machinery | `biologically-plausible-credit-assignment`, `equilibrium-propagation`, `energy-based-models`, `meta-optimized-plasticity` | When §3's learning-rule slots are filled, not before. `equilibrium-propagation` moves up to wave 5 if the spec commits to energy-based dynamics. |

---

## Budget

| Wave | Pages | Cumulative | Spec sections closable after it |
|---|---|---|---|
| 1 | 6 | 6 | §1, §2 (partial), §6 skeleton |
| 2 | 10 | 16 | §3 |
| 3 | 9 | 25 | §4, §5 |
| 4 | 7 | 32 | §2 (complete), §6, §7 |
| 5 | 10 | 42 | §8, §9, §3 refinements |
| 6 | 6 | 48 | §10, §12 |

48 of 254 pages. Everything not listed is reachable by `grep` when a specific row needs it.
