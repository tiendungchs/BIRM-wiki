# Excitation–Inhibition Balance — One Per-Edge Ratio That Sets Functional Connectivity, Integration Time and Memory Volatility

**Split every long-range projection into the part that lands on the target's excitatory population (`w_ij^LRE`) and the part that lands on its inhibitory population (`w_ij^FFI`), hold the sum fixed, and the *ratio* becomes a single knob that moves the pair's functional connectivity smoothly from full antisynchronisation to full synchronisation — but only if each node is separately running a homeostatic rule that pins its own firing rate. That ratio then propagates downstream: it sets the amplitude and the correlation of the synaptic input a decision circuit receives, and those two quantities jointly decide whether the circuit jumps to a conclusion or integrates, and whether a working memory is easy or hard to overwrite. Speed and accuracy are traded here without any threshold being moved.**

> **Provenance.** Schirner, Deco & Ritter 2023, *Learning how network structure shapes decision-making for bio-inspired computing*, Nature Communications 14:2963, doi:10.1038/s41467-023-38626-y (`raw/schirner-2023-network-structure-decision-making.md`). Behaviour from 1176 Human Connectome Project (HCP) Young Adult participants; 650 personalised 379-node brain network models, each fitted to that individual's resting functional connectivity; a 2-node reduction for the tuning curves; a generic frontoparietal winner-take-all circuit (Wang 2002 family) studied in isolation and then driven by the fitted whole-brain models.

The wiki has had the excitation/inhibition ratio as a *phrase* on five pages and as a *quantity* on none. This page is the quantity: what it is a ratio of, what it controls, what has to be true for it to be controllable, and what it costs to fit.

---

## The parameterisation

Standard dynamical mean-field node (one excitatory `E` and one inhibitory `I` population per region), with the long-range term split in two:

```
I_i^E = W_E I_0 + w_+ J_NMDA S_i^E + J_NMDA Σ_j w_ij^LRE C_ij S_j^E − J_i S_i^I      (1)
I_i^I = W_I I_0 +     J_NMDA S_i^E + J_NMDA Σ_j w_ij^FFI C_ij S_j^E −     S_i^I      (2)
```

| Symbol | Meaning | Status in prior whole-brain models |
|---|---|---|
| `C_ij` | Structural connectome weight (diffusion tractography streamline count) | Same |
| `w_ij^LRE` | **Long-range excitation** — rescales the excitatory→excitatory projection | Implicitly a single scalar, `= 1` for all `i,j` |
| `w_ij^FFI` | **Feedforward inhibition** — rescales the excitatory→*inhibitory* projection | **Absent**: `= 0` for all `i,j`; long-range coupling was excitatory-to-excitatory only |
| `J_i` | Local inhibitory→excitatory feedback strength | Set by Feedback Inhibition Control (below) |
| E/I ratio | `w_ij^LRE / w_ij^FFI`, **long-range only** — local `J_i` deliberately excluded | n/a |

Two things follow from the split that are easy to miss. (i) Adding feedforward inhibition is what makes the coupling *signed*: a purely excitatory long-range term can only raise a target's rate, so a correlation matrix built from it cannot go negative for structural reasons, and anticorrelated resting networks were never reproducible. (ii) The E/I ratio is defined over the long-range terms alone; the ratio of *total* currents arriving at the excitatory population is always balanced, because Feedback Inhibition Control restores it. So "unbalanced E/I" here means an unbalanced *input mixture*, not a runaway node.

---

## The monotonicity result, and its precondition

Sweep the ratio in the 2-node model from 0.01 to 100 under the constraint `w^LRE + w^FFI = 1` (total input held constant):

| Quantity | Behaviour as E/I ratio rises |
|---|---|
| Correlation of simulated BOLD (functional connectivity) | **Monotone**, strong negative → strong positive, i.e. full antisynchronisation → full synchronisation |
| Correlation of simulated synaptic currents | Monotone, negative → positive |
| Amplitude of synaptic currents | **Falls** |

**This holds only when Feedback Inhibition Control (FIC) is active.** FIC is an inhibitory-synaptic-plasticity rule (Vogels et al.) applied to each node's local `J_i` once every 720 ms (one fMRI repetition time), driving that node's excitatory population to a target rate:

```
Δw = η_FIC (pre × post − ρ_0 × pre),    η_FIC = 0.001,  ρ_0 = 4 Hz
```

With FIC off, the E/I→functional-connectivity relation is a complicated non-monotone curve: raising the ratio can raise *or* lower the correlation depending on where you are. **The homeostatic rule is therefore not a biological nicety, it is what makes the parameter learnable at all** — it linearises the map from a structural knob to an observable statistic, and it is also what makes amplitude fall while correlation rises (the concordance the downstream decision result needs).

