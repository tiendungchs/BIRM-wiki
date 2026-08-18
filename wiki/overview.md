# Overview — Brain-Inspired Models for Abstract Reasoning

Master synthesis. Rewritten after every ~10 ingests, or whenever a major insight changes the picture.

> **State of the wiki:** 10 sources ingested (Hassabis et al. 2017, *Neuroscience-Inspired Artificial Intelligence*; Geirhos et al. 2020, *Shortcut Learning in Deep Neural Networks*; Schmidgall et al. 2023, *Brain-Inspired Learning in Artificial Neural Networks: a Review*; Revencu & Csibra 2023, *The Missing Link Between Core Knowledge and Language*; Hutter 2000, *A Theory of Universal Artificial Intelligence based on Algorithmic Complexity*; Spelke & Kinzler 2007, *Core Knowledge*; Butz 2016, *Toward a Unified Sub-symbolic Computational Theory of Cognition*; Lake et al. 2017, *Building Machines That Learn and Think Like People*; Richards et al. 2019, *A Deep Learning Framework for Neuroscience*; Chollet 2019, *On the Measure of Intelligence*). Sections below stay placeholders until enough sources are in to defend a thesis; the concept skeleton is listed in [[wiki/index-concepts.md]]. **Note:** per-ingest summaries for sources 6–9 were never written; this page is due a full rewrite at the next lint pass.

---

## The Central Thesis

*Empty — written once enough sources are in to state a thesis and defend it.*

---

## Master Problem Framing: Latent Graph Discovery

**Infer the structure of a relational graph from observations, then navigate it — where the graph is never given and must be recovered from partial, aliased, or sequential evidence.** Full statement, taxonomy, and the six sources of hardness: [[wiki/concepts/latent-graph-discovery.md]].

---

## Current Best Understanding

*Too early for a synthesis. What the first ingest establishes:*

- The brain is used as a **prior over architectures**, not as a specification: computational and algorithmic level transfer, implementation level is declared out of scope (contested — [[wiki/empirical-tensions.md]] T1).
- The **two-timescale split** (fast instance store / slow structural learner) arrives independently from biology (complementary learning systems) and from optimization (meta-learning), and both are instantiated in working machines. The **factorized code** `p = f(g, x)` that the framing also demands is not instantiated anywhere yet — gap G1.
- Every mechanism that has historically transferred was a *representation* or a *gating/scheduling policy*. No factorization has ever transferred ([[wiki/concepts/neuroscience-ai-transfer.md]]).

*What the second ingest establishes:*

- **The intended solution is not a function of the data.** Shortcut and structural rules are equally consistent with any single environment, so the `g`/`x` factorization the framing demands cannot be discovered — it must be bought with inductive bias, on one of exactly four levers: architecture, training data, loss, optimizer (gap G16, [[wiki/concepts/shortcut-learning.md]]).
- **The environment family is doing double duty.** It was introduced as a sample-complexity decomposition; it is also the *identifiability* condition that makes an invariant edge distinguishable from a correlational one. This is the first claim in the wiki that two independent arguments converge on the same structure.
- **Measurement is a prerequisite, not a detail.** i.i.d. benchmarks cannot separate a discovered graph from a correlation, so no architecture the wiki will ingest can be scored against the six hardness sources without an out-of-distribution test with a well-defined intended solution (gap G17).
- **Biology is not a source of immunity.** Rats, students and conditioned animals take shortcuts too. What the brain supplies is a better *prior*, which is exactly the architecture lever — and Morgan's Canon is the discipline that keeps matched behaviour from being read as matched algorithm.

*What the third ingest establishes:*

- **The update rule is now a first-class design object.** [[wiki/concepts/synaptic-plasticity.md]] (Hebb → STDP → three-factor → node perturbation → eligibility traces) is the only family that writes weights *during deployment*, which is what binding an instance-graph in-episode literally requires. [[wiki/concepts/meta-optimized-plasticity.md]] then makes the rule itself the object of an outer search — the first mechanism in the wiki where slow **W** is a *searched* object rather than a parameter blob, and the first named candidate for the third tier (gap G9, now `PARTIAL`).
- **Locality has a measured price.** Backpropagation-derived local rules generalize worse and more variably than backpropagation through time, and the deficit does not close by scaling the step size ([[wiki/empirical-tensions.md]] T7). Feedback alignment fails at ImageNet scale; only sign-symmetry matches backpropagation there, and it is the variant that still transports sign information. "Biologically plausible" and "approximates backpropagation" pull against each other.
- **The shortcut problem recurs one level down.** Every local rule is a coactivity detector, so it writes on shortcut-driven coactivity exactly as readily as on structural coactivity. Fixing gap G6 in the slow learner does not fix it in the fast store (new gap G19).
- **The weights-vs-activity question may be a change of basis.** Parameter-sharing in a meta-learner makes activations interpretable as weights, and self-attention's products can be cast as learned weight updates that implement gradient descent — so tension T2 may be about degrees of freedom and decay timescale rather than about architecture.
- **The implementation-level exclusion is now actively contested.** [[wiki/entities/spiking-neural-networks.md]] — the wiki's first entity page — argues spike timing carries more information than a rate code and that energy is a first-order constraint (T1). Its most interesting property for this wiki is unclaimed in the literature: the STDP sign flip is a substrate-level *directed*-edge detector.

