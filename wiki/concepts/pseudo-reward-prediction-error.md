# Pseudo-Reward Prediction Error — an Internally Generated Error Over a Subgoal the Reward Function Says Nothing About

**A pseudo-reward prediction error (PPE) is a temporal-difference error computed against an *option-specific* value function `V_o`, so it moves when progress toward the current subgoal changes and stays silent when progress toward the rewarded goal changes — the one quantity that exists in hierarchical reinforcement learning and in no flat learner, and therefore the signal that makes a self-set intermediate goal trainable by the same rule as a real one.**

> **Provenance.** Ribas-Fernandes, Solway, Diuk, McGuire, Barto, Niv & Botvinick 2011, *A neural signature of hierarchical reinforcement learning*, Neuron 71(2):370–379 (`raw/ribasfernandes-2011-neural-signature-hierarchical-rl.md`). Three neuroimaging experiments (EEG `n` = 9; fMRI `n` = 30; fMRI `n` = 14) plus one behavioural experiment (`n` = 22) on one task, with a simulated hierarchical and a simulated flat agent supplying the contrasting predictions. Display equations 1–2 are figure images in the clip and are reconstructed below from the paper's own prose definitions; everything else is from that source unless marked.

Why this earns a page rather than a row on [[wiki/concepts/temporal-abstraction-options.md]]. That page lists pseudo-reward as one cell of the options formalism and flags in its own open problems that it **may not exist** (`T136`). It does exist, and the measurement that shows it is a *design*, not a correlation: the task makes the goal-level and subgoal-level value changes geometrically orthogonal, so the flat learner's prediction is exactly zero where the hierarchical learner's is large. That design is reusable and is the page's main transferable content.

---

## The formalism

| Object | Definition (delivery task) | Flat learner's counterpart |
|---|---|---|
| State (flat agent) | `s_t = gd` — goal distance, truck → package → house, in navigation steps | same |
| State (hierarchical agent) | `s_t = (gd, sd)` — plus `sd`, truck → package | `sd` is **not** part of the state |
| Reward `r` | `1` at goal (house) attainment | same |
| Pseudo-reward `r̃` | `1` at subgoal (package) attainment | does not exist |
| Value | `V(t) = γ^{gd(t)}`, `γ = 0.9` | same |
| Option value | `V_o(t) = γ^{sd(t)}` | does not exist |
| RPE (pre-goal) | `δ_t = γV(s_t) − V(s_{t−1})` | same |
| PPE (pre-subgoal, inside option `o`) | `δ^o_t = γV_o(s_t) − V_o(s_{t−1})` | **zero by construction** |

