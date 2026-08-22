# Mediodorsal Thalamus — the Context Variable Is Computed by the Loop It Gates

**The mediodorsal thalamus (MD) holds no cue and no rule. It holds the *cueing context* — which set of cues is currently in force — a variable it does not receive from the senses but **constructs by pooling from the prefrontal cue-selective cells it will then gate**, and returns to prefrontal cortex as two oppositely signed channels: transient MD neurons sustain the context-relevant representation, persistent MD neurons suppress the context-irrelevant one through cortical fast-spiking interneurons.**

> **Provenance.** Rikhye, Gilra & Halassa 2018, *Thalamic regulation of switching between cortical representations enables cognitive flexibility*, Nat Neurosci 21(12):1753–1763 (`raw/rikhye-2018-thalamic-switching-cognitive-flexibility.md`). Freely behaving mice, blocked switching between two learned two-cue sets over a cross-modal attentional-selection task; multi-site multi-electrode recording in prelimbic prefrontal cortex and MD (1789 prefrontal units, ~350 MD units, 5 mice), multi-neuronal Poisson generalized linear models with coupling filters, temporally precise optogenetic suppression at two calibrated laser powers, and a reservoir + MD-node simulation.

Why this earns a page. Every gating mechanism the wiki holds is handed its context signal — [[wiki/entities/context-modular-memory-network.md]] states plainly that the mask's source is outside the model, [[wiki/concepts/continual-learning.md]]'s context-gated-reachability row imports a striatal gate whose controller is unspecified, and [[wiki/concepts/contextual-inference.md]]'s posterior is fit rather than built. This is the one source in the wiki where the gate variable is measured, its *derivation* traced to the population it gates, and its removal scored on both the representation and the behaviour.

---

## The task and the variable stack

| Level | Where it is coded | Code | Number |
|---|---|---|---|
| **Cue** (which of four physical cues: high-pass noise, low-pass noise, ultraviolet flash, green flash) | Prefrontal regular-spiking **transient** cells | Brief elevation in **spike-timing reliability**, distinct cells tiling the delay | 233/1789 |
| **Rule** (attend-to-vision vs. attend-to-audition; two cues per rule, one per context) | Prefrontal regular-spiking transient **cue-invariant** cells | Same reliability code, equivalent for the two cues sharing a meaning | 102/1789 (~5%) |
| **Cueing context** (which two-cue set is in force) | Prefrontal **fast-spiking** cells, and MD | Broad, **persistent rate** change spanning the inter-trial interval and the delay | 418 prefrontal FS; MD is the most context-informative population recorded |

Two facts here are load-bearing before any thalamus enters. First, **two variables occupy one population in two different codes** — content in spike-timing reliability, context in rate — and the decoders separate accordingly (rule decodes better from regular-spiking cells, context better from fast-spiking cells). Second, the cue→rule step is *hierarchical and local*: coupling filters show cue-selective cells coupling strongly only to same-cue cells and weakly to cue-invariant ones, while cue-invariant cells receive strong input from cue-selective cells **across both contexts** (`p = 1.89 × 10⁻⁶`). The rule cell is a pooling of cue cells, and it is the same rule cell in both contexts.

Cue omission on 20% of trials drops the tuning strength of both transient classes, so the transient code is driven by the cue rather than by the trial structure.

---

## Where the context signal comes from

| Test | Result |
|---|---|
| Is MD's selectivity sensory (cue modality)? | No. Hetero-modal blocks are tracked; presenting all four cues randomised makes MD cells respond to all four, i.e. the *combination* becomes one context |
| Which prefrontal cells build it? | Cue-selective transient cells. >75% of the delay-period variance of **both** MD subtypes is explained by them, with a bias toward the context-congruent cue set (`p = 0.15 × 10⁻⁴`). Prefrontal persistent regular-spiking cells contribute nothing; prefrontal fast-spiking cells contribute nothing (they do not project to MD — a built-in validation of the coupling model) |
| Causal check | Suppressing prefrontal somata, or prefrontal terminals *in* MD, reduces MD contextual selectivity by about as much as deleting the prefrontal filters from the fitted model (`p = 0.42` for the difference). Bilateral suppression during the cue impairs behaviour |
| Pooling geometry | Fitted weights over 1000 simulated prefrontal units: **persistent** MD cells weight all prefrontal inputs near-uniformly (temporally unselective), **transient** MD cells weight co-tuned cells more strongly (temporally selective) |

So the context latent is a **low-dimensional read-out of the content population, computed outside it**, licensed by an anatomy the source names: individually small cortical terminals converge on single MD neurons, and MD lacks lateral connectivity, so it can average and multiplex where a recurrent cortical circuit could not.

