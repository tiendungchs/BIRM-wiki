# The Connectivity Scaling Bottleneck — What Happens to a Graph When You Scale the Node Count Under a Physical Edge Budget

**In a spatially embedded network, long-range wiring is bought in a currency (volume, cross-sectional area) that grows more slowly than the thing it has to connect (surface, unit count). Measured across primates over a 350-fold range of brain size, every consequence follows mechanically: edge density falls, the length distribution shifts short, mean path length rises, clustering rises, and the two nominally redundant hemispheres' connectivity profiles diverge. Local specialisation and lateralisation are therefore *predictions of scale under a wiring budget*, not adaptations for whatever function ends up localised — and the same arithmetic applies to any architecture whose modules are scaled up behind a fixed interconnect.**

> **Provenance.** Ardesch, Scholtens, de Lange, Roumazeilles, Khrapitchev, Preuss, Rilling, Mars & van den Heuvel 2022, *Scaling Principles of White Matter Connectivity in the Human and Nonhuman Primate Brain*, Cereb. Cortex 32(13):2831–2842, doi:10.1093/cercor/bhab384 (`raw/ardesch-2022-white-matter-scaling-principles.md`). Structural and diffusion MRI (in vivo and postmortem) across **14 primate species** — 5 great apes incl. human, 1 lesser ape, 3 Old World monkeys, 4 New World monkeys, 1 strepsirrhine — spanning cerebral volume 2.6 cm³ (Senegal galago) to 905 cm³ (human) and cortical surface 11 cm² to 1555 cm². Volumetric fits by phylogenetic generalised least squares on log data (so coefficients are scaling exponents); network fits on *z*-scored data (standardised β). Network metrics computed at **equalised density across species** and normalised against 1000 degree-preserved rewired nulls.

This page is the *substrate-and-topology* half of the scaling story. [[wiki/concepts/cellular-scaling-rules.md]] prices the units (`M ∼ N^a`); this page prices the **edges between them**, and shows that the two exponents point in opposite directions — primates add units cheaply (`a ≈ 1.06`) and connect them expensively.

---

## The volumetric exponents

`log(y) = b · log(x) + c`. Isometry is `b = 1` for volume-against-volume or surface-against-surface, and `b = 2/3` for a surface against a volume.

| Relation `y ~ x` | `b` (95% CI) | Isometric | Reading |
|---|---|---|---|
| Cortical surface area ~ cerebral volume | **0.85** (0.82–0.88), adj. `R² = 0.99` | 0.67 | Surface outpaces volume — the cortex folds and thins to keep gaining area |
| White matter volume ~ grey matter volume | **1.10** (0.99–1.21), adj. `R² = 0.97` | 1 | White matter share of cerebrum rises: 37% galago → 39% capuchin → 43% gorilla → **48% human** |
| Cortical surface area ~ white matter volume | **0.78** (0.73–0.83) | 0.67 | Surface still outpaces the wire, even though the wire is winning against grey matter |
| **Corpus callosum cross-section ~ cortical surface** | **0.88** (0.81–0.95), adj. `R² = 0.98` | 1 | **Negative allometry.** Cortex served per cm² of callosum: 90 cm² (galago) → 132 (chimpanzee) → **211 (human)** |

**The squeeze in one line:** white matter *volume* grows faster than grey matter, and is still not enough, because the surface it must serve grows faster still — and the one structure that is purely a long-range crossing point, the corpus callosum, is the only term that scales *below* isometry.

*Note on the source's own wording:* the discussion calls `b = 0.78` for surface-on-white-matter "negative allometric", but 0.78 exceeds the 2/3 expected for a surface against a volume, and the figure caption for the same panel says positive allometry. The directional claim the paper needs — surface outpaces wire — is the one supported; the "negative" label on that row is a slip. The callosum row (0.88 against an isometric 1, surface against surface) is unambiguously sub-isometric and carries the argument on its own.

---

## The topological consequences

All against cerebral volume, standardised β, density equalised across species so these are **not** artefacts of the density decline in the first row.

