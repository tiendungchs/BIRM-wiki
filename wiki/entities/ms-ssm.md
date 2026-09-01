# MS-SSM (Multi-Scale State Space Model)

**A state-space layer that stops asking one recurrence to hold every timescale: a learned, undecimated wavelet front end splits the stream into `S+2` band-limited copies, an independent SSM runs on each with its eigenvalues *initialised into a disjoint band of the spectrum*, and a content-derived row vector `E_t` mixes the bank back to one channel — so memory horizon becomes an allocation across a bank rather than a single number, and the total state budget is unchanged.**

> **Provenance.** Karami, Behrouz, Zhong, Pascanu & Mirrokni, *MS-SSM: A Multi-Scale State Space Model for Efficient Sequence Modeling*, arXiv:2512.23824v1 (`raw/karami-2025-ms-ssm-multi-scale-state-space.md`), Google Research / Google DeepMind. **Preprint, not peer-reviewed.** Tables 5 (architecture ablation) and 6 (mean mixing distance) are rendered as images and are **absent from the extracted source** — both are held from prose only, with no numbers.

Why the wiki holds this page:

1. It is the **built version of a bank of horizons**, which [[wiki/entities/simple-cycle-reservoir.md]] defined (Def. 7, non-identical multi-cycle blocks read out by a linear mixture) and never exploited. MS-SSM adds the two things that definition lacks: a front end that makes the bands *actually different*, and a mixer that is *input-dependent*.
2. It supplies the wiki's **best ListOps result (63.04%)** — the Long Range Arena's hierarchical-reasoning column, and the one [[wiki/entities/s4.md]] flagged as its weakest by 27 points.
3. It is the **second independent instance of a spectral initialisation deciding a sequence result** ([[wiki/empirical-tensions.md]] T177), and it sharpens the claim: what matters is not merely *which* prior on `A` but whether that prior is **stratified**. Same architecture, Mamba's init vs scale-dependent init: **57.49 → 63.04** on ListOps.
4. It separates **state size** from **spectral spread** and finds only the second one pays. Doubling Mamba's state buys 4 points on ListOps; redistributing the *same* state across bands buys 25.

---

## The object

Three components, in series. `S` is the number of decomposition levels (`S = 3` in every experiment), `N` the state size per scale, `K` the filter length (`K = 4`).

### 1. Multi-resolution front end — a learned Stationary Wavelet Transform

Multi-Resolution Analysis (MRA) via the Discrete Wavelet Transform (DWT) recursively applies a low-pass `φ` and high-pass `ψ` filter pair and downsamples. The downsampling is what destroys translation-invariance, so MS-SSM uses the **Stationary Wavelet Transform (SWT)** (Nason & Silverman 1995) instead — *skip the decimation, dilate the filters*:

```
a^s[t] = Σ_{ℓ<K} a^{s−1}[t − 2^{s−1}ℓ] φ[ℓ]        approximation (low-pass)
d^s[t] = Σ_{ℓ<K} a^{s−1}[t − 2^{s−1}ℓ] ψ[ℓ]        detail        (high-pass)
        a^0 ≜ x
```

which is exactly one **causal depthwise `Conv1d(in=1, out=2, kernel=K, dilation=2^{s−1})`** per level:

| Property | Consequence |
|---|---|
| No downsampling | Every level has length `L`; the representation is *redundant*, and redundancy is what buys translation-invariance |
| Filters **learned**, not a fixed wavelet basis (Haar/Daubechies/Symlets), with dedicated weights per level | Perfect reconstruction is given up deliberately — following Shi et al. 2023, orthogonality is not a property a sequence model wants |
| Dilation `2^{s−1}` | Level `s` sees patterns up to `2^s·K` long. **Local**: this is a band-pass filter, not a memory |
| Output | `x_t ∈ R ↦ x̂_t ∈ R^{S+1}` — `(d^1,…,d^S, a^S)`, fine detail → coarse trend |
| Cost | `O(LKS)` time, `O(KS)` parameters per layer. Being LTI, the cascade composes into a **parallel filter bank** at inference (`φ_{1:2} = φ_1 ∗ φ_2`, kernel `K_1+K_2−1`) |

