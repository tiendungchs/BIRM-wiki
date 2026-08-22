# Random Feedback Addressing

**A controller whose units are tuned to many things at once can still deliver feedback tuned to one thing, provided the connections it feeds back through are near-random: the components addressed at irrelevant features are uncorrelated with those features' tuning axes and cancel, while the component addressed at the relevant feature survives because the same weights carried it up.**

> **Provenance.** Park & Serences 2025, *Near-random connections support top-down feature-based attentional modulations in early sensory cortex*, PLOS Computational Biology 21(8):e1013396 (`raw/park-2025-near-random-connections-attention.md`). Two-layer Poisson spiking model in Brian2, adapted from Bouchacourt & Buschman 2019; 10 random-seed initialisations per condition, 50 trials per condition. Simulation only — no new recordings.

The wiki's control layer has a standing correspondence problem. Prefrontal units carry **mixed selectivity** ([[wiki/concepts/population-geometry.md]]) — they are tuned to conjunctions of many features — and that is read everywhere as an asset, because it makes an arbitrary readout linearly decodable. On the *feedback* side it is a liability: a unit tuned to *red* and to *vertical* cannot excite the red-tuned sensory population without also exciting the vertical-tuned one. The two standing answers were both bad. Collapse the controller's tuning before sending (needs a second controller to say how to collapse), or make the projection topographic (destroys the mixed selectivity the readout needs). This page is the third answer: **do nothing, and let the randomness of the projection do the filtering.**

---

## The model

| Component | Specification |
|---|---|
| Layer 1 "sensory" | 8 ring sub-networks × 512 Poisson neurons; each ring is a circular feature space (orientation/colour/direction), each ring a different retinotopic location |
| Ring recurrence | `w(θ) = λ + A e^{k₁(cos θ − 1)} − A e^{k₂(cos θ − 1)}`, `k₁ = 1`, `k₂ = 0.83`, `A = 2`, `λ = 0.28`, `w(0) = 0` — short-range excitation, long-range inhibition, so every unit has a circular-normal tuning curve. `k₂` was *narrowed* from the source model so one ring can hold **two** stimuli at once |
| Layer 2 "control" | 1024 units, no ring, no topography; `p(excitatory connection) = 0.35` to any layer-1 unit in any sub-network |
| Feedback matrix | `W^FB = (W^FF)ᵀ` — reciprocal by construction; `α = 2100` up, `β = 200` down |
| Balance | Every unit's inputs are shifted so `Σ_j W^FF_ij = Σ_j W^FB_ij = 0` (a stand-in for local interneurons). **This is what makes the cancellation exact rather than approximate** |
| Dynamics | `ṡ_i + s_i/τ = Σ_α δ(t − t_i^α)`, `τ = 10 ms`; `g_i = Σ_j W_ij s_j`; `r_i = 0.4(1 + tanh(0.25 g_i − 3))`; `spikes ~ Poisson(r_i)`. Slope lowered from 0.4 to 0.25 to widen the dynamic range for graded attention |
| Sub-networks are **not** connected to each other | All cross-location interaction is forced through layer 2 — which is the whole point of the design |

Rings only feed layer 2 and layer 2 only feeds rings, so the second layer's mixed selectivity is *inherited* from convergence rather than built in. It is **linear** mixed selectivity (a sum of tuned inputs), not the task-conditioned nonlinear kind — a stated limitation, see below.

**Tasks.** *Sensory*: one stimulus, 300 ms, 16 values tiling the ring. *Attention*: two stimuli 180° apart in ring 1, 1000 ms, with attention delivered as additive drive `S^att ∈ [0, 18]` to the 20% of layer-2 units that fired most to the attended value **in the sensory task**. Stimulus strength `S^ext ∈ [0, 19]`.

---

## Why the irrelevant components cancel

The drive arriving at sensory unit `j` is `Δ_j = Σ_{i ∈ A} W^FB_ij s_i`, where `A` is the attended 20% of control units.

| Ring | Relation between membership in `A` and unit `j`'s preferred feature | Result |
|---|---|---|
| **Stimulated (ring 1)** | `A` was *selected* by response to feature `f` presented in ring 1, and `W^FB = (W^FF)ᵀ`, so a unit is in `A` largely because `f`-tuned ring-1 units drive it. The return weight is therefore correlated with tuning-similarity to `f` | Feedback is **feature-aligned**: gain on the `f`-tuned population, which the ring's own long-range inhibition converts into suppression of the competitor |
| **Unstimulated (rings 2–8)** | Membership in `A` is independent of a ring-`k` unit's preferred feature — the connections that got a control unit into `A` were drawn in ring 1 | `Δ_j` is a fixed, reproducible, but **tuning-uncorrelated** vector; with balanced weights its mean is zero and it has no ring structure |

