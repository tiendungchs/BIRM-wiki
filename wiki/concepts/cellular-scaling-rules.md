# Cellular Scaling Rules

**Brain mass is a power law of neuron number, `M ∼ N^a`, and the exponent `a` is a property of the *clade and the structure*, not of brains in general — so mass, relative mass and encephalization are all uninformative about unit count across orders. Since `M ≈ N · s̄` with `s̄` the average unit size (soma plus its entire dendritic and axonal arbour plus synapses), `a` decomposes as `s̄ ∼ N^(a−1)`: the exponent says whether a lineage bought capacity by adding units or by growing the wiring per unit.**

> **Provenance.** Herculano-Houzel 2009, *The Human Brain in Numbers: A Linearly Scaled-up Primate Brain*, Front. Hum. Neurosci. 3:31 (`raw/herculanohouzel-2009-human-brain-in-numbers.md`). A review of the author's own isotropic-fractionator counts (whole-brain tissue homogenates, anatomically defined regions) across 18 species of rodents, primates and insectivores, plus the first direct count of a whole human brain (Azevedo et al. 2009). Every number below is measured except the whale/elephant rows, which the source marks as predictions.
>
> **Second provenance.** Herculano-Houzel & Kaas 2011, *Gorilla and Orangutan Brains Conform to the Primate Cellular Scaling Rules: Implications for Human Evolution*, Brain Behav. Evol. 77:33–44 (`raw/herculanohouzel-2011-gorilla-orangutan-brains-conform-primate-cellular-scaling-rules.md`). Same lab and same method, so not an independent replication. It counts **cerebellum only** (1 gorilla, 3 orangutans); every great-ape cortex and whole-brain number in it is *predicted* from the cerebellar count, and every hominin number is predicted from cranial capacity. See § Great apes and hominins below.

---

## The exponents

`M ∼ N^a`, fitted **within** an order, ignoring body mass entirely:

| Structure | Rodents | Insectivores | Primates |
|---|---|---|---|
| Whole brain | `N^1.550` | `N^1.016` | `N^1.056` |
| Cerebral cortex | `N^1.744` | `N^1.520` | `N^1.077` |
| Cerebellum | `N^1.372` | `N^1.028` | `N^0.990` |
| Remaining (brainstem + diencephalon + basal ganglia) | `N^1.153` | `N^0.926` | `N^1.013` |

*Primate fits exclude human values, which makes the human brain an out-of-sample test of them.*

| Reading | Consequence |
|---|---|
| **`a ≈ 1` (primates)** | `s̄` invariant: neuronal density and the non-neuronal/neuronal ratio do not change with brain size. Units are added at **constant wiring per unit** |
| **`a > 1` (rodents; insectivore cortex)** | `s̄ ∼ N^0.74` in rodent cortex: added units are *also bigger* units. Density falls, glia:neuron rises with size |
| **The exponent is per-structure** | Insectivores are primate-like in cerebellum (`1.028`) and rodent-like in cortex (`1.520`). One brain runs two regimes at once, so `a` is not a species constant |
| **Cost of a 10× unit increase** | Rodent brain: **35×** mass. Primate brain: **11×** mass |

**The economy is the whole result.** A hypothetical rodent brain with the human's 86 billion neurons would weigh **35 kg** — beyond the largest brain that has ever existed (9 kg, blue whale) and probably physiologically impossible. A rodent brain of human mass (1.5 kg) holds **12 billion** neurons, seven times fewer than a primate brain of the same mass.

---

## The human numbers

| Quantity | Generic rodent, 1.5 kg | Generic primate, 1.5 kg | **Human (measured)** |
|---|---|---|---|
| Neurons, whole brain | 12 B | 93 B | **86 B** (−7%) |
| Non-neuronal cells | 46 B | 112 B | **85 B** (−24%) |
| Cortex mass | 1154 g (77%) | 1412 g (94%) | **1233 g (82%)** |
| Cortex neurons | 2 B (17% of brain) | 25 B (27%) | **16 B (19%)** |
| Cerebellum mass | 133 g | 121 g | **154 g (10%)** |
| Cerebellum neurons | 10 B | 61 B | **69 B (80% of all brain neurons)** |

Three textbook facts die here: the brain does not have 100 billion neurons (86 B, outside the observed margin of variation); glia do not outnumber neurons 10:1 (they are **at most 50%** of all brain cells, ≈1:1 — the 10:1 figure holds only in subcortical nuclei such as thalamus and ventral pallidum); and the human brain is not an outlier in cellular composition — it is what the primate rules predict for its size, fitted without it.

