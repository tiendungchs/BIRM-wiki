# Pulvinar — the Relay That Copies Its Cortex and Keeps It Awake

**The ventro-lateral pulvinar looks like a copy of the cortex it is wired to. Its selectivity, receptive fields and attention effects match V4's, with attention effects weaker and later, and V4 leads it at attention-modulated gamma. So it is not where attention comes from. But remove it and V4 loses 60% of its evoked response and half of its attentional modulation. That patch of cortex then drops into a local, retinotopically confined slow-wave state, and behaviour in the matching quadrant falls from 74% to 11%. The pulvinar is not a controller. It is the loop the cortex needs in order to be controllable at all.**

> **Provenance.** Zhou, Schafer & Desimone 2016, *Pulvinar-cortex interactions in vision and attention*, Neuron 89(1):209–220, doi:10.1016/j.neuron.2015.11.034 (`raw/zhou-2016-pulvinar-cortex-interactions-in-vision-and-attention.md`). Two rhesus macaques. The task was cued covert spatial attention: three grayscale objects, report the cued one's 50 ms colour change, ignore changes at the two distracters. Multiunit activity and local field potentials (LFP) were recorded at the same time from ventro-lateral pulvinar, V4 and inferotemporal cortex (IT), using 16-contact linear probes. The pulvinar was then reversibly deactivated with muscimol (a GABA_A agonist; 2–4 × 1 µl at sites representing the V4 receptive fields), within-session before/after. Cell Press clip. The supplement is not in the clip; it holds the analysis formulas, including the attention index.

Why this earns a page. The wiki pages three thalamic nuclei ([[wiki/entities/mediodorsal-thalamus.md]], [[wiki/entities/anterior-thalamic-nuclei.md]], [[wiki/entities/nucleus-reuniens.md]]) and one mouse analogue of this nucleus ([[wiki/concepts/transthalamic-context-routing.md]], LP). None has a primate causal result on a sensory hierarchy during a task. This source also runs **both instruments on one circuit**: directed-correlation measures (latency, coherence, Granger, phase slope) and a lesion. The two disagree about which structure matters.

---

## Anatomy (as the source states it)

| Fact | Consequence for a model |
|---|---|
| Largest thalamic nucleus. Its ventro-lateral part (inferior + ventral lateral pulvinar) is reciprocally wired with V1, V2, V4 and IT | One relay serves a whole cortical hierarchy |
| Cortical **layers 5/6 → pulvinar**, topographic. Pulvinar → cortex mainly to **superficial layers** | A deep-out / superficial-in loop, the transthalamic motif of [[wiki/concepts/canonical-cortical-microcircuit.md]] |
| A single V4 location connects to a wide anterior–posterior zone of pulvinar. Separate V4 points converge on one pulvinar site | Pulvinar receptive fields are **between V4 and IT in size**: a convergent copy |
| Inferior pulvinar receives superior colliculus input | The only non-cortical driver named |
| **No direct connections** between ventro-lateral pulvinar and parietal or prefrontal cortex. All of pulvinar receives GABAergic input from the thalamic reticular nucleus, which receives converging cortical input, including prefrontal | Any prefrontal control reaching this loop goes through an inhibitory shell. It has no direct wire |
| Dorsal pulvinar is the parietal-connected part. Its cells resemble parietal cells, and deactivating it impairs attention but spares sensory processing | The subdivisions differ: each **inherits the function of its cortical partner** |

---

## Intact state: the pulvinar mirrors V4

| Measure | Pulvinar | V4 | IT |
|---|---|---|---|
| Visually responsive sites | 339/641 (53%) | 310/366 (85%) | 210/422 (50%) |
| Stimulus-selective sites (7 objects) | 35% | 42% | 32% |
| Relative object tuning of selective sites | similar | similar | similar |
| Attention index, cue-first / stimulus-first | **0.04 / 0.03** | **0.16 / 0.13** | — |
| Attention latency (population histogram) | 135 ms | 115 ms | — (difference n.s., `p = 0.22`) |
| Attention latency (per-site cumulative distribution) | **later** | earlier | `p = 0.0085` |
| Within-area spike–LFP gamma coherence, attention effect | **none** (`p = 0.31`) | ↑ (`p = 4.9e-46`) | ↑ (`p = 7.6e-13`) |

Cross-area results:

