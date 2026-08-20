# Meta-RL Agent (Prefrontal Cortex as a Meta-Reinforcement Learning System)

**A recurrent network whose weights are trained by a slow, model-free, dopamine-style reward-prediction-error algorithm across a *distribution* of related tasks, until its frozen-weight activity dynamics constitute a second, faster reinforcement-learning algorithm adapted to that distribution** (Wang et al. 2018, `raw/wang-2018-pfc-meta-rl-system.md`).

The primary source behind the meta-RL section of [[wiki/concepts/meta-learning.md]], which the wiki previously carried second-hand from Hassabis et al. 2017.

---

## Architecture

| Component | Implementation | Claimed biological counterpart |
|---|---|---|
| Prefrontal network (PFN) | One fully connected set of LSTM units (input, memory and output gates) | Prefrontal cortex + the dorsal striatum and mediodorsal thalamus it loops with — the "associative loop" of the cortico–basal-ganglia–thalamo–cortical circuit |
| Inputs | Observation `o_t`, **previous action `a_{t-1}`, previous reward `r_{t-1}`** | Perceptual input plus efference/reward information reaching prefrontal cortex |
| Outputs | Softmax over actions `a_t`; one linear unit for state value `v_t` | Action selection and value coding in prefrontal cortex |
| Outer learning | Model-free policy-gradient RL on the recurrent weights, using the RPE `δ`; learning rate **0.00005** | Phasic dopamine driving synaptic plasticity in the prefrontal network and its striatal components |
| Inner learning | **Activity dynamics only** — weights frozen at test | Rapid within-task learning attributed to prefrontal dynamics, not synaptic change |
| Pixel variant | The LSTM is fronted by a convolutional image-processing network (simulation 5) | Sensory cortex feeding the loop |

**The three premises, and the claim.** Recurrent prefrontal circuit + weights trained by a model-free dopaminergic RPE + a *series of interrelated* tasks rather than one task. Each premise is pre-existing; the contribution is that their conjunction is *sufficient* to produce a second, free-standing RL algorithm in the activations — one that handles exploration/exploitation, maintains a value function, and updates a policy, with no explicit mechanism for any of the three.

**Emergence conditions (a falsifiable scope statement).** Recurrence alone suffices for the effect — no specific gating mechanism is required. But the network's inputs must carry recent actions and rewards, and its dynamics must maintain information over the relevant horizon. These two conditions are proposed as what distinguishes the associative loop from the sensorimotor and other cortico-striatal loops, i.e. why meta-RL would be prefrontal rather than generic.

---

## Results — six simulations, weights frozen at test throughout

| # | Task | Result | What it establishes |
|---|---|---|---|
| 0 | Two-armed bandit, arm parameters redrawn per episode | Cumulative regret competitive with Gittins indices, Thompson sampling and UCB; exploration→exploitation transition is slower on harder (0.6/0.4) problems than easy ones (0.25/0.75) | The inner algorithm is a *real* RL algorithm, not a memorised policy |
| 0b | Same, trained on **correlated** bandits (`p_L + p_R = 1`) | Identifies the better arm faster than the independent-bandit network on the same test problem; PCA of hidden state ordered by payoff parameters | The inner algorithm is **specialised to `p(T)`** — the outer loop selects an algorithm, not just its parameters |
| 1 | Probability-matching saccade task (Tsutsui et al.; Lau & Glimcher) | Reproduces matching behaviour and lag-regression profile; single units code previous action, previous reward, their interaction, and current choice value | Reward/action-history coding in dorsolateral prefrontal cortex is *derived*, not designed in |
| 2 | Volatile bandit (Behrens et al.) | Learning rate rises in volatile blocks and falls in stable ones, matching humans and a Bayesian volatility-tracking model; **37 ± 1%** of LSTM units explicitly track volatility. The emergent learning rate is **orders of magnitude larger** than the outer loop's 0.00005 | Adaptive learning rate needs no special-purpose mechanism; the inner algorithm differs *quantitatively and qualitatively* from the one that built it |
| 3 | Reversal task with inferred value (Bromberg-Martin et al.) | Model RPE shows the inferred-value effect — the response to the *un-experienced* cue flips after a reversal on the other cue; PCA shows hidden state clustered by latent task state and abruptly reversing at the reversal trial | Structure-sensitive dopamine signals come for free once the value input to the RPE is the prefrontal network's own output |
| 4 | Two-step task (Daw et al.; Miller et al.) | Stay-probability pattern and multi-lag regression match the *model-based* signature in humans and rats; model RPE regresses on a model-based algorithm at `r² = 0.89` versus `5.8 × 10⁻⁷` for model-free | **Model-based behaviour and model-based RPEs produced by a model-free training algorithm** |
| 5 | Harlow learning-to-learn, novel image pairs every 6 trials, 3D pixel environment | After training, correct from trial 2 onward — one-shot within each new block, matching Harlow's monkeys; 14 of 50 replicas reached maximal performance | The inner algorithm generalises to *never-seen stimuli*, so it is a learning procedure rather than a lookup |
| 6 | RPE fed in **as the network's input** in place of raw reward; simulated optogenetic block/induction (Stopper et al.) | Comparable behaviour on tasks 1–5; blocking DA at reward reduces preference for that lever and inducing DA at omission raises it — **with weights fixed** | Dual role for dopamine: teaching signal *and* observation. Optogenetic behaviour shifts need not be synaptic |