### 2. An array of `S+2` SSMs, one per band, plus one on the raw signal

The front end is band-limited *and* short-range. Long-range correlation **within** a band is what the SSMs supply. Each is a standard diagonal real SSM (S4-style LTI, or S6-style input-dependent):

```
h^s_t = Ā^s h^s_{t−1} + B̄^s_t x̂^s_t ,     y^s_t = C^s_t h^s_t
```

Effective state per input channel is `(S+2)N`, **held equal to the baselines' single-recurrence state size** — the comparison is at matched state, not matched-per-scale.

**Scale-dependent initialisation — the load-bearing part.** With `|λ_i(Ā)| < 1 − δ`, effective memory is `O(1/δ)` (Agarwal et al. 2023). MS-SSM partitions that quantity by band:

```
diag(A^s) ~ Uniform( −N(S+1−s), −N(S−s) ]           s ∈ {0,…,S+1}
⇔ diag(Ā^s) ∈ ( e^{−Δ₀N(S+1−s)}, e^{−Δ₀N(S−s)} ]
```

Coarse bands (high `s`) get eigenvalues **near 1** → long horizon. Fine bands get small eigenvalues → short horizon, local dynamics. At `s = 0` this collapses to S4D-real's HiPPO-grounded `diag(A)_n = −(n+1)`, so the scheme is that initialisation **stratified by band** rather than a new one.

### 3. Scale mixer — content-set weighting *over timescales*

```
z_t = E_t · y_t ,        E_t = Linear_E(x_t) ∈ R^{1×(S+2)}
```

A per-position, input-dependent convex-free weighting that collapses the bank to one channel. Ablation (Table 5, prose only): this **linear** data-dependent form beats both a data-independent trainable linear layer and a softmax-nonlinear data-dependent gate.

**Input-dependent parameterisation (S6 variant).** `B̄^s_t, C̄^s_t, Δ^s_t` are functions of the **raw** `x_t` — *not* of the band's own representation `x̂^s_t`. The paper reports the raw-input version as measurably better, its stated reason being that it re-mixes each band with unfiltered information.

---

## Results

Two variants throughout: **MS-SSM (S4)** — LTI recurrence — and **MS-SSM (S6)** — Mamba's selective recurrence.

### Hierarchical reasoning: ListOps (LRA, length 2048, nested `MAX/MIN/MEDIAN/SUM_MOD`)

| Model | Acc. % | |
|---|---|---|
| **MS-SSM (S6)** | **63.04** | best in the wiki |
| **MS-SSM (S4)** | **62.83** | |
| Liquid-S4 / MultiResNet | 62.75 | |
| S5 | 62.15 | |
| S4D / S4 | 60.52 / 59.60 | |
| H-Transformer-1D | 49.53 | best Transformer variant |
| **Mamba 2× params** | 49.63 | |
| **Mamba 2× state** | 42.14 | |
| **Mamba** | 38.02 | |
| Transformer | 36.37 | |
| Griffin | 32.34 | |

The three Mamba rows are the most informative lines in the paper. **Doubling the state buys 4.1 points; doubling the parameters buys 11.6; stratifying the same state across bands buys 25.0.**

### Everything else

