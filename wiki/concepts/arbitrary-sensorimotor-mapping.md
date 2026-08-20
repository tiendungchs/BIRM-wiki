# Arbitrary Sensorimotor Mapping

**An edge from a cue to an action whose endpoints share no spatial, perceptual or causal relation — so the edge carries no information except its own existence, and can only be stored, never computed.**

> **Provenance.** Wise & Murray 2000, *Arbitrary associations between antecedents and actions*, TINS (`raw/wise-2000-arbitrary-antecedent-action-associations.md`). A review of monkey ablation, human neuroimaging and monkey single-unit work on conditional motor learning, stated in propositional form: *if antecedent, then consequent*, where the antecedent maps arbitrarily onto the consequent.
>
> **Companion.** Murray, Bussey & Wise 2000, *Role of prefrontal cortex in a network for arbitrary visuomotor mapping*, Exp Brain Res 133:114–129 (`raw/murray-2000-pfc-arbitrary-visuomotor-mapping.md`). Same year, overlapping authors, but a different object: where the TINS piece establishes *that* the edge class exists and what network carries it, this one decomposes the network into functional parts — which node holds exemplars, which holds the abstraction over them, which holds the search strategy, and which is merely a wire. Everything below the section *The rule hierarchy* is from this source unless marked otherwise.

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

## The same split in humans: acquiring a rule and executing one are different networks

> **Companion.** Boettiger & D'Esposito 2005, *Frontal networks for learning and executing arbitrary stimulus-response associations*, J Neurosci 25:2723–2732 (`raw/boettiger-2005-frontal-stimulus-response-learning.md`). Human fMRI, `n = 14`, 4 T, per-subject functional ROIs. Everything in this section is from that source.

The design's contribution over every earlier human imaging study of conditional learning is a single methodological move: **make the rule hard enough that it is still being acquired while the scanner runs, and put a no-rule condition beside it.**

| Condition | Content | Role |
|---|---|---|
| **fam** (familiar) | Two 10-member stimulus sets, each set → one of four buttons; learned by trial and error the previous day to 90% (≈7 blocks × 40 trials ≈ 15 min), re-practised immediately before scanning | Executing a learned higher-order rule |
| **nov** (novel) | Two new sets of identical construction, acquired across the six scan runs | Acquiring one |
| **NR** (no rule) | 20 stimuli each generated from a *different* matrix — no rule binds them; 10 arbitrarily assigned to each of two buttons; subjects not warned | Stimulus novelty, uncertainty and error feedback **without discoverable structure** |

Stimuli are 8 × 8 colour matrices. Members of a set share **no** identically-coloured square, but preserve the *relation* between identically-coloured squares under 10 permuted colour maps — so the category is a constellation of covarying elements, hard to verbalise, and set membership is the only route to the response. Perceptual content and motor repertoire are therefore identical across all three conditions.

Behaviour: fam 74 ± 4%; nov 36 ± 3% (run 1) → 61 ± 5% (run 6); NR 35 ± 3% — *below* the 50% a pure two-button strategy guarantees, i.e. subjects kept trying to store 20 separate edges rather than settling for the floor.

### Two networks