**Relative size is not a proxy for relative units, and the two are uncorrelated.** Cortical mass ranges 42% (mouse) → 82% (human) of brain mass while cortical neurons stay at **13–28% of brain neurons in 15 of 18 species** (13% mole → 41% squirrel monkey). The "overdeveloped human cortex" holds the same *fraction* of brain neurons as a rodent's. What does scale together is the **absolute** neuron count of cortex and cerebellum, which rise in step and faster than the remaining areas — cortex and cerebellum are one coupled system, not competing ones.

---

## Great apes and hominins — the ape gap filled at the cerebellum only

Herculano-Houzel & Kaas 2011. The 2009 primate fits contain no great apes, which is the caveat `T301` and `G101` both rest on. This source adds apes, but only by counting their cerebellum.

**Method.** Isotropic fractionator on one cerebellar hemisphere (×2). Tissue had been in paraformaldehyde for >10 years, so immunostaining for neurons was impossible. Neurons were therefore identified by nuclear morphology (granule vs Purkinje) in samples of >40,000 nuclei. Cortex, whole brain and body mass are then predicted from the cerebellar cell count `C_CB` by regressions fitted on the 6 non-ape primates of Herculano-Houzel et al. 2007.

| Measured (cerebellum) | Gorilla (`n` = 1) | Orangutan (`n` = 3) |
|---|---|---|
| Mass | 37.56 g | 35.06 ± 4.34 g |
| Cells | 29.3 B | 28.5 ± 3.78 B |
| Granule cells (% of cells) | 26.4 B (90.1%) | 26.3 ± 2.47 B (92.3%) |
| Purkinje cells | 9.79 M | 13.10 ± 1.69 M |
| Granule : Purkinje | **2,697** | **1,912 ± 435** |
| Deviation from primate rule (from mass) | +37.7% | +31.9% |
| Deviation from rodent rule (from mass) | +371% | +384% |

The +32–38% deviation is attributed to fixation shrinkage, which lowers mass without changing cell number. Against literature cerebellar masses (gorilla 64.5 g, orangutan 48.5 g) the deviation is −24.7% and +5.2%.

**Exponents with the apes and humans added.** Cerebellar mass vs cells: `0.971`, and `0.997` after phylogenetic independent contrasts (9 species). Mass vs neurons: `0.999`, and `1.010` after contrasts. So the cerebellum stays at `a ≈ 1` through the hominids.

**Cortex and whole brain, predicted from `C_CB`.** The paper reports the prediction chain as accurate to ~20% for cortex across the 6 fitted species.

| | Predicted mass | Observed mass (literature) | Predicted neurons | Measured neurons |
|---|---|---|---|---|
| Orangutan cortex | 394 g | 415 g | 8.9 B | — |
| Gorilla cortex | 406 g | 377 g | 9.1 B | — |
| Orangutan whole brain | 470 g | 512 g | 32.6 B | — |
| Gorilla whole brain | 483 g | 486 g | 33.4 B | — |
| **Human cortex** | 1,287 g | 1,233 g | **23.7 B** | **16.3 B (−31%)** |
| Human whole brain | 1,433 g | 1,509 g | 92.8 B | 86.1 B (−7%) |

A rodent brain with the apes' cerebellar cell count would weigh ~2.8–2.9 kg, against ~0.5 kg observed.

**The one cortex where the chain can be checked misses by 31%, and the miss goes the way Position A of `T301` predicts.** Predicted from its cerebellum, the human cortex has the predicted mass (−4%) but only 69% of the predicted neurons. Non-neuronal cells miss further: 60.8 B against 103.4 B predicted. The paper does not comment on this row. The two ape cortical neuron counts (8.9 B, 9.1 B) come from the same chain, so the error is unknown for them.

The human:great-ape cortical neuron ratio follows from these numbers (derived here, not in the source). Human measured over ape predicted gives **1.8×**, for 3.0–3.3× the observed cortical mass. If the chain over-predicts ape cortex by the same 31% it over-predicts human cortex, the ratio becomes **2.6–2.7×**. Both values sit well above Shariff's 1.25×, and both sit below the 2.8–3.0× that Position B's exponent (`N^1.077`) implies for a 3.0–3.3× mass ratio.

