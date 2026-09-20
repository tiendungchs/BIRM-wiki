# DIAYN — Diversity Is All You Need

**Make the skill index recoverable from the states it visits and otherwise act as randomly as possible: maximise `I(S;Z) + H[A|S] − I(A;Z|S) = H[Z] − H[Z|S] + H[A|S,Z]`, replace the intractable posterior with a learned discriminator `q_φ(z|s)`, and the resulting per-step pseudo-reward `r_z(s,a) = log q_φ(z|s) − log p(z)` is the *only* reward in the system — an option library discovered by self-identification, with no environment reward, no graph, no bottleneck statistic, no task ensemble and no demonstration.**

> **Provenance.** Eysenbach, Gupta, Ibarz & Levine 2018, *Diversity is All You Need: Learning Skills without a Reward Function*, ICLR 2019 / arXiv:1802.06070 (`raw/eysenbach-2018-diversity-is-all-you-need.md`). Experiments: 2-D navigation, inverted pendulum, mountain car, half-cheetah, hopper, ant (111 degrees of freedom), plus a cheetah-hurdle and an ant-waypoint task for the hierarchical runs. Everything below is from that source unless marked.

The **eleventh** option-discovery family on [[wiki/concepts/temporal-abstraction-options.md]], and the only one whose subgoal is neither a state, a direction, nor a spectral extremum but a **partition label**: what a skill is *for* is being distinguishable from the other skills.

---

## The objective

| Term | Reading | How it is optimised |
|---|---|---|
| `I(S;Z)` maximised | The skill index must dictate which states are visited — so `z` is inferable from `s` | Discriminator `q_φ(z\|s)` trained by maximum likelihood on visited states |
| `H[A\|S]` maximised | The mixture over skills is a maximum-entropy policy | Soft actor–critic's entropy term, scaled `α = 0.1` |
| `I(A;Z\|S)` minimised | Skills must be told apart by **states, not actions** — an action with no environmental effect is invisible to an outside observer | Falls out algebraically; the rearranged objective contains only `H[A\|S,Z]` |
| `H[Z]` maximised | Every skill keeps getting sampled | **`p(z)` is fixed uniform categorical, not learned** — the single most consequential design choice (below) |

