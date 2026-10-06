# Action Prediction Error — a Teaching Signal Over Actions, With No Reward Term

**An error between the action that was taken and the action the current state predicted, `δ_APE = a − A(s)`, with no outcome anywhere in it. Dopamine carries it to the tail of the striatum (TS). There it writes state–action associations by repetition. On its own it cannot learn which action is rewarded. Paired with a reward-trained controller, it copies that controller's choices into a store that then takes over expert performance.**

> **Provenance.** Greenstreet, Martinez Vergara, Johansson, …, Clopath & Stephenson-Jones 2025, *Dopaminergic action prediction errors serve as a value-free teaching signal*, Nature (published 14 May 2025; doi 10.1038/s41586-025-09008-9) (`raw/greenstreet-2025-dopaminergic-action-prediction-errors-value-free-teaching-signal.md`). Mouse, cloud-of-tones (COT) auditory two-alternative choice: low (5–10 kHz) or high (20–40 kHz) tone clouds map to left/right water ports. Methods: bulk dLight1.1 photometry in TS (`n` = 6–10 mice) and ventral striatum (VS, `n` = 5–7); lesions (caspase, 6-hydroxydopamine), pharmacology (muscimol, the NMDA (N-methyl-D-aspartate) antagonist d-AP5), and optogenetics; plus two hand-parameterised models. It tests the theories of Miller, Shenhav & Ludvig 2019 ([[wiki/concepts/value-free-habit.md]], its ref. 4) and Bogacz 2020. It shares no author with Miller et al. 2019. Author Moskovitz has co-written with Miller elsewhere (its ref. 58).

Why this earns a page: the wiki has an error over outcome value ([[wiki/concepts/reward-prediction-error.md]]), over which event follows ([[wiki/concepts/state-prediction-error.md]]) and over subgoal value ([[wiki/concepts/pseudo-reward-prediction-error.md]]). This is the first error over **which action was taken**, with no value term. It is also the measured carrier of the update `H ← H + α_H(𝐚_t − H)` that [[wiki/concepts/value-free-habit.md]] states only in theory (`T405`).

---

## Formalism

**Photometry model** (semi-Markov actor–critic plus a value-free system; states Start / High / Low / Outcome / action states; actions Left / Right / Centre / Idle):

| Quantity | Update |
|---|---|
| RPE (dwell-time discounted) | `δ_k = r_{k+1} − ρ_k·d_k + V̂(s)_{k+1} − V̂(s)_k`, where `ρ_k` = average reward per time step over the last 500 transitions |
| Critic, actor | `V̂(s) ← V̂(s) + αδ_k`; `m̂(s,a) ← m̂(s,a) + βδ_k`; `α = β = 0.005` |
| **APE** | `δ_{a_k} = a_k − A(s)`, where `a_k` is one-hot. **Rectified**, so only the taken action's component is non-zero, which makes it a scalar update. No TS dopamine dips were ever seen at action time |
| Value-free store | `A(s) ← A(s) + ε·δ_{a_k}`; `ε = 0.01`, or 0.001 "to mimic how a value-free controller should update slowly" |

**Dual-controller network** (2 states × 2 actions, 100 agents):

```
A_total(s) = W_actor·s + W_tail·s + U[0,1] noise          a = argmax A_total
δ_RPE = r − W_critic·s
τ_tail · dp_a/dt = −p_a + binarize(argmax W_tail·s)        τ_tail = 100
δ_APE = a − p_a                                            for the action taken
W_tail   ← W_tail   + β·δ_APE·s·a                          β = 0.02   (three-factor: state × efference copy × error)
W_actor  ← W_actor  + α·δ_RPE·s·a                          α = 0.04
W_critic ← W_critic + α·δ_RPE·s
τ_decay · dW_actor/dt = −W_actor + 1                       τ_decay = 100   ← the handover
```

All weights are bounded positive. `W_actor` and `W_tail` start at 1, `W_critic` at 0. Both controllers receive an **efference copy of the action taken**. The two controllers' outputs are **summed**, with no arbiter. Control passes to the tail store because the actor's weights relax to baseline once `δ_RPE` is small, not because an arbiter decides.

