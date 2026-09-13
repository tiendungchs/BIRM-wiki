# Recursive NPI (Neural Programmer-Interpreter trained on recursive traces)

**Leave the architecture untouched and rewrite the supervision: make the training execution trace call the program on itself instead of looping, and the learned neural program stops being a length-indexed family of behaviours and becomes one operator with an unbounded trip count — testable on a *finite* set of inputs and therefore provable.**

> **Provenance.** Cai, Shin & Song, *Making Neural Programming Architectures Generalize via Recursion*, ICLR 2017 (arXiv:1704.06611), `raw/cai-2017-neural-programming-generalize-via-recursion.md`. `LOSSY` — converted by `pdf2md`; equations below were re-read against the converted body, and the layout breakage in Algorithm 1 is conversion noise. The base architecture is Reed & de Freitas 2016 (NPI, Neural Programmer-Interpreter), which the authors re-implemented in Keras because no public implementation existed. Four tasks: grade-school addition, bubble sort, topological sort, quicksort.

This is the artefact `G70` was opened against: **the one system in the wiki whose induced program contains a call whose trip count is not fixed at synthesis time**, and the only one that converts "does it generalise?" from an extrapolation experiment into a coverage argument over a finite set.

---

## The architecture, and the one line of it that does the work

| Component | Definition |
|---|---|
| Encoder | `s_t = f_enc(e_t, a_t)` — domain-specific MLP over a slice of the external environment `Q` seen through a fixed number of pointers, plus a 3-tuple of integer arguments `a_t = (a_t(1), a_t(2), a_t(3))` |
| Core | `h_t = f_lstm(s_t, p_t, h_{t−1})` — task-agnostic 2-layer LSTM (Long Short-Term Memory), program embedding `p_t ∈ R^P` |
| Heads | `r_t = f_end(h_t)` (return probability), `p_{t+1} = f_prog(h_t)`, `a_{t+1} = f_arg(h_t)` |
| Step | Call a subprogram · or, if `p` is primitive, write to the environment `e_{t+1} ∼ f_env(e_t, p_t, a_t)` · or return when `r_t ≥ α = 0.5` |
| Supervision | **Full execution traces**, not input/output pairs: each training item is a step-input `(e, p, a)` → step-output `(r, p₂, a₂)` pair |
| Training | Adam; 200 traces (addition, max length 3), 100 (bubble sort, max length 2), **6** (topological sort, graphs of size 5 and 7), **4** (quicksort, arrays of length 5) |

**The load-bearing fact is `h ← 0` at every subprogram call** (Algorithm 1, line 3), with the caller's context pushed on a stack and popped on return. A call is therefore a *scope boundary*: the callee cannot see how much work the caller has already done. Recursion is then available for free in any architecture with this call structure — the NPI authors never used it — and a recursive call **erases the length-dependent history**: "via the recursive call, we effectively forget that the column just added exists… there is no concept of length relevant to the problem."

**The intervention is on the supervision only.** No equation changes. For addition, the non-recursive trace loops `ADD1 → LSHIFT → ADD1 → …` inside one stack frame; the recursive trace replaces the loop-back with a tail call to `ADD`. That is the entire method.

| Task | What is made recursive | Level needed |
|---|---|---|
| Addition | tail call to `ADD` after `ADD1`+`LSHIFT` | one |
| Bubble sort | tail call to `BUBBLESORT`, **plus** `BSTEP` and `LSHIFT` made tail recursive | **all three** — partial recursion fails |
| Topological sort (DFS variant, Algorithm 2) | tail calls in `TOPOSORT`, `CHECK_CHILD`, `EXPLORE`, `NEXT_START`; primitive `MOVE`/`WRITE` sequence identical to the non-recursive version | four |
| Quicksort (Lomuto partition) | **not purely tail recursive** — two recursive calls with argument stacks `Q_stackLo`, `Q_stackHi`; the harder case | two |

---

## Results

Accuracy on 30 randomly generated problems per length; `100%` rows below run to the largest size tried.

| Task | Non-recursive | Partially recursive | Recursive |
|---|---|---|---|
| Bubble sort, length 3 / 4 / 8 / 20 / 90 | 6.7 / 10 / 0 / 0 / 0 % | 23 / 10 / 0 / 0 / 0 % | **100% throughout** |
| Quicksort, length 11 / 15 / 20 / 25 / 70 | 73.3 / 60 / 30 / 3.3 / 0 % | — | **100% throughout** |
| Topological sort (1 training trace, 5-node graph), 5 / 7 / 8 / 70 vertices | 6.7 / 3.3 / 0 / 0 % | — | **100% throughout** |
| Addition, full 200-trace training set | generalises to 5,000 digits | — | generalises to 5,000 digits |
| Addition, trained on **5 one-digit sums** | fails on multi-digit problems composed of those sums | — | perfect (`822+233` from `8+2`, `2+3`) |

