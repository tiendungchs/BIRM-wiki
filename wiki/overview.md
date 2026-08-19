# Overview — Brain-Inspired Models for Abstract Reasoning

Master synthesis. Rewritten after every ~10 ingests, or whenever a major insight changes the picture.

> **State of the wiki:** **67 sources ingested** across four waves — wave 0 (18 sources: framings, formal ceilings, measurement theory), wave 2 (31: the hippocampal-entorhinal literature and its models), wave 3 (13: memory stores, sparse codes, dendrites, cortical microcircuitry), wave 4 (in progress: credit assignment and plasticity). 44 concept pages, 30 entity pages, 46 architectural gaps, 71 empirical tensions. Per-source detail lives in the git log, in the `From` column of [[wiki/architectural-gaps.md]] and in the provenance notes at the foot of that file; **this page no longer keeps a per-ingest log** — that format did not survive 67 sources and duplicated the gap table's provenance. What follows is thematic.

---

## The Central Thesis

**A reasoning model is a two-level graph learner: a slow level that acquires the *structure* a family of environments shares, and a fast level that binds one instance of it in a handful of observations — with the two related by a factorization `p = f(g, x)` of structural position from content. The wiki's position, after 67 sources, is that every component of this is buildable except the factorization itself, that the factorization cannot be learned from data by any objective (it must be paid for in architecture), and that no instrument currently exists to certify it was obtained.**

Four independent arguments converge on the "cannot be learned" half, and they are the wiki's most load-bearing result because they arrive from different fields:

| Argument | Statement | Source of the argument |
|---|---|---|
| **Identifiability** | Shortcut and structural rules are equally consistent with any single environment, so no objective computed on one environment prefers the structural one (G16) | Shortcut learning ([[wiki/concepts/shortcut-learning.md]]) |
| **Insufficiency of the strongest bias** | The simplicity prior — provably sufficient for prediction — identifies a *short program*, not a factorization of it; the shortest program's internal variables need not correspond to the graph (G26) | Universal induction ([[wiki/concepts/universal-induction.md]]) |
| **Unreachability by the search operator** | Gradient descent optimises weights inside a fixed structure; the ingredients wanted are structural, and no algorithmic procedure searches over them (G29) | Causal model building ([[wiki/concepts/causal-model-building.md]]) |
| **Empty objective slot** | A design is an objective + a learning rule + an architecture; no quantity is known that is maximised when `g` is path-consistent and minimised when it is content-contaminated, so there is nothing for a rule to ascend (G30) | Three-component framework ([[wiki/concepts/three-component-framework.md]]) |

And a measured counterexample closes the loop: a 70 B model compresses ImageNet patches better than PNG while having no object, depth or occlusion structure at all — world-class code length with none of the graph recovered.

**The corollary the wiki operates under:** since the target must be imposed rather than discovered, biology's value is as a *prior over architectures* — a library of mechanisms that were selected for solving this problem under a sample budget — and the research programme is to work out which of them are load-bearing and at what price.

---

## Master Problem Framing: Latent Graph Discovery

**Infer the structure of a relational graph from observations, then navigate it — where the graph is never given and must be recovered from partial, aliased, or sequential evidence.** Full statement, taxonomy and the six sources of hardness: [[wiki/concepts/latent-graph-discovery.md]].

Three amendments the ingests have forced on the framing itself, all of which sharpen it rather than replace it:

- **The node set is assumed, not given** (G27). Every element of the graph formalisation presupposes discretised experience; a continuous sensorimotor stream supplies none. The two candidate discretisers — [[wiki/concepts/event-segmentation.md]] (has the representation, no criterion) and [[wiki/concepts/contextual-inference.md]] (has a principled criterion, nodes that are single scalars) — are exact complements and have never been combined.
- **One node set can carry several graphs at once.** The same 12 objects carry a learned transition graph and a lifetime semantic taxonomy, and the hippocampal formation holds both in non-overlapping territory with no conjunctive code. "The" graph is a modelling assumption.
- **The measured biological estimate is weaker than the topology and stronger than the experience.** It is a traffic-weighted predictive metric (successor-representation-like), acquired incidentally with no reward or task; it is *symmetric* even where the transitions were not; and it contains composed edges the agent never traversed, written offline during awake ripples, in the direction of credit rather than of use.

---

## Current Best Understanding

### 1. The two-timescale split is solved; the factorization is not

Fast/slow separation arrives independently from biology ([[wiki/concepts/complementary-learning-systems.md]]) and from optimization ([[wiki/concepts/meta-learning.md]]), and both are instantiated in working machines. The factorized *code* is not: where the split works it was **written down by hand** — a hyperprior with per-agent parameters adapts by exact conjugate update in 8 trials ([[wiki/entities/hbtom.md]]); a store with exponential capacity and provably convex basins has its grid modules, periods and torus topology all installed ([[wiki/entities/vector-hash.md]]). The cleanest statement available: **capacity and structure discovery are separable problems, and solving the first buys nothing toward the second.**

