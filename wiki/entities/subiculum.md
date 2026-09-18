# Subiculum — the Store's Output Stage, Partitioned by Destination

**The hippocampal formation's principal excitatory output region, and not one bus. Molecular identity, position along three anatomical axes, long-range input, intrinsic firing phenotype, projection target and behavioural contribution *covary*, producing discrete, abutting excitatory subtypes that each occupy a spatial subdomain and each emit a specialised stream of hippocampal output to its own fixed *suite* of targets — the type set by **position**, and individual cells within a class collateralising across that suite rather than holding a labelled line to one consumer. Output selectivity is therefore a **wiring fact** at the store's exit, not a gating hypothesis — but the review's own closing argument is that diffuse CA1 input and dense local recurrence pull the other way, so the region balances *segregation versus integration* rather than sitting at either extreme.**

> **Provenance.** Kinman, Kraus & Cembrowski 2026, *The subiculum: cell-type-specific composition, computation, and function*, Trends Neurosci. 49(4):278–291 (`raw/kinman-2026-subiculum-cell-type-specific-composition.md`). A review, overwhelmingly rodent, integrating single-cell/spatial transcriptomics, immunohistochemistry, retrograde and trans-synaptic viral tracing, *ex vivo* slice electrophysiology and *in vivo* recording/optogenetics, with a cross-species section on monkey and human. Figures 1–3 and Tables 1–2 are images in the clip; the axis definitions and the coarse-domain table are reconstructed from the prose and the table's row labels. **No counts, connection probabilities or effect sizes appear in the clipped text.**

Why this earns a page. Every hippocampal page in the wiki names the subiculum and treats it as a waypoint — the place a projection passes through on its way to [[wiki/entities/retrosplenial-cortex.md]], [[wiki/entities/anterior-thalamic-nuclei.md]], [[wiki/entities/medial-prefrontal-cortex.md]] or [[wiki/entities/entorhinal-cortex.md]]. This is the first source held on the waypoint itself, and its claim is that the waypoint is the **router**. The page carries two sources: `kinman-2026`, the review that states the framework, and `cembrowski-2018`, the primary underneath it that measures the border in six modalities and supplies the wave's only causal manipulation.

---

## Geometry: three axes, two of them not independent

| Axis | Also called | Runs from → to | Primate homologue |
|---|---|---|---|
| Dorsal–ventral | "long" | Septal → temporal pole; a few mm in rodent | **Posterior → anterior**, after a ~90° rotation of the hippocampal long axis; the anterior subiculum is markedly enlarged in humans and wraps the hippocampal fissure, inverting laminar orientation |
| Proximal–distal | "transverse" | Adjacent to CA1 (proximal; contains the **prosubiculum**) → furthest from CA1 (distal) | Preserved |
| Superficial–deep | "radial" | Pyramidal cell layer (superficial) → **polymorphic layer** abutting white matter (deep) | Preserved, with *more* laminar differentiation: three distinct excitatory layers in monkey and human |

**The two in-plane axes are not orthogonal in practice.** Their reference boundaries — CA1 and the white matter — are curved, so proximal–distal and superficial–deep position covary across space. Any claim that assigns a property to "the distal subiculum" is partly a claim about depth.

Cytoarchitecture along each: dorsally compact and sharply delineated, ventrally broader with diffuse packing and clearer internal stratification; proximal-to-distal changes in thickness, cell-packing density and internal organisation; the deep polymorphic layer sparsely packed with heterogeneous morphologies.

---

## The patchwork: discrete, not graded

Single-cell RNA sequencing in mouse resolves excitatory subtypes whose marker genes label **anatomically distinct and non-overlapping** subdomains, matching the cytoarchitectural subdomains that immunohistochemistry had already stained in mouse and rat. The organisation is a patchwork of abutting tiles, not a gradient — which is the opposite of what [[wiki/concepts/hippocampal-long-axis.md]] finds one stage upstream, where gradients and discrete domains are superimposed.

Three consequences the authors draw, each of which is a methodological lever rather than a result:

1. **Marker genes give per-subtype experimental access** (promoter-specific Cre lines).
2. **Spatial position becomes a proxy for identity** — the review's "Rosetta stone": if subtypes tile a volume contiguously, coordinates substitute for labels wherever molecular annotation is missing.
3. **Gene identity licenses mechanistic inference** upward to circuit and behaviour (e.g. differentially expressed ion-channel and neuromodulatory-receptor genes accounting for firing-phenotype differences).

