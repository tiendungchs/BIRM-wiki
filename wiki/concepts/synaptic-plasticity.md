# Synaptic Plasticity

**A weight update computed from quantities available *at the synapse* — pre-synaptic activity, post-synaptic activity, and at most one broadcast modulatory signal — with no error propagated backwards through the network.**

This is the brain's actual write mechanism. Where [[wiki/concepts/biologically-plausible-credit-assignment.md]] asks whether backpropagation can be *approximated* locally, this page covers the rules that were never trying to approximate it: they are dynamical equations on the weights, and what they compute is whatever their fixed points encode. For the wiki's target they are the candidate write rule for fast **M** — the only family that can modify a network *during deployment*, at the timescale a reasoning agent meets a new instance-graph (Schmidgall et al. 2023).

---

## The biological substrate

| Mechanism | Timescale | Computational content |
|---|---|---|
| **Short-term plasticity** | tens of ms → minutes | Adaptation to sensory statistics; short-lasting memory formation. A transient, automatically-decaying store — fast **M** with a built-in forget gate |
| **Long-term plasticity** (long-term potentiation / depression) | minutes → longer | Long-term behavioural change and memory storage; the substrate slow **W** would be written into |
| **Neuromodulation** | ms → long | Chemical broadcast (acetylcholine, dopamine, serotonin) altering circuit excitability *and* synaptic strength. Supplies the third factor: a global scalar the local rule multiplies against |
| **Metaplasticity** | — | "Plasticity of plasticity": changes the *ability* of a synapse to change, by shifting the physiological state of the neuron or synapse. Protects the network from its own saturation |
| **Neurogenesis** | developmental, and adult (subventricular zone, amygdala, dentate gyrus) | Capacity added rather than reallocated; rate is environment-sensitive (enrichment, exercise, stress in rodents). Role in learning not established |
| **Glial modulation** | — | Astrocytes release, reuptake and metabolize neurotransmitters, regulating availability; structural changes in synaptic strength require glial involvement. Not represented in any learning rule below |

**The timescale objection.** Long-term potentiation is routinely cited as the biological warrant for Hebbian learning, and Gallistel & Matzel 2013 argue the cognitive significance of that warrant is unclear on three counts (reported in Lake et al. 2017): (i) LTP's critical interstimulus interval is *orders of magnitude smaller* than the intervals that matter behaviourally, and experiments varying interstimulus and intertrial intervals together show **no critical interval exists**; (ii) behaviour persists for weeks or months while LTP decays to baseline in days (Power et al. 1997); (iii) learned behaviour is rapidly reacquired after extinction (Bouton 2004) with no corresponding facilitation in LTP (de Jonge & Racine 1985). Their conclusion — that it would be "especially challenging" to implement structured model building with purely Hebbian mechanisms — is logged as [[wiki/empirical-tensions.md]] T13. It does not touch the rules below as *engineering*; it removes the biological argument for preferring them.

**Metaplasticity is the important one for this wiki.** It is elastic weight consolidation's biological ancestor stated as a *mechanism* rather than as a penalty term — the gate on writability is intrinsic to the synapse and stateful, not computed by an outer loop from a Fisher matrix ([[wiki/concepts/continual-learning.md]]). It is distinguishable from neuromodulation, though the two overlap in time at a modified synapse.

---

## The rule family, in order of what each fixes

**1. Hebbian.** Strengthen coactive pairs:

```
Δw_ij = η · x_i · x_j
```

Unsupervised; identifies structure in the input with no feedback. Stores large binary patterns in a fully-connected recurrent net (Hopfield). **Unstable by construction:** a weak positive correlation raises `w_ij`, which reinforces the correlation, which raises `w_ij` again. Needs bounding, or a rule tracking pre/post history or the activity of other neurons.

**2. Spike-timing-dependent plasticity (STDP).** Replace coactivity with *order*:

