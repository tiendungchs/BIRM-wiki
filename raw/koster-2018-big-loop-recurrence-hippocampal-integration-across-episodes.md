---
title: "Big-Loop Recurrence within the Hippocampal System Supports Integration of Information across Episodes"
source: "https://www.cell.com/neuron/fulltext/S0896-6273(18)30682-2"
author:
  - "[[Raphael Koster]]"
  - "[[Martin J. Chadwick]]"
  - "[[Yi Chen]]"
  - "[[David Berron]]"
  - "[[Andrea Banino]]"
  - "[[Emrah Düzel]]"
  - "[[Demis Hassabis]]"
  - "[[Dharshan Kumaran]]"
published: 2017-08-04
created: 2026-11-18
description: "The hippocampus is central for storing distinct episodes, while also supporting integrationacross related episodes. Using ultra-high-resolution fMRI, Koster et al. provide evidencefor a core computational principle (big-loop recurrence) that can account for theseapparently conflicting hippocampal roles."
tags:
  - "clippings"
---
## Highlights

- How we are able to integrate information across multiple episodes remains unknown
- We show that recirculation of hippocampal output as a new input mediates this process
- Results support computational models of big-loop recurrence within the hippocampus
- This provides a unifying hippocampal algorithm for episodic memory and integration

## Summary

Recent evidence challenges the widely held view that the hippocampus is specialized for episodic memory, by demonstrating that it also underpins the integration of information across experiences. Contemporary computational theories propose that these two contrasting functions can be accomplished by big-loop recurrence, whereby the output of the system is recirculated back into the hippocampus. We use ultra-high-resolution fMRI to provide support for this hypothesis, by showing that retrieved information is presented as a new input on the superficial entorhinal cortex—driven by functional connectivity between the deep and superficial entorhinal layers. Further, the magnitude of this laminar connectivity correlated with inferential performance, demonstrating its importance for behavior. Our findings offer a novel perspective on information processing within the hippocampus and support a unifying framework in which the hippocampus captures higher-order structure across experiences, by creating a dynamic memory space from separate episodic codes for individual experiences.

Sign in to unlock the full response and ask your own questions.

