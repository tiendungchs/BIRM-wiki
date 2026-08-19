# Pattern Separation and Completion

**One knob, not two mechanisms: a network's *transfer function* mapping input similarity to output similarity. Push output apart where input overlaps (separation) and you can store two similar episodes without interference; pull it together (completion) and you can retrieve a whole episode from a fragment.**

The pair is the hippocampus's answer to the write/read conflict that every fast store faces: the same code that makes storage interference-free makes retrieval from a partial cue fail, and vice versa. Yassa & Stark 2011 is the wiki's evidence base for the claim that this is a real, localisable computation rather than a modelling convenience.

---

## The formalism

Let `s_in` be the similarity of two input patterns and `s_out` the similarity of the representations they evoke. The identity line `Δs_out = Δs_in` is the reference; the *computation* is the deviation:

| Regime | Condition | Effect |
|---|---|---|
| **Separation** | `Δ output > Δ input` — similarity is decreased | Overlapping inputs stored orthogonally; no catastrophic interference |
| **Completion** | `Δ output < Δ input` — similarity is increased | Degraded or partial cues filled in to the stored pattern; generalization over noise |
| **Linear** | `Δ output = Δ input` | Neither; the region relays |

**Two consequences the wiki should carry forward:**

1. Separation and completion are **not** binary region labels. The *same* region does both, at different points on its transfer curve — CA3 completes for small input changes and separates for large ones. What identifies a region is the *shape* of the curve, not which side of the diagonal it sits on.
2. A measurement of the output alone is uninterpretable. Separation is defined relative to the *upstream* input, so claiming a region computes separation requires recording what it received. "Region X's codes were dissimilar" is compatible with X relaying already-dissimilar input.

---

## Where it happens: the trisynaptic circuit

Entorhinal cortex (EC) layer II → dentate gyrus (DG) → CA3 → CA1, a primarily feedforward chain with a bypass:

| Pathway | Property | Computational role |
|---|---|---|
| **Perforant path**, EC II → DG | Distributed EC codes onto a far larger, sparsely firing granule-cell population | Expansion recoding — the substrate of strong, domain-agnostic separation |
| **Mossy fibers**, DG → CA3 | Few, very large "detonator" synapses on proximal apical dendrites; strongly depolarizing | *Forces* a separated code onto CA3 — the write path |
| **Perforant path**, EC II → CA3 (bypassing DG) | Weak, direct | Supplies the retrieval *cue* — the read path |
| **Recurrent collaterals**, CA3 → CA3 | Dense auto-association | Attractor dynamics → completion |
| **Schaffer collaterals**, CA3 → CA1 | — | CA1 relays linearly; hippocampal output is not the DG/CA3 signal |

**The write/read dissociation is anatomical, and it is causal.** Inactivating mossy fibers impairs new learning and spares recall; lesioning the direct EC→CA3 perforant path impairs retrieval and spares encoding. So the same recurrent network is addressed by two different inputs depending on whether it is being written to or read from — which is the wiki's first concrete mechanism for a store that does not have to *choose* between separation and completion globally.

## Transfer curves by subfield

| Region | Curve shape | Evidence |
|---|---|---|
| **DG** | Separates at the *smallest* input changes; steeply nonlinear | Simultaneous DG/CA3 recordings under incremental environment morphs |
| **CA3** | Nonlinear but shifted right: completes for small input changes (cue rotation within a room), separates for large ones (different room) | Cue-mismatch recordings, two-environment recordings, and immediate-early gene (IEG) population imaging — three studies that looked contradictory until plotted against input magnitude |
| **CA1** | Linear — neither separates nor completes | Same studies; human high-resolution fMRI |

**Two codes for separation, not one** (DG/CA3 recordings):

| Mechanism | What changes | When |
|---|---|---|
| **Rate remapping** | Firing rates change within a stable place map; new activity pattern largely orthogonal to old | Smaller input change (medial entorhinal input unchanged) |
| **Global remapping** | Rate *and* place statistically independent — complete reorganization | Larger input change (different room) |

Under global remapping the two subfields differ in *kind*: DG re-codes within the **same** active cells, CA3 recruits a **different population**. Whether these are two mechanisms or one continuum, and what selects between them, is stated as open.

---

## Necessity, not just correlation

| Manipulation | Result | Reads as |
|---|---|---|
| DG lesion (rat) | Fails to re-explore when two objects move 60 cm → 40 cm apart | DG *necessary* for spatial separation |
| NR1 subunit of the NMDA receptor knocked out in DG granule cells | Contextual fear *discrimination* impaired; plain contextual conditioning and water-maze learning spared; CA3 rate remapping disrupted downstream | Separation needs NMDA-receptor plasticity, and the DG's output is what drives CA3 rate remapping |
| CA3 lesion (rat/mouse) | One-trial object-place recall impaired; accuracy collapses when only 1–2 of 4 trained extra-maze cues are present | CA3 *necessary* for completion from a partial cue |
| NR1 knocked out in CA3 | Impaired when familiar cues are removed | Same, plasticity-dependent |
| Ablate adult neurogenesis (x-irradiation) | Impaired at *low* sample-target separation (2 intervening radial-maze arms), unimpaired at high (3–4) | Newborn granule cells matter specifically where separation demand is high |
| Genetically enhance newborn-neuron survival | Better contextual fear discrimination | Gain-of-function in the same direction |