| Pair | Gamma | Low band (≤15–30 Hz) | Direction |
|---|---|---|---|
| V4 ↔ pulvinar | Spike–field coherence ↑ with attention in both directions | ↓ with attention | **V4 leads.** Granger V4→pulvinar gamma ↑ with attention (`p ≈ 0`). Pulvinar→V4 gamma slightly ↓. Phase slope gives a constant **12.2 ms** V4 lead |
| Pulvinar → V4, below 30 Hz | — | Granger pulvinar→V4 **exceeds** V4→pulvinar (`p ≈ 0`). Attention reduces it by only 12% | The **pulvinar dominates the low band** |
| Pulvinar → V4, pre-stimulus alpha (8–16 Hz), cue-first | — | ↑ with attention (`p = 7.5e-35`) | Replicates Saalmann et al. 2012. During stimulus processing, pulvinar→V4 alpha is instead slightly ↓ |
| V4 → IT | Strongly ↑ with attention, almost unidirectional | — | V4 leads IT by **6.4 ms**. The enhancement occurs **only when the attended item is in the joint V4–IT receptive field**, although both items sit inside the large IT field |
| Pulvinar ↔ IT | No attention effect | — | Recording sites were chosen for V4 connectivity |
| Pulvinar rate × cortical LFP power, trial by trial | Positive with gamma (V4 0.0050, IT 0.0034) | **Negative** with alpha–beta (V4 16–30 Hz, IT 8–30 Hz) | Correlational |

Controls: selecting trials so that firing rate and LFP power match across attention conditions keeps the coherence and Granger effects. So they are not a by-product of rate or power.

**The source criterion, applied.** The frontal eye field (FEF) passes the three tests a source of attention should pass: little stimulus selectivity, strong attentional modulation, and modulation earlier than V4 (Gregoriou et al. 2009; Zhou & Desimone 2011; [[wiki/concepts/priority-map.md]]). The ventro-lateral pulvinar fails all three. It carries the cortex's selectivity, its attention effect is smaller and later, and it lags at gamma. The authors conclude it is not a major source of feedback that directly mediates attention in V4.

---

## Deactivated: V4 loses its drive, not just its selection

| Measure | Before | After | Change |
|---|---|---|---|
| Behaviour, target in **lower contralateral** field (with distracters) | 74.3% | **10.8%** | `p = 1.6e-4`, `n = 8` sessions |
| Behaviour, ipsilateral target | 76.6% | 72.8% | n.s. |
| Behaviour, upper contralateral target | 69.2% | 59.1% | n.s. (`p = 0.13`) |
| Behaviour without distracters, at the V4 receptive-field location | 81.0% | **19.5%** | Other two locations: 82.8→74.4%, 82.7→76.3% |
| V4 baseline firing (250 ms before stimulus) | 9.54 Hz | **12.20 Hz** | ↑ (`p = 0.052`) |
| V4 visually evoked response (50–150 ms, baseline-subtracted) | 11.65 Hz | 4.69 Hz | **−59.7%**. Now **below the pre-injection response to an unattended stimulus** |
| V4 response to target colour change | 4.76 sp/s | 0.44 sp/s | **−90.7%** |
| V4 attention index | 0.106 | 0.053 | **−50%** (`p = 0.0015`) |
| V4 spike–LFP gamma coherence (mean of attend-in/out) | 0.051 | 0.031 | −39% |
| Attention effect on V4 gamma coherence | 0.123 | 0.062 | −49.6% |
| V4–IT field–field gamma coherence | 0.17 | 0.11 | −35% |
| Attention enhancement of V4–IT gamma coherence | 0.33 | 0.23 | −30% (still present, `p ≈ 0`) |
| V4 LFP power below 20 Hz | — | **large ↑**, extending down to **≥0.5 Hz** in a 2 s window | Smaller ↑ in IT |
| LGN visual response (2 sessions) | — | unchanged | Rules out muscimol spread to LGN |
| IT visual response (`n` = 28 before / 31 after) | — | not reduced (`p = 0.28`) | IT input bypassing V4 survives |

Confound controls on the low-frequency increase: V4 and IT low-frequency LFPs differ in phase, and current-source-density shows the same increase (so it is not volume conduction). Matching microsaccade rates keeps the increase (so it is not eye movement). Short- and long-delay trials give the same power (so it is not stimulus transients). The crude superficial/deep split of V4 sites shows the same effects in both halves.

