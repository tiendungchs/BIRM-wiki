# Spike-Train Error Metrics

**The loss function for a temporally coded output: given a desired spike train `y^ref` and an emitted one `y`, what scalar measures the discrepancy, and what weight update does its gradient give?** This is the question logically *prior* to credit assignment in a spiking network — before an error can be propagated it has to exist — and it is [[wiki/architectural-gaps.md]] `G76`. The page's spine is Gardner & Grüning 2016 (`raw/gardner-2016-snn-precise-temporal-encoding.md`, PLoS ONE 11(8):e0161335), the one source in the wiki that *derives* such a rule rather than positing it, and measures what the choice of error is worth in stored patterns per synapse.

---

## The derivation, in five steps

The whole family of spike-based supervised rules is one chain with a choice at the last link.

| Step | Statement |
|---|---|
| 1. Neuron | Simplified Spike Response Model `SRM₀`: `u_i(t) = Σ_j w_ij Σ_{t_j ∈ x_j} ε(t − t_j) + Σ_{t_i ∈ y_i} κ(t − t_i)` — a **linear** sum of postsynaptic potentials plus a reset kernel |
| 2. Make firing stochastic | Escape rate `ρ_i = g(u_i) = ρ_0 exp[(u_i − ϑ)/Δu]`. Because `SRM₀` is linear and `g` exponential, the log-likelihood of emitting a **specified** train is **concave in `w`** — no non-global maxima (Pfister et al. 2006) |
| 3. Ascend it | `Δw_ij ∝ η ∫ dt [Y_i^ref(t) − ρ_i(t)] · (1/Δu) Σ_{t_j} ε(t − t_j)` — a **two-factor** rule: a postsynaptic error term × a presynaptic eligibility term |
| 4. Unclamp | Replace `ρ_i(t\|x, y^ref)` with `ρ_i(t\|x, y)`: the rate depends on the neuron's **own** emitted spikes, not on the target it is being clamped to. An approximation, convergent for small timing displacements and finite `Δu` |
| 5. Take `Δu → 0` | The stochastic intensity collapses onto the actual output train, `ρ_i(t) → Y_i(t) = Σ δ(t − t_i)`, recovering a deterministic LIF neuron and hence a *precisely timed* output |

The result, with the learning rate renormalised `η ← η/Δu`:

```
INST:  Δw_ij = η ∫₀^T dt [ Y_i^ref(t) − Y_i(t) ] · Σ_{t_j} ε(t − t_j)
FILT:  Δw_ij = η ∫₀^T dt [ Ỹ_i^ref(t) − Ỹ_i(t) ] · Σ_{t_j} λ(t − t_j),   Ỹ = Y ⊛ e^{−s/τ_q}
```

`λ` is the learning window that falls out of convolving the postsynaptic-potential kernel `ε` with the exponential filter; `τ_q = 10 ms ≈ τ_m`. The two rules differ **only** in whether the postsynaptic error is instantaneous or exponentially smoothed. Everything else — including the presynaptic factor — is identical.

**The presynaptic factor is derived, not chosen.** Both rules inherit the postsynaptic potential `ε` as the eligibility term, because that is what step 3 produces. SPAN and PSD instead use the postsynaptic *current* `α`, which the derivation gives no warrant for; the SPAN authors report empirically that an α-shaped kernel works best, and that shape closely resembles a PSP curve. So a free design choice in the heuristic rules is fixed by the derivation, and the fix agrees with the grid search.

---

## What filtering the error buys, and why

The mechanism is not smoothing-as-regularisation. It **moves the attractor of the learning dynamics onto the solution**. Single synapse, one input spike at `t = 0`, one target output spike, weight `w` plotted against `Δw`:

