# Universal Transformer

**A Transformer whose layer stack is replaced by one layer applied `T` times: the same self-attention block and the same transition function recur over *revisions of the per-position representation* rather than over positions, with a two-dimensional (position, step) coordinate embedding added at every step, and — optionally — a per-position ACT halting unit that lets each symbol stop after its own number of revisions. Weight-tying across depth is what makes `T` a run-time variable, and letting `T` grow with input length is what makes the model computationally universal, which a fixed-depth Transformer provably is not under finite precision.**

> **Provenance.** Dehghani, Gouws, Vinyals, Uszkoreit & Kaiser 2019, *Universal Transformers*, ICLR 2019, arXiv:1807.03819 (`raw/dehghani-2019-universal-transformers.md`). Full body, all seven tables, appendices A–F including the halting implementation; figures dropped (the ponder-time heatmap and the universality sketch are held from their captions only).

Why the wiki holds this page. It is the point where three lines already on the wiki meet in one architecture: [[wiki/concepts/adaptive-computation-time.md]]'s halting unit, [[wiki/entities/transformer.md]]'s content-addressed read, and [[wiki/concepts/circuit-size-separation.md]]'s depth-versus-width currency. Three things only this source carries:

1. **The first report that conditional computation *improves accuracy*** rather than trading it for compute — and the control that rules out "it just ran longer" (fixed 8- and 9-step models lose to a dynamic model averaging 8.2 steps).
2. **Per-input compute tracked a counted, ground-truth task quantity**: mean ponder time 2.3 → 3.1 → 3.8 for bAbI tasks requiring 1 → 2 → 3 supporting facts. That is the wiki's cleanest evidence that a learned budget measures *hops*, not surprise.
3. **The universality argument is about `T(n)`, not about halting.** Explicitly: the result "holds independently of whether or not adaptive computation time is employed" and requires only a non-constant, possibly deterministic, input-length-dependent step count. So the wiki's habit of bundling "adaptive" with "universal" is wrong, and only weight-sharing is load-bearing.

---

## The object

Encoder, per recurrent step `t`, on `H^{t−1} ∈ ℝ^{m×d}`:

```
A^t = LayerNorm( (H^{t−1}+P^t) + MultiHeadSelfAttention(H^{t−1}+P^t) )
H^t = LayerNorm( A^t + Transition(A^t) )

P^t_{i,2j}   = sin(i/10000^{2j/d}) + sin(t/10000^{2j/d})      # position ⊕ step, summed
P^t_{i,2j+1} = cos(i/10000^{2j/d}) + cos(t/10000^{2j/d})
```

| Component | Setting | Note |
|---|---|---|
| Recurrence axis | over **depth**, not over positions | the model is bounded by revisions per symbol, not by sequence length |
| Parameters | one attention block + one transition, **shared across all `t`** | fixed `T` ⇒ exactly a depth-`T` Transformer with tied layers |
| Transition | separable convolution *or* position-wise 2-layer ReLU MLP | task-dependent; the MT win used the MLP |
| Coordinate embedding | sinusoidal in position **and** in step, **added** | the step index is injected the same way position is — superposition again ([[wiki/entities/transformer.md]] §2) |
| Decoder | same recurrence + cross-attention onto `H^T`, causal mask, autoregressive | encoder run once, decoder run per output symbol |
| Halting (optional) | per-position ACT, threshold hyper-parameter, `max_steps` cap | halted positions **copy** their state forward until all halt |

**The halting rule as implemented** (Appendix C, verbatim in behaviour): `p = σ(dense(state,1))`; a position halts when its accumulated halting mass crosses `threshold`; the step that crosses it is weighted by the remainder `1 − Σp`; the new state is the *interpolation* `transformed·w + previous·(1−w)`. Two departures from Graves 2016 worth naming — the loop is per position rather than per input step, and the shown code carries **no ponder penalty `τ`**: the pressure to stop is a hand-set threshold plus a step cap, so `G107`'s constant survives, renamed.

**Two readings of the same model**, both given by the authors:
- *Tied-layer Transformer* — accurate at fixed `T`, and the boring one.
- *A block of `m` parallel RNNs with shared parameters, one per symbol, whose recurrent step is "attend to every other RNN's previous state"*. This is the informative one: unlike a time-recurrent RNN, whose only memory in the recurrent step is a fixed-size state vector (hence automaton-like), each step here reads the **whole previous layer**, i.e. recurrence with memory access.

---

## Results

