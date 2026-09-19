# Incremental Grouping — the Parse as a Spreading Activity Tag, Priced in Distance Travelled

**Which image elements belong to one object is settled not by a detector, a slot or a read-out but by *labelling*: extra activity is injected at a cued location and propagates, step by step, through the elements that group with it, stopped by whatever the local circuit treats as a boundary. The tag is a transient modulation of the same cells that carry the feedforward representation — the parse is written onto the base representation rather than beside it — and its distinguishing signature is a **cost curve**: grouping time is linear in the distance travelled through the object, not in the number of objects, the number of features, or the depth of the network.**

> **Provenance.** Mollard, Bohte & Roelfsema 2026, *How the visual brain can learn to parse images using a multiscale, incremental grouping process*, PLoS Comput. Biol. 22(4):e1014193 (`raw/mollard-2026-multiscale-incremental-grouping.md`) — the model page is [[wiki/entities/multiscale-tracing-network.md]]. The psychophysics and physiology it rests on (Jolicoeur et al. 1986; Roelfsema et al. 1998; Pooresmaeili et al. 2014; Jeurissen et al. 2016; Adeli et al.) are cited second-hand through it; Roelfsema 2006's base- vs incremental-grouping review is **not** in the wiki (paywalled, see `priority-ingest.md`), so the base/incremental split below is carried at one remove.

---

## The two-process split

| | **Base grouping** | **Incremental grouping** |
|---|---|---|
| Timing | The feedforward sweep | After a delay that grows with distance from the cue |
| Parallelism | All locations at once | One expanding front |
| What it delivers | Local grouping cues — connectedness, collinearity, homogeneity — made explicit *everywhere* | Which elements are on the **same** object as a designated one |
| Cost | One pass, image-size-independent | Linear in traversal distance |
| Cortical signature | Layers 4 and 6: cells that represent the stimulus veridically and **do not** participate in the tag | Layers 2, 3 and 5: cells whose firing rate is enhanced when their receptive field falls on the target |

The split is the paper's central architectural commitment and it is implemented as two *segregated populations*, not two phases of one: the feedforward population is frozen and gates the recurrent one, so activity can only spread where the feedforward units declare the local content unambiguous. **A boundary is therefore not a feature — it is the absence of a permission.**

---

## The mechanism, and why the inhibitory detour is load-bearing

Three cell classes — pyramidal cells plus two inhibitory families, VIP (Vasoactive Intestinal Peptide-expressing) and SOM (Somatostatin-expressing) interneurons. Propagation by disinhibition, one step:

```
pyramidal(l, x)  ──horizontal / feedback──►  VIP(l, x±1)  ──┤  SOM(l, x±1)  ──┤  pyramidal(l, x±1)
                                                    (inhibits)        (inhibits)
```

`SOM` is tonically active and suppresses pyramidal cells; `VIP` recruited by an already-tagged neighbour silences `SOM`, releasing the neighbour's pyramidal cell, which recruits the next `VIP`. Formally the released pyramidal activity is bounded above by its own feedforward drive — disinhibition can only remove a subtraction, never add gain — which is what makes the recurrent network reach a fixed point.

| Recurrent scheme | What happens along a long curve | Consequence |
|---|---|---|
| Excitatory→excitatory, `ReLU` | Unbounded; runaway | No stable state; the learning rule (which requires one) cannot be applied |
| Excitatory→excitatory, squashing nonlinearity | Stable, but the target–distractor activity difference **attenuates progressively** with distance | Trained on short curves, fails on long ones — the tag fades before it arrives |
| **Disinhibitory (VIP⊣SOM⊣pyramidal)** | Activity difference stays constant at every distance | Generalises from 7-pixel training curves to 30-pixel test curves at 100% |

**This is the wiki's cleanest case of a stability property being purchased by a *circuit motif* rather than by a loss term.** The two inhibitory classes are not decoration on an excitatory model: replace the detour with direct excitation and length generalisation is lost for a stated reason (attenuation), not by degree.

---

## Multiscale, and the scale-independence Ullman could not explain

Four scales run in parallel, each with larger receptive fields and coarser sampling. A feedforward unit at scale `s` activates only if everything in its receptive field unambiguously belongs to one object — collinear *and* connected for curves, boundary-free for regions. So:

