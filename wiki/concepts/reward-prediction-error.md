# Reward Prediction Error

**One broadcast scalar, `δ(t) = r(t) + γV(s(t)) − V(s(t−1))`, carrying the *sign* of how an outcome compared to its expectation and no address at all — consumed in the same instant as a plasticity term and as a gain on the units that happen to be active.**

> **Provenance.** No single source; this page is a lint-pass synthesis of a quantity the wiki was using on 38 pages without a home. Primary material from Doya 2002 (`raw/doya-2002-metalearning-neuromodulation.md`), Gerfen & Surmeier 2011 (`raw/gerfen-2011-striatal-dopamine-modulation.md`), O'Reilly & Frank 2006 (`raw/oreilly-2006-making-working-memory-work.md`), Wang et al. 2018 (`raw/wang-2018-pfc-meta-rl-system.md`), Kable & Glimcher 2007 (`raw/kable-2007-subjective-value-intertemporal-choice.md`), Schultz et al. 1993/1997 as cited throughout.

Why this earns a page. The wiki's architectures do not disagree about the *formula* — they disagree about what the formula names, and the disagreement is invisible while `δ` is mentioned in passing on other pages. Four incompatible readings are in active use here simultaneously, and every one of them cashes out as a different wire in a built system.

---

## Four readings of the same firing record

| # | Reading | `δ` is | Consumed by | Where the wiki runs it |
|---|---|---|---|---|
| 1 | **Teaching signal** (standard) | An error on *value*: `r + γV(s′) − V(s)` | A plasticity rule, from outside the network | [[wiki/entities/meta-rl-agent.md]], every temporal-difference model here |
| 2 | **Precision** | The *value of* prediction error — an inferred inverse variance on proprioceptive/interoceptive channels | The inference dynamics, as a postsynaptic gain | [[wiki/concepts/precision-weighting.md]] ([[wiki/empirical-tensions.md]] T122) |
| 3 | **Associative pair, no chain** | The output of two Rescorla–Wagner systems (`PV` cancels the burst at expected delivery, `LV` creates it at the cue) | The same plasticity rule as 1 | [[wiki/entities/pbwm.md]]'s PVLV (T85) |
| 4 | **Learning signal in a four-chemical taxonomy** | Not a metaparameter at all — the global signal itself, with `γ`, `β`, `α` carried separately by serotonin, noradrenaline and acetylcholine | Critic *and* actor | [[wiki/concepts/neuromodulatory-metaparameters.md]] |

Readings 1, 3 and 4 differ in *how the signal is computed* and agree on what it is for. Reading 2 differs on what it is for, and the disagreement now spans two chemicals rather than one: reading 4 assigns acetylcholine the learning rate, reading 2 assigns it the precision of exteroceptive inference.

**The useful licence, and it is not obvious.** Gerfen & Surmeier 2011 are explicit that the debate over *what* midbrain firing encodes is not load-bearing for the striatal mechanism: it needs only that the signal moves **bidirectionally with outcome**. A precision signal read as a learning-rate gain is consumed by exactly the same D₁/D₂ split with the same opposite signs. So T122 can stay open indefinitely without stalling any architecture on this page — which is why it has.

**Three observations reading 2 gets for free and reading 1 has to absorb** ([[wiki/entities/affordance-active-inference-model.md]], Friston et al. 2012):

| Observation | Under reading 1 | Under reading 2 |
|---|---|---|
| A substantial fraction of dopamine neurons **increase** firing to aversive stimuli and to cues predicting them | wrong sign for `r + γV(s′) − V(s)` | an aversive cue portends a predictable sensorimotor sequence, so it is precise |
| Dopamine neurons fire to cues predicting the future **availability of information** about a reward, conveying nothing about the reward itself | no reward term to be in error about | the cue announces that a contingency is about to become predictable |
| Dopaminergic discharge covaries with the **variance** of juice rewards | second-order, outside the formula | precision *is* an inverse variance |