| Rule | Fixed points | Consequence |
|---|---|---|
| **INST** | Attractor at `w/ϑ = 1` — the threshold-crossing point, i.e. *the peak of the PSP*, **independent of the target time** — reached through a discontinuity in `Δw`; plus a repeller at the true solution `w*` | The neuron is switched on and off as `w` fluctuates about `ϑ`. Post-training spikes fluctuate around the PSP peak, not around the target. Learning is repelled from `w*` and diverges for large initial `w` |
| **FILT** | `Δw` stays **positive** until `w*` is reached, so the attractor *is* `w*` and it is stable; the repeller moves out beyond it | Smooth convergence for sufficiently small initial `w` |

This is the sharpest available statement of why the instantaneous error fails: not "it is noisy" but "its stable point is a property of the membrane filter and carries no information about the target".

**The learning windows differ correspondingly.** INST's `Δw` against `t^ref − t^pre` is just the PSP kernel: strictly causal (zero for negative lags), peaking just under 7 ms. FILT's is roughly **symmetric** about a peak near 3 ms, and non-zero for post-before-pre — because it minimises a *smoothed* difference, a near-match counts.

**The filter constant sets a precision floor.** There is a minimum learnable target latency `t̃_min` at which `w*` flips from stable to unstable, and `τ_q ∈ [0, ∞)` maps to `t̃_min ∈ [s_peak, 0)`. At `τ_q = 0` the rule *is* INST and `t̃_min = s_peak ≈ 7 ms`; at `τ_q = 10 ms`, `t̃_min ≈ 3 ms`. Longer filtering buys finer timing — the opposite of the intuition that smoothing costs resolution.

---

## The measured price of the error definition

One postsynaptic neuron, `n_i` presynaptic neurons firing one spike each over `T = 200 ms`, patterns hetero-associated to five classes identified by target output spike timings; a classification counts if the neuron fires the right number of spikes each within `Δt` of target. Capacity `α_m := p_m/n_i` at the 90%-correct cut-off within 500 epochs. Benchmark `CHRON` = the E-learning Chronotron (Victor–Purpura distance).

| Quantity | INST (instantaneous) | FILT (van Rossum-like) | CHRON (Victor–Purpura) |
|---|---|---|---|
| Capacity `α_m` at `Δt = 1 ms` | 0.07 ± 0.01 | **0.14 ± 0.01** | 0.15 ± 0.01 |
| Capacity at `Δt = 0.2 ms` | **0** (nothing memorisable below `Δt = 0.8 ms`) | ≈ 0.07 | ≈ 0.07 |
| Max target spikes per pattern above 90% | 1 | 3 | 4 |
| Epochs to criterion | 3–4× slower than the others | fast | fast |
| Final van Rossum distance, single 4-spike mapping | 0.2 ± 0.2 (≈1 ms residual error, never reaches 0) | → 0 | — |
| Weight solution | peak weights >3× FILT's; the **only** rule producing negative weights | smooth, periodic in input-spike order | — |
| Implementable online | yes | **yes** | **no** — the VPD cost is non-local in time |

Read across the table: **the choice of spike-train error is worth a factor of two in patterns per synapse, and it is the entire difference between sub-millisecond coding being possible and being impossible.** Capacity saturates for `Δt > 3 ms` — beyond that, precision is free and the error metric stops mattering.

Three secondary results that constrain implementations:
- All three rules share the same optimal learning rate and the same scaling `η = 600/(n_i n_s p)` — inversely proportional to presynaptic count, target-spike count and pattern count. The learning rate is not a per-rule hyperparameter.
- The learned weight profile, sorted by presynaptic firing time, is a **ramp before each target spike followed by a fall** — the network solves the task by building a coincidence in the arrival-time histogram, which is [[wiki/concepts/temporal-coding.md]]'s mechanism arrived at by gradient rather than by delay selection.
- INST's negative weights sit immediately *after* the target times: it is cancelling its own over-drive, the signature of the unstable attractor above.

---

## The full inventory of proposals

Consolidated here; the survey provenance and per-model detail are on [[wiki/entities/spiking-neural-networks.md]].

