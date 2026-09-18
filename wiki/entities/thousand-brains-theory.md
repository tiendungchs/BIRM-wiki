# Thousand Brains Theory

**One algorithm, ~150,000 copies: every cortical column runs the hippocampal formation's what/where binding in miniature — a location code updated by an efference copy of its own motor output, bound to the feature currently sensed — so an object is not one representation but thousands of partial models that vote.**

The wiki already carries this theory second-hand: [[wiki/concepts/distributed-reference-frames.md]] cites it (Hawkins et al. 2019, via Chen et al. 2022) for "columns as reference-frame units voting on a pose" and says of the voting that it is "asserted, not specified", and [[wiki/concepts/canonical-cortical-microcircuit.md]] holds the laminar graph the claim presupposes. This page holds the theory's own content: the **layer-by-layer assignment** of the hippocampal circuit onto the six-layer column, the **two-output architecture** (L5 acts, L2/3 votes) that makes voting a distinct channel rather than a metaphor, and the **hierarchy-by-recursion** step that carries the same algorithm into abstract reasoning.

> **Provenance.** Two sources, and they differ.
> - **Primary:** `raw/hawkins-2019-framework-intelligence-cortical-grid-cells.md` — Hawkins, Lewis, Klukas, Purdy & Ahmad, *Front. Neural Circuits* 12:121, 2019. A theory paper: no equations, no simulation, no data of its own; its arguments are from published anatomy and from function. Claims below are this paper's unless marked otherwise.
> - **Secondary:** `raw/talk-nd-thousand-brains-theory.txt` — undated explainer talk, no citations. Where the talk and the paper disagree, the paper wins and the disagreement is flagged inline.
>
> The paper states its own method, which is worth copying: start from a function the neocortex demonstrably performs, **deduce** the representations it requires, then map those onto anatomy — explicitly against the bottom-up route of simulating a reconstructed column and hoping principles emerge ([[wiki/concepts/function-to-structure-inference.md]]).

---

## The two premises

| Premise | Content | Evidence the talk gives |
|---|---|---|
| **Cortical uniformity** | The six-layer circuit is the same everywhere, so the *algorithm* is the same everywhere; only the input differs | Cajal (common blueprint), Mountcastle (a vertical ~0.5 mm column in S1 all responds to one skin patch), Hubel & Wiesel (orientation columns in V1) |
| **Every column is a complete modelling system** | Not one central model but ~150,000 parallel ones, each learning whole objects; perception is their consensus | Asserted. The evolutionary argument is the support: scaling intelligence by *replicating one module* needs no new machinery and no new wiring plan, only more voters |

The second premise is the theory's actual novelty. Predictive-processing accounts ([[wiki/concepts/predictive-coding-free-energy.md]]) also make the cortex a predictive modeller; only this one denies that the model is singular.

---

## The universal algorithm: sensorimotor binding

The statue-in-the-dark derivation, which is the theory's whole argument in five lines:

1. Sensation alone yields an unordered feature list (`smooth`, `sharp edge`, `rough`) — no object.
2. Take an **efference copy** of each movement and update a location estimate: `l_t = l_{t-1} ⊕ a_t` — [[wiki/concepts/path-integration.md]]'s update rule, run on the sensor's own displacement.
3. Store the pair `(feature, l)`. The accumulated set is a **reference frame** anchored to the object.
4. Prediction becomes free: given `l_t` and a planned `a`, the model states what will be felt at `l_t ⊕ a`. Learning is *tested* by movement rather than by a label.
5. Recognition is the inverse: the observed feature sequence is consistent with only some (object, pose) pairs.

**The bold structural prediction: every column has a motor output**, including columns in areas with no obvious effector. What "movement" means varies by area — eye movement in visual cortex, limb movement in somatosensory, and in higher areas *a shift of attention or a memory recall*. This makes the theory's input to the wiki a claim about **action typing**: the `a_t` that [[wiki/concepts/path-integration.md]] requires need not be physical, but it must exist per module, and the module must emit it itself.

---

## The hippocampal circuit, miniaturised — the layer assignment

The theory's derivation is evolutionary: the allocortical hippocampal formation (3-layer hippocampus, 6-layer-but-non-columnar entorhinal cortex) solved *navigate and remember where things are* first; neocortex is that toolkit copied per column.