And a mechanistic objection that is independent of any firing record: dopamine acts on G-protein-coupled receptors concentrated in glutamatergic dendritic spines, where it **modulates** a postsynaptic response and cannot excite one. A modulator cannot be the wire carrying an error's content; it can only scale a wire that does. Reading 1 survives this by locating the error in the *timing and magnitude* of a signal that is consumed as a plasticity gate — which is what the striatal mechanism above actually needs — but it means "dopamine encodes `δ`" is a claim about what the firing *reports*, never about what it *delivers*.

---

## What the scalar is actually consumed as

This is the part the `δ` notation hides, and it is the only part with a mechanism behind it.

```
dopamine ↑ :  direct-pathway SPNs   excitability ↑  and  corticostriatal Δw ← LTP
              indirect-pathway SPNs excitability ↓  and  corticostriatal Δw ← LTD
dopamine ↓ :  the mirror
```

**Gain and learning rate are co-modulated by one signal, in the same direction.** The scalar that decides which pathway runs *now* also decides which pathway's cortical inputs are strengthened *for next time*. Selection and credit assignment are not two mechanisms sharing a wire; they are one modulation read at two timescales. **No learning rule in [[wiki/concepts/synaptic-plasticity.md]] couples its third factor to the activation function of the same units** — the wiki's plasticity rules take a modulator that multiplies `Δw` and leaves the forward pass alone.

**(brainstorm)** The machine version is a one-line change with no obvious precedent: let the same broadcast scalar scale both the update and the unit gains of the population it updates, with opposite signs on two subpopulations. The prediction is a self-reinforcing selection — the channel favoured now is the channel whose evidence gets strengthened — which is either the mechanism behind fast habit formation or an instability, and nothing in the wiki distinguishes those.

---

## The address problem, and the two answers to it

`δ` is diffuse and unaddressed. *Which* synapses move is decided entirely by which units the current input ensemble happened to drive.

This is the read of **G19** (no local rule is selective about what it writes) that biology actually implements: **the scalar carries the sign, the ensemble carries the address**, selectivity is in the conjunction, and the price is that a coincidentally-active ensemble is potentiated exactly as readily as a causal one.

Two mechanisms in the wiki make the addressless scalar selective, and they are different in kind:

| Mechanism | How | Cost |
|---|---|---|
| **Conjunction only** (striatum) | Sign from the modulator, address from whichever spiny neurons the cortical ensemble drove | Spurious credit is the default, not a failure mode |
| **Gated by the acting module's own output** ([[wiki/entities/pbwm.md]]) | `δ_j = snr_j · δ` — the global signal is multiplied per stripe by that stripe's own Go activation, so a stripe that did not act receives no learning signal, implemented anatomically by SNr → SNc inhibition | Requires the module to have a *discrete act/not-act event* to gate on. Ablating it is the single most damaging manipulation in that model |

**(brainstorm)** The second is the cheapest structural-credit mechanism in the wiki and it generalises past gating: any module that emits a licence on its own participation can convert a broadcast scalar into an addressed one *without* the scalar carrying an address. That is the same shape as the write-mask proposal on [[wiki/entities/hippocampal-prefrontal-channel.md]] (G52), arrived at from the credit side rather than the interface side, and it is the reason the two should be built as one experiment.

---

## The terms are less settled than the formula

`δ` is composed of `r`, `γ` and `V`, and each of the three is contested independently of the debate above.

| Term | Standard | Contested by |
|---|---|---|
| `γ` | A scalar metaparameter, chemically carried (serotonin), set within a lifetime by a feedback law on `Var(δ)` (Doya 2002) | A per-agent **trait**: a 238× spread across subjects, stable over six months, and a population-average rate destroys the neural effect entirely (Kable & Glimcher 2007). The two are compatible only where the control law's input was stationary — which, in a lab task, it was |
| The kernel | `γ^k` — exponential, so `V` is stationary and dynamic programming converges | Hyperbolic, `SV = A/(1+kD)`, median `R² = 0.95` per subject, matched by a kernel refit to the value regions' own time courses with zero mean offset (T141). A hyperbolic kernel is **time-inconsistent** — no *single* stationary `V` exists for `δ` to be an error *about*, but it is a mixture `∫₀¹ w(γ)γᵗ dγ` of ones that are, so ten well-formed `δ`s at ten discount factors reconstruct it ([[wiki/concepts/multi-horizon-value-learning.md]]) |
| `V` | One value function | Two, with different horizons and an arbitrator (the β–δ reading) — falsified here on two independent grounds (T140), but the *architectural* question it raises survives the falsification |

