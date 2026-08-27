# BIRM — Buildable Spec

**Status: WAVE 2 FILLED.** §1, §2, §3 and the §6 skeleton carry ledger rows. §4, §5, §7–§10 are still template. Every filled cell carries a ledger row in §11. A section with no ledger rows is not "done", it is "asserted".

> Instantiated from `_brainstorm/birm-spec-template.md`, which stays unfilled as the blank form. Reading order is fixed by `_brainstorm/priority-read.md`; the wave that filled each cell is in §13.

> **What this document is.** One buildable specification of BIRM: an agent-side controller that receives observation vectors and emits action vectors, with everything benchmark-specific pushed into an adapter. It is written so that a later reading wave can *replace* a filled cell rather than append to it — see §11's `Supersedes` column and §13.
>
> **What it is not.** Not a literature review (that is `wiki/`), not a wish list (that is `wiki/architectural-gaps.md`). A row belongs here only if it is implementable as written or explicitly marked `OPEN-SLOT` in §12.

---

## Editing rules

| Rule | Statement |
|---|---|
| R1 | Every design decision gets a ledger id `D<n>` in §11 with a status token: `ASSUMED` (no source, my choice) / `SOURCED` (a wiki page says it) / `MEASURED` (a number exists) / `CONTESTED` (a tension row disputes it). |
| R2 | A decision may only be replaced by a decision that names it in `Supersedes` and says what new evidence forced the change. Deleting a row silently is forbidden. |
| R3 | Any quantity with no number is written `?` and appears in §12. Never write a plausible number. |
| R4 | Every organ (§3) and every bus (§4) must have at least one falsifier in §10 before it is called specified. |
| R5 | Prose is capped: tables, equations, numbered steps. If a paragraph is needed, it is a symptom that a decision is missing. |

---

## 1. Scope

