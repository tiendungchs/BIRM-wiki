# STP Flickering CANN

**A two-map continuous attractor network whose recurrent synapses carry short-term plasticity, so the map the animal has just left keeps a *gain* advantage after its sensory support is gone — and a theta rhythm that periodically collapses global inhibition lets that advantage win a cycle back.** Mark, Romani, Jezek & Tsodyks 2017, *Hippocampus* 27:959–970.

The target phenomenon is Jezek et al. 2011 "teleportation": switch the visual cue set of a familiar environment instantaneously and CA3 switches map almost immediately, but for a few seconds afterwards individual theta cycles are transiently captured by the *old* map (flickering). The model's claim is that flickering is not noise and not a posterior sample — it is the discharge of a **memory held in synaptic state rather than in activity**, which is the only place it can be held, because the correlation between CA3 activity and the old map essentially vanishes between flickers.

---

## Architecture

| Component | Specification |
|---|---|
| Populations | Two maps, each a torus of **2,500 rate units** (linear resolution `2π/50` rad); unit = pool of neurons with overlapping place fields |
| Map assignment | Per-unit binary selectivity `ξ_i^k = 1` with probability `f = 0.25`, drawn independently per map — overlapping, near-orthogonal populations |
| Recurrent weights | `J_ij = Σ_k ξ_i^k ξ_j^k J_1 (cos Δφ^{k,1} + cos Δφ^{k,2}) − J_0` — distance-dependent excitation *within* a map, unstructured global inhibition `J_0` across everything |
| Transfer function | `g(z) = α log(1 + e^{z/α})` — exponential for negative input, linear for large positive; no saturation |
| Dynamics | `τ dm_i/dt = −m_i + g(I_i)`, `I_i = Σ_j J_ij x_j u_j m_j + I_ext^i + I_0`, `τ = 10 ms` |
| **Short-term plasticity** | `du_i/dt = (U − u_i)/τ_f + U(1 − u_i) m_i` ; `dx_i/dt = (1 − x_i)/τ_r − u_i x_i m_i` (Tsodyks–Markram). `U = 0.25`, `τ_r = 0.6 s` (depression recovery), `τ_f = 1.9 s` (facilitation decay) |
| External input | `I_ext = A_θ sin(2π f_θ t) + A_local([cos(φ_i − φ(t))]_+ …)`, `f_θ = 10 Hz`. `A_local` splits into `A_1` (cues that switch on teleportation) and `A_2` (cues that do not — odour, path integration), so the two maps are never fully separated by input |
| Noise (optional) | Colored input noise `τ_N dη/dt = −η + A_n ξ(t)` |

**The two input classes are the load-bearing modelling choice.** Because `A_2` persists across the switch, the competition after teleportation is between a map with slightly more input and a map with more gain — not between a driven map and a silent one. Supplementary result: shrinking the input difference *increases* flicker count.

---

## The mechanism: a synaptic rebound

Single synapse, response to a pulse of presynaptic rate:

1. During the pulse, `u` rises (facilitation) and `x` falls (depression); efficacy `ux` is a compromise.
2. At pulse offset, **`x` recovers faster than `u` relaxes** (`τ_r < τ_f`), so `ux` *overshoots* before settling — the **synaptic rebound**.
3. Rebound amplitude grows with `τ_f/τ_r` and with the firing rate during the pulse, and is **non-monotonic in `U`** (maximal at intermediate baseline release probability).

In the network the rebound is a gain advantage for the just-abandoned map, and the sequence self-sustains:

```
switch cues → new map wins → old map's synapses rebound → old map's gain exceeds its input deficit
   → theta trough collapses global inhibition, resetting the competition → old map wins one cycle (flicker)
   → now the *new* map's synapses rebound → back to the new map → repeat, decaying
```

Each flicker re-arms the other map's rebound, which is why **the transient outlasts every time constant in the system** (`τ = 10 ms`, `τ_r = 0.6 s`, `τ_f = 1.9 s`, yet flickering persists for several seconds). Theta enters twice: high `A_θ` deepens the trough that resets the inhibitory competition, and raises peak rate, which raises the rebound.

**Mixed states appear at the start of a theta cycle and are resolved by its end** — both populations grow together until one wins — matching the experimental observation that mixed representations are a within-cycle transient rather than a stable state.

---

## Predictions and the test

