# Dynamic Network Connectivity

**A recurrent network's connections carry a second, content-free strength register that is set in seconds by a global state variable and reversed just as fast — implemented in ion channels inside individual dendritic spines, leaving the wiring diagram untouched.**

> **Provenance.** Arnsten, Paspalas, Gamo, Yang & Wang 2010, *Dynamic Network Connectivity: A New Form of Neuroplasticity*, Trends Cogn Sci 14(8):365–375 (`raw/arnsten-2010-dynamic-network-connectivity.md`). A working model assembled from monkey dorsolateral prefrontal iontophoresis-plus-recording, immuno-electron microscopy of spines, and rat prefrontal pharmacology; several load-bearing results are cited as the authors' own unpublished data. Abbreviated **DNC** in the source — this wiki spells it out, because DNC already denotes the Differentiable Neural Computer ([[wiki/entities/differentiable-neural-computer.md]], [[wiki/glossary.md]]).

The wiki's plasticity pages ask how a weight comes to hold a *value* ([[wiki/concepts/synaptic-plasticity.md]], [[wiki/concepts/meta-optimized-plasticity.md]]). This page is about a register that holds no value at all: a per-synapse multiplicative gate whose set-point is arousal, energy availability and momentary cognitive demand.

---

## Two plasticity registers, distinguished by their morphology

| | **Architecture** (long-term potentiation) | **Connection gain** (dynamic network connectivity) |
|---|---|---|
| What changes | Which cells are connected, and how strongly, for good | Whether an existing connection is currently expressed |
| Spine type | Sessile spines enlarging into **mushroom** spines | Long, pedunculated spines with a **narrow neck** |
| Timescale | Minutes to permanent | **Seconds**, reversible |
| Carrier | Receptor complement, spine volume | Open probability of K⁺/HCN/TRPC channels in the spine head and neck |
| What it encodes | The content of a memory | Nothing — it is a gain, set by state |
| Failure mode | Forgetting | Disconnection: the network is intact and silent |

Why the geometry matters: a **narrow, long spine neck** is what makes a shunt effective — opening a conductance in the neck bleeds the synaptic current before it reaches the dendrite, and computational modelling (Pereira & Wang, cited as personal communication) says exactly those two morphological parameters set the shunt's efficacy. So the gain register is *physically segregated* from the architecture register at the level of the individual synapse, which is what lets the two run independently ([[wiki/concepts/dendritic-computation.md]]).

---

## The machinery, as a signed table

Prefrontal pyramidal cells excite each other on spines via NMDA receptors, which pass Ca²⁺ as well as Na⁺. Calcium is the shared input to nearly every weakening pathway.

| Direction | Pathway | Terminal effect on the synapse | Evidence in the source |
|---|---|---|---|
| **Weaken** | NMDA Ca²⁺ → **SK** (small-conductance Ca²⁺-activated K⁺) channels | Shunt; reduced excitability | Blocking SK with apamin *increases* the prefrontal NMDA current and *improves* working memory |
| **Weaken** | Glutamate spillover → perisynaptic **mGluR1/5** → Gq → IP₃ → intracellular Ca²⁺ release → SK | Shunt | Blocking IP₃-mediated release (xestospongin C) improves working memory; RGS4, which inhibits Gq, sits perisynaptically and is *reduced* in schizophrenia |
| **Weaken** | Ca²⁺ → adenylyl cyclase → **cAMP** → **HCN** channels (direct) and **KCNQ2/3** via protein kinase A | Shunt at the spine neck | Raising cAMP collapses delay-period firing; the collapse is *reversed* by blocking HCN (ZD7288) or KCNQ (XE991, linopirdine) |
| **Weaken** | Ca²⁺ → CaMKII, protein kinase C | Impaired function; with chronic drive, spine loss | Protein kinase C signalling rises under stress; blocking it or cAMP prevents stress-induced spine loss |
| **Strengthen** | Norepinephrine → **α2A adrenergic receptors** → inhibit cAMP production | Closes HCN/KCNQ → connection expressed | α2A receptors co-localise with HCN1 in the spine head *and neck*; the agonist guanfacine raises delay firing for the preferred direction, and a cAMP analogue reverses it |
| **Strengthen** | **PDE4** phosphodiesterases hydrolysing cAMP; DISC1 activates PDE4 under high cAMP | Same channel end-point | Loss of PDE4 activity → cAMP build-up → network collapse |
| **Strengthen** | Acetylcholine → **α7 nicotinic** receptors *on the spine*, next to the NMDA synapse; muscarinic closure of KCNQ | Boosts the NMDA input directly | An α7 agonist partially rescues ketamine-induced working-memory deficits |
| **Strengthen** | Low cAMP → **TRPC** depolarising current | Net depolarisation | Working model; high cAMP suppresses the TRPC current |

