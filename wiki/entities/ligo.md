# LiGO — Linear Growth Operator

**Initialise a large transformer as a *learned linear map* of a smaller pretrained one's parameters, `V(Θ^(new)) = M V(Θ)`, with `M` factorised into a depth operator times a width operator and each Kronecker-factorised so that the free parameters are one blend weight per layer pair and one expansion matrix per neuron axis — 100 SGD steps to fit `M`, then train as usual.** Wang, Panda, Torroba Hennigen, Greengard, Karlinsky, Feris, Cox, Wang & Kim 2023, *Learning to Grow Pretrained Models for Efficient Transformer Training*, ICLR 2023, arXiv:2303.00980 (`raw/wang-2023-ligo-learning-to-grow-pretrained-models.md`).

This is the wiki's first **runnable machine growth operator with a learning component**, and therefore the machine counterpart to [[wiki/concepts/developmental-heterochrony.md]]'s per-module phase offsets: the matrix `w ∈ R^{L₂×L₁}` is literally a learned, per-module schedule for how earlier capacity is spent on later capacity. It is also the row's first negative result on *what a growth schedule buys* — the saving is compute, and the downstream capability gain is zero (`T354`).

---

## The operator

| Object | Form | Free parameters |
|---|---|---|
| Target | `V(Θ^(new)) = M V(Θ)`, `M ∈ R^{L₂D₂² × L₁D₁²}` | intractable unrestricted |
| Factorisation | `M = L_depth · R_width` | `O(D₁²D₂²L₁)` — still intractable |
| Depth, Kronecker | `L_depth = w ⊗ I`, `w ∈ R^{L₂×L₁}` | **`O(L₁L₂)`** — ties all neurons in a layer |
| Width, Kronecker | `R_l = A_l ⊗ B_l`, `A_l, B_l ∈ R^{D₂×D₁}` | **`O(L₁D₁D₂)`** — ties by neuron |
| Applied | `W_l^(new) = B_l W_l A_lᵀ`, then `V(W_l^(new))_k = Σ_{l'} (w)_{l,l'} V(W_{l'})_k` | — |

- **The two Kronecker factorisations are the architectural prior.** Grouping by *layer* (depth) and by *neuron* (width) is what makes the map learnable at all; the paper's own framing is that the factorisation "encodes architectural knowledge". An unstructured `M` is not merely expensive — it has no notion that a transformer has layers.
- **Transformer tying.** New channels must align across modules, so for all `l`: `A_l^k = (B^(emb))ᵀ` for `k ∈ {Q,K,V}`; `A_l^O = (B_l^V)ᵀ`; `B_l^O = B^(emb)` (forced by the residual stream); analogously `A_l^(fc1) = (B^(emb))ᵀ`, `A_l^(fc2) = (B_l^(fc1))ᵀ`, `B_l^(fc2) = B^(emb)`. **The residual stream is a global width constraint** — one `B^(emb)` reused across every layer and module, which is why 100 gradient steps suffice.
- **Universality (Appendix A).** StackBERT (`W_l^(new) = W_{l mod L₁}`), Interpolation (`W_l^(new) = W_{⌊l/k⌋}`), and Net2Net's random-selection width copy are all `M` at particular settings of `w`, `A`, `B`. Every hand-designed growth recipe in the literature is a *fixed point* in this space; LiGO learns which one to be.
- **Expressivity.** The depth-width factorisation is a Monarch matrix (`M = P₁ diag(L_i) P₂ᵀ diag(R_i)`) up to permutation — it inherits butterfly/Monarch expressivity rather than being an ad-hoc sparsity pattern.

---

## Results — FLOPs / wall-time saved to reach the scratch model's final score

| Growth | FLOPs | Wall time |
|---|---|---|
| BERT-Small(6, 512) → BERT-Base(12, 768) | **44.7%** | 40.7% |
| BERT-Base → BERT-Large | 45.2% | — |
| BERT-Small → BERT-Large | 30.3% | — |
| RoBERTa-Small → RoBERTa-Base | **47.2%** | — |
| GPT2-Base (117M) → GPT2-Medium (345M) | 22.5% | — |
| GPT2-Medium → GPT2-1.5B (15k steps, preliminary) | ~39% | — |
| DeiT-S → DeiT-B (ImageNet) | **55.4%** | 52.0% |
| CaiT-XS → CaiT-S (ImageNet) | 52.6% | 46.1% |

**More stored content ⇒ more saving**, monotonically and on two axes: BERT-Base → BERT-Large saves 45.2% against BERT-Small → BERT-Large's 30.3%, and a BERT-Small trained only 50k steps instead of 220k still yields 35.2% rather than 44.7%. The donor's *degree of training* is a continuous dial on the transfer, not a threshold.

