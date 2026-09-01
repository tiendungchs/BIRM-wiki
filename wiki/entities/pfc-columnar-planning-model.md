# PFC Columnar Planning Model (Martinet et al. 2011)

**A prefrontal network of cortical columns that learns a topological graph by compressing a redundant hippocampal place code, then plans by letting a reward signal diffuse backwards through the graph until it meets the current state — no rollout, no value iteration, no tree** (Martinet, Sheynikhovich, Benchenane & Arleo 2011, `raw/martinet-2011-prefrontal-spatial-planning-model.md`, *PLoS Computational Biology*).

The wiki's clearest instance of **planning as a wavefront**. Its load-bearing claims for a reasoning model are three: the graph's *nodes* are learned by sparsification rather than given; the *plan* is the fixed point of a decaying diffusion, so distance-to-goal is a firing rate rather than a stored value; and a *second, coarser copy of the graph* is what makes the whole thing survive an enlarged environment — hierarchy as a signal-to-noise device, with an ablation to prove it.

> **Notation warning.** The converted source (a PubMed Central HTML clipping) has stripped every mathematical symbol and subscript, so the paper's unit labels (`Ω`-populations, per-unit superscripts) are unrecoverable from `raw/`. Unit types below are named functionally. The two column populations are called **fine** (hippocampus-driven) and **coarse** (proprioception-gated) here.

---

## Architecture

| Level | Content |
|---|---|
| **Input** | Model hippocampal place cells with Gaussian fields, integrating vision + self-motion (Sheynikhovich et al. 2009); highly redundant and distributed |
| **Column** | One column ≈ one **state** (place). Contains three single units + a population of minicolumns. No layer IV — matching rat medial prefrontal cytoarchitecture ([[wiki/entities/medial-prefrontal-cortex.md]]) |
| **Minicolumn** | One **state–action pair**; two units each. Actions are allocentric motion directions, i.e. graph *edges* |
| **Fine population** | Columns driven directly by place-cell input; Hebbian afferent learning makes each selective to a location |
| **Coarse population** | Columns driven by *already-processed* fine-column output, gated by a proprioceptive signal (see below) |
| **Edges** | Plastic lateral projections between columns, learned by unsupervised Hebbian updates on every experienced place→place transition. **Forward and reverse projections are learned separately** — the graph is stored as two directed adjacency matrices, not one symmetric one |
| **Motivation input** | A reward-drive synapse onto layer II–III units, standing in for ventral tegmental dopamine or amygdala input; it makes one column *the goal column* |
| **Output** | Winner-take-all across the minicolumns of the current column → one motor command |

### The five functional unit types, and what each one is for

| Unit type | Signal it carries | Measured signature | Machine reading |
|---|---|---|---|
| **State unit** | Location | Symmetric place field; largest spatial mutual information per unit | The graph node |
| **Goal / value unit** | Back-propagating reward wave | *No* spatial correlate, high constant firing rate, unique preferred discharge frequency per unit | Distance-to-goal, computed not stored |
| **Path unit** | Forward-propagating selected-plan wave | Asymmetric field, **negative skew growing quasi-linearly with the number of relays from the start**; anticipates the state unit of the same column | Prospective code — the plan, laid out in advance |
| **Action unit** | Coincidence of place and back-propagated goal | Ranking flips within ~1 s of encountering a block | The state–action value, and the thing that is actually selected over |
| **Coarse state unit** | Chunked location (a whole alley, not a point) | Large receptive field, low population count, lower total population information | The meta-graph node |

---

## Planning by activation diffusion

The mechanism in five steps:

1. Motivation input fires the goal column's value unit.
2. That activity **back-propagates along the learned reverse edges**, attenuated at every synaptic relay — so intensity decays exponentially in graph distance.
3. Because receptive fields tile the environment roughly evenly, the intensity arriving at any column ∝ a monotone decreasing function of **shortest path length to the goal**. This is a measured result, not a design assumption (their Fig. 6A).
4. At the *current* column, coincidence of local place activity and the arriving goal wave fires the action units; a local winner-take-all picks the direction.
5. The winner's activity then **forward-propagates along the forward edges**, reconstructing the whole planned state sequence as an anticipatory wave.