| Task | MS-SSM (S6) | MS-SSM (S4) | Best baseline |
|---|---|---|---|
| sCIFAR (pixel sequence, no 2-D prior) | **93.3** | 90.3 | MultiResNet 93.1 · Orchid 93.0 · Liquid-S4 92.0 · S4 91.1 · Mamba 90.1 |
| ImageNet-1K (16×16 patches, ViT backbone) | **81.3** | 79.7 | Mamba 80.5 · S4D 80.4 · S4 79.1 |
| PTB-XL ECG, AUROC (all / diag / sub / super / form / rhythm) | **.939 / .941 / .936 / .935 / .901** / .979 | .939/.939/.935/.930/.899/**.980** | S4 & MultiResNet .938 · SpaceTime .936 · Mamba .915 |
| **LRA avg** (Text, Retrieval, Image, Pathfinder, Path-X — *excludes* ListOps) | 86.73 | **91.89** | **Mega 93.22 · S5 92.52 · S4 91.38** · LRU 91.52 · Mamba 72.30 · Griffin 68.47 |

**The last row contradicts the abstract.** The paper claims MS-SSM "consistently outperforms prior SSM-based models"; on the five other LRA tasks the headline S6 variant is **4.7 points below plain S4 and 6.5 below Mega**, and only the S4 variant edges S4 (+0.51). The paper's framing of that table — a "+14.42% improvement over its closest counterpart, Mamba" — is true and selects the weakest SSM in the table as the comparator. Both variants are reproduced above; the wiki should cite the pair, never one alone.

### Ablations

| Ablation | Result |
|---|---|
| **Initialisation** (Table 7) | scale-dependent **63.04 / .939** vs Mamba's init **57.49 / .928** (ListOps / PTB-XL) |
| **Architecture** (Table 5, numbers unavailable) | all ten components contribute; the **main contribution comes from the multi-resolution convolution**, not the recurrent module |
| Remove recurrent module / replace multi-res conv with plain Conv1D | both degrade (magnitudes unavailable) |
| Gate each band from its own representation `x̂^s_t` vs from raw `x_t` | raw `x_t` better |
| Scale mixer: data-dependent linear vs data-independent linear vs softmax-gated | data-dependent **linear** wins |

### Mean mixing distance — an ERF metric for models with no attention matrix

Self-attention hands you `A(x)` whose rows are distributions over positions, so the *average attention distance* `d(m,n) = Σ_n A(x)_{m,n}(m−n)` is immediate (Dosovitskiy et al. 2020). An SSM stack has no such matrix. MS-SSM substitutes the **row-normalised Jacobian**:

```
d(m,n) = Σ_{n≤m}  |J(x)_{m,n}| / |Σ_{k≤m} J(x)_{m,k}|  ×  (m − n)
```

reported as `d(m,L)` for the last token, averaged over channels and layers. MS-SSM ≫ Mamba on ListOps (Table 6 — **numbers are in a dropped image**).

This is the first instrument in the wiki that measures **how far a model actually looks**, as opposed to how far it *could*, and it is architecture-agnostic — it applies to any differentiable sequence map. That makes it the natural measurement for the quantity T174/T175 both name as unmeasured, and for [[wiki/entities/s4.md]]'s claim that late-layer kernels span all 16,384 positions (asserted from a dropped figure, never quantified).

---

## What this changes in the wiki

### 1. The design variable inside the fading class is the *spread* of the spectrum, not its size

[[wiki/entities/simple-cycle-reservoir.md]] proved that inside the contractive class, topology is free and width is a rate: enlarging `n` "buys a longer `λ`-exponential horizon, never a non-fading one". [[wiki/entities/s4.md]] then narrowed the operative variable to "the spectrum and its conditioning". MS-SSM measures the next digit: **at fixed total state, how the eigenvalues are *distributed* across that state is worth 25 points where making the state twice as large is worth 4.**

The mechanism is legible. A single diagonal SSM initialised from one interval concentrates its effective memories `1/δ_i` in one order of magnitude; a nested-structure task needs decisions at several. Stratifying the init is a **prior that the input has several relevant timescales at once** — which is a claim about data, not about computation, and it is the same *kind* of object as HiPPO: chosen before any data arrive, neither recovered nor destroyed by gradient descent.

`(brainstorm)` If this holds, the wiki's whole "how large a state?" question is mis-posed and should be replaced by "**what measure on the unit interval should the eigenvalues be drawn from?**" MS-SSM's answer is a dyadic partition with `S+2` uniform blocks. Nothing tests whether the dyadic spacing matters, whether a log-uniform draw over one interval does the same job with no bank at all, or whether the front end is even necessary once the spectrum is stratified. That last one is the cheap discriminating experiment and the paper does not run it: **plain S4 with band-stratified `A`, no wavelet decomposition.** Table 5 says the multi-resolution convolution is the largest contributor, which is evidence against — but Table 5's numbers are unavailable.

### 2. Imposed vs discovered multiscale structure — a new tension

[[wiki/entities/s4.md]] records that S4 *discovers* a multiscale decomposition with no hierarchy in the architecture: first-layer kernels local, last-layer kernels spanning all 16,384 positions at varying frequencies, 20 layers deep. MS-SSM *imposes* one, in a single layer, and gains 3.4 points on ListOps at matched parameters — while **losing** to S4 on the five LRA tasks where the discovered version already works. Filed as [[wiki/empirical-tensions.md]] T178. The pattern in the split is worth naming: the imposed hierarchy wins where the task's structure is **explicitly nested** (ListOps, ECG rhythm-vs-form, pixel sCIFAR) and loses where it is **flat and long** (Retrieval, Path-X).

### 3. Selection over timescales ≠ selection over positions — and Mamba is the proof

Mamba's selective scan makes `B, C, Δ` functions of the token at *each position*: content-dependent selection along the sequence axis. It is the most input-dependent SSM in the table and the **worst on ListOps** (38.02), below a plain Transformer. MS-SSM's `E_t` is also content-dependent, but its output axis is the **bank**, not the sequence. Two different jobs, and the first does not confer the second:

| | Selection axis | ListOps |
|---|---|---|
| S4 | none (LTI) | 59.60 |
| Mamba / S6 | position | 38.02 |
| MS-SSM | position (S6 inner) **+ band** (`E_t`) | 63.04 |
| MS-SSM (S4) | **band only** | 62.83 |

The `MS-SSM (S4)` row is the one that settles it: band selection alone, with a fully LTI recurrence and no per-position gating anywhere, is worth 24.8 points over Mamba's per-position gating. `(brainstorm)` The reading the wiki should carry is that "input-dependence" has been treated as one lever and is at least two, and the wiki has been scoring architectures on the wrong one. A nested-bracket task needs the model to decide *at what temporal grain to read*, not *which token to keep*.

### 4. A partial answer to G54 — the horizon is set by a cue that is not the content

[[wiki/architectural-gaps.md]] G54 asks for a channel that carries timing separated from one that carries content. [[wiki/entities/ltc.md]] fails it by construction (`f` is both). [[wiki/entities/cfc.md]] splits `θ_f` from `θ_g, θ_h` and the split buys nothing measurable, with that page naming the missing test: *"a task where a cue sets the horizon without being the content remembered."* MS-SSM is the closest thing the wiki has to that architecture:

| | What is stored | What sets the horizon |
|---|---|---|
| LTC | `x`, via `f` | `f(x, I)` — same function |
| CfC | `g, h` | `f`, own parameters, but still driven by the content |
| S4 | `h` | `Δ`, global, external, **nothing learns it** |
| **MS-SSM** | `h^0 … h^{S+1}`, one per band, horizons **fixed at init** | `E_t = Linear_E(x_t)` — content-derived, but it selects *among* horizons and cannot change any of them |

So the separation is real but partial: the bank is content-independent and frozen, and the content-dependent part only chooses a mixture over it. That is arguably the *right* factorisation — a neuromodulator does not set an arbitrary time constant, it picks among the ones the circuit has — and it is the first architecture here that has it. The ablation result that gating should read the **raw** `x_t` rather than the band's own `x̂^s_t` is the same point from the other side: **a band-limited channel cannot judge its own relevance**, so the selector must sit outside the filter it is selecting.

### 5. Hierarchical prediction across timescales, as a biological claim

The paper's stated motivation is neuroscientific and cited secondhand: `(tentative)` Caucheteux et al. 2023 report evidence for **hierarchical predictive coding in language** — the brain predicts speech at multiple levels, with different regions carrying different prediction depths — and language models augmented with hierarchical multi-timescale predictions align better with brain responses; Wacongne et al. 2011 is cited for a cortical hierarchy of prediction timescales. This is the same shape as [[wiki/concepts/predictive-coding-free-energy.md]]'s derived slow-above/fast-below result, arriving from data rather than from the coupling argument. Neither claim was read in primary form here.

---

## Comparison

| | **MS-SSM** | [[wiki/entities/s4.md]] | Mamba / S6 | [[wiki/entities/ltc.md]] | [[wiki/entities/simple-cycle-reservoir.md]] |
|---|---|---|---|---|---|
| Recurrence | `S+2` parallel diagonal SSMs | one diagonal SSM (NPLR) | one diagonal SSM, gated | nonlinear rate | one ring, weight `λ` |
| Horizons available | **a bank, `S+2` disjoint bands** | one interval | one interval | per-unit, per-instant | one (`λ`) |
| How horizons are set | **initialisation, stratified by band** | initialisation (HiPPO) | initialisation | learned from input | one hyperparameter |
| Content-dependence | band mixture `E_t`, and (S6 variant) per-position `B,C,Δ` | none (LTI) | per-position `B,C,Δ` | rate only | none |
| Front end | learned undecimated wavelet cascade | none | none | none | none |
| Extra cost | `O(LKS)` time, `O(KS)` params | — | — | stiff solver | — |
| ListOps | **63.04** | 59.60 | 38.02 | — | — |
| LRA avg (5 tasks) | 86.73 (S6) / 91.89 (S4) | 91.38 | 72.30 | — | — |
| Test-time resolution change | not reported | **native via `Δ`** | no | native | no |
| Long-range | Path-X 97.12 (S4 variant) | Path-X 96.35 | fails | conceded absent | excluded (proved) |

---

## Limitations

| Limitation | Consequence |
|---|---|
| **The two variants disagree, and the paper does not say so** | MS-SSM (S6) wins ListOps/sCIFAR/ImageNet/PTB-XL; MS-SSM (S4) wins the other five LRA tasks by 5.2 points. The claim that "performance does not rely on the S6 block" is supported on some tasks and refuted on others by the paper's own tables |
| **Loses to Mega and S5 on LRA** | The abstract's "consistently outperforms prior SSM-based models" is not what Table 4 shows |
| **Tables 5 and 6 are images and were dropped in extraction** | The architecture ablation and *every* mean-mixing-distance number are unavailable. The claims "the main contribution comes from the multi-resolution convolution" and "MS-SSM ≫ Mamba in ERF" are held **from prose with no magnitudes** |
| **`S` is a hyperparameter, fixed at 3 in every experiment** | Nothing learns how many timescales the data has, where the band boundaries go, or whether dyadic spacing is right. New gap G67 |
| **No stratified-init-without-wavelets arm** | The cheapest and most informative ablation — plain S4 with band-partitioned `A` — is not run, so the front end and the initialisation are never separated |
| **Preprint, arXiv v1** | Not peer-reviewed. All numbers above carry that caveat |
| **No abstract reasoning task beyond ListOps** | Same boundary as every other sequence model in the wiki. ListOps is nested-bracket arithmetic over a 10-symbol alphabet with 4 operators and a single-token answer — hierarchical, but with no variables, no held-out structure, and no composition of *rules* |
| **`Δ` retunability not tested** | S4's demonstrated external timescale register is neither inherited nor discussed, despite MS-SSM having `S+2` of them |
| **Redundancy is paid for in full** | The SWT's translation-invariance comes from *not* downsampling, so every band is length `L`. The saving is only that state is redistributed rather than added |

---

## Connections

- **[[wiki/entities/s4.md]]** — the base case this is stratified over, and the direct empirical opponent: S4 puts one initialisation interval on one recurrence and *discovers* a local→global kernel hierarchy across 20 layers, MS-SSM partitions the same total state into `S+2` bands with disjoint eigenvalue intervals and imposes the hierarchy inside one layer — beating S4 by 3.4 points on ListOps (the column S4's own page flags as its weakest) while losing to it by 4.7 on the other five Long Range Arena tasks in the S6 variant, which is [[wiki/empirical-tensions.md]] T178.
- **[[wiki/entities/simple-cycle-reservoir.md]]** — the bank of horizons this page builds: SCR's Def. 7 defines non-identical multi-cycle blocks read out by a linear mixture `h(Σ a_i x^(i))` and never uses it, because all its theorems require identical blocks; MS-SSM supplies the two missing pieces (a learned band-pass front end so the blocks see *different* signals, and an input-dependent mixer in place of the fixed `a_i`) and reports what SCR's width-is-a-rate result predicts you cannot get from size alone — 25 points from redistributing a fixed state against 4 from doubling it.
- **[[wiki/entities/ltc.md]]** — the opposite factorisation of the same variable: LTC computes a *continuous* horizon per unit per instant from the content it is integrating, MS-SSM fixes a *discrete* set of horizons at initialisation and lets content pick a mixture over them — so LTC can express any timescale and cannot separate rate from content (G54), while MS-SSM separates them cleanly and can only express the `S+2` it was initialised with.
- **[[wiki/entities/cfc.md]]** — supplies the architecture CfC's null result asked for: CfC gives the rate its own parameter set `θ_f` and the variant ladder is flat, with that page naming the missing test as "a cue that sets the horizon without being the content remembered"; MS-SSM's `E_t` is exactly that cue — derived from the raw input, selecting among frozen horizons, changing none of them — and the ablation that raw-input gating beats band-representation gating says the selector must sit *outside* the filter it selects.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — a timescale hierarchy with neither termination conditions nor variable-length commitment: `S+2` fixed dyadic bands (`2^s·K` filter support, eigenvalues stratified into disjoint intervals) running *simultaneously* and mixed per position, so where an option commits to one temporal grain until a boundary fires, MS-SSM holds all grains at once and re-weights them every step — the fully parallel alternative to sequential temporal chunking, and the one that wins on nested-bracket evaluation.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the timescale register in its most biologically-shaped form yet: S4's `Δ` is external and global but nothing learns it, LTC's `τ_sys` is learned but inseparable from the content, and MS-SSM's `E_t` is a learned, content-derived, per-instant *selection among a fixed repertoire of horizons* — which is what a modulator actually does, since acetylcholine does not set an arbitrary time constant, it picks among the ones the circuit has.
- **[[wiki/concepts/attention.md]]** — an attention-free model that supplies attention's missing measurement: the *mean mixing distance* replaces the attention matrix with the row-normalised Jacobian `|J_{m,n}|/|Σ_k J_{m,k}|`, giving an effective-receptive-field number that is comparable across attentional and non-attentional architectures — and the ListOps column shows content-dependent scoring over *positions* (Mamba 38.02, Transformer 36.37) losing by 25 points to content-dependent selection over *timescales* with an LTI recurrence (62.83).
- **[[wiki/concepts/reward-prediction-error.md]]** — a use for the frozen horizon bank outside sequence modelling: temporal-difference learning of the dopamine record needs a representation of *time since cue*, supplied in the original model by a hand-built delay line (the complete serial compound), and this bank is the wiki's nearest learned substitute — blurred rather than orthogonal, so it predicts a softer omission dip.
- **[[wiki/concepts/latent-graph-discovery.md]]** — ListOps is the wiki's closest sequence-model approach to the navigate half over an *explicitly nested* graph: the bracket structure is a tree that must be evaluated bottom-up, and the result says the decisive capability is reading the stream at several temporal grains at once rather than selecting tokens along it — the first evidence here that hierarchical structure in the data wants a hierarchy in the *spectrum*, not in the layer stack.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the same slow-above/fast-below timescale hierarchy reached from the opposite direction: that page *derives* it from the coupling (a higher attractor prescribes the manifold the lower states flow over, so it must change slowly), while MS-SSM *installs* it as a prior on the eigenvalue distribution and measures what it is worth — and the paper's stated motivation is `(tentative)` evidence for hierarchical predictive coding in human language processing across cortical timescales.
- **[[wiki/concepts/three-component-framework.md]]** — the second result in the wiki to land outside all three slots and the first to say what shape the missing slot has: architecture, learning rule and objective are fixed while only the *initial distribution* of `A`'s eigenvalues changes, and ListOps moves 57.49 → 63.04 — so the fourth slot S4 opened is not "an initialisation" but "a **measure** the initialisation is drawn from".
- **[[wiki/concepts/event-segmentation.md]]** — the frequency-domain alternative to a boundary detector: rather than cutting the stream where the predictive model breaks, MS-SSM decomposes it into scales that coexist, so multi-grain structure is handled with no segmentation decision at all — which sidesteps G27's missing detector for *reading* while supplying nothing for the discrete nodes a graph formalisation needs.
- **[[wiki/entities/transformer.md]]** — the architecture this page's mean mixing distance replaces a metric for: maximum path length (Vaswani et al. 2017, Table 1) is a worst-case *graph* property of a layer type, where mixing distance is the realised receptive field of a trained model and is defined for non-attentional layers too; and the 25-point ListOps gap between selection over positions (Transformer 36.37) and selection over timescales under a fully time-invariant recurrence is the sharpest statement that the founding architecture picked the less useful of the two input-dependences.
- **[[wiki/entities/lru.md]]** — the other way to set the spectrum, on the axis this page does not use: this page stratifies eigenvalue **magnitude** into `S+2` disjoint bands and buys 25 ListOps points at fixed total state, LRU keeps one unstratified magnitude ring and buys Path-X (chance → 94.2%) by restricting eigenvalue **phase** to `[0, π/10]`, on the argument that phase sets *what* a channel stores (global summary vs local oscillation average) independently of how long it stores it — so the joint `(ν, θ)` bank neither page builds is the next object, and G67's complaint about authored allocations now covers two axes rather than one (Orvieto et al. 2023).
- **[[wiki/concepts/parallel-timescale-streams.md]]** — the biological measurement this page's `S+2` strata are the closest architecture to, and the respect in which they still miss: the strata are disjoint decay-constant bands over **one** state stream sampled at several rates, where the connectome runs six *concurrent* streams over one shared blueprint alphabet with chance-level cross-stream overlap, so a stratified SSM reproduces the timescale spread without reproducing the asynchrony.
- **[[wiki/concepts/timescale-hierarchy.md]]** — the biological alternative to authoring the bands: a spectrum spanning tens of milliseconds to seconds generated by one scalar gradient over a weighted directed graph, with the modes also *spatially localised* (fast at the sensory periphery, slow at the apex) so each band is addressable as a module — where this page's `S+2` strata are hand-partitioned eigenvalue intervals with no spatial correlate (Chaudhuri et al. 2015).
- **[[wiki/concepts/intrinsic-timescale-measurement.md]]** — the measured spectrum this bank's dyadic partition should be sized against, and it is a surprise: the entire cortical *intrinsic* range is `50–350 ms`, a factor of ~7 that would fit inside one of this model's `2^s·K` bands, while the functional horizons that ordering predicts are an order of magnitude longer — so a narrow gradient plus recurrence buys a wide range, and matching the intrinsic spread is a weaker test than matching the functional one.