*(Equations reconstructed; `γ`, both value definitions and `r = r̃ = 1` are stated in the source's prose.)* On an ordinary step toward the package both errors vanish — `gd` and `sd` each fall by one and the discount exactly cancels. Only a *displacement of the subgoal* moves them, which is what the task manipulates.

---

## The design: orthogonalising the two levels by geometry

The package occasionally jumps mid-trial. Because total path length is truck → package → house, the locus of package positions leaving `gd` unchanged is **an ellipse with foci at the truck and the house**. Jumping along that ellipse changes `sd` freely while holding `gd` fixed — the whole experiment sits inside this one fact.

| Jump | `gd` | `sd` | Flat RPE | Hierarchical PPE | Used in |
|---|---|---|---|---|---|
| A (inside ellipse) | ↓ | — | **+** | — | simulation only |
| B (outside ellipse) | ↑ | — | **−** | — | simulation only |
| C (on ellipse, toward truck) | 0 | ↓ | **0** | **+** | fMRI 2 |
| D (on ellipse, away from truck) | 0 | ↑ | **0** | **−** | EEG, fMRI 1 |
| E (on ellipse, `sd` preserved) | 0 | 0 | 0 | 0 | baseline in all three |

Simulated distances `(gd, sd)`: start `(949, 524)`, two steps to `(849, 424)`, then A `(599, 424)`, B `(1449, 424)`, C `(849, 124)`, D `(849, 724)`, E `(849, 424)`.

**Type E is the load-bearing control**, not a filler condition: it is the only jump that moves the stimulus, draws the eye and triggers re-planning while predicting *neither* error — so subtracting it removes visual transient, attention shift and motor re-specification and leaves the subgoal-distance term alone. Any machine analogue of this experiment needs its own E.

---

## Results

| Experiment | `n` | Manipulation | Finding |
|---|---|---|---|
| EEG | 9 | D vs E | Phasic negativity at Cz, 200–600 ms post-jump, `p` < 0.01; fronto-central midline topography, i.e. a feedback-related-negativity-like component, peaking later than a standard FRN |
| fMRI 1 (whole brain) | 30 | D vs E, PPE magnitude as parametric regressor | dACC `p` < 0.01 (cluster-corrected), bilateral anterior insula, right supramarginal gyrus, medial lingual gyrus; left inferior frontal gyrus with negative coefficient |
| fMRI 1, controlling subgoal *displacement* | 30 | nuisance regressor: distance from old to new package position | Surviving: **dACC** (`p` < 0.01), **bilateral anterior insula** (`p` < 0.01 left, `p` < 0.05 right), right lingual gyrus |
| fMRI 1, region-of-interest | 30 | D vs E in habenula, nucleus accumbens (NAcc), amygdala | **Habenular complex** D > E, `p` < 0.05; **right amygdala** `p` < 0.05; NAcc null |
| fMRI 2 | 14 | C vs E, NAcc region of interest | **Right NAcc** activation scaling with predicted PPE magnitude, `p` < 0.05 |
| Behaviour | 22 | Choice between two packages differing in `gd` and `sd` | `gd` coefficient `M = −7.6`, `p` < 0.001; `sd` coefficient `−0.16`, `p` = 0.43 (null also within trials matched on `gd` ratio 0.8–1.2). Mean Bayes factor 4.31 favouring the hierarchical model over a flat model with primary reward at the subgoal, `p` < 0.001 |

**The behavioural experiment is what makes the imaging interpretable.** If participants had attached primary reward to the package, a flat learner would predict an RPE at C and D jumps and the whole dissociation collapses. Choice says they did not: subgoal distance carries no weight in a preference that is strongly sensitive to goal distance. So the imaging signal is an error about a state the agent is *not* paid to reach — which is precisely what "invented intermediate goal" has to mean operationally.

**Alternative explanations the source rules out.**

| Alternative | Why it fails |
|---|---|
| Response conflict / error detection (the standard dACC reading) | The EEG effect survives controlling for response accuracy and response latency, the two usual conflict indices |
| Exogenous attention shift | Attention shifts produce a midline **positivity** growing with eccentricity; the authors observe exactly that positivity in their own data when contrasting jumps (D + E) against no-jump trials, while the PPE effect is a negativity |
| Attention, in fMRI | Frontal eye fields and superior parietal cortex do activate for jumps vs no-jump, but show **no** correlation with the PPE regressor |
| Subgoal displacement magnitude | Entered as a nuisance regressor; dACC and insula survive it |

---

## What this settles, and what it does not

| Question | Answer |
|---|---|
| Does a learner with subgoals emit a subgoal-specific error signal? | **Yes** — `T136` closes in favour of pseudo-reward ([[wiki/tensions/closed/t136.md]]) |
| Where? | The *same* four structures already associated with reward prediction error: dACC, habenula, amygdala (negative PPE) and NAcc (positive PPE) |
| Is the signal separated from the reward prediction error by anatomy? | **No evidence of separation** — at this resolution the two are co-localised, which is what opens `T367` |
| Is it dopaminergic? | Unknown. Indirect and explicitly hedged: dACC and habenula are both proposed dopamine-modulating or dopamine-driven sites, but the authors note the account does not require dopamine |
| Where did the subgoal come from? | **The experimenter.** The package is a task object; nothing here discovers, selects or retires a subgoal (`G33`) |
| Does the signal *drive learning*? | Untested. Policies were near-stable throughout; the source names learning dynamics in hierarchical tasks as the open follow-up |
| Positive and negative PPE in the same subject? | No — separate experiments, separate participants, and the positive effect is unilateral (right NAcc, right amygdala) |

---

## The credit-assignment problem this creates

The source states it and does not solve it: if the PPE is carried on the same phasic channel as the RPE, proper credit assignment **requires the downstream learner to discriminate them**, because a pseudo-reward folded into the root value function is an agent paying itself. Three structural options, none measured — `T367`:

| Option | Mechanism | Cost |
|---|---|---|
| Two channels | Separate populations/projections for `δ` and `δ^o` | A second broadcast scalar; [[wiki/concepts/broadcast-channel-decomposition.md]] shows the dopaminergic projection already carries at least three signals, so this is not extravagant |
| One channel, context-gated | The identity of the running option is held elsewhere (a prefrontal stripe) and gates which value function the same scalar updates | Needs the option identifier to be a *routing* variable, not just a state feature — the write-enable of [[wiki/entities/pbwm.md]] doing double duty |
| One channel, no separation | Pseudo-reward genuinely enters the root value | The farming failure mode: the agent maximises its own subgoal attainment and stops delivering packages |

**(brainstorm)** The wiki's own material makes option 2 the cheap one and predicts a diagnostic nobody has run. `V_o` is indexed by the option identifier; if that identifier is the same vector that gates the prefrontal stripe, then the discrimination is free — the scalar is broadcast undifferentiated and *which* value table it lands on is set by what is currently maintained, exactly the `snr_j · δ` trick of [[wiki/entities/pbwm.md]] with the mask supplied by the hierarchy rather than by the sender. The prediction: abolish the option representation (or make two options share one identifier) and the PPE should start contaminating goal-level value, measurable as choice becoming sensitive to subgoal distance — the behavioural experiment above run again under a working-memory load.

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| PPE | A gradient on distance to an **interior node** of the graph, computed while the gradient on distance to the terminal node is flat |
| The ellipse | The locus along which the two gradients are orthogonal — the general recipe for testing whether an agent represents an interior node at all |
| Type E jump | Movement along the graph's *observation* dimension with both distances fixed: the control that separates "re-perceived" from "re-valued" |
| Co-localisation of PPE and RPE | The same edge-length readout applied to two different targets, so the machinery is per-target-instantiated rather than per-level-duplicated |
| What is still missing | Which interior node to point at — this page supplies the error term once the node is chosen and says nothing about choosing it (`G33`) |

---

## Open problems

- **Nothing here invents the subgoal.** The signal is the cheap half; `G33`'s selection problem is untouched, and the task's subgoal is a visible object with a hand-designed pseudo-reward of `1`.
- **The relative scale of `r̃` to `r` is unset.** Both are `1` in the simulation by fiat. Nothing in the framework or the data says what a subgoal should be worth, and the answer determines whether the agent farms subgoals or ignores them.
- **No signal at subgoal *attainment* is reported.** Attainment regressors were in the design matrix; only the en-route error is analysed. The reward-like response to attainment that [[wiki/concepts/temporal-abstraction-options.md]] predicts is still unmeasured.
- **The option-level error of the formalism is not the one measured.** Options theory's `δ_o = [Σ γ^t r_t] + γ^k V(s_term) − V(s_init)` is computed **at termination** over the whole option; the PPE here is a per-step error *inside* the option, against `V_o`. Both are in the framework; only the second has neural evidence.
- **Hierarchy was assumed, then argued for post hoc.** The authors concede any hierarchical policy has a flat equivalent under the Markov property; the behavioural Bayes factor (4.31) is the only positive evidence that participants used the hierarchical representation, and it is modest.
- **Unilateral effects.** Right NAcc and right amygdala only, in small region-of-interest samples — the lateralisation is unexplained and untested.

---

## Connections

- **[[wiki/concepts/temporal-abstraction-options.md]]** — supplies the measurement that page's formalism asked for and its open problems doubted: pseudo-reward is real, so the `V_o` row is not a modelling convenience, and the framework-discriminating prediction that separated options/MAXQ from HAM has been made and came out for the first pair (`T136`, now closed).
- **[[wiki/concepts/reward-prediction-error.md]]** — the same difference operator applied to a second value function, and the finding that makes the pairing awkward: the PPE appears in dACC, habenula, amygdala and nucleus accumbens, i.e. in the structures that page already assigns to `δ`, so a recorded reward prediction error is not identified as one by its location (`T367`).
- **[[wiki/concepts/expected-value-of-control.md]]** — direct evidence for that page's rival, `T364` position B: a dACC signal indexed to the **subgoal level** with goal-level value held constant by design, and with response conflict and latency controlled — which the level-blind expected-value-of-control criterion contains no argument for and does not predict.
- **[[wiki/entities/lateral-habenula.md]]** — extends the negative channel past primary reward: habenular activation to a jump that increases distance to a subgoal carrying no primary reward at all, so the anti-reward hub reports errors against an *internally supplied* target and not only against outcomes the environment pays for.
- **[[wiki/entities/amygdala.md]]** — the same point on the other structure, and a constraint on that page's format axis: right amygdala responds to a subgoal-distance error, which is a signal about a *self-set* intermediate state rather than about the current value of a specific predicted outcome — the basolateral reading would need the subgoal to count as an outcome.
- **[[wiki/entities/salience-network.md]]** — its two cortical nodes, dorsal anterior cingulate and bilateral anterior insula, are the two regions surviving every control here; so the "salience detector" is reporting a purely *internal* bookkeeping error with no exogenous salience difference between conditions (type D and type E jumps are matched visual events), which the detection framing does not cover.
- **[[wiki/concepts/broadcast-channel-decomposition.md]]** — the address problem raised one level up: that page splits the dopaminergic projection by what is signalled about the outcome, this one adds a split by *which value function the error belongs to*, and the co-localisation result means the second split, if it exists, is not visible at the resolution used here (`T367`).
- **[[wiki/concepts/hindsight-goal-relabelling.md]]** — the flat rival at the level of *signal* rather than of structure: relabelling manufactures dense intermediate reward by rewriting goal labels on stored transitions, where this page's mechanism emits a second live error against a second value function — so the pair brackets the two ways an agent gets gradient between sparse rewards, one offline and label-side, one online and critic-side.
- **[[wiki/concepts/optimal-hierarchy-criterion.md]]** — the complement it needs and does not have: that page scores *which* decomposition to adopt but presupposes the subtask policies are already optimal, while this page supplies the error term that would train them — together they are a selection criterion plus a learning signal, with nothing yet joining the two.
- **[[wiki/concepts/eigenoption-discovery.md]]** — the same object arrived at from the opposite end: eigenpurposes `rᵉ(s,s′) = eᵀ(φ(s′) − φ(s))` *are* pseudo-rewards derived from graph structure with no environment reward consulted, so that page answers where a subgoal comes from and this one shows the brain emits the resulting error — but the eigenpurpose is a per-step reward while the measured signal is a per-step *error* against `γ^{sd}`, and no source runs the pair together.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the ellipse manipulation generalised: holding distance-to-terminal-node fixed while varying distance-to-interior-node is the discriminating design for whether an agent represents interior nodes at all, and it transfers to any graph where two distances can be traded against each other.
- **[[wiki/entities/pbwm.md]]** — the candidate solution to this page's credit-assignment problem: an option identifier maintained in a gated stripe would route one broadcast scalar onto the right value table, which is that model's `δ_j = snr_j · δ` with the mask supplied by the hierarchy instead of by the sender.
- **[[wiki/concepts/learning-progress.md]]** — the drive that would select which self-set goal to work on, to this page's signal for training on one once selected: learning progress allocates free time across activities and is measured only behaviourally, while a pseudo-reward prediction error is measured in cortex on a subgoal the experimenter supplied — between them the two halves of a self-directed curriculum, never measured in the same paradigm (Ten et al. 2021).
- **[[wiki/concepts/conditioned-reinforcement.md]]** — the measured *value* of the intermediate target, to this page's measured error against it, and the two have incompatible dynamics: here `r̃ = 1` by fiat and is immune to being collected, while a conditioned reinforcer's worth is its own pairing probability (0.7 at 50% backing, 0.4 at 30%) and is extinguished by every delivery the primary reward does not follow (`G125`). It also turns this page's credit-assignment worry into an observation — Cronin 1980's pigeons chose the option signalled by an immediate conditioned reinforcer over the one leading to food, on ~90% of trials, stably.
- **[[wiki/concepts/higher-order-conditioning.md]]** — three constraints on this page's signal that the biological chain imposes and `r̃` violates: the manufactured target's value is not a copy of the goal's, it is a US-general affect with the outcome's identity stripped at the first chaining step (`T395`); the procedure that creates it simultaneously trains an inhibitor of it, so net pull is a difference of two quantities with different time constants (`G126`); and the association's *type* is fixed by where the new input attaches relative to the outcome-identity stage and the policy fan-out, which is a wiring decision every hierarchical learner makes implicitly and none reports.
- **[[wiki/concepts/token-reinforcement.md]]** — the pay-out schedule this page has by default and never chose: crediting `r̃` at subgoal completion is the unequal-exchange arrangement, the one under which both pigeons and humans take the sooner, smaller option; equalising the redemption delay across options reverses the preference with the subgoal contingency identical (Jackson & Hackenberg 1996; Hyten et al. 1994), which makes `T367`'s subgoal-capture failure a schedule parameter rather than a structural defect (`G127`).
- **[[wiki/concepts/effort-based-decision-making.md]]** — the one place a self-manufactured subgoal reward would *lower* a cost rather than raise a pull: if effort's opportunity cost is regulated vigour-style by the average rate of *experienced* reward reported in striatal dopamine tone, then internally generated pseudo-rewards credited at subgoal completion enter that average, so decomposing a task into subgoals makes the task itself subjectively cheaper to stay engaged with. Westbrook & Braver 2015 state the ingredient and never join it to a subgoal mechanism; no wiki architecture implements the coupling, and it predicts that a hierarchical agent's effort price falls as its decomposition gets finer — with a failure mode (reward-rate inflation by pseudo-reward spam) that the terminal-reward-anchored accounts do not have.
- **[[wiki/concepts/learned-industriousness.md]]** — the complementary route to the same end, and the transfer contrast that separates them: manufacturing subgoals lowers a task's effective cost by injecting reward into it, where conditioning value onto the effort sensation lowers the price of exertion itself. A subgoal decomposition is task-bound; a conditioned effort price is carried into tasks never decomposed.
