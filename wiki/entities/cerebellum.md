# The Cerebellum — the wiki's first page on the structure holding ~80% of the brain's neurons

**A uniform, endlessly repeated three-layer circuit with exactly one output cell and one instructive fibre per output cell, argued to hold *internal models* of the body and the world: inverse models (desired state transition → motor command), forward models (state + efference copy → predicted next state and predicted reafference), or — the review's own reconciliation — **paired** forward/inverse modules, one pair per microzone, selected by a responsibility signal computed from each forward model's prediction error.**

> **Provenance.** `raw/wolpert-1998-internal-models-cerebellum.md` — Wolpert, Miall & Kawato, *Internal models in the cerebellum*, Trends Cogn. Sci. 1998; 2(9):338–347. A review co-written by the two rival camps, so each reading is argued by its own proponent and each states its own weakest link. Kawato's ocular-following evidence for the inverse model is the strongest single-microzone dataset in the paper; Miall & Wolpert concede outright that "direct evidence that the cerebellum acts as a forward model is not yet available."

The wiki has cited this structure eleven times across other pages and never described it. [[wiki/concepts/cellular-scaling-rules.md]] states the complaint precisely: cerebellar and cortical **absolute** neuron counts rise in step across 18 species and are the tightest correlate in that dataset, so cortex and cerebellum are one coupled system — and the wiki models the 19% and not the 80%.

---

## The circuit, and the two ways the wiki now reads it

