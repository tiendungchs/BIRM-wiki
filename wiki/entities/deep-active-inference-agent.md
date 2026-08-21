# Deep Active Inference Agent

**Active inference scaled by replacing every distribution with a neural network — encoder, decoder, transition, critic, policy — built up one network at a time, so that each component's contribution to solving a task can be measured separately. Built that way, the epistemic term is the component that breaks it.**

> **Primary source.** `raw/champion-2023-deconstructing-deep-active-inference.md` — Champion, Grześ, Bonhême & Bowman, *Deconstructing deep active inference*, 2023. Two halves: a review of eight published deep active-inference (DAI) implementations, and a from-scratch ablation ladder (VAE → HMM → CHMM → DAI) × 5 expected-free-energy definitions × 3 action-selection rules, all on one environment, with a deep Q-network as the control. Code released; several reviewed systems could not be reproduced or had no code.

This is the wiki's **implementation** entry for [[wiki/concepts/expected-free-energy.md]]. That page holds three 2026 theory sources that classify the objective, identify it with a ρ-POMDP, and decompose it into entropy corrections. This page holds what happens when the objective is handed to five neural networks and a replay buffer, and the answer is that the only variants that work are the ones with the epistemic term deleted.

---

## The ladder

Each row adds exactly one network to the row above; everything else is held fixed (same replay buffer, same 500K iterations, same environment).

| Agent | Networks | Prior over actions | Objective | dSprites cumulative reward (500K it.) | World model |
|---|---|---|---|---|---|
| **DQN** (control) | Q-network + target net | ε-greedy on `Q(o,a)` | MSE to `y = r + γ max_a Q̂(o',a')` | **≈ +50K** | none |
| **VAE** | encoder `E_φs`, decoder `D_θo` | random actions | VFE `= D_KL[Q_φs(s_t)‖P(s_t)] − E[ln P_θo(o_t\|s_t)]` | ≈ −7K (= random baseline) | reconstructs single frames |
| **HMM** | + transition `T_θs` | random actions | VFE with the prior replaced by `P_θs(s_t\|s_{t−1},a_{t−1})` | ≈ −7K | **best in the paper** — generates clean action-conditioned sequences |
| **CHMM** | + critic `G_θa` | `P_θa(a_t\|s_t) = σ[−ζ G_θa(s_t,·)]` | VFE + smooth-L1 of critic to a **Bellman backup on EFE**: `y(a_t) = G_{t+1}(a_t) + γ E max_a Ĝ(s_{t+1},a)` | solves the task **only** with `G⁴` (reward-only) | degraded |
| **DAI** | + policy net `Q_φa(a\|s)` (posterior over actions) | as above, with the policy amortising it | VFE + critic loss + policy loss | **never solves it**; 14 of 15 configurations diverged to `NaN` | good reconstruction, no task |

The ladder's own result is the first finding: **task competence and model quality move in opposite directions.** The HMM taking uniformly random actions learns the environment's dynamics almost perfectly and scores at chance; the reward-maximising CHMM solves the task and predicts the environment noticeably worse. Random play is the best data-collection policy for model learning and the worst for reward, and nothing in the objective arbitrates between them.

---

## The five expected-free-energy definitions

Estimated at `τ = t+1` (one-step; the policy is a single action), with `Q(s_{t+1}|a_t) ≈ P_θs(s_{t+1}|s_t = ŝ_t, a_t)`, `ŝ_t ∼ Q_φs(s_t)`, and prior preferences `ln P(o_τ) = ψ r_τ + C`:

```
G   = D_KL[ P_θs(s_{t+1}|ŝ_t,a_t) ‖ Q_φs(s_{t+1}) ]        − ψ r_{t+1}     "principled"
G¹  = H[Q_φs(s_{t+1})] − H[P_θs(s_{t+1}|ŝ_t,a_t)]          − ψ r_{t+1}
G²  = H[P_θs(s_{t+1}|ŝ_t,a_t)] − H[Q_φs(s_{t+1})]          − ψ r_{t+1}
G³  = D_KL[ Q_φs(s_{t+1}) ‖ P_θs(s_{t+1}|ŝ_t,a_t) ]        − ψ r_{t+1}
G⁴  =                                                       − ψ r_{t+1}     reward only
```

`G⁴` makes the critic a Q-network over latent states rather than observations; it is the ablation, and it is the only one that ever solves the task.

| Action selection | Which agents solve dSprites |
|---|---|
| ε-greedy with exponential decay | DQN, and **CHMM[`G⁴`] only** — but slower than DQN, because it must learn the dynamics as well as the task |
| Softmax on `−ζG` | **none** (DQN aside). Critic outputs sit close together, so sampling ≈ random |
| argmax (best action per critic) | DQN, and **CHMM[`G⁴`] only**; worse than ε-greedy — no exploration source at all |

`G¹` additionally destabilised training: VFE went `NaN` at ~270K iterations.

---

## Why the epistemic term collapses behaviour

