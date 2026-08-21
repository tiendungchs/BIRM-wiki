# AGENT — Action, Goal, Efficiency, coNstraint, uTility

**A 3-D violation-of-expectation benchmark for the core *agent* system, whose 13 trial types are authored one-per-heuristic as controls rather than as difficulty levels — and whose supplementary table is the wiki's only direct price for the ground-truth state space that every structured theory-of-mind result is quoted on.**

> **Provenance.** Shu, Bhandwaldar, Gan, Smith, Liu, Gutfreund, Spelke, Tenenbaum & Ullman 2021, *AGENT: A Benchmark for Core Psychological Reasoning* (`raw/shu-2021-agent-psychological-reasoning-benchmark.md`), ICML, PMLR 139:9614–9625; arXiv 2102.12321v4. DARPA Machine Common Sense, MIT-IBM Watson AI Lab, NSF STC CCF-1231216. Rendered in ThreeDWorld (TDW; Gan et al. 2020). Data and video at `tshu.io/AGENT`. Sibling and concurrent with the Baby Intuitions Benchmark (BIB; Gandhi et al. 2021, primary source queued at `raw/gandhi-2021-baby-intuitions-benchmark.md`), the benchmark [[wiki/entities/hbtom.md]] and [[wiki/entities/irene.md]] are scored on.

The scientific content is the same as BIB's — infant intuitive psychology, paired expected/surprising continuations, [[wiki/concepts/violation-of-expectation.md]] scoring. Three things make it worth a page of its own:

1. **The stimuli are physically grounded 3-D scenes**, not gridworld, so agent reasoning is *entangled by construction* with the object and physics core systems. The paper's own conclusion is that the two cannot be separated: passing requires "utility computations **and** core knowledge of objects and physics".
2. **The evaluation is a 2×2 lattice of generalisation splits over the authored concept structure**, not an i.i.d. test — the same design move as [[wiki/entities/pgm.md]]'s splits over `[relation, object, attribute]` triples, arrived at independently.
3. **The perception ablation.** Every headline number is computed on ground-truth 3-D state. Re-running both baselines behind a trained derenderer moves .96 → .65 and .90 → .51 (chance). This is the measurement [[wiki/empirical-tensions.md]] T21 has been missing.

---

## Dataset

| Property | Value |
|---|---|
| Videos | 8,400 · 5.6–25.2 s · 35 fps |
| Trials | 3,360 = **1,920 train / 480 val / 960 test** (test = 480 *pairs* sharing familiarization) |
| Structure | 1+ familiarization video(s) → 1 test video, either **expected** or **surprising** |
| **Train/val contain expected test videos only** | No model can learn what a violation looks like; surprise must be derived from a predictor |
| Modalities shipped | RGB, depth, instance segmentation, camera parameters, 3-D bounding boxes, entity class (`agent` / `object` / `obstacle`), 8 colour-code identities |
| Nuisance variation | 8 floor textures, 3 background-wall textures, obstacle and shape sets |
| Shape/obstacle split | **basic set** (1,100 trials) vs **extended set** (the rest) — an unseen-shape generalisation axis on top of the concept splits |
| Agent shapes | Always sphere / cone / cube; obstacles are wall, door, ramp, platform, chasm, bridge |
| Generation | Sample a physical **scene graph** satisfying the type's constraints → instantiate in TDW → drive the agent with hand-written waypoint/action heuristics (walk, jump, climb) plus a gaze-turning motion |

The agent's motion is *scripted*, not planned by a solver — so "the agent is rational" is a property the generator enforces, and the surprising videos are authored violations of it.

---

## The four scenarios, and what each trial type controls for

Each scenario replicates an infant study; each *type* within it is a control against one specific shortcut, in the style of developmental method rather than of machine-learning difficulty tiers.

