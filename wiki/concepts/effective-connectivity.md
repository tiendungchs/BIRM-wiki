# Effective Connectivity — Edges Recovered by Inverting a Generative Model

**Structural and functional connectivity are *measurements*; effective connectivity is an *estimate of the parameters of a model that could have produced the measurement*. That single change of status buys the three things a correlation matrix structurally cannot express — direction, sign, and within-node recurrence — and costs a commitment to a specific neuronal model, a specific observation model, and a specific optimiser. The recovered graph is not an atlas: it is indexed by the state the brain was in, so there is one effective connectome per task, per stimulus, per direction of attention.**

> **Provenance.** Li & Yap 2022, *From descriptive connectome to mechanistic connectome: Generative modeling in functional magnetic resonance imaging analysis*, Frontiers in Human Neuroscience 16:940842, doi:10.3389/fnhum.2022.940842 (`raw/li-2022-mechanistic-connectome-generative-models.md`). A review of the three generative-model families used to estimate effective connectivity from fMRI (Dynamic Causal Model, Biophysical Network Model, Dynamic Neural Model), their cost/identifiability trade, and what each recovers. This is the *inverse* half of [[wiki/concepts/mean-field-reduction.md]] — that page's ladder is forward-only and states as an open problem that the heterogeneous long-range coupling "is supplied by anatomy, never recovered"; this page is the literature that recovers it.

---

## What the descriptive connectome cannot say

| Missing property | Why it is missing | What it costs |
|---|---|---|
| **Direction** | Both structural connectivity (diffusion tractography) and functional connectivity (correlation, mutual information, ICA, HMM) are symmetric relations | Anatomical and functional asymmetry (Felleman & Van Essen 1991) is inexpressible; feedforward and feedback cannot be told apart |
| **Sign** | Tract density and correlation magnitude are both non-negative quantities | No excitation/inhibition balance can be estimated — the quantity that governs coding, plasticity and neurogenesis |
| **Intra-regional connections** | A node has no interior in either representation | Cortical neurons are more influenced by short-range local than by long-range inter-regional input, so the dominant term is the one omitted |
| **Mechanism** | Both are descriptions of a relation, not of a process | No account of *how* the observed data arose, hence no counterfactual and no stimulation target |

Effective connectivity (Friston et al. 2003) is defined as the **directed causal influence one neuronal population exerts on another**, and it exists as a *coupling parameter of a generative model* rather than as a statistic of the data.

---

## The three-component template

Every generative model of a connectome in this literature is exactly three parts, and the parts are independently swappable:

| Component | Job | Instances |
|---|---|---|
| **1. Neuronal model** | Generate population-level latent activity `x(t)` | Bilinear state space `ẋ = [A + Σ_k B^k u_k(t)] x + C u(t)`; two-state (E/I) linear; canonical-microcircuit neural mass (4 populations × 2 hidden states, 2nd-order ODEs); integrate-and-fire spiking with AMPA/NMDA/GABA_A kinetics; dynamic mean-field `Ṡ_i = −S_i/τ_s + r(1−S_i)H(x_i) + σν_i`, `x_i = wJS_i + GJ Σ_j C_ij S_j + I`; Wilson–Cowan E/I pair; multivariate Ornstein–Uhlenbeck |
| **2. Observation model** | Map latent activity to the measurable | The Balloon/Windkessel haemodynamic chain — vasodilatory signal `ṡ = x − κs − γ(f−1)`, flow `ḟ = s`, volume `τv̇ = f − v^{1/α}`, deoxyhaemoglobin `τq̇ = …`, then `y = v₀(k₁(1−q) + k₂(1−q/v) + k₃(1−v))`. Shared verbatim between the Dynamic Causal Model and most Biophysical Network Models |
| **3. Optimisation scheme** | Fit coupling parameters to data | Variational Laplace (Bayesian model inversion) → posterior + model evidence; expectation-maximisation; gradient descent; NADAM on one-step prediction error; genetic algorithm; maximum likelihood |

