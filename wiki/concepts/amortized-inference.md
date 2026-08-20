# Amortized Inference

**Compile the results of slow, structured inference into a fast feed-forward mapping, so the answer can be produced without re-running the expensive computation — "learning to do inference", as distinct from learning the model (Lake et al. 2017).**

This is the wiki's answer to a problem the rest of the framing creates: richer, more structured models require more complex and slower inference, yet perception and thought are fast — a novel scene is comprehended in a fraction of a second. Amortization is the proposed resolution, and it is the one place where "model-free pattern recognition" is assigned a *positive* role inside a model-building architecture rather than being the thing model building replaces.

> **Provenance.** Lake, Ullman, Tenenbaum & Gershman 2017 (`raw/lake-2017-machines-learn-think-like-people.md`), §4.3.

---

## The two amortizations

The source treats these as one idea appearing at two levels. They share a shape: an expensive search is run once and its output is cached as a learned mapping.

| | **Inference amortization** | **Plan amortization** |
|---|---|---|
| Expensive process | Posterior inference over a structured generative model / program | Model-based planning over a learned transition model |
| Cached as | A recognition network: observation → plausible hypotheses | Cached values / a policy |
| Mechanism | Paired generative/recognition networks (Helmholtz machine; Dayan et al. 1995; Hinton et al. 1995), variational optimization, nearest-neighbour density estimation | The model-based system **simulates training data for the model-free system** (Dyna; Sutton 1990) |
| When it runs | During training of the recognition net | Possibly **offline** — dreaming or quiet wakefulness, i.e. a consolidation process in reinforcement learning (Gershman, Markman & Otto 2014) |
| Biological signature | Inferential correlations across problems that share amortized computations (Gershman & Goodman 2014) | Model-based behaviour becomes automatic over training (Economides et al. 2015); skills "habitize" |

**A third amortization, and the one the wiki was missing** ([[wiki/entities/h-jepa.md]]): amortize the *latent*, not the hypothesis and not the plan. In a latent-variable energy-based model, inference requires `ž = argmin_z E(x, y, z)` at every prediction step — an inner optimization inside every forward pass. The remedy is a module trained to output the minimising latent (or a distribution over latents whose parameters are computed from the current state) directly. Two things follow that the other two rows do not give:

- **The amortized latent distribution is a learned prior over what happens next**, so conditioning it on previous states biases trajectory sampling toward plausible futures — amortization doing *pruning*, not just speed.
- **It restates the wiki's plan/policy distinction in one vocabulary.** Amortizing the action variable gives a policy; amortizing the latent variable gives a proposal distribution; both are the same operation because "there is no conceptual difference between an action and a latent variable" ([[wiki/concepts/energy-based-models.md]]). The Mode-2 → Mode-1 distillation `min_θ D(ǎ[t], A_θ(s[t]))` is then not a special mechanism but the action-shaped instance of it.

**A fourth mode: amortize the *initialization*, not the answer** (Bengio et al. 2015). Decompose the approximate posterior into a parametric guess plus iterative refinement — `q₀(H|x) = q(H|x)`, then `q_t(H|x) = A(x) q_{t−1}(H|x)` for `t = 1…T` — and train with

`J = log p(x|h) + log p(h) + α log q(h|x)`

where `h` is a free variable initialized from `q` and then updated to increase `J`. The third term is the amortization: it is a pressure on the feed-forward net to land where the relaxation would have gone, so that *few steps suffice*. Two consequences the other three modes do not have:

- **The cached mapping and the expensive process run in series, not in competition.** The arbitration question above ("when to fall back") does not arise, because the fast path is always the first step of the slow path. What is tuned is `T`, not a switch.
- **The model is also pushed toward being easy to invert.** One may add a term encouraging `p(x,h)` to favour posteriors that `q_t` can approximate for small `t` — amortization feeding back into *model selection*, which is the reverse of the usual dependency and a direct answer to the open problem that a recognition net is only as good as what it was trained on.

