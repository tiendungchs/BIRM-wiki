# REMERGE — generalization by recirculating an episodic store's own output

**An exemplar model made recursive. The similarity computation over stored episodic traces does not stop at its first output. The feature pattern it reconstructs is fed back as input and scored against the same store again, with the external input clamped, until the network settles. Links between items never experienced together fall out of the settled state, so inference is produced *at retrieval* from pattern-separated traces, with nothing integrated at encoding.**

> **Provenance.** Kumaran & McClelland 2012, *Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system*, Psychol Rev 119(3):573–616 (`raw/kumaran-2012-generalization-recurrent-interaction-episodic-memories-remerge.md`). Primary source. REMERGE = Recurrency and Episodic Memory Results in Generalization. The page was first written second-hand from Kumaran, Hassabis & McClelland 2016 (`raw/kumaran-2016-complementary-learning-systems-updated.md`, Box 6). Where the two differ, both are stated below. The clipped source renders the equations as images, so the forms in the architecture table are rebuilt from the text's definitions of each term.

---

## The problem it exists to solve

| Step | Claim |
|---|---|
| Complementary learning systems: the hippocampus stores specifics in orthogonalized codes, and the slow cortical learner extracts structure | [[wiki/concepts/complementary-learning-systems.md]] |
| Transitive inference (TI), paired associate inference (PAI) and acquired equivalence (AE) are solved within one session, and cutting the hippocampus off abolishes them while sparing the premise pairs (rat TI: fornix transection or perirhinal + entorhinal ablation, Dusek & Eichenbaum 1997; rat PAI: selective hippocampal lesion, Bunsey & Eichenbaum 1996) | So a store with maximally non-overlapping codes is doing cross-item inference |
| **Encoding-based overlap theories** repair this by making related episodes' codes overlap (relational theory, temporal context model, integrative encoding) | [[wiki/concepts/retrieval-mediated-learning.md]]. This gives up pattern separation for exactly the items most likely to interfere |
| REMERGE's repair: assume **perfect** separation (localist conjunctive units), and make the read recurrent | Generalization becomes a property of the retrieval dynamics, not of the stored code |

---

## Architecture

