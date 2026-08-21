---
title: "Higher-order thalamic input to cortex selectively conveys state information"
source: "https://pmc.ncbi.nlm.nih.gov/articles/PMC11920878/"
author:
  - "[[Garrett T. Neske]]"
  - "[[Jessica A. Cardin]]"
published: 2025-02-11
created: 2026-08-09
description: "Cell Reports 44(2):115292. Awake mice; two-photon imaging of PM cell bodies plus V1->PM, LM->PM and LP->PM axon terminals, with eOPN3 terminal silencing and projection-neuron ablation. V1->PM carries the strongest visual drive; LP->PM axons fire at higher rates but are poorly time-locked to PM events. Silencing V1/LM terminals cuts PM visual responses; silencing LP terminals leaves visual responses near-intact and instead cuts PM modulation by PUPIL diameter - with no effect on locomotion modulation. The LP state signal appears inherited from V1 layer-5/6 corticothalamic neurons. Authors state the role of LP is target-area dependent (LP->postrhinal may carry precise visual information), so LP->PM should not be read as all higher-order thalamus."
tags:
  - "clippings"
  - "thalamus"
  - "attention"
  - "gating"
  - "arousal"
  - "hub-satellite-interface"
---

# Higher-order thalamic input to cortex selectively conveys state information

Garrett T Neske

### Garrett T Neske

1Department of Neuroscience, Kavli Institute for Neuroscience, Wu Tsai Neuroscience Institute, Yale University, New Haven, CT, USA

2Present address: Department of Physiology and Biophysics, State University of New York at Buffalo, Jacobs School of Medicine and Biomedical Sciences, Buffalo, NY, USA

Find articles by Garrett T Neske

1,2, Jessica A Cardin

### Jessica A Cardin

1Department of Neuroscience, Kavli Institute for Neuroscience, Wu Tsai Neuroscience Institute, Yale University, New Haven, CT, USA

3Lead contact

Find articles by Jessica A Cardin

1,3,*

-

-

-

1Department of Neuroscience, Kavli Institute for Neuroscience, Wu Tsai Neuroscience Institute, Yale University, New Haven, CT, USA

2Present address: Department of Physiology and Biophysics, State University of New York at Buffalo, Jacobs School of Medicine and Biomedical Sciences, Buffalo, NY, USA

3Lead contact

AUTHOR CONTRIBUTIONS

G.T.N. and J.A.C. designed the experiments. G.T.N. collected and analyzed the data. G.T.N. and J.A.C. wrote the manuscript.

*
Correspondence: jess.cardin@yale.edu

Issue date 2025 Feb 25.

