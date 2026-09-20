# Curriculum Learning

**A curriculum is not "show easy things first" — it is a *sequence of training criteria*, one per step, obtained by reweighting the target distribution. Formally it is a continuation method on a non-convex objective: optimise a smoothed, low-entropy version of the loss first, then anneal to the real one. Its payoff is therefore an *optimisation* payoff, and it should be expected to vanish wherever the target objective is already easy to optimise.**

The wiki used the word on 39 pages before it owned it (`L20`). This page is the artefact: Bengio, Louradour, Collobert & Weston 2009, *Curriculum Learning*, ICML 26:41–48 (`raw/bengio-2009-curriculum-learning.md`) — the paper the term traces to, and the only source in the wiki that gives training order a **definition** rather than a procedure.

> **Provenance.** Converted from the ACM PDF (`LOSSY`). Text and numbers below verified against the converted body; equation (5)'s layout is mangled in conversion and is restated here from the surrounding prose. Figures 1, 3 and 5 are images and are reported as the text describes them.

---

## The definition

Let `z` be an example, `P(z)` the target training distribution, and `0 ≤ W_λ(z) ≤ 1` a weight at step `λ ∈ [0,1]` with `W_1(z) = 1`. The training distribution at step `λ` is

```
Q_λ(z) ∝ W_λ(z) P(z)        ∀z,     ∫ Q_λ(z) dz = 1,     Q_1(z) = P(z)
```

The sequence `{Q_λ}` is a **curriculum** iff both:

| Condition | Statement | What it forbids |
|---|---|---|
| **Entropy increases** | `H(Q_λ) < H(Q_{λ+ε})  ∀ε > 0` | A schedule that *narrows* the training set — diversity must grow monotonically |
| **Weights increase** | `W_{λ+ε}(z) ≥ W_λ(z)  ∀z, ∀ε > 0` | Dropping an example once added; an example's weight may only rise |

Discrete case: `Q_λ` concentrated on a finite set, increasing `λ` = **adding** examples, so the supports are a nested (embedded) sequence of training sets ending at the target set. Two steps is enough to qualify (easy set → target set), and two steps is what three of the four experiments use.

**The two conditions are the whole content of the word.** Note what they do *not* require: an easy set that resembles the target set. The `BasicShapes` set below occupies a tiny volume of input space relative to the target, which is admissible because the easy examples' initial weights can be arbitrarily small in the final mixture.

---

## Why it should work: a curriculum is a continuation method

Continuation methods (Allgower & Georg 1980; used in computational chemistry for molecular conformation) minimise a non-convex `C_1(θ)` by defining a family `C_λ(θ)` with `C_0` easy or convex, minimising `C_0`, then raising `λ` while keeping `θ` at a local minimum — so `θ` is carried into the basin of attraction of a dominant minimum of `C_1` rather than the nearest one.

Bengio et al.'s claim is that **a curriculum is exactly this family, with `λ` indexing a reweighting of the data rather than a smoothing of the function.** Two consequences the wiki should hold onto:

1. **The mechanism is basin selection, not information.** The curriculum does not add data (the union control below rules that out); it decides *which* local minimum the descent lands in. This is why the effect is predicted to be largest for deep / non-convex objectives and smallest for convex ones — and the paper's own numbers follow that ordering.
2. **The effect surfaces as regularisation.** Like unsupervised pre-training (Erhan et al. 2009), the gain shows up on the *test* set at equal training error. The paper explicitly refuses to explain why basin selection should improve generalisation and flags it as open for both procedures.

---

## What was actually measured

