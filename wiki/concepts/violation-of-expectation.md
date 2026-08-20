# Violation of Expectation

**Show one history, then two continuations differing only in the property under test, and score whether the model rates the intended one as less surprising — a relative judgement between two futures of an identical past, needing no labels, no distribution shift and no absolute calibration.**

The wiki has been using this protocol since [[wiki/entities/hbtom.md]] and scoring models with it on [[wiki/entities/irene.md]] and [[wiki/entities/lewm.md]], without a page stating what it measures. It is gap **G17**'s sixth instrument and the only one in that list that can register a model scoring *below* chance — i.e. having acquired the opposite rule.

> **Provenance.** Primary: **Garrido et al. 2025**, *Intuitive physics understanding emerges from self-supervised pretraining on natural videos* (`raw/garrido-2025-intuitive-physics-v-jepa.md`), FAIR at Meta / EHESS-ENS-PSL / Inria — the most methodologically careful machine VoE study in the wiki, and the one that supplies the missing null baseline. Secondary: Bortoletto et al. 2023 ([[wiki/entities/irene.md]]) for the free-parameter problem, Maes et al. 2026 ([[wiki/entities/lewm.md]]) for the paired-perturbation variant, Riochet et al. 2022 (IntPhys), Jassim et al. 2024 (GRASP), Weihs et al. 2022 (InfLevel) for the benchmarks. Developmental origin: Baillargeon et al. 1985; Spelke 1985.

---

## The protocol

| | **Infant version** | **Machine version** |
|---|---|---|
| Stimulus | Two scenes identical in objects, count, occluders — one containing a physical impossibility | Same, generated synthetically or filmed |
| Response measured | Looking time / gaze duration | A scalar **surprise** derived from the model's own predictions |
| Decision | Longer look ⟹ violation detected | Higher surprise on the impossible member ⟹ correct |
| Prior control | Habituation trials, to discount perceptual preference | **Randomly-initialised networks** (see below) |

The machine surprise in the latent-prediction case, and the reason a JEPA can be scored with no adaptation at all:

```
s_t = d( P_φ( E_θ(x_{t−M..t}) ) ,  E_θ(x_{t+1..t+N}) )        # prediction error in representation space
score(video) = agg_t s_t ,   agg ∈ {max_t, mean_t}
correct(pair) = 1[ score(impossible) > score(possible) ]
```

Two structural points. (i) The encoder and predictor are used **frozen and unadapted** — no probe is fitted, no label is seen, so decoder capacity cannot manufacture the result (contrast every row of [[wiki/concepts/representation-probing.md]]). (ii) V-JEPA is *never trained on causal prediction* — its pretraining masks a spatial block for the whole clip — yet is evaluated causally (past → future). The protocol therefore also tests whether a non-causal training task leaves a usable causal predictor behind; it does.

---

## The free parameters, and which of them Garrido et al. close

The instrument's defect, recorded as [[wiki/empirical-tensions.md]] **T146**: the score is not fixed by the protocol.

| Free parameter | Effect when varied | Status |
|---|---|---|
| **Error statistic** `max_t` vs `mean_t` | Moves IRENE's Blocking Barrier 83.5 → 99.4 and its Multi-Agent 74.9 → 63.6; rival groups justify opposite choices | Still open. Garrido et al. state the choice explicitly (`max` for single-video classification, generalises better; the pairwise numbers use the same statistic throughout) rather than defending it |
| **Context length `M`** and **framerate** | Set per property, "as the one maximising performance", for *every* model including the baselines | Open, and now explicit: the reported numbers are best-achievable-per-model, not fixed-protocol |
| **Which subtasks are averaged** | Two of three BIB Instrumental subtasks are heuristic-solvable, so the average ranks the barrier-ignorant model above the barrier-aware one | **Closed by practice here**: results are reported per property with per-property significance tests, never as one number |
| **Low-level dataset bias** | A benchmark can be solvable from statistics that have nothing to do with the concept named | **Closed**: `n = 20` randomly-initialised networks are run through the identical pipeline and the reported quantity is the *gain over that null*, per property (two-sample one-tailed Welch's t-test, Hedges' `g` with CIs) |

