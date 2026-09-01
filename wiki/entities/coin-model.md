# COIN — the COntextual INference model

**A nonparametric Bayesian switching state-space model of motor learning in which memory creation, expression and updating are all read off one posterior over an unbounded set of discrete contexts.** Heald, Lengyel & Wolpert 2021, *Nature* 600:489–493.

Principle and wiki-level consequences: [[wiki/concepts/contextual-inference.md]]. This page carries the model, the experiments and the numbers.

---

## Generative model

| Variable | Type | Dynamics |
|---|---|---|
| `c_t` | context, discrete, `∈ {1,…,∞}` | Markov chain, `c_t ∼ Π_{c_{t−1}}` |
| `x_t^(j)` | state of context `j`, **scalar** | `x_t^(j) = a^(j) x_{t−1}^(j) + d^(j) + ε`, `ε ∼ N(0, σ_q²)`; first-observation prior = stationary distribution |
| `y_t` | state feedback, scalar | `y_t ∼ N(x_t^(c_t), σ_r²)` — emitted by the **active** context only |
| `q_t` | sensory cue, discrete | `q_t ∼ Φ_{c_t}` |
| `ω^(j) = (a^(j), d^(j))` | per-context dynamics params | bivariate normal prior, `a^(j)` truncated to `[0,1]` |

**Priors that make the infinite model well-defined** (hierarchical Dirichlet process, Teh et al.):

| | Construction | Role |
|---|---|---|
| Global transition probs | `β ∼ GEM(γ)` | `γ` sets the effective number of contexts via the decay rate of `β_j` |
| Local transition rows | `π_j ∼ DP(α β + κ δ_j)` — the **sticky** variant | `α` ties each row to the shared `β` (two-level pooling); `κ` biases self-transition, encoding that contexts persist |
| Cue probabilities | `β^e ∼ GEM(γ^e)`, `φ_j ∼ DP(α^e β^e)` — non-sticky | same construction for the cue emission matrix |

Note the row coupling: because every `π_j` has `β` in its base measure, a context that is globally common is transitioned into frequently *from every other context*. That shared term is the model's meta level.

## Inference and read-outs

Exact inference infeasible → **particle learning** (sequential Monte Carlo filtering over `c_t`, `x^(j)`, `ω^(j)`, `β`, `Π`, `β^e`, `Φ`), validated against ground truth.

| Quantity | Conditioned on | Used for |
|---|---|---|
| **Predicted probability** `p(c_t=j ∣ q_t, …)`, `j ∈ {1,…,J,∅}` | cue only (pre-movement) | **expression** |
| **Responsibility** `p(c_t=j ∣ q_t, y_t, …)` | cue + feedback | **creation** (of `∅`) and **updating** (of all `j`) |
| Predicted state `p(x_t^(j) ∣ …)`, mean update | — | `mean_j ← ā^(j)·mean_j + λ_j · k_j · e_j`, with `k_j` the per-context Kalman gain, `e_j` its prediction error, `λ_j` its responsibility |
| Motor output | `u_t = Σ_j p(c_t=j∣q_t,…) · E[x_t^(j)]` | the mean of the mixture predicted-state distribution |

The novel context `∅` is always represented, carrying a stationary state distribution — the model never assumes it has seen every context.

---

## Experiments and results

Reaching movements against a robotic manipulandum; velocity-dependent curl fields `P⁺`/`P⁻`, null field `P⁰`, and **channel trials** `P^c` that clamp the hand to a straight path and read out the force the participant produces (adaptation measured without letting the participant learn from error).

