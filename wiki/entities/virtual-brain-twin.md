# Virtual Brain Twin (VBT) — A Personalised Whole-Brain Generative Model, Inverted Against That Individual's Data

**A VBT is a whole-brain network model whose *graph* is one person's connectome, whose *nodes* are neural mass models, and whose *few free parameters* are estimated by Bayesian inversion against that same person's functional recordings. It is the wiki's only worked example of a mechanistic model of a whole system being fitted per-individual and then used to answer a counterfactual — and the design rule that makes it work is the one a builder should take: infer only the parameters the intended use requires, and fix everything else from the literature.**

> **Provenance.** Hashemi, Depannemaecker, Saggio, Triebkorn, Rabuffo, Fousek, Ziaeemehr, Sip, Athanasiadis, Breyton, Woodman, Wang, Petkoski, Sorrentino, Stefanovski, Schirner, Ritter, Bernard & Jirsa 2025, *Principles and Operation of Virtual Brain Twins*, IEEE Reviews in Biomedical Engineering (`raw/hashemi-2025-virtual-brain-twins.md`). A review by the group that built The Virtual Brain (TVB) and the Virtual Epileptic Patient (VEP), covering construction, simulation, inference and four clinical applications. The theory it rests on is [[wiki/concepts/structured-flows-on-manifolds.md]]; the ladder its nodes occupy is [[wiki/concepts/mean-field-reduction.md]]; the estimation family it belongs to is [[wiki/concepts/effective-connectivity.md]].

---

## Architecture

| Stage | What is built | From | Choice points |
|---|---|---|---|
| **1. Structural scaffold** | Nodes co-registered in physical space, connected by a tractography-derived connectome with per-edge **weight `w_ij`** and **delay `τ_ij = d_ij/ν`** | T1 MRI (parcellation), diffusion-weighted MRI (tractography), CT (SEEG electrode positions) | Atlas and resolution (see ledger below); no gold-standard preprocessing pipeline exists |
| **2. Node dynamics** | A neural mass model per node; at high resolution a neural field per cortical vertex | Literature: 29 models implemented in TVB; Epileptor for seizures, Wong–Wang / Wilson–Cowan / Montbrió for rest, Stuart–Landau (Hopf normal form) for oscillatory regimes | Where on the biophysical↔phenomenological continuum; which bifurcation structure is required |
| **3. Source-to-sensor map** | Projection of simulated activity onto the actual measurement | Balloon–Windkessel for BOLD; quasi-static Maxwell solution (spherical / boundary-element / finite-element) with subject geometry for EEG/MEG/SEEG | This is the **observation model**, and it is subject-specific too |
| **4. Inversion** | Posterior over a small set of parameters | MCMC (No-U-Turn Sampler in Stan) or simulation-based inference (neural density estimators / normalising flows) | Which parameters to free, and which low-dimensional data features to fit |

Network equation (low resolution):

```
ψ̇_i(t) = N(ψ_i) + G Σ_j w_ij H(ψ_i, ψ_j(t − τ_ij)) + z(ψ_i) ξ_i(t)
```

`N` local mass dynamics · `G` global coupling · `w_ij, τ_ij` the connectome's **space–time structure** · `ξ` noise. Solved with an explicit stochastic Heun step. The working point is set jointly by `G`, the local bifurcation parameters, and the noise strength `D`.

**Only `G` and a per-region control (bifurcation/excitability) parameter are typically inferred.** Everything else is pinned. The stated reason is convergence of the inference; [[wiki/concepts/structured-flows-on-manifolds.md]] supplies the principled version — the enslaved directions carry no identifiable information, so freeing them buys a flatter posterior and nothing else.

---

## The two ledgers a builder should copy

**Resolution.** The paper prices the mass↔field choice instead of arguing it.

