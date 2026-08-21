# Thousand Brains Theory

**One algorithm, ~150,000 copies: every cortical column runs the hippocampal formation's what/where binding in miniature — a location code updated by an efference copy of its own motor output, bound to the feature currently sensed — so an object is not one representation but thousands of partial models that vote.**

The wiki already carries this theory second-hand: [[wiki/concepts/distributed-reference-frames.md]] cites it (Hawkins et al. 2019, via Chen et al. 2022) for "columns as reference-frame units voting on a pose" and says of the voting that it is "asserted, not specified", and [[wiki/concepts/canonical-cortical-microcircuit.md]] holds the laminar graph the claim presupposes. This page holds the theory's own content: the **layer-by-layer assignment** of the hippocampal circuit onto the six-layer column, the **two-output architecture** (L5 acts, L2/3 votes) that makes voting a distinct channel rather than a metaphor, and the **hierarchy-by-recursion** step that carries the same algorithm into abstract reasoning.

> **Provenance.** `raw/talk-nd-thousand-brains-theory.txt` — explainer talk, no date, summarising Hawkins and the Numenta programme. Secondary; no citations for its evidence claims. Anatomical assignments and the mechanism are the theory's, not this talk's; anything the talk asserts without a named source is marked `(tentative)`.

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
| Medial entorhinal cortex (grid cells) | **where** — a metric coordinate system | **L6** | Every column has its own grid-like population `(tentative — "a growing body of evidence" is asserted with no citation)` |
| (motor system / self-motion input) | supplies the displacement | **L5** | Motor command out to subcortex **plus an efference copy to L6 within the column**, which is what lets L6 path-integrate |
| Hippocampus proper (place cells) | **binding** of what × where | **L2/3** | Receives feature from L4 and location from L6 *indirectly, via thalamus*; learns whole objects |
| — | prediction channel | **L1** | The L6 location signal arrives on distal apical dendrites, **priming** the cells below rather than driving them |

Two things follow that the wiki did not have:

- **The talk's L6→thalamus→L2/3 route makes the location signal a broadcast rather than a within-column wire.** That is a *third* role for thalamus in the wiki, alongside relay and the multiplexer hypothesis of [[wiki/concepts/distributed-reference-frames.md]] — here it is the bus that distributes a column's coordinate to the layers and columns that need it.
- **Priming ≠ driving is load-bearing, not decorative.** The location code sets which L2/3 cells are *predicted*, and the L4 feature decides which of those fire — the two-compartment logic of [[wiki/concepts/dendritic-computation.md]] used as the binding operator itself. Depolarised-but-subthreshold *is* the representation of "expected here", so a column's hypothesis set is held in dendritic state rather than in spiking.

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

## The recursion into abstraction

The step that makes this a reasoning theory rather than a perception theory:

| Level | Input to L4 | "Movement" issued by L5 | Location code in L6 |
|---|---|---|---|
| Primary sensory | Thalamic sensory data | Effector movement (eye, finger) | Sensor position on the object |
| Higher cortical | **L2/3 output of lower columns** — i.e. another column's settled percept | A command selecting *which lower columns supply the next input* — attention | Position in whatever space that column's inputs span |
| Abstract | Concepts, recalled facts | Recall a fact, apply a rule, focus on a sub-problem | Position in a conceptual space |

So a chain of reasoning is a **path through a reference frame**, each inferential step a movement, and the same predict-then-move loop that explores a statue explores a proof. `(tentative — asserted by the talk with no worked example, no model and no data.)`

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
| No formal model in this source | Every claim above is a wiring diagram plus a story; nothing is written as an update equation, and no result is reported |
| The layer assignment is an analogy | "L4 ≈ LEC, L6 ≈ MEC, L2/3 ≈ hippocampus" is argued from function, not from homology or from tract-tracing |
| Cortical grid cells in L6 are the load-bearing prediction and are asserted | The wiki's evidence for them is [[wiki/concepts/distributed-reference-frames.md]]'s roundup, which comes with its own detector caveat ([[wiki/empirical-tensions.md]] T37); the S1/V2 grid recordings were *not* layer-restricted to L6 |
| Uniformity is doing heavy lifting | [[wiki/concepts/canonical-cortical-microcircuit.md]] measures what is conserved (E/I ratio, motif) and what is not (interneuron composition, spine counts, the lateral patches themselves — absent in rodent V1/S1), and the patch system is the very substrate voting would need |
| Voting is stipulated | See the three unspecified items above; the wiki's only *named* mechanism for it comes from a different source (iterated soft winner-take-all, Douglas & Martin 2004) and that too is labelled a hypothesis |
| The talk concedes the scope | "Many aspects of brain function don't fit so neatly into this picture" |

---

## Connections

- **[[wiki/concepts/distributed-reference-frames.md]]** — the wiki's page for this theory's central claim, seen from the evidence side; this page supplies the circuit-level content that page cites and does not carry (the L4/L5/L6/L2-3 assignment, the two output channels), and inherits its detector caveat and its open arbitration gap G43.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the measured anatomy this theory assigns functions to. The assignments are partly in tension with it: L6 is the source of the *modulator*-type projections there, yet carries the location code that determines what a column represents here, and the L5→L6 efference copy is an edge that graph contains but reads as a plain interlaminar link.
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
