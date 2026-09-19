# Encoding–Retrieval Alternation

**A store cannot write and read at the same time, and the hippocampus does not solve this by switching modes strategically — it alternates at 4–8 Hz, continuously, a few times per second. The two half-cycles then double as the *minus* and *plus* phases of an error-driven learning rule, which converts the fast store from a Hebbian recorder into a predictor trained on its own recall failures** (O'Reilly, Bhattacharyya, Howard & Ketz 2011, reviewing Hasselmo et al. 2002).

---

## The conflict this exists to resolve

[[wiki/concepts/pattern-separation-completion.md]] states the trade-off as one transfer curve. The dynamic version is sharper: encoding *needs* maximal separation, retrieval *needs* maximal completion, and the parameters are shared, so any setting that optimises one degrades the other (O'Reilly & McClelland 1994).

| Parameter | Helps separation | Helps completion |
|---|---|---|
| Hebbian potentiation (LTP) on the recurrent collaterals | — | ✔ (deepens basins) |
| Heterosynaptic depression (LTD) of inactive-pre → active-post synapses | ✔ (restores separation LTP destroys) | — |
| Layer count in the feedforward chain (EC → DG → CA3) | ✔ — separation **compounds** across stages | ✘ — completion does not |
| Sparseness `a` | ✔ | ✘ |

The static compromise is the anatomy. The dynamic compromise is the theta cycle: rather than pick a point on the curve, **run both endpoints in alternation and let each half-cycle be short enough that neither corrupts the other**.

---

## The mechanism (Hasselmo's theta-phase model)

| Theta phase | EC → CA3/CA1 drive | CA3 recurrent drive | Plasticity | Mode |
|---|---|---|---|---|
| Peak | **Strong** | Weak | LTP on the active conjunction | **Encoding** — the input pattern drives CA3/CA1 without contamination from what CA3 would have completed |
| Trough | Weak | **Strong** | LTD | **Retrieval** — CA3 completes from a partial cue and drives CA1, uncontested by the input |

Support cited: within-theta switching of CA1's dominant input between EC and CA3 (Colgin et al. 2009); phase-dependence of encoding vs retrieval success (Manns et al. 2007; Rizzuto et al. 2003).

**The within-cycle ordering is now measured on the CA3 population itself, not inferred from CA1's afferents** (Jezek, Henriksen, Treves, Moser & Moser 2011, `raw/jezek-2011-theta-paced-flickering-between-place-cell-maps.md`). Under an instantaneous cue switch between two orthogonally-coded environments, CA3 theta cycles that correlate with *both* stored charts — the signature of a population not yet committed — are rarer than a unit-shuffle null in both halves of the cycle, but the margin grows sharply from the first half (`p < 0.05`) to the second (`p < 0.001`). The authors' reading is this page's two-drive schedule stated as an ordering: **afferent input can override the attractor early in the cycle, and late activity is set by propagation through the recurrent collaterals**, which is also what a completed retrieval inside ~120 ms requires. Two cautions before this is counted as confirmation. The cycle boundary here is the phase of *minimum population firing*, chosen empirically because it maximised the separation between charts; nothing in the source aligns that boundary to the LFP peak and trough that Hasselmo's table is written in, so the ordering is established and the registration to "encoding phase" and "retrieval phase" is not. And the effect is the disappearance of mixtures, not a change of drive — it constrains *when the recurrent network has won*, not when the entorhinal input was strong.

**The schedule is a metronome, and that is the part no store copies.** The same data show the read being re-run every cycle whether or not anything changed: the flicker rate rises from a 1–3% baseline to 10–15% for about five seconds after the switch and then decays, so for seconds the hippocampus is re-deciding which chart it is in, several times a second, on an input that is constant. This is the opposite answer to `G49`'s question from the one prefrontal cortex gives — there a controller names an item and a lead time; here nobody schedules anything and the store simply reads on the clock's edge. The source's own proposal for what the repetition buys is **error correction**: a completion run once per stimulus (its cited contrast is inferior temporal cortex) has no opportunity to revise, whereas one re-run at 8 Hz can converge under weak or ambiguous cues. Nothing measures the benefit, and no architecture in the wiki re-reads at all (`G123`).

**The load-bearing property is the *rate*, not the existence of a switch.** The prevalent alternative — a strategic, controlled, infrequent switch between "I am now studying" and "I am now remembering" — is what the cholinergic mode signal implements ([[wiki/concepts/neuromodulatory-metaparameters.md]]). At 4–8 Hz the switch is far too fast to be under task control, so the system is *always* doing both, and the mode bit is not information the controller has to supply.

---

## Why the rate matters: the two phases are a learning signal

This is O'Reilly's addition and the reason the page exists. If retrieval always immediately precedes encoding, then within every ~150 ms the network produces:

1. **Minus phase** (trough, retrieval): what the store *predicted* the current situation contains, generated by completion from a partial cue.
2. **Plus phase** (peak, encoding): what the situation *actually* contains, driven by entorhinal input.

`Δw ∝ (plus − minus)` is then available locally, with no labels, no teacher and no second network — the Leabra/GeneRec contrastive form ([[wiki/concepts/biologically-plausible-credit-assignment.md]], [[wiki/concepts/equilibrium-propagation.md]]).

**Measured effect** (Bhattacharyya, Howard & O'Reilly, reported as unpublished data in the review; Leabra/Emergent implementation of the CLS hippocampus):

| Condition | Recall error on a hard classification task |
|---|---|
| No phase modulation — Hebbian only | Learning curve flat/slow; many trials never recalled perfectly |
| Attenuate EC→CA1 during the *recall* phase, so the minus phase is a genuine prediction | **Markedly lower** sum-squared error and fewer unrecallable trials |

The ablation is the informative half: the benefit comes specifically from **preventing the answer from leaking into the phase that is supposed to be a guess**. A minus phase driven by the input is not a prediction, and the delta collapses to zero.

**A second use of the same oscillation, with the plasticity *sign* flipped rather than the drive** (Norman, Newman & Detre 2006, 2007): let inhibition oscillate instead, and

| Half-cycle | Inhibition | Which units are active | Update |
|---|---|---|---|
| Low-inhibition | ↓ | units of *competing* memories intrude | **weaken** them |
| High-inhibition | ↑ | units that *should* be on fall silent | **strengthen** them |

This is a "stress test": each memory is probed at the margin and its weak elements reinforced while its nearest competitors are pushed away. It is the same oscillatory scaffold used for **differentiation** rather than for prediction error, and it is the direct ancestor of the sleep-stage rebalancing model in [[wiki/concepts/offline-replay.md]] (Norman, Newman & Perotte 2005).

---

## What this buys a builder

- **The phase-control signal has a free source.** The wiki's standing objection to every two-phase local learning rule is objection 6 — *who tells the network which phase it is in?* ([[wiki/concepts/biologically-plausible-credit-assignment.md]]). Here nobody does: an endogenous 4–8 Hz oscillator supplies the phase, the same oscillator that already gates plasticity, and it is uninformative about the task. That converts a control problem into a hyperparameter (the frequency).
- **The fast store becomes error-driven at no architectural cost.** Every fast store in the wiki — Hopfield, sparse distributed memory, differentiable-neural-computer memory matrix, HAMI's episodic buffer — writes what it is given. This one writes *what it got wrong*, using a target it manufactures by running its own read one half-cycle earlier.
- **(brainstorm) The runnable version is small.** Take any content-addressable store with a learned write. Each step: (i) read with the cue only, record `m⁻`; (ii) clamp the full observation, record `m⁺`; (iii) update on `m⁺ − m⁻`. No extra parameters, no task boundary, no replay. The prediction that distinguishes it from plain one-shot writing is that redundant episodes should produce *no* write, because the store already predicts them — an automatic novelty gate falling out of the learning rule rather than bolted on ([[wiki/concepts/recall-gated-consolidation.md]] reaches a very similar gate from a normative direction, with the sign reversed: it writes *when* recall succeeds, this writes *what* recall missed).
- **It gives the fast/slow split a shared learning rule.** If the same delta drives cortex, then the theta oscillation is not a hippocampal specialisation but the clock of a brain-wide contrastive rule — proposed explicitly in the source as a future direction, and untested.

---

## Open problems

- **Who sets the phase for the receiver?** For the delta to be meaningful in cortex, cortical plasticity must be aligned to the hippocampal theta phase. The review proposes prefrontal cortex as the modulator of hippocampal theta dynamics (Jones & Wilson 2005 as suggestive evidence), which would make the encode/retrieve balance *controllable* by the same structure that sets task goals — but this reverses the "no controller needed" advantage above, and nothing measures it.
- **Does the minus phase contaminate the plus phase?** The simulation had to *attenuate EC→CA1 during recall* by hand. In the biological circuit the corresponding gating is asserted, not measured with the resolution needed.
- **The result is unpublished data in a review.** One task, one implementation, no baseline against a non-oscillatory error-driven control — so the claim "the oscillation is what buys the improvement" is not separated from "error-driven learning is better than Hebbian learning", which was already known.
- **Rate vs phase.** [[wiki/empirical-tensions.md]] T32 asks whether serial order is carried by oscillatory phase or by rate-coded attractor transitions. If the rate account wins, this page's clock has to come from somewhere else, since the same oscillation is doing double duty here (order *and* mode).
- **No machine implementation exists.** Not in any architecture in the wiki.

---

## Connections

- **[[wiki/concepts/attractor-dynamics.md]]** — supplies the within-cycle evidence for this page's ordering in a form the page did not have: the *content* of the cycle is a single chart, exclusivity tightening from the first half to the second, so the alternation is visible in what the population represents and not only in which afferent dominates.
- **[[wiki/concepts/pattern-separation-completion.md]]** — supplies the conflict this page resolves in time rather than in parameters: separation and completion pull the same knobs in opposite directions, and alternating at 4–8 Hz means never having to choose a point on the curve — a controller for G38 that needs no error signal and no neuromodulator, only a clock.
- **[[wiki/concepts/complementary-learning-systems.md]]** — turns that page's fast store from a buffer into a learner: the retrieval half-cycle is a prediction and the encoding half-cycle is its outcome, so the hippocampus trains on its own recall failures before anything is transported to cortex.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — answers that page's last surviving objection to the contrastive family (who supplies the phase signal) with an endogenous oscillator that is uninformative about the task, at the cost of a fixed cycle length the network cannot lengthen for hard problems.
- **[[wiki/concepts/equilibrium-propagation.md]]** — the same two-phase difference derived from an energy function instead of from an anatomy; this page supplies a biological clock for the free/clamped alternation that page treats as an external schedule.
- **[[wiki/concepts/offline-replay.md]]** — the oscillatory-inhibition variant here is the mechanism that page's sleep-rebalancing model runs on, and this page's theta cycle is the online counterpart of that page's ripple: same store, two clocks, two jobs.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the rival architecture for the same mode bit: acetylcholine sets storage-vs-retrieval globally and slowly, this sets it locally and 4–8 times a second, and the two are compatible only if the neuromodulator biases the *ratio* of the half-cycles rather than selecting a mode.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — the measurable signature of this page's alternation, and a mechanism for it: CA1's internal (CA3) and external (entorhinal) afferents dominate at different theta phases and are separated in the gamma sub-band as well, so which mode the store is in is readable off the receiver's own spectrum without touching either source.
- **[[wiki/concepts/temporal-coding.md]]** — a second job for theta phase beyond ordering spikes within a sequence: the phase is also a mode variable, so any model that spends theta phase on serial order has to explain how the encode/retrieve alternation coexists with it (T32).
- **[[wiki/concepts/synaptic-plasticity.md]]** — requires the potentiation/depression sign to be phase-locked to an oscillation rather than set purely by spike timing, which is a constraint on the write rule that no spike-timing-dependent-plasticity kernel in the wiki carries.
- **[[wiki/concepts/recall-gated-consolidation.md]]** — the same quantity (the fast store's own recall of the current item) read with the opposite sign: that page uses recall *success* as a license to write to the slow store, this uses recall *failure* as the error signal for writing to the fast one — so one statistic can gate both stores if the signs are kept straight.
- **[[wiki/concepts/continual-learning.md]]** — supplies that page with a write gate no continual learner in the wiki has: because the encoding half-cycle updates on the difference between what was recalled and what arrived, an already-known item produces a null update, so protection against interference needs no importance estimate, no task boundary and no exemplar buffer.
- **[[wiki/entities/hopfield-network.md]]** — what a fast store looks like with no alternation: writes are unconditional and content-blind, so redundant episodes cost capacity, which is exactly the failure the minus-phase gate removes.
- **[[wiki/concepts/retrieval-mediated-learning.md]]** — the direct friction with this page: retrieval-mediated integration *requires* the completed content to be present while the new pair is written, which is exactly the contamination the theta model exists to prevent, and nothing measures whether reinstated absent-item content is phase-locked to the trough.
- **[[wiki/concepts/hippocampal-long-axis.md]]** — the rival, spatial version of this page's split, and why it fails: an anterior-encoding / posterior-retrieval division of the hippocampus is ruled out because retrieval reactivates the very cells that encoded the event, which is the argument that forces the alternation into the time domain.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — a slow, controller-driven version of this page's alternation: on a successful remote recall the cortical match is proposed to inhibit the hippocampus and on a mismatch to release it, so the encode/retrieve decision is taken per retrieval by another region rather than per theta cycle by the store itself.
- **[[wiki/concepts/reference-frame-transformation.md]]** — where the schedule's control signal lands: the mode scalar is a gain on an *interface's* afferents and efferents rather than on either store, so one parameter sets which of two representations drives the other (`G110`).
- **[[wiki/entities/bb-model.md]]** — the alternation implemented with an intermediate setting, and what the intermediate buys: leaving top-down connections partially open during perception ("bleed") makes memory of a removed boundary or object leak into the perceptual representation, which yields trace fields, a novelty signal localised in peri-personal space, and a spatial firing field on a nominally non-spatial identity cell — so theta reads as a periodic *comparison* rather than a gate between two processes.
- **[[wiki/entities/neuron-astrocyte-associative-memory.md]]** — a one-scalar machine implementation of the alternation: a global `r ∈ {0,1}`, attributed to acetylcholine, swaps the input population between keys and queries and switches one term of the neuron equation, with exponential convergence proved in both modes — against this page's complaint that the biological schedule has no machine counterpart that is not hand-written control flow (Kozachkov, Slotine & Krotov 2023).
