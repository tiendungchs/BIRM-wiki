# Intrinsic-Motivation Typology

**An intrinsic motivation is a reward function computed from properties of the sensorimotor flow and of its relation to the agent's own knowledge and know-how, *irrespective of the meaning of the channels it reads*. That last clause — not "no external goal", not "internally generated" — is the only criterion that survives formalisation, and it partitions a dozen published curiosity formulas into three families that are not interchangeable.**

> **Provenance.** Oudeyer & Kaplan 2007, *What is intrinsic motivation? A typology of computational approaches*, Front. Neurorobot. 1:6 (`raw/oudeyer-2007-what-is-intrinsic-motivation-typology.md`). A typology, not an experiment: no result is reported in this paper. The clipped HTML renders most equations as images; every formula below is one the prose states in words or symbols, and the image-only ones are described rather than guessed.

This page is the *map* that [[wiki/concepts/epistemic-value.md]] is a measurement of. That page ablates four quantities circulating under one name inside active inference; this one covers the larger space those four sit in, including the competence half that active inference has no term for.

---

## The three axes that are routinely conflated

| Axis | Distinguished by | Note |
|---|---|---|
| **internal / external** | *where the reward is computed* — inside the agent, or handed to it by a designer, a camera on the ceiling, an environment API | Purely a question of autonomy. A robot that measures its own forward speed and rewards itself has an **internal, extrinsic** motivation |
| **intrinsic / extrinsic** | whether the reward is defined over *specific, meaning-bearing* channels (energy level, number of faces, distance walked) or over the flow's abstract properties | The paper's own criterion, and the one it arrives at only after rejecting the psychological definition. All external motivations are extrinsic; internal ones can be either |
| **homeostatic / heterostatic** | satiable vs. unsatiable — maintain a variable in a comfort zone, or be pushed permanently away from the habitual state | Novelty reward is heterostatic; "reward novelty only at an intermediate rate" makes the same drive homeostatic |
| **fixed / adaptive** | does the same sensorimotor situation get the same reward for the agent's whole life? | A novelty drive is adaptive *only if* the agent remembers; otherwise it is a fixed function of an unchanging estimate |

**Why the psychological definition fails computationally.** Ryan & Deci define intrinsic motivation by the absence of a separable outcome. Under reinforcement learning every reward *is* a goal, so "search for novelty" is the goal of obtaining novelty rewards and is therefore extrinsic by that definition. The construct does not survive the translation, which is why the paper replaces it with the channel-semantics criterion above. **The consequence the wiki should hold:** `intrinsic ≠ exploratory`. Familiarity, competence-maximising and stability motivations are intrinsic under this criterion and make an agent stand still.

---

## Family 1 — knowledge-based: score the flow against what the agent predicts

Two sub-families by how knowledge is represented. Events `e^k` are states `SM^k`, transitions `(SM^k(t), SM^l(t+1))`, or conditionals; `SM(→t)` is the current-and-past sensorimotor context; `Π` is a predictor, `E_r(t) = ‖ẽ^k(t+1) − e^k(t+1)‖` its error.

### 1a. Information-theoretic / distributional — the agent holds `P(e^k)`

| Model | Reward | What it seeks |
|---|---|---|
| **Uncertainty motivation (UM)** | `r(e^k) = C / P(e^k)` | rare events — novelty as *low empirical probability* |
| **Information gain motivation (IGM)** | decrease in the entropy of the agent's distribution caused by observing `e^k` | "pleasure of learning"; assimilation |
| **Distributional surprise motivation (DSM)** | non-linear in expectation violation: high only for events that were *strongly expected not to occur* | surprise ≠ novelty — any draw from a flat distribution is maximally novel for UM and barely surprising for DSM |
| **Distributional familiarity motivation (DFM)** | UM with the sign flipped: `r ∝ P(e^k)` | the frequent and familiar |

Distributional models need an estimate of `P` over an event space that is **not predefined** and grows with experience, and the paper concedes they are typically intractable in continuous spaces.

### 1b. Predictive — the agent holds a predictor, not a distribution

| Model | Reward | Note |
|---|---|---|
| **Predictive novelty motivation (NM)** | `r = C · E_r(t)` | maximise prediction error. The stochastic-trap family: an unpredictable noise source is maximally rewarding forever |
| **Intermediate level of novelty (ILNM)** | peaked at a threshold `E^σ_s` | direct model of "optimal incongruity", and the paper's own objection is decisive — one global threshold cannot be right across a heterogeneous sensorimotor space, and adaptive thresholding is the hard part |
| **Learning progress motivation (LPM)** | the (negated) derivative of the mean prediction error over the last `τ` predictions **made inside a region `ℛ_n`** | threshold-free version of ILNM |
| **LPM, Schmidhuber 1991 variant** | error of `Π` on the *same* context `SM(→t)` before minus after one learning update | progress measured per-update rather than per-window; no regions needed |
| **Predictive surprise motivation (SM)** | ratio of actual error to the error a meta-predictor `MetaΠ` expected | needs a second predictor of `Π`'s own error — the wiki's cheapest self-competence estimate (`G89`) |
| **Predictive familiarity motivation (FM)** | high for low error; robustly, low smoothed error in the region containing `SM(→t)` | intrinsic, anti-exploratory |