| Scenario | Infant source | Concept | Types and the heuristic each blocks |
|---|---|---|---|
| **1 · Goal Preferences** | Woodward 1998 | An agent pursues a *preferred object*, and the same preference yields different actions in a new physical layout | 1.1 equal cost in fam. and test · 1.2 equal in fam., low goal cost at test · 1.3 high goal cost in fam., equal at test · 1.4 high in fam., low at test. Varying relative cost blocks "predict whichever object is cheaper" and "predict the same *side*" (object positions swap on half the tests) |
| **2 · Action Efficiency** | Gergely et al. 1995 | A rational agent takes the cheapest path *given the current constraints*, so removing a constraint should change the path | 2.1 obstacle removed · 2.2 obstacle moved **out of the way** (blocks "obstacle present ⇒ jump") · 2.3 **smaller** obstacle (blocks "same obstacle class ⇒ same action") · 2.4 obstacle with a **door or bridge** (blocks "go over, never through") · 2.5 surprising path passes **through** the wall (blocks "straightest path is always least surprising") |
| **3 · Unobserved Constraints** | Csibra et al. 2003 | Run the efficiency assumption backwards: a costly detour behind an occluder *implies* a hidden obstacle | 3.1 occluder falls to reveal **no barrier** · 3.2 reveals a barrier that still makes the path inefficient — a small wall or a doorway (blocks "absence behind the occluder = surprise") |
| **4 · Cost-Reward Trade-offs** | Liu et al. 2017; Jara-Ettinger et al. 2016 | Utility decomposes into reward and cost, so *how much cost an agent will pay* identifies which object it prefers — even though the two objects are never seen together until test | **4 familiarization videos**: pays medium cost for object A but gives up at maximum cost; pays low cost for B but gives up at medium. Test: 4.1 equal cost to both · 4.2 the *dispreferred* object is behind the harder obstacle |

Scenario 4 is the structurally hardest: the preference is never observed as a choice, only inferred from a **revealed-preference boundary** across four episodes, and the test trial is the first time a choice is even available.

**Declared out of scope.** False belief and perceptual access. The paper's position is that this minimal set *is* core psychology in children who cannot yet pass false-belief tasks, and is the substrate the later concepts compose out of — which is also exactly the boundary [[wiki/entities/hbtom.md]] hits (MDP, not POMDP) and [[wiki/entities/autotom.md]] crosses by making the belief node searchable.

---

## Metric and human baseline

Relative surprise, after Riochet et al. 2018 (IntPhys). For a paired set of surprising ratings `{r⁺}` and expected ratings `{r⁻}` sharing familiarization:

```
accuracy = (1 / N⁺N⁻) · Σ_{i,j} 1[ r⁺_i > r⁻_j ]
```

| Human measurement | Result |
|---|---|
| 300 Amazon Mechanical Turk raters, 240 test trials (25% of the test set), 10 raters each, 0–100 surprise slider, each rater sees only one member of a pair | Mean surprising rating **> mean expected rating on every trial** ⇒ **100%** accuracy for the rater *ensemble* |
| Single rater (ratings standardised per participant) | **.91** overall (range .82–.97 by type; SD .03–.11) |

The ensemble/individual split is a usable design fact: the stimuli are unambiguous *in the aggregate*, so a model can be compared against .91 for parity and against 1.00 for the ceiling.

---

## The two baselines

### BIPaCK — Bayesian Inverse Planning and Core Knowledge

A generative model `G(S₀, Φ, Θ)` fusing an off-the-shelf physics engine with a motion planner. Entities are recreated crudely and deliberately: **all obstacles become cubes, agent and objects become spheres**, in PyBullet — a *different* engine from the one that rendered the data, so the model has no access to the generator's parameters.

