# H-JEPA and the Autonomous Machine Intelligence Architecture

**A fully differentiable modular agent built around a single *configurable* world-model engine, whose predictions happen in representation space rather than input space (JEPA), stacked to predict at several time scales at once (H-JEPA), and used for planning by minimising a learned cost over action sequences.**

> **Provenance.** LeCun 2022, *A Path Towards Autonomous Machine Intelligence*, v0.9.2 (`raw/lecun-2022-autonomous-machine-intelligence.md`). Explicitly a **position paper**: it reports no experiments and claims priority for none of its components. The formalism it runs on is [[wiki/concepts/energy-based-models.md]].

---

## The module table

All modules are differentiable, so the cost's gradient can be back-propagated through the world model into the action variables.

| Module | Function | Trainable? | Claimed brain analogue |
|---|---|---|---|
| **Configurator** | Executive control: modulates the parameters, attention circuits and connection graphs of every other module for the task at hand. In a transformer-based predictor, its output is *extra input tokens* | yes | Prefrontal executive control; Dehaene's C2 (self-monitoring) |
| **Perception** | Estimates current world state `s = Enc(x)`, hierarchically, primed by the configurator to extract only what the task needs | yes | Sensory and association cortex |
| **World model** | (1) fills in state information perception did not supply, (2) predicts plausible future states given proposed actions. Multi-modal predictions carried by latent variables | yes | Prefrontal cortex |
| **Cost** | Scalar "energy" = `Σ_i u_i·IC_i(s) + Σ_j v_j·TC_j(s)`. Weights `u, v` set by the configurator | **Intrinsic Cost (IC): never** | IC ↔ basal ganglia / amygdala; TC ↔ reward-predicting prefrontal cortex |
| **Trainable Critic (TC)** | Predicts future intrinsic energy, e.g. minimise `‖IC(s_{τ+δ}) − TC(s_τ)‖²` on triplets `(τ, s_τ, IC(s_τ))` retrieved from memory | yes | — |
| **Short-term memory** | Key-value associative store of (time, state, intrinsic energy); read/written by the world model; trains the critic | yes | Hippocampus |
| **Actor** | Proposes action sequences, optimises them against the cost, emits the first action; also instantiates latent configurations and trains policy nets | yes | Premotor cortex |

**The Intrinsic Cost is immutable by design** — it is where drives live (pain, hunger, curiosity, "influencing the state of the world", empathy, safety guardrails), and the stated reason for freezing it is to prevent behavioural collapse or drift. The configurator may reweight it but not rewrite it. This is the wiki's first architecture with a *deliberately unlearnable* component.

---

## Mode-1 and Mode-2

| | **Mode-1** (reactive) | **Mode-2** (deliberate) |
|---|---|---|
| Computation | `a[0] = A(s[0])`, one forward pass | Propose → simulate → evaluate → optimise → act; iterate |
| Uses the world model | No (optionally one step, to train it) | Yes, unrolled to horizon `T` |
| Optimiser | — | Gradient descent through the unrolled model; or dynamic programming / beam search / MCTS if the action space is discrete or the map is non-smooth |
| Analogy | Kahneman System 1 | Kahneman System 2; formally **model-predictive control with receding horizon**, differing from classical MPC only in that model *and* cost are learned |
| Concurrency | Many policy modules may run at once | **One task at a time** — there is only one world-model engine, and it is configured for a single task |

**Mode-2 → Mode-1 is the paper's own amortisation step.** Run Mode-2, obtain the optimal sequence `(ǎ[0], …, ǎ[T])`, then train `A(s[t])` to minimise a divergence `D(ǎ[t], A(s[t]))`. The distilled policy then either acts reactively or *initialises* the next Mode-2 optimisation. Named in the source as amortised inference; see [[wiki/concepts/amortized-inference.md]].

**The single-engine hypothesis is a substantive claim, not an implementation detail.** Its justifications are hardware reuse *and* knowledge sharing — one generic world model per environment, a small slice of parameters modulated per task, which "may enable reasoning by analogy, by applying the model configured for one situation to another situation". Its cost is the one-conscious-task-at-a-time limit, which the source offers as an explanation of that limit in humans.

---

## JEPA: the centrepiece