**The regionalisation is load-bearing and is not a detail.** A naive learning-progress reward compares errors in a window at `t` against a window at `t − θ`, which rewards the *transition* from watching a leaf in the wind to staring at a white wall. Progress is only meaningful within a set of comparable situations, so LPM requires an incremental partition `{ℛ_n}` of the sensorimotor space with adaptively updated boundaries — i.e. **a curiosity signal presupposes a task decomposition**, which is the same object `G33` wants and nothing in the typology supplies.

---

## Family 2 — competence-based: score the flow against what the agent can *achieve*

The paper's contribution the literature had not implemented in 2007, and the formal home of effectance (White 1959), personal causation, self-determination and Flow.

**Architecture.** A know-how module `KH(t_g)` plans actions toward a self-set goal; a motivation module rewards from `KH`'s performance; a third module chooses goals to maximise that reward. **Two clocks:** physical time `t` over atomic actions, and abstract time `t_g` over goal-reaching *episodes*, an episode being `set g_k(t_g)` → act → terminate on success or timeout `T_g`. At the end, the reached configuration is compared to the goal to give a level of (mis)achievement `l_a(g_k, t_g)`, and rewards are emitted **only at episode end**.

| Model | Reward | Seeks |
|---|---|---|
| **Maximising incompetence (IM)** | `l_a` on this episode; smoothed over the last `τ` episodes at the same goal; or over goals with `dist(g_k, g_k^{σ_g}) < σ_g` | maximally difficult challenges |
| **Competence progress / Flow (CPM)** | current performance at `g_k` minus performance at the last attempt `t_g − θ`; smoothed and neighbourhood-generalised as above | goals whose difficulty is *falling* |
| **Maximising competence (CM)** | mean performance in the goal-space region `ℛ_n` containing `g_k` | mastered activities |

Three properties a builder should read off this:

- **A goal here is any set of properties of a sensorimotor configuration that the agent sets for itself.** Interestingness is a property of the *achievement process*, never of the goal's content — so the family generates its own goal space and needs no external success criterion (`G72`), at the price that the goal space is exactly as arbitrary as the sensorimotor parameterisation.
- **Episodes are temporally extended actions**; the abstract clock `t_g` is the option clock of [[wiki/concepts/temporal-abstraction-options.md]], and the goal chooser is a policy over options learned by ordinary reinforcement learning on the intrinsic reward.
- **Prediction and control are only loosely coupled**, so knowledge-based and competence-based motivations are *not* notational variants: no prediction model is required to run `KH` at all (Q-learning over self-set goals suffices), and being able to predict a situation says little about being able to bring it about.

---

## Family 3 — morphological: score the flow alone, with no model of any kind

No predictor, no goal — only mathematical properties of the sensorimotor time series.

| Model | Reward | Note |
|---|---|---|
| **Synchronicity (SyncM)** | short-term correlation across a maximally large number of channels, measured as mutual information `I(SM_i; SM_j)`, as Crutchfield's normalised information distance `d` (a metric, via conditional entropies), or as plain correlation | the cheapest cross-modal binding signal in the wiki: synchrony detection is implicated in object interaction, self-modelling and word learning in infants |
| **Stability (StabM)** | keep `SM(t)` near its average over the last `τ` steps | yields tracking behaviour |
| **Variance (VarM)** | high variance across channels | pushes toward contingencies far from equilibrium |

**(brainstorm)** SyncM is the only reward in the typology whose maximiser is a *structural* discovery rather than an epistemic state: high mutual information between a motor channel and a sensory one is exactly an edge in the latent graph ([[wiki/concepts/latent-graph-discovery.md]]), and the reward needs neither a model nor a goal to find it. The typology's own estimate is that its organisation potential is low, but the wiki has no morphological-reward implementation to check that against.

---

## The exclusion test, stated as a procedure

`SocM` (keep the average number of faces seen near a set point) and `EnerM` (keep energy near an optimal level) are **internal, adaptive, homeostatic — and not intrinsic**, because each is defined over a *named* channel. Test: *permute the labels on all sensory and motor channels; if the reward function changes, it is extrinsic.* Every formula in families 1–3 is permutation-invariant; `SocM` and `EnerM` are not. This is a cheap audit for any claimed curiosity bonus, and it is the one criterion in the source that does real work.

