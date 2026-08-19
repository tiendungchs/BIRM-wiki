# Predictive Coding and Free-Energy-Based Inference

**One update rule for perception, learning, action and thought: maintain a generative model, propagate only the residual between top-down prediction and bottom-up signal, and minimise that residual by changing activity (fast), weights (slow), or the world itself (action).**

The wiki's core framing names *free-energy attractor dynamics* as one of the rival one-problem reductions to latent graph discovery ([[wiki/concepts/latent-graph-discovery.md]]). This page is that rival stated in full. Its main source (Butz 2016) argues the reduction **does not work on its own**: free-energy minimisation is a learning principle with no preference over *which* structures develop, so it must be supplemented with **structural priors** that force distinct encoding types into existence. That claim is the page's load-bearing content.

---

## The update

Strict hierarchy of layers `S_i`, with `S_0 = X` the sensory layer, activity `y^{S_i}`, forward weights `W^{S_i}`:

```
y^{S_i} ← (1 − α − β)·y^{S_i}  +  γ·W^{S_i}·e^{S_{i−1}}  +  β·(W^{S_{i+1}})^T·y^{S_{i+1}}      (1)
e^{S_{i−1}} = y^{S_{i−1}} − (W^{S_i})^T·y^{S_i}                                                (2)
```

- `y` = the **currently active** predictive encodings; `W` = the set of encodings that are *possible* at all. Activity is the instance; weights are the model.
- Two adaptation timescales fall out of one objective: fast error-minimisation over `y`, slow error-minimisation over `W`. This is the wiki's fast **M** / slow **W** split derived from an inference principle rather than from interference ([[wiki/concepts/complementary-learning-systems.md]]) or sample complexity.

**α, β, γ are precision gates, not constants.** Setting them by relative precision (inverse variance) makes one equation cover four regimes:

| Setting | Regime | Use |
|---|---|---|
| `α = β = γ = 0` | maintenance under no evidence | holding a state across a gap — working memory as a limit case |
| `β > 0` | predictive-coding update | ordinary top-down constraint |
| `β < 0` | biased competition | top-down disambiguation of ambiguous input (Kanizsa illusory contours) |
| `γ ↑` | bottom-up error correction | high sensory precision dominates |
| `γ → 0`, `β ≪ 0` | **decoupling from sensation** | imagination, planning, mental simulation |

The last row is the operational point: **the same circuit becomes a simulator by turning two scalars**, with no separate imagination machinery. See [[wiki/concepts/simulation-based-planning.md]].

---

## Three structural priors (the paper's central proposal)

Free-energy minimisation is indifferent to what kind of encoding forms. Butz 2016 proposes that development must be biased — genetically — toward exactly three encoding types, from which all others compose:

| Encoding type | Predicts | Anatomy claimed | Graph element |
|---|---|---|---|
| **Top-down** | item-specific sensory signals / feature constellations, generalising over space | ventral stream, inferior temporal cortex, fusiform face area; position- and format-invariant identity cells | **node content `x`**, at multiple abstraction levels |
| **Spatial** | mappings of one predictive encoding onto another, posture-dependently, across frames of reference | dorsal stream, posterior parietal cortex; visuo-tactile body-centred frames | **relations between nodes** — a learned change-of-basis, i.e. the `g` side |
| **Temporal** | change in causes, positions, orientations given **forces** | sensorimotor loops generalised to *sensoriforce* encodings | **edges** — labelled by the force that produces the transition |

Two consequences the wiki should carry:

- **Edges are labelled by force, not by action.** Generalising sensorimotor → *sensoriforce* prediction detaches the edge label from the agent's own motor system: the same edge fires whether the agent, another agent, or physics supplied the force. This is exactly the wiki's *edge driver* distinction (controllable vs. exogenous) obtained as a **generalisation of one encoding** rather than as two separate mechanisms.
- **Modularity is derived, not assumed.** The paper's proposition 3 is that modularity develops *because* flexibly relating encodings across space and time requires separable parts. The wiki's standing modular stance ([[wiki/concepts/attention.md]]) gets a functional justification here rather than an anatomical one.

**This is a direct candidate answer to gap G16** (which lever buys graph-structured solutions): the architecture lever, spent on *three typed prediction channels* rather than on one homogeneous predictor. It is a proposal, not a result — no implementation exists.

---

## Active inference: where goals come from