---

## Output typed by destination

| Axis / position | Marker genes | Projection targets |
|---|---|---|
| **Dorsal** | — | Retrosplenial and parietal cortex |
| **Ventral** | — | Hypothalamus, amygdala, bed nucleus of the stria terminalis, nucleus accumbens — stress, affect, autonomic regulation |
| **Proximal** (prosubiculum) | *Nnat*, *Chrna7*, *Nptx1*, *Robo1* | Nucleus accumbens, medial prefrontal cortex, **lateral** entorhinal cortex |
| **Distal** | *Nts*, *Cdh7*, *Elf1*, *Scn4b* | Retrosplenial cortex, **medial** entorhinal cortex, ventral thalamic nuclei |
| **Deep polymorphic layer** — the non-pyramidal "**ovoid cell**" | *Ly6g6e* | **Anterior thalamic nuclei, selectively** |

The projection classes recapitulate the transcriptomic subclasses: cell bodies *and* dendritic arbors of a given projection class occupy their own anatomical subdomain. The same axes organise the inputs — proximal afferents from lateral entorhinal cortex, distal afferents from medial entorhinal cortex, plus a topographic CA1 → subiculum map across proximal–distal.

**The reciprocity this implies.** Proximal cells receive lateral entorhinal input and project to lateral entorhinal cortex; distal cells receive medial and project to medial. That is the stream-preserving topology of `T340` Position A, holding at the store's *output* stage and typed by cell class rather than inferred from bulk tracer topography — still anatomy, and still not the stream-typed functional measurement that row's `Closes when` asks for.

---

## The primary underneath the review: the border measured, and one behavioural dissociation

> **Provenance.** Cembrowski, Phillips, DiLisio, Shields, Winnubst, Chandrashekar, Bas & Spruston 2018, *Dissociable structural and functional hippocampal outputs via distinct subiculum cell classes*, Cell 173(5):1280–1292.e18 (`raw/cembrowski-2018-dissociable-hippocampal-outputs-subiculum-cell-classes.md`). Mouse, dorsal subiculum only. Population and single-cell RNA-seq, two-colour *in situ* hybridisation, retrograde and anterograde trans-synaptic viral tracing, whole-brain single-axon reconstruction, slice patch-clamp registered to an anatomical landmark, and Cre-line-restricted chemogenetic silencing — six modalities on one border. This is the study `kinman-2026` reviews; two of its authors wrote that review, so the two sources are not independent.

**The border is discrete and it is drawn by position, not by target.**

| Measurement | Result |
|---|---|
| popRNA-seq of retrograde-labelled projection classes | Nucleus accumbens- vs retrosplenial-projecting cells interleave ~1% (7/848 double-labelled); hundreds of projection-enriched genes; low cross-class transcriptome correlation |
| **The region/target confound, broken** | Prefrontal (proximal) and ventral-hypothalamic (distal) classes added. Classes from the *same* region have similar transcriptomes; differences across the proximal–distal axis are markedly larger — so the transcriptional type tracks **where the cell sits**, not what it projects to |
| scRNA-seq, 327 cells, ~5,000 genes/cell | PC1 loads on proximal/distal markers (*Nnat*, *Nts*, *Fn1*). Three separated clusters: **two** proximal (accumbens- and prefrontal-projecting separable), **one** distal (retrosplenial and hypothalamic indistinguishable). >90% agreement with hierarchical and density-based clustering; a random-forest classifier reaches >90% accuracy on 80 training cells |
| A fourth, rare cluster found *de novo* | *Ly6g6e*⁺, *Slc17a7*⁺, sparse **deep** cells spanning the whole proximal–distal axis — the population `kinman-2026` later names the **ovoid cell** |
| Two-colour ISH | Sharp border with a **~200 µm** interleaved transition zone; ~3% (27/881) of cells co-express opposing markers. Cross-validated by Allen Brain Atlas ISH for 30/36 (86%) marker genes, and present along the **whole long axis** |
| Border ≡ projection border | Retrograde AAV into retrosplenial cortex: **94.8%** of labelled cells co-label distal markers (n = 250); **0.0%** co-label proximal markers (n = 236) |

**Seven efferent classes against one reference (accumbens-projecting cells, co-injected in every animal):**

