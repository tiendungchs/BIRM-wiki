# Cross-Paradigm Interface

**A module placed *between* two networks that speak different representational languages — synchronous real values on one side, asynchronous spikes on the other — which holds its own parameters, can be trained by its own objective, and carries either content or control.**

> Zhao, Yang, Zheng, Wu, Liu, Wu, Li, Chen, Song, Zhu, Zhang, Huang, Xu, Sheng, Yin, Pei, Li, Zhang, Zhao & Shi 2022, *A framework for the general design and computation of hybrid neural networks* (`raw/zhao-2022-hybrid-neural-networks-framework.md`, Nature Communications 13:3427). Every number on this page is from it. Code: `github.com/IbrahimYang/Hybrid-neural-networks`.

The wiki has treated the rate/spike boundary twice before, and both times as a *conversion*: copy trained weights into spiking units and read activations as firing rates ([[wiki/entities/spiking-neural-networks.md]]), or choose a scheme that turns a scalar into a spike train ([[wiki/concepts/spike-encoding-schemes.md]]). Both are one-directional, fixed, and parameterless. This page holds the third option — make the boundary itself a **trainable module** — and it is the reason the source is worth an ingest even though its component networks are all standard: the interface is the only thing in it that is new, and it is the object [[wiki/architectural-gaps.md]] G52 has been asking for.

**Terms.** HNN (Hybrid Neural Network) — a network containing both ANN and SNN subnetworks. HU (Hybrid Unit) — the interface module. HSN / HMN / HRN — the paper's hybrid **sensing** / **modulation** / **reasoning** networks. Also in [[wiki/glossary.md]].

---

## The formalism

The whole framework is one composition of four stages, each solving one named incompatibility:

`Y = HU[X] = Q · F · H · W (X)`

| Stage | Operation | The incompatibility it removes |
|---|---|---|
| **W** — windowing | Truncate `X` by a parametric window `W(t, k, T_s)`, giving `X · W(t − kT_s)` | `a[k]` (a discrete-index activation vector) and `s(t)` (a continuous-time spike train) have **no intrinsic temporal relation**. `T_s` is where the two clocks are reconciled |
| **H** — kernel | Convolve into an intermediate representation `h(t,k) = [X · W(t − kT_s)] * H(t)` | `h(t,k)` is deliberately in a format **compatible with both** `a[k]` and `s(t)` — the interface has an internal currency, and neither endpoint's is privileged |
| **F** — nonlinearity | Arbitrary nonlinear map on `h(t,k)` | `H` and `F` together are what give the HU **universal approximation**, so the interface is not restricted to the conversions someone thought of |
| **Q** — discretisation | Threshold in amplitude → binary spike trains; integrate in time → a discrete-time real sequence | Target-domain representation. **`Q` is omitted for modulation**, because a parameter being set need not be discrete in time or in value |

`W, H, F, Q` are all parameterisable. Setting them all by hand recovers the fixed converters the wiki already had; the framework's content is that they need not be.

---

## Two kinds of hybrid flow

The split that does the most work here, and the wiki did not have it stated:

| | **Hybrid transmission** | **Hybrid modulation** |
|---|---|---|
| Target | Neuron **state** | Neuron or synapse **parameters** — thresholds, weights |
| Path | Synaptic, direct | Indirect: changes how the receiving network computes, not what it currently holds |
| Timescale | The signal's own | Free — typically slower and coarser |
| Needs `Q`? | Yes | No |
| Biological analogue offered | Feedforward cortical projection | The dense **neuropeptide** network — minute-scale, diffusive, fine-grained modulation of fast synaptic transmission |
| Instantiated by | HSN, HRN | HMN |

**(brainstorm)** This is the same distinction [[wiki/architectural-gaps.md]] G54 draws between a content channel and a coordination channel, arrived at from the engineering side and with a different second term: G54's non-content channel carries **timing**, this one carries **parameters**. An architecture wanting both would need three channel types on each edge, and no model in the wiki has two.

---

## Where the interface's parameters come from