### Against the hand-designed operators (BERT-Base, GLUE/SQuAD in Table 1 of the source)

| Method | FLOPs saved | Wall saved | GLUE avg | SQuAD F1/EM |
|---|---|---|---|---|
| Scratch | – | – | 82.25 | 78.79 / 72.19 |
| StackBERT (depth, stacking) | 34.1% | 33.3% | 82.36 | 78.91 / 72.41 |
| MSLT (progressive depth) | 34.9% | 30.0% | 81.72 | 78.47 / 71.95 |
| KI (distillation from the small model) | **−5.7%** | **−13.9%** | 82.59 | 78.01 / 71.85 |
| bert2BERT (Net2Net for transformers) | 29.0% | 25.1% | 82.42 | 78.88 / 71.97 |
| **LiGO** | **44.7%** | **40.7%** | 82.57 | 78.76 / 72.31 |

**KI is the control that matters for the wiki's distillation pages:** transferring the small model's knowledge through its *outputs* costs more compute than training from scratch, while transferring it through its *parameters* saves 45%. The cheap channel between two networks of different size is the weight space, not the function space.

---

## Ablations

| Ablation | Result | Reading |
|---|---|---|
| Depth only, BERT(6,768) → BERT(12,768) | **51.7%** FLOPs | The depth operator alone — a learned `L₂×L₁` blend — beats stacking, interpolation and MSLT |
| Width only, BERT(12,512) → BERT(12,768) | **41.6%** FLOPs | Beats direct copy, Net2Net function-preserving init, and bert2BERT's advanced knowledge init |
| Steps to fit `M`: 100 / 500 / 1000 / 10000 | 44.7% / 44.5% / 44.2% / **38.9%** | Savings are **flat to 1000 steps and then fall.** Longer fitting reaches the target 1k steps sooner (214k vs 215k) and costs more than it returns — the growth map is a *low-information* object, fully determined by ~100 minibatches |
| Composition with layer drop / token drop / staged training | +4.7% / +7.4% / +8.2% | Orthogonal to the efficiency levers it is most likely to be confused with |
| LiGO init, **no further pretraining**, straight to GLUE | 81.04 vs BERT-Small's 80.38 (vs BERT-Base scratch 82.25) | The map alone moves a small model a fraction of the way to the large one's competence — the grown model is not merely a re-parameterisation of the donor |

The DeiT initialisation already scores **72% ImageNet accuracy at step 0** after 100 gradient steps of fitting `M`, converging to 81.7%.

---

## Limitations — and what keeps `G100` open

| Limitation | Detail |
|---|---|
| **One growth event, externally timed** | `M` is applied once, at a moment the experimenter picks. There is no schedule, no criterion for *when* to grow, and no per-module phase offset of the kind [[wiki/concepts/developmental-heterochrony.md]] measures — `w` says how much of each old layer goes into each new layer, not when |
| **The objective fitted is not the schedule's objective** | `M` is fitted by 100 steps of the ordinary pretraining loss on the large model. Nothing optimises for *final* performance, transferability, or the quality of the basin — the growth map is greedy at the moment of growth |
| **Linear** | The map is restricted to linear by tractability, not by argument. A grown layer is a linear combination of the donor's layers, so no feature can be created that is not in the donor's span at initialisation |
| **No capability gain** | Final quality matches scratch on every downstream task (see `T354`). The savings are real and the competence is not new |
| **Scale** | Largest run is GPT2-1.5B, preliminary, 15k steps. The authors state the large-scale question is open |
| **Donor must exist** | The method prices *reuse*; it says nothing about a system that must grow without a previously converged smaller self |

---

## Comparison to the wiki's other growth architecture

| | LiGO (Wang et al. 2023) | [[wiki/entities/progressive-neural-networks.md]] (Rusu et al. 2016) |
|---|---|---|
| What grows | width **and** depth of one network | one frozen column per task |
| Old parameters after growth | **absorbed and then trained** | frozen forever |
| Growth rule | **learned** (100 SGD steps on `w, A, B`) | fixed (add a column, add adapters) |
| When to grow | experimenter | external task boundary |
| Matched-size control | full-size-from-scratch, **trainable** | same-size progressive net with a **random frozen** anterior column |
| What the control isolates | the value of the *schedule* | the value of the stored *content* |
| Result against control | ties on quality, 45% cheaper | wins (209 vs 134 transfer score) |
| Forgetting | not addressed (single task) | zero by construction |
| Readout of whether growth helped | none | Average Fisher Sensitivity |

