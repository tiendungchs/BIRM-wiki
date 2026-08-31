# Affordance–Active-Inference Model (Friston et al. 2012)

**A two-level active-inference agent in which dopamine appears nowhere as a *signal* and only as the postsynaptic gain `Π` on each level's prediction errors — so depleting the same scalar at three anatomical sites produces three qualitatively different motor syndromes, including a sign reversal in reaction time, from one unchanged mechanism.**

> **Provenance.** Friston, Shiner, FitzGerald, Galea, Adams, Brown, Dolan, Moran, Stephan & Bestmann 2012, *Dopamine, Affordance and Active Inference*, PLoS Comput Biol 8(1):e1002327 (`raw/friston-2012-dopamine-affordance-active-inference.md`). A simulation paper: one synthetic cued-reaching task, no data fitted, no empirical comparison run (the authors defer that to a "forthcoming paper"). Equations and integrator are the generic generalised-filtering scheme of [[wiki/concepts/predictive-coding-free-energy.md]], reused unmodified — the model is entirely in the choice of generative model and in where the precisions sit.

This is the wiki's only worked instance of the [[wiki/concepts/precision-weighting.md]] dopamine reading operating a *behaving* agent, and the thing to take from it is not the Parkinson's story but the **level-specificity**: a builder who places one gain register at the wrong height in a hierarchy does not get a weaker version of the intended effect, it gets the opposite one.

---

## Architecture

Generalised predictive coding (Equation 3 of the source) applied to the generative model below, with prediction units and error units assigned to regions. Error units are the ones dopamine gates.

| Level | Quantity | Unit type | Assigned region | Precision gated by |
|---|---|---|---|---|
| Sensory | arm position in extrinsic (visual) coordinates | error | parietal cortex | mesocortical |
| Sensory | salience (illumination) of the 4 target locations | error | **superior colliculus** | nigrotectal |
| Sensory | proprioception (joint angles) | error → reflex | spinal ventral horn | — (this *is* action) |
| 1 (fast) | hidden state: arm angular position | prediction | motor cortex | mesocortical |
| 1 (fast) | hidden state: **affordance** of each of 4 locations | prediction | **premotor cortex** | mesocortical |
| 2 (slow) | hidden cause: cycle *speed* `v⁽¹⁾` (= set) | error | **striatum / basal ganglia** | nigrostriatal |
| 2 (slow) | hidden state: context (sequential vs random) | prediction | prefrontal cortex | mesocortical |

Action is not chosen. Level-1 affordance predictions are unpacked downward into proprioceptive predictions and discharged by classical reflex arcs — `ȧ = −∂_a F` acts only through sensory prediction error, so **the whole motor system is a servo on a prediction** and dopamine's grip on behaviour is entirely a grip on which predictions are precise enough to be worth enforcing.

---

## The generative model: a slow pattern generator that sets the *rate* of a fast one

Both levels use the same **winnerless competition** — generalised Lotka–Volterra dynamics whose trajectory is a stable heteroclinic channel connecting unstable fixed points, each attractive in one dimension and repelling in another, so the state is expelled from each and captured by the next ([[wiki/concepts/metastability.md]]).

```
level 2 (slow, 8× the period):   ẋ⁽²⁾ = f_LV( x⁽²⁾ )
                                 v⁽¹⁾  = softmax( x⁽²⁾ )          # context → rate
level 1 (fast):                  ẋ⁽¹⁾ = f_LV( x⁽¹⁾ ) · v⁽¹⁾       # 4 affordance states
                                 ℓ     = L · softmax( x⁽¹⁾ )      # affordance → target location
                                 predictions: arm drawn toward ℓ ; location ℓ is salient
```

Three properties, none of which the wiki's other sequence generators have together:

| Property | Consequence |
|---|---|
| The itinerant dynamics are a **prior belief**, not the network's forward dynamics | the agent expects the world to cycle; behaviour is what happens when that expectation is enforced by reflex. Reverse the cue order and the *same* dynamics produce an error, not a different output |
| The higher level sets the lower one's **rate**, not its content | one scalar `v⁽¹⁾` ranges from "run the sequence" to `≈0` = "no sequential contingency, wait for the cue". Context selection costs one hidden cause, not a second policy |
| Nothing is modelled explicitly | evidence accumulation, delay-period working memory, anticipation, action selection, set switching and reversal all fall out of inverting this one model. The authors note that the identical Lotka–Volterra formulation independently yields a working-memory capacity bound of ~7 items |

---

## Results

