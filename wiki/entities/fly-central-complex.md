# Fly Central Complex — the Ellipsoid Body Heading Compass

**A toroidal neuropil in the *Drosophila* brain whose columnar neurons carry a single activity bump encoding the fly's azimuth relative to its surroundings — landmark-driven when a landmark is visible, self-motion-driven in darkness, and self-sustaining when neither is available.** The wiki's only case where a structural code and its update rule are observed in a *complete, identified* population rather than sampled from a distributed circuit (Seelig & Jayaraman 2015).

Why it earns a page: every other reference frame in the wiki is either a model (`g` in [[wiki/entities/tolman-eichenbaum-machine.md]]) or a statistical inference from sampled units (rodent grid/head-direction populations). Here the whole population is imaged at once, its anatomy is a ring, and the three regimes an integrator must have — driven, integrating, holding — are separated experimentally.

---

## Anatomy and preparation

| Item | Detail |
|---|---|
| Structure | Ellipsoid body (EB), a torus at the centre of the central complex (CX); conserved across insects |
| Neurons imaged | **EBw.s** columnar neurons — each sends dendrites to one *wedge* of the EB, so the population tiles the ring. Also called eb-pb-vbo, EIP; likely homologous to locust/butterfly CL1a |
| Method | Two-photon calcium imaging (GCaMP6f), head-fixed fly walking on an air-supported ball inside a 270°-wide LED arena, closed-loop virtual reality; 5-plane volumes at 8.5 Hz, 140 s trials |
| Read-out | Population vector average (PVA) over the ring → decoded azimuth |

The closed loop matters: turning on the ball rotates the visual scene, so the fly *acts* and the consequences of the action return through vision. Passive-viewing studies of the same region had found static visual maps only.

---

## What the population does

| Regime | Available cues | Observed dynamics |
|---|---|---|
| Single vertical stripe | Landmark + self-motion | One bump; rotates with the stripe; PVA decodes stripe azimuth ≡ fly's virtual orientation |
| Complex multi-feature scene | Landmark + self-motion | Still **one** bump of the same width — a feature map would have widened and fragmented it |
| Two identical opposed stripes | Ambiguous landmark | Still one bump, locked to *one* of the two stripes; occasional transitions between the two offsets |
| Landmark jump (instant cue displacement) | Landmark conflicts with self-motion | Bump jumps to follow the landmark, **preserving its offset**; sometimes fast, sometimes slow |
| Closed-loop gain varied | Landmark decoupled from turning | Bump tracks *cue* rotation, barely scales with the fly's own rotation |
| Complete darkness | Self-motion only | Bump forms and tracks turning — **angular path integration** — but accumulates drift and misses small/slow rotations |
| Standing still in darkness | Neither | Orientation **persists >30 s**; when walking resumes the bump reappears in exactly the predicted wedges |

**The code is abstract, not retinotopic.** Three independent arguments: (1) the offset between bump and cue azimuth is fly-specific and occasionally changes *between* trials — a static retinotopic map cannot have a re-assignable offset; (2) the 270° arena is mapped onto the full 360° of the EB, so the ring rescales to the environment rather than inheriting the visual geometry; (3) a complex scene yields one narrow bump, not a copy of the scene. What the ring represents is *orientation in a reference frame*, with visual features as evidence about it.

**Landmark selection looks winner-take-all.** With two indistinguishable stripes the bump commits to one rather than splitting or averaging, and the rare offset transitions are the commitment breaking. This is the aliasing problem of [[wiki/concepts/latent-graph-discovery.md]] appearing in the *anchoring* stage: two observations are identical, the system must pick a hypothesis, and picking wrong produces a coherent-but-wrong frame rather than degraded output.

---

## Ring-attractor evidence, and what is still missing

Features observed that ring-attractor models predict (Seelig & Jayaraman 2015):