| | Neural mass (low resolution) | Neural field (high resolution) |
|---|---|---|
| Units | ~162–200 regions | up to ~200k–260k cortical vertices |
| Cortex per unit | ~10 cm² | ~1 mm² |
| Connectivity | heterogeneous (connectome) only; local connections absorbed into the node | heterogeneous **plus** a distance-decaying local kernel on geodesic distance, treated as instantaneous (`c → ∞`) |
| Throughput, one desktop GPU (RTX 4090) | **25 M iterations/s** | **25 k iterations/s** |
| Buys | tractable model inversion | cortical travelling waves; accurate electric fields for stimulation modelling |

**Three orders of magnitude for one factor of ~1000 in spatial units** — and inversion, not simulation, is what the high-resolution model puts out of reach. The stated remedies are pseudo-spectral solution and re-parameterising into **spherical-harmonic mode coefficients**, i.e. reduce the *parameter space* rather than the state space.

**Inference.**

| Method | Cost | Output | Amortised? |
|---|---|---|---|
| MCMC (No-U-Turn Sampler) | **7–15 h** per SEEG dataset; embarrassingly parallel across chains | Full posterior, gold standard, unbiased | No — refit per subject |
| Simulation-based inference (neural density estimator on low-dimensional features) | **~14× speedup**; training minutes, sampling **seconds** | Approximate posterior; may over-estimate uncertainty | **Yes** — apply to a new patient with no retraining |
| Optimisation (maximum a posteriori) | lowest | Point estimate only | n/a |

SBI's price is stated honestly: the whole difficulty moves into **choosing the low-dimensional data features** that are informative about the control parameters (functional connectivity, functional connectivity dynamics, power spectral density, SEEG envelope). Mitigations offered: time-delay embedding as data augmentation, and hierarchical re-parameterisation of the configuration space.

---

## What it has actually produced

| Application | Free parameter(s) | Result |
|---|---|---|
| **Virtual Epileptic Patient** (VEP), `n` = 53 drug-resistant focal epilepsy | per-region excitability + global coupling `G`, fitted to SEEG features | Precision against resected tissue **0.972 in seizure-free patients**, **0.593 in non-seizure-free** (overall 0.6 against the clinical hypothesis). Prospective trial EPINOV (NCT03643016), 356 patients. One case: VEP flagged a region outside the clinical hypothesis; after a second surgery targeting it, seizure-free >2 years |
| **Virtual Aging Brain** (VAB), `n` = 649, ages 55–85 | `G`, with interhemispheric structural connectivity degraded *in silico* ("virtual ageing") | Inferred `G` **rises** with age and with structural deterioration, and rises faster in low performers on concept shifting — i.e. global coupling reads as a **compensatory** modulation preserving fluidity, not as damage |
| **Virtual MS Patient** (VMSP) | average conduction velocity `ν`, then a single scalar `γ` mapping lesion intensity to per-edge delay | Inferred conduction velocity is lower in patients, and **adds significant predictive power for clinical disability** over sex, age, disease duration and lesion load — attacking the clinical-radiological paradox (lesion count correlates poorly with impairment) |
| **Resting state / consciousness** | `G`, noise | Fluidity of spontaneous activity separates conscious report under propofol, xenon and ketamine **as well as** the perturbational complexity index, which needs a TMS pulse |
| **Parkinson's** | dopaminergic modulation in the mass model | Correctly predicts individual-level effects of L-Dopa on large-scale activity |

**The VEP precision asymmetry is the most informative number.** In a seizure-free patient the epileptogenic zone was, by assumption, fully resected, so a false positive is genuinely false; in a non-seizure-free patient a false positive is plausibly a *missed* epileptogenic region. The gap between 0.972 and 0.593 is therefore partly the model being right about the cases the surgeon got wrong — which is exactly the reading the metric cannot separate from the model being wrong, and the source says so.

---

## Comparison to the alternatives the source names