So the feedback in an unstimulated ring is not small — it is *unstructured*. That distinction is the paper's whole result and it is measurable two different ways.

---

## The two decoders disagree, and that is the finding

| Analysis | Stimulated ring | Unstimulated rings |
|---|---|---|
| Circular ridge regression **trained on stimulus-evoked patterns** (sensory task) → tested on attention task | Mean absolute error (MAE) falls monotonically with attention strength; predictions concentrate on the attended value (strengths 2–6), then **disperse again** at strength ≥ 8 as the attended population saturates and spills onto neighbours | **At chance at every attention strength** — no stimulus-like representation is induced |
| Binary SVM **trained and tested within the attention task** | Accuracy rises with attention strength | **Above chance, and rising with attention strength** |
| SVM trained on one unstimulated ring → tested on another | — | **At chance**, even at maximum attention |

Read together: the attended feature *is* recoverable from a region that saw no stimulus, in a code that (i) does not resemble a stimulus, and (ii) is idiosyncratic to each region. Every ring gets a different random shadow of the same top-down signal.

**This reframes an existing empirical result rather than adding to it.** Decoding an attended feature from cortex representing an unstimulated part of the visual field (Serences & Boynton 2007) has been read as evidence of a spatially global *feature-tuned gain*. The model shows the same decoding accuracy arises with **no feature-tuned gain anywhere in the unstimulated region** ([[wiki/empirical-tensions.md]] T279). The authors draw the general moral explicitly: classifier accuracy establishes the presence of information, not its format, and the discriminating instrument is a cross-generalising **encoding** model, not a within-task classifier ([[wiki/concepts/representation-probing.md]]).

---

## The κ dial: randomness is not free, and neither is structure

Fully random connections cannot produce spatially global feature attention at all — by construction there is nothing shared across rings for a feature signal to ride on. So the paper adds structure parametrically: each control unit is assigned a preferred feature `μ` and its connections are drawn with

```
p(θ) = exp(κ cos(θ − μ)) / (2π I₀(κ))          κ ∈ {0, 0.1, 0.2, 0.3, 0.4}
```

which only changes *which* connections exist, not their strength. Higher `κ` makes like-tuned units across different rings converge on the same control unit.

| κ | Stimulated ring | Unstimulated rings | Control-layer tuning | Verdict |
|---|---|---|---|---|
| **0** (fully random) | Contrast gain, precise, cancellation exact | Idiosyncratic, decodable within-ring, **never stimulus-like** | Maximally high-dimensional | Precise but **parochial** — no global feature attention |
| **0.1** | Essentially unchanged from κ = 0 | Mean absolute error drops **slightly** with attention — a weak, stimulus-like but sub-threshold representation of the attended feature | Still high-dimensional | **The operating point.** Global priming without a competing percept |
| **0.2–0.3** | MAE falls further (activity approaches the single-stimulus pattern) | MAE drops **to stimulated levels** | Falling | **Illusory percepts**: an unstimulated location represents the attended feature as strongly as the stimulated one does |
| **0.4** | — | Structured activity in unstimulated rings **even with zero attentional drive** — a stimulus in one location evokes itself elsewhere | Approaching sensory-like, contradicting the mixed selectivity PFC is measured to have | Broken |

Two failure modes bound the dial from opposite sides, and they are different in kind: too random loses a *capability* (global priming), too structured produces a *false belief* (a percept with no cause). The empirically reported magnitude of feature attention in mid-level visual areas, 10–20%, corresponds to attention strengths ~2–4 here — well below the saturating regime where even the stimulated ring's decoder degrades.

---

## Reading in the core framing

| Element | Latent-graph reading |
|---|---|
| `W^FF` random, `W^FB = (W^FF)ᵀ` | The **address book is the transpose**: no inverse model, no decoder, no learned readout is needed to aim feedback — the path that carried evidence up is the path that carries the modulation down |
| Selecting the top-20% control units | A query executed *in the abstract layer* — "which control nodes does this feature project to" — with the answer read off activity rather than off structure |
| Cancellation in unstimulated rings | Random projection as a **filter**, not as an expansion: the same property that makes a random code high-capacity going up makes it selective coming down |
| κ | A single scalar interpolating between "modulate only what was addressed" and "modulate everything like it, everywhere" — i.e. between local gain and **generalisation across contexts** |
| Idiosyncratic-but-consistent shadow | A private, per-region tag correlated with the global control state — usable as a context signal by anything downstream of that region, invisible to any decoder trained elsewhere |