The mechanism is identified, not merely observed. The only difference between CHMM[`G`] and CHMM[`G⁴`] is the term `D_KL[P_θs(s_{t+1}|ŝ_t,a_t) ‖ Q_φs(s_{t+1})]`, which is **minimised**. That term is small when the transition network and the encoder agree — i.e. when the agent's forward model predicts its own posterior well. An agent can achieve that trivially by **restricting its own data distribution**:

1. Pick one action repeatedly (`down`).
2. Become an expert at predicting that action's consequences; the KL falls to ~0.
3. In dSprites `down` also has expected reward 0 while every other action has negative expected reward, so the degenerate solution is simultaneously the least costly single action.

Measured: the entropy of the prior over actions converges to zero, the action histogram is almost entirely `down`, and the transition network's variance layer is low-variance **only for `down`** — high for `up`, `left`, `right`, which the agent never gathered data for. CHMM[`G⁴`] instead keeps selecting `left`/`right` (the actions that actually drag the shape across the image) and keeps its action-prior entropy well above zero.

**(brainstorm) The sign is the diagnosis.** A self-consistency penalty between a *prior-predictive* and a *posterior* is exactly what an agent minimises by never being surprised, and never being surprised is achievable by never doing anything new — the dark-room objection, arrived at empirically rather than as a thought experiment. The information-gain reading of the epistemic term requires the divergence to be *rewarded* (`E_o D_KL[Q(s|o,π) ‖ Q(s|π)]`, entering `G` with a minus). Somewhere between the Parr & Friston decomposition and the deep estimator the term changes from a bonus for expected belief change to a penalty for model–encoder disagreement, and that is a sign convention, not a modelling choice. Any implementation should be checked by asking whether an agent that freezes its own policy can drive its epistemic term to zero; if it can, the term is a self-consistency penalty.

**The tabular confirmation (Section 5).** With `EV = E_{P(o|s)Q(s|π)}[ln P(s_τ|o_τ) − ln Q(s_τ|π)]` stored as explicit matrices, two experiments give opposite signs:

| Experiment | What varies | Effect on `EV` | Reading |
|---|---|---|---|
| 1 | likelihood `P(o\|s)` → uniform, prior fixed | `P(s\|o)` approaches `Q(s\|π)`, `EV` **decreases** | correct — maximising `EV` seeks informative observations |
| 2 | likelihood fixed at high entropy, prior `P(s)` shifted | `P(s\|o)` diverges from `Q(s\|π)`, `EV` **also decreases** | degenerate — maximising `EV` now *destroys* information |

So the standard epistemic/extrinsic decomposition (Parr & Friston 2019, eq. 10) is not a single behaviour: its exploratory reading depends on which distribution is the one moving. Every deep implementation that inherits that equation inherits the ambiguity.

---

## Two conceptual defects in the deep estimator

- **`Q(s_{t+1}|a_t)` is estimated from the generative model, not the variational one.** For EFE to be the expectation of VFE, `Q(s_{t+1}|a_t)` must be a factor of the variational distribution; deep implementations (including Fountas et al. 2020) substitute the Monte-Carlo estimate `1/N Σ_i P_θs(s_{t+1}|ŝ_t^i, a_t)`, a factor of `P`. If that identification fails, an agent minimising EFE is not thereby minimising VFE, and the free-energy-principle justification for the planning objective does not transfer to the deep case.
- **The tabular derivation assumes `P(o_τ, s_τ)` is the generative model.** Under the POMDP the paper actually uses, `s_τ` depends on `s_{τ−1}` and `a_{τ−1}`, so `P(o_τ, s_τ)` is better read as a *target* distribution encoding preferences than as the generative model — which is where the equivalence is lost.

---

## Representational analysis (linear CKA)

`CKA(x,y) = ‖yᵀx‖²_F / (‖xᵀx‖_F ‖yᵀy‖_F)` on centred layer activations over 5K examples — the RV-coefficient, a normalised Hilbert–Schmidt independence criterion. Compares layers within and across models with no shared units. Caveat used by the authors: CKA is over-sensitive to architectural differences (convolutional vs. linear), so only *variations* in similarity are compared, never absolute values across layer types.

| Comparison | Result |
|---|---|
| DQN internally | first three layers near-identical (CKA ≈ 1), fourth diverges, last two highly specialised (≈ 0) |
| VAE / HMM encoder vs. DQN | early layers similar; last two diverge — the learning objective shows up only at the top |
| HMM vs. VAE encoder | mean and variance layers differ → **the transition network reshapes the latent code**, not just the dynamics |
| CHMM[`G⁴`] vs. CHMM[`G`], argmax selection | **near-identical everywhere except** the critic's last layer (objective difference) and the **variance layers** of transition and encoder |
| CHMM[`G⁴`] vs. DQN, ε-greedy | reward-maximising critic is closer to DQN's last layers than the EFE critic is — but still CKA < 0.4 |

**The methodological finding is where the signal was.** Two agents whose behaviour differs completely — one solves the task, one emits a single action forever — are representationally indistinguishable across almost every layer. The difference lives in the *variance* head of a Gaussian output layer, a site no standard probing pipeline inspects, and it is legible only because the distribution of that unit's activations was plotted **per action**. See [[wiki/concepts/representation-probing.md]].

