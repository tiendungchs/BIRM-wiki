# Attractor Identification — What Licenses the Claim That a Circuit *Has* an Attractor

**Low-dimensional activity is not evidence of an attractor. The claim requires four state-space predictions — localization, flow-back after perturbation, invariance, and (for integrators) isometry — of which only *invariance* is defining, because the other three are all reproducible by a low-dimensional input or a low-rank feedforward projection with no recurrence anywhere.**

> **Provenance.** Khona & Fiete 2022, *Attractor and integrator networks in the brain*, Nat. Rev. Neurosci., doi:10.1038/s41583-022-00642-0 (`raw/khona-2022-attractor-and-integrator-networks-in-the-brain.md`). A review; the contribution taken here is the criteria list and the scoreboard, not new data.

This page is the measurement half of [[wiki/concepts/attractor-dynamics.md]], which is the design half. The split matters because the wiki cites attractors on ~40 pages and has, until this page, no stated test that could come back negative.

---

## The four criteria

| # | Criterion | What is measured | What it rules out on its own |
|---|---|---|---|
| **C1** | **Localization** | States are found at or around a low-dimensional subset of the `10²–10⁷`-dimensional state space | Nothing — see the two confounds below |
| **C2** | **Flow back after perturbation** | After a natural or induced deviation, the state returns *quickly* to the subset | An unconstrained random walk; not a feedforward projection, which also has no off-manifold persistence |
| **C3** | **Invariance** — **the defining one** | The set of states, or the cell–cell relationships that stand in for it, persists **across time, across environments, across behavioural states, across the removal of tuned input, and across waking and sleep** | A low-dimensional *input*: an externally imposed manifold does not survive removal of the input that imposes it |
| **C4** | **Isometry** (integrators only) | Equal displacements of the external variable map to equal lengths of coding space | A monotone but arbitrarily warped read-out; distinguishes an integrator from a correlate |

**Supporting, not necessary:** a physically low-dimensional anatomical structure, and directly visible symmetry in the connectivity between cells. Neither is theoretically required (the fly ellipsoid body has one, the mammalian anterodorsal thalamic ring does not), but both raise the prior sharply.

**Precondition on the whole battery: effective autonomy.** The circuit must be probed with inputs that are constant in time and *untuned* — not providing differential drive to subsets of the putative attractor set. Attractor circuits are used non-autonomously in normal operation (an integrator is driven by velocity), so this is a test condition, not a claim about function.

---

## Why C1 is worth nothing alone

Two confounds, both of which produce low-dimensional population activity with no recurrent stabilisation:

1. **The inputs and the behaviour are themselves low-dimensional.** Stereotyped, trained, low-dimensional tasks yield low-dimensional activity whatever the circuit does. This is the standing objection to reading motor-cortical trajectories as attractors.
2. **A low-dimensional feedforward projection into the target.** High-dimensional upstream activity passed through a low-rank map lands on a low-dimensional set, and high-dimensional perturbations of the target do not persist — so it passes C1 and C2.

Hence the load falls entirely on C3: *the states are internally generated, so they must survive the withdrawal of whatever might have been imposing them.* Sleep is the strongest available version of that withdrawal, and it is what separates grid cells from place cells below.

---

## The fifth criterion nobody lists, and why it fails both ways

**Abrupt, coherent switching under a graded input morph** — hysteresis — is the test most of the hippocampal literature actually runs, and it is not in the four above. Colgin et al. 2010 (`raw/colgin-2010-attractor-map-versus-autoassociation-hippocampal-dynamics.md`) is the experiment that shows why it should not be promoted.

| Failure | Evidence | Consequence |
|---|---|---|
| **It does not localise** | The steepest sigmoid transitions were recorded in **CA1** (slope 26.7 ± 14.5, 7/9 fields at the identical midpoint), a field with almost no recurrent collaterals — the dynamics were imposed by its inputs | A positive result licenses "an attractor exists somewhere upstream", never "this population has one" |
| **It has a false-negative mode set by training history, at fixed connectivity** | The *same* morph protocol on the *same* circuit gave a linear, incoherent, rate-only trend after single-location training and a coherent 5×-steeper midpoint jump after double-location training; the only difference was whether the two endpoints had been assigned different path-integrator coordinates a week earlier | A negative result is uninformative about the circuit: it reports what the anchoring associations were, not what the landscape is |