The parametric structure of the last two rows is the methodological point worth importing: the manipulation is scored **as a function of input similarity**, so the claim is about a transfer curve, not about a task.

---

## The knob has a controller

Unregulated separation destroys recall — nothing would ever be recognised as a repeat. The review's Box 1 names the candidate control signals:

| Controller | Direction | Note |
|---|---|---|
| Hilar **mossy cells** (excitatory) | ↑ separation | Under direct CA3→DG backprojection — i.e. the *output* stage sets the *input* stage's bias |
| **HIPP** interneurons targeting the perforant path (inhibitory) | ↓ separation | Same backprojection |
| **Cholinergic** input from medial septum | Switches storage (separation) vs. recall (completion) modes | The closest biological analogue of an explicit write/read mode bit |
| **Noradrenergic** input from locus coeruleus | Unknown | Innervation of the DG polymorphic layer is orders of magnitude denser than elsewhere in the hippocampus |

**(brainstorm)** The cholinergic switch and the CA3→DG backprojection are two different control architectures for the same knob: one *external and global* (a neuromodulator sets the mode for the whole structure), one *internal and closed-loop* (how well CA3 completed the current cue sets how hard DG separates the next input). The second is the interesting one for a machine, because it is a **self-supervised** setting rule — completion error is measurable at runtime without labels, and it is exactly the signal that says "this is a new situation, write it separately" versus "I have this one, retrieve it". Nothing in the wiki implements it (gap G38).

---

## Mapping to the core framing

| Biology | [[wiki/concepts/latent-graph-discovery.md]] element |
|---|---|
| Pattern separation | **De-aliasing** (hardness source 3, gap G2): the same observation at structurally distinct positions must receive distinct codes |
| Pattern completion | **Retrieval / instance binding** (gap G37): find the stored meta-graph fragment this partial observation belongs to |
| The transfer curve | The **allocate-vs-reuse decision**, made continuously and by degree, rather than by a discrete new-node test |
| Mossy-fiber write path vs. perforant-path read path | The store's two ports: what makes an allocate and a retrieve *different operations on the same memory* |
| DG steep, CA3 shifted, CA1 linear | A **cascade** of curves, not one decision — the separation bias is set once at the input and partially undone downstream |
| Neurogenesis | Capacity *added* where separation demand is high, rather than reallocated ([[wiki/concepts/synaptic-plasticity.md]]) |

**(brainstorm) The wiki's two answers to allocate-vs-reuse are now the same question at different resolutions.** [[wiki/concepts/contextual-inference.md]] answers it with a posterior over a growing context library and a nonparametric allocation rule — discrete, probabilistic, and normative. This page answers it with a tunable transfer curve — continuous, mechanistic, and with no probability anywhere. The CA3 transfer curve is what a responsibility posterior *looks like* after it has been compiled into a fixed network: a soft threshold on input similarity, whose steepness plays the role of the concentration parameter `α` and whose position plays the role of the prior over new contexts. If that identification holds, the neuromodulatory controllers above are the biological form of setting `α` online — which is the one thing the nonparametric account leaves as a fitted constant.

---

## What breaks when the knob is stuck

Neurocognitive aging is the wiki's cleanest natural experiment on a mis-set separation bias:

| Finding | Species |
|---|---|
| **Representational rigidity** — the same map is reused across similar environments; bias shifted from separation toward completion | rat, human |
| CA3 neurons show abnormally *elevated* firing, attributed to disinhibition following interneuron and perforant-path deterioration, reinforcing the recurrent network | rat |
| Perforant-path integrity (diffusion imaging) declines with age; the decline correlates with both the rigidity and the behavioural discrimination deficit | rat, human |
| Older adults require *more* dissimilarity before DG/CA3 separates | human |

**Read as an engineering result:** the failure mode of a fast store whose separation bias drifts down is not forgetting — it is **over-generalization**, confidently retrieving an old episode for a new one. Degrading the input pathway (perforant path) shifts the balance toward the recurrent network, i.e. toward completion, i.e. toward hallucinated recall. **(brainstorm)** The analogue in a machine store is a retrieval index whose embedding quality decays while the attractor dynamics on top of it do not: the system does not report failure, it reports a neighbour.

---

## Caveats the review states about its own evidence