**The random-init null is the transferable methodological result.** It is the machine analogue of habituation trials, it costs one forward pass per untrained seed, and it converts "78% on benchmark B" — uninterpretable, because chance is not 50% when the stimulus pairs differ in pixel statistics — into an effect size against a control that shares the architecture, the input pipeline and the surprise metric while sharing none of the learning. Every VoE number in the wiki that lacks it is quoting an unknown baseline. **(brainstorm)** The same null generalises past VoE: any protocol scoring a *trained* model with a fixed read-out can be re-run on untrained seeds, and the difference is the only part attributable to training.

---

## What it has measured: models

Pairwise accuracy (which of the two is impossible), best context per property, chance = 50%.

| Model | Class | IntPhys | GRASP | InfLevel-lab |
|---|---|---|---|---|
| **V-JEPA** (ViT-H, VideoMix2M) | prediction in **learned representation space** | **98%** [95, 99] | **66%** [64, 68] | **62%** [60, 63] |
| VideoMAEv2 | prediction in **pixel space** | ≈ untrained | ≈ untrained | ≈ untrained |
| Qwen2-VL-7B | multimodal LLM (no video-prediction objective) | ≈ untrained | ≈ untrained | ≈ untrained |
| Gemini 1.5 pro | multimodal LLM, closed | ≈ untrained | ≈ untrained | ≈ untrained |
| Randomly-initialised V-JEPA (`n = 20`) | none | ~50–55 | ~54–58 | ~52 |

V-JEPA is the only method significantly above the untrained null on **all three** datasets. The MLLMs are scored differently (shown both videos, asked which is impossible) because a text-output model has no surprise trace — so the comparison is system-level, not objective-level.

**This is the wiki's sharpest evidence for predicting in representation space rather than pixels**, and unlike [[wiki/entities/v-jepa-2.md]]'s planning-latency argument it is not a compute argument: VideoMAEv2 has the same predictive form and the same evaluation and sits at chance. The standing caveat holds — the two differ in data and masking as well as prediction space, and no ablation swaps the prediction space alone.

---

## What it has measured: properties

V-JEPA ViT-L on HowTo100M, `n = 5` seeds against `n = 20` untrained, Welch's t-test, Hedges' `g`.

| Property | Dataset | V-JEPA (M ± SD) | Untrained | `g` |
|---|---|---|---|---|
| Object permanence | IntPhys | 85.7 ± 7.6 | 51.4 ± 1.0 | **9.0** |
| Continuity | IntPhys | 86.3 ± 6.2 | 51.2 ± 1.2 | **11.0** |
| Shape constancy | IntPhys | 83.7 ± 7.8 | 51.7 ± 1.2 | **8.1** |
| Support | GRASP | 98.1 ± 3.0 | 58.4 ± 10.5 | 3.9 |
| Gravity | GRASP | 74.9 ± 2.4 | 55.3 ± 4.3 | 4.5 |
| Object permanence | GRASP | 70.7 ± 7.8 | 54.1 ± 5.9 | 2.4 |
| Continuity | GRASP | 65.0 ± 6.1 | 55.0 ± 5.0 | 1.8 |
| Inertia | GRASP | 62.0 ± 2.4 | 54.3 ± 4.2 | 1.8 |
| Object permanence | InfLevel | 72.1 ± 2.9 | 52.5 ± 3.5 | 5.4 |
| **Colour constancy** | GRASP | — | — | **n.s.** |
| **Solidity** | GRASP, InfLevel | — | — | **n.s.** |
| **Collision** | GRASP | — | — | **n.s.** |
| **Gravity** | InfLevel | — | — | **n.s.** |

The profile is sharp and it is not an accuracy gradient:

- **Properties intrinsic to a single object** (permanence, continuity, shape) — large effects, `g` 8–11 on IntPhys.
- **Properties of an object against a static world** (support, gravity, inertia) — moderate, and gravity passes on GRASP while failing on InfLevel, where the relevant fact (whether the container is open or closed) is established by a **contextualising event earlier than the model's 3–4 s window**.
- **Properties of object–object interaction** (solidity, collision) — at chance.
- **Colour constancy** — at chance, in a model whose surprise otherwise works.

Two of these have a stated mechanical explanation (memory window, framerate) and two do not. The authors' own hypotheses: interactions are rare in the training distribution; interactions may need higher-order representations that one JEPA level cannot form; interactions may need *acting* on objects rather than watching them.

---

## Against humans

IntPhys private test set, human data from Riochet et al. 2022 (Mechanical Turk), V-JEPA ViT-H on VideoMix2M, `max_t` surprise.

- V-JEPA is **equal or better than naive humans on every property**.
- Both drop when the physics-breaking event happens **behind an occluder**, and the two error patterns are well correlated in the occluded conditions.

The correlated failure is the more interesting half. **(brainstorm)** A shared failure profile between a human and a model that shares none of the human's priors is exactly what [[wiki/concepts/core-knowledge.md]]'s signature-limit criterion was supposed to rule out — see [[wiki/empirical-tensions.md]] **T161**.

**An independent replication of the null, on a different model class and a different question format** (Jassim et al., cited in Bordes et al. 2024, [[wiki/concepts/cross-modal-grounding.md]]). Synthetic videos are generated to obey or violate physics — a ball that vanishes breaks spatio-temporal continuity — and the model is *asked in language* whether the trajectory is lawful. VideoLLaMA and PandaGPT do not exceed random performance; humans exceed 80%. Two things this adds to the table above: the multimodal-LLM null is not an artefact of the surprise-based scoring (here the read-out is a verbal answer, not a `max_t` statistic), and the human ceiling is supplied by the same design rather than imported from another study.

---

## Robustness of the emergence: three ablations

All V-JEPA variants stay significantly above the untrained null.

| Lever | Range tested | Effect on IntPhys |
|---|---|---|
| **Pretraining task** | Block masking / Block + Causal / Random pixel masking | All work. Random masking costs ~5 points, against a ~20-point cost on video *classification* — so the objective detail matters far less here than for the task V-JEPA was designed for. **Causal Block masking is worse than Block**, despite matching the causal setup used at test time |
| **Data** | SSv2 (fine-grained motion) / K710 (actions) / HowTo100M (tutorials); then HowTo subsampled 100% → 0.1% at **fixed compute** (always 30 years of video processed) | SSv2 alone ≈ chance; K710 above chance; HowTo best. **Dataset size barely matters: 128 h of unique video keeps >70% pairwise accuracy on every property.** So the relevant variable is the *distribution* — what appears in the videos — not the quantity |
| **Encoder size** | 115M → ViT-H | Larger is better, but **115M already exceeds 85%** |

The 128-hour result is the one with consequences elsewhere: at fixed compute, an intuitive-physics-capable video predictor needs roughly an infant's-worth of unique visual experience and a great deal of revisiting it — which is the shape of [[wiki/concepts/offline-replay.md]]'s bargain, arriving from the data side.

---

## What the protocol certifies, and what it does not

| Certifies | Does not certify |
|---|---|
| A *relative* preference between two futures of an identical past, with no labels and no shift | That the preference is computed by the mechanism whose name is on the axis. Nothing here localises the surprise to an object representation, and no intervention is run |
| A **below-chance** result, i.e. the opposite rule acquired (26.3% on BIB Preference) — no other G17 instrument can | That the pair isolates the property. The pair is hand-authored, so the instrument inherits G17's developer-awareness problem wholesale |
| A **dissociation** between perturbation types on the same trace (physical vs visual, [[wiki/entities/lewm.md]]) — the cheap repair for T146 | An absolute capability level. `agg`, `M` and framerate are tuned per model per property |
| Gain over a **matched untrained null**, which is what makes a benchmark's low-level bias subtractable | That the ability transfers to control. Surprise is a read-out; nothing in the protocol requires the model to *act* on the violation |