| Element | Anatomy | Inverse-model reading (CBFELM) | Memory reading ([[wiki/entities/sparse-distributed-memory.md]]) |
|---|---|---|---|
| **Mossy fibres → granule cells → parallel fibres** | Massive expansion recoding; each parallel fibre contacts many Purkinje cells | Desired trajectory **and** current state of the controlled object | The address decoder — a fixed, random expansion selecting hard locations |
| **Purkinje cell (P-cell)** | The **sole** output of cerebellar cortex, inhibitory; four interneuron classes besides | The feedforward motor command, carried by **simple spikes** (SS) | The contents store; SS rate = the majority-vote read-out |
| **Climbing fibre** (inferior olive), 1 per P-cell, **1–2 spikes/s** | Evokes the **complex spike** (CS); drives long-term depression at co-active parallel-fibre synapses | A copy of the **feedback motor command** — i.e. sensory error already transformed into motor coordinates | The error-gated write signal (Albus' CMAC, `ΔC = g(p̂_u − s_u)/K`) |
| **Golgi cells** | Feedback inhibition onto granule cells | — | The sparsity controller: 500–5,000 of 200,000 granule cells active regardless of input load ([[wiki/concepts/pattern-separation-completion.md]]) |
| **Microzone** | A sagittal strip; the repeating functional unit | One inverse model of one controlled object (with extracerebellar circuits: the "side-loop" form) | One memory bank |

**The two readings differ only in what the climbing fibre is.** Store: an error-gated write enable. Controller: an error *expressed in the output's own coordinates*. The second is a much stronger claim and the review supplies the measurement for it.

Because the circuit is uniform and long-term depression ubiquitous, all three readings below claim to be **universal across the cerebellum** on the strength of evidence from one microzone and one eye movement. The review says so in those words. That inference — uniform anatomy ⇒ uniform computation — is the same move [[wiki/entities/thousand-brains-theory.md]] makes for the cortical column, made here on a circuit that is far more regular.

---

## Reading 1 — the cerebellum as an inverse model, and the credit-assignment trick that makes it learnable

An **inverse model** maps a desired state transition to the motor command that causes it. Cascade it with the plant and you get approximately the identity, so an accurate inverse model *is* a feedforward controller — which is what fast movement needs, since biological feedback loops are too slow and too low-gain. The rival account (equilibrium-point control) predicts high measured limb stiffness; measured stiffness during visually guided multi-joint reaching is **low** (Gomi & Kawato 1996), which the review reads as requiring an inverse model.

### The distal-teacher problem, and feedback-error learning

The training signal for a controller is its *motor command* error — and that is exactly what is unavailable: if you knew it, you would already have the right command. Errors arrive in **sensory** coordinates (retinal slip, proprioception, acoustics) and must be converted to **output** coordinates before any local rule can use them.

**Feedback-error learning (Kawato's CBFELM — cerebellar feedback-error-learning model)** solves it without inverting the plant and without a backward pass:

```
u_total = u_ff(desired trajectory)      ← inverse model, learned
        + u_fb(sensory error)           ← crude, slow, phylogenetically old feedback controller
train  u_ff  with  u_fb  as the error signal
```

Three properties worth importing:

| Property | Why it matters |
|---|---|
| The feedback controller performs the sensory→motor coordinate transform *by being a controller* | No inverse model of the plant is needed to train an inverse model of the plant — the circularity is broken by a bad controller that already exists |
| The training signal **extinguishes itself** | As `u_ff` improves, the sensory error and hence `u_fb` fall to zero; no schedule, no stopping rule |
| The teacher is architecturally *older and worse* than the student | Scaffolding by a legacy pathway, not by a supervisor with privileged information |

Circuit assignment: parallel fibres carry desired trajectory + state; SS carry `u_ff`; climbing fibres carry `u_fb`. See [[wiki/concepts/biologically-plausible-credit-assignment.md]].

### The evidence — monkey ventral paraflocculus during ocular-following responses

Ocular-following responses (OFR) are reflexive eye-tracking movements evoked by whole-field visual motion.

| Claim | Measurement |
|---|---|
| SS **are** the motor command | SS firing rate reconstructed by a linear combination of eye acceleration, velocity and position measured **10 ms later** (the conduction delay); good fit for the majority of cells over a wide stimulus range; velocity/acceleration coefficient ratio ≈ that of motoneurons |
| The command is *computed here*, not inherited | The same inverse-dynamics fit **fails** on medial superior temporal area and dorsolateral pontine nucleus — the visual mossy-fibre inputs — and where it fits at all the velocity/acceleration ratio is smaller |
| The coordinate transform happens **at the parallel-fibre→P-cell synapse** | Input preferred directions are uniform over 360°; SS preferred directions are downward or ipsilateral — the extraocular muscle axes — and electrical stimulation at the recording site moves the eye in that cell's SS preferred direction |
| CS carry error **in motor coordinates** | CS spatial axes aligned with SS (muscle axes) but preferred direction **180° opposite**; CS waveforms nonetheless carry retinal slip, and CS speed tuning is more linear against eye movement than against slip |
| A 1–2 Hz fibre can carry high-frequency error | CS **firing probability** (generalised linear model on a binomial spike count) reconstructs the same dynamics as SS at ~1/50 the rate; long-term plasticity acts as the temporal averager, triggered by a stimulus onset that parallel fibres detect |
| The SS waveform is **learned**, not wired | Cell-by-cell SS↔CS negative correlation in preferred direction, modulation depth *and* temporal pattern; cross-correlation shows the brief CS-induced SS pause accounts for none of it, so the effect is long-term |
| The sign mechanism | Long-term potentiation at low CS rate, depression at high CS rate makes each cell's SS preferred direction the opposite of its CS preferred direction |

Two model predictions that held: CS activity **persists after learning** (visual motion in OFR is unpredictable, so the feedback term never vanishes), and even for a purely feedforward movement an **onset burst** of CS survives, because desired trajectory and actual feedback are offset in time — confirmed for arm reaching, where CS encode both destinations and errors (Kitazawa et al. 1998).

---

## Reading 2 — the cerebellum as a forward model, and the Smith predictor

A **forward dynamic model** maps (current state, efference copy of the motor command) → next state. A **forward output model** maps state → predicted reafference, *including the transport delay*. In series they predict the sensory consequences of a command.

The justification is not that reafference is unavailable — it is that it is **late**. In visually guided tracking the visual feedback is delayed and says nothing about muscle forces; in fast reaching, feedback is usable only at the end. A forward model supplies the missing state estimate at ~zero delay.

### The Smith predictor, and its second model

Miall et al. 1993's proposal: a forward model inside a **high-gain internal feedback loop**, plus a separate learned model of the **transport delays**.

| Component | Job |
|---|---|
| Forward dynamic model (lateral cerebellum) | State estimate, available immediately |
| Internal high-gain loop (cerebro-cerebellar) | Its output **is** the motor command |
| Forward output model (the delay model) | Holds the internal prediction back so it can be compared with the delayed real feedback **in temporal register** |

Two consequences the wiki should carry:

1. **A forward model in a high-gain loop constitutes an inverse model.** The two readings above are therefore not cleanly separable by behaviour — this is the review's own reconciliation route, and it is why [[wiki/empirical-tensions.md]] `T342` is a decomposition question rather than a settled one.
2. **A comparator needs a model of its own latency.** Prediction and feedback are not comparable until one has been delayed by the right amount, and the right amount is a learned quantity. Every predictive architecture in the wiki assumes temporal register — `G111`.

### The evidence, and what it is not

| Result | Reading |
|---|---|
| Mirror task (hand and cursor move in *different* directions): a significant proportion of directionally tuned P-cells in intermediate cerebellar cortex track the **cursor**, not the hand | Encoding the *visual consequence* of the movement, not the command or its proprioceptive consequence. Goal-tuned cells are excluded because they fire before movement onset |
| Ebner & Fu: P-cell activity correlates with hand movement early in a trial, with cursor movement later | Same, with a within-trial time course |
| SS activity **predicts CS activity ~150 ms later** — the prediction interval of that visually guided task | Cortical output is a prediction; the climbing fibre corrects it after a fixed lag |
| A Smith predictor simulation with a *degraded* forward model reproduces the tracking deficits of cerebellar ataxia | Lesion-matching, not localisation |
| Imaging and lesions: cerebellum implicated in sensory acquisition and discrimination rather than motor control (Gao et al. 1996); motion-perception deficits from midline cerebellar lesions (Nawrot & Rizzo 1995) | Consistent with reafference processing; consistent with much else |

The review's own verdict on this column is that it is all indirect.

### Two objections, and the answers offered

| Objection | Answer, and its measured support |
|---|---|
| **Structural credit assignment** (Arbib 1989): the Smith predictor needs *two* forward models trained simultaneously from one error term | **Separate their learning rates.** Measured: human adaptation to an added 200–300 ms visual feedback delay takes **hours**; adaptation to changed task dynamics takes minutes. Oculomotor delay adaptation is equally slow. A slow delay model and a fast dynamics model can share one error signal without fighting |
| **Temporal credit assignment**: the climbing-fibre error arrives ~150 ms after the parallel-fibre activity that caused it | An **eligibility trace** — metabotropic glutamate receptors on the P-cell holding a decaying record of recent parallel-fibre input; the same device used in cerebellar models of eye-blink conditioning (Fiala et al. 1996) and saccadic adaptation (Schweighofer et al. 1996). This is [[wiki/concepts/synaptic-plasticity.md]]'s eligibility trace with a proposed receptor and a measured required duration |

---

## Reading 3 — MOSAIC: multiple paired forward and inverse models

The review's synthesis (Wolpert & Kawato 1998). `N` modules; module `j` = **(forward model, inverse model, responsibility predictor)**, proposed to sit one per microzone.

| Term | Computed from | Timing |
|---|---|---|
| **Likelihood** | Forward model `j`'s prediction error — smaller error, higher responsibility | After the movement; needs the outcome |
| **Prior** | **Responsibility predictor**: sensory contextual cues → responsibility estimate, trained to approximate the final posterior | **Before** movement onset |
| **Responsibility** `λ_j` | prior × likelihood, normalised across modules (soft-max) | — |

`λ_j` does three separate jobs:

1. Scales forward model `j`'s error → **competitive learning**, so the forward models partition the experienced dynamics between them;
2. Scales inverse model `j`'s motor error → **a controller is trained only where its paired predictor is right**;
3. Scales inverse model `j`'s contribution to the final feedforward command.

**Why modular at all**, per the review: the world *is* modular (distinct objects and environments); modules let one behaviour be learned without disturbing the others ([[wiki/concepts/continual-learning.md]]); and modules **compose** — 32 inverse models each contributing or not gives `2³² ≈ 10¹⁰` behaviours, so internal models are **motor primitives** and a novel context is a new mixture rather than new learning ([[wiki/concepts/compositionality.md]]).

Behavioural support the review assembles: context-dependent adaptation cued by gaze direction, body orientation, arm configuration, an auditory tone or the *feel* of prism goggles; **de-adaptation faster than adaptation** (switching, not relearning); and repeated alternation between two prism displacements speeding adaptation each time (a retained module switched back on).

### MOSAIC is COIN's direct ancestor, and the wiki has been carrying the descendant without the parent

| | **MOSAIC** (Wolpert & Kawato 1998) | **COIN** ([[wiki/entities/coin-model.md]], Heald, Lengyel & Wolpert 2021) |
|---|---|---|
| Module count | Fixed `N` | Unbounded; sticky hierarchical Dirichlet process |
| Prior on responsibility | A **learned** responsibility predictor from sensory cues | `p(c_t ∣ q_t, c_{t−1})` — cue emission matrix × sticky transition matrix, both inferred |
| Likelihood | **Forward-model prediction error** | State-feedback likelihood `p(y_t ∣ x^{(j)})` |
| Combination | prior × likelihood, soft-max | Exact Bayes over an infinite context set (particle learning) |
| Per-module content | A forward model **and a controller** | A **scalar** state `x^{(j)}` and its dynamics `(a^{(j)}, d^{(j)})` |
| What responsibility gates | Forward-model learning, **inverse-model learning**, and the **command** mixture | Memory creation, memory updating, and the output mixture |
| New-module allocation | None | `p(c_t = ∅)`, always represented |
| Fitted to data | No | Yes — ΔBIC 302.6 / 394.1 nats over the dual-rate model |

**(brainstorm) Reading the difference.** COIN bought a principled allocation rule and a fitted posterior, and lost the controller. MOSAIC's per-module content is a *pair* — a predictor and a policy — and the responsibility signal is what welds them: an inverse model receives motor error **only where its paired forward model predicts well**, so a module whose world model is wrong cannot contribute a command however good its policy is. That is a partial, 1998 answer to [[wiki/gaps/g062.md]] run backwards: nothing here *scores* a world model by what a controller can do with it, but the world model is the controller's admission ticket, which is the same coupling with the arrow reversed. It is also [[wiki/gaps/g037.md]]-style retrieval with the router grounded in a quantity the system computes for itself — a prediction error, not a label. What neither model supplies is a way for the world to say **how many** modules there should be; COIN answers with a hyperparameter (`γ`), MOSAIC with a constant.

**(brainstorm) The two-channel structure survives intact into COIN and is worth stating as an architectural invariant.** Context evidence always arrives twice: a *cue* channel that is available before acting and is therefore the only thing expression can use, and an *outcome* channel that is diagnostic but late. Any library-of-models architecture needs both, and needs the cue channel to be **trained against the outcome channel's verdict** — which is exactly what MOSAIC's responsibility predictor is and what a hand-designed gating network is not.

---

## What maps onto model components

| Cerebellar element | Machine correspondent | Where the wiki carries it |
|---|---|---|
| Parallel-fibre expansion + Golgi sparsification | Fixed random expansion recoding with a sparsity set point | [[wiki/entities/sparse-distributed-memory.md]], [[wiki/concepts/pattern-separation-completion.md]] |
| Climbing fibre as feedback motor command | A **legacy controller's output used as the training target for a learned controller** | [[wiki/concepts/biologically-plausible-credit-assignment.md]] |
| Metabotropic trace on the P-cell | Eligibility trace bridging a ~150 ms action–error lag | [[wiki/concepts/synaptic-plasticity.md]], [[wiki/gaps/g020.md]] |
| Forward output model | A learned model of the agent's own feedback latency | `G111` |
| Microzone | The unit of modularity — one (predictor, controller) pair | [[wiki/concepts/emergent-modularity.md]] |
| Responsibility | Mixture weight over a library of models, computed from prediction error | [[wiki/concepts/contextual-inference.md]] |

---

## Open problems

- **The generalisation is unmeasured.** Rigorous support for the inverse-model reading is one microzone and one eye movement. Whether the arm's cerebellar representation is the same computation on a harder plant, or a different computation, is the review's own first outstanding question.
- **Are forward and inverse models spatially interleaved or segregated?** The paired-module claim predicts interleaving at microzone scale; nothing in the review tests it. This is what would decide [[wiki/empirical-tensions.md]] `T342`.
- **Does the climbing fibre carry the same signal for limbs as for eyes?** Agreed to be motor error for eye movements; open for skeletomotor control.
- **Is long-term depression the memory, or is the memory downstream?** The review frames this as tied to whether cerebellar positive-feedback loops via P-cells do trajectory planning (Houk & Barto; Lisberger) — and offers one discriminating measurement: ventral paraflocculus SS correlate with **future** eye velocity (inverse-dynamics prediction) and **not** with past eye velocity (eye-velocity-feedback prediction), and when the target is blanked, input and P-cell activity drop together.
- **The extension the review names and does not take.** "It is simple to extend the concept of internal models of the motor system to internal models of the external world, of other people's mental processes or of parts of one's own brain." Twenty-eight years later the wiki's world models ([[wiki/concepts/learned-world-models.md]]) and its theory-of-mind models ([[wiki/entities/hbtom.md]]) are separate literatures, and neither is paired with a controller in the MOSAIC sense.

---

## Connections

- **[[wiki/entities/sparse-distributed-memory.md]]** — the same circuit read as a memory rather than as a controller: granule-cell expansion is Kanerva's address decoder, the P-cell is the contents store, and Albus' CMAC makes the climbing fibre an error-gated write enable. The disagreement is precise and testable — a write signal need only say *whether* to write, whereas feedback-error learning requires the climbing fibre to carry a **signed error in the output's own coordinates**, which is what the ocular-following preferred-direction data measure.
- **[[wiki/concepts/contextual-inference.md]]** — this page supplies the ancestor of that page's responsibility signal: MOSAIC 1998 computes responsibility as prior (cue-driven, pre-movement) × likelihood (forward-model prediction error), which is the same two-channel decomposition COIN fits 23 years later, with a *controller* attached to each module that COIN drops.
- **[[wiki/entities/coin-model.md]]** — its direct predecessor; the comparison table above states what each buys and loses (unbounded allocation and a fitted posterior, against a paired policy per module).
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — feedback-error learning is a solution to the distal-teacher problem that needs no backward pass and no plant inverse: a crude legacy feedback controller performs the sensory→motor coordinate transform, its output trains the fast feedforward controller, and the signal extinguishes itself as learning succeeds.
- **[[wiki/concepts/learned-world-models.md]]** — the Smith predictor is a forward model used as a *controller* rather than as a rollout engine: inside a high-gain internal loop its output is the motor command, so the forward/inverse distinction that page inherits is not architecturally sharp.
- **[[wiki/concepts/prediction-error-neurons.md]]** — a third locus for the cortical prediction machinery that page localises to layer 2/3, and a rival reading of the error signal: cortical prediction errors are in **sensory** coordinates, the climbing-fibre error is claimed to be in **motor** coordinates, which is a stronger and separately measurable claim.
- **[[wiki/concepts/cellular-scaling-rules.md]]** — that page's standing complaint, answered: cerebellar and cortical neuron counts rise in step and the cerebellum holds ~80% of them, so a wiki that models only cortex is modelling the smaller half of a coupled pair.
- **[[wiki/concepts/emergent-modularity.md]]** — the microzone is the cleanest candidate in biology for a repeated module with a *stated internal decomposition* (predictor + controller + gate) and a compositional read-out, against that page's cortical modules whose boundaries are inferred from covariance.
- **[[wiki/concepts/synaptic-plasticity.md]]** — supplies the eligibility trace this circuit needs and the duration it needs it for: the climbing-fibre error lands ~150 ms after the parallel-fibre activity that must be modified, and a metabotropic-receptor trace is the proposed substrate.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the Golgi-cell set point (500–5,000 of 200,000 granule cells active regardless of input load) is that page's runtime sparsity controller, running in this circuit.
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — supplies the coordinate-transformation framing this page's inverse model instantiates, and the efference-copy requirement the forward model consumes as input.
