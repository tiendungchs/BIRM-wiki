# Independent Causal Mechanisms (ICM)

**The generative process of a system is composed of autonomous modules that neither *inform* nor *influence* one another: intervening on `P(Xᵢ|PAᵢ)` leaves every other `P(Xⱼ|PAⱼ)` unchanged, and knowing some mechanisms gives no information about the rest (Schölkopf et al. 2021).**

This is the assumption underneath every invariance method in the wiki, stated as a principle rather than as a trick. [[wiki/concepts/environment-invariance.md]] *enforces* invariance with a penalty and is handed the environment partition; ICM says **why** an invariance should exist in the first place, and its corollary — the Sparse Mechanism Shift hypothesis — is the wiki's first criterion that scores a factorization without needing environments to be labelled.

> **Provenance.** Schölkopf, Locatello, Bauer, Ke, Kalchbrenner, Goyal & Bengio 2021, *Towards Causal Representation Learning* (`raw/scholkopf-2021-toward-causal-representation-learning.md`). A review; the principle is attributed to Haavelmo 1944, Simon's invariance criterion, Aldrich 1989, Pearl 2009, Janzing & Schölkopf 2010 and Peters, Janzing & Schölkopf 2017.

---

## The two factorizations

Given a structural causal model `Xᵢ := fᵢ(PAᵢ, Uᵢ)` over a directed acyclic graph with jointly independent noises `Uᵢ`, the joint admits the **causal (disentangled) factorization**

```
P(X₁,…,Xₙ) = ∏ᵢ P(Xᵢ | PAᵢ)
```

Every other ordering also factorizes — e.g. the **entangled** `∏ᵢ P(Xᵢ | X_{i+1},…,Xₙ)` — and all of them describe the same observational distribution exactly. What separates them is behaviour under change, not fit:

| Factorization | Under an intervention on one physical mechanism | Reusable across domains |
|---|---|---|
| Causal `∏ P(Xᵢ\|PAᵢ)` | **one** factor changes | Yes — the unchanged factors transfer |
| Entangled (any other order) | many or all factors change simultaneously | No |

**The worked case.** Altitude `A` → temperature `T`, measured at weather stations in Austria and in Switzerland. `P(A)` differs sharply between countries; `P(T|A)` is near-invariant because it *is* the physical mechanism. The causal factorization `P(A)P(T|A)` therefore contains a component that generalises across countries; the entangled `P(T)P(A|T)` contains no such component, and the joint `P(A,T)` hides the fact that anything was stable at all. **A factorization is not a bookkeeping choice — it decides whether anything in the model is transportable.**

---

## Sparse Mechanism Shift (SMS)

> **SMS hypothesis.** Small distribution changes tend to manifest themselves in a *sparse or local* way in the causal factorization — they should usually not affect all factors simultaneously.

Read as an objective rather than as a description, this is the load-bearing move of the source for this wiki:

- The correct factorization is the one in which observed shifts are **sparsest**. Sparsity-of-change becomes a *score over candidate factorizations*, computable from a stream that merely contains shifts — no environment labels, no intervention targets, no causal graph.
- The reference illustration: a finger moves and knocks a cube over. In the causal variables, **two** variables change (finger pose, cube pose). In pixel space the change is dense — and if the camera or the lighting moves, *every* pixel changes under a sparse intervention. Sparsity is a property of the representation, so it can be optimised for.
- Ancestry: Simon's invariance criterion (the causal structure is what stays fixed across changing background conditions), and slow-feature analysis (look for what varies slowly). Used since for causal discovery by continuous relaxation of the discrete graph search (Ke et al. 2019), for modular architectures (Goyal et al. 2019), and for disentanglement, where it is **theoretically sufficient given suitable training data** (Lachapelle et al. 2022, as reported).

**(brainstorm) SMS is the missing half of `G6`.** That row is open because invariance methods are handed the environment partition and nothing infers it. SMS inverts the dependency: instead of *given environments, find the invariant representation*, it is *given a representation, count how many factors a shift touches* — a quantity the learner can evaluate on unlabelled non-stationary data. Wiring it to [[wiki/concepts/contextual-inference.md]] (which infers *that* a context changed) would give the partition and the factorization from the same signal. Nothing in the wiki does this, and the source does not do it either — it states SMS as a hypothesis and points at three papers that exploit it in restricted settings.