**(brainstorm)** This is the same relation as H-JEPA's distilled policy *initializing* rather than replacing the optimization, and as predictive coding's relaxation — three sources converging on **guess-then-relax** over guess-or-relax. If that is the right shape, the wiki's fast/slow arbitration debate is partly mis-framed: the interesting quantity is not *which* system runs but how many refinement steps the cached guess buys you, which is measurable on any model with an iterative inference loop.

**The prediction that makes amortization falsifiable:** because different problems share amortized computations, their solutions become *correlated* in ways the exact posterior would not predict. That is a signature of the mechanism rather than of its output — the same kind of evidence as a signature limit ([[wiki/concepts/core-knowledge.md]]), and directly runnable on a model.

---

## Arbitration between the two systems

| Finding | Content |
|---|---|
| Model-free machinery is real | Phasic midbrain dopamine matches reward prediction error qualitatively (Schultz, Dayan & Montague 1997) and quantitatively (Bayer & Glimcher 2005) |
| So is model-based machinery | A "cognitive map" used to plan action sequences for complex tasks (Daw, Niv & Dayan 2005; Dolan & Dayan 2013) |
| They compete *and* cooperate | Competitively (which controls behaviour) and cooperatively (one trains the other), supervised by **metacognitive** processes |
| The arbitration is rational | A trade-off between flexibility and speed, resolved by an arbitration policy (Daw et al. 2005; Keramati, Dezfouli & Piray 2011) |
| Habitization is the shift | With routine application, skills move from model-based to model-free control |

**Consequence for gap G15** (no control policy over simulation): arbitration is the *when-to-plan* question answered by a second criterion — an estimated value of computation — rather than by the free-energy drive [[wiki/concepts/predictive-coding-free-energy.md]] supplies. The two are compatible and neither answers *how deep* (gap G24).

**The one case where both modes are recorded on the same knowledge.** Barron et al. 2020 ran a sensory-preconditioning inference task (`X→Y` day 1, `Y→Z` day 2, `X` alone day 3) in humans and mice and found the *expensive* and the *compiled* route to the same answer running in one brain:

| | Online, at choice | Offline, in rest |
|---|---|---|
| Operation | Hippocampal pattern during `X` reinstates the associated `Y`, with `Y`-cells spiking *after* `X`-cells — one hop of chained recall, in the learned temporal order | Awake sharp-wave ripples co-activate `X₁` and `Z₁` directly, increasingly with experience, *without* the intermediary `Y₁` present |
| Cost | A retrieval per link; the paper's stated motivation for a shortcut is the search cost over many memories | Paid once, during rest |
| Direction | Forward (`X`→`Y`), the direction of use | **Reverse** (`Z₁`→`X₁`), the direction of credit |
| Gating | Runs on the trial | Reward-gated: increases for the sucrose set, not the neutral set, and not for cross-set pairs |
| Causal test | Optogenetic dorsal-CA1 silencing during `X` abolishes the inference while sparing first-order conditioned responding | Not manipulated |

This is the wiki's first *neural* evidence for plan amortization as this page defines it — expensive composition run once and cached as a direct mapping — and it adds a detail no machine version has: the cached link is written **in the opposite direction to its use**, which is what a credit-assignment write looks like rather than a rehearsal. It also sharpens the arbitration question: both routes exist simultaneously after days of training, so the compiled shortcut does not retire the chained recall (silencing the hippocampus at choice still breaks behaviour), and what selects between them is unmeasured. See [[wiki/concepts/offline-replay.md]].

**The model-free signal is computed over an inferred state, not over cached action values.** Mishchanchuk et al. 2024 record nucleus accumbens dopamine (dLight1.1) while mice run a probabilistic 2-armed bandit whose contingency reverses uncued. The dopamine transient tracks the prediction error of a **state-inference** agent — a belief `b_t(s)` over which of two latent contexts is active — and not that of a Q-learning agent, distinguishable because a belief update uses outcomes of *both* levers while a Q update uses only the chosen one. Lesioning ventral CA1 removes the state-inference signature from dopamine almost entirely (unilateral lesion, ipsilateral photometry, behaviour spared by cross-hemisphere redundancy) and shifts behaviour toward Q ([[wiki/concepts/contextual-inference.md]]).