| Target | Falls where | Fraction |
|---|---|---|
| Prefrontal cortex | proximal, same field as accumbens | 94.5% |
| Lateral entorhinal cortex | proximal | 96.5% |
| Retrosplenial cortex | distal, abutting | 96.8% |
| Ventral hypothalamic nuclei | distal | 90.9% |
| Medial entorhinal cortex | distal | 74.3% |
| **Interanteromedial thalamic nucleus** | **spans the border** — sparse, the single non-conformer | 41.9% |

**Afferents respect the same border, and one does not:**

| Input | Lands | Fraction / ratio |
|---|---|---|
| Lateral entorhinal cortex (anterograde trans-synaptic) | proximal | 91% (296/327 cells), 3.9× fluorescence |
| Medial entorhinal cortex | distal | 99% (81/82 cells), 2.4× |
| Basal amygdala | proximal | 91% (104/114 cells), 3.6× |
| Nucleus reuniens | **no** proximal–distal organisation (cited, not measured here) | — |
| NPY interneurons (local) | proximal | 3.2× cell bodies, 2.8× processes; no difference for somatostatin, parvalbumin or vasoactive intestinal peptide subtypes |

**Firing phenotype is not merely biased across the border — it is exhausted by it.** Whole-cell recordings (n = 32 cells, 16 animals), biocytin-filled and registered to the accumbens projection border: 12 regular-spiking, 20 bursting. The proximal field is **entirely** regular-spiking and the distal field **entirely** bursting; only the ~200 µm transition zone contains both (p < 1e−4 for proximal–distal ordering). Earlier reports of intermingled firing types are recovered as sampling from the transition zone.

---

## The correction the primary makes to the "one class, one consumer" reading

Whole-brain two-photon reconstruction of **11** complete subicular axonal arbors (MouseLight) finds that *most individual neurons innervate multiple distinct extrahippocampal targets*, including targets the retrograde panel never probed. The retrograde data agree: double-labelling is **1.9%** across the border but **18.8%** within a region. This contradicts the standing claim that subicular efferents are organised as mostly parallel single-target projections (Naber & Witter 1998) — a claim reached by extrapolation from two-colour retrograde tracing, which cannot see a collateral to an uninjected site.

So the store's output stage is **`k` typed heads, each broadcasting to a fixed *suite* of consumers** — not `k` labelled lines, one per consumer. The suite is the class signature: `{accumbens, prefrontal, lateral entorhinal}` for the proximal class, `{retrosplenial, medial entorhinal, ventral thalamus}` for the distal one. Two architectural consequences, both sharper than the "typed output" reading alone:

- **Consumers within a suite cannot be addressed separately.** Nothing downstream of the subiculum can receive the distal stream without retrosplenial cortex, medial entorhinal cortex *and* ventral thalamus receiving a copy of it. Selectivity at this exit is selectivity over **sets**, at the granularity of the class, and any finer routing must be done by the receivers.
- **The copy is free and the partition is not.** A machine equivalent is one write broadcast on a fixed fan-out bus per head, with the head chosen by which population is active. That is cheaper than per-consumer gating and strictly less expressive, and it is the arrangement `G14` gets for nothing and `G122` pays for.

---

## The one causal result: silencing an output class blocks writing, not reading

Cre lines give class-restricted access — *Klk8-cre* (proximal), *Nts-cre* (distal) — with bilateral hM4D(Gi)/CNO silencing (n = 13 and 15 mice).

| Assay | Proximal silenced | Distal silenced |
|---|---|---|
| Locomotion, elevated plus maze, novel object recognition, olfactory habituation | no effect | no effect |
| Match-to-sample Morris water maze, goal-quadrant preference | above chance (p < 1e−2) | **at chance** (p > 0.05; vs vehicle p < 0.05) |
| Reference-memory (hippocampus-independent) version | no effect | no effect |
| Retrieval of the *previous* day's goal, first trial on the CNO day | — | **intact** (p < 0.01) |
| Encoding of the CNO day's goal, read out on the *following* day | — | **abolished** (p > 0.05; CNO vs post-CNO p < 0.05) |

Controls that make the dissociation load-bearing: wild-type mice show no CNO effect; the proximal null is not incomplete genetic access, because silencing *all* proximal cells (Cre-off hM4D in the *Nts-cre* line) also leaves working memory intact; the deficit is random swimming rather than perseveration to the old goal; and the one-day intersession interval exceeds CNO's several-hour action, which is what makes the encoding read-out on the following day interpretable.

