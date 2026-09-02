# BIRM — Behavioural Contract (L1)

**Status: first draft, wave B1. Derived entirely from `_brainstorm/birm-spec.md`; no new reading.** Ten behaviours, three of which have no acceptance test anywhere in a spec carrying thirty-four of them (`Q1`).

> **What this document is.** The layer above the anatomy. It says what BIRM must **do**, observed at the agent boundary with the organs unopened — one row per behaviour, each falsifiable, each naming the cheap trick it must beat. It is the thing §3's organs and §4's buses exist to serve, and the thing they must now be checked against.
>
> **What it is not.** Not a mechanism (that is `birm-spec.md` §3–§7), not a test suite (that is §10 — §10 is this document written backwards, and much of what follows is that inversion), not a wish list (that is `wiki/architectural-gaps.md`).

---

## The tier discipline this document installs

| Tier | Question | Document | Rule |
|---|---|---|---|
| **L0** Task | Which problems, what counts as success, what was hardwired | spec §1, §2.2 | — |
| **L1** Behaviour | What must the agent **do**, organs unopened | **this file** | A row here needs no mechanism to be stated |
| **L2** Bets | What must be represented, at what timescale, kept apart from what — and what the bet **costs** if wrong | spec §6, to be generalised (Phase 2) | Every bet names the `B` it buys and its rent clause |
| **L3** Anatomy | Organs, buses, denials, the step trace | spec §3–§5, §7 | Every row names the `B` or bet it serves, or moves to §14 Unattributed |
| **L4** Implementation | Objectives, learning rules, parameter counts, thresholds, coefficients | spec §8–§9, §12 | **Never blocking. Never drives acquisition.** Closed by building, not by reading |

**The rule that makes the tiers load-bearing:** a tier may only be filled in service of the tier above it. A question that cannot name the `B` it eventually bears on is not a research question — it is a preference.

---

## Editing rules

| Rule | Statement |
|---|---|
| B-R1 | A behaviour is stated at the **agent boundary**: observation stream in, action stream out. If stating it requires naming an organ, it belongs in L2 or L3. |
| B-R2 | Every behaviour names **the cheap trick that fakes it** and how the two are told apart. A behaviour with no impostor is not a behaviour, it is a hope. |
| B-R3 | Every behaviour names its **acceptance number** or writes `?`. Never write a plausible number. (Inherits spec `R3`.) |
| B-R4 | Every behaviour names its **instrument** — the §10 row that could refute it. A behaviour with no instrument is `ASSERTED`, and that is a defect logged in §5, not a state to leave alone. |
| B-R5 | Behaviours are **distinguished from their neighbours** explicitly (`Not this behaviour`). Two behaviours that fail together are one behaviour. |
| B-R6 | This file may be edited without reading a source. It is a re-derivation of commitments already made, and a new behaviour appearing here is a **claim about the spec**, not about the literature. |

---

## 1. The behaviour ledger

| # | Behaviour, in one line | Acceptance number | Instrument | Status |
|---|---|---|---|---|
| **B0** | Beats its own cheap explanations — on the control task *and* on the incongruent half | control at `k ≥ 3`; no level solvable by random play more than 1 in 10,000; above null on **both** subsets | `T19`, `T20` | `CONTRACTED` |
| **B1** | Acquires the meta-graph: cost scales with **nodes visited**, not edges taken | `θ` = `?`; reference point 18 steps inferring 42 links | `T17` (+`T1`, `T24`) | `CONTRACTED-NO-THRESHOLD` |
| **B2** | Rebinds the action vocabulary without relearning the structure | ≤ 8 trials/cue to <10% error at `k = 3`; structure reuse ~3.3× (147±39 vs 483±70) | `T16` | `CONTRACTED` |
| **B3** | Re-goals without relearning the transitions | "materially below a matched-parameter baseline" = `?` | `T2` | `CONTRACTED-NO-NUMBER` |
| **B4** | Improves without new experience, and **stops** | `?` per-relation ration; `?` gain | **none** for (i)–(ii); `T23` half-covers (iii) | `ASSERTED` (`Q1`) |
| **B5** | Acts to find out, and chains at least two such acts before a pragmatic one | `H ≥ 2` probes; `γ`-signature `+7.8 / +1.0 / −1.6 pp` | `T21`, `T22` | `CONTRACTED` |
| **B6** | Declines when unresolved — abstention is an expressible outcome | `?` | **none** | `ASSERTED` (`Q1`) |
| **B7** | Degrades by **resolution**, not by identity, as instances accumulate | `?` | **none** (`T3` probes contents, never sweeps load) | `ASSERTED` (`Q1`) |
| **B8** | Never stops exploring — action-conditional variance has a floor it does not switch off | floor on `ρ_tr` = `?` | `T26` (reports it; nothing enforces it) | `CONTRACTED-NO-NUMBER` |
| **B9** | Its published rollout predicts its own trajectory | alignment ≥ the 93–98% analogue | `T29` | `CONTRACTED` (caveat `O37`) |

