# The Multiscale Tracing Network — a Parser Trained by Reward Alone, With a Reaction-Time Curve

**Two segregated populations over four spatial scales: a frozen feedforward group that decides *where grouping is permitted*, and a recurrent group of pyramidal cells plus VIP (Vasoactive Intestinal Peptide-expressing) and SOM (Somatostatin-expressing) interneurons that spreads an attentional tag through the permitted region. Only the second is trained, by a local three-phase reinforcement rule whose only signal is a binary reward on an eye movement. It learns to trace curves 4× longer than any it was trained on, transfers to 2-D object parsing in under 100 trials, and its timestep count — not an added read-out — predicts human reaction times.**

> **Provenance.** Mollard, Bohte & Roelfsema 2026, *How the visual brain can learn to parse images using a multiscale, incremental grouping process*, PLoS Comput. Biol. 22(4):e1014193 (`raw/mollard-2026-multiscale-incremental-grouping.md`). Code at `github.com/samimol/multiscale_tracing`. The mechanism page is [[wiki/concepts/incremental-grouping.md]]. Clip is complete prose; the displayed equations did not survive (LaTeX images), so every formal statement below is reconstructed from the surrounding text and marked where it is.

---

## Architecture

| Component | Specification |
|---|---|
| Input | RGB image, `108 × 108` (also tested at `144 × 144` curves, `594 × 594` objects — **no fine-tuning needed**, weight sharing carries it) |
| Scales | **4**, each with larger receptive fields and coarser spatial sampling (`l = 1` has 1 feature channel; `l ≥ 2` have 6) |
| **Feedforward group** | `1 × 1` convolution to one shared feature map → per scale, a 20-map convolution (`RF = K`, stride 1) → a second convolution (`RF = K`, stride `K`) → sigmoid. Each scale has its **own loss** and gets gradient only from it; the shared `1 × 1` projection gets all of them |
| Feedforward role | Veridical representation + **scale selection**; its output *gates* the recurrent units by Hadamard product, so no tag can spread where it is inactive |
| **Recurrent group** | Per hidden layer: pyramidal units, VIP interneurons, SOM interneurons. VIP driven by feedback (transposed convolution, stride 3, spatially aligned receptive fields only) and horizontal input (stride 1, **von Neumann 4-neighbourhood**). SOM `= 1 − VIP`, clipped. SOM inhibits pyramidal locally (`3 × 3` kernel, single non-zero centre — no spatial mixing) |
| Input layer | A **blackboard**: pyramidal units there receive *no* feedforward drive, only top-down feedback gated by the sensory image, which weights the colour channels while the image fixes the spatial structure |
| Output | Selects a blue pixel as an eye-movement target; reward if it is on the cued object |
| Convergence | Activity unchanged between consecutive timesteps, or 30 timesteps, whichever first |

**The gate is the architectural claim.** Grouping permission is a *separate, non-participating* population — which the authors match to cortical layers 4 and 6 (veridical, no incremental grouping) against layers 2, 3 and 5 (grouping). A boundary is the absence of a permission, not the presence of an edge feature.

---

## Training

| Stage | Method | Data / budget |
|---|---|---|
| Feedforward | **Supervised backpropagation**, Adam, `lr = 10⁻³`, 80 epochs, per-scale cross-entropy summed across scales | 50,000 stimuli (curve tracing: *are all pixels in this receptive field collinear and connected?*); 10,000 (object parsing: *is this receptive field boundary-free?*). Then **frozen** |
| Recurrent | **RELEARNN** — three phases: (1) settle to a fixed point; (2) select an action, propagate an attentional feedback signal through a linearised, transposed accessory network, giving each unit's influence on the chosen action; (3) reward `r ∈ {0,1}`, compute `δ = r − Q_a`, broadcast `δ` neuromodulatorily. Update uses `δ` × attentional feedback × pre- and post-synaptic activity — all locally available | Curriculum: curves of 3 px, +1 px each time test accuracy reaches 85%, up to 7 px. **~23,200 trials** to convergence, 5 networks |