---

## The algorithmic formulation, and what it buys

The probabilistic statement of "two mechanisms do not inform each other" is awkward, because a deterministic function neither creates nor destroys information. The source's replacement: encode each mechanism as a bit string and require that **joint compression saves nothing relative to independent compression** — vanishing algorithmic mutual information (Janzing & Schölkopf 2010).

| Statistical graphical model | Algorithmic graphical model |
|---|---|
| `Uᵢ` are independent random variables | `Uᵢ` are jointly independent **bit strings** |
| `Xᵢ ~ P(Xᵢ\|PAᵢ)` | `Xᵢ` = output of a fixed Turing machine running program `Uᵢ` on input `PAᵢ` |
| Local + global (d-separation) Markov conditions | Same conditions, provably implied by the SCM |
| Factorization `∏ P(Xᵢ\|PAᵢ)` | **Additive decomposition of the joint Kolmogorov complexity** |
| Independence of noises ≠ independence of mechanisms | The two **coincide** — the independent programs *are* the unexplained noise |

Two consequences the wiki should carry:

- **"Causality is not intrinsically bound to statistics."** The whole apparatus survives with no randomness anywhere, which matters because most of the wiki's targets (a rule, a program, a grammar) are not naturally probabilistic objects.
- **It is the constraint [[wiki/concepts/universal-induction.md]] is missing.** That page's sharpest open problem is *compression ≠ structure*: the shortest program for the data need not expose the factorization (`G26`). Algorithmic ICM does not repair that — it adds a second, independent requirement on top of shortness: the description must **split into parts that do not help compress each other**. Compression alone ranks programs by total length; ICM ranks them by whether the length is *additive over modules*. **(brainstorm)** The wiki has been treating minimum description length as the whole of the simplicity prior; this says the modularity of the code is a separate, orthogonal criterion, and it is the one that predicts transfer. Both are uncomputable, and neither has an approximation in the wiki.

---

## Identification without environments: restrict the function class

Conditional-independence testing needs at least three variables, so the two-variable case (`X → Y` vs `X ← Y`) has no non-trivial Markov implications at all. The source's route out is **not** more environments but a restriction on `fᵢ`:

| Model | Statement | Identifiability |
|---|---|---|
| General `Y = f(X, V)` | `V` selects among `{f_v(·)}`; if `f` depends on `v` non-smoothly, the effective function class is exponential in `\|supp(V)\|` | None from finite data |
| **Additive noise** `Y = f(X) + V`, `X = U`, `U ⊥ V` | motivated by a local Taylor expansion when `f` depends smoothly on `V` and `V` is concentrated | **A distribution generated by an ANM cannot be fit by an ANM in the reverse direction** — the cause/effect symmetry breaks |
| Exceptions | `U, V` Gaussian and `f` linear | Unidentifiable |
| Extensions | nonlinear rescalings, loops, confounders, multi-variable settings | Identifiable under genericity assumptions |

**The design lesson, stated generally.** Statistical learning restricts function classes to make estimation possible; here the same restriction makes the *direction* recoverable. This is a second identification lever alongside environment diversity, and it is cheaper — it needs one distribution rather than `d − r + d/r` of them ([[wiki/concepts/environment-invariance.md]]). Its ceiling is severe and the wiki should record it: methods that classify causal direction pairwise beat chance, and **nobody knows how to lift them to rich hierarchies of latent causal variables**, which is the only case that matters here.

---

## Causal representation learning: the setting

Classical causal discovery assumes the variables are given. The named open problem is what happens when they are not:

```
X = G(S₁, …, Sₙ)         G non-linear, X high-dimensional (pixels), n ≪ d
Sᵢ := fᵢ(PAᵢ, Uᵢ)         the SCM to be recovered among the latents
```