---

## Which of the wiki's exploration quantities are the same thing

The map `R5` asked for. Columns: what the quantity is defined *over*.

| Wiki quantity | Typology cell | Same quantity? |
|---|---|---|
| E3 parameter novelty, `D_KL[q(θ\|y,x) ‖ q(θ\|x)]` ([[wiki/concepts/epistemic-value.md]]) | **IGM** | Yes, up to notation — entropy decrease of the agent's own distribution caused by an observation |
| E1 state-marginal coverage, `Φ = −Σ_t H(ρ^π_t)` | between **UM** and **VarM** | No. UM rewards a *rare event on observation*; `Φ` scores a *predicted occupancy* before acting. UM is retrospective and model-free, `Φ` is prospective |
| E2 belief sharpening `I_a(b)` over a fixed hidden state | **no cell** | The typology has no model of a hidden state to be inferred; all its knowledge-based models score the observable flow |
| E4 ambiguity `E H[q(y\|x,θ)]` | **no cell** | Sensor equivocality is a channel-specific quantity and fails the permutation test |
| Plan2Explore latent disagreement ([[wiki/entities/continual-dreamer.md]]) | **NM** (ensemble form) | Yes — prediction error, with the error estimated as ensemble variance instead of realised residual |
| Prediction-error replay priority `\|δ\|` ([[wiki/concepts/replay-prioritisation.md]]) | **NM** applied to rehearsal rather than action | Same quantity, different consumer — and it works in one job and not the other |
| Count-based / pseudo-count bonuses | **UM** | Yes, `r ∝ 1/P(e)` is the count bonus |
| Human learning-progress estimates (Ten et al. 2021, queued) | **LPM / CPM** | The measurement this page's central claim needs |
| Empowerment `C(A_t → S_{t+1})` (Salge et al., queued) | **no cell** | Task-independent *control* capacity, model-free and goal-free — a competence-family quantity computed without episodes. The typology's clearest missing row |

**Two named non-identities the wiki has been sliding over.** (i) *Novelty* is at least three quantities — rarity under a distribution (UM), prediction error (NM), and violation of a strong expectation (DSM) — which come apart exactly where the wiki's ablations live: under a flat predictive distribution UM and NM are maximal and DSM is near zero. (ii) *Progress* is two quantities, over predictions (LPM) and over achievements (CPM), and the paper's argument that they dissociate is the same one [[wiki/concepts/epistemic-value.md]] reports as a measurement — the agent that models the environment best takes random actions and scores at chance.

---

## What the typology recommends, and on what evidence

**Heterostatic + adaptive is the only combination with both high exploration potential and high organisation potential** — IGM, LPM, CPM. The supporting result is outside this paper (the Playground Experiment, Oudeyer et al. 2007): LPM plus an adaptive region-splitting mechanism, given only an *unlabelled* list of sensors and motors, self-organises a staged developmental trajectory — body babbling → focused play with individual body parts → actions toward objects → action–object affordances. That is the wiki's only claim of a *stage sequence emerging from a reward function*, and it is the strongest available argument that an intrinsic reward can substitute for a designed curriculum ([[wiki/concepts/curriculum-learning.md]]'s `λ` set by the learner's own competence frontier, which that page lists as missing).

**The caveat the paper puts first:** the typology classifies *mechanisms*, not behaviours, and the same intrinsic motivation in a different body or environment produces a different developmental trajectory. Embodiment is a free variable that the formalism deliberately separates out and does not control.

---

## Open problems