| Setting | Objective | Curriculum | Result |
|---|---|---|---|
| **Linear SVM**, 2 Gaussians in 2-D, means `(y/√2, y/√2)`, sd 1, 50 train examples, 50 seeds | **Convex** | Train on "easy" only (`y w′x > 0`, correct side of the Bayes boundary) | 16.3% vs **17.1%** generalisation error (significant). *Not a curriculum* — a cleanliness filter, and the smallest effect in the paper |
| **Perceptron**, 200 updates, 500 repetitions, inputs `(x_relevant, x_irrelevant)`, target `y = sign(w′x_relevant)` | **Convex** | Order by (a) number of non-zeroed irrelevant inputs, (b) margin `y w′x` | Curriculum beats random order on both criteria; all differences > .01 significant at 5%. **Convex ⇒ the gain is pure speed of convergence** |
| **3-hidden-layer MLP**, 32×32 grey-scale shapes, 3 classes, 10k train / 5k valid / 5k test, 20 seeds, 256-epoch budget | **Non-convex** (negative conditional log-likelihood) | 2-step: `BasicShapes` (squares, circles, equilateral triangles) → `GeomShapes` (rectangles, ellipses, triangles), switch epoch ∈ {0, 2, 4, …, 128} | Best test error at **switch epoch 128** — *half the entire budget spent on the easy set*. Monotone improvement in switch epoch up to that point |
| **Ranking language model** (Collobert & Weston 2008 architecture; `d = 50` embeddings, 100 hidden units, `n = 5`-word windows), 631M Wikipedia windows | **Non-convex** | Grow the **vocabulary**: pass 1 keeps only windows inside the 5,000 most frequent words (270M of 631M), +5,000 words per subsequent pass (370M at pass 2, …) to a 20,000 target | Final test mean log-rank **2.78 vs 2.83** (significant). Curves cross at ~**1 billion updates**, shortly after the target vocabulary is reached, and diverge thereafter. Each vocabulary increment produces a visible *drop* in rank error |

**The two controls that make the shapes result mean something.** (i) *More data?* No — a no-curriculum model trained on the **union** of `BasicShapes` and `GeomShapes` is still significantly worse than the curriculum, at roughly the switch-epoch-16 level. (ii) *Easy data is just better data?* No — training on `BasicShapes` alone is poor. Both models also converge (by early stopping) on the target training criterion, so the residual difference is a difference of **local minima**, which is the continuation-method prediction.

**Read the effect sizes.** On a convex criterion the paper buys 0.8 points; on a deep non-convex one it buys half the training budget's worth of ordering. That ordering — small on convex, large on deep — is the paper's own evidence for its mechanism, and it is also the wiki's rule of thumb for when to bother.

---

## Instantiations already in the wiki, re-read under the definition

The wiki has been running curricula for a long time without a name for them. Under `Q_λ`, they sort by *what is being annealed*:

| Page | Annealed variable | Effect | Satisfies both conditions? |
|---|---|---|---|
| [[wiki/entities/neuromatch.md]] | Query **radius** 1 → 4, then target-graph count → 256, incremented on 20 plateaued epochs | −6% and higher variance without it | Yes — nested supports, entropy rising |
| [[wiki/entities/differentiable-neural-computer.md]] | Lesson index over a 25-lesson graph/mini-SHRDLU sequence | **Essential everywhere except bAbI**; 98.8% vs an LSTM's 37% | Only with the paper's own patch: 10% of exemplars are drawn from *earlier* lessons to stop regression — i.e. the nesting condition is enforced by hand because a pure stage sequence violates it |
| [[wiki/entities/i-jepa.md]] | Context/target **mask sampler** (fixed, not annealed) | 15.5 → 54.2 on ImageNet-1% linear eval | No — a single `Q`, not a sequence. The largest "curriculum" number in the wiki is not a curriculum |
| [[wiki/entities/irene.md]] | Training-task **subset** (all 15 of 4 tasks) | Non-monotone: 51.5 alone, 80.4 paired, 51.4 with a third | No — and the non-monotonicity is a direct violation of the weight-monotonicity condition's spirit: adding a task *removed* capability |
| [[wiki/entities/byol.md]] | EMA rate `β`, which raises the predictor's target `τ/(1+σ²)` as the representation stabilises | The mechanism by which the EMA works at all (`T305`) | Yes, in the continuation sense — and it is the wiki's only **automatic** one, with `λ` driven by the learner's own state rather than a wall-clock schedule |
| [[wiki/entities/anli.md]] | Example **hardness**, closed-loop against the live model | +27.5 / +16.8 / +14.9 over rounds | **Inverted** — entropy of the target sampler falls onto the model's failures. An anti-curriculum, and the largest effect of the six |
| [[wiki/entities/saycam-baby-vision.md]] | **Nothing** — one child's entire 6–32-month head-mounted stream trained as a single i.i.d. `Q` | Linearly decodable categories, cross-child transfer, unseen-exemplar generalisation; ImageNet linear 20.9 vs 1.2 untrained | No — and this is the family's **null**: the developmental interval every curriculum argument appeals to, with the order deliberately discarded |

