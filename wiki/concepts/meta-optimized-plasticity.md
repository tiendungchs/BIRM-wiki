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

## Sparse selection over a candidate basis — the one setup that yields a *readable* rule (Shervani-Tabar & Rosenbaum 2023)

The four families above all return a rule you cannot read: per-synapse coefficients, or an evolved expression tree. A fifth setup returns an equation in three terms, and it does so by three restrictions stacked deliberately:

| Restriction | Form | What it buys |
|---|---|---|
| **Linear combination of a fixed candidate pool** | `F(Θ) = Σ_{r=0}^{R−1} θ_r F^r`, `R = 10` quadratic-and-higher combinations of `y_ℓ`, `y_{ℓ−1}`, `e_ℓ`, `e_{ℓ−1}`, `W_{ℓ−1,ℓ}` | Search is over `R` scalars, not over expressions; every survivor is already a named rule |
| **L1 penalty on Θ** | `L_meta(Θ) = L(f_W(X_query), Y_query) + λ‖Θ‖₁` | Occam pressure inside the outer loop: 7 of 10 coefficients go to zero by ~600 episodes |
| **Meta-parameter sharing across all layers and synapses** | One `Θ` for the whole network | The output is a *global* learning rule, comparable to backpropagation, rather than a weight-shaped blob |

**And one restriction on the inner loop that removes the field's standing confound.** Weights `W` are **reinitialized randomly every episode** and the inner loop is **online (batch size 1) on 250 data points total** (5-way EMNIST, `K = 50` per class). Nothing is meta-learned except `Θ`. This is stated against Lindsey et al. 2024, Miconi et al. and MAML-descended work, which meta-learn an initialization *alongside* the rule: when both are learned, no experiment separates how much of the gain came from the rule. Here the rule must train a naive network from scratch, so the measured gain is attributable.

**The discovered rule.** Meta-learning over the pool converges to three surviving terms — the pseudo-gradient, an error-based Hebbian term, and Oja's rule:

```
F^bio(Θ) = −θ₀ · e_ℓ y_{ℓ−1}ᵀ                                  (pseudo-gradient, F⁰)
           −θ₂ · e_ℓ e_{ℓ−1}ᵀ                                  (eHebb, F²)
           +θ₉ · ( y_ℓ y_{ℓ−1}ᵀ − (y_ℓ y_ℓᵀ) W_{ℓ−1,ℓ} )       (Oja, F⁹)
```

`e_ℓ` is transmitted through **fixed random** feedback `B` (feedback alignment), never `Wᵀ`. Pure Hebb `y_ℓ y_{ℓ−1}ᵀ` was excluded from the pool by hand because it blew up the activations — the instability of [[wiki/concepts/synaptic-plasticity.md]] rule 1, hit empirically — and replaced by its stabilised descendant `F⁹`.

**Result:** feedback alignment in this regime reaches ~25% on 5-way classification where backpropagation reaches ~70%; the meta-learned pool starts at feedback-alignment accuracy and climbs to backpropagation's by ~300 episodes. The three-term `F^bio` matches the full ten-term pool.

### The two survivors work by *different* mechanisms, and only one has backpropagation as its ceiling

| Term | Mechanism | Ceiling |
|---|---|---|
| **eHebb** `−e_ℓ e_{ℓ−1}ᵀ` | In a linear network, `E[e_ℓ e_{ℓ−1}ᵀ ∣ B_{ℓ,ℓ−1}] ∝ B_{ℓ,ℓ−1}ᵀ`, so the term drives **`W → Bᵀ`**. Alignment is achieved by moving the *forward* weights onto the random feedback, not by moving feedback onto forward. It also opens a **same-iteration** channel from `B_{ℓ+1,ℓ}` into `W_{ℓ,ℓ+1}`, where plain feedback alignment needs two iterations (the information reaches `W_{ℓ,ℓ+1}` only after a forward pass through the updated `W_{ℓ−1,ℓ}`) | **Backpropagation.** Its whole job is to make the pseudo-gradient into the gradient; it cannot exceed the thing it imitates |
| **Oja** `y_ℓ y_{ℓ−1}ᵀ − (y_ℓ y_ℓᵀ) W` | Touches the backward path not at all. Purely unsupervised, label- and loss-independent: it drives weight rows toward an **orthonormal basis** of the PCA subspace of the presynaptic activations, measured directly as rising orthonormality of `W`. Alignment angles are *not* improved — the gain is better-separated hidden features for the predictor layer to read | **None.** It is not imitating backpropagation, so it can be added *to* backpropagation; the authors report it accelerating learning for poorly initialized symmetric-feedback networks too |

