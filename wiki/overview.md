# Overview — Brain-Inspired Models for Abstract Reasoning

Master synthesis. Rewritten after every ~10 ingests, or whenever a major insight changes the picture.

> **State of the wiki:** **125 sources ingested** across seven waves — wave 0 (15: framings, formal ceilings, measurement theory), wave 1 (3: the latent-graph framing), wave 2 (31: the hippocampal-entorhinal literature and its models), wave 3 (13: attractors, single neurons, cortical microcircuitry), wave 4 (23: credit assignment, plasticity, consolidation), wave 5 (35: the control layer — working memory and prefrontal cortex), wave 6 (4 of 22, in progress: normative theories — predictive coding, active inference, RL planning). 58 concept pages, 43 entity pages, 60 architectural gaps, 120 empirical tensions. Per-source detail lives in the git log, in the `From` column of [[wiki/architectural-gaps.md]] and in the provenance notes at the foot of that file; **this page keeps no per-ingest log** — that format did not survive 67 sources and duplicated the gap table's provenance. What follows is thematic.

---

## The Central Thesis

**A reasoning model is a two-level graph learner: a slow level that acquires the *structure* a family of environments shares, and a fast level that binds one instance of it in a handful of observations — with the two related by a factorization `p = f(g, x)` of structural position from content. The wiki's position, after 125 sources, is that every component of this is buildable except the factorization itself, that the factorization cannot be learned from data by any objective (it must be paid for in architecture), and that no instrument currently exists to certify it was obtained.**

Four independent arguments converge on the "cannot be learned" half, and they are the wiki's most load-bearing result because they arrive from different fields:

| Argument | Statement | Source of the argument |
|---|---|---|
| **Identifiability** | Shortcut and structural rules are equally consistent with any single environment, so no objective computed on one environment prefers the structural one (G16) | Shortcut learning ([[wiki/concepts/shortcut-learning.md]]) |
| **Insufficiency of the strongest bias** | The simplicity prior — provably sufficient for prediction — identifies a *short program*, not a factorization of it; the shortest program's internal variables need not correspond to the graph (G26) | Universal induction ([[wiki/concepts/universal-induction.md]]) |
| **Unreachability by the search operator** | Gradient descent optimises weights inside a fixed structure; the ingredients wanted are structural, and no algorithmic procedure searches over them (G29) | Causal model building ([[wiki/concepts/causal-model-building.md]]) |
| **Empty objective slot** | A design is an objective + a learning rule + an architecture; no quantity is known that is maximised when `g` is path-consistent and minimised when it is content-contaminated, so there is nothing for a rule to ascend (G30) | Three-component framework ([[wiki/concepts/three-component-framework.md]]) |

And a measured counterexample closes the loop: a 70 B model compresses ImageNet patches better than PNG while having no object, depth or occlusion structure at all — world-class code length with none of the graph recovered.

**The corollary the wiki operates under:** since the target must be imposed rather than discovered, biology's value is as a *prior over architectures* — a library of mechanisms that were selected for solving this problem under a sample budget — and the research programme is to work out which of them are load-bearing and at what price.

**The amendment waves 5–6 force.** The thesis is about *representations*, and the last 58 sources were almost all about something else: what reads them, what writes them, and what runs between them. The wiki's inventory of representations is now much better than its inventory of interfaces, and the gap table has moved accordingly — of the fourteen gaps opened since the last lint pass (G47–G60), eleven are about a **read, an edge, or a level boundary**, and none is about a code. The corollary is that "paid for in architecture" was under-read: the architecture that has to be paid for is not only the code's format, it is the protocol by which one module addresses another.

---

## Master Problem Framing: Latent Graph Discovery

**Infer the structure of a relational graph from observations, then navigate it — where the graph is never given and must be recovered from partial, aliased, or sequential evidence.** Full statement, taxonomy and the six sources of hardness: [[wiki/concepts/latent-graph-discovery.md]].

Four amendments the ingests have forced on the framing itself, all of which sharpen it rather than replace it:

- **The node set is assumed, not given** (G27). Every element of the graph formalisation presupposes discretised experience; a continuous sensorimotor stream supplies none. The two candidate discretisers — [[wiki/concepts/event-segmentation.md]] (has the representation, no criterion) and [[wiki/concepts/contextual-inference.md]] (has a principled criterion, nodes that are single scalars) — are exact complements and have never been combined.
- **The manifold is assumed too** (G47). Every continuous attractor in the wiki has its topology built in by translation-invariant recurrence — a ring for heading, a torus for grid modules, a plane for a concept space — so the space the graph is *embedded in* is a designer statement made before any data arrive, and the prestructured stores make it deliberately more rigid because that is what buys convex basins and exponential capacity.
- **One node set can carry several graphs at once.** The same 12 objects carry a learned transition graph and a lifetime semantic taxonomy, and the hippocampal formation holds both in non-overlapping territory with no conjunctive code. "The" graph is a modelling assumption.
- **The traversal is not atomic.** A single step is time-multiplexed inside itself: which excitatory source drives the code is handed over mid-node by two different inhibitory channels (entorhinal prediction on entry, recurrent retrieval on exit), so "estimate the graph" and "read the stored transition" are *phases within one step* rather than separable stages ([[wiki/concepts/inhibitory-control-of-coding.md]]).
- **The measured biological estimate is weaker than the topology and stronger than the experience.** It is a traffic-weighted predictive metric (successor-representation-like), acquired incidentally with no reward or task; it is *symmetric* even where the transitions were not; and it contains composed edges the agent never traversed, written offline during awake ripples, in the direction of credit rather than of use.

---

## Current Best Understanding

### 1. The two-timescale split is solved; the factorization is not

Fast/slow separation arrives independently from biology ([[wiki/concepts/complementary-learning-systems.md]]) and from optimization ([[wiki/concepts/meta-learning.md]]), and both are instantiated in working machines. The factorized *code* is not: where the split works it was **written down by hand** — a hyperprior with per-agent parameters adapts by exact conjugate update in 8 trials ([[wiki/entities/hbtom.md]]); a store with exponential capacity and provably convex basins has its grid modules, periods and torus topology all installed ([[wiki/entities/vector-hash.md]]). The cleanest statement available: **capacity and structure discovery are separable problems, and solving the first buys nothing toward the second.**

### 2. Structural codes exist, and their preconditions are now known

`g` has a mechanism — path integration accumulates action displacements so equal total displacement lands on the same code *by construction*, in four model families and three animal phyla ([[wiki/concepts/path-integration.md]], [[wiki/concepts/abstract-structural-codes.md]]). It has an external validation: across 203 developing humans, structural-code strength predicts matrix-reasoning score and training-to-criterion. And it has three hard preconditions the wiki now states explicitly: the domain's **actions must compose** (G41 — a bare social network has no closure and the mechanism is simply unavailable), the space must be embeddable (G11), and the manifold's topology must be known in advance (G47). The abstract-domain evidence is drawn almost entirely from hand-designed continuous 2-D planes, i.e. exactly the regime where all three hold trivially — so "maps outside space" is well evidenced and "grids outside space" is not ([[wiki/empirical-tensions.md]] T4, T44).

### 3. Relaxation is the wiki's most reusable primitive

[[wiki/concepts/attractor-dynamics.md]] — settling onto weight-defined fixed points — serves retrieval, de-aliasing, maintenance, sequence generation and path integration with one operation, at a cost independent of library size. Its regimes are typed, its capacity is closed-form, and its overload behaviour is a *design choice* rather than a fact. It is also the only family in the wiki with a self-test that needs no data. Wave 5 added the strongest version of the claim: a **plan can be a fixed point rather than a search** — one attractor population per future timestep, so the whole action sequence settles at once at a cost linear in horizon ([[wiki/entities/spacetime-attractor.md]]) — and wave 6 added the generative counterpart, where a hierarchical dynamical model is a cascade of attractors in which the manifold says *which sequence* and the state says *where in it* ([[wiki/concepts/predictive-coding-free-energy.md]]). What relaxation still does not supply is edges, a certificate, or similarity structure over what it stores.

### 4. Memory has numbers; the rest of the architecture does not

The fast store is the one component with derived capacities (`p_max ≈ k·C/(a ln(1/a))`), a derived sparsity schedule, a per-retrieval confidence read-out (`\|s_u\|`), a separate *sequence* capacity that scales differently from item capacity, a priced consolidation channel, and now a capacity that is **conditional on an externally supplied context mask** (≈7× the Hopfield limit under random neuronal gating, ≈30–40× under a post-hoc sign-test refinement — but only if the mask is free). No other part of any architecture here is quantified to that standard.

