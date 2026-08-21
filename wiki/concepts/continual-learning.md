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
| **Context-gated reachability** | Do not protect the weights and do not separate the addresses: gate whether the plastic pathway can be *driven at all*, on a signal that tracks the context rather than the item. Cholinergic tonically active neurons tonically inhibit striatal projection neurons and learn to pause in contexts that pay; leaving the context withdraws the pause, re-inhibits the neurons, and corticostriatal learning simply stops (Ashby & Crossley 2011, via Helie et al. 2013) | Striatal cholinergic interneurons; the same burst-pause circuitry as [[wiki/entities/basal-ganglia.md]] | The old weights are preserved *unreachable*, not preserved *correct* — nothing detects that they have gone stale, and there is no mechanism for revising them without first re-entering the context that licenses them |
| **Subspace allocation with a readable quota** | Represent what each stored item occupies as a soft subspace `C^j` of one shared state space; maintain used space as `A^j = C¹∨…∨C^j`; write only the **logical difference** `C^{j+1} \\ A^j` into the still-unclaimed space `¬A^j` ([[wiki/entities/conceptor.md]], Jaeger 2014) | None claimed — this is an engineering construction on a reservoir | Needs the stored items' subspaces to have near-rectangular singular value spectra; fails on arbitrary patterns without a hand-set thresholding step |
| **Local plasticity rules** | Do not train with backpropagation at all; let the network keep learning at deployment from local signals, so there is no discrete "training period" whose end causes the problem | Synaptic plasticity, metaplasticity, neuromodulation | Local rules are correlation detectors ([[wiki/concepts/synaptic-plasticity.md]]); a discovered rule generalizes only over its meta-training distribution |

**The quota is the row's payload, and it is the only one in this table a system can read at run time.** `q(A^j) = (Σ_i s_i(A^j))/N ∈ [0,1]` is the fraction of the shared space already claimed. Measured behaviour on 16 patterns in a 100-unit reservoir: exact replicas of already-stored patterns consume **zero** additional quota; members 5–16 of a 2-parameter family cost 0.26 where the first four cost 0.52; overload at `q ≈ 0.99` damages **only the pattern being written**, leaving every earlier one intact. So this family answers three questions the others leave open at once — *how full am I* (G42), *is this new item redundant with what I hold* (G38, decided by the data's own geometry rather than by a designer-set novelty threshold), and *what happens at saturation* (a bounded spill, not a collapse).

Two caveats and one anomaly. It is demonstrated only on a reservoir with dynamical patterns as items, at `N ≤ 500`; and it needs the per-item subspaces to be nearly projectors, which holds for integer-periodic drivers and must otherwise be *forced* by pushing the singular values through a steep sigmoid. The anomaly is that on the mixed-pattern condition where that forcing is required, **incremental loading beat simultaneous loading** — mean NRMSE 0.094 against 0.19 with tuned scaling and regularisation — which inverts this page's founding assumption that sequential presentation is a cost paid against joint training ([[wiki/empirical-tensions.md]] T195).

**Extinction is not unlearning, and that is the design point.** The row above is the wiki's only mechanism where the *forgetting curve is a gating artefact*. During acquisition the interneurons learn to pause, the projection neurons are released, and stimulus–response weights are learned by dopamine-gated plasticity. During extinction the interneurons learn the context no longer pays and stop pausing — the projection neurons go back under inhibition, the behaviour disappears, and the acquisition weights are *frozen where they were* because the cells carrying them can no longer be driven by cortex. Re-entering the rewarding context restores the pause and recovers those weights intact, which is where **fast reacquisition** comes from: the second acquisition is faster than the first because there is nothing to relearn.

**(brainstorm)** Every other family in the table pays for retention with a permanent cost — an importance matrix, stored exemplars, frozen parameters, an orthogonality budget. This one pays with a *second, cheaper learner* over contexts, and the expensive weights stay fully plastic whenever they are reachable. The machine form is a per-module scalar gate `c ∈ {0,1}` predicted from context by a fast learner, multiplying both the module's activation and its learning rate — which is the [[wiki/entities/context-modular-memory-network.md]] mask with the mask itself made learned and made a function of the environment rather than an index. The failure mode is specific and worth stating: because the gate suppresses learning as well as output, a module cannot discover that its own contents have become wrong. It can only be re-entered and found stale.

