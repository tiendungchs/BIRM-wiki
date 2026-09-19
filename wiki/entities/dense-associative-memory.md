# Dense Associative Memory (Krotov & Hopfield 2016)

**Replace the quadratic Hopfield energy `E = −½ σᵀTσ` with `E = −Σ_μ F(ξ^μ·σ)` for a sharply growing `F`. Each stored pattern's contribution to the energy is peaked instead of broad, so cross-talk between neighbouring memories collapses and capacity goes from `≈0.14N` to `K^max = α_n N^{n−1}`. The same model read at one update step, with the output units initialised infinitesimally off, *is* a one-hidden-layer feedforward network whose activation function is `f = F′` — so an activation function and a storage-capacity exponent are the same parameter.**

Krotov & Hopfield 2016, *Dense Associative Memory for Pattern Recognition*, NIPS 2016 (arXiv 1606.01164).

This is the origin page of the modern-Hopfield line the wiki already carries downstream: [[wiki/entities/dense-sequence-memory.md]] applies the same move to *asymmetric* weights and sequence capacity, and the glossary's `MHN` entry names this construction. What this page adds that neither carries is (i) the item-capacity derivation itself, (ii) the **duality** with a feedforward net, and (iii) the **feature-to-prototype transition** — a single scalar that dials what the store's units mean.

> **Provenance.** `raw/krotov-2016-dense-associative-memory-for-pattern-recognition.md` — ar5iv rendering of arXiv 1606.01164. The clip byline lists only the first author; the NIPS 2016 paper is Krotov & Hopfield. Figures 1, 2, 4 and 5 are images not present in the clip, so every number below is taken from the text and the appendix, not read off a plot.

---

## The construction

| Object | Statement | What changed from [[wiki/entities/hopfield-network.md]] |
|---|---|---|
| State | `σ ∈ {−1,+1}^N` | Unchanged |
| Memories | `ξ^μ`, `μ = 1…K` | Unchanged in role; here they are **learned by gradient descent**, not written by an outer product |
| Energy | `E = −Σ_{μ=1}^{K} F(ξ_i^μ σ_i)` (sum over `i` implied) | The `K` memories enter as `K` separate terms, not folded into one `N×N` matrix `T_ij` |
| `F` (polynomial) | `F(x) = x^n` | `n = 2` **recovers the classical model exactly** |
| `F` (rectified polynomial, `ReP_n`) | `F(x) = x^n` for `x ≥ 0`, `0` otherwise | The variant used for all the MNIST work |
| Update | `σ_i^{(t+1)} = Sign[ Σ_μ ( F(ξ_i^μ + Σ_{j≠i} ξ_j^μ σ_j) − F(−ξ_i^μ + Σ_{j≠i} ξ_j^μ σ_j) ) ]`, asynchronous | The argument is a **difference of two energies** (unit on vs. unit off), not an induced field. The two differ by self-coupling terms; earlier higher-order-interaction models used the field version |

**Why sharpening works, in one line.** Confusion in the quadratic model happens because several memories contribute energy of the same order — the energy falls *too slowly* as the state approaches a memory. For `n > 2` each term in `Σ_μ F(ξ^μ·σ)` peaks more sharply around its own memory, so more memories fit in the same configuration space before their contributions overlap. **The capacity knob is the read-out nonlinearity, and the code, the state space and the write rule are untouched** — the same relocation [[wiki/entities/dense-sequence-memory.md]] later makes for sequences.

---

## The capacity derivation

Initialise at memory `μ` and ask when flipping bit `i` lowers the energy. With `F(x) = x^n` and random `±1` patterns:

```
⟨ΔE⟩ = N^n − (N−2)^n ≈ 2n N^{n−1}                    (signal, from the ν = μ term)
Σ²   = Ω_n (K−1) N^{n−1},   Ω_n = 4n²(2n−3)!!        (cross-talk variance)

P_error ≈ sqrt( (2n−3)!!/2π · K/N^{n−1} ) · exp( −N^{n−1} / (2K(2n−3)!!) )
```

Thresholding `P_error`:

| Criterion | Capacity |
|---|---|
| `P_error < 0.5%` (per-bit) | `K^max = α_n N^{n−1}`, `α_n` a constant depending on the chosen threshold |
| `P_error < 1/N` (whole pattern recovered) | `K^max_{no errors} ≈ N^{n−1} / (2(2n−3)!! · ln N)` |
| `n = 2` | Recovers `K = 0.14N` |

