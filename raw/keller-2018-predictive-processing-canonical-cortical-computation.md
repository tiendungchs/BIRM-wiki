---
title: "Predictive Processing: A Canonical Cortical Computation"
source: "https://www.cell.com/neuron/fulltext/S0896-6273(18)30857-2"
author:
  - "[[Georg B. Keller]]"
  - "[[Thomas D. Mrsic-Flogel]]"
published:
created: 2026-09-10
description: "In this perspective, Keller and Mrsic-Flogel describe the advantages of predictiveprocessing as a computational framework for understanding cortical function in thecontext of emerging evidence with a focus on sensory processing."
tags:
  - "clippings"
---
## Abstract

This perspective describes predictive processing as a computational framework for understanding cortical function in the context of emerging evidence, with a focus on sensory processing. We discuss how the predictive processing framework may be implemented at the level of cortical circuits and how its implementation could be falsified experimentally. Lastly, we summarize the general implications of predictive processing on cortical function in healthy and diseased states.

Sign in to unlock the full response and ask your own questions.

[Sign in](https://www.cell.com/action/idLogin?type=login&redirectUri=https%3A%2F%2Fwww.cell.com%2Fneuron%2Ffulltext%2FS0896-6273%2818%2930857-2&pii=S0896627318308572)

### Questions you could ask:

- How does sensory experience shape the circuits involved in generating predictions and computing prediction errors?
- How does the predictive processing framework extend the representational framework in understanding cortical function?
- How does increasing stimulus predictability affect neural responses in sensory areas of the cortex?

### Actions you could take:

- Summarize this article

## Main Text

### Introduction

How does the brain distinguish between self-generated and externally generated sensory input? This was the basis of a disagreement between Hermann von Helmholtz and Charles Sherrington over a century ago. The echoes of this exchange enrich our pursuit of understanding the function of the neocortex to this day. Hermann von Helmholtz speculated that the absence of motion perception during eye movements is the result of an efference copy signal that cancels the visual feedback arising from self-generated eye movements (

117.

von Helmholtz, H.

**Handbuch der physiologischen**

*Optik (Stuttg.).* 1867;

[Google Scholar](https://scholar.google.com/scholar?q=H.von+HelmholtzHandbuch+der+physiologischenOptik+%28Stuttg.%291867)

). He argued that when pushing gently on one’s eye, this cancellation does not occur, and we perceive a moving world. Less well known perhaps is the case of a patient with a unilateral traumatic lesion of the lateral rectus muscle that moves the eye temporally. When the patient would close the unaffected eye and attempt to initiate a movement of the affected eye temporally, he would report seeing the world rapidly moving in the direction of intended eye movement (

117.

von Helmholtz, H.

**Handbuch der physiologischen**

*Optik (Stuttg.).* 1867;

[Google Scholar](https://scholar.google.com/scholar?q=H.von+HelmholtzHandbuch+der+physiologischenOptik+%28Stuttg.%291867)

). Thus, the motor command to move the eye could drive perception in absence of any change in visual input. Based on these observations Helmholtz speculated that the brain must have an internal model of the sensory consequences of self-generated movements. He called this the “sense of innervation.” Four decades later, Charles Sherrington revisited these ideas and argued that we have a sensory system in the musculature—the “muscular sense” (proprioception)—that provides direct sensory evidence of the position of our muscles. Based on this, he concluded that a sense of innervation would be an unnecessary assumption (

103.

Sherrington, C.S.

**The Muscular Sense**

Sharpey-Schäfer, E.A. (Editor)

**Textbook of Physiology**

Edinburgh, London, 1900; 1002-1025

[Google Scholar](https://scholar.google.com/scholar?q=C.S.SherringtonThe+Muscular+SenseE.A.Sharpey-Sch%C3%A4ferTextbook+of+Physiology1900EdinburghLondon10021025)

). Sherrington’s reliance on bottom-up-driven sensory computations would extend to one of his most influential concepts—the receptive field—paving the way for a view of the brain that is driven to move by its sensorium. Sherrington’s views of a nervous system built upon sensory-driven receptive fields would flourish over the next several decades. Describing the responses of ganglion cells in the frog’s retina to small black spots, Horace Barlow argued that it is hard to avoid the conclusion that these neurons function as fly detectors (

4.

Barlow, H.B.

**Summation and inhibition in the frog’s retina**

*J. Physiol.* 1953; **119**:69-88

[Crossref](https://doi.org/10.1113/jphysiol.1953.sp004829)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/13035718/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1113%2Fjphysiol.1953.sp004829&pmid=13035718)

). Born was the concept of the feature detector, the postulate that the activity of neurons in sensory pathways is driven primarily by feed-forward sensory input and represents the presence of a feature or an object in the environment. The effects of this revolutionary idea are still apparent in most of our thinking of brain function. With the discovery of the simple cells in cat primary visual cortex (

42.

Hubel, D.H. ∙ Wiesel, T.N.

**Receptive fields of single neurones in the cat’s striate cortex**

*J. Physiol.* 1959; **148**:574-591

), the feature detector rapidly became the dominant narrative for our thinking about cortical function (

72.

Martin, K.A.C.

**A brief history of the “feature detector”**

*Cereb. Cortex.* 1994; **4**:1-7

). This concept has been a guiding principle for scientific inquiry; it is apparent not only in the concept of receptive fields of neurons in visual cortex, but also in place cells (

78.

O’Keefe, J. ∙ Dostrovsky, J.

**The hippocampus as a spatial map. Preliminary evidence from unit activity in the freely-moving rat**

*Brain Res.* 1971; **34**:171-175

), grid cells (

34.

Hafting, T. ∙ Fyhn, M. ∙ Molden, S....

**Microstructure of a spatial map in the entorhinal cortex**

*Nature.* 2005; **436**:801-806

), face cells (

83.

Perrett, D.I. ∙ Rolls, E.T. ∙ Caan, W.

**Visual neurones responsive to faces in the monkey temporal cortex**

*Exp. Brain Res.* 1982; **47**:329-342

[Crossref](https://doi.org/10.1007/BF00239352)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7128705/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1007%2FBF00239352&pmid=7128705)

), and concept cells (

89.

Quiroga, R.Q. ∙ Reddy, L. ∙ Kreiman, G....

**Invariant visual representation by single neurons in the human brain**

*Nature.* 2005; **435**:1102-1107

). Once sensory systems of the brain have extracted an invariant representation from the sensory input, a separate part of the brain is then tasked with deciding and acting upon that representation. Following David Marr, we will call this the representational framework for describing the function of neocortex (

71.

Marr, D.

**Vision**

MIT Press, 1982

[Google Scholar](https://scholar.google.com/scholar?q=D.MarrVision1982MIT+Press)

).

In parallel, the ideas of Helmholtz would resurface in the work of Erich von Holst, Horst Mittelstaedt (

118.

von Holst, E. ∙ Mittelstaedt, H.

**Das Reafferenzprinzip**

*Naturwissenschaften.* 1950; **37**:464-476

), and Roger Sperry (

107.

Sperry, R.W.

**Neural basis of the spontaneous optokinetic response produced by visual inversion**

*J. Comp. Physiol. Psychol.* 1950; **43**:482-489

). They were unsatisfied with an account of perception driven bottom-up by sensory input because it failed to explain how animals distinguish self-generated sensory feedback from externally generated input. One prominent example they used to illustrate that the brain must be able to make this distinction is the fact that the optokinetic reflex does not prevent self-motion of the eye. During passive viewing, full-field visual flow results in a movement of the eye that stabilizes the image on the retina; this is called the optokinetic reflex. If the animal could not distinguish between self-generated and externally generated visual input, then the optokinetic reflex would prevent any active movement of the eye. The argument is that the visual flow resulting from an eye movement would trigger the optokinetic reflex just as visual flow during passive viewing does and thus would result in a reflexive eye movement that counteracts the original eye movement. They concluded that one simple strategy to solve this problem of distinguishing self-generated sensory feedback from externally generated input in general would be to cancel the predictable consequences of self-generated sensory feedback using an efference copy of a motor command. This requires that the brain has a mechanism to transform the efference copy of the motor command into the sensory coordinate system to cancel the reafferent sensory feedback. This transformed version of the efference copy is often referred to as a corollary discharge. Conceputally, such transformations, or internal models, are equivalent to a simulation of the external world and function to make predictions of sensory input. Kenneth Craik formulated this idea in the early 1940s as: “My hypothesis then is that thought models, or parallels, reality—that its essential feature is not ‘the mind’, ‘the self’, ‘sense-data’, nor propositions but symbolism, and that this symbolism is largely of the same kind as that which is familiar to us in mechanical devices which aid thought and calculation” (

14.

Craik, K.J.

**The Nature of Explanation**

Cambridge University Press London, 1943

[Google Scholar](https://scholar.google.com/scholar?q=K.J.CraikThe+Nature+of+Explanation1943Cambridge+University+Press+London)

).

The mapping of the motor command onto the sensory consequences of the movement functions to simulate the environment and thus *is* the internal model of the world. The idea that the brain uses an internal model to predict sensory input based on movements and past sensory experience has been formalized in several different variants: predictive coding, hierarchical temporal memory, and Bayesian inference (

26.

Friston, K.

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2005; **360**:815-836

38.

Hawkins, J. ∙ Blakeslee, S.

**On intelligence**

Times Books, 2004

[Google Scholar](https://scholar.google.com/scholar?q=J.HawkinsS.BlakesleeOn+intelligence2004Times+Books)

56.

Körding, K.P. ∙ Wolpert, D.M.

**Bayesian integration in sensorimotor learning**

*Nature.* 2004; **427**:244-247

90.

Rao, R.P.N. ∙ Ballard, D.H.

**Predictive coding in the visual cortex: a functional interpretation of some extra-classical receptive-field effects**

*Nat. Neurosci.* 1999; **2**:79-87

108.

Spratling, M.W.

**Predictive coding as a model of response properties in cortical area V1**

*J. Neurosci.* 2010; **30**:3531-3543

). All of these are based around the idea of a generative model of the world used to predict sensory input. Following Andy Clark (

11.

Clark, A.

**Surfing uncertainty: prediction, action, and the embodied mind**

Oxford University Press, 2016

[Crossref](https://doi.org/10.1093/acprof:oso/9780190217013.001.0001)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1093%2Facprof%3Aoso%2F9780190217013.001.0001)

), we will refer to this family of theories as the predictive processing framework. Of note, we do not wish to diminish the importance of the discrepancies between the different theories we are grouping here (see, e.g.,

109.

Spratling, M.W.

**A review of predictive coding algorithms**

*Brain Cogn.* 2017; **112**:92-97

for a review of different variants of predictive coding), but will focus on their common premise. Here, we will focus on aspects of predictive processing that are based on a comparison of sensory input with a generative model of the environment. Our aim is to discuss the physiological evidence that has convinced us that the predictive processing framework is more consistent with the data than the representational framework (see, e.g.,

71.

Marr, D.

**Vision**

MIT Press, 1982

[Google Scholar](https://scholar.google.com/scholar?q=D.MarrVision1982MIT+Press)

and

72.

Martin, K.A.C.

**A brief history of the “feature detector”**

*Cereb. Cortex.* 1994; **4**:1-7

for discussions of the representational framework).

Predictive processing as a conceptual framework for understanding brain has a long tradition in the fields of computational and cognitive neuroscience and has been elegantly summarized elsewhere (

10.

Clark, A.

**Whatever next? Predictive brains, situated agents, and the future of cognitive science**

*Behav. Brain Sci.* 2013; **36**:181-204

57.

Koster-Hale, J. ∙ Saxe, R.

**Theory of mind: a neural prediction problem**

*Neuron.* 2013; **79**:836-848

). The principle of a comparison between predicted and actual feedback is also often used to model the function of the cerebellum (

122.

Wolpert, D.M. ∙ Miall, R.C. ∙ Kawato, M.

**Internal models in the cerebellum**

*Trends Cogn. Sci.* 1998; **2**:338-347

) and the dopaminergic reward system (

101.

Schultz, W. ∙ Dayan, P. ∙ Montague, P.R.

**A neural substrate of prediction and reward**

*Science.* 1997; **275**:1593-1599

). Surprisingly, however, predictive processing in the neocortex has received little attention at the physiological level. This is in part due to the difficulty of designing experiments that can effectively disambiguate between the neuronal activity associated with bottom-up representation and that associated with predictive processing hypotheses, and it is in part because we have poor experimental access to internal models or control over the associated predictions. In this perspective, we argue that existing data about neural activity and neural circuit organization of the (sensory) cortex can be understood in the context of a predictive processing framework, and we highlight recent direct evidence in support. We then discuss how computations required for predictive processing might be implemented at the circuit level and propose experiments that would provide a mechanistic corroboration.

### Theoretical Framework for Predictive Processing

#### Prediction-Error Neurons and Internal Representation Neurons

At the core of all predictive processing theories is the idea that the brain develops a generative model of the world that it uses to predict sensory input (

5.

Barlow, H.B.

**Possible principles underlying the transformations of sensory messages**

Rosenblith, W. (Editor)

**Sensory Communication**

MIT Press, 1961; 217-234

[Google Scholar](https://scholar.google.com/scholar?q=H.B.BarlowPossible+principles+underlying+the+transformations+of+sensory+messagesW.RosenblithSensory+Communication1961MIT+Press217234)

14.

Craik, K.J.

**The Nature of Explanation**

Cambridge University Press London, 1943

[Google Scholar](https://scholar.google.com/scholar?q=K.J.CraikThe+Nature+of+Explanation1943Cambridge+University+Press+London)

32.

Gregory, R.L.

**Perceptions as hypotheses**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 1980; **290**:181-197

[Crossref](https://doi.org/10.1098/rstb.1980.0090)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/6106237/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1098%2Frstb.1980.0090&pmid=6106237)

). The comparison of predicted and actual sensory input then updates an internal representation of the world. This process is often described as a processing hierarchy. A brain area at a higher level of the hierarchy sends a top-down signal to an area at lower level in the form of a prediction of the bottom-up input to that area. Predictions are compared to bottom-up input to compute the difference between the two ([Figures 1](#fig1) A and 1B). This requires at least two functional classes of neurons: an internal representation neuron and a comparator or prediction-error neuron. Internal representation neurons project downward in the neural hierarchy and encode predictions about the bottom-up input. Prediction-error neurons project upward in the hierarchy and encode a difference between prediction and bottom-up input. Thus, in the lowest level of the hierarchy the bottom-up input is the sensory input, while in higher levels of the hierarchy it is the prediction errors from lower levels. When the bottom-up information matches the information carried by internal representation neurons, the responses in prediction-error neurons decrease. In sensory cortex, both internal representation neurons and prediction-error neurons are expected to be selective for specific stimulus features.

![](https://www.cell.com/cms/10.1016/j.neuron.2018.10.003/asset/63f5def1-d0ef-4642-b3c9-3e051da81be7/main.assets/gr1_lrg.jpg)

Figure 1 Inter-Areal Communication

Prediction errors may come in two flavors. The bottom-up input can be stronger than predicted (for example, when an unpredicted stimulus appears) or it can be weaker than predicted (for example, when the expected stimulus does not appear or a stimulus disappears). In theory, a bidirectional change could be signaled by one neuron that has a sufficiently high basal firing rate. Increases in activity could signal more input than predicted, while a decrease could signal less input than predicted. Such a bidirectional modulation of a prediction-error signal has been observed in the dopaminergic system (

101.

Schultz, W. ∙ Dayan, P. ∙ Montague, P.R.

**A neural substrate of prediction and reward**

*Science.* 1997; **275**:1593-1599

). In the neocortex, and particularly in layer 2/3, the baseline firing rates of principal neurons are much lower (

18.

de Kock, C.P.J. ∙ Bruno, R.M. ∙ Spors, H....

**Layer- and cell-type-specific suprathreshold stimulus representation in rat primary somatosensory cortex**

*J. Physiol.* 2007; **581**:139-154

76.

Niell, C.M. ∙ Stryker, M.P.

**Highly selective receptive fields in mouse visual cortex**

*J. Neurosci.* 2008; **28**:7520-7536

96.

Sakata, S. ∙ Harris, K.D.

**Laminar structure of spontaneous and sensory-evoked population activity in auditory cortex**

*Neuron.* 2009; **64**:404-418

) and bidirectional modulation of activity is less plausible. In agreement with previous suggestions (

90.

Rao, R.P.N. ∙ Ballard, D.H.

**Predictive coding in the visual cortex: a functional interpretation of some extra-classical receptive-field effects**

*Nat. Neurosci.* 1999; **2**:79-87

), we think it is more likely that the error computation is carried out by two separate prediction-error circuits: one to signal more and one to signal less input than predicted ([Figure 2](#fig2)). We will refer to these two types of prediction error as positive prediction error and negative prediction error.

![](https://www.cell.com/cms/10.1016/j.neuron.2018.10.003/asset/4d8fc0a8-373d-4e3e-a373-2a4e45d39ee8/main.assets/gr2_lrg.jpg)

Figure 2 Schematic of the Canonical Microcircuit for Predictive Processing

In the predictive processing framework, predictions that arrive in a target area are based on an internal representation in the source area. To illustrate this, assume two hypothetical visual areas: one coding for geometric shapes and the other for edges. If the internal representation of a triangle is active in the geometric shape area, it will send a prediction of three edges to the edge area. Prediction-error neurons will be activated only if the bottom-up input does not match the top-down prediction. In absence of prediction errors, the internal representation for edges in the edge area and the internal representation for the triangle in the geometric shape area will remain active. These internal representations (of the triangle in the geometric shape area and edges in the edge area) are equivalent to those postulated by the representation framework. The key difference lies in how the internal representations are updated: in the representation framework through feature detectors and bottom-up drive and in predictive processing through a comparison between bottom-up input and top-down predictions based on an internal representation.

A common assumption is that predictive processing is advantageous because it is efficient; fewer spikes are necessary because only prediction errors are transmitted up the hierarchy. While prediction-error signals are sparser when input is predictable, for every bottom-up spike cancelled there needs to be a spike in a top-down prediction. In a first approximation, this means that the total number of spikes (bottom-up and top-down) remains unchanged. Hence, although there are circumstances under which predictive processing can be more efficient, in cortex this is likely not the case if efficiency is measured as the number of spikes per bit of information transmitted. We propose that the main advantage of predictive processing is that the internal representation is updated by a combination of bottom-up and top-down input and can thus be modified in absence of bottom-up input. This would provide a framework to simulate and predict the environment.

#### Coordinate Transformations across Cortical Areas (Internal Models)

Cerebral cortex is a network of interconnected areas that are distinguishable by their connections to the sensory input and motor output streams and by their connections to each other. We refer to the part of cortex that is the principal target of the afferents from primary sensory thalamus as primary sensory cortex. By virtue of its connectivity to the periphery, each cortical area has a unique basis for the representation of body and environment. We refer to this basis of representation as the area’s coordinate system. The coordinate system of visual cortex, for example, appears to be built on Gabor filters of the visual input (such as the receptive field of simple cells), and that of auditory cortex is built on spectro-temporal filters of the auditory input. In motor cortex, the coordinate system is built on motor commands, and in inferotemporal cortex, possibly on objects or concepts (

89.

Quiroga, R.Q. ∙ Reddy, L. ∙ Kreiman, G....

**Invariant visual representation by single neurons in the human brain**

*Nature.* 2005; **435**:1102-1107

). Each coordinate system only spans part of the total space of all sensory input and motor output. The transformation from one coordinate system to another is referred to as an internal model. For instance, given a current motor state and visual input, an efference copy of a motor command can be transformed to a prediction of the corresponding consequences in visual input. The motor command for an eye movement to the left can be transformed to the corresponding shift of the visual image to the right. The transformation from a motor coordinate system to a sensory coordinate system is referred to as a forward model, while a transformation from a sensory coordinate system to a motor coordinate system is referred to as an inverse model (

45.

Jordan, M.I. ∙ Rumelhart, D.E.

**Forward Models: Supervised Learning with a Distal Teacher**

*Cogn. Sci.* 1992; **16**:307-354

[Crossref](https://doi.org/10.1207/s15516709cog1603_1)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1207%2Fs15516709cog1603_1)

121.

Wolpert, D. ∙ Ghahramani, Z. ∙ Jordan, M.

**An internal model for sensorimotor integration**

*Science.* 1995; **269** (80-.):1880-1882

) ([Figure 1](#fig1) C). More generally, any communication between two cortical areas will require a transformation that describes how activity in the source area relates to activity in the target area. If such a transformation between two areas exists, activity in one area can serve as a prediction of bottom-up input in the other area. Although cortical processing can be hierarchical, especially in the vicinity of primary sensory areas, cortex as a whole is likely not arranged as a hierarchy (

29.

Gămănuţ, R. ∙ Kennedy, H. ∙ Toroczkai, Z....

**The Mouse Cortical Connectome, Characterized by an Ultra-Dense Cortical Graph, Maintains Specificity by Distinct Connectivity Profiles**

*Neuron.* 2018; **97**:698-715.e10

). Given that there are systematic correlations between auditory and visual inputs, for example, activity in an auditory area could serve as a prediction of bottom-up input in a visual area and vice versa. Thus, predictive processing does not have to follow a strict hierarchical arrangement of inter-areal connections ([Figure 1](#fig1) D). Interestingly, a model that has been proposed recently as an alternative to hierarchical predictive processing is a variant of a predictive processing architecture in which the flow of signals is reversed, predictions are sent up the hierarchy, and errors are sent down the hierarchy (

39.

Heeger, D.J.

**Theory of cortical function**

*Proc. Natl. Acad. Sci. USA.* 2017; **114**:1773-1782

). In the absence of a strict hierarchy, the communication between areas would always entail the exchange of predictions and errors in both directions.

#### Experimental Considerations

When evaluating evidence that may distinguish the two alternative descriptions of cortical function, it is worth noting that the predictive processing framework is an extension of the representational framework. To illustrate this, we will make a few simplifying assumptions. In the representational framework, the response *R* of a neuron can be modeled as a function *V* of the bottom-up input.

(1)

This function can be arbitrarily complex and, in the case of visual or auditory receptive fields, is in the form of a convolution with a receptive field. The predictive processing framework differs to this in that, in addition to internal representation neurons, it postulates the existence of prediction-error neurons. The response of prediction-error neurons is the difference between a function *V* that depends on the bottom-up input and a function *P* that depends on the top-down input—or, more specifically, the prediction of the bottom-up input *V*.

(2)

For simplicity, we have ignored multiplicative gains of response magnitude, which can be incorporated in both frameworks. The reason the two response types are hard to distinguish is that experimentalists have some control over the bottom-up input—at least in sensory areas of the brain—but have only poor control of the top-down input or predictions generated on a moment-by-moment basis. If experiments are performed by averaging data over many trials, for each of which the top-down input may vary, or experiments are performed under conditions in which top-down input is altered or gated off (e.g., by anesthesia), *P* reduces to a constant and (2) can be written in the form of (1). With the prediction error driven just by the stimulus, the internal representation will be updated by bottom-up input and will look like the one postulated by the representation framework ([Figure 2](#fig2)). Under these conditions, both internal representation neurons and positive prediction-error neurons will have responses identical to the ones predicted by the representational framework. Thus, to design experiments that could distinguish between the two frameworks, experimentalists must be able to control or measure the prediction. Typically, this is not possible, and instead a proxy is used for the animal’s predictions. In the context of sensory processing, self-generated motion is one possible proxy for a prediction of the resulting visual feedback (e.g., optic flow). This assumes that animals learn how sensory feedback couples to movement with experience. In a first approximation, the representational framework predicts that neuronal responses will not differ in conditions when the stimulus is externally generated versus when it is the consequence of self-motion. The predictive processing framework instead postulates that responses in a subset of neurons, the prediction-error neurons, signal a deviation, or a mismatch, between predicted and actual sensory input. Based on this argument, much of the experimental focus in the effort to test the hypothesis of predictive processing in cortex was on prediction-error responses. In the next section, we will summarize the evidence for cortical responses that are consistent with predictive processing.

### Evidence for Predictive Processing in Cortical Circuits

#### Behavioral Evidence

The idea that our perception of the world is an active and constructive process has an intuitive appeal to explain much of our everyday experience of the world. Our predictions frequently interfere with what we perceive. Our voice sounds eerily different when we hear it in a recording, and we perceive our own singing to be much closer to pitch than it actually is. In visual illusions, we see color where there is none, simply because we know objects rarely change color (

25.

Foster, D.H.

**Color constancy**

*Vision Res.* 2011; **51**:674-700

), or miss things that happen right in front of our eyes (

104.

Simons, D.J. ∙ Chabris, C.F.

**Gorillas in our midst: sustained inattentional blindness for dynamic events**

*Perception.* 1999; **28**:1059-1074

[Crossref](https://doi.org/10.1068/p2952)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/10694957/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1068%2Fp2952&pmid=10694957)

). In these cases, what we expect to hear or see interferes with, and even supersedes, what we actually hear and see. We refer to the conditions in which we can prove that our predictions interfere with perception as sensory illusions. Given our frequent disagreements with others over the attributes of objects we see, or over what we hear, it is probably appropriate to describe perception as a controlled hallucination (

11.

Clark, A.

**Surfing uncertainty: prediction, action, and the embodied mind**

Oxford University Press, 2016

[Crossref](https://doi.org/10.1093/acprof:oso/9780190217013.001.0001)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1093%2Facprof%3Aoso%2F9780190217013.001.0001)

). This tainting of our access to reality must come at some advantage. One advantage of having an internal model of the world is to allow us to predict the future. We cannot only anticipate the sensory consequences of our own movements, but also physical attributes or dynamics of objects and other agents in the world. You can look at a photograph of a football player - one leg on the ground in front of the player, the other retracted behind the ball – and know instantly and without deliberation what will happen next. Often such predictions are not trivial and depend on detailed knowledge about the physical properties of the objects we are looking at, our model of the intentions or actions of the agents, and their context in the particular moment. These examples, and many others like it, give intuitive support for the idea that the brain is a predictive processing machine. In this section, we highlight the physiological evidence for predictive processing in neural circuits of the sensory neocortex.

#### Prediction-Error Signals

In neocortex, early evidence for the predictive processing framework did not arise with new data, but from the demonstration that classical visual phenomena, like end-stopping (

43.

Hubel, D.H. ∙ Wiesel, T.N.

**Receptive fields and functional architecture in two nonstriate visual areas (18 and 19) of the cat**

*J. Neurophysiol.* 1965; **28**:229-289

), can be explained as a prediction error (

90.

Rao, R.P.N. ∙ Ballard, D.H.

**Predictive coding in the visual cortex: a functional interpretation of some extra-classical receptive-field effects**

*Nat. Neurosci.* 1999; **2**:79-87

). One central idea here was that the suppression of the response that appears when a stimulus extends into the surround of the classical receptive field is the consequence of top-down inhibition. In this way, the stimulus in a given location acts as a prediction of the stimulus in the neighboring region. This prediction, relayed via activation of a higher-level representation, inhibits responses of neurons with receptive fields in neighboring parts of the visual field to the same stimulus. In layer 2/3 of mouse visual cortex, somatostatin-positive interneurons, likely driven by lateral projections from neighboring cortical neurons, have been shown to have a causal role in surround suppression (

1.

Adesnik, H. ∙ Bruns, W. ∙ Taniguchi, H....

**A neural circuit for spatial summation in visual cortex**

*Nature.* 2012; **490**:226-231

2.

Angelucci, A. ∙ Bijanzadeh, M. ∙ Nurminen, L....

**Circuits and Mechanisms for Surround Modulation in Visual Cortex**

*Annu. Rev. Neurosci.* 2017; **40**:425-451

). The idea of a top-down prediction that acts to inhibit bottom-up input was later used to demonstrate that a large variety of classical visual receptive field properties can be explained in a predictive processing framework (

108.

Spratling, M.W.

**Predictive coding as a model of response properties in cortical area V1**

*J. Neurosci.* 2010; **30**:3531-3543

). This type of comparison is consistent with a positive prediction error: the top-down prediction acts to inhibit the predictable bottom-up input. A top-down prediction that functions to inhibit bottom-up input should result in a response decrease when stimuli become predictable. This is indeed the case when stimuli become predictable, either as the result of a learned association with a preceding stimulus () or after frequent presentation of the same stimulus, in which case the suppression is often described as sensory adaptation (

114.

Ulanovsky, N. ∙ Las, L. ∙ Nelken, I.

**Processing of low-probability sounds by cortical neurons**

*Nat. Neurosci.* 2003; **6**:391-398

). Another simple form of increased predictability of a stimulus is prolonged presentation of the same stimulus, during which sensory responses typically decrease in magnitude. This form of sensory adaptation occurs at many levels in the sensory processing hierarchy, but certain forms, like contrast adaptation in visual cortex, are thought to be, at least in part, cortical in origin (

8.

Carandini, M.

**Visual cortex: Fatigue and adaptation**

*Curr. Biol.* 2000; **10**:R605-R607

51.

Keller, A.J. ∙ Houlton, R. ∙ Kampa, B.M....

**Stimulus relevance modulates contrast adaptation in visual cortex**

*eLife.* 2017; **6**:e21589

66.

Maffei, L. ∙ Fiorentini, A. ∙ Bisti, S.

**Neural correlate of perceptual adaptation to gratings**

*Science.* 1973; **182**:1036-1038

[Crossref](https://doi.org/10.1126/science.182.4116.1036)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/4748674/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1126%2Fscience.182.4116.1036&pmid=4748674)

). Although adaptation would be consistent with top-down inhibition, early experiments studying mechanisms of contrast adaptation using intracellular recordings in visual cortex of anesthetized animals found no evidence of inhibition contributing to contrast adaptation (

9.

Carandini, M. ∙ Ferster, D.

**A tonic hyperpolarization underlying contrast adaptation in cat visual cortex**

*Science.* 1997; **276**:949-952

). More recently, it was found that levels of inhibition increase with stimulus duration (

49.

Keller, A.J. ∙ Martin, K.A.C.

**Local Circuits for Contrast Normalization and Adaptation Investigated with Two-Photon Imaging in Cat Primary Visual Cortex**

*J. Neurosci.* 2015; **35**:10078-10087

[Crossref](https://doi.org/10.1523/JNEUROSCI.0906-15.2015)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/26157005/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1523%2FJNEUROSCI.0906-15.2015&pmid=26157005)

) and are selectively suppressed by anesthesia (). Consistent with a strong top-down influence, contrast adaptation has been shown to depend on the behavioral relevance of a stimulus (

51.

Keller, A.J. ∙ Houlton, R. ∙ Kampa, B.M....

**Stimulus relevance modulates contrast adaptation in visual cortex**

*eLife.* 2017; **6**:e21589

). Hence, it is possible that certain forms of sensory adaptation in the awake animal are driven by top-down inhibition.

Similarly, there may be top-down inhibition of the sensory consequences of self-generated movement. There is evidence for this in auditory cortex, where responses are generally supressed during self-generated locomotion via top-down projection that recruits local inhibition (

100.

Schneider, D.M. ∙ Nelson, A. ∙ Mooney, R.

**A synaptic and circuit basis for corollary discharge in the auditory cortex**

*Nature.* 2014; **513**:189-194

). Consistent with the idea that the effect of these top-down predictions can be modulated in a context-dependent manner, certain forms of response adaptation in visual cortex have been shown to be dependent on the task relevance of the stimulus (

51.

Keller, A.J. ∙ Houlton, R. ∙ Kampa, B.M....

**Stimulus relevance modulates contrast adaptation in visual cortex**

*eLife.* 2017; **6**:e21589

).

If increasing stimulus predictability results in a response reduction, a violation of a strong prediction should trigger a response increase. Evidence in support comes from the discovery of prediction-error signals in primary sensory areas of cortex, where responses were quantified to unexpected changes in the coupling between self-generated movements and sensory feedback. Using manipulations of visual feedback from hand movements, work in humans found a selective activation of primary visual cortex to incongruences between hand movements and visual feedback that could not be explained by the visual input alone (

110.

Stanley, J., and Miall, R.C. (2007). Functional activation in parieto-premotor and visual areas dependent on congruency between hand movement and visual stimuli during motor-visual priming. *34*, 290–299.

[Google Scholar](https://scholar.google.com/scholar?q=Stanley%2C+J.%2C+and+Miall%2C+R.C.+%282007%29.+Functional+activation+in+parieto-premotor+and+visual+areas+dependent+on+congruency+between+hand+movement+and+visual+stimuli+during+motor-visual+priming.+34%2C+290%E2%80%93299.)

). Manipulating auditory feedback of self-generated vocalizations in marmosets revealed responses in primary auditory cortex that were selective to deviations between expected and actual auditory feedback (

21.

Eliades, S.J. ∙ Wang, X.

**Neural substrates of vocalization feedback monitoring in primate auditory cortex**

*Nature.* 2008; **453**:1102-1106

). Similar observations were made in primary auditory pallium of the songbird (

48.

Keller, G.B. ∙ Hahnloser, R.H.R.

**Neural processing of auditory feedback during vocal practice in a songbird**

*Nature.* 2009; **457**:187-190

). These responses could not be explained by the change in sensory input, as they were only apparent during manipulations of self-generated feedback and not when the animal was passively observing or hearing the same stimulus. However, in all of these experiments, the responses were triggered by an unexpected change to sensory feedback in the form of an additional stimulus that differed from the one expected. The key signal that is more difficult to explain in a representation framework is a response to the absence of a predicted sensory input or a negative prediction error. Such signals have been found in layer 2/3 of primary visual cortex (V1) of the mouse, where a subset of neurons responds selectively to the absence of expected visual flow (

50.

Keller, G.B. ∙ Bonhoeffer, T. ∙ Hübener, M.

**Sensorimotor mismatch signals in primary visual cortex of the behaving mouse**

*Neuron.* 2012; **74**:809-815

) or the absence of an expected visual stimulus (

23.

Fiser, A. ∙ Mahringer, D. ∙ Oyibo, H.K....

**Experience-dependent spatial expectations in mouse visual cortex**

*Nat. Neurosci.* 2016; **19**:1658-1664

[Crossref](https://doi.org/10.1038/nn.4385)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/27618309/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2Fnn.4385&pmid=27618309)

). We have referred to this type of negative prediction error as a mismatch response. Although mismatch responses also exist in layer 5 neurons, they are likely more prevalent in layer 2/3 (

97.

Saleem, A.B. ∙ Ayaz, A. ∙ Jeffery, K.J....

**Integration of visual motion and locomotion in mouse visual cortex**

*Nat. Neurosci.* 2013; **16**:1864-1869

).

In the predictive processing framework, prediction-error signals in sensory cortices are expected to be feature-specific and not simply the result of a surprise response. That is, they should signal the type of deviation from prediction and not simply the fact that there was a deviation. Accordingly, responses of mismatch neurons in layer 2/3 of mouse V1 were found to signal deviations between predicted and actual visual flow in spatially confined areas of the visual field (

128.

Zmarz, P. ∙ Keller, G.B.

**Mismatch Receptive Fields in Mouse Visual Cortex**

*Neuron.* 2016; **92**:766-772

). These mismatch signals parallel visual signals in magnitude, spatial resolution and retinotopic organization, suggesting that mismatch signals are computed based on local visual cues and that visual and mismatch signals are separate aspects of the same computation.

#### Circuits for Predictive Processing

Observing prediction-error signals in the neocortex does not prove they are computed therein. However, if cortical circuits do implement predictive processing, this requires at least three components: a comparator circuit that computes the prediction error between bottom-up input and predictions, a circuit to maintain an internal representation that gives rise to predictions, and a modulating or gating signal that sets the precision or weight of the prediction error. The circuit elements required to generate prediction errors are present in each module of the neocortex. Cortical areas receive bottom-up input from the thalamus or other cortical areas as well as extensive top-down inputs from many nearby and distal cortical areas and higher-order thalamic nuclei (

22.

Felleman, D.J. ∙ Van Essen, D.C.

**Distributed hierarchical processing in the primate cerebral cortex**

*Cereb. Cortex.* 1991; **1**:1-47

[Crossref](https://doi.org/10.1093/cercor/1.1.1)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/1822724/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1093%2Fcercor%2F1.1.1&pmid=1822724)

70.

Markov, N.T. ∙ Vezoli, J. ∙ Chameau, P....

**Anatomy of hierarchy: feedforward and feedback pathways in macaque visual cortex**

*J. Comp. Neurol.* 2014; **522**:225-259

79.

Oh, S.W. ∙ Harris, J.A. ∙ Ng, L....

**A mesoscale connectome of the mouse brain**

*Nature.* 2014; **508**:207-214

102.

Sherman, S.M.

**Thalamus plays a central role in ongoing cortical functioning**

*Nat. Neurosci.* 2016; **19**:533-541

127.

Zingg, B. ∙ Hintiryan, H. ∙ Gou, L....

**Neural networks of the mouse neocortex**

*Cell.* 2014; **156**:1096-1111

), consistent with predictions from multiple modalities. The top-down inputs can be very dense—as, for instance, the top-down input from anterior cingulate cortex to V1 (

126.

Zhang, S. ∙ Xu, M. ∙ Kamigaki, T....

**Selective attention. Long-range and local circuits for top-down modulation of visual cortex processing**

*Science.* 2014; **345**:660-665

)—and target both excitatory and inhibitory neurons in layer 2/3 monosynaptically (

62.

Leinweber, M. ∙ Ward, D.R. ∙ Sobczak, J.M....

**A Sensorimotor Circuit in Mouse Cortex for Visual Flow Predictions**

*Neuron.* 2017; **95**:1420-1432.e5

69.

Mao, T. ∙ Kusefoglu, D. ∙ Hooks, B.M....

**Long-range neuronal circuits underlying the interaction between sensory and motor cortex**

*Neuron.* 2011; **72**:111-123

124.

Yang, W. ∙ Carrasquillo, Y. ∙ Hooks, B.M....

**Distinct balance of excitation and inhibition in an interareal feedforward and feedback circuit of mouse visual cortex**

*J. Neurosci.* 2013; **33**:17373-17384

126.

Zhang, S. ∙ Xu, M. ∙ Kamigaki, T....

**Selective attention. Long-range and local circuits for top-down modulation of visual cortex processing**

*Science.* 2014; **345**:660-665

). The comparator circuits that generate negative and positive prediction errors require differential wiring of bottom-up and top-down inputs onto subsets of excitatory and inhibitory neurons. Negative prediction-error neurons will respond when top-down excitation exceeds bottom-up inhibition (whereby increasing strength or saliency in predictions should result in increasing strength of mismatch). It follows that subsets of inhibitory neurons are mainly bottom-up driven, either directly or via local excitatory relays, and that these provide input preferentially to negative prediction-error neurons. In layer 2/3 of visual cortex, a subset of somatostatin-expressing interneurons are thought to provide visually driven inhibition to negative prediction-error neurons (

3.

Attinger, A. ∙ Wang, B. ∙ Keller, G.B.

**Visuomotor Coupling Shapes the Functional Development of Mouse Visual Cortex**

*Cell.* 2017; **169**:1291-1302.e14

). Conversely, positive prediction-error neurons will respond when bottom-up excitation exceeds top-down inhibition. Accordingly, a different set of interneurons is expected to be driven more strongly by top-down input and provide inhibition to positive prediction-error neurons. This form of top-down inhibition is a frequent circuit motif in cortex (

61.

Lee, S. ∙ Kruglikov, I. ∙ Huang, Z.J....

**A disinhibitory circuit mediates motor integration in the somatosensory cortex**

*Nat. Neurosci.* 2013; **16**:1662-1670

100.

Schneider, D.M. ∙ Nelson, A. ∙ Mooney, R.

**A synaptic and circuit basis for corollary discharge in the auditory cortex**

*Nature.* 2014; **513**:189-194

126.

Zhang, S. ∙ Xu, M. ∙ Kamigaki, T....

**Selective attention. Long-range and local circuits for top-down modulation of visual cortex processing**

*Science.* 2014; **345**:660-665

).

Finally, we suggest that negative and positive prediction-error neurons exert opposite effects on their targets. Negative prediction errors should act mainly by engaging bottom-up inhibition in their target areas, thus suppressing the current internal representation. Conversely, positive prediction-error neurons provide bottom-up excitation to target areas, thus activating a new cohort of neurons. The combined effect of positive and negative prediction-error neurons is to update the internal representation that best approximates, or predicts, the current environment.

#### Top-Down Signals Are Predictions

With the discovery of strong motor-related signals in primary visual cortex in the complete absence of visual input (

47.

Keck, T. ∙ Keller, G.B. ∙ Jacobsen, R.I....

**Synaptic scaling and homeostatic plasticity in the mouse visual cortex in vivo**

*Neuron.* 2013; **80**:327-334

50.

Keller, G.B. ∙ Bonhoeffer, T. ∙ Hübener, M.

**Sensorimotor mismatch signals in primary visual cortex of the behaving mouse**

*Neuron.* 2012; **74**:809-815

97.

Saleem, A.B. ∙ Ayaz, A. ∙ Jeffery, K.J....

**Integration of visual motion and locomotion in mouse visual cortex**

*Nat. Neurosci.* 2013; **16**:1864-1869

) came further evidence that a representational framework could explain only a fraction of the responses, even in primary sensory areas. Modulation of visual responses by locomotion or arousal () is thought to be the consequence of neuromodulatory inputs (

28.

Fu, Y. ∙ Tucciarone, J.M. ∙ Espinosa, J.S....

**A cortical circuit for gain control by behavioral state**

*Cell.* 2014; **156**:1139-1152

85.

Polack, P.-O. ∙ Friedman, J. ∙ Golshani, P.

**Cellular mechanisms of brain state-dependent gain modulation in visual cortex**

*Nat. Neurosci.* 2013; **16**:1331-1339

), which exert context-dependent influence on responses in visual cortex (

81.

Pakan, J.M. ∙ Lowe, S.C. ∙ Dylda, E....

**Behavioral-state modulation of inhibition is context-dependent and cell type specific in mouse visual cortex**

*eLife.* 2016; **5**:e14985

). However, modulatory inputs alone cannot account for motor-related signals in visual cortex in the absence of visual input. A driving motor-related prediction of visual input, however, could account for these non-visual signals. We have recently argued that in visual cortex, one source of the prediction of visual input given movement is the anterior cingulate cortex (

62.

Leinweber, M. ∙ Ward, D.R. ∙ Sobczak, J.M....

**A Sensorimotor Circuit in Mouse Cortex for Visual Flow Predictions**

*Neuron.* 2017; **95**:1420-1432.e5

). Activity in axons of anterior cingulate neurons in visual cortex conveys an experience-dependent prediction of visual flow (rather than copies of motor commands) as a function of the turning of the mouse in a virtual environment. Importantly, we found that this motor-related input is shaped by the coupling between movement and visual feedback the mouse has experienced previously.

Locomotion is just one possible proxy for a prediction of visual input, and other signals, like spatial location, could serve a similar function. Consistent with this, neurons in layer 2/3 of V1 respond robustly to the omission of a stimulus the mouse expects to see at a certain location in a virtual environment (

23.

Fiser, A. ∙ Mahringer, D. ∙ Oyibo, H.K....

**Experience-dependent spatial expectations in mouse visual cortex**

*Nat. Neurosci.* 2016; **19**:1658-1664

[Crossref](https://doi.org/10.1038/nn.4385)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/27618309/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2Fnn.4385&pmid=27618309)

). In principle, any signal that explains some of the variance in the visual input can serve as a prediction of visual feedback. Vestibular or eye movement signals could serve as predictions of full-field visual flow. In a learned coupling between two sensory stimuli—e.g., a sound and a visual input—one can serve as a prediction of the other. It is therefore plausible that long-range cortical communication conveys specific predictions of input to the target areas that are associated by experience with signals in the source area (

58.

Larkum, M.

**A cellular mechanism for cortical associations: an organizing principle for the cerebral cortex**

*Trends Neurosci.* 2013; **36**:141-151

94.

Roelfsema, P.R. ∙ Holtmaat, A.

**Control of synaptic plasticity in deep cortical networks**

*Nat. Rev. Neurosci.* 2018; **19**:166-180

). Consistent with this view, specific signals related to self-generated movement, head direction, animal’s spatial location, and stimulus timing have been observed across several sensory areas (

65.

Lütcke, H. ∙ Murayama, M. ∙ Hahn, T....

**Optical recording of neuronal activity with a genetically-encoded calcium indicator in anesthetized and freely moving mice**

*Front. Neural Circuits.* 2010; **4**:9

[PubMed](https://pubmed.ncbi.nlm.nih.gov/20461230/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=20461230)

68.

Manita, S. ∙ Suzuki, T. ∙ Homma, C....

**A Top-Down Cortical Circuit for Accurate Sensory Perception**

*Neuron.* 2015; **86**:1304-1316

69.

Mao, T. ∙ Kusefoglu, D. ∙ Hooks, B.M....

**Long-range neuronal circuits underlying the interaction between sensory and motor cortex**

*Neuron.* 2011; **72**:111-123

86.

Poort, J. ∙ Khan, A.G. ∙ Pachitariu, M....

**Learning Enhances Sensory and Multiple Non-sensory Representations in Primary Visual Cortex**

*Neuron.* 2015; **86**:1478-1490

100.

Schneider, D.M. ∙ Nelson, A. ∙ Mooney, R.

**A synaptic and circuit basis for corollary discharge in the auditory cortex**

*Nature.* 2014; **513**:189-194

115.

Vélez-Fort, M. ∙ Bracey, E.F. ∙ Keshavarzi, S....

**A Circuit for Integration of Head- and Visual-Motion Signals in Layer 6 of Mouse Primary Visual Cortex**

*Neuron.* 2018; **98**:179-191.e6

). These diverse sources of contextual input may thus provide predictions required for computation of prediction errors and for updating internal representations based on information from a given sensory modality.

#### Learning to Predict

A key assumption of the predictive processing framework is that internal models are learned and that experience shapes the circuits required for generating predictions and computing prediction errors. While evolution has generated a template of reproducible long-range projections linking cortical areas, often reciprocally, it is the interaction with the world that refines these connections to generate internal models. Sensory experience sculpts the connectivity between neurons in an activity-dependent manner, such that nearby cortical neurons with similar responses (i.e., those that fire together) can preferentially link up into synaptically connected subnetworks with strong recurrent excitation (

13.

Cossell, L. ∙ Iacaruso, M.F. ∙ Muir, D.R....

**Functional organization of excitatory synaptic strength in primary visual cortex**

*Nature.* 2015; **518**:399-403

53.

Ko, H. ∙ Hofer, S.B. ∙ Pichler, B....

**Functional specificity of local synaptic connections in neocortical networks**

*Nature.* 2011; **473**:87-91

54.

Ko, H. ∙ Cossell, L. ∙ Baragli, C....

**The emergence of functional microcircuits in visual cortex**

*Nature.* 2013; **496**:96-100

). We suggest that a similar principle may apply to the establishment of long-range networks across cortical areas, whereby a history of correlated firing determines which neurons become associated. In the context of predictive processing, this would apply equally to sculpting the bottom-up and top-down connectivity between internal representation neurons encoding components of the same object as well as between prediction-error neurons and internal representation neurons within and across areas. In visual cortex of rodents, predictive responses emerge in an experience-dependent way (

23.

Fiser, A. ∙ Mahringer, D. ∙ Oyibo, H.K....

**Experience-dependent spatial expectations in mouse visual cortex**

*Nat. Neurosci.* 2016; **19**:1658-1664

[Crossref](https://doi.org/10.1038/nn.4385)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/27618309/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2Fnn.4385&pmid=27618309)

67.

Makino, H. ∙ Komiyama, T.

**Learning enhances the relative impact of top-down processing in the visual cortex**

*Nat. Neurosci.* 2015; **18**:1116-1122

86.

Poort, J. ∙ Khan, A.G. ∙ Pachitariu, M....

**Learning Enhances Sensory and Multiple Non-sensory Representations in Primary Visual Cortex**

*Neuron.* 2015; **86**:1478-1490

). Through passive sensory experience, visual cortex responses become predictive of upcoming visual stimuli (

31.

Gavornik, J.P. ∙ Bear, M.F.

**Learned spatiotemporal sequence recognition and prediction in primary visual cortex**

*Nat. Neurosci.* 2014; **17**:732-737

123.

Xu, S. ∙ Jiang, W. ∙ Poo, M.-M....

**Activity recall in a visual cortical ensemble**

*Nat. Neurosci.* 2012; **15**:449-455

S1-2

). Through experience of visuomotor coupling, predictions of visual flow are learned (

3.

Attinger, A. ∙ Wang, B. ∙ Keller, G.B.

**Visuomotor Coupling Shapes the Functional Development of Mouse Visual Cortex**

*Cell.* 2017; **169**:1291-1302.e14

62.

Leinweber, M. ∙ Ward, D.R. ∙ Sobczak, J.M....

**A Sensorimotor Circuit in Mouse Cortex for Visual Flow Predictions**

*Neuron.* 2017; **95**:1420-1432.e5

), and through experience in a spatial environment, responses emerge that are predictive of the visual input at a given spatial location (

23.

Fiser, A. ∙ Mahringer, D. ∙ Oyibo, H.K....

**Experience-dependent spatial expectations in mouse visual cortex**

*Nat. Neurosci.* 2016; **19**:1658-1664

[Crossref](https://doi.org/10.1038/nn.4385)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/27618309/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2Fnn.4385&pmid=27618309)

). These predictive responses is sensory areas may thus be driven by long-range inputs whose influence is shaped by experience.

We assume that perception is linked to the internal representation of the world and that we only perceive a stimulus if the internal representation for that stimulus is active. This internal representation is what predictions are based on. During a given percept, internal representation neurons, likely distributed across several associated areas, are active. If neurons maintaining the internal representation are the basis for predictions of bottom-up input impinging on the same or other cortical areas, they should exhibit a set of functional and connectional features. First, an internal representation requires a circuit mechanism that maintains the activity in a population of neurons for the time a stimulus is perceived. A number of plausible mechanisms have been proposed for the persistence of neural activity, including strong and selective recurrent excitation between coactive neuronal assemblies within the cortex (

13.

Cossell, L. ∙ Iacaruso, M.F. ∙ Muir, D.R....

**Functional organization of excitatory synaptic strength in primary visual cortex**

*Nature.* 2015; **518**:399-403

63.

Li, N. ∙ Daie, K. ∙ Svoboda, K....

**Robust neuronal dynamics in premotor cortex during motor planning**

*Nature.* 2016; **532**:459-464

82.

Perin, R. ∙ Berger, T.K. ∙ Markram, H.

**A synaptic organizing principle for cortical neuronal groups**

*Proc. Natl. Acad. Sci. USA.* 2011; **108**:5419-5424

106.

Song, S. ∙ Sjöström, P.J. ∙ Reigl, M....

**Highly nonrandom features of synaptic connectivity in local cortical circuits**

*PLoS Biol.* 2005; **3**:e68

) or via thalamocortical loops (

33.

Guo, Z.V. ∙ Inagaki, H.K. ∙ Daie, K....

**Maintenance of persistent activity in a frontal thalamocortical loop**

*Nature.* 2017; **545**:181-186

92.

Reinhold, K. ∙ Lien, A.D. ∙ Scanziani, M.

**Distinct recurrent versus afferent dynamics in cortical visual processing**

*Nat. Neurosci.* 2015; **18**:1789-1797

99.

Schmitt, L.I. ∙ Wimmer, R.D. ∙ Nakajima, M....

**Thalamic amplification of cortical connectivity sustains attentional control**

*Nature.* 2017; **545**:219-223

). Moreover, internal representations may not require stable patterns of activity, but could be maintained using dynamic attractors. In either case, neurons representing the internal model are expected to exhibit more sustained and dense activity than neurons that function as comparators. Second, internal representation neurons should make connections within the area they reside as well as provide top-down input to lower areas within the same sensory modality and/or project to associated cortical areas dedicated to other modalities. Finally, as internal representations need to be updated by prediction errors, the neurons encoding the internal representation should be densely connected with the comparator circuit encoding the same feature. Interestingly, these functional and anatomical characteristics are hallmarks of a subset of cortical neurons prevalent in deeper layers (

36.

Harris, K.D. ∙ Mrsic-Flogel, T.D.

**Cortical connectivity and sensory coding**

*Nature.* 2013; **503**:51-58

37.

Harris, K.D. ∙ Shepherd, G.M.G.

**The neocortical circuit: themes and variations**

*Nat. Neurosci.* 2015; **18**:170-181

). However, how internal representations are maintained in the cortical circuit and how they may be used to generate top-down predictions is still unclear.

#### Precision Signals

In sensory cortex, responses can be modulated and given precedence depending on the context in which the stimulus is perceived. This implies that predictions and prediction errors may be modulated in a context-dependent manner. Conceptually, a dynamic modulation of the influence of top-down and bottom-up input is consistent with an attentional modulation of sensory input (

87.

Posner, M.I. ∙ Gilbert, C.D.

**Attention and primary visual cortex**

*Proc. Natl. Acad. Sci. USA.* 1999; **96**:2585-2587

). Direct evidence for a modulation of prediction and prediction-error signals comes from a variety of experiments. Experience-dependent predictive responses in visual cortex, for example, are only apparent under quiet wakefulness, but not if the animal is active (

123.

Xu, S. ∙ Jiang, W. ∙ Poo, M.-M....

**Activity recall in a visual cortical ensemble**

*Nat. Neurosci.* 2012; **15**:449-455

S1-2

). Similarly, adaptation of sensory responses depends on context and the task-relevance of sensory input (

51.

Keller, A.J. ∙ Houlton, R. ∙ Kampa, B.M....

**Stimulus relevance modulates contrast adaptation in visual cortex**

*eLife.* 2017; **6**:e21589

). In sensorimotor learning, prediction errors during movement are thought to correct the motor program. Here, the requirement for a context-dependent gating of prediction errors stems from the fact that prediction errors that occur during passive observation should not interfere with the motor program. This requires an error signal that can gate plasticity, whose magnitude can be adjusted in a context-dependent manner.

The source of such a modulating or gating signal is not always clear. Attentional gain modulation in visual cortex has been speculated to be driven by long-range cortical input (

126.

Zhang, S. ∙ Xu, M. ∙ Kamigaki, T....

**Selective attention. Long-range and local circuits for top-down modulation of visual cortex processing**

*Science.* 2014; **345**:660-665

), input from higher-order thalamus (

88.

Purushothaman, G. ∙ Marion, R. ∙ Li, K....

**Gating and control of primary visual cortex by pulvinar**

*Nat. Neurosci.* 2012; **15**:905-912

95.

Roth, M.M. ∙ Dahmen, J.C. ∙ Muir, D.R....

**Thalamic nuclei convey diverse contextual information to layer 1 of visual cortex**

*Nat. Neurosci.* 2016; **19**:299-307

Published online December 21, 2015

120.

Wimmer, R.D. ∙ Schmitt, L.I. ∙ Davidson, T.J....

**Thalamic control of sensory selection in divided attention**

*Nature.* 2015; **526**:705-709

), or neuromodulatory inputs (

28.

Fu, Y. ∙ Tucciarone, J.M. ∙ Espinosa, J.S....

**A cortical circuit for gain control by behavioral state**

*Cell.* 2014; **156**:1139-1152

84.

Pinto, L. ∙ Goard, M.J. ∙ Estandian, D....

**Fast modulation of visual perception by basal forebrain cholinergic neurons**

*Nat. Neurosci.* 2013; **16**:1857-1863

85.

Polack, P.-O. ∙ Friedman, J. ∙ Golshani, P.

**Cellular mechanisms of brain state-dependent gain modulation in visual cortex**

*Nat. Neurosci.* 2013; **16**:1331-1339

111.

Thiele, A. ∙ Bellgrove, M.A.

**Neuromodulation of attention**

*Neuron.* 2018; **97**:769-785

). Neuromodulatory input can not only gate plasticity (

52.

Kilgard, M.P. ∙ Merzenich, M.M.

**Cortical map reorganization enabled by nucleus basalis activity**

*Science.* 1998; **279**:1714-1718

73.

Martins, A.R.O. ∙ Froemke, R.C.

**Coordinated forms of noradrenergic plasticity in the locus coeruleus and primary auditory cortex**

*Nat. Neurosci.* 2015; **18**:1483-1492

119.

Weinberger, N.M.

**Specific long-term memory traces in primary auditory cortex**

*Nat. Rev. Neurosci.* 2004; **5**:279-290

[Crossref](https://doi.org/10.1038/nrn1366)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/15034553/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2Fnrn1366&pmid=15034553)

), but also change the balance of top-down versus bottom-up influence (

125.

Yu, A.J. ∙ Dayan, P.

**Uncertainty, neuromodulation, and attention**

*Neuron.* 2005; **46**:681-692

). Specifically, the neuromodulatory tone may shift the relative contribution of bottom-up and top-down signals such that the influence of prediction errors can be modulated according to the internal state of the animal, which would determine the extent to which bottom-up inputs are used to update the internal model. It remains to be seen how different modulatory signals are combined to alter the sensitivity by which cortical circuits prioritize and respond to sensory information or report prediction errors. A more complete understanding of these modulation mechanisms requires further exploration and may be key to understanding cortical dysfunction.

### Implications for Cortical Function and Dysfunction

The immediate appeal of predictive processing is that it could be a basic computational primitive implemented in different variants throughout the brain. Evidence consistent with predictive processing has been found in a variety of different brain regions. The function of the dopaminergic system has been described in terms of reward prediction errors (

101.

Schultz, W. ∙ Dayan, P. ∙ Montague, P.R.

**A neural substrate of prediction and reward**

*Science.* 1997; **275**:1593-1599

). Many of the models of cerebellar function are based on the concepts of internal models and prediction errors (

121.

Wolpert, D. ∙ Ghahramani, Z. ∙ Jordan, M.

**An internal model for sensorimotor integration**

*Science.* 1995; **269** (80-.):1880-1882

122.

Wolpert, D.M. ∙ Miall, R.C. ∙ Kawato, M.

**Internal models in the cerebellum**

*Trends Cogn. Sci.* 1998; **2**:338-347

). Cerebellum-dependent sensorimotor learning is thought to be driven by sensory prediction errors computed as a comparison between intended and actual sensory feedback (

7.

Brooks, J.X. ∙ Carriot, J. ∙ Cullen, K.E.

**Learning to expect the unexpected: rapid updating in primate cerebellum during voluntary self-motion**

*Nat. Neurosci.* 2015; **18**:1310-1317

). Similarly, certain forms of cortex-dependent sensorimotor learning are thought to be driven by performance errors (

41.

Houde, J.F. ∙ Jordan, M.I.

**Sensorimotor adaptation in speech production**

*Science.* 1998; **279**:1213-1216

55.

Konishi, M.

**The role of auditory feedback in the control of vocalization in the white-crowned sparrow**

*Z. Tierpsychol.* 1965; **22**:770-783

). In vocal learning, these performance errors have been suggested to be computed based on a comparison of intended and actual sensory feedback (

48.

Keller, G.B. ∙ Hahnloser, R.H.R.

**Neural processing of auditory feedback during vocal practice in a songbird**

*Nature.* 2009; **457**:187-190

).

So, what could the implications be of describing brain function in terms of an internal representation of the world that is updated through comparison with incoming sensory information? Of course, we do not have a definitive answer to this question, but what we will attempt to do in this section is to explain where we see promise of predictive processing. First, temporarily decoupling the internal representation from sensory input would allow one to run the model as a simulation. In this way, one could simulate the consequences of one’s actions without having to perform them. This is likely what we refer to as thinking. Second, we would postulate that perception is based on a finely tuned process that continuously balances internal predictions against bottom-up signals to update an internal representation. If this process is imbalanced such that the internal representation is driven too strongly by top-down predictions, one might perceive things that are not there, or interpret intention into action of others where there is none. This would likely resemble positive symptoms of schizophrenia, as has been argued previously (

12.

Corlett, P.R. ∙ Frith, C.D. ∙ Fletcher, P.C.

**From drugs to deprivation: a Bayesian framework for understanding models of psychosis**

*Psychopharmacology (Berl.).* 2009; **206**:515-530

24.

Fletcher, P.C. ∙ Frith, C.D.

**Perceiving is believing: a Bayesian approach to explaining the positive symptoms of schizophrenia**

*Nat. Rev. Neurosci.* 2009; **10**:48-58

27.

Frith, C.D. ∙ Blakemore, S. ∙ Wolpert, D.M.

**Explaining the symptoms of schizophrenia: abnormalities in the awareness of action**

*Brain Res. Brain Res. Rev.* 2000; **31**:357-363

). Conversely, if the effect of top-down predictions were too weak and the internal representation were dominated by bottom-up sensory input, one might be unable to adequately predict sensory input or understand intentions of others. Assuming the brain lacks the ability to generate an internal model with sufficient predictive capacity, a simple behavioral strategy would be to engage in stereotyped repetitive behavior that makes the input more predictable. A dysfunction in the brain’s ability to make accurate predictions has been proposed as one of the attributes of autism (

59.

Lawson, R.P. ∙ Rees, G. ∙ Friston, K.J.

**An aberrant precision account of autism**

*Front. Hum. Neurosci.* 2014; **8**:302

60.

Lawson, R.P. ∙ Mathys, C. ∙ Rees, G.

**Adults with autism overestimate the volatility of the sensory environment**

*Nat. Neurosci.* 2017; **20**:1293-1299

105.

Sinha, P. ∙ Kjelgaard, M.M. ∙ Gandhi, T.K....

**Autism as a disorder of prediction**

*Proc. Natl. Acad. Sci. USA.* 2014; **111**:15220-15225

). Based on this, one could speculate that schizophrenia and autism are opposite ends of the same circuit imbalance in which the internal representation of the world is either driven too strongly or too weakly by predictions. We speculate that alterations in predictive processing circuits may be common to both disorders. Anti-NMDA receptor encephalitis, for example, in which NMDA receptors are targeted by the immune system, results in symptoms that resemble those of schizophrenia when adults are affected, while it results in symptoms that resemble those of autism when children are affected (

16.

Creten, C. ∙ van der Zwaan, S. ∙ Blankespoor, R.J....

**Late onset autism and anti-NMDA-receptor encephalitis**

*Lancet.* 2011; **378**:98

17.

Dalmau, J. ∙ Tüzün, E. ∙ Wu, H.Y....

**Paraneoplastic anti- *N* -methyl-D-aspartate receptor encephalitis associated with ovarian teratoma**

*Ann. Neurol.* 2007; **61**:25-36

112.

Titulaer, M.J. ∙ McCracken, L. ∙ Gabilondo, I....

**Late-onset anti-NMDA receptor encephalitis**

*Neurology.* 2013; **81**:1058-1063

). In addition, there is a common gene expression network that is dysregulated in the two conditions (

30.

Gandal, M.J. ∙ Haney, J.R. ∙ Parikshak, N.N...., CommonMind Consortium, PsychENCODE Consortium, iPSYCH-BROAD Working Group

**Shared molecular neuropathology across major psychiatric disorders parallels polygenic overlap**

*Science.* 2018; **359**:693-697

), possibly in opposite directions (

15.

Crespi, B. ∙ Stead, P. ∙ Elliot, M.

**Evolution in health and medicine Sackler colloquium: Comparative genomics of autism and schizophrenia**

*Proc. Natl. Acad. Sci. USA.* 2010; **107** (Suppl 1):1736-1741

). Thus, the absence of key molecular regulators of synaptic plasticity (e.g., glutamate receptors) may lead to a failed experience-dependent adjustment of the connections in circuits that maintain an internal representation of the world through a comparison with incoming sensory input. In turn, this may cause aberrations in predictive processing and altered cortical function in these neurodevelopmental disorders.

### The Experiments That Need to Be Done

In this section, we outline experiments that may test, refine, or reject the model of predictive processing in the cerebral cortex using currently available technologies.

(1) One of the core postulates is that there are neurons in each area of cortex that maintain an internal representation of the world in a local coordinate system. To the best of our knowledge, there has been no clear demonstration of the existence of such neurons. The problem with identifying such neurons is that they will exhibit responses that appear driven by a bottom-up input in many conditions. However, there are a few functional and anatomical characteristics that might aid in identifying them. First, internal-representation neurons should comprise a class of neurons separate from the prediction-error neurons. It is possible that internal-representation neurons are intermixed with prediction-error neurons in different cortical layers or that they are enriched in deep layers of cortex (

6.

Bastos, A.M. ∙ Usrey, W.M. ∙ Adams, R.A....

**Canonical microcircuits for predictive coding**

*Neuron.* 2012; **76**:695-711

), which are the main source of top-down signals (

22.

Felleman, D.J. ∙ Van Essen, D.C.

**Distributed hierarchical processing in the primate cerebral cortex**

*Cereb. Cortex.* 1991; **1**:1-47

[Crossref](https://doi.org/10.1093/cercor/1.1.1)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/1822724/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1093%2Fcercor%2F1.1.1&pmid=1822724)

70.

Markov, N.T. ∙ Vezoli, J. ∙ Chameau, P....

**Anatomy of hierarchy: feedforward and feedback pathways in macaque visual cortex**

*J. Comp. Neurol.* 2014; **522**:225-259

). Second, internal-representation neurons provide input to both local prediction-error neurons and, either directly or indirectly, give rise to projections, which convey predictions to other cortical areas. Third, within a cortical area, the current internal representation should function like a prediction (the current scene is a decent predictor of future scenes). Therefore, local internal-representation neurons should interact with prediction-error neurons in the same way top-down predictions do. Negative prediction-error neurons should be net excited by internal representation neurons, while positive prediction-error neurons should be net inhibited. Fourth, activity in prediction-error neurons should update the local internal representation. Positive prediction-error neurons, which report more bottom-up input than expected, should net activate the corresponding local internal-representation neurons. Conversely, negative prediction-error neurons, which report less input than expected, should net inhibit the corresponding internal-representation neurons. Given that we do not have a genetic handle on the different functional neuronal classes, experiments would need to rely on the possibility that there is a predominance of one or the other neuron type in different cortical layers (for example, a preponderance of prediction-error neurons in layer 2/3 and of internal representation neurons in layer 5). In this way, one could test the influence of activation of a subset of putative internal representation neurons, either in a given cortical layer or through targeted photostimulation (

80.

Packer, A.M. ∙ Russell, L.E. ∙ Dalgleish, H.W.P....

**Simultaneous all-optical manipulation and recording of neural circuit activity with cellular resolution in vivo**

*Nat. Methods.* 2015; **12**:140-146

Published online December 22, 2014

[Crossref](https://doi.org/10.1038/nmeth.3217)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/25532138/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2Fnmeth.3217&pmid=25532138)

), on functionally identified prediction-error neurons in layer 2/3.

(2) Assuming that cortex is built based on a canonical circuit motif (

19.

Douglas, R.J. ∙ Martin, K.C. ∙ Whitteridge, D.

**A Canonical Microcircuit for Neocortex**

*Neural Comput.* 1989; **1**:480-488

[Crossref](https://doi.org/10.1162/neco.1989.1.4.480)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1162%2Fneco.1989.1.4.480)

), we should find prediction-error neurons for every instance of a behaviorally meaningful correlation of activity across any two cortical areas. To illustrate this, let us take the interaction between motor areas and visual areas. Every movement that is coupled to a predictable change in visual input (whole-body translation; eye, head, limb, or whisker movements; etc.) should have a corresponding set of prediction-error neurons in a sensory cortex. We think that a subset of layer 2/3 neurons in mouse V1 functions to compute prediction errors between whole-body translation and visual input (

3.

Attinger, A. ∙ Wang, B. ∙ Keller, G.B.

**Visuomotor Coupling Shapes the Functional Development of Mouse Visual Cortex**

*Cell.* 2017; **169**:1291-1302.e14

128.

Zmarz, P. ∙ Keller, G.B.

**Mismatch Receptive Fields in Mouse Visual Cortex**

*Neuron.* 2016; **92**:766-772

). Similar predictions of sensory input may be based on spatial location, head direction, or sensory input in other modalities. Consistent with this, a subset of neurons in layer 2/3 of mouse V1 signal a prediction error between a prediction of visual feedback based on spatial location and visual input (

23.

Fiser, A. ∙ Mahringer, D. ∙ Oyibo, H.K....

**Experience-dependent spatial expectations in mouse visual cortex**

*Nat. Neurosci.* 2016; **19**:1658-1664

[Crossref](https://doi.org/10.1038/nn.4385)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/27618309/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2Fnn.4385&pmid=27618309)

). Similar prediction-error neurons may exist for predictions based on auditory input, vestibular input, etc.

(3) Most work on cortical circuits for predictive processing has focused on primary sensory areas. The advantage of examining in a primary sensory area is that there is some experimental control over bottom-up inputs. Assuming predictive processing describes a canonical cortical computation, we should find similar prediction-error signals in other cortical areas. These prediction-error signals would be encoded in the same coordinate system as the bottom-up input to the area. By this we mean that there should be neurons in prefrontal cortex that signal deviations in a conceptual rule the animal has learned or a deviation in social patterns the animal expects to encounter in its conspecifics. There is some evidence that a subset of neurons in motor cortex signals a deviation between intended and actual motor state, given proprioceptive or other sensory feedback (

40.

Heindorf, M. ∙ Arber, S. ∙ Keller, G.B.

**Mouse Motor Cortex Coordinates the Behavioral Response to Unpredicted Sensory Feedback**

*Neuron.* 2018; **99**:1040-1054.e5

44.

Inoue, M. ∙ Uchimura, M. ∙ Kitazawa, S.

**Error signals in motor cortices drive adaptation in reaching**

*Neuron.* 2016; **90**:1114-1116

).

(4) In neocortex, it is likely that the prediction-error circuits are shaped by experience, as they are in primary visual cortex for sensorimotor and spatial predictions (

3.

Attinger, A. ∙ Wang, B. ∙ Keller, G.B.

**Visuomotor Coupling Shapes the Functional Development of Mouse Visual Cortex**

*Cell.* 2017; **169**:1291-1302.e14

23.

Fiser, A. ∙ Mahringer, D. ∙ Oyibo, H.K....

**Experience-dependent spatial expectations in mouse visual cortex**

*Nat. Neurosci.* 2016; **19**:1658-1664

[Crossref](https://doi.org/10.1038/nn.4385)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/27618309/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2Fnn.4385&pmid=27618309)

). What is still unclear is which synapses in this circuit undergo experience-dependent plasticity. In the case of the negative prediction-error circuit in layer 2/3 of mouse V1, we can constrain the site of plasticity to some extent. The activity in the somatostatin-positive inhibitory interneurons, which mediate the bottom-up inhibition, is not dependent on sensorimotor experience (

3.

Attinger, A. ∙ Wang, B. ∙ Keller, G.B.

**Visuomotor Coupling Shapes the Functional Development of Mouse Visual Cortex**

*Cell.* 2017; **169**:1291-1302.e14

). Hence, experience-dependent plasticity must modify at least one of the other connections in the circuit. This could be the synapse from the inhibitory neuron onto the prediction-error neuron, or the one from the top-down predictive input onto the prediction-error neuron. Identifying the site of plasticity could be achieved by preventing experience-dependent plasticity in specific cell types during sensorimotor learning (

98.

Sawtell, N.B. ∙ Frenkel, M.Y. ∙ Philpot, B.D....

**NMDA receptor-dependent ocular dominance plasticity in adult visual cortex**

*Neuron.* 2003; **38**:977-985

).

(5) To explain the phenomenon of attention and the fact that passive experience does not modify the motor program during sensorimotor learning, we predict the existence of a modulating signal that can attenuate or amplify prediction-error signals. In vocal learning, for example, listening to conspecific vocalizations should not generate prediction errors that update the motor program for vocalization. Hence, prediction-error signals have to be gated on only during times of self-vocalization. A similar modulation mechanism is necessary to explain attention-related phenomena. There may be at least three defining characteristics of such a signal. First, this input should selectively alter the coupling between prediction-error neurons and internal representation neurons. Second, in sensory and motor regions, the modulating signal should be correlated with movement. Third, manipulations of the modulating system should result in shifts in the balance between top-down and bottom-up inputs, and this may change the gain of responses in prediction-error neurons according to internal state. Possible sources of modulatory signals include classical neuromodulatory systems (e.g., acetylcholine, noradrenaline) or the thalamus, both of which have been shown to change the operating regime of cortical circuits (

28.

Fu, Y. ∙ Tucciarone, J.M. ∙ Espinosa, J.S....

**A cortical circuit for gain control by behavioral state**

*Cell.* 2014; **156**:1139-1152

84.

Pinto, L. ∙ Goard, M.J. ∙ Estandian, D....

**Fast modulation of visual perception by basal forebrain cholinergic neurons**

*Nat. Neurosci.* 2013; **16**:1857-1863

85.

Polack, P.-O. ∙ Friedman, J. ∙ Golshani, P.

**Cellular mechanisms of brain state-dependent gain modulation in visual cortex**

*Nat. Neurosci.* 2013; **16**:1331-1339

88.

Purushothaman, G. ∙ Marion, R. ∙ Li, K....

**Gating and control of primary visual cortex by pulvinar**

*Nat. Neurosci.* 2012; **15**:905-912

120.

Wimmer, R.D. ∙ Schmitt, L.I. ∙ Davidson, T.J....

**Thalamic control of sensory selection in divided attention**

*Nature.* 2015; **526**:705-709

).

(6) Assuming psychosis is a state of imbalance in processing in which the internal representation is not updated by sensory feedback and thus dominated by predictions, and prediction errors are either too strong or too weak, we would expect to find a common functional signature of drugs that reduce psychosis. It is conceivable that antipsychotic drugs function by changing the balance between positive and negative prediction errors or by changing the balance between top-down and bottom-up input. Testing this hypothesis requires systematic characterization of the effects of drugs that are anti- or pro-psychotic on prediction errors, predictions, and bottom-up signals.

Predictive processing in the form we are proposing here will very likely not provide a complete description of cortical function. Hence, our intention should be to identify the limits and shortcomings of the framework in order to formulate a more complete theory. One thing is certain: we need to move away from a purely representational understanding of the cortex if we aim to make conceptual progress in this endeavor.

### Conclusion

Inquiries into the function of any biological structure are best conducted with an eye on David Marr’s three levels of analysis (

71.

Marr, D.

**Vision**

MIT Press, 1982

[Google Scholar](https://scholar.google.com/scholar?q=D.MarrVision1982MIT+Press)

). We have discussed a possible algorithm for the function of neocortex and how this algorithm could be implemented in cortical circuits. What remains to be addressed is what the goal of the computation is. In other words, what is the evolutionary advantage of having a cortex? Cortex emerged in evolution on top of a fully functional brain capable of sensory processing, movement control, and decision making. It had to integrate its input and output circuitry into this functioning brain. It is highly probable that the influence of cortex was initially sparse and modulatory. Reminiscent of this idea is the fact that cortical lesions have relatively subtle phenotypes in rodents (

46.

Kawai, R. ∙ Markman, T. ∙ Poddar, R....

**Motor cortex is required for learning but not for executing a motor skill**

*Neuron.* 2015; **86**:800-812

75.

Miri, A. ∙ Warriner, C.L. ∙ Seely, J.S....

**Behaviorally Selective Engagement of Short-Latency Effector Pathways by Motor Cortex**

*Neuron.* 2017; **95**:683-696.e11

) compared to the dramatic effect of similar lesions in humans (

113.

Twitchell, T.E.

**The restoration of motor function following hemiplegia in man**

*Brain.* 1951; **74**:443-480

). The effect of motor cortex lesions is pronounced, however, during certain forms of motor learning (

46.

Kawai, R. ∙ Markman, T. ∙ Poddar, R....

**Motor cortex is required for learning but not for executing a motor skill**

*Neuron.* 2015; **86**:800-812

) or when animals need to initiate a behavioral response to unexpected sensory feedback perturbations (

64.

Lopes, G. ∙ Nogueira, J. ∙ Dimitriadis, G....

**A robust role for motor cortex**

*bioRxiv.* 2016;

[https://doi.org/10.1101/058917](https://doi.org/10.1101/058917)

[Google Scholar](https://scholar.google.com/scholar?q=G.LopesJ.NogueiraG.DimitriadisJ.A.MenendezJ.J.PatonA.R.KampffA+robust+role+for+motor+cortexbioRxiv2016https%3A%2F%2Fdoi.org%2F10.1101%2F058917)

). Thus, the function of nascent cortex may have been to enable behavioral alternatives in order to evaluate and select novel responses to a given sensory input. One strategy to expand behavioral flexibility is to employ a simulation of the world that allows for rapid testing and continuous preparation of possible motor plans. With the increasing importance of social interaction and coordination, this same mechanism may have been adapted to model and simulate other agents in the world (

93.

Rizzolatti, G. ∙ Fogassi, L. ∙ Gallese, V.

**Neurophysiological mechanisms underlying the understanding and imitation of action**

*Nat. Rev. Neurosci.* 2001; **2**:661-670

). Thus, human neocortex may be the product of an evolutionary arms race to build a machine that allows us to make predictions of the ever increasingly complex behavior of our conspecifics—or in the words of the Scottish poet Robert Burns:

> “But, Mousie, thou art no thy-lane,

> In proving foresight may be vain;

> The best-laid schemes o' mice an' men

> Gang aft agley,

> An' lea'e us nought but grief an' pain,

> For promis'd joy!

> Still thou art blest, compar'd wi' me

> The present only toucheth thee:

> But, Och! I backward cast my e'e.

> On prospects drear!

> An' forward, tho' I canna see,

> I guess an' fear!”
> 
> Robert Burns, from “To a Mouse.”

## Acknowledgments

We thank Rainer Friedrich, Andreas Keller, Marcus Stephenson-Jones, and the entire Keller lab for comments on earlier versions of this manuscript. This work was funded by the Gatsby Charitable Foundation (GAT3212 / GAT3361) and Wellcome (090843/E/09/Z) (T.D.M.-F.), the Swiss National Science Foundation and the Novartis Research Foundation (G.B.K.).

## References

[1.](#body-ref-sref2 "View in article")

Adesnik, H. ∙ Bruns, W. ∙ Taniguchi, H....

**A neural circuit for spatial summation in visual cortex**

*Nature.* 2012; **490**:226-231

[2.](#body-ref-sref2 "View in article")

Angelucci, A. ∙ Bijanzadeh, M. ∙ Nurminen, L....

**Circuits and Mechanisms for Surround Modulation in Visual Cortex**

*Annu. Rev. Neurosci.* 2017; **40**:425-451

[3.](#body-ref-sref3-1 "View in article")

Attinger, A. ∙ Wang, B. ∙ Keller, G.B.

**Visuomotor Coupling Shapes the Functional Development of Mouse Visual Cortex**

*Cell.* 2017; **169**:1291-1302.e14

[4.](#body-ref-sref4 "View in article")

Barlow, H.B.

**Summation and inhibition in the frog’s retina**

*J. Physiol.* 1953; **119**:69-88

[Crossref](https://doi.org/10.1113/jphysiol.1953.sp004829)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/13035718/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1113%2Fjphysiol.1953.sp004829&pmid=13035718)

[5.](#body-ref-sref32 "View in article")

Barlow, H.B.

**Possible principles underlying the transformations of sensory messages**

Rosenblith, W. (Editor)

**Sensory Communication**

MIT Press, 1961; 217-234

[Google Scholar](https://scholar.google.com/scholar?q=H.B.BarlowPossible+principles+underlying+the+transformations+of+sensory+messagesW.RosenblithSensory+Communication1961MIT+Press217234)

[6.](#body-ref-sref6 "View in article")

Bastos, A.M. ∙ Usrey, W.M. ∙ Adams, R.A....

**Canonical microcircuits for predictive coding**

*Neuron.* 2012; **76**:695-711

[7.](#body-ref-sref7 "View in article")

Brooks, J.X. ∙ Carriot, J. ∙ Cullen, K.E.

**Learning to expect the unexpected: rapid updating in primate cerebellum during voluntary self-motion**

*Nat. Neurosci.* 2015; **18**:1310-1317

[8.](#body-ref-sref65 "View in article")

Carandini, M.

**Visual cortex: Fatigue and adaptation**

*Curr. Biol.* 2000; **10**:R605-R607

[9.](#body-ref-sref9 "View in article")

Carandini, M. ∙ Ferster, D.

**A tonic hyperpolarization underlying contrast adaptation in cat visual cortex**

*Science.* 1997; **276**:949-952

[10.](#body-ref-sref56 "View in article")

Clark, A.

**Whatever next? Predictive brains, situated agents, and the future of cognitive science**

*Behav. Brain Sci.* 2013; **36**:181-204

[11.](#body-ref-sref11-1 "View in article")

Clark, A.

**Surfing uncertainty: prediction, action, and the embodied mind**

Oxford University Press, 2016

[Crossref](https://doi.org/10.1093/acprof:oso/9780190217013.001.0001)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1093%2Facprof%3Aoso%2F9780190217013.001.0001)

[12.](#body-ref-sref27 "View in article")

Corlett, P.R. ∙ Frith, C.D. ∙ Fletcher, P.C.

**From drugs to deprivation: a Bayesian framework for understanding models of psychosis**

*Psychopharmacology (Berl.).* 2009; **206**:515-530

[13.](#body-ref-sref53 "View in article")

Cossell, L. ∙ Iacaruso, M.F. ∙ Muir, D.R....

**Functional organization of excitatory synaptic strength in primary visual cortex**

*Nature.* 2015; **518**:399-403

[14.](#body-ref-sref14-1 "View in article")

Craik, K.J.

**The Nature of Explanation**

Cambridge University Press London, 1943

[Google Scholar](https://scholar.google.com/scholar?q=K.J.CraikThe+Nature+of+Explanation1943Cambridge+University+Press+London)

[15.](#body-ref-sref15 "View in article")

Crespi, B. ∙ Stead, P. ∙ Elliot, M.

**Evolution in health and medicine Sackler colloquium: Comparative genomics of autism and schizophrenia**

*Proc. Natl. Acad. Sci. USA.* 2010; **107** (Suppl 1):1736-1741

[16.](#body-ref-sref109 "View in article")

Creten, C. ∙ van der Zwaan, S. ∙ Blankespoor, R.J....

**Late onset autism and anti-NMDA-receptor encephalitis**

*Lancet.* 2011; **378**:98

[17.](#body-ref-sref109 "View in article")

Dalmau, J. ∙ Tüzün, E. ∙ Wu, H.Y....

**Paraneoplastic anti- *N* -methyl-D-aspartate receptor encephalitis associated with ovarian teratoma**

*Ann. Neurol.* 2007; **61**:25-36

[18.](#body-ref-sref94 "View in article")

de Kock, C.P.J. ∙ Bruno, R.M. ∙ Spors, H....

**Layer- and cell-type-specific suprathreshold stimulus representation in rat primary somatosensory cortex**

*J. Physiol.* 2007; **581**:139-154

[19.](#body-ref-sref19 "View in article")

Douglas, R.J. ∙ Martin, K.C. ∙ Whitteridge, D.

**A Canonical Microcircuit for Neocortex**

*Neural Comput.* 1989; **1**:480-488

[Crossref](https://doi.org/10.1162/neco.1989.1.4.480)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1162%2Fneco.1989.1.4.480)

[21.](#body-ref-sref21 "View in article")

Eliades, S.J. ∙ Wang, X.

**Neural substrates of vocalization feedback monitoring in primate auditory cortex**

*Nature.* 2008; **453**:1102-1106

[22.](#body-ref-sref124 "View in article")

Felleman, D.J. ∙ Van Essen, D.C.

**Distributed hierarchical processing in the primate cerebral cortex**

*Cereb. Cortex.* 1991; **1**:1-47

[Crossref](https://doi.org/10.1093/cercor/1.1.1)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/1822724/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1093%2Fcercor%2F1.1.1&pmid=1822724)

[23.](#body-ref-sref23-1 "View in article")

Fiser, A. ∙ Mahringer, D. ∙ Oyibo, H.K....

**Experience-dependent spatial expectations in mouse visual cortex**

*Nat. Neurosci.* 2016; **19**:1658-1664

[Crossref](https://doi.org/10.1038/nn.4385)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/27618309/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2Fnn.4385&pmid=27618309)

[24.](#body-ref-sref27 "View in article")

Fletcher, P.C. ∙ Frith, C.D.

**Perceiving is believing: a Bayesian approach to explaining the positive symptoms of schizophrenia**

*Nat. Rev. Neurosci.* 2009; **10**:48-58

[26.](#body-ref-sref106-1 "View in article")

Friston, K.

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2005; **360**:815-836

[27.](#body-ref-sref27 "View in article")

Frith, C.D. ∙ Blakemore, S. ∙ Wolpert, D.M.

**Explaining the symptoms of schizophrenia: abnormalities in the awareness of action**

*Brain Res. Brain Res. Rev.* 2000; **31**:357-363

[28.](#body-ref-sref83-1 "View in article")

Fu, Y. ∙ Tucciarone, J.M. ∙ Espinosa, J.S....

**A cortical circuit for gain control by behavioral state**

*Cell.* 2014; **156**:1139-1152

[29.](#body-ref-sref29 "View in article")

Gămănuţ, R. ∙ Kennedy, H. ∙ Toroczkai, Z....

**The Mouse Cortical Connectome, Characterized by an Ultra-Dense Cortical Graph, Maintains Specificity by Distinct Connectivity Profiles**

*Neuron.* 2018; **97**:698-715.e10

[30.](#body-ref-sref30 "View in article")

Gandal, M.J. ∙ Haney, J.R. ∙ Parikshak, N.N...., CommonMind Consortium, PsychENCODE Consortium, iPSYCH-BROAD Working Group

**Shared molecular neuropathology across major psychiatric disorders parallels polygenic overlap**

*Science.* 2018; **359**:693-697

[31.](#body-ref-sref120-1 "View in article")

Gavornik, J.P. ∙ Bear, M.F.

**Learned spatiotemporal sequence recognition and prediction in primary visual cortex**

*Nat. Neurosci.* 2014; **17**:732-737

[32.](#body-ref-sref32 "View in article")

Gregory, R.L.

**Perceptions as hypotheses**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 1980; **290**:181-197

[Crossref](https://doi.org/10.1098/rstb.1980.0090)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/6106237/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1098%2Frstb.1980.0090&pmid=6106237)

[33.](#body-ref-sref97 "View in article")

Guo, Z.V. ∙ Inagaki, H.K. ∙ Daie, K....

**Maintenance of persistent activity in a frontal thalamocortical loop**

*Nature.* 2017; **545**:181-186

[34.](#body-ref-sref34 "View in article")

Hafting, T. ∙ Fyhn, M. ∙ Molden, S....

**Microstructure of a spatial map in the entorhinal cortex**

*Nature.* 2005; **436**:801-806

[36.](#body-ref-sref37 "View in article")

Harris, K.D. ∙ Mrsic-Flogel, T.D.

**Cortical connectivity and sensory coding**

*Nature.* 2013; **503**:51-58

[37.](#body-ref-sref37 "View in article")

Harris, K.D. ∙ Shepherd, G.M.G.

**The neocortical circuit: themes and variations**

*Nat. Neurosci.* 2015; **18**:170-181

[38.](#body-ref-sref106-1 "View in article")

Hawkins, J. ∙ Blakeslee, S.

**On intelligence**

Times Books, 2004

[Google Scholar](https://scholar.google.com/scholar?q=J.HawkinsS.BlakesleeOn+intelligence2004Times+Books)

[39.](#body-ref-sref39 "View in article")

Heeger, D.J.

**Theory of cortical function**

*Proc. Natl. Acad. Sci. USA.* 2017; **114**:1773-1782

[40.](#body-ref-sref126 "View in article")

Heindorf, M. ∙ Arber, S. ∙ Keller, G.B.

**Mouse Motor Cortex Coordinates the Behavioral Response to Unpredicted Sensory Feedback**

*Neuron.* 2018; **99**:1040-1054.e5

[41.](#body-ref-sref54 "View in article")

Houde, J.F. ∙ Jordan, M.I.

**Sensorimotor adaptation in speech production**

*Science.* 1998; **279**:1213-1216

[42.](#body-ref-sref42 "View in article")

Hubel, D.H. ∙ Wiesel, T.N.

**Receptive fields of single neurones in the cat’s striate cortex**

*J. Physiol.* 1959; **148**:574-591

[43.](#body-ref-sref43 "View in article")

Hubel, D.H. ∙ Wiesel, T.N.

**Receptive fields and functional architecture in two nonstriate visual areas (18 and 19) of the cat**

*J. Neurophysiol.* 1965; **28**:229-289

[44.](#body-ref-sref126 "View in article")

Inoue, M. ∙ Uchimura, M. ∙ Kitazawa, S.

**Error signals in motor cortices drive adaptation in reaching**

*Neuron.* 2016; **90**:1114-1116

[45.](#body-ref-sref118-1 "View in article")

Jordan, M.I. ∙ Rumelhart, D.E.

**Forward Models: Supervised Learning with a Distal Teacher**

*Cogn. Sci.* 1992; **16**:307-354

[Crossref](https://doi.org/10.1207/s15516709cog1603_1)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1207%2Fs15516709cog1603_1)

[46.](#body-ref-sref74 "View in article")

Kawai, R. ∙ Markman, T. ∙ Poddar, R....

**Motor cortex is required for learning but not for executing a motor skill**

*Neuron.* 2015; **86**:800-812

[47.](#body-ref-sref95-2 "View in article")

Keck, T. ∙ Keller, G.B. ∙ Jacobsen, R.I....

**Synaptic scaling and homeostatic plasticity in the mouse visual cortex in vivo**

*Neuron.* 2013; **80**:327-334

[48.](#body-ref-sref47-1 "View in article")

Keller, G.B. ∙ Hahnloser, R.H.R.

**Neural processing of auditory feedback during vocal practice in a songbird**

*Nature.* 2009; **457**:187-190

[49.](#body-ref-sref48 "View in article")

Keller, A.J. ∙ Martin, K.A.C.

**Local Circuits for Contrast Normalization and Adaptation Investigated with Two-Photon Imaging in Cat Primary Visual Cortex**

*J. Neurosci.* 2015; **35**:10078-10087

[Crossref](https://doi.org/10.1523/JNEUROSCI.0906-15.2015)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/26157005/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1523%2FJNEUROSCI.0906-15.2015&pmid=26157005)

[50.](#body-ref-sref49-1 "View in article")

Keller, G.B. ∙ Bonhoeffer, T. ∙ Hübener, M.

**Sensorimotor mismatch signals in primary visual cortex of the behaving mouse**

*Neuron.* 2012; **74**:809-815

[51.](#body-ref-sref65 "View in article")

Keller, A.J. ∙ Houlton, R. ∙ Kampa, B.M....

**Stimulus relevance modulates contrast adaptation in visual cortex**

*eLife.* 2017; **6**:e21589

[52.](#body-ref-sref116 "View in article")

Kilgard, M.P. ∙ Merzenich, M.M.

**Cortical map reorganization enabled by nucleus basalis activity**

*Science.* 1998; **279**:1714-1718

[53.](#body-ref-sref53 "View in article")

Ko, H. ∙ Hofer, S.B. ∙ Pichler, B....

**Functional specificity of local synaptic connections in neocortical networks**

*Nature.* 2011; **473**:87-91

[54.](#body-ref-sref53 "View in article")

Ko, H. ∙ Cossell, L. ∙ Baragli, C....

**The emergence of functional microcircuits in visual cortex**

*Nature.* 2013; **496**:96-100

[55.](#body-ref-sref54 "View in article")

Konishi, M.

**The role of auditory feedback in the control of vocalization in the white-crowned sparrow**

*Z. Tierpsychol.* 1965; **22**:770-783

[56.](#body-ref-sref106-1 "View in article")

Körding, K.P. ∙ Wolpert, D.M.

**Bayesian integration in sensorimotor learning**

*Nature.* 2004; **427**:244-247

[57.](#body-ref-sref56 "View in article")

Koster-Hale, J. ∙ Saxe, R.

**Theory of mind: a neural prediction problem**

*Neuron.* 2013; **79**:836-848

[58.](#body-ref-sref92 "View in article")

Larkum, M.

**A cellular mechanism for cortical associations: an organizing principle for the cerebral cortex**

*Trends Neurosci.* 2013; **36**:141-151

[59.](#body-ref-sref103 "View in article")

Lawson, R.P. ∙ Rees, G. ∙ Friston, K.J.

**An aberrant precision account of autism**

*Front. Hum. Neurosci.* 2014; **8**:302

[60.](#body-ref-sref103 "View in article")

Lawson, R.P. ∙ Mathys, C. ∙ Rees, G.

**Adults with autism overestimate the volatility of the sensory environment**

*Nat. Neurosci.* 2017; **20**:1293-1299

[61.](#body-ref-sref123-3 "View in article")

Lee, S. ∙ Kruglikov, I. ∙ Huang, Z.J....

**A disinhibitory circuit mediates motor integration in the somatosensory cortex**

*Nat. Neurosci.* 2013; **16**:1662-1670

[62.](#body-ref-sref123-2 "View in article")

Leinweber, M. ∙ Ward, D.R. ∙ Sobczak, J.M....

**A Sensorimotor Circuit in Mouse Cortex for Visual Flow Predictions**

*Neuron.* 2017; **95**:1420-1432.e5

[63.](#body-ref-sref104 "View in article")

Li, N. ∙ Daie, K. ∙ Svoboda, K....

**Robust neuronal dynamics in premotor cortex during motor planning**

*Nature.* 2016; **532**:459-464

[64.](#body-ref-sref63 "View in article")

Lopes, G. ∙ Nogueira, J. ∙ Dimitriadis, G....

**A robust role for motor cortex**

*bioRxiv.* 2016;

[https://doi.org/10.1101/058917](https://doi.org/10.1101/058917)

[Google Scholar](https://scholar.google.com/scholar?q=G.LopesJ.NogueiraG.DimitriadisJ.A.MenendezJ.J.PatonA.R.KampffA+robust+role+for+motor+cortexbioRxiv2016https%3A%2F%2Fdoi.org%2F10.1101%2F058917)

[65.](#body-ref-sref112 "View in article")

Lütcke, H. ∙ Murayama, M. ∙ Hahn, T....

**Optical recording of neuronal activity with a genetically-encoded calcium indicator in anesthetized and freely moving mice**

*Front. Neural Circuits.* 2010; **4**:9

[PubMed](https://pubmed.ncbi.nlm.nih.gov/20461230/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=20461230)

[66.](#body-ref-sref65 "View in article")

Maffei, L. ∙ Fiorentini, A. ∙ Bisti, S.

**Neural correlate of perceptual adaptation to gratings**

*Science.* 1973; **182**:1036-1038

[Crossref](https://doi.org/10.1126/science.182.4116.1036)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/4748674/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1126%2Fscience.182.4116.1036&pmid=4748674)

[67.](#body-ref-sref84-2 "View in article")

Makino, H. ∙ Komiyama, T.

**Learning enhances the relative impact of top-down processing in the visual cortex**

*Nat. Neurosci.* 2015; **18**:1116-1122

[68.](#body-ref-sref112 "View in article")

Manita, S. ∙ Suzuki, T. ∙ Homma, C....

**A Top-Down Cortical Circuit for Accurate Sensory Perception**

*Neuron.* 2015; **86**:1304-1316

[69.](#body-ref-sref123-2 "View in article")

Mao, T. ∙ Kusefoglu, D. ∙ Hooks, B.M....

**Long-range neuronal circuits underlying the interaction between sensory and motor cortex**

*Neuron.* 2011; **72**:111-123

[70.](#body-ref-sref124 "View in article")

Markov, N.T. ∙ Vezoli, J. ∙ Chameau, P....

**Anatomy of hierarchy: feedforward and feedback pathways in macaque visual cortex**

*J. Comp. Neurol.* 2014; **522**:225-259

[71.](#body-ref-sref70-1 "View in article")

Marr, D.

**Vision**

MIT Press, 1982

[Google Scholar](https://scholar.google.com/scholar?q=D.MarrVision1982MIT+Press)

[72.](#body-ref-sref71-1 "View in article")

Martin, K.A.C.

**A brief history of the “feature detector”**

*Cereb. Cortex.* 1994; **4**:1-7

[73.](#body-ref-sref116 "View in article")

Martins, A.R.O. ∙ Froemke, R.C.

**Coordinated forms of noradrenergic plasticity in the locus coeruleus and primary auditory cortex**

*Nat. Neurosci.* 2015; **18**:1483-1492

[74.](#body-ref-sref73 "View in article")

Meyer, T. ∙ Olson, C.R.

**Statistical learning of visual transitions in monkey inferotemporal cortex**

*Proc. Natl. Acad. Sci. USA.* 2011; **108**:19401-19406

[75.](#body-ref-sref74 "View in article")

Miri, A. ∙ Warriner, C.L. ∙ Seely, J.S....

**Behaviorally Selective Engagement of Short-Latency Effector Pathways by Motor Cortex**

*Neuron.* 2017; **95**:683-696.e11

[76.](#body-ref-sref94 "View in article")

Niell, C.M. ∙ Stryker, M.P.

**Highly selective receptive fields in mouse visual cortex**

*J. Neurosci.* 2008; **28**:7520-7536

[78.](#body-ref-sref77 "View in article")

O’Keefe, J. ∙ Dostrovsky, J.

**The hippocampus as a spatial map. Preliminary evidence from unit activity in the freely-moving rat**

*Brain Res.* 1971; **34**:171-175

[79.](#body-ref-sref124 "View in article")

Oh, S.W. ∙ Harris, J.A. ∙ Ng, L....

**A mesoscale connectome of the mouse brain**

*Nature.* 2014; **508**:207-214

[80.](#body-ref-sref79 "View in article")

Packer, A.M. ∙ Russell, L.E. ∙ Dalgleish, H.W.P....

**Simultaneous all-optical manipulation and recording of neural circuit activity with cellular resolution in vivo**

*Nat. Methods.* 2015; **12**:140-146

Published online December 22, 2014

[Crossref](https://doi.org/10.1038/nmeth.3217)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/25532138/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2Fnmeth.3217&pmid=25532138)

[81.](#body-ref-sref80 "View in article")

Pakan, J.M. ∙ Lowe, S.C. ∙ Dylda, E....

**Behavioral-state modulation of inhibition is context-dependent and cell type specific in mouse visual cortex**

*eLife.* 2016; **5**:e14985

[82.](#body-ref-sref104 "View in article")

Perin, R. ∙ Berger, T.K. ∙ Markram, H.

**A synaptic organizing principle for cortical neuronal groups**

*Proc. Natl. Acad. Sci. USA.* 2011; **108**:5419-5424

[83.](#body-ref-sref82 "View in article")

Perrett, D.I. ∙ Rolls, E.T. ∙ Caan, W.

**Visual neurones responsive to faces in the monkey temporal cortex**

*Exp. Brain Res.* 1982; **47**:329-342

[Crossref](https://doi.org/10.1007/BF00239352)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7128705/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1007%2FBF00239352&pmid=7128705)

[84.](#body-ref-sref128 "View in article")

Pinto, L. ∙ Goard, M.J. ∙ Estandian, D....

**Fast modulation of visual perception by basal forebrain cholinergic neurons**

*Nat. Neurosci.* 2013; **16**:1857-1863

[85.](#body-ref-sref83-1 "View in article")

Polack, P.-O. ∙ Friedman, J. ∙ Golshani, P.

**Cellular mechanisms of brain state-dependent gain modulation in visual cortex**

*Nat. Neurosci.* 2013; **16**:1331-1339

[86.](#body-ref-sref112 "View in article")

Poort, J. ∙ Khan, A.G. ∙ Pachitariu, M....

**Learning Enhances Sensory and Multiple Non-sensory Representations in Primary Visual Cortex**

*Neuron.* 2015; **86**:1478-1490

[87.](#body-ref-sref85 "View in article")

Posner, M.I. ∙ Gilbert, C.D.

**Attention and primary visual cortex**

*Proc. Natl. Acad. Sci. USA.* 1999; **96**:2585-2587

[88.](#body-ref-sref117-1 "View in article")

Purushothaman, G. ∙ Marion, R. ∙ Li, K....

**Gating and control of primary visual cortex by pulvinar**

*Nat. Neurosci.* 2012; **15**:905-912

[89.](#body-ref-sref87-1 "View in article")

Quiroga, R.Q. ∙ Reddy, L. ∙ Kreiman, G....

**Invariant visual representation by single neurons in the human brain**

*Nature.* 2005; **435**:1102-1107

[90.](#body-ref-sref106-1 "View in article")

Rao, R.P.N. ∙ Ballard, D.H.

**Predictive coding in the visual cortex: a functional interpretation of some extra-classical receptive-field effects**

*Nat. Neurosci.* 1999; **2**:79-87

[91.](#body-ref-sref113 "View in article")

Reimer, J. ∙ McGinley, M.J. ∙ Liu, Y....

**Pupil fluctuations track rapid changes in adrenergic and cholinergic activity in cortex**

*Nat. Commun.* 2016; **7**:13289

[Crossref](https://doi.org/10.1038/ncomms13289)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/27824036/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2Fncomms13289&pmid=27824036)

[92.](#body-ref-sref97 "View in article")

Reinhold, K. ∙ Lien, A.D. ∙ Scanziani, M.

**Distinct recurrent versus afferent dynamics in cortical visual processing**

*Nat. Neurosci.* 2015; **18**:1789-1797

[93.](#body-ref-sref91 "View in article")

Rizzolatti, G. ∙ Fogassi, L. ∙ Gallese, V.

**Neurophysiological mechanisms underlying the understanding and imitation of action**

*Nat. Rev. Neurosci.* 2001; **2**:661-670

[94.](#body-ref-sref92 "View in article")

Roelfsema, P.R. ∙ Holtmaat, A.

**Control of synaptic plasticity in deep cortical networks**

*Nat. Rev. Neurosci.* 2018; **19**:166-180

[95.](#body-ref-sref117-1 "View in article")

Roth, M.M. ∙ Dahmen, J.C. ∙ Muir, D.R....

**Thalamic nuclei convey diverse contextual information to layer 1 of visual cortex**

*Nat. Neurosci.* 2016; **19**:299-307

Published online December 21, 2015

[96.](#body-ref-sref94 "View in article")

Sakata, S. ∙ Harris, K.D.

**Laminar structure of spontaneous and sensory-evoked population activity in auditory cortex**

*Neuron.* 2009; **64**:404-418

[97.](#body-ref-sref95-1 "View in article")

Saleem, A.B. ∙ Ayaz, A. ∙ Jeffery, K.J....

**Integration of visual motion and locomotion in mouse visual cortex**

*Nat. Neurosci.* 2013; **16**:1864-1869

[98.](#body-ref-sref96 "View in article")

Sawtell, N.B. ∙ Frenkel, M.Y. ∙ Philpot, B.D....

**NMDA receptor-dependent ocular dominance plasticity in adult visual cortex**

*Neuron.* 2003; **38**:977-985

[99.](#body-ref-sref97 "View in article")

Schmitt, L.I. ∙ Wimmer, R.D. ∙ Nakajima, M....

**Thalamic amplification of cortical connectivity sustains attentional control**

*Nature.* 2017; **545**:219-223

[100.](#body-ref-sref98-1 "View in article")

Schneider, D.M. ∙ Nelson, A. ∙ Mooney, R.

**A synaptic and circuit basis for corollary discharge in the auditory cortex**

*Nature.* 2014; **513**:189-194

[101.](#body-ref-sref99-1 "View in article")

Schultz, W. ∙ Dayan, P. ∙ Montague, P.R.

**A neural substrate of prediction and reward**

*Science.* 1997; **275**:1593-1599

[102.](#body-ref-sref124 "View in article")

Sherman, S.M.

**Thalamus plays a central role in ongoing cortical functioning**

*Nat. Neurosci.* 2016; **19**:533-541

[103.](#body-ref-sref101 "View in article")

Sherrington, C.S.

**The Muscular Sense**

Sharpey-Schäfer, E.A. (Editor)

**Textbook of Physiology**

Edinburgh, London, 1900; 1002-1025

[Google Scholar](https://scholar.google.com/scholar?q=C.S.SherringtonThe+Muscular+SenseE.A.Sharpey-Sch%C3%A4ferTextbook+of+Physiology1900EdinburghLondon10021025)

[104.](#body-ref-sref102 "View in article")

Simons, D.J. ∙ Chabris, C.F.

**Gorillas in our midst: sustained inattentional blindness for dynamic events**

*Perception.* 1999; **28**:1059-1074

[Crossref](https://doi.org/10.1068/p2952)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/10694957/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1068%2Fp2952&pmid=10694957)

[105.](#body-ref-sref103 "View in article")

Sinha, P. ∙ Kjelgaard, M.M. ∙ Gandhi, T.K....

**Autism as a disorder of prediction**

*Proc. Natl. Acad. Sci. USA.* 2014; **111**:15220-15225

[106.](#body-ref-sref104 "View in article")

Song, S. ∙ Sjöström, P.J. ∙ Reigl, M....

**Highly nonrandom features of synaptic connectivity in local cortical circuits**

*PLoS Biol.* 2005; **3**:e68

[107.](#body-ref-sref105 "View in article")

Sperry, R.W.

**Neural basis of the spontaneous optokinetic response produced by visual inversion**

*J. Comp. Physiol. Psychol.* 1950; **43**:482-489

[108.](#body-ref-sref106-1 "View in article")

Spratling, M.W.

**Predictive coding as a model of response properties in cortical area V1**

*J. Neurosci.* 2010; **30**:3531-3543

[109.](#body-ref-sref107 "View in article")

Spratling, M.W.

**A review of predictive coding algorithms**

*Brain Cogn.* 2017; **112**:92-97

[110.](#body-ref-sref108 "View in article")

Stanley, J., and Miall, R.C. (2007). Functional activation in parieto-premotor and visual areas dependent on congruency between hand movement and visual stimuli during motor-visual priming. *34*, 290–299.

[Google Scholar](https://scholar.google.com/scholar?q=Stanley%2C+J.%2C+and+Miall%2C+R.C.+%282007%29.+Functional+activation+in+parieto-premotor+and+visual+areas+dependent+on+congruency+between+hand+movement+and+visual+stimuli+during+motor-visual+priming.+34%2C+290%E2%80%93299.)

[111.](#body-ref-sref128 "View in article")

Thiele, A. ∙ Bellgrove, M.A.

**Neuromodulation of attention**

*Neuron.* 2018; **97**:769-785

[112.](#body-ref-sref109 "View in article")

Titulaer, M.J. ∙ McCracken, L. ∙ Gabilondo, I....

**Late-onset anti-NMDA receptor encephalitis**

*Neurology.* 2013; **81**:1058-1063

[113.](#body-ref-sref110 "View in article")

Twitchell, T.E.

**The restoration of motor function following hemiplegia in man**

*Brain.* 1951; **74**:443-480

[114.](#body-ref-sref111 "View in article")

Ulanovsky, N. ∙ Las, L. ∙ Nelken, I.

**Processing of low-probability sounds by cortical neurons**

*Nat. Neurosci.* 2003; **6**:391-398

[115.](#body-ref-sref112 "View in article")

Vélez-Fort, M. ∙ Bracey, E.F. ∙ Keshavarzi, S....

**A Circuit for Integration of Head- and Visual-Motion Signals in Layer 6 of Mouse Primary Visual Cortex**

*Neuron.* 2018; **98**:179-191.e6

[116.](#body-ref-sref113 "View in article")

Vinck, M. ∙ Batista-Brito, R. ∙ Knoblich, U....

**Arousal and locomotion make distinct contributions to cortical activity patterns and visual encoding**

*Neuron.* 2015; **86**:740-754

[117.](#body-ref-sref114-1 "View in article")

von Helmholtz, H.

**Handbuch der physiologischen**

*Optik (Stuttg.).* 1867;

[Google Scholar](https://scholar.google.com/scholar?q=H.von+HelmholtzHandbuch+der+physiologischenOptik+%28Stuttg.%291867)

[118.](#body-ref-sref115 "View in article")

von Holst, E. ∙ Mittelstaedt, H.

**Das Reafferenzprinzip**

*Naturwissenschaften.* 1950; **37**:464-476

[119.](#body-ref-sref116 "View in article")

Weinberger, N.M.

**Specific long-term memory traces in primary auditory cortex**

*Nat. Rev. Neurosci.* 2004; **5**:279-290

[Crossref](https://doi.org/10.1038/nrn1366)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/15034553/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2Fnrn1366&pmid=15034553)

[120.](#body-ref-sref117-1 "View in article")

Wimmer, R.D. ∙ Schmitt, L.I. ∙ Davidson, T.J....

**Thalamic control of sensory selection in divided attention**

*Nature.* 2015; **526**:705-709

[121.](#body-ref-sref118-1 "View in article")

Wolpert, D. ∙ Ghahramani, Z. ∙ Jordan, M.

**An internal model for sensorimotor integration**

*Science.* 1995; **269** (80-.):1880-1882

[122.](#body-ref-sref119-1 "View in article")

Wolpert, D.M. ∙ Miall, R.C. ∙ Kawato, M.

**Internal models in the cerebellum**

*Trends Cogn. Sci.* 1998; **2**:338-347

[123.](#body-ref-sref120-1 "View in article")

Xu, S. ∙ Jiang, W. ∙ Poo, M.-M....

**Activity recall in a visual cortical ensemble**

*Nat. Neurosci.* 2012; **15**:449-455

S1-2

[124.](#body-ref-sref123-2 "View in article")

Yang, W. ∙ Carrasquillo, Y. ∙ Hooks, B.M....

**Distinct balance of excitation and inhibition in an interareal feedforward and feedback circuit of mouse visual cortex**

*J. Neurosci.* 2013; **33**:17373-17384

[125.](#body-ref-sref122 "View in article")

Yu, A.J. ∙ Dayan, P.

**Uncertainty, neuromodulation, and attention**

*Neuron.* 2005; **46**:681-692

[126.](#body-ref-sref123-1 "View in article")

Zhang, S. ∙ Xu, M. ∙ Kamigaki, T....

**Selective attention. Long-range and local circuits for top-down modulation of visual cortex processing**

*Science.* 2014; **345**:660-665

[127.](#body-ref-sref124 "View in article")

Zingg, B. ∙ Hintiryan, H. ∙ Gou, L....

**Neural networks of the mouse neocortex**

*Cell.* 2014; **156**:1096-1111

[128.](#body-ref-sref125-1 "View in article")

Zmarz, P. ∙ Keller, G.B.

**Mismatch Receptive Fields in Mouse Visual Cortex**

*Neuron.* 2016; **92**:766-772