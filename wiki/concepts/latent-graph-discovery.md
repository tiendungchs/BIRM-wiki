# Latent Graph Discovery

**CORE PROBLEM FRAMING — The unified problem a brain-inspired reasoning model must solve.**

**Latent graph discovery = infer the structure (nodes, edges, topology) of a relational graph from observations, then navigate it — where the graph is never given explicitly and must be recovered from partial, aliased, or sequential evidence.**

This framing subsumes most cognitive tasks: abstract reasoning, analogy, planning, mathematics, navigation, and scientific discovery all reduce to recovering an implicit relational structure and using it to generate predictions, plans, or inferences.

> **Epistemic status — LGD is a *chosen lens*, not an established reduction.** It is **biologically warranted as a *substrate*** on the **metric / embeddable slice** — structure that is orderable, continuous, or transition-sampled (Constantinescu, Garvert, Park, Qu; and a *natural attractor* in ML — Nanda, Tehenan, Ivanitskiy). On the **genuinely non-embeddable symbolic slice** (modular arithmetic, syntactic recursion, type-checking) it is **untested and remains a bet**. Three rival "one-problem" reductions — program induction (Johnson), the Probabilistic Language of Thought (Goodman, backed by a *universality theorem*), and free-energy attractor dynamics (Butz, an *implementation-level* rival that contests the substrate itself) — each explain the same data and are **mutually foldable** with navigation, so **folding any of them *into* "navigation over a hypothesis graph" is a modeling choice, not a finding.** Navigation is *one of ≥3 contestable lenses at both Marr levels*, demoted-not-falsified. Read the sections below with this scoping in mind.

---

## The Graph Formalization

| Element                                      | Interpretation                                                                                                                                                                           |
| -------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Nodes**                                    | Observations / states of the world                                                                                                                                                       |
| **Edges**                                    | Transformations / actions that move between states                                                                                                                                       |
| **Edge labels**                              | The rule or operation applied (often unknown)                                                                                                                                            |
| **Topology**                                 | The relational skeleton of the domain                                                                                                                                                    |
| **Edge driver** (controllable vs. exogenous) | Whether an edge fires because the agent chose an action, or regardless of agent choice (physics, other agents, passage of time — a "no-op" action still transitions via exogenous edges) |

The graph is **never directly observable**. It must be inferred from sequences of (observation, action, next-observation) triples — or from before/after pairs alone (ARC-AGI style), where edge labels are what must be recovered.

---

## Taxonomy: What Is Latent?

Tasks differ by which graph components are hidden. This is more principled than domain enumeration: it reveals what the model must compute regardless of surface form, and predicts which task types share computational structure.

**This is a set of independent latent variables, not a partition into mutually exclusive types.** A task is a *subset* of hidden bits over the graph components below — not a single category. Most real tasks set several bits at once (FrontierMath sets three — edge-labels + path + vocabulary), so a "task type" is a **bit-vector**, and appearing in more than one row is expected, not a classification error. The old four-way list (below) is a *difficulty ladder* read off these bits, not the taxonomy itself.

### The latent variables (the actual axes)

| Latent variable | Known ↔ latent | What must be computed when latent |
|---|---|---|
| **Node content / identity** | states given vs. inferred | de-alias / infer partial state from path context |
| **Edge existence** (topology / adjacency) | which edges exist | structure learning — discover which transitions are possible |
| **Edge labels** (rule per edge) | what each edge does | single-hop function induction from endpoint pairs |
| **Edge vocabulary** (alphabet of possible labels) | operator set given vs. co-discovered | vocabulary co-discovery (hardness source 2) — invent new primitives |
| **Path** (composition connecting endpoints) | route given vs. searched | multi-hop search / planning over a *known* move-set |
| **Goal node** | target given vs. latent | infer what counts as a solution (ARC-AGI-3) |

Canonical tasks as bit-vectors: **ARC-AGI** = {edge-label, vocab ≈known (Core Knowledge), single-hop}; **ARC-AGI-3** = ARC-AGI + {goal latent, vocab latent}; **Navigation** = {path, vocab known, topology known-or-latent}; **FrontierMath** = {edge-labels, path, vocab} — three bits, the hardest *stationary* cell.

