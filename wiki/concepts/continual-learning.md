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

---

## Solution families

| Family | Mechanism | Biological ancestor | Cost |
|---|---|---|---|
| **Weight protection** | Penalize movement of parameters important to earlier tasks. Elastic weight consolidation (EWC): `L = L_B(θ) + Σ_i (λ/2) F_i (θ_i − θ*_{A,i})²`, `F_i` a Fisher-information estimate of parameter *i*'s importance to A | Spine stability / cascade states — a direct import | Importance estimates accumulate; capacity saturates |
| **Rehearsal / replay** | Interleave stored or generated samples of earlier tasks | Hippocampal replay ([[wiki/concepts/complementary-learning-systems.md]]) | Storage; a generator that must not itself drift |
| **Architectural growth** | Freeze prior parameters, add capacity with lateral access to them (progressive networks) | Cortical recruitment (weak analogy) | Parameter count scales with task count |
| **Modularity / routing** | Different tasks recruit different sub-networks | Functional specialization | Needs task identity, or a router that must itself be learned continually |

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