Two encoders (not required to share architecture or parameters, so `x` and `y` may be different modalities), a predictor, and an optional latent:

```
s_x = Enc_x(x)        s_y = Enc_y(y)        s̃_y = Pred(s_x, z)
E_w(x, y, z) = D(s_y, s̃_y)        F_w(x, y) = min_{z∈Z} E_w(x, y, z)
```

**It is not generative: it predicts the *representation* of `y`, never `y`.** That is the whole point — the `y`-encoder may discard whatever is not predictable (carpet texture, leaves in wind, pond ripples), which a generative model structurally cannot do except by pushing the detail into a latent.

Two independent routes to multi-modality:

| Route | Mechanism |
|---|---|
| **Encoder invariance** | If a set of `y` maps to one `s_y`, all of them get identical energy — multi-modality with no latent at all |
| **Latent predictor** | Varying `z` over `Z` sweeps a set of plausible predictions `Pred(s_x, Z)`. Car at a fork: `s_x, s_y` carry position/orientation/velocity, `z` is one bit for left-or-right |

**The four training criteria** (non-contrastive; **VICReg** ([[wiki/entities/vicreg.md]]) and **Barlow Twins** ([[wiki/entities/barlow-twins.md]]) are the named instances):

1. maximise information content of `s_x` about `x`
2. maximise information content of `s_y` about `y`
3. make `s_y` predictable from `s_x` — this *is* the energy term `D(s_y, s̃_y)`
4. **minimise the information content of `z`**

Criteria 1, 2 and 4 are collectively what prevents collapse; each blocks one of the collapse modes tabulated in [[wiki/concepts/energy-based-models.md]].

**They are not necessary, and the counterexample predates the design** ([[wiki/entities/byol.md]]). BYOL implements criterion 3 and nothing else — no information-maximisation on either encoder, no latent to limit — and reaches 74.3% ImageNet linear-eval top-1 without collapsing, because its two branches are asymmetric in function (predictor on one side) and in update rule (EMA on the other). So the four criteria are one sufficient recipe among at least two, and the second one has no objective attached: what it buys in tuning cost (zero anti-collapse coefficients) it gives back in certifiability. **And the named instance qualifies them from the other side** ([[wiki/entities/barlow-twins.md]]): deleting Barlow Twins' redundancy-reduction term — its implementation of criteria 1–2 — leaves 57.3% top-1 rather than collapse, because the batch-wise standardisation inside its loss already denies a constant encoder. So part of what the criteria are credited with is done by a normalisation, and the four-part decomposition over-attributes. VICReg implements 1 and 2 by expanding `s` to a higher-dimensional `v` and driving that embedding's covariance matrix toward the identity — a **variance** hinge keeping each component's standard deviation above a threshold, plus a **covariance** term decorrelating pairs of components.

**And the named instance supplies the property this design needs and cannot get from the other one** ([[wiki/entities/vicreg.md]]). VICReg applies both terms to **each branch separately**, so criteria 1 and 2 are enforced independently on `s_x` and `s_y` — which is what allows the two encoders to have different weights, different architectures and *different input modalities* (image ⊕ caption, raw waveform ⊕ spectrogram, both beating Barlow Twins by 2–3 points). Barlow Twins' cross-correlation matrix couples the branches and loses 4.5 points as soon as they stop sharing weights. Since this design's `x` and `y` are in general different slices of the world — past and future, or one modality and another — the per-branch form is the one the four criteria actually require, and the coupled form is the special case.

**Criterion 3 against criteria 1–2 is the architecture's central trade-off:** completeness of the representation versus predictability of the world in it. What gets represented is decided implicitly by the encoders' and predictor's inductive biases — which the source concedes is a lever it does not know how to set, offering only auxiliary prediction heads on task-relevant derived variables as a way to bias it.

**The lever has a measured instance, and it is not in the encoder** ([[wiki/entities/i-jepa.md]]). In the first image JEPA, holding the loss, the architecture and the dataset fixed and varying only the distribution over *which sub-images are paired* moves ImageNet-1% linear evaluation from **15.5 to 54.2** — larger than the spread across the entire anti-collapse literature. Two of the losing settings (random patches, one large block) are the masked-image-modelling field's defaults; the winner samples four semantically-sized targets from a spatially distributed context, deliberately placed between targets predictable from local texture and targets not predictable at all. So "what gets represented" is set by the **pair sampler**, a component this design does not name, and the auxiliary-head proposal is aiming at the wrong slot ([[wiki/empirical-tensions.md]] T167).

