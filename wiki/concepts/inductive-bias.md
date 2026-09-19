# Inductive Bias

**A learner's bias *is* its hypothesis space `H`: the set of functions it will consider at all. Everything the wiki calls "adding a bias" — an architecture, a typed channel, a regulariser, a sampler — is a move that shrinks or reshapes `H`, and the cost of that move is a sample-complexity quantity that can be written down.**

The wiki used the phrase on 37 pages before it owned it. This page is the artefact: Baxter 2000 (`raw/baxter-2000-model-of-inductive-bias-learning.md`, JAIR 12:149–198) is the one source that makes bias a **measurable** object with a price in tasks and examples rather than a rhetorical label attached to a design choice.

> **Provenance.** Converted from PDF (`LOSSY`); asymptotic statements below are taken from the paper's own Conclusion and §3.3.3 discussion, which survive conversion intact. The explicit constants in Theorems 2, 4 and 8 did not, and are given here in structural form only. Check against arXiv:1106.0245 before quoting a constant.

---

## The formal object

Ordinary PAC learning *takes* `H` as given; it therefore has no model of bias at all. Baxter's move is to hand the learner a **family** `H = {H}` and an **environment** of related tasks to choose from.

| Object | Definition | Reading |
|---|---|---|
| **Task** | `P`, a distribution on `X × Y` | One learning problem |
| **Environment** | `(P, Q)` — `Q` a distribution over the set `P` of all tasks | What the learner is embedded in. A face-recognition `Q` is peaked over face-recognition problems |
| **Hypothesis space family** | `H = {H}`, each `H` a set of `h : X → Y` | The candidate biases. Its structure is the **hyper-bias** |
| **Bias loss** | `er_Q(H) = ∫_P inf_{h∈H} er_P(h) dQ(P)` | Small only if, with high `Q`-probability, `H` contains a good solution to a task drawn at random |
| **`(n, m)`-sample** | `n` tasks from `Q`, `m` examples from each | The bias learner's data — two axes, not one |
| **Capacity** | `C(ε, H)`, `C(ε, H_l^n)` — covering numbers of the family | The bias-learning analogue of VC dimension; what the bounds are stated in |

The definition does the work: **`er_Q(H)` measures how appropriate a bias is for an environment**, so "is this a good inductive bias?" stops being a matter of taste and becomes a quantity with an estimator (`êr_z(H)`, the empirical version on the `(n,m)`-sample).

---

## The three results the wiki should carry

**1. Meta-generalisation is provable.** (Theorem 2) With `H` permissible and both `n` and `m` large enough — `n` controlled by `log C(ε, H)`, `m` by `log C(ε, H_l^n)/n` — every `H ∈ H` satisfies `er_Q(H) ≤ êr_z(H) + ε` with probability `1 − δ`. A hypothesis space that performs well on enough *training tasks* is likely to contain good solutions to *novel tasks from the same environment*. Both axes are required: enough tasks to pin down the environment, enough examples to pin down each task.

**2. The per-task sampling burden falls with the number of tasks, and never rises.** (Theorem 4, Lemma 5) The bound on `m` depends *inversely* on `n`, and `log C(ε, H_l^1) ≤ log C(ε, H_l^n) ≤ n · log C(ε, H_l^1)` — so the capacity term can never grow fast enough to make multi-task learning worse. Range of outcomes: from no improvement at all to a full `O(1/n)` decrease.

**3. For feature learning the constant is nameable, and the bound is tight.** Specialise `H = {G ∘ f : f ∈ F}` — a fixed read-out class over a learned feature map. With `k` features and `W` feature-map parameters:

| Quantity | Bound | Reading |
|---|---|---|
| Examples **per task** | `m = O(k + W/n)` | Decays to `O(k)` — the cost of learning a task when the *correct* features are already known |
| **Number of tasks** | `n = O(W)` | Upper bound only; no matching lower bound was proved |
| Boolean linear-threshold case | `d_H(n) = Θ(W/n + k)`, upper `≤ 2(W/n + k + 1) log₂(2e(k+l+1))`, lower `≥ ½(W/(2n) + k + 1)`; necessity of `m` within a `log(1/ε)` factor (Theorems 14–16) | `m = O(k + W/n)` is **not** an artefact of the proof technique |

