# BIRM — Buildable Spec (TEMPLATE)

**Status: TEMPLATE. Nothing below is a claim yet.** Every filled cell must carry a ledger row in §11. A section with no ledger rows is not "done", it is "asserted".

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
| Target task set (three-component framing: name it or No-Free-Lunch applies) | `?` |
| Benchmarks that instantiate it | `?` |
| Explicitly out of scope | `?` |
| Success statement (one sentence, falsifiable) | `?` |
| Non-goals inherited from wiki (things known unbuildable today) | `?` |

---

## 2. Boundary declaration — BIRM vs. adapter

> This section exists because the agent/world boundary is drawn by hand in every architecture (`G92`), and because whatever is placed in the adapter is the part of the problem that was *not solved*. An undeclared adapter makes every score in §10 uninterpretable.

### 2.1 Adapter contract

| Interface | Spec | Fixed across benchmarks? |
|---|---|---|
| Observation stream(s): count, dimension, rate, dtype, value range | `?` | `?` |
| Action code: dimension, discrete/continuous, emission rate | `?` | `?` |
| Primary affect channel (the "kickstarter") — signal, range, latency | `?` | `?` |
| Episode/reset signalling | `?` | `?` |
| What the adapter is forbidden to do | `?` | — |

### 2.2 Declared-hardwiring ledger (mandatory)

Every bit of task knowledge that lives outside the learner, itemised. This is the denominator of every claim in §10.

| # | Hardwired thing | Where it lives | Why it cannot be learned | Bits/parameters |
|---|---|---|---|---|
| H1 | `?` | adapter / BIRM | `?` | `?` |

---

## 3. Organ inventory

| Organ | Job in one line | Inputs (buses) | Outputs (buses) | Objective slot | Learning-rule slot | Architecture slot | Timescale | Falsifier (§10) | Status |
|---|---|---|---|---|---|---|---|---|---|
| **A0 Adapter** | codec + affect channel; not part of BIRM | env | O-bus, R-bus | n/a | none (fixed) | `?` | fixed | `?` | `?` |
| **M Model** | action-conditioned predictor of next latent | `?` | `?` | `?` | `?` | `?` | slow + fast | `?` | `?` |
| **S Store** | fast one-shot episodic store with a typed read protocol | `?` | `?` | `?` | `?` | `?` | one-shot | `?` | `?` |
| **C Controller** | selects actions and sub-policies from buses | `?` | `?` | `?` | `?` | `?` | fast | `?` | `?` |
| **X Arbitrator** | selects *mode* (input-driven vs internally generated), and which control level is live | `?` | `?` | `?` | `?` | `?` | fast | `?` | `?` |
| **N Metaparameter bus source** | computes gains, precisions, learning rates from the learner's own second-order statistics | `?` | `?` | `?` | `?` | `?` | slow-ish | `?` | `?` |
| `?` | | | | | | | | | |

Per-organ detail sheets go in §3.x, one subsection each, same column set expanded plus: state variables held, parameter count, what it is architecturally **denied**.

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
| Mechanism that generates `g` | `?` |
| What makes `g` path-consistent by construction (if anything) | `?` |
| What makes a content-contaminated `g` **cost the agent task reward** (rent) | `?` |
| Anti-collapse provision, and whether it is a design-time property or a runtime monitor | `?` |
| Path-commutativity residual: formula, when logged | `?` |
| Manifold topology: assumed or learned; if assumed, stated here as a designer decision | `?` |
| Node set / discretisation: what supplies it | `?` |

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
| D1 | `?` | `?` | `ASSUMED` | — | `?` | — | `?` |

---

## 12. Open slots

| # | Unfilled thing | Section | Gap id | Blocking? | Cheapest way to close |
|---|---|---|---|---|---|
| O1 | `?` | `?` | `?` | `?` | `?` |

---

## 13. Spec changelog

| Date | Wave | Change | Ledger rows touched |
|---|---|---|---|
| `?` | `?` | template created | — |
