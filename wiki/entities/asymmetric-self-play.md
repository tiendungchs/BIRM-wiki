# Asymmetric Self-Play — The Goal Generator That Has to Ship a Solution With Every Goal

**Two agents in the same body. Alice acts for `T` steps and whatever state she leaves behind *is* the goal; Bob is reset to Alice's initial state and paid only for reproducing it. Alice is paid 5 when Bob fails. The goal distribution is therefore generated adversarially, with no human priors, no target-task knowledge and no easiness measure — and it is worth going from a flat `0` on four hand-designed curricula to zero-shot table-setting, tangram and block-stacking from a single policy. The result that matters for the wiki is the ablation: remove Alice's *trajectory* as a demonstration and Bob solves nothing at all.** Primary source: OpenAI (Plappert, Sampedro, Xu, Akkaya, Kosaraju, Welinder, D'Sa, Petron, Ponde de Oliveira Pinto, Paino, Noh, Weng, Yuan, Chu & Zaremba) 2021, *Asymmetric self-play for automatic goal discovery in robotic manipulation*, arXiv:2101.04882 (`raw/openai-2021-asymmetric-self-play-goal-discovery.md`). Method descends from Sukhbaatar et al. 2018a/2018b.

---

## The game

| Step | Mechanism | Designer choice hidden inside it |
|---|---|---|
| Initial state `s₀` | Sampled once; **Alice and Bob are instantiated into their own copies of the same environment at the same `s₀`** | Requires a resettable simulator — the paper's stated limitation |
| Alice's turn | `π_A(a\|s)` acts `T` steps (100 blocks / 250 ShapeNet); terminal state `s_T` is published as the goal `g` | `T` is the only difficulty dial, and it is fixed |
| Goal validation | (1) some object moved; (2) all objects still on the table; (3) objects inside the camera-visible *placement area* — else invalid (episode resets) or `−3` penalty | **Hand-written legality predicates.** Without them the adversary degenerates into throwing objects off the table |
| Bob's turn | `π_B(a\|s,g)` gets **sparse** reward: `+1` per object within 0.04 m and 0.2 rad of its goal pose (`−1` if it leaves one it had), `+5` when all objects are placed | The achievement predicate and its two tolerances are an oracle, as in [[wiki/concepts/hindsight-goal-relabelling.md]] |
| Alice's reward | `+1` valid goal, `+5` **iff Bob failed**, `−3` out-of-zone | Pure adversarial signal — *not* learning progress, *not* novelty |
| Repeat | Up to **5 goals per episode**; Alice keeps proposing after Bob's first failure, Bob's remaining turns are scored as failures | Multi-goal structure is load-bearing (ablation below) |
| Anti-collapse | Each agent plays a **past version** of its opponent in 20% of games | Hand-set |

Both policies are the same recurrent architecture trained with Proximal Policy Optimization (PPO); Alice differs only in having no goal input. Per-object embeddings are max-pooled (permutation-invariant); the ShapeNet variant adds a vision stack (IMPALA trunk, front camera + wrist camera + goal image) under Automatic Domain Randomization (ADR) over object count and size.

## Alice Behavioural Cloning (ABC) — the load-bearing part

Every proposed goal arrives with a **witness**: Alice's own trajectory reaches it, from the same initial state, in the same body. Relabel it goal-augmented, `τ_BC = {(s_t, s_T, a_t, r_t)}`, and train Bob on it alongside the RL objective, `L = L_RL + β L_abc`, `β = 0.5`, with two corrections:

- **Filter:** only trajectories for goals Bob *failed* become demonstrations. Alice's route is often accidental, so a solved goal's demonstration is noise.
- **Clip:** the naive negative-log-likelihood BC loss is replaced by the PPO clipped surrogate with the advantage pinned to `Â = 1`,
  `L_abc = −E[clip(π_B(a_t|s_t,g_t;θ)/π_B(a_t|s_t,g_t;θ_old), 1−ε, 1+ε)]`, `ε = 0.2` — i.e. imitate, but never move the policy further than a trust region per iteration.

## Results

| Setting | Result |
|---|---|
| 1–2 blocks, four holdouts (push, flip, pick-and-place, stack), **zero holdout goals in the training distribution** | Bob solves all four. Each holdout tests a distinct skill; none was encoded anywhere |
| **No curriculum** baseline, trained directly on the holdout mixture | "Fails drastically" — no progress on anything |
| `curriculum:distance` (ADR-annealed initial→goal distance and rotation tolerance) | Push and flip, **single block only** |
| `curriculum:distribution` (ADR-annealed `pickup_proba`, `stack_proba`) | **Acquires no skill at all** |
| `curriculum:full` (all four ADR parameters) | Still **cannot pick up or stack** |
| ShapeNet scale-up (≤10 random objects, hybrid vision policy) | One policy, zero-shot: table setting, mini chess, rainbow (2–6 pieces), tangram, dominoes, ball-capture, YCB push and pick-and-place, block stacking 2–4. Weakest on concave shapes, rolling objects, and stacking order beyond 3 |
| **No ABC** | Bob "completely fails to solve any holdout task" |
| No BC-loss clipping | Slower on pick-and-place and stack, mid-training instability |
| No demonstration filter | Marked instability on flip |
| **Single-goal** episodes instead of 5 | Much slower and less stable generalisation |
| Alice's reward: Bob-failure only vs Sukhbaatar's timestep-based shaping | No measurable difference — the simpler signal suffices |
| Empirical Alice×Bob payoff matrix over checkpoints | Later Alices are harder for a fixed Bob; later Bobs beat a fixed Alice. The authors read the monotone structure as "potentially unbounded complexity" |

Emergent goals the holdout suite never contained: lifting two blocks at once, building a tower and **holding it balanced with an arm joint**.

---

## Why this matters for a reasoning model

- **It is the strongest entry on `G32` and the first fully automatic one.** [[wiki/entities/anli.md]] is the wiki's other closed-loop generator and it has a paid human inside the loop; here the proposer is a policy, the rejector is a three-line legality predicate, and the comparison arm is not i.i.d. data but **four hand-designed curricula built by the same team with ADR machinery and "a decent amount of time iterating"**, three of which score approximately nothing. On this evidence the open-loop, easy-first family of [[wiki/concepts/curriculum-learning.md]] is not merely the cheap corner of the design space — on a task requiring pick-up and stacking it is the *empty* corner.
- **It states the price of an adversarial generator: a witness trajectory.** HER's goals come from the agent's own realised future and need no demonstration; Alice's goals are drawn from a policy **explicitly rewarded for proposing what Bob cannot do**, and without ABC the resulting distribution is worth zero. The generator's difficulty and the solver's reachability are the same quantity, and an adversary that maximises the first destroys the second unless the goal ships with a route (`T403`).
- **Achievability is bought by *embodiment*, not by inference.** The guarantee "every proposed goal has at least one solution" follows from Alice being instantiated in the same action space and the same initial state. This is the cheapest known answer to the reachability problem [[wiki/concepts/hindsight-goal-relabelling.md]] identifies (`random` relabelling fails because it writes edges that do not exist) — and it generalises: *a goal proposer that shares the solver's body cannot propose an unreachable goal.* Every generative-model goal sampler (Florensa et al. 2018; setter–solver, Racanière et al. 2020) forfeits that guarantee and must recover it statistically.
- **The adversary has to be fenced, and the fence is designer knowledge.** The three validation rules plus the `−3` out-of-zone penalty plus past-opponent sampling are the entire defence against the degenerate optimum (push everything off the table; propose the impossible forever). This is the same shape as [[wiki/entities/diayn.md]]'s `log p(z)` baseline existing to stop the agent ending the episode: **every self-generated objective in the wiki needs a hand-written non-degeneracy clause**, and the clause is where the designer's task knowledge re-enters after being removed from the goal distribution.
- **Multi-goal episodes are a meta-learning claim in disguise.** Five goals per episode beats one, and the authors' explanation is that the recurrent policy *internalises environment constants* — object properties and dynamics are fixed within an episode, so early goals are probes whose answers pay off on later ones. That is the inner loop of [[wiki/concepts/meta-learning.md]] arriving as a free side effect of episode structure, and it makes the goal sequence a **within-episode** curriculum as well as a cross-episode one (stack 3 requires stack 2 as a step).
- **(brainstorm) Alice is a conditioned-reinforcement engine run in reverse.** [[wiki/concepts/conditioned-reinforcement.md]] builds intermediate wants by propagating value *outward* from a primary reinforcer that has already been reached. Alice builds them by propagating **reachability** outward from the initial state — she has no access to any environment payoff, and the structure she generates is a frontier of the reachable set ordered by Bob's incompetence. The two mechanisms populate the same intermediate layer from opposite ends, and nothing in the wiki runs both: an agent with a terminal `WIN` *and* an asymmetric proposer would have value flowing in from the goal and reachability flowing out from the start, meeting somewhere in the middle. That meeting point is what a subgoal is (`G33`).
- **The termination question is answered by the opponent.** Every intrinsic-motivation scheme in the wiki needs a stopping rule for "when is this region exhausted" — learning progress differentiates competence, empowerment computes a channel capacity. Here the stop is free: a goal Bob reliably solves stops paying Alice, so the frontier moves without any progress estimate being computed anywhere. It is [[wiki/concepts/learning-progress.md]]'s set-point implemented as a *second agent's reward function* rather than as a derivative.

## Limitations

- **Resettable simulator, by construction.** Bob must begin where Alice began. This is the same exemption [[wiki/entities/go-explore.md]] takes for its return step, arrived at for a different reason — Go-Explore rewinds to *re-enter* a state, asymmetric self-play rewinds to make two rollouts *comparable*. No sim-to-real is attempted; it is future work.
- **The goal space is object pose.** `g = s_T` compared per object on Euclidean position and Euler-angle rotation under fixed tolerances. A goal that is a relation, a rule, or a property not expressible as a pose is outside the space — the same wall as HER's `m : S → G`.
- **Nothing measures whether the emergent difficulty is the *useful* difficulty.** Alice maximises Bob's failure rate, which is a maximum at the frontier only because failing goals stop being novel; there is no term preventing her from parking on a narrow hard trick. Past-opponent sampling is the only counterweight and it is a hyper-parameter (20%).
- **Evaluation is on designer-authored holdouts.** Zero-shot generalisation is measured against tasks a human wrote down, so "the generator covered the interesting space" is asserted relative to one team's list of interesting things.
- **Compute:** 256 GPUs and 16,704 rollout-worker CPUs for the ShapeNet policy.
- **Alice's own exploration is unaddressed.** She is a PPO policy with an entropy bonus; nothing drives her toward *novel* goal regions rather than merely hard ones, and the paper reports no coverage statistic over the goal space.

## Comparison

| | Where goals come from | Reachability guaranteed? | Demonstration shipped? | Needs environment reward? |
|---|---|---|---|---|
| **Asymmetric self-play** | A second policy in the same body, paid for the solver's failure | Yes — by construction | **Yes, and required** | No |
| [[wiki/concepts/hindsight-goal-relabelling.md]] | The agent's own realised future | Yes — already traversed | No, and not needed | No |
| [[wiki/entities/go-explore.md]] | An archive of visited cells, selected by count | Yes — already visited | The archive *is* the route, used only at robustify time | Only for tie-breaking |
| [[wiki/entities/diayn.md]] | A fixed uniform prior over a latent index | No — the index names no state | No | No |
| [[wiki/entities/feudal-networks.md]] | A Manager's latent direction, trained by the return | Partially — a direction is always partly achieved | No | **Yes** — the Manager needs it |
| [[wiki/entities/anli.md]] | A paid human writing against the live model | By human judgement | The human's label | n/a |
| ADR curricula (this paper's baselines) | Designer-parameterised distribution, annealed on a performance threshold | No | No | Yes |

## Open problems

- **Does the demonstration channel remain necessary once the goal distribution is matched to the solver's frontier?** The ablation removes ABC while leaving Alice adversarial; nobody has run it with a difficulty-regulated proposer (`T403`).
- **Learn the legality predicate.** "Some object moved, nothing off the table, inside the camera volume" is the whole anti-degeneracy defence and is entirely hand-authored.
- **Asymmetric self-play with a terminal environment reward present.** The setup deliberately has none; the composition with an actual `WIN` is unstudied and is where `G72` lives.
- **Coverage.** No statistic reports what fraction of the reachable goal space Alice visits, so "potentially unbounded complexity" rests on a payoff matrix over checkpoints rather than on a measured frontier.

## Connections

- **[[wiki/concepts/curriculum-learning.md]]** — the automatic, closed-loop, human-free instance that page asks for, and the most damaging control in the wiki for its definition: four ADR curricula satisfying Bengio's monotone easy-first conditions acquire *no* pick-up or stacking skill while an adversarial generator whose entropy tracks the solver's failures solves all four holdouts, so the two conditions select the family that does not pay here.
- **[[wiki/concepts/hindsight-goal-relabelling.md]]** — the same reachability constraint solved by a second body rather than by the agent's own past: HER samples goals from the trajectory's future (always reachable, never far), asymmetric self-play samples them from an adversary sharing the solver's action space and initial state (reachable by construction, deliberately far) — and only the second needs a demonstration channel to be worth anything (`T403`).
- **[[wiki/entities/go-explore.md]]** — the same simulator-reset exemption taken for opposite purposes (re-enter a stored state vs. make two rollouts comparable), and the same finding about where the signal has to be consumed: Go-Explore's archive holds routes it later distils by self-imitation, ABC distils a route the proposer just walked — in both, the trajectory and not the target is what the solver actually learns from.
- **[[wiki/entities/diayn.md]]** — the opposite corner of goal generation without reward: DIAYN's goals are latent indices with no guarantee of naming any useful state and its ant skills score below doing nothing, where Alice's goals are literal reachable configurations and Bob generalises to hand-written tasks; both need a hand-written non-degeneracy clause (`log p(z)` baseline; the three legality predicates) to keep the self-generated objective from collapsing.
- **[[wiki/entities/feudal-networks.md]]** — the cooperative pole of the same two-agent structure, and the distinction the source draws itself: a Manager is trained to *optimise the task return* and its subgoals exist to help, while Alice is trained on the Worker's **failure** and her goals exist to hurt — so the same architecture (setter + goal-conditioned solver) supports opposite objective signs, and only the adversarial sign needs a witness trajectory attached.
- **[[wiki/entities/option-critic.md]]** — the third arrangement of setter and solver: option-critic has no setter at all and dissolves the intermediate target into option policies learned from the return, which makes it the null for both this page's proposer and FuN's Manager; none of the three has been run against the others at matched interaction budget.
- **[[wiki/entities/anli.md]]** — the wiki's other closed-loop adversarial generator, with the human replaced by a policy: ANLI needs a *rejector* (`model-wrong ∧ human-right`) because an unverified adversarial example is worth random, and asymmetric self-play gets its rejector free — a goal Alice reaches is verified by the reaching, which is what an embodied proposer buys over a written one.
- **[[wiki/concepts/meta-learning.md]]** — the inner loop arriving as a by-product of episode structure: five goals per episode beats one because the environment's constants are fixed within an episode and the recurrent policy can probe them on early goals, so the multi-goal game is a goal curriculum *and* a fast-adaptation task simultaneously.
- **[[wiki/concepts/learning-progress.md]]** — the same frontier-tracking behaviour with the derivative removed: the stop condition for an exhausted region is not a fall in competence progress but a fall in the *opponent's* payoff, which makes the set-point an equilibrium of a two-player game rather than a quantity any agent estimates — and nothing prevents Alice parking on a narrow hard trick, which a progress term would penalise.
- **[[wiki/concepts/conditioned-reinforcement.md]]** — value propagating outward from a primary reinforcer versus reachability propagating outward from the initial state: the two mechanisms populate the same intermediate layer from opposite ends and have never been run in one agent, which is the experiment `G33` most obviously wants.
- **[[wiki/concepts/latent-graph-discovery.md]]** — goal generation read as edge proposal: Alice emits `(s₀ → s_T)` pairs annotated with the action sequence that realises them, so the training distribution is a set of *measured long edges* of the reachability relation chosen adversarially against the solver's current coverage, where HER writes short edges and Go-Explore enumerates nodes.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — an option library obtained without option machinery: the multi-goal episode makes early goals into literal subgoals of later ones (stack 2 before stack 3) with no `⟨I, π_o, β⟩`, no termination function and no library, so the temporal structure is carried by the *game's* turn order rather than by the architecture.
