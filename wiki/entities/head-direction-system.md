# Head-Direction System — An Integrator Whose Velocity Input Is Not a Sensor Reading

**The chain of brainstem, hypothalamic, thalamic and parahippocampal populations that holds one allocentric heading variable as a single activity bump on a ring: vestibular nuclei → nucleus prepositus / supragenual nucleus → dorsal tegmental nucleus ↔ lateral mammillary nucleus → anterodorsal thalamus → postsubiculum → retrosplenial and entorhinal cortex. The signal has two parts: a direction integrated from self-motion, and an anchor that fixes its reference frame. The textbook input is vestibular angular velocity, but the first central vestibular stage cancels ~70% of the signal whenever the movement is self-generated. So whatever drives the ring during active behaviour is not a plain sensor reading.**

> **Provenance.** Cullen & Taube 2017, *Our sense of direction: progress, controversies and challenges*, Nat. Neurosci. 20(11) (`raw/cullen-2017-our-sense-of-direction-progress-controversies-challenges.md`). This is a Perspective, not new data. It joins two literatures that rarely cite each other: monkey vestibular-nucleus single units recorded during active versus passive motion (Cullen), and rat head-direction lesion and recording studies (Taube). Box 1 and Figures 1–3 are images or missing from the clip. Taube is an author on most of the rat lesion results the wiki already cites on [[wiki/entities/mammillary-bodies.md]] and [[wiki/entities/anterior-thalamic-nuclei.md]] (Stackman & Taube; Golob & Taube; Goodridge & Taube), so this source does not check those pages independently.

Why this earns a page. "Head direction" appears on ~45 wiki pages. The circuit is covered node by node: the fly ring ([[wiki/entities/fly-central-complex.md]]), the mammillary generator ([[wiki/entities/mammillary-bodies.md]]), the thalamic manifold ([[wiki/entities/anterior-thalamic-nuclei.md]]) and the cortical stabiliser ([[wiki/entities/retrosplenial-cortex.md]]). No page covers the system end to end, and none asks what rides its input wire. This source does both. The second question is `T408`.

---

## The chain

| Stage | Cells | Role | Key evidence |
|---|---|---|---|
| Vestibular labyrinth | Semicircular canals: 3-D rotational velocity. Otoliths: 3-D linear acceleration, gravity included | Sensor | Bilateral labyrinth lesions abolish anterodorsal heading. Canal occlusion, canal inactivation and horizontal-canal-deficient mice all abolish heading in anterodorsal thalamus or postsubiculum |
| Vestibular nuclei | `VO` (vestibular-only), `VOR` (vestibulo-ocular reflex: position-vestibular-pause `PVP` and floccular-target `FTN` neurons) | First central stage, multimodal: head, body and gaze motor commands, neck proprioception and visual input converge here | See the conundrum below |
| Nucleus prepositus (`NPH`), supragenual nucleus (`SGN`) | Angular-head-velocity (`AHV`) cells. In the monkey, most `NPH` cells respond only to eye movement; ~20% respond to eye and vestibular input | Relay to the attractor; `NPH` is also the oculomotor integrator | Lesions here leave the heading signal **drifting** rather than abolished (lesion logic below) |
| Dorsal tegmental nucleus (`DTN`) ↔ lateral mammillary nucleus (`LMN`) | `AHV`, heading, head pitch | **Hypothesised ring-attractor site**, because the two nuclei are reciprocally connected. The source cites a dissent (Peyrache et al.) without stating it | [[wiki/entities/mammillary-bodies.md]] |
| Anterodorsal thalamus (`AD`) | ~50% "classic" heading cells in rodent, high signal-to-noise | Rostral relay; one-variable population | [[wiki/entities/anterior-thalamic-nuclei.md]] |
| Postsubiculum (~25% heading cells), parasubiculum, retrosplenial, entorhinal and medial precentral cortex, striatum | Heading cells in every one of them. Peak rates range from a few to >100 spikes/s and tuning widths vary, with no known functional role for either | Consumers | — |
| Landmark entry | Visual cortex → dorsal presubiculum (less → retrosplenial) → **top-down to `LMN`** | Anchoring | The visual correction enters at the cortical end and descends to the attractor |

