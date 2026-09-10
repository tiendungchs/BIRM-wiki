# Vector Coding

**A location is coded as the *allocentric* (distance, direction) offset from a referent object — in cells that generalise over the referent's identity, size and shape, that are sharply tuned on first exposure to a novel object in a novel room, and that hold their orientation offsets against grid and head-direction cells across environments. It is the measured member of the wiki's vector-code family, and the one whose origin is supplied by the environment rather than by the agent's own trajectory.**

> **Provenance.** `raw/hoydal-2019-object-vector-coding-mec.md` — Høydal, Skytøen, Andersson, Moser & Moser, *Nature* 568:400–404, 2019. Tetrode recordings, superficial medial entorhinal cortex, 1,100 cells / 16 mice, freely foraging. Everything in the first three sections is measurement; the model-side readings are marked.

---

## The measurement

| Quantity | Value |
|---|---|
| Object-vector cells | **162 / 1,100 = 14.7%** — more abundant than grid cells (11.3%) or border cells (5.1%) in the same sample |
| Criterion | New field on object insertion, field centre > 4 cm from object, and vector-map (distance × direction from object centre) correlation between the object trial and a **displaced-object** trial above the 99th shuffle percentile (`r = 0.42`) |
| Fields per cell | 65% one, 33% two, 2% three. Multi-field cells are **not** latent grids — a grid lattice extrapolated from the two fields scores `Z` median `−0.12` (n = 56) |
| Reference frame | **Allocentric.** Only 10/162 cells exceed the 99th shuffle percentile for egocentric (heading-relative) modulation |
| Field shape | Gaussian in vector space, `f(d) = a·exp(−dᵀAd) + b`; elliptic fit beats circular, median aspect ratio 1.6 (25th–75th: 1.3–2.0) |
| Vector range | Full 360° azimuth, wide span of distances; median object-vector field sits 21.4 ± 2.6 cm from the object |

## What generalises, and what the generalisation costs

| Manipulation | Result | Reading |
|---|---|---|
| **Object identity** (2–6 distinct objects in one arena) | Fields appear for **51/52 object–cell pairs**, at near-identical distance and orientation from each object | The cell codes a *vector*, not an object. Contrast CA1 landmark-vector cells, which discriminate between objects — the `g`/`x` invariance split, measured cell by cell ([[wiki/concepts/abstract-structural-codes.md]]) |
| **Novel room + novel objects, first exposure** (n = 14) | Every cell with a vector field in the familiar room had one immediately in the novel room; spatial information equal; after rotation to best alignment, vector maps correlate highly — the **distance metric is preserved** | No experience-dependent emergence. Contrast CA1 landmark-vector cells, which emerge slowly. The basis is available before the environment is |
| **Ensemble structure across rooms** | Pairwise orientation offsets are preserved between simultaneously recorded cells (`P = 2.6 × 10⁻⁶` vs shuffled), and equally for object-vector ↔ head-direction and object-vector ↔ grid pairs; preserved between square and circular arenas | One low-dimensional network, rigid across environments — the same fixed-offset signature grid and head-direction populations show |
| **Object elongation** (prism 6.75 → 62.5 cm) | Fields survive in 92/96 instances; field length grows with object length (`P = 0.007`); fields anchor preferentially to the object's **ends** | An extended object is read as its endpoints, not as a surface — the same decomposition [[wiki/entities/state-space-composition.md]] hand-codes ("a wall is *two* vector populations, one per end") |
| **Object diameter** (cylinder 2 → 20 cm) | Vector maps correlate 0.80 ± 0.001 across all diameters; no effect on field size — the vector is measured from the **perimeter** | Scale-invariant in the referent's size |
| **Object height** (2 → 40 cm) | Taller preferred; only 43% of cells respond at 2 cm | The referent must be salient enough to be *segmented*; the node-definition problem enters here ([[wiki/concepts/node-definition-problem.md]]) |

## The three separations that make it a distinct code

| Against | Test | Result |
|---|---|---|
| **Border cells** | Suspend a wall 15 cm above the floor (visible, not obstructing), then lower it | Border cells largely **fail** on the suspended wall and fire when it is lowered — border firing tracks **obstruction of the path**, not distance from a surface |
| **Border cells (converse)** | Suspend the *object* 15 cm above the floor | **32/32** object-vector cells keep their fields, rates unchanged — object-vector firing is independent of whether the referent affects the trajectory |
| **Boundary-vector cells** | Scan the open-field sample | Only 20/840 cells pass a boundary-vector criterion, and 19 of those 20 have fields encroaching on the wall; object-vector field–object distances are far larger (`U = 703`, `P = 9 × 10⁻⁹`). For the 15 cells passing *both* criteria: object-vector field 21.4 ± 2.6 cm from object vs border field 7.6 ± 0.6 cm from wall |
| **Lateral-entorhinal object cells** | — | Those fire *at* the object; object-vector cells fire in the space *between* objects, which is what makes them a position code rather than a detection |

**The cue dependence, and it is the opposite of the grid's.** In complete darkness (n = 21 cells, same session, mouse never removed) spatial information (`P = 1.1 × 10⁻⁴`), spatial coherence (`P = 6.0 × 10⁻⁵`), peak rate (`P = 6.9 × 10⁻⁵`) and mean rate (`P = 8.0 × 10⁻⁴`) all fall, while head-direction tuning **rises** (`P = 0.005`). So in one region, two structural codes with opposite anchoring: the grid survives darkness on self-motion alone (Dannenberg et al. 2020, `T46`), the object vector degrades because its origin is a *visually measured* landmark. Logged as `T348` against the assumption that vector blocks are path-integrable.