*What the fourth ingest establishes:*

- **The wiki now has a "what is given" column.** [[wiki/concepts/core-knowledge.md]] supplies the concrete content of Geirhos's architecture lever: a handful of innate, domain-specific systems (objects, agents, number, geometry, social partners; the later inventory adds forms), each with its own concepts, principles and — decisively — its own **entry condition** on what it applies to. In the framing that is a *pre-installed partial meta-graph*, which is why instance binding can be one-shot. Object cognition in newborn chicks with no prior visual or tactile experience of solid objects is the wiki's first direct evidence that a relational prior is installable at all.
- **And a way to test for one.** Spelke & Kinzler 2007 identify each system by its **signature limits** — a quantitative failure profile (object set size 3–4; a numerical Weber ratio; geometry blind to colour and to movable objects) that holds across ages, species and cultures, and that survives resource stress while *learned* distinctions do not. Ported to machines that is the wiki's first proposal for certifying a prior rather than a learned structure (G17): look for a constant that does not move under scaling and domain shift, and shrink the budget to see what degrades last. Two further constraints come with it — the number system shows that a prior can fix a **format** while leaving **precision** to learning, and the conceptual-change record shows an installed prior must be **defeasible**, always overridden through an external symbol system ([[wiki/empirical-tensions.md]] T11).
- **The pre-installed graph is disconnected, and joining it is a new problem.** Core systems are encapsulated and compete for a limited attentional resource, so their outputs cannot be pooled — a content needing number, object, agent and social systems at once is unrepresentable (gap G21). Modularity has been the wiki's standing architectural stance since the first ingest; this is the first source to price it. The two candidate binders — acquired natural-language syntax vs. an innate language of thought — are in open dispute ([[wiki/empirical-tensions.md]] T8), and neither side has a criterion separating productive composition from mere association, which is gap G17's unfalsifiability defect reappearing for composition.
- **Composition is a selection problem, not only an induction problem.** External guidance undergenerates (the primitives are what everyone assumes and therefore rarely says); internal generation overgenerates (nothing says why only a handful of possible compositions are built). Granting composition postpones the combinatorial explosion rather than solving it (gap G22). **(brainstorm)** A machine need not choose: an internal composer with the corpus as *pruner* is a shape the developmental debate cannot take.
- **Priors need entry tests, and machine priors have none.** A pile of sand fails cohesion and never enters the object system; convolution's translation prior applies to every pixel regardless. Without a gate, stacking priors monotonically stacks misapplied constraints, so the architecture lever does not obviously scale (gap G23). The gate would also supply the routing policy gap G12 asks for.
- **Modules de-alias for free.** Ten-month-olds fail to individuate a duck from a truck behind an occluder and succeed with a ball and a doll — two entities typed by *different* core systems. Module membership is a discrete identity tag that does hardness source 3's work with no path integration (gap G2 gains a second answer), though it depends on exactly the simultaneous activation modularity is said to forbid.

*What the fifth ingest establishes:*