---

## Applying it to build a reasoning model

- **Use it as a training-time monitor, not only an evaluation.** The surprise trace is temporally aligned and needs no labels, so it is available at every step of self-supervised pretraining. The unmeasured question the ablations make obvious: does the property ordering (intrinsic → static-world → interaction) appear *over training* in that order, which is the falsifiable half of [[wiki/entities/h-jepa.md]]'s developmental table?
- **Surprise is the natural trigger for a write.** A spike in `s_t` is a label-free event boundary and a label-free novelty signal at once — the quantity [[wiki/concepts/event-segmentation.md]] segments on and the one [[wiki/concepts/memory-allocation-excitability.md]] would allocate on.
- **Always run the untrained null.** One extra column, and without it no VoE number in the wiki is interpretable.
- **Report per property with effect sizes.** The aggregate hides the only structurally informative thing the instrument produces, which is the failure profile.

---

## Connections

- **[[wiki/concepts/core-knowledge.md]]** — the protocol is imported wholesale from that page's own developmental literature, and now returns a result against it: a model with no installed prior passes the object-system probes, so VoE certifies the *competence* and is silent about its origin.
- **[[wiki/entities/h-jepa.md]]** — supplies the first quantitative test of that page's level-by-level developmental ordering: object permanence and continuity easy, gravity and inertia harder, collision at chance, in exactly the predicted sequence, though measured as a difficulty ordering rather than an acquisition-over-training one.
- **[[wiki/entities/v-jepa-2.md]]** — the same architecture one generation later; this page holds the intuitive-physics evidence for the objective, that page holds the control and scaling evidence, and neither ablates the prediction space in isolation.
- **[[wiki/entities/lewm.md]]** — the paired-perturbation variant (physical vs visual on one trace) and the strongest available test of this page's colour result: two independent latent world models, 15M and 300M+, both surprised by teleportation and both blind to colour change.
- **[[wiki/entities/irene.md]]** — where the free-parameter problem was found: the same instrument on the agent domain, with `max_t`/`mean_t` swinging a single model by 16 points.
- **[[wiki/entities/hbtom.md]]** — the wiki's first use of the protocol, and the source of its listing as G17's sixth instrument.
- **[[wiki/concepts/representation-probing.md]]** — the complementary instrument: probing asks whether a structure is *inside* and needs ground-truth labels to ask; VoE asks whether the model's own predictions rank two futures correctly and needs none. A model can pass either and fail the other.
- **[[wiki/concepts/shortcut-learning.md]]** — the random-init null is a shortcut control: it measures how much of a benchmark is solvable from low-level statistics before any learning, which is the quantity every "architecture X reasons" claim needs subtracted.
- **[[wiki/concepts/learned-world-models.md]]** — supplies that page's decoder question with its non-control evidence: at equal evaluation, a pixel-space predictor scores at the untrained null where a representation-space predictor scores 98%.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — surprise here is literally prediction error at one level of an abstraction hierarchy, so a VoE score is a direct behavioural read-out of the quantity that framework makes central.
- **[[wiki/concepts/event-segmentation.md]]** — the same scalar under a different use: a prediction-error spike is the segmentation signal there and the violation signal here, which means one trace serves both without a second mechanism.
- **[[wiki/concepts/simulation-based-planning.md]]** — the negative result that matters for planning: the properties a planner most needs (solidity, collision) are exactly the ones at chance, so a model that passes this protocol is not thereby a usable physics simulator.
- **[[wiki/concepts/objective-identifiability.md]]** — the ablations are an identifiability experiment run by hand: three masking objectives and three corpora, with the corpus *distribution* mattering far more than the objective or the corpus size.
- **[[wiki/concepts/cross-modal-grounding.md]]** — an independent replication of the multimodal-LLM null with a verbal rather than a surprise-based read-out (VideoLLaMA and PandaGPT at chance, humans >80%), and a second differencing instrument in the same spirit as the untrained null: déjà vu memorization is defined only as a gap against a reference model trained without the item.
