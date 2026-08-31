# Switch Transformer

**A Transformer whose feed-forward block is replaced by `E` identical expert feed-forward nets and a router that sends each token to exactly one of them (`k = 1`), with a single load-balance loss, a float32 router, and a 10×-reduced initialisation scale — the configuration that made sparse expert models trainable at 1.6T parameters and 4–7× faster than a FLOP-matched dense baseline (Fedus, Zoph & Shazeer 2022).**

> **Provenance.** Fedus, Zoph & Shazeer 2022, *Switch Transformers: Scaling to Trillion Parameter Models with Simple and Efficient Sparsity* (`raw/fedus-2022-switch-transformers.md`, JMLR; arXiv 2101.03961). The system the wiki has been citing second-hand through the same authors' survey ([[wiki/concepts/sparse-expert-routing.md]], `raw/fedus-2022-sparse-expert-models-review.md`) and through [[wiki/entities/sparsely-gated-moe.md]]. This page holds what only the primary source carries: the `k = 1` falsification with its head-to-head table, the three stability interventions priced individually, the distillation ceiling, the negative results (rerouting, sampling), and the FLOPs-per-token dissociation the survey states as a rule without the measurement behind it.

Why it matters here beyond efficiency: it is the wiki's **cheapest fully-committed discrete decision at scale** — one integer per token per layer, no top-2 hedge, no soft mixture — and the paper is a catalogue of what that commitment costs and what it does not.

---

## Architecture

| Component | Definition |
|---|---|
| Experts | Identical FFNs substituted for the Transformer position-wise block; `E ∈ {2 … 2048}`; expert frequency 1/2 (Base/Large/XXL) or 1 (Switch-C) |
| Router | `p(x) = softmax(W_r x)`, `W_r ∈ ℝ^{E×d}`; **top-1**: `y = p_{argmax}(x) · E_{argmax}(x)` |
| Gradient path | Only through the scalar `p_i` multiplying the chosen expert's output — the argmax is dead, as in Shazeer et al. 2017 |
| **Expert capacity** | `C = (tokens per batch / E) × CF`; a token routed to a full expert receives **no computation** and passes through on the residual (drop rate typically <1% with the balance loss on) |
| Balance loss | `L = α · E · Σ_i f_i P_i`, `f_i` = fraction of tokens argmaxed to `i` (non-differentiable), `P_i` = mean router probability for `i` (differentiable). Minimised at uniform; the `E` factor holds the loss scale constant as `E` varies. `α = 10⁻²`, chosen from a sweep over `10⁻¹ … 10⁻⁵` |
| Exploration noise | Multiplicative uniform jitter on the router input during training only |
| Precision | Router body computed in float32; dispatch/combine tensors recast to bfloat16 *before* the all-to-all, so no float32 tensor crosses the network |
| Init | Truncated normal, `σ = √(s/n)`, with `s` reduced from 1.0 to **0.1** |
| Fine-tuning | Dropout 0.1 everywhere, **0.4 inside the experts** ("expert dropout") |
| Parallelism | Expert-parallel (`n` = `E` = cores) alone for Switch-C; expert × model × data for Switch-XXL, which adds all-reduce on top of all-to-all |

**Simplification is the contribution.** Against Shazeer et al. 2017 this drops: the second expert, the noise-integrated `Load` loss, the separate `Importance` loss, and the hierarchical gate. What remains is one softmax, one argmax, one auxiliary term.

---

## `k ≥ 2` was false, and `k = 1` is strictly better

Shazeer et al. conjectured top-`k` with `k ≥ 2` was necessary for the router to have useful gradient ("compare at least two experts"); Ramachandran & Le 2018 argued higher `k` in lower layers mattered. Head-to-head at 128 experts, matched hardware (32 TPUv3), FLOP-matched to T5-Base:

| Model | `CF` | Neg. log ppl @100k ↑ | Hours to −1.50 ↓ | Examples/sec ↑ |
|---|---|---|---|---|
| T5-Base (dense) | — | −1.731 | not reached | 1600 |
| T5-Large (dense, 3.5× FLOPs) | — | −1.550 | 131.1 | 470 |
| MoE-Base (top-2) | 2.0 | −1.547 | 68.7 | 840 |
| **Switch-Base (top-1)** | 2.0 | −1.554 | 72.8 | 860 |
| MoE-Base (top-2) | 1.0 | −1.572 | 80.1 | 860 |
| **Switch-Base (top-1)** | **1.0** | **−1.561** | **62.8** | **1000** |

Two readings. (1) At `CF = 2.0` top-2 is marginally better per step; the ordering **reverses as capacity tightens**, and tight capacity is the only regime that exists at scale, where expert memory is scarce. So the `k = 1` win is not a quality win, it is a win in the currency that binds. (2) The four-year 2× routing overhead was bought by **a gradient-availability argument, not a measurement** — the same failure mode the wiki flags on [[wiki/entities/sparsely-gated-moe.md]].

---

## The three stability interventions, priced

Sparse routing destabilises training because a continuous score decides a discrete outcome; roundoff flips an argmax, which redirects gradient, which moves the score.

| Intervention | Without | With |
|---|---|---|
| **Selective float32** (router body only) | bfloat16: **−3.780, diverged** | −1.716 at 1390 ex/s — full float32 quality (−1.718) at full bfloat16 speed (1390 vs 1160) |
| **0.1× init scale** | −3.60, SD **0.68** across 3 seeds | −2.72, SD **0.01** |
| **Expert dropout 0.4** | uniform `d=0.3`: GLUE 83.9 | `d=0.1` / expert `d=0.4`: GLUE **85.2** |

**The general lesson the wiki should carry: all three act on the router or on the experts' *statistics*, never on the decision rule.** The router is the only place in the network where a float32/bfloat16 difference changes which parameters exist in the computation graph, so precision is not a numerics detail — it is where the architecture's discreteness is adjudicated. And each expert sees only `B/E` tokens, so both the init scale and the dropout rate that are right for a dense block of the same shape are wrong here: **conditional parameters need their own hyper-parameter regime because their effective batch is divided by the branching factor.**

---

## Scale, and the dissociation that is actually about FLOPs

| Model | Params | FLOPs/seq | `E` | Neg. log ppl @500k | Stability |
|---|---|---|---|---|---|
| T5-XXL | 11B | 6.3T | — | −1.095 | stable |
| Switch-XXL | 395B | 6.3T | 64 | **−1.008** | **sporadically unstable** |
| Switch-C | **1571B** | 0.89T | 2048 | −1.043 | **no instability at all** |

- **Instability tracks FLOPs per token, not parameter count or expert count.** The 1.6T/2048-expert model trains cleanly; the 4×-smaller model with ~10× the FLOPs per token does not. This corrects the loose "larger sparse models are less stable" reading on [[wiki/concepts/sparse-expert-routing.md]]: the sparse axis is the *safe* one to scale.
- **And downstream quality inverts the same way.** At near-equal perplexity, Switch-C scores 87.7 on SQuAD against Switch-XXL's 89.6 — the model with 4× the parameters and 1/10 the FLOPs per token is worse. Reasoning is bought with FLOPs per token; parameters at fixed FLOPs buy something else.
- **Matched-FLOPs, the reasoning picture is the opposite of matched-perplexity.** Against FLOP-matched dense baselines, Switch-Base *gains* on every reasoning benchmark: SuperGLUE 79.5 vs 75.1, Winogrande 73.3 vs 66.6, ANLI-R3 54.0 vs 51.8, and Switch-XXL sets 65.7 on ANLI against a prior best of 49.4. The survey's "sparse models transfer worse on reasoning" is a statement **at matched pre-training perplexity**, i.e. about what the extra parameters bought — not a claim that sparsity costs reasoning at fixed compute. The wiki should keep the two comparisons apart.
- The only losses in the fine-tuning table are ARC-Easy and ARC-Challenge — the two most explicitly reasoning-shaped tasks in the set.
- **Multilingual:** gains on **all 101 languages**, mean 5× step speed-up over mT5-Base, ≥4× for 91% of languages — the strongest positive-transfer measurement in this family after Shazeer's 12-pair result.
- **Small scale works.** 2, 4 and 8 experts already beat the FLOP-matched dense baseline; sparsity is not a supercomputer-only technique.