**The engineering statement.** Fix `ε, δ`. Learning a *good bias* costs `O(W)` tasks; once it is learnt, a novel task costs `O(k)` examples — estimate the read-out only. So: **the surcharge for learning your own features instead of being handed them is `W/n` examples per task, and it goes to zero.** And because a useful feature map must be large enough to *contain* the unknown good features, `W ≫ k` is the normal case — which is exactly the regime where `O(k + W/n)` improves fastest with `n`. Feature learning is the ideal application of bias learning on the example axis and the worst on the task axis.

---

## What this converts, elsewhere in the wiki

| Wiki claim | Restated in this page's currency |
|---|---|
| [[wiki/concepts/shortcut-learning.md]]'s four levers (architecture, data, loss, optimisation) | Four routes for *choosing an `H`*. The page's control surface is a list of ways to move inside `H`; this page supplies the axis the move is priced on |
| [[wiki/concepts/meta-learning.md]]'s `p(T)` | Exactly `Q`. Theorem 2 is the sample-complexity statement of what the outer loop buys, and the knowledge-boundedness limit is `er_Q` being an average over `Q` and nothing else |
| [[wiki/concepts/disentanglement.md]] Theorem 1 ("biases on model **and** data") | The model-side bias is `H`; the data-side bias is `Q`. Baxter's theorem needs both to be non-trivial and quantifies each separately (`C(ε,H)` and the `n` tasks drawn from `Q`) |
| [[wiki/concepts/three-component-framework.md]]'s genome bottleneck | A budget on `log C(ε, H)` — the description length of the *design*, which is the term Theorem 2's task-count bound is stated in |
| [[wiki/concepts/universal-induction.md]]'s `K(µ)` | The uncomputable limit of the same quantity. Baxter's capacity is `K(µ)` made finite and estimable at the cost of losing dominance |

**A multi-class classifier is not a bias learner.** Baxter's sharpest architectural point: `n`-way face recognition and "learn features that let *any* new face be separated from the rest" are different problems that look identical from the loss. Theorem 8 specialises to the known parameter-counting bound (`mn = O(nk + W)`) in the first case, but only the second licenses using the features on an unseen task — and only if `n` was large enough. **Features learnt on too few tasks implement idiosyncrasies of those tasks rather than invariances of the environment, and nothing in the training loss distinguishes the two cases.** That is the identifiability worry of [[wiki/concepts/objective-identifiability.md]] arriving with a sample-size threshold attached.

---

## The regress, and where the theory stops

- **The hyper-bias is given.** `H`'s own structure is fixed a priori and is not learned. This is the third level [[wiki/concepts/meta-learning.md]] names as its central open problem, reached independently from the sample-complexity side; Langford 1999 is cited for deeper hierarchies, and "to what extent the hierarchy can be inferred from data" is left open — the author himself relates it to induction of structure in graphical models, i.e. to [[wiki/concepts/latent-graph-discovery.md]].
- **Task relatedness is not defined except relative to `H`.** Whether a task "belongs with" the others is meaningless absolute — if `H` contains every hypothesis space, all tasks are related. So there is no substrate-free notion of a task family, and grouping too broadly is empirically damaging (the author cites Caruana 1997).
- **The task-count bound is loose and known to be.** The author's own counter-evidence: features with *several hundred thousand* parameters, trained on **400** Japanese characters, transferred to ~2,600 unseen characters. `O(W)` predicts far more tasks. Diagnosis offered: the bound is insensitive to the size of the read-out class `G`. No lower bound on `n` was obtained. **So the wiki's one quantitative handle on "how many tasks install a bias" is an upper bound that overestimates by ~3 orders of magnitude in the only case it was checked against.**
- **`er_Q` is an average.** A bias with small `er_Q(H)` can still be terrible on particular tasks; the only control is Markov's inequality on `er_Q`. There is no per-task guarantee, which is precisely the failure mode [[wiki/empirical-tensions.md]] `T202` measures — a sampled bias reproducing a population statistic while mis-applying it on individual contexts.
- **The bounds scale as `1/ε²`**, improving to `1/ε` only in the realizable case (`êr_z(H) = 0`) or for relative deviation.