The second row generalises past hippocampus and is the reason it belongs on this page: **hysteresis measures the separation of the stored states, which is a property of what was written, while C1–C4 measure the existence of the state set, which is a property of the network.** Two studies reaching opposite conclusions on the same protocol (Wills et al. 2005 vs Leutgeb JK et al. 2005a) differed in the first and were read as differing in the second. The machine translation is direct and unrun: an ablation that shows a trained network "has no attractor" because its outputs interpolate may have shown only that the training distribution never separated the endpoints.

---

## The sixth test, and the one that localises where hysteresis does not

**Population coherence against a unit-shuffle null.** Jezek, Henriksen, Treves, Moser & Moser 2011 (`raw/jezek-2011-theta-paced-flickering-between-place-cell-maps.md`) put a rat in one of two orthogonally-coded boxes and switched the light cues instantaneously, then asked, per theta cycle, how often the CA3 population vector correlated with *both* stored charts at once. The null is the decisive part: recombine the observed cycles unit by unit, drawing each cell's spike count from a cycle recorded at the same spatial bin in the same period. That null is exactly "each cell expresses one chart or the other independently", so the comparison isolates the **joint** statistic.

| | Observed | Null |
|---|---|---|
| Mixed cycles (`r·r_A > C` and `r·r_B > C`) | **1.25%** | exceeded by 970/1000 shuffles (`p < 0.03`) |
| Mixed half-cycles, first half | — | 958/1000 (`p < 0.05`) |
| Mixed half-cycles, second half | — | **1000/1000** (`p < 0.001`) |

Three reasons it belongs on this page rather than in the hippocampus literature.

