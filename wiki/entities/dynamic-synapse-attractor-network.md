# Dynamic-Synapse Attractor Network

**A rate-model attractor network whose recurrent excitation runs through Tsodyks–Markram facilitating/depressing synapses. The synapse kinetics set how the network *enters* its persistent state: facilitation gives a slow, reversible approach that needs a minimum input duration, depression gives an immediate population spike. With both kinds of subpopulation inside one stimulus-selective population, the input's duration, not only which neurons it targets, decides which attractor is entered.** Barak & Tsodyks 2007, *PLoS Comput. Biol.* 3(2):e35 (`raw/barak-2007-persistent-activity-in-neural-networks-with-dynamic-synapses.md`).

> **Provenance.** Theory paper: mean-field analysis plus simulation. No new data; the synapse classes come from Wang et al. 2006 (prefrontal interpyramidal connections: facilitating, depressing, intermediate `τ_f ≈ τ_r`). The source renders every equation and both parameter tables as images. The equations below are the standard Tsodyks–Markram rate form the text describes term by term. Critical values are given only where the prose states them. Table 2's numbers are not recoverable.

This is **not** the synaptic theory of working memory (Mongillo, Barak & Tsodyks 2008). Here the memory *is* persistent spiking, and short-term plasticity (STP) shapes how the store is written. It gives no activity-silent carrier.

---

## Architecture

| Component | Specification |
|---|---|
| Single subpopulation | `τ dh/dt = −h + J·u·x·R + I(t)`; `R = [h]₊` (threshold-linear; qualitative results checked against other nonlinearities) |
| Facilitation | `du/dt = (U − u)/t_f + U(1 − u)R` |
| Depression | `dx/dt = (1 − x)/t_r − u·x·R` |
| Parameters | `J` absolute efficacy, `U` baseline utilisation (≈ release probability), `t_f` facilitation decay, `t_r` depression recovery; `τ` a few ms ≪ `t_f`, `t_r` |
| Full network | `P` populations (one per stored stimulus, sparse and non-overlapping), each split into `Q` subpopulations with homogeneous synapse kinetics. Coupling is three-tier: within subpopulation `J`, within population `f·J`, across populations `g·J`. Each population has its own inhibitory pool |
| Simulated instance | `P = 10`, `Q = 2` (one facilitating, set A; one depressing, set C; `J = 4.5`), `f = 0.1`, `g = 0.01`, `J_Iα = (0.5, 0.4)`, `J_αI = (0.3, 0.7)`: the depressing subpopulation gets the stronger inhibition, which keeps it at rest despite suprathreshold input |
| Assumed origin of the structure | Hebbian learning strengthens within-population links. Neurons with similar synapse kinetics fire with similar time courses, so they wire more strongly to each other. The three tiers are assumed, not learned in the model |

---

## Key results

### Regimes of one subpopulation, over `(J, t_f/t_r)`

| Quantity | Value | Meaning |
|---|---|---|
| Facilitation threshold | `t_f/t_r > U/(1 − U)` | `ux` rises with `R` before depression takes over. `JuxR` is then convex at low `R`, which is what allows a low-activity state to coexist with the persistent one |
| `J_low` | `1/(ux)_p`, with `(ux)_p` the peak steady-state `ux` | Minimum efficacy for a persistent state (the condition is `Jux = 1` at `I = 0`) |
| `J_high` | `1/U` | Above this, the spontaneous state vanishes: no bistability |
| Depressing case | `ux` monotone decreasing ⇒ `J_low = J_high = 1/U` | Persistent activity only at `J > 1/U`, and bistability only for `I < 0` (rest = silence) |
| `J*` | Found numerically (backward integration of the separatrix); lower bound `1/u*` | Above `J*`, the trajectory to the persistent state crosses the "forbidden line" `Jux = 1` ⇒ a **delayed** population spike |
| `J_stab` | `≥ J_low`; equals `J_low` if the persistent state's `u > u*` | Between `J_low` and `J_stab`, the persistent state is unstable ⇒ periodic population spikes ("bursting") |
| Stable at inception (`I = 0`) | `t_f/t_r > (t_f/t_r)₁`, which for small `U` reduces to **`t_f > t_r`** | One of the three prefrontal synapse classes satisfies it |

