# Perturbation Elicitability — What a Focal Edit Reveals About the Code It Lands In

**Inject current at one site and ask whether the system's reportable content changes. The probability that it does — the *elicitation rate* — is not uniform: it falls monotonically from ~67% in unimodal sensory cortex to a floor of 0% in frontopolar cortex, and the fall is not explained by myelin or excitability. Elicitability is therefore a causal readout of *coding scheme*: a sparse, topographically contiguous, low-dimensional code is steerable by a local edit; a dense, mixed-selectivity, distributed code is not. The same property that makes an abstract layer robust makes it unsteerable, and every activation-editing method in the wiki assumes the first regime.**

> **Provenance.** Raccah, Block & Fox 2021, *Does the prefrontal cortex play an essential role in consciousness? Insights from intracranial electrical stimulation of the human brain*, J Neurosci 41(10):2076–2087, doi:10.1523/JNEUROSCI.1141-20.2020 (`raw/raccah-2021-pfc-consciousness-stimulation.md`). A Viewpoints synthesis — **no new data**; it aggregates a century of intracranial electrical stimulation (iES) reports plus the authors' own cohorts (Fox et al. 2018b, 2020). Written by two opponents of prefrontal theories of consciousness plus a philosopher (Block); read the *rates* as the contribution and the theory verdict as advocacy.

---

## The method, and what it can and cannot show

| Property | Specification |
|---|---|
| Preparation | Epilepsy patients implanted for seizure localisation; subdural grids or stereo-EEG depth probes. Same contacts record and stimulate |
| Parameters | Bipolar, typically **50 Hz, 2–10 mA**, inside an empirically derived safe window (Gordon et al. 1990) |
| Read-out | Standardised open-ended question after each trial ("Did you experience any change?") plus follow-ups |
| Control | **Sham stimulation.** Patients almost never report effects on sham trials — so false positives from demand characteristics are rare, and patients reliably separate spontaneous mentation from elicited experience (Fox et al. 2020; Fox & Parvizi 2021) |
| Positive control on power | **Dose–response**: across 2–8 mA in orbitofrontal and anterior cingulate cortex, subjective intensity rises *linearly* with current, especially for emotional content (Yih et al. 2019). Where the method works, it works gradedly — so a null is a property of the site, not of the instrument |
| What it cannot show | Whether iES excites, inhibits, or both; how far current spreads passively or synaptically; whether sub-reportable effects occurred. All brains are diseased (though non-ictal epileptic tissue shows normal stimulus-evoked responses, S. Liu & Parvizi 2019) |

**The instrument's logical shape.** iES is one of the few *causal* handles on human cortex, and it tests constitution rather than correlation: if a site's activity is part of what the content *is*, perturbing it should perturb the content. Null results are weak evidence individually and strong in aggregate only because the same protocol yields 67% positives two centimetres away.

---

## The gradient

67 patients, **1537 electrode sites**, whole cortical mantle (Fox et al. 2020), projected onto the Yeo 17-network parcellation:

| Region / network | Elicitation rate | Character of the effect |
|---|---|---|
| Unimodal — primary visual, somatomotor | **~67%** | Simple, modality-matched: phosphenes, shapes, colours, tingling, twitches |
| Category-selective ventral temporal (fusiform face area) | High | **Distortion of the percept currently present** — the clinician's face is remodelled while being looked at |
| Medial temporal | High | Detailed episodic memories, dream-like hallucinations |
| Orbitofrontal cortex (22 patients, 172 sites) | **17%** | Olfactory, gustatory, somatosensory, multimodal; often emotionally coloured; **never visual**. Anterior–posterior gradient: mid/posterior positive, ventral frontal pole (BA 10) **zero** |
| Anterior cingulate | Low but reliable | Visceral and somatic sensations, urge to move or laugh, fear (pregenual), and in anterior midcingulate a reproducible **motivational** state — "push harder … I have to make it through" (Parvizi et al. 2013) |
| Lateral prefrontal (dorsolateral / ventrolateral) | Very rare; **five published reports in total** | Content-free *thoughts* ("a thought about a game kids play"; "a person", explicitly non-visual — A. Liu et al. 2020; Popa et al. 2016). One contested face-hallucination case (Vignal et al. 2000). All responsive sites were **posterior** lateral prefrontal |
| Anteromedial prefrontal (BA 9m/10m) | **Null** across dozens of patients (Fox et al. 2020; Trevisi et al. 2018, n = 36) | — |
| Frontopolar (medial, lateral, ventral) | **0% — the global minimum of the whole brain**; no iES effect ever reported in the literature | — |
| Other transmodal association cortex (posterior cingulate, default and limbic networks) | Low, alongside prefrontal | Low elicitability is a property of **abstract-processing cortex generally**, not of prefrontal cortex specifically (Foster & Parvizi 2017) |