**Same object as `H`.** `δ_APE` is the bracket in Miller et al.'s `H(s,·) ← H(s,·) + α_H(𝐚_t − H(s,·))`. The network form differs in one place: the prediction `p_a` is a low-pass of the store's *own argmax*, not of `H` itself.

---

## Evidence

| Test | Result | What it establishes |
|---|---|---|
| Pre-training TS lesion (caspase) | Lower learning rate and lower maximum performance | TS is needed to learn |
| d-AP5 in TS | Impairs learning when infused during training. No effect in experts (`n` = 4) | NMDA-dependent plasticity in TS is needed to learn, not to act |
| 6-hydroxydopamine (6-OHDA) ablation of TS-projecting dopamine (`n` = 9 vs 5) | Learning deficit. Maximum performance tracks lesion size (`p` = 0.049). Centre-to-side time and inter-trial interval unchanged | TS dopamine is needed to learn, and the deficit is not motor |
| Muscimol in experts | TS impairs performance, dorsomedial striatum (DMS) does not | Expert choice runs through TS |
| D₁ vs D₂ spiny projection neuron (SPN) optoinhibition in TS | Opposite choice biases | Both pathways contribute, with opposite signs |
| What TS dopamine follows (kernel regression) | Contralateral movement out of the centre port, and contralateral returns. No sound response: none when the cue is omitted, played on the return trip, or played passively. Little outcome response. VS follows outcome | A movement signal, not a sensory or reward signal |
| Open arena | Scales with contralateral turn angle (TS slope > 0, `p` = 0.03; VS `p` = 0.87) | Not specific to the task |
| **Decline over learning** | Movement-locked TS dopamine falls, resembling the model's exponential decay. The fall survives regressing out speed and turn angle, and log trial number carries most of the explained variance | The signal is a prediction error, not raw movement |
| **Trial history** | TS response is smaller when the same sound→action pairing occurred on the previous trial. VS cue response is larger | Predicted actions produce smaller errors |
| **Novel cue, familiar action** | White noise replaces the contralateral tone cloud, and TS response *rises*. VS cue response falls | The prediction is conditioned on the state |
| **Value manipulations** | Larger reward or omission: TS unchanged (`p` = 0.84, 0.54; `n` = 6), VS changes strongly (`p` ≈ 3×10⁻⁶). Predicted-value shift: TS unchanged (`p` = 0.26, `n` = 5), VS changes (`p` = 2.4×10⁻⁴) | Value-free. This is the converse of the usual confound: value varied at a fixed action (`G116`) |
| Rival models (movement only, novelty, salience) | None matches the pattern across conditions (Ext. Data Fig. 8) | APE is the best of the candidates fitted |
| **Sufficiency**: unilateral TS stimulation at the centre port, on trials with contralateral evidence | Contralateral bias that builds across the session. No bias on the stimulated trial itself. VS stimulation at the same time: none. TS or VS stimulation at outcome: none | TS dopamine *teaches*. It does not drive the movement |
| State–outcome tests | Free choice with one port paired with stimulation: TS none; VS biases toward that port (`p` = 0.002 at 50% reward). Real-time place preference: TS neither appetitive nor aversive | TS dopamine does not reinforce state–outcome associations |
| Movement initiation (closed-loop stimulation in an open field when the mouse is immobile) | No change in movement likelihood or movement parameters | TS dopamine is not a movement trigger or invigorator |
| **Endogenous teaching** | A larger TS response on trial *t* predicts repeating the choice on *t*+1. Higher sensory uncertainty also predicts repeating. VS reward response does not predict repeating. A larger TS response predicts a more similar next trajectory (smaller Fréchet distance) | The natural signal acts like the stimulated one |
| **Handover** | TS SPN optoinhibition has no effect early in training. The effect grows once performance passes ~65% | TS takes control only after choices are already consistent. Control migrates within the striatum, it does not leave it (`T131`) |

**Dual-controller simulations:**