**Edge-label-latent vs. path-latent — the distinction a new reader trips on.** Both involve "edges" and both show start/end nodes, so name the two real discriminators explicitly: (a) *single edge vs. composed sequence*, and (b) *is the vocabulary known?*
- **Edge-label latent** = *single-hop rule identity.* You see **many** (start, end) **pairs** and infer the one transformation mapping input→output (ARC-AGI: given before/after grids, name the rule). The unknown is one edge label; endpoints are supplied repeatedly.
- **Path latent** = *multi-hop composition over a known move-set.* You see **one** (start, end) pair, already **know the edge vocabulary** (operators / theorems / moves), and must find the **sequence** connecting them (navigation, proof search).

### Benchmarks × what is latent (a derived reading, not a partition)

Instead of a single "primary bit" ladder, cross the canonical benchmarks (rows, grouped by family) against the six latent variables (columns). A benchmark sets **several bits at once**, so most rows carry multiple marks — that is the point, not a classification error. Difficulty still reads off the table: more ✓ in a row = harder, and the families are ordered roughly by increasing hidden mass.

**Legend:** ✓ latent (must be computed) · ◐ partial / sometimes-latent · — given.

| Benchmark family (examples) | Node content | Topology (edge existence) | Edge labels | Vocabulary (alphabet) | Path | Goal node |
|---|---|---|---|---|---|---|
| **Rule induction** — ARC-AGI, IQ tests, analogy | — | — | ✓ | — (Core Knowledge) | ◐ (grain-dependent) | — |
| **Interactive rule + goal** — ARC-AGI-3 | ◐ (self-mutated state) | — | ✓ | ✓ | ◐ | ✓ |
| **Path, known vocab** — Navigation/route-finding; AIME/HMMT; MATH | — | ◐ (nav: known-or-latent) | — | — | ✓ | — |
| **Path, partial vocab** — OlymMATH-HARD | — | — | — | ◐ | ✓ | — |
| **Node-content-latent QA** — GPQA (bio/physics/chem); algebra, physics, CSP | ✓ | — | — | — | ◐ | — |
| **Edges + path + vocab** — FrontierMath | ◐ (aliasing) | — | ✓ | ✓ | ✓ | — |
| **Topology discovery** — scientific discovery, causal learning, exploration | ◐ | ✓ | ✓ | ✓ | ✓ | ◐ |

Reading notes: **AIME/HMMT** — olympiad path over known vocabulary, largely solved by frontier models 2025–2026. **MATH** — known operator vocabulary, long chains; 3–7% frontier 2021 → ~60–80% by 2025, but MATH-Perturb shows structural path-brittleness remains. **OlymMATH-HARD** — intermediate tier (31–58% top-model 2025–2026), path over *partially*-known vocabulary. **GPQA** — google-proof design makes it a spurious-edge-suppression probe on top of latent intermediate states. **FrontierMath** — the hardest *stationary* cell (three bits set). **Topology discovery** — the deepest cell: observations only, everything downstream latent.

**What "topology given" (—) means — and does not.** The topology column marks *edge existence / adjacency only*: **must the wiring be discovered from observation, or is it determined in advance?** "Given" is the technical claim *"the adjacency is fixed by an explicit map or by known rules, so no structure-learning-from-observation is required"* — **not** the everyday claim *"the solver already knows the graph."* Three consequences that trip readers:
- **Given ≠ small / explicit / easy.** FrontierMath's theorem network is astronomically large and mostly dark to the solver, yet topology is "given" because the axioms *determine* which inference edges exist — the difficulty is finding *which theorems apply* (label), from a near-empty alphabet (vocab), along an unknown route (path), never *whether* an edge exists. Only the **Topology discovery** row has no rulebook fixing adjacency, so ✓ there means "induce the wiring from data."
- **Edge *existence* vs. edge *semantics* are orthogonal.** ARC-AGI-3 marks topology "—" because the **action affordances are enumerable** (you know your N buttons; each is a candidate transition from each state). That the *same action does different things per game* is not a topology fact — it is exactly the **edge-label ✓ + vocabulary ✓**: the button exists (topology), what it does is latent (label), the alphabet of possible effects is latent (vocab).
- **ARC-AGI path = ◐ (grain-dependent).** At the *grid→grid grain* the transformation is one atomic edge (single-hop, path given); at the *program-induction grain* the rule is a **composition of Core-Knowledge primitives**, i.e. a latent **path** through program-space, and its unbounded depth is real. Topology stays "given" under both grains (the primitive alphabet is fixed by Core Knowledge, so program-space adjacency is determined) — only the path cell flips. This is the navigation-vs-program-induction tension of §*Connection to ARC-AGI*; the coarse marking otherwise hides ARC's actual difficulty inside one label cell.