| Slot | Fill |
|---|---|
| Target task set (three-component framing: name it or No-Free-Lunch applies) | The **interactive, transition-sampled slice of the abstract-reasoning AI Set**: an agent emitting actions into an environment family, recovering structure from `(obs, action, obs')` triples. In the latent-variable bit-vector: **edge existence, edge label, path and goal node latent**; node content given by the adapter; edge vocabulary *size* given, semantics latent. `D1`, `D2` |
| Benchmarks that instantiate it | Primary: `[[wiki/entities/arc-agi-3.md]]` — interactive, action semantics and goal both withheld, and its scoring function `S = min(h/a, 1.15)²` is already the efficiency ratio rather than a side column. Secondary: a **repurposed-skill family** (train on game `X`, evaluate on unpublished variants `X₁…Xₙ` built so `X`'s optimal program is not optimal for `Xᵢ`) — the environment-family identifiability condition turned into an instrument. Control: an **arbitrary sensorimotor mapping** task at `k ≥ 3` alternatives. `D3` |
| Explicitly out of scope | (i) The **non-embeddable symbolic slice** — modular arithmetic, syntactic recursion, type-checking: no metric, path integration unavailable, and the navigation frame is an untested bet there. (ii) **Static input→output formats with no action stream** (ARC-AGI-1/2, PGM, Raven) — they instantiate a different bit-vector and would be scored by a different organ set. (iii) **Natural language** as either input or output. (iv) **Rewrite-search**: environments whose edge set is rewritten *by the agent's own moves* as a search problem. `D4` |
| Success statement (one sentence, falsifiable) | On held-out instance-graphs of a **seen** environment family, BIRM reaches skill threshold `θ` in fewer environment steps than a flat baseline of matched parameter count, **and** its advantage survives when performance is plotted against *nodes visited* rather than *edges taken* — the `O(E) → O(V)` gap being the operational definition of "it has the meta-graph". `D5` |
| Non-goals inherited from wiki (things known unbuildable today) | **Constructing the problem representation** — deciding what gets to be a variable (`G73`) — and **choosing a parse** of the input (`G75`): both are supplied by the adapter here and charged in §2.2. **Deriving the agent/world boundary** (`G92`): drawn by hand, declared, not inferred. **Searching over rule rewrites** (`T229`): nothing in the wiki does it. **A computable `GD`** (`G31`): approximated in §10, never computed. `D6` |

**Scoring discipline forced by the task set** (not optional; `D7`):

| Rule | Statement |
|---|---|
| S1 | A score is a property of **(approach, compute budget)**. Cost per task appears on every reported line or the line is void. |
| S2 | No benchmark with a **data generator** for the evaluation set; the experience term `E` is capped and reported. |
| S3 | The evaluation family is a **depleting stock**. The set used for intermediate/diagnostic scoring is disjoint from the set used for final scoring, and the number of times each has been read is logged. |
| S4 | Every prior installed is enumerated in §2.2 **before** a score is quoted. A score without its §2.2 denominator is uninterpretable. |
| S5 | The control task (arbitrary mapping, `k ≥ 3`) is run in every evaluation round. A "reasoning" score not exceeding it measured **binding speed**, not inference. Two-alternative forced choice is forbidden: at `k = 2` a Repeat-Stay/Change-Shift heuristic is a complete solution. |

---

## 2. Boundary declaration — BIRM vs. adapter

> This section exists because the agent/world boundary is drawn by hand in every architecture (`G92`), and because whatever is placed in the adapter is the part of the problem that was *not solved*. An undeclared adapter makes every score in §10 uninterpretable.

### 2.1 Adapter contract

| Interface | Spec | Fixed across benchmarks? |
|---|---|---|
| Observation stream(s): count, dimension, rate, dtype, value range | **One** stream. `o_t ∈ ℝ^{D_o}`, float32, range `[0,1]`, exactly one vector per environment step. `D_o` is a per-benchmark constant declared in §2.2, never inferred and never varying within a family. `D8` | Contract fixed; `D_o` **not** fixed — it is hardwiring `H1` |
| Action code: dimension, discrete/continuous, emission rate | **Discrete**, one-hot over `k` primitives, one emission per environment step, no no-op suppression. `k` declared per benchmark. The *semantics* of each primitive are latent to BIRM — the adapter passes indices, never labels. `D9` | Contract fixed; `k` **not** fixed — hardwiring `H2` |
| Primary affect channel (the "kickstarter") — signal, range, latency | Scalar `r_t ∈ [−1, 1]`, delivered on the **same step** as `o_t`, no shaping, no per-benchmark rescaling. Deliberately *one* scalar with **no address**: it cannot name what it is about. `D10` `ASSUMED` — its role as a second multiplicative factor rather than a reward term is a wave-4 question | Yes |
| Episode/reset signalling | Explicit boolean `done_t` on the same step. BIRM carries **no state across `done`** except slow weights `W` — the fast store `S` and the structural code `g` are re-initialised, `g` to a **random phase** so a new environment de-aliases against all previous ones. `D11` | Yes |
| What the adapter is forbidden to do | (a) Parse the observation into objects, entities or slots. (b) Supply the goal, or any signal correlated with distance to it beyond `r_t`. (c) Supply action semantics, action grouping, or an action mask. (d) Vary `D_o` or `k` within a declared family. (e) Carry any state across `done`. (f) Re-order, filter or denoise the stream. `D12` | — |

### 2.2 Declared-hardwiring ledger (mandatory)

Every bit of task knowledge that lives outside the learner, itemised. This is the denominator of every claim in §10.

> **The conservation law that makes this section load-bearing.** Relational content is conserved between *inside a unit* and *between units*: enlarging the units deletes edges by swallowing them, shrinking them multiplies edges without adding information. The choice does **not** converge as granularity is refined. So whatever discretisation the adapter imposes has already absorbed an unmeasured part of the graph BIRM is scored on discovering. `H3` is therefore the denominator of the whole spec, and it is currently unquantified. `D13`

| # | Hardwired thing | Where it lives | Why it cannot be learned | Bits/parameters |
|---|---|---|---|---|
| H1 | Observation dimension `D_o`, dtype, value range | adapter | Fixing the stream's width is prior to any learning over it | `?` — §12 `O1` |
| H2 | Action alphabet **size** `k` (semantics excluded) | adapter | The agent cannot emit an action it has no code for; the code width must precede the first step | `log₂ k` per step, plus `k` declared once |
| H3 | **The discretisation implicit in the encoding** — what counts as one observation, and therefore what counts as one node | adapter | Nothing in the wiki constructs a representation (`G73`) or chooses a parse (`G75`); this spec does not attempt it | `?` — **unquantified and load-bearing**; §12 `O2` |
| H4 | Episode boundaries (`done_t`) | adapter | An episode boundary is a claim about which experiences may bind together; it is not recoverable from the stream at the rate BIRM would need it | 1 bit/step |
| H5 | Existence and sign convention of the affect channel `r_t` | adapter | The agent cannot derive that a scalar is *good* from the scalar itself | 1 scalar/step + sign convention |
| H6 | The **structural code's manifold topology** (which group the action displacements act in) | BIRM | Assumed by the designer, not learned — see §6 | `?` — §12 `O3` |
| H7 | Two-timescale split: which parameters are slow `W` and which are fast `M` | BIRM | The split is a sample-complexity decomposition chosen in advance; nothing in the wiki discovers it | parameter counts, §3 |

**What §2.2 is *not* claiming.** Every row above is a prior in the sense of `P` in the efficiency ratio. `H3` in particular means BIRM is **not** being scored on latent-graph discovery end-to-end: it is scored on discovery over a vertex set the adapter fixed. Any §10 result must be quoted with that qualification attached. `D14`

---

## 3. Organ inventory

> **Status token, local to this section.** `SHAPED` = job, buses, timescale and architectural denials are fixed and carry ledger rows; the slots a later wave supplies are named in §12. `SPECIFIED` requires a §10 falsifier (R4) and §10 is wave 6 — **no organ below is `SPECIFIED`**. The `Falsifier` column therefore names the *candidate* test and the wave that must write it.

| Organ | Job in one line | Inputs (buses) | Outputs (buses) | Objective slot | Learning-rule slot | Architecture slot | Timescale | Falsifier (§10) | Status |
|---|---|---|---|---|---|---|---|---|---|
| **A0 Adapter** | codec + affect channel; not part of BIRM | env | **O**, **V**(`r_t`), `done` | n/a | none (fixed) | fixed codec, §2.1 | fixed | none — A0 is declared, not tested; its content is §2.2 | `DECLARED` |
| **M Model** | slow store of the **meta-graph**: an action-conditioned predictor of the next latent, and the vocabulary `S`'s bindings are written *over* | **Bg**, **Bx**, **Act**, **L**(transport enable) | **Bg**, **Bx**, prediction residual → **X** | `?` — wave 5 (#33) | Slow gradient on **associative weights only**; the input/output codes are frozen during transport (`D23`) | `?` — wave 5 (#33, #34, #36) | slow; written **only** on the transport channel, never online | `F-M`: reverse ablation — freeze the associator and train the codes; transport must fail. Wave 6 | `SHAPED-PARTIAL` |
| **S Store** | fast one-shot instance store, **addressed by `g`**, with a typed access protocol | **Bg** (address), **Bx** (content), **L** (write-enable + erase type + read schedule) | **Bx** (retrieved), occupancy scalar → **N**, `ρ` residual → log | **none** — `S` optimises nothing; its *write policy* is `C`'s (`D33`) | One-shot Hebbian write at the address; write-**enable** learned by RL with per-slot credit `δ_j = gate_j · δ` | Fixed random `g→S` projection + pointwise nonlinearity (§6 `D18`); content slots | one-shot write; typed erase; **read is a scheduled event**, not a pure function of the query | `F-S`: score the read **schedule** separately from the contents — a store whose contents probe clean while task accuracy falls is a scheduler failure, not a memory failure. Wave 6 | `SHAPED` |
| **C Controller** | holds a task model as **sustained state** and emits it as **bias** into organs that keep running their own dynamics | **Bx**, **Bg**, **V**, `S`-read, per-level engagement gains from **X** | **Act**, **L** (write-enable, erase type, read address + lead time), bias into `M`/`S` read, **one channel into `N`** | Task return, via **V** only | Reward-gated association among co-active `C` units (task model) + RL on the gate/schedule outputs | `k` parallel level-searchers; **one common component + `θ_upd` + `θ_shift`, no inhibition-specific parameters**; typed output channels (`D27`, `D28`) | fast (per step); the control state **persists across steps** and is swapped, not recomputed | `F-C1`: bifactor fit over a population of trained instances must recover common + updating + shifting and **no inhibition factor**. `F-C2`: a lesion of `C` must produce context-inappropriate but *confidently executed* actions, not chance. Wave 6 | `SHAPED` |
| **X Arbitrator** | sets **mode** (input-driven vs internally generated) and **which control level is live**, by two separately controlled gains over *edges* | prediction residual from **M**, per-level output entropies from **C**, **V** | `g_rel` (release gain on internal-periphery edges), `g_acq` (acquisition gain on external-reader edges), per-level engagement gains → **C** | `?` — §5.4, wave 3 (#21) | `?` — the set-point is slow and experience-driven; wave 3 | Two gains, not one; address space is **edges, not organs** (`D35`) | fast switch, **slow set-point** | `F-X`: `g_rel` must predict speed only and `g_acq` accuracy only, with the crossed cells empty. Wave 6 | `SHAPED-PARTIAL` |
| **N Metaparameter source** | computes gains, precisions and learning rates from the learner's own second-order statistics | `S` occupancy, **V** statistics, **C**'s channel into `N` | **U**, per-component gains, learning rates | `?` — wave 3 (#19) | `?` — wave 3 (#19) | **Per-component set-points with an operating point each**, never one global gain (`D37`) | slow-ish | `F-N`: a single-scalar `N` must be beatable by per-component gains on a task pair whose optima differ. Wave 6 | `SHAPED-PARTIAL` |

**No seventh organ was added by this wave.** The two candidates were rejected: a *competence estimator* (the biological one is signed-inflated and calibrated by a separate lesionable module) is deferred to §12 `O14` rather than installed, and a *conflict/difficulty detector* is refused outright — the discriminating experiment equates or reverses error, difficulty, conflict and novelty, and only output entropy tracks engagement (`D30`).

### 3.1 M — Model (slow store)

| Slot | Fill |
|---|---|
| State held | Slow weights `W`: the code vocabulary (context codes, event codes, action codes) **and** the associative weights among them, as two separately addressable parameter blocks |
| Parameter count | `?` — §12 `O12` |
| **Architecturally denied** | (i) Online writes — `M` is written **only** on the transport channel, so an environment step can never move a slow weight. (ii) The observation bus into the `g` half (§6 `D15`). (iii) Any ability to schedule its own transport: the filter and the stopping rule live outside it (wave 3, #24) |
| Load-bearing commitment | **`S` and `M` are two organs, not one model with two learning rates** (`D22`), and what transports between them is the **mapping, not the terms** (`D23`) — `M` already holds the vocabulary at acquisition |
| Known hazard | Transport past a finite point *raises* generalization error, and for a relation `M` cannot model the optimal transport is **zero** — so a scheduler that always consolidates is wrong by construction (`D24`) |

### 3.2 S — Store (fast, instance)

| Slot | Fill |
|---|---|
| State held | Content slots; a **pointer register** typed differently from the contents (`D32`); per-slot occupancy |
| Access protocol | `write(addr=g, content)` · `read(addr, lead_time)` · `replace` · `suppress` · `clear`. **Five primitives, not two** (`D32`) |
| **Architecturally denied** | (i) Choosing what it reads — the address *and the lead time* come from `C`. (ii) Surviving `done` (§2.1 `D11`). (iii) Deciding its own erase type — the operation code stays in `C` and only the effect ships downstream. (iv) A write that also discards: unlike PBWM's `Go`, write and erase are separate operations here (`D33`) |
| Load-bearing commitment | The read is a **scheduled, priced event**. `C`'s output is an address **plus a time**, and a mis-scheduled read on intact contents is a distinct, loggable failure class |
| Known hazard | Enlarging `S` need not raise capacity if the bound is in the *selection* rather than the carrier; the occupancy read-out to `N` exists so this is measurable rather than assumed |

### 3.3 C — Controller

**Mechanism.** `C` does not route, gate or rewire anything downstream. It holds a task model as sustained state and adds an excitatory bias to organs that are already running a competition; the competition converts a small bias into a decision, so "enhance the relevant" and "suppress the irrelevant" are one operation and there is **no dedicated suppression channel** (`D25`, `D26`).

| Slot | Fill |
|---|---|
| State held | The task model (sustained, swappable, broadcast); `k` per-level engagement gains; the pointer/schedule registers it drives into `S` |
| Factorization | Three axes, orthogonal and composed: **by operation** — one common component + `θ_upd` + `θ_shift`, **no inhibition-specific parameters** (`D27`); **by output port** — typed channels whose meaning is fixed by their reader (`D28`); **by policy order** — `k` level-searchers, all live from step 1 (`D29`) |
| Engagement rule | Level `j` is engaged iff the running entropy of **its own output** is non-zero: `gain_j ← σ(H[π_j] − h₀)`. Not error, not difficulty, not conflict, not novelty (`D30`) |
| Inter-level interface | Level `j+1` receives `(abstract variable, resolved output)` from level `j` and is **denied the observation bus** (`D31`). Non-bypassability is enforced by wiring, not by a loss term |
| **Architecturally denied** | (i) Routing or gating any downstream organ (only bias). (ii) Inhibition-specific parameters. (iii) The observation bus below level 0. (iv) Emitting "which slot" without a lead time and a removal type. (v) Writing to `M` — `C` can write to `N` and to `S`, never to the slow store |
| Known hazard | Two task models held at once should produce a **blend** — behaviour consistent with neither rule — which is a different signature from forgetting and is what `F-C2` looks for |
| Contested | The bias-only mechanism is disputed: in the biological loop, sustaining the relevant representation and suppressing the irrelevant one are carried by two different populations and removable one at a time. Recorded as `D25` `CONTESTED` against `T275`; §12 `O13` |

### 3.4 X — Arbitrator

| Slot | Fill |
|---|---|
| State held | Mode variable; two gains (`g_rel`, `g_acq`); `k` engagement gains; a slow set-point for each |
| Output shape | **Two gains over edges, not one gain over an organ** (`D35`). A single "suppress the internal mode" scalar can produce the release half and cannot produce the acquisition half, because the acquisition half addresses edges to organs that were not in the internal mode to begin with |
| Trigger (provisional) | The **residual of `M`'s prediction against the immediate past** — local adjustment while it predicts well, global revision from endogenous priors when it does not. Provisional because the threshold is not defined; §5.4 and wave 3 (#21) own the commit discipline |
| **Architecturally denied** | (i) Carrying content — `X` emits gains only. (ii) Being addressed by content. (iii) Setting the *sign* of its own coupling permanently: the internal↔control coupling sign is a controlled variable, not wiring (`D36`) |
| Known hazard | Both failure directions are settings of one variable — never-on (no internal mode) and always-on (rumination) — so an implementation must be able to exhibit both, or the gain is not real |

### 3.5 N — Metaparameter source

Wave 2 fixes only the **shape**; the contents are wave 3 (#19).

| Slot | Fill |
|---|---|
| Load-bearing commitment | Every component has an **operating point**, not a monotone gain, and the optima differ between components — so a controller with one temperature/gain hyperparameter is mis-specified by construction (`D37`) |
| Closed loop | `C` has a channel that writes to `N`, so the control parameters are partly set by the organ they parameterise (`G50`). This is drawn, not filled: what `C` sends is wave 3 |
| **Architecturally denied** | A single global gain shared across components |

### 3.6 What §3 does not have

- **No competence estimator.** The biological default self-model is signed-inflated and its calibrator is a separate, lesionable module with an external referent — so adding a self-assessor to `C` would install the failure mode along with the function. §12 `O14`.
- **No detector organ.** Conflict, difficulty, error and novelty are all refused as engagement variables (`D30`); nothing in BIRM computes them.
- **Buses are named but not specified.** Every `Inputs`/`Outputs` cell above names a bus; the encoding, rate and *denied* columns are §4, wave 3.

---

## 4. Bus inventory

> A signal means what it means because of **who is allowed to read it**, not because it converged to a meaning. Fill the *denied* column first.

| Bus | Carries | Encoding | Rate | Writer | Readers | **Architecturally denied to** | Falsifier |
|---|---|---|---|---|---|---|---|
| **O** observation | `?` | `?` | `?` | A0 | `?` | `?` | `?` |
| **Bg** structural belief (`g`) | `?` | `?` | `?` | M | `?` | `?` | `?` |
| **Bx** content belief (`x`) | `?` | `?` | `?` | M | `?` | `?` | `?` |
| **U** precision / uncertainty | `?` | `?` | `?` | `?` | `?` | `?` | `?` |
| **V** value / prediction error | `?` | `?` | `?` | `?` | `?` | `?` | `?` |
| **L** licensing / write-mask | `?` | `?` | `?` | `?` | `?` | `?` | `?` |
| **Act** action code | `?` | `?` | `?` | C | A0 | `?` | `?` |

Interface state per edge (weight, terminal gain, writability licensor, operating point) — table per edge, or state the decision to omit it and why.

---

## 5. The trace — one step, observation to action

> The load-bearing section. Numbered, no gaps, every line naming the organ, the bus, and the state that persists after it. If a step cannot be written as an assignment, it is not specified.

### 5.1 Online step (mode = input-driven)

| # | Event | Organ | Reads | Writes | State after | Cost |
|---|---|---|---|---|---|---|
| 1 | observation arrives | A0 | env | O | `?` | `?` |
| 2 | `?` | | | | | |
| … | | | | | | |
| n | action code emitted | C | `?` | Act | `?` | `?` |

Required decisions inside the step, not after it:
- Where the belief update is a settling process vs. a feed-forward map. `?`
- Whether the step is time-multiplexed internally (one phase estimating, one phase reading stored transitions). `?`
- What is *not* recomputed this step (persistence). `?`

### 5.2 Rollout step (mode = internally generated)

Same table, plus: what stops the rollout, what tags the produced content as generated rather than observed, and what happens to the tag downstream.

### 5.3 Offline cycle (rest / replay)

Same table. Must state the sampling filter, what is transported from S to M, and the stopping criterion for transport.

### 5.4 Mode arbitration

| Slot | Fill |
|---|---|
| Quantity the arbitrator compares | `?` |
| Where it is computed | `?` |
| Hysteresis / commit discipline | `?` |
| What happens to in-flight rollouts on a switch | `?` |

---

## 6. The factorization — where `g`/`x` is installed and what makes it pay rent

> The wiki's central negative result: no objective is known that prefers a factorized code, and a constant code satisfies path-consistency trivially. So this section is architecture, not loss — and it needs an anti-collapse provision *before* any of it is scored.

| Slot | Fill |
|---|---|
| Mechanism that generates `g` | **Action-accumulated path integration**: `g_t = f(W g_{t−1} + B a_t)`, with `g` never reading `o_t`. Content enters only through the conjunction `p = f(g, x)`. `D15` |
| What makes `g` path-consistent by construction (if anything) | Additivity of the displacement: equal total displacement lands on the same code, so commutativity is a property of the **update rule**, not of a loss. **Conditional** — it requires the family's actions to compose (`G41`); the test that decides this per domain is §7's first row, and if it fails this whole section is void and falls back to §12 `O4`. `D16` |
| What makes a content-contaminated `g` **cost the agent task reward** (rent) | `g` is the **address of the fast store `S`** and is used for nothing else. Two requirements then become forced rather than stipulated: *distinctness* (different states must get different codes or their memories collide) and *path-invariance* (the same state must code the same from any direction or the memory is unretrievable); content-invariance follows, because an address must not depend on what is stored at it. Contamination therefore shows up as **retrieval failure**, which is paid in task reward on the same step. Capacity is the second rent: a frozen random projection from `M` structural modules into `S` makes all `∏ᵢ Kᵢ` states stable attractors with `N_S` growing only **linearly in `M`** — and content-shuffled scaffolds with *learned* bidirectional weights lose the exponential scaling entirely. `D17` |
| Anti-collapse provision, and whether it is a design-time property or a runtime monitor | **Both, and the design-time half comes first.** Design-time: `g` is *architecturally denied* the observation bus, so the constant-encoder solution is not reachable by contaminating it with content — and the `g→S` projection is **fixed and random** with a pointwise nonlinearity (a linear layer fails), so there is no weight that can collapse it. Runtime: **CCGP and parallelism score** over an enumerable condition grid, logged per evaluation round — **not decoding accuracy**, which in the one dataset reporting both was statistically unchanged while CCGP rose. `D18` |
| Path-commutativity residual: formula, when logged | `ρ = ‖g(s, α) − g(s, β)‖₂ / ‖g(s, α)‖₂` for any two action sequences `α, β` with equal total displacement from the same start `s`. Logged **on every `S` write** (the write already computes the address) and reported as a distribution, never a mean. Pass condition is a §10 row, not fixed here. `D19` |
| Manifold topology: assumed or learned; if assumed, stated here as a designer decision | **Assumed — a designer decision, recorded as `H6`.** Which group the displacements act in is chosen per family and not inferred. Two consequences accepted openly: the code cannot compose a joint space from marginals never sampled together, and a family whose true structure is not of the assumed type will be forced onto it silently. `D20` |
| Node set / discretisation: what supplies it | **The adapter, as `H3`.** Stated here rather than hidden: this is the part of latent-graph discovery the spec does not attempt, and the conservation law means the amount conceded is unmeasured. `D21` |

**What §6 still does not have** (`G30`, unchanged by this wave): no objective function is maximised by a path-consistent `g` and minimised by a contaminated one. Everything above is *architecture* and *rent* — the code is built and made to pay, never **trained toward**. The nearest shapes in the wiki are a relations-only Gram penalty (label-free, but no path term and within-input only) and long-range predictability (rewards content-invariance, says nothing about commutativity). Recorded as §12 `O5`; wave 5 (#38) may supersede.

---

## 7. Action-vocabulary rebinding

> The same action code must be able to mean something different in a new environment. Where no relation exists between cue and consequence, no mechanism can be cheaper than one-pair-at-a-time binding — so the design question is *binding speed and where the binding is stored*, not a clever transform.

| Slot | Fill |
|---|---|
| Test that decides whether this domain's actions compose | `?` |
| Path if they compose | `?` |
| Path if they do not | `?` |
| Where a rebinding is written (weights / fast store / interface gain) | `?` |
| Budget: trials to `<10%` error on `k` novel cue→action pairs | `?` (target from biology: ~8 trials/cue) |
| What is preserved across rebinding (the body-independent level) | `?` |
| Size of the body/task-specific decoder below it | `?` |

---

## 8. Exploration vs. exploitation

> Requirement: derived from a quantity the agent already computes, and evaluated *inside* the selector — not an external schedule, not a decayed epsilon.

| Slot | Fill |
|---|---|
| Epistemic quantity, with formula | `?` |
| Which distribution it is defined over (the sign of the term depends on this) | `?` |
| Where it enters the action score | `?` |
| Its metaparameter, and the second-order statistic that sets it | `?` |
| Behaviour at each pipeline stage (§9) | `?` |

---

## 9. Training pipeline

| Stage | Data collector / policy | Objective | What is frozen | What is logged | Exit criterion | Known hazard |
|---|---|---|---|---|---|---|
| P0 `?` | `?` | `?` | `?` | `?` | `?` | `?` |
| P1 pre-training | `?` | `?` | `?` | excitation statistic `?` | `?` | improving the policy destroys model identifiability |
| P2 behaviour cloning | `?` | `?` | `?` | `?` | `?` | downstream head's initialisation transient damages the pretrained representation |
| P3 deployment | `?` | `?` | `?` | `?` | `?` | `?` |

Cross-stage decisions:
- Is a random-play collector kept running alongside the improving policy? `?`
- What crosses a stage boundary unchanged, and what is re-initialised? `?`
- Gain/learning-rate schedule at each boundary (the interface, not the module). `?`

---

## 10. Acceptance tests

> One row per organ, per bus, and per claim class. A test whose failure mode is "we would notice" is not a test.

| # | What it tests | Protocol | Pass condition | Known counterexample class it does **not** rule out |
|---|---|---|---|---|
| T1 | `?` | `?` | `?` | `?` |

Mandatory rows: (a) a planner-in-the-loop score for M, not a prediction loss; (b) an arbitrary-mapping control task — any "reasoning" score not exceeding it measured binding speed; (c) a read-side score for S, separate from its write-side forgetting number; (d) a learning-*trajectory* comparison, not an endpoint score; (e) a two-frame re-run of every null result.

---

## 11. Decision ledger

| # | Decision | Section | Status | Source (wiki page / `raw/` file) | Gap / tension id | Supersedes | What would kill it |
|---|---|---|---|---|---|---|---|
| D1 | Task set is the **interactive, transition-sampled** slice, not the static-pair slice | §1 | `SOURCED` | `[[wiki/concepts/three-component-framework.md]]` (No Free Lunch → name the set); `[[wiki/concepts/latent-graph-discovery.md]]` (taxonomy) | — | — | A demonstration that the organ set specified here is strictly worse on interactive tasks than on static ones, i.e. that the action stream is not what it is buying |
| D2 | Latent bit-vector fixed as edge-existence + edge-label + path + goal; node content **given** | §1 | `SOURCED` | `[[wiki/concepts/latent-graph-discovery.md]]` benchmark × latent-variable table | `G73`, `G75` | — | Showing the given-node-content assumption is what carries the result — i.e. performance collapses under any change of adapter encoding that preserves the information |
| D3 | Benchmarks: ARC-AGI-3 primary, repurposed-skill family secondary, arbitrary-mapping control | §1 | `SOURCED` | `[[wiki/entities/arc-agi-3.md]]`; `[[wiki/concepts/skill-acquisition-efficiency.md]]` (repurposed-skill design); `[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]` | `G31` | — | Wave 6 (#43–#48) showing ARC-AGI-3's instrument cannot separate structure discovery from search — the certification inventory is read then, not now |
| D4 | Non-embeddable symbolic slice, static formats, natural language, rewrite-search all out of scope | §1 | `SOURCED` | `[[wiki/concepts/latent-graph-discovery.md]]` (open problems; hardness 6) | `G11`, `T229` | — | Nothing kills an exclusion; it is withdrawn only by a decision that names D4 and supplies the mechanism |
| D5 | Success = fewer steps on held-out instance-graphs **and** an `O(E)→O(V)` gap on the nodes-visited vs. edges-taken curves | §1 | `MEASURED` | `[[wiki/concepts/latent-graph-discovery.md]]` (TEM: 18 steps infer 42 links; accuracy tracks nodes visited) | `G17` | — | The gap appearing in a flat baseline of matched parameter count — which would make it a property of the environment family, not of the meta-graph |
| D6 | Representation construction, parse choice, boundary derivation and rewrite-search are declared non-goals | §1 | `SOURCED` | `[[wiki/concepts/problem-framing.md]]` ("Constructed by the system: **None**") | `G73`, `G75`, `G92`, `G31` | — | Any wiki page supplying a mechanism for one of them; then that non-goal is withdrawn by a superseding row |
| D7 | Scoring discipline S1–S5 binds every reported number | §1 | `MEASURED` | `[[wiki/concepts/skill-acquisition-efficiency.md]]` (Chollet 2019 checklist + ARC Prize 2024 corrections); `[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]` (`k = 2` heuristic) | `G6`, `G17`, `G31`, `G74` | — | S5 failing as a control — i.e. the arbitrary-mapping task turning out to be *harder* than the target tasks, which would make it a ceiling rather than a floor |
| D8 | Single observation stream, fixed `D_o`, one vector per step | §2.1 | `ASSUMED` | — | `G92` | — | A benchmark in scope that cannot be expressed as one fixed-width stream without the adapter doing forbidden work |
| D9 | Discrete one-hot action code, `k` given, **semantics latent** | §2.1 | `SOURCED` | `[[wiki/entities/arc-agi-3.md]]` (action semantics withheld); `[[wiki/concepts/latent-graph-discovery.md]]` hardness 2 | `G66` | — | Wave 5 (#37, AdaWorld) showing the alphabet itself must be induced, which would move `k` out of §2.2 and into the learner |
| D10 | Affect is one same-step scalar in `[−1,1]` with **no address** | §2.1 | `ASSUMED` | `[[wiki/concepts/latent-graph-discovery.md]]` (goal node latent) — the no-address property is wave 3 (#18) | — | — | Wave 3/4 establishing the kickstarter is a multiplicative second factor rather than a reward-like scalar; D10 is then superseded, not amended |
| D11 | Nothing survives `done` except slow `W`; `g` re-initialised to a **random phase** | §2.1 | `SOURCED` | `[[wiki/entities/vector-hash.md]]` (random initial phase de-aliases new environments against all previous) | `G2` | — | Evidence that cross-episode carry-over of the fast store is what buys transfer, which would make the reset the bug |
| D12 | Adapter prohibitions (a)–(f), especially **no object parse** | §2.1 | `SOURCED` | `[[wiki/concepts/node-definition-problem.md]]`; `[[wiki/concepts/problem-framing.md]]` (G75) | `G73`, `G75` | — | Showing (a) is unenforceable — that any fixed encoding of a benchmark in scope already constitutes an object parse, which would make the prohibition cosmetic |
| D13 | §2.2 is the denominator of every §10 claim, and `H3` is its load-bearing unquantified row | §2.2 | `SOURCED` | `[[wiki/concepts/node-definition-problem.md]]` (conservation law; non-convergence under refinement) | `G27`, `G75` | — | A measure of how much relational content a given encoding absorbs — which would convert `H3` from a caveat into a number and is the single most valuable thing that could be added here |
| D14 | BIRM is scored on discovery **over a vertex set the adapter fixed**, and says so | §2.2 | `SOURCED` | `[[wiki/concepts/node-definition-problem.md]]` "For a builder" | `G27` | — | Nothing; this is a disclosure, not a design choice. It is removed only when D6's non-goal is withdrawn |
| D15 | `g` generated by action-accumulated path integration and **denied the observation bus** | §6 | `SOURCED` | `[[wiki/concepts/path-integration.md]]` via `G3`; `[[wiki/concepts/abstract-structural-codes.md]]` | `G3`, `G1` | — | Wave 4 (#26) showing path integration cannot be made to work without a content-driven correction term, which would re-open the observation bus to `g` |
| D16 | Path-consistency is a property of the update rule, conditional on actions composing | §6 | `SOURCED` | `G3` = `PARTIAL` (Whittington et al. 2022; Peng et al. 2025) | `G3`, `G41` | — | The compositionality test in §7 failing on the target family — in which case §6 is void and `O4` becomes blocking |
| D17 | Rent for `g` = it is the **address of `S`** and nothing else; contamination costs retrieval and costs capacity | §6 | `MEASURED` | `[[wiki/concepts/abstract-structural-codes.md]]` (Whittington 2020 derivation; Chandra 2023 capacity, content-shuffled scaffolds lose exponential scaling) | `G30`, `G1` | — | A demonstration that a contaminated `g` retrieves fine at the scale BIRM runs at — i.e. that the capacity argument does not bind below some `M` this design never exceeds |
| D18 | Anti-collapse: design-time denial + fixed random `g→S` projection; runtime **CCGP/PS**, never decoding accuracy | §6 | `MEASURED` | `[[wiki/concepts/representational-collapse.md]]` via `G34`; `[[wiki/concepts/population-geometry.md]]` (Courellis 2024: decoding flat while CCGP rose) | `G34` | — | Collapse appearing anyway in a form CCGP cannot see; or wave 5 (#38) naming a collapse mode that a frozen projection does not prevent |
| D19 | Commutativity residual `ρ` logged on every `S` write, reported as a distribution | §6 | `ASSUMED` | `[[wiki/concepts/representation-probing.md]]` (path-consistency as a residual between codes decoded after distinct routes) | `G3` | — | The residual being uninformative — e.g. near-zero for a code that demonstrably fails transfer, making it a monitor that never fires |
| D20 | Manifold topology **assumed**, per family, recorded as `H6` | §6 | `ASSUMED` | `[[wiki/concepts/abstract-structural-codes.md]]` open problem "what supplies the metric?" | `G11`, `G43` | — | A mechanism that infers the group from the action stream; that supersedes D20 rather than amending it |
| D21 | Node set supplied by the adapter, stated in §6 rather than hidden | §6 | `SOURCED` | `[[wiki/concepts/node-definition-problem.md]]` | `G27`, `G73` | — | See D14 — disclosure, not choice |
| D22 | **`S` and `M` are two organs**, not one model with two learning rates | §3 | `MEASURED` | `[[wiki/concepts/complementary-learning-systems.md]]` (two independent derivations: interference, and sample complexity; AB–AC: cortex+hippocampus learns faster *and* forgets less than either alone) | `G1`, `T2` | closes `O7` | A single-store instance matching the two-organ one on the AB–AC-shaped test — i.e. the interference argument not binding at BIRM's scale |
| D23 | Transport writes **only the associative weights**; `M`'s input and output codes are frozen during it | §3.1 | `SOURCED` | `[[wiki/entities/medial-prefrontal-cortex.md]]` / `[[wiki/concepts/complementary-learning-systems.md]]` (Euston et al. 2012: cortex represents context, events and responses at acquisition; only the mapping migrates) | `G14` | — | The reverse ablation succeeding: codes trainable + associator frozen consolidating as well as the specified split (`F-M`) |
| D24 | Consolidation is **gated, not scheduled** — the optimal transport for a relation `M` cannot model is zero | §3.1 | `MEASURED` | `[[wiki/concepts/generalization-optimized-consolidation.md]]` via `[[wiki/concepts/complementary-learning-systems.md]]` (Sun et al. 2023: transport past a finite point raises generalization error) | `G14` | — | Nothing — but the *filter* that implements the gate is wave 3 (#24), so this row is a constraint on that filter, not a mechanism |
| D25 | `C` acts by **additive bias into a competing substrate**; it does not route, gate or rewire anything downstream | §3.3 | `CONTESTED` | `[[wiki/concepts/cognitive-control.md]]` (Miller & Cohen guided activation) — disputed by `[[wiki/entities/mediodorsal-thalamus.md]]` | `T275` | — | The mediodorsal result generalising: if sustain and suppress are separable channels removable one at a time, bias-only is wrong and `C` needs an addressed suppression output. §12 `O13` |
| D26 | `C`'s task model is carried as **sustained activity, not weights**, because it must reach many organs and be swapped within a step | §3.3 | `SOURCED` | `[[wiki/concepts/cognitive-control.md]]` (broadcast + swap argument; capacity falls out of the carrier as interference, not slots) | `G42` | — | Showing a weight-carried control state can be broadcast and swapped at step rate without the interference signature — which would remove the whole derivation |
| D27 | `C` is factorized **by operation** into one common component + `θ_upd` + `θ_shift`, with **no inhibition-specific parameters** | §3.3 | `MEASURED` | `[[wiki/concepts/control-unity-and-diversity.md]]` (bifactor: updating- and shifting-specific factors, no inhibition-specific factor; latent `r = 0.42–0.63` where raw task `r = −0.05–0.34`) | `G55` | — | `F-C1` recovering an inhibition-specific factor over a population of trained instances — which would mean BIRM has suppression parameters it was not supposed to have |
| D28 | `C`'s outputs are **typed channels whose meaning is fixed by their reader**, including one channel that writes to `N` | §3.3, §3.5 | `SOURCED` | `[[wiki/entities/medial-prefrontal-cortex.md]]` (factorization by output port; deep-layer → patch → the teaching-signal generator) | `G50`, `G52` | — | A demonstration that a single untyped control output plus a learned readout does the same work — i.e. that typing buys nothing an ordinary decoder cannot learn |
| D29 | `C` is `k` **parallel level-searchers, all live from step 1**, not a router and not a curriculum | §3.3 | `MEASURED` | `[[wiki/concepts/policy-abstraction-hierarchy.md]]` (Badre et al. 2010: the order-2 band is above baseline early in the *flat* condition and declines; early activity predicts who finds the abstraction) | `G12`, `G5` | — | The `O(k)` fixed cost not being repaid — a serial/bottom-up stack matching the parallel one on step-shaped learning curves |
| D30 | Level engagement = the running **entropy of that level's own output**. Error, difficulty, conflict and novelty are refused | §3.3 | `MEASURED` | `[[wiki/concepts/policy-abstraction-hierarchy.md]]` (Matsuzaka et al. 2012: population empties under single-tactic retraining at 99–100% accuracy, returns when both tactics restored; the *higher*-conflict condition is one that silences it) | `G58` | — | Entropy failing to track engagement where the alternatives do — the discriminating design being one where the level's output stops varying but the structure is still being searched |
| D31 | The interface between levels is a **narrowing**: level `j+1` gets `(abstract variable, resolved output)` and is **denied the observation bus** | §3.3 | `SOURCED` | `[[wiki/concepts/policy-abstraction-hierarchy.md]]` (Awan et al. 2020: cue position present in pmPFC, absent one station caudal); the machine sample violates it without exception | `G59` | — | The narrowed interface costing performance with no compensating gain in non-bypassability — i.e. the lower level needing the observation to do its job at all |
| D32 | `S` exposes **five** access primitives — scheduled read, `replace`, `suppress`, `clear` — and carries a **pointer register typed apart from the contents** | §3.2 | `MEASURED` | `[[wiki/concepts/memory-read-and-erase.md]]` (Lundqvist et al. 2018 read schedule and prospective clear; DeRosa et al. 2024 typed removal; Lebedev et al. 2004: 61% pointer vs 16% content) | `G48`, `G49` | — | `suppress` never being used by a trained `C` — which would say the extra primitive is cortical bookkeeping with no machine role (§12 `O2` of that page's own open list) |
| D33 | `S`'s **write enable is learned by RL** with per-slot credit `δ_j = gate_j · δ`; write and erase are **separate operations** | §3.2 | `MEASURED` | `[[wiki/entities/pbwm.md]]` (no DA modulation → 0% of networks learn any task; per-stripe credit ablation nearly as damaging) | `G19`, `G49` | — | A fixed or threshold write policy matching the learned one on the shared-stimulus case — the case where no fixed input→memory weight can work |
| D34 | The **V-bus is one unaddressed scalar**: sign supplied by the receiver's type, address by co-activity; gain and learning rate are co-modulated by it | §3 (pre-commit for §4) | `MEASURED` | `[[wiki/entities/basal-ganglia.md]]` (D₁/D₂ opposite excitability *and* opposite plasticity sign from one broadcast scalar; sign from a tonic baseline rather than signed weights) | `G19` | — | Wave 3 (#18) showing the scalar must carry an address after all; then D34 is superseded, not amended. `[[wiki/empirical-tensions.md]]` `T129` also disputes the balance reading |
| D35 | `X` emits **two gains over edges**, not one gain over an organ: `g_rel` (release) and `g_acq` (acquisition) | §3.4 | `MEASURED` | `[[wiki/entities/default-mode-network.md]]` (Gao et al. 2013: core↔periphery `0.43 → 0.24` predicts reaction time only; core↔recruited `0.05 → 0.34` predicts accuracy only; crossed cells and within-class cells empty) | `G90` | — | `F-X` finding the two gains predict the same quantity — which would collapse them back into one mode scalar |
| D36 | The sign of the internal↔control coupling is a **controlled variable**, not wiring | §3.4 | `SOURCED` | `[[wiki/entities/default-mode-network.md]]` (Tripathi et al. 2025: negative during generation, positive during evaluation, within one act) | `G90` | — | Nothing in wave 2; the scheduling rule that sets the sign is `O15` and is wave 3/5 work |
| D37 | `N` has **per-component set-points with an operating point each**; a single global gain is refused | §3.5 | `MEASURED` | `[[wiki/concepts/control-unity-and-diversity.md]]` (inverted-U for every modulator; dopamine depletion impairs updating while *improving* shifting — one scalar, opposite signs) | `G50`, `G61` | — | `F-N`: a single-scalar `N` matching per-component gains on a task pair whose optima differ |
| D38 | No competence estimator and no conflict/difficulty detector are installed | §3.6 | `SOURCED` | `[[wiki/concepts/default-self-model.md]]` (the uncorrected self-model is signed-inflated; the calibrator is a separate lesionable module with an external referent); `[[wiki/concepts/policy-abstraction-hierarchy.md]]` (conflict equated or reversed) | `G89`, `G58` | — | A routing decision BIRM must make that is expressible only as a competence estimate; that opens `O14` into an organ |
| D39 | The output-port factorization is **not visible in unit activity** — any probe of `D28` must be geometric | §3.3, §10 | `MEASURED` | `[[wiki/entities/medial-prefrontal-cortex.md]]` (Lai et al. 2026: no rate difference under any condition; the two channels diverge only in population geometry, sharing a common reference state) | `G52` | — | Nothing — this is a measurement constraint. It kills any §10 row that tries to verify a typed channel by reading a unit |

---

## 12. Open slots

| # | Unfilled thing | Section | Gap id | Blocking? | Cheapest way to close |
|---|---|---|---|---|---|
| O1 | `D_o` and its value range per benchmark | §2.2 `H1` | — | No | Read the benchmark's own observation spec; it is a lookup, not a decision |
| O2 | **How many bits of graph the adapter's discretisation absorbed** | §2.2 `H3` | `G27`, `G75` | **Yes — for interpreting §10, not for building** | Run the same family at two encoding granularities and report the score difference; the conservation law says it will not be zero, and the size of the difference is the missing number |
| O3 | Which group the action displacements act in, per family | §2.2 `H6`, §6 | `G11`, `G41` | **Yes** | §7's compositionality test, which is wave 4 (#27); until then the topology is a per-family stipulation |
| O4 | Fallback for `g` when the family's actions do **not** compose | §6 | `G41`, `G2` | **Yes if the §7 test fails** | The wiki's complement is a frozen per-observation clone pool learned by expectation–maximisation — de-aliases locally and fast, transfers nothing. Merging it with path integration is named in the wiki as an obvious unbuilt model; wave 5 (#34, #35) |
| O5 | **An objective that prefers a path-consistent, content-free `g`** | §6 | `G30` | No — §6 is architecture + rent, and builds without it | Nothing in the wiki closes it. Nearest shapes: a relations-only Gram penalty, and long-range predictability. Wave 5 (#38, #39) is where this is re-attempted |
| O6 | Whether the affect channel is a reward term or a multiplicative second factor | §2.1 `D10`, §8 | — | No | Wave 4 (#29) `motivation-representation-synergy`: `expressed competence ≈ representation × motivation` |
| O7 | ~~The parameter split between slow `W` and fast `M`~~ | §2.2 `H7`, §3 | `G1` | No | **CLOSED, wave 2, by `D22`** — `S` exists as a separate organ, on two independent derivations. The residual *parameter count* question is re-opened as `O12` |
| O8 | Pass condition for the commutativity residual `ρ` | §6 `D19`, §10 | `G3` | No | Measure `ρ`'s distribution on a family where transfer is known to work, and set the threshold from it — it cannot be chosen a priori |
| O9 | The condition grid CCGP/PS is computed over | §6 `D18`, §10 | `G34` | No | Requires an enumerable factor structure in the evaluation family; ARC-AGI-3 may not supply one, in which case a purpose-built probe family is needed |
| O10 | A computable proxy for generalization difficulty `GD` | §1 `D7`, §10 | `G31` | No | Human success rate per task (needs successes), or mean human description length (collectable from participants who *fail*, `r = −0.50` with accuracy) |
| O11 | **The lead-time policy for `S`'s scheduled read** | §3.2 `D32` | `G49` | No | The output *format* is known (address + lead time); nothing says what the lead time is a function of — retrieval latency, deadline, or confidence. No source in the wiki supplies it; it is a design sweep, not a lookup |
| O12 | Parameter counts for `M`, `S` and `C`, and the slow/fast split between them | §3.1, §2.2 `H7` | `G1` | No | Follows from the §6 capacity argument once `M`'s module count is chosen — `N_S` grows linearly in the number of structural modules, so the split is derivable rather than tuned. Wave 5 (#33, #34) |
| O13 | **Whether `C` needs an addressed suppression channel after all** | §3.3 `D25` | — (`T275`) | **Yes if it resolves against bias-only** | Two controllers on one backbone — bias-only into a competitive substrate vs. bias plus a dedicated suppression output — scored by `F-C1`. Architecture (a) must yield no inhibition-specific factor; (b) must yield one. Costs a seed sweep |
| O14 | A **competence estimator and its external calibrator** | §3.6 `D38` | `G89` | No | Deliberately not installed. If a routing decision forces it, the biology's constraint is that the calibrator must sit outside the trained loop with an external referent, or the estimate inflates. Wave 6 (#43, #47) |
| O15 | **What sets the sign of the internal↔control coupling** | §3.4 `D36` | `G90` | No | No source names the variable that flips it; "internal vs external content" does not separate the cases, since generation and evaluation share content. Nearest machine framing is the proposer/verifier schedule — wave 5 (#39, #41) |
| O16 | **The timescale of the engagement gain** | §3.3 `D30` | `G58` | No | The biological measurement is a ~2-week retraining effect, i.e. a consolidated statistic rather than a per-trial register. The discriminating run — interleaving single- and multi-choice blocks trial-by-trial — was never done in biology and is cheap in simulation |
| O17 | **`X`'s residual threshold** — how badly the immediate past must predict before a global revision fires | §3.4, §5.4 | `G90` | No | The source that supplies the trigger supplies no threshold, so "poorly predicted" is not yet a measurable condition. Wave 3 (#20, #21) owns the commit discipline |

---

## 13. Spec changelog

| Date | Wave | Change | Ledger rows touched |
|---|---|---|---|
| — | — | template created (`_brainstorm/birm-spec-template.md`) | — |
| 2026-08-27 | 1 | Instantiated from the template. Filled §1 (scope + scoring discipline S1–S5), §2.1 (adapter contract), §2.2 (hardwiring ledger `H1`–`H7`), §6 (factorization skeleton). Registry pass `G1 G2 G3 G16 G26 G29 G30 G34 G92`, `T14 T16 T20`. No wave-1 page struck under K5 | `D1`–`D21` created; `O1`–`O10` opened |
| 2026-08-27 | 2 | Filled §3 (organ inventory + detail sheets §3.1–§3.6). Six organs shaped, none `SPECIFIED` — §10 is wave 6, so `Falsifier` names candidates `F-M`, `F-S`, `F-C1`, `F-C2`, `F-X`, `F-N` rather than tests. Registry pass `G48 G49 G55 G58 G60 G90 G96 G98`, `T98 T104`. No wave-2 page struck under K5 | `D22`–`D39` created; `O7` closed by `D22`; `O11`–`O17` opened |