| Component | Content |
|---|---|
| Physics params `Φ` | Coordinate transform, gravity (fixed 9.81), friction (searched over `{0, .05, .1, .15, .2}`), densities (fixed 1), time unit (5 ms/step). Most are mutually compensating and therefore pinned |
| Agent params `Θ = (R, w)` | Rewards `r_g ∈ (0, 100]` per goal object; cost `C(s_a, s′_a) = wᵀf = w_h f_h + w_v f_v` — a weighted sum of the **horizontal and vertical force** needed for the step. `w_h ≡ 1`, `w_v ∈ {.1, .2, .3, .5, 1.0, 10.0}` |
| Planner | RRT\* with a hand-written collision-check condition for valid expansions (may cross a wall or chasm, may land on a platform, may **not** land on a wall or in a chasm) |
| Trajectory | `Γ̂ = argmax_Γ Σ_g r_g δ(s^T_a, s_g) − Σ_t C(s^t_a, s^{t+1}_a)` |
| Likelihood | `P(Γ \| S₀, Φ, Θ) = e^{−β D(Γ, Γ̂)}`, `β = 0.2`, `D` = dynamic-time-warped Euclidean trajectory distance |
| Fitting | Uniform priors; posterior `P_train(Φ,Θ)` accumulated over **all training trajectories**, then re-weighted by the familiarization videos of the trial at hand |
| Surprise | `E_{P(Φ,Θ|X_fam,X_train)}[ D(Γ_test, G(S₀_test, Φ, Θ)) ]`, 10 sampled trajectories, 1–3 s per test video on 16 cores |
| Occlusion handling | Occluder removed from the state; the hidden segment of the trajectory filled by **2nd-order curve fitting** |

Two structural notes. Object-oriented goals are a **built-in inductive bias** — nothing else can be a goal. And `β` here is a fixed observation-noise temperature on trajectory distance, *not* the inferred per-agent rationality latent of [[wiki/entities/hbtom.md]]; rationality in BIPaCK is instead absorbed into the inferred cost weights `w`.

### ToMnet-G — graph-encoder Theory of Mind network

Rabinowitz et al. 2018's ToMnet with the state encoder replaced by a GNN over the scene.

| Stage | Content |
|---|---|
| Node input | `v_i = (x_i, a_i)`: 3-D bounding-box centre + entity class, box width/length/height, orientation, colour code |
| Encoding | `φ_v(v_i) = [φ^x_v(x_i), φ^a_v(a_i)]` (32-d each); edges `φ_e(v_i,v_j)` 64-d; **only the agent node is connected to everything else**, its edges sum-pooled, then 64-d FC |
| Character embedding | Per familiarization video → LSTM(64), last state `e^k_fam`; `e_char = Σ_k e^k_fam` (sum-pool over videos) |
| Mental-state embedding | Test-video agent embedding ⊕ `e_char` → 2×FC(64) → LSTM(64) → `e_mental` |
| Output | FC → one-step displacement `δx`, fed back into the agent node's position and **rolled out autoregressively** to the end of the test video |
| Loss | `L = (1/T) Σ_t ‖x̂_t − x_t‖²` — next-position regression, nothing else |
| Surprise | Deviation between predicted and observed trajectory |

Same shape as [[wiki/entities/irene.md]] on BIB: no goal variable, no utility, no rationality, no belief. Whatever intuitive psychology it has must live in `e_char`.

---

## Results — ground-truth state (main paper)

Pairwise accuracy. `All` = trained on everything; `G1` = leave one **type** out (trained within scenario); `G2` = leave one **scenario** out.

