# Evidence Accumulation and the Decision Threshold

**A choice among `N` alternatives is made by integrating noisy per-alternative evidence over time and committing when the *posterior* over hypotheses — not the accumulated evidence itself — crosses a threshold; the difference between those two stopping rules is the difference between an optimal decision and a slow one.**

> **Provenance.** Bogacz & Gurney 2007, *The basal ganglia and cortex implement optimal decision making between alternative actions*, Neural Computation 19:442–477 (`raw/bogacz-2007-basal-ganglia-optimal-decisions.md`). An analytic mapping of the multihypothesis sequential probability ratio test (MSPRT) onto cortico–basal-ganglia anatomy, plus simulations at a fixed 1% error rate and refits of published subthalamic and pallidal firing-rate data.

The wiki has had *when to start* deliberating ([[wiki/concepts/simulation-based-planning.md]], gap G15) and *which controller to trust* ([[wiki/concepts/amortized-inference.md]], T135). This page is the third question those two presuppose: given that deliberation is running, **when is the answer good enough to act on** — and it is the one question here with a closed-form optimal answer.

---

## The algorithm

Evidence for alternative `i` at time `t` is `x_i(t)`, drawn i.i.d. `N(μ⁺, σ)` for the correct alternative and `N(μ⁻, σ)` for the rest, `μ⁺ > μ⁻`. Cortex integrates and scales:

```
Y_i(T) = Σ_{t=1..T} x_i(t)                     # accumulated evidence
y_i(T) = g* · Y_i(T)                           # "salience"; g* = (μ⁺ − μ⁻)/σ²
L_i(T) = ln P(H_i | input(T)) = y_i(T) − S(T)
S(T)   = ln Σ_j exp( y_j(T) )                  # the response-conflict / normalising term
```

**Act as soon as any `L_i(T)` exceeds a fixed threshold.** So `L` is a log-softmax over saliences: the decision variable is a normalised log-posterior, and `S(T)` is its denominator. `S(T)` is identical across channels and grows when *many* alternatives are well supported, so it raises the salience every alternative must reach — response conflict is not a separate monitor, it is the normaliser.

| Rule | Decision variable | Optimality | Decision time, `N` = 10 at 1% error |
|---|---|---|---|
| **Race** (Vickers 1970) | `Y_i` alone — no denominator | None | 676 ms |
| **Diffusion / SPRT** (Stone 1960; Ratcliff 1978) | `Y_1 − Y_2` | Exactly optimal, but **only for `N` = 2** | — |
| **Usher & McClelland 2001** | Leaky accumulators with lateral inhibition | Approximates SPRT at `N` = 2; degenerates toward the race model as `N` grows | 628 ms |
| **MSPRT** (Baum & Veeravalli 1994) | `y_i − ln Σ_j e^{y_j}` | Asymptotically optimal (minimal decision time at fixed error, as error → 0) for any `N` | **607 ms** (545 ms at tuned `g`, `a`) |

MSPRT wins at every `N` tested (2–20) and the margin grows with `N`. Its decision time is ≈ proportional to `ln N`, which is **Hick's law** falling out of the decision rule rather than being fitted to it.

---

## The anatomical mapping, and why it is a strong claim

| Term | Structure | Required transfer function |
|---|---|---|
| `y_i(T)` — salience | Cortical integrators (frontal eye field, lateral intraparietal area) projecting to striatum and subthalamic nucleus | Linear integration × gain `g` |
| `− y_i(T)` — inhibitory copy | D₁ striatal projection neurons → output nuclei (**direct pathway**) | Sign inversion; cortex is glutamatergic, so the negative term *has* to be re-supplied by a GABAergic relay |
| `exp(·)` | Subthalamic nucleus | `STN_i = exp( y_i − GP_i )` — firing rate **exponential** in input |
| `ln(·)` | External pallidum, closing a loop on the diffuse subthalamic sum `Σ` | `GP_i = Σ − ln Σ` — approximately **linear** for large `Σ` |
| `Σ_j` | Diffuse subthalamic → output-nucleus projection | Summation over channels by anatomy alone |
| `L_i` → action | Output nuclei (`OUT_i = −L_i`), tonically active | Commit when an output *falls* below threshold — i.e. **disinhibition is the threshold crossing** |