**Worked at `N = 100`:** `K^max_{no errors} ≈ 11` (`n=2`), `≈ 360` (`n=3`), `≈ 7240` (`n=4`). Simulation with `K = 2000` random memories and 10,000 random initial states: at `n = 2,3` the overlap histogram shows no recovery (the store is over capacity); at `n = 4` it peaks sharply at perfect recovery; at `n ≥ 5` **all 10,000 samples** converge to a stored memory. Sweeping `50 ≤ N ≤ 200`, `50 ≤ K ≤ 1500` and reading `K_{1/2}` (the load at which half of 1000 random starts recover perfectly), the polynomial model matches the formula and the rectified model sits slightly above it with the same non-linear shape.

**The non-monotonicity in `n` is already visible in the formula, and the wiki has been quoting only half of it.** `(2n−3)!!` in the denominator grows faster than `N^{n−1}` for `n` large at fixed `N`, so `K^max_{no errors}` has an interior maximum in `n`. [[wiki/entities/dense-sequence-memory.md]] states the same fact as an empirical `d_max(N)` for the sequence case and notes it "is also true of the symmetric MHN" — it is not a separate finding, it is this expression read at finite `N`. A builder picks the exponent *for the network size*; maximising it is wrong.

**What the derivation assumes, and it is the standing caveat on every capacity number in the wiki.** Patterns are i.i.d. `±1`. The paper notes without quantifying that "for correlated patterns the maximal number of stored memories might be different". [[wiki/entities/dense-sequence-memory.md]] later measures the size of that gap and finds it qualitative, not quantitative: polynomial networks up to `d ≈ 50`, well inside the bound above, recall *nothing* on correlated MovingMNIST frames.

---

## The duality: an activation function is a stored-pattern energy

Take the classification form — visible units `v_i` clamped to the image, `N_c` classification units `x_α`, one update of the classification units only — and initialise the classification units at `x_α = −ε` rather than `−1`. Expand `F` to first order in `ε` and set `β = 1/(2ε)`:

```
c_α ≈ g[ Σ_μ ξ_α^μ · f(ξ_i^μ v_i) ],        f(x) = F′(x)
```

which is exactly a one-hidden-layer feedforward network: **`K` hidden units, one per stored memory; the visible part `ξ_i^μ` is the incoming weight; the classification part `ξ_α^μ` is the outgoing weight; the hidden activation is the derivative of the energy function.** The expansion is justified by `Σ_i ξ_i^μ v_i ≫ Σ_α ξ_α^μ x_α`, i.e. *labels carry far less information than data* — which is true of most supervised problems and is the paper's only stated condition.

| Activation `f` | Energy `F` | Asymptotics of `F` | Effective `n` |
|---|---|---|---|
| `tanh(x)` | `ln cosh(x) ≈ x` | linear | 1 |
| logistic | `ln(1+e^x) ≈ x` | linear | 1 |
| ReLU | `∼ x²` | quadratic | **2** |
| `ReP_{n−1}` | `ReP_n` | `x^n` | `n` |

Three consequences a builder should carry:

1. **ReLU is `n = 2`, i.e. the classical Hopfield network.** Every wiki page that treats "rectified linear units" and "the `0.14N` attractor store" as unrelated objects is talking about one object at two update counts.
2. **Activation functions fall into universality classes set by the asymptotics of `F` at `x → ∞`**, because the basins are shaped by the low-energy states. Saturating and non-saturating units differ in class; `tanh` and the logistic do not.
3. **A hidden unit is a stored memory.** The bipartite two-body reformulation of [[wiki/entities/two-body-dense-associative-memory.md]] (Krotov & Hopfield 2021) is this duality read backwards — and the price is already visible here: `K` hidden units for `K` memories, so the `N^{n−1}` scaling is a statement about patterns per *visible* neuron, never per synapse.

**One-step update = full relaxation, in the prototype regime only.** At large `β` and large `n` the image places the state inside the basin of one prototype, and a single update of the classification units completes the memory. The equivalence between the feedforward net and the recurrent store is therefore *conditional* on the stored patterns being stable with basins at least one bit wide — which is exactly the condition the capacity formula states.

---

## The feature-to-prototype transition