Variational lower bound by Jensen (Agakov's IM algorithm): `F(θ) ≥ H[A|S,Z] + E_{z∼p(z), s∼π(z)}[log q_φ(z|s) − log p(z)] ≜ G(θ,φ)`, so the environment reward is replaced everywhere by

`r_z(s,a) ≜ log q_φ(z|s) − log p(z)`

**Cooperative, not adversarial.** The policy is paid for visiting discriminable states and the discriminator is trained to discriminate better; both push the same way. The source contrasts this explicitly with asymmetric-self-play saddle-point formulations and reports insensitivity to random seed — the stability property adversarial curriculum methods do not have.

**Three differences from Variational Intrinsic Control (Gregor et al. 2016), each measured:**

| Difference | Effect |
|---|---|
| `p(z)` **fixed** rather than learned | VIC suffers the **Matthew effect**: the learned prior samples the already-diverse skills more often, so only those receive gradient. Effective skill count `e^{H[Z]}` collapses ~10× on half-cheetah, inverted pendulum and mountain car; DIAYN holds `log 50 ≈ 3.9` nats by construction |
| Discriminator reads **every state**, not the final state | Dense pseudo-reward at every step instead of one terminal bit — credit assignment inside the skill |
| Maximum-entropy skill policies | Skills are pushed apart rather than merely separated: a high-entropy skill that stays discriminable must occupy a region far from the others. Ablation: small `α` gives long-range but narrow skills, large `α` destroys discriminability |

The imitation experiment aggregates all three: DIAYN < "low entropy" < "few skills" ≈ "learned `p(z)`" in trajectory distance to the expert, and VIC *is* the combination of the two worst ablations.

**The `log p(z)` baseline is not a free constant.** Subtracting it makes `r_z ≥ 0` whenever the discriminator beats chance, which encourages the agent to **stay alive**; without it the optimal agent ends the episode as soon as possible. Equivalently it pretends episodes never terminate and pays `log p(z)` after the artificial cut. **(brainstorm)** This is the cheapest survival drive in the wiki — no homeostatic channel, no death term, just a baseline choice inside an information objective, and it is the same structural move as [[wiki/concepts/empowerment.md]]'s "vanishing capacity is death".

---

## The gridworld analytic result — and why it matters to `T365`

On an `N×N` gridworld the optimum is computable (Appendix B):

- **Unregularised (`α = 0`):** any set of skills that **evenly partitions the state space** is a global optimum — `H[Z|S] = 0` because the skill is inferable everywhere, `H[Z] = log 2` is maximal by construction.
- **Regularised:** an even partition is within `log(4)/2N` of optimum, i.e. `O(1/N)`.
- **The residual term is a border penalty.** `H[A|S,Z]` and `−H[Z|S]` conflict *only at states on the boundary between two skills*, because a border state's random action leaks into the neighbour's territory. So the objective strictly prefers partitions with **short borders**, and therefore partitions whose cuts fall at **bottleneck states**.

**Bottleneck preference is derived, not designed.** No graph is built, no Laplacian is diagonalised, no adjacency is partitioned, and no reward is consulted — yet the argmin of border length is the doorway cut. This is a third, independent derivation landing on `T365`'s Position A, and it arrives from inside the reward-free family that supplied Position B ([[wiki/concepts/eigenoption-discovery.md]]). The caveat is exact: it is an *analytic* result about an unobstructed gridworld's stationary distributions, and DIAYN never measures diffusion time or trials-to-discover, so it adjudicates nothing empirically.

**Skills are not confined to disjoint state sets.** The hallway experiment: a per-state discriminator would seem to forbid two skills sharing the corridor, but because the agent maximises *cumulative* pseudo-reward it traverses the shared corridor to reach the room where it can be distinguished. Discriminability is a property of the trajectory's occupancy, not of every step.

---

## What the skills are, measured

| Domain | Result |
|---|---|
| 2-D navigation | 6 skills move radially away from each other to stay distinguishable |
| Inverted pendulum, mountain car | Multiple **distinct** skills each solve the benchmark task; balancing skills differ in track position, oscillation amplitude and period; mountain-car skills differ in turnaround point and velocity. **The task is solved having never seen its reward** |
| Half-cheetah, hopper | Running forward and backward at various speeds, flipping, falling, balancing, diving — "challenging to craft reward functions that elicit these behaviours" |
| Ant (111 DOF (Degrees Of Freedom)) | Jumping and walking in curved trajectories; **no skill walks in a straight line**, so no single skill scores above the do-nothing baseline on the benchmark's survival bonus |
| Reward distribution | Skills spread widely over the benchmark reward; unlike random skills, learned skills *rarely* score near zero — every skill acts in order to be distinguishable |
| Three natural rewards (run / jump / move-from-origin) evaluated post hoc | DIAYN produces some skill scoring well on **each**; VIME, a single policy maximising an exploration bonus, scores poorly on all three |

**The last row is the paper's exploration claim and it is a claim about *collections*.** The contrast with count-based and curiosity bonuses is not a better bonus but a different object: those optimise one policy to visit many states, DIAYN optimises `N` policies to partition them. **(brainstorm)** This is the exploration analogue of an ensemble, and it is the only mechanism in the wiki that turns "cover the state space" into a *supervised* problem — the discriminator's cross-entropy is a legible, decreasing training loss standing in for a coverage objective that nobody can write down directly.

---

## Harnessing: three downstream uses, three different costs

| Use | Mechanism | Result |
|---|---|---|
| **Policy initialisation** | Pick the highest-reward skill; fine-tune actor **and critic** on the true reward | Faster than random init on cheetah, hopper, ant. The pretrained critic transfers because the pseudo-reward happens to be close to the task reward *for the best skill* — an accident, not a guarantee |
| **Hierarchical RL** | Freeze the skills; learn a meta-controller that picks a skill to run for `k` steps (`k = 100` ant, `10` cheetah), same observation space as the skills | Beats TRPO (Trust Region Policy Optimization), soft actor–critic and VIME (Variational Information Maximizing Exploration) on cheetah-hurdle and the 5-waypoint sparse-reward ant task. On 2-D navigation the reward rises with skill count and one skill choice suffices |
| **Imitation from states only** | `ẑ = argmax_z Π_{s_t ∈ τ*} q_φ(z|s_t)` — an **M-projection** of the expert's state distribution onto the skill family, solved by enumeration | Imitates standing, flipping, faceplanting; **fails the handstand**. `q_φ(ẑ|τ*)` predicts imitation accuracy *before execution* — a usable competence estimate |

**The discriminator is doing three jobs**: reward function during pretraining, skill retrieval index at imitation time, and confidence estimate on the retrieval. **(brainstorm)** That third use is the under-exploited one. A learned posterior over "which of my compiled policies is this trajectory" is exactly the recognition model [[wiki/concepts/amortized-inference.md]] needs to decide *execute the cached option or re-plan*, and DIAYN gets it for free as a byproduct of the objective rather than as a separate head.

**Supervision re-enters through `f(s)`.** Conditioning the discriminator on a function of the observation — `E[log q_φ(z|f(s))]`, e.g. the ant's centre of mass — biases discovery toward skills that vary that quantity, and "DIAYN+prior" beats plain DIAYN on the hierarchical task. The authors state the honest version: performance on hierarchical tasks improves with more supervision.

---

## The routing question (`T367`): the temporal-severance pole

`T367` asks whether the subgoal-level error rides its own channel or the reward channel masked by the running option. The wiki already holds the single-channel pole ([[wiki/entities/option-critic.md]]) and the own-channel-with-gain pole ([[wiki/entities/feudal-networks.md]]). DIAYN is a third arrangement, stricter than both:

| | Option-critic | FuN | DIAYN |
|---|---|---|---|
| Channels active at once | 1 (`r`) | 2 (`r` to Manager, `r + αr^I` to Worker) | **1 at a time** — `r_z` during pretraining, `r` during the downstream phase |
| Inter-level gain to set | none | `α`, swept, domain-dependent optimum | **none** — the phases never overlap |
| Who sets the low level's target | the return, via the gradient | the Manager, every step | **nobody** — `z` is drawn from a fixed uniform prior and is never chosen to serve anything |
| Gradient between levels | flows | severed | **no shared training at all**; skills are frozen before the meta-controller exists |
| Subgoal capture ([[wiki/concepts/conditioned-reinforcement.md]]) | impossible | available, bounded by `α < 1` | **total, and intended** — during pretraining the agent pursues nothing but its own identifiability |

The price is the mirror image of option-critic's. Option-critic cannot express an option pursued for its own sake; DIAYN can express *only* that, and pays for it by having no mechanism at all to make the skill library serve a task that arrives later — the recourse is to freeze, re-index, and hope. **(brainstorm)** The three architectures together suggest the real variable in `T367` is not *how many wires* but *whether the two errors are ever live simultaneously*. Temporal separation makes the calibration problem vanish and makes staleness certain; simultaneous operation makes calibration mandatory and staleness self-correcting. No source in the wiki runs both schedules on one architecture.

---

## Limits

| Limit | Consequence |
|---|---|
| **No termination condition** | A skill runs for the whole episode during pretraining and for a hand-set `k` steps downstream. There is no `β`, so this is not a semi-Markov decision process and the granularity question is answered by an integer — the same unset quantity as FuN's `c` |
| **Number of skills is hand-set** (`N = 50`, or 20, or 6) | Nothing selects it; the imitation ablation shows 5 skills is measurably worse than 50, with no principle in between. The fixed uniform `p(z)` that prevents collapse is also what makes `N` a hard commitment |
| **Discriminator reads states only** | Two skills differing purely in *how* they achieve the same occupancy are one skill; the ant's inability to produce a straight-line walker is the visible symptom — diversity in occupancy is not diversity in competence |
| **Diversity is not utility** | The ant's learned skills all score *below* a do-nothing policy on the benchmark. The objective maximises coverage of the reachable set; nothing says the covered regions are ones any task will care about |
| **Flat library, no nesting** | Skills never compose into skills; the meta-controller is one level and is retrained per task |
| **Skills are frozen** | No retirement, no re-derivation, no incremental update as the environment or the reachable set changes — the stale-library failure mode of [[wiki/concepts/temporal-abstraction-options.md]] in its purest form |
| **Pretraining assumed free** | Pretraining steps are omitted from every learning curve, justified by amortisation across tasks. Against a flat learner at *matched total interaction*, the comparison is not reported |

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| Skill `z` | A **region label** on the graph, not an edge — the policy that keeps the agent inside its own cell of a learned partition |
| `I(S;Z)` | A partition-quality score computable from occupancy alone, with no adjacency matrix ever formed |
| Border penalty | A preference for cuts across few edges — min-cut, arrived at by entropy rather than by spectral relaxation |
| Discriminator `q_φ` | An inverse map from a visited state back to the region that owns it — the same object a graph partitioner outputs, learned rather than computed |
| Meta-controller | Navigation over the **quotient graph** whose nodes are the skills' regions; DIAYN builds the quotient and never builds the graph underneath it |

**(brainstorm)** Read this way the relation to [[wiki/entities/cscg.md]] is a division of labour, not a rivalry: CSCG de-aliases observations into latent states and then runs InfoMap to get communities; DIAYN skips the latent state entirely and learns a soft community assignment directly from the reward the assignment defines. What DIAYN cannot do is what the de-aliasing was for — under perceptual aliasing, `q_φ(z|s)` conditions on an observation that two regions share, and the pseudo-reward is then a lie in both. That is the untested prediction the pairing makes, and it costs one aliased-maze run to check.

---

## Connections

- **[[wiki/concepts/temporal-abstraction-options.md]]** — the eleventh discovery family and the only one whose subgoal is a *partition label*: skills are discovered by being told apart from each other, so the library is defined by a mutual-information objective over the skill index rather than by bottlenecks, spectra, corpora or return gradients — and it arrives with no termination function at all, which is the same omission as feudal networks from the opposite direction.
- **[[wiki/concepts/eigenoption-discovery.md]]** — the nearest neighbour and the sharpest contrast: both consult the environment reward never, but eigenoptions read *directions* off the transition Laplacian and need the incidence matrix, while DIAYN reads *regions* off its own occupancy and needs nothing but rollouts — and the eigenvalue ladder that hands eigenoptions graded timescales for free has no DIAYN counterpart, whose every skill lasts exactly one episode.
- **[[wiki/entities/option-critic.md]]** — the opposite end of the reward axis with an unexpected agreement at the subgoal: option-critic's terminations concentrate at four-rooms doorways from return pressure, DIAYN's analytic optimum prefers short-border partitions and therefore the same doorways from an information objective with no reward — two derivations of the bottleneck from incompatible premises.
- **[[wiki/entities/feudal-networks.md]]** — the own-channel sibling with the coupling removed rather than severed: FuN's Manager chooses a direction every step and pays the Worker at gain `α`, DIAYN draws `z` from a fixed uniform prior that serves nothing and never pays a second signal at the same time as the first, so the per-level calibration FuN measures as domain-dependent simply does not arise.
- **[[wiki/concepts/empowerment.md]]** — the same channel-capacity machinery one level up, as the source states outright: maximising `I(S;Z)` is the empowerment of a *hierarchical* agent whose action space is the skill set, so DIAYN builds the macro-action alphabet that would make the empowerment estimate meaningful rather than degenerate — and it inherits the same failure, that a capacity objective ranks regions by reachability and never by worth.
- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — a cell the typology has no row for: the reward is neither knowledge-based (no predictor, no error, no progress) nor competence-based (no goal is set and no achievement is scored) nor morphological — it scores *the agent's own identifiability from its trace*, which is permutation-invariant and so intrinsic by the typology's test while fitting none of its three families, the second such case after eigenpurposes.
- **[[wiki/concepts/hindsight-goal-relabelling.md]]** — the two reward-free ways to manufacture dense signal without a subgoal vocabulary, and the comparison neither runs: relabelling harvests goals from the agent's realised future and stays flat, DIAYN manufactures goals from a fixed prior and produces a policy library — both make a coverage problem supervised, one by re-labelling stored data and the other by training a classifier on fresh rollouts.
- **[[wiki/entities/hisd.md]]** — the same "what recurs is a skill" instinct applied to different data: HiSD segments an unlabelled *observation corpus* and takes grammar rules used twice as options, DIAYN generates its own corpus by acting and takes the discriminator's decision regions as skills — so HiSD needs a demonstrator and gets nesting, DIAYN needs an environment and gets a flat set.
- **[[wiki/concepts/conditioned-reinforcement.md]]** — a want built from nothing paired with anything: the pseudo-reward `log q_φ(z|s) − log p(z)` is manufactured entirely inside the agent with no primary reinforcer to inherit value from, so subgoal capture is not a failure mode but the whole of the pretraining phase — and the `log p(z)` baseline is what keeps the manufactured want positive enough to prevent the agent from killing the episode.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — an explicit test of what prior experience buys, with the accounting stated and then suspended: skill pretraining accelerates fine-tuning on cheetah, hopper and ant, and the pretraining interaction is omitted from every curve on the assumption that it amortises across tasks, so the source measures transfer benefit and never the break-even task count.
- **[[wiki/concepts/divergence-objectives.md]]** — the variational-bound move in its cleanest instrumental form: replacing the intractable `p(z|s)` with a learned `q_φ(z|s)` gives a lower bound by Jensen, and the bound's *slack* is `E[KL(p(z|s) ‖ q_φ(z|s))]` — so the agent is rewarded by an approximation whose error it is also training away, which is why the game is cooperative rather than adversarial.
- **[[wiki/entities/cscg.md]]** — the same partition obtained with and without a de-aliaser: CSCG recovers room communities by running InfoMap on a learned clone transition matrix, DIAYN learns a soft region assignment directly from rollouts and never forms the matrix — which predicts that DIAYN's discriminator fails exactly where CSCG's control failed, on aliased observations that two regions share.
- **[[wiki/concepts/amortized-inference.md]]** — the free byproduct: `q_φ(ẑ|τ*)` scores how well a stored skill matches an observed trajectory *before* the skill is run, which is the execute-or-replan confidence signal that page needs and that no option framework in the wiki supplies.
- **[[wiki/entities/go-explore.md]]** — the same explore-first-use-later schedule with the coverage objective swapped, and the swap is diagnostic: this page maximises state–skill mutual information and freezes a skill library whose ant skills score below doing nothing, Go-Explore maximises raw coverage of a designer-given cell map and freezes a trajectory archive that contains the optimal path — coverage anchored to environment states pays, coverage anchored to a latent index does not.
