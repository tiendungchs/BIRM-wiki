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
| **Head direction** (ring attractor, mammal) | ✓ (the complete state set of a several-thousand-cell population is a 1-D ring) | ✓ | ✓ (invariant across environments and into REM sleep) | ✓ (ring intervals map isometrically to heading) | **Established — the strongest case in the brain**, together with grid cells |
| **Head direction** (fly ellipsoid body) | partial | ✓ | ✓ | — | Anatomical ring plus a fully traced connectome implementing the copy-and-offset double ring; full state-space dimensionality not yet characterised, and the same circuit may also do 2-D path integration |
| **Grid modules** (torus) | ✓ (persistent homology → 2-torus) | ✓ | ✓ (conserved across environments, across environment dimensionality, across grid-rescaling deformations, and across overnight sleep) | ✓ | **Established.** Corollary: since the cell–cell structure survives sleep in grid cells and *not* in place cells, models deriving grid cells from place cells are inconsistent with the data |
| **ALM premotor bistability** (mouse, 2-alternative delay) | ✓ | ✓ (weak photoinhibition erased, strong drives a jump to the other state and the wrong action) | partial (terminal states shared across cue modality) | n/a | **Established and localized**, but the dynamics are task-shaped and acquired by slow plasticity — so the recurrent structure is malleable in adults |
| **Prefrontal / parietal graded working memory** | ✓ | ✓ (bump profile invariant) | partial | n/a | Bump diffuses along a 1-D manifold with variance growing linearly in delay, and the drift **predicts the behavioural error** — the attractor is the memory, not a correlate. Trained on an unnatural task, so C3 across tasks is expected to fail |
| **Cortical up/down states** | ✓ (bistable, sharply peaked histograms) | ✓ | partial | n/a | Network-driven rather than cellular, but the origin is distributed (synchronous across cortex and striatum), so localization fails |
| **Perceptual bistability** | ✓ | — | — | n/a | Two states are evident in the *report*; no bistable circuit has ever been localized, and top-down modulation across many areas is implicated |
| **Discrete multistability** (olfactory, auditory, hippocampus) | suggestive | — | — | n/a | Global inhibition plus selective recurrent excitation are documented; C1–C3 have not been tested quantitatively. **The weakest link in the whole programme** — the machine-side workhorse (Hopfield/WTA multistability) is the biologically least-verified regime |
| **V1 orientation tuning** | ✓ | — | — | n/a | **Departure.** Changing an attractor state needs strong input and is slow, which perception is not; illusory-contour responses lag real ones, implying top-down rather than intra-V1 dynamics. Feedforward drive plus non-normal amplification is the live alternative |
| **Place cells** | ✓ (low-dimensional within an environment) | — | ✗ (cell–cell correlations are *not* preserved across environments — remapping — nor across sleep) | n/a | **Departure**, and the sharpest one — with a second, independent line of attack: a designed dissociation finds hippocampal attractor dynamics present or absent depending on whether the *upstream path integrator* was given two coordinates or one, which puts the landscape in medial entorhinal cortex and CA3/CA1 downstream of it (Colgin et al. 2010, `T389`). Also: storing several high-resolution maps in a homogeneous attractor severely limits capacity (G42), so the conjunctive-feedforward reading (grid + border + landmark + reward inputs) fits better — except that CA3 replay sequences still need recurrence (`T389`) |
| **Motor cortical trajectories** | ✓ | — | — | n/a | **Departure.** The behaviours recorded are themselves stereotyped and low-dimensional (confound 1), and perturbation experiments implicate thalamic input as the driver |

---

## Relevance to a reasoning model

