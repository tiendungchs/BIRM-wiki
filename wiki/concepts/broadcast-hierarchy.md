# Broadcast Hierarchy — the Apex as a Conductor Rather Than a Commander

**A hierarchy can be deep without being a chain. The standard predictive architecture assumes level `i` talks only to `i−1` and `i+1`, so the top level reaches the bottom by relay; the alternative measured in cortex is that the top level **receives selectively from mid-and-high levels only** and **projects diffusely to many levels and laminar types at once** — compressed input, broadcast output. Under that shape a global model update is one act rather than `L` relays, and the "levels" are not a command chain but a heterarchy in which similarly differentiated areas exchange laterally at every depth.**

> **Provenance.** Satpute et al. 2026, *The default mode network in a hierarchical generative model of the brain*, Current Opinion in Behavioral Sciences 69:101656, doi:10.1016/j.cobeha.2026.101656 (`raw/satpute-2026-dmn-hierarchical-generative-model.md`). A theoretical review — **no new data**. Its evidence base is other people's cytoarchitecture and tractography (principally Paquola et al. on laminar profiles of human cortical networks, and Barbas' structural model of cortico-cortical connections); every functional claim is an argument, not a measurement. Read the anatomy rows as inherited findings and the architectural reading as the contribution.

---

## Two shapes for the same depth

| | **Chain of command** | **Orchestra conductor** |
|---|---|---|
| Downward | `i → i−1` only; reaching the sensory layer costs `L−1` relays | `apex → {many levels, many laminar types}` in one hop |
| Upward | `i−1 → i` only | Selective: apex receives **proportionally more from high-level association cortex (eulaminate I) than from sensory cortex** |
| Update latency for a global revision | `O(L)` | `O(1)` |
| What the apex has to represent | Whatever the level below abstracts | A prior compressed enough to be simultaneously valid at several levels |
| Wiki instances | Every one — equation (1) of [[wiki/concepts/predictive-coding-free-energy.md]], every deep net, every hierarchical RNN | None |

The asymmetry is the point: **input is filtered, output is not**. A conductor that listened to every instrument at full bandwidth would need the bandwidth of the whole orchestra; one that listens only to section leads and cues everyone at once is cheap in both directions.

**Anatomical basis, as reported.** Cortex is graded by laminar differentiation — allocortex (3–4 layers: hippocampus, limbic lobe) → dysgranular (4–6 poorly differentiated) → eulaminate I → II → III → koniocortex (primary sensory). Networks mostly sit in a band of that gradient; the default mode network does not. It spans **agranular, dysgranular and eulaminate I–III** while containing *no* koniocortex — high position (far from sensory input) but wide laminar coverage. Its connectivity is not denser than other networks; it is **broader in cross-network reach**, with diffuse long-range output across multiple networks and laminar types.

**Most connections are short.** Quantitative tract-tracing: the majority of cortico-cortical connections are **< 10 mm**, so local circuits carry local features of the generative model and the sparse long-distance projections carry the integration. A broadcast hierarchy is therefore not a dense graph — it is a mostly-local graph with a thin, wide-fan-out overlay. That is the same statistical picture as [[wiki/concepts/small-world-topology.md]], read as a computational division of labour rather than as an efficiency result.

---

## The laminar-type rule makes the "levels" a heterarchy

Barbas' structural model: **cortical areas preferentially connect to areas with similar laminar profiles** — granular to granular, agranular to agranular. Applied inside a high-level network with wide laminar coverage, this predicts *parallel* channels rather than one serial pathway: the agranular parts of two distant complexes talk to each other, the eulaminate parts talk to each other, and neither exchange has to pass through the other.

| Consequence | Statement |
|---|---|
| **Local hierarchies, lateral exchange** | Each complex runs its own internal agranular→eulaminate gradient (a local generative model over nearby cortical and subcortical targets) and exchanges with the other complex *level-matched*, not top-down |
| **Partial independence** | Two complexes can generate and check predictions at the same time without either being the other's superior |
| **A typed edge the wiki lacks** | Laminar type is a *connection-eligibility label*: it says which pairs may couple at all, independent of distance or function. No wiki architecture types edges by a property of the endpoints' internal structure |

