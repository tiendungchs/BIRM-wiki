# AdaWorld

**A world model whose action condition is not given but *induced*: a compact continuous code extracted self-supervised from every pair of consecutive video frames by an information bottleneck, then used as the universal action interface across 1016 environments — so adapting to a new environment means learning the map from its action space into an alphabet the model already speaks.**

> **Provenance.** Gao, Zhou, Du, Zhang & Gan, *AdaWorld: Learning Adaptable World Models with Latent Actions*, ICML 2025 (PMLR v267; arXiv:2503.18938v4) — `raw/gao-2025-adaworld-latent-actions.md`.

This is the wiki's first at-scale instance of **edge-label vocabulary induction** (gap G4). Everything else in the wiki that composes actions — [[wiki/entities/tolman-eichenbaum-machine.md]], the path-integration family, [[wiki/concepts/temporal-abstraction-options.md]] — is handed its action alphabet. Here the alphabet is fitted from unlabeled observation and the ground-truth action labels are only ever used, in tiny quantity, to *index into* it.

---

## Architecture

| Component | Form |
|---|---|
| **Latent action encoder** `q_φ(ã \| f_{t:t+1})` | Spatiotemporal Transformer, `L` blocks of interleaved spatial + temporal attention (rotary embeddings on the temporal axis to mark causal order); 16×16 patches from both frames plus two learnable tokens `a_{t:t+1}`; all tokens discarded except `a_{t+1}`, projected to a Gaussian posterior `(μ_ã, σ_ã)` |
| **Latent action decoder** `p_θ(f_{t+1} \| ã, f_t)` | Spatial Transformer, predicts the next frame in *pixel* space; used only to train the bottleneck, never as the world model |
| **Objective** | β-VAE: `E_q log p_θ(f_{t+1} \| ã, f_t) − β·D_KL(q_φ(ã\|f_{t:t+1}) ‖ p(ã))`, with **β = 2×10⁻⁴** |
| **World model** | Stable Video Diffusion (EDM) re-purposed to denoise **one** frame per step (frame-level control, not clip-level); `ã` concatenated to both the timestep embedding and the CLIP image embedding; last memory frame is the SVD conditioning image; up to `K = 6` history frames encoded and concatenated to the noise latent map. Loss: `E‖x₀ − x̂₀(x_t, t, c)‖²` |
| **Pretraining data** | SSv2 + Ego4D + Open X-Embodiment + MiraData, plus video auto-collected from **1016** Gym Retro and Procgen environments ≈ **2000M frames**. All compared world models trained 50K iterations |

**The load-bearing element is `β`, not the architecture.** `ã` is far smaller than a frame, so to minimise reconstruction it must carry the *dominant* variation between the two frames and drop the context — which is where the paper's claim of context-invariance comes from. The paper is explicit that this is a dial and not a free lunch: **lowering `β` makes latent actions more expressive and more mutually distinguishable while reducing action overlap across environments**, i.e. destroying the transferability that is the whole point. Expressiveness and context-invariance are traded on one scalar.

---

## The three operations the induced alphabet buys

| Operation | Mechanism | Cost |
|---|---|---|
| **Action transfer, zero training** | Encode a demonstration video into a sequence of `ã`, then roll the world model autoregressively from a *different* initial frame using that sequence as the condition | None |
| **Environment adaptation** | For `N` discrete actions, collect 100 samples each, encode, and **average** the latent codes — the average is reported to consistently denote the intended action — then use the `N` averages as the initial action embeddings and finetune 800 steps. For continuous action spaces, fit a 2-layer MLP from raw displacements to the latent-action interface (3K steps, <30 s on one GPU) | 100 samples/action, 800 steps |
| **Action composition and creation** | Average two latent codes to obtain an action that merges both functions; cluster collected codes to mint an arbitrary number of discrete controls | None — but reported qualitatively only (Fig. 5), with no metric |

---

## Results

**Action transfer** (1300 video pairs; take the action sequence from video 1, the first frame from video 2, generate 20 frames autoregressively, score against video 2). ECS = embedding cosine similarity; Human = forced-choice preference.

| Method | LIBERO FVD ↓ | ECS ↑ | Human ↑ | SSv2 FVD ↓ | ECS ↑ | Human ↑ |
|---|---|---|---|---|---|---|
| Action-agnostic (zeros as condition) | 1545.2 | 0.702 | 0% | 847.2 | 0.592 | 1% |
| Optical flow condition (UniMatch, 16×16) | 1409.5 | 0.724 | 2% | 702.8 | 0.611 | 10.5% |
| Discrete condition (VQ-8, Genie-style) | 1504.5 | 0.700 | 3.5% | 726.8 | 0.596 | 21.5% |
| **AdaWorld (continuous)** | **767.0** | **0.804** | **70.5%** | **473.4** | **0.639** | **61.5%** |