---

## Distillation: the capacity does not compress

| Teacher | Student | Quality gain preserved | Compression |
|---|---|---|---|
| Switch-Base 1.1B | T5-Base 223M | 37% | 82% |
| Switch-Base 3.8B | T5-Base 223M | 30% | 95% |
| Switch-Base 14.7B | T5-Base 223M | 28% | 99% |
| Switch-Base 7.4B, fine-tuned on SuperGLUE | T5-Base 223M | 30% (81.3 → 76.6 vs 74.6) | 97% |

Recipe: initialise the student's non-expert weights from the teacher (possible because the models are FLOP-matched, so the shapes agree) and mix 0.75 hard label / 0.25 teacher probability. Initialisation alone, without distillation, buys **nothing** (−1.639 vs −1.636).

**The number that matters is the ~30% ceiling, and its flatness.** It barely moves from 82% to 99% compression, so the recoverable part is not a function of how much is thrown away. Read structurally: **roughly 70% of what conditional parameters buy is not a function a dense student can represent at that FLOP budget** — it is capacity that exists only because different inputs saw different weights. This is the sharpest available evidence that a sparse model is not a compressible ensemble of one dense model, and it is what a wiki architecture buying capacity through a module library should expect to be unable to fold back in.

---

## Negative results worth more than the positive ones

| Attempt | Finding | Reading |
|---|---|---|
| **No-Token-Left-Behind** — iteratively reroute overflow tokens to their 2nd, 3rd… choice until virtually nothing is dropped | **No benefit**, on quality or stability | Dropping a token entirely beats sending it to the wrong expert. Once a token–expert association is learned, honouring it is what carries the information; a second-choice module is not a degraded version of the first, it is a different one. **A module library needs the option to abstain** ([[wiki/concepts/latent-graph-discovery.md]]: no edge is better than a wrong edge) |
| **Router exploration** — argmax −1.471, input jitter −1.468, input dropout −1.480, **sampling from the router softmax −1.570** | Stochastic selection is decisively *worse*; only tiny input-space noise helps | The router's problem is framed by the authors as a contextual bandit, and the bandit answer (sample the policy) loses to pure exploitation. Whatever the router is learning does not need exploration — consistent with `T296`'s Position B, where the assignment is close to a function of token identity and there is little to explore |
| **Switch layers on `q`/`k`/`v`** | Quality *improves* (−1.513 vs −1.548 for FFN-only) but **diverges under bfloat16** | Conditional parameters help more inside attention than in the FFN, and are blocked there by numerics alone — a live opportunity, not a settled negative ([[wiki/entities/transformer.md]]) |

---

## Comparison

| System | `k` | Experts | Balance | Stability provision | Routed unit |
|---|---|---|---|---|---|
| [[wiki/entities/sparsely-gated-moe.md]] (2017) | 2–4 | ≤131,072 FFNs between LSTMs | `Importance` + noise-integrated `Load`, CV² | Zero-init router (uniform load at step 0) | Token position |
| **Switch Transformer** (2022) | **1** | ≤2048 FFNs replacing the Transformer FFN | One loss, `α·E·Σ f_i P_i` | float32 router, 0.1× init, expert dropout | Token |
| ST-MoE (per the survey) | 2 | ≤64 large | + **router z-loss** | Logit-scale penalty | Token |
| [[wiki/entities/neural-module-networks.md]] | — | 5 typed, heterogeneous | none needed | — | Sub-question |

---

## Limitations

