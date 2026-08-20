# Neuromodulatory Metaparameter Control

**Every hyperparameter of a learning system is a *global* quantity — it regulates how a large number of ordinary parameters change — so give each one a dedicated diffuse broadcast channel, and close the loop by computing its set-point from second-order statistics of the learner's own signals.**

> **Provenance.** Doya 2002, *Metalearning and neuromodulation*, Neural Networks 15:495–506 (`raw/doya-2002-metalearning-neuromodulation.md`). A theory paper: a mapping from four ascending neuromodulatory systems onto the free parameters of actor–critic reinforcement learning, plus a set of predicted interactions among them. No implementation, no new data.

The framing argument, which is independent of whether the mapping is right: **metaparameters have the same topology as neuromodulators.** `α`, `β`, `γ` each affect the trajectory of every weight in the system; neuromodulators are released from small brainstem nuclei that project diffusely to cortex, striatum and cerebellum. A quantity that must reach everything and address nothing is exactly what a broadcast channel is for. Ordinary parameters get synapses; metaparameters get chemistry.

---

## The mapping

Actor–critic over a Markov decision problem, value `V(s) = E[Σ_k γ^k r(t+k+1)]`, TD error `δ(t) = r(t) + γV(s(t)) − V(s(t−1))`, Boltzmann policy `P(a_i|s) ∝ exp(β Q(s,a_i))`, updates `Δv_j = α δ(t) b_j(s(t−1))`.

| Signal | Slot | Role | Principal evidence cited |
|---|---|---|---|
| **Dopamine** | `δ` | Not a metaparameter — the **global learning signal** itself, shared by critic and actor | Substantia nigra pars compacta / ventral tegmental area firing shifts from reward to predictive cue with learning and dips on omission (Schultz et al. 1993, 1997); stimulation is reinforcing; dopamine *reverses the sign* of corticostriatal plasticity (Reynolds & Wickens 2001) — so Eqs. `Δv`, `Δw` are directly implementable |
| **Serotonin** | `γ` | Discount factor — how far ahead the prediction reaches | Central serotonergic depletion makes rats choose the small immediate over the large delayed reward (Mobini et al. 2000); low serotonin ↔ impulsivity and aggression |
| **Noradrenaline** | `β` | Inverse temperature — randomness of action selection | Locus coeruleus phasic response at stimulus onset predicts response *accuracy* (Aston-Jones et al. 1994); gain models reproduce the accuracy change (Servan-Schreiber et al. 1990; Usher et al. 1999); amphetamine → stereotypy |
| **Acetylcholine** | `α` | Learning rate — storage vs. retention | Cholinergic modulation of plasticity in hippocampus, cortex and striatum; high cholinergic tone = storage mode, low = retrieval mode (Hasselmo & Bower 1993); Meynert-nucleus loss → amnesic syndromes |

**The one non-obvious clinical read.** With `γ` small, a policy whose costs precede its rewards has `V < 0` and is rejected in favour of a zero-reward baseline of doing nothing — so **depression is proposed as a discount-factor pathology, not a reward pathology** (Fig. 7). The reward function is intact; the horizon is too short to see past the cost. A machine analogue is directly testable: an agent whose `γ` is lowered should not become reward-insensitive, it should become *inactive* while still reporting correct immediate values.

---

## The part worth stealing: the metaparameters form a closed loop

The mapping is a taxonomy and would be worth little on its own. What makes the paper load-bearing is that the algebra of the learning rules **forces** relations among the channels, so each set-point becomes a computed function of the agent's own statistics rather than an annealing schedule. Doya's Fig. 9, as control laws:

| Law | Statement | Where it comes from |
|---|---|---|
| **γ → δ** | Serotonin should *facilitate* dopamine when `V(s(t)) > 0` and *inhibit* it when `V(s(t)) < 0` | Read straight off `δ = r + γV(t) − V(t−1)`: `γ` multiplies a signed quantity |
| **Var(δ) → γ** | High variance in dopaminergic activity should **inhibit** serotonin (lower `γ`) | Bias–variance: value estimates learned with `γ → 1` have large variance, and a smaller `γ` buys a biased but low-variance estimate (Baxter & Bartlett 2000; Kakade 2001). The variance is visible in `δ`, so the agent can measure its own horizon feasibility |
| **γ → β, γ → α** | Serotonin should **inhibit** both noradrenaline and acetylcholine | If you are predicting far ahead you must not commit early: a long horizon requires slow learning and continued exploration. This is a *coupling* constraint the wiki has nowhere else — horizon, learning rate and exploration cannot be set independently |
| **V → β** | Noradrenaline rises when `V` is **very high or very low** | Near-optimal performance is degraded by noise; danger removes the leisure to sample. Exploration is scheduled by the value estimate, not by trial count |
| **Var_a Q(s,a) → β** | Noradrenaline falls when the action values at the current state are widely spread | Ishii et al. 2002: state-dependent inverse temperature, so exploration is allocated per-state rather than globally |
| **sign-oscillation of δ → α** | Frequent reversals in the direction of the TD error should **inhibit** acetylcholine | The delta-bar-delta heuristic: oscillating error means the step size is too large |