**And criterion 3's own premise now has a controlled price.** The same page's target ablation — representation-space targets 66.9, pixel targets 40.7, everything else fixed and the losing arm given *more* epochs — is the wiki's only direct measurement of the claim that prediction must happen in latent space (T162).

---

## H-JEPA and hierarchical planning

Stack JEPAs: level 1 makes short-term predictions on detailed representations, level 2 takes level-1 representations as input and makes longer-term predictions on coarser ones (temporal pooling between levels). The argument that this is *forced*: long-horizon prediction at full detail is impossible, so any architecture predicting far ahead must have discarded detail, i.e. must have abstracted.

**The hierarchical planning move, and the reason this page matters to the wiki:**

> A high-level "action" is **not** an action. It is a *condition the lower-level state must satisfy* for the high-level prediction to hold.

So `a₂[2]` is fed to a lower-level cost module `C(s[2])` measuring how far the low-level state is from satisfying it — the subgoal is a learned cost, not a symbol. The top level infers `(a₂[2], a₂[4])` minimising `C(s₂[4])`; the lower level then infers a fine action sequence minimising the induced subgoal costs. The source notes this is old in control theory (a proportional servo is exactly "given a target state, descend the squared distance"), flags that the described top-down pass is greedy and that joint optimisation across levels would be better, and states that the intermediate action vocabulary must be **learned**, not predefined — which is where existing hierarchical-planning work stops.

**Uncertainty:** each predictor at each level gets its own regularised latent `z_i[t]`, sampled at planning time from the Gibbs distribution of its regulariser (parameters optionally amortised from earlier states, or set by the configurator, to bias sampling toward plausible trajectories). Branching is `k^t` for `k`-valued discrete latents, so directed search and pruning — MCTS — are required. With multiple sampled trajectories, the actor can minimise expected cost *or* a combination of mean and variance, i.e. plan for risk rather than for expectation.

---

## Two further design commitments

**Separate the world model from the ego model.** The agent's own effector-to-proprioception map is far more predictable than the external world, so it should get its own model, plausibly latent-free. The ego model then serves as the **template for modelling other agents** — the wiki's cheapest available route to theory of mind, and a structural argument for it rather than a behavioural one.

**Keep world state in a writable key-value memory, not a state vector.** An action changes a small part of the world; a vector-passing architecture rewrites all of it. Read `v = Σ_j Normalize(Match(k_j, q))_j · v_j`, write by `Update(r, v, c) = c·r + (1−c)·v`, allocate a new slot when the query is far from every key (thresholded by the `γ` in the normaliser). One entry per **entity**: `k_bottle`, `k_kitchen`, `k_dining-room`, and moving the bottle updates three entries and nothing else. All differentiable.

**(brainstorm)** That last paragraph is a graph store with sparse edits, arriving from an efficiency argument rather than from a representational one. It is the closest thing in the wiki to an explicit instance-graph in fast **M** whose *update locality* is architecturally enforced — and the allocation threshold is a de-aliasing decision (gap G2): a query far from every key creates a new node instead of merging into an old one.

---

## Five modes of information gathering

The source's taxonomy of how a world model gets its data, ordered by how much the agent perturbs the world:

| Mode | Description | What it can establish |
|---|---|---|
| 1. Passive observation | A sensor stream is fed to the agent | Correlational structure; laws of motion "in principle" |
| 2. Active foveation | Attention directed within the stream, environment unaffected | Same, sampled better |
| 3. Passive agency | Watching *another* agent act | **Causal effects of actions**, without acting |
| 4. Active egomotion | Sensor position changed, environment substantially unaffected | Viewpoint/parallax structure; depth, occlusion, objecthood |
| 5. Active agency | The stream is influenced by the agent's own actions | Causal models of one's own effects; brings exploration/exploitation to the fore |

