---
title: "Bidirectional synaptic plasticity rapidly modifies hippocampal representations"
source: "https://elifesciences.org/articles/73046"
author:
  - "[[Aaron D Milstein]]"
  - "[[Yiding Li]]"
  - "[[Katie C Bittner]]"
  - "[[Christine Grienberger]]"
  - "[[Ivan Soltesz]]"
  - "[[Jeffrey C Magee]]"
  - "[[Sandro Romani]]"
published: 2021-12-09
created: 2026-09-19
description: "Dendritic calcium spikes translocate hippocampal place fields by inducing a non-Hebbian form of bidirectional synaptic plasticity that operates over a seconds-long timescale called behavioral timescale synaptic plasticity."
tags:
  - "clippings"
---
###### Cite this article

(2021)

*eLife* **10**:e73046.

https://doi.org/10.7554/eLife.73046
1. Copy to clipboard
2. [Download BibTeX](https://elifesciences.org/articles/73046.bib)
3. [Download.RIS](https://elifesciences.org/articles/73046.ris)

Learning requires neural adaptations thought to be mediated by activity-dependent synaptic plasticity. A relatively non-standard form of synaptic plasticity driven by dendritic calcium spikes, or plateau potentials, has been reported to underlie place field formation in rodent hippocampal CA1 neurons. Here, we found that this behavioral timescale synaptic plasticity (BTSP) can also reshape existing place fields via bidirectional synaptic weight changes that depend on the temporal proximity of plateau potentials to pre-existing place fields. When evoked near an existing place field, plateau potentials induced less synaptic potentiation and more depression, suggesting BTSP might depend inversely on postsynaptic activation. However, manipulations of place cell membrane potential and computational modeling indicated that this anti-correlation actually results from a dependence on current synaptic weight such that weak inputs potentiate and strong inputs depress. A network model implementing this bidirectional synaptic learning rule suggested that BTSP enables population activity, rather than pairwise neuronal correlations, to drive neural adaptations to experience.

This manuscript uses a combination of high-quality in vivo electrophysiology and modelling to demonstrate that Behavioural Time Scale Plasticity (BTSP) is bidirectional, and the amplitude and direction of this plasticity are dictated by the current weight of the inputs and not by the correlated activity of pairs of neurons. These findings challenge our current views on synaptic plasticity, which are primarily based on Hebb's concept. In addition, the network model used in this study demonstrates that this type of plasticity can rapidly reshape population activity to respond to environmental clues. This study will be of interest to the broad neuroscience audience and foster new ideas on biological and artificial learning.

[https://doi.org/10.7554/eLife.73046.sa0](https://doi.org/10.7554/eLife.73046.sa0)

A new housing development in a familiar neighborhood, a wrong turn that ends up lengthening a Sunday stroll: our internal representation of the world requires constant updating, and we need to be able to associate events separated by long intervals of time to finetune future outcome. This often requires neural connections to be altered.

A brain region known as the hippocampus is involved in building and maintaining a map of our environment. However, signals from other brain areas can activate silent neurons in the hippocampus when the body is in a specific location by triggering cellular events called dendritic calcium spikes.

Milstein et al. explored whether dendritic calcium spikes in the hippocampus could also help the brain to update its map of the world by enabling neurons to stop being active at one location and to start responding at a new position. Experiments in mice showed that calcium spikes could change which features of the environment individual neurons respond to by strengthening or weaking connections between specific cells. Crucially, this mechanism allowed neurons to associate event sequences that unfold over a longer timescale that was more relevant to the ones encountered in day-to-day life.

A computational model was then put together, and it demonstrated that dendritic calcium spikes in the hippocampus could enable the brain to make better spatial decisions in future. Indeed, these spikes are driven by inputs from brain regions involved in complex cognitive processes, potentially enabling the delayed outcomes of navigational choices to guide changes in the activity and wiring of neurons. Overall, the work by Milstein et al. advances the understanding of learning and memory in the brain and may inform the design of better systems for artificial learning.

Activity-dependent changes in synaptic strength can flexibly alter the selectivity of neuronal firing, providing a cellular substrate for learning and memory. In the hippocampus, synaptic plasticity plays an important role in various forms of spatial and episodic learning and memory ([Nakazawa et al., 2004](#bib79)). The spatial firing rates of hippocampal place cells have been shown to be modified by experience and by changes in environmental context or the locations of salient features ([O’Keefe and Conway, 1978](#bib81); [Mehta et al., 1997](#bib66); [Lever et al., 2002](#bib56); [Dupret et al., 2010](#bib27); [Zaremba et al., 2017](#bib108); [Turi et al., 2019](#bib102); [Ziv et al., 2013](#bib111); [Muller and Kubie, 1987](#bib77); [Bostock et al., 1991](#bib12); [Fyhn et al., 2007](#bib30); [Leutgeb et al., 2005](#bib55)). These modifications can occur rapidly, even within a single trial ([Hill, 1978](#bib45); [Mehta, 2015](#bib68); [Monaco et al., 2014](#bib76); [Bittner et al., 2015](#bib8); [Bittner et al., 2017](#bib9); [Diamantaki et al., 2018](#bib26); [Jezek et al., 2011](#bib51); [Geiller et al., 2017](#bib32); [Bourboulou et al., 2019](#bib13); [Zhao et al., 2020](#bib110)). Here, we investigate the synaptic plasticity mechanisms underlying such rapid changes in the spatial selectivity of hippocampal place cells.

Various forms of Hebbian synaptic plasticity have been considered for decades to be the main, or even only, synaptic plasticity mechanisms present within most brain regions of a number of species ([Magee and Grienberger, 2020](#bib62)). The core feature of such plasticity mechanisms is that they are autonomously driven by repeated synchronous activity between synaptically connected neurons, which results in either increases or decreases in synaptic strength depending on the exact temporal coincidence ([Gerstner et al., 2018](#bib33); [Keck et al., 2017](#bib52); [Shouval et al., 2010](#bib94); [Song et al., 2000](#bib96)). This includes the so-called ‘three-factor’ plasticity rules that, in addition to pre- and postsynaptic activity, depend on a third factor that extends the time course over which plasticity can function ([Magee and Grienberger, 2020](#bib62); [Gerstner et al., 2018](#bib33); [He et al., 2015](#bib42); [Yagishita et al., 2014](#bib106)). To implement these three-factor plasticity rules, it has been proposed that correlated pre- and postsynaptic activity drives the formation of a synaptic flag or eligibility trace (ET) that is then converted into changes in synaptic weights by the delayed third factor, usually a neuromodulatory signal ([Gerstner et al., 2018](#bib33); [Sajikumar and Frey, 2004](#bib90); [Frey and Morris, 1997](#bib28)).

Recently, we reported a potent, rapid form of synaptic plasticity in hippocampal CA1 pyramidal neurons that enables a de novo place field to be generated in a single trial following a dendritic calcium spike (also called a plateau potential) ([Bittner et al., 2015](#bib8); [Bittner et al., 2017](#bib9); [Diamantaki et al., 2018](#bib26)). This form of synaptic plasticity, termed behavioral timescale synaptic plasticity (BTSP), rapidly modifies synaptic inputs active within a seconds-long time window around the plateau potential. This relatively long time course suggests that BTSP may be similar to the above-mentioned three-factor forms of plasticity, with synaptic activity generating local signals marking synapses as eligible for plasticity (ETs), and plateau potentials acting as the delayed factor that converts synaptic ETs into changes in synaptic strength. However, BTSP was shown to strengthen many synaptic inputs whose activation did not coincide with any postsynaptic spiking or even subthreshold depolarization detected at the soma ([Bittner et al., 2017](#bib9)), suggesting that changes in synaptic weight might be independent of correlated pre- and postsynaptic activity, and that BTSP may be fundamentally different than all variants of Hebbian synaptic plasticity ([Gerstner et al., 2018](#bib33); [Keck et al., 2017](#bib52); [Shouval et al., 2010](#bib94); [Mehta, 2004](#bib67); [Golding et al., 2002](#bib34)). Such a non-standard plasticity rule could enable learning to be guided by delayed behavioral outcomes, rather than by short timescale associations of pre- and postsynaptic activity.

In this study, we tested the effect of dendritic plateau potentials on the spatial selectivity of CA1 neurons that already express pre-existing place fields, and therefore exhibit substantial postsynaptic depolarization and spiking prior to plasticity induction. We found that dendritic plateau potentials rapidly translocate the place field position of hippocampal place cells, both by strengthening inputs active near the plateau position and weakening inputs active within the original place field. In order to determine if the increased postsynaptic activity in place cells is causally related to the synaptic depression observed within the initial place field, we performed a series of voltage perturbation experiments, which indicated that the direction of plasticity induced by plateau potentials is independent of postsynaptic depolarization and spiking. Next, we inferred from the data a computational model of the synaptic learning rule underlying this bidirectional form of plasticity, which suggested that it is instead the current weight of each synaptic input that controls the direction of plasticity such that weak inputs potentiate and strong inputs depress. Finally, we implemented this weight-dependent learning rule in a network model to explore the capabilities of bidirectional BTSP to adapt network-level population representations to changes in the environment.

We first examined how plasticity induced by dendritic plateau potentials changes the intracellular membrane potential (*V* <sub><i>m</i></sub>) dynamics in neurons already exhibiting location-specific firing (i.e. place cells). Intracellular voltage recordings from CA1 pyramidal neurons were established in head-fixed mice trained to run for a water reward on a circular treadmill decorated with visual and tactile cues to distinguish spatial positions (~185 cm in length). Brief step currents (700 pA, 300 ms) were injected through the intracellular electrode for a small number ([Nakazawa et al., 2004](#bib79); [O’Keefe and Conway, 1978](#bib81); [Mehta et al., 1997](#bib66); [Lever et al., 2002](#bib56); [Dupret et al., 2010](#bib27); [Zaremba et al., 2017](#bib108); [Turi et al., 2019](#bib102); [Ziv et al., 2013](#bib111)) of consecutive laps to evoke plateau potentials at a second location that was between 0 and 150 cm from the initial place field (labeled ‘Induction 2’ in [Figure 1A and B](#fig1); *n* = 26 plasticity inductions in 24 neurons). In 8/24 neurons a ‘natural’ pre-existing place field was expressed from the start of recording, while in 16/24 the initial place field was first experimentally induced by the same procedure (labeled ‘Induction 1’ in [Figure 1A and B](#fig1)). In 2/24 neurons the induction procedure was repeated a third time with plateaus evoked at a different location, resulting in a total of 26 plasticity inductions in cells with pre-existing place fields (see [Figure 1—figure supplement 1E](https://elifesciences.org/articles/73046/figures#fig1s1) and Materials and methods).

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig1-v3.tif/full/1234,/0/default.webp)

Dendritic plateau potentials translocate hippocampal place fields. ( A ) Spatial firing of a CA1 pyramidal cell recorded intracellularly from a mouse running laps on a circular treadmill. Dendritic plateau potentials evoked by intracellular current injection first … see more

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig1-figsupp2-v3.tif/full/1234,/0/default.webp)

Characterization of behavioral timescale synaptic plasticity (BTSP)-induced changes in Vm (related to ). ( A ) Raw V m traces of three laps (6, 9, and 10) from a neuron that expressed a naturally occurring place field (on laps 1–8), a naturally occurring plateau potential (on lap 9), and a new place field … see more

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig1-figsupp1-v3.tif/full/1234,/0/default.webp)

Animal run behavior and behavioral timescale synaptic plasticity (BTSP) induction procedures (related to and ). ( A ) Raw data for V m (black), injected current (red), run velocity (green), and position (blue) for 12 laps, including eight plasticity induction laps, for the second induction in the example neuron … see more

In most cases the evoked dendritic plateaus shifted the location of the neuron’s pre-existing place field toward the position of the second induction site ([Figure 1A and B](#fig1)). Place field firing is known to be driven by a slow, ramping depolarization of *V* <sub><i>m</i></sub> from sub- to supra-threshold levels ([Bittner et al., 2015](#bib8); [Harvey et al., 2009](#bib41)). Isolation of these low-pass filtered *V* <sub><i>m</i></sub> ramps ([Figure 1—figure supplement 2A-H](https://elifesciences.org/articles/73046/figures#fig1s2); Materials and methods) revealed that plateau potentials likewise shifted the neuron’s *V* <sub><i>m</i></sub> ramp toward the position of the plateau, such that the new *V* <sub><i>m</i></sub> ramp peaked near the plateau position in most neurons (average distance = 19.5 ± 4.7 cm; *n* = 26; [Figure 1C–E](#fig1) and [Figure 1—figure supplement 2](https://elifesciences.org/articles/73046/figures#fig1s2); example cells shown in [Figure 1C](#fig1) are indicated with matching colored arrows in [Figure 1D](#fig1)). We also observed similar shifts in place field position to be induced by spontaneous, naturally occurring plateau potentials in a separate set of recordings (*n* = 5; [Figure 1—figure supplement 2I-M](https://elifesciences.org/articles/73046/figures#fig1s2)).

The spatial profile of plateau-induced *V* <sub><i>m</i></sub> changes (Δ *V* <sub><i>m</i></sub>) ([Figure 2A](#fig2)) was obtained by subtracting the average *V* <sub><i>m</i></sub> ramp for trials occurring before plateau initiation ([Figure 1C](#fig1); before) from the average *V* <sub><i>m</i></sub> ramp for trials occurring after ([Figure 1C](#fig1); after). These data indicate that plateaus induced both positive and negative changes to *V* <sub><i>m</i></sub> ramp amplitude ([Figure 2A and B](#fig2)). In general, the increases in *V* <sub><i>m</i></sub> depolarization peaked near the position of the plateau, while the negative changes peaked near the initial place field ([Figure 2A and B](#fig2), and [Figure 2—figure supplement 1A and B](https://elifesciences.org/articles/73046/figures#fig2s1)). Although these changes varied considerably in magnitude across cells, the peak change in the positive direction was greater than the peak change in the negative direction (mean positive change± SEM vs. mean negative change± SEM: 6.73 ± 0.73 mV vs. 3.89 ± 0.32 mV, *n* = 26 inductions; p = 0.0001, paired two-way Student’s t-test; [Figure 2—figure supplement 1A](https://elifesciences.org/articles/73046/figures#fig2s1)). Aligning each Δ *V* <sub><i>m</i></sub> trace to the position of the plateau ([Figure 2A and B](#fig2)) demonstrates that the increases in *V* <sub><i>m</i></sub> depolarization observed near the plateau position decay with distance, eventually becoming hyperpolarizing decreases in *V* <sub><i>m</i></sub>. At even greater distances from a plateau, Δ *V* <sub><i>m</i></sub> decays back to zero ([Figure 2B](#fig2)). To summarize the data presented thus far, dendritic plateau potentials change the location of place field firing by depolarizing *V* <sub><i>m</i></sub> around the plateau position and hyperpolarizing *V* <sub><i>m</i></sub> at positions within a pre-existing place field.

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig2-v3.tif/full/1234,/0/default.webp)

Spatial and temporal profiles of plateau-induced change in Vm. ( A ) Difference between spatially binned V m ramp depolarizations averaged across laps after the second induction and those averaged across laps before the second induction. Same example traces as … see more

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig2-figsupp1-v3.tif/full/1234,/0/default.webp)

Vm changes in space and time in place cells with pre-existing place fields (related to ). ( A ) Peak positive changes in V m ramp (max, gray open circles) and peak negative changes (min, black open circles) for all cells. Mean and SEM are indicated with filled circles and bars. ( B ) Left: … see more

Previously we showed that location-specific increases in *V* <sub><i>m</i></sub> depolarization induced by plateau potentials are the result of synapse-specific increases in the strength of spatially tuned excitatory inputs ([Bittner et al., 2017](#bib9)). The above results suggest that, in addition to this synaptic potentiation, BTSP is also capable of inducing synaptic depression to cause location-specific decreases in *V* <sub><i>m</i></sub> depolarization. In analyzing the spatial extent of the *V* <sub><i>m</i></sub> changes induced by plateaus, we observed a strong linear relationship between the width of the resulting Δ *V* <sub><i>m</i></sub> and the running speed of the animal during plateau induction laps ([Figure 2C and D](#fig2)), which had a slope on the order of seconds. This suggested that the run trajectory of the animal ([Figure 2C](#fig2)) affected the spatial extent of the plasticity ([Figure 2A and B](#fig2)) by determining which positions were traversed within a fixed seconds-long temporal window for plasticity, as we previously reported ([Bittner et al., 2017](#bib9)). Therefore, we next analyzed the temporal relationship between plateau potentials and location-specific potentiation and depression. To do this, we used the running trajectory of the mice during plateau induction trials ([Figure 2C](#fig2)) as a time base for Δ *V* <sub><i>m</i></sub> ([Figure 2E](#fig2); see also [Figure 1—figure supplement 1](https://elifesciences.org/articles/73046/figures#fig1s1), [Figure 1—figure supplement 2A-H](https://elifesciences.org/articles/73046/figures#fig1s2) and Materials and methods). This analysis showed that the positive and negative changes to *V* <sub><i>m</i></sub> induced in place cells occurred over a timescale of multiple seconds ([Figure 2F](#fig2)), with the positive changes appearing to be asymmetric with respect to the onset time of the plateaus (ratio of potentiation duration before/after plateau onset: 2.2; black circles and crossmarks in [Figure 2F](#fig2) mark the time points when Δ *V* <sub><i>m</i></sub> crosses zero). This asymmetry was similar to that observed for the positive *V* <sub><i>m</i></sub> changes induced by BTSP in silent cells ([Bittner et al., 2017](#bib9)). The negative changes (i.e. the hyperpolarizations indicative of synaptic depression) occurred within a time window between ±2 and ±6 s from the plateau in many neurons that expressed pre-existing place fields ([Figure 2E and F](#fig2)). Notably, this hyperpolarization was greatly reduced, or even absent, in a set of place cells where the time delay between plateau onset and the initial place field *V* <sub><i>m</i></sub> ramp was greater than 4–5 s (red traces in [Figures 1C](#fig1), [2A and E](#fig2); see also [Figure 2—figure supplement 1C-F](https://elifesciences.org/articles/73046/figures#fig2s1)), further indicating the time delimited aspect of the depression component. These data reinforce the idea that BTSP is a bidirectional form of synaptic plasticity with a seconds-long timescale that enables dendritic plateau potentials to shift the locations of hippocampal place fields by inducing both synaptic potentiation and depression.

We next sought to understand why dendritic plateaus induce both *V <sub>m</sub>* depolarization and *V <sub>m</sub>* hyperpolarization in cells expressing pre-existing place fields ([Figures 1](#fig1) and [^1]), but induce only *V <sub>m</sub>* depolarization in spatially untuned silent cells ([Figure 3—figure supplement 1](https://elifesciences.org/articles/73046/figures#fig3s1); [Bittner et al., 2017](#bib9)). [Figure 3A](#fig3) shows that the initial temporal profile of *V <sub>m</sub>* in place cells with pre-existing place fields was highly variable across neurons, as plateaus were experimentally induced at different temporal intervals from the existing place field in different neurons. In contrast, the change in *V <sub>m</sub>* (Δ *V* <sub><i>m</i></sub>) induced by plateaus showed a more consistent shape in time that appeared to depend on the initial level of *V <sub>m</sub>* depolarization at each time point prior to plasticity ([Figure 3B](#fig3)). Large positive changes occurred at time points with relatively hyperpolarized initial *V <sub>m</sub>*, while time points with more depolarized initial *V <sub>m</sub>* were associated with less positive and more negative Δ *V* <sub><i>m</i></sub>. These changes resulted in final *V <sub>m</sub>* profiles that were highly similar across neurons, regardless of the initial *V <sub>m</sub>* ([Figure 3C](#fig3)). These results indicate that BTSP induces variable changes in synaptic strength that reshape the selectivity of neurons toward a common target shape – a place field centered near the location of evoked plateau potentials that decays toward baseline over many seconds in each direction.

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig3-v3.tif/full/1234,/0/default.webp)

Vm ramp plasticity varies with both time delay from plateau onset and initial Vm depolarization. ( A ) Temporal profile of initial V m before plasticity for inductions in neurons with pre-existing place fields (26 inductions from 24 place cells), aligned to the onset time of evoked plateau … see more

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig3-figsupp1-v3.tif/full/1234,/0/default.webp)

Vm changes in space and time in silent cells without pre-existing place fields (related to ). ( A ) Spatially binned initial V m traces for silent cells that did not express pre-existing place fields (individual traces, gray; average across cells, black) (100 spatial bins). ( B ) Same as ( ) but … see more

In [Figure 3D-F](#fig3), we examined this further by comparing data from initially hyperpolarized silent cells (black; *n* = 29 inductions, see [Figure 3—figure supplement 1](https://elifesciences.org/articles/73046/figures#fig3s1) and Materials and methods) to data from place cells (dark red; *n* = 26 inductions). Place cells were on average more depolarized before plasticity than silent cells ([Figure 3D](#fig3)), and more depression occurred in place cells compared to silent cells ([Figure 3E](#fig3)). However, each place cell had both spatial positions where it was depolarized within its place field, and positions where it was hyperpolarized out-of-field. To determine if spatial positions that were initially depolarized were associated with larger depression, we grouped *V <sub>m</sub>* ramp data from all place cells, considering only spatial bins where each cell was more depolarized than a threshold of –56 mV (light red traces labeled ‘PCs (within-field)’ in [Figure 3D-F](#fig3)). Indeed, more depression and less potentiation was induced in place cells at those spatial positions that were initially most depolarized ([Figure 3E](#fig3)). However, the final *V <sub>m</sub>* ramps after plasticity were less sensitive to the initial state of depolarization across spatial bins of place cells ([Figure 3F](#fig3)). This analysis further supported the findings that, while changes in *V <sub>m</sub>* induced by plateaus were highly dependent on initial *V <sub>m</sub>*, these changes drove the resulting final *V <sub>m</sub>* ramp toward a common target shape ([Figure 3F](#fig3)). Indeed, when all spatial bins from all place cells were analyzed, Δ *V* <sub><i>m</i></sub> showed a strong inverse correlation with initial *V* <sub><i>m</i></sub> (*m* = –0.91; [Figure 3G](#fig3)). In contrast, final *V* <sub><i>m</i></sub> showed a very weak positive correlation with initial *V* <sub><i>m</i></sub> (*m* = 0.04; [Figure 3H](#fig3)), which reflects that some spatial bins show no change in *V* <sub><i>m</i></sub> during plasticity, either because they were traversed outside the temporal window for plasticity or because the *V* <sub><i>m</i></sub> at those positions had already reached a final *V* <sub><i>m</i></sub> target value.

That BTSP induces variable changes in *V* <sub><i>m</i></sub> that reshape the *V* <sub><i>m</i></sub> ramp toward a particular target shape is further evident from a heatmap depicting the relationships of Δ *V* <sub><i>m</i></sub> to both initial *V* <sub><i>m</i></sub> ramp depolarization and time from plateau onset ([Figure 3I](#fig3), positive Δ *V* <sub><i>m</i></sub> in red, and negative Δ *V* <sub><i>m</i></sub> in blue; see Materials and methods). The white regions of this plot trace out a temporal profile of *V* <sub><i>m</i></sub> that corresponds to the final target place field shapes shown in [Figure 3C and F](#fig3). All initial deviations from this equilibrium *V* <sub><i>m</i></sub> profile resulted in either positive or negative changes to approach this target place field shape (see dashed arrows). It should also be noted that the depression of *V* <sub><i>m</i></sub> in place cells appeared to be weaker than the potentiation, leaving some residual depolarization at positions distant from the peak ([Figure 3F](#fig3)). The functional significance of this is unclear, but may suggest that BTSP induces synaptic depression at a slower rate than potentiation ([Cone and Shouval, 2021](#bib24)). To summarize, BTSP induces precise changes in synaptic strength that modify pre-existing place fields with any initial shape such that they approach a target shape that peaks near the location where dendritic plateaus were evoked.

Altogether these data revealed that, in general, the magnitude and direction of Δ *V* <sub><i>m</i></sub> depended on the time from the plateau potential, and correlated inversely with the initial *V* <sub><i>m</i></sub> ramp amplitude prior to plasticity induction. Does this anti-correlation reflect a causal relationship between postsynaptic depolarization and changes in synaptic weight induced by BTSP? This possibility would require that small depolarizations induce synaptic potentiation and large depolarizations induce synaptic depression, which is actually opposite to what has been observed in CA1 pyramidal cells with a variety of other plasticity protocols ([Shouval et al., 2010](#bib94); [Yang et al., 1999](#bib107); [Graupner and Brunel, 2012](#bib37); [Clopath et al., 2010](#bib21); [Clopath and Gerstner, 2010](#bib22); [Jedlicka et al., 2015](#bib50)). Furthermore, the increased *V* <sub><i>m</i></sub> depolarization within a cell’s place field also reflects the activation of strongly weighted synaptic inputs, which have been potentiated by prior plasticity ([Bittner et al., 2015](#bib8); [Bittner et al., 2017](#bib9); [Figure 3J](#fig3)). Thus, a causal dependency on either *V* <sub><i>m</i></sub> or synaptic weight could explain the data so far.

To discriminate between these two possibilities, we next devised a set of voltage perturbation experiments. We reasoned that, if increased depolarization and spiking within a cell’s place field causes synaptic depression, then artificially increasing *V* <sub><i>m</i></sub> and inducing spiking in otherwise silent cells would cause plateau potentials to induce negative Δ *V* <sub><i>m</i></sub>. Likewise, artificially decreasing *V* <sub><i>m</i></sub> and preventing spiking in place cells would prevent plateau potentials from inducing negative Δ *V* <sub><i>m</i></sub> ([Figure 3K](#fig3)). On the contrary, if the direction of plasticity depended instead on the initial strengths of synapses prior to plasticity, these voltage manipulations would have no effect on the balance between positive and negative Δ *V* <sub><i>m</i></sub> ([Figure 3K](#fig3)). It is important to note that these somatic voltage manipulations are not expected to strictly control or even completely overwhelm *V* <sub><i>m</i></sub> at the synaptic sites relevant to plasticity induction ([Magee and Johnston, 1997](#bib60); [Koester and Sakmann, 1998](#bib53); [Froemke et al., 2005](#bib29)) due to attenuation of current and voltage along the dendritic cable ([Magee, 1998](#bib61); [Golding et al., 2005](#bib35)), and compartmentalization of synaptic voltage in dendritic spines ([Harnett et al., 2012](#bib40)). However, by either increasing or decreasing the generation of somatic action potentials, this manipulation will unequivocally alter the number of action potentials that back-propagate into dendrites, which will in turn influence the activation of voltage-gated channels in dendrites and spines (e.g. Na <sup>+</sup> channels, Ca <sup>2+</sup> channels, and NMDA-Rs) ([Magee and Johnston, 1997](#bib60); [Takahashi and Magee, 2009](#bib100)). Expected changes to the mean *V* <sub><i>m</i></sub> in active dendritic spines were supported by simulations of a biophysically and morphologically detailed CA1 place cell model expressing voltage-gated ion channels and receiving rhythmic excitation and inhibition to mimic the in vivo recording conditions ([Figure 4—figure supplement 1](https://elifesciences.org/articles/73046/figures#fig4s1); [Grienberger et al., 2017](#bib38)). Moreover, manipulation of somatic *V* <sub><i>m</i></sub> and spike timing is widely used to successfully influence plasticity induction in vitro and in vivo ([Malinow and Miller, 1986](#bib63); [Jacob et al., 2007](#bib48); [Schulz et al., 2010](#bib92)).

According to the above scheme, we first recorded from spatially untuned silent cells, and injected current (~100 pA) through the intracellular pipette to depolarize the neurons’ *V* <sub><i>m</i></sub> by ~10 mV and to increase spiking during plasticity induction trials ([Figure 4A](#fig4); baseline trials mean AP rate: 0.26 ± 0.25 Hz; first induction trial mean AP rate: 4.8 ± 1.4 Hz, *n* = 8; blue trace in [Figure 4B](#fig4)). In all neurons tested, we observed plateau potentials to induce large positive Δ *V* <sub><i>m</i></sub> at spatial positions surrounding the plateau location, and no negative Δ *V* <sub><i>m</i></sub> at any spatial positions ([Figure 4A](#fig4); blue trace in [Figure 4C](#fig4)). This result is inconsistent with a causal dependence on initial *V* <sub><i>m</i></sub> ([Figure 3K](#fig3)), which predicted a Δ *V* <sub><i>m</i></sub> profile similar to that of control place cells at their most depolarized positions within their pre-existing place fields (red traces, ‘control PCs (within-field)’ in [Figure 4B and C](#fig4) repeated from [Figure 3D and E](#fig3) for comparison).

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig4-v3.tif/full/1234,/0/default.webp)

Experimental perturbation of postsynaptic activation does not change the direction of plasticity induced by behavioral timescale synaptic plasticity (BTSP). ( A ) Intracellular V m traces from individual laps in which plasticity was induced by experimentally evoked plateau potentials in an otherwise silent CA1 cell (top trace). During plasticity induction … see more

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig4-figsupp2-v3.tif/full/802,/0/default.webp)

Hyperpolarization of silent cells during plasticity induction reduces synaptic potentiation (related to ). ( A ) Top black traces are V m during laps before induction in a silent cell. During plasticity induction (thin green trace) somatic current injection (–500 pA, thick green trace) hyperpolarized by … see more

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig4-figsupp1-v3.tif/full/1234,/0/default.webp)

Biophysically detailed simulations of depolarizing and hyperpolarizing somatic Vm perturbation experiments (related to ). ( A ) Simulation of a biophysically detailed CA1 pyramidal cell model with realistic morphology and dendritic ion channel distributions ( Grienberger et al., 2017 ) to estimate the effect of somatic … see more

Next, we performed the inverse manipulation by recording from place cells and injecting current (~–150 pA) to hyperpolarize the neurons’ *V* <sub><i>m</i></sub> by ~–15 mV and prevent spiking at spatial locations surrounding their pre-existing place fields while plasticity was induced at a second location ([Figure 4D](#fig4); baseline trials in-field mean AP rate 10.66 ± 0.93 Hz; first induction trial in-field mean AP rate 0.06 ± 0.06 Hz, *n* = 5; green trace in [Figure 4E](#fig4)). This manipulation did not prevent negative Δ *V* <sub><i>m</i></sub> at positions within the original place field ([Figure 4D](#fig4); green trace in [Figure 4F](#fig4)), again incompatible with synaptic depression requiring elevated postsynaptic depolarization and spiking ([Figure 3K](#fig3)). In fact, full amplitude synaptic depression was observed at locations within the original place field despite the somatic *V* <sub><i>m</i></sub> being more hyperpolarized than either the silent cell (black traces in [Figure 4E and F](#fig4)) or control place cell groups (red traces, ‘control PCs’ in [Figure 4E and F](#fig4)).

These data clearly show that the direction of plasticity induced by dendritic plateau potentials is not determined by the activation state of the postsynaptic neuron. Instead, the results of these voltage perturbation experiments support the alternative hypothesis that it is the initial strength of each synapse that controls whether an input will be potentiated or depressed by BTSP ([Figure 3K](#fig3)). However, the magnitude of potentiation and depression was slightly affected by the voltage perturbations (e.g. potentiation was slightly but significantly increased in silent cells during artificial depolarization compared to control, [Figure 4C](#fig4)). This is consistent with the previously reported finding that BTSP induction requires activation of voltage-dependent ion channels, including NMDA-type glutamate receptors (NMDA-Rs) and voltage-gated calcium channels ([Bittner et al., 2017](#bib9)), which would have predicted BTSP to depend on postsynaptic depolarization. To examine this further, we performed an additional set of experiments in which silent cells were strongly hyperpolarized by somatic current injection (~–50 mV for ~3 s just before plateau initiation) during plasticity induction ([Figure 4—figure supplement 2](https://elifesciences.org/articles/73046/figures#fig4s2)). This manipulation decreased synaptic potentiation ([Figure 4—figure supplement 2](https://elifesciences.org/articles/73046/figures#fig4s2)), consistent with a requirement for activation of voltage-dependent NMDA-Rs. That such a large, non-physiological level of global *V* <sub><i>m</i></sub> hyperpolarization was required to alter BTSP reinforces the finding that, operationally, the dependence is not on voltage signals associated with neuronal activation state (sustained somatodendritic *V* <sub><i>m</i></sub> and action potentials), but rather on those associated with synaptic input (transient local spine depolarization) ([Beaulieu-Laroche and Harnett, 2018](#bib5)). Finally, these experiments do not support a role for synaptic depolarization in determining the *direction* of changes in synaptic strengths.

The above voltage perturbation experiments suggested that the form of synaptic plasticity underlying BTSP does not depend on the activation state of the postsynaptic neuron ([Figure 4](#fig4)). This contrasts with Hebbian plasticity rules that typically depend on either the firing rate or depolarization of the postsynaptic cell to determine the amplitude and direction of changes in synaptic weight. Another difference is that BTSP appears to be inherently stable, converting synaptic potentiation into depression when input strengths exceed a particular range, whereas most models of Hebbian learning require additional homeostatic mechanisms to counteract synaptic potentiation in highly active neurons ([Oja, 1982](#bib80); [Bienenstock et al., 1982](#bib7); [Abbott and Nelson, 2000](#bib1); [Zenke et al., 2013](#bib109); [Turrigiano and Nelson, 2004](#bib103)). To better understand the synaptic learning rule underlying BTSP and its functional consequences, we next sought a mathematical description of BTSP to account for the following features of the in vivo recording data:

1. BTSP induces bidirectional changes in synaptic weight at inputs activated up to ~6 s before or after a dendritic plateau potential.
2. The direction and magnitude of changes in synaptic weight depend on the initial state of each synapse such that weak inputs potentiate, and strong inputs depress.
3. BTSP modifies synaptic weights such that the temporal profile of *V* <sub><i>m</i></sub> in place cells approaches a stable target shape that peaks close in time to the plateau location and decays with distance.

As mentioned previously, ‘three-factor’ plasticity models propose a mechanism for the strengths of activated synapses to be modified after a time delay – a biochemical intermediate signal downstream of synaptic activation marks each recently activated synapse as ‘eligible’ to undergo a plastic change in synaptic weight. This ‘ET’ decays over a longer timescale than synaptic activation, and while it does not induce plasticity by itself, it enables plasticity to be induced upon the arrival of an additional modulatory biochemical signal. While ‘three-factor’ models consider synaptic ETs to be generated by a coincidence of presynaptic spikes (factor 1) and postsynaptic spikes or sustained depolarization (factor 2), the results of the above voltage perturbation experiments suggest that if BTSP involves the generation of synaptic ETs, these signals depend only on a single factor – local synaptic activation. In the context of BTSP, the modulatory or ‘instructive signal’ (IS) could be instantiated by a dendritic plateau potential. To model this, we assumed that the large magnitude dendritic depolarization associated with a plateau potential (~60 mV) effectively propagates to all synapses ([Xu et al., 2012](#bib105)), activating an IS at each synapse and allowing a spatially and temporally local interaction between ET and IS to drive plasticity independently at each individual synapse ([Figure 5A](#fig5)). To account for plasticity that occurs at inputs activated up to multiple seconds *after* a plateau, this IS would have to decay slowly enough to overlap in time with ETs generated after the end of the plateau ([Figure 5A](#fig5)).

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig5-v3.tif/full/1234,/0/default.webp)

Weight-dependent model of behavioral timescale synaptic plasticity (BTSP) captures essential features of plateau-induced plasticity. ( A – B ) Traces schematize a model of bidirectional BTSP that depends on (1) presynaptic spike timing, (2) plateau potential timing and duration, and (3) the current synaptic weight of an input … see more

Accordingly, we modeled changes in synaptic weights as a function of the time-varying amplitudes of these two biochemical intermediate signals, ET and IS. For simplicity, we first considered how BTSP would change the weight $W$ of a single synapse activated by a single presynaptic spike with precise timing relative to the onset of a plateau potential ([Figure 5A](#fig5)). We modeled the synaptic ET as a signal that increases upon synaptic activation at time $t^{s}$ and decays exponentially with time course $\tau_{E T}$ (see [Figure 5A](#fig5) and Materials and methods). The IS was modeled as a signal that increases during a plateau potential with onset at time $t^{p}$ and duration $d$ and decays exponentially with time course $\tau_{I S}$ (see [Figure 5A](#fig5) and Materials and methods).

Next, we modeled bidirectional changes in synaptic weight $\frac{d W}{d t}$ as a function of the temporal overlap or product of these two signals, $E T * I S$. To account for the observation that BTSP favors synaptic potentiation at weak synapses and synaptic depression at strong synapses, we expressed $\frac{d W}{d t}$ in terms of two separate plasticity processes $q^{+}$ and $q^{-}$ with opposite dependencies on the current synaptic weight $W$:

(1) 
$$
\frac{d W}{d t} = \left(W_{m a x} - W\right) * k^{+} * q^{+} \left(E T * I S\right) - W * k^{-} * q^{-} \left(E T * I S\right)
$$

where $W$ is saturable up to a maximum weight of $W_{m a x}$, and *k* <sup>+</sup> and *k* <sup>−</sup> are learning rate constants that control the magnitudes of synaptic potentiation and depression per plateau potential. This formula can be obtained from a two-state model of finite synaptic resources (see Materials and methods). When the current synaptic weight $W$ is near $W_{m a x}$, the potentiation rate becomes zero, and when $W$ is near zero, the depression rate becomes zero. To calculate the net change in synaptic weight $\Delta W$ after plasticity induction, $\frac{d W}{d t}$ was integrated in time for the duration of plasticity induction laps.

Experimental evidence suggests that synaptic potentiation and depression processes involve biochemical interactions between enzymes (e.g. phosphokinases-like CaMKII and phosphatases-like calcineurin) and synaptic protein substrates (e.g. AMPA-type glutamate receptors) ([Herring and Nicoll, 2016](#bib44); [Mansuy, 2003](#bib64)). Such concentration-limited reactions are typically saturable and nonlinear ([Graupner and Brunel, 2012](#bib37)). Accordingly, we defined the plasticity processes $q^{+}$ and $q^{-}$ as saturable (sigmoidal) functions of the signal overlap $E T * I S$ (see Materials and methods). If the depression process $q^{-}$ has a lower threshold for activation than the potentiation process $q^{+}$ ([Graupner and Brunel, 2007](#bib36); [Inglebert et al., 2020](#bib47)), the resulting change in synaptic weight $\frac{d W}{d t}$ is positive and increases monotonically when initial weights are low, but is negative and non-monotonic when initial weights are high ([Figure 5B](#fig5)). At intermediate weights, $\frac{d W}{d t}$ transitions from negative (depression) to positive (potentiation) for values of signal overlap $E T * I S$ that are beyond a threshold ([Figure 5B](#fig5)). Thus, the largest negative changes in synaptic weight occur when inputs are initially large in weight and signal overlap $E T * I S$ is intermediate in amplitude. This is consistent with the in vivo data, which showed that negative changes in place field ramp *V* <sub><i>m</i></sub> were largest at intermediate delays from a plateau ([Figure 3B and I](#fig3)).

We tested this weight-dependent model of bidirectional BTSP by varying both the timing of a single presynaptic spike relative to a plateau ([Figure 5A](#fig5)) and the initial weight of the activated synapse ([Figure 5B](#fig5)). Model parameters were calibrated (see Materials and methods) such that synapses with an initial weight less than a baseline weight of 1 undergo only potentiation, while synapses with higher weight undergo either potentiation or depression, depending on the timing of their activation relative to the plateau ([Figure 5C](#fig5)). This produced a profile of changes in synaptic weight similar to the profile of changes in intracellular *V* <sub><i>m</i></sub> measured in vivo ([Figure 3I](#fig3)). This model also recapitulated the finding that the positive and negative changes in weight induced by BTSP appear to drive synaptic inputs toward a stable target weight, after which additional plateaus do not induce any further changes in strength (indicated in white, compare [Figures 3I](#fig3) and [5C](#fig5)).

We next exploited the mathematical formulation of the model to analyze these equilibrium conditions in more detail. We defined $W_{e q}$ as the stable equilibrium value of *W* where potentiation and depression processes are exactly balanced, and the change in weight $\Delta W$ is zero over the course of a trial from times $t_{0}$ to $t_{1}$:

(2) 
$$
\Delta W = 0 = \left(W_{m a x} - W_{e q}\right) * k^{+} * \int_{t_{0}}^{t_{1}} q^{+} \left(E T * I S\right) d t - W_{e q} * k^{-} * \int_{t_{0}}^{t_{1}} q^{-} \left(E T * I S\right) d t
$$

If we abbreviate the integrated potentiation and depression terms as:

(3) 
$$
\Delta Q^{+} = \int_{t_{0}}^{t_{1}} q^{+} \left(E T * I S\right) d t
$$

(4) 
$$
\Delta Q^{-} = \int_{t_{0}}^{t_{1}} q^{-} \left(E T * I S\right) d t
$$

then $W_{e q}$ can be expressed as:

(5) 
$$
W_{e q} = W_{m a x} * \frac{K^{+} * \Delta Q^{+}}{K^{+} * \Delta Q^{+} + k^{-} * \Delta Q^{-}}
$$

Note that the quantities $\Delta Q^{+}$ and $\Delta Q^{-}$, and therefore the value of $W_{e q}$, will vary with the activation time of the input ($t^{s}$), and the onset time ($t^{p}$) and duration ($d$) of a plateau. For a plateau with fixed onset time and duration, this produces a distribution of target equilibrium weights that varies only with the timing of synaptic activation relative to plateau onset (dashed line in [Figure 5C](#fig5)), and matches the asymmetric shape of place fields induced by BTSP. In contrast, an alternative version of the model in which the potentiation and depression processes were defined to be linear instead of sigmoidal, predicted a single value for $W_{e q}$ regardless of the timing of synaptic activation ([Figure 5D](#fig5)), thus failing to account for the data. Finally, we verified that the model requires long timescales for $E T$ and $I S$ by testing the model with shorter values (100 ms) for the decay time constants $\tau_{E T}$ and $\tau_{I S}$ ([Figure 5E](#fig5)). This was unable to explain changes in synaptic weight at inputs activated at seconds-long time delays to a plateau.

Having demonstrated that this weight-dependent model of plasticity at single synapses captures the essential features of BTSP, we next tested if the model can account quantitatively for the in vivo place field translocation data ([Figures 1](#fig1) — [^2]). For this purpose, we assumed that the *V* <sub><i>m</i></sub> ramp depolarization measured in a CA1 pyramidal cell during locomotion on the circular treadmill reflects a weighted sum of presynaptic inputs that are themselves place cells with firing rates that vary with spatial position (see [Figure 3J](#fig3) and Materials and methods). As a population, the place fields of these inputs uniformly tiled the track, and the firing rate of an individual input depended on the recorded run trajectory of the animal ([Figure 6A](#fig6), first and second rows). In this case, presynaptic activity patterns were modeled as continuous firing rates rather than discrete spike times. For each cell in the experimental dataset (*n* = 26 inductions from 24 neurons, [Figures 1](#fig1) — [^2]), the initial weight $W_{i}$ of each presynaptic input $i$ was inferred from the recorded initial *V* <sub><i>m</i></sub>, and the changes in weight $\Delta W_{i}$ during plasticity induction laps containing evoked plateau potentials were computed as above ([Equation 1](#equ1); see Materials and methods). The relevant signals modeled for an example lap from a representative cell from the dataset are shown in [Figure 6A](#fig6). Note that, at inputs activated before the onset time of the plateau, changes in synaptic weight (bottom row) do not begin until after plateau onset when the instructive signal $I S$ and the signal overlap $E T * I S$ are nonzero. The parameters of the model were optimized to predict the final synaptic weights ([Figure 6B](#fig6)) and reproduce the final *V* <sub><i>m</i></sub> ramp ([Figure 6C](#fig6)) after multiple plasticity induction laps ([Figure 6—figure supplement 1](https://elifesciences.org/articles/73046/figures#fig6s1), Materials and methods). Across all cells, these predictions quantitatively matched the corresponding experimental data ([Figure 6D](#fig6)). Finally, the sensitivity of changes in *V* <sub><i>m</i></sub> to initial *V* <sub><i>m</i></sub> and time to plateau predicted by the model recapitulated that measured from the in vivo intracellular recordings ([Figure 6E](#fig6) and [Figure 6—figure supplement 2](https://elifesciences.org/articles/73046/figures#fig6s2)).

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig6-v3.tif/full/1234,/0/default.webp)

Weight-dependent model of behavioral timescale synaptic plasticity (BTSP) accounts for experimentally measured bidirectional changes in Vm. ( A ) The weight-dependent model of BTSP shown in Figure 5 was used to reproduce plateau-induced changes in V m in an experimentally recorded CA1 neuron given (1) the measured run trajectory of the … see more

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig6-figsupp3-v3.tif/full/1234,/0/default.webp)

Bidirectional behavioral timescale synaptic plasticity (BTSP) schematic (related to, and ). ( A – C ) (Step 1) Selecting synapses for weight adjustment. ( A ) Postsynaptic dendrite with spines and presynaptic inputs. Top spines receive inappropriately patterned or inactive inputs (black) while … see more

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig6-figsupp2-v3.tif/full/1234,/0/default.webp)

Comparison of alternative models of behavioral timescale synaptic plasticity (BTSP) (related to and ). ( A ) Variants of the model of bidirectional BTSP described in Figures 5 and 4 were evaluated based on the accuracy of their predictions of experimentally measured changes in V m ramp amplitude induced … see more

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig6-figsupp1-v3.tif/full/1234,/0/default.webp)

Sensitivity of induced place field Vm ramps to repeated plateau potentials and run velocity in the weight-dependent model of behavioral timescale synaptic plasticity (BTSP) (related to and ). ( A–B ) For the example cell shown in Figure 6A-C to illustrate the weight-dependent model of BTSP described in Figure 5, the values of synaptic weights ( A ) and V m ramp amplitude ( B ) before and after … see more

The above modeling results help to clarify the differences between BTSP and previously characterized forms of associative synaptic plasticity based on input-output correlations over short timescales ([Gerstner et al., 2018](#bib33); [He et al., 2015](#bib42); [Brzosko et al., 2015](#bib15); [Brzosko et al., 2017](#bib16)). First, the model supports the hypothesis that a dependence on initial synaptic weight is the actual source of the observed inverse relationship between initial *V* <sub><i>m</i></sub> and plasticity-induced changes in *V* <sub><i>m</i></sub> ([Figure 3](#fig3)). Second, the scaling of both potentiation and depression by synaptic weight produces a balanced form of plasticity that rapidly stabilizes during repeated inductions ([Figure 1](#fig1), and [Figure 6—figure supplement 1A and B](https://elifesciences.org/articles/73046/figures#fig6s1); [Shouval et al., 2010](#bib94); [Jedlicka et al., 2015](#bib50); [Bienenstock et al., 1982](#bib7); [Abraham, 2008](#bib2); [Cooper and Bear, 2012](#bib25)). Third, the time course of BTSP is determined by temporal overlap between slow eligibility signals associated with synaptic activity and slow IS associated with plateau potentials. This selects a subpopulation of synaptic inputs activated with appropriate timing to undergo a change in synaptic strength ([Figure 6—figure supplement 3](https://elifesciences.org/articles/73046/figures#fig6s3)). Finally, IS are internal signals activated by dendritic plateau potentials, rather than by spiking output, arguing that BTSP is not simply a variant of Hebbian plasticity that depends on input-output correlations over a longer timescale.

The above observations imply that BTSP could enable spatial representations to be shaped non-autonomously by delayed behavioral outcomes, if dendritic inputs carrying information about those outcomes are able to evoke plateau potentials ([Muller et al., 2019](#bib78)). To evaluate the feasibility and implications of this theory, we next considered the conditions that are required for dendritic plateau potentials to be generated in the context of the hippocampal neural circuit. Previous work has shown that (1) plateau potentials are positively regulated by excitatory inputs from entorhinal cortex ([Bittner et al., 2015](#bib8); [Takahashi and Magee, 2009](#bib100); [Milstein et al., 2015](#bib71)), (2) they are negatively regulated by dendrite-targeting inhibition ([Grienberger et al., 2017](#bib38); [Milstein et al., 2015](#bib71); [Lovett-Barron et al., 2012](#bib58); [Royer et al., 2012](#bib88); [Palmer et al., 2012](#bib82)), (3) they occur more frequently in novel environments ([Cohen et al., 2017](#bib23)) and precede the emergence of new place fields ([Sheffield et al., 2017](#bib93)), and (4) introduction of a fixed reward site induces large shifts in the place field locations of many place cells in a population, as assayed by calcium imaging ([Turi et al., 2019](#bib102)). In order to explore the consequences of these regulatory mechanisms on memory storage by BTSP at the network level, we next constructed a network model of the CA1 microcircuit that incorporates these critical elements to regulate plateau initiation ([Figure 7A](#fig7)) and implements the above-described weight-dependent model of BTSP ([Figures 5](#fig5) and [^4]) at each input to the network.

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig7-v3.tif/full/1234,/0/default.webp)

Bidirectional behavioral timescale synaptic plasticity (BTSP) enables rapid adaptation of population representations in a network model. ( A ) Diagram depicts components of a hippocampal network model. A population of CA1 pyramidal neurons receives spatially tuned excitatory input from a population of CA3 place cells and a long-range … see more

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig7-figsupp1-v3.tif/full/1234,/0/default.webp)

New place field acquisition and pre-existing place field translocation in a network model of goal-directed navigation (related to ). ( A – C ) Data shown are derived from the network model results from Figure 7. ( A ) Histogram depicts neurons recruited to express new place fields in each spatial bin (epochs: novel explore, blue; … see more

In a population of 500 firing rate model CA1 pyramidal neurons, plateaus were positively regulated by a long-range feedback input from entorhinal cortex and negatively regulated by local feedback inhibition ([Figure 7A and B](#fig7); [Stefanelli et al., 2016](#bib98)). Generation of plateau potentials within the population of CA1 neurons in the model was stochastic, which would result from fluctuations in inputs from entorhinal cortex that occasionally cross a threshold for the generation of a plateau potential in different cells at different times. The presence of reward delivered at a fixed goal location was implemented as an increase in input from entorhinal cortex ([Boccara et al., 2019](#bib10); [Butler et al., 2019](#bib17)), although an equivalent increase in plateau generation could result instead from neuromodulatory input that directly increased dendritic excitability or reduced dendritic inhibition ([Sjöström et al., 2008](#bib95); [Pi et al., 2013](#bib84); [Tyan et al., 2014](#bib104); [Guerguiev et al., 2017](#bib39)).

During goal-directed navigation, hippocampal neurons have been shown to preferentially acquire new place fields near behaviorally relevant locations, and to translocate existing place fields toward those locations ([Dupret et al., 2010](#bib27); [Zaremba et al., 2017](#bib108); [Turi et al., 2019](#bib102); [Hollup et al., 2001](#bib46); [Gauthier and Tank, 2018](#bib31); [Lee et al., 2020](#bib54)). We modeled this situation by simulating a virtual animal running on a circular treadmill for three separate phases of exploration ([Figure 7C](#fig7)). At each time step (10 ms), instantaneous plateau probabilities were computed for each cell ([Figure 7B](#fig7)), determining which neurons would initiate a dendritic plateau and undergo plasticity. During the first few laps of simulated exploration, CA1 pyramidal neurons rapidly acquired place fields that, as a population, uniformly tiled the track ([Figure 7C and D](#fig7)). As neurons increased their activity over time, feedback inhibition increased proportionally and prevented further plasticity ([Figure 7A–C](#fig7)). During the next phase a goal was presented at a fixed location, resulting in both acquisition of new place fields nearby the goal location in a population of initially silent neurons, and translocation of place fields toward the goal location in a separate population of cells with pre-existing fields ([Figure 7E](#fig7), left; [Figure 7—figure supplement 1](https://elifesciences.org/articles/73046/figures#fig7s1)). Overall, this resulted in an increased proportion of place cells with fields near the goal position ([Figure 7E](#fig7), right), recapitulating experimentally observed modifications in CA1 network activity during goal-directed behavior ([Zaremba et al., 2017](#bib108)). The asymmetric time course of BTSP caused the population representation of the goal in the model to peak before the goal location itself, producing a predictive memory representation of the path leading to the goal ([Mehta et al., 1997](#bib66); [Stachenfeld et al., 2017](#bib97)). Simulated place cell activity remained stable in a final phase of exploration without reward ([Figure 7C](#fig7) and [Figure 7—figure supplement 1](https://elifesciences.org/articles/73046/figures#fig7s1)). These network modeling results demonstrate that plasticity regulated by local network activity and long-range feedback, rather than by pairwise correlations, can enable populations of place cells to rapidly adapt their spatial representations to changes in the environment without any compromise in selectivity.

In summary, we observed translocation of hippocampal place fields by dendritic plateau potentials and characterized the underlying synaptic learning rule. We found that BTSP is bidirectional, inducing both synaptic potentiation and synaptic depression in neurons expressing pre-existing place fields. The direction of plasticity is determined by the synaptic weight of each excitatory input prior to a plateau potential, and the time interval between synaptic activity and a plateau. The large magnitude of synaptic weight changes enables BTSP to rapidly reshape place field activity in a small number of trials. These results corroborate recent work showing that changes in place field firing in CA1 could be induced by juxtacellular current injection, which was correlated with the occurrence of long duration complex spikes ([Diamantaki et al., 2018](#bib26)). Here, we used intracellular stimulation and recording to reliably evoke dendritic calcium spikes with precise timing and duration, and to monitor subthreshold changes in *V* <sub><i>m</i></sub> dynamics, which enabled inference of the underlying synaptic learning rule.

The time and synaptic weight dependence of BTSP suggests that it is driven by an input-specific process rather than nonselective heterosynaptic ([Lynch et al., 1977](#bib59)) or homeostatic plasticity ([Mendez et al., 2018](#bib69); [Hengen et al., 2016](#bib43)), or modulation of cellular excitability ([Chandra and Barkai, 2018](#bib20); [Titley et al., 2017](#bib101)). A significant role for changes in inhibitory synaptic weights is unlikely given that (1) inhibitory neurons in CA1 exhibit low levels of spatial selectivity ([Grienberger et al., 2017](#bib38)), (2) homosynaptic potentiation of excitatory inputs by dendritic plateau potentials can be induced with GABAergic inhibition blocked ([Bittner et al., 2017](#bib9)), and (3) inhibitory input to CA1 neurons does not change following induction of synaptic potentiation by BTSP ([Grienberger et al., 2017](#bib38)).

The voltage perturbation experiments we performed ([Figure 4](#fig4)) showed that BTSP does not depend on the activation state of the postsynaptic neuron. These results point to a fundamental difference between BTSP and existing Hebbian models of plasticity. In most previous models, including the aforementioned ‘three-factor’ plasticity models, the firing rate ([He et al., 2015](#bib42); [Brzosko et al., 2015](#bib15); [Markram et al., 1997](#bib65); [Bi and Poo, 1998](#bib6)), or sustained level of global depolarization ([Clopath et al., 2010](#bib21); [Artola et al., 1990](#bib4); [Brandalise and Gerber, 2014](#bib14)) at the time of presynaptic spiking primarily determines whether a synaptic weight increases or decreases ([Gerstner et al., 2018](#bib33); [Abbott and Nelson, 2000](#bib1); [Caporale and Dan, 2008](#bib19)). Our voltage perturbation experiments ([Figure 4](#fig4) and [Figure 4—figure supplement 2](https://elifesciences.org/articles/73046/figures#fig4s2)) show that the direction of plasticity is not determined by either global depolarization or spiking.

This lack of dependence on the postsynaptic activity or output could enable plasticity to be robust to fluctuations in postsynaptic state due to noise or network oscillations (e.g. theta or gamma) ([Buzsáki and Moser, 2013](#bib18)), and may allow the postsynaptic state to subserve other functions, such as temporal coding, without interfering with ongoing synaptic weight modifications. Furthermore, while in traditional Hebbian models of plasticity, short timescale synchrony between pre- and postsynaptic activity modifies weights to reinforce pre-existing correlations, BTSP instead provides a mechanism to either create new pairwise activity correlations ‘from scratch’, or remove pre-existing ones based on delayed outcomes. Our network model ([Figure 7](#fig7)) highlights how this fundamental element of BTSP could shape spatial memory storage at the network level, allowing neuronal circuits to rapidly acquire population-level representations of previously unencountered environmental features, and to modify outdated representations. This model also demonstrated that, if plateau potentials are generated by a mismatch between local circuit output and target information relayed by long-range feedback, BTSP can implement objective-based learning ([Richards et al., 2019b](#bib87); [Sacramento, 2018](#bib89); [Payeur et al., 2020](#bib83)).

Together our experimental and modeling results establish BTSP as a potent mechanism for rapid and reversible learning. In addition to providing insight into the fundamental mechanisms of spatial memory formation in the hippocampus, these findings suggest new directions for general theories of biological learning and the development of artificial learning systems ([Guerguiev et al., 2017](#bib39); [Payeur et al., 2020](#bib83); [Bono and Clopath, 2017](#bib11); [Richards and Lillicrap, 2019a](#bib86); [Lillicrap et al., 2020](#bib57)).

All experimental methods were approved by the Janelia or Baylor College of Medicine Institutional Animal Care and Use Committees (Protocols 12–84 and 15–126). All experimental procedures in this study, including animal surgeries, behavioral training, treadmill and rig configuration, and intracellular recordings, were performed identically to a previous detailed report ([Bittner et al., 2017](#bib9)) in an overlapping set of experiments, and are briefly summarized here.

In vivo experiments were performed in 6- to 12-week-old mice of either sex. Craniotomies above the dorsal hippocampus for simultaneous whole-cell patch clamp and local field potential (LFP) recordings, as well as affixation of head bar implants were performed under deep anesthesia. Following a week of recovery, animals were prepared for behavioral training with water restriction, handling by the experimenter, and addition of running wheels to their home cages. Mice were trained to run on the cue-enriched linear treadmill for a dilute sucrose reward delivered through a licking port once per lap (~187 cm). A MATLAB GUI interfaced with a custom microprocessor-controlled system for position-dependent reward delivery and intracellular current injection. Animal-run velocity was measured by an encoder attached to one of the wheel axles.

Plasticity was induced in vivo by injecting current (700 pA, 300 ms) intracellularly into recorded CA1 neurons to evoke dendritic plateau potentials at the same position on the circular treadmill for multiple consecutive laps. In most cases, plateaus were evoked on five consecutive laps ([Figure 1—figure supplement 1E](https://elifesciences.org/articles/73046/figures#fig1s1), left). However, during some experiments, large changes in the spatial *V* <sub><i>m</i></sub> ramp depolarization could be observed to develop after as few as one plateau (consistent with the observation that plasticity could be induced by a single spontaneously-occurring plateau), and so fewer induction laps were used. In other experiments, plateaus were induced on more than five consecutive laps if place field expression remained weak after the first five trials ([Figure 1—figure supplement 1E](https://elifesciences.org/articles/73046/figures#fig1s1), left). The source of this variability across cells/animals is not yet clear, and requires future investigation. Overall, this procedure induced changes in spatial *V* <sub><i>m</i></sub> ramp depolarization in 100% of cells in which it was attempted by three investigators. In some cells, the initial place field was first induced by this procedure, and then the procedure was repeated a second or third time in the same cell with plateaus induced at different locations. In those cases, there was no systematic difference in the number of plateaus required to induce the first place field compared to subsequent fields ([Figure 1—figure supplement 1E](https://elifesciences.org/articles/73046/figures#fig1s1), right).

Since the time window for plasticity induction by BTSP extends for seconds around each plateau, and plateaus were typically evoked on multiple consecutive laps, the changes in synaptic weights induced by BTSP depended on the run behavior of the animals across all induction laps. We showed in [Figure 3D](#fig3) that the spatial width of place fields induced by BTSP varied with the average velocity of animals across all plasticity induction laps. Another factor that contributed to the spatial width of induced fields is the proximity of the evoked plateaus to the reward site, as animals tended to stop running briefly to lick near the fixed reward site. Variability across laps in either the run velocity or the duration of pauses could pose a challenge in trying to relate spatial changes in *V* <sub><i>m</i></sub> ramp depolarization to the time delay to the plateau (see below). [Figure 1—figure supplement 1](https://elifesciences.org/articles/73046/figures#fig1s1) shows the full run trajectories of animals during all plasticity induction laps for the five representative example cells shown in [Figure 1](#fig1). While some variability across induction laps was observed, each animal tended to run consistently at similar velocities across laps.

To establish whole-cell recordings from CA1 pyramidal neurons, an extracellular LFP electrode was lowered into the dorsal hippocampus using a micromanipulator until prominent theta-modulated spiking and increased ripple amplitude was detected. Then a glass intracellular recording pipette was lowered to the same depth while applying positive pressure. The intracellular solution contained (in mM): 134 K-gluconate, 6 KCl, 10 HEPES, 4 NaCl, 0.3 MgGTP, 4 MgATP, 14 Tris-phosphocreatine, and in some recordings, 0.2% biocytin. Current-clamp recordings of intracellular membrane potential (*V* <sub><i>m</i></sub>) were amplified and digitized at 20 kHz, without correction for liquid junction potential. The silent-cell population of neurons (*n* = 29) contained recordings from 17 neurons that have been previously reported ([Bittner et al., 2017](#bib9)).

In a subset of experiments ([Figure 4](#fig4) and [Figure 4—figure supplement 2](https://elifesciences.org/articles/73046/figures#fig4s2)), in addition to position-dependent step current to evoke plateau potentials, additional current was injected either to depolarize neurons beyond spike threshold or to hyperpolarize neurons below spike threshold, during plasticity induction laps. While these perturbations to *V* <sub><i>m</i></sub> at the soma are expected to attenuate along the path to distal dendrites ([Golding et al., 2005](#bib35)), the pairing of back-propagating action potentials with synaptic inputs has been shown to significantly amplify dendritic depolarization ([Jarsky et al., 2005](#bib49); [Stuart and Häusser, 2001](#bib99); [Migliore et al., 1999](#bib70); [Schiller and Schiller, 2001](#bib91)). Simulations of a biophysically detailed CA1 place cell model with realistic morphology and distributions of dendritic ion channels ([Grienberger et al., 2017](#bib38)) suggest that somatic depolarization of a silent CA1 cell increases distal dendritic depolarization, and that somatic hyperpolarization of a place cell substantially reduces distal dendritic depolarization at the peak of its place field ([Figure 4—figure supplement 1](https://elifesciences.org/articles/73046/figures#fig4s1)).

To analyze subthreshold *V* <sub><i>m</i></sub> ramps, action potentials were first removed from raw *V* <sub><i>m</i></sub> traces and linearly interpolated, then the resulting traces were low-pass filtered (<3 Hz). For each of 100 equally sized spatial bins (~1.85 cm), *V* <sub><i>m</i></sub> ramp amplitudes were computed by averaging across 10 laps of running on the treadmill both before and after plasticity induction. The spatially binned ramp traces were then smoothed with a Savitzky-Golay filter with wrap-around. Ramp amplitude was quantified as the difference between the peak and the baseline (average of the 10% most hyperpolarized bins). For cells with a second place field induced, the same baseline *V* <sub><i>m</i></sub> value determined from the period before the second induction was also used to quantify ramp amplitude after the second induction. Plateau duration was estimated as the duration of intracellular step current injections, or as the full width at half maximum *V* <sub><i>m</i></sub> in the case of spontaneous naturally occurring plateaus.

*V* <sub><i>m</i></sub> ramp half-width ([Figure 2D](#fig2) and [Figure 6—figure supplement 1C](https://elifesciences.org/articles/73046/figures#fig6s1)) was calculated from the Δ *V* <sub><i>m</i></sub> traces as the time (s) or distance (cm) between the plateau and the final return of Δ *V* <sub><i>m</i></sub> to zero (or at least to 25% of min; see [Figure 2—figure supplement 1G](https://elifesciences.org/articles/73046/figures#fig2s1)). In most cases this only occurred on one side of the plateau, during either the running period before or after the plateau. In 5/26 inductions, the mouse ran so quickly that the Δ *V* <sub><i>m</i></sub> did not have time to reach 25% of min on either side of the plateau ([Figure 2—figure supplement 1G](https://elifesciences.org/articles/73046/figures#fig2s1)), resulting in an underestimation of the ramp half-width. The average velocity was calculated as the mean velocity of the mouse from the plateau to the end of the plasticity ([Figure 2—figure supplement 1](https://elifesciences.org/articles/73046/figures#fig2s1)).

In order to relate spatial changes in *V* <sub><i>m</i></sub> ramp depolarization to the time delay to a plateau (e.g. [Figures 2E, F](#fig2) — [4B, C, E, F](#fig4) – [6E](#fig6)), we assigned to each spatial position the shortest time delay to plateau that occurred across multiple induction laps ([Figure 1—figure supplement 1](https://elifesciences.org/articles/73046/figures#fig1s1)). This is a conservative estimate, as the shortest delay between presynaptic activity and postsynaptic plateau will generate the largest overlap between ET and IS, and will result in the largest changes in synaptic weight. While this method is imperfect and did discard variability in running behavior across laps, it enabled direct comparison of the time course of BTSP across neurons. We also note that, to generate the modeling results shown in [Figure 6](#fig6), the full run trajectory of each animal during all induction laps, including pauses, was provided as input to the model (see details below). This resulted in good quantitative agreement between experimentally recorded and modeled spatial *V* <sub><i>m</i></sub> ramps ([Figure 6D](#fig6)). Since not all possible pairs of initial ramp amplitude and time delay relative to plateau onset were sampled in the experimental dataset, expected changes in ramp amplitude (e.g. [Figure 3I](#fig3)) were predicted from the sampled experimental or model data points by a two-dimensional Gaussian process regression and interpolation procedure using a rational quadratic covariance function, implemented in the open-source Python package sklearn ([Abraham et al., 2014](#bib3); [Rasmussen and Williams, 2006](#bib85)).

To statistically compare Δ *V* <sub><i>m</i></sub> vs. time plots among groups each individual induction trace was binned in time (average of values in 80, 100 ms, bins from –4 to +4 s). The number of points in each bin for each group is as follows: silent cells (−4, + 4 s): *n* = 19, 19, 19, 0, 20, 20, 21, 21, 25, 26, 26, 27, 27, 27, 27, 27, 28, 28, 28, 28, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 27, 25, 25, 25, 24, 21, 20, 19, 17, 16, 14, 14, 10, 9, 9, 8, 8, 7, 7, 7, 7, 7, 6, 6, 6, 6, 6. Silent + depolarization (−4, + 4 s): *n* = 2, 2, 4, 5, 5, 6, 6, 6, 6, 6, 6, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 7, 7, 6, 6, 6, 6, 5, 5, 5, 5, 3, 3. Depolarized PCs (–4 to +4 s): *n* = 6, 6, 6, 6, 6, 5, 5, 5, 4, 4, 5, 6, 6, 6, 7, 7, 6, 6, 6, 7, 7, 8, 7, 7, 7, 7, 6, 6, 5, 5, 5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 6, 7, 8, 8, 8, 9, 10, 14, 14, 15, 15, 15, 15, 15, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 13, 12, 12, 10, 9, 9. All PCs (–1 to +4 s): *n* = 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 25, 24, 24. PCs + hyperpolarization (–1 to +4 s): *n* = 5, 6, 6, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8. Silent+ large hyperpolarization (–4 to +4): *n* = 4, 4, 4, 4, 5, 5, 5, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 6, 6, 6, 6, 5, 5, 5, 5, 5, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2.

Statistical details of experiments can be found in the figure legends. Unless otherwise specified, measured values and ranges reflect mean ± SEM. Significance was defined as p < 0.05. Sample sizes were not determined by statistical methods, but efforts were made to collect as many samples as was technically feasible. No data or subjects were excluded from any analysis.

In [Figures 5](#fig5) and [^4], we provide a mathematical model of the synaptic learning rule underlying bidirectional BTSP. In this ‘weight-dependent’ model, the direction and magnitude of plasticity at excitatory synapses from spatially tuned CA3 place cell inputs onto a CA1 pyramidal cell are determined by (1) the timing of presynaptic spiking relative to postsynaptic plateau potentials and (2) the current weight of each synapse just prior to a plateau. While in [Figure 5](#fig5), discrete spikes were provided as presynaptic inputs to the model, in [Figure 6](#fig6), presynaptic inputs were provided as continuous firing rates. This model contained nine free parameters (described in detail below), which were fit to the experimental data using an iterative, bounded, stochastic search procedure based on the simulated annealing algorithm ([Milstein, 2021a](#bib72); [Milstein, 2021b](#bib73)). This optimization sought to minimize the difference between the experimentally recorded place cell *V* <sub><i>m</i></sub> ramp depolarizations ([Figures 1](#fig1) — [^2]) and those predicted by the model ([Figure 6D and E](#fig6)). Parameter optimization was considered to converge after sampling 30,000 distinct model configurations. Below we describe the model formulation in detail.

A CA1 place cell was modeled as receiving excitatory input from a population of 200 CA3 place cells with spatially tuned firing fields spaced uniformly across an ~185 cm circular track ([Figure 3J](#fig3)). The firing rate $R_{i}$ of an individual input $i$ with place field at position $y_{i}$ depended on the recorded run trajectory of the animal $x \left(t\right)$ ([Figure 6A](#fig6), first and second rows):

(6) 
$$
R_{i} \left(t\right) = R_{m a x} * e^{- \frac{1}{2} \left(\frac{y_{i} - x \left(t\right)}{\sigma}\right)^{2}}
$$

where $R_{m a x}$ is a maximum firing rate of 40 Hz at the peak of a place field, and $\sigma$ determines the width of the place field. $\sigma$ was set such that CA3 place field inputs had a full floor width ($6 * \sigma$) of 90 cm (half-width of ~34 cm) ([Mizuseki et al., 2012](#bib75)), though models tuned with alternative values of $\sigma$ generated quantitatively similar predictions (‘60 cm input field widths’ in [Figure 6—figure supplement 2](https://elifesciences.org/articles/73046/figures#fig6s2)). The complete run trajectory of each animal during consecutive plasticity induction laps, including pauses in running between laps, was provided as a continuous input to the model. In accordance with experimental data ([Bittner et al., 2015](#bib8); [Grienberger et al., 2017](#bib38)), the firing rates of model place cell inputs were set to zero during periods when the animal stopped running.

The *V <sub>m</sub>* ramp depolarization of a CA1 place cell as a function of position, $V \left(x\right)$ *,* was modeled as a weighted sum of the spatial firing rates of the CA3 place cell inputs. We assumed that in silent cells prior to plasticity induction, all inputs had an initial synaptic weight of 1. This produced a background level of depolarization, $V_{b}$, which was subtracted from the total weighted sum to calculate the ramp amplitude ([Figure 6C–E](#fig6)):

(7) 
$$
V \left(x\right) = c * \sum_{i} W_{i} * R_{i} \left(x\right) - V_{b}
$$

The scaling factor $c$ was calibrated such that if the synaptic weights of CA3 place cell inputs varied between 1 and 2.5 as a Gaussian function of their place field locations, the postsynaptic CA1 cell would express a *V* <sub><i>m</i></sub> ramp with 108 cm width and 6 mV peak amplitude, consistent with previous measurements of place field properties and the degree of synaptic potentiation by BTSP ([Bittner et al., 2017](#bib9)). For CA1 place cells already expressing a place field before plateaus were evoked at a second location, the initial synaptic weights were estimated by using least squares approximation to fit the experimentally recorded initial *V* <sub><i>m</i></sub> ramp.

At each input $i$, a postsynaptic eligibility trace $\left(E T\right)_{i}$ was activated by presynaptic firing $R_{i}$ and decayed with a seconds-long time course $\tau_{E T}$ ([Figure 6A](#fig6), third row):

(8) 
$$
\tau_{E T} * \frac{d E T_{i}}{d t} = - E T_{i} + \lambda_{E T} * R_{i}
$$

The scaling factor $\lambda_{E T}$ was chosen such that the maximum amplitude of $E T$ does not exceed 1. For single spike inputs, as shown in [Figure 5](#fig5), the firing rate $R_{i}$ was replaced with a delta function $\delta \left(t - t^{s}\right)$ where $t^{s}$ is the time of the spike.

Postsynaptic dendritic plateau potentials during each induction lap *µ* with onset at time $t^{p}$ and duration $d$ activated an instructive signal $I S$ that was broadcast to all synapses and decayed exponentially with time course $\tau_{I S}$ ([Figure 6A](#fig6), fourth row):

(9) 
$$
\tau_{I S} * \frac{d I S}{d t} = - I S + \lambda_{I S} * P \left(t^{p} , d\right)
$$

where $P$ is a binary function that takes a value of 1 during a plateau and 0 otherwise. The scaling factor $\lambda_{I S}$ was chosen such that the maximum amplitude of $I S$ does not exceed 1. The duration of experimentally induced plateaus were typically 300 ms, but spontaneous plateaus were recorded with duration up to ~800 ms.

Next, temporal overlap of eligibility traces $\left(E T\right)_{i}$ and instructive signals $I S$ ([Figure 6A](#fig6), fifth row) were considered to drive saturable potentiation and depression processes independently at each synapse. The sensitivity of these two processes $q^{+}$ and $q^{-}$ to the amplitude of plasticity signal overlap was defined by generalized sigmoid functions $s \left(x , \alpha , \beta\right)$ with a scale and offset to meet the following edge constraints: $s = 0$ when $x = 0$, $s = 1$ when $x = 1$:

(10) 
$$
\hat{s} \left(x , \alpha , \beta\right) = \frac{1}{1 + e^{\left(- \beta \left(x - \alpha\right)\right)}}
$$

(11) 
$$
s \left(x , \alpha , \beta\right) = \frac{\hat{s} \left(x , \alpha , \beta\right) - \hat{s} \left(0 , \alpha , \beta\right)}{\hat{s} \left(1 , \alpha , \beta\right) - \hat{s} \left(0 , \alpha , \beta\right)}
$$

(12) 
$$
q^{+} \left(E T_{i} * I S\right) = s \left(E T_{i} * I S , \alpha^{+} , \beta^{+}\right)
$$

(13) 
$$
q^{-} \left(E T_{i} * I S\right) = s \left(E T_{i} * I S , \alpha^{-} , \beta^{-}\right)
$$

where $\alpha^{\pm}$ and $\beta^{\pm}$ control the threshold and slope of the sigmoidal gain functions for potentiation and depression.

Finally, to capture the dependency of changes in synaptic weight $\frac{d W_{i} \left(t\right)}{d t}$ on the current value of synaptic weight $W_{i}$ at each input $i$ during plasticity induction, we chose a two-state non-stationary kinetic model of the following form:

(14) 
$$
\begin{matrix}I n a c t i v e \\ I\end{matrix} \begin{matrix}\underset{←←←←←←←←←←←←←←→}{k^{+} * q^{+} \left(E T_{i} * I S\right)} \\ \overset{↔←←←←←←←←←←←←←←}{k^{-} * q^{-} \left(E T_{i} * I S\right)}\end{matrix} \begin{matrix}A c t i v e \\ A\end{matrix}
$$

According to this formulation, independent and finite synaptic resources at each synapse occupied either an inactive state *I* or an active state *A*, and transitioned between states with rates controlled by the constants $k^{\pm}$ and the gain functions $q^{\pm}$ described above. The synaptic weight of each input $W_{i}$ was defined as proportional to the occupancy of the active state *A*:

(15) 
$$
W_{i} = A * W_{m a x}
$$

where $0 \leq A \leq 1$, and $W_{m a x}$ is a free parameter controlling the maximum value of synaptic weight. Since the occupancy of each state in a kinetic model constrains the flow of finite resources between states, the net change in synaptic weight $\frac{d W_{i}}{d t}$ at each input $i$ naturally depended on the current value of synaptic weight $W_{i}$:

(16) 
$$
\frac{d W_{i}}{d t} = \left(W_{m a x} - W_{i}\right) * k^{+} * q^{+} \left(E T_{i} * I S\right) - W_{i} * k^{+} * q^{-} \left(E T_{i} * I S\right)
$$

Changes in synaptic weight $\Delta W_{i}$ were calculated by integrating the net rate of change of synaptic weight $\frac{d W_{i}}{d t}$ over the duration of plasticity induction. In practice, for simplicity and efficiency of computation during parameter optimization, we numerically approximated $\Delta W_{i}$ by holding the value of $W_{i}$ constant for the duration of each induction lap, and updating $W_{i}$ once at the end of each induction lap ([Figure 6](#fig6)). Equivalent results were obtained by updating $W_{i}$ continuously in 10 ms steps without requiring any change in parameters.

The weight-dependent model of the BTSP rule contained nine free parameters. The range of parameter values that fit the experimental data (*n* = 26 plasticity inductions in 24 neurons with pre-existing place fields) were as follows (mean ± SEM): (1) $\tau_{E T}$: 863.91 ± 113.93 ms, (2) $\tau_{I S}$: 542.76 ± 95.47 ms, (3) $\alpha^{+}$: 0.24 ± 0.05, (4) $\beta^{+}$: 30.32 ± 6.50, (5) $\alpha^{-}$: 0.09 ± 0.04, (6) $\beta^{-}$: 2260.61 ± 1529.97, (7) $k^{+}$: 2.27 ± 0.49/s, (8) $k^{-}$: 0.33 ± 0.11/s, (9) $W_{m a x}$: 4.02 ± 0.17. The results of the model in response to simpler single-spike inputs in [Figure 5A–C](#fig5) were obtained with the following parameter values: (1) $\tau_{E T}$: 2500 ms, (2) $\tau_{I S}$: 1500 ms, (3) $\alpha^{+}$: 0.5, (4) $\beta^{+}$: 4, (5) $\alpha^{-}$: 0.01, (6) $\beta^{-}$: 44.44, (7) $k^{+}$: 1.7/ s, (8) $k^{-}$: 0.204/s, (9) $W_{m a x}$: 5.

Given the complexity of the above model, we also tested a number of alternative formulations to determine if the experimental data could be accounted for by a simpler model. First, we tested whether the filter time constants $$ and $$ that control the duration of the $E T$ and $I S$ could be shorter by constraining their values during parameter optimization to be less than 50 ms. This model variant performed poorly in predicting the depression component of BTSP (‘short timescale ET and IS’ in [Figure 5E](#fig5) and [Figure 6—figure supplement 2A and B](https://elifesciences.org/articles/73046/figures#fig6s2)). This supports the notion that intermediate signals with durations longer than either voltage or calcium are required for the long timescale of BTSP. This also demonstrates that the nonlinear gain functions $q^{\pm}$ are not able to compensate for shorter duration $E T$ or $I S$.

Next, we determined whether the nonlinear gain functions $q^{\pm}$ could instead be linear by replacing both the sigmoidal $q^{+}$ and $q^{-}$ with the identity function:

(17) 
$$
q^{+} \left(E T_{i} * I S\right) = E T_{i} * I S
$$

(18) 
$$
q^{-} \left(E T_{i} * I S\right) = E T_{i} * I S
$$

This model variant also failed to account for synaptic depression by BTSP (‘linear *q* <sup>+</sup> and *q* <sup>−</sup> ’ in [Figure 5D](#fig5) and [Figure 6—figure supplement 2A and B](https://elifesciences.org/articles/73046/figures#fig6s2)), suggesting that nonlinearity of bidirectional plasticity is an important feature of the weight-dependent BTSP model.

To investigate the implications of bidirectional BTSP for spatial learning by a population of CA1 place cells ([Figure 7](#fig7)), we constructed a network model comprised of 500 CA1 pyramidal cells each receiving input from a population of 200 CA3 place cells with place fields spaced at regular intervals spanning the ~185 cm circular track. The synaptic weights at inputs from model CA3 place cells to model CA1 cells were controlled by the weight-dependent model described above ([Figures 5](#fig5) and [^4]). For this purpose, the nine free parameters of the model were calibrated to match synthetic target *V* <sub><i>m</i></sub> ramp data as follows: (1) lap running was simulated at a constant run velocity of 25 cm/s, (2) in an initially silent cell, plasticity was induced by three consecutive laps with one 300 ms long plateau per lap evoked at a fixed location, (3) after plasticity, the induced place field *V* <sub><i>m</i></sub> ramp had an asymmetric shape (~75 cm rise, ~ 35 cm decay) and a peak amplitude of 8 mV, (4) three additional plasticity induction laps with plateaus evoked at a location 3 s behind the peak location of the initial place field resulted in a 5 mV decrease in ramp amplitude at the initial peak location, and an 8 mV peak ramp amplitude at the new translocated peak position.

Before simulated exploration, all synaptic weights were initialized to a value of 1, which resulted in zero ramp depolarization in all model CA1 cells. Under these baseline conditions, each model CA1 neuron $k$ had a probability $p_{k} \left(t\right) = p^{b a s a l} = 0.0075$ of emitting a single dendritic plateau potential in 1 s of running. During each 10 ms time step, this instantaneous probability $p_{k} \left(t\right)$ was used to weight biased coin flips to determine which cells would emit a plateau. This stochasticity can be thought of as reflecting fluctuations in the synaptic input arriving to each cell from the long-range cortical input pathway that occasionally drives the neuron to cross a threshold for generation of a dendritic calcium spike. If a cell emitted a plateau, it persisted for a fixed duration of 300 ms and was followed by a 500 ms refractory period during which $p_{k} \left(t\right)$ was transiently set to zero.

After the first lap, CA1 neurons that had emitted at least one plateau and had induced synaptic potentiation produced nonzero ramp depolarizations ([Figure 7C](#fig7)). The output firing rates $R_{\mu , k}^{C A 1}$ of each CA1 neuron $k$ on lap *µ* were considered to be proportional to their ramp depolarizations $V_{\mu , k} \left(t\right)$ after subtracting a threshold depolarization of 2 mV. The activity $R_{\mu}^{I N H} \left(t\right)$ of a single inhibitory feedback element was set to be a normalized sum of the activity of the entire population of CA1 pyramidal neurons:

(19) 
$$
R_{\mu}^{I N H} \left(t\right) = \lambda * \underset{k}{\sum} R_{\mu , k}^{C A 1} \left(t\right)
$$

where the normalization constant $\lambda$ was chosen such that the activity of the inhibitory feedback neuron would be one if every CA1 pyramidal neuron expressed a single place field and as a population their place field peak locations uniformly tiled the track. Then, the probability that any CA1 neuron *k* would emit a plateau $p_{k} \left(t\right)$ was negatively regulated by the inhibitory feedback term $R_{\mu}^{I N H} \left(t\right)$:

(20) 
$$
p_{k} \left(t\right) = \begin{cases} s \left(R_{\mu}^{I N H} \left(t\right) , \alpha^{b a s a l} , \beta^{b a s a l}\right) & R_{\mu}^{I N H} \left(t\right) < \alpha^{b a s a l} \\ 0 & R_{\mu}^{I N H} \left(t\right) \geq \alpha^{b a s a l} \end{cases}
$$

where $\alpha^{b a s a l}$ defined a target normalized population activity (set to 0.5) and $\beta^{b a s a l}$ defined the slope of a descending sigmoid function with a maximum value of 0.0075 ([Figure 7B](#fig7)).

In some laps, a specific location was assigned as the target of a goal-directed search. To mimic an increase in the activity of the long-range input from entorhinal cortex signaling the presence of the goal, the probability that a CA1 neuron would emit a plateau potential $p_{k} \left(t\right)$ was transiently increased when the simulated animal crossed the goal location for a period of 500 ms. Within the goal region, the relationship between $p_{k} \left(t\right)$ and $R_{\mu}^{I N H} \left(t\right)$ was instead:

(21) 
$$
p_{k} \left(t\right) = \begin{cases} s \left(R_{\mu}^{I N H} \left(t\right) , \alpha^{g o a l} , \beta^{g o a l}\right) & R_{\mu}^{I N H} \left(t\right) < \alpha^{g o a l} \\ 0 & R_{\mu}^{I N H} \left(t\right) \geq \alpha^{g o a l} \end{cases}
$$

where $\alpha^{g o a l}$ is an elevated target normalized population activity (set to 1.0) and $\beta^{g o a l}$ defines the slope of a descending sigmoid function with a maximum value of 0.035, corresponding to an elevated peak plateau probability ([Figure 7B](#fig7)).

The complete dataset and Python code for data analysis and model simulation is available at [https://github.com/neurosutras/BTSP](https://github.com/neurosutras/BTSP) ([Milstein, 2021c](#bib74) copy archived at [swh:1:rev:952cbb453ae80b2efe52f2936baa03e3a4689dc5](https://archive.softwareheritage.org/swh:1:dir:cda92d64e4759766b3860371e6bd87a13f302768;origin=https://github.com/neurosutras/BTSP;visit=swh:1:snp:93f4e56542da6f05ab3ed2f7419b6b3335be934c;anchor=swh:1:rev:952cbb453ae80b2efe52f2936baa03e3a4689dc5)).

The complete dataset, Python code for data analysis and model simulation, and additional MATLAB and Igor analysis scripts are available at [https://github.com/neurosutras/BTSP](https://github.com/neurosutras/BTSP) (copy archived at [swh:1:rev:952cbb453ae80b2efe52f2936baa03e3a4689dc5](https://archive.softwareheritage.org/swh:1:dir:cda92d64e4759766b3860371e6bd87a13f302768;origin=https://github.com/neurosutras/BTSP;visit=swh:1:snp:93f4e56542da6f05ab3ed2f7419b6b3335be934c;anchor=swh:1:rev:952cbb453ae80b2efe52f2936baa03e3a4689dc5)).

The following data sets were generated

1. 1. [Abbott LF](https://scholar.google.com/scholar?q=%22author:Abbott+LF%22)
	2. [Nelson SB](https://scholar.google.com/scholar?q=%22author:Nelson+SB%22)
	(2000) [Synaptic plasticity: taming the beast](https://doi.org/10.1038/81453)
	*Nature Neuroscience* **3**:1178–1183.
	[https://doi.org/10.1038/81453](https://doi.org/10.1038/81453)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/11127835)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Synaptic+plasticity%3A+taming+the+beast&author=Abbott+LF&author=Nelson+SB&publication_year=2000&journal=Nature+Neuroscience&volume=3&pages=pp.+1178%E2%80%931183&pmid=11127835)
2. 1. [Abraham WC](https://scholar.google.com/scholar?q=%22author:Abraham+WC%22)
	(2008) [Metaplasticity: tuning synapses and networks for plasticity](https://doi.org/10.1038/nrn2356)
	*Nature Reviews. Neuroscience* **9**:387.
	[https://doi.org/10.1038/nrn2356](https://doi.org/10.1038/nrn2356)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/18401345)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Metaplasticity%3A+tuning+synapses+and+networks+for+plasticity&author=Abraham+WC&publication_year=2008&journal=Nature+Reviews.+Neuroscience&volume=9&pages=387&pmid=18401345)
3. 1. [Abraham A](https://scholar.google.com/scholar?q=%22author:Abraham+A%22)
	2. [Pedregosa F](https://scholar.google.com/scholar?q=%22author:Pedregosa+F%22)
	3. [Eickenberg M](https://scholar.google.com/scholar?q=%22author:Eickenberg+M%22)
	4. [Gervais P](https://scholar.google.com/scholar?q=%22author:Gervais+P%22)
	5. [Mueller A](https://scholar.google.com/scholar?q=%22author:Mueller+A%22)
	6. [Kossaifi J](https://scholar.google.com/scholar?q=%22author:Kossaifi+J%22)
	7. [Gramfort A](https://scholar.google.com/scholar?q=%22author:Gramfort+A%22)
	8. [Thirion B](https://scholar.google.com/scholar?q=%22author:Thirion+B%22)
	9. [Varoquaux G](https://scholar.google.com/scholar?q=%22author:Varoquaux+G%22)
	(2014) [Machine learning for neuroimaging with scikit-learn](https://doi.org/10.3389/fninf.2014.00014)
	*Frontiers in Neuroinformatics* **8**:14.
	[https://doi.org/10.3389/fninf.2014.00014](https://doi.org/10.3389/fninf.2014.00014)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/24600388)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Machine+learning+for+neuroimaging+with+scikit-learn&author=Abraham+A&author=Pedregosa+F&author%5B2%5D=Eickenberg+M&author%5B3%5D=Gervais+P&author%5B4%5D=Mueller+A&author%5B5%5D=Kossaifi+J&author%5B6%5D=Gramfort+A&author%5B7%5D=Thirion+B&author%5B8%5D=Varoquaux+G&publication_year=2014&journal=Frontiers+in+Neuroinformatics&volume=8&pages=14&pmid=24600388)
4. 1. [Beaulieu-Laroche L](https://scholar.google.com/scholar?q=%22author:Beaulieu-Laroche+L%22)
	2. [Harnett MT](https://scholar.google.com/scholar?q=%22author:Harnett+MT%22)
	(2018) [Dendritic Spines Prevent Synaptic Voltage Clamp](https://doi.org/10.1016/j.neuron.2017.11.016)
	*Neuron* **97**:75–82.
	[https://doi.org/10.1016/j.neuron.2017.11.016](https://doi.org/10.1016/j.neuron.2017.11.016)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/29249288)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Dendritic+Spines+Prevent+Synaptic+Voltage+Clamp&author=Beaulieu-Laroche+L&author=Harnett+MT&publication_year=2018&journal=Neuron&volume=97&pages=pp.+75%E2%80%9382&pmid=29249288)
5. 1. [Bi GQ](https://scholar.google.com/scholar?q=%22author:Bi+GQ%22)
	2. [Poo MM](https://scholar.google.com/scholar?q=%22author:Poo+MM%22)
	(1998) [Synaptic modifications in cultured hippocampal neurons: dependence on spike timing, synaptic strength, and postsynaptic cell type](https://doi.org/10.1523/JNEUROSCI.18-24-10464.1998)
	*The Journal of Neuroscience* **18**:10464–10472.
	[https://doi.org/10.1523/JNEUROSCI.18-24-10464.1998](https://doi.org/10.1523/JNEUROSCI.18-24-10464.1998)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/9852584)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Synaptic+modifications+in+cultured+hippocampal+neurons%3A+dependence+on+spike+timing%2C+synaptic+strength%2C+and+postsynaptic+cell+type&author=Bi+GQ&author=Poo+MM&publication_year=1998&journal=The+Journal+of+Neuroscience&volume=18&pages=pp.+10464%E2%80%9310472&pmid=9852584)
6. 1. [Bienenstock EL](https://scholar.google.com/scholar?q=%22author:Bienenstock+EL%22)
	2. [Cooper LN](https://scholar.google.com/scholar?q=%22author:Cooper+LN%22)
	3. [Munro PW](https://scholar.google.com/scholar?q=%22author:Munro+PW%22)
	(1982) [Theory for the development of neuron selectivity: orientation specificity and binocular interaction in visual cortex](https://doi.org/10.1523/JNEUROSCI.02-01-00032.1982)
	*The Journal of Neuroscience* **2**:32–48.
	[https://doi.org/10.1523/JNEUROSCI.02-01-00032.1982](https://doi.org/10.1523/JNEUROSCI.02-01-00032.1982)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/7054394)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Theory+for+the+development+of+neuron+selectivity%3A+orientation+specificity+and+binocular+interaction+in+visual+cortex&author=Bienenstock+EL&author=Cooper+LN&author%5B2%5D=Munro+PW&publication_year=1982&journal=The+Journal+of+Neuroscience&volume=2&pages=pp.+32%E2%80%9348&pmid=7054394)
7. 1. [Bittner KC](https://scholar.google.com/scholar?q=%22author:Bittner+KC%22)
	2. [Grienberger C](https://scholar.google.com/scholar?q=%22author:Grienberger+C%22)
	3. [Vaidya SP](https://scholar.google.com/scholar?q=%22author:Vaidya+SP%22)
	4. [Milstein AD](https://scholar.google.com/scholar?q=%22author:Milstein+AD%22)
	5. [Macklin JJ](https://scholar.google.com/scholar?q=%22author:Macklin+JJ%22)
	6. [Suh J](https://scholar.google.com/scholar?q=%22author:Suh+J%22)
	7. [Tonegawa S](https://scholar.google.com/scholar?q=%22author:Tonegawa+S%22)
	8. [Magee JC](https://scholar.google.com/scholar?q=%22author:Magee+JC%22)
	(2015) [Conjunctive input processing drives feature selectivity in hippocampal CA1 neurons](https://doi.org/10.1038/nn.4062)
	*Nature Neuroscience* **18**:1133–1142.
	[https://doi.org/10.1038/nn.4062](https://doi.org/10.1038/nn.4062)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/26167906)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Conjunctive+input+processing+drives+feature+selectivity+in+hippocampal+CA1+neurons&author=Bittner+KC&author=Grienberger+C&author%5B2%5D=Vaidya+SP&author%5B3%5D=Milstein+AD&author%5B4%5D=Macklin+JJ&author%5B5%5D=Suh+J&author%5B6%5D=Tonegawa+S&author%5B7%5D=Magee+JC&publication_year=2015&journal=Nature+Neuroscience&volume=18&pages=pp.+1133%E2%80%931142&pmid=26167906)
8. 1. [Bono J](https://scholar.google.com/scholar?q=%22author:Bono+J%22)
	2. [Clopath C](https://scholar.google.com/scholar?q=%22author:Clopath+C%22)
	(2017) [Modeling somatic and dendritic spike mediated plasticity at the single neuron and network level](https://doi.org/10.1038/s41467-017-00740-z)
	*Nature Communications* **8**:706.
	[https://doi.org/10.1038/s41467-017-00740-z](https://doi.org/10.1038/s41467-017-00740-z)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/28951585)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Modeling+somatic+and+dendritic+spike+mediated+plasticity+at+the+single+neuron+and+network+level&author=Bono+J&author=Clopath+C&publication_year=2017&journal=Nature+Communications&volume=8&pages=706&pmid=28951585)
9. 1. [Bourboulou R](https://scholar.google.com/scholar?q=%22author:Bourboulou+R%22)
	2. [Marti G](https://scholar.google.com/scholar?q=%22author:Marti+G%22)
	3. [Michon F-X](https://scholar.google.com/scholar?q=%22author:Michon+F-X%22)
	4. [El Feghaly E](https://scholar.google.com/scholar?q=%22author:El+Feghaly+E%22)
	5. [Nouguier M](https://scholar.google.com/scholar?q=%22author:Nouguier+M%22)
	6. [Robbe D](https://scholar.google.com/scholar?q=%22author:Robbe+D%22)
	7. [Koenig J](https://scholar.google.com/scholar?q=%22author:Koenig+J%22)
	8. [Epsztein J](https://scholar.google.com/scholar?q=%22author:Epsztein+J%22)
	(2019) [Dynamic control of hippocampal spatial coding resolution by local visual cues](https://doi.org/10.7554/eLife.44487)
	*eLife* **8**:e44487.
	[https://doi.org/10.7554/eLife.44487](https://doi.org/10.7554/eLife.44487)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/30822270)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Dynamic+control+of+hippocampal+spatial+coding+resolution+by+local+visual+cues&author=Bourboulou+R&author=Marti+G&author%5B2%5D=Michon+F-X&author%5B3%5D=El+Feghaly+E&author%5B4%5D=Nouguier+M&author%5B5%5D=Robbe+D&author%5B6%5D=Koenig+J&author%5B7%5D=Epsztein+J&publication_year=2019&journal=eLife&volume=8&pages=e44487&pmid=30822270)
10. 1. [Caporale N](https://scholar.google.com/scholar?q=%22author:Caporale+N%22)
	2. [Dan Y](https://scholar.google.com/scholar?q=%22author:Dan+Y%22)
	(2008) [Spike timing-dependent plasticity: a Hebbian learning rule](https://doi.org/10.1146/annurev.neuro.31.060407.125639)
	*Annual Review of Neuroscience* **31**:25–46.
	[https://doi.org/10.1146/annurev.neuro.31.060407.125639](https://doi.org/10.1146/annurev.neuro.31.060407.125639)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/18275283)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Spike+timing-dependent+plasticity%3A+a+Hebbian+learning+rule&author=Caporale+N&author=Dan+Y&publication_year=2008&journal=Annual+Review+of+Neuroscience&volume=31&pages=pp.+25%E2%80%9346&pmid=18275283)
11. 1. [Chandra N](https://scholar.google.com/scholar?q=%22author:Chandra+N%22)
	2. [Barkai E](https://scholar.google.com/scholar?q=%22author:Barkai+E%22)
	(2018) [A non-synaptic mechanism of complex learning: Modulation of intrinsic neuronal excitability](https://doi.org/10.1016/j.nlm.2017.11.015)
	*Neurobiology of Learning and Memory* **154**:30–36.
	[https://doi.org/10.1016/j.nlm.2017.11.015](https://doi.org/10.1016/j.nlm.2017.11.015)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/29196146)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=A+non-synaptic+mechanism+of+complex+learning%3A+Modulation+of+intrinsic+neuronal+excitability&author=Chandra+N&author=Barkai+E&publication_year=2018&journal=Neurobiology+of+Learning+and+Memory&volume=154&pages=pp.+30%E2%80%9336&pmid=29196146)
12. 1. [Clopath C](https://scholar.google.com/scholar?q=%22author:Clopath+C%22)
	2. [Gerstner W](https://scholar.google.com/scholar?q=%22author:Gerstner+W%22)
	(2010) [Voltage and Spike Timing Interact in STDP - A Unified Model](https://doi.org/10.3389/fnsyn.2010.00025)
	*Frontiers in Synaptic Neuroscience* **2**:25.
	[https://doi.org/10.3389/fnsyn.2010.00025](https://doi.org/10.3389/fnsyn.2010.00025)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/21423511)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Voltage+and+Spike+Timing+Interact+in+STDP+-+A+Unified+Model&author=Clopath+C&author=Gerstner+W&publication_year=2010&journal=Frontiers+in+Synaptic+Neuroscience&volume=2&pages=25&pmid=21423511)
13. 1. [Cone I](https://scholar.google.com/scholar?q=%22author:Cone+I%22)
	2. [Shouval HZ](https://scholar.google.com/scholar?q=%22author:Shouval+HZ%22)
	(2021) [Behavioral Time Scale Plasticity of Place Fields: Mathematical Analysis](https://doi.org/10.3389/fncom.2021.640235)
	*Frontiers in Computational Neuroscience* **15**:640235.
	[https://doi.org/10.3389/fncom.2021.640235](https://doi.org/10.3389/fncom.2021.640235)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/33732128)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Behavioral+Time+Scale+Plasticity+of+Place+Fields%3A+Mathematical+Analysis&author=Cone+I&author=Shouval+HZ&publication_year=2021&journal=Frontiers+in+Computational+Neuroscience&volume=15&pages=640235&pmid=33732128)
14. 1. [Cooper LN](https://scholar.google.com/scholar?q=%22author:Cooper+LN%22)
	2. [Bear MF](https://scholar.google.com/scholar?q=%22author:Bear+MF%22)
	(2012) [The BCM theory of synapse modification at 30: interaction of theory with experiment](https://doi.org/10.1038/nrn3353)
	*Nature Reviews. Neuroscience* **13**:798–810.
	[https://doi.org/10.1038/nrn3353](https://doi.org/10.1038/nrn3353)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/23080416)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=The+BCM+theory+of+synapse+modification+at+30%3A+interaction+of+theory+with+experiment&author=Cooper+LN&author=Bear+MF&publication_year=2012&journal=Nature+Reviews.+Neuroscience&volume=13&pages=pp.+798%E2%80%93810&pmid=23080416)
15. 1. [Diamantaki M](https://scholar.google.com/scholar?q=%22author:Diamantaki+M%22)
	2. [Coletta S](https://scholar.google.com/scholar?q=%22author:Coletta+S%22)
	3. [Nasr K](https://scholar.google.com/scholar?q=%22author:Nasr+K%22)
	4. [Zeraati R](https://scholar.google.com/scholar?q=%22author:Zeraati+R%22)
	5. [Laturnus S](https://scholar.google.com/scholar?q=%22author:Laturnus+S%22)
	6. [Berens P](https://scholar.google.com/scholar?q=%22author:Berens+P%22)
	7. [Preston-Ferrer P](https://scholar.google.com/scholar?q=%22author:Preston-Ferrer+P%22)
	8. [Burgalossi A](https://scholar.google.com/scholar?q=%22author:Burgalossi+A%22)
	(2018) [Manipulating Hippocampal Place Cell Activity by Single-Cell Stimulation in Freely Moving Mice](https://doi.org/10.1016/j.celrep.2018.03.031)
	*Cell Reports* **23**:32–38.
	[https://doi.org/10.1016/j.celrep.2018.03.031](https://doi.org/10.1016/j.celrep.2018.03.031)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/29617670)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Manipulating+Hippocampal+Place+Cell+Activity+by+Single-Cell+Stimulation+in+Freely+Moving+Mice&author=Diamantaki+M&author=Coletta+S&author%5B2%5D=Nasr+K&author%5B3%5D=Zeraati+R&author%5B4%5D=Laturnus+S&author%5B5%5D=Berens+P&author%5B6%5D=Preston-Ferrer+P&author%5B7%5D=Burgalossi+A&publication_year=2018&journal=Cell+Reports&volume=23&pages=pp.+32%E2%80%9338&pmid=29617670)
16. 1. [Frey U](https://scholar.google.com/scholar?q=%22author:Frey+U%22)
	2. [Morris RG](https://scholar.google.com/scholar?q=%22author:Morris+RG%22)
	(1997) [Synaptic tagging and long-term potentiation](https://doi.org/10.1038/385533a0)
	*Nature* **385**:533–536.
	[https://doi.org/10.1038/385533a0](https://doi.org/10.1038/385533a0)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/9020359)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Synaptic+tagging+and+long-term+potentiation&author=Frey+U&author=Morris+RG&publication_year=1997&journal=Nature&volume=385&pages=pp.+533%E2%80%93536&pmid=9020359)
17. 1. [Gauthier JL](https://scholar.google.com/scholar?q=%22author:Gauthier+JL%22)
	2. [Tank DW](https://scholar.google.com/scholar?q=%22author:Tank+DW%22)
	(2018) [A Dedicated Population for Reward Coding in the Hippocampus](https://doi.org/10.1016/j.neuron.2018.06.008)
	*Neuron* **99**:179–193.
	[https://doi.org/10.1016/j.neuron.2018.06.008](https://doi.org/10.1016/j.neuron.2018.06.008)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/30008297)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=A+Dedicated+Population+for+Reward+Coding+in+the+Hippocampus&author=Gauthier+JL&author=Tank+DW&publication_year=2018&journal=Neuron&volume=99&pages=pp.+179%E2%80%93193&pmid=30008297)
18. 1. [Gerstner W](https://scholar.google.com/scholar?q=%22author:Gerstner+W%22)
	2. [Lehmann M](https://scholar.google.com/scholar?q=%22author:Lehmann+M%22)
	3. [Liakoni V](https://scholar.google.com/scholar?q=%22author:Liakoni+V%22)
	4. [Corneil D](https://scholar.google.com/scholar?q=%22author:Corneil+D%22)
	5. [Brea J](https://scholar.google.com/scholar?q=%22author:Brea+J%22)
	(2018) [Eligibility Traces and Plasticity on Behavioral Time Scales: Experimental Support of NeoHebbian Three-Factor Learning Rules](https://doi.org/10.3389/fncir.2018.00053)
	*Frontiers in Neural Circuits* **12**:53.
	[https://doi.org/10.3389/fncir.2018.00053](https://doi.org/10.3389/fncir.2018.00053)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/30108488)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Eligibility+Traces+and+Plasticity+on+Behavioral+Time+Scales%3A+Experimental+Support+of+NeoHebbian+Three-Factor+Learning+Rules&author=Gerstner+W&author=Lehmann+M&author%5B2%5D=Liakoni+V&author%5B3%5D=Corneil+D&author%5B4%5D=Brea+J&publication_year=2018&journal=Frontiers+in+Neural+Circuits&volume=12&pages=53&pmid=30108488)
19. 1. [Graupner M](https://scholar.google.com/scholar?q=%22author:Graupner+M%22)
	2. [Brunel N](https://scholar.google.com/scholar?q=%22author:Brunel+N%22)
	(2007) [STDP in a bistable synapse model based on CaMKII and associated signaling pathways](https://doi.org/10.1371/journal.pcbi.0030221)
	*PLOS Computational Biology* **3**:e221.
	[https://doi.org/10.1371/journal.pcbi.0030221](https://doi.org/10.1371/journal.pcbi.0030221)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/18052535)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=STDP+in+a+bistable+synapse+model+based+on+CaMKII+and+associated+signaling+pathways&author=Graupner+M&author=Brunel+N&publication_year=2007&journal=PLOS+Computational+Biology&volume=3&pages=e221&pmid=18052535)
20. 1. [Graupner M](https://scholar.google.com/scholar?q=%22author:Graupner+M%22)
	2. [Brunel N](https://scholar.google.com/scholar?q=%22author:Brunel+N%22)
	(2012) [Calcium-based plasticity model explains sensitivity of synaptic changes to spike pattern, rate, and dendritic location](https://doi.org/10.1073/pnas.1109359109)
	*PNAS* **109**:3991–3996.
	[https://doi.org/10.1073/pnas.1109359109](https://doi.org/10.1073/pnas.1109359109)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/22357758)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Calcium-based+plasticity+model+explains+sensitivity+of+synaptic+changes+to+spike+pattern%2C+rate%2C+and+dendritic+location&author=Graupner+M&author=Brunel+N&publication_year=2012&journal=PNAS&volume=109&pages=pp.+3991%E2%80%933996&pmid=22357758)
21. 1. [Grienberger C](https://scholar.google.com/scholar?q=%22author:Grienberger+C%22)
	2. [Milstein AD](https://scholar.google.com/scholar?q=%22author:Milstein+AD%22)
	3. [Bittner KC](https://scholar.google.com/scholar?q=%22author:Bittner+KC%22)
	4. [Romani S](https://scholar.google.com/scholar?q=%22author:Romani+S%22)
	5. [Magee JC](https://scholar.google.com/scholar?q=%22author:Magee+JC%22)
	(2017) [Inhibitory suppression of heterogeneously tuned excitation enhances spatial coding in CA1 place cells](https://doi.org/10.1038/nn.4486)
	*Nature Neuroscience* **20**:417–426.
	[https://doi.org/10.1038/nn.4486](https://doi.org/10.1038/nn.4486)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/28114296)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Inhibitory+suppression+of+heterogeneously+tuned+excitation+enhances+spatial+coding+in+CA1+place+cells&author=Grienberger+C&author=Milstein+AD&author%5B2%5D=Bittner+KC&author%5B3%5D=Romani+S&author%5B4%5D=Magee+JC&publication_year=2017&journal=Nature+Neuroscience&volume=20&pages=pp.+417%E2%80%93426&pmid=28114296)
22. 1. [He K](https://scholar.google.com/scholar?q=%22author:He+K%22)
	2. [Huertas M](https://scholar.google.com/scholar?q=%22author:Huertas+M%22)
	3. [Hong SZ](https://scholar.google.com/scholar?q=%22author:Hong+SZ%22)
	4. [Tie X](https://scholar.google.com/scholar?q=%22author:Tie+X%22)
	5. [Hell JW](https://scholar.google.com/scholar?q=%22author:Hell+JW%22)
	6. [Shouval H](https://scholar.google.com/scholar?q=%22author:Shouval+H%22)
	7. [Kirkwood A](https://scholar.google.com/scholar?q=%22author:Kirkwood+A%22)
	(2015) [Distinct Eligibility Traces for LTP and LTD in Cortical Synapses](https://doi.org/10.1016/j.neuron.2015.09.037)
	*Neuron* **88**:528–538.
	[https://doi.org/10.1016/j.neuron.2015.09.037](https://doi.org/10.1016/j.neuron.2015.09.037)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/26593091)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Distinct+Eligibility+Traces+for+LTP+and+LTD+in+Cortical+Synapses&author=He+K&author=Huertas+M&author%5B2%5D=Hong+SZ&author%5B3%5D=Tie+X&author%5B4%5D=Hell+JW&author%5B5%5D=Shouval+H&author%5B6%5D=Kirkwood+A&publication_year=2015&journal=Neuron&volume=88&pages=pp.+528%E2%80%93538&pmid=26593091)
23. 1. [Hengen KB](https://scholar.google.com/scholar?q=%22author:Hengen+KB%22)
	2. [Torrado Pacheco A](https://scholar.google.com/scholar?q=%22author:Torrado+Pacheco+A%22)
	3. [McGregor JN](https://scholar.google.com/scholar?q=%22author:McGregor+JN%22)
	4. [Van Hooser SD](https://scholar.google.com/scholar?q=%22author:Van+Hooser+SD%22)
	5. [Turrigiano GG](https://scholar.google.com/scholar?q=%22author:Turrigiano+GG%22)
	(2016) [Neuronal Firing Rate Homeostasis Is Inhibited by Sleep and Promoted by Wake](https://doi.org/10.1016/j.cell.2016.01.046)
	*Cell* **165**:180–191.
	[https://doi.org/10.1016/j.cell.2016.01.046](https://doi.org/10.1016/j.cell.2016.01.046)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/26997481)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Neuronal+Firing+Rate+Homeostasis+Is+Inhibited+by+Sleep+and+Promoted+by+Wake&author=Hengen+KB&author=Torrado+Pacheco+A&author%5B2%5D=McGregor+JN&author%5B3%5D=Van+Hooser+SD&author%5B4%5D=Turrigiano+GG&publication_year=2016&journal=Cell&volume=165&pages=pp.+180%E2%80%93191&pmid=26997481)
24. 1. [Herring BE](https://scholar.google.com/scholar?q=%22author:Herring+BE%22)
	2. [Nicoll RA](https://scholar.google.com/scholar?q=%22author:Nicoll+RA%22)
	(2016) [Long-Term Potentiation: From CaMKII to AMPA Receptor Trafficking](https://doi.org/10.1146/annurev-physiol-021014-071753)
	*Annual Review of Physiology* **78**:351–365.
	[https://doi.org/10.1146/annurev-physiol-021014-071753](https://doi.org/10.1146/annurev-physiol-021014-071753)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/26863325)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Long-Term+Potentiation%3A+From+CaMKII+to+AMPA+Receptor+Trafficking&author=Herring+BE&author=Nicoll+RA&publication_year=2016&journal=Annual+Review+of+Physiology&volume=78&pages=pp.+351%E2%80%93365&pmid=26863325)
25. 1. [Hill AJ](https://scholar.google.com/scholar?q=%22author:Hill+AJ%22)
	(1978) [First occurrence of hippocampal spatial firing in a new environment](https://doi.org/10.1016/0014-4886\(78\)90058-4)
	*Experimental Neurology* **62**:282–297.
	[https://doi.org/10.1016/0014-4886(78)90058-4](https://doi.org/10.1016/0014-4886\(78\)90058-4)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/729680)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=First+occurrence+of+hippocampal+spatial+firing+in+a+new+environment&author=Hill+AJ&publication_year=1978&journal=Experimental+Neurology&volume=62&pages=pp.+282%E2%80%93297&pmid=729680)
26. 1. [Hollup SA](https://scholar.google.com/scholar?q=%22author:Hollup+SA%22)
	2. [Molden S](https://scholar.google.com/scholar?q=%22author:Molden+S%22)
	3. [Donnett JG](https://scholar.google.com/scholar?q=%22author:Donnett+JG%22)
	4. [Moser MB](https://scholar.google.com/scholar?q=%22author:Moser+MB%22)
	5. [Moser EI](https://scholar.google.com/scholar?q=%22author:Moser+EI%22)
	(2001) [Accumulation of hippocampal place fields at the goal location in an annular watermaze task](https://doi.org/10.1523/JNEUROSCI.21-05-01635.2001)
	*The Journal of Neuroscience* **21**:1635–1644.
	[https://doi.org/10.1523/JNEUROSCI.21-05-01635.2001](https://doi.org/10.1523/JNEUROSCI.21-05-01635.2001)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/11222654)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Accumulation+of+hippocampal+place+fields+at+the+goal+location+in+an+annular+watermaze+task&author=Hollup+SA&author=Molden+S&author%5B2%5D=Donnett+JG&author%5B3%5D=Moser+MB&author%5B4%5D=Moser+EI&publication_year=2001&journal=The+Journal+of+Neuroscience&volume=21&pages=pp.+1635%E2%80%931644&pmid=11222654)
27. 1. [Jacob V](https://scholar.google.com/scholar?q=%22author:Jacob+V%22)
	2. [Brasier DJ](https://scholar.google.com/scholar?q=%22author:Brasier+DJ%22)
	3. [Erchova I](https://scholar.google.com/scholar?q=%22author:Erchova+I%22)
	4. [Feldman D](https://scholar.google.com/scholar?q=%22author:Feldman+D%22)
	5. [Shulz DE](https://scholar.google.com/scholar?q=%22author:Shulz+DE%22)
	(2007) [Spike timing-dependent synaptic depression in the in vivo barrel cortex of the rat](https://doi.org/10.1523/JNEUROSCI.4264-06.2007)
	*The Journal of Neuroscience* **27**:1271–1284.
	[https://doi.org/10.1523/JNEUROSCI.4264-06.2007](https://doi.org/10.1523/JNEUROSCI.4264-06.2007)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/17287502)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Spike+timing-dependent+synaptic+depression+in+the+in+vivo+barrel+cortex+of+the+rat&author=Jacob+V&author=Brasier+DJ&author%5B2%5D=Erchova+I&author%5B3%5D=Feldman+D&author%5B4%5D=Shulz+DE&publication_year=2007&journal=The+Journal+of+Neuroscience&volume=27&pages=pp.+1271%E2%80%931284&pmid=17287502)
28. 1. [Jedlicka P](https://scholar.google.com/scholar?q=%22author:Jedlicka+P%22)
	2. [Benuskova L](https://scholar.google.com/scholar?q=%22author:Benuskova+L%22)
	3. [Abraham WC](https://scholar.google.com/scholar?q=%22author:Abraham+WC%22)
	(2015) [A Voltage-Based STDP Rule Combined with Fast BCM-Like Metaplasticity Accounts for LTP and Concurrent “Heterosynaptic” LTD in the Dentate Gyrus In Vivo](https://doi.org/10.1371/journal.pcbi.1004588)
	*PLOS Computational Biology* **11**:e1004588.
	[https://doi.org/10.1371/journal.pcbi.1004588](https://doi.org/10.1371/journal.pcbi.1004588)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/26544038)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=A+Voltage-Based+STDP+Rule+Combined+with+Fast+BCM-Like+Metaplasticity+Accounts+for+LTP+and+Concurrent+%E2%80%9CHeterosynaptic%E2%80%9D+LTD+in+the+Dentate+Gyrus+In+Vivo&author=Jedlicka+P&author=Benuskova+L&author%5B2%5D=Abraham+WC&publication_year=2015&journal=PLOS+Computational+Biology&volume=11&pages=e1004588&pmid=26544038)
29. 1. [Keck T](https://scholar.google.com/scholar?q=%22author:Keck+T%22)
	2. [Toyoizumi T](https://scholar.google.com/scholar?q=%22author:Toyoizumi+T%22)
	3. [Chen L](https://scholar.google.com/scholar?q=%22author:Chen+L%22)
	4. [Doiron B](https://scholar.google.com/scholar?q=%22author:Doiron+B%22)
	5. [Feldman DE](https://scholar.google.com/scholar?q=%22author:Feldman+DE%22)
	6. [Fox K](https://scholar.google.com/scholar?q=%22author:Fox+K%22)
	7. [Gerstner W](https://scholar.google.com/scholar?q=%22author:Gerstner+W%22)
	8. [Haydon PG](https://scholar.google.com/scholar?q=%22author:Haydon+PG%22)
	9. [Hübener M](https://scholar.google.com/scholar?q=%22author:H%C3%BCbener+M%22)
	10. [Lee H-K](https://scholar.google.com/scholar?q=%22author:Lee+H-K%22)
	11. [Lisman JE](https://scholar.google.com/scholar?q=%22author:Lisman+JE%22)
	12. [Rose T](https://scholar.google.com/scholar?q=%22author:Rose+T%22)
	13. [Sengpiel F](https://scholar.google.com/scholar?q=%22author:Sengpiel+F%22)
	14. [Stellwagen D](https://scholar.google.com/scholar?q=%22author:Stellwagen+D%22)
	15. [Stryker MP](https://scholar.google.com/scholar?q=%22author:Stryker+MP%22)
	16. [Turrigiano GG](https://scholar.google.com/scholar?q=%22author:Turrigiano+GG%22)
	17. [van Rossum MC](https://scholar.google.com/scholar?q=%22author:van+Rossum+MC%22)
	(2017) [Integrating Hebbian and homeostatic plasticity: the current state of the field and future research directions](https://doi.org/10.1098/rstb.2016.0158)
	*Philosophical Transactions of the Royal Society of London. Series B, Biological Sciences* **372**:20160158.
	[https://doi.org/10.1098/rstb.2016.0158](https://doi.org/10.1098/rstb.2016.0158)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/28093552)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Integrating+Hebbian+and+homeostatic+plasticity%3A+the+current+state+of+the+field+and+future+research+directions&author=Keck+T&author=Toyoizumi+T&author%5B2%5D=Chen+L&author%5B3%5D=Doiron+B&author%5B4%5D=Feldman+DE&author%5B5%5D=Fox+K&author%5B6%5D=Gerstner+W&author%5B7%5D=Haydon+PG&author%5B8%5D=H%C3%BCbener+M&author%5B9%5D=Lee+H-K&author%5B10%5D=Lisman+JE&author%5B11%5D=Rose+T&author%5B12%5D=Sengpiel+F&author%5B13%5D=Stellwagen+D&author%5B14%5D=Stryker+MP&author%5B15%5D=Turrigiano+GG&author%5B16%5D=van+Rossum+MC&publication_year=2017&journal=Philosophical+Transactions+of+the+Royal+Society+of+London.+Series+B%2C+Biological+Sciences&volume=372&pages=20160158&pmid=28093552)
30. 1. [Koester HJ](https://scholar.google.com/scholar?q=%22author:Koester+HJ%22)
	2. [Sakmann B](https://scholar.google.com/scholar?q=%22author:Sakmann+B%22)
	(1998) [Calcium dynamics in single spines during coincident pre- and postsynaptic activity depend on relative timing of back-propagating action potentials and subthreshold excitatory postsynaptic potentials](https://doi.org/10.1073/pnas.95.16.9596)
	*PNAS* **95**:9596–9601.
	[https://doi.org/10.1073/pnas.95.16.9596](https://doi.org/10.1073/pnas.95.16.9596)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/9689126)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Calcium+dynamics+in+single+spines+during+coincident+pre-+and+postsynaptic+activity+depend+on+relative+timing+of+back-propagating+action+potentials+and+subthreshold+excitatory+postsynaptic+potentials&author=Koester+HJ&author=Sakmann+B&publication_year=1998&journal=PNAS&volume=95&pages=pp.+9596%E2%80%939601&pmid=9689126)
31. 1. [Lee JS](https://scholar.google.com/scholar?q=%22author:Lee+JS%22)
	2. [Briguglio JJ](https://scholar.google.com/scholar?q=%22author:Briguglio+JJ%22)
	3. [Cohen JD](https://scholar.google.com/scholar?q=%22author:Cohen+JD%22)
	4. [Romani S](https://scholar.google.com/scholar?q=%22author:Romani+S%22)
	5. [Lee AK](https://scholar.google.com/scholar?q=%22author:Lee+AK%22)
	(2020) [The Statistical Structure of the Hippocampal Code for Space as a Function of Time, Context, and Value](https://doi.org/10.1016/j.cell.2020.09.024)
	*Cell* **183**:620–635.
	[https://doi.org/10.1016/j.cell.2020.09.024](https://doi.org/10.1016/j.cell.2020.09.024)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/33035454)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=The+Statistical+Structure+of+the+Hippocampal+Code+for+Space+as+a+Function+of+Time%2C+Context%2C+and+Value&author=Lee+JS&author=Briguglio+JJ&author%5B2%5D=Cohen+JD&author%5B3%5D=Romani+S&author%5B4%5D=Lee+AK&publication_year=2020&journal=Cell&volume=183&pages=pp.+620%E2%80%93635&pmid=33035454)
32. 1. [Lovett-Barron M](https://scholar.google.com/scholar?q=%22author:Lovett-Barron+M%22)
	2. [Turi GF](https://scholar.google.com/scholar?q=%22author:Turi+GF%22)
	3. [Kaifosh P](https://scholar.google.com/scholar?q=%22author:Kaifosh+P%22)
	4. [Lee PH](https://scholar.google.com/scholar?q=%22author:Lee+PH%22)
	5. [Bolze F](https://scholar.google.com/scholar?q=%22author:Bolze+F%22)
	6. [Sun X-H](https://scholar.google.com/scholar?q=%22author:Sun+X-H%22)
	7. [Nicoud J-F](https://scholar.google.com/scholar?q=%22author:Nicoud+J-F%22)
	8. [Zemelman BV](https://scholar.google.com/scholar?q=%22author:Zemelman+BV%22)
	9. [Sternson SM](https://scholar.google.com/scholar?q=%22author:Sternson+SM%22)
	10. [Losonczy A](https://scholar.google.com/scholar?q=%22author:Losonczy+A%22)
	(2012) [Regulation of neuronal input transformations by tunable dendritic inhibition](https://doi.org/10.1038/nn.3024)
	*Nature Neuroscience* **15**:423–430.
	[https://doi.org/10.1038/nn.3024](https://doi.org/10.1038/nn.3024)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/22246433)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Regulation+of+neuronal+input+transformations+by+tunable+dendritic+inhibition&author=Lovett-Barron+M&author=Turi+GF&author%5B2%5D=Kaifosh+P&author%5B3%5D=Lee+PH&author%5B4%5D=Bolze+F&author%5B5%5D=Sun+X-H&author%5B6%5D=Nicoud+J-F&author%5B7%5D=Zemelman+BV&author%5B8%5D=Sternson+SM&author%5B9%5D=Losonczy+A&publication_year=2012&journal=Nature+Neuroscience&volume=15&pages=pp.+423%E2%80%93430&pmid=22246433)
33. 1. [Magee JC](https://scholar.google.com/scholar?q=%22author:Magee+JC%22)
	2. [Johnston D](https://scholar.google.com/scholar?q=%22author:Johnston+D%22)
	(1997) [A synaptically controlled, associative signal for Hebbian plasticity in hippocampal neurons](https://doi.org/10.1126/science.275.5297.209)
	*Science* **275**:209–213.
	[https://doi.org/10.1126/science.275.5297.209](https://doi.org/10.1126/science.275.5297.209)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/8985013)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=A+synaptically+controlled%2C+associative+signal+for+Hebbian+plasticity+in+hippocampal+neurons&author=Magee+JC&author=Johnston+D&publication_year=1997&journal=Science&volume=275&pages=pp.+209%E2%80%93213&pmid=8985013)
34. 1. [Magee JC](https://scholar.google.com/scholar?q=%22author:Magee+JC%22)
	(1998) [Dendritic hyperpolarization-activated currents modify the integrative properties of hippocampal CA1 pyramidal neurons](https://doi.org/10.1523/JNEUROSCI.18-19-07613.1998)
	*The Journal of Neuroscience* **18**:7613–7624.
	[https://doi.org/10.1523/JNEUROSCI.18-19-07613.1998](https://doi.org/10.1523/JNEUROSCI.18-19-07613.1998)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/9742133)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Dendritic+hyperpolarization-activated+currents+modify+the+integrative+properties+of+hippocampal+CA1+pyramidal+neurons&author=Magee+JC&publication_year=1998&journal=The+Journal+of+Neuroscience&volume=18&pages=pp.+7613%E2%80%937624&pmid=9742133)
35. 1. [Magee JC](https://scholar.google.com/scholar?q=%22author:Magee+JC%22)
	2. [Grienberger C](https://scholar.google.com/scholar?q=%22author:Grienberger+C%22)
	(2020) [Synaptic Plasticity Forms and Functions](https://doi.org/10.1146/annurev-neuro-090919-022842)
	*Annual Review of Neuroscience* **43**:95–117.
	[https://doi.org/10.1146/annurev-neuro-090919-022842](https://doi.org/10.1146/annurev-neuro-090919-022842)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/32075520)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Synaptic+Plasticity+Forms+and+Functions&author=Magee+JC&author=Grienberger+C&publication_year=2020&journal=Annual+Review+of+Neuroscience&volume=43&pages=pp.+95%E2%80%93117&pmid=32075520)
36. 1. [Malinow R](https://scholar.google.com/scholar?q=%22author:Malinow+R%22)
	2. [Miller JP](https://scholar.google.com/scholar?q=%22author:Miller+JP%22)
	(1986) [Postsynaptic hyperpolarization during conditioning reversibly blocks induction of long-term potentiation](https://doi.org/10.1038/320529a0)
	*Nature* **320**:529–530.
	[https://doi.org/10.1038/320529a0](https://doi.org/10.1038/320529a0)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/3008000)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Postsynaptic+hyperpolarization+during+conditioning+reversibly+blocks+induction+of+long-term+potentiation&author=Malinow+R&author=Miller+JP&publication_year=1986&journal=Nature&volume=320&pages=pp.+529%E2%80%93530&pmid=3008000)
37. 1. [Mansuy IM](https://scholar.google.com/scholar?q=%22author:Mansuy+IM%22)
	(2003) [Calcineurin in memory and bidirectional plasticity](https://doi.org/10.1016/j.bbrc.2003.10.046)
	*Biochemical and Biophysical Research Communications* **311**:1195–1208.
	[https://doi.org/10.1016/j.bbrc.2003.10.046](https://doi.org/10.1016/j.bbrc.2003.10.046)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/14623305)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Calcineurin+in+memory+and+bidirectional+plasticity&author=Mansuy+IM&publication_year=2003&journal=Biochemical+and+Biophysical+Research+Communications&volume=311&pages=pp.+1195%E2%80%931208&pmid=14623305)
38. 1. [Mehta MR](https://scholar.google.com/scholar?q=%22author:Mehta+MR%22)
	(2004) [Cooperative LTP can map memory sequences on dendritic branches](https://doi.org/10.1016/j.tins.2003.12.004)
	*Trends in Neurosciences* **27**:69–72.
	[https://doi.org/10.1016/j.tins.2003.12.004](https://doi.org/10.1016/j.tins.2003.12.004)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/15106650)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Cooperative+LTP+can+map+memory+sequences+on+dendritic+branches&author=Mehta+MR&publication_year=2004&journal=Trends+in+Neurosciences&volume=27&pages=pp.+69%E2%80%9372&pmid=15106650)
39. 1. [Mehta MR](https://scholar.google.com/scholar?q=%22author:Mehta+MR%22)
	(2015) [From synaptic plasticity to spatial maps and sequence learning](https://doi.org/10.1002/hipo.22472)
	*Hippocampus* **25**:756–762.
	[https://doi.org/10.1002/hipo.22472](https://doi.org/10.1002/hipo.22472)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/25929239)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=From+synaptic+plasticity+to+spatial+maps+and+sequence+learning&author=Mehta+MR&publication_year=2015&journal=Hippocampus&volume=25&pages=pp.+756%E2%80%93762&pmid=25929239)
40. 1. [Migliore M](https://scholar.google.com/scholar?q=%22author:Migliore+M%22)
	2. [Hoffman DA](https://scholar.google.com/scholar?q=%22author:Hoffman+DA%22)
	3. [Magee JC](https://scholar.google.com/scholar?q=%22author:Magee+JC%22)
	4. [Johnston D](https://scholar.google.com/scholar?q=%22author:Johnston+D%22)
	(1999) [Role of an A-type K+ conductance in the back-propagation of action potentials in the dendrites of hippocampal pyramidal neurons](https://doi.org/10.1023/a:1008906225285)
	*Journal of Computational Neuroscience* **7**:5–15.
	[https://doi.org/10.1023/a:1008906225285](https://doi.org/10.1023/a:1008906225285)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/10481998)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Role+of+an+A-type+K%2B+conductance+in+the+back-propagation+of+action+potentials+in+the+dendrites+of+hippocampal+pyramidal+neurons&author=Migliore+M&author=Hoffman+DA&author%5B2%5D=Magee+JC&author%5B3%5D=Johnston+D&publication_year=1999&journal=Journal+of+Computational+Neuroscience&volume=7&pages=pp.+5%E2%80%9315&pmid=10481998)
41. Software
	1. [Milstein AD](https://scholar.google.com/scholar?q=%22author:Milstein+AD%22)
	(2021a) [Code repository for computational model of bidirectional behavioral timescale plasticity in hippocampal CA1 place cells, version 952cbb4](http://github.com/neurosutras/BTSP)
	Github.
	[http://github.com/neurosutras/BTSP](http://github.com/neurosutras/BTSP)
42. Software
	1. [Milstein AD](https://scholar.google.com/scholar?q=%22author:Milstein+AD%22)
	(2021b) [Code repository for nested: parallel multi-objective optimization software, version 509e16c](https://github.com/neurosutras/nested)
	Github.
	[https://github.com/neurosutras/nested](https://github.com/neurosutras/nested)
43. Software
	1. [Milstein AD](https://scholar.google.com/scholar?q=%22author:Milstein+AD%22)
	(2021c) [BTSP, version swh1rev952cbb453ae80b2efe52f2936baa03e3a4689dc5](https://archive.softwareheritage.org/swh:1:dir:cda92d64e4759766b3860371e6bd87a13f302768;origin=https://github.com/neurosutras/BTSP;visit=swh:1:snp:93f4e56542da6f05ab3ed2f7419b6b3335be934c;anchor=swh:1:rev:952cbb453ae80b2efe52f2936baa03e3a4689dc5)
	Software Heritage.
	[https://archive.softwareheritage.org/swh:1:dir:cda92d64e4759766b3860371e6bd87a13f302768;origin=https://github.com/neurosutras/BTSP;visit=swh:1:snp:93f4e56542da6f05ab3ed2f7419b6b3335be934c;anchor=swh:1:rev:952cbb453ae80b2efe52f2936baa03e3a4689dc5](https://archive.softwareheritage.org/swh:1:dir:cda92d64e4759766b3860371e6bd87a13f302768;origin=https://github.com/neurosutras/BTSP;visit=swh:1:snp:93f4e56542da6f05ab3ed2f7419b6b3335be934c;anchor=swh:1:rev:952cbb453ae80b2efe52f2936baa03e3a4689dc5)
44. 1. [Muller RU](https://scholar.google.com/scholar?q=%22author:Muller+RU%22)
	2. [Kubie JL](https://scholar.google.com/scholar?q=%22author:Kubie+JL%22)
	(1987)
	The effects of changes in the environment on the spatial firing of hippocampal complex-spike cells
	*The Journal of Neuroscience* **7**:1951–1968.
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/3612226)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=The+effects+of+changes+in+the+environment+on+the+spatial+firing+of+hippocampal+complex-spike+cells&author=Muller+RU&author=Kubie+JL&publication_year=1987&journal=The+Journal+of+Neuroscience&volume=7&pages=pp.+1951%E2%80%931968&pmid=3612226)
45. 1. [Oja E](https://scholar.google.com/scholar?q=%22author:Oja+E%22)
	(1982) [A simplified neuron model as a principal component analyzer](https://doi.org/10.1007/BF00275687)
	*Journal of Mathematical Biology* **15**:267–273.
	[https://doi.org/10.1007/BF00275687](https://doi.org/10.1007/BF00275687)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/7153672)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=A+simplified+neuron+model+as+a+principal+component+analyzer&author=Oja+E&publication_year=1982&journal=Journal+of+Mathematical+Biology&volume=15&pages=pp.+267%E2%80%93273&pmid=7153672)
46. 1. [O’Keefe J](https://scholar.google.com/scholar?q=%22author:O%E2%80%99Keefe+J%22)
	2. [Conway DH](https://scholar.google.com/scholar?q=%22author:Conway+DH%22)
	(1978) [Hippocampal place units in the freely moving rat: why they fire where they fire](https://doi.org/10.1007/BF00239813)
	*Experimental Brain Research* **31**:573–590.
	[https://doi.org/10.1007/BF00239813](https://doi.org/10.1007/BF00239813)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/658182)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Hippocampal+place+units+in+the+freely+moving+rat%3A+why+they+fire+where+they+fire&author=O%E2%80%99Keefe+J&author=Conway+DH&publication_year=1978&journal=Experimental+Brain+Research&volume=31&pages=pp.+573%E2%80%93590&pmid=658182)
47. Book
	1. [Rasmussen CE](https://scholar.google.com/scholar?q=%22author:Rasmussen+CE%22)
	2. [Williams CKI](https://scholar.google.com/scholar?q=%22author:Williams+CKI%22)
	(2006)
	Gaussian Processes for Machine Learning. Adaptive Computation and Machine Learning
	MIT Press.
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Gaussian+Processes+for+Machine+Learning.+Adaptive+Computation+and+Machine+Learning&author=Rasmussen+CE&author=Williams+CKI&publication_year=2006)
48. 1. [Richards BA](https://scholar.google.com/scholar?q=%22author:Richards+BA%22)
	2. [Lillicrap TP](https://scholar.google.com/scholar?q=%22author:Lillicrap+TP%22)
	(2019a) [Dendritic solutions to the credit assignment problem](https://doi.org/10.1016/j.conb.2018.08.003)
	*Current Opinion in Neurobiology* **54**:28–36.
	[https://doi.org/10.1016/j.conb.2018.08.003](https://doi.org/10.1016/j.conb.2018.08.003)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/30205266)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Dendritic+solutions+to+the+credit+assignment+problem&author=Richards+BA&author=Lillicrap+TP&publication_year=2019&journal=Current+Opinion+in+Neurobiology&volume=54&pages=pp.+28%E2%80%9336&pmid=30205266)
49. 1. [Richards BA](https://scholar.google.com/scholar?q=%22author:Richards+BA%22)
	2. [Lillicrap TP](https://scholar.google.com/scholar?q=%22author:Lillicrap+TP%22)
	3. [Beaudoin P](https://scholar.google.com/scholar?q=%22author:Beaudoin+P%22)
	4. [Bengio Y](https://scholar.google.com/scholar?q=%22author:Bengio+Y%22)
	5. [Bogacz R](https://scholar.google.com/scholar?q=%22author:Bogacz+R%22)
	6. [Christensen A](https://scholar.google.com/scholar?q=%22author:Christensen+A%22)
	7. [Clopath C](https://scholar.google.com/scholar?q=%22author:Clopath+C%22)
	8. [Costa RP](https://scholar.google.com/scholar?q=%22author:Costa+RP%22)
	9. [de Berker A](https://scholar.google.com/scholar?q=%22author:de+Berker+A%22)
	10. [Ganguli S](https://scholar.google.com/scholar?q=%22author:Ganguli+S%22)
	11. [Gillon CJ](https://scholar.google.com/scholar?q=%22author:Gillon+CJ%22)
	12. [Hafner D](https://scholar.google.com/scholar?q=%22author:Hafner+D%22)
	13. [Kepecs A](https://scholar.google.com/scholar?q=%22author:Kepecs+A%22)
	14. [Kriegeskorte N](https://scholar.google.com/scholar?q=%22author:Kriegeskorte+N%22)
	15. [Latham P](https://scholar.google.com/scholar?q=%22author:Latham+P%22)
	16. [Lindsay GW](https://scholar.google.com/scholar?q=%22author:Lindsay+GW%22)
	17. [Miller KD](https://scholar.google.com/scholar?q=%22author:Miller+KD%22)
	18. [Naud R](https://scholar.google.com/scholar?q=%22author:Naud+R%22)
	19. [Pack CC](https://scholar.google.com/scholar?q=%22author:Pack+CC%22)
	20. [Poirazi P](https://scholar.google.com/scholar?q=%22author:Poirazi+P%22)
	21. [Roelfsema P](https://scholar.google.com/scholar?q=%22author:Roelfsema+P%22)
	22. [Sacramento J](https://scholar.google.com/scholar?q=%22author:Sacramento+J%22)
	23. [Saxe A](https://scholar.google.com/scholar?q=%22author:Saxe+A%22)
	24. [Scellier B](https://scholar.google.com/scholar?q=%22author:Scellier+B%22)
	25. [Schapiro AC](https://scholar.google.com/scholar?q=%22author:Schapiro+AC%22)
	26. [Senn W](https://scholar.google.com/scholar?q=%22author:Senn+W%22)
	27. [Wayne G](https://scholar.google.com/scholar?q=%22author:Wayne+G%22)
	28. [Yamins D](https://scholar.google.com/scholar?q=%22author:Yamins+D%22)
	29. [Zenke F](https://scholar.google.com/scholar?q=%22author:Zenke+F%22)
	30. [Zylberberg J](https://scholar.google.com/scholar?q=%22author:Zylberberg+J%22)
	31. [Therien D](https://scholar.google.com/scholar?q=%22author:Therien+D%22)
	32. [Kording KP](https://scholar.google.com/scholar?q=%22author:Kording+KP%22)
	(2019b) [A deep learning framework for neuroscience](https://doi.org/10.1038/s41593-019-0520-2)
	*Nature Neuroscience* **22**:1761–1770.
	[https://doi.org/10.1038/s41593-019-0520-2](https://doi.org/10.1038/s41593-019-0520-2)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/31659335)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=A+deep+learning+framework+for+neuroscience&author=Richards+BA&author=Lillicrap+TP&author%5B2%5D=Beaudoin+P&author%5B3%5D=Bengio+Y&author%5B4%5D=Bogacz+R&author%5B5%5D=Christensen+A&author%5B6%5D=Clopath+C&author%5B7%5D=Costa+RP&author%5B8%5D=de+Berker+A&author%5B9%5D=Ganguli+S&author%5B10%5D=Gillon+CJ&author%5B11%5D=Hafner+D&author%5B12%5D=Kepecs+A&author%5B13%5D=Kriegeskorte+N&author%5B14%5D=Latham+P&author%5B15%5D=Lindsay+GW&author%5B16%5D=Miller+KD&author%5B17%5D=Naud+R&author%5B18%5D=Pack+CC&author%5B19%5D=Poirazi+P&author%5B20%5D=Roelfsema+P&author%5B21%5D=Sacramento+J&author%5B22%5D=Saxe+A&author%5B23%5D=Scellier+B&author%5B24%5D=Schapiro+AC&author%5B25%5D=Senn+W&author%5B26%5D=Wayne+G&author%5B27%5D=Yamins+D&author%5B28%5D=Zenke+F&author%5B29%5D=Zylberberg+J&author%5B30%5D=Therien+D&author%5B31%5D=Kording+KP&publication_year=2019&journal=Nature+Neuroscience&volume=22&pages=pp.+1761%E2%80%931770&pmid=31659335)
50. 1. [Royer S](https://scholar.google.com/scholar?q=%22author:Royer+S%22)
	2. [Zemelman BV](https://scholar.google.com/scholar?q=%22author:Zemelman+BV%22)
	3. [Losonczy A](https://scholar.google.com/scholar?q=%22author:Losonczy+A%22)
	4. [Kim J](https://scholar.google.com/scholar?q=%22author:Kim+J%22)
	5. [Chance F](https://scholar.google.com/scholar?q=%22author:Chance+F%22)
	6. [Magee JC](https://scholar.google.com/scholar?q=%22author:Magee+JC%22)
	7. [Buzsáki G](https://scholar.google.com/scholar?q=%22author:Buzs%C3%A1ki+G%22)
	(2012) [Control of timing, rate and bursts of hippocampal place cells by dendritic and somatic inhibition](https://doi.org/10.1038/nn.3077)
	*Nature Neuroscience* **15**:769–775.
	[https://doi.org/10.1038/nn.3077](https://doi.org/10.1038/nn.3077)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/22446878)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Control+of+timing%2C+rate+and+bursts+of+hippocampal+place+cells+by+dendritic+and+somatic+inhibition&author=Royer+S&author=Zemelman+BV&author%5B2%5D=Losonczy+A&author%5B3%5D=Kim+J&author%5B4%5D=Chance+F&author%5B5%5D=Magee+JC&author%5B6%5D=Buzs%C3%A1ki+G&publication_year=2012&journal=Nature+Neuroscience&volume=15&pages=pp.+769%E2%80%93775&pmid=22446878)
51. Book
	1. [Sacramento J](https://scholar.google.com/scholar?q=%22author:Sacramento+J%22)
	(2018)
	Advances in Neural Information Processing Systems
	MIT Press.
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Advances+in+Neural+Information+Processing+Systems&author=Sacramento+J&publication_year=2018)
52. 1. [Sajikumar S](https://scholar.google.com/scholar?q=%22author:Sajikumar+S%22)
	2. [Frey JU](https://scholar.google.com/scholar?q=%22author:Frey+JU%22)
	(2004) [Late-associativity, synaptic tagging, and the role of dopamine during LTP and LTD](https://doi.org/10.1016/j.nlm.2004.03.003)
	*Neurobiology of Learning and Memory* **82**:12–25.
	[https://doi.org/10.1016/j.nlm.2004.03.003](https://doi.org/10.1016/j.nlm.2004.03.003)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/15183167)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Late-associativity%2C+synaptic+tagging%2C+and+the+role+of+dopamine+during+LTP+and+LTD&author=Sajikumar+S&author=Frey+JU&publication_year=2004&journal=Neurobiology+of+Learning+and+Memory&volume=82&pages=pp.+12%E2%80%9325&pmid=15183167)
53. 1. [Schiller J](https://scholar.google.com/scholar?q=%22author:Schiller+J%22)
	2. [Schiller Y](https://scholar.google.com/scholar?q=%22author:Schiller+Y%22)
	(2001) [NMDA receptor-mediated dendritic spikes and coincident signal amplification](https://doi.org/10.1016/s0959-4388\(00\)00217-8)
	*Current Opinion in Neurobiology* **11**:343–348.
	[https://doi.org/10.1016/s0959-4388(00)00217-8](https://doi.org/10.1016/s0959-4388\(00\)00217-8)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/11399433)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=NMDA+receptor-mediated+dendritic+spikes+and+coincident+signal+amplification&author=Schiller+J&author=Schiller+Y&publication_year=2001&journal=Current+Opinion+in+Neurobiology&volume=11&pages=pp.+343%E2%80%93348&pmid=11399433)
54. 1. [Stuart GJ](https://scholar.google.com/scholar?q=%22author:Stuart+GJ%22)
	2. [Häusser M](https://scholar.google.com/scholar?q=%22author:H%C3%A4usser+M%22)
	(2001) [Dendritic coincidence detection of EPSPs and action potentials](https://doi.org/10.1038/82910)
	*Nature Neuroscience* **4**:63–71.
	[https://doi.org/10.1038/82910](https://doi.org/10.1038/82910)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/11135646)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Dendritic+coincidence+detection+of+EPSPs+and+action+potentials&author=Stuart+GJ&author=H%C3%A4usser+M&publication_year=2001&journal=Nature+Neuroscience&volume=4&pages=pp.+63%E2%80%9371&pmid=11135646)
55. 1. [Takahashi H](https://scholar.google.com/scholar?q=%22author:Takahashi+H%22)
	2. [Magee JC](https://scholar.google.com/scholar?q=%22author:Magee+JC%22)
	(2009) [Pathway interactions and synaptic plasticity in the dendritic tuft regions of CA1 pyramidal neurons](https://doi.org/10.1016/j.neuron.2009.03.007)
	*Neuron* **62**:102–111.
	[https://doi.org/10.1016/j.neuron.2009.03.007](https://doi.org/10.1016/j.neuron.2009.03.007)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/19376070)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Pathway+interactions+and+synaptic+plasticity+in+the+dendritic+tuft+regions+of+CA1+pyramidal+neurons&author=Takahashi+H&author=Magee+JC&publication_year=2009&journal=Neuron&volume=62&pages=pp.+102%E2%80%93111&pmid=19376070)
56. 1. [Turi GF](https://scholar.google.com/scholar?q=%22author:Turi+GF%22)
	2. [Li WK](https://scholar.google.com/scholar?q=%22author:Li+WK%22)
	3. [Chavlis S](https://scholar.google.com/scholar?q=%22author:Chavlis+S%22)
	4. [Pandi I](https://scholar.google.com/scholar?q=%22author:Pandi+I%22)
	5. [O’Hare J](https://scholar.google.com/scholar?q=%22author:O%E2%80%99Hare+J%22)
	6. [Priestley JB](https://scholar.google.com/scholar?q=%22author:Priestley+JB%22)
	7. [Grosmark AD](https://scholar.google.com/scholar?q=%22author:Grosmark+AD%22)
	8. [Liao Z](https://scholar.google.com/scholar?q=%22author:Liao+Z%22)
	9. [Ladow M](https://scholar.google.com/scholar?q=%22author:Ladow+M%22)
	10. [Zhang JF](https://scholar.google.com/scholar?q=%22author:Zhang+JF%22)
	11. [Zemelman BV](https://scholar.google.com/scholar?q=%22author:Zemelman+BV%22)
	12. [Poirazi P](https://scholar.google.com/scholar?q=%22author:Poirazi+P%22)
	13. [Losonczy A](https://scholar.google.com/scholar?q=%22author:Losonczy+A%22)
	(2019) [Vasoactive Intestinal Polypeptide-Expressing Interneurons in the Hippocampus Support Goal-Oriented Spatial Learning](https://doi.org/10.1016/j.neuron.2019.01.009)
	*Neuron* **101**:1150–1165.
	[https://doi.org/10.1016/j.neuron.2019.01.009](https://doi.org/10.1016/j.neuron.2019.01.009)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/30713030)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Vasoactive+Intestinal+Polypeptide-Expressing+Interneurons+in+the+Hippocampus+Support+Goal-Oriented+Spatial+Learning&author=Turi+GF&author=Li+WK&author%5B2%5D=Chavlis+S&author%5B3%5D=Pandi+I&author%5B4%5D=O%E2%80%99Hare+J&author%5B5%5D=Priestley+JB&author%5B6%5D=Grosmark+AD&author%5B7%5D=Liao+Z&author%5B8%5D=Ladow+M&author%5B9%5D=Zhang+JF&author%5B10%5D=Zemelman+BV&author%5B11%5D=Poirazi+P&author%5B12%5D=Losonczy+A&publication_year=2019&journal=Neuron&volume=101&pages=pp.+1150%E2%80%931165&pmid=30713030)
57. 1. [Turrigiano GG](https://scholar.google.com/scholar?q=%22author:Turrigiano+GG%22)
	2. [Nelson SB](https://scholar.google.com/scholar?q=%22author:Nelson+SB%22)
	(2004) [Homeostatic plasticity in the developing nervous system](https://doi.org/10.1038/nrn1327)
	*Nature Reviews. Neuroscience* **5**:97–107.
	[https://doi.org/10.1038/nrn1327](https://doi.org/10.1038/nrn1327)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/14735113)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Homeostatic+plasticity+in+the+developing+nervous+system&author=Turrigiano+GG&author=Nelson+SB&publication_year=2004&journal=Nature+Reviews.+Neuroscience&volume=5&pages=pp.+97%E2%80%93107&pmid=14735113)
58. 1. [Tyan L](https://scholar.google.com/scholar?q=%22author:Tyan+L%22)
	2. [Chamberland S](https://scholar.google.com/scholar?q=%22author:Chamberland+S%22)
	3. [Magnin E](https://scholar.google.com/scholar?q=%22author:Magnin+E%22)
	4. [Camiré O](https://scholar.google.com/scholar?q=%22author:Camir%C3%A9+O%22)
	5. [Francavilla R](https://scholar.google.com/scholar?q=%22author:Francavilla+R%22)
	6. [David LS](https://scholar.google.com/scholar?q=%22author:David+LS%22)
	7. [Deisseroth K](https://scholar.google.com/scholar?q=%22author:Deisseroth+K%22)
	8. [Topolnik L](https://scholar.google.com/scholar?q=%22author:Topolnik+L%22)
	(2014) [Dendritic inhibition provided by interneuron-specific cells controls the firing rate and timing of the hippocampal feedback inhibitory circuitry](https://doi.org/10.1523/JNEUROSCI.3813-13.2014)
	*The Journal of Neuroscience* **34**:4534–4547.
	[https://doi.org/10.1523/JNEUROSCI.3813-13.2014](https://doi.org/10.1523/JNEUROSCI.3813-13.2014)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/24671999)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Dendritic+inhibition+provided+by+interneuron-specific+cells+controls+the+firing+rate+and+timing+of+the+hippocampal+feedback+inhibitory+circuitry&author=Tyan+L&author=Chamberland+S&author%5B2%5D=Magnin+E&author%5B3%5D=Camir%C3%A9+O&author%5B4%5D=Francavilla+R&author%5B5%5D=David+LS&author%5B6%5D=Deisseroth+K&author%5B7%5D=Topolnik+L&publication_year=2014&journal=The+Journal+of+Neuroscience&volume=34&pages=pp.+4534%E2%80%934547&pmid=24671999)
59. 1. [Xu N](https://scholar.google.com/scholar?q=%22author:Xu+N%22)
	2. [Harnett MT](https://scholar.google.com/scholar?q=%22author:Harnett+MT%22)
	3. [Williams SR](https://scholar.google.com/scholar?q=%22author:Williams+SR%22)
	4. [Huber D](https://scholar.google.com/scholar?q=%22author:Huber+D%22)
	5. [O’Connor DH](https://scholar.google.com/scholar?q=%22author:O%E2%80%99Connor+DH%22)
	6. [Svoboda K](https://scholar.google.com/scholar?q=%22author:Svoboda+K%22)
	7. [Magee JC](https://scholar.google.com/scholar?q=%22author:Magee+JC%22)
	(2012) [Nonlinear dendritic integration of sensory and motor input during an active sensing task](https://doi.org/10.1038/nature11601)
	*Nature* **492**:247–251.
	[https://doi.org/10.1038/nature11601](https://doi.org/10.1038/nature11601)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/23143335)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Nonlinear+dendritic+integration+of+sensory+and+motor+input+during+an+active+sensing+task&author=Xu+N&author=Harnett+MT&author%5B2%5D=Williams+SR&author%5B3%5D=Huber+D&author%5B4%5D=O%E2%80%99Connor+DH&author%5B5%5D=Svoboda+K&author%5B6%5D=Magee+JC&publication_year=2012&journal=Nature&volume=492&pages=pp.+247%E2%80%93251&pmid=23143335)
60. 1. [Yagishita S](https://scholar.google.com/scholar?q=%22author:Yagishita+S%22)
	2. [Hayashi-Takagi A](https://scholar.google.com/scholar?q=%22author:Hayashi-Takagi+A%22)
	3. [Ellis-Davies GCR](https://scholar.google.com/scholar?q=%22author:Ellis-Davies+GCR%22)
	4. [Urakubo H](https://scholar.google.com/scholar?q=%22author:Urakubo+H%22)
	5. [Ishii S](https://scholar.google.com/scholar?q=%22author:Ishii+S%22)
	6. [Kasai H](https://scholar.google.com/scholar?q=%22author:Kasai+H%22)
	(2014) [A critical time window for dopamine actions on the structural plasticity of dendritic spines](https://doi.org/10.1126/science.1255514)
	*Science* **345**:1616–1620.
	[https://doi.org/10.1126/science.1255514](https://doi.org/10.1126/science.1255514)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/25258080)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=A+critical+time+window+for+dopamine+actions+on+the+structural+plasticity+of+dendritic+spines&author=Yagishita+S&author=Hayashi-Takagi+A&author%5B2%5D=Ellis-Davies+GCR&author%5B3%5D=Urakubo+H&author%5B4%5D=Ishii+S&author%5B5%5D=Kasai+H&publication_year=2014&journal=Science&volume=345&pages=pp.+1616%E2%80%931620&pmid=25258080)
61. 1. [Zaremba JD](https://scholar.google.com/scholar?q=%22author:Zaremba+JD%22)
	2. [Diamantopoulou A](https://scholar.google.com/scholar?q=%22author:Diamantopoulou+A%22)
	3. [Danielson NB](https://scholar.google.com/scholar?q=%22author:Danielson+NB%22)
	4. [Grosmark AD](https://scholar.google.com/scholar?q=%22author:Grosmark+AD%22)
	5. [Kaifosh PW](https://scholar.google.com/scholar?q=%22author:Kaifosh+PW%22)
	6. [Bowler JC](https://scholar.google.com/scholar?q=%22author:Bowler+JC%22)
	7. [Liao Z](https://scholar.google.com/scholar?q=%22author:Liao+Z%22)
	8. [Sparks FT](https://scholar.google.com/scholar?q=%22author:Sparks+FT%22)
	9. [Gogos JA](https://scholar.google.com/scholar?q=%22author:Gogos+JA%22)
	10. [Losonczy A](https://scholar.google.com/scholar?q=%22author:Losonczy+A%22)
	(2017) [Impaired hippocampal place cell dynamics in a mouse model of the 22q11.2 deletion](https://doi.org/10.1038/nn.4634)
	*Nature Neuroscience* **20**:1612–1623.
	[https://doi.org/10.1038/nn.4634](https://doi.org/10.1038/nn.4634)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/28869582)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Impaired+hippocampal+place+cell+dynamics+in+a+mouse+model+of+the+22q11.2+deletion&author=Zaremba+JD&author=Diamantopoulou+A&author%5B2%5D=Danielson+NB&author%5B3%5D=Grosmark+AD&author%5B4%5D=Kaifosh+PW&author%5B5%5D=Bowler+JC&author%5B6%5D=Liao+Z&author%5B7%5D=Sparks+FT&author%5B8%5D=Gogos+JA&author%5B9%5D=Losonczy+A&publication_year=2017&journal=Nature+Neuroscience&volume=20&pages=pp.+1612%E2%80%931623&pmid=28869582)
62. 1. [Ziv Y](https://scholar.google.com/scholar?q=%22author:Ziv+Y%22)
	2. [Burns LD](https://scholar.google.com/scholar?q=%22author:Burns+LD%22)
	3. [Cocker ED](https://scholar.google.com/scholar?q=%22author:Cocker+ED%22)
	4. [Hamel EO](https://scholar.google.com/scholar?q=%22author:Hamel+EO%22)
	5. [Ghosh KK](https://scholar.google.com/scholar?q=%22author:Ghosh+KK%22)
	6. [Kitch LJ](https://scholar.google.com/scholar?q=%22author:Kitch+LJ%22)
	7. [El Gamal A](https://scholar.google.com/scholar?q=%22author:El+Gamal+A%22)
	8. [Schnitzer MJ](https://scholar.google.com/scholar?q=%22author:Schnitzer+MJ%22)
	(2013) [Long-term dynamics of CA1 hippocampal place codes](https://doi.org/10.1038/nn.3329)
	*Nature Neuroscience* **16**:264–266.
	[https://doi.org/10.1038/nn.3329](https://doi.org/10.1038/nn.3329)
	- [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/23396101)
	- [Google Scholar](https://scholar.google.com/scholar_lookup?title=Long-term+dynamics+of+CA1+hippocampal+place+codes&author=Ziv+Y&author=Burns+LD&author%5B2%5D=Cocker+ED&author%5B3%5D=Hamel+EO&author%5B4%5D=Ghosh+KK&author%5B5%5D=Kitch+LJ&author%5B6%5D=El+Gamal+A&author%5B7%5D=Schnitzer+MJ&publication_year=2013&journal=Nature+Neuroscience&volume=16&pages=pp.+264%E2%80%93266&pmid=23396101)

### Author details

1. #### Aaron D Milstein
	1. Department of Neurosurgery and Stanford Neurosciences Institute, Stanford University School of Medicine, Stanford, United States
	2. Department of Neuroscience and Cell Biology, Robert Wood Johnson Medical School and Center for Advanced Biotechnology and Medicine, Rutgers University, Piscataway, United States
	##### Contribution
	Conceptualization, Formal analysis, Investigation, Methodology, Software, Visualization, Writing – original draft, Writing – review and editing
	##### Competing interests
	No competing interests declared
	![](https://elifesciences.org/assets/patterns/img/icons/orcid.5d420edc.svg)
2. #### Yiding Li
	Howard Hughes Medical Institute, Baylor College of Medicine, Houston, United States
	##### Contribution
	Investigation, Methodology
	##### Competing interests
	No competing interests declared
3. #### Katie C Bittner
	Howard Hughes Medical Institute, Janelia Research Campus, Ashburn, United States
	##### Contribution
	Conceptualization, Investigation, Methodology, Visualization
	##### Competing interests
	No competing interests declared
4. #### Christine Grienberger
	Howard Hughes Medical Institute, Baylor College of Medicine, Houston, United States
	##### Contribution
	Conceptualization, Investigation, Methodology, Visualization
	##### Competing interests
	No competing interests declared
5. #### Ivan Soltesz
	Department of Neurosurgery and Stanford Neurosciences Institute, Stanford University School of Medicine, Stanford, United States
	##### Contribution
	Funding acquisition, Supervision, Writing – review and editing
	##### Competing interests
	No competing interests declared
6. #### Jeffrey C Magee
	Howard Hughes Medical Institute, Baylor College of Medicine, Houston, United States
	##### Contribution
	Conceptualization, Funding acquisition, Investigation, Supervision, Visualization, Writing – original draft, Writing – review and editing
	##### For correspondence
	[jcmagee@bcm.edu](mailto:jcmagee@bcm.edu)
	##### Competing interests
	No competing interests declared
7. #### Sandro Romani
	Howard Hughes Medical Institute, Janelia Research Campus, Ashburn, United States
	##### Contribution
	Conceptualization, Funding acquisition, Investigation, Methodology, Supervision, Writing – original draft, Writing – review and editing
	##### For correspondence
	[romanis@janelia.hhmi.org](mailto:romanis@janelia.hhmi.org)
	##### Competing interests
	No competing interests declared
	![](https://elifesciences.org/assets/patterns/img/icons/orcid.5d420edc.svg)

- Aaron D Milstein
- Ivan Soltesz

- Aaron D Milstein

The funders had no role in study design, data collection and interpretation, or the decision to submit the work for publication.

We are grateful to Karel Svoboda and Wulfram Gerstner for discussions, Nicolas Brunel and Nelson Spruston for comments on the manuscript, Grace Ng for contributing to software development, Roy Phillips for behavioral device development, Ivan Raikov for technical assistance with high-performance computing, and Kristopher Bouchard at LBNL for sharing large-scale computing resources provided by the National Energy Research Scientific Computing Center, a Department of Energy Office of Science User Facility (DE-AC02-05CH11231). This work was also made possible by computing allotments from NSF (XSEDE Comet, NCSA Blue Waters, and TACC Frontera) and supported by NIH BRAIN grant U19NS104590 and NIMH grant R01MH121979. SR and JM are supported by the Howard Hughes Medical Institute.

All experimental methods were approved by the Janelia or Baylor College of Medicine Institutional Animal Care and Use Committees (Protocol 12-84 & 15-126).

- 7,954
	views
- 1,351
	downloads
- 167
	citations

Views, downloads and citations are aggregated across all versions of this paper published by eLife.

### Citations by DOI

- 167
	citations for umbrella DOI [https://doi.org/10.7554/eLife.73046](https://doi.org/10.7554/eLife.73046)

[![Article has an altmetric score of 22](https://badges.altmetric.com/?size=240&score=22&types=mbtttttu)](https://www.altmetric.com/details.php?domain=elifesciences.org&citation_id=118523409)

[Picked up by **1** news outlets](https://www.altmetric.com/details.php?domain=elifesciences.org&citation_id=118523409&tab=news)

[Blogged by **2**](https://www.altmetric.com/details.php?domain=elifesciences.org&citation_id=118523409&tab=blogs)

[Posted by **8** X users](https://www.altmetric.com/details.php?domain=elifesciences.org&citation_id=118523409&tab=twitter)

[Referenced by **1** Bluesky users](https://www.altmetric.com/details.php?domain=elifesciences.org&citation_id=118523409&tab=bluesky)

**137** readers on Mendeley

[https://doi.org/10.7554/eLife.73046](https://doi.org/10.7554/eLife.73046)

[^1]: Figure 2 with 1 supplement

[Download asset](https://elifesciences.org/download/aHR0cHM6Ly9paWlmLmVsaWZlc2NpZW5jZXMub3JnL2xheC83MzA0NiUyRmVsaWZlLTczMDQ2LWZpZzItdjMudGlmL2Z1bGwvZnVsbC8wL2RlZmF1bHQuanBn/elife-73046-fig2-v3.jpg?_hash=by8tDCMb3Xcla5Tj4ONoUDphKAjM4Yrdx4RbE0sIXCI%3D) [Open asset](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig2-v3.tif/full/,1500/0/default.jpg)

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig2-v3.tif/full/1234,/0/default.webp)

Spatial and temporal profiles of plateau-induced change in Vm. ( A ) Difference between spatially binned V m ramp depolarizations averaged across laps after the second induction and those averaged across laps before the second induction. Same example traces as … see more ↩

[^2]: Figure 3 with 1 supplement

[Download asset](https://elifesciences.org/download/aHR0cHM6Ly9paWlmLmVsaWZlc2NpZW5jZXMub3JnL2xheC83MzA0NiUyRmVsaWZlLTczMDQ2LWZpZzMtdjMudGlmL2Z1bGwvZnVsbC8wL2RlZmF1bHQuanBn/elife-73046-fig3-v3.jpg?_hash=0Fx8Q%2BBFWStpnjZf%2BBCx%2Frya4wRdpswOckGSDzeXbWg%3D) [Open asset](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig3-v3.tif/full/,1500/0/default.jpg)

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig3-v3.tif/full/1234,/0/default.webp)

Vm ramp plasticity varies with both time delay from plateau onset and initial Vm depolarization. ( A ) Temporal profile of initial V m before plasticity for inductions in neurons with pre-existing place fields (26 inductions from 24 place cells), aligned to the onset time of evoked plateau … see more ↩

[^3]: Figure 5

[Download asset](https://elifesciences.org/download/aHR0cHM6Ly9paWlmLmVsaWZlc2NpZW5jZXMub3JnL2xheC83MzA0NiUyRmVsaWZlLTczMDQ2LWZpZzUtdjMudGlmL2Z1bGwvZnVsbC8wL2RlZmF1bHQuanBn/elife-73046-fig5-v3.jpg?_hash=uvubEs4GdyjsccvK4GavH0vh99hP981sgCFNnM7junA%3D) [Open asset](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig5-v3.tif/full/1500,/0/default.jpg)

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig5-v3.tif/full/1234,/0/default.webp)

Weight-dependent model of behavioral timescale synaptic plasticity (BTSP) captures essential features of plateau-induced plasticity. ( A – B ) Traces schematize a model of bidirectional BTSP that depends on (1) presynaptic spike timing, (2) plateau potential timing and duration, and (3) the current synaptic weight of an input … see more ↩

Accordingly, we modeled changes in synaptic weights as a function of the time-varying amplitudes of these two biochemical intermediate signals, ET and IS. For simplicity, we first considered how BTSP would change the weight $W$ of a single synapse activated by a single presynaptic spike with precise timing relative to the onset of a plateau potential ([Figure 5A](#fig5)). We modeled the synaptic ET as a signal that increases upon synaptic activation at time $t^{s}$ and decays exponentially with time course $\tau_{E T}$ (see [Figure 5A](#fig5) and Materials and methods). The IS was modeled as a signal that increases during a plateau potential with onset at time $t^{p}$ and duration $d$ and decays exponentially with time course $\tau_{I S}$ (see [Figure 5A](#fig5) and Materials and methods).

Next, we modeled bidirectional changes in synaptic weight $\frac{d W}{d t}$ as a function of the temporal overlap or product of these two signals, $E T * I S$. To account for the observation that BTSP favors synaptic potentiation at weak synapses and synaptic depression at strong synapses, we expressed $\frac{d W}{d t}$ in terms of two separate plasticity processes $q^{+}$ and $q^{-}$ with opposite dependencies on the current synaptic weight $W$:

[^4]: Figure 6 with 3 supplements

[Download asset](https://elifesciences.org/download/aHR0cHM6Ly9paWlmLmVsaWZlc2NpZW5jZXMub3JnL2xheC83MzA0NiUyRmVsaWZlLTczMDQ2LWZpZzYtdjMudGlmL2Z1bGwvZnVsbC8wL2RlZmF1bHQuanBn/elife-73046-fig6-v3.jpg?_hash=EGYmRywek8QPS%2Bn8CsntFLN3Nnz0sNU3BxmsXhHx768%3D) [Open asset](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig6-v3.tif/full/1500,/0/default.jpg)

![](https://iiif.elifesciences.org/lax/73046%2Felife-73046-fig6-v3.tif/full/1234,/0/default.webp)

Weight-dependent model of behavioral timescale synaptic plasticity (BTSP) accounts for experimentally measured bidirectional changes in Vm. ( A ) The weight-dependent model of BTSP shown in Figure 5 was used to reproduce plateau-induced changes in V m in an experimentally recorded CA1 neuron given (1) the measured run trajectory of the … see more ↩