| Metric | Quantity minimised | Class | Ceiling |
|---|---|---|---|
| **Output-timing error** (SpikeProp) | `t^ref − t^actual` | timing, direct | Exactly one output spike per unit |
| **Victor–Purpura distance** (Chronotron E-learning) | Minimum cost of create / remove / **move** operations | edit distance on trains | Offline only; the three costs are unspecified for any task; single neuron |
| **Alpha-kernel regression** (SPAN) | Squared error after convolving with `t·e^{−t/τ}` | smoothed | Kernel chosen by grid search; single neuron |
| **Widrow–Hoff on trains** (ReSuMe, PSD) | `x·(y^ref − y)` ≡ STDP against teacher + anti-STDP against output | instantaneous | Teacher train available without a physical connection |
| **INST** (Gardner & Grüning) | Momentary spike-count difference | instantaneous, **derived** | Attractor independent of the target; capacity 0 below 0.8 ms |
| **FILT** (Gardner & Grüning) | van Rossum distance `∫(Ỹ^ref − Ỹ)² dt` | smoothed, **derived** | Precision floor set by `τ_q`; single neuron |
| **Finite Precision** (the FP algorithm, cited by the source) | First erroneous spike only, PSP eligibility | instantaneous, truncated | Discards all later errors by construction, to avoid nonlinear error accumulation through the reset |
| **Narrow-support gate** (Huh & Sejnowski 2018) | Any loss — threshold replaced by `g(v) ≥ 0`, `∫g dv = 1` | substrate change, not a metric | The only entry freeing the *number* of output spikes |

**The classification that matters is not smoothed vs. combinatorial.** It is whether the error signal at time `t` knows about spikes at other times. INST and ReSuMe do not, and both are unstable near threshold; FILT and CHRON do — one by convolution, one by an explicit spike-pairing step — and they perform the same. That is the design rule the whole table reduces to.

---

## Why this matters for a reasoning model

- **It supplies the missing output side of every timing-coded architecture in the wiki.** [[wiki/entities/spiking-tem.md]], [[wiki/concepts/temporal-coding.md]] and [[wiki/entities/spiking-neural-networks.md]] all read timing; none of them could previously be *trained* toward a timing target with a rule whose convergence was analysable. FILT is that rule, and it is online.
- **Capacity per synapse is now a comparable number.** `α_m ≈ 0.14` at 1 ms against the perceptron's `α ≈ 2` for binary patterns: a precisely timed spike is a far more expensive thing to store than a bit. Any architecture proposing to hold a latent graph in output spike times inherits this exchange rate.
- **The two-factor form is the same object as three-factor plasticity with the modulator replaced by a target** ([[wiki/concepts/synaptic-plasticity.md]]). The presynaptic eligibility term is literally the PSP; the second factor is a target-minus-actual signal that in a reinforcement setting would be a scalar reward. The derivation therefore tells the wiki what an eligibility trace *should* be, rather than leaving it a fitted kernel.
- **(brainstorm) `τ_q ≈ τ_m` is not a coincidence and may remove the filter.** The optimal error-filter constant equals the membrane constant, and the authors' own reading is that the exponential filtering could be carried out by the membrane potential's own response to postsynaptic spikes. If so, the smoothing is free — the neuron already computes it — and the "biologically implausible instantaneous weight change" objection to INST is answered by hardware rather than by an extra state variable. Nothing in the wiki has tested whether the membrane's afterpotential can serve as the error filter directly.

---

## Open problems

