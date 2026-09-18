# Reference-Frame Transformation

**Converting the *same content* between two coordinate systems by multiplying it against a bank of pre-wired copies of itself, one copy per value of the transform parameter, with exactly one copy disinhibited at a time by an externally computed parameter. The bank is the gain field; the parameter is head direction; the bank is bidirectional, so the *same* weights run perception and imagery and only a scalar gain says which.**

The wiki names this operation constantly — `anchor`, `re-anchor`, "the egocentric↔allocentric conversion", `G39`'s per-instance transform, `distributed-reference-frames`'s Prediction 4 — and until Bicanski & Burgess 2018 ([[wiki/entities/bb-model.md]]) held no page stating it as a circuit. This page holds the operation; the model that implements it, its simulations and its failure modes are on the entity page.

---

## The formalism

Let `A` be a population coding content in frame **A** (allocentric boundary/object vector cells) and `E` a population coding the same content in frame **E** (egocentric, peri-personal). The group relating them is planar rotation, discretised to `K` elements.

```
transform circuit TR = K sublayers, each a full copy of A
  sublayer i is tuned to head direction θ_i                 (K = 20, Δθ = 18°)
  cell (i, j) = "boundary at allocentric bearing j, while facing θ_i"
  W_E→TR^i  and  W_TR→A  are reciprocal and fixed

gating:  r_IP = σ( φ · Σ r_HD − α )        one global interneuron, driven by total HD activity
         every sublayer receives −φ_IP · r_IP  (blanket inhibition)
         sublayer i additionally receives + W_HD→TR^i · r_HD
  ⇒ only the sublayer whose HD tuning matches the current bump escapes inhibition
```

- **Bottom-up (perception):** `E → TR → A`. Sensory drive instantiates `E`; the selected sublayer relays it into `A`.
- **Top-down (imagery/recall):** `A → TR → E`. The store drives `A`; the selected sublayer reconstructs a *viewpoint*.
- **Mode is a scalar.** The off-direction gains are scaled to **5%** of maximum rather than zero, and a single "bleed" parameter `B` slides the two continuously (`B` on one direction, `B⁻¹` on the other). Nothing about the weights changes between encoding and retrieval.

The transform parameter is **not inferred inside the circuit**. It is computed by a separate integrator — a head-direction ring attractor updated by angular velocity — and arrives as an input ([[wiki/concepts/path-integration.md]], [[wiki/entities/anterior-thalamic-nuclei.md]]).

---

## The four properties that make it an architecture rather than a matrix multiply

| Property | Statement | What it denies a reader |
|---|---|---|
| **Banked, not computed** | `K` pre-wired copies of the target population, selected; no rotation is ever applied to a vector | The transform cannot interpolate off the `K` grid — heading resolution is `2π/K` by construction |
| **Externally parameterised** | The group element arrives from an integrator that owns no content | Zeroing the parameter input leaves both representations intact and destroys only the conversion — a factorised lesion signature (Papez-circuit simulation) |
| **Bidirectional on one weight set** | Perception and imagery are the same matrices read in opposite directions | The two directions cannot be trained to different mappings; a machine encoder/decoder pair does not satisfy this |
| **Gated at the interface** | Control is a neuromodulatory gain on the circuit's afferents and efferents, not on either store | The controller cannot select *what* is converted, only *which way* and *how strongly* — `G110` |

**Cost.** `K × |A|` units for a `K`-element group, against `|A|²` for a learned dense map. The gain-field bank is cheaper than a general linear operator whenever `K ≪ |A|`, and it is *only* as expressive as the group it enumerates — which is the point: it cannot represent a transformation outside the installed group, so it cannot be wrong in an unbounded way.

---

## Instantiations