### 2. Structural codes exist, and their preconditions are now known

`g` has a mechanism — path integration accumulates action displacements so equal total displacement lands on the same code *by construction*, in four model families and three animal phyla ([[wiki/concepts/path-integration.md]], [[wiki/concepts/abstract-structural-codes.md]]). It has an external validation: across 203 developing humans, structural-code strength predicts matrix-reasoning score and training-to-criterion. And it has two hard preconditions the wiki now states explicitly: the domain's **actions must compose** (G41 — a bare social network has no closure and the mechanism is simply unavailable), and the space must be embeddable (G11). The abstract-domain evidence is drawn almost entirely from hand-designed continuous 2-D planes, i.e. exactly the regime where the preconditions hold trivially — so "maps outside space" is well evidenced and "grids outside space" is not ([[wiki/empirical-tensions.md]] T4, T44).

### 3. Relaxation is the wiki's most reusable primitive

[[wiki/concepts/attractor-dynamics.md]] — settling onto weight-defined fixed points — turns out to serve retrieval, de-aliasing, maintenance, sequence generation and path integration with one operation, at a cost independent of library size. Its regimes are now typed (content-defined / prestructured / orthogonalised / masked × discrete / continuous / sequential), its capacity is closed-form, and its overload behaviour is a *design choice* rather than a fact. It is also the only family in the wiki with a self-test that needs no data. What it does not supply is edges, a certificate, or any similarity structure over what it stores.

### 4. Memory has numbers; the rest of the architecture does not

Wave 3 gave the fast store an unusual status: it is the one component with derived capacities (`p_max ≈ k·C/(a ln(1/a))`), a derived sparsity schedule (`p = (2MT)^(−1/3)`), a per-retrieval confidence read-out (`|s_u|`), a separate *sequence* capacity that scales differently from item capacity, and a priced consolidation channel (`C^HBP = C^RC·a_nc/a_CA3` ≥ 12,000 afferents per cortical cell, which inverts the assumption that a sparser store is cheaper to read back). No other part of any architecture here is quantified to that standard — least of all the controllers.

### 5. Everything unbuilt is a controller

The wiki's open gaps cluster with striking regularity: the *mechanisms* exist and the thing that **sets their one free parameter** does not. When to roll out and how broadly (G15) — the adaptive attractor makes both continuous knobs with analytic thresholds, and what sets the gain is exogenous. Allocate vs. reuse (G38) — five candidate answers, one of them a closed-form schedule, none with a controller; and the actuator is now known to be a *vector* of four interneuron families, each causally tied to one feature of the code, with nothing above them. Which stored structure applies (G37) — four mechanisms, and the best of them relocates the question to a context signal the model does not contain. Which subgoal to plan toward (G33) — the configurator, whose interface is specified precisely and whose function its own author calls the most mysterious part. **The wiki's sharpest single lesson for a builder: the missing pieces are not representations, they are policies over representations.**

### 6. Credit assignment is no longer the blocker it was

Wave 4 substantially narrowed the biological-plausibility objection ([[wiki/concepts/biologically-plausible-credit-assignment.md]]). Equilibrium propagation's contrastive update is the **exact** gradient of a Helmholtz free-energy difference at any finite nudge — no small-`β`, convexity or weight-symmetry assumption ([[wiki/empirical-tensions.md]] T69) — so for any architecture whose dynamics minimise an energy, objective and learning rule are filled by one choice. What survives the narrowing is a sharper split: the model family that solves *non-locality* (~1.7–3% MNIST error with purely Hebbian updates) uniformly **assumes symmetric feedback weights**, and the family that solves *weight transport* transports the load-bearing part. No model answers both (T3).

### 7. Measurement is the binding constraint on the whole programme

Seven candidate instruments for certifying structure discovery (G17) and not one that works: i.i.d. testing cannot separate a recovered graph from a sample correlation; o.o.d. benchmarks must be revised as models learn to game them; the one *quantity* proposed is defined through Kolmogorov complexity with no approximation (G31); probing confirms containment of a structure the experimenter already had; and behavioural success — in or out of distribution — does not certify that a learner split its nodes, since networks solve aliased sequences with their states still correlated. Underneath all of it sits a **proof** that for any agent whose actions shape its data, no optimality certificate exists for any policy (G25). Bias is therefore not a concession where guarantees were never available.

---

## Key Open Problems

Ordered by how much else depends on them. Full statements in [[wiki/architectural-gaps.md]].

