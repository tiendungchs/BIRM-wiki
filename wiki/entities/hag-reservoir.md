# HAG (Hebbian Architecture Generation) — grown reservoirs

**An unsupervised rule that *builds* a recurrent weight matrix from nothing: start with `W = 0`, and every time a neuron falls outside a homeostatic band on its own firing statistic, grow one incoming synapse from whichever other off-band neuron its activity correlates with most over a randomly-sampled time window. Only the linear readout is ever trained** (Cazalets et al. 2025).

The wiki's first entry where the object being learned is the **graph of the network**, not the values on it. Every other write rule in [[wiki/concepts/synaptic-plasticity.md]] moves weights inside a connectivity pattern the designer fixed; HAG fixes nothing and lets the input statistics decide which edges exist. That makes it the wiki's only algorithmic — as opposed to hand-pulled — instance of the architecture lever that [[wiki/architectural-gaps.md]] G29 says is the heaviest and the least searchable.

---

## The substrate: reservoir computing / echo state networks

Reservoir Computing (RC) transforms an input stream into a high-dimensional dynamical state with a **random, fixed** recurrent network, and trains only a linear readout on top.

| Component | Statement |
|---|---|
| Reservoir | `x[t+1] = σ(W x[t] + W_in u[t] + b)`, `x ∈ R^n`, `σ = tanh`, `u[t] ∈ R^d` multivariate |
| Readout | `y[t+1] = W_out x[t+1] + b_out` — **the only trained parameters**, fitted by ridge regression (closed form) |
| Justification | Cover's theorem: a nonlinear lift into higher dimension raises the probability that the classes are linearly separable |
| Why it is used | No gradient, no backpropagation-through-time, competitive in low-data regimes, and directly implementable on neuromorphic and photonic substrates |

**The standing complaint the paper attacks.** The reservoir is random and static — "the antithesis of the optimal", since it is identical regardless of the task — so performance is chance-dependent, there is no unsupervised adaptation, and no criterion says whether a given reservoir is suitable. Prior fixes tune the *values* of an already-wired reservoir: **Intrinsic Plasticity (IP)** (adjusting per-neuron gain/bias toward a target output distribution), **Anti-Oja** learning, and their combination.

---

## The rule

Initialisation: `W = 0` (no recurrent edges at all); `W_in ~ U(0,1)`; `b_i ~ N(0.1, 0.1)`; inputs min–max scaled to `[0,1]`. **All recurrent weights are constrained non-negative** (`w_ij > 0`, excitatory only); the readout stays signed.

Every `T_current` steps, compute a per-neuron statistic `s_i` and its deviation from a homeostatic set-point:

```
Δz_i = (s_i − ρ_κ) / β_κ ,        κ ∈ {r, v}

mean-HAG      (κ = r):  s_i = ⟨x_i⟩_T          target mean firing rate
variance-HAG  (κ = v):  s_i = σ_{x_i, T}       target activity standard deviation
```

| Condition | Action |
|---|---|
| `Δz_i < −1` (under-active) | **Grow.** Over the set of neurons *not* at homeostasis, compute all pairwise Pearson correlations `r_ij`; take `(i*, j*) = argmax r_ij`; increment the incoming synapse `w_{i*j*} ← w_{i*j*} + δw` |
| `Δz_i > +1` (over-active) | **Prune.** Draw `j` uniformly from `{j : w_ij > 0}` and set `w_ij ← max(0, w_ij − δw)` |
| `\|Δz_i\| ≤ 1` for all `i` | Converged (no formal guarantee; ties and random pruning make the final wiring seed-dependent) |

Three details carry most of the behaviour:

- **`T_current` is resampled every adaptation step** from a log-spaced grid `[T_min, T_max]`, so the rule captures co-fluctuation at many timescales instead of one. (A `FULLINSTANCE` mode sets it to the length of the next sequence.)
- **Growth is correlation-driven, pruning is random.** The authors state the reason plainly: they have *no reliable local criterion for removal* that would increase global dimensionality. Selectivity exists on the write side and not on the erase side — [[wiki/architectural-gaps.md]] G19 in a form the wiki had not seen, since the usual complaint is about writes.
- **Edges come out reciprocal.** `r_ij = r_ji`, so when `j*` is processed as a target it picks `i*` back; asymmetry arises only when random pruning removes one direction. The grown graph is therefore **symmetric by construction** — a nodes-not-edges structure in the sense of [[wiki/concepts/attractor-dynamics.md]]'s `J = J^S + J^A` decomposition.

