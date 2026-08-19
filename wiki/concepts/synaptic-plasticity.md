# Synaptic Plasticity

**A weight update computed from quantities available *at the synapse* — pre-synaptic activity, post-synaptic activity, and at most one broadcast modulatory signal — with no error propagated backwards through the network.**

This is the brain's actual write mechanism. Where [[wiki/concepts/biologically-plausible-credit-assignment.md]] asks whether backpropagation can be *approximated* locally, this page covers the rules that were never trying to approximate it: they are dynamical equations on the weights, and what they compute is whatever their fixed points encode. For the wiki's target they are the candidate write rule for fast **M** — the only family that can modify a network *during deployment*, at the timescale a reasoning agent meets a new instance-graph (Schmidgall et al. 2023).

---

## The biological substrate

| Mechanism | Timescale | Computational content |
|---|---|---|
| **Short-term plasticity** | tens of ms → minutes | Adaptation to sensory statistics; short-lasting memory formation. A transient, automatically-decaying store — fast **M** with a built-in forget gate. Not a learning rule: it has no fixed point to converge to, and what it modulates is *gain*, not content (see below) |
| **Long-term plasticity** (long-term potentiation / depression) | minutes → longer | Long-term behavioural change and memory storage; the substrate slow **W** would be written into |
| **Neuromodulation** | ms → long | Chemical broadcast (acetylcholine, dopamine, serotonin) altering circuit excitability *and* synaptic strength. Supplies the third factor: a global scalar the local rule multiplies against |
| **Metaplasticity** | — | "Plasticity of plasticity": changes the *ability* of a synapse to change, by shifting the physiological state of the neuron or synapse. Protects the network from its own saturation |
| **Neurogenesis** | developmental, and adult (subventricular zone, amygdala, dentate gyrus) | Capacity added rather than reallocated; rate is environment-sensitive (enrichment, exercise, stress in rodents). Role in learning not established |
| **Glial modulation** | — | Astrocytes release, reuptake and metabolize neurotransmitters, regulating availability; structural changes in synaptic strength require glial involvement. Not represented in any learning rule below |
| **Behavioral timescale synaptic plasticity** (BTSP) | **seconds** | A dendritic plateau potential potentiates *every* input active in a ~seconds-wide window around it. One event, one new receptive field — single-shot learning at the timescale behaviour actually runs at (Bittner et al. 2017; Liao & Losonczy 2024) |
| **Inhibitory (GABAergic) plasticity** | minutes → longer | Long-term potentiation and depression at inhibitory synapses, with a symmetric spike-timing rule reported in auditory cortex (D'amour & Froemke 2015). Candidate mechanism for a *learned suppression mask* — see [[wiki/concepts/offline-replay.md]] |

**The weight distribution any rule must reproduce is log-normal.** Measured CA3 recurrent EPSPs are heavy-tailed — median 0.66 mV [IQR 0.33–1.08], Gaussian in log amplitude — as in every other cortical region measured (Sammons et al. 2023). Most synapses are near-negligible and a small minority dominates the dynamics, which changes what a write *costs*: a ten-step sequence can be embedded by pushing **<1%** of synapses to the 99th percentile of the existing distribution, leaving the histogram essentially unchanged ([[wiki/concepts/offline-replay.md]]). A learning rule with additive Gaussian noise and a hard weight ceiling — the default in nearly every machine implementation of the rules below — produces the wrong distribution, and therefore the wrong signal-to-noise ratio between stored items and background **(brainstorm)**.

**The timescale objection.** Long-term potentiation is routinely cited as the biological warrant for Hebbian learning, and Gallistel & Matzel 2013 argue the cognitive significance of that warrant is unclear on three counts (reported in Lake et al. 2017): (i) LTP's critical interstimulus interval is *orders of magnitude smaller* than the intervals that matter behaviourally, and experiments varying interstimulus and intertrial intervals together show **no critical interval exists**; (ii) behaviour persists for weeks or months while LTP decays to baseline in days (Power et al. 1997); (iii) learned behaviour is rapidly reacquired after extinction (Bouton 2004) with no corresponding facilitation in LTP (de Jonge & Racine 1985). Their conclusion — that it would be "especially challenging" to implement structured model building with purely Hebbian mechanisms — is logged as [[wiki/empirical-tensions.md]] T13. It does not touch the rules below as *engineering*; it removes the biological argument for preferring them.

**BTSP is the direct answer to objection (i).** The critical-interval complaint is that Hebbian plasticity's window is orders of magnitude shorter than behaviourally relevant intervals. Behavioral timescale synaptic plasticity has a window of **seconds**, set by an eligibility trace rather than by spike coincidence, and it produces a reproducible place field from a single traversal (Bittner et al. 2017; Liao & Losonczy 2024). So the family is no longer forced to explain behaviour with a 20 ms kernel: rule 6 below runs at the behavioural timescale by construction. Objections (ii) persistence and (iii) reacquisition-after-extinction are untouched.

**Short-term plasticity is the one row here that is a dynamical system rather than a rule.** The Tsodyks–Markram form — release probability `u` facilitating with presynaptic rate and recovering with `τ_f`, resources `x` depleting and recovering with `τ_r`, efficacy `u·x` — has no target and no fixed point that encodes anything:

```
du/dt = (U − u)/τ_f + U(1 − u)·m ,   dx/dt = (1 − x)/τ_r − u·x·m ,   efficacy = u·x
```

When `τ_f > τ_r` (e.g. 1.9 s vs 0.6 s in CA3), efficacy **overshoots after the presynaptic drive stops** — resources refill before facilitation decays — so a population that has just been active carries a transient *gain advantage* with no activity and no weight learning. Mark et al. 2017 make that rebound the whole memory: it is enough to reactivate an abandoned hippocampal map for seconds after its sensory support is gone ([[wiki/entities/stp-flickering-cann.md]]). Three consequences for the rules below: the substrate they write on has a fast state variable of its own; a "weight" is therefore `W · u · x`, only one factor of which is learned; and rebound amplitude is non-monotonic in `U`, so the same rule on the same weights behaves differently under neuromodulators that shift release probability.

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

**The kernel's symmetry selects which error-driven rule the synapse implements** (Whittington & Bogacz 2019). Asymmetric STDP as written above computes a *derivative*: if the postsynaptic rate is rising, more post spikes land in the potentiating window than in the depressing one, so `ΔW ∝ ẋ_post · x_pre` — which is exactly the update the continuous-update approximation of backpropagation requires (Bengio et al. 2017). The **symmetric** form — near-coincident spikes potentiate regardless of order, plus a small depression per presynaptic spike (Vogels et al. 2011) — computes a *level* relative to a baseline `x₀`, which is the update predictive coding requires at equilibrium. So one substrate covers both error-representation schemes of [[wiki/concepts/biologically-plausible-credit-assignment.md]], and which one it covers is set by the window shape, not by the network. Note this is the *second* independent result on this page where kernel symmetry changes what is computed rather than how fast — rule 7's `β` selects successor vs. reversible transition structure (Keck et al. 2025).

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

**6. Behavioral timescale synaptic plasticity (BTSP) — the single-shot rule.** A three-factor rule whose third factor is a **dendritic plateau potential** and whose eligibility window is seconds wide:

```
Δw_i = η · e_i(t) · P(t) ,   e_i(t) = ∫ K(t − s) · x_i(s) ds ,   K spanning ≈ ±2–4 s
```

`P(t)` is the instructive plateau, evoked by endogenous input — entorhinal cortex is the proposed source (Grienberger & Magee 2022) — or by optogenetic stimulation (Rolotti et al. 2022a). Every input whose trace `e_i` is non-zero when the plateau arrives is potentiated, so the cell acquires a whole receptive field in one event. Established in CA1 (Bittner et al. 2017), extended to CA3 (Li et al. 2023), more strongly expressed in **novel** environments (Priestley et al. 2022), and the plasticity kernel has been measured in vivo at synaptic resolution (Gonzalez et al. 2023).

| Property | Why it makes single-shot learning work |
|---|---|
| **Integration over seconds** | Averages over many noisy spikes, so one large weight change is driven by a reliable signal rather than by a coincidence |
| **Many synapses potentiated at once** | Robustness by the law of large numbers: even if some potentiated synapses are spuriously associated with the field, it is very unlikely that enough are to flip the output |
| **Population-driven, not pairwise** | Computationally it is the supervised fitting of a **binary classifier by one cell**, over a rich dendritic input basis, rather than a correlation detector (Milstein et al. 2021) |
| **Gated by an instructive signal** | The cell writes only when a plateau arrives — the first rule on this page whose writes are *licensed* rather than automatic |

**The dendritic basis is load-bearing.** Distinct dendrites of one CA1 pyramidal cell carry heterogeneous, partly decorrelated tuning; soma–dendrite coupling varies with brain state, so dendrites can act semi-independently (Rolotti et al. 2022b; O'Hare et al. 2022). Read functionally: **the dendrites are a high-dimensional random-feature basis and BTSP chooses a weighting on it.** A place field is then a readout direction, and "which field" is "which weights", which is why place-cell-like tuning also appears for sound frequency, faces, conspecifics and stimulus×choice conjunctions — the rule is not spatial, the basis is whatever the cell receives. The implication the review draws is strong: a tuned hippocampal cell may just be a **memory cell**, place coding a byproduct of compressing inputs under a sparsity penalty (Benna & Fusi 2021).

**7. Predictive/decorrelative rule with a symmetry dial — the rule whose fixed point is a named object.** Subtract the synapse's own predicted input from the post-synaptic activity, and run the same term on the time-reversed pair with weight `β`:

```
ΔW = α (p_post(t+1) − W p_pre(t)) p_pre(t)ᵀ  +  β (p_post(t) − W p_pre(t+1)) p_pre(t+1)ᵀ
```

The single-term version (`β = 0`) has `E[ΔW | p_pre] = 0` exactly when `W p_pre = E[p_post | p_pre]`, so the rule is a regression onto the *next* activity — which is why its fixed point is a successor representation rather than a correlation matrix. The `β` term is the same regression run backwards, and at convergence the network stores the SR of `P_{α,β} = (αP_forward + βP_backward)/(α+β)`: asymmetric → successor, symmetric → time-reversible (policy-insensitive) map, `β`-only → predecessor representation (Keck et al. 2025; see [[wiki/concepts/successor-representation.md]] for the functional consequences). Stability requires `|α| > |β|`; `α = −β` diverges.

**Why this rule matters here.** It is the wiki's clearest case of the demand made in the vector-field section below being *met*: the quantity that improves is named, and the coefficient controlling the shape of the plasticity kernel maps onto a defined change in the represented transition structure. The rule is also robust to the biological messiness the page's other rules assume away — heterogeneous per-synapse `α, β` drawn at random, and per-timestep noise on them, leave the behaviour qualitatively unchanged, so a symmetry *bias* rather than exact symmetry is sufficient. Empirically CA3 recurrent synapses show a temporally symmetric potentiation window while CA1 Schaffer-collateral synapses show classical asymmetric STDP, which under this rule assigns the two subfields different representations of the same experience.

### The two rules divide the graph between them

| | BTSP | STDP |
|---|---|---|
| Learns | **Nodes** — a new discrete concept / receptive field | **Edges** — ordered pairwise transitions between existing concepts |
| Shots | One | Many |
| Window | Seconds | Tens of ms (needs theta compression to see behavioural pairs — [[wiki/concepts/offline-replay.md]]) |
| Weight change per event | Large | Small |
| Fails at | Order *within* the window is indiscriminable; sequences longer than the biophysical window are unlearnable | Single events; each pairing is dominated by noise |
| Why the failure is a feature | Discrete concepts have no internal order to preserve | Most observed pairings are spurious; requiring many exposures *is* the spuriousness filter |

**Speed–amplitude trade-off (the review's unifying proposal):** the magnitude of the weight change in a plasticity event is proportional to the **expected information gained** in that event. BTSP integrates seconds of population activity → large change → one shot. STDP integrates one spike pair → small change → many shots. This is one principle generating both rules from their integration windows, and it is directly implementable: make a learning rate a function of the evidence integrated by the update.

**And this pair is expressive enough for the wiki's whole target.** A system that can encode concepts *and* the pairwise sequential relationships between them can in principle represent **any graph** (Liao & Losonczy 2024) — which is [[wiki/concepts/latent-graph-discovery.md]] reached from the synapse rather than from the task. The caveat the review adds is the one the wiki tracks as G27: unlike graph learning in the machine setting, **the concepts themselves are also learned, from a continuous input stream.**

**The distinction is not clean.** Place fields are also gradually refined and stabilised by Hebbian plasticity (Mehta et al. 1997), and BTSP may participate in that refinement too — a higher BTSP rate is associated with a more stable code (Vaidya et al. 2023; Madar et al. 2023). Read the table as two ends of a continuum indexed by integration window, not as two systems.

---

## Why this matters for a reasoning model

| Property | Consequence for the architecture |
|---|---|
| **Deployment-time weight change** | Backpropagation-trained networks cannot learn after training; the data they assume is i.i.d. and timeless, which physical reality is not (information is temporally and spatially correlated). Plasticity is the only family here that writes during the episode — the literal implementation of binding an instance-graph |
| **Locality** | Errors in fast **M** never propagate through slow **W**; the two levels stay decoupled, which is the property the `p = f(g, x)` factorization wants anyway (gap G1) |
| **Delayed sparse reward is reachable** | Node perturbation + eligibility traces learn from a reward arriving long after the responsible activity — the credit structure a multi-hop traversal actually has |
| **The rule is a hyperparameter** | `η`, `A₊`, `τ₊` are hand-set. This is the opening that [[wiki/concepts/meta-optimized-plasticity.md]] exploits: make them differentiable and the *rule* becomes learnable |
| **Metaplasticity is stateful gating** | A continual-learning mechanism that needs no task boundaries, unlike elastic weight consolidation — the synapse's own history sets its writability |
| **Single-shot writes are licensed, not automatic** | BTSP writes only when an instructive plateau arrives, so *when to allocate a new unit* is a separate signal carried on a separate anatomical pathway (entorhinal → CA1 distal dendrites). That is the allocate-vs-reuse decision of [[wiki/concepts/pattern-separation-completion.md]] implemented as a gate, and it is what gap G19 was asking for |
| **Learning rate scales with evidence integrated** | The speed–amplitude trade-off is a one-line change to any optimizer: weight the step by how much independent evidence the update averaged over, and single-shot and incremental learning become two operating points of one rule rather than two mechanisms |

**(brainstorm)** The rules above form a ladder where each rung buys one missing ingredient: order (STDP), reward (three-factor), an unbiased estimator (node perturbation), time (eligibility traces), and — with rule 6 — **a node**. BTSP is the first rule on this page with a claim on structure: one event creates one reusable discrete unit, and STDP then links the units. What is still missing is *identity across contexts*: neither rule says whether the field created in environment A is the same node as a field created in environment B, so the pair can build a graph per environment and cannot say two graphs share a shape. Plasticity now supplies the instance-graph write mechanism ([[wiki/concepts/latent-graph-discovery.md]]) and still says nothing about the meta-graph.

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
- **Where does the instructive signal come from?** BTSP's whole selectivity rests on the plateau, and what generates a plateau at the right moment is unknown — entorhinal cortex is a proposal (Grienberger & Magee 2022), not a result. A single-shot rule with an unexplained teacher has relocated the credit-assignment problem, not solved it.
- **The molecular substrate of the seconds-long eligibility trace is unidentified.** αCaMKII is the leading candidate (Xiao et al. 2023). Until it is pinned down, the seconds-wide kernel is a fitted phenomenology, and its shape — which sets what counts as "one event" — is not derived from anything.
- **Does plasticity run offline?** Whether weights change within hippocampus during rest is unstudied, though SWR-paired spiking potentiates in vitro and disrupting awake ripples impairs learning with online representations intact ([[wiki/concepts/offline-replay.md]]).
- **Inhibitory plasticity has no agreed rule.** Reports are variously potentiating, depressing and rate-dependent; models both require it (Liao et al. 2022) and reproduce replay phenomena without it (Ecker et al. 2022; Nicola & Clopath 2017).

---

## Connections

- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — states a requirement most Hebbian accounts omit: heterosynaptic LTD is *necessary* alongside LTP for efficient associative storage, and doubles as the forgetting mechanism that keeps a capacity-limited store from overloading; also names non-associative mossy-fibre plasticity as a signal-to-noise device favouring consistently-firing inputs.

- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — the same locality constraint approached from the other end: that page asks how much of backpropagation survives locality, this one covers the rules that never approximated it and are dynamical systems in their own right. The bridge is the STDP window: its asymmetric form implements a rate-of-change rule and its symmetric form an activity-level rule, which are precisely the two error-representation classes that page splits on.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — takes the hand-set coefficients of these rules (`η`, `A₊`, `τ₊`) as the parameters of an outer loop, converting a fixed rule into a discovered one.
- **[[wiki/concepts/continual-learning.md]]** — metaplasticity is the biological mechanism elastic weight consolidation reimplements as a loss penalty; the mechanism version needs no task boundaries.
- **[[wiki/concepts/complementary-learning-systems.md]]** — short- and long-term plasticity are the synaptic-level version of the fast/slow split that CLS states at the systems level; the timescale separation is present in a single synapse before any second anatomical system is invoked.
- **[[wiki/entities/spiking-tem.md]]** — STDP used as the *memory write of a generative model* rather than as a plasticity demonstration, and shown to be necessary for something upstream of memory: removing it drops entorhinal grid emergence from 59.6% to 10.1%, so the structural code cannot form until the associative store works.
- **[[wiki/entities/spiking-neural-networks.md]]** — STDP is defined on spike times, so it presupposes a spiking substrate; the rules on this page are what a spiking network is optimized *by* when gradients are unavailable.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies a write rule for fast **M** that operates during the episode; with BTSP for nodes and STDP for edges the pair is expressive enough to build *any* instance-graph, and still has no notion of node identity *across* graphs, so the meta-level stays unwritten.
- **[[wiki/concepts/shortcut-learning.md]]** — a purely local correlation detector has no lever by which to prefer a causal edge, so plasticity rules inherit the shortcut problem rather than solving it.
- **[[wiki/concepts/universal-induction.md]]** — the ideal these rules approximate under locality and compute budgets: Bayesian conditioning of a universal mixture needs no update rule at all, so every local rule is a bounded stand-in for it.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — supplies an error-driven local write rule where this page's rules are coactivity-driven, and makes the precision gates `α, β, γ` a metaplasticity-like control over how much the fast level writes (Butz 2016).
- **[[wiki/concepts/three-component-framework.md]]** — rehabilitates non-gradient rules by the vector-field decomposition (only a rule *orthogonal* to `∇F` fails to learn), while imposing the counter-demand that every rule name the objective it improves, or be classed as change rather than learning.
- **[[wiki/concepts/offline-replay.md]]** — supplies the temporal re-clocking these rules need (a theta cycle compresses a seconds-long trajectory into one STDP window) and the arena where the inhibitory and offline plasticity rows would do their work.
- **[[wiki/concepts/complementary-learning-systems.md]]** — BTSP is the synapse-level mechanism of the "fast, one exposure" column: a single plateau writes a new unit, which is what one-shot encoding means at the level of a rule.
- **[[wiki/concepts/pattern-separation-completion.md]]** — where this page's neurogenesis row acquires a demonstrated function: ablating adult dentate neurogenesis impairs discrimination only at *low* sample-target separation, so added capacity is spent specifically on pushing similar inputs apart (Yassa & Stark 2011).
- **[[wiki/concepts/successor-representation.md]]** — what rule 7's fixed point computes: the temporal symmetry of the plasticity kernel selects whether the stored matrix is the successor, the predecessor, or the policy-insensitive reversible map, so a plasticity coefficient becomes a representational design choice (Keck et al. 2025).
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the rival route to flexibility: remapping by rewriting excitatory weights versus remapping by re-mixing inhibitory gains, the second fast, reversible and weight-free. Plasticity re-enters one level up — short-term depression at the place-cell→*Pvalb* synapse and potentiation at the place-cell→*Sst* (OLM) synapse are what write the within-field schedule that hands excitatory control from entorhinal to CA3 input mid-traversal.
- **[[wiki/entities/sparse-distributed-memory.md]]** — the outer-product rule engineered rather than described: saturating up–down counters (bounded weights whose overflow discards the oldest evidence), a fixed non-learning addressing layer that is what keeps one-shot writes from interfering, and an error-gated variant (CMAC's `g(p̂_u − s_u)/K`, applied only when the retrieval error is too large) that is a write-selectivity rule of the kind G19 says no local rule has.
- **[[wiki/entities/stp-flickering-cann.md]]** — the short-term-plasticity row run as the *only* memory in a network: a `τ_f > τ_r` rebound gives the just-abandoned attractor a gain advantage that outlives its sensory support, which is a memory with no fixed point, no content and no write decision — the opposite end of the family from BTSP.
- **[[wiki/entities/dense-sequence-memory.md]]** — the payoff and the ceiling of the temporally asymmetric rule: STDP writes exactly `J_ij ∝ Σ_μ ξ_i^{μ+1} ξ_j^μ`, and what that stores is a sequence only `O(N)` steps long unless a nonlinearity is applied to the overlap downstream — so the storable sequence length is set outside the plasticity rule entirely.
- **[[wiki/entities/adaptive-cann.md]]** — a case where the computational role is pinned down and the synaptic implementation is explicitly left open: the dynamics require only a slow negative feedback proportional to recent activity, which spike-frequency adaptation (intrinsic) and short-term depression (synaptic) both supply, so nothing in the behaviour distinguishes them.
- **[[wiki/entities/context-modular-memory-network.md]]** — the strongest challenge in the wiki to weights-as-memory: a symmetric Gaussian random matrix carrying no pattern information stores arbitrary chosen patterns as stable attractors once the right per-context binary mask is applied, so learning could sit in a sign-agreement gate rather than in weight change — and bounded or binary synapses then suffice ([[wiki/empirical-tensions.md]] T59).
- **[[wiki/entities/hopfield-network.md]]** — the Hebbian rule taken literally and applied once: an outer-product write that is local and correlation-based yet installs a *global* structure (an energy landscape), which is the clearest demonstration in the wiki that local plasticity can specify a network-level computation.
- **[[wiki/entities/boltzmann-machine.md]]** — Hebbian and anti-Hebbian terms inside one rule, with the sign decided by whether the network is currently driven by the world or by itself: the clearest case in the wiki that a rule's *phase context* carries as much information as its pre/post product.
- **[[wiki/concepts/dendritic-computation.md]]** — this page's "the dendrites are a high-dimensional random-feature basis" made the primary object: each segment is an independent `θ`-of-`s` coincidence detector with a measured threshold of 8–20 synapses within 20–300 µm and 1–5 ms, so the plateau that licenses a BTSP write is itself a pattern detection, and clustered plasticity is the rule that chooses which `s` synapses a segment samples.
