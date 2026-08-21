# Activity Baseline — Defining a Zero Point for Activity Without a Control Condition

**Every "activation" in functional imaging — and every activation in an interpretability experiment — is a *difference* against a control state, so any claimed decrease can always be re-described as a hidden increase in the control. The escape is to find a quantity that is **invariant across the system at rest while the activity levels underneath it vary several-fold**, declare that invariant the zero, and read deviations in either direction. In cortex the candidate is the oxygen extraction fraction: blood flow and oxygen consumption differ ~4× between grey and white matter and ~40% between cortical regions, but their *ratio* is spatially near-uniform at rest, because supply has equilibrated to the demand of each region's own long-run modal activity. Two consequences that survive whether or not the physiology holds: a unit's **tonic rate carries no information about whether it is engaged**, and a region's baseline is the state it is ecologically normally in, not the state with no input.**

> **Provenance.** Raichle, MacLeod, Snyder, Powers, Gusnard & Shulman 2001, *A default mode of brain function*, PNAS 98(2):676–682, doi:10.1073/pnas.98.2.676 (`raw/raichle-2001-default-mode-brain-function.md`). The paper that named the default mode. Primary data: quantitative positron-emission tomography (cerebral blood flow, blood volume, oxygen extraction fraction, cerebral metabolic rate for oxygen) in two independent groups of 19 awake adults resting with eyes closed, on two different scanners, plus 11 adults measured for blood flow in eyes-closed rest *and* passive visual fixation (five paired measurements each). Regions of interest were taken verbatim from Shulman et al. 1997's meta-analysis of task-induced *decreases*, not re-selected. Small `n` by modern standards, whole-brain resolution 16–17 mm, and the two groups differ in global oxygen extraction fraction (0.40 vs 0.30) — read the *spatial* uniformity claim, not the absolute number.

---

## The problem the paper is actually solving

| Step | Statement |
|---|---|
| Observation | Task-induced *decreases* recur in the same regions across a wide range of tasks, while increases move with task demands |
| The objection that cannot be answered by contrasts | Any control state is "just another task state with its own areas of activation", so a decrease may be the offset of an unrecognised increase in the control |
| Why it matters | Without an agreed baseline, *no* regional activity level has a sign. "Deactivation" is a relation between two conditions, not a property of a region |
| The move | Define the baseline **physiologically** — from a quantity measured in one condition — rather than **comparatively**, from a subtraction |