| Case | When | Method |
|---|---|---|
| **Designable** | The relation between the two representations is deterministic, simple **and known** | Configure `W, H, F, Q` from domain knowledge. Used in HRN for static attributes ("this object is red"), where the front end's object-oriented output maps onto predefined back-end symbols |
| **Learnable — non-deterministic** | The front end does not contain enough information to satisfy the back end | Empirical fit, e.g. naïve Bayes for a probabilistic mapping. Used in HRN for events ("these two objects collided"), where the *time* of the event is uncertain |
| **Learnable — complex** | Relation deterministic, transformation too intricate to program | Fit it |
| **Learnable — unknown** | Relation deterministic and simple, but no prior knowledge exists | Identify the principle from data (the paper's example: recovering Kepler's laws) |

Three placements for the learning, and the third is the one nothing else in the wiki has:

1. **Installed in the front-end or back-end network** and trained jointly with it (HSN, HMN).
2. **Modelled separately, under its own independent optimisation goal** — the interface has an objective the modules do not share (HRN's collision detector: a 1-D UNet with two MLP heads, trained on CLEVRER's event labels with `5·CE + MSE`, predicting *whether* and *when*).
3. **Trained with the complete model** end-to-end.

---

## Three instantiations

| | Architecture | Flow | Result |
|---|---|---|---|
| **HSN** (sensing) | ANN "what" pathway extracts static features `SF(t)`; structurally similar SNN "where" pathway predicts the feature *change* `ΔDF(Δt)`; learnable HU adds them: `ŜF(t+Δt) = SF(t) + HU[ΔDF(Δt)]` | Transmission | On Tianjic chips, **0.679 mIoU streaming accuracy** where the same-quality ANN drops from 0.85 offline to **0.33** online; 5952 FPS and 129 µJ/inference against the ANN's 272 µJ (11× speed, 2× energy). SNN alone is faster and cheaper (6613.8 FPS, 106 µJ) and cannot represent a bounding box |
| **HMN** (modulation) | ANN backbone reads the task, HUs at its output emit a per-neuron **threshold** vector for an SNN branch: `ṽ = (1 − V_th,i)·v_T` | Modulation | 40-task permuted N-MNIST continual learning; beats plain SNN, context-dependent gating, EWC and synaptic intelligence, and composes with EWC. See below |
| **HRN** (reasoning) | ANN front ends (Mask R-CNN + PropNet for vision, a sequential generation model for language) feed a **graph-structured integrate-and-fire** back end whose nodes are symbols | Transmission | CLEVRER: **91.65 / 95.27 / 85.96 / 78.81%** on descriptive / explanatory / predictive / counterfactual questions. See below |

### HMN — the continual-learning result

The training objective on the backbone + HUs is a **similarity-matching** loss, not a task loss:

`min_θa ‖S_ta − S_Vth‖² − λ S_ta · S_Vth + µ max(ρ − ‖S_Vth‖₁, 0)`

where `S_Vth` is the cosine similarity between two tasks' modulation vectors and `S_ta` the similarity between the tasks themselves (here `1 − hamming(p_i, p_j)` over permutation indices — the paper states outright that computing `S_ta` in general **is an open problem**). The third term forces sparsity in the modulation signal. So the interface is trained to make *similar tasks produce similar gates*, and nothing else.

| Evidence | Reading |
|---|---|
| t-SNE of modulation vectors clusters by task group | The gate tracks task similarity, as designed |
| Mean activation correlation across tasks: pure SNN is **highly correlated across uncorrelated task groups**; the HMN branch reuses neurons within a group and switches to others across groups | The proposed mechanism of forgetting, measured: one parameter set serving uncorrelated tasks. The gate buys reuse **and** non-interference at once — not a bag of disjoint subnets |
| Superior accuracy on **unlearned** tasks similar to learned ones; the backbone never saw half the tasks in the final 10 groups | The gate generalises over the task space, which a per-task index mask cannot do |
| Accuracy of single models saturates with task count; the HMN's **keeps improving** | Bears directly on [[wiki/concepts/continual-learning.md]]'s capacity open problem |
| ANN-only and SNN-only ablations with the same modulation architecture are both worse | The paper's own case that heterogeneity, not modulation alone, is load-bearing — though the mechanism for *why* is not given |

### HRN — reasoning on a spiking substrate

Two node types and a memory made of edges:

- **Representative neurons** — symbols at several levels of abstraction (`red`, `cube`, `shape`, `collision`, `object A`).
- **Functional neurons** — operators over symbols (`inhibition`, `excitation`, `copy`, `filter`, `order`).
- **Edges = working memory**, in three stages: (i) *initialise* from long-term memory, giving the abstract semantic skeleton ("red is a kind of colour"); (ii) *store* perception by **Hebbian binding** — detect that object A is red, connect node `A` to node `red` with a positive weight; (iii) *execute* on external instruction. A synchronised stimulus on `object-inhibition` and `red` deactivates every `object` node lacking the red property — that is `filter by colour`, run as spike propagation.

Two measured properties, and only one of them is what the paper claims:

| Property | Measurement | Honest reading |
|---|---|---|
| **Parallelism** | Latency nearly unchanged as the number of objects and events grows | Real, and it is a property of *propagation over a graph*, not of spike timing — the same would hold for any parallel relaxation. **(brainstorm)** Not evidence for T1 |
| **Robustness to a bad interface** | Relaxing the collision-detection threshold injects false events. NS-DR returns **empty outputs**, NS-DR-Guess returns **random guesses**, the HRN degrades gracefully | This one *is* structural: the prior knowledge in the graph shrinks the answer space, so a corrupted symbol lands somewhere constrained instead of crashing a program. A program-synthesis reasoner has no analogue ([[wiki/concepts/program-induction.md]]) |

**What the spiking half actually learned: nothing.** The graph is hand-designed, the instruction set is manually specified ("and thus fully understandable"), the bindings are written by a Hebb rule, and all gradient learning lives in the ANN front ends and the collision HU. This is the strongest reasoning result in the wiki on a spiking substrate and it is a *fourth* entry in the pattern [[wiki/empirical-tensions.md]] T231 names — accuracy past MNIST on a spiking network in which no weight was learned in spikes. Here the reason is not conversion; it is that the network was **authored**.

---

## What this changes for the target

- **An interface with its own objective is a third thing.** The wiki's inter-module links are either fixed wiring or one weight matrix trained by the global loss. Placement (2) above — the interface fitted against its own labels while both endpoints are trained on theirs — is the cheapest realisation of [[wiki/architectural-gaps.md]] G52 anyone has built, and it comes with the ingredient G52 asks for and G21 needs: a **composition point that is a trained object**.
- **A gate whose addressing rule is task similarity.** G56 wants a run-time gain register and a rule for *where to set it*; its two candidate set-points so far are normative (precision-weighted free energy; inverse temperature). The HMN supplies an implemented third: **train a separate network to emit the register's value, supervised on similarity between contexts rather than on the task**. It is not a gain (it is a threshold, so it gates reachability rather than scaling drive) but it occupies the same architectural slot and it runs.
- **The `Q` stage is the encoding choice, made learnable.** Every scheme in [[wiki/concepts/spike-encoding-schemes.md]] is a fixed choice of `Q` with `H` and `F` set to identity. Stating encoding as one factor of a trainable composition is what that page's "no selection procedure" open problem needs — though nobody here learns `Q` itself.
- **Symbols get a substrate that degrades.** [[wiki/architectural-gaps.md]] G11 wants a mechanism for structure that admits no metric embedding. The HRN's answer is a literal graph in integrate-and-fire neurons whose prior structure absorbs front-end errors — a non-embedded symbolic slice with a *graceful* failure mode, which is the property the neuro-symbolic alternatives on CLEVRER measurably lack.

---

## Open problems

- **The task-similarity function is unspecified** — *partly answered by the same lab three years later* ([[wiki/entities/ch-hnn.md]], Shi et al. 2025). `S_ta` is the input the whole HMN mechanism runs on, and it is computed here from permutation indices the modeller has. In a real stream, "how similar are these two tasks?" is [[wiki/concepts/contextual-inference.md]]'s question. CH-HNN's answer: compute it as cosine similarity between PCA-reduced *statistics of the input features* (raw pixels for MNIST, CLIP feature maps for CIFAR-100 / Tiny-ImageNet), which makes the gate a per-sample perceptual operation needing no task ID at train or test. The residual: where episodes have no natural correlation — task-incremental sMNIST and sCIFAR-100 — the similarity matrix is still hand-set to 1-within-task / 0-between, so the oracle is removed at inference and not at training.
- **The three demonstrations use *homogeneous* subnetworks.** The paper says so itself: heterogeneous dynamics and connectivity are not exploited, so the HNN's advantage over a single-paradigm model is being credited to a boundary that separates two conventional networks.
- **Nothing selects the flow type.** Given two modules, no criterion says whether they should be coupled by transmission or by modulation. The three cases were assigned by hand.
- **`Q`'s inverse is not addressed.** Spike → real is an integration; real → spike is a coding decision with a large literature and no selection rule. The framework makes both a parameter and inherits both problems.
- **No result isolates the interface.** Every comparison is HNN against single-paradigm; none is learnable-HU against a fixed converter at matched everything else, so the value of *learnability* — the framework's central claim — is argued, not measured ([[wiki/empirical-tensions.md]] T235). Cheapest test: freeze `H` and `F` to the identity conversion in the HSN or HMN and change nothing else.

