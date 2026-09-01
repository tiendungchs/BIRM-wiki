# Nucleus Reuniens — the Controller's Return Path, and It Is a Shared Bus

**The midline thalamic nucleus reuniens is the route by which the medial prefrontal cortex reaches a hippocampus that does not receive its axons: prefrontal cortex → reuniens → hippocampus, with the reciprocal hippocampus → reuniens → prefrontal arm as well, and — the architecturally load-bearing detail — *single* reuniens neurons collateralising to both endpoints, so the same spike train is delivered to controller and store at once.**

> **Provenance.** Jin & Maren 2015, *Prefrontal-hippocampal interactions in memory and emotion*, Front Syst Neurosci 9:170 (`raw/jin-2015-prefrontal-hippocampal-interactions.md`). A review of the direct and indirect hippocampal–prefrontal pathways; the reuniens material is assembled from Hoover & Vertes 2012, Varela et al. 2014, Bokor et al. 2002, Porter et al. 2000, Hembrook & Mair 2011, Hembrook et al. 2012 and Ito et al. 2015.

Why this earns a page. [[wiki/entities/medial-prefrontal-cortex.md]] establishes that the direct hippocampus → medial prefrontal projection is **monosynaptic and unreciprocated**, and draws the consequence: "the controller cannot address the store except through a third module." This page is that third module, named, wired and lesioned. The wiki's schema, consolidation and contextual-retrieval stories all assume a controller→store arrow (gaps G37, G51); the arrow exists, it is polysynaptic, and it has a topology no machine architecture uses.

---

## The wiring

| Property | Detail |
|---|---|
| Position | Midline thalamus, ventral tier of the midline group |
| Transmitter | Large majority of projection neurons **glutamatergic** (Bokor et al. 2002) |
| Prefrontal → reuniens | Strong; medial prefrontal cortex is a major cortical afferent |
| Reuniens → hippocampus | **Dense**; the main non-entorhinal cortical route into the hippocampus |
| Reuniens ↔ prefrontal | Bidirectional — the return arm gives hippocampus a second, indirect route *to* prefrontal cortex |
| **Collateralisation** | Single reuniens neurons send branches to **both** hippocampus and medial prefrontal cortex (Hoover & Vertes 2012; Varela et al. 2014) |
| Cortical termination | Layers V–VI of the **ventral** tier of the medial wall (midline nuclei generally; [[wiki/entities/medial-prefrontal-cortex.md]]) |
| Physiological effect | Reuniens stimulation strongly **excites** neurons in both hippocampus and prefrontal cortex, and is capable of modulating synaptic plasticity in both (Di Prisco & Vertes 2006; Eleore et al. 2011) |

Two other indirect hippocampus↔prefrontal routes exist and are *not* this one — nucleus accumbens / ventral tegmental area, and amygdala — plus entorhinal cortex, which is bidirectional with the medial wall and is the other candidate read port. Reuniens is distinguished by being the only one that is simultaneously bidirectional, excitatory to both ends, and collateralised.

---

## What it is needed for

| Manipulation | Deficit | Source |
|---|---|---|
| Reuniens lesion or inactivation | Radial-arm maze performance | Porter et al. 2000; Hembrook & Mair 2011 |
| Reuniens lesion or inactivation | Delayed-non-match-to-position — a task independently shown to require **both** hippocampus and prefrontal cortex | Hembrook et al. 2012 |
| Prefrontal → reuniens → septal (dorsal) hippocampus pathway | Representation of the **future path** during goal-directed behaviour | Ito et al. 2015 |