**Two honest readings the headline hides.** (i) Where the training set is rich enough, the *non*-recursive program also extrapolates far (addition to 5,000 digits, topological sort to 120 vertices) — so the measured accuracy margin appears only on the tasks with a length-dependent inner loop (sorting) or when training is starved to the base cases. What recursion buys unconditionally is not accuracy but the **proof**. (ii) Partial recursion is worse than useless as a half-measure: one of three loops made recursive moves bubble sort from 6.7% to 23% at length 3 and left 0% at length 8. The property is all-or-nothing per length-dependent loop.

---

## Provably perfect generalization, and what it costs

The theorem verified is

```
∀ i ∈ V,   M(i) ⇓ P(i)
```

`i` = a sequence of step inputs **within one function call**, `V` = all valid such sequences, `M` = the learned model, `P` = the reference program. Recursion is what makes `V` finite: each call to the recursive `ADD` runs for a fixed number of steps whatever the problem length, so the infinite family of `n`-digit problems collapses onto a finite set of two-adjacent-column configurations. The non-recursive program's hidden state is carried across all `ADD1` calls, so `V` is unbounded and no finite test licenses any claim.

| Step | How it is done | Cost |
|---|---|---|
| Construct `V` | Iterate the observation→observation mapping implied by the reference implementation from the entry function's reachable observations to fixed point — "analogous to how value iteration obtains the correct value for each state" | Analytic for addition; for the other three, generate inputs at random until coverage of the analytically derived `V` |
| Construct the verification set `S_V` | Problem inputs whose execution produces exactly `V` | — |
| Verify | Run `M` on `S_V`, require the **trace** to match `P`'s, not just the answer | **Once per training run**, never per input |

| Task | Verification set |
|---|---|
| Addition | **20,181 input problems** (analytic; assumes equal digit counts and no leading zeros, both removable at some cost) |
| Bubble sort (comparison-only encoder, below) | **one array of size 10** |
| Topological sort | **73 graphs** |
| Quicksort | **one 10-element array**, `[8,2,1,2,0,8,5,8,3,7]` |

The training set is routinely *smaller than the verification set* and the model still passes it — so the NPI generalises from seen step-input/step-output pairs to unseen ones **within** the finite space, which is the part that is still statistical learning rather than proof.

### The design lever: verifiability is a property of the observation interface

The size of `V` is set by what `f_enc` is allowed to see, and the paper's three examples are the same `L2` move made three times:

| Task | Interface as first written | Interface that makes verification tractable | Side effect |
|---|---|---|---|
| Bubble sort | expose the values `Q(1,i₁), Q(1,i₂)` (as in the original NPI) | expose only the **comparison bit** `Q(1,i₁) ≤ Q(1,i₂)` plus two in-range flags | the program now sorts **arbitrary comparable elements**, not just digits |
| Topological sort | expose absolute vertex identities | expose 3 booleans/colours: colour of the start vertex, colour of the active vertex's next child, `p_stack == 1` | scales to vertex counts never seen in training (naively 32 observation combinations, most unreachable) |
| Quicksort | an earlier program set lacking a move-pointer-to-pointer primitive | add `MOVE_PIVOT_LO`, `MOVE_J_LO`, shrinking the function and observation count | the earlier version "also generalized just as well in practice" but was far harder to verify |

The paper's own summary: "relatively small differences in the formulation of the traces and the environment observations can drastically change the difficulty of verification." **Denying the reader the values and handing it the relation is exactly the [[wiki/concepts/relational-bottleneck.md]] move, bought here for verifiability and element-type generality rather than for sample efficiency.**

---

## Limitations

- **The recursion is authored, not discovered.** It arrives as hand-written recursive traces over a hand-written program set. The paper states training "without providing explicit training execution traces or with only partial or non-recursive traces" as future work. So this is an existence proof that the *hypothesis class* can hold an unbounded trip count, not that anything induces one.
- **Per-step supervision.** NPI is the only architecture in its literature that does not train on input/output pairs; the price of the guarantee is a teacher who already has the program.
- **Verification needs a finite, enumerable base-case space.** The authors name the counter-case themselves: tasks with MNIST digits or speech samples as inputs have a base-case space that is "prohibitively large, possibly infinite", and the procedure does not apply. Every verified task here has a handful of boolean/colour observations.
- **`V` is built by hand for three of four tasks** — random generation until coverage of an analytically reasoned target, with automation from a precise `P` left as future work.
- **Four algorithmic tasks, one re-implementation.** No public NPI baseline existed; all comparisons are against the authors' own non-recursive runs.

---

## Comparison — how the wiki's other unbounded-iteration mechanisms differ

