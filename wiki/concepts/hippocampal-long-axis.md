# Hippocampal Long Axis — Smooth Gradients Superimposed on Sharply Bordered Domains

**One structure, one repeated intrinsic circuit, but two independent organizations laid over each other along its long axis (dorsal→ventral in rodent, posterior→anterior in human). (i) A *continuous* gradient: extrinsic connectivity is a monotone topographic map from source to target, and the represented scale grows with it — CA3 place-field width goes from ~1 m at the dorsal pole to ~10 m at the ventral pole, near-linearly. (ii) *Discrete* domains: combined gene-expression boundaries carve at least nine domains in CA3 and three in CA1 and dentate gyrus, and the longitudinal association fibres (CA3 collaterals, dentate mossy-cell axons) diverge freely within the dorsal two-thirds and within the ventral one-third but barely cross between them, with theta coherence dropping abruptly at that same seam in rat and in human. The dorsal/ventral *dichotomy* — space here, emotion there — is wrong on both counts: it is not two, and the boundary that does exist is at 2/3–1/3, not at the middle.**

> **Provenance.** Strange, Witter, Lein & Moser 2014, *Functional organization of the hippocampal longitudinal axis*, Nat Rev Neurosci 15:655–669, doi:10.1038/nrn3785 (`raw/strange-2014-hippocampal-longitudinal-axis.md`). A review; the load-bearing primaries it aggregates are the Allen *in situ* transcriptional atlas (Thompson et al. 2008; Dong et al. 2009; Fanselow & Dong 2010), Kjelstrup et al. 2008 (place-field scale gradient), Stensola et al. 2012 (discrete grid modules), Komorowski et al. 2013 (ventral generalization), Bast et al. 2009 (intermediate hippocampus).

---

## The two organizations, and what carries each

| Level | Organization | Evidence |
|---|---|---|
| Cortical input | **Gradient** | Entorhinal dorsolateral→ventromedial origin maps smoothly onto hippocampal dorsal→ventral termination; cingulate topography is inherited through it (retrosplenial → dorsal, prelimbic → intermediate, infralimbic → ventral). No abrupt transition anywhere. CA1/subiculum return projections mirror it |
| Subcortical output | **Gradient** | Hippocampus → lateral septum → hypothalamus preserves topography across two synapses; nucleus accumbens and amygdala receive progressively more *medial* input from progressively more *ventral* hippocampus |
| Neuromodulation | **Gradient (unresolved shape)** | Monoamine projections denser ventrally; gradual-vs-step-like never measured |
| Gene expression | **Discrete** | Domains defined by the *overlap* of many genes' expression boundaries, not by any single gene; borders reciprocal (different genes delimit the same border from each side). ≥9 domains in CA3; 3 each in CA1 and dentate gyrus (dorsal / intermediate / ventral). No two-way boundary exists |
| Intrinsic association fibres | **Discrete** | CA3 longitudinal collaterals and dentate mossy-cell axons diverge within dorsal 2/3 and within ventral 1/3; few fibres cross. Monkey: posterior 2/3 vs anterior 1/3, boundary less sharp |
| Oscillatory coupling | **Discrete** | Human depth electrodes: abrupt coherence drop between adjacent contacts at the anterior-1/3 seam. Rat: theta coherence high dorsal↔intermediate, much lower dorsal↔ventral |
| Represented spatial scale | **Gradient** | CA3 place-field size ~1 m (dorsal pole) → ~10 m (ventral pole), scaling almost linearly with position |

**Development supplies a cheap generator for the gradient half.** Neurogenesis is simultaneous along the axis, but each long-axis level projects to the zone of its target whose cells were born at a matching time — dorsal hippocampus → early-born septal cells, ventral → late-born. A monotone wiring map falls out of a birth-date correlation, with no per-axon addressing.

---

## Discrete input, continuous output — the scale-conversion problem

The scale gradient is the place where the two organizations visibly collide, and the collision is informative for a builder.

