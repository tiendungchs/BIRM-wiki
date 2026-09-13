# BIRM — The Model at a Glance

**Status: derived, no new decision, no ledger row.** A one-screen restatement of `_brainstorm/birm-spec.md` for someone who wants to *build* it. Every cell here is a pointer; the argument, the ledger id and the evidence live in the spec. Where this page and the spec disagree, the spec wins and this page is patched (spec `R2`, `R6`).

> **What this document is.** The shape of the model: what the blocks are, what wires join them, what one step does, what is trained when, and what is still `?`. Read this first; go to the pointer in the last column for detail.
>
> **What it is not.** Not the claim (spec §1), not the denominator (spec §2.2), not the tests (spec §10), not the rationale (spec §11). None of that is needed to implement the forward pass.

---

## 1. Interface

| | Shape | Notes | Detail |
|---|---|---|---|
| In | `o_t ∈ ℝ^{D_o}`, float32, `[0,1]` — one per env step | unparsed; lands on **one** block only | spec §2.1 |
| In | `r_t ∈ [−1,1]` scalar, same step | no address, no shaping | spec §2.1 |
| In | `done_t` bit | wipes the fast store, re-seeds `g` to a random phase | spec §2.1 `D11` |
| Out | `a_t` one-hot over `k` | indices only; semantics latent | spec §2.1 `D9` |
| Instantiate with | `⟨D_o, k, Ŝ⟩` | every width below is a function of these plus two free scalars `K`, `c` | spec §2.2 `D85` |

Everything benchmark-specific (pixels, key codes, reward shaping) is the **adapter**, outside the model. Its choices are the `H1`–`H10` ledger — the denominator of every score, not part of the build (spec §2.2).

---

## 2. Blocks

Six organs, no seventh. Three of them are drawn as sub-units because the spec already addresses their parts separately.

| Organ | Sub-unit | What it is | Parameters | Learns | Detail |
|---|---|---|---|---|---|
| **Cortex** | `CX·g` | path integrator: `g_t = ℓ₂(W_{a_{t−1}} g_{t−1})`, `W_a = f_g(a)`. One matvec, feed-forward, deterministic. **Never sees `o_t`** | `f_g`: `k` operators of size `K×K`; `n_mod = ⌈log_K Ŝ⌉` modules | `f_g` re-fit per environment | spec §6 `D63`, `D65`; §7 `D77` |
| | `CX·x` | content half: effect-equivalence codebook front end, then settles `m⁻` (phase α, from structure) and `m⁺` (phase β, under clamped `o_t`). Stochastic — determinism forbidden | width follows `D_o` | codebook frozen after P0; associative weights only on the offline channel | spec §3.1 `D86`–`D88`; §6 `D71` |
| | `CX·W` | codes + associative weights as two separately addressable blocks — the **meta-graph** (action-conditioned next-content predictor) | derived from `⟨D_o, k, Ŝ⟩` | slow gradient, associative block only, **never online** | spec §3.1 `D22`–`D24` |
| **Hippocampus** | `HC·scaf` | frozen random `g → slot` projection + pointwise nonlinearity; decides which slots exist | `N_slots = c·n_mod` | **never** | spec §3.2, §6 `D17`, `D18`, `D68` |
| | `HC·cont` | one-shot content layer: per slot the conjunction `(Δ = m⁺ − m⁻, a_{t−1}, r_t)`, occupancy, per-feature variance, provenance bit | — | Hebbian one-shot write at address `g_t`; typed erase from PFC; wiped at `done` | spec §3.2 `D32`, `D74`, `D76`, `D173` |
| | `HC·conf` | per-read confidence scalar + occupancy scalar → Neuromodulators | — | — | spec §3.2 `D69` |
| **PFC** | `PF·lv` | `k` parallel level-searchers holding the task model as sustained state; level `j+1` gets `(abstract var, resolved output)` from `j` only; `gain_j = σ(H[π_j] − h₀)` | one common component + `θ_upd` + `θ_shift`; no inhibition parameters | reward-gated association among co-active units (P2) | spec §3.3 `D25`–`D31` |
| | `PF·act` | action port: argmax over a biased competition → `Act` | — | RL on gate/schedule outputs, per-slot credit `δ_j = gate_j·δ` | spec §3.3, §5.1 step 10 |
| | `PF·cmd` | write/bias port: `L_cmd = (address, lead time, erase type)` into the store; additive bias into `CX·x`; operating-point offset into Neuromodulators | — | same | spec §3.3 `D32`, `D33`, `D43` |
| **Thalamus** | — | phase clock (α/β); commit gate onto **W** (threshold = bifurcation point of the settle, resting distance set by `U`); two edge gains `g_rel`, `g_acq`; publishes `scope`, `generated` | two gains + `k` engagement gains + set-points | resting distance only | spec §3.4, §5.4 `D35`, `D53`–`D56`, `D62` |
| **Neuromodulators** | — | computes `m_t` (one low-dim vector) from the learner's own second-order statistics via **eight fixed laws**; each organ decodes `f_k(W_k · m_t)` | one small decoder matrix per organ | nothing — laws are authored | spec §3.5 `D37`, `D40`–`D42`, `D91`, `D179` |

