# Output-Null Subspace — Computing Where the Readout Cannot See

**Fix the readout `m = W_out r`. Neuron-space then splits into a *potent* subspace (the row space of `W_out`, dimension ≤ the number of outputs) and a *null* subspace (dimension `N − rank W_out`); activity confined to the null subspace produces exactly zero output no matter how large it is, so a circuit can prepare, hold and compute at full amplitude and emit nothing — with no gate, no timing and no moving parts. Motor cortex is claimed to use this: preparatory activity is not a muted rehearsal of the movement, it is the movement's initial condition arranged perpendicular to everything the muscles can read.**

> **Provenance.** `raw/talk-nd-motor-cortex-dynamics.txt` — an explainer talk transcript, no frontmatter, no authors, no numbers, no paper read. **Everything on this page is (tentative).** The underlying literature (preparatory activity as an initial condition, output-null/output-potent dimensions in premotor and motor cortex) is not in `raw/` and should be acquired before any claim here is load-bearing.

---

## The geometry

| Object | Statement |
|---|---|
| Read-out | `m = W_out r`, `W_out ∈ R^{p×N}` **fixed** (cortex→motoneuron weights; `p` muscles, `N` neurons). Toy case: `m = a r₁ + b r₂ + c r₃` |
| Iso-output set | `{r : W_out r = c}` — an affine subspace of dimension `N − p`. As the commanded output is dialled up the whole subspace **translates**, parallel pages of a book |
| Potent subspace | `row(W_out)`, dimension ≤ `p`; the direction that flips one page to the next |
| Null subspace | `ker(W_out)`, dimension `N − rank W_out`; motion inside a page, invisible downstream |
| Scale of the split | `p ~ tens of muscles`, `N ~ 10³–10⁶ neurons` ⇒ the potent fraction is `p/N`, so the quiet subspace is **essentially the whole space** |
| Movement onset | Not a release event: the instant the autonomous trajectory acquires a non-zero potent component. "Nothing was ever released except the dynamics themselves" |

**The load-bearing inversion:** the usual question is *how is internal activity kept from acting?* The answer here is that it is not kept from anything — the output map is low-rank, and low rank has an enormous kernel that costs nothing to occupy.

---

## Structural silence vs. a downstream gate

Both exist in biology and the source concedes gating mechanisms contribute; the comparison is about what each costs a builder.

| | Downstream gate (inhibitory brake on the pathway) | Null-subspace embedding |
|---|---|---|
| What must be built | A separate device on the right pathway | Nothing — a consequence of `rank W_out < N` |
| Timing | Must be released **in sync** with the dynamics that generate the output | None; silence is a property of *where* the state is, not of *when* |
| Failure mode | Falls out of sync in a noisy system ⇒ leaked or truncated output ("the arm twitching at the thought of reaching") | Any drift of the state into a potent direction leaks **immediately** and by exactly its potent projection — graded, not all-or-none |
| What it costs instead | Control complexity: a second controller with its own credit-assignment problem | A **constraint on the recurrent dynamics**: `f` must keep the preparatory transient inside `ker(W_out)` — the problem is relocated into `W`, not removed |
| Generality | Works for arbitrary activity | Only for activity that can be arranged orthogonally to the read-out; the budget shrinks as `p` grows |

---

## The preparatory fixed point: an input that only sets an initial condition

`ẋ = f(x) + I(t)` — `f` the (fixed, learned) recurrent flow field, `I` everything arriving from elsewhere.

| Phase | State of `I` | Dynamics |
|---|---|---|
| Delay | `I = I_target + I_hold` | The sum flow vanishes where `f(x*) = −I`: an **input-created fixed point**, placed at a movement-specific state inside `ker(W_out)`. Preparatory transient = relaxation to `x*` |
| Go cue | `I → 0` | Nothing balances `f` any more; dynamics are autonomous again and unspool from `x*` |
| Execution | `ẋ = f(x)` | The trajectory swings out of the null subspace; `W_out x(t)` is the muscle command |

