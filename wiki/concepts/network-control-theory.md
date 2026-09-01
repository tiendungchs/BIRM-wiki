# Network Control Theory — Where to Inject Energy, and What It Costs

**Given a fixed structural graph and a model of the dynamics running on it, ask an engineering question instead of a descriptive one: which nodes must be driven, with what input, to carry the system from its current state to a named target state — and what is the smallest energy that does it. The output is not a property of a node (degree, centrality) but a property of a *(driver set, source state, target state, horizon)* four-tuple, which makes "which region matters" answerable only relative to a transition someone wants.**

> **Provenance.** Two sources. (i) Bassett & Sporns 2017, *Network neuroscience*, Nat Neurosci 20(3):353–364, doi:10.1038/nn.4502 (`raw/bassett-2017-network-neuroscience.md`) — a programmatic review, not a result paper; the control material is its Figure 5 and the "Perturbation, manipulation and control" section. (ii) **Gu, Pasqualetti, Cieslak, Telesford, Yu, Kahn, Medaglia, Vettel, Miller, Grafton & Bassett 2015, *Controllability of structural brain networks*, Nat Commun 6:8414, doi:10.1038/ncomms9414 (`raw/gu-2015-controllability-structural-brain-networks.md`)** — the empirical anchor: the first application of these diagnostics to a measured human connectome, and the source of every number in the section below. The underlying engineering literature dates to the 1970s and was re-popularised by Liu, Slotine & Barabási 2011.

The wiki already measures brain-network states ([[wiki/concepts/integration-segregation-balance.md]]), catalogues their repertoire ([[wiki/concepts/dynamic-repertoire.md]]) and prices topological position ([[wiki/concepts/connectome-hubs-and-cores.md]]). None of them says *how to get from one state to another on purpose*. That is the whole content of this page, and it is the step that turns a descriptive graph statistic into a control variable.

---

## The formalism, in four lines

Linear discrete-time model on a structural adjacency `A` (normalised for stability), with `B` selecting which nodes receive input:

| Object | Definition | What it encodes |
|---|---|---|
| Dynamics | `x(t+1) = A x(t) + B u(t)` | Activity `x ∈ ℝᴺ`; `B ∈ ℝ^{N×m}` picks the `m` **driver nodes**; `u(t)` is the injected signal |
| Controllability Gramian | `W_c = Σ_{τ=0}^{T−1} A^τ B Bᵀ (Aᵀ)^τ` | Full rank ⟺ every target state is reachable in `T`; its *eigenvalues* say how cheaply, per direction |
| Minimum control energy | `E* = (x_T − A^T x_0)ᵀ W_c^{−1} (x_T − A^T x_0)` | The scalar the review calls "control energy": smallest `Σ_t ‖u(t)‖²` effecting the transition in horizon `T` |
| Three summary statistics | `trace(W_c)` (**average controllability**, easy/nearby transitions) · `φ_i = Σ_j (1 − λ_j(A)²) v_ij²` (**modal controllability**, hard/distant transitions) · recursive-Fiedler community boundary rank (**boundary controllability**, coupling/decoupling whole modules) | Three different control *goals*, not one ranking — and only the third turns out to be independent of node degree (below) |

**The reframing that carries all the weight for a builder.** Once "intervention" means "a term `Bu(t)` added to the dynamics", the review's own list of interventions collapses into one type: *optogenetics, electrical stimulation, lesions, neurofeedback, mood induction, task priming, training, and simply performing a task* are all inputs to the same equation. A task instruction and an electrode differ in `B` (where the energy lands) and in `u` (its time course), not in kind. Nothing else in the wiki puts a curriculum and a perturbation in the same units.

---

## The empirical anchor: the formalism run on a measured connectome

> Gu et al. 2015. Diffusion spectrum imaging, **8 adults scanned in triplicate**, deterministic tractography, `N = 234` Lausanne-atlas cortical + subcortical regions, edges = streamline counts, `A` stabilised by dividing by the mean edge weight, `A_ii = 0`, undirected and unsigned. Replications: an independent **85-subject** diffusion-tensor cohort, and macaque **CoCoMac** tract tracing (2,402 projections, 95 areas). Diagnostics rank-transformed per subject then averaged.

