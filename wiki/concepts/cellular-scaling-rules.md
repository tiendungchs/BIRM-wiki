# Cellular Scaling Rules

**Brain mass is a power law of neuron number, `M ∼ N^a`, and the exponent `a` is a property of the *clade and the structure*, not of brains in general — so mass, relative mass and encephalization are all uninformative about unit count across orders. Since `M ≈ N · s̄` with `s̄` the average unit size (soma plus its entire dendritic and axonal arbour plus synapses), `a` decomposes as `s̄ ∼ N^(a−1)`: the exponent says whether a lineage bought capacity by adding units or by growing the wiring per unit.**

> **Provenance.** Herculano-Houzel 2009, *The Human Brain in Numbers: A Linearly Scaled-up Primate Brain*, Front. Hum. Neurosci. 3:31 (`raw/herculanohouzel-2009-human-brain-in-numbers.md`). A review of the author's own isotropic-fractionator counts (whole-brain tissue homogenates, anatomically defined regions) across 18 species of rodents, primates and insectivores, plus the first direct count of a whole human brain (Azevedo et al. 2009). Every number below is measured except the whale/elephant rows, which the source marks as predictions.

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

- **No direct counts for the large-brained outgroups.** Whale and elephant cellular composition is *predicted*, and the two rule sets disagree tenfold on the same brain (false killer whale: 21 B under rodent rules, 212 B under primate rules). The source's own tie-breaker — measured grey-matter density ≈7000 neurons/mm³, rodent-like — is called speculative in the text, and the elephant cerebellum's actual ~1 kg is far above either prediction. **The claim "humans have the most neurons" is therefore unmeasured**, which matters because it is the claim the whole neuron-centred view rests on.
- **`N` → cognition is a correlation with no mechanism.** The source's own proposal — combinatorial interaction of units, so ability rises *exponentially* in `N` with possible thresholds — is stated without a model, and would make a 3× neuron ratio (human:gorilla = gorilla:baboon) mean different things at different absolute scales. That is an untested nonlinearity doing all the explanatory work.
- **The counts are for gross divisions only.** Cortex, cerebellum, and everything else lumped. Whether particular functional areas carry disproportionate units — the mosaic-evolution question, and the one that would bear on module-share arguments — is not answered by any number here.
- **Why `a` differs between clades is unexplained.** The rules are descriptions; nothing says what developmental mechanism sets `s̄`'s dependence on `N`, so nothing says whether an engineer can choose the exponent or only inherit it.

---

## Connections

- **[[wiki/concepts/emergent-modularity.md]]** — direct empirical collision on the same organ: that page's scale-up-is-neuropil reading (2.75× chimpanzee cortical volume for 1.25× the neurons, Shariff 1953) requires `a ≈ 4.5` in the hominid cortex, against the `1.077` measured across primates by whole-brain counting ([[wiki/empirical-tensions.md]] T301).
- **[[wiki/concepts/motivation-representation-synergy.md]]** — supplies the primary measurement behind that page's outlier test: the human neuron count is fitted-and-predicted rather than merely asserted to be on the line, and the fit that predicts it excludes humans.
- **[[wiki/concepts/intelligence-density.md]]** — fixes the denominator's units: `C(S)` counted in substrate (mass, volume, watts) and `C(S)` counted in units diverge by a clade-specific power law, so any density argument that switches currencies mid-comparison is measuring the exponent rather than the system.
- **[[wiki/concepts/small-world-topology.md]]** — the wiring-cost account of why `a` cannot stay at 1 forever: constant `s̄` with growing `N` means constant fan-out, which is exactly the regime that forces long-range connections to be rationed rather than added.
- **[[wiki/concepts/sparse-expert-routing.md]]** — the machine architecture in the primate regime: adding experts at fixed per-token fan-in is `a ≈ 1` scaling of units against substrate, where a dense layer is `a = 2`.
- **[[wiki/concepts/dendritic-computation.md]]** — the mechanism that makes `s̄` a computational variable rather than a metabolic one: if a unit's arbour is itself a multilayer network, then rodent-style `s̄`-growth buys per-unit depth and primate-style `N`-growth buys width, and the two exponents become two different architectures rather than two prices.
- **[[wiki/concepts/convergent-circuit-motifs.md]]** — the same accounting at the other end of the size range: miniaturised planners are the case where `C(S)` is under direct selection, and this page supplies the exponent that says what shrinking `N` costs in a given clade.
- **[[wiki/concepts/neuron-complexity-index.md]]** — the per-unit column this page's accounting lacks: neuron counts and average neuron mass are measured per clade, but nothing measures what one neuron costs to *imitate*, and the minimal-fitting-network size is the first instrument that could put a number on "a human pyramidal cell is worth more than a mouse one" instead of asserting it.