Heading cells respond to landmarks and to the gravity axis, **not** to the geomagnetic field.

---

## Two components, and the lesion logic that locates the attractor

The source splits the signal into **(i) the directional signal**, which in theory integrates self-motion, and **(ii) its anchoring to a source**, which fixes the reference frame. The two can be lesioned separately, and that is how the attractor is located:

| Lesion site relative to the attractor | Predicted downstream signal |
|---|---|
| Inside the attractor, or downstream of it | Directional firing disrupted or lost |
| Upstream (afferent) | Recurrent connections intact, but external input can no longer drive or reset the bump. The bump **drifts around the ring**: the network is "untethered" |

`NPH` and `SGN` lesions give the untethered pattern. So the attractor sits downstream of them, consistent with `DTN` ↔ `LMN`.

**The same lesion logic run on the rest of the chain** (Jankowski et al. 2013, review; Taube-lab and Clark & Taube results):

| Lesion | Effect | Reading |
|---|---|---|
| `DTN` or `LMN` (bilateral) | `AD` heading abolished | Generator below `AD` |
| `AD` | Heading abolished in postsubiculum, parasubiculum and superficial medial entorhinal cortex | Ascending dependence |
| Postsubiculum | Subcortical heading intact | No descending dependence for the *direction* |
| Postsubiculum or retrosplenial cortex | `AD` cells lose **landmark control** of their tuning | The *anchor* is cortical and descends |
| Medial entorhinal cortex | `AD` tuning only mildly affected; no clear loss of landmark processing or angular path integration | Top of the hierarchy, a consumer |
| Lateral dorsal thalamus | Postsubicular heading barely affected | `AD`, not lateral dorsal thalamus, feeds the postsubiculum |
| Vestibular hair cells (neurotoxic) | `AD` directional tuning lost for ≥3 months. A new class of **non-directional bursting cells** appears. Vision, touch and smell do not compensate | The velocity source is not substitutable |
| Otoconia-deficient *tilted* mice | Directional cells present but **unstable across sessions**: tuning holds within one session and is lost between sessions | Otolith (gravity) input is needed for the anchor to persist across sessions, not for the direction itself |
| `AD` (effect on hippocampus) | Place fields survive but are degraded and **more directional** (Calton 2003) | The store keeps its map but loses part of its heading-invariance |

The table splits the two components by lesion site: direction ascends from the brainstem, anchor descends from cortex.

**(brainstorm) An ablation instrument for trained networks.** "Drift versus loss" tells *severed input* apart from *destroyed integrator* without reading any weights. Ablate the inputs to a recurrent module in a trained model. If the state persists but random-walks, the module is the integrator and the ablated block was its velocity source. If the state collapses, the integrator is at or below the cut. The test is cheap, and it would make the attractor criteria on [[wiki/concepts/attractor-identification.md]] usable on models. No machine study in the wiki runs it.

---

## The conundrum: the sensor that drives the integrator cancels self-motion

| Measurement | Result |
|---|---|
| Vestibular nerve (eighth-nerve afferents), monkey | **Identical** for active and passive rotation and translation, and independent of gaze |
| `VO` neurons, head-unrestrained monkeys (several species) and mice | Responses **~70% attenuated** during active head movement, for rotation and for translation |
| Condition for the cancellation | It occurs **only when neck-proprioceptor activation matches the motor-generated expectation**. It is cerebellum-dependent and happens at the first central synapse |
| Recalibration | A constant resistive torque halves head motion. Vestibular-nucleus neurons at first respond as if the movement were passive. Cancellation returns over **~40–50 head movements**, on the same time course as behavioural learning: a fast forward-model update |
| `PVP` neurons | Suppressed by an inhibitory gaze command during every saccade and smooth pursuit |
| `FTN` neurons | Carry gaze-related as well as vestibular signals |
| Otolith input to the vestibular nuclei | Also strongly attenuated during voluntary changes of head position |

**The source's conclusion.** During voluntary behaviour, none of the three monkey vestibular-nucleus output classes carries purely vestibular information. `VO` is attenuated, and `PVP`/`FTN` carry gaze. Yet heading needs the vestibular system:

| Heading-cell result | Implication |
|---|---|
| Tuning is retained under passive rotation, where only vestibular cues are present | Vestibular input alone can drive the ring |
| Rats moved by cart to a novel room: preferred directions are **unstable**. Rats that walk there: **stable** | A normal vestibular signal is not sufficient. Proprioception or efference copy is needed to carry orientation into a new environment |
| Active-versus-passive heading differences are mixed: attenuated when passive in towel-restrained rats; similar in head-fixed `AD` | Unresolved |
| Numbers, `AD` (Jankowski et al. 2013): tight trunk restraint, head free → near-complete suppression when passive (Taube 1995; Knierim 1995). Unrestrained passive → peak rate −27%, tuning kept (Zugaro 2001). Loose restraint → −23% (Bassett 2005). Trunk and head fixed → **no** reduction, also in the dark (Shinder & Taube 2011) | The size of the effect follows the restraint, not the active/passive contrast. Restraint is a confound, and in the head-fixed case vision, motor and proprioceptive input are not needed for tuning |

**Two candidate answers, neither tested.** (i) Mouse `VO` neurons, unlike monkey ones, carry a **static neck-position** signal that is unchanged between active and passive motion. (ii) The residual ~30% is **up-weighted** in the active condition and/or combined with proprioceptive and efference signals inside the heading network, so the input is decoded according to context. The source asks which circuit would do this and has no answer. Registered as `T408`.

---

## Head or gaze?

- `NPH` is the oculomotor integrator, its lesion disrupts heading, and it targets regions projecting multisynaptically to presubiculum. So the ascending signal may carry **eye-in-head position** as well as head direction.
- **No rodent study has recorded heading cells while tracking the eyes.** Whether a rodent "head-direction" cell codes head or gaze is open.
- Primate data point both ways:

| Primate finding | Frame |
|---|---|
| Spatial-view cells, mostly in hippocampus: fire when a region of the environment is in view (Rolls) | View |
| Entorhinal cells in head-fixed monkeys fire by saccade direction | **Egocentric** |
| Allocentric heading cells in presubiculum, entorhinal cortex and anterior thalamus, independent of eye position | Allocentric, but **~5%** of cells, against 50% (`AD`) and 25% (postsubiculum) in rodents |

**(brainstorm) The variable an integrator holds is defined by what enters it.** If the velocity wire carries eye plus head velocity, the ring integrates gaze, whatever the recording design names it. This is an `L0-INSTR` hazard for every machine probe that labels a latent by the variable the experimenter controlled ([[wiki/concepts/representation-probing.md]]).

---

## The reference frame in three dimensions: one axis is anchored by gravity

| Species / test | Result |
|---|---|
| Bats | 3-D tuning, kept when the animal is inverted |
| Rats, vertical plane | Directional tuning present |
| Rats, inverted | Tuning **lost** |
| Proposed explanations | Locomotion-plane frame (a wall is an extension of the floor). Mosaic hypothesis: one rule for yaw, one for rotation of the dorsal–ventral axis about gravity. **Neither explains the loss under inversion** |
| Shinder & Taube: head-fixed rats placed passively in all three rotational planes | Responses largely explained by orientation **relative to the gravity axis** |
| Otolith disruption | Impairs heading cells |
| Monkey anterior thalamus | Cells tuned to pitch and roll relative to gravity |

**(brainstorm) The cheapest anchor in the wiki.** One axis of the frame is fixed by a sensor reading of a physical constant. Nothing has to be learned and nothing searched. Read against `G39`: part of the symmetry group is removed before any landmark is consulted. Rotation in 3-D reduces to rotation about a known axis. Abstract structures have no such constant.

---

## Immersive and imagined frames

The forward model that decides what counts as self-generated is recalibrated within tens of movements. Any setup that changes the relation between motor command and sensory feedback therefore changes what the heading network is fed:

| Setup | Mismatch |
|---|---|
| Virtual reality | Visual flow says the subject moves. Vestibular and proprioceptive feedback say it does not |
| Head-fixed or head-restrained | Expected and actual vestibular and proprioceptive feedback disagree |
| Human fMRI navigation | Supine, head fixed, watching a monitor: **no** active vestibular, motor-efference or proprioceptive signal |