**Simple neurophysiological attributes do not explain the gradient.** Myelin concentration and electrical excitability were tested and fail (Fox et al. 2020); the residual predictor is intrinsic network architecture.

---

## The coding-scheme reading — the part that transfers

The source's own mechanistic proposal, and the reason this page exists:

| Cortex type | Code | Consequence for a focal perturbation |
|---|---|---|
| Unimodal | **Sparse**, tuned to specific perceptual features (edge-selective V1 cells), and *topographically contiguous* — neighbouring neurons code neighbouring feature values | A stimulating electrode captures a coherent, complete sub-population. The perturbation is itself a legal code word, so it reads out as content |
| Prefrontal / transmodal | **Dense**, mixed-selectivity: single cells tuned to many higher-order features of perception, action and intention (Fusi et al. 2016; Parthasarathy et al. 2017; Duncan 2001; Stokes et al. 2013). Information is carried across a large circuit, not a patch | A local electrode touches an arbitrary, incomplete slice of a distributed vector. The perturbation is off-manifold: it is not a code word in any content, and nothing downstream reads it as one |

**(brainstorm) Elicitability ≈ the fraction of a representation that fits under an electrode.** For a code of dimension `d` spread over `N` neurons with participation ratio `p`, a probe reaching `k` contiguous cells perturbs roughly `k/(pN)` of the representation's support. Sparse-and-topographic means `pN ≈ k` — one probe moves the whole thing. Dense-and-distributed means `pN ≫ k` — the same probe moves a projection so small that the state stays inside the basin it was in. This makes the cortical gradient a *measurement of `pN` in a common unit*, and gives the wiki a causal counterpart to the correlational dimensionality estimates on [[wiki/concepts/population-geometry.md]].

**The design trade-off, stated.** Distributedness buys robustness — lesion tolerance, graceful degradation, superposition capacity — and pays for it in **steerability**. A layer that cannot be knocked off course by a local edit also cannot be *driven* by one. This is not a biological curiosity: it is the same trade-off that decides whether activation addition along a probe direction works ([[wiki/concepts/representation-probing.md]]). Steering an abstract layer succeeds only where the edit is applied *in the code's own basis* (a fitted direction across the whole population), and fails where it is applied in the substrate's basis (a contiguous block of units). The electrode is a substrate-basis edit. Activation steering is a code-basis edit. **The measured gradient is the price of confusing them.**

---

## The second finding: prefrontal effects insert content rather than perturbing it

Independent of rate, the *kind* of effect differs by region, and this is the argument that bites theory:

| Site | Relation of the elicited effect to what the patient is currently experiencing |
|---|---|
| Fusiform face area | **Tied to the ongoing percept** — features of the face being viewed are altered |
| V1, somatomotor | Added within the ongoing sensory stream, modality-matched |
| Orbitofrontal / anterior cingulate | **Unrelated to the environment**: smells, tastes, visceral sensations, emotions, motivational states — hallucinations in the technical sense |
| Lateral prefrontal (the rare positives) | Conceptual thoughts, explicitly reported as *not* perceptual |

So no site in prefrontal cortex, when perturbed, changes what the patient is currently perceiving — with at most one contested exception in a century of stimulation. Both higher-order and global-workspace theories predict the opposite: if prefrontal activity re-represents, indexes, or maintains-and-broadcasts the current percept, then editing it should distort that percept. Logged as [[wiki/empirical-tensions.md]] T269.

**What survives on the positive side:** orbitofrontal and anterior cingulate stimulation reliably produces *emotional and motivational* content, replicated across tens of patients and dose-dependent. If prefrontal cortex constitutes any conscious content, on this evidence it is affective, not perceptual.

---

## The false-negative ledger, taken seriously

A design instrument built on nulls has to survive its own caveats:

| Objection | Standing |
|---|---|
| Patients underreport subtle effects | Live. Mitigated by the eloquence of positive case reports, and by the sham-trial baseline, but not eliminated |
| Patients may be mind-wandering, so a perturbation of ongoing *perception* would go unnoticed | Live, and the authors raise it themselves — though the elicited prefrontal effects are typically unrelated to sensory processing in the first place |
| Effects exist below the reportability threshold | Live and testable, untested: the proposed fix is iES **during a task**, scoring performance rather than report. Transcranial magnetic stimulation and lesions of lateral prefrontal cortex *do* impair perceptual and metacognitive performance under controlled conditions (Rounis et al. 2010; Del Cul et al. 2009; Fleming et al. 2014) |
| The method lacks power in prefrontal cortex | Answered by the dose–response result in orbitofrontal / anterior cingulate cortex |