**Two counter-propagating waves on one graph.** The retrograde wave carries value; the anterograde wave carries the committed plan. Only their *conjunction* at the current node produces an action. This is a genuinely different factorization from every other planner in the wiki: [[wiki/entities/spacetime-attractor.md]] relaxes one field over (location × delay); Monte Carlo tree search grows one forward tree; the [[wiki/concepts/successor-representation.md]] caches the retrograde half as a matrix. Here the two directions are separate populations with separate synaptic matrices — and each is separately measurable in recorded prefrontal cells.

### What the decay buys, and what it costs

| Property | Consequence |
|---|---|
| Value = attenuation | No reward-prediction error, no bootstrapping, no learning of a value function at all. Revaluation is instant: move the motivation input, the field re-forms |
| Attenuation is exponential | The plan is **shortest-path by construction** — the strongest arriving signal is the fewest relays |
| Blocking an edge blocks the wave | Removing one edge invalidates *every* path through it simultaneously, without enumerating those paths |
| **The noise floor is the horizon** | Past some graph distance the goal wave falls to basal noise and action selection degrades to random search. Planning depth is not a scheduling parameter — it is `log(signal/noise) / attenuation per relay` |

**(brainstorm)** That last row is the wiki's most concrete answer yet to gap G24 (no principled planning horizon). The horizon here is neither chosen nor discounted-in: it falls out of the ratio of synaptic attenuation to noise, both of which are physical constants of the substrate. And unlike a discount factor, it is *fixable by re-representation* — see the hierarchy result below. A planner whose depth limit can be extended by coarsening its own graph has converted a hyperparameter into a representational decision, which is the form gap G24 says a real answer must take.

---

## The hierarchy result — the most transferable finding

The coarse population is recruited by a **proprioceptive change-point signal**: the running probability that a sharp direction change occurs at this location.

| Situation | What the signal does | Result |
|---|---|---|
| Mid-corridor | Constant | Hebbian potentiation of *many* fine columns onto *one* coarse column — chunking |
| Turning point | Changes value | A new coarse column is recruited — a boundary |

So a corridor becomes one node. The coarse graph runs the same diffusion, and its columns bias the fine columns' units during planning.

### The ablation

Same protocol at two maze scales (1:1 and 4:1, proportions preserved), 40 simulated rats per group, controls vs. a group lacking the coarse population:

| Phase | 1:1, both groups | 4:1 control | 4:1 no-coarse |
|---|---|---|---|
| Day 1 (no block) — prefer shortest path P1 | ✓ | ✓ | ✓ but degraded |
| Days 2–14 (block A) — prefer shortest *detour* P2 over P3 | ✓ | ✓ | **✗ — no significant preference** |
| Day 15 probe (block B) — prefer P3 over P2 | ✓ | ✓ | **✗** |

**Why it fails.** Not because the coarse map is more efficient to search. Because the coarse graph has **fewer relays between the same two physical points**, so the exponentially attenuated goal signal is still above noise where the fine graph's has already died. Hierarchy extends the horizon by shortening the path *in graph-hops*, not in metres.

**(brainstorm)** This converts a hedge on [[wiki/concepts/simulation-based-planning.md]] — "jumpy hierarchical planning may be as much an error-control device as an efficiency device" — into a mechanism plus an ablation. Generalised: *any* planner whose signal degrades multiplicatively per step (compounding rollout error, vanishing gradients through a deep unroll, attention diluted over long chains) gets the same benefit from the same move, and gets it for the same reason. The design rule is not "chunk for speed"; it is **chunk until the surviving signal at the goal exceeds the noise**, which is a testable stopping criterion for how coarse a meta-graph should be. It also means depth of hierarchy is set by environment *size*, not environment complexity — the model needs the second level only at 4:1.