**Result 1 — the brain is controllable from a single region and it does not matter.** The smallest eigenvalue of `W_c` is `> 0` for every region taken alone (so `W_c` is invertible and every target state is formally reachable), but its mean is `2.5 × 10⁻²³` (SD `4.8 × 10⁻²³`) against a largest eigenvalue `≥ 1`. Single-node control is theoretically available and practically unusable, and the individual differences in that number are **not reproducible across scan sessions** (`p > 0.05`) — only the rank ordering is, and it varies monotonically with parcellation scale.

**This is the most important practical fact on the page and it is easy to miss.** A `10⁻²³` eigenvalue means `W_c` is catastrophically ill-conditioned, so the honest average-controllability measure `trace(W_c⁻¹)` — the one that actually equals average input energy — *cannot be numerically computed* even at `N = 234`. The paper substitutes `trace(W_c)` (the network `H₂` norm, inversely related but not the same object) explicitly for this reason. Any builder who writes `E* = Δxᵀ W_c⁻¹ Δx` on a network of realistic size is inverting a matrix with 23 orders of magnitude of dynamic range.

**Result 2 — the three diagnostics, their anatomy, and their relation to degree.**

| Diagnostic | Control goal | Top regions | Pearson `r` with weighted degree (DSI · DTI · macaque) |
|---|---|---|---|
| **Average** | Many easily reachable states, little input energy | Precuneus, posterior cingulate, superior frontal, paracentral, precentral, subcortical | **+0.91** · +0.88 · +0.90 |
| **Modal** | Difficult-to-reach states (control of *all* eigenmodes, including the poorly excitable ones) | Postcentral, supramarginal, inferior parietal, pars orbitalis, medial orbitofrontal, rostral middle frontal | **−0.99** · −0.99 · −0.99 |
| **Boundary** | Couple or decouple whole network communities | Rostral middle frontal, lateral orbitofrontal, frontal pole, medial orbitofrontal, superior frontal, anterior cingulate | **+0.13** (`p = 0.03`) · +0.008 (ns) · −0.19 (ns) |

The `r = −0.99` row is the one to stare at. **Modal controllability is, on three independent datasets and two species, a monotone relabelling of `−degree`** — and average controllability is nearly a relabelling of `+degree`. The claim that control theory supplies a *target-relative* importance score beyond centrality survives only for boundary controllability, which is the sole diagnostic orthogonal to degree. Logged as [[wiki/empirical-tensions.md]] T324.

**Result 3 — control role is a property of the cognitive system, not just of the node.** Assigning the 234 regions to eight resting-state systems (Power et al. 2011) and taking the top 30 nodes per diagnostic, normalised by system size:

| Diagnostic | Enriched system | Share of control hubs | Cognitive reading offered |
|---|---|---|---|
| Average | **Default mode** | 30% | The baseline state is the one from which most task states are cheap to reach |
| Modal | **Frontoparietal + cingulo-opercular** | 32% | Effortful switching into states no easy trajectory reaches |
| Boundary | **Ventral + dorsal attention** | 34% | Gating, synchronising and segregating whole cognitive systems |

Repeated-measures two-way ANOVA: main effect of system `F(9) = 42.40`, of diagnostic `F(2) = 22.25` (`p = 0.0013`), and the **system × diagnostic interaction `F(18) = 39.81`, `p ≈ 0`**. The interaction is the actual result — it is what makes "different systems do different control jobs" more than a re-description of where the hubs are.

**Result 4 — weak edges are the control-relevant ones for hard transitions.** The modal-controllability anticorrelation says the nodes that can drive the system into difficult-to-reach configurations are the *sparsely* connected ones. The authors marshal the converging evidence: weak-connection topology in resting fMRI classifies schizophrenia, and correlates with IQ *better* than strong-connection topology does. Every pruning-by-magnitude scheme in the wiki removes exactly this population.

**What the linear model buys and what it costs.** The authors' own defence, worth carrying because every wiki page that wants to use this formalism inherits it: (i) if the linearisation is controllable, the nonlinear system is **locally controllable**; (ii) *gain scheduling* — a bank of linear controllers each designed around one operating point, switched by an observed parameter — is the standard engineering answer for nonlinear plants and works in flight control; (iii) the same linear `A` already predicts a substantial share of resting fMRI variance (Honey et al. 2009). What it does not buy is any claim about transitions that leave the neighbourhood of the operating point, which is precisely what "difficult-to-reach state" means.

---

## The questions the formalism makes askable