```
Δw_ij =  A₊ · exp(−Δt/τ₊)   if Δt > 0   (pre before post → potentiate)
        −A₋ · exp( Δt/τ₋)   if Δt < 0   (post before pre → depress)
```

Observed in neocortex, hippocampus and cerebellum. The sign flip at `Δt = 0` is what makes it *causal* rather than correlational — the asymmetry is a cheap directional-edge detector, which is exactly the primitive latent graph discovery needs and Hebb's correlational form cannot supply **(brainstorm)**.

**3. Naive three-factor (reward-modulated Hebbian) — and why it fails.**

```
Δw_ij = η · x_i · x_j · R          ✗
```

Broken: if `w_ij` is already optimal, the rule still produces a net change and drives it away from the optimum. To track the actual covariance between inputs, outputs and rewards, **at least one term in the product must be zero-mean** (Frémaux et al., cited). Subtracting a reward baseline (`R − E[R]`) helps but is generally insufficient.

**4. Node perturbation — the fix that works.** Center the *output* instead, by perturbing activations with zero-mean noise `Δx_j` and using the perturbation in the product:

```
Δw_ij = η · x_i · Δx_j · R
```

The `x_i·Δx_j` increment pushes future `x_j` responses toward the perturbation; multiplying by `R` pushes toward it when reward was positive and away when negative. Net drift is up-reward *even when `R` is not zero-mean* (at higher variance). This rule implements REINFORCE and estimates the true gradient of `R` with respect to `w_ij`, biologically plausibly, and lets recurrent networks learn non-trivial cognitive and motor tasks **from sparse, delayed rewards**.

**5. Eligibility traces — the bridge across time.** Keep a per-synapse trace of which synapses contributed to recent activity; a dopamine-like signal arriving later converts the trace into an actual weight change. This is the mechanism that makes a *retroactive* third factor possible, and it is what e-prop and neuromodulated differentiable plasticity are both built on ([[wiki/concepts/meta-optimized-plasticity.md]]).

---

## Why this matters for a reasoning model

| Property | Consequence for the architecture |
|---|---|
| **Deployment-time weight change** | Backpropagation-trained networks cannot learn after training; the data they assume is i.i.d. and timeless, which physical reality is not (information is temporally and spatially correlated). Plasticity is the only family here that writes during the episode — the literal implementation of binding an instance-graph |
| **Locality** | Errors in fast **M** never propagate through slow **W**; the two levels stay decoupled, which is the property the `p = f(g, x)` factorization wants anyway (gap G1) |
| **Delayed sparse reward is reachable** | Node perturbation + eligibility traces learn from a reward arriving long after the responsible activity — the credit structure a multi-hop traversal actually has |
| **The rule is a hyperparameter** | `η`, `A₊`, `τ₊` are hand-set. This is the opening that [[wiki/concepts/meta-optimized-plasticity.md]] exploits: make them differentiable and the *rule* becomes learnable |
| **Metaplasticity is stateful gating** | A continual-learning mechanism that needs no task boundaries, unlike elastic weight consolidation — the synapse's own history sets its writability |

**(brainstorm)** The four rules above form a ladder where each rung buys one missing ingredient: order (STDP), reward (three-factor), an unbiased estimator (node perturbation), time (eligibility traces). Nothing on the ladder buys *structure* — no rule here has any notion of a node identity or a path. That is the shape of the gap: plasticity supplies a write mechanism for fast **M** and says nothing about what **M** should hold.

---

## Does a non-gradient rule learn anything?

Richards et al. 2019 answer with a decomposition. Take a plasticity rule as a **vector field over weight space**; any vector field splits into a component along `∇_W F` and components orthogonal to it.

| Alignment with `∇_W F` | Trajectory | Verdict |
|---|---|---|
| Full | Direct ascent to the optimum | Learning |
| Partial | Indirect ascent — still arrives | Learning |
| Orthogonal | Never approaches the optimum | **Change, not learning** |

