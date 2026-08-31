---
title: "A Large-Scale Circuit Mechanism for Hierarchical Dynamical Processing in the Primate Cortex"
source: "https://www.cell.com/neuron/fulltext/S0896-6273(15)00765-5"
author:
  - "[[Rishidev Chaudhuri]]"
  - "[[Kenneth Knoblauch]]"
  - "[[Marie-Alice Gariel]]"
  - "[[Henry Kennedy]]"
  - "[[Xiao-Jing Wang]]"
published: 2014-11-10
created: 2026-08-31
description: "Chaudhuri et al. report a large-scale model of the macaque cortex incorporating quantitativeanatomical data and inter-areal heterogeneity. This model gives rise to a hierarchyof timescales and suggests a revision of functional connectivity analysis of globalbrain dynamics."
tags:
  - "clippings"
---
## Summary

We developed a large-scale dynamical model of the macaque neocortex, which is based on recently acquired directed- and weighted-connectivity data from tract-tracing experiments, and which incorporates heterogeneity across areas. A hierarchy of timescales naturally emerges from this system: sensory areas show brief, transient responses to input (appropriate for sensory processing), whereas association areas integrate inputs over time and exhibit persistent activity (suitable for decision-making and working memory). The model displays multiple temporal hierarchies, as evidenced by contrasting responses to visual versus somatosensory stimulation. Moreover, slower prefrontal and temporal areas have a disproportionate impact on global brain dynamics. These findings establish a circuit mechanism for “temporal receptive windows” that are progressively enlarged along the cortical hierarchy, suggest an extension of time integration in decision making from local to large circuits, and should prompt a re-evaluation of the analysis of functional connectivity (measured by fMRI or electroencephalography/magnetoencephalography) by taking into account inter-areal heterogeneity.

Sign in to unlock the full response and ask your own questions.