| Stage | Scale organization |
|---|---|
| Medial entorhinal grid cells | **Step-like.** Discrete modules; spacing jumps between modules; modules overlap anatomically along the dorsoventral entorhinal axis |
| CA3 place cells | **Continuous.** Near-linear growth 1 m → 10 m along the axis |

The reconciliation the authors offer: because entorhinal modules overlap spatially, a hippocampal level receives a *mixture* of module inputs, and mixtures with slowly shifting weights read out as a smooth scale gradient. **A discrete basis plus an overlapping, position-dependent mixing matrix produces a continuum of scales.** This is the wiki's cheapest known route to multi-scale representation: it needs `k` modules and one monotone mixing profile, not `n` separately trained scales — cf. [[wiki/concepts/path-integration.md]], where the only mechanisms for grid-scale diversity are a hand-set module structure, a readout width `σ_E`, or a prediction horizon `m_b`, and none of the three converts a discrete set into a continuum.

Caveats the source is explicit about: whether place-field growth is *truly* continuous has not been tested against the genetic domain borders (if it steps, it should step where they do), and the rescaling asymmetry found across grid modules — large-scale modules rescale to a compressed environment, small ones do not — has never been checked between ventral and dorsal place fields.

**Why a gradient rather than a set of scales.** The authors' argument: a gradient "accommodates both spatial resolution and spatial contiguity" — a discrete stack has to solve the correspondence problem between levels, a gradient has neighbouring levels already in register because the wiring is monotone and mostly short-range. This is the same locality argument [[wiki/concepts/microarchitectural-topography.md]] makes for cortex: a smooth gradient makes coupling *similar* units cheap and coupling *distant* points of the axis expensive.

---

## The scale gradient as a mechanism for higher-order links — the paper's main offer to abstract reasoning

Human anterior hippocampus is the locus for semantic processing and for transitive inference; posterior for item-specific, non-semantic, detailed retrieval, with reported double dissociations in both directions. The cellular counterpart: in rat CA3, dorsal ensembles bind *specific* objects to *specific* locations, while progressively more ventral ensembles increasingly generalize across object-sampling events within a spatial context while still discriminating between contexts (Komorowski et al. 2013). This is the generality gradient [[wiki/concepts/schema-assimilation.md]] carries, given a scale explanation:

1. Every place cell oscillates slightly faster than the population theta rhythm; the interference is phase precession, which compresses a traversed sequence into a single theta cycle (the **compression dynamic**).
2. Cells whose fields overlap in the compressed window fire in the same theta cycle and are therefore eligible to be bound by spike-timing-dependent plasticity.
3. Field size *increases* and cell oscillation frequency *decreases* toward the ventral pole. Both push in the same direction: **more, and more widely separated, assemblies co-occur in one theta cycle ventrally than dorsally.**
4. So the ventral end can link *non-adjacent* representations — items never experienced in sequence — while the dorsal end can only link near-neighbours. Under item↔location analogy, that is the machinery for transitive inference and, by extrapolation, for the anterior locus of semantic responses in humans.

**(brainstorm) The importable form is a binding-window width that varies with representational scale, not a separate relational module.** Every wiki mechanism for non-adjacent association is either an explicit search ([[wiki/concepts/subgraph-matching.md]]), a learned structural code ([[wiki/entities/tolman-eichenbaum-machine.md]]), or an architectural refusal to see content ([[wiki/concepts/relational-bottleneck.md]]). This proposal gets higher-order links from *one* parameter — how much of a trajectory fits inside one binding window — swept across a population. A cheap test: train one sequence model with a per-unit receptive-field width swept monotonically across the layer and a fixed-width control matched on total capacity, then score first-presentation transitive inference. The prediction is that the graded model infers `A > C` from `A > B`, `B > C` and the matched control does not, with the effect carried by the wide-field units.

**What is unpaid.** Step 4 is a theoretical extrapolation in the source, not a measurement: no one has shown ventral cells binding non-adjacent items, and the human transitive-inference lesion data (Dusek & Eichenbaum 1997) involved the entire axis. Nor is the direction of causation fixed — wide fields might follow from generalized coding rather than produce it.