| System | Group | Parameter source | Bank | Status |
|---|---|---|---|---|
| [[wiki/entities/bb-model.md]] (Bicanski & Burgess 2018) | Planar rotation | Head-direction ring attractor (Papez circuit) | 20 sublayers × boundary-vector population, in retrosplenial cortex | Implemented, rate-coded; bank built in a supervised setup phase (400,000 boundary-segment presentations), assumed developmental |
| Parietal gain fields (Salinas & Abbott 1995; Pouget & Sejnowski 1997; Snyder et al. 1998) | Eye/head/body pose | Proprioceptive and oculomotor signals | Posterior parietal and parieto-occipital neurons multiplicatively modulated by pose | Measured; the biological precedent the above copies |
| [[wiki/entities/retrosplenial-cortex.md]] | Planar rotation (Vann et al. 2009) — or *any* perspective shift, including egocentric→egocentric and oblique (Alexander et al. 2023) | Anterodorsal/postsubicular head-direction system | Conjunctive egocentric–allocentric cells — reported in *many* structures, not only here | Contested: `T383`, and the localised version's one downstream prediction is close to null |
| [[wiki/entities/retrosplenial-cortex.md]], measured (Alexander & Nitz 2015) | None installed — three frames (egocentric turn, route position, room location) held jointly | Not applicable; no parameter population is selected | 228 cells whose responses are multiplicative nestings of the three | Measured. A basis for transformations, not a transformation: which map is performed depends entirely on the downstream weights |
| [[wiki/concepts/displacement-codes.md]] | Translation on the grid torus | Attention selecting the two frames to difference | Module-wise subtraction of two grid states | Proposed, not implemented |
| [[wiki/entities/gcq.md]] | Torus translation group | Least-squares fit over `K` codewords to an observation sequence | The codebook | Implemented — but the parameter is *inferred inside*, in one batch, and never re-fitted |
| [[wiki/entities/a24b-m2-v1-projection.md]] | Retinotopy | None — solved at development time by the axon | Topographic wiring | Measured; the degenerate case where `K = 1` and the bank is the map itself |

---

## What the operation buys, beyond coordinates

- **Coherence as a retrieval constraint.** A store holds an enormous number of retrievable combinations; only a small subset is expressible *from a single viewpoint*. Running retrieval through a transform parameterised by one heading is therefore a filter that forces the reconstruction to be self-consistent. This is the mechanism behind "episodic recollection is re-experiencing": the constraint is not a scoring term, it is the interface. Directly relevant to [[wiki/concepts/latent-graph-discovery.md]] — a retrieved subgraph is validated by being renderable from one origin.
- **Mismatch detection in the frame where it is actionable.** Reconstructing top-down while perception drives bottom-up gives a difference signal *in the egocentric frame*, so the novelty signal localises **where in peri-personal space** the world changed, and can be handed directly to attention. A mismatch computed in the allocentric store would say *that* something changed, not *where to look* ([[wiki/concepts/priority-map.md]], [[wiki/concepts/violation-of-expectation.md]]).
- **A generative model for free.** Reading the interface top-down is a generator over scenes with no separate decoder trained — an inference/generation pair sharing weights, in the sense of Káli & Dayan 2001 ([[wiki/concepts/energy-based-models.md]], [[wiki/concepts/predictive-coding-free-energy.md]]).

## The rival implementation: a bank you select from, versus a basis you read out of

The bank above and the measured retrosplenial population are two ways to build the same operation, and they differ in every property that matters to a builder.

| | Gated bank ([[wiki/entities/bb-model.md]]) | Basis-function population (Alexander & Nitz 2015) |
|---|---|---|
| Structure | `K` copies of the target population, one per group element | One population; units are products of positions in `≥2` frames |
| Who chooses the transform | A gate, from an externally computed parameter | The **downstream weight matrix** — nothing inside chooses |
| Frames per circuit | Exactly 2, fixed at wiring time | Any number the tuning spans (3 measured) |
| Resolution | Quantised to `2π/K` | Continuous in the mixed variables |
| Cost | `K × N_A` units at one site | One population, but each downstream map needs its own readout |
| Conflict between frames | Undefined — one parameter bump | Not representable — a "conflict" is just another point in the joint space |
| What it denies | Any transform outside the enumerated group | Nothing, and therefore no guarantee either: expressiveness is unbounded and unconstrained |

**The last two rows are the trade.** The bank cannot be wrong in an unbounded way because it cannot represent anything outside its group; the basis can approximate arbitrary nonlinear maps and therefore has no built-in prior at all. **(brainstorm)** The pair is a clean architectural fork for a machine module: install the group and pay quantisation and a parameter estimator, or install a mixed layer and pay for a learned readout per map plus the absence of any constraint on what it learns. Biology as measured is closer to the second; the one running implementation is the first. Nobody has built the intermediate — a basis-function layer *regularised* toward an enumerated group.

**And the definitional problem sits on the second, not the first.** A bank with a selected sublayer has performed a transformation by construction — the selection event is the operation. A basis-function population has performed nothing until something reads it; conjunctive tuning is exactly what co-representation looks like (`T383`). So the operational criterion `T383` asks for is **not a property of the neural code at all** — it is a property of the readout, and can only be certified by manipulating a downstream population.

---

## Open problems