| | Problem | Why it is first |
|---|---|---|
| 1 | **G30 — no objective is sensitive to the factorization** | Without one the target can be built but not trained toward, and no measurement scores distance from it. Every candidate the wiki has (constrained code length, a path-commutativity residual, supervised bidirectional retrieval, the informativeness/predictability/parsimony quadruple) is named and unrun |
| 2 | **G17/G31 — nothing certifies structure discovery** | The instrument problem for the entire gap table; no gap can be shown closed without it |
| 3 | **G14 — instance structure never becomes meta structure** | The consolidation channel is the only route from the fast level to the slow one. Biology's version now has a measured *selection criterion* (weight by cross-episode recurrence and inverse visitation, not by reward) and a priced transport, and the transport is unbuilt |
| 4 | **G38/G15/G37/G33 — the missing controllers** | Four instances of one shape: a characterised mechanism with an exogenous free parameter |
| 5 | **G27 — nothing supplies the discretisation** | The node set is presupposed by every other row; two complementary halves exist and have never been joined |
| 6 | **G40 — nothing decides when to factorise and when to entangle** | Compositional codes are assumed strictly better and are not; grid cells demonstrably warp toward stable rewards, destroying transfer, and stop warping when reward configurations vary |
| 7 | **G11/G12 — the non-embeddable symbolic slice, and the router** | The framing's own stated boundary. Modular arithmetic, syntactic recursion and type-checking admit no metric embedding; the brain sorts structure types into separate territory and nothing says what reads the right one at query time |

---

## Promising Directions

- **Merge the two de-aliasing mechanisms.** A clone-structured hidden Markov model de-aliases fast, locally and without transfer ([[wiki/entities/cscg.md]]); path integration de-aliases by position and transfers but is slow to acquire ([[wiki/entities/tolman-eichenbaum-machine.md]]). Combining them is stated as the obvious next model by more than one source and has not been done.
- **Price `g` and `x` on separate budgets.** The nearest available shape for G30: minimise description length *subject to* the code being reusable across instances of a family, plus a path-commutativity residual computable from trajectories alone.
- **Tie recurrent read-out gain and recurrent learning rate to one variable, inversely.** Directly copyable from the cholinergic mechanism, and it makes the separation/completion knob a single scalar with a functional form rather than a named neuromodulator.
- **Take the replay filter seriously as a curriculum generator.** Biology's offline pass upsamples rarely-visited states and prefers remote to imminent trajectories — an inductive bias toward *transferable* content, implementable today, and orthogonal to everything machine replay currently does.
- **Steepen the read-out nonlinearity before touching anything else.** Sequence capacity moves from linear to polynomial or exponential through one scalar, with the code, sparsity and learning rule untouched — the cheapest capacity lever in the wiki.
- **Build the description channel** (G45). A verbal statement of a task's latent structure produced a hippocampal geometry indistinguishable from one discovered through experience, with new stimuli. No architecture has a channel by which a description *redirects what the learner factorises*; the cheap test is specified and unrun.
- **Energy-based framing as the unifying language.** An edge label and a latent variable are the same free variable; path search is `argmin` over a sequence of them; and equilibrium propagation then supplies objective and learning rule in one choice. This is the closest thing the wiki has to a translation between its framing and a trainable system.

---

## Major Controversies

The full list is [[wiki/empirical-tensions.md]] (71 rows). The load-bearing ones:

| # | Question | Status |
|---|---|---|
| T1 | **Does the implementation level carry computational content?** | `LEANING B`. Rebuilding a rate model in spiking neurons made three mechanisms *inexpressible in the original specification* necessary for its central representation (grid emergence 59.6% → 0.00% without neuromodulatory gain); and barn-owl coincidence detection reaches 20–25 µs precision from 250 µs potentials, a variable with no rate-level description |
| T14 | **Are structured representations real, or emergent descriptions of sub-symbolic processes?** | `LIVE` — and unresolvable by construction: the two sides make identical predictions on any single trained task and differ only on transfer, re-goaling and query richness, i.e. exactly the instruments G17 says do not yet exist |
| T16 | **Does the shortest program consistent with the data generalize?** | `LIVE`. Compression is the provably sufficient bias; policy compression is antagonistic to generalization because the shortest curriculum-optimal program discards what evaluation needs. Candidate reconciliation — compress the generator over environments, never the policy fitted to one curriculum — is an independent argument for the two-level split |
| T18 | **Must a world model be generative?** | `LIVE`. Generativity is what the richness protocol needs and precisely what prevents discarding unpredictable detail. Possibly a disagreement about *level*: generative where detail is causally relevant, not above |
| T15 | **Is training data a design lever or an anchor?** | `LIVE`. Decides whether the identifiability gap can be paid for with curated environment families at all, or must come entirely out of architecture and objective |
| T20 | **Is intelligence a property of the process or of the finished arrangement?** | `LIVE`. Decides whether hand-installed priors are free or disqualifying — and therefore whether most of this wiki's proposals count as progress |
| T53 | **Is orthogonalization of aliased states a requirement or a free choice?** | `LEANING B` on the mechanism: nothing in a prediction loss produces it; it appears only under soft winner-take-all competition or an explicit decorrelation penalty. A concrete term for the empty objective slot |
| T55/T61 | **Should a fast store's addressing be random, and are its patterns random or orthogonalised?** | `LIVE`. Random addressing is optimal only for uniform data, and every known fix makes the addressing stage data-dependent — the one thing the wiki's best stores keep random on purpose |