Refused, by decision: competence estimator, conflict/error/novelty detector, transfer path out of PFC, feedback into perception, option library, seventh organ (spec §3.6, `D101`).

---

## 3. Wires

Eight buses. A bus means what it means by **who may read it**; the denied column is the design.

| Bus | Carries | Writer | Readers | Denied to | Detail |
|---|---|---|---|---|---|
| **O** | `o_t` | Periphery | `CX·x` only, phase β only | `CX·g`, PFC, Thalamus, NM, Hippocampus, phase α | spec §4 `D15`, `D31`, `D50` |
| **Bg** | `g_t` — a content-free address; low-passed on the edge | `CX·g`; `HC·scaf` (reset at 9b) | Hippocampus (address), PFC (level context), `CX·p` | time-locking to **Bx** | spec §4 `D45`, `D46`, `D65` |
| **Bx** | content, registers `Bx⁻` (predicted) / `Bx⁺` (observed) | `CX·x`; `HC·cont` (retrieved) | Hippocampus, PFC, Thalamus (aggregate only) | carrying context | spec §4 `D50`, `D53` |
| **U** | `m_t` | Neuromodulators | every organ via its own decoder | reading raw; any shared global gain | spec §4 `D37`, `D40`, `D41` |
| **V** | one scalar (`r_t` + Cortex residual), **no address**, unrectified | Periphery, `CX·x` | Hippocampus, PFC, NM, Cortex (transport gate), Thalamus (residual) | carrying an address | spec §4 `D70`, `D249` |
| **L** | `L_cmd` struct; `L_part` one gate per organ, self-issued; `L_tr` transport enable | `PF·cmd`; every organ about itself; `HC·cont` | Hippocampus; credit path; Cortex | action path reading `L_part` | spec §4 `D44`, `D57` |
| **W** | the committed payload (a copy) + `scope` + `generated`; exclusive, held for a dwell | Thalamus (gate) + winner (payload) | all organs | any transform of the payload | spec §4 `D47`, `D48`, `D61` |
| **Act** | one-hot over `k` | `PF·act` | Periphery at `t`; `CX·g`, `HC·cont`, NM as efference copy `Act(t−1)` | Thalamus; PFC reading itself | spec §4, §7 `D76`, `D91` |

Every edge carries four registers — weight, terminal gain, writability, operating point — and **no conduction delay** (spec §4.1). Full edge list with live-when and denied columns: `birm-flow.md` §3. Diagram with sub-units and all arrows: `birm-flow.md` §2.2.

