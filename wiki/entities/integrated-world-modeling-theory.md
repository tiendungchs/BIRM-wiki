# Integrated World Modeling Theory — Integration and Broadcast as Necessary but Not Sufficient

**A synthesis framework that accepts the global workspace's routing discipline and integrated information theory's irreducibility measure, and then adds a *necessity condition* neither of them has: a complex is a world model only if its integrated content is coherent with respect to **space** (relative locality), **time** (change within that space) and **cause** (regularity over those changes), for a system that is also modelling *itself* as the locus of sensing and acting. High Φ, a shared bus and a converged posterior are all obtainable without that grounding — the paper's counterexample is an expander graph, which has small-world topology, sparsity and error-correcting capacity and models nothing. The mechanism proposed to deliver all of it at once is a **self-organizing harmonic mode**: a transient synchronous complex over the connectivity backbone that is simultaneously an ignition event, a workspace, a Φ-complex, and one round of loopy belief propagation across coupled autoencoder bottlenecks.**

> **Provenance.** Safron 2022, *Integrated world modeling theory expanded: implications for the future of consciousness*, Front. Comput. Neurosci. 16:642397, doi:10.3389/fncom.2022.642397 (`raw/safron-2022-integrated-world-modeling-theory.md`). **Single-author theory paper; no new data, no implementation, no simulation.** Every claim below is an architectural proposal or a mapping between existing formalisms. The author marks several sections as "(very) highly speculative" himself — the quantum-analogy section and the time-crystal reading of synchrony are excluded from this page as carrying no design content. Read the mappings as hypotheses with a stated falsifier (below), not as results.

---

## The added condition, stated as a specification

| Requirement | What must hold in the representation | What fails it |
|---|---|---|
| **Space** | Entities are situated at relative locations — a body-centric frame plus at least one introspectable 2-D map with irregular, salience-biased spacing | A bag-of-features code; any latent with no metric over entity positions |
| **Time** | Change is defined *within* that space; velocity is what ties the two, so time and space are mutually defined rather than separately encoded | A model with a frame index but no displacement variable |
| **Cause** | Regularity over those changes, including the ability to run **simulated interventions** — the paper explicitly nominates Pearl's `do`-operator, implemented as action simulation rather than as a graph surgery | Correlational sequence prediction; a model that cannot be queried off-policy |
| **Self / agency** | A partition learned from the fact that bodily states are *uniquely perceivable and uniquely controllable* — sensors and effectors are on the body and not elsewhere, so the self/world boundary is derivable from a controllability asymmetry, not installed | Any disembodied predictor; a model with no action channel |

**Why the last row is the load-bearing one for a builder.** It is a *derivation* of the self/other split from a measurable statistic — mutual information between a variable and the agent's own efferent copy — rather than an installed prior. That makes it runnable: partition the observation stream by controllability and the boundary falls out. The wiki has no architecture that computes this partition, and it is a prerequisite for the counterfactual machinery the causal row asks for ([[wiki/concepts/counterfactual-probing.md]], [[wiki/concepts/causal-model-building.md]]).

**The expander-graph argument, which is the sharpest form of the claim.** A 2-D expander graph has high Φ under standard estimators, small-world connectivity, sparse coding and the capacity to support error-correcting codes — i.e. most of the properties the wiki attributes computational power to ([[wiki/concepts/small-world-topology.md]], [[wiki/concepts/sparse-distributed-representations.md]]). Hierarchically stacked, the paper concedes it could implement predictive processing and be functionally equivalent to the turbo-coding scheme below. It still models nothing, because nothing in it is *about* anything. **The transferable statement: measures of integration are measures of a network's dynamics, and no dynamical measure by itself distinguishes a model from a resonator.** Any wiki claim of the form "architecture X integrates information, therefore X represents the environment" inherits this hole.

---

## The architectural mapping