**Body mass is the outlier, not the brain.** Body mass predicted from `C_CB` is 23.4 kg for the orangutan and 24.0 kg for the gorilla. Observed adult ranges are 30–90 kg and 70–275 kg, at least 114% and 316% above prediction. Human body mass matches its prediction of 67 kg. The source's reading is that great apes grew large bodies late in postnatal growth, after the brain had reached adult size (Shea 1983; Riska & Atchley 1985). Brain-body allometry exponents also depend on which species are sampled, while the neuronal rules do not (Gabi et al. 2010). So encephalization is a ratio with an unstable denominator.

**Hominins (predicted from cranial capacity via the 6-primate brain-mass regressions; nothing counted).**

| Taxon | Brain mass | Predicted neurons, whole brain | Predicted cortical neurons |
|---|---|---|---|
| *Pan troglodytes* | 406 g | 27.9 B | 8.0 B |
| *Australopithecus*, *Paranthropus* (6 species) | 407–525 g | 28.0–35.4 B | 8.0–10.0 B |
| *Homo habilis* | 599 g | 40.0 B | 11.3 B |
| *H. rudolfensis*, *H. ergaster* | 746–758 g | 49.0–49.7 B | 13.8–13.9 B |
| *H. erectus* | 963 g | **62.0 B** | 17.2 B |
| *H. heidelbergensis* | 1,200 g | **75.9 B** | 21.0 B |
| *H. neanderthalensis* | 1,353 g | **84.8 B** | 23.3 B |
| *H. sapiens* (same regression) | 1,408 g | 88.0 B | 24.2 B |
| *H. floresiensis* | 414 g | 28.4 B | 8.1 B |

Modern human range: 76–90 B (Azevedo et al. 2009). *H. heidelbergensis* and *H. neanderthalensis* fall inside it.

| What it shows | What it does not show |
|---|---|
| The ape cerebellum is on the primate line and ~5× off the rodent one. Adding apes and humans moves no exponent by more than 0.03 | Any great-ape **cortical** count. `T301`'s `Closes when` asks for exactly this, and it is still missing |
| Predicted ape brain and cortex masses match the literature to within 10% | That the apes' *cortical neurons* are on the line. Mass matching is what the chain predicts even if `s̄` differs, because the chain is fitted on mass |
| Great-ape body mass is the anomaly, so "the human brain is 3× too large for its body" is a statement about ape bodies | Anything about edges. Units, mass and body only (`G101`) |
| A predicted step in neuron count at early *Homo* (~50–60 B), then 62 B in *H. erectus* | Hominin counts that are independent of the rule. They are the rule applied to fossil volumes, so they cannot test it |