Two things make this more than a re-description. `L_i ≤ 0` always, so it cannot be a firing rate; taking `OUT_i = −L_i` forces the decision to be a *decrease*, which is what basal-ganglia output nuclei actually do. And the transfer functions were derived from the algorithm, not fitted: the exponential subthalamic `f–I` curve is unusual, contradicts the piecewise-linear (Gurney et al. 2001) and sigmoid (Frank 2005) assumptions of rival models, and holds up against pooled published data (Hallworth et al. 2003; Wilson et al. 2004), while the near-linear pallidal relation matches Nambu & Llinás 1994 and Kita & Kitai 1991. See [[wiki/empirical-tensions.md]] T137.

The indirect (D₂ → pallidum) pathway and the pallidum → output projection are **excluded from the core model** and shown in an appendix not to break it. On this account the selection computation needs one inhibitory copy, one exponentiator and one log-compressor — and the `NoGo` channel is doing something else entirely (T132).

---

## The one free parameter, and why it does not matter

`g* = (μ⁺ − μ⁻)/σ²` is an **inverse-variance gain**: the optimal cortical gain is the precision of the evidence ([[wiki/concepts/precision-weighting.md]]). It is task-specific and therefore unknowable to the circuit. The robustness result is that this is survivable:

- `g > g*` — decision time does **not** increase at all.
- `g < g*` — decision time increases, but provably never exceeds the Usher–McClelland model's.

**Therefore: set the gain as high as possible.** A one-sided penalty is a rare and valuable property — the wiki's other precision-like parameters ([[wiki/concepts/neuromodulatory-metaparameters.md]]) are all two-sided, so they need estimation; this one needs only saturation. Linearising the pallidum (`GP_i = a·Σ`) is likewise cheap: default `a` = 1, `g` = `g*` gives 607 ms, still better than both rivals.

**Upstream competition is free.** If the cortical stage is replaced by a full Usher–McClelland network with its own lateral inhibition, output-nucleus activity is *provably unchanged* and decision time is identical. So a normalising stage downstream makes competition upstream harmless — cheap pre-filtering of low-salience requests costs nothing in optimality, which licenses a two-stage selector.

---

## Reading in the core framing

| Element | Latent-graph reading |
|---|---|
| `x_i(t)` | Per-edge evidence arriving over time from a noisy observation channel |
| `y_i(T)` | The score of candidate edge `i`, precision-weighted |
| `S(T)` | The partition function of the score vector — computed by a *separate recurrent subcircuit*, not for free |
| Threshold on `L_i` | The commitment rule: traverse the edge once the posterior over which edge is correct is confident enough |
| `μ⁺ − μ⁻`, `σ` | The environment's own discriminability — what a curriculum controls (gap G32) |

**(brainstorm) The importable result is that the softmax denominator costs a nucleus.** In `softmax(qKᵀ)V` the normaliser is a free arithmetic side-effect, computed in one pass and immediately discarded. Here it is the fixed point of a recurrent loop between two populations, it is the *only* nonlinearity in the circuit, and it is separately addressable — which buys three things a transformer cannot express: (i) the normaliser can be modulated on its own, so "raise the bar for everything" is one input rather than a change to every score; (ii) it is iterative, so partial normalisation is a legitimate intermediate state and the decision variable is well-defined at every instant rather than only after a full pass; (iii) cost is `O(N)` exponentials plus one shared scalar, with no pairwise comparisons — the same complexity as a race model, for asymptotic optimality.

