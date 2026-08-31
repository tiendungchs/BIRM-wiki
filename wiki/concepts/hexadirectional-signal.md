# Hexadirectional Signal

**The instrument almost every "grid code outside the rat" claim in this wiki rests on: an aggregate BOLD signal modulated by *movement direction* `θ` with six-fold rotational symmetry about a per-subject grid orientation `φ`, fitted as `cos(6[θ(t) − φ])`, and gated by movement speed.**

It measures direction and speed. It cannot measure location — grid modules tile the environment with offset phases, so population activity is by construction near-flat in position (Doeller et al. 2010). Every claim in the wiki of the form "region R carries a grid-like code over space X" is therefore a claim about the *directional* statistics of trajectories through X, never about where in X the subject is.

Founding source: Doeller, Barry & Burgess 2010 (Nature), which built the instrument, validated its three linking assumptions with rat single-unit recording in the same paper, and applied it to 42 humans in a virtual-reality foraging arena.

---

## Why an aggregate signal exists at all — three measured links

Averaging thousands of grid cells over a voxel destroys the code unless the population is coherent in some quantity that varies with a measurable behavioural variable. Three facts make direction that quantity; the second and third were measured in this paper:

| # | Link | Evidence |
|---|---|---|
| 1 | **Grid orientations are common across cells.** Neighbouring and distant grids share angular orientation relative to the environment and rotate together when distal cues rotate | Hafting et al. 2005; Barry et al. 2007 |
| 2 | **Conjunctive grid cells' preferred firing directions are aligned to their own grid axes.** So aligned-vs-misaligned running produces systematically different population dynamics | New: 18 directional grid cells / 8 rats; angular difference to nearest grid axis non-uniform (Rayleigh `P` = 0.007) and clustered at zero (mean **3.15°**, Monte Carlo `P` < 0.001) |
| 3 | **Speed sharpens the code.** Grid firing rate, inter-burst frequency and field-sampling rate all rise with running speed — and the spatial organisation itself is stronger when fast | New: gridness for 113 grid cells, fast vs slow median split, paired `t`-test `P` = 2.2×10⁻¹¹ |

Consequence: link 1 + link 2 predict a six-fold directional modulation; link 3 predicts it is **stronger for fast runs**, which converts a nuisance regressor into a designed-in specificity test. The chain is the reason the instrument is not merely a sinusoid fitted to noise.

---

## The two readouts

| Readout | Procedure | Result (n = 42, VR arena) |
|---|---|---|
| **Activation** (split-half) | Quadrature filter on **half** the data, within an anatomical entorhinal ROI, gives each voxel's candidate orientation; `φ` = amplitude-weighted population vector; fit `cos(6[θ(t) − φ])` **whole-brain** on the other half | Right entorhinal cortex, fast runs only. Peak MNI 30/3/−30, `z` = 3.59. Orientations significantly clustered across ROI voxels in **34/42** subjects |
| **Adaptation** (no ROI needed) | Regressor `log(time since last run at 60° from the current direction)`, run directly whole-brain, exclusively masked by basic 360° directional adaptation | Right entorhinal/subiculum `z` = 3.28; medial prefrontal 4.96; lateral temporal 4.99 / 3.48; posterior parietal 3.24; medial parietal. Fast runs only |

The two readouts are independent in construction — one needs a prior ROI and a split, the other needs neither — and they converge on right entorhinal cortex. Regions found by adaptation were then re-tested against the entorhinal-defined sinusoidal regressor and passed in medial prefrontal (`P` = 0.008), medial parietal (0.002) and lateral temporal (0.019 / 0.0005) cortex, but **not** posterior parietal (0.058).

---

## The control structure — what makes it a detector

| Control | Result | What it rules out |
|---|---|---|
| 4-, 5-, 7-, 8-fold symmetry | All null | A generic periodic or directional-tuning artefact |
| 45° and 90° shifted adaptation | Null | The same, in the adaptation readout |
| Medium and slow runs | Null | An effect independent of the link-3 prediction (i.e. an unpredicted one) |
| `φ` across participants | Randomly distributed | The environment's visual features setting the axis |
| Split-half | `φ` estimated and tested on disjoint data | Fitting the sinusoid to the data it is scored on |
| Control ROIs (posterior right hippocampus; the visual-cortex adaptation peak) | Null | A whole-brain or vascular effect |
| Basic 360° directional adaptation | Present separately (visual, parahippocampal, retrosplenial), and the 60° maps are masked by it | View/scene adaptation masquerading as a grid code |

**The design principle worth importing.** Derive the aggregate-level prediction from cell-level facts *first*, commit to a modulator that must gate it (speed), then test at a periodicity that has neighbours which must come out null. A pattern score with no adjacent-null requirement and no predicted gate is a much weaker instrument — this is the standard against which the wiki's other detectors (grid score, linear probe) look loose ([[wiki/concepts/representation-probing.md]]).

---

## What the instrument does not license — stated by its own authors