**(brainstorm) The transferable design rule: a local homeostatic normaliser is a precondition for global learnability, not a competitor to it.** The wiki's normalisation mechanisms are usually justified as stability regularisers. Here a rate-homeostasis rule is what converts a non-monotone parameter→observable map into a monotone one, i.e. it is what makes a gradient exist. Any architecture whose global coupling is to be tuned against an emergent statistic should ask which local invariant has to be held for that statistic to be a monotone function of the knob.

---

## The fitting algorithm

The gradient is *the monotonicity itself* — no backpropagation through the simulator, no adjoint, no surrogate.

```
for each fMRI time step:
    simulate one step of M; compute simulated FC ρ^sim
    for each node i:
        rmse_i = RMS deviation between row i of ρ^trg and ρ^sim
        for each connection j of i:
            diff = ρ^trg_ij − ρ^sim_ij
            w_ij^LRE += η_EI · diff · rmse_i
            w_ij^FFI −= η_EI · diff · rmse_i
            clip both at 0
```

| Design element | Value / role |
|---|---|
| Update signal | Sign and size of the per-edge functional-connectivity error — **the target is an observable statistic, not a state trajectory** |
| `rmse_i` factor | Row-wise error acts like a simulated-annealing temperature: as node `i`'s row fits, its steps shrink. Also breaks the `i↔j` symmetry, so the better-fitting endpoint of an edge moves less |
| Schedule | 6 stages; `η_EI` halved and the functional-connectivity estimation window doubled each stage (start `η = 0.1`, window 150 TRs); 10 h of biological time per stage |
| Online | Parameters updated after every simulated BOLD sample, not after a full run |
| Cost | ~120 CPU-hours per individual model; **78,000 CPU-hours** for the cohort |
| Result | Simulated vs empirical functional connectivity `r > 0.97` per subject, reproducing fine off-diagonal structure |

**Structurally this is Hebbian homeostatic plasticity applied to a *macroscopic* error.** The rule is local in the graph (each edge uses its own error plus one row summary) and it is doing what a plasticity rule does — moving an E/I mixture — but its teaching signal is a statistic of the whole network's output. That is a different animal from both backpropagation and from the wiki's local rules, and it is the first mechanism in the wiki that *learns* a coupling matrix inside a biophysical whole-brain model ([[wiki/concepts/mean-field-reduction.md]] lists "nothing on the ladder learns" as an open problem).

---

## Degeneracy: the parameters are not identified, the predictions are

1000 refits on the group-average structural and functional connectivity, random initial conditions and noise seeds:

| Quantity | Result |
|---|---|
| Minimum pairwise correlation among the 1000 simulated functional connectomes | `r = 0.9946` |
| Mean correlation of each fit's functional connectivity with the empirical target | `r = 0.9973` |
| Simulated BOLD time series across the 1000 models, **same noise** | `r = 0.9962` |
| Coefficient of variation of the fitted parameters | `CV_LRE = 0.5`, `CV_FFI = 0.72` |

So ~143,000 free parameters (two per edge over 379 nodes) do **not** converge to a unique set, and the resulting dynamics are nonetheless reproduced to three decimal places. Held-out generality was checked separately by train/test splits over the cohort (1000 random halves): predicting subject-wise mean functional connectivity from mean synaptic inputs gives `r = 0.67 ± 0.025` train / `0.66 ± 0.025` test; using the ten best-correlated areas, `0.79 ± 0.018` / `0.73 ± 0.055`; per-connection regressions over all 71,631 connections, `0.61 ± 0.1` / `0.52 ± 0.13`.

**The claim this licenses, and the one it does not.** Licensed: the fitted models' *dynamics* — amplitudes, synchronies, the derived behavioural predictions — are a stable function of the data and are comparable across people. Not licensed: reading any individual `w_ij^LRE` as an estimate of that person's anatomy. This is the wiki's cleanest empirical instance of **prediction-identifiability without parameter-identifiability**, and it is a direct challenge to the design rule that [[wiki/entities/virtual-brain-twin.md]] states — *free only the parameters your question requires* — from the same research group ([[wiki/empirical-tensions.md]] T245).

---

## What the ratio buys downstream

### 1. Decision-making: amplitude and input correlation, not threshold

The frontoparietal winner-take-all circuit (two competing decision populations in prefrontal cortex (PFC) and in posterior parietal cortex (PPC), cross-inhibition via a shared inhibitory pool) is normally driven by *independent* Ornstein–Uhlenbeck noise. Replace that with inputs whose amplitude and correlation are swept:

