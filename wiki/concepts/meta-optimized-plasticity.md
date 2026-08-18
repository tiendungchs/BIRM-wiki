# Meta-Optimized Plasticity

**Make the learning rule itself the object of optimization: an outer loop searches over plasticity-rule parameters (or over rule *equations*), while the rule it produces does the within-lifetime learning.**

```
outer:  θ* = argmin_θ  E_T [ L_T( network after inner-loop plasticity with rule params θ ) ]
inner:  Δw_ij(t) = f_θ( x_i, x_j, m(t) )        applied online, during the episode
```

This is the branch [[wiki/concepts/meta-learning.md]] leaves open — meta-learning the *rule* rather than the initialization — and it is where the wiki's two-level hierarchy stops being a metaphor: slow **W** literally becomes the plasticity coefficients, fast **M** literally becomes the weights they update (Schmidgall et al. 2023).

---

## The four families

| Family | Outer loop | What is discovered | Cost |
|---|---|---|---|
| **Differentiable plasticity** | Backpropagation through the plasticity dynamics | Rule *coefficients* (`η` in Hebb, `A₊` in STDP) | **Memory** — backpropagation through time over multiple parameters *per synapse*. Needs parameter sharing or memory-efficient backpropagation to scale |
| **Neuromodulated differentiable plasticity** | Same | The modulatory signal too, in two variants: **global** (a network-output-dependent scalar sets direction and magnitude of all weight changes) and **retroactive** (a dopamine-like signal converts eligibility traces into plastic change within a short window) | Same, plus the modulator network |
| **Evolutionary / genetic** | Population search, no gradient | Coefficients *and*, via Cartesian genetic programming, the rule **equation** itself — automated discovery of biologically plausible rules fitted to the task | **Data** — much lower memory (no backpropagation through time) but needs far more samples for comparable performance |
| **Self-referential** | The network modifies *all* its own parameters recursively | The meta-learner as well as the learner — learning, meta-learning, meta-meta-learning in principle unbounded | Instability; some variants still need a hardwired meta-learner to set the initialization, others eliminate even that |

**Results to date:** sequential associative tasks, familiarity detection, robotic adaptation to motor-gain and rough-terrain domain shift, limb-damage recovery. Short-term plasticity rules optimized this way improve reinforcement and temporal supervised learning. Applied to spiking networks via surrogate gradients, a differentiable STDP rule produced "learning to learn" on **online one-shot** continual learning and one-shot image class recognition ([[wiki/entities/spiking-neural-networks.md]]). Evolvable Neural Units evolve somatic and synaptic compartment models jointly and *independently rediscover* spiking dynamics and reinforcement-type learning rules while solving a T-maze.

---

## Plasticity and in-context learning are the same thing seen twice

Transformers are strong intra-lifetime learners, and so are recurrent networks — but in-context learning changes **activations, not weights**. The review's key structural observation is that this is not a rival mechanism:

| Bridge | Statement |
|---|---|
| **Activations as weights** | Parameter-sharing in the meta-learner leads to the *interpretation of activations as weights*. A fixed-weight model exhibits the learning capabilities of a plastic one |
| **Attention as a weight update** | Self-attention's outer and inner products can be cast as learned weight updates — and can implement gradient descent |

This is direct evidence for position B of [[wiki/empirical-tensions.md]] T2 (fast **M** as recurrent activity rather than a second store), and it downgrades the whole weights-vs-activity question from an architectural choice to a **change of basis** **(brainstorm)**. If activations and weights are interconvertible under parameter sharing, then "does the model have plastic weights?" is the wrong question; the right one is "how many degrees of freedom does the fast level have, and at what timescale do they decay?"

---

## Generalization: the binding constraint