- **BOLD is not spiking.** Hexadirectional modulation is compatible with a coherent population of *head-direction* cells or of conjunctive directional cells, not only of grid cells. The paper's own defence is link 2 — it shows conjunctive cells *are* six-fold organised — which makes the alternatives less distinct rather than excluded.
- **No position.** See above; the instrument is blind to the part of the grid code that carries location.
- **Direction is confounded with view** in a first-person VR paradigm (viewing direction = running direction). Handled here by the exclusive mask, not by design.
- **The validation is in physical space with real self-motion.** Links 2 and 3 are rat entorhinal measurements over a foraging box. No conjunctive-alignment result and no speed-gating result exists for a conceptual space, where "direction" is an angle in a designed feature plane and "speed" has no obvious referent — see [[wiki/empirical-tensions.md]] T37, which this sharpens: the objection to the abstract-grid literature is not that the detector is unvalidated but that **its validation was earned in a domain those studies do not occupy**.

---

## The two findings the instrument produced, beyond existence

**A behavioural link, and it is an alignment statistic.** The **coherence** of candidate grid orientations across a subject's right entorhinal cortex (mean resultant length of the orientation vectors) correlates with spatial memory — Spearman `ρ` = 0.32, `P` = 0.039, memory scored as inverse mean object-replacement error (7.4–61.7 virtual metres). Not amplitude, not gridness: *how much the voxels agree on one axis*. **(brainstorm)** This is the wiki's earliest instance of the pattern later made explicit by Park et al. 2021 (value readout stronger for grid-aligned vectors) and Qu et al. 2026 (grid strength mediates inference gain): what predicts behaviour is the **registration** of the code, not its presence. Model-side prediction — in a network with a structural state `g`, a consensus statistic over per-unit or per-module preferred axes should predict downstream task accuracy better than any single-unit periodicity score does. Nothing in the wiki measures this.

**The network, six years before the abstract-grid literature.** Entorhinal/subicular + posterior parietal + medial parietal + lateral temporal + medial prefrontal, all six-fold and all aligned to the entorhinal orientation. That is the first multi-region aligned hexadirectional result, and it is in **physical** space — so the shared-orientation network Constantinescu et al. 2016 and Park et al. 2021 report over concept and social spaces is a re-finding of a spatial-task network, not a new one. It also overlaps the autobiographical-memory / default-mode network, which is the paper's own closing speculation about why a periodic code sits there at all. Bears directly on G43 ([[wiki/concepts/distributed-reference-frames.md]]): the count of *independently oriented* frames observed in one task is still one, and it was already one in 2010.

---

## Open problems

- **No conceptual-space validation of links 2 and 3.** The cheapest partial fix is not electrophysiology: a conceptual task with a manipulable "speed" (rate of traversal through the feature plane) should reproduce the speed gating if the same population mechanism is running, and its absence would be informative.
- **False-negative rate unknown.** A mismatch between grid scale and enclosure size hides the pattern; nothing bounds how often the instrument returns null on a real code (Chen et al. 2022).
- **No model-side counterpart.** Trained networks are scored with per-unit grid scores, not with a split-half aggregate detector that has adjacent-periodicity nulls and a predicted gate. `(brainstorm)` Porting this instrument to a model is nearly free — regress mean population activity on `cos(6[θ − φ])` where `θ` is the direction of the state update and `φ` is fitted on half the trajectories — and it would make T38's "grids emerge from path integration" claims measurable in the *same* currency as the biological ones instead of a different one.
- **Posterior parietal fails the convergence test** (`P` = 0.058) while showing the adaptation effect, and nobody has said why.

---

## Connections

- **[[wiki/concepts/cognitive-map.md]]** — supplies the method behind that page's Element-1 encoding-model row, and the reason the row reads "a periodic code inferred from an aggregate signal": the instrument is blind to position, so the map evidence it contributes is entirely directional.
- **[[wiki/concepts/nonspatial-maps.md]]** — the instrument every fMRI row on that page is made of; its validation chain is what those rows borrow, and the fact that the chain was measured only in physical space is the precise form of that page's blanket BOLD caveat.
- **[[wiki/concepts/abstract-structural-codes.md]]** — decides how much weight the "grid codes are general, not spatial" case can carry: the six-fold-only specificity structure is why those results are not dismissible, and the domain of the validation is why they are not conclusive.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the earliest evidence for that page's replication claim *and* the earliest evidence against its independence claim: five regions, six-fold, all aligned to one entorhinal orientation, in a plain navigation task (G43).
- **[[wiki/concepts/path-integration.md]]** — the mechanism the signal is a shadow of: speed gating is the instrument's handle on the integrator's velocity input, which is why "fast runs only" is a positive result rather than a restriction.
- **[[wiki/concepts/representation-probing.md]]** — the machine-side twin: both fit a weak decoder to a hypothesised structure and must then argue the structure is used rather than merely findable; this page supplies the stricter template (predicted gate + adjacent nulls + split-half) that a linear probe usually lacks.
- **[[wiki/concepts/objective-identifiability.md]]** — the pairing that makes T37 and T38 one problem: this page is the detector applied to brains, that page is the same periodicity score applied to networks where it turns out to be installed by the readout target.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the model whose `g` this instrument would be applied to: TEM's grid-like units are scored per unit, and porting the split-half hexadirectional test to its population state is the open item above.