```
                 o_t (β only)         r_t
   env ──► Periphery ────────────┐      │                 done ─► wipe HC, reseed g
                                 ▼      ▼
   Act(t−1) ─► CX·g ──Bg──► HC·scaf ─► HC·cont ──Bx⁻──► CX·x ──Bx⁺──► Thalamus ──W──► all
                 ▲            ▲  (reset, 9b)               ▲  (bias)        (commit)  │
                 │            └──────── L_cmd ◄──── PF·cmd ◄────────────────────────┘
                 │                                      │
                 └────────────── Act ◄──── PF·act ◄── PF·lv ◄── Bg, Bx, W, V, U
                                                        ▲
   Neuromodulators ──U──► every organ's decoder          └── HC·conf, V stats, action log ──► NM
```

---

## 4. One online step

Two phases inside one env step, driven by Thalamus's clock. Phase α predicts from structure; phase β admits the observation; the difference is the write.

| # | Who | Does | Detail |
|---|---|---|---|
| 1 | Periphery | `o_t`, `r_t`, `done` arrive | spec §5.1 |
| 2 | Thalamus | **phase α**: **O** gated off | `D50` |
| 3 | `CX·g` | `g_t = ℓ₂(W_{a_{t−1}} g_{t−1})` | `D63` |
| 4 | Hippocampus | scheduled read at address `g_t`, lead time from `PF·cmd` → `Bx⁻` | `D32` |
| 5 | `CX·x` | settle `m⁻` from `Bg`, `Bx⁻` | `D50` |
| 6 | Thalamus | **phase β**: **O** admitted, store read attenuated | `D51` |
| 7 | `CX·x` | settle `m⁺` under clamped `o_t`; settle ends at commit, hard cap as fallback | `D53` |
| 8 | Thalamus | **commit**: aggregate `Bx⁺` vs threshold → publish on **W** (`generated = 0`); failed commit is a logged state | `D53`, `D172` |
| 9 | Hippocampus | write `(Δ = m⁺ − m⁻, a_{t−1}, r_t)` at `g_t`; an already-predicted step writes null | `D76` |
| 9b | `HC·scaf → CX·g` | reverse read on content, above confidence threshold only → discrete offset-preserving reset of `g`; residual logged as `ρ` | `D64`, `D65`, `D69` |
| 10 | PFC | action = argmax over biased competition → `Act`, `L_cmd(t+1)`, `L_part` | `D25` |
| 11 | all | latch `L_part` (credit path only) | `D44` |

Persists across steps: `PF·lv` task model, store slots, the live commit for its dwell, `g` on **Bg**. Nothing else (spec §4 `D230`).

**Rollout** (internal mode): same loop, α only, `CX·g` advanced by a *proposed* action, commit tagged `generated = 1`, scored by PFC at **every** rollout step as `q(a_t | g_{t−1})`, pragmatic term first then a `U`-gated epistemic term; stops on **commit failure**, no `γ`, must chain `H ≥ 2` epistemic commits. Spec §5.2, §8.

**Offline** (rest): draw from the store by uniform coverage, gate transport by the store's own recall `r_S`, one gradient step on `CX·W`'s associative block, compose two stored transitions sharing an endpoint and write the composed edge, stop per relation when its probe error stops falling. Spec §5.3.

Live-per-mode matrix: `birm-flow.md` §4. Narrated walk-through: `birm-flow.md` §7–§9.

---

## 5. Training

