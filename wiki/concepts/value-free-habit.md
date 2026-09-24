# Value-Free Habit (the Law of Exercise)

**A habit is a stimulus–response (S–R) strength that grows with how often an action was *taken* in a state, with no reward term anywhere in its update: `H(s,·) ← H(s,·) + α_H(a_t − H(s,·))`. It is a running average of the executed policy. Value enters only upstream, through whichever controller chose the actions that got repeated.**

> **Provenance.** Miller, Shenhav & Ludvig 2019, *Habits without values*, Psychol Rev 126(2):292–311 (`raw/miller-2019-habits-without-values.md`). A theory paper with simulations. Every behavioural and neural datum in it is cited second-hand. The rat bandit data are "in prep". Nothing is fitted quantitatively; all agreement is qualitative.

Why this earns a page: the wiki's working definition of habit is **model-free reinforcement learning (RL)** — a cached value that wins an arbitration ([[wiki/concepts/amortized-inference.md]], [[wiki/entities/basal-ganglia.md]]). Robinson & Berridge ([[wiki/concepts/incentive-salience.md]], `G121`) criticise that definition as *negative*: it says only what a habit lacks. This page records the positive definition, from a habit-theory source in its own words: a habit is a stored action frequency, and it is not a value (`T405`).

---

## The model

Three modules. Single-state form is below; Appendix A of the source gives the multi-state form.

| Module | State | Update | Reads outcome? |
|---|---|---|---|
| **Habitual controller** | `H(s,a)`, starts at 0 | `H(s_t,·) ← H(s_t,·) + α_H(𝐚_t − H(s_t,·))`, where `𝐚_t` is one-hot on the action taken | **No** |
| **Goal-directed controller** (model-based) | `R(s,a,m)` = expected magnitude of reinforcer *type* `m`; `T(s,a,s′)` | `R ← R + α_R(r_t(m) − R)`; `T ← T + α_T(𝐬_{t+1} − T)`; `Q(s,a) = Σ_m U(m)R(s,a,m) + γ Σ_{s′} T(s,a,s′) max_{a′} Q(s′,a′)` | Yes. It keeps reinforcers separate by type, with **no common currency**. Devaluation is a direct edit to `U(m)` |
| **Arbiter** | `w ∈ (0,1)` | see below | Through `g` only |

**Arbitration:**

```
g = sqrt( Σ_a π(a) (R(a) − Σ_a′ π(a′)R(a′))² )     action–outcome contingency: policy-weighted standard deviation of expected outcome
h = sqrt( Σ_a (H(a) − mean_a H)² )                  habitization: spread of habit strengths
w = 1 / (1 + exp(w_g·g − w_h·h + w_0))              weight on the habit controller
D(a) = w·θ_h·H(a) + (1 − w)·θ_g·Q(a)                drive
π(a) ∝ exp(D(a))
```

- The push–pull is **contingency against concentration**. High `g` favours goal-directed control. A peaked `H` favours habit. The arbiter weighs the *environment's* contingency against the *agent's own* action history, which differs from arbitration by uncertainty (Daw et al. 2005) or by speed (Keramati et al. 2011).
- `g` reads **means only**. "1 pellet for sure" against "2 pellets with p = 0.5" scores `g = 0`. The arbiter cannot see risk or variance.
- `H` is a function of `π`'s history alone. Habits form out of goal-directed choices: first the controller picks, then repetition builds `H`, then `h` rises, then `w` rises.

**Free-operant extension.** The action is a press rate `a ∈ [0,150]` per minute. `R` is fitted on a 4-term polynomial basis and `H` on 30 Gaussian radial basis functions. An action-density prior `m(a) = e^{−a/5}` enters as `π(a) ∝ exp(m(a)·D(a))`, so a random agent presses slowly. Effort is a reinforcer with negative utility, quadratic in rate.

---

## What it reproduces