| System | What varies with input size | Where the iteration count lives | Verifiable on a finite set |
|---|---|---|---|
| **Recursive NPI** | depth of a call stack of *scoped* frames, each with `h = 0` | in the learned program, unbounded | **yes** — that is the result |
| [[wiki/concepts/adaptive-computation-time.md]] | number of repeated transitions on one input, halted by `Σ h^n ≥ 1−ε` | in a trained halting unit with a hand-set cost `τ` | no — no scope boundary, states are mean-fielded together |
| [[wiki/entities/universal-transformer.md]] | per-position depth | same halting rule, per position | no |
| [[wiki/entities/pcfg-set.md]] seq2seq models | nothing — LSTMS2S accuracy is **exactly 0 at argument length 6** after training on ≤5 | nowhere; a length-indexed family of behaviours | n/a |
| [[wiki/entities/dreamcoder.md]] | program structure, with recursion available in the *authored generic basis* (Y-combinator, `fold`/`unfold` learned from it) | in an induced λ-term, from input/output pairs only | no, but the program is inspectable |
| [[wiki/entities/ilp-arc-synthesizer.md]] | nothing — clauses are **unrolled** `n` times, capping the test instance at `≤ n` repetitions | fixed at synthesis time | n/a |
| [[wiki/entities/differentiable-neural-computer.md]] | memory usage; control flow stays in one unscoped recurrent state | nowhere explicit | no |

The axis the table sorts on is **scope**. ACT and the DNC add computation inside one continuing state, so more computation means more opportunity for length to leak into the representation; the recursive NPI adds computation by *starting a new state*, which is why a finite test can say anything about an infinite input family.

---

## Connections

- **[[wiki/concepts/program-induction.md]]** — the family's only instantiation whose emitted program contains recursion, and the one that pays cost 1 in the most extreme currency available: not just an authored library but an authored *trace* at every step, in exchange for the wiki's only proof of perfect generalization.
- **[[wiki/concepts/compositionality.md]]** — productivity obtained by construction rather than measured: a recursive call makes composition depth a property of the program instead of a property of the training data, which is the failure mode the compositionality tests exist to catch.
- **[[wiki/entities/pcfg-set.md]]** — the exact complement, one measurement each: PCFG SET shows a seq2seq model holding a length-indexed family of behaviours with a cliff at the training maximum; this page shows what removes the cliff, and it is a scope boundary in the trace rather than more data or more capacity.
- **[[wiki/concepts/external-verification.md]]** — a rung the ladder does not have: the artefact checked is the **model**, not an answer or a derivation, and the check is paid once per training run and then covers every input forever — but only where the base-case space is finite and enumerable.
- **[[wiki/concepts/relational-bottleneck.md]]** — the sharpest non-efficiency argument for the same `L2` denial: replacing the two values with the single bit `Q(i₁) ≤ Q(i₂)` shrinks the verification set for bubble sort to one array of size 10 and makes the learned program sort arbitrary comparable elements.
- **[[wiki/concepts/adaptive-computation-time.md]]** — the differentiable rival for unbounded iteration, and the contrast that names what recursion adds: ACT repeats a transition inside one accumulating state, the recursive NPI opens a fresh state per call, and only the second makes the step-input space finite.
- **[[wiki/concepts/curriculum-learning.md]]** — the paper's negative claim about length curricula, and the alternative: rather than ordering examples by length, change the hypothesis class until length is not a variable of the problem at all.
- **[[wiki/entities/dreamcoder.md]]** — the two halves of the missing system: DreamCoder induces programs from input/output pairs alone and is *handed* recursion in its generic basis; the recursive NPI is handed the program in its traces and demonstrates what recursion buys once present.
- **[[wiki/entities/ilp-arc-synthesizer.md]]** — the unrolled corner of `G70` that this page answers: where the ILP synthesizer emits `n` copies of a clause chosen from the training examples, a tail call re-enters the same program with no count anywhere.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the same era's other differentiable-programming system, and the architectural difference that matters: an external memory with one continuing controller state, against an external environment plus a *stack of reset* controller states.
- **[[wiki/concepts/discrete-infinity.md]]** — the machine instantiation of the claim: a finite set of subprograms plus one self-application yields an unbounded set of executions, and the paper's verification argument is what a "separable recursive operator" looks like when it is separable enough to be tested on its own.
- **[[wiki/concepts/working-memory.md]]** — the clearest case in the wiki where *forgetting* is the mechanism: resetting `h` at every call is what removes the length dependence, so the architecture's memory contract is scoped rather than continuous.
- **[[wiki/concepts/certification-instruments.md]]** — instrument `I42`, and the only row in that inventory whose output is a proof rather than a score: coverage of a finite reachable step-input space, with the scope condition (no perceptual inputs) stated by the authors rather than inferred.
