# Generalization-Optimized Consolidation

**Transport from the fast store to the slow one should run only as long as it lowers *generalization* error, and the point at which it stops is set by the **predictability** of the relationship being consolidated. Unregulated consolidation is not merely wasteful — it is overfitting, and past the optimum it makes the slow store worse than untrained (Sun et al. 2023, "Go-CLS").**

[[wiki/concepts/complementary-learning-systems.md]] assumes transport is good and asks only how it is scheduled. This page states the missing sign condition: for a mapping the slow learner cannot model, **the optimal amount of consolidation is zero**, and the memory should stay in the fast store forever.

---

## The formalism: teacher–student–notebook

| Element | Model | Maps to |
|---|---|---|
| **Teacher** | Linear feedforward net, `y^μ = w̄x^μ + ε^μ`; `w̄ ~ 𝒩(0, σ_w²)`, `x ~ 𝒩(0, 1/N)`, `ε ~ 𝒩(0, σ_ε²)`, with `σ_w² + σ_ε² = 1` | The environment: the input→output relations experience actually contains |
| **Student** | Size-matched linear net, weights `w` initialised to zero (tabula rasa), trained by gradient descent | Neocortex |
| **Notebook** | Sparse Hopfield net, `M = 2,000–5,000` binary units, sparsity `a`; one-shot Hebbian binding of a random index `ξ^μ` to the student's activation `(x^μ, y^μ)` | Hippocampus as a **pattern-separated index** ([[wiki/concepts/pattern-separation-completion.md]]) |
| **Predictability** | `SNR = σ_w² / σ_ε²` | How much of experience is modellable *by this student* |

**The consolidation loop** (this is the transport mechanism, stated explicitly):

1. Encode `P` examples into the notebook in one shot — Hebbian, on notebook↔notebook, student→notebook and notebook→student weights.
2. Offline, initialise the notebook with a random pattern; 9 synchronous recurrent cycles settle it into a stored attractor (pattern completion, near-uniform sampling since `P ≪ M`).
3. The retrieved index drives the student's input and output layers through notebook→student weights, yielding `(x̃^μ, ỹ^μ)`.
4. The student regresses its own forward pass on the reactivated target:

```
Δw = η ( Ỹ X̃ᵀ − w X̃ X̃ᵀ )
```

This is **self-distillation from the fast store**: the slow learner's targets come from the fast store's recall, not from the environment. It is the wiki's first concrete answer to "how does instance structure become meta structure" (gap G14) that does not require the slow learner to re-see the data.

---

## The result: consolidation has an optimum, and it is interior

| Teacher | Standard consolidation (unbounded reactivation, optimise *memory*) | Go-CLS (stop where generalization error is minimal) |
|---|---|---|
| Noiseless (`SNR = ∞`) | Generalization improves monotonically; full memory transfer | Same — full transfer arises *as a consequence* of optimising generalization |
| Intermediate SNR | Generalization improves, then **degrades**; the student interpolates the noise that was replayed with the signal | Finite reactivation count; near-optimal generalization, **incomplete** memory in the student |
| Very low SNR | *Any* consolidation hurts; generalization can fall **below chance** — the trained student interpolates noise into wildly wrong outputs | Consolidation ≈ 0; the memory stays notebook-resident permanently |

Two structural consequences:

- **Partial memory transfer is the normal case, not a failure.** The permanently hippocampus-dependent memories that the standard theory cannot explain are exactly the low-predictability ones. Predictability — not *detail* (multiple trace / trace transformation theory), not frequency, not salience — is the proposed determinant.
- **The notebook keeps what the student refuses.** The combined system is read out through whichever module has lower error, so memory performance survives even where consolidation is switched off.

**Retrograde amnesia shapes fall out of one parameter.** Lesioning the notebook at time `t` and freezing consolidation there:

| SNR / prior state | Amnesia curve | Reading |
|---|---|---|
| High SNR (~8) | **Graded** — recent memories lost, remote spared | The classical result; the only one the standard theory produces |
| Low SNR (0.01–0.3) | **Flat** — recent and remote equally lost | Nothing ever consolidated |
| High SNR + extensive prior consolidation (`SNR = 50`, 8–2,000 prior epochs) | Shallower gradient, up to **no retrograde amnesia at all** | Schema-consistent learning: a student that already models the domain consolidates a new instance almost immediately |