| Model | Outcome |
|---|---|
| Value-free controller alone | **Cannot learn.** It keeps repeating its own initial 50/50 choice |
| Value-based actor–critic alone | Learns |
| Both | Learns faster than value-based alone. The two curves split only once choices become consistent, at the same point where lesioned and control mice split |
| Both, with actor decay | Control passes to the tail store. The critic keeps state value. The actor's state–action weights decay |

---

## Placement among the wiki's prediction errors

| Error | Differenced over | Form | Carrier | Writes |
|---|---|---|---|---|
| Reward ([[wiki/concepts/reward-prediction-error.md]]) | Outcome value | `r + γV(s′) − V(s)` | VTA / medial SNc → VS | Critic and actor |
| State ([[wiki/concepts/state-prediction-error.md]]) | Which event follows | `x_obs − x̂(·|c)` (wiki's reconstruction) | VTA transient | Cue → cue edge |
| Pseudo-reward ([[wiki/concepts/pseudo-reward-prediction-error.md]]) | Subgoal value | `γV_o(s′) − V_o(s)` | Dorsal anterior cingulate, anterior insula, habenula, amygdala, accumbens (functional MRI / EEG) | Option policy |
| **Action (this page)** | **Which action given the state** | `a − A(s)`, rectified | **Lateral SNc / substantia nigra pars lateralis → TS** | **State → action store** |
| Threat (proposed by others; Menegas et al. 2018, cited) | Threat | — | Also TS dopamine. Looming stimuli evoke TS responses in the same mice | Avoidance. Here TS stimulation is never aversive. The source proposes separate *Vglut2* (threat) and *Anxa1* (movement) subpopulations. Untested |

---

## What a builder takes

| Finding | Consequence |
|---|---|
| A teaching signal over actions, with no outcome term | Compiling a controller into an automatic store is **online behaviour cloning**: `Δ = (a_taken − p)` for whatever the controller did. It needs no reward and no replay, only an efference copy (`G51`, now `PARTIAL`) |
| The value-free store cannot learn alone | It is a consolidator, not a learner. Its content is value-shaped only because a value-trained controller chose the actions first. A build that trains it from scratch learns nothing |
| Handover by source decay, not by an arbiter | The actor relaxes to baseline when `δ_RPE` is small, so control passes to the store with no arbitration variable. This is a fourth rule beside reliability, value of computation (`T135`) and contingency against habit concentration (Miller et al.) |
| Two teaching signals, each admitted to one store and one moment | Teaching at choice time reaches the state–action store. Teaching at outcome time reaches the state–outcome learner. Stimulation at the other moment, or in the other region, does nothing (`G119`) |
| Repetition is more likely under higher sensory uncertainty | Consistent with the source's reading of the store as an **action prior** that dominates when the value controller is unsure. The source's other reading is a compressed default policy (its refs. 57–59) — see [[wiki/concepts/default-policy-regularization.md]] |

**(brainstorm)** For a reasoning agent this is a concrete compile path. A planner or explicit controller acts. A policy head trained on `a_executed − p` copies its choices online. The controller's own fast weights relax wherever its value error has gone quiet, so practised moves stop costing planning. Two consequences follow. (i) The head's distribution is set by what the planner *did*, so systematic planner errors get compiled too. (ii) The source's handover needs the controller's learned weights to *decay*. A deep-network planner has no such term. Without one, the two outputs stay summed indefinitely and nothing ever becomes automatic.

---

## Limitations

| Limit | Consequence |
|---|---|
| Reward is present in every manipulation | Not a repetition-without-reinforcement test (`T405` design (i)). The stimulated bias builds inside a rewarded task |
| No devaluation and no omission test | The TS store is not shown to be a habit by the standard assay, and not shown *not* to be one. It is called habit-like on the grounds of stability and late takeover only (`G121`) |
| The signal is movement-locked | "Prediction" rests on decline, trial history and the novel-cue effect, each regressed against 2D head speed and turn angle only (DeepLabCut, 30 Hz). Turn angle itself correlates with TS dopamine |
| Bulk photometry | A population average. Whether single neurons carry APE, or a movement signal plus a separate threat signal, is not resolved here |
| Rectification is assumed | Negative APEs are never seen, so the store's unlearning route is unspecified |
| Two different APE formulations | `a − A(s)` in the photometry model, `a − p_a` (low-pass of the store's own argmax) in the network. Parameters are hand-set and not fitted to learning speed |
| One region | APE broadcast to the rest of dorsal striatum is drawn as "proposed, as yet unverified" (Ext. Data Fig. 11c) |
| Primate homology is by reinterpretation | Caudate-tail dopamine fires before contralateral saccades (Kim et al. 2015, cited). Those authors read it as a visual response; this source reads it as APE |

---

## Open problems

- **Is the APE store the habit?** Run devaluation and omission on behaviour that depends on TS, after the handover. This is the test `T405` (ii) and `G121` need. Neither is run.
- **Repetition with no reward at all.** Stimulate TS dopamine at choice time in a session with outcomes equalised, then test free choice. That is design (i) of `T405`. The free-choice arm here stimulated at port entry, which tests state–outcome learning instead.
- **Preparation or execution?** The source leaves open whether the error is computed against the planned action or the executed one. It decides whether `a` in the formula is an efference copy or a reafference.
- **Is all movement-related dopamine APE?** The source proposes yes, citing two signatures. In dorsolateral striatum (DLS), dopamine transients at the onset of sub-second behavioural syllables scale with how unpredictable the next action is (Markowitz et al. 2023). In SNc, movement-related activity falls with practice (da Silva et al. 2018). If so, the wiki's dorsolateral habit address ([[wiki/entities/basal-ganglia.md]]) has the same teaching signal.
- **Where is `A(s)` computed?** TS-projecting dopamine neurons take input from the deep, motor layers of the superior colliculus (cited). Where the prediction is subtracted is unidentified.
- **Off-policy learning.** An APE lets the basal ganglia learn from actions that a different controller chose (Lindsey & Litwin-Kumar 2022, cited). This is untested.

---

## Connections

- **[[wiki/concepts/value-free-habit.md]]** — the measured carrier of that page's `H` update. `δ_APE = a − A(s)` is the bracket in `H ← H + α_H(𝐚_t − H)`. This page supplies a dopamine signal that is value-free, falls as the action becomes predictable, and causally biases state–action choice. It does not supply the omission or devaluation test that page says decides between value-free and cached-value habits (`T405`).
- **[[wiki/concepts/reward-prediction-error.md]]** — the second dopaminergic teaching signal that page lacked. It travels on a separate projection (lateral SNc / pars lateralis → TS, against VTA → VS), it is unmodulated by reward size, omission or predicted value, and it is consumed only by a state–action store. So "dopamine = `δ`" holds for one terminal field, not for the whole projection.
- **[[wiki/concepts/state-prediction-error.md]]** — the other value-free dopaminergic error in the wiki. That one is over which *event* follows a cue and writes a cue→cue edge. This one is over which *action* follows a state and writes a state→action link. Both remove `r` from the formula. They differ in what is predicted and in which projection carries the signal.
- **[[wiki/concepts/broadcast-channel-decomposition.md]]** — another channel addressed by axon. A lateral nigral population sends to TS a movement-locked, value-free error that is silent to sound and outcome. TS also carries threat responses, proposed to come from a genetically separate subpopulation. So the "tail" of the projection is itself at least two channels.
- **[[wiki/entities/basal-ganglia.md]]** — gives that circuit a fourth striatal territory and a second teacher. TS learns state→action by APE through a three-factor rule (state × efference copy × error). D₁ and D₂ spiny-neuron silencing there bias choice in opposite directions. Expert performance moves into TS as training proceeds. DMS inactivation spares experts.
- **[[wiki/concepts/default-policy-regularization.md]]** — the source reads the APE store as a compressed default policy and as a prior on action, dominant when sensory uncertainty is high (repetition rises with uncertainty). That is that page's `π₀`, learned online from executed actions rather than distilled from task policies, and added to the controller's output rather than charged for by `KL`.
- **[[wiki/concepts/amortized-inference.md]]** — a measured instance of compiling a controller into a cache. The cache is written by a value-free error over executed actions, not by Dyna-style value learning. The handover comes from the controller's own weights decaying when its reward error is small, with no arbiter.
