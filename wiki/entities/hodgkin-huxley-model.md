# Hodgkin–Huxley Model

**The neuron as a leaky capacitor whose leaks are voltage-controlled: four coupled ODEs — one for membrane voltage, three for gating variables — from which the action potential emerges with no supervisor deciding when a channel opens.**

This is the level *below* the leaky integrate-and-fire unit of [[wiki/entities/spiking-neural-networks.md]]: LIF is this model with the gating variables deleted and the spike re-inserted by hand as a threshold rule. The wiki's stake is [[wiki/empirical-tensions.md]] T1 — what, if anything, the implementation level contributes — and the two transferable items here are **conductance-based (multiplicative, reversal-bounded) input** and **per-unit hidden state that inactivates**, neither of which any rate unit in the wiki has.

> **Provenance.** `raw/talk-nd-hodgkin-huxley-model.txt` — explainer talk, no date. Textbook content (Hodgkin & Huxley 1952, Nobel 1963); claims sourced only to the talk are marked `(tentative)`.

---

## The equations

| Object | Form | Reading |
|---|---|---|
| Membrane as capacitor | `Q = C·V` → `C dV/dt = dQ/dt = −Σᵢ Iᵢ` | Voltage moves only as charge crosses the membrane |
| Ionic current (Ohm) | `Iᵢ = gᵢ·(V − Eᵢ)` | `(V − Eᵢ)` is the **driving force**; `Eᵢ` the equilibrium potential |
| Conductance factorization | `gᵢ = ḡᵢ · p(V,t)` | `ḡᵢ` fixed (channel count × single-channel conductance); `p ∈ [0,1]` the open fraction |
| Gate kinetics | `dx/dt = α(V)(1−x) − β(V)x` | Two-state Markov gate; `α, β` fitted empirically (linear × exponential forms) |
| Potassium | `I_K = ḡ_K n⁴ (V − E_K)` | 4 identical gates, all must be permissive |
| Sodium | `I_Na = ḡ_Na m³h (V − E_Na)` | 3 activation gates `m` (open on depolarization) × 1 **inactivation** gate `h` (closes on sustained depolarization) |
| Leak | `I_L = g_L (V − E_L)` | Constant conductance; always-open channels |

**Equilibrium potential.** Set where diffusion (concentration gradient) exactly cancels the electrical force. K⁺ is ~30× more concentrated inside → `E_K ≈ −90 mV`; at `V > E_K` K⁺ leaves and repolarizes, at `V < E_K` it enters. The ion's current is a *restoring force toward its own `Eᵢ`*, so a neuron's resting state is a conductance-weighted compromise between the reversal potentials of whatever is open.

**The mechanism of the spike, with no controller.** Depolarization past threshold opens `m` (fast) → Na⁺ influx → more depolarization (positive feedback) → `h` closes (slow) and `n` opens (slow) → K⁺ efflux repolarizes. The sequencing is entirely a **timescale separation between gates driven by the same variable** — `m` fast, `h` and `n` slow — not a schedule.

---

## The n⁴ prediction

The exponent 4 came from curve-fitting conductance data in 1952, when potassium-channel structure was unknown. X-ray crystallography decades later found the channel is a tetramer of four identical subunits. A dynamical exponent predicted a molecular stoichiometry.

This is the second instance in the wiki of a phenomenological fit naming a biophysical constant in advance — the other is `θ ≈ 9–20` for the dendritic NMDA threshold ([[wiki/concepts/dendritic-computation.md]]). Both are the strongest evidence form available to [[wiki/concepts/neuroscience-ai-transfer.md]]: the abstraction was not merely consistent with the biology, it constrained it.

---

## Spatial extension

The four equations are the **point neuron** (isopotential) case. Real morphology is handled by compartmentalizing: apply the same equations per segment and add axial coupling currents between neighbours, giving a coupled system whose per-compartment voltage differs. This is the formal ground for [[wiki/concepts/dendritic-computation.md]] — a dendritic segment can have its own local voltage, its own channel complement, and therefore its own nonlinearity, purely because the cable does not equalize fast enough.

---

## Limitations

| Limit | Consequence |
|---|---|
| 4-D state space | No phase-plane visualization; excitability is simulable but not *seeable*. Motivates the 2-variable reductions (FitzHugh–Nagumo, Morris–Lecar) that trade the ion identities for geometric intuition `(tentative — the talk defers these to a sequel)` |
| `α(V), β(V)` are fits | No closed-form derivation from protein physics; the molecular mechanism of gating charge movement is stated as not fully resolved |
| Two ion species + leak | Squid axon. Ca²⁺, A-type K⁺, h-current, and adaptation currents — the ones that set firing patterns in cortical cells — are absent |
| Deterministic | Channel noise (finite channel counts, stochastic gating) is averaged away |
| Cost | Numerically stiff; ~4 ODEs per compartment × ~10² compartments per cell makes network-scale simulation expensive, which is why every network model in the wiki uses a reduced unit |

---

## Comparison