**T141 used to be the one that should worry a builder**, and its architectural sting is now drawn. Every value function in the wiki uses `γ^k`; if the kernel is hyperbolic, `δ` as written at the top of this page is still perfectly well-formed — it is just no longer the *only* one, since the hyperbola is a weighted integral of exponentials and a bank of ordinary temporal-difference learners recombines into it at read-out (Fedus et al. 2019, [[wiki/concepts/multi-horizon-value-learning.md]]). What is left of T141 is the empirical question of which kernel the brain uses, and a smaller architectural one: how many horizons, and who sets the weighting.

---

## The dual role: the same signal drives weights *and* behaviour

The sharpest single result on this page is that `δ` does not have to be doing only one job. In the meta-RL agent, feeding the RPE in **as the network's input** in place of raw reward reproduces behaviour on five tasks — and then, **with weights frozen**, simulated dopamine block at reward still reduces preference for that lever while induced dopamine at omission raises it.

So the same scalar is simultaneously (i) the outer-loop plasticity term that built the recurrent dynamics and (ii) an online input those frozen dynamics condition on. A lesion of "the dopamine signal" therefore has two dissociable effects on two timescales, and no experiment that manipulates dopamine can attribute its result to one of them without freezing the weights — which is exactly what the simulation can do and the animal experiment cannot.

**(brainstorm)** This is the cleanest instance in the wiki of a quantity that is a *training signal* and a *runtime observation* at once, and it suggests a test nobody has run: train an agent with `δ` on the input channel, freeze it, and check whether the frozen policy's sensitivity to `δ` perturbation matches the animal's. If it does, the behavioural dopamine literature has been measuring the inference role and reading it as the learning role.

---

## What a builder takes from this

| Finding | Consequence |
|---|---|
| One scalar, two consumers, same direction | Do not model the modulator as a multiplier on `Δw` alone. The biological signal is a gain *and* a learning rate, oppositely signed on two populations |
| The address is in the ensemble, never in the signal | Any architecture that broadcasts a scalar inherits spurious credit by construction (G19); buying selectivity requires a *second* signal from the acting module, not a better modulator |
| Outcome value ≠ action value | `δ` is computed on outcome value; collapsing it into `Q(s,a)` loses the ability to re-goal without relearning the action values (G28) |
| The signal is bidirectional, and that is all the mechanism needs | Which makes T122 safely deferrable and the *kernel* question (T141) the one that is not |

---

## Open problems

- **No architecture in the wiki couples gain and plasticity to one scalar.** The mechanism is documented in detail on [[wiki/entities/basal-ganglia.md]] and implemented nowhere, so its predicted instability has never been observed either way.
- **The kernel question is unadjudicated but no longer load-bearing.** Exponential `γ^k` and hyperbolic `A/(1+kD)` are behaviourally near-unidentifiable (the two-exponential sum fits as well as the hyperbola), and since the hyperbola *is* a mixture of exponentials, the two no longer imply different planning machinery — only a different number of value heads and a different read-out weighting — T141.
- **The two-timescale confound has no experimental resolution outside simulation.** Every dopamine manipulation in the cited literature moves the plasticity role and the input role together.
- **`δ` is measured, never certified.** Recording a signal that correlates with `r + γV(s′) − V(s)` does not establish that a downstream circuit consumes it as an error rather than as a gain — the same non-identifiability [[wiki/concepts/objective-identifiability.md]] states for objectives, applied to a scalar.
- **Nobody has read `γ_effective` off a trained network.** Kable & Glimcher's two-part psychometric–neurometric test (covariance *and* zero offset) is directly runnable on an artificial agent and would say whether the horizon the optimiser was given is the horizon the network learned.