- **The Δ-input axis is not calibrated.** Studies alter cue configurations, object identities, rooms, or picture categories, and plot them all as "environmental change". Linearly distorting the environment need not linearly distort the internal representation, so the *position* of a subfield's curve is not comparable across studies. Strictly the axis should be the **neural** input from EC, which is not manipulable.
- **Remapping ≠ separation, stability ≠ completion.** They coincide only when the input patterns were similar-but-not-identical and the upstream input is known.
- **Multi-day discrimination-learning tasks do not isolate separation** unless input similarity is manipulated parametrically with an unimpaired high-dissimilarity control.
- **fMRI cannot resolve DG from CA3**, even at high resolution — which may be the whole source of the human/rodent discrepancy (humans separate at the smallest increments; rodent CA3 completes there), if the blood-oxygen-level-dependent signal is dominated by DG perisynaptic activity.
- **DG/CA3 activity is not hippocampal output.** It passes through CA1, and an overt recognition task recruits separation-consistent activity across the *whole* hippocampus, while DG/CA3 activity is abrupt where behaviour is graded. The mapping from an internal separation signal to behavioural discrimination is unestablished — the same measurement problem [[wiki/concepts/representation-probing.md]] raises for probes.

---

## Open problems

- **What sets the knob?** The controllers are named, none is characterised as a function. See gap G38.
- **Rate vs. global remapping.** What selects the code, and are they combined?
- **Attractor dynamics in CA3 is a hypothesis with one supporting demonstration**, despite being the standard account of completion.
- **Newborn vs. mature granule cells.** Loss/gain-of-function says newborn cells enable separation; a computational account says immature cells are too broadly tuned to separate and instead *integrate* patterns; a reactivation study suggests mature cells may be functionally retired. Unresolved — [[wiki/empirical-tensions.md]] T26.
- **Only mammals evolved a DG.** Birds solve the same computational problem another way, which means the anatomy is one solution rather than the solution — relevant to whether a machine should copy the circuit or the transfer curve.
- **Non-visual and temporal separation are untested** at the subfield level; lesion work suggests spatial and temporal separation dissociate across subfields.
- **Does reward or prediction error regulate separation?** Suggested, not established.

---

## Connections

- **[[wiki/concepts/complementary-learning-systems.md]]** — supplies the mechanism behind the "sparse conjunctive code" that page asserts: separation is what makes the fast store's codes non-overlapping, and it is a tunable transfer curve rather than a fixed sparsity level.
- **[[wiki/concepts/latent-graph-discovery.md]]** — separation is de-aliasing (hardness source 3) and completion is retrieval; the transfer curve is the allocate-vs-reuse decision made by degree.
- **[[wiki/concepts/contextual-inference.md]]** — the same allocate-vs-reuse question answered normatively (a responsibility posterior over a growing library) rather than mechanistically; the transfer curve is what that posterior looks like compiled into fixed circuitry.
- **[[wiki/concepts/continual-learning.md]]** — names catastrophic interference as the problem separation exists to prevent, and supplies the alternative solution family (gate the weights) to this one (orthogonalize the codes before writing).
- **[[wiki/concepts/synaptic-plasticity.md]]** — separation and completion are both NMDA-receptor-dependent, and adult neurogenesis appears here as the capacity-adding mechanism whose learning role that page lists as unestablished.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the same hippocampal-entorhinal anatomy carries both; separation supplies distinct codes for repeated content, while `g` supplies position — two different routes to the same de-aliasing requirement.
- **[[wiki/concepts/event-segmentation.md]]** — a discrete new-event decision and a continuous separation bias are two answers to when experience gets a fresh code; the cholinergic storage/recall switch is a candidate boundary signal.
- **[[wiki/concepts/energy-based-models.md]]** — completion is attractor relaxation, i.e. energy minimisation over the free variables of a partial cue; separation is the constraint that keeps two stored patterns in distinct basins.
- **[[wiki/concepts/subgraph-matching.md]]** — completion from a partial cue is the same query as "does this fragment occur in the store, and where", solved by dynamics rather than by an order embedding.
- **[[wiki/concepts/representation-probing.md]]** — measuring a transfer curve requires recording the *upstream* input, which is the same discipline probes need: an internal code's dissimilarity means nothing without the input's.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — a candidate import of the *scheduling/gating* type rather than the representation type: a mode signal that switches a store between writing separately and reading associatively.
- **[[wiki/concepts/cognitive-map.md]]** — the same transfer curve one level up: the separated unit is a whole map, not an episode, with global/rate remapping as the separation end and all-or-nothing attractor selection under ambiguous cues — in human multivoxel patterns as well as rodent place cells — as the completion end (Epstein et al. 2017).
- **[[wiki/entities/cscg.md]]** — separation reduced to bookkeeping: allocating a fresh clone of an observation *is* the separation operation, with the clone-pool size standing in for the separation/completion bias as a hand-set hyperparameter (gap G38).
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — separation in the service of transfer: conjunctive structure × sensory codes are what makes hippocampal remapping the mechanism of generalisation rather than a source of instability.
