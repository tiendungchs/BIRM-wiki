---
title: "Opposing Influence of Top-down and Bottom-up Input on Excitatory Layer 2/3 Neurons in Mouse Primary Visual Cortex"
source: "https://www.cell.com/neuron/fulltext/S0896-6273(20)30748-0"
author:
  - "[[Rebecca Jordan]]"
  - "[[Georg B. Keller]]"
published: 2020-03-30
created: 2026-09-18
description: "Jordan and Keller use whole cell recordings in mice navigating in virtual realityto show that neurons only in superficial cortical layers have a special property:they integrate visual flow and locomotion speed with opposing signs, allowing themto compute bidirectional mismatches between actual and expected visual flow speeds."
tags:
  - "clippings"
---
## Summary

Processing in cortical circuits is driven by combinations of cortical and subcortical inputs. These inputs are often conceptually categorized as bottom-up, conveying sensory information, and top-down, conveying contextual information. Using intracellular recordings in mouse primary visual cortex, we measured neuronal responses to visual input, locomotion, and visuomotor mismatches. We show that layer 2/3 (L2/3) neurons compute a difference between top-down motor-related input and bottom-up visual flow input. Most L2/3 neurons responded to visuomotor mismatch with either hyperpolarization or depolarization, and the size of this response was correlated with distinct physiological properties. Consistent with a subtraction of bottom-up and top-down input, visual and motor-related inputs had opposing influence on L2/3 neurons. In infragranular neurons, we found no evidence of a difference computation and responses were consistent with positive integration of visuomotor inputs. Our results provide evidence that L2/3 functions as a bidirectional comparator of top-down and bottom-up input.

Sign in to unlock the full response and ask your own questions.