| What this buys | Statement |
|---|---|
| **One circuit, every output** | Same `f`, same `W_out`; the movement is selected entirely by *where you start*. Under autonomous first-order dynamics trajectories cannot cross, so the initial condition indexes the whole output |
| **Input is an address, not a steering signal** | `I_target` never has to persist through execution — its only job is to park the state. This is the cheapest conditioning interface in the wiki: `p`-dimensional output selected by one `N`-vector delivered once |
| **Timing is free** | A fixed point holds for an unpredictable delay (experimentally 0.5–2 s, randomised so the animal cannot anticipate). No clock, no countdown, no arrival-timed trajectory |
| **Release is subtraction** | The go cue *removes* input rather than adding drive. The commit is `I = 0` |
| **The hold input is what makes the point a fixed point** | Remove `I_hold` and `x*` is just a point on a trajectory. This is a regime absent from [[wiki/concepts/attractor-dynamics.md]]'s Axis-1 table: fixed points defined neither by content nor by a frozen scaffold but by **cancellation against an input** — created, moved and destroyed at input timescale with no weight change |
| **(brainstorm) the fixed point is also the error correction** | Parking is relaxation into a basin, so noise accumulated during preparation is squeezed out *before* release — which matters because after release nothing corrects the trajectory. Holding is therefore not only about waiting; it buys initial-condition precision, and precision is what an open-loop generator has instead of feedback |

---

## What it settles in the wiki

| Wiki row | Contribution |
|---|---|
| [[wiki/concepts/autonomous-pattern-generation.md]] open problems 2–3 | That page's unanswered question — one reservoir plus one readout is one song, so how do you get `k`? — gets a third answer. **Not** `k` readouts, **not** a conceptor filter in the loop: `k` initial conditions in one unchanged circuit |
| [[wiki/empirical-tensions.md]] T87 (fixed point vs. trajectory) | Supplies Position A's missing *mechanism* and its strongest functional argument — a randomised, unpredictable delay is trivially survivable for a fixed point and requires a read-out clock for a trajectory. It does not settle T87: the same account has the delay ending in a trajectory, so the two are sequential phases here rather than rival designs |
| [[wiki/architectural-gaps.md]] G15 | Not closed, and sharply so: the entire release policy is one exogenous bit (`I_hold` on/off) delivered by the experimenter's go cue. The mechanism makes *how* to release free and says nothing about *when* |
| [[wiki/architectural-gaps.md]] G91 | A commit with no gate to learn. The publication event is geometric — the state entering `row(W_out)` — so the "discrete, dateable, exclusive" property is bought from the read-out's rank rather than from a threshold. The learning-signal half of G91 is untouched |

### Three routes to selecting among stored outputs

| Route | Selector | Cost |
|---|---|---|
| Swap the read-out | `k` readouts, one per pattern | Selection lives outside the network; `k·N` parameters |
| Filter the loop ([[wiki/entities/conceptor.md]]) | PSD matrix `C` inserted into the feedback path | `N×N` per pattern; but composable (`∧ ∨ ¬`), blendable, inferable from a cue |
| **Initial condition** (this page) | A point `x*` in state space, installed by a transient input | One `N`-vector per pattern, no change to `W` or `W_out`, no run-time machinery at all — and no composition operator, no way to blend or negate two starting points that is guaranteed to land on a valid trajectory |

---

## Relevance to a reasoning model

- **"Think without acting" is the recurring requirement**, and the wiki's answers to it are all gates: PBWM's Go/NoGo, basal-ganglia disinhibition ([[wiki/concepts/working-memory.md]]), the workspace threshold ([[wiki/concepts/ignition.md]]). This page is the only alternative in the wiki that needs no controller: make the deliberation orthogonal to the output map.
- **The null-space budget is a design parameter nobody sets deliberately.** `dim ker(W_out) = N − rank W_out`. A narrow read-out buys a large silent workspace; a wide one buys none. **(brainstorm)** An autoregressive language model is the degenerate case — the unembedding is full-rank in `d_model` by construction, so there is **no** null space and every internal state is potent at every step, which is exactly why "thinking" there has to be spent as emitted tokens. The null-space construction predicts a different fix from a scratchpad: give the model a **low-rank output head plus a wide state**, and latent deliberation becomes silent for free, with the commit being the rotation of the state into the potent rows. Untested, and the obvious objection is that a low-rank head caps output entropy at `rank` — the same `p`-vs-`N` trade this page's last table row names.
- **Two cheap, immediately runnable things.**
  1. *Instrument:* for any trained network with a linear read-out, compute the variance of the hidden state in `ker(W_out)` vs `row(W_out)` per phase of a task. The ratio measures whether a model deliberates where its output cannot see it. This costs one SVD and no labels — the kind of structural probe [[wiki/concepts/representation-probing.md]] is otherwise short of.
  2. *Objective:* penalise `‖W_out x_t‖²` during a designated preparation phase. That trains the null-space constraint into the recurrence instead of installing a gate, and it is the trainable version of the row above that says the constraint is really a demand on `f`.