---

## Function along the axis

| Function | Locus | Organization implied |
|---|---|---|
| Spatial encoding/retrieval | Dorsal 70% required for retrieval in an intact rat; smaller dorsal fragments suffice if encoding also happened lesioned | Graded and distributed, not a dorsal module |
| Unconditioned fear (elevated plus maze, novel-food latency, social interaction) | Ventral 1/3 **only**; dorsal-2/3 lesions null | **Discrete** — a segregated functional portion; may act through hypothalamus directly, not through amygdala (amygdala lesions did not reproduce it) |
| Conditioned fear | Both, inconsistently | Graded — outcome depends on where the lesion sits relative to the ventral→dorsal hippocampus / medial→lateral amygdala topography, which is why the literature disagrees with itself |
| Locomotion, reward, goal-directed action | Ventral / anterior, via nucleus accumbens and mesolimbic dopamine | Graded connectivity read as a dichotomy in the experiments |
| **Rapid place learning used to guide navigation** | **Intermediate** hippocampus | The junction: accurate place coding (strongest dorsally) meets the output connections to prefrontal cortex and accumbens (strongest ventrally). Caveat the authors raise: intermediate tissue blocks are more likely to contain complete trisynaptic circuits than polar blocks, so the localization may be partly an artefact of subfield composition |
| Episodic detail vs gist | Posterior = detailed spatial/autobiographical retrieval; anterior = coarse, gist-like | Proposed to be the same scale gradient in a non-spatial domain; never shown to *be* graded, and no metric for "richness of detail" exists |
| Semantic / transitive inference | Anterior | See above |

**One negative result worth keeping.** The old anterior-encoding / posterior-retrieval dissociation is rejected on mechanistic grounds, not statistical ones: a memory is retrieved by reactivating the cells that encoded it, so encoding and retrieval cannot live in different cell populations. The observed anterior-novelty / posterior-familiarity double dissociations must therefore index something other than the encode/retrieve distinction. Constrains [[wiki/concepts/encoding-retrieval-alternation.md]], which puts the alternation on the theta cycle rather than in space.

---

## Instrument caveats that bite on every human long-axis claim

- Susceptibility artefact and signal drop-out hit the **anterior** medial temporal lobe harder than the posterior — an anterior null may be an instrument null.
- Posterior hippocampal cross-section is ~50% smaller than the anterior head, so cluster-extent thresholds and spatial smoothing are not comparable along the axis.
- A thresholded focal activation at one long-axis locus does not exclude a sub-threshold effect elsewhere; only reported **double dissociations** carry the argument, and the source leans on them for exactly that reason.
- Human fMRI subjects do not locomote, and rodent place-field scale changes when the animal is transported rather than walking — so scanner-measured scale may not be the free-behaviour scale.
- Cross-species transfer of the *molecular* domains is not established: the adult human transcriptional atlas already shows mouse–human differences in hippocampal gene regulation, and primate long-axis molecular organization is unexamined.

---

## Open problems

- **How many domains, and are they nested?** Nine in CA3 vs three in CA1/dentate gyrus; whether the nine collapse hierarchically into three is unknown, so "tripartite" is a simplification the data permit rather than assert.
- **Do the two organizations interact, or merely coexist?** Nothing tests whether a functional gradient (place-field scale, generality) steps at a genetic border. This is the single measurement that would decide whether a builder should model the axis as `k` modules or as a continuum.
- **Where is the ventral fear portion's dorsal border?** Not known to coincide with the gene-expression border, the association-fibre seam, or the septal-projection topography — three candidate boundaries, no test.
- **Is there a time-field gradient?** Place fields become time fields when a rodent runs in place; whether "time fields" expand dorsal→ventral like place fields is untested, and a positive result would make the axis a general *scale* gradient rather than a spatial one ([[wiki/concepts/timescale-hierarchy.md]]).
- **A metric for episodic detail.** The gist/detail gradient cannot be tested until "richness of retrieved detail" is quantified.

---

## Connections