**(brainstorm) This is a different mechanism from everything on [[wiki/concepts/meta-learning.md]], and cheaper.** The outer-loop formulation needs a task distribution `p(T)`, many episodes, and a gradient (or evolution) through the inner learner; its product is a *fixed* metaparameter setting good on average over `p(T)`. These control laws need none of that: they read `E[δ]`, `Var(δ)`, `sign` reversals of `δ`, `V`, `Var_a Q` — all quantities the agent already computes — and set the metaparameters *within a single lifetime in a single environment*, tracking non-stationarity for free. Metalearning as **feedback control on the learner's own second-order statistics** rather than as an outer optimisation. The two are complementary rather than rival: an outer loop could supply the gains of these laws instead of the metaparameters themselves, which is a far smaller search space and one that transfers across `p(T)` by construction.

**What it costs.** The laws are heuristics with no shared objective — nothing guarantees the four-dimensional loop converges, and three of the six are mutually inhibitory couplings that could oscillate. Doya derives them from separate arguments (bias–variance for `γ`, delta-bar-delta for `α`, performance-dependent annealing for `β`) rather than from one variational principle. The contrast with [[wiki/concepts/precision-weighting.md]] is exact: there, every gain is a `μ^λ` optimised by descent on one free energy, with convergence inherited and biological specificity lost; here, biological specificity is the whole content and convergence is unaddressed.

---

## Where each knob would physically live

Doya's circuit proposals, all within the [[wiki/entities/basal-ganglia.md]] loop and all still untested:

| Knob | Proposed substrate | Status |
|---|---|---|
| `γ` | The **relative strength of the direct vs. indirect pathway** — the indirect contribution supplies the delayed term in the TD computation, so raising it raises the effective discount factor. Serotonin from dorsal raphe reaches both striatum and the dopaminergic nuclei | Untested; the discriminating experiment (serotonergic effect on the two pathways compared) is stated |
| `γ`, alternative | **Selection among parallel loops with different native timescales** — cognitive vs. motor cortico-basal-ganglia loops, amygdala, and cerebellar forward models for long-range prediction — with serotonin differentially enhancing loops via distinct receptor subtypes | Untested |
| `β` | **Chaotic dynamics in globus pallidus** as the noise source: high spontaneous firing plus mutual inhibition gives an asynchronous "roulette wheel", and globus pallidus has relatively high noradrenaline (Russell et al. 1992) | Untested. Notable as a *positive* proposal for where stochasticity comes from — a stable attractor averages channel noise away, so randomness must be generated, not leaked |
| `α` | **Striatal cholinergic interneurons** gating dopamine-dependent corticostriatal plasticity, timed to reward-predicting cues (Aosaki et al. 1994; Partridge et al. 2002); cortically, cholinergic control of the top-down/bottom-up balance keyed to prediction mismatch (Yu & Dayan 2002) | Mechanism partly confirmed since; the *learning-rate* reading is not |

**And a fifth role with no metaparameter attached.** Mesocortical dopamine to prefrontal cortex is proposed to shape the **basis functions** `b_j(s)`, `c_k(s,a)` themselves — which is where a global reward signal buys a task-dependent state representation without backpropagation (Gullapalli 1990; Mazzoni et al. 1991) — and D1-dependent stable working memory is read as *allocating memory capacity to reward-relevant cues*. This is the same signal doing representation learning in one target and parameter updating in another, which the one-modulator-one-parameter slogan does not cover.

---

## Limitations

| Limit | Consequence |
|---|---|
| **The one-signal-one-parameter mapping has counterexamples inside the paper** | Serotonin facilitates striatal dopamine release (Sershen et al. 2000); serotonin-1B knockout and 1B stimulation both enhance cocaine reinforcement; the 5-HT2A receptor facilitates prefrontal working memory just as D1 does (Williams et al. 2002). Doya's escape — one global signal, different effects per receptor and circuit — is the same move that makes the taxonomy hard to falsify at the level it is stated |
| **No implementation** | Not one of the six control laws is run in a simulation in the paper, and the wiki has no architecture that implements any of them |
| **`δ` may not be a prediction error at all** | The signal the whole scheme hangs on is contested ([[wiki/empirical-tensions.md]] T122); dopamine neurons also fire to salient non-rewarding stimuli (Horvitz 2000; Redgrave et al. 1999) |
| **The TD computation is not solved** | The classical proposal (long-latency direct, short-latency indirect striatal input to substantia nigra pars compacta; Houk et al. 1995) requires slow GABA_B transmission that later data contradict — both routes are predominantly fast GABA_A (Paladini et al. 1999). Doya's alternative form of `δ` needs a delay in the globus pallidus externa ↔ subthalamic recurrent circuit instead. Since the `γ` proposal *is* the direct/indirect balance, an unresolved TD circuit leaves the discount-factor hypothesis without a mechanism |
| **Two theories now assign the same balance two different metaparameters** | The direct/indirect ratio is claimed for `γ` here and for `β` by the explore-regime models ([[wiki/empirical-tensions.md]] T133) |