**Why the dissociation is the interesting part.** The distal class is the origin of the posterior exit ([[wiki/entities/retrosplenial-cortex.md]], medial entorhinal cortex). Silencing it leaves an existing spatial memory fully readable and leaves a new one unwritten. Read against the store framing the wiki uses, this is an output stage whose traffic is required for the **write** path and dispensable for the **read** path — which is odd, because an output stage is by construction on the read path.

The authors' own reconciliation, offered because contextual fear conditioning gives the *opposite* phase assignment (subiculum dispensable for encoding, required for retrieval), is that distal subiculum is required for **updating a behavioural decision against already-known spatial cues**. In the water maze the extramaze cues are familiar and only the cue→goal mapping changes, so silencing costs the update and not the read; in fear conditioning the context is novel at encoding so no update is possible, and the cost falls at retrieval where a response must be selected. The authors list the confounds themselves (goal-directed search vs freezing, extended vs single-trial training, neutral vs aversive valence) and call the alternatives undisambiguated.

**(brainstorm) That reframes the exit as a policy-revision port rather than a memory port.** If the unifying model is right, this output class is not carrying "the retrieved memory" at all — it is carrying the *revision* to a cue→action mapping, and it is needed exactly when the map is stable and the policy over it is not. The wiki has no module of that shape: every store read-out in [[wiki/concepts/complementary-learning-systems.md]] is a content delivery, and every policy update lives in [[wiki/entities/basal-ganglia.md]] driven by a scalar. A hippocampal exit typed for *edits to the mapping* would sit between them — structured content on the wire, but written into a controller rather than returned to a querier, which is the arrangement `G14` needs and `T100` is already arguing about one channel over.

**The stream assignment this supports.** Knierim's parallel-streams framework assigns the proximal class local cues and the distal class global cues. The water-maze task has no local cue for the platform and is entirely driven by extramaze cues; it needs the distal class and not the proximal one. This is a **single** dissociation — the complementary experiment (a local-cue task requiring proximal subiculum) has not been run, so "parallel streams carrying local versus global information" remains one-sided.


---

## Physiology and function, per subtype