**Reading.** Higher baseline firing, slow oscillations down to 0.5 Hz, and weak sensory responses together match the signature of cortex in slow-wave sleep (Livingstone & Hubel 1981). The deficit is **local**: one quadrant's behaviour, one area's physiology, confined to where the injected pulvinar sites project. The authors' interpretation is that pulvinar input keeps the cortex in an active state, and that this is also what lets top-down attention signals from elsewhere act on it.

---

## What this gives a builder

**1. A lesion separates "the structure the attention signal passes through" from "the structure that is necessary".** On directed-correlation evidence, V4 drives the pulvinar. On lesion evidence, V4 needs the pulvinar. Both are true: the gamma lead measures the direction of the *attention-modulated component*, and the lesion measures dependence. For [[wiki/concepts/inter-areal-synchrony.md]] this is the converse of "never call a correlation a channel": **never call a lag a hierarchy of necessity.**

**2. The relay's removal costs both drive and selection, and the selection loss is not just a gain effect.** Evoked response fell 59.7% and the attention index fell 50%. If the index is the usual contrast `(In − Out)/(In + Out)` (the formula is in the unclipped supplement), then a pure multiplicative gain loss would leave it unchanged. Its halving means the attentional modulation itself was cut on top of the drive. **(brainstorm)** Model the loop as a gain field that both scales the module and licenses modulatory inputs to reach it: `r = g_loop · (drive + g_loop · a · bias)`, where `g_loop → small` both shrinks `r` and removes the effect of the attention bias `a`. The testable prediction: in an ANN (artificial neural network) with a recurrent module→relay→module loop, cutting the loop should shrink modulation *as a fraction*, not only in absolute size.

**3. The "state" is addressed, not broadcast.** The slow-wave-like state appears only in the cortex served by the deactivated sites, with the upper-field and ipsilateral quadrants spared. A higher-order thalamic permissive signal is therefore **retinotopically addressed**. That is evidence against reading thalamic state control as one global scalar (`T376`, Position A's "topology of a broadcast"). But the pulvinar is not *aimed* by attention, since its own attention effect is small and late. The picture fits `T376`'s untested reconciliation: a slow, spatially addressed permissive loop set by the thalamus, with selection supplied by a different controller (FEF, prefrontal cortex).

**4. The want-list's hypothesis is refuted.** The wave-27 target expected a gateway "whose removal costs the selection, not the signal" (`G110`). The data show the signal falls *more* than the selection (−59.7% vs −50%), with the response to the target event nearly gone (−90.7%). This is not control applied at an interface. It is a module's **power supply** that happens to be a loop through a second structure. `G110` stays open.

**5. Hub partition by partner.** The authors' synthesis is that "each subdivision of the pulvinar shares the properties and functions of its anatomically connected cortical areas": ventro-lateral ↔ V4-like, dorsal ↔ parietal-like, and the MT-connected zone derives its direction tuning from MT (Berman & Wurtz 2011). One nucleus holds `k` partner-typed sub-loops, each a convergent copy of its partner. That is `G122`'s *discrete* arrangement at the scale of subdivisions. Afferent density per projection class is not measured.

---

## Against the wiki's other thalamic pages

| Nucleus | Cargo | Source of its variable | Removal costs |
|---|---|---|---|
| [[wiki/entities/mediodorsal-thalamus.md]] | Cueing context, two signed channels | Pooled from the prefrontal population it gates | Switching speed and weight protection. Stable within-block performance is spared |
| LP → PM, mouse ([[wiki/concepts/transthalamic-context-routing.md]]) | Sender's pupil-linked arousal | Upstream layer-5/6 cells | PM's arousal modulation. Visual responses nearly spared |
| **Ventro-lateral pulvinar → V4, macaque (this page)** | A convergent copy of V4, plus a low-band influence that suppresses cortical alpha–beta | V4's (and V1/V2/IT's) deep layers | **Sensory drive, attention modulation, gamma coherence, and the active state itself**, locally |
| Higher-order thalamus → layer 5a ([[wiki/entities/dendritic-integration-theory.md]]) | Permission for apical–basal coupling | Layer-5 pyramids of the same column | Coupling. Decoupled cortex generates slow oscillations |

The LP→PM and pulvinar→V4 rows conflict on whether removing the pulvinar-class relay spares content responses. They differ in species, target area (a mouse higher visual area versus primate mid-level V4), instrument (partial terminal-release suppression of one pathway versus whole-nucleus muscimol that removes every output), and engagement (passive versus an attention task). The row this table best fits is the last: "decoupled cortex runs slow oscillations" is what Table 1 of the dendritic-integration source predicts. Here it is measured with the thalamus removed, in an awake animal, in one patch of cortex. This is a candidate cellular account of the result, not one the source tests.