| Reading | Consequence for this page |
|---|---|
| The canonical model-free error signal is **downstream of a model-based state estimate** | "Model-free" names the *update rule*, not the input. The same temporal-difference machinery is model-free or model-based depending only on whether its state variable is an observation or a posterior — so the arbitration table above is mis-drawn if it treats the two systems as consuming the same input |
| Removing the state estimator does not break the valuation system, it **degrades its state space** | The lesioned animal is not incompetent; it runs correct Q-learning over the wrong (context-free) state. A failure of abstraction presents as a change of *strategy class*, not as a performance collapse — worth carrying as a diagnostic pattern |
| **(brainstorm)** The machine version is a one-line change with a measurable consequence | Feed a temporal-difference learner the responsibility vector of a context-inference module instead of the raw observation, then ablate the module. If the wiki's reading is right, the ablated agent's residuals should be fit better by a same-choice-only error term than by a both-choices error term — the exact statistic used here, and one that needs no access to the model's internals |

**(brainstorm)** The wiki has been treating model-free control as the failure mode and model-based control as the target. Amortization inverts the relation: the model-free system is the *compiled output* of the model-based one, so a mature architecture should show a growing model-free component whose contents are traceable to rollouts. That is a testable architectural signature — and it says a system that is model-free *from the start* (a DQN) and one that is model-free *by consolidation* are different systems with the same interface, which no current benchmark distinguishes.

---

## Why pure Monte Carlo is not enough

The structured-model side has a real algorithmic problem: computing a distribution over an entire space of programs is intractable, and often finding even one high-probability program is an intractable search.

| Position | Content |
|---|---|
| **Monte Carlo as the psychological answer** | Sampling accounts explain children's response variability (Bonawitz et al. 2014), garden-path effects (Levy et al. 2009), perceptual multistability (Gershman et al. 2012); neural implementations of sampling exist (Buesing et al. 2011; Pecevski et al. 2011) |
| **But it does not scale to theory learning** | When the hypothesis space is vast and few hypotheses fit, good models cannot be found without exhaustive search. In some domains people apparently have no clever solution either — theory discovery is slow and arduous, and *saltatory* rather than gradual (development, insight, scientific revolutions) |
| **Yet sometimes it is fast** | Learning Frostbite is a loosely ordered sequence of "Aha!" moments — floes change colour when jumped on; changed floes build the igloo; birds cost points; fish gain points — assembled into a causal understanding "more like a guided process than arbitrary proposals in a Monte Carlo scheme" |

**The proposed resolution: inductive biases guide hypothesis *selection*, not just hypothesis evaluation.** Abstract structural properties of a problem carry information about the abstract form of its solution — the answer to "where is the deepest point in the Pacific?" must be a *location*; "20 inches" is a priori invalid as an answer to "what year was Lincoln born?" (Schulz 2012). Children demonstrably use high-level abstract features — distributional properties like a seeds-to-flowers ratio, dynamical properties like periodic vs. monotonic cause-effect relations — to guide hypothesis selection (Tsividis, Tenenbaum & Schulz 2015; Magid, Sheskin & Schulz 2015).

For this wiki that is a **type system over the hypothesis space**: a cheap classifier of the *question* prunes the space of admissible *answers* before search begins. It is the routing policy gap G12 asks for, stated for hypotheses rather than for observations, and it is the same move core knowledge makes with entry conditions — restrict the domain before doing the expensive work.

---

## Where the amortized mapping comes from