| Question | Why it has no answer in graph statistics alone |
|---|---|
| Which regions can effect *which* transitions? | Controllability is target-relative; a hub can be the wrong driver for a specific target state |
| **Optimal drivers vs optimal targets** | The node you inject into and the node you want to move are different arguments, and the review separates them explicitly |
| How many control points are needed? | `rank(W_c)` question, not a degree question — and one driver may suffice or `N/2` may not |
| Which transitions does the system *prefer*? | The energy landscape's own structure: `E*` varies over target pairs, so some reconfigurations are near-free and others are not reachable at any budget in horizon `T` |
| What is `A`, when the dynamics model is unknown? | **Systems identification** — fit `A` and the dynamics jointly from regional time series. The review's flag: *the `A` recovered this way need not be the anatomical connection matrix*. Two different graphs, one name |

That last row is the sharpest methodological point in the section: the graph that governs controllability is the one that generates the observed dynamics, and the anatomical connectome is at best a prior on it ([[wiki/concepts/effective-connectivity.md]], [[wiki/concepts/function-to-structure-inference.md]]).

---

## Prediction is a prerequisite, and it comes in two flavours

The review orders the field's programme as **describe → predict → control**, and states plainly that control is only available once a predictive model exists.

| Route to prediction | Instances the review cites | Cost |
|---|---|---|
| **Black box** (machine learning on network features) | "rarely explicitly combined with network neuroscience" as of 2017 | Gives a number, not a driver set — a black-box predictor does not tell you where to inject |
| **First-principles mechanistic** (statistical physics, dynamical systems) | Therapeutic targets in cellular regulatory networks; seizure prediction in refractory epilepsy | Needs the energy landscape — which states exist, and the probability of transitioning between them |

The energy-landscape object is the one shared by both this page and [[wiki/concepts/energy-based-models.md]]: a scalar over configurations whose minima are the common states and whose barriers set the transition probabilities. The control formulation adds what the wiki's energy pages do not have — an explicit *actuator* and a budget for crossing a barrier deliberately rather than waiting for noise to do it.

---

## The one result with a topology-dependent answer