---

## Two-Level Graph Hierarchy

Every reasoning domain has two nested graph levels:

| Level              | Role                                                       | Examples                                                              |
| ------------------ | ---------------------------------------------------------- | --------------------------------------------------------------------- |
| **Meta-graph**     | Shared transition structure across all tasks in the domain | Arithmetic operators; kinship relations; ARC-AGI transformation types |
| **Instance-graph** | Task-specific topology for a single problem                | The particular equation to solve; one ARC-AGI grid pair               |

A system that conflates these levels cannot transfer: it must relearn the meta-graph rules from scratch for each new instance. Separating them is the core requirement of structural generalization.

Direct mapping to the W/M split (two learning timescales):
- **Slow W** ← meta-graph (shared structure, learned across many episodes)
- **Fast M** ← instance-graph (episode-specific, bound within a context)

And to the factorized code (TEM's factorized representations - Whittington et al):
- **g** (structural code) ← position in the meta-graph
- **x** (sensory code) ← node content
- **p = f(g, x)** ← conjunction anchoring content to graph position

---

## Six Sources of Hardness

| Source                            | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Architectural implication                                                                                                                                                                                                                                                                                                                                                                     |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Two-level entanglement**        | Meta-graph rules and instance-graph quirks co-occur in every observation; separating them requires many diverse episodes                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Factorized latent space + two distinct learning rates                                                                                                                                                                                                                                                                                                                                         |
| **Unknown vocabulary**            | The action set, node types, or both are not given; they must be inferred alongside graph structure                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | Learnable observation and transformation embeddings                                                                                                                                                                                                                                                                                                                                           |
| **Observation aliasing**          | The same observation appears at structurally distinct positions; path context must disambiguate                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | Clone cells or path-integrated identity (cscg model)                                                                                                                                                                                                                                                                                                                     |
| **Simultaneity**                  | In hardest tasks, structure must be inferred *while* navigating — no clean discovery-then-use separation                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Joint inference loop: update graph estimate and navigate concurrently                                                                                                                                                                                                                                                                                                                         |
| **Spurious edge covariate shift** | Training observations contain correlations that produce false edges (shortcuts). Canonical natural-language-inference (NLI) case: hypothesis text alone predicts the entailment label at ~72% IID accuracy (false edge H→label), bypassing the true edge P→H; ANLI's adversarial collection blocks this shortcut and accuracy drops to 42–51% (Nie et al. 2020). False edges work IID but fail OOD when the spurious correlation is broken — the model has discovered the wrong graph. Larger LLMs are *more* susceptible under direct prompting (inverse scaling), because accumulated pretraining memorization provides more shortcut paths.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Training must force invariant causal edge discovery across diverse environments; IRM / meta-learning across distribution shifts; or explicit intermediate-node traversal (chain-of-thought, CoT) to prevent single-edge shortcut paths                                                                                                                                                        |
| **Non-stationary topology**       | The edge set itself rewrites at the timescale of a *single episode* (rules change, doors open, other agents alter reachability) — violating the stationarity assumption implicitly shared by all five sources above, each of which treats the true graph as fixed-but-hidden. Distinct from cross-episode non-stationarity (absorbed by slow-W relearning) and from contextual masking of a known edge set (STA wall-gating, spacetime attractor, only inhibits already-known transitions). Not reducible to *Simultaneity* (a scheduling constraint over a graph that is fixed once inferred), *Unknown vocabulary* (edge/node *types* can be fully known while the edge-set *instance* mutates), or *Spurious edges* (stably wrong vs. correctly-present-then-absent). Defeats the *write-once* scheduling of M — not the W/M factorization itself: the instance-graph mutates *inside* the fast-M binding window, so M must become a continuously-updated state rather than a bind-then-read memory (see *Rule-State as a Dimension* below — lifting rule-config into the node restores stationarity, at a tractability cost). Contrast the controllable/exogenous edge split (edge-driver row above), which is *not* a hardness source — `a_t = ∅` selects a fixed autonomous-drift edge, so `T` stays stationary. | Discover the *stationary generator* of the topology changes (a **rewrite-graph** recursing W/M up one level), then re-infer the instance-graph online within the fast-M window; tractable only when the rewrite is legible/bounded/meta-stationary (see *Anatomy of Non-Stationary Topology* below) — truly random rewrites are unsolvable in principle. Not handled by any wiki architecture |

---

## Anatomy of Non-Stationary Topology (Source 6)

Rule-changing games are natural experiments in *what keeps a mutating edge set learnable*. Nomic (Suber 1990), Fluxx (Looney 1997), and Baba Is You / Baba Is AI (Cloos et al. 2024) all rewrite their own rules mid-play yet stay playable by humans — because none of them mutate *randomly*. Each pins four axes to their tractable pole:

| Axis | Tractable pole | Intractable pole | Game evidence |
|---|---|---|---|
| **Legibility** | rewrite is *observed* (rules are visible objects) | rewrite is *latent* — new topology must be re-inferred from behavior | Baba: rules = alignable tiles; Fluxx: New Rules face-up on table; Nomic: rules written down |
| **Driver** | agent-controlled, or bounded-stochastic | adversarial / unbounded exogenous | Baba: agent pushes tiles (controllable); Fluxx: drawn from a *fixed deck* (bounded stochastic); Nomic: propose-and-vote |
| **Meta-stationarity** | a slower, stationary *rule-for-changing-rules* exists | the mutation law itself changes arbitrarily | **Nomic's two-tier immutable/mutable hierarchy** — the key case |
| **Bounded vocabulary** | finite, known space of possible rules | unbounded / open-ended rule space | Baba: `{noun} is {property}`; Fluxx: fixed card set |

**The Nomic insight (meta-stationarity is what licenses self-amendment):** Nomic — "a game in which changing the rules is a move" — is playable *only* because "immutable" rules take logical priority and govern how mutable rules change; "all change is the product of existing rules properly applied, and none is revolutionary." A stationary (or slower-changing) meta-rule substrate preserves continuity even as the object-level edge set rewrites. Nomic also demonstrates the failure pole in-game: mutate the meta-rules far enough and you reach **paradox / undecidability** (Rule 213 — a player wins by making further play impossible), the point where even adjudication is paralyzed.

**Formal restatement — the tractability criterion:** non-stationary topology is learnable **iff the rewrite process is itself a stationary, higher-tier latent structure** — a *rewrite-graph* (meta-graph over topology-edits) that can be discovered and then used to predict future topology. This **recurses the two-level hierarchy up one level**: instance-graph (fast M) → meta-graph (slow W) → rewrite-graph (generator of instance-graph mutations, which must be stationary for anything to be learnable).

**The unsolvability boundary (why truly random rule changes are unsolvable — even for a brain):** if the edge set is resampled i.i.d. with *no compressible generator*, there is no rewrite-graph to discover; history carries zero information about the next topology. This is not AIXI's *computability* failure but an *information-theoretic* one — the environment is incompressible (maximal Kolmogorov complexity), so even AIXI is Bayes-optimal against pure noise, i.e. no better than chance. No learner, biological or artificial, can win, because there is nothing to learn. Every *playable* rule-changing game is therefore deliberately non-random: designers preserve a stationary meta-layer precisely to keep the game a discoverable structure. This validates the intuition that genuinely random topology is outside the solvable regime — the interesting engineering target is the large tractable interior (legible, bounded, meta-stationary rewrites), not the incompressible edge.

**Where current models actually fail:** Baba Is AI pins *all four* axes to their tractable pole (controllable, legible, bounded, meta-stationary) — yet GPT-4o/Gemini score ~15–20% on composing rewrites (`break→make→goto`). The current-model bottleneck sits far *below* the in-principle ceiling: models cannot plan over an edge set they themselves edit even when every edit is observable and finite. A separate, human-facing cost surfaces in Fluxx/Batman Fluxx: with 10+ simultaneous active rule-modifications, even expert players lose track of the *combined* topology — a working-memory tracking load distinct from the unsolvability pole.

---

## Rule-State as a Dimension (why Source 6 does not defeat W/M)

The apparent non-stationarity of the edge set is an **artifact of marginalizing out the rule-configuration**. Distinguish two things both loosely called "the rule":

- **(a) object-level edges currently in effect** (`rock is push`, `flag is win`) — these mutate mid-episode
- **(b) the generator that changes (a)** (Baba: "aligning tiles `X is Y` activates edge `X→Y`") — this is stationary

Correct W/M assignment restores the two-level scheme rather than breaking it:
- **(b) → slow W** (stationary rule-change generator, shared across episodes)
- **(a) → fast M** (currently-active edge set = instance-graph state, now updated *continuously* rather than written once)

**The lifting move (parallel to time-as-dimension):** define the augmented node `s' = (base_state, rule_config)`. On this lifted space **the graph is stationary again** — topology only *looked* dynamic because the rule dimension was projected out. This is the exact analogue of folding time into the node to handle reward dynamics (STA/SR); here we fold *rule-state* into the node to handle topology dynamics. Source 6 then reduces to ordinary latent graph discovery over a larger, stationary graph.

**Two catches:**

| Catch | Consequence |
|---|---|
| **State-space blowup** | Lifted space is `(base) × (rule-configs)`. Stationarity is free; *tractability* is not. Learnable only if rule-config **factorizes** and rewrite transitions are **sparse** — exactly the meta-stationary + bounded-vocabulary poles of the Anatomy table. The reduction holds precisely over the tractable interior; the unsolvable pole is "the lifted graph has no compressible generator." |
| **Genuine third tier survives** | The fold works only when (b) is expressible in the *same* vocabulary as base transitions (Baba-class: movement and rule-activation are both tile ops). When the rewrite edits the meta-graph in a way *not* expressible in object-level vocabulary — **Nomic**, where a mutable rule can change the voting rule that governs rule-changes — the immutable/mutable tiers are irreducibly distinct and a third rewrite-graph level is required. **Two levels suffice for Baba-class; three for Nomic-class self-amendment.** |

**Biological reading — reification:** the brain likely represents a *rule as a first-class object* (a node with its own factorized code) rather than as special machinery. Once a rule is an ordinary entity, "rule-change" is an ordinary edge over rule-nodes, handled by the *same* HC-entorhinal relational apparatus. The slower timescale needed for W-over-rules maps onto the cortical hierarchy of temporal receptive windows (posterior/HC = fast base task; anterior PFC = long-timescale rule context) rather than a discrete new module.

---

## Formal Ceiling: AIXI (AI with (X) induction (I))

**AIXI** (Hutter 2000) is the only known system that satisfies all six hardness sources simultaneously. It maintains a Bayesian mixture over **all computable environments** q weighted by 2^{-l(q)} — i.e., over all possible latent graphs, edge vocabularies, aliasing structures, and topologies, *including non-stationary ones* (a graph that rewrites over time is still a computable program) — and acts via expectimax to maximize universal-prior-expected credit. The full history conditions ξ^AI, so aliasing is always resolved and topology changes are simply absorbed into the environment posterior.

AIXI fails only on computability grounds: it is uncomputable. Every entry in the table below is a bounded-program approximation to it, failing on whichever hardness sources its program-search budget cannot reach.

---

## Biological Instantiation: PFC Columnar Model

Martinet et al. 2011 provide the most direct biological proof that a neural system can solve latent graph discovery from sequential observations:

| LGD element | Biological implementation |
|---|---|
| **Nodes (locations)** | Cortical minicolumns, each becoming selective to one environmental state via Hebbian learning from HC place-cell input |
| **Edges (adjacency)** | Lateral collateral synapses (ψ/φ connections) potentiated when the animal moves between two columns — edge = co-activation during locomotion |
| **Graph never given** | Animal explores; topology is inferred from sequential (position, motion, next-position) triples — exact LGD problem setup |
| **Graph search (planning)** | Spreading activation (BFS): reward signal back-propagates from goal node, decaying per edge; current-location node detects goal signal and fires; forward path signal propagates to goal |
| **Two levels** | α columns = fine spatial topology (instance graph); β columns = corridor-level topology (coarser meta-graph layer) |

**Why spreading activation = BFS:** because the goal signal decays exponentially per synaptic relay, the first signal to arrive at the current-position column has traversed the *minimum number of edges* (shortest path). This is BFS without an explicit queue — the distance-to-goal property is implemented by exponential signal decay through the graph, not by any explicit search data structure.

**HC → PFC compression as source hardness mitigation:** HC provides a redundant high-dimensional code (many place cells per location, ~85% spatial information) that the PFC columnar system compresses to a sparse topological code (~5× fewer active units). This solves the aliasing problem locally: each PFC column has a unique, non-overlapping receptive field, so observation aliasing is resolved by the compression step rather than by explicit de-aliasing (contrast: CSCG uses clone cells for the same purpose).

---

## Why Current Architectures Fail

| Architecture | Satisfies | Fails |
|---|---|---|
| Transformer | Substitutivity; powerful fast-M analog | Two-level entanglement; path-consistency; localism gap |
| Reservoir computing | Temporal memory | No structured transition rules; cannot compress meta-graph across environments |
| CSCG | De-aliasing (source 3) | No cross-environment meta-graph; two-level entanglement unaddressed |
| TEM | Two-level separation; path-consistency; factorization; de-aliasing | Pre-given action vocabulary; flat (non-hierarchical) meta-graph |
| **DNC** | Instance-graph binding (fast M externalized); sequential path retrieval (temporal links); path traversal (empirically verified: 98.8% graph traversal, 81.8% inference) | Meta-graph cross-environment learning (controller W fixed); vocabulary co-discovery; no aliasing disambiguation |
| LLMs / LRMs | In-context adaptation within training distribution | Knowledge-bounded (Choi 2026 / ARC-AGI-3): fast inner loop cannot generalize beyond pretraining envelope. **Spurious edge susceptibility**: LLMs learn false edges from pretraining statistics; larger models are *more* prone under zero-shot/few-shot ICL (LLaMA2-70B drops to 0.8% on Constituent OOD, Yuan et al. 2024). CoT prompting partially bypasses this by forcing multi-hop traversal rather than single shortcut edges. **Mathematical graph fragility** (GSM-Symbolic/GSM-Plus 2024): cannot maintain computation graph topology under modification — irrelevant node insertion causes avg 65% collapse (GSM-NoOp); reversed edge direction causes up to 20% drop (GSM-Plus reversal); failures are structural, not arithmetic (97–99% arithmetic accuracy preserved). **Structural blindness to graph edits** (MATH-Perturb 2025): when latent path structure is altered (hard perturbations requiring different solution strategies), models apply memorized edge labels from the original graph — 12–28% accuracy drops (vs. <5% for surface-only edits); subtle memorization (technique-application-without-structural-check) is distinct from verbatim copying and scales with model capability. **Non-stationary topology failure** (Baba Is AI 2024): even when rule-changes are fully legible, controllable, and bounded, GPT-4o/Gemini score ~15–20% on composing rewrites (`break→make→goto`) — they cannot plan over an edge set they themselves edit |
| **AIXI** | All six hardness sources; universal over all computable environments (including non-stationary topologies) | Uncomputable; O(t̃ · 2^{l̃}) even in bounded form |
| **LAPA (VLA latent action)** | Vocabulary co-discovery (source 2, partial): learns discrete action codebook jointly with world model from unlabeled video; VQ-VAE on frame differences discovers a finite action alphabet | Alphabet is domain-specific (manipulation video); does not generalize across environments; no meta-graph structure |
| **AdaWorld (Gao et al., ICML 2025)** | Vocabulary co-discovery (source 2): a **continuous** latent-action space learned by information bottleneck over frame pairs, reusable across renderers and embodiments; a new environment is absorbed by mapping its actions into that space (100 samples/action) | One dynamics family (egocentric physical motion) — no *structural* mismatch anywhere in the transfer set; no compositional recombination (scores ~0.00 on NEO's compositional-OOD test as `Cont-Mono`); context-invariance shown by UMAP only |
| **NEO (Baek et al., ICML 2026 Oral)** | Vocabulary co-discovery (source 2) **jointly with edge structure**: primitives *and* their semantics induced from raw `(x,y)` pairs, no DSL; compositional and length OOD; MDL picks explanation length | Synthetic domains, ≤16 primitives, short programs, deterministic execution; amortized inference is weak over long horizons (0.02 → 0.70 only with test-time search); requires a decoder for its state-grounding loss |

No *computable* architecture satisfies all six hardness sources simultaneously.

---

## Architectural Requirements

| Requirement                | Mechanism                                                                                                                                                                                                                                    |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Two-level separation       | Factorized latent space: g (meta-graph position) ≠ x (node content)                                                                                                                                                                          |
| Meta-graph learning        | Slow W update over many episodes                                                                                                                                                                                                             |
| Instance-graph binding     | Fast Hebbian M within episode                                                                                                                                                                                                                |
| De-aliasing                | Path-context-sensitive identity (clone cells or path-integrated g)                                                                                                                                                                           |
| Path-consistency           | g must commute: same meta-graph position via any path                                                                                                                                                                                        |
| Vocabulary learning        | Observation + action embeddings learnable, not fixed                                                                                                                                                                                         |
| **Causal edge invariance** | Edge labels must be learned from invariant causal structure, not i.i.d. correlations; requires training signal from diverse distribution shifts or explicit intermediate-node traversal to prevent single-hop shortcut edges from dominating |
| Multi-level hierarchy      | W itself structured as a discoverable graph (open problem)                                                                                                                                                                                   |

**CoT as latent-graph traversal (Yuan et al. 2024):** Chain-of-thought prompting reduces shortcut reliance by 15–41% on adversarial NLI. In graph terms: CoT forces the model to materialize intermediate nodes (sub-steps) rather than taking a direct shortcut edge from observation to label. This is not a mechanism for discovering the correct causal graph — the edges were already learned during pretraining — but it biases path selection toward the intended multi-hop path over the memorized single-hop shortcut. The residual shortcut reliance under CoT (still ~30–40% on Constituent OOD for most models) reveals that CoT cannot fix fundamentally incorrect edge vocabularies, only select among existing ones.

**Self-poisoning via model-generated intermediate nodes (MATH 2021):** Training on ground-truth step-by-step solutions improves test accuracy by ~10% relative, but asking models to generate their own CoT at test time *decreases* accuracy. Self-generated intermediate nodes are unreliable latent graph positions — errors at step k propagate through all subsequent steps. This is distinct from the bias-reduction effect of ground-truth CoT: ground-truth CoT prevents shortcut path selection; model-generated CoT corrupts the intermediate nodes on which subsequent traversal depends. The implication: CoT's benefit requires reliable intermediate structure, which current architectures cannot self-generate under distribution.

**Domain-module assignment for metric vs. associative graphs:** Kumaran & Maguire 2005 establish that HC engages only metric or temporal-sequential latent graphs, not purely declarative associative ones. Even when two graph-traversal tasks are matched in relational complexity and behavioral difficulty (same 14 nodes; edges differ: spatial proximity vs. social acquaintance), only the spatially-embedded graph drives HC. For a brain-inspired reasoning model, this implies a domain split within the latent-graph taxonomy: *metric/sequential latent graphs* (spatial navigation, temporal sequence traversal, path integration with continuous distances) → HC-analog module; *purely topological/declarative latent graphs* (social networks, logical propositions without sequential ordering) → mPFC/social-brain analog (STS, TPJ, temporal poles). In the task taxonomy: path-discovery over metric space → HC; pure edge-discovery in declarative associative domains → mPFC.

**Refinement — the routing key is transition-experience, and the recovered metric is the SR (Garvert et al. 2017):** A *discrete, non-spatial* graph with no continuous dimension is nonetheless reconstructed in entorhinal cortex when it is learned implicitly from **random-walk sequences** — the cleanest direct evidence the brain performs latent graph discovery unconsciously. Two consequences for the framing: (1) the HC-vs-mPFC routing key is *how the structure was acquired* — **transition-sampled (→ HC) vs. declaratively-known-without-traversal (→ mPFC)** — refining the "metric vs. declarative" split above; (2) the native distance the HC module recovers over a discovered graph is not link-distance or Euclidean but the **successor representation / communicability** (weighted sum of future states) — the discovery process reads out an SR, not a veridical adjacency. Caveats bounding how far this extends: Garvert's graph was small, 2D-planar-embeddable, and learned passively (the map stayed in HC/EC, absent from vmPFC/OFC) — it does not yet reach genuinely non-embeddable symbolic structure (modular arithmetic, syntactic recursion), which is where the "reasoning ≅ navigation" frame remains a bet.

---

## Open Problems


---

## Connections