**variance-HAG needs a second brake**: if any state exceeds `θ_sat`, that neuron's weights are scaled down by `η_sat` — synaptic scaling added on top of the structural homeostasis, because raising activity *variance* does not itself bound activity.

**The long window is the claimed novelty.** Existing plastic reservoirs (IP, Oja, Anti-Oja, BCM) update on moment-to-moment coactivity. HAG computes a **linear correlation coefficient over a window**, i.e. a statistical rather than instantaneous view of co-activation, and the paper's headline empirical claim is that this is what separates it from the local-rule baselines it beats.

---

## Results

Setup: `n ≈ 500` neurons for every model, enforced by duplicating each of the `d` input channels `k = 500/d` times so that **each reservoir neuron receives exactly one input channel**. Baselines: excitatory-only ESN (E-ESN), signed ESN, IP, Anti-Oja, IP+Anti-Oja, and gradient-trained GRU (Gated Recurrent Unit) / LSTM at the *same* hidden size (which over-parameterises the gradient baselines relative to a sparse reservoir — a deliberate bias against HAG). 8 seeds.

| Task family | Datasets | Outcome |
|---|---|---|
| **Classification** (sequence → final state → ridge readout) | Japanese Vowels, CatsDogs, FSDD (Free Spoken Digit Dataset), Spoken Arabic Digits, Speech Commands | HAG variants take the **best mean rank overall**; beat *every* ESN variant everywhere; beat GRU/LSTM on the small datasets, competitive on medium, lose on the largest (Speech Commands). mean-HAG wins small, variance-HAG wins large |
| **Forecasting** (5-step-ahead, sequence → sequence) | Mackey-Glass, Lorenz, Sunspot | **Marginal.** mean-HAG above static reservoirs, variance-HAG comparable to local-rule ESNs; GRU/LSTM clearly better on Lorenz and Sunspot and clearly worse on Mackey-Glass (data quantity is the discriminator) |

The forecasting/classification split is the paper's own diagnosis and it is the interesting one: **decorrelation helps separability and hurts memory.** Adaptive connectivity expands the feature space but disrupts the stable temporal representations long-range prediction needs.

### What the grown wiring does to the code

| Metric | Static excitatory ESN → mean-HAG / variance-HAG | Reading |
|---|---|---|
| **Spectral radius** | Japanese Vowels 0.72 → 0.98 / 1.24; FSDD 0.97 → 1.01 / 2.89; Speech Commands 1.00 → 0.98 / 1.99 | variance-HAG systematically pushes `ρ(W)` **above 1**, i.e. past the naive echo-state-property bound, and is held stable only by the saturation rescaling. Memory horizon bought at the cost of the stability guarantee |
| **Mean pairwise \|r\|** | Japanese Vowels 0.445 → 0.081 / 0.065; FSDD 0.890 → 0.329 / 0.169; Speech Commands 0.994 → 0.570 / 0.476 | The headline: a static excitatory reservoir on a hard task is *almost perfectly synchronous* (0.994) and therefore carries ~one dimension. Growth is what breaks the lock-step |
| **Distance correlation** (zero iff statistically independent, so it sees nonlinear coupling too) | HAG **matches or beats fully signed excitatory–inhibitory ESNs** | Decorrelation achieved *without inhibitory weights* — see below |
| **CEVD** (Cumulative Explained Variance Dimensionality: fewest PCs reaching 90% variance) | CatsDogs 7.25 → 13.0 / 10.75; FSDD 1.5 → 12.0 / 14.75; Speech Commands 1.0 → 9.0 / 13.0; Spoken Arabic Digits 10.25 → 9.0 / 10.25 (the one exception) | Effective subspace expands, but *moderately* — see the trade-off below |
| **Cluster quality** (inter/intra distance ratio, silhouette, Davies-Bouldin, Calinski-Harabasz) | A HAG variant is best in **13 of 20** dataset × metric cells, and at least one HAG variant is best in **17 of 20**; best cumulative rank overall | Tighter within class *and* further between classes — the two things a linear readout needs |

**IP and Anti-Oja never surpass HAG and seldom exceed even the static ESN.** The paper's own contrast with the prior literature: IP+Anti-Oja, reported elsewhere as the best plasticity combination, does not reliably beat a static reservoir here.

### Rewiring buys what inhibition buys