Two structural facts about this table are the transferable part:

- **Every weakening route converges on one of three K⁺-type conductances**, and every strengthening route works by removing that conductance. The controller does not have `n` independent levers; it has one lever with several afferents.
- **The lever is placed *between* the synapse and the dendrite**, not at the synapse's weight. Nothing about what the synapse learned is read or altered.

---

## The same mechanism has two address scopes

| Scope | Trigger | Effect |
|---|---|---|
| **Per-spine** | Ca²⁺ or cAMP raised in a subset of spines | Sculpts *which inputs* a neuron currently listens to — a per-edge gain vector |
| **Global** | Acute stress: high dopamine/norepinephrine → cAMP everywhere | Collapses the whole recurrent network in seconds; control of behaviour reverts to amygdala and other subcortical systems, which the same catecholamine surge *strengthens* |

The global setting is an architecture switch driven by a scalar: a deliberative, expensive, model-based controller is taken offline and a fast reflexive policy takes over. **(brainstorm)** The wiki has no architecture with this move. A machine analogue is one scalar `σ` (threat/uncertainty/time-pressure) that simultaneously multiplies down the recurrent gain of a planner and multiplies up the output weight of a reactive policy — arbitration by a shared gain variable rather than by a learned meta-controller, and therefore free of the "what selects the selector" regress ([[wiki/concepts/cognitive-control.md]]).

---

## Two knobs with opposite jobs, on disjoint spine populations

Dopamine D1 receptors and α2A adrenergic receptors sit on **different subsets of spines** on the same cells.

| Knob | What it does to delay-period tuning | Read as |
|---|---|---|
| α2A (norepinephrine, moderate) | Raises firing for the neuron's **preferred** direction | Increase **signal** |
| D1 (dopamine, moderate) | Suppresses firing for **nonpreferred** directions | Decrease **noise** — a shunt on inputs from dissimilarly tuned neurons |
| D1 (high, e.g. under stress) | Suppresses **all** directions | The inverted-U: the same knob past its operating point destroys the code |

Three consequences:

- **Tuning is set twice, by two mechanisms with different flexibility.** GABAergic lateral inhibition sculpts the preferred/nonpreferred contrast structurally ([[wiki/concepts/inhibitory-control-of-coding.md]]); D1 shunting does the *same job* through a channel that arousal can retune within a trial. So a machine model that implements selectivity only as fixed lateral inhibition is missing the adjustable half.
- **The optimal setting is task-dependent and the paper says which way.** D1 narrowing helps when a narrow range of inputs is required (spatial working memory for one location) and *hurts* when a broad range is required (attentional set-shifting). This is the factorise-vs-entangle/receptive-field-width trade (gap G40) exposed as a single continuously settable parameter with a task-conditioned optimum.
- **Every component has an operating point rather than a monotone gain**, which is the same inverted-U the control psychometrics report across noradrenergic, dopaminergic and serotonergic manipulations ([[wiki/concepts/control-unity-and-diversity.md]]).

---

## Capacity as an imposed stability margin, not a resource ceiling

The load-bearing claim for this wiki. Recurrent excitation is intrinsically unsafe, so prefrontal microcircuits run a negative feedback loop — activity → Ca²⁺ → K⁺ conductance → shunt — whose *purpose* is to prevent runaway excitation.