**Baseline (log precision 4 everywhere).** Four targets, cued every 12 bins of 64 ms, 128 bins; five cues clockwise then five anticlockwise. Anticipation makes predictable trials fast; at reversal, level-2 error deflects, context expectations switch after ~2 trials, and the switch is paid for as a transient reaction-time and accuracy cost. Precise sensory evidence overrides a violated top-down sequence prior.

**Depletion.** Reduce the log precision by 50% in six steps, one site at a time. Level-1 error accumulates while level-2 error *decreases* — the reciprocity is the signature: an imprecise low level makes inference over-reliant on priors and less willing to revise them.

| Site depleted | Its errors are about | Level | Bradykinesia | Perseveration | Reaction time |
|---|---|---|---|---|---|
| **Superior colliculus** | exteroceptive salience of cue locations | low | yes | yes | **↑** |
| **Motor cortex** | proprioception / angular position | low | yes | **no** | ↑ (non-specific) |
| **Premotor cortex** | change in affordance | high | **no** | yes | **↓** |

The third row is the load-bearing one. Raising precision at a *higher* level has the opposite effect to raising it at a lower one: the agent grows overconfident in its empirical priors, so cue-driven reactions degrade slightly while set switching gets *faster*. There is a real trade-off between the efficiency with which cues elicit movement and the efficiency of switching, and it is controlled by the ratio of precisions across levels rather than by any of them alone.

At the lowest simulated dopamine the set switch never happens at all and the agent keeps reaching toward the falsely anticipated next target, requiring a corrective sub-movement each trial — latent bradykinesia plus perseveration from one depleted scalar.

**The bidirectional prediction.** Excess low-level precision is the mirror image: subliminal fluctuations in ascending prediction error become potent enough to trigger movement, i.e. **aberrant affordance**, offered as a reading of the hyperkinetic disorders (levodopa-induced dyskinesia, Tourette syndrome, hemiballismus) that produce structured but non-purposeful movement rather than myoclonus.

---

## Three arguments the simulation is a vehicle for

| Argument | Content |
|---|---|
| **Dopamine cannot carry content, only gain** | Dopamine acts through G-protein-coupled receptors concentrated in dendritic spines expressing glutamatergic synapses; it *modulates* postsynaptic responses and cannot excite them. So whatever information a rewarding cue conveys, dopamine is not the wire carrying it — it is the wire scaling it |
| **The cell count matches a precision, not a content variable** | A statistical model has far more parameters than precision hyperparameters (a two-factor design: hundreds of parameters, two variances). Dopaminergic cells are correspondingly few against the cells encoding causes — a dimensional argument for a **low-rank gain register**, and one of the few quantitative constraints in the wiki on how big such a register should be |
| **Reward is a consequence of behaviour, not a cause of it** | Value-based accounts define reward by its ability to elicit reward-seeking and then explain reward-seeking by reward. Replacing value with priors over sensory trajectories removes the circle and the Bellman solve at once ([[wiki/concepts/precision-weighting.md]]) — at the price the wiki already logs: re-goaling becomes model surgery (G28) |

---

## Limitations

- **The precisions are hand-set constants.** The paper explicitly assumes tonic dopamine encodes a *fixed* level and does not model its optimisation. So this tests what a gain register **buys**, and says nothing about how it is **set** — G56's set-point half is untouched.
- **Tonic only.** No phasic bursts, no dopamine-dependent plasticity, no D₁/D₂ split (D₁ on principal cells only, explicitly), no striatal clearance kinetics — which is precisely the machinery [[wiki/entities/basal-ganglia.md]] says the sign of the effect depends on.
- **No learning.** The sequence prior is installed by fiat. The claim that "repeated exposure would instantiate it" is asserted, not simulated.
- **The anatomy is illustrative.** The authors say the regional assignment "should not be taken too seriously"; the lesion dissociation is a claim about *hierarchical level*, and the region names are a readable stand-in for level.
- **No empirical comparison.** Every Parkinson's-disease contact is qualitative and retrospective. The distinguishing prediction — on/off-medication differences concentrated on trials that violate an established sequence, near-absent on in-sequence and on genuinely random trials — is stated and left untested.
- **Scale.** One single-jointed arm (two angular degrees of freedom), four targets, a hand-written two-level generative model, 128 time bins.

---

## Comparison