| Manipulation | Accuracy | Integration time |
|---|---|---|
| **Lower** input amplitude | ↑ | ↑ |
| **Higher** correlation of the inputs to the two **PPC** populations | ↑ | ↑, inverted-U with maximum at `r ≈ 0.5` |
| Higher correlation of the inputs to the two **PFC** populations | no relevant effect | no relevant effect |

Both manipulations move accuracy and time in the *same* direction, i.e. they buy accuracy by spending time. Note what is not touched: the circuit's recurrent weights, its cross-inhibition, and any decision threshold. **The speed–accuracy point is set by the statistics of the drive, not by the stopping rule** — which is the alternative [[wiki/concepts/evidence-accumulation.md]] lists as its own open problem ("the threshold itself is unmodelled") and never gets from the accumulator literature.

The asymmetry is the mechanistically informative part: correlation matters at the *parietal* stage and not at the frontal one. Correlated input to the two competing PPC populations is common-mode and therefore does not discriminate — it fails to nudge the race, so the winner-take-all instability is reached later and more of the actual evidence accumulates first. In the slow mode PFC ramps first and amplifies PPC; in the fast mode PPC ramps before PFC, and the decision is effectively taken parietally. That ordering flip is the same signature the ignition literature reports for conscious versus non-conscious processing (late ~300–500 ms prefrontal positivity re-activating parietal cortex, with rising long-range frontoparietal synchrony).

### 2. Working memory: one knob sets *both* thresholds

Bifurcation analysis over net recurrent current `J_S` (recurrent excitation minus cross-inhibition) and stimulus strength `I_app` gives three regimes — robust memory, disrupted memory, no induction. Lowering input amplitude raises the induction threshold **and** the disruption threshold together:

| Input amplitude | Writing a memory | Overwriting it with a distractor |
|---|---|---|
| Low (high functional connectivity, high E/I) | harder | harder — **stable** |
| High (low functional connectivity, low E/I) | easier | easier — **flexible** |

So stability and flexibility are not two dials; they are one dial read from two ends, and it is the *same* dial that sets decision integration time. A configuration that integrates evidence slowly also holds its intermediate results against interference — which is exactly the pairing a hierarchical matrix-reasoning problem needs, where a partially-solved sub-goal must survive while its sub-problems are worked out.

---

## The behavioural anchor: intelligent people are slower on hard problems

| Measurement (HCP, `N` = 1176 unless noted) | Result |
|---|---|
| `g` / fluid intelligence vs. simple processing-speed tests (Pattern Completion, Dimensional Change Card Sort) | Faster — the century-old result reproduced |
| `g` / fluid intelligence vs. reaction time for correct answers on the Penn Matrix Reasoning Test (PMAT) | **Slower** |
| Per-item breakdown (rules out the "they simply reached the harder items" artefact) | Higher scorers faster on the **first 8** items, slower on the **remaining 16** |
| Mean resting functional connectivity vs. `g` (`N` = 650) | `r = 0.02`, `p = 0.69` — **nothing** |
| Mean resting functional connectivity vs. PMAT correct-response reaction time | `r = 0.13`, `p = 0.0012`; positive for every individual item, easy or hard |
| Multiple correlation of mean functional connectivity against all five behavioural variables | `r = 0.16` |
| Fitted models: mean synaptic amplitude vs. PMAT reaction time | `r = −0.11`, `p = 0.0068` (large at group-average level) |
| Fitted models: mean synaptic correlation vs. PMAT reaction time | `r = +0.13`, `p < 0.001` (large at group-average level) |
| Multiscale model (10 PFC + 10 PPC parcels identified by n-back activation, 90 pairings) | Models of higher-fluid-intelligence individuals were **more accurate and slower**, reproducing the empirical trade |

Two cautions the numbers themselves impose. The single-subject effect sizes are small (`r ≈ 0.11–0.16`, i.e. ~2% of variance); the group-average correlations that look impressive are computed on binned means, which inflates them. And mean functional connectivity predicts *reaction time* but not *accuracy* (`r = 0.02` with `g`) — so the network variable is a speed variable, and the accuracy half of the trade is inferred from the circuit simulations rather than measured against behaviour.

---

## Relevance to a reasoning model