- **The routed unit is still a token.** Nothing routes a step of a computation; the ARC-Easy/Challenge losses are where that would bite first ([[wiki/concepts/refinement-loop.md]]).
- **Experts are homogeneous by construction**, so routing allocates parameters and never compute per input; the authors name heterogeneous experts ("route to a larger expert when the example is harder") as future work, unattempted.
- **The load-balance loss imposes a uniform prior on the partition**, which is a strong claim about the structure distribution and is never tested against a non-uniform one.
- **No expert-specialisation analysis at all** — the primary source reports none; every specialisation table the wiki carries comes from the survey and from later work.
- **The FLOPs/params/fine-tuning dependence is admitted to be unexplained** by the authors, and it is the single most decision-relevant unknown in the paper.
- Attention-layer experts and the largest FLOP-per-token model both diverge in bfloat16 — the stability suite does not generalise past the configurations it was tuned on.

---

## Connections

- **[[wiki/concepts/sparse-expert-routing.md]]** — the primary source under that page's central design rules: the `k = 1` falsification with the head-to-head table, `α = 10⁻²` from a five-decade sweep, and the correction that instability tracks *FLOPs per token* rather than sparsity, since the 1.6T/2048-expert model is the stable one and the 395B/10×-FLOPs model is not.
- **[[wiki/entities/sparsely-gated-moe.md]]** — the direct predecessor, simplified in four places at once (top-1, one balance loss instead of two, no noise-integrated `Load`, no hierarchical gate) with no quality loss — so the earlier design's differentiability apparatus turns out to be optional, and what the noise term survives as here is a plain jitter that the exploration ablation shows contributes almost nothing.
- **[[wiki/entities/transformer.md]]** — the host, and the localisation of where conditional parameters may go: substituting the position-wise FFN is stable and standard, while substituting the `q`/`k`/`v` projections gives *better* quality (−1.513 vs −1.548) and diverges under bfloat16, so the blocker on attention-level conditional parameters is numerical rather than architectural.
- **[[wiki/concepts/discrete-relaxation-gradients.md]]** — a measured argument against relaxing this particular discrete decision: sampling from the router softmax costs 0.10 negative-log-perplexity against a hard argmax (−1.570 vs −1.471), so the stochastic-selection family that page catalogues is not merely unnecessary for a router but actively harmful, and the only noise that helps is jitter on the router's *input*.
- **[[wiki/concepts/representational-collapse.md]]** — the collapse remedy in its minimal form: one auxiliary term `α·E·Σ f_i P_i` pairing a non-differentiable count `f` with a differentiable probability `P` so the gradient flows through the second while the first supplies the target, and `α` insensitive across `10⁻¹…10⁻⁵` — corroborating that a discrete selection variable is far easier to hold up than a continuous embedding.
- **[[wiki/concepts/emergent-modularity.md]]** — the negative result that page most needs and this source supplies indirectly: 2048 modules were trained to 1.6T parameters with *no specialisation analysis performed at all*, so the field's largest emergent module library was built and shipped without anyone checking what the modules are.
- **[[wiki/concepts/refinement-loop.md]]** — the granularity evidence sharpened: the only benchmarks where a FLOP-matched Switch model *loses* to dense are ARC-Easy and ARC-Challenge, the two most explicitly multi-step tasks in the fine-tuning set, which is what one predicts when the routed unit is a token and the problem decomposes into steps.
- **[[wiki/concepts/continual-learning.md]]** — the distillation ceiling is a warning for every consolidation scheme in the wiki: ~30% of a sparse model's quality gain survives compression into a dense student and the fraction is nearly flat from 82% to 99% compression, so capacity that exists because different inputs saw different weights is not recoverable by a student that runs the same weights on everything.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the abstention result: No-Token-Left-Behind guarantees almost no dropped tokens and buys nothing, so passing a token through unprocessed beats routing it to its second-choice node — evidence that a navigation policy over a learned partition should be allowed to *decline* rather than take its next-best edge.