- ~~**Still one postsynaptic neuron.**~~ **Solved, by a source that supplies no metric.** Every rule in *this* inventory, derived or heuristic, trains a single output neuron from many inputs. Deep credit assignment in the timing domain now exists — EventProp's adjoint backward pass gives exact gradients through hidden layers, recurrent connections and multiple spikes per neuron ([[wiki/concepts/learnable-synaptic-delays.md]]) — but every non-toy task it has been run on uses a first-spike latency or a max-membrane-voltage objective, not a distance between trains. **The machinery to backpropagate FILT or a Victor–Purpura cost through depth is available and unused**, and that composition is now the whole of `G76`.
- **`τ_q` is set by parameter sweep.** It fixes the achievable precision floor and is chosen offline; this is the same defect as [[wiki/architectural-gaps.md]] `G78` (nothing sets a slow variable's time constant) in a second place.
- **The reset nonlinearity is dodged, not handled.** Target spikes are kept ≥10 ms apart and the FP algorithm keeps only the first error, both to prevent errors accumulating nonlinearly through the reset kernel. No rule handles densely packed output spikes.
- **Classification by exact timing, not by distance.** Patterns are called correct when a spike lands within `Δt` of target. Classifying by *minimum distance* between candidate trains would be noise-robust and is not evaluated here — so all reported capacities are lower bounds under an unnecessarily brittle decision rule.
- **The input code is one spike per afferent.** Chosen for analytic tractability; nothing says the capacity numbers survive multi-spike inputs.
- **No statement of what the target train should be.** Every result presupposes a teacher specifying exact output times. Where a target spike train comes from, for a task that is not hetero-association, is unaddressed by the entire family.

---

## Connections

- **[[wiki/entities/spiking-neural-networks.md]]** — the substrate this page supplies the loss for, and the page that holds the six-proposal survey this one consolidates and extends: the entity page asks "what is the error between two spike trains?" and answers with a table of posits, while this page gives the one derivation the family has and prices the choice at 2× capacity per synapse.
- **[[wiki/concepts/temporal-coding.md]]** — the page whose central objection this source contradicts: it argues that any rule smoothing a spike train into a continuous function measures a *rate-like* discrepancy and inherits rate coding's blindness, but the smoothed van Rossum error here reaches 0.2 ms precision and matches the combinatorial Victor–Purpura metric exactly ([[wiki/empirical-tensions.md]] T236). It also supplies this page's mechanism from the other side: the learned weight profile is a ramp before each target time, i.e. gradient descent rediscovers coincidence-on-arrival-times as the solution.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the same two-factor skeleton with the second factor supplied by a teacher instead of a modulator, and the source of the algebraic identity (`Widrow–Hoff on trains ≡ STDP + anti-STDP`) that places ReSuMe in this page's inventory; the derivation here settles that page's open question of what the presynaptic eligibility kernel should be — the postsynaptic potential, not the postsynaptic current.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — where this page's residue lives: a loss on spike trains is necessary but not sufficient, because every rule that has one trains a single layer, so the timing-domain analogue of backpropagation is still missing.
- **[[wiki/concepts/spike-encoding-schemes.md]]** — the input-side counterpart: that page fixes how a signal becomes spikes, this one fixes how spikes are scored against a target, and the two share a defect — both need a time origin the network does not generate ([[wiki/architectural-gaps.md]] `G77`), since a target spike *time* is meaningless without one.
- **[[wiki/concepts/spike-frequency-adaptation.md]]** — the same "a filter time constant is the whole design" problem in a different variable: there `τ_a` sets memory span, here `τ_q` sets the precision floor, and in both cases the constant is found by grid search rather than set by anything in the model (`G78`).
- **[[wiki/entities/liquid-state-machine.md]]** — the alternative that makes this page unnecessary by construction: rather than defining an error on spike trains, the liquid exponentially filters them into a continuous state and puts a memoryless linear readout on top, so the loss is an ordinary regression loss — the same convolution FILT uses, moved from the error term to the representation.
- **[[wiki/concepts/circuit-size-separation.md]]** — the expressivity result that motivates paying this price: a spiking neuron's programmable **delays** give VC dimension `Θ(n log n)` against `Θ(n)` for weights, so timing is worth training toward — but every rule here modifies weights only, and none of the family touches the parameter that carries the extra capacity.
- **[[wiki/concepts/learnable-synaptic-delays.md]]** — the exact complement: this page has a derived loss on spike trains and no way to propagate it past one neuron; that page has an exact gradient through depth, recurrence and multiple spikes, and uses it on latency and voltage objectives instead of a train distance. It is also the family's first rule that touches the parameter this page's last connection says nobody trains — the delay itself, whose gradient `−w_ji Σ_k (λ_I,j − λ_V,j)|_{t_k+d_ji}` is read off the same backward trajectories as the weight's.