**For a builder (brainstorm).** If the hominin predictions hold, Neanderthal and *H. heidelbergensis* brains had modern unit counts several hundred thousand years before the archaeological signature of symbolic cognition. The source draws the same conclusion: what separated the species was "cultural accumulation and transmission". So unit count was in place before the capability appeared, and the capability needed something else. That fits the outlier-test reading in [[wiki/concepts/motivation-representation-synergy.md]] (a capability on its family's scaling line needs its *inputs* explained), and it bears on the `Homo erectus` window in [[wiki/concepts/emergent-modularity.md]]. The inference is two predictions deep: neurons from cranial volume, then cognition from archaeology.

---

## What a builder takes from it

| Move | Statement |
|---|---|
| **Name the currency** | Every proportion argument must say whether it is in units or in substrate. "82% of the brain is cortex" and "19% of neurons are cortical" describe the same organ; only the second is an architectural claim. The wiki's own module-share arguments are almost all in the first currency |
| **`a` is the architectural knob, not `N`** | Two lineages with the same `N` and different `a` are different architectures at the same width. The exponent is exactly what [[wiki/architectural-gaps.md]] `G101` asks for a measurement of — and the comparative record already contains the sweep, with the answer that the clade with the better cognition-per-gram is the one that held `s̄` **fixed** |
| **Machine networks sit outside both regimes (brainstorm)** | A dense layer costs `params ∼ N²`, i.e. `a = 2` — steeper than rodent cortex (`1.744`), the *worst* biological case. A fixed-degree sparse architecture is the primate regime, `a ≈ 1`. This makes sparse fixed-fan-in ([[wiki/concepts/sparse-expert-routing.md]], [[wiki/concepts/small-world-topology.md]]) a claim about scaling *exponents* rather than about efficiency at a given size, and predicts the gap widens without bound |
| **Out-of-sample first, uniqueness after** | Fit the law over the family with the candidate excluded, then ask whether the candidate lands on it. Human neuron count lands within 7%. A capability that lands on its family's scaling curve needs an explanation of its *inputs*, not of its internals ([[wiki/concepts/motivation-representation-synergy.md]]) |
| **Between-family, not within-family** | Brain size does not track neuron count *across individuals of one species* (rats, same age), and brain size does not correlate with cognitive ability within human families. `N` is a design variable, not a seed variable — the machine analogue is that parameter count predicts across recipes and says nothing across runs of one recipe |
| **The cerebellum holds 80% of the units** | The wiki models the structure holding 19% and almost never the one holding 80%, whose neuron count is the tightest correlate of cortical neuron count in the whole dataset |

---

## Open problems

- **No direct counts for the large-brained outgroups.** Whale and elephant cellular composition is *predicted*, and the two rule sets disagree tenfold on the same brain (false killer whale: 21 B under rodent rules, 212 B under primate rules). The source's own tie-breaker — measured grey-matter density ≈7000 neurons/mm³, rodent-like — is called speculative in the text, and the elephant cerebellum's actual ~1 kg is far above either prediction. **The claim "humans have the most neurons" is therefore unmeasured**, which matters because it is the claim the whole neuron-centred view rests on. The great apes are now counted only at the cerebellum. Their cortical counts are predicted through a chain that over-predicts the human cortex by 31% (Herculano-Houzel & Kaas 2011), so no hominid cortex other than the human one has a measured neuron count.
- **`N` → cognition is a correlation with no mechanism.** The source's own proposal — combinatorial interaction of units, so ability rises *exponentially* in `N` with possible thresholds — is stated without a model, and would make a 3× neuron ratio (human:gorilla = gorilla:baboon) mean different things at different absolute scales. That is an untested nonlinearity doing all the explanatory work.
- **The counts are for gross divisions only.** Cortex, cerebellum, and everything else lumped. Whether particular functional areas carry disproportionate units — the mosaic-evolution question, and the one that would bear on module-share arguments — is not answered by any number here.
- **Within humans, volume and cognition are reported both to correlate and not to.** Population meta-analyses find brain volume correlates with IQ (McDaniel 2005; Pietschnig et al. 2015, via Galakhova et al. 2022). This page's source finds no correlation within families. The designs differ: a within-family comparison removes shared background. So both results can hold, but they disagree about whether volume causes cognition or only co-varies with background. At the cellular level, higher IQ tracks thicker L2/L3 made of **larger cells at lower density, not more neurons** (Heyer et al. 2021) — a within-species `s̄` effect with `N` unchanged ([[wiki/entities/human-supragranular-pyramidal-neuron.md]]).
- **Why `a` differs between clades is unexplained.** The rules are descriptions; nothing says what developmental mechanism sets `s̄`'s dependence on `N`, so nothing says whether an engineer can choose the exponent or only inherit it.

---

## Connections

- **[[wiki/concepts/emergent-modularity.md]]** — direct empirical collision on the same organ: that page's scale-up-is-neuropil reading (2.75× chimpanzee cortical volume for 1.25× the neurons, Shariff 1953) requires `a ≈ 4.5` in the hominid cortex, against the `1.077` measured across primates by whole-brain counting ([[wiki/empirical-tensions.md]] T301). The great-ape data bound the human:ape cortical neuron ratio at ~1.8–2.7× for ~3× the mass, which excludes 1.25× under either reading of the prediction error. Predicted modern neuron counts in *H. heidelbergensis* and Neanderthals also sharpen that page's `Homo erectus`-window problem: the units preceded the cognitive event (Herculano-Houzel & Kaas 2011).
- **[[wiki/concepts/motivation-representation-synergy.md]]** — supplies the primary measurement behind that page's outlier test: the human neuron count is fitted-and-predicted rather than merely asserted to be on the line, and the fit that predicts it excludes humans. The great-ape data move the outlier test's anomaly from the human brain to the ape body: ape brains sit on the primate line, while ape bodies are 114–316% heavier than their cerebellar count predicts (Herculano-Houzel & Kaas 2011).
- **[[wiki/concepts/intelligence-density.md]]** — fixes the denominator's units: `C(S)` counted in substrate (mass, volume, watts) and `C(S)` counted in units diverge by a clade-specific power law, so any density argument that switches currencies mid-comparison is measuring the exponent rather than the system.
- **[[wiki/concepts/small-world-topology.md]]** — the wiring-cost account of why `a` cannot stay at 1 forever: constant `s̄` with growing `N` means constant fan-out, which is exactly the regime that forces long-range connections to be rationed rather than added.
- **[[wiki/concepts/sparse-expert-routing.md]]** — the machine architecture in the primate regime: adding experts at fixed per-token fan-in is `a ≈ 1` scaling of units against substrate, where a dense layer is `a = 2`.
- **[[wiki/concepts/dendritic-computation.md]]** — the mechanism that makes `s̄` a computational variable rather than a metabolic one: if a unit's arbour is itself a multilayer network, then rodent-style `s̄`-growth buys per-unit depth and primate-style `N`-growth buys width, and the two exponents become two different architectures rather than two prices.
- **[[wiki/concepts/convergent-circuit-motifs.md]]** — the same accounting at the other end of the size range: miniaturised planners are the case where `C(S)` is under direct selection, and this page supplies the exponent that says what shrinking `N` costs in a given clade.
- **[[wiki/concepts/neuron-complexity-index.md]]** — the per-unit column this page's accounting lacks: neuron counts and average neuron mass are measured per clade, but nothing measures what one neuron costs to *imitate*, and the minimal-fitting-network size is the first instrument that could put a number on "a human pyramidal cell is worth more than a mouse one" instead of asserting it. The first run gives human pyramidal models FCI 0.38 against 0.22 for rat, driven by dendritic area and NMDA steepness. Those are per-unit (`s̄`) variables, not `N` (Aizenbud et al. 2026).
- **[[wiki/concepts/connectivity-scaling-bottleneck.md]]** — the edge-side companion to this page's unit-side accounting: constant wiring-per-unit (`a ≈ 1.06`) is only half the budget, and the other half is measured to scale *sub*-isometrically — corpus callosum cross-section `∼ cortical surface^0.88` across 14 primates — so the same clade that adds units cheaply connects them at rising cost, which is why a scaled primate brain ends up locally clustered and lateralised (Ardesch et al. 2022).
- **[[wiki/entities/cerebellum.md]]** — this page's standing complaint given a page: the structure holding ~80% of brain neurons, whose absolute count is the tightest correlate of cortical neuron count in the whole dataset, now has a stated computation (internal models of the motor apparatus, one paired forward/inverse module per microzone) — so "cortex and cerebellum are one coupled system" can be read as a claim about what the second system computes for the first, rather than only as a regression coefficient. The great-ape cerebellum supplies that circuit's expansion ratio: granule cells are 90–92% of cerebellar cells, at ~1,900–2,700 per Purkinje cell (Herculano-Houzel & Kaas 2011).
- **[[wiki/concepts/width-versus-parameter-count.md]]** — the machine test of which exponent is the better buy: holding the *weight* budget fixed and spending it on more units rather than on denser fan-in raises ImageNet top-1 (11.7M weights at width 181 ≈ 90.7M weights at the same width), i.e. the primate move (`a ≈ 1.06`, constant wiring-per-unit) beats the rodent move (`s̄ ∼ N^0.74`) on a task and not merely in metabolic price (Golubeva et al. 2021).
- **[[wiki/entities/human-supragranular-pyramidal-neuron.md]]** — the per-unit measurements this page's per-clade exponents lack: synapse density roughly constant while human L2/3 dendrites are ~3× mouse, so synapses per neuron rise; and within humans, higher IQ tracks larger L2/L3 cells at lower density with no more neurons — `s̄` varying at fixed `N` (Galakhova et al. 2022).
- **[[wiki/entities/sparse-evolutionary-training.md]]** — a machine value for the synapse-per-unit ratio at fixed unit count: `ε` ≈ 11–20 edges per unit, rewired during training, matches or beats a dense layer. On i.i.d. benchmarks, then, the rodent move of adding wiring per unit buys nothing a sparse learned topology lacks. The comparison is two-point and confounded by overfitting (`G101`).
- **[[wiki/entities/rigl.md]]** — a machine test of how the wiring-per-unit ratio is spread, not only its mean: allocating each layer's edges in proportion to its input + output units beats uniform per-layer density at every sparsity. Its fixed-width density sweep puts the diminishing-returns point near 20% of dense edges on ImageNet.