One parameter sweep reproduces a literature's worth of mutually inconsistent amnesia results — which is also the theory's weakness, since it can postdict any curve if SNR is unconstrained (see Open problems).

---

## Why *two* systems, quantitatively

Comparing the optimal student–notebook system against ablations:

| System | Generalization | Why |
|---|---|---|
| Notebook only | Poor at any SNR | Curse of dimensionality — a new random high-dimensional input is almost never near a stored one, so rote recall does not extrapolate |
| Student only (online, one pass per example, optimally scheduled learning rate) | Worse than the pair | Cannot revisit an example; the data are seen once and the estimator is noisier than a repeated-batch one |
| Student + notebook, regulated | Best | Replay converts a single-pass stream into a re-usable dataset, and regulation prevents the fitting of noise |

**The gain peaks where `P ≈` the number of learnable student weights** — and that is *also* the worst point for overfitting under unregulated consolidation. This is the **double-descent** regime: near capacity, the weights must be tuned most finely to drive training error down, so small errors buy large, noise-corrupted weight changes.

**(brainstorm)** This is a sharp and underused design rule. The value of a replay buffer is not monotone in data — it is largest exactly in the data-limited, near-capacity regime where the same buffer is most dangerous. An agent that both has limited experience and is near the capacity of its slow learner *needs* replay and *must* regulate it; an agent swimming in data can skip both. Every machine replay buffer in the wiki runs at a fixed, unregulated rate.

---

## Unpredictability has four sources, and they are interchangeable

The student cannot tell them apart, and the model shows they yield the same training/generalization dynamics — all decompose into a modellable signal plus an unmodellable residual, i.e. a nonzero optimal approximation error for the teacher–student *pair*:

| Source | Example | Note |
|---|---|---|
| **Inherent noise** | Additive `ε` on the teacher's output | The base case |
| **Architecture mismatch** | Deterministic nonlinear teacher (sine), linear student | Fully deterministic yet unpredictable *from where the student stands* |
| **Partial observability** | Teacher's mapping uses input features the student cannot see | Favours large students with enough features; makes "add capacity" a way to raise predictability |
| **Attention** | The student attends to a subset of its own inputs | Predictability of the *same external experience* becomes an internal, individual-specific variable — a candidate explanation for individual variability in consolidation |

Two important qualifications the source makes itself:

- **Predictability is a property of the pair, not of the world.** "Paris is the capital of France" is arbitrary but perfectly predictable — infinite SNR. Arbitrariness and unpredictability are orthogonal.
- **Not all noise is generalization-limiting.** Independent noise injected at *inference* regularises (dropout). Only noise entering the fitted target does damage.

**Every relationship inside one experience gets its own SNR.** A single episode contains many input→output mappings — cross-modal predictions, multiple outputs from shared features — each with its own predictability. So consolidation is not a per-episode decision but a **per-relationship** one: birds fly and strawberries taste sweet consolidate; the coincidence that a shirt matched the strawberries does not, and stays as episodic detail requiring the hippocampus forever. This is what makes the theory a claim about *decomposing* experiences rather than triaging them.

---

## Who does the stopping? The supervisor problem

Early stopping requires an estimate the agent does not have. Three candidate estimators, all shown to work in the model:

| Estimator | Mechanism | Cost |
|---|---|---|
| **Held-out validation** | Split the notebook's stored examples into a training set that drives student learning and a small validation set that does not; stop when validation error turns up | Works best with a *small* validation set; the source itself doubts brains reserve data that never drives learning |
| **Maximum-likelihood SNR** | Compare the input–output covariance of stored examples to theoretical expectations, which vary with SNR | Needs prior knowledge of the data-statistics→SNR relation |
| **Initial learning speed** | Faster early learning at a given dataset size ⇒ higher predictability | The cheap heuristic; a single scalar |