**The source's untested prediction.** If the forward model adapts to the immersive setup, heading cells may encode heading **in the reality the subject is immersed in** (a VR world, a dream) rather than in the physical room. That would contradict the assumption that the system holds a fixed real-world heading.

| Related evidence | Detail |
|---|---|
| Place cells in rat VR | Robust in one lab, where rats were harnessed but free to rotate head and body, so canals and neck proprioceptors were active; heading and grid cells were present too. Absent or reduced in labs using head- or body-fixed rats. All studies used rats, so species does not explain it. The source's reading: robust place firing needs vestibular and proprioceptive input |
| Spatial tasks without heading | Rats can perform spatial tasks with a non-functional heading system. Different spatial tasks recruit different computations |
| Grid cells | Need intact heading input and theta, and need **active movement**. Peripheral vestibular damage disrupts hippocampal and medial entorhinal theta as well as heading, so the vestibular system plausibly sits upstream of the grid code twice. Not tested directly |
| Two frames at once (Jacob et al. 2017, rat retrosplenial cortex) | Some heading cells follow the **global** environment, some the **local** one. A third type, found only in dysgranular retrosplenial cortex, has **two preferred directions** and codes both frames simultaneously ([[wiki/entities/retrosplenial-cortex.md]], `G43`) |
| Sleep (Peyrache et al.) | Heading cells keep their pairwise correlation structure, and waking activity is replayed at ~10× speed. Heading activity is not always tied to real-world events. Peyrache et al. 2015 is the data set Chaudhuri et al. 2019 re-analysed to find the 8× non-REM sweeps on [[wiki/entities/anterior-thalamic-nuclei.md]] |
| Open questions the source poses | Avatar in a video game: does heading follow the game frame or the room? Imagined navigation from home: imagined frame or real one? Do all heading areas switch frames together, or does the population split? |

---

## Two ascending vestibular pathways

| | **Anterior** | **Posterior** |
|---|---|---|
| Route | Vestibular nuclei → `NPH`/`SGN` → `DTN` ↔ `LMN` → `AD` → retrosplenial cortex directly, and → pre-/parasubiculum → entorhinal cortex | Vestibular nuclei → ventral posterior (lateral) thalamus → somatosensory cortex and parieto-insular vestibular cortex |
| Carries | A static **sense of direction**: a held state | Perceived **self-motion**: a rate, whether relative to the world or to a screen |
| Studied | Extensively | Little |
| Where the two merge | **Unknown** | |

**(brainstorm) One sensor, two readers: a state and its derivative on separate wires.** In machine terms this is an `L1` split: the integrator and the motion percept are separate blocks. The `VO`-to-thalamus signal that reaches perception is the exafference-dominated one. If heading is built from that same attenuated signal, the integrator also needs the efference/proprioceptive estimate that perception discards. The two pathways would then differ in *which half of the motion* they are allowed to see.

---

## How it maps to model components

| Element | Model reading |
|---|---|
| `DTN` ↔ `LMN` ring with `AHV` input | `z_t = f(W z_{t−1} + B a_t)` on a 1-D ring ([[wiki/concepts/path-integration.md]]) |
| `VO` cancellation | The first stage emits `sensed − predicted(efference)`: exafference. So `a_t` is **not** the sensor reading |
| Cancellation only when proprioception matches expectation | The comparator is gated by a second sensory channel. A command alone does not cancel anything |
| Recalibration in ~40–50 movements | A fast, cerebellum-dependent forward model that decides *what counts as self-generated* ([[wiki/entities/cerebellum.md]], `G92`) |
| Drift-versus-loss lesion logic | An ablation test for locating an integrator in a trained network (above) |
| Gravity-referenced axis | A sensor-delivered anchor that removes part of the symmetry group (`G39`) |
| VR / head-fixed mismatch | What the integrator counts as motion depends on the setup. A change in body dynamics recalibrates the integrator's input before it can affect the integrator |

