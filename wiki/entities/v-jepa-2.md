# V-JEPA 2 and V-JEPA 2-AC

**The JEPA design built at scale and driven to a real robot: a 1B-parameter video encoder trained by masked *feature* prediction on 1M+ hours of internet video, then frozen, with a separately trained 300M action-conditioned predictor bolted on top of 62 hours of unlabeled teleoperation video — and planning done by cross-entropy-method search over an L1 distance to a goal *embedding*.**

> **Provenance.** Assran et al. 2025, *V-JEPA 2: Self-Supervised Video Models Enable Understanding, Prediction and Planning* (`raw/assran-2025-v-jepa-2.md`), arXiv:2506.09985v1, FAIR at Meta + Mila. Code and weights released. Successor to V-JEPA (Bardes et al. 2024); the design it instantiates is [[wiki/entities/h-jepa.md]] (LeCun 2022), several of whose authors are shared.

This is the page the wiki's JEPA entries have been citing by name with no page of their own. Its value here is that it converts a position paper's claims into numbers — and that the numbers land on *different* claims than the ones the design leads with.

---

## The two stages

| | **Stage 1 — V-JEPA 2** (action-free) | **Stage 2 — V-JEPA 2-AC** (action-conditioned) |
|---|---|---|
| Data | VideoMix22M: 22M samples, >1M video-hours (SSv2, Kinetics, HowTo100M, curated YT-Temporal-1B, ImageNet) | **62 hours** of raw Droid teleoperation video (Franka Panda, 7-DoF + gripper), left exocentric camera only |
| Labels | none | none beyond the end-effector state already logged per frame; **no reward, no task label, no success flag** |
| Objective | `min ‖P_φ(Δ_y, E_θ(x)) − sg(E_θ̄(y))‖₁` — masked-patch feature prediction, L1, EMA teacher (`0.99925`), loss on masked patches only | teacher forcing `‖ẑ_{k+1} − z_{k+1}‖₁` over 15 steps **plus** a 2-step rollout loss, summed |
| Trained | encoder + predictor jointly | **predictor only** — encoder frozen |
| Size | ViT-L 300M → ViT-g 1B encoder; predictor fixed at ViT-s 22M | 24-layer, 1024-wide, ~300M transformer, block-causal attention |
| Position code | 3D-RoPE (feature dim split into `T/H/W` thirds, 1D rotations per axis) — replaces absolute sincos, needed to stabilise the largest models | 3D-RoPE on patches; **temporal rotary only** on action and pose tokens |
| Tokens | tubelets `2×16×16` | interleaved `(a_k, s_k, z_k)`; feature maps `16×16×1408` per frame |

The interface between the stages is the whole architectural bet: **whatever stage 1 discarded is unavailable to control for ever**, because the encoder never moves again. The paper states this itself — V-JEPA 2-AC's capabilities "fundamentally depend on the information captured in the V-JEPA 2 representation space."

---

## Scaling: the four ingredients, with their individual contributions

Baseline is a ViT-L/16 on VideoMix2M; the metric is average accuracy over six frozen-probe classification tasks (SSv2, Diving-48, Jester, K400, COIN, IN1K).

| Ingredient | Change | Δ avg |
|---|---|---|
| Data | 2M → 22M videos | **+1.0** (concentrated on *appearance* tasks — K400, COIN, IN1K) |
| Model | 300M → 1B (ViT-L → ViT-g) | **+1.5** (motion +1.6 on SSv2 and appearance +1.5 on K400 both benefit) |
| Schedule | 90K → 252K iterations, warmup-constant-**cooldown** instead of cosine | **+0.8** |
| Resolution | 256→384 px, 16→64 frames, at train *and* eval | to **88.2** total, +4.0 cumulative |
| Curation | uncurated YT1B → cluster-retrieval-curated YT1B (target = K710/SSv2/COIN/EpicKitchens distribution) | **+1.4** at ViT-L — and it *inverts* in the mixed setting (SSv2 72.8 curated vs 73.3 uncurated) |

Two entries deserve to survive the table.