**(brainstorm) The importable recipe is three lines and needs no new machinery.** Any architecture with a random or unlearned expansion into a wider layer (`h = σ(Rx)`, reservoirs, fly-style projections, a frozen adapter) can get feature-precise top-down gain by (i) recording which expansion units respond to the target feature, (ii) adding drive to that subset, and (iii) letting `Rᵀ` return it. The precision is a property of `R`'s randomness rather than of anything trained, which means it survives the expansion being frozen — the one case in the wiki where a fixed random projection is doing work on the way *back*. `[[wiki/entities/vector-hash.md]]`, `[[wiki/entities/btsp-cam.md]]` and the reservoir results all use random projection going up only.

**(brainstorm) κ is the wiki's separation/completion knob wearing different clothes.** At κ = 0 the eight rings are eight separate stores that share a hub without contaminating each other; at κ = 0.4 they are one store, and a write to any of them completes across all of them. That is [[wiki/concepts/pattern-separation-completion.md]]'s allocate-vs-reuse decision expressed as a **connection-formation prior** rather than as a threshold or a neuromodulator, and it joins the Collins & Frank result (random vs one-to-one context→PFC projection moving the fitted Dirichlet `α`) as the second case in the wiki where the bias is a readable property of a weight matrix ([[wiki/architectural-gaps.md]] G38). The difference: here the failure mode of over-completion is named and it is *hallucination*, not over-generalisation.

**(brainstorm) The result should generalise past linear mixing, and the paper says how to test it.** If a network held two random connection configurations, one per task — giving control units nonlinear, task-conditioned mixed selectivity — cancellation would still hold *within each configuration*, because randomness is the only property being used. Unrun.

---

## What it does not supply

- **Which control units to drive is the whole control problem, and it is handed to the model.** The attended subset is identified by running the ground-truth network on the stimulus first. The authors are candid: this "required some knowledge about network connectivity," motivated by the **GANE** proposal (locus-coeruleus norepinephrine amplifying local glutamatergic "hot-spots", so the address is *found* by the stimulus rather than computed). But GANE's own initialisation — what prioritises the relevant feature before the positive-feedback loop starts — is unspecified, so the regress moves one level and does not close ([[wiki/architectural-gaps.md]] G96).
- **Reciprocity is assumed, not derived.** `W^FB = (W^FF)ᵀ` is a simplifying assumption defended only at the level of regions. Symmetric weights are also exactly what a machine implementation would find hardest to justify and easiest to just impose.
- **No learning anywhere.** Connections are drawn once per seed; nothing in the model explains how a network would arrive at κ ≈ 0.1 rather than being initialised there. The one biological proposal is a *developmental* mechanism — stochastic protocadherin expression giving neurons unique molecular identities, so matching identities across areas could initialise random reciprocal connections — which is initialisation, not learning.
- **Feature attention only.** Spatial attention would need a second control layer with *structured* connections; the proposed architecture (a structured spatial layer + a near-random feature layer, mapping onto frontal eye field vs. ventral prearcuate / inferior frontal junction) is sketched and not built.
- **Additive drive.** The multiplicative version is relegated to supplementary figures; the main results are additive `S^att`.
- **Attentional modulation is only ever positive.** Suppression of the unattended stimulus is a *consequence* of the ring's own long-range inhibition, never an addressed signal — so the model has no way to express "stop attending to X" ([[wiki/concepts/inhibitory-control-of-coding.md]]).

---

## Open problems

- **What sets κ, and can it be set at runtime?** The paper's own speculation is that prefrontal cortex may span the continuum — units with large spatial receptive fields but flexible feature tuning could behave as random or as structured depending on which subset is driven, letting the system choose focal vs. diffuse modulation per task. Nothing implements this, and it is the difference between a design constant and a control variable.
- **Does the "idiosyncratic shadow" do anything, or is it waste heat?** It is consistent, decodable within a region, and carries the global control state. No consumer is proposed. If a downstream area could read it, it would be a free broadcast channel that costs no dedicated wiring.
- **Is cancellation robust to non-uniform sensory statistics?** Balanced weights make the shadow mean-zero under uniform feature statistics. Real feature distributions are heavily non-uniform (cardinal orientation bias), which is exactly the failure mode that broke random addressing in [[wiki/entities/sparse-distributed-memory.md]] ([[wiki/empirical-tensions.md]] T55). Untested here.
- **Does the same argument run forward?** Cancellation is derived from `A`'s independence from the target ring's tuning axis. Nothing about it is specific to the feedback direction, so a symmetric prediction exists for feedforward interference between simultaneously presented stimuli, and is not tested.