| Phenomenon | Setup | Result | Mechanism in the model |
|---|---|---|---|
| Habits form from goal-directed behaviour | Reversal: A pays 0.5, B pays 0; swapped after 1000 trials | `Q` flips soon after reversal. `H` keeps favouring A until B has been *chosen* consistently. Choice follows `H` long after `Q` has flipped | `H` tracks choices, not payoffs |
| **Overtraining abolishes omission sensitivity** | Press pays pellet p = .25 (or .5), withhold pays leisure 0.1. Then pressing *prevents* the pellet. Training length varied 100–2000 trials | Short training: pressing drops. Long training: pressing persists | Same handover as devaluation |
| **Overtraining abolishes devaluation sensitivity** | Same training, then `U(pellet) = 0`, then extinction test | Persistence grows with training length | Same handover |
| **Interval schedules habitize faster than ratio schedules** — the source's claim to the first computational account | VI6 (variable-interval, baited every 6 s on average) against VR10 (variable-ratio, 10% per press), quadratic effort | VI: moderate rate, early habit. VR: high rate, late habit | On VI, pellet rate is sublinear in press rate, so the slope is flat, so `g` is low and the habit side wins early. On VR the slope is linear, so `g` stays high |
| **Lesion double dissociation** | "Dorsomedial striatum lesion": `θ_g` 20 → 2, `w_g` 6 → 0. "Dorsolateral striatum lesion": `θ_h`, `w_h` → 0. Limited (5k) or extended (15k) training on VR | Goal-directed lesion: low rate, insensitive to omission and devaluation. Habit lesion: high rate, sensitive to both. Intact: sensitive after limited training, insensitive after extended | Matches Yin et al. 2004/2005/2006 rat lesions qualitatively |
| **Choice perseveration** | Drifting two-armed bandit (Gaussian random walk, standard deviation 0.15), 10k trials, 50 agents. Analysed by lagged logistic regression: `logit P_t = Σ_τ β_a(τ)a_{t−τ} + β_r(τ)r_{t−τ} + β_x(τ)a_{t−τ}r_{t−τ} + β_o` | Rats show both a reward-seeking term (`β_x`) and a choice-repetition term (`β_a`). The model reproduces both. A model-based + model-free mixture over a wider parameter range reproduces the reward term only | `β_a > 0` is `H` |

**Why the omission row is the discriminating one.** Model-free RL explains devaluation-insensitivity cheaply: its cached value is in a common currency with no outcome identity, so editing `U(m)` cannot reach it. Omission is different. Once pressing *prevents* reward, the cached value of pressing falls under any model-free update. So model-free RL predicts omission-*sensitive* habits. The only rescue the authors know of is an extra mechanism: a learning rate that decays in stable environments (Dayan, Kakade & Montague 2000). The value-free controller explains both insensitivities with one mechanism, because `H` never reads the outcome.

---

## The realignment it proposes

| Dichotomy | Neural separation? | Evidence the source cites |
|---|---|---|
| Goal-directed vs habitual | **Clean double dissociations** | Goal-directed: prelimbic cortex, dorsomedial striatum, mediodorsal thalamus, basolateral amygdala, orbitofrontal cortex (vmPFC and dorsolateral prefrontal cortex in humans). Habitual: infralimbic cortex, dorsolateral striatum. Activity: orbitofrontal/dorsomedial striatum up under goal-directed control, dorsolateral striatum up under habitual (Gremel & Costa 2013); human putamen tracks habit development (Tricomi et al. 2009) |
| Model-based vs model-free | **None found** | Regions carrying model-free signals also carry model-based ones: ventral striatum, vmPFC, midbrain dopamine (Daw et al. 2011; Wimmer et al. 2012). Dopamine carries inferred values (Bromberg-Martin et al. 2010), counterfactual outcomes (Kishida et al. 2016) and sensory-preconditioning errors (Sadacca et al. 2016). Parkinson's patients show impaired model-based choice *and* more perseveration, both relieved by dopamine replacement |

Proposal:

1. **Divorce.** Habits are value-free S–R links strengthened by repetition, outside RL entirely. Value-free does not mean value-*insensitive*. Value can modulate how *fast* a habit is written (e.g. through vigour), but once the habit exists it does not drive it.
2. **Union.** Model-free and model-based RL are two ends of one goal-directed continuum, ordered by how much information the choice uses (recent rewards, then stimulus–stimulus relations, then a full state model). This removes the need for a common-currency cache, which the source says has weak neural evidence (Morrison & Nicola 2014; O'Doherty 2014; Schoenbaum et al. 2011). The model itself stays agnostic on whether model-free RL exists at all.

**Weaker predictions from the union.** Every region with a model-free prediction error should also carry a model-based one. A model-free valuation lesion should always affect model-based behaviour. The reverse need not hold, because model-based control adds hippocampal and prefrontal machinery.

**Predictions from the divorce.**

- Dorsolateral-striatum activity should rise with the number of repetitions, and lesions there should reduce value-free perseveration (`β_a`).
- **Repetition alone should build a habit.** Actions elicited by microstimulation in a context, with no reinforcement, should be facilitated later in that context. Not run.
- Obsessive–compulsive and tic disorders need not involve faulty valuation.

---

## Placement among the wiki's habit accounts

| Account | What a habit is | Written by | Why it resists devaluation | Why it resists omission |
|---|---|---|---|---|
| Model-free RL (Daw, Niv & Dayan 2005; [[wiki/concepts/amortized-inference.md]]) | Cached common-currency value | Reward-prediction error | No outcome identity in the cache | Needs a decaying learning rate |
| Uncertainty arbitration (same) | Whichever cache wins the variance comparison | Same | Tree search's computational noise exceeds cache variance | Same problem |
| Action chunks (Dezfouli & Balleine 2012) | Open-loop action sequence, launched under goal-directed control | Speed–accuracy cost–benefit | Runs to completion without checking | Same |
| Cortico-cortical Hebbian shortcut (Ashby et al. 2007; O'Reilly & Frank 2006; [[wiki/entities/basal-ganglia.md]] SPEED) | Cortical S–R link trained by consistent basal-ganglia firing | Hebbian co-activity | Bypasses the valuing module | Same |
| Default-policy regularization ([[wiki/concepts/default-policy-regularization.md]]) | `π₀` distilled from task policies | Distillation under a `KL` price | Deviation from `π₀` is costly | Same |
| Incentive sensitization ([[wiki/concepts/incentive-salience.md]]) | Not a habit: a cue-bound motivational gain | Mesolimbic transients | The gain is bound to the cue, not the outcome | Not addressed |
| **Value-free (this page)** | Action frequency per state | **Execution alone** | `H` never reads the outcome | `H` never reads the outcome |

**(brainstorm) `H` is the Distral default policy with the price removed.** `H(s,·)` is an exponential moving average of one-hot executed actions, i.e. a behaviour-cloned estimate of `π(·|s)` with time constant `1/α_H`. Default-policy regularization distils `π₀` from task policies and *charges* for departing from it with `KL`. Miller et al. distil the same object from executed actions and *add* it to the logits, gated by the arbiter. So the two accounts differ in one place: whether the default enters as a prior with a price (`log π₀` inside a `KL`) or as an additive drive whose weight a contingency signal switches. That can be tested by ablation in one agent.

**(brainstorm) For plan amortization, this changes the training target.** If the habit store is value-free, compiling a planner into a habit is **behaviour cloning of what the planner did**, not Dyna-style value learning from simulated rollouts. It needs no reward, and it needs the planner to have *run*. That favours distil-the-actions designs (a Mode-2 → Mode-1 action loss, [[wiki/concepts/amortized-inference.md]]) over cache-the-values designs.

---

## Limitations

| Limit | Consequence |
|---|---|
| **`α_H` spans five orders of magnitude across simulations**: 10⁻⁵ (operant), 10⁻³ (forced choice), 0.5–0.7 (bandit) | The trial-lag perseveration kernel and the thousands-of-trials overtraining habit are fitted by the *same equation* at time constants ~10⁵ apart. Nothing shows they are one mechanism. Two stores at two rates fit the data equally well |
| **The bandit comparison is not a fair ablation** | The model-based + model-free (MB/MF) comparison agent has no perseveration kernel. Standard MB/MF formalisations include one (Lau & Glimcher 2005; Daw et al. 2011), as the source concedes. In a one-state bandit the MB and MF update equations are identical (B1 vs B2), so the red scatter is "no choice term", not "model-free instead of value-free" |
| **The VI/VR result comes from the arbiter, not from value-freedom** | `g` is low on interval schedules whatever the habit store holds. **(brainstorm)** A model-free cache under the same contingency arbiter should reproduce the schedule effect too. Untested |
| "Lesions" are parameter reductions | `θ_g`, `w_g` or `θ_h`, `w_h` are turned down, not modules removed. A graded knob, and it is hand-picked per simulation |
| Parameters hand-set, not fitted; animal data qualitative or unpublished | Figure agreement is shape-level. No likelihood comparison between accounts |
| All simulations are single-state | The multi-state equations are written down but never run. How `H` generalises across states (e.g. action sequences, where the source suggests proprioceptive feedback from the last action becomes the next stimulus) is untested |
| Incentive salience is not addressed | The model has no cue-keyed gain, so it does not separate its account from the one `G121` raises |

---

## Open problems

- **Is perseveration the same thing as a habit?** The mechanism is shared, but the time constants are not (limitation 1). The discriminating experiment: does a dorsolateral-striatum lesion that abolishes overtraining habits also remove the per-trial `β_a` kernel?
- **Repetition-only habit induction** (microstimulation, or instructed forced choice with outcomes equalised) is the direct test of the divorce. It also discriminates against incentive salience, which has no reason to grow from unrewarded repetition (`G121`, `T405`).
- **What sets `α_H`, and is it modulated by value?** The source allows value to scale habit *writing*. If it does, the empirical boundary between "value-free" and "value-cached" becomes a question of which term the modulation enters.
- **The union claim is a prediction, not a result.** "No region has a model-free error without a model-based one" is a universal negative. It is also consistent with [[wiki/concepts/amortized-inference.md]]'s reading (Mishchanchuk et al. 2024) that the model-free update runs over a model-based state estimate.

---

## Connections

- **[[wiki/concepts/amortized-inference.md]]** — contests that page's "habitization is the shift to model-free control" row. Here the habit store holds no value, so what gets compiled from the planner is the executed action distribution, not a value table. The omission result is the behavioural wedge: a cached value should learn omission, but habits do not (`T405`).
- **[[wiki/entities/basal-ganglia.md]]** — reinterprets that page's Daw et al. 2005 address. Dorsolateral striatum stays the habit site, but what it stores is action frequency rather than cached value. The model reproduces the dorsomedial/dorsolateral lesion double dissociation with the habit side value-free. The cortical Hebbian models on that page (SPEED) are the closest prior mechanism. The difference is the teacher: those models pair the Hebbian shortcut with a model-free teacher, this one with a model-based teacher.
- **[[wiki/concepts/default-policy-regularization.md]]** — the same distilled default policy, entering behaviour differently. There, `π₀` is distilled from task policies and departure from it is priced by `KL`. Here, `H` is distilled from executed actions and added to the drive under a contingency-gated weight. The two disagree on whether habits come from *pricing* or from *repetition*.
- **[[wiki/concepts/incentive-salience.md]]** — the account `G121` opposes to S–R habit, now faced with a positive S–R definition. The two predict opposite results for unrewarded repetition: it builds `H` but gives the mesolimbic gain nothing to attach to.
- **[[wiki/concepts/reward-prediction-error.md]]** — the source's case against a purely model-free dopamine system (inferred values, counterfactual outcomes, sensory-preconditioning errors) is the same record that page uses against reading 1. Here it is used for a different conclusion: the habit system does not need dopamine's error at run time at all.