**The unresolved shape of the disagreement.** "No reportable change in content" and "measurable performance cost" are both true of lateral prefrontal perturbation. That is exactly what a *routing* component predicts and what a *content* component does not — breaking a router degrades throughput without changing what any message says. The iES literature is therefore compatible with prefrontal cortex being the bus and incompatible with it holding the payload.

---

## What this gives an abstract-reasoning architecture

| Finding | Design consequence |
|---|---|
| Elicitation rate falls monotonically toward transmodal cortex | **Perturbability is a proxy for abstraction.** An architecture that claims an abstract layer should *predict* that focal single-unit edits there do nothing; if a contiguous edit steers it, the layer is holding a sparse local code and the abstraction claim is unearned |
| The gradient is not explained by myelin or excitability, but by network architecture | Robustness is a property of the code, not of the hardware — it is obtained by distributing, not by insulating |
| Local perturbation of a hub does not change the content on the bus | A shared-bus design should be **tested by perturbation, not only by decoding**. The wiki's ignition account predicts that disturbing the workspace disturbs the current content; the strongest available human causal test does not find this |
| Effects, where present, are hallucination-like | A generator that runs at the hub produces content *unrelated to the input* — which is the internally-generated mode of gap `G90`, arriving as a side-effect of stimulating exactly the transmodal hubs the default-mode literature claims |
| Sham trials are nearly always negative | The protocol is worth copying for any human-report instrument: an interleaved null condition with identical framing, scored per trial |

---

## Connections

- **[[wiki/entities/global-neuronal-workspace.md]]** — the theory this evidence is aimed at: the workspace predicts that perturbing the prefrontal hub alters or interrupts the content currently broadcast, and a century of intracranial stimulation of lateral and anterior prefrontal cortex finds the lowest elicitation rates in the brain instead.
- **[[wiki/concepts/ignition.md]]** — the commit operation this page tests causally: stimulation should be able to force or corrupt a commit, and in the region where ignition is claimed to be densest it produces no reportable change of content — which relocates the evidence for ignition onto propagation (`d′`) rather than onto the gate's locus.
- **[[wiki/concepts/population-geometry.md]]** — the causal counterpart of that page's dimensionality measurements: dense mixed-selectivity coding predicts low elicitability, so the cortical gradient measures how much of a representation's support fits under one electrode, in a unit comparable across regions.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the other half of the trade-off: sparsity plus topographic contiguity is what makes a code locally addressable and therefore locally perturbable, and the price of the overlap arithmetic that page prices is that a focal edit is a legal code word.
- **[[wiki/concepts/representation-probing.md]]** — the machine-side instrument with the same logic and the opposite basis: activation addition edits along a *fitted population direction* and works on abstract features, whereas an electrode edits a contiguous block of substrate and fails there, so "the model uses X" needs the edit expressed in the code's basis.
- **[[wiki/concepts/broadcast-hierarchy.md]]** — the anatomical gradient this rate gradient tracks: elicitability falls exactly along the selective-in / diffuse-out axis toward the transmodal apex, so low perturbability is a signature of being high in the hierarchy rather than of being prefrontal.
- **[[wiki/entities/default-mode-network.md]]** — the network-level form of the null: default, limbic and other transmodal networks show the lowest elicitation rates in the Yeo parcellation, and where stimulation there does produce something it is internally generated content unrelated to the environment.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the causal boundary condition on the control layer: anteromedial prefrontal stimulation is null across dozens of patients while orbitofrontal and cingulate stimulation reliably produces affective and motivational states, so the medial wall's value/emotion subdivisions are perturbable and its most anterior ones are not.
- **[[wiki/concepts/effective-connectivity.md]]** — the same causal-versus-correlational distinction one level up: that page's interventions establish directed influence between areas, this page's establish whether a site's activity constitutes the content it correlates with.
- **[[wiki/concepts/subjective-value.md]]** — where the positive prefrontal results land: orbitofrontal and anterior cingulate stimulation elicits graded affective and motivational states (including mood improvement in depression, Rao et al. 2018), which is the only conscious content the causal evidence assigns to prefrontal cortex.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the methodological transfer: perturb-and-observe is how a hidden graph's edges are certified, and this page is that protocol applied to the substrate itself, with the result that a distributed node cannot be probed by touching one of its parts.