**Ten behaviours, no eleventh.** Two candidates were considered and refused as L1: *"operates at a per-component working point rather than a maximum"* (spec `D37`, `T7`) is the **rent clause of the metaparameter bet**, not a behaviour — it goes to L2; and *"can exhibit rumination"* (`D62`) is a property of the design space, not a required behaviour — it is a denial, `N6`.

---

## 2. The sheets

### B0 — Beats its own cheap explanations

| Field | Fill |
|---|---|
| Situation | Every evaluation round, without exception |
| Required behaviour | The family score **exceeds** the arbitrary-sensorimotor-mapping control at `k ≥ 3`, **and** sits above the null on the congruent and incongruent subsets **separately** |
| Boundary observable | Two scores and a partition; no internal access needed |
| Acceptance number | `k ≥ 3` (at `k = 2`, Repeat-Stay/Change-Shift is a *complete* solution worth 33% error at `k=3` and 0% at `k=2`); random-policy `P_win` ≤ 1/10,000 per level |
| The cheap trick | **Binding speed masquerading as reasoning**, and **a marginal statistic carrying the aggregate**. The second is measured, not hypothetical: 0.68 congruent against 0.53 (chance) incongruent under an overall 0.64 |
| Failure signature | An aggregate that moves while the incongruent subset does not |
| Not this behaviour | B0 is a **floor**, not a capability. Passing it certifies nothing except that B1–B9 are worth reading |
| Serves / served by | spec §1 `S5`, `D79`; §10.3 `T19`, `T20` |
| Known non-coverage | `T20`'s partition needs the intended structure known in advance — exactly what identifiability denies in general (`G16`). Available only because the benchmark author holds the graph |

### B1 — Acquires the meta-graph

