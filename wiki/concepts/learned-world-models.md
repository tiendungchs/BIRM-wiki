# Learned World Models

**A learned world model is a parameterised predictor of environment dynamics — `p(z' | z, a)` over an internal state, with some read-out to observations — held *separately from the task*, so that the same model can be replayed as data, rolled forward as a transition function, or queried as an evaluator.**

This page is about the **model object**: what it is made of, what jobs it is asked to do, and which of its design choices are load-bearing. The *search over* it is [[wiki/concepts/simulation-based-planning.md]]; the *problem* it is an estimate of is [[wiki/concepts/latent-graph-discovery.md]].

> **Provenance.** Long et al. 2025 (`raw/long-2025-embodied-intelligence-world-models.md`), a survey of physical simulators and world models for embodied intelligence covering ~2018–2025, with a 40-row comparison table of robot world models (their Table VI) and a 10-item challenge list. Working definition adopted there, from NVIDIA's world foundation models: *"generative AI models that understand the dynamics of the real world, including physics and spatial properties"*; origin credited to Ha & Schmidhuber 2018.

---

## Simulator vs world model

The survey's organising contrast, and the reason the field moved: both are models of the environment, but one is written and one is fitted.

| | **Physical simulator** (Gazebo, MuJoCo, Isaac) | **Learned world model** |
|---|---|---|
| Where the dynamics come from | Hand-specified equations + hand-built assets | Fitted to observation streams |
| Locus | External to the agent | Internal — the agent's own state |
| Control over conditions | Exact; repeatable to the bit | Conditional at best (text, action, trajectory) |
| Fails by | Model mismatch that no data can fix; assets that do not exist for the scene | Compounding rollout error; hallucination |
| Cost of a new environment | Human modelling effort | Data |

The survey's argument for the transition is narrow and worth keeping: simulators fail on **accuracy** (simplifications diverge from the real system), **complexity** (some systems are not tractable to write down), **data dependency** (calibration still needs data), and **overfitting to the scenario built**. Learned models trade all four for a different failure mode. **(brainstorm)** For this wiki the interesting asymmetry is elsewhere: a simulator is a *third-person* model with no state the agent can be uncertain about, so it cannot supply a belief; a learned latent model is a belief by construction. Anything the wiki wants from partial observability has to come from the second kind.

---

## Three roles, one object

The survey's most transferable contribution: the same learned dynamics model is used in three distinct ways, and the three impose different requirements. Confusing them is why "is this world model good?" has no answer.

| Role | What it is used for | What it must get right | Representative systems |
|---|---|---|---|
| **Neural simulator** | Generate training data, augment rare cases, stand in for a physics engine, *evaluate a policy offline* | Perceptual realism, controllability, multi-view/temporal consistency | GAIA-1/2, Cosmos, DreamGen, RoboDreamer, DreMa, EnerVerse, WorldEval, RoboTransfer |
| **Dynamics model** | Roll forward in latent space for model-based RL and planning | Latent transition accuracy over the planning horizon; nothing about pixels | PlaNet, Dreamer series, TransDreamer, iVideoGPT, TD-MPC, V-JEPA 2 |
| **Reward model** | Score imagined futures — safety, trajectory quality — without a hand-written reward | Ordering of counterfactual futures, not their appearance | Vista, Drive-WM, WoTE, VIPER, Iso-Dream (via controllable/non-controllable split) |

**Why the third role matters here.** The reward-model use is the wiki's gap **G28** attacked from the opposite side. G28 asks for a model that composes with an *arbitrary new reward* at query time; these systems instead let the model *supply* the reward by simulating a maneuver and judging its own output (Vista), or by simulating several distinct maneuvers and comparing (Drive-WM's multi-future "what-if" evaluation). That is re-goaling with the goal left implicit in the model — which buys the flexibility without the factorisation, and therefore cannot be re-goaled *again*. **(brainstorm)** The two are separable and should be built separately: a model that ranks futures has already committed to a preference, and the wiki's re-goaling test would score it as entangled.

**Circularity warning.** WorldEval and EnerVerse-AC use a world model to *rank policies* (Policy2Vec conditions generation on a latent action, ranks the resulting videos). This is the neural-simulator role standing in for a real robot. It scores policies against the model, not the model against the world — so it cannot close the evaluation problem below.

---

## The transition mechanism: three design points