Static excitatory-only reservoirs are highly redundant (`|r| > 0.4` everywhere, → 0.994 on the hardest task); signed reservoirs decorrelate because positive and negative couplings partly cancel. HAG closes most of that gap **using only positive weights**, and on distance correlation — which penalises nonlinear synchrony that `|r|` misses — it matches or beats the signed networks outright. The stated motivation is hardware: substrates that natively realise only non-negative weights otherwise need `w = w⁺ − w⁻` differential pairs, doubling device count.

### The result the wiki should carry: expansion is not the objective

Plotting mean CEVD against mean intra-class distance, with marker size = accuracy, the best models do **not** sit at high CEVD. HAG occupies a small region of *moderate* expansion with near-optimal within-class compactness, and architectures that push CEVD higher fail to convert it into accuracy:

> beyond a dataset-dependent tipping point, extra principal components mainly inject noise and erode class structure.

The paper's own refinement of its claim: HAG performs a **minimal-sufficient expansion** that organises variance along *discriminative* directions, rather than an indiscriminate increase in dimensionality. Cover's theorem licenses the lift; it does not license maximising it ([[wiki/empirical-tensions.md]] T75).

---

## Limitations

| Limitation | Consequence |
|---|---|
| **Unsupervised means input-statistics-specific, not task-specific** | No label, reward or error touches `W`. "Task-specific adaptation" means adapted to the *input distribution*, so HAG can only sculpt whatever separability the input statistics already imply — it is the structural analogue of the shortcut objection in [[wiki/concepts/shortcut-learning.md]] |
| **Excitatory-only recurrence** | Deliberate (neuromorphic substrates), but it removes every inhibitory mechanism the wiki elsewhere treats as the control surface for coding format ([[wiki/concepts/inhibitory-control-of-coding.md]]) |
| **No convergence guarantee; random pruning** | Final wiring is not unique across seeds on the same series. The rule is a stochastic search, not an optimiser of a named quantity |
| **No objective is named** | By [[wiki/concepts/three-component-framework.md]]'s criterion the rule is only shown to *change* usefully; the quantity it ascends is measured post hoc (decorrelation, cluster separability), not derived |
| **Symmetric grown graph** | Correlation is symmetric, so the rule cannot express a directed edge — the primitive [[wiki/concepts/latent-graph-discovery.md]] most needs. Compare spike-timing-dependent plasticity, whose whole content is the sign flip at `Δt = 0` |
| **Scale and scope** | `n ≈ 500`, five audio/speech classification sets and three chaotic series; the largest dataset is where HAG loses to gradient training |
| **Growth happens in a pretraining pass** | Adaptation runs over a concatenated unsupervised stream before the readout is fitted; nothing tests continued rewiring at deployment, which is the property the wiki wants from a structural rule |

---

## Comparison

| | HAG | Standard ESN | IP / Anti-Oja ESN | [[wiki/entities/dendritic-ann.md]] | STDP ([[wiki/concepts/synaptic-plasticity.md]] rule 2) |
|---|---|---|---|---|---|
| What is learned | **Which edges exist** | Nothing (readout only) | Edge *values* / neuron gains | Nothing — masks handcrafted, then gradient on values | Edge values |
| Initial graph | Empty | Random, fixed | Random, fixed | Handcrafted sparse, fixed | Given |
| Signal driving change | Long-window pairwise correlation, gated by homeostatic deviation | — | Instantaneous coactivity / output distribution | — | Spike order, ms window |
| Directed edges | No (symmetric by construction) | — | No | — | **Yes** |
| Gradient used | None | None (readout is closed-form) | None | Yes | None |
| Selectivity | Growth targeted, **pruning random** | — | Unselective | Chosen by hand | Unselective |

---

## Why this matters for a reasoning model

