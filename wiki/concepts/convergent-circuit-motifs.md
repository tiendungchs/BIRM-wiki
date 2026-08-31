# Convergent Circuit Motifs

**When lineages that separated 400–600 Mya independently arrive at the *same* circuit topology for the same computation, the motif is evidence of a constraint imposed by the problem rather than a contingency of one nervous system — which makes independent re-invention count a selection criterion for [[wiki/concepts/neuroscience-ai-transfer.md]].**

The transfer page's three arguments for looking at the brain (sparse search space, existence proof, validation channel) all treat *the* brain as one sample. Convergence turns a single existence proof into a repeated experiment: the same problem posed to non-communicating optimisers, run to fixation independently. A motif that recurs across mollusc, arthropod, annelid and vertebrate is a much stronger prior over where to look than a motif observed once in a mouse.

Source: `raw/chat-nd-convergent-spatial-memory.md` — an unrefereed conversation. **Every factual row below is `(tentative)`**; the census is a pointer list to be verified paper-by-paper, not a finding.

---

## The census — allocentric world-model structures by lineage `(tentative)`

| Structure | Clade | Claimed independent origin | What is claimed for it |
|---|---|---|---|
| Hippocampal formation | Vertebrates | ~500 Mya | The wiki's reference case ([[wiki/concepts/cognitive-map.md]], [[wiki/concepts/pattern-separation-completion.md]]) |
| Mushroom bodies | Insects; **spiders contested** | ~400–500 Mya | Kenyon-cell expansion → compact output lobes; multimodal, sparse. The spider half of this row is **not safe**: salticids are generally described as *lacking* mushroom bodies, the candidate arachnid analogue being the arcuate body. Both sources that assert it are unrefereed (`raw/chat-nd-convergent-spatial-memory.md`, `raw/ihadnoclue-nd-jumping-spiders-spatial-cognition.md`) — see `T295` |
| Central complex (ellipsoid + protocerebral bridge) | Insects | ~400 Mya | Ring-attractor heading code, angular path integration, goal vectors ([[wiki/entities/fly-central-complex.md]]) |
| Vertical lobe | Cephalopods | ~500 Mya | Amacrine-cell fan-out → compressed output; lesions impair spatial/contextual learning; den return by novel routes |
| Hemiellipsoid bodies | Malacostracan crustaceans | ~400 Mya | Sister structure to mushroom bodies, independently enlarged; place-cell-like activity claimed in crabs |
| Mushroom-body homologs | Polychaete annelids (*Platynereis*, *Nereis*) | ~600 Mya | Same motif; **deep homology vs convergence is unsettled**, which makes this row not usable as an independent sample |

The annelid row shows the method's main failure mode in one line: an "independent" re-invention only counts if the independence is established. Homology inflates the apparent sample size at exactly the point where the argument depends on it.

---

## The two motifs that recur

**M1 — expansion → compression.** `many inputs → wide sparse layer → compact output layer`. Instantiated as dentate gyrus → CA3, Kenyon cells → mushroom-body output neurons, amacrine cells → vertical-lobe output. The wiki already has this as two separate accounts that never cite an evolutionary argument: separation-then-completion ([[wiki/concepts/pattern-separation-completion.md]]) and expansion recoding for separability ([[wiki/concepts/sparse-distributed-representations.md]], Cover / Kanerva). Convergence adds nothing to *how* it works and something to *whether it is forced*: the same three-stage shape is reached from at least three independent starting anatomies.

**M2 — cyclic attractor + velocity shift + landmark reset.** A low-dimensional state on a circular manifold, moved by a self-motion term and reset by a sensory term. Vertebrate head-direction system and insect central complex are the two clean instances; the fly case is the one where the topology is anatomical rather than inferred ([[wiki/entities/fly-central-complex.md]]). This is `z_t = f(W z_{t-1} + B a_t)` with an observation-driven correction — the predict/correct decomposition of [[wiki/concepts/path-integration.md]], reached twice.

The two motifs answer different halves of [[wiki/concepts/latent-graph-discovery.md]]: M1 supplies non-colliding addresses for states, M2 supplies a code whose arithmetic is the graph's edges.

---

## What the argument licenses, and what it does not

| Inference | Status |
|---|---|
| "Recurs across lineages" → the problem admits few solutions at this level of description | Reasonable, if independence is established |
| → the motif is *optimal* | Not licensed. Convergence selects for reachable-and-adequate, not optimal |
| → the motif should be imported into a machine | **Weakest link.** Every lineage shares the same substrate constraints — wiring cost in 3-D, metabolic budget, no weight transport, limited fan-in. Convergence across lineages with a common substrate is evidence about the *substrate*, not about the computation. A GPU pays none of those costs |
| → the description level is the right one | Unclear. The motif is stated at a level (three stages, wide middle) coarse enough that unrelated computations satisfy it |