The paper's most transferable result, and it is a dial, not a discovery. `K = 2000` memories, `N = 784` visible units, MNIST, memories learned by backpropagation through the update above (objective `C = Σ (c_α − t_α)^{2m}`; higher `m` emphasises the worst-classified examples — `m = 2,3,4` at small `n`, `m ≈ 30` at `n = 20,30`).

| `n` | What a memory looks like | Classes a memory votes for | Memories within 0.9 of the top contribution |
|---|---|---|---|
| 2–3 | Not a digit; a pattern useful for recognising several digits | mostly 3–5 | many; long-tailed distribution — several memories cooperate on each decision |
| 20 | Recognisable digits with white (zero-valued, i.e. energy-independent) margins encoding stroke-thickness variability | — | — |
| 30 | Whole-digit prototypes, small admixture of feature memories | > 40% vote for exactly **one** class | **> 8000 of 10,000** test images have *no* second memory within 0.9 of the largest contribution |

**Two class-free measurements of the transition**, which is what makes it usable where there is no pixel grid to look at (genomic data is the paper's example): count the `±1` recognition connections in the "on" state per memory (how many classes it votes for), and count how many memories contribute within 0.9 of the maximum to a single decision. Both are computable from a trained network with no visualisation and no labels beyond the ones already present.

**Performance is competitive across the whole range.** At `n = 20` the network is still near state of the art for its class *while doing an entirely different computation* — a single template match instead of a distributed feature vote. So the feature/prototype axis is not an accuracy axis; it is an axis of *how the answer is composed*, and MNIST accuracy cannot distinguish the ends of it.

---

## Reported results

| Result | Number |
|---|---|
| MNIST, `n = 2` (= ReLU) | ≈ **1.6%** test error — matches the best published results for backpropagation without generative pretraining, dropout or adversarial training |
| MNIST, `n = 3` (rectified parabola activation) | **All** sampled hyperparameter settings beat 1.6% |
| Training speed, epochs to first cross 2% error | `n = 2`: 179–312. `n = 3`: 158–262. Speed-up grows with `n` |
| XOR | `N = 3` units (2 input, 1 output), `K = 4` memories = the four truth-table rows. `E_n(x,y,z)` is `0` at `n=1`, constant at even `n`, and `C_n·xyz` at odd `n ≥ 3`, giving `z = Sign[−xy]`. Solvable for odd `n ≥ 3` (polynomial) or any `n ≥ 2` (rectified), and **unsolvable at `n = 1,2`** |
| Training setup | Minibatch 1000 (100 per class), 3000 epochs, per-memory normalised updates (`ξ ← ξ + ε V/max_J\|V_J\|`), weights clipped to `[−1,1]`, temperature `β = 1/T^n` with `500 ≤ T ≤ 700` at large `n` and an annealed `T` at small `n` |

**The XOR case is the paper's cleanest architectural statement and it belongs to a different wiki row than capacity.** `n = 2` here *is* the linear perceptron, and its failure on XOR is Minsky & Papert's. The fix is not hidden units added by hand — it is a **three-body term in the energy**, and the resulting network stores `K = 4 > N = 3` patterns reliably. So "more memories than neurons" and "compute a function no pairwise model can" are the same move seen twice.

---

## What this contributes to the wiki

| Claim | Why it matters |
|---|---|
| **A capacity that is *derived* and carries a dial** | `G42` asks a fast store to report a bound sized by structure rather than by hyperparameter. `K^max = α_n N^{n−1}` is derived from a signal-to-noise calculation, is verified against simulation at three loads, and the exponent is an architectural choice with an interior optimum. It is still a *design-time* number — nothing in the running store reads its own occupancy — so the row does not close |
| **An `n`-body interaction whose coefficients are learned** | `G105` says every discovery mechanism in the wiki is pairwise. Here the energy has an explicit degree-`n` term and the memories in it are fit by gradient descent. The restriction is severe (the `n`-way tensor is a *sum of rank-one* terms `(ξ^μ·σ)^n`, so the model cannot express an arbitrary hyperedge) and the XOR memories are hand-embedded rather than discovered, but the hypothesis space is no longer dyadic |
| **The feature/prototype axis as one scalar** | Whether a store holds parts that recombine or wholes that match is usually an architectural commitment. Here it is `n`, it is continuous, both ends are competitive on the task, and there are two label-free measurements of where on the axis a trained network sits |
| **Activation function ⇄ storage exponent** | A feedforward design choice with no theory behind it becomes a capacity exponent with a closed-form bound. This is the wiki's only case of a deep-learning hyperparameter acquiring a memory-theoretic meaning |
| **Higher rectified polynomials as an unexplored activation family** | `ReP_{n−1}` for `n > 2` is proposed and, as of this source, unused in deep learning. `n = 3` trains faster and generalises better than ReLU on MNIST |

**(brainstorm) The duality makes every trained MLP hidden layer readable as a store with a capacity number.** `f = F′` inverts: given any monotone activation, `F(x) = ∫f` is an energy, the hidden weights are memories, and `N^{n−1}` with `n` set by the asymptotics of `∫f` is a bound on how many distinct things that layer can hold before its units start blending. Nothing in the paper does this, and the assumptions are strong (one hidden layer, the `ε → 0` expansion, `Σξv ≫ Σξx`, i.i.d. patterns) — but it is a cheap, data-free diagnostic to try on a layer whose width was chosen by search, and it predicts a specific failure: a ReLU layer is at `n = 2`, hence linear capacity, hence *the widest layer in a network is the one whose capacity claim is weakest relative to its width*.

**(brainstorm) `n` is the separation/completion knob written at the read-out, and its two regimes are the two failure modes.** At small `n` the store completes aggressively and blends — several memories vote, which is [[wiki/concepts/pattern-separation-completion.md]]'s completion bias and the source of spurious mixtures. At large `n` the store separates to the point of pure template match, and the > 8000/10000 single-dominant-memory figure is separation *measured*. That suggests the missing object is a `n` scheduled by load or by retrieval confidence — the same unbuilt scheduler [[wiki/entities/dense-sequence-memory.md]] arrives at from the sequence side and [[wiki/entities/sparse-distributed-memory.md]] arrives at from the sparsity side. Three pages now want the same scalar controller.

---

## Limitations

| Limit | Consequence |
|---|---|
| **A degree-`n` energy is an `n`-body synapse** | Biologically inadmissible as written, and the paper does not address it. The fix — hidden neurons and two-body interactions only — is [[wiki/entities/two-body-dense-associative-memory.md]] (Krotov & Hopfield 2021), not this paper, and there the conversion is exact: this energy is what that bipartite network becomes when its hidden neurons are integrated out |
| **The memories are learned by backpropagation, not written in one shot** | The classical store's defining capability ([[wiki/concepts/complementary-learning-systems.md]]: an episode is acquired in one exposure) is given up here. This is a *classifier* built out of associative-memory machinery, trained for 3000 epochs. Nothing here writes a new memory at run time |
| **Capacity theory is i.i.d.-patterns only** | Correlated data is acknowledged and not analysed; the measured damage is downstream ([[wiki/entities/dense-sequence-memory.md]]) |
| **No run-time occupancy read** | `α_n N^{n−1}` is computed from `N` and `n` before anything is stored. The store cannot refuse a write, report fullness, or signal that it is guessing (`G42`) |
| **One-step update only, for the classification results** | The recurrent dynamics are used for the capacity simulations; every MNIST number comes from a single update of the classification units. The equivalence between the two holds only in the large-`β`, large-`n`, prototype regime |
| **Basins are not characterised** | Stability against a one-bit flip is the criterion throughout. Basin size, noise robustness and convergence probability from a perturbed state are not addressed |
| **`α_n` is threshold-dependent** | The leading constant is set by the arbitrary 0.5% per-bit error target, so the capacity is a curve read at a chosen fidelity, never a single number — the same caveat [[wiki/entities/hopfield-network.md]] applies to reconciling `0.138N` with `0.15N` |
| **Small scale** | MNIST and a 3-unit XOR. The speed-up argument for large datasets (ImageNet is named) is projection |

---

## Connections

- **[[wiki/entities/hopfield-network.md]]** — the model this one generalises and recovers exactly at `n = 2`: same states, same asynchronous update, same Hebbian-style memories, with the quadratic energy replaced by a sum of sharply peaked per-memory terms, which turns `0.14N` into `α_n N^{n−1}` without touching the code or the state space.
- **[[wiki/entities/dense-sequence-memory.md]]** — the same nonlinearity move applied to *asymmetric* weights: this page prices how many items can be held, that one how many transitions can be chained, and its empirical `d_max(N)` is the `(2n−3)!!` factor in this page's closed form read at finite `N`; it also supplies the bipartite two-body form that removes this page's `n`-body synapse.
- **[[wiki/concepts/energy-based-models.md]]** — a case where the *shape* of the energy, not its minima, is the design variable: `F` is chosen for how fast it grows, and the choice sets both capacity and whether the learned representation is parts or wholes, which is a lever that formalism does not currently name.
- **[[wiki/concepts/attractor-dynamics.md]]** — the discrete-attractor regime with its capacity made a tunable exponent: sharpening each memory's energy contribution narrows and deepens its basin, so robustness and count trade off through one scalar rather than through the code.
- **[[wiki/concepts/higher-order-interactions.md]]** — the same complaint answered from the energy side: a degree-`n` term in `E = −Σ_μ F(ξ^μ·σ)` *is* an `n`-body interaction with learnable coefficients, and the XOR construction is this page's `n`-bit-xor blindness argument solved rather than diagnosed — subject to the restriction that the `n`-way tensor is a sum of rank-one terms, so arbitrary hyperedges remain out of reach (`G105`).
- **[[wiki/concepts/pattern-separation-completion.md]]** — separation implemented at the read-out with no representational change: raising `n` collapses every off-target memory's contribution while leaving the target's fixed, and the > 8000/10000 single-dominant-memory count at `n = 30` is the separation end of the axis measured directly.
- **[[wiki/concepts/memorisation-vs-generalisation.md]]** — the same parts-versus-wholes question posed as an architectural dial rather than a task property: at small `n` a hidden unit is a shared macrofeature voting across 3–5 classes, at large `n` it is a whole-class template, and both ends solve MNIST at the same accuracy — so task performance does not identify which reading the network admits.
- **[[wiki/entities/sparse-distributed-memory.md]]** — the same trade seen from the other side: there capacity is bought with a large address space and a load-dependent sparsity schedule, here with a steeper read-out at fixed code, and both arrive at the unbuilt object of a load-dependent schedule for their single scalar knob.
- **[[wiki/concepts/retrieval-capacity.md]]** — the complementary quantity: this page counts how many items the store holds, that one how many distinct *queries* can address it, and the two bind independently — a store with exponential item capacity still cannot be asked for arbitrary subsets at fixed margin.
- **[[wiki/entities/two-body-dense-associative-memory.md]]** — the paper this page's "biologically inadmissible" limitation names as its own fix, and it is exact rather than approximate: the degree-`n` energy here is the *integrated-out* form of a bipartite network of feature and hidden neurons with symmetric two-body synapses only, the duality `f = F′` generalises to layer-wide activations (softmax, divisive normalisation) as gradients of non-additive Lagrangians, and it adds the ceiling `N_mem ≤ N_h` that this page's `N^{n−1}` assumes away (Krotov & Hopfield 2021).
- **[[wiki/entities/continuous-modern-hopfield-network.md]]** — this page's construction taken to the `F = exp`, continuous-state limit, where the capacity knob moves out of the read-out nonlinearity and into the *geometry*: `n` is gone, and capacity is exponential in `d` with the base set by the radius `M = K√(d−1)` the patterns are normalised to. The separation/completion axis this page reads off `n` is read there off `βΔ_i` with `Δ_i = ½ min_{j≠i}‖x_i−x_j‖²`, and the resulting update is transformer attention (Ramsauer et al. 2020).
- **[[wiki/entities/neuron-astrocyte-associative-memory.md]]** — a biological realisation of this page's `n = 4` member: a three-layer neuron/synapse/astrocyte network with `T_ijkl = Σ_μ ξ_iξ_jξ_kξ_l` reduces on elimination of the two non-neuronal layers to `E = −Σ_μ F(ξ^μ·φ)` with `F(z)=¼z⁴`, so this page's `α_n N^{n−1}` and its `(2n−3)!!` interior optimum apply verbatim to a glial store, with the storage sitting in calcium-transport coefficients rather than in weights (Kozachkov, Slotine & Krotov 2023).
- **[[wiki/concepts/key-value-memory.md]]** — this page's exponent read as a separation operator: `σ(x) = x^n` and attention's softmax are the same separability dial in one family, bounded above by `σ = max` — optimal in the noiseless case and maximally brittle, which is why the dial exists.