[Sign in](https://www.cell.com/action/idLogin?type=login&redirectUri=https%3A%2F%2Fwww.cell.com%2Fneuron%2Ffulltext%2FS0896-6273%2818%2930682-2&pii=S0896627318306822)

### Questions you could ask:

- What evidence supports the existence of a big-loop recurrent circuit in the hippocampal system?
- How does Informational Connectivity between the layers of the Entorhinal Cortex contribute to the understanding of big-loop recurrence?
- What is the traditional view of the hippocampus's role in episodic memory, and how is it challenged by recent evidence?

### Actions you could take:

- Summarize this article
- Summarize experiments

## Introduction

The hippocampus is widely accepted to be critical to episodic memory, by creating orthogonalized representations that minimize interference between experiences (

22.

Favila, S.E. ∙ Chanales, A.J. ∙ Kuhl, B.A.

**Experience-dependent hippocampal pattern differentiation prevents interference during subsequent learning**

*Nat. Commun.* 2016; **7**:11066

48.

Marr, D.

**Simple memory: a theory for archicortex**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 1971; **262**:23-81

49.

McClelland, J.L. ∙ McNaughton, B.L. ∙ O’Reilly, R.C.

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

50.

McNaughton, B.L. ∙ Morris, R.G.

**Hippocampal synaptic enhancement and information storage within a distributed memory system**

*Trends Neurosci.* 1987; **10**:408-415

57.

Norman, K.A. ∙ O’Reilly, R.C.

**Modeling hippocampal and neocortical contributions to recognition memory: a complementary-learning-systems approach**

*Psychol. Rev.* 2003; **110**:611-646

58.

O’Reilly, R.C. ∙ McClelland, J.L.

**Hippocampal conjunctive encoding, storage, and recall: avoiding a trade-off**

*Hippocampus.* 1994; **4**:661-682

77.

Treves, A. ∙ Rolls, E.T.

**Computational constraints suggest the need for two distinct input systems to the hippocampal CA3 network**

*Hippocampus.* 1992; **2**:189-199

84.

Yassa, M.A. ∙ Stark, C.E.

**Pattern separation in the hippocampus**

*Trends Neurosci.* 2011; **34**:515-525

). Emerging evidence, however, suggests that the hippocampus also plays an important role in integrating information across episodes (

5.

Banino, A. ∙ Koster, R. ∙ Hassabis, D....

**Retrieval-based model accounts for striking profile of episodic memory and generalization**

*Sci. Rep.* 2016; **6**:31330

17.

Collin, S.H. ∙ Milivojevic, B. ∙ Doeller, C.F.

**Memory hierarchies map onto the hippocampal long axis in humans**

*Nat. Neurosci.* 2015; **18**:1562-1564

39.

Kumaran, D.

**What representations and computations underpin the contribution of the hippocampus to generalization and inference?**

*Front. Hum. Neurosci.* 2012; **6**:157

51.

Milivojevic, B. ∙ Vicente-Grabovetsky, A. ∙ Doeller, C.F.

**Insight reconfigures hippocampal-prefrontal memories**

*Curr. Biol.* 2015; **25**:821-830

67.

Schlichting, M. ∙ Preston, A.

**The Hippocampus and Memory Integration: Building Knowledge to Navigate Future Decisions**

Springer International Publishing, 2017 405-437

[Google Scholar](https://scholar.google.com/scholar_lookup?title=The+Hippocampus+and+Memory+Integration%3A+Building+Knowledge+to+Navigate+Future+Decisions&author=M.+Schlichting&author=A.+Preston&publication_year=2017&pages=405-437)

70.

Shohamy, D. ∙ Turk-Browne, N.B.

**Mechanisms for widespread hippocampal involvement in cognition**

*J. Exp. Psychol. Gen.* 2013; **142**:1159-1170

87.

Zeithamova, D. ∙ Dominick, A.L. ∙ Preston, A.R.

**Hippocampal and ventral medial prefrontal activation during retrieval-mediated learning supports novel inference**

*Neuron.* 2012; **75**:168-179

), a function that exposes a fundamental tension with its role in pattern separation (

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

)—a computation that inherently disregards the commonalities between episodes (

50.

McNaughton, B.L. ∙ Morris, R.G.

**Hippocampal synaptic enhancement and information storage within a distributed memory system**

*Trends Neurosci.* 1987; **10**:408-415

58.

O’Reilly, R.C. ∙ McClelland, J.L.

**Hippocampal conjunctive encoding, storage, and recall: avoiding a trade-off**

*Hippocampus.* 1994; **4**:661-682

). Recent work, therefore, presents a substantial challenge to theoretical frameworks that view the hippocampus as being specialized for episodic memory (

49.

McClelland, J.L. ∙ McNaughton, B.L. ∙ O’Reilly, R.C.

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

57.

Norman, K.A. ∙ O’Reilly, R.C.

**Modeling hippocampal and neocortical contributions to recognition memory: a complementary-learning-systems approach**

*Psychol. Rev.* 2003; **110**:611-646

), with the gradual extraction of statistical structure across experiences relying on the neocortex (

41.

Kumaran, D. ∙ Hassabis, D. ∙ McClelland, J.L.

**What learning systems do intelligent agents need? complementary learning systems theory updated**

*Trends Cogn. Sci.* 2016; **20**:512-534

49.

McClelland, J.L. ∙ McNaughton, B.L. ∙ O’Reilly, R.C.

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

).

Recently developed computational theories (

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

; also see

66.

Schapiro, A.C. ∙ Turk-Browne, N.B. ∙ Botvinick, M.M....

**Complementary learning systems within the hippocampus: a neural network modelling approach to reconciling episodic memory with statistical learning**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2017; **372**:20160049

) have posited a novel mechanism that resolves the tension between episodic memory and integration across episodes. Specifically, the hippocampal system is proposed to act as a big-loop recurrent circuit, whereby the output of the system is recirculated as a new input rather than constituting the endpoint of hippocampal processing (

49.

McClelland, J.L. ∙ McNaughton, B.L. ∙ O’Reilly, R.C.

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

). Notably, the use of the term big-loop recurrence (

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

66.

Schapiro, A.C. ∙ Turk-Browne, N.B. ∙ Botvinick, M.M....

**Complementary learning systems within the hippocampus: a neural network modelling approach to reconciling episodic memory with statistical learning**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2017; **372**:20160049

), which supports the appreciation of structure *across* episodes, serves to distinguish this mechanism from the well-established internal recurrence within the CA3 region of the hippocampus (

77.

Treves, A. ∙ Rolls, E.T.

**Computational constraints suggest the need for two distinct input systems to the hippocampal CA3 network**

*Hippocampus.* 1992; **2**:189-199

), which supports *within* -episode pattern completion ([Figure S1](#mmc1)). Anatomically, recirculation mediated by big-loop recurrence could be enabled by direct projections between the input and output layers of the entorhinal cortex (EC), which have been documented in rats (

14.

Chrobak, J.J. ∙ Lörincz, A. ∙ Buzsáki, G.

**Physiological patterns in the hippocampo-entorhinal cortex system**

*Hippocampus.* 2000; **10**:457-465

20.

Dolorfo, C.L. ∙ Amaral, D.G.

**Entorhinal cortex of the rat: organization of intrinsic connections**

*J. Comp. Neurol.* 1998; **398**:49-82

37.

Kloosterman, F. ∙ van Haeften, T. ∙ Lopes da Silva, F.H.

**Two reentrant pathways in the hippocampal-entorhinal system**

*Hippocampus.* 2004; **14**:1026-1039

80.

van Strien, N.M. ∙ Cappaert, N.L. ∙ Witter, M.P.

**The anatomy of memory: an interactive overview of the parahippocampal-hippocampal network**

*Nat. Rev. Neurosci.* 2009; **10**:272-282

) and monkeys (

13.

Chrobak, J.J. ∙ Amaral, D.G.

**Entorhinal cortex of the monkey: VII. intrinsic connections**

*J. Comp. Neurol.* 2007; **500**:612-633

), or by a wider circuit involving additional neocortical regions (

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

). By this algorithmic account, the hippocampus represents related experiences (e.g., AB and BC in the paired associate inference \[PAI\] task; [Figure 1](#fig1) A) through pattern separated codes: big-loop recurrence effectively allows the recombination of related episodes at the point of retrieval, thereby allowing appreciation of the commonalities and higher-order structure present among the set of experiences ([Figure 1](#fig1) B;

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

; also see

66.

Schapiro, A.C. ∙ Turk-Browne, N.B. ∙ Botvinick, M.M....

**Complementary learning systems within the hippocampus: a neural network modelling approach to reconciling episodic memory with statistical learning**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2017; **372**:20160049

).

![](https://www.cell.com/cms/10.1016/j.neuron.2018.08.009/asset/086ee77b-3a1d-469c-8d0b-1c7cb4ed0136/main.assets/gr1_lrg.jpg)

Figure 1 Experimental Design and Background

As an everyday example of the dynamic interplay of distinct yet related memories mediated by big-loop recurrence, imagine meeting a work colleague (Alex) and suddenly remembering meeting them for the first time in a conference in Paris the year before. This then triggers a strong memory of a romantic trip to Paris with a partner (Sam) many years previously, which itself triggers another memory of a holiday spent together in Thailand. In this example, this process effects a form of “memory chaining” whereby individual elements of episodic memories can trigger the retrieval of other memories from completely different times of our lives. The big-loop recurrence account proposes that the hippocampus represents related experiences (e.g., Alex-Paris and Paris-Sam in the example above) through pattern separated codes, and that recirculation of shared components across experiences as the output back into the hippocampus (i.e., Paris) allows the retrieval of other related memories (Paris-Sam; Sam-Thailand). While the example above illustrates how the algorithm allows memories to be chained together, more generally it mediates a successive search through memory with subsequent retrieval conditioned on the products of previous retrieval resulting in an iterative process consisting of cycles of memory retrieval and re-querying of the hippocampus (

39.

Kumaran, D.

**What representations and computations underpin the contribution of the hippocampus to generalization and inference?**

*Front. Hum. Neurosci.* 2012; **6**:157

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

). This provides a powerful mechanism for generalization and inference, as exemplified by the widely studied PAI task ([Figure 1](#fig1) A), as it effectively allows the recombination of related episodes at the point of retrieval, thereby allowing appreciation of the commonalities and higher-order structure present among the set of experiences (

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

; also see

66.

Schapiro, A.C. ∙ Turk-Browne, N.B. ∙ Botvinick, M.M....

**Complementary learning systems within the hippocampus: a neural network modelling approach to reconciling episodic memory with statistical learning**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2017; **372**:20160049

).

In contrast to retrieval-based big-loop recurrent models, encoding-based models (

16.

Cohen, N.J. ∙ Eichenbaum, H.

**Memory, Amnesia and the Hippocampal System**

MIT Press, 1993

[Google Scholar](https://scholar.google.com/scholar_lookup?title=Memory%2C+Amnesia+and+the+Hippocampal+System&author=N.J.+Cohen&author=H.+Eichenbaum&publication_year=1993)

21.

Eichenbaum, H. ∙ Dudchenko, P. ∙ Wood, E....

**The hippocampus, memory, and place cells: is it spatial memory or a memory space?**

*Neuron.* 1999; **23**:209-226

25.

Gluck, M.A. ∙ Myers, C.E.

**Hippocampal mediation of stimulus representation: a computational theory**

*Hippocampus.* 1993; **3**:491-516

67.

Schlichting, M. ∙ Preston, A.

**The Hippocampus and Memory Integration: Building Knowledge to Navigate Future Decisions**

Springer International Publishing, 2017 405-437

[Google Scholar](https://scholar.google.com/scholar_lookup?title=The+Hippocampus+and+Memory+Integration%3A+Building+Knowledge+to+Navigate+Future+Decisions&author=M.+Schlichting&author=A.+Preston&publication_year=2017&pages=405-437)

71.

Shohamy, D. ∙ Wagner, A.D.

**Integrating memories in the human brain: hippocampal-midbrain encoding of overlapping events**

*Neuron.* 2008; **60**:378-389

) implicitly de-emphasize the notion of pattern separation—a computation viewed to be critical to episodic memory (

57.

Norman, K.A. ∙ O’Reilly, R.C.

**Modeling hippocampal and neocortical contributions to recognition memory: a complementary-learning-systems approach**

*Psychol. Rev.* 2003; **110**:611-646

58.

O’Reilly, R.C. ∙ McClelland, J.L.

**Hippocampal conjunctive encoding, storage, and recall: avoiding a trade-off**

*Hippocampus.* 1994; **4**:661-682

)—and instead suggest that it is the overlap of hippocampal neural codes for related experiences that is critical to inferential behavior (see [Figure S2](#mmc1) for details). This account is supported by several studies (), indicating that encoding-based mechanisms can support inference when the stimuli have been repeated several times, giving an opportunity for the integrated representations to be formed within the hippocampus (consistent with simulated results from

66.

Schapiro, A.C. ∙ Turk-Browne, N.B. ∙ Botvinick, M.M....

**Complementary learning systems within the hippocampus: a neural network modelling approach to reconciling episodic memory with statistical learning**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2017; **372**:20160049

). Thus, while this encoding-based contribution has been experimentally established, the proposed big-loop mechanism has yet to be empirically validated. Therefore, the aim of the current experiment was to test the hypothesis that the hippocampal system functions as a big-loop recurrent circuit that enables the recirculation of information from the superficial (sEC) and deep (dEC) layers of the EC ([Figure S1](#mmc1);

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

; also see

66.

Schapiro, A.C. ∙ Turk-Browne, N.B. ∙ Botvinick, M.M....

**Complementary learning systems within the hippocampus: a neural network modelling approach to reconciling episodic memory with statistical learning**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2017; **372**:20160049

). To achieve this, we employed the PAI task ([Figure 1](#fig1) A;

10.

Bunsey, M. ∙ Eichenbaum, H.

**Conservation of hippocampal memory function in rats and humans**

*Nature.* 1996; **379**:255-257

87.

Zeithamova, D. ∙ Dominick, A.L. ∙ Preston, A.R.

**Hippocampal and ventral medial prefrontal activation during retrieval-mediated learning supports novel inference**

*Neuron.* 2012; **75**:168-179

)—a prototypical setting in which to examine the mechanisms underlying the ability to integrate information across episodes—together with ultra-high-resolution multivariate fMRI techniques, which allowed us to dissociate neural activity in the input and output layers of the hippocampal system: the sEC and dEC layers (), respectively ([Figure S3](#mmc1); [STAR Methods](#sec-4)).

We focused on inference test trials (i.e., AC trials) in which this circuit-level mechanism makes specific predictions ([Figure 1](#fig1) B). First, during AC test trials requiring the integration of information across episodes (e.g., AB and BC), we should see evidence of reactivation of the unseen item (i.e., B) on the input layer (sEC) due to recirculation from the output (dEC). Second, we should see evidence for functional connectivity between these layers, reflecting the active recirculation of information. Third, the magnitude of recirculation through this pathway connecting the output layer (dEC) to the input layer (sEC) should predict individual variation in inference performance. Critically, recirculation of the output of the hippocampal system as a new input can only exist in the presence of a big-loop mechanism, and therefore the predictions outlined above contrast with those made by encoding-based models (e.g.,

67.

Schlichting, M. ∙ Preston, A.

**The Hippocampus and Memory Integration: Building Knowledge to Navigate Future Decisions**

Springer International Publishing, 2017 405-437

[Google Scholar](https://scholar.google.com/scholar_lookup?title=The+Hippocampus+and+Memory+Integration%3A+Building+Knowledge+to+Navigate+Future+Decisions&author=M.+Schlichting&author=A.+Preston&publication_year=2017&pages=405-437)

71.

Shohamy, D. ∙ Wagner, A.D.

**Integrating memories in the human brain: hippocampal-midbrain encoding of overlapping events**

*Neuron.* 2008; **60**:378-389

; also see [Figure S2](#mmc1)). Specifically, encoding-based models are consistent with reactivation in the dEC of the shared component across related memories (i.e., the B item, shared across AB and BC pairs in the PAI task) as part of pattern completion of a composite/blended representation (i.e., ABC; [Figure S2](#mmc1)). However, they do not predict recirculation of this information from the dEC to the sEC mediated by connectivity between these layers, or the functional relevance of this mechanism to behavior.

## Results

### Task and Behavioral Results

We scanned 26 subjects while they performed a PAI task ([Figure 1](#fig1) A). During encoding, subjects viewed pairs of images. For each pair (AB), each subject later saw another related pair (BC) that shared one image in common (B). This creates stimulus triads such that A and C are indirectly associated even though they have never been presented together. Direct test trials test whether a subject remembers the correct images being presented together (hereafter “AB/BC test trials”), thereby assessing associative memory. By contrast, indirect test trials investigate whether the subjects are able to infer the indirect association between A and C images (hereafter “AC test trials”), which depends on the integration of information across related episodes (i.e., AB, BC). The focus of this experiment was on the neural mechanisms present during these AC test trials.

Behaviorally, subjects had the highest accuracy for AB test trials ([Figure 2](#fig2) A; significant difference across all conditions, *F* (2,50) = 69.88, p < 0.0001; mean ± SEM; 0.89 ± 0.012; significantly larger than BC \[per definition the second pair observed from each triad\], *t* (25) = 2.41, p = 0.021 and AC, *t* (25) = 10.21, p < 0.0001), followed by BC (0.88 ± 0.016; significantly larger than AC, *t* (25) = 8.07, p < 0.0001), and lowest for AC (0.76 ± 0.019). The reaction times followed this pattern inversely with the AB test trials being the fastest (significant difference across all conditions, *F* (2,50) = 317.3, p < 0.0001; 2,013 ± 54; significantly faster than BC, *t* (25) = 6.62, p < 0.0001 and AC, *t* (25) = 18.66, p < 0.0001), followed by BC (2,127 ± 54.3, significantly faster than AC, *t* (25) = 17.88, p < 0.0001), and slowest for AC (2,935 ± 47.4). Note that while incorrect trials had significantly longer RTs (*F* (1,25) = 29.47, p < 0.0001, the slowed response for AC trials was also observed when only considering correct trials (significantly slower than AB, *t* (25) = 19.83, p < 0.0001 and BC, *t* (25) = 18.53, p < 0.0001). This pattern of results matches those observed in a previous study and is well accounted for by the REMERGE big-loop recurrent model (

5.

Banino, A. ∙ Koster, R. ∙ Hassabis, D....

**Retrieval-based model accounts for striking profile of episodic memory and generalization**

*Sci. Rep.* 2016; **6**:31330

).

![](https://www.cell.com/cms/10.1016/j.neuron.2018.08.009/asset/18caeca7-3e0e-4c1b-9a33-85b392b93262/main.assets/gr2_lrg.jpg)

Figure 2 Behavioral and Univariate Results

### AC Trials Reactivate Category Information in the Entorhinal Cortex

In order to investigate the functional properties of the entorhinal cortical layers, we first needed to establish the presence of detectable scene and object signals in the fMRI data. We considered the whole-brain scenes versus objects (SvO) univariate contrast during AB/BC test trials ([Figure 1](#fig1)) on the group level. These trials will contain a mixture of both retrieved and visually presented information, both of which likely contribute to any resultant scene and object information. In a whole-brain analysis, we found significant SvO activation spanning the entire posterior medial temporal lobe (MTL) to the occipital lobe ([Figure 2](#fig2) B), consistent with the literature on scene representation (

54.

Nasr, S. ∙ Liu, N. ∙ Devaney, K.J....

**Scene-selective cortical regions in human and nonhuman primates**

*J. Neurosci.* 2011; **31**:13771-13785

). Further, consistent with previous studies of the medial temporal cortex (), we found evidence for a significant posterior-anterior gradient of scene-to-object signal ([STAR Methods](#sec-4); [Figure 2](#fig2) C; average *r* = 0.81 ± 0.013; sign-rank test against 0, z = 4.46, p < 0.0001, one-tailed).

We next turned to the AC test trials ([Figure 1](#fig1)). Given that no scene or object information was visually presented on these trials, the presence of any category signal can only be driven by reactivation of memory content within the medial temporal cortex. We also found evidence for a posterior-anterior gradient coding for SvO (average *r* = 0.183 ± 0.082; sign-rank test against 0, z = 2.17, p = 0.015, one-tailed) during AC test trials, thereby demonstrating that the medial temporal cortex signal reflects memory reactivation at the time of inference. We ran a further analysis specifically focusing on AC test trial reactivation within the EC. In order to do so, we first selected the 100 voxels within the EC that displayed the strongest activation for scenes over objects (SvO) and vice versa (OvS) during the AB/BC test trials to use as two functional regions of interest. For each subject, we then extracted the average t value of these two sets of voxels from the SvO contrast in the AC test trials. A direct comparison revealed a significant difference in relative scene and object reactivation between these two (SvO and OvS) sets of voxels (mean difference, 3.13 ± 0.86; sign-rank test against 0, z = 2.98, p = 0.0014, one-tailed; see [Figure S4](#mmc1) for single-subject activation maps). This shows that the same EC voxels that discriminate scenes and objects during presentation (AB/BC test trials) are also involved in memory reactivation (AC test trials). These results establish that the expected signals of reactivation of the linking (B) item are present within the EC.

### Entorhinal Cortical Layers Have Separable BOLD Signal

While our previous analysis provides evidence for reactivation in the EC as a whole, our key predictions depend on the ability to detect laminar-specific signals in the dEC and sEC layers. Detecting separate signals in different cortical layers can be challenging due to potential correlation in the BOLD signal driven by the vasculature of laminar cortex (

33.

Huber, L. ∙ Handwerker, D.A. ∙ Jangraw, D.C....

**High-resolution cbv-fmri allows mapping of laminar activity and connectivity of cortical input and output in human m1**

*Neuron.* 2017; **96**:1253-1263.e7

42.

Lawrence, S.J.D. ∙ Formisano, E. ∙ Muckli, L....

**Laminar fMRI: applications for cognitive neuroscience**

*Neuroimage.* 2017;

Published online July 4, 2017

73.

Stephan, K.E. ∙ Petzschner, F.H. ∙ Kasper, L....

**Laminar fMRI and computational theories of brain function**

*Neuroimage.* 2017;

Published online November 2, 2017

; also see [Discussion](#sec-3)). In order to investigate the structure of the laminar signal in our dataset, and to investigate the presence of layer-specific signals, we took a subject-specific, task-independent approach. We used an automated segmentation method ([STAR Methods](#sec-4); [Figure S6](#mmc1)) to segment the EC of each subject into the superficial (input) and deep (output) layers, approximately corresponding to cortical layers II/III and IV/V, respectively (). Segmentations were based on each subject’s native-space high-resolution T2 images, therefore creating a set of subject-specific laminar segmentations ([Figures 3](#fig3) and [S3](#mmc1)). For each voxel in both the sEC and dEC, we extracted the event-specific signal for each trial across the entire experiment (including encoding trials, AB/BC, and AC test trials), thereby forming a temporal response profile. If there is detectable layer-specific signal, it should be possible to determine whether a voxel belongs to the superficial or deep layer based on its temporal responses. To directly test this question, we trained a multivariate classifier to differentiate superficial and deep voxels based on their temporal response profiles. The results were robustly significant (mean ± SD, 85.9% ± 0.7%; sign-rank test on *Z* scores obtained by permutation, z = 4.46, p < 0.001), demonstrating separable signal over the course of the experiment ([Figures 3](#fig3) B and [S3](#mmc1) B). To determine whether this was still the case when specifically focusing on the set of trials of interest to our main hypothesis (AC test trials), we repeated the analysis based only on the temporal responses derived from the set of AC test trials. The classification result still remained robust (67.3% ± 0.6%; z = 4.46, p < 0.001), validating that the signal present in each layer is separable during the set of AC test trials. Importantly, this difference cannot be attributed to mean differences across layers, but can only be based on the temporal responses, as the voxel time courses were standardized prior to classification. We additionally directly compared the temporal signal and contrast to noise ratios (tSNR and CNR) across the layers (

82.

Welvaert, M. ∙ Rosseel, Y.

**On the definition of signal-to-noise ratio and contrast-to-noise ratio for FMRI data**

*PLoS ONE.* 2013; **8**:e77089

; also see [STAR Methods](#sec-4) and [Figure S6](#mmc1)). We found no significant difference in CNR (based on picture presentations versus fixations; mean ± SD; sEC, 0.054 ± 0.12; dEC, 0.064 ± 0.084; sign-rank test on difference, z = 0.57, p = 0.57, two-tailed), though there was a significantly stronger tSNR in the dEC compared to sEC (mean ± SD; sEC, 7.32 ± 0.73; dEC, 8.41 ± 0.92; sign-rank test on difference, z = 4.46, p < 0.0001, two-tailed). This latter is consistent with some degree of MTL signal dropout, which would influence the layers closer to the cortical surface (i.e., the superficial layers;

60.

Olman, C.A. ∙ Davachi, L. ∙ Inati, S.

**Distortion and signal loss in medial temporal lobe**

*PLoS ONE.* 2009; **4**:e8160

). Importantly, however, the successful layer classification described above demonstrates that robust differences between the EC layers are still present despite this dropout. Further, it also provides additional validation of the automated laminar segmentation protocol, as separable signal could only be present if the layers have been accurately segmented.

![](https://www.cell.com/cms/10.1016/j.neuron.2018.08.009/asset/99e742d2-708b-4bef-9c9a-dadf05d74e4a/main.assets/gr3_lrg.jpg)

Figure 3 AC Test Decoding Results

### Reactivated Category Information Is Present in the Superficial Entorhinal Cortex at the Time of Inference

Having found evidence for distinct laminar signals in the EC, we next turned to our first main hypothesis. If episodic information is recirculated from the entorhinal output (deep) layers back to the input (superficial) layers during AC test trials, then category information (scene or object) about the linking B item should be present not only in the deep (dEC), but also the superficial (sEC) layer activations ([Figure 1](#fig1) B). To investigate this neural “reactivation” during AC test trials, we used multivariate voxel decoding to classify the stimulus category (object or scene) of the non-presented linking item (image B). As images A and C were always faces, successful classification can only be due to reactivation of item B. All decoding analyses were based on anatomical masks specific to each subject’s anatomy ([Figures 3](#fig3) and [S3](#mmc1)) in native space, and all reported results are based on unsmoothed, bilateral data (results for each hemisphere separately are reported in [Tables S1](#mmc1) and [S2](#mmc1)). First, consistent with previous multivariate studies involving the cued recall of objects and scenes (

43.

Liang, J.C. ∙ Preston, A.R.

**Medial temporal lobe reinstatement of content-specific details predicts source memory**

*Cortex.* 2017; **91**:67-78

), we found significant reactivation throughout the MTL regions ([Figure 3](#fig3) C; for individual hippocampal subfields, see [Figure S7](#mmc1)). Crucially, however, we also detected significant reactivation within the sEC (1.7% ± 0.07%, z = 2.45, p = 0.007, one-tailed; [Figure 3](#fig3) D), suggesting that information may be recirculated from the dEC back into the hippocampus via the sEC. As detailed earlier, there are potential hemodynamic confounds between the cortical layers driven by the BOLD sensitivity to the cortical vasculature (). In order to ensure that the classification result in the sEC was not driven by BOLD originating solely from dEC activations, we reran the classification analysis after first removing the local dEC signal from each sEC voxel ([STAR Methods](#sec-4); [Figure S5](#mmc1)). This analysis ensures that remaining signal in the sEC cannot be driven by any local spatial correlations caused by draining vein artifacts (for a conceptually similar approach, see

38.

Kok, P. ∙ Bains, L.J. ∙ van Mourik, T....

**Selective activation of the deep layers of the human primary visual cortex by top-down feedback**

*Curr. Biol.* 2016; **26**:371-376

). The classification result in the sEC was still significant after regressing out the local dEC signal (1.8% ± 0.6%, z = 2.73, p = 0.0032, one-tailed), thereby providing evidence that there is unique reactivation information present in the sEC that is unlikely to be attributed to local vasculature confounds such as draining veins ().

### MTL Informational Connectivity Analyses: Evidence for a Functional Connection between the Entorhinal Layers

We next tested for the existence of the predicted functional connection between the entorhinal layers using a method known as informational connectivity (IC). The method has similarity to well-established functional connectivity analysis, but allows inference based on multivoxel information rather than global BOLD signal (*cf.*

1.

Aly, M. ∙ Turk-Browne, N.B.

**Attention promotes episodic encoding by stabilizing hippocampal representations**

*Proc. Natl. Acad. Sci. USA.* 2016; **113**:E420-E429

18.

Coutanche, M.N. ∙ Thompson-Schill, S.L.

**Informational connectivity: identifying synchronized discriminability of multi-voxel patterns across the brain**

*Front. Hum. Neurosci.* 2013; **7**:15

). This approach assesses the covariation in trial-by-trial information (decoding accuracy) between a pair of regions ([Figure 4](#fig4) B). If the two regions covary positively, this indicates that the regions are functionally connected, with information passing between the two ([Figure 4](#fig4) C). IC has previously been shown to accurately capture regional covariation in information content above and beyond univariate methods (

1.

Aly, M. ∙ Turk-Browne, N.B.

**Attention promotes episodic encoding by stabilizing hippocampal representations**

*Proc. Natl. Acad. Sci. USA.* 2016; **113**:E420-E429

18.

Coutanche, M.N. ∙ Thompson-Schill, S.L.

**Informational connectivity: identifying synchronized discriminability of multi-voxel patterns across the brain**

*Front. Hum. Neurosci.* 2013; **7**:15

34.

Huffman, D.J. ∙ Stark, C.E.L.

**The influence of low-level stimulus features on the representation of contexts, items, and their mnemonic associations**

*Neuroimage.* 2017; **155**:513-529

), and here we applied it to assess the flow of information during inference. We measured IC between the sEC and dEC, while partialling out the information contained in all other MTL regions, ensuring that any resulting connectivity was selective to this laminar connection and was not mediated by any other MTL region. The laminar IC was significant (mean rho = 0.11 ± 0.01, z = 4.46, p < 0.0001), indicating a selective functional connection between the EC layers.

![](https://www.cell.com/cms/10.1016/j.neuron.2018.08.009/asset/814eff2b-b2bf-4154-bae0-e378274f08fc/main.assets/gr4_lrg.jpg)

Figure 4 Schematic Depiction of Informational Connectivity Analysis Methods and Laminar Connectivity Results

To validate that this laminar IC measure reflects a meaningful functional connection between the EC layers, we leveraged the well-established anatomical connectivity of the MTL using what we refer to as an “MTL IC direct/indirect analysis.” If IC is detecting meaningful functional connections, we should find that IC is stronger between regions that are directly anatomically connected than between regions that are only indirectly connected (i.e., are only connected via other regions, as part of a larger circuit). To accomplish this, we calculated the IC between every pair of regions in the MTL ([STAR Methods](#sec-4)). We then separated the IC measures into pairs of regions that are known to be directly anatomically connected, and those that are only indirectly connected (

2.

Amaral, D. ∙ Lavenex, P.

**Hippocampal Neuroanatomy**

Oxford University Press, 2009

[Google Scholar](https://scholar.google.com/scholar_lookup?title=Hippocampal+Neuroanatomy&author=D.+Amaral&author=P.+Lavenex&publication_year=2009)

15.

Clark, R.E. ∙ Squire, L.R.

**Similarity in form and function of the hippocampus in rodents, monkeys, and humans**

*Proc. Natl. Acad. Sci. USA.* 2013; **110** (Suppl 2):10365-10370

44.

Libby, L.A. ∙ Ekstrom, A.D. ∙ Ragland, J.D....

**Differential connectivity of perirhinal and parahippocampal cortices within human hippocampal subregions revealed by high-resolution functional imaging**

*J. Neurosci.* 2012; **32**:6550-6560

; [Figure 4](#fig4) D), leaving aside the laminar connection. These two sets of ICs were then averaged per subject to provide a summary of the “direct” and “indirect MTL” connectivity strength. Both showed a significant positive IC strength (direct, mean rho = 0.096 ± 0.002, z = 4.46, p < 0.0001; indirect, mean rho = 0.065 ± 0.003, z = 4.46, p < 0.0001, one-tailed), but crucially, the direct connectivity was significantly stronger than indirect connectivity (z = 4.07, p < 0.0001, one-tailed), showing that the strength of IC reflects the underlying functional connectivity of the region ([Figure 4](#fig4) E). This comparison therefore allowed us to investigate whether the selective IC we find between the entorhinal layers is more similar to a “direct” MTL connection than an “indirect” correction. The laminar IC was significantly higher than the indirect MTL IC (z = 2.96, p = 0.0015, one-tailed; [Figure 4](#fig4)), distinguishing it from the baseline connectivity in the MTL. We further explored this connection by using a classification approach, which tested whether the laminar connection was more likely to reflect a “direct” or “indirect” anatomical connection. A classifier was trained to distinguish “direct” and “indirect” MTL connections using each subject’s average IC strength as feature. This logistic ridge-regression was then applied to the laminar IC values for each subject, determining whether the laminar connection is classified as direct or indirect MTL connection. The resulting value of the regression (classifier evidence) was 0.62 (ranging from 0 \[“indirect MTL”\] to 1 \[“direct MTL”\]; p < 0.024 based on a one-tailed permutation test). Put together, these results provide empirical evidence for selective connectivity between the sEC and dEC consistent with a genuine functional connection between the layers—in keeping with the known anatomical connections between the layers (

80.

van Strien, N.M. ∙ Cappaert, N.L. ∙ Witter, M.P.

**The anatomy of memory: an interactive overview of the parahippocampal-hippocampal network**

*Nat. Rev. Neurosci.* 2009; **10**:272-282

).

We ran two additional analyses to ensure that this connectivity result could not be attributed to spurious local laminar correlations driven by the cortical vasculature. The first control analysis used the same procedure outlined earlier (i.e., in relation to the multivariate classification analysis), whereby the local BOLD signal from the neighboring dEC layer was removed from the sEC on a voxel-wise basis and vice versa ([STAR Methods](#sec-4)). Laminar IC was recalculated using this processed data, and was still found to be significantly stronger than the indirect MTL connectivity (z = 2.37, p = 0.009, one-sided; [Figure S5](#mmc1)). The second control analysis parcellated the EC layers each into two distinct sections (medial and lateral; [Figure S5](#mmc1)), and IC was recalculated between the layers across these distinct sections. There are known to be long-range anatomical connections between the layers, such that information could still in theory pass between these medial and lateral sections (

20.

Dolorfo, C.L. ∙ Amaral, D.G.

**Entorhinal cortex of the rat: organization of intrinsic connections**

*J. Comp. Neurol.* 1998; **398**:49-82

), but in this case there can be no contribution from any local vascular artifacts. Laminar IC across the medial and lateral sections (i.e., medial sEC with lateral dEC, and lateral sEC with medial dEC) was significantly stronger than the indirect MTL connections (z = 2.07, p = 0.019, one-sided; [Figure S5](#mmc1)). These two control analyses provide evidence that there is a genuine selective functional connection between the EC layers (i.e., laminar connectivity) that cannot be accounted for by local hemodynamic contributions such as draining vein artifacts.

### Individual Variation in Laminar Connectivity Predicts Strength of Input Back into the Hippocampus

Having established that the sEC contains reactivated information at the time of inference, and that there is a selective functional connectivity between the entorhinal layers, we next tested whether the sEC reactivation is driven by information flowing through this “big-loop” pathway, in line with our hypothesis ([Figure 1](#fig1)). We leveraged the individual variation in reactivation and IC strength in order to address this question. If information flows from the dEC to the sEC, then we would expect to see a positive correlation between laminar IC strength and sEC reactivation strength. Further, big-loop recirculation predicts that the correlation between the magnitude of laminar IC and reactivation strength in the input layer (sEC) should be significantly stronger than with the output layer (dEC). This is because the strength of sEC reactivation should depend specifically on big-loop recurrence indexed through laminar IC, whereas the strength of dEC reactivation likely reflects the more conventional mechanism of simple associative retrieval in which a subject retrieves the individual associate pairs AB or BC from the A and C items presented on the screen during AC test trials. [Figure S8](#mmc1) displays simulation results confirming that, when individual differences in these two processes are independent, we should find differential correlations between laminar IC and sEC versus dEC reactivation.

As predicted, we found a significant positive correlation between the sEC reactivation strength and laminar IC ([Figure 5](#fig5); *r* = 0.406, p = 0.018; one-tailed permutation tests used for all across-subject correlations). By contrast, the dEC was not significantly correlated with laminar IC (*r* = −0.202, p = 0.838), and a direct comparison of the two revealed that the sEC was significantly more highly correlated with laminar IC than the dEC (difference in *r* = 0.607, p = 0.014). This provides evidence consistent with the hypothesis that selective laminar connectivity is indeed driving the sEC reactivation. Note that this difference cannot be explained by a generic difference in signal intensity between the layers. There is no significant difference in CNR between the two layers, and tSNR is stronger in the dEC than in the sEC, which would predict a bias in sensitivity in the opposite direction to our results (see [Figure S6](#mmc1) for details). To ensure that these correlation results were not influenced by the positive correlation between the sEC and dEC reactivation strengths (*r* = 0.199, p = 0.168), we ran a further partial correlation analysis in which for each correlation we controlled for reactivation strength in the other layer. This analysis revealed the same pattern of result (sEC, *r* = 0.464, p = 0.009; dEC, *r* = −0.315, p = 0.939; difference in *r* = 0.779, p = 0.003), demonstrating that the relationship between laminar IC strength and sEC reactivation cannot be explained by confounding correlations with the dEC. Notably, the finding of a clear dissociation between the entorhinal layers result provides additional strong evidence against the data being driven by vasculature confounds, as an effect that is uniquely attributable to the sEC cannot be driven by spurious BOLD confounds deriving from the dEC.

![](https://www.cell.com/cms/10.1016/j.neuron.2018.08.009/asset/5938b7cc-7994-4efd-b82b-397e88e56553/main.assets/gr5_lrg.jpg)

Figure 5 Individual Variation in Entorhinal Laminar (sEC/dEC) Connectivity Correlates with Three Key Variables

One further prediction of the big-loop hypothesis is that information recirculated from the dEC to the sEC should then propagate back into the hippocampus—specifically into subregions viewed to instantiate pattern separated representations for individual experiences (“episode space”; [Figure S2](#mmc1)), namely the dentate gyrus (DG) and CA3 ([Figure S1](#mmc1))—thereby allowing retrieved content to requery related experiences stored in these regions (

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

). We tested this prediction using the same individual variation data, by correlating the laminar IC strength with the average IC strength between the sEC and the DG&CA3. This revealed a significant positive correlation (*r* = 0.391, p = 0.026), further supporting the hypothesis that the big-loop pathway drives recirculation of information back into the hippocampus. As each of these connections shares the sEC in common, they are not fully independent, which could artificially inflate the correlation. We therefore assessed a baseline control correlation between laminar IC and the average IC strength between the sEC and CA1&SUB. While these hippocampal subfields do share an anatomical connection with the sEC, these connections should not form part of the big-loop recurrent pathway (

39.

Kumaran, D.

**What representations and computations underpin the contribution of the hippocampus to generalization and inference?**

*Front. Hum. Neurosci.* 2012; **6**:157

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

). Thus, if the sEC to DG&CA3 IC reflects the predicted operation of the big-loop pathway, the strength of this connection should be significantly greater than IC between the sEC and CA1&SUB. Notably, these latter connections share the same statistical dependence on the sEC, and therefore provide a stringent baseline. Further, this comparison provides a strong test of the predicted pathway from the sEC back into the hippocampus. Laminar IC did not significantly correlate with the sEC/CA1&SUB IC strength (*r* = −0.214, p = 0.82), and crucially, it was significantly weaker than the correlation between laminar IC and the sEC/DG&CA3 pathway (difference in *r* = 0.605, p = 0.016). These results clearly support the hypothesis that information is recirculated from the dEC to the sEC back into the hippocampal subfields CA3 and DG during performance of AC inference test trials.

The results presented above point toward the conclusion that the laminar connectivity identified reflects a direct functional pathway between the dEC and sEC, rather than a larger pathway mediated by MTL regions such as the perirhinal and or parahippocampal cortex (PHC or PRC). To examine this further in the current context of recirculation of information back into the hippocampus, we also considered an alternative model of information flow incorporating a longer cortical loop through the PRC or PHC. Contrary to the predictions of this alternative model, we did not find a significant correlation between sEC reactivation and sEC/PRC IC (*r* = −0.083, p = 0.69) or sEC/PHC IC (*r* = 0.06, p = 0.776), nor was there a significant correlation between sEC/DG&CA3 and sEC/PRC (*r* = 0.207, p = 0.306) or sEC/PHC (*r* = −0.078, p = 0.713) IC. Thus, these results do not provide support for any longer cortical pathway, and are instead consistent with information flowing directly from the dEC to the sEC. Further, we ran each analysis outlined above, additionally partialling out both the sEC/PRC and sEC/PHC IC. Even with these extra controls, each analysis was still significant ([Table S3](#mmc1)), demonstrating that they are not influenced by any extraneous signals arising in PRC or PHC.

### Recirculation Predicts Individual Variation in Inference Performance

Having established the existence of the predicted functional pathway, we next turned to the final prediction of our model—that big-loop recirculation should predict behavioral inference performance. To test this prediction, we again leveraged the individual variation in our data and correlated the strength of laminar IC with average performance on the AC test trials ([Figure 5](#fig5) C). These variables were significantly positively correlated (*r* = 0.378, p = 0.028), indicating that the degree of recirculation has an impact on inference ability. By contrast, dEC reactivation, which we use as a proxy for the strength of conventional associative retrieval of the AB and BC pairs through pattern completion elicited by the presence of A and C items on the screen during AC test trials, did not significantly correlate with behavioral AC inference performance (*r* = −0.197, p = 0.833). Indeed, a direct comparison revealed that the correlation with AC test performance was significantly higher with laminar IC compared to dEC reactivation (difference in *r* = 0.574, p = 0.021). Additional control analyses demonstrated that these results could not be accounted for by any confounding correlations between the laminar IC and dEC reactivation (*r* = −0.133, p = 0.736; [Table S4](#mmc1)), or by additional pathways running through the PHC/PRC ([Table S4](#mmc1)). To further assess the laminar-specific contributions to behavior, we correlated AC inference performance with both sEC and dEC reactivation strength. If AC inference performance is selectively driven by big-loop recurrence passing information to the sEC, we would expect to see a significantly higher behavioral correlation with sEC than dEC reactivation. This was the case both with (difference in *r* = 0.606, p = 0.017) and without (difference in *r* = 0.481, p = 0.045) partialling out the reactivation strength in the opposing layer. This difference was driven by a marginally positive relationship between AC inference performance and sEC reactivation (while partialling out dEC, *r* = 0.337, p = 0.05; without partialling out dEC, *r* = 0.284, p = 0.079). By contrast, the dEC was not positively correlated with AC inference performance either with (*r* = −0.27, p = 0.9) or without (*r* = − 0.197, p = 0.831) partialling. This pattern of results was still present even when additionally partialling out the IC from PRC and PHC (AC performance and sEC reactivation, *r* = 0.337, p = 0.058; AC performance with dEC reactivation, *r* = −0.27, p = 0.895; difference, *r* = 0.607, p = 0.022). These results suggest that inference is dissociably related to information in the entorhinal input layers. Put together, these results reveal a direct correspondence between the strength of big-loop recirculation and overall inference performance across subjects, which could not be accounted for by variations in general retrieval strength. This is striking evidence in support of the unique functional role of the big-loop mechanism in episodic inference.

## Discussion

We set out to provide evidence for the existence of a big-loop recurrent circuit using ultra-high-resolution fMRI and multivoxel pattern analysis, applied to the PAI task. Solving the inference trials of this task requires the integration of information across temporally distinct episodes. If such integration requires big-loop recurrence, we should see evidence of recirculation of information from the output (dEC) back to the input (sEC). A series of targeted analyses revealed a coherent set of results, each consistent with the presence of a big-loop mechanism. First, we found evidence for reactivation of the unseen “bridging: element (e.g., B item in AC test trial) required for successful inference not only in the region that receives the output of the hippocampus (dEC), but also in the layer processing the input (sEC). This reactivation is only expected if a recirculation mechanism is recruited. Second, we found that the layers of the EC displayed IC consistent with a selective connection between the two. Further, an analysis of the individual variation in layer reactivation and IC strength provided evidence for a flow of information, from the dEC back into the sEC, consistent with the operation of a big-loop pathway. Third, laminar IC predicted the flow of information from the input layer (sEC) back into the dentate gyrus and CA3, consistent with the hypothesis that big-loop recurrence allows retrieved content to requery related experiences stored in these regions. Finally, the strength of information flow through the entorhinal big loop predicted individual variation in inference performance. Put together, our findings offer the first evidence in any species of the functional importance of big-loop recurrence—involving recirculation of the output of the hippocampal system from the deep layer of the EC as a new input on the superficial layer—and establish its link to successful performance in a classic task requiring inferential behavior. Importantly, the demonstration of big-loop recurrence bolsters theoretical frameworks that propose that the hippocampus is able to support two functions that place seemingly opposing demands on the system: episodic memory and the rapid integration of information across episodes (

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

; also see

66.

Schapiro, A.C. ∙ Turk-Browne, N.B. ∙ Botvinick, M.M....

**Complementary learning systems within the hippocampus: a neural network modelling approach to reconciling episodic memory with statistical learning**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2017; **372**:20160049

). While these accounts have received support from computational modeling of behavioral and neural data (

5.

Banino, A. ∙ Koster, R. ∙ Hassabis, D....

**Retrieval-based model accounts for striking profile of episodic memory and generalization**

*Sci. Rep.* 2016; **6**:31330

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

), they have lacked the critical empirical evidence that we provide here concerning the core underlying circuit-level mechanism, namely big-loop recurrence.

The set of results critically depends on the ability to meaningfully differentiate the signal present within the sEC and dEC layers, as well as to detect a meaningful covariance structure between the information contained within the layers. It is therefore crucial to carefully consider the known problems of laminar fMRI introduced by the potential for local vasculature confounds. Specifically, BOLD is sensitive to signals from draining veins that run perpendicular to the cortical layers, toward the pial surface, which can lead to spurious correlations between the layers (

32.

Huber, L. ∙ Uludağ, K. ∙ Möller, H.E.

**Non-BOLD contrast for laminar fMRI in humans: CBF, CBV, and CMR <sub>O2</sub>**

*Neuroimage.* 2017;

Published online July 20, 2017

42.

Lawrence, S.J.D. ∙ Formisano, E. ∙ Muckli, L....

**Laminar fMRI: applications for cognitive neuroscience**

*Neuroimage.* 2017;

Published online July 4, 2017

73.

Stephan, K.E. ∙ Petzschner, F.H. ∙ Kasper, L....

**Laminar fMRI and computational theories of brain function**

*Neuroimage.* 2017;

Published online November 2, 2017

), making it potentially difficult to detect layer-specific signals or laminar connectivity. While alternative methods exist that provide superior specificity, they come at the cost of lower sensitivity and acquisition speed (

32.

Huber, L. ∙ Uludağ, K. ∙ Möller, H.E.

**Non-BOLD contrast for laminar fMRI in humans: CBF, CBV, and CMR <sub>O2</sub>**

*Neuroimage.* 2017;

Published online July 20, 2017

33.

Huber, L. ∙ Handwerker, D.A. ∙ Jangraw, D.C....

**High-resolution cbv-fmri allows mapping of laminar activity and connectivity of cortical input and output in human m1**

*Neuron.* 2017; **96**:1253-1263.e7

), which can be problematic in regions sensitive to signal dropout, such as the MTL. However, despite the lower specificity of BOLD, a growing number of studies have found robust laminar-specific activation or information using BOLD imaging (

19.

De Martino, F. ∙ Moerel, M. ∙ Ugurbil, K....

**Frequency preference and attention effects across cortical depths in the human primary auditory cortex**

*Proc. Natl. Acad. Sci. USA.* 2015; **112**:16036-16041

23.

Fracasso, A. ∙ Petridou, N. ∙ Dumoulin, S.O.

**Systematic variation of population receptive field properties across cortical depth in human visual cortex**

*Neuroimage.* 2016; **139**:427-438

38.

Kok, P. ∙ Bains, L.J. ∙ van Mourik, T....

**Selective activation of the deep layers of the human primary visual cortex by top-down feedback**

*Curr. Biol.* 2016; **26**:371-376

52.

Muckli, L. ∙ De Martino, F. ∙ Vizioli, L....

**Contextual feedback to superficial layers of v1**

*Curr. Biol.* 2015; **25**:2690-2695

61.

Olman, C.A. ∙ Harel, N. ∙ Feinberg, D.A....

**Layer-specific fMRI reflects different neuronal computations at different depths in human V1**

*PLoS ONE.* 2012; **7**:e32536

). Recent work, therefore, provides evidence that laminar-specific signals can be detected using BOLD fMRI.

To ensure this was true of our own data, we used a task-independent analysis to determine the presence of laminar-specific signals within our data. Specifically, a classifier trained on the set of voxel temporal response profiles was able to differentiate superficial from deep voxels ([Figures 3](#fig3) B and [S3](#mmc1) B), clearly demonstrating that the entorhinal layers contain separable BOLD signal. Further, for each analysis, we took additional steps to ensure that the results could not be attributed to vasculature-driven laminar confounds. First, we demonstrated that sEC reactivation was still present even after removing the spatially proximal dEC signal from every sEC voxel (for a conceptually similar approach, see

38.

Kok, P. ∙ Bains, L.J. ∙ van Mourik, T....

**Selective activation of the deep layers of the human primary visual cortex by top-down feedback**

*Curr. Biol.* 2016; **26**:371-376

). This ensured that the sEC signals could not be driven by hemodynamic signals originating in neighboring dEC voxels, as might occur in the case of draining vein artifacts (

32.

Huber, L. ∙ Uludağ, K. ∙ Möller, H.E.

**Non-BOLD contrast for laminar fMRI in humans: CBF, CBV, and CMR <sub>O2</sub>**

*Neuroimage.* 2017;

Published online July 20, 2017

33.

Huber, L. ∙ Handwerker, D.A. ∙ Jangraw, D.C....

**High-resolution cbv-fmri allows mapping of laminar activity and connectivity of cortical input and output in human m1**

*Neuron.* 2017; **96**:1253-1263.e7

38.

Kok, P. ∙ Bains, L.J. ∙ van Mourik, T....

**Selective activation of the deep layers of the human primary visual cortex by top-down feedback**

*Curr. Biol.* 2016; **26**:371-376

42.

Lawrence, S.J.D. ∙ Formisano, E. ∙ Muckli, L....

**Laminar fMRI: applications for cognitive neuroscience**

*Neuroimage.* 2017;

Published online July 4, 2017

). Second, we applied the same local-signal correction prior to measuring the IC between the sEC and dEC, and still found evidence for a significant selective laminar connection. We also applied a second control analysis to rule out local vasculature influences on laminar connectivity, by explicitly measuring only non-local connectivity between the entorhinal layers. This was achieved by partitioning each layer into medial and lateral portions, and assessing laminar IC across different portions. Despite the fact that only non-local connectivity could be detected using this method, we still found a significant effect, consistent with the known existence of non-local anatomical connections (

20.

Dolorfo, C.L. ∙ Amaral, D.G.

**Entorhinal cortex of the rat: organization of intrinsic connections**

*J. Comp. Neurol.* 1998; **398**:49-82

). Each of these control analyses removes the potential contribution of local vasculature confounds, and together they provide clear evidence for the presence of a genuine functional connection between the sEC and dEC layers. In addition to these explicit control analyses, there are also some key results that cannot be explained by vasculature confounds. First, we found that individual variation in the strength of laminar IC correlates selectively with sEC, and not dEC reactivation. If the sEC signal and laminar IC were both influenced by hemodynamic artifacts originating in the dEC, it would not be possible to find any such laminar-specific correlations, as the two layers would covary in their reactivation strength. Second, laminar IC correlated with AC performance, while dEC reactivation did not. Again, if the sEC reactivation and connectivity signals were spuriously influenced by signals from the dEC, this selective correlation with performance would not be present. Put together, these stringent control analyses and laminar-specific correlation results converge in providing strong evidence for the predicted recirculation signals that cannot be accounted for by any signals originating in the deep entorhinal layers.

We consider two further potential limitations of our data. First, when dealing with sub-millimeter resolution imaging and laminar separation, results are more prone to noise effects from imperfect motion correction or coregistration. In order to apply stringent quality control, all masks were manually inspected and corrected when necessary prior to analysis. To highlight the quality of the masks, we display single-subject-level masks for every subject in EPI space in the [Supplemental Information](#supplementary-material) ([Figure S3](#mmc1)). Notably, successful differentiation of the BOLD signal depends on an accurate segmentation of the layers, as well as coregistration with the EPI data. If any of these steps resulted in substantive misalignment, the detection of layer-specific BOLD would not be possible. Further, any serious residual head motion artifacts remaining after preprocessing would also reduce our ability to detect layer-specific BOLD. As described in the previous passage, we found that a classifier could successfully differentiate the BOLD signal in the two EC layers, which provides a robust quality control check to rule out any significant impact from preprocessing error or residual motion. Second, while the absolute classification accuracies in each region are low, they are comparable with other decoding analyses within the region (e.g.,

8.

Bonnici, H.M. ∙ Chadwick, M.J. ∙ Kumaran, D....

**Multi-voxel pattern analysis in human hippocampal subfields**

*Front. Hum. Neurosci.* 2012; **6**:290

12.

Chadwick, M.J. ∙ Hassabis, D. ∙ Weiskopf, N....

**Decoding individual episodic memory traces in the human hippocampus**

*Curr. Biol.* 2010; **20**:544-547

). Further, there is no straightforward relationship between classification accuracy and the underlying effect size or biological interpretation (

30.

Hebart, M.N. ∙ Baker, C.I.

**Deconstructing multivariate decoding for the study of brain function**

*Neuroimage.* 2017;

Published online August 4, 2017

). Indeed, the overall classification accuracy is not typically the measure of interest, as it is not itself a statistical test, and cannot be interpreted as a measure of effect size (

63.

Pereira, F. ∙ Mitchell, T. ∙ Botvinick, M.

**Machine learning classifiers and fMRI: a tutorial overview**

*Neuroimage.* 2009; **45** (Suppl):S199-S209

). Rather, it is the nature of the statistical significance test performed on the classification accuracy that is key for appropriate interpretation, which in our case is at the group level. It is worth noting that, despite the low average decoding accuracy within the sEC, the variance in decoding across individuals correlated with laminar connectivity and inference, in each case with a medium effect size (i.e., between 0.3 and 0.5). This indicates that the variance across a relatively narrow band of decoding accuracies is nevertheless meaningful with respect to other neural metrics and behavior.

We identified selective functional connectivity—referred to as laminar connectivity—between the dEC and sEC through an IC analysis focused on the MTL. Results from a specifically designed MTL IC direct/indirect analysis were consistent with this laminar connectivity reflecting a direct connection between the dEC and sEC, rather than a longer pathway involving the PHC or PRC. Since the major neocortical inputs and outputs to and from the ERC pass through the PRC and PHC (

44.

Libby, L.A. ∙ Ekstrom, A.D. ∙ Ragland, J.D....

**Differential connectivity of perirhinal and parahippocampal cortices within human hippocampal subregions revealed by high-resolution functional imaging**

*J. Neurosci.* 2012; **32**:6550-6560

), controlling for information contained within these two regions in the MTL IC analysis—and additionally in an analysis linking the strength of sEC reactivation to laminar connectivity strength—also suggests that the laminar connection cannot be explained by additional regions that project through the PRC/PHC. Taken together, a parsimonious interpretation of these results is that the laminar connectivity identified reflects a direct functional pathway between the dEC and sEC, rather than a longer pathway mediated by an additional neocortical region to which the ERC projects. However, there are two more subtle alternatives that our analyses cannot conclusively rule out. First, laminar connectivity could be mediated by a part (i.e., subsection) of an existing MTL region that is not adequately captured by our regions of interest. Second, the laminar connectivity identified could in theory be mediated by a region outside the MTL that the ERC projects to via other neocortical or subcortical regions other than the PRC or PHC. Nevertheless, it is worth noting that the logic of our MTL IC direct/indirect analysis—specifically, that regions within the MTL that are directly connected have significantly greater connection strengths than those that are connected indirectly via an additional MTL region—may well hold true for brain structures outside the MTL regions our analysis was focused on. Notably, however, this argument relies on an assumption, albeit a plausible one: the connectivity-related properties of these extra-MTL structures are broadly similar to the MTL regions examined—for example, the connection strengths to a region putatively mediating laminar connectivity are not substantially higher than the connections within the MTL. Hence, given the inherent limitations of fMRI connectivity analyses alluded to above, we cannot definitely rule out the possibility that the laminar connectivity observed does indeed involve additional regions (i.e., is indirect), rather than being mediated by direct projections from the dEC to SEC. Importantly, the big-loop theory as originally proposed viewed the critical algorithmic component of recirculation between the hippocampal system output layer (dEC) and input layer (sEC) as being instantiated either via direct anatomical connections within the ERC known to be present (

13.

Chrobak, J.J. ∙ Amaral, D.G.

**Entorhinal cortex of the monkey: VII. intrinsic connections**

*J. Comp. Neurol.* 2007; **500**:612-633

14.

Chrobak, J.J. ∙ Lörincz, A. ∙ Buzsáki, G.

**Physiological patterns in the hippocampo-entorhinal cortex system**

*Hippocampus.* 2000; **10**:457-465

20.

Dolorfo, C.L. ∙ Amaral, D.G.

**Entorhinal cortex of the rat: organization of intrinsic connections**

*J. Comp. Neurol.* 1998; **398**:49-82

37.

Kloosterman, F. ∙ van Haeften, T. ∙ Lopes da Silva, F.H.

**Two reentrant pathways in the hippocampal-entorhinal system**

*Hippocampus.* 2004; **14**:1026-1039

80.

van Strien, N.M. ∙ Cappaert, N.L. ∙ Witter, M.P.

**The anatomy of memory: an interactive overview of the parahippocampal-hippocampal network**

*Nat. Rev. Neurosci.* 2009; **10**:272-282

), or via additional neocortical regions (

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

).

While our results provide support that big-loop recurrence at the point of retrieval (i.e., during performance of AC test trials) supports performance in the PAI task, it is important to note that empirical evidence suggests that encoding-based mechanisms may also play a role (

5.

Banino, A. ∙ Koster, R. ∙ Hassabis, D....

**Retrieval-based model accounts for striking profile of episodic memory and generalization**

*Sci. Rep.* 2016; **6**:31330

17.

Collin, S.H. ∙ Milivojevic, B. ∙ Doeller, C.F.

**Memory hierarchies map onto the hippocampal long axis in humans**

*Nat. Neurosci.* 2015; **18**:1562-1564

39.

Kumaran, D.

**What representations and computations underpin the contribution of the hippocampus to generalization and inference?**

*Front. Hum. Neurosci.* 2012; **6**:157

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

51.

Milivojevic, B. ∙ Vicente-Grabovetsky, A. ∙ Doeller, C.F.

**Insight reconfigures hippocampal-prefrontal memories**

*Curr. Biol.* 2015; **25**:821-830

67.

Schlichting, M. ∙ Preston, A.

**The Hippocampus and Memory Integration: Building Knowledge to Navigate Future Decisions**

Springer International Publishing, 2017 405-437

[Google Scholar](https://scholar.google.com/scholar_lookup?title=The+Hippocampus+and+Memory+Integration%3A+Building+Knowledge+to+Navigate+Future+Decisions&author=M.+Schlichting&author=A.+Preston&publication_year=2017&pages=405-437)

86.

Zeithamova, D. ∙ Preston, A.R.

**Flexible memories: differential roles for medial temporal lobe and prefrontal cortex in cross-episode binding**

*J. Neurosci.* 2010; **30**:14676-14684

87.

Zeithamova, D. ∙ Dominick, A.L. ∙ Preston, A.R.

**Hippocampal and ventral medial prefrontal activation during retrieval-mediated learning supports novel inference**

*Neuron.* 2012; **75**:168-179

). Indeed, while our results are consistent with two computational models that incorporate big-loop recurrence (

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

66.

Schapiro, A.C. ∙ Turk-Browne, N.B. ∙ Botvinick, M.M....

**Complementary learning systems within the hippocampus: a neural network modelling approach to reconciling episodic memory with statistical learning**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2017; **372**:20160049

), these models have a key difference: the latter model additionally incorporates a mechanism that allows the gradual encoding of overlapping representations that stably capture the statistics and commonalities among related experiences (

21.

Eichenbaum, H. ∙ Dudchenko, P. ∙ Wood, E....

**The hippocampus, memory, and place cells: is it spatial memory or a memory space?**

*Neuron.* 1999; **23**:209-226

65.

Schapiro, A.C. ∙ Gregory, E. ∙ Landau, B....

**The necessity of the medial temporal lobe for statistical learning**

*J. Cogn. Neurosci.* 2014; **26**:1736-1747

66.

Schapiro, A.C. ∙ Turk-Browne, N.B. ∙ Botvinick, M.M....

**Complementary learning systems within the hippocampus: a neural network modelling approach to reconciling episodic memory with statistical learning**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2017; **372**:20160049

70.

Shohamy, D. ∙ Turk-Browne, N.B.

**Mechanisms for widespread hippocampal involvement in cognition**

*J. Exp. Psychol. Gen.* 2013; **142**:1159-1170

). This is mediated by relatively slow learning within a pathway directly connecting the EC to the CA1 region of the hippocampus (termed the monosynaptic pathway; [Figure S1](#mmc1)). As such, the model by

66.

Schapiro, A.C. ∙ Turk-Browne, N.B. ∙ Botvinick, M.M....

**Complementary learning systems within the hippocampus: a neural network modelling approach to reconciling episodic memory with statistical learning**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2017; **372**:20160049

can be considered a hybrid model that incorporates the principles of big-loop recurrence (

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

) as well as an encoding-based mechanism. Given the slow learning nature of the encoding-based mechanism, big-loop recurrence is viewed to be critical to rapidly appreciating the structure among experiences in the PAI and related tasks after few stimulus repetitions before the MSP has had a chance to learn—that is, after a single exposure in computational simulations (

66.

Schapiro, A.C. ∙ Turk-Browne, N.B. ∙ Botvinick, M.M....

**Complementary learning systems within the hippocampus: a neural network modelling approach to reconciling episodic memory with statistical learning**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2017; **372**:20160049

) and two exposures in our experiment. After more extended stimulus repetitions, the MSP is viewed to play a dominant role in capturing and exploiting the structure among related experiences, though big-loop recurrence is still viewed to contribute (

66.

Schapiro, A.C. ∙ Turk-Browne, N.B. ∙ Botvinick, M.M....

**Complementary learning systems within the hippocampus: a neural network modelling approach to reconciling episodic memory with statistical learning**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2017; **372**:20160049

). Future work should aim to distinguish between these two big-loop recurrence models by isolating the specific operation of the MSP pathway. More generally, it will be important to characterize the conditions that favor capturing the structure of experiences on the fly through big-loop recurrent dynamics, as opposed to representing them through static neural codes—considering factors such as task parameters (e.g., the number of item repetitions), the rate of change of the environment (

24.

Gershman, S.J. ∙ Monfils, M.H. ∙ Norman, K.A....

**The computational nature of memory modification**

*eLife.* 2017; **6**:e23763

), and differences along the anterior-posterior axis of the hippocampus (

17.

Collin, S.H. ∙ Milivojevic, B. ∙ Doeller, C.F.

**Memory hierarchies map onto the hippocampal long axis in humans**

*Nat. Neurosci.* 2015; **18**:1562-1564

69.

Schlichting, M.L. ∙ Guarino, K.F. ∙ Schapiro, A.C....

**Hippocampal structure predicts statistical learning and associative inference abilities during development**

*J. Cogn. Neurosci.* 2017; **29**:37-51

).

Recent computational models have been proposed that marry the competing functions of the hippocampus in episodic memory and the integration of information across episodes (

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

66.

Schapiro, A.C. ∙ Turk-Browne, N.B. ∙ Botvinick, M.M....

**Complementary learning systems within the hippocampus: a neural network modelling approach to reconciling episodic memory with statistical learning**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2017; **372**:20160049

). Critically, these have incorporated big-loop recurrence as a key component, which until now has lacked empirical support. In providing the first empirical evidence for big-loop recurrence, our study encourages a rethinking of classical theories of information flow within the hippocampal system. Further, our work provides a novel algorithmic framework whereby the hippocampus can rapidly represent a set of related experiences through pattern separated codes—thereby preserving memory for individual experiences—while big-loop recurrence creates a dynamic memory space at the point of retrieval, thereby allowing the rapid appreciation of their commonalities and higher-order structure. Interestingly, the algorithm realized through big-loop recurrence (

40.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

) has striking parallels with cutting-edge machine learning neural network architectures that utilize external memory to solve problems of real world relevance, typically referred to as “question answering,” in which a set of sentences must be retained over a period time following which questions are posed ([Figure S9](#mmc1)). Notably, these tasks pose exactly the same challenge that we highlight here (e.g.,

75.

Sukhbaatar, S. ∙ Szlam, A. ∙ Weston, J....

**End-to-end memory networks**

*Adv. Neural Inf. Process. Syst.* 2015; **28**:2440-2448

[Google Scholar](https://scholar.google.com/scholar_lookup?title=End-to-end+memory+networks&author=S.+Sukhbaatar&author=A.+Szlam&author=J.+Weston&author=R.+Fergus&publication_year=2015&pages=2440-2448)

, see also

26.

Graves, A. ∙ Wayne, G. ∙ Reynolds, M....

**Hybrid computing using a neural network with dynamic external memory**

*Nature.* 2016; **538**:471-476

)—how to integrate information across separate episodes while preserving their individual features—and would be predicted to be difficult for encoding-based models (e.g.,

67.

Schlichting, M. ∙ Preston, A.

**The Hippocampus and Memory Integration: Building Knowledge to Navigate Future Decisions**

Springer International Publishing, 2017 405-437

[Google Scholar](https://scholar.google.com/scholar_lookup?title=The+Hippocampus+and+Memory+Integration%3A+Building+Knowledge+to+Navigate+Future+Decisions&author=M.+Schlichting&author=A.+Preston&publication_year=2017&pages=405-437)

71.

Shohamy, D. ∙ Wagner, A.D.

**Integrating memories in the human brain: hippocampal-midbrain encoding of overlapping events**

*Neuron.* 2008; **60**:378-389

) to solve ([Figure S2](#mmc1)). In the future, it will be important to establish the relative contribution of big-loop recurrence, as compared to encoding-based mechanisms, to combining information across multiple related experiences in the service of adaptive behavior.

## STAR★Methods

### Key Resources Table

<table><thead><tr><th>REAGENT or RESOURCE</th><th>SOURCE</th><th>IDENTIFIER</th></tr></thead><tbody><tr><td colspan="3"><b>Software and Algorithms</b></td></tr><tr><td>MATLAB</td><td>Mathworks</td><td><a href="https://www.mathworks.com/">https://www.mathworks.com</a></td></tr><tr><td>Python</td><td>Python Software Foundation</td><td><a href="https://www.python.org/">https://www.python.org</a></td></tr><tr><td>Presentation Version 18.0</td><td>Neurobehavioral Systems</td><td><a href="http://www.neurobs.com/">http://www.neurobs.com/</a></td></tr><tr><td>Bank of Standardized Stimuli</td><td><p>9.</p><p>Brodeur, M.B. ∙ Dionne-Dostie, E. ∙ Montreuil, T....</p><p><strong>The Bank of Standardized Stimuli (BOSS), a new set of 480 normative photos of objects to be used as visual stimuli in cognitive research</strong></p><p><em>PLoS ONE.</em> 2010; <strong>5</strong>:e10773</p><p><a href="https://doi.org/10.1371/journal.pone.0010773">Crossref</a></p><p><a href="https://www.cell.com/servlet/linkout?suffix=e_1_5_1_2_9_2&dbid=137438953472&doi=10.1016%2Fj.neuron.2018.08.009&key=2-s2.0-77956511196">Scopus (458)</a></p><p><a href="https://pubmed.ncbi.nlm.nih.gov/20532245/">PubMed</a></p><p><a href="https://scholar.google.com/scholar_lookup?title=The+Bank+of+Standardized+Stimuli+%28BOSS%29%2C+a+new+set+of+480+normative+photos+of+objects+to+be+used+as+visual+stimuli+in+cognitive+research&author=M.B.+Brodeur&author=E.+Dionne-Dostie&author=T.+Montreuil&author=M.+Lepage&publication_year=2010&pages=e10773&doi=10.1371%2Fjournal.pone.0010773&pmid=20532245">Google Scholar</a></p></td><td><a href="https://sites.google.com/site/bosstimuli/">https://sites.google.com/site/bosstimuli/</a></td></tr><tr><td>Glasgow Unfamiliar Face Database</td><td><p>11.</p><p>Burton, A.M. ∙ White, D. ∙ McNeill, A.</p><p><strong>The glasgow face matching test</strong></p><p><em>Behav. Res. Methods.</em> 2010; <strong>42</strong>:286-291</p><p><a href="https://doi.org/10.3758/BRM.42.1.286">Crossref</a></p><p><a href="https://www.cell.com/servlet/linkout?suffix=e_1_5_1_2_11_2&dbid=137438953472&doi=10.1016%2Fj.neuron.2018.08.009&key=2-s2.0-77952534987">Scopus (424)</a></p><p><a href="https://pubmed.ncbi.nlm.nih.gov/20160307/">PubMed</a></p><p><a href="https://scholar.google.com/scholar_lookup?title=The+glasgow+face+matching+test&author=A.M.+Burton&author=D.+White&author=A.+McNeill&publication_year=2010&pages=286-291&doi=10.3758%2FBRM.42.1.286&pmid=20160307">Google Scholar</a></p></td><td><a href="http://www.facevar.com/downloads">http://www.facevar.com/downloads</a></td></tr><tr><td>SPM12</td><td><p>62.</p><p>Penny, W.D. ∙ Friston, K.J. ∙ Ashburner, J.T....</p><p><strong>Statistical Parametric Mapping: The Analysis of Functional Brain Images</strong></p><p>Elsevier, 2011</p><p><a href="https://scholar.google.com/scholar_lookup?title=Statistical+Parametric+Mapping%3A+The+Analysis+of+Functional+Brain+Images&author=W.D.+Penny&author=K.J.+Friston&author=J.T.+Ashburner&author=S.J.+Kiebel&author=T.E.+Nichols&publication_year=2011">Google Scholar</a></p></td><td><a href="https://www.fil.ion.ucl.ac.uk/spm/software/">https://www.fil.ion.ucl.ac.uk/spm/software/</a></td></tr><tr><td>FSL</td><td><p>72.</p><p>Smith, S.M. ∙ Jenkinson, M. ∙ Woolrich, M.W....</p><p><strong>Advances in functional and structural MR image analysis and implementation as FSL</strong></p><p><em>Neuroimage.</em> 2004; <strong>23</strong> (Suppl 1):S208-S219</p><p><a href="https://doi.org/10.1016/j.neuroimage.2004.07.051">Crossref</a></p><p><a href="https://www.cell.com/servlet/linkout?suffix=e_1_5_1_2_72_2&dbid=137438953472&doi=10.1016%2Fj.neuron.2018.08.009&key=2-s2.0-7044260964">Scopus (10407)</a></p><p><a href="https://pubmed.ncbi.nlm.nih.gov/15501092/">PubMed</a></p><p><a href="https://scholar.google.com/scholar_lookup?title=Advances+in+functional+and+structural+MR+image+analysis+and+implementation+as+FSL&author=S.M.+Smith&author=M.+Jenkinson&author=M.W.+Woolrich&author=C.F.+Beckmann&author=T.E.+Behrens&author=H.+Johansen-Berg&author=P.R.+Bannister&author=M.+De+Luca&author=I.+Drobnjak&author=D.E.+Flitney&publication_year=2004&pages=S208-S219&doi=10.1016%2Fj.neuroimage.2004.07.051&pmid=15501092">Google Scholar</a></p></td><td><a href="https://fsl.fmrib.ox.ac.uk/fsl/fslwiki">https://fsl.fmrib.ox.ac.uk/fsl/fslwiki</a></td></tr><tr><td>ANTs</td><td><p>3.</p><p>Avants, B.B. ∙ Epstein, C.L. ∙ Grossman, M....</p><p><strong>Symmetric diffeomorphic image registration with cross-correlation: evaluating automated labeling of elderly and neurodegenerative brain</strong></p><p><em>Med. Image Anal.</em> 2008; <strong>12</strong>:26-41</p><p><a href="https://www.cell.com/servlet/linkout?suffix=e_1_5_1_2_3_2&dbid=4&doi=10.1016%2Fj.neuron.2018.08.009&key=10.1016%2Fj.media.2007.06.004&cf=fulltext&site=medima-site">Full Text</a></p><p><a href="https://www.cell.com/servlet/linkout?suffix=e_1_5_1_2_3_2&dbid=4&doi=10.1016%2Fj.neuron.2018.08.009&key=10.1016%2Fj.media.2007.06.004&cf=pdf&site=medima-site">Full Text (PDF)</a></p><p><a href="https://www.cell.com/servlet/linkout?suffix=e_1_5_1_2_3_2&dbid=137438953472&doi=10.1016%2Fj.neuron.2018.08.009&key=2-s2.0-38849187993">Scopus (3537)</a></p><p><a href="https://pubmed.ncbi.nlm.nih.gov/17659998/">PubMed</a></p><p><a href="https://scholar.google.com/scholar_lookup?title=Symmetric+diffeomorphic+image+registration+with+cross-correlation%3A+evaluating+automated+labeling+of+elderly+and+neurodegenerative+brain&author=B.B.+Avants&author=C.L.+Epstein&author=M.+Grossman&author=J.C.+Gee&publication_year=2008&pages=26-41&doi=10.1016%2Fj.media.2007.06.004&pmid=17659998">Google Scholar</a></p><p>4.</p><p>Avants, B.B. ∙ Tustison, N.J. ∙ Song, G....</p><p><strong>A reproducible evaluation of ANTs similarity metric performance in brain image registration</strong></p><p><em>Neuroimage.</em> 2011; <strong>54</strong>:2033-2044</p><p><a href="https://doi.org/10.1016/j.neuroimage.2010.09.025">Crossref</a></p><p><a href="https://www.cell.com/servlet/linkout?suffix=e_1_5_1_2_4_2&dbid=137438953472&doi=10.1016%2Fj.neuron.2018.08.009&key=2-s2.0-78650181934">Scopus (2970)</a></p><p><a href="https://pubmed.ncbi.nlm.nih.gov/20851191/">PubMed</a></p><p><a href="https://scholar.google.com/scholar_lookup?title=A+reproducible+evaluation+of+ANTs+similarity+metric+performance+in+brain+image+registration&author=B.B.+Avants&author=N.J.+Tustison&author=G.+Song&author=P.A.+Cook&author=A.+Klein&author=J.C.+Gee&publication_year=2011&pages=2033-2044&doi=10.1016%2Fj.neuroimage.2010.09.025&pmid=20851191">Google Scholar</a></p></td><td><a href="http://stnava.github.io/ANTs/">http://stnava.github.io/ANTs/</a></td></tr><tr><td>GLMnet</td><td><p>64.</p><p>Qian, J. ∙ Hastie, T. ∙ Friedman, J....</p><p><strong>Glmnet for matlab</strong></p><p>Stanford University, 2013</p><p><a href="https://scholar.google.com/scholar_lookup?title=Glmnet+for+matlab&author=J.+Qian&author=T.+Hastie&author=J.+Friedman&author=R.+Tibshirani&author=N.+Simon&publication_year=2013">Google Scholar</a></p></td><td><a href="https://web.stanford.edu/%7Ehastie/glmnet_matlab/">https://web.stanford.edu/∼hastie/glmnet_matlab/</a></td></tr><tr><td>Nonparametric Toolbox</td><td><p>56.</p><p>Nichols, T.E. ∙ Holmes, A.P.</p><p><strong>Nonparametric permutation tests for functional neuroimaging: a primer with examples</strong></p><p><em>Hum. Brain Mapp.</em> 2002; <strong>15</strong>:1-25</p><p><a href="https://doi.org/10.1002/hbm.1058">Crossref</a></p><p><a href="https://www.cell.com/servlet/linkout?suffix=e_1_5_1_2_56_2&dbid=137438953472&doi=10.1016%2Fj.neuron.2018.08.009&key=2-s2.0-0036136472">Scopus (4943)</a></p><p><a href="https://pubmed.ncbi.nlm.nih.gov/11747097/">PubMed</a></p><p><a href="https://scholar.google.com/scholar_lookup?title=Nonparametric+permutation+tests+for+functional+neuroimaging%3A+a+primer+with+examples&author=T.E.+Nichols&author=A.P.+Holmes&publication_year=2002&pages=1-25&doi=10.1002%2Fhbm.1058&pmid=11747097">Google Scholar</a></p></td><td><a href="https://warwick.ac.uk/snpm">https://warwick.ac.uk/snpm</a></td></tr></tbody></table>

- [Open table in a new tab](https://www.cell.com/action/showFullTableHTML?isHtml=true&tableId=undtbl1&pii=S0896-6273%2818%2930682-2)

### Contact for Reagent and Resource Sharing

Further information and requests for resources should be directed to and will be fulfilled by the Lead Contact, Raphael Koster ([rkoster@google.com](mailto:rkoster@google.com)).

### Experimental Model and Subject Details

#### Subjects

Twenty-six subjects (recruited via the Otto-von-Guericke University Magdeburg participant database, mean age 27.5 ± 3.9 years, 12 males) participated in the study and were included in the analysis. Exclusion criteria were metallic implants (other than standard dental implants), tinnitus, known metabolic disorders or a history of neurological or psychiatric disorders. This study was approved by the ethics committee of the Otto-von-Guericke University Magdeburg. All subjects gave written informed consent before participation. A total of four subjects completed the experiment but were excluded from further analysis. Three subjects were excluded due to strong signal dropout in the EC determined by visual inspection of the mean EPI image. One subject was excluded due to poor performance on the paired associate inference task (below chance performance in AC inference trials).

### Method Details

#### Stimuli

The stimuli consisted of 432 digital color photographic images: 72 objects (Bank of Standardized Stimuli;

9.

Brodeur, M.B. ∙ Dionne-Dostie, E. ∙ Montreuil, T....

**The Bank of Standardized Stimuli (BOSS), a new set of 480 normative photos of objects to be used as visual stimuli in cognitive research**

*PLoS ONE.* 2010; **5**:e10773

), 72 scenes (obtained from various sources on the internet) and 288 faces (Glasgow Unfamiliar Face Database;

11.

Burton, A.M. ∙ White, D. ∙ McNeill, A.

**The glasgow face matching test**

*Behav. Res. Methods.* 2010; **42**:286-291

). All images’ mean value was adjusted to the same value. The fixation target was a white fixation cross in the middle of a black screen. Participants watched the stimuli through a mirror mounted on the head coil. Note that for display purposed, depictions of the stimuli displaying faces and scenes in this paper are license-free images obtained from the internet.

#### Task

During the fMRI session, subjects performed an adapted version of the paired associate inference task (

5.

Banino, A. ∙ Koster, R. ∙ Hassabis, D....

**Retrieval-based model accounts for striking profile of episodic memory and generalization**

*Sci. Rep.* 2016; **6**:31330

87.

Zeithamova, D. ∙ Dominick, A.L. ∙ Preston, A.R.

**Hippocampal and ventral medial prefrontal activation during retrieval-mediated learning supports novel inference**

*Neuron.* 2012; **75**:168-179

). For each subject, the stimuli were randomly organized into 144 triplets (ABC; Face-Object-Face (FOF) or Face-Scene-Face (FSF)). Every experimental block utilized 16 different triplets. Each subject completed one scanning session, which contained 3 functional runs. Each functional run contained three experimental blocks (one cycle of training and test utilizing 16 triplets – see below). Each block lasted approximately 7 min resulting in a total experimental time in the scanner of 63 min. Before the scanning, subjects completed a training session consisting of a shortened experimental block. The training was completed once at a self paced speed and once with time-limits exactly like the scanning version of the experiment.

#### Training block

The training block consisted of being exposed to pairs of stimuli presented next to each other on the screen for 2.5 s each followed by a 0.5 s fixation screen. First, 16 AB (Face-Object or Face-Scene) pairs were shown in random order. Then, the 16 corresponding BC (Object-Face or Scene-Face) pairs were shown in the order following the initial AB presentation. Then, the entire sequence of 16 AB and 16 BC presentations was repeated in the same order. Which of the two images was presented on the left or right side of the screen was randomized across trials.

#### Test block

The test block contained three test trials for each of 16 triplets (48 total): direct (i.e., AB and BC) and indirect (AC inference) test trials (see below for details). Each test screen presented one face at the top of the screen (A for AB trials, C for BC trials and A for AC trials) and two images on the bottom of the screen: the target (B for AB trials, B for BC trials and C for AC trials) and the lure. The lure picture was the same scene/object category as the target (or in case of AC trials, associated with the same category) but chosen from a different triplet of the same block. This ensured that the task could not be solved with a category level memory, or with familiarity (i.e., since both choice items were equally familiar). The left-right location of the target and lure was randomized across trials. Subjects were tasked with identifying which of the two bottom pictures was in the same triplet as the picture presented at the top of the screen with a left or right button press.

Solution of the AB and BC test trials can be solved via direct associations, as in each case the pictures were presented together. By contrast, AC trials can only be solved by inferring the connection via the shared linking picture B – hence items A and C were indirectly associated. Importantly, during the AC trials, three faces were displayed on the screen and no object or scene, as A and C were always faces in each triplet. This ensured that any successful classification of objects versus scenes could only be driven by reactivation of the linking image (B). The screen of the test question was displayed for 5 s during which subjects could submit their response. After 5 s the chosen option was outlined with a green square for 0.5 s or, if subjects failed to respond the words ’too slow’ were displayed for 0.5 s. Each trial was concluded with a fixation screen for 0.5 s. The trial order of the 48 test trials was random, but constrained such that for each triplet, the AC test trial had to be presented before the AB or BC trial from the same triplet. This was done to not contaminate the AC test with learning or exposure from previous trials of the same triplet. The experiment was performed using Presentation software (Version 18.0, Neurobehavioral Systems, Berkeley, CA, [http://www.neurobs.com/](http://www.neurobs.com/)).

### Quantification and Statistical Analysis

#### Behavioral analysis

Behavior was assessed in terms of choice accuracy (i.e., belonging to the same triplet as the stimuli displayed at the top of the screen) and choice reaction time. Differences in these measures were assessed with one way ANOVAs (with the levels AB, BC and AC) and paired t tests for comparisons of individual conditions. For reaction time, the same procedure was repeated only on correctly answered trials.

#### F/MRI data acquisition

MRI data were acquired using a 7T MR system (Siemens, Erlangen, Germany). A 32-channel head coil was used (Nova Medical). Before the fMRI session, a whole-head MPRAGE volume (TE = 2.8 ms, TR = 2500 ms, TI = 1050 ms, flip angle = 5°, resolution = 0.8 mm isotropic, hereinafter ‘T1’) was acquired. The slices were acquired in an odd-even interleaved fashion oriented parallel to the hippocampus longitudinal axis. EPIs were motion corrected by the sequence built-in algorithm during the online reconstruction (

76.

Thesen, S. ∙ Heid, O. ∙ Mueller, E....

**Prospective acquisition correction for head motion with image-based tracking for real-time fMRI**

*Magn. Reson. Med.* 2000; **44**:457-465

) and distortion corrected using a point spread function mapping method (

35.

In, M.H. ∙ Speck, O.

**Highly accelerated PSF-mapping for EPI distortion correction with improved fidelity**

*MAGMA.* 2012; **25**:183-192

). Each subject’s fMRI scan consisted of 720 volumes, each comprising 28 T2 <sup>∗</sup> -weighted echo planar (hereinafter ’EPI’) slices with a resolution of 0.8 × 0.8 mm (TE = 22 ms, TR = 2000 ms, slice thickness = 0.8 mm, FOV = 205 mm, matrix = 256 × 256, partial Fourier = 5/8, parallel imaging with grappa factor 4, bandwidth = 1028 Hz/Pixel, echo spacing = 1.1 ms, echo train length = 40, flip angle = 90°) in each of 3 functional runs. After that, the high resolution partial structural volume was acquired (Turbo Spin echo (TSE) with hyperecho (flip angle 60°), TE = 76 ms, TR = 8000 ms, band width = 155 Hz/Pixel, turbo factor 9, 55 slices of 1mm thickness and 10% gap, FOV = 224 mm, matrix = 512 × 512 resulting in an effective spatial resolution of 0.44 mm x 0.44 mm x 1.1 mm, hereinafter ’T2′), with a slice alignment orthogonal to the hippocampal longitudinal axis.

#### Anatomical ROIs in MTL

##### Automated segmentation of MTL (ASHS)

For completeness, we briefly describe here the algorithmic scheme of the ASHS software (

85.

Yushkevich, P.A. ∙ Pluta, J.B. ∙ Wang, H....

**Automated volumetry and regional thickness analysis of hippocampal subfields and medial temporal cortical structures in mild cognitive impairment**

*Hum. Brain Mapp.* 2015; **36**:258-287

). Utilizing structural information from both T1 and T2 images, ASHS generates anatomical labels according to a customizable atlas, in which labels were manually defined on the T2 images. For a new, unlabelled brain volume, ASHS evaluates its similarity to each of the labeled brain volumes in the atlas and, using this similarity as weights, produces a probabilistic labeling for the new brain. The final labels of the brain are determined by combining the probabilistic labeling and the gray values in the new brain, using a Bayesian approach. In our case, the atlas consisted of 38 young healthy individuals from another dataset, of which hippocampal subfields (CA1, CA2, CA3, dentate gyrus (DG) and subiculum (SUB)) as well as extrahippocampal subregions (perirhinal (PRC), entorhinal (EC) and parahippocampal cortex (PHC)) were manually segmented and cross-examined by experienced segmentation experts. Importantly, these structural images for atlas building were acquired in the same scanner with exactly the same scanning protocol. In so doing we aimed to maximize the compatibility between the atlas and the current dataset. The labels of the manual segmentation, thus also of the automated segmentation output, include both cortical regions in MTL: PHC, PRC (consisting of A35 and A36) and EC, and hippocampal subfields: CA1, CA2, CA3, DG, SUB. Hippocampal subfield segmentation followed the protocol from Wisse and colleagues (

83.

Wisse, L.E. ∙ Gerritsen, L. ∙ Zwanenburg, J.J....

**Subfields of the hippocampal formation at 7 T MRI: in vivo volumetric assessment**

*Neuroimage.* 2012; **61**:1043-1049

). Manual delineation of extrahippocampal regions was mainly based on the protocol from Berron and colleagues with a few adaptations, described below (

6.

Berron, D. ∙ Vieweg, P. ∙ Hochkeppler, A....

**A protocol for manual segmentation of medial temporal lobe subregions in 7 Tesla MRI**

*Neuroimage Clin.* 2017; **15**:466-482

). Delineation of PRC and EC started 3 slices anterior to the hippocampal head. PRC consisted of area 35 and 36 which included the medial and the lateral bank of the collateral sulcus. The posterior border of the PRC and EC was the first slice of the hippocampal body defined by the disappearance of the uncal apex. This was also the starting point for the delineation of the PHC which contained both lateral and medial banks of the collateral sulcus and was segmented until the last slice of the hippocampal tail.

##### Cortical layer separation

As demonstrated previously (), dividing the EC into 3 layers can capture cytoarchitectural features of the EC. The superficial third (referred to here as ’sEC’) of the human EC mainly covers EC layer II and likely parts of EC layer III, projecting into DG/CA3 and CA1, respectively. The deep third (referred to here as ’dEC’) mostly covers layer V and VI and is the main output of the HC. The middle layer is excluded from the analysis as functional interpretations are less certain (see for details).

Our approach to separate the binary mask of EC into 3 different layers is based on shape analysis and cortical thickness estimation. To avoid the aliasing artifacts due to the anisotropic acquisition of the T2 images, we first smoothed the binary mask of EC in T2 space with a Gaussian kernel (FWHM = 1.1mm), and resampled the smoothed mask to an isotropic resolution of 0.22 × 0.22 × 0.22 mm <sup>3</sup> ([Figures S6](#mmc1) C1 and S6C2).

Boundary voxels of the mask in this super-sampled image were identified by using an isosurface method with a volume-preserving threshold, i.e.where *I* is the smoothed and super-sampled image, the binary mask image in T2 space, and are their respective voxel volumes.

We further take the smoothed volume as a probabilistic image of the mask, and the gradient vector of this image at each voxel as a potential direction along which the cortical thickness can be estimated. For each boundary voxel, we then estimated the cortical thickness by approximating a line integral along the gradient direction ([Figure S6](#mmc1) C3). More specifically, we took sum of dense samples along the direction:where is the location of a boundary voxel, and the normalized gradient vector at **x**. In implementation, we used a sampling density of 0.06mm, and took 100 samples along each gradient direction, presuming the maximal thickness < 6mm.

This procedure gave us, for each boundary voxel, an estimate of the cortical thickness in the direction perpendicular to the local boundary surface. Notably, only those voxels on the pial or gray-white matter surfaces provide useful cortical thickness information for laminar separation. We thus removed the voxels residing on the boundaries next to neighboring regions of gray matter, using an automated approach. Specifically, as shown in [Figure S6](#mmc1) C3, voxels falling at these gray matter borders will have much greater estimates of “cortical thickness” than those on the pial or gray-white matter surfaces. We therefore remove all voxels with a cortical thickness estimate greater than ([Figure S6](#mmc1) C4) to automatically detect these outlying values. For the remaining voxels, we started from each boundary voxel, along its gradient direction, to include all the voxels lying within 1/3 of its thickness to form each segment of the mask. [Figure S6](#mmc1) C shows the layer mask after this growing procedure.

Note that despite the illustration in [Figure S6](#mmc1) C is in 2D, the actual shape analysis was all done in 3D space, thus avoiding the view-specific limitation of fully manual separation. Furthermore, all anatomical ROIs and masks of separated layers were subsequently examined and, when necessary, corrected manually. Voxels in which two ROIs overlapped after the growing procedure were removed from the mask with lower probability in that voxel. [Figure S6](#mmc1) A shows a summary of these ROIs on all subjects.

##### Cross-modal registration and mapping of ROIs

To precisely extract the layer-specific activity patterns in a cortical area of average thickness ≤ 3mm and measured with imaging resolution of 0.8mm, the separated layer masks of EC in the anatomical image space have to be very accurately transformed into the functional image space. Moreover, due to the partial-coverage scanning protocol, the overlap between the T2 image space, in which the anatomical ROIs were defined, and the functional image space was often too limited to provide reliable registration. Therefore for each subject, the whole brain T1 image was used as a proxy for transforming the ROI masks to the functional image space. Specifically, to obtain the final masks for functional activity extraction, two registration steps were involved: one from the T2 to the T1 and another from the T1 to the functional image.

For every pair of images of each subject, we used the registration tools from 3 software packages: SPM, FSL (

72.

Smith, S.M. ∙ Jenkinson, M. ∙ Woolrich, M.W....

**Advances in functional and structural MR image analysis and implementation as FSL**

*Neuroimage.* 2004; **23** (Suppl 1):S208-S219

) and ANTs (

3.

Avants, B.B. ∙ Epstein, C.L. ∙ Grossman, M....

**Symmetric diffeomorphic image registration with cross-correlation: evaluating automated labeling of elderly and neurodegenerative brain**

*Med. Image Anal.* 2008; **12**:26-41

4.

Avants, B.B. ∙ Tustison, N.J. ∙ Song, G....

**A reproducible evaluation of ANTs similarity metric performance in brain image registration**

*Neuroimage.* 2011; **54**:2033-2044

). Mutual information optimization criteria were used and registration transformation was limited to rigid transform. Field bias of T1 images was corrected using SPM before running registration, to minimize the adverse influence of intensity inhomogeneity on the registration algorithms. In addition to carefully manual examination of the registration results, we set an independent criterion to assess the registration quality objectively: we calculated the agreement between gradient directions at the mask boundaries and that of the target image, after applying the transformation. Here the target image designates the space into which anatomical ROIs were transformed. Based on this boundary gradient agreement criterion, we chose from the 3 registration results the best transformation for mapping the anatomical ROIs to the functional image space.

When mapping the separated layer masks from the super-sampled image space for functional activity pattern extraction, we again adopted a volume-preserving strategy: after smoothing the ROI masks with a Gaussian kernel (FWHM = 1mm) to a probabilistic mask, we applied the transform matrices and re-thresholded the probabilistic mask to preserve its original binary volume. This strategy also enabled us to resolve cases of partially overlapped voxels by selecting the ROI label with the highest probability. [Figure S6](#mmc1) E shows the separated EC layers from the left hemisphere of a typical subject, in the super-sampled space and after transformation into the functional image space.

#### FMRI data preprocessing

fMRI preprocessing and statistical modeling of the fMRI data was conducted using SPM12 (Wellcome Trust Centre for Neuroimaging, University College London;

62.

Penny, W.D. ∙ Friston, K.J. ∙ Ashburner, J.T....

**Statistical Parametric Mapping: The Analysis of Functional Brain Images**

Elsevier, 2011

[Google Scholar](https://scholar.google.com/scholar_lookup?title=Statistical+Parametric+Mapping%3A+The+Analysis+of+Functional+Brain+Images&author=W.D.+Penny&author=K.J.+Friston&author=J.T.+Ashburner&author=S.J.+Kiebel&author=T.E.+Nichols&publication_year=2011)

). Subsequent analyses were run using MATLAB. As images were already corrected for distortions and for motion (see “ [F/MRI data acquisition](#sec-4-5-2) ” section), the preprocessing consisted solely of slice timing correction using default settings. For the multivariate decoding analysis, data were left unsmoothed to preserve the patterns of activation at high spatial resolution. Six volumes that were acquired before the experiment started were discarded. To estimate brain activity for every single trial enabling multi-voxel pattern classification analysis, we computed a separate general linear model (GLM) for each trial (). For each subject, 1008 GLMs were created, containing the onset of the picture presentation for all training and test trials. Each GLM contains two conditions modeling the scans of one experimental block: the first regressor contained the event (onset of train or test trial) to be modeled in this GLM, the second regressor contained all other events (all other onsets of train or test trials) in the experimental block (one cycle of training and test). Additionally, each model contained 6 regressors of no interest containing motion correction parameters to account for task-related motion. The GLM estimated all voxels contained within a combined mask comprising all anatomical masks of interest created by the automated segmentation (see above). For one subject, the scanner was erroneously stopped before the conclusion of the experiment. For this subject the last 7 trials were excluded. To estimate the activity related to each individual trial, the condition containing the event of interest was contrasted against the condition containing all other events. The resulting t-statistics were used for all multi-voxel pattern classification analyses.

#### Univariate analysis

For the univariate analysis, a first level model was created modeling 3 sessions, each containing the following conditions (onsets of events with duration 0): 1. Encoding Repetition 1 AB Object 2. Encoding Repetition 1 BC Object 3. Encoding Repetition 1 AB Scene 4. Encoding Repetition 1 BC Scene 5. Encoding Repetition 2 AB Object 6. Encoding Repetition 2 BC Object 7. Encoding Repetition 2 AB Scene 8. Encoding Repetition 2 BC Scene 9. Test AB Object 10. Test BC Object 11. Test AC Object 12. Test AB Scene 13. Test BC Scene 14. Test AC Scene 15. Button Presses 16. Fixation periods. We considered the contrasts; ’AB and BC Test conditions Scene versus Object’, ’AC Test conditions Scene versus Object’, ’Fixation against the first 14 conditions (picture display)’ and ’Test AC trials against baseline (zero over all other conditions)’. The resulting t-contrast images were then normalized to the group template created by using ANTs with all the subjects’ T1 whole brain images. The normalized images were then smoothed (Gaussian kernel, FWHM = 4mm) and group level statistics were computed using the nonparametric toolbox (

56.

Nichols, T.E. ∙ Holmes, A.P.

**Nonparametric permutation tests for functional neuroimaging: a primer with examples**

*Hum. Brain Mapp.* 2002; **15**:1-25

). Analyses were restricted to either (a) a mask containing all scanned voxels (the overlap of all subjects’ acquisition windows in template space), (b) an anatomical group MTL, or (b) an anatomical group EC mask. The anatomical masks on the group level were created by normalizing each subject’s anatomical masks into the ANTS template space, averaging them and binarizing them using a threshold chosen via visual inspection.

To investigate Scene and Object (SvO) representations during visual presentation of scenes and objects we considered a contrast of Test AB Scene and Test BC Scene versus Test AB Object and Test BC Object. The SvO representation of reactivated memory content (linking B item) were investigated with a contrast of Test AC Scene versus Test AC Object. We considered the contrasts masked with scanning coverage of all subject and with the anatomical MTL masks for display purposes. In order to investigate a posterior-anterior Scene to Object gradient within the EC (), we masked each subject’s normalized contrast t-image with the group EC mask and collapsed it to one dimension by averaging it to the posterior-anterior axis. We then correlated the average t-value with the voxel position via Pearson correlation, obtaining one correlation value per subject. The inference on the group level was performed via a Wilcoxon sign-rank test. One-tailed significance levels were used due to the directional hypothesis (). We conducted this analysis both for the Test AB/BC SvO contrast as well as the Test AC SvO contrast. We also investigated reinstated memories (Test AC SvO contrast) in a functional region of interest defined by the Test AB/BC SvO contrast. For this, we extracted the average Test AC SvO and Test AC OvS t-value from the top 100 voxels selected for the highest and lowest t-values in the Test AB/BC SvO contrast, respectively. The average t-values were tested against each other with a sign-rank test. Due to the directed hypothesis one-tailed signficance levels were used. To display single subject maps of the SvO and OvS contrasts in AB/BC and AC Test Trials, the contrasts were considered in single subject space and smoothed with a 2mm kernel.

#### Validating layer separation via classification

In order to assess the presence of layer-specific signals in our data, we took a subject-specific, task-independent approach. Based on the preprocessing steps outlined above, each voxel has a response estimate to every trial in the experiment, which we refer to as the temporal response profile of that voxel. The temporal response profile (i.e., features) used for classification were the 1008 values from the t-images modeling each experimental trial, or the 144 values from the AC test trials. For each subject we took the set of voxels in each of the segmented EC layers (sEC and dEC), and trained a logistic ridge-regression classifier (lambda = 0.01) to classify each voxel as belonging to the sEC or dEC based on the temporal response profiles. We used a leave-two-out cross-validation approach, where on each fold, one voxel from each layer was held out (note that when necessary random voxels from the larger layer were discarded to equate the sample size in each layer). This classification procedure was repeated for each voxel in both layers. We calculate the percentage of correctly classified (classifier evidence higher than 0.5 for sEC and lower than 0.5 for dEC) voxels for each subject. Group level statistics were calculated with a sign-rank test on accuracy z-scores calculated for each subject, by placing the actual decoding accuracy value across voxels in a distribution of permuted decoding accuracy values. In order to create this distribution of permuted values, we computed the classification of each voxel 100 times with shuffled labels.

#### Signal intensity, SNR and CNR in EC layers

To assess the overall signal quality in each of the EC layers, we computed and compared a number of metrics. First, we calculated the mean gray value of the mean EPI series of all scans that were acquired during the experiment. Second, tSNR was computed by dividing the mean by the standard deviation of every voxel over the whole timeseries of scans (averaged over the three functional scanning runs separately). Third we considered the univariate contrasts of ’Test AC trials over baseline’ and ’picture presentation over fixation’, to provide two estimates of contrast-to-noise (CNR;

82.

Welvaert, M. ∙ Rosseel, Y.

**On the definition of signal-to-noise ratio and contrast-to-noise ratio for FMRI data**

*PLoS ONE.* 2013; **8**:e77089

). The average over voxels was then calculated for each region. We directly compare the magnitude of the measures in the sEC and dEC using a sign-rank test.

#### FMRI MVPA analysis

In order to assess the reactivation of scene and object information, a classifier was trained to distinguish AC trials associated with triplets containing objects and AC trials associated with triplets containing scenes. Note that during AC trials only faces were displayed on the screen, thus any ability to discriminate between the two trial categories must be due to reactivated memory content. For each region of interest (hippocampus, parahippocampal cortex (PHC), perihinal cortex (PRC), deep and superficial layers of the entorhinal cortex (dEC and sEC)) the activation patterns of each AC test trial were extracted. A logistic ridge-regression classifier was used to assess the presence of significant reactivated category content, using a repeated split, 12-fold cross-validation approach. On each data split, the 72 AC Object trials and 72 AC Scene trials were randomly split into 12-folds; each fold contained 6 AC Object and 6 AC Scene trials in the test set and the remaining trials in the training set (for the subject missing trials one fold contained 5 items each). For each fold, a logistic ridge regression (lambda = 0.01) was fitted to the training set, and the fitted model was used to predict an output value for each of the items in the test set (

64.

Qian, J. ∙ Hastie, T. ∙ Friedman, J....

**Glmnet for matlab**

Stanford University, 2013

[Google Scholar](https://scholar.google.com/scholar_lookup?title=Glmnet+for+matlab&author=J.+Qian&author=T.+Hastie&author=J.+Friedman&author=R.+Tibshirani&author=N.+Simon&publication_year=2013)

). The output value was passed through a softmax function to produce a probabilistic prediction of the trial category. This prediction was used to calculate ‘decoding evidence’ which is the likelihood of the trial being classified correctly. This process was repeated 100 times, each time using a new random split of the data. The predictions of the 100 runs were averaged for more stable decoding estimates (

81.

Varoquaux, G. ∙ Raamana, P.R. ∙ Engemann, D.A....

**Assessing and tuning brain decoders: cross-validation, caveats, and guidelines**

*Neuroimage.* 2017; **145** (Pt B):166-179

). For each subject the decoding evidence was averaged across trials to obtain the overall decoding accuracy. Significance of the decoding accuracy across the population was assessed via a permutation test. The null distribution was obtained for each region for each subject by running the above analyses 1000 times with randomly shuffled trial labels. For each subject a z-score was obtained by scoring the decoding value with respect to the mean and standard deviation of the permuted null distribution. The test assessing significance on the group level was a sign-rank test over the z-scores of the entire group. For this analysis a one-tailed significance level is used, as one would only expect decoding accuracies above chance. Throughout the main text we report bilateral neural signals by averaging the results of the left and right hemisphere per subject (but see [Tables S1](#mmc1) and [S2](#mmc1) for results in each hemisphere separately).

##### Controlling for local vasculature influences

In order to control for the presence of local vasculature influences on the BOLD signal, we ran a control analysis incorporating an additional processing step into the MVPA analysis. We reasoned that, as vasculature artifacts should be spatially local in nature, explicitly removing local correlation between the two layers should minimize their impact. For each voxel in the target layer (e.g., sEC), we found the closest voxel in the opposing layer (e.g., dEC), and regressed the signal out. To ensure that this neighboring voxel represents the local signal, we smoothed that layer beforehand (smoothing kernel 2mm, constrained to smooth within the structure in order to avoid contamination of the signal through other adjacent structures). As a result, each voxel in the sEC did not contain signal shared with the adjacent dEC voxels, and vice versa. The MVPA analysis described above was then repeated using this processed data.

#### FMRI informational connectivity analysis

To investigate whether information is passed directly between the deep and superficial layer of the entorhinal cortex, we used an informational connectivity approach (

1.

Aly, M. ∙ Turk-Browne, N.B.

**Attention promotes episodic encoding by stabilizing hippocampal representations**

*Proc. Natl. Acad. Sci. USA.* 2016; **113**:E420-E429

18.

Coutanche, M.N. ∙ Thompson-Schill, S.L.

**Informational connectivity: identifying synchronized discriminability of multi-voxel patterns across the brain**

*Front. Hum. Neurosci.* 2013; **7**:15

34.

Huffman, D.J. ∙ Stark, C.E.L.

**The influence of low-level stimulus features on the representation of contexts, items, and their mnemonic associations**

*Neuroimage.* 2017; **155**:513-529

). This approach infers informational connectivity from covariation in trial-by-trial decoding accuracy between regions, and is therefore the MVPA analog of functional connectivity methods commonly applied to univariate data. This technique has been shown to be more sensitive than univariate functional connectivity in a classic dataset of visual processing of objects by Haxby et al. (

18.

Coutanche, M.N. ∙ Thompson-Schill, S.L.

**Informational connectivity: identifying synchronized discriminability of multi-voxel patterns across the brain**

*Front. Hum. Neurosci.* 2013; **7**:15

29.

Haxby, J.V. ∙ Gobbini, M.I. ∙ Furey, M.L....

**Distributed and overlapping representations of faces and objects in ventral temporal cortex**

*Science.* 2001; **293**:2425-2430

). Selective connectivity between the sEC and dEC (hereafter ’laminar connectivity’) was measured as the Spearman correlation between the trial-wise decoding accuracy of the two entorhinal layers, while partialling out the decoding evidence of all other regions of interest in the network (DG, CA1, CA2, CA3, PHC, PRC, SUB; see

74.

Striem-Amit, E. ∙ Ovadia-Caro, S. ∙ Caramazza, A....

**Functional connectivity of visual cortex in the blind follows retinotopic organization principles**

*Brain.* 2015; **138**:1679-1695

88.

Zhang, D. ∙ Snyder, A.Z. ∙ Fox, M.D....

**Intrinsic functional relations between human cerebral cortex and thalamus**

*J. Neurophysiol.* 2008; **100**:1740-1748

). Additionally, to rule out that connectivity between layers measured this way is merely an artifact of a general widespread effect in the BOLD response, or spatial correlation between the regions, we added the trial-wise fluctuation in univariate response (the mean t-value of the contrast images over voxels for each trial’s estimated activation pattern) in the sEC and dEC as additional covariates. The resulting correlation coefficients were transformed using Fisher’s z-transform. The group level inference of whether the correlation coefficients are significantly bigger than zero was based on a sign-rank test (one-tailed). See [Figure 4](#fig4) for a schematic depiction of the analysis. To validate this approach we also computed the average correlation coefficient strength (pairwise partial Spearman’s rho while controlling for all regions of interest and the mean t-value of the two EC layers, as above) of all known direct connections between the MTL regions (all pairwise correlations between the two EC layers, DG, CA1, CA3, PHC, PRC and SUB except the indirect connections) and indirect connections (deep EC layer & DG, deep EC layer & CA3, SUB & DG, SUB & CA3, CA1 & DG, PRC & DG, PRC & CA3, PHC & DG, PHC & CA3;

2.

Amaral, D. ∙ Lavenex, P.

**Hippocampal Neuroanatomy**

Oxford University Press, 2009

[Google Scholar](https://scholar.google.com/scholar_lookup?title=Hippocampal+Neuroanatomy&author=D.+Amaral&author=P.+Lavenex&publication_year=2009)

44.

Libby, L.A. ∙ Ekstrom, A.D. ∙ Ragland, J.D....

**Differential connectivity of perirhinal and parahippocampal cortices within human hippocampal subregions revealed by high-resolution functional imaging**

*J. Neurosci.* 2012; **32**:6550-6560

). See [Figure 4](#fig4) D for a depiction of the connectivity graph. If informational connectivity is sensitive to the true underlying anatomical connectivity, we should detect a significant difference between the direct and indirect connections within the MTL as a whole. If the laminar connection is genuine, it should be significantly stronger than the indirect connections. All of the aforementioned informational connectivity comparisons were conducted on bilateral data, by averaging the informational connectivity across hemispheres for each region (hemisphere specific results are reported in [Table S1](#mmc1)). All statistical comparisons were conducted using sign-rank tests on the difference between conditions at the group level. Given the directional nature of the hypothesis (connectivity reflecting known anatomical connections) one-tailed significance levels were used when comparing to the indirect baseline. Additionally, we used a classification approach to determine whether the laminar connectivity is classed as ’direct MTL’ or ’indirect MTL’ connectivity. For this, we trained a classifier (see decoding methods) to distinguish direct and indirect connections for all subjects (one vector with 52 values, the feature being connectivity strength). We then applied the regression equation to the 26 values of the laminar connectivity values. In order to obtain a permuted p value, we placed the mean value of the resulting classification evidence within a distribution of 10000 values obtained by shuffling the ’direct MTL’ and ’indirect MTL labels’.

##### Local vasculature influences on connectivity

Additional to adding the average BOLD signal in each layers as covariate in the pairwise informational connectivity measures, we performed two control analyses to ensure that the connectivity observed between the layers is not due to a vascular artifact. First, as described above with regard to the MVPA analyses, we removed the local spatial influence of one layer on the other, and recomputed the connectivity on the processed data. In the case of the connectivity analysis, we applied a second method of controlling for local vasculature confounds. Specifically, we subdivided the sEC and dEC masks into lateral and medial portions to avoid correlating adjacent voxels (displayed in [Figure S5](#mmc1)). We cut the sEC and dEC into medial and lateral portions by applying a diagonal cut in every coronal slice that aimed to minimize the pairwise size difference between the two medial/lateral sEC and two dEC subregions. We applied the same procedure of decoding Scene/Object reactivation during AC trials in those regions and correlating the decoding accuraries trial-by-trial. This connectivity was always across layer, but now can either be within region (e.g., medial-medial, or lateral-lateral), or across region (medial-lateral). In the latter case, the regions no longer contain any spatially neighboring voxels across the layers, ensuring that any residual connectivity can not be influenced by local vasculature confounds.

#### Individual variation analyses

Each subject’s measure of ”reactivation” was based on the MVPA classification accuracy on the AC inference trials in a given region. Each measure of ”connectivity” was based on the informational connectivity between a given pair of regions, as described in an earlier section. Inference performance was each subject’s accuracy on the AC test trials, which require inference to solve. Here we were interested in assessing the correlation between certain connectivity and reactivation metrics, as well as with behavioral variation in inference performance, at the level of individual variation. For each such analysis, we used a Pearson correlation (partial correlations when additional variables were controlled for), where the p value was obtained via its rank in a permuted distribution of 10000 values (

78.

Tuğran, E. ∙ Kocak, M. ∙ Mirtagioğlu, H....

**A simulation based comparison of correlation coefficients with regard to type i error rate and power**

*Journal of Data Analysis and Information Processing.* 2015; **3**:87

[Crossref](https://doi.org/10.4236/jdaip.2015.33010)

[Google Scholar](https://scholar.google.com/scholar_lookup?title=A%C2%A0simulation+based+comparison+of+correlation+coefficients+with+regard+to+type+i+error+rate+and+power&author=E.+Tu%C4%9Fran&author=M.+Kocak&author=H.+Mirtagio%C4%9Flu&author=S.+Yi%C4%9Fit&author=M.+Mendes&publication_year=2015&pages=87&doi=10.4236%2Fjdaip.2015.33010)

). Where differences between such correlations are reported, the p value is based on the rank compared to a permuted distribution of correlation differences. All tests were one sided due to clear directional hypotheses, unless otherwise stated. All tests were conducted on bilateral data. The key analyses are also reported for the individual hemispheres in [Supplemental Information](#supplementary-material) ([Table S2](#mmc1)). To establish the expected pattern of results under the big-loop hypothesis, we implemented a simulation of between subject variance in Python, details and results of which are described in [Figure S8](#mmc1).

## Acknowledgments

We thank the Leibniz Institute for Neurobiology (LIN) for access to the 7T scanner and Caswell Barry, Matthew Botvinick, Zeb Kurth-Nelson, Adam Santoro, Christopher Summerfield, and Jane X. Wang for helpful discussion. E.D. was supported by the German Research Foundation (SFB 779 A07).

### Author Contributions

D.K., R.K., M.J.C., D.H., Y.C., and A.B. conceived the project. R.K. and Y.C. acquired the data. R.K., M.J.C., Y.C., D.B., D.K., and A.B. analyzed and interpreted the data. D.K., D.H., and E.D. supervised the project. All authors contributed to writing the manuscript.

### Declaration of Interests

The authors declare no conflict of interest.

## Supplemental Information (2)

[PDF (10.16 MB)](https://www.cell.com/cms/10.1016/j.neuron.2018.08.009/attachment/7b589d21-33d2-4db6-9039-d341d8e6ddca/mmc1.pdf)

Document S1. Figures S1–S9 and Tables S1–S4

[PDF (12.32 MB)](https://www.cell.com/cms/10.1016/j.neuron.2018.08.009/attachment/33058d01-4665-4e0d-be89-7dd9dacfec3f/mmc2.pdf)

Document S2. Article plus Supplemental Information

## Supporting Citations

The following references appear in the Supplemental Information:

27.

Hasselmo, M.E.

**The role of acetylcholine in learning and memory**

*Curr. Opin. Neurobiol.* 2006; **16**:710-715

28.

Hasselmo, M.E. ∙ McClelland, J.L.

**Neural models of memory**

*Curr. Opin. Neurobiol.* 1999; **9**:184-188

36.

Ketz, N. ∙ Morkonda, S.G. ∙ O’Reilly, R.C.

**Theta coordinated error-driven learning in the hippocampus**

*PLoS Comput. Biol.* 2013; **9**:e1003067

47.

Maass, A. ∙ Berron, D. ∙ Libby, L.A....

**Functional subregions of the human entorhinal cortex**

*eLife.* 2015; **4**:e06426

59.

O’Reilly, R.C. ∙ Rudy, J.W.

**Conjunctive representations in learning and memory: principles of cortical and hippocampal function**

*Psychol. Rev.* 2001; **108**:311-345

.

## References

[1.](#body-ref-sref18-1 "View in article")

Aly, M. ∙ Turk-Browne, N.B.

**Attention promotes episodic encoding by stabilizing hippocampal representations**

*Proc. Natl. Acad. Sci. USA.* 2016; **113**:E420-E429

[2.](#fig4 "View in article")

Amaral, D. ∙ Lavenex, P.

**Hippocampal Neuroanatomy**

Oxford University Press, 2009

[Google Scholar](https://scholar.google.com/scholar_lookup?title=Hippocampal+Neuroanatomy&author=D.+Amaral&author=P.+Lavenex&publication_year=2009)

[3.](#body-ref-sref4-1 "View in article")

Avants, B.B. ∙ Epstein, C.L. ∙ Grossman, M....

**Symmetric diffeomorphic image registration with cross-correlation: evaluating automated labeling of elderly and neurodegenerative brain**

*Med. Image Anal.* 2008; **12**:26-41

[4.](#body-ref-sref4-1 "View in article")

Avants, B.B. ∙ Tustison, N.J. ∙ Song, G....

**A reproducible evaluation of ANTs similarity metric performance in brain image registration**

*Neuroimage.* 2011; **54**:2033-2044

[5.](#body-ref-sref87-1 "View in article")

Banino, A. ∙ Koster, R. ∙ Hassabis, D....

**Retrieval-based model accounts for striking profile of episodic memory and generalization**

*Sci. Rep.* 2016; **6**:31330

[6.](#body-ref-sref6 "View in article")

Berron, D. ∙ Vieweg, P. ∙ Hochkeppler, A....

**A protocol for manual segmentation of medial temporal lobe subregions in 7 Tesla MRI**

*Neuroimage Clin.* 2017; **15**:466-482

[8.](#body-ref-sref12 "View in article")

Bonnici, H.M. ∙ Chadwick, M.J. ∙ Kumaran, D....

**Multi-voxel pattern analysis in human hippocampal subfields**

*Front. Hum. Neurosci.* 2012; **6**:290

[9.](#body-ref-sref9-1 "View in article")

Brodeur, M.B. ∙ Dionne-Dostie, E. ∙ Montreuil, T....

**The Bank of Standardized Stimuli (BOSS), a new set of 480 normative photos of objects to be used as visual stimuli in cognitive research**

*PLoS ONE.* 2010; **5**:e10773

[10.](#body-ref-sref87-2 "View in article")

Bunsey, M. ∙ Eichenbaum, H.

**Conservation of hippocampal memory function in rats and humans**

*Nature.* 1996; **379**:255-257

[11.](#body-ref-sref11-1 "View in article")

Burton, A.M. ∙ White, D. ∙ McNeill, A.

**The glasgow face matching test**

*Behav. Res. Methods.* 2010; **42**:286-291

[12.](#body-ref-sref12 "View in article")

Chadwick, M.J. ∙ Hassabis, D. ∙ Weiskopf, N....

**Decoding individual episodic memory traces in the human hippocampus**

*Curr. Biol.* 2010; **20**:544-547

[13.](#body-ref-sref13-1 "View in article")

Chrobak, J.J. ∙ Amaral, D.G.

**Entorhinal cortex of the monkey: VII. intrinsic connections**

*J. Comp. Neurol.* 2007; **500**:612-633

[14.](#body-ref-sref80-1 "View in article")

Chrobak, J.J. ∙ Lörincz, A. ∙ Buzsáki, G.

**Physiological patterns in the hippocampo-entorhinal cortex system**

*Hippocampus.* 2000; **10**:457-465

[15.](#body-ref-sref44-2 "View in article")

Clark, R.E. ∙ Squire, L.R.

**Similarity in form and function of the hippocampus in rodents, monkeys, and humans**

*Proc. Natl. Acad. Sci. USA.* 2013; **110** (Suppl 2):10365-10370

[16.](#body-ref-sref71-1 "View in article")

Cohen, N.J. ∙ Eichenbaum, H.

**Memory, Amnesia and the Hippocampal System**

MIT Press, 1993

[Google Scholar](https://scholar.google.com/scholar_lookup?title=Memory%2C+Amnesia+and+the+Hippocampal+System&author=N.J.+Cohen&author=H.+Eichenbaum&publication_year=1993)

[17.](#body-ref-sref87-1 "View in article")

Collin, S.H. ∙ Milivojevic, B. ∙ Doeller, C.F.

**Memory hierarchies map onto the hippocampal long axis in humans**

*Nat. Neurosci.* 2015; **18**:1562-1564

[18.](#body-ref-sref18-1 "View in article")

Coutanche, M.N. ∙ Thompson-Schill, S.L.

**Informational connectivity: identifying synchronized discriminability of multi-voxel patterns across the brain**

*Front. Hum. Neurosci.* 2013; **7**:15

[19.](#body-ref-sref61 "View in article")

De Martino, F. ∙ Moerel, M. ∙ Ugurbil, K....

**Frequency preference and attention effects across cortical depths in the human primary auditory cortex**

*Proc. Natl. Acad. Sci. USA.* 2015; **112**:16036-16041

[20.](#body-ref-sref80-1 "View in article")

Dolorfo, C.L. ∙ Amaral, D.G.

**Entorhinal cortex of the rat: organization of intrinsic connections**

*J. Comp. Neurol.* 1998; **398**:49-82

[21.](#body-ref-sref71-1 "View in article")

Eichenbaum, H. ∙ Dudchenko, P. ∙ Wood, E....

**The hippocampus, memory, and place cells: is it spatial memory or a memory space?**

*Neuron.* 1999; **23**:209-226

[22.](#body-ref-sref84 "View in article")

Favila, S.E. ∙ Chanales, A.J. ∙ Kuhl, B.A.

**Experience-dependent hippocampal pattern differentiation prevents interference during subsequent learning**

*Nat. Commun.* 2016; **7**:11066

[23.](#body-ref-sref61 "View in article")

Fracasso, A. ∙ Petridou, N. ∙ Dumoulin, S.O.

**Systematic variation of population receptive field properties across cortical depth in human visual cortex**

*Neuroimage.* 2016; **139**:427-438

[24.](#body-ref-sref24 "View in article")

Gershman, S.J. ∙ Monfils, M.H. ∙ Norman, K.A....

**The computational nature of memory modification**

*eLife.* 2017; **6**:e23763

[25.](#body-ref-sref71-1 "View in article")

Gluck, M.A. ∙ Myers, C.E.

**Hippocampal mediation of stimulus representation: a computational theory**

*Hippocampus.* 1993; **3**:491-516

[26.](#body-ref-sref26 "View in article")

Graves, A. ∙ Wayne, G. ∙ Reynolds, M....

**Hybrid computing using a neural network with dynamic external memory**

*Nature.* 2016; **538**:471-476

[27.](#body-ref-sref59 "View in article")

Hasselmo, M.E.

**The role of acetylcholine in learning and memory**

*Curr. Opin. Neurobiol.* 2006; **16**:710-715

[28.](#body-ref-sref59 "View in article")

Hasselmo, M.E. ∙ McClelland, J.L.

**Neural models of memory**

*Curr. Opin. Neurobiol.* 1999; **9**:184-188

[29.](#body-ref-sref29 "View in article")

Haxby, J.V. ∙ Gobbini, M.I. ∙ Furey, M.L....

**Distributed and overlapping representations of faces and objects in ventral temporal cortex**

*Science.* 2001; **293**:2425-2430

[30.](#body-ref-sref30 "View in article")

Hebart, M.N. ∙ Baker, C.I.

**Deconstructing multivariate decoding for the study of brain function**

*Neuroimage.* 2017;

Published online August 4, 2017

[32.](#body-ref-sref79-4 "View in article")

Huber, L. ∙ Uludağ, K. ∙ Möller, H.E.

**Non-BOLD contrast for laminar fMRI in humans: CBF, CBV, and CMR <sub>O2</sub>**

*Neuroimage.* 2017;

Published online July 20, 2017

[33.](#body-ref-sref79-1 "View in article")

Huber, L. ∙ Handwerker, D.A. ∙ Jangraw, D.C....

**High-resolution cbv-fmri allows mapping of laminar activity and connectivity of cortical input and output in human m1**

*Neuron.* 2017; **96**:1253-1263.e7

[34.](#body-ref-sref34-1 "View in article")

Huffman, D.J. ∙ Stark, C.E.L.

**The influence of low-level stimulus features on the representation of contexts, items, and their mnemonic associations**

*Neuroimage.* 2017; **155**:513-529

[35.](#body-ref-sref35 "View in article")

In, M.H. ∙ Speck, O.

**Highly accelerated PSF-mapping for EPI distortion correction with improved fidelity**

*MAGMA.* 2012; **25**:183-192

[36.](#body-ref-sref59 "View in article")

Ketz, N. ∙ Morkonda, S.G. ∙ O’Reilly, R.C.

**Theta coordinated error-driven learning in the hippocampus**

*PLoS Comput. Biol.* 2013; **9**:e1003067

[37.](#body-ref-sref80-1 "View in article")

Kloosterman, F. ∙ van Haeften, T. ∙ Lopes da Silva, F.H.

**Two reentrant pathways in the hippocampal-entorhinal system**

*Hippocampus.* 2004; **14**:1026-1039

[38.](#body-ref-sref38-1 "View in article")

Kok, P. ∙ Bains, L.J. ∙ van Mourik, T....

**Selective activation of the deep layers of the human primary visual cortex by top-down feedback**

*Curr. Biol.* 2016; **26**:371-376

[39.](#body-ref-sref87-1 "View in article")

Kumaran, D.

**What representations and computations underpin the contribution of the hippocampus to generalization and inference?**

*Front. Hum. Neurosci.* 2012; **6**:157

[40.](#body-ref-sref40-1 "View in article")

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

[41.](#body-ref-sref49-3 "View in article")

Kumaran, D. ∙ Hassabis, D. ∙ McClelland, J.L.

**What learning systems do intelligent agents need? complementary learning systems theory updated**

*Trends Cogn. Sci.* 2016; **20**:512-534

[42.](#body-ref-sref79-1 "View in article")

Lawrence, S.J.D. ∙ Formisano, E. ∙ Muckli, L....

**Laminar fMRI: applications for cognitive neuroscience**

*Neuroimage.* 2017;

Published online July 4, 2017

[43.](#body-ref-sref43 "View in article")

Liang, J.C. ∙ Preston, A.R.

**Medial temporal lobe reinstatement of content-specific details predicts source memory**

*Cortex.* 2017; **91**:67-78

[44.](#fig4 "View in article")

Libby, L.A. ∙ Ekstrom, A.D. ∙ Ragland, J.D....

**Differential connectivity of perirhinal and parahippocampal cortices within human hippocampal subregions revealed by high-resolution functional imaging**

*J. Neurosci.* 2012; **32**:6550-6560

[45.](#body-ref-sref55-1 "View in article")

Litman, L. ∙ Awipi, T. ∙ Davachi, L.

**Category-specificity in the human medial temporal lobe cortex**

*Hippocampus.* 2009; **19**:308-319

[47.](#body-ref-sref59 "View in article")

Maass, A. ∙ Berron, D. ∙ Libby, L.A....

**Functional subregions of the human entorhinal cortex**

*eLife.* 2015; **4**:e06426

[48.](#body-ref-sref84 "View in article")

Marr, D.

**Simple memory: a theory for archicortex**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 1971; **262**:23-81

[49.](#body-ref-sref84 "View in article")

McClelland, J.L. ∙ McNaughton, B.L. ∙ O’Reilly, R.C.

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

[50.](#body-ref-sref84 "View in article")

McNaughton, B.L. ∙ Morris, R.G.

**Hippocampal synaptic enhancement and information storage within a distributed memory system**

*Trends Neurosci.* 1987; **10**:408-415

[51.](#body-ref-sref87-1 "View in article")

Milivojevic, B. ∙ Vicente-Grabovetsky, A. ∙ Doeller, C.F.

**Insight reconfigures hippocampal-prefrontal memories**

*Curr. Biol.* 2015; **25**:821-830

[52.](#body-ref-sref61 "View in article")

Muckli, L. ∙ De Martino, F. ∙ Vizioli, L....

**Contextual feedback to superficial layers of v1**

*Curr. Biol.* 2015; **25**:2690-2695

[54.](#body-ref-sref54 "View in article")

Nasr, S. ∙ Liu, N. ∙ Devaney, K.J....

**Scene-selective cortical regions in human and nonhuman primates**

*J. Neurosci.* 2011; **31**:13771-13785

[55.](#body-ref-sref55-1 "View in article")

Navarro Schröder, T. ∙ Haak, K.V. ∙ Zaragoza Jimenez, N.I....

**Functional topography of the human entorhinal cortex**

*eLife.* 2015; **4**

[56.](#body-ref-sref56-1 "View in article")

Nichols, T.E. ∙ Holmes, A.P.

**Nonparametric permutation tests for functional neuroimaging: a primer with examples**

*Hum. Brain Mapp.* 2002; **15**:1-25

[57.](#body-ref-sref84 "View in article")

Norman, K.A. ∙ O’Reilly, R.C.

**Modeling hippocampal and neocortical contributions to recognition memory: a complementary-learning-systems approach**

*Psychol. Rev.* 2003; **110**:611-646

[58.](#body-ref-sref84 "View in article")

O’Reilly, R.C. ∙ McClelland, J.L.

**Hippocampal conjunctive encoding, storage, and recall: avoiding a trade-off**

*Hippocampus.* 1994; **4**:661-682

[59.](#body-ref-sref59 "View in article")

O’Reilly, R.C. ∙ Rudy, J.W.

**Conjunctive representations in learning and memory: principles of cortical and hippocampal function**

*Psychol. Rev.* 2001; **108**:311-345

[60.](#body-ref-sref60 "View in article")

Olman, C.A. ∙ Davachi, L. ∙ Inati, S.

**Distortion and signal loss in medial temporal lobe**

*PLoS ONE.* 2009; **4**:e8160

[61.](#body-ref-sref61 "View in article")

Olman, C.A. ∙ Harel, N. ∙ Feinberg, D.A....

**Layer-specific fMRI reflects different neuronal computations at different depths in human V1**

*PLoS ONE.* 2012; **7**:e32536

[62.](#body-ref-sref62-1 "View in article")

Penny, W.D. ∙ Friston, K.J. ∙ Ashburner, J.T....

**Statistical Parametric Mapping: The Analysis of Functional Brain Images**

Elsevier, 2011

[Google Scholar](https://scholar.google.com/scholar_lookup?title=Statistical+Parametric+Mapping%3A+The+Analysis+of+Functional+Brain+Images&author=W.D.+Penny&author=K.J.+Friston&author=J.T.+Ashburner&author=S.J.+Kiebel&author=T.E.+Nichols&publication_year=2011)

[63.](#body-ref-sref63 "View in article")

Pereira, F. ∙ Mitchell, T. ∙ Botvinick, M.

**Machine learning classifiers and fMRI: a tutorial overview**

*Neuroimage.* 2009; **45** (Suppl):S199-S209

[64.](#body-ref-sref64-1 "View in article")

Qian, J. ∙ Hastie, T. ∙ Friedman, J....

**Glmnet for matlab**

Stanford University, 2013

[Google Scholar](https://scholar.google.com/scholar_lookup?title=Glmnet+for+matlab&author=J.+Qian&author=T.+Hastie&author=J.+Friedman&author=R.+Tibshirani&author=N.+Simon&publication_year=2013)

[65.](#body-ref-sref70-2 "View in article")

Schapiro, A.C. ∙ Gregory, E. ∙ Landau, B....

**The necessity of the medial temporal lobe for statistical learning**

*J. Cogn. Neurosci.* 2014; **26**:1736-1747

[66.](#body-ref-sref66-1 "View in article")

Schapiro, A.C. ∙ Turk-Browne, N.B. ∙ Botvinick, M.M....

**Complementary learning systems within the hippocampus: a neural network modelling approach to reconciling episodic memory with statistical learning**

*Philos. Trans. R. Soc. Lond. B Biol. Sci.* 2017; **372**:20160049

[67.](#body-ref-sref87-1 "View in article")

Schlichting, M. ∙ Preston, A.

**The Hippocampus and Memory Integration: Building Knowledge to Navigate Future Decisions**

Springer International Publishing, 2017 405-437

[Google Scholar](https://scholar.google.com/scholar_lookup?title=The+Hippocampus+and+Memory+Integration%3A+Building+Knowledge+to+Navigate+Future+Decisions&author=M.+Schlichting&author=A.+Preston&publication_year=2017&pages=405-437)

[69.](#body-ref-sref69 "View in article")

Schlichting, M.L. ∙ Guarino, K.F. ∙ Schapiro, A.C....

**Hippocampal structure predicts statistical learning and associative inference abilities during development**

*J. Cogn. Neurosci.* 2017; **29**:37-51

[70.](#body-ref-sref87-1 "View in article")

Shohamy, D. ∙ Turk-Browne, N.B.

**Mechanisms for widespread hippocampal involvement in cognition**

*J. Exp. Psychol. Gen.* 2013; **142**:1159-1170

[71.](#body-ref-sref71-1 "View in article")

Shohamy, D. ∙ Wagner, A.D.

**Integrating memories in the human brain: hippocampal-midbrain encoding of overlapping events**

*Neuron.* 2008; **60**:378-389

[72.](#body-ref-sref72-1 "View in article")

Smith, S.M. ∙ Jenkinson, M. ∙ Woolrich, M.W....

**Advances in functional and structural MR image analysis and implementation as FSL**

*Neuroimage.* 2004; **23** (Suppl 1):S208-S219

[73.](#body-ref-sref79-1 "View in article")

Stephan, K.E. ∙ Petzschner, F.H. ∙ Kasper, L....

**Laminar fMRI and computational theories of brain function**

*Neuroimage.* 2017;

Published online November 2, 2017

[74.](#body-ref-sref88 "View in article")

Striem-Amit, E. ∙ Ovadia-Caro, S. ∙ Caramazza, A....

**Functional connectivity of visual cortex in the blind follows retinotopic organization principles**

*Brain.* 2015; **138**:1679-1695

[75.](#body-ref-sref75 "View in article")

Sukhbaatar, S. ∙ Szlam, A. ∙ Weston, J....

**End-to-end memory networks**

*Adv. Neural Inf. Process. Syst.* 2015; **28**:2440-2448

[Google Scholar](https://scholar.google.com/scholar_lookup?title=End-to-end+memory+networks&author=S.+Sukhbaatar&author=A.+Szlam&author=J.+Weston&author=R.+Fergus&publication_year=2015&pages=2440-2448)

[76.](#body-ref-sref76 "View in article")

Thesen, S. ∙ Heid, O. ∙ Mueller, E....

**Prospective acquisition correction for head motion with image-based tracking for real-time fMRI**

*Magn. Reson. Med.* 2000; **44**:457-465

[77.](#body-ref-sref84 "View in article")

Treves, A. ∙ Rolls, E.T.

**Computational constraints suggest the need for two distinct input systems to the hippocampal CA3 network**

*Hippocampus.* 1992; **2**:189-199

[78.](#body-ref-sref78 "View in article")

Tuğran, E. ∙ Kocak, M. ∙ Mirtagioğlu, H....

**A simulation based comparison of correlation coefficients with regard to type i error rate and power**

*Journal of Data Analysis and Information Processing.* 2015; **3**:87

[Crossref](https://doi.org/10.4236/jdaip.2015.33010)

[Google Scholar](https://scholar.google.com/scholar_lookup?title=A%C2%A0simulation+based+comparison+of+correlation+coefficients+with+regard+to+type+i+error+rate+and+power&author=E.+Tu%C4%9Fran&author=M.+Kocak&author=H.+Mirtagio%C4%9Flu&author=S.+Yi%C4%9Fit&author=M.+Mendes&publication_year=2015&pages=87&doi=10.4236%2Fjdaip.2015.33010)

[80.](#body-ref-sref80-1 "View in article")

van Strien, N.M. ∙ Cappaert, N.L. ∙ Witter, M.P.

**The anatomy of memory: an interactive overview of the parahippocampal-hippocampal network**

*Nat. Rev. Neurosci.* 2009; **10**:272-282

[81.](#body-ref-sref81 "View in article")

Varoquaux, G. ∙ Raamana, P.R. ∙ Engemann, D.A....

**Assessing and tuning brain decoders: cross-validation, caveats, and guidelines**

*Neuroimage.* 2017; **145** (Pt B):166-179

[82.](#body-ref-sref82-1 "View in article")

Welvaert, M. ∙ Rosseel, Y.

**On the definition of signal-to-noise ratio and contrast-to-noise ratio for FMRI data**

*PLoS ONE.* 2013; **8**:e77089

[83.](#body-ref-sref83 "View in article")

Wisse, L.E. ∙ Gerritsen, L. ∙ Zwanenburg, J.J....

**Subfields of the hippocampal formation at 7 T MRI: in vivo volumetric assessment**

*Neuroimage.* 2012; **61**:1043-1049

[84.](#body-ref-sref84 "View in article")

Yassa, M.A. ∙ Stark, C.E.

**Pattern separation in the hippocampus**

*Trends Neurosci.* 2011; **34**:515-525

[85.](#body-ref-sref85 "View in article")

Yushkevich, P.A. ∙ Pluta, J.B. ∙ Wang, H....

**Automated volumetry and regional thickness analysis of hippocampal subfields and medial temporal cortical structures in mild cognitive impairment**

*Hum. Brain Mapp.* 2015; **36**:258-287

[86.](#body-ref-sref87-3 "View in article")

Zeithamova, D. ∙ Preston, A.R.

**Flexible memories: differential roles for medial temporal lobe and prefrontal cortex in cross-episode binding**

*J. Neurosci.* 2010; **30**:14676-14684

[87.](#body-ref-sref87-1 "View in article")

Zeithamova, D. ∙ Dominick, A.L. ∙ Preston, A.R.

**Hippocampal and ventral medial prefrontal activation during retrieval-mediated learning supports novel inference**

*Neuron.* 2012; **75**:168-179

[88.](#body-ref-sref88 "View in article")

Zhang, D. ∙ Snyder, A.Z. ∙ Fox, M.D....

**Intrinsic functional relations between human cerebral cortex and thalamus**

*J. Neurophysiol.* 2008; **100**:1740-1748