This is the same defect [[wiki/concepts/human-baseline.md]] names on the evaluation side (a score is meaningless until the denominator's protocol is fixed) and [[wiki/concepts/function-to-structure-inference.md]] names on the inference side (a function label inherited from a contrast is a property of the contrast).

---

## The invariant, and why a *ratio* can be flat while its terms are not

`OEF = CMRO₂ / (CBF × [O₂]_arterial)` — oxygen used divided by oxygen delivered.

| Quantity, awake eyes-closed rest | Group I (n=19) | Group II (n=19) | Spatial behaviour |
|---|---|---|---|
| Oxygen extraction fraction (OEF) | 0.40 ± 0.09 | 0.30 ± 0.09 | **Near-uniform across the brain**; 95% confidence limits ±3% |
| Cerebral blood flow (CBF) | 46 ± 8 ml/(min·100 g) | 48 ± 10 | Varies ~4× grey vs white matter |
| Cerebral metabolic rate for oxygen (CMRO₂) | 2.94 ± 0.41 ml/(min·100 g) = 1.31 ± 0.18 µmol/(min·g) | 2.17 ± 0.41 = 0.97 ± 0.17 | Varies ~4× grey vs white matter |

The interpretation: uniformity of the ratio means **supply has equilibrated to each region's long-run modal demand**, whatever that demand's absolute size. Transient departures from the modal level break the equilibrium, and it is the *break* that functional MRI measures — flow rises far more than oxygen consumption, so OEF falls, oxygenated haemoglobin leaving the region rises, and that is the blood-oxygen-level-dependent signal. Deactivation is the mirror.

**The decision rule this buys:**

| Regional OEF vs hemisphere mean | Verdict |
|---|---|
| Below | **Activated** — above its own baseline |
| Not different | **At baseline** |
| Above | **Deactivated** — below its own baseline |

---

## The test, and the two dissociations that transfer

**Test.** Take the four regions that most reliably *decrease* under attention-demanding tasks, and ask whether they are covertly activated during eyes-closed rest. If they are, their OEF should be below the hemisphere mean.

| Region (Brodmann) | Group I OEF ratio (p) | Group II OEF ratio (p) | Group I CBF ratio | Group I CMRO₂ ratio |
|---|---|---|---|---|
| Medial 31/7 (posterior cingulate/precuneus) | 1.010 (0.62) | 1.035 (0.62) | **1.374** (<0.0001) | **1.397** (<0.0001) |
| Left 40 | 0.901 (0.07) | 0.903 (0.04) | **0.735** (<0.0001) | **0.695** (<0.0001) |
| Left 39/19 | 0.987 (0.66) | 0.997 (0.94) | **0.813** (0.0008) | **0.805** (0.0003) |
| Right 40 | 0.978 (0.26) | 0.994 (0.77) | 1.002 (0.96) | 0.998 (0.97) |

No region's OEF differs from the hemisphere mean after correction; regional OEF replicates across the two independent groups at `r = 0.89`. A whole-brain search for OEF deviations found **no decreases anywhere** — nowhere in the resting brain is activated by this definition.

**Dissociation 1 — tonic level is orthogonal to engagement state.** Posterior cingulate/precuneus runs ~37% above the global mean in blood flow and ~40% above in oxygen consumption *while sitting exactly at baseline*; left area 40 runs ~27% and ~30% *below* the global mean, also at baseline. Medial area 10 joins the first group, left area 9 the second. **A region's resting metabolic rate says nothing about whether it is currently doing extra work.**

**Dissociation 2 — the baseline is per-region and set by the ecologically normal condition.** The only deviations found were *increases* in OEF — i.e. deactivations — and they were bilateral extrastriate visual cortex (Brodmann 18/19, OEF ratios 1.145–1.217 across the two groups; plus area 11 in the right gyrus rectus at 1.491 in group I only, unreplicated). Blood flow in those areas rises when the eyes open. Read forwards: **eyes-closed rest is below baseline for visual cortex** — the region's zero is the eyes-open state, because that is what its supply has equilibrated to.

**The control-state check.** Eyes-closed rest vs passive fixation of a cross hair (n=11): no significant blood-flow change in any of the four regions above. So the recurring task-induced decreases are not manufactured by whichever passive control an experimenter picked — the two commonest controls give the same value for these regions, while differing for visual cortex.

---

## What the baseline is spent on, in the original statement

The paper's own function claim — the one later reviews call the **sentinel** hypothesis — is that the baseline budget buys continuous, unrequested information gathering plus continuous evaluation of what it returns:

| Component | Argument given | Grade |
|---|---|---|
| Posterior cingulate + precuneus = broad monitoring | These neurons respond to large, brightly textured stimuli even when task-irrelevant, and not to small attended spots; the region belongs to a dorsal-stream network representing the **visual periphery**; medial parietal damage produces Balint's syndrome (simultanagnosia — cannot perceive the field as a whole despite intact fields); recovery of external awareness from vegetative state is heralded by restored parietal/precuneal metabolism | Convergent but entirely indirect |
| Medial prefrontal cortex = salience/valence evaluation | Ventral medial prefrontal cortex receives wide-band sensory input from body and environment and is heavily interconnected with amygdala, ventral striatum, hypothalamus, periaqueductal grey and brainstem autonomic nuclei; orbital/medial prefrontal neurons code stimuli by reward and non-reward association | Anatomy plus monkey electrophysiology, no human test |
| Why it must be default rather than called | "Detection of predators… should not, in the first instance, require the intentional allocation of attentional resources" — William James's *sentinels* that "cry 'who goes there' and call the fovea to the spot" | Evolutionary argument |

**The baseline has a price, and it is paid in the same place.** Posterior cingulate and precuneus are selectively vulnerable to carbon-monoxide poisoning, diffuse ischaemia and Alzheimer's disease. The standard explanation is vascular (arterial watershed territory); the paper's added suggestion is that the **exceptionally high tonic metabolic rate is itself a risk factor**. A component that runs continuously at 40% above the mean is the first to fail when supply drops.

---

## Where the claim does not hold

The absolute-baseline argument is weaker than its use in the later literature suggests, and the primary tables above show it:

| Objection | Evidence, from this paper's own data |
|---|---|
| OEF is not actually constant | Left area 40 is at 0.90 of the hemisphere mean in **both** groups (p = 0.07, 0.04) — a replicated ~10% decrease that survives only because the multiple-comparison correction kills it. Regional OEF correlating at `r = 0.89` across independent groups means the *pattern* of regional variation is real and reproducible; a genuinely constant OEF would correlate at zero |
| The invariant is not invariant across instruments | Global OEF is 0.40 in group I and 0.30 in group II — same protocol, different scanners. The zero point is defined only *within* a brain-and-session, so no absolute cross-subject or cross-instrument comparison is licensed |
| Circularity risk | The regions tested were chosen because they decrease under task; a null OEF result in exactly those regions is the predicted outcome under both hypotheses if the effect size is small relative to ±3% confidence limits |

[[wiki/entities/default-mode-network.md]] carries the anchor review's version of this critique (Buckner et al. 2008); the honest statement is **modulated but weakly**, not constant. What survives intact is the *strategy* — define the zero from an equilibrium invariant rather than a contrast — and the two dissociations, neither of which depends on the invariant being exact.

---

## Relevance to a reasoning model

- **(brainstorm) The transferable object is an equilibrium invariant, not oxygen.** The recipe: find a ratio `demand/supply` that a homeostatic process pins to a common value across units *regardless of each unit's operating point*, and read departures from it as engagement. A machine analogue would be a per-unit resource that adapts on a slow timescale to that unit's own long-run activity — a running normaliser with a very long time constant — where the *residual* against the normaliser, not the raw activation, is the engagement signal. Every activation-based interpretability method in the wiki ([[wiki/concepts/representation-probing.md]], [[wiki/concepts/linear-representation-hypothesis.md]]) reads raw magnitudes or contrasts against a chosen control prompt, and inherits exactly the objection this paper starts from: the control prompt is another task.
- **High-rate units are not the working units.** Dissociation 1 is a direct warning against the wiki's habit of locating function by activation magnitude. A 40%-above-mean tonic rate and a 30%-below-mean tonic rate were both *at baseline*; nothing about the level predicted the state. Any method that ranks units or heads by mean activation is measuring the equilibrium, not the computation.
- **Idle is a *state*, and it is expensive.** The resting brain is not a system waiting for input at low cost — it spends ~20% of the body's oxygen on 2% of its mass, and the regions with the highest tonic spend are the ones that *decrease* under task. An architecture with an internal mode ([[wiki/architectural-gaps.md]] `G90`) should expect its idle policy to be a major, not marginal, fraction of total cost, and to have a failure mode located precisely at its most expensive component.
- **Define each module's zero by its normal operating condition, not by null input.** Visual cortex is *below* baseline with the eyes shut. The equivalent error in a machine system is measuring a module's reference state with an empty or zeroed input, when the distribution it has equilibrated to is the ordinary one. The correct null is "typical input", and it differs per module.
- **The sentinel is a resource-allocation argument, and it names a cost the wiki never pays.** Broad monitoring must run *unrequested*, because a call implies a caller that already noticed. Every attention mechanism in the wiki ([[wiki/concepts/priority-map.md]], [[wiki/concepts/attention.md]]) is called by a task; none has a continuously running, low-resolution, wide-field channel whose only job is to interrupt. That channel is what makes an internal mode interruptible by something the current task does not care about.

---

## Open problems

| Problem | Why it is open |
|---|---|
| **The invariant is only approximately invariant** | A replicated ~10% OEF decrease in one region, and `r = 0.89` reproducibility of the regional pattern, both say the zero point is regionally structured; nobody has quantified how much of the "baseline" is really a slowly varying field |
| **No zero across sessions, subjects or instruments** | Global OEF differed by a third between two groups on two scanners. Everything here is a within-brain relative measure, which is what an absolute baseline was supposed to escape |
| **"Modal level of neural activity" is never operationalised** | The equilibrium is asserted between blood flow and the demand of a long-run modal activity level, but that level is not measured, and no timescale is given for the equilibration — so the theory has no prediction for how fast a baseline moves after a sustained change in use |
| **The sentinel function is untested by this design** | Every argument for broad monitoring is anatomical, lesion-based or evolutionary; nothing here manipulates monitoring breadth and measures the baseline. Non-identification against the internal-mentation account starts here and is still open |
| **The machine analogue has no instance** | No architecture in the wiki has a per-unit slow resource normaliser, or reports engagement as a residual against one |

---

## Connections

- **[[wiki/entities/default-mode-network.md]]** — the network this baseline argument was invented to license: the paper's contribution is not the map (inherited from Shulman's meta-analysis) but the demonstration that the map's regions decrease from a *true* zero rather than returning from an unnoticed activation.
- **[[wiki/concepts/human-baseline.md]]** — the same defect one level up: there a benchmark score has no meaning until the human denominator's protocol is fixed, here a regional activation has no sign until the control state's status is fixed, and both are solved by specifying the reference rather than by better measurement.
- **[[wiki/concepts/function-to-structure-inference.md]]** — a function label derived from a contrast is a property of the contrast; this page supplies the physiological attempt to escape that, and the extent to which it fails.
- **[[wiki/concepts/default-self-model.md]]** — the competing account of what the medial prefrontal share of this baseline metabolism is spent on: self-competence modelling rather than salience monitoring, from the companion paper in the same issue.
- **[[wiki/concepts/priority-map.md]]** — the sentinel claim is a priority map that is never called: broad, low-resolution, task-independent monitoring whose output is an interrupt, against that page's template-driven map that exists only while a search is running.
- **[[wiki/concepts/dynamic-repertoire.md]]** — the same resting state described by its dynamics rather than its energetics; a repertoire is what the baseline metabolism is *buying*, and neither page's measure constrains the other.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — the mechanism class that could hold a ratio fixed while absolute rates vary: node-level homeostasis pinning a firing rate is the same shape of argument as supply equilibrating to demand, one level down.
- **[[wiki/concepts/representation-probing.md]]** — every probe reads activations against a chosen control condition, which is precisely the objection this page starts from; the fix implied here is a residual against a slowly adapted per-unit reference, which no probing method uses.