| Component | Statement |
|---|---|
| **Homeostasis as free energy** | divergence between desired and current internal (Hullian, bodily) state *is* free energy demanding minimisation |
| **Goal-directed action** | minimise that divergence by acting — temporal predictive encodings are run **inversely** to recover the forces, then the motor commands, that produce the desired change |
| **Epistemic action** | minimise uncertainty about state estimates, so that goals are reached *with high certainty* — curiosity as variance reduction |
| **Arbitration** | the agent must continuously trade epistemic against goal-directed action; the trade is made by the same free-energy quantity |
| **Attention = action minus execution** | abstract from motor commands to *forces* and behavioural control becomes attentional control; run it on internal encodings and it becomes **thought** |

The last row is the paper's strongest architectural claim: **thinking is action on internal predictive encodings**, produced by the same machinery, motivated by the same homeostatic drive. It supplies a candidate for gap G15 (no control policy over simulation) — rollouts are initiated by homeostatic imbalance and steered by the epistemic/goal trade-off — while leaving *depth* and *stopping* unaddressed.

---

## The cognitive processing loop

Generalised from the **modular modality frame** architecture (a probabilistic body-image model that represents an arm in many limb-centred low-dimensional frames rather than one high-dimensional one — modularity *for scalability*):

1. **Temporal prediction** → prior state estimate, with a precision loss (uncertainty grows).
2. **Sensory fusion** → local posterior; bottom-up errors pass upward; per-modality plausibility estimated by cross-checking against spatial predictive encodings.
3. **Mutual consistency relaxation** → *global posterior*: pairwise adjustment of active encodings until residual error is approximately minimised.

Step 3 is the expensive one and is explicitly acknowledged as intractable in general — the system is "a highly modular, distributed restricted Boltzmann machine", so the global attractor is approximated by local interactive adjustment, never computed.

**Relation to gap G5 (no joint discover-and-navigate loop):** this loop *is* joint at the activity level — the state estimate is revised while acting, with no discovery-then-use phase. It is **not** joint at the structure level: `W` still adapts slowly and offline relative to behaviour. So the loop closes the instance half of G5 and leaves the meta half open.

---

## Concepts as attractors

| Claim | Content |
|---|---|
| **A concept is a free-energy minimum** | a distributed set of simultaneously active predictive encodings that mutually predict each other without significant contradiction. "Ball" = roundness template (top-down) + size/volume/default-location (spatial) + rolling/bouncing under force (temporal) |
| **Uncertainty is the residual** | the error remaining after activity relaxation quantifies believed uncertainty about the concept — a free confidence estimate, not a separate head |
| **Composition = joint attractor** | "a ball lies in a bowl" is one attractor over both concept sets, related in a relative spatial frame; the two temporal interaction predictions *cancel*, which is what "lies stably" means |
| **Composition is gated by consistency** | "a bowl lies in a ball" is hard to imagine because a ball affords no interior — the composition has no low-energy state. Semantic anomaly = failure to find a minimum |
| **Symbol-like behaviour without symbols** | rule- and symbol-like structure is carried by distributed attractors; the proposal is explicitly positioned as *grounding* SOAR/ACT-R-style production rules rather than replacing them |
| **Thought = attractor succession** | pursuing an idea is exploring concepts and compositions by event-schema-driven activity change over time ([[wiki/concepts/event-segmentation.md]]) |

**The first empirical test of this claim at brain scale** (Englert et al. 2026, [[wiki/entities/fcann.md]]). The free-energy learning rule `ΔJ_ij ∝ σ_iσ_j − L(·)σ_j` predicts a *geometric* signature — the attractors it writes are approximately orthogonal, so they coincide with the eigenvectors of the coupling matrix. Reading the human functional connectome (`J = −Σ⁻¹`) as coupling weights and relaxing, the resulting attractors do align with those eigenvectors, converge ~9× faster than degree-preserving permutations of the same connectome, and explain more held-out variance than principal components fitted to the activity itself. Three things this adds to the page. (i) "Concepts are free-energy minima" acquires a testable consequence that is not about behaviour: it constrains the *weights*. (ii) The inverse temperature `β` is the **precision of the prior**, with `β → ∞` a binary Hopfield net that ignores its input entirely — the same precision-gating logic as `α, β, γ` above, applied to the landscape rather than to a layer. (iii) The intractable global relaxation of step 3 is here run to convergence in ~380 iterations on 122 coarse-grained units, which is what "approximate by coarse-graining rather than by locality" looks like in practice.