**The split now has a quantity, if not an answer.** V-JEPA 2 spends >1,000,000 hours of mode-1 passive observation and **62 hours** of mode-5 interaction data, and the second stage is the only one that touches actions at all — so on this one system the observed ratio is ~16,000:1, with everything except the action response bought from mode 1 ([[wiki/entities/v-jepa-2.md]]). It is an existence point rather than a boundary: nothing tests whether 6 hours or 600 would have done, and the interaction data is *teleoperated by humans*, i.e. mode 3 (passive agency, watching another agent act) as much as mode 5.

The stated open question is the split: how much is reachable by 1/2/4, how much needs 3, how much needs 5. Modes 2, 4 and 5 are argued to require **intrinsic motivation** aimed at states where the model's predictions are currently wrong or uncertain — curiosity as a data-collection policy, not as a reward hack.

**The split now has a formal partial answer, and it is unfavourable to modes 1–4.** For the action-conditioned JEPA objective under invertible observations and linear–Gaussian latent dynamics, a *state-only* predictor provably identifies only `E_π[z_{t+1} | z_t]` — the future averaged over whatever policy generated the data — and does **not** identify how an alternative action would change the next state. Recovering the controlled dynamics needs mode 5 and needs it to be *noisy*: the sufficient condition is a positive **conditional** action excitation `ρ_tr(π) = λ_min(E_z[Cov_π(a|z)])`, i.e. action variation that survives conditioning on the state. Acting is not enough; acting *predictably given the state* leaves the model exactly where passive observation left it (Zhang et al. 2026, [[wiki/concepts/learned-world-models.md]]).

**This lands on two of the architecture's own commitments.** (i) The Gaussian constraint that theory needs is precisely the LeJEPA-style regularisation this design's criteria 1–2 are meant to supply, so the result is a positive identifiability theorem *for this objective* — the first the wiki has. (ii) The Mode-2 → Mode-1 distillation trains a deterministic policy `A(s)`, which drives `ρ_tr → 0`; the counterfactual error of a model trained on that policy's data can be amplified by `1/ρ_tr` while its on-policy prediction loss keeps falling. The architecture's amortisation step and its world-model estimation step pull against each other, and nothing in the design arbitrates (gap **G63**).

---

## The developmental argument for abstraction-by-prediction

The source's account of what an H-JEPA trained on video *should* learn, level by level, is a concrete instantiation of the wiki's meta-graph acquisition story:

| Level | Predictive task | Concept that falls out |
|---|---|---|
| Local patches, space and time | Predict a region from its neighbours | Edges, contours, moving contours |
| Viewpoint pairs | Predict one view from a nearby view | A **depth map** — the simplest explanation of view change |
| Depth + motion | — | Occlusion edges; collective motion of rigid regions ⟹ **objects** |
| Object level | Objects reappear after parallax occlusion | **Object permanence** |
| Object trajectories | Predictability of trajectories | **Inanimate vs. animate** (animate = harder to predict) |
| Longer horizons on object representations | — | Stability, gravity, momentum, then cause-and-effect, then social and linguistic structure |

This is a claim, not a result. Its value here is that it is a *falsifiable ordering*: abstraction levels should appear in that sequence, and the acquisition ages charted in the source (object permanence ~2–4 months, gravity/inertia ~7–9 months) supply the developmental prediction to check it against ([[wiki/concepts/core-knowledge.md]]).

**It is now partly a result, and the ordering held.** Garrido et al. 2025 score a V-JEPA — one level of this design, trained exactly as specified on natural video — with violation-of-expectation on IntPhys / GRASP / InfLevel, against a null of 20 randomly-initialised networks ([[wiki/concepts/violation-of-expectation.md]]):

| Table row | Predicted | Measured |
|---|---|---|
| Objects, permanence | early, easy | Object permanence `g = 9.0`, continuity `g = 11.0`, shape constancy `g = 8.1` (IntPhys); 98% overall |
| Stability, gravity, momentum | later | Support `g = 3.9`, gravity `g = 4.5`, inertia `g = 1.8` (GRASP) — above the null but a rank below; gravity **fails** on InfLevel, where the disambiguating event precedes the model's memory window |
| Cause-and-effect | latest | Solidity and collision **at chance**. Colour constancy also at chance |