| Field | Fill |
|---|---|
| Situation | Dropped into a held-out instance-graph of a **seen** environment family |
| Required behaviour | Reaches skill threshold `θ` in fewer environment steps than a matched-parameter flat baseline, **and** the advantage survives replotting against *nodes visited* rather than *edges taken* |
| Boundary observable | Two learning curves over the benchmark's own directed state graph (nodes hash-identified so trajectories merge) |
| Acceptance number | `θ` = `?`. Reference point, not a threshold: **18 steps inferring 42 links** |
| The cheap trick | **Practice.** Dense sampling reaches threshold without discovering anything — blocked by `S1` (sweep the budget, don't just report it), `S2` (no generator-backed evaluation sets), `S3` (consumable evaluation set with a read counter) |
| Second cheap trick | **Retrieval mistaken for learning.** A curve cannot separate a learner from a retriever; `T24`'s evoker control bounds the confusion and does not remove it |
| Failure signature | The `V`-curve and the `E`-curve are parallel; or the same gap appears in the flat baseline |
| Not this behaviour | Not B3 — B1 holds the reward semantics and moves the graph; B3 holds the graph and moves the reward |
| Serves / served by | spec §1 `D5`; §6 in full; §3.1 `D22`; §10.3 `T17`, §10.1 `T1`, `T24` |
| Known non-coverage | A family whose graph is dense enough that `V` and `E` scale together. And `L2`/`F5`: BIRM is scored on discovery over a vertex set the adapter fixed (`H3`), so what fraction of the graph the adapter already supplied is unmeasured (`O2`) |

### B2 — Rebinds the action vocabulary without relearning the structure

| Field | Fill |
|---|---|
| Situation | The adapter's index→primitive map is permuted between episodes, without notice, family held fixed |
| Required behaviour | Re-binding completes inside the budget **and the structural code survives the permutation** — the meta-graph is not retrained, only the action→operator generator is re-fitted |
| Boundary observable | Trials-to-criterion after the permutation, against trials-to-criterion for the original acquisition |
| Acceptance number | **≤ 8 trials/cue to <10% error at `k = 3`**; ~3 trials/cue to substantial learning; 24 new mappings/day sustained. Structure-reuse arm: **147 ± 39 trials against 483 ± 70**, a ~3.3× speedup |
| The cheap trick | A `k` small enough that random re-binding meets the budget by luck. Barred by `k ≥ 3` and by reporting the random-policy floor |
| Failure signature | Re-binding cost that scales with the size of the graph rather than with the number of cues |
| Not this behaviour | Not B3. B2 changes what the *action symbols mean*; B3 changes what the *reward marks*. Both preserve the transitions, and they are separable: B2 can be passed by a system that must re-solve the goal, and B3 by one that cannot survive a permutation |
| Serves / served by | spec §7 in full, `D77`, `D102`, `D103`, `D79`; §10.2 `T16` |
| Known non-coverage | What *licenses* a particular binding is unsolved and BIRM inherits it (`O30`) — reinforcement is too slow and too coarse for 3 trials/cue. And the curriculum precondition: cue–choice contiguity decides which mechanism runs at all, so a family that leaves it uncontrolled does not know what it is scoring |

### B3 — Re-goals without relearning the transitions

| Field | Fill |
|---|---|
| Situation | Family's transition structure held fixed; what `r_t` marks is moved |
| Required behaviour | Environment steps to threshold `θ` after the move is materially below the same measurement on a matched-parameter flat baseline |
| Boundary observable | Retraining curve after the goal switch |
| Acceptance number | `?` — "materially below" has no coefficient. **Named as an L1 hole, not an L4 one:** the number decides whether the behaviour was demonstrated |
| The cheap trick | **Multi-task training over reward placements.** `C4`: a BIRM trained across many reward placements passes without any of it flowing through one model, and §10 has **no row that closes this** (`L7`) |
| Failure signature | Retraining cost that tracks graph size rather than goal distance |
| Not this behaviour | Not B1 (graph moves, goal fixed), not B2 (symbols move, goal fixed) |
| Serves / served by | spec §10.1 `T2` (`I4` re-goaling); §3.1's rollout-throughput claim `D89` |
| Known non-coverage | `L7` in full. This is the behaviour most exposed to the one-model question, and the spec explicitly does not claim to close it |

### B4 — Improves without new experience, and stops

| Field | Fill |
|---|---|
| Situation | A rest period between episodes. No environment steps are taken |
| Required behaviour | Three clauses. (i) Held-out probe performance for a relation **rises** across the period. (ii) The rise **stops** at that relation's own ration, and further consolidation does not degrade it. (iii) Edges the agent **never traversed** become traversable, by composition of two stored transitions sharing an endpoint |
| Boundary observable | Probe score before and after a rest period with the step counter frozen; and a traversal test restricted to composed edges |
| Acceptance number | `?` on all three clauses — the per-relation ration, the size of the gain, and the composition acceptance rate |
| The cheap trick | **Smuggled experience.** Any consolidation measurement that lets the environment step counter advance is measuring B1 |
| Second cheap trick | **A shortcut that recurs stably.** Recall gating is a reliability filter, not a causality filter, and passes a stable shortcut exactly as easily as structure. Stated openly in §5.3 and unaddressed |
| Failure signature | Monotone improvement that never stops — transport past a finite point *raises* generalization error, and for a relation the model cannot represent the optimal transport is **zero**, so a scheduler that always consolidates is wrong by construction |
| Not this behaviour | Not B1. B1 spends environment steps; B4 spends none, and the two are separable by the step counter alone |
| Serves / served by | spec §5.3 in full, `D57`, `D58`, `D24`, `D60`; §3.1's transport channel `D23` |
| **Instrument** | **None for clauses (i) and (ii)** — §10 has thirty-four rows and not one of them runs a rest period; `T1` touches transport only through the reversed freeze. **Clause (iii) is half-covered**: `T23`'s primitive-only control run disables composed edges and reads the return gap, which scores what composition is *worth* in deployment and never whether a rest period produced it. Logged as `Q1` |
| Known non-coverage | The two consolidation gates are composed in series and have never been swept together (`O53`), and the recall gate's sign has never been reversed (`O54`) — both are L4 slots sitting under a behaviour that has no L1 instrument, which is the wrong order |

### B5 — Acts to find out, and chains it

| Field | Fill |
|---|---|
| Situation | A goal that cannot be reached without information the current observation does not carry, requiring `n` probes chained before a commit |
| Required behaviour | Two clauses. (i) BIRM emits **`H ≥ 2` information-gathering commits before a pragmatic one**. (ii) The quantity driving them **cannot be driven to zero by freezing the policy** |
| Boundary observable | The action stream, classified against the level's state graph into probes and pragmatic acts; and the epistemic term under a frozen policy |
| Acceptance number | `H ≥ 2` in probes. `γ`-sweep signature on a multi-observation family: **+7.8 pp at `γ = 1.0`, +1.0 at 0.95, −1.6 at 0.90**, and **flat** on a single-probe family |
| The cheap trick | **A self-consistency penalty wearing the name "epistemic value."** It fails measurably: action-prior entropy → 0, the action histogram almost entirely one action, the variance head low only for that action |
| Second cheap trick | A decayed `ε` or an external schedule. Excluded by construction — the term is computed inside the selector from a quantity the agent already holds |
| Failure signature | Sensitivity to `γ` on the **single**-probe family. That means the estimation discount leaked into the rollout scorer; there is no second reading of it |
| Not this behaviour | Not B8. B5 is *directed* information-seeking scored inside the selector; B8 is an undirected variance floor held by the metaparameter layer, paid for in return on purpose. They are separable: an agent can pass B8 by dithering and still never chain two probes |
| Serves / served by | spec §8 in full, `D95`–`D98`, `D107`–`D109`; §5.2 `D108`; §10.3 `T21`, `T22` |
| Known non-coverage | All five measured estimators in the source literature are horizon-1, which is independently where the objective degenerates to myopic information gain — so `T22`'s confound is real and `H ≥ 2` is the standing repair rather than an independent check. And BIRM's own per-step commit reliability against the crossing point is unmeasured (`O44`) |

### B6 — Declines when unresolved

| Field | Fill |
|---|---|
| Situation | No candidate recruits enough support to publish |
| Required behaviour | Abstention is an **expressible, logged outcome**, distinct from three neighbours: a completed commit, a blend of two task models, and chance-level output |
| Boundary observable | An action stream containing a distinguishable null; and, under a two-rule manipulation, behaviour consistent with **neither** rule rather than with the older one |
| Acceptance number | `?` |
| The cheap trick | **Chance.** A collapse to uniform is not abstention, and a system whose competitive dynamics fall to a default winner under any perturbation mimics the pass |
| Failure signature | A blend that is scored as forgetting, or a decline that is indistinguishable from noise |
| Not this behaviour | Not B5. B5 acts to *remove* uncertainty; B6 is what happens when it has not been removed and the step must still end |
| Serves / served by | spec §5.4 (sub-threshold case), `D53`, `D56`; §5.2 (commit failure as the rollout's stopping rule, and as its overgeneration pruner); §3.3's blend hazard |
| **Instrument** | **None as a behaviour.** `T5` reads the action stream under a `C` lesion and is an organ test; nothing scores abstention on an intact system. Logged as `Q1`. This matters more than it looks: **commit failure is load-bearing three times over** — it stops the rollout (§5.2), it prunes overgeneration (§5.3), and it sets rollout depth (`D109`) — so an unmeasured B6 leaves B4 and B5 resting on an untested outcome |
| Known non-coverage | The system hallucinates by the mechanism it perceives by: a spontaneous supra-threshold cascade is indistinguishable downstream from a driven one. Stated openly and not repaired |

### B7 — Degrades by resolution, not by identity

| Field | Fill |
|---|---|
| Situation | Instances accumulate within one episode until the fast store is past comfortable occupancy |
| Required behaviour | Errors become **confusions between similar addresses**; no item is lost wholesale, nothing is evicted by capacity, nothing decays |
| Boundary observable | Error *type* against load: a confusion matrix that thickens near the diagonal versus one that develops holes |
| Acceptance number | `?` |
| The cheap trick | Reporting aggregate accuracy under load, which cannot distinguish the two failure shapes |
| Failure signature | Holes rather than blur — an item that was retrievable at load `n` and is absent at load `n+1` |
| Not this behaviour | Not B1. B7 is a within-episode load property; B1 is across-instance transfer |
| Serves / served by | spec §3.2 (attractor regime, removal discipline, read tolerance `D74`), `D32`, `D33`, `D73`; §3.2's own hazard — enlarging `S` need not raise capacity if the bound is in the selection |
| **Instrument** | **None.** `T3` probes occupancy and retrieval fidelity at a supplied address and sweeps the lead time; it never sweeps **load**. Logged as `Q1` |
| Known non-coverage | `S` cannot hold two things at one address (`O60`), and the frozen allocation density has never been swept under a non-stationary family (`O51`) — again two L4 slots beneath a behaviour with no L1 instrument |

### B8 — Never stops exploring

| Field | Fill |
|---|---|
| Situation | Deployment, after the random-play collector is retired |
| Required behaviour | The conditional action variance `ρ_tr = λ_min(E_g[Cov(a\|g)])` stays **above a floor**, and BIRM pays return for it on purpose |
| Boundary observable | Computed from BIRM's own action log **with no model** — the cheapest instrument in the document |
| Acceptance number | Floor value = `?`. What it protects is exact: counterfactual error is `δ/ρ_tr` |
| The cheap trick | **Reporting on-policy prediction error**, which is the only number anyone reports and is blind to this. Every mechanism for improving an actor drives `ρ_tr → 0` while on-policy loss falls throughout |
| Failure signature | A falling loss curve and a collapsing action covariance in the same run. That pair is the signature, and neither half alone is |
| Not this behaviour | Not B5 — see B5's `Not this behaviour`. B8 is a *precondition* for B1 and B3 remaining measurable, not a capability of its own |
| Serves / served by | spec §9 (P0 heterogeneity, P3 dither), `D90`, `D91`, `D92`; §10.3 `T26` |
| Known non-coverage | `T26` **reports** both margins and nothing enforces the floor; a negative margin does not license "this cannot be learned", since identification error changes smoothly through `γ_rep = 0`. So B8 is a certificate attached to other behaviours' numbers, and its own pass condition is unwritten |

### B9 — Its rollout predicts its own trajectory

| Field | Fill |
|---|---|
| Situation | Any step at which a rollout is published before acting |
| Required behaviour | The realised trajectory follows the committed rollout often enough that the rollout is a usable proxy for the executed computation |
| Boundary observable | Committed rollout versus realised path, both logged; classification of the rollout against the level's state graph as **intended** / **unintended-but-successful** / **wrong** |
| Acceptance number | The language-modality analogue reports **93–98%** and is admissible on that basis |
| The cheap trick | Scoring alignment on a system whose rollouts are post-hoc — i.e. published after the action rather than before it. Excluded by the commit ordering, and worth stating because nothing else excludes it |
| Failure signature | Two, and they distort in opposite directions: a high unintended-successful share means the score **overstates** structure; intended-rollout-with-failed-execution means it **understates** it |
| Not this behaviour | Not a capability at all — B9 is the **readability precondition** for reading B1, B3 and B5 off a trajectory. It is listed as a behaviour because it is boundary-observable and it can fail |
| Serves / served by | spec §5.2, `D123`; §10.3 `T29`; §10.0 (`I15` substitute — BIRM cannot state a rule, natural language being outside the stream contract) |
| Known non-coverage | BIRM's classifier is unvalidated: `D123` substitutes the level's state graph for the human rater the instrument was built around, and the original has no algorithmic form (`O37`). Available only where the graph is enumerable |

---

## 3. Behavioural denials — what BIRM must **not** do

The L1 counterpart of §3's and §4's `Architecturally denied` columns. Each is boundary-observable and each is violated by a system that would otherwise score well.

| # | Denial | Detected by | Why the denial exists |
|---|---|---|---|
| **N1** | Must not reach the family score at the control task's rate | `T19` | A reasoning score that does not exceed the arbitrary-mapping control measured **binding speed** |
| **N2** | Must not carry its aggregate on the congruent subset | `T20` | Measured: 0.68 / 0.53 under an overall 0.64 |
| **N3** | Must not converge to a deterministic policy | B8's action-log statistic | It destroys the identifiability of the model it plans with, silently |
| **N4** | Must not be able to zero its epistemic term by freezing its policy | `T22` | The impostor term collapses the policy, and the implementation is **discarded, not tuned** |
| **N5** | Must not jump on a single evoker trial | `T24` | A jump larger and more persistent than a one-trial update is *apparent* learning: the stored states did not change, only the weights over them |
| **N6** | Must not be **unable** to ruminate | design-space check, `D62` | Never-on and always-on are two settings of one gain. An implementation that cannot exhibit the pathological setting does not have the gain |
| **N7** | Must not change its behaviour under an observation perturbation correlated with content but not with structure | `T9` | The structural code is denied the observation bus; if behaviour moves, the denial is not implemented |
| **N8** | Must not be scored by a prediction loss on its own converged policy's data | spec §3.1 (iv), §9 `D92` | Every mechanism for improving an actor makes this number fall while the thing it claims to measure degrades |
| **N9** | Must not be asked to state a rule | scope, `D8`, `D83`, `D126` | Natural language is outside the stream contract. `B9` is the substitute, and it is weaker |

---

## 4. Coverage map — L1 against the spec

Provisional. The authoritative version is the `Serves` column Phase 3 adds to spec §3, §4, §11 and §12; this table is what the inversion looks like from above.

| Behaviour | Spec sections that exist to serve it | L2 bet it will rest on (Phase 2) |
|---|---|---|
| B0 | §1 `S1`–`S5` | — (a scoring discipline, not a bet) |
| B1 | §6, §3.1, §3.2, §5.1, §9 P0–P1 | the `g`/`x` factorization; two stores at two timescales |
| B2 | §7, §3.2 | two stores at two timescales |
| B3 | §3.1, §3.3 | bias-into-a-competition |
| B4 | §5.3, §3.1 | two stores at two timescales |
| B5 | §8, §5.2, §3.5 | second-order metaparameters; exclusive publication |
| B6 | §5.4, §5.2, §3.4 | exclusive publication with a dwell time |
| B7 | §3.2, §6 | the `g`/`x` factorization (address vs. content) |
| B8 | §9, §3.5 | second-order metaparameters |
| B9 | §5.2, §5.4 | exclusive publication with a dwell time |

**Sections not yet attributed to any behaviour** — candidates for spec §14, to be settled in Phase 3, not here: §3.5's `γ` law and its horizon coupling, §4.1's operating-point register, §7's abstraction-layer rate-multiplier row, and the parts of §3.3's three-axis factorization that no behaviour above distinguishes. Listing them is not a proposal to delete them; `R2` holds.

---

## 5. Open behavioural questions

L1-tier only. An L4 slot may not appear here, however unresolved — the sixty-one rows of spec §12 are unaffected by this list and are not promoted onto it.

| # | Question | Why it is L1 | Cheapest way to close |
|---|---|---|---|
| **Q1** | **Three behaviours have no instrument.** B4 (improves without new experience — `T23` half-covers its composition clause and nothing scores the rest period itself), B6 (declines when unresolved) and B7 (degrades by resolution) are asserted across four spec subsections and go essentially unscored by §10's thirty-four rows | A behaviour with no instrument cannot be claimed, and two of the three carry load elsewhere: commit failure is B6's outcome and is simultaneously the rollout's stopping rule, the offline pruner, and the setter of rollout depth | Write three §10 rows. All three are cheap and need no new source: a rest period with the step counter frozen; an abstention rate on an intact system under a two-rule manipulation; an error-**type** sweep against store load |
| **Q2** | **The asymmetry the coverage map exposes.** §10's rows cluster on B0, B1 and the hygiene of their scores — `T17`–`T20` and `T24`–`T34` are almost entirely about whether a *meta-graph* claim is readable — while three behaviours have essentially nothing. The exact split is Phase 3's to compute; the imbalance does not depend on the exact split | Instrument effort followed what the sources discussed, not what the agent must exhibit | Q1's three rows, then tally `T1`–`T34` against B0–B9 properly |
| **Q3** | **B3's "materially below" has no coefficient, and it is the number the behaviour is made of** | Unlike an L4 threshold, this one decides whether the behaviour was demonstrated at all | It cannot be read off a source; set it from the flat baseline's own variance on the same family |
| **Q4** | **Nothing certifies that B1, B3 and B5 come from one model** (`L7`, `C4`) | It is the question the whole document is for: ten behaviours from ten mechanisms is not BIRM | §10 has no row and the spec does not claim one. Standing. The honest response is to report it, not to close it |
| **Q5** | **B8 is a precondition dressed as a behaviour, and its floor is unwritten** | If the floor is unset, B1's and B3's numbers are uninterpretable rather than merely unbounded | The floor is a property of the collector, not of the architecture — measurable in P0 before any training |

**What this list is not.** It is not the research queue's replacement yet; that arrives when Phase 3 tags the 107 gaps and 284 tensions against these rows. What it already establishes is the queue's **size**: five open questions at L1, three of which are closed by writing test rows rather than by reading anything.

---

## 6. Changelog

| Date | Wave | Change |
|---|---|---|
| 2026-09-02 | B1 | Document created. Ten behaviours lifted from spec §1, §5, §7, §8 and §10.3 by inversion; nine denials from §3/§4/§9; the tier discipline stated; five L1 questions opened, `Q1` being the finding that three behaviours are unscored. No new reading; no spec row superseded. |