| Level of definition | Finding | Species |
|---|---|---|
| Firing phenotype | **Regular-spiking** vs **burst-firing** pyramidal neurons, stratified across proximal–distal *and* superficial–deep; covaries with morphology, electrophysiology and neuromodulatory properties | rat, mouse (*ex vivo*); human (both present, more regular-spiking) |
| Long axis | Dorsal subiculum: predictive/task-linked reward correlates **embedded within spatial codes** — anticipatory firing, goal-site activity, multiplexed with position and task phase | rat |
| Long axis | Ventral subiculum → nucleus accumbens encodes reward history and task engagement and **bidirectionally regulates** food-seeking and approach; ventral → bed nucleus of the stria terminalis / hypothalamus drives the hypothalamic–pituitary–adrenal axis and defensive behaviour | rat, mouse |
| Proximal–distal | **Vector-trace neurons** — egocentric vectors to salient cues that *persist after cue removal* — present distally, largely absent proximally; firing-rate differences along the same axis | rat, mouse |
| Projection class | **Speed** cells (firing scaling with locomotor velocity) predominate in the retrosplenial-projecting population; **trajectory-dependent** cells (differential firing on the same physical path by route) in the accumbens-projecting population | rat |
| Marker gene | Distal *Fn1*/*Nts* neurons contribute to specific types **and phases** of working memory | mouse |
| Marker gene | *Ly6g6e*⁺ ovoid neurons in the deep layer show **sustained** responses to novel objects and drive object recognition | mouse |
| Oscillation | Theta can **originate in the subiculum and propagate backward** across the hippocampal network, matching structural back-projections; subtype-specific drive of sharp-wave ripples; proximal–distal variation in theta and gamma | rat, mouse |

The review's three-principle summary: multimodal properties **covary** within a subtype, **dissociate** between subtypes, and are **reinforced by temporal dynamics** — so the subiculum is "a highly complex arrangement of distinct circuits", not a monolithic relay.

---

## The counter-argument the authors make against themselves

Four facts pull toward integration rather than parallel conduits:

| Fact | Consequence |
|---|---|
| CA1 neurons project **diffusely across large swathes** of the subiculum (rat, mouse) | Barring fine-scale wiring nobody has found, the dominant hippocampal afferent imparts relatively **non-specific** drive across many subtypes |
| Local axon collaterals are prominent; *ex vivo* recording confirms monosynaptic coupling **between** excitatory subtypes, with relatively high connection probability, and some subtypes have **autapses** | Segregated afferents can be re-mixed locally before reaching the output |
| Inhibitory interneuron subtypes are differentially patterned across proximal–distal, with subtype-specific effects on excitatory activity | The re-mixing is itself patterned, and essentially unstudied |
| At least one mouse subtype **lacks the anatomical substrates typically associated with hippocampal inputs** | For some streams, long-range extrahippocampal input may be the central driver and local hippocampal input a minor contribution — a reinterpretation of what "hippocampal output" means |

Their resolution is a run-time one: mechanisms that balance **segregation versus integration as a function of space, time and circuit**, with the region flexibly computing distinct operations by behavioural state. The proposed substrates are local rather than global — subtype-specific neuromodulatory receptor complements acting under locally distinct neuromodulatory tone (consistent with observed opposing "countermodulation" of the two firing phenotypes in rat), and network oscillations spatially localised to individual patches.

---

## The two-tier registration proposal

Different labs named the same tiles differently (`PSd`/`SUBdd`/`Sub2`/"proximal pyramidal neurons" are one domain). The authors propose registering all results spatially:

| Tier 1 — coarse atlas domain | Location across the three axes |
|---|---|
| Dorsal prosubiculum, pyramidal cell layer | dorsal · proximal · superficial |
| Dorsal subiculum, pyramidal cell layer | dorsal · distal · superficial |
| Ventral prosubiculum, pyramidal cell layer | ventral · proximal · superficial |
| Ventral subiculum, pyramidal cell layer | ventral · distal · superficial |
| Polymorphic layer | deep, across both other axes |

Tier 2 registers finer subtypes (laminae, marker genes) *within* a tier-1 domain. The point is compatibility with atlas nomenclature (Allen Mouse Reference Atlas) while leaving room for subtypes the atlas does not contain — and the authors are explicit that **atlas delineations incompletely recapitulate the spatial boundaries of the underlying subtypes**, with atlas efforts disagreeing outright on the ventral border against CA1, presubiculum, parasubiculum and amygdala.

---

## Cross-species

| Property | Conserved? |
|---|---|
| Long-axis gene-expression gradients and molecular domains | Yes, rodent ↔ primate — read as a shared developmental program |
| Anterior/posterior projection split | Yes: posterior → retrosplenial, anterior thalamic nuclei, mammillary bodies (≈ rodent dorsal); anterior → amygdala, hypothalamus, ventromedial/orbitofrontal prefrontal (≈ rodent ventral) |
| Deep-layer ovoid population | Plausibly: the deepest human subicular layer contains **PCP4-positive** neurons resembling the mouse ovoid cells |
| Superficial–deep lamination | **Enhanced** in primate — three excitatory layers, greater pyramidal heterogeneity |
| Functional lateralisation | **Not** conserved — human-only, proposed to emerge through subiculum-mediated interaction with already-lateralised cortical networks |

---

## The architectural reading

**The store's read port is `k` typed heads, not one.** Every two-store architecture in the wiki ([[wiki/concepts/complementary-learning-systems.md]], [[wiki/entities/neural-episodic-control.md]], every retrieval-augmented scheme) gives the fast store a single output that downstream consumers read. Here the output stage is partitioned by consumer *before any computation runs*: the cells that speak to the retrosplenial/anterior-thalamic spatial system are not the cells that speak to accumbens and prefrontal cortex, they receive different afferents, they fire differently, and they carry different variables (speed vs trajectory). `G14` asks for a consolidation channel selective about what it transports; this makes a large part of that selectivity **structural** — each *class* has its own origin population, so "what gets sent where" needs no gate to compute it. The primary bounds how far that goes: the head is typed to a **set** of consumers, not to one (18.8% of cells double-label across same-region targets, and 11 fully reconstructed axons mostly reach several extrahippocampal targets), so a gate is still needed for any selectivity finer than the class.

**(brainstorm) And that is a cheap thing to build, with a stated cost.** `k` read heads over one store, each with its own input mask and its own recurrent neighbourhood, plus a shared diffuse drive from the store's last internal stage. What it buys is that a consumer cannot be flooded by a stream it was not wired for; what it costs is that the wiring, not the task, decides which conjunctions are expressible — the fork `G122` opens. This region is the one place where **both** of that row's continua have been measured, and the answer is neither extreme: afferents partly discrete (entorhinal, topographic CA1) and partly mixed (diffuse CA1), recurrence dense but *subtype-specific*. The importable form is therefore an architecture with typed outputs, typed long-range inputs, and a shared broadcast input that guarantees no head is fully isolated.

**(brainstorm) Spatial position as a substitute for a label.** The "Rosetta stone" move is general and the wiki has no analogue of it: when a module's functional subtypes tile a space contiguously and discretely, a coordinate *is* an identity, and any measurement that records position inherits the type annotation for free. In a learned module the equivalent would be a topographic constraint on an expert layer ([[wiki/concepts/sparse-expert-routing.md]], [[wiki/concepts/microarchitectural-topography.md]]) — experts arranged so that adjacency in the layout predicts both input source and output destination, which would make a routing decision readable off geometry rather than off a learned gate.

**(brainstorm) The output stage clocks the store.** Theta originating in the subiculum and propagating *backward* across the hippocampal network, on measured structural back-projections, means the designated output region drives its own upstream. Every store in the wiki is drawn with a read port that is a pure function of internal state; here the read port is a rhythm generator for the thing it reads. If the exit stage sets the store's phase, then *when* the store is readable and *what* it emits are set by the same population — which is the write-enable/read-out coupling `G14`'s protocol discussion ([[wiki/concepts/sleep-oscillation-nesting.md]]) puts in the receiver, relocated into the sender's last stage.

**Routing by destination is not routing by content.** Worth stating as the limit: nothing here shows the subiculum *choosing* a target. It shows that the choice was made developmentally and is expressed as which cell fires. A machine store that copies this gets fixed labelled lines, and gets the flexibility question — [[wiki/concepts/sparse-expert-routing.md]]'s learned partition by *input* is the dual, and the biology offers no mechanism for re-typing a line once wired.

---

## Limitations

- **A review by the authors of much of the evidence** (two of three authored the patchwork, dissociable-outputs and ovoid-cell primaries), and overwhelmingly rodent. The `kinman-2026` clip carries **no quantities at all** — no subtype counts, no connection probabilities, no effect sizes; every number on this page comes from `cembrowski-2018`, which is one of the primaries those authors wrote, so the page's two sources are not independent.
- **The primary is narrower than the framework it supports.** `cembrowski-2018` is mouse only, **dorsal** subiculum only, and the transcriptional resolution is three excitatory clusters plus a rare deep one — fewer subtypes than the review's patchwork. Its single-axon evidence rests on **11** reconstructed neurons, its electrophysiology on 32 cells, and its behavioural claim on one task in one modality.
- **The behavioural dissociation is single, not double.** Only the distal class was shown necessary, only for a global-cue task, only at encoding. The complementary experiment the parallel-streams framework predicts — a local-cue task requiring the *proximal* class — has not been run, so "two streams, local versus global" is supported at one corner of a 2×2.
- **The node's boundaries are contested before its contents are.** Atlas efforts disagree on the subiculum's border ventrally, laminar distinctions become unreliable there, and atlas domains do not recapitulate subtype boundaries — [[wiki/concepts/node-definition-problem.md]] in its sharpest form, since every projection statistic above is conditioned on a border nobody agrees on.
- **Input organisation is the review's own first outstanding question.** Whether CA1, entorhinal, amygdalar, claustral and thalamic afferents differentially target subtypes is "largely unknown"; the cell-type-resolved rabies experiments that would settle it are named as future work.
- **Inhibitory diversity is nearly untouched**, so the local re-mixing term in the segregation/integration balance is unconstrained.
- **The measurement `G122` needs is still not made anywhere**: input density from every afferent source — *including other neurons of the same region* — per projection class.
- Causal evidence is thin relative to the correlational typing: a handful of optogenetic/chemogenetic manipulations (accumbens approach behaviour, ovoid-cell object recognition, *Fn1*/*Nts* working memory) against a large catalogue of covariation.