| Task | Transformer | LSTM | **UT** | **UT + halting** |
|---|---|---|---|---|
| bAbI 10K, train joint (avg err, failed/20) | 22.1 (12/20) | — | 0.47 (0/20) | **0.29 (0/20)** |
| bAbI 1K, train joint | 26.8 (14/20) | — | 8.50 (8/20) | **7.78 (5/20)** |
| Subject–verb agreement, 5 attractors | 0.883 | 0.842 | 0.892 | **0.907** |
| LAMBADA LM perplexity (test) | 7321 | 5174 | 319 (6 fixed steps) | **142** |
| LAMBADA reading comprehension | 0.3988 | 0.2007 | 0.5216 | **0.5625** |
| Copy / Reverse / Addition, train len 40 → test len 400 (seq-acc) | 0.03 / 0.06 / 0.0 | 0.09 / 0.11 / 0.0 | **0.35 / 0.46 / 0.02** | — |
| Learning-to-Execute, memorization (copy/double/reverse, seq-acc) | 0.63 / 0.55 / 0.26 | 0.11 / 0.05 / 0.32 | **1.0 / 1.0 / 1.0** | — |
| Learning-to-Execute, program eval (program/control) | 0.29 / 0.66 | 0.12 / 0.21 | **0.63 / 1.0** | — |
| WMT14 EN→DE BLEU (base, param-matched) | 28.0 | — | **28.9** | degrades slightly |

Read in the wiki's terms:

- **Weight-tying alone is most of the gain.** Every algorithmic and LTE row above is plain UT with no halting, against a parameter-comparable Transformer. The recurrent inductive bias — the *same* operator applied repeatedly — is what buys length extrapolation, not adaptivity.
- **Halting is worth ~0.2 bAbI error points and 177 perplexity, and costs BLEU.** It helps precisely where the per-input demand is heterogeneous and structured, and hurts on a task where every sentence needs about the same work — the inverse of Graves's negative LM result, and the reason for `T321`.
- **The compute/accuracy exchange is *good* here**, unlike ACT on sort (~9× compute for halving the error). LAMBADA: 6 fixed steps → 319 ppl; 8 fixed → 202; 9 fixed → 239; dynamic averaging 8.2 → **142**. Depth-matched controls exist and lose. The authors' reading, and the wiki should keep it as a hypothesis rather than a finding: **dynamic halting acts as a regulariser**, forcing a smaller budget on some symbols so more is affordable for others.
- **The attention distributions sharpen over steps** — uniform early, concentrated on the correct supporting facts late — which makes the step index a *stage* of an inference and not merely more capacity. Combined with the ponder/supporting-fact scaling, this is a multi-hop trace with a measured hop count.
- **Ponder time is used to *ignore*, not only to think.** On 3-fact tasks (long stories, many irrelevant facts) most positions halt at step 1–2 and a few run long; on 1-fact tasks the histogram is uniform. Selective allocation over positions is the mechanism by which distractors get dropped.

---

## The universality argument, stated precisely

| Claim | What it rests on |
|---|---|
| A standard Transformer is **not** computationally universal | Under finite precision, its number of *sequential* operations is a constant (the layer count), independent of input size; a function requiring sequential processing of each element admits, for any depth `T`, an input of length `N > T` it cannot process |
| A UT **is**, given sufficient memory | Choose `T` as a function of input length. Weight sharing is what permits varying `T` after training |
| ACT is **not** required | Stated outright; a deterministic non-constant `T(n)` suffices |
| Neural GPU ⊂ UT | Set self-attention + residual to identity, transition to a convolution, `T = m` — exactly a Neural GPU. The last condition is what a Transformer cannot do |

`(brainstorm)` The reduction gives the wiki a cheap dial nobody reports: `T = m` makes depth scale with input length and is the *only* setting under which the universality claim applies, yet every experiment above uses a small fixed `T` (6–9) or an ACT budget capped by `max_steps`. **No result in this paper is run in the regime its theory is about.** The universality result is therefore an existence claim about the architecture class, and the empirical wins are claims about weight-tying — they are logically independent and are routinely cited as one.

---

## Comparison

| | **UT** | [[wiki/entities/transformer.md]] | ACT-LSTM ([[wiki/concepts/adaptive-computation-time.md]]) | [[wiki/entities/differentiable-neural-computer.md]] |
|---|---|---|---|---|
| Recurrence axis | depth (revisions) | none | input steps | input steps |
| Memory read in the recurrent step | **the whole previous layer** | n/a | fixed-size state only | external memory matrix |
| Depth | variable, `T` or per-position | fixed `N = 6` | n/a | n/a |
| Parameters vs. depth | constant (tied) | linear | constant | constant |
| Halting granularity | **per position** | — | per input step | — |
| Stop pressure | threshold + step cap | — | ponder penalty `τ` | — |
| Computationally universal | yes, if `T = f(n)` | **no** (finite precision) | yes-ish (unbounded ponder) | yes given memory |
| Length extrapolation 40 → 400 | 0.35–0.46 seq-acc | 0.03–0.06 | untested at this ratio | untested |