**For a builder this is the reusable part.** The graph, the emission process and the estimator are three separate design choices, and nearly every property below is traceable to one of them rather than to "the method". The wiki's graph-discovery pages ([[wiki/concepts/latent-graph-discovery.md]]) almost always assume component 2 is the identity; here the observation is a slow, nonlinear, regionally-varying filter of the state, and half the methodological argument is about it.

---

## Three families, one trade

| | **Dynamic Causal Model (DCM)** | **Biophysical Network Model (BNM)** | **Dynamic Neural Model with direct parameterisation (DNM)** |
|---|---|---|---|
| Design objective | Estimate *individual connections* for a *single subject* | *Simulate* fMRI and reproduce its statistics | Both, deliberately |
| Neuronal model | Simple (bilinear); recently neural-mass | Realistic (spiking or mean-field) | Neural mass, abstracted to the scale being fit |
| Long-range weights | Estimated; structural connectivity optional as prior | **Structural connectivity used as a proxy for synaptic weight** | Optional (MNMI uses it as a sparsifying prior; MINDy uses none) |
| What is fit to | Raw BOLD time series (spectral/regression variants: cross-spectra) | High-level summary statistics — usually the functional connectivity matrix | One-step prediction error on BOLD, or functional connectivity |
| Free parameters recovered | All connections, per subject | Often **one** global scaling `G`; sometimes a small subset, at group average | All connections, per subject |
| Estimator output | Full posterior → Bayesian model comparison, automatic pruning | Point estimate; no pruning | Point estimate |
| Scale / cost | <10 nodes deterministic; spectral DCM 36 nodes in **20–40 h**; regression DCM (rDCM) 66 nodes in **seconds**, >200 regions / >40,000 connections in **minutes** | up to ~1000 nodes, forward simulation cheap, inversion effectively impossible | MINDy: hundreds of nodes, **1–3 min per subject**; MNMI: heavy |

The two poles are **identifiability** and **biological realism**, and the review's central observation is that the boundary is dissolving: DCM has acquired a canonical-microcircuit neural mass and a linear whole-brain variant, BNM has acquired per-subject whole-brain estimation (MOU-EC, Gilson et al. 2016–2020, maximum-likelihood fit of a multivariate Ornstein–Uhlenbeck process — equivalently a linear-feedback network, i.e. the linearisation of Wilson–Cowan), and DNM was constructed in the gap.

**Where the identifiability is bought from is explicit, and it is not from the data.** rDCM moves the linear DCM equations into the frequency domain, fixes the haemodynamic response function, and thereby turns model inversion into Bayesian linear regression — 40,000 connections in minutes, at the price of a model that is inherently linear with no neural mass in it. MINDy fits at the *fMRI* timescale rather than the neuronal one, and deconvolves BOLD instead of simulating it. Every order of magnitude in scale is paid for in the expressiveness of component 1 or 2.

---

## The claim with the largest consequence: there is no atlas

> "Unlike static structural connectome, mechanistic connectome based on effective connectivity is **parameterized by the state of the brain**. That is, one would obtain a very different mechanistic connectome when the task demands change, or when the stimuli change, or when endogenous activity switches to a different state (e.g. inward vs outwardly directed attention). Thus, there will not be a conventional atlas for the mechanistic connectome like one could obtain for the structural connectome."

This is the same object the bilinear equation states formally: `A` is the baseline graph and `B^k` is *the modulation of the graph by input* `u_k`. The edges are a function of the context, and the model has a slot for it.

**The claim needs one qualification, and it is the useful half.** No atlas of state-specific *graphs* — but the state-to-state *transformation* is atlas-able. Yoo et al. 2022 estimate one rank-10 linear operator per task state from ~285 subjects' paired rest/task connectomes and apply it to individuals the operator never saw, generating their task connectome accurately enough for 74% seven-way state identification, with within-individual similarity exceeding cross-individual ([[wiki/concepts/connectome-state-transformation.md]]). So `B^k` — here fitted per subject, per session — behaves as a **population-level** object acting on an individual-level `A`. That is the empirical warrant for the factorisation below, and it costs the price this page charges: those are descriptive graphs, so the operator maps between symmetric, unsigned matrices with no within-node term.