---

## Connections

- **[[wiki/entities/spiking-neural-networks.md]]** — the alternative to that page's conversion route: instead of turning a rate network into a spiking one, keep both and make the boundary a trained module, which is how the HSN gets the SNN's event-driven streaming throughput and the ANN's bounding-box precision in one system (0.679 vs 0.33 mIoU under real latency).
- **[[wiki/concepts/spike-encoding-schemes.md]]** — that page's taxonomy is the `Q` stage of this page's composition with `H` and `F` set to identity; making the whole cascade parameterised is what turns "which code?" from a designer's choice into a fitted one, and the same move exposes the untouched half — how a *decision* leaves a spiking module.
- **[[wiki/concepts/continual-learning.md]]** — supplies a solution family this page's modulation flow instantiates and that page did not have in this form: an ANN trained on **inter-task similarity** emits a per-neuron threshold vector for an SNN, giving reuse within a task group and non-interference across groups, beating context-dependent gating, EWC and synaptic intelligence on 40 permuted N-MNIST tasks and composing with EWC.
- **[[wiki/concepts/spike-frequency-adaptation.md]]** — the same state variable used the opposite way: there the threshold is set by the neuron's own firing and *is* the memory (T233), here it is set by another network and is a **control port** — so one variable serves as store and as gate, and nothing says how a neuron doing both would keep them separate.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the biological version of the modulation flow, with a finer division of labour: four interneuron families each biasing a different feature of the code, against this framework's one scalar per neuron; the HMN shows the coarse version already buys non-interference, which sets a floor for what the four-channel version has to beat.
- **[[wiki/concepts/working-memory.md]]** — the HRN is a working memory whose contents live in **edges**, not in activity: prior knowledge initialises the graph, Hebbian binding writes perception into it, and external instruction executes reads — the paper's own analogy to prefrontal working memory coordinating symbolic operations with sensory grounding from other cortical areas.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the execution half done on a spiking substrate: a graph of symbol nodes whose edges are written by Hebbian binding from perception and traversed by spike propagation, with flat latency in the number of objects — and the discovery half entirely absent, since the graph's schema is authored.
- **[[wiki/concepts/program-induction.md]]** — the contrast the HRN's robustness experiment is built to make: a program-based reasoner fed a corrupted symbol returns an empty output or a random guess, while a graph whose prior structure shrinks the answer space returns a constrained wrong answer — degradation as an architectural property rather than an error-handling one.
- **[[wiki/entities/mediodorsal-thalamus.md]]** — the biological twin of the gating network with the open problem closed: the same shape (a separate low-dimensional module emitting a per-neuron gate on a learner) but the gate variable is pooled from the gated population's own activity, so no task-similarity function has to be supplied — and the gate is two-signed, sustaining the in-context units while suppressing the out-of-context ones (Rikhye et al. 2018).
- **[[wiki/entities/ch-hnn.md]]** — the same lab's next system, and the closest thing to a fix for this page's headline open problem: `S_ta` is no longer read off permutation indices but computed as cosine similarity between PCA-reduced statistics of the *input* (CLIP feature maps for CIFAR-100/Tiny-ImageNet), so the modulation flow becomes a per-sample router with no task oracle at inference — extended from task-incremental to class-incremental, and with a measured dependency the HMN did not report (the metaplasticity co-mechanism is worth 0.02 points when the gate is accurate and 4.3 points when its priors are off-distribution).