[Sign in](https://www.cell.com/action/idLogin?type=login&redirectUri=https%3A%2F%2Fwww.cell.com%2Fneuron%2Ffulltext%2FS0896-6273%2820%2930748-0&pii=S0896627320307480)

### Questions you could ask:

- How was the correlation between mismatch response and visual response calculated?
- What is the assumed driving force behind visual flow responses compared to locomotion responses?
- What challenges are presented in quantifying mismatch responses and visual tuning curves in the same neurons?

### Actions you could take:

- Summarize this article
- Summarize experiments

## Introduction

Predicting the sensory consequences of self-motion is a central component of feedback guided motor control and allows the brain to infer whether sensory stimuli are self-generated or externally generated (

5.

Crapse, T.B. ∙ Sommer, M.A.

**Corollary discharge across the animal kingdom**

*Nat. Rev. Neurosci.* 2008; **9**:587-600

). It is still unclear how the nervous system learns and represents the relationships between movement and sensory feedback. One brain structure involved in complex sensorimotor learning processes is the neocortex (

21.

Lalazar, H. ∙ Vaadia, E.

**Neural basis of sensorimotor learning: modifying internal models**

*Curr. Opin. Neurobiol.* 2008; **18**:573-581

;

26.

Makino, H. ∙ Hwang, E.J. ∙ Hedrick, N.G....

**Circuit Mechanisms of Sensorimotor Learning**

*Neuron.* 2016; **92**:705-721

). Cortical areas receive both bottom-up sensory-driven input and top-down input that is thought to signal contextual and motor-related information (

8.

Engel, A.K. ∙ Fries, P. ∙ Singer, W.

**Dynamic predictions: oscillations and synchrony in top-down processing**

*Nat. Rev. Neurosci.* 2001; **2**:704-716

). The primary visual cortex (V1) of mice receives bottom-up visual input from the lateral geniculate nucleus, as well as top-down input from various other cortical areas, including higher-order visual cortices, retrosplenial cortex, and anterior cingulate cortex (

25.

Leinweber, M. ∙ Ward, D.R. ∙ Sobczak, J.M....

**A Sensorimotor Circuit in Mouse Cortex for Visual Flow Predictions**

*Neuron.* 2017; **95**:1420-1432.e5

;

30.

Oh, S.W. ∙ Harris, J.A. ∙ Ng, L....

**A mesoscale connectome of the mouse brain**

*Nature.* 2014; **508**:207-214

;

44.

Zhang, S. ∙ Xu, M. ∙ Chang, W.C....

**Organization of long-range inputs and outputs of frontal cortex for top-down control**

*Nat. Neurosci.* 2016; **19**:1733-1742

). These top-down inputs convey various contextual signals, including attention (

43.

Zhang, S. ∙ Xu, M. ∙ Kamigaki, T....

**Selective attention. Long-range and local circuits for top-down modulation of visual cortex processing**

*Science.* 2014; **345**:660-665

), spatial information (

9.

Fiser, A. ∙ Mahringer, D. ∙ Oyibo, H.K....

**Experience-dependent spatial expectations in mouse visual cortex**

*Nat. Neurosci.* 2016; **19**:1658-1664

;

37.

Saleem, A.B. ∙ Diamanti, E.M. ∙ Fournier, J....

**Coherent encoding of subjective spatial position in visual cortex and hippocampus**

*Nature.* 2018; **562**:124-127

), head direction (

41.

Vélez-Fort, M. ∙ Bracey, E.F. ∙ Keshavarzi, S....

**A Circuit for Integration of Head- and Visual-Motion Signals in Layer 6 of Mouse Primary Visual Cortex**

*Neuron.* 2018; **98**:179-191.e6

), and locomotion-related signals (

25.

Leinweber, M. ∙ Ward, D.R. ∙ Sobczak, J.M....

**A Sensorimotor Circuit in Mouse Cortex for Visual Flow Predictions**

*Neuron.* 2017; **95**:1420-1432.e5

).

There are different, though not mutually exclusive, ideas about the computational purpose of integrating bottom-up and top-down inputs. Locomotion-related input may function to increase the signal-to-noise ratio of visual responses by enhancing visual responses in V1 (). During locomotion, neuromodulatory inputs are more active (

22.

Larsen, R.S. ∙ Turschak, E. ∙ Daigle, T....

**Activation of neuromodulatory axon projections in primary visual cortex during periods of locomotion and pupil dilation**

*bioRxiv.* 2018;

;

34.

Reimer, J. ∙ McGinley, M.J. ∙ Liu, Y....

**Pupil fluctuations track rapid changes in adrenergic and cholinergic activity in cortex**

*Nat. Commun.* 2016; **7**:13289

), and there is widespread depolarization of cortical neurons (

4.

Bennett, C. ∙ Arroyo, S. ∙ Hestrin, S.

*Neuron.* 2013; **80**:350-357

;

32.

Polack, P.-O. ∙ Friedman, J. ∙ Golshani, P.

**Cellular mechanisms of brain state-dependent gain modulation in visual cortex**

*Nat. Neurosci.* 2013; **16**:1331-1339

), indicating a locomotion-related state change that likely underlies the increased gain of visual responses (

11.

Fu, Y. ∙ Tucciarone, J.M. ∙ Espinosa, J.S....

**A cortical circuit for gain control by behavioral state**

*Cell.* 2014; **156**:1139-1152

;

32.

Polack, P.-O. ∙ Friedman, J. ∙ Golshani, P.

**Cellular mechanisms of brain state-dependent gain modulation in visual cortex**

*Nat. Neurosci.* 2013; **16**:1331-1339

). Another idea is that V1 integrates positively weighted sums of locomotion speed and visual flow speed to estimate an animal’s speed through the world (

36.

Saleem, A.B. ∙ Ayaz, A. ∙ Jeffery, K.J....

**Integration of visual motion and locomotion in mouse visual cortex**

*Nat. Neurosci.* 2013; **16**:1864-1869

). This was based on the finding that neurons in V1 can be driven by locomotion in absence of visual input (

19.

Keller, G.B. ∙ Bonhoeffer, T. ∙ Hübener, M.

**Sensorimotor mismatch signals in primary visual cortex of the behaving mouse**

*Neuron.* 2012; **74**:809-815

) and often have activity that correlates positively with both visual flow speed and locomotion speed (

36.

Saleem, A.B. ∙ Ayaz, A. ∙ Jeffery, K.J....

**Integration of visual motion and locomotion in mouse visual cortex**

*Nat. Neurosci.* 2013; **16**:1864-1869

). It has also been proposed that layer 2/3 (L2/3) neurons compute a difference between visual and locomotion-related input to convey visuomotor prediction errors (

18.

Keller, G.B. ∙ Mrsic-Flogel, T.D.

**Predictive Processing: A Canonical Cortical Computation**

*Neuron.* 2018; **100**:424-435

). This interpretation is based on the computational framework of predictive processing (

33.

Rao, R.P.N. ∙ Ballard, D.H.

**Predictive coding in the visual cortex: a functional interpretation of some extra-classical receptive-field effects**

*Nat. Neurosci.* 1999; **2**:79-87

) and the discovery of a subset of L2/3 neurons that strongly respond to a sudden mismatch between visual flow feedback and locomotion speed (

19.

Keller, G.B. ∙ Bonhoeffer, T. ∙ Hübener, M.

**Sensorimotor mismatch signals in primary visual cortex of the behaving mouse**

*Neuron.* 2012; **74**:809-815

;

45.

Zmarz, P. ∙ Keller, G.B.

**Mismatch Receptive Fields in Mouse Visual Cortex**

*Neuron.* 2016; **92**:766-772

). In predictive processing, one of the key circuit elements is prediction error neurons. These neurons compare top-down inputs that convey a prediction of sensory input with bottom-up sensory-driven inputs, rendering them responsive to differences between the two. Top-down and bottom-up inputs could be compared using a divisive mechanism (

39.

Spratling, M.W.

**Predictive coding as a model of biased competition in visual attention**

*Vision Res.* 2008; **48**:1391-1408

;

40.

Spratling, M.W. ∙ De Meyer, K. ∙ Kompass, R.

**Unsupervised learning of overlapping image components using divisive input modulation**

*Comput. Intell. Neurosci.* 2009; **2009**:381457

) or a subtractive mechanism (

18.

Keller, G.B. ∙ Mrsic-Flogel, T.D.

**Predictive Processing: A Canonical Cortical Computation**

*Neuron.* 2018; **100**:424-435

;

33.

Rao, R.P.N. ∙ Ballard, D.H.

**Predictive coding in the visual cortex: a functional interpretation of some extra-classical receptive-field effects**

*Nat. Neurosci.* 1999; **2**:79-87

). In the latter case, the weights of these two types of input would be balanced and opposing in a given prediction error neuron. If bottom-up sensory input is excitatory, then the effect of top-down input should be inhibitory, and vice versa.

The predictive processing framework postulates the existence of two types of prediction error neurons: positive prediction error neurons that subtract a top-down prediction from the sensory input and negative prediction error neurons that subtract sensory input from the top-down prediction (

18.

Keller, G.B. ∙ Mrsic-Flogel, T.D.

**Predictive Processing: A Canonical Cortical Computation**

*Neuron.* 2018; **100**:424-435

;

33.

Rao, R.P.N. ∙ Ballard, D.H.

**Predictive coding in the visual cortex: a functional interpretation of some extra-classical receptive-field effects**

*Nat. Neurosci.* 1999; **2**:79-87

). The mismatch-responsive neurons found in L2/3 using calcium imaging are consistent with the latter type of neurons. V1 receives both bottom-up excitation and visually driven inhibition (

2.

Attinger, A. ∙ Wang, B. ∙ Keller, G.B.

**Visuomotor Coupling Shapes the Functional Development of Mouse Visual Cortex**

*Cell.* 2017; **169**:1291-1302.e14

), as well as a combination of excitatory and inhibitory top-down inputs (

13.

Gilbert, C.D. ∙ Li, W.

**Top-down influences on visual processing**

*Nat. Rev. Neurosci.* 2013; **14**:350-363

;

25.

Leinweber, M. ∙ Ward, D.R. ∙ Sobczak, J.M....

**A Sensorimotor Circuit in Mouse Cortex for Visual Flow Predictions**

*Neuron.* 2017; **95**:1420-1432.e5

;

43.

Zhang, S. ∙ Xu, M. ∙ Kamigaki, T....

**Selective attention. Long-range and local circuits for top-down modulation of visual cortex processing**

*Science.* 2014; **345**:660-665

). If the strengths of the two sources of input were balanced and opposing in individual neurons, prediction error responses would arise from a temporary imbalance between the two inputs.

To test for the existence of a balance between top-down and bottom-up inputs, we performed intracellular recordings in V1 of mice exploring a virtual reality environment. We found widespread responses to visuomotor mismatch in L2/3 excitatory neurons ranging from strongly hyperpolarizing to strongly depolarizing. The magnitude and sign of these responses is associated with differences in electrophysiological properties, visual responses, and membrane potential (V <sub>m</sub>) dynamics during locomotion. Moreover, the influence of visual input and that of locomotion-related input on V <sub>m</sub> were opposing, consistent with the hypothesis that L2/3 computes a difference between the two inputs. By contrast, deep-layer neurons did not show this characteristic, instead exhibiting depolarizing responses to both types of input.

## Results

We made blind whole-cell recordings in V1 of mice head-fixed on a spherical treadmill with locomotion coupled to visual flow feedback in a virtual reality environment ([Figures 1](#fig1) A and 1B;

24.

Leinweber, M. ∙ Zmarz, P. ∙ Buchmann, P....

**Two-photon calcium imaging in mice navigating a virtual reality environment**

*J. Vis. Exp.* 2014; **84**:e50885

[Google Scholar](https://scholar.google.com/scholar?q=M.LeinweberP.ZmarzP.BuchmannP.ArgastM.H%C3%BCbenerT.BonhoefferG.B.KellerTwo-photon+calcium+imaging+in+mice+navigating+a+virtual+reality+environmentJ.%C2%A0Vis.+Exp.842014e50885)

). At the beginning of each recording, full-field visual flow was coupled to mouse locomotion. This coupling was interrupted by suddenly halting visual flow for 1 s at random times to generate visuomotor mismatch events (

19.

Keller, G.B. ∙ Bonhoeffer, T. ∙ Hübener, M.

**Sensorimotor mismatch signals in primary visual cortex of the behaving mouse**

*Neuron.* 2012; **74**:809-815

). To minimize the influence of changes in eye position, we used full-field visual flow halts that induce a uniform mismatch stimulus independent of eye position and that do not trigger eye movements ([Figure S1](#mmc1);

19.

Keller, G.B. ∙ Bonhoeffer, T. ∙ Hübener, M.

**Sensorimotor mismatch signals in primary visual cortex of the behaving mouse**

*Neuron.* 2012; **74**:809-815

;

45.

Zmarz, P. ∙ Keller, G.B.

**Mismatch Receptive Fields in Mouse Visual Cortex**

*Neuron.* 2016; **92**:766-772

). Following the closed-loop session, we decoupled locomotion and visual flow to measure the effects of each on neuronal activity separately. Visual stimuli consisted of 1 s full-field, fixed-speed flow of the virtual tunnel walls, presented at random times. We made whole-cell recordings from 54 neurons. Putative interneurons, with an input resistance exceeding 100 MΩ, or a spike half-width below 0.6 ms (

12.

Gentet, L.J. ∙ Kremer, Y. ∙ Taniguchi, H....

**Unique functional properties of somatostatin-expressing GABAergic neurons in mouse barrel cortex**

*Nat. Neurosci.* 2012; **15**:607-612

;

31.

Pala, A. ∙ Petersen, C.C.H.

***In vivo* measurement of cell-type-specific synaptic connectivity and synaptic transmission in layer 2/3 mouse barrel cortex**

*Neuron.* 2015; **85**:68-75

), were excluded from all analyses. These criteria do not exclude lower-input-resistance, non-fast-spiking interneurons (

12.

Gentet, L.J. ∙ Kremer, Y. ∙ Taniguchi, H....

**Unique functional properties of somatostatin-expressing GABAergic neurons in mouse barrel cortex**

*Nat. Neurosci.* 2012; **15**:607-612

). In total 15% of neurons were excluded, leaving 46 putative excitatory neurons in the sample ([Figure S2](#mmc1)).

![](https://www.cell.com/cms/10.1016/j.neuron.2020.09.024/asset/35a46a21-c570-47f4-9a4a-52c280693c0a/main.assets/gr1_lrg.jpg)

Figure 1 Whole-Cell Recordings during Visuomotor Coupling and Mismatch

### Subthreshold Mismatch Responses Are Widespread in Putative L2/3 Excitatory Neurons

We first assessed the visuomotor mismatch responses of 32 putative L2/3 excitatory neurons recorded within 400 μm of the cortical surface. Consistent with mismatch responses described previously using calcium imaging (

19.

Keller, G.B. ∙ Bonhoeffer, T. ∙ Hübener, M.

**Sensorimotor mismatch signals in primary visual cortex of the behaving mouse**

*Neuron.* 2012; **74**:809-815

;

45.

Zmarz, P. ∙ Keller, G.B.

**Mismatch Receptive Fields in Mouse Visual Cortex**

*Neuron.* 2016; **92**:766-772

), we found neurons with depolarizing responses to mismatch ([Figures 1](#fig1) C and 1D). We also found neurons with hyperpolarizing responses ([Figures 1](#fig1) E and 1F). Across neurons, the distribution of mismatch responses was unimodal, with 78% (25/32) responding significantly (see [STAR Methods](#sec-4); [Figures 2](#fig2) A, 2B, and [S3](#mmc1) A). We operationally defined neurons as either depolarizing mismatch (dMM, n = 17) neurons or hyperpolarizing mismatch (hMM, n = 6) neurons if their average mismatch response was above 1 mV or below −1 mV, respectively. This threshold value is arbitrary, and our results are robust using a range of thresholds. The remaining neurons (9 of 32, denoted as unclassified) did not exceed the average 1 mV threshold but often showed brief depolarizing responses at the onset and/or the offset of mismatch. The different signs of mismatch response could not be explained by regression to a common reversal potential, because mismatch responses were not related to pre-stimulus voltage ([Figure S3](#mmc1) B). Mean mismatch responses were comparable in magnitude to the standard deviation (SD) of V <sub>m</sub> for most neurons ([Figure S3](#mmc1) C), and the mean fraction of trials with responses larger than 2 SDs across all neurons was 28% ± 19% ([Figure S3](#mmc1) D). Potentially because of this trial-to-trial variability, spiking responses were less common in the dataset but overall reflected the subthreshold responses ([Figures 2](#fig2) C and 2D). Different response types were intermixed, because they could be recorded from the same craniotomy ([Figures S3](#mmc1) E–S3G).

![](https://www.cell.com/cms/10.1016/j.neuron.2020.09.024/asset/269864ba-de67-4db9-864d-820ecbfb8af8/main.assets/gr2_lrg.jpg)

Figure 2 Subthreshold Mismatch Responses Are Widespread in L2/3, and Responses Correlate with Locomotion Speed

We previously found that mismatch responses scale with locomotion speed (

19.

Keller, G.B. ∙ Bonhoeffer, T. ∙ Hübener, M.

**Sensorimotor mismatch signals in primary visual cortex of the behaving mouse**

*Neuron.* 2012; **74**:809-815

;

45.

Zmarz, P. ∙ Keller, G.B.

**Mismatch Receptive Fields in Mouse Visual Cortex**

*Neuron.* 2016; **92**:766-772

). Congruently, 30% of neurons exhibited significant correlations between mismatch response and locomotion speed across trials ([Figures 2](#fig2) E–2G). The sign of this correlation was significantly different between dMM neurons and hMM neurons ([Figures 2](#fig2) G and [S3](#mmc1) H). Given that during mismatch the difference between predicted and actual visual flow speed is simply a function of the locomotion speed, an increase in mismatch response with increasing locomotion speed is consistent with an increased prediction error.

### Mismatch Response Sign Is Associated with Different Electrophysiological Properties

Biophysical properties can be tuned by the profile of synaptic input received by the neuron (

1.

Angelo, K. ∙ Rancz, E.A. ∙ Pimentel, D....

**A biophysical signature of network affiliation and sensory processing in mitral cells**

*Nature.* 2012; **488**:375-378

;

7.

Desai, N.S. ∙ Rutherford, L.C. ∙ Turrigiano, G.G.

**Plasticity in the intrinsic excitability of cortical pyramidal neurons**

*Nat. Neurosci.* 1999; **2**:515-520

). We found that certain electrophysiological properties correlated with mismatch responses, including initial resting V <sub>m</sub>, variance in V <sub>m</sub> (when stationary), and baseline spike rates ([Figure 3](#fig3) A). To test whether a neuron’s mismatch response was predictable from its electrophysiological properties, we used multiple linear regression to predict mismatch responses using the following six properties: initial resting V <sub>m</sub>, input resistance, V <sub>m</sub> variance (during stationary periods), baseline spike rate, membrane time constant, and spike threshold (see [STAR Methods](#sec-4)). The variance in mismatch response explained by the linear model was 77% when using all six properties and was significantly higher than for shuffle controls (p < 0.0001) (see [STAR Methods](#sec-4); [Figures 3](#fig3) B and 3C). The contribution of each electrophysiological property to the variance explained ranged between 5% and 25%, with no single property dominating the effect ([Figure 3](#fig3) D). Using leave-one-out analysis, we found there were significantly higher positive correlations between predicted and actual mismatch responses when the model was generated using actual data compared with randomly permuted controls (actual: 0.65 ± 0.06; shuffle controls: −0.06 ± 0.21; p < 0.001) (see [STAR Methods](#sec-4); [Figure 3](#fig3) E). Thus, responses to mismatch were correlated with electrophysiological properties, potentially indicating differences in synaptic inputs and/or cell-type-specific and intrinsic properties.

![](https://www.cell.com/cms/10.1016/j.neuron.2020.09.024/asset/d8e87204-b8cd-4415-8c1d-a67a9494b03b/main.assets/gr3_lrg.jpg)

Figure 3 Mismatch Responses Are Predictable from Electrophysiological Properties

### Mismatch Responses Are Anticorrelated with Visual Flow Responses in Putative L2/3 Excitatory Neurons

The observed mismatch responses either could be computed by L2/3 neurons as a difference between predicted and actual visual flow input or could simply be inherited from inputs to these neurons. If the responses are inherited, hyperpolarization would simply reflect a mismatch-triggered inhibitory input, and depolarization would reflect a mismatch-triggered excitatory input. However, if mismatch responses are driven by a reduction in visually driven input, we should find an opposing relationship between mismatch responses and visual responses. If visual input is excitatory, then its removal during mismatch would evoke hyperpolarization. Similarly, assuming visual input is inhibitory, removal of this input would evoke depolarization. To test this, we analyzed responses to 1 s visual flow stimuli, presented at random times independent of locomotion. Given that these stimuli are not predictable from locomotion or stimulus history, they constitute a positive prediction error (i.e., more visual flow than predicted). Because visual flow responses during locomotion and during stationary periods were correlated ([Figures S4](#mmc1) A–S4C), we included all presentations in our analysis. We lost 5 putative L2/3 pyramidal neurons before being able to record visual responses. 60% of the remaining neurons responded significantly to visual flow presentations ([Figures 4](#fig4) A–4C; see [STAR Methods](#sec-4)). Subthreshold responses to visual flow were significantly different in dMM and hMM neurons (mean ± SD, dMM: −0.3 ± 1.6 mV, n = 14; hMM: 3.5 ± 3.0 mV, n = 5; p < 0.003, t test) ([Figure 4](#fig4) D), and there was a significant negative correlation between visual flow response and mismatch response (R = −0.49, p < 0.01, n = 27) ([Figure 4](#fig4) E). The different signs of visual response could not be explained by regression to a common reversal potential, because spiking responses largely reflected subthreshold responses ([Figure S4](#mmc1) E), and pre-stimulus V <sub>m</sub> was a poor predictor of visual flow response ([Figures S4](#mmc1) F and S4G). Visual responses were comparable in magnitude to mismatch responses ([Figure S4](#mmc1) H).

![](https://www.cell.com/cms/10.1016/j.neuron.2020.09.024/asset/fe50af47-9aac-4e6e-b86c-98f6063682da/main.assets/gr4_lrg.jpg)

Figure 4 Visual Flow Responses Inversely Relate to Mismatch Responses in L2/3 Neurons

In addition to responses to visual flow onset, we found that many neurons exhibited depolarizing responses or persistent depolarization after visual flow offset ([Figure 4](#fig4) C). One interpretation of this is that the offset of visual flow results in separate excitatory input to L2/3 neurons. Consequently, mismatch responses would arise from a reduction in visual flow-driven input and a parallel increase in input driven by the visual flow offset. Correcting the mismatch responses for this visual flow offset response revealed a strong anticorrelation between visual flow and mismatch responses (R = −0.81, p < 10 <sup>−6</sup>, n = 27) ([Figure 4](#fig4) E; see [STAR Methods](#sec-4)). In a subset of neurons, we presented four distinct visual flow speeds ([Figure 4](#fig4) F). In dMM neurons, visually driven hyperpolarization increased with visual flow speed, resulting in negative correlations between visual flow speed and V <sub>m</sub> response (mean R value ± SD, = −0.54 ± 0.21, n = 6) ([Figure 4](#fig4) G). By contrast, in hMM neurons, visually driven depolarization increased with visual flow speed, resulting in positive correlations (mean R value ± SD = 0.1 ± 0.1, n = 4; dMM versus hMM: p < 0.001, t test). Overall, the opposing relationship between visual responses and mismatch responses is consistent with the latter arising from transient removal of visual flow input.

### The Influence of Locomotion on Vm Differs Depending on Mismatch Response

Computing visuomotor prediction errors requires a top-down input to convey a prediction of visual flow given movement. If a motor-related input is used to compute prediction error responses, we would expect to find that the motor-related input to a given neuron is correlated with the strength of the mismatch responses and anticorrelated with the strength of visual response. Thus, dMM neurons should receive motor-related excitation, whereas hMM neurons should receive motor-related inhibition (

18.

Keller, G.B. ∙ Mrsic-Flogel, T.D.

**Predictive Processing: A Canonical Cortical Computation**

*Neuron.* 2018; **100**:424-435

). Complicating this analysis somewhat, locomotion is associated with a brain state change, likely driven by neuromodulatory inputs (

11.

Fu, Y. ∙ Tucciarone, J.M. ∙ Espinosa, J.S....

**A cortical circuit for gain control by behavioral state**

*Cell.* 2014; **156**:1139-1152

;

32.

Polack, P.-O. ∙ Friedman, J. ∙ Golshani, P.

**Cellular mechanisms of brain state-dependent gain modulation in visual cortex**

*Nat. Neurosci.* 2013; **16**:1331-1339

). We quantified the influence of locomotion on L2/3 neurons in the open-loop condition in absence of coupled visual flow. Consistent with previous work (

4.

Bennett, C. ∙ Arroyo, S. ∙ Hestrin, S.

*Neuron.* 2013; **80**:350-357

;

32.

Polack, P.-O. ∙ Friedman, J. ∙ Golshani, P.

**Cellular mechanisms of brain state-dependent gain modulation in visual cortex**

*Nat. Neurosci.* 2013; **16**:1331-1339

), we observed during locomotion a systematic depolarization in V <sub>m</sub> that began before locomotion onset, a reduction in V <sub>m</sub> variance, and only a small change in spike rates across the dataset ([Figures 5](#fig5) A–5C and [S5](#mmc1) A–S5C). Although all neurons depolarized, locomotion onset responses correlated positively with mismatch responses ([Figure 5](#fig5) D). Locomotion also caused visual responses to become more depolarizing ([Figures S4](#mmc1) A–S4D), consistent with previous findings (

4.

Bennett, C. ∙ Arroyo, S. ∙ Hestrin, S.

*Neuron.* 2013; **80**:350-357

). These results are consistent with a neuromodulatory state change causing widespread depolarization of neurons (

32.

Polack, P.-O. ∙ Friedman, J. ∙ Golshani, P.

**Cellular mechanisms of brain state-dependent gain modulation in visual cortex**

*Nat. Neurosci.* 2013; **16**:1331-1339

), alongside a separate locomotion-related drive that correlates with mismatch response. To minimize the influence of state transitions associated with locomotion onsets and offsets, we analyzed the correlation between V <sub>m</sub> and locomotion speed only during times of locomotion (see [STAR Methods](#sec-4); [Figure S7](#mmc1)). We found that dMM neurons depolarized with increasing locomotion speed, whereas hMM neurons hyperpolarized with increasing locomotion speed (dMM: mean R value ± SD = 0.14 ± 0.13, n = 12; hMM: −0.06 ± 0.07, n = 5; p < 0.005, t test) ([Figure 5](#fig5) E). This is consistent with a locomotion-related excitation onto dMM neurons and inhibition onto hMM neurons that both scale with locomotion speed, in addition to state-dependent depolarization.

![](https://www.cell.com/cms/10.1016/j.neuron.2020.09.024/asset/8b735e76-1977-49aa-90eb-4aabfa757dc1/main.assets/gr5_lrg.jpg)

Figure 5 The Influence of Locomotion on V m Differs Depending on Mismatch Response

If mismatch responses are the result of opposing visual flow and locomotion speed inputs, the effects of locomotion speed and visual flow speed on V <sub>m</sub> should have opposing signs. This was indeed the case: the correlation coefficients between V <sub>m</sub> and locomotion speed were positively correlated with mismatch responses (R = 0.59, p < 0.01) ([Figures 5](#fig5) E, 5F, and [S7](#mmc1)), whereas the correlation coefficients between V <sub>m</sub> and visual flow speed showed a similarly strong negative correlation with mismatch responses (R = −0.54, p < 0.01). Consistent with this, in the closed-loop condition, the change in V <sub>m</sub> during locomotion (and concurrent visual flow) did not depend on mismatch response ([Figure S5](#mmc1) D), whereas the difference in locomotion-related V <sub>m</sub> changes between closed-loop and open-loop epochs was anticorrelated with mismatch response ([Figure S5](#mmc1) E). Although we cannot determine from our data whether locomotion and visual flow inputs are perfectly coincident, we found that the timing of the peak cross-correlation of V <sub>m</sub> with locomotion was well matched with that of the cross-correlation of V <sub>m</sub> with visual flow ([Figure 5](#fig5) F). These data are consistent with L2/3 mismatch-responsive neurons computing the difference between a visual flow input and a locomotion-related input using balanced and opposing excitatory and inhibitory input.

### Infragranular Layers Integrate Visual and Motor-Related Input Differently from L2/3

It has been suggested that infragranular layers 5 and 6 (L5/6) are computationally distinct from L2/3 (

14.

Harris, K.D. ∙ Mrsic-Flogel, T.D.

**Cortical connectivity and sensory coding**

*Nature.* 2013; **503**:51-58

;

33.

Rao, R.P.N. ∙ Ballard, D.H.

**Predictive coding in the visual cortex: a functional interpretation of some extra-classical receptive-field effects**

*Nat. Neurosci.* 1999; **2**:79-87

). To probe for layer specificity in mismatch computation, we examined responses of neurons recorded between 480 and 750 μm from the cortical surface ([Figure 6](#fig6) A), which we consider putative L5/6 excitatory neurons (n = 14). These L5/6 neurons had higher input resistances and higher firing rates than L2/3 neurons ([Figures S6](#mmc1) A and S6B), consistent with differences previously found between L5 and L2/3 neurons (

6.

de Kock, C.P.J. ∙ Sakmann, B.

**Spiking in primary somatosensory cortex during natural whisking in awake head-restrained rats is cell-type specific**

*Proc. Natl. Acad. Sci. USA.* 2009; **106**:16446-16450

;

23.

Lefort, S. ∙ Tomm, C. ∙ Floyd Sarria, J.C....

**The excitatory neuronal network of the C2 barrel column in mouse primary somatosensory cortex**

*Neuron.* 2009; **61**:301-316

;

35.

Sakata, S. ∙ Harris, K.D.

**Laminar structure of spontaneous and sensory-evoked population activity in auditory cortex**

*Neuron.* 2009; **64**:404-418

). In contrast to L2/3 neurons, only 36% (5/14) of neurons responded significantly to mismatch ([Figures 6](#fig6) B and 6C). Depolarizing responses (exceeding 1 mV, dMM) were rare (1 of 14 neurons), whereas half of the neurons (7 of 14) exhibited hyperpolarizing responses (exceeding −1 mV, hMM) ([Figures 6](#fig6) D and [S6](#mmc1) C). Congruently, there was no evidence of positive correlations between mismatch response and locomotion speed in L5/6 neurons ([Figure S6](#mmc1) D). Overall, there was a significant difference between average mismatch responses in L2/3 and L5/6 neurons (mean ± SD, L2/3: 0.8 ± 2.4 mV, 32 neurons; L5/6: −1.5 ± 2.0 mV, 14 neurons; p < 0.01, t test) ([Figures 6](#fig6) E and 6F). The paucity of dMM responses in L5/6 could be the result of (1) reduced bottom-up visual inhibition, (2) reduced excitatory locomotion-related input, (3) a lack of balanced and opposing tuning between these inputs, or (4) any combination of these. To examine these possibilities, we first analyzed visual flow responses. 70% of L5/6 neurons had significant responses to visual flow, all of which were depolarizing ([Figure 6](#fig6) G). However, we found no evidence of a significant difference in average visual responses between L5/6 and L2/3 neurons (mean ± SD, L2/3: 1.3 ± 2.8 mV, 27 neurons; L5/6: 2.0 ± 1.9 mV, 13 neurons; p = 0.40, t test) ([Figures 6](#fig6) H and 6I). In L5/6 neurons, we also found no evidence of a correlation between visual responses and mismatch responses ([Figure S6](#mmc1) E). Next, we looked at locomotion onset responses in L5/6 neurons. Nearly all L5/6 neurons underwent depolarization beginning before locomotion onset that was similar to that of L2/3 neurons (mean ± SD, L2/3: 3.5 ± 2.2 mV; L5/6: 2.8 ± 2.2 mV; p = 0.36, t test) ([Figures 6](#fig6) J–6L). However, unlike in L2/3 neurons, locomotion did not affect visual responses in L5/6 neurons ([Figures S4](#mmc1) C–S4D), similar to findings in the somatosensory cortex (

3.

Ayaz, A. ∙ Stäuble, A. ∙ Hamada, M....

**Layer-specific integration of locomotion and sensory information in mouse barrel cortex**

*Nat. Commun.* 2019; **10**:2585

).

![](https://www.cell.com/cms/10.1016/j.neuron.2020.09.024/asset/e7bc5eb6-c956-4b5b-baee-aa7568c78489/main.assets/gr6_lrg.jpg)

Figure 6 Deep-Layer Neurons Show a Lack of dMM Responses

Finally, we compared how V <sub>m</sub> in L2/3 and L5/6 neurons scaled with locomotion speed and visual flow speed. V <sub>m</sub> in L2/3 neurons tended to exhibit a positive correlation with visual flow and a negative correlation with locomotion, or vice versa, resulting in a significant anticorrelation between the two correlation values (R = −0.65, p < 0.001, n = 22 neurons) ([Figures 7](#fig7) A and [S7](#mmc1)). In contrast, V <sub>m</sub> in L5/6 neurons tended to exhibit positive correlations with both visual flow and locomotion ([Figures 7](#fig7) A and [S7](#mmc1)). To quantify this difference between L2/3 and L5/6 neurons, we computed the angle from 0° in the two-dimensional scatterplot of correlation values for each neuron. This angle is between 0° and 90° for neurons with positive correlations for both visual flow and locomotion and either between 90° and 180° (negative prediction error) or between 270° and 360° (positive prediction error) for neurons with opposing signs of the correlations. We found that this distribution is bimodal for L2/3 neurons, with a significantly higher proportion of neurons with angles corresponding to opposing signs of correlation than that observed in L5/6 neurons (L2/3: 17 of 22 neurons; L5/6: 2 of 12 neurons; p < 0.002, tea tasting exact test) ([Figure 7](#fig7) B). The distribution of angles for L2/3 and L5/6 neurons were significantly more anticorrelated than expected by chance (p < 0.01) (see [STAR Methods](#sec-4)). The difference between the correlation of V <sub>m</sub> with locomotion and the correlation of V <sub>m</sub> with visual flow was a good predictor of mismatch responses in L2/3 neurons (R = 0.58, p < 0.01), but not in L5/6 neurons (R = −0.10, p = 0.75) ([Figure 7](#fig7) C). Thus, the relative lack of dMM responses in L5/6 neurons is likely a result of a lack of balanced and opposing tuning between visual and locomotion-related inputs. Altogether, opposing visual and locomotion-related inputs necessary to compute visuomotor mismatch responses is a specific feature of L2/3 neurons and appears to be absent from L5/6 neurons, indicative of separate computational roles of L2/3 and L5/6 in visuomotor integration.

![](https://www.cell.com/cms/10.1016/j.neuron.2020.09.024/asset/bc8c114f-9766-467a-b1c1-c13a76d8dd6b/main.assets/gr7_lrg.jpg)

Figure 7 L2/3 Neurons, but Not L5/6 Neurons, Integrate Locomotion and Visual Inputs with Opposing Signs

## Discussion

Our results are consistent with the key postulate of the predictive processing framework: visuomotor mismatch responses observed in L2/3 of V1 are the result of a difference computation between predicted visual flow and actual visual flow (

18.

Keller, G.B. ∙ Mrsic-Flogel, T.D.

**Predictive Processing: A Canonical Cortical Computation**

*Neuron.* 2018; **100**:424-435

;

33.

Rao, R.P.N. ∙ Ballard, D.H.

**Predictive coding in the visual cortex: a functional interpretation of some extra-classical receptive-field effects**

*Nat. Neurosci.* 1999; **2**:79-87

). Although the visuomotor integration characteristics of L5/6 could support several models, they are consistent with a role in maintaining an internal representation by integrating over L2/3 and top-down input (

18.

Keller, G.B. ∙ Mrsic-Flogel, T.D.

**Predictive Processing: A Canonical Cortical Computation**

*Neuron.* 2018; **100**:424-435

). This interpretation assumes that visual flow responses are mainly bottom-up driven and locomotion responses are mainly top-down driven.

Several limitations of current-clamp recordings should be kept in mind when interpreting our results. First, we cannot directly determine from changes in V <sub>m</sub> the underlying changes in excitatory and inhibitory inputs. A depolarizing response, for example, can be caused by an increase in excitatory input or a decrease in inhibitory input. Second, somatic recordings do not have direct access to inputs arising on distal dendrites, particularly in awake *in vivo* recordings, in which input resistances are typically low ([Figure S2](#mmc1) A). Consequently, inhibition is underestimated if it arises primarily on distal dendritic compartments or when it shunts depolarizing currents rather than evoking overt hyperpolarization. The sources of the visually driven inhibition onto negative prediction error neurons are somatostatin-positive interneurons (

2.

Attinger, A. ∙ Wang, B. ∙ Keller, G.B.

**Visuomotor Coupling Shapes the Functional Development of Mouse Visual Cortex**

*Cell.* 2017; **169**:1291-1302.e14

), which preferentially target the apical dendrites of L2/3 excitatory neurons (

28.

Markram, H. ∙ Toledo-Rodriguez, M. ∙ Wang, Y....

**Interneurons of the neocortical inhibitory system**

*Nat. Rev. Neurosci.* 2004; **5**:793-807

). This could explain why we only see overt hyperpolarization to visual flow in a subset of dMM neurons. To overcome these limitations, ideally one would want to use genetically encoded voltage indicators to measure voltage changes in the dendrites optically.

It is possible that hMM and dMM neurons are differentially tuned for visual features such as grating orientation and that dMM responses arise from relief from a form of cross-orientation suppression. In the limited recording time of intracellular recordings, it would be difficult to quantify mismatch responses and visual tuning curves in the same neurons. However, a purely visual explanation of the difference between dMM and hMM neurons would not account for the effect of locomotion-related input anticorrelating with that of the visual flow input ([Figures 5](#fig5) F and [7](#fig7) A). This is consistent with suprathreshold mismatch responses not being accounted for by visual responses alone (

45.

Zmarz, P. ∙ Keller, G.B.

**Mismatch Receptive Fields in Mouse Visual Cortex**

*Neuron.* 2016; **92**:766-772

). In addition, cross-orientation suppression likely is not driven by intra-cortical inhibition but instead is the consequence of reduced thalamic drive (

10.

Freeman, T.C.B. ∙ Durand, S. ∙ Kiper, D.C....

**Suppression without inhibition in visual cortex**

*Neuron.* 2002; **35**:759-771

). Thus, a model based purely on bottom-up visually driven responses cannot account for our results.

Assuming hMM and dMM neurons correspond to positive and negative prediction error neurons, why signal the two types of errors in separate populations of neurons? In the midbrain dopaminergic system, positive and negative reward prediction errors are thought to be encoded bidirectionally in individual neurons via increases and decreases in firing rate (

38.

Schultz, W. ∙ Dayan, P. ∙ Montague, P.R.

**A neural substrate of prediction and reward**

*Science.* 1997; **275**:1593-1599

). In the case of cortical L2/3 neurons, baseline firing rates are probably too low to reliably signal with a decrease in firing rate. Splitting negative and positive prediction error responses into two separate populations of neurons alleviates this problem. In addition, this could simplify learning, because the activity of prediction error neurons could be used directly as an error signal to drive plasticity (

15.

Hertäg, L. ∙ Sprekeler, H.

**Learning prediction error neurons in a canonical interneuron circuit**

*eLife.* 2020; **9**:e57541

[Crossref](https://doi.org/10.7554/eLife.57541)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/32820723/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.7554%2FeLife.57541&pmid=32820723)

).

How many spiking responses to mismatch would we expect, assuming the predictive processing framework were a useful model? A simple upper bound on this would be half of the prediction error neuron population: half responds to positive prediction errors, and the other half responds to negative prediction errors. However, here we probed prediction errors by breaking the coupling between forward locomotion and backward visual flow, which represents only a small fraction of the total space of visuomotor coupling a mouse will experience. V1 receives top-down input that conveys predictions of visual input given locomotion (

25.

Leinweber, M. ∙ Ward, D.R. ∙ Sobczak, J.M....

**A Sensorimotor Circuit in Mouse Cortex for Visual Flow Predictions**

*Neuron.* 2017; **95**:1420-1432.e5

), spatial location (

9.

Fiser, A. ∙ Mahringer, D. ∙ Oyibo, H.K....

**Experience-dependent spatial expectations in mouse visual cortex**

*Nat. Neurosci.* 2016; **19**:1658-1664

), and visual surround (

20.

Keller, A.J. ∙ Roth, M.M. ∙ Scanziani, M.

**Feedback generates a second receptive field in neurons of the visual cortex**

*Nature.* 2020; **582**:545-549

). In addition, V1 receives inputs that convey vestibular signals (

41.

Vélez-Fort, M. ∙ Bracey, E.F. ∙ Keshavarzi, S....

**A Circuit for Integration of Head- and Visual-Motion Signals in Layer 6 of Mouse Primary Visual Cortex**

*Neuron.* 2018; **98**:179-191.e6

) and auditory signals (

16.

Ibrahim, L.A. ∙ Mesik, L. ∙ Ji, X.-Y....

**Cross-Modality Sharpening of Visual Cortical Processing through Layer-1-Mediated Inhibition and Disinhibition**

*Neuron.* 2016; **89**:1031-1045

;

17.

Iurilli, G. ∙ Ghezzi, D. ∙ Olcese, U....

**Sound-driven synaptic inhibition in primary visual cortex**

*Neuron.* 2012; **73**:814-828

). In principle, all these top-down inputs could be associated with a population of prediction error neurons selective for a particular type of error. We previously found that L2/3 neurons responsive to the omission of a visual input expected based on spatial location are different from those that respond to the visuomotor mismatches we used here (

9.

Fiser, A. ∙ Mahringer, D. ∙ Oyibo, H.K....

**Experience-dependent spatial expectations in mouse visual cortex**

*Nat. Neurosci.* 2016; **19**:1658-1664

). Thus, there likely is some specificity in the coding of prediction errors. Although L5/6 neurons in our study did not have the opposing influence of locomotion and visual flow input necessary to compute prediction errors, it is possible that they compute prediction errors in different dimensions, for example, when integrating vestibular and visual signals. Furthermore, only 2 of 14 of our infragranular recordings were recorded at the layer 6 depth (>600 μm), and it is possible that in larger datasets, distinct visuomotor integration characteristics may be observed for layer 6 neurons.

Calcium imaging experiments show that 20%–30% of L2/3 neurons respond to mismatch (

2.

Attinger, A. ∙ Wang, B. ∙ Keller, G.B.

**Visuomotor Coupling Shapes the Functional Development of Mouse Visual Cortex**

*Cell.* 2017; **169**:1291-1302.e14

;

19.

Keller, G.B. ∙ Bonhoeffer, T. ∙ Hübener, M.

**Sensorimotor mismatch signals in primary visual cortex of the behaving mouse**

*Neuron.* 2012; **74**:809-815

)—a proportion larger than that estimated to respond to one particular natural scene (3%) or one particular drifting grating (12%) (

42.

Yoshida, T. ∙ Ohki, K.

**Natural images are reliably represented by sparse and variable populations of neurons in visual cortex**

*Nat. Commun.* 2020; **11**:872

). Not surprisingly, the subthreshold tuning for mismatch is broader than the suprathreshold tuning. However, only 10% of our L2/3 neurons show spiking responses to mismatch. Potential causes of this smaller fraction of suprathreshold responses could be internal solution dialysis, the higher rate of mismatch presentation used during the whole-cell recordings, or intracellular calcium rises independent of spiking activity during calcium imaging. Although the cause of this discrepancy is unclear, it does not alter our conclusions.

Altogether, we find L2/3 neurons with responses consistent with signaling either positive or negative prediction errors, which can be explained by opposing visual and locomotion-related inputs. This computation appears confined to L2/3 neurons. It is conceivable that the two functional neuron types in L2/3 are associated with different synaptic input distributions and possibly gene expression profiles. Identifying molecular markers for these different neuron types would allow us to test the hypotheses put forward in the predictive processing framework.

## STAR★Methods

### Key Resources Table

<table><thead><tr><th>REAGENT or RESOURCE</th><th>SOURCE</th><th>IDENTIFIER</th></tr></thead><tbody><tr><td colspan="3"><b>Deposited Data</b></td></tr><tr><td>All data and code used to generate figures.</td><td>This manuscript</td><td><a href="https://data.fmi.ch/">https://data.fmi.ch/</a></td></tr><tr><td colspan="3"><b>Experimental Models: Organisms/Strains</b></td></tr><tr><td><i>Mus musculus</i>: C57BL/6J</td><td>Charles River Laboratories</td><td>IMSR_JAX:000664</td></tr><tr><td colspan="3"><b>Software and Algorithms</b></td></tr><tr><td>MATLAB, 2019</td><td><a href="https://www.mathworks.com/products/matlab.html">https://www.mathworks.com/products/matlab.html</a></td><td>RRID: <a href="https://scicrunch.org/resources/Any/search?q=undefined&l=SCR_001622">SCR_001622</a></td></tr><tr><td>LabView</td><td><a href="https://www.ni.com/en-us/shop/labview.html">https://www.ni.com/en-us/shop/labview.html</a></td><td>RRID: <a href="https://scicrunch.org/resources/Any/search?q=undefined&l=SCR_014325">SCR_014325</a></td></tr><tr><td>Python3</td><td><a href="https://www.python.org/">https://www.python.org/</a></td><td>RRID: <a href="https://scicrunch.org/resources/Any/search?q=undefined&l=SCR_008394">SCR_008394</a></td></tr><tr><td>Panda3D</td><td><a href="https://www.panda3d.org/">https://www.panda3d.org/</a></td><td>N/A</td></tr><tr><td>MultiClamp Commander</td><td><a href="https://www.moleculardevices.com/">https://www.moleculardevices.com/</a></td><td>N/A</td></tr></tbody></table>

- [Open table in a new tab](https://www.cell.com/action/showFullTableHTML?isHtml=true&tableId=undtbl1&pii=S0896-6273%2820%2930748-0)

### Resource Availability

#### Lead Contact

Requests for further information and resources should be directed to the lead contact, Georg Keller ([georg.keller@fmi.ch](mailto:georg.keller@fmi.ch)).

#### Materials Availability

No new unique reagents or mouse lines were generated in this study.

#### Data and Code Availability

All data and analysis code are available online at [https://data.fmi.ch/](https://data.fmi.ch/).

### Experimental Model and Subject Details

All animal procedures were approved by and carried out in accordance with guidelines of the Veterinary Department of the Canton Basel-Stadt, Switzerland.

#### Subjects

32 experimentally naive C57BL/6J mice (RRID:IMSR\_JAX:000664) were used in this study, procured from Charles River Laboratories. Mice were a mixture of males and females and aged between 6 and 10 weeks of age at the time of electrophysiological recording.

### Method Details

#### Head implant surgery

Mice were anesthetized using a mix of fentanyl (0.05 mg/kg), medetomidine (0.5 mg/kg) and midazolam (5 mg/kg). Analgesics were applied perioperatively. Lidocaine was injected locally on the scalp (10 mg/kg s.c.) prior to surgery, while metacam (5 mg/kg, s.c.), and buprenorphine (0.1 mg/kg s.c.) were injected just after completion of the surgery. An incision was made in the skin above the cranium and the periosteum was completely removed from the skull. The surface of the skull was roughened with a dental drill. To optimize stability of the brain for later recordings, a blunt tool was used to apply gentle force to one of the parietal skull plates just anterior to bregma until small forces applied to either intra-parietal or parietal skull plates did not result in relative movement of the bones. In this position, layers of tissue glue (Histoacryl, B.Braun, Germany) were used to fuse the skull plates along the sutures. Tissue glue was then applied to the whole skull surface, and a custom-made titanium head-bar was glued to the skull. At this point, right V1 was marked 2.5 mm lateral to the midline, just anterior to the lambdoid suture. Dental cement was used to fix the head-bar in place and build a recording chamber around V1. Anesthesia was then antagonized (Flumazenil, 0.5 mg/kg and Atipamezole, 2.5 mg/kg i.p.), and the mouse was allowed to recover for 3 days. Buprenorphine or Metacam were provided as a general analgesia on the subsequent 2 days.

#### Whole cell recordings

Micropipettes (5 MΩ to 8 MΩ resistance) were fabricated using a PC-100 puller (Narishige, Tokyo, Japan) from 1.5 mm diameter filamented borosilicate glass (BF150-86-10, Sutter, California, USA). A small 1 mm craniotomy and durectomy were made over the right primary visual cortex (spanning 2 mm to 3 mm lateral from the midline) under isoflurane anesthesia. To stabilize the brain, the craniotomy was covered in a layer (0.5 mm to 1 mm) of 4% low-melting point agar (A9793, Sigma-Aldrich), dissolved in bath recording solution. The recording chamber was submerged in bath recording solution (126 mM NaCl, 5 mM KCl, 10 mM HEPES, 2 mM MgSO <sub>4</sub>, 2 mM CaCl <sub>2</sub>, 12 mM glucose, brought to pH 7.4 using NaOH, with a final osmolarity 280 mOsm to 290 mOsm). The mouse was allowed to recover from isoflurane anesthesia for at least 20 minutes head-fixed prior to recordings, which were only attempted after the mouse had displayed regular locomotion behavior. Whole cell recordings were performed blindly by lowering the micropipette, back-filled with intracellular recording solution (135 mM KMeSO <sub>3</sub>, 5 mM KCl, 0.1 mM EGTA, 10 mM HEPES, 4 mM Mg-ATP, 0.5 mM Na <sub>2</sub> -GTP, 4 mM Na <sub>2</sub> -phosphocreatine, brought to pH 7.3-7.4 with KOH, with an osmolarity 284 mOsm to 288 mOsm), through the agar and 50 μm into the tissue with high pressure (> 500 mbar) applied to the micropipette. The micropipette was visually targeted at the center of the craniotomy. Micropipette resistance was monitored in voltage clamp via observing the electrode current while applying 15 mV square pulses at 20 Hz. Brain entry was detected by a step change in the current (

27.

Margrie, T.W. ∙ Brecht, M. ∙ Sakmann, B.

***In vivo*, low-resistance, whole-cell recordings from neurons in the anaesthetized and awake mammalian brain**

*Pflugers Arch.* 2002; **444**:491-498

), and at this point the descent axis was zeroed. Once a depth of 50 μm from the surface was reached, pipette pressure was lowered to 20 mbar and neuron hunting began. This consisted of advancing the electrode in 2 μm steps until a substantial and progressive increase in pipette resistance was observed for at least 3 consecutive steps. Pressure in the pipette was then rapidly lowered to 0 mbar, and often a small negative pressure was applied to aid in forming a gigaohm seal. Once this was achieved, the pipette was then carefully retracted by up to 4 μm, and break-in achieved using suction pulses. Electrophysiological properties were determined in the first 60 s of the recording using a series of current steps from −0.4 nA to 0.3 nA, and the evoking of action potentials was used to confirm the neuronal nature of the cell. All recordings took place in current clamp mode. Pipette capacitance and series resistance were not compensated. Data were acquired and Bessel low-pass filtered below 4 kHz using a MultiClamp amplifier (Molecular Devices, California USA) and digitized at 20 kHz via custom-written LabView software. Voltage values have not been corrected for the junction potential between the internal solution and bath solution (−8.5 mV), owing to the difficulty of measuring junction potentials accurately *in vivo*. Recordings were terminated if series resistance displayed a substantial increase, as monitored by 25 ms or 50 ms current pulses between −0.1 nA and −0.25 nA applied at 1 Hz throughout the recording. Access resistance was estimated offline from the voltage drop in the 1 ms after current step onset and ranged between 25 MΩ and 140 MΩ for included data (65 MΩ ± 27 MΩ, mean ± SD). For all data included the average membrane potential during stationary periods was more hyperpolarized than −45 mV (on average −61 mV ± 7 mV, mean ± SD; 95% were more hyperpolarized than −55 mV), and spike amplitudes on average were 47 mV ± 16 mV (mean ± SD).

#### Virtual reality

During all recordings, mice were head-fixed in a virtual reality system as described previously (

24.

Leinweber, M. ∙ Zmarz, P. ∙ Buchmann, P....

**Two-photon calcium imaging in mice navigating a virtual reality environment**

*J. Vis. Exp.* 2014; **84**:e50885

[Google Scholar](https://scholar.google.com/scholar?q=M.LeinweberP.ZmarzP.BuchmannP.ArgastM.H%C3%BCbenerT.BonhoefferG.B.KellerTwo-photon+calcium+imaging+in+mice+navigating+a+virtual+reality+environmentJ.%C2%A0Vis.+Exp.842014e50885)

). Briefly, mice were free to run on an air-supported polystyrene ball, the rotation of which was coupled to linear displacement in the virtual environment projected onto a toroidal screen surrounding the mouse. From the point of view of the mouse, the screen covered a visual field of approximately 240 degrees horizontally and 100 degrees vertically. The virtual environment presented on the screen was a virtual tunnel with walls consisting of continuous vertical sinusoidal gratings. Prior to the recording experiments, mice were trained in 1 h to 2 h sessions for 5 d to 7 d, until they displayed regular locomotion.

#### Visual stimuli

During the first segment of each recording, visual flow feedback was coupled to the mouse’s locomotion speed. At random intervals averaging at 7 s, 1 s long halts in visual feedback were presented (referred to as ‘mismatch’ stimuli). After at least 3 minutes of this protocol, the visual feedback was stopped (i.e., no visual flow coupled to locomotion speed), and instead 1 s full-field fixed-speed visual flow stimuli were presented at random intervals (mean ± SD, 8.1 s ± 1.3 s), regardless of locomotion behavior. In a subset of recordings (12 of 27), these stimuli all had one fixed visual flow speed, and in the remaining subset (15 of 27), four different visual flow speeds were presented in a pseudorandom sequence.

### Quantification and Statistical Analysis

All data analysis was performed using custom-written MATLAB (2019) (Mathworks) code.

#### Statistics

For each comparison, first a Lilliefors test was used to test for normality of the distribution. In the case of comparisons involving normal distributions across more than one group (e.g., hMM, dMM and unclassified L2/3 neurons), first a one-way ANOVA was performed. If the distribution was not normal, a one-way ANOVA on ranks was used instead. In the case of a significant result (p < 0.05), either t tests or rank sum tests were used to determine which comparisons were significant (the latter test being used in cases of non-normally distributed data or data comparisons where variance was unequal as determined by a Bartlett test). To test for significant differences in variance in non-normally distributed samples, a Brown-Forsythe test was performed. Box and whisker plots are all drawn such that the box represents the inter-quartile range and median, and the whiskers represent the 10 <sup>th</sup> and 90 <sup>th</sup> percentiles. For all correlations, a method of fitting robust to outliers was used (MATLAB function Fitlm) based on bisquare weighting of residuals.

#### Cell numbers:

In total, we recorded from 54 neurons from 32 mice. Only one craniotomy was performed per mouse. Typically, only one (13 mice), or two neurons (13 mice) would be recorded per mouse, but in rarer cases three neurons (5 mice) would be recorded. Between recordings, mice would be re-exposed to fully coupled visuomotor experience for at least 10 minutes. Of the 54 neurons recorded, 6 neurons were excluded as putative interneurons as they had an input resistance higher than 100 MΩ. A subset of interneuron types (e.g., somatostatin-expressing neurons) have been described to have high input resistances (

12.

Gentet, L.J. ∙ Kremer, Y. ∙ Taniguchi, H....

**Unique functional properties of somatostatin-expressing GABAergic neurons in mouse barrel cortex**

*Nat. Neurosci.* 2012; **15**:607-612

;

31.

Pala, A. ∙ Petersen, C.C.H.

***In vivo* measurement of cell-type-specific synaptic connectivity and synaptic transmission in layer 2/3 mouse barrel cortex**

*Neuron.* 2015; **85**:68-75

). Two neurons were excluded due to spike half-widths below 0.6 ms (putative parvalbumin-expressing neurons). Consistent with the excluded neurons being interneurons, other electrophysiological features differed between these excluded neurons and the remaining putative excitatory neurons, including higher baseline spike rates and more depolarized resting membrane potentials ([Figure S2](#mmc1)). 32 of the remaining 46 putative excitatory neurons were recorded at a vertical depth of less than 400 μm below the cortical surface. We refer to these as putative L2/3 neurons. Of these, 27 underwent both the visuomotor coupled and open-loop parts of the protocol, and the remaining 5 underwent only the former part. Of the 27 neurons with both parts of the protocol, 15 were presented with visual stimuli of four different speeds, while the remaining 12 were presented with only one visual flow speed. The neurons for which we do not have data in the open-loop condition are represented as uniform gray on response heatmaps of visual flow and locomotion onset response. 14 neurons were recorded at vertical depths greater than 480 μm, with a maximum depth of 723 μm (2/14 were recorded at L6 depths of > 600 μm, so the dataset is likely dominated by L5 neurons). We refer to these as putative L5/6 neurons. Of these, 13 underwent both the visuomotor coupled and open-loop parts of the protocol, and the remaining 1 underwent only the former part. Of the 13 neurons with both parts of the protocol, 12 were presented with four different visual flow stimuli of different speeds, and the remaining 1 neuron was presented visual flow stimuli of one speed only. Note that neurons are included in each analysis depending on availability of the relevant data.

#### Spike half-widths and subtraction

Spikes were detected from peaks exceeding −30 mV membrane potential. Spike half-width was measured as the duration of the average spike waveform that exceeded half of the spike amplitude. For all average membrane potential response plots, spikes were removed from membrane potential traces by replacing them with a linear interpolation from the membrane potential recorded 2 ms prior to spike peak, and that recorded 3 ms after spike peak. Voltage responses to the 25 ms or 50 ms duration current pulses used to track access resistance were removed similarly, by replacing them with a linear interpolation from the time just before the current pulse turned on to that 70 ms later.

#### Mismatch responses

Presentation of visual flow halts (mismatches) occurred independent of locomotion speed. As only halts during non-zero visual flow speed would result in a change of the visual stimulus, mismatch events were defined as visual flow halts that occurred during an average locomotion speed exceeding 4 cm/s in the 2 s prior to and after onset of mismatch stimulus. The average number of mismatch presentations per neuron was 15 ± 9 (mean ± standard deviation). To calculate average V <sub>m</sub> responses, spikes and current pulses were removed as described above and the V <sub>m</sub> was baseline-subtracted by the average membrane potential in a window 1 s prior to mismatch for each trial. The mean of all resulting V <sub>m</sub> traces was then taken to generate the average response. The average response for each neuron was taken as the mean V <sub>m</sub> response during the entire 1 s of mismatch presentation. The significance of this response was determined by performing a paired t test between the average V <sub>m</sub> 1 s before mismatch and that in the 1 s during mismatch. Mismatch responses were cross-validated in neurons with at least 10 mismatch trials by calculating mismatch responses in odd and even trials separately ([Figure S3](#mmc1) A). Spiking responses were generated by taking the mean spike count in 250 ms time bins aligned to mismatch onset. To assess the signal to noise ratio of subthreshold mismatch responses, standard deviation of the baseline membrane potential was calculated for each neuron from a distribution of sham-triggered changes in V <sub>m</sub> (average V <sub>m</sub> in 0-1 s baseline subtracted for the average V <sub>m</sub> in the 1 s prior to the sham-trigger) during locomotion([Figures S3](#mmc1) C and S3D).

#### Electrophysiological properties and multiple linear regression analysis:

A series of current steps from −0.4 nA to 0.3 nA were applied to the neuron at least 3 times at the beginning of the recording to determine input resistance. In all cases, mice were stationary at the time of these current steps. The total resistance was calculated by averaging the voltage response for each current step value and measuring the slope between the average response 25 ms to 125 ms after current step onset against the injected current. This was done separately for negative and positive current injection, as the former consistently showed a lower resistance than the latter (in part due to voltage sag during negative current injection). The access resistance was estimated by taking the slope between the current injected and the voltage response in the first 1 ms. Input resistance was calculated as the difference between total resistance and access resistance. Resting membrane potential was defined as the intersection between zero current and the voltage axis. Note that resting membrane potential would often depolarize by a few mV before stabilizing during the first 3 to 5 minutes of the recording, presumably as the intracellular solution diffuses throughout the neuron. As such, membrane voltages read out at later time points (e.g., in [Figure S5](#mmc1)) are different to the initial resting membrane potentials assessed just after break-in. The membrane time constant was estimated by finding the time at which the voltage change fell below 1/ *e* of the difference between 1 ms after current step (−0.1 nA) onset and steady state (estimated as the voltage in the window 45 ms - 50 ms after the onset). Since many cells were silent during zero current injection, spike thresholds were calculated for spikes evoked during the I-V curve (after offline removal of the voltage drop across the series resistance), all of which were overshooting. For each spike, the spike threshold was determined as the voltage at the peak rate of change of the slope of the spike waveform. The median of these spike thresholds was then taken as the measure of spike threshold for the neuron. Spike thresholds measured in this way were similar to those measured in previous *in vivo* studies of L2/3 in primary visual cortex (−40 mV ± 5 mV, mean ± SD) (

4.

Bennett, C. ∙ Arroyo, S. ∙ Hestrin, S.

*Neuron.* 2013; **80**:350-357

;

32.

Polack, P.-O. ∙ Friedman, J. ∙ Golshani, P.

**Cellular mechanisms of brain state-dependent gain modulation in visual cortex**

*Nat. Neurosci.* 2013; **16**:1331-1339

).

In order to determine whether mismatch responses could be predicted from electrophysiological properties, we used a multiple linear regression analysis including six physiological properties: spike threshold, initial resting membrane potential, input resistance, spike rate prior to mismatch stimuli, variance in membrane potential during stationary epochs, and membrane time constant. For each regression, we included 1 to 6 of these properties, in all possible combinations, and determined the variance in mismatch response explained by each model. Since not all properties were measured for each neuron, including more properties in the regression leads to a reduction in sample size which could account for some of the increase in variance explained as more properties are included. To assess this, we performed controls in which mismatch responses were randomly permuted with respect to the sets of electrophysiological properties (10000 permutations per regression). The contribution of each variable to model performance was assessed for all neurons where all data were available. The R <sup>2</sup> of model subsets including a given electrophysiological property were compared to the R <sup>2</sup> of the same subsets missing the property. The average change in R <sup>2</sup> was then averaged for all model subsets, for each individual property. To assess the performance of the models on data not included in model generation, we used all model subsets including 5 or 6 properties, and systematically generated the model excluding one of the 32 L2/3 neurons. We then used the resulting model to predict the response of the left-out neuron and determined the correlation between predicted and actual mismatch responses for the full dataset. This was then compared to 10000 models in which mismatch response was randomly permuted with respect to electrophysiological properties.

#### Changes in membrane potential dynamics during locomotion

To measure membrane potential average and variance, as well as spiking activity during locomotion and stationary periods ([Figure S5](#mmc1)), only the data from the open-loop condition were used. The data were binned into 500 ms time bins, and spike count, median membrane potential and locomotion speed were calculated for each time bin. The locomotion speed trace was smoothed in a 1 s time window prior to this calculation. For quantification of V <sub>m</sub> during stationary periods, all V <sub>m</sub> values corresponding to times when the locomotion speed was below a threshold of 4 cm/s were pooled, and the mean and standard deviation of these values were calculated for each neuron. The same was then done for locomotion periods where the locomotion speed exceeded the 4 cm/s threshold.

To determine the time of locomotion onsets, we detected points where the smoothed locomotion velocity crossed a threshold of 0.8 cm/s and exceeded 4 cm/s in the following 1 s. Average locomotion onset responses were then calculated for each neuron where there were at least 2 locomotion onsets. These were baseline-subtracted by the average membrane potential in the 2.5 s prior to locomotion onset for each trial before averaging all traces. Locomotion onset responses were taken for each neuron as the average response 0 s to 6 s after locomotion onset.

#### Calculation of cross-correlations (E, 5F, and ):

Cross-correlations were calculated between membrane potential and locomotion for the open-loop condition only. For this, the locomotion trace and visual flow trace recorded at 1 kHz were smoothed using a 500 ms time window. Membrane potential was binned in 1 ms time windows. Times during which the mouse was stationary (locomotion < 4 cm/s), and times during which visual flow stimuli were presented, as well as 1 s after the presentation, were excluded. We then computed the cross-correlation between locomotion trace and membrane potential in a window of −2000 ms to +2000 ms. A similar procedure was used for the cross-correlation between membrane potential and visual flow, again excluding periods when the mouse was stationary. For each neuron, the overall correlation coefficient for the locomotion-V <sub>m</sub> correlation was taken as the average cross-correlation for time delays between −500 and +500 ms, as this is where the cross-correlation averaged across the L2/3 and L5/6 samples combined peaked ([Figure S7](#mmc1) B). For each neuron, the overall correlation coefficient for the visual flow-V <sub>m</sub> correlation was taken as the average cross-correlation for time delays between −1000 and 0 ms, as this is where the cross-correlation averaged across the L2/3 and L5/6 samples combined peaked ([Figure S7](#mmc1) B). Only neurons with at least 25 s of locomotion in absence of visual flow were included in these analyses (n = 22 L2/3, n = 12 L5/6).

To compare correlations for L5/6 and L2/3 datasets ([Figure 7](#fig7)), we calculated an interaction angle for each neuron as the arcus tangent of the ratio of the locomotion-V <sub>m</sub> correlation and visual flow-V <sub>m</sub> correlation. Polar histograms were then made for the L2/3 and L5/6 datasets separately ([Figure 7](#fig7) B). The neuron counts for each angular bin were then correlated between L5/6 and L2/3 datasets, generating an R value of −0.1. To test if the resulting anticorrelation was significant, L5/6 and L2/3 interaction angles were pooled, random subsets corresponding to the sample sizes of the L5/6 and L2/3 datasets were drawn, and the correlation coefficients between the shuffled sample distributions were obtained. An R value was then calculated for the correlation between the resulting two polar histograms. This was repeated 10000 times to generate a distribution of correlation coefficients.

To determine how well the correlations for visual flow speed and locomotion speed predicted a neuron’s mismatch response ([Figure 7](#fig7) C), we computed the correlation coefficient between the difference of the two correlation coefficients (R value <sub>locomotion</sub> - R value <sub>visual</sub>) and the mismatch responses, for L2/3 and L5/6 neurons separately. As a shuffle control, we then randomly permuted the visual flow correlation and locomotion correlation values across neurons 100000 times to create a shuffle distribution.

#### Visual flow responses

Visual onsets were defined as the time the visual flow speed crossed a threshold of 0.8 cm/s. The membrane potential for each presentation was baseline subtracted by the average V <sub>m</sub> in the 1 s prior to visual flow onset. The response was then averaged in the 1 s window of visual flow across all trials, regardless of locomotion behavior. The significance of this response was determined for each neuron by performing a paired t test between the average V <sub>m</sub> 1 s before visual flow onset, and that in the 1 s during visual flow for all included trials. For the subset of neurons which were shown four different visual flow speeds, responses were averaged regardless of visual flow speed. To determine the effect of locomotion on visual flow responses ([Figures S4](#mmc1) A–S4D), visual flow presentations were separated according to locomotion speed: locomotion trials were defined as trials in which the average locomotion speed in the 1 s prior to and 1 s during visual flow both exceeded 4 cm/s. Stationary trials were defined as trials in which the locomotion speed in these two epochs both were less than 4 cm/s. For correlations between visual flow speed and visual response ([Figures 4](#fig4) F and 4G), only trials in which the mouse was locomoting above 4 cm/s were included, and the correlation coefficient between the visual flow speed and membrane potential response across trials was generated for each neuron.

#### Correlation between visual flow response and mismatch response

For the correlation between mismatch response and visual response across neurons ([Figure 4](#fig4) E), we first calculated the correlation between the mismatch response (as averaged across the 1 s of mismatch) versus the visual response (as averaged across the 1 s of visual response). To account for any response to visual flow offset, we computed the visual offset response as the average membrane potential response in the 1 s after visual flow offset, baseline subtracted using the average membrane potential in the 1 s prior to visual flow onset. This visual flow offset response was then subtracted from the mismatch response, and the correlation was calculated between the resulting values and the visual flow response.

#### Pupil movements

Mismatch induced eye movements were quantified in 20 mice not used in the whole cell recordings experiments ([Figure S1](#mmc1)). Eye position and pupil dimeter were recorded in response to visuomotor mismatches. We measured pupil diameter for all mismatch trials and z scored the data for each trial. For each mouse, these z scored data were then averaged to quantify the average mismatch induced pupil diameter response. This was repeated for sham trials using random triggers. We quantified mismatch induced eye movements by comparing the x and y pupil positions in the 1 s before to that in the 1 s during mismatch.

## Acknowledgments

We thank Rainer Friedrich, Mahesh Karnani, Jesse Jackson, Loreen Hertäg, and Andreas Keller for helpful comments on earlier versions of this manuscript; Andreas Lüthi for lending us research equipment; and all members of the Keller lab for discussion and support. This project received funding from the Swiss National Science Foundation (to G.B.K.), the Novartis Research Foundation (to G.B.K. and R.J.), the Human Frontier Science Program (LT000077/2019-L) (to R.J.), and the European Research Council (ERC) under the European Union’s Horizon 2020 research and innovation program (grant 865617) (to G.B.K.).

### Author Contributions

R.J. designed and performed the experiments and analyzed the data. R.J. and G.B.K. wrote the manuscript.

### Declaration of Interests

The authors declare no competing interests.

## Supplemental Information (2)

[PDF (1.37 MB)](https://www.cell.com/cms/10.1016/j.neuron.2020.09.024/attachment/b9dd34ab-001d-4432-8f9f-9d7efc43afed/mmc1.pdf)

Document S1. Figures S1–S7 and Table S1

[PDF (6.45 MB)](https://www.cell.com/cms/10.1016/j.neuron.2020.09.024/attachment/1699153e-ae81-48ef-bcf6-83574d7fbe28/mmc2.pdf)

Document S2. Article plus Supplemental Information

## References

[1.](#body-ref-sref1 "View in article")

Angelo, K. ∙ Rancz, E.A. ∙ Pimentel, D....

**A biophysical signature of network affiliation and sensory processing in mitral cells**

*Nature.* 2012; **488**:375-378

[2.](#body-ref-sref2-1 "View in article")

Attinger, A. ∙ Wang, B. ∙ Keller, G.B.

**Visuomotor Coupling Shapes the Functional Development of Mouse Visual Cortex**

*Cell.* 2017; **169**:1291-1302.e14

[3.](#body-ref-sref3 "View in article")

Ayaz, A. ∙ Stäuble, A. ∙ Hamada, M....

**Layer-specific integration of locomotion and sensory information in mouse barrel cortex**

*Nat. Commun.* 2019; **10**:2585

[4.](#body-ref-sref4-1 "View in article")

Bennett, C. ∙ Arroyo, S. ∙ Hestrin, S.

*Neuron.* 2013; **80**:350-357

[5.](#body-ref-sref5 "View in article")

Crapse, T.B. ∙ Sommer, M.A.

**Corollary discharge across the animal kingdom**

*Nat. Rev. Neurosci.* 2008; **9**:587-600

[6.](#body-ref-sref6 "View in article")

de Kock, C.P.J. ∙ Sakmann, B.

**Spiking in primary somatosensory cortex during natural whisking in awake head-restrained rats is cell-type specific**

*Proc. Natl. Acad. Sci. USA.* 2009; **106**:16446-16450

[7.](#body-ref-sref7 "View in article")

Desai, N.S. ∙ Rutherford, L.C. ∙ Turrigiano, G.G.

**Plasticity in the intrinsic excitability of cortical pyramidal neurons**

*Nat. Neurosci.* 1999; **2**:515-520

[8.](#body-ref-sref8 "View in article")

Engel, A.K. ∙ Fries, P. ∙ Singer, W.

**Dynamic predictions: oscillations and synchrony in top-down processing**

*Nat. Rev. Neurosci.* 2001; **2**:704-716

[9.](#body-ref-sref9-1 "View in article")

Fiser, A. ∙ Mahringer, D. ∙ Oyibo, H.K....

**Experience-dependent spatial expectations in mouse visual cortex**

*Nat. Neurosci.* 2016; **19**:1658-1664

[10.](#body-ref-sref10 "View in article")

Freeman, T.C.B. ∙ Durand, S. ∙ Kiper, D.C....

**Suppression without inhibition in visual cortex**

*Neuron.* 2002; **35**:759-771

[11.](#body-ref-sref11-1 "View in article")

Fu, Y. ∙ Tucciarone, J.M. ∙ Espinosa, J.S....

**A cortical circuit for gain control by behavioral state**

*Cell.* 2014; **156**:1139-1152

[12.](#body-ref-sref12-1 "View in article")

Gentet, L.J. ∙ Kremer, Y. ∙ Taniguchi, H....

**Unique functional properties of somatostatin-expressing GABAergic neurons in mouse barrel cortex**

*Nat. Neurosci.* 2012; **15**:607-612

[13.](#body-ref-sref13 "View in article")

Gilbert, C.D. ∙ Li, W.

**Top-down influences on visual processing**

*Nat. Rev. Neurosci.* 2013; **14**:350-363

[14.](#body-ref-sref14 "View in article")

Harris, K.D. ∙ Mrsic-Flogel, T.D.

**Cortical connectivity and sensory coding**

*Nature.* 2013; **503**:51-58

[15.](#body-ref-sref15 "View in article")

Hertäg, L. ∙ Sprekeler, H.

**Learning prediction error neurons in a canonical interneuron circuit**

*eLife.* 2020; **9**:e57541

[Crossref](https://doi.org/10.7554/eLife.57541)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/32820723/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.7554%2FeLife.57541&pmid=32820723)

[16.](#body-ref-sref16 "View in article")

Ibrahim, L.A. ∙ Mesik, L. ∙ Ji, X.-Y....

**Cross-Modality Sharpening of Visual Cortical Processing through Layer-1-Mediated Inhibition and Disinhibition**

*Neuron.* 2016; **89**:1031-1045

[17.](#body-ref-sref17 "View in article")

Iurilli, G. ∙ Ghezzi, D. ∙ Olcese, U....

**Sound-driven synaptic inhibition in primary visual cortex**

*Neuron.* 2012; **73**:814-828

[18.](#body-ref-sref18-1 "View in article")

Keller, G.B. ∙ Mrsic-Flogel, T.D.

**Predictive Processing: A Canonical Cortical Computation**

*Neuron.* 2018; **100**:424-435

[19.](#body-ref-sref19-1 "View in article")

Keller, G.B. ∙ Bonhoeffer, T. ∙ Hübener, M.

**Sensorimotor mismatch signals in primary visual cortex of the behaving mouse**

*Neuron.* 2012; **74**:809-815

[20.](#body-ref-sref20 "View in article")

Keller, A.J. ∙ Roth, M.M. ∙ Scanziani, M.

**Feedback generates a second receptive field in neurons of the visual cortex**

*Nature.* 2020; **582**:545-549

[21.](#body-ref-sref21 "View in article")

Lalazar, H. ∙ Vaadia, E.

**Neural basis of sensorimotor learning: modifying internal models**

*Curr. Opin. Neurobiol.* 2008; **18**:573-581

[22.](#body-ref-sref22 "View in article")

Larsen, R.S. ∙ Turschak, E. ∙ Daigle, T....

**Activation of neuromodulatory axon projections in primary visual cortex during periods of locomotion and pupil dilation**

*bioRxiv.* 2018;

[23.](#body-ref-sref23 "View in article")

Lefort, S. ∙ Tomm, C. ∙ Floyd Sarria, J.C....

**The excitatory neuronal network of the C2 barrel column in mouse primary somatosensory cortex**

*Neuron.* 2009; **61**:301-316

[24.](#body-ref-sref24-1 "View in article")

Leinweber, M. ∙ Zmarz, P. ∙ Buchmann, P....

**Two-photon calcium imaging in mice navigating a virtual reality environment**

*J. Vis. Exp.* 2014; **84**:e50885

[Google Scholar](https://scholar.google.com/scholar?q=M.LeinweberP.ZmarzP.BuchmannP.ArgastM.H%C3%BCbenerT.BonhoefferG.B.KellerTwo-photon+calcium+imaging+in+mice+navigating+a+virtual+reality+environmentJ.%C2%A0Vis.+Exp.842014e50885)

[25.](#body-ref-sref25-1 "View in article")

Leinweber, M. ∙ Ward, D.R. ∙ Sobczak, J.M....

**A Sensorimotor Circuit in Mouse Cortex for Visual Flow Predictions**

*Neuron.* 2017; **95**:1420-1432.e5

[26.](#body-ref-sref26 "View in article")

Makino, H. ∙ Hwang, E.J. ∙ Hedrick, N.G....

**Circuit Mechanisms of Sensorimotor Learning**

*Neuron.* 2016; **92**:705-721

[27.](#body-ref-sref27 "View in article")

Margrie, T.W. ∙ Brecht, M. ∙ Sakmann, B.

***In vivo*, low-resistance, whole-cell recordings from neurons in the anaesthetized and awake mammalian brain**

*Pflugers Arch.* 2002; **444**:491-498

[28.](#body-ref-sref28 "View in article")

Markram, H. ∙ Toledo-Rodriguez, M. ∙ Wang, Y....

**Interneurons of the neocortical inhibitory system**

*Nat. Rev. Neurosci.* 2004; **5**:793-807

[30.](#body-ref-sref31 "View in article")

Oh, S.W. ∙ Harris, J.A. ∙ Ng, L....

**A mesoscale connectome of the mouse brain**

*Nature.* 2014; **508**:207-214

[31.](#body-ref-sref32-1 "View in article")

Pala, A. ∙ Petersen, C.C.H.

***In vivo* measurement of cell-type-specific synaptic connectivity and synaptic transmission in layer 2/3 mouse barrel cortex**

*Neuron.* 2015; **85**:68-75

[32.](#body-ref-sref33-1 "View in article")

Polack, P.-O. ∙ Friedman, J. ∙ Golshani, P.

**Cellular mechanisms of brain state-dependent gain modulation in visual cortex**

*Nat. Neurosci.* 2013; **16**:1331-1339

[33.](#body-ref-sref34-1 "View in article")

Rao, R.P.N. ∙ Ballard, D.H.

**Predictive coding in the visual cortex: a functional interpretation of some extra-classical receptive-field effects**

*Nat. Neurosci.* 1999; **2**:79-87

[34.](#body-ref-sref36 "View in article")

Reimer, J. ∙ McGinley, M.J. ∙ Liu, Y....

**Pupil fluctuations track rapid changes in adrenergic and cholinergic activity in cortex**

*Nat. Commun.* 2016; **7**:13289

[35.](#body-ref-sref37 "View in article")

Sakata, S. ∙ Harris, K.D.

**Laminar structure of spontaneous and sensory-evoked population activity in auditory cortex**

*Neuron.* 2009; **64**:404-418

[36.](#body-ref-sref38-1 "View in article")

Saleem, A.B. ∙ Ayaz, A. ∙ Jeffery, K.J....

**Integration of visual motion and locomotion in mouse visual cortex**

*Nat. Neurosci.* 2013; **16**:1864-1869

[37.](#body-ref-sref39 "View in article")

Saleem, A.B. ∙ Diamanti, E.M. ∙ Fournier, J....

**Coherent encoding of subjective spatial position in visual cortex and hippocampus**

*Nature.* 2018; **562**:124-127

[38.](#body-ref-sref40 "View in article")

Schultz, W. ∙ Dayan, P. ∙ Montague, P.R.

**A neural substrate of prediction and reward**

*Science.* 1997; **275**:1593-1599

[39.](#body-ref-sref41 "View in article")

Spratling, M.W.

**Predictive coding as a model of biased competition in visual attention**

*Vision Res.* 2008; **48**:1391-1408

[40.](#body-ref-sref42 "View in article")

Spratling, M.W. ∙ De Meyer, K. ∙ Kompass, R.

**Unsupervised learning of overlapping image components using divisive input modulation**

*Comput. Intell. Neurosci.* 2009; **2009**:381457

[41.](#body-ref-sref43-1 "View in article")

Vélez-Fort, M. ∙ Bracey, E.F. ∙ Keshavarzi, S....

**A Circuit for Integration of Head- and Visual-Motion Signals in Layer 6 of Mouse Primary Visual Cortex**

*Neuron.* 2018; **98**:179-191.e6

[42.](#body-ref-sref44 "View in article")

Yoshida, T. ∙ Ohki, K.

**Natural images are reliably represented by sparse and variable populations of neurons in visual cortex**

*Nat. Commun.* 2020; **11**:872

[43.](#body-ref-sref45-1 "View in article")

Zhang, S. ∙ Xu, M. ∙ Kamigaki, T....

**Selective attention. Long-range and local circuits for top-down modulation of visual cortex processing**

*Science.* 2014; **345**:660-665

[44.](#body-ref-sref46 "View in article")

Zhang, S. ∙ Xu, M. ∙ Chang, W.C....

**Organization of long-range inputs and outputs of frontal cortex for top-down control**

*Nat. Neurosci.* 2016; **19**:1733-1742

[45.](#body-ref-sref47-1 "View in article")

Zmarz, P. ∙ Keller, G.B.

**Mismatch Receptive Fields in Mouse Visual Cortex**

*Neuron.* 2016; **92**:766-772