| Evidence | Reading |
|---|---|
| Blocking SK channels (apamin) or IP₃-mediated Ca²⁺ release (xestospongin C) in rat prefrontal cortex **improves** working-memory performance | The store was running below its achievable capacity |
| A mutation preventing protein kinase A from opening KCNQ2/3 causes childhood epilepsy; reduced HCN expression lowers cortical seizure threshold | The feedback is load-bearing for stability, and removing it costs seizures |
| The same feedback is offered as the reason hippocampal connections are needed beyond ~10–30 s | The handoff between fast **M** and the episodic store has a *cause*, not just a convention |

**This is a fourth locus for the capacity limit**, and it is of a different type from the wiki's other three — noise-limited attractor chains (`7 ± 2`, [[wiki/entities/rolls-treves-hippocampal-model.md]]), superposition interference among concurrent control states ([[wiki/concepts/cognitive-control.md]]), and softmax competition at the read ([[wiki/concepts/attention.md]]). Those are ceilings the substrate imposes. This one is a **margin the system chooses**, and it is measurably recoverable by pharmacology ([[wiki/empirical-tensions.md]] T104).

**(brainstorm)** The machine version is exact and cheap: any recurrent store with a stability regulariser (spectral-radius clipping, activity normalisation, an adaptation current such as [[wiki/entities/adaptive-cann.md]]'s `m`) is paying the same tax, and the tax is a hyperparameter nobody reports as a *capacity* number. The experiment is one line: sweep the regulariser down until the network destabilises and record capacity along the way. If capacity rises monotonically until instability, the wiki's stores are all running with an unmeasured margin too.

---

## One global knob, opposite signs in two stores

Raising cAMP in prefrontal cortex **impairs** working memory and **strengthens** long-term memory consolidation — the same drug (a PDE4 inhibitor, or a PDE4-resistant cAMP analogue), the same region, opposite direction for the two functions.

**(brainstorm)** This is the fast-**M**/slow-**W** split with a shared antagonistic gain, and it is a design the wiki does not have. Every architecture here sets fast-store dynamics and slow-write rate independently. A single `κ` that trades *hold the current binding* against *commit it to the slow learner* is an economical way to schedule consolidation — the system cannot both be reasoning and be writing at full rate, and it does not need a separate scheduler to enforce the alternation ([[wiki/concepts/complementary-learning-systems.md]], [[wiki/concepts/offline-replay.md]]).

---

## The controller sets the gain that sets the controller

Prefrontal cortex regulates the firing patterns of the subcortical norepinephrine, dopamine and acetylcholine cell groups, which in turn determine prefrontal functional state — the authors' phrase is "vicious vs. delicious cycles". Combined with the layer-typed output anatomy ([[wiki/entities/medial-prefrontal-cortex.md]]: deep ventral layers → striatal patch and accumbens shell → dopamine cells; ventral tier → locus coeruleus and dorsal raphe), this is a closed loop from the controller onto its own neuromodulatory supply.

For gap **G50** (the controller cannot set the gain of its own teaching signal) this is the first source that states the loop as a functional claim rather than as anatomy, and it adds the property a builder would most want to know: **the loop is unstable in both directions**, so a self-set gain needs its own stabiliser and the biological one is chemical rather than computational.

---

## Cost, and why the gain exists at all

Recurrent prefrontal activity is metabolically expensive (2-deoxyglucose in monkeys, fluorodeoxyglucose-PET in humans). The weakening pathways are offered as an **energy-conservation policy**: disconnect the expensive recurrent store during fatigue, reconnect it during rested waking when the energy is available and the computation is needed.

**(brainstorm)** No model in the wiki has an energy term that gates whether its most expensive module runs. The nearest thing is [[wiki/entities/trnn.md]]'s `⟨r²⟩` metabolic proxy, which is measured and never *used* as a control variable. A gain register with an energy budget makes "when to think hard" a resource-allocation problem with a scalar answer, which is a candidate handle on gap G15 (no control policy over simulation).

---

## The flexibility mechanism is also the failure point

Because the gain register is molecular and lives on slender spines, everything that can perturb it degrades cognition — and a striking share of the known genetic and environmental insults land there.

| Insult | Where it hits the table above |
|---|---|
| Normal ageing | Loss of **long, thin** spines specifically; α2A receptors and PDE4A decline → cAMP *disinhibited* (opposite to aged hippocampus, where cAMP falls); dopamine and acetylcholine decline |
| Alzheimer's disease | Soluble amyloid-β internalises NMDA receptors in the presence of α7 nicotinic receptors, and directly stimulates mGluR1 — both are gain-register components, and the deficit precedes cell death |
| Schizophrenia | Genetic hits on NMDA signalling (dysbindin, D-amino acid oxidase, neuregulin 1), α7 nicotinic receptors, DISC1 (→ PDE4), and large reductions in RGS4 protein and mRNA; an unbiased fMRI study found reduced prefrontal activity associated with polymorphisms in DISC1, NMDA, α7 and α2A genes together |
| Acute stress | cAMP surge (D1, β1) plus α1-driven Ca²⁺/protein kinase C; cortisol blocks catecholamine reuptake and amplifies it |
| Chronic stress | Sustained weakening becomes architectural: prefrontal dendrites and spines retract (reversibly), while amygdala dendrites *elongate* |

**(brainstorm) The design lesson is uncomfortable and worth stating plainly.** The register that buys second-scale reconfigurability is the one with the most failure modes, and its failures are *systematic* (disconnection under stress, disinhibited gain with age) rather than random. A machine architecture that adopts a fast global gain channel inherits the same exposure: a single scalar that can silence the reasoning module is a single point of failure, and the biological system's answer is not redundancy but a stack of mutually antagonistic chemical brakes.

---

## Open problems

- **Whether the gain register is ever used as a *learned* control output.** Everything here is driven by arousal state and by task demand as inferred by the experimenter; nothing shows the controller setting per-spine gains as an action it selects.
- **The register can be driven from outside the brain, and its address is engagement rather than anatomy.** Continuous electrical stimulation of the ventral internal capsule/ventral striatum in humans raises induced prefrontal theta and speeds conflict responses by 34 ms, with **no** change in resting theta in the same sessions — so an exogenous scalar multiplies whatever the circuit is currently doing and leaves an idle circuit alone (Widge et al. 2019, [[wiki/concepts/cognitive-control.md]]). This is the closest thing the wiki has to a dose–response handle on the gain register, and it is still not a *learned* output: the experimenter sets it.
- **The addressing question.** Per-spine scope is asserted from the fact that signalling proteins are localised to individual spines; no experiment in the source shows a specific subset of inputs being gated in a task.
- **Interaction with the architecture register is unmodelled.** Chronic gain suppression causes spine loss, so the two registers are coupled in one direction; whether an architectural change alters the gain set-point is not addressed.
- **The capacity claim rests on two pharmacological improvements.** Apamin and xestospongin C improving working memory is consistent with an imposed margin and also with the drugs relieving an unrelated tonic suppression; no dose–capacity curve is given.

---

## Limitations

| Limit | Consequence |
|---|---|
| Explicitly a "working model" | Several central links (mGluR1/5 reducing network firing, α7 effects on network firing, aged-monkey recordings) are cited as unpublished data by the authors |
| Region, species and layer specific | Drawn from superficial layers of monkey dorsolateral prefrontal cortex; the authors flag orbital/serotonergic and rodent medial-prefrontal differences |
| Modulation is invisible outside a cognitively engaged circuit | *In vitro* excitability effects need not correspond to gain effects during a task — which also means the machine analogue must be measured under load, not at rest |
| Almost everything is pharmacological | Rescue and impairment by drug; no manipulation that sets a *specific* spine subset's gain and reads the consequence |

---

## Connections

- **[[wiki/concepts/working-memory.md]]** — supplies a fourth locus for this store's capacity limit and the only one that is *chosen*: recurrent excitation is held below its achievable level by a Ca²⁺→K⁺ negative feedback whose job is seizure prevention, and blocking that feedback pharmacologically improves performance.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the other register on the same spine: long-term potentiation changes what a connection stores by enlarging a sessile spine, this page changes whether the connection is expressed by opening channels in a long thin spine's neck, and the two are morphologically segregated so they can run independently.
- **[[wiki/concepts/dendritic-computation.md]]** — gives the gain register its spatial resolution: because a spine neck is an electrical bottleneck the shunt is local to one synapse, so the same machinery addresses one input or the whole cell depending only on where the second messenger rises.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — a non-GABAergic channel doing one of that page's jobs: D1 shunting of dissimilarly-tuned inputs sharpens selectivity exactly as lateral inhibition does, but its strength is set by arousal within a trial rather than by the interneuron wiring.
- **[[wiki/concepts/cognitive-control.md]]** — the control layer's substrate has a state parameter that page's model does not include: sustained bias only exists while the recurrent gain is high, and a stress-driven cAMP surge collapses the task model in seconds without touching anything the controller learned. The same page carries the upward direction of the same scalar, set electrically rather than chemically: raising the loop's gain improves control on every trial type of a conflict task and *slows* a value-based choice minutes later, which is a sign flip across tasks from one parameter and no arbitration logic (Widge et al. 2019).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the anatomical carrier of this page's closed loop: the ventral tier projects to the dopamine, noradrenergic and serotonergic cell groups that set the gain it runs at, and that page's neurochemistry table lists the same modulators as tier-specific tonic parameters.
- **[[wiki/concepts/control-unity-and-diversity.md]]** — the behavioural signature of a gain with an operating point: every neuromodulatory manipulation of control shows an inverted-U dose–response, which is what a shunt driven by a second messenger predicts and a monotone gain does not.
- **[[wiki/concepts/complementary-learning-systems.md]]** — one knob with opposite signs across the two systems: raising prefrontal cAMP impairs working memory and strengthens long-term consolidation, so hold-the-binding and commit-the-binding can be traded by a single scalar rather than scheduled separately.
- **[[wiki/concepts/attractor-dynamics.md]]** — the parameter the wiki's attractor stores fix at design time: whether a recurrent network holds, drifts or collapses is set here by a modulator on a seconds timescale, so the stability margin is a run-time variable rather than a property of the weight matrix.
- **[[wiki/entities/adaptive-cann.md]]** — the closed-form counterpart: that page's adaptation gain `m` moves a store between holding, sampling and searching, and this page names the biological implementation of `m` and the chemical signals that set it.
- **[[wiki/entities/pbwm.md]]** — the closest machine architecture and the point of difference: its dopamine term gates *what is written* into a stripe, while this page's modulators set *how strongly the stripe's recurrence runs at all*, which is a gain on the store rather than a gate on its input.
- **[[wiki/entities/trnn.md]]** — supplies the cost side of this page's energy argument in machine units: `⟨r²⟩` falls stepwise as maintenance becomes transient, which is the metabolic quantity the weakening pathways exist to conserve, and it is measured there and never used as a control variable.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — a test case at the implementation level (T1): the transferable object is a content-free multiplicative gain register with a state-variable set-point, which is an architectural claim, while the channel identities are substrate detail.
- **[[wiki/entities/meta-rl-agent.md]]** — the computational load this page's gain register carries: if prefrontal recurrence is the substrate of an emergent learning algorithm, then a neuromodulatory change in recurrent strength does not merely dim a memory, it detunes the inner learner (Wang et al. 2018).
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the same weight-register/gain-register split one scale up: that page places it on a single spine, the channel places a whole four-tuple `(weight, gain, writability, decay)` on an inter-regional projection, and dopamine is the shared knob.
- **[[wiki/concepts/precision-weighting.md]]** — the normative set-point rule this register lacks: if the gain *is* the precision of a prediction error, it is inferred by gradient descent on the same objective as everything else, which is the wiki's only proposal for a gain register that sets itself (Friston 2009, G56).
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — a second candidate set-point rule for the same register, arrived at from reinforcement learning rather than from inference: the noradrenergic gain *is* the inverse temperature of action selection, so it should be set from the value estimate and from the spread of action values — computed, like the precision rule, from quantities the agent already has, but without a shared objective to guarantee the loop converges (Doya 2002).
- **[[wiki/concepts/integration-segregation-balance.md]]** — the same content-free gain register read at network scale: a global arousal-set coupling change raises every parcel's between-module connectivity while leaving within-module connectivity untouched, which is what this page's per-spine gate would produce in aggregate — and the acute-stress disconnection is the failure mode a runtime integration dial inherits.