The reward is the *only* teaching signal reaching the recurrent group — no segmentation mask, no target activity pattern, no curve label. Weight sharing is used for compute and is flagged as biologically implausible; prior work with the same structure and no sharing needed **~7× more trials**.

---

## Key results

| Result | Number |
|---|---|
| Curve tracing, training regime (≤7 px) | **100%** on all 5 networks (criterion was 85%) |
| **Length generalisation** — 15 unseen curves of **30 px** | **100%** |
| Transfer to 2-D object parsing (recurrent weights retrained by the same reward rule; new feedforward net) | **>85% within 100 trials**, all 5 networks |
| Curve tracing after that transfer | Still **100%** — one recurrent circuit serves both tasks |
| Bottleneck effect | Narrowing the gap between target and distractor delays the response enhancement **only for receptive fields beyond the bottleneck** — matching monkey V1 (Pooresmaeili et al. 2014) |
| Scale policy (emergent, never supervised) | Large gap → large receptive fields, fast; small gap or high curvature → drops to a lower layer, slow |
| Human RT fit, scrambled shapes (Jeurissen et al., 20 images × 3 cues) | `R² = 0.55` — against growth-cone heuristic `0.63`, **noise ceiling `0.67`**, hGRU `0.21` |
| Human RT fit, COCO object masks (Adeli et al., 255 images × 2 cues) | `R² = 0.15` — growth-cone `0.16`, **noise ceiling `0.24`**, hGRU `0.07` |
| Scale-count ablation | 4 scales beat 3 (`p = 0.03`) and 2 (`p < 10⁻³`) |
| Disinhibition ablation | Excitatory recurrence with `ReLU`: unstable, no fixed point. With a squashing nonlinearity: stable but the tag **attenuates along the curve**, so length generalisation is lost. Disinhibition keeps the target–distractor difference constant |

**Two of these are unusual enough to name.** *Length generalisation from a 7-px curriculum to a 30-px test at 100%* is a compositional-generalisation result obtained without any compositional machinery — it follows from the fixed point being distance-independent, which follows from the inhibitory motif. And *the RT prediction is read off the model's own dynamics* (the timestep at which the output unit over the cued pixel reaches 90% of maximum), where the competing hGRU models had to convert an uncertainty measure into an RT by a fitted transform and scored 2–3× worse.

---

## Limitations

- **The grouping criterion is supervised and frozen.** "Collinear and connected", "boundary-free" are labels the designers wrote. What the reward teaches is the *routine*, not the criterion. The wave note that filed this source called it "a parser whose grouping criterion is learned" — that is an overstatement, and the distinction is the whole of `T151`'s fourth stance. It is also why this model does not close `G75`: there is one parse, chosen by the designers before any task is seen, and the reward only teaches how to execute it.
- **Joint training failed.** The authors tried; an earlier **single-scale** version of this architecture trained end-to-end, and the multiscale version "did not consistently elicit grouping across all scales", though some disinhibitory propagation emerged. They name regularisation, curriculum and architecture as untried repairs. So the two-stage pipeline is a workaround, not a commitment, and the developmental evidence (collinearity sensitivity matures into late childhood) argues against it.
- **Stimuli are toy by construction.** Filled homogeneous masks on empty backgrounds; the COCO condition presented *object masks*, not images. Natural-image parsing is conceded to depend on recognition (upright images parse faster than inverted ones) and is not modelled.
- **Only four Gestalt cues total, and only two implemented.** Motion, colour and luminance similarity are absent.
- **Binary query only.** The output is "which of two blue pixels is on the cued object". No count, no partition, no object variable, nothing a planner can bind to.
- **Weight sharing** is biologically implausible and is used throughout; the scale-invariance to `594 × 594` inputs is partly a consequence of it.
- **Five networks, near-zero variance** between them (the paper notes the absence of error bars in the latency figure) — impressive for reproducibility, but it also means the ablations are single-architecture comparisons, not a search.

