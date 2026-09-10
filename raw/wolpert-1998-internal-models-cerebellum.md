---
title: "Internal models in the cerebellum"
source: "https://www.cell.com/trends/cognitive-sciences/fulltext/S1364-6613(98)01221-2"
author:
  - "[[Daniel M Wolpert]]"
  - "[[R.Chris Miall]]"
  - "[[Mitsuo Kawato]]"
published:
created: 2026-09-10
description: "This review will focus on the possibility that the cerebellum contains an internalmodel or models of the motor apparatus. Inverse internal models can provide the neuralcommand necessary to achieve some desired trajectory. First, we review the necessityof such a model and the evidence, based on the ocular following response, that inversemodels are found within the cerebellar circuitry. Forward internal models predictthe consequences of actions and can be used to overcome time delays associated withfeedback control."
tags:
  - "clippings"
---
## Abstract

This review will focus on the possibility that the cerebellum contains an internal model or models of the motor apparatus. Inverse internal models can provide the neural command necessary to achieve some desired trajectory. First, we review the necessity of such a model and the evidence, based on the ocular following response, that inverse models are found within the cerebellar circuitry. Forward internal models predict the consequences of actions and can be used to overcome time delays associated with feedback control. Secondly, we review the evidence that the cerebellum generates predictions using such a forward model. Finally, we review a computational model that includes multiple paired forward and inverse models and show how such an arrangement can be advantageous for motor learning and control.

Sign in to unlock the full response and ask your own questions.