**This is the sharpest instance in the wiki of the T7 escape route.** eHebb is a backpropagation-derived local rule and inherits the ceiling that argument predicts. Oja is not, and does not. A discovered rule that beats backpropagation will come from the second column, and meta-learning's real contribution here is that it *found the mixture* — hand-tuning three coefficients spanning two incompatible mechanisms is exactly the search a human does badly.

### What this settles about restriction

The page's open problem — *which restrictions buy generalization and which merely shrink the space* — gets one clean data point. Restriction by **candidate basis + L1 + parameter sharing** does not degrade the discovered rule (three terms match ten) and yields the only interpretable output in the five families. What it does *not* test is out-of-distribution transfer: the rule is meta-trained and evaluated on EMNIST 5-way tasks, so the knowledge-boundedness limit is untouched.

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
- **Restriction is doing the work, and nobody has characterized it.** Variable-shared meta-learning generalizes because of sharing and locality. Which restrictions buy generalization, and which merely shrink the space, is unstated. Shervani-Tabar & Rosenbaum 2023 supply the one controlled data point — candidate basis + L1 + full parameter sharing costs nothing in-distribution — but never test the rule off its meta-training distribution, which is where restriction was supposed to pay.
- **The locality of a discovered rule is a claim about neurons, not about the rule.** Every term in the pool except Oja's uses both `y_ℓ` and `e_ℓ`, so it is local *iff* the same population encodes activations and errors — by time-multiplexing, by apical/basal compartments, or by the burst-vs-single-spike distinction. Nothing in the meta-learning setup checks which; the rule is written as local and the biology is asked to supply the multiplexing afterwards ([[wiki/concepts/dendritic-computation.md]]).
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
- **[[wiki/concepts/three-component-framework.md]]** — the framework turned on itself: if learning rules are searched and some objectives are themselves learned, two of its three components become optimization targets, and the regress it leaves open is gap G9.
- **[[wiki/entities/mm-tem-hippoformer.md]]** — this page's outer/inner split applied to a *relational* store: an outer loop learns the key/value/query projections and three gate networks, the inner loop is online gradient descent on a reconstruction loss with data-dependent forgetting `α_t`, momentum `η_t` and rate `β_t`, and it keeps running at test time — so surprise-gated writing and learned forgetting become the memory's update rule rather than a hand-set decay constant.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — where the discovered rule lands: eHebb is a *repair* for feedback alignment that drives `W → Bᵀ`, i.e. it fixes objection 1 from the forward side while leaving the random feedback untouched, and its backpropagation ceiling is the T7 argument reappearing inside a discovered rule.
- **[[wiki/concepts/objective-identifiability.md]]** — the outer loop is an objective-selection device: L1 on `Θ` plus a fixed candidate basis makes the meta-loss identify *which mechanism* is doing the work, which is why the three-term rule can be read at all where per-synapse rules cannot.
- **[[wiki/concepts/dendritic-computation.md]]** — decides whether a discovered rule is local at all: every candidate term mixing activations `y_ℓ` with errors `e_ℓ` needs one population to carry both, which the basal/apical compartment split is proposed to supply.
- **[[wiki/concepts/recall-gated-consolidation.md]]** — hands this family a concrete object to meta-learn: the gating function `g` on long-term plasticity, whose shape (hard threshold vs non-monotonic band-pass) encodes an assumption about how memories recur in the environment, and whose threshold implicitly encodes an estimate of environmental reliability that no agent knows on arrival.
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — a second concrete object for this family to meta-learn, and a harder one than a gating function: the early-stopping point of consolidation, whose optimal value depends on an environment statistic (predictability) that the agent cannot observe directly and must estimate from covariance structure or from its own initial learning speed.