| Biological object | Machine-learning object claimed | What the mapping buys |
|---|---|---|
| Cortical hierarchy | A **disentangled variational autoencoder folded at the bottleneck**, so encoder level `k` aligns with decoder level `k`; superficial pyramidal cells carry the encoder, deep pyramidal cells the decoder | Predictive coding becomes a *folding operation* on a standard architecture rather than a separate model class: descending decoder messages explain away ascending encoder messages, and only unsuppressed residuals climb |
| Association cortex ("rich club") | **Chained bottlenecks** — the low-dimensional latents of several folded autoencoders wired to each other, forming one auto-associative graph *with cycles* | A shared latent space across modalities, with no fusion module and no joint training objective. The cycles are the point: see [[wiki/concepts/loopy-belief-propagation.md]] |
| Precuneus / posterior-medial 2-D maps | A **graph neural network** over a grid-like representational geometry | Locality of message passing over an installed grid, at a latency proportional to closure of the action–perception cycle. Declared *not* a falsification condition by the author — an admission that this row is decoration unless someone measures it |
| Synchronous complex (SOHM) | One round of message passing that has **converged**, yielding a joint posterior and a MAP estimate | Identifies "the current broadcast content" with "the argmax of an approximate joint posterior over the coupled latents" — a computational definition of workspace occupancy that [[wiki/entities/global-neuronal-workspace.md]] does not supply |
| Diffuse neuromodulators | Precision / Kalman gain on the inference, plus policy sculpting | [[wiki/concepts/precision-weighting.md]], [[wiki/concepts/neuromodulatory-metaparameters.md]] |
| Experience-dependent plasticity | **Implicit neural architecture search** — plasticity selects the graph over which message passing will run | Reframes structural learning as choosing an inference graph rather than fitting a function |

**The metabolic argument for the bus.** The rich club consumes up to ~50% of cortical metabolism. The paper's justification is not representational but *latency*: high-bandwidth reciprocal wiring reduces the number of noisy transactions needed to reach a reliable estimate, so the cost buys **fewer rounds to convergence and a shorter time to action selection**. That is a different justification for a hub than [[wiki/concepts/connectome-hubs-and-cores.md]]'s routing-bottleneck argument, and it is quantitative in principle: rounds-to-convergence against wiring cost is measurable in any message-passing network.

---

## Frequency bands as message types

The paper assigns each band a role in the message-passing scheme. This is the most directly testable part of the framework and the part a builder can copy as a *scheduling* discipline.

| Band | Ensemble size | Message claimed |
|---|---|---|
| **Gamma** | Small, fast | Prediction errors ascending the hierarchy as **quantised packets of sufficient statistics** — marginal messages, not raw activity |
| **Beta** | Large | Specific descending predictions |
| **Alpha** | Large | Descending predictions **integrated within an egocentric reference frame** — the band at which content becomes an experienced *world* rather than a set of features |
| **Theta** | Large, slowest | Predictions **conditioned on an action**, including mental acts (attentional fixation); supplied by the hippocampal/entorhinal loop with frontal cortex |

**The entrainment flip.** Before ignition, peripheral sensory hierarchies asymmetrically entrain the core, seeding it with gamma-carried errors — competing coalitions are hypotheses about latent causes. After ignition, the direction reverses and the core drives the periphery. So Bayesian model selection is implemented as *differential seeding of core states followed by a reversal of drive direction*, which is a concrete, measurable signature and a scheduling rule: **errors up, then a commit, then estimates down**, with the switch dated by the synchronisation event rather than by a clock ([[wiki/concepts/inter-areal-synchrony.md]], [[wiki/concepts/ignition.md]]).

**The hedge that matters.** The paper explicitly states the scheme does not depend on predictive coding being correct: descending slow-band input may *gate* ascending errors (raising or lowering their contribution) rather than explain them away, which is a precision-weighting account and is compatible with the gamma-power-tracks-consciousness findings that strict explaining-away struggles with. Either way the framework's own commitment is that **gamma does not generate the content — it modulates belief updating at slower frequencies.**

---

## Φ as a cycle variable, not a constant

The framework's one genuinely novel empirical prediction, and the only place it stakes a falsifier:

| Phase of the cognitive cycle | Local modules | Global workspace |
|---|---|---|
| Segregated | High Φ, high local modularity, **multiple competing hypotheses stay in play** | Low |
| Ignited | Local modularity breaks down | High Φ; winner-take-all; MAP estimate broadcast back as modules re-form |