---

## Limitations

| Limit | Consequence |
|---|---|
| Two monkeys. Mostly multiunit activity. V4 sites not assigned to layers (only an upper/lower-half split) | Cannot say which pulvinar terminals (superficial-layer target) carry the effect, or whether layer-5 coupling is involved |
| Muscimol silences **every** output of the injected zone | Content, state and synchrony cargo cannot be separated. The pathway-specific design of [[wiki/concepts/transthalamic-context-routing.md]] is what would be needed |
| LGN spread control rests on 2 sessions; IT on 28/31 cells | The specificity claim is moderately supported |
| Sensory loss vs profound neglect not separated behaviourally | The effect is only modestly larger with distracters. The authors cannot exclude neglect |
| "Sleep-like" is an analogy from LFP spectra and baseline rate | No sleep measurement and no down-state detection. The 2 s window used for <4 Hz spans trial events and the intertrial interval |
| Granger and phase-slope analyses run on LFPs | Field potentials carry shared-source risk. Pairs with non-linear phase were flagged as noise-dominated |
| Attention-index and coherence formulas are in the unclipped supplement | Point 2 above (contrast versus absolute) is conditional on the standard definition |

---

## Connections

- **[[wiki/concepts/transthalamic-context-routing.md]]** — the mouse analogue measured pathway by pathway, and the result this page contradicts on one point: LP→PM silencing spares the receiver's visual responses, whereas deactivating the macaque ventro-lateral pulvinar cuts V4's evoked response by 60%, so "the transthalamic edge carries state, not content" does not transfer as "removing it spares content" (`T276`).
- **[[wiki/entities/mediodorsal-thalamus.md]]** — the other half of the thalamic contrast: mediodorsal thalamus builds a context variable its cortex does not carry and returns it as a signed gate, while this nucleus holds a convergent copy of what its cortex already carries and returns an enabling drive, so one computes a variable and the other keeps its partner in an operating state.
- **[[wiki/entities/dendritic-integration-theory.md]]** — a primate test of that theory's slow-oscillation row: removing a higher-order thalamic input leaves an awake animal's cortex with raised baseline firing, slow oscillations down to 0.5 Hz, and weak sensory drive in one patch only, which is what decoupling predicts and also a local rather than global state (`T376`).
- **[[wiki/concepts/attention.md]]** — applies that page's frontal-source latency criterion to a subcortical candidate and rejects it: pulvinar attention effects are a quarter the size of V4's and come later, yet removing the pulvinar halves V4's attention effect, so the structure attention needs is not the structure attention comes from.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — a single circuit where the measures disagree on direction: attention-modulated gamma runs V4→pulvinar (12.2 ms lead), low-band Granger runs pulvinar→V4, and the lesion shows V4 depends on pulvinar, so which structure leads says nothing about which one is necessary.
- **[[wiki/concepts/priority-map.md]]** — the contrast case that defines a control source: frontal eye field cells are unselective for objects, strongly modulated and earlier than V4, while pulvinar cells are selective, weakly modulated and later, so the three properties sort a source from a relay without any lesion.
- **[[wiki/concepts/visual-routines.md]]** — tests Ullman's connectivity-only nomination of the pulvinar as the task-independent shift controller for the ventral-stream part: that part follows the cortex rather than leading it, and is necessary for cortical drive rather than for shifting as such.
- **[[wiki/concepts/constitutive-vs-enabling.md]]** — a measured enabling structure: removing it abolishes behaviour in one quadrant and most of V4's response, yet its own activity only mirrors V4, so a correlate that disappears with pulvinar deactivation may index the loop rather than the content.
- **[[wiki/concepts/sleep-oscillation-nesting.md]]** — waking evidence that cortex without its thalamic loop falls into slow rhythms: deactivation raises V4 power down to 0.5 Hz, which fits `T373` Position A (the slow oscillation is a cortical default) and suggests the waking job of the higher-order thalamus is partly to hold that default off.
- **[[wiki/concepts/emergent-modularity.md]]** — the human pulvinar gained neurons, and a bimodal soma-size distribution, while sensory relay nuclei did not change. Here that expansion is priced: in the macaque this nucleus is necessary for mid-level visual cortex to respond at all.