- **The ceiling has a floor under it.** [[wiki/entities/aixi.md]] covers all six hardness sources and fails on computability — but **AIXItl** removes that failure: enumerate every program of length `≤ l̃` carrying a proof that it never overrates its own expected credit, run them all, act on the highest self-certified value, at `O(2^l̃·t̃)` per cycle (gap G13 → `PARTIAL`). The transferable idea is the *selection criterion*, not the enumeration: score candidate policies by a value bound their author must certify. Verifier-scored candidate generation is the same shape, with the same failure mode — correct-but-unverifiable proposals are discarded.
- **Optimality is uncertifiable the moment the learner acts.** For passive problems the error excess is bounded by `K(µ)` alone. For active ones **no such bound exists for any policy** — Heaven & Hell (an early irreversible choice) and the needle (`2^K(µ)` candidates tried one at a time) prove it (gap G25). This is the wiki's first gap with a proof that its answer does not exist. It puts a formal floor under gap G17's measurement problem and legitimizes the whole bounded, biased, biologically-derived programme: bias is not a concession where guarantees were never available.
- **Learnability = compressibility.** The only property of the environment entering the convergence bounds is `K(µ)` — not state-space size, stochasticity, or stationarity. Hardness source 6's "a rewrite process with no compressible generator is unsolvable in principle" turns out to be the general statement, not a special case.
- **Compression does not buy structure.** The simplicity prior identifies a *short program* for the data, never a factorization of it into `g` and `x`. So the strongest bias known does not supply what gap G1 asks for (new gap G26) — the sharpest available statement of why a compression-optimal model is not automatically a reasoning model.
- **The two-level split is a capacity requirement, not a logical one.** AIXI transfers perfectly and represents no meta-level at all; the hierarchy exists because the posterior must fit in finite weights. Conversely, environment *assumptions* become a second scoring axis alongside the hardness sources: the separability hierarchy (passive → factorizable → stationary → Markovian → uniform → forgetful → farsighted → asymptotically learnable) names what an architecture is buying its guarantee with, and the useful domains sit above the Markovian line most practical architectures assume.
- **Demonstrations beat reward by exactly `K(R)` bits.** Examples are compressed into the program predicting the observation stream for free, so learning to *use* them costs `O(1)` credit; pure reinforcement must reconstruct the relation from credit alone, at `≈K(R)`. Supervised learning is therefore an emergent capability of a reinforcement learner, not a separate mechanism ([[wiki/concepts/universal-induction.md]]).
- **Planning depth is unresolved at the ideal level.** Every parameter-free horizon fails, and the unbounded limit makes even the *optimal* agent score zero on a constructible environment (gap G24). Gap G15's control policy over simulation is not merely unbuilt; its "how deep" component has no known principled answer.
- **Innateness may be a claim about timing.** Presenting knowledge `z` in the first cycle replaces `K(µ)` by `K(µ|z)`: priors and inputs are interchangeable up to an `O(1)` interpreter, so "the boundary between implementation and training is unsharp" ([[wiki/empirical-tensions.md]] T10) — with the same source supplying the counter, that evolution may have encoded incompressible information no `O(1)` program reaches.

*What the tenth ingest establishes:*

- **The wiki now has a scoring function, not just a scoring genre.** [[wiki/concepts/skill-acquisition-efficiency.md]] defines intelligence as `E[ skill · generalization-difficulty / (priors + experience) ]` — a conversion rate from information held about part of situation space into area of *future* situation space covered. Every earlier answer to gap G17 said what a good test should look like; this one says what it should measure, and gives the quantity: `GD = H(Sol^θ_T | TrainSol^opt_{T,C}) / H(Sol^θ_T)`.
- **The evaluation target is the developer, not the system.** Skill on any task known in advance is purchasable through either of two channels — hard-code the solution (unlimited priors) or dense-sample the situation space (unlimited data; a locality-sensitive hashtable suffices). So the wiki's out-of-distribution requirement is not enough: the shift must be one the *builder* did not see either. **Developer-aware generalization** is the only gameable-proof notion, and it silently invalidates most benchmark rows the wiki would otherwise have accepted.
- **Skill is an artifact; intelligence is the process that emits it.** The formalism splits a system into a program-synthesis engine and the skill program it produces, and locates intelligence exclusively in the former. Reinforcement learning's monolithic agent is what this is set against, and the practical consequence is a push toward program synthesis: [[wiki/entities/arc-agi.md]]'s intended solver is a domain-specific language search that recombines sub-programs found on earlier tasks.
- **Compression and generalization are now in open conflict.** The shortest program optimal on a curriculum discards precisely what evaluation needs; readiness for future uncertainty costs description length ([[wiki/empirical-tensions.md]] T16 against [[wiki/concepts/universal-induction.md]]). **(brainstorm)** The reconciliation on offer — compress the generator over environments, never the policy fitted to one curriculum — is an independent argument for the two-level factorization, arriving now from measurement theory rather than from sample complexity or identifiability.
- **The wiki's first benchmark page.** ARC: ~1,000 hand-authored grid tasks, ~3 examples each, evaluation set unknown to developers, priors enumerated as Spelke's four core systems and nothing else. In the taxonomy it is the pure **edge-label-latent** case with a **co-latent vocabulary** — hardness sources 1 and 2 isolated, 3–6 designed out — which is why it is the sharpest available probe of the two variables the wiki cares most about.
- **And the instrument does not yet work.** `GD`, priors and experience are all defined through Kolmogorov complexity with no approximation offered (gap G31), and ARC quantifies the difficulty of none of its own tasks. Two further gaps open with it: nothing designs the curriculum whose quality the measure says determines expressed intelligence (G32), and the universal-vs-scoped question about intelligence itself is now a live disagreement with the wiki's own formal ceiling ([[wiki/empirical-tensions.md]] T17).

---

## Key Open Problems

*Empty — promoted here from concept-page open-problem sections and from [[wiki/architectural-gaps.md]].*

---

## Promising Directions

*Empty — filled by ingests.*

---

## Major Controversies

*Empty — the load-bearing ones are promoted here from [[wiki/empirical-tensions.md]].*