- **This is the missing negative control for every "our network learned an attractor" claim in the wiki.** The four tests are *cheaper* on a trained network than on tissue — the hidden state is fully observable, perturbation is free, and "remove the tuned input" is a line of code — yet no page here runs them. [[wiki/empirical-tensions.md]] T106 and T87 separate attractor from non-attractor solutions by a post-hoc *transience index* fitted to activity; C2 and C3 would settle the same question causally.
- **C3 is the test the machine side cannot borrow unchanged.** "Invariant across environments and into sleep" has no direct analogue for a feedforward-trained model with no autonomous regime; the nearest translations are invariance of the fixed-point set across task families and persistence of the state under zeroed input. **(brainstorm)** The second is exactly the `I`-row an architecture claim needs: *zero the input, run the recurrence forward, and ask whether the state stays where it was put.* A model whose "memory" evaporates under zeroed input is a filter, not a store, and nothing in the wiki reports this number.
- **The criteria are ordered by cost, and the cheapest one is the pairwise route.** Cell–cell correlation invariance recovered head-direction and grid attractors before any population-scale recording existed. Its machine analogue — invariance of the unit–unit correlation matrix across task conditions — needs no embedding, no topology estimate and no labels, which puts it in the same class as [[wiki/concepts/population-geometry.md]]'s parallelism score.
- **A negative result is informative here in a way accuracy never is.** Three of the wiki's most-cited biological justifications for recurrent design (V1 as a line/ring attractor, place cells as a chart store, motor cortex as a limit cycle) are listed by the field's own review as *departures*. Any architecture argument in the wiki that leans on them is leaning on a claim the source literature has withdrawn.

---

## Open problems

- **No criterion distinguishes "has an attractor" from "needs one".** ALM is bistable and the task has two choices; the causation runs either way, and the review's own reading is that the structure was learned to fit the task.
- **The invariance test has no graded form.** C3 is run as pass/fail on a chosen set of conditions; nothing reports *how much* of the cell–cell structure survives a condition change, which is what a model comparison would need.
- **Criterion C4 has no machine instance at all.** Isometry — equal external displacement ↔ equal coding length — is checked for biological integrators and never for a learned one, although it is the property [[wiki/concepts/path-integration.md]]'s composition argument silently assumes.

---

## Connections

- **[[wiki/concepts/attractor-dynamics.md]]** — the design half: that page says what a landscape buys and costs, this page says what licenses the claim that one is there, and its scoreboard rows are the evidence base that page's typology is built on.
- **[[wiki/concepts/population-geometry.md]]** — supplies the estimators (intrinsic dimensionality, held-out reconstruction, the input-geometry control) that C1 is measured with; this page adds the argument that all of them together are *necessary and not sufficient*, and that invariance under input withdrawal is what upgrades a measured manifold to a generated one.
- **[[wiki/concepts/perturbation-elicitability.md]]** — the same causal move at a different level: C2 asks whether a focal edit decays, elicitability asks whether it changes reportable content, and both read a code's steerability off its response to injected current.
- **[[wiki/concepts/structured-flows-on-manifolds.md]]** — the formalism whose central claim (a low-dimensional flow does the computation) this page's confound list says a projection alone cannot evidence.
- **[[wiki/concepts/metastability.md]]** — the alternative explanation C1–C2 cannot exclude: a trajectory deflected by ghost attractors localises and flows back without ever being captured, so the two are separated only by C3's long-dwell invariance.
- **[[wiki/concepts/dynamic-repertoire.md]]** — the worked case of the confound: three whole-brain models reproduce the same low-dimensional cluster structure, and only one of them contains multistability.
- **[[wiki/concepts/path-integration.md]]** — C4 (isometry) is this page's only criterion specific to integrators, and it is the measurement form of that page's path-consistency requirement. That page also owns the variable behind the hysteresis false negative above: whether two environments got one set of path-integrator coordinates or two is what decides whether the downstream store switches abruptly or blends (Colgin et al. 2010).
- **[[wiki/concepts/certification-instruments.md]]** — the same methodological shape in the benchmark domain: an instrument only certifies if it can come back negative on a high-scoring system, which is precisely why C1 is excluded here.
- **[[wiki/entities/fly-central-complex.md]]** — the one system where the anatomical-symmetry support criterion is fully satisfied: a physical ring with a traced connectome implementing the copy-and-offset construction.
- **[[wiki/entities/entorhinal-cortex.md]]** — the circuit holding the scoreboard's strongest row, and the source of the sleep-invariance contrast that separates grid modules from place cells.
- **[[wiki/entities/trnn.md]]** — the machine claim this page's tests would arbitrate: fixed points are reported absent by a measured transience index rather than by perturbation and input withdrawal.
- **[[wiki/concepts/stationary-surrogate-null.md]]** — the complementary null: this page guards against a manifold imposed by the input, that page against structure produced by the statistics of the estimator.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — the rival reading of the same abrupt/gradual dichotomy this page's fifth criterion measures: under that model the sharpness of a transition is the log posterior odds of a hidden-state partition rather than the separation of two anchored coordinates, and the two accounts are carried as `T394`.