- **The group outside space is unnamed.** This is `G39`'s standing residue restated at circuit level: the bank enumerates rotations because rotations are what relates two spatial frames. Nothing says what set of transformations relates a stored *abstract* structure to a present one, so there is no bank to build. The operation is fully specified and has no non-spatial instance.
- **Nothing builds the bank.** In the one implementation the `K` sublayers are wired in a supervised setup phase and declared developmental. An unsupervised rule that discovers `K`, discovers the tuning of each sublayer, and keeps the two directions consistent has not been stated.
- **Discretisation is unaccounted.** `K = 20` is a parameter, not a derivation. What sets heading resolution, and what happens between grid points, is unaddressed — and the same question is `T348`'s in vector-code form.
- **The parameter has no measured carrier in the region the operation is assigned to.** The bank needs a head-direction population to select a sublayer; the primary recording finds head-direction tuning in only **6%** of retrosplenial cells, against ~50% carrying turn direction and a majority carrying route position. Whatever the region is doing with its cells, selecting among 20 heading-indexed copies is not what most of them are wired for.
- **Selection is one-hot and assumed reliable.** A single global interneuron thresholds *total* head-direction activity. If the parameter population held two bumps — which is exactly the cue-conflict case `G43` cares about — the gate's behaviour is undefined. The one architecture that most explicitly holds two frames at once has **no arbitration mechanism**, because a single parameter makes disagreement unrepresentable.
- **Converting versus co-representing is still not separated.** Alexander et al. 2023's definitional objection applies in full to the circuit above: conjunctive tuning is what a gain field looks like, and it is also what binding-and-recall of two co-occurring codes looks like. Having an implementation does not supply the readout that tells them apart (`T383`).

---

## Connections

- **[[wiki/entities/bb-model.md]]** — the implementation this page abstracts: the same twenty-sublayer circuit, plus the stores on either side of it, the simulations that exercise it, and the lesion profiles that dissociate it from its own parameter source.
- **[[wiki/entities/retrosplenial-cortex.md]]** — the region the operation is assigned to, and the reason the assignment is contested: `T383` splits on whether this circuit is localised there at all, and the later review generalises the group from planar rotation to perspective shifts of any kind without naming the set they are drawn from.
- **[[wiki/concepts/distributed-reference-frames.md]]** — supplies this page's Prediction 4 in circuit form, and inherits the cost: if conjunctive cells implementing the transform are everywhere, then every module holding a frame needs its own bank and its own parameter feed, and `K × |A|` is paid once per module.
- **[[wiki/concepts/path-integration.md]]** — the parameter source, and the reason the two are separable: the ring attractor that integrates angular velocity owns no content, so the estimator and the applier can be lesioned apart.
- **[[wiki/concepts/vector-coding.md]]** — the code on the allocentric side of the interface: object- and boundary-vector cells are what the bank's sublayers are copies of, and their identity-invariance is why a separate identity stream (perirhinal) has to be bound in.
- **[[wiki/concepts/attractor-dynamics.md]]** — the fork under the buffer proposal: a feedforward gain field settles in one pass, whereas the "short-term buffer during translation" reading implies relaxation, and the implemented circuit sits in between — the gate is feedforward, but the store it writes into is a pattern-completing attractor whose stability is the whole model's single point of failure.
- **[[wiki/concepts/encoding-retrieval-alternation.md]]** — the temporal schedule this interface runs on: the mode scalar is exactly Hasselmo's encoding/retrieval switch, here given a concrete target (the interface gains) and a concrete intermediate setting (partial bleed), which turns theta from a gate into a periodic comparison between memory and perception.
- **[[wiki/concepts/cognitive-map.md]]** — the orientation half of that page's retrieval/orientation split, stated as a circuit: retrieval delivers *which* structure, this interface delivers *where on it the agent stands*, and the second is a lookup into a bank rather than an inference.
- **[[wiki/concepts/displacement-codes.md]]** — the same operation with both ends inside the store: differencing two object-anchored frames is the conversion run frame-to-frame instead of frame-to-viewpoint, and it inherits this page's precondition that the two spaces be commensurate before the operation is defined.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — what the top-down direction is, read as prediction: a store rendering its contents through the interface *is* a generative model over sensory populations, and the bottom-up/top-down gain pair is the precision term that says which of the two currently wins.
- **[[wiki/concepts/violation-of-expectation.md]]** — the readout the interface makes possible: a mismatch computed at the egocentric end carries a location, so expectation violation becomes a pointer rather than a scalar surprise.
- **[[wiki/concepts/population-geometry.md]]** — the same non-linear mixing this page's bank implements by wiring, measured as a population property and with the mixed variables being reference frames rather than task conditions: a basis-function code buys *maps between structured spaces* where condition-mixing buys implementable classifications, and the two are scored by different statistics.
- **[[wiki/concepts/working-memory.md]]** — the alternative home for the buffer: the implemented model holds the egocentric scene only while it is driven, so anything persisting past the drive has to be maintained elsewhere, which the model states and does not supply.