| Component | Specification | Hippocampal mapping (source's) |
|---|---|---|
| Feature layer | Localist units for components (items, objects, locations). Logistic `y = 1/(1+e^{−net/τ})` for present/absent features; softmax within a dimension for mutually exclusive values | CA1 + entorhinal cortex + neocortex: **componential** codes built by the slow learner |
| Conjunctive layer | One localist unit per stored episode (e.g. `BC`). **Hedged softmax** `y_i = e^{net_i/τ} / (Σ_k e^{net_k/τ} + C)` | Dentate gyrus–CA3: conjunctive, pattern-separated |
| Feature ↔ conjunctive | Bidirectional excitatory. This loop is the only source of generalization | **"Big-loop" recurrence**: output of the hippocampal system re-entering as input (below) |
| Response layer | Logistic. Conjunctive → response excitatory, plus feedforward inhibition in TI (`AB` excites `A`, inhibits `B`) | — |
| Net input | `net_i(t) = λ·cnet_i(t) + (1−λ)·net_i(t−1)`, `λ = 0.2`; `cnet_i = Σ_j w_ij y_j + estr·ext_i + ε`, `estr = 0.5`, noise only in the replay runs | — |
| Choice | Luce rule on final response activities, equivocation set by `β` | — |
| Run | External input clamped for the whole run; **300 timesteps** of settling; weights fixed ("recall mode") | Encoding/recall split across theta phase or neuromodulatory state |
| Learning | Not simulated. The first exposure creates a weak unit; further training is modelled by **scaling the premise weights between runs** | — |
| Free parameters | **Three**: temperature `τ` (all layers), novelty constant `C`, choice `β` | — |

**`C` is a novelty term.** A plain softmax sums to 1, so some stored trace always wins. With `C` in the denominator, total conjunctive activity rises with memory strength and with how well the input matches the store, and stays low for a novel input. This matches the generalized context model (GCM) constant for "this item is new" (Nosofsky et al. 2012).

**`τ` is the GCM sensitivity, inverted.** GCM similarity is `η = e^{−c·d(i,j)}` with city-block mismatch distance `d`. The conjunctive activation is the same quantity computed from matching features, with `c = 1/τ` (Appendix). Low `τ` → one best-matching trace wins. High `τ` → several related traces stay co-active.

### Recurrent similarity computation, step by step (TI, `B–D` probe)

| Cycles | Feature layer | Conjunctive layer |
|---|---|---|
| Early | `B`, `D` clamped | `AB`, `BC`, `CD`, `DE` equally active: the input is equally similar to all four |
| Middle | **`C` rises** above every unclamped unit: it gets convergent input from `BC` and `CD` | — |
| Late | Reconstructed pattern ≈ `B, C, D` | `BC`, `CD` beat `AB`, `DE`: they now match the *reconstructed* input better |
| Output | — | `BC` (excites `B`) + `CD` (inhibits `D`) → **`B` chosen** |

On a `B–E` probe, `CD` ends above `AB` and `EF`, although `CD` shares **no** feature with the input. On a premise probe (`B–C`), `BC` dominates and the other traces stay low.

**Why one pass cannot do it** (derived from the architecture, not simulated in the source): on the first pass `AB`, `BC`, `CD`, `DE` are equally active, so `B` gets `+BC −AB = 0` and `D` gets `+DE −CD = 0`. A non-recurrent exemplar model is at chance on `B–D` by construction. The source's general statement is that GCM-class models "are unable to perform inference" here, because their similarities are computed only against the external input. A standard interactive activation and competition (IAC) network (McClelland 1981) reproduces the same `B–D` dynamics, so the effect belongs to the recurrent class, not to the softmax form.

---

## Anatomy: the loop is the big loop, not CA3 collaterals

The 2016 summary located the recurrence in CA3 recurrent collaterals plus the entorhinal–hippocampal loop. The primary source places it **outside** CA3, and contrasts it with CA3 collaterals explicitly. CA3 autoassociation reinstates one stored pattern inside an otherwise one-way pass. Big-loop recurrence recirculates the *output* of the whole hippocampal system as its next input.

| Evidence for the loop | Source cited |
|---|---|
| Superficial and deep entorhinal layers are interconnected | van Strien et al. 2009 |
| Hippocampus projects to **both** deep and superficial entorhinal cortex | van Strien et al. 2009 |
| Deep entorhinal cortex projects back to dentate gyrus, and its activation suffices to drive dentate gyrus | van Strien et al. 2009 |
| Subiculum stimulation → deep entorhinal cortex → re-entry into CA1 | Kloosterman et al. 2004 |
| Perforant-path stimulation evokes triple dentate responses, especially at rest | Buzsáki 1989 |

The feature layer's anatomical home is left open: entorhinal cortex, other medial-temporal regions, or loops through neocortex including prefrontal cortex. The first measurement favours the first option, a direct deep → superficial entorhinal route, with perirhinal and parahippocampal loops not supported (Koster et al. 2018, below).

**Nodal codings, reread.** Cells responding to a shared feature across many events (Wood et al. 1999) are taken as the **componential input/output format** of dentate gyrus–CA3, not as a generalization mechanism. CA3 codes are near-orthogonal across rooms while CA1 codes track shared enclosure shape (Leutgeb et al. 2004), and fast-developing CA1 codes fit a direct entorhinal→CA1 drive. Human "concept cells" respond at 300–600 ms. The source suggests that latency could reflect recurrent co-activation of conjunctive ensembles rather than feedforward drive **(tentative)**.

### The loop measured: deep → superficial entorhinal recirculation at test (Koster et al. 2018)

> Koster, Chadwick, Chen, Berron, Banino, Düzel, Hassabis & Kumaran 2018, *Big-loop recurrence within the hippocampal system supports integration of information across episodes*, Neuron 99:1342 (`raw/koster-2018-big-loop-recurrence-hippocampal-integration-across-episodes.md`). The first empirical test of the model's circuit claim, by the model's author group. Figures and supplement (Figures S1–S9, Tables S1–S4, including the between-subject simulation) were not clipped.

**Design.**

| Element | Content |
|---|---|
| Subjects, scanner | n = 26 (4 excluded: 3 for entorhinal signal dropout, 1 for below-chance `AC`). 7 T, 0.8 mm isotropic EPI, TR 2 s, partial coverage along the hippocampal axis |
| Task | Paired associate inference (PAI). 144 triads, face–object–face or face–scene–face. Per block: 16 `AB` pairs, then the 16 `BC` pairs, then the whole sequence once more, so **2 exposures** per pair |
| Test | `AC` is tested **before** `AB` or `BC` of the same triad. Lure is a same-category item from another triad, so neither category memory nor familiarity solves it |
| Key property | `A` and `C` are always faces, so on `AC` trials any scene-vs-object decoding can only come from the reinstated absent `B` |
| Laminar split | Entorhinal cortex segmented per subject into thirds: superficial (sEC ≈ layers II/III, the input to dentate gyrus/CA3 and CA1) and deep (dEC ≈ layers V/VI, the hippocampal output). The middle third is discarded |
| Instrument | Informational connectivity (IC): trial-by-trial covariation of decoding evidence between two regions, partialling out every other MTL (medial temporal lobe) region and both layers' mean univariate signal |

**Results.**

| Prediction of the loop | Measurement |
|---|---|
| Layers carry separable signal | A voxel's temporal response profile classifies it as sEC or dEC: 85.9% over all trials, 67.3% on `AC` trials alone (both p < 0.001). Time courses standardised, so not a mean difference |
| Absent `B` reinstated on the **input** layer | Scene-vs-object decoding in sEC on `AC` trials: z = 2.45, p = 0.007, one-tailed. Survives regressing out the nearest smoothed dEC voxel from each sEC voxel (p = 0.003) |
| A functional dEC → sEC connection | Laminar IC ρ = 0.11 (p < 0.0001). Above the IC of anatomically indirect MTL pairs (z = 2.96), and classified as "direct" (evidence 0.62, p < 0.024). Survives the local-signal regression and a medial-section ↔ lateral-section control that has no adjacent voxels |
| sEC reinstatement is driven by the loop | Across subjects, laminar IC × sEC decoding r = 0.41; × dEC decoding r = −0.20; difference 0.61, p = 0.014. Partialling the other layer: 0.46 vs −0.32 |
| Recirculated content re-enters the **separating** fields | Laminar IC × sEC–DG&CA3 IC r = 0.39; × sEC–CA1&subiculum IC r = −0.21; difference 0.61, p = 0.016 |
| The loop closes inside entorhinal cortex | No correlation of sEC reinstatement with sEC–perirhinal or sEC–parahippocampal IC (\|r\| ≤ 0.21, n.s.). All effects survive partialling both out |
| The loop predicts inference | Laminar IC × `AC` accuracy r = 0.38 (p = 0.028). dEC decoding, the proxy for ordinary associative retrieval of `AB`/`BC` from the faces on screen, × `AC` accuracy r = −0.20; difference 0.57, p = 0.021 |
| Behaviour | `AB` 0.89, `BC` 0.88, `AC` 0.76. RT 2,013 / 2,127 / **2,935 ms**; `AC` is slower on correct trials alone too |

**What it settles and what it does not.**

| Point | Reading |
|---|---|
| Encoding-based accounts | Predict dEC reinstatement of `B` (completion of an `ABC` composite) but **not** its recirculation to sEC or the link to behaviour. Here dEC reinstatement is the one signal that predicts nothing |
| Anatomical home of the feature layer, left open by the 2012 paper | Direct dEC → sEC, not a longer loop through perirhinal or parahippocampal cortex. The authors cannot exclude an unmeasured MTL sub-region or a route outside the MTL |
| Settling cost | `AC` is ~800 ms slower than `BC`, which fits per-query settling and the model's `RT` row below. Settling cycles are still not mapped onto milliseconds |
| Causality | None. Every brain–behaviour link is a between-subject correlation at n = 26, one-tailed, with r ≈ 0.4. Laminar BOLD carries draining-vein confounds, which the controls address but cannot exclude, and absolute decoding accuracies are low |
| Rival model the source names | Schapiro et al. 2017 (second-hand here): big-loop recurrence **plus** a slowly learning entorhinal → CA1 "monosynaptic pathway" (MSP) that encodes overlapping structure. The loop dominates after 1–2 exposures and the MSP after many. Two exposures cannot tell the hybrid from pure REMERGE |

**(brainstorm) Two importable instruments.** (i) **The bridge-item probe at test.** In any multi-hop retrieval model, decode the absent bridge entity from the store's *input* side on two-hop queries. A one-read model can show it at the output only. A recirculating model shows it re-entering the input, and the per-query strength of re-entry, not of first-pass retrieval, should predict two-hop accuracy. (ii) **The direct/indirect positive control for a connectivity measure.** Before reading an IC (or attention-flow) edge between two modules, score the measure on module pairs whose wiring is known. It must rank direct above indirect before the unknown edge is classified. Few connectivity results in the wiki report such a control.

---

## Key results

| Paradigm | Data | Model | Parameters |
|---|---|---|---|
| TI over training (Ryan et al. 2009, n = 20, 6 items, 5 stages) | Premise and inference accuracy rise in parallel. Close = distant pairs | Same pattern from scaling premise weights only | `τ = 0.45` |
| **Lag generalization** (model property) | — | Inference trails premise accuracy at **every** weight strength. At low `τ`, premise reaches asymptote before inference leaves chance. At high `τ` the two rise nearly together | `τ` sets the lag |
| PAI (Zeithamova & Preston 2010, n = 23, 144 overlapping pairs) | Premise 82%, inference 64% (range 47–90%). Good n = 12: 73% inference / 85% premise. Poor n = 11: 54% / 77% | Good vs poor = premise weights **1.52 vs 1.47** | `τ = 0.2`, `C = 1` |
| PAI neural (same study) | Hippocampal activity on `BC` encoding trials, not `AB` trials, predicts later `A–C` success | Higher summed conjunctive activity on `BC` trials at the stronger weight, **driven by the `AB` unit**: ordinary pattern completion of the overlapping trace, no integrated unit | — |
| AE (Shohamy & Wagner 2008) | Primary source ([[wiki/concepts/retrieval-mediated-learning.md]]): generalization **81%** (range 38–100%), trained **93%** at test. The earlier "~75% at ~90% premise" was the REMERGE paper's summary. Hippocampal–midbrain activity ramps over training in good generalizers only | Behaviour fitted by weight strength. Neural ramp **only partly** fitted: the simulated poor group also ramps, and the model's good-group rise comes from the *directly matching* `F2–S1` unit, not from completion of related traces. The data also locate the effect on `F2–S1` trials (strongest correlation; midbrain increase selective to them; no trial-type interaction), so the locus does not separate the model from the source's chained-retrieval reading | — |
| Amnesia (Knowlton & Squire 1993) | Prototype categorization spared, recognition impaired | Amnesic vs control weights **0.83 vs 1.50**. Categorization rises slowly with weight, recognition steeply. Fits with recurrence **disabled** too | `τ = 1` |
| Patient E.P.: normal categorization, chance recognition | — | **Not reproduced** | — |
| 5–4 categorization (meta-analysis of 30 experiments) | — | Sum of squared deviations (SSD) 0.07 to data and 0.06 to GCM, with the A2/A1 advantage. Three parameters, against GCM's five plus choice | — |
| Recognition (8-bit prototype distortions) | — | Recurrent ≈ feedforward-only control (feature layer duplicated into in/out copies) on d′. Both best at `τ = 0.1`, still adequate at `τ = 1` | — |
| Shortcut replay (Gupta et al. 2010, T maze) | A share of ripples replay never-run shortcuts, above chance recombination | 12 locations, pairwise journeys, start→unit weight 1.0 vs end 0.9 (forward bias), threshold 0.6, inhibition of return, noise SD 0.005, 3-node sequences, 50 runs per start: **60% forward, 26% backward, 14% shortcut, <1% disjoint**. More shortcuts than observed | `τ = 0.2`, `C = 5` |
| Sleep (Ellenbogen et al. 2007, n = 56) | Inference at chance after 20 min, **75%** after 12 h, premise ~90% throughout | Reproduced by stronger weights after the delay | `τ = 0.2` |
| Same study: distant pairs gain more from sleep (`B–E` > `B–D`) | — | **Not reproduced.** Close pairs emerge at equal or lower weights | — |

### The weak-trace claim: two statements, and the primary data restrict it

| | Kumaran et al. 2016 (review) | Kumaran & McClelland 2012 (primary data) |
|---|---|---|
| Statement | Separate-trace mechanisms "allow weak hippocampal traces that support only relatively poor item recognition to mediate near-normal generalization" | True for **categorization**, where generalization is first-pass similarity to the input (the amnesia simulation, which fits equally well without recurrence) |
| Inference (TI, PAI, AE) | Not distinguished | **Reversed.** Weaker premise traces hurt inference *more* than premise accuracy (lag generalization), because recurrent similarity "depends on the faithful recall of robustly encoded" premises |

So weak traces sparing generalization is a signature of the **exemplar half**, not of the recurrent half. The signature of the recurrent half is the opposite: inference is the *first* thing lost when premise traces weaken. The wiki had attributed the review's version to the recurrent mechanism ([[wiki/empirical-tensions.md]] T334, now corrected).

---

## Predictions that separate it from encoding-based accounts

| Test | REMERGE | Temporal context model / value transfer |
|---|---|---|
| **Close the hierarchy into a circle**: after `A>…>F`, train `F+ A−`, then probe `B–E` | **Chance**: retrieval-time similarity now runs both ways round the loop (simulated, Fig. 16) | **`B` still preferred**: the stored item–context codes of `B` are not revised by the new pair |
| Same, probe `B–D` | `B` preferred | `B` preferred |
| Replay content as inhibition varies offline | Generalized replay **interspersed** with single-episode replay | Similarity is fixed in the code, so no switching is predicted |
| Disable big-loop recurrence | Abolishes generalized replay and inference, spares premise memory | — |
| Strength of big-loop recurrence, across people (Koster et al. 2018, above) | Predicts inference; ordinary retrieval of the premises does not. **Measured** in correlational form: laminar IC × `AC` r = 0.38, dEC decoding × `AC` r = −0.20. No ablation | Not predicted: the composite is reinstated in the output layer and nothing needs to recirculate |
| Replay-disruption effect | Generalization more sensitive than premise memory | — |
| Response time, unobserved vs trained pair | Longer, if settling cycles map onto response time. Not simulated **(brainstorm)**. In PAI after 2 exposures, `AC` is ~800 ms slower than `BC`, correct trials included (Koster et al. 2018) | Equal: the link is read from a cached code **(brainstorm)** |
| Hippocampal lesion **after** premise training, before test **(brainstorm)** | Inference abolished: the loop must run in the store at test | Spared, if the ordering is cached in a code outside the lesion |

**The response-time row has data, from acquired equivalence, not transitive inference** (Shohamy & Wagner 2008, [[wiki/concepts/retrieval-mediated-learning.md]]). In the top quartile the untrained pair is answered within 39 ms of the trained ones, and the gap predicts generalization (r = −0.69). This favours a stored link. It does not rule REMERGE out, because the mapping from settling cycles to milliseconds is unspecified. **Paired associate inference after only two exposures shows the opposite**: the unobserved `AC` pair takes ~800 ms longer than the trained `BC`, and in the same subjects the strength of entorhinal recirculation predicts `AC` accuracy (Koster et al. 2018, above). The two studies differ in paradigm (acquired equivalence vs associative chain) and in training (8 intermixed repetitions with feedback vs 2 exposures), and either difference could set which mechanism runs ([[wiki/empirical-tensions.md]] T334).

**The ablation row has a rat analogue, but it does not test the model** (Dusek & Eichenbaum 1997). Perirhinal + entorhinal ablation (lateral entorhinal 93% removed, perirhinal 71%) and fornix transection each leave the four premise pairs intact and put `B–D` at chance: 50% on the first presentation, against 88% in controls (n = 6, 4, 8). The two lesions do not differ from each other. That is the predicted dissociation. But entorhinal cortex is a candidate home for the feature layer, and in the model removing the feature layer takes premise memory with it. The premises survive anyway, by a route the model does not contain (the source's candidate: configural stimulus–reward associations). So the data fit any account in which a second system learns the pairs, and do not single out the loop. **(brainstorm)** The fornix lesion also removed the septal input, verified by lost hippocampal acetylcholinesterase staining. The model assigns the encoding/recall split to exactly that kind of modulatory state. So the fornix deficit may come from losing the read-mode control rather than the loop itself.

**The post-training lesion row has second-hand data, and it goes against the loop** (Van der Jeugd et al. 2009, via Wendelken & Bunge 2010, [[wiki/entities/lateral-frontoparietal-network.md]]). Mouse hippocampal excitotoxic lesions before training impaired transitive inference. Lesions after training but before the inference test did not. The training–test delay is not stated in the citing source. A cortical code written by replay during that delay would rescue the model ([[wiki/empirical-tensions.md]] T334, merge reading). A loop that must settle in the hippocampus at test does not. **And when premises are on screen, the query-time composer is not in the hippocampus at all.** Chaining two relations raises rostrolateral prefrontal activation and leaves hippocampal activation unchanged (`n = 16`). So REMERGE's settling is at most the solver for *memorised* premises.

**Human lesion data with memorised premises give one profile no premise-weight sweep produces** (Koscik & Tranel 2012, [[wiki/entities/medial-prefrontal-cortex.md]]). Seven items, adjacent-pair training with no criterion. Premise accuracy at test is 0.53–0.59 in every group. Controls are at chance on transitive pairs (0.52, 0.54), which is what lag generalization predicts at weak premise weights. vmPFC patients have equal premise accuracy and are **below** chance (0.36 ± 0.18, `n = 15`). The source models training only by scaling all premise weights together, and lowering that scale moves inference toward chance, not past it. Unequal weights across pairs might produce reversals, but the source does not simulate them. So, inside the simulated range, a reversal with premise accuracy held equal needs a variable the model lacks: a competing reader, or the loss of whatever suppresses one. Unilateral MTL lesions (`n = 17`) do not bear on the loop, because no deficit to chance can be seen against controls at chance.

**With controls above chance, the human vmPFC profile is inside the model's range** (Spalding et al. 2018, [[wiki/entities/medial-prefrontal-cortex.md]]). Paired associate inference after blocked `AB` → `BC` training, two rounds each, 3AFC. Controls score 0.76 on `AC` (chance 0.33). vmPFC patients (`n = 5`) score 0.48. Their direct-pair accuracy is equal and near ceiling (0.95–0.98), and the deficit survives restricting to triads with both premises correct. There is no reversal, and the 3AFC lures could not show one. Two readings, each using one variable the model has:

| Reading | Variable changed | Predicts `AC` deficit | Predicts the larger `AB_final` decline (vmPFC 0.96 → 0.78, NC 0.98 → 0.91) |
|---|---|---|---|
| Lost setter of `τ` (the prefrontal control the source names) | Read-time inhibition only. Premise recognition is fine at low `τ`, and inference needs co-activation | Yes, toward chance | **No**: the premise weights are untouched |
| Weaker `AB` traces | `AB` weight. Lag generalization costs inference first | Yes. Equal 3AFC accuracy is compatible with unequal weights (`AC_alt` conditions on accuracy, not on weight) | **Yes**, and `AB_final` was tested *after* `AC` |

**(brainstorm)** The second reading accounts for both findings with one parameter, but it moves the explanation to *why* `AB` weakens. The authors' answer is retroactive interference from `BC` learning, which an intact vmPFC prevents by integrating `ABC`. REMERGE cannot express that, because learning is not modelled and weights are set by hand. So the profile fits the model only if something outside it protects the first trace. The cheap check in simulation: lower `τ` alone, then lower the `AB` weight alone, and score both `AC` and `AB`. Only the second should reproduce the pair.

Only preliminary circle-closure data exist (chimpanzees, Gillan 1981; rats, Davis 1992; small samples): transitive responding was disrupted. The source frames the contrast as model-based vs model-free (Daw et al. 2005). REMERGE builds the answer by search at the point of choice. The temporal context model caches a similarity structure at encoding, though it caches representations rather than values.

**(brainstorm) The circle test is a cheap L0 instrument for any machine.** Train an ordering, then add one premise that closes it. A model that caches an ordinal embedding (a trained positional code, a learned value per item) keeps `B > E`. A model that composes at query time goes to chance on `B–E` and keeps `B > D`. This needs no probe of internal state, and it tells you where the model pays for an unobserved path.

---

## Where it sits in the wiki's write-time/read-time trade-off

| | Write-time integration | **REMERGE** | Query-time composition (naive) |
|---|---|---|---|
| What is stored | a composite the agent never experienced | separated traces only | separated traces only |
| Who pays for the unobserved path | the encoder, speculatively | the retrieval dynamics, per query (300 cycles) | a traversal operator, per hop |
| What decides success | reinstatement at encoding | **premise trace strength × `τ`** | per-hop accuracy |
| Failure mode | schema distorts the item | a settled state that mixes the wrong traces | multi-hop collapse |

This makes REMERGE the mechanistic form of Position B in [[wiki/empirical-tensions.md]] T334. The temporal context model gets the ordering from retrieved-context overlap built during training. [[wiki/entities/tolman-eichenbaum-machine.md]] answers from a structural code it had to learn first. REMERGE needs neither, only a store and a loop.

**The source concedes the boundary is not sharp.** Ellenbogen's distant-pair sleep benefit is what a *stored* linear structure predicts, and REMERGE cannot produce it. If weights could change during settling or offline, the co-active feature pattern could be written as a **new localist unit** ("stored generalization"). Because it gets its own unit, it would not degrade recall of `AB`. The source does not simulate this, and it warns that letting learning run during recall is risky (Hasselmo & Bower 1992). Generalized replay is the proposed route, so a retrieval-based mechanism can build over time the composite an encoding-based account assumes.

---

## The machine parallels

| REMERGE | Machine counterpart | Source of the parallel |
|---|---|---|
| Similarity of input to stored traces, iterated with reconstructed input | **Memory networks** (Weston et al. 2014): query + retrieved sentence re-queries the store | Kumaran et al. 2016 |
| Higher-order similarity between `BC` and `DE` when their input-space similarity is zero | **Isomap** (Tenenbaum et al. 2000): similarity as shortest path over a neighbourhood graph | Kumaran & McClelland 2012 |
| Consolidation as finding the low-dimensional structure (`A–…–F` is a line) under high-dimensional episodes | Manifold learning. The source suggests recurrence might drive it, **tentatively** | Kumaran & McClelland 2012 |

The Isomap parallel is the one closest to [[wiki/concepts/latent-graph-discovery.md]]. REMERGE computes something like a geodesic over the graph whose edges are the stored episodes, without ever building that graph or its path. The settling dynamics play the role of the shortest-path search.

**(brainstorm) The unrun ablation is one line.** Every retrieval-augmented model in the wiki makes a *single* retrieval pass per query. REMERGE says the multi-hop capability they lack can be bought by re-querying with query + reconstructed content until the retrieved set stops changing, with no change to the index and no write. The prediction is specific. Iterative re-query should help on queries whose answer needs an item with low similarity to the query and high similarity to a first-pass hit, and nowhere else. **Now run in a machine, in modified form** (Trivedi et al. 2023, [[wiki/entities/ircot.md]]). Re-querying a fixed BM25 index with no write beats a single read by 3.5–22.6 recall points at a matched 15-paragraph budget. In the qualitative error tables, the single read fixes the hop nearest the question and fails the later hops, as predicted. Two departures: what is recirculated is the reasoner's *derived sentence* naming the bridge entity, not the retrieved content; and the loop stops on a string match, not when the retrieved set stops changing. Gain is not stratified by query–item similarity, and the settling curve is still unreported.

**(brainstorm) `τ` is a read-time separation knob.** REMERGE keeps storage fully separated and moves the specificity/generalization trade-off to a single read-time inhibition level. Low `τ` gives better recognition, high `τ` gives co-activation and therefore inference. A machine store can expose the same knob as a retrieval-softmax temperature per query, with no change to what is written. The source names prefrontal control as the likely setter, and lowered inhibition in sleep as the generalized-replay setting, and leaves both open ([[wiki/gaps/g038.md]]).

---

## Limitations

| Limitation | Consequence |
|---|---|
| **Learning is not modelled.** Units are stipulated per premise, and "training" is a weight scale chosen per run, from an informal parameter search | Every "emergence" result is a one-parameter sweep. Nothing shows the codes can be *learned* with recurrence active, or with sparse distributed codes in place of localist ones (the source's own stated next step) |
| **`τ` is free and unexplained.** The TI fit uses 0.45, PAI and sleep use 0.2, amnesia uses 1. The size of the lag depends on it | The model's flexibility and its variability are the same parameter. Nothing in the model sets it |
| **Not every result is reproduced**: distant > close after sleep, patient E.P., the AE poor-group neural profile, the shortcut proportion | The first is the strongest evidence in the source for stored generalizations |
| **Cross-domain analogy is out of reach by construction.** With no shared input features between two domains, no trace of one is similar to any trace of the other | The source assigns isomorphic-structure transfer (family trees, Hinton et al. 1986) to slow cortical learning that builds shared hidden structure. This is the fast store's hard boundary for abstract reasoning ([[wiki/concepts/analogical-mapping.md]]) |
| **Navigation from novel start points** (water maze) is excluded | Shortcuts are recombined journeys only. Geometric map computation is left to another mechanism |
| **Value transfer is set aside** for TI | TI performance may be partly reward-gradient. Only PAI and AE rule that out by design. The rat TI data control one reward account only: equal `AB`/`CD` accuracy equalises error-driven losses on `B` and `D`. Value transfer from the paired item is untested (Dusek & Eichenbaum 1997, [[wiki/empirical-tensions.md]] T411) |
| **Nothing selects which traces enter the loop** in a large store. Toy stores have 4–16 conjunctive units | A first pass over a large store returns mostly surface matches ([[wiki/entities/macfac.md]], ~.12 structural vs ~.53 surface). Capacity of the loop is unstated ([[wiki/entities/rolls-treves-hippocampal-model.md]]) |
| **Settling cost is not priced** against the write-time alternative | 300 cycles per probe in a 4–16-unit store, with no scaling statement |

**The hippocampal/neocortical ledger the source draws.** Recurrent hippocampus: fast learning, flexible under changed structure, helps interleaving. But it depends on pre-built components, its generalization varies with inhibition, and its capacity is limited. Neocortex: learnable componential codes that capture relational abstractions, reliable generalization, large capacity. But it learns slowly and needs interleaving. The source's example is *bardrel*: a hippocampal trace generalizes to `BARDREL` only if the input is already coded as abstract letters, and that letter code comes from cortex.

---

## Comparison

| | **REMERGE** | [[wiki/entities/temporal-context-model.md]] | [[wiki/concepts/retrieval-mediated-learning.md]] | [[wiki/entities/tolman-eichenbaum-machine.md]] | GCM (Nosofsky 1984) |
|---|---|---|---|---|---|
| Stored code | Localist, separated episodes | Item–context associations whose overlap grows with chain distance | Integrated `ABC` composite | Learned structural code `g` + bound memories | Separate exemplars |
| When the `A–C` link exists | While a query settles | After training, in the code | After encoding the overlapping pair | After structure learning | Never |
| Recurrence | Big loop, to settling | Context reinstatement | Completion during encoding | Generative model | None |
| TI `B–D` | Yes | Argued via a value gradient, not simulated | Yes | Yes, first presentation | Chance |
| Circle closure, `B–E` | Chance | `B` preferred | Not stated | Not stated | Not stated |
| Free parameters | 3 | 2 | — | Trained | 5 + choice |

---

## Connections

- **[[wiki/concepts/complementary-learning-systems.md]]** — the amendment this model was built to license: the fast store generalizes after all without giving up pattern separation, so the original fast-specific/slow-general dichotomy softens on the *fast* side. The primary source keeps the dichotomy for stationary structure and cross-domain transfer.
- **[[wiki/concepts/retrieval-mediated-learning.md]]** — the direct rival for the same behaviour: that page pays for the unobserved `A–C` path at encoding by binding a reinstated element into a live episode, this one pays at retrieval. The PAI encoding-phase hippocampal effect that page counts as integration is fitted here as plain completion of the stronger `AB` trace ([[wiki/empirical-tensions.md]] T334).
- **[[wiki/concepts/pattern-separation-completion.md]]** — what the model is built to keep. Storage is fully separated and the trade-off is moved into a read-time temperature, so "separate or integrate" becomes a question about the retrieval loop. The source also rereads CA1 nodal codes as componential I/O for a separated CA3.
- **[[wiki/concepts/attractor-dynamics.md]]** — the settling process is relaxation over a store of separate exemplars, not over a learned energy landscape, so the answer to an inference query is a fixed point whose basin was never trained.
- **[[wiki/entities/temporal-context-model.md]]** — the encoding-based rival in formal form. The source classes it as cached (model-free-like) against REMERGE's search (model-based-like), and supplies the circle-closure probe on which the two predict opposite `B–E` choices.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the structural-code answer to the same test: transitive inference on first presentation from a learned generative model. The path is paid for by pretraining instead of settling, which brackets the cost space with this page.
- **[[wiki/concepts/offline-replay.md]]** — supplies the model's offline form: with noise and inhibition of return, the same loop replays never-run shortcuts (14% of sequences). Writing a settled state back as a new unit is the route by which the model stops being purely retrieval-based.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the same content-addressable store with the loop present but untrained for this purpose: read heads can chain, and nothing in the objective asks the chain to run to a fixed point.
- **[[wiki/entities/hopfield-network.md]]** — the minimal form of the settling half without the exemplar half: iterate to an attractor, but over a superposed weight matrix rather than over separately stored traces addressed by similarity.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a path query answered without ever estimating the path. Stored episodes are the edges, and settling does what Isomap's shortest-path step does, so a builder needs a settling rule rather than an edge estimator.
- **[[wiki/entities/macfac.md]]** — supplies the retrieval-stage failure this model has no defence against: a first-pass similarity over a large store returns surface matches at .53 against .12 for structural ones, so what enters the loop is mostly wrong before the loop starts.
- **[[wiki/entities/ircot.md]]** — the machine run of this page's one-line ablation. Iterative re-query of an unchanged index with no write beats a single read on four multi-hop sets. The recirculated quantity is a generated inference rather than the retrieved items, which makes query compression between reads, not settling, the candidate source of the gain.
- **[[wiki/concepts/schema-assimilation.md]]** — the rival, structure-based route to the same behaviour: that page passes its property (iii) by assimilating into an organized schema, while this model passes it with no schema at all, by recirculating retrievals until they settle.
- **[[wiki/concepts/relational-reinterpretation.md]]** — supplies the reward-history deflation this page sets aside for TI. The rat lesion control filed there shows that the lesioned animal keeps item value and still fails `B–D`, which makes it the ablated twin any settling account must be scored against ([[wiki/empirical-tensions.md]] T411).
- **[[wiki/entities/lateral-frontoparietal-network.md]]** — locates the query-time composer for transitive inference outside this model's store: with premises on screen, rostrolateral prefrontal cortex chains the two relations while hippocampal activation stays flat and only its coupling to the integrator rises, so the hippocampus is read rather than settled (Wendelken & Bunge 2010).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — supplies the lesion profile this model cannot produce. Human vmPFC damage leaves premise accuracy equal to controls' and drives interior transitive pairs below chance, while the source's uniform premise-strength sweep only reaches chance. The prefrontal suppression the model leaves to an unspecified setter of `τ` is the candidate missing variable (Koscik & Tranel 2012). With controls above chance, the paired-associate lesion profile (inference toward chance, 3AFC premises equal, a larger later `AB` decline) is reproducible from a weaker `AB` weight, but only if something outside the model explains why vmPFC loss weakens the first trace (Spalding et al. 2018).
- **[[wiki/entities/entorhinal-cortex.md]]** — the anatomical home of this model's feature ↔ conjunctive loop: the layer Vb → II/III projection is the recirculation path, and human 7 T data show the absent bridge item reinstated in the superficial layers on inference trials, in proportion to deep–superficial connectivity, which predicts inference (Koster et al. 2018).
- **[[wiki/entities/hippocampal-formation.md]]** — places this model on the circuit hub: its conjunctive layer is the dentate gyrus–CA3 stage, and the measured big loop re-enters exactly there and not at CA1/subiculum, so the model's two layers map onto the hub's write front end and its entorhinal return edge.
- **[[wiki/concepts/analogical-mapping.md]]** — marks this model's hard limit for abstract reasoning. Recurrent similarity cannot transfer between domains that share no input features, so structure-mapping across perceptually unrelated domains needs a cortically learned relational code before the fast store can help.