The model predicts flicker count should (i) **increase with theta power** and (ii) **decrease with distance travelled from the switch position** — the second because the facilitated synapses belong to units whose place fields sat at the switch position in the *old* map, so the memory is only expressible while the animal is still near it.

| Prediction | Re-analysis of Jezek et al. 2011 (partial correlation, average firing rate as control) |
|---|---|
| flicker rate ↑ with normalized theta power | `r = 0.44`, `p = 2×10⁻¹⁶` |
| flicker rate ↓ with average distance from switch position | `r = −0.157`, `p = 0.027` |
| — | **Confound:** distance and velocity correlate at `c = 0.64` (`p = 10⁻¹⁷`); their contributions cannot be separated |
| Do the two maps become linked by learning? | **No** — flicker count does not increase across a recording day, so no plasticity is binding the maps together |

**The discriminating control is the no-STP network.** A network without short-term plasticity, driven by noise, also flickers — and its flicker probability is **constant in time with no dependence on teleportation**, contradicting the data. STP is therefore what makes the flicker rate *transient*, and noise only widens the parameter range over which flickers occur at all. This is a rare case in the wiki where a mechanism is isolated by a property of the *time course* rather than by the presence of the phenomenon.

---

## What it contributes

| Claim | Why it matters here |
|---|---|
| **Short-term memory can live entirely in synaptic state** | Activity in CA3 between flickers carries no trace of the old map, yet the old map is recoverable. An activity-silent store with an automatic decay, no gate, and no write decision ([[wiki/concepts/working-memory.md]]) |
| **Gain and input are separable levers on attractor selection** | Which map wins is `input × gain`; STP moves gain only. A retrieval system therefore has two independent knobs, and a *history* term that no purely input-driven selection rule has |
| **A rhythm can be a competition reset** | Global inhibition scales with total activity, so a periodic dip in activity periodically releases the losing attractor. Oscillation as scheduling, not as coding ([[wiki/concepts/inhibitory-control-of-coding.md]]) |
| **Recursive re-arming stretches a transient past its time constants** | The alternation itself regenerates the substrate that drives it — a design pattern for holding an exploratory regime open longer than any decay constant allows **(brainstorm)** |
| **A concrete manipulation** | The model predicts that changing synaptic calcium dynamics (hence `U`, `τ_f/τ_r`) changes flicker statistics, and that morphed (more similar) environments flicker more — both untested |

**(brainstorm) The exportable reading is a soft-reset retrieval policy.** Given a library of stored structures scored by `evidence + gain`, add (a) a per-structure gain term that transiently *rises* after that structure is deselected, and (b) a periodic global threshold dip. The pair produces bounded, self-terminating revisiting of the recently abandoned hypothesis without any explicit exploration schedule, and it costs one extra state variable per stored structure. That is a cheaper implementation of "re-examine the alternative context" than sampling from an explicit posterior, and it makes the revisit rate a function of *recency* rather than of probability — which is the substantive difference from [[wiki/entities/hidden-state-inference-remapping.md]]'s theta-sampling proposal ([[wiki/empirical-tensions.md]] T56).

---

## Comparison