---

## The reviewed implementations

Eight prior systems, with the recurring complaint that the definition of EFE differs between them:

| System | Contribution kept |
|---|---|
| `DAI_MC` (Fountas et al. 2020) | Monte-Carlo tree search for planning; the bootstrapped-EFE critic |
| `DAI_VPG` (Millidge 2020) | EFE as variational policy gradient |
| `DAI_RHI` (Rood et al. 2020) | rubber-hand illusion as an active-inference phenomenon |
| `DAI_HR` (Sancaktar et al. 2020; Lanillos et al. 2020) | humanoid body control from pixel-level free energy |
| `DAI_FA` (Ueltzhöffer 2018) | free-action objective, evolution-strategies optimiser |
| `DAI_POMDP` / `DAI_SSM` (van der Himst & Lanillos 2020; Çatal et al. 2020) | deep state-space models under partial observability |
| Schneider et al. 2022 | active exploration for robotic manipulation (no code) |

Reproduction failed for some claims (e.g. `DAI_MC` on Animal-AI); code was unavailable for others. **No complete deep active-inference agent had been published**, which is the paper's framing claim and the reason the ladder was built.

---

## Limitations of this evidence

- **One environment.** dSprites with four translation actions, 500K iterations, shaped so that `down` is the zero-reward action — the degenerate fixed point is partly a property of this reward layout, even though the KL-collapse mechanism is not.
- **Horizon 1.** All five EFE definitions are one-step estimates. Every theoretical result that makes the epistemic term pay ([[wiki/concepts/expected-free-energy.md]]) needs depth — Cooper & Velasquez report `H = 1` degenerating to myopic information gain, and Nuijten et al.'s novelty term is defined over a rollout. This is arguably the largest confound in the paper: it may be testing shallow EFE rather than EFE.
- **The epistemic term here is over *states*, and over the model's own agreement with itself.** The parameter-novelty term that the wiki's ablation evidence says carries nearly all the benefit ([[wiki/empirical-tensions.md]] T124) is absent from all five definitions.
- **No tree search.** Planning is a one-step critic with a Bellman backup, so the paper is not testing the MCTS-based implementations it reviews on their own terms.

---

## Connections

- **[[wiki/concepts/epistemic-value.md]]** — the page this agent's ablation is the central negative result for: five one-step estimators × three action-selection rules, and the only configurations that solve the task are the ones with the epistemic term deleted, by a named mechanism (a self-consistency divergence an agent can zero by freezing its own policy).

- **[[wiki/concepts/expected-free-energy.md]]** — the implementation counterweight to that page's three theory sources: written as five different one-step neural estimators and run against a matched reward-only ablation, the epistemic term never pays and in one form collapses the policy to a single action, so the objective's derivation and its estimator are separately fallible.
- **[[wiki/concepts/expected-free-energy.md]]** — and the estimator defect that breaks the derivation: deep implementations compute `Q(s_{t+1}|a_t)` from a factor of the *generative* model rather than the variational distribution, so the deep agent's expected free energy is not the expectation of its variational free energy and the free-energy-principle justification does not carry over.
- **[[wiki/concepts/representation-probing.md]]** — supplies the linear-CKA instrument and the wiki's clearest case of a probe finding nothing where the whole behavioural difference lies: two agents with opposite policies match on every layer except a Gaussian *variance* head, whose activations had to be split by action before the collapse became visible.
- **[[wiki/concepts/simulation-based-planning.md]]** — the exploration/model-quality conflict stated with numbers: the agent that learns the transition structure best is the one taking uniformly random actions and scoring at chance, and the agent that solves the task predicts the environment worse — so a control policy over simulation (G15) also has to be a data-collection policy for the model it simulates on.
- **[[wiki/concepts/divergence-objectives.md]]** — the direction of the KL is load-bearing at the level of behaviour, not just of fit: `D_KL[P_θs ‖ Q_φs]`, `D_KL[Q_φs ‖ P_θs]` and the two entropy differences between them are four defensible readings of "epistemic value" that give four different agents, one of which diverges to `NaN`.
- **[[wiki/concepts/objective-identifiability.md]]** — the reproducibility form of the same problem: eight published systems all called deep active inference optimise measurably different objectives, and some cannot be re-run at all, so "this architecture implements active inference" is not currently a checkable claim about code.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a concrete failure mode for a discovery agent: an epistemic drive defined as agreement between the agent's forward model and its own encoder is minimised by shrinking the visited part of the graph, which is the exact opposite of the edge-coverage drive discovery needs.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the ladder's lower rungs are that page's objective made concrete (VAE = VFE with a fixed isotropic prior, HMM = VFE with a learned action-conditioned prior), and they show the perception half working cleanly on its own: both minimise VFE and reconstruct well while doing nothing useful.
- **[[wiki/entities/h-jepa.md]]** — the same five-module inventory (encoder, world model, cost, actor, critic) with the cost hand-designed rather than derived; this page is evidence for that choice, since the derived cost is what fails here.