### 5. The unbuilt pieces are policies over representations — and, more specifically, interfaces

The wiki's open gaps cluster with striking regularity: the *mechanisms* exist and the thing that **sets their one free parameter** does not. When to roll out and how broadly (G15); allocate vs. reuse (G38); which stored structure applies (G37); which subgoal to plan toward (G33). Wave 5 kept the shape and moved its location — from the middle of a module to its boundary:

| Boundary | What biology does that no architecture here does | Gap |
|---|---|---|
| **The read** | Content is *made ready* several hundred ms before it is queried, for the specific item about to be queried; the read is cancelled when an earlier result makes it unnecessary; and erasure is addressed by relevance rather than by age or usage | G49 |
| **The query** | The template register holds whatever currently maximises expected guidance value — a learned *associate* when the target is hard to discriminate, with the target itself decodable nowhere. The query is chosen, not `encode(goal)` | G60 |
| **The pointer** | What the controller is currently pointing at is a different register from what it is holding, and a delay signal can be a pointer with no item behind it | G48 |
| **The edge** | An inter-module connection carries four separable state variables — weight, terminal gain, writability licensed by a *third* module, and a stress-set operating point — and it multiplexes content (gamma) and timing (theta) as separately lesionable channels | G52, G53, G54 |
| **The level boundary** | A lower level receives the resolved output and the protocol and is architecturally denied the observation that produced them, so the bypass mapping feudal architectures always find is unavailable by wiring rather than by loss | G59 |
| **The controller's own supply** | The control layer projects onto the neuromodulatory cell groups that set its own gain, and the teaching signal is fed back in as an *observation* as well as consumed by a plasticity rule | G50, G57 |
| **The controller's own extent** | The population carrying a control level exists only while that level has a live choice; it shrinks under single-tactic retraining and returns when the choice is restored | G58 |

**The sharpest single lesson for a builder, updated: the missing pieces are not representations, and not even policies over representations — they are protocols between modules.** Every one of the rows above is cheap to implement and none of them is implemented anywhere in the wiki.

### 6. The controller is factorized on three orthogonal axes at once

Wave 5's most transferable structural result, because the three cuts are independent and compose into one specification:

| Axis | Partition | Evidence that it is real |
|---|---|---|
| **By operation** | One common component + updating-specific + shifting-specific, and **no** inhibition-specific component | Separate genetic influences, separate receptor dependences (D1 working memory vs. D2 flexibility), double-dissociable lesion sites ([[wiki/concepts/control-unity-and-diversity.md]]) |
| **By output port** | Which code a cell carries is selected by where it projects, and is invisible in the firing rate; two projection classes in the same tissue are indistinguishable by rate and opposite in geometry | Projection-typed recording in mouse medial wall ([[wiki/entities/medial-prefrontal-cortex.md]], [[wiki/concepts/population-geometry.md]]) |
| **By order of abstraction** | Rostro-caudal levels, searched **in parallel from the first trial** and pruned by reward, each engaged only while it has a live decision | Order-specific frontal activation, tactic-selective medial premotor populations that vanish under single-tactic retraining ([[wiki/concepts/policy-abstraction-hierarchy.md]]) |

Wiki architectures sit at two extremes — one monolithic controller, or `n` fully independent ones — and none has the middle: shared machinery plus operation-specific parameters (G55).

### 7. Credit assignment is no longer the blocker, and the objective slot has its first real candidates

Equilibrium propagation's ([[wiki/concepts/equilibrium-propagation.md]]) contrastive update is the **exact** gradient of a Helmholtz free-energy difference at any finite nudge (T69), so for any architecture whose dynamics minimise an energy, objective and learning rule are filled by one choice. Two wave-6 results tighten this. First, **the objective is a precision ratio and backpropagation is one setting of one scalar**: the predictive-coding objective interpolates continuously to the backpropagation gradient as `Σ^(0) → ∞`, and that limit is *anti-biological* (it drives error-node activity to zero, which spikes cannot encode) while the usable setting costs nothing measurable (T119). Second, **expected free energy decomposes into a linear reward plus one convex term, and curiosity is that term's gradient** — so exploration stops being a tuned bonus and becomes a derived quantity, with the whole planning problem falling into the convex-MDP class ([[wiki/concepts/expected-free-energy.md]]). Neither has been run against path-consistency, which is what G30 actually asks for. What survives from wave 4 is the sharper split: the family that solves *non-locality* assumes symmetric feedback weights, and the family that solves *weight transport* transports the load-bearing part (T3).