**Where the segmentation criterion comes from is the weak point.** A change-point in a self-motion statistic is cheap and unsupervised — the spatial analogue of [[wiki/concepts/event-segmentation.md]]'s prediction-error boundary — but it is *hand-chosen*, and the paper's own candidate for its biological source is striatal habit learning (if the animal always turns left here, that stimulus–response association is the signal). In an open field with no obstacles the model predicts uniform coarse-unit activity — i.e. no chunking at all — which the authors flag as an untested prediction. Gap G33 is dented, not closed.

---

## Tolman & Honzik's detour task — insight without insight

The behavioural target. Three paths of different length from start to goal; P1 and P2 share a final section. Protocol: 168 training trials (14 "days" × 12), block at A (P1 only) on days 2–14, then 7 probe trials with block at B (the *shared* section of P1 and P2).

| Phase | Rats (Tolman & Honzik 1930) | Model |
|---|---|---|
| No block | Prefer shortest P1 | ✓ (ANOVA significant) |
| Block A | Prefer shortest detour P2 | ✓ |
| **Probe, block B** | Choose P3 — *without having tested P2* | ✓ |

The probe is the whole point: the animal must infer that blocking the shared section invalidates P2, having never experienced P2 blocked. Tolman called it insight.

**What the model shows is that insight is not a mechanism.** It is what a graph representation does for free. A route-based store (three independent place–action–place chains) cannot produce it, because nothing links P1's blockage to P2's. A graph with shared nodes produces it with no additional machinery: the wave dies at the blocked edge, and both paths through it go dark at once.

**(brainstorm)** This is the cleanest statement in the wiki of *why* [[wiki/concepts/latent-graph-discovery.md]] is the right problem framing rather than one framing among several. The behavioural phenomenon that motivated fifty years of "cognitive map" theorising reduces, exactly, to the difference between storing paths and storing a graph — and it reduces to nothing else. Anything that recovers the shared node gets the inference; anything that memorises trajectories cannot, at any scale. It also supplies a minimal benchmark: **shared-substructure invalidation**. Train on routes, block a shared segment, and see whether the system rejects the untested sibling route. It is cheap, it needs no distribution shift, and it is passed only by systems that have factorised paths into edges — a companion instrument to the re-goaling test (gap G17), probing *structure* where re-goaling probes *preferences*.

---

## Hippocampus → prefrontal cortex as a redundancy-reduction stage

Measured across place cells → fine columns → coarse columns:

| Quantity | Direction along the cascade | Note |
|---|---|---|
| Receptive field size | Increases significantly | Matches rat hippocampal vs. prefrontal field sizes in recordings |
| Population size encoding the maze | Decreases significantly | Sparsification, quantified |
| Spatial density of fields | Decreases significantly | Confirmed by kurtosis and information-sparseness analyses |
| Mutual information *per unit* | Increases | A larger field is informative over more of the input space |
| Mutual information of the *population* | Decreases | Place cells highest; **fine columns retain ~85% of the theoretical upper bound**; coarse columns lose significantly more |

The 85% figure is the design point: enough to solve the task with a fraction of the units. The coarse population's information loss is not a defect — it is what makes it a meta-graph, and the paper is explicit that it cannot support planning alone.

**(brainstorm)** Read as a claim about node discovery: the graph's node set is obtained by *compressing a high-dimensional, aliased sensory code until the compression starts costing task-relevant information, and stopping there*. That is an operational criterion for how many nodes a learned graph should have, and it is the same criterion [[wiki/concepts/prediction-compression-equivalence.md]] arrives at from information theory — reached here by simulation, with the retained fraction actually measured. The wiki has many mechanisms for *learning edges* and almost none for *deciding what a node is*; this is one.

---

## Validation against recorded prefrontal cortex

Every unit type the model needs was found in medial prefrontal recordings from navigating rats (Wiener lab data; Benchenane et al. 2010, Peyrache et al. 2009):

| Model unit | Recorded counterpart |
|---|---|
| State unit | Spatially selective prefrontal cells, matched in field shape and signal-to-noise |
| Goal / value unit | Cells with no spatial correlate and evenly distributed constant preferred discharge frequencies |
| Path unit | Cells with asymmetric tuning curves whose negative skew tracks distance travelled |
| Action units before/after contingency change | Strategy-switching cells (Rich & Shapiro 2009): different subsets active before vs. after a reward-contingency change |
| Sequence-order code | Monkey prefrontal cells whose pre-movement activity ranking predicts the serial order of drawn segments (Averbeck et al. 2002) — reproduced by the path-unit ranking, and holding at *every* timestep, not just at trajectory onset |