- Φ for modules and Φ for the workspace should vary **inversely** and on the timescale of the cycle, not of the task.
- Therefore the **perturbational complexity index should be higher when workspace dynamics are present** — testable by timing a transcranial magnetic stimulation pulse to coincide with ignition, or by scoring Lempel–Ziv complexity after a P3. **If evoked complexity is not elevated at ignition, the framework is falsified** (the author's own statement).
- Integrated information theory reads the same trade-off differently: when modules are the Φ maxima, *the modules* are conscious and the workspace is not. The disagreement is about which complex counts, not about the dynamics — which makes the two theories closer than their rhetoric, and makes "how global must integration be to count as global?" the actual question.

**This is the resolution the wiki's `T267`/`T269` neighbourhood was missing for a different reason: it turns a categorical dispute into a measurement with a sampling rate.** Any measure of a network's integration that is reported as one number per condition has averaged over the variable the framework says carries the signal.

---

## The Bayesian blur problem, and the design pattern it yields

**Problem.** A probabilistic model's natural output is a distribution. Action selection wants a commitment. How does a system get a discrete percept out of a posterior?

**The paper's answer is to refuse the choice and schedule both:**

| Phase | Representation | What it is good for |
|---|---|---|
| High modularity / segregation | Full distribution — multiple competing and cooperating hypotheses maintained in parallel across modules | Exploration, adaptation, recovery from a wrong commit |
| Integration / ignition | Winner-take-all collapse to a MAP estimate, broadcast back to the re-forming modules as a prior | Coherent action selection; a discrete step boundary |

**(brainstorm) This is the cleanest architectural statement in the source and it is implementable today.** A system alternating between a *segregated* phase where `K` module-local hypotheses are maintained without arbitration and an *integrated* phase where a single joint MAP estimate is committed and written back as each module's prior is a particle filter whose resampling step is scheduled by network topology rather than by effective sample size. It gives an answer to a question the wiki keeps re-asking — *when should a system commit?* — that depends on neither a confidence threshold nor a fixed step count: **commit when the loop converges, and go back to plural representation immediately afterwards.** The cost is that convergence of loopy message passing is not guaranteed, which is exactly why the schedule needs a second timescale to force the issue. See [[wiki/concepts/integration-segregation-balance.md]], which measures the axis this schedule moves along, and [[wiki/concepts/dynamic-repertoire.md]].

---

## Where it puts prefrontal cortex

The framework's answer to the wiki's `T269` is *both, for different explananda* — with an honest admission that it has no definitive prediction:

| Position offered | Content |
|---|---|
| Posterior sufficiency | Posterior "hot zone" (occipital–temporal–parietal, with posterior-medial cortices carrying the quasi-Cartesian spatial frame) is necessary and sufficient for generating a coherent world model — the content |
| Frontal necessity for access | Frontal cortex is required to manipulate, reflect on and report that content, and can shape which complex forms by coupling *before* maximal coherence is reached, thereby setting the spatial and temporal **grain** of the commit |
| The deflationary reading | A complex integrating across occipital, temporal and parietal cortex could reasonably be called "global" already, so part of the dispute is a threshold on the word *global* |
| The developmental alternative | Frontal cortex may be necessary to **bootstrap** a coherent world model and dispensable for running it afterwards — which would make every adult lesion and stimulation study, including the one the wiki logs against the workspace framework, blind to the frontal contribution by construction |

**The developmental alternative is the row worth keeping.** It is the only proposal in the wiki that would reconcile the near-zero prefrontal elicitation rates ([[wiki/concepts/perturbation-elicitability.md]]) with a genuine prefrontal role, and it converts a synchronic dispute into a developmental prediction — a system that never had the frontal stage should fail to acquire the coherent model, while one that acquires it and then loses the stage should retain the content and lose the access. Untested in any species; unlisted as a test by the source.

---

## The unfolding rebuttal — why recurrence is not a compression detail

Against the argument that any recurrent network is functionally equivalent to its unrolled feedforward counterpart, and therefore recurrence cannot be what distinguishes anything:

| Claim | Force |
|---|---|
| Unrolling a human-brain-scale recurrent network over the ~100s of ms of a workspace episode needs supra-astronomical resources | Practical, not principled — but decisive for anyone actually building |
| The equivalence is demonstrated **only** when the unrolled system is returned to its initial conditions and run under identical circumstances | The equivalence is *on-distribution only* |
| Unrolled systems diverge from their recurrent originals **when intervened upon**, and cannot repair themselves when modified | The lost property is robustness and context-sensitivity under perturbation — precisely what a reasoning system needs off-distribution |
| A feedforward network can produce one state estimate but has no **functional closure across moments**: no carrying of the posterior into the next round's prior | The iterative Bayesian-model-selection loop is not expressible without it |

**The transferable version, free of the consciousness framing:** *feedforward equivalence is an equivalence of input–output maps on the training distribution, and every property that matters under intervention lives in the recurrence.* This is a directly usable argument for why [[wiki/concepts/test-time-training.md]] and iterated-refinement architectures are not merely deeper feedforward stacks ([[wiki/concepts/refinement-loop.md]]).

---

## Limitations, as a design document

| Limitation | Detail |
|---|---|
| **Nothing is implemented** | No simulation, no code, no fitted model. The wiki's standard for the workspace framework — "what I cannot create, I cannot understand" — applies here with more force, since this framework's content is *entirely* architectural |
| **The falsifier is weak** | One prediction (perturbational complexity elevated at ignition), on an index the author concedes is explicable without integrated information theory at all |
| **Two central mappings are exempted from falsification by the author** | The graph-neural-network reading of association cortex is explicitly "not a necessary entailment"; the quantum analogies are labelled non-literal. A framework that pre-announces which of its claims do not count is not being tested by them |
| **The coherence conditions have no metric** | "To what degrees must these forms of coherence be present in which ways?" is asked and left open. Without a threshold, the space/time/cause requirement cannot discriminate any two candidate systems |
| **Circular bootstrapping is invoked, not modelled** | Coherent models make message passing converge; convergence is what produces coherent models. The paper offers this positive feedback as an explanation for non-linear developmental and evolutionary transitions. It is also exactly the failure mode of an unregularised self-training loop, and nothing distinguishes the two here |
| **Single author, self-citing** | Large fractions of the argument point to the author's own prior work for the details |

---

## Connections

- **[[wiki/entities/global-neuronal-workspace.md]]** — the framework this one accepts and then constrains: it keeps ignition and broadcast wholesale, supplies the computational definition of workspace occupancy the workspace account lacks (the MAP estimate of a converged loopy posterior), and denies that broadcast is sufficient without spatial/temporal/causal coherence and an embodied controller.
- **[[wiki/concepts/loopy-belief-propagation.md]]** — the reusable primitive extracted from this framework: chained autoencoder bottlenecks form a graph with cycles, message passing on it is a turbo-code, and synchrony is the scheduler that makes it converge.
- **[[wiki/concepts/ignition.md]]** — re-read as a self-organizing harmonic mode: the commit event becomes "the round at which loopy message passing converged", which supplies the ignition account's missing answer to *what is being committed* and predicts the entrainment direction flips at the commit.
- **[[wiki/concepts/integration-segregation-balance.md]]** — the axis this framework's cognitive cycle rides: segregated phases keep plural hypotheses in modules, integrated phases collapse to one broadcast estimate, so a network's position on the participation-coefficient axis is also its position between distribution and point estimate.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — supplies the band-to-message-type assignment (gamma = error packets, beta = specific predictions, alpha = egocentrically framed predictions, theta = action-conditioned predictions) and the claim that gamma modulates rather than constitutes the content.
- **[[wiki/concepts/anatomical-harmonic-modes.md]]** — the same word, a different object: harmonic modes there are a *fixed* spectral basis generated from anatomy before any activity, here they are *transient self-organizing* complexes formed by activity over that anatomy, and the relationship between the two (are SOHMs excitations of the anatomical modes?) is unstated and is the obvious joint test.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the folding construction: a disentangled variational autoencoder folded at its bottleneck so encoder and decoder levels align *is* a predictive-coding hierarchy, which makes predictive coding a wiring pattern over a standard architecture rather than a separate model class.
- **[[wiki/concepts/learned-world-models.md]]** — the necessity condition this page adds to that page's requirement list: prediction accuracy, latent transition fidelity and future ordering are all obtainable by a system with no spatial, temporal or causal coherence and no self/world partition, and the expander-graph counterexample shows integration measures cannot detect the difference.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — a second, quantitative justification for the metabolic cost of a rich club: not routing capacity but **rounds-to-convergence**, since high-bandwidth reciprocal wiring reduces the number of noisy transactions needed before an estimate is reliable enough to act on.
- **[[wiki/concepts/core-knowledge.md]]** — the Kantian version of the same list: space, time and cause as preconditions for an experienceable world rather than as domains learned from it, with the Helmholtzian counter-position that selfhood and agency come *first* and the categories are constructed from them, which is a developmental ordering claim that page's evidence could test.
- **[[wiki/concepts/perturbation-elicitability.md]]** — the framework's escape route from the prefrontal nulls: if frontal cortex is needed to *bootstrap* a coherent world model and not to run it, every adult stimulation study is blind to its contribution by construction.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the alternative to a fusion module: modalities are coupled by *sharing* their bottlenecks and iterating messages between them, so the joint estimate is inferential rather than concatenative — and the rate-limit argument on that page becomes a statement about how many bits survive one round of message passing.
- **[[wiki/concepts/counterfactual-probing.md]]** — the causal coherence requirement made operational: simulated interventions as an implementation of the `do`-operator, which is what the framework demands of a world model and what most predictors cannot supply.
- **[[wiki/concepts/default-self-model.md]]** — the self/world partition derived rather than installed: bodily states are uniquely perceivable *and* uniquely controllable, so the boundary follows from a controllability asymmetry that an agent with an efference copy can measure.
- **[[wiki/concepts/test-time-training.md]]** — the unfolding rebuttal's constructive side: feedforward equivalence holds only on-distribution and only from matched initial conditions, so the properties that survive intervention live in the recurrence, which is the case for iterating at inference time rather than deepening the stack.
- **[[wiki/entities/default-mode-network.md]]** — the framework's account of where decoupled internal dynamics come from: cortical expansion producing association cortex and a more freely operating default mode network is nominated as what made counterfactual simulation possible at all.