---

## Open problems

- **Nothing in the wiki reports `C(ε, H)` for any architecture it proposes.** Every "this architecture has the right inductive bias" claim on the 37 pages is untested against the one criterion that would make it checkable: does `er_Q(H)` fall on tasks drawn from `Q` and never trained on? **(brainstorm)** The cheap version is a protocol, not a theorem — hold out whole *task families*, not items, and report the held-out-family curve as a function of `n`. No wiki entity does this; held-out *episodes* from the same sampler (which [[wiki/entities/mlc.md]] does) measure the inner level only.
- **`O(k + W/n)` is a design target, not just an analysis.** It says where to spend: if the read-out is fixed (`k → 0` effectively), per-task cost decays as `O(W/n)`; if the feature map is deleted (`W = 0`), multi-task learning buys nothing. An architecture that wants to profit from a task family must put its shared structure in `f` and keep `G` small — the formal version of "the interface between the shared module and the task head should be narrow".
- **Where does `Q` come from?** Baxter assumes it and so does every meta-learner in the wiki. The three sources of a task distribution actually used — hand-authored samplers, natural environment statistics, adversarial generation — have never been compared on the quantity that matters here, which is coverage of the environment the learner will be deployed in (`G66`).
- **Is the environment's *own* structure learnable?** If `Q` has structure (tasks are themselves graph-structured, e.g. a hierarchy of related families), Theorem 2 ignores it — the bound treats `n` i.i.d. draws. The gain from exploiting relatedness *among the training tasks* is unbounded and unaddressed.

---

## Connections