**Assimilation: the biological answer, measured (Qu et al. 2026).** Adding four new items to the centre of an already-learned 5×5 conceptual map does *not* re-fit the map. The entorhinal grid orientation estimated before the insertion still predicts the six-fold code over trajectories through the new items, and per-subject **frame constancy predicts inference accuracy over the new items** (`r` = 0.21) while being uncorrelated with age. What *does* change and *does* develop is the medial-prefrontal distance readout, which independently mediates the age effect on the new inferences after the old map's performance is partialled out.

Read as a solution family, this is **address-space separation plus a re-trained readout**: the structural code is treated as infrastructure that must not move — its constancy is precisely what makes the new items reachable from distant old ones without traversing them — while the content bindings and the metric head absorb the update. Two consequences for the table above: (i) the protected set is chosen by *role* (`g`) rather than by a Fisher-style importance estimate, which sidesteps the "protecting the right level" open problem below by construction; (ii) the case is a **partial update to a map that is otherwise unchanged**, which is not the task-sequence benchmark any method in the table is evaluated on, and it comes with a behavioural score for how well the frame survived ([[wiki/concepts/cognitive-map.md]]).

**The lifelong-learning framing (Schmidgall et al. 2023).** Catastrophic forgetting is attributed specifically to *repeatedly applying backpropagation*: the algorithm has no term expressing the need to preserve prior knowledge, so weights optimized for earlier tasks are as free to move as any other. The proposed route is not a better penalty but a different write mechanism — brain-inspired local learning, where adaptation is continuous and the mature brain is the existence proof (it learns across a lifetime while staying roughly fixed in size). The strongest result so far is **online one-shot continual learning from a meta-optimized spike-timing-dependent plasticity rule** ([[wiki/concepts/meta-optimized-plasticity.md]]), which is a demonstration on a single task family, not a general solution.

**Forgetting inside a *stationary* stream, with no tasks and no boundaries** (Siméoni et al. 2025, [[wiki/entities/dinov3.md]]). Every row above presupposes a sequence — task A then task B — and locates the damage in B overwriting A. DINOv3's 7B trains for 1M iterations on one i.i.d. image distribution with one fixed loss, and a read-out is destroyed anyway: a linear probe on its patch tokens peaks at ~200k iterations and ends **below its own early value**, while the image-level probe rises monotonically throughout. The two "tasks" are the two terms of a single objective, presented simultaneously, and one of them wins over training *time*.

The repair is a family this table has as a row but not in this form: **functional regularisation against a stored earlier self.** `L_Gram = ‖X_S X_Sᵀ − X_G X_Gᵀ‖_F²` holds the current network's patch-similarity structure near that of a checkpoint from 800k steps earlier, refreshed every 10k steps. Compared with the rows above:

| | EWC | Replay | **Gram anchoring** |
|---|---|---|---|
| What is carried forward | an importance estimate over parameters | data | a **relational structure** over one input's tokens |
| Where the constraint acts | parameter space | input space | **function space, and only on second-order structure** — the features are free up to any inner-product-preserving transformation |
| Needs a task boundary | yes | no | no |
| Selection of what to protect | Fisher information | sampling | by *role*: the quantity the surviving objective does not measure |

Two facts about it are the interesting ones for this page. It **repairs rather than prevents** — applied only after the damage, it recovers the read-out in 10k iterations, 1% of the budget that caused the loss, which no weight-protection method can do because the information is gone from the parameters. And the anchor has a **usable age window**: a 100k- or 200k-iteration checkpoint works, a 1M-iteration one is harmful, because by then it has the disease. A rehearsal buffer with an expiry date at *both* ends is not a shape any row above has.

**Forgetting caused by a *downstream module's initialisation*, and the field's answer is to switch learning off** (Kawaharazuka et al. 2025, a survey of Vision-Language-Action models; results attributed to their own sources). Attaching a randomly initialised action head to a pretrained vision-language backbone and training end-to-end degrades the backbone's representations — the damage is done by the transient from an untrained module below, with no task sequence and no distribution shift, and it is the mainstream's most common form of catastrophic forgetting. The remedies in use, ordered by how much learning they give up:

| Remedy | What it does | What it gives up |
|---|---|---|
| **Gradient insulation** | Block gradients from the action head at the backbone boundary | All adaptation of perception to the robot's own visual domain |
| **Full freezing** (GR00T N1.5) | The backbone is not trained at all | As above, and any language grounding in action terms |
| **Low-Rank Adaptation** | Update a low-rank correction only | Reported competitive with full fine-tuning on OpenVLA, at consumer-GPU cost |
| **Staged unfreezing / selective layers** | Delay or restrict which parameters move | Needs a schedule nobody derives |
| **RevLA** | *Gradually reverse* the backbone's weights toward their pretrained values, by analogy with model merging | Repair rather than prevention, like Gram anchoring above, but in parameter space |
| **DSRL** | Do not update the policy at all: learn a distribution over the **initial noise** the diffusion policy denoises from | Reported to take `π₀` from ~20% to ~100% success on 10K samples — adaptation confined to the *input* of a frozen generator |

**(brainstorm)** DSRL is the row with no biological or wiki analogue and the most interesting shape: the learner is not permitted to touch any weight, so the entire adaptation lives in the sampler's initial condition. That is continual learning as *conditioning* — the stability–plasticity trade-off dissolved by making the plastic object a latent input rather than a parameter — and it is immune to every failure this page catalogues, at the price that whatever the frozen policy cannot express is unreachable no matter how much data arrives. The survey also states the field's baseline honestly: once trained offline these models are frozen and "do not adapt to new situations", so none of the rows above is being used to support learning at deployment.

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

- **[[wiki/entities/dinov3.md]]** — forgetting with no task sequence and no distribution shift: one stationary stream, one fixed loss, and a dense read-out decays over 1M iterations while a global one improves — repaired by functional regularisation against a stored earlier checkpoint that constrains only the token-similarity structure, needs no boundary and no importance estimate, and works only from a *young enough* anchor.


- **[[wiki/concepts/cross-embodiment-transfer.md]]** — what the protection is protecting: a backbone pooled across bodies and web-scale data is destroyed by the initialisation transient of a per-body action head, which is why gradient insulation, freezing and Low-Rank Adaptation are the field's default recommendations (gap G65, Kawaharazuka et al. 2025).
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
- **[[wiki/entities/basal-ganglia.md]]** — homeostasis running *against* the learning signal rather than protecting it: a sustained shift in the opponent modulator is partly cancelled over weeks by L-type Ca²⁺ → calcineurin → myocyte enhancer factor 2 → *Arc*/*Nur77* spine elimination in the over-active pathway, so a decision encoded as a persistent neuromodulatory imbalance is structurally re-normalised away — the mirror image of metaplasticity as a consolidation mechanism.
- **[[wiki/entities/basal-ganglia.md]]** — the substrate of the context-gated-reachability row, and its second polarity: the same module whose dopamine-driven opponent plasticity is partly cancelled over weeks by homeostatic spine elimination also carries a cholinergic gate that protects weights by making the cells that hold them undrivable, so one structure supplies both an interference mechanism and a protection mechanism operating on the same synapses.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the stability–plasticity dial as a single broadcast scalar with a substrate and a set-point: high cholinergic tone selects storage mode and low tone retrieval mode, and the tone is proposed to be lowered by oscillation in the sign of the global error signal — a rate rule computed online instead of an importance penalty computed per weight (Doya 2002; Hasselmo & Bower 1993).
- **[[wiki/entities/conceptor.md]]** — the subspace-allocation row above: the wiki's only continual learner that reads its own remaining capacity (`q = Σs_i(C¹∨…∨C^j)/N`), decides allocate-vs-reuse by a Boolean difference against what it already holds rather than by a threshold, and degrades at saturation by spilling one item instead of collapsing — with the standing anomaly that its incremental condition outperformed simultaneous loading on mixed patterns (Jaeger 2014).
- **[[wiki/concepts/memory-read-and-erase.md]]** — the same problem one timescale down: a relevance-addressed erase is targeted forgetting that solves interference by *addressing* rather than by rehearsal or regularisation, and no architecture in either literature has one.
- **[[wiki/entities/anli.md]]** — the unpaid bill of an otherwise-attractive data loop: HAMLET retrains from scratch every round because nothing lets a round's data be added without forgetting, and its authors name catastrophic forgetting and online updating as the open problems standing between three rounds and the never-ending version — so this page's failure mode is what bounds how often a benchmark can be regenerated against its own solvers.