The proposed architecture is an autoencoder with an SCM embedded in it: encoder `q: ℝ^d → ℝ^n` mapping `X` to the exogenous noises `U`, then the structural assignments `f`, then decoder `p: ℝ^n → ℝ^d`, trained so that `p ∘ f ∘ q ≈ id`. If the graph is known its topology fixes the network; if not, the graph is absorbed into an unspecified part of the decoder `p̃ = p ∘ f`.

| Claim | Consequence for the wiki |
|---|---|
| Disentanglement research (independent factors of variation) is the **special case `PAᵢ = ∅` for all `i`** — a trivial causal graph | "Disentangled" as usually measured is the degenerate corner of ICM, and a representation can be perfectly disentangled in that sense while modelling no mechanism at all |
| **Objects are constituents of a scene that permit separate intervention** — so object-centric learning is a special case of causal factorization, complemented by mechanisms for orientation, viewing direction and lighting | Supplies a criterion for [[wiki/concepts/node-definition-problem.md]] that is neither spatial nor perceptual: a unit is whatever can be intervened upon alone |
| Recovering the exogenous noises is **ill-posed in the i.i.d. case** — infinitely many equivalent solutions yield the same observational distribution | Passive data cannot fix the representation, however much of it there is. Only inductive biases or shifts break the tie |
| **The ill-posedness is a theorem even in the `PAᵢ = ∅` corner, with the counterexample constructed explicitly** (Locatello et al. 2019, [[wiki/concepts/disentanglement.md]]): for any factorized `p(z) = Πᵢ p(zᵢ)` and `d > 1` there is an infinite family of bijections `f` with `∂fᵢ/∂uⱼ ≠ 0` for *all* `i, j` and `P(f(z) ≤ u) = P(z ≤ u)` — built as CDF → normal quantile → dense orthogonal matrix → back | The row above says "infinitely many equivalent solutions"; this says the equivalent solutions include *maximally* entangled ones, in the easiest case ICM contains. So the wiki's weakest form of causal representation learning is already impossible without a **dataset-side** assumption, and the model-side inductive biases the wiki argues for (typed channels, two-rate schedules) are provably only half of what is required |
| **Which factors can be disentangled depends on which interventions can be observed** | Granularity is not a property of the world but of the available intervention repertoire — the same relativity [[wiki/concepts/affordance-grounded-symbols.md]] derives from a body |
| Learned "disentangled" codes are still fixed-format vectors with arbitrary dimension ordering, so **the representation size cannot change** | No architecture in the wiki can change the number of objects in a scene at inference time |

---

## Downstream predictions ICM makes

These are the source's arguments that the principle is not decorative — each is a falsifiable consequence, and two have been tested.

| Prediction | Reasoning | Status |
|---|---|---|
| **Semi-supervised learning is futile in the causal direction and possible in the anticausal one** | If `X → Y`, then by ICM `P(X)` carries no information about `P(Y\|X)`, so unlabelled data cannot help. In the anticausal direction the dependence measure is provably strictly positive (Daniušis et al. 2010) | Empirically corroborated (Schölkopf et al. 2012). The standard SSL assumptions — cluster, low-density separation, semi-supervised smoothness — all assert a dependence between `P(X)` and `P(Y\|X)`, and the co-training theorem assumes predictors conditionally independent given the label, i.e. an anticausal graph. Bears directly on [[wiki/empirical-tensions.md]] T297 |
| **Adversarial examples should be harder to find against a predictor that approximates a causal mechanism** | A structural assignment is by definition valid under every allowed intervention; adversarial perturbation is an i.i.d.-violating intervention | Supported indirectly: modelling the causal generative direction and classifying by *analysis by synthesis* is an effective defence, as is autoencoder reconstruction before classification |
| **Perception assumes the object and the imaging mechanism are independent** | The generic viewpoint assumption. Violating it deliberately — accidental viewpoints, 3D structures lining up in 2D, shadow boundaries coinciding with texture boundaries — produces optical illusions | The invariance is what licenses structure-from-motion without stereo |
| **Modules mirroring world modularity should be re-usable across tasks** | If mechanisms recur across environments, an agent meeting a new environment need adapt only a few modules | Motivates competitive module training. **The architecture now exists and the prediction is still untested in its own terms** ([[wiki/entities/rims.md]], Goyal et al. 2019): `k_T` recurrent modules with private parameters, sparsely activated by attention, beat monolithic baselines on held-out object counts, occluders, novel distractors, dormant-span extension (50 → 200 steps) and WMT→IWSLT transfer — but every result is aggregate end-to-end accuracy, and **no measurement of "how many modules had to change" exists** there either. The one place interference is priced directly is the multi-task translation row, where a second language pair *lowers* an LSTM's transfer BLEU and *raises* the modular model's |

