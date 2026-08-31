# CA3 Inhibitory Replay Filter

**A model in which one Hebbian long-term-potentiation rule at *inhibitory* synapses — the same symmetric spike-timing rule already used at the excitatory ones — is what makes offline replay sample the generalizable structure of the world rather than the sequence of observations that carried it; validated by optogenetically implanting statistically unpredictable representations into awake mouse hippocampus and showing they accumulate inhibition in sharp-wave ripples.** Liao, Terada, Raikov, Hadjiabadi, Szoboszlay, Soltesz & Losonczy 2024, *Nature Neuroscience* 27:1810–1821 (`raw/liao-2024-inhibitory-plasticity-replay-generalization.md`; the preprint is cited across this wiki as "Liao et al. 2022").

The problem it poses: in a world where no two episodes are identical, the network **cannot know at encoding time which stimuli are structure and which are distractors**, so it must represent everything online and select afterwards. That makes the selection rule — not the storage rule — the interesting object, and this page's claim is that the selection rule is a plasticity rule at the GABAergic synapse.

---

## Three models, one rule

| Level | Specification | What it establishes |
|---|---|---|
| **Spiking network** | 8,000 leaky integrate-and-fire pyramidal cells + 150 interneurons (Brian 2), spike-rate adaptation; `p(PC→PC) = p(PC→IN) = 0.10`, `p(IN→IN) = p(IN→PC) = 0.25`; 50% place-tuned, 10% distractor-tuned (non-exclusive); interneurons may be place-, cue-, both- or un-tuned. 40 laps of a 3 m belt; distractor appears at a **randomly relocated** point each lap. Offline = unstructured Poisson drive to all PCs (mossy-fibre surrogate) | Replay in both directions emerges with no external "replay signal" and no non-local rule, and cue cells are **selectively suppressed inside ripples while remaining active outside them** |
| **Biophysically detailed** | 260 multicompartmental pyramidal cells + 30 interneurons with per-pathway dendritic input streams; 80% of PCs receive place (mossy fibre) + grid (medial entorhinal) input, 20% receive the distractor via the lateral entorhinal pathway | Necessity and sufficiency (table below), plus measurable predictions at the synapse: median `w_{I→cue} = 0.0063 µS` vs `w_{I→place} = 0.0046 µS` (**+38.9%**, `p = 2.5×10⁻¹⁸⁷`), and larger inhibitory postsynaptic currents onto cue cells at every holding potential from −65 to −45 mV |
| **Abstract binary** | One "concept neuron" per schema, all-to-all; excitatory count matrix `W` and inhibitory count matrix `W^I` | The normative claim: replay is a *statistical estimator* of the ground-truth sequence, and it is consistent only with the inhibitory term |

**The three levels share exactly one commitment**: symmetric spike-timing-dependent plasticity (sSTDP) applies to `I→E` synapses as well as `E→E`. Robustness sweep: any Hebbian LTP rule on `I→E` with a **~3 ms** kernel reproduces the effect, so the model constrains the sign and the timescale, not the kernel shape.

---

## The rule and the estimator

Per observed transition `x_i → x_{i+1}`:

```
W_{x_i x_{i+1}}   += 1                       # excitatory, symmetric (CA3's kernel is symmetric)
W^I_{x_i x_i}     += 1                       # inhibition onto the cell that just fired
W^I_{x_{i+1} x_i}, W^I_{x_i x_{i+1}} += β    # β < 1, the inhibitory kernel decay
```

Offline dynamics (the **REPLAY estimator**, run for `K` steps from a randomly excited start):

```
ŷ_{t+1} = σ( (W − α W^I) ŷ_t ) ,   α > 1  (α = 1.5 used),  σ = sample a one-hot from the non-negative entries
Ŷ = (ŷ_0, ŷ_1, …, ŷ_K)
```

`α > 1` encodes that **inhibition predominates during ripples**. Forward vs reverse events are modelled by restricting to the lower or upper half-diagonal of `W` — the abstract stand-in for the adaptation current that stops the sequence doubling back.

### Why excitation alone fails, stated as a graph problem

- Noiseless world: Hebbian LTP on `E→E` alone potentiates the diagonal band and replay walks the true sequence. **Excitation suffices.**
- Noisy world: a distractor appearing at a *random* position each lap potentiates **off-diagonal** entries linking it to whatever was active then. Over laps it acquires an edge to every schema, so the learned graph closes into a near-complete graph with cycles, and replay — which samples that graph — emits out-of-order sequences.
- Blocking the distractor node at replay time removes every side path in one operation, and the walk returns to the world's structure.

**So the Hebbian count matrix is not a consistent estimator of the world's adjacency, and the inhibitory matrix is the correction term.** This is the sharpest statement in the wiki of why [[wiki/concepts/latent-graph-discovery.md]]'s edge-writing step needs a second, subtractive channel: coactivity counts converge to *co-occurrence*, and the object wanted is *conditional* structure.