| Contrast | Regions (**bold** = consistent in every subject's own ROIs; plain = map-wise group only) | Reading |
|---|---|---|
| **nov > fam** — acquisition | **right dorsolateral prefrontal (middle frontal gyrus)**, **midline SMA/pre-SMA**, **left ventral premotor (precentral gyrus)**, **right anterior striatum (caudate)**; left middle frontal gyrus, right inferior frontal gyrus/frontal operculum, right anterior inferior frontal sulcus, bilateral insula | Finding the rule |
| **fam > nov** — execution | **left frontopolar cortex**, **left dorsal premotor (superior frontal gyrus, BA 8B)**; rostral anterior cingulate, ventral left insula, bilateral superior frontal gyrus | Running one already found |

The execution set is the human counterpart of the monkey result that dorsal premotor cortex robustly represents *well-learned* rules (Wallis & Miller 2003), and of this page's PM/BG module as the long-term store. The acquisition set adds the dorsolateral prefrontal node that human imaging had repeatedly failed to find while monkey physiology and lesion work kept implicating it.

### The no-rule control: the signal tracks extractable structure, not difficulty

All four acquisition regions were **more** active for nov than for NR (`p < 2×10⁻⁴` middle frontal gyrus, `p < 0.03` SMA, `p < 8×10⁻⁵` precentral gyrus, `p < 0.01` striatum) — although NR is the *harder* condition, with the same stimulus novelty, more uncertainty, and more error feedback. Frontopolar cortex shows the same ordering on the execution side (`p < 0.004`).

**This is the load-bearing control and it is what makes the study worth carrying.** The acquisition signal is not an effort, novelty, arousal or error-rate signal: it is specific to *there being structure available to extract*. It is the direct human analogue of the direction-selectivity control this page already records for monkey single units, run at the level of a whole network.

**(brainstorm)** The wiki has no machine quantity of this kind. A model that emitted an internal scalar rising when a latent regularity exists and falling when the same task is scrambled would be reporting "there is a graph here to be found" independently of how badly it is currently doing ([[wiki/concepts/latent-graph-discovery.md]]) — which is exactly the trigger a rule layer needs in order to know when to be engaged (G8), and it is *not* prediction error, since NR maximises prediction error and minimises this signal. The cheapest test is the paper's own design: train on a structured task and a matched scrambled one, and ask whether any internal quantity separates them in the direction opposite to loss. The caveat the design cannot fully exclude: partial disengagement in NR would produce the same ordering; the authors argue against it from the below-chance accuracy, which shows subjects were still attempting per-stimulus storage.

### The decay signature separates the search from the store

Maps one-to-one onto this page's learning-**selective** / learning-**dependent** distinction, now in humans:

| Region | Early → late runs, nov only | Type |
|---|---|---|
| Dorsolateral prefrontal (MFG) | **decreases** (`p < 0.02`) | Learning-selective — engaged only while the rule is unknown |
| SMA/pre-SMA | **decreases** (`p < 0.004`) | Learning-selective |
| Ventral premotor (PCG) | no change, though clearly nov-selective | Neither — "a qualitatively different role" |
| Anterior striatum (caudate) | no decline | Learning-dependent — matching monkey premotor/striatal recordings where firing *rises* as the mapping is acquired (Hadj-Bouziane et al. 2003; Brasted & Wise 2004) |

So the two signs recorded in monkey supplementary eye field are not a species or a method artefact: the same task, imaged in humans, splits the same way, and it splits along the store/search line rather than along the cortical/subcortical one.

**The *learning-selective* label is conditional on the rule being flat.** Badre et al. 2010 ran the same decline against a matched set in which a genuine 2nd-order rule was available: prefrontal activity declined across learning only for the set whose rules were all 1st-order, and was **sustained throughout** for the hierarchical set. So a prefrontal region that decays is not reporting "the rule is now learned" — it is reporting "there is nothing left to find at my level of abstraction", and the classical prefrontal-learning / premotor-execution dissociation may be an artefact of a literature that studied only flat mappings ([[wiki/concepts/policy-abstraction-hierarchy.md]]).

### What distinguishes a good learner is coupling, not activation

- Block by block, BOLD magnitude correlates **negatively** with accuracy in the middle frontal gyrus, SMA and precentral gyrus — **in the nov condition only**, not fam and not NR.
- The *strength of that within-subject correlation* predicts, across subjects, overall novel-rule accuracy: `R² = 0.59` (MFG, `p < 0.002`), `0.47` (SMA, `p < 0.007`), `0.34` (PCG, `p < 0.03`). A median split on learning ability separates the same index. Striatum does not show it.
- Between regions: blockwise SMA–MFG coactivation predicts total accuracy with `R² = 0.63`; SMA–striatum coupling also separates good from poor performers.

**(brainstorm) This is a different kind of number from anything else on the page, and it is stated in units an architecture can be scored in.** The individual difference is not *how much* control is recruited but *how tightly recruitment tracks the moment-to-moment need for it* — up while the rule is unknown, down as it becomes known. A controller running at constant gain would score zero on this index while looking entirely normal on any activation-magnitude measure. Every gated architecture in the wiki ([[wiki/entities/pbwm.md]], [[wiki/entities/differentiable-neural-computer.md]]) has the gate and none measures whether the gate's *schedule* matches task demand; the diagnostic is free to run — correlate controller usage with per-trial error, and require the correlation to be negative and to shrink as the task is mastered. The second number says the same about *pairs* of modules: two-thirds of the variance in performance is carried by how well two modules covary, not by either one's level.

### Why the earlier human studies missed dorsolateral prefrontal cortex

| Earlier design choice | Consequence |
|---|---|
| Rules practised to criterion before scanning | The scanned period measures strengthening, not acquisition |
| Rules stated explicitly, one-to-one, few stimuli | Humans learn them in a handful of trials — faster than the measurement's time resolution |
| No condition holding novelty fixed while removing the rule | Any acquisition effect is confounded with stimulus novelty |
| Map-wise group analysis only | Activations that are robust per subject but small and spatially variable are averaged away — two ventrolateral prefrontal foci here appear *only* in the group analysis, the reverse of the usual assumption |

**The reusable rule: a benchmark learned faster than the instrument's time resolution measures retention, not acquisition.** It is the same failure mode as the two-choice trap above — a design under which the interesting mechanism never has to run — and it applies unchanged to machine probing, where a representation read out after convergence cannot distinguish a structure that was discovered from one that was already there ([[wiki/concepts/representation-probing.md]]).

### A candidate anatomical answer to "where does the abstraction come from"

The authors' proposal, argued from the dissociation rather than measured:

| Node | Proposed content |
|---|---|
| Ventrolateral prefrontal | Individual stimulus→response→outcome contingencies, held in working memory |
| Dorsolateral prefrontal | Recalls previous outcomes, **detects the regularity across them**, holds the resulting organising rule; retrieves individual associations from ventrolateral prefrontal cortex and integrates them with medial premotor information the two are not directly connected across |
| SMA/pre-SMA | Represents the *set of possible* stimulus→response associations, on which dorsolateral prefrontal working-memory content acts as a selection bias |
| Anterior striatum | Monitors feedback; the reward-based component that keeps rising as learning proceeds |
| Dorsal premotor, frontopolar | Receive the finished rule; run it without further evaluation |

This is the first candidate in the wiki for the *site* of the extraction step this page's open problems say has no mechanism — and it remains a site, not a mechanism: nothing states what error signal drives "detect the regularity", and the source's own framework (like the monkey work above) holds that the higher-order rule is not needed to acquire the exemplars, so failure to acquire them cannot be it.
---

## The rule hierarchy: exemplar, higher-order rule, strategy

Three levels of content, defined so they can be told apart by lesion rather than by introspection:

| Level | Definition | Example in the task |
|---|---|---|
| **Lower-order rule** (= exemplar = specific mapping) | One edge | Red square → leftward joystick |
| **Higher-order rule** | Same information type, one level up: which *kind* of input is licensed to select an action | "Nonspatial visual information (colour, shape) instructs the choice of action" |
| **Strategy** | A plan for solving the *problem class*, independent of any particular edge | Repeat-Stay / Change-Shift: on a repeat trial re-emit the last response; on a change trial pick a different one |

**A fourth level sits between the higher-order rule and the strategy, and it is dissociable from both.** Matsuzaka et al. 2012 (`raw/matsuzaka-2012-dmpfc-response-tactic-selection.md`) call it a **tactic** — not which action to emit and not which input type is licensed, but *which of several equally valid response protocols is running*: reach toward the cue, or reach away from it. In monkey posterior medial prefrontal cortex 51% of response-period neurons code the tactic; only 4% code the rule form that selects it (spatial vs. colour-conditional, tested by recolouring the cues so both tactics fall under one rule); and inserting a delay between tactic determination and target cue leaves 16 of 41 neurons tactic-selective with no target yet knowable. So *which protocol* and *which rule licenses it* are separate codes in the same population, which is a finer cut than this page's hierarchy makes, and it is the level whose engagement is set by whether a choice exists at all ([[wiki/concepts/policy-abstraction-hierarchy.md]]).

**And it re-prices the medial premotor row of T109.** In the same recordings pre-SMA carries the tactic distinction (35% of its response-period cells, against 26% in SMA) but — unlike pmPFC — its task-related population does **not** shrink when the choice between tactics is removed. That is the signature Boettiger & D'Esposito's node table assigns SMA/pre-SMA: a store of the *set of candidate protocols*, present whether or not a selection is being made, with the selection itself made upstream ([[wiki/empirical-tensions.md]] T109).

**A follow-up in the same animals says what pre-SMA is *not* given.** Under a mixed-tactic condition with the tactic cue and the spatial cue separated by a 1–1.5 s delay, a per-factor variance partition finds tactic and action in pre-SMA but **no significant cue-position signal**, while pmPFC carries all three (Awan et al. 2020, `raw/awan-2020-tactic-based-sensorimotor-transformations.md`). The sensorimotor transformation proper — binding *which protocol* to *where the stimulus is* — therefore happens at one station, and the stations below receive the resolved action plus the protocol identity. For this page's ladder that separates two things it has treated as one: the *site of the mapping* (pmPFC here) and the *store of candidate responses* the mapping selects from (pre-SMA/SMA), with the sensory argument never reaching the second ([[wiki/concepts/policy-abstraction-hierarchy.md]]).

### They are separately destructible

Ablation results in monkeys, collated (source Table 1). `?` is untested, not negative.

| Lesion | Higher-order rules & strategies | Familiar mappings (retention, relearning) | Fast novel mappings |
|---|---|---|---|
| **PFv+o** (ventral + orbital prefrontal) | **lost** | partially preserved, or relearned across sessions | **lost** |
| **PFdl** (dorsolateral prefrontal) | ? | preserved | partially disrupted |
| **PM** (premotor) | ? | **lost** | **lost** |
| **BG output** (basal ganglia → thalamus → cortex) | ? | **lost** | presumably lost |
| **HS** (hippocampal system) | **preserved** | preserved | severely disrupted |

**The load-bearing row pair is HS versus PFv+o.** Hippocampal-system monkeys go on applying Repeat-Stay/Change-Shift while failing completely to acquire new edges. PFv+o monkeys lose the strategy *and* the edges. So the strategy is not an epiphenomenon of having the edges, and the edges are not a by-product of running the strategy: the two are separately lesionable, hence separate represented objects. This is the wiki's strongest evidence that a rule-level and an instance-level store can be physically distinct, and it upgrades the ≈50% mapping-selective-cell result above from *edges are represented* to *edges and the abstractions over them are represented in different places*.

### The strategy is worth an exact number

Three-choice novel mapping, chance = 67% errors on initial choices. Perfect Repeat-Stay/Change-Shift gives 0% on repeat trials and 50% on change trials, and change trials occur twice as often:

`E = (1/3)(0) + (2/3)(0.5) = 33%`

After PFv+o removal the observed initial-choice error rose to ~67%, i.e. exactly the loss of the strategy. **And the authors then argue against their own result:** losing 33 points of error rate does not explain why the *reinforced* mappings were not learned at all across a 50-trial block. A strategy buys a better starting point; it does not buy learning.

### Abstraction is a rate multiplier, not an enabler

Stated explicitly and worth carrying, because the wiki's usual framing assumes the opposite: higher-order rules are **not** necessary for acquiring lower-order ones. Each exemplar can be learned one at a time without ever encoding the general rule that nonspatial visual information is the informative channel. What the higher-order rule buys is speed and efficiency. **(brainstorm)** This is the cleanest available statement of what an abstraction layer is *for* in a learner that already has a working instance layer: it changes the constant in front of `O(n)` — by pruning which input dimensions are even candidates for an edge — but it cannot change the exponent, because arbitrary edges have no shared content to factor out ([[wiki/concepts/skill-acquisition-efficiency.md]]). An architecture that installs a rule layer expecting sample-complexity *class* improvement on this edge type is expecting something the biology does not deliver.

---

## Cortical–BG modules: the architectural unit

The review's organising claim (after Houk & Wise 1995): the unit of frontal function is not an area but a **recurrent loop through neocortex → basal ganglia → thalamus → the same cortex**. Each cortical area participates in a *large number* of such loops, operating largely in parallel.

| Module family | Cortex in the loop | Proposed content |
|---|---|---|
| **PM/BG** | Premotor | Specific object→action mappings (exemplars); the long-term store |
| **PF/BG** | Prefrontal | Higher-order rules and problem-solving strategies — **in addition to**, not instead of, lower-order mappings |
| **M1/BG** | Primary motor | Motor output; the effector side |

Two properties do the work. First, abstraction level is a property of *which cortical area sits in the loop*, not of a different mechanism — the same loop architecture, replicated, yields exemplars in one copy and rules over exemplars in another. Second, PF is explicitly credited with lower-order mappings too, so the hierarchy is nested rather than partitioned: removing PFv+o removes its contribution at both levels at once, which is why that lesion is the most destructive one in the table.

**(brainstorm) Against [[wiki/entities/pbwm.md]].** PBWM is this architecture with the count right and the typing missing: ~20,000 prefrontal stripes, each an independently gated cortico-striatal loop, is exactly "a large number of cortical-BG modules operating in parallel". But PBWM's stripes are homogeneous — every stripe holds task-relevant content of the same kind, and nothing assigns some stripes to hold *rules over the contents of other stripes*. The biology says the level of abstraction is fixed by anatomical placement, which in a machine means: two banks of stripes, with the second bank's inputs being the first bank's *contents and gating history* rather than the sensory stream. Nothing in the wiki builds this, and it is the concrete form gap G8's "rule as addressable object" would take in a gated-store architecture.

---

## A lesion deficit does not localize a computation

PFv+o receives most of the frontal lobe's input from inferior temporal cortex (area TE and perirhinal cortex); **IT does not project directly to premotor cortex**. So a PFv+o lesion has two available readings, and the review declines to choose between them:

| Reading | Claim | What it predicts |
|---|---|---|
| **Computation** | PFv+o computes and stores the mappings, rules and strategies in its own cortical-BG modules | Deficit survives any restoration of the IT→PM route |
| **Disconnection** | PFv+o is the *route* by which nonspatial object identity reaches PM and its striatal territory | Deficit is a bandwidth failure; the binder is intact but starved |

The argument that the computation reading is insufficient on its own: prefrontal cortex cannot support learning in the absence of PMd, so PF is not a self-contained binder.

**The same argument runs backwards, and it is the more useful direction.** A PM lesion may impair PF's ability to encode exemplars because it deprives PF of information about *which movement was actually prepared and executed* — especially at the moment reward arrives or fails to. So the binder needs an efference copy, not just the cue: the conjunction cue × action × outcome cannot be formed from the sensory stream alone. That is an architectural constraint, not an anatomical curiosity — it says a binding module fed only by the perceptual encoder cannot learn what it is for, which is how most memory-augmented architectures in the wiki are wired.

**(brainstorm) The reusable methodological rule.** For any claim "region X computes Y", ask whether X lies on the only path from Y's inputs to Y's consumer. Ablating a module in a trained network lesions the module *and every path through it*; the two are separable only by a crossed disconnection (lesion X in one hemisphere, X's input source in the other) or by restoring the path around the ablation. The wiki's machine analogue — [[wiki/concepts/representation-probing.md]]'s causal-intervention tests — inherits this confound whole and has no equivalent of the crossed-lesion control.

---

## Working memory does not explain the deficit

The review dismantles the default interpretation, which matters because the wiki's control layer leans on prefrontal cortex being a store:

| Argument | Evidence |
|---|---|
| PFv is not required for short-term storage of nonspatial visual information | Monkeys with PFv removals hold visual stimuli for up to 8 s in delayed matching-to-sample with familiar stimuli (Rushworth et al. 1997a) |
| The task imposed almost no storage demand | The instruction stimulus stayed on the video screen throughout response selection and execution |
| The deficit is not perseveration either | Post-lesion the monkey repeated previously emitted incorrect responses more than pre-lesion, but no more than it emitted any *other* alternative — i.e. a loss of the correct-choice signal, not a stuck response. No tendency to incorrectly repeat a previously *rewarded* response on change trials |

Conclusion as stated: the hypothesis that "the sole specialized function of PF, as a whole, is the mediation of working memory" is falsified. See [[wiki/empirical-tensions.md]] T92.

---

## Generality: not about motor output, and not about discrimination

| Task | IT ↔ PF interaction required? | Reading |
|---|---|---|
| Arbitrary visuo**motor** mapping | Yes | Consequent is an action |
| Arbitrary visuo**visual** mapping (visual paired associates) | Yes — uncinate fascicle transection is dramatically impairing | Consequent need not be motor |
| Reward-instructed visual choice (pellet arrival / non-arrival signals which of two stimuli is correct) | Yes — crossed-lesion disconnection | **Antecedent need not be visual** |
| Visual discrimination | **No** | Solvable by "approach the target of high affective valence" — i.e. standard mapping |
| Configural discrimination (AB+ / CD+ vs BC− / AD−) | **No** | Same: approach the rewarded configuration |

So the IT↔PF pathway is specific to *arbitrariness*, not to vision, not to motor output, and not to task difficulty. The discrimination sparing carries the sharper point: those tasks **could** be solved by arbitrary mapping and are not. The review's proposed determinant is spatiotemporal contiguity — when sample and choice are contiguous in time and space, the animal falls back on approach-by-valence; separate them and it is pushed onto arbitrary mapping (Holland 1991).

**(brainstorm)** That is a curriculum knob, and the wiki has almost none. The same nominal task recruits a valence/similarity shortcut or an explicit binding depending on whether cue and choice are contiguous — which makes cue–choice separation a designable lever for forcing a learner off a shortcut and onto a stored edge ([[wiki/concepts/shortcut-learning.md]]). It also means a benchmark that leaves contiguity uncontrolled does not know which mechanism it is scoring.

### The two-choice trap

At `k = 2` responses, Repeat-Stay/Change-Shift **solves the task completely** — stay after a repeat, shift after a change, and with only one alternative the shift is necessarily correct. At `k = 3` it leaves 33% error. Therefore:

> Any binding benchmark with binary choice measures strategy, not binding.

The review applies this to its own field: every rat study of arbitrary mapping to that date used two stimuli and two responses, so the rat literature's negative hippocampal results (Marston et al. 1993; Bussey et al. 2000) may simply be animals routing around the requirement. This generalises directly to machine evaluation, where two-alternative forced choice is the default format ([[wiki/concepts/skill-acquisition-efficiency.md]]).

---

## Intermediate-term, not merely fast

The proposed division: the hippocampal system holds exemplars **and rules and strategies** over the intermediate term, pending consolidation of each into the frontal cortical-BG modules that will hold them long-term (PM/BG for exemplars, PF/BG for rules and strategies). The fast store is therefore not typed by content — it takes abstractions and instances alike and hands each to a different cortical destination.

**And a control the wiki has been missing.** "Familiar mappings spared by the lesion" supports a preserved long-term store *only if* performance is good immediately after surgery. If the familiar stimuli reappear across days, sparing may be post-operative relearning instead. Preliminary data split the two cases: hippocampal-system sparing looks like a genuinely preserved store, PFv+o sparing looks like relearning across sessions (which is why that cell in the table reads "partially preserved *or relearned*"). Every consolidation-gradient claim in [[wiki/concepts/complementary-learning-systems.md]] rests on the same distinction and few sources report which one they measured.

---

## What the network is *not*

Structures whose removal leaves arbitrary mapping essentially intact — the specificity evidence, which is what makes the positive list a network rather than a list of everything:

| Species | No effect |
|---|---|
| Monkey | Medial premotor cortex (supplementary motor + anterior cingulate motor areas), dorsal prefrontal cortex (PFd), posterior parietal cortex (familiar mappings), deep cerebellar nuclei, complete bilateral amygdala |
| Rat | Amygdala, mediodorsal thalamus, anterior thalamic nuclei, prelimbic cortex, perirhinal + postrhinal cortex combined, medial frontal / anterior cingulate cortex |

**The first monkey cell is now contested.** Medial premotor cortex is listed here as ablation-negative, but in the human study above midline SMA/pre-SMA is one of four regions selective for rule *acquisition*, declines as the rule is learned, and its coupling with dorsolateral prefrontal cortex accounts for 63% of the between-subject variance in accuracy — the single largest effect in that dataset. Ablation-negative and imaging-positive are not formally contradictory (a region can be sufficient-when-present and dispensable), but the size of the imaging effect makes "no effect" hard to hold as stated. Logged as [[wiki/empirical-tensions.md]] T109.

Two rat results run the other way and are worth more than the nulls:

- **Removal that *helps*.** Excitotoxic lesions of anterior cingulate cortex caudal to the genu, and cholinergic denervation of cingulate cortex, **facilitated** early learning. **(brainstorm)** A module whose ablation accelerates acquisition is a competing controller — a prior that must be overridden before an arbitrary edge can be written. Nothing in the wiki's architectures has a component that must be *suppressed* for fast binding to proceed, and the striatal novelty signal above is the natural partner: one circuit says "this is new, write", another says "use what you already do here", and early learning is the second one losing.
- **Late-phase-only contributors.** Posterior cingulate and infralimbic lesions impaired acquisition **only in its latest stages** — a component recruited after the edges exist, i.e. a consolidation or automatization stage rather than a binder.

The rat/monkey mapping is explicitly unsafe: rat AGm (Fr2) and AGi are both implicated, but frontal homologies between rats and primates are unresolved (Preuss 1995), and BG results conflict (nucleus accumbens core yes; dorsolateral and ventrolateral striatum no, against earlier dopamine-depletion and lateral-striatal reports).

---

## Open problems

- **What licenses an arbitrary edge?** Nothing in the source says how the network decides that *this* cue and *that* action should be bound rather than any of the other pairings available in the trial. With no structural constraint, the binding problem is combinatorial and the only stated selector is reinforcement — which is too slow and too coarse to explain 3 trials/cue.
- **Antecedent/consequent generality is partly mapped, and the gaps are the informative cells.** The review states plainly that the decomposition into visuomotor / visuospatial / visuovisual mapping across network components "has yet to be explored systematically". Premotor cortex is motor-specific; prefrontal cortex is not; the hippocampus is disputed. The companion adds two cells — visuovisual mapping and a *reward* antecedent both require the IT↔PF pathway — but no ablation has used a consequent that is neither motor nor spatial, which is precisely the experiment [[wiki/empirical-tensions.md]] T91 turns on.
- **Reification is observed, not explained.** ~50% mapping-selective cells says the edge is represented; nothing says how the representation is constructed from the two marginals, or how it is used to drive the action (G8).
- **The consolidation target is now named, not shown.** Murray et al. place exemplars in PM/BG modules and rules and strategies in PF/BG modules, with the hippocampal system holding all three over the intermediate term. This is a proposal argued from the lesion table, not a measurement: no experiment tracks a single mapping moving from one store to the other, and an unstructured association still gives consolidation nothing to compress (G14).
- **Language preadaptation is a conjecture.** Wise & Murray note the arbitrariness of the word–referent relation matches the arbitrariness of the cue–action relation and suggest arbitrary mapping was a preadaptation for language. Attractive for the wiki's symbolic slice (G11) — symbols are exactly edges with no exploitable geometry — but the argument is comparative and evolutionary, not mechanistic.
- **Nothing says how a higher-order rule is extracted from exemplars.** The hierarchy is established by dissociation and its value is quantified, but no mechanism converts a set of specific mappings into "colour instructs action". Since the review also argues the rule is *not necessary* for learning the exemplars, the extraction cannot be driven by failure to learn them — leaving no stated error signal for the abstraction layer. Boettiger & D'Esposito 2005 supply a *site* and not a mechanism: dorsolateral prefrontal cortex, which is engaged exactly while the rule is unknown and disengages as it is found, with ventrolateral prefrontal cortex holding the individual contingencies it integrates over. The error signal remains unnamed, and by the same argument as above it cannot be exemplar-learning failure.
- **Computation versus wire is unresolved for the most-lesioned node.** The PFv+o deficit is compatible with PFv+o *being* the binder and with PFv+o merely *carrying object identity to* the binder, and the review keeps both. No crossed-lesion or route-restoration experiment separates them, so every claim in the wiki that cites this region as a rule store cites an ambiguous result.
- **The two-choice trap invalidates an unknown fraction of the literature it reviews.** With `k = 2`, Repeat-Stay/Change-Shift is a complete solution; every rat study to date used `k = 2`. Which rat negative results are real and which are strategy artefacts is not recoverable from the published data.
- **What must be suppressed?** Ablating rat anterior cingulate cortex caudal to the genu *accelerates* early acquisition. No account is offered of what that region contributes that competes with fast binding, and the wiki has no architectural slot for a component whose suppression is a precondition for a write.

- **What makes the acquisition network turn on is measured but not modelled.** Boettiger & D'Esposito's no-rule condition is *harder* than the learning condition and drives the acquisition network *less*, so the engagement signal is neither prediction error, uncertainty, novelty nor effort. Nothing in the source says what quantity is being computed such that "a rule exists here" is detectable before the rule is found — which is a stronger requirement than it looks, since a system that could reliably detect extractable structure without extracting it would already have solved most of the search.
- **The best predictor of learning ability is a correlation, and no architecture exposes the equivalent.** What separates good from poor human learners is the tightness of the coupling between control-region activity and trial-by-trial accuracy (`R² = 0.34`–`0.59`), and between two control regions (`R² = 0.63`) — not the level of either. There is no wiki architecture whose controller usage is even logged per trial, so the diagnostic cannot currently be run on any model here.

---

## Connections

- **[[wiki/concepts/priority-map.md]]** — the same frontal machinery under a different contingency: a cue that specifies *what to find* rather than *which action*, so the action is chosen by an argmax over locations scored against the cue — a cue→predicate mapping that composes over an arbitrary number of stimuli, where this page's mappings are cue→response and enumerable (Bichot et al. 2015).
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the edge class the framing has no machinery for: an edge whose endpoints share no relation gives zero transfer to any other edge, so structure discovery has nothing to work on and the cost is `O(n)` in the edge count — the biological form of gap G11's non-embeddable symbolic slice. It also supplies the closest thing the wiki has to a *detector* for the framing's central question: in humans the frontal acquisition network is driven harder by a stimulus set that has a hidden grouping rule than by a matched set that has none, even though the ruleless set is the harder one — so "there is structure here to be found" is a quantity a brain computes before it has found it (Boettiger & D'Esposito 2005).
- **[[wiki/concepts/complementary-learning-systems.md]]** — the sharpest behavioural form of the fast/slow dissociation: hippocampal ablation destroys acquisition of new arbitrary mappings while leaving pre-lesion mappings intact, on associations with no internal regularity, so whatever consolidation moved to cortex cannot have been a compressed structure — and the companion adds the control that decides the claim: sparing counts as a preserved long-term store only if performance is good *immediately* post-surgery, since sparing measured across days of re-exposure is relearning (Murray et al. 2000).
- **[[wiki/concepts/population-geometry.md]]** — the conjunction result in geometric terms: prefrontal cells coding the *pairing* rather than either marginal are the high-shattering-dimension end of the expressiveness/abstraction trade-off, and cue-action reversal is a ready-made cross-condition test that holds the marginals fixed while flipping the code.
- **[[wiki/concepts/working-memory.md]]** — the reason a mapping must be addressable rather than compiled into weights: an arbitrary rule set is swapped between blocks on the timescale of trials, which is the operation a controller-addressable store exists to perform — though the companion falsifies the stronger reading: ventral prefrontal cortex is *not* required for 8 s retention of nonspatial visual stimuli, and the mapping deficit appears with the cue on screen throughout, so storage is not what the region is for (Murray et al. 2000, [[wiki/empirical-tensions.md]] T92).
- **[[wiki/entities/pbwm.md]]** — the architecture that implements the swap this page's data demand: a gated prefrontal store holding the currently active stimulus–response rule, with basal ganglia deciding when to update it, matching the striatal cue-onset signal reported here — and the architecture whose stripes are the cortical-BG modules this page's companion proposes, but untyped, so nothing holds rules *over* the contents of other stripes (Murray et al. 2000).
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — a task family whose generalization difficulty is known by construction rather than estimated (the training solution provably excludes the test solution), and therefore a control condition: a reasoning score that does not exceed an arbitrary-binding score measured binding speed, not inference.
- **[[wiki/concepts/memory-allocation-excitability.md]]** — the same question — *when should a write be spent?* — at a 100 ms timescale instead of hours: the striatal novel-versus-familiar signal appearing immediately after cue onset is a candidate allocation trigger, and nothing in the wiki has one.
- **[[wiki/concepts/compositionality.md]]** — the negative case that bounds it: arbitrary mappings are the part of a repertoire that cannot be composed, so any compositional system needs a non-compositional binding layer underneath supplying the primitives it recombines.
- **[[wiki/concepts/contextual-inference.md]]** — the missing selector stated as a problem: with no structural constraint on which cue binds to which action, context must do the work, and this page supplies no mechanism for it.
- **[[wiki/concepts/representation-probing.md]]** — inherits this page's confound and lacks its control: a PFv+o lesion destroys the region *and* the only route carrying object identity to premotor cortex, so an ablation localizes a computation only when the region is not on the input path — and the biological remedy, crossed-lesion disconnection, has no machine analogue among the wiki's intervention tests (Murray et al. 2000). It also inherits a *temporal* form of the same trap: human imaging missed the prefrontal rule-acquisition signal for a decade by scanning tasks learned faster than the measurement resolved, and a representation probed after convergence likewise cannot separate a structure that was discovered from one already present (Boettiger & D'Esposito 2005).
- **[[wiki/concepts/meta-learning.md]]** — a problem-solving strategy shown to be a separately stored object rather than an emergent property of the instance learner: Repeat-Stay/Change-Shift survives hippocampal ablation while new bindings fail, and dies with PFv+o while nothing else about the task changes — the inner/outer loop split made surgically, with the outer loop's product worth an exact 33 percentage points (Murray et al. 2000).
- **[[wiki/concepts/shortcut-learning.md]]** — supplies a curriculum knob for forcing a learner onto the intended mechanism: visual and configural discriminations *could* be solved by arbitrary mapping and are not, because cue and choice are spatially and temporally contiguous, so approach-by-valence is cheaper — separating them in time or space is what recruits the binding pathway (Murray et al. 2000).
- **[[wiki/concepts/cognitive-control.md]]** — the level above this page's rule hierarchy, with the confounds designed out: a *match / non-match* rule cued by stimuli from different modalities within a rule and the same modality across rules has no cue, action or reward content left, and transfers to pictures seen for the first time — where this page's higher-order rule still names an input type. It also names the primary source behind this page's ~50% pairing figure and reports it slightly lower (44% of randomly sampled lateral prefrontal cells coding the cue×action pairing; Asaad et al. 1998), adding the property the share alone does not carry — the tuning is **nonlinear**, so activity for one cue×action combination is not predictable from the others — and the direct disagreement about what abstraction buys ([[wiki/empirical-tensions.md]] T93). Its unspecified withdrawal criterion also gets a measurement here: dorsolateral prefrontal and pre-SMA activity decline across runs only while a rule is being acquired, and what predicts a good learner is the tightness of that decline's coupling to accuracy, not its magnitude (Boettiger & D'Esposito 2005).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — resolves *which* rat prelimbic cortex this page's ablation table names, and re-reads several of its lesion rows as switching costs rather than mapping costs: ventral prelimbic/infralimbic damage leaves acquisition of a mapping intact and destroys the ability to replace one, and only when the shift crosses stimulus type (place ↔ response) rather than reversing within it.
- **[[wiki/concepts/controller-knowledge-vs-process.md]]** — the opposite end of the same storage claim: this page's cue→action edge is the smallest structureless prefrontal content, that page's structured event complex is a goal-oriented multi-event sequence, and nothing in the wiki states how one scales into the other.
- **[[wiki/concepts/control-unity-and-diversity.md]]** — separates this page's operation from monitoring inside lateral prefrontal cortex by double dissociation: BA-8 damage impairs conditional stimulus→response selection while sparing *n*-back, and BA-9/46 damage does the reverse, so cue→action binding is its own circuit rather than an application of the working-memory one (Friedman & Robbins 2021).
- **[[wiki/entities/pfc-columnar-planning-model.md]]** — the mapping unit made local and made valuable: one minicolumn = one state–action pair, winner-take-all across a column selects the action, and the mapping's value is supplied from outside by a diffusing reward wave rather than learned per association (Martinet et al. 2011).
- **[[wiki/entities/c-ts-model.md]]** — the level above a single structureless edge: several cue→action bindings are bundled under one latent task-set that a *new* context can point at, so the zero-transfer property of an individual arbitrary edge does not prevent transfer of the bundle — and the transfer is measured in both directions, positive when the new context signals a stored rule and negative when it partially matches two (Collins & Frank 2013).
- **[[wiki/concepts/policy-abstraction-hierarchy.md]]** — makes this page's exemplar/higher-order-rule/strategy ladder countable by defining a level as "the output names a rule rather than an action", gives each level a frontal band, and disputes the *learning-selective* label on prefrontal decline: prefrontal activity falls across learning only when the rule is 1st-order and is sustained throughout when a genuine 2nd-order rule is present (Badre et al. 2010). It also inserts a level this page's ladder skips — the *tactic*, a response protocol coded separately from the rule that selects it and from the target it produces — and shows that its neural population exists only while two tactics are live, which is the engagement signal this page's own open problems say nothing computes (Matsuzaka et al. 2012). And it splits this page's mapping site from its response store: only posterior medial prefrontal cortex holds tactic, cue position and action together, so the transformation is computed at one station and pre-SMA/SMA receive the protocol identity plus the resolved action with the sensory argument withheld (Awan et al. 2020, gap G59).