**(brainstorm)** The wiki already contains an architecture built on exactly this premise from the other direction: [[wiki/entities/context-modular-memory-network.md]] applies a discrete context mask to a fixed weight matrix, producing **one effective connectivity and one energy landscape per context**. Li & Yap's claim is the empirical statement that biological connectomes behave this way; the masked Hopfield network is the cheapest known implementation of it. Together they suggest the right storage format for a discovered graph is *(one substrate graph, plus a per-state modulation)* rather than a graph per state — the `A` + `B^k u` factorisation, with `A` learnable slowly and `B` fast, which is the slow-`W`/fast-`M` split of [[wiki/concepts/latent-graph-discovery.md]] written on the edges instead of on the weights.

---

## Model complexity is a selected quantity, not a design choice

Only the Bayesian branch has an answer, and it is a sharp one:

- Inversion optimises the trade-off between **accuracy** (fit) and **complexity** (divergence of parameters from their priors); the trade is the **log model evidence** `log p(y|m)`.
- Bayesian model selection then compares whole *architectures* — different connectivity graphs, different modulations — at subject or group level (Parametric Empirical Bayes for the group).
- The rule of thumb the review endorses: a model must have parameters relating to the quantities of interest (interpretability) **while not being more complex than the data can accommodate**.
- Point-estimate optimisers (the BNM/DNM branch: EM, gradient descent, genetic algorithms) give no posterior and therefore **no automatic pruning of connections** — the graph's sparsity has to be imposed by hand (MNMI removes weak structural edges before fitting to avoid over-parameterisation).

This is the wiki's cleanest instance of *structure learning done by evidence rather than by regularisation*: candidate graphs are enumerated and scored, and the score already contains the complexity penalty rather than having one added to it.

---

## What the recovered edges bought, empirically

| Result | What only a directed/signed/intra-regional graph could say |
|---|---|
| Perceptual learning strengthens **feedforward** effective connectivity V3A→ventral premotor and intraparietal sulcus→frontal eye field (Jia et al. 2018) | Learning changed a direction, not a coupling magnitude |
| Auditory prediction errors encoded in **feedforward and intrinsic** pathways within superior temporal gyrus (Lumaca et al. 2021) | Intrinsic (within-region) gain is a separate quantity from between-region drive |
| Perceptual categorisation: effective drive from category-selective → stimulus-selective areas exceeds the reverse, in somatosensory as in visual/auditory (Malone et al. 2019, MOU-EC over 200 regions) | The two-stage hierarchy is a claim about asymmetry and is untestable with correlations |
| Major depressive disorder localised to an **executive–limbic** circuit rather than default-mode/salience: recurrent inhibition *within* amygdala abnormally decreased; superior parietal → dorsolateral prefrontal effective connectivity **flips sign**, excitatory in controls to inhibitory in patients (Li et al. 2021, MNMI) | Both diagnostic quantities — a recurrent self-weight and an edge *sign* — are structurally inexpressible in structural or functional connectivity |
| *In silico* stimulation of a fitted whole-brain model forces transitions between sleep and wakefulness (Deco et al. 2019); precuneus identified as the best target for pushing older-adult brain states toward middle-aged ones (Escrichs et al. 2022) | A fitted generative model is a **controller**, not only a description: the search is over stimulation sites and intensities in the model, and the answer is a place |
| Whole-cortex rDCM over 400 parcels shows the default mode network's effective **output** distributed evenly across all six cortical types while its **input** is concentrated on one end of a cytoarchitectural axis (`r = −0.54`, `P < 0.001`; output `r = −0.18`, n.s.) — a balance no other functional network shows (Paquola et al. 2025) | A directional asymmetry *between* the in- and out-degree of the same nodes, graded by the microarchitecture of the partner. Correlation gives one symmetric number per edge and can express neither half — and the result is only reachable because rDCM scales to 400 nodes, i.e. it is bought with the linearity this page prices |
| The brain is *maximally* metastable, hence exhibits critical slowing down at transitions — the review's "dynamical origin of the slowness of thought" | Explicitly stated to be underivable from functional connectivity analysis; it is a property of the fitted dynamics ([[wiki/concepts/metastability.md]]) |

