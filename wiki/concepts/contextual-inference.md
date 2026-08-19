# Contextual Inference

**One posterior over "which context am I in" simultaneously controls memory *creation*, *expression* and *updating* — so a change in behaviour decomposes into two mechanisms that no adaptation curve can separate: *proper* learning (a stored state changed) and *apparent* learning (only the weights on unchanged stored states changed).**

Source: Heald, Lengyel & Wolpert 2021 (Nature), which formalises the principle as the COIN model ([[wiki/entities/coin-model.md]]) and tests it on human sensorimotor adaptation. The claim is explicitly domain-general — the authors close by saying the proper/apparent distinction "is likely to be relevant to all forms of learning in which experience can be usefully broken down into discrete contexts".

**Two independent instantiations, two domains, two read-outs.** Heald et al. 2021 read the posterior off *behaviour* (motor output as a mixture); Sanders, Wilson & Gershman 2020 read it off *neural population code* — hippocampal place-field remapping as the expression of a posterior over which hidden state generated the current observations ([[wiki/entities/hidden-state-inference-remapping.md]]). Same nonparametric prior family, same allocate-vs-reuse logic, arrived at independently in sensorimotor adaptation and in place-cell physiology. That convergence is the strongest evidence the wiki has that contextual inference is a general operation rather than a fit to one paradigm.

For the wiki this is the **retrieval-and-allocation policy** the graph framing has been missing: contexts are nodes of a rule-graph, the posterior over them says which stored meta-graph fragment is live, and a nonparametric prior says when to allocate a new one.

---

## The three operations, one computation

Let `c_t` be the (unobserved, discrete, unbounded) context at time `t`, `q_t` a sensory cue, `y_t` state feedback obtained *after* acting.

| Operation | Driven by | Timing | Formal statement |
|---|---|---|---|
| **Expression** | *predicted probability* `p(c_t = j ∣ q_t, …)` — posterior after the cue, **before** feedback | pre-action | output is a probability-weighted **mixture** of all memories, not a selected one: `u_t = Σ_j p(c_t=j∣q_t,…) · E[x_t^(j)]` |
| **Creation** | *responsibility* of the **novel** context `p(c_t = ∅ ∣ q_t, y_t, …)` | post-feedback | a new memory is instantiated with probability equal to that responsibility, initialised from the novel context's stationary state distribution |
| **Updating** | *responsibility* of each known context | post-feedback | **every** memory updates, each by its own Kalman gain **scaled by its responsibility**: `Δmean_j ∝ λ_j · k_j · e_j` |

The two probabilities differ only in what has been conditioned on: expression uses cue evidence alone (you must act before you learn the outcome), creation and updating use cue **and** feedback. Everything else — savings, interference, recovery — falls out of the dynamics of that single posterior.

---

## Proper vs. apparent learning

| | **Proper learning** | **Apparent learning** |
|---|---|---|
| What changes | the inferred state `x^(j)` of a memory | the predicted probabilities `p(c_t = j ∣ …)` |
| Classical reading | "learning" | also read as "learning", wrongly |
| Rate parameter | Kalman gain `k_j` (a real learning rate) | none — no memory is touched |
| Reversible in one trial | no | yes (evoked recovery) |

Heald et al. reproduce **savings**, **anterograde interference** and the **environmental-consistency effect on single-trial learning** with parameters fit to *other* experiments (parameter-free predictions), and show that in all three the Kalman gains and underlying states are essentially unchanged — the entire effect sits in the context probabilities. Three canonical "learning rate" findings are therefore **not** findings about learning rate.

**Consequence for this wiki (gap G17).** Any curve of behaviour-vs-trials — motor adaptation, few-shot fine-tuning, in-context learning — confounds "the model acquired structure" with "the model re-weighted structure it already had". An evaluation that reports only the curve cannot tell a learner from a retriever ([[wiki/empirical-tensions.md]] T24). **(brainstorm)** The experimental cure is the one used here: insert a single unambiguous context-signalling trial (an *evoker*) and see whether behaviour jumps. A jump larger and more persistent than any plausible one-trial update is apparent learning by elimination — a cheap, general probe applicable to an in-context-learning model as easily as to a hand at a manipulandum.

