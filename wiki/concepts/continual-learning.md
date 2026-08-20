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
| **Address-space separation** | Do not protect anything: give each task a random position in a prestructured code so large that collisions are improbable, and let all weights stay fully plastic | Random grid-phase re-initialisation on entering a new environment ([[wiki/entities/vector-hash.md]]) | Buys non-interference by orthogonality, so nothing transfers between tasks either |
| **Recall gating** | Gate the slow store's write by whether the *fast* store already recalls the proposed update: `Δw_LTM ∝ g(w_STM · w*)`, with the gating scalar realised as prediction accuracy, decision confidence or familiarity ([[wiki/concepts/recall-gated-consolidation.md]]) | Systems consolidation: Drosophila γ1 MBON disinhibiting the α2 dopamine neuron; hippocampus→cortex | Needs no task boundary, no importance estimate and no exemplars, but the threshold encodes an unknown estimate of how reliable the environment is — and a stably predictive shortcut passes it |
| **Local plasticity rules** | Do not train with backpropagation at all; let the network keep learning at deployment from local signals, so there is no discrete "training period" whose end causes the problem | Synaptic plasticity, metaplasticity, neuromodulation | Local rules are correlation detectors ([[wiki/concepts/synaptic-plasticity.md]]); a discovered rule generalizes only over its meta-training distribution |

**Assimilation: the biological answer, measured (Qu et al. 2026).** Adding four new items to the centre of an already-learned 5×5 conceptual map does *not* re-fit the map. The entorhinal grid orientation estimated before the insertion still predicts the six-fold code over trajectories through the new items, and per-subject **frame constancy predicts inference accuracy over the new items** (`r` = 0.21) while being uncorrelated with age. What *does* change and *does* develop is the medial-prefrontal distance readout, which independently mediates the age effect on the new inferences after the old map's performance is partialled out.

Read as a solution family, this is **address-space separation plus a re-trained readout**: the structural code is treated as infrastructure that must not move — its constancy is precisely what makes the new items reachable from distant old ones without traversing them — while the content bindings and the metric head absorb the update. Two consequences for the table above: (i) the protected set is chosen by *role* (`g`) rather than by a Fisher-style importance estimate, which sidesteps the "protecting the right level" open problem below by construction; (ii) the case is a **partial update to a map that is otherwise unchanged**, which is not the task-sequence benchmark any method in the table is evaluated on, and it comes with a behavioural score for how well the frame survived ([[wiki/concepts/cognitive-map.md]]).

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

- **[[wiki/concepts/cognitive-map.md]]** — supplies the one setting where the protect-vs-overwrite decision is made by *role* and its outcome is measured: new nodes are assimilated into a held-constant entorhinal frame while the prefrontal distance readout is rebuilt, with frame constancy predicting reasoning over the new nodes (Qu et al. 2026).