---

## For a builder

- **A recovered edge should be a model parameter, not a statistic.** The direction/sign/self-weight triple is unavailable to any correlational estimator at any resolution, and available *by construction* once the estimate is the inversion of a forward model. Any architecture that discovers structure by thresholding a similarity matrix inherits all four failures of the first table (this includes [[wiki/entities/hag-reservoir.md]] and [[wiki/entities/fcann.md]]).
- **Budget the observation model as a first-class component (G81).** The whole cost/identifiability trade above is a fight with a slow nonlinear emission process; a discovery mechanism that assumes it sees the state is solving an easier problem than the one it will face, and no mechanism in the wiki fits an emission process at all.
- **Sparsity has to come from somewhere.** Either the estimator supplies it (model evidence, automatic pruning) or the prior does (drop weak structural edges before fitting). Nothing in the wiki's graph-discovery pages currently supplies either.
- **State-dependent edges are cheaper than state-indexed graphs.** `A + Σ_k B^k u_k` is the factorisation, and it is one modulation tensor rather than one graph per context.
- **The fitted model is the intervention planner.** Once component 1 is a dynamical system, "where should I perturb to move the system into state `s`?" is a search over the model, and the answer transfers to the real system — which is the strongest argument in this literature for paying the realism cost of component 1.

---

## Open problems

- **How complex should the generative model be?** Answered inside the Bayesian branch by model evidence and unanswered outside it; the review flags complexity selection as the topic most deserving attention, precisely because the physiologically interesting questions (neuromodulation, multiscale effects) require additional parameters the data may not support.
- **No ground truth.** Nothing in this literature validates a recovered directed edge against invasive tracing or invasive recording; the identifiability differences between families are therefore untested against a known answer ([[wiki/empirical-tensions.md]] T245).
- **Multiscale is asserted, not built.** A model linking cellular → circuit → network → system dynamics to behaviour is stated as wanted and does not exist; MNMI is two levels and cannot scale to the whole brain.
- **Multimodal fusion is missing.** fMRI, MEG and EEG are inverted separately; a unified generative model over all three is proposed as the route to better-constrained parameters.
- **Nothing here learns.** Effective connectivity is *fit* per state, per session. There is no plasticity rule that would make the modulation `B` an outcome of experience rather than an estimated parameter — the same gap [[wiki/concepts/mean-field-reduction.md]] logs for the forward direction.
- **Linearity where it matters most.** The only estimators that reach whole-brain scale per subject (rDCM, MOU-EC, and MINDy at fMRI timescale) are linear or near-linear, so the regime the whole-brain modelling literature cares about — proximity to a bifurcation ([[wiki/concepts/metastability.md]]) — is outside the model class of the tools that scale.

---

## Connections