**(brainstorm) The transferable shape is a loop, not a controller.** `c = f(h)` where `h` is the gated population's own activity, `f` is a wide, sparse, non-recurrent pooling, and the returned gate `g(c)` multiplies `h` and its plasticity. That is cheaper than any wiki mechanism for the same job — no task label ([[wiki/entities/context-modular-memory-network.md]]), no fitted Dirichlet prior ([[wiki/entities/coin-model.md]]), no similarity function over tasks ([[wiki/concepts/cross-paradigm-interface.md]]) — and its stability condition is exactly that `f` be *temporally* rather than *identity* selective, which is what the two MD weight profiles above measure. Its obvious failure mode is also visible: a variable pooled from the content cells cannot signal a context those cells have never expressed, which is why the first exposure to a new block costs 4–8 trials.

---

## Two thalamic channels, opposite signs, separable by excitability

| | **Transient MD** | **Persistent MD** |
|---|---|---|
| Response | Brief reliability peak, tiling the delay; equal for both cues in the block | Sustained rate change across delay and inter-trial interval |
| Functional input to prefrontal cue-selective cells | Predominantly **excitatory** | Predominantly **inhibitory** |
| Coupling to prefrontal fast-spiking cells | Weaker | **Stronger** (`p = 0.78 × 10⁻²`) — the inhibition is delivered through cortical interneurons |
| Excitability | Lower (needs stronger, more coincident cortical drive) | Higher |
| Optogenetic separation | **Silenced by weak laser** (0.6–1.1 mW) | Unaffected by weak laser; needs 2.1–3.5 mW |
| Job | Maintain the context-relevant representation — permits the cue to be held through the delay | Suppress the context-irrelevant representation |
| Removing it | Excitatory functional inputs to prefrontal cortex vanish; tuning of both transient prefrontal classes falls; fast-spiking cells unaffected (`p = 0.81`) | Out-of-context cue-selective spiking rises; fast-spiking spiking falls; coupling filters into cue-invariant cells take longer to stabilise |

Coupling to prefrontal *cue-invariant* (rule) cells is near-absent (`p = 0.58 × 10⁻⁵` against cue-selective) — **the thalamus gates the content layer and never touches the abstraction built from it.**

The bimodal resting membrane potential of MD neurons is what makes the two channels separately addressable by laser power. That is a methodological point with an architectural consequence: **a single actuator with a graded strength addresses two functionally opposite populations in a fixed order**, because they differ in excitability rather than in receptor or projection target. No machine gate in the wiki has a dose–order.

---

## Switching, and what the switch cost actually is

- Blocking the four cues into two contexts beats presenting them equiprobably (`p = 0.023 × 10⁻³`) — a performance advantage for having a context at all, independent of how the cues are grouped by modality.
- At each block switch, performance drops for **4–8 trials** despite both cue sets being fully learned.
- During those trials the **coupling filters from cue-selective to cue-invariant prefrontal cells are re-stabilising**, and their stabilisation latency explains ≈**87%** of the variance in behavioural switch latency (`p = 0.0068 × 10⁻⁶`, 33 sessions). The prefrontal→MD coupling also re-stabilises but too fast to correlate with behaviour.
- Bilateral MD suppression during the cue has **no effect once performance is stable inside a block** and a large effect on how long the switch takes (`p = 0.78 × 10⁻⁴`), with a matching increase in filter stabilisation latency (`p = 0.19 × 10⁻⁴`).

**The switch cost is therefore not a decision latency and not a memory retrieval — it is the settling time of a re-routing inside the cortex, and the thalamus sets its rate.** That is a directly checkable claim for any model with a context gate: the cost of a context change should scale with how much of the downstream mapping has to be re-fit, not with the ambiguity of the context evidence.

---

## The weight-protection result

The claim the paper is built toward: cross-contextual suppression is not only interference control, it **preserves the suppressed connections for later reuse**.

**Model.** 1000-unit rate reservoir as prefrontal cortex, `τ = 20 ms`, each cue driving a disjoint set of 200 units. The MD node is a one-hot context vector acting **twice**: an additive `w^{MD+} = −10` onto units belonging to the other context, and a **multiplicative** `μ_i = Σ_m w^{MD×}_{im} r^{MD}_m` (`= 8` for in-context units) scaling the *recurrent* input, so `τ İ_i = −I_i + Σ_k w^{in}_{ik} cue_k + Σ_j (1 + μ_i) w_{ij} r_j + Σ_l w^{MD+}_{il} r^{MD}_l`. Output weights are the only plastic parameters, `τ_w ẇ = −r_i ε_n`, learning always on. The prefrontal-only control sets `w^{MD+} = 0` and `w^{MD×} = 2`.

