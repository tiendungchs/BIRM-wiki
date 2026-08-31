# Integration–Segregation Balance — Network Topology as a Fast Control Variable

**A modular network does not have one topology; it has a one-dimensional family of them, and it moves along that family in seconds. Measured on the human brain at ~10 s resolution, the axis is *between-module* connectivity (participation coefficient `B`) — within-module connectivity `W` does not move at all — the position along it is graded by task demand rather than switched, and the position predicts behaviour in the right decomposition: more integration buys a faster drift rate and a shorter non-decision time, and leaves the response boundary untouched. The candidate knob is ascending neuromodulatory gain, indexed by pupil diameter.**

> **Provenance.** Shine, Bissett, Bell, Koyejo, Balsters, Gorgolewski, Moodie & Poldrack 2016, *The Dynamics of Functional Brain Networks: Integrated Network States during Cognitive Task Performance*, Neuron 92(2):544–554, doi:10.1016/j.neuron.2016.09.018 (`raw/shine-2016-integrated-network-states-cognition.md`). Time-resolved graph analysis of 375-parcel fMRI: 92 unrelated Human Connectome Project subjects at rest and on seven tasks, replicated on a second session, a second 92-subject cohort, and 152 subjects from the NKI Rockland sample at a different site; plus a separate 14-subject resting dataset with simultaneous pupillometry.

The wiki already has the *substrate* account of a fluctuating functional graph ([[wiki/concepts/dynamic-repertoire.md]], [[wiki/concepts/metastability.md]]) and the *anatomical* account of where crossing traffic must go ([[wiki/concepts/connectome-hubs-and-cores.md]]). Neither says what the fluctuation is *for*. This page is the missing behavioural link: the same axis, measured against reaction-time decomposition and against an arousal index, in awake humans doing a task.

---

## The measurement chain

Four steps, all computable on any modular system that emits per-module time series — no weights, no labels, no task regressor required.

| Step | Quantity | Definition |
|---|---|---|
| 1. Time-resolved coupling | `MTD_ijt` | `(1/w) Σ_{t}^{t+w} (dt_it · dt_jt)/(σ_dt_i · σ_dt_j)` — the **multiplication of temporal derivatives**: point-wise product of the two z-scored first derivatives, boxcar-averaged over `w`. Signed, weighted, unthresholded; `w = 14` TR ≈ 10.1 s here |
| 2. Community partition | `Q_T`, `Ci_T` | Louvain modularity on the signed weighted matrix per window, `γ = 1`, 500 restarts + consensus fine-tuning |
| 3. Two per-node graph statistics | `W_iT` = `(κ_iT − κ̄_{s_iT}) / σ_{κ_{s_iT}}` | **within**-module degree z-score |
| | `B_iT` = `1 − Σ_{s=1}^{n_M} (κ_isT / κ_iT)²` | **between**-module participation coefficient: 0 if all links stay in-module, →1 if links are spread uniformly across modules |
| 4. **Cartographic profile** | 2-D joint histogram of `(W_iT, B_iT)` over all 375 nodes, one per window | The paper's methodological move: keep the *whole* joint distribution instead of binning nodes into Guimerà–Amaral hub classes, so the cartographic class boundaries — which are arbitrary — never enter |

**Why step 4 matters for a builder.** A hub taxonomy assigns each node a label; a joint histogram makes the *system* the unit of analysis and gives a state vector that can be clustered, correlated with a regressor, or affinely registered against another condition. `k`-means at `k = 2` on that histogram (500 restarts) recovers two states with no labels anywhere in the pipeline, and the partition is stable: mutual information with the `k = 2` partition averages `0.400 ± 0.02` across `k = 2…20`, and per-subject PCA gives an integrated first component (20.2 ± 1.4% variance) and a segregated second (4.9 ± 2.3%).

---

## What the two states are