- **A second, non-threshold route to the speed–accuracy point, and it is the route a network has.** Every stopping rule in the wiki ([[wiki/concepts/evidence-accumulation.md]]) trades accuracy for time by moving a boundary. Here the boundary is untouched and the *input statistics* move: lower amplitude, higher common-mode correlation. For a builder this is cheaper — it is one gain and one shared-noise term on the input to a competition, applied globally, with no per-decision policy — and it is the only mechanism in the wiki that produces the trade as a side-effect of a variable that is *already* being set for other reasons.
- **Coupling decision speed to memory volatility is free, and probably correct.** No architecture in the wiki links its stopping rule to its store's write threshold; here one variable sets both, in the direction that matches the task ([[wiki/architectural-gaps.md]] `G86`). **(brainstorm)** The concrete import: put a single scalar `α` on a reasoning module's input gain, use `1/α` on the drive into its scratchpad's write gate, and a "deliberate" mode automatically becomes a mode with a hard-to-clobber scratchpad. The failure prediction is equally concrete — a system tuned for fast throughput should show *both* premature commitment and distractor-sensitive intermediate state, and should not be fixable by only raising its decision threshold.
- **Feedforward inhibition is what makes a long-range weight signed, and the wiki's whole-brain couplings are not.** [[wiki/entities/fcann.md]] and the coupling matrices of the metastability literature are excitatory-scalar objects. Splitting each edge into an E-targeting and an I-targeting share costs one extra number per edge and buys the full range from antisynchronisation to synchronisation — the sign of a functional relationship becomes a *learnable* property of the edge instead of an artefact of the readout.
- **A learning rule whose teaching signal is a network-level statistic.** The update is local in the graph and its error is a correlation the network emits. This is neither backpropagation nor a purely local Hebbian rule, and it is one answer to what a slow **W**-level learner could optimise when no per-unit target exists: match a *statistic* of your own activity to a target statistic ([[wiki/concepts/latent-graph-discovery.md]]).
- **The identifiability lesson runs the other way from the wiki's usual one.** 143,000 parameters, non-unique to `CV ≈ 0.5–0.7`, and time-series predictions reproducible at `r = 0.9962`. The right audit question is not "how many parameters did you free" but "which functionals of the parameters are pinned by the data" — and that is answerable by refitting with different seeds and correlating the *outputs*, which costs one extra run and is not standard practice anywhere in this wiki.
- **A latency benchmark for reasoning systems.** The human result is that on matrix-reasoning items the better solvers are slower on the hard items and faster on the easy ones — a *crossing*, at item 8 of 24. A system with a fixed inference budget cannot produce that curve; a system with an adaptive one should be scored on whether it does ([[wiki/entities/raven.md]], [[wiki/entities/arc-agi.md]]).

---

## Open problems

- **Nothing sets the ratio at run time.** The E/I ratios are fitted offline over 60 h of simulated biological time per model and then frozen. Whatever the brain uses to move along the fast↔slow axis within a task operates in seconds, and this work supplies no such mechanism — the fitted ratio is a trait, and the phenomenon it explains (switching modes by problem type) is a state.
- **The direction of the behavioural inference is unsecured.** Mean functional connectivity is measured at rest and correlated with performance on a task recorded elsewhere; the model then supplies a mechanism connecting them. Nothing manipulates E/I balance and observes reaction time.
- **The accuracy half of the trade is simulated, not measured.** Mean functional connectivity has no relationship to `g` (`r = 0.02`). The accuracy prediction rests entirely on the circuit model and on the multiscale coupling.
- **The multiscale coupling is a search.** 90 PFC×PPC pairings were tried and "several" predicted empirical performance; how many, and under what correction, is not stated in the main text.
- **One mechanism out of many.** The authors state it plainly: a model with this many parameters admits potentially infinitely many mechanisms consistent with the data. The defence offered is that the circuit-level results hold with no fitting at all, which is the right defence and covers the DM/WM results but not the claim that E/I ratios are what individual differences in functional connectivity *are*.
- **Streamline counts again.** `C_ij` is diffusion tractography, so the lateral-parietal and interhemispheric blind spots of [[wiki/concepts/function-to-structure-inference.md]] are inherited wholesale, and every fitted `w_ij` is a correction applied on top of a biased skeleton.

---

## Connections