- Wide clearance between target and distractor ⇒ large receptive fields stay unambiguous ⇒ propagation at a high layer ⇒ **few steps per degree of visual angle**.
- A bottleneck, or high curvature ⇒ only small receptive fields are unambiguous ⇒ propagation drops to a low layer ⇒ **many steps per degree**.

The emergent policy is the "growth-cone" heuristic (Roelfsema; Jeurissen et al.): fastest progress in the area whose receptive fields on the target *almost* touch the distractor. Two consequences:

| Prediction | Status |
|---|---|
| Narrowing the gap delays the response enhancement **only for receptive fields beyond the bottleneck**, not before it | Reproduced by the model; matches monkey V1 (Pooresmaeili et al. 2014) |
| Reaction time is nearly **invariant to viewing distance** — approaching the display lengthens the curve and widens the inter-curve gap, and grouping moves up a scale, cancelling | The resolution of [[wiki/concepts/visual-routines.md]]'s single unresolved failure: bounded activation predicts time rising with figure size, human inside/outside judgement is close to scale-independent, and Ullman 1984 left this open. **The missing term was a scale hierarchy with a clearance-driven selector.** |
| Number of scales is not free: 4 scales fit human reaction times better than 3 (`p = 0.03`) and than 2 (`p < 10⁻³`) | Measured; the unbounded-scale heuristic model still fits slightly better (`R² 0.63` vs `0.55`, ceiling `0.67`), so 4 is a floor |

---

## Evidence and instantiations

| Instantiation | Grouping criterion | Learned? | Cost curve reported |
|---|---|---|---|
| Growth-cone heuristic (Jeurissen et al. 2016) | Declared; unbounded scales | No | Yes — `R² = 0.63` on scrambled-shape human RTs |
| Marić & Domijan | Hard-coded multiscale Gabors, hand-set weights | No | Qualitative only; no 2-D generalisation |
| hGRU horizontal-interaction unit | Learned, end-to-end supervised | Yes | Indirect — an uncertainty measure that must be *transformed* into an RT; `R² = 0.21` / `0.07` |
| **[[wiki/entities/multiscale-tracing-network.md]]** | Feedforward criterion declared and pretrained; **propagation and scale policy learned from reward alone** | Partly | Yes, natively — timesteps to 90% enhancement; `R² = 0.55` (scrambled shapes) / `0.15` (COCO masks, ceiling `0.24`) |
| Monkey V1 / human V1 fMRI | — | — | Yes — enhancement latency grows with distance along the curve |

**The "learned" column is the one to read carefully, because the wiki's want-list overstated it.** What is learned by trial and error is the *routine* — spread, gating, stopping, and which scale to use. What decides *what groups with what* is a supervised label on the feedforward units ("all pixels in this receptive field are collinear and connected"), trained on 50,000 stimuli and then frozen. So the criterion is still declared by the designer; it has merely been moved from the recurrent dynamics into a pretraining objective. The authors state the co-development problem directly: joint end-to-end training worked in their earlier single-scale model and **did not reliably elicit grouping across all scales here**.

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| Feedforward gate | The **edge set**: which adjacent locations may be traversed, computed once, everywhere, in parallel |
| Spreading tag | A **reachability query** answered by flooding from a seed, not by matching a template |
| Scale | The **granularity of the traversal step** — chosen per region by local clearance, so the graph is coarsened where it is safe to coarsen |
| Timesteps to arrival | The query's **price**, in the same currency as a human reaction time |
| The object | The connected component the flood reached — never named, never counted, never stored |

**(brainstorm)** This gives the wiki its first parse whose *output is an addressable side effect on the input representation*. Ullman's incremental representation was described and never built; the recurrent population here is one, with two properties the description did not fix: it is written in the same units as the base representation (so the next operation reads it for free) and it is **not retained** — it is a fixed point of a dynamical system that decays when the cue changes. A downstream reasoner can ask "is this on the same object as that?" and cannot ask "how many objects are there?" without re-running the flood once per seed.

---

## Open problems

