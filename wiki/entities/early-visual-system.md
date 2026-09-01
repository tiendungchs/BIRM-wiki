# The Early Visual System (Retina → LGN → V1) — and Its Standard Models

**The one biological cascade whose computation the field has tried hardest to write down as an equation, and the only place in the wiki where the answer to "do we know what this circuit does?" is a *number*: a linear filter plus a static nonlinearity accounts for ~80% of retinal ganglion-cell response variance to the stimulus class it was fitted on, a filter whose gain and integration time are dynamically set by luminance and contrast carries that success to natural movies in the lateral geniculate nucleus (LGN), and the same programme drops to ~40% of explainable variance in primary visual cortex (V1) and ~10% in V4. The cascade is the ancestor of the convolutional network, and the numbers are what that inheritance is actually worth.**

> **Provenance.** Carandini, Demb, Mante, Tolhurst, Dan, Olshausen, Gallant & Rust 2005, *Do we know what the early visual system does?*, J Neurosci 25(46):10577–10597 (`raw/carandini-2005-early-visual-system.md`). A seven-author mini-symposium review, deliberately structured as **disagreement**: each author states how well the standard model of one stage survives contact with natural stimuli, and the Conclusions section enumerates the points on which they do not agree. This is the wiki's first page on the visual front end, which until now existed only as an unexamined premise — the row "convolutional network ← V1 simple/complex cells" in [[wiki/concepts/neuroscience-ai-transfer.md]] and the divisive-normalization scalar in [[wiki/concepts/inhibitory-control-of-coding.md]].

---

## Anatomy of the cascade

| Stage | Cell census | What the standard model of the stage is |
|---|---|---|
| **Retina** | ~60–80 cell types: 3–4 photoreceptors, ~40–50 interneurons, ~15–20 ganglion cell types (Masland 2001; Wässle 2004). Standard models cover **four** of them: ON/OFF × sustained (X/parvocellular) and transient (Y/magnocellular) | Centre–surround linear filter → static nonlinearity → Poisson spiking (**LNP**) |
| **LGN** | Relay cells driven mainly by X and Y ganglion cells — ~50% of ganglion cells in cat, ~80% in primate. Also receives intrageniculate, subcortical and **cortical** input | Same filter, with gain and integration time set online by two gain controls |
| **V1 simple cells** | ~half of V1 under Hubel & Wiesel's criteria | Oriented (Gabor) filter → half-squaring → divisive normalization |
| **V1 complex cells** | the other half | Energy model: two quadrature filters, each squared, summed |
| **V4 and beyond** | — | **No commonly accepted model exists** |

Modelling the four "conventional" ganglion types is a deliberate exclusion, not a coverage claim: direction-selective and intrinsically photosensitive ganglion cells are outside every model here. **The 15–20 output channels are not a redundancy — they are ~15–20 different functions of the same image, and the standard model describes four of them.** Any architecture that treats the retina as a preprocessing stage with one output map has imported the tractable quarter and discarded the rest.

---

## The standard model, stage by stage

### Retina: LNP

`r(t) = N( (k ∗ s)(t) )`, spikes ~ Poisson(`r`). The filter `k` is recovered by cross-correlating spikes with a white-noise stimulus (spike-triggered average, Chichilnisky 2001); `N` is fitted by plotting the linear prediction against the measured rate.

- **Fit quality within stimulus class: `r² = 0.81`** on a novel white-noise segment at the same contrast and mean luminance (guinea pig ON Y-cell, Zaghloul et al. 2005). Near a maximum-likelihood gold standard. The same LN form works on subthreshold membrane voltage, so it is not an artefact of spiking.
- **It breaks the moment any stimulus statistic moves.** Raising contrast lowers the filter's gain and shortens its integration time, so each contrast needs its own `k` — and a natural movie changes contrast continuously, so what is actually needed is `k(t)` as a functional of stimulus history. Timescale of that adaptation is itself disputed: ~10–100 ms (Victor 1987; Baccus & Meister 2002) against seconds (Kim & Rieke 2001).
- **The Poisson assumption is wrong in the conservative direction.** Ganglion cells are *more* reliable than Poisson: a 9-spike burst has trial-to-trial SD ≈ 1 spike, not 3. Replacing the Poisson stage with an integrate-and-fire generator carrying a refractory recovery function (Keat et al. 2001; Paninski et al. 2004) predicts spike *times*, and reveals that part of the famous contrast-dependent narrowing of `k` is a refractory-period artefact of the LNP fit itself (Pillow & Simoncelli 2003) — though intracellular recording says some of it is real.
- **Nonlinear spatial pooling is missing.** Y-cells sum receptive-field subregions nonlinearly (bipolar-cell output rectification, Demb et al. 2001), and signals arrive from outside the classical receptive field. Some ganglion cells also *adapt to spatial pattern statistics* — after prolonged vertical exposure, sensitivity to horizontal rises (Hosoya et al. 2005), which is adaptation to a higher-order statistic than mean or contrast.

