# FeUdal Networks (FuN) — Subgoals as Directions in a Latent Space the Manager Invents

**Split the agent into a Manager that emits a unit vector `g_t` in a latent state space it learns for itself, and a Worker that is paid an intrinsic reward for making the shared latent state actually move in that direction. No gradient crosses between them: the Manager is trained against the environment's return by a *transition* policy gradient (a gradient with respect to a model of where the Worker will end up), the Worker against `R + αR^I`. The subgoal vocabulary is neither symbolic, nor a state, nor a bottleneck — it is a **direction**, which is what makes one subgoal reusable across a large part of the state space.**

> **Provenance.** Vezhnevets, Osindero, Schaul, Heess, Jaderberg, Silver & Kavukcuoglu 2017, *FeUdal Networks for Hierarchical Reinforcement Learning*, ICML 2017 / arXiv:1703.01161 (`raw/vezhnevets-2017-feudal-networks-hierarchical-reinforcement-learning.md`). A3C training, Atari suite plus four DeepMind Lab memory levels, with a five-way ablation. Everything below is from that source unless marked. Builds on Dayan & Hinton's feudal reinforcement learning (1993), not ingested.

The tenth option-discovery family on [[wiki/concepts/temporal-abstraction-options.md]] and the **own-channel pole** of `T367`, paired against [[wiki/entities/option-critic.md]]'s single-channel pole.

---

## Forward dynamics

| Stage | Equation | Note |
|---|---|---|
| Shared perception | `z_t = f^percept(x_t)` | CNN (16×8×8/4, 32×4×4/2) + 256-unit dense; **one** perceptual module for both levels |
| Manager's own latent space | `s_t = f^Mspace(z_t)` | A further dense+ReLU layer. The space the goals live in is *learned by the Manager*, not given |
| Manager | `h^M_t, ĝ_t = f^Mrnn(s_t, h^M_{t−1})`; `g_t = ĝ_t/‖ĝ_t‖` | `f^Mrnn` is a **dilated LSTM**; the goal is a unit vector — a direction, not a location |
| Goal pooling + embedding | `w_t = φ(Σ_{i=t−c}^{t} g_i)` | Sum of the last `c` goals, then a linear `φ : R^d → R^k`, `k = 16`, **with no bias** |
| Worker | `h^W, U_t = f^Wrnn(z_t, h^W_{t−1})`, `U_t ∈ R^{|a|×k}` | Standard LSTM, 256 units; one `k`-vector per primitive action |
| Policy | `π_t = SoftMax(U_t w_t)` | The goal enters **multiplicatively**, not as a concatenated input |

**The bias-free `φ` is a wiring-level anti-bypass device.** With no bias term `φ` can never emit a constant non-zero vector, and a constant `w` is the only way the Worker could factor the Manager out of `U_t w_t`. So the goal channel is made non-ignorable *by the algebra of the interface*, rather than by an auxiliary loss — the first instance in the wiki of the `G59` prescription being met by construction rather than by information-hiding. Pooling over `c` steps additionally makes the conditioning vary smoothly, so the Worker's context does not jump at option boundaries the way a call-and-return option does.

---

## The two learning rules, and why they are not one

| Level | Rule | Reward |
|---|---|---|
| Manager | `∇g_t = A^M_t ∇_θ d_cos(s_{t+c} − s_t, g_t(θ))`, `A^M_t = R_t − V^M_t` | Environment only. `d_cos` = cosine similarity; the dependence of `s` on `θ` is **ignored** when differentiating, to avoid the trivial solution of moving the space instead of the agent |
| Worker | `∇π_t = A^D_t ∇_θ log π(a_t\|x_t)`, `A^D_t = R_t + αR^I_t − V^D_t` | `r^I_t = (1/c) Σ_{i=1}^{c} d_cos(s_t − s_{t−i}, g_{t−i})` **plus** the environment reward |