**(brainstorm) The stopping rule generalises past perceptual choice, and that is the untested claim.** Nothing in the derivation is specific to sensory evidence: `y_i` is any accumulating score over enumerated alternatives, so the same rule should stop a rollout over `N` candidate plans, or a search over `N` candidate rules on an [[wiki/entities/arc-agi.md]] grid, at the moment the posterior over candidates is confident enough. What blocks this is not the rule but the enumeration — see below.

---

## Open problems

- **The alternatives must be enumerated and localist.** Each `L_i` is one channel. The source concedes the problem directly ("is moving one's hand 10 cm a different action from 15 cm?") and the only evidence offered is that fine parameters appear to be coded *within* a channel by opposed-sign populations (Georgopoulos et al. 1983). A distributed-representation mapping exists for linear SPRT networks (Bogacz 2006) and **does not extend to MSPRT**, because the subthalamic exponential is nonlinear. This is the gap between an optimal chooser and an agent that must first *construct* its options (gap G33).
- **The threshold itself is unmodelled.** MSPRT fixes the error rate and derives the time; nothing here sets the error rate. Tonic dopamine is the proposed knob for the speed–accuracy trade-off (Gurney et al. 2004; reaction-time effects in Amalric & Koob 1987), and whether it can move the threshold while *preserving* optimality is explicitly left open. A whole-brain simulation supplies the alternative the accumulator literature does not: in a frontoparietal winner-take-all circuit the trade is moved by **lowering input amplitude and raising the common-mode correlation of the inputs to the competing parietal populations**, with the threshold and the recurrent weights fixed — accuracy up, integration time up, no boundary touched ([[wiki/concepts/excitation-inhibition-balance.md]], Schirner et al. 2023). Whether an optimality claim survives that route is untested.
- **Learning is out of scope by construction.** The mapping describes the *proficient* phase only, with the stimulus–response map already in the cortical weights. Where evidence is integrated during learning is known to be somewhere else — in the version of the motion task where the mapping is not yet known, integration does not occur in the frontal eye field (Gold & Shadlen 2003).
- **The prior is uniform.** `P(H_i) = 1/N` is assumed so the priors cancel. A non-uniform prior would add a per-channel constant — trivially, an offset on the striatal relay — but nothing measures whether that is what expected-reward modulation of the integrators (Platt & Glimcher 1999) is doing.
- **Optimality is asymptotic.** MSPRT minimises decision time at fixed error only as the error rate → 0; the 1% simulations are the evidence that it holds at usable error rates, and there is no guarantee at high error rates or under unequal evidence variances.

---

## Connections