| Hippocampal formation | Job | Cortical column analogue | Wiring claimed |
|---|---|---|---|
| Lateral entorhinal cortex | **what** — sensory identity | **L4** | Thalamic drive; fires first on a stimulus |
| Medial entorhinal cortex (grid cells) | **where** — a metric coordinate system | **L6a**, cortico-cortical cells specifically | Every column has its own grid-like population |
| (motor system / self-motion input) | supplies the displacement | **L5** | Motor command out to subcortex; the talk adds an efference copy to L6 within the column (the paper instead cites *long-range* motor projections terminating in L6) |
| Hippocampus proper (place cells) | **binding** of what × where | **L2/3** | Receives feature from L4 and location from L6; the talk routes the location signal *via thalamus*, the paper via the direct reciprocal L6a↔L4 loop |
| — | prediction channel | **L1** | The location signal arrives on distal apical dendrites, **priming** the cells below rather than driving them |
| — | **relating two locations** | **L5** thick-tufted | Displacement cells — the paper's new prediction; see below |

**The paper argues the L6 assignment from published anatomy, where the talk asserted it.** Four facts, all pre-existing:

| Fact | Number / source | Why it bears |
|---|---|---|
| Feedforward thalamic input to L4 | **<10%** of L4 synapses (Ahmed 1994/1997; Sherman & Guillery 2013) | L4 is not primarily driven by the sensory afferent |
| L6a cortico-cortical → L4 | **~45%** of L4 synapses (Ahmed 1994; Binzegger 2004) | The dominant input to the "feature" layer is the "location" layer |
| L4 → those same L6 cells | McGuire 1984; Binzegger 2004; Kim 2014 | The loop is **reciprocal**, which is what learning object structure by movement requires |
| L6↔L4 arbor spread | Narrow (Binzegger 2004) | Matches the topographically aligned bidirectional MEC↔hippocampus wiring the analogy is built on |
| Motor projections to L6 | Nelson 2013; **Leinweber 2017** | A path integrator needs a self-motion input, and L6 has one |

L6a is named as *the only known cell set* meeting the requirement of bidirectional connectivity with the sensory-input cells. This does not settle [[wiki/empirical-tensions.md]] `T66` — the same L6→L4 projection is morphologically modulator-type — but it moves the row off "asserted with no citation" and onto a causal manipulation nobody has run.

Three things follow that the wiki did not have:

- **The location signal's route is contested between the wiki's own two sources.** The talk's L6→thalamus→L2/3 broadcast makes it a bus (a *third* thalamic role, alongside relay and the multiplexer hypothesis of [[wiki/concepts/distributed-reference-frames.md]]); the paper's L6a↔L4 loop makes it a within-column wire and gives the thalamus no part in it. Nothing in either source decides.
- **Priming ≠ driving is load-bearing, not decorative.** The location code sets which L2/3 cells are *predicted*, and the L4 feature decides which of those fire — the two-compartment logic of [[wiki/concepts/dendritic-computation.md]] used as the binding operator itself. Depolarised-but-subthreshold *is* the representation of "expected here", so a column's hypothesis set is held in dendritic state rather than in spiking.
- **The uniqueness of the location code is conceded to be a problem.** Grid modules are *not* sparse — each cell fires over a large area — and sparsity is what makes codes discriminable. The paper's own hedges: sample more modules (but nobody knows how many are available), use the sub-modules of Gu et al. 2018, or use **conjunctive cells**, which outnumber pure grid cells in entorhinal cortex and are likely sparser. So the wiki's `g`-as-address argument ([[wiki/concepts/path-integration.md]]) rests on a capacity claim the theory's own authors will not stand behind for pure grid cells.

---

## Displacement cells: the paper's new prediction

The one genuinely new object in the primary, and the part with the most leverage for reasoning. Full treatment at [[wiki/concepts/displacement-codes.md]].

| Operator | Signature | Same space → | Different spaces → |
|---|---|---|---|
| Grid cells | `Location1 + Displacement ⇒ Location2` | predict where a movement lands you | convert a point in cup-space to the equivalent point in logo-space |
| **Displacement cells** | `Location2 − Location1 ⇒ Displacement` | the movement needed to get from **a** to **b** — navigation by subtraction, no search | **the composite object**: "logo, at this offset, on cup" |