### Why the inhibition lands on cue cells and not place cells

The selection needs no cue-detector and no supervisory signal — it falls out of *whose partners vary*:

| Step | Consequence |
|---|---|
| Distractor input drives both pyramidal cells and interneurons above the near-uniform baseline that tiled place fields produce | A local, transient rate increase in **both** populations |
| Elevated rates compress pre/post spike timings into the ~3 ms inhibitory LTP window | `dW^I/dt` rises for whichever pyramidal cells are active at that moment |
| The distractor's *location* is re-randomised every lap | The place cells that receive the potentiation are **a different subset each lap** → inhibition onto the place population is spread thin |
| The cue population is **the same cells every lap** | Inhibition onto cue cells accumulates trial after trial |

**The discriminating statistic is therefore variance of the co-active set across episodes, computed with no memory of the episodes.** A representation whose partners recur gets diluted inhibition; a representation whose partners are unpredictable gets concentrated inhibition. That is "keep what recurs, suppress the idiosyncratic" ([[wiki/concepts/recall-gated-consolidation.md]]) obtained without a recall gate, without a broadcast scalar, and without an offline evaluation — the accumulator runs during behaviour and is read out at rest.

**(brainstorm) The machine form is a frequency-discounted transition estimator.** `W` counts pairs, `W^I` counts (mostly) single-node occurrences, and replay logits are `W − αW^I` — the same shape as shifted pointwise mutual information / negative sampling: subtract a multiple of the marginal from the joint, so an edge survives on its *conditional* probability rather than its raw count. A replay buffer that scores candidate transitions by `count(a,b) − α·count(a)` rather than by `count(a,b)` is a one-line import, and it is the only mechanism in the wiki that suppresses a high-frequency-but-uninformative node without being told which node that is.

---

## Necessity and sufficiency

| Plasticity configuration | Place/cue correlation during offline events | Verdict |
|---|---|---|
| `E→E` + **`I→E`** sSTDP (the model) | `r = −0.19`, `p < 5×10⁻¹²` (1,288 bins, 225 s) | Cue cells suppressed during replay |
| `E→E` only | `r = 0.10`, `p = 0.71` — co-active | Inhibitory plasticity is **necessary**; restoring it restores suppression |
| `E→E` + `E→I` | `r = 0.75`, `p = 6.2×10⁻²³⁴` — strongly co-active | Plasticity *onto* interneurons is not a substitute; the locus must be the `I→E` synapse |
| `E→E` only, **<3% cue cells** | Forward and reverse replay still emerge | Inhibitory plasticity is **not** needed for replay itself — only for the filter |

The last row is the one that settles a standing wiki disagreement: models that reproduce spontaneous bidirectional replay with a static inhibitory background (Ecker et al. 2022; Nicola & Clopath 2017) and models that require inhibitory plasticity are explaining **different phenomena** — sequence generation versus sequence selection — and this paper reproduces both regimes in one network by varying the distractor fraction ([[wiki/concepts/synaptic-plasticity.md]]).

---

## The experiment

Sparse optogenetic induction of *artificial* cue cells in awake behaving mice (ChRmine under a diluted-Cre sparse-labelling scheme; GCaMP8m imaging; CA3/CA2 and CA1):

| Manipulation | Result | What it establishes |
|---|---|---|
| Pyramidal-cell stimulation **paired** with a randomly presented sensory cue | Those cells become **suppressed** during subsequent sharp-wave ripples | The model's central prediction: a representation with unpredictable statistics accumulates inhibition. The content was *implanted*, so this is not a selection artefact of which cells happened to encode cues |
| Pyramidal-cell stimulation **unpaired** with any sensory cue | Those cells show **increased** ripple recruitment | Post-synaptic activation alone does not do it — presynaptic sensory-driven inhibition and postsynaptic firing are **both** required, i.e. the plasticity is correlative and at the inhibitory synapse |
| Same paired protocol in **CA1** (few recurrent collaterals) | Same suppression | The filter's locus is the `I→E` synapse, not the recurrent excitatory network — so this is a candidate general coding principle rather than a CA3 specialisation |
| Cue responses entrained onto arbitrary pyramidal cells | Stable, novel non-spatial selectivity | First artificial induction of a **non-spatial** representation in hippocampal pyramidal cells: feature selectivity is acquired by rapid plasticity over a rich set of available inputs, not developmentally allocated ([[wiki/concepts/memory-allocation-excitability.md]]) |

---

## Predictions left open