- **[[wiki/concepts/evidence-accumulation.md]]** — supplies the missing half of that page's "the threshold itself is unmodelled" problem: the speed–accuracy point is moved by lowering input amplitude and raising common-mode input correlation at the parietal stage, with the decision boundary and the recurrent weights untouched, so the trade is a property of the drive rather than of the stopping rule.
- **[[wiki/concepts/integration-segregation-balance.md]]** — the same network-state→behaviour question with the opposite sign and a finer decomposition: there, more integration raises drift rate and leaves the boundary alone (no trade); here, higher mean functional connectivity buys accuracy by spending time — logged as [[wiki/empirical-tensions.md]] T250.
- **[[wiki/concepts/mean-field-reduction.md]]** — the rung this page's nodes occupy, and the first mechanism to answer that page's "nothing on the ladder learns": the heterogeneous long-range coupling it says is "supplied by anatomy, never recovered" is here recovered per edge by a homeostatic Hebbian rule driven by a functional-connectivity error.
- **[[wiki/concepts/effective-connectivity.md]]** — an effective-connectivity estimator with an unusual output type: not a directed weight but a *mixture* (excitatory-targeting vs inhibitory-targeting share) per edge, which is what makes the recovered coupling signed, fitted to `r > 0.97` at 379 nodes and ~143,000 parameters.
- **[[wiki/entities/virtual-brain-twin.md]]** — the same lab's opposite design rule, and the contrast this page sharpens: the twin infers ~3 parameters because the rest are degenerate; this fits ~143,000 that *are* degenerate (`CV ≈ 0.5–0.7`) and shows the predictions are reproducible anyway (`r = 0.9962` on the time series).
- **[[wiki/concepts/function-to-structure-inference.md]]** — the constructive attempt at the deconvolution that page lists as never attempted: rather than thresholding correlations to declare edges, it inverts functional connectivity into a per-edge E/I mixture on a *known* structural skeleton — which sidesteps the base-rate problem by never asking whether an edge exists, and inherits that page's tractography blind spots.
- **[[wiki/concepts/working-memory.md]]** — a mechanism that makes stability and flexibility one parameter rather than two: input amplitude shifts the induction and disruption thresholds of persistent activity together, so a configuration that is hard to write is also hard to overwrite, and it is the same configuration that integrates evidence slowly.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — the generative counterpart of that page's measurement caution: here a correlation between two nodes is produced by moving their long-range E/I mixture with the structural edge held fixed, so a change in synchrony is exactly what a change in *input composition* looks like from the outside.
- **[[wiki/concepts/attractor-dynamics.md]]** — the bifurcation reading: the fast/slow decision modes and the robust/disrupted/no-induction memory regimes are regions of a `(J_S, I_app)` diagram, and input amplitude translates the boundaries rather than changing the attractor structure.
- **[[wiki/concepts/synaptic-plasticity.md]]** — an inhibitory-plasticity rule doing load-bearing computational work rather than stabilisation: `Δw = η(pre·post − ρ_0·pre)` pinning each node to 4 Hz is what makes the map from E/I ratio to functional connectivity monotone, and without it the parameter is not learnable.
- **[[wiki/concepts/metastability.md]]** — the working-point literature this page's fits sit inside, with a different control variable: not one global gain `G` swept toward a bifurcation but a per-edge mixture, which reaches a functional-connectivity fit (`r > 0.97`) an order of magnitude beyond what global-gain sweeps achieve.
- **[[wiki/concepts/cognitive-control.md]]** — the effortful/automatic distinction given a network correlate: hard decisions require slow frontoparietal integration with prefrontal cortex leading, easy ones are taken parietally with prefrontal cortex following, and the switch between the two is one input-statistics variable rather than a controller decision.
- **[[wiki/entities/raven.md]]** — the human latency curve on the psychometric matrix task: higher scorers are faster on the first 8 items and slower on the remaining 16, so *time spent* crosses over with difficulty — a property no fixed-budget solver of these items can exhibit.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a slow-**W** learning signal of an unusual type: the teaching signal is a *statistic* of the network's own output (its correlation matrix) rather than a per-unit target, and the update is local to the edge, which is one concrete answer to what a graph-level learner optimises when no per-edge supervision exists.
- **[[wiki/concepts/activity-baseline.md]]** — the same shape of argument two levels up: node-level homeostasis pins a firing rate while synaptic drive varies, and supply–demand equilibration pins the oxygen extraction fraction while metabolic rate varies ~4× — in both cases the invariant is what makes a deviation readable.
- **[[wiki/concepts/ignition.md]]** — the ordering flip this page reports between prefrontal and parietal ramping is the ignition literature's own signature, and the connection is mechanical: Joglekar et al. 2018 show a reciprocally connected cortical network ignites only inside a balanced-amplification window, so this page's one knob sets the *admission threshold* for global broadcast as well as the speed–accuracy point and the working-memory thresholds.
- **[[wiki/concepts/random-feedback-addressing.md]]** — balance doing information-theoretic rather than stability work: shifting every unit's inputs so that `Σ_j W^FF_ij = Σ_j W^FB_ij = 0` is exactly what makes off-target top-down feedback mean-zero, so a precision result about mixed-selectivity feedback is a consequence of E/I balance and should degrade as balance is broken (Park & Serences 2025).