**(brainstorm)** The table's shape is the finding. Bengio's two conditions describe an *open-loop, monotone, easy-first* schedule, and the two biggest effects in the wiki (i-JEPA's sampler, ANLI's adversarial loop) satisfy neither. The definition captures the schedules that are cheap to specify, not the ones that pay most. A superset worth naming: **the experience stream is a distribution the designer chooses at every step, and "curriculum" is the special case where that choice is monotone in difficulty and independent of the learner** (`G32`). The seventh row sharpens what is missing from the other six: they all vary the schedule over a corpus assembled for convenience, and none of them can say what fraction of a real learner's history that corpus is. SAYCam can (~1 week of a child's waking input, two orders of magnitude short of a 2.5-year-old) — so it is the first entry that prices the *stream* rather than the *order*, and it does so with the order removed entirely.

---

## Boundaries the paper draws itself

| Against | Distinction |
|---|---|
| **Boosting** | Both end up emphasising hard examples, but boosting *starts* uniform and a curriculum starts easy; and for boosting the training criterion never changes — the reweighting is visible only to the next weak learner, while the boosted sum follows a functional gradient on one fixed criterion. A curriculum changes the criterion being optimised |
| **Multi-task / transfer learning** | A curriculum *is* transfer learning in which the early tasks exist to **guide the optimisation** rather than to share statistical strength. The motivation is different even when the mechanism overlaps: sharing across tasks vs steering into a better basin |
| **Active learning** | The proposed automatic version inverts the usual criterion: not examples near the *decision surface*, but examples near the frontier of what the learner already captures — "neither too easy nor too hard", i.e. expand the captured set outward from its border. Proposed, not built |
| **Unsupervised pre-training** | Hypothesised to act by the same dual mechanism (better basin + regulariser); the paper notes it cannot explain the regularisation half for either |

---

## Open problems

- **"Easy" is undefined.** The paper supplies four task-specific easiness measures (Bayes-correct side, margin, shape-variability, word frequency) and states outright that a general principle is missing. Every one of them requires knowing something the learner is trying to learn — the Bayes boundary, the true `w`, the generative factors. **A curriculum defined by an oracle is not a curriculum a system can run on itself.**
- **The pace is set by hand.** Switch epoch and vocabulary increment are hyper-parameters chosen arbitrarily; the paper's own proposal is to let the learner set `λ` from its own competence frontier — which humans demonstrably do, weighting their own `|Δ PC|` per activity alongside `PC` itself ([[wiki/concepts/learning-progress.md]]), with the pace having a measured **optimum**: final learning is an inverted U in self-challenge, so a schedule can be too slow as easily as too fast. [[wiki/entities/byol.md]]'s EMA and [[wiki/entities/neuromatch.md]]'s plateau trigger are the wiki's only two self-paced instances, and neither was designed as a curriculum.
- **Does the gain survive better optimisers?** The mechanism is basin selection under SGD on a 2009-era deep network — precisely the regime that residual connections, normalisation and adaptive optimisers were built to fix. No source in the wiki re-runs a curriculum ablation at modern optimisation quality, and the continuation-method account **predicts the effect should shrink toward the convex-case 0.8 points** as the objective becomes easier to descend. This is the single cheapest experiment the page implies.
- **Entropy-monotone is an odd requirement to inherit.** Condition (3) forbids ever *removing* an example, yet the DNC needs explicit re-injection of old lessons to avoid regression, and [[wiki/concepts/continual-learning.md]] exists because sequential training without re-injection forgets. A nested-support curriculum is a full-replay continual-learning schedule; the interesting schedules — the ones that do not store everything — all violate the definition.
- **Curriculum and capacity are confounded in the entire literature it descends from.** See `T351`.

---

## Connections

- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — that page makes the curriculum part of the *measurement* (`GD` is conditioned on `TrainSol^opt_{T,C}`, the shortest program optimal on the curriculum) and then says no procedure generates one; this page supplies the generated object's definition and two conditions, so "expressed intelligence rises with a better curriculum" acquires a space to be better *in*.
- **[[wiki/concepts/meta-learning.md]]** — the same task sequence with the opposite reading of `λ`: a meta-learner samples `p(T)` i.i.d. and asks what the average installs, a curriculum orders it and asks what the *order* installs — and Bengio's continuation account says ordering buys a basin, which no meta-learning objective in the wiki scores.
- **[[wiki/concepts/inductive-bias.md]]** — Baxter's `Q` is a fixed environment distribution and this page is what happens when `Q` is made a function of training time; the two bounds compose badly on purpose — `er_Q(H)` is silent about order, and a curriculum's entire claim is that order is worth points at fixed `H` and fixed data.
- **[[wiki/concepts/developmental-heterochrony.md]]** — the capacity schedule to this page's data schedule: per-module phase offsets decide *when a block exists*, a curriculum decides *what it is shown*, and Elman 1993's "starting small" fused the two — which is why `T351` is open and why `G100` and `G32` are separate rows.
- **[[wiki/concepts/continual-learning.md]]** — a curriculum is a training-order schedule that is allowed to keep everything, and continual learning is the same schedule under a no-storage constraint; Bengio's entropy-monotonicity condition is exactly the full-replay assumption, so every interesting continual schedule falls outside the definition.
- **[[wiki/concepts/compositionality.md]]** — supplies the one non-arbitrary easiness measure in the wiki: when the target relation composes (subgraph containment under sum aggregation), hop `k` is learnable only once hop `k−1` holds, so "easy" is fixed by the task's algebra rather than by an oracle.
- **[[wiki/entities/neuromatch.md]]** — the wiki's cleanest curriculum ablation (−6% and higher variance without it), and the case where the schedule is *self-paced* (increment on plateau) and *justified* (composition), which is both of the things this page lists as missing.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the strongest necessity claim in the wiki (a 25-lesson curriculum is essential everywhere except bAbI, 98.8% vs 37%) and the clearest violation of the definition's nesting condition, patched by re-injecting 10% of earlier lessons — evidence that stage sequences forget and that Bengio's monotone-weight condition is doing real work.
- **[[wiki/entities/irene.md]]** — the non-monotone counter-case: adding a training task can *remove* capability, so the curriculum unit is the distribution of latent-variable variation a task induces, not the task, and no easy-to-hard ordering over task identities can express it.
- **[[wiki/entities/byol.md]]** — the wiki's only automatic curriculum, and one that anneals a *target* rather than a data distribution: the EMA raises the predictor's achievable goal as the representation stabilises, which is a continuation method with `λ` read off the learner's own state (`T305`).
- **[[wiki/entities/anli.md]]** — the inverted schedule and the larger effect: hardness selected in closed loop against the live model, entropy *falling* onto its failures, which is outside this page's definition and is the direction `G32`'s generator has to go.
- **[[wiki/entities/i-jepa.md]]** — the reminder that the biggest ordering effect in the wiki is not an ordering at all but a single fixed sampler (15.5 → 54.2), so "design the experience stream" and "sequence it easy-to-hard" are separable design levers with the first currently worth more.
- **[[wiki/concepts/offline-replay.md]]** — the internal version of the same reweighting: replay generates `Q_λ` from already-experienced data, inside the agent and without a teacher, which is the only mechanism in the wiki that could set `λ` without an oracle definition of "easy".
- **[[wiki/concepts/shortcut-learning.md]]** — a curriculum is an intervention on that page's *data* lever with a timing axis added, and the shapes experiment is a warning: an easy set is by construction a set with fewer varying factors, so every curriculum stage is an invitation to install the shortcut the stage does not disambiguate.
- **[[wiki/entities/model-free-episodic-control.md]]** — a data-schedule result arriving from the representation-learning side: MFEC's VAE embedding is trained on 1M frames of a *random policy*, and on Frostbite it is measurably worse than a random projection because a random policy never reaches most of the game — so a learned representation inherits the coverage of the policy that collected its data, which is `Q_λ` chosen by an agent's own incompetence rather than by a teacher.
- **[[wiki/entities/recursive-npi.md]]** — the rejection of the wiki's most common curriculum variable, from inside the program-learning literature (**second-hand** — the claim is Cai et al.'s reading of Zaremba et al. 2016, Reed & de Freitas 2016 and Graves et al. 2016, with no curriculum ablation of their own): length-ordered training "eventually fails after a certain level of complexity" because the semantics being taught never changes while the model keeps fitting length, and the proposed alternative is not a better schedule but a hypothesis class in which length is not a variable of the problem at all.
- **[[wiki/entities/saycam-baby-vision.md]]** — the experience-stream question with the ordering axis deleted: one child's 6–32-month history trained as a single i.i.d. `Q`, no schedule at all, which isolates the *realism* of the stream from its sequence and supplies `G32` its first conversion rate to real experience (~1 week of a child's input, 100× short).