---

## What is load-bearing for the wiki

1. **The fast level can be state.** The clearest existence proof that a two-timescale learner does not require a second memory system — the inner learner is the hidden state of the same network ([[wiki/empirical-tensions.md]] T2, against [[wiki/concepts/complementary-learning-systems.md]]).
2. **Model-based behaviour is not evidence of a model-based learning algorithm.** Simulation 4 breaks the inference the wiki's re-goaling and two-step protocols rely on ([[wiki/concepts/simulation-based-planning.md]], gap G17). The two-step signature certifies the *inner* algorithm and says nothing about the outer one.
3. **The teaching signal doubles as an input.** Simulation 6 makes `δ` both the plasticity modulator and part of `o_t`, which is a structural feature no other architecture in the wiki has (gap G57).
4. **Specialisation is the product.** What the outer loop delivers is not a good initialisation but an *algorithm shaped to `p(T)`* — visible as a learning rate that responds to volatility, and as structure exploitation in the correlated-bandit case.
5. **A latent-state code appears without being asked for.** Simulation 3's hidden state clusters by the task's latent state and flips at reversal — the meta-RL route to what [[wiki/concepts/contextual-inference.md]] gets from an explicit posterior and [[wiki/concepts/abstract-structural-codes.md]] gets from a structural module.

---

## Predictions the theory commits to

| Prediction | Discriminates against |
|---|---|
| Interfering with phasic dopamine *during initial training* should block the later emergence of model-based control on two-step-like tasks | Accounts where prefrontal model-based control is independent of dopaminergic training |
| Lesioning/inactivating prefrontal cortex or its striatal nuclei should abolish **model-based dopaminergic RPEs** | Accounts where the RPE's structure sensitivity is computed inside the dopamine system |
| Prefrontal unit activity in animals should be predicted by the model's hidden-unit activity on matched tasks | Any account that treats prefrontal reward-history coding as a designed feature |

---

## Limitations

| Limitation | Detail |
|---|---|
| No regional specialisation | All of prefrontal cortex is one fully connected network, yet simulation 1/4 correlates are dorsolateral and simulation 2's volatility coding is anterior cingulate; orbitofrontal/ventromedial latent-state coding is acknowledged and unmodelled |
| The striatal gate is skipped | The cortico-striatal loop is asserted as the substrate but the simulations use a generic LSTM; replicating the results in an explicit gating model is left as future work ([[wiki/entities/pbwm.md]]) |
| Qualitative fits only | Deliberately no parameter fitting to data — robust qualitative effects, so the theory is not quantitatively constrained by any of the six datasets |
| Replica variance | Harlow: 14/50 replicas reached maximal performance; the emergent algorithm is not a reliable product of the training procedure |
| `p(T)` is authored | Every task distribution is hand-specified; inherits the knowledge-boundedness limit of [[wiki/concepts/meta-learning.md]] in full |
| Inner learner is opaque | The algorithm exists only as dynamics — it can be characterised post hoc (regret curves, learning rates, PCA) but not read out, edited, or composed |

---

## Comparison

| System | Where the fast learner lives | Who trains it | What is explicit |
|---|---|---|---|
| **Meta-RL agent** | LSTM hidden state | Model-free RPE on the recurrent weights | Nothing — exploration, value, learning rate and latent state all emerge |
| **[[wiki/entities/pbwm.md]]** | Prefrontal stripe activity | Same dopaminergic critic, but it trains a **gating policy** | The write-enable; PVLV replaces the TD prediction chain with associations ([[wiki/empirical-tensions.md]] T85) |
| **[[wiki/entities/differentiable-neural-computer.md]]** | External memory matrix | Task loss through differentiable addressing | Read/write addressing, temporal links, allocation |
| **[[wiki/entities/stsp-working-memory-rnn.md]]** | Short-term synaptic facilitation | Task loss | The decay constant; storage is in synapses, not activity |
| **[[wiki/concepts/complementary-learning-systems.md]]** | A second anatomical store | Different learning rules per system | The system boundary |
| **[[wiki/entities/coin-model.md]]** | Posterior over an unbounded context set | Bayesian filtering, no outer loop | The latent state that meta-RL leaves implicit in PCA space |