---

## Connections

- **[[wiki/entities/entorhinal-cortex.md]]** — the reciprocal partner typed cell-by-cell rather than by tracer topography, now with the loop closed in one animal: anterograde trans-synaptic labelling puts lateral-entorhinal input on proximal cells (91%) and medial on distal (99%), while retrograde labelling from the same two divisions recovers the same border (96.5% proximal, 74.3% distal) — so the strict reciprocity `T340` Position A asserts holds at the store's output stage, as anatomy, in mouse, with the functional test still unrun (`cembrowski-2018`).
- **[[wiki/entities/retrosplenial-cortex.md]]** — the destination of the distal/dorsal output class, and the pairing is informative both ways: the subicular cells that project there are the *speed*-coding population, and the same axons that feed this cortex collateralise to the mammillary bodies, so the posterior exit from the store is one typed output class rather than a region-to-region wire.
- **[[wiki/entities/anterior-thalamic-nuclei.md]]** — the two pages meet on one cell type and one dependency: the deep *Ly6g6e*⁺ ovoid neuron projects **selectively** to these nuclei, and their lesion abolishes spatial-responsive firing throughout the subiculum while sparing CA1 — so the output stage's tuning is maintained by the target it writes to.
- **[[wiki/concepts/hippocampal-long-axis.md]]** — the same axis one stage later and organised differently: upstream the axis carries a smooth gradient with discrete domains superimposed, here the organisation is a patchwork of abutting tiles with no gradient claimed, and the dorsal/ventral split cashes out as retrosplenial-parietal versus hypothalamic-amygdalar *targets* rather than as a scale gradient.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — names the origin population of that channel precisely: the *proximal* (prosubicular) class, defined by *Nnat*/*Chrna7*/*Nptx1*/*Robo1* and shared with the accumbens and lateral-entorhinal projections, so the store→controller wire and the store→valuation wire leave from the same tile.
- **[[wiki/concepts/complementary-learning-systems.md]]** — converts part of the consolidation channel's selectivity from a gating hypothesis into a wiring fact: the fast store's output stage is partitioned by destination, so which slow consumer receives what is decided by which cell fires rather than by a computed gate (`G14`) — and the partition is over *sets* of consumers, so the gate's residual job is within-suite selection.
- **[[wiki/entities/basal-ganglia.md]]** — the comparison the encoding/retrieval dissociation forces: silencing the distal output class leaves an existing spatial memory readable and a new one unwritten, which on the authors' own reconciliation makes the exit a channel for **revisions to a cue→action mapping** rather than a memory read-out — structured content on the wire where this page's policy updates arrive as a scalar (`cembrowski-2018`, brainstorm).
- **[[wiki/concepts/working-memory.md]]** — the store's exit assigned a task phase: class-restricted chemogenetic silencing of the distal subiculum abolishes encoding of a new water-maze goal while leaving retrieval of the previous one intact, and silencing the *whole* proximal class (the origin of the subiculum→prefrontal wire) costs neither phase (`cembrowski-2018`, `T100`).
- **[[wiki/concepts/node-definition-problem.md]]** — the region where the problem is stated by the field itself: atlases disagree on the ventral border, atlas domains do not match subtype boundaries, and the proposed fix is to register results to a two-tier spatial frame rather than to a named region.
- **[[wiki/concepts/population-geometry.md]]** — the measured middle of the mixed-versus-discrete fork (`G122`): discrete projection-typed output classes with their own dendritic subdomains, fed partly by topographic afferents and partly by a diffuse CA1 broadcast, then re-mixed by dense but subtype-specific local recurrence.
- **[[wiki/concepts/sparse-expert-routing.md]]** — the dual arrangement: machine routing partitions a module by *input*, learned at run time; this partitions by *output destination*, fixed developmentally, with the input mask following the partition rather than selecting it — and the primary sharpens which variable carries the type, since same-region cells projecting to different targets share a transcriptome while same-target cells across the border do not, so the expert index is **position**, not destination.
- **[[wiki/concepts/cognitive-map.md]]** — the map's exit is not a single read-out: vector-trace neurons (egocentric vectors to cues, persisting after cue removal) are distal, speed cells are retrosplenial-projecting, trajectory-dependent cells are accumbens-projecting, so different consumers receive different variables from the same map.
- **[[wiki/concepts/valuation-system-decomposition.md]]** — the anatomical origin of the hippocampal term in that page's circuits: the ventral/proximal classes are the ones wired to nucleus accumbens, amygdala and the hypothalamic–pituitary–adrenal axis, and they bidirectionally control approach behaviour, so "subiculum" in a valuation circuit means a specific tile.
- **[[wiki/concepts/microarchitectural-topography.md]]** — a non-cortical case of the same principle, with the type annotation carried by position: contiguous discrete tiles make coordinates a proxy for cell identity, which is the "Rosetta stone" the review builds its integration strategy on.