---

## What it settles for the wiki

- **The basis-function prediction now has a primary.** [[wiki/entities/tolman-eichenbaum-machine.md]] derives grid, band, border and object-vector units from next-observation prediction alone and predicts the invariance split (structural layer generalises over object identity, conjunctive layer stays object-specific). Both halves are here in recordings: MEC object-vector cells generalise across objects and rooms, CA1 landmark-vector cells do not. Bears on `T38` — the units are not an artefact of a spatial readout, since the biology has them too.
- **The composition model's primitive is real, its key property is not tested.** [[wiki/entities/state-space-composition.md]] builds state spaces out of object-, border- and reward-vector blocks *because* each is "a complete path-integrable map in its referent's own frame". The map, the generalisation and the endpoint decomposition are confirmed here; the **path-integrability** is what the darkness result puts in doubt (`T348`), and it is the property offline construction by replay depends on.
- **A worked case of a free anchor** (`G39`). The group is installed — allocentric direction × distance, shared with the head-direction and grid populations, rigid across rooms — and 162 cells *enumerate its elements*, which is exactly the "installed group **plus** a population enumerating it" that `G39` extracts from the M2 → auditory-cortex filter. What the environment supplies is only the **origin**: one salient object. So the orientation half of retrieval is solved without solving the identity half; the code cannot say *which* object it is anchored to.
- **The measured neighbour of an unmeasured cell class.** [[wiki/concepts/displacement-codes.md]] predicts displacement cells (location − location, across two object spaces) and notes no recording exists. Object-vector cells are the agent-to-object case of the same algebra, measured: the referent is a real object, the code is metric and allocentric, and it generalises over the referent. What is still missing is the *object-to-object* case, where neither endpoint is the agent.

---

## Open problems

- **Where the vector comes from.** No mechanism: the paper reports the code and does not derive it. Candidate inputs — postrhinal/visual afferents to medial entorhinal cortex ([[wiki/entities/entorhinal-cortex.md]]), an egocentric bearing signal converted to allocentric by the head-direction code — are neither measured nor excluded here.
- **Object identity is not in the code.** Generalisation over objects is a feature for reuse and a defect for binding: a downstream reader given only object-vector activity cannot tell which of six objects it is 30 cm east of. Whatever supplies the conjunction has to come from elsewhere (lateral entorhinal object cells, hippocampal conjunction), and nothing measures the join.
- **Nothing says which object becomes the referent.** Height and contrast matter (43% response at 2 cm); no rule, and no account of what happens when six objects are present and each cell must pick — the paper reports fields around *all* of them, which multiplies the code rather than selecting.
- **Rodent, spatial, and physical.** No test of a vector code over an abstract referent, which is what the wiki would need — `G39`'s standing complaint that nothing says what a landmark is outside space.
- **(brainstorm) The cheapest reading for a builder.** A vector-coding layer is a *relative* position encoder whose origin is a pointer into the observation, learned once and reused. If the origin can be set by attention rather than by salience, the same layer computes "position relative to whatever I am currently attending to" — which is the serialisation [[wiki/concepts/displacement-codes.md]] needs, with a measured code underneath instead of a predicted one.

---

## Connections

- **[[wiki/concepts/displacement-codes.md]]** — the same "a relation is a vector in the location format" algebra, with the agent as one endpoint: this page supplies the measured, allocentric, referent-generalising version of a cell class that page can only predict, and leaves the object-to-object case still unrecorded.
- **[[wiki/concepts/abstract-structural-codes.md]]** — a cell-by-cell measurement of the `g`/`x` invariance split: object-vector cells in the structural layer generalise over object identity in the same session in which CA1 landmark-vector cells do not, so the split is a property of the tissue and not only of a model's factorisation.
- **[[wiki/concepts/path-integration.md]]** — the complementary anchoring discipline in one region: the grid integrator survives darkness on self-motion, this code degrades in it, so the two structural codes in medial entorhinal cortex fail under opposite deprivations (`T46`, `T348`).
- **[[wiki/entities/entorhinal-cortex.md]]** — the circuit this code lives in: superficial medial entorhinal layers, whose *only* lateral interaction between stellates is disynaptic inhibition, and which receive the postrhinal/visual afferents this visually-dependent code would need.
- **[[wiki/entities/state-space-composition.md]]** — supplies the measured version of that model's building block, including the endpoint decomposition of an extended object it hand-codes, and puts the block's path-integrability in question.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the model that predicts this cell class from transition statistics alone; the recordings supply the invariance signature it predicts, and remove the readout-artefact explanation for it.
- **[[wiki/concepts/cognitive-map.md]]** — sharpens what "the map is anchored by boundaries rather than objects" means: objects do anchor a code, just not the *global* one — a per-object frame that generalises, alongside a boundary-anchored global frame that does not.
- **[[wiki/concepts/node-definition-problem.md]]** — the referent must be segmented before it can be an origin, and the height threshold (43% response at 2 cm) is the wiki's one quantitative handle on when a thing is salient enough to become a node.
- **[[wiki/concepts/compositionality.md]]** — a compositional primitive with its own frame, measured: an extended object is represented as vectors to its endpoints, so the parts a composition operates over are recovered by the code rather than supplied by the modeller.
- **[[wiki/entities/visual-predictive-coder.md]]** — a displacement code with neither a referent object nor a periodic basis: subtracting the thresholded 128-unit codes of two locations is linearly decodable to distance (`r` = 0.718) and direction (`r` = 0.924), so what the vector algebra needs is fields wide enough to *overlap* (mean 9.79% of the arena), not a torus and not a landmark.