| Stage | Collector | Trains | Frozen | Exit | Detail |
|---|---|---|---|---|---|
| **P0** vocabulary | heterogeneous random play over the family | effect-equivalence codebook `b = round(σ(f_enc(o)))`, `ê = g_dec(b, a_{t−1})`, `L = ‖ê − (o_t − o_{t−1})‖²`; run the `g`-vs-clone-pool race | — | class count plateaus and the race returns a verdict; `Ŝ` read off class count | spec §9, §6 `D71`, §7 `D78` |
| **P1** pre-training | same collector, unchanged | `CX·W` by action-conditioned next-content prediction in representation space, `x` marginal held isotropic-Gaussian; `f_g` | codebook, `HC·scaf`, `f_g`'s form | read-out probe **peak**, not loss convergence, crossed with steps-to-criterion on a fresh instance-graph | spec §9, `D86`, `D87`, `D94` |
| **P2** controller fit | BIRM acting, excitation floor live | `PF·lv` by reward-gated association; `L_cmd` outputs by RL with `δ_j = gate_j·δ` | **all of Cortex** | level-engagement entropies stabilise | spec §9, `D30`, `D168` |
| **P3** deployment | BIRM; dither holds `ρ_tr` above floor | nothing online; `CX·W` on the offline channel only; store one-shot; `f_g` re-fit per env | codebook, scaffold | — | spec §9, `D91`, `D92` |

No behaviour cloning, no plan→policy distillation (`D92`). No per-stage hyperparameter schedule: a stage boundary is a change in which `L_part` gates are open (spec §9 cross-stage table). Logged at every stage: `ρ_tr`, `γ_rep`, `ρ` distribution, CCGP/PS, split-recombine (spec §9, §6 `D18`, `D72`, `D90`).

---

## 6. Open slots that block a build

Only the `?`s an implementer hits on the forward pass. The full list is spec §12; the wiring seams are `birm-flow.md` §6.

| `?` | Where it bites | Spec slot |
|---|---|---|
| Which group `f_g`'s operators act in, per family | `CX·g` | `O3` (`H6`) |
| Lead-time policy for the store read, and its time origin | step 4, `PF·cmd` | `O11`, `O43` |
| Form of 9b's content comparator | `HC·cont → HC·scaf` | `O61` |
| The reset's time constant | step 9b | `O27` |
| `CX·p`: what it computes and where its output goes | inside Cortex | `birm-flow.md` §6 |
| Where `f_g` lives and what writes it | Cortex | `birm-flow.md` §6 |
| Step 3's equation: additive-in-action (§5.1) vs per-action operator (§6) | `CX·g` | `birm-flow.md` §6 |
| Commit reliability `p` vs crossing `p*` for rollout depth | Thalamus | `O44` |
| Coefficient of the eighth Neuromodulator law | Thalamus / NM | `O58` |
| `K` and `c`, the two free scalars | every width | `D85` |

---

## 7. Where to look

| Question | Go to |
|---|---|
| The five-line summary and the symbol table | spec §0.1, §0.4 |
| Each organ's full slot sheet (denials, hazards, contested cells) | spec §3.1–§3.5 |
| Each bus's encoding, rate, falsifier | spec §4 |
| The step, rollout and offline cycle line by line, with costs | spec §5.1–§5.3 |
| Commit discipline: threshold, dwell, failed commit, deferred promotion | spec §5.4 |
| Why `g` and `x` are two things; anti-collapse; effect-equivalence | spec §6 |
| Rebinding actions in a new environment; what survives a body change | spec §7 |
| The epistemic term: which quantity, its weight, its gate | spec §8 |
| The pipeline with hazards and cross-stage answers | spec §9 |
| Acceptance tests, instrument menu, what no test can settle | spec §10, §10.0, §10.5 |
| Why any cell says what it says | spec §11 (`D<n>`) |
| Everything still `?` | spec §12 (`O<n>`) |
| Sub-unit definitions and the full wiring diagram | `birm-flow.md` §1.1, §2.2 |
| Every edge with live-when and denied | `birm-flow.md` §3 |
| What each reader decodes off a shared bus | `birm-flow.md` §2.3 |
| Where the wiring is under-determined | `birm-flow.md` §6 |
| What the built thing must **do** at the boundary, and the cheap tricks it must beat | `birm-behavior.md` §2, §3 |

---

## 8. Changelog

| Wave | Change |
|---|---|
| M1 | First draft. Derived from `birm-spec.md` §0–§9 and `birm-flow.md` §1–§6. No new content. |
