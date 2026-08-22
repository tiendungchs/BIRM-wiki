# CN-DPM — Continual Neural Dirichlet Process Mixture

**Task-free continual learning as online variational inference of a Dirichlet-process mixture whose components are neural experts: forgetting is eliminated by construction, and the entire remaining error moves to the *retrieval* step.** Lee, Ha, Zhang & Kim 2020, ICLR (arXiv:2001.00689).

This is the wiki's first *expansion*-family continual learner with a working allocation rule, and its most valuable content is a negative result the paper reports on itself: per-expert classifiers forget essentially nothing (88.20% → 88.20% on Split-CIFAR10), and end-to-end accuracy is 45.21% because the gate that picks the expert is right 48.18% of the time. The authors name expert selection "the main bottleneck". That is the first number the wiki has for gap **G37** (*nothing decides which stored structure applies*), and it says the retrieval step, not the storage step, is where an expanding memory fails.

---

## Architecture

| Component | Form | Role |
|---|---|---|
| Expert `k` | a pair `(p(y∣x; φ_k^D), p(x; φ_k^G))` — a classifier **and** an explicit density model (VAE) | jointly models `p(x,y ∣ z=k)`; the density half exists *only* to gate |
| Count `N_k` | `Σ_n ρ_{n,k}`, the soft data mass assigned to expert `k` | the Chinese-restaurant prior term |
| Novel component `k = K+1` | `φ̂_0 ∼ G_0`, `G_0` = the weight-initialisation distribution | the always-present "none of my experts" hypothesis |
| Short-term memory `ℳ` | FIFO buffer, capacity `M` (500 MNIST / 1000 CIFAR) | holds data judged novel until there is enough to fit a new expert |
| Lateral connections | new expert reads the frozen features of all earlier experts, **gradients blocked** | forward-only transfer; ≈38% parameter saving at no accuracy cost (Appendix K) |

**Responsibility (the one equation).** For arriving `(x_{n+1}, y_{n+1})`:

```
ρ_{n+1,k} ∝ N_k · p(y_{n+1} ∣ x_{n+1}; φ̂_k^D) · p(x_{n+1}; φ̂_k^G)     1 ≤ k ≤ K
ρ_{n+1,K+1} ∝ α · p(y_{n+1} ∣ x_{n+1}; φ̂_0^D) · p(x_{n+1}; φ̂_0^G)
```

i.e. **CRP prior × joint generative likelihood**, evaluated fresh on every single sample. Sequential Variational Approximation (Lin 2013) replaces the intractable posterior; because `G_0` and the likelihood are not conjugate, `φ̂_k` is an SGD MAP estimate, updated with the gradient **scaled by `ρ_{n,k}`** (Eq. 4).

**Inference** is a mixture, not a selection: `p(y∣x) ≈ Σ_k p(y∣x; φ_k^D) · p(x; φ_k^G) p(z=k) / Σ_{k'} p(x; φ_{k'}^G) p(z=k')`.

---

## The two-timescale training loop

| Phase | Trigger | What happens |
|---|---|---|
| **Wake** | `argmax_k ρ_{n,k} ≠ K+1` | every existing expert updates by `ρ_{n,k}·λ·∇ log l_k` — a responsibility-scaled write across the whole library |
| **Buffer** | `argmax_k ρ_{n,k} = K+1` | the sample goes to short-term memory; **no expert is created yet** |
| **Sleep** | `∣ℳ∣ ≥ M` | the data stream is *halted*, a new expert is trained on the buffer for multiple epochs to convergence, `ℳ` is emptied |

Two design facts worth carrying:

- **The buffer exists because one sample cannot fit a neural expert.** A DP mixture over Gaussians allocates on the spot; a DP mixture over networks cannot, so the allocation decision and the allocation *act* are separated by `M` samples. That delay is what makes the mechanism implementable at all, and it is also its main assumption.
- **The assumption the buffer smuggles in is temporal autocorrelation.** "This STM trick assumes that the data in the STM belong to the same expert" — justified only by "adjacent data are highly correlated" in CL streams. So the method is task-free but not *order*-free: it substitutes stream autocorrelation for the task label it refuses to be given. It survives a graded test — **Fuzzy Split-MNIST**, where tasks cross-fade rather than switch, gives 93.22% against a clean-boundary 93.23% — but nothing tests an i.i.d.-shuffled stream.

---