| Statistic | β (left hemisphere) | Direction with size | Numbers |
|---|---|---|---|
| Network density | **−0.76** (`p = 2.5 × 10⁻³`; right −0.73) | Falls | 52% (galago) → 31–37% (great apes incl. human) |
| Proportion of *shortest* connections (bins 1–2 of 10, each bin = 10% of anterior–posterior length) | **−0.65** on the long-vs-short contrast (`p = 1.7 × 10⁻²`) | Short fraction rises | Short: 36% galago / 29% night monkey → 41% chimpanzee → **60% human**. Long: 63% / 71% → 59% → **40%** |
| Characteristic path length `L` | **+0.74** (`p = 3.6 × 10⁻³`; right +0.66) | Rises | More hops between arbitrary regions in bigger brains |
| Clustering coefficient `C` | **+0.75** (`p = 3.0 × 10⁻³`; right +0.64) | Rises | Local segregation compensates |
| **Connectivity asymmetry** (mean absolute difference between the connectivity profiles of left/right spatial homologues, weights resampled to a common distribution) | **+0.73** (`p = 5.0 × 10⁻³`; permutation null `p < 2 × 10⁻¹⁶`) | Rises | Larger brains' hemispheres wire *differently*, not just separately |

Supplementary: long-tailed degree distribution, a rich club, and rising betweenness centrality with size — i.e. the [[wiki/concepts/connectome-hubs-and-cores.md]] picture is present across the clade, and gets *more* pronounced with scale.

**`σ` is not scale-invariant.** Both `C` and `L` rise with size against degree-preserved nulls. A small-world summary statistic therefore describes a *point on a size trajectory*, and comparing `σ` between two networks of different `N` compares their sizes as much as their designs ([[wiki/concepts/small-world-topology.md]]).

---

## Why this is a bottleneck and not merely a cost

The three effects compose into one mechanism:

1. **Fixed fan-out per unit.** Across primates, average neuron size — soma plus its entire arbour — is invariant with brain size ([[wiki/concepts/cellular-scaling-rules.md]]). Units are added at constant wiring-per-unit.
2. **The physical budget for *long* edges grows sublinearly.** Long connections need larger axon diameters to hold conduction time roughly fixed as distance grows (Ringo 1991; Ringo et al. 1994, cited in source), so they are the expensive ones and they are the ones rationed — hence the shift of the length distribution toward short.
3. **Therefore the answer is local computation plus divergent duplicates.** Rising `C` is the compensation for rising `L`; rising connectivity asymmetry is the compensation for a callosum that cannot keep pace. When two copies of a system cannot be kept in sync cheaply, letting them specialise is the *efficient* outcome, not a failure of coordination.

**The cost that is not paid back:** reduced redundancy. High lateralisation with low global connectivity means fewer alternative routes, which the source ties to the human brain's vulnerability to focal damage (stroke, and callosal involvement across a wide range of neurological and psychiatric conditions).

---

## What a builder takes from it

| Move | Statement |
|---|---|
| **Emergent modularity in a scaled model is weak evidence of discovered function** | Specialisation is what a spatially/bandwidth-constrained graph does when you grow it, independent of the task. A large model that develops distinct specialised subnetworks has demonstrated the arithmetic, not a semantic decomposition. The control is a size-matched model at the *same* interconnect budget on a different task distribution |
| **Price cross-module edges as a function of scale, not as a constant** | `G84`'s complaint made quantitative: the crossing point's capacity should scale *sub*-linearly with module count by design if it is imitating this system, and the machine analogue is exact — all-reduce/all-to-all bandwidth per expert falls as expert count rises behind a fixed fabric, which is the same 0.88-exponent squeeze on a different substrate **(brainstorm)** |
| **Let redundant replicas diverge** | Two hemispheres are a redundant pair whose profiles measurably diverge with scale, and the divergence is adaptive. A model-parallel or ensemble pair under a limited interconnect should be permitted (or encouraged) to specialise rather than regularised toward agreement — the synchronisation cost is exactly what this scaling law says grows fastest **(brainstorm)** |
| **Report `C`, `L` and density with `N`** | Any topological claim about a trained network is uninterpretable without its size, because all three move with size under a constant design. This page supplies the biological null curve to compare a machine trajectory against |
| **The knee is where the compensation starts** | The transferable prediction: sweep unit count at fixed per-unit fan-out and watch for the point where clustering starts rising to offset path length. That is the scale at which a flat architecture begins behaving like a modular one whether or not it was designed to. Unrun anywhere in the wiki |
| **Human network organisation is on the primate line** | Longer paths, higher clustering, higher asymmetry are all *predicted* from human brain size by fits containing 13 other species. Human network specialisation needs no human-specific mechanism — the same out-of-sample discipline [[wiki/concepts/cellular-scaling-rules.md]] applies to cell counts, applied to topology |