Three qualifications. (i) This is a **difficulty** ordering measured on a converged model, not the **acquisition** ordering the table predicts — nobody ran the probe over training checkpoints, which is a one-line experiment on data the ablation study already generated. (ii) The design's own explanation for the tail is available and untested: interaction properties may need "higher-order representations" that one level cannot form, which is the argument for the stack, and the authors of the empirical paper reach for it independently. (iii) The other proposed cause is data, not depth — object interactions are rare in HowTo100M — and the two are not separated by anything reported.

**The strongest single fact for this page's position against core knowledge:** the levels above depth and objecthood are reached with no installed abstraction, at 115M parameters, on 128 hours of unique video ([[wiki/empirical-tensions.md]] T12).

---

## Position against the two dominant alternatives

| Target | Argument |
|---|---|
| **"Scaling is enough"** | Two objections. (i) Tokenised generative models handle uncertainty by a distribution over a finite dictionary; that device does not exist for high-dimensional continuous signals, so *some* encoder must discard the unpredictable — which is the JEPA move. Masked/denoising auto-encoding is furthermore classified as a **contrastive** method and inherits its dimensional cost. (ii) With no abstract latent variables, there is no way to explore alternative interpretations of a percept or to search for a course of action — and "dynamically specifying a goal in such models is essentially impossible" |
| **"Reward is enough"** | In standard RL the intrinsic cost *is the environment*: an unknown, non-differentiable function whose gradient must be estimated by trials. Here it is a known differentiable function of predicted states, so the whole design is closer to optimal control than to RL. Most parameters are trained by predicting observations; the scalar reward is low-information and plays "a relatively minor role" |
| **"Deep learning needs bolted-on symbol manipulation"** | Rejected in favour of making the *learned hierarchy* smooth enough that discrete high-level choices become a continuous relaxation. Conceded as unresolved — whether energy minimisation covers all human reasoning is stated as an open question |

---

## Comparison to related architectures in the wiki

| | **H-JEPA** | [[wiki/entities/bayesian-program-learning.md]] | [[wiki/entities/aixi.md]] | Predictive coding ([[wiki/concepts/predictive-coding-free-energy.md]]) |
|---|---|---|---|---|
| Model of the world | Learned encoders + predictor, non-generative | Hand-specified generative program prior over strokes | Universal mixture over all computable environments | Learned generative hierarchy, residual-driven |
| Where uncertainty lives | Regularised latent `z` + encoder invariance | Program's stochastic choices | Posterior over environments | Precision (inverse variance) gates |
| Planning | Gradient descent on actions through the unrolled model (MPC) | Not a planner | Expectimax over the mixture | Inverse temporal predictions to recover forces |
| Abstraction | Emerges from the predictability/completeness trade-off, stacked | Architectural: parts, sub-parts, relations | Absorbed into the posterior, not represented | Stipulated: three typed prediction channels |
| Evidence | **None as a design** — but its central component now has some: [[wiki/entities/v-jepa-2.md]] scales the JEPA half to 1B parameters and 1M video-hours, and drives it to zero-shot pick-and-place on real Franka arms. The *stack*, the latent `z`, the configurator and the learned cost remain untested | One-shot human-level on Omniglot; passed a visual Turing test | Formal results only; uncomputable | Sketch; no integrated implementation |
| Hardness sources reached (claimed) | 1 (H-JEPA levels), 2 (learned latents/actions), 4 (online replanning), 6 (partially, via reconfiguration) | 1, 2 | all six | 4, partially 3 |

**The honest summary:** this is the wiki's most complete *design* for a reasoning agent and its least-evidenced entry. Every quantitative result cited belongs to a component ([[wiki/entities/vicreg.md]], Barlow Twins, VQ-VAE, transformers), never to the assembly.

