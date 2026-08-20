# PBWM (Prefrontal Cortex / Basal Ganglia Working Memory)

**A working-memory model in which the store is prefrontal cortex, the *write enable* is basal-ganglia disinhibition, and the policy that decides when to write is learned by reinforcement from a dopaminergic critic — so the "central executive" is a trained gating policy rather than a homunculus** (O'Reilly & Frank 2006, `raw/oreilly-2006-making-working-memory-work.md`).

The wiki's other fast stores either fix their write policy by design (thresholded allocation, sparsity, `τ_f`) or hand it to a differentiable controller trained by backpropagation through time. PBWM is the one entry where **what to store is itself the learned quantity**, and it is learned without any gradient flowing backwards through time.

---

## Architecture

| Layer | Biological identification | Function in the model |
|---|---|---|
| PFC stripes | Isolated interconnected groups in prefrontal cortex (~20,000 estimated in human frontal cortex; 4–6 in the simulations) | The store. Maintenance by an extra excitatory ion channel (`g = .5`) *toggled* by a gating pulse — bistability plus recurrence, not a decaying trace |
| Striatum Go / NoGo | Direct (D1) / indirect (D2) pathway spiny neurons, one Go+NoGo pair per stripe | The **actor**: a per-stripe binary write-enable policy, input = current sensory input + prior PFC context |
| SNrThal | SNr / GPe / thalamus collapsed into one unit per stripe | `net_j = [Go_j − NoGo_j]⁺` normalized, then kWTA across stripes → stripes *compete* to update PFC; above threshold (.1) it toggles that stripe's maintenance current |
| PVLV (PVe/PVi, LVe/LVi) → SNc/VTA | Lateral hypothalamus, ventral-striatal striosomes, central amygdala → midbrain dopamine | The **critic**: a scalar dopamine signal `δ` evaluating the *new PFC state* |

Gating is by **disinhibition**: Go firing inhibits the tonically active SNr, which releases the thalamus, which enables — does not cause — the PFC toggle. Robust maintenance is the *default* (NoGo, no toggle); updating is the event that has to be earned.

### The three demands, and why they force a gate

| Demand | Example in the 1-2-AX task |
|---|---|
| Rapid updating | Each incoming stimulus must be encodable immediately |
| Robust maintenance | The outer-loop task cue (1 or 2) must survive many inner-loop items and distractors |
| Selective updating | Inner-loop `A`/`X` are overwritten *while* the outer-loop cue is held |

The first two are contradictory in any single-timescale recurrent network; the third rules out one global gate. Hence: one gate **per stripe**, controlled by a policy, with an outer loop (task cue) and inner loops (cue–probe pairs) held in different stripes.

---

## The learning problem, split in two

| Problem | Statement | PBWM's answer |
|---|---|---|
| **Temporal credit assignment** | Storing `1` pays off only later, when `A-X` arrives | PVLV — an associative (not predictive) critic, evaluated on PFC state |
| **Structural credit assignment** | *Which stripe* should hold *which* item | The global `δ` is multiplied per stripe by that stripe's own Go activation: `δ_j = snr_j · δ` — a stripe that did not act receives no learning signal |

Structural credit assignment is proposed to be implemented anatomically by SNr → SNc inhibition, so a Go-firing stripe disinhibits its own dopamine supply. Ablating it (`No SNrThal DA Mod`) is the single most damaging manipulation in the paper.

### PVLV: dropping prediction for association

TD learning explains the dopamine record by *chaining* predictions across adjacent time steps; any unpredictable event breaks the chain, and in the 1-2-AX task the stimulus sequence is nearly unpredictable by construction. PVLV replaces the chain with two Rescorla–Wagner systems that only ever use the current time step:

| System | Trained by | Learns | Effect on `δ` |
|---|---|---|---|
| **PV** (primary value) | Primary reward `r_t` at *every* step | `V̂_pv = Σ_i w_i x_i`; `δ_pv = r_t − V̂_pv`; `Δw_i = ε δ_pv x_i` | Cancels the burst at expected reward delivery |
| **LV** (learned value) | Only when primary reward is present **or expected by PV** | A reward *association* for the currently active state | Fires at cue onset (`LVe`, fast, excitatory; `LVi`, slow, inhibitory) |

The trick is the **training mask**: because LV is not trained at times when no reward is expected, it is never punished for firing at cue onset, so anticipatory dopamine appears without a prediction chain. "Anticipatory dopamine is a reward *association*, not a reward *prediction*" — see [[wiki/empirical-tensions.md]] T85.

### The catch-22, and why two systems are needed

The critic must learn the value of *maintaining* something, so it must read PFC state, not the transient sensory input that caused it (which may be many steps gone). But PFC only reflects an input *after* it was gated in — so the system cannot know a store was worth making until it has made it. Resolution:

1. Striatum decides to gate, from **sensory input + prior PFC context** (phase `+`).
2. PFC updates (a third settling phase `++`, after the motor response has been made — updating must not disturb the context that produced the response).
3. PVLV evaluates the **new PFC state**; the resulting `δ` modulates Go/NoGo activations, and the delta between phases `+` and `++` is the striatal weight change: `Δw ∝ (y⁺⁺ − y⁺) x`.

So the critic supplies *immediate* feedback for an action whose real payoff is delayed — the delay is absorbed once, at reward time, into the critic's associations over PFC states. Trial-and-error is unavoidable: `Random Go` firing (triggered when a stripe's average `δ` at Go time is negative and it has not fired in 10 trials, `p = .1`; plus a `.0001` baseline) is the exploration mechanism, and it is load-bearing.