**The homomorphism argument, worth keeping verbatim in spirit.** A gain-control mechanism compensating for illumination need have *nothing physically to do* with the sun and the clouds; it plays a role in the model's modular structure corresponding to the role the physical mechanism plays in the world's. So ICM buys a **structural homomorphism to a world the system cannot directly access** — which is the strongest available answer to why a brain that only turns neuronal signals into other neuronal signals should recover anything about the world at all. **(brainstorm)** This is a cleaner statement of what [[wiki/concepts/latent-graph-discovery.md]] is asking for than "recover the graph": the target is a correspondence of *roles*, not of *parts*, which also explains why per-unit correspondence fails while population-level structure transfers ([[wiki/concepts/objective-identifiability.md]]).

---

## The counterargument the source answers

*"Why not just train one huge model over all interventions? Distributed representations generalise, and a big enough network trained on enough interventions will generalise across them."*

| Reply | Force |
|---|---|
| If the data was not sufficiently diverse, worst-case error to unseen shifts is still arbitrarily high — **and diversity-sufficiency is untestable a priori** | Strong; this is [[wiki/concepts/environment-invariance.md]]'s `E ⊂ ℙ_G` gap |
| A model successful under all interventions in *one* environment is still wanted in environments with similar but non-identical dynamics | Strong; scaling never reaches the second environment family |
| Generalisation is tied to a model's assumptions; the causal approach makes them explicit and aligned with physics and cognition, and a learner not using valid assumptions should fare worse than one that does | Conditional — it is an argument for making assumptions explicit, not for their truth |

The concession is real and is stated: *"we have clearly come a long way already without explicitly treating the multi-task problem as a causal one."*

---

## Open problems

- **No procedure measures ICM violation in a learned model.** The principle is stated in two forms — influence and information — and neither has an estimator that runs on a trained network. "Are these two modules independent mechanisms?" is currently a judgement call, exactly as *"is model A more causal than model B"* is on [[wiki/concepts/causal-model-building.md]].
- **SMS is circular as stated.** It scores a factorization by the sparsity of observed shifts, but which factors are recoverable "depends on which interventions can be observed" — so the signal presupposes an intervention distribution nobody supplies, and a representation could be scored sparse merely because the available shifts were narrow.
- **ICM is false whenever mechanisms share an origin.** Modules produced by one designer, one genome, one evolutionary lineage or one training run *do* inform each other. The source never states the scope condition, and every artificial system in the wiki is in the violating case by construction. **(brainstorm)** This may be the reason a large pretrained model's "modules" fail to transfer separately — they were compressed jointly, so their algorithmic mutual information is large by construction.
- **Coarse-graining has no general theory.** It is "challenging to state general conditions under which coarse-grained variables admit causal models with well-defined interventions" — across microscopic SCMs, ODEs, and temporally aggregated time series alike. This is `G27` restated by the causality literature and conceded there too.
- **Algorithmic independence is uncomputable**, like every Kolmogorov quantity; no resource-bounded surrogate is proposed.
- **The identification results are pairwise.** Function-class restriction breaks the two-variable symmetry, and "it is unclear how to apply the approach to inferring rich hierarchies of latent causal variables."
- **No benchmark exists.** The source's own list of challenges includes that the usual train/test protocol "may not be sufficient for inferring and evaluating causal relations", and that new benchmarks with environment information and interventions are needed — which is `G17`, arrived at independently.

---

## Connections