---

## Comparison

| | This model | [[wiki/entities/spelkenet.md]] | Slot architectures (`T151` position A) | [[wiki/entities/arc-vsa-solver.md]] |
|---|---|---|---|---|
| Where objects live | A transient activity tag on the base representation | A statistic of sampled counterfactual rollouts | A fixed number `K` of latent slots | One of six enumerated parse hypotheses |
| Parse is | Per query (one seed, one component) | Per input (whole partition) | Per input (all slots at once) | Per task, from a menu |
| Part count | Never represented | Emergent from clustering | Fixed at design time | Fixed by the hypothesis |
| Training signal | Binary reward on an action | Self-supervised flow completion | Reconstruction / contrast | None — search |
| Cost | Timesteps ∝ traversal distance, scale-adapted | `R × T` full rollouts per segment | One forward pass | Search over 6 × rules |
| Delivers a bindable variable | **No** | No | Yes | Yes |
| Predicts a human reaction time | **Yes, natively** | No | No | No |
| Scales to real images | No | Yes | Reported not to | n/a (grids) |

The row that matters is the last three together: this is the only entry that pays in a currency biology also pays in, and the only one that cannot hand a downstream reasoner an object.

---

## Connections

- **[[wiki/concepts/incremental-grouping.md]]** — the mechanism this page instantiates, with the base-vs-incremental split, the growth-cone scale policy and the cost-curve argument stated independently of this implementation.
- **[[wiki/concepts/visual-routines.md]]** — the first working implementation of two of that page's five elemental operations (bounded activation, boundary tracing), learned rather than hand-built, and the resolution of its one unresolved empirical failure: the multiscale hierarchy is why grouping time does not scale with figure size. What it does **not** supply is the assembly mechanism — there is exactly one routine here, and it is not composed.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — RELEARNN is a worked, non-toy application of the attention-gated reinforcement-learning family that page lists with *unknown* bias and variance: three phases, a linearised transposed accessory network for structural credit, a broadcast reward-prediction error for temporal credit, and a task that requires a stable fixed point, which is why the architecture had to be disinhibitory.
- **[[wiki/concepts/curriculum-learning.md]]** — a curriculum with a *competence-triggered* step (85% test accuracy, then +1 pixel) rather than a fixed schedule, over a difficulty axis that is also the generalisation axis, and it works far outside its support: 7 px trained, 30 px at 100%.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the VIP⊣SOM⊣pyramidal motif used as the *carrier* of a computation rather than as a gate on one, with an ablation that prices it: replacing the detour with direct excitation costs either stability or length generalisation.
- **[[wiki/concepts/adaptive-computation-time.md]]** — a variable step count set by stimulus geometry and validated against a human reaction-time distribution, which is the external cost curve that page's learned halting units have never had.
- **[[wiki/entities/early-visual-system.md]]** — the model's target tissue and its strongest commitment about it: two segregated populations in one area, one veridical (layers 4, 6) and one modulatory (layers 2, 3, 5), with the second gated by the first.
- **[[wiki/entities/dorsal-visual-stream.md]]** — the loop this model's front end is half of: the tag is written in early visual cortex and the same-object judgement it supports is parieto-prefrontal traffic, which the model replaces with a direct read-out of one output unit.
- **[[wiki/entities/spelkenet.md]]** — the opposite answer on `T151`'s question: objectness as a property of a query-time flood through a small recurrent circuit, versus objectness as a clustered statistic over counterfactual rollouts in a 7B model — the first is cheap, human-timed and returns one component, the second is expensive, timeless and returns a partition.
- **[[wiki/concepts/visual-indices.md]]** — the two mechanisms a relational predicate needs and neither supplies alone: indices give `n` individuals with identity and no content, this gives content-free *sameness* over locations with no individuals — and nothing in the wiki binds one to the other.
- **[[wiki/concepts/attention.md]]** — object-based attention as this page's trained behaviour, with the seed injection as selection and the spread as the object-based part, measured in timesteps rather than asserted.
