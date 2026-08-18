# Continual Learning

**Master a sequence of tasks without destroying the solutions to earlier ones — the stability–plasticity trade-off.**

Neural networks fail this by default: as parameters move toward the optimum for task B they overwrite the configuration that solved task A (**catastrophic forgetting**). Animals are comparatively good at it, which makes the gap a direct target for [[wiki/concepts/neuroscience-ai-transfer.md]].

---

## The problem, stated

Given tasks `A, B, …` presented sequentially with no access to earlier data:

- Gradient descent on `L_B` treats every parameter as free. Parameters load-bearing for A are as available to overwrite as parameters that were not.
- The information needed to avoid this — *which* parameters mattered for A — is not in `L_B`. It must be carried forward explicitly.

Every solution family below is a different answer to "carry forward *what*?"

---

## Biological evidence: plasticity is not uniform

Two-photon imaging of dendritic spines during learning shows the brain does not treat all synapses as equally writable (Hassabis et al. 2017, reviewing the neocortical-plasticity literature):

| Finding | Implication |
|---|---|
| A proportion of strengthened synapses show **decreased lability** after learning | Plasticity is *per-synapse gated*, not global |
| Reduced lability is mediated by **spine enlargements that persist** despite subsequent learning of other tasks | The gate is structural and long-lived — performance retained over months |
| **Optogenetic erasure of those enlarged spines causes forgetting** of the task | Causal, not correlational: these specific synapses carry the memory |
| Consistent with **cascade models**: synapses transition through a chain of states of decreasing plasticity | A synapse's history sets its writability; repeated confirmation deepens the well |

Computational content: **importance-weighted plasticity**. A synapse that has proven load-bearing becomes progressively harder to change.

**The mechanism has a name in neuroscience: metaplasticity** — the "plasticity of synaptic plasticity", which alters a synapse's *ability* to change by shifting the physiological state of the neuron or synapse, and is proposed as the safeguard keeping a constantly-changing brain from saturating (Schmidgall et al. 2023; [[wiki/concepts/synaptic-plasticity.md]]). This matters for the task-boundary problem below: metaplasticity is **stateful and intrinsic to the synapse**, so it gates writability continuously from the synapse's own history. Elastic weight consolidation reimplements it as an *externally computed* penalty that needs a task boundary at which to compute the Fisher matrix. The biological mechanism does not have that dependency — which suggests the boundary problem is an artefact of the reimplementation, not of the mechanism **(brainstorm)**.

---

## Solution families

| Family | Mechanism | Biological ancestor | Cost |
|---|---|---|---|
| **Weight protection** | Penalize movement of parameters important to earlier tasks. Elastic weight consolidation (EWC): `L = L_B(θ) + Σ_i (λ/2) F_i (θ_i − θ*_{A,i})²`, `F_i` a Fisher-information estimate of parameter *i*'s importance to A | Spine stability / cascade states — a direct import | Importance estimates accumulate; capacity saturates |
| **Rehearsal / replay** | Interleave stored or generated samples of earlier tasks | Hippocampal replay ([[wiki/concepts/complementary-learning-systems.md]]) | Storage; a generator that must not itself drift |
| **Architectural growth** | Freeze prior parameters, add capacity with lateral access to them (progressive networks) | Cortical recruitment (weak analogy) | Parameter count scales with task count |
| **Modularity / routing** | Different tasks recruit different sub-networks | Functional specialization | Needs task identity, or a router that must itself be learned continually |
| **Local plasticity rules** | Do not train with backpropagation at all; let the network keep learning at deployment from local signals, so there is no discrete "training period" whose end causes the problem | Synaptic plasticity, metaplasticity, neuromodulation | Local rules are correlation detectors ([[wiki/concepts/synaptic-plasticity.md]]); a discovered rule generalizes only over its meta-training distribution |

**The lifelong-learning framing (Schmidgall et al. 2023).** Catastrophic forgetting is attributed specifically to *repeatedly applying backpropagation*: the algorithm has no term expressing the need to preserve prior knowledge, so weights optimized for earlier tasks are as free to move as any other. The proposed route is not a better penalty but a different write mechanism — brain-inspired local learning, where adaptation is continuous and the mature brain is the existence proof (it learns across a lifetime while staying roughly fixed in size). The strongest result so far is **online one-shot continual learning from a meta-optimized spike-timing-dependent plasticity rule** ([[wiki/concepts/meta-optimized-plasticity.md]]), which is a demonstration on a single task family, not a general solution.

EWC's practical claim: multiple tasks learned **without an increase in network capacity**, with weights shared efficiently between tasks that have related structure — protection is compatible with transfer, not opposed to it. Demonstrated at scale in deep RL agents.

---

## Why this is central to the wiki's target

The slow **W** of [[wiki/concepts/latent-graph-discovery.md]] *is* an accumulating store: the meta-graph is built from many episodes across many environment families. Continual learning is therefore not a feature but **the mechanism by which W is written at all**.

- A meta-graph learner without weight protection erases earlier families as it meets new ones — it cannot converge on the shared laws it was supposed to extract.
- **(brainstorm)** Fisher importance is a crude proxy for "this parameter encodes shared structure". LGD suggests a sharper criterion: protect parameters encoding *meta-graph* structure (regularities confirmed across instances), leave *instance-graph* parameters fully plastic. That is exactly the W/M split — so the right continual-learning method for this wiki may be the factorization itself rather than an importance penalty bolted onto a flat network.

---

## Open problems

- **Task boundaries.** EWC-style methods assume you know when a task ended; real streams have none, and boundary detection is itself latent-structure inference.
- **Capacity.** Every protected parameter is one fewer degree of freedom. What is the asymptote, and does factorization raise it?
- **Backward transfer.** Protection prevents forgetting but also prevents later evidence from *improving* an earlier solution. Brains revise old knowledge; EWC forbids it.
- **Protecting the right level.** Under non-stationary topology (hardness source 6) what must persist is the rewrite generator, not the object-level edges — protecting the wrong level freezes exactly what should stay plastic.

---

## Connections

- **[[wiki/concepts/complementary-learning-systems.md]]** — the same interference problem solved by adding a second fast system instead of gating plasticity inside one; replay and weight protection are complementary.
- **[[wiki/concepts/latent-graph-discovery.md]]** — continual learning is the write mechanism for slow W; without it the meta-graph cannot accumulate across environment families.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — EWC is a clean case of a synaptic finding converted into a loss term, with optogenetic erasure supplying the causal half of the evidence.
- **[[wiki/concepts/meta-learning.md]]** — meta-learning optimizes adaptation to future tasks, continual learning protects performance on past ones; progressive networks pursue both by growing.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — both concern *which* synapses change: credit assignment sets direction and magnitude, plasticity gating sets eligibility.
- **[[wiki/concepts/synaptic-plasticity.md]]** — metaplasticity is the biological mechanism elastic weight consolidation reimplements as a loss term, and it gates writability without needing task boundaries.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — a discovered plasticity rule can carry its own consolidation schedule instead of receiving one as an external penalty; online one-shot continual learning is that branch's headline result.
- **[[wiki/concepts/shortcut-learning.md]]** — importance-gated plasticity protects whatever the model found predictive, so a shortcut consolidated into slow W is protected *as if* it were structure; out-of-distribution validation has to gate the write.