### LGN: the same filter with two knobs

The load-bearing extension, and the wiki's cleanest example of a **model that generalises across stimulus classes because it was not fitted on them**:

```
temporal weighting function  =  k_fixed  ⊛  g_luminance(L)  ⊛  g_contrast(C)
```

| Property | Value |
|---|---|
| Speed | Both gain controls complete **within one cycle of a drifting grating, < 100 ms** — fast enough to be a saccade-compensation mechanism, since each fixation drops the receptive field onto a region of different mean luminance and contrast |
| Locality of the luminance pool | Not larger than the receptive-field **surround** |
| Locality of the contrast pool | Confined to the classical receptive field, computed from the pooled output of small **nonlinear subunits** coextensive with it |
| Independence | Luminance and contrast gain controls act independently, so the two filters compose (Mante et al. 2005) — this is what makes an arbitrary (`L`,`C`) combination predictable rather than a lookup table |
| Direction | Both reduce gain *and* integration time when their driving quantity rises |

From these two knobs alone, five phenomena that the linear receptive field cannot produce follow: (1) response amplitude independent of mean luminance at low temporal frequencies but proportional to it at high; (2) contrast saturation; (3) size tuning — enlarging a stimulus adds little drive but recruits many normalizing subunits; (4) both effects vanishing at high temporal frequencies; (5) masking by a superimposed stimulus.