---

## Connections

- **[[wiki/entities/basal-ganglia.md]]** — the circuit every knob is placed in, and the source of the sharpest conflict: this page's `γ` proposal is the direct/indirect balance, the explore-regime models' `β` proposal is the same balance, and that page's own evidence (both pathways co-active during movement, timing rather than level predicting choice) says the balance may not be a scalar at all.
- **[[wiki/concepts/precision-weighting.md]]** — the rival account of the same four chemicals: one computation (precision) in different territories, versus four distinct computations in one broadcast format. The disagreement is not about dopamine alone — it is about whether a metaparameter has a *derivation* (descent on free energy, convergence inherited, specificity lost) or a *control law* (measured from `δ`'s own statistics, biologically specific, convergence unaddressed). T122.
- **[[wiki/concepts/meta-learning.md]]** — the same job done by feedback rather than by an outer loop: no task distribution, no episodes, no gradient through the inner learner, and the setting tracks non-stationarity within one lifetime. The natural composition is to meta-learn the *gains* of these control laws rather than the metaparameters themselves.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — supplies the one metaparameter that page's outer loop always searches for offline (`α`, the rule's step size) with an online estimator instead: oscillation in the sign of the global error signal lowers the learning rate, computed from the same scalar the rule already consumes.
- **[[wiki/concepts/synaptic-plasticity.md]]** — where the third factor's *magnitude* comes from: this page separates the third factor's value (`δ`, dopamine) from the rate at which it is applied (`α`, acetylcholine) and puts them on different wires, so a rule can be told "this much error" and "learn this fast" independently.
- **[[wiki/concepts/simulation-based-planning.md]]** — makes the planning horizon a *regulated* quantity rather than a chosen one: `γ` is set by the measured variance of the value estimate, so an agent lowers its own horizon exactly when its long-range predictions have stopped being reliable — a computable answer to gap G24 that needs no lifetime estimate.
- **[[wiki/concepts/cognitive-control.md]]** — the exploration and gain knobs read as control outputs: `β` rising at extreme values of `V` is a controller deciding when deliberation is over, and it is set by the value estimate rather than by conflict.
- **[[wiki/concepts/dynamic-network-connectivity.md]]** — the biological register that `β` would be written into: noradrenergic and cholinergic spine-local gain control is the substrate a broadcast inverse temperature acts on, and this page supplies the missing set-point rule for it (gap G56).
- **[[wiki/entities/pbwm.md]]** — the wiki's implemented model of this circuit and the contrast case: its `Random Go` is a hand-set `p = .1` external schedule, which is exactly the `β` these control laws compute from `V` and `Var_a Q(s,a)` (gap G61).
- **[[wiki/entities/meta-rl-agent.md]]** — the same phenomenon (an emergent learning rate that rises in volatile blocks) obtained without any metaparameter channel: recurrent dynamics trained over a task series produce the adaptive rate as a side effect, where this page routes it through a dedicated chemical. Two mechanisms, one measurement, and the meta-RL version is the only one implemented.
- **[[wiki/concepts/continual-learning.md]]** — the storage/retention trade-off named as a single scalar with a substrate: the cholinergic storage-vs-retrieval mode switch is the stability–plasticity dial, set here by the error signal's own oscillation rather than by an importance penalty.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the metaparameters are the search's control surface: `γ` sets how far along the graph the value signal propagates, `β` sets whether the walk commits or samples, and `α` sets how fast an observed edge is written — so all three are properties of the *traversal*, not of the graph, and only this page proposes setting them from the traversal's own statistics.
- **[[wiki/concepts/amortized-inference.md]]** — gives those uncertainty signals a job beyond setting learning rate: if the choice between a model-based and a model-free valuation is made by comparing posterior variances, then a cholinergic/noradrenergic uncertainty estimate is not a metaparameter but the *arbitration variable itself* (Daw et al. 2005).
- **[[wiki/concepts/evidence-accumulation.md]]** — a metaparameter this page's four-chemical taxonomy does not list: the decision threshold, which sets the speed–accuracy trade-off and is proposed to be carried by *tonic* dopamine rather than by any phasic signal. Its companion parameter, the integrator gain, is the one metaparameter in the wiki that provably does not need regulating — too high costs nothing (Bogacz & Gurney 2007).
- **[[wiki/concepts/subjective-value.md]]** — the same knob measured at the other end of the pipe, and the regime where this page's control law has nothing to do: the discount is already folded into the value signal at choice time, the rate is *idiosyncratic* (238× spread across ten subjects, and fitting one population rate destroys the effect in ventral striatum and posterior cingulate), and it does not move across sessions separated by up to six months on a stationary task (Kable & Glimcher 2007). It also constrains the functional form — the fitted kernel is hyperbolic, not the `γ^k` this page's actor–critic assumes (T141).