| Finding | Consequence |
|---|---|
| Flat minima generalize better — perturbation `ε` in weight space degrades performance more around *narrow* minima | The standard yardstick for a learning rule is *where in the loss landscape it lands*, not its final training loss |
| **Large, unrestricted rule search spaces generalize worse** | A rule discovered with few restrictions overfits the meta-training task distribution. The freedom that makes discovery interesting is the same freedom that breaks it |
| **Variable-shared meta-learning** parameterizes flexible rules by parameter-shared recurrent networks that locally exchange information — and generalizes to classification problems *not seen during meta-optimization*. Similar results hold for discovered reinforcement learning algorithms | Restriction by *architecture* (sharing + locality), not by hand-written rule form, is the one route shown to survive out of distribution |

The open question the review states plainly: **when should a discovered rule replace a manually derived general-purpose one like backpropagation?** No result yet answers it.

---

## Why this is load-bearing for the wiki's target

- **This is the only mechanism in the wiki that makes slow W a *searched* object rather than a parameter blob.** Self-referential architectures are the first candidate answer to gap G9 (no third tier): a network that modifies its own meta-learner is exactly the rewrite-graph recursion of hardness source 6, instantiated.
- **It converts the two-level split from an emergent property into an architectural one.** In meta-RL the inner learner emerges in recurrent dynamics and can only be inspected after the fact; here the inner learner *is* the rule, written down.
- **It supplies the missing selectivity of [[wiki/concepts/synaptic-plasticity.md]].** A hand-set Hebbian rule writes on any coactivity; a meta-optimized rule can in principle learn *not* to write on coactivity that failed to transfer across the outer loop's task distribution — the identifiability argument of [[wiki/concepts/shortcut-learning.md]] applied to the plasticity rule rather than to the weights.
- **The cost profile is a real design fork.** Differentiable = memory-bound; evolutionary = data-bound. Which is affordable decides the scale at which the fast level can exist at all.

---

## Open problems

- **The knowledge-boundedness limit recurses.** A discovered rule is bounded by the task distribution it was discovered on, exactly as a meta-learned initialization is — and a rule that fails outside `p(T)` is worse than backpropagation, which at least fails predictably.
- **No discovered rule has been shown to acquire *structure*.** Every result above is adaptation (associative recall, motor gain, damage, familiarity), not acquisition of new transition rules.
- **Self-referential stability.** Nothing bounds what a network that edits its own update rule converges to; the reported cases restrict the search space until self-improvement becomes tractable, which is the same restriction that generalization requires — possibly not a coincidence.
- **Restriction is doing the work, and nobody has characterized it.** Variable-shared meta-learning generalizes because of sharing and locality. Which restrictions buy generalization, and which merely shrink the space, is unstated.
- **Memory cost scales per-synapse.** Differentiable plasticity at the scale of a large model is currently out of reach without parameter sharing that may itself remove the expressiveness being paid for.

---

## Connections

- **[[wiki/concepts/synaptic-plasticity.md]]** — supplies the rules whose hand-set coefficients this page hands to an outer loop; without a local rule to parameterize there is nothing to meta-optimize.
- **[[wiki/concepts/meta-learning.md]]** — the same outer/inner structure with the inner learner made explicit as a rule instead of emergent in recurrent activity; this page is the answer to that page's open "meta-learn the rule, not the initialization".
- **[[wiki/concepts/latent-graph-discovery.md]]** — instantiates slow **W** as plasticity coefficients and fast **M** as the weights they write, and self-referential variants are the first candidate third tier (gap G9).
- **[[wiki/concepts/working-memory.md]]** — the activations-as-weights equivalence means an activity-based store and a plastic-weight store are the same object in different bases, so working-memory capacity limits transfer directly onto plastic fast **M**.
- **[[wiki/entities/spiking-neural-networks.md]]** — surrogate gradients made spiking networks differentiable enough for this outer loop, which is how a differentiable STDP rule became trainable.
- **[[wiki/concepts/shortcut-learning.md]]** — a meta-optimized rule is an *optimizer-lever* intervention: one of the four inductive-bias levers, applied to the update rule rather than to the weights.
- **[[wiki/concepts/continual-learning.md]]** — online one-shot continual learning is the headline demonstration of discovered plasticity, and a discovered rule can encode its own consolidation schedule rather than receiving one as a penalty.