| Route | Mechanism |
|---|---|
| Paired generative/recognition networks | Wake-sleep; the recognition net is trained on samples from the generative model (Dayan et al. 1995) |
| Variational optimization | DRAW, variational autoencoders, neural variational inference (Mnih & Gregor 2014; Rezende et al. 2014) |
| Nearest-neighbour density estimation | Stuhlmüller et al. 2013; Kulkarni et al. 2015 |
| Neural network as **bottom-up proposer** inside a structured generative model | The integration route the source favours: the deep net makes probabilistic inference tractable, the program supplies the causal structure (Eslami et al. 2016; Yildirim et al. 2015) |
| **Learned initializer for an iterative relaxation** | `q(h\|x)` supplies `h⁰`, then `T` local updates increase a variational bound; a regularizer in the training objective ties the two together so the feed-forward guess stays close to the relaxed answer (Bengio et al. 2015) |
| Differentiable programming | Make the program-like hypotheses themselves differentiable, so they are learnable by gradient descent |

The fourth row is the architectural proposal: **the neural network is the inference engine, the program is the model.** The alternative reading — the network *is* the causal generative model, if imbued with the right ingredients — is left open by the source as the second of two ways deep learning could play a role.

---

## Open problems

- **Amortization is only as good as the training distribution of the recognition net.** It inherits meta-learning's knowledge-boundedness limit exactly: queries outside the sampled space get a fast, confident, wrong answer, with no signal that the expensive path should have been taken.
- **Nothing decides when to fall back.** Arbitration between fast approximation and slow exact inference is asserted to be metacognitive and rational; no computational account of the metacognitive estimator is given.
- **The guided-search claim is not mechanised.** "Aha!" sequences and abstract-feature-guided hypothesis selection are described behaviourally; what computes the type of a question, and what prunes the answer space with it, is unspecified.
- **Consolidation direction is unproven in machines.** Offline replay of model-based rollouts into a model-free learner is proposed as a form of consolidation, but replay in current systems decorrelates a training stream rather than transporting structure — the same defect as gap G14, one level down.

---

## Connections