- **[[wiki/entities/waterbirds.md]]** — the demonstration that shrinking `H` is not by itself a bias *toward* anything: an `ℓ2` penalty leaves the objective to decide which solution is surrendered, and the identical penalty lands Waterbirds' worst group at 84.6 under a max-over-groups objective and 21.3 under a mean one that scored 60.0 unpenalised.
- **[[wiki/concepts/meta-learning.md]]** — the same two-level object from the optimisation side rather than the statistical one: `p(T)` is `Q`, the inner loop searches `H`, and this page supplies what that page's objective does not — the number of tasks and examples per task that make the outer loop's product generalise to a *novel* task (Baxter 2000).
- **[[wiki/concepts/universal-induction.md]]** — the same bias-as-hypothesis-space idea with the family taken maximal: `ξ` is the bias that needs no environment because it dominates every computable one, and the price is uncomputability; Baxter's `C(ε, H)` is the finite, estimable stand-in for `K(µ)`, and the arbitrary choice of `H` here is the arbitrary choice of reference machine `U` there.
- **[[wiki/concepts/shortcut-learning.md]]** — that page enumerates the four places a bias can be inserted; this one says what inserting it costs and what it must be validated against, converting "choose the right invariances" from a prescription into a measurement with two sample axes.
- **[[wiki/concepts/disentanglement.md]]** — the impossibility theorem's two required biases land on this page's two objects: the bias on the model is `H`, the bias on the data is `Q`, and Baxter's `(n,m)`-sample is what a procedure would need to *learn* the first from the second rather than assume it.
- **[[wiki/concepts/objective-identifiability.md]]** — supplies the missing sample-size side of that page's demand to "specify the inductive biases": a feature set learnt on too few tasks encodes idiosyncrasies indistinguishable, under the training loss, from environment invariances, so "which bias carried this tuning curve" is unanswerable below a task threshold nobody reports.
- **[[wiki/concepts/three-component-framework.md]]** — the framework's architecture/objective/learning-rule slots are three constructions of `H`, and its genome-bottleneck argument is a budget on `log C(ε, H)`; this page's `n = O(W)` says what the evolutionary outer loop would have had to sample to install a bias of that size.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the meta-graph/instance-graph split with a proof attached: `H` is the meta-graph, `h ∈ H` the instance, and the `O(k + W/n)` result is the framing's sample-budget argument made exact for the feature-learning case.
- **[[wiki/concepts/core-knowledge.md]]** — the limit of an environment sampled over evolutionary time: core systems are an `H` that was selected rather than estimated, which is why no `n` appears in the runtime cost of instantiating one.
- **[[wiki/concepts/environment-invariance.md]]** — the same multi-environment signal spent on a penalty rather than on a hypothesis-space search; both need several environments, but invariance methods get a representation directly while bias learning returns a *space* that a per-task learner must still search.
- **[[wiki/entities/mlc.md]]** — the wiki's most explicit `Q`, and the case that shows what this page's guarantee does and does not cover: its held-out episodes are new draws from the same sampler (inside `er_Q`) and pass, while a facet the sampler never varied fails at 100% — an `er_Q` that is small over the wrong `Q`.
- **[[wiki/concepts/structural-learning.md]]** — the experimental counterpart of `Q`'s support mattering more than its mean: a task family sampled symmetrically about the identity installs a bias that `E[T]` cannot contain, which is `er_Q(H)` being sensitive to the *set* of tasks in the environment and not to their average (Braun et al. 2009).
- **[[wiki/concepts/program-induction.md]]** — a domain-specific language is an `H` written by hand; this page prices the alternative of estimating one, and the `O(W)` task count is why hand-authoring a DSL is still usually cheaper.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — scores the conversion of priors and experience into skill; this page names the two experience axes that conversion runs over (`n` tasks, `m` examples each) and shows they are not interchangeable, which a single "experience" term hides.
- **[[wiki/concepts/continual-learning.md]]** — the same task sequence read for retention rather than for bias: Baxter's `n` tasks are sampled i.i.d. and simultaneously available, so his guarantee is silent about the order they arrive in and about anything being forgotten.
- **[[wiki/concepts/curriculum-learning.md]]** — what happens when Baxter's environment `Q` is made a function of training time: the bounds here are silent about order, and a curriculum's whole claim is that annealing `Q_λ` to `Q` is worth points at fixed `H`, fixed data and fixed capacity — so the two accounts of "where the bias comes from" do not compose and neither subsumes the other.

- **[[wiki/entities/ligo.md]]** — the same bias-as-restricted-family argument applied to a map between *parameter* spaces rather than to a hypothesis class: an unrestricted growth operator lives in `R^{L₂D₂² × L₁D₁²}` and is unlearnable, and the single assumption that layers and neurons are the groups (a Kronecker factorisation) collapses it to `O(L₁L₂ + L₁D₁D₂)` parameters fitted in 100 minibatches — a bias that buys sample complexity by naming a symmetry, with the sample-complexity saving measured directly as FLOPs.
- **[[wiki/entities/varc.md]]** — the wiki's cleanest empirical price list for this page's object: on a fixed 18M ViT and a fixed data budget, visual priors are added one at a time (1D→2D positional embedding, 1×1→2×2 patchification on a larger canvas, translation augmentation, scale augmentation) for **+27.7 points** on ARC-AGI-1, with the largest single item (+6.2) being *scale* — precisely the invariance the architecture has no structural claim on, which is `er_Q(H)` reduced by data where it cannot be reduced by `H`.
- **[[wiki/entities/vdm-i2i.md]]** — the complement to VARC's price list: instead of pricing each prior by adding it one at a time, it prices a whole *delivery mechanism* (a video pretraining corpus) by the downstream examples it saves, and finds the saving indexed to the input's dimensionality — null on 1D cellular automata, large and horizon-growing on 2D ones.