| Prediction | Observed |
|---|---|
| Localised bump on a circular topology | Yes — and the anatomy is literally a ring |
| Bump moves to neighbouring wedges under self-motion | Yes |
| Drift without corrective input | Yes, in darkness |
| Persistent activity with no input | Yes, >30 s — two orders of magnitude beyond GCaMP6f decay |
| Abrupt jumps *and* gradual transitions under strong sensory input | Both observed |

**Not shown here:** the functional connectivity between EBw.s neurons. Every feature above is also producible by cell-intrinsic persistence plus feedforward drive, so this is strong circumstantial evidence for an attractor, not a demonstration of one. Also unresolved: whether the bump codes *current* or *predicted* orientation (calcium imaging lacks the temporal precision), and where translational self-motion enters — the paper only establishes the *angular* integrator.

---

## What this buys a reasoning model

1. **The three regimes are architecturally distinct and all necessary.** Sensory-driven (anchor), action-driven (integrate), input-free (hold). Most models in the wiki implement the first two and get the third for free from a persistent hidden state without ever testing it in isolation. The fly test — remove *both* cue streams and check the code is still there and still correct on resumption — is a cheap, importable evaluation for any structural code.
2. **Anchoring has an observable minimal form.** The bump-to-landmark offset is exactly the per-instance pose parameter `φ_k` that [[wiki/concepts/cognitive-map.md]] derives from Sanders et al. 2020: one scalar relating a reusable ring code to this environment. Here it is arbitrary, stable within a trial, and re-assignable between trials — i.e. the reusable code and the instance binding are physically separable, in a brain of ~10⁵ neurons.
3. **Cue arbitration is not a fusion.** Under conflict the compass does not average landmark and self-motion evidence; it *follows the landmark and keeps the offset*, which is a reset of the integrator rather than a Bayesian blend. **(brainstorm)** The slow-vs-fast responses to successive landmark jumps suggest the reset is gated by something like confidence in the current binding — a landmark that has just proved unreliable moves the bump less. A machine analogue: weight the anchor update by the posterior on the landmark's stability, which is the stability-ranking bias [[wiki/concepts/cognitive-map.md]] already argues for, implemented as a time constant rather than as a prior.
4. **Working memory here is a *reference frame*, not a content buffer.** What persists is where you are pointed, not what you saw. **(brainstorm)** That is the cheapest possible episodic state: hold the pose, re-derive the content from the world when it returns. A reasoning system that holds `g` across a gap and re-reads `x` on resumption pays `O(dim g)` for continuity instead of storing the scene.
5. **Small-brain existence proof.** The whole compass is a few dozen columnar neurons. The wiki's structural codes are usually argued for on capacity/transfer grounds; this one is argued for by being *sufficient* at a scale where nothing else fits.

---

## Comparison to the wiki's other integrators

| | Fly EB compass | Rodent head-direction system | Entorhinal grid code | TEM `g` |
|---|---|---|---|---|
| Topology | Ring (1-D, circular), anatomically explicit | Ring (inferred from population manifold) | Torus per module, 2-D | Learned, unconstrained |
| What is integrated | Angular velocity | Angular velocity | 2-D velocity | Arbitrary action tokens |
| Anchor | Visual landmark, arbitrary offset | Distal cues, geometry | Boundaries, geometry | Memory recall of `x` |
| Cue conflict | **Landmark wins** (gain and jump experiments) | Landmark predominantly wins | Physical motion wins over vision (Chen et al. 2019) — [[wiki/empirical-tensions.md]] T46 | Not tested |
| Drift measured | Yes, in darkness | Yes | Yes | Not applicable (discrete steps) |
| Persistence with no input | >30 s, measured | Assumed | Assumed | Hidden state, untested |
| Population coverage | **Complete** | Sampled | Sampled | N/A |

---

## Open problems