- **[[wiki/concepts/predictive-coding-free-energy.md]]** — an eighth candidate family, asserted rather than measured: if every weight descends only its own layer's residual, no single global output loss is ever free to overwrite structure elsewhere — protection by *objective locality* instead of by gating, replay or separation (talk-nd-brain-learning-algorithm, **(tentative)**).
- **[[wiki/concepts/complementary-learning-systems.md]]** — the same interference problem solved by adding a second fast system instead of gating plasticity inside one; replay and weight protection are complementary.
- **[[wiki/concepts/latent-graph-discovery.md]]** — continual learning is the write mechanism for slow W; without it the meta-graph cannot accumulate across environment families.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — EWC is a clean case of a synaptic finding converted into a loss term, with optogenetic erasure supplying the causal half of the evidence.
- **[[wiki/concepts/meta-learning.md]]** — meta-learning optimizes adaptation to future tasks, continual learning protects performance on past ones; progressive networks pursue both by growing.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — both concern *which* synapses change: credit assignment sets direction and magnitude, plasticity gating sets eligibility.
- **[[wiki/concepts/synaptic-plasticity.md]]** — metaplasticity is the biological mechanism elastic weight consolidation reimplements as a loss term, and it gates writability without needing task boundaries.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — a discovered plasticity rule can carry its own consolidation schedule instead of receiving one as an external penalty; online one-shot continual learning is that branch's headline result.
- **[[wiki/concepts/shortcut-learning.md]]** — importance-gated plasticity protects whatever the model found predictive, so a shortcut consolidated into slow W is protected *as if* it were structure; out-of-distribution validation has to gate the write.
- **[[wiki/concepts/contextual-inference.md]]** — removes the task-boundary assumption above: boundaries are inferred rather than given, and plasticity is gated by *relevance* (a memory updates in proportion to its responsibility for the current observation) rather than by *importance*, so no Fisher matrix and no task label are needed (Heald et al. 2021).
- **[[wiki/concepts/pattern-separation-completion.md]]** — the third solution family for the same interference problem: orthogonalize the *codes* before writing rather than gate the weights or replay, with dentate-gyrus lesion and NMDA-receptor knockout data showing the orthogonalization is necessary for discrimination but not for plain conditioning (Yassa & Stark 2011).
- **[[wiki/entities/vector-hash.md]]** — a fourth solution family this table did not have: **address-space separation**. Eleven environments learned in sequence with zero forgetting, no weight protection, no replay, no task boundary and no importance estimate, because each new map takes a random initial state in an exponentially large prestructured code and therefore does not collide. The cost is that non-interference is bought by orthogonality, so nothing transfers *between* the maps either (Chandra et al. 2023).
- **[[wiki/concepts/offline-replay.md]]** — supplies the selection rule rehearsal is missing: biological replay culls rather than reproduces, because consolidating everything overfits, and it upsamples the under-visited rather than the high-reward.
- **[[wiki/entities/context-modular-memory-network.md]]** — a fifth solution family: **mask separation**. Contexts share both neurons and synapses (>50% of synapses serve 2–5 contexts at optimal random gating) yet do not interfere, because interference is removed at *recall* by a per-context binary mask rather than prevented at write — so unlike address-space separation it does not forbid transfer between tasks, and unlike importance-gating it needs no Fisher matrix, only one bit per synapse per context.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the mechanistic account of why sparse codes resist catastrophic interference, with the residual quantified: a write for one pattern touches almost no coordinate that a detector for another pattern samples, and the leftover interference is exactly the subsampling false-positive formula — protection without any importance estimate, gating or replay.
- **[[wiki/entities/dendritic-ann.md]]** — interference resistance bought by wiring alone: under class-blocked training (gradients from one class at a time for 50 epochs) a dendritically masked network is more accurate and less seed-variable than its dense twin, with no replay, no penalty and no dedicated module — the proposed mechanism being that mixed-selective, fully utilised units are less disrupted by single-class gradients (Chavlis & Poirazi 2025).
- **[[wiki/concepts/recall-gated-consolidation.md]]** — a seventh solution family, and the cheapest to compute: gate the slow write on whether the fast learner already recalls the proposed update. No Fisher matrix, no task boundary, no stored exemplars, no growth — one broadcast scalar per event, which is why it works on an unsegmented stream (Lindsey & Litwin-Kumar 2024).
- **[[wiki/concepts/manifold-constrained-learning.md]]** — the cost side of address-space separation, measured: placing a new task orthogonally to old ones is exactly the kind of change a population cannot make quickly, since M1 learns readouts inside its existing co-modulation subspace within a session and fails to learn ones requiring new co-modulation patterns — so non-interference by orthogonality and fast acquisition of new skills pull against each other (Sadtler et al. 2014).
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — a stopping criterion for the slow write that needs no task boundary, no importance estimate and no stored exemplars, only an estimate of how predictable the current relation is; and a warning this family does not carry, that a correctly functioning replay buffer *degrades* the learner it feeds once the environment is partly unpredictable (Sun et al. 2023).
- **[[wiki/concepts/cognitive-control.md]]** — the case where overwriting may be the design rather than the failure: retraining monkeys on category boundaries orthogonal to the ones they had learned leaves the *new* partition in prefrontal delay activity and no trace of the old, in the same cells — a control layer that holds whichever quotient the current task needs, for which this page's protection mechanisms would be actively harmful (Freedman et al. 2001, in Miller et al. 2002).
- **[[wiki/concepts/schema-assimilation.md]]** — names the operation this page's mechanisms are built to prevent: accommodation is a targeted rewrite of an existing structure so it can admit a conflicting item, and importance-gated plasticity protects exactly the weights that would have to change — so consolidation and accommodation want opposite things from the same parameters, and no rule in either literature does the rewrite without collateral damage.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — where the amygdala write-lock lands as a proposal: a third region licensing plasticity on an edge is edge-level write protection, which is a target for interference control that unit-level importance weighting cannot express.
- **[[wiki/entities/coin-model.md]]** — relevance-gated plasticity with no task boundary and no importance estimate: every memory updates in proportion to how much it explains the current observation.