| Observation | Reading |
|---|---|
| PFC+MD beats PFC-only in mean squared error across two context switches | Gating buys sequential-task retention |
| Without MD, weights from context-1 units change during context 2; with MD they do not | The mechanism is **restricted reachability**, not a penalty. Suppressed units carry no rate, so their outgoing weights receive no gradient |
| The benefit is larger on **XOR**, a non-linearly-separable version of the task | Gating pays more where the representations must be genuinely disjoint |

**Experiment.** Three blocks — context 1, context 2, context 1 again — with bilateral MD suppression only during block 2.

| Result | Number |
|---|---|
| Performance on re-exposure to block 1 | Falls to **chance**, as if the first context had been forgotten |
| Recovery | Full, the next day — no lasting damage |
| Dose response | Deficit grows with the number of suppressed trials in block 2, inflection at ≈**20 trials** |
| Switch-back latency | Prolonged (`p = 0.09 × 10⁻⁴`), and more so than an ordinary switch, because block 3 requires *reactivating* an ensemble rather than establishing one |
| Without suppression, are the block-1 cells reused in block 3? | Yes — cue-selective and cue-invariant tuning strengths are preserved across blocks 1 and 3 (no significant change) |
| With unilateral suppression in block 2 | Block-1 cells fire out of context during block 2; on the switch back their **coupling onto cue-invariant cells is much weaker**, even though the cells are recruited on time |

**What the wiki gains from this.** [[wiki/concepts/continual-learning.md]] carries context-gated reachability as a solution family with a striatal ancestor, a stated failure mode and no in-vivo measurement of the *protection*. Here the protection is measured by removing the gate and scoring the earlier task: chance performance, dose-dependent, reversible, with the damage localised to the **coupling filters** rather than to the cells' tuning. Two consequences.

1. **The corrupted object is an edge, not a unit.** Block-1 cells are still selective and still recruited in block 3; what was destroyed while they fired out of context was their functional connection onto the rule cells. Weight-protection methods that score importance per parameter of a unit would have protected the wrong thing here.
2. **The gate's own dose matters.** ~20 trials of out-of-context firing is the point past which the deficit accelerates. Every gating mechanism in the wiki is binary and instantaneous; this one has an **integrated exposure** below which nothing is lost, which is the shape of a plasticity budget rather than of a switch.

---

## What it says about the wiki's control-layer claims

**Suppression is a separate population, doubly dissociated from enhancement.** [[wiki/concepts/cognitive-control.md]]'s mechanism holds that "enhance the relevant" and "suppress the irrelevant" are one operation, because the controlled substrate mutually inhibits and a small excitatory bias decides the local competition for free. Here the two halves come from **different thalamic cells with different excitabilities and different cortical targets**, and are removed separately: weak suppression eliminates the excitatory input and the transient prefrontal tuning while leaving fast-spiking firing and out-of-context spiking untouched; strong suppression raises out-of-context spiking and lowers fast-spiking firing. See [[wiki/empirical-tensions.md]] T275.

**A partial derivation of a rule cell.** That page's standing open problem — "how an abstract rule is *learned* is not addressed at all; the rule cells are demonstrated, never derived" — gets its first mechanical account here, at the level below abstraction across modality: a cue-invariant cell is a pooling of cue-selective cells from *both* contexts, and the context-appropriate half of that pooling is selected by re-stabilising coupling filters at each switch, on a timescale that predicts the behaviour. It is a derivation of the *invariance*, not of the abstraction — the meaning shared by the two cues is supplied by the reward contingency, not extracted.

**The named generator of the beta channel.** [[wiki/concepts/inhibitory-control-of-coding.md]] carries prefrontal beta bursts as a spatiotemporal filter deciding when and where information is expressed, with "mediodorsal thalamus–prefrontal loop" listed as the likely generator and no measurement attached. This supplies the cellular version of that guess: a thalamic population whose output is inhibitory-at-the-target, addressed at the sites holding no-longer-relevant content, and routed through the fast-spiking cells that generate beta.

---

## Limitations

- **The excitatory/inhibitory assignment is functional, not synaptic.** MD projections are glutamatergic; "inhibitory functional input" means a negative coupling filter in a fitted generalized linear model plus a correlated drop in fast-spiking firing. The interneuron class through which persistent MD acts is not identified — the source says so, and offers only the guess that transient MD recruits disinhibitory motifs while persistent MD targets soma-targeting cells.
- **The two subtypes are separated by laser power**, i.e. by inferred excitability, not by a genetic marker or a projection target. Every causal claim about the two channels rests on that dose calibration holding.
- **The reservoir model is not a fit to the recordings.** Its MD node is a one-hot context vector supplied by the experimenter — the very thing the physiology says is *computed*. So the paper's mechanistic claim (context pooled from cortex) and its computational claim (gating protects weights) are demonstrated in two disjoint systems.
- **Plasticity in the model is confined to the output weights**, so "protects unused cortical traces" is demonstrated for a linear read-out, not for a recurrent representation.
- **Only ~5% of mouse prefrontal cells are rule-selective**, against much larger fractions in primates; the source itself uses this to explain why mice do badly on randomised cueing. The hierarchy may be shallower here than the framing implies.
- **Contexts are experimenter-imposed blocks.** Nothing in the data shows MD *discovering* a context, only tracking one whose statistics are stationary within a block.