| | | GP 1.1 | 1.2 | 1.3 | 1.4 | **GP** | AE 2.1 | 2.2 | 2.3 | 2.4 | 2.5 | **AE** | 3.1 | 3.2 | **UC** | 4.1 | 4.2 | **CR** | **All** |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| | **Human** | .95 | .95 | .92 | .97 | .95 | .87 | .93 | .86 | .95 | .94 | .91 | .88 | .94 | .92 | .82 | .91 | .87 | **.91** |
| All | ToMnet-G | .57 | 1.0 | .67 | 1.0 | .84 | .95 | 1.0 | .95 | 1.0 | 1.0 | .98 | .93 | .87 | .89 | .82 | .97 | .89 | **.90** |
| All | BIPaCK | .97 | 1.0 | 1.0 | 1.0 | .99 | 1.0 | 1.0 | .85 | 1.0 | 1.0 | .97 | .93 | .88 | .90 | .90 | 1.0 | .95 | **.96** |
| G1 | ToMnet-G | .50 | .90 | .63 | .88 | .75 | .90 | .75 | **.45** | .90 | **.05** | .66 | .58 | .77 | .69 | **.48** | **.48** | .48 | **.65** |
| G1 | BIPaCK | .93 | 1.0 | 1.0 | 1.0 | .98 | 1.0 | 1.0 | .80 | 1.0 | 1.0 | .97 | .93 | .82 | .86 | .88 | 1.0 | .94 | **.94** |
| G2 | ToMnet-G | **.37** | .95 | .63 | .88 | .71 | **.35** | .60 | .75 | .68 | .85 | .65 | .63 | .80 | .73 | .55 | .95 | .75 | **.71** |
| G2 | BIPaCK | .93 | 1.0 | 1.0 | 1.0 | .98 | 1.0 | 1.0 | .75 | 1.0 | .95 | .95 | .88 | .85 | .87 | .83 | 1.0 | .92 | **.94** |

Two further splits, reported as heatmaps: **G3** train on one type → test the rest of its scenario; **G4** train on one scenario → test the other three. Same ordering.

**The .90 vs .91 trap.** ToMnet-G's aggregate on seen types is at the single-human level. It is not doing the task:

- **Per-type correlation with human accuracy: BIPaCK 0.55, ToMnet-G 0.06.** Equal aggregate, orthogonal profile.
- Type 1.1 (.57) vs 1.2 (1.0) with the same concept: in 1.2/1.4 the agent always walks away from an object it would have to pay for, so "predict departure when a high-cost obstacle is present" solves the type without any preference inference — the exact heuristic 1.1/1.3 exist to catch.
- Type 2.5 falls to **.05** under leave-one-type-out — far below chance, i.e. the learned rule is *anti*-correlated with solidity. The prediction network happily routes the agent **through solid walls** (paper's Fig. 6ABDH), predicts unnecessary jumps when the obstacle is out of the way (2.2), and selects no goal or the wrong goal.
- Cost-Reward drops to .48 under both G1 and G2 — chance on the one scenario that needs a latent assembled across four episodes.

BIPaCK's one real weakness is **Type 2.3**, where a mis-estimated `w_v` makes walking around a small wall look cheaper than hopping over it. Its familiarization update is load-bearing but not dominant: dropping the per-trial posterior re-weighting (Eq. 4) costs a further **10–15%**.

**Unseen shapes and obstacles** (train on the basic set, test on the extended set, ground-truth boxes still given): BIPaCK **.95**, ToMnet-G **.57**. BIPaCK's shape encoding is fixed by fiat (everything is a sphere or a cube), so novel geometry is invisible to it — which is a cheap trick and also precisely the point: an abstraction over shape *is* what generalisation to a new shape requires.

---

## Results — behind a derenderer (supplementary Table 2)

The perception front-end: Mask R-CNN (ImageNet-pretrained, finetuned on ground-truth masks, 11 labels = agent + obstacle + occluder + 8 colour identities) → per-mask ResNet-34 → FC(256) → FC(15) predicting the entity's 3-D box and the camera parameters. 36k training frames, 14k validation frames.

| Method | GP | AE | UC | CR | **All** |
|---|---|---|---|---|---|
| ToMnet-G | .54 | .52 | .43 | .53 | **.51** |
| BIPaCK | .73 | .63 | .55 | .69 | **.65** |
| *(ground truth, same models)* | *.84 / .99* | *.98 / .97* | *.89 / .90* | *.89 / .95* | *.90 / .96* |

Mean 3-D bounding-box IoU (Intersection over Union) against ground truth: **0.07 (SD 0.11)**, from bad centre and orientation estimates.

**This is the number the wiki has been missing.** Read three ways:

| Reading | Statement |
|---|---|
| **T21, priced** | The structured model's advantage over the neural one *survives* the loss of ground-truth state (.65 vs .51), but **two-thirds of its margin over chance does not**. The claim "structured priors beat minimal-bias learners on infant intuitions" is demonstrated at .96 only in a setting where perception is solved by fiat |
| **Against the perception excuse** | The derendered column is not a model-quality argument on ToMnet-G's behalf: it goes *to chance everywhere*, including the types it scored 1.0 on with clean state. Its .90 was an inference over exact coordinates, not over a scene |
| **The composition failure is the finding** | Both baselines are modular — perception feeds a fixed reasoner — and neither is robust to the interface degrading. An IoU of 0.07 is not a small error; nothing downstream re-estimates the state using what the agent model implies about it. **(brainstorm)** A generative model that already has a physics engine and a planner *could* close the loop and treat the derenderer output as a noisy observation to be filtered by the plan hypothesis, which is what the "one program, three query types" property of [[wiki/concepts/simulation-based-planning.md]] licenses and what nobody here runs |

The authors also state plainly that **training from scratch on AGENT alone will not work**, and prescribe a modular or finetuning paradigm — a benchmark declaring at publication that it is not a training set.

---

## Comparison — AGENT vs BIB

Stated by the authors, since the two are concurrent and overlap conceptually.

| | **AGENT** | **BIB** ([[wiki/entities/hbtom.md]], [[wiki/entities/irene.md]]) |
|---|---|---|
| Concepts | Goals, preferences, actions, **unobserved constraints**, **cost-reward trade-offs** | Goals, preferences, actions, **instrumentality** (fetch key → unlock → reach goal) |
| Physics | Ramps, platforms, doors, bridges, chasms, walls; 3-D, gravity, jumping | Gridworld mazes with walls |
| Familiarization | 1 video (Sc. 1–3), **4 videos** (Sc. 4) | 8 trials |
| Question asked | Does the concept **generalise** across physical configurations and across scenarios? | Can the concept be **learned at all** from one large training set? |
| Baseline inputs | Ground truth **and** a trained derenderer | Pixels, or symbolic JSON |

They are complementary instruments and a model should be run on both: BIB tests acquisition, AGENT tests transfer.

---

## What it is evidence for

| Claim | Strength |
|---|---|
| **An authored planning model transfers across concept splits and a learned trajectory predictor does not** | Strong on clean state: BIPaCK .96 → .94 → .94 across `All`/G1/G2, ToMnet-G .90 → .65 → .71 |
| **Aggregate accuracy is uninformative about mechanism** | Strong, and cheaply measured: .90 vs .91 at a per-type human correlation of 0.06 |
| **Agent reasoning cannot be separated from object and physics knowledge** | Strong by construction *and* by failure mode — ToMnet-G's errors are physics violations (through-wall paths), not goal errors |
| **Structured models are the way forward** | **Weak once perception is included.** .65 with a derenderer, on the authors' own numbers, and no model here is above .73 on any scenario |
| **The heuristic controls work** | Strong: every control type produced a measurable drop somewhere (2.5 → .05, 1.1 → .57, 2.3 → .80 for BIPaCK) |

---

## Open problems

- **Nobody has run a model that perceives and reasons jointly.** The stated open question — "whether we can learn generalizable inverse graphics and physics simulators" — is [[wiki/concepts/latent-graph-discovery.md]] restated as an engineering bottleneck; the derenderer result says the bottleneck is currently the whole difficulty.
- **The generator is not a planner.** Agent motion is scripted from waypoint heuristics, so "efficient" means "efficient by the generator's hand-written definition". BIPaCK's RRT\* is a *different* efficiency notion, and its Type 2.3 failure is exactly a disagreement between the two. No test tells apart "the model is wrong" from "the generator's notion of cost is idiosyncratic".
- **No untrained-network null** ([[wiki/concepts/violation-of-expectation.md]]). Chance is asserted as .50 for a pairwise metric on stimuli whose two members differ in low-level statistics; the random-init control that would make .51 interpretable was not run.
- **Release did not follow the paper.** Bortoletto et al. 2023 ([[wiki/entities/irene.md]]) report that they could not evaluate on AGENT because neither code nor data was available, and that re-implementation from the paper failed — despite the "we plan to release" commitment here. One reason the two sibling benchmarks have almost no models in common.
- **Nothing acts.** Every model is a passive rater. Cost-reward inference in infants is tested by looking time, but the competence it is a proxy for is *used* in choosing how to act.
- **The `Θ` grid is small and hand-chosen.** Six cost weights and a fixed horizontal weight; whether the model's transfer is a property of inverse planning or of a well-chosen 6-point grid is not ablated.

---

## Connections

- **[[wiki/entities/hbtom.md]]** — the sibling result on the sibling benchmark, and the one this page prices: HBToM's 96–99.7 is quoted on noise-free symbolic state, and the closest available estimate of what that is worth is BIPaCK's .96 → .65 when the same class of model is put behind a trained derenderer.
- **[[wiki/entities/irene.md]]** — the *other* control on the same question, pulling the other way: matching the **symbolic** input leaves the structured model's advantage largely intact, while matching the **perceptual** input removes most of it, so "matched inputs" names two different experiments with two different answers.
- **[[wiki/entities/autotom.md]]** — the successor that removes this page's fixed agent model: BIPaCK's `(R, w)` are the only latents and their factorisation is authored, whereas AutoToM searches which mental variables to instantiate per query — including the belief node both this benchmark and its baselines declare out of scope.
- **[[wiki/concepts/core-knowledge.md]]** — the agent system's second machine battery, and the one designed so that the agent system cannot be tested in isolation from the object system; its failure modes (predicted paths through solid walls) are object-system failures showing up on an agent-system score.
- **[[wiki/concepts/violation-of-expectation.md]]** — a second large deployment of the protocol with two properties the wiki's other instances lack: an ensemble-of-raters ceiling at 100% alongside a single-rater baseline at .91, and a *per-type correlation against the human profile* as a second read-out on top of the accuracy.
- **[[wiki/concepts/shortcut-learning.md]]** — the clean case of Morgan's Canon: a model at the single-human aggregate (.90 vs .91) whose per-type profile correlates 0.06 with the human one and which scores .05 — anti-correlated — on the type authored to catch it.
- **[[wiki/concepts/simulation-based-planning.md]]** — inverse planning instantiated over *continuous 3-D physics with forces* rather than a gridworld MDP: the cost function is a weighted sum of the horizontal and vertical force a step requires, so utility is grounded in the same simulator that supplies the dynamics.
- **[[wiki/entities/pgm.md]]** — the same evaluation design in the abstract-reasoning domain: declare the concept structure explicitly, then split train from test *over the structure* (types, scenarios) instead of over the inputs, and report the held-out cell rather than an i.i.d. number.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the benchmark's own generator is a **physical scene graph** sampled per trial, and the task is to infer the two latents left off it (which object is rewarded, what the agent's cost weights are) while everything else about the graph is visible; the derenderer result says recovering even the *visible* part from pixels is currently the hard step.
- **[[wiki/concepts/learned-world-models.md]]** — the negative datum for trajectory-prediction-as-world-model: a next-position regressor trained to convergence predicts motion through solid obstacles, so the training objective does not install the constraint even when every training trajectory obeys it.
- **[[wiki/entities/conceptarc.md]]** — the same measurement philosophy in a different domain: many easy instantiations per concept, scored per concept, with the aggregate treated as the least informative summary.