[Sign in](https://www.cell.com/action/idLogin?type=login&redirectUri=https%3A%2F%2Fwww.cell.com%2Fneuron%2Ffulltext%2FS0896-6273%2815%2900765-5&pii=S0896627315007655)

### Questions you could ask:

- How do slow network timescales relate to the connectivity of frontal and temporal areas?
- How do strong recurrent connections influence the dynamics of cortical areas?
- What factors contribute to the emergence of hierarchies of timescales in response to different stimuli?

### Actions you could take:

- Summarize this article
- Summarize experiments

## Introduction

The receptive field is a central concept in neuroscience, defined as the spatial region over which an adequate stimulus solicits rigorous response of a neuron (

60.

Sherrington, C.S.

**Observations on the scratch-reflex in the spinal dog**

*J. Physiol.* 1906; **34**:1-50

). In the primate visual cortical system, the receptive field size of neurons progressively enlarges along a hierarchy (

40.

Hubel, D.H.

**Eye, Brain, and Vision: Scientific American Library Series**

Scientific American Press, New York, 1988

[Google Scholar](https://scholar.google.com/scholar?q=D.H.HubelEye%2C+Brain%2C+and+Vision%3A+Scientific+American+Library+Series1988Scientific+American+PressNew+York)

41.

Hubel, D.H. ∙ Wiesel, T.N.

**Receptive fields, binocular interaction and functional architecture in the cat’s visual cortex**

*J. Physiol.* 1962; **160**:106-154

65.

Wallisch, P. ∙ Movshon, J.A.

**Structure and function come unglued in the visual cortex**

*Neuron.* 2008; **60**:195-197

). As a result, higher areas can integrate stimuli over a greater spatial extent, which is essential for such functions as size-invariance of object recognition in the ventral (“what”) stream for visual perception (

44.

Kobatake, E. ∙ Tanaka, K.

**Neuronal selectivities to complex object features in the ventral visual pathway of the macaque cerebral cortex**

*J. Neurophysiol.* 1994; **71**:856-867

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8201425/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=8201425)

).

Accumulating evidence suggests that the brain also displays a hierarchy in the temporal domain. This allows neurons in higher areas to respond to stimuli spread over a greater temporal extent and to integrate information over time, while neurons in early sensory areas rapidly track changing stimuli. In human studies, preserving the short timescale structure of stimuli while scrambling long timescale structure changes responses in association areas but not early sensory areas (

26.

Gauthier, B. ∙ Eger, E. ∙ Hesselmann, G....

**Temporal tuning properties along the human ventral visual stream**

*J. Neurosci.* 2012; **32**:14433-14441

30.

Hasson, U. ∙ Yang, E. ∙ Vallines, I....

**A hierarchy of temporal receptive windows in human cortex**

*J. Neurosci.* 2008; **28**:2539-2550

39.

Honey, C.J. ∙ Thesen, T. ∙ Donner, T.H....

**Slow cortical dynamics and the accumulation of information over long timescales**

*Neuron.* 2012; **76**:423-434

45.

Lerner, Y. ∙ Honey, C.J. ∙ Silbert, L.J....

**Topographic mapping of a hierarchy of temporal receptive windows using a narrated story**

*J. Neurosci.* 2011; **31**:2906-2915

63.

Stephens, G.J. ∙ Honey, C.J. ∙ Hasson, U.

**A place for time: the spatiotemporal structure of neural dynamics during natural audition**

*J. Neurophysiol.* 2013; **110**:2019-2026

). Notably, using electrocorticography (ECoG),

39.

Honey, C.J. ∙ Thesen, T. ∙ Donner, T.H....

**Slow cortical dynamics and the accumulation of information over long timescales**

*Neuron.* 2012; **76**:423-434

found that cortical areas sensitive to long time structure in the stimulus also show slower decays in their temporal autocorrelation (and hence slower dynamics), and

63.

Stephens, G.J. ∙ Honey, C.J. ∙ Hasson, U.

**A place for time: the spatiotemporal structure of neural dynamics during natural audition**

*J. Neurophysiol.* 2013; **110**:2019-2026

made a similar observation with fMRI. In the macaque,

53.

Murray, J.D. ∙ Bernacchia, A. ∙ Freedman, D.J....

**A hierarchy of intrinsic timescales across primate cortex**

*Nat. Neurosci.* 2014; **17**:1661-1663

found a hierarchical organization in the timescales of spontaneous fluctuations of single neurons across 7 cortical areas, and an area’s timescale was well predicted by its position in the anatomical hierarchy of

25.

Felleman, D.J. ∙ Van Essen, D.C.

**Distributed hierarchical processing in the primate cerebral cortex**

*Cereb. Cortex.* 1991; **1**:1-47

. Similarly, temporal correlations in neural activity reveal slower decay rates in the frontal eye fields than area V4 (

54.

Ogawa, T. ∙ Komatsu, H.

**Differential temporal storage capacity in the baseline activity of neurons in macaque frontal eye field and area V4**

*J. Neurophysiol.* 2010; **103**:2433-2445

), the timescales of reward memory lengthen from parietal to dorsolateral prefrontal to anterior cingulate cortex (

6.

Bernacchia, A. ∙ Seo, H. ∙ Lee, D....

**A reservoir of time constants for memory traces in cortical neurons**

*Nat. Neurosci.* 2011; **14**:366-372

), and, more generally, persistent activity after a brief stimulus can last for seconds, even across inter-trial intervals, in association areas (). Finally, normative theories of predictive coding suggest that a hierarchy of timescales would allow animals to form a nested sequence of predictions about the world (

43.

Kiebel, S.J. ∙ Daunizeau, J. ∙ Friston, K.J.

**A hierarchy of time-scales and the brain**

*PLoS Comput. Biol.* 2008; **4**:e1000209

).

What underlying neurobiological mechanisms might give rise to such a range of temporal dynamics? For example, spatial patterns of convergence can produce increasing receptive field sizes in the visual hierarchy. Are there basic anatomical motifs that produce a hierarchy of timescales?

Here we report a large-scale circuit mechanism for the generation of a hierarchy of temporal receptive windows in the primate cortex. This hierarchy naturally emerges in a dynamical model based on a recent quantitative anatomical dataset containing directed and weighted connectivity for the macaque neocortex (

24.

Ercsey-Ravasz, M. ∙ Markov, N.T. ∙ Lamy, C....

**A predictive network model of cerebral cortical connectivity based on a distance rule**

*Neuron.* 2013; **80**:184-197

46.

Markov, N.T. ∙ Misery, P. ∙ Falchier, A....

**Weight consistency specifies regularities of macaque cortical networks**

*Cereb. Cortex.* 2011; **21**:1254-1272

48.

Markov, N.T. ∙ Ercsey-Ravasz, M. ∙ Van Essen, D.C....

**Cortical high-density counterstream architectures**

*Science.* 2013; **342**:1238406

49.

Markov, N.T. ∙ Ercsey-Ravasz, M.M. ∙ Ribeiro Gomes, A.R....

**A weighted and directed interareal connectivity matrix for macaque cerebral cortex**

*Cereb. Cortex.* 2014; **24**:17-36

). The data were obtained using the same experimental conditions and measures, ensuring a consistent database (

42.

Kennedy, H. ∙ Knoblauch, K. ∙ Toroczkai, Z.

**Why data coherence and quality is critical for understanding interareal cortical networks**

*Neuroimage.* 2013; **80**:37-45

[Crossref](https://doi.org/10.1016/j.neuroimage.2013.1004.1031)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/23603347/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1016%2Fj.neuroimage.2013.1004.1031&pmid=23603347)

), and include both the number of projections between areas and their laminar origins. Based on a separate anatomical study (

21.

Elston, G.N.

**Pyramidal cells of the frontal lobe: all the more spinous to think with**

*J. Neurosci.* 2000; **20**:RC95

[PubMed](https://pubmed.ncbi.nlm.nih.gov/10974092/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=10974092)

23.

Elston, G.N. ∙ Benavides-Piccione, R. ∙ Elston, A....

**Pyramidal cells in prefrontal cortex of primates: marked differences in neuronal structure among species**

*Front. Neuroanat.* 2011; **5**:2

), we introduced heterogeneity across cortical areas in the form of a gradient of excitatory connection strengths. Strong recurrent excitation has been proposed as a mechanism by which prefrontal cortex could implement “cognitive-type” computations, such as information integration and memory-related delay activity; we hypothesized that differences in recurrent excitation might allow the generation of a temporal hierarchy.

The model thus incorporates anatomically constrained variation in both within-area and inter-areal connectivity and enables us to probe the interplay of local microcircuitry and long-range connectivity that underlies a hierarchy of timescales. Using different sensory inputs, we demonstrate the existence, in our model, of multiple dynamical hierarchies subserved by a single integrated global and local circuit. We then investigate the implications of local circuit heterogeneity for macroscopic dynamics measured by functional connectivity (i.e., correlations in activity across areas). Here we find a disproportionate role for slow dynamics in the prefrontal and other association cortices in shaping resting-state functional connectivity. This role is not predicted by long-range connections, suggesting that interpretations of brain imaging data will need to be revised to account for inter-areal heterogeneity.

While we have used the model to investigate the origin of a hierarchy of timescales, it can be a platform for future models relating connectivity to dynamics and the functions of cortical areas. Most statistical analyses of connectivity (

11.

Bullmore, E. ∙ Sporns, O.

**Complex brain networks: graph theoretical analysis of structural and functional systems**

*Nat. Rev. Neurosci.* 2009; **10**:186-198

62.

Sporns, O.

**Contributions and challenges for network models in cognitive neuroscience**

*Nat. Neurosci.* 2014; **17**:652-660

) and computational models (

17.

Deco, G. ∙ Corbetta, M.

**The dynamical balance of the brain at rest**

*Neuroscientist.* 2011; **17**:107-123

18.

Deco, G. ∙ Ponce-Alvarez, A. ∙ Hagmann, P....

**How local excitation-inhibition ratio impacts the whole brain dynamics**

*J. Neurosci.* 2014; **34**:7886-7898

27.

Ghosh, A. ∙ Rho, Y. ∙ McIntosh, A.R....

**Noise during rest enables the exploration of the brain’s dynamic repertoire**

*PLoS Comput. Biol.* 2008; **4**:e1000196

36.

Honey, C.J. ∙ Kötter, R. ∙ Breakspear, M....

**Network structure of cerebral cortex shapes functional connectivity on multiple time scales**

*Proc. Natl. Acad. Sci. USA.* 2007; **104**:10240-10245

37.

Honey, C.J. ∙ Sporns, O. ∙ Cammoun, L....

**Predicting human resting-state functional connectivity from structural connectivity**

*Proc. Natl. Acad. Sci. USA.* 2009; **106**:2035-2040

) have lacked comprehensive high-resolution data, relying either on collating qualitative tract-tracing data across disparate experiments and conditions or on diffusion tensor imaging, which is noisy and cannot reveal the direction of a pathway. Moreover, such models typically treat cortical areas as identical nodes in a network, distinguished by connection patterns but not by local properties or computational capabilities. Although this approach is reasonable for certain purposes, it is doubtful that functional specialization of cortical areas can be elucidated without considering heterogeneity. Our model provides a framework to explore how dynamical and functional specialization can emerge from inter-areal pathways coupled with local circuit differences.

## Results

We developed the model in three steps. First, we used recent connectivity data for the macaque neocortex (

49.

Markov, N.T. ∙ Ercsey-Ravasz, M.M. ∙ Ribeiro Gomes, A.R....

**A weighted and directed interareal connectivity matrix for macaque cerebral cortex**

*Cereb. Cortex.* 2014; **24**:17-36

), designed to overcome the limitations of collated anatomical datasets, and collected by the same group under similar conditions, with quantitative measures of connectivity. The connectivity weights are directionally specific and cover 29 widely distributed cortical areas, with 536 connections whose strengths span five orders of magnitude ([Figure 1](#fig1)). The presence or absence of all projections in this network has been established; thus, there are no unknown pathways.

![](https://www.cell.com/cms/10.1016/j.neuron.2015.09.008/asset/ecb7333b-4002-4d14-a5d0-7833090a7d99/main.assets/gr1_lrg.jpg)

Figure 1 The Network Consists of 29 Widely Distributed Cortical Areas

Second, each cortical area was described by a threshold-linear recurrent network with interacting excitatory and inhibitory populations and calibrated by the neurophysiology of the primary visual cortex (

7.

Binzegger, T. ∙ Douglas, R.J. ∙ Martin, K.A.

**Topology and dynamics of the canonical circuit of cat V1**

*Neural Netw.* 2009; **22**:1071-1078

), but rescaled as described below. This is a highly simplified description of the dynamics of an area and ignores most within-area variability. In particular, note that the model is large-scale in that it addresses macroscopic cortical dynamics but is not large-scale in the sense of having millions of neurons or very high-dimensional activity. However, this level of complexity allows us to parsimoniously capture essential requirements for a hierarchy of timescales. We extend our results in [Figure 7](#fig7) and suggest further extensions in the [Discussion](#sec-3).

Third, we hypothesized that the local microcircuit is qualitatively canonical (

20.

Douglas, R.J. ∙ Martin, K.A.

**A functional microcircuit for cat visual cortex**

*J. Physiol.* 1991; **440**:735-769

), i.e., the same across areas, but that quantitative inter-areal differences are crucial in generating the timescales of areas. Specifically, the number of basal dendritic spines on layer three pyramidal neurons increases sharply from primary sensory to prefrontal areas (

21.

Elston, G.N.

**Pyramidal cells of the frontal lobe: all the more spinous to think with**

*J. Neurosci.* 2000; **20**:RC95

[PubMed](https://pubmed.ncbi.nlm.nih.gov/10974092/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=10974092)

23.

Elston, G.N. ∙ Benavides-Piccione, R. ∙ Elston, A....

**Pyramidal cells in prefrontal cortex of primates: marked differences in neuronal structure among species**

*Front. Neuroanat.* 2011; **5**:2

). Taking spine count as a proxy for excitatory synapses per pyramidal cell, we introduced a gradient of excitatory input strength across the cortex. We modeled this by scaling the strength of excitatory projections in an area according to the area’s position in the anatomical hierarchy described below.

### Gradient of Excitation along the Cortical Hierarchy

The laminar pattern of inter-areal projections can be used to place cortical areas in a hierarchy: neurons mediating feedforward connections from one area to another tend to originate in supragranular layers of the source area, whereas feedback projections tend to originate in infragranular layers (

3.

Barbas, H. ∙ Rempel-Clower, N.

**Cortical structure predicts the pattern of corticocortical connections**

*Cereb. Cortex.* 1997; **7**:635-646

25.

Felleman, D.J. ∙ Van Essen, D.C.

**Distributed hierarchical processing in the primate cerebral cortex**

*Cereb. Cortex.* 1991; **1**:1-47

). This was quantified by

5.

Barone, P. ∙ Batardiere, A. ∙ Knoblauch, K....

**Laminar distribution of neurons in extrastriate areas projecting to visual areas V1 and V4 correlates with the hierarchical rank and indicates the operation of a distance rule**

*J. Neurosci.* 2000; **20**:3263-3281

[PubMed](https://pubmed.ncbi.nlm.nih.gov/10777791/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=10777791)

, who observed that the fraction of projecting neurons located in the supragranular layers of the source area defines a hierarchical distance between two areas; this allowed them to reproduce the hierarchy of

25.

Felleman, D.J. ∙ Van Essen, D.C.

**Distributed hierarchical processing in the primate cerebral cortex**

*Cereb. Cortex.* 1991; **1**:1-47

using data from connections to only two areas (V1 and V4).

The laminar data included with this paper (see [Table S1](#mmc2)) contain hierarchical distance measured this way for all pairs of cortical areas included in the model ([Figure 2](#fig2) A). We follow the approach of

50.

Markov, N.T. ∙ Vezoli, J. ∙ Chameau, P....

**Anatomy of hierarchy: feedforward and feedback pathways in macaque visual cortex**

*J. Comp. Neurol.* 2014; **522**:225-259

, and use these to estimate each area’s position in an underlying hierarchy. We found that an area’s position in this anatomical hierarchy is strongly correlated with counts of spines on pyramidal neurons in that area (

22.

Elston, G.N.

**Specialization of the neocortical pyramidal cell during primate evolution**

Elsevier,

Kass, J.H. ∙ Preuss, T.M. (Editors)

in: Evolution of Nervous Systems: A Comprehensive Reference. Volume 4. 2007; 191-242

[Google Scholar](https://scholar.google.com/scholar?q=G.N.ElstonSpecialization+of+the+neocortical+pyramidal+cell+during+primate+evolutionJ.H.KassT.M.PreussEvolution+of+Nervous+Systems%3A+A+Comprehensive+ReferenceVolume+42007Elsevier191242)

). This allowed us to introduce a systematic gradient of excitatory connection strength per neuron along the cortical hierarchy, and to explore how such heterogeneity interacts with the pattern of long-range projections to produce large-scale dynamics.

![](https://www.cell.com/cms/10.1016/j.neuron.2015.09.008/asset/2e199fc0-7ab0-4620-a310-c225903f8de7/main.assets/gr2_lrg.jpg)

Figure 2 Hierarchical Organization of the Cortex

As a visual and conceptual aid, in [Figure 2](#fig2) C we use a two-dimensional embedding to plot hierarchy and connectivity for the 29 areas. The angle between two areas reflects connection strength (closer areas have stronger connections), and the distance of an area from the center reflects hierarchy (higher areas closer to the center). The low-dimensional embedding is approximate but captures broad features of cortical organization and provides intuitive understanding of the model’s behavior. It suggests two hierarchical streams of sensory input originating in area V1 (primary visual cortex) and area 2 (part of primary somatosensory cortex) respectively, and converging on densely connected association areas. We next explored the response of the network to these sensory inputs.

### Response to Visual Inputs

We simulated the response of the network to a pulsed input to primary visual cortex (area V1). The response is propagated up the visual hierarchy, progressively slowing as it proceeds ([Figure 3](#fig3) A). Early visual areas, such as V1 and V4, exhibit fast, short-lived responses. Prefrontal areas, on the other hand, exhibit slower responses and longer integration times, with traces of the stimulus persisting several seconds after stimulation. As with the response to a pulse of input, white-noise input is integrated with a hierarchy of timescales: the activity of early sensory areas shows rapid decay of autocorrelation with time whereas cognitive areas are correlated across longer periods ([Figures 3](#fig3) B and 3C). Thus, a hierarchy of widely disparate temporal windows or timescales emerges from this anatomically calibrated model system.

![](https://www.cell.com/cms/10.1016/j.neuron.2015.09.008/asset/5e9cec9e-546d-4023-b53a-90c74988a07d/main.assets/gr3_lrg.jpg)

Figure 3 The Network Shows a Hierarchy of Timescales in Response to Visual Input

To quantitatively compare areas, we fit single or double exponentials to the decay of each area’s autocorrelation function (see [Figure S2](#mmc1) for plots of the fits). These fits capture a dominant characteristic timescale for each area in our model in response to visual stimulation. The time constants from the fits are plotted in [Figure 3](#fig3) D, with areas ordered by position in the anatomical hierarchy. As can be seen from the bar plot, the dominant timescale of an area tends to increase along the hierarchy (i.e., left to right), suggesting an important role for a gradient of excitation in generating the temporal hierarchy.

Nevertheless, an area’s timescales are not entirely determined by its hierarchical position, and the plotted timescales do not increase monotonically with hierarchy. To gain some intuition for the role of long-range projections in the model, consider area 8m (part of the frontal eye fields), which is low in the hierarchy and would show a rapid decay of correlation in the absence of long-range projections (far-right image of [Figure 5](#fig5) A) but instead demonstrates long timescales in the model (and in the empirical observations of

30.

Hasson, U. ∙ Yang, E. ∙ Vallines, I....

**A hierarchy of temporal receptive windows in human cortex**

*J. Neurosci.* 2008; **28**:2539-2550

). As can be seen from [Figure 2](#fig2) C, area 8m participates in a strongly-connected core of prefrontal and association areas (

24.

Ercsey-Ravasz, M. ∙ Markov, N.T. ∙ Lamy, C....

**A predictive network model of cerebral cortical connectivity based on a distance rule**

*Neuron.* 2013; **80**:184-197

48.

Markov, N.T. ∙ Ercsey-Ravasz, M. ∙ Van Essen, D.C....

**Cortical high-density counterstream architectures**

*Science.* 2013; **342**:1238406

), allowing it to show long timescales that emerge from inter-areal excitatory loops (these timescales are strongly attenuated in the absence of feedback projections). The shared slower timescales are particularly characteristic of prefrontal areas in our model (see [Figure S2](#mmc1), especially areas best fit by two timescales). Conversely, whereas area TEpd is high in the hierarchy, it does not participate in this core and is instead strongly coupled to ventral stream visual areas. Thus, it reflects the faster timescales of visual input.

### Multiple Functional Hierarchies

The response to visual input reveals an ascending hierarchy of timescales in the visual system. We next stimulated primary somatosensory cortex (area 2), which is weakly connected to the visual hierarchy and strongly connected to other somatosensory and motor areas ([Figure 2](#fig2) C). As previously, input propagates up a hierarchy of timescales ([Figure 4](#fig4) A). However, the somatosensory response uncovers a different dynamical hierarchy to visual stimulation. Primary somatosensory cortex shows the fastest timescale, followed by primary motor cortex (area F1) and somatosensory association cortex (area 5). Parietal and premotor areas show intermediate timescales and, as with visual stimulation, prefrontal areas show long timescales. Visual areas demonstrate much weaker responses than before and are mostly driven by top-down projections from association areas. Thus, in the absence of direct input, they reflect the slower timescales of a distributed network state. In [Figure 4](#fig4) B, we contrast time constants for visual and somatosensory stimulation across areas.

![](https://www.cell.com/cms/10.1016/j.neuron.2015.09.008/asset/6c4f477c-d798-4c46-b95a-ea59ae94850c/main.assets/gr4_lrg.jpg)

Figure 4 The Response to Somatosensory Input Reveals a Different Functional Hierarchy Subserved by the Same Anatomical Network

An area’s timescales emerge from a combination of local circuit properties, the specificity of long-range projections, and the particular input to the network. Our model allows us to examine the contribution of each. These can be intuitively summarized by noting that each area in [Figure 2](#fig2) C shows timescales approximately determined by its distance from the periphery (hierarchical position), proximity to the central clusters (long-range connectivity), and distance from the source of input.

### Role of Local and Long-Range Projections

To further dissect the contributions of local and long-range projections, we examined time constants in response to visual input after removing either differences in local microcircuitry or inter-areal projections. In the second image of [Figure 5](#fig5) A, we show that the range of timescales is drastically reduced in the absence of differences in the microcircuit across areas. Moreover, there is no longer a relationship to an area’s position in the anatomical hierarchy. Thus, while differences in long-range inputs and outputs to each area are significant, they are insufficient to account for disparate timescales and local heterogeneity is needed.

![](https://www.cell.com/cms/10.1016/j.neuron.2015.09.008/asset/0565c4fe-e63d-4737-9d3e-735050399d0d/main.assets/gr5_lrg.jpg)

Figure 5 Role of Local and Long-Range Projections in Determining Timescales

In the third image of [Figure 5](#fig5) A, we show the effect of removing long-range feedback projections, and for the far right image, we remove all long-range projections and stimulate individual areas separately. The range of time constants is lower, reflecting the propensity of slow areas to form long-range excitatory loops with each other. More significantly, once long-range projections are removed, an area’s time constant simply reflects its position in the hierarchy.

We extend our investigation of the role of long-range projections by contrasting the resting-state response (i.e., equal white-noise input to all areas) of the intact network to networks where long-range connections are scrambled while preserving the gradient of excitation. A number of these networks show responses that are poorly fit by exponentials, so we measure timescale non-parametrically as the time after pulse offset for activity to decay to within 5% of baseline. In [Figure 5](#fig5) B, we show that scrambling almost entirely removes the hierarchy of timescales, further confirming that a gradient of excitation alone is insufficient to separate timescales.

The connectivity data show specificity in which projections exist and in their strengths, and both connection probability and strength decay exponentially with inter-areal distance (

24.

Ercsey-Ravasz, M. ∙ Markov, N.T. ∙ Lamy, C....

**A predictive network model of cerebral cortical connectivity based on a distance rule**

*Neuron.* 2013; **80**:184-197

46.

Markov, N.T. ∙ Misery, P. ∙ Falchier, A....

**Weight consistency specifies regularities of macaque cortical networks**

*Cereb. Cortex.* 2011; **21**:1254-1272

48.

Markov, N.T. ∙ Ercsey-Ravasz, M. ∙ Van Essen, D.C....

**Cortical high-density counterstream architectures**

*Science.* 2013; **342**:1238406

49.

Markov, N.T. ∙ Ercsey-Ravasz, M.M. ∙ Ribeiro Gomes, A.R....

**A weighted and directed interareal connectivity matrix for macaque cerebral cortex**

*Cereb. Cortex.* 2014; **24**:17-36

). In [Figure 5](#fig5) C, we preserve network topology (i.e., which areas are connected), but scramble the strengths of non-zero projections. Here the separation of timescales is strongly attenuated for most areas, suggesting that specificity in projection strengths and not just network topology is required for the timescales we see.

### Localized Eigenvectors and Separated Timescales

The model for a single area is threshold-linear, meaning we ignore nonlinearities besides the constraint that firing rates be positive. This allowed us to explore the genesis of separated timescales with linear systems analysis. The activity of a linear network is the weighted sum of characteristic activity patterns, called eigenvectors (

55.

Rugh, W.J.

**Linear System Theory**

Prentice Hall, New Jersey, 1995

[Google Scholar](https://scholar.google.com/scholar?q=W.J.RughLinear+System+TheorySecond+Edition1995Prentice+HallNew+Jersey)

). Each eigenvector evolves on a timescale given by a corresponding eigenvalue and is differently driven by different inputs.

The eigenvectors of the linearized network are localized: those with short timescales are broadly concentrated around sensory areas and those with long timescales are concentrated at frontal areas ([Figure 6](#fig6)). In general, if an eigenvector is small at a node then its amplitude at that node in response to input will also be small, and the corresponding timescale will be weakly expressed. Thus, localization means that for most inputs network dynamics will be dominated by rapid timescales at sensory areas and slower timescales at cognitive areas. In previous theoretical work, we have shown how localized eigenvectors can arise in networks with gradients of local properties and produce a diversity of timescales (

13.

Chaudhuri, R. ∙ Bernacchia, A. ∙ Wang, X.J.

**A diversity of localized timescales in network activity**

*eLife.* 2014; **3**:e01239

[Google Scholar](https://scholar.google.com/scholar?q=R.ChaudhuriA.BernacchiaX.J.WangA+diversity+of+localized+timescales+in+network+activityeLife32014e01239)

).

![](https://www.cell.com/cms/10.1016/j.neuron.2015.09.008/asset/b3a5f4c3-7e7d-47d3-acc8-5d1f0fbb18be/main.assets/gr6_lrg.jpg)

Figure 6 Eigenvectors of the Network Coupling Matrix Are Weakly Localized, Corresponding to Segregated Temporal Modes

### Extension to Nonlinear Dynamics and Multistability

The threshold-linear local circuit let us highlight the requirements for a hierarchy of timescales and provide intuition from linear systems theory. Moreover, many systems can be linearly approximated, and neural responses are often near linear over a wide range of inputs (

12.

Chance, F.S. ∙ Abbott, L.F. ∙ Reyes, A.D.

**Gain modulation from background synaptic input**

*Neuron.* 2002; **35**:773-782

66.

Wang, X.J.

**Calcium coding and adaptive temporal computation in cortical pyramidal neurons**

*J. Neurophysiol.* 1998; **79**:1549-1566

[PubMed](https://pubmed.ncbi.nlm.nih.gov/9497431/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=9497431)

), making linear and threshold-linear models useful for neural circuits (

16.

Dayan, P. ∙ Abbott, L.F.

**Theoretical Neuroscience**

The MIT Press, 2001

[Google Scholar](https://scholar.google.com/scholar?q=P.DayanL.F.AbbottTheoretical+Neuroscience2001The+MIT+Press)

).

Nevertheless, linear models show limited dynamics and cannot capture features such as persistent activity or multistability, which are thought to be important for cognitive capabilities in higher areas (

69.

Wang, X.J.

**The prefrontal cortex as a quintessential “cognitive-type” neural circuit: working memory and decision making**

Stuss, D.T. ∙ Knight, R.T. (Editors)

**Principles of Frontal Lobe Function**

Cambridge University Press, 2013; 226-248

[Crossref](https://doi.org/10.1093/med/9780199837755.003.0018)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1093%2Fmed%2F9780199837755.003.0018)

). We thus replaced our local circuit with a firing rate (“mean-field”) version of a spiking network with more realistic synaptic dynamics (

67.

Wang, X.J.

**Probabilistic decision making by slow reverberation in cortical circuits**

*Neuron.* 2002; **36**:955-968

70.

Wong, K.F. ∙ Wang, X.J.

**A recurrent network mechanism of time integration in perceptual decisions**

*J. Neurosci.* 2006; **26**:1314-1328

). When isolated, an area in this network can display qualitatively different regimes ([Figure 7](#fig7) A). For relatively weak recurrent connections, an area shows a single stable state. As recurrent excitation is increased, there is a transition to a regime with two stable states, with low and high firing rates that correspond to a resting state and a self-sustained persistent activity state. In this regime, an area can integrate inputs over time and maintain activity in the absence of a stimulus. Such dynamical regimes have been proposed to underlie “cognitive-type” computations such as working memory and decision-making (

67.

Wang, X.J.

**Probabilistic decision making by slow reverberation in cortical circuits**

*Neuron.* 2002; **36**:955-968

69.

Wang, X.J.

**The prefrontal cortex as a quintessential “cognitive-type” neural circuit: working memory and decision making**

Stuss, D.T. ∙ Knight, R.T. (Editors)

**Principles of Frontal Lobe Function**

Cambridge University Press, 2013; 226-248

[Crossref](https://doi.org/10.1093/med/9780199837755.003.0018)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1093%2Fmed%2F9780199837755.003.0018)

).

![](https://www.cell.com/cms/10.1016/j.neuron.2015.09.008/asset/8473d8f4-54d2-4c26-8854-8cee96e639ed/main.assets/gr7_lrg.jpg)

Figure 7 Hierarchy of Timescales in a Nonlinear Model

With this model for each area in the large-scale network, we introduced the previous gradient of excitation. Consequently, sensory areas show single stable states while areas further up the hierarchy can also show persistent activity when driven by strong inputs ([Figure 7](#fig7) B). Small perturbations are insufficient to shift the state of a node but take longer to decay away in areas further up the hierarchy ([Figure 7](#fig7) C).

For small inputs, the network response resembles the threshold-linear model: a brief input to V1 is propagated up the hierarchy, with rapid decays in sensory areas and slow decays in association areas ([Figure 7](#fig7) D). Thus, the previous results extend to a nonlinear model with a larger dynamical repertoire. Exploring the complex dynamical behaviors that this network can show is beyond the scope of this paper, but one interesting consequence of the extended model is that the timescales of small fluctuations around baseline predict the ability of an area to show much longer timescales in response to larger inputs ([Figure 7](#fig7) C and see [Discussion](#sec-3)), as observed in

39.

Honey, C.J. ∙ Thesen, T. ∙ Donner, T.H....

**Slow cortical dynamics and the accumulation of information over long timescales**

*Neuron.* 2012; **76**:423-434

and

53.

Murray, J.D. ∙ Bernacchia, A. ∙ Freedman, D.J....

**A hierarchy of intrinsic timescales across primate cortex**

*Nat. Neurosci.* 2014; **17**:1661-1663

.

### Functional Connectivity

We now investigate the implications of local heterogeneity for network organization as measured by correlations in resting-state activity (resting-state functional connectivity). In our model, frontal and association areas reflect a slowly varying network state, and we hypothesized that this state should strongly shape functional connectivity.

In [Figure 8](#fig8) A, we show functional connectivity in our threshold-linear model with heterogeneity in local area properties, or without it (as typically assumed in models relating functional to anatomical connectivity). The inclusion of a gradient of local excitation reduced the correlation (r <sup>2</sup>) between functional and anatomical connectivity from 0.83 to 0.53 ([Figure S6](#mmc1) shows results using a BOLD kernel \[

8.

Boynton, G.M. ∙ Engel, S.A. ∙ Glover, G.H....

**Linear systems analysis of functional magnetic resonance imaging in human V1**

*J. Neurosci.* 1996; **16**:4207-4221

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8753882/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=8753882)

\]).

![](https://www.cell.com/cms/10.1016/j.neuron.2015.09.008/asset/b5779c9d-8561-4031-aa55-44e3ede9267d/main.assets/gr8_lrg.jpg)

Figure 8 Functional Connectivity Depends on Local Microcircuitry

Multiple studies find that the strength of an anatomical connection between areas (“structural connectivity”) partially predicts correlations in neurophysiological signals from those areas (functional connectivity), but there are significant differences (

15.

Damoiseaux, J.S. ∙ Greicius, M.D.

**Greater than the sum of its parts: a review of studies combining structural connectivity and resting-state functional connectivity**

*Brain Struct. Funct.* 2009; **213**:525-533

17.

Deco, G. ∙ Corbetta, M.

**The dynamical balance of the brain at rest**

*Neuroscientist.* 2011; **17**:107-123

18.

Deco, G. ∙ Ponce-Alvarez, A. ∙ Hagmann, P....

**How local excitation-inhibition ratio impacts the whole brain dynamics**

*J. Neurosci.* 2014; **34**:7886-7898

29.

Hagmann, P. ∙ Cammoun, L. ∙ Gigandet, X....

**Mapping the structural core of human cerebral cortex**

*PLoS Biol.* 2008; **6**:e159

37.

Honey, C.J. ∙ Sporns, O. ∙ Cammoun, L....

**Predicting human resting-state functional connectivity from structural connectivity**

*Proc. Natl. Acad. Sci. USA.* 2009; **106**:2035-2040

38.

Honey, C.J. ∙ Thivierge, J.P. ∙ Sporns, O.

**Can structure predict function in the human brain?**

*Neuroimage.* 2010; **52**:766-776

). Our results also suggest that inter-areal connections are insufficient to predict functional connectivity. However, we find that heterogeneity in local connectivity could help account for the previously unexplained variance.

In our model, slower frontal and temporal areas in particular show enhanced functional connectivity. Consequently, areas with slow timescales play a predominant role in the network, as shown by “lesioning” individual areas ([Figure 8](#fig8) B, left panel). For the simple case of identical input to each area, the effect of lesioning an area is well predicted by the time constant of intrinsic fluctuations ([Figure 8](#fig8) B, right panel). Note that areas most important for functional connectivity are not simply those at the highest positions in the hierarchy (i.e., with the most recurrent connections), and hierarchy alone poorly predicts impact on functional connectivity (r <sup>2</sup> = 0.18). For instance, the caudal superior temporal polysensory region (STPc) and the rostral parabelt (PBr) are at intermediate hierarchical positions but have strong connections to other parts of STP (darker lines in [Figure 8](#fig8) B) forming a cluster that shapes functional connectivity. In general, areas combining intermediate to high hierarchical position and strong connections to slow areas have the strongest influence on global activity patterns.

## Discussion

The main findings of this work are 3-fold. First, it establishes a circuit mechanism for a hierarchy of temporal receptive windows, which has received empirical support in recent human (

26.

Gauthier, B. ∙ Eger, E. ∙ Hesselmann, G....

**Temporal tuning properties along the human ventral visual stream**

*J. Neurosci.* 2012; **32**:14433-14441

30.

Hasson, U. ∙ Yang, E. ∙ Vallines, I....

**A hierarchy of temporal receptive windows in human cortex**

*J. Neurosci.* 2008; **28**:2539-2550

39.

Honey, C.J. ∙ Thesen, T. ∙ Donner, T.H....

**Slow cortical dynamics and the accumulation of information over long timescales**

*Neuron.* 2012; **76**:423-434

45.

Lerner, Y. ∙ Honey, C.J. ∙ Silbert, L.J....

**Topographic mapping of a hierarchy of temporal receptive windows using a narrated story**

*J. Neurosci.* 2011; **31**:2906-2915

63.

Stephens, G.J. ∙ Honey, C.J. ∙ Hasson, U.

**A place for time: the spatiotemporal structure of neural dynamics during natural audition**

*J. Neurophysiol.* 2013; **110**:2019-2026

) and single-unit monkey experiments (

53.

Murray, J.D. ∙ Bernacchia, A. ∙ Freedman, D.J....

**A hierarchy of intrinsic timescales across primate cortex**

*Nat. Neurosci.* 2014; **17**:1661-1663

). The model extends time integration in decision making from local circuits (

68.

Wang, X.J.

**Decision making in recurrent neuronal circuits**

*Neuron.* 2008; **60**:215-234

) to a large-scale system across multiple timescales (

31.

Hasson, U. ∙ Chen, J. ∙ Honey, C.J.

**Hierarchical process memory: memory as an integral component of information processing**

*Trends Cogn. Sci.* 2015; **19**:304-313

). Second, inter-areal heterogeneity implies that areas cannot be treated as identical nodes of a network and slow dynamics in association areas can play a disproportionate role in determining the pattern of functional connectivity. This suggests that functional connectivity analyses be revised. Third, this is the first large-scale dynamical model of the macaque cortex based on weighted and directed connectivity and incorporating heterogeneity across areas.

The ability to integrate and hold information across time is critical for cognition. On the other hand, the brain must rapidly and transiently respond to changing stimuli. Complex behavior thus requires a multitude of coexisting timescales. We demonstrate how such timescales (or temporal receptive windows) naturally emerge in a model of primate cortex, built with quantitative anatomical data. Our work reveals multiple functional hierarchies converging on a slow distributed network of densely connected frontal and other association areas.

A long-standing observation is that strong recurrent connections can produce slower dynamics (

68.

Wang, X.J.

**Decision making in recurrent neuronal circuits**

*Neuron.* 2008; **60**:215-234

), and we show how this basic anatomical motif can interact with the pattern of long-range connections to produce a hierarchy of timescales. The hierarchies we observe with different stimuli thus emerge from a combination of heterogeneity in excitatory connection strengths across areas and the profile of long-range connectivity (which is highly specific to each area (

47.

Markov, N.T. ∙ Ercsey-Ravasz, M. ∙ Lamy, C....

**The role of long-range connections on the specificity of the macaque interareal cortical network**

*Proc. Natl. Acad. Sci. USA.* 2013; **110**:5187-5192

)), and neither alone can predict an area’s timescales. For example, while differences in local recurrence play a crucial role in generating timescales, the correlation between anatomical hierarchy and timescale is relatively weak (r <sup>2</sup> = 0.25, 0.14, 0.22 in the visual, somatosensory, and resting-state conditions, respectively). Moreover, areas can show quite different timescales in response to different inputs: as seen in [Figure 4](#fig4) B, even early visual areas with relatively weak recurrence can have slower timescales. To characterize the dependence of timescales on local and long-range properties, we first removed the gradient of local properties and observed that the hierarchy of timescales vanishes. Separately, we preserved the local properties of areas and either removed ([Figure 5](#fig5) A, right panels) or scrambled the long-range projections both globally and while preserving network topology ([Figures 5](#fig5) B and 5C).

It will be important to further probe the interaction of local and long-range connectivity. This will require additional anatomical and physiological data, and our model can be a platform to explore the consequences of these data for large-scale dynamics. For example, following the finding of

46.

Markov, N.T. ∙ Misery, P. ∙ Falchier, A....

**Weight consistency specifies regularities of macaque cortical networks**

*Cereb. Cortex.* 2011; **21**:1254-1272

that the proportion of local to long-range synapses is roughly conserved across areas, we have chosen to scale both local and long-range projections by an area’s position in the hierarchy. Nevertheless, local and long-range synapses may have different strengths and properties and may differentially target cell types and dendritic locations. Relatedly, long-range inputs may be differentially gated depending on task demands and the local circuit regime. Conversely, in the nonlinear model, long-range input can shift the dynamical regime of the local circuit: an area that lacks persistent activity when isolated may show persistent activity in the presence of a weak long-range control signal. These interactions can provide the network with an enhanced computational repertoire.

To examine timescales in the clearest way possible, we modeled individual areas with a threshold-linear rate model, where time constants are mathematically well defined. However, the results hold for a nonlinear local circuit with multiple stable states. Note that this work did not focus on the latency of neural responses (

10.

Bullier, J.

**Integrated model of visual processing**

*Brain Res. Rev.* 2001; **36**:96-107

57.

Schmolesky, M.T. ∙ Wang, Y. ∙ Hanes, D.P....

**Signal timing across the macaque visual system**

*J. Neurophysiol.* 1998; **79**:3272-3278

[PubMed](https://pubmed.ncbi.nlm.nih.gov/9636126/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=9636126)

), for which a spiking model is needed. Nevertheless, single neurons in the monkey cortex display slow responses during stimulus presentation as shown in the model; for example, in decision tasks prefrontal and parietal neurons can show quasi-linear ramping with a time constant that may appear effectively infinite (

9.

Brunton, B.W. ∙ Botvinick, M.M. ∙ Brody, C.D.

**Rats and humans can optimally accumulate evidence for decision-making**

*Science.* 2013; **340**:95-98

28.

Gold, J.I. ∙ Shadlen, M.N.

**The neural basis of decision making**

*Annu. Rev. Neurosci.* 2007; **30**:535-574

61.

Smith, P.L. ∙ Ratcliff, R.

**Psychology and neurobiology of simple decisions**

*Trends Neurosci.* 2004; **27**:161-168

68.

Wang, X.J.

**Decision making in recurrent neuronal circuits**

*Neuron.* 2008; **60**:215-234

). Thus, the model is the simplest that is adequately designed to reveal a hierarchy of timescales in the cortex.

We systematically introduced heterogeneity into our model by assigning each cortical area a hierarchical position determined by its pattern of feedforward and feedback projections. A priori, there is no reason why excitatory input would vary systematically along this anatomical hierarchy. However, we find that hierarchical position correlates very strongly with the number of spines per neuron in an area ([Figure 2](#fig2) B). This suggests an underlying cortical organizational principle, which could be explored in future (see

58.

Scholtens, L.H. ∙ Schmidt, R. ∙ de Reus, M.A....

**Linking macroscale graph analytical organization to microscale neuroarchitectonics in the macaque connectome**

*J. Neurosci.* 2014; **34**:12192-12205

for a similar observation and

3.

Barbas, H. ∙ Rempel-Clower, N.

**Cortical structure predicts the pattern of corticocortical connections**

*Cereb. Cortex.* 1997; **7**:635-646

and

34.

Hilgetag, C.C. ∙ Dombrowski, S.M. ∙ Barbas, H.

**Classes and gradients of prefrontal cortical organization in the primate**

*Neurocomputing.* 2002; **44**:823-829

for correlation of hierarchy with lamination and relative density of an area).

There are no systematic measurements of the timescales of areas in response to different stimuli, but recent studies have compared temporal responses and integration timescales across areas and report a hierarchical organization (

6.

Bernacchia, A. ∙ Seo, H. ∙ Lee, D....

**A reservoir of time constants for memory traces in cortical neurons**

*Nat. Neurosci.* 2011; **14**:366-372

26.

Gauthier, B. ∙ Eger, E. ∙ Hesselmann, G....

**Temporal tuning properties along the human ventral visual stream**

*J. Neurosci.* 2012; **32**:14433-14441

30.

Hasson, U. ∙ Yang, E. ∙ Vallines, I....

**A hierarchy of temporal receptive windows in human cortex**

*J. Neurosci.* 2008; **28**:2539-2550

39.

Honey, C.J. ∙ Thesen, T. ∙ Donner, T.H....

**Slow cortical dynamics and the accumulation of information over long timescales**

*Neuron.* 2012; **76**:423-434

45.

Lerner, Y. ∙ Honey, C.J. ∙ Silbert, L.J....

**Topographic mapping of a hierarchy of temporal receptive windows using a narrated story**

*J. Neurosci.* 2011; **31**:2906-2915

53.

Murray, J.D. ∙ Bernacchia, A. ∙ Freedman, D.J....

**A hierarchy of intrinsic timescales across primate cortex**

*Nat. Neurosci.* 2014; **17**:1661-1663

54.

Ogawa, T. ∙ Komatsu, H.

**Differential temporal storage capacity in the baseline activity of neurons in macaque frontal eye field and area V4**

*J. Neurophysiol.* 2010; **103**:2433-2445

63.

Stephens, G.J. ∙ Honey, C.J. ∙ Hasson, U.

**A place for time: the spatiotemporal structure of neural dynamics during natural audition**

*J. Neurophysiol.* 2013; **110**:2019-2026

). Notably,

39.

Honey, C.J. ∙ Thesen, T. ∙ Donner, T.H....

**Slow cortical dynamics and the accumulation of information over long timescales**

*Neuron.* 2012; **76**:423-434

connected a functional hierarchy in the timescales of preferred stimuli to a dynamical hierarchy in the timescales of correlation in network activity, and found autocorrelation timescales similar to those we model (in particular, see [Figure 6](#fig6) of

39.

Honey, C.J. ∙ Thesen, T. ∙ Donner, T.H....

**Slow cortical dynamics and the accumulation of information over long timescales**

*Neuron.* 2012; **76**:423-434

). Similarly,

53.

Murray, J.D. ∙ Bernacchia, A. ∙ Freedman, D.J....

**A hierarchy of intrinsic timescales across primate cortex**

*Nat. Neurosci.* 2014; **17**:1661-1663

found that autocorrelation traces were well-described by exponentials, the hierarchical ordering of areas they observe agrees with our model, and the timescales of small fluctuations in that study are close to the intrinsic time constants of areas in the model (i.e., in the absence of long-range projections such as [Figure 5](#fig5) A, far right panel).

Our model has several testable predictions. Though there are multiple combinations of local time constants and network connection strengths that could produce a particular set of observed timescales, the model suggests that timescales of small fluctuations should reflect the intrinsic properties of areas (far right panel of [Figure 5](#fig5) A), while larger responses should reflect time constants that emerge from the entire system (far left panel of [Figure 5](#fig5) A). In the model, slow network timescales are driven by strongly connected frontal and temporal areas, corresponding to a slowly varying global state. Inactivating these areas should decrease slow dynamics in connected areas lower in the hierarchy. The differential responses to visual and somatosensory input suggest that when a particular input is not involved in a task, the corresponding sensory areas better reflect slow changes in global cortical state. This may explain decreases in low-frequency ECoG power (i.e., slow modes) when a subject engages in a task (

33.

He, B.J. ∙ Zempel, J.M. ∙ Snyder, A.Z....

**The temporal structures and functional significance of scale-free brain activity**

*Neuron.* 2010; **66**:353-369

39.

Honey, C.J. ∙ Thesen, T. ∙ Donner, T.H....

**Slow cortical dynamics and the accumulation of information over long timescales**

*Neuron.* 2012; **76**:423-434

), as well as the observation of

63.

Stephens, G.J. ∙ Honey, C.J. ∙ Hasson, U.

**A place for time: the spatiotemporal structure of neural dynamics during natural audition**

*J. Neurophysiol.* 2013; **110**:2019-2026

that, despite fast timescales in response to visual input, early visual areas have slow timescales during auditory processing. Finally, we predict that areas with longer timescales, such as prefrontal and superior temporal areas, can shape functional connectivity to a greater degree. This highlights the importance of incorporating heterogeneous local dynamics in studying the determinants of functional connectivity and, intriguingly, suggests that functional connectivity might be used to probe local properties. Whereas there is some evidence that frontal and association areas show enhanced functional connectivity (

59.

Sepulcre, J. ∙ Liu, H. ∙ Talukdar, T....

**The organization of local and distant functional connectivity in the human brain**

*PLoS Comput. Biol.* 2010; **6**:e1000808

) and of a correlation between enhanced functional connectivity and slow timescales (

4.

Baria, A.T. ∙ Mansour, A. ∙ Huang, L....

**Linking human brain local activity fluctuations to structural and functional network architectures**

*Neuroimage.* 2013; **73**:144-155

), it would be interesting to use functional imaging to better understand the link between functional connectivity and response timescales (for example, as determined by the approach of

30.

Hasson, U. ∙ Yang, E. ∙ Vallines, I....

**A hierarchy of temporal receptive windows in human cortex**

*J. Neurosci.* 2008; **28**:2539-2550

39.

Honey, C.J. ∙ Thesen, T. ∙ Donner, T.H....

**Slow cortical dynamics and the accumulation of information over long timescales**

*Neuron.* 2012; **76**:423-434

45.

Lerner, Y. ∙ Honey, C.J. ∙ Silbert, L.J....

**Topographic mapping of a hierarchy of temporal receptive windows using a narrated story**

*J. Neurosci.* 2011; **31**:2906-2915

, and

26.

Gauthier, B. ∙ Eger, E. ∙ Hesselmann, G....

**Temporal tuning properties along the human ventral visual stream**

*J. Neurosci.* 2012; **32**:14433-14441

). The link between slow timescales and enhanced functional connectivity might also explain observations that functional connectivity is greater at low frequencies (

56.

Salvador, R. ∙ Suckling, J. ∙ Schwarzbauer, C....

**Undirected graphs of frequency-dependent functional connectivity in whole brain networks**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2005; **360**:937-946

). Moreover, because distant areas tend to lack strong direct connections, their functional connectivity will be primarily driven by slow distributed network modes and will be further biased toward low frequencies, as previously observed (

56.

Salvador, R. ∙ Suckling, J. ∙ Schwarzbauer, C....

**Undirected graphs of frequency-dependent functional connectivity in whole brain networks**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2005; **360**:937-946

).

We mostly used a threshold-linear model for local areas, but the hierarchy of timescales holds when areas are modeled by a nonlinear microcircuit, similar to one proposed as a model for general “cognitive-type” computations (

67.

Wang, X.J.

**Probabilistic decision making by slow reverberation in cortical circuits**

*Neuron.* 2002; **36**:955-968

69.

Wang, X.J.

**The prefrontal cortex as a quintessential “cognitive-type” neural circuit: working memory and decision making**

Stuss, D.T. ∙ Knight, R.T. (Editors)

**Principles of Frontal Lobe Function**

Cambridge University Press, 2013; 226-248

[Crossref](https://doi.org/10.1093/med/9780199837755.003.0018)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1093%2Fmed%2F9780199837755.003.0018)

). Depending on connectivity and input parameters, such networks show a single stable state, multistability with persistent firing, or continuous slow fluctuations between metastable states. While we do not explore this broader range of behaviors, note that in the nonlinear model the timescales of small fluctuations around baseline predict an area’s ability to show much longer timescales in response to larger inputs. This can be seen by comparing the timescales of [Figure 7](#fig7) C with the steady states of [Figure 7](#fig7) A, and by contrasting responses to large and small perturbations in [Figures 7](#fig7) B and 7D (note that timescales in response to large perturbations tend to be slower than those from small perturbations even if the area is not bistable). This may explain why the timescales of spontaneous fluctuations in an area (on the order of hundreds of milliseconds) correlate with its sensitivity to temporal structure in stimuli across seconds (

39.

Honey, C.J. ∙ Thesen, T. ∙ Donner, T.H....

**Slow cortical dynamics and the accumulation of information over long timescales**

*Neuron.* 2012; **76**:423-434

) as well as with slow drifts in baseline neural activity and the timescales of reward memory (

53.

Murray, J.D. ∙ Bernacchia, A. ∙ Freedman, D.J....

**A hierarchy of intrinsic timescales across primate cortex**

*Nat. Neurosci.* 2014; **17**:1661-1663

).

Our model is parsimonious, designed to capture a basic mechanism underlying a hierarchy of timescales, and can be extended in several ways. First, the local area model could be made more complex, and an interesting direction is using the SLNs to incorporate a laminar structure. Second, in our model activity propagates along the hierarchy with significant attenuation. This attenuation can be substantially decreased by changing model parameters (M. Joglekar and X.-J.W., unpublished data) and may be removed by synchronous firing (

19.

Diesmann, M. ∙ Gewaltig, M.O. ∙ Aertsen, A.

**Stable propagation of synchronous spiking in cortical neural networks**

*Nature.* 1999; **402**:529-533

) or more sophisticated feedback projections (

52.

Moldakarimov, S. ∙ Bazhenov, M. ∙ Sejnowski, T.J.

**Feedback stabilizes propagation of synchronous spiking in cortical neural networks**

*Proc. Natl. Acad. Sci. USA.* 2015; **112**:2545-2550

). Third, we only consider cortico-cortical connections. Whereas these form the major input to a cortical area (

46.

Markov, N.T. ∙ Misery, P. ∙ Falchier, A....

**Weight consistency specifies regularities of macaque cortical networks**

*Cereb. Cortex.* 2011; **21**:1254-1272

), subcortical projections will play an important role. For example, incorporating thalamo-cortical projections would allow us to more realistically model input and may help set network state and gate inter-areal interactions, whereas neuromodulators such as acetylcholine might modulate the excitability of local populations and enhance information transmission at other synapses. Fourth, as a first step, we used two global parameters to scale long-range connection strengths but emerging data relating long-range anatomy and physiology should be incorporated. Fifth, extensions should include other inter-areal heterogeneities, such as in interneuron types and densities (

51.

Medalla, M. ∙ Barbas, H.

**Synapses with inhibitory neurons differentiate anterior cingulate from dorsolateral prefrontal pathways associated with cognitive control**

*Neuron.* 2009; **61**:609-620

) and in neuromodulatory signaling (

32.

Hawrylycz, M.J. ∙ Lein, E.S. ∙ Guillozet-Bongaarts, A.L....

**An anatomically comprehensive atlas of the adult human brain transcriptome**

*Nature.* 2012; **489**:391-399

). For example, it would be interesting to model the higher numbers of dopaminergic projections to prefrontal areas. Finally, while we have focused on how areas are able to accumulate incoming information on different timescales, processing input requires synthesizing it with previous input. Future work should explore how different areas in our model integrate information from more realistic time-varying stimulation such as a movie or a song and to probe how these responses change when the correlation structure of the input is disrupted (for example, by scrambling).

In conclusion, we report a novel, quantitatively calibrated, dynamical model of the macaque cortex with directed and weighted connectivity. The identification of a specific circuit mechanism for a hierarchy of timescales (temporal receptive windows) represents a key advance toward understanding specialized processes and functions of different (from early sensory to cognitive-type) cortical areas. Our findings demonstrate the importance of heterogeneity in local areal properties, as well as the specific profile of long-range connectivity, in sculpting the large-scale dynamical organization of the brain.

## Experimental Procedures

### Anatomical Data

Connectivity data are from an ongoing project to quantitatively measure all connections between cortical areas in the macaque (

49.

Markov, N.T. ∙ Ercsey-Ravasz, M.M. ∙ Ribeiro Gomes, A.R....

**A weighted and directed interareal connectivity matrix for macaque cerebral cortex**

*Cereb. Cortex.* 2014; **24**:17-36

). Inter-areal connection strengths are measured by counting projecting neurons labeled by retrograde tracer injections and normalizing by the total number of neurons labeled in the injection, yielding a fractional weight or FLN (fraction of labeled neurons) for each pathway:So far, 29 areas have been injected and we use the subnetwork consisting of these areas. The presence or absence of all connections is known bidirectionally, and 66% of possible connections exist, with widely varying strengths.

We also use data on the fraction of neurons in each projection that originate in the upper layers of the source area (SLN, for supragranular layer neurons \[

50.

Markov, N.T. ∙ Vezoli, J. ∙ Chameau, P....

**Anatomy of hierarchy: feedforward and feedback pathways in macaque visual cortex**

*J. Comp. Neurol.* 2014; **522**:225-259

\]) defined as:Data are in [Table S1](#mmc2) and can also be accessed at [http://core-nets.org/](http://core-nets.org/). Further details of data collection can be found in

49.

Markov, N.T. ∙ Ercsey-Ravasz, M.M. ∙ Ribeiro Gomes, A.R....

**A weighted and directed interareal connectivity matrix for macaque cerebral cortex**

*Cereb. Cortex.* 2014; **24**:17-36

50.

Markov, N.T. ∙ Vezoli, J. ∙ Chameau, P....

**Anatomy of hierarchy: feedforward and feedback pathways in macaque visual cortex**

*J. Comp. Neurol.* 2014; **522**:225-259

. All the procedures used in the study followed the national and European regulations concerning animal experiments (EC guidelines 86/609/EC) and were approved by the authorized national and veterinary agencies.

### Hierarchy and Connectivity Embedding

To extract the hierarchy, we follow observations from the visual system that the fraction of projections originating in the supragranular layers of the source area (the SLN) measures hierarchical distance between the source and target areas (

5.

Barone, P. ∙ Batardiere, A. ∙ Knoblauch, K....

**Laminar distribution of neurons in extrastriate areas projecting to visual areas V1 and V4 correlates with the hierarchical rank and indicates the operation of a distance rule**

*J. Neurosci.* 2000; **20**:3263-3281

[PubMed](https://pubmed.ncbi.nlm.nih.gov/10777791/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=10777791)

25.

Felleman, D.J. ∙ Van Essen, D.C.

**Distributed hierarchical processing in the primate cerebral cortex**

*Cereb. Cortex.* 1991; **1**:1-47

50.

Markov, N.T. ∙ Vezoli, J. ∙ Chameau, P....

**Anatomy of hierarchy: feedforward and feedback pathways in macaque visual cortex**

*J. Comp. Neurol.* 2014; **522**:225-259

). We use a generalized linear model to assign hierarchical values to areas such that the differences in hierarchical values predict the SLNs (similar to the method in

50.

Markov, N.T. ∙ Vezoli, J. ∙ Chameau, P....

**Anatomy of hierarchy: feedforward and feedback pathways in macaque visual cortex**

*J. Comp. Neurol.* 2014; **522**:225-259

).

For [Figure 2](#fig2) C, we compute angles θ <sub>i</sub> so that the angular distances between areas A <sub>i</sub> and A <sub>j</sub> correspond to dissimilarity measured as −Log(FLN(A <sub>i</sub>, A <sub>j</sub>)). We then plot the areas on a polar plot with θ(A <sub>i</sub>) = θ <sub>i</sub> and .

See the [Supplemental Experimental Procedures](#mmc1) and [Figure S1](#mmc1) for an expanded discussion of the hierarchy and the circular embedding.

### Model Architecture

Each area consists of an excitatory and an inhibitory population described by

is the firing rate of the i-th excitatory population, with intrinsic time constant τ <sub>E</sub>, couplings w <sub>EE</sub> and w <sub>EI</sub> from the local excitatory and inhibitory population, and external input (both stimulus input and any noise we add to the system). The inhibitory population has corresponding parameters τ <sub>I</sub>, w <sub>IE</sub>, w <sub>II</sub>, and The f-I curves are threshold linear, with slope β <sub>E</sub> and β <sub>Ι</sub>. FLN <sub>ij</sub> is the FLN from area j to area i. μ <sub>EE</sub> and μ <sub>IE</sub> control the strengths of long-range input to the excitatory and inhibitory populations, and do not vary between connections: all specificity comes from the FLNs. η scales both local and long-range excitatory inputs to an area by its position in the hierarchy, h <sub>i</sub>. We set τ <sub>E</sub> = 20 ms, τ <sub>I</sub> = 10 ms, β <sub>E</sub> = 0.066 Hz/pA, β <sub>I</sub> = 0.351 Hz/pA, w <sub>EE</sub> = 24.3 pA/Hz, w <sub>IE</sub> = 12.2 pA/Hz, w <sub>EI</sub> = 19.7 pA/Hz, w <sub>II</sub> = 12.5 pA/Hz, μ <sub>EE</sub> = 33.7 pA/Hz, μ <sub>IE</sub> = 25.3 pA/Hz and η = 0.68. For more details, see the [Supplemental Experimental Procedures](#mmc1).

We mostly ignore inter-areal conduction delays; however, see [Figure S3](#mmc1) for a network with conduction delays.

### Pulse Input, Autocorrelation, and Fitted Time Constants

For [Figures 3](#fig3), [4](#fig4), [5](#fig5), and [8](#fig8), we choose the background input for each area so that the excitatory and inhibitory populations have rates of 10 and 35 Hz, respectively.

In [Figure 3](#fig3) A, V1 receives a 250 ms pulse of input that drives its rate to 100 Hz. For the remaining images of this figure and [Figure 5](#fig5) A, the stimulus to V1 is white noise with a mean of 2 Hz and a SD of 0.5 Hz. The other areas receive a small amount of background input (SD on the order of 10 <sup>−5</sup>), but are primarily driven by long-range input propagating out from area V1. For [Figure 4](#fig4), the currents are the same except that area 2 receives the stimulus rather than V1.

For each area, we extract time constants by fitting both one and two exponentials to the part of the autocorrelation function that decays from 1 to 0.05. If the sum of squared errors of the single exponential fit is less than eight times that of the double exponential, then we report that time-constant. Otherwise, we use the sum of time constants from the double exponential fit, with each weighted by its amplitude. Fits in response to V1 and area 2 input and for resting state activity are shown in [Figures S2, S4, and S5](#mmc1).

For [Figure 4](#fig4) B, we map the time constants logarithmically to a heatmap and plot them using Caret (

64.

Van Essen, D.C. ∙ Drury, H.A. ∙ Dickson, J....

**An integrated software suite for surface-based analyses of cerebral cortex**

*J. Am. Med. Inform. Assoc.* 2001; **8**:443-459

).

### Functional Connectivity

To highlight the effect of intrinsic hierarchy, in [Figure 8](#fig8) A we contrast a network without hierarchy with a network that has a gradient of local excitatory connections but unlike in the remaining figures, no gradient in the long-range projection strengths (thus, these networks have the same long-range connection strengths and differences emerge from local properties). We replace

for the excitatory population, and similarly for the inhibitory population. For [Figure 8](#fig8) B, we use the same network as elsewhere, so that all incoming excitatory projections are scaled by an area’s hierarchical position.

We calculate functional connectivity as the correlation matrix of area activity in response to equal white-noise input to all areas. For [Figure 8](#fig8) B, we determine this correlation matrix analytically (see [Supplemental Experimental Procedures](#mmc1)). The effect of lesioning an area, A, is measured as ||C <sub>l,A</sub> −C <sub>rs,A</sub> ||/||C <sub>rs,A</sub> ||, where C <sub>l,A</sub> is the correlation matrix after lesioning A, C <sub>rs,A</sub> is the intact correlation matrix without the row and column corresponding to A, and the double lines indicate the norm. The values are then scaled to lie between 0 and 1.

### Nonlinear Network

The nonlinear single area model is a variant of a model proposed in

70.

Wong, K.F. ∙ Wang, X.J.

**A recurrent network mechanism of time integration in perceptual decisions**

*J. Neurosci.* 2006; **26**:1314-1328

as an approximation to a spiking network with AMPA, GABA and NMDA synapses (

67.

Wang, X.J.

**Probabilistic decision making by slow reverberation in cortical circuits**

*Neuron.* 2002; **36**:955-968

). Each area is described by:ν <sub>E</sub> and ν <sub>I</sub> are excitatory and inhibitory firing rates, s <sub>N</sub> is a gating variable corresponding to NMDA synapses (with decay timescale τ <sub>N</sub>) and φ is a simplified f-I curve from

1.

Abbott, L.F. ∙ Chance, F.S.

**Drivers and modulators from push-pull and balanced synaptic input**

*Prog. Brain Res.* 2005; **149**:147-155

. We set τ <sub>N =</sub> 60 ms, τ <sub>I</sub> = 10 ms, γ = 0.641, w <sub>EE</sub> = 250.2 pA, w <sub>EI</sub> = 8.110 pA/Hz, w <sub>IE</sub> = 303.9 pA, and w <sub>II</sub> = 12.5 pA/Hz.

For [Figures 7](#fig7) A–7C, we remove long-range connections and characterize an isolated area. The bifurcation diagram of [Figure 7](#fig7) A shows network steady states as we vary the hierarchy scaling (i.e., 1+ηh <sub>i</sub>), whereas [Figure 7](#fig7) C shows the slowest timescale of the Jacobian around the low firing state.

For [Figure 7](#fig7) B, we set η = 3.4 and give a 100 Hz pulse of input for 250 ms to the two disconnected areas at opposite ends of the hierarchy (V1 and 24c). For [Figure 7](#fig7) D, we consider a connected network, with long-range projections only targeting excitatory subpopulations, for simplicity, and set μ <sub>EE</sub> = 125.1 pA. We give a 200 Hz pulse of input to area V1 for 250 ms.