The Ito result is the specific one. The direct hippocampus → prefrontal channel carries *context* (the ventral/anterior pole's general code; [[wiki/concepts/schema-assimilation.md]]). The reuniens channel runs the other way and carries a *goal-conditioned trajectory* into the store's own coordinate system. The two arrows are not the same signal in two directions — they are typed differently.

---

## The architectural reading

**(brainstorm) A collateralising relay is not a relay** — the anatomy behind `G53`. Every inter-module link in the wiki is point-to-point: module A's output is A's output, delivered to B. A neuron branching to both endpoints is a **broadcast node with guaranteed copy-identity** — controller and store receive the *same vector at the same time*, so any operation defined on the pair (align two codes, timestamp a write, open a shared window) needs no synchronising protocol between them. The nearest machine construct is a shared embedding written into two streams, but nobody makes the shared write a *third trained module* with its own inputs from both sides. Concrete test: in a two-module model, replace the A→B and B→A links with one relay module R fed by both and broadcasting one output to both, and check whether the coordination phenomena the wiki attributes to phase-locking (theta coherence rising at choice points, coherence rising after a new rule is acquired; [[wiki/entities/medial-prefrontal-cortex.md]]) appear without any oscillation being built in.

**(brainstorm) A directed write of a *plan* into a map.** Prefrontal → reuniens → hippocampus carrying future path is the operation gap G37 needs and gap G51 half-needs: the controller does not query the store for a matching schema, it **writes a goal-conditioned constraint into the store and lets the store's own dynamics do the retrieval**. That inverts the usual read-then-select design — closer to conditioning a generative model than to indexing a database — and it fits the Preston & Eichenbaum result that inactivating the controller leaves hippocampal retrieval intact but *indiscriminate* ([[wiki/concepts/schema-assimilation.md]]): with the write channel gone, the store still retrieves, just without the constraint that would have narrowed it.

**Why the direct anatomy misled.** Because the monosynaptic projection is one-way, the wiki inferred an asymmetric architecture. The functional data are symmetric: prefrontal lesions disrupt the spatial firing of hippocampal **place cells**, and hippocampal lesions disrupt anticipatory activity of prefrontal neurons in working-memory tasks (Kyd & Bilkey 2003; Burton et al. 2009). Mutual functional dependence with one-way direct wiring is exactly the signature of a required indirect return path — which is the argument for reuniens carrying real traffic and not merely existing.

---

## Two updates from a later review

> Sigurdsson & Duvarci 2016 (`raw/sigurdsson-2016-hippocampal-prefrontal-interactions.md`), summarized at [[wiki/concepts/inter-areal-synchrony.md]].

- **This relay is no longer the *only* route back into the store.** A monosynaptic anterior-cingulate → dorsal-CA1/CA3 projection exists and is necessary and sufficient for spatial-memory retrieval (Rajasethupathy et al. 2015). Reuniens is now one of two controller→store channels, and the page's premise — "the controller cannot address the store except through a third module" — holds only for the ventral tier. What survives, and is unique to reuniens, is the *collateralised* topology.
- **A specific job for the relay, from a subtraction.** Silencing the direct hippocampus→prefrontal terminals abolishes gamma coupling but leaves **theta** coupling intact, and theta is the band that rises at memory-guided choice points. Whatever carries choice-phase coordination is therefore *not* the direct wire; reuniens — bidirectional, excitatory to both ends, collateralised, and lesion-sensitive on exactly these tasks — is the leading candidate, alongside the medial septum and the ventral hippocampus itself (whose inactivation desynchronizes prefrontal–dorsal-hippocampal theta, O'Neill et al. 2013). **(brainstorm)** A collateralising axon is the cheapest possible theta generator: shared phase with no computation at either endpoint.

---

## Limitations

- **Everything here is rat, and almost all of it is lesion or electrical stimulation.** No cell-type-specific causal dissection of the collateralising population, so "the same spike goes to both" is anatomy (dual retrograde labelling) plus inference, not a simultaneous recording of both terminals.
- **The functional claims do not separate the two arms.** Reuniens lesions damage prefrontal→hippocampal and hippocampal→prefrontal traffic together; no manipulation in the source cuts one direction only. The "controller writes to the store" reading rests on Ito et al. 2015 alone.
- **"Future path" is a decoding claim** about hippocampal representations under a pathway manipulation, not a demonstration that the prefrontal cortex specified the path.
- **Nothing localises the content on this channel either** — the same limitation the direct pathway carries (gap G52). A goal, a gain signal and an attentional window are all consistent with the data.
- **Reuniens is one of at least four indirect routes**, and the source does not adjudicate between them; accumbens, amygdala and entorhinal cortex could each carry part of what is attributed here.

- **Whether the relay is obligatory is unresolved.** If the control layer can address the episodic store directly, this nucleus is a bandwidth convenience; if it cannot, the relay is an architectural requirement and its gating is a first-class design parameter ([[wiki/empirical-tensions.md]] T101).

---

## Connections

- **[[wiki/entities/medial-prefrontal-cortex.md]]** — supplies the return path that page's anatomy section says must exist: hippocampus→prefrontal is monosynaptic and unreciprocated, so the controller's only routes back into the store are entorhinal cortex and this diencephalic relay, which additionally terminates in the deep layers of the ventral tier where the controller's patch/dopamine-directed output originates.
- **[[wiki/concepts/working-memory.md]]** — lesions here reproduce the deficits of a hippocampal–prefrontal disconnection (radial-arm maze, delayed-non-match-to-position), so a spatial working-memory deficit can be a lesion of the *bus* between the store and the controller rather than of either.
- **[[wiki/concepts/simulation-based-planning.md]]** — the concrete substrate for a controller-specified rollout: prefrontal→reuniens→hippocampus carries the *future path*, so the plan is written into the map's own code rather than read out of it.
- **[[wiki/concepts/complementary-learning-systems.md]]** — closes the loop the direct anatomy left open: consolidation-side traffic from controller to fast store has a named, cuttable diencephalic route, and it delivers a goal constraint rather than a retrieval query.
- **[[wiki/concepts/cognitive-map.md]]** — a second writer into the map: prefrontal lesions degrade hippocampal place-cell spatial firing, so the map's own tuning depends on controller input arriving through this relay.
- **[[wiki/concepts/temporal-coding.md]]** — the collateralised relay is a synchrony *generator*: one axon delivering the same spike to two structures produces coordinated timing without either structure computing a phase.
- **[[wiki/concepts/schema-assimilation.md]]** — supplies the missing write channel for the selection story: the controller narrows what the store returns by constraining it through this relay, which is why controller inactivation leaves retrieval intact but indiscriminate.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — assigns this relay a measurable signature: the coupling band that *survives* cutting the direct hippocampus→prefrontal wire (theta, peaking at choice points) must come from a common input, which is what a collateralising relay delivers by construction.
- **[[wiki/entities/pfc-columnar-planning-model.md]]** — the functional load this relay would carry: the columnar model's forward path-wave *is* a representation of the future trajectory, which is the signal this pathway's inactivation abolishes (Martinet et al. 2011).
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the indirect arm of the channel this relay serves: the direct hippocampus→prefrontal projection is unreciprocated, so this nucleus is the return half of a pair of separately-typed directed edges rather than the transpose of the forward one.
- **[[wiki/concepts/contextual-inference.md]]** — what this relay's return arm is for, in inferential terms: responsibility can be applied by *constraining the store's dynamics* through the midline thalamus rather than by re-weighting the store's outputs.
- **[[wiki/entities/mediodorsal-thalamus.md]]** — the other thalamic relay in the wiki, and the contrast that types both: this nucleus collateralises one spike train to two structures and carries *content* (a goal-conditioned future path), where the mediodorsal nucleus pools from one structure and returns a *context* that gates it — a broadcast bus against a closed control loop.
- **[[wiki/concepts/transthalamic-context-routing.md]]** — completes the three-way thalamic contrast: reuniens collateralises one spike train carrying *content* to two structures, the mediodorsal nucleus returns a *context* to its own source, and the higher-order visual thalamus hands an upstream area's *state* to a downstream one — same cell type, three routing topologies, three cargoes (Neske & Cardin 2025).