**Progressive resolution is a scheduling trick with an 8.4× price tag attached.** Training ViT-g directly on `64×384×384` was projected at ~60 GPU-years; training short/low through warmup and constant phases and raising duration + resolution only during the 12K-step cooldown gets the same input capability for 1/8.4 of the GPU time. Longer clips at cooldown improve performance **even when evaluation stays at 16 frames** (+0.7), i.e. the benefit is in what the encoder learned, not in what it can ingest. Beyond 64 frames (128, 256) nothing further was gained.

**Curation is not monotone, which is the more interesting result.** Retrieval-based curation toward a target distribution helps a lot in isolation and *hurts* SSv2 once hand-selected video and images are mixed in — and Curated-YT1B alone beats the full mix on COIN (86.5 vs 86.25) and K400 (84.6 vs 83.7) despite the mix containing K710 training data outright. **(brainstorm)** This is gap **G32** (nothing designs the experience stream) with a sign flip: adding the target task's own training data to the pretraining mixture made the downstream number on that task go *down*. Curation and mixing are not composable interventions, and no principle in the source or the wiki predicts which pairs cancel.

---

## Planning: energy minimisation in embedding space

Given current frame `x_k`, end-effector state `s_k`, and a **goal image** `x_g`, both encoded by the frozen encoder:

```
E(â_{1:T}; z_k, s_k, z_g) = ‖ P(â_{1:T}; s_k, z_k) − z_g ‖₁
(a*_i) = argmin E ,  execute a*_1 , re-observe , replan     (receding horizon)
```

Optimised by the **cross-entropy method**: sample each action coordinate from a per-timestep Gaussian (zero mean, unit variance), keep the top-`k`, refit mean/variance, repeat 10 refinement steps, return the mean sequence. Deployment settings: 800 samples, 10 iterations, **planning horizon `T = 1`**, actions constrained to the L1 ball of radius 0.075 (~13 cm max displacement) because larger actions are out of distribution.

Three properties of this energy that the wiki's planning pages have been asking for:

- **It is smooth and locally convex** in the action, and its minimum sits near the ground-truth action (measured by sweeping `Δx, Δy` at `Δz = 0` against a known goal displacement). So gradient-based action inference — the mechanism [[wiki/entities/h-jepa.md]] proposes and never tests — is *plausible here*, and the paper names it as future work while shipping a sampling optimiser instead.
- **Horizon 1 suffices** for every skill demonstrated, because the tasks are greedy given sub-goals. The sub-goals are what make them greedy, and the sub-goals are hand-authored.
- **The cost is a distance to a goal embedding, not a learned cost.** H-JEPA's "subgoal is a learned cost on the lower-level state" is replaced by "subgoal is an *image* whose embedding you descend toward" — cheaper, and it removes the cost-learning problem by removing the cost.

---

## Results

### Zero-shot robot manipulation (10 trials per cell, two labs, neither in Droid, uncalibrated monocular RGB)

| Method | Reach | Grasp cup | Grasp box | Reach w/ obj. cup | box | Pick-&-place cup | box |
|---|---|---|---|---|---|---|---|
| Octo (VLA, behaviour cloning on all of Droid) | 100% | 15% | 0% | 15% | 70% | 15% | 10% |
| **V-JEPA 2-AC** | 100% | **65%** | **25%** | **75%** | 75% | **80%** | **65%** |

### Same planner, same energy, different world model (Lab 2)

| Model | Samples | Iters | Horizon | **Time / action** | Reach | Grasp cup | box | P&P cup | box |
|---|---|---|---|---|---|---|---|---|---|
| Cosmos (7B latent-diffusion video generation, action-conditioned fine-tune on Droid) | 80 | 10 | 1 | **4 min** | 80% | 0% | 20% | 0% | 0% |
| **V-JEPA 2-AC** | **800** | 10 | 1 | **16 sec** | 100% | 60% | 20% | 80% | 50% |

**This row is the strongest single argument in the wiki for predicting in representation space, and it is a *compute* argument, not a fidelity argument.** Ten times more candidate actions evaluated in one fifteenth of the wall-clock is a ~150× per-sample throughput difference, and it converts directly into planning quality because the cross-entropy method's estimate improves with population size. A full pick-and-place under Cosmos takes over an hour of robot execution. The pixel-vs-latent debate has always been argued on what the objective *represents* ([[wiki/empirical-tensions.md]] T18); this says the search budget the model affords may decide the outcome before representation quality is reached. Caveats the source states: this is the first reported attempt to use Cosmos for control, the fine-tuning recipe needed three hand-tuned deviations, and both models run on one RTX 4090.

