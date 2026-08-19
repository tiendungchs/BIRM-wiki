# Dendritic Computation

**A pyramidal neuron is not a thresholded sum over its synapses. It is a bank of ~100 independent nonlinear pattern detectors — each a short stretch of dendrite that fires a regenerative NMDA spike when 8–20 of its co-located synapses are active within a few milliseconds — and the cell's output is closer to an OR over those detectors than to a weighted sum of its inputs.**

This is the wiki's first page at the *implementation* level that carries computational content rather than substrate detail (T1), because the claim is not "neurons are complicated" but "the unit that stores a pattern is the segment, not the cell", and that changes what a unit count means.

> **Provenance.** `raw/ahmad-2016-sparse-representations-active-dendrites.md` — Ahmad & Hawkins, Numenta, 2016. The mathematics of the detector lives on [[wiki/concepts/sparse-distributed-representations.md]]; this page carries the neuron model, the biology it rests on, and the prediction it makes.

---

## The biology the model abstracts

| Fact | Number | Why it matters |
|---|---|---|
| Most synapses are **distal**, far from the soma | — | A single distal synapse has almost no somatic effect; classically they were dead weight |
| A **cluster** of co-active distal synapses fires an NMDA spike | 8–20 synapses | The nonlinearity. This is the unit of pattern memory |
| The cluster must be **spatially localized** | 20–300 µm | Which synapses can cooperate is set by anatomy, not by weights |
| And **temporally synchronized** | 1–5 ms | The segment is a coincidence detector, not an integrator |
| The resulting depolarization is **long** | 50–200 ms | One detection biases the cell over a behavioural timescale — a prediction, not a spike |
| Synapses per pyramidal cell / per segment | ~10⁴ total; 100–400 per segment | ~100+ independent segments per neuron |

Clustered plasticity and NMDA-spike-dependent structural change are experimentally established (Losonczy & Magee 2006; Makara et al. 2009; Kleindienst et al. 2011; Takahashi et al. 2012; Makino & Malinow 2011), so the pool of *potential* connections reachable by structural plasticity is far larger than the set of actual ones — the segment chooses its `s` synapses from a large candidate set.

---

## The model neuron

| Level | Object | Operation |
|---|---|---|
| Segment | Binary vector `D`, `s` = 20–300 synapses out of `n` potential | `D · A_t ≥ θ` → NMDA spike |
| Neuron | ~100 segments, each with its own `D` | Detects hundreds of distinct patterns |
| Region | 10⁶ neurons, each detecting hundreds | The population-level error bound |

Two properties do the work, and both are absent from the standard artificial unit:

- **Sparse connectivity is the model, not an approximation of it.** Presynaptic activity not connected to a segment has *no* effect on it — there is no zero weight to be swamped by a large input. A conventional unit is fully connected to its input layer; this one samples ~0.3% of it.
- **Segments are independent.** No single somatic threshold arbitrates between them. This is what allows one cell to hold many unrelated patterns without them interfering — the interference is bounded by the SDR overlap arithmetic, not by weight competition.

**What the paper deliberately does not model:** how a dendritic spike becomes a somatic spike. It is scoped as "the overall accuracy of any such model is bounded by the accuracy of its segments", which is a real result but leaves the neuron's output function open. Existing proposals: two-layer perceptron (Poirazi et al. 2003), synchrony propagation and precisely-timed sequence replay in recurrent nets (Jahnke et al. 2013; Breuer et al. 2014), sequence memory over networks of such cells (Hawkins & Ahmad 2016).

---

## The prediction — theory fixing a biological constant

The one place on this wiki where a derived scaling law names a measured biophysical parameter in advance.

| Step | Content |
|---|---|
| Sweep | `n` from 10⁴ to 2×10⁵, activity 0.5–3%, `s` from 20 to 50 |
| Quantity | Median probability of error as a function of `θ`, marginalised over everything else |
| Result | `θ ≥ 9` gives error below 1 in 10⁹; beyond `θ ≈ 15–20` returns diminish and the extra synapses are metabolically unjustified |
| **Predicted optimum** | **`θ` between 9 and 20** |
| **Measured NMDA spike threshold** | **8 to 20** (Major et al. 2013; Branco & Häusser 2011) |

A second, independent match falls out of the union property: mixing more patterns onto one segment requires a *higher* threshold to hold the error rate, which is exactly the observation that more active synapses are needed to initiate an NMDA spike when they are spread over a longer stretch of dendrite (Major et al. 2013; McBride et al. 2008). And segment sizes of 100–400 synapses translate to **4–16 independent patterns per segment** — a capacity number for a piece of dendrite.

---

## What a dendritic match is *for* — an open list

The paper's own admission: it computes detection accuracy and does not say what the neuron does with a detection. Candidates in the literature, all live:

| Proposed function | Source |
|---|---|
| Translation invariance | Mel et al. 1998 |
| Efficient propagation of activity | Polsky et al. 2009 |
| **Top-down prediction** (apical dendrites as the prediction channel) | Larkum 2013 |
| Sequence storage / replay | Losonczy et al. 2008; Branco et al. 2010; Hawkins & Ahmad 2016 |
| Gain control | Larkum et al. 2004 |

