# Adaptive Computation Time

**Attach a sigmoidal halting unit to a recurrent network's output, run the same state transition repeatedly on one input until the halting activations sum past `1−ε`, and take a probability-weighted mean of the intermediate states and outputs — so the number of transitions spent on an input becomes a learned, differentiable, deterministic function of that input rather than an architectural constant.**

> **Provenance.** Graves 2016, *Adaptive Computation Time for Recurrent Neural Networks*, arXiv:1603.08983 (`raw/graves-2016-adaptive-computation-time.md`). Four synthetic tasks (parity, logic, addition, sort) plus character prediction on Hutter-prize Wikipedia; LSTM everywhere except parity (plain RNN); 20 random seeds per time penalty over a logarithmic grid.

This is the wiki's first *mechanism* for a question several pages already name as open and none answers: **what allocates the inference budget** ([[wiki/concepts/external-verification.md]], [[wiki/concepts/refinement-loop.md]]). It answers it for a differentiable inner loop, and it exposes the price of the answer as a single hand-set scalar — the new [[wiki/architectural-gaps.md]] row `G107`.

---

## The algorithm

At input step `t`, run `N(t)` intermediate updates with **shared** transition `S`, output weights `W_y`, halting weights `W_h`:

```
s^n_t = S(s_{t-1}, x^1_t)   if n = 1;      S(s^{n-1}_t, x^n_t)   otherwise
y^n_t = W_y s^n_t + b_y
h^n_t = σ(W_h s^n_t + b_h)                       # halting unit
N(t)  = min{ M , min{ n' : Σ_{n≤n'} h^n_t ≥ 1−ε } }
R(t)  = 1 − Σ_{n<N(t)} h^n_t                     # the remainder
p^n_t = h^n_t for n < N(t);   R(t) for n = N(t)  # Σ_n p^n_t = 1 exactly
s_t   = Σ_n p^n_t s^n_t        y_t = Σ_n p^n_t y^n_t     # mean-field, not a sample
```

`x^n_t = x_t + δ_{n,1}` — a binary flag on the first update only, so the network can tell a repeated *input* from a repeated *computation* on the same input. `ε = 0.01` exists solely so a single update can suffice; without it every step costs at least two. `b_h` is initialised positive and `M` caps `N(t)` (100, or 20 for addition), both to survive early training rather than as parts of the model.

**The cost and its gradient.** Ponder `ρ_t = N(t) + R(t)`, `P(x) = Σ_t ρ_t`, and the trained loss is `L̂ = L + τ·P(x)`. `P` is discontinuous where `N(t)` increments; the paper treats `N(t)` as constant and minimises `R(t)` everywhere, giving for `n < N(t)`

```
∂L̂/∂h^n_t = (∂L/∂y_t)(y^n_t − y^{N(t)}_t) + (∂L/∂s_t)(s^n_t − s^{N(t)}_t) − τ
∂L̂/∂h^{N(t)}_t = 0
```

Two structural facts follow that no prose summary of ACT states. **The halting unit is trained by a *difference* between the intermediate result and the final one** — an update earns its keep only insofar as its state and output differ from the last one, so the signal that funds computation is exactly the marginal change it produces. And **the last update's halting unit receives no gradient at all**: the commitment step itself is unlearnable, because its probability is a remainder fixed by everything before it.

| Decision | Alternative rejected | Why it matters here |
|---|---|---|
| **Mean field** over `p^n_t` | Sample `n̂ ∼ p^n_t` (the stochastic route; used for scene understanding by Eslami et al. 2016) | No stochastic gradient estimate, no added parameter noise. The stated reason is *accumulation*: each halting decision conditions all later ones, so sampling noise compounds along the sequence ([[wiki/concepts/discrete-relaxation-gradients.md]]) |
| **Shared parameters across intermediate steps** | Per-step weights | Keeps "more computation" from silently meaning "more parameters" — the one confound that would make every result here uninterpretable |
| **Learned halting with a gradient** | Activation threshold on a halting neuron (self-delimiting networks, Schmidhuber 2012) | No gradient reaches the halting time in the threshold version, so halting is not *optimised*, only *implemented* |
| **A time penalty `τ`** | Minimise true computation | Minimum-computation is Kolmogorov complexity, hence the halting problem; `τ` is the pragmatic surrender, and `G107` is its bill |