[Sign in](https://www.cell.com/action/idLogin?type=login&redirectUri=https%3A%2F%2Fwww.cell.com%2Ftrends%2Fcognitive-sciences%2Ffulltext%2FS1364-6613%2898%2901221-2&pii=S1364661398012212)

### Actions you could take:

- Summarize this article

The cerebellum has attracted the attention of theorists and modelers for many years

1.

Marr, D

**A theory of cerebellar cortex**

*J. Physiol.* 1969; **202**:437-470

2.

Albus, J.S

**A theory of cerebellar function**

*Math. Biosci.* 1971; **10**:25-61

3.

Ito, M. (1984) *The Cerebellum and Neural Control*, Raven Press

[Google Scholar](https://scholar.google.com/scholar?q=Ito%2C+M.+%281984%29+The+Cerebellum+and+Neural+Control%2C+Raven+Press)

. The attraction is that the cerebellar cortex is both quite simple and well documented. It has only one output cell, the inhibitory Purkinje cell (P-cell), and four main classes of interneuron; it is also extremely regular in its cytoarchitecture. Hence, most people believe that there is a common computational operation performed by all cerebellar areas, although processing specific inputs and sending outputs to different extracerebellar targets. However, knowledge of the anatomical and cerebellar circuitry has outstripped our understanding of the function or functions that the cerebellum performs. In this paper, we will review models that are aimed at understanding the cerebellum's possible role in motor learning and control at the functional level.

The approaches we will review are intimately linked to the notion that the cerebellum contains an internal model or models of the motor apparatus. There are two varieties of internal model, forward and inverse models

4.

Kawato, M ∙ Furawaka, K ∙ Suzuki, R

**A hierarchical neural network model for the control and learning of voluntary movements**

*Biol. Cybern.* 1987; **56**:1-17

5.

Jordan, M.I ∙ Rumelhart, D.E

**Forward models: supervised learning with a distal teacher**

*Cognit. Sci.* 1992; **16**:307-354

[Crossref](https://doi.org/10.1207/s15516709cog1603_1)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1207%2Fs15516709cog1603_1)

. Forward models capture the forward or causal relationship between inputs to the system, such as the arm, and the outputs. A forward dynamic model of the arm, for example, predicts the next state (e.g. position and velocity) given the current state and the motor command. In contrast, inverse models invert the system by providing the motor command that will cause a desired change in state. They are, therefore, well suited to act as controllers as they can provide the motor command necessary to achieve some desired state transition.

In the first two sections, we will review the evidence that the cerebellum instantiates an inverse and a forward model, respectively. We show how these models can solve a specific part of the motor control problem, that of converting a desired trajectory of the arm or eye into appropriate motor commands. The final section will consider the benefits of using multiple and paired forward and inverse models in motor learning and control.

## 1 The cerebellum as an inverse model

Fast and coordinated arm movements cannot be executed under pure feedback control because biological feedback loops are both too slow and have small gains. Two major feedforward control schemes have been proposed: the equilibrium-point control hypothesis

6.

Feldman, A.G

**Functional tuning of the nervous system with control of movement or maintenance of a steady posture: III. Mechanographic analysis of execution by arm of the simplest motor tasks**

*Biophysics.* 1966; **11**:766-775

[Google Scholar](https://scholar.google.com/scholar?q=A.GFeldmanFunctional+tuning+of+the+nervous+system+with+control+of+movement+or+maintenance+of+a+steady+posture%3A+III.+Mechanographic+analysis+of+execution+by+arm+of+the+simplest+motor+tasksBiophysics111966766775)

7.

Bizzi, E...

**Posture control and trajectory formation during arm movement**

*J. Neurosci.* 1984; **4**:2738-2744

[PubMed](https://pubmed.ncbi.nlm.nih.gov/6502202/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=6502202)

8.

Hogan, N

**An organizing principle for a class of voluntary movements**

*J. Neurosci.* 1984; **4**:2745-2754

[PubMed](https://pubmed.ncbi.nlm.nih.gov/6502203/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=6502203)

9.

Flash, T

**The control of hand equilibrium trajectories in multi-joint arm movements**

*Biol. Cybern.* 1987; **57**:257-274

and the inverse dynamics model hypothesis

4.

Kawato, M ∙ Furawaka, K ∙ Suzuki, R

**A hierarchical neural network model for the control and learning of voluntary movements**

*Biol. Cybern.* 1987; **56**:1-17

. Some versions of the former scheme advocate that the central nervous system (CNS) can avoid complicated computations by relying on the spring-like properties of muscles and reflex loops. For this mechanism to work efficiently, the mechanical and neural feedback gains, which can be measured in the arm as the mechanical stiffness in perturbation experiments, must be quite high. Alternatively, the inverse dynamics model hypothesis proposes that during motor learning the CNS acquires an inverse dynamics model of the controlled object. Using such an inverse model the arm can be controlled with quite low mechanical stiffness. Using a novel mechanical device (PFM: Parallel link direct drive air and magnet Floating Manipulandum), the stiffness of the arm was recently measured during visually guided point to point multi-joint movements

10.

Gomi, H ∙ Kawato, M

**Equilibrium-point control hypothesis examined by measured arm stiffness during multijoint movement**

*Science.* 1996; **272**:117-120

. The finding of a low stiffness suggests that an inverse dynamic model is necessary in these well-practised and relaxed movements.

Acquiring an inverse dynamics model through motor learning is generally a difficult task because the error in the model's output, the motor command error, which could provide a training signal is not directly available to the CNS. If the motor command error was known, there would be no need to learn the inverse dynamics as the correct control signal would already be known. Instead movement errors are initially represented in sensory coordinates, and these sensory errors need to be converted into motor errors before they can be used to train an inverse model. For example, for arm movement the error may be specified visually or through proprioception or cutaneous signals, and these errors would need to be converted into errors in the activation of the muscles. Similarly, in speech the error might be an acoustic error which would need to be transformed into errors in speech articulator muscle activations. Kawato and colleagues

4.

Kawato, M ∙ Furawaka, K ∙ Suzuki, R

**A hierarchical neural network model for the control and learning of voluntary movements**

*Biol. Cybern.* 1987; **56**:1-17

11.

Kawato, M ∙ Gomi, H

**The cerebellum and VOR/OKR learning models**

*Trends Neurosci.* 1992; **15**:445-453

have proposed a cerebellar feedback-error-learning model (CBFELM) to resolve this problem. [Fig. 1](#FIG1) A shows the block diagram and [Fig. 1](#FIG1) B shows the corresponding cerebellar neural circuit. The feedback controller transforms the trajectory error, in sensory coordinates, into a feedback motor command, which is then used to train the inverse model. This training signal therefore represents the sensory error converted into motor command coordinates. The sum of the feedforward and feedback motor commands then acts on the controlled object. In the cerebellar circuit, simple spikes (SS) represent feedforward motor commands, and the parallel fiber inputs represent the desired trajectory as well as the sensory feedback of the current state of the controlled object. A microzone of the cerebellar cortex constitutes (a part of: see below) an inverse model of a specific controlled object such as the eye or arm. Most importantly, climbing fiber inputs are assumed to carry a copy of the feedback motor commands generated by a crude feedback control circuit. Thus, the complex spikes (CS) of P-cells activated by climbing fiber inputs are predicted to be sensory error signals already expressed in motor command coordinates.

![](https://www.cell.com/cms/10.1016/S1364-6613(98)01221-2/asset/db42a3af-d6da-48b6-8263-e65457ead86e/main.assets/gr1.jpg)

Fig. 1 The cerebellar feedback-error-learning model (CBFELM). (A) The general feedback-error-learning model. (B) The cerebellar feedback-error-learning model. The \`controlled object' is a physical entity that needs to be controlled by the central nervous system (CNS), such as the eyes, hands, legs or torso. The controlled object can be considered as a cascade of transformations between motor command (e.g. joint torques or muscle activations) and linkage motion (e.g. joint angular position, velocity and acceleration), and between this linkage motion and the controlled object motion (e.g. spatial position, velocity and acceleration of the hand). Such transformations represent the system dynamics and kinematics, respectively. By \`inverse model', we mean a neural representation of the transformation from the desired movement trajectory of the controlled object to the motor commands required to attain this movement goal. Because the inverse model possesses input–output transfer characteristics that are the inverse of those of the controlled object, the cascade of the two systems gives an approximate identity function. That is, if a desired trajectory is given to the inverse model, then at the end of the cascade the actual trajectory will be fairly close to the desired trajectory. Thus, accurate inverse models can be used as ideal feedforward controllers. An example of the trajectory error is retinal slip for the vestibulo–ocular reflex (VOR) and occular-following responses (OFR). In engineering, a proportional-integral-derivative controller is often used as a feedback controller. The component of the final motor command that is generated by a feedback controller is called the feedback motor command.

The cerebellar feedback-error-learning model is directly supported by neurophysiological studies in the ventral paraflocculus (VPFL) of monkey cerebellum during ocular-following responses (OFR)

12.

Kobayashi, Y. *et al*. Temporal firing patterns of Purkinje cells in the cerebellar ventral paraflocculus during ocular following responses in monkeys. II. Complex spikes *J. Neurophysiol*. (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Kobayashi%2C+Y.+et+al.+Temporal+firing+patterns+of+Purkinje+cells+in+the+cerebellar+ventral+paraflocculus+during+ocular+following+responses+in+monkeys.+II.+Complex+spikes+J.+Neurophysiol.+%28in+press%29)

13.

Shidara, M...

**Inverse-dynamics encoding of eye movement by Purkinje cells in the cerebellum**

*Nature.* 1993; **365**:50-52

14.

Gomi, H. *et al*. Temporal firing patterns of Purkinje cells in the cerebellar ventral paraflocculus during ocular following responses in monkeys: I. Simple spikes. *J. Neurophysiol*. (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Gomi%2C+H.+et+al.+Temporal+firing+patterns+of+Purkinje+cells+in+the+cerebellar+ventral+paraflocculus+during+ocular+following+responses+in+monkeys%3A+I.+Simple+spikes.+J.+Neurophysiol.+%28in+press%29)

. OFR are tracking movements of the eyes evoked by movements of a visual scene and are thought to be important for the visual stabilization of gaze. [Fig. 2](#FIG2) illustrates the neural networks involved in OFR control and is drawn intentionally to correspond to [Fig. 1](#FIG1) B of CBFELM. The phylogenetically older crude feedback circuit of CBFELM comprises the retina, the accessory optic system (AOS) and the brain stem in [Fig. 2](#FIG2). The phylogenetically newer, more sophisticated feedforward/feedback pathway and the inverse dynamics model of CBFELM correspond to the cerebral/cerebellar cortical pathway and the cerebellar cortex of [Fig. 2](#FIG2), respectively.

![](https://www.cell.com/cms/10.1016/S1364-6613(98)01221-2/asset/f7035439-69dc-4335-88f7-c033d423593f/main.assets/gr2.jpg)

Fig. 2 Summary of the neural networks involved in controlling the occular-following responses (OFR) (A). Insets show the preferred directions of neurons in different brain regions in response to large visual stimulus motion, which induces OFR. The data of preferred directions of neurons recorded from dorsolateral pontine nucleus (DLPN), medial superior temporal area (MST), pretectum (PT) and nucleus of optic tract (NOT) neurons were reproduced, with permission, from Refs 28. Kawano, K... J. Neurophysiol. 1994; 71:2305-2324 PubMed Google Scholar 72. Kawano, K. et al. (1996) Visual inputs to cerebellar paraflocculus during ocular following responses, in Extrageniculostriate Mechanisms Underlying Visually-guided Orientation Behavior (Progress in Brain Research, Vol. 112) (Norita, M., Bando, T. and Stein, B., eds), pp. 415–422, Elsevier 73. Kawano, K ∙ Shidara, M ∙ Yamane, S 1992; 67:680-703. The pairwise preferred directions of the simple spikes (SS; green line) and the complex spikes (CS; red line) of individual Purkinje cells were reproduced from Ref. 12. Kobayashi, Y.. Temporal firing patterns of Purkinje cells in the cerebellar ventral paraflocculus during ocular following responses in monkeys. II. Complex spikes J. Neurophysiol. (in press). The temporal waveforms (B) are average firing rates (black) of SS (top) and CS (bottom), and their firing-probability reconstructions by the inverse dynamics model of the eye movement (green and red). The time course of SS and CS firing rates (black) was accumulated from nine vertical cells over many trials, aligned with the onset of stimulus motion (time 0). Abbreviations: AOS, accessory optic system; MT, middle temporal area; LGN, lateral geniculate nucleus; EOMN: extra ocular motor neurons. (Modified from Ref..)

As shown in the inset of [Fig. 2](#FIG2), during OFR, the temporal waveforms of SS firing frequency of VPFL P-cells show complicated patterns. However, they (black waveform) were quite accurately reconstructed by using an inverse-dynamics representation of the eye movement (green waveform), that is a linear combination of eye acceleration, velocity and position measured 10ms (the conduction delay) after the SS (Refs ). The model fit was good for the majority of the neurons studied under a wide range of visual stimulus conditions. The velocity/acceleration coefficient ratio of the SS was close to that of motoneurons. This indicates that VPFL P-cells properly encode the dynamic components of the motor command during OFR.

The same inverse dynamics analysis of firing frequency was applied to neurons in the medial superior temporal area (MST) and dorsolateral pontine nucleus (DLPN), which provide visual mossy fiber inputs to the VPFL ([Fig. 2](#FIG2)). In this area, neural firing patterns were not well reconstructed and, even in the case of a good fit, the velocity/acceleration coefficient ratio was smaller than those of the SS and motor neurons

15.

Takemura, A. *et al*. (1994) A linear regression time-series analysis of neural activity during ocular following, in The 9th Symposium on Biological and Physiological Engineering, pp. 275–278, Society of Instrumental and Control Engineers of Japan

[Google Scholar](https://scholar.google.com/scholar?q=Takemura%2C+A.+et+al.+%281994%29+A+linear+regression+time-series+analysis+of+neural+activity+during+ocular+following%2C+in+The+9th+Symposium+on+Biological+and+Physiological+Engineering%2C+pp.+275%E2%80%93278%2C+Society+of+Instrumental+and+Control+Engineers+of+Japan)

. This suggests that the parallel fiber inputs most probably provide the desired trajectory information, while the SS outputs provide the dynamic part of the necessary motor command. Taken together, these data suggest that the VPFL is the major site of the inverse dynamics model of the eye for OFR.

The CBFELM assumes that motor commands, which are conveyed by SS, are directly modified and acquired through synaptic plasticity by motor-command errors, which are conveyed by climbing fiber inputs. For this to work, the motor commands and climbing fiber inputs must have comparable temporal and spatial characteristics, but the extremely low discharge rates of the climbing fibers (1–2 spikes/second) would appear to rule this out. However, as shown in the inset of [Fig. 2](#FIG2), the firing probability of climbing fiber inputs (red) aligned with the stimulus motion onset was found to have high-frequency temporal dynamics matching those of the dynamic command signals (green)

12.

Kobayashi, Y. *et al*. Temporal firing patterns of Purkinje cells in the cerebellar ventral paraflocculus during ocular following responses in monkeys. II. Complex spikes *J. Neurophysiol*. (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Kobayashi%2C+Y.+et+al.+Temporal+firing+patterns+of+Purkinje+cells+in+the+cerebellar+ventral+paraflocculus+during+ocular+following+responses+in+monkeys.+II.+Complex+spikes+J.+Neurophysiol.+%28in+press%29)

. In this study, firing probability rather than firing frequency of CS and SS was reconstructed from a generalized linear model

16.

Kawato, M. (1995) Analysis of neural firing frequency by a generalized linear model *Tech. Rep. IEICE* NC95-33, pp. 31–38

[Google Scholar](https://scholar.google.com/scholar?q=Kawato%2C+M.+%281995%29+Analysis+of+neural+firing+frequency+by+a+generalized+linear+model+Tech.+Rep.+IEICE+NC95-33%2C+pp.+31%E2%80%9338)

based on a binomial distribution of the spike count. As shown in the inset of [Fig. 2](#FIG2), the spatial coordinates of CS (horizontal and vertical axes) were aligned with those of SS, although the preferred directions were 180° opposite. The speed-tuning properties of CS and SS were more linear for eye movement than retinal slip velocity, indicating that CS contains a motor component in addition to the sensory component identified in previous studies. Although the temporal patterns of the CS firing probabilities were similar to those of the SS when the sign was reversed (although the probability of climbing fibre firing was overall about 50-times lower than for SS owing to their extremely low firing frequency), the ratio of velocity and acceleration coefficients used to fit the eye movement data was less for the CS than that of the SS and was similar to MST and DLPN, suggesting that CS are more sensory in nature than SS and carry retinal slip signals in their waveforms.

On a cell-by-cell basis, the CS and SS temporal firing patterns have negative correlations with regard to their preferred directions for visual stimulus motion, their average modulation depths and their temporal firing patterns. A cross-correlation analysis of SS with CS revealed that short-term modulation (the brief pause in SS caused by CS) accounts for neither the reciprocal modulation of SS and CS nor these negative correlations; thus, long-term effects are involved. Overall, these findings support the most critical assumptions of CBFELM as follows. First, reconstruction analysis showed that climbing fiber signals carry high-frequency information that can be read out by P-cells using the long-term synaptic plasticity as a temporal averaging mechanism triggered by the stimulus motion onset, which is detected by parallel fiber inputs. Secondly, climbing fiber inputs carry sensory error signals already represented in the motor command coordinates, because their spatial axes are those of muscles, yet they represent retinal slips in their waveforms. Finally, because the cell-by-cell CS and SS negative correlations cannot be explained by short-term effect, innate anatomical connections or general cell properties, SS waveform of each cell seems to be acquired by long-term synaptic change controlled by the CS waveform.

Examination of the preferred directions of MST and DLPN neurons showed that they were evenly distributed over 360°. Thus, the visual coordinates for OFR are uniformly distributed over all possible directions. In distinction, the extraocular muscles act in either a horizontal or vertical direction. Preferred directions of P-cell SS were either downward or ipsilateral, and at the site of each recording, electrical stimulation of a P-cell elicited eye movement toward the preferred direction of the SS of that P-cell

17.

Shidara, M ∙ Kawano, K

*Exp. Brain Res.* 1993; **93**:185-195

. These data indicate that the SS coordinate framework is already in that of the motor commands. Thus, at the parallel fiber-P-cell synapse, a drastic visuomotor coordinate transformation occurs. So, what is the origin of this sensory-motor transformation (in other words, the inverse kinematics and dynamics model)? The CBFELM proposes that the CS and, eventually, the AOS are the source of this motor command spatial framework. The preferred directions of pretectum (PT) neurons are upward, and those of nucleus of optic tract (NOT) neurons are contralateral, and they are propagated to the inferior olive neurons and the CS of P-cells. If the parallel fiber-P-cell synapse is potentiated (long-term potentiation) by the low CS firing rates, and depressed (long-term depression) by the high CS firing rates, respectively, it is easy to demonstrate that the CS preferred directions determine the opposite preferred directions of the SS on a cell-by-cell basis

18.

Yamamoto, K. *et al*. (1998) A computational simulation on the adaptation of vertical ocular following responses. *Tech. Rep. IEICE* NC97-131, pp. 229–236

[Google Scholar](https://scholar.google.com/scholar?q=Yamamoto%2C+K.+et+al.+%281998%29+A+computational+simulation+on+the+adaptation+of+vertical+ocular+following+responses.+Tech.+Rep.+IEICE+NC97-131%2C+pp.+229%E2%80%93236)

.

The control of goal-directed arm movements can be conceptually partitioned into the following three computational problems: trajectory planning, coordinate transformation and the calculation of motor commands. The inverse kinematics model and the inverse dynamics model provide efficient computational mechanisms to solve the latter two problems, respectively. Internal inverse models are also essential for trajectory planning if the planning takes into account the dynamics and kinematics of motor apparatus

19.

Kawato, M. (1996) Trajectory formation in arm movements: minimization principles and procedures, in *Advances in Motor Learning and Control* (Zelaznik, H.N., ed.), pp. 225–259, Human Kinetics Publishers

[Google Scholar](https://scholar.google.com/scholar?q=Kawato%2C+M.+%281996%29+Trajectory+formation+in+arm+movements%3A+minimization+principles+and+procedures%2C+in+Advances+in+Motor+Learning+and+Control+%28Zelaznik%2C+H.N.%2C+ed.%29%2C+pp.+225%E2%80%93259%2C+Human+Kinetics+Publishers)

. Houk and colleagues

20.

Houk, J.C. and Barto, A.G. (1991) Distributed sensorimotor learning, in *Tutorial in Motor Behavior II* (Stelmach, G.E. and Requin, J., eds), pp. 71–100, Elsevier

[Google Scholar](https://scholar.google.com/scholar?q=Houk%2C+J.C.+and+Barto%2C+A.G.+%281991%29+Distributed+sensorimotor+learning%2C+in+Tutorial+in+Motor+Behavior+II+%28Stelmach%2C+G.E.+and+Requin%2C+J.%2C+eds%29%2C+pp.+71%E2%80%93100%2C+Elsevier)

21.

Houk, J.C ∙ Buckingham, J.T ∙ Barto, A.G

**Models of the cerebellum and motor learning**

*Behav. Brain Sci.* 1996; **19**:363-383

[Google Scholar](https://scholar.google.com/scholar?q=J.CHoukJ.TBuckinghamA.GBartoModels+of+the+cerebellum+and+motor+learningBehav.+Brain+Sci.191996363383)

proposed a series of interesting computational models of the cerebellum that solve the trajectory planning problem as well as the other two problems based on the known cerebellar reverberating circuits

22.

Tsukahara, N...

**Properties of cerebello–precerebellar reverberating circuits**

*Brain Res.* 1983; **274**:249-259

and Boylls' model

23.

Boylls, C.C. (1975) A theory of cerebellar function with applications to locomotion: I. The physiological role of climbing fiber inputs in anterior lobe operation. COINS Technical Report, Computer and Information Science University of Massachusetts

[Google Scholar](https://scholar.google.com/scholar?q=Boylls%2C+C.C.+%281975%29+A+theory+of+cerebellar+function+with+applications+to+locomotion%3A+I.+The+physiological+role+of+climbing+fiber+inputs+in+anterior+lobe+operation.+COINS+Technical+Report%2C+Computer+and+Information+Science+University+of+Massachusetts)

. For eye movements such as the OFR or vestibulo–ocular reflex (VOR), the sensory system (visual and vestibular) provides the cerebellum with the desired trajectory information. Thus, the cerebellum does not need to plan the trajectory. For limb movements such as visually guided arm reaching movements, it is unknown whether the cerebellum receives desired trajectory information or whether the desired trajectory is generated within the cerebellum, as proposed by Houk and colleagues

19.

Kawato, M. (1996) Trajectory formation in arm movements: minimization principles and procedures, in *Advances in Motor Learning and Control* (Zelaznik, H.N., ed.), pp. 225–259, Human Kinetics Publishers

[Google Scholar](https://scholar.google.com/scholar?q=Kawato%2C+M.+%281996%29+Trajectory+formation+in+arm+movements%3A+minimization+principles+and+procedures%2C+in+Advances+in+Motor+Learning+and+Control+%28Zelaznik%2C+H.N.%2C+ed.%29%2C+pp.+225%E2%80%93259%2C+Human+Kinetics+Publishers)

20.

Houk, J.C. and Barto, A.G. (1991) Distributed sensorimotor learning, in *Tutorial in Motor Behavior II* (Stelmach, G.E. and Requin, J., eds), pp. 71–100, Elsevier

[Google Scholar](https://scholar.google.com/scholar?q=Houk%2C+J.C.+and+Barto%2C+A.G.+%281991%29+Distributed+sensorimotor+learning%2C+in+Tutorial+in+Motor+Behavior+II+%28Stelmach%2C+G.E.+and+Requin%2C+J.%2C+eds%29%2C+pp.+71%E2%80%93100%2C+Elsevier)

21.

Houk, J.C ∙ Buckingham, J.T ∙ Barto, A.G

**Models of the cerebellum and motor learning**

*Behav. Brain Sci.* 1996; **19**:363-383

[Google Scholar](https://scholar.google.com/scholar?q=J.CHoukJ.TBuckinghamA.GBartoModels+of+the+cerebellum+and+motor+learningBehav.+Brain+Sci.191996363383)

.

This issue of whether the cerebellum is involved in trajectory planning based on positive feedback loops via the P-cells is also central to the controversy over whether the long-term synaptic plasticity in the cerebellar cortex is the main memory mechanism of adaptation of several types of movements, including VOR (Refs

24.

Ito, M

**Cerebellar learning in vestibulo–ocular reflex**

*Trends Cognit. Sci.* 1998; **2**:313-321

25.

DeZeeuw, C...

**Expression of a protein kinase-C inhibitor in Purkinje cells block cerebellar LTD and adaptation of the vestibulo–ocular reflex**

*Neuron.* 1998; **20**:495-508

26.

Raymond, J.L ∙ Lisberger, S.G ∙ Mauk, M.D

**The cerebellum: a neuronal learning machine?**

*Science.* 1996; **272**:1126-1131

). In Lisberger's model of VOR and smooth pursuit, which is computationally related to Houk and Barto's more abstract model, the eye velocity feedback loop back to P-cells is essential for maintaining smooth pursuit with no retinal slip

27.

Lisberger, S.G

**Neural basis for motor learning in the vestibuloocular reflex of primates: III. Computational and behavioral analysis of the sites of learning**

*J. Neurophysiol.* 1994; **72**:974-998

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7983549/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=7983549)

. However, for P-cells in the VPFL, which is the major cerebellar locus of smooth pursuit control, the SS firing rate correlated well with the future eye velocity, as predicted by the inverse dynamics model, but did not correlate with the past eye velocity, as predicted by the eye velocity feedback theory

14.

Gomi, H. *et al*. Temporal firing patterns of Purkinje cells in the cerebellar ventral paraflocculus during ocular following responses in monkeys: I. Simple spikes. *J. Neurophysiol*. (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Gomi%2C+H.+et+al.+Temporal+firing+patterns+of+Purkinje+cells+in+the+cerebellar+ventral+paraflocculus+during+ocular+following+responses+in+monkeys%3A+I.+Simple+spikes.+J.+Neurophysiol.+%28in+press%29)

. Furthermore, when the target was blanked in the OFR, the activity of MST (Ref.

28.

Kawano, K...

*J. Neurophysiol.* 1994; **71**:2305-2324

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7931519/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=7931519)

), DLPN (Ref.

73.

Kawano, K ∙ Shidara, M ∙ Yamane, S

*J. Neurophysiol.* 1992; **67**:680-703

[PubMed](https://pubmed.ncbi.nlm.nih.gov/1578251/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=1578251)

) and VPFL (Ref.

14.

Gomi, H. *et al*. Temporal firing patterns of Purkinje cells in the cerebellar ventral paraflocculus during ocular following responses in monkeys: I. Simple spikes. *J. Neurophysiol*. (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Gomi%2C+H.+et+al.+Temporal+firing+patterns+of+Purkinje+cells+in+the+cerebellar+ventral+paraflocculus+during+ocular+following+responses+in+monkeys%3A+I.+Simple+spikes.+J.+Neurophysiol.+%28in+press%29)

) suddenly dropped, along with the eye movement, which is against a significant contribution of the eye velocity feedback to P-cells. If eye velocity feedback to P-cells is not significant, many of the physiological criticisms

27.

Lisberger, S.G

**Neural basis for motor learning in the vestibuloocular reflex of primates: III. Computational and behavioral analysis of the sites of learning**

*J. Neurophysiol.* 1994; **72**:974-998

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7983549/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=7983549)

against Ito's flocculus hypothesis for VOR adaptation no longer hold. We believe that the resolution of the controversy is possible only by combining quantitative computational models and rigorous testing of their predictions by electrophysiological experiments.

Although direct and rigorous support for the CBFELM described above was limited to a small portion of the cerebellum and for a specific type of eye movement, because the neural circuit of different parts of the cerebellum is uniform and long-term depression is ubiquitous, we believe that the computational principle and neural architecture proven are universal for all parts of the cerebellum. Recent physiological and brain imaging experiments provided further support to CBFELM for visually guided arm reaching movements

29.

Kitazawa, S ∙ Kimura, T ∙ Yin, P

**Cerebellar complex spikes encode both destinations and errors in arm movements**

*Nature.* 1998; **392**:494-497

and learning of a new tool

30.

Imamizu, H...

**Separated modules for visuomotor control and learning in the cerebellum: a functional MRI study**

*NeuroImage.* 1997; **5**:S598

[Google Scholar](https://scholar.google.com/scholar?q=HImamizuSeparated+modules+for+visuomotor+control+and+learning+in+the+cerebellum%3A+a+functional+MRI+studyNeuroImage51997S598)

. It might be worthwhile to note that the CBFELM predicts that the CS activity remains even after sufficient learning for feedback control (intuitively because visual motion cannot be predicted beforehand in OFR), and even for feedforward movement, the initial burst of CS remains at the onset of movement because of the time difference between the desired trajectory and feedback of the actual trajectory

31.

Schweighofer, N...

**Role of the cerebellum in reaching quickly and accurately: II. A detailed model of the intermediate cerebellum**

*Eur. J. Neurosci.* 1998; **10**:95-105

, which was supported experimentally

29.

Kitazawa, S ∙ Kimura, T ∙ Yin, P

**Cerebellar complex spikes encode both destinations and errors in arm movements**

*Nature.* 1998; **392**:494-497

. We also note that CBFELM (Refs

4.

Kawato, M ∙ Furawaka, K ∙ Suzuki, R

**A hierarchical neural network model for the control and learning of voluntary movements**

*Biol. Cybern.* 1987; **56**:1-17

11.

Kawato, M ∙ Gomi, H

**The cerebellum and VOR/OKR learning models**

*Trends Neurosci.* 1992; **15**:445-453

) proposes that a microzone of the cerebellum, together with other feedforward control circuits in the brain, constitutes the inverse model (side-loop model) as in VOR and arm reaching

31.

Schweighofer, N...

**Role of the cerebellum in reaching quickly and accurately: II. A detailed model of the intermediate cerebellum**

*Eur. J. Neurosci.* 1998; **10**:95-105

.

## 2 The cerebellum as a forward model

An alternative hypothesis for the cerebellum, proposed under a variety of forms

32.

Ito, M

**Neurophysiological aspects of the cerebellar motor control system**

*Int. J. Neurol.* 1970; **7**:162-176

[PubMed](https://pubmed.ncbi.nlm.nih.gov/5499516/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=5499516)

33.

Miall, R.C

**Internal representation of human arm movements in visually guided tracking**

*J. Physiol.* 1989; **420**:61P

[Google Scholar](https://scholar.google.com/scholar?q=R.CMiallInternal+representation+of+human+arm+movements+in+visually+guided+trackingJ.+Physiol.420198961P)

34.

Miall, R.C...

**Is the cerebellum a Smith Predictor?**

*J. Motor Behav.* 1993; **25**:203-216

35.

Paulin, M.G. (1989) A Kalman-filter theory of the cerebellum, in *Dynamic Interactions in Neural Networks: Models and Data* (Arbib, M.A. and Amari, S., eds), pp. 241–259, Springer-Verlag

[Google Scholar](https://scholar.google.com/scholar?q=Paulin%2C+M.G.+%281989%29+A+Kalman-filter+theory+of+the+cerebellum%2C+in+Dynamic+Interactions+in+Neural+Networks%3A+Models+and+Data+%28Arbib%2C+M.A.+and+Amari%2C+S.%2C+eds%29%2C+pp.+241%E2%80%93259%2C+Springer-Verlag)

, suggests that the cerebellum generates a forward, causal representation of the motor apparatus, often known as a forward model

5.

Jordan, M.I ∙ Rumelhart, D.E

**Forward models: supervised learning with a distal teacher**

*Cognit. Sci.* 1992; **16**:307-354

[Crossref](https://doi.org/10.1207/s15516709cog1603_1)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1207%2Fs15516709cog1603_1)

36.

Wolpert, D.M ∙ Ghahramani, Z ∙ Jordan, M.I

**An internal model for sensorimotor integration**

*Science.* 1995; **269**:1880-1882

37.

Wolpert, D.M

**Computational approaches to motor control**

*Trends Cognit. Sci.* 1997; **1**:209-216

. A forward model represents the normal behavior of the motor system in response to outgoing motor commands. Hence, a forward model of the arm's dynamics has, as inputs, the current state of the arm and an efferent copy of motor commands being issued by a controller, and produces as output an estimate of the new state of the arm. This model therefore captures the state changes in the arm in response to the motor outflow, which are not directly available to the CNS. One can also define a forward \`sensory output' model of the arm that predicts the sensory reafferent signals (from sensory ending in the muscles, joints and skin) that are consequent on a particular change in state (joint angles and velocities). By linking a forward dynamic and forward sensory output model in series, an estimate of the sensory consequences of a motor command can be achieved ([Fig. 3](#FIG3)).

![](https://www.cell.com/cms/10.1016/S1364-6613(98)01221-2/asset/944a7669-b0d9-4cac-b83d-2e624824b0b1/main.assets/gr3.jpg)

Fig. 3 The Smith-Predictor model. The outer loop of this figure indicates a negative feedback control loop in which a motor controller (motor cortex) evokes motor commands to act on the motor system, causing reafferent sensory inputs. A forward dynamic model (proposed to be in the lateral cerebellum, light blue box) generates an internal state estimate within the internal cerebro-cerebellar feedback loop, indicated by the circular arrow. Physiological sensory-motor systems have significant feedback delays, so in a Smith-Predictor system 34. Miall, R.C... Is the cerebellum a Smith Predictor? J. Motor Behav. 1993; 25:203-216 there is an additional internal model of these delays (the forward output model). Errors between the predicted output of the cerebellar \`observer' (the forward model and forward output model) and the real feedback are used to correct movement and also maintain the accuracy of the observer models.

Why is there any need for such a system of forward models, as they apparently only reproduce signals about movement that are already available from the proprioceptive system? There are many different uses for forward models in physiological systems (reviewed in Ref.

38.

Miall, R.C ∙ Wolpert, D.M

**Forward models for physiological motor control**

*Neural Netw.* 1996; **9**:1265-1279

); we mention only one here. It is that forward models provide crucial motor control signals (the state estimates) that can be used—and may even be necessary in some circumstances—for the control of movement. For example, in visually guided tracking tasks, the subject tries to control his or her hand position on the basis of visual information from the target and the hand. This information is delayed by visual processing and does not directly inform the CNS about the changes in muscle forces or even joint angles required to correct for any movement errors. Likewise, in fast arm movements, sensory feedback can only be used towards the end of the movement. Hence a forward model can provide the missing feedback information, in principle with negligible delay after the issue of a motor command, allowing accurate tracking. So, although forward models have been described in terms of the processing state or \`sensory' estimates, we think of the cerebellar forward model forming a crucial element of the motor control system. In more detail, we have proposed that the cerebellum may act as a \`Smith Predictor'

34.

Miall, R.C...

**Is the cerebellum a Smith Predictor?**

*J. Motor Behav.* 1993; **25**:203-216

. This is a control scheme based on forward models, which is designed to control a system with long transport delays. The delays in sensory processing, sensory-motor coupling and motor execution in physiological systems mean that many sensory guided behaviors have \`transport delays' that are long with respect to movement duration. The Smith Predictor works in this situation because it couples a forward model located within a high gain internal feedback loop with a model of the transport delays ([Fig. 3](#FIG3)). The output of the high gain internal feedback loop is the motor command, and so provides an alternative mechanism for generating the feedforward motor commands. Thus, the cerebellar forward model, in a closed loop including motor cortical or brainstem circuits, could form an inverse model. This is thus a variant of previous hypotheses of the cerebellum as a \`side-loop' of the motor pathway. The model of the delays retains the internal predictions so that they can be compared in temporal register with the delayed feedback from the movement. Thus, the Smith Predictor has two forward models; one is a forward model of the arm dynamics, and its output is a state estimate or prediction, and the other is a forward output model that transforms and delays the state estimate to form an estimate of reafference.

Direct evidence that the cerebellum acts as a forward model is not yet available; we have reviewed supporting evidence elsewhere

34.

Miall, R.C...

**Is the cerebellum a Smith Predictor?**

*J. Motor Behav.* 1993; **25**:203-216

38.

Miall, R.C ∙ Wolpert, D.M

**Forward models for physiological motor control**

*Neural Netw.* 1996; **9**:1265-1279

. In brief, there are data from allometric studies

39.

Sultan, F ∙ Braitenberg, V

**Shapes and sizes of different mammalian cerebella: a study in quantitative comaparative neuroanatomy**

*J. Hirnforsch.* 1993; **34**:79-92

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8376757/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=8376757)

, from functional imaging studies

40.

Gao, J.H...

**Cerebellum implicated in sensory acquisition and discrimination rather than motor control**

*Science.* 1996; **272**:545-547

41.

Jueptner, M...

**The relevance of sensory input for the cerebellar control of movements**

*NeuroImage.* 1997; **5**:41-48

42.

Inoue, K...

**PET study of pointing with visual feedback of moving hands**

*J. Neurophysiol.* 1998; **79**:117-125

[PubMed](https://pubmed.ncbi.nlm.nih.gov/9425182/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=9425182)

and from clinical studies

43.

Diener, H.C...

**Cerebellar dysfunction of movement and perception**

*Can. J. Neurol. Sci.* 1993; **20**:S62-S69

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8334593/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=8334593)

44.

Nawrot, M ∙ Rizzo, M

**Motion perception deficits from midline cerebellar lesions in human**

*Vision Res.* 1995; **35**:723-731

showing that the cerebellum is concerned with processing sensory reafference. There are data from human movement studies (Refs

36.

Wolpert, D.M ∙ Ghahramani, Z ∙ Jordan, M.I

**An internal model for sensorimotor integration**

*Science.* 1995; **269**:1880-1882

45.

Miall, R.C ∙ Weir, D.J ∙ Stein, J.F

**Intermittency in human manual tracking tasks**

*J. Motor Behav.* 1993; **25**:53-63

and N. Bhushan and R. Shadmehr, pers. commun.) that are consistent with learning and use of a forward model, and there are some data from electrophysiology that also point to the cerebellar cortex (see below) and the climbing fibers

46.

Gellman, R ∙ Gibson, A.R ∙ Houk, J.C

**Inferior olive neurones in the awake cat: detection of contact and passive body displacement**

*J. Neurophysiol.* 1985; **54**:40-60

[PubMed](https://pubmed.ncbi.nlm.nih.gov/4031981/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=4031981)

having a role more consistent with sensory reafferent prediction than with motor command generation. Furthermore, in simulations of the control of the human arm based on the Smith Predictor

47.

Miall, R.C. and Wolpert, D.M. (1995) The cerebellum as a predictive model of the motor system: a Smith Predictor hypothesis, in *Neural Control of Movement* (Ferrell, W.R. and Proske, U., eds), pp. 215–223, Plenum Press

[Google Scholar](https://scholar.google.com/scholar?q=Miall%2C+R.C.+and+Wolpert%2C+D.M.+%281995%29+The+cerebellum+as+a+predictive+model+of+the+motor+system%3A+a+Smith+Predictor+hypothesis%2C+in+Neural+Control+of+Movement+%28Ferrell%2C+W.R.+and+Proske%2C+U.%2C+eds%29%2C+pp.+215%E2%80%93223%2C+Plenum+Press)

, we demonstrated how an inaccurate forward model leads to tracking deficits similar to those seen in cerebellar ataxia. To test the hypothesis more directly, we are currently collecting single cell data from cerebellar cortical cells and testing whether their responses are more closely correlated with movement of the hand or with the cursor (a visual outcome of movement) in a mirror movement task. Directionally sensitive cells correlating with hand movement might be encoding the motor command or the proprioceptive consequences of movement; but cells that co-vary with the cursor even when the hand and the cursor move in different directions are more obviously encoding the visual consequences of movement. Cells coding for the visual goal of the movement are active before movement onset, and can be excluded on that basis. We have preliminary evidence that a significant proportion of directionally sensitive cells in the intermediate cerebellar cortex are more strongly related to the direction of cursor movement than to the movement of the hand itself

48.

Miall, R.C. The cerebellum, predictive control and coordination, in *Sensory Guidance of Movement* (Glickstein, M. and Bock, R., eds), Novartis (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Miall%2C+R.C.+The+cerebellum%2C+predictive+control+and+coordination%2C+in+Sensory+Guidance+of+Movement+%28Glickstein%2C+M.+and+Bock%2C+R.%2C+eds%29%2C+Novartis+%28in+press%29)

. Ebner and Fu

49.

Ebner, T.J. and Fu, Q. (1997) What features of visually guided arm movements are encoded in the simple spike discharge of cerebellar Purkinje cells? in *The Cerebellum, From Structure to Control* (Progress in Brain Research, Vol. 114) (Zeeuw, C.I., De Strata, P. and Voogd, J., eds), pp. 431–447, Elsevier

[Google Scholar](https://scholar.google.com/scholar?q=Ebner%2C+T.J.+and+Fu%2C+Q.+%281997%29+What+features+of+visually+guided+arm+movements+are+encoded+in+the+simple+spike+discharge+of+cerebellar+Purkinje+cells%3F+in+The+Cerebellum%2C+From+Structure+to+Control+%28Progress+in+Brain+Research%2C+Vol.+114%29+%28Zeeuw%2C+C.I.%2C+De+Strata%2C+P.+and+Voogd%2C+J.%2C+eds%29%2C+pp.+431%E2%80%93447%2C+Elsevier)

have data consistent with this, as the activity profiles of their P-cells were initially correlated with hand movement, but later in each trial correlated with cursor movement. We have also recently shown that there is a predictable relationship between increased SS activity and subsequent CS activity ∼150ms later

50.

Miall, R.C. *et al*. Purkinje cell complex spikes are predicted by simple spike activity *Nat. Neurosci*. (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Miall%2C+R.C.+et+al.+Purkinje+cell+complex+spikes+are+predicted+by+simple+spike+activity+Nat.+Neurosci.+%28in+press%29)

. This is consistent with the cerebellar cortical output being a predictive signal that is actively corrected by climbing fiber input after a finite delay of 150ms, which is equivalent to the prediction interval in this visually guided task.

The Smith-Predictor hypothesis has been criticized on the grounds that it requires two separate forward models that are trained simultaneously

51.

Arbib, M.A., Erdi, P. and Szentágothai, J. (1989) *Neural Organization. Structure, Function and Dynamics*, MIT Press

[Google Scholar](https://scholar.google.com/scholar?q=Arbib%2C+M.A.%2C+Erdi%2C+P.+and+Szent%C3%A1gothai%2C+J.+%281989%29+Neural+Organization.+Structure%2C+Function+and+Dynamics%2C+MIT+Press)

. So there is a structural credit assignment problem facing the action of the climbing fiber inputs from the inferior olive, which induce long-term depression of the P-cell inputs from parallel fibers. However, we assumed in earlier papers that the learning rate for the two models would be very different, with slow adaptation of the model of feedback delays, and faster learning of the dynamic model; this allows stable learning of both models

47.

Miall, R.C. and Wolpert, D.M. (1995) The cerebellum as a predictive model of the motor system: a Smith Predictor hypothesis, in *Neural Control of Movement* (Ferrell, W.R. and Proske, U., eds), pp. 215–223, Plenum Press

[Google Scholar](https://scholar.google.com/scholar?q=Miall%2C+R.C.+and+Wolpert%2C+D.M.+%281995%29+The+cerebellum+as+a+predictive+model+of+the+motor+system%3A+a+Smith+Predictor+hypothesis%2C+in+Neural+Control+of+Movement+%28Ferrell%2C+W.R.+and+Proske%2C+U.%2C+eds%29%2C+pp.+215%E2%80%93223%2C+Plenum+Press)

. We have now shown in a human visually guided tracking task (Miall and Foulkes, unpublished) that adaptation to added feedback delays of 200 or 300ms in a visual tracking task is indeed much slower than to changes in task dynamics with a time course of several hours. Oculomotor adaptation is equally slow

52.

Deno, D.C ∙ Keller, E.L ∙ Crandall, W.F

**Dynamical neural network organization of the visual pursuit system**

*IEEE Trans. Biomed. Eng.* 1989; **36**:85-92

. Thus, stable training of both models with a single error term may not be difficult. Finally, we still need to be able to demonstrate that the delayed error signals from the olive can affect the appropriate parallel fiber-P-cell synapses, those that were active at least 150ms previously, a temporal credit assignment problem faced by many models of motor learning. We are currently testing models in which the metabotropic receptors on the P-cell act to keep a trace of previous input activity (M. Malkmus, R.C. Miall, and J.F. Stein, unpublished), in line with similar models of the cerebellar cortical contribution to eye-blink conditioning

53.

Fiala, J.C ∙ Grossberg, S ∙ Bullock, D

**Metabotropic glutamate receptor activation in cerebellar Purkinje cells as substrate for adaptive timing of the classically conditioned eye-blink response**

*J. Neurosci.* 1996; **16**:3760-3774

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8642419/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=8642419)

or saccadic adaptation

54.

Schweighofer, N ∙ Arbib, M.A ∙ Dominey, P.F

**A model of the cerebellum in adaptive control of saccadic gain: I. The model and its biological substrate**

*Biol. Cybern.* 1996; **75**:19-28

.

## 3 The cerebellum as multiple paired forward and inverse models

The previous sections have focused on the utility and evidence for either inverse or forward models within the cerebellum for generation of motor commands and control of movements. In this section, we speculate on the benefits of multiple internal models and, in particular, the advantages of pairing inverse and forward models for motor learning and control. Although the cerebellum has often been viewed as a modular system

3.

Ito, M. (1984) *The Cerebellum and Neural Control*, Raven Press

[Google Scholar](https://scholar.google.com/scholar?q=Ito%2C+M.+%281984%29+The+Cerebellum+and+Neural+Control%2C+Raven+Press)

55.

Oscarsson, O

**Functional units of the cerebellum: sagittal zones and microzones**

*Trends Neurosci.* 1979; **2**:143-145

, we present a new cohesive computational framework for motor learning and control.

Humans demonstrate a remarkable ability to generate accurate and appropriate motor behavior under many different and often uncertain environmental conditions. Considering the number of objects and environments, and their possible combinations, that can influence the dynamics of the motor system, the controller must be capable of providing appropriate motor commands for a multitude of distinct contexts, such as different tasks and interactions with objects, that are likely to be experienced. Given this multitude of contexts, there are two qualitatively distinct strategies to motor control and learning. The first is to use a single controller that uses all the contextual information in an attempt to produce an appropriate control signal. However, such a controller would demand enormous complexity to allow for all possible scenarios. If this controller were unable to encapsulate all the contexts, it would need to adapt every time the context of the movement changed before it could produce appropriate motor commands—this would produce transient and possibly large performance errors. Alternatively, a modular approach can be used in which multiple controllers co-exist, with each controller suitable for one or a small set of contexts. Depending on the current context, only those appropriate controllers should be active to generate the motor command.

While forward and inverse models could be learned by a single module, there are three potential benefits in employing a modular approach. First, the world is essentially modular, in that we interact with multiple qualitatively different objects and environments. By using multiple inverse models, each of which might capture the motor commands necessary when acting with a particular object or within a particular environment, we could achieve an efficient coding of the world. In other words, the large set of environmental conditions in which we are required to generate movement requires multiple behaviors or sets of motor commands, each embodied within a module. Secondly, the use of a modular system allows individual modules to adapt through motor learning without affecting the motor behaviors already learned by other modules. Thirdly, many situations that we encounter are derived from combinations of previously experienced contexts, such as novel conjoints of manipulated objects and environments. By modulating the contribution to the final motor command of the outputs of the inverse modules, an enormous repertoire of behaviors can be generated. With as few as 32 inverse models, in which the output of each model either contributes or does not contribute to the final motor command, we have 2 <sup>32</sup> or 10 <sup>10</sup> behaviors—sufficient for a new behavior for every second of one's life. Therefore, multiple internal models can be regarded conceptually as motor primitives, which are the building blocks used to construct intricate motor behaviors with an enormous vocabulary.

Several studies have shown that the motor system is able to adapt to multiple different environments. Context dependent adaptation can be seen if cued by gaze direction

56.

Kohler, I

**Development and alterations of the perceptual world: conditioned sensations**

*Proc. Austrian Acad. Sci.* 1951; **227**:1-118

[Google Scholar](https://scholar.google.com/scholar?q=IKohlerDevelopment+and+alterations+of+the+perceptual+world%3A+conditioned+sensationsProc.+Austrian+Acad.+Sci.22719511118)

57.

Hay, J.C ∙ Pick, H.L

**Gaze-contingent prism adaptation: optical and motor factors**

*J. Exp. Psychol.* 1966; **72**:640-648

58.

Shelhamer, M ∙ Robinson, D.A ∙ Tan, H.S

**Context-specific gain switching in the human vestibulo–ocular reflex**

*Ann. New York Acad. Sci.* 1991; **656**:889-891

, body orientation

59.

Baker, J.F...

**Simultaneous opposing adaptive changes in cat vestibulo–ocular reflex directions for two body orientations**

*Exp. Brain Res.* 1987; **69**:220-224

, arm configuration

60.

Gandolfo, F ∙ Mussa-Ivaldi, F.A ∙ Bizzi, E

**Motor learning by field approximation**

*Proc. Natl. Acad. Sci. U. S. A.* 1996; **93**:3843-3846

, an auditory tone

61.

Kravitz, J.H ∙ Yaffe, F

**Conditioned adaptation to prismatic displacement with a tone as the conditional stimulus**

*Percept. Psychophys.* 1972; **12**:305-308

or the feel of prism goggles

62.

Kravitz, J.H

**Conditioned adaptation to prismatic displacement**

*Percept. Psychophys.* 1972; **11**:38-42

63.

Welch, R.B

**Discriminative conditioning of prism adaptation**

*Percept. Psychophys.* 1971; **10**:90-92

64.

Martin, T.A...

**Throwing while looking through prisms: II. Specificity and storage of multiple gaze-throw calibrations**

*Brain.* 1996; **119**:1199-1211

. In general, de-adaptation is quicker than adaptation

65.

Welch, R.B. (1986) Adaptation of space perception, in *Handbook of Perception and Human Performance* (Vol. 1, Section 24) (Boff, K.R., Kaufman, L. and Thomas, J.P., eds), pp. 24.1–24.45, John Wiley & Sons

[Google Scholar](https://scholar.google.com/scholar?q=Welch%2C+R.B.+%281986%29+Adaptation+of+space+perception%2C+in+Handbook+of+Perception+and+Human+Performance+%28Vol.+1%2C+Section+24%29+%28Boff%2C+K.R.%2C+Kaufman%2C+L.+and+Thomas%2C+J.P.%2C+eds%29%2C+pp.+24.1%E2%80%9324.45%2C+John+Wiley+%26+Sons)

, suggesting that de-adaptation may mainly be a switching process, while adaptation represents learning a new module. Similarly, adaptation becomes increasingly rapid when subjects are presented repeatedly with two different prismatic displacements separated temporally

66.

McGonigle, B.O ∙ Flook, J.P

**Long-term retention of single and multistate prismatic adaptation by humans**

*Nature.* 1978; **272**:364-366

67.

Welch, R.B...

**Alternating prism exposure causes dual adaptation and generalization to a novel displacement**

*Percept. Psychophys.* 1993; **54**:195-204

, suggesting that a retained module can be quickly switched on again in response to the behavioral context. Data for mixing of two new learned modules based on prism work

68.

Ghahramani, Z ∙ Wolpert, D.M

**Modular decomposition in visuomotor learning**

*Nature.* 1997; **386**:392-395

suggest a specific way that multiple modules are integrated.

Based on the benefits of a modular approach and the experimental evidence for modularity, Wolpert and Kawato

69.

Wolpert, D.M. and Kawato, M. Multiple paired forward and inverse models for motor control *Neural Netw*. (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Wolpert%2C+D.M.+and+Kawato%2C+M.+Multiple+paired+forward+and+inverse+models+for+motor+control+Neural+Netw.+%28in+press%29)

70.

Kawato, M. and Wolpert, D.M. Internal models for motor control, in *Sensory Guidance of Movement* (Glickstein, M. and Bock, R., eds), Novartis (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Kawato%2C+M.+and+Wolpert%2C+D.M.+Internal+models+for+motor+control%2C+in+Sensory+Guidance+of+Movement+%28Glickstein%2C+M.+and+Bock%2C+R.%2C+eds%29%2C+Novartis+%28in+press%29)

have proposed that the problem of motor learning and control is best solved using multiple controllers—that is, inverse models. At any given time, one or a subset of these inverse models will contribute to the final motor command (see [Appendix A](#app-1) for details of the model). However, if there are multiple controllers, then there must also be some scheme to select the appropriate controller or controllers at each moment in time. The basic idea is that multiple inverse models exist to control the system, and each is augmented with a forward model that determines the responsibility each controller should assume during movement. This responsibility signal reflects, at any given time, the degree to which each pair of forward and inverse models should be responsible for controlling the current behavior. Within each module, the inverse and forward internal models are tightly coupled during their acquisition, through motor learning. This ensures that the forward models learn to divide up experience so at least one forward model can predict the consequence of performed actions under any given context. By coupling the learning of the forward and inverse models, the inverse models learn to provide appropriate control commands in contexts in which their paired forward model produces accurate predictions.

The responsibilities are determined by two distinct processes (see [Appendix A](#app-1)). The first uses sensory contextual cues to predict the responsibility of the module and can therefore select controllers prior to movement initiation. The second process uses the forward model's predictions. As each forward model captures a distinct dynamical behavior of the motor system, their prediction errors can be used during movement to determine in which context the motor system is acting.

This scheme based on multiple paired forward-inverse modules is capable of learning to produce appropriate motor commands under a variety of contexts and can switch rapidly between controllers as the context changes. These features are important for a full model of motor control and motor learning, as it is clear that the human motor system is capable of very flexible, modular adaptation. We propose, therefore, that the cerebellum contains multiple pairs of corresponding forward and inverse models, each instantiated within a microzone. The modular and repetitive architecture would include the forward and inverse models of the previous sections and we are currently investigating the ways in which its computational circuit diagram could map onto the neural networks in and around the cerebellum.

## 4 Conclusion

Internal models provide a firm computational foundation from which theories of the cerebellum can be considered. We have reviewed the evidence that the cerebellum contains inverse or forward models of the motor system. By considering the possibility that the cerebellum contains multiple pairs of forward and inverse models, we believe that the benefits of both views can be retained and integrated. Such a paired system would results in computational advantages in both motor learning and control.

## 5 Outstanding questions

- There is evidence that the cerebellum contributes to an inverse dynamics model of the eye. But similar evidence for the hand and arm is less clear. Does this imply different function for the cerebellum in controlling different effectors or does it simply reflect the different levels of complexity, making identification of internal models of the hand less certain?
- Are the different types of model (forward and inverse) found in different areas of the cerebellar cortex? Are the paired models spatially local or are the forward and inverse models grouped?
- Although it is generally agreed that the climbing fibers provide motor error signals for eye movements, do they supply the same or additional signals for skeleto-motor control?
- While hypotheses based on internal models can provide a role for the cerebellum, the details of implementing the models in cerebellar neural tissue are far from clear. Is LTD the main process or is LTP also important?
- Many studies support the cerebellum in a cognitive role. It is simple to extend the concept of internal models of the motor system to internal models of the external world, of other people's mental processes or of parts of one's own brain. Can such models play a fundamental role in understanding cerebellar functions in perception, planning, communication, thinking and consciousness
	71.
	Kawato, M. (1997) Bidirectional theory approach to consciousness, in *Cognition, Computation and Consciousness* (Ito, M., Miyashita, Y. and Rolls, E.T., eds), pp. 223–248, Oxford University Press
	[Google Scholar](https://scholar.google.com/scholar?q=Kawato%2C+M.+%281997%29+Bidirectional+theory+approach+to+consciousness%2C+in+Cognition%2C+Computation+and+Consciousness+%28Ito%2C+M.%2C+Miyashita%2C+Y.+and+Rolls%2C+E.T.%2C+eds%29%2C+pp.+223%E2%80%93248%2C+Oxford+University+Press)
	?

## Acknowledgements

This work was supported by grants from the Wellcome Trust, the Medical Research Council, the Royal Society, the BBSRC and the Human Frontier Science Project. R.C.M. is supported by a Wellcome Senior Research Fellowship.

## Appendix A Multiple paired forward-inverse models

The [Fig. 4](#FIG4) shows a schematic of the multiple paired forward-inverse model

74.

Wolpert, D.M. and Kawato, M. Multiple paired forward and inverse models for motor control *Neural Netw*. (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Wolpert%2C+D.M.+and+Kawato%2C+M.+Multiple+paired+forward+and+inverse+models+for+motor+control+Neural+Netw.+%28in+press%29)

75.

Kawato, M. and Wolpert, D.M. Internal models for motor control, in *Sensory Guidance of Movement* (Glickstein, M. and Bock, R., eds), Novartis (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Kawato%2C+M.+and+Wolpert%2C+D.M.+Internal+models+for+motor+control%2C+in+Sensory+Guidance+of+Movement+%28Glickstein%2C+M.+and+Bock%2C+R.%2C+eds%29%2C+Novartis+%28in+press%29)

. N paired modules are shown as stacked sheets (the dotted lines represent training signals and × signal multiplication). The details of the first module are shown and interactions between modules take place through the Responsibility Estimator. Each module consists of three interacting parts. The first two, the forward model and the responsibility predictor, are used to determine the responsibility of the module. This responsibility signal reflects the degree to which the module captures the current context and should, therefore, participate in control. The aim is that the multiple forward models learn to divide up experience so at least one forward model can predict the consequence of performed actions under any given context. The likelihood that a particular forward model captures the current behavior is determined from its prediction error. The smaller this error, the more likely the sensory feedback and efference copy are consistent with the context captured by the forward model, and hence the higher the module's responsibility. However, the forward model can only be used to estimate responsibility once a movement has been initiated and the results of action are known. To allow sensory contextual signal to alter the responsibility prior to movement, a responsibility predictor estimates the responsibility before movement onset using sensory contextual cues and is trained to approximate the final responsibility estimate. By multiplying this estimate (the prior) by the likelihood derived from the forward models, and normalizing across the modules using the responsibility estimator (with soft-max for example), an estimate of the module's responsibility (posterior estimate) is achieved.

![Figure FIG4](https://www.cell.com/cms/10.1016/S1364-6613(98)01221-2/asset/4741f864-1c94-428f-8d98-1cd8aac9cfd0/main.assets/gr4.jpg)

Fig. 4

This responsibility signal represents the extent to which each forward model/responsibility predictor accounts for the behavior of the system. It ensures that the smaller the prediction error, the higher the forward module's responsibility and vice-versa. The responsibilities are then used to control the learning within the forward models, with those models with high responsibilities receiving proportionally more of their error signal than modules with low responsibility. By weighting the errors by the responsibility we ensure competitive learning so that the forward models will learn to divide up the system dynamics experienced and the responsibilities will reflect the extent to which each forward model captures the current behavior of the system.

For each behavior captured by a forward model we wish to learn a controller. Hence, the third component of the model is the inverse model which generate a motor command given a desired trajectory. Each module has an inverse model which learns to provide suitable control signals under the context for which the paired forward model provides accurate predictions. Again the responsibilities are used to weight the error signal (the feedback motor command as discussed in the section on Inverse Models) for each inverse model thereby ensuring that the inverse model and forward model within a module are tightly coupled during learning. If one forward model's prediction is good, its corresponding inverse model receives the major part of the motor error signal. Finally the responsibilities are used to determine the extent to which each inverse model's output contributes to the final feedforward motor command.

## References

[1.](#body-ref-BIB3-1 "View in article")

Marr, D

**A theory of cerebellar cortex**

*J. Physiol.* 1969; **202**:437-470

[2.](#body-ref-BIB3-1 "View in article")

Albus, J.S

**A theory of cerebellar function**

*Math. Biosci.* 1971; **10**:25-61

[3.](#body-ref-BIB3-1 "View in article")

Ito, M. (1984) *The Cerebellum and Neural Control*, Raven Press

[Google Scholar](https://scholar.google.com/scholar?q=Ito%2C+M.+%281984%29+The+Cerebellum+and+Neural+Control%2C+Raven+Press)

[4.](#body-ref-BIB5-1 "View in article")

Kawato, M ∙ Furawaka, K ∙ Suzuki, R

**A hierarchical neural network model for the control and learning of voluntary movements**

*Biol. Cybern.* 1987; **56**:1-17

[5.](#body-ref-BIB5-1 "View in article")

Jordan, M.I ∙ Rumelhart, D.E

**Forward models: supervised learning with a distal teacher**

*Cognit. Sci.* 1992; **16**:307-354

[Crossref](https://doi.org/10.1207/s15516709cog1603_1)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1207%2Fs15516709cog1603_1)

[6.](#body-ref-BIB9 "View in article")

Feldman, A.G

**Functional tuning of the nervous system with control of movement or maintenance of a steady posture: III. Mechanographic analysis of execution by arm of the simplest motor tasks**

*Biophysics.* 1966; **11**:766-775

[Google Scholar](https://scholar.google.com/scholar?q=A.GFeldmanFunctional+tuning+of+the+nervous+system+with+control+of+movement+or+maintenance+of+a+steady+posture%3A+III.+Mechanographic+analysis+of+execution+by+arm+of+the+simplest+motor+tasksBiophysics111966766775)

[7.](#body-ref-BIB9 "View in article")

Bizzi, E...

**Posture control and trajectory formation during arm movement**

*J. Neurosci.* 1984; **4**:2738-2744

[PubMed](https://pubmed.ncbi.nlm.nih.gov/6502202/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=6502202)

[8.](#body-ref-BIB9 "View in article")

Hogan, N

**An organizing principle for a class of voluntary movements**

*J. Neurosci.* 1984; **4**:2745-2754

[PubMed](https://pubmed.ncbi.nlm.nih.gov/6502203/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=6502203)

[9.](#body-ref-BIB9 "View in article")

Flash, T

**The control of hand equilibrium trajectories in multi-joint arm movements**

*Biol. Cybern.* 1987; **57**:257-274

[10.](#body-ref-BIB10 "View in article")

Gomi, H ∙ Kawato, M

**Equilibrium-point control hypothesis examined by measured arm stiffness during multijoint movement**

*Science.* 1996; **272**:117-120

[11.](#body-ref-BIB11-1 "View in article")

Kawato, M ∙ Gomi, H

**The cerebellum and VOR/OKR learning models**

*Trends Neurosci.* 1992; **15**:445-453

[12.](#body-ref-BIB14-1 "View in article")

Kobayashi, Y. *et al*. Temporal firing patterns of Purkinje cells in the cerebellar ventral paraflocculus during ocular following responses in monkeys. II. Complex spikes *J. Neurophysiol*. (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Kobayashi%2C+Y.+et+al.+Temporal+firing+patterns+of+Purkinje+cells+in+the+cerebellar+ventral+paraflocculus+during+ocular+following+responses+in+monkeys.+II.+Complex+spikes+J.+Neurophysiol.+%28in+press%29)

[13.](#body-ref-BIB14-1 "View in article")

Shidara, M...

**Inverse-dynamics encoding of eye movement by Purkinje cells in the cerebellum**

*Nature.* 1993; **365**:50-52

[14.](#body-ref-BIB14-1 "View in article")

Gomi, H. *et al*. Temporal firing patterns of Purkinje cells in the cerebellar ventral paraflocculus during ocular following responses in monkeys: I. Simple spikes. *J. Neurophysiol*. (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Gomi%2C+H.+et+al.+Temporal+firing+patterns+of+Purkinje+cells+in+the+cerebellar+ventral+paraflocculus+during+ocular+following+responses+in+monkeys%3A+I.+Simple+spikes.+J.+Neurophysiol.+%28in+press%29)

[15.](#body-ref-BIB15 "View in article")

Takemura, A. *et al*. (1994) A linear regression time-series analysis of neural activity during ocular following, in The 9th Symposium on Biological and Physiological Engineering, pp. 275–278, Society of Instrumental and Control Engineers of Japan

[Google Scholar](https://scholar.google.com/scholar?q=Takemura%2C+A.+et+al.+%281994%29+A+linear+regression+time-series+analysis+of+neural+activity+during+ocular+following%2C+in+The+9th+Symposium+on+Biological+and+Physiological+Engineering%2C+pp.+275%E2%80%93278%2C+Society+of+Instrumental+and+Control+Engineers+of+Japan)

[16.](#body-ref-BIB16 "View in article")

Kawato, M. (1995) Analysis of neural firing frequency by a generalized linear model *Tech. Rep. IEICE* NC95-33, pp. 31–38

[Google Scholar](https://scholar.google.com/scholar?q=Kawato%2C+M.+%281995%29+Analysis+of+neural+firing+frequency+by+a+generalized+linear+model+Tech.+Rep.+IEICE+NC95-33%2C+pp.+31%E2%80%9338)

[17.](#body-ref-BIB17 "View in article")

Shidara, M ∙ Kawano, K

*Exp. Brain Res.* 1993; **93**:185-195

[18.](#body-ref-BIB18 "View in article")

Yamamoto, K. *et al*. (1998) A computational simulation on the adaptation of vertical ocular following responses. *Tech. Rep. IEICE* NC97-131, pp. 229–236

[Google Scholar](https://scholar.google.com/scholar?q=Yamamoto%2C+K.+et+al.+%281998%29+A+computational+simulation+on+the+adaptation+of+vertical+ocular+following+responses.+Tech.+Rep.+IEICE+NC97-131%2C+pp.+229%E2%80%93236)

[19.](#body-ref-BIB19-1 "View in article")

Kawato, M. (1996) Trajectory formation in arm movements: minimization principles and procedures, in *Advances in Motor Learning and Control* (Zelaznik, H.N., ed.), pp. 225–259, Human Kinetics Publishers

[Google Scholar](https://scholar.google.com/scholar?q=Kawato%2C+M.+%281996%29+Trajectory+formation+in+arm+movements%3A+minimization+principles+and+procedures%2C+in+Advances+in+Motor+Learning+and+Control+%28Zelaznik%2C+H.N.%2C+ed.%29%2C+pp.+225%E2%80%93259%2C+Human+Kinetics+Publishers)

[20.](#body-ref-BIB21-1 "View in article")

Houk, J.C. and Barto, A.G. (1991) Distributed sensorimotor learning, in *Tutorial in Motor Behavior II* (Stelmach, G.E. and Requin, J., eds), pp. 71–100, Elsevier

[Google Scholar](https://scholar.google.com/scholar?q=Houk%2C+J.C.+and+Barto%2C+A.G.+%281991%29+Distributed+sensorimotor+learning%2C+in+Tutorial+in+Motor+Behavior+II+%28Stelmach%2C+G.E.+and+Requin%2C+J.%2C+eds%29%2C+pp.+71%E2%80%93100%2C+Elsevier)

[21.](#body-ref-BIB21-1 "View in article")

Houk, J.C ∙ Buckingham, J.T ∙ Barto, A.G

**Models of the cerebellum and motor learning**

*Behav. Brain Sci.* 1996; **19**:363-383

[Google Scholar](https://scholar.google.com/scholar?q=J.CHoukJ.TBuckinghamA.GBartoModels+of+the+cerebellum+and+motor+learningBehav.+Brain+Sci.191996363383)

[22.](#body-ref-BIB22 "View in article")

Tsukahara, N...

**Properties of cerebello–precerebellar reverberating circuits**

*Brain Res.* 1983; **274**:249-259

[23.](#body-ref-BIB23 "View in article")

Boylls, C.C. (1975) A theory of cerebellar function with applications to locomotion: I. The physiological role of climbing fiber inputs in anterior lobe operation. COINS Technical Report, Computer and Information Science University of Massachusetts

[Google Scholar](https://scholar.google.com/scholar?q=Boylls%2C+C.C.+%281975%29+A+theory+of+cerebellar+function+with+applications+to+locomotion%3A+I.+The+physiological+role+of+climbing+fiber+inputs+in+anterior+lobe+operation.+COINS+Technical+Report%2C+Computer+and+Information+Science+University+of+Massachusetts)

[24.](#body-ref-BIB26 "View in article")

Ito, M

**Cerebellar learning in vestibulo–ocular reflex**

*Trends Cognit. Sci.* 1998; **2**:313-321

[25.](#body-ref-BIB26 "View in article")

DeZeeuw, C...

**Expression of a protein kinase-C inhibitor in Purkinje cells block cerebellar LTD and adaptation of the vestibulo–ocular reflex**

*Neuron.* 1998; **20**:495-508

[26.](#body-ref-BIB26 "View in article")

Raymond, J.L ∙ Lisberger, S.G ∙ Mauk, M.D

**The cerebellum: a neuronal learning machine?**

*Science.* 1996; **272**:1126-1131

[27.](#body-ref-BIB27-1 "View in article")

Lisberger, S.G

**Neural basis for motor learning in the vestibuloocular reflex of primates: III. Computational and behavioral analysis of the sites of learning**

*J. Neurophysiol.* 1994; **72**:974-998

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7983549/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=7983549)

[28.](#body-ref-BIB73-1 "View in article")

Kawano, K...

*J. Neurophysiol.* 1994; **71**:2305-2324

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7931519/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=7931519)

[29.](#body-ref-BIB29-1 "View in article")

Kitazawa, S ∙ Kimura, T ∙ Yin, P

**Cerebellar complex spikes encode both destinations and errors in arm movements**

*Nature.* 1998; **392**:494-497

[30.](#body-ref-BIB30 "View in article")

Imamizu, H...

**Separated modules for visuomotor control and learning in the cerebellum: a functional MRI study**

*NeuroImage.* 1997; **5**:S598

[Google Scholar](https://scholar.google.com/scholar?q=HImamizuSeparated+modules+for+visuomotor+control+and+learning+in+the+cerebellum%3A+a+functional+MRI+studyNeuroImage51997S598)

[31.](#body-ref-BIB31-1 "View in article")

Schweighofer, N...

**Role of the cerebellum in reaching quickly and accurately: II. A detailed model of the intermediate cerebellum**

*Eur. J. Neurosci.* 1998; **10**:95-105

[32.](#body-ref-BIB35 "View in article")

Ito, M

**Neurophysiological aspects of the cerebellar motor control system**

*Int. J. Neurol.* 1970; **7**:162-176

[PubMed](https://pubmed.ncbi.nlm.nih.gov/5499516/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=5499516)

[33.](#body-ref-BIB35 "View in article")

Miall, R.C

**Internal representation of human arm movements in visually guided tracking**

*J. Physiol.* 1989; **420**:61P

[Google Scholar](https://scholar.google.com/scholar?q=R.CMiallInternal+representation+of+human+arm+movements+in+visually+guided+trackingJ.+Physiol.420198961P)

[34.](#body-ref-BIB35 "View in article")

Miall, R.C...

**Is the cerebellum a Smith Predictor?**

*J. Motor Behav.* 1993; **25**:203-216

[35.](#body-ref-BIB35 "View in article")

Paulin, M.G. (1989) A Kalman-filter theory of the cerebellum, in *Dynamic Interactions in Neural Networks: Models and Data* (Arbib, M.A. and Amari, S., eds), pp. 241–259, Springer-Verlag

[Google Scholar](https://scholar.google.com/scholar?q=Paulin%2C+M.G.+%281989%29+A+Kalman-filter+theory+of+the+cerebellum%2C+in+Dynamic+Interactions+in+Neural+Networks%3A+Models+and+Data+%28Arbib%2C+M.A.+and+Amari%2C+S.%2C+eds%29%2C+pp.+241%E2%80%93259%2C+Springer-Verlag)

[36.](#body-ref-BIB37 "View in article")

Wolpert, D.M ∙ Ghahramani, Z ∙ Jordan, M.I

**An internal model for sensorimotor integration**

*Science.* 1995; **269**:1880-1882

[37.](#body-ref-BIB37 "View in article")

Wolpert, D.M

**Computational approaches to motor control**

*Trends Cognit. Sci.* 1997; **1**:209-216

[38.](#body-ref-BIB38-1 "View in article")

Miall, R.C ∙ Wolpert, D.M

**Forward models for physiological motor control**

*Neural Netw.* 1996; **9**:1265-1279

[39.](#body-ref-BIB39 "View in article")

Sultan, F ∙ Braitenberg, V

**Shapes and sizes of different mammalian cerebella: a study in quantitative comaparative neuroanatomy**

*J. Hirnforsch.* 1993; **34**:79-92

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8376757/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=8376757)

[40.](#body-ref-BIB42 "View in article")

Gao, J.H...

**Cerebellum implicated in sensory acquisition and discrimination rather than motor control**

*Science.* 1996; **272**:545-547

[41.](#body-ref-BIB42 "View in article")

Jueptner, M...

**The relevance of sensory input for the cerebellar control of movements**

*NeuroImage.* 1997; **5**:41-48

[42.](#body-ref-BIB42 "View in article")

Inoue, K...

**PET study of pointing with visual feedback of moving hands**

*J. Neurophysiol.* 1998; **79**:117-125

[PubMed](https://pubmed.ncbi.nlm.nih.gov/9425182/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=9425182)

[43.](#body-ref-BIB44 "View in article")

Diener, H.C...

**Cerebellar dysfunction of movement and perception**

*Can. J. Neurol. Sci.* 1993; **20**:S62-S69

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8334593/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=8334593)

[44.](#body-ref-BIB44 "View in article")

Nawrot, M ∙ Rizzo, M

**Motion perception deficits from midline cerebellar lesions in human**

*Vision Res.* 1995; **35**:723-731

[45.](#body-ref-BIB45 "View in article")

Miall, R.C ∙ Weir, D.J ∙ Stein, J.F

**Intermittency in human manual tracking tasks**

*J. Motor Behav.* 1993; **25**:53-63

[46.](#body-ref-BIB46 "View in article")

Gellman, R ∙ Gibson, A.R ∙ Houk, J.C

**Inferior olive neurones in the awake cat: detection of contact and passive body displacement**

*J. Neurophysiol.* 1985; **54**:40-60

[PubMed](https://pubmed.ncbi.nlm.nih.gov/4031981/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=4031981)

[47.](#body-ref-BIB47-1 "View in article")

Miall, R.C. and Wolpert, D.M. (1995) The cerebellum as a predictive model of the motor system: a Smith Predictor hypothesis, in *Neural Control of Movement* (Ferrell, W.R. and Proske, U., eds), pp. 215–223, Plenum Press

[Google Scholar](https://scholar.google.com/scholar?q=Miall%2C+R.C.+and+Wolpert%2C+D.M.+%281995%29+The+cerebellum+as+a+predictive+model+of+the+motor+system%3A+a+Smith+Predictor+hypothesis%2C+in+Neural+Control+of+Movement+%28Ferrell%2C+W.R.+and+Proske%2C+U.%2C+eds%29%2C+pp.+215%E2%80%93223%2C+Plenum+Press)

[48.](#body-ref-BIB48 "View in article")

Miall, R.C. The cerebellum, predictive control and coordination, in *Sensory Guidance of Movement* (Glickstein, M. and Bock, R., eds), Novartis (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Miall%2C+R.C.+The+cerebellum%2C+predictive+control+and+coordination%2C+in+Sensory+Guidance+of+Movement+%28Glickstein%2C+M.+and+Bock%2C+R.%2C+eds%29%2C+Novartis+%28in+press%29)

[49.](#body-ref-BIB49 "View in article")

Ebner, T.J. and Fu, Q. (1997) What features of visually guided arm movements are encoded in the simple spike discharge of cerebellar Purkinje cells? in *The Cerebellum, From Structure to Control* (Progress in Brain Research, Vol. 114) (Zeeuw, C.I., De Strata, P. and Voogd, J., eds), pp. 431–447, Elsevier

[Google Scholar](https://scholar.google.com/scholar?q=Ebner%2C+T.J.+and+Fu%2C+Q.+%281997%29+What+features+of+visually+guided+arm+movements+are+encoded+in+the+simple+spike+discharge+of+cerebellar+Purkinje+cells%3F+in+The+Cerebellum%2C+From+Structure+to+Control+%28Progress+in+Brain+Research%2C+Vol.+114%29+%28Zeeuw%2C+C.I.%2C+De+Strata%2C+P.+and+Voogd%2C+J.%2C+eds%29%2C+pp.+431%E2%80%93447%2C+Elsevier)

[50.](#body-ref-BIB50 "View in article")

Miall, R.C. *et al*. Purkinje cell complex spikes are predicted by simple spike activity *Nat. Neurosci*. (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Miall%2C+R.C.+et+al.+Purkinje+cell+complex+spikes+are+predicted+by+simple+spike+activity+Nat.+Neurosci.+%28in+press%29)

[51.](#body-ref-BIB51 "View in article")

Arbib, M.A., Erdi, P. and Szentágothai, J. (1989) *Neural Organization. Structure, Function and Dynamics*, MIT Press

[Google Scholar](https://scholar.google.com/scholar?q=Arbib%2C+M.A.%2C+Erdi%2C+P.+and+Szent%C3%A1gothai%2C+J.+%281989%29+Neural+Organization.+Structure%2C+Function+and+Dynamics%2C+MIT+Press)

[52.](#body-ref-BIB52 "View in article")

Deno, D.C ∙ Keller, E.L ∙ Crandall, W.F

**Dynamical neural network organization of the visual pursuit system**

*IEEE Trans. Biomed. Eng.* 1989; **36**:85-92

[53.](#body-ref-BIB53 "View in article")

Fiala, J.C ∙ Grossberg, S ∙ Bullock, D

**Metabotropic glutamate receptor activation in cerebellar Purkinje cells as substrate for adaptive timing of the classically conditioned eye-blink response**

*J. Neurosci.* 1996; **16**:3760-3774

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8642419/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=8642419)

[54.](#body-ref-BIB54 "View in article")

Schweighofer, N ∙ Arbib, M.A ∙ Dominey, P.F

**A model of the cerebellum in adaptive control of saccadic gain: I. The model and its biological substrate**

*Biol. Cybern.* 1996; **75**:19-28

[55.](#body-ref-BIB55 "View in article")

Oscarsson, O

**Functional units of the cerebellum: sagittal zones and microzones**

*Trends Neurosci.* 1979; **2**:143-145

[56.](#body-ref-BIB58 "View in article")

Kohler, I

**Development and alterations of the perceptual world: conditioned sensations**

*Proc. Austrian Acad. Sci.* 1951; **227**:1-118

[Google Scholar](https://scholar.google.com/scholar?q=IKohlerDevelopment+and+alterations+of+the+perceptual+world%3A+conditioned+sensationsProc.+Austrian+Acad.+Sci.22719511118)

[57.](#body-ref-BIB58 "View in article")

Hay, J.C ∙ Pick, H.L

**Gaze-contingent prism adaptation: optical and motor factors**

*J. Exp. Psychol.* 1966; **72**:640-648

[58.](#body-ref-BIB58 "View in article")

Shelhamer, M ∙ Robinson, D.A ∙ Tan, H.S

**Context-specific gain switching in the human vestibulo–ocular reflex**

*Ann. New York Acad. Sci.* 1991; **656**:889-891

[59.](#body-ref-BIB59 "View in article")

Baker, J.F...

**Simultaneous opposing adaptive changes in cat vestibulo–ocular reflex directions for two body orientations**

*Exp. Brain Res.* 1987; **69**:220-224

[60.](#body-ref-BIB60 "View in article")

Gandolfo, F ∙ Mussa-Ivaldi, F.A ∙ Bizzi, E

**Motor learning by field approximation**

*Proc. Natl. Acad. Sci. U. S. A.* 1996; **93**:3843-3846

[61.](#body-ref-BIB61 "View in article")

Kravitz, J.H ∙ Yaffe, F

**Conditioned adaptation to prismatic displacement with a tone as the conditional stimulus**

*Percept. Psychophys.* 1972; **12**:305-308

[62.](#body-ref-BIB64 "View in article")

Kravitz, J.H

**Conditioned adaptation to prismatic displacement**

*Percept. Psychophys.* 1972; **11**:38-42

[63.](#body-ref-BIB64 "View in article")

Welch, R.B

**Discriminative conditioning of prism adaptation**

*Percept. Psychophys.* 1971; **10**:90-92

[64.](#body-ref-BIB64 "View in article")

Martin, T.A...

**Throwing while looking through prisms: II. Specificity and storage of multiple gaze-throw calibrations**

*Brain.* 1996; **119**:1199-1211

[65.](#body-ref-BIB65 "View in article")

Welch, R.B. (1986) Adaptation of space perception, in *Handbook of Perception and Human Performance* (Vol. 1, Section 24) (Boff, K.R., Kaufman, L. and Thomas, J.P., eds), pp. 24.1–24.45, John Wiley & Sons

[Google Scholar](https://scholar.google.com/scholar?q=Welch%2C+R.B.+%281986%29+Adaptation+of+space+perception%2C+in+Handbook+of+Perception+and+Human+Performance+%28Vol.+1%2C+Section+24%29+%28Boff%2C+K.R.%2C+Kaufman%2C+L.+and+Thomas%2C+J.P.%2C+eds%29%2C+pp.+24.1%E2%80%9324.45%2C+John+Wiley+%26+Sons)

[66.](#body-ref-BIB67 "View in article")

McGonigle, B.O ∙ Flook, J.P

**Long-term retention of single and multistate prismatic adaptation by humans**

*Nature.* 1978; **272**:364-366

[67.](#body-ref-BIB67 "View in article")

Welch, R.B...

**Alternating prism exposure causes dual adaptation and generalization to a novel displacement**

*Percept. Psychophys.* 1993; **54**:195-204

[68.](#body-ref-BIB68 "View in article")

Ghahramani, Z ∙ Wolpert, D.M

**Modular decomposition in visuomotor learning**

*Nature.* 1997; **386**:392-395

[69.](#body-ref-BIB70 "View in article")

Wolpert, D.M. and Kawato, M. Multiple paired forward and inverse models for motor control *Neural Netw*. (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Wolpert%2C+D.M.+and+Kawato%2C+M.+Multiple+paired+forward+and+inverse+models+for+motor+control+Neural+Netw.+%28in+press%29)

[70.](#body-ref-BIB70 "View in article")

Kawato, M. and Wolpert, D.M. Internal models for motor control, in *Sensory Guidance of Movement* (Glickstein, M. and Bock, R., eds), Novartis (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Kawato%2C+M.+and+Wolpert%2C+D.M.+Internal+models+for+motor+control%2C+in+Sensory+Guidance+of+Movement+%28Glickstein%2C+M.+and+Bock%2C+R.%2C+eds%29%2C+Novartis+%28in+press%29)

[71.](#body-ref-BIB71 "View in article")

Kawato, M. (1997) Bidirectional theory approach to consciousness, in *Cognition, Computation and Consciousness* (Ito, M., Miyashita, Y. and Rolls, E.T., eds), pp. 223–248, Oxford University Press

[Google Scholar](https://scholar.google.com/scholar?q=Kawato%2C+M.+%281997%29+Bidirectional+theory+approach+to+consciousness%2C+in+Cognition%2C+Computation+and+Consciousness+%28Ito%2C+M.%2C+Miyashita%2C+Y.+and+Rolls%2C+E.T.%2C+eds%29%2C+pp.+223%E2%80%93248%2C+Oxford+University+Press)

[72.](#body-ref-BIB73-1 "View in article")

Kawano, K. *et al*. (1996) Visual inputs to cerebellar paraflocculus during ocular following responses, in *Extrageniculostriate Mechanisms Underlying Visually-guided Orientation Behavior* (Progress in Brain Research, Vol. 112) (Norita, M., Bando, T. and Stein, B., eds), pp. 415–422, Elsevier

[Google Scholar](https://scholar.google.com/scholar?q=Kawano%2C+K.+et+al.+%281996%29+Visual+inputs+to+cerebellar+paraflocculus+during+ocular+following+responses%2C+in+Extrageniculostriate+Mechanisms+Underlying+Visually-guided+Orientation+Behavior+%28Progress+in+Brain+Research%2C+Vol.+112%29+%28Norita%2C+M.%2C+Bando%2C+T.+and+Stein%2C+B.%2C+eds%29%2C+pp.+415%E2%80%93422%2C+Elsevier)

[73.](#body-ref-BIB73-1 "View in article")

Kawano, K ∙ Shidara, M ∙ Yamane, S

*J. Neurophysiol.* 1992; **67**:680-703

[PubMed](https://pubmed.ncbi.nlm.nih.gov/1578251/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=1578251)

[74.](#body-ref-BIB75 "View in article")

Wolpert, D.M. and Kawato, M. Multiple paired forward and inverse models for motor control *Neural Netw*. (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Wolpert%2C+D.M.+and+Kawato%2C+M.+Multiple+paired+forward+and+inverse+models+for+motor+control+Neural+Netw.+%28in+press%29)

[75.](#body-ref-BIB75 "View in article")

Kawato, M. and Wolpert, D.M. Internal models for motor control, in *Sensory Guidance of Movement* (Glickstein, M. and Bock, R., eds), Novartis (in press)

[Google Scholar](https://scholar.google.com/scholar?q=Kawato%2C+M.+and+Wolpert%2C+D.M.+Internal+models+for+motor+control%2C+in+Sensory+Guidance+of+Movement+%28Glickstein%2C+M.+and+Bock%2C+R.%2C+eds%29%2C+Novartis+%28in+press%29)