| Level | Prediction |
|---|---|
| Synapse | Inhibitory postsynaptic currents onto cue cells > onto place cells, measurable by paired recording from identified interneuron classes |
| Cell type | The responsible interneurons **respond to sensory cues during exploration but keep stable ripple recruitment**; cholecystokinin-expressing cells are the paper's candidate (Vancura et al. 2023) |
| Network | Interneuron firing rates stay stable across learning (because `E→I` plasticity would break the mechanism — see the necessity table) |
| Behaviour | Ablating inhibitory plasticity should impair world-structure inference and goal-directed performance while leaving online representations intact |
| Scope | Non-spatial relational structures obeying a well-defined distance metric should be learnable and replayable by the same mechanism — the model is agnostic to what the schemas mean |

---

## Limitations

- **Interneurons are one uniform pool.** The four genetically defined families have different ripple phase preferences, different fan-in breadth and different coding jobs ([[wiki/concepts/inhibitory-control-of-coding.md]]); which of them carries this rule is unmeasured, and the required "cue-responsive, ripple-stable" profile is a strong constraint the paper cannot yet satisfy from data.
- **The consistency claim is asymptotic** ("in the limit of observations") and argued, not proved with a rate; nothing says how many laps are needed before `W − αW^I` recovers the true adjacency.
- **The environments are 1-D sequences.** The defence — any environment is experienced as sequential trajectories through it — is the same assumption [[wiki/concepts/successor-representation.md]] makes, and it inherits the same exposure-to-coverage problem.
- **Awake replay only.** Sleep replay is forward-biased and noisier; the model reproduces that regime only by conjecture (change the offline input statistics from localised to stochastic).
- **`α > 1` is asserted, not learned.** The excitation/inhibition ratio during ripples is the one free parameter that decides how aggressive the filter is, and nothing in the model sets it ([[wiki/concepts/excitation-inhibition-balance.md]]).

---

## Why this matters for a reasoning model

- It supplies a **local, unsupervised, online rule whose effect is content selection** — the thing gap `G19` says no local rule has. The selectivity is not in the write rule; it is in a second write rule of opposite sign running on the same spikes.
- It makes the replay filter **buildable**: two count matrices, one subtraction, one temperature. No architecture change, no extra pass over data, no labels.
- It reframes generalisation as **edge pruning in a learned graph** rather than as representational compression, which is the form [[wiki/concepts/latent-graph-discovery.md]] can consume directly.
- It says what "noise" means operationally for a structure learner: **not low amplitude, but low predictability of what it co-occurs with** — a salient, reliably represented, high-firing stimulus is exactly the thing to suppress if its context varies.

---

## Connections

- **[[wiki/concepts/offline-replay.md]]** — the primary source behind that page's "the filter" row: it upgrades inhibitory plasticity from a modelling conjecture to a mechanism with a necessity test, a sufficiency test and an implanted-representation experiment, and it answers that page's open problem "is the inhibitory filter learned?" in the affirmative.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the inhibitory-plasticity row's worked instance, and the resolution of that page's "models both require it and reproduce replay without it": the two model families explain sequence *generation* and sequence *selection* respectively, and both regimes appear in this network as a function of distractor density.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the same claim at a different grain: that page shows inhibitory channels set the *features* of the online code, this one shows an inhibitory channel sets the *content* of the offline sample; and its cell-type taxonomy is the instrument that would identify the interneuron population this model needs.
- **[[wiki/concepts/recall-gated-consolidation.md]]** — the same selection criterion ("keep what recurs") derived normatively there and implemented here without its broadcast gate: the discriminating statistic is the across-episode variance of a representation's co-active partners, accumulated at the synapse during behaviour.
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — the complementary control variable: that page rations *how much* replay a relationship gets by its predictability, this one decides *which* representations enter the sample at all, and both make predictability the quantity that matters.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the model's core result restated as graph estimation: Hebbian coactivity counting converges to a near-complete graph under stochastic distractors, so a subtractive inhibitory term is what keeps the discovered adjacency sparse and conditional rather than joint.
- **[[wiki/concepts/pattern-separation-completion.md]]** — completion is what lets a random offline kick reinstate a whole sequence; this page adds that the completion is *steered*, with learned inhibition deciding which basins are reachable during a ripple.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the same CA3 recurrent attractor with the inhibitory pool made plastic and made informative: where that model uses inhibition to hold sparseness constant, here its trained structure is the memory of which representations were unpredictable.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — the free parameter `α > 1`: the whole filter is an excitation/inhibition ratio that is dialled differently offline than online, and nothing in the model learns it.
- **[[wiki/concepts/memory-allocation-excitability.md]]** — the counterpart result on the write side: cue selectivity can be entrained onto arbitrary pyramidal cells by pairing stimulation with a sensory cue, so which cells carry a non-spatial feature is set by rapid plasticity rather than by developmental wiring.
- **[[wiki/concepts/temporal-coding.md]]** — the mechanism's only hard timing constraint: the inhibitory LTP kernel must be ~3 ms wide, and the effect exists because distractor-driven rate increases *compress spike timings* into that window.