**The first implementation attempt confirms the summary and narrows it.** V-JEPA 2 ([[wiki/entities/v-jepa-2.md]], Assran et al. 2025, several authors shared with this source) builds exactly one level of the design and gets a working robot out of it: masked feature prediction on >1M video-hours, encoder then frozen, a separately trained action-conditioned predictor on 62 h of teleoperation, MPC by cross-entropy method over `‖P(â;s,z) − z_g‖₁`. What it validates is the *core*: prediction in representation space, an encoder/predictor split, planning as energy minimisation over action variables — and the energy landscape is measured to be smooth and locally convex around the true action, which is the precondition this design's gradient-based planner needs and never checked. What it leaves untouched is everything this page adds *on top of* a JEPA — no stack, no temporal pooling, no latent `z` (so no multi-modality and no risk-sensitive planning), no configurator, no cost module (a subgoal is a goal *image* whose embedding you descend toward, not a learned cost), and no gradient-based action inference (a sampling optimiser is shipped instead). Its reported failures — autoregressive error accumulation and exponentially growing action search — are precisely the failures the hierarchy was proposed to fix, and its own future-work section asks for the hierarchy by name. So the design's least-evidenced parts are still its distinctive parts.

---

## Limitations, mostly the author's own

- **The configurator is unspecified and is the linchpin.** How it decomposes a complex task into a sequence of achievable subgoals — the operation the entire hierarchical-planning story depends on — is "left open for future investigation". Called "the most mysterious" module by the source.
- **No demonstration that H-JEPA can be trained from video at all**, let alone that it produces the concept hierarchy above. **Partly retired, on a different data type** ([[wiki/entities/hit-jepa.md]]): a three-level stack does train jointly and stably on sequences, and beats its own single-level ablation — but the levels differ in *sequence resolution*, not in prediction horizon, so the claim that far-ahead prediction forces abstraction remains untested, and the measured benefit is ~4% in-distribution against a halving of error under distribution shift (Li et al. 2025).
- **The latent regulariser is undetermined** — discrete, low-dimensional, sparse or stochastic, with no criterion for choosing.
- **Gradient-based action inference may not work** where the action-to-cost map is non-smooth, which is precisely the high-abstraction regime the hierarchy is for.
- **Nothing cycles through alternative latent interpretations** (the Necker-cube capability).
- **The short-term memory's role in representing beliefs is "somewhat fuzzy"**, and getting memory-network architectures to work for complex planning is conceded to be hard.
- **Branching is `k^t`.** Pruning is named (MCTS) and not designed.
- **Emotions are predicted to be inevitable** in any agent of this design — instantaneous ones from the Intrinsic Cost, anticipatory ones (fear, elation) from the Trainable Critic. Stated as a consequence, not a goal.

---

## Connections