| Experiment | n | Design | Result |
|---|---|---|---|
| **Spontaneous recovery** | 8 | long `P⁺` → brief `P⁻` → channel trials | replicated: transient re-expression of `P⁺` instead of decay to baseline. COIN attributes it to `P⁺` being the most probable context during the channel phase — *no memory changes* |
| **Evoked recovery** (novel prediction) | 8 | as above, but trials 3–4 of the channel phase replaced by `P⁺` "evoker" trials | **strong recovery lasting the rest of the experiment.** Rules out exponential-decay accounts; the dual-rate model predicts only a transient that decays at its own fast rate |
| **Graded updating** | 24 | two cue-paired contexts trained, then channel–exposure–channel triplets with all 4 cue×perturbation combinations | single-trial learning graded across conditions; cue `F(1,23)=10.35, p=3.8×10⁻³`, perturbation `F(1,23)=21.16, p=1.26×10⁻⁴`, no interaction; **no** gradation pre-training (Fisher's exact test rules out that the two effects live in disjoint participant subsets) |

**Model comparison vs. the dual-rate model** (the standard single-context, fast+slow account):

| Comparison | Value |
|---|---|
| Group-level ΔBIC, spontaneous recovery | **302.6 nats** favouring COIN (7 params vs 5) |
| Group-level ΔBIC, evoked recovery | **394.1 nats** favouring COIN |
| Individual participants favouring COIN | 6/8 in each experiment |
| Failure mode of the rival | qualitative mismatch in the *decay time course* of evoked recovery; multi-rate extensions do not fix it |

**Parameter-free reproductions.** Using the 40 participants' fitted parameters from the experiments above, COIN reproduces three literature phenomena it was never fit to — savings, anterograde interference, and the effect of environmental consistency on single-trial learning — and in each case the **Kalman gains and states barely move**: the effect is carried entirely by the context probabilities. Two extras: a working-memory distractor task producing evoked recovery (working memory = maintenance of the context probabilities), and the explicit/implicit split in visuomotor learning (explicit = state inference, implicit = a proprioceptive–visual recalibration bias parameter).

---

## Comparison to related models

| Model | Contexts | Which memories update | Expression | Covers |
|---|---|---|---|---|
| **COIN** | unbounded, inferred, with transitions and cues | **all**, scaled by responsibility | probability-weighted mixture | every dataset in the paper's comparison table |
| Dual-rate / multi-rate | none (single context) | all, at fixed distinct rates | fixed sum | spontaneous recovery; fails evoked recovery |
| Prior contextual models (e.g. modular selection) | present but with no context-transition, cue or state-dynamics model | typically one, winner-take-all | selected memory | hand-tailored subsets |
| [[wiki/entities/hbtom.md]] | agents, fixed set, Dirichlet hyperprior | conjugate posterior per agent | posterior-weighted prediction | theory of mind, hand-written state space |
| [[wiki/entities/neuromatch.md]] | stored graphs, fixed set | none (retrieval only) | deterministic order-embedding test | structural containment queries |

---

## Limitations

- **Scalar state per context.** A memory is one number. Nothing shows the scheme works when a context's content is a graph, a program or a scene.
- **No composition between contexts.** Contexts are exchangeable atoms sharing only a transition prior; there is no factorization letting a new context be described as an edit of an old one.
- **7–8 free parameters fit per participant**, including the granularity hyperparameters `γ`, `α`, `κ`. The knobs that decide how many memories exist are set by the experimenter's fitting procedure.
- **Particle learning, not a neural implementation.** The paper offers the proper/apparent decomposition as a *framework* for studying neural bases, and no circuit.
- **Cue alphabet is given**, and in the experiments a cue is a target location — discovering what counts as a context cue is untouched. Together with the fitted granularity hyperparameters this is `G27`: the discretisation into contexts is what the model is *about*, and both its alphabet and its grain are supplied.
- **Small n** (8, 8, 24) with strong within-participant designs; the model comparison is decisive per-participant for 6/8, not 8/8.

---

## Connections

- **[[wiki/concepts/contextual-inference.md]]** — the principle this model formalises, and where its consequences for the wiki's gaps are worked out.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — the independently-derived hippocampal twin: same nonparametric allocate-vs-reuse logic with a simpler prior (plain Chinese Restaurant Process, no transitions or cues), but with a population read-out that makes posterior *uncertainty* directly observable as partial and rate remapping — the one thing this model can only infer through a fit.
- **[[wiki/concepts/latent-graph-discovery.md]]** — implements the rule-config lifting for hardness source 6: the context variable is a rule reified as a first-class latent with its own Markov dynamics, so a rule change is an ordinary edge in a rule-graph.
- **[[wiki/concepts/event-segmentation.md]]** — supplies the missing granularity control and stopping rule for node creation (`γ`, `κ`, `α` under a sticky hierarchical Dirichlet process) in exchange for a scalar node content (tension T23).
- **[[wiki/concepts/continual-learning.md]]** — responsibility-scaled updating is relevance-gated plasticity: every memory updates in proportion to how much it explains the current observation, with no task boundary and no importance estimate.
- **[[wiki/concepts/working-memory.md]]** — a working-memory distractor task produces evoked recovery, which is the experimental basis for identifying working memory with maintenance of the context probabilities.
- **[[wiki/concepts/meta-learning.md]]** — the hierarchical Dirichlet process instantiates the two-level split as a prior rather than as an optimisation loop: shared `β` across contexts, per-context `π_j`.
- **[[wiki/entities/hbtom.md]]** — the wiki's other hierarchical-Bayes worked instance; both get a two-level hierarchy and one-shot adaptation from an authored prior over a hand-specified state space.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the paper's proper/apparent decomposition is the concrete demonstration that a learning curve is not a measure of learning, which constrains any conversion-rate score read off adaptation data.
- **[[wiki/entities/context-modular-memory-network.md]]** — the complementary half: COIN computes `p(context)` from cues and feedback but each memory holds a single scalar; that model stores a full attractor set per context in one shared weight matrix but takes the context as given, so its `s` maskable landscapes are the structured context library this model's posterior currently indexes with numbers.
- **[[wiki/entities/meta-rl-agent.md]]** — the emergent counterpart of this model's explicit posterior: volatility-dependent learning rates and latent-state clustering appear in recurrent activity trained by reward alone, with no context variable, no prior and no responsibility weights to inspect (Wang et al. 2018).
- **[[wiki/entities/c-ts-model.md]]** — the parametric sibling: a bare Chinese restaurant process over contents that are full stimulus–action maps, against this model's richer prior (stickiness, hierarchical pooling, non-stationarity) over contents that are one number each.
- **[[wiki/entities/neuromatch.md]]** — the deterministic alternative for the same retrieval slot (G37): a one-shot geometric containment test, against this page's sequential and graded posterior over which stored model generates the data.
- **[[wiki/entities/fluxx.md]]** — the domain this model's contribution would have to be run in to address hardness source 6: a rule reified as a latent with Markov transitions is exactly what a player's belief over the live rule set is, and here the transition distribution is a fixed deck and therefore estimable rather than fitted.
- **[[wiki/entities/cn-dpm.md]]** — the same allocate-vs-reuse posterior with a memory scaled from one scalar to a full classifier plus density model, which forces two changes this page's formalism does not carry: allocation must be **deferred** (a network cannot be fit to a single sample, so novel data buffer until there are `M` of them and the new component is then trained offline to convergence), and the responsibility likelihood becomes a *learned* generative model whose discriminability caps the whole system — 48.18% correct retrieval at five components, against per-component storage that forgets 0.0 points.