**A blind test, and it is the strongest methodological export.** Six statistics per unit (mean rate, s.d., skewness, lifetime kurtosis, spatial information per spike, spatial mutual information) → PCA → k-means with `k = 3`, run identically on simulated and recorded populations. Both partition into three clusters with matching profiles: a high-rate/no-spatial-information cluster (model: goal units), and two location-selective clusters differing in skewness (model: state and path units). A Poisson control population separates cleanly from all model units, so the structure is not a rate artefact.

**(brainstorm)** This is a template the wiki should reuse: instead of asking "does my model's unit `i` look like recorded cell `j`", cluster both populations blindly in the same statistical space and ask whether the *partitions* correspond. It tests the model's claimed functional taxonomy rather than any individual tuning curve, it needs no correspondence between model and recorded units, and it produces falsifiable predictions — here, that prefrontal interneurons participate in the goal-propagation cluster, i.e. that inhibition carries planning signal rather than merely gating it ([[wiki/concepts/inhibitory-control-of-coding.md]]).

---

## Comparison

| | **This model** | [[wiki/entities/spacetime-attractor.md]] | [[wiki/concepts/successor-representation.md]] | MCTS / rollout |
|---|---|---|---|---|
| Graph stored as | Two directed synaptic matrices (forward, reverse), two scales | One adjacency copy per consecutive delay-subspace | One matrix, discounted-occupancy | A transition function |
| Planning operation | Attenuating diffusion, both directions | Relaxation to a fixed point | Matrix product `v = Sr` | Serial forward search |
| Futures considered | All, in parallel | All, in parallel | Aggregated, not enumerated | One at a time |
| Depth limit set by | **Noise floor vs. per-relay attenuation** | Number of subspaces (anatomical) | Discount `γ` | Compute budget |
| Reward change within horizon | ✗ — one static goal | ✓ native | ✗ | ✓ |
| Blocked edge | ✓ handled — wave stops | ✓ if adjacency updated | ✗ known failure | ✓ |
| Hierarchy | ✓ two learned scales, ablated | ✗ | ✗ | assumed |
| Nodes learned? | ✓ by sparsifying a place code | ✗ given | ✗ given | ✗ given |

Against **Hasselmo's (2005) prefrontal columnar planner**, its nearest neighbour: both use minicolumns, activation diffusion and reward propagation. The difference is the encoding — Hasselmo's minicolumns represent *either* a state *or* an action, chaining state–response–state; here a column is a state and its minicolumns are that state's actions, so state and action are jointly coded in one local circuit. The consequence is that value arrives at a place and is *distributed over that place's edges* by local competition, rather than value being carried on the edges themselves.

---

## Limitations

| Limitation | Why it matters here |
|---|---|
| **One goal, appetitive only** | No relative valuation of competing goals, no effort or delay cost. The authors' proposed fix — diffuse several motivation signals with intensities proportional to subjective value — is stated but not implemented |
| **Static reward** | Fails exactly where [[wiki/entities/spacetime-attractor.md]] is designed to win: rewards that change within the planning horizon |
| **The hippocampal model is a stub** | No remapping when a barrier appears, no extrafield firing, no theta phase precession, no forward sweeps. Since the paper's central claim is about the *interaction* of the two structures, the untested half is load-bearing |
| **Columnar function is assumed** | The paper concedes (citing Rakic) that no general computational function for the cortical column is established, and that columns differ radically across cortex. "Column" here means only "local circuit sharing a spatial input" ([[wiki/concepts/canonical-cortical-microcircuit.md]]) |
| **The chunking signal is hand-supplied** | See above — gap G33 |
| **Structured maze only** | Corridors and intersections give clean decision points. Open-field behaviour is predicted, not shown |
| **Exponential decay is the value function** | Elegant, but it means value is *purely* a function of graph distance. Any environment where the best path is not the shortest path is outside the model |