### Understanding and prediction (frozen encoder, 4-layer attentive probe)

| Task | V-JEPA 2 ViT-g₃₈₄ | Best comparator (same protocol) |
|---|---|---|
| SSv2 (motion) | **77.3** | InternVideo2ₛ₂-1B 69.7; PE_core G 55.4; DINOv2 50.7 |
| Diving-48 / Jester | 90.2 / 97.8 | 86.4 / 97.0 |
| K400 / COIN / IN1K (appearance) | 87.3 / 91.1 / 85.1 | 89.4 / 95.3 / 88.0 — **V-JEPA 2 loses all three** |
| 6-task average | **88.2** | InternVideo2ₛ₂-1B 87.0 |
| EK100 action anticipation (recall@5) | **39.7** | PlausiVL (8B) 27.6 — **+44% relative**, from a 300M frozen backbone at 32.7 |

The motion/appearance split is consistent and large: the objective that predicts *masked spatiotemporal patches from context* buys motion understanding and costs static-appearance accuracy against language-supervised image encoders. Anticipation scales linearly in model size (32.7 → 36.5 → 38.0 → 39.7) with the *predictor's* output concatenated to the encoder's before the probe — so the pretrained predictor is doing work, not just the encoder.

### Video question answering — the conventional-wisdom result

Aligned to an LLM by LLaVA-style visual instruction tuning. In the controlled comparison (same Qwen2-7B backbone, same 18M alignment samples, **frozen** vision encoder), V-JEPA 2 ViT-g₅₁₂ averages **52.3** against PE 49.1, SigLIP2 48.1, DINOv2 45.7 — winning every benchmark except PerceptionTest, with the gaps largest on the temporal ones (MVP 31.1 vs 26.7; TemporalBench 33.3 vs 27.5). Scaled to 88.5M alignment samples with Llama 3.1 8B: PerceptionTest **84.0**, MVP **44.5**, TempCompass **76.9**, TemporalBench **36.7**, TOMATO **40.3** — state of the art at the 8B class, losing to PerceptionLM 8B on TVBench and MVBench only.

**The claim worth extracting: a visual encoder pretrained with no language supervision at all can beat image–text contrastive encoders at feeding a language model.** That contradicts the standing assumption that semantic alignment with language must be installed during vision pretraining ([[wiki/empirical-tensions.md]] T149).

---

## Limitations, and the four that are architectural rather than practical

**1. The action coordinate axis is inferred from the image and rotates with the camera.** With no calibration and the robot base often out of frame, "which way is `+x`" is genuinely underdetermined. Measured: sweep the camera 35°–85° around the table, collect 201 random in-plane moves per position, solve `W* = argmin‖AW − B‖₂` mapping inferred to real actions. `W*` has condition number ≈1.5 — i.e. it is essentially a **rotation** — and the rotation error is close to *linear* in camera angle. Mean absolute prediction error ≈1.6 cm against a ground-truth delta of ≈5 cm, systematic rather than noisy. The authors note the obvious repair (execute random actions, least-squares fit `W*`, pre-multiply every inferred action) and **deliberately do not apply it**.

**(brainstorm) This is gap G43 with an error curve attached, and the repair is the wiki's own machinery.** A world model that infers the effect of an action from monocular pixels has no reference frame of its own; it has the *camera's* frame, and the map from egocentric command to image-space consequence is a free parameter it silently guesses. The proposed calibration — act randomly, regress inferred against executed, keep the rotation — is unsupervised, needs no reward, and is exactly the self-consistency constraint [[wiki/concepts/path-integration.md]] imposes by construction and this architecture does not. It is also, notably, a use for *deliberately noisy* action data (G63) that has nothing to do with reward.

**2. There is no hierarchy.** H-JEPA is the design; V-JEPA 2 is one level of it. Every long-horizon failure the paper reports — error accumulation over autoregressive rollouts, exponential growth of the action search space — is the failure the stacked design was proposed to fix, and the paper's own future-work section names "hierarchical models capable of making predictions across multiple spatial and temporal scales" as the fix. **The wiki's most complete design for jumpy planning remains untested after its flagship implementation.**