| Regime | Condition | Response to a transient input |
|---|---|---|
| Depressing | `t_f/t_r` below the facilitation threshold | Persistent only at `J > J_high`; **instant population spike** even for a very short input |
| Intermediate, bursting | facilitating, `J_low < J < J_stab` | Periodic population spikes |
| Intermediate, delayed spike | facilitating, `J > J*` | Delayed population spike, then persistence; strong transient oscillations |
| Facilitating, smooth | `t_f/t_r > (t_f/t_r)₁` | Persistent state stable on arrival, reached **gradually, with no population spike** |
| Transient only | `J < J_low` | No persistence |

### The mechanism: timescale separation

- **Fast** (`x, u` frozen at `1, U`): `τ dR/dt = −R + JUR + I`. At `J < 1/U`, `R` settles to a quasi-steady state and the slow variables carry the rest. At `J > 1/U`, `R` has no fixed point ⇒ runaway ⇒ population spike, ended by depression.
- **Slow** (2-D in `x, u`, with `R = I/(1 − Jux)` valid only while `Jux < 1`): input reshapes the nullclines so that only the high fixed point remains. **Remove the input before the trajectory crosses the separatrix and the network returns to rest; leave it on past the crossing and the network continues to the persistent state.** This is the minimum-duration requirement. Figure 2 shows it with 200 ms vs 700 ms pulses.
- **Stated rule:** a population spike needs depression (it terminates the rate explosion); duration sensitivity needs facilitation (it supplies the long timescale).

### Two subpopulations, one population

| Input to population 1 (same amplitude) | Depressing subpopulation | Facilitating subpopulation |
|---|---|---|
| Short pulse | Enters its persistent state | Stays at baseline: too little time to build up |
| Long pulse | Transient rise, then **suppressed** | Ramps to its persistent state and inhibits the depressing one |

Cross-inhibition keeps untargeted populations quiet. **The two outcomes are mutually exclusive attractors selected by input duration at a fixed target set.** The activity profiles resemble lateral intraparietal delay cells (Zhang & Barash 2004): fast rise then slow decay, and slow ramping. The paper states that the simulations were not fitted to those cells.

---

## What it gives a reasoning model

| Claim | Consequence |
|---|---|
| **The write rule is in the synapses, even when the store is in activity** | Write rule = minimum-duration threshold (facilitating) or immediate commit (depressing). It comes from kinetic constants, not from a gate or a controller ([[wiki/concepts/working-memory.md]]) |
| **Sub-threshold approach is reversible** | A facilitating store *integrates toward* commitment and forgets partial progress if the input stops early. Short glitches are rejected with no dedicated filter |
| **An attractor can be addressed by a temporal feature of its input** | The attractor-network default is that *which* neurons the input targets decides *which* attractor wins. Here, the input's temporal profile is a second addressing dimension on the same neurons ([[wiki/concepts/attractor-dynamics.md]]) |
| **Facilitation lowers the connection strength persistence needs** | `J_low < 1/U` only if `t_f/t_r > U/(1 − U)`. Persistence becomes reachable at weaker weights, and bistability survives a positive background input |
| **Heterogeneous delay-cell profiles have a structural reading** | Transient, ramping and mixed prefrontal/parietal delay responses are read as embedded subpopulations with different synapse types, not noise ([[wiki/concepts/neuronal-parameter-heterogeneity.md]]) |

**(brainstorm)** For a machine store: give each slot a leaky accumulator `a ← a + dt·(drive − a/t_f)` and commit only when `a` crosses a threshold. Slots with different time constants then compete for the same input, so how long a cue lasts decides which one wins. It costs one scalar per slot. No key–value memory in the wiki makes admission depend on how long evidence persists.

---

## Limitations

