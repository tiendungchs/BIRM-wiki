# Network Control Theory — Where to Inject Energy, and What It Costs

**Given a fixed structural graph and a model of the dynamics running on it, ask an engineering question instead of a descriptive one: which nodes must be driven, with what input, to carry the system from its current state to a named target state — and what is the smallest energy that does it. The output is not a property of a node (degree, centrality) but a property of a *(driver set, source state, target state, horizon)* four-tuple, which makes "which region matters" answerable only relative to a transition someone wants.**

> **Provenance.** Bassett & Sporns 2017, *Network neuroscience*, Nat Neurosci 20(3):353–364, doi:10.1038/nn.4502 (`raw/bassett-2017-network-neuroscience.md`) — a programmatic review, not a result paper. The control material is its Figure 5 and the "Perturbation, manipulation and control" section; the underlying engineering literature dates to the 1970s and was re-popularised by Liu, Slotine & Barabási 2011. Equations below are the standard linear formulation the review points at rather than anything the review writes down; the wiki's dedicated empirical source (Gu et al. 2015) is queued and not yet ingested.

The wiki already measures brain-network states ([[wiki/concepts/integration-segregation-balance.md]]), catalogues their repertoire ([[wiki/concepts/dynamic-repertoire.md]]) and prices topological position ([[wiki/concepts/connectome-hubs-and-cores.md]]). None of them says *how to get from one state to another on purpose*. That is the whole content of this page, and it is the step that turns a descriptive graph statistic into a control variable.

---

## The formalism, in four lines

Linear discrete-time model on a structural adjacency `A` (normalised for stability), with `B` selecting which nodes receive input:

| Object | Definition | What it encodes |
|---|---|---|
| Dynamics | `x(t+1) = A x(t) + B u(t)` | Activity `x ∈ ℝᴺ`; `B ∈ ℝ^{N×m}` picks the `m` **driver nodes**; `u(t)` is the injected signal |
| Controllability Gramian | `W_c = Σ_{τ=0}^{T−1} A^τ B Bᵀ (Aᵀ)^τ` | Full rank ⟺ every target state is reachable in `T`; its *eigenvalues* say how cheaply, per direction |
| Minimum control energy | `E* = (x_T − A^T x_0)ᵀ W_c^{−1} (x_T − A^T x_0)` | The scalar the review calls "control energy": smallest `Σ_t ‖u(t)‖²` effecting the transition in horizon `T` |
| Two summary statistics | `trace(W_c)` (**average controllability**, easy/nearby transitions) · smallest eigenvector weight (**modal controllability**, hard/distant transitions) | A node can be good at one and bad at the other — they are different jobs, not one ranking |

**The reframing that carries all the weight for a builder.** Once "intervention" means "a term `Bu(t)` added to the dynamics", the review's own list of interventions collapses into one type: *optogenetics, electrical stimulation, lesions, neurofeedback, mood induction, task priming, training, and simply performing a task* are all inputs to the same equation. A task instruction and an electrode differ in `B` (where the energy lands) and in `u` (its time course), not in kind. Nothing else in the wiki puts a curriculum and a perturbation in the same units.

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
- **Controllability is a better importance score than centrality, because it names the transition.** Every importance measure in the wiki is either function-based (saliency, ablation, Fisher information) or topology-based-but-target-free (degree, betweenness, k-core). `E*` is topology-based *and* target-relative, and it is the only one that answers "important for getting **where**".
- **The energy budget is a currency the wiki's control pages lack.** [[wiki/concepts/cognitive-control.md]] treats control as bias injection with no price; [[wiki/concepts/integration-segregation-balance.md]] shows the biological system grades routing by difficulty and [[wiki/concepts/connectome-hubs-and-cores.md]] prices routing metabolically. `E*` is the quantity that would let an agent decide whether a reconfiguration is worth performing — the resource-allocation form of "when to think hard" (`G15`).
- **(brainstorm) Planning in state space, not action space.** The control formulation is planning where the plan is a continuous input trajectory to a fixed dynamical system rather than a path over discrete edges — the same problem [[wiki/concepts/simulation-based-planning.md]] states, in the setting where the graph is fixed and known and only the *drive* is chosen. Whether a discrete path search and a minimum-energy input are two views of one object depends on whether the latent structure is embeddable, which is exactly the open bet on [[wiki/concepts/latent-graph-discovery.md]].

---

## Open problems

- **Linearity.** Every quantity above assumes `x(t+1) = Ax + Bu`. The review notes the dynamics may be linear or nonlinear and does not say what survives; nothing here establishes that a linearised connectome model predicts real transitions.
- **Which `A`.** Anatomical adjacency, an effective-connectivity estimate, or a systems-identification fit give three different matrices and three different controllability rankings, and the review explicitly warns they need not agree. No result cited settles which one the control predictions should be computed on.
- **No closed loop, and no learning.** In every application the experimenter picks the target state and the driver set. Nothing selects its own target, and nothing updates `A` from the consequences of its own control actions — which is the same open end as `G50` (the controller cannot set the gain of its own teaching signal).
- **Control energy has never been measured in an artificial network.** The formalism is cheap and fully specified; the wiki records no instance of it being applied to a trained model, so its diagnostic value is asserted rather than shown.
- **Target states are hand-specified.** "Push a diseased brain toward health" and "move the system from activation pattern A to pattern B" both presuppose that the desired state is known and representable as a vector — which is the goal-node-latent row of [[wiki/concepts/latent-graph-discovery.md]]'s taxonomy, assumed away.

---

## Connections

- **[[wiki/concepts/integration-segregation-balance.md]]** — the measurement half of the same loop: that page shows the biological network's position on a one-dimensional routing axis is graded by demand and predicts throughput, and this page supplies what would move it deliberately — a driver set, an input, and a minimum-energy cost for the transition. Together they are the two halves `G85` asks for.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — the topology the control runs on, and the reason a target-free importance score is not enough: six graph measures agree on which nodes are central, but centrality is computed without reference to any transition, whereas control energy is defined only relative to a named source and target pair.
- **[[wiki/concepts/effective-connectivity.md]]** — supplies the matrix this page's predictions are only as good as: systems identification recovers an `A` that governs the dynamics and need not equal the anatomical connectome, which is that page's model-inversion argument arriving from the control side.
- **[[wiki/concepts/higher-order-interactions.md]]** — the same review's other generalisation of the graph, and a limit on this one: `x(t+1) = Ax + Bu` is dyadic by construction, so any structure carried by non-pairwise relations is invisible to the controllability calculation.
- **[[wiki/concepts/small-world-topology.md]]** — where broadcast control breaks: distributed stimulation quiets simulated seizure dynamics on a random graph and *fails* on a small-world one, so the biologically realistic topology is the regime in which control must be targeted rather than broadcast.
- **[[wiki/concepts/cognitive-control.md]]** — the functional theory this page gives an engineering statement: control as an input injected to reach a target state at minimum energy, plus an anatomical precedent for the controller and the controlled being separately addressable (the seizure-regulating zone lies outside the seizure-generating zone).
- **[[wiki/concepts/latent-graph-discovery.md]]** — the use-half of that page's problem under the assumption its discovery-half is already solved: with `A` known, planning becomes minimum-energy input design rather than path search, and the target state is still latent.