- **[[wiki/entities/ligo.md]]** — the growth-without-curriculum cell of `T351`'s 2×2, now filled: capacity is grown (BERT-Small → BERT-Base, DeiT-S → DeiT-B) with the data distribution held fixed and i.i.d. throughout, and expanding resources on a schedule returns 44.7–55.4% of the FLOPs and *no* change in final quality — so whatever Position B attributes to Elman's expanding resources does not appear as a main effect here, and the cell still missing is the interaction one.
- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — the self-paced `λ` this page lists as missing, supplied by a reward function rather than a schedule: learning-progress motivation plus adaptive region splitting orders a robot's own experience from body babbling through object affordances, given only an unlabelled list of sensors and motors (Oudeyer & Kaplan 2007) — a curriculum whose difficulty measure is the derivative of the learner's own prediction error, and therefore needs no oracle notion of "easy".
- **[[wiki/concepts/information-sampling-vs-search.md]]** — the human measurement of the self-paced `λ` this page lists as missing: adults given no instructions and a set of games of varying difficulty survey the whole set, hold at **70–80% correct** for most of a session and then move to harder games, which is the operating point a learning-progress maximiser is predicted to converge to and a checkable target for any self-generated machine curriculum (Gottlieb & Oudeyer 2018).
- **[[wiki/concepts/hindsight-goal-relabelling.md]]** — the automatic `λ` this page asks for, driven by failure rather than by competence: the training distribution is over *goals*, each episode contributes the goals it actually reached, and the support therefore walks outward with the policy — no oracle easiness measure, no switch epoch, and neither of the two conditions satisfied (the support moves rather than nesting), while taking three manipulation tasks from 0 to solved (Andrychowicz et al. 2017).
- **[[wiki/concepts/learning-progress.md]]** — the self-paced `λ` of this page's open problem, fitted to 382 humans and with both failure modes named: the uninstructed under-challenge (easiest activity above chance) and the instructed over-challenge (36.92% of trials on an unlearnable activity), with best learning at intermediate self-challenge — so "let the learner set the pace" is a *two-sided* miss, and the term that prevents the over-challenge arm is the derivative of competence, not competence (Ten et al. 2021).
- **[[wiki/entities/multiscale-tracing-network.md]]** — a competence-triggered curriculum along the axis that is also the generalisation axis: curves grow one pixel each time test accuracy reaches 85%, training stops at 7 px, and the network then traces 30-px curves at 100% — so the schedule's support does not have to cover the test regime when the learned operation is distance-independent by construction.
- **[[wiki/concepts/conditioned-reinforcement.md]]** — a developmental stage boundary that is not a schedule: on Hoffman & Ratner's re-reading, imprinting's critical period is the window before a *second* maturing process (fear of novelty) gates off the exposure the pairing needs, and birds prevented from escaping imprint well outside it — so the stage emerges from two learners interacting rather than from a clock `(tentative)`.
- **[[wiki/concepts/learned-industriousness.md]]** — a curriculum prescription about the *reward contingency* rather than the difficulty schedule, and the quantity it transfers is a price rather than a skill: rewarding high performance across a **variety** of tasks, with total trial count equated, produced broader transfer than the same volume on a single task, and tagging the training episode with a broad verbal category widened transfer further. It also supplies a negative for the easy-increment schedule — continuous reinforcement of small attained increments yields *less* later resistance to failure than intermittent reinforcement does.