**(brainstorm) This is a routing prior that is free to compute and hard to learn.** Every module-routing scheme in the wiki ([[wiki/concepts/priority-map.md]], mixture-of-experts, [[wiki/concepts/parallel-timescale-streams.md]]'s coalition masks) either learns which modules may talk or lets all pairs talk. The laminar-type rule is a third option: give every module a scalar "differentiation level", permit coupling only between modules within a small distance on that scalar, and the level-matched parallel channels fall out of the constraint rather than out of training. It also gives the depth variable a *content*: a module's level is a property of its own compression, not its index in a list.

---

## Abstraction implemented as anatomy: dimensionality reduction with a price

The source's mechanistic claim for why high-level areas hold abstract priors is entirely structural — no learning rule is invoked:

| Anatomical feature at higher levels | Computational consequence |
|---|---|
| Fewer neurons; lower neuron and neurite density | Less local processing capacity per unit of input → the representation must be smaller than its input |
| Broader receptive fields; convergent input from many lower-level regions | Integration across wider spatial scale |
| Reduced myelination (hypomyelinated relative to sensory/motor cortex) → slower transmission | Longer integration windows → integration across wider *temporal* scale |
| Broad, diffuse projections | The compressed code is usable by many consumers at once |

`many high-dimensional inputs → converging onto few, slow, broad-receptive-field units → a lower-dimensional recode` — and that recode *is* the high-level prior. Abstraction and compression are the same operation here, which is the position [[wiki/concepts/prediction-compression-equivalence.md]] argues from the coding side and this page supplies the wiring for.

**The compression is lossy, and deliberately so.** The source's own footnote: the generative model does **not** reconstruct expected sensory input in its original form; it generates *metabolically efficient approximations sufficient for guiding action*. This is a direct constraint on any predictive-coding implementation that scores itself by reconstruction fidelity — the biological objective is sufficiency-for-action at minimum cost, not pixel recovery. See [[wiki/concepts/expected-free-energy.md]] for the objective this implies and [[wiki/concepts/affordance-grounded-symbols.md]] for the "sufficient for what" question it leaves open.

---

## The trigger: autopilot until the immediate past stops predicting

The source's functional claim, and the one operational statement in it:

| Regime | Condition | What the apex does |
|---|---|---|
| **Autopilot** | Sensory input is well predicted by the immediate past | Maintain the global model with minimal perturbation; local levels absorb the residual |
| **Global update** | The immediate past predicts the incoming input poorly | Recruit **endogenous** sources (prior knowledge, not the recent input) and reconstruct the generative model broadly |

Named triggers for the second regime: scene changes in naturalistic film (shifts of time, place or goal), goal changes (e.g. thermoregulatory → metabolic), switching which agent's behaviour is being modelled, and affective state changes. All four are **event boundaries in the sense of [[wiki/concepts/event-segmentation.md]]** — which makes this a claim that the boundary detector and the global-broadcast apex are the same subsystem operating at two settings.

**(brainstorm) The regime variable is a *depth-of-update* scalar, and no wiki architecture has one.** Every model here updates all its levels on every step (backpropagation) or updates a fixed subset on a fixed schedule (hierarchical RNNs ticking every `k` steps). The specification implied here is: a residual monitored against the *immediate-past* prediction, gating how many levels the update is allowed to reach, with the top setting sourcing its replacement from stored priors rather than from the input. That is one scalar controlling the *scope* of a write — closely related to, but not the same as, the precision gates `α, β, γ` of [[wiki/concepts/predictive-coding-free-energy.md]], which control the *strength* of the update at each level independently and cannot express "revise everything at once".

---

## Relevance to a reasoning model

- **A global model revision should cost one hop, not `L`.** If abstract reasoning requires occasionally throwing out the current frame — a wrong assumption, a changed goal, a new interlocutor — a chain-of-command hierarchy pays `L` relays each time and the intermediate levels spend that interval computing on a repudiated prior. The conductor shape is the architectural fix, and it costs one wide-fan-out projection set.
- **Filter the upward path, not the downward one.** The measured asymmetry (selective input from high-level areas, diffuse output to all levels) is the opposite of a transformer residual stream, where every layer reads everything and writes into the same space. It is also the opposite of the usual "bottleneck at the top" reading: the bottleneck here is on what the apex *listens to*, and the output side is deliberately wide.
- **Depth should be a measured property, not an index.** Laminar differentiation level and the SLN% distance rule ([[wiki/concepts/canonical-cortical-microcircuit.md]]) are two ways of estimating a module's hierarchical position *from its structure*. The equivalent for a trained model — estimate each module's level from its own compression ratio and receptive-field width, then check whether coupling respects level-matching — is a diagnostic the wiki does not run.
- **Slow is a design choice, not a defect.** Hypomyelination at the apex buys a long integration window. Every wiki timescale bank achieves the same effect with a decay constant on a uniformly fast substrate; the biological version pays for it in conduction physics, which also makes it modifiable by a non-synaptic route ([[wiki/concepts/learnable-synaptic-delays.md]]).

---

## Open problems

| Problem | Why it is open |
|---|---|
| **The whole page is an argument over borrowed anatomy** | No new data. The laminar profiles, the connectivity breadth and the myelination gradient are inherited; the conductor reading is the authors' inference, and no experiment reported here distinguishes it from a chain of command with fast relays |
| **"Apex" and "not in the chain" are asserted together** | The source places the network at or near the apex of macroscale structural and functional gradients *and* denies it a chain-of-command position. Both can be true — high position by distance-from-sensory, non-serial by connection type — but nothing measures the two on the same graph |
| **The laminar-type rule is stated, not quantified here** | No coupling probability as a function of laminar-type distance is given, so the routing prior has a shape but no parameters |
| **The layered communication axis is untestable with current methods** | The source concedes it: parsing laminar types in a way that informs task fMRI is not yet possible, so the one axis that carries the heterarchy claim has no functional evidence |
| **No learning anywhere** | The gradient of neuron density, myelination and laminar differentiation is treated as given. Nothing says how a level acquires its compression ratio, or whether the level structure is trainable |

---

## Connections

- **[[wiki/concepts/predictive-coding-free-energy.md]]** — this page attacks the one assumption that page's equation (1) makes silently: that level `i` couples only to `i±1`. Replacing the chain with selective-in/diffuse-out changes the cost of a global revision from `O(L)` to `O(1)` and gives the precision gates a companion variable they lack — the *scope* of an update rather than its strength.
- **[[wiki/entities/default-mode-network.md]]** — the biological instance the shape was derived from, and the network whose thirty years of functional heterogeneity this shape is offered to explain in one stroke.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the other structural hierarchy metric: SLN% grades depth by the superficial fraction of a projection's source cells, laminar differentiation grades it by the source area's own layering, and the laminar-type rule adds a coupling *constraint* that SLN% does not express.
- **[[wiki/concepts/event-segmentation.md]]** — the trigger for the broadcast regime is exactly a boundary (scene, goal, agent, affect), so this page claims the segmenter and the global-model updater are one subsystem at two settings of a depth-of-update scalar.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the wiring behind that page's identity: convergent input onto fewer, slower, broader units *is* the compressor, and the source adds that the compression is deliberately lossy — approximations sufficient for action, not reconstructions.
- **[[wiki/concepts/parallel-timescale-streams.md]]** — the same multi-speed picture from the other end: that page measures six concurrent streams over one shared codebook, this page supplies a structural reason why the slow ones live at the apex (hypomyelination, low neurite density, long integration windows).
- **[[wiki/concepts/small-world-topology.md]]** — the connection-length statistics this page depends on: mostly < 10 mm local wiring with sparse long-range projections, read here as local generative models plus a thin broadcast overlay.
- **[[wiki/concepts/learnable-synaptic-delays.md]]** — myelination sets the apex's integration window, so hierarchical position is partly a *conduction* property and is modifiable without touching any synaptic weight.
- **[[wiki/concepts/integration-segregation-balance.md]]** — a conductor is an integration mechanism with a specific asymmetry (compressed in, diffuse out), which is a sharper object than a scalar participation coefficient measured on an undirected graph.
- **[[wiki/concepts/expected-free-energy.md]]** — the objective the lossy-compression footnote implies: the generative model is scored by sufficiency for action at minimal metabolic cost, not by reconstruction accuracy.