## Key results

All numbers averaged over 10 runs; no task identity at train **or** test, so Split-CIFAR100 is genuine 100-way classification (most prior work uses per-task heads and reports 5-way).

| Scenario | CN-DPM | Reservoir (experience replay) | iid-online | Fine-tune | Params (CN-DPM) |
|---|---|---|---|---|---|
| Split-MNIST | **93.23** | 85.69 | 96.18 | 19.43 | 524 K |
| Split-MNIST (generation, bits/dim ↓) | **0.2110** | 0.2234 | 0.2156 | 0.2817 | 970 K |
| MNIST-SVHN | 94.46 | 94.12 | 95.24 | 83.35 | 7.80 M |
| Split-CIFAR100 (20 tasks) | **20.10** | 10.01 | 20.46 | 2.43 | 19.2 M |
| Split-CIFAR10, 0.2 epoch | **41.78** | 37.09 | 36.65 | 12.68 | 4.60 M |
| Split-CIFAR10, 1 epoch | **45.21** | 44.00 | 62.79 | 18.08 | 4.60 M |
| Split-CIFAR10, 10 epochs | **46.98** | 43.82 | 83.19 | 19.31 | 4.60 M |

Gradient-Based Sample Selection (Aljundi et al. 2019b), the task-free replay baseline, scores 33.56 on Split-CIFAR10/0.2-epoch — **below plain reservoir sampling**, which the authors flag.

**The dissection that matters (Table 3).**

| Accuracy type | Split-CIFAR10 | Split-CIFAR100 |
|---|---|---|
| Responsible classifier, at end of its own task | 88.20 | 55.42 |
| Same classifier, after all tasks | **88.20** | **55.24** |
| **Gating (the VAEs picking the expert)** | **48.18** (5 experts) | **31.14** (20 experts) |

Forgetting is ≤0.2 points. The system loses ~40 points at the gate. And the gate degrades with library size — 48% over 5 components, 31% over 20 — which is the wiki's only measured **scaling law for retrieval over a growing store**.

**Two more diagnostics.**

- **Replay overfits its own buffer; expansion does not.** Extend each task from 1 to 10 epochs and Reservoir *drops* (44.00 → 43.82) while CN-DPM *rises* (45.21 → 46.98). A replay buffer is a fixed sample repeatedly presented as the past; CN-DPM's buffer is transient scaffolding discarded at each sleep, so the two memories of the same size age in opposite directions.
- **The advantage grows with task count.** At 20 tasks / 100 classes CN-DPM doubles Reservoir (20.10 vs 10.01) and matches i.i.d. online training, because a 1000-slot replay buffer is 50 exemplars per task while an expert pool simply grows.

---

## The knobs, and who turns them

| Knob | What it does | Who sets it |
|---|---|---|
| `α` (DP concentration) | sensitivity to novelty ⇒ number of experts; bounded `O(α log N)` | **hand-set per scenario so that exactly the intended number of experts is created** |
| `M` (STM capacity) | how much evidence is collected before committing to a new expert | hand-set |
| Classifier temperature (0.01) | rescales `log p(y∣x,z)` against `log p(x∣z)`, whose ranges differ by orders of magnitude | hand-set; without it "the classifier has almost no effect" |
| Merge threshold `ε` | cosine similarity between experts' per-datum log-likelihood vectors `l_{·k}`; above it, drop the expert with smaller `N_k` and reassign its mass | hand-set (0.9) |

**The `α` sweep is the honest part of the paper** (Appendix J, Split-MNIST):

| `log α` | Accuracy | Experts | Params |
|---|---|---|---|
| −600 | 54.04 | 3.20 | 362 K |
| −400 | **93.23** | 5.00 | 524 K |
| 80 | 93.54 | 14.4 | 1.44 M |

A 200-nat error in one scalar costs 39 accuracy points. The authors' defence is a *transfer* argument, not a learning one: `α` tuned on letters a–m should work on n–z "because the alphabets would have a similar level of discrepancies between tasks" — i.e. `α` is a property of the environment family, assumed stationary, and there is no mechanism that estimates or adapts it. This is gap **G38** stated in its sharpest form: the allocate-vs-reuse threshold decides the whole result and is supplied by the designer.