---

## Connections

- **[[wiki/concepts/attention.md]]** — supplies the mechanism its "top-down feature gain" entries have assumed and never had: a controller whose units are tuned to many features can still deliver single-feature gain, because the irrelevant components of the feedback are uncorrelated with the target population's tuning axis and cancel under balanced weights — no collapsing of the controller's selectivity and no topographic projection required (Park & Serences 2025).
- **[[wiki/concepts/priority-map.md]]** — bears directly on that page's unresolved route question: it exhibits a **feature-addressed** feedback pathway that produces spatially global feature modulation with no retinotopy anywhere in it, which is the alternative to reading extrastriate feature gain as retinotopic frontal feedback — and it makes the discriminating experiment (overlapping stimuli sharing a location) a prediction rather than a hope, since a near-random feature route handles that display and a spatial route cannot.
- **[[wiki/concepts/population-geometry.md]]** — prices mixed selectivity on the side that page never costs it: high-dimensional tuning is an asset for readout and a liability for *output*, since a conjunctively tuned unit cannot address one of its features without addressing the others — and the fix is a property of the projection (randomness) rather than of the code.
- **[[wiki/concepts/representation-probing.md]]** — the sharpest cautionary case in the wiki for its central instrument: a within-task classifier decodes the attended feature above chance from a population containing no stimulus-like representation of it, and only a decoder *trained on stimulus-evoked patterns* (an encoding-model-style cross-generalisation) reports the absence correctly.
- **[[wiki/concepts/pattern-separation-completion.md]]** — κ is the allocate-vs-reuse bias expressed as a connection-formation prior over a shared hub: at κ = 0 eight regions share a hub without contaminating each other, at κ ≥ 0.2 a write to one completes across all of them, and the named failure mode of over-completion here is a percept with no cause.
- **[[wiki/concepts/working-memory.md]]** — the same architecture, run backwards: Bouchacourt & Buschman's random-coupling model was built to explain capacity limits in a store whose items are *held* by the hub, and this page drives the hub deliberately to show the same random connections make it a precise addressing device rather than only a capacity bottleneck.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — balance doing information-theoretic rather than stability work: `Σ_j W^FB_ij = 0` is what makes the off-target feedback exactly mean-zero, so the cancellation result is a consequence of E/I balance and would degrade with it.
- **[[wiki/entities/early-visual-system.md]]** — the layer this page's feedback lands on, and the reason the "no spurious percept" constraint is binding: the ring sub-networks are a stand-in for orientation/direction/colour-tuned early visual populations, whose stimulus-evoked responses the model must not be able to counterfeit.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the ring's long-range inhibition converting an excitatory, feature-addressed feedback signal into suppression of the competitor, so "enhance the attended" and "suppress the unattended" are one addressed operation plus one local circuit property rather than two control signals.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the proposed source of the address this model is handed: GANE has locus-coeruleus norepinephrine amplify local glutamatergic hot-spots, so the set of control units to drive would be *found* by the stimulus rather than computed by a controller — a broadcast scalar interacting with local activity to produce a targeted effect.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the same random projection used in the opposite direction: expansion into a wide random layer buys capacity and separability going up, and this page shows the identical wiring buys *selectivity* coming down, with the balanced-weight condition standing in for the sparsity condition.
- **[[wiki/entities/vector-hash.md]]** — the wiki's strongest case for a frozen random projection, now with a second job: there randomness makes basins convex and spurious-free on the way in, here it makes off-target feedback cancel on the way out, and both properties are destroyed by making the projection content-dependent.
- **[[wiki/concepts/latent-graph-discovery.md]]** — an addressing scheme with no address space: modulation is aimed by *which nodes the evidence passed through*, read off activity, rather than by any coordinate the controller holds — the return path is the query.
- **[[wiki/concepts/precision-weighting.md]]** — a competing account of the same phenomenon at a different level: attention as multiplicative gain on a prediction error assumes the gain can be applied where it belongs, and this page is a mechanism for that assumption in a network where the unit issuing the gain has no way to name its target.