**The two controls are complementary and neither is the one `G100` asks for.** Rusu et al. vary *content* at fixed size; Wang et al. vary *cost* at fixed content and fixed final size. Crossing them — grow-with-content against full-size-from-step-0, both trainable, scored at matched final size *and* matched total updates — is still unrun.

---

## Reading in the core framing

| This page | Latent-graph reading |
|---|---|
| `M = L_depth R_width`, Kronecker-factorised | The prior over growth maps is **the architecture's own graph**: layers are a group, neurons are a group. Growth is only learnable because the structure of the thing being grown restricts the map (brainstorm — this is the same move as [[wiki/concepts/inductive-bias.md]]'s hypothesis-space family, applied to a map between parameter spaces rather than to a function class) |
| `w ∈ R^{L₂×L₁}` | A **dense** per-layer-pair schedule. [[wiki/concepts/developmental-heterochrony.md]] says the biological object is **sparse** (~4% of components moved). Fitting `w` and reporting its sparsity is a one-line experiment nobody has run, and would say whether the machine optimum is mosaic too (brainstorm) |
| 100 steps suffice, 10000 hurt | The growth map carries **very little information** — a few hundred bits per module pair. If a schedule prior is this cheap to fit, the argument that it must be evolved rather than learned weakens (brainstorm) |
| Savings scale with donor training | Late capacity really is conditioned on what the earlier, smaller version learned — the mechanism `G100` posits is demonstrated; only its *payoff* is in dispute |
| Growth in weight space beats growth in function space (KI at −5.7%) | Between two systems with a shared architecture family, the parameter vector is a **cheaper channel** than the input–output map — which is the opposite of the assumption behind every distillation and probing argument in the wiki |

---

## Connections

- **[[wiki/concepts/developmental-heterochrony.md]]** — the machine instantiation of that page's central object: `w ∈ R^{L₂×L₁}` is a learned per-module blend deciding how earlier capacity forms later capacity, which is the phase-offset vector made runnable — but it is fitted dense and applied once, where the biological measurement says the real object is sparse (~4%) and spread over a decade-long window, so the page supplies the mechanism and not the schedule.
- **[[wiki/entities/progressive-neural-networks.md]]** — the wiki's other growth architecture, and its exact complement: that one freezes old capacity and varies stored *content* against a random-column control, this one absorbs old capacity and varies *cost* against a full-size control, so the 2×2 that `G100` needs is these two experiments crossed and neither paper ran it.
- **[[wiki/concepts/curriculum-learning.md]]** — the capacity arm that `T351` says has never been crossed with an ordering arm: LiGO grows capacity with the data distribution held fixed and i.i.d. throughout, which is the clean "growth without curriculum" cell, and it returns a compute saving with no quality change — so if a curriculum's gain is really an interaction with capacity, this cell is where the main effect should have appeared and did not.
- **[[wiki/concepts/continual-learning.md]]** — the architectural-growth row without the continual part: capacity is added once, everything is retrained, and forgetting is not a question because there is one task — which isolates growth from interference and shows that the expensive part of that page's growth family is the *protection* machinery, not the expansion.
- **[[wiki/concepts/inductive-bias.md]]** — a bias imposed on a map between *parameter* spaces rather than on a hypothesis class: the Kronecker factorisation is the statement "layers and neurons are the groups", and it converts an intractable `R^{L₂D₂²×L₁D₁²}` search into 100 gradient steps, which is the sharpest illustration in the wiki that a bias buys sample complexity by naming the symmetry rather than by shrinking the space arbitrarily.
- **[[wiki/concepts/emergent-modularity.md]]** — that page gives developmental timing the greatest weight of any evolutionary lever and states it in gross volume percentages; LiGO prices the machine version of the same lever at 45% of training compute and, crucially, at **zero** competence, which is the first quantitative pressure on the assumption that the schedule is what the timing lever buys.
- **[[wiki/concepts/connectivity-scaling-bottleneck.md]]** — the depth/width decomposition scored separately (51.7% depth-only, 41.6% width-only) is the growth-side echo of that page's units-versus-edges split; here the two axes are separable operators that compose, so an architecture can be given different schedules for adding units and adding connections.
- **[[wiki/concepts/sparse-expert-routing.md]]** — the other family that grows a transformer's parameter count without paying for it, and the contrast is instructive: sparse routing buys capacity at fixed FLOPs *at inference*, LiGO buys the same final capacity at reduced FLOPs *during training*, and the two levers have never been combined.