- **Initial-condition control is a compression claim about plans.** If a whole extended output is recoverable from its starting point, then storing a plan costs one state vector and executing it costs no supervision — the *use* half of [[wiki/concepts/latent-graph-discovery.md]] with the schedule removed. The price is that nothing can intervene mid-trajectory, which is where [[wiki/entities/affordance-active-inference-model.md]]'s interruptible generative sequence and this account differ sharply.

---

## Open problems

| # | Problem |
|---|---|
| 1 | **Nothing here produces the null-space constraint.** That preparatory dynamics stay inside `ker(W_out)` is read off data and asserted; no learning rule in the wiki would produce it, and the constraint couples `W` to `W_out`, so the read-out cannot be trained independently of the recurrence |
| 2 | **`I_target` and `I_hold` are exogenous** — the same relocation as the clock in [[wiki/concepts/autonomous-pattern-generation.md]]. Something must compute *which* fixed point and *when* to drop it, and that something is the whole controller |
| 3 | **The "trajectories cannot cross" argument is stated in the full state space** and every measurement of it is a low-dimensional projection, where apparent crossings are expected. The initial-condition claim needs a dimension count that the talk does not give |
| 4 | **Open-loop after release.** Once `I = 0` the trajectory has no correction path; error in `x*` maps to error in the whole output, and no error model is given. This is where the account most obviously needs the feedback it excludes |
| 5 | **The split is a shared resource.** Null-space dimension and output bandwidth sum to `N`; a system that wants richer output has less silent room, and nothing says how to divide it |
| 6 | **Silence at the read-out is not silence downstream** if the downstream target is itself dynamical rather than a static weighted sum. A null direction of `W_out` need not be null for `W_out` composed with a spinal circuit that has its own state |

---

## Connections

- **[[wiki/concepts/attractor-dynamics.md]]** — supplies a fixed-point regime that page's two axes do not cover: a point created by an **external input cancelling the recurrent flow**, so it is placed, held and abolished at input timescale with no plasticity, and its function is not memory but the setting of an initial condition for what follows.
- **[[wiki/concepts/autonomous-pattern-generation.md]]** — the answer to its open problem 2: `k` patterns from one unchanged recurrent net and one unchanged read-out, selected by where the state is parked rather than by `k` read-outs, a clock phase or a conceptor filter — and its "phase-breaking variable" objection does not apply, because the trajectory here is a transient rather than a cycle.
- **[[wiki/concepts/population-geometry.md]]** — the complementary geometric object: that page measures the manifold the *activity* lies on, this one is a subspace of the **read-out**, which is defined without any data at all (an SVD of `W_out`) — so a manifold claim and a null-space claim can be checked against each other, and preparatory activity being high-dimensional in the population is compatible with being zero-dimensional at the muscle.
- **[[wiki/concepts/manifold-constrained-learning.md]]** — the same two-subspace decomposition made experimentally causal, with the read-out owned by the experimenter: a BCI decoder *is* `W_out`, its potent space is the 2-D control space, and the within/outside-manifold split shows that what an animal can learn is set by the intrinsic manifold rather than by the decoder's kernel — the missing test of whether the null space is also a *learnable* workspace.
- **[[wiki/concepts/working-memory.md]]** — the alternative to that page's gates: delay activity that cannot act because of its geometry rather than because a basal-ganglia gate is closed, which removes the synchronisation requirement every gated design there carries, and makes the store's content a *pre-computed initial condition* rather than an item to be read.
- **[[wiki/concepts/structured-flows-on-manifolds.md]]** — the same flow-field ontology at a different level: there the flow's structure comes from symmetry breaking in the coupling, here the flow is taken as given and the question is which of its directions a downstream reader can see, so the two decompose the same `ẋ = f(x)` by generator and by observer respectively.
- **[[wiki/concepts/latent-graph-discovery.md]]** — execution as an initial-condition problem: if a path's whole realisation is recoverable from its starting state, then a plan is stored as one point and run with no scheduler, which is the cheapest possible form of the framing's *navigate* half and also the least interruptible.
- **[[wiki/entities/conceptor.md]]** — the rival selector, and the sharper contrast the wiki now has: a conceptor selects an orbit by inserting an `N×N` filter into the loop and is composable under `∧ ∨ ¬`, while an initial condition selects a transient by placing one `N`-vector and has no algebra — orbit selection at run-time cost versus trajectory selection at zero run-time cost.