- **[[wiki/concepts/energy-based-models.md]]** — the formalism this architecture is an instance of: a JEPA is an EBM whose energy is prediction error in representation space, and the four training criteria are its collapse-prevention recipe.
- **[[wiki/concepts/simulation-based-planning.md]]** — the fullest worked version of the *use* half of the framing: Mode-2 is model-predictive control with a learned model and a learned cost, and the hierarchical variant supplies the wiki's first mechanism for jumpy multi-scale planning.
- **[[wiki/concepts/amortized-inference.md]]** — the Mode-2 → Mode-1 distillation is plan amortisation named as such, plus a second amortisation the wiki did not have: predicting the minimising *latent* rather than the optimal action.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the two-level hierarchy realised as prediction *timescale*: H-JEPA's upper level is the coarse graph and its lower level the fine one, with the split emerging from what is predictable rather than being imposed.
- **[[wiki/concepts/abstract-structural-codes.md]]** — supplies a training signal for abstraction the wiki lacked: a representation is abstract *because* it is what remains predictable at long range, which makes the level structure a consequence of the objective rather than a design choice.
- **[[wiki/concepts/working-memory.md]]** — the world-state key-value store with per-entity slots, sparse updates and threshold-triggered allocation is control/storage separation applied to the environment model itself.
- **[[wiki/concepts/attention.md]]** — the configurator is the goal-driven control of the spotlight that page lists as missing: it modulates attention circuits and, in transformer modules, is implemented as extra input tokens.
- **[[wiki/concepts/causal-model-building.md]]** — the direct rival on generativity: model building demands the model's steps resemble the generative process, while this architecture argues against generative models precisely because they cannot discard the irrelevant ([[wiki/empirical-tensions.md]] T18).
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the closest relative in the wiki: same scalar-minimisation shape, same activity/weight timescale split, differing on whether the scalar is a probability and on whether collapse is the central obstacle.
- **[[wiki/concepts/core-knowledge.md]]** — the developmental table above is the rival account of the same acquisitions: object permanence, cohesion and intuitive physics as *learned* consequences of prediction at increasing abstraction, on the same age chart core knowledge reads as installed ([[wiki/empirical-tensions.md]] T12).
- **[[wiki/concepts/event-segmentation.md]]** — temporal pooling between JEPA levels is a coarse-graining of time that never names boundaries, which is the same job event segmentation does with a boundary detector and no fixed pooling window.
- **[[wiki/concepts/three-component-framework.md]]** — a full three-slot specification: energy as objective, non-contrastive regularisation as learning rule, the module graph as architecture — and it is the wiki's first candidate architecture in which the *cost* is designed rather than the behaviour.
- **[[wiki/concepts/shortcut-learning.md]]** — the design's bet on the architecture lever: prediction in a representation space that is trained to be maximally informative *and* maximally predictable is meant to make appearance-only rules unavailable, with collapse as the shortcut the four criteria explicitly outlaw.
- **[[wiki/concepts/meta-learning.md]]** — the single configurable world-model engine is the two-level split moved into *inference*: shared slow structure plus a small modulated slice per task, with reconfiguration standing in for an inner-loop update.
- **[[wiki/entities/maze-solving-transformers.md]]** — the contrast case on where a world model has to live: this design stipulates a separate world-model module, and an equally decodable one emerges unbidden at layer 2 of a generic decoder trained only on next-token prediction (Ivanitskiy et al. 2023).
- **[[wiki/entities/differentiable-neural-computer.md]]** — the trained precedent for this page's key-value world state: the same threshold-style allocation of a fresh slot when nothing matches, shown to recycle slots under memory pressure via a differentiable free list, and shown to survive a change of memory size after training.
- **[[wiki/concepts/cognitive-control.md]]** — the biological version of the configurator, and what it says is missing: modulating a module by injecting extra tokens *is* additive bias, but the biological mechanism only works because the biased systems mutually inhibit (so a small bias decides a competition), and because the bias is a persistent task-identified state trained by reward-gated association among co-active controller units — a transformer has only the softmax for the first and nothing at all for the second (Miller et al. 2002).
- **[[wiki/entities/spacetime-attractor.md]]** — the same optimisation over a learned model reached from the biological side: instead of back-propagating a cost into action variables through an unrolled predictor, the predictor is *already* unrolled in the recurrent weights and the plan is found by relaxation, which removes the differentiability requirement the gradient-based planner depends on (Jensen et al. 2026).
- **[[wiki/entities/deep-active-inference-agent.md]]** — the same five-module inventory (encoder, world model, cost, actor, critic) with the cost *derived* from a free-energy objective instead of hand-designed, and evidence for this page's choice: every derived-cost variant is beaten by its own reward-only ablation, and the full five-network agent diverges in 14 of 15 configurations (Champion et al. 2023).
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the predecessor this design supersedes on one axis and drops on another: a subgoal here is a learned cost on the lower-level state rather than a symbolic subgoal state, which removes the option vocabulary problem — but an option also carries a termination function and an expected *duration*, so its levels are variable-length commitments where this architecture's are fixed prediction time-scales (Botvinick, Niv & Barto 2009).
- **[[wiki/entities/hisd.md]]** — the opposite answer to where hierarchy depth comes from: levels here are fixed architectural time-scales with no termination function, while HiSD's depth is whatever a grammar compresses the demonstration corpus to — and the trade is symmetric, since HiSD has variable-length units and no world model, so it can only select among compiled options and never plans (Harvey et al. 2026).
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the discrete rival at the same job: high-level actions here are continuous conditions on lower-level states learned by long-range predictability, there they are binary codes learned by effect-equivalence and distilled into PDDL rules a classical planner consumes; nobody has run either inside the other (Taniguchi et al. 2023).
- **[[wiki/concepts/learned-world-models.md]]** — the field this architecture is a minority position in: of ~38 robot dynamics models surveyed, roughly half are RSSM variants and exactly one is a joint-embedding predictive architecture — and the reconstruction-free lineage inside the RSSM family (Dreaming, DreamerPro) reaches the same conclusion from the opposite direction, deleting the decoder because pixel loss makes small task-critical objects vanish (Long et al. 2025).
- **[[wiki/concepts/learned-world-models.md]]** — and the identifiability theory for this page's objective: the LeJEPA-style Gaussian constraint plus a positive conditional action excitation in the behaviour policy suffices for the global minimiser to recover latent state and controlled dynamics up to an orthogonal `Q` — while the design's own Mode-2 → Mode-1 distillation, by making the actor deterministic, destroys the second condition (Zhang et al. 2026).
- **[[wiki/entities/kan-ode.md]]** — a cheaper mechanism for this design's *jumpy prediction*: a continuous-time model integrated by an adaptive solver takes large steps wherever the dynamics are slow, making temporal abstraction a tolerance setting instead of a stack of separately trained encoders — but it gives up the property that motivates the stack, since it predicts the state it was handed rather than an abstraction it selected for predictability.
- **[[wiki/entities/v-jepa-2.md]]** — this design's JEPA core built at scale and driven to a real robot, and therefore the audit of which of its commitments are load-bearing: representation-space prediction and energy-minimisation planning survive contact with hardware, while the stack, the latent, the configurator and the learned cost were all dropped to get there — and every long-horizon limitation reported is the one the stack exists to fix.
- **[[wiki/entities/adaworld.md]]** — the opposite pair of choices on the two axes this design fixes: predicts in *pixel* space via diffusion where this page predicts in representation space, and *induces* its action vocabulary from video where this page assumes one and learns subgoal costs above it — the wiki's only head-to-head on where an action alphabet comes from.
- **[[wiki/entities/lewm.md]]** — this design's core at the other extreme of scale, and the sharpest statement of what its four training criteria cost: one distribution-matching term with a single coefficient replaces the collapse machinery entirely, trained end-to-end from pixels with no EMA, no stop-gradient and no frozen encoder — while the stack, the latent `z`, the configurator and the learned cost remain unbuilt here too (Maes et al. 2026).
- **[[wiki/concepts/violation-of-expectation.md]]** — the instrument that turned this page's developmental table from a claim into a partial result, and the one that priced it: the predicted early levels emerge at `g` 8–11 over an untrained null, the predicted late one (interaction, cause-and-effect) is at chance in the single-level model the stack was proposed to replace.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the evidence against this page's founding commitment that reconstruction is unnecessary: on Winoground, the compositional benchmark the whole vision-language field fails, the models that *do* decode to input space far outperform the joint-embedding ones ([[wiki/empirical-tensions.md]] T162).
- **[[wiki/entities/vicreg.md]]** — the primary source for the first named instance of the four training criteria, and the one property this design cannot get elsewhere: variance and covariance terms applied to each branch *separately*, so criteria 1 and 2 hold on `s_x` and `s_y` independently and the two encoders may differ in weights, architecture and modality.
- **[[wiki/entities/barlow-twins.md]]** — the measured instance of criteria 1–3 in a single matrix penalty, and the source of two qualifications: the anti-collapse work is shared with a batch normalisation inside the loss (invariance term alone: 57.3%, not collapse), and adding BYOL's asymmetry on top costs 10 points, so this design's two candidate anti-collapse routes are alternatives rather than complements.
- **[[wiki/entities/i-jepa.md]]** — this design's first working image instantiation, and the two numbers it puts on the design's own commitments: representation-space targets beat pixel targets by 26.2 points with everything else held fixed, and the pair sampler — a component this page never names — is worth 34 points, which relocates the "we do not know how to set the inductive-bias lever" concession onto a concrete and cheap knob.
- **[[wiki/entities/byol.md]]** — the counterexample to this design's four training criteria as necessary conditions: criterion 3 alone, with no information-maximisation and no latent, avoids collapse by branch asymmetry — cheaper in coefficients and uncertifiable, since no objective corresponds to the dynamics.
- **[[wiki/entities/hit-jepa.md]]** — the first *trained* instance of this page's stack, and the audit of it: three JEPAs over a Conv1D/MaxPool resolution pyramid, coupled top-down by upsampled attention matrices, trained jointly on one GPU — so "can a stack be trained at all" is answered yes, but the level axis is sequence resolution rather than prediction horizon, there is no latent, no action and no cost, and the measured payoff is ~4% in-distribution against a halving of error under distribution shift (Li et al. 2025).