| | Segregated | Integrated |
|---|---|---|
| Modularity `Q` | **0.55 ± 0.1** | 0.42 ± 0.2 (Cohen's `d = 0.9`, `p = 10⁻¹¹`) |
| Global efficiency `E` (positive-weight thresholded) | 0.18 ± 0.03 | **0.24 ± 0.05** (`d = 1.5`, `p = 10⁻⁸`) |
| Graph density | matched — the states are **not** a sparsity artefact | matched |
| Time spent, rest | ~30% | **70.32 ± 1.4%** |
| Regional signature | relatively higher participation within default-mode regions | all 375 parcels higher `B_T` (FDR `α < 0.05`); largest shift in sensory and attentional networks |

**The single sharpest structural result: `B` moves and `W` does not.** All 375 parcels show significantly higher `B_T` in the integrated state; **zero** parcels differ in `W_T` between states. Whatever the control variable is, it acts on the *between*-module fraction of each node's connectivity budget and leaves the internal cohesion of the modules alone. For a modular architecture this is a specification, not a description: the reconfiguration surface is the cross-module bandwidth, and module internals are off it.

**A counter-datum on the `W`-null, from a single-network design.** Within one network's own subsets, within-class coupling does move with state: over rest → relaxed task → speeded task → rest, coupling *among* the default-mode regions that disengage falls, coupling *among* the recruited insula/cingulate regions rises, and only the stable core's internal coupling is flat (Gao et al. 2013, `N = 19`, [[wiki/entities/default-mode-network.md]]). The two results are not directly comparable — 375 hard parcels with modules re-estimated per window here, versus three functionally defined classes with fixed membership there, and the "modules" there are subsets of one network rather than the network partition — but if within-module coupling really does not move, a within-class change of `0.43 → 0.24` needs an account. Logged as [[wiki/empirical-tensions.md]] T263.

**A second decomposition of the same behavioural coupling.** This page's `B`-axis buys drift rate and non-decision time with the boundary untouched — one axis, two speed-side effects, no trade. The single-network design finds a **double dissociation instead**: depth of *disengagement* from the internal periphery predicts reaction time only, degree of *integration* with recruited outside regions predicts accuracy only, with the crossed correlations null. If both hold, the scalar `mean B` is a sum of two components with different behavioural targets, and averaging them is throwing away the more useful half.

**It is genuine dynamics, not sampling noise.** Against a VAR(11) null fitted to the group covariance (2500 surrogates, matched filtering), 16.1 ± 1.1% of windows exceed the 95th percentile of window-to-window `|Δ mean B_T|` — three times the 5% expected. Fluctuations are uncorrelated with framewise displacement (`r = 0.01 ± 0.01`), with cerebrospinal-fluid/white-matter nuisance signal (`r = −0.02 ± 0.01`), and with the number of modules recovered per window (`r = 0.03 ± 0.10`).

---

## Position on the axis is graded by demand

With the haemodynamic-convolved task blocks **regressed out of the time series before** coupling is computed — so what remains is co-fluctuation of residuals, not shared task drive:

| Comparison | Result |
|---|---|
| Mean `B_T` vs. N-back block regressor | `r = 0.521`, `R² = 0.27`, `p = 10⁻¹⁰` |
| …after also regressing the global signal | `r = 0.452 ± 0.21` |
| …after also regressing mean coupling across all parcels | `r = 0.393 ± 0.14` |
| Task ordering along the `B_T` axis (affine registration of each subject's task profile onto their own rest profile, 3 d.o.f.) | **Motor least integrated → five other HCP tasks → N-back most integrated**; 88.8% of parcels higher `B_T` in N-back than Motor |
| Where the task-driven integration is largest | frontoparietal, default-mode, striatal, thalamic — the rich club |

So integration is a **dial read by difficulty**, not a mode switch: a repetitive effector task sits nearer the segregated end than rest, a working-memory-updating task further out than rest, and the remaining five in between. The 2-back block sits further right than 0-back within the same task.

---

## The behavioural coupling, in the decomposition that constrains mechanism

EZ-diffusion fit per subject to 2-back trials (mean correct RT, RT variance, accuracy → drift rate `v`, non-decision time `t`, boundary `a`):

| Diffusion parameter | Relation to mean `B_T` | Reading |
|---|---|---|
| **Drift rate `v`** | positive | integration raises the signal-to-noise of evidence accumulation |
| **Non-decision time `t`** | negative | integration also shortens encoding/motor stages *outside* the decision |
| **Boundary `a`** | **none** (no histogram bin survived correction) | integration is **not** a speed–accuracy trade-off — nothing here is being traded |
| `W_T` vs. any of the three | **none** for all 375 parcels | again: the whole behavioural signal lives on the between-module axis |

Both effects replicate in the independent 92-subject cohort, and both localise to the same set: **frontoparietal, striatal, thalamic and pallidal**, right-lateralised.

**A contrary sign from the same class of measurement.** Mean *resting* functional connectivity — a global coupling statistic rather than a routing statistic — correlates **positively** with correct-response time on untimed matrix reasoning (`r = 0.13`, `N` = 650), and the whole-brain models fitted to those individuals trade accuracy for time rather than getting both ([[wiki/concepts/excitation-inhibition-balance.md]], Schirner et al. 2023). Logged as [[wiki/empirical-tensions.md]] T250; the candidate reconciliation is that the two studies measure different quantities (participation coefficient during task vs. mean coupling at rest) on different task regimes (a speeded 2-back vs. an untimed reasoning test where taking longer is permitted).

**Why the boundary null is the load-bearing datum.** A model that merely raised arousal-driven urgency would move `a`. A model that merely traded accuracy for speed would move `a`. What moves is the rate of information gain per unit time and the fixed overhead — i.e. integration buys *throughput*, at no cost in caution. That is the profile of a bandwidth change, not of a policy change, and it is what makes this page's axis a plausible architectural knob rather than a re-description of "trying harder".

---

## The candidate driver: ascending neuromodulatory gain

Separate 14-subject resting dataset, pupil diameter recorded at 60 Hz, cleaned, downsampled to 0.5 Hz, convolved with an informed basis set:

- pupil vs. mean `B_T`: `r = 0.241 ± 0.06`, `R² = 0.06`, `p = 10⁻⁵`, maximal in frontoparietal, striatal and thalamic parcels;
- conjunction (positive with drift rate ∧ negative with non-decision time ∧ positive with pupil) is satisfied by `B_T` in a right-lateralised frontoparietal–striatal–thalamic set, and by no cerebellar parcel.

Non-luminance pupil diameter tracks locus-coeruleus firing (Joshi et al. 2016; McGinley et al. 2015), so the proposed chain is **noradrenergic gain → neural gain on each unit's input–output function → cross-module coupling exceeds threshold → participation rises**. This is the same one-scalar-gain story as the coupling parameter `k` on [[wiki/concepts/metastability.md]], now with an *endogenous measured signal* standing in for the swept parameter. Caveats the authors state: `R² = 0.06`; the inference from pupil to locus coeruleus is indirect; cholinergic tone and intralaminar thalamic projections are equally available carriers; and the right-lateralisation argument rests on a 1981 lesion literature.

---

## Reproducibility

| Replication | `r_W_T` | `r_B_T` | `r_cartographic profile` |
|---|---|---|---|
| Session 2, same 92 subjects | 0.982 | 0.957 | 0.982 |
| Independent 92 HCP subjects | 0.971 | 0.967 | 0.973 |
| NKI Rockland, different site/protocol (`n = 152`) | 0.941 | 0.857 | 0.927 |

Task-behaviour relations replicate at `r > 0.610`. This is a stronger reproducibility ledger than most entries in the wiki's dynamic-connectivity material, and it is what licenses treating the axis as a real property rather than a pipeline artefact.

---

## What the design does not establish

- **Direction is unidentified.** fMRI alone cannot separate "integration enabled the communication" from "the communication produced integration as a by-product" (the authors' own statement). Nothing here is a manipulation; the only causal handle proposed is future optogenetic or electrophysiological work.
- **The frequency band was chosen before the analysis.** Band-pass `0.071 < f < 0.125 Hz` plus a 14-TR moving average means the phenomenon is defined at ~0.1 Hz by construction. The 0.35 Hz haemodynamic arbitration bound on [[wiki/concepts/metastability.md]] applies unchanged.
- **`k = 2` was assumed, then defended.** The mutual-information and PCA checks show the two-state partition is *not contradicted* at higher `k`; they do not show two is the right number.
- **The estimator is one of many.** Multiplication of temporal derivatives is more sensitive to covariance than to correlation and has not been cross-validated here against the full range of time-resolved connectivity methods.
- **`Q` and `E` are functions of coupling gain, not only of topology** — the caution logged on [[wiki/concepts/metastability.md]]. A global gain change moves every graph statistic in the table above without any edge changing, which is *consistent* with the pupil result and is exactly why the pupil result cannot be read as evidence of rewiring.
- **The node set is fixed and hard.** 333 Gordon cortical parcels + 14 subcortical + 28 cerebellar, identical across subjects and time, so `W` and `B` are both stated in units the [[wiki/concepts/node-definition-problem.md]] page shows are not neutral — a coarser parcellation moves relational mass from `B` into `W` mechanically.

---

## Relevance to a reasoning model

- **A one-dimensional runtime knob for a modular architecture, with a measurement and a target.** Compute `B_i` per module per window from the module's own output correlations, average it, and you have a scalar state variable of the whole system that (i) needs no weights, no labels and no task identity, (ii) is graded by demand, and (iii) predicts throughput. The wiki's existing operating-point statistic `σ_R` ([[wiki/concepts/metastability.md]]) says *how much of the repertoire is being visited*; `mean B` says *where on the specialisation↔bandwidth axis the system currently is*. They are complementary and both cheap.
- **Demand-graded, not demand-switched.** **(brainstorm)** A mixture-of-experts router with a fixed top-`k` implements exactly one point on this axis, chosen at design time and held constant across every query. The biological analogue is a router whose *dispersion* (how uniformly a token's routing mass spreads across experts) is set per-batch by an estimate of task difficulty, with the cheap tasks routed sparsely and the hard ones routed broadly. Participation coefficient is the right measurand for that dispersion — it is already a normalised, module-count-invariant statistic — and the Motor→N-back ordering says the mapping from difficulty to dispersion is monotone rather than binary.
- **Gain, not gating.** The `W`-null says the mechanism does not restructure modules; it changes how much of each unit's output escapes its module. A single multiplicative gain on inter-module edges reproduces that signature; a learned per-edge gate does not need to be, and should not be, the first thing tried. This is [[wiki/concepts/dynamic-network-connectivity.md]]'s per-synapse gain register applied at network scale, and [[wiki/concepts/neuromodulatory-metaparameters.md]]'s "give each global quantity one broadcast channel" with the quantity finally named: cross-module coupling strength.
- **The set-point can be closed-loop, and the loop already exists.** Doya's control laws set metaparameters from the learner's own second-order statistics. Here the loop is the same shape: an internal difficulty estimate (accumulator variance, conflict, `S(T)` in [[wiki/concepts/evidence-accumulation.md]]'s log-softmax denominator) sets the gain; the gain sets `B`; `B` sets drift rate; drift rate feeds back into the difficulty estimate. **(brainstorm)** That is a two-line addition to any architecture that already computes a response-conflict term, and it is the concrete form the missing "exploration as an operating point" mechanism (`G61`) would take on the *routing* variable rather than the action variable.
- **A cost model comes attached.** [[wiki/concepts/connectome-hubs-and-cores.md]] prices topological centrality in metabolism (`r² = 0.49` between centrality and resting blood flow), and this page says the traffic across those hubs is *modulated by demand*. Together they license a runtime policy no wiki architecture has: pay the cross-module communication cost only in proportion to how hard the current problem is, and default to the cheap segregated regime — which is also, note, the state the resting brain spends only 30% of its time in, so the biological default is *not* the cheap one.
- **A benchmark axis.** If integration is what buys throughput on hard tasks, then a model whose routing dispersion is fixed should show a characteristic failure: performance that degrades on precisely the items that require combining information across its specialisations, while single-specialisation items are unaffected. That is a testable prediction about existing mixture-of-experts systems and needs no new architecture to check.

---

- **`G85` — no architecture in the wiki reads its own network topology, and none treats it as a demand-graded control variable.** This page supplies the evidence that biology does grade it by demand; the gap is that every architecture here has a graph fixed at design time and no read access to it.

## Connections

- **[[wiki/concepts/metastability.md]]** — the same axis with a different order parameter and an unresolved conflict at the endpoint: `σ_R` says a fully coherent network has a repertoire of size one and is useless, while this page's most-integrated states are the best-performing ones — logged as [[wiki/empirical-tensions.md]] T249; the shared claim is that one global coupling gain moves every graph statistic without any edge changing.
- **[[wiki/concepts/dynamic-repertoire.md]]** — supplies the substrate for the fluctuation this page measures behaviourally: the wandering is noise-driven exploration of configurations reachable on a fixed skeleton, and this page adds that the wandering is *steerable by task demand* and that its position predicts reaction-time parameters.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — the anatomy that constrains the traffic: participation coefficient is the same statistic Hagmann et al. compute on structure, so this page is that measure made time-resolved, and the regions whose `B_T` rises most with task are the connector hubs whose metabolic cost that page prices.
- **[[wiki/concepts/cognitive-control.md]]** — a control output the biased-competition account does not have: control here is not a bias injected into a competition but a change in how much of every module's output leaves the module, and the demand-grading (Motor → N-back) is the same difficulty ordering that page's controller responds to.
- **[[wiki/concepts/evidence-accumulation.md]]** — the decomposition that makes this page's behavioural claim mechanistic: integration raises drift rate `v` and lowers non-decision time `t` while leaving boundary `a` untouched, so the network state sets the evidence signal-to-noise rather than the stopping rule — and that page's conflict term `S(T)` is a ready-made internal signal for setting the gain.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — names the carrier and adds a metaparameter to that page's list: noradrenergic gain, indexed by pupil diameter, controlling not the inverse temperature `β` but the *cross-module coupling* of the network the policy runs on — one broadcast channel, one global quantity, exactly that page's topology argument.
- **[[wiki/concepts/dynamic-network-connectivity.md]]** — the per-synapse version of this page's network-scale knob: a content-free gain register set in seconds by arousal, which is what a global `B`-raising signal would have to be implemented as, and it supplies the failure mode (acute stress disconnects the network) that a runtime integration dial inherits.
- **[[wiki/concepts/connectome-state-transformation.md]]** — the alternative formalisation of the same rest→task change: a rank-10 linear operator between two window-averaged graphs, where this page has a single scalar position on one axis; that page's own stated next step is to incorporate integration/segregation, which is this measurement.
- **[[wiki/concepts/node-definition-problem.md]]** — the upstream choice this page's two statistics are stated in: `W` and `B` partition a node's connectivity budget, and the partition boundary *is* the parcellation, so a coarser atlas mechanically converts between-module mass into within-module mass and shifts the whole cartographic profile.
- **[[wiki/concepts/effective-connectivity.md]]** — the estimation contrast: multiplication of temporal derivatives gives an undirected, unsigned-in-use coupling at 10 s resolution with no generative model, which is why this page can measure a state and cannot say which direction the causation runs.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a constraint on the discovery side: the graph recovered from the same nodes changes its modularity by `d = 0.9` within seconds under a constant anatomy, so any discovered edge set is indexed by the system's momentary gain as well as by its window.
- **[[wiki/concepts/attention.md]]** — the resource question restated at network scale: the throughput gain here comes with no boundary shift, so the limit that integration relieves is bandwidth between specialised systems rather than a capacity that must be divided.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — the same network-state→reaction-time question with the opposite sign: higher *mean* resting functional connectivity predicts **longer** correct-response times on matrix reasoning (`r = 0.13`) and, in the fitted models, better accuracy — a genuine trade where this page's decomposition finds none — logged as [[wiki/empirical-tensions.md]] T250; the mechanistic contrast is that this page's knob is a global gain on between-module edges and that page's is a per-edge excitatory/inhibitory-targeting mixture.
- **[[wiki/concepts/cortical-traveling-waves.md]]** — a third graph-derived statistic on the same substrate, and the only signed one: participation coefficient says how a node's edge mass is *distributed*, instrength says how much *arrives*, and only the latter is claimed to set a direction of flow (Koller et al. 2024).
- **[[wiki/concepts/parallel-timescale-streams.md]]** — the same state variable at higher resolution: participation coefficient `B` at ~10 s is roughly "how many networks are co-active", i.e. a projection of the 126-bit coalition mask onto its popcount, and it is measured only in the slowest of six concurrent streams (Alderson et al. 2026).
- **[[wiki/concepts/small-world-topology.md]]** — the static version of this page's axis: high clustering plus short paths is a *set point* on a fixed wiring diagram, and this page shows the same trade being re-negotiated in ~10 s by moving between-module connectivity alone.
- **[[wiki/entities/default-mode-network.md]]** — the network where this page's axis has been decomposed into two separately-behaving components (release of internal periphery → speed, acquisition of outside regions → accuracy) and where within-class coupling moves against this page's `W`-null ([[wiki/empirical-tensions.md]] T263); also a named pair on this page's axis: the default and dorsal attention systems are anticorrelated, individuals with the strongest intrinsic default coupling show the most attenuated sensory-evoked responses, and whether a separate frontoparietal arbitrator sets the balance or the two systems settle it locally is unresolved.
- **[[wiki/entities/salience-network.md]]** — a candidate event-driven, anatomically localised driver for this page's axis, against its diffuse neuromodulatory-gain candidate: anterior insula signalling is claimed to disengage the default network and engage frontoparietal cortex by one mechanism.
- **[[wiki/concepts/broadcast-hierarchy.md]]** — an integration mechanism with an asymmetry this page's scalar cannot see: compressed, selective input from high-level areas paired with diffuse output across many levels and laminar types, which an undirected participation coefficient scores the same as symmetric integration.
- **[[wiki/concepts/microarchitectural-topography.md]]** — the *kind* of integration this page cannot distinguish: convergent (smooth microarchitectural gradient, progressive abstraction) versus combinatorial (interdigitated microarchitecture, binding of disparate sources), which a participation coefficient measures identically.
- **[[wiki/entities/integrated-world-modeling-theory.md]]** — a computational reading of this axis: the segregated phase keeps plural hypotheses alive inside modules and the integrated phase collapses them to one broadcast MAP estimate written back as each module’s prior, so a network’s position on the participation-coefficient axis is also its position between a distribution and a point estimate — a particle filter whose resampling step is scheduled by topology.
- **[[wiki/concepts/transthalamic-context-routing.md]]** — the same arousal index (pupil diameter) with a route this page's noradrenergic-gain account does not contain: a cortical area's pupil-linked modulation survives silencing its cortico-cortical inputs and collapses when one higher-order thalamic projection is silenced, so not all pupil-correlated gain is chemical (Neske & Cardin 2025).
- **[[wiki/concepts/sparse-expert-routing.md]]** — supplies the actuator this page asks for and shows why it is not sufficient: a top-`k` router *is* a one-scalar dispersion knob over modules, but `k` and the capacity factor are design-time constants in every deployed sparse expert model, so a cheap query and one that must combine two specialisations are routed identically — the `G85` failure with a concrete architecture behind it (Fedus, Dean & Zoph 2022).