| | This model | [[wiki/entities/pbwm.md]] | [[wiki/entities/c-ts-model.md]] | [[wiki/entities/deep-active-inference-agent.md]] |
|---|---|---|---|---|
| What dopamine is | postsynaptic gain = precision, fixed per region | `δ`, a teaching signal, gated per stripe by `snr_j` | reinforcement signal training stripe→task-set mappings | absent |
| How context is represented | a hidden state in a **continuous** slow attractor, setting the fast level's rate | a discrete gated stripe | a discrete cluster under a Chinese-restaurant prior | a latent in a deep HMM |
| How a switch happens | evidence accumulates until the slow state is expelled from its fixed point | a gating action is selected and reinforced | posterior mass moves to another cluster, or a new one is opened | policy re-selected by expected free energy |
| What sets the switch *rate* | the precision ratio across levels — **one scalar, and it is anatomically placed** | learning rate and gating threshold | concentration `α` and selection noise | the temperature on `G` |
| Learning | none | yes | yes | yes |
| Behaviour | emitted by reflex arcs servoing a prediction | selected as an action | selected as an action | selected as an action |

The row that matters: this is the only entry where **the switch rate is a property of a gain register rather than of a decision rule**, which is why it can be lesioned regionally and why the lesion has a sign.

---

## Connections

- **[[wiki/concepts/precision-weighting.md]]** — the page this model instantiates, and the one thing it adds that the framing paper could not: precision is not one number but a *field over hierarchical levels*, and the behavioural sign of a change in it flips with height, so "dopamine is precision" only becomes a prediction once the level is named.
- **[[wiki/concepts/reward-prediction-error.md]]** — the rival identity for the same firing record; this model is the constructive half of the case against it, showing that anticipation, switching and their costs need no value function anywhere, and supplying the mechanistic objection that a modulator cannot carry content it can only scale (T122).
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the message-passing scheme reused unmodified: superficial pyramidal error units forward, deep pyramidal predictions backward, and the model's entire content is the generative model plugged into it plus where `Π` is placed.
- **[[wiki/entities/basal-ganglia.md]]** — the same structure read as a *level* rather than as a selector: striatal spiny neurons as prediction-error units for the contextual hidden cause, targeted by backward (layer-V) corticostriatal projections, which puts the module below prefrontal cortex in the hierarchy ([[wiki/empirical-tensions.md]] T303).
- **[[wiki/concepts/autonomous-pattern-generation.md]]** — the conditional-continuation problem answered by nesting: a slow generator that sets the *rate* of a fast one, with the whole stack sitting in the generative model rather than in the forward dynamics, so the sequence is a belief that can be violated instead of an output that cannot.
- **[[wiki/concepts/metastability.md]]** — supplies the dynamical object both levels are built from: a stable heteroclinic channel, whose defining property (every fixed point unstable in some direction) is what makes the sequence run without a clock and what makes it interruptible by a precise enough prediction error.
- **[[wiki/concepts/cognitive-control.md]]** — set switching without a controller: the switch is an inference about a slow hidden state, the switch *cost* is the evidence-accumulation delay, and perseveration is that delay diverging as low-level precision falls.
- **[[wiki/entities/c-ts-model.md]]** — the discrete rival for the same phenomenon: a context is a cluster grown by a nonparametric prior and selected by a gating action there, a continuous slow attractor state that sets a rate here — and only the second predicts that the switch rate has an anatomical address whose lesion has a *sign*.
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — affordance as an *inferred amodal hidden state* that emits both exteroceptive and proprioceptive predictions, against that page's affordance as a *learned discrete code* under an effect-prediction bottleneck: the same Gibsonian criterion arrived at by inference rather than by training, with no repertoire quantifier and no symbol.
- **[[wiki/concepts/evidence-accumulation.md]]** — the switch latency is an accumulation to a bound that nobody wrote down: the bound is where the slow Lotka–Volterra state loses its fixed point, and the drift rate is the precision of the level below.
- **[[wiki/concepts/attention.md]]** — the explicit symmetry claim: dopaminergic gating on sensorimotor channels and attentional gain on sensory channels are the *same* operation in different projection fields, which makes affordance the motor counterpart of salience.
- **[[wiki/concepts/dynamic-network-connectivity.md]]** — the biological register this model spends: a content-free, D₁-mediated multiplicative gain on principal cells, here shown to be sufficient to produce a behavioural syndrome all by itself when it is set wrong at one level.
- **[[wiki/entities/deep-active-inference-agent.md]]** — the same framework taken to neural-network estimators and finding it does not run (14 of 15 agents diverge); this model runs because every distribution is analytic and every prior is authored, which is the honest statement of what the framework currently costs.