The survey's Fig. 24 states the trichotomy that every latent-dynamics architecture in this wave sits on. The failure modes are the useful part.

| Transition | Form | Failure |
|---|---|---|
| **Deterministic** (RNN/GRU/LSTM) | `z' = f(z, a)` | Cannot represent multi-modal futures; and because the rollout is a differentiable deterministic map, **the planner exploits it** — the optimiser finds action sequences whose imagined return comes from model error |
| **Stochastic** (state-space model) | `z' ~ p(· | z, a)` | Long-term memory is not retained: information has to survive repeated sampling |
| **Hybrid** (RSSM) | deterministic carrier `h' = f(h,z,a)` **plus** stochastic `z' ~ p(·|h')` | The compromise: multi-modal futures on the stochastic channel, temporal coherence on the deterministic one |

**Planner exploitation is the entry that matters.** It is [[wiki/concepts/shortcut-learning.md]] pointed inward: the search procedure is an adversary against its own model, and the defence is not a better model but *stochasticity in the transition* — noise makes exploitable ridges disappear under expectation. Every wiki architecture that plans by gradient descent on a deterministic learned map inherits this and none of them says so.

**Convergence, and what it costs.** Of ~38 dynamics-model entries in the survey's Table VI, roughly half are RSSM variants; exactly one is a joint-embedding predictive architecture (V-JEPA 2). The field converged on one transition family before the alternatives were compared, which is worth remembering when the rest of this wave reports JEPA results — the baseline is a single lineage, not a field.

**Observability skew.** In the same table, image input is near-universal, proprioception appears in roughly a third of entries, **tactile input in two**, and explicit 3D geometry in a handful. The "world" in these world models is overwhelmingly what a camera sees. Contact — the one channel that would settle most physical questions the models get wrong — is essentially absent.

---

## The decoder question

Whether the latent state must reconstruct observations. This is [[wiki/empirical-tensions.md]] T18 with an empirical failure mode attached.

| System | Move | Result |
|---|---|---|
| PlaNet / Dreamer / DreamerV2–V3 | Variational autoencoder + RSSM, trained on the reconstruction ELBO | The default; works, and is decoder-bound |
| **Dreaming** | Delete the decoder; likelihood-free InfoMax contrastive objective | Motivated explicitly by **object vanishing** — a small task-relevant object contributes almost nothing to a pixel loss dominated by background, so it is dropped from the latent |
| DreamingV2 | Reconstruction-free + DreamerV2's *discrete* categorical latent | Best of both on 3D robot-arm tasks |
| DreamerPro | Keep the model, swap reconstruction for prototypical representations | Beats contrastive methods under visual distraction |
| V-JEPA 2 | Predict in embedding space by construction | The wave's other branch |

**The transferable claim:** a pixel reconstruction loss is a *weighting* over what the latent must keep, and that weighting is set by pixel area rather than by task relevance. This is the concrete mechanism behind LeCun's abstract argument on [[wiki/concepts/causal-model-building.md]] — not "generative models cannot discard detail" in principle, but "the loss makes small things cheap to lose."

**The counterweight — the loss is multi-task and its balance is not free.** HarmonyDream reports that world-model training is a competition between the observation-modelling loss and the reward-modelling loss, that one dominates by default, and that dynamically rebalancing them yields 10–69% gains on visual robot tasks and a new Atari-100k record. So the decoder question is not binary: the decoder's *weight* is a first-class hyperparameter that decides what the model represents, which is [[wiki/concepts/objective-identifiability.md]]'s problem instantiated inside a single architecture.

---

## Factorisations that have been tried

Each is a partial answer to a wiki gap, reported without the wiki's framing.