### 8. Measurement is still the binding constraint, and wave 5 made it worse

Seven candidate instruments for certifying structure discovery (G17) and not one that works. Wave 5 added a result that undercuts the most-used class outright: a meta-reinforcement-learning agent trained only by model-free updates reproduces the two-step task's canonical model-based behavioural signature, so **model-based behaviour does not license the inference that a model-based algorithm is running** (T105). Combined with the standing finding that probing confirms containment of a structure the experimenter already had, and the proof that no optimality certificate exists for any agent whose actions shape its data (G25), the position is: **behavioural signatures, probes and i.i.d. scores have each now been shown to admit a counterexample, and nothing has replaced them.** Two new instruments did arrive, both from the biology side and both unrun on machines: *learning-trajectory* matching (the order in which a learner disambiguates its aliased states, G46) and *profile* scoring (a family of unrelated-looking failures as the signature of one degraded channel).

---

## Key Open Problems

Ordered by how much else depends on them. Full statements in [[wiki/architectural-gaps.md]].

| | Problem | Why it is first |
|---|---|---|
| 1 | **G30 — no objective is sensitive to the factorization** | Without one the target can be built but not trained toward, and no measurement scores distance from it. The candidate list is no longer empty — constrained code length, a path-commutativity residual, the free-energy difference `J(θ)`, the precision ratio `Σ^(0)`, the convex term of expected free energy — and not one has been run against path-consistency |
| 2 | **G17/G31 — nothing certifies structure discovery** | The instrument problem for the entire gap table, now with a counterexample against each surviving instrument class (T105 for behaviour, T25 for probes) |
| 3 | **G52/G53/G54/G59 — no inter-module connection has state, a licensor, a band split, or a non-bypassable narrowing** | The wiki's newest cluster and its cheapest: a third module emitting a write-mask on another pair's interface is a few lines, and nothing in the literature has tried it |
| 4 | **G48/G49/G60 — the read side of memory is one primitive where biology runs four** | Schedule, cancel, relevance-erase, and *choose the query*. Every store here is write + read-on-demand, and the capacity limit may be in the read rather than the store (T104) |
| 5 | **G14 — instance structure never becomes meta structure** | The consolidation channel is the only route from the fast level to the slow one; biology's version has a measured selection criterion and a priced transport, and the transport is unbuilt |
| 6 | **G27/G47 — nothing supplies the discretisation, and nothing learns the manifold** | The node set *and* the space it lives in are both presupposed by every other row |
| 7 | **G55/G58 — no controller is shared-plus-specific, and none is instantiated by the existence of a choice** | Both are measurement protocols as much as architectures, and both are cheap: a bifactor model over a population of trained instances, and an entropy-gated level cost |
| 8 | **G40 — nothing decides when to factorise and when to entangle** | Compositional codes are assumed strictly better and are not; grid cells warp toward stable rewards, destroying transfer, and stop warping when reward configurations vary |
| 9 | **G11/G12 — the non-embeddable symbolic slice, and the router** | The framing's own stated boundary. Modular arithmetic, syntactic recursion and type-checking admit no metric embedding; the brain sorts structure types into separate territory and nothing says what reads the right one at query time |

---

## Promising Directions