**Adaptation to four unseen environments** (800 finetune steps, 100 samples/action):

| Method | Habitat PSNR/LPIPS | Minecraft | DMLab | nuScenes (continuous) |
|---|---|---|---|---|
| Action-agnostic | 20.34 / 0.450 | 19.44 / 0.532 | 20.96 / 0.386 | 20.86 / 0.475 |
| Flow | 22.49 / 0.373 | 20.71 / 0.492 | 22.22 / 0.357 | 20.94 / 0.462 |
| Discrete VQ-8 | 23.31 / 0.342 | 21.33 / 0.465 | 22.36 / 0.349 | 21.28 / 0.450 |
| **AdaWorld** | **23.58 / 0.327** | **21.59 / 0.457** | **22.92 / 0.335** | **21.60 / 0.436** |

**Visual planning** — Procgen goal-reaching, sampling-based MPC with cross-entropy method, reward = cosine similarity of predicted observation to the goal image, 20-step budget, 30 scenes × 4 games × 5 seeds:

| Method | Heist | Jumper | Maze | CaveFlyer | Average |
|---|---|---|---|---|---|
| Random | 19.33% | 22.00% | 41.33% | 22.00% | 26.17% |
| Action-agnostic (finetuned) | 20.67% | 20.67% | 39.33% | 23.33% | **26.00%** |
| AdaWorld, **no** finetune (averaged codes only) | 38.67% | 68.00% | 41.33% | 31.33% | 44.83% |
| AdaWorld, finetuned | 66.67% | 58.67% | 68.00% | 33.33% | **56.67%** |
| Q-learning (same samples, quantised-image states) | 22.67% | 47.33% | 4.67% | 34.00% | 27.17% |
| Oracle (ground-truth simulator for MPC) | 86.67% | 77.33% | 84.67% | 74.00% | 80.67% |

On VP² robot tasks (MPPI, 1K finetune steps): aggregate normalised success **5.03** action-agnostic → **21.54** AdaWorld; Robosuite push 17.50% → 63.50%.

**Ablations.**

| Ablation | Result |
|---|---|
| Random-init control interface (vs averaged-code init) | Starts *below* the action-agnostic baseline, overtakes it after ~200 finetune steps — the pretrained interface, not the initialisation, is what transfers |
| Data mixture → Procgen PSNR/LPIPS | OpenX only 25.51/0.318 · Retro only 26.43/0.250 · **Retro+OpenX 26.62/0.234**. Real-world robot video improves latent actions for 2-D virtual games |
| Method generality (BAIR, action-conditioned) | iVideoGPT 16.59/0.220 → iVideoGPT + AdaWorld latent actions 17.40/0.204 |

**Stated limitations:** not real-time; cannot create content beyond the initial scene once the rollout leaves it; no extremely long rollouts.

---

## What this settles, and what it does not

**The action-agnostic baseline plans at chance.** 26.00% against a random planner's 26.17%. A world model pretrained on video with no action information is, for control purposes, worth exactly nothing after 800 steps of adaptation on 100 samples per action — while its PSNR (20.34 on Habitat) is only ~14% below AdaWorld's. This is the sharpest case in the wiki of the [[wiki/concepts/learned-world-models.md]] G62 problem: **the perceptual metric compresses a difference the planning metric shows as total.** The caveat is that the planning table omits the flow and discrete baselines, so the claim is licensed for action-aware vs action-agnostic and not for ranking the three action-aware variants.

**It is a real, if partial, answer to T145.** Transfer is scored by taking a code out of one video and applying it to a *different scene*, then comparing against ground truth in that scene — a test a model that had merely memorised the on-policy joint distribution cannot pass, and one where mere leakage of `f_{t+1}` through `ã` would hurt rather than help. Combined with the planning numbers, this is the wiki's best evidence that action-conditioning can be made to *mean* something. What it is not is a counterfactual test in Zhang et al. 2026's sense: every `ã` is extracted from a transition that actually occurred, so the model is never asked about an action the environment never took from that state.

**The excitation condition is met by data diversity rather than by dither.** **(brainstorm)** Gap **G63** says identifiability needs positive conditional action excitation `ρ_tr` and that improving an agent drives it to zero. AdaWorld's data-collection "policy" is the union of thousands of unrelated demonstrators across 1016 environments plus four heterogeneous human/robot video corpora — so conditional action variance is high by construction, without anyone injecting noise into a controller. That suggests a second lever on G63 the identifiability paper does not name: `ρ_tr` can be bought from *source heterogeneity* instead of from stochasticity in one agent's own policy, which is free where dither costs reward. Untested — nobody has measured `ρ_tr` on a mixed corpus, and the latent-action setting has no `a` in whose covariance to measure it.