**3. There is no latent variable, so no multi-modality.** The predictor is deterministic; nothing in either stage corresponds to H-JEPA's regularised `z`, its Gibbs sampling at planning time, or its risk-sensitive mean/variance action selection. Per [[wiki/concepts/learned-world-models.md]]'s transition trichotomy this is the *deterministic* cell, which the same page names as the one a planner can exploit — and a cross-entropy method searching 800 candidates per step is precisely an optimiser hunting for the cheapest imagined state.

**4. Sub-goals are hand-authored and hand-scheduled.** Pick-and-place is solved by three images and a fixed timetable: optimise toward sub-goal 1 for 4 steps, sub-goal 2 for 10, final goal for 4. Nothing detects sub-goal achievement; the switch is a step count. This is gap **G33** left entirely open — the decomposition that makes horizon-1 planning sufficient is supplied by the experimenter, and the paper says so ("pick-and-place *without* image sub-goals" is listed as a non-greedy task it cannot do).

Plus the stated practical limits: goals must be images (language goal specification named as future work, with the LLM-alignment result offered as the starting point); single camera view only (training on both Droid views without conditioning on camera position *degraded* performance); scaling stopped at 1B while the curve was still rising.

---

## What the frame decoder shows

A ViT-L feedforward decoder is trained (L2 pixel loss, 150K steps) to map *encoder* features to pixels, then applied off-the-shelf to *predictor* rollouts — used explicitly as an interpretability instrument, not as part of the model ([[wiki/concepts/representation-probing.md]]).

- Encoder reconstructions keep what control needs and blur backgrounds.
- Rollouts from a single context frame plus a ground-truth action sequence animate the arm while leaving background and untouched objects (a shelf) unchanged.
- With the gripper **closed**, the cup moves with the arm — object constancy, shape constancy, gravity. Error accumulates: by the final frame the predicted cup is slightly below the true one.
- **The counterfactual probe:** identical action sequences, gripper open vs closed. With the gripper open the cup's predicted position is unchanged across all timesteps. This is a *qualitative* answer to the question [[wiki/empirical-tensions.md]] T145 says nobody asked — the model is queried about an action pairing the environment did not execute, and it answers correctly. No number is attached, and it is one figure.

---

## Comparison