This is Morgan's Canon ([[wiki/concepts/shortcut-learning.md]]) applied to phylogeny: matched topology across taxa licenses no inference about matched algorithm. The honest use of the census is **prioritisation** — read the convergent motifs first — not justification.

**(brainstorm)** The sharpest version of the argument survives the substrate objection only for M1, and only in one form: expansion-then-compression is also what Cover's theorem and Kanerva's derivation recommend *from first principles with no substrate in them*. Where an independently-derived mathematical argument and a repeated evolutionary outcome agree, the substrate confound is broken. That is the test to apply to any candidate motif before importing it, and M2 currently fails it — the wiki has no substrate-free derivation of why the state manifold should be a ring rather than, say, a learned unconstrained latent.

---

## The neuron-budget datapoint: salticid detour planning `(tentative)`

Source: `raw/ihadnoclue-nd-jumping-spiders-spatial-cognition.md` — a popular-science aggregator page, **lower reliability than anything else cited on this page**. Its named attributions could not be checked and at least one structural claim is contradicted by standard arachnid neuroanatomy (see the census row and `T295`). What survives is the one quantity the wiki has no other source for.

| Claim | Reading for a builder |
|---|---|
| Salticid (*Phidippus*, *Portia*-type) **detour behaviour**: the spider views prey, loses line of sight, then takes a route that initially leads *away* from it | The behavioural signature of planning over a latent graph with the goal unobserved — [[wiki/concepts/simulation-based-planning.md]]'s re-goaling test in its minimal form. Corroborated in the refereed salticid literature independently of this source |
| Achieved on **< 5×10⁵ neurons** total (vs. ~8.6×10¹⁰ human) | An upper bound on the circuit size that route planning over an unobserved goal requires — five orders of magnitude below the vertebrate case ([[wiki/concepts/circuit-size-separation.md]], [[wiki/concepts/intelligence-density.md]]) |
| **No hippocampus**; allocentric behaviour anyway | Consistent with the census's thesis: the capability is not tied to the vertebrate structure |
| Cross-modal integration (principal + secondary eyes, trichobothria, leg airflow sensors) with neurons claimed to respond maximally when visual and vibrational cues are **spatially and temporally coherent** | A coherence gate rather than a sum — the multimodal binding criterion [[wiki/concepts/cross-modal-grounding.md]] asks for, at this budget `(tentative)` |
| Interception: jumping to where prey *will* be | Forward model over a moving target, not a servo on current position |
| "Spider place cells" in mushroom bodies, stable under visual-cue change | **Do not use.** Structure attribution contradicted (`T295`); no citation recoverable |

**(brainstorm)** The budget number is the only thing on this page that bears on the substrate confound from the other direction. The census's weakest link is that every lineage shares wiring-cost and metabolic constraints, so convergence may be evidence about the substrate. A miniaturised nervous system is the *extreme* of that constraint — if the same motif survives a five-order-of-magnitude reduction in units, the motif is being held by the task, not by the budget, because the budget changed by 10⁵ and the behaviour did not. That makes salticids the highest-value row in the census to verify, and currently the worst-sourced.

## Target selection: which structure to model `(tentative)`

The source's second question is a builder's question — of the convergent instances, which is cheapest to understand well enough to copy — and its answer is the insect central complex.

| | Hippocampal formation | Insect central complex |
|---|---|---|
| Regions that must be modelled together | Hippocampus + entorhinal + prefrontal + striatum + thalamus | Largely self-contained |
| Connectome | Not available | *Drosophila* hemibrain / FAFB / larval — complete |
| Core computation | Contested | Ring attractor, imaged directly in a behaving animal (Seelig & Jayaraman 2015) |
| Cell types for spatial navigation | 10+ (place, grid, border, speed, theta-modulated…) | ~4–5 |
| Core circuit size | ~10⁶ neurons | ~80 E-PG cells |
| Learning rule | Unsettled | Hebbian + neuromodulation, mapped |

The claim worth keeping is not "the fly is simpler" but **"the fly's world model is separable from its policy"**: ring + integrator (state) is decoupled from goal vector → motor error (action), where the hippocampal formation's state estimate is entangled with cortical, striatal and thalamic loops that the wiki has separate pages for. A builder gets a testable world-model module without also having to model the controller.

Suggested reading order from the source, unverified: Seelig & Jayaraman 2015 (ring attractor, *Nature*) → Stone et al. 2017 (anatomically constrained bee path integrator) → Turner-Evans et al. 2017/2020 → Hulse et al. 2021 (*Neuron*, full CX framework) → Lyu et al. 2022 (vector-based goal navigation).

---

## The machine translation `(tentative)`

| Circuit element | ML primitive |
|---|---|
| E-PG ring attractor | Recurrent layer with cosine (circulant) connectivity, fixed-point dynamics on `S¹` |
| P-EN velocity shift | RNN/GRU latent updated by an action input — [[wiki/concepts/path-integration.md]] |
| Landmark correction | Attention over observations, writing a *reset* rather than a blend (the fly preserves its offset) |
| PFL/FC2 goal vector | Separate goal embedding, action = vector difference |
| Dopaminergic gating | Learning-rate modulation on a Hebbian update — [[wiki/concepts/neuromodulatory-metaparameters.md]] |