- **[[wiki/concepts/causal-model-building.md]]** — the cost this page pays down: causal, program-like models are exactly the models that are slow to invert, so amortization is the precondition for using one in real time.
- **[[wiki/concepts/simulation-based-planning.md]]** — plan amortization is this page applied to rollouts: model-based simulation generates training data for a model-free controller, and habitization is the resulting shift in control.
- **[[wiki/concepts/complementary-learning-systems.md]]** — offline amortization (dreaming, quiet wakefulness) is the same replay machinery in a third role: not stabilizing a training stream and not consolidating episodes, but compiling plans into values.
- **[[wiki/concepts/meta-learning.md]]** — an amortized recognition network is an outer loop over an inference problem rather than over a task distribution, and it inherits the same hard boundary at the edge of what was sampled.
- **[[wiki/concepts/attention.md]]** — the amortized mapping is what makes a fast feed-forward pass a *proposal* rather than an answer; attention is how such a proposer is decomposed into sequential sub-queries instead of one shot.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — where amortisation stops being an efficiency device and becomes load-bearing for *learning*: if the relaxed latent state is the error signal, then the quality of the amortized initializer sets how many synaptic-timescale iterations credit assignment costs (Bengio et al. 2015).
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — a rival account of fast inference: instead of compiling the posterior into a feed-forward net, run a fast recurrent relaxation to a consistent state; the two differ in whether speed comes from caching or from convergence — and the variational-EM route above refuses the choice, using the cache as the relaxation's starting point.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the *speed* constraint the framing otherwise ignores: a graph estimate that cannot be queried in real time is not usable for navigation, however well it is recovered.
- **[[wiki/concepts/core-knowledge.md]]** — abstract-feature-guided hypothesis selection is an entry condition over the hypothesis space rather than over entities: restrict the domain before paying for search.
- **[[wiki/entities/h-jepa.md]]** — the architecture that runs both amortizations at once: a distilled Mode-1 policy for actions and an amortized latent-inference module for uncertainty, with the distilled policy also used to *initialize* the expensive optimization rather than replace it.
- **[[wiki/concepts/energy-based-models.md]]** — supplies the expensive computation being amortized in its most general form: `argmin` over free variables, which covers hypotheses, latents and actions with one operation.
- **[[wiki/entities/bayesian-program-learning.md]]** — the concrete case where inference is the bottleneck: a structured program prior with human-level one-shot results, whose search cost is what amortization would remove.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — makes the cost of amortisation visible in the code length: parameters are an up-front payment counted in the adjusted compression rate, repaid only by streams in the terabytes (Chinchilla 70 B: 8.3% raw, 14008.3% adjusted).
- **[[wiki/entities/hbtom.md]]** — the boundary case that needs no amortisation: conjugacy, a 5-point grid over the rationality parameter, and A\* run only on visited states make exact structured inference fast enough to run online, so compilation is a scale remedy rather than a structural one.
- **[[wiki/concepts/subgraph-matching.md]]** — structural amortisation, worked: an NP-complete relational query becomes an offline `O(K\|E_T\|)` encoding plus an `O(\|V_T\|\|V_Q\|)` coordinate comparison, 0.03 s against 7.5–25.9 s for exact search — with the un-flagged error rate that this page's open problem predicts (Ying et al. 2020).
- **[[wiki/concepts/contextual-inference.md]]** — splits the same two modes by *what has been observed* rather than by compute budget: expression uses the cue-only posterior and must be computed before acting, updating uses the post-feedback posterior (Heald et al. 2021); and it supplies the state variable the dopaminergic error is computed over, so the model-free system's input is itself a model-based inference (Mishchanchuk et al. 2024).
- **[[wiki/concepts/cognitive-map.md]]** — the navigational form of compilation: hippocampal involvement falls away once an environment is highly familiar, so map-based route computation appears to be cached into a cheaper policy rather than run every time (Epstein et al. 2017).
- **[[wiki/concepts/offline-replay.md]]** — the mechanism this page's offline compilation would run on, plus the competition for it: four other jobs claim the same replay budget under four different sampling policies, and nothing arbitrates.
- **[[wiki/concepts/offline-replay.md]]** — and the recording that makes offline compilation concrete: ripples cache a never-experienced `X→Z` link, reward-gated and reverse-ordered, while the chained-recall route it replaces stays functional (Barron et al. 2020).
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — the same offline-reactivation-compiles-into-fast-weights loop with a different target and an extra term: what is compiled is a *generalizing* function rather than a cached value, and the theory's entire payload is the stopping rule, since compiling past the optimum makes the compiled function worse than untrained.
- **[[wiki/entities/pbwm.md]]** — contests this page's dopamine-as-reward-prediction-error framing: PVLV reproduces the same firing record with two Rescorla–Wagner systems and no prediction chain, on the argument that temporal-difference chaining breaks on tasks whose stimulus sequence is unpredictable ([[wiki/empirical-tensions.md]] T85).
- **[[wiki/entities/meta-rl-agent.md]]** — runs this page's compilation arrow backwards: rather than rollouts being cached into a model-free learner, a model-free dopaminergic training procedure *compiles a model-based inner algorithm* into recurrent dynamics, and the reward-prediction error inherits task structure because its value term is the prefrontal network's own output (Wang et al. 2018).
- **[[wiki/concepts/expected-free-energy.md]]** — amortization split into two compiled objects that are optimised in different phases: the recognition density `ν` (perception, fitted by variational free energy) and the latent policy `π` (planning, fitted by expected free energy), composed at deployment as `β = π∘ν` with `ν` held fixed throughout planning (Milosevic et al. 2026).
- **[[wiki/concepts/successor-representation.md]]** — the wiki's clearest worked example of compiling model-based computation into a cached object: half the Bellman computation stored ahead of time, with obstacle insertion as the exact price of the caching.
- **[[wiki/entities/neuromatch.md]]** — structural amortisation on an NP-complete query: subgraph containment answered by precomputed order embeddings plus a coordinate comparison, with all the cost moved offline.