| Split | System | What it buys | Wiki gap |
|---|---|---|---|
| **Controllable vs non-controllable dynamics** | Iso-Dream | Isolate ego-effects from environment-driven change; long-horizon planning improves because only the controllable branch needs the action | G1 — a factorisation with an operational definition (does the action move it?) rather than a timescale |
| **Language-compositional generation** | RoboDreamer | Factorise video generation into primitives keyed to language structure; generalises to **unseen object–action combinations** and multimodal goals | G21/G22 — composition selected by an external vocabulary (language), which is the undergenerating horn |
| **Geometry + physics, explicitly** | DreMa, PIN-WM | Gaussian-splatting reconstruction plus a physics engine; **equivariant transformations** of the reconstructed scene generate new training episodes, giving one-shot imitation on a Franka arm | G45 — the latent structure (rigid-body equivariance) is *told* to the model rather than discovered |
| **Waypoints vs actions** | PIVOT-R | Predict primitive waypoints in one module, execute asynchronously in another; 28× efficiency at ~equal performance | G33 — subgoals as an explicit intermediate, though the waypoint vocabulary is given |
| **Affordance space** | SWIM | Learn the action space from *human* video, fine-tune with <30 min of robot data | Passive agency ([[wiki/concepts/causal-model-building.md]]) with a number on it |
| **Object-centric latents** | FOCUS | Scene as structured object interactions; enables object-centric exploration under sparse reward | G21 |

---

## Open problems

Distilled from the survey's challenge list, keeping the items that name a missing mechanism rather than a difficulty.

- **Prediction fidelity is not planning utility.** Mean-squared error on future observations "may not correlate with the performance of downstream tasks"; a model generating visually sharper predictions "might not necessarily enable a safer or more efficient control policy." No metric exists that scores a world model by what a planner can do with it (gap **G62**, tension **T144**).
- **Correlation, not causation.** These models learn that brake lights precede deceleration without representing why, so counterfactual queries off the training distribution fail. This is [[wiki/concepts/causal-model-building.md]]'s richness criterion failing on the one query type a world model exists to answer.
- **No fusion of the physical and the semantic level.** A model that predicts pixels or occupancy has no representation of traffic law, intent, or affordance; the survey names the *fusion* of fine-grained physical prediction with abstract concepts as the major open problem, and offers no mechanism.
- **Memory over the horizon that matters.** Retaining a "Road Work Ahead" sign seen minutes earlier is not what any of these architectures is built for; the survey lists transformers and state-space models as the contested candidates and nothing else.
- **Compositional generalisation.** Learning "cup" and "table" should give "a cup on a table" free; current models need the composition in the training set. Stated as requiring **disentangled representations of entities, relations and physical properties** — i.e. the wiki's meta-graph, arrived at from robotics.
- **Verifiability.** Formally proving a learned world model never hallucinates a hazard is named as an open theoretical problem. **(brainstorm)** This is the strongest practical argument in the wave for a *discrete* bottleneck: a model whose transitions are rules over a finite symbol set admits verification of the kind a continuous latent never will ([[wiki/concepts/affordance-grounded-symbols.md]]).

---

## Connections

- **[[wiki/concepts/simulation-based-planning.md]]** — the use half: this page is the object a rollout runs on, and the transition trichotomy above explains one of that page's failure modes (a deterministic learned map is exploitable by the planner searching it).
- **[[wiki/concepts/latent-graph-discovery.md]]** — a learned world model *is* a graph estimate in continuous form: `p(z'|z,a)` is a weighted adjacency over an inferred state space, and every design choice here is a choice about how that graph is parameterised.
- **[[wiki/concepts/causal-model-building.md]]** — supplies the criterion these models fail: their steps track correlation rather than the generative process, so counterfactual queries break — and the object-vanishing result gives the pixel-loss mechanism behind the anti-generative position of T18.
- **[[wiki/concepts/objective-identifiability.md]]** — the decoder weight is the case in miniature: HarmonyDream shows the same architecture represents different things depending on which loss term dominates, so a world model's representation is not attributable to its architecture.
- **[[wiki/concepts/compositionality.md]]** — RoboDreamer factorises generation along language primitives and generalises to unseen object–action pairs, which is compositionality bought from an external vocabulary rather than discovered.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the limit case of that page's proposal: prediction loss is a measurable stand-in for structure found, but the survey reports it does not order models by planning utility, so the stand-in fails exactly where control is the query.
- **[[wiki/concepts/shortcut-learning.md]]** — planner exploitation is shortcut learning with the roles reversed: the *search* finds the model's spurious structure and acts on it, so model error becomes a reward channel.
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the discrete alternative to everything on this page, and the only route the wiki has to the verifiability problem above.
- **[[wiki/entities/h-jepa.md]]** — the architectural counter-proposal: predict in representation space so unpredictable detail can be discarded, rather than reconstructing and reweighting the loss; the survey's Table VI shows exactly one such entry against ~19 RSSM variants.