**Why this generalises, per the source:** the circuit stores no trajectories. It holds a compressed continuous state updated by two independent streams, so a novel environment supplies new landmark corrections to the *same* ring and there is nothing trajectory-specific to overfit. That is the same argument [[wiki/concepts/path-integration.md]] makes for grid codes — transfer is free because all positions are treated alike — arrived at from the invertebrate side.

---

## Open problems

- **No independence audit.** Every row of the census needs its phylogenetic independence checked before it counts as a sample; the annelid row is already contested by its own literature.
- **The description level is unspecified.** "Expansion → compression" is satisfied by any wide-hidden-layer network. Without a sharper statement, convergence cannot discriminate between mechanisms.
- **The substrate confound has no proposed control.** Comparing lineages does not vary the substrate; only comparing a brain to a machine solution derived under different costs would.
- **Is M2 forced or contingent?** No substrate-free derivation exists for the ring topology, which is exactly the case where convergence would be doing real work if it held up.
- **The best test of the substrate confound is the worst-sourced row.** Salticid detour planning at <5×10⁵ neurons would be the census's strongest datapoint (constraint varied by 10⁵, capability held), and the wiki's only source for it is a popular aggregator whose neuroanatomy is wrong. Needs a refereed replacement (Tarsitano & Jackson; Cross & Jackson; Steinhoff on the arachnid arcuate body).
- **Nothing in the wiki uses convergence as a selection criterion.** Every transfer in [[wiki/concepts/neuroscience-ai-transfer.md]]'s track record was sourced from one taxon (mostly rodent, macaque or human), so the criterion proposed here has never been applied.

---

## Connections

- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — supplies a fourth argument to that page's three: independent re-invention across lineages turns the single-existence-proof premise into a repeated experiment, and gives a criterion (verify independence, then check for a substrate-free derivation) for ranking candidate imports.
- **[[wiki/entities/fly-central-complex.md]]** — the census's best-characterised member and this page's recommended modelling target: the only convergent instance where the ring topology is anatomical, the population is imaged whole, and the world model is separable from the goal/action system.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the mechanistic account of motif M1; this page adds that the same expansion→compression shape is reached independently by cephalopod, arthropod and vertebrate circuits, which is an argument about whether the motif is forced rather than about how it works.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — supplies the substrate-free half of the M1 argument: Cover's theorem and Kanerva's derivation recommend expansion recoding from mathematics alone, so the evolutionary repetition and the derivation agree and the wiring-cost confound is broken for this motif only.
- **[[wiki/concepts/path-integration.md]]** — motif M2 is that page's update rule plus a sensory reset, and the fly/rodent pair is its second independent instantiation; the invertebrate version reaches the same "generalisation is free because the code is action-composed" conclusion from a ~80-neuron circuit.
- **[[wiki/concepts/attractor-dynamics.md]]** — the ring attractor is the continuous-attractor row of that page's typology, and this page asks the question that typology does not: whether a circular manifold is computationally forced or is what a 3-D wiring budget makes cheap.
- **[[wiki/concepts/cognitive-map.md]]** — the allocentric world model is the capability the whole census is a census *of*; this page contributes the claim that the anchoring operation (reusable code + instance offset) recurs across phyla, which is evidence the two-part factorisation is the right decomposition.
- **[[wiki/concepts/shortcut-learning.md]]** — supplies Morgan's Canon in the form this page needs it: matched circuit topology across taxa licenses no inference about matched algorithm, which is the reason the census is a reading list rather than a justification.
- **[[wiki/concepts/simulation-based-planning.md]]** — supplies the census's smallest planner: salticid detour routes require a goal held while unobserved and a path scored before it is taken, which is that page's model-based signature at a neuron budget five orders below the hippocampal case.
- **[[wiki/concepts/circuit-size-separation.md]]** — the salticid row is an empirical upper bound of the kind that page reasons about analytically: how much circuit a computation actually needs, measured rather than derived.
- **[[wiki/concepts/intelligence-density.md]]** — a nervous system under extreme miniaturisation is a natural high-`ℐ` case, since selection there acts directly on `C(S)`; this page contributes the candidate instance, and that page supplies the reason it should be expected.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the claimed salticid coherence gate (fire maximally when vision and vibration agree in space *and* time) is that page's binding criterion implemented as a conjunction detector rather than a learned alignment loss `(tentative)`.
- **[[wiki/concepts/cellular-scaling-rules.md]]** — the mammalian half of the same accounting: where this page reads miniaturised planners as selection acting directly on unit count, that page measures what a unit *costs* in substrate and finds the price is clade-specific (`M ∼ N^1.06` primates, `N^1.55` rodents), so "few neurons" is only comparable across lineages once the exponent is named.