- **The grouping criterion is still declared.** Collinearity-and-connectedness and boundary-freeness are supervision targets, not discoveries. Similarity of motion, colour and luminance — the rest of the Gestalt list — are not implemented at all, and the authors name their simultaneous emergence as the open problem (`T151`, `G75`).
- **No object variable exists anywhere.** The tag answers a binary same-object query about two cued points. Counting, comparing two objects, or binding an object to a role each require the flood to be re-run, and nothing in the architecture holds the result (`G39`, [[wiki/concepts/visual-indices.md]]).
- **Natural images are out of scope by construction.** Objects are presented as filled homogeneous masks on an empty background. The authors concede that parsing real scenes depends on recognition — humans parse upright images faster than inverted ones — and that feedback from recognition areas is the untried extension.
- **Nothing connects the cost curve to a reasoning benchmark.** The model prices a parse in timesteps and is fit to human RT; no ARC-family result in the wiki reports a per-task operation count, so the comparison that would make this a shared currency has never been made (`T215`, `G17`).
- **The stopping condition is a fixed point, not a decision.** Convergence is declared after activity is unchanged between two timesteps or after 30 steps, whichever comes first. A reader that must act on "the flood has finished" has no signal that it has.

---

## Connections

- **[[wiki/entities/multiscale-tracing-network.md]]** — the implementation this page abstracts: four scales, a frozen feedforward gate, a VIP/SOM disinhibitory recurrent group trained by reward alone, with the numbers, the ablations and the transfer result.
- **[[wiki/concepts/visual-routines.md]]** — the same mechanism specified 42 years earlier and left unbuilt: bounded activation and boundary tracing are exactly these two tasks, the incremental representation is exactly this tag, and this page supplies the missing term (a clearance-selected scale hierarchy) that resolves the one place Ullman's own preferred algorithm was contradicted by the scale-independence of human inside/outside judgements.
- **[[wiki/concepts/visual-indices.md]]** — the complementary half and the sharper contrast: an index *individuates* without describing and persists across change, where a tag *labels* without individuating and dies with the cue — so a relation over `n` arguments needs the indices, and deciding whether two indexed things are one thing needs the flood.
- **[[wiki/entities/early-visual-system.md]]** — the sheet this is written on, and the reason it can be: the same cells carry the veridical feedforward response and the grouping tag as a later modulation, so the parse costs no separate store and is legible to whatever reads the base representation.
- **[[wiki/concepts/attention.md]]** — object-based attention given a mechanism and a price: the "spread of attention over an object" is this flood, selection is the injection of the seed, and the serial order is forced by the propagation rather than by a capacity limit.
- **[[wiki/concepts/subgraph-matching.md]]** — the perceptual instance of a connectivity query with the cost in the other currency: linear in path length, independent of the number of distractor paths, and with the traversal step size itself adapted to local clutter.
- **[[wiki/concepts/adaptive-computation-time.md]]** — a ponder loop whose step count is set by the *stimulus geometry* rather than by a learned halting unit, and whose step count is validated against human reaction times rather than against accuracy — the one case in the wiki where a variable-depth computation has an external cost curve to match.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — a second job for the same cell types: there inhibition sharpens a tuning curve and vetoes a column, here a VIP⊣SOM detour is the *propagation mechanism itself*, and the bound it imposes (released activity cannot exceed feedforward drive) is what makes the recurrent network converge.
- **[[wiki/concepts/latent-graph-discovery.md]]** — grouping recast as reachability: the feedforward gate is the edge set computed in parallel, the flood is a seeded traversal, and an "object" is the connected component the traversal reached — so the vertex set is never enumerated and the parse is answered per query.
- **[[wiki/entities/spelkenet.md]]** — the two extremes of the same question: objectness as a *statistic over sampled counterfactual rollouts* in a 7B model, versus objectness as a *fixed point of a small recurrent circuit* seeded at one point — one returns a whole partition and costs `R × T` rollouts, the other returns one component and costs a number of steps that predicts a human reaction time.
- **[[wiki/entities/dorsal-visual-stream.md]]** — where the tag would have to be read: same-object judgements, tracing and spatial relations are the parieto-prefrontal pathway's traffic, and this page supplies the early-visual half of a loop whose other half that anatomy describes and this model does not include.