---

## Results

Epochs to criterion, 20 networks each, against three backpropagation-through-time controls (LSTM with forget gates, real-time recurrent backprop RBP, simple recurrent network SRN), all with parameters searched:

| Task | Finding |
|---|---|
| **1-2-AX** | PBWM ≈ LSTM ≈ RBP (~500–1000 epochs); SRN ~3000 and only with 100 hidden units and hysteresis ≥ .5 (0% success at hysteresis .1–.2) |
| **SIR-2, dedicated stimuli** | PBWM ≈ LSTM ≈ RBP; SRN ~40,090 epochs |
| **SIR-2, shared stimuli** | **The gated/non-gated split**: PBWM and LSTM learn; RBP and SRN never reach the stricter criterion |
| **Phonological loop** (3-item sequence recall, 300 train / 300 novel test sequences of 10³) | Both gated models learn faster *and* generalize; SRN essentially memorizes |

The shared-stimulus result is the informative one. With dedicated stimulus units, the input itself says what to do with it, so a fixed input→memory weight suffices. With shared units, the same `A` must go to store 1, store 2, or nowhere depending on a *separate* control input — there is no fixed weight that works, and only a gated architecture can route it. Same argument in the phonological loop: a stripe learns to hold "the 3rd phoneme, whichever it is", which is why generalization to unseen sequences is near-perfect.

### Component ablations (% of networks reaching criterion; full model = 100%)

| Manipulation | 1-2-AX | SIR-2 | Loop |
|---|---|---|---|
| No Hebbian learning (posterior cortex only) | 95 | 100 | 100 |
| No DA contrast enhancement | 80 | 95 | 90 |
| No Random Go exploration | **0** | 95 | 100 |
| No LVi (slow LV baseline) | 15 | 90 | 30 |
| No SNrThal DA modulation (structural credit), DA = 1.0 | 15 | 5 | 0 |
| … DA = 0.5 / 0.2 / 0.1 | 70 / 80 / 55 | 20 / 30 / 40 | 0 / 20 / 20 |
| No DA modulation at all | **0** | **0** | **0** |

Reading: **learning the gate is the whole model** (last row), **per-stripe credit assignment is nearly as necessary as the learning signal itself** (and the DA=0.5/0.2/0.1 controls show the damage is not just a change in overall dopamine level), and **exploration is what makes the hardest task learnable at all** — a store that never writes never receives a training signal about writing.

---

## Gating as variable binding

Two stripes act as slots; the control input decides which slot an item is bound to. This is dynamic routing of a value to an address, learned rather than wired — the wiki's cheapest instance of binding without a binding mechanism. The authors' own limit is explicit and worth carrying: PFC stripes are **not** symbolic variables. Each stripe must *learn to encode* the items it will hold, and downstream layers must *learn to decode* that particular stripe, so an arbitrary value cannot be placed in an arbitrary slot. Binding generalizes over fillers within a learned vocabulary (10 phonemes, 5 letters), not over arbitrary content.

## Limitations

| Limit | Consequence |
|---|---|
| Hundreds of trials to learn 1-2-AX; humans do it from one verbal instruction | The model is an account of *monkey-style* acquisition of a control policy, not of instructed behaviour. The gap ("generativity") is named as the field's biggest open problem, not addressed |
| Slots are not general | See above: no arbitrary store into an arbitrary stripe |
| Three-phase settling (`−`, `+`, `++`) is imposed | Biologically it would need PFC updating to lag motor output by a fixed delay; the schedule is a modelling convenience |
| Stripe topography of SNc dopamine is a prediction, untested | The paper concedes it would need parallel multi-stripe dopamine recordings; it may instead live in terminal release regulation |
| Gating is binary and toggling | A Go both writes *and* discards what was there; there is no partial write and no separate erase, which is why exploration costs maintained information |

## Comparison

| | PBWM | LSTM | SRN | DNC ([[wiki/entities/differentiable-neural-computer.md]]) |
|---|---|---|---|---|
| Gate | Learned, per stripe, discrete | Learned, per cell, continuous | None (copy every step) | Learned write head |
| Credit for gating | RL from an associative critic; no BPTT | Backpropagation through time | BPTT, one step | BPTT |
| Store contents | Learned PFC representations | Cell state | Copy of hidden layer | Explicit memory matrix |
| Exploration | Required (`Random Go`) | Not applicable | Not applicable | Not applicable |
| Cost model | ~20,000 independent slots claimed feasible | Compute grows as a power of 2 per memory-cell unit → few cells | — | Memory scales independently of controller |