**The action/context split is a factorisation with a knob, not a discovered one.** `β` decides how much of the frame-to-frame change counts as "action". Nothing in the objective distinguishes change the agent caused from change the environment caused: a latent action extracted from a video of falling rain encodes the rain. Iso-Dream's controllable/non-controllable split (gap G1) is the missing piece, and AdaWorld does not have it — its UMAP evidence for context-invariance is over three environments with *deliberate* discrete agent actions (Habitat, Minecraft, DMLab), which is the favourable case.

**Composition is arithmetic and unmeasured.** Averaging two codes to merge two actions is the strongest claim in the paper for [[wiki/concepts/compositionality.md]] and the least evidenced — one figure, no benchmark, no test of whether the composed action does what a human would say it should. The same averaging operation doing double duty as *within*-action denoising (100 samples → one embedding) and *across*-action composition should make one suspicious: if the mean of 100 codes for `UP` is `UP`, it is not obvious what makes the mean of `UP` and `LEFT` a diagonal rather than a blur.

**Discrete loses, and by a lot.** VQ-8 transfer (LIBERO FVD 1504.5) is barely better than no action condition at all (1545.2), against continuous 767.0 — while on unseen-environment fidelity the same discrete variant is second best and within 1% of AdaWorld. The two tables disagree about how much the codebook costs, and the resolution is presumably that 8 codes suffice to *index* a small discrete action space after finetuning but cannot *carry* an arbitrary demonstrated transition. New tension **T148**.

---

## Comparison

| | AdaWorld | Genie (VQ-8, as reimplemented here) | Optical flow condition | [[wiki/entities/h-jepa.md]] |
|---|---|---|---|---|
| Where the action comes from | Induced, continuous, `β`-bottlenecked | Induced, discrete codebook | Computed, dense 16×16 field | Given |
| Prediction space | Pixels (diffusion) | Pixels | Pixels | Representation |
| Composition | Vector average / interpolation | Codebook lookup only | None | Learned subgoal costs |
| Adapts to a new action space by | Averaging 100 encoded samples per action | Finetuning | Finetuning | n/a |

---

## Connections

- **[[wiki/concepts/learned-world-models.md]]** — the family page: AdaWorld sits in the *dynamics-model* role but attacks a variable that page's transition trichotomy holds fixed, the action condition, and supplies its sharpest G62 datum (an action-agnostic model 14% behind on PSNR and at chance on planning).
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the same carving problem with the supervision inverted: effect-equivalence types a *state* by what the agent's own actions do to it and needs an action repertoire; latent actions type a *transition* by what compresses it and need no agent at all — which is why they are cheap at scale and why they cannot separate agent-caused from world-caused change.
- **[[wiki/concepts/latent-graph-discovery.md]]** — an instance of hardness source 2 (latent edge labels) attacked directly: the induced alphabet is exactly the edge-label vocabulary the framing says must be co-discovered, obtained here without the nodes.
- **[[wiki/concepts/objective-identifiability.md]]** — `β` is that page's thesis in one scalar: the same architecture and the same data yield either expressive-but-context-bound or transferable-but-coarse action codes depending on one hyperparameter, so what the representation *is* is set by the loss, not the architecture.
- **[[wiki/concepts/compositionality.md]]** — composition by vector arithmetic in a continuous action space, offered as an alternative to composition over a symbol set; the wiki's cheapest composition mechanism and its least-tested.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — orthogonal, and worth keeping so: latent actions are one-step edge labels with no temporal extent, so they supply the *alphabet* that an options layer would need and answer nothing about how long an action lasts.
- **[[wiki/concepts/simulation-based-planning.md]]** — the downstream use: MPC with cross-entropy method over the adapted model, with the goal image supplying the cost by cosine similarity, beating a Q-table built from the identical samples 56.67% to 27.17%.
- **[[wiki/concepts/amortized-inference.md]]** — the adaptation step is amortisation of an alphabet rather than of a search: 100 samples per action compile a new environment's controls into an interface the pretrained model already understands, in 800 steps.
- **[[wiki/entities/h-jepa.md]]** — the contrast on both axes at once: predicts in pixel space where H-JEPA predicts in representation space, and *learns* its action vocabulary where H-JEPA assumes one and learns subgoal costs above it.