| Approach | Personalised | Mechanistic | Simulates counterfactuals | Quantifies uncertainty |
|---|---|---|---|---|
| **VBT** | yes | yes (whole-brain dynamical) | yes (virtual surgery, virtual ageing, virtual stimulation) | yes (MCMC / SBI posterior) |
| Dynamic Causal Model | yes | yes (small networks; effective connectivity) | limited | yes — but via fixed variational schemes (Laplace) |
| Biophysical network models (NEST, NEURON, BRIAN, BMTK…) | **no** | yes, in more detail | yes, in principle | **no** — no integrated inference |
| Deep-learning disease-progression models | yes | **no** | no | rarely |
| Connectomics / graph analysis | partly | **no** | **no** | no |
| Pharmacogenomic / AI predictive models | yes | **no** | no | no |

The distinguishing combination is *personalisation × dynamical mechanism × probabilistic inversion*; nothing else in the table has all three.

---

## Relevance to a reasoning model

- **The design rule generalises past neuroscience: fix the parameters your question does not require.** A whole-brain model has millions of parameters and three are inferred. The wiki's habitual posture is that more free parameters means more expressive; the VBT's posture is that the free parameters *are the hypothesis*, and everything else is scaffolding. This is [[wiki/concepts/objective-identifiability.md]]'s lesson applied prospectively rather than as a post-hoc audit.
- **A fitted generative model is a controller.** Virtual surgery, virtual ageing and virtual stimulation are all the same operation: perturb the fitted model, read the consequence, act on the real system. This is [[wiki/concepts/simulation-based-planning.md]] with a world model that was *inverted* from data rather than learned by prediction — and the epilepsy case is the wiki's only instance where the plan was executed on the physical system with a recorded outcome.
- **The observation model is subject-specific and is half the engineering.** Balloon–Windkessel for BOLD, quasi-static Maxwell with the individual's skull geometry for EEG/MEG. The source's own criticism of the field is that everyone uses **one haemodynamic model across all regions, subjects and conditions** even though the haemodynamic response demonstrably varies by region, by individual, with age, and with neurodegeneration — so a fitted "functional connectivity" difference may be a vascular difference (gap `G81`).
- **Amortisation lands where the wiki predicted it would.** SBI is trained once on simulations and applied to new patients in seconds; the boundedness limit is the training prior, and the feature-selection problem is the "training distribution is a design object" problem from [[wiki/concepts/amortized-inference.md]] appearing verbatim in a clinical pipeline.
- **A negative result worth carrying: the model has no long timescales.** Seizures fluctuate on daily-to-monthly cycles and nothing in a VBT represents that. A system fitted to minutes of recording is silent about the process that decides when it will next be needed — the same missing level as `G67`.

---

## Limitations

- **Computationally expensive and parameter-sensitive**, which the authors name as the obstacle to clinical routine.
- **Preprocessing is not determinate.** 70 international teams analysing the same fMRI data produced **no two identical pipelines** and sizeable variation in the statistical results; comparable studies exist for tractography and are underway for EEG. Every VBT's graph inherits this. A typical 3 T multimodal dataset takes ~12 h to preprocess on a workstation.
- **Neural mass modelling simplifies the dynamics**, bounding the granularity of anything simulated; the proposed fix (invert high-resolution neural field models) is exactly the one the 1000× throughput gap blocks.
- **No ground truth for a recovered parameter.** The VEP is validated against surgical outcome — a downstream behavioural proxy — and never against a measured excitability.
- **Nothing learns.** The connectome is measured, the node equations are chosen from literature, the parameters are fitted per session. There is no plasticity rule anywhere in the pipeline.

---

## Connections