**Why this matters for gap G21/G22.** The wiki's composition gap asks how outputs of separate modules are joined, and why only a handful of the astronomically many possible compositions are ever built. This page supplies a mechanism for both halves at once: **join by mutual constraint satisfaction, select by energy**. Compositions that fail to reach a minimum are never built, so the combinatorial explosion is pruned by the physics of the representation rather than by a corpus or a teacher. Two costs: the relaxation is intractable in general (approximated locally), and nothing here shows that *low energy* and *correct* coincide — an attractor is a consistency criterion, not a truth criterion.

**(brainstorm)** Read against [[wiki/concepts/latent-graph-discovery.md]], this is not a rival to navigation but a *substrate* for it: an attractor is a node, the relaxation is the node's identity check, and an event schema is an edge with typed endpoints. The reduction that survives both readings is "navigation over a graph whose nodes are implicitly defined as energy minima" — which buys de-aliasing (two identical observations at different graph positions relax to different attractors if their context differs, gap G2) at the cost of nodes being defined only up to the relaxation's convergence.

---

## Open problems

- **No implementation.** The paper is an integrative sketch; no system implements the three-channel prior, the event abstraction, and active inference together. Every claim below the equations is unverified.
- **The structural priors are stipulated.** Why *these three* channels and not four or two is argued functionally, not derived from free energy — which concedes that the principle underdetermines the architecture.
- **Event-boundary detection is not derived from the principle.** Butz 2016 states outright that deriving segmentation from free energy "remains a future challenge"; the working proposals are multiplicative gates and explicit change monitors ([[wiki/concepts/event-segmentation.md]]).
- **The global attractor is intractable.** Local relaxation approximates it with no guarantee, so "concepts are free-energy minima" is a definition the system can never verify it has met.
- **Social and linguistic dimensions are excluded by the author.** Other agents are treated as items; intentionality, and any account of how language shapes the encodings, are left out — the same boundary that T8 sits on.
- **The data problem.** Developmental-scale, self-motivated sensorimotor experience is not obtainable from robots (days at best); the proposed substitute is game-engine virtual reality. Whether structure learned in a simulator is the structure the theory is about is untested.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — the named rival reduction, stated in full; its three predictive-encoding types map onto node content, inter-node relations and edges, and its activity/weight split is the fast-**M**/slow-**W** split derived from inference.
- **[[wiki/concepts/event-segmentation.md]]** — the abstraction layer built on top of this substrate: events are *sets* of active predictive encodings, boundaries are significant changes in that set.
- **[[wiki/concepts/simulation-based-planning.md]]** — supplies the switch that turns perception into simulation (`γ → 0`, strongly negative `β`) and the homeostatic drive that initiates a rollout.
- **[[wiki/concepts/complementary-learning-systems.md]]** — reaches the same two-timescale split from a different premise: here it is activity-vs-weight adaptation under one objective, there it is interference between a sparse store and a distributed one.
- **[[wiki/concepts/abstract-structural-codes.md]]** — spatial predictive encodings are a second, learned candidate for `g`: content-invariant frame-of-reference mappings acquired from multimodal correlation, where grid codes are periodic and given.
- **[[wiki/concepts/attention.md]]** — attention here is *action abstracted from execution*: the same active-inference machinery pointed at internal encodings, which is what makes thought and behaviour one mechanism.
- **[[wiki/concepts/working-memory.md]]** — `α = β = γ = 0` is maintenance in the absence of evidence, i.e. active maintenance recovered as a limiting case of the inference update rather than as a dedicated store.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — predictive coding is the local rule this page runs on; the error `e` is computed within a layer, so no weight transport is needed.
- **[[wiki/concepts/core-knowledge.md]]** — the direct rival on origins: this page derives "innate" conceptual primitives from very early sensorimotor prediction (tension T12), while supplying the same *kind* of thing — a small set of installed structural biases.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the slow half of the update (`W` adaptation to minimise residual error) is a local, error-driven write rule, and the precision gates are a metaplasticity-like control over how much it writes.
- **[[wiki/concepts/shortcut-learning.md]]** — the three typed prediction channels are an architecture-lever bet against shortcuts: a spatial or temporal channel cannot express a purely appearance-based rule.
- **[[wiki/concepts/causal-model-building.md]]** — the rival route to the same target: there, causal fidelity is an explicit criterion on the generative model and is paid for with causal training data; here it is meant to fall out of predicting one's own sensorimotor consequences, with no separate criterion.
- **[[wiki/concepts/compositionality.md]]** — supplies the one mechanised candidate for the coherence that compositionality lacks: a composition is an attractor, so arrangements with no low-energy state are never formed.
- **[[wiki/concepts/amortized-inference.md]]** — the competing account of fast inference: compile the posterior into a feed-forward recognition network, versus converge to it by recurrent relaxation — caching against convergence.
- **[[wiki/concepts/energy-based-models.md]]** — the near-identical formalism from the machine-learning side: same scalar minimised over activity at inference and over weights at learning, but the energy is explicitly *not* a log-probability and representational collapse is the central obstacle — a threat that does not arise here because a residual against present sensory input cannot go flat.
- **[[wiki/entities/h-jepa.md]]** — the engineered counterpart of this page: an abstraction hierarchy trained by prediction, decoupled from sensation for planning, with a differentiable cost supplying the homeostatic drive; it derives the same abstraction levels this page stipulates as three typed channels.
- **[[wiki/concepts/three-component-framework.md]]** — supplies the slot-by-slot reading of this architecture: description length is its objective function, local residual descent its learning rule, the typed hierarchy its architecture — the wiki's one proposal that fills all three slots at once.
- **[[wiki/concepts/divergence-objectives.md]]** — types the residual: `e` is surprisal, its minimisation is cross-entropy against sensation, and the variational bound optimises the *reverse* (mode-seeking) direction, which is the information-theoretic reason relaxation lands in one attractor instead of averaging several.
- **[[wiki/concepts/contextual-inference.md]]** — the same residual-driven update with the residual *routed*: prediction error is distributed across a discrete set of context models in proportion to their responsibility, instead of being absorbed by a single model (Heald et al. 2021).
- **[[wiki/concepts/offline-replay.md]]** — generative-model sampling with sensory input clamped off: the same forward pass this page uses for imagination, run offline for a learning rather than a control purpose.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the same commitment to reference-frame transformation as a core cortical operation, reached from the grid-cell side: a universal egocentric→allocentric conversion predicted across all sensory cortices, with posterior parietal cortex as the candidate site this page had already named.
- **[[wiki/entities/spiking-tem.md]]** — an explicit predictive population in a trained circuit: MECIII is trained to predict MECII one step ahead, and its spatial tuning is only measurable against the *future* position (gridness low at the current position, significantly higher one step ahead), which is what a prediction-carrying layer should look like in recordings.
- **[[wiki/entities/adaptive-cann.md]]** — prediction-ahead with no prediction: a constant anticipation time `t_ant ≈ (A_uτ_v/α)(m − τ/τ_v)`, independent of input speed, emerges from the competition between an intrinsic drift and an external drive, so lead time is set by a gain rather than by a generative model or a prediction error.
- **[[wiki/entities/fcann.md]]** — the first empirical test of a *geometric* prediction of free-energy minimisation: if attractors are learned priors written by the contrastive rule `ΔJ_ij ∝ σ_iσ_j − L(·)σ_j`, they must come out approximately orthogonal, and in human functional connectomes they do — with stochastic relaxation read as posterior sampling and the inverse temperature `β` as the precision of the prior.
- **[[wiki/entities/boltzmann-machine.md]]** — names the substrate this page invokes ("a highly modular, distributed restricted Boltzmann machine") and its escape from the intractable global attractor: in a ratio between two states differing in one unit the partition function cancels, so local interactive adjustment samples a globally normalised distribution without ever evaluating `Z`.
- **[[wiki/concepts/dendritic-computation.md]]** — a candidate physical substrate for the prediction channel: a distal NMDA spike depolarizes the cell for 50–200 ms without firing it, so a detection is a prediction held over a behavioural interval on an anatomically separate pathway from the feedforward drive carrying the evidence.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the laminar substrate the hierarchy assumes: feedforward projections originate in layer 2/3 and terminate in layer 4 above, feedback originates in layers 5/6 and terminates outside layer 4 (mostly layer 1, on distal apical tufts) — and the superficial-layer-neuron percentage makes hierarchical *depth* a measured continuous quantity rather than a stipulated layer index (Douglas & Martin 2004).