- **It tests a different proposition from C1–C4.** Those establish that a state *set* exists and is internally generated. This establishes that the states are mutually **exclusive** — that the circuit actively suppresses the convex combinations its units would produce on their own. A system can pass C1–C4 with a state space that is one connected manifold and no discreteness anywhere; nothing in the battery reports a count.
- **It localises, and the fifth criterion does not.** Hysteresis fails to localise because its sharpest expression was in CA1, which has no recurrence (above). Coherence runs the other way: flickering was present in CA1 but **discrete relapses were clearly less frequent than in CA3**, which is the direction recurrence predicts. So a within-population exclusivity statistic distinguishes the generator from the relay where a transfer-curve statistic could not.
- **It is cheap and it is the version a machine can run.** No embedding, no topology estimate, no perturbation, no autonomy precondition — only simultaneous unit activity and a permutation. The machine translation is direct and unrun anywhere in the wiki: **take a store's read under an ambiguous query, and ask whether the output's similarity to two stored items is jointly lower than a per-unit shuffle of the same reads would give.** A softmax-attention read fails this by construction — it *is* the convex combination — so the statistic separates architectures that return a member from architectures that return a mean ([[wiki/entities/continuous-modern-hopfield-network.md]]'s intermediate-`β` metastable state is the explicit machine case of the second).

**What it does not do.** It says nothing about where the exclusivity comes from: global inhibition, a learned landscape and a downstream gate all produce it. And it requires the two candidate states to be near-orthogonal in advance (here, spatial correlation `0.112 ± 0.019` between the boxes) — with overlapping references the null and the data converge and the test loses power.

---

## The one circuit where the whole battery was run end to end — and the two criteria it adds

> Chaudhuri, Gerçek, Pandey, Peyrache & Fiete 2019 (`raw/chaudhuri-2019-intrinsic-attractor-manifold-head-direction-circuit.md`). Mouse anterodorsal thalamus, 7 animals, waking foraging plus REM and non-REM sleep. This is the primary source behind the scoreboard's strongest row; the review above quotes it. Method: [[wiki/concepts/topological-latent-decoding.md]].

The paper states **six** properties rather than four, and the two extra ones are not redundant with C1–C4.

| Property | Criterion here | How it was measured | Result |
|---|---|---|---|
| Low-dimensional continuum of matching topology | **C1** | Persistent homology on the full state space | One persistent `H1`, no `H2`; behaviour was ≥ 5-dimensional, the manifold is 1-D |
| Isometry of coded intervals | **C4** | Uniform arc-length parameterization decodes without per-region rescaling | Passes |
| Autonomously generated, self-sustained with sensory input removed | **C3** | The ring during REM is essentially identical to the waking ring | Passes — the strongest available form of input withdrawal |
| Manifold is attractive | **C2** | **Net flux off- vs on-manifold**, bins split at the 50th percentile of distance to the fitted spline, null = velocity vectors shuffled across points (1000 permutations) | Off-manifold flux significantly larger, in radial *and* tangential components — during **spontaneous** activity, with no perturbation applied |
| **Manifold states are energetically equal** | *new* | Flow field along the ring (uniform bars, no convergence points); log density of decoded angle along the ring; squared angular displacement vs lag | Flat log density within across-session variability; displacement **linear** in lag (unbiased diffusion) in REM, quadratic at short lags in waking |
| **The velocity input drives along the manifold** | *new* | Diffusion constant compared against a matched network model | Measured 1.1 ± 0.04 rad² s⁻¹, **20–50×** the prediction from independent per-neuron noise; accounted for by manifold-aligned input noise of amplitude comparable to the waking head-velocity drive |

**Why the flux measurement matters more than the criterion it satisfies.** C2 is written as "after a natural or induced deviation" and is run everywhere else by *inducing* one — photoinhibition in ALM, saccadic knocks in the oculomotor integrator. Flux asymmetry needs no perturbation protocol: the circuit's own noise supplies the deviations, and a permutation over its own trajectories supplies the null. That makes C2 available on any system whose state is observable, including every trained network in the wiki, at zero experimental cost.

**The fifth property is the one the four-criterion battery cannot state.** C1–C4 certify that a state *set* exists and is generated internally. Energetic equality says the set has **no preferred member** — which is exactly what separates a continuous attractor from a continuum with discrete fixed points sitting on it, and is the complement of the sixth test above (which certifies that the members are mutually *exclusive*). A system can pass C1–C4 with a ring that has four sticky points on it, and nothing in the battery would report them.

**The sixth property is a claim about wiring, not about the landscape**, and it is the only entry here that comes back with a number about what rides which wire: the noise that limits the memory arrives through the same low-dimensional channel that updates it, because high-dimensional noise has variance `1/N` along the manifold (`G124`).

**A warning the same paper supplies about the battery itself.** In non-REM sleep the manifold is *not* the waking ring — it is a cone whose rim is the ring, with population firing rate on the radial axis. A wake-trained supervised decoder projects cone states onto the ring before estimating dynamics and reports structureless fast diffusion; on the native manifold the dynamics are confined diffusion alternating with coherent directional sweeps at 8× waking speed. **Any criterion run in a basis fitted under one condition can come back negative on another condition for purely representational reasons** — which is a false-negative mode of C3 as serious as the hysteresis false negative above, and it applies to every machine translation of C3 that holds the projection fixed across task families.

**A second false-negative mode of the same kind, one level down: the population is not homogeneous.** In the grid modules the battery passes or fails depending on *which units it is run on*. Clustering cells by spike-train temporal autocorrelogram alone — no tuning information — splits each module into bursty, non-bursty and theta-modulated classes with distinct spike widths; the bursty class carries the torus in every state and alone recovers it in slow-wave sleep, while the theta-modulated class holds 80% of the conjunctive grid × direction cells and returns a **head-direction circle** instead (Gardner et al. 2022). So a negative C1 can mean "this population has no manifold", "this population has two manifolds", or "the estimate was run on the wrong subset", and the battery does not distinguish them. The machine translation is cheap and unrun: cluster a layer's units by their temporal autocorrelation before running any geometry on them.

---

## How the criteria are actually run

| Route | Requirement | Note |
|---|---|---|
| **Direct manifold recovery** | Enough simultaneously recorded cells to characterise the full state space (thousands) | Linear (PCA, MDS, tensor factorisation) or nonlinear (Isomap, LLE, t-SNE, VAE, LFADS) embedding works only for `d ≤ 3` or topologically trivial `d ≥ 3` |
| **Topological data analysis** | Same, plus persistent homology | The only route for non-trivial topology — rings, tori — which is exactly where the interesting claims are |
| **Pairwise cell–cell relationships** | Small simultaneous samples | The cheap proxy: C1–C3 can be *inferred* from the invariance of cell–cell correlation structure without ever embedding the manifold. This is how the head-direction and grid results were obtained years before population-scale recording |
| **Localization of the generator** | Perturb the candidate region, then remove the drive | If the region generates the dynamics or is upstream of them, a perturbation *along* the attractor set persists after the perturbing drive stops; a downstream read-out relaxes |

---

## The scoreboard

| System | C1 | C2 | C3 | C4 | Verdict |
|---|---|---|---|---|---|
| **Oculomotor integrator** (line attractor) | ✓ | ✓ (saccadic knocks decay back to the firing state) | ✓ (persists in the dark, no visual feedback) | ✓ | **Established.** Plus a causal handle: synaptic blockers shorten the integration time constant — leaky integrator — so integration is a network rather than a cell property; and EM reconstruction finds ipsilateral excitation / contralateral inhibition as the line-attractor model requires |
| **Head direction** (ring attractor, mammal) | ✓ (persistent homology: one `H1`, no `H2`; 94% of between-neuron covariation is shared ring coding, residual structureless — so the code is *purely* 1-D down to the noise floor) | ✓ (off-manifold net flux significantly exceeds on-manifold, radial and tangential, against a velocity-shuffle null, during spontaneous activity) | ✓ (invariant across environments and into REM sleep) | ✓ (uniform arc-length parameterization decodes with no per-region rescaling) | **Established — the strongest case in the brain**, together with grid cells. Every cell here is Chaudhuri et al. 2019, the one circuit where the battery was run end to end (section above); it also adds two properties the four criteria do not state, and a non-REM manifold that is a *cone* rather than the ring |
| **Head direction** (fly ellipsoid body) | partial | ✓ | ✓ | — | Anatomical ring plus a fully traced connectome implementing the copy-and-offset double ring; full state-space dimensionality not yet characterised, and the same circuit may also do 2-D path integration |
| **Grid modules** (torus) | ✓ (persistent cohomology → four long bars: one `H0`, **two** `H1`, one `H2`, in 6/6 modules in two environments, `p < 0.001` against a spike-roll null; 66–189 cells per module) | ✓ | ✓ (conserved across environments — toroidal field centres move 31.5 ± 6.3° against a 135.8° shuffle, `r` = 0.79 — across environment dimensionality, across grid-rescaling deformations, and **into REM (5/6 modules) and slow-wave sleep (4/6)**) | ✓ | **Established**, and since Gardner et al. 2022 this row rests on a primary population measurement rather than on the review's summary of one ([[wiki/concepts/topological-latent-decoding.md]]). Two additions the four criteria do not state: the torus is the *twisted* one, with the two decoded circles meeting at **60°** — so the geometry is measured, not assumed; and the toroidal coordinate predicts the cells' spiking **better than the animal's physical position does** (5/6 modules), which puts the environment-induced grid distortions in the space→torus chart rather than in the manifold. Corollary as before: since the cell–cell structure survives sleep in grid cells and *not* in place cells, models deriving grid cells from place cells are inconsistent with the data |
| **ALM premotor bistability** (mouse, 2-alternative delay) | ✓ | ✓ (weak photoinhibition erased, strong drives a jump to the other state and the wrong action) | partial (terminal states shared across cue modality) | n/a | **Established and localized**, but the dynamics are task-shaped and acquired by slow plasticity — so the recurrent structure is malleable in adults |
| **Prefrontal / parietal graded working memory** | ✓ | ✓ (bump profile invariant) | partial | n/a | Bump diffuses along a 1-D manifold with variance growing linearly in delay, and the drift **predicts the behavioural error** — the attractor is the memory, not a correlate. Trained on an unnatural task, so C3 across tasks is expected to fail |
| **Cortical up/down states** | ✓ (bistable, sharply peaked histograms) | ✓ | partial | n/a | Network-driven rather than cellular, but the origin is distributed (synchronous across cortex and striatum), so localization fails |
| **Perceptual bistability** | ✓ | — | — | n/a | Two states are evident in the *report*; no bistable circuit has ever been localized, and top-down modulation across many areas is implicated |
| **Discrete multistability** (olfactory, auditory, hippocampus) | suggestive | — | — | n/a | Global inhibition plus selective recurrent excitation are documented; C1–C3 have not been tested quantitatively. **The weakest link in the whole programme** — the machine-side workhorse (Hopfield/WTA multistability) is the biologically least-verified regime. **One quantitative test now exists for the hippocampal case, and it is not one of C1–C4**: under a teleportation cue switch, CA3 theta cycles correlate with both stored charts in 1.25% of cycles, *below* a unit-shuffle null (`p < 0.03`), falling to `p < 0.001` in the second half of each cycle (Jezek et al. 2011; the sixth test above). It measures exclusivity rather than existence, and it favours CA3 over CA1 |
| **V1 orientation tuning** | ✓ | — | — | n/a | **Departure.** Changing an attractor state needs strong input and is slow, which perception is not; illusory-contour responses lag real ones, implying top-down rather than intra-V1 dynamics. Feedforward drive plus non-normal amplification is the live alternative |
| **Place cells** | ✓ (low-dimensional within an environment) | — | ✗ (cell–cell correlations are *not* preserved across environments — remapping — nor across sleep) | n/a | **Departure**, and the sharpest one — with a second, independent line of attack: a designed dissociation finds hippocampal attractor dynamics present or absent depending on whether the *upstream path integrator* was given two coordinates or one, which puts the landscape in medial entorhinal cortex and CA3/CA1 downstream of it (Colgin et al. 2010, `T389`). Also: storing several high-resolution maps in a homogeneous attractor severely limits capacity (G42), so the conjunctive-feedforward reading (grid + border + landmark + reward inputs) fits better — except that CA3 replay sequences still need recurrence (`T389`) |
| **Motor cortical trajectories** | ✓ | — | — | n/a | **Departure.** The behaviours recorded are themselves stereotyped and low-dimensional (confound 1), and perturbation experiments implicate thalamic input as the driver |

---

## Relevance to a reasoning model

- **This is the missing negative control for every "our network learned an attractor" claim in the wiki.** The four tests are *cheaper* on a trained network than on tissue — the hidden state is fully observable, perturbation is free, and "remove the tuned input" is a line of code — yet no page here runs them. [[wiki/empirical-tensions.md]] T106 and T87 separate attractor from non-attractor solutions by a post-hoc *transience index* fitted to activity; C2 and C3 would settle the same question causally.
- **C3 is the test the machine side cannot borrow unchanged.** "Invariant across environments and into sleep" has no direct analogue for a feedforward-trained model with no autonomous regime; the nearest translations are invariance of the fixed-point set across task families and persistence of the state under zeroed input. **(brainstorm)** The second is exactly the `I`-row an architecture claim needs: *zero the input, run the recurrence forward, and ask whether the state stays where it was put.* A model whose "memory" evaporates under zeroed input is a filter, not a store, and nothing in the wiki reports this number.
- **The cheapest causal-looking test needs no intervention at all, and it is now specified.** Flux asymmetry against a velocity-shuffle null (section above) gives C2 from trajectories the system generated on its own: bin the state space, average the step vectors per bin, split bins by distance to the fitted manifold, and shuffle the vector-to-point assignment for the null. On a trained network this is a few lines over a rollout, and it is the only entry in the battery that is *cheaper* on tissue-scale data than the perturbation route.
- **Topology is cheap in units.** ~35 simulated grid cells suffice for persistent homology to reveal the 2-torus, against the "thousands" the direct-manifold-recovery row demands — so the topology branch of C1 is available at population sizes that any model layer exceeds ([[wiki/concepts/topological-latent-decoding.md]]).
- **The criteria are ordered by cost, and the cheapest one is the pairwise route.** Cell–cell correlation invariance recovered head-direction and grid attractors before any population-scale recording existed. Its machine analogue — invariance of the unit–unit correlation matrix across task conditions — needs no embedding, no topology estimate and no labels, which puts it in the same class as [[wiki/concepts/population-geometry.md]]'s parallelism score.
- **A negative result is informative here in a way accuracy never is.** Three of the wiki's most-cited biological justifications for recurrent design (V1 as a line/ring attractor, place cells as a chart store, motor cortex as a limit cycle) are listed by the field's own review as *departures*. Any architecture argument in the wiki that leans on them is leaning on a claim the source literature has withdrawn.

---

## Open problems

- **A basis fitted under one condition is a false-negative machine.** The non-REM cone result means a criterion can fail because the manifold changed shape, not because the dynamics changed — and the failure presents as *noise*, which is the least suspicious result to report. Nothing in the battery asks whether the projection is still the right one.
- **No criterion distinguishes "has an attractor" from "needs one".** ALM is bistable and the task has two choices; the causation runs either way, and the review's own reading is that the structure was learned to fit the task.
- **The invariance test has no graded form.** C3 is run as pass/fail on a chosen set of conditions; nothing reports *how much* of the cell–cell structure survives a condition change, which is what a model comparison would need.
- **Criterion C4 has no machine instance at all.** Isometry — equal external displacement ↔ equal coding length — is checked for biological integrators and never for a learned one, although it is the property [[wiki/concepts/path-integration.md]]'s composition argument silently assumes.

---

## Connections

- **[[wiki/concepts/topological-latent-decoding.md]]** — the instrument this page's criteria are measured with: persistent homology plus a spline of matching topology supplies C1 and C4 without any labelled covariate, and the flux decomposition off the fitted object turns C2 into a permutation test on spontaneous activity. It also supplies the two properties the four criteria do not state — energetic equality of manifold states, and the alignment of the update channel — and the non-REM cone that makes a fixed projection a false-negative mode of C3. Its two-dimensional variant (cohomological decoding) is what the grid-module row is now measured with, and it fits nothing — the toroidal coordinates come straight off the barcode's cocycles.
- **[[wiki/entities/anterior-thalamic-nuclei.md]]** — the circuit behind the scoreboard's strongest row: the anterodorsal nucleus, whose lack of anatomical topography is why this page's "supporting, not necessary" clause exists.
- **[[wiki/entities/stp-flickering-cann.md]]** — what a positive coherence result still leaves open: the same all-or-none per-cycle exclusivity is produced by short-term plasticity plus a theta-paced inhibitory reset, with no commitment about the landscape, so the sixth test licenses "the states are mutually exclusive" and not "the recorded population holds them" (`T56`).
- **[[wiki/concepts/attractor-dynamics.md]]** — the design half: that page says what a landscape buys and costs, this page says what licenses the claim that one is there, and its scoreboard rows are the evidence base that page's typology is built on.
- **[[wiki/concepts/population-geometry.md]]** — supplies the estimators (intrinsic dimensionality, held-out reconstruction, the input-geometry control) that C1 is measured with; this page adds the argument that all of them together are *necessary and not sufficient*, and that invariance under input withdrawal is what upgrades a measured manifold to a generated one.
- **[[wiki/concepts/perturbation-elicitability.md]]** — the same causal move at a different level: C2 asks whether a focal edit decays, elicitability asks whether it changes reportable content, and both read a code's steerability off its response to injected current.
- **[[wiki/concepts/structured-flows-on-manifolds.md]]** — the formalism whose central claim (a low-dimensional flow does the computation) this page's confound list says a projection alone cannot evidence.
- **[[wiki/concepts/metastability.md]]** — the alternative explanation C1–C2 cannot exclude: a trajectory deflected by ghost attractors localises and flows back without ever being captured, so the two are separated only by C3's long-dwell invariance.
- **[[wiki/concepts/dynamic-repertoire.md]]** — the worked case of the confound: three whole-brain models reproduce the same low-dimensional cluster structure, and only one of them contains multistability.
- **[[wiki/concepts/path-integration.md]]** — C4 (isometry) is this page's only criterion specific to integrators, and it is the measurement form of that page's path-consistency requirement. That page also owns the variable behind the hysteresis false negative above: whether two environments got one set of path-integrator coordinates or two is what decides whether the downstream store switches abruptly or blends (Colgin et al. 2010).
- **[[wiki/concepts/certification-instruments.md]]** — the same methodological shape in the benchmark domain: an instrument only certifies if it can come back negative on a high-scoring system, which is precisely why C1 is excluded here.
- **[[wiki/entities/fly-central-complex.md]]** — the one system where the anatomical-symmetry support criterion is fully satisfied: a physical ring with a traced connectome implementing the copy-and-offset construction.
- **[[wiki/entities/entorhinal-cortex.md]]** — the circuit holding the scoreboard's strongest row, and the source of the sleep-invariance contrast that separates grid modules from place cells; it also supplies this page's second false-negative mode, since the modules there are mixtures of three temporally-defined cell classes lying on two different manifolds.
- **[[wiki/entities/trnn.md]]** — the machine claim this page's tests would arbitrate: fixed points are reported absent by a measured transience index rather than by perturbation and input withdrawal.
- **[[wiki/concepts/stationary-surrogate-null.md]]** — the complementary null: this page guards against a manifold imposed by the input, that page against structure produced by the statistics of the estimator.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — the rival reading of the same abrupt/gradual dichotomy this page's fifth criterion measures: under that model the sharpness of a transition is the log posterior odds of a hidden-state partition rather than the separation of two anchored coordinates, and the two accounts are carried as `T394`.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the claim class this page's fifth criterion is most often misapplied to: abrupt switching under a graded morph is not evidence that the recorded field holds the landscape, and its absence is not evidence that separation failed, because one circuit yields either outcome depending on anchoring history — so a separation/completion result and an attractor result are not interchangeable readings of the same recording (Colgin et al. 2010).