**Pruning is the one thing that runs after the fact.** Set `α` too high (7 experts on Split-MNIST), build the `K×K` cosine-similarity matrix of log-likelihood vectors, threshold at 0.9, drop the smaller of each redundant pair: accuracy 87.07 → 86.01. So the library can be *audited for redundancy from its own likelihood profiles* with no labels, no task identity and no held-out data — a cheap, general instrument the wiki's other growing stores do not have.

---

## Why the gate must be generative — and what that costs

The paper's central architectural argument, stated in one line: a single learned gate network `p(z∣x)` **cannot** be used, because the gate is itself a classifier over a growing label set trained online, so it catastrophically forgets exactly like the thing it is gating. The only forgetting-free gate is Bayes' rule over per-expert density models, `p(z=k∣x) ∝ p(x; φ_k^G) p(z=k)`.

That argument closes a loop but opens a worse one:

| | What it buys | What it costs |
|---|---|---|
| Learned router | one small network, discriminatively trained on exactly the decision that matters | forgets; needs the task labels it was supposed to replace |
| **Generative gate (CN-DPM)** | never forgets; requires no labels, no boundaries, no replay | **each expert must carry a full density model of its inputs**, and end-to-end accuracy is capped by that density model's discriminability — 48% at `K=5` |

**(brainstorm)** The failure is diagnosable rather than mysterious. A VAE's ELBO on natural images is dominated by low-level pixel statistics; two CIFAR superclasses have nearly identical ones, so the likelihood ratio the gate needs is close to 1 while the *class* information the classifier needs is intact — the gate is being asked to do out-of-distribution detection with a generative model, which is the known-hard case in that literature. Three exits, none tried here: (i) gate on the *classifier's* confidence rather than the density (fails for the same forgetting reason only if the classifier is shared — per-expert confidences are as forgetting-free as per-expert densities); (ii) gate on a **frozen** representation so the density model works in a semantically organised space rather than pixel space; (iii) do not gate at all — read the mixture, and accept the density term only as a soft prior, which is what the temperature hack is already doing by hand.

---

## Comparison to related models

| | **CN-DPM** | [[wiki/entities/coin-model.md]] | [[wiki/entities/c-ts-model.md]] | [[wiki/entities/hidden-state-inference-remapping.md]] |
|---|---|---|---|---|
| Prior | Chinese restaurant, one `α` | sticky HDP, `γ, κ, α` | Chinese restaurant, one `α` | Chinese restaurant |
| What a component holds | **a classifier + a density model — millions of parameters** | one scalar | a stimulus→action policy | a place-field map |
| Evidence for allocation | joint likelihood `p(x,y∣φ_k)` under a *learned deep* density | Kalman residual under a linear-Gaussian model | reward under the policy | observation likelihood under the map |
| Allocation act | **deferred `M` samples, then offline fit to convergence** | immediate | immediate | immediate |
| Expression | responsibility-weighted mixture | responsibility-weighted mixture | argmax collapse | posterior-weighted remapping |
| Update | **all** experts, `ρ`-scaled | **all** memories, `ρ`-scaled | one | — |
| Retrieval quality | **measured: 48.18% / 31.14%** | not separable from the fit | inferred from error types | inferred from remapping category |
| Composition between components | none (lateral feature reuse only, one-directional) | none | none | none |

The row that only this page can fill is the last-but-one. Every other nonparametric account in the wiki reads its retrieval accuracy off a model fit to behaviour, where retrieval error and state error are entangled. CN-DPM has ground-truth task labels available at evaluation time and simply reports the gate's accuracy against them.

---

## Limitations

- **`α`, `M`, the temperature and the merge threshold are all hand-set**, and `α` is set *so that the known number of tasks is produced*. The task label is refused at train time and re-enters through hyperparameter selection.
- **Capacity grows without bound in principle** (`O(α log N)`), and does grow in practice: 19.2 M parameters on Split-CIFAR100 against an 11.2 M single ResNet-18 baseline that scores 20.46 i.i.d. The parameter comparison is favourable only on Split-CIFAR10 (4.60 M).
- **Sleep halts the stream.** The agent stops consuming data while a new expert is fit — acceptable offline, undefined for an embodied agent.
- **Experts are atoms.** Lateral connections give forward-only feature reuse; there is no factorisation letting expert 6 be "expert 3 with one edge changed", and no backward transfer at all (an earlier expert can never be improved by later data — that is exactly why it never forgets).
- **No composition of experts on a single input.** The mixture averages predictions; nothing routes different *parts* of one input to different experts.
- Absolute accuracies are low (45% on CIFAR10, 20% on CIFAR100). The setting is unusually hard — fully online, single-pass, no task identity at test — but nothing here reasons; it classifies.