So the standing worry that Hebbian-family rules approximate no gradient is not disqualifying: a rule needs only a **positive projection** onto some objective's gradient. The price is a demand this page must now meet for each rule it lists — **name the quantity that improves**. If no metric gets better, the phenotypic change is not learning by any usable definition, which is also the wiki's sharpest statement of what gap G19 (no local rule is selective about what it writes) actually costs: an unselective rule may be writing orthogonally.

---

## Open problems

- **No rule on this page is selective about *what* it writes.** Hebbian-family updates fire on any coactivity, including coactivity produced by a shortcut feature ([[wiki/concepts/shortcut-learning.md]]). A local rule cannot tell a causal edge from a correlational one — it is by construction a correlation detector.
- **Stabilization is unsolved in general**, only patched (bounding, normalization, history terms). The instability is intrinsic to the positive feedback.
- **Glial modulation and neurogenesis appear in no learning rule.** If astrocytes are required for structural synaptic change in biology, every rule here is modelling an incomplete mechanism.
- **What does metaplasticity compute?** It is described as protecting against saturation; no computational account states what objective its state machine is optimizing.
- **The behavioural timescales do not line up.** If LTP has no critical interstimulus interval, decays in days where behaviour persists for months, and shows no reacquisition-after-extinction effect, then the mechanism cited as the biological warrant for the whole family is not obviously the mechanism behind behavioural learning (T13). No rule here is stated at a timescale that would fix this.
- **Sparse-reward credit still needs an exploration policy.** Node perturbation is unbiased but its variance grows with network size; nothing says where the perturbations should be injected.

---

## Connections

- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — the same locality constraint approached from the other end: that page asks how much of backpropagation survives locality, this one covers the rules that never approximated it and are dynamical systems in their own right.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — takes the hand-set coefficients of these rules (`η`, `A₊`, `τ₊`) as the parameters of an outer loop, converting a fixed rule into a discovered one.
- **[[wiki/concepts/continual-learning.md]]** — metaplasticity is the biological mechanism elastic weight consolidation reimplements as a loss penalty; the mechanism version needs no task boundaries.
- **[[wiki/concepts/complementary-learning-systems.md]]** — short- and long-term plasticity are the synaptic-level version of the fast/slow split that CLS states at the systems level; the timescale separation is present in a single synapse before any second anatomical system is invoked.
- **[[wiki/entities/spiking-neural-networks.md]]** — STDP is defined on spike times, so it presupposes a spiking substrate; the rules on this page are what a spiking network is optimized *by* when gradients are unavailable.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies a write rule for fast **M** that operates during the episode, but no notion of node identity or path, so it can bind an instance-graph's weights without representing its structure.
- **[[wiki/concepts/shortcut-learning.md]]** — a purely local correlation detector has no lever by which to prefer a causal edge, so plasticity rules inherit the shortcut problem rather than solving it.
- **[[wiki/concepts/universal-induction.md]]** — the ideal these rules approximate under locality and compute budgets: Bayesian conditioning of a universal mixture needs no update rule at all, so every local rule is a bounded stand-in for it.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — supplies an error-driven local write rule where this page's rules are coactivity-driven, and makes the precision gates `α, β, γ` a metaplasticity-like control over how much the fast level writes (Butz 2016).
- **[[wiki/concepts/three-component-framework.md]]** — rehabilitates non-gradient rules by the vector-field decomposition (only a rule *orthogonal* to `∇F` fails to learn), while imposing the counter-demand that every rule name the objective it improves, or be classed as change rather than learning.
- **[[wiki/concepts/pattern-separation-completion.md]]** — where this page's neurogenesis row acquires a demonstrated function: ablating adult dentate neurogenesis impairs discrimination only at *low* sample-target separation, so added capacity is spent specifically on pushing similar inputs apart (Yassa & Stark 2011).