| | **V-JEPA 2-AC** | [[wiki/entities/h-jepa.md]] (design) | [[wiki/entities/adaworld.md]] | Cosmos (this paper's baseline) | Octo (VLA) |
|---|---|---|---|---|---|
| Prediction space | learned embedding | learned embedding | pixels (latent diffusion) | pixels (latent diffusion) | — (direct policy) |
| Action condition | **given** (7-D end-effector delta) | assumed | **induced** from video by β-VAE bottleneck | given | given |
| How behaviour is produced | MPC by CEM on goal-embedding L1 | MPC by gradient descent on a learned cost | MPC by CEM on goal-image cosine | MPC by CEM | behaviour cloning |
| Hierarchy | none | stacked timescales | none | none | none |
| Multi-modal futures | no (deterministic) | yes (latent `z`) | yes (diffusion) | yes (diffusion) | n/a |
| Interaction data needed | 62 h unlabeled, incl. failures | unspecified | 100 samples/action + 800 steps to adapt | Droid fine-tune | 1M+ expert trajectories |
| Real robot, new environment | **yes, zero-shot, two labs** | never run | Procgen / LIBERO only | 0–20% success at 4 min/action | 0–15% on object tasks |
| Planning cost | 16 s/action, 800 samples | untested | — | 4 min/action, 80 samples | one forward pass |

---

## What this settles, and what it does not

**Settles:** that a JEPA trained purely by masked feature prediction on passive internet video produces representations from which (a) motion classification, (b) 1-second action anticipation, (c) language-aligned video QA, and (d) a control-usable action-conditioned dynamics model can all be read — with only (d) needing any interaction data, and needing 62 hours of it against 1M+ hours of observation. That ratio, ~16,000:1, is the wiki's sharpest datum on [[wiki/entities/h-jepa.md]]'s own open question of how much of a world model is reachable by *passive observation* (its mode 1) before active agency (mode 5) is required.

**Settled elsewhere, on the predecessor, and it is the missing objective-level evidence:** Garrido et al. 2025 score **V-JEPA** (v1) with violation-of-expectation against a null of 20 randomly-initialised networks and get 98% on IntPhys, 66% GRASP, 62% InfLevel — while **VideoMAEv2, a pixel-space predictor evaluated by the identical surprise metric, sits at the untrained null**, as do Qwen2-VL-7B and Gemini 1.5 pro. That is the closest thing in the wiki to a prediction-space comparison at fixed protocol, and unlike this page's Cosmos row it is not a compute argument. It also supplies the scale floor this page never probes downward: 115M parameters and 128 hours of unique video, at fixed compute, already clear 85% on IntPhys ([[wiki/concepts/violation-of-expectation.md]]).

**Does not settle:** whether the JEPA objective is what did it. Every baseline in every table is trained on different data with a different objective, and the paper concedes the comparison is system-level only. There is no ablation anywhere that swaps the stage-1 objective while holding data and architecture fixed — so "prediction in representation space" and "1M hours of curated video with a good schedule" are not separated by anything in this paper.

**(brainstorm) One quiet piece of luck in the design.** Stage 1 is *action-free*, and by Zhang et al. 2026 a state-only predictor identifies `E_π[z_{t+1}|z_t]` — the future averaged over whoever generated the video — and nothing about what actions do. The action response has to be learned entirely in stage 2, from Droid. Droid is **human teleoperation**, across many operators, retaining failed attempts. Human teleoperators are not a converged policy: their actions have large conditional variance given the state, which is exactly a high `ρ_tr`. So the one part of this system that had to identify controlled dynamics was trained on close to the best-excited data anybody has, and neither the paper nor the field frames it that way. The corollary is uncomfortable: this recipe's action model would get *worse* if it were retrained on trajectories from its own increasingly competent planner (gap **G63**).

---

## Connections

- **[[wiki/entities/vl-jepa.md]]** — this page's encoder frozen and handed a *language* target instead of a visual one: at matched ViT-L the swap is worth +1.5 R@5 at 1 s anticipation and +4.6 at 10 s, crossing the 3× larger ViT-g between 2 s and 4 s — the wiki's first horizon-differential measurement of prediction granularity, and the appearance/motion split reappears unchanged because the encoder is this one.
- **[[wiki/entities/dinov3.md]]** — bounds the same deficit from the same direction as this page's DINOv2 comparison, at 6× the scale: a frozen 7B image encoder with an attentive probe beats V-JEPA 2 by 3.9 on appearance-driven K400 and loses SSv2 by 4.6, so dense-feature quality and scale do not substitute for a temporal objective.


- **[[wiki/entities/h-jepa.md]]** — the design this is the first at-scale instantiation of, and the audit: the encoder/predictor split, the representation-space objective and MPC are all present and work; the stack, the latent `z`, the configurator, the learned cost and gradient-based action inference are all absent, so every long-horizon failure reported here is a failure of the level the design says should not have been alone.
- **[[wiki/concepts/learned-world-models.md]]** — the one joint-embedding entry in that page's ~38-model survey, now with its own numbers: deterministic transition (hence planner-exploitable), no decoder, and a head-to-head against a pixel-generative model under an identical planner that the decoder question had never been given.
- **[[wiki/concepts/simulation-based-planning.md]]** — supplies a working energy for the rollout (`‖P(â;s,z) − z_g‖₁`, smooth and locally convex around the true action) and the sharpest price list in the wiki for what the model costs the search: 16 s versus 4 min per action at 10× the candidates.
- **[[wiki/entities/adaworld.md]]** — the complementary half: this page has the action alphabet handed to it and induces the *dynamics* at scale from passive video; AdaWorld induces the *alphabet* and predicts in pixels. Neither induces both, and their planners are the same algorithm on different costs.
- **[[wiki/concepts/energy-based-models.md]]** — the shipped instance of planning as energy minimisation over free action variables, with the shape of the energy landscape measured rather than assumed.
- **[[wiki/concepts/representation-probing.md]]** — the frame decoder as an interpretability instrument: a decoder fit to *encoder* features and then applied to *predictor* rollouts, which reads out a latent world model's imagination without the model ever having been trained to reconstruct anything.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the missing frame, measured: the action coordinate axis is inferred from the camera image, rotates roughly linearly with camera position, and is recoverable by an unsupervised least-squares fit the authors describe and decline to run (G43).
- **[[wiki/concepts/objective-identifiability.md]]** — the case where the architecture is fixed and the *stage split* decides what is identified: an action-free stage-1 objective can only recover the policy-averaged future, so all of this system's action sensitivity is owed to 62 hours of well-excited teleoperation data rather than to the JEPA objective.
- **[[wiki/concepts/shortcut-learning.md]]** — the appearance/motion split as a diagnostic: the same encoder that beats every comparator by 20+ points on SSv2 loses to all of them on ImageNet, COIN and K400, so an objective that forces temporal prediction buys resistance to single-frame shortcuts at a measured cost in static recognition.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — what the sub-goal schedule is standing in for: three goal images and a fixed 4/10/4 step timetable, with no termination detector, is a hand-compiled option sequence, and it is what makes a horizon-1 planner sufficient (G33).
- **[[wiki/concepts/amortized-inference.md]]** — the distillation this system pointedly does *not* do, and the reason it keeps working: nothing here trains a reactive policy on the planner's output, so the behaviour policy that would collect its next round of data never becomes deterministic (G63).
- **[[wiki/entities/spelkenet.md]]** — the opposite bet on the same substrate and the same wave: predict in an abstract embedding space so unpredictable detail can be discarded, versus predict in an explicit quantised *flow* space so a one-pixel counterfactual can be addressed by appending two tokens. One buys planning latency, the other buys a query language, and neither has the other's property ([[wiki/empirical-tensions.md]] T152).
- **[[wiki/entities/lewm.md]]** — the same architecture and the same planner at 1/100th the parameter count, trained end-to-end from pixels instead of frozen after foundation-scale pretraining: it wins on planning latency (<1 s per plan) and per-FLOP control, ties on physical probing once the corpus confound is named, and never leaves simulation — so the two together bracket how much of this page's result is owed to scale.
- **[[wiki/concepts/violation-of-expectation.md]]** — the evidence this page lacks, measured on its own predecessor: the objective's physical understanding scored with no adaptation and against a matched untrained null, where a pixel-space predictor under the identical metric scores at chance and this architecture's *frozen* encoder+predictor need no probe at all.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the mechanism that would explain T149 in bits: in a multimodal objective the latent's information content is capped by the weaker channel, so a 77-token caption is a rate limiter and a vision-only encoder is not subject to it.
- **[[wiki/entities/byol.md]]** — where this system's EMA teacher and stop-gradient come from, and what they carry with them: the same asymmetry transplanted from two views of an image to two timesteps, along with the admission that no loss is jointly descended — which is why identifiability results stated for a loss's global minimiser do not apply to this training procedure.
- **[[wiki/entities/dinov2.md]]** — the encoder this page's controlled swap beats, now with its own page: DINOv2 is last of four on temporal video QA (45.7 vs 52.3) despite winning nearly every static image read-out, which localises the deficit in the missing temporal objective rather than in scale or corpus (T149).
- **[[wiki/entities/i-jepa.md]]** — this page's direct predecessor and the source of its unexplained choices: the same EMA-teacher masked-feature objective on static images, where the two knobs are measured — latent targets over pixel targets at +26.2 points, and the mask sampler at 34, which is the setting this page inherits at video scale without re-ablating.
- **[[wiki/entities/hit-jepa.md]]** — the complementary half of [[wiki/entities/h-jepa.md]]: this page builds one level at 1B parameters and reports autoregressive error accumulation as the failure the stack was meant to fix, while that one builds the stack at toy scale with no actions and finds its payoff is entirely under distribution shift — neither system tests the horizon differential that motivates stacking.
- **[[wiki/concepts/representational-collapse.md]]** — the scale case for sidestepping the problem by freezing: neither this nor DINO-WM trains the encoder, so neither pays the price the taxonomy prices.
- **[[wiki/concepts/manifold-untangling.md]]** — the closest system in the wiki to the biology's data source and the furthest from its objective: video time is spent on *prediction across a gap* rather than on *equivalence between neighbours*, so the identity-preserving directions are never explicitly factored out (gap `G95`).