For richer environments, the source proposes the statistics→predictability prior is itself established by **meta-learning over developmental, lifetime and evolutionary timescales** ([[wiki/concepts/meta-learning.md]], [[wiki/concepts/meta-optimized-plasticity.md]]) — i.e. the stopping rule is the meta-level's output, not the agent's inference.

**Candidate neuromodulatory implementation** (speculative in the source):

| Signal | Proposed role |
|---|---|
| Norepinephrine | Represents unexpected environmental change → cue to *re-estimate* predictability |
| Acetylcholine | Promotes encoding, suppresses replay, represents environmental stochasticity → could tag unpredictable experience for hippocampal retention and reduced transport |
| Dopamine | Known to tag rewarding episodes for enhanced replay — the *existing* tag, on the wrong variable |

The stated open experiment: find whether any neuromodulator tags memories for *reduced* consolidation, the mirror image of dopamine's reward tag.

---

## The heuristic-failure prediction

If the brain approximates predictability with **frequency**, Go-CLS's most distinctive prediction inverts: the theory says a rare statement from a reliable source should consolidate more than frequently repeated misinformation, and a frequency heuristic gives the opposite. Extreme misregulation of the consolidation amount is offered as a framing for PTSD — a maximally unpredictable event consolidated as though it were structure.

**(brainstorm)** This is the cleanest behavioural discriminator in the ingest and it is directly testable in machines: train a replay-regulated learner on a stream mixing high-frequency/low-reliability and low-frequency/high-reliability relations, and ask which consolidates. It also predicts a failure mode for [[wiki/concepts/recall-gated-consolidation.md]]'s gate, which is *defined* on recurrence and would consolidate the misinformation.

---

## Why this matters for a reasoning model

- **It supplies the missing sign on gap G14.** Every prior wiki page treats the fast→slow channel as a good thing whose only problem is that nobody has built it. This says a built channel with no regulator is actively harmful in exactly the data regime where it is most needed.
- **It reframes the fast store's permanence.** The hippocampus is not a staging buffer that has failed to empty; it is the **permanent home of the unmodellable residual**. A reasoning architecture therefore needs a fast store at deployment time, not only at training time — which is the same conclusion [[wiki/concepts/latent-graph-discovery.md]] reaches for instance graphs, arrived at from generalization error rather than from sample complexity.
- **It puts a criterion on which edges are promoted into the meta-graph:** an edge is promoted iff its promotion lowers held-out error on the environment family. That is a *validation* criterion rather than a *recurrence* criterion, and the two come apart.
- **Overfitting the world model is a named failure mode.** The "maladaptive generalization, worse than chance" regime is what an agent that consolidates every episode into its world model should be expected to do in an unpredictable environment ([[wiki/concepts/shortcut-learning.md]] is the same disease with a different cause: there the spurious feature is reliable, here it is noise).

**A machine teacher–student where the teacher is the same network, earlier** (Siméoni et al. 2025, [[wiki/entities/dinov3.md]]). The [[wiki/entities/dinov2.md]] entry recorded a machine instance where the direction was size: distil a larger net into a smaller one and beat training the smaller one directly. DINOv3 supplies the axis this page actually cares about — **time**. The Gram teacher is a checkpoint of the same 7B network 800k iterations earlier: *worse* on the objective being optimised, *better* on the property being lost, and regressing the current network's patch-similarity structure onto it recovers that property in 10k steps. Three points of contact with the formalism above:

- **The teacher has a usable age window at both ends.** A 100k- or 200k-iteration anchor works; a 1M-iteration one is harmful. Transport from the notebook is beneficial only while the notebook's contents are still worth having — which is the interior-optimum shape of this page's result, relocated from *how much* to transport to *from when*.
- **The regulator is a role, not an estimate.** What is protected is chosen by *which read-out the surviving objective cannot see*, not by a Fisher-style importance score or a validation split. That sidesteps the "validation data the brain does not hold out" open problem below, at the cost of needing to know in advance which property is at risk.
- **Distillation crosses an architecture boundary.** The 7B ViT's features distil into ConvNeXts with no CLS token and no attention (+17.9 mIoU over ImageNet-22k-supervised ConvNeXt-T on ADE20k), and an 0.8B student matches the 8× larger teacher. What the teacher transports is not capacity and not weights — it is a target distribution, and the student's substrate is nearly free.