---

## Connections

- **[[wiki/entities/continual-dreamer.md]]** — the opposite extreme of the same task-agnostic problem: a world model that shares *everything* across tasks has no gate to fail and therefore no retrieval loss, and pays instead in interference — a buffer holding the old goal prevents learning a new one in an identical environment.
- **[[wiki/concepts/continual-learning.md]]** — the expansion row of that page's solution table, measured end to end: forgetting is eliminated (88.20 → 88.20) and the cost is not the parameter count the row names but a **retrieval failure at the gate**, so the family's real price is a growing library nothing can index accurately.
- **[[wiki/concepts/contextual-inference.md]]** — the same allocate-vs-reuse posterior with the component's contents scaled from a scalar to a deep classifier + density model, which forces two changes that page's formalism does not have: allocation must be *deferred* until enough evidence accumulates to fit the component, and the responsibility likelihood must be a learned generative model whose discriminability then becomes the binding constraint.
- **[[wiki/entities/coin-model.md]]** — the sibling with the richer prior and the poorer contents; this model shows what happens to the same machinery when a memory is a network rather than a number — the posterior still works, and its accuracy becomes the system's ceiling.
- **[[wiki/entities/c-ts-model.md]]** — the argmax counterpart on the retrieval question (T108); this model splits the difference by *operation* — argmax for the allocate-or-not decision, responsibility-weighted mixture for expression and for updating — which is a shape neither side of that tension had.
- **[[wiki/concepts/complementary-learning-systems.md]]** — a machine instantiation of the two-store loop with the transport direction inverted: the fast store buffers only *unexplained* items and its consolidation product is a **new slow module** rather than an update to an existing one, so nothing is ever interleaved into an old learner and nothing can be revised.
- **[[wiki/concepts/offline-replay.md]]** — the anti-replay datum: the same buffer size aged in opposite directions over 10 epochs per task (Reservoir 44.00 → 43.82, CN-DPM 45.21 → 46.98), because a replay buffer is a fixed sample re-presented as the past while this buffer is discarded at every sleep.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the allocate-vs-reuse decision made by a likelihood ratio against `α` instead of by a similarity threshold, with the price of getting the threshold wrong measured: a 200-nat error in `log α` costs 39 accuracy points (gap G38).
- **[[wiki/concepts/latent-graph-discovery.md]]** — an expanding library of instance-graphs with no meta-graph: experts share features one-directionally and nothing is factored, so the system pays a new module for every environment and gets `ℐ → 0` on [[wiki/concepts/intelligence-density.md]]'s scale.
- **[[wiki/concepts/event-segmentation.md]]** — segmentation without a segmenter: a boundary is never declared, and the only thing that plays the role of one is the buffer filling up, which makes the *granularity* a function of `M` and `α` jointly rather than of any property of the stream.
- **[[wiki/concepts/amortized-inference.md]]** — the argument against amortising the router: a learned gate `p(z∣x)` is itself an online classifier over a growing label set and therefore forgets, so the retrieval step is forced back to explicit Bayes over per-component generative models.
- **[[wiki/entities/hami.md]]** — the same growing library reached by the cheap route: a cosine-similarity threshold mints a discrete key where this model runs a likelihood ratio against a CRP prior; both hand-set the threshold, and only this one reports what fraction of retrievals are correct.
- **[[wiki/entities/conceptor.md]]** — the other continual learner that can read its own library: quota `q` says *how full* the shared space is, where this model's likelihood-vector cosine matrix says *which stored components are redundant with each other* — two label-free self-audits of a growing store, neither of which the other has.
- **[[wiki/entities/hag-reservoir.md]]** — growth as a learning mechanism at the other granularity: one synapse per step under a homeostatic local rule, against one whole expert per sleep phase under a Bayesian nonparametric criterion.
- **[[wiki/entities/ch-hnn.md]]** — the same relocation of forgetting into a retrieval step, routed the opposite way: a soft per-neuron binary mask over one fixed-size network, emitted by a feedforward pass over the sample, against this page's hard argmax over per-expert generative likelihoods with linear memory growth — so the two bracket T282's read problem, and only this page scores its gate against ground truth.
