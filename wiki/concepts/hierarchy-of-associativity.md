# Hierarchy of Associativity — the Store's Input Path Is a Processing Stack, Not a Cable

**Between neocortex and the hippocampus sit three cortical stages — perirhinal, parahippocampal, entorhinal — each with its own dense network of intrinsic associational connections, and each feeding the next. Integration therefore happens *before* anything reaches the store: unimodal input is made polymodal, then supermodal/amodal, in stages, so by the time a code arrives at the dentate gyrus the modality-specific detail it was built from is already gone. The return path is a broadcast, not a rewind: hippocampal output is redistributed through the same two cortices to much of neocortex including unimodal sensory areas — but the projections are *not* cell-for-cell reciprocal, so the cells that wrote a memory are not the cells the return reaches.**

> **Provenance.** Lavenex & Amaral 2000, *Hippocampal-neocortical interaction: a hierarchy of associativity*, Hippocampus 10(4):420–430 (`raw/lavenex-2000-hippocampal-neocortical-hierarchy-of-associativity.md`). An anatomical review, macaque-dominated, built on retrograde/anterograde tracer studies (Suzuki & Amaral, Insausti, Van Hoesen, the authors' own then-unpublished material). Converted from PDF (`LOSSY`) — figure panels are summaries only. Several connectivity statements are cited as "Lavenex and Amaral, unpublished observations".

Why this earns a page. The wiki has a circuit-level page for the gateway itself ([[wiki/entities/entorhinal-cortex.md]]) and many pages that write `p = f(g, x)` into a store, but nothing that describes **what happens to `x` on the way in**. Every model in the wiki treats the store's input as a cortical embedding delivered by one projection. The anatomy says the input passes through two-and-a-half additional association stages with recurrent mixing at each, and that this staging — not the hippocampus — is where most of the cross-modal binding occurs.

---

## The stack, and what each stage adds

| Stage | Afferents | Intrinsic associational network | Integration level reached |
|---|---|---|---|
| Higher unimodal + polymodal cortex | — | corticocortical | unimodal / polymodal |
| **Perirhinal cortex** (areas 35, 36d/36r/36c) | Object vision (area TE), somatosensory, ventrolateral + orbitofrontal, cingulate, superior temporal sulcus polymodal | Heavy and reciprocal within 36r↔36c↔35; area 36d largely *excluded* from it | first multimodal stage |
| **Parahippocampal cortex** (areas TF medial/lateral, TH) | Visuospatial (area V4, posterior parietal), auditory association, somatosensory, retrosplenial | TF↔TH strong and reciprocal; no rostrocaudal topography, but mediolateral segregation (TH↔medial TF heavy, lateral TF mostly to itself) | second multimodal stage |
| Perirhinal ↔ parahippocampal | each other | Asymmetric: rostral TF/TH → 35/36r/36c moderate-heavy; 36c → rostral TF moderate-heavy; 36d gets the *whole* rostrocaudal extent of the parahippocampal cortex | cross-stream mixing |
| **Entorhinal cortex** | ≈ two-thirds of its cortical input from the two above; plus superior temporal gyrus, insular, orbitofrontal, cingulate, retrosplenial — each itself a convergence zone | Three rostrocaudal bands (lateral / intermediate / rostromedial); layer II associational connections stay *within* layer II; deep→superficial closes the loop | supermodal |
| **Hippocampal formation** | Entorhinal perforant path (layer II → dentate/CA3, layer III → CA1/subiculum) | Dentate mossy-cell associational net; CA3 recurrents + widely diverging Schaffer collaterals (one CA3 cell can reach CA1 over 75% of the hippocampal length); **CA1 has almost none** | highest / amodal |

Two structural consequences the review draws itself:

1. **Integration is monotone along the loop** — unimodal → polymodal → supermodal/amodal, with the hippocampal complex the last stage.
2. **The output is broadcast** — medial-temporal output reaches much of neocortex *including unimodal sensory cortex*, so a highly abstract representation is delivered back into the levels that supplied its parts.

**Indirect routes matter as much as direct ones.** Area V4 and posterior parietal cortex do not project to perirhinal cortex, but reach it disynaptically via the parahippocampal cortex — and can reach any rostrocaudal level of entorhinal cortex by that route or by a trisynaptic one. So the entorhinal input segregation (perirhinal → rostral two-thirds, parahippocampal → caudal two-thirds) is **not** a segregation of sensory content: the content has already been redistributed upstream.

---

## It is a hierarchy in the laminar sense, not only the conceptual one

Applying the Felleman–Van Essen laminar criteria (modified for entorhinal periallocortex, which lacks a layer IV):

| Pathway | Origin | Termination | Type |
|---|---|---|---|
| Perirhinal/parahippocampal → entorhinal | superficial layer III + layer V | layers II/III (which project on to dentate/hippocampus) | **feedforward / ascending** |
| CA1 + subiculum → entorhinal | — | deep layers | feedback |
| Entorhinal → perirhinal/parahippocampal | layer V | layer I, less in V/VI | **feedback / descending** |
| Perirhinal/parahippocampal → neocortex | deep layers | superficial layers | **feedback / descending** |

So the medial temporal lobe sits *above* association cortex on the same anatomical scale used to rank visual areas — the ranking instrument is the same one [[wiki/concepts/broadcast-hierarchy.md]] and `T252` argue over, applied past the last cortical stage.

---

## The reciprocity failure, and why a builder should care

Afferent and efferent projections between the two cortices and neocortex are *broadly* reciprocal but **not cell-for-cell**: the neocortical cells that project to perirhinal/parahippocampal cortex are not necessarily the cells receiving the feedback. Three named asymmetries:

| Pair | Direction that is larger |
|---|---|
| Perirhinal ↔ frontal cortex | frontal **→** perirhinal much wider; perirhinal → frontal reaches fewer areas |
| Perirhinal ↔ superior temporal sulcus | superior temporal sulcus **→** perirhinal, from a much wider field |
| Perirhinal ↔ caudal visual areas V4, TEO | perirhinal **→** V4/TEO more widespread than the reverse |

**(brainstorm) This is a concrete architectural constraint on hippocampal indexing.** An index is only useful if it can address the pattern it indexed. If the return path is systematically *not* the input path — narrow back to frontal cortex, wide back to early visual cortex — then the store cannot be re-instating "the cells that were active"; it can only deliver a compressed structure into a *different, largely earlier* population that must reconstruct the rest locally. That flips the engineering reading of reinstatement from **addressing** to **generative re-synthesis under a constraint vector**, and it predicts that the reinstated cortical pattern should be systematically *more* faithful in early sensory cortex than in frontal cortex — the opposite ordering from what a pointer-to-the-encoder model expects. Nothing in the wiki tests this; the closest measurement is retrieval-side reinstatement in [[wiki/concepts/retrieval-mediated-learning.md]]. Logged against `T28`.

---

## The interface is an active memory participant, not a relay

| Observation | Source (cited in the review) | What it shows |
|---|---|---|
| Perirhinal or parahippocampal lesion produces a deficit as severe as hippocampal lesion, and worsens it when combined | Zola-Morgan, Otto & Eichenbaum, Meunier, Mumby & Pinel | the stages are not bypassable |
| Perirhinal lesion ≈ perirhinal+entorhinal lesion in visual recognition; **entorhinal lesion alone is mild** | Meunier et al. 1993 | the severity is not ordered by height in the hierarchy |
| Entorhinal+perirhinal lesion abolishes pair-coding responses in inferotemporal area TE | Higuchi & Miyashita 1996 | the **feedback** arm is required to install a learned association in neocortex — a direct causal datum for consolidation-by-feedback |
| Perirhinal delay activity reflects the sample stimulus, and is abolished by an intervening nonmatching stimulus | Miller et al. 1993; Miyashita & Chang 1988 | the first stage already holds an explicit maintained representation, and it is *overwritable* |
| Perirhinal activation enhances corticocortical pathways secondarily driven by perirhinal input | Ivanco et al. 1996 | the stage can act as a plasticity gain on cortex, not only a conduit |
| Visually responsive and stimulus-selective cells are **rarer** in entorhinal than perirhinal cortex, yet entorhinal cells still discriminate objects | Suzuki et al. 1997 | the predicted conjunction-only regime is approached but not reached |

The review's own hypothesis for the entorhinal stage: its cells "might respond solely to the conjoint activation by neurons from several cortical areas" — i.e. an AND over convergence zones rather than a feature detector. The measurement partially contradicts it (object information survives into entorhinal cortex), which is the first empirical edge of the pure-conjunction reading that [[wiki/entities/tolman-eichenbaum-machine.md]] and [[wiki/entities/vector-hash.md]] adopt at the layer below.

---

## Timing as the instrument for separating stages

Because the stack is recurrent and reciprocal at every level, no static measurement can attribute a computation to one stage. The review's proposed instrument is **latency**: each transfer costs a delay, so a single cell early in the loop should carry *coarse* information first and *fine* information later, the latter arriving via feedback from stages above.

- The supporting datum is Sugase et al. 1999: single superior-temporal-sulcus neurons carry face **category** (monkey vs human) at a short latency and **identity within category** at a longer one, from the same spike train.
- A second timing fact: theta-band activity in perirhinal cortex is highly coherent with entorhinal theta during walking and paradoxical sleep, and perirhinal cortex receives **no** medial septal (pacemaker) input — so its theta is imposed by deep entorhinal layers, i.e. by the *higher* stage. The interface therefore has a rhythm supplied from above, which is the coincidence window plasticity at that stage would run in ([[wiki/concepts/temporal-coding.md]]).

**(brainstorm) This is a usable probe specification for machine models, and the wiki has no equivalent.** For any deep encoder feeding a fast store, decode coarse-category and fine-identity labels from each layer *as a function of forward-pass step* in a model with feedback connections; the biological claim is that the coarse→fine transition inside one layer is the signature of a feedback contribution and is what makes a recurrent stack functionally deeper than its layer count. Under a strictly feedforward encoder no such within-layer time course can exist, which makes it a cheap architectural discriminator rather than a performance metric ([[wiki/concepts/representation-probing.md]]).

---

## Parallel channels, and a primate/rodent difference

Entorhinal intrinsic connectivity is organised into three rostrocaudal bands (lateral; a wide intermediate band; rostromedial) — proposed as the substrate for **parallel processing** through the hippocampal formation. The species comparison is sharp:

| | Extent of intrinsic projection from any one entorhinal location |
|---|---|
| Rat | the **entire** rostrocaudal extent |
| Monkey | about **half** the rostrocaudal extent |

So the monkey's entorhinal cortex has more segregated connectivity domains than the rat's — read by the authors as a higher degree of parallel processing at the store's gateway in primates.

**(brainstorm) If the primate change at this interface is *more segregation*, the wiki's default of a single shared store interface is the rodent setting.** Every model here has one write port; the anatomy of the species that does the reasoning the wiki cares about is moving toward several partially isolated ports feeding the same store. That is a testable scaling claim — split the write path of a fast-store model into `k` weakly-coupled channels at fixed parameter count and measure interference and compositional transfer as `k` grows — and it is the same one-operator-vs-tiled-family question `T338` and [[wiki/entities/entorhinal-cortex.md]] raise one level down.

---

## What this denies a downstream reader

Stated as an architectural constraint, since that is the form the wiki can use:

- The hippocampus **cannot** recover which modality a component of its input came from, except insofar as the perirhinal (object/anterior) vs parahippocampal (spatial/posterior) split survives into the entorhinal bands — and the disynaptic/trisynaptic cross-routes above show it survives only partially.
- Therefore any de-aliasing the store performs is over *already-mixed* codes: if two situations were made identical upstream, no hippocampal mechanism separates them. This is the upstream half of `T347`, whose measurements are all made at or below the entorhinal stage.
- Conversely, anything the stack keeps separate arrives at the store pre-separated, and costs the store nothing.

---

## Limitations

- **Anatomy, macaque, and old.** Almost every functional claim is imported from a handful of 1990s lesion and single-unit studies; the review adds no data.
- **Unpublished observations carry load.** The intrinsic perirhinal/parahippocampal connectivity pattern and the reciprocity asymmetries are partly the authors' unpublished material.
- **"Integration increases" is never quantified.** No measure of dimensionality, mutual information or mixing rate is offered at any stage — the monotone integration claim is an inference from convergence anatomy, not a measurement, and the one relevant recording (Suzuki et al. 1997) is mixed.
- **`LOSSY` conversion.** Figures 1–3 (the connectivity summary diagrams) are present only as captions.

---

## Connections

- **[[wiki/entities/entorhinal-cortex.md]]** — the same interface one resolution finer and one species over: that page gives the rodent circuit inside the last stage (layer II reelin/calbindin channels, the layer Vb comparator), this one gives the two macaque association stages *upstream* of it and the claim that most cross-modal binding is already done before the entorhinal cortex is reached — and both independently report the deep→superficial return that closes the loop.
- **[[wiki/concepts/complementary-learning-systems.md]]** — supplies the missing encoder in the two-store picture: the fast store's input is not a cortical embedding delivered by one projection but the output of two additional recurrent association stages, and the causal datum that a learned association in neocortex (pair-coding in area TE) *requires* the medial-temporal feedback arm to form is consolidation-by-feedback measured rather than assumed (Higuchi & Miyashita 1996).
- **[[wiki/concepts/pattern-separation-completion.md]]** — bounds what the separator can be asked to do: the transfer curve operates on codes whose modality-specific structure was already mixed away upstream, so two episodes made identical by the association stack cannot be separated by any dentate/CA3 mechanism, and conversely anything the stack keeps apart arrives pre-separated at no cost (`T347`).
- **[[wiki/concepts/broadcast-hierarchy.md]]** — extends that page's ranking instrument past the last cortical stage: the perirhinal/parahippocampal → entorhinal projection is laminar-feedforward by the same Felleman–Van Essen criteria, and the return is compressed-in/diffuse-out in the strong form — one amodal representation redistributed to much of neocortex including unimodal sensory areas.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the same non-reciprocity finding at a second edge: frontal cortex projects to perirhinal cortex far more widely than perirhinal cortex projects back, matching that page's unreciprocated hippocampus → medial prefrontal projection, so asymmetric edges are the rule at this interface rather than a quirk of one pathway.
- **[[wiki/concepts/retrieval-mediated-learning.md]]** — where the reciprocity failure is testable: reinstatement is measured there as a classifier read-out of an absent element, and this page predicts the read-out should be systematically more faithful in early sensory cortex than in frontal cortex, because the return path is wide to the former and narrow to the latter.
- **[[wiki/concepts/temporal-coding.md]]** — supplies the stack's coincidence window and its source: perirhinal theta is imposed by deep entorhinal layers rather than by the septal pacemaker, so the plasticity window at the store's input stage is set by the stage above it.
- **[[wiki/concepts/representation-probing.md]]** — a probe specification this page derives: decode coarse-category and fine-identity labels from *one* layer as a function of recurrent step; a within-layer coarse→fine time course is the signature of a feedback contribution and cannot exist in a strictly feedforward encoder (after Sugase et al. 1999).
