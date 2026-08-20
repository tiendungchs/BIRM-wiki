# Arbitrary Sensorimotor Mapping

**An edge from a cue to an action whose endpoints share no spatial, perceptual or causal relation — so the edge carries no information except its own existence, and can only be stored, never computed.**

> **Provenance.** Wise & Murray 2000, *Arbitrary associations between antecedents and actions*, TINS (`raw/wise-2000-arbitrary-antecedent-action-associations.md`). A review of monkey ablation, human neuroimaging and monkey single-unit work on conditional motor learning, stated in propositional form: *if antecedent, then consequent*, where the antecedent maps arbitrarily onto the consequent.

The wiki's graph framing ([[wiki/concepts/latent-graph-discovery.md]]) has so far been populated with edges that are *inferable* — spatial adjacency, temporal succession, causal dependence — all of which give a learner leverage: knowing some edges constrains the rest. This page names the class where that leverage is exactly zero. It is the cleanest biological instance of gap G11 (the non-embeddable symbolic slice), and the reason the brain devotes a distributed frontal–striatal–hippocampal network to a function that looks, computationally, like a lookup table.

---

## The taxonomy of visuomotor mappings

| Class | Relation between cue and action | What a learner can exploit | Example |
|---|---|---|---|
| **Standard** | The cue *is* the target of action | Everything — the mapping is a coordinate transform, learnable once and applied to any new cue location | Reach to the seen object |
| **Transformational** (nonstandard) | Cue location is an *input to an algorithm* that produces the target | The algorithm generalises across cue positions; still fully determined by geometry | Aiming a tennis shot to the opponent's backhand |
| **Arbitrary** (nonstandard) | Cue location "neither constrains nor determines action" | Nothing. Each pair must be acquired independently | Stop at a red light; twist a handle for a yellow placard |

**The consequence Wise & Murray draw:** arbitrary mapping "liberat[es] the sensory guidance of action from the shackles of spatial information", so that *any* action already in the repertoire can be selected by *any* input. Flexibility is bought by discarding the very structure that made the other two classes cheap.

**(brainstorm)** Read against the framing, the three classes are a difficulty ladder for edge learning that is orthogonal to the hardness sources on [[wiki/concepts/latent-graph-discovery.md]]:

| Class | Sample cost of `n` edges | Transfer to edge `n+1` |
|---|---|---|
| Standard | `O(1)` — one transform | Free |
| Transformational | `O(1)` per algorithm, `O(k)` for `k` algorithms | Free within an algorithm |
| Arbitrary | `O(n)` — each pair paid for separately | **Zero by construction** |

A benchmark of arbitrary mappings therefore has a *known, non-zero* generalization difficulty in the sense of [[wiki/concepts/skill-acquisition-efficiency.md]] — the training solution provably does not contain the test solution — which makes it one of the few task families where `GD` need not be estimated. What it cannot test is structure discovery, since there is no structure to discover. The two together make it a **control task**: any system whose "reasoning" score does not exceed its arbitrary-mapping score has been measured on binding speed, not on inference.

---

## Learning rate: the number to carry

Rhesus monkeys, three-direction joystick, three novel cues per set:

| Quantity | Value |
|---|---|
| New mappings acquired per day (experienced animals) | **24** |
| Trials to substantial learning | ~10 trials total ≈ **3 trials/cue** |
| Trials to <10% error | ~25 trials total ≈ **8 trials/cue** |
| Asymptote | Near-perfect for some animals |

Roughly one bit of binding per few trials, in a system that has never seen these cues before, with no gradient step available at that timescale. This is the same order as the one-shot binding budget the wiki assigns to the fast store ([[wiki/concepts/complementary-learning-systems.md]]) — and the lesion data below say it *is* that store, or at least requires it.

---

## The network, by lesion

| Structure | Lesion effect on arbitrary mapping | Specificity |
|---|---|---|
| **Dorsal premotor cortex (PMd)** | Cannot learn cue→handle-twist; performs the twist and recognises the cue normally. Impairs both **pre-learned** and **novel** mappings | Necessary for visuo**motor** but *not* visuo**visual** mapping |
| **Dorsolateral prefrontal cortex (PFdl)** | Impairs learning of novel mappings | Impairs visuovisual **and** visuomotor — a general arbitrary-mapping role |
| **Uncinate fascicle** (inferior temporal ↔ prefrontal disconnection) | Impairs novel mappings | Identifies the *cue* pathway into the binder |
| **Thalamus** (basal ganglia → frontal outflow) | "Profoundly disrupted" | Places the basal ganglia inside the loop |
| **Hippocampal formation** (+ dentate, subiculum, parahippocampal gyrus; also fornix transection) | Marked disability on **novel** mappings; **pre-lesion mappings performed normally** | Possibly visuospatial but not visuovisual **(contested — see tension)** |