---

## What the experiments actually establish

| Task | Without ACT | With ACT | Ponder vs. difficulty |
|---|---|---|---|
| **Parity** of a 64-element ±1/0 vector, presented *statically* to a plain RNN | ~40% error (50% = chance) | <5% for `τ ≤ 0.03` | Linear in the number of non-zero bits for good `τ`; flat for bad `τ` and for no-ACT |
| **Logic** — recursive application of 1–10 binary gates, carrying the result across steps | ~0.2 sequence error | ~0 for all `τ ≤ 0.01`, converged in ~10k iterations | Clusters at 5–6 steps ≈ mean gate count; abrupt error jump past 5 gates without ACT, read as the ceiling on gates learnable as one composite operation |
| **Addition**, cumulative sum of 1–5-digit numbers | — | Solved perfectly at *every* `τ` in the grid; higher `τ` needed **fewer** training examples | Slope ≈ 1 step per digit at the highest `τ` — a long-addition algorithm, read off the ponder trace |
| **Sort** of 2–15 Gaussians, presented one per step | ~12% error | ~6% error | ~9× the computation for that halving; growth sublinear in sequence length, "whether logarithmic is unclear"; a ponder spike just *before* the end of the input, where the comparisons happen |
| **Wikipedia** character prediction | — | Error essentially unchanged; learning curves slightly more data-efficient; ponder per input much lower than elsewhere | — |

The pattern across the first four: **ACT converts a statically-presented problem into a sequential algorithm the architecture could not otherwise express.** The parity network without ACT has an unused recurrent connection and is a one-hidden-layer feedforward net; with ACT the same weights implement an iterative procedure. Higher `τ` does not simply mean *worse* — it appears to force chunking (compute the parity of larger blocks per step, learn composite truth tables), and on addition it improved sample efficiency.

Two negative results deserve equal weight. **Sort buys accuracy at a 9× compute premium** — the only task where the exchange rate is reported and it is bad. **Language modelling gains nothing**, which is the honest ceiling on the claim: where the per-input computational demand is roughly uniform, a per-input budget has nothing to allocate. The second is contested — [[wiki/entities/universal-transformer.md]] reports 319 → 142 perplexity on LAMBADA from the same mechanism, against fixed-depth controls at its own average depth ([[wiki/empirical-tensions.md]] T321).

---

## The per-position variant, and what changes

[[wiki/entities/universal-transformer.md]] (Dehghani et al. 2019) attaches this halting rule to each *position* of a depth-recurrent Transformer rather than to each input step of an RNN. Halted positions copy their state forward until every position halts or `max_steps` is hit. Four differences worth holding separately from Graves's version:

| | Graves 2016 (this page) | Universal Transformer |
|---|---|---|
| Halting granularity | per input step | **per position**, `m` independent halting units per step |
| Stop pressure | ponder penalty `τ` in the loss | a **bare threshold** hyper-parameter plus `max_steps`; no `τ` in the released implementation |
| What the recurrent step can read | fixed-size state vector only | the **whole previous layer**, via self-attention |
| Effect on accuracy | neutral-to-positive; LM neutral, sort 9× premium | **improves** — bAbI 0.47 → 0.29 joint error, LAMBADA 319 → 142 perplexity, MT *degrades* slightly |

Three results this adds that no experiment here could produce:

- **Ponder time scales with a counted ground-truth quantity.** Mean steps 2.3 ± 0.8 / 3.1 ± 1.1 / 3.8 ± 2.2 for bAbI questions requiring 1 / 2 / 3 supporting facts. This page's Wikipedia analysis showed ponder tracks *reducible structure*; that shows it tracks **number of inference hops**, which is the reading [[wiki/concepts/latent-graph-discovery.md]] needs and the closest thing in the wiki to a hop counter that was never supervised.
- **The budget is spent on suppression as much as on thinking.** On 3-fact tasks (longest stories, most distractors) most positions halt at step 1–2 and a few run long; on 1-fact tasks the ponder histogram is uniform. Allocating compute *away* from a position is how irrelevant facts get dropped.
- **The depth-matched control.** Fixed 8- and 9-step models (202 / 239 ppl) lose to a dynamic model averaging 8.2 steps (142), so the gain is not extra depth. The authors' explanation is that halting acts as a **regulariser**, not as an allocator — a different mechanism, and if it is the right one then the forward-looking-statistic reading above is over-attributed (T321).