- **Mean-field only.** Fluctuations are ignored, and whether the regimes survive a balanced excitation–inhibition regime is left open by the authors ([[wiki/concepts/excitation-inhibition-balance.md]]).
- **The three-tier connectivity is assumed.** Its Hebbian origin is argued in the introduction and never simulated.
- **Homogeneous kinetics within a subpopulation** is what makes the rate reduction possible. Within-subpopulation spread is not treated.
- **Stability and `J*` are partly numerical.** `J_stab` is derived for small positive input in the 2-D reduction. `J*` has only an analytic lower bound.
- **The duration code is shown for one pulse amplitude and two durations.** No capacity or resolution for duration (how many durations are separable) is derived. Frequency coding is proposed, not shown.
- **No task, no learning, no behaviour.** The testable prediction is for a delayed-saccade task whose response depends on the cue's duration. The paper names it and does not run it.
- **Population-spike prediction.** Multi-electrode recordings should show transient synchrony at the transition into delay activity. The paper cites motor-cortex synchrony (Riehle et al. 1997) as consistent; no working-memory test is reported.

---

## Comparison

| Model | Where the item lives during the delay | Role of STP | What selects the attractor |
|---|---|---|---|
| **This model** | Persistent spiking | Shapes **entry**: duration threshold vs population spike; lowers `J_low` | Target neurons **and** input duration |
| [[wiki/entities/stp-flickering-cann.md]] | Synaptic rebound (`t_f > t_r`) in the abandoned map; activity carries none of it | Is the memory | `input × gain`, with gain set by recent history |
| [[wiki/entities/stsp-working-memory-rnn.md]] | Mostly synaptic state (trained); spiking falls to chance | Trained carrier | Learned |
| Mongillo et al. 2008 (not in wiki) | Facilitated synapses between silent periods; population spikes refresh them | The carrier | Target neurons |
| [[wiki/entities/pbwm.md]] | Bistable prefrontal stripes | None | Learned basal-ganglia gate |
| [[wiki/entities/adaptive-cann.md]] | Bump on a continuum | Slow negative feedback (adaptation, not facilitation) pushes the state *away* | Input location plus adaptation gain |

---

## Connections

- **[[wiki/concepts/synaptic-plasticity.md]]** — adds the regime boundaries to that page's short-term-plasticity row: the facilitation threshold `t_f/t_r > U/(1 − U)`, `J_high = 1/U`, and `t_f > t_r` for a persistent state that is stable on arrival. The same `u·x` factor that stores a gain bias there sets the entry dynamics of a spiking attractor here.
- **[[wiki/concepts/working-memory.md]]** — a hybrid of that page's two carriers: the item is held in activity, but whether and how it gets written is set by synaptic kinetics. Duration is the admission criterion, and no controller is involved.
- **[[wiki/concepts/attractor-dynamics.md]]** — a selection variable that page's axes do not have: with two synapse types sharing one input, the input's duration picks which of two mutually exclusive attractors wins, at a fixed target set.
- **[[wiki/entities/stp-flickering-cann.md]]** — same synapse model, opposite use. There, a `t_f > t_r` rebound holds a map after activity has gone. Here, facilitation builds up toward a persistent spiking state and depression ends a population spike, so STP is on the write path, not the storage path.
- **[[wiki/entities/stsp-working-memory-rnn.md]]** — the persistent-activity arm of that page's comparison, with STP added rather than substituted. The fixed-synapse networks there hold the item in activity with no kinetic write rule; this model shows what adding presynaptic kinetics to such a network changes before any training.
- **[[wiki/concepts/ignition.md]]** — the same entry into a self-sustained state, with synapse kinetics deciding its shape. A depressing population commits explosively, as ignition's threshold-crossing cascade does. A facilitating one approaches slowly and reversibly, so its threshold is on input duration rather than input strength.
- **[[wiki/concepts/neuronal-parameter-heterogeneity.md]]** — heterogeneity placed in the synapses, not the neurons. Per-subpopulation `(U, t_f, t_r)` makes one stimulus-selective population respond differently to different input time courses, which is offered as the source of variable delay-cell profiles.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — the regime this analysis does not cover. The authors leave open whether a balanced network with dynamic synapses keeps the duration threshold and the population spike.
- **[[wiki/entities/adaptive-cann.md]]** — the opposite-sign history term on a persistent state. Adaptation destabilises an occupied state; facilitation stabilises a state as it is being entered. A circuit with both would have a write threshold and a release timer from two slow variables.