**The double dissociation is the load-bearing result.** Same animals, same cues, same movements: new bindings fail, old bindings survive. So the deficit is neither perceptual nor motor, and the fast store is required for *acquisition* only — the trained mapping has moved somewhere the lesion does not reach. This is [[wiki/concepts/complementary-learning-systems.md]]'s consolidation gradient measured on an association that has no internal structure to schematize, which is a stronger form of the claim than the spatial-memory version: what transfers to cortex here cannot be a compressed regularity, because there is no regularity. It is the wiki's clearest behavioural demonstration that gap G14's channel exists in biology while remaining unimplemented in machines.

Historically the same lesions reproduced the profile of patient H.M. — preserved skills and strategies, preserved pre-surgical knowledge, failure to acquire new knowledge — a match that two decades of deliberate attempts had missed because the tasks used were recognition tasks rather than binding tasks.

---

## The code: the edge, not its endpoints

Miller and colleagues, prefrontal delay-period activity, one mapping then its reversal (same cues, same actions, swapped edges):

| Selectivity | Share of prefrontal neurons |
|---|---|
| Cue identity | ~30% |
| Response direction | ~20% |
| **The specific cue→action mapping** | **~50%** |

The majority code neither endpoint but the *pairing* — active for leftward responses under some cues and not others. Reversal is the control that makes this unambiguous: the marginals are held fixed and only the edge set changes.

**This is the wiki's most direct evidence that an edge can be a first-class represented object rather than a weight** — gap G8 (rule reification has no implementation) with a biological existence proof attached. In a standard network the mapping lives *in* the synapses from cue units to action units and has no activity of its own; here half the population carries an activity vector whose referent is the edge. That is the difference between a rule the network obeys and a rule the network can address, and it is what would let a controller swap one mapping set for another without rewriting weights ([[wiki/concepts/working-memory.md]], [[wiki/entities/pbwm.md]]).

**Passingham's argument for why prefrontal cortex specifically:** it is the only node holding all three of cue (from visual areas), action (from premotor areas) and outcome. The conjunction that defines the edge — and its value — can be formed nowhere else. **(brainstorm)** In architecture terms this is a constraint on where a binding module may be placed: it must sit at the convergence of the three streams, which rules out the common design of attaching a memory to the sensory encoder alone.

---

## Learning-related activity comes in two signs

Recorded in supplementary eye field (SEF) and frontal eye field with fixation, delay, and analysis restricted to correct trials, so cue, movement and retinocentric coordinates are constant from the first correct trial to the last:

| Type | Time course | Interpretation |
|---|---|---|
| **Learning-dependent** | Activity **increases** across learning and stays up | The acquired edge itself |
| **Learning-selective** | Activity **decreases**, often to complete silence | Active only while the edge is *being* acquired — a novelty/acquisition signal, not a store |

The two are thoroughly intermingled in SEF. The population vector (each cell voting for its preferred direction) becomes progressively more accurate at predicting the response as learning proceeds — the readout improving, not just individual cells.

**Generalized-arousal confounds are excluded by direction selectivity:** a cell that increases for two of four learned directions cannot be reporting reward rate, expectancy, arousal or motivation, since those move identically for all directions in an interleaved design. This is a reusable control for any claim that a unit "codes learning".

### Regional signatures

| Region | Dominant type | Magnitude | Timing | Reading |
|---|---|---|---|---|
| **Premotor / SEF** | Learning-dependent | Robust; >50% of sampled cells | Distributed across task events | Dense code; the store |
| **Hippocampus** | Learning-**selective** | Weak — a few spikes/s | — | Sparse code **(speculation in source)**; time-limited role, consistent with the lesion dissociation |
| **Prefrontal** | Learning-related **time-shift** of directional selectivity | — | Selectivity migrates earlier in the trial | The edge becoming available before the action is required |
| **Striatum** | Novel-vs-familiar difference in ~30% of cells | Lower prevalence than frontal cortex | Concentrated **immediately after the cue** | A role in the *earliest phase* of a structured event sequence (same result in rats for auditory-motor mappings) |