**The comparison that makes the result count.** Tested on movies (a *Cat-cam* forest walk and Disney's *Tarzan*), the nonlinear model beat the linear one with **the same number of free parameters — two, spontaneous and maximal firing rate**; every other parameter was estimated from grating responses and then frozen. A more complex model given no extra fitting freedom is a real test; the same model fitted on the movies would not have been.

**What still fails:** measured responses are more transient than predicted — LGN burst firing after ≥100 ms hyperpolarization (prominent under anaesthesia, much less in awake animals) and spike-generation transience, neither of which is in the model.

### V1 simple cells: linear summation plus bolt-ons

Hubel & Wiesel's definition is four clauses, of which the fourth — *responses to arbitrary stimuli are predictable from the map* — is a **predictive-adequacy claim wearing a taxonomic disguise**. Taken literally it is unfalsifiable: any cell that fails it is reclassified as complex.

- What the spatiotemporal receptive field predicts **well**: preferred orientation, spatial frequency, temporal frequency.
- What it predicts **badly**: the relative magnitude of responses to non-optimal stimuli (tuning bandwidths come out too wide), and the two directions of motion. Most of this is repaired by a threshold or sigmoidal output nonlinearity — intracellular recordings, which see the box before that transform, show the linear model doing better.
- What an output nonlinearity **cannot** repair: response saturation and *nonspecific suppression* — a stimulus that evokes no response alone suppresses the response to the optimal one. Heeger's (1992) circuit covers both: linear sum → half-squaring → **division by the pooled activity of all neurons whose fields cover the same location**. This is the origin of the divisive-normalization abstraction used elsewhere in the wiki, and its arithmetic survived even though its proponents later changed their minds about the underlying mechanism (Carandini et al. 2002).
- Suppression from **outside** the classical receptive field is a separate mechanism with no simple arithmetic rule, possibly carried by intra-V1 lateral connections or by feedback.
- On flashed natural photographs, a hand-fitted Gabor with **no nonlinearities at all** reaches `r = 0.73` on the best-predicted cell of Smyth et al. 2003 — so for static images the trigger feature survives; the nonlinearities scale the response rather than changing what drives it.

### V1 complex cells: the energy model, and what exceeds it

`R = F(k_φ ∗ s) + F(k_{φ+90°} ∗ s)`, `F(x) ≈ x²` (Adelson & Bergen 1985). Because contrast polarity is irrelevant to these cells, the spike-triggered average is useless; the recovery tool is **spike-triggered covariance** (STC) — eigenvectors of the covariance of the spike-triggered stimulus ensemble with eigenvalues outside the shuffled-spike-train null.

| Finding | Detail |
|---|---|
| Cat V1 | Two significant eigenvectors per cell, both Gabor-shaped, same spatial frequency, **~90° phase apart**; contrast-response functions bimodal (rise at both polarities). Exactly the energy model |
| Circularity caveat, stated by the authors | STC computes the second-order Wiener kernel, and the energy model *is* a quadratic — so agreement is partly guaranteed by the estimator |
| Independent support | Feedforward artificial networks trained to imitate complex-cell input–output converge to energy-model-like connection profiles (Lau et al. 2002; Prenger et al. 2004) — the energy model is what a feedforward architecture *finds* for this function |
| Monkey V1 | More than two eigenvectors: extra **excitatory** ones consistent with convergence of spatially shifted subunits, plus **suppressive** ones acting divisively — i.e. normalization visible in the same analysis (Rust et al. 2005) |
| Predicting tuning from the recovered subunits | Direction selectivity `r ≈ 0.8` (against 0.47 from the linear receptive field); orientation preference within 3.6°, bandwidth within 6.3°, tuning-curve dot product 0.95 ± 0.04 |
| Predicting responses to complex stimuli | Consistently better than spike-triggered average, and **far below the noise ceiling for most cells** |

### The dichotomy is probably not one

Receptive-field structure is continuously graded from textbook simple cells through "nonlinear simple cells" (overlapping ON/OFF regions) and "discrete complex cells" to frank complex cells (Dean & Tolhurst 1983; Mechler & Ringach 2002; Priebe et al. 2004). One candidate account: geniculate input is *inherently* nonlinear, and **push–pull inhibition is what masks that nonlinearity** — so simple cells are complex cells with strong enough opponent inhibition, and the class boundary is a property of one inhibitory parameter (Tolhurst & Dean 1987, 1990; Wielaard et al. 2001). Olshausen's section names the dichotomy as a case of a category that may be an artefact of the analysis lens rather than a fact about the tissue — see [[wiki/concepts/node-definition-problem.md]].

---

## The predictive scorecard

| Stage | Model | Test stimulus | Score |
|---|---|---|---|
| Retina (ON Y-cell) | LNP | novel white noise, *same* contrast & luminance | **81% of variance** |
| Retina | LNP | natural movie | essentially untested — the review notes retinal studies have not attempted it |
| LGN | linear receptive field only | natural / cartoon movies | timing of responses right, **amplitudes wrong** |
| LGN | + luminance & contrast gain control, 2 free parameters | same movies | captures the gist; residual is excess transience |
| V1 | phase-separated Fourier model | simulated natural vision | ~20% of **total** variance |
| V1 | second-order Fourier power model | natural vision | **~40% of explainable variance** — "the best current estimate of how well conventional V1 models account for natural visual responses" |
| V4 | Fourier power model, spatial only | 4 Hz natural-image sequence | **~10% of explainable variance** |
| V1, whole-population estimate | any | natural | Olshausen & Field 2005: **as much as 85% of V1 function is unaccounted for** |

**The failure modes differ in kind, not just in size.** In LGN the linear model predicts nearly every response event and gets the gain wrong — a correctable error, and gain control corrects it. In V1 under time-varying natural input the model *misses events entirely and invents others*. The review's own conclusion: this "will require more than tweaking to resolve… a more complex, network nonlinearity is at work, and describing the behavior of any one neuron will require including the influence of other simultaneously recorded neurons." **The single-neuron receptive field may be the wrong unit of description above LGN.**

---

## The five biases (Olshausen & Field 2005)

The audit that produces the 85% figure. It is stated about V1 and transfers verbatim to interpretability of artificial networks — see [[wiki/concepts/predictive-adequacy.md]].

| Bias | The V1 case | Estimated cost |
|---|---|---|
| **Biased neuron sampling** | Hunting with a microelectrode finds cells that fire; energy budgets imply mean rates < 1 spike/s in primate cortex, yet published *spontaneous* rates routinely exceed that | up to **60% of the population never recorded** |
| **Biased stimuli** | Gratings, spots and white noise are optimal for characterising *linear* systems; in a nonlinear system, responses to a reduced stimulus set do not determine responses to combinations | unquantified, and unquantifiable without the answer |
| **Biased theories** | Publication rewards a theory that explains data over one that shows a poor fit; the simple/complex split and "V1 detects edges" are named as possible lens artefacts — and no simple- or complex-cell filter has ever recovered an object outline in computer vision | — |
| **Interdependence / context** | ~**60–80% of a layer-4 V1 cell's response variance** is a function of other V1 neurons or of non-LGN input; probing this with centre–surround grating pairs faces combinatorial explosion over surround configurations, and natural-scene context produces sparsification that was not predictable from those experiments (Vinje & Gallant 2000) | most of the variance |
| **Ecological deviance** | Models fitted and tested on laboratory stimuli deviate markedly under natural viewing | the 40% figure above |

---

## How this maps to model components

| Biological item | Machine analogue | What the analogy inherits — and what it drops |
|---|---|---|
| Linear filter → half-squaring | convolution → ReLU | Kept. The filter is where a natural-image prior enters, and it is the cheapest part of the biology to copy |
| Divisive normalization by a co-localised pool | batch/layer/group norm; attention softmax denominator | The *arithmetic* transferred; the **pool geometry did not**. In V1 the normalizing pool is defined by receptive-field overlap and, for LGN contrast gain, is spatially coextensive with the classical field — a local, content-defined pool, not a layer-wide one ([[wiki/concepts/inhibitory-control-of-coding.md]]) |
| Quadrature pair → sum of squares | max pooling | Kept in spirit; the energy model is a *smooth* phase-invariance operator, and trained networks rediscover it |
| Luminance & contrast gain control | input normalization applied **once**, offline, per dataset | **Dropped entirely.** The biology sets gain and integration time from the *local, recent* statistics of the input, per unit, within 100 ms, with the two factors composing multiplicatively. No standard vision architecture has a per-unit, per-timestep, locally-pooled gain and time-constant controller |
| Non-Poisson, refractory spiking | — | Dropped; matters only if spike times are the code ([[wiki/concepts/temporal-coding.md]], [[wiki/concepts/spike-encoding-schemes.md]]) |
| 15–20 ganglion channels | 3 colour channels | Dropped |
| 60–80% of L4 variance from lateral/feedback sources | a purely feedforward stack | **Dropped, and this is the load-bearing omission.** The measured cortex is a recurrent network whose feedforward drive is a minority shareholder |

**(brainstorm) The gain-control omission is the cheapest transferable item on this list and the one with a stated normative purpose — logged as gap `G94`.** Luminance and contrast gain control exist because eye movements throw the receptive field onto regions of wildly different statistics every ~300 ms, and the dynamic range of a neuron is small. The machine analogue of that problem is any agent whose input distribution shifts *within an episode* — a moving camera, a scrolling context window, a changing task regime. The biological answer is not a normalization layer: it is a **two-factor, locally-pooled, sub-100-ms controller of both a gain and a time constant**, whose two factors are independent so they compose. Composability is what makes it a controller rather than a lookup table, and it is testable — fit each factor separately, freeze, and check that the product predicts the joint condition. That is exactly the protocol Mante et al. used.

**(brainstorm) The second transferable item is negative and more important: the depth gradient.** Predictive adequacy falls monotonically — 80% (retina) → gist (LGN) → 40% (V1) → 10% (V4) → nothing (IT and beyond) — and it falls fastest exactly where the wiki's interests begin. A reasoning architecture that justifies its front end by appeal to V1 is appealing to a stage that is 60% unexplained on its own terms, and any layer of that architecture past the second has no biological model to be faithful *to*. This is not an argument against the analogy; it is an argument that above LGN the analogy stops being a constraint and becomes a metaphor. Whether that is a fact about the tissue or about the unit of description is [[wiki/empirical-tensions.md]] T277.

---

## Connections

- **[[wiki/concepts/predictive-adequacy.md]]** — the methodological standard this page is the primary case study for: what "we understand this circuit" has to mean, why it must be scored against a noise ceiling on held-out data, and why a model fitted on one stimulus class and *frozen* before testing on another is the only version of the claim that carries information.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — supplies the biological source for that page's convolutional-network row, and prices it: the transferred items (oriented filter, rectification, normalization, pooling) are exactly the components that account for ~40% of explainable V1 variance, and the untransferred ones (dynamic gain control, non-Poisson spiking, the recurrent 60–80%) are where the residual lives.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — gives the divisive-normalization scalar its original circuit and, more usefully, its **pool geometry**: normalization in V1 divides by neurons sharing the same visual-field location, and LGN contrast gain pools nonlinear subunits coextensive with the classical receptive field, which is the local content-defined pooling that page argues a single global normalization layer cannot express.
- **[[wiki/entities/hodgkin-huxley-model.md]]** — the level below: a synapse whose reversal potential sits at rest divides rather than subtracts, which is what makes the normalization arithmetic on this page biophysically available in the first place.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the anatomical frame for this page's contextual-modulation problem: the same suppression from outside the classical receptive field appears there as feedback that decreases V1 firing for centre-only stimuli and increases it when the surround is driven, and the driver/modulator typing is the connection-level version of "what sets the receptive field" vs. "what scales it".
- **[[wiki/concepts/node-definition-problem.md]]** — the simple/complex dichotomy as a possible artefact of the measurement lens (receptive-field maps subtract dark from bright responses, forcing a single-valued field): a case where the unit of description was fixed before the graph, and the resulting categories may not exist in the tissue.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the natural-scene context effect on this page (Vinje & Gallant 2000) is the sparsification that page's decorrelation argument rests on; here it appears as evidence that the classical receptive field is a minority contributor to the response.
- **[[wiki/concepts/temporal-coding.md]]** — the spike-generation half of the standard model: retinal ganglion cells are markedly *sub*-Poisson, and replacing the Poisson stage with a refractory integrate-and-fire generator both improves prediction below 50 ms and shows that one published adaptation effect was an artefact of assuming Poisson. That page uses this as its second, independent line of evidence against the Poisson-sample reading of spike output — the first being cortical cells firing to millisecond-reproducible times under fluctuating current (Mainen & Sejnowski 1997) — so retina and cortex fail the same assumption by different methods.
- **[[wiki/concepts/attention.md]]** — the top of the cascade: in V4 under free-viewing search, attention modulates mean rate, response gain *and* orientation/spatial-frequency tuning, so the "attention as a gain scalar" abstraction is incomplete at the one stage where it was measured naturalistically (David et al. 2002).
- **[[wiki/concepts/priority-map.md]]** — shares the V4 substrate; this page supplies the baseline that page's attentional-gain claims are modulations *of*, and the measurement that only ~10% of V4's explainable variance is captured by any current stimulus model.
- **[[wiki/entities/ventral-visual-stream.md]]** — the same cascade continued past V4, and scored by the opposite criterion: per-unit predictive adequacy falls across these stages (81% → 40% → 10% → nothing) while the population's *linear decodability* of object identity rises monotonically over exactly the same tissue, so which curve is plotted decides whether the stream reads as understood or unexplained (DiCarlo, Zoccolan & Rust 2012).
- **[[wiki/concepts/manifold-untangling.md]]** — what the cascade on this page is *for*, stated geometrically: the point-wise retinal and geniculate sensors leave object manifolds nearly as tangled as pixels, V1's ~30-fold expansion spreads them, and the divisive normalization characterised here flattens them measurably even with random unlearned filters — the one contribution to invariance that costs no data.
- **[[wiki/entities/resonator-network.md]]** — a framing claim about what this system's first job is (Feldman, via Frady et al. 2020): a receptor signal is already a *product* of illumination, reflectance, surface orientation and atmosphere, so early vision is fundamentally **unbinding** — demultiplication rather than feature detection — and factorization is the operation to look for in the circuitry.
- **[[wiki/concepts/random-feedback-addressing.md]]** — the layer top-down feature attention lands on, and the reason the no-spurious-percept constraint binds: feedback routed through near-random reciprocal connections must not be able to counterfeit the stimulus-evoked responses of the orientation/direction/colour-tuned populations characterised here, and a concentration parameter above ~0.2 on the feedback wiring does exactly that (Park & Serences 2025).