**The framing claim underneath all of this is contested.** Putting the topological graph in cortex and instances in the hippocampus runs against the wiki's default cognitive-map account — see [[wiki/empirical-tensions.md]] T107.

---

## Connections

- **[[wiki/concepts/simulation-based-planning.md]]** — the sharpest alternative to rolling forward at all: a decaying retrograde wave computes distance-to-goal for *every* state in one parallel pass, and its noise floor supplies a physical planning horizon (gaps G15, G24) where discounting schemes only relocate the free parameter.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the strongest single argument for the wiki's core framing: Tolman's "insight" reduces exactly to storing a graph rather than storing routes, and to nothing else; and the node set is *learned*, by compressing a redundant place code until information loss bites.
- **[[wiki/concepts/cognitive-map.md]]** — supplies a mechanism for that page's route-planning read-outs: distance-to-goal is the amplitude of a diffusing signal rather than a stored quantity, and the two-scale graph is a circuit-level version of hierarchical chunking observed in rostrodorsal medial prefrontal cortex.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the model is built to that region's cytoarchitecture (no layer IV, hippocampal excitatory input, dopaminergic/amygdalar motivation input) and predicts a functional taxonomy of its cells that a blind clustering of real recordings recovers.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — takes the column/minicolumn motif as the unit of computation and assigns it a specific job (one place, its edges), while conceding that no general column function is established.
- **[[wiki/entities/spacetime-attractor.md]]** — the same commitment (evaluate all futures in parallel in prefrontal cortex, not serially) reached by relaxation over a delay axis instead of by diffusion over a distance axis; complementary failure modes, since only the attractor handles reward changing within the horizon and only this model learns its nodes and its hierarchy.
- **[[wiki/concepts/successor-representation.md]]** — the cached counterpart of the retrograde wave: `v = Sr` precomputes what the diffusion recomputes on demand, which is why the successor representation breaks when an obstacle appears and this model does not.
- **[[wiki/concepts/event-segmentation.md]]** — the coarse population is spatial event segmentation: a change-point in a self-motion statistic recruits a new node, chunking a corridor into one state exactly as a prediction-error boundary chunks a stream into one episode.
- **[[wiki/concepts/complementary-learning-systems.md]]** — a division of labour stated in representational terms: hippocampus holds instances (places, routes, episodes), the cortical controller holds the rules abstracted over them (the topology), so consolidation is a change of representational format and not only of storage site.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — sparsification measured rather than assumed: field size up, population size down, per-unit information up, population information down to ~85% of the upper bound, which fixes where the compression should stop.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — supplies the criterion the sparsification cascade implements empirically: compress until the retained task-relevant information starts falling.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the clustering analysis puts recorded interneurons in the goal-propagation cluster, predicting that inhibition *carries* the planning signal rather than only gating it.
- **[[wiki/concepts/temporal-coding.md]]** — the model's value code is a *frequency* code: each goal unit has a unique preferred discharge frequency set by its relay count from the goal, matching recorded prefrontal cells with no spatial correlate and evenly distributed rates.
- **[[wiki/entities/nucleus-reuniens.md]]** — the anatomical route the model's hippocampus→prefrontal arrow abstracts over, and the structure whose lesion removes exactly the forward path representation the path units carry.
- **[[wiki/concepts/offline-replay.md]]** — the forward path wave is a plan-time analogue of a replay sequence, but generated by a synaptic wavefront rather than by resampling stored trajectories, so it needs no episodic store to run.
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — the minicolumn is that page's mapping unit made local: a state–action pair in one microcircuit, selected by winner-take-all, with the mapping's value supplied from outside by the diffusing reward wave.
- **[[wiki/concepts/information-bottleneck.md]]** — the wiki's one system that already stops on a per-layer information criterion: the place-code cascade is run until retained task-relevant information starts falling (~85% of the bound) and the stage past that point cannot plan, which is an empirically located `ΔG` for a quantity that page can otherwise only define (Martinet et al. 2011).