- **It is a proof of concept that structure can be searched by a local rule.** G29's stated alternatives were genetic programming (evolution-like cost profile) or hand-building. HAG is a third option that costs one unsupervised pass: architecture search whose step is a synapse, not a candidate network, and whose signal is the data itself.
- **It separates two things the wiki has been conflating.** "Dimensionality" splits into *task-agnostic expressivity* (how spread out the states are) and *task-relevant effective dimensionality* (how many directions separate the classes). The paper measures both and shows they come apart — the second is what predicts accuracy, and the first can be raised while the second falls.
- **Homeostasis as the write gate.** The rule fires only for neurons outside a set-point band, so *what to change* is decided by a per-neuron scalar with no error, no label and no reward. That is the cheapest write-licensing mechanism in the wiki, and unlike BTSP's plateau it needs no unexplained instructive pathway ([[wiki/concepts/synaptic-plasticity.md]] open problems).
- **(brainstorm) The natural extension is to make pruning as selective as growth.** The rule already computes the full pairwise correlation matrix over off-band neurons; the obvious erase criterion — prune the incoming edge whose partner is *most* redundant with the neuron's other inputs — is one line and would turn HAG from "grow correlated, forget randomly" into a decorrelation objective on the graph. The authors say they lacked such a criterion; the one they lacked appears to be available from the statistic they already compute.
- **(brainstorm) HAG grows a graph over neurons; the wiki wants a graph over *states*.** The two are the same problem at different addresses, and the missing piece is identical in both — the rule can wire co-active units together but cannot say that the wiring it built in one environment is the *same structure* it should reuse in the next. Structural plasticity supplies an instance-graph builder and, like every rule on [[wiki/concepts/synaptic-plasticity.md]], is silent about the meta-graph.

---

## Connections

- **[[wiki/concepts/synaptic-plasticity.md]]** — the rule family this extends by changing what a "write" is: every rule there moves a weight inside a fixed connectivity pattern, HAG creates and destroys the connections themselves, and gates the decision on a homeostatic set-point rather than on pre/post coincidence. It also supplies that page's sharpest counter-datum on timescale — long-window correlation beats moment-to-moment coactivity rules (IP, Anti-Oja) on every classification task tested.
- **[[wiki/architectural-gaps.md]]** — moves G29 off `OPEN`: architecture search executed by a local unsupervised rule at the cost of one pass over the data, in a restricted setting (recurrent wiring within a fixed neuron pool, symmetric edges, excitatory only). It also relocates G19 to the *erase* side, since HAG's growth is targeted and its pruning is explicitly random for want of a local criterion.
- **[[wiki/concepts/population-geometry.md]]** — a model-side measurement of the same quantity that page measures in brains, with the opposite sign of conclusion about expansion: raising the linear effective dimensionality of a code past a dataset-dependent threshold *degrades* class structure, so a high participation-ratio code is not a better code ([[wiki/empirical-tensions.md]] T75).
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the cheap substitute for inhibition: rewiring an excitatory-only network by long-window correlation drives pairwise and *distance* correlation down to the level a signed excitatory–inhibitory reservoir reaches, so decorrelation is obtainable from graph structure instead of from opposing signs.
- **[[wiki/entities/dendritic-ann.md]]** — the exact complement: both argue a sparse task-shaped graph is what matters, one fixes the graph by hand before training and learns the values by gradient, the other grows the graph from data and never learns a recurrent value by gradient at all.
- **[[wiki/concepts/attractor-dynamics.md]]** — the grown matrix is symmetric (`r_ij = r_ji`), so HAG builds only the `J^S` half of that page's decomposition — fixed points but no traversal — and it is the wiki's one case of the recurrent topology being *derived from data* rather than imposed by translation-invariant wiring (G47).
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the same expansion-recoding premise (Cover's theorem: lift, then separate linearly) with an empirical ceiling attached: past a dataset-dependent point extra dimensions add noise rather than separability.
- **[[wiki/entities/spiking-neural-networks.md]]** — the deployment target the excitatory-only constraint is chosen for: substrates realising only non-negative weights otherwise need `w = w⁺ − w⁻` differential pairs, and the paper's claim is that grown structure buys back what the missing sign would have provided.
- **[[wiki/concepts/three-component-framework.md]]** — a rule that changes the *architecture* slot rather than the learning-rule or objective slot, and one that fails that page's demand in an instructive way: no quantity is named that HAG ascends, so its decorrelation and separability gains are measured rather than derived.
- **[[wiki/concepts/latent-graph-discovery.md]]** — structure discovery run one level down, on the network's own wiring instead of on the environment's states; the limitation transfers exactly, since a symmetric correlation-grown edge is not a directed transition and nothing carries the grown structure across environments.
- **[[wiki/concepts/shortcut-learning.md]]** — the shortcut objection transposed onto architecture search: an unsupervised structural wiring rule connects whatever co-fluctuates, so a high-variance nuisance regularity earns an edge as readily as a task-relevant one — 'task-specific' means specific to the input distribution, never to the task.