- **[[wiki/concepts/mean-field-reduction.md]]** — the forward half of the same machinery, and the page whose open problem this one answers: that ladder builds population dynamics down from spiking neurons and leaves the long-range coupling `W_het` "supplied by anatomy, never recovered", while every method here is a scheme for recovering exactly those couplings by inverting a rung-4 model against data — with the recovered value now indexed by brain state rather than fixed.
- **[[wiki/concepts/node-definition-problem.md]]** — supplies the vertex set every method on this page takes as given, and states the open problem this page addresses: directionality is out of reach for lag-based estimators because BOLD is slow and the haemodynamic response varies regionally, with resting-state dynamic causal modelling named as the live hope — the answer being that direction is recovered from a *model*, at the price of the model being right.
- **[[wiki/concepts/latent-graph-discovery.md]]** — this is the framing's discovery half done on a real system, with the two ingredients the framing usually omits: a non-identity observation model between the latent graph and the data, and an explicit complexity criterion (log model evidence) deciding how many edges the data can support.
- **[[wiki/concepts/causal-model-building.md]]** — the criterion this page's edges are trying to meet: an effective-connectivity estimate claims to name a step of the generative process rather than a sufficient predictor, and the bilinear Dynamic Causal Model is the concrete equation that page cites as the form a causal architecture should take.
- **[[wiki/concepts/metastability.md]]** — both the payoff and the limit case: fitted whole-brain models place the working point at the edge of a bifurcation and support *in silico* stimulation that forces state transitions (sleep↔wake; precuneus as the ageing-reversal target), yet the estimators that scale to per-subject whole-brain effective connectivity are linear and cannot represent that bifurcation.
- **[[wiki/concepts/dynamic-repertoire.md]]** — the reason a single estimate is not enough: if a functional network is a frequently-visited region of a repertoire rather than an object, then an effective connectome fitted to one window is a snapshot of the modulation `B^k u_k`, which is exactly why the review denies that a mechanistic-connectome atlas can exist.
- **[[wiki/entities/context-modular-memory-network.md]]** — the same state-dependence implemented as an architecture: a discrete context signal masks a fixed weight matrix, producing one effective connectivity and one energy landscape per context, which is the `A + Σ_k B^k u_k` factorisation with a binary `B`.
- **[[wiki/entities/fcann.md]]** — the wiki's whole-brain model built the descriptive way: its couplings are the negative inverse covariance of regional time series, hence symmetric and unsigned-by-construction, so the direction, sign and recurrent-self-weight quantities that carried the clinical signal here are unavailable to it.
- **[[wiki/entities/ltc.md]]** — the architecture whose state equation is a diagonal nonlinear relative of the bilinear model on this page; the resemblance is the wiki's standing bridge between a trainable continuous-time layer and an estimator of directed causal coupling, and this page is what the neuroimaging side actually does with that equation.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the population identities the most recent Dynamic Causal Models index: four coupled populations per region with inter- and intra-laminar connections, each with two hidden states, which is what raised fMRI model inversion from an abstract bilinear graph to a laminar circuit.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the quantity only a signed graph exposes: excitation/inhibition balance, including *within-region* recurrent inhibition, which is where the depression result localised the defect (decreased recurrent inhibition in amygdala) and which no correlational connectome can carry.
- **[[wiki/concepts/objective-identifiability.md]]** — the trade this literature runs explicitly: the number of recoverable parameters is set by the model class, not by the data, so linearising and fixing the haemodynamic response buys 40,000 identifiable connections while a realistic nonlinear whole-brain model leaves one global gain identifiable at group level.
- **[[wiki/concepts/simulation-based-planning.md]]** — the use the fitted model is put to: searching over stimulation sites and intensities *inside* the model to find a perturbation that moves the real system between states, which is planning over a learned world model with the plan executed on the system it was fitted to.
- **[[wiki/empirical-tensions.md]]** — T245 is this page's central disagreement in one row: one global gain at group level versus >40,000 per-subject connections, from the same kind of data, decided entirely by what the model class is allowed to assume.
- **[[wiki/entities/virtual-brain-twin.md]]** — a fourth position in this page's identifiability trade, and one neither pole predicts: a *nonlinear* whole-brain model with only a global coupling and per-region excitability freed, inverted per subject in **seconds** by amortised simulation-based inference — so scale is bought by shrinking the parameter set rather than by linearising the model, which is the one route T245 does not consider (Hashemi et al. 2025).
- **[[wiki/concepts/structured-flows-on-manifolds.md]]** — the dynamical justification for choosing which parameters to free: degeneracy is the geometrical counterpart of non-identifiability, so the directions enslaved by the order parameters are exactly the couplings a posterior cannot constrain, readable off the manifold before any data arrive.
- **[[wiki/concepts/connectome-state-transformation.md]]** — the qualification on this page's "there is no atlas" claim: the state-specific graphs are individual and must be measured, but the *deformation* taking one state's graph to another's is a single low-rank operator estimable from a population and transferable to unseen individuals, which is the `A + Σ_k B^k u_k` factorisation with `B` shared and `A` private.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the negative result that motivates this page's whole programme: a correlation matrix cannot be thresholded into an adjacency matrix at biological sparsity even when the generating couplings are known, so edges have to be estimated as model parameters with sparsity supplied by evidence rather than by a cutoff.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — the same graph obtained by counting rather than inverting: streamline density gives an undirected, unsigned, state-independent connectome that *does* have an atlas, which is the baseline against which this page's direction, sign and recurrence are the purchase and the model-class contingency is the price.
- **[[wiki/concepts/integration-segregation-balance.md]]** — the cheap end of the same trade: multiplication of temporal derivatives gives a signed weighted coupling at ~10 s resolution with no generative model and no observation model, which buys time resolution and replication across three datasets at the price of being unable to say which way the causation runs.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — an estimator whose recovered quantity is not a weight but a *mixture*: each long-range edge is split into the share landing on the target's excitatory population and the share landing on its inhibitory population, which is what makes the recovered coupling signed, and it reaches `r > 0.97` against individual resting functional connectivity at 379 nodes with ~143,000 fitted parameters that are themselves non-identifiable (Schirner et al. 2023).
- **[[wiki/concepts/cortical-traveling-waves.md]]** — a directionality claim obtained without any model inversion: instrength is a column sum of the structural matrix and the wave flow potential is one Laplacian solve on a phase-gradient field, so a signed direction of flow costs no estimation, no priors and no observation model — at the price of being a property of the anatomy rather than of the current state (Koller et al. 2024).
- **[[wiki/entities/hag-reservoir.md]]** — the construction this page's objection is aimed at, running: an edge set grown by thresholding a symmetric co-fluctuation statistic under a local unsupervised rule, which buys architecture search at no model cost and forfeits direction, sign and self-weight at every resolution — the price of *not* committing to a forward model.
- **[[wiki/entities/salience-network.md]]** — this page's identifiability problem with real stakes: dynamic causal modelling and directed-information analyses on the same systems yield two opposed gradients (salience→default suppression, default→frontoparietal outflow at rest), and no intervention in the source separates them ([[wiki/empirical-tensions.md]] T257).
- **[[wiki/entities/default-mode-network.md]]** — the largest published use of the cheap end of this page's trade: 400-parcel regression dynamic causal modelling turns "is the apex a broadcaster?" into a testable asymmetry between fitted in- and out-couplings — and inherits the price, since the balanced-output claim is a property of a linear model with a fixed haemodynamic response compared against a spin null (Paquola et al. 2025).
- **[[wiki/concepts/perturbation-elicitability.md]]** — the same causal-versus-correlational demand one level down: that a site's activity carries directed influence on another area does not establish that the activity *constitutes* the content it correlates with, and focal stimulation is the instrument that separates the two.
- **[[wiki/entities/mediodorsal-thalamus.md]]** — a spike-level instance of this page's method with both validations run: coupling filters from a multi-neuronal Poisson generalized linear model are checked by matching the *model's* ablation (delete the prefrontal input filters) against the *experiment's* (optogenetically suppress the prefrontal terminals), `p = 0.42` for the difference, and falsified where they should be — no coupling is recovered from cortical fast-spiking cells, which are known not to project to the thalamus (Rikhye et al. 2018).
- **[[wiki/concepts/transthalamic-context-routing.md]]** — a clean counterexample to inferring influence from activity magnitude: LP→PM axons have higher calcium event rates than either cortico-cortical afferent *and* than the target's own somata, yet contribute nothing to its visual responses under both terminal silencing and projection-neuron ablation; the statistic that tracks causal influence is time-locking to the target's events, not rate (Neske & Cardin 2025).
- **[[wiki/concepts/broadcast-hierarchy.md]]** — the asymmetry this instrument is used to establish (selective in, diffuse out), and the case where its linearity bites: regression dynamic causal modelling reaches 400 parcels only by being linear with a fixed haemodynamic response, so the hierarchy it recovers is a directed-influence ordering and not a causal one.
- **[[wiki/concepts/constitutive-vs-enabling.md]]** — the reason this page's interventional standard exists: a correlate must be perturbed before it can be assigned to the content cell rather than to an enabling, modulating, triggering or reporting one, and the cortical ledger is what the distinction buys when it is applied systematically.