The 50–200 ms depolarization is the strongest hint: a detection that does not itself fire the cell but biases it for a behavioural interval is functionally a **prediction with a hold time**, which is the interface [[wiki/concepts/predictive-coding-free-energy.md]] needs and the licensing signal gap G19 asks for — a plateau that says *write now* rather than a coactivity that says *these two fired*.

---

## Consequences for a builder

**(brainstorm) A segment is a key-value pair with the value fused into the address.** `s` synapses are the key, the NMDA spike is a one-bit value, and `θ` is the match tolerance. A layer of such units is content-addressable retrieval with `O(1)` cost per key and no softmax — attention's function without attention's `O(M)` scan ([[wiki/concepts/attention.md]]). What it cannot do is return a *value*: it returns membership, and something else must supply the content.

**(brainstorm) Unit count is the wrong budget.** If one artificial neuron models one segment, a cortical column of 10⁴ cells is 10⁶ units; if it models one cell, the artificial network has ~100× less pattern memory per unit than the biological one it is compared against. Every "N-neuron network" comparison on this wiki is off by two orders of magnitude in one direction or the other, and which one depends on an unstated modelling choice.

**Dendritic ANN precedent, and Ahmad's correction to it.** Poirazi & Mel 2001 showed active-dendrite neurons beat linear neurons of the same synapse count on capacity and error. Ahmad's analysis says their simulation was run at dimensionality 400 — a sub-optimal regime by the scaling law — and their error rates would improve by orders of magnitude at biologically realistic `n`. **The lesson is transferable: dendritic architectures evaluated at small input dimension will under-report their own advantage**, because the mechanism's payoff is superexponential in `n`.

---

## Limitations

| Limit | Consequence |
|---|---|
| No dendrite → soma model | The neuron's actual output function is undefined; all results are bounds on what a cell built from these parts *could* achieve |
| No learning rule | Which synapses a segment forms, and when, is out of scope — the recognition theory is compatible with any allocation policy that samples the target pattern |
| Binary activity and binary synapses | Argued to be a lower bound (see [[wiki/concepts/sparse-distributed-representations.md]]), not a demonstrated-tight one |
| Assumes decorrelated inputs | Correlated afferents raise segment overlap above chance; the tolerance is quantified, the general case is not |
| Cortex-wide uniformity is assumed, not shown | The claim that the same segment arithmetic holds for all pyramidal cells everywhere is an inference from the uniformity of pyramidal morphology |

---

## Connections

- **[[wiki/concepts/sparse-distributed-representations.md]]** — the mathematics this page's hardware runs: the segment's accuracy, capacity and optimal threshold are all consequences of overlap arithmetic on sparse high-dimensional binary codes, and neither page stands without the other.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the same dendritic substrate read as a learning story rather than a detection story: that page's "the dendrites are a high-dimensional random-feature basis and BTSP chooses a weighting on it" is this page's segment bank with a write rule attached, and the plateau that licenses a BTSP write is the NMDA/plateau event this page counts as a detection.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — narrows the space of local rules: if the computational unit is a segment with its own threshold, a credit signal must reach a *branch*, not a cell, which is what dendritic-error schemes assume and what makes the apical/basal split load-bearing rather than anatomical trivia.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — supplies a candidate physical prediction channel: a distal detection that depolarizes for 50–200 ms without firing the cell is a prediction held over a behavioural interval, separable from the feedforward drive that carries the evidence.
- **[[wiki/concepts/three-component-framework.md]]** — an architecture-slot proposal with a derived parameter, which is rare: the segment nonlinearity is the architectural commitment, and `θ ≈ 9–20` is fixed by the objective (minimise detection error) rather than tuned.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — a test case for the implementation level (T1): the transferable content is a nonlinearity and a connectivity pattern, not biophysics, and it arrives with a quantitative prediction that was confirmed — the strongest form of evidence this wiki's transfer argument can get.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the same research programme's other half: columns as reference-frame units voting on object identity, running on cells whose detectors are the segments described here; the voting operation is an overlap test over sparse codes.
- **[[wiki/concepts/attention.md]]** — the same retrieval function at different cost: a segment answers "is my key present" in one thresholded overlap with no scan over stored items, but returns one bit instead of a value-weighted mixture.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the counterweight: segment arithmetic only works while the presynaptic active fraction stays in the 0.5–3% band, and inhibitory channels are what hold it there regardless of how much input is arriving.
- **[[wiki/entities/spiking-neural-networks.md]]** — the natural substrate and an unexploited one: coincidence detection within a 1–5 ms window is a spike-timing computation, so a spiking implementation gets the segment nonlinearity for free where a rate model must add it by hand.
- **[[wiki/entities/dendritic-ann.md]]** — the controlled complement to this page's thesis: it imports the dendritic *connectivity graph* (tree partition + 16-pixel receptive fields) with none of the segment nonlinearity, and still gains 1–3 orders of magnitude in trainable parameters — so topology and nonlinearity are separable contributions, and the cheap one is already worth taking (Chavlis & Poirazi 2025).
- **[[wiki/entities/hodgkin-huxley-model.md]]** — the biophysics that licenses this page's central claim: compartmentalized Hodgkin–Huxley equations with axial coupling let a segment hold a voltage distinct from the soma, which is the precondition for a segment having its own threshold at all; and both pages share the rare pattern of a fitted parameter (`n⁴`, `θ ≈ 9–20`) that later matched measured structure.