- **Nothing selects among the formulas.** A dozen rewards, one qualitative table of guessed exploration/organisation potential, and no quantity that says which to run in a given environment. `G30` restated inside the curiosity literature.
- **Every progress-based model needs a region partition it does not define.** LPM, CM and the robust form of FM all require an incremental `{ℛ_n}`; the alternative is a hand-set threshold (`ILNM`, `σ_g`, `T_f`). The comparison class *is* the algorithm, and the typology leaves it to a citation.
- **The competence family's goal space is unconstrained.** Any sensorimotor configuration may be a goal, so a self-set goal carries no guarantee of being reachable, meaningful, or on a path to anything — which is the half of `G72` the family does not answer while appearing to.
- **Distributional models are intractable in continuous spaces**, by the authors' own admission, which is where every model in the wiki lives.
- **Rewards arrive only at episode end in the competence family**, so the credit-assignment problem inside an episode is handed to `KH` with no intrinsic signal to help it — the pseudo-reward this typology could have defined and does not (`G33`).
- **The typology has no cell for control capacity.** Empowerment, mutual information between actions and future states, and every "keep your options open" objective are competence-like but need no goals and no episodes. Either the family is broader than the paper's architecture or these belong in a fourth family.
- **Every reward in the typology is an additive term on the objective, and biology has at least one that is not.** Cue–reward uncertainty does not enter behaviour as a bonus consumed by the planner: it raises the *motivational multiplier* on the uncertain cue (a 50%-predictive cue draws more approach than a 100%-predictive one) and sensitizes the mesolimbic system the way intermittent drug exposure does, so the elevation **outlasts the uncertainty** that produced it ([[wiki/concepts/incentive-salience.md]], Robinson & Berridge 2025). UM's `r(e) = C/P(e)` and this quantity agree at the moment of measurement and diverge afterwards, which is a free discriminating experiment: make the contingency deterministic, then test pursuit of the cue's target.
- **Permutation invariance may be too strong a criterion.** It excludes every homeostatic drive, including the ones biology uses to bootstrap value ([[wiki/concepts/homeostatic-need-signal.md]]), and an agent whose interoceptive channels are *not* interchangeable with its exteroceptive ones is the normal case rather than the exception.

---

## Connections

- **[[wiki/concepts/epistemic-value.md]]** — the measurement half of this map: its E3 is this page's IGM and its ablations are the only evidence in the wiki that any cell of the typology pays, while its E2/E4 have no cell here at all because the typology scores the observable flow rather than a belief over a hidden state.
- **[[wiki/concepts/expected-free-energy.md]]** — one specific point in the space, reached by derivation rather than by choice: a preference term plus a state-entropy term, which places it between UM and IGM and gives it a weight nothing in this typology can supply, since the typology offers no principle for combining two intrinsic rewards.
- **[[wiki/concepts/curriculum-learning.md]]** — the stage sequence this page's recommended cell produces without a teacher: LPM plus region splitting generates its own easy-to-hard ordering from an unlabelled sensorimotor list, which is exactly the self-paced `λ` that page lists as its central missing piece.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the competence family *is* an option-discovery scheme in disguise: the goal-reaching episode is an option, the abstract clock `t_g` is the semi-Markov clock, and the intrinsic reward is a score on the option's own termination rather than on environment reward.
- **[[wiki/concepts/incentive-salience.md]]** — the same uncertainty quantity entering by a different door: not an additive bonus on the objective but a cue-addressed motivational gain with its own slow plasticity, which produces a residue after the uncertainty is resolved that no formula in this typology can express.
- **[[wiki/concepts/replay-prioritisation.md]]** — the same predictive-novelty quantity (NM) consumed by a different module; the wiki's record is that it works as an action bonus and fails as a rehearsal priority, which the typology cannot express because it defines rewards without saying what reads them.
- **[[wiki/concepts/homeostatic-need-signal.md]]** — the boundary case the exclusion test cuts off: a need signal is internal, adaptive and homeostatic but defined over a named channel, so it is extrinsic by this page's criterion while being the biological source of value the intrinsic formulas have to sit alongside.
- **[[wiki/concepts/general-danger-channel.md]]** — the sign problem the typology never raises: every novelty cell here rewards the unfamiliar, and the measured biological response to an unfamiliar food or object is the *threat* channel (`T358`), so UM and NM may have the wrong sign in the one system that is known to develop.
- **[[wiki/concepts/latent-graph-discovery.md]]** — what each family would discover: knowledge-based rewards drive toward edges the model gets wrong, competence-based toward edges the agent can traverse on demand, morphological toward edges that show up as raw cross-channel dependence — three different partial orders over the same graph, and no result says which recovers it fastest.
- **[[wiki/concepts/reward-prediction-error.md]]** — where these rewards would enter: every formula here is a definition of `r`, deliberately agnostic about the learning algorithm downstream, which is the same separation that lets an intrinsic reward reuse the whole dopaminergic machinery unchanged.
- **[[wiki/concepts/divergence-objectives.md]]** — the choice this page's IGM cell hides: "decrease in uncertainty" is a directed quantity, and the four defensible readings of that KL are four different curiosity drives.
- **[[wiki/concepts/information-sampling-vs-search.md]]** — the problem statement this typology is a list of answers to, and the justification it gives them: intrinsic rewards are proposed there as *heuristics for a computational-complexity problem* (a normative theory does not distinguish two alternatives from 2¹⁰⁰) rather than as approximations to any single objective, which is what licenses a dozen non-commensurable formulas at once — and it adds the human measurement this page's LPM/CPM cells needed, free play settling at 70–80% correct with no instructions (Gottlieb & Oudeyer 2018).