---

## Limitations

| Limitation | Consequence |
|---|---|
| **The halting threshold is hand-set** | `G107` unchanged: the price of a step is still an external constant, now a threshold rather than a `τ`, with no sweep reported and no sensitivity analysis |
| **Halting *degrades* machine translation** | Conceded ("marginally degraded"); the base MT result is the no-ACT model. So the mechanism is task-conditional and nothing predicts which tasks in advance |
| **The regulariser explanation is an inference from three numbers** | 6/8/9-step fixed controls vs one dynamic run; no ablation separating "fewer steps on easy symbols" from "variance across symbols" from "the interpolation `w` acting as depth-wise dropout" |
| **Algorithmic tasks are not solved** | Copy 0.35, Reverse 0.46, Addition **0.02** sequence accuracy at 10× length. Neural GPU gets 1.0 on all three — with a curriculum UT did not use, which makes the comparison unresolvable in either direction |
| **`O(T·n²·d)`** | Depth is now a multiplier on an already quadratic layer; every step re-attends over the full sequence, and halted positions still occupy the keys |
| **No test in the universality regime** | See above: `T = f(n)` is never run |
| **bAbI is synthetic and the input encoding is task-specific** | Facts are pre-pooled by a learned multiplicative positional mask before the model sees them, so the sentence-level segmentation the ponder analysis is read against is supplied, not discovered |
| **Best-of-10-seeds selection on bAbI** | Stated; matches prior work, and means the headline 0/20 is a best run rather than an expected one |

---

## Connections

- **[[wiki/entities/transformer.md]]** — the same layer with its stack untied and its depth made a run-time variable, which repairs exactly one thing: a fixed-depth stack has a constant number of sequential operations and is therefore not computationally universal at finite precision, while tying weights lets `T` grow with input length. It also inherits that page's superposition trick and extends it — the *step index* is injected as a second sinusoidal coordinate added into the same `d_model` vector as position and content.
- **[[wiki/concepts/adaptive-computation-time.md]]** — the mechanism moved from per-input-step to **per-position**, with the ponder penalty `τ` dropped for a bare threshold, and the first evidence that halting *improves accuracy* rather than trading it away (bAbI 0.47 → 0.29, LAMBADA 319 → 142 against depth-matched fixed controls at 202/239) — including the LM result that inverts Graves's negative one (`T321`).
- **[[wiki/concepts/latent-graph-discovery.md]]** — the wiki's cleanest measurement that a learned compute budget counts *hops*: mean ponder time 2.3 / 3.1 / 3.8 steps for bAbI questions requiring 1 / 2 / 3 supporting facts, with attention sharpening onto the correct facts across steps — so the number of traversals an inference took is readable off the architecture without being supervised.
- **[[wiki/concepts/refinement-loop.md]]** — the loop with its verifier deleted and its state kept: `H^t` is a candidate repeatedly rewritten by one shared operator, but the signal deciding the next step is a sigmoid on the current state rather than a check against the task's own pairs, which is why it is differentiable end-to-end and why nothing here notices that a revision was *wrong*.
- **[[wiki/concepts/circuit-size-separation.md]]** — the empirical shadow of that page's currency at the largest scale in the wiki: the same parameters applied `T` times solve length-400 copy/reverse where a parameter-matched fixed-depth network is at 0.03–0.06, so sequential steps and units are substitutable and the paper's universality argument is exactly a statement that only the sequential axis can be traded against input size.
- **[[wiki/entities/cfq.md]]** — where this architecture is scored on the wiki's compositionality axis, and it is the negative result that matters: recurrence in depth buys length extrapolation on algorithmic tasks and buys nothing at high compound divergence (98.0 i.i.d. → 18.9 at MCD, 1.2 on SCAN MCD), so the two failure modes are separable and this model separates them.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the architecture whose read/write step this one claims to subsume: a single addressed read per step is expressible as UT's global parallel revision, and the authors' stated advantage is that UT stays competitive on realistic sequence-to-sequence tasks where the memory-augmented models only performed on algorithmic ones.
- **[[wiki/entities/sparsely-gated-moe.md]]** — the other conditional-computation axis measured against this one: a router varies *which* parameters run at fixed depth, this varies *how many times* one shared set runs, and UT is the case where the second alone changed nothing about parameter count and still moved a translation benchmark by 0.9 BLEU.
- **[[wiki/concepts/evidence-accumulation.md]]** — the same accumulate-to-threshold shape with the accumulator moved inside a representation: halting mass accrues per position until a hand-set threshold, with the crossing step down-weighted by the remainder, so the "commit" is an interpolation rather than a choice and there is no error-rate guarantee attached to the threshold.