Why it matters here: with thousands of object-anchored frames, **relating two objects is relating two frames**, so composition and frame-conversion collapse into one operation. An object is then stored as a *set of displacement vectors over previously learned objects* rather than as a set of (feature, location) pairs — which buys part reuse, hierarchy (a displacement placing the logo implicitly carries the logo's own sub-objects), recursion (a logo containing a cup with a logo), and **object behaviour** (a stapler opening is a *sequence* of displacements between its two parts' frames; open and close are the same elements in reverse order, learned by the high-order sequence mechanism of Hawkins & Ahmad 2016).

The prediction has a substrate and a cost: L5 thick-tufted cells, which forces a reinterpretation of the branched L5 axon that Guillery & Sherman read as an efference copy ([[wiki/empirical-tensions.md]] `T344`). And it has an unpaid precondition — the subtraction is only defined if the two object spaces share moduli, scale and orientation, which is `G43` reappearing *inside* a single column rather than between columns.

**What/where reduces to a choice of space.** The paper's account of the dorsal/ventral split: identical machinery, different anchoring — "what" regions run grid cells in **allocentric, object-centred** space, "where" regions in **egocentric, body-centred** space. The displacement operation is the same in both; only the interpretation of the resulting vector changes.

---

## Voting: the second output channel

| Output | Source | Destination | Purpose |
|---|---|---|---|
| Action | **L5** | Subcortical effectors (+ efference copy to L6) | Move the sensor |
| Vote | **L2/3** | *Laterally*, to L2/3 of other columns | Resolve ambiguity by consensus |

The coffee-cup example is the mechanism in miniature: the index finger's columns sense a circular rim → hypotheses {cup, saucer, wine glass}; the thumb's columns sense a C-shaped handle → {cup, teapot, drawer handle}. Multiple hypotheses are **partially active simultaneously in one column** — the column holds a distribution, not a decision. Lateral votes add convergent evidence to the single hypothesis in the intersection; unsupported hypotheses lose the reinforcement race and are suppressed by their neighbours. The dynamics named are **rich-get-richer plus lateral inhibition**, converging in a fraction of a second.

**What this buys the framing.** Recognition is set intersection across independently-derived hypothesis sets, executed as network dynamics: each column's local evidence is ambiguous, and the object is the unique element consistent with *all* columns' features **at their respective locations**. In [[wiki/concepts/latent-graph-discovery.md]]'s terms this is parallel partial-graph estimation with consensus replacing a single posterior — and the pose constraint is what makes it stronger than a vote over labels, since a wrong-pose match is eliminated even when the feature matches.

**What it still does not specify** (the gap [[wiki/concepts/distributed-reference-frames.md]] recorded as G43 stays open):

- Nothing says how votes are made **commensurate**. Two columns holding object-anchored frames must agree on a pose in a *shared* frame; the talk's account votes over object identity and quietly assumes the location terms already line up. The registration result on [[wiki/concepts/distributed-reference-frames.md]] (grid angles aligned across regions) is the only evidence in the wiki that this alignment might come for free.
- Nothing says what happens when consensus **fails** — no stopping rule, no null hypothesis, no mechanism for instantiating a frame for a genuinely new object.
- Nothing counts the voters: which columns are eligible to vote on one object, and how that set is delimited, is unspecified.

---

## Hierarchy, rethought: level-skipping and object scale

The paper's argument against the feature-extraction hierarchy is not that hierarchy is absent but that **what travels up it is already an object**:

| Observation | Consequence drawn |
|---|---|
| Projections skip levels — LGN reaches V1, V2 and V4, not just V1; "the rule, not the exception" | V1 and V2 are *both* operating on retinal input, in parallel, not in series |
| LGN→V2 is more divergent than LGN→V1 | **Prediction: V2's cortical grid scale is larger than V1's.** Input convergence × grid scale sets the *range of object sizes* a region can model |
| ~**40%** of all possible region-to-region connections exist (Felleman & Van Essen 1991) | Far more than a pure hierarchy needs; the surplus is the lateral voting channel |
| Long-range connections between hemispheres and *across modalities at the lowest levels*, terminating outside feedforward/feedback layers | Not hierarchical at all — they connect regions that often observe the same object at the same time |