This is an open access article under the CC BY-NC-ND license (https://creativecommons.org/licenses/by-nc-nd/4.0/).

PMC Copyright notice

PMCID: PMC11920878  NIHMSID: NIHMS2060932  PMID: 39937647

The publisher's version of this article is available at Cell Rep

Previous version available: This article is based on a previously available preprint posted on bioRxiv on October 10, 2023: "Transthalamic input to higher-order cortex selectively conveys state information".

## SUMMARY

Communication among neocortical areas is largely thought to be mediated by long-range synaptic interactions between cortical neurons, with the thalamus providing only an initial relay of information from the sensory periphery. Higher-order thalamic nuclei receive strong synaptic inputs from the cortex and send robust projections back to other cortical areas, providing a distinct and potentially critical route for corticocortical communication. However, the relative contributions of corticocortical and thalamocortical inputs to higher-order cortical function remain unclear. Using imaging of neurons and axon terminals in combination with optogenetic manipulations, we find that the higher-order visual thalamus of mice has a unique impact on the posterior medial visual cortex (PM). Whereas corticocortical projections from lower cortical areas convey robust visual information to PM, higher-order thalamocortical projections convey information about global arousal state. Together, these findings suggest a key role for the higher-order thalamus in providing contextual signals that may flexibly modulate cortical sensory processing.

## In brief

Neske and Cardin use imaging and optogenetics to examine the impact of thalamocortical and corticocortical projections on the higher-order cortex. They show that thalamic projections from the LP to higher-order cortical area PM primarily contribute to state-dependent modulation. In contrast, projections from cortical areas V1 and LM contribute to PM visual encoding.

## Graphical Abstract

## INTRODUCTION

Many fundamental sensory, motor, and cognitive operations of the brain depend on intricate communication among multiple regions of the neocortex. Synaptic interactions among hierarchically organized neocortical regions generate increasingly selective neuronal responses ranging from simple, heterogeneous tuning properties in primary sensory areas to highly specialized responses in higher-order cortices.1–3 Corticocortical communication thus comprises a complex web of feedforward and feedback connections4–6 with distinct laminar termination patterns and cellular and subcellular targets.7–9

Inter-areal cortical interactions also mediate cognitive flexibility, dynamically altering the flow of information across the cortex depending on behavioral context and past experience.10,11 This extensive series of interactions may support the functional flexibility of cortical processing, but the relative contributions of long-range projections are poorly understood. Neurons in higher-level cortical areas receive robust feedforward synaptic inputs from cortical areas occupying earlier levels of the sensory processing hierarchy, but it remains unclear how higher-order sensory receptive fields arise from the integration of distinct lower-level cortical inputs.12–14

In addition to direct corticocortical innervation, higher-order thalamic projections to the cortex provide a separate pathway for corticocortical communication. Higher-order thalamic areas, including the pulvinar nucleus in the visual system, receive most of their driving synaptic input from the cortex rather than from the sensory periphery. In turn, higher-order thalamic nuclei send projections to areas spanning the cortical hierarchy. A cortical region receiving direct, monosynaptic corticocortical connections may thus also receive disynaptic input from the same cortical source via higher-order thalamic nuclei,15 providing a transthalamic corticocortical connection that mirrors the direct one.16 Thalamocortical relay cells in higher-order thalamic nuclei receive very strong synaptic input from subcortically projecting layer 5 cortical pyramidal cells,17–19 suggesting that the higher-order thalamus could serve as a potent means of transmitting sensory information between cortical regions.20–22 However, the relative impact of direct corticocortical connections and higher-order thalamic projections on postsynaptic cortical targets remains unclear.

Both spontaneous and sensory-evoked activity in primary and higher-order cortical areas is strongly modulated by fluctuations in behavioral state.23–29 Wakeful behavioral states are associated with pupil dilation, facial and body movements, locomotion, arousal, attention, and task engagement.27,28,30,31 Variation in these markers of behavioral state are linked to fluctuations in cortical activity patterns and sensory encoding, as well as the reorganization of cortical networks.23,24,29,32 Activity in primary thalamic relay nuclei is likewise sensitive to global arousal and locomotion,33–35 suggesting that some behavioral signals in lower-order cortical areas may be inherited from primary or higher-order thalamic afferents. However, partly due to the challenges of selectively manipulating activity in higher-order thalamic nuclei, it remains unclear how behavioral-state information reaches higher-order cortical areas.

Here, we investigated the impact of long-range corticocortical and higher-order thalamocortical synaptic pathways on the sensory- and state-dependent properties of neurons in the posterior medial visual cortex (PM) in awake, behaving mice. Using in vivo imaging of genetically encoded calcium indicators in neuronal cell bodies and axon terminals in layer 2/3 of PM, along with optogenetic manipulations of discrete input pathways, we find that corticocortical and higher-order thalamocortical projections make distinct contributions to higher-order cortical circuit function. Whereas suppression of corticocortical inputs to PM reduces sensory-related activity, suppression of higher-order thalamocortical inputs primarily affects representation of contextual signals related to behavioral state. Our results provide insight into the synaptic foundations of corticocortical communication and suggest a unique role for the higher-order thalamus in promoting flexible sensory processing by cortical circuits.

## RESULTS

### Convergence of corticocortical and higher-order thalamocortical inputs to the higher visual cortex

To examine the relative contributions of corticocortical and thalamocortical inputs to higher-order cortical areas, we focused on the mouse PM, a higher-order visual cortical area (Figure 1A). PM occupies one of the highest levels of the mouse visual system hierarchy9,36 and receives feedforward long-range projections from several other visual cortical regions.37,38 To determine the relative abundance and density of projections to PM from different presynaptic regions, we injected a retrogradely infecting CAV2 virus39 carrying Cre recombinase into PM of mice harboring a Cre-dependent red fluorophore. Cells in the higher-order visual thalamus, the lateral posterior nucleus (LP; an analog of the pulvinar nucleus), but not the neighboring first-order visual thalamus, the dorsal lateral geniculate nucleus (dLGN), were robustly retro-labeled by CAV2-Cre injection into PM (Figure 1B). Projections from primary visual cortex (V1) and lateromedial cortex (LM) constituted 72%–90% (mean: 82%, SD: 0.05%) of the feedforward corticocortical projections to PM (see STAR Methods), suggesting that projection neurons in these cortical regions may be strong drivers of PM activity (Figures 1C and 1D). We therefore selected V1→PM and LM→PM projections for further comparison with the higher-order thalamocortical pathway from the LP (i.e., LP→PM projections) (Figures 1E and 1F).

#### Figure 1. Long-range corticocortical and higher-order thalamocortical projections to the mouse higher-order visual area PM.

Open in a new tab

(A) Schematic of pathways originating from the higher-order visual thalamus (lateral posterior nucleus [LP]) and multiple visual cortical regions that project to the higher-order posterior medial (PM) visual cortex.

(B) Coronal sections containing thalamocortical and corticocortical projection neurons retrogradely labeled via injection of CAV2-Cre into the PM of tdTomato reporter (Ai9) mice. Cells labeled by tdTomato send projections to the PM (dLGN, dorsal lateral geniculate nucleus; RL, rostral lateral visual cortex; AL: anterior lateral visual cortex; LM, lateral medial visual cortex). Scale bar: 500 μm.

(C) Quantification of overall cell density for thalamocortical and corticocortical projection neurons sending axons to the PM. Dotted lines connect values from individual Ai9 animals (N = 10 mice).

(D) Quantification of cell counts (normalized to the histological section with the highest cell count in each animal) along the anterior-posterior axis of the brain (relative to bregma) for each thalamocortical and corticocortical projection neuron type. Numbered arrows correspond to (B1)–(B4) (N = 10 mice).

(E) Thalamocortical (LP→PM) and corticocortical (V1→PM, LM→PM) projection axons in the PM anterogradely labeled with GCaMP6s via adeno-associated virus (AAV) injection in the corresponding presynaptic regions. Scale bar: 50 μm.

(F) Laminar distribution of axonal fluorescence intensity for each projection type (N = 4 mice per projection type).

(G) Top: schematic of in vivo imaging setup. Bottom: image from video monitoring of the mouse’s facial motion and pupil size.

(H) Fluorescence traces of Ca2+ activity from individual cell body (PM) and axon (V1→PM, LM→PM, and LP→PM) regions of interest (ROIs) imaged simultaneously with behavioral-state monitoring (locomotion speed, facial motion, and pupil size) and visual stimuli presentation.

Error bars denote SEM.

### Corticocortical and higher-order thalamocortical pathways convey distinct visual information

To directly compare the activity of corticocortical and thalamocortical inputs to the PM with that of PM neurons, we expressed the calcium indicator GCaMP in either corticocortical and higher-order thalamocortical axons terminating in PM or PM neurons and assessed the state-dependent and visually evoked activity of these inputs (Figures 1G, 1H, and S1). Compared to V1 neurons, PM neurons exhibited less selectivity for visual stimulus size and a higher sensitivity to coherent motion in the visual field (Figures S2 and S3), consistent with previous reports of enhanced motion processing in mouse dorsal visual stream areas.38,40

Using a range of visual stimulation regimes (see STAR Methods), we compared the visual response magnitudes and feature selectivity of PM cell bodies with those of V1→PM, LM→PM, and LP→PM long-range axons. Stimulus sets comprised drifting gratings varying in orientation, spatial and temporal frequency, and size, as well as dots with varying motion coherence (see STAR Methods). Across all stimulation regimes, V1→PM axons consistently exhibited the strongest sensory-evoked responses of all the afferent populations (Figure 2). Because afferent axons and PM cell bodies overall exhibited modest selectivity (Figure S3), evoked response amplitudes were calculated across all stimuli for each set (Figure 2). Whereas V1→PM axons and PM cell bodies were comparable in their visual response magnitudes, LM→PM and LP→PM axons exhibited significantly smaller visual responses for many visual stimuli (Figure 2). The results were largely similar when analysis was restricted to preferred stimuli (Figure S3Y–S3BB), with the exception of size tuning. All statistical results are listed in Table S1.

#### Figure 2. Visual responses of thalamocortical and corticocortical inputs converging in the PM.

Open in a new tab

(A) Top: ROIs of each cell type that were significantly responsive (darker colors) or non-responsive (lighter colors) to visual stimuli varying in orientation. Bottom: visual response magnitude distributions to stimuli varying in orientation for all ROIs of each cell type. Because all ROIs were poorly tuned, response magnitudes were averaged across all stimuli. (V1→PM: N = 8 animals and n = 172 ROIs; LM→PM: N = 9 animals and n = 364 ROIs; LP→PM: N = 9 animals and n = 268 ROIs; and PM: N = 9 animals and n = 579 ROIs) (PM maximum value [max. val.] = 18.0, not shown for visualization purposes).

(B) As in (A) but for stimuli varying in spatial frequency/temporal frequency/speed tuning (V1→PM: N = 10 animals and n = 183 ROIs; LM→PM: N = 9 animals and n = 348 ROIs; LP→PM: N = 10 animals and n = 303 ROIs; and PM: N = 13 animals and n = 781 ROIs) (LM→PM minimum [min.]/max. val. = −8.2/20.6).

(C) As in (A) but for stimuli varying in size (V1→PM: N = 5 animals and n = 69 ROIs; LM→PM: N = 8 animals and n = 291 ROIs; LP→PM: N = 8 animals and n = 181 ROIs; and PM: N = 6 animals and n = 228 ROIs) (LM→PM max. val. = 12.4; PM max. val. = 17.3).

(D) As in (A) but for stimuli varying in motion coherence (V1→PM: N = 7 animals and n = 200 ROIs; LM→PM: N = 7 animals and n = 301 ROIs; LP→PM: N = 10 animals and n = 376 ROIs; and PM: N = 13 animals and n = 807 ROIs) (LP→PM min. val. = −30.1; PM max. val. = 12.7).

*p < 0.05, **p < 0.01, and ***p < 0.001; semi-weighted t test; Benjamini-Hochberg correction for false discovery rate.

Corticocortical and higher-order thalamocortical projections to PM exhibited diverse visual feature selectivity. For instance, whereas PM neurons largely lacked suppression in response to increasing stimulus size, corticocortical and higher-order thalamocortical projections to PM exhibited robust surround suppression (Figures S3D, S3K, and S3S), suggesting that the lack of suppression in PM is not inherited directly from afferents but instead may arise via input integration (see also Murgas et al.41). However, the tuning properties of PM neurons were similar to those of corticocortical inputs, including V1→PM axons (Figure S3), suggesting that some visual response features may be propagated directly from presynaptic populations in upstream visual cortical areas.13

### Higher-order thalamocortical pathways convey state-related information

The spontaneous and sensory-evoked activity of neurons across the entire cortex is strongly influenced by the behavioral or arousal state. Changes in wakeful behavioral states are often associated with motor actions, such as locomotion, facial, and whisker motion, and altered pupil size.25–30,32,42–44 Although ascending neuromodulatory systems play a crucial role,24 both corticocortical and thalamocortical afferents could also be key players in cortical state modulation.45–47 We therefore considered what roles the major feedforward corticocortical (V1→PM and LM→PM) and higher-order thalamocortical (LP→PM) inputs may play in conveying state-dependent activity to PM.

PM neurons exhibited stronger state-dependent modulation than V1 neurons for locomotion (Figures S4A and S4B) and for facial motion (Figures S4C–S4E) and pupil diameter (Figures S4F–S4H) in the absence of locomotion. Consistent with this observation, V1→PM axons exhibited the weakest levels of overall state-dependent modulation (Figure 3), in direct contrast with their robust modulation by visual input. State-dependent modulation related to global arousal was stronger for higher-order thalamocortical inputs from LP (LP→PM axons) than either of the corticocortical afferents (V1→PM and LM→PM axons) (Figures 3 and S3X). Together, these results suggest that whereas corticocortical axons from the V1 carry the strongest sensory-related information to PM, higher-order thalamocortical axons from LP carry the strongest global state-related information.

#### Figure 3. Behavioral-state-dependent modulation of thalamocortical and corticocortical inputs to the PM.

Open in a new tab

(A) Example Ca2+ signal from an LP axon terminating in the PM (cyan). The bottom traces (black) show locomotion speed, facial motion (motion energy of the whisker pad), and pupil size (a.u. [arbitrary units]). Periods of sustained low or high motor activity (locomotion or facial motion) are indicated by shaded areas, and transition points from low to high motor activity are indicated by green lines. Analyses of modulation by facial motion and pupil dilation/constriction were limited to sustained periods without locomotion. Open blue boxes indicate high facial motion periods not included in the analysis of state transitions due to overlap with locomotion.

(B) Neuronal activity (Z scored ΔF/F) aligned to locomotion onset (green dotted line) and offset (red dotted line). Baseline activity (10–15 s after locomotion offset during sustained quiescent periods) is shown to the right for comparison.

(C) Locomotion modulation indices for ROIs of each cell type (V1→PM: N = 11 animals and n = 291 ROIs; LM→PM: N = 9 animals and n = 343 ROIs; LP→PM: N = 10 animals and n = 266 ROIs; and PM: N = 8 animals and n = 622 ROIs).

(D) Cross-correlation between neuronal activity (ΔF/F) and facial motion. Facial motion is the reference signal in the cross-correlation.

(E) Neuronal activity (Z scored ΔF/F) aligned to the onset of high facial motion.

(F) Peak correlation values between neuronal activity and facial motion for each cell type (V1→PM: N = 4 animals and n = 107 ROIs; LM→PM: N = 4 animals and n = 176 ROIs; LP→PM: N = 6 animals and n = 165 ROIs; and PM: N = 5 animals and n = 454 ROIs).

(G) Cross-correlation between neuronal activity (ΔF/F) and pupil size.

(H) Neuronal activity (Z scored ΔF/F) aligned to one pupil dilation-constriction cycle (derived from the Hilbert transform of the pupil signal).

(I) Peak correlation values between neuronal activity and pupil size for each cell type (V1→PM: N = 4 animals and n = 108 ROIs; LM→PM: N = 8 animals and n = 284 ROIs; LP→PM: N = 6 animals and n = 162 ROIs; and PM: N = 5 animals and n = 353 ROIs).

*p < 0.05, **p < 0.01, and ***p < 0.001; semi-weighted t test, Benjamini-Hochberg correction for false discovery rate. Error bars denote SEM.

The higher-order thalamic nucleus LP receives convergent synaptic inputs from multiple cortical and subcortical brain regions,22 as well as from multiple neuromodulatory systems.48,49 Previous anatomical work has shown that synaptic input to PM-projecting LP neurons largely arises from corticothalamic neurons in V1.22 We therefore compared the strength of the state-dependent modulation between two classes of V1 projection neurons: (1) corticocortical V1 neurons projecting directly to PM and (2) corticothalamic V1 neurons projecting to LP (Figures S4I and S4J). The somata of these pyramidal neurons largely resided in layer 5 and lower layer 6 (Figures S4K and S4L). As a proxy for calcium activity in the deep-layer somata, we imaged the calcium activity in the layer 1 apical dendrites of these neurons (Figures S4M, S4N, and S5F).50,51 Compared to V1 corticocortical projection neurons, V1 corticothalamic neurons projecting to LP exhibited stronger modulation by behavioral state, specifically for state transitions associated with dilations in pupil diameter during behavioral quiescence, a marker of fluctuations in global arousal state (Figures S4T–S4V). V1 projection neurons may thus be a key source of the strong state-dependent activity observed in LP→PM projections.

### Functional interactions between afferents and PM neurons

To examine the functional contributions of corticocortical and thalamocortical inputs to PM, we simultaneously imaged the calcium activity of PM cell bodies and the axon terminals of V1→PM, LM→PM, or LP→PM projections. To separate axons from the local neuropil, we expressed GCaMP6s in axon terminals and a soma-targeted version of GCaMP, riboGCaMP6m,52 in PM cell bodies (Figures 4A–4C). We observed very little GCaMP labeling in the axons or dendrites of PM neurons when riboGCaMP6m was expressed in these cells alone (Figure S5A). Furthermore, imaging of in vivo preparations in which only riboGCaMP6m was expressed in PM cell bodies showed a negligible neuropil signal when compared with GCaMP6s (Figures S5B–S5E). A comparison of neuropil and cell body signals suggested little cross-contamination (Figures S5F–S5H). This dual GCaMP approach allowed the simultaneous imaging of two populations from a single imaging channel.

#### Figure 4. Distinct functional interactions between thalamocortical and corticocortical afferents and PM cells.

Open in a new tab

(A) Schematic of method for simultaneously monitoring the neuronal activity of PM cell bodies and long-range projection axons terminating in the PM based on expression of GCaMP6s in long-range axon terminals and ribo-GCaMP6m in PM cell bodies.

(B) In vivo field of view with PM cell bodies expressing riboGCaMP6m and LM axon terminals expressing GCaMP6s.

(C) Fluorescence traces of Ca2+ activity simultaneously recorded in PM cell bodies expressing riboGCaMP6m and projection axons expressing GCaMP6s.

(D) Mean Ca2+ event rates among the different cell types. (V1→PM: N = 5 animals and n = 332 ROIs; LM→PM: N = 4 animals and n = 211 ROIs; LP→PM: N = 5 animals and n = 191 ROIs; and PM: N = 14 animals and n = 168 ROIs).

(E) Ca2+ event rates for each afferent population aligned to simultaneously recorded Ca2+ events in PM neurons (raw data minus data from shuffled PM event times).

(F) Peak Ca2+ event rates aligned to PM neuron Ca2+ events (V1→PM: N = 5 animals and n = 59 PM ROIs; LM→PM: N = 4 animals and n = 53 PM ROIs; LP→PM: N = 5 animals and n = 56 PM ROIs; and PM activity aligned with PM events: N = 14 animals and n = 168 PM ROIs).

*p < 0.05, **p < 0.01, and ***p < 0.001; semi-weighted t test; Benjamini-Hochberg correction for false discovery rate. Error bars denote SEM.

Using this approach, we examined the relationship between neuronal activity in PM cell bodies and V1→PM, LM→PM, and LP→PM axons during quiescent (non-locomotion) periods. After deconvolving ΔF/F calcium activity traces from axons and cell bodies into estimates of calcium events (STAR Methods), we assessed the relationship between simultaneously imaged axonal and PM somatic calcium event rates. Although overall calcium event rates in LP axons were significantly higher than those of V1 or LM corticocortical axons and PM cell bodies (Figure 4D), LP events were significantly less time-locked to events in PM cell bodies than those of corticocortical axons (Figures 4E and 4F). LP→PM activity may thus be less effective in driving PM neuron spiking than corticocortical inputs. Indeed, functional interactions between LP→PM axons and PM cell bodies were comparable with those between LP→V1 axons and V1 cell bodies, a canonical modulatory pathway (Figure S6).53,54 Calcium events in PM cell bodies were significantly more correlated with events in neighboring PM cell bodies than those in either corticocortical or thalamocortical axons (Figures 4E and 4F), potentially reflecting strong levels of recurrent connectivity within PM.55 Together, these results support a modulatory role for LP inputs to PM and a stronger driving role for short- and long-range corticocortical inputs.

### Acute silencing reveals distinct causal contributions to PM neuronal activity

To determine more precisely the contributions of each input to the activity of PM neurons, we selectively silenced individual inputs to PM while monitoring the state-dependent and visually evoked activity of PM neurons. Using Cre-dependent expression of the inhibitory opsin eOPN3,56 we silenced the axon terminals of different corticocortical and higher-order thalamocortical projections within PM. To express eOPN3 selectively in V1→PM, LM→PM, or LP→PM terminals, we injected a mixture of CAV2-Cre and AAV-GCaMP6s into the PM followed by the Cre-dependent AAV-SIO-eOPN3-mScarlet in the presynaptic target area (Figure 5A). These injections resulted in projection-specific expression of eOPN3 in axon terminals that were physically intermingled with PM cell bodies expressing GCaMP6s (Figure 5B). The relative numbers of V1→PM, LM→PM, or LP→PM projection neurons labeled in this way largely recapitulated those seen from CAV2-Cre injection in reporter animals (Figure S7), indicating that eOPN3 was not over- or under-expressed in any projection neuron class. Visual responses of PM neurons were robustly decreased by optogenetic suppression of corticocortical V1 and LM axons but only slightly affected by suppression of thalamocortical LP axons (Figures 5C, 5D, and 5G). Consistent with the strong state-dependent modulation of LP axons we observed in PM, state-dependent modulation of PM neuron activity with changes in pupil diameter was significantly reduced when LP→PM, but not V1→PM or LM→PM, terminals were inhibited (Figures 5E, 5F, 5H, and S7D–S7I). In a separate series of experiments, we selectively ablated PM-projecting neurons in either V1 or LP (see STAR Methods). Consistent with the results of optogenetic manipulation, ablation of V1→PM, but not LP→PM, projection neurons reduced visual responses in PM neurons (Figures S7J–SJP). Corticocortical and higher-order thalamocortical inputs may thus primarily confer the sensory- and state-dependent properties of PM cortical neurons, respectively (Figure 6).

#### Figure 5. Distinct contributions of cortico-cortical and thalamocortical pathways to PM activity.

Open in a new tab

(A) Schematic of viral injections for co-expressing GCaMP6s in PM cortical neurons and the Cre-dependent inhibitory opsin eOPN3 in presynaptic projection axon terminals.

(B) Left: expression of eOPN3-mScarlet (red) in thalamocortical neurons in the LP. Right: expression of GCaMP6s in PM cortical neurons (green) and eOPN3-mScarlet (red) in the surrounding LP thalamocortical terminals. Scale bar: 30 μm.

(C) Visual contrast-response curves of PM neurons in control animals and animals with eOPN3 expressed in corticocortical and higher-order thalamocortical axons for sessions with (light-emitting diode [LED]) and without (dark) optogenetic stimulation.

(D) Scatterplots showing visual response magnitudes from individual PM neurons identified during both dark and LED imaging sessions.

(E) As in (C) but for cross-correlations between PM neuronal activity and pupil size.

(F) As in (D) but for peak correlation values between neuronal activity and pupil size.

(G) Differences between visual response magnitudes during sessions with and without optogenetic stimulation (control: N = 5 animals and n = 195 ROIs; V1→PM eOPN3: N = 7 animals and n = 227 ROIs; LM→PM eOPN3: N = 4 animals and n = 215 ROIs; and LP→PM eOPN3: N = 6 animals and n = 327 ROIs) (control min./max. val. = −3.2/2.5; V1→PM eOPN3 min./max. val. = −5.3/3.1; LM→PM eOPN3 min./max. val. = −3.1/5.0; and LP→PM eOPN3 min./max. val. = −3.1/1.0).

(H) As in (G) but for differences in peak ΔF/F-pupil correlation values between sessions with and without optogenetic stimulation (control: N = 7 animals and n = 327 ROIs; V1→PM eOPN3: N = 4 animals and n = 169 ROIs; LM→PM eOPN3: N = 3 animals and n = 167 ROIs; and LP→PM eOPN3: N = 5 animals and n = 468 ROIs).

*p < 0.05, **p < 0.01, and ***p < 0.001; semi-weighted t test; Benjamini-Hochberg correction for false discovery rate. Error bars denote SEM.

#### Figure 6. Corticocortical and thalamocortical pathways may have distinct impacts on higher-order cortex.

Open in a new tab

Top: corticocortical pathways, particularly the direct input from the V1, carry strong sensory information to the higher-order visual cortex (PM), whereas higher-order thalamocortical inputs from the LP carry comparatively weak, untuned sensory signals. Bottom: corticocortical inputs to the PM carry some behavioral state information, whereas higher-order thalamocortical inputs from the LP convey strong behavioral-state-related signals that may reflect their presynaptic corticothalamic inputs from the V1.

## DISCUSSION

We examined the sensory responses and behavioral-state-dependent modulation of activity in two lower-order visual cortical areas, V1 and LM, and a higher-order thalamocortical area, LP, that converge on a common higher-order visual cortical area, PM. Overall, we find that while corticocortical projections carry strong sensory information and significantly impact the visually evoked responses of their postsynaptic targets in PM, higher-order thalamocortical signals from LP do not strongly contribute to PM visual responses. In contrast, direct cortico-cortical inputs from V1 and LM do not drive state-dependent modulation in PM, whereas inputs from LP contribute to the representation of global arousal by PM neurons, as measured by pupil diameter. Together, these results suggest two streams conveying sensory and contextual information to the higher-order cortex.

Unlike first-order thalamic nuclei, which receive their driving synaptic input from the sensory periphery or associated brainstem nuclei, most higher-order thalamic nuclei receive their strongest input from the cortex. Anatomical connectivity suggests that whereas first-order thalamic nuclei (e.g., dLGN) predominately function as sensory relays, albeit under dynamic modulatory control from the cortex,33,34,57 higher-order thalamic nuclei (e.g., pulvinar) relay the results of computations carried out within local cortical networks. Like the first-order thalamus, which encodes low-level sensory information from the sensory periphery, higher-order thalamic nuclei may encode integrated sensory information that is propagated across the cortex.58 Alternatively, higher-order thalamic nuclei may predominantly convey non-sensory contextual information or reconfigure the cortical circuits to which they project.59 Previous work has suggested that the broad tuning properties of higher-order visual thalamic outputs seem inadequately suited to generate the highly specific receptive fields of extrastriate neurons60 but may instead play an essential role in modifying the functional connectivity of distributed cortical regions in a task- or context-dependent manner.61–63

Targeted imaging of corticocortical inputs to PM and PM neurons revealed robust visual responses.22,41,64 Overall, PM neurons exhibited low selectivity for stimulus orientation, enhanced motion sensitivity, and almost no surround suppression as compared to V1 neurons. We found that PM neurons exhibited enhanced tuning for high spatial frequencies.22,64 We observed less overall selectivity of PM neurons for visual features compared to some previous reports, but these differences may reflect different inclusion criteria, calcium indicators, and use of anesthesia.64–66 Observational experiments have revealed that LP neurons exhibit visual responses, but the postsynaptic impact of this visual activity is unclear. In good agreement with previous studies,22,67 we observed that LP afferents to the PM showed visual responses but with low selectivity for stimulus orientation and little size tuning. However, LP afferents exhibited high levels of activity but little correlation with the activity of individual PM neurons, consistent with a modulatory, rather than driving, role for higher-order thalamic inputs. Indeed, suppression of LP afferents did not change PM visual responses. Thus, although individual LP axons exhibit modest visual responses, these afferents do not appear to play a critical role in the visual responses of postsynaptic PM neurons. In contrast, we found that the suppression of afferents from V1 and LM strongly reduced PM visual responses. Convergent lines of evidence from the ablation of projection neurons in LP and V1 likewise supported a role for V1, but not LP, in driving PM visual responses. Together, these results suggest that some visual information carried by afferents to PM may be redundant. Alternatively, despite exhibiting visual responses, the temporal dynamics or synaptic properties of LP→PM inputs may minimize the transmission of rapidly modulated visual activity while permitting the transmission of slow time-varying fluctuations related to behavioral context or global arousal state. Reduced visual response amplitudes could potentially result from net decreases in PM neuronal excitability due to the loss of excitatory input. However, we found that the suppression of corticocortical inputs did not affect the state-dependent modulation of PM neurons, suggesting a selective role for these projections in providing visual information to the PM.

The activity levels and functional connectivity of primary and higher-order cortical areas are modulated by both global arousal state and motor activity.23,24,27,29 Indeed, previous work has highlighted the independent modulation of cortical activity by locomotion and global arousal state as measured by pupil diameter,28 and recent findings have further detailed a tight association between periods of moderate arousal, facial movement, and cholinergic signaling in the cortex.24 Surprisingly, we found that PM neurons were more strongly modulated by changes in behavioral state, as measured by locomotion, facial motion, and pupil dilation, than the general population of V1 neurons or any individual direct afferent pathway. This strong representation of behavioral state information by PM neurons may facilitate the previously reported non-visual roles of PM in visually guided tasks.68,69 LP inputs to PM exhibited more robust sensitivity to behavioral-state variables than either V1 or LM inputs, suggesting that the higher-order thalamus may provide a key source of state information to PM. Indeed, LP thalamocortical activity was robustly linked to global arousal, as assessed by pupil diameter, and optogenetic inactivation of LP terminals reduced the modulation of postsynaptic PM neurons by pupil dilation but had no effect on modulation by locomotion. Consistent with a contextual role for LP, recent work found that LP thalamocortical axons projecting to the higher visual cortex do not encode a detailed representation of optic flow, which is signaled by corticocortical axons, but rather encode discrepancies between optic flow and self-motion.22 Corticocortical afferents may thus be a principal conduit of feedforward sensory information between cortical areas, whereas higher-order thalamocortical axons may primarily contribute state-dependent contextual modulation of this sensory signaling.70,71

Deep-layer cortical projection neurons may be a major source of the state-dependent modulation of LP activity. Although V1 projects to both PM and LP, these pathways arise from distinct populations of projection neurons with different properties.31,72 We found that V1 layer 5 corticothalamic neurons that project to LP are more strongly modulated by the behavioral state than corticocortical projection neurons. Previous work has likewise highlighted a potential role for corticothalamic projections in conveying locomotion modulation signals from the V1 to the LGN.34 Additional presynaptic sources may further amplify the unique state-dependent properties of LP thalamocortical neurons. In addition, some state-dependent modulation of LP activity may arise from the superior colliculus, which regulates pupil dilation and orienting responses.73,74 Previous work has identified several neuromodulatory systems75,76 and GABAergic pathways77,78 that selectively interact with higher-order thalamocortical neurons. Global arousal information may also reach LP via corticothalamic neurons in the deepest part of cortical layer 6, which project exclusively to the higher-order thalamus79 (see also Figures S4C and S4D). Deep layer 6 corticothalamic neurons are sensitive to the wake-promoting neuropeptide orexin,80 which is strongly coupled to pupil-linked arousal.81 Neuromodulatory signaling to corticothalamic neurons may thus regulate a selective channel for behavioral-state information from V1 to LP, potentially contributing to the strong correlation between pupil fluctuations and LP activity.

Our current results pertain to long-range synaptic inputs to a specific region of the higher-order mouse visual cortex, area PM. However, the mouse visual system consists of more than 10 distinct cortical processing regions downstream of V1.82 These regions have specific hierarchical relationships and communicate in both feedforward and feedback directions.9,37,83,84 Furthermore, analogously to the primate pulvinar,85 the mouse LP contains multiple retinotopically organized subdivisions.67 The functional role of LP in corticocortical communication may therefore differ depending on the hierarchical positions of the postsynaptic cortical regions.86 For instance, whereas LP input to V154 and medial higher visual areas (such as the PM) may primarily convey contextual and behavioral-state signals, LP input to lateral higher visual areas (such as the post-rhinal cortex) may instead convey robust and precise visual information.87 LP thalamocortical neurons might also have distinct functions based upon which specific pre- and postsynaptic cortical areas they serve to connect. Indeed, previous work found that whereas LP afferents to anterior lateral visual cortex (AL) were sensitive to changes in optic flow and suppressed by locomotion, LP afferents to PM were variably modulated by both signals.22 Finally, our data highlight potential contributions of LP afferents to local circuits in layer 2/3 of PM, but previous studies have suggested that long-range projections to different layers may carry distinct information,22,88,89 raising the possibility of different roles for LP projections to layer 1 or 5 in PM. However, the synaptic mechanisms by which higher-order thalamocortical inputs are integrated with direct corticocortical inputs within the cortex and how this integration may contribute to circuit function in different areas or cortical layers remain to be explored.

Previous work has shown that activity in ascending neuromodulatory pathways, such as those releasing acetylcholine and norepinephrine, may be linked to pupil-related global arousal.30 Neuromodulatory pathways may also carry motor-related signals, such as locomotion and facial motion.24,90 Our current results indicate that higher-order thalamocortical axons can convey state-modulated signals reminiscent of canonical neuromodulatory pathways. Future work will be required to disentangle the precise contributions of these different afferent pathways to both global and local state-dependent reconfigurations of cortical networks. Overall, our findings identify cortico-cortical and higher-order thalamocortical inputs that convey distinct information streams to the higher-order cortex. We find that corticocortical pathways convey robust sensory information to area PM, whereas higher-order thalamocortical inputs from LP primarily provide behavioral-state information. Higher-order thalamocortical inputs may thus serve as a modulatory route by which contextual information shapes the dynamic functional interactions between cortical regions and the integration of sensory information to guide behavioral output.

### Limitations of the study

In the current study, we measured the activity of deep-layer neurons in V1 by recording fluorescence in dendritic branches. Previous work has shown that nearly all dendritic calcium activity is driven by back-propagating action potentials, making this a good readout of somatic activity.50 However, it is possible that our analysis includes some activity originating in the dendrites in response to synaptic inputs. We imaged neurons and afferent corticocortical and thalamocortical axons in layer 2/3 of PM. Thalamocortical projections also target apical dendrites in superficial layer 1, and it is possible that distal dendritic inputs may convey distinct information to postsynaptic neurons in PM. However, it is likely that LP inputs to both layer 1 and layer 2/3 dendrites exert modulatory effects on PM neurons. It is possible that projections to layer 1 are over-represented in our histological dataset due to tropism of the viral vectors for particular classes of projection neurons. Finally, because calcium imaging does not provide direct insight into synaptic interactions, our data highlight functional connectivity between long-range projections and postsynaptic targets rather than synaptic connectivity. However, because our eOPN3 manipulation regulated the release of synaptic vesicles from presynaptic terminals within PM,56 the resulting data specifically highlight local interactions between corticocortical afferents, higher-order thalamocortical afferents, and PM neurons. Light transmission to deeper cortical layers may be reduced compared to superficial layers, suggesting that our optogenetic effects could primarily arise from the selective suppression of LP afferents to PM in superficial layers. Robust suppression of inputs can change the activity of postsynaptic neurons due to a loss of overall excitation rather than reduction in a selective input. To avoid this issue, we endeavored to use levels of optogenetic manipulation that allowed our data to remain within the physiological range of normal circuit function.

eOPN3 is now a commonly used tool for systems neuroscience, and recent results suggest a wide range of effective light stimuli for long-term activation. Initial results (Mahn et al.56) and more recent efforts have found a half-life of efficacy around 5–6 min in vivo. In the current study, we illuminated terminals in PM for 1 s at moderately high power (30 mW/mm2) every 2 min. This is within the range of other recent studies using eOPN3 for in vivo suppression of synaptic release. Recent studies have used a range of illumination protocols, including 4 s every 60 s, 30 s every 2.33 min, and 15 s every 5 min.91–93 Notably, substantial suppression has been observed even following short pulse durations at low power.92 It is highly unlikely that any optogenetic suppression will be complete,94 and we therefore do not expect that our optogenetic manipulation equates to a total silencing of afferents. However, the existing evidence overwhelmingly indicates that eOPN3 is effective over a moderately long time course such as that used in the current study.

We examined the modulation of afferent populations and PM neurons by behavioral state using pupil diameter, facial motion, and locomotion as indicators of changes in the internal state of the animal. In the analysis presented in the current study, visual response data were not separated according to behavioral state. Although we assessed state-dependent modulation during periods when visual stimuli were also presented, visual stimuli were randomly interspersed with respect to transitions in behavioral state and thus unlikely to bias results. The role of cortico-cortical and thalamocortical inputs in regulating state-dependent visual response gain is a topic of considerable interest for future exploration.

## RESOURCE AVAILABILITY

### Lead contact

Further information and requests for resources and reagents should be directed to Jessica A. Cardin (jess.cardin@yale.edu).

### Materials availability

No new reagents were generated as a result of this study.

### Data and code availability

-
Data reported in this paper and any additional information required are available from the lead contact upon request.

-
All original code is available at https://github.com/cardin-higley-lab/CC_TC_Neske_Project.

-
Any additional information required to reanalyze the data reported in this paper is available from the lead contact upon request.

## STAR★METHODS

### EXPERIMENTAL MODEL AND SUBJECT DETAILS

#### Animals

All animal handling and maintenance was performed according to the regulations of the Institutional Animal Care and Use Committee of the Yale University School of Medicine. Adult male and female C57BL/6J mice (The Jackson Laboratory, strain #000664) aged 10–14 weeks were kept on a 12h light/dark cycle, provided with food and water ad libitum, and housed individually following head-post implants. In a subset of experiments, adult male and female Ai9 mice (The Jackson Laboratory, strain #007909) were used. All experiments were performed during the light cycle.

### METHOD DETAILS

#### Surgical procedures

Surgeries were performed in adult mice in a stereotaxic frame, anesthetized with 1–2% isoflurane mixed with pure oxygen. Eyes were protected throughout the surgery with ophthalmic ointment (Puralube). After providing an intraperitoneal injection of Carprofen (5 mg/kg), a midline incision along the scalp was made to expose the skull. Small burr holes in the skull were made in stereotaxic coordinates to introduce viral vectors into multiple brain regions of interest– (mm lateral [L], posterior [P], and ventral [V] from bregma) LP thalamus: 1.6 L, 2.06 P, 2.7 V; PM visual cortex (2 sites): 1.8L, 2.7P, 0.4V & 1.5L, 2.9P, 0.4V; V1 visual cortex (3 sites): 2.5L, 3.5P, 0.4V & 3.0L, 3.5P,0.4V & 2.5L, 4.0P, 0.4V; LM visual cortex: 4.0L, 3.5P, 0.4V. Pulled glass capillaries were connected to a microinjection system (Stoelting Quintessential Stereotaxic Injector) to deliver viral vectors into the brain at a rate of 40–70 nL per minute, with a total volume of 100–200 nL per injection site. To express the calcium indicator GCaMP6s in neuronal cell bodies or long-range projection axons either AAV5-Syn-GCaMP6s or AAV1-Syn-GCaMP6s (1×1013 gc/mL; Addgene #100843) was injected into the relevant brain region. For experiments requiring expression of the soma-targeted GCaMP variant (riboGCaMP) in PM cell bodies, AAV9-Syn-GCaMP6m-RPL10a (1×1013 gc/mL; Addgene #158777) was injected into PM. For experiments requiring Cre-dependent optogenetic silencing of axon terminals within PM while imaging PM cell bodies, CAV2-Cre (1×1013 gc/mL; CRNS Plateforme de Vectorologie de Montpellier) was mixed in a 1:10 ratio with AAV5-syn-GCaMP6s and injected into PM and AAV5-Syn-SIO-eOPN3-mScarlet (2×1013 gc/mL; Addgene #125713) was injected into either LP, V1, or LM. All viruses were allowed to express for at least 3 weeks prior to experiments.

For headpost implantation, mice were anesthetized with isoflurane and the scalp was cleaned with Betadine solution. An incision was made at the midline and the scalp resected to each side to leave an open area of the skull. After cleaning the skull and scoring it lightly with a surgical blade, a custom titanium head post was secured with C&B-Metabond (Butler Schein) with the left PM or V1 centered. Two skull screws (McMaster-Carr) were placed at the right anterior and posterior poles (bilateral to the injection site). A 3×3-mm craniotomy was made over the left PM or V1. A glass window made of a 3×3-mm square inner coverslip adhered with an ultraviolet-curing adhesive (Norland Products) to a 5 mm-diameter round outer coverslip (both #1, Warner Instruments) was inserted into the craniotomy and secured to the skull with Cyanoacrylate glue (Loctite). A circular ring was attached to the titanium headpost with glue, and additional Metabond was applied to cover any exposed skull and to cover each skull screw. Analgesics were given immediately after surgery (5 mg/kg Carprofen and 0.05 mg/kg Buprenorphine) and on the two following days to aid recovery. Mice were given a course of antibiotics (Sulfatrim, Butler Schein) to prevent infection and were allowed to recover for 3–5 days following implant surgery before beginning wheel training.

#### Histology

For histological preparation of brain sections, mice were deeply anesthetized with isoflurane and transcardially perfused with PBS followed by 4% PFA in PBS. Perfused brains were extracted and postfixed overnight at 4°C. 40-μm coronal sections were then prepared from the fixed brains using a vibratome (Leica VT1000 S). Free-floating sections were then mounted to microscope slides, coated with mounting medium (ProLong Gold Antifade Mountant with DAPI, Invitrogen) and sealed with cover glass. Epifluorescence and confocal images of brain sections were taken with a Zeiss Axio Imager 2 and Zeiss LSM 900, respectively.

#### Calcium imaging

Calcium indicators in neuronal cell bodies and axon terminals within the cortex were imaged with a 2-photon Movable Objective Microscope (MOM) equipped with a galvo-resonant scanner (Sutter Instruments) through a 25x, 1.05 NA objective (Olympus). 2-photon excitation of the calcium indicators was achieved by scanning the output of a Ti-sapphire laser (MaiTai eHP DeepSee, SpectraPhysics) tuned to 920 nm. Emitted fluorescence was collected by a PMT (H10770PA-40, Hamamatsu) and digitized into image series with ScanImage software (Vidrio) at ~30 Hz at a resolution of 256×256. To prevent light contamination from the display monitor, the microscope was enclosed in blackout material that extended to the headpost.

All calcium imaging was performed through a cranial window in awake, head-fixed mice that could freely run on a cylindrical wheel. Wheel speed was monitored by a magnetic angle sensor (Digikey). Before calcium imaging data were collected, mice were habituated to head-fixation for several days to ensure they spontaneously engaged in sustained locomotion bouts with normal posture. During calcium imaging experiments, the mouse’s face was illuminated with an IR LED array and facial video was acquired with a miniature CMOS camera (Blackfly s-USB3, Flir) at a frame rate of 10 Hz. All data acquisition signals (laser scanner frame times, wheel signal, and video camera frame times) were digitized at 5 kHz using a Power1401 data acquisition system (CED).

Imaging of cell bodies and axon terminals in layer 2/3 was performed at 150–350 μm depth relative to the brain surface, while imaging of apical dendrites in layer 1 was performed at 50–100 μm depth. For each mouse, 1–4 fields of view were imaged. During each session, spontaneous activity was collected for 10 min before the series of visual stimuli were presented, and 10 min after (20 min total) as the mouse freely moved on the wheel in front of a mean-luminance gray screen.

#### Optogenetic stimulation

For imaging sessions in which projection axons expressing the inhibitory opsin eOPN3 were optically stimulated, a two-session experimental design was used to compare conditions with and without optical stimulation. Since eOPN3 has a relatively long and potentially variable time constant for inactivation (~5 min56), it is not well suited to traditional experimental designs using optogenetics in which control periods and periods with optical stimulation are interleaved throughout a session. Imaging data were therefore first collected during a session in which no optical stimuli were given (“Dark” session). After the end of this control session, the mouse was returned to its home cage for ~2 h. This waiting period ensured that residual effects of neuronal adaptation to visual stimulation did not carry over from one session to the next. After the waiting period, the mouse was placed back on the imaging set-up and the same field of view was imaged for a second session (“LED” session). During this session, light from a green LED (M530L3–530 nm, Thorlabs) was triggered with a 1-s TTL pulse, directed through the epifluorescence path of the Sutter MOM and reflected through the objective to produce widefield illumination onto the cranial window (~1 mm spot diameter, ~30 mW/mm2). This 1-s optical stimulus was given every 2 min throughout the session during intermittent pauses in scanning. Comparisons between neuronal properties were then made between the first and second imaging session to assess the effects of optogenetic manipulation.

#### Cre-dependent ablation

For Cre-mediated ablation of specific corticocortical pathways and higher-order thalamocortical pathways projecting to area PM, we injected ~200 nL CAV2-Cre into PM and ~200 nL AAV5-flex-taCasp3-TEVp (7×1012 vg/mL) (Yang et al., 2013) into either LP or V1. For histological verification of caspase-mediated cell death in these projection neurons, these injections were performed in Ai9 animals with within-brain control injections: one hemisphere injected with CAV2-Cre in PM and caspase in V1/LP and the other hemisphere injected with CAV2-Cre in PM and equal volume of sterile saline in V1/LP. After 3 weeks of expression, histological brain sections were analyzed for tdTomato-positive cells in V1/LP of each hemisphere. For in vivo calcium imaging experiments, CAV2-Cre was mixed in a 1:10 ratio with AAV5-syn-GCaMP6s and injected into PM and either AAV5-flex-taCasp3-TEVp (experimental animals) or saline (control animals) was injected into V1/LP. Calcium imaging was performed after 3 weeks of viral expression.

#### Visual stimulus presentation

Visual stimuli were presented on a 43 cm × 24 cm gamma-corrected LCD monitor (model B206HQL Aymph, Acer) positioned 45° from the mouse’s midline, with the center of the monitor located 18 cm from the mouse’s eye. The monitor subtended ~100° azimuth/67° elevation of the mouse’s visual hemifield. A photodiode (model #SM1PD1B, Thorlabs) was fixed to the lower right corner of the monitor and connected to the Power1401 to allow precise recordings of visual stimulus onset times. Visual stimuli were generated and synchronized with the 60 Hz refresh rate of the monitor using MATLAB-based Psychtoolbox software.95 Visual stimuli were 2 s in duration and consisted of either drifting sine-wave gratings of varying orientation, drift direction, size, spatial frequency, or temporal frequency or random dot kinematograms (RDKs). RDKs consisted of randomly positioned white circles (4° diameter) on an isoluminant gray background, such that 20% of the background was occupied by the circles. Each circle was then allowed to drift (80°/s) in a random direction based on the value of percent motion coherence chosen for a given 2-s visual stimulus. For all types of visual stimuli, the time between the end of one visual stimulus and the onset of the next (i.e., inter-stimulus interval) was 5 s.

#### Data analysis

##### Cell counts and fluorescence intensity quantification in histological sections

Fluorescently labeled cells were counted manually in each histological section. Sections were aligned to bregma based on the detection of a small volume (<50 nL) of red retrobeads (Lumafluor) injected into the brain at the anterior-posterior coordinate of bregma immediately before transcardial perfusions as a fiducial marker. Fluorescently labeled cells were assigned to specific brain regions based on alignment with coronal sections in the Paxinos-Franklin mouse brain atlas and previously reported coordinates.96,97 To calculate the total cell density in each brain region, the total number of cells counted in that region was divided by an estimate of its total volume, computed by numerical integration of the cross-sectional areas of the portions of each section corresponding to the brain region. Normalized cell count as a function of anterior-posterior distance from bregma was calculated by dividing the cell count associated with a given histological section by the highest cell count among all the sections from a given animal. To calculate the relative proportions of projections to PM for each mouse, we put the total number of tdTomato-positive cells counted across all areas in the denominator and the total number of tdTomato-positive cells counted in V1 and LM in the numerator and multiplied by 100 to yield the percentage that V1 and LM contribute to the feedforward projections to PM. Fluorescence intensity of axonal or dendritic labeling was measured in 10- or 5-μm bins across the laminar depth of the cortex relative to the pia for whole-cortex and layer 1 measurements, respectively. Mean normalized laminar fluorescence intensity for a given animal was calculated by dividing all fluorescence intensities by the highest fluorescence intensity for that animal and then averaging resulting normalized fluorescence vs. depth data from all sections in that animal.

##### Wheel position and change-points

Wheel position was determined from the output of the linear angle detector. The circular wheel position variable was first transformed to the [−π, π] interval. The phases were then circularly unwrapped to yield running distance as a linear variable, and locomotion speed was computed as a differential of distance (cm/s). A change-point detection algorithm detected locomotion onset/offset times based on changes in standard deviation of speed. Locomotion onset or offset times were estimated from periods when the moving standard deviations, as determined in a 0.5-s window, exceeded or fell below an empirical threshold of 0.1. Locomotion trials were required to have average speed exceeding 0.5 cm/s and last longer than 1 s. Quiescence trials were required to last longer than 2 s and have an average speed <0.5 cm/s.

##### Quantification of calcium signals

Analysis of imaging data was performed using ImageJ and custom routines in MATLAB (Mathworks). Motion artifacts and drifts in the Ca2+ signal were corrected with the moco plug-in in ImageJ,98 and regions of interest (ROIs) were selected as previously described.31,72,99–101 All pixels in each ROI were averaged as a measure of fluorescence, and the neuropil signal was subtracted. ΔF/F was calculated as (F-F0)/F0, where F0 was the lowest 10% of values from the neuropil-subtracted trace for each session.

For some analyses (Figure 4; Figure S6), ΔF/F signals were deconvolved to estimate the times of underlying Ca2+ events. The AR1 FOOPSI algorithm in the Oasis toolbox102 was used to find the optimal convolution kernel, baseline fluorescence, and noise distribution. Ca2+ events were then detected as times at which the deconvolved signal increased beyond 3 standard deviations. Time-varying Ca2+ event rates were then computed as

| R(t)=∑i=1nwt-ti| (Equation 1)

where tj indicates the time at which a Ca2+ event occurred for n events in a recording, and w is a sliding Gaussian window,

| w(τ)=12πσwexp-τ22σw2| (Equation 2)

where σw=100ms.

##### Cellular ROI selection

Image series collected from 2-photon calcium imaging were corrected for motion artifacts using the moco plug-in on ImageJ.98 ROIs corresponding to cell bodies or axon terminals within the imaging field of view were chosen with a semi-automated procedure using mean- or max-projections of the imaging series.99–101,103 All pixels within an ROI were averaged as a measure of fluorescence. To correct for fluorescence originating from neuropil potentially contaminating the ROI signal, a group of pixels corresponding to a ~20 μm region around each ROI (excluding all selected ROIs) was averaged and subtracted from the ROI signal at each time point:

| Fcorrected(t)=Fraw(t)-0.7×Fneuropil(t)| (Equation 3)

From these neuropil-corrected raw fluorescence traces for each ROI, calcium activity was quantified as ΔF/F:

| ΔFF(t)=Fcorrected(t)-F0(t)F0(t)| (Equation 4)

where F0(t) is a sliding 10th percentile of the raw fluorescence distribution, with a sliding window 60 s in width.

For ROIs corresponding to axon terminals, additional efforts were made to minimize inclusion of redundant ROIs that putatively belong to the same neuron in the presynaptic source region. Whereas redundancies in cell body ROIs are highly unlikely (i.e., 2 or more ROIs corresponding to the same neuronal cell body), ROIs for axon terminals could suffer from redundancy due to axonal branching. In order to minimize the number of redundant axon terminal ROIs in our dataset, we used a procedure based on activity correlations. For this procedure, we first generated a dataset derived from axonal calcium imaging sessions consisting of axon segments that were unambiguously part of the same stretch of axon (“sub-ROIs”). For all such sub-ROI pairs within an imaging field of view, we then calculated the partial correlation of their activity throughout the entire imaging session, subtracting the mean value of all pairwise correlation values from each raw pairwise correlation. The resulting distribution of partial correlation values corresponds to the case in which all axon terminal ROIs in a dataset are actually from the same neuron. We then compared this distribution of sub-ROI partial correlation values with that of the partial correlation values between axon terminal ROIs that were considered to belong to different neurons based upon structural images (i.e., terminals that were non-contiguous within the field of view). Based on an analysis of the distributions of correlations for ROIs and sub-ROIs (Figure S1), a partial correlation value of 0.3 was the most conservative threshold for separating these distributions in our datasets. Thus, in our larger dataset of axon terminal ROIs, if any 2 ROIs exhibited partial correlations ≥0.3, one of the ROIs was discarded as putatively redundant and not included in further analysis. This method was also applied to eliminate putatively redundant ROIs from experiments in which we imaged apical dendrites from pyramidal neurons arborizing in layer 1 (Figure S1; Figure S4).

##### Quantification of visual responses and visual feature selectivity

Prior to imaging sessions used for characterizing neuronal visual responses, the population receptive field for the ROIs in a field of view was mapped by partitioning the LCD monitor into a 3×3 grid and presenting binarized Gaussian noise stimuli104 within each patch in the grid. In subsequent imaging experiments using a given field of view, the monitor was positioned such that it was centered at the location within the visual field that elicited the largest visual responses from the neuron ROIs during these initial receptive field mapping sessions. With the exception of size tuning and motion coherence protocols (see below), visual stimuli were ~40° in diameter.

For ROIs corresponding to cell bodies or axon terminals, visually evoked response magnitude was quantified as the mean z-scored ΔF/F during a 2-s visual stimulus, with the mean and standard deviation of the ΔF/F signal during a 1-s baseline period prior to visual stimulus onset used for z-scoring. The overall visual response magnitude for a given ROI was the mean visually evoked z-scored ΔF/F averaged across all visual stimulus presentations during an imaging session. ROIs were considered significantly visually responsive if ΔF/F values during visual stimulation periods were significantly larger than ΔF/F values during 1-s periods before visual stimulus onset (p < 0.05, Student’s t-test). Calculation of selectivity for different visual features is described below. Visual trials were not separated by behavioral state.

###### Orientation/direction selectivity.

To calculate an ROI’s selectivity for the orientation and direction of drifting sine-wave gratings, 12 different drift directions were presented during imaging sessions (evenly spaced between 0° and 352°). The temporal frequency of the gratings was 1 Hz and the spatial frequency was either 0.05, 0.085, or 0.12 cycles/°. Each combination of drift direction, temporal frequency, and spatial frequency was randomly repeated 10x during an imaging session. For each ROI, orientation selectivity was quantified by Lori=[1-CircularVariance]105:

| Lori=∑kRθke2iθk∑kRθk| (Equation 5)

where Rθk is the mean visual response magnitude to drift direction θk, and direction selectivity was quantified by Ldir=[1–DirectionalCircularVariance]:

| Ldir=∑kRθkeiθk∑kRθk| (Equation 6)

###### Spatial frequency, temporal frequency, & speed tuning.

To calculate an ROI’s tuning for visual spatial frequency (SF), temporal frequency (TF), and speed, the spatial and temporal frequencies of sine-wave gratings drifting at 0° were varied approximately in octaves (SF: 0.02, 0.04, 0.08, 0.16, 0.32 cycles/°; TF: 0.5, 1, 2, 4, 8, 15, 24 Hz) and each SF-TF combination was randomly repeated 15x during an imaging session. Each ROI’s response to a specific SF or TF was computed as the mean visual response magnitude for each presentation of that SF or TF. Different SF-TF combinations corresponded to different speeds (in °/s), which was calculated as the ratio between TF and SF. Each ROI’s response to a specific speed was thus computed as the mean visual response magnitude for a unique ratio between TF and SF. To quantify the preferred SF, TF, and speed for a given ROI, visual responses as a function of either SF, TF, or speed were fit to log-Gaussian models106:

| Rx=Rmax,xexp-log2x-log2x022σx2| (Equation 7)

where x is either SF, TF, or speed and Rmax,x,x0, and σx are parameters fit by nonlinear optimization. SF, TF, and speed tuning curves were considered well-fit if the model R2 was greater than 0.8. In this model, x0 corresponds to preferred SF, TF, or speed.

###### Size tuning.

To calculate an ROI’s tuning for visual stimulus size, the diameter of drifting sine-wave gratings within the population receptive field was varied between 7° and 75° in increments of 10°. The temporal frequency of the gratings was 1 Hz, the spatial frequency was either 0.05, 0.085, or 0.12 cycles/°, and the drift direction was in either of the 4 cardinal directions. Each combination of size, temporal frequency, spatial frequency, and drift direction was randomly repeated 4x during an imaging session. The amount of surround suppression exhibited by an ROI was calculated from its size-tuning curve as a suppression index (SI):

| SI=RMaxSize-RMaxResponseRMaxResponse| (Equation 8)

where RMaxSize is the magnitude of the response for the maximum size in stimulus set (75°) and RMaxResponse is the magnitude of the maximum response across all stimulus sizes.

###### Motion coherence selectivity.

To characterize an ROI’s selectivity for coherent motion within the visual field, full-screen random dot kinematograms (RDKs) (see “Visual stimulus presentation”) were presented in which the percent motion coherence was varied among 8 values (20, 25, 31, 40, 50, 63, 79, 100%). For each percent motion coherence value, drift direction could be in either of the 4 cardinal directions. Each combination of percent motion coherence and drift direction was randomly repeated 15x during an imaging session. For each ROI, the drift direction that elicited the largest visual responses was chosen as that ROI’s preferred direction and visual responses as a function of motion coherence were analyzed for that drift direction. To quantify an ROI’s selectivity for coherent visual motion, the Pearson correlation coefficient between a vector of visual responses for each motion coherence value and a vector of the corresponding motion coherence values was calculated.40

##### Quantification of modulation of neuronal activity by locomotion

For calculation of locomotion modulation index (LMI), only locomotion bouts occurring after and before at least 15 s of quiescence were used. LMI for each ROI was calculated as

| LMI=CaL-on-CaQCaL-on+CaQ| (Equation 9)

where CaL-on is the mean ΔF/F during the 4 s following locomotion onset and CaQ is the mean ΔF/F during the 10–15 s after locomotion offset.

##### Quantification of modulation of neuronal activity by pupil size

From video of the mouse’s face, pupil size of the non-visually-stimulated eye was computed from individual video frames. Frames were first cropped to a region around the eye and image pixels were binarized such that the majority of the pixels within the pupil were white and the majority of the pixels outside of the pupil were black (the IR light from the Ti-sapphire laser that escapes through the mouses eye causes the pupil to appear white when captured by the camera). Canny edge detection was then used on the binarized image frames to detect edges of the pupil. Pupil size was then estimated as the authalic diameter of the area enclosed by the detected edges (i.e., the diameter of a circle with the same area).44

All analyses relating neuronal activity to pupil fluctuations were restricted to quiescent (i.e., non-locomotion) periods of imaging sessions. Visual stimuli were randomly presented throughout the session and these periods were not excluded from the overall analysis. To relate pupil dilation and constriction to fluctuations in neuronal activity, the time series of pupil size was bandpass-filtered between 0.1 and 1 Hz. The bandpass-filtered signal of pupil size was converted to phase of the pupil dilation-constriction cycle through a Hilbert transform, which transforms the signal into a time series of complex numbers. The inverse tangent of the ratio between the imaginary and real parts of the complex number at each time point yields the phase of the bandpass-filtered pupil signal. To quantify neuronal activity as a function of the phase of the dilation-constriction cycle, ΔF/F time series for each ROI were also band-pass-filtered between 0.1 and 1 Hz. These bandpass-filtered ΔF/F signals were then z-scored using baseline periods associated with minimal changes in pupil size and small baseline pupil diameter. Specifically, these baseline periods needed to be associated with a mean of the bandpass-filtered pupil signal that was less than 1.5x the interquartile range of this signal and a mean pupil size that was within the bottom 25th percentile of the distribution of pupil sizes observed during quiescent periods during a given session. The mean and standard deviation of the bandpass-filtered ΔF/F signal during these baseline periods was used for z-scoring the ΔF/F signal. For each dilation-constriction cycle, z-scored ΔF/F for each ROI was then averaged in bins of width π/32 from −π to π. Only dilation-constriction periods larger than a threshold of 1.5x the interquartile range of the bandpass-filtered pupil signal were analyzed.

To calculate cross-correlations between neuronal activity and pupil fluctuations, both the time series of pupil size and the time series of ΔF/F for each ROI were lowpass-filtered at 10 Hz. Correlations between these signals were then computed at different lags in 100-ms increments in a time window of 8 s, using the pupil signal as the reference signal. The strength of the modulation of ΔF/F by pupil size for each ROI was quantified as the value of the peak cross-correlation between ΔF/F and pupil size.

##### Quantification of modulation of neuronal activity by facial motion/whisking

From video of the mouse’s face, a region consisting of the nose, mouth, and whisker pads was cropped from each frame. A region of interest was then drawn around the whisker pad and facial motion energy was calculated as the absolute value of the difference in average pixel intensity of the whisker pad between successive image frames. Onset times of facial motion bouts were computed by first z-scoring the entire time series of facial motion energy. High and low thresholds of facial motion energy were then defined as the 60% and 40% quantiles of the z-scored facial motion energy distribution during quiescent periods. After smoothing the time series of z-scored facial motion energy with a 1-s moving-average filter, high and low facial movement states were defined as periods in which the smoothed signal remained above or below the high and low threshold levels for at least 500 ms. Onset of a facial motion bout was then defined as the time at which a high facial motion state was preceded by at least 4 s of a low facial motion state. ROI calcium activity aligned to these onsets was z-scored using the mean and standard deviation of the ΔF/F during low facial motion periods. As for pupil diameter, facial motion data were measured during imaging sessions where visual stimuli were randomly presented.

To calculate cross-correlations between neuronal activity and facial motion, both the time series of facial motion energy and the time series of ΔF/F for each ROI were lowpass-filtered at 10 Hz. Correlations between these signals were then computed at different lags in 100-ms increments in a time window of 8 s, using the facial motion energy as the reference signal. The strength of the modulation of ΔF/F by facial motion for each ROI was quantified as the value of the peak cross-correlation between ΔF/F and facial motion energy.

##### Calculation of Ca2+ event-triggered averages

For data shown in Figures 4E and 4F and Figures S6B and S6C, Ca2+ activity aligned to cell body Ca2+ events was computed as follows. For each riboGCaMP6m-expressing cell body identified in a field of view, the times of its Ca2+ events were estimated from the deconvolved ΔF/F signal. In an 8-s window around each Ca2+ event from the cell body, the population average Ca2+ event rate from all other relevant ROIs (i.e., axon ROIs or ROIs from other cell bodies) was calculated. For each cell body whose event-triggered average was calculated this way, the peak event rate was taken as the maximum event rate in the 8-s window.

##### Statistical tests

In both the text and figures “N” refers to number of mice and “n” refers to number of neuron ROIs (cell bodies or axon terminals). Unless otherwise noted, data are summarized by either box-and-whisker charts (with “boxes” marking the median value and the 25% and 75% quantiles, and “whiskers” marking the minimum and maximum values in the dataset) or summary curves indicating the mean value and shading indicating the standard error of the mean.

For statistical comparisons among groups, we accounted for the nested structure of the data (i.e., cellular ROIs nested within mice). Without taking nesting into consideration, false positive rates are inflated since cellular ROIs from the same mouse cannot be considered independent measurements.107 We used semi-weighted error estimators to account for the nesting of cellular ROIs within mice.72 For this procedure, let yi be the mean for a given parameter (e.g., locomotion modulation index) for the i-th mouse in a group, where xj is the parameter value for the j-th ROI in a set if M ROIs for mouse i:

| y=1M∑j=1Mxj| (Equation 10)

The unweighted estimator of the mean is defined as the mean of yi for all mice in a group of N mice, where N is the number of degrees of freedom. This analysis is suboptimal, as some animals have many cells and yield more reliable estimates, whereas other animals have few cells and yield less reliable estimates. At the other extreme, the weighted estimator is defined by pooling parameter values from all ROIs across the N mice in a group and using this number as the degrees of freedom. While the weighted estimator is commonly used in statistical comparisons, the false positive rate is improperly controlled in this case. The semi-weighted estimator for a given parameter measured from multiple ROIs from multiple mice in a group is defined as:

| μ=∑i=1Nwiyi∑i=1Nwi| (Equation 11)

where the weight for the i-th mouse is defined as

| wi=1∣τ2+si2| (Equation 12)

and si2 is the within-mouse variance across ROIs and τ2 is the estimated variance across all mice within the group using maximum likelihood estimation108:

| τ2=∑i=1Nyi-μ2-si2∑i=1Nwi| (Equation 13)

Equations 12 and 13 were solved iteratively and checked for convergence of τ2 to <0.001. If there is minimal across-mouse variance, then the contribution of each ROI is weighted by the number of mice (the weighted estimator), whereas if across-mouse variance is large (i.e., parameter measurements for ROIs within a mouse are strongly dependent), then each mouse is given the same weight.

The semi-weighted estimators derived for different cell types (e.g., V1 axons vs. LP axons) or experimental conditions (e.g., control vs. eOPN3) were then used to calculate the statistical significance of pairwise comparisons using a Student’s t-test. The Benjamini-Hochberg procedure was used to control the false discovery rate from multiple pairwise comparisons. p-values <0.05 after multiple comparisons correction were considered statistically significant. Central markers on box-whisker plots indicate median values, boxes delineate the 25th and 75th percentiles, and upper/lower whiskers indicate maximum/minimum values.

### QUANTIFICATION AND STATISTICAL ANALYSIS

Data were analyzed using custom-written scripts in Mathematica 11 (Wolfram Research) and MATLAB R2018a (Mathworks). Statistical tests, exact values of n, and statistical values for all analyses are listed in Table S1.

## Supplementary Material

1

NIHMS2060932-supplement-1.pdf (19.2MB, pdf)

2

NIHMS2060932-supplement-2.xlsx (33.6KB, xlsx)

## KEY RESOURCES TABLE.

| REAGENT or RESOURCE| SOURCE
| IDENTIFIER

|

| Bacterial and virus strains|
|

|

| AAV5-Syn-GCaMP6s| Chenetal., 201367

| Addgene #100843

| AAV1-Syn-GCaMP6s| Chenetal., 201367

| Addgene #100843

| CAV2-Cre| CRNS Plateforme de Vectorologie de Montpellier
|
https://plateau-igmm.pvm.cnrs.fr/

| AAV5 ef1a-Flex-taCasP3-TEVP| Yang et al., 201347

| UNC Vector Core

| AAV5-Syn-SIO-eOPN3-mScarlet| Mahn et al., 202156

| Addgene #125713

|

| Experimental models: Organisms/strains|
|

|

| Mouse Ai9| Jackson Laboratory
| JAX 007909

| Mouse c57Bl/6| Jackson Laboratory
| JAX 000664

|

| Software and algorithms|
|

|

| MATLAB R2022b (with curve fitting toolbox)| Mathworks
|
https://www.mathworks.com/

| Mathematica 11| Wolfram Research
|
https://www.wolfram.com/mathematica/

| ImageJ Moco Algorithm| Dubbs et al., 201668

|
https://github.com/NTCColumbia/moco

| Custom code| This paper
|
https://github.com/cardin-higley-lab/CC_TC_Neske_Project

https://doi.org/10.5281/zenodo.13899503

Open in a new tab

## Highlights.

-
Projections from LP to higher-order cortex PM exhibit strong state modulation

-
LP projections contribute to PM neuron state modulation but not visual responses

-
Corticocortical projections to PM convey visual, but not state, information

-
The impact of LP on PM activity is consistent with a modulatory role