---

## Open problems

- **Linear student, linear teacher, matched sizes.** The analytic tractability comes from cleanly separating optimal approximation error from learning dynamics, and the source states this separation is impractical for complex students. Whether the same optimum exists in a deep nonlinear student is asserted-by-analogy (overfitting is general) rather than shown.
- **Predictability is not measurable in any real experiment.** The mapping from published paradigms to SNR is the theory's own stated weak point — it makes the postdiction of the amnesia literature suggestive, not confirmatory. No experiment yet manipulates predictability deliberately and measures consolidation.
- **No biological mechanism for regulation.** The theory says *what* is regulated and not *how*; replay volume, replay composition and post-replay incorporation are three distinct places the regulator could sit, and nothing chooses between them.
- **The interpolation escape.** Some machine-learning methods interpolate the training data *and* generalize well (benign overfitting). If a student architecture existed with no memorization/generalization trade-off, the whole normative argument for regulated transport would dissolve. The source names this and does not pursue it.
- **Permanent hippocampal residence is not a diagnostic.** The theory's signature outcome — a memory that stays notebook-resident with weak cortical involvement — is produced identically by a *degraded transport channel*: in older humans, low prefrontal slow-wave activity predicts persistent next-day hippocampal retrieval activation and reduced hippocampal–prefrontal connectivity, with the deficit traced to cortical atrophy rather than to anything about the material's predictability (Mander et al. 2013). Since predictability is unmeasurable in any real experiment (bullet above), refusal and failure are currently indistinguishable in exactly the datasets used to argue for partial consolidation ([[wiki/empirical-tensions.md]] T82).
- **Supervised only.** Reinforcement learning and in-context/few-shot learning have richer generalization dynamics and are untreated.
- **Validation data the brain does not hold out.** The most conceptually simple regulator is the least biologically plausible one, and the plausible substitutes (SNR estimation, learning speed) both require a learned prior nobody has specified how to acquire.

---

## Connections

- **[[wiki/entities/inhibitory-replay-filter.md]]** — the *which* to this page's *how much*, and it makes predictability the quantity in both: a symmetric spike-timing rule at inhibitory synapses accumulates suppression on representations whose co-active partners vary across episodes, so unpredictable content is excluded from the replay sample rather than being rationed within it — two independently derived filters keyed on the same statistic, one acting on the sample and one on the budget.
- **[[wiki/entities/dinov3.md]]** — the teacher–student channel run along *time* rather than size: a checkpoint 800k iterations old, worse on the optimised metric and better on the eroded one, restores the eroded property in 10k steps — and the anchor is useful only within an age window, which is this page's interior optimum relocated from how much to transport to from when.