- **[[wiki/concepts/schema-assimilation.md]]** — supplies the mechanism behind that page's generality gradient: the ventral/anterior pole codes what all events of a context share because its fields are wide and its theta cycles slow, so distant assemblies co-fire and get bound; and it adds that the gradient is not the only organization on the axis — a discrete 2/3–1/3 seam runs across it.
- **[[wiki/concepts/cognitive-map.md]]** — the map is held at every scale at once along one anatomical axis rather than at a single grain, which is why hippocampal patterns discriminate corners-within-rooms and rooms in different places; the metric's resolution is a function of position, not a global constant.
- **[[wiki/concepts/path-integration.md]]** — the biological answer to that page's grid-scale-diversity problem, and it runs the other way: discrete entorhinal modules are converted into a *continuous* hippocampal scale gradient by anatomically overlapping module inputs, so a continuum of scales needs `k` bases plus a monotone mixing profile rather than `n` trained scales.
- **[[wiki/concepts/microarchitectural-topography.md]]** — the same wiring-cost argument applied to a subcortical structure: the hippocampal long axis is the "gradient" motif (progressive convergence, neighbours cheap to couple), and the discrete gene-expression domains superimposed on it are a case that page's two-scalar measurement would score as smooth-and-wavy at once.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — explains *why* the channel originates ventrally: the controller is wired to the end of the axis whose fields are widest and whose code generalizes over events within a context, so the anatomy selects the cargo's grain before any computation does.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the input topography is inherited: prelimbic and infralimbic cortex reach the hippocampus only through ventromedial entorhinal cortex and therefore only its ventral levels, while retrosplenial cortex reaches only dorsal levels — the prefrontal↔hippocampal loop is closed at one end of a gradient, not across the structure.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the separation/completion bias has an anatomical gradient nobody has priced: wide ventral fields overlap more, which is completion-favouring by construction, so position on the long axis is a candidate for G38's missing control variable that requires no cholinergic mode bit.
- **[[wiki/concepts/temporal-coding.md]]** — the compression dynamic is this page's binding mechanism: phase precession squeezes a traversed sequence into one theta cycle, and how much of the sequence fits is set by field size, so a temporal code's window is what converts a scale gradient into a generality gradient.
- **[[wiki/concepts/encoding-retrieval-alternation.md]]** — supplies the argument that retires the rival account: encoding and retrieval cannot be split *spatially* along the axis because retrieval reactivates the encoding cells, which is why the alternation has to be carried in time.
- **[[wiki/concepts/timescale-hierarchy.md]]** — the spatial-scale analogue of a temporal-receptive-window hierarchy, and possibly the same thing: if time fields expand ventrally as place fields do, the long axis is one monotone scale axis over whatever variable the input supplies.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the model side of the CA3 that this page grades: the longitudinal association collaterals whose divergence defines the discrete 2/3–1/3 seam are the same recurrent matrix the autoassociative story runs on, so the attractor is bounded to a portion of the axis rather than to the whole structure.
- **[[wiki/entities/entorhinal-cortex.md]]** — an inhibition gradient on the same axis, one synapse upstream: parvalbumin expression falls from the rhinal fissure ventrally in *both* entorhinal divisions and the gradient is conserved into monkey and human, so the long-axis story has an interneuron-density term at the store's gateway as well as inside it (Witter et al. 2017).
- **[[wiki/entities/retrosplenial-cortex.md]]** — the dorsal end of this page's inherited cingulate topography, paged: retrosplenial cortex reaches the hippocampus only through dorsolateral entorhinal cortex and therefore only dorsal levels, the opposite pole from the infralimbic/ventral loop.
- **[[wiki/entities/subiculum.md]]** — the same axis one stage downstream, organised the other way: the store's output stage is a patchwork of abutting discrete tiles with no gradient claimed, and its dorsal/ventral split cashes out as retrosplenial-parietal versus hypothalamic-amygdalar *targets* rather than as a scale gradient — with the primate homologue the anterior–posterior axis after a ~90° rotation (Kinman et al. 2026).