---

## Open problems

- **Diffusion tractography is the only instrument.** It produces both false-positive and false-negative fibres, and long, crossing and lateral tracts are precisely where it is weakest — which is the same category the paper's central claim is about. The mitigations used (restricting weighted analyses to connections present in both hemispheres, averaging across regions) reduce noise, not directional bias.
- **Cerebrum only.** The cerebellum was absent from several postmortem samples and excluded — and it is the structure holding ~80% of brain neurons and expanding fastest in the ape lineage ([[wiki/concepts/cellular-scaling-rules.md]]). Whether cerebellar connectivity obeys or escapes the same squeeze is unmeasured.
- **The exponents are clade-bound.** Positive white/grey allometry holds in primates and is *absent* in artiodactyls (Mota et al. 2019, cited in source), so these are not laws of spatially embedded networks in general — which is exactly what a transfer to machines would need them to be.
- **No causal step anywhere.** Every entry in the topological table is a cross-species regression on 14 points. Nothing lesions a long-range tract and measures the predicted rise in local clustering; the compensation account is inferred from the correlation's sign.
- **Density-equalisation is doing work.** `L`, `C` and asymmetry are computed at matched density precisely because density itself falls with size, so the reported rises are "beyond what the density decline explains" — a defensible choice that also discards the possibility that the density decline *is* the mechanism rather than a confound.
- **Which fibres, which areas.** The result is macroscale only; the paper's own closing statement is that meso- and microscale work is needed to say which cortical areas, bundles and cell types implement the shift. Without that, the machine transfer has a shape and no placement rule.

---

## Connections

- **[[wiki/concepts/cellular-scaling-rules.md]]** — the two halves of one budget: that page measures units against substrate (`M ∼ N^a`, primates `a ≈ 1.06`, i.e. constant wiring per unit), this page measures the *edges between* units against the surface they must serve (callosum `∼ surface^0.88`), and the composition is the whole argument — cheap units plus expensive long edges forces local processing at scale.
- **[[wiki/concepts/small-world-topology.md]]** — the size-dependence that page's static statistic hides: `C` and `L` both rise with brain size against degree-preserved nulls across 14 primates, so `σ` is a point on a scaling trajectory rather than a design property, and comparing it across networks of different `N` compares sizes.
- **[[wiki/concepts/emergent-modularity.md]]** — supplies the measurement that page names as missing: degree of lateralisation plotted against brain size across primates (connectivity asymmetry β = +0.73, `p = 5 × 10⁻³`, permutation `p < 2 × 10⁻¹⁶`), which is the strongest available evidence for the consequence-of-scale position in [[wiki/empirical-tensions.md]] T290 while still not holding a function fixed.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — the same graph statistics measured on one species at high resolution and here measured coarsely across 14: the rich club, the long-tailed degree distribution and rising betweenness are conserved features whose *prominence increases with brain size*, so a hub-and-core design is what a scaled-up version of a small brain becomes.
- **[[wiki/concepts/integration-segregation-balance.md]]** — the runtime axis whose *set point* this page fixes: that page shows between-module connectivity moving in ~10 s on a fixed anatomy, and this page says the anatomy that axis is anchored on slides toward the segregated end as the network grows, so a big brain negotiates a shorter integration lever.
- **[[wiki/concepts/broadcast-hierarchy.md]]** — the functional interpretation of the length shift: if short connections carry local generative-model detail and sparse long-range projections form the broadcast overlay, then the measured drop from 71% to 40% long connections says the broadcast layer is the part that gets *thinner* with scale, not the local one.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a scale-dependent prior for the discovery side: the fraction of true edges that are long falls with system size, so the correct edge-length prior for a recovery algorithm is a function of the graph's `N`, and a prior tuned on a small system will over-propose long edges on a large one.
- **[[wiki/concepts/sparse-expert-routing.md]]** — the machine substrate where the same exponent bites: adding experts behind a fixed interconnect fabric divides a sub-linearly growing cross-device bandwidth among a linearly growing set of modules, which is this page's squeeze with hardware in place of white matter, and predicts the same answer — more local computation per expert, less cross-expert traffic **(brainstorm)**.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — a constraint on how much interhemispheric coherence can mean: the callosal cross-section per unit cortex falls by a factor of 2.3 from galago to human, so the physical channel that cross-hemisphere coupling must run on is scarcest exactly in the species most of the wiki's coherence claims come from.
