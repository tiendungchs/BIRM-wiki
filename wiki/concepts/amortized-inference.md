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
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — a rival account of fast inference: instead of compiling the posterior into a feed-forward net, run a fast recurrent relaxation to a consistent state; the two differ in whether speed comes from caching or from convergence.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the *speed* constraint the framing otherwise ignores: a graph estimate that cannot be queried in real time is not usable for navigation, however well it is recovered.
- **[[wiki/concepts/core-knowledge.md]]** — abstract-feature-guided hypothesis selection is an entry condition over the hypothesis space rather than over entities: restrict the domain before paying for search.
- **[[wiki/entities/h-jepa.md]]** — the architecture that runs both amortizations at once: a distilled Mode-1 policy for actions and an amortized latent-inference module for uncertainty, with the distilled policy also used to *initialize* the expensive optimization rather than replace it.
- **[[wiki/concepts/energy-based-models.md]]** — supplies the expensive computation being amortized in its most general form: `argmin` over free variables, which covers hypotheses, latents and actions with one operation.
- **[[wiki/entities/bayesian-program-learning.md]]** — the concrete case where inference is the bottleneck: a structured program prior with human-level one-shot results, whose search cost is what amortization would remove.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — makes the cost of amortisation visible in the code length: parameters are an up-front payment counted in the adjusted compression rate, repaid only by streams in the terabytes (Chinchilla 70 B: 8.3% raw, 14008.3% adjusted).
- **[[wiki/entities/hbtom.md]]** — the boundary case that needs no amortisation: conjugacy, a 5-point grid over the rationality parameter, and A\* run only on visited states make exact structured inference fast enough to run online, so compilation is a scale remedy rather than a structural one.
- **[[wiki/concepts/subgraph-matching.md]]** — structural amortisation, worked: an NP-complete relational query becomes an offline `O(K\|E_T\|)` encoding plus an `O(\|V_T\|\|V_Q\|)` coordinate comparison, 0.03 s against 7.5–25.9 s for exact search — with the un-flagged error rate that this page's open problem predicts (Ying et al. 2020).
- **[[wiki/concepts/contextual-inference.md]]** — splits the same two modes by *what has been observed* rather than by compute budget: expression uses the cue-only posterior and must be computed before acting, updating uses the post-feedback posterior (Heald et al. 2021).
- **[[wiki/concepts/cognitive-map.md]]** — the navigational form of compilation: hippocampal involvement falls away once an environment is highly familiar, so map-based route computation appears to be cached into a cheaper policy rather than run every time (Epstein et al. 2017).