- **Connectivity.** No functional connectivity between EBw.s neurons; the attractor is inferred from dynamics, not from a measured recurrent kernel.
- **Translation.** The angular integrator is established; nothing here says how displacement is accumulated or where the two combine into a position.
- **How visual features become an orientation.** Ring neurons deliver localised visual features to EB rings; the conversion from features to an abstract, offset-free orientation estimate is explicitly unknown — this is [[wiki/concepts/cognitive-map.md]]'s anchoring gap (G39) in its simplest possible instance, and it is *still open there*.
- **Current or predicted heading?** Undetermined at calcium-imaging resolution — the difference matters for whether the compass is a filter or a forward model.
- **What sets the offset?** Nothing explains why a given fly locks the bump to a given phase, or what triggers re-assignment between trials.

---

## Connections

- **[[wiki/concepts/path-integration.md]]** — the physical existence proof behind that page's CANN row: the update rule `z_t = f(Wz_{t-1} + Ba_t)` observed running on a ring that is anatomically a ring, with drift in darkness as the direct measurement of the accumulated-error cost the page states abstractly.
- **[[wiki/concepts/cognitive-map.md]]** — supplies the anchoring operation (element 2) in its minimal observable form: a reusable ring code plus one arbitrary, re-assignable landmark offset, with winner-take-all landmark selection when two landmarks alias.
- **[[wiki/concepts/working-memory.md]]** — persistent activity maintaining a *reference frame* rather than a content buffer, for >30 s with no sensory or self-motion input, in a circuit small enough to be fully imaged.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the evidence that this code is structural rather than sensory: one bump in a many-featured scene, arena width rescaled onto the ring, and an offset that can change between trials without the code changing.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the single-frame counterpoint: one ring, one heading, one landmark selected at a time, which is what the multi-frame consensus architectures are proposing to replace.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the same integrate-then-anchor logic learned rather than wired: TEM corrects drift by memory recall of the sensorium, the fly corrects it by locking to a landmark, and both leave the structural code content-free.
- **[[wiki/entities/spiking-neural-networks.md]]** — the substrate argument met from biology's side: the whole compass runs in a few dozen identified neurons, which is the density claim spiking models make and rarely demonstrate.
- **[[wiki/concepts/population-geometry.md]]** — the same reusable-code-plus-offset architecture at `d ≈ 5` and inferred rather than `d = 1` and anatomically identified: 69–75% of a mouse CA1 manifold transfers between animals through one `SO(5)` rotation, which is this page's arbitrary, re-assignable bump-to-landmark offset generalised to a higher-dimensional geometry and to variation *between brains* rather than between trials.
- **[[wiki/entities/adaptive-cann.md]]** — the analysis of what this ring does when its own adaptation gain is raised: below `m = τ/τ_v` the measured static, drifting bump; above it a spontaneous travelling wave, and in between a tracking state that leads the cue by a speed-independent lag — the regime this page's cue-conflict measurements sit in, and a prediction for what modulating adaptation here should do.
- **[[wiki/concepts/attractor-dynamics.md]]** — a ring attractor observed end to end in an identified population, including the offset-preserving reset no model of this mechanism has.
- **[[wiki/entities/spacetime-attractor.md]]** — borrows this circuit's update neurons for a non-spatial axis: an identity feed-forward term between consecutive delay-subspaces shifts a whole plan one step after each action, making "conveyor belt" plan execution path integration along *time-to-arrival* (Jensen et al. 2026).
- **[[wiki/entities/gcq.md]]** — the machine contrast on anchoring: where this circuit resets discretely to a landmark while preserving its offset, GCQ picks one offset by least-squares fit over an entire observation sequence and then never re-anchors — batch inference against online reset, on the same kind of bump.
- **[[wiki/concepts/convergent-circuit-motifs.md]]** — places this circuit in the census of independently evolved allocentric world models and argues it is the cheapest one to copy: complete connectome, ~80 core cells, ~4–5 cell types, and a state estimate architecturally separable from the goal/action system, where the hippocampal formation's is not.