- **[[wiki/concepts/disentanglement.md]]** — the `PAᵢ = ∅` corner of this page's factorization, and the corner where the ill-posedness is proved constructively: an infinite family of completely entangled latents with identical marginals, which means the *easiest* case of causal representation learning needs a data-side assumption this page never states.
- **[[wiki/concepts/environment-invariance.md]]** — the enforcement side of this page's principle: IRM penalises a classifier that varies across environments, which is ICM's *influence* clause turned into a gradient-norm term — and it needs a labelled environment partition where SMS needs only an unlabelled non-stationary stream.
- **[[wiki/concepts/causal-model-building.md]]** — the rival criterion for what makes a model causal: resemblance of its steps to the generative process rather than autonomy of its factors, with the modelling ladder (mechanistic → SCM → causal graphical → statistical) that prices each level.
- **[[wiki/concepts/latent-graph-discovery.md]]** — sharpens the framing's target: what is to be recovered is a correspondence of *roles* between the model's modules and the world's mechanisms, not of parts, which is why a gain-control circuit can be the right module for illumination without resembling the sun.
- **[[wiki/concepts/universal-induction.md]]** — supplies the second, orthogonal criterion that page's simplicity prior lacks: not the shortest description but one whose length is **additive over modules**, i.e. whose parts do not help compress each other (`G26`).
- **[[wiki/concepts/node-definition-problem.md]]** — an intervention-based criterion for the vertex set: a unit is whatever can be separately intervened upon, which carves objects rather than regions and makes granularity a function of the available intervention repertoire.
- **[[wiki/concepts/counterfactual-probing.md]]** — the operational cousin: clamping one variable and clustering co-response is a direct test of this page's influence clause, executed inside a trained model rather than assumed.
- **[[wiki/concepts/shortcut-learning.md]]** — explains why a shortcut is not merely wrong but *fragile in a specific way*: a spurious edge lives in an entangled factorization, so any change to any physical mechanism moves it, while a causal edge moves only under an intervention on itself.
- **[[wiki/concepts/objective-identifiability.md]]** — the same non-identifiability from the loss side, and this page adds its observational form: recovering the exogenous noises is ill-posed under i.i.d. data, so no amount of passive data fixes the representation and only inductive biases or shifts break the tie.
- **[[wiki/concepts/emergent-modularity.md]]** — the biological counterweight: this page argues modules should mirror the world's mechanisms, that page shows modules can instead be *products* of a growth schedule acting on domain-general parameters, which would make modular structure evidence about ontogeny rather than about the world.
- **[[wiki/concepts/learned-world-models.md]]** — where the modularity claim is supposed to pay: a world model factorised into independent mechanisms needs only a few modules re-learned per distribution change, and partial world models are exactly the case where the unmodelled environment becomes an unobserved confounder.
- **[[wiki/concepts/compositionality.md]]** — the neighbouring decomposition principle with a different currency: composition is about how parts combine into a whole, ICM is about whether the parts can be *changed independently*, and a system can have either without the other.
- **[[wiki/concepts/contextual-inference.md]]** — the missing supplier: SMS scores factorizations by how few factors a shift touches, and contextual inference is the machinery that would detect *that* a shift occurred, so the two together would close the loop `G6` leaves open **(brainstorm)**.
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the same relativity of granularity reached from a body rather than from a graph: there the categories are fixed by which effects the repertoire can produce, here by which interventions can be observed.
- **[[wiki/entities/spelkenet.md]]** — the closest thing in the wiki to a measurement of this page's influence clause: grouping sites by co-response to an imagined force recovers the units that can be intervened on separately, without an object variable anywhere in the model.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the computable descent used for the shortness criterion; nothing analogous exists for the additivity criterion this page adds, which is the concrete missing measurement.
- **[[wiki/entities/rims.md]]** — the architecture built to satisfy this page's fourth downstream prediction, with the prediction still untested: private per-module parameters and default dynamics that interact sparsely, motivated by Sparse Mechanism Shift and validated only through aggregate out-of-distribution accuracy (held-out ball counts, occluders, novel distractors, WMT→IWSLT transfer) — nothing counts how many modules a shift had to change, so "modules mirroring world modularity are re-usable" is corroborated in its consequence and unmeasured in its mechanism (Goyal et al. 2019).