- **[[wiki/entities/basal-ganglia.md]]** — the substrate this page's algorithm is claimed to be: cortical integrators supply the salience, the D₁ direct pathway supplies its inhibitory copy, and the subthalamic–pallidal loop computes `ln Σ_j exp(y_j)` by way of an exponential and a log transfer function, so the tonically inhibited output nucleus holds `−L_i` and selection *is* the threshold crossing downward.
- **[[wiki/concepts/priority-map.md]]** — the normative correction to that page's `argmax`: the arbitration stage should not take the maximum of the raw similarity scores but threshold their log-softmax, and the denominator is computed by a physically distinct subcircuit — so the two-stage split measured there (score in ventral prearcuate, arbitrate in the frontal eye field) is missing a *third* stage that both pages' `softmax` writes as free.
- **[[wiki/concepts/precision-weighting.md]]** — the optimal cortical gain is exactly an inverse-variance weighting, `g* = (μ⁺−μ⁻)/σ²`, which puts a precision term on the *evidence* rather than on a prediction error, and adds a property none of that page's precisions has: the penalty for miscalibration is one-sided, so the correct policy is to saturate the gain rather than estimate it.
- **[[wiki/concepts/simulation-based-planning.md]]** — supplies gap G15's *when is the answer good enough* half in closed form for the case where the alternatives are already enumerated: threshold the posterior over candidates, not the score of the leader. It does not touch *how deep* or *which branch*, and its enumeration requirement is exactly what a planner over open-ended action sequences does not have.
- **[[wiki/concepts/amortized-inference.md]]** — the same commit/keep-going decision one level up: that page arbitrates *which controller* to believe by comparing posterior variances, this one decides *when either controller has heard enough*, and both make the stopping criterion a quantity the estimator already maintains rather than a tuned threshold.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — adds a metaparameter that page does not list and locates it: the decision threshold sets the speed–accuracy trade-off, tonic (not phasic) dopamine is the proposed carrier, and unlike the discount factor or the exploration temperature its companion parameter `g` has a provably one-sided cost — so only one of the two needs regulating.
- **[[wiki/concepts/attention.md]]** — the resource-free reading of competition: nothing here is capacity-limited, and the "bottleneck" is entirely the time needed for the posterior to reach threshold, which grows only as `ln N` — so an apparent capacity limit can be produced by a stopping rule with no capacity in it.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the commitment step of traversal: given noisy per-edge evidence, the optimal moment to move is when the normalised posterior over which edge is correct crosses threshold, which makes the graph's *discriminability* (`(μ⁺−μ⁻)/σ`) the quantity that sets how expensive navigation is.
- **[[wiki/concepts/subjective-value.md]]** — what the accumulated evidence is made of in an economic choice: a subjective value with the agent's own discount kernel already applied, which makes this page's discriminability term `(μ⁺−μ⁻)/σ` a function of the discount rate — a steep discounter faces an easier discrimination on the same objective pair, and so should commit faster without any change in threshold.
- **[[wiki/entities/autotom.md]]** — a measured counterexample to monotone evidence in a scaffolded reasoner: recruiting context backwards from the present only while the answer stays uncertain beats using every available timestep by 4.5 points at half the tokens (82.43 vs 77.92; on one benchmark 8.0K vs 44.5K tokens for +6.8 points), so *more* observations made the posterior worse.
- **[[wiki/concepts/mean-field-reduction.md]]** — the spiking-network instance of the same decision, with two results no threshold-on-the-accumulator formulation states: the discriminating populations' firing rate carries only `sign(f2−f1)` and `|f2−f1|`, so **Weber's law lives in the probability of reaching a rate rather than in the rate**; and it is reproduced only when the *spontaneous* state is stable alongside the two answers, making an explicit "undecided" attractor load-bearing rather than a failure mode (Deco et al. 2008).
- **[[wiki/concepts/integration-segregation-balance.md]]** — where the diffusion parameters come from physiologically: network integration raises drift rate `v` and shortens non-decision time `t` with *no* effect on the boundary `a`, so global network state sets evidence signal-to-noise rather than the stopping rule — and this page's conflict term `S(T)` is an internal signal already available for setting that state.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — the non-threshold route to this page's unmodelled speed–accuracy knob: in a frontoparietal winner-take-all circuit, lowering the input amplitude and raising the *common-mode* correlation of the inputs to the two parietal populations both raise accuracy and lengthen integration time, with the recurrent weights and the commitment threshold untouched — so the trade can be bought by changing the statistics of the drive rather than the stopping rule, and the correlation term works at the parietal stage only (Schirner et al. 2023).
- **[[wiki/concepts/ignition.md]]** — an answer to this page's unmodelled threshold: in macaque V1/V4/dlPFC the signal-detection criterion *is* the prefrontal ignition point, sensitivity `d′` is propagation efficiency along the sensory chain, and bias is the pre-stimulus distance from threshold — all three measurable before the stimulus, and false alarms are literally spontaneous supra-threshold cascades (van Vugt et al. 2018).
- **[[wiki/concepts/loopy-belief-propagation.md]]** — a third candidate stopping rule, and the only one that is not a tuned constant: stop when the messages stop changing, which makes the number of steps a function of input ambiguity and gives ambiguous inputs longer latencies for free.