Note what does *not* change: the exchange rate is still an external constant. `τ` has become a threshold, unswept and without a reported sensitivity analysis, so `G107` survives the substitution intact.

---

## Ponder time measures reducible structure, not difficulty

The Wikipedia result is the one worth importing even though the loss did not move. Trained with `τ = 6e−3`, the network pauses at spaces between words and pauses longer at commas and full stops — and does **not** pause on the digits of random ID numbers, where prediction loss and predictive entropy both spike.

| Signal | High on hard-but-structured points (clause and sentence boundaries) | High on irreducible noise (random IDs) |
|---|---|---|
| Next-step loss | partly — but not at full stops or commas, which are always followed by a space | **yes** |
| Predictive entropy | partly — same failure | **yes** |
| **Ponder time** | **yes** | **no** |

The reason is stated cleanly in the source and generalises past this experiment: **loss and entropy measure the difficulty of the current prediction; ponder time measures the degree to which the current input will affect future predictions.** Extra computation is only worth buying where it changes something downstream, so a learned compute budget is a *forward-looking* statistic that a per-step uncertainty is not. This is the wiki's first boundary detector whose threshold is trained rather than hand-set ([[wiki/concepts/event-segmentation.md]]), and the first signal here that separates structure from noise rather than ranking both as "surprising".

**(brainstorm)** This also sharpens a stopping rule the wiki has accepted elsewhere. "Iterate until the messages stop changing" ([[wiki/concepts/loopy-belief-propagation.md]]) gives ambiguous inputs longer latencies for free — but *ambiguous* and *irreducibly noisy* are the same thing to a convergence criterion and are opposite things to ACT. A pure-noise input under that rule is the worst case (messages never settle); under ACT it is the cheapest. Whichever behaviour is wanted, the two rules are not interchangeable, and only one of them can be trained toward a downstream objective.

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| `N(t)` | How many relational hops to take before emitting, chosen per observation rather than fixed by depth |
| `h^n_t` | A learned "is the current node's structure already resolved" test, computed from the state it is testing |
| The mean field `Σ p^n s^n` | A commitment that never happens — the answer is a convex mixture over the states at every depth, which only becomes a real halt when training concentrates `p` on one `n` |
| `τ` | The exchange rate between traversal cost and answer quality, which the graph itself should set and does not |
| Ponder trace | A read-out of the *inferred* segmentation of the input into sub-problems — the addition trace is a per-digit loop, the sort trace localises the comparison phase |

The addition and sort traces are the sharpest thing here for this wiki: **the allocation of compute is an interpretable artefact.** Where a chain of thought is a claim about the procedure that must be trusted or verified, the ponder sequence is a measurement of the procedure with a known unit (state transitions), and it recovered "one step per digit" without anyone asking for it.

---

## Limits

- **`τ` is hand-chosen and the behaviour is highly sensitive to it.** The source says so twice and names automatic determination of the accuracy/speed trade-off as the important future work. Every result above required a 20-seed logarithmic grid search. Registered as `G107`.
- **The linearity assumption is load-bearing and only argued.** Mean-fielding states presumes interpolating two state vectors interpolates what they represent. The defence is three-part — high-dimensional representations empirically behave linearly ([[wiki/concepts/linear-representation-hypothesis.md]]), networks tolerate harsh regularisers, and at convergence the halting distribution concentrates and the assumption becomes vacuous. None of these is a measurement on this model.
- **The ponder cost is not differentiable and is treated as if it were.** `N(t)` jumps; the paper minimises `R(t)` everywhere and ignores the discontinuity — a fact corrected in the acknowledgements of the published version, not in the derivation.
- **Depth without width.** ACT buys transitions, not parameters. Nothing here tests whether the same budget spent on parameters would do better, and the shared-weights choice that makes the experiments clean also forbids the comparison.
- **No credit for *what* the computation is.** The halting unit is funded by `(y^n − y^N)` and `(s^n − s^N)` — a measure of how much the extra step *moved* the state, not of whether the movement was correct. A step that changes the state uselessly is indistinguishable from one that changes it usefully, which is the same defect [[wiki/concepts/external-verification.md]] fixes for a rejection loop with a verifier and which ACT has no analogue of.