- **[[wiki/concepts/complementary-learning-systems.md]]** — supplies the normative sign condition CLS never stated: transport is beneficial only while it lowers generalization error, so partial and zero consolidation are optimal outcomes rather than pathologies, and it quantifies the two-system advantage as peaking when the stored example count matches the slow learner's parameter count.
- **[[wiki/concepts/recall-gated-consolidation.md]]** — the rival criterion for the same valve, and they are separable: recall gating passes what *recurs*, Go-CLS passes what the slow learner can *model*, and an unmodellable-but-recurring relation (a nonlinear teacher seen daily) is consolidated by the first and refused by the second ([[wiki/empirical-tensions.md]] T81).
- **[[wiki/concepts/offline-replay.md]]** — turns the review's "consolidating everything overfits" from an aside into a derivation with an early-stopping rule, and reads the replay budget as a quantity to be *rationed per relationship* by predictability rather than allocated per episode.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the notebook is exactly this mechanism used as an index: random sparse patterns bound one-shot to cortical activity, retrieved by recurrent completion, and never carrying content of their own.
- **[[wiki/concepts/continual-learning.md]]** — a stopping criterion for the slow write that needs no task boundary and no importance estimate, only an estimate of how predictable the current relation is; and a warning that a perfectly working replay buffer degrades the learner it feeds once the environment is noisy.
- **[[wiki/concepts/meta-learning.md]]** — where the theory puts the supervisor: the prior linking observable data statistics to predictability is meta-learned over developmental and evolutionary timescales, so the amount of consolidation is an outer-loop output rather than an inner-loop inference.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — the same delegation at the rule level: "how many reactivations before stopping" is a plasticity hyperparameter whose optimal value is set by environment statistics, which is precisely the object that family meta-learns.
- **[[wiki/concepts/shortcut-learning.md]]** — the complementary failure: this page's maladaptive generalization comes from fitting *unpredictable* structure, shortcut learning from fitting *reliably predictive but non-causal* structure, and no consolidation criterion in the wiki filters the second.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies a promotion rule from instance-graph to meta-graph — promote an edge iff promotion lowers held-out error — and an argument that the instance store must be permanent, since the unmodellable residual of experience has nowhere else to live.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the notebook here is that model stripped to its function (sparse index + one-shot Hebbian binding + recurrent completion), and this page's incomplete-transfer result gives the capacity bound a new consequence: the fast store must permanently hold the unpredictable residual, so its capacity constrains steady-state behaviour rather than only the consolidation lag.
- **[[wiki/concepts/synaptic-plasticity.md]]** — a division of labour between rules: one-shot Hebbian association writes the index, slow error-corrective gradient descent writes the generalization, and the theory's claim is that the second must be *stopped early* by a process neither rule contains.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — makes the error signal driving consolidation an internally generated prediction error (student forward pass vs. notebook-reactivated target), so the slow learner is trained by its own replayed model rather than by the world.
- **[[wiki/concepts/amortized-inference.md]]** — the same shape as this page's transport loop, offline reactivation compiling into fast weights, with the difference that here the compilation target is a *generalizing* function and the theory's whole content is when to stop compiling.
- **[[wiki/concepts/complementary-learning-systems.md]]** — and a second link, from the throughput side: the biological unit in which this page's reactivation budget would be spent looks like slow-oscillation cycles rather than seconds offline, since slow-wave *amplitude* predicts overnight retention while sleep duration, efficiency and stage composition do not (Mander et al. 2013).
- **[[wiki/concepts/engram.md]]** — the rival origin story for abstraction, and a weaker one: repeated conjunction of traces via co-retrieval builds a shared assembly that holds *that* two episodes go together, with nothing showing it comes to represent *what they have in common* — the criterion this page derives from predictability.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — a biological constraint on what the transport function may write: the cortical learner already represents the context, event and response terms at acquisition, so consolidation moves only the *association* among them, whereas self-distillation from the fast store rewrites whatever the slow learner's loss touches (Euston et al. 2012).
- **[[wiki/concepts/schema-assimilation.md]]** — two inputs this page's objective lacks: how much the new item conflicts with already-stored structure (which decides whether the slow learner is needed at acquisition rather than later) and how much episodic detail must survive read-out (which decides whether the fast store is ever released), both stated as the variables that reconcile the divergent remote-memory literature (Preston & Eichenbaum 2013).
- **[[wiki/concepts/memory-allocation-excitability.md]]** — the reason a top-down allocation gate can only be a *late* mechanism: it needs a cortical trace that transport has already built, which is why the ventromedial-prefrontal gate is load-bearing at 7 days and inert at 5 hours.
- **[[wiki/entities/dinov2.md]]** — the machine teacher–student instance with the surprising direction: a ViT-L distilled from a ViT-g beats the same ViT-L trained from scratch on **12/12** benchmarks, so what the teacher transfers is not capacity but a target distribution more fittable than the objective that produced it — and the retained model is the EMA of the student, not the student.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the lesion-literature route to this page's conclusion: the *transformation* account of consolidation says nothing moves, the episodic trace stays hippocampal as long as the memory is retained at all, and cortex learns its own semanticised version with a similarity structure the original never had (Winocur et al. 2010 via O'Reilly et al. 2011).