**(brainstorm) Put the forward model on the integrator's input path, not beside it.** Suppose the integrator needs total head motion and the sensor stage passes on only the unpredicted part. Then the input has to be rebuilt as `a_t = â_t(efference, proprioception) + e_t`: the forward model's prediction plus the exafferent residual. Three consequences follow. (i) A forward-model miscalibration becomes **integrator drift**. (ii) A sustained miscalibration, as in VR, is a sustained bias. (iii) The prediction: heading should drift, or follow the wrong gain, during the ~40–50 movements after a change in body dynamics. That is the window in which vestibular-nucleus neurons treat self-motion as passive. Untested. The fly compass is the cleanest machine template the wiki has ([[wiki/entities/fly-central-complex.md]]), and it was measured head-fixed in closed-loop VR, the setup this source flags as mismatched.

**(brainstorm) `G92`'s boundary statistic, computed per variable at the first synapse.** `G92` asks for the agent/world boundary to be *derived* as the variables that the agent's efference copy explains. `VO` neurons already compute it for head motion: they pass on the exafferent part, gate the cancellation on proprioceptive confirmation, and recalibrate the partition within ~50 movements when the body changes. This is not the general mechanism `G92` needs, since the variable (head motion) and the efference channel are fixed by wiring. It is the wiki's first measured instance of the boundary as a comparator output with a recalibration time constant.

---

## Limitations

- **Perspective, not data.** Box 1 (glossary of path integration, forward model, optic flow, idiothetic/allothetic) and the figures are missing from the clip.
- **Not independent of the wiki's Papez pages.** Taube co-authored most of the rat heading lesion results already cited there.
- **Species split.** The active/passive vestibular data are mainly monkey and the heading data mainly rat. The conundrum spans the two, and the one cross-species difference reported (mouse `VO` neck-position signal) points to an answer that does not hold in monkeys.
- **The attractor's site is a hypothesis** based on lesion-pattern logic and reciprocal wiring. No connectivity measurement is reported.
- **No eye tracking in any rodent heading study**, so the variable's name is an assumption.
- **The VR prediction is stated and not tested.** No heading recording is reported under a manipulated forward model.

---

## Connections

- **[[wiki/concepts/path-integration.md]]** — this system is the mammalian heading instance of that page's update rule, and it challenges the rule's input term: `a_t` is labelled self-motion, but the measured first central stage passes on only the unpredicted part of self-generated motion, so the integrator's velocity must be rebuilt from efference and proprioception (`T408`).
- **[[wiki/entities/mammillary-bodies.md]]** — holds the hypothesised attractor: `DTN` ↔ `LMN` is where the ring is placed, because lesions upstream (`NPH`/`SGN`) leave the bump drifting while lesions at or below it abolish directional firing. Visual correction descends to `LMN` from dorsal presubiculum.
- **[[wiki/entities/anterior-thalamic-nuclei.md]]** — `AD` is the chain's high-signal-to-noise relay (~50% heading cells), and it is the head of the anterior vestibulothalamic pathway, the "sense of direction" route that this source contrasts with the posterior, self-motion-perception route.
- **[[wiki/entities/retrosplenial-cortex.md]]** — supplies the system's one measured case of two frames held at once: global-tied, local-tied and dual-preferred-direction heading cells (the last only in dysgranular cortex), the basis the source offers for keeping several spatial representations concurrently.
- **[[wiki/entities/fly-central-complex.md]]** — the insect ring this system is compared with. That page's cue-conflict data were measured head-fixed in closed-loop VR, the setup this source says changes what a heading network is fed.
- **[[wiki/entities/cerebellum.md]]** — the cancellation of self-generated vestibular input is cerebellum-dependent and recalibrates in ~40–50 movements, so the forward model that page describes for limb control sits on the heading integrator's input path.
- **[[wiki/concepts/prediction-error-neurons.md]]** — a subcortical, first-synapse version of that page's comparator: vestibular-only neurons pass on sensed minus predicted motion, gated by a proprioceptive match, one synapse from the sensor rather than in cortical layer 2/3.
- **[[wiki/entities/hippocampal-diencephalic-cingulate-network.md]]** — the circuit this chain runs through, with its theta twin one nucleus over at every level (ventral tegmental nucleus of Gudden → medial mammillary → `AV`). The two merge in `AV`'s head-direction-by-theta cells (Jankowski et al. 2013).
- **[[wiki/concepts/hexadirectional-signal.md]]** — the human instrument is run supine and head-fixed in front of a monitor, the setup in which this system's vestibular, proprioceptive and efference inputs are all absent or mismatched.