---

## Connections

- **[[wiki/entities/affordance-active-inference-model.md]]** — the constructive half of the case against reading 1: a behaving agent that anticipates, switches set, pays a switch cost and shows bradykinesia with no value function and no `δ` anywhere, dopamine present only as a fixed postsynaptic gain whose *level* in the hierarchy determines the syndrome (T122).

- **[[wiki/entities/continual-dreamer.md]]** — a negative result about reward as a *selection* signal: weighting replay sampling in proportion to environment reward is indistinguishable from uniform sampling, so reward magnitude carries no usable information about what should be rehearsed.
- **[[wiki/entities/basal-ganglia.md]]** — the circuit that consumes this signal, and the source of the one mechanism on this page: opponent D₁/D₂ populations read one broadcast scalar with opposite signs on excitability *and* on plasticity, so selection and credit assignment are one modulation at two timescales.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the taxonomy that places this signal among three others: `δ` is the global learning signal and *not* a metaparameter, while `γ`, `β` and `α` are, each with a chemical carrier and a feedback law computed from this page's own statistics (`Var(δ)`, sign reversals of `δ`).
- **[[wiki/concepts/precision-weighting.md]]** — the rival identity for the same firing record: an inferred inverse variance consumed by the inference dynamics rather than an error consumed by a plasticity rule ([[wiki/empirical-tensions.md]] T122), with the licence that the striatal mechanism is indifferent between them.
- **[[wiki/concepts/subjective-value.md]]** — supplies the `V` this page differences and undermines the `γ` it multiplies: the discount is applied *inside* the represented value at choice time, the rate is a stable per-agent trait rather than a tracked statistic, and the kernel that fits is hyperbolic (T140, T141).
- **[[wiki/entities/pbwm.md]]** — the wiki's only mechanism for making an addressless scalar selective, `δ_j = snr_j · δ`, plus the contesting account of where the signal comes from: two Rescorla–Wagner systems with no prediction chain, which matters because the chain breaks on exactly the tasks that model runs (T85).
- **[[wiki/entities/meta-rl-agent.md]]** — the dual-role result: this signal trains the recurrent weights *and*, delivered as an input to those weights once frozen, still moves behaviour — so any dopamine manipulation confounds a plasticity effect with an inference effect.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the third-factor slot this signal fills, and the coupling none of that page's rules has: a modulator that scales the update *and* the activation function of the units it updates.
- **[[wiki/concepts/simulation-based-planning.md]]** — what inherits the kernel problem: rollout scoring assumes a stationary value function, which a hyperbolic discount forbids, so T141 propagates from valuation into planning.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the same structural-credit trick arrived at from the interface side: a module emitting a licence on its own participation converts a broadcast signal into an addressed one, which is the write-mask experiment (G52) and this page's `snr_j · δ` gate built as one thing.
- **[[wiki/concepts/objective-identifiability.md]]** — why measuring this signal does not certify it: a recorded correlate of `r + γV(s′) − V(s)` is consistent with the downstream circuit consuming it as a gain, and no i.i.d. measurement separates the two.
- **[[wiki/concepts/amortized-inference.md]]** — where this signal sits in the arbitration story: the model-free controller whose values it trains is the cached, cheap system, and the relative-uncertainty account decides when its output is trusted over a rollout.
- **[[wiki/concepts/replay-prioritisation.md]]** — the same `δ` used as a *control* signal rather than a learning signal: `|δ|` selects which stored transition is fitted next, so a quantity this page tracks as dopaminergic teaching becomes a scheduler over the learner's own data.
- **[[wiki/concepts/multi-horizon-value-learning.md]]** — keeps this page's error term intact under a non-exponential kernel: each `δ_i = r + γ_i V_i(s′) − V_i(s)` is an ordinary temporal-difference error at its own horizon, and the time-inconsistent value appears only at read-out as `Σ_i w(γ_i)Q^{γ_i}` — so what a hyperbolic brain would need is many broadcast channels or one signal read with many decay rates, not a new learning rule.