---

## Connections

- **[[wiki/entities/universal-transformer.md]]** — this mechanism moved onto a depth-recurrent Transformer and made *per position*, where it improves accuracy rather than trading it (bAbI 0.47 → 0.29, LAMBADA 319 → 142 against fixed-depth controls at 202/239) and where its stop pressure is a bare threshold rather than a ponder penalty; it also supplies the measurement this page lacks, ponder time scaling 2.3/3.1/3.8 with the number of supporting facts a question requires.
- **[[wiki/concepts/evidence-accumulation.md]]** — the same commit/keep-going decision with the stopping variable swapped: MSPRT thresholds a *normalised log-posterior over enumerated alternatives* and is asymptotically optimal at that; ACT thresholds a *cumulative halting mass* that is trained toward the downstream loss and requires no enumeration, so it applies where the options do not exist yet — and it pays for that by having no optimality claim, no error-rate guarantee, and a hand-set price on time where the accumulator has a hand-set threshold.
- **[[wiki/concepts/event-segmentation.md]]** — supplies a boundary detector whose threshold is *learned*: ponder time rises at word, clause and sentence boundaries in raw character streams and stays flat on random digits, so segmentation falls out of a compute-allocation objective rather than out of a monitor over predictive encodings, and it separates structure from noise where prediction error and entropy do not.
- **[[wiki/concepts/external-verification.md]]** — the differentiable answer to that page's named open control problem (adaptive test-time compute allocation): a halting unit trained end-to-end against `L + τP` allocates per input with no verifier, no sampling and no reranking — and inherits the complementary weakness, since nothing checks that the extra computation was *right*, only that it changed the state.
- **[[wiki/concepts/refinement-loop.md]]** — makes the loop's step count a trained per-input variable rather than a fixed budget, and does it inside one differentiable graph instead of around a generate-and-test harness; the two are composable in principle (halt the refinement when the halting unit fires) and this is the experiment nobody in that literature has run.
- **[[wiki/concepts/sparse-expert-routing.md]]** — the other axis of conditional computation, and the complement: a router varies *which parameters* run at fixed depth, ACT varies *how many times* fixed parameters run — which is precisely the heterogeneous-expert experiment that page lists as unattempted, obtained without touching the hardware constraint that forces experts to be large.
- **[[wiki/concepts/discrete-relaxation-gradients.md]]** — a fourth escape from the discrete-latent problem that page's taxonomy does not list: do not relax the sample and do not score it, but take the *mean field* over the whole halting distribution, which is exact, noise-free and needs no temperature — legitimate only under the linearity assumption above, and only because the quantity being mixed is a state vector rather than a choice among incompatible branches.
- **[[wiki/concepts/circuit-size-separation.md]]** — the same currency measured on the other axis: that page prices a function in *units at fixed depth*, ACT prices it in *sequential transitions at fixed units*, and the parity result is the cheap empirical shadow of the theoretical statement — the function a one-hidden-layer network needs exponentially many units for is solved by one small recurrent network given a variable number of steps.
- **[[wiki/concepts/test-time-training.md]]** — the two ways to spend compute at inference without changing the training set, and they are disjoint: test-time training changes the *weights* per instance and leaves the forward pass fixed, ACT leaves the weights frozen and changes the *number of forward steps* per input, so nothing prevents stacking them and no reported system does.
- **[[wiki/concepts/latent-graph-discovery.md]]** — makes traversal depth a per-observation learned quantity instead of an architectural constant, and leaves a readable trace of it: the ponder sequence recovered one step per digit on addition and a comparison spike on sort, which is the closest thing in the wiki to a measurement of how many hops an inference actually took.
- **[[wiki/concepts/selective-prediction.md]]** — the same halting decision with a *specified* target: ACT's ponder cost `τ` is a hand-set scalar with nothing to calibrate it against, while a selection function is thresholded against a declared risk target `r*` with a proved bound. Training a halting unit against a risk–coverage target instead of a ponder penalty is the untried combination, and it is what the missing `τ` is standing in for.