Wilson–Cowan oscillator models of large-scale seizure dynamics (Ching, Brown & Kramer 2012, via the review's Figure 6):

| Underlying structural topology | Which control strategy quiets the dynamics |
|---|---|
| Relatively **random** | **Distributed** control — inject at all stimulation sites equally, blanket suppression works |
| **Small-world** | Distributed control is *less effective*; input must be **tuned to specific driver nodes** in the regulatory or seizure-generating network |

**This is the transferable claim and it is a hard one.** Whether a broadcast control signal suffices is a function of the controlled network's topology, and the biologically realistic topology ([[wiki/concepts/small-world-topology.md]]) is the one where broadcast fails. Every global-scalar control proposal in the wiki — noradrenergic gain raising participation coefficient, a single arousal knob collapsing a recurrent store, one broadcast channel per global quantity ([[wiki/concepts/neuromodulatory-metaparameters.md]]) — is a *distributed* strategy in this taxonomy, applied to a *small-world* substrate. The review supplies the reason that combination is not obviously sufficient, and the wiki has no architecture that targets its control input at all.

A second structural finding from the same figure: epilepsy has **two** intervention targets, not one — the seizure-generating zone and a distinct **seizure-regulating** zone outside it, inferred from a spatially intricate push–pull pattern of synchronisation and desynchronisation. A controller and the thing controlled are separately addressable in the substrate, which is the anatomical form of the arbitration question [[wiki/concepts/cognitive-control.md]] asks functionally.

---

## Relevance to a reasoning model

- **`G85` gets its missing half.** That gap asks for an architecture that reads its own topology *and* grades it against demand; the measurement recipe exists (participation coefficient per window) and the actuator does not. Control theory supplies the actuator's specification exactly: a driver set `B`, an input `u(t)`, a target state, and a scalar cost `E*` to minimise. **(brainstorm)** The minimal experiment needs no new architecture: take a trained mixture-of-experts or a modular recurrent net, define the target state as the activity pattern the network shows on a task it solves, and solve for the smallest input into a chosen subset of units that drives it there from its current state. `E*` per (driver set, target) is then a *topological* diagnostic computable without gradients and without labels — a control-side counterpart to the k-core/participation statistics on [[wiki/concepts/connectome-hubs-and-cores.md]].
- **Controllability names the transition, but two of its three summary statistics do not survive the check.** `E*` is topology-based *and* target-relative, unlike every other importance measure in the wiki (saliency, ablation, Fisher information are function-based; degree, betweenness, k-core are target-free). But the *node-level summaries* people actually compute are not: average controllability is `r = +0.91` with weighted degree and modal controllability `r = −0.99`, reproduced on two imaging modalities and in macaque (Gu et al. 2015, T324). So the only diagnostic here that adds information to a degree vector is **boundary controllability** — and it is the one no wiki architecture has any analogue of, and the one whose definition (recursive Fiedler bipartition of the least-controllable subnetwork) needs no target state either. The full target-relative object `E*(driver set, x₀, x_T, T)` is untouched by this critique and remains uncomputed on anything.
- **Boundary controllability is the missing primitive, and it is the one with an architectural job description.** A boundary node's control action is *not* "move the system to state `x_T`" but "couple or decouple these two communities" — a control signal whose argument is a **partition**, not a point in state space. Nothing in the wiki emits such a signal: mixture-of-experts routers act on tokens, attention acts on positions, neuromodulatory gain acts uniformly. The biological placement (34% of boundary hubs in dorsal + ventral attention systems, and the top regions being frontal pole / lateral orbitofrontal / anterior cingulate rather than the posterior structural core) says the module-coupling controller is a *different* population from the broadcast hub — which is the anatomically-separate-controller point again, now with the controller identified.
- **The energy budget is a currency the wiki's control pages lack.** [[wiki/concepts/cognitive-control.md]] treats control as bias injection with no price; [[wiki/concepts/integration-segregation-balance.md]] shows the biological system grades routing by difficulty and [[wiki/concepts/connectome-hubs-and-cores.md]] prices routing metabolically. `E*` is the quantity that would let an agent decide whether a reconfiguration is worth performing — the resource-allocation form of "when to think hard" (`G15`).
- **(brainstorm) Planning in state space, not action space.** The control formulation is planning where the plan is a continuous input trajectory to a fixed dynamical system rather than a path over discrete edges — the same problem [[wiki/concepts/simulation-based-planning.md]] states, in the setting where the graph is fixed and known and only the *drive* is chosen. Whether a discrete path search and a minimum-energy input are two views of one object depends on whether the latent structure is embeddable, which is exactly the open bet on [[wiki/concepts/latent-graph-discovery.md]].

---

## Open problems

- **The Gramian is numerically unusable at realistic `N`.** Smallest eigenvalue `2.5 × 10⁻²³` against largest `≥ 1` at `N = 234` (Gu et al. 2015), so `W_c⁻¹` — and therefore `E*` itself, and the honest average-controllability measure `trace(W_c⁻¹)` — cannot be computed in double precision. Every reported "average controllability" in this literature is the *substitute* `trace(W_c)`. No source in the wiki says what regularisation makes `E*` computable, or what the regularised quantity then means.
- **Two of the three diagnostics are degree in disguise** (`r = +0.91`, `r = −0.99`), which means every result stated in terms of them can be restated as a result about hubs and non-hubs, and the control-theoretic vocabulary is doing interpretive rather than measurement work. T324.
- **Linearity.** Every quantity above assumes `x(t+1) = Ax + Bu`. Gu et al.'s defence is local controllability plus gain scheduling — both of which are arguments about *neighbourhoods of an operating point*, and the diagnostic being defended (modal controllability) is explicitly about states far from it. Nothing establishes that a linearised connectome model predicts a real far transition.
- **Global controllability is not measurable in an individual.** The smallest Gramian eigenvalues fail test–retest across sessions (`p > 0.05`) even though the three regional diagnostics pass and hold across five parcellation scales (83 → 1,015 regions). So the property that decides *whether* control is possible is the one property this instrument cannot estimate per subject.
- **Undirected, unsigned, single-node.** Streamline counts give a symmetric `A` with no afferent/efferent distinction and no excitation/inhibition; `B` is a single canonical vector throughout, so nothing is known about *sets* of drivers — which is the realistic case, and the authors' own named next step.
- **Which `A`.** Anatomical adjacency, an effective-connectivity estimate, or a systems-identification fit give three different matrices and three different controllability rankings, and the review explicitly warns they need not agree. No result cited settles which one the control predictions should be computed on.
- **No closed loop, and no learning.** In every application the experimenter picks the target state and the driver set. Nothing selects its own target, and nothing updates `A` from the consequences of its own control actions — which is the same open end as `G50` (the controller cannot set the gain of its own teaching signal).
- **Control energy has never been measured in an artificial network.** The formalism is cheap and fully specified; the wiki records no instance of it being applied to a trained model, so its diagnostic value is asserted rather than shown.
- **Target states are hand-specified.** "Push a diseased brain toward health" and "move the system from activation pattern A to pattern B" both presuppose that the desired state is known and representable as a vector — which is the goal-node-latent row of [[wiki/concepts/latent-graph-discovery.md]]'s taxonomy, assumed away.

---

## Connections

- **[[wiki/concepts/integration-segregation-balance.md]]** — the measurement half of the same loop: that page shows the biological network's position on a one-dimensional routing axis is graded by demand and predicts throughput, and this page supplies what would move it deliberately — a driver set, an input, and a minimum-energy cost for the transition. Together they are the two halves `G85` asks for.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — the topology the control runs on, and the page this one turns out to mostly *agree* with rather than supersede: control energy is defined relative to a named source and target where centrality is not, but the node-level summaries measured on a real connectome are `r = +0.91` (average) and `r = −0.99` (modal) with that page's weighted-degree column, so the structural core *is* the easy-transition driver set and the two vocabularies rank the same nodes (Gu et al. 2015, T324).
- **[[wiki/entities/default-mode-network.md]]** — that network's control-theoretic job description: its regions carry the highest average controllability (30% of the top-30 average-control hubs, normalised by system size), which makes the resting configuration a *pluripotent ground state* — the point in state space from which the largest number of task states are cheap to reach — rather than a state that must be suppressed before work begins.
- **[[wiki/concepts/attention.md]]** — where boundary controllability lands anatomically: 34% of boundary-control hubs sit in the dorsal and ventral attention systems, so the attention networks are positioned to emit a control signal whose argument is a *partition of the network* (couple or decouple these two communities) rather than a location or a feature — a signal type no attention mechanism in the wiki produces.
- **[[wiki/concepts/effective-connectivity.md]]** — supplies the matrix this page's predictions are only as good as: systems identification recovers an `A` that governs the dynamics and need not equal the anatomical connectome, which is that page's model-inversion argument arriving from the control side.
- **[[wiki/concepts/higher-order-interactions.md]]** — the same review's other generalisation of the graph, and a limit on this one: `x(t+1) = Ax + Bu` is dyadic by construction, so any structure carried by non-pairwise relations is invisible to the controllability calculation.
- **[[wiki/concepts/small-world-topology.md]]** — where broadcast control breaks: distributed stimulation quiets simulated seizure dynamics on a random graph and *fails* on a small-world one, so the biologically realistic topology is the regime in which control must be targeted rather than broadcast.
- **[[wiki/concepts/cognitive-control.md]]** — the functional theory this page gives an engineering statement: control as an input injected to reach a target state at minimum energy, plus an anatomical precedent for the controller and the controlled being separately addressable (the seizure-regulating zone lies outside the seizure-generating zone). Gu et al. 2015 add the placement claim that page does not make: the frontoparietal and cingulo-opercular control systems are enriched in *modal* control hubs, i.e. they are **weakly** connected non-hubs, so the cognitive controller is not sited where a broadcast bias signal would be cheapest to inject.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the use-half of that page's problem under the assumption its discovery-half is already solved: with `A` known, planning becomes minimum-energy input design rather than path search, and the target state is still latent.
- **[[wiki/concepts/network-communication-models.md]]** — the complementary half of the same problem, named as such by both reviews: control theory fixes the propagation rule in `A` and asks where to inject `u(t)` to reach a target state, while communication models fix the destination and ask how a signal finds its way there — and the biased-random-walk parameter `λ` (unbiased diffusion at `0`, shortest-path routing at `∞`) is a *targeted* one-scalar actuator, which is what this page's Wilson–Cowan result says a small-world substrate requires and what broadcast gain fails to supply.
- **[[wiki/concepts/timescale-hierarchy.md]]** — the node-heterogeneity term this page's controllability metrics omit: control energy is computed on a graph of identical nodes, and one scalar gradient of recurrent gain on a fixed connectome changes both the global timescale spectrum and which areas dominate the correlation structure when lesioned (Chaudhuri et al. 2015).