**(brainstorm)** The most useful thing to steal is not the LSTM, it is the input convention. Feeding `(o_t, a_{t-1}, r_{t-1})` is what turns a sequence model into a learner, because it makes the agent's own experience part of the observable state — an in-context RL setup written in 2018 in RL notation. The wiki's structural models ([[wiki/entities/tolman-eichenbaum-machine.md]], [[wiki/entities/cscg.md]]) feed observations and actions but not *outcomes*, so their inner loop can bind an instance-graph but cannot bind a *policy* over it. Adding the reward channel is a one-line change with a two-level consequence.

---

## Connections

- **[[wiki/concepts/meta-learning.md]]** — the primary source for this page's parent concept: the outer loop over `p(T)` is dopaminergic RL on the recurrent weights, and the inner loop is the frozen-weight activity dynamics, so "learning to learn" is instantiated with both levels named biologically.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the direct rival on where the fast level lives: recurrent state in one network versus a second anatomical store with its own learning rule ([[wiki/empirical-tensions.md]] T2).
- **[[wiki/concepts/simulation-based-planning.md]]** — undercuts the diagnostic value of the two-step task: a model-free-trained recurrent network reproduces the model-based stay pattern and model-based RPEs (`r² = 0.89`), so the signature certifies the emergent inner algorithm rather than the mechanism that built it.
- **[[wiki/concepts/amortized-inference.md]]** — runs that page's compilation arrow backwards: there, model-based rollouts are cached into a model-free controller; here, a model-free training procedure *compiles a model-based inner algorithm*, and the RPE's structure sensitivity comes from the prefrontal network's value output feeding the error term.
- **[[wiki/entities/pbwm.md]]** — the same dopaminergic critic training the same prefrontal circuit toward the same two-loop shape, with the write-enable made explicit; the striatal gating theory it belongs to was itself inspired by LSTM gating, and this page's effect is claimed to need only recurrence, not any particular gate.
- **[[wiki/concepts/working-memory.md]]** — the inner learner is nothing but maintained activity, so this architecture's adaptation horizon is exactly the maintenance horizon of the recurrent store, and the stated emergence conditions make maintenance a prerequisite rather than a side benefit.
- **[[wiki/concepts/cognitive-control.md]]** — supplies the trainable mechanism behind the "task model held as activity" reading: a swap of prefrontal state at block boundaries is what the hidden-state PCA shows at reversal, and it is produced by reward-driven training of the recurrence rather than by a control module.
- **[[wiki/concepts/contextual-inference.md]]** — the same latent-state-tracking function reached from the other side: an explicit posterior with a Dirichlet-process prior there, an emergent state cluster that flips at reversal here, with dopamine consuming the inferred state in both.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the wiki's cleanest AI→neuroscience transfer, now with the primary source: an RL construct built for machines is offered as a theory of dopamine–prefrontal division of labour, complete with lesion and optogenetic predictions.
- **[[wiki/concepts/dynamic-network-connectivity.md]]** — the same prefrontal recurrence viewed at a different register: here it is the substrate that must merely persist long enough for the inner algorithm to run, there it is a gain-controlled connection whose strength is set moment-to-moment by neuromodulators.
- **[[wiki/entities/coin-model.md]]** — the explicit-posterior counterpart of simulation 2's emergent learning-rate control: volatility handled by inference over contexts versus volatility tracked by 37% of units with no inference machinery.
- **[[wiki/concepts/latent-graph-discovery.md]]** — an instance-graph bound entirely in recurrent state (which arm, which latent reversal state, which of two novel images pays) with the meta-graph in weights, and no explicit representation of either.
- **[[wiki/entities/spacetime-attractor.md]]** — names the inner algorithm this page leaves opaque: RNNs meta-trained on planning tasks with reward that changes within the trial converge on a spacetime attractor — explicit future subspaces, recurrent weights matching the maze adjacency matrix (0.91 ± 0.07), and discrete attractor switching under perturbation — so "structure in weights, adaptation in dynamics" gains a readable mechanism (Jensen et al. 2026).