**(brainstorm)** The SRN-as-gated-network observation in the discussion is the transferable frame: any recurrent net that settles over multiple cycles per input *already* has a gate, applied by fiat every step. PBWM is what you get by taking that implicit gate and giving it three degrees of freedom — make it dynamic (skip steps), make the context learned rather than a copy, and make it plural (many stripes, gated independently). The same three moves apply to a transformer's key/value cache, where the write is currently also by fiat, every token, into one shared store ([[wiki/entities/tem-transformer.md]]).

---

## Connections

- **[[wiki/concepts/working-memory.md]]** — supplies the missing controller for the wiki's fast store: the gate that every other design fixes by construction (`τ_f`, a similarity threshold, an SRN's copy-every-step) is here a policy learned by reinforcement, with the ablation number that shows the store is worthless without it.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — a delayed-credit solution that is not an approximation of backpropagation at all: the temporal gap is closed once, by an associative critic evaluating *internal states* at reward time, and the structural gap by multiplying the global neuromodulator by the acting unit's own activation.
- **[[wiki/concepts/compositionality.md]]** — dynamic gating gives variable binding by routing: which slot an item enters is set by a control input rather than by the item, which is what makes generalization to unseen sequences possible — and the paper's own limit (stripes must learn their fillers, decoders must learn their stripes) is the exact distance left to symbolic variables.
- **[[wiki/concepts/attention.md]]** — the gate and the attentional read are the same selection operation on opposite sides of the store: attention chooses what to read out by content, Go/NoGo chooses what is allowed in, and only the latter has to be trained against delayed consequences.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the write rule is licensed rather than local: a stripe's weights change only in proportion to its own gating action times a broadcast dopamine scalar, which is the selective-write property gap G19 asks for, bought by needing an external reward.
- **[[wiki/concepts/meta-learning.md]]** — the same two-loop shape with the levels swapped: here the slow loop learns a *gating policy* and the fast loop is activity in PFC stripes, so the "inner learner in recurrent activity" is given an explicit, trainable write-enable instead of being left implicit in the dynamics.
- **[[wiki/concepts/amortized-inference.md]]** — supplies the wiki's dopamine-as-reward-prediction-error framing that this page contests: PVLV reproduces the same firing record with associations only, and argues the prediction chain breaks precisely on tasks whose stimulus sequence is unpredictable.
- **[[wiki/entities/tem-transformer.md]]** — the counterpart store discipline: there the write policy is a conditional (store a conjunction only if not already present) evaluated on content, here it is a learned action evaluated on consequences, and neither system can erase without also writing.
- **[[wiki/entities/adaptive-cann.md]]** — the same maintain/update conflict resolved in continuous rather than discrete form: there the exchange rate between holding and moving is a single adaptation gain with a closed-form threshold, here it is a binary gate whose *timing* is what gets learned.
- **[[wiki/entities/context-modular-memory-network.md]]** — control that carries no content, as here: a handful of control bits select which attractors are retrievable, while PBWM's control bits select which stripes may be overwritten.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the engineering counterpart of this page's gate, with the credit problem solved the other way: write, allocation and free gates all trained by backpropagation through time against task loss, and — unlike a Go, which writes and discards in one act — a separate erase vector and a free list that reclaims read locations.
- **[[wiki/entities/stsp-working-memory-rnn.md]]** — the write-policy pole opposite this page: maintenance by synaptic decay with no gate at all, which reproduces the *decay* of prefrontal delay decoding that this page's bistable stripes would not, and so prices what a learned gate assumes — that the item stays decodable while it is held.
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — the behaviour this architecture is the model of, with its biology filled in: prefrontal cells that code the cue→action pairing rather than either endpoint are the stripe contents, and the striatal signal that fires immediately after the cue on novel-but-not-familiar mappings is a recorded candidate for the Go this page learns (Wise & Murray 2000). It also supplies the biological version of the stripe count and the typing this page lacks: each cortical area sits in a large number of parallel cortex→basal ganglia→thalamus loops, and *which* area is in the loop fixes the level of abstraction — premotor modules hold exemplars, prefrontal modules hold the rules and strategies over them, a distinction PBWM's homogeneous stripes do not make (Murray et al. 2000).
- **[[wiki/concepts/cognitive-control.md]]** — the rival account of how a controller acts, on the same anatomy: PBWM gates *what enters* a stripe and control is exercised by admission, where the Miller & Cohen model never gates anything — the controller adds sustained excitatory bias to systems that keep running their own dynamics and their mutual inhibition decides. The two predict different lesion signatures downstream, and the bias account additionally explains the controller's own withdrawal, since repeated biasing strengthens the direct pathway until the behaviour is automatic.