---

## Connections

- **[[wiki/concepts/continual-learning.md]]** — the in-vivo measurement its context-gated-reachability row was missing: removing the gate during the second task drops the *first* task to chance on re-exposure, dose-dependently (inflection ≈20 trials) and reversibly, with the damage localised to the coupling filters between content and rule cells rather than to either cell's tuning.
- **[[wiki/concepts/cognitive-control.md]]** — the direct challenge to bias-not-routing: enhancement and suppression are carried by two thalamic populations with different excitabilities and different cortical targets, removable one at a time (T275), and the same data supply a partial derivation of that page's undelivered rule cell as a context-selected pooling of cue cells.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — names and measures the controller behind the beta channel: a thalamic population whose functional input to prefrontal cortex is inhibitory, delivered through fast-spiking interneurons, and addressed specifically at content that has stopped being relevant.
- **[[wiki/concepts/contextual-inference.md]]** — the same context latent obtained without a posterior: it is *pooled from the content population* rather than inferred from a likelihood, so it has no uncertainty, cannot allocate a new context, and cannot signal a context the content cells have never expressed — which prices what the Bayesian machinery buys.
- **[[wiki/entities/context-modular-memory-network.md]]** — supplies the controller that model declares outside itself: the mask signal is computed by a low-dimensional relay pooling from the very population the mask will gate, at a cost far below the `s·N` that model's authors estimate for a synaptic gating controller.
- **[[wiki/concepts/working-memory.md]]** — makes the thalamo-cortical maintenance loop two loops with opposite signs: one thalamic population sustains the item being held, another suppresses the items the current context does not license, and only the second has a behavioural cost that appears at switches rather than within a block.
- **[[wiki/entities/nucleus-reuniens.md]]** — the other thalamic relay in the wiki, and the contrast that defines both: reuniens collateralises one spike train to two structures and carries *content* (a goal-conditioned future path), where this nucleus pools from one structure and returns a *context* that gates it — a broadcast bus against a closed control loop.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the cortical end of this loop, recorded at cell-type resolution: the controller's content cells are the source of the thalamic context signal and the target of its two return channels, and the switching deficit here is the physiological form of that page's acquire-vs-replace dissociation.
- **[[wiki/entities/pbwm.md]]** — the closest architecture and the point of difference: PBWM's thalamus is a disinhibited write-enable released by the basal ganglia, carrying no variable of its own, where this thalamus computes the context, returns it as two signed channels, and never gates the abstraction layer at all.
- **[[wiki/concepts/effective-connectivity.md]]** — the method used throughout: coupling filters from a multi-neuronal Poisson generalized linear model, validated by matching the model's ablation (delete the prefrontal filters) against the experiment's (suppress the prefrontal terminals), and falsified where it should be (no coupling from fast-spiking cells, which do not project to the thalamus).
- **[[wiki/concepts/cross-paradigm-interface.md]]** — the engineering twin of the same loop with the source of the gate replaced: there a separate network reads a task-similarity function it is handed and emits per-neuron thresholds; here the gate variable is pooled from the gated population itself, so no similarity function is needed and nothing external supplies the context.
- **[[wiki/concepts/attention.md]]** — attentional set as a gated *content layer* rather than a biased sensory competition: the cue and rule live in prefrontal cortex, the set that licenses them lives in thalamus, and the behavioural signature of the split is a switch cost that tracks cortical re-routing rather than cue processing.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a cheap implementation of the rule-config latent: the context is a low-rank projection of the instance-level activity, returned as a gate on that activity, so the meta/instance split is enforced by reachability rather than by a factorised representation.
- **[[wiki/concepts/transthalamic-context-routing.md]]** — the same organ with the loop opened: this nucleus pools context *from* the prefrontal population it gates and returns it there, while the higher-order visual thalamus pools arousal state from an upstream sender's layer-5/6 cells and delivers it to a *different* cortical area — two topologies for one anatomy, which is why "what the thalamus does" is under-specified without naming the pre- and postsynaptic areas (Neske & Cardin 2025).
- **[[wiki/entities/ch-hnn.md]]** — the engineering version of this page's gate, and what it leaves out: a separate network emits a per-neuron mask on the learner, but the mask is one-signed (it selects, it does not also suppress the out-of-context units) and its input is a separate perceptual pathway rather than being pooled from the gated population itself.