Two consequences worth carrying: **sensor fusion is decentralised** — there is no single multimodal model of a cup, but hundreds of unimodal partial models reaching consensus, so nothing in the architecture ever merges modalities into one representation; and **the theory is nearly unfalsifiable by single-unit recording as stated**, since a column's object representation is a population code whose individual neurons participate in many objects and "if observed in isolation will appear to represent sensory features, not objects" — the authors say so.

The smallest printed letters are recognised in V1 *and only V1*; larger ones in both; larger still only in V2. Scale, not abstraction, is what the levels differ in.

---

## The recursion into abstraction

The step that makes this a reasoning theory rather than a perception theory:

| Level | Input to L4 | "Movement" issued by L5 | Location code in L6 |
|---|---|---|---|
| Primary sensory | Thalamic sensory data | Effector movement (eye, finger) | Sensor position on the object |
| Higher cortical | **L2/3 output of lower columns** — i.e. another column's settled percept | A command selecting *which lower columns supply the next input* — attention | Position in whatever space that column's inputs span |
| Abstract | Concepts, recalled facts | Recall a fact, apply a rule, focus on a sub-problem | Position in a conceptual space |

So a chain of reasoning is a **path through a reference frame**, each inferential step a movement, and the same predict-then-move loop that explores a statue explores a proof. The paper's slogan: *all knowledge is stored at locations relative to location spaces, and thinking is movement through those spaces.* `(tentative — asserted with no worked example, no model and no data; the paper's only empirical support is that human grid signatures were found in frontal and parietal cortex during cognitive tasks far from sensory input — Doeller 2010, Jacobs 2013, Constantinescu 2016.)`

**The paper states three success conditions for such a model, and this is the most usable thing in it** — they are what a learner must get right, and each is a gap:

| Condition | Status |
|---|---|
| Discover the correct **dimensionality** of the object's space | No mechanism anywhere; the space's topology and dimension are architectural choices in every implementation the wiki holds (`G47`) |
| Learn how **movements update locations** in that space | Path integration, where the actions compose — `G41` decides whether they do |
| **Associate features with locations** in that space | The binding step; TEM's written memory is the wiki's only version with an equation |

**And it names the failure mode, which is sharper than the success conditions.** A column fed retinal input while integrating *finger* movement learns nothing: the traversed location space does not map onto the space over which the inputs change. Learning fails not from insufficient data but from a **mispairing of the movement space with the input space**. `(brainstorm)` This is a falsifiable prediction about machine world-models: an action-conditioned predictor given an action stream that does not generate its observation stream should fail in a *characteristic* way — degenerate to observation-only prediction rather than degrade smoothly — and no ablation in the wiki tests it. It is also the reason cross-embodiment transfer is hard ([[wiki/concepts/cross-embodiment-transfer.md]]): the movement space changed while the input space did not.

**(brainstorm) The two commitments this makes that the wiki's other abstraction accounts do not.** (i) An abstract step must be an *action the system emits*, so the inference operators are typed and enumerable rather than being an unconstrained function of the state — which is the composition precondition of [[wiki/concepts/path-integration.md]] (G41) restated as an architectural requirement, and it predicts that domains whose operators do not compose ("knows", on that page's table) should be exactly the ones humans reason about badly without external aids. (ii) Attention is *motor*, so the controller [[wiki/concepts/attention.md]] and G15 keep asking for is not an extra module: it is the same L5 output path, and it is trained by the same prediction error as physical movement.

---

## Comparison

| | Thousand Brains | [[wiki/concepts/cognitive-map.md]] (single map) | [[wiki/entities/tolman-eichenbaum-machine.md]] | [[wiki/concepts/predictive-coding-free-energy.md]] |
|---|---|---|---|---|
| Number of models of one object | thousands, partial | one | one | one hierarchy |
| Frame anchored to | the object | the world/environment | the environment | — |
| Integration across modules | lateral voting | none needed | none | hierarchical message passing |
| Location code | per column, L6 | entorhinal `g` | `g`, one code reused | not a component |
| Binding operator | dendritic priming (L1) × drive (L4) | conjunctive place cell `p = f(g, x)` | Hebbian memory `M`, `p = f(g̃ ⊙ x̃)` | precision-weighted residual |
| Built? | **No** — no equations, no simulation in this source | n/a | yes | partially |

---

## Limitations

| Limit | Consequence |
|---|---|
| No formal model in **either** source | Every claim above is a wiring diagram plus a story; nothing is written as an update equation, and no result is reported. The paper's own supporting simulations live in companion papers (Hawkins et al. 2017; Lewis et al. 2018), not here |
| The layer assignment is an analogy, now with connectivity behind it | "L4 ≈ LEC, L6 ≈ MEC, L2/3 ≈ hippocampus" is argued from function plus synapse counts, not from homology or from tract-tracing between the assigned partners |
| Cortical grid cells in L6a are the load-bearing prediction and remain untested | The wiki's evidence for cortical grids is [[wiki/concepts/distributed-reference-frames.md]]'s roundup, with its own detector caveat ([[wiki/empirical-tensions.md]] T37); the S1/V2 recordings were *not* layer-restricted, so the specific L6a claim has no data either way |
| Displacement cells do not exist | The theory's newest and most compositionally useful object is a predicted cell class with zero recordings, whose proposed substrate requires a time-multiplexing convention (phase or firing pattern) that is named and never specified (`T344`) |
| Orientation is missing | The paper predicts a per-column head-direction analogue — knowing a finger is *at* a location on a cup is insufficient without knowing how it is rotated — and states it has no evidence for it, no candidate cell type, and no account of how it interacts with the grid and displacement codes |
| The location code may not be unique enough | Grid modules are not sparse; the authors' own fallbacks are more modules, sub-modules (Gu et al. 2018) or conjunctive cells, none of them worked through |
| A population-code escape hatch | The theory predicts that its object representations will *look like* feature selectivity to a single electrode, which insulates it from the most available disconfirming measurement |
| Uniformity is doing heavy lifting | [[wiki/concepts/canonical-cortical-microcircuit.md]] measures what is conserved (E/I ratio, motif) and what is not (interneuron composition, spine counts, the lateral patches themselves — absent in rodent V1/S1), and the patch system is the very substrate voting would need |
| Voting is stipulated | See the three unspecified items above; the wiki's only *named* mechanism for it comes from a different source (iterated soft winner-take-all, Douglas & Martin 2004) and that too is labelled a hypothesis |
| The talk concedes the scope | "Many aspects of brain function don't fit so neatly into this picture" |
| Nothing outside neocortex is modelled | Thalamus appears only as a relay, and basal ganglia, cerebellum and neuromodulation are absent — the theory is a cortex theory being offered as a theory of intelligence ([[wiki/entities/cerebellum.md]]) |

---

## Connections

- **[[wiki/concepts/distributed-reference-frames.md]]** — the wiki's page for this theory's central claim, seen from the evidence side; this page supplies the circuit-level content that page cites and does not carry (the L4/L5/L6/L2-3 assignment, the two output channels), and inherits its detector caveat and its open arbitration gap G43.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the measured anatomy this theory assigns functions to. The assignments are partly in tension with it: L6 is the source of the *modulator*-type projections there, yet carries the location code that determines what a column represents here, and the L5→L6 efference copy is an edge that graph contains but reads as a plain interlaminar link. The hodological re-description there is a second problem for the layer-by-layer assignment: L5B and L6 each hold **two** classes with opposite profiles (broadcast-output PT beside telencephalon-only IT; near-silent corticothalamic CT beside L6 IT), so "layer 5 acts, layer 6 holds the location code" names a mixture rather than a population ([[wiki/empirical-tensions.md]] `T371`).
- **[[wiki/concepts/path-integration.md]]** — the update rule this theory replicates per column, with two additions: the displacement is the column's *own* efference copy rather than an externally supplied `a_t`, and in higher areas the action is an attention shift, which extends the composition requirement (G41) from physical to inferential operators.
- **[[wiki/concepts/cognitive-map.md]]** — the direct architectural rival, and this theory's stated *origin*: the map machinery is claimed to be evolutionarily older, miniaturised and copied into every column, so a single anchored map and thousands of object-anchored frames are the same mechanism at two scales.
- **[[wiki/concepts/dendritic-computation.md]]** — supplies the binding operator: the location signal arrives in layer 1 on distal apical tufts and *primes* rather than drives, so "predicted here" is depolarised-but-subthreshold dendritic state and a column's whole hypothesis set is held in that state rather than in spikes.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the framing's parallel-consensus form with a constraint the plain version lacks: each column estimates the same structure from a different input, and agreement is required *at matched locations in a frame*, so a hypothesis surviving consensus has passed a pose test rather than a label test.
- **[[wiki/concepts/attention.md]]** — makes attention a motor output rather than a gating module: the same L5 pathway that moves an effector selects which lower columns supply the next input, so the spotlight controller is trained by sensorimotor prediction error.
- **[[wiki/concepts/compositionality.md]]** — the object-anchored frame as the part-whole primitive: a feature's position *relative to the object* is reusable across scenes, and recognition composes such descriptions by intersection rather than by a learned classifier.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the built single-frame version of the same factorisation (one structural code, rebound per environment) against this theory's thousands of concurrent object-anchored frames, and the contrast that shows what this theory has never paid: TEM states its binding as an equation and reports results.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — shares the "cortex is a predictive modeller" premise and denies its singularity: prediction here is generated by the column's own next movement inside its own frame, not by a top-down residual passed down a hierarchy.
- **[[wiki/concepts/autonomous-pattern-generation.md]]** — an outside reading of this theory as a **reservoir**: thousands of independent columns as basis elements and cortical output as a learned mixture over them (`raw/talk-nd-reservoir-computing.txt`, **(tentative)**). It inverts what the theory says is load-bearing — a random basis works because its elements *differ*, whereas voting works because they *agree* — and it makes the consensus step a trained linear readout, which is a testable alternative to the unspecified arbitration of G43.
- **[[wiki/concepts/spike-encoding-schemes.md]]** — where hierarchical temporal memory sits in the spiking-code taxonomy: it is the applied instance of *synchrony* coding — a spatial pooler learning which input neurons fire together, a temporal memory over the resulting sequences — deployed for anomaly detection and sequence prediction (Auge et al. 2021).
- **[[wiki/entities/global-neuronal-workspace.md]]** — the architectural rival at the level of whether a distinguished global bus is needed at all: thousands of peer models voting to consensus over long-range connections, with no privileged core and no thresholded admission event, against one exclusive workspace that publishes a single content at a time.
- **[[wiki/entities/entorhinal-cortex.md]]** — the anatomy behind this theory's *what*/*where* assignment, and a qualification of it: lateral and medial entorhinal cortex are near-identical circuits distinguished mainly by their afferents, which argues for one column type replicated per input rather than two differently-designed column components (Witter et al. 2017).
- **[[wiki/concepts/prediction-error-neurons.md]]** — agrees that every cortical area predicts its own next input and disagrees on where the prediction comes from: there it is generated inside the column from a movement-updated location code, here it is another area's internal representation delivered over a learned coordinate transformation — and this page's non-hierarchical claim removes the objection that predictive coding requires a strict hierarchy the cortex does not have.
- **[[wiki/concepts/displacement-codes.md]]** — the operator this theory needs once it has thousands of frames: relating two objects *is* differencing two object-anchored location codes, so composition, navigation and frame-conversion are one computation, and an object becomes a set of displacement vectors over parts rather than a set of feature–location pairs.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the theory's stated method, run at full length: name a function the cortex performs, deduce the representations it requires, then look for cells with those properties — with displacement cells as the deduction's output and the falsification risk that carries.
- **[[wiki/concepts/cross-embodiment-transfer.md]]** — the failure mode this theory predicts, generalised: a column fed one modality's input while integrating another effector's movement learns nothing, because the traversed location space does not map onto the space the inputs vary over — which is what changing an embodiment does to a world model.
- **[[wiki/entities/cerebellum.md]]** — the locus this theory declines to name: both make prediction-from-efference-copy central, but here the forward model is replicated per cortical column with an object-anchored location code, and there it is a single subcortical structure with no map at all.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the same "compose by a vector operation" commitment with an opposite role code: random and similarity-destroying there, a metric offset in a shared modular basis here, so this theory's compositions stay comparable to each other while binding's do not.
- **[[wiki/entities/a24b-m2-v1-projection.md]]** — the same claim (every area predicts its own next input from movement) with the opposite anatomy, and the anatomy that has been measured: here the movement-updated location code is internal to the column, there the prediction is manufactured in a distant motor-related area and shipped in already converted to retinotopic coordinates — distinguishable by whether silencing an external source removes the prediction, and it does.