**No gradients flow between Worker and Manager.** Training the whole differentiable stack end-to-end is possible and is exactly what the paper refuses: it "would deprive the Manager's goals of any semantic meaning, making them just internal latent variables". The decoupling is what buys `g` an interpretation — *an advantageous direction in latent state space at horizon `c`*.

**Transition policy gradient (the paper's core derivation).** For a high-level policy `o_t = μ(s_t,θ)` selecting fixed-duration (`c`-step) sub-policies, each sub-policy induces `p(s_{t+c}|s_t,o_t)`; composing gives a *transition policy* `π^TP(s_{t+c}|s_t)`, and the original MDP is isomorphic to one whose transition function *is* `π^TP`. The policy gradient theorem then applies directly:

`∇_θ π^TP_t = E[(R_t − V(s_t)) ∇_θ log p(s_{t+c} | s_t, μ(s_t,θ))]`

Assume the direction `s_{t+c} − s_t` is von Mises–Fisher with mean direction `g_t`, i.e. `p(s_{t+c}|s_t,o_t) ∝ e^{d_cos(s_{t+c}−s_t, g_t)}`, and the Manager update above *is* that gradient. The move worth carrying: **the Manager never learns from the Worker's trajectories, only from a model of where they end up** — sub-policy execution is skipped over analytically instead of sampled through. And the Worker's intrinsic reward is the log-likelihood of the state trajectory under that same model, so the architecture *enforces the assumption it makes*: the Worker is paid to make the transition model true.

Manager and Worker may carry different discounts — `0.999` vs `0.99` on Montezuma's Revenge — so the levels differ in horizon as well as in rate.

### Dilated LSTM (`L3`)

State `h = {ĥ^i}_{i=1..r}`; at step `t` only group `t mod r` is updated: `ĥ^{t%r}_t, g_t = LSTM(s_t, ĥ^{t%r}_{t−1}; θ^LSTM)`, one shared parameter set, output pooled over the last `c` outputs. `r = c = 10`. Unlike a clockwork RNN the slow level still *observes every frame*; only its memory is partitioned. This is what permits BPTT over **400** steps where the LSTM baseline degrades at 100.

---

## Results

| Domain | Result |
|---|---|
| **Montezuma's Revenge** | Solves room 1 in <200 epochs and immediately explores on, to ~2600 points; LSTM baseline takes >300 epochs to reach 400 and stagnates there until ~900. The learned subgoals are interpretable **waypoints** — two of them land at roughly the locations (ladder, key) that Kulkarni et al. hand-crafted |
| **Atari** | Beats LSTM strongly on Ms. Pac-Man, Amidar, Gravitar (long-horizon games) and Enduro (no reward until an overtake); ×7 on Frostbite; loses to a greedy `γ = 0.95` LSTM on Seaquest and Breakout, and to LSTM on Alien |
| **vs. Option-Critic** (4 games) | Similar on Seaquest, **×2** Ms. Pac-Man, **×3** Zaxxon, **×20** Asterix — with FuN's score still rising where Option-Critic's plateaus. *Caveat the paper states itself:* Option-Critic was compared against DQN, FuN against a stronger A3C-LSTM baseline |
| **DeepMind Lab memory** (water maze, T-maze, T-maze+, non-match) | FuN beats LSTM on all four, faster and higher-asymptote. The LSTM agent "doesn't appear to use its memory" in water maze at all — it circles at a fixed radius |
| **Sub-policy inspection** (Seaquest) | Freeze a sampled `g` as constant conditioning and average the agent's position: sub-policies occupy distinct regions of playable space; sub-policy 3 *is* "swim up for air" |
| **Action-repeat transfer** | Transfer a repeat-4 agent to repeat-1 by adjusting discounts, dilation `r` (×4) and horizon `c` (×4) — nothing else. Transferred FuN beats every other method **on every environment**; the transferred LSTM shows positive transfer only on Ms. Pac-Man |

The transfer result is the load-bearing one for a builder: the Manager's transition policy is **invariant to embodiment**, because it is stated in latent state transitions rather than in actions. Re-embodying the agent means re-learning the Worker and re-timing three temporal constants.

---

## Ablations — what each design choice is worth

| Ablation | Outcome |
|---|---|
| **Non-feudal** (`g` trained by gradients from the Worker, no intrinsic reward — i.e. Option-Critic-style coupling) | Works "to some degree", significantly inferior |
| `g` trained by standard policy gradient (Manager emits a Gaussian mean, goals sampled) | Significantly inferior |
| **Absolute goals** instead of directional | Significantly inferior |
| **Purely feudal** (Worker trained on intrinsic reward *alone*, Dayan & Hinton's reward concealment) | Better than the other three ablations, **still worse than full FuN** — "allowing the Worker to experience the external reward is beneficial" (`T401`) |
| **No dilation** in the Manager | **Catastrophic failure** — "most likely overwhelmed by the recurrent gradient" |
| **Horizon `c = 1`** | Hurts, but *less than the other ablations* — even at full temporal resolution the Manager captures structure worth communicating |
| **dLSTM alone** as a flat agent (no Manager/Worker split) | Underperforms both LSTM and FuN — the dilation is only useful *in a slow level* |
| **Intrinsic weight `α ~ U(0,1)`** | Score correlates with high `α` on Gravitar and Amidar; optimal `α < 1` elsewhere. The first measured value of the wiki's `r̃` : `r` ratio |

The `c = 1` row is the surprising one: it says most of FuN's benefit comes from **training two levels under two different objectives**, not from temporal extension. Under `c = 1` the Manager still emits a direction and is still trained by the transition gradient; what it loses is only the temporal gap. That reframes hierarchy's payoff as *objective decomposition* rather than *time decomposition* — and it is the ablation nobody in the option literature runs, because options with `β ≡ 1` are not options at all.

---

## Against Option-Critic — the routing question, both poles built

| | **FuN** (own channel) | **[[wiki/entities/option-critic.md]]** (single channel) |
|---|---|---|
| Rewards in the architecture | 2 — `r` and `r^I_t` | 1 — `r(s,a)` |
| `r̃` : `r` ratio | `α`, swept over `[0,1]`, **domain-dependent optimum** | no referent |
| Subgoal vocabulary | unit directions in a **learned** latent space `s = f^Mspace(z)` | none — options are policies with no named target |
| What the lower level receives | pooled goal `w_t` ⊗ its own action embeddings, **plus** the raw observation `z_t` | the observation; option identity indexes the critic |
| Gradient between levels | **severed** | the only coupling there is |
| Granularity | set by `c` and by the dLSTM dilation `r` (hard-wired constants) | collapses to `β → 1` unless bribed with `ξ = 0.01` |
| Subgoal capture ([[wiki/concepts/conditioned-reinforcement.md]]) | **possible in principle** — the Worker is paid for direction-following whether or not it pays; bounded only by `α < 1` and by the Worker also seeing `r` | impossible by construction |
| Degeneracy it must patch | none reported; goals stay diverse because they are directions | options shrink to primitives; policies go deterministic |
| Emitted goals when the Manager is uninformative | `ε`-probability random Gaussian goal for transition-policy exploration | `ε`-greedy over `π_Ω` |

**(brainstorm)** The two papers agree on the diagnosis and split on the cure. Option-critic's collapse (`β → 1`) and FuN's refusal to backpropagate between levels are the *same* observation: a hierarchy trained by one objective has no reason to stay a hierarchy, because the lower level can always absorb the upper level's job. Option-critic pays a scalar (`ξ`) to prevent that; FuN cuts the wire that would allow it. The wire-cut is the stronger move, and the price is exactly `T367`'s: a second reward whose gain `α` nothing derives.

**(brainstorm)** FuN's directional goal is the wiki's cheapest answer to "what is a subgoal made of". A bottleneck needs a graph; a goal image needs an encoder and a distance; a symbol needs a vocabulary. A unit vector in a learned latent space needs only that the space be *smooth enough for cosine similarity to mean something* — and the Worker's intrinsic reward is what makes it so, since a space in which the Worker cannot reliably cause directional shifts pays the Worker nothing. The representation and the controller co-train into mutual usability, which is a mechanism [[wiki/concepts/latent-graph-discovery.md]] has no other instance of: the latent geometry is shaped by *what is steerable*, not by what is predictable.

---

## Limitations

| Limitation | Consequence |
|---|---|
| **`c` and `r` are hard-wired constants** (10 each) | The wiki's granularity question is not answered, only relocated from `β` to two integers. The action-repeat transfer shows they must be *rescaled by hand* when the agent's clock changes |
| **Two levels only** | Deeper hierarchies are named as future work ("goals at multiple time scales") and never built — again no option-of-options |
| **The Worker sees the full observation** | `G59` is violated in the standard way; the bias-free `φ` mitigates bypass at the *policy* layer but the Worker's LSTM still receives `z_t` |
| **The transition model is assumed, not learned** | von Mises–Fisher with mean `g_t` is imposed; its validity rests on the Worker's compliance, which is trained but never measured |
| **`α` unset** | Swept as a hyperparameter with a game-dependent optimum; nothing derives it |
| **Manager goals are never grounded or inspected online** | Interpretability comes from post-hoc procedures (maximise `cos(s_{t′}−s_t, g_t)` over future states; freeze a goal and watch) — the agent itself never reports what a goal means |
| **No termination condition at all** | The Manager re-emits every step and the Worker pools; there is no commitment, so nothing can be *interrupted*, and the SMDP machinery of the options framework does not apply |

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| `s = f^Mspace(z)` | A latent space with no requirement that it be a *graph*; only that displacement in it is (a) causable by the Worker and (b) predictive of return |
| `g_t` | Not a node, not an edge — a **tangent vector**. The wiki's only subgoal representation that does not presuppose discrete structure |
| Transition policy `π^TP` | The quotient MDP at horizon `c`, learned directly without ever building its transition table |
| Worker | The thing that makes the quotient well-defined, by making `p(s_{t+c}|s_t,g)` concentrate |
| Doorway/waypoint subgoals in Montezuma | Bottleneck-like structure recovered a third time (after [[wiki/entities/cscg.md]]'s partitions and option-critic's terminations) from yet another objective — which weakens the claim that any one discovery principle owns bottlenecks |

---

## Connections

- **[[wiki/concepts/temporal-abstraction-options.md]]** — the tenth discovery family and the one that abandons the `⟨I, π_o, β⟩` object entirely: no initiation set, no termination condition, no commitment, just a continuously re-emitted direction with a pooling window. It supplies that page's granularity problem with a second relocation (into `c` and the dilation `r`) and an ablation that undercuts the page's premise — `c = 1` hurts far less than removing the second objective, so temporal extent may be the lesser half of what hierarchy buys.
- **[[wiki/entities/option-critic.md]]** — the paired opposite on `T367` and the direct head-to-head: FuN severs the inter-level gradient and pays the Worker a second reward, option-critic makes the inter-level gradient the whole mechanism and pays nothing; FuN's own "non-feudal" ablation *is* option-critic-style coupling and is significantly inferior on the same games (×20 on Asterix, ×3 Zaxxon, ×2 Ms. Pac-Man), against a stronger baseline than option-critic was measured with.
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — the machine instance of that page's measured signal, with the ratio it flagged as unasked actually swept: `r^I_t` is a pseudo-reward against a *self-invented* subgoal, and `α ~ U(0,1)` is the `r̃` : `r` ratio, whose optimum is domain-dependent (high on Gravitar and Amidar, below 1 elsewhere) rather than `1` : `1` by fiat.
- **[[wiki/concepts/conditioned-reinforcement.md]]** — the architecture most exposed to that page's failure mode and the one that manages it by dilution: the Worker is paid for direction-following regardless of whether the direction pays, so subgoal capture is available in principle, and the only things preventing it are `α < 1` and the Worker's retained access to the environment reward — which is precisely what the "purely feudal" ablation removes, and it performs worse (`T401`).
- **[[wiki/concepts/policy-abstraction-hierarchy.md]]** — the machine hierarchy this page's biological result was written against, with one design that meets its prescription halfway: `π = SoftMax(U_t w_t)` with a bias-free `φ` makes the goal channel algebraically non-ignorable, which is non-bypassability enforced by *wiring* rather than by a loss — while the Worker's LSTM still receives the same observation `z_t` the Manager saw, so `G59` holds.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a subgoal representation that needs no graph at all: a unit direction in a learned latent space, with the space shaped by *what the Worker can reliably cause* rather than by what is predictable — the framing's only instance of a latent geometry co-trained into steerability.
- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — a competence-style intrinsic reward with the goal space discovered rather than enumerated: `r^I` scores achievement of a self-set *direction* at horizon `c`, so the goal distribution is a learned continuous manifold instead of a list of target states, and the achievement measure is graded (cosine) rather than binary.
- **[[wiki/concepts/hindsight-goal-relabelling.md]]** — the comparison neither literature runs: both manufacture dense signal against a goal the environment never named, one by relabelling what was reached, one by paying for movement toward what was asked; FuN's directional goals are always partially achieved (cosine is graded), so it needs no relabelling trick to avoid the all-or-nothing sparsity that motivates HER.
- **[[wiki/concepts/cross-embodiment-transfer.md]]** — a clean mechanism for body-independence at the top level: the Manager's transition policy is stated in latent state displacements, so changing the agent's action repeat requires rescaling three temporal constants and re-learning only the Worker — transferred FuN shows positive transfer on *every* environment where the transferred LSTM manages one.
- **[[wiki/entities/dqn.md]]** — the shared substrate and the distant baseline: FuN uses the same convolutional front end and A3C rather than Q-learning, and the paper's central methodological point against option-critic is that its own baseline (A3C-LSTM) is much stronger than DQN, so hierarchical gains reported against DQN are not commensurable with these.
- **[[wiki/entities/cscg.md]]** — the same waypoint structure from an incompatible starting point: CSCG partitions an estimated transition graph offline and gets room boundaries, FuN emits directions online in a space with no graph and its Montezuma waypoints land where a human designer put subgoals — three routes now recover bottleneck-like structure from three objectives, which weakens any claim that bottleneck-ness is owned by one discovery principle.
- **[[wiki/entities/diayn.md]]** — the own-channel arrangement with the coupling removed rather than severed: this page's Manager chooses `g` every step and pays the Worker at gain `α` with a domain-dependent optimum, while DIAYN draws its skill index from a fixed uniform prior that serves nothing and runs its two rewards in *disjoint phases*, so the per-level calibration measured here has no referent there — at the cost that the frozen skill library can never be reshaped by the task that arrives later.
- **[[wiki/entities/go-explore.md]]** — the null for this page's whole premise, on this page's own hardest game: learned latent-direction subgoals produce interpretable waypoints and ~2,600 points on Montezuma's Revenge, while an archive with no levels, no intrinsic reward and random-action exploration produces 1.7M, which prices what the hierarchy is buying on the benchmark it was demonstrated on (`T402`, `G33`).
- **[[wiki/entities/asymmetric-self-play.md]]** — the adversarial sign of this page's setter–solver structure, and the distinction the source draws itself: a Manager is trained on the *task return* and its subgoals exist to help the Worker, while Alice is paid `+5` for the solver's **failure** and her goals exist to hurt — so one architecture supports both signs, and only the adversarial one must ship a witness trajectory with each goal or score zero (`T403`, OpenAI et al. 2021).