| Account of flickering | Source of the alternation | Predicts a post-switch transient? | Predicts distance dependence? |
|---|---|---|---|
| **This model (STP)** | Synaptic rebound in the abandoned map + theta reset of inhibition | **Yes**, and it decays without any additional timescale | **Yes** — facilitation is spatially localized to the switch position |
| Noise-driven CANN (Stella & Treves 2011; this paper's control) | Fluctuations cross the inhibitory barrier | No — constant rate | No |
| Theta-cycle posterior sampling ([[wiki/entities/hidden-state-inference-remapping.md]]) | One hidden state drawn per cycle at a rate ∝ its probability | Yes, as evidence accumulates the posterior sharpens | No mechanism for it |
| Single-population multi-map network (Monasson & Rosay 2015) | Spontaneous transitions between stored charts | Not addressed | Not addressed |
| Entorhinal-lag account (raised and set aside by the authors) | Grid network does not remap immediately, so the input difference between maps is transiently small | Yes | **No** — and cannot explain a seconds-long window |

---

## Limitations

- **Two maps, both familiar, both pre-wired.** Nothing allocates a map; the `ξ^k` assignment is drawn by the modeller. This is a model of *selection among stored attractors*, with no account of storage, and none of the allocate-vs-reuse machinery of [[wiki/concepts/contextual-inference.md]].
- **The state inside a map is a position on a torus.** Same restriction as every CANN in the wiki: the content of a context is a point in a 2-D continuum, not a graph.
- **STP is asserted for CA3, not measured here.** Cited from slice work (Miles & Wong 1986; Guzman et al. 2016); `τ_f = 1.9 s`, `τ_r = 0.6 s`, `U = 0.25` are chosen, and the paper shows only that the phenomenon is robust over a range, not that the range is the biological one.
- **Distance and velocity are confounded in the only test of prediction (ii)**, so the spatial-locality claim — the part that most sharply separates this account from posterior sampling — rests on a `p = 0.027` partial correlation with an unresolved covariate.
- **Alternative substrates are not excluded.** The authors state that intrinsic adaptation/facilitation would do the same work; the result constrains the memory to be non-activity-based, not to be synaptic.
- **The function of flickering is speculation.** The proposal — that flickering is a "mental exploration" state in which downstream areas get to re-examine alternative contexts, and that neuromodulators or theta amplitude tune how much of it happens — is offered without any test, and nothing measures whether a flicker influences behaviour.

---

## Connections

- **[[wiki/entities/hidden-state-inference-remapping.md]]** — the normative rival for the same data: flickering as one posterior sample per theta cycle versus flickering as a decaying synaptic transient, separated by whether the revisit rate depends on evidence or on recency and travelled distance (T56).
- **[[wiki/concepts/contextual-inference.md]]** — supplies the mechanism layer under that page's retrieval step: expression of a "posterior" as attractor competition where the responsibility weights are `input × gain` and the history term is synaptic rather than Bayesian.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the page's short-term-plasticity row made into a dynamical mechanism: the `τ_f > τ_r` rebound is a memory trace that changes *gain* rather than encoding content, and it is not a learning rule at all — nothing about it converges.
- **[[wiki/concepts/working-memory.md]]** — the activity-silent design: state held in `u, x` while the units are quiescent, with decay built in and no controller, no gate and no write decision.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — uses inhibition in exactly the abstracted form that page argues against (one global scalar), and gets something from it that the abstraction usually hides: because the scalar tracks total activity, a theta trough is a periodic reset of the competition between representations.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the storage theory this model presupposes and does not repeat: how many near-orthogonal charts a diluted CA3 recurrent network can hold, and why the overlapping populations here can be treated as independent maps.
- **[[wiki/concepts/pattern-separation-completion.md]]** — a completion event that fires on the *wrong* pattern by design: the cue that should be doing the completing has switched, and a residual synaptic bias completes to the previous attractor anyway.
- **[[wiki/concepts/offline-replay.md]]** — the same recurrent network re-expressing a representation the current input does not support, at theta timescale and in the awake state, driven by short-term synaptic state rather than by ripple-associated reactivation.
- **[[wiki/concepts/cognitive-map.md]]** — a map switch is not instantaneous or clean: for seconds after the cue change, which map is live is a per-theta-cycle question, and the animal's position relative to the switch point is part of what decides it.
- **[[wiki/entities/adaptive-cann.md]]** — also the rival account of where the theta pacing comes from (T58): here an externally supplied 10 Hz drive whose troughs reset the inhibitory competition, there a limit cycle born from a Hopf bifurcation with no oscillator at all. And the destabilisation mechanism with the opposite sign and a continuum instead of two maps: adaptation follows current activity and pushes the state *away*, short-term plasticity follows past activity and pulls it *back*, so a network carrying both would have a repulsive and an attractive history term at different timescales.
- **[[wiki/entities/context-modular-memory-network.md]]** — the opposite pole on attractor selection: here expression is self-organised, history-dependent and transiently wrong (gain competition plus short-term plasticity); there it is dictated by an external mask and exact, with non-selected maps provably not attractors at all (`κ̄_inacc → 0`).
- **[[wiki/entities/hodgkin-huxley-model.md]]** — the same self-limiting motif one level down: short-term depression makes the network abandon the attractor it is in exactly as sodium inactivation `h` makes a unit abandon the spike it is producing — slow negative feedback driven by the fast variable, at population and at channel scale.
- **[[wiki/concepts/attractor-dynamics.md]]** — the one worked case of a bias over attractors held in synaptic state rather than in the activity, released by a rhythm.
- **[[wiki/entities/stsp-working-memory-rnn.md]]** — the same mechanism arrived at by training rather than by construction: networks free to hold a delay item in either activity or synapses are more like recorded prefrontal cortex when they use the synapses, which turns this page's sufficiency argument into a preference result.