- **Give one interface state and see what happens.** The cheapest experiment in the wiki: a two-module model with a learned interface, plus a third module emitting a binary write-mask on that interface's plasticity. Measure continual-learning interference. It costs a mask, and it is the only row of G52's table that does not need an architecture change.
- **Build the level boundary as a narrowing, not as a concatenation.** Hand level `k−1` the abstract variable and the resolved output, and architecturally deny it the observation. Non-bypassability by wiring rather than by auxiliary loss — the standard feudal failure mode removed by construction (G59).
- **Merge the two de-aliasing mechanisms.** A clone-structured hidden Markov model de-aliases fast, locally and without transfer ([[wiki/entities/cscg.md]]); path integration de-aliases by position and transfers but is slow to acquire ([[wiki/entities/tolman-eichenbaum-machine.md]]). Named as the obvious next model by more than one source and never done.
- **Price `g` and `x` on separate budgets.** The nearest available shape for G30: minimise description length *subject to* the code being reusable across instances of a family, plus a path-commutativity residual computable from trajectories alone.
- **Score the learning trajectory, not the endpoint.** On one aliased task a clone model, a softmax recurrent network and a spiking Hebbian network all reach the endpoint mouse CA1 reaches, and only the *order* of disambiguation distinguishes them (G46). This is an instrument the wiki can build today and it needs no distribution shift.
- **Tie recurrent read-out gain and recurrent learning rate to one variable, inversely.** Directly copyable from the cholinergic mechanism; makes the separation/completion knob a single scalar with a functional form.
- **Take the replay filter seriously as a curriculum generator.** Biology's offline pass upsamples rarely-visited states and prefers remote to imminent trajectories — an inductive bias toward *transferable* content, implementable today, orthogonal to everything machine replay does.
- **Steepen the read-out nonlinearity before touching anything else.** Sequence capacity moves from linear to polynomial or exponential through one scalar, with code, sparsity and learning rule untouched — the cheapest capacity lever in the wiki.
- **Build the description channel** (G45). A verbal statement of a task's latent structure produced a hippocampal geometry indistinguishable from one discovered through experience. No architecture has a channel by which a description *redirects what the learner factorises*; the cheap test is specified and unrun.
- **Energy-based framing as the unifying language.** An edge label and a latent variable are the same free variable; path search is `argmin` over a sequence of them; equilibrium propagation then supplies objective and learning rule in one choice; and the precision ratio makes the choice between that and backpropagation a single scalar.

---

## Major Controversies

The full list is [[wiki/empirical-tensions.md]] (120 rows). The load-bearing ones:

| # | Question | Status |
|---|---|---|
| T1 | **Does the implementation level carry computational content?** | `LEANING B`. Rebuilding a rate model in spiking neurons made three mechanisms *inexpressible in the original specification* necessary for its central representation (grid emergence 59.6% → 0.00% without neuromodulatory gain); barn-owl coincidence detection reaches 20–25 µs precision from 250 µs potentials |
| T14 | **Are structured representations real, or emergent descriptions of sub-symbolic processes?** | `LIVE` — and unresolvable by construction: the two sides make identical predictions on any single trained task and differ only on transfer, re-goaling and query richness, i.e. exactly the instruments G17 says do not exist |
| T105 | **Does model-based *behaviour* license the inference that a model-based *algorithm* is running?** | `LIVE`, and it is the wiki's most damaging measurement result: a purely model-free meta-RL agent reproduces the canonical model-based signature. Every behavioural certificate in the gap table inherits the counterexample |
| T16 | **Does the shortest program consistent with the data generalize?** | `LIVE`. Compression is the provably sufficient bias; policy compression is antagonistic to generalization. Candidate reconciliation — compress the generator over environments, never the policy fitted to one curriculum — is an independent argument for the two-level split |
| T20 | **Is intelligence a property of the process or of the finished arrangement?** | `LIVE`. Decides whether hand-installed priors are free or disqualifying — and therefore whether most of this wiki's proposals count as progress |
| T104 | **Is the working-memory capacity limit a resource ceiling or a safety margin the system imposes on itself?** | `LIVE`, and it is directly actionable: blocking the Ca²⁺→K⁺ negative feedback pharmacologically *improves* performance, so the store was running below its achievable capacity. The machine version is one line — sweep the stability regulariser down until the network destabilises and record capacity along the way |
| T119 | **Where does the variability in a learning task enter the generative model?** | `LEANING` toward the second column, and it is what makes G30 tractable: the objective is a precision ratio, backpropagation is one setting of it, and the setting that makes them equal is anti-biological while costing nothing measurable |
| T53 | **Is orthogonalization of aliased states a requirement or a free choice?** | `LEANING B` on the mechanism: nothing in a prediction loss produces it; it appears only under soft winner-take-all competition or an explicit decorrelation penalty. A concrete term for the empty objective slot |
| T98 | **Does the episodic store address the controller by delivering content, or by setting its inhibitory gain?** | `LIVE`, and it inverts the wiki's standing picture: the channel's terminals drive feed-forward inhibition, so inactivating the store *disinhibits* the controller ([[wiki/entities/hippocampal-prefrontal-channel.md]]) |
| T55/T61 | **Should a fast store's addressing be random, and are its patterns random or orthogonalised?** | `LIVE`. Random addressing is optimal only for uniform data, and every known fix makes the addressing stage data-dependent — the one thing the wiki's best stores keep random on purpose |