**(brainstorm)** The four signatures read as a division of labour a machine architecture could copy directly: striatum flags *that a new binding is required* at cue onset, hippocampus supplies the transient one-shot slot, prefrontal cortex holds the addressable edge and moves it earlier as it consolidates, premotor cortex accumulates the durable dense copy. Only the first of those — a gating signal fired at cue time by the novelty of the cue — is missing from every architecture in the wiki; it is the trigger that would decide when to spend a fast-store write, which is [[wiki/concepts/memory-allocation-excitability.md]]'s question asked at a 100 ms rather than an hours timescale.

---

## Open problems

- **What licenses an arbitrary edge?** Nothing in the source says how the network decides that *this* cue and *that* action should be bound rather than any of the other pairings available in the trial. With no structural constraint, the binding problem is combinatorial and the only stated selector is reinforcement — which is too slow and too coarse to explain 3 trials/cue.
- **Antecedent/consequent generality is unmapped.** The review states plainly that the decomposition into visuomotor / visuospatial / visuovisual mapping across network components "has yet to be explored systematically". Premotor cortex is motor-specific; prefrontal cortex is not; the hippocampus is disputed.
- **Reification is observed, not explained.** ~50% mapping-selective cells says the edge is represented; nothing says how the representation is constructed from the two marginals, or how it is used to drive the action (G8).
- **The consolidation target is unknown.** Pre-lesion mappings survive hippocampal ablation, so they live elsewhere — but the review does not identify where, and an unstructured association gives consolidation nothing to compress (G14).
- **Language preadaptation is a conjecture.** Wise & Murray note the arbitrariness of the word–referent relation matches the arbitrariness of the cue–action relation and suggest arbitrary mapping was a preadaptation for language. Attractive for the wiki's symbolic slice (G11) — symbols are exactly edges with no exploitable geometry — but the argument is comparative and evolutionary, not mechanistic.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the edge class the framing has no machinery for: an edge whose endpoints share no relation gives zero transfer to any other edge, so structure discovery has nothing to work on and the cost is `O(n)` in the edge count — the biological form of gap G11's non-embeddable symbolic slice.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the sharpest behavioural form of the fast/slow dissociation: hippocampal ablation destroys acquisition of new arbitrary mappings while leaving pre-lesion mappings intact, on associations with no internal regularity, so whatever consolidation moved to cortex cannot have been a compressed structure.
- **[[wiki/concepts/population-geometry.md]]** — the conjunction result in geometric terms: prefrontal cells coding the *pairing* rather than either marginal are the high-shattering-dimension end of the expressiveness/abstraction trade-off, and cue-action reversal is a ready-made cross-condition test that holds the marginals fixed while flipping the code.
- **[[wiki/concepts/working-memory.md]]** — the reason a mapping must be addressable rather than compiled into weights: an arbitrary rule set is swapped between blocks on the timescale of trials, which is the operation a controller-addressable store exists to perform.
- **[[wiki/entities/pbwm.md]]** — the architecture that implements the swap this page's data demand: a gated prefrontal store holding the currently active stimulus–response rule, with basal ganglia deciding when to update it, matching the striatal cue-onset signal reported here.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — a task family whose generalization difficulty is known by construction rather than estimated (the training solution provably excludes the test solution), and therefore a control condition: a reasoning score that does not exceed an arbitrary-binding score measured binding speed, not inference.
- **[[wiki/concepts/memory-allocation-excitability.md]]** — the same question — *when should a write be spent?* — at a 100 ms timescale instead of hours: the striatal novel-versus-familiar signal appearing immediately after cue onset is a candidate allocation trigger, and nothing in the wiki has one.
- **[[wiki/concepts/compositionality.md]]** — the negative case that bounds it: arbitrary mappings are the part of a repertoire that cannot be composed, so any compositional system needs a non-compositional binding layer underneath supplying the primitives it recombines.
- **[[wiki/concepts/contextual-inference.md]]** — the missing selector stated as a problem: with no structural constraint on which cue binds to which action, context must do the work, and this page supplies no mechanism for it.