| | HH unit | LIF unit ([[wiki/entities/spiking-neural-networks.md]]) | Rate unit (ANN) |
|---|---|---|---|
| State per unit | `V, m, h, n` (4) | `V` (1) | none |
| Spike | Emergent from the dynamics | Imposed threshold + reset rule | None |
| Input effect | **Multiplicative**: a conductance change, scaled by `(V − E)` | Additive injected current | Additive weighted sum |
| Saturation | Intrinsic — current → 0 as `V → E`, no input can push past `E_Na` | Absent | Absent (needs an explicit nonlinearity) |
| Refractoriness / adaptation | Emergent from `h` and `n` kinetics | Hard-coded refractory period | Absent |
| Cost | ~4 ODEs | 1 ODE | 1 multiply–accumulate |

---

## Consequences for a builder

**Conductance-based input is gating, not summation.** `I = g(V − E)` means a synapse's effect on the cell depends on the cell's own state and is *bounded by* `E`. Inhibitory synapses with `E ≈ V_rest` contribute almost no current but a large `g` — pure **shunting**: they divide the effect of everything else without subtracting anything. This is the biophysical origin of divisive normalization, which [[wiki/concepts/inhibitory-control-of-coding.md]] and [[wiki/entities/adaptive-cann.md]] both use as an abstracted scalar `k`. The abstraction is not arbitrary; it is what a reversal potential at rest *does*.

**(brainstorm) `h` is the missing per-unit state variable.** Sodium inactivation is a slow, input-driven, self-resetting hidden variable inside the unit: it records "this unit has been active recently" on a ~ms–10 ms timescale and gates the unit off regardless of drive. Every fast-adaptation mechanism the wiki reaches for at the *network* level — the adaptation variable that destabilizes a bump in [[wiki/entities/adaptive-cann.md]], the short-term depression that drives map-flickering in [[wiki/entities/stp-flickering-cann.md]] — is the same functional object implemented one level up. HH says the primitive is available *per unit and per channel type*, before any synapse or population is involved.

**(brainstorm) Powers as coincidence requirements.** `n⁴` and `m³h` say the channel is an AND over independent stochastic gates, so open probability is a *steep* function of the per-gate probability — a nonlinearity built by requiring simultaneity, not by a chosen activation function. This is the same construction as the dendritic segment's `D·A ≥ θ` ([[wiki/concepts/dendritic-computation.md]]) and as the multi-pin lock analogy the talk uses: **conjunction is the cheapest source of sharp nonlinearity in a noisy substrate**, and it is tunable by one integer.

**Where it does *not* help.** Nothing here bears on credit assignment, on representation, or on abstraction. HH is a complete account of how a single unit converts input to output and a complete non-account of what the output means. Its value to this wiki is a catalogue of primitives (multiplicative input, reversal-bounded saturation, inactivation state, conjunction nonlinearity), not an architecture.

---

## Connections

- **[[wiki/entities/spiking-neural-networks.md]]** — the level this model gets reduced to: LIF keeps the capacitor equation and discards `m, h, n`, so every SNN result is downstream of a decision that gating dynamics are not computational — which is exactly the T1 question that page exists to test.
- **[[wiki/concepts/dendritic-computation.md]]** — the compartmental form of these equations is *why* dendrites compute: axial resistance keeps a segment's voltage locally distinct, so the segment can carry its own channels and its own threshold rather than reporting a number to the soma; and both pages share the pattern of a fitted exponent/threshold that later matched measured structure.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — supplies the biophysics behind that page's channel taxonomy: a synapse's *effect type* is set by its reversal potential relative to `V`, so shunting (divisive) and hyperpolarizing (subtractive) inhibition are different operations, and which one an interneuron family performs is a fact about its receptors, not its wiring.
- **[[wiki/entities/adaptive-cann.md]]** — the two abstractions that page takes on faith, derived one level down: divisive normalization `k` is what a rest-reversal conductance does, and the adaptation variable that destabilizes the bump is the network-level analogue of sodium inactivation `h`.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the wiki's cleanest case of a *dynamical* abstraction constraining biology rather than following it (`n⁴` → four subunits), and simultaneously a limit case for transfer: the model is maximally accurate about the substrate and says nothing at Marr levels 1–2.
- **[[wiki/entities/stp-flickering-cann.md]]** — the same self-limiting-activity motif at a different scale: short-term depression makes a network abandon its own attractor the way `h` makes a unit abandon its own spike, both being slow negative feedback driven by the fast variable.
- **[[wiki/concepts/circuit-size-separation.md]]** — a boundary this page's abstraction ladder crosses silently: Maass 1997 proves that spiking neurons with **rectangular** postsynaptic potentials (type A) cannot simulate even a 3-gate threshold circuit on analog input at *any* network size, while **triangular** ones (type B) do it in `O(s)` neurons — so postsynaptic-potential *shape*, usually the first biophysical detail dropped, is a hard computational boundary rather than a modelling convenience.
- **[[wiki/concepts/mean-field-reduction.md]]** — this model in its planar two-variable reduction is the microscopic rung of the coarse-graining ladder, and supplies the ladder's most counter-intuitive result: the three-variable *neural mass* built from these neurons can express chaos and the planar neurons themselves cannot, so dimension reduction **added** dynamical repertoire rather than only removing detail (Deco et al. 2008).