- **[[wiki/concepts/structured-flows-on-manifolds.md]]** — the theory this system is an engineering realisation of: the manifold is simulated forward to produce the observable *and* is the object the inversion samples, which is why inferring three parameters out of millions is principled rather than expedient.
- **[[wiki/concepts/mean-field-reduction.md]]** — supplies the rung every node occupies and the price list for moving between rungs; this page adds the measured cost of the mass→field step (25 M vs 25 k iterations/s on one GPU) and the observation that inversion, not simulation, is what the finer rung puts out of reach.
- **[[wiki/concepts/effective-connectivity.md]]** — the estimation family this belongs to, and the position it occupies in that page's identifiability trade: a *nonlinear* whole-brain model with a handful of free parameters, inverted per subject in seconds by simulation-based inference — which is neither of the two poles that page tabulates.
- **[[wiki/concepts/amortized-inference.md]]** — the clinical instance of the pattern: simulation-based inference trains a neural density estimator once and returns a per-patient posterior in seconds with no retraining, and its stated difficulty is precisely the choice of low-dimensional data features, i.e. the training distribution as a design object.
- **[[wiki/concepts/metastability.md]]** — supplies the working point this system tunes to and one of its data features: fluidity (functional-connectivity-dynamics variance) is the estimator used here, and the anaesthesia result gives it an external validation against the perturbational complexity index.
- **[[wiki/concepts/dynamic-repertoire.md]]** — what a VBT simulates at rest: noise-driven wandering of the configurations a personal connectome makes reachable, with the individual's own weights and delays instead of a group-averaged skeleton.
- **[[wiki/concepts/node-definition-problem.md]]** — the step upstream of everything here, and the source of this page's sharpest caveat: 70 teams produced 70 different pipelines on one fMRI dataset, so the vertex set and edge weights a VBT is personalised *to* are the output of an undetermined procedure.
- **[[wiki/concepts/simulation-based-planning.md]]** — planning over a model that was inverted rather than learned: virtual surgery searches over resections inside the fitted model, and in the reported case the plan was executed on the patient with a recorded outcome.
- **[[wiki/concepts/objective-identifiability.md]]** — the audit run forwards: which parameters may be freed is decided before fitting from the model's degeneracy structure, rather than diagnosed afterwards from a representation that could have come from many objectives.
- **[[wiki/concepts/learnable-synaptic-delays.md]]** — the one application where a delay is the *inferred* quantity: conduction velocity, and then a per-edge delay derived from lesion intensity by a single scalar, predicts multiple-sclerosis disability beyond lesion load.
- **[[wiki/entities/fcann.md]]** — the wiki's other whole-brain model, and the contrast: fcANN's couplings are a statistic of group data with a symmetric unsigned matrix and no observation model, where a VBT's are an individual's tractography plus delays with an explicit source-to-sensor projection.
- **[[wiki/concepts/attractor-dynamics.md]]** — the node-level design vocabulary: interictal state as a fixed point, ictal state as a limit cycle, and the pair of bifurcations connecting them as the taxonomy ("dynamotypes") that selects which mass model a clinical application needs.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the case where the graph is *measured* rather than discovered, and only its scalar modulation is inferred; the payoff is that a three-parameter posterior over a measured graph supports counterfactuals that a fully-discovered graph in this wiki has never supported.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — the pipeline this entity runs per individual, characterised at group level: diffusion imaging → tractography → weighted region graph, with its validation (78.9% agreement with macaque tracer data) and its biases (6.1% tracer-contradicted edges; lateral and interhemispheric fibres underrepresented) inherited wholesale.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the result that licenses this entity's division of labour (anatomy fixed, few parameters fitted): the forward direction is strong and the reverse is ill-posed at ≈6% precision, and the lateral-parietal default-mode failure demonstrated there is the blind spot every diffusion-seeded personal model inherits.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — the same group's opposite design choice, and the sharpest available test of this page's *fix what your question does not require* rule: ~143,000 per-edge parameters fitted per subject, demonstrably non-identifiable (`CV = 0.5` / `0.72` over 1000 refits), and yet the simulated time series reproduce at `r = 0.9962` — so degeneracy blocks reading a parameter without blocking the prediction ([[wiki/empirical-tensions.md]] T245).
- **[[wiki/concepts/cortical-traveling-waves.md]]** — what this entity's surface-based simulation buys, cashed out: cortical travelling waves simulated in this platform on a 1000-region human connectome, with their propagation direction traced to the connectome's instrength gradient and shown to vanish when conduction delays are removed (Koller et al. 2024).