---

## Where new memories come from

The generative model puts a **sticky hierarchical Dirichlet process** on context transitions (details on [[wiki/entities/coin-model.md]]). Three hyperparameters do work no other mechanism in the wiki does:

| Hyperparameter | Controls | What it buys |
|---|---|---|
| `γ` (GEM concentration) | rate of decay of global transition probabilities | the **effective number of contexts** — small `γ`: few, high-probability contexts; large `γ`: many rare ones. A granularity knob |
| `κ` (self-transition bias) | probability mass on `c_t = c_{t−1}` | contexts *persist*: the prior that the world does not re-roll its rules every step |
| `α` (DP concentration) | how much each context's local transition row resembles the global row `β` | the **two-level split**: `β` is shared across contexts (meta), `π_j` is per-context (instance) |

This answers the open problem left standing on [[wiki/concepts/event-segmentation.md]] — "the compression criterion is unspecified: no clustering objective, no granularity control, no stopping rule". Here all three are one prior, and the allocation decision is a probability rather than a threshold. It also produces a non-obvious empirical prediction that holds: a perturbation introduced **abruptly** creates a new memory, the **same perturbation introduced gradually does not** (existing memories can absorb it), which is why deadaptation after gradual introduction is slower.

**The boundary detector is the posterior.** Contrast the two accounts the wiki now carries:

| | Butz 2016 ([[wiki/concepts/event-segmentation.md]]) | Heald et al. 2021 |
|---|---|---|
| A boundary is | a lasting change in the active set of predictive encodings | a shift of posterior mass to a different (possibly new) context |
| Detector | hand-set thresholds, or LSTM gates trained by backpropagation through time | Bayes' rule under a nonparametric prior |
| Granularity set by | unspecified | `γ`, `κ`, `α` |
| Handles noise-vs-boundary | "a precision judgement the theory does not specify" | the likelihood ratio *is* the precision judgement |
| Scales to | rich multimodal streams (in principle) | a scalar state per context (in fact) |

They are not rivals so much as the same idea at opposite ends of the expressiveness/principle trade: one has the representation and no criterion, the other has the criterion and no representation.

---

## Uncertainty is the observable, not the winner

The hippocampal instantiation adds something the motor one could not: a *population* of units expressing the same posterior, so posterior **uncertainty** becomes directly measurable rather than inferred from a fitted model.

| Log posterior odds between "same state" and "new state" | Neural signature (Sanders et al. 2020) |
|---|---|
| strongly positive | no remapping |
| weakly positive | rate remapping |
| **≈ 0** | **partial remapping, and maximal heterogeneity across cells** |
| strongly negative | global remapping |

The field's four categories of remapping are therefore one axis. Two consequences the wiki should carry:

1. **A graded population response is not a failure to decide — it is the decision.** Where a winner-take-all account reads heterogeneity as noise or as incomplete convergence, this reads the *spread* across units as the width of the posterior. Sanders et al. formalise it with a Beta distribution over per-unit modulation whose parameters are set by the evidence ratio, which predicts (and matches the literature's rank-orderings) that extent of rate remapping and fraction of fully-remapped units move together, and that heterogeneity peaks at the point of maximal uncertainty.
2. **(brainstorm) The machine analogue is a mixture-of-experts router that is scored on its entropy, not its argmax.** If a library of stored structures is queried by responsibility, then the *dispersion* of the routing weights across a population of read-out heads is an unlabelled runtime estimate of "am I in a situation my library covers?" — the same self-supervised signal [[wiki/concepts/pattern-separation-completion.md]] wants for gap G38, obtained without a completion-error measurement.

**A learning curve cannot tell you which regime generated it.** Sanders et al.'s cleanest simulation: observations drawn from *one* Gaussian and observations drawn from *two* well-separated Gaussians produce indistinguishable early evidence ratios, and only extended experience separates them. Early in training the learner does not know which world it is in — so map *stabilisation* (Law et al. 2016) and map *divergence* (Lever et al. 2002) are the same computation run against opposite ground truths. This is the neural counterpart of the proper/apparent warning above: the early portion of any adaptation curve is uninformative about the structure being acquired.

## Tolerance is set by past variance, not by similarity

The posterior predictive of a state widens along whatever feature has *varied* within that state. Hence Sanders et al.'s novel prediction: an agent trained with high variability in feature 1 will **not** allocate a new context when feature 1 takes a novel value, while an agent trained with low variability in the same feature will. Independently confirmed in a contemporaneous preprint (Plitt & Giocomo 2019).

This is the sharpest available discriminator between a generative-model account of retrieval and any similarity-threshold or similarity-recall account ([[wiki/entities/temporal-context-model.md]]): similarity is symmetric in the features, a learned generative model is not. **(brainstorm)** For a machine store it prescribes per-feature, per-context tolerance learned from within-context variance — the retrieval analogue of a Mahalanobis rather than Euclidean metric, and a cheap defence against the anchoring-side shortcut failure named on [[wiki/concepts/cognitive-map.md]]: a feature that has historically moved around should not be allowed to trigger a new allocation.

## Two evidence channels, fused

Context evidence arrives in two forms with different timing and different reliability:

- **Sensory cues** `q_t` — available before acting, so they are the only thing expression can use. Cheap, but a cue only indicates a context to the extent it has been *paired* with it.
- **State feedback** `y_t` — available only after acting. Directly diagnostic of the dynamics.

Heald et al. put them in conflict (the light-but-large-cup manipulation) and measure single-trial learning of one memory under all four cue×perturbation combinations. Result: graded updating, with **both** channels significant and additive (cue `F(1,23)=10.35, p=3.8×10⁻³`; perturbation `F(1,23)=21.16, p=1.26×10⁻⁴`; no interaction), and **no** gradation before training — the gradation is *learned*, not built in. Feedback outweighed the cue, as predicted, because washout trials had paired both cues with the null field and thereby degraded their diagnosticity.

This is direct evidence against winner-take-all retrieval: **all** stored structures update on every trial, in proportion to how much they explain the observation.

---

## What this contributes to the core framing

| Wiki claim | What contextual inference adds |
|---|---|
| G37 — nothing decides which stored structure applies | A graded posterior over a growing library, computed from `p(cue∣context) × p(context∣previous context) × p(feedback∣context state)`. Compare [[wiki/concepts/subgraph-matching.md]]: that answers *does this pattern occur here* geometrically and deterministically; this answers *which of my models is generating this* probabilistically and sequentially. They are the structural and the statistical version of the same retrieval step |
| G27 — nothing supplies the discretisation | A stopping rule and a granularity knob for node creation, at the cost of assuming the within-node state is a scalar |
| Hardness 6 — non-stationary topology | `c_t` **is** the "rule-config" the lifting argument asks for, made a first-class latent with its own Markov dynamics. A rule change is literally an edge in a rule-graph — the reification gap G8 wanted, implemented and fit to data (in a scalar world) |
| G1 — two-level separation | The hierarchical Dirichlet process is the hierarchy: global `β` pooled across contexts, local `π_j` per context, coupled by `α`. Same shape as [[wiki/entities/hbtom.md]]'s hyperprior, again hand-written rather than discovered |
| Continual learning's task-boundary problem | Dissolved: boundaries are not needed as input, they are the thing being inferred. And responsibility-scaled updating is **relevance**-gated plasticity rather than **importance**-gated (elastic weight consolidation) — protection comes from a memory not being responsible for the current data, which needs no Fisher matrix and no task label |
| Working memory | Heald et al. identify working memory with **maintenance of the current context probabilities** — a distractor task disrupts them and thereby produces evoked recovery. That gives fast **M** a specific content: not the instance-graph itself, but the *mixing weights over stored graphs* |

---

## The posterior has a measured format, and the format is what predicts the behaviour

Courellis et al. 2024 record human hippocampal single units during an uncued serial reversal task whose two stimulus–response–outcome maps are exact inversions, so one negative feedback licenses a full one-shot flip — the discrete-context case this page formalises, with the posterior collapsing on a single observation.

| Finding | Consequence for this page |
|---|---|
| The latent context becomes a **coding direction in population space that is parallel across stimuli** (rising CCGP and parallelism score), only in sessions where participants actually perform the inference | The posterior over `c_t` is not merely decodable — it is *disentangled from content*, which is what allows one readout learned on some stimuli to apply to the rest. The one-shot flip needs precisely that: the evidence arrives at one stimulus and must move the response for the three not yet seen |
| Context decodability itself barely moved (0.63 → 0.67, n.s.) between inference-absent and inference-present sessions | **A context signal can be present and useless.** The wiki's reading of remapping ([[wiki/entities/hidden-state-inference-remapping.md]]) has been that expressing the posterior is the operation; this says expression is necessary and not sufficient, and the sufficient condition is a geometric one |
| Error trials inside inference-present sessions look like inference-absent sessions | The posterior's format tracks behaviour at single-trial resolution, which is the tightest coupling available short of intervention |
| A ~4-minute **verbal description** of the latent structure produced, in patients who then began performing inference, a context geometry indistinguishable in parallelism from that of patients who discovered it themselves — while a third of patients received the same instruction and changed neither behaviour nor code | Two routes into the same posterior representation: sequential evidence accumulation, and being *told the partition*. Neither COIN nor the remapping account has any channel for the second (gap G45) |

**(brainstorm) The exportable claim: a responsibility vector is not enough — it must be a *reusable* one.** A mixture-of-experts router that emits `p(c)` per situation satisfies this page's formalism and would fail the geometric test if its context direction is entangled with input content, because the routing learned on one input family would not transfer to another. The measurement is available: enumerate a condition grid, train the router's context readout on one slice, test on the others. That converts "does the system infer context" from a fit statistic into a generalization test, and it is the only test here that a well-fit but content-entangled router fails.

## The posterior is causally necessary, and dopamine is its consumer

Mishchanchuk et al. 2024 (*Science* 386:926-932) supply the two things every account on this page was missing: an **intervention** showing the context posterior is required for the behaviour, and an identified **downstream reader** of it. Mice run an operant 2-armed bandit (70% / 10%, contingency reversed after 10-32 high-probability choices); the latent context is which lever is currently high, inferable only from outcomes.

| Evidence | Result |
|---|---|
| **Model comparison** | Every session from every mouse is best fit (Bayesian information criterion) by a state-inference (SI) agent over Q-learning, including Q variants supplemented with counterfactual updating, forgetting and dynamic learning rates. Confirmed by two independent read-outs: switch probability conditioned on the past three choice-outcome pairs, and trial-by-trial choice prediction |
| **The mechanical signature that separates the two** | Q updates the value of the chosen option only, so a Q reward prediction error (RPE) depends on past outcomes of the **same** choice; a belief over context is updated by outcomes of **both** choices. On rewarded switch trials split by whether the previous opposite-lever choice was rewarded, nucleus accumbens (NAc) dopamine (dLight1.1) differs sharply — as SI-RPE predicts and Q-RPE does not, across all same/opposite × rewarded/unrewarded histories |
| **Bilateral vCA1 lesion** (caspase under CaMKII, ventral CA1 pyramidal cells, in trained mice) | Behaviour shifts *from* SI *toward* Q: the SI simulation stops recapitulating switching behaviour, the Q simulation starts to, other strategies barely move, and the effect concentrates around contingency reversals |
| **Unilateral vCA1 lesion + ipsilateral photometry** (behaviour spared by cross-hemisphere redundancy) | NAc dopamine loses its SI-RPE signature almost completely, by both the trial-history and the regression analysis — so the loss is in the *signal*, not a consequence of the animal behaving differently |
| **Miniscope imaging, 592 vCA1 pyramidal neurons, 6 sessions, 3 mice** | ~40% choice-selective, ~20% expected-outcome-selective, ~30% selective for contingency/context irrespective of choice **and** expected outcome. The top three principal components separate the four trial types by choice (PC1), expected outcome (PC2) and context (PC3); all three decode from pre-outcome activity and remain decodable through the inter-trial interval |
| **The context code is abstract** | Decoders trained on one trial type per context (e.g. right-high vs left-high) transfer above chance to the other (right-low vs left-low) — cross-condition generalization in a rodent, over a context defined purely by past probabilistic outcomes ([[wiki/concepts/population-geometry.md]]) |

**Three things this changes for the wiki.**

1. **"Which model is generating this" has a necessary substrate.** The whole retrieval-and-allocation policy (gap G37) has been supported by fits to behaviour (COIN) and by simulations against published place-cell data (Sanders et al. 2020). Here removing one population removes the *strategy*, and the animal falls back to the cached-value alternative rather than becoming incompetent. The posterior is not an epiphenomenal read-out of a decision made elsewhere.
2. **Belief states are what the value system is handed.** The dopaminergic RPE — the wiki's canonical model-free signal — is computed over `b_t(s)` rather than over `Q(a)`, and it stops being so when its hippocampal input is removed. That relocates the model-free/model-based boundary: the cached machinery is intact and merely *state-starved* ([[wiki/concepts/amortized-inference.md]]).
3. **The non-spatial context code looks like the spatial one.** The same population that tiles space tiles the choice × expected-outcome × contingency parameter space of an operant chamber where the animal never moves, and separates the two latent contexts the way it separates two rooms — which is the mechanistic version of the claim [[wiki/concepts/cognitive-map.md]]'s "beyond space" table has otherwise been assembling from blood-oxygen-level-dependent (BOLD) signals.

**The caveat that limits what it evidences.** The fitted SI agent is a **2-state sticky hidden Markov model with fixed cardinality** — a stay-probability `γ`, an observation-compatibility parameter `c` (and a separate `d` for omissions), and softmax steepness fixed at 10 — not a Chinese Restaurant Process or a hierarchical Dirichlet process. The number of contexts is supplied by the experimenter, so this is strong evidence for **belief maintenance over a known context set** and *no* evidence for the allocation half this page leans on `γ, κ, α` for. The best-fitting variant also updates `p(o_t∣s_t)` on **rewarded trials only** (`d = 0`), treating omissions as uninformative — a deliberate asymmetry that buys stability when the correct option pays out only 70% of the time. **(brainstorm)** That asymmetry is worth copying: an evidence channel whose likelihood is flat for the *frequent-but-ambiguous* observation is a one-parameter defence against a posterior thrashing under a noisy reward function, and it is cheaper than tuning stickiness `κ` to do the same job.

---

## Open problems

- **The contexts are atoms — in both instantiations.** Sanders et al. state the same gap independently (no hierarchical inference; nothing lets one map be another map with one feature changed) and point at two places a hierarchy would live in the hippocampus: McKenzie et al. 2014's nested representational similarity within one population, and the dorsoventral gradient of place-field size, which they suggest could be the *same* inference run at several values of `α` in parallel — so two observations share a state at one end of the axis and not at the other, giving partial sharing of learning. Nothing implements it.
- **The contexts are atoms.** Nothing is shared *between* contexts except the transition prior: context 5 cannot be "context 3 with one edge flipped". There is no `g`/`x` factorization inside the library, so the model gets retrieval and allocation right while giving up compositionality ([[wiki/concepts/compositionality.md]]). A repertoire that grows one atom per novel situation is exactly the memorising regime [[wiki/concepts/intelligence-density.md]] scores at `ℐ → 0`.
- **Scalar states.** Each memory holds one number (force-field strength). The whole apparatus is untested where a context's content is a graph, a program, or an image.
- **Exact inference is infeasible**; the COIN fit uses particle learning (sequential Monte Carlo), and Sanders et al. compare only a handful of hand-picked partitions, calling their account "an analytical heuristic rather than an algorithmic theory". **Where the candidate partitions come from is the unsolved step in both.** One concrete neural proposal now exists: represent the posterior by *sampling*, one hidden state per theta cycle, which turns the observed rapid flickering between hippocampal maps into the inference algorithm and predicts that switching rate declines as evidence accumulates ([[wiki/entities/hidden-state-inference-remapping.md]]).
- **Cue vocabulary is given.** `q_t` is a discrete observation from a known alphabet; discovering *what counts as a cue* is the vocabulary problem (hardness 2) and is not addressed.
- **How much is prior, how much is inferred?** `γ`, `κ`, `α`, the state-dynamics prior and the noise variances are fit per participant (7–8 free parameters). The granularity knob is real, but here it is turned by the experimenter's optimiser, not by the learner.

---

## Connections

- **[[wiki/entities/coin-model.md]]** — the model this page abstracts: full generative model, inference scheme, experiments and model comparison.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — the same principle in hippocampal physiology: hidden states are maps, remapping is the posterior's expression, and posterior uncertainty is read directly off population heterogeneity rather than fitted.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the retrieval-and-allocation policy the framing assumes: a posterior over which stored structure is live, and a nonparametric prior deciding when to create a new one; the context variable is hardness source 6's rule-config lifted into an explicit latent.
- **[[wiki/concepts/event-segmentation.md]]** — the rival account of where node boundaries come from: a lasting change in active predictive encodings versus a shift of posterior mass under a sticky nonparametric prior, which supplies exactly the clustering objective and stopping rule that account lacks (tension T23).
- **[[wiki/concepts/continual-learning.md]]** — dissolves the task-boundary assumption and replaces importance-gated plasticity with relevance-gated plasticity: a memory is protected by having low responsibility for the current observation, so no Fisher matrix or task label is needed.
- **[[wiki/concepts/complementary-learning-systems.md]]** — a third answer to the interference problem: rather than one fast store plus one slow store, a *growing set* of slow stores with an inference process deciding which is being written to.
- **[[wiki/concepts/working-memory.md]]** — gives fast **M** a specific content: the mixing weights over stored memories rather than the memories themselves, which is what a distractor task disrupts.
- **[[wiki/concepts/meta-learning.md]]** — the hierarchical Dirichlet process is the outer/inner loop written as a prior: global transition probabilities are the meta level, per-context rows the instance level, and adaptation is conjugate inference rather than gradient descent.
- **[[wiki/concepts/subgraph-matching.md]]** — the structural counterpart of the same retrieval step: containment tested geometrically and deterministically there, generative identity tested probabilistically and sequentially here.
- **[[wiki/concepts/amortized-inference.md]]** — expression is the amortised half (a weighted read-out computed before acting) and updating the deliberative half (after feedback), split by *what has been observed* rather than by compute budget; and the value system is handed the posterior rather than raw observations, since accumbens dopamine carries a belief-state prediction error that disappears when ventral CA1 is lesioned (Mishchanchuk et al. 2024).
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — same residual-driven update, with the residual routed by a discrete latent: prediction error is assigned to contexts in proportion to responsibility instead of being absorbed by one model.
- **[[wiki/entities/hbtom.md]]** — the same two-level Bayesian shape in another domain (hyperprior over agents rather than over contexts), with the same limitation: the hierarchy is authored, not discovered.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — sharpens the measurement problem: an adaptation curve conflates acquiring structure with re-weighting stored structure, so a conversion-rate score computed from a learning curve is only valid if apparent learning has been ruled out (gap G17).
- **[[wiki/concepts/intelligence-density.md]]** — the cost of the atomic repertoire: a system that answers novelty by allocating a new context grows description length with the world, which is the `ℐ(n) → 0` memorising asymptote.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the mechanistic form of the same allocate-vs-reuse decision: a tunable input-similarity transfer curve whose steepness and offset play the role this page assigns to `α` and the new-context prior, with named neuromodulatory controllers for setting them online.
- **[[wiki/concepts/population-geometry.md]]** — supplies the format criterion this page's posterior has to meet: the latent context must be a coding direction parallel across content, and human hippocampal recordings show context decodability rising negligibly while that parallelism (and inference behaviour) appears (Courellis et al. 2024).
- **[[wiki/concepts/cognitive-map.md]]** — splits what this page computes into two: the responsibility posterior answers *which* map (context retrieval), and a retrieved map still has to be oriented — coordinates and heading recovered from present cues — before anything can be read off it (gap G39).
