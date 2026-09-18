---
title: "What Learning Systems do Intelligent Agents Need? Complementary Learning Systems Theory Updated"
source: "https://www.cell.com/trends/cognitive-sciences/fulltext/S1364-6613(16)30043-2"
author:
  - "[[Dharshan Kumaran]]"
  - "[[Demis Hassabis]]"
  - "[[James L. McClelland]]"
published:
created: 2026-09-18
description: "We update complementary learning systems (CLS) theory, which holds that intelligentagents must possess two learning systems, instantiated in mammalians in neocortexand hippocampus. The first gradually acquires structured knowledge representationswhile the second quickly learns the specifics of individual experiences. We broadenthe role of replay of hippocampal memories in the theory, noting that replay allowsgoal-dependent weighting of experience statistics. We also address recent challengesto the theory and extend it by showing that recurrent activation of hippocampal tracescan support some forms of generalization and that neocortical learning can be rapidfor information that is consistent with known structure."
tags:
  - "clippings"
---
## Trends

Discovery of structure in ensembles of experiences depends on an interleaved learning process both in biological neural networks in neocortex and in contemporary artificial neural networks.

Recent work shows that once structured knowledge has been acquired in such networks, new consistent information can be integrated rapidly.

Both natural and artificial learning systems benefit from a second system that stores specific experiences, centred on the hippocampus in mammalians.

Replay of experiences from this system supports interleaved learning and can be modulated by reward or novelty, which acts to rebalance the general statistics of the environment towards the goals of the agent.

Recurrent activation of multiple memories within an instance-based system can be used to discover links between experiences, supporting generalization and memory-based reasoning.

## Abstract

We update complementary learning systems (CLS) theory, which holds that intelligent agents must possess two learning systems, instantiated in mammalians in neocortex and hippocampus. The first gradually acquires structured knowledge representations while the second quickly learns the specifics of individual experiences. We broaden the role of replay of hippocampal memories in the theory, noting that replay allows goal-dependent weighting of experience statistics. We also address recent challenges to the theory and extend it by showing that recurrent activation of hippocampal traces can support some forms of generalization and that neocortical learning can be rapid for information that is consistent with known structure. Finally, we note the relevance of the theory to the design of artificial intelligent agents, highlighting connections between neuroscience and machine learning.

## Keywords

1. [memory](https://www.cell.com/action/doSearch?AllField=%22memory)
2. [learning](https://www.cell.com/action/doSearch?AllField=%22learning)
3. [hippocampus](https://www.cell.com/action/doSearch?AllField=%22hippocampus)
4. [artificial intelligence](https://www.cell.com/action/doSearch?AllField=%22artificial+intelligence)

Sign in to unlock the full response and ask your own questions.

[Sign in](https://www.cell.com/action/idLogin?type=login&redirectUri=https%3A%2F%2Fwww.cell.com%2Ftrends%2Fcognitive-sciences%2Ffulltext%2FS1364-6613%2816%2930043-2&pii=S1364661316300432)

### Questions you could ask:

- How does Complementary Learning Systems (CLS) theory describe the hippocampus's function in learning?
- How does Complementary Learning Systems (CLS) theory characterize the organization of learning in the brain?
- What is the role of the hippocampus in generalizing from specific experiences to novel situations?

### Actions you could take:

- Summarize this article

## Complementary Learning Systems

Twenty years have passed since the introduction of the CLS theory of human learning and memory

1.

McClelland, J.L....

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

[Crossref](https://doi.org/10.1037/0033-295X.102.3.419)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7624455/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.102.3.419&pmid=7624455)

, a theory that, itself, had roots in earlier ideas of Marr and others. According to the theory, effective learning requires two complementary systems: one, located in the neocortex, serves as the basis for the gradual acquisition of structured knowledge about the environment, while the other, centered on the hippocampus, allows rapid learning of the specifics of individual items and experiences. We begin with a review of the core tenets of this theory. We then provide three types of updates. First, we extend the role of replay of memories stored in the hippocampus. This mechanism, initially proposed to support the integration of new information into the neocortex, may support a diverse set of functions

2.

O’Neill, J....

**Play it again: reactivation of waking experience and memory**

*Trends Neurosci.* 2010; **33**:220-229

3.

Wikenheiser, A.M. ∙ Redish, A.D.

**Decoding the cognitive map: ensemble hippocampal sequences and decision making**

*Curr. Opin. Neurobiol.* 2015; **32**:8-15

, including goal-related manipulation of experience statistics such that the neocortex is not a slave to the statistics of its environment. Second, we describe recent updates to the theory in response to two key empirical challenges: (i) evidence suggesting that the hippocampus supports some forms of generalization that go beyond those originally envisaged

4.

Zeithamova, D....

**The hippocampus and inferential reasoning: building memories to navigate future decisions**

*Front. Hum. Neurosci.* 2012; **6**:1-14

5.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: A model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

6.

Eichenbaum, H.

**Hippocampus: cognitive processes and neural representations that underlie declarative memory**

*Neuron.* 2004; **44**:109-120

, and (ii) evidence suggesting that, when new information is consistent with existing knowledge, the time required for its integration into the neocortex may be much shorter than originally suggested

7.

Tse, D....

**Schemas and memory consolidation**

*Science.* 2007; **316**:76-82

8.

Tse, D....

**Schema-dependent gene activation and memory encoding in neocortex**

*Science.* 2011; **333**:891-895

. In a final section, we highlight links between the core principles of CLS theory and recent themes in machine learning, including neural network architectures that incorporate memory modules that have parallels with the hippocampus. While there remain several issues not yet fully addressed (see Outstanding Questions), the extensions, responses to challenges, and integration with machine learning bring the theory into agreement with many important recent developments and provide a take-off point for future investigation.

### Summary of the Theory

CLS theory

1.

McClelland, J.L....

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

[Crossref](https://doi.org/10.1037/0033-295X.102.3.419)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7624455/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.102.3.419&pmid=7624455)

provided a framework within which to characterize the organization of learning in the brain ([Figure 1](#fig0005), Key Figure). Drawing on earlier ideas by David Marr

9.

Marr, D.

**Simple memory: a theory for archicortex**

*Philos. Trans. R. Soc. L. B Biol. Sci.* 1971; **262**:23-81

[Crossref](https://doi.org/10.1098/rstb.1971.0078)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/4399412/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1098%2Frstb.1971.0078&pmid=4399412)

, it offered a synthesis of the computational functions and characteristics of the hippocampus and neocortex that not only accounted for a wealth of empirical data ([Box 1](#tb0010)) but resonated with rational perspectives on the challenges faced by intelligent agents.

![](https://www.cell.com/cms/10.1016/j.tics.2016.05.004/asset/df984925-89a2-4c78-83f4-e95f158a105f/main.assets/gr1_lrg.jpg)

Figure 1 Key Figure: Complementary Learning Systems (CLS) and their Interactions.

Box 1

Empirical Evidence Supporting Core Principles of CLS Theory

*The Role of the Hippocampus in Memory*

Bilateral damage to the hippocampus profoundly affects memory for new information, leaving language, reading, general knowledge, and acquired cognitive skills intact

29.

Cohen, N.J. ∙ Eichenbaum, H.B.

**Memory, Amnesia and the Hippocampal System**

MIT Press, 1994

[Google Scholar](https://scholar.google.com/scholar?q=N.J.CohenH.B.EichenbaumMemory%2C+Amnesia+and+the+Hippocampal+System1994MIT+Press)

34.

Squire, L.R....

**The medial temporal lobe**

*Annu. Rev. Neurosci.* 2004; **27**:279-306

, consistent with the idea that many types of new learning are initially hippocampus-dependent. Memory for recent pre-morbid information is profoundly affected by hippocampal damage, with older memories being less dependent on the hippocampus and therefore less sensitive to hippocampal lesions

1.

McClelland, J.L....

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

[Crossref](https://doi.org/10.1037/0033-295X.102.3.419)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7624455/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.102.3.419&pmid=7624455)

34.

Squire, L.R....

**The medial temporal lobe**

*Annu. Rev. Neurosci.* 2004; **27**:279-306

51.

Frankland, P.W. ∙ Bontempi, B.

**The organization of recent and remote memories**

*Nat. Rev. Neurosci.* 2005; **6**:119-130

128.

Scoville, W.B. ∙ Milner, B.

**Loss of recent memory after bilateral hippocampal lesions**

*J. Neurol. Neurosurg. Psychiatry.* 1957; **20**:11-12

[Crossref](https://doi.org/10.1136/jnnp.20.1.11)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/13406589/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1136%2Fjnnp.20.1.11&pmid=13406589)

, supporting gradual integration of learned information into cortical knowledge structures. However, some evidence suggests that memory for specific details of an event can remain MTL-dependent

52.

Winocur, G....

**Memory formation and long-term retention in humans and animals: convergence towards a transformation account of hippocampal–neocortical interactions**

*Neuropsychologia.* 2010; **48**:2339-2356

129.

Nadel, L. ∙ Moscovitch, M.

**Memory consolidation, retrograde amnesia and the hippocampal complex**

*Curr. Opin. Neurobiol.* 1997; **7**:217-227

as long as the details are retained (e.g.,

130.

Moscovitch, M....

**Functional neuroanatomy of remote episodic, semantic and spatial memory: a unified account based on multiple trace theory**

*J. Anat.* 2005; **207**:35-66

).

*Hippocampus Supports Core Computations and Representations of a Fast-Learning Episodic Memory System*

Episodic memory is widely accepted to depend on the hippocampus, mediated by a capacity to bind together (i.e., ‘auto-associate’) diverse inputs from different brain areas that represent the constituents of an event. Indeed, information about the spatial (e.g., place) and non-spatial (e.g., what happened) aspects of an event are thought to be processed primarily by parallel streams before converging in the hippocampus at the level of the DG/CA3 subregions

37.

Knierim, J.J. ∙ Neunuebel, J.P.

**Tracking the flow of hippocampal computation: pattern separation, pattern completion, and attractor dynamics**

*Neurobiol. Learn. Mem.* 2016; **129**:38-49

. Two complementary computations – pattern separation and pattern completion – are viewed to be central to the function of the hippocampus for storing details of specific experiences. Evidence suggests that the dentate gyrus (DG) subregion of the hippocampus performs pattern separation, orthogonalizing incoming inputs before **auto-associative storage** in the CA3 region

131.

Yassa, M.A. ∙ Stark, C.E.

**Pattern separation in the hippocampus**

*Trends Neurosci.* 2011; **34**:515-525

132.

Liu, X....

**Optogenetic stimulation of a hippocampal engram activates fear memory recall**

*Nature.* 2012; **484**:381-385

133.

Leutgeb, J.K....

**Pattern separation in the dentate gyrus and CA3 of the hippocampus**

*Science.* 2007; **315**:961-966

134.

Leutgeb, S....

**Distinct ensemble codes in hippocampal areas CA3 and CA1**

*Science.* 2004; **305**:1295-1298

135.

Bonnici, H.M....

**Decoding representations of scenes in the medial temporal lobes**

*Hippocampus.* 2011; **22**:1143-1153

136.

McHugh, T.J....

**Dentate gyrus NMDA receptors mediate rapid pattern separation in the hippocampal network**

*Science.* 2007; **317**:94-99

137.

Neunuebel, J.P. ∙ Knierim, J.J.

**CA3 retrieves coherent representations from degraded input: direct evidence for CA3 pattern completion and dentate gyrus pattern separation**

*Neuron.* 2014; **81**:416-427

. Further, the CA3 subregion is crucial for pattern completion – allowing the output of an entire stored pattern (e.g., corresponding to an entire episodic memory) from a partial input consistent with its function as an attractor network

138.

Nakazawa, K....

**Requirement for hippocampal CA3 NMDA receptors in associative memory recall**

*Science.* 2002; **297**:211-218

139.

Jezek, K....

**Theta-paced flickering between place-cell maps in the hippocampus**

*Nature.* 2011; **478**:246-249

([Boxes 2–4](#tb0015)).

*Hippocampal Replay*

A wealth of evidence demonstrates that replay of recent experiences occurs during offline periods (e.g., during sleep, rest)

2.

O’Neill, J....

**Play it again: reactivation of waking experience and memory**

*Trends Neurosci.* 2010; **33**:220-229

3.

Wikenheiser, A.M. ∙ Redish, A.D.

**Decoding the cognitive map: ensemble hippocampal sequences and decision making**

*Curr. Opin. Neurobiol.* 2015; **32**:8-15

. Further, the hippocampus and neocortex interact during replay as predicted by CLS theory

65.

Ji, D. ∙ Wilson, M.A.

**Coordinated memory replay in the visual cortex and hippocampus during sleep**

*Nat. Neurosci.* 2007; **10**:100-107

, putatively to support interleaved learning. A causal role for replay in systems-level consolidation is supported by the finding that optogenetic blockage of CA3 output in transgenic mouse after learning in a contextual fear paradigm specifically reduces sharp-wave ripple (SWR) complexes in CA1 and impairs consolidation

69.

Nakashiba, T....

**Hippocampal CA3 output is crucial for ripple-associated reactivation and consolidation of memory**

*Neuron.* 2009; **62**:781-787

.

*The Hippocampus And Neocortex Support Qualitatively Different Forms of Representation*

A recent experiment

140.

Richards, B.A....

**Patterns across multiple memories are identified over time**

*Nat. Neurosci.* 2014; **17**:981-986

found initial evidence in favor: the behavior of rats in the Morris water maze early on appeared to reflect individual episodic traces (i.e., an instance-based non-parametric representation), but at a later time-point (28 days after learning) was consistent with the use of a parametric representation putatively housed in the neocortex.

#### Structured Knowledge Representation System in Neocortex

A central tenet of the theory is that the neocortex houses a structured knowledge representation, stored in the connections among the neurons in the neocortex. This tenet arose from the observation that multi-layered neural networks ([Figure 2](#fig0010)) gradually learn to extract structure when trained by adjusting connection weights to minimize error in the network outputs

10.

Rumelhart, D.E....

**Learning representations by back-propagating errors**

*Nature.* 1986; **323**:533-536

[Crossref](https://doi.org/10.1038/323533a0)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2F323533a0)

. Early examples were provided by networks that learned to read words aloud

11.

Sejnowski, T.J. ∙ Rosenberg, C.R.

**Parallel networks that learn to pronounce English text**

*Complex Syst.* 1987; **1**:145-168

[Google Scholar](https://scholar.google.com/scholar?q=T.J.SejnowskiC.R.RosenbergParallel+networks+that+learn+to+pronounce+English+textComplex+Syst.11987145168)

12.

Guyonneau, R....

**Temporal codes and sparse representations: a key to understanding rapid processing in the visual system**

*J. Physiol. Paris.* 2004; **98**:487-497

13.

Plaut, D.C....

**Understanding normal and impaired word reading: computational principles in quasi-regular domains**

*Psychol. Rev.* 1996; **103**:56-115

[Crossref](https://doi.org/10.1037/0033-295X.103.1.56)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8650300/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.103.1.56&pmid=8650300)

from repeated, interleaved exposure to the spellings and corresponding sounds of English words. These networks supported the gradual acquisition of a structured knowledge representation in the connection weights among the units in the network, shaped by the statistics of the environment in a fashion that was efficient and generalized to novel examples

1.

McClelland, J.L....

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

[Crossref](https://doi.org/10.1037/0033-295X.102.3.419)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7624455/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.102.3.419&pmid=7624455)

14.

Rogers, T.T. ∙ McClelland, J.L.

**Semantic Cognition: A Parallel Distributed Processing Approach**

MIT Press, 2004

[Crossref](https://doi.org/10.7551/mitpress/6161.001.0001)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.7551%2Fmitpress%2F6161.001.0001)

15.

Rumelhart, D.E.

**Brain style computation: learning and generalization**

Zornetzer, S.F.... (Editors)

**An Introduction to Electronic and Neural Networks**

Academic Press, 1990; 405-420

[Google Scholar](https://scholar.google.com/scholar?q=D.E.RumelhartBrain+style+computation%3A+learning+and+generalizationS.F.ZornetzerAn+Introduction+to+Electronic+and+Neural+Networks1990Academic+Press405420)

, while also supporting performance on atypical items occurring frequently in the domain. Such a representation can be described as **parametric** (see [Glossary](#glo0005)) rather than as item-based (or **non-parametric**) in that the connection weights can be viewed as a set of parameters optimized for the entire domain (e.g., the spellings and sounds of the full set of words in the language) instead of supporting memory for the items *per se*. According to the theory, such networks underlie acquired cognitive abilities of all types in domains as diverse as perception, language, semantic knowledge representation, and skilled action. This idea can be seen as an extension of Marr's original proposal

9.

Marr, D.

**Simple memory: a theory for archicortex**

*Philos. Trans. R. Soc. L. B Biol. Sci.* 1971; **262**:23-81

[Crossref](https://doi.org/10.1098/rstb.1971.0078)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/4399412/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1098%2Frstb.1971.0078&pmid=4399412)

, which held that cortical neurons each learned the statistics associated with a particular category.

![](https://www.cell.com/cms/10.1016/j.tics.2016.05.004/asset/a6f66f71-261d-472f-897f-aac8f6925f34/main.assets/gr2_lrg.jpg)

Figure 2 A Neocortex-Like Artificial Neural Network. In the complementary learning systems (CLS) theory, neocortical processing is seen as occurring through the propagation of activation among neurons via weighted connections, as simulated using artificial networks of neuron-like units (small circles). Each unit has an input line and an output line (with arrowhead). There is a separate real-valued weight where each output line crosses an input line. The weights are the knowledge that governs processing in the network. During processing (inset), each unit computes a net input ( n ) from the activations of its inputs and the weights (plus a bias term, omitted here), producing an activation ( a ) that is a non-linear function of (one such function shown). The units in a layer may project back onto their own inputs (illustrated for layer 3), simulating recurrent intra-cortical computations and higher layers may project back to lower layers ( Figure 1 ). In the situation shown, the input (lower left) is a pattern in which units are either active ( = 1, black) or inactive ( 0, white), and examples of possible activations produced in units of other layers are shown (darker for greater activation). Learning occurs through adjusting the weights to reduce the difference between the output of the network and a target output (upper right) 10. Rumelhart, D.E.... Learning representations by back-propagating errors Nature. 1986; 323:533-536 Crossref Google Scholar 16. LeCun, Y.... Deep learning 2015; 521:436-444. In the case shown, the output activations are similar to the target, but there is some error to drive learning. There are no targets for internal or hidden layers (i.e., layers 2 and 3). These patterns depend on the connection weights, which in turn are shaped by the error-driven learning process.

The CLS theory proposed that learning in such a parametric system will necessarily be slow, for two main reasons: first, each experience represents a single sample from the environment. Given this, a small learning rate allows a more-accurate estimate of the underlying population statistics by effectively aggregating information over a larger number of samples

1.

McClelland, J.L....

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

[Crossref](https://doi.org/10.1037/0033-295X.102.3.419)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7624455/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.102.3.419&pmid=7624455)

. Second, the optimal adjustment of each connection depends on the values of all of the other connections. Before the ensemble of connections has been structured by experience, the signals specifying how to change connection weights to optimize the representation will be both noisy and weak, slowing initial learning. This issue has proved to be particularly important in deep (i.e., many-layered) neural network architectures that have enjoyed recent successes in machine learning

16.

LeCun, Y....

**Deep learning**

*Nature.* 2015; **521**:436-444

as well as in modeling the neural computations supporting visual processing of objects in primates. The considerable advantages of depth in allowing the learning of increasingly complex and abstract mappings

16.

LeCun, Y....

**Deep learning**

*Nature.* 2015; **521**:436-444

are balanced here by the strong interdependencies among connection weights in deep networks

19.

Saxe, A.M....

**Learning hierarchical categories in deep neural networks**

**Proceedings of the 35th Annual Conference of the Cognitive Science Society**

2015; 1271-1276

[Google Scholar](https://scholar.google.com/scholar?q=A.M.SaxeLearning+hierarchical+categories+in+deep+neural+networksProceedings+of+the+35th+Annual+Conference+of+the+Cognitive+Science+SocietyCognitive+Science+Society201512711276)

20.

Saxe, A.M....

**Exact solutions to the nonlinear dynamics of learning in deep linear neural networks**

2014

Published online December 20, 2013. http://arxiv.org/abs/1312.6120

[Google Scholar](https://scholar.google.com/scholar?q=A.M.SaxeExact+solutions+to+the+nonlinear+dynamics+of+learning+in+deep+linear+neural+networks2014Published+online+December+20%2C+2013.+http%3A%2F%2Farxiv.org%2Fabs%2F1312.6120)

such that the weights are learned gradually through extensive, repeated, and interleaved exposure to an ensemble of training examples that embody the domain statistics.

Although there are real advantages of a system using structured parametric representations, on its own such a system would suffer from two drastic limitations

1.

McClelland, J.L....

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

[Crossref](https://doi.org/10.1037/0033-295X.102.3.419)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7624455/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.102.3.419&pmid=7624455)

. First, it is important to be able to base behavior on the content of an individual experience. For example, after experiencing a life-threatening situation – for example, an encounter with a lion at a watering-hole – it would clearly be beneficial to learn to avoid that particular location without the need for further encounters with the lion. The second problem is that the rapid adjustment of connection weights in a multilayer network to accommodate new information can severely disrupt the representation of existing knowledge in it – a phenomenon termed catastrophic interference

1.

McClelland, J.L....

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

[Crossref](https://doi.org/10.1037/0033-295X.102.3.419)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7624455/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.102.3.419&pmid=7624455)

21.

McCloskey, M. ∙ Cohen, N.J.

**Catastrophic forgetting in connectionist networks: the problem of sequential learning**

Bower, G.H. (Editor)

**The Psychology of Learning and Motivation (Vol. 20)**

Academic Press, 1989; 109-165

[Google Scholar](https://scholar.google.com/scholar?q=M.McCloskeyN.J.CohenCatastrophic+forgetting+in+connectionist+networks%3A+the+problem+of+sequential+learningG.H.BowerThe+Psychology+of+Learning+and+Motivation+%28Vol.+20%291989Academic+Press109165)

22.

Ratcliff, R.

**Connectionist models of recognition memory: constraints imposed by learning and forgetting functions**

*Psychol. Rev.* 1990; **97**:285-308

[Crossref](https://doi.org/10.1037/0033-295X.97.2.285)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/2186426/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.97.2.285&pmid=2186426)

23.

French, R.M.

**Catastrophic forgetting in connectionist networks**

*Trends Cogn. Sci.* 1999; **3**:128-135

that is related to the stability–plasticity dilemma

24.

Carpenter, G.A. ∙ Grossberg, S.

**A massively parallel architecture for a self-organizing neural pattern recognition architecture**

*Comput. Vision, Graph. Image Process.* 1987; **37**:54-115

[Crossref](https://doi.org/10.1016/S0734-189X\(87\)80014-2)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1016%2FS0734-189X%2887%2980014-2)

. If the new information about the dangerous lion is forced into a multi-layer network by making large connection weight adjustments just to accommodate this item, this can interfere with knowledge of other less-threatening animals one may already be familiar with.

#### Instance-Based Representation in the Hippocampal System

Fortunately, a second, complementary learning system can address both problems, affording the rapid and relatively individuated storage of information about individual items or experiences (such as the encounter with the lion). Following Marr's and subsequent proposals

25.

McNaughton, B.L. ∙ Morris, R.G.

**Hippocampal synaptic enhancement and information storage within a distributed memory system**

*Trends Neurosci.* 1987; **10**:408-415

26.

Treves, A. ∙ Rolls, E.T.

**Computational constraints suggest the need for two distinct input systems to the hippocampal CA3 network**

*Hippocampus.* 1992; **2**:189-199

27.

O’Reilly, R.C. ∙ McClelland, J.L.

**Hippocampal conjunctive encoding, storage, and recall: avoiding a trade-off**

*Hippocampus.* 1994; **4**:661-682

, the CLS theory proposed that the hippocampus and related structures in the medial temporal lobe (MTL) support the initial storage of item-specific information, including the features of the watering hole as well as those of the lion ([Figure 1](#fig0005)). This proposal has been captured in models of the role of the hippocampus in recognition memory for specific items and in sensitivity to context and co-occurrence of items within the same event or experience

28.

Knierim, J.J....

**Hippocampal place cells: parallel input streams, subregional processing, and implications for episodic memory**

*Hippocampus.* 2006; **16**:755-764

29.

Cohen, N.J. ∙ Eichenbaum, H.B.

**Memory, Amnesia and the Hippocampal System**

MIT Press, 1994

[Google Scholar](https://scholar.google.com/scholar?q=N.J.CohenH.B.EichenbaumMemory%2C+Amnesia+and+the+Hippocampal+System1994MIT+Press)

30.

O’Reilly, R.C. ∙ Rudy, J.W.

**Conjunctive representations in learning and memory: principles of cortical and hippocampal function**

*Psychol. Rev.* 2001; **108**:311-345

[Crossref](https://doi.org/10.1037/0033-295X.108.2.311)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/11381832/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.108.2.311&pmid=11381832)

31.

Norman, K.A. ∙ O’Reilly, R.C.

**Modeling hippocampal and neocortical contributions to recognition memory: a complementary-learning-systems approach**

*Psychol. Rev.* 2003; **110**:611-646

32.

Mayes, A....

**Associative memory and the medial temporal lobes**

*Trends Cogn. Sci.* 2007; **11**:126-135

33.

Davachi, L.

**Item, context and relational episodic encoding in humans**

*Curr. Opin. Neurobiol.* 2006; **16**:693-700

34.

Squire, L.R....

**The medial temporal lobe**

*Annu. Rev. Neurosci.* 2004; **27**:279-306

35.

Schiller, D....

**Memory and space: towards an inderstanding of the cognitive map**

*J. Neurosci.* 2015; **35**:13904-13911

36.

O’Reilly, R.C....

**Complementary learning systems**

*Cogn. Sci.* 2014; **38**:1229-1248

.

In CLS theory, the dentate gyrus (DG) and CA3 subregions of the hippocampus are the heart of the fast learning system ([Boxes 2–4](#tb0015)). The DG is crucial in selecting a distinct neural activity pattern in CA3 for each experience, even when different experiences are quite similar

25.

McNaughton, B.L. ∙ Morris, R.G.

**Hippocampal synaptic enhancement and information storage within a distributed memory system**

*Trends Neurosci.* 1987; **10**:408-415

26.

Treves, A. ∙ Rolls, E.T.

**Computational constraints suggest the need for two distinct input systems to the hippocampal CA3 network**

*Hippocampus.* 1992; **2**:189-199

27.

O’Reilly, R.C. ∙ McClelland, J.L.

**Hippocampal conjunctive encoding, storage, and recall: avoiding a trade-off**

*Hippocampus.* 1994; **4**:661-682

37.

Knierim, J.J. ∙ Neunuebel, J.P.

**Tracking the flow of hippocampal computation: pattern separation, pattern completion, and attractor dynamics**

*Neurobiol. Learn. Mem.* 2016; **129**:38-49

38.

Johnston, S.T....

**Paradox of pattern separation and adult neurogenesis: a dual role for new neurons balancing memory resolution and robustness**

*Neurobiol. Learn. Mem.* 2016; **129**:60-68

, a process known as pattern separation. Increases in the strengths of connections onto and among the participating neurons in DG and CA3 stabilize the activity pattern for an experience and support reactivation of the pattern from a partial cue: because of the strengthened connections, reactivation of part of the pattern that was activated during storage (features of the watering hole in which the lion was encountered) can then reactivate the rest of the pattern (i.e., the encounter with the lion), a process called ‘pattern completion’. Return connections from hippocampus to neocortex then support adaptive behavior (e.g., avoidance of that location).

![](https://www.cell.com/cms/10.1016/j.tics.2016.05.004/asset/d7039bdc-600f-4a58-ad9f-37ae262b5e50/main.assets/gr1b2_lrg.jpg)

Box 2 Functional Roles of Subregions of the Medial Temporal Lobes

![](https://www.cell.com/cms/10.1016/j.tics.2016.05.004/asset/60054a08-e2c5-40d7-acf0-c32cfd1874e0/main.assets/gr1b3_lrg.jpg)

Box 3 Pattern Separation and Completion in Different Subregions of the Hippocampus

Box 4

Sparse Conjunctive Coding and Pattern Separation in the Dentate Gyrus

Neuronal codes range from the extreme of localist codes – where neurons respond highly selectively to single entities (‘grandmother cells’) to dense distributed codes where items are coded through the activity of many (e.g., 50%) neurons in an area

153.

Olshausen, B.A. ∙ Field, D.J.

**Sparse coding of sensory inputs**

*Curr. Opin. Neurobiol.* 2004; **14**:481-487

154.

Quiroga, R.Q....

**Sparse but not ‘grandmother-cell’ coding in the medial temporal lobe**

*Trends Cogn. Sci.* 2008; **12**:87-91

. While localist codes minimize interference and are easily decodable, they are inefficient in terms of representational capacity. By contrast, dense distributed codes are capacity-efficient; however, they are costly in terms of metabolic cost and relatively difficult to decode. These are endpoints on a continuum quantified by a measure called sparsity, where ‘population’ sparsity indexes the proportion of neurons that fire in response to a given stimulus/location, and ‘lifetime’ sparsity indexes the proportion of stimuli to which a single neuron responds

26.

Treves, A. ∙ Rolls, E.T.

**Computational constraints suggest the need for two distinct input systems to the hippocampal CA3 network**

*Hippocampus.* 1992; **2**:189-199

153.

Olshausen, B.A. ∙ Field, D.J.

**Sparse coding of sensory inputs**

*Curr. Opin. Neurobiol.* 2004; **14**:481-487

155.

Ahmed, O.J. ∙ Mehta, M.R.

**The hippocampal rate code: anatomy, physiology and theory**

*Trends Neurosci.* 2009; **32**:329-338

. For example, a population sparsity of 1% means that only 1% of the neurons in a population are active in representing a given input. Two randomly selected sparse patterns tend to have low overlap (for two randomly selected patterns of equal sparsity over the same set of neurons, the average proportion of neurons in either pattern that is active in the other is equal to the sparsity), but neurons still participate in several different memories, making them more efficient than localist codes. Despite variability in estimates of the sparsity of a given brain region, the DG is widely believed to sustain among the sparsest neural code in the brain (∼0.5–1% population sparseness)

25.

McNaughton, B.L. ∙ Morris, R.G.

**Hippocampal synaptic enhancement and information storage within a distributed memory system**

*Trends Neurosci.* 1987; **10**:408-415

26.

Treves, A. ∙ Rolls, E.T.

**Computational constraints suggest the need for two distinct input systems to the hippocampal CA3 network**

*Hippocampus.* 1992; **2**:189-199

27.

O’Reilly, R.C. ∙ McClelland, J.L.

**Hippocampal conjunctive encoding, storage, and recall: avoiding a trade-off**

*Hippocampus.* 1994; **4**:661-682

. The CA3 region, to which the DG projects, is thought to be less sparse (∼2.5%

47.

Barnes, C.A....

**Comparison of spatial and temporal characteristics of neuronal activity in sequential stages of hippocampal processing**

*Prog. Brain Res.* 1990; **83**:287-300

[Crossref](https://doi.org/10.1016/S0079-6123\(08\)61257-1)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/2392566/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1016%2FS0079-6123%2808%2961257-1&pmid=2392566)

). Many studies find less-sparse patterns in CA1 than CA3.

The unique functional and anatomical properties of the DG suggest the origins of its sparse, pattern-separated code. The perforant path from the ERC (containing ∼200 000 neurons in the rodent) projects to a layer of ∼1 million of DG granule cells. Combined with the high levels of inhibition in the DG, this supports the formation of highly sparse, conjunctive representations, such that each neuron in DG responds only when several input neurons are simultaneously active, reducing overlap between similar input patterns

25.

McNaughton, B.L. ∙ Morris, R.G.

**Hippocampal synaptic enhancement and information storage within a distributed memory system**

*Trends Neurosci.* 1987; **10**:408-415

26.

Treves, A. ∙ Rolls, E.T.

**Computational constraints suggest the need for two distinct input systems to the hippocampal CA3 network**

*Hippocampus.* 1992; **2**:189-199

27.

O’Reilly, R.C. ∙ McClelland, J.L.

**Hippocampal conjunctive encoding, storage, and recall: avoiding a trade-off**

*Hippocampus.* 1994; **4**:661-682

136.

McHugh, T.J....

**Dentate gyrus NMDA receptors mediate rapid pattern separation in the hippocampal network**

*Science.* 2007; **317**:94-99

. Evidence also suggests that new DG neurons arise from stem cells throughout adult life; these new neurons may be preferentially recruited in the formation of memories

136.

McHugh, T.J....

**Dentate gyrus NMDA receptors mediate rapid pattern separation in the hippocampal network**

*Science.* 2007; **317**:94-99

, further reducing overlap with previously stored memories. The CA3 pattern for a memory is then selected by the active DG neurons, each of which has a ‘detonator’ synapse to ∼15 randomly selected CA3 neurons. This process helps minimize the overlap of CA3 patterns for different memories, increasing storage capacity and minimizing interference between them, even if the two memories represent similar events that have highly overlapping patterns in neocortex and ERC. Empirical evidence provides support for this, with one study

137.

Neunuebel, J.P. ∙ Knierim, J.J.

**CA3 retrieves coherent representations from degraded input: direct evidence for CA3 pattern completion and dentate gyrus pattern separation**

*Neuron.* 2014; **81**:416-427

showing that the representation supported by DG was highly sensitive to small changes in the environment, despite evidence that incoming inputs from the ERC were little affected (also see

133.

Leutgeb, J.K....

**Pattern separation in the dentate gyrus and CA3 of the hippocampus**

*Science.* 2007; **315**:961-966

145.

Lee, H....

**Neural population evidence of functional heterogeneity along the CA3 transverse axis: pattern completion versus pattern separation**

*Neuron.* 2015; **87**:1093-1105

). Furthermore, DG lesions impair an animals’ ability to learn to respond differently in two very similar environments while leaving the ability to learn to respond differently in two environments that are not similar

136.

McHugh, T.J....

**Dentate gyrus NMDA receptors mediate rapid pattern separation in the hippocampal network**

*Science.* 2007; **317**:94-99

.

Note, however, that a hippocampal system acting alone would also be insufficient due to capacity limitations

26.

Treves, A. ∙ Rolls, E.T.

**Computational constraints suggest the need for two distinct input systems to the hippocampal CA3 network**

*Hippocampus.* 1992; **2**:189-199

and its limited ability to generalize. Related to the latter point, the use of pattern-separated hippocampal codes for related experiences – in contrast to the relatively dense similarity-based coding scheme thought to operate in the parametric neocortical system

39.

Bengio, Y....

**Representation learning: a review and new perspectives**

*IEEE Trans. Pattern Anal. Mach. Intell.* 2013; **35**:1798-1828

40.

Khaligh-Razavi, S.M. ∙ Kriegeskorte, N.

**Deep supervised, but not unsupervised, models may explain IT cortical representation**

*PLoS Comput. Biol.* 2014; **10**:e1003915

41.

Kriegeskorte, N....

**Matching categorical object representations in inferior temporal cortex of man and monkey**

*Neuron.* 2008; **60**:1126-1141

42.

Clarke, A. ∙ Tyler, L.K.

**Object-specific semantic coding in human perirhinal cortex**

*J. Neurosci.* 2014; **34**:4766-4775

43.

Kiani, R....

**Object category structure in response patterns of neuronal population in monkey inferior temporal cortex**

*J. Neurophysiol.* 2007; **97**:4296-4309

44.

McNaughton, B.L.

**Cortical hierarchies, sleep, and the extraction of knowledge from memory**

*Artficial Intell.* 2010; **174**:205-2014

45.

Leibold, C. ∙ Kempter, R.

**Sparseness constrains the prolongation of memory lifetime via synaptic metaplasticity**

*Cereb. Cortex.* 2008; **18**:67-77

46.

Rolls, E.T....

**The representational capacity of the distributed encoding of information provided by populations of neurons in primate temporal visual cortex**

*Exp. Brain Res.* 1997; **114**:149-162

– may be adaptive for some purposes but comes with a cost: it disregards shared structure between experiences, thereby limiting both efficiency and generalization.

The theory is supported by findings that neocortical activity patterns generally show less **sparsity** and exhibit greater similarity-based overlap compared to the hippocampus

40.

Khaligh-Razavi, S.M. ∙ Kriegeskorte, N.

**Deep supervised, but not unsupervised, models may explain IT cortical representation**

*PLoS Comput. Biol.* 2014; **10**:e1003915

41.

Kriegeskorte, N....

**Matching categorical object representations in inferior temporal cortex of man and monkey**

*Neuron.* 2008; **60**:1126-1141

43.

Kiani, R....

**Object category structure in response patterns of neuronal population in monkey inferior temporal cortex**

*J. Neurophysiol.* 2007; **97**:4296-4309

44.

McNaughton, B.L.

**Cortical hierarchies, sleep, and the extraction of knowledge from memory**

*Artficial Intell.* 2010; **174**:205-2014

45.

Leibold, C. ∙ Kempter, R.

**Sparseness constrains the prolongation of memory lifetime via synaptic metaplasticity**

*Cereb. Cortex.* 2008; **18**:67-77

46.

Rolls, E.T....

**The representational capacity of the distributed encoding of information provided by populations of neurons in primate temporal visual cortex**

*Exp. Brain Res.* 1997; **114**:149-162

47.

Barnes, C.A....

**Comparison of spatial and temporal characteristics of neuronal activity in sequential stages of hippocampal processing**

*Prog. Brain Res.* 1990; **83**:287-300

[Crossref](https://doi.org/10.1016/S0079-6123\(08\)61257-1)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/2392566/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1016%2FS0079-6123%2808%2961257-1&pmid=2392566)

([Boxes 4 and 5](#tb0025)). It should be noted, however, that the degree of sparsity and similarity-based overlap varies across subregions of the hippocampus and neocortex ([Boxes 4 and 5](#tb0025)). While some of the relevant findings have been seen as supporting other theories

48.

McKenzie, S....

**Representation of memories in the cortical–hippocampal system: results from the application of population similarity analyses**

*Neurobiol. Learn. Mem.* 2015;

Published online December 31, 2015

, such differences are fully consistent with CLS and have long been exploited in CLS-based accounts of the roles of specific hippocampal subregions ([Boxes 2–4](#tb0015)). Similarly, learning rates vary across hippocampal areas in the theory ([Box 2](#tb0015)) and, likewise, there may be variation in learning rates across neocortical areas ([Box 5](#tb0030)).

![](https://www.cell.com/cms/10.1016/j.tics.2016.05.004/asset/57c80ccb-fc20-4376-a9b3-145813b88a81/main.assets/gr1b5_lrg.jpg)

Box 5 Similarity-Based Coding in High-Level Visual Cortex

#### Joint Contribution to Task Performance

In the CLS theory, the hippocampal and neocortical systems contribute jointly to performance in many tasks and many different types of memories. This point applies to tasks that are often thought of as tapping ‘episodic memory’ (memory for the elements of one specific experience), ‘semantic memory’ (knowledge of facts, e.g., about the properties of objects) or ‘implicit memory’ (performance enhancement as a consequence of prior experience that is not dependent on explicit recollection of the prior experience). In the CLS theory, tasks and types of memory are seen as falling on a continuum, with varying degrees of dependence on the two learning systems depending on task, item, and other variables. For example, consider the task of learning a list of paired associates. The list may contain a mixture of pairs with strong, weak, or no discernable prior association (e.g., dog–cat, heavy–suitcase, city–tiger). Recall of the second word of a pair when cued with the first is worse in hippocampal patients than controls, but both groups show better performance on items with stronger prior association

49.

Cutting, J.

**A cognitive approach to Korsakoff's syndrome**

*Cortex.* 1978; **14**:485-495

[Crossref](https://doi.org/10.1016/S0010-9452\(78\)80024-0)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/738059/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1016%2FS0010-9452%2878%2980024-0&pmid=738059)

. The findings have been captured in a model

50.

McClelland, J.L.

**Memory as a constructive process: the parallel-distributed processing apporach**

Nalbantian, P.... (Editors)

**The Memory Process: Neuroscientific and Humanist Perspectives**

MIT Press, 2011; 99-129

[Google Scholar](https://scholar.google.com/scholar?q=J.L.McClellandMemory+as+a+constructive+process%3A+the+parallel-distributed+processing+apporachP.NalbantianThe+Memory+Process%3A+Neuroscientific+and+Humanist+Perspectives2011MIT+Press99129)

(K. Kwok, PhD Thesis, Carnegie-Mellon University, 2003) in which hippocampal and neocortical networks jointly contribute to retrieval. Background associative knowledge is mediated by the cortex and the hippocampus mediates acquisition of associations linking each item pair to the learning context.

## Replay of Hippocampal Memories and Interleaved Learning

We now consider two important aspects of the CLS theory that are central foci of this review: the replay of hippocampal memories and interleaved learning. According to the theory, the hippocampal representation formed in learning an event affords a way of allowing gradual integration of knowledge of the event into neocortical knowledge structures. This can occur if the hippocampal representation can reactivate or replay the contents of the new experience back to the neocortex, interleaved with replay and/or ongoing exposure to other experiences

1.

McClelland, J.L....

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

[Crossref](https://doi.org/10.1037/0033-295X.102.3.419)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7624455/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.102.3.419&pmid=7624455)

. In this way the new experience becomes part of the database of experiences that govern the values of the connections in the neocortical learning system

51.

Frankland, P.W. ∙ Bontempi, B.

**The organization of recent and remote memories**

*Nat. Rev. Neurosci.* 2005; **6**:119-130

52.

Winocur, G....

**Memory formation and long-term retention in humans and animals: convergence towards a transformation account of hippocampal–neocortical interactions**

*Neuropsychologia.* 2010; **48**:2339-2356

53.

Squire, L.R....

**The medial temporal region and memory consolidation: a new hypothesis**

Weingartner, H. ∙ Parker, E.S. (Editors)

**Memory Consolidation: Psychobiology of Cognition**

Psychology Press, 1984; 185-210

[Google Scholar](https://scholar.google.com/scholar?q=L.R.SquireThe+medial+temporal+region+and+memory+consolidation%3A+a+new+hypothesisH.WeingartnerE.S.ParkerMemory+Consolidation%3A+Psychobiology+of+Cognition1984Psychology+Press185210)

. Which other memories are selected for interleaving with the new experience remains an open question. Most simply, the hippocampus might replay recent novel experiences interleaved with all other recent experiences still stored in the hippocampus. A variant of this scheme would be for new experiences to be interleaved with related experiences activated by the new experience, through the dynamics of a recurrent mechanism (as in the REMERGE model

5.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: A model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

, described below). An alternative possibility would be that interleaved learning does not actually involve the faithful replay of previous experiences: instead, hippocampal replay of recent experiences might be interleaved with activation of cortical activity patterns consistent with the structured knowledge implicit in the neocortical network (e.g.,

23.

French, R.M.

**Catastrophic forgetting in connectionist networks**

*Trends Cogn. Sci.* 1999; **3**:128-135

54.

Robins, A.

**Consolidation in neural networks and in the sleeping brain**

*Conn. Sci.* 1996; **8**:259-276

55.

Tononi, G. ∙ Cirelli, C.

**Sleep and the price of plasticity: from synaptic and cellular homeostasis to memory consolidation and integration**

*Neuron.* 2014; **81**:12-34

56.

Norman, K.A....

**Methods for reducing interference in the complementary learning systems model: oscillating inhibition and autonomous memory rehearsal**

*Neural Netw.* 2005; **18**:1212-1228

).

Thus, the dual-system architecture proposed by CLS theory effectively harnesses the complementary properties of each of the two component systems, allowing new information to be rapidly stored in the hippocampus and then slowly integrated into neocortical representations. This process, sometimes labeled ‘systems level consolidation’

51.

Frankland, P.W. ∙ Bontempi, B.

**The organization of recent and remote memories**

*Nat. Rev. Neurosci.* 2005; **6**:119-130

, arises, within the theory, from gradual cortical learning driven by replay of the new information, interleaved with other activity to minimize disruption of existing knowledge during the integration of the new information.

*Empirical Evidence of Replay.* Because of its centrality in the theory, we highlight key empirical evidence that replay events really do occur. The data come primarily from rodents, recorded during periods of inactivity (including sleep), in which hippocampal neurons exhibit large irregular activity (LIA) patterns that are distinct from the activity patterns observed during active states

2.

O’Neill, J....

**Play it again: reactivation of waking experience and memory**

*Trends Neurosci.* 2010; **33**:220-229

3.

Wikenheiser, A.M. ∙ Redish, A.D.

**Decoding the cognitive map: ensemble hippocampal sequences and decision making**

*Curr. Opin. Neurobiol.* 2015; **32**:8-15

. During LIA states, synchronous discharges thought to be initiated in hippocampal area CA3 produce **sharp-wave ripples** (SWRs), which are propagated to neocortex. SWRs reflect the reactivation of recent experiences, expressed as the sequential firing of so-called place cells, cells that fire when the animal is at a specific location

2.

O’Neill, J....

**Play it again: reactivation of waking experience and memory**

*Trends Neurosci.* 2010; **33**:220-229

3.

Wikenheiser, A.M. ∙ Redish, A.D.

**Decoding the cognitive map: ensemble hippocampal sequences and decision making**

*Curr. Opin. Neurobiol.* 2015; **32**:8-15

57.

Skaggs, W.E. ∙ McNaughton, B.L.

**Replay of neuronal firing sequences in rat hippocampus during sleep following spatial experience**

*Science.* 1996; **271**:1870-1873

58.

Wilson, M.A. ∙ McNaughton, B.L.

**Reactivation of hippocampal ensemble memories during sleep**

*Science.* 1994; **265**:676-679

[Crossref](https://doi.org/10.1126/science.8036517)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8036517/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1126%2Fscience.8036517&pmid=8036517)

59.

Carr, M.F....

**Hippocampal replay in the awake state: a potential substrate for memory consolidation and retrieval**

*Nat. Neurosci.* 2011; **14**:147-153

. These replay events appear to be time-compressed by a factor of about 20, bringing neuronal spikes that were well-separated in time during an actual experience into a time-window that enhances synaptic plasticity both within the hippocampus and between hippocampus and neocortex, and this allows a single event to be replayed many times during a single sleep period

1.

McClelland, J.L....

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

[Crossref](https://doi.org/10.1037/0033-295X.102.3.419)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7624455/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.102.3.419&pmid=7624455)

2.

O’Neill, J....

**Play it again: reactivation of waking experience and memory**

*Trends Neurosci.* 2010; **33**:220-229

3.

Wikenheiser, A.M. ∙ Redish, A.D.

**Decoding the cognitive map: ensemble hippocampal sequences and decision making**

*Curr. Opin. Neurobiol.* 2015; **32**:8-15

58.

Wilson, M.A. ∙ McNaughton, B.L.

**Reactivation of hippocampal ensemble memories during sleep**

*Science.* 1994; **265**:676-679

[Crossref](https://doi.org/10.1126/science.8036517)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8036517/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1126%2Fscience.8036517&pmid=8036517)

60.

Buzsaki, G.

**Two-stage model of memory trace formation: a role for ‘noisy’ brain states**

*Neuroscience.* 1989; **31**:551-570

61.

Kali, S. ∙ Dayan, P.

**Off-line replay maintains declarative memories in a model of hippocampal-neocortical interactions**

*Nat. Neurosci.* 2004; **7**:286-294

. Consistent with the proposal that replay events are propagated to neocortex

1.

McClelland, J.L....

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

[Crossref](https://doi.org/10.1037/0033-295X.102.3.419)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7624455/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.102.3.419&pmid=7624455)

2.

O’Neill, J....

**Play it again: reactivation of waking experience and memory**

*Trends Neurosci.* 2010; **33**:220-229

3.

Wikenheiser, A.M. ∙ Redish, A.D.

**Decoding the cognitive map: ensemble hippocampal sequences and decision making**

*Curr. Opin. Neurobiol.* 2015; **32**:8-15

60.

Buzsaki, G.

**Two-stage model of memory trace formation: a role for ‘noisy’ brain states**

*Neuroscience.* 1989; **31**:551-570

61.

Kali, S. ∙ Dayan, P.

**Off-line replay maintains declarative memories in a model of hippocampal-neocortical interactions**

*Nat. Neurosci.* 2004; **7**:286-294

, SWRs within hippocampus are synchronized with fluctuations in neocortical activity states

62.

Sirota, A....

**Communication between neocortex and hippocampus during sleep in rodents**

*Proc. Natl. Acad. Sci. U.S.A.* 2003; **100**:2065-2069

63.

Battaglia, F.P....

**Hippocampal sharp wave bursts coincide with neocortical ‘up-state’ transitions**

*Learn. Mem.* 2004; **11**:697-704

. Also, hippocampal replay of specific place sequences has been shown to correlate with replay of patterns on grid cells located in the deep layers of the entorhinal cortex that receive the output of the hippocampal circuit

64.

Ólafsdóttir, H....

**Coordinated grid and place cell replay during rest**

*Nat. Neurosci.* 2016;

Published online April 18, 2016

, as well as more distant neocortical regions

65.

Ji, D. ∙ Wilson, M.A.

**Coordinated memory replay in the visual cortex and hippocampus during sleep**

*Nat. Neurosci.* 2007; **10**:100-107

. Furthermore, a recent study observed coordinated reactivation of hippocampal and ventral striatal neurons during slow-wave sleep (SWS), with location-specific hippocampal replay preceding activity in reward-sensitive striatal neurons

66.

Lansink, C.S....

**Hippocampus leads ventral striatum in replay of place–reward information**

*PLoS Biol.* 2009; **7**:e1000173

. A causal role for replay is supported by studies showing that the disruption of ripples in the hippocampus produces a significant impairment in systems-level consolidation in rats

67.

Ego-Stengel, V. ∙ Wilson, M.A.

**Disruption of ripple-associated hippocampal activity during rest impairs spatial learning in the rat**

*Hippocampus.* 2010; **20**:1-10

68.

Girardeau, G....

**Selective suppression of hippocampal ripples impairs spatial memory**

*Nat. Neurosci.* 2009; **12**:1222-1223

69.

Nakashiba, T....

**Hippocampal CA3 output is crucial for ripple-associated reactivation and consolidation of memory**

*Neuron.* 2009; **62**:781-787

.

*Additional Roles of Replay.* Recent work has highlighted additional roles for replay – both during LIA but also during theta states

3.

Wikenheiser, A.M. ∙ Redish, A.D.

**Decoding the cognitive map: ensemble hippocampal sequences and decision making**

*Curr. Opin. Neurobiol.* 2015; **32**:8-15

70.

Johnson, A. ∙ Redish, A.D.

**Neural ensembles in CA3 transiently encode paths forward of the animal at a decision point**

*J. Neurosci.* 2007; **27**:12176-12189

71.

Wikenheiser, A.M. ∙ Redish, A.D.

**Hippocampal theta sequences reflect current goals**

*Nat. Neurosci.* 2015; **18**:289-294

– well beyond its initially proposed role in systems-level consolidation. Specifically, recent evidence suggests that hippocampal replay can: (i) be non-local in nature, initiated by place cell activity coding for locations distant from the current position of the animal

3.

Wikenheiser, A.M. ∙ Redish, A.D.

**Decoding the cognitive map: ensemble hippocampal sequences and decision making**

*Curr. Opin. Neurobiol.* 2015; **32**:8-15

; (ii) reflect novel shortcut paths by stitching together components of trajectories

72.

Wu, X. ∙ Foster, D.J.

**Hippocampal replay captures the unique topological structure of a novel environment**

*J. Neurosci.* 2014; **34**:6459-6469

73.

Gupta, A.S....

**Hippocampal replay is not a simple function of experience**

*Neuron.* 2010; **65**:695-705

; (iii) support look-ahead online planning during goal-directed behavior

70.

Johnson, A. ∙ Redish, A.D.

**Neural ensembles in CA3 transiently encode paths forward of the animal at a decision point**

*J. Neurosci.* 2007; **27**:12176-12189

74.

Pfeiffer, B.E. ∙ Foster, D.J.

**Hippocampal place-cell sequences depict future paths to remembered goals**

*Nature.* 2013; **497**:74-79

; (iv) reflect trajectories through parts of environments that have only been seen but never visited; and (v) be biased to reflect trajectories through rewarded locations in the environment

76.

Bendor, D. ∙ Wilson, M.A.

**Biasing the content of hippocampal replay during sleep**

*Nat. Neurosci.* 2012; **15**:1439-1444

. Together, this evidence points to a pervasive role for hippocampal replay in the creation, updating, and deployment of representations of the environment

3.

Wikenheiser, A.M. ∙ Redish, A.D.

**Decoding the cognitive map: ensemble hippocampal sequences and decision making**

*Curr. Opin. Neurobiol.* 2015; **32**:8-15

. Notably, these putative functions accord well with perspectives that emphasize the role of the human hippocampus in prospection

77.

Schacter, D.L. ∙ Addis, D.R.

**The cognitive neuroscience of constructive memory: remembering the past and imagining the future**

*Philos. Trans. R. Soc. B Biol. Sci.* 2007; **362**:773-786

, imagination

78.

Hassabis, D. ∙ Maguire, E.A.

**Deconstructing episodic memory with construction**

*Trends Cogn. Sci.* 2007; **11**:299-306

79.

Hassabis, D....

**Patients with hippocampal amnesia cannot imagine new experiences**

*Proc. Natl. Acad. Sci. U.S.A.* 2007; **104**:1726-1731

, and the potential utility of episodic control of behavior over control based on learned summary statistics in some circumstances (e.g., given relatively little experience in an environment)

80.

Lengyel, M. ∙ Dayan, P.

**Hippocampal contributions to control: the third way**

*Neural Inf. Process. Syst.* 2007;

[Google Scholar](https://scholar.google.com/scholar?q=M.LengyelP.DayanHippocampal+contributions+to+control%3A+the+third+wayNeural+Inf.+Process.+Syst.2007)

.

*Proposed Role for the Hippocampus in Circumventing the Statistics of the Environment.* As we have seen, hippocampal activity during LIA does not necessarily reflect a faithful replay of recent experiences. Instead, mounting evidence suggests that replay may be biased towards rewarding events

59.

Carr, M.F....

**Hippocampal replay in the awake state: a potential substrate for memory consolidation and retrieval**

*Nat. Neurosci.* 2011; **14**:147-153

76.

Bendor, D. ∙ Wilson, M.A.

**Biasing the content of hippocampal replay during sleep**

*Nat. Neurosci.* 2012; **15**:1439-1444

. Building on this, we consider the broader hypothesis that the hippocampus may allow the general statistics of the environment to be circumvented by reweighting experiences such that statistically unusual but significant events may be afforded privileged status, leading not only to preferential storage and/or stabilization (as originally envisaged in the theory) but also leading to preferential replay that then shapes neocortical learning. We see this hippocampal reweighting process as being particularly important in enriching the memories of both biological and artificial agents, given memory capacity and other constraints as well as incomplete exploration of environments. These ideas link our perspective to rational accounts that view memory systems as being optimized to the goals of an organism rather than simply mirroring the structure of the environment

81.

Anderson, J.R. ∙ Milson, R.

**Human memory: an adaptive perspective**

*Psychol. Rev.* 1989; **96**:703

[Crossref](https://doi.org/10.1037/0033-295X.96.4.703)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.96.4.703)

.

A wide range of factors may affect the significance of individual experiences

82.

Lisman, J.E. ∙ Grace, A.A.

**The hippocampal–VTA loop: controlling the entry of information into long-term memory**

*Neuron.* 2005; **46**:703-713

83.

Lisman, J....

**A neoHebbian framework for episodic memory; role of dopamine-dependent late LTP**

*Trends Neurosci.* 2011; **34**:536-547

: for example, they may be surprising or novel; high in reward value (either positive or negative) or in their informational content (e.g., in reducing uncertainty about the best action to take in a given state). The hippocampus – in receipt of highly processed multimodal sensory information

84.

van Strien, N.M....

**The anatomy of memory: an interactive overview of the parahippocampal-hippocampal network**

*Nat. Rev. Neurosci.* 2009; **10**:272-282

as well as neuromodulatory signals triggered by such factors

83.

Lisman, J....

**A neoHebbian framework for episodic memory; role of dopamine-dependent late LTP**

*Trends Neurosci.* 2011; **34**:536-547

85.

Hasselmo, M.E.

**Neuromodulation: acetylcholine and memory consolidation**

*Trends Cogn. Sci.* 1999; **3**:351-359

– is well positioned to reweight individual experiences accordingly. Indeed, recent work suggests specific molecular mechanisms that support the stabilization of memories and specific neuromodulatory projections to the hippocampus

83.

Lisman, J....

**A neoHebbian framework for episodic memory; role of dopamine-dependent late LTP**

*Trends Neurosci.* 2011; **34**:536-547

86.

McNamara, C.G....

**Dopaminergic neurons promote hippocampal reactivation and spatial memory persistence**

*Nat. Neurosci.* 2014; **17**:1658-1660

87.

Sara, S.J.

**The locus coeruleus and noradrenergic modulation of cognition**

*Nat. Rev. Neurosci.* 2009; **10**:211-223

88.

McGaugh, J.L.

**The amybdala modulates the consolidation of memories of emotionally arousing experiences**

*Annu. Rev. Neurosci.* 2004; **27**:1-28

that allow the persistence of individual experiences in the hippocampus to be modulated by events that occur both before and afterwards, providing mechanisms by which episodes may be retrospectively reweighted if their significance is enhanced by subsequent events

83.

Lisman, J....

**A neoHebbian framework for episodic memory; role of dopamine-dependent late LTP**

*Trends Neurosci.* 2011; **34**:536-547

89.

Redondo, R.L. ∙ Morris, R.G.

**Making memories last: the synaptic tagging and capture hypothesis**

*Nat. Rev. Neurosci.* 2011; **12**:17-30

, thereby influencing the probability of replay.

The importance of the reweighting capability of the hippocampus is illustrated by the following example. Over a multitude of experiences, consider a child gradually acquiring conceptual knowledge about the world, which includes the fact that dogs are typically friendly. Imagine that one day the child experiences an encounter with a frightening, aggressive dog – an event that would be surprising, novel, and charged with emotion. Ideally, this significant experience would not only be rapidly stored within the hippocampus but would also lead to appropriate updating of relevant knowledge structures in the neocortex. While CLS theory initially emphasized the role of the hippocampus in the first stage (i.e., initial storage of such one-shot experiences), here we highlight an additional role for the hippocampus in ‘marking’ salient but statistically infrequent experiences, thereby ensuring that such events are not swamped by the wealth of typical experiences – but instead are preferentially stabilized and replayed to the neocortex, thereby allowing knowledge structures to incorporate this new information. Although this reweighting would generally be adaptive, it could on occasion have maladaptive consequences. For example, in post-traumatic stress disorder, a unique aversive experience may be transformed into a persistent and dominant representation through a runaway process of repeated reactivation.

## Challenges Arising from Recent Empirical Findings

In this section we discuss two significant challenges to the central tenets of CLS theory. Both challenges have recently been addressed through computational modeling work that extends and clarifies the principles of the theory.

### The Hippocampus, Inference, and Generalization

#### Cross-Item Inferences

The first challenge concerns the role of the hippocampus in generalizing from specific experiences to novel situations. As noted above, CLS theory emphasized the crucial role of the hippocampus as a fast learning system relying on sparse activity patterns that minimize overlap even in the representation of very similar experiences. This representation scheme was thought to support memory of specifics, leaving generalization to the complementary neocortical system. Evidence presenting a substantial challenge to this account, however, has come from paradigms where individuals have been shown to rapidly utilize features that create links among a set of related experiences as a basis for a form of inference within or shortly after a single experimental session

4.

Zeithamova, D....

**The hippocampus and inferential reasoning: building memories to navigate future decisions**

*Front. Hum. Neurosci.* 2012; **6**:1-14

5.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: A model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

90.

Kumaran, D.

**What representations and computations underpin the contribution of the hippocampus to generalization and inference?**

*Front. Hum. Neurosci.* 2012; **6**:157

91.

Bunsey, M. ∙ Eichenbaum, H.

**Conservation of hippocampal memory function in rats and humans**

*Nature.* 1996; **379**:255-257

92.

Zeithamova, D. ∙ Preston, A.R.

**Flexible memories: differential roles for medial temporal lobe and prefrontal cortex in cross-episode binding**

*J. Neurosci.* 2010; **30**:14676-14684

93.

Preston, A.R....

**Hippocampal contribution to the novel use of relational information in declarative memory**

*Hippocampus.* 2004; **14**:148-152

94.

Dusek, J.A. ∙ Eichenbaum, H.

**The hippocampus and memory for orderly stimulus relations**

*Proc. Natl. Acad. Sci. U.S.A.* 1997; **94**:7109-7114

95.

Shohamy, D. ∙ Wagner, A.D.

**Integrating memories in the human brain: hippocampal-midbrain encoding of overlapping events**

*Neuron.* 2008; **60**:378-389

.

The **paired associate inference** (PAI) task provides an example of a task that involves the hippocampus and captures the essence of requiring cross-item inferences required in other relevant tasks (such as the transitive inference task reviewed in

4.

Zeithamova, D....

**The hippocampus and inferential reasoning: building memories to navigate future decisions**

*Front. Hum. Neurosci.* 2012; **6**:1-14

). In the study phase of the PAI task, subjects view pairs of objects (e.g., AB, BC) that are derived from triplets (i.e., ABC) or larger object sets (e.g., sextets: A, B, C, D, E, F; [Box 6](#tb0035)). In the crucial test trials, subjects are tested on their ability to appreciate the indirect relationships between items that were never presented together (e.g., A and F in the sextet version). Evidence for a role of the hippocampus in supporting inference in such settings naturally raises the question of the neural mechanisms underlying this function, and has been seen as challenging the view that the hippocampus only stores separate representations of specific items or experiences. Indeed, the findings have been taken as supporting ‘encoding-based overlap’ models, in which it is proposed that the hippocampus supports inference by using representations that integrate or combine overlapping pairs of items (e.g., AB and BC in the triplet version of the PAI task).

![](https://www.cell.com/cms/10.1016/j.tics.2016.05.004/asset/eeb3bdd8-469f-400c-af46-d9cd0bcb46fd/main.assets/gr1b6_lrg.jpg)

Box 6 Generalization Through Recurrence in the Hippocampal System

While the PAI findings weigh against the view that the hippocampus only plays a role in the behaviors based on the contents of a single previous episode, these findings could arise from reliance on separate representations of the relevant AB, AC item pairs. Indeed, the CLS-grounded REMERGE model

5.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: A model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

proposes that representations combining elements of items never experienced together may arise from simultaneous activation of two or more memory traces within the hippocampal system, driven by an interactive activation process occurring within a recurrent circuit, whereby the output of the system can be recirculated back into it as a subsequent input ([Box 6](#tb0035)). This proposal is consistent with anatomical and physiological evidence

101.

Kloosterman, F....

**Two reentrant pathways in the hippocampal–entorhinal system**

*Hippocampus.* 2004; **14**:1026-1039

([Box 2](#tb0015)).

REMERGE, therefore, can be considered to capture the insights of the relational theory of memory by allowing the linkage of related episodes within a dynamic memory space, while preserving the assumption that the hippocampal system relies primarily on pattern-separated representations seen as essential for episodic memory

1.

McClelland, J.L....

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

[Crossref](https://doi.org/10.1037/0033-295X.102.3.419)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7624455/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.102.3.419&pmid=7624455)

9.

Marr, D.

**Simple memory: a theory for archicortex**

*Philos. Trans. R. Soc. L. B Biol. Sci.* 1971; **262**:23-81

[Crossref](https://doi.org/10.1098/rstb.1971.0078)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/4399412/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1098%2Frstb.1971.0078&pmid=4399412)

25.

McNaughton, B.L. ∙ Morris, R.G.

**Hippocampal synaptic enhancement and information storage within a distributed memory system**

*Trends Neurosci.* 1987; **10**:408-415

26.

Treves, A. ∙ Rolls, E.T.

**Computational constraints suggest the need for two distinct input systems to the hippocampal CA3 network**

*Hippocampus.* 1992; **2**:189-199

27.

O’Reilly, R.C. ∙ McClelland, J.L.

**Hippocampal conjunctive encoding, storage, and recall: avoiding a trade-off**

*Hippocampus.* 1994; **4**:661-682

30.

O’Reilly, R.C. ∙ Rudy, J.W.

**Conjunctive representations in learning and memory: principles of cortical and hippocampal function**

*Psychol. Rev.* 2001; **108**:311-345

[Crossref](https://doi.org/10.1037/0033-295X.108.2.311)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/11381832/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.108.2.311&pmid=11381832)

31.

Norman, K.A. ∙ O’Reilly, R.C.

**Modeling hippocampal and neocortical contributions to recognition memory: a complementary-learning-systems approach**

*Psychol. Rev.* 2003; **110**:611-646

103.

Burgess, N.

**Computational models of the spatial and mnemonic functions of the hippocampus**

Andersen, P.... (Editors)

**The Hippocampus**

Oxford University Press, 2006; 715-750

[Google Scholar](https://scholar.google.com/scholar?q=N.BurgessComputational+models+of+the+spatial+and+mnemonic+functions+of+the+hippocampusP.AndersenThe+Hippocampus2006Oxford+University+Press715750)

104.

Willshaw, D.J....

**Memory, modelling and Marr: a commentary on Marr (1971) ‘Simple memory: a theory of archicortex’**

*Philos. Trans. R. Soc. B Biol. Sci.* 2015; **370**:20140383

. Further, the recurrency within the hippocampal system makes the prediction that hippocampal activity may sometimes combine information from several separate episodes – a notion that receives empirical support from neuronal recordings in rodents

72.

Wu, X. ∙ Foster, D.J.

**Hippocampal replay captures the unique topological structure of a novel environment**

*J. Neurosci.* 2014; **34**:6459-6469

73.

Gupta, A.S....

**Hippocampal replay is not a simple function of experience**

*Neuron.* 2010; **65**:695-705

. This generalized replay – simultaneous reactivation of multiple related traces during testing or offline periods – may facilitate the creation of new representations from the recombination of multiple related episodes (‘stored generalizations’)

5.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: A model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

and the discovery of novel relationships (e.g., shortcuts)

72.

Wu, X. ∙ Foster, D.J.

**Hippocampal replay captures the unique topological structure of a novel environment**

*J. Neurosci.* 2014; **34**:6459-6469

73.

Gupta, A.S....

**Hippocampal replay is not a simple function of experience**

*Neuron.* 2010; **65**:695-705

. Empirical evidence also supports a role for the hippocampus in category- and so-called ‘statistical’ learning

105.

Schapiro, A.C....

**The necessity of the medial temporal lobe for statistical learning**

*J. Cogn. Neurosci.* 2014; **26**:1736-1747

106.

Knowlton, B.J. ∙ Squire, L.R.

**The learning of categories: parallel brain systems for item memory and category knowledge**

*Science.* 1993; **262**:1747-1749

[Crossref](https://doi.org/10.1126/science.8259522)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8259522/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1126%2Fscience.8259522&pmid=8259522)

107.

Shohamy, D. ∙ Turk-Browne, N.B.

**Mechanisms for widespread hippocampal involvement in cognition**

*J. Exp. Psychol. Gen.* 2013; **142**:1159-1170

: the mechanisms in REMERGE and other related models that rely on separate memory traces for individual items allow weak hippocampal traces that support only relatively poor item recognition to mediate near-normal generalization

5.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: A model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

108.

Nosofsky, R.M.

**Choice, similarity, and the context theory of classification**

*J. Exp. Psychol. Learn. Mem. Cogn.* 1984; **10**:104-114

.

While encoding-based overlap and retrieval-based models make divergent experimental predictions, empirical evidence to date does not definitely distinguish between them ( for discussion). Indeed, it is conceivable that both mechanisms operate under different circumstances – perhaps as a function of the experimental paradigm under consideration, amount of training, and delay between training and testing (e.g.,

109.

Tamminen, J....

**From specific examples to general knowledge in language learning**

*Cogn. Psychol.* 2015; **79**:1-39

). It is also worth noting that in reality the difference between encoding-based and retrieval-based models is not absolute: as alluded to above, generalized replay may facilitate the formation of new representations that directly capture distant relationships between items (e.g., the linear hierarchy in the transitive inference paradigm

5.

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: A model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

90.

Kumaran, D.

**What representations and computations underpin the contribution of the hippocampus to generalization and inference?**

*Front. Hum. Neurosci.* 2012; **6**:157

110.

Walker, M.P. ∙ Stickgold, R.

**Overnight alchemy: sleep-dependent memory evolution**

*Nat. Rev. Neurosci.* 2010; **11**:218

). Such representations then become the contents of episodic memory, subject to storage in the hippocampus.

The distinction between encoding- and retrieval-based models can be related more broadly to the finding of ‘concept’ cells: hippocampal neurons which come to respond to common features across many events, for example cells for specific odors

111.

Wood, E.R....

**The global record of memory in hippocampal neuronal activity**

*Nature.* 1999; **397**:613-616

[Crossref](https://doi.org/10.1038/16564)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/10050854/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2F16564&pmid=10050854)

, time-points within an episode

112.

Eichenbaum, H.

**Time cells in the hippocampus: a new dimension for mapping memories**

*Nat. Rev. Neurosci.* 2014; **15**:732-744

, attributes of a task, and even cells that fire to any picture or the name of a famous person

114.

Quiroga, R.Q....

**Invariant visual representation by single neurons in the human brain**

*Nature.* 2005; **435**:1102-1107

. In [Box 7](#tb0040) we review empirical findings concerning concept cells and pattern overlap sometimes observed in parts of hippocampus, and consider how well these findings fit within the perspective that the hippocampus supports pattern separation.

Box 7

Concept Cells and Nodal Codings?

Reports of concept cells in the hippocampus have been taken as contradicting a tenet of CLS theory, but the existence of such neurons is not necessarily inconsistent with it, given that the theory expects different hippocampal regions to vary in terms of context specificity and also permits variation within hippocampal regions ([Box 3](#tb0020)). Evidence supporting the CLS prediction of context-specificity in the CA3 and DG comes from a recent intracranial recording study in humans. In this study, neurons in CA3/DG, and also in the subiculum, tended to discriminate between different images of a famous person – with responses correlating with successful performance in a recognition memory task that required discriminating previously experienced targets from similar lures. Neurons in other MTL areas (i.e., entorhinal and parahippocampal cortices) exhibited more invariant ‘concept cell like’ responses that were not linked to memory performance (the CA1 subregion was sparsely sampled in this study).

It is also interesting to consider the finding of ‘splitter’ cells in a task where animals must alternate between turning left and right on successive trials in a T maze

167.

Wood, E.R....

**Hippocampal neurons encode information about different types of memory episodes occurring in the same location**

*Neuron.* 2000; **27**:623-633

168.

Ferbinteanu, J. ∙ Shapiro, M.L.

**Prospective and retrospective memory coding in the hippocampus**

*Neuron.* 2003; **40**:1227-1239

169.

Bower, M.R....

**Sequential-context-dependent hippocampal activity is not necessary to learn sequences with repeated elements**

*J. Neurosci.* 2005; **25**:1313-1323

170.

MacDonald, C.J....

**Distinct hippocampal time cell sequences represent odor memories in immobilized rats**

*J. Neurosci.* 2013; **33**:14607-14616

171.

Markus, E.J....

**Interactions between location and task affect the spatial and directional firing of hippocampal neurons**

*J. Neurosci.* 1995; **15**:7079-7094

[Crossref](https://doi.org/10.1523/JNEUROSCI.15-11-07079.1995)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7472463/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1523%2FJNEUROSCI.15-11-07079.1995&pmid=7472463)

172.

Skaggs, W.E. ∙ McNaughton, B.L.

**Spatial firing properties of hippocampal CA1 populations in an environment containing two visually identical regions**

*J. Neurosci.* 1998; **18**:8455-8466

[Crossref](https://doi.org/10.1523/JNEUROSCI.18-20-08455.1998)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/9763488/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1523%2FJNEUROSCI.18-20-08455.1998&pmid=9763488)

173.

Kriegeskorte, N....

**Representational similarity analysis – connecting the branches of systems neuroscience**

*Front. Syst. Neurosci.* 2008; **2**:4

[Crossref](https://doi.org/10.3389/neuro.01.016.2008)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/19104670/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.3389%2Fneuro.01.016.2008&pmid=19104670)

174.

Komorowski, R.W....

**Robust conjunctive item-place coding by hippocampal neurons parallels learning what happens where**

*J. Neurosci.* 2009; **29**:9918-9929

175.

Ellenbogen, J.M....

**Human relational memory requires time and sleep**

*Proc. Natl. Acad. Sci. U.S.A.* 2007; **104**:7723-7728

176.

Dumay, N. ∙ Gaskell, M.G.

**Sleep-associated changes in the mental representation of spoken words**

*Psychol. Sci.* 2007; **18**:35-39

177.

Coutanche, M.N. ∙ Thompson-Schill, S.L.

**Fast mapping rapidly integrates information into existing memory networks**

*J Exp Psychol Gen.* 2014; **143**:2296-2303

178.

Sharon, T....

**Rapid neocortical acquisition of long-term arbitrary associations independent of the hippocampus**

*Proc. Natl. Acad. Sci. U.S.A.* 2011; **108**:1146-1151

179.

Merhav, M....

**Neocortical catastrophic interference in healthy and amnesic adults: a paradoxical matter of time**

*Hippocampus.* 2014; **24**:1653-1662

: here, some CA1 and CA3 place cells for locations on the central stem of the T maze are modulated by the trajectory of the rat (e.g., whether it will subsequently turn left or right) whereas others are trajectory-independent. This phenomenon, known as partial remapping

48.

McKenzie, S....

**Representation of memories in the cortical–hippocampal system: results from the application of population similarity analyses**

*Neurobiol. Learn. Mem.* 2015;

Published online December 31, 2015

170.

MacDonald, C.J....

**Distinct hippocampal time cell sequences represent odor memories in immobilized rats**

*J. Neurosci.* 2013; **33**:14607-14616

171.

Markus, E.J....

**Interactions between location and task affect the spatial and directional firing of hippocampal neurons**

*J. Neurosci.* 1995; **15**:7079-7094

[Crossref](https://doi.org/10.1523/JNEUROSCI.15-11-07079.1995)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7472463/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1523%2FJNEUROSCI.15-11-07079.1995&pmid=7472463)

172.

Skaggs, W.E. ∙ McNaughton, B.L.

**Spatial firing properties of hippocampal CA1 populations in an environment containing two visually identical regions**

*J. Neurosci.* 1998; **18**:8455-8466

[Crossref](https://doi.org/10.1523/JNEUROSCI.18-20-08455.1998)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/9763488/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1523%2FJNEUROSCI.18-20-08455.1998&pmid=9763488)

, is consistent with the idea that pattern separation is a matter of degree in our theory

27.

O’Reilly, R.C. ∙ McClelland, J.L.

**Hippocampal conjunctive encoding, storage, and recall: avoiding a trade-off**

*Hippocampus.* 1994; **4**:661-682

37.

Knierim, J.J. ∙ Neunuebel, J.P.

**Tracking the flow of hippocampal computation: pattern separation, pattern completion, and attractor dynamics**

*Neurobiol. Learn. Mem.* 2016; **129**:38-49

. As such, we should expect partly overlapping representations (i.e., rather than fully independent ‘charts’

121.

Samsonovich, A. ∙ McNaughton, B.L.

**Path integration and cognitive mapping in a continuous attractor neural network model**

*J. Neurosci.* 1997; **17**:5900-5920

[Crossref](https://doi.org/10.1523/JNEUROSCI.17-15-05900.1997)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/9221787/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1523%2FJNEUROSCI.17-15-05900.1997&pmid=9221787)

) when environmental changes are sufficiently small ([Box 3](#tb0020)). We also expect the greatest differentiation in DG, and at an early point in learning. To our knowledge no studies have yet recorded from DG in this paradigm.

In a recent study, representational similarity analysis techniques

173.

Kriegeskorte, N....

**Representational similarity analysis – connecting the branches of systems neuroscience**

*Front. Syst. Neurosci.* 2008; **2**:4

[Crossref](https://doi.org/10.3389/neuro.01.016.2008)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/19104670/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.3389%2Fneuro.01.016.2008&pmid=19104670)

were applied to ensemble recording data collected while rats performed a context-guided reward discrimination task. As expected, the population codes in CA3 and CA1 were dominated by context and place coding, although other task dimensions – reward value and item – were also represented (also see

174.

Komorowski, R.W....

**Robust conjunctive item-place coding by hippocampal neurons parallels learning what happens where**

*J. Neurosci.* 2009; **29**:9918-9929

). Although there was some representational overlap across locations based on value and item, CA3/CA1 codes were consistent with incomplete but still strong pattern separation, especially in the dorsal hippocampus. Overall, these findings appear consistent with the CLS, with the provision that pattern separation is a matter of degree, and may vary by task and region. Why CA3 shows greater specificity than CA1 in some studies but not others requires further exploration.

### Rapid Schema-Dependent Consolidation

It is useful to distinguish systems-level consolidation from what we refer to as within-system consolidation. The former refers to the gradual integration of knowledge into neocortical circuits, while the latter denotes stabilization of recently formed memories within the hippocampus, perhaps through stabilization of synapses among hippocampal neurons

89.

Redondo, R.L. ∙ Morris, R.G.

**Making memories last: the synaptic tagging and capture hypothesis**

*Nat. Rev. Neurosci.* 2011; **12**:17-30

. In the initial formulation of CLS, systems-level consolidation was viewed as temporally extended (e.g., spanning years or even decades in humans

34.

Squire, L.R....

**The medial temporal lobe**

*Annu. Rev. Neurosci.* 2004; **27**:279-306

51.

Frankland, P.W. ∙ Bontempi, B.

**The organization of recent and remote memories**

*Nat. Rev. Neurosci.* 2005; **6**:119-130

52.

Winocur, G....

**Memory formation and long-term retention in humans and animals: convergence towards a transformation account of hippocampal–neocortical interactions**

*Neuropsychologia.* 2010; **48**:2339-2356

53.

Squire, L.R....

**The medial temporal region and memory consolidation: a new hypothesis**

Weingartner, H. ∙ Parker, E.S. (Editors)

**Memory Consolidation: Psychobiology of Cognition**

Psychology Press, 1984; 185-210

[Google Scholar](https://scholar.google.com/scholar?q=L.R.SquireThe+medial+temporal+region+and+memory+consolidation%3A+a+new+hypothesisH.WeingartnerE.S.ParkerMemory+Consolidation%3A+Psychobiology+of+Cognition1984Psychology+Press185210)

). Although it was noted in

1.

McClelland, J.L....

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

[Crossref](https://doi.org/10.1037/0033-295X.102.3.419)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7624455/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.102.3.419&pmid=7624455)

that the timeframe could be highly variable (depending, perhaps, on the rate of replay of memory traces in the hippocampus), recent evidence suggests that this timeframe can be much shorter than anticipated (e.g., as little as a few hours to a couple of days)

7.

Tse, D....

**Schemas and memory consolidation**

*Science.* 2007; **316**:76-82

8.

Tse, D....

**Schema-dependent gene activation and memory encoding in neocortex**

*Science.* 2011; **333**:891-895

. We focus on empirical data from the influential ‘event arena’ paradigm which demonstrated striking evidence of this phenomenon

7.

Tse, D....

**Schemas and memory consolidation**

*Science.* 2007; **316**:76-82

8.

Tse, D....

**Schema-dependent gene activation and memory encoding in neocortex**

*Science.* 2011; **333**:891-895

.

In the studies using this paradigm

7.

Tse, D....

**Schemas and memory consolidation**

*Science.* 2007; **316**:76-82

, rats were trained to forage for food in an event arena whose location was indicated by the identity of a flavor (e.g., banana) presented to the animal as a cue in a start box ([Box 8](#tb0045)). Learning of six such flavor–place paired associations (PAs) required multiple sessions distributed over several weeks, and was found to be hippocampus-dependent. Interestingly, although the learning of the original six PAs proceeded at a slow rate, rats were then able to learn two new PAs within the now familiar event arena based on a single exposure to each. Importantly, this one-shot learning was dependent on the presence of prior knowledge, often termed a ‘schema’: no such rapid learning was observed when rats that had been trained within one event arena were exposed to new PAs within a novel arena. Further, although the hippocampus must be intact for learning of new PAs in the familiar environment, memory for the new PAs remained robust when the hippocampus was surgically removed 2 days later. A follow-up study

8.

Tse, D....

**Schema-dependent gene activation and memory encoding in neocortex**

*Science.* 2011; **333**:891-895

provided insights into the neural basis of this phenomenon: the expression of genes associated with synaptic plasticity was significantly greater in neocortex very shortly (80minutes) after rats experienced new PAs in the familiar arena compared to new PAs in the unfamiliar arena. Taken together, these results support the view that rapid systems-level consolidation, mediated by extensive synaptic changes in the neocortex within a short time after initial learning, is possible if the novel information is consistent with previously acquired knowledge.

![](https://www.cell.com/cms/10.1016/j.tics.2016.05.004/asset/ab93aec1-fac2-4846-8db1-52fe83275922/main.assets/gr1b8_lrg.jpg)

Box 8 Rapid Integration of New Learning in the Neocortex: When Does it Occur?

At face value, the findings from the event arena paradigm

7.

Tse, D....

**Schemas and memory consolidation**

*Science.* 2007; **316**:76-82

8.

Tse, D....

**Schema-dependent gene activation and memory encoding in neocortex**

*Science.* 2011; **333**:891-895

present a substantial challenge to a core tenet of CLS theory as originally stated: newly acquired memories, the theory proposed, should remain hippocampus-dependent for an extended time to allow for gradual interleaved learning such that integration into the neocortex can take place while avoiding the catastrophic forgetting of previously acquired knowledge. It is worth noting, however, that the simulations presented in the original CLS paper to illustrate the problem of catastrophic interference involved the learning of new information that is inconsistent with prior knowledge. As such, the relationship between the degree to which new information is schema-consistent and the timeframe of systems-level consolidation was not actually explored.

Recent work within the CLS framework

115.

McClelland, J.L.

**Incorporating rapid neocortical learning of new schema-consistent information into complementary learning systems theory**

*J. Exp. Psychol. Gen.* 2013; **142**:1190-1210

addressed this issue using simulations designed to parallel the key features of the event arena experiments

7.

Tse, D....

**Schemas and memory consolidation**

*Science.* 2007; **316**:76-82

8.

Tse, D....

**Schema-dependent gene activation and memory encoding in neocortex**

*Science.* 2011; **333**:891-895

using the same neural network architecture and content domain that had been used in the original CLS paper as an illustration of the principles of learning in the neocortex. Briefly, the network was first trained to gradually acquire a schema (structured body of knowledge) about the properties of a set of individual animals (e.g., canary is a bird, can fly; salmon is a fish, can swim), paralleling the initial learning phase over several weeks in the event area paradigm (

115.

McClelland, J.L.

**Incorporating rapid neocortical learning of new schema-consistent information into complementary learning systems theory**

*J. Exp. Psychol. Gen.* 2013; **142**:1190-1210

for details). Next, the ability of this trained network to acquire new information was examined. The network was trained on a new item X, whose features were either consistent or inconsistent with prior knowledge (e.g., X is a bird and X can fly, consistent with known birds, or X is a bird but can swim, not fly, inconsistent with the items known to the network), thus mirroring the learning of new PAs under schema-consistent and schema-inconsistent conditions in the event arena studies

7.

Tse, D....

**Schemas and memory consolidation**

*Science.* 2007; **316**:76-82

. Notably, the network exhibited rapid learning of schema-consistent information without disrupting existing knowledge, while schema-inconsistent information was acquired much more slowly and necessitated interleaved training with the already-known examples (e.g., canary) to avoid catastrophic interference. Interestingly, there was also a clear relationship between the profile of weight changes occurring in the network and the consistency of the information being learned. Specifically, even though the same small value of the learning rate parameter was used in both simulations, large amplitude weight changes occurred during the learning of schema-consistent, but not schema-inconsistent, information – emulating the schema-dependent pattern of neocortical plasticity-related gene expression reported in

8.

Tse, D....

**Schema-dependent gene activation and memory encoding in neocortex**

*Science.* 2011; **333**:891-895

. A theoretical analysis of multilayer neural networks makes clear why the model exhibits these effects

20.

Saxe, A.M....

**Exact solutions to the nonlinear dynamics of learning in deep linear neural networks**

2014

Published online December 20, 2013. http://arxiv.org/abs/1312.6120

[Google Scholar](https://scholar.google.com/scholar?q=A.M.SaxeExact+solutions+to+the+nonlinear+dynamics+of+learning+in+deep+linear+neural+networks2014Published+online+December+20%2C+2013.+http%3A%2F%2Farxiv.org%2Fabs%2F1312.6120)

: the analysis shows that the rate of learning within a multilayered neural network of the type that CLS attributes to the neocortex

20.

Saxe, A.M....

**Exact solutions to the nonlinear dynamics of learning in deep linear neural networks**

2014

Published online December 20, 2013. http://arxiv.org/abs/1312.6120

[Google Scholar](https://scholar.google.com/scholar?q=A.M.SaxeExact+solutions+to+the+nonlinear+dynamics+of+learning+in+deep+linear+neural+networks2014Published+online+December+20%2C+2013.+http%3A%2F%2Farxiv.org%2Fabs%2F1312.6120)

will always depend on the state of knowledge within the network as well as on the compatibility of new inputs with the structured system this knowledge represents.

The analysis described above thus addresses the challenge to CLS theory posed by the findings from the event arena paradigm

7.

Tse, D....

**Schemas and memory consolidation**

*Science.* 2007; **316**:76-82

8.

Tse, D....

**Schema-dependent gene activation and memory encoding in neocortex**

*Science.* 2011; **333**:891-895

([Box 8](#tb0045) discusses other issues related to rapid systems-level consolidation). Taken together, this empirical and theoretical research highlights the need for two amendments to the theory as originally stated

115.

McClelland, J.L.

**Incorporating rapid neocortical learning of new schema-consistent information into complementary learning systems theory**

*J. Exp. Psychol. Gen.* 2013; **142**:1190-1210

. First, consider the core tenet of the theory that the incorporation of novel information into neocortical networks must be slow to avoid catastrophic interference: we now know that this statement only applies when new information is inconsistent with existing knowledge in the neocortex. The second important amendment relates to the original dichotomy between the slow-learning neocortical system and a fast-learning system instantiated in the hippocampus. The empirical data, simulations, and theoretical work summarized above demonstrate that the neocortex does not necessarily learn slowly. More accurately, we now characterize the rate of learning in the neocortex as being dependent on prior knowledge rather than being slow *per se*. Because input to the hippocampus depends on the structured knowledge in the cortex, it follows that hippocampal learning will also be dependent on prior knowledge

116.

McClelland, J.L. ∙ Goddard, N.H.

**Considerations arising from a complementary learning systems perspective on hippocampus and neocortex**

*Hippocampus.* 1996; **6**:654-665

. Future research should explore this issue.

## Links Between CLS Theory and Machine-Learning Research

The core principles of CLS theory have broad relevance not only in understanding the organization of memory in biological systems but also in designing agents with artificial intelligence. We discuss here connections between aspects of CLS theory and recent themes in machine-learning research.

### Deep Neural Networks and the Slow-Learning Neocortical System

Very deep networks

16.

LeCun, Y....

**Deep learning**

*Nature.* 2015; **521**:436-444

, sometimes with more than 10 layers, grew out of earlier computational work

15.

Rumelhart, D.E.

**Brain style computation: learning and generalization**

Zornetzer, S.F.... (Editors)

**An Introduction to Electronic and Neural Networks**

Academic Press, 1990; 405-420

[Google Scholar](https://scholar.google.com/scholar?q=D.E.RumelhartBrain+style+computation%3A+learning+and+generalizationS.F.ZornetzerAn+Introduction+to+Electronic+and+Neural+Networks1990Academic+Press405420)

16.

LeCun, Y....

**Deep learning**

*Nature.* 2015; **521**:436-444

117.

Hinton, G.E....

**Distributed representations**

Rumelhart, D.E.... (Editors)

**Explorations in the Microstructure of Cognition. Vol. 1: Foundations**

MIT Press, 1986; 77-109

[Google Scholar](https://scholar.google.com/scholar?q=G.E.HintonDistributed+representationsD.E.RumelhartExplorations+in+the+Microstructure+of+Cognition.+Vol.+1%3A+Foundations1986MIT+Press77109)

on networks with only a few layers, which were used to model the essential principles of the slow-learning neocortical system within the CLS framework. In general, therefore, deep networks share the characteristics of the slow-learning neocortical system discussed previously: they achieve an optimal parametric characterization of the statistics of the environment by learning gradually through repeated, interleaved exposure to large numbers of training examples.

In recent years, deep networks have achieved state-of-the-art performance in several domains, including image recognition and speech recognition

16.

LeCun, Y....

**Deep learning**

*Nature.* 2015; **521**:436-444

, made possible through increased computing power and algorithmic development. Their power resides in their ability to learn successively more abstract representations from raw sensory data (e.g., the image of an object) – for example oriented edges, edge combinations, and object parts – through composing multiple processing layers that perform non-linear transformations. One class of deep networks, termed convolutional neural networks (CNNs), has been particularly successful in achieving state-of-the-art performance in challenging object-recognition tasks (e.g., ImageNet

118.

Krizhevsky, A....

**Imagenet classification with deep convolutional neural networks**

*Adv. Neural Inf. Process. Syst.* 2012; **25**:1106-1114

[Google Scholar](https://scholar.google.com/scholar?q=A.KrizhevskyImagenet+classification+with+deep+convolutional+neural+networksAdv.+Neural+Inf.+Process.+Syst.25201211061114)

). CNNs are particularly suited to the task of object recognition because their architecture naturally builds in robustness to changes in position through the use of a hierarchy of convolutional filters where units within a feature map at each layer share the same weights, thereby allowing them to detect the same feature at different locations. Interestingly, CNNs have recently also been shown to provide a good model of object recognition in primates at both behavioral and neural levels (e.g., V4, inferotemporal cortex).

### Neural Networks and Replay

For the purposes of machine learning, deep networks are often trained in interleaved fashion because the examples from the entire dataset are available throughout. This is not generally the case, however, in a developmental or online learning context, when intelligent agents need to learn and make decisions while gathering experiences and/or where the data distribution is changing perhaps as the agent's abilities change. Here, recent machine-learning research has drawn inspiration from CLS theory about the role of hippocampal replay. Implementation of an ‘experience replay’ mechanism was crucial to developing the first neural network (Deep Q-Network or DQN) capable of achieving human-level performance across a wide variety of Atari 2600 games by successfully harnessing the power of deep neural networks and reinforcement learning (RL)

119.

Mnih, V....

**Human-level control through deep reinforcement learning**

*Nature.* 2015; **518**:529-533

([Box 9](#tb0050)).

Box 9

Experience Replay in Deep Q-Networks

Instead of employing a standard online learning method in which each unit of play experience (consisting of a state, action, next state and resulting reward) is used immediately to adjust connection weights and then discarded, an experience replay buffer similar to the hippocampus is used. This allows learning based on randomly chosen subsets of recent experiences stored in the replay buffer (

119.

Mnih, V....

**Human-level control through deep reinforcement learning**

*Nature.* 2015; **518**:529-533

for details) to be interleaved with ongoing game-play. The approach is in line with findings cited above

66.

Lansink, C.S....

**Hippocampus leads ventral striatum in replay of place–reward information**

*PLoS Biol.* 2009; **7**:e1000173

that hippocampal replay reactivates reward related neurons in striatum, in accord with the hypothesis that hippocampus-dependent RL facilitates learning during off-line periods.

Experience replay in the DQN architecture was crucial in (i) maximizing data efficiency, allowing each unit of experience to be reused in many updates (e.g., mirroring benefits of repeated time-compressed hippocampal replay) and (ii) smoothing out learning and avoiding unstable response policies that can result from the tendency of the current policy to bias the experienced samples. The approach minimizes learning from consecutive samples, which is undesirable owing to their strongly correlated nature and inconsistent with the implicit assumptions built into neural-network learning algorithms. Instead experience replay allows updates within the deep Q-network to be performed on non-adjacent samples from a set of recent experiences in a fashion that breaks up these correlations while still relying on relevant statistics. The dramatic advantage of a network implementing interleaved learning through experience replay was illustrated by the effects of disabling replay on network performance: this caused a severe drop in performance to at best ∼30% of when experience replay was present

119.

Mnih, V....

**Human-level control through deep reinforcement learning**

*Nature.* 2015; **518**:529-533

. Note that the uniform sampling mechanism as implemented treats all transitions in the replay memory as if they were equal. Recent work

183.

Schaul, T....

**Prioritized experience replay**

*International Conference on Learning Representations.* 2016;, 2016

[Google Scholar](https://scholar.google.com/scholar?q=T.SchaulPrioritized+experience+replayInternational+Conference+on+Learning+Representations2016)

shows that biasing replay towards significant events – specifically, experiences that are associated with high reward prediction errors – yields further gains. This mechanism, which resonates with the role of the hippocampus in reweighting experiences as discussed above, allows information to be harvested from rare experiences that may be particularly informative.

### Continual Learning and the Hippocampus

Continual learning – the name machine-learning researchers use for the ability to learn successive tasks in sequential fashion (e.g., tasks A, B, C) without catastrophic forgetting of earlier tasks (e.g., task A) – remains a fundamental challenge in machine-learning research, and addressing it can be considered a prerequisite to developing artificial agents we would consider truly intelligent. A principal motivation for incorporating a fast-learning hippocampal system as a complement to the slow neocortical system in CLS theory was to support continual learning in the neocortex: hippocampal replay was proposed to mediate interleaved training of the neocortex (i.e., intermixed examples from tasks A, B, C) despite the sequential nature of the real-world experiences. We draw attention here to a second relatively underexplored reason why the hippocampus may facilitate continual learning, particularly over relatively short timescales (i.e., before systems-level consolidation).

As discussed previously, the hippocampus is thought to represent experiences in pattern-separated fashion, whereby in the idealized case even highly similar events are allocated neuronal codes that are non-overlapping or orthogonal (e.g.,

26.

Treves, A. ∙ Rolls, E.T.

**Computational constraints suggest the need for two distinct input systems to the hippocampal CA3 network**

*Hippocampus.* 1992; **2**:189-199

). Notably, the advantages of this coding scheme for episodic memory – reduction of interference between similar but distinct events – may also have significant benefits for continual learning. Specifically, this mechanism allows the rapid creation of distinct non-interfering representations for multiple tasks to which an agent has been exposed in sequential fashion. The utility of this function, and the ubiquity of continual learning, is well established in the domain of spatial navigation, where the notion of a task can be related to that of an environmental context: rodents are able to learn and sustain robust representations of many different environments (e.g., >10 environments in

120.

Alme, C.B....

**Place cells in the hippocampus: eleven maps for eleven rooms**

*Proc. Natl. Acad. Sci. U.S.A.* 2014; **111**:18428-18435

), with each environment being represented by a pattern-separated representational space (putatively implemented as a continuous attractor, called a ‘chart’

121.

Samsonovich, A. ∙ McNaughton, B.L.

**Path integration and cognitive mapping in a continuous attractor neural network model**

*J. Neurosci.* 1997; **17**:5900-5920

[Crossref](https://doi.org/10.1523/JNEUROSCI.17-15-05900.1997)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/9221787/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1523%2FJNEUROSCI.17-15-05900.1997&pmid=9221787)

) within the CA3 subregion of the hippocampus, and within which specific locations are further individuated.

### Neural Networks with External Memory and the Hippocampus

Recent work has suggested that deep networks may be considerably enhanced by the addition of an external memory. For example, an external memory is used in the neural Turing machine (NTM)

125.

Graves, A....

**Neural Turning machines**

2014

Published online October 20, 2014. http://arxiv.org/abs/1410.5401

[Google Scholar](https://scholar.google.com/scholar?q=A.GravesNeural+Turning+machines2014Published+online+October+20%2C+2014.+http%3A%2F%2Farxiv.org%2Fabs%2F1410.5401)

, and this memory has content-addressable properties akin to those of the **attractor networks** used to model pattern completion in the hippocampus ([Box 10](#tb0055)). Such an external memory has been shown to support functionalities such as the learning of new algorithms, for example performing **paired associative recall** ([Box 10](#tb0055)

125.

Graves, A....

**Neural Turning machines**

2014

Published online October 20, 2014. http://arxiv.org/abs/1410.5401

[Google Scholar](https://scholar.google.com/scholar?q=A.GravesNeural+Turning+machines2014Published+online+October+20%2C+2014.+http%3A%2F%2Farxiv.org%2Fabs%2F1410.5401)

) or question-and-answering (Q&A

126.

Sukhbaatar, S....

**End-to-end memory networks**

*NIPS.* 2015; 2431-2439

[Google Scholar](https://scholar.google.com/scholar?q=S.SukhbaatarEnd-to-end+memory+networksNIPS201524312439)

127.

J. Weston, *et al*. *Memory Networks*. Published online October 15, 2014 http://arxiv.org/abs/1410.3916

[Google Scholar](https://scholar.google.com/scholar?q=J.+Weston%2C+et+al.+Memory+Networks.+Published+online+October+15%2C+2014+http%3A%2F%2Farxiv.org%2Fabs%2F1410.3916)

) – a class of machine-learning paradigms where textual outputs are required based on queries (e.g., Q: where is Bill?; A: the bathroom) requiring inference over a knowledge database (e.g., a set of sentences).

![](https://www.cell.com/cms/10.1016/j.tics.2016.05.004/asset/bc65d797-5706-4fb2-af9c-ce9dc7852d3e/main.assets/gr1b10_lrg.jpg)

Box 10 Neural Networks with External Memory and the Hippocampus

It is also worth noting that the neuropsychological testing of story recall can be considered to be a version of the Q&A task used in machine learning (e.g.,

126.

Sukhbaatar, S....

**End-to-end memory networks**

*NIPS.* 2015; 2431-2439

[Google Scholar](https://scholar.google.com/scholar?q=S.SukhbaatarEnd-to-end+memory+networksNIPS201524312439)

). When the amount of story content to be retained exceeds a few sentences, this task is crucially dependent on the memory storage properties of the hippocampus. Indeed, the specific working of the REMERGE model of the hippocampus – **recurrent similarity computation**, such that the output of the episodic system is recirculated as a new input – has parallels in a recent machine-learning algorithm developed for the purpose of Q&A, termed a ‘memory network’

127.

J. Weston, *et al*. *Memory Networks*. Published online October 15, 2014 http://arxiv.org/abs/1410.3916

[Google Scholar](https://scholar.google.com/scholar?q=J.+Weston%2C+et+al.+Memory+Networks.+Published+online+October+15%2C+2014+http%3A%2F%2Farxiv.org%2Fabs%2F1410.3916)

. Specifically, a learned, dense feature-vector representation of an input query (e.g., ‘where is the milk?’) is used to retrieve the sentence with the most similar feature vector in the database (e.g., ‘Joe left the milk’): a combined feature representation of the initial query and retrieved sentence is then used to identify similar sentences earlier in the story (‘Joe traveled to the office’); this process iterates until a response is emitted by the network (‘the office’). The joint dependence of this system on input/output feature representations that are developed gradually through training with a large corpus of text and on individual stored sentences nicely parallels the complementary roles of neocortical and hippocampal representations in CLS theory and REMERGE.

## Concluding Remarks

We have argued that the core features of the memory architecture proposed by CLS theory continue to provide a useful framework for understanding the organization of learning systems in the brain. We have, however, refined and extended the theory in several ways. First, we now encompass a broader and more-significant role for the hippocampus in generalization than previously thought. Second, we have amended the statement that neocortical learning is constrained to be slow *per se* – instead, we now clarify that the rate of neocortical learning is dependent on prior knowledge and can be relatively fast under some conditions. Together, these revisions to the theory imply a softening of the originally strict dichotomy between the characteristics of neocortical (slow learning, parametric, and therefore generalizing) and hippocampal (fast-learning, item-based) systems. In addition, we have extended the proposed functions for the fast-learning hippocampal system, suggesting that this system can circumvent the general statistics of the environment by reweighting experiences that are of significance. Finally, we have highlighted the broad applicability of the principles of CLS theory to developing agents with artificial intelligence, an area which we hope will continue to rise in interest and become a significant direction for future research (see Outstanding Questions).

Outstanding Questions

Under what conditions does the proposed hippocampal reweighting of experiences result in a biased neocortical model of environmental structure?

Are hippocampal representations updated to incorporate changes in neocortical representations (the ‘index maintenance’ problem), and if so how?

What is the fate of hippocampal memory traces after systems-level consolidation is complete?

What are the precise conditions under which rapid systems-level consolidation can occur?

Are hippocampal memory traces susceptible to reconsolidation in a way that mirrors amygdala-dependent memories (e.g., in fear-conditioning paradigms)?

What neocortical mechanisms complement hippocampal replay in facilitating continual learning?

What algorithmic functionalities and implementational schemes are desirable for an external memory module, both for human learners and for artificial agents?

## Acknowledgments

We are very grateful to Adam Cain for help with creating the figures and Greg Wayne and Nikolaus Kriegeskorte for comments on an earlier version of the paper.

## References

[1.](#body-ref-sbref0005-1 "View in article")

McClelland, J.L....

**Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory**

*Psychol. Rev.* 1995; **102**:419-457

[Crossref](https://doi.org/10.1037/0033-295X.102.3.419)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7624455/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.102.3.419&pmid=7624455)

[2.](#body-ref-sbref0015-1 "View in article")

O’Neill, J....

**Play it again: reactivation of waking experience and memory**

*Trends Neurosci.* 2010; **33**:220-229

[3.](#body-ref-sbref0015-1 "View in article")

Wikenheiser, A.M. ∙ Redish, A.D.

**Decoding the cognitive map: ensemble hippocampal sequences and decision making**

*Curr. Opin. Neurobiol.* 2015; **32**:8-15

[4.](#body-ref-sbref0030 "View in article")

Zeithamova, D....

**The hippocampus and inferential reasoning: building memories to navigate future decisions**

*Front. Hum. Neurosci.* 2012; **6**:1-14

[5.](#body-ref-sbref0030 "View in article")

Kumaran, D. ∙ McClelland, J.L.

**Generalization through the recurrent interaction of episodic memories: A model of the hippocampal system**

*Psychol. Rev.* 2012; **119**:573-616

[6.](#body-ref-sbref0030 "View in article")

Eichenbaum, H.

**Hippocampus: cognitive processes and neural representations that underlie declarative memory**

*Neuron.* 2004; **44**:109-120

[7.](#body-ref-sbref0040-1 "View in article")

Tse, D....

**Schemas and memory consolidation**

*Science.* 2007; **316**:76-82

[8.](#body-ref-sbref0040-1 "View in article")

Tse, D....

**Schema-dependent gene activation and memory encoding in neocortex**

*Science.* 2011; **333**:891-895

[9.](#body-ref-sbref0045-1 "View in article")

Marr, D.

**Simple memory: a theory for archicortex**

*Philos. Trans. R. Soc. L. B Biol. Sci.* 1971; **262**:23-81

[Crossref](https://doi.org/10.1098/rstb.1971.0078)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/4399412/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1098%2Frstb.1971.0078&pmid=4399412)

[10.](#body-ref-sbref0050-1 "View in article")

Rumelhart, D.E....

**Learning representations by back-propagating errors**

*Nature.* 1986; **323**:533-536

[Crossref](https://doi.org/10.1038/323533a0)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2F323533a0)

[11.](#body-ref-sbref0065 "View in article")

Sejnowski, T.J. ∙ Rosenberg, C.R.

**Parallel networks that learn to pronounce English text**

*Complex Syst.* 1987; **1**:145-168

[Google Scholar](https://scholar.google.com/scholar?q=T.J.SejnowskiC.R.RosenbergParallel+networks+that+learn+to+pronounce+English+textComplex+Syst.11987145168)

[12.](#body-ref-sbref0065 "View in article")

Guyonneau, R....

**Temporal codes and sparse representations: a key to understanding rapid processing in the visual system**

*J. Physiol. Paris.* 2004; **98**:487-497

[13.](#body-ref-sbref0065 "View in article")

Plaut, D.C....

**Understanding normal and impaired word reading: computational principles in quasi-regular domains**

*Psychol. Rev.* 1996; **103**:56-115

[Crossref](https://doi.org/10.1037/0033-295X.103.1.56)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8650300/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.103.1.56&pmid=8650300)

[14.](#body-ref-sbref0075-1 "View in article")

Rogers, T.T. ∙ McClelland, J.L.

**Semantic Cognition: A Parallel Distributed Processing Approach**

MIT Press, 2004

[Crossref](https://doi.org/10.7551/mitpress/6161.001.0001)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.7551%2Fmitpress%2F6161.001.0001)

[15.](#body-ref-sbref0075-1 "View in article")

Rumelhart, D.E.

**Brain style computation: learning and generalization**

Zornetzer, S.F.... (Editors)

**An Introduction to Electronic and Neural Networks**

Academic Press, 1990; 405-420

[Google Scholar](https://scholar.google.com/scholar?q=D.E.RumelhartBrain+style+computation%3A+learning+and+generalizationS.F.ZornetzerAn+Introduction+to+Electronic+and+Neural+Networks1990Academic+Press405420)

[18.](#body-ref-sbref0090-1 "View in article")

Yamins, D.L. ∙ DiCarlo, J.J.

**Using goal-driven deep learning models to understand sensory cortex**

*Nat. Neurosci.* 2016; **19**:356-365

[19.](#body-ref-sbref0100-1 "View in article")

Saxe, A.M....

**Learning hierarchical categories in deep neural networks**

**Proceedings of the 35th Annual Conference of the Cognitive Science Society**

2015; 1271-1276

[Google Scholar](https://scholar.google.com/scholar?q=A.M.SaxeLearning+hierarchical+categories+in+deep+neural+networksProceedings+of+the+35th+Annual+Conference+of+the+Cognitive+Science+SocietyCognitive+Science+Society201512711276)

[20.](#body-ref-sbref0100-1 "View in article")

Saxe, A.M....

**Exact solutions to the nonlinear dynamics of learning in deep linear neural networks**

2014

Published online December 20, 2013. http://arxiv.org/abs/1312.6120

[Google Scholar](https://scholar.google.com/scholar?q=A.M.SaxeExact+solutions+to+the+nonlinear+dynamics+of+learning+in+deep+linear+neural+networks2014Published+online+December+20%2C+2013.+http%3A%2F%2Farxiv.org%2Fabs%2F1312.6120)

[21.](#body-ref-sbref0115-1 "View in article")

McCloskey, M. ∙ Cohen, N.J.

**Catastrophic forgetting in connectionist networks: the problem of sequential learning**

Bower, G.H. (Editor)

**The Psychology of Learning and Motivation (Vol. 20)**

Academic Press, 1989; 109-165

[Google Scholar](https://scholar.google.com/scholar?q=M.McCloskeyN.J.CohenCatastrophic+forgetting+in+connectionist+networks%3A+the+problem+of+sequential+learningG.H.BowerThe+Psychology+of+Learning+and+Motivation+%28Vol.+20%291989Academic+Press109165)

[22.](#body-ref-sbref0115-1 "View in article")

Ratcliff, R.

**Connectionist models of recognition memory: constraints imposed by learning and forgetting functions**

*Psychol. Rev.* 1990; **97**:285-308

[Crossref](https://doi.org/10.1037/0033-295X.97.2.285)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/2186426/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.97.2.285&pmid=2186426)

[23.](#body-ref-sbref0115-1 "View in article")

French, R.M.

**Catastrophic forgetting in connectionist networks**

*Trends Cogn. Sci.* 1999; **3**:128-135

[24.](#body-ref-sbref0120 "View in article")

Carpenter, G.A. ∙ Grossberg, S.

**A massively parallel architecture for a self-organizing neural pattern recognition architecture**

*Comput. Vision, Graph. Image Process.* 1987; **37**:54-115

[Crossref](https://doi.org/10.1016/S0734-189X\(87\)80014-2)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1016%2FS0734-189X%2887%2980014-2)

[25.](#body-ref-sbref0135-1 "View in article")

McNaughton, B.L. ∙ Morris, R.G.

**Hippocampal synaptic enhancement and information storage within a distributed memory system**

*Trends Neurosci.* 1987; **10**:408-415

[26.](#body-ref-sbref0135-1 "View in article")

Treves, A. ∙ Rolls, E.T.

**Computational constraints suggest the need for two distinct input systems to the hippocampal CA3 network**

*Hippocampus.* 1992; **2**:189-199

[27.](#body-ref-sbref0135-1 "View in article")

O’Reilly, R.C. ∙ McClelland, J.L.

**Hippocampal conjunctive encoding, storage, and recall: avoiding a trade-off**

*Hippocampus.* 1994; **4**:661-682

[28.](#body-ref-sbref0180 "View in article")

Knierim, J.J....

**Hippocampal place cells: parallel input streams, subregional processing, and implications for episodic memory**

*Hippocampus.* 2006; **16**:755-764

[29.](#body-ref-sbref0170-1 "View in article")

Cohen, N.J. ∙ Eichenbaum, H.B.

**Memory, Amnesia and the Hippocampal System**

MIT Press, 1994

[Google Scholar](https://scholar.google.com/scholar?q=N.J.CohenH.B.EichenbaumMemory%2C+Amnesia+and+the+Hippocampal+System1994MIT+Press)

[30.](#body-ref-sbref0180 "View in article")

O’Reilly, R.C. ∙ Rudy, J.W.

**Conjunctive representations in learning and memory: principles of cortical and hippocampal function**

*Psychol. Rev.* 2001; **108**:311-345

[Crossref](https://doi.org/10.1037/0033-295X.108.2.311)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/11381832/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.108.2.311&pmid=11381832)

[31.](#body-ref-sbref0180 "View in article")

Norman, K.A. ∙ O’Reilly, R.C.

**Modeling hippocampal and neocortical contributions to recognition memory: a complementary-learning-systems approach**

*Psychol. Rev.* 2003; **110**:611-646

[32.](#body-ref-sbref0180 "View in article")

Mayes, A....

**Associative memory and the medial temporal lobes**

*Trends Cogn. Sci.* 2007; **11**:126-135

[33.](#body-ref-sbref0180 "View in article")

Davachi, L.

**Item, context and relational episodic encoding in humans**

*Curr. Opin. Neurobiol.* 2006; **16**:693-700

[34.](#body-ref-sbref0170-1 "View in article")

Squire, L.R....

**The medial temporal lobe**

*Annu. Rev. Neurosci.* 2004; **27**:279-306

[35.](#body-ref-sbref0180 "View in article")

Schiller, D....

**Memory and space: towards an inderstanding of the cognitive map**

*J. Neurosci.* 2015; **35**:13904-13911

[36.](#body-ref-sbref0180 "View in article")

O’Reilly, R.C....

**Complementary learning systems**

*Cogn. Sci.* 2014; **38**:1229-1248

[37.](#body-ref-sbref0185-1 "View in article")

Knierim, J.J. ∙ Neunuebel, J.P.

**Tracking the flow of hippocampal computation: pattern separation, pattern completion, and attractor dynamics**

*Neurobiol. Learn. Mem.* 2016; **129**:38-49

[38.](#body-ref-sbref0190 "View in article")

Johnston, S.T....

**Paradox of pattern separation and adult neurogenesis: a dual role for new neurons balancing memory resolution and robustness**

*Neurobiol. Learn. Mem.* 2016; **129**:60-68

[39.](#body-ref-sbref0230-1 "View in article")

Bengio, Y....

**Representation learning: a review and new perspectives**

*IEEE Trans. Pattern Anal. Mach. Intell.* 2013; **35**:1798-1828

[40.](#body-ref-sbref0230-1 "View in article")

Khaligh-Razavi, S.M. ∙ Kriegeskorte, N.

**Deep supervised, but not unsupervised, models may explain IT cortical representation**

*PLoS Comput. Biol.* 2014; **10**:e1003915

[41.](#body-ref-sbref0230-1 "View in article")

Kriegeskorte, N....

**Matching categorical object representations in inferior temporal cortex of man and monkey**

*Neuron.* 2008; **60**:1126-1141

[42.](#body-ref-sbref0230-1 "View in article")

Clarke, A. ∙ Tyler, L.K.

**Object-specific semantic coding in human perirhinal cortex**

*J. Neurosci.* 2014; **34**:4766-4775

[43.](#body-ref-sbref0230-1 "View in article")

Kiani, R....

**Object category structure in response patterns of neuronal population in monkey inferior temporal cortex**

*J. Neurophysiol.* 2007; **97**:4296-4309

[44.](#body-ref-sbref0230-1 "View in article")

McNaughton, B.L.

**Cortical hierarchies, sleep, and the extraction of knowledge from memory**

*Artficial Intell.* 2010; **174**:205-2014

[45.](#body-ref-sbref0230-1 "View in article")

Leibold, C. ∙ Kempter, R.

**Sparseness constrains the prolongation of memory lifetime via synaptic metaplasticity**

*Cereb. Cortex.* 2008; **18**:67-77

[46.](#body-ref-sbref0230-1 "View in article")

Rolls, E.T....

**The representational capacity of the distributed encoding of information provided by populations of neurons in primate temporal visual cortex**

*Exp. Brain Res.* 1997; **114**:149-162

[47.](#body-ref-sbref0235-1 "View in article")

Barnes, C.A....

**Comparison of spatial and temporal characteristics of neuronal activity in sequential stages of hippocampal processing**

*Prog. Brain Res.* 1990; **83**:287-300

[Crossref](https://doi.org/10.1016/S0079-6123\(08\)61257-1)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/2392566/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1016%2FS0079-6123%2808%2961257-1&pmid=2392566)

[48.](#body-ref-sbref0240-1 "View in article")

McKenzie, S....

**Representation of memories in the cortical–hippocampal system: results from the application of population similarity analyses**

*Neurobiol. Learn. Mem.* 2015;

Published online December 31, 2015

[49.](#body-ref-sbref0245 "View in article")

Cutting, J.

**A cognitive approach to Korsakoff's syndrome**

*Cortex.* 1978; **14**:485-495

[Crossref](https://doi.org/10.1016/S0010-9452\(78\)80024-0)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/738059/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1016%2FS0010-9452%2878%2980024-0&pmid=738059)

[50.](#body-ref-sbref0250 "View in article")

McClelland, J.L.

**Memory as a constructive process: the parallel-distributed processing apporach**

Nalbantian, P.... (Editors)

**The Memory Process: Neuroscientific and Humanist Perspectives**

MIT Press, 2011; 99-129

[Google Scholar](https://scholar.google.com/scholar?q=J.L.McClellandMemory+as+a+constructive+process%3A+the+parallel-distributed+processing+apporachP.NalbantianThe+Memory+Process%3A+Neuroscientific+and+Humanist+Perspectives2011MIT+Press99129)

[51.](#body-ref-sbref0640 "View in article")

Frankland, P.W. ∙ Bontempi, B.

**The organization of recent and remote memories**

*Nat. Rev. Neurosci.* 2005; **6**:119-130

[52.](#body-ref-sbref0645 "View in article")

Winocur, G....

**Memory formation and long-term retention in humans and animals: convergence towards a transformation account of hippocampal–neocortical interactions**

*Neuropsychologia.* 2010; **48**:2339-2356

[53.](#body-ref-sbref0265-1 "View in article")

Squire, L.R....

**The medial temporal region and memory consolidation: a new hypothesis**

Weingartner, H. ∙ Parker, E.S. (Editors)

**Memory Consolidation: Psychobiology of Cognition**

Psychology Press, 1984; 185-210

[Google Scholar](https://scholar.google.com/scholar?q=L.R.SquireThe+medial+temporal+region+and+memory+consolidation%3A+a+new+hypothesisH.WeingartnerE.S.ParkerMemory+Consolidation%3A+Psychobiology+of+Cognition1984Psychology+Press185210)

[54.](#body-ref-sbref0280 "View in article")

Robins, A.

**Consolidation in neural networks and in the sleeping brain**

*Conn. Sci.* 1996; **8**:259-276

[55.](#body-ref-sbref0280 "View in article")

Tononi, G. ∙ Cirelli, C.

**Sleep and the price of plasticity: from synaptic and cellular homeostasis to memory consolidation and integration**

*Neuron.* 2014; **81**:12-34

[56.](#body-ref-sbref0280 "View in article")

Norman, K.A....

**Methods for reducing interference in the complementary learning systems model: oscillating inhibition and autonomous memory rehearsal**

*Neural Netw.* 2005; **18**:1212-1228

[57.](#body-ref-sbref0295-1 "View in article")

Skaggs, W.E. ∙ McNaughton, B.L.

**Replay of neuronal firing sequences in rat hippocampus during sleep following spatial experience**

*Science.* 1996; **271**:1870-1873

[58.](#body-ref-sbref0295-1 "View in article")

Wilson, M.A. ∙ McNaughton, B.L.

**Reactivation of hippocampal ensemble memories during sleep**

*Science.* 1994; **265**:676-679

[Crossref](https://doi.org/10.1126/science.8036517)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8036517/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1126%2Fscience.8036517&pmid=8036517)

[59.](#body-ref-sbref0295-1 "View in article")

Carr, M.F....

**Hippocampal replay in the awake state: a potential substrate for memory consolidation and retrieval**

*Nat. Neurosci.* 2011; **14**:147-153

[60.](#body-ref-sbref0305-2 "View in article")

Buzsaki, G.

**Two-stage model of memory trace formation: a role for ‘noisy’ brain states**

*Neuroscience.* 1989; **31**:551-570

[61.](#body-ref-sbref0305-1 "View in article")

Kali, S. ∙ Dayan, P.

**Off-line replay maintains declarative memories in a model of hippocampal-neocortical interactions**

*Nat. Neurosci.* 2004; **7**:286-294

[62.](#body-ref-sbref0315 "View in article")

Sirota, A....

**Communication between neocortex and hippocampus during sleep in rodents**

*Proc. Natl. Acad. Sci. U.S.A.* 2003; **100**:2065-2069

[63.](#body-ref-sbref0315 "View in article")

Battaglia, F.P....

**Hippocampal sharp wave bursts coincide with neocortical ‘up-state’ transitions**

*Learn. Mem.* 2004; **11**:697-704

[64.](#body-ref-sbref0320 "View in article")

Ólafsdóttir, H....

**Coordinated grid and place cell replay during rest**

*Nat. Neurosci.* 2016;

Published online April 18, 2016

[65.](#body-ref-sbref0325-1 "View in article")

Ji, D. ∙ Wilson, M.A.

**Coordinated memory replay in the visual cortex and hippocampus during sleep**

*Nat. Neurosci.* 2007; **10**:100-107

[66.](#body-ref-sbref0330-1 "View in article")

Lansink, C.S....

**Hippocampus leads ventral striatum in replay of place–reward information**

*PLoS Biol.* 2009; **7**:e1000173

[67.](#body-ref-sbref0345-2 "View in article")

Ego-Stengel, V. ∙ Wilson, M.A.

**Disruption of ripple-associated hippocampal activity during rest impairs spatial learning in the rat**

*Hippocampus.* 2010; **20**:1-10

[68.](#body-ref-sbref0345-2 "View in article")

Girardeau, G....

**Selective suppression of hippocampal ripples impairs spatial memory**

*Nat. Neurosci.* 2009; **12**:1222-1223

[69.](#body-ref-sbref0345-1 "View in article")

Nakashiba, T....

**Hippocampal CA3 output is crucial for ripple-associated reactivation and consolidation of memory**

*Neuron.* 2009; **62**:781-787

[70.](#body-ref-sbref0355 "View in article")

Johnson, A. ∙ Redish, A.D.

**Neural ensembles in CA3 transiently encode paths forward of the animal at a decision point**

*J. Neurosci.* 2007; **27**:12176-12189

[71.](#body-ref-sbref0355 "View in article")

Wikenheiser, A.M. ∙ Redish, A.D.

**Hippocampal theta sequences reflect current goals**

*Nat. Neurosci.* 2015; **18**:289-294

[72.](#body-ref-sbref0365-1 "View in article")

Wu, X. ∙ Foster, D.J.

**Hippocampal replay captures the unique topological structure of a novel environment**

*J. Neurosci.* 2014; **34**:6459-6469

[73.](#body-ref-sbref0365-1 "View in article")

Gupta, A.S....

**Hippocampal replay is not a simple function of experience**

*Neuron.* 2010; **65**:695-705

[74.](#body-ref-sbref0370 "View in article")

Pfeiffer, B.E. ∙ Foster, D.J.

**Hippocampal place-cell sequences depict future paths to remembered goals**

*Nature.* 2013; **497**:74-79

[76.](#body-ref-sbref0380-1 "View in article")

Bendor, D. ∙ Wilson, M.A.

**Biasing the content of hippocampal replay during sleep**

*Nat. Neurosci.* 2012; **15**:1439-1444

[77.](#body-ref-sbref0385 "View in article")

Schacter, D.L. ∙ Addis, D.R.

**The cognitive neuroscience of constructive memory: remembering the past and imagining the future**

*Philos. Trans. R. Soc. B Biol. Sci.* 2007; **362**:773-786

[78.](#body-ref-sbref0395 "View in article")

Hassabis, D. ∙ Maguire, E.A.

**Deconstructing episodic memory with construction**

*Trends Cogn. Sci.* 2007; **11**:299-306

[79.](#body-ref-sbref0395 "View in article")

Hassabis, D....

**Patients with hippocampal amnesia cannot imagine new experiences**

*Proc. Natl. Acad. Sci. U.S.A.* 2007; **104**:1726-1731

[80.](#body-ref-sbref0400 "View in article")

Lengyel, M. ∙ Dayan, P.

**Hippocampal contributions to control: the third way**

*Neural Inf. Process. Syst.* 2007;

[Google Scholar](https://scholar.google.com/scholar?q=M.LengyelP.DayanHippocampal+contributions+to+control%3A+the+third+wayNeural+Inf.+Process.+Syst.2007)

[81.](#body-ref-sbref0405 "View in article")

Anderson, J.R. ∙ Milson, R.

**Human memory: an adaptive perspective**

*Psychol. Rev.* 1989; **96**:703

[Crossref](https://doi.org/10.1037/0033-295X.96.4.703)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.96.4.703)

[82.](#body-ref-sbref0415-1 "View in article")

Lisman, J.E. ∙ Grace, A.A.

**The hippocampal–VTA loop: controlling the entry of information into long-term memory**

*Neuron.* 2005; **46**:703-713

[83.](#body-ref-sbref0415-1 "View in article")

Lisman, J....

**A neoHebbian framework for episodic memory; role of dopamine-dependent late LTP**

*Trends Neurosci.* 2011; **34**:536-547

[84.](#body-ref-sbref0420-1 "View in article")

van Strien, N.M....

**The anatomy of memory: an interactive overview of the parahippocampal-hippocampal network**

*Nat. Rev. Neurosci.* 2009; **10**:272-282

[85.](#body-ref-sbref0755 "View in article")

Hasselmo, M.E.

**Neuromodulation: acetylcholine and memory consolidation**

*Trends Cogn. Sci.* 1999; **3**:351-359

[86.](#body-ref-sbref0440 "View in article")

McNamara, C.G....

**Dopaminergic neurons promote hippocampal reactivation and spatial memory persistence**

*Nat. Neurosci.* 2014; **17**:1658-1660

[87.](#body-ref-sbref0440 "View in article")

Sara, S.J.

**The locus coeruleus and noradrenergic modulation of cognition**

*Nat. Rev. Neurosci.* 2009; **10**:211-223

[88.](#body-ref-sbref0440 "View in article")

McGaugh, J.L.

**The amybdala modulates the consolidation of memories of emotionally arousing experiences**

*Annu. Rev. Neurosci.* 2004; **27**:1-28

[89.](#body-ref-sbref0445-1 "View in article")

Redondo, R.L. ∙ Morris, R.G.

**Making memories last: the synaptic tagging and capture hypothesis**

*Nat. Rev. Neurosci.* 2011; **12**:17-30

[90.](#body-ref-sbref0475-1 "View in article")

Kumaran, D.

**What representations and computations underpin the contribution of the hippocampus to generalization and inference?**

*Front. Hum. Neurosci.* 2012; **6**:157

[91.](#body-ref-sbref0475-1 "View in article")

Bunsey, M. ∙ Eichenbaum, H.

**Conservation of hippocampal memory function in rats and humans**

*Nature.* 1996; **379**:255-257

[92.](#body-ref-sbref0475-1 "View in article")

Zeithamova, D. ∙ Preston, A.R.

**Flexible memories: differential roles for medial temporal lobe and prefrontal cortex in cross-episode binding**

*J. Neurosci.* 2010; **30**:14676-14684

[93.](#body-ref-sbref0475-1 "View in article")

Preston, A.R....

**Hippocampal contribution to the novel use of relational information in declarative memory**

*Hippocampus.* 2004; **14**:148-152

[94.](#body-ref-sbref0475-1 "View in article")

Dusek, J.A. ∙ Eichenbaum, H.

**The hippocampus and memory for orderly stimulus relations**

*Proc. Natl. Acad. Sci. U.S.A.* 1997; **94**:7109-7114

[95.](#body-ref-sbref0475-1 "View in article")

Shohamy, D. ∙ Wagner, A.D.

**Integrating memories in the human brain: hippocampal-midbrain encoding of overlapping events**

*Neuron.* 2008; **60**:378-389

[96.](#body-ref-sbref0490-2 "View in article")

Zeithamova, D....

**Hippocampal and ventral medial prefrontal activation during retrieval-mediated learning supports novel inference**

*Neuron.* 2012; **75**:168-179

[97.](#body-ref-sbref0490-2 "View in article")

Milivojevic, B....

**Insight reconfigures hippocampal-prefrontal memories**

*Curr. Biol.* 2015; **25**:821-830

[99.](#body-ref-sbref0500 "View in article")

Eichenbaum, H....

**The hippocampus, memory, and place cells: is it spatial memory or a memory space?**

*Neuron.* 1999; **23**:209-226

[101.](#body-ref-sbref0505 "View in article")

Kloosterman, F....

**Two reentrant pathways in the hippocampal–entorhinal system**

*Hippocampus.* 2004; **14**:1026-1039

[103.](#body-ref-sbref0520 "View in article")

Burgess, N.

**Computational models of the spatial and mnemonic functions of the hippocampus**

Andersen, P.... (Editors)

**The Hippocampus**

Oxford University Press, 2006; 715-750

[Google Scholar](https://scholar.google.com/scholar?q=N.BurgessComputational+models+of+the+spatial+and+mnemonic+functions+of+the+hippocampusP.AndersenThe+Hippocampus2006Oxford+University+Press715750)

[104.](#body-ref-sbref0520 "View in article")

Willshaw, D.J....

**Memory, modelling and Marr: a commentary on Marr (1971) ‘Simple memory: a theory of archicortex’**

*Philos. Trans. R. Soc. B Biol. Sci.* 2015; **370**:20140383

[105.](#body-ref-sbref0535 "View in article")

Schapiro, A.C....

**The necessity of the medial temporal lobe for statistical learning**

*J. Cogn. Neurosci.* 2014; **26**:1736-1747

[106.](#body-ref-sbref0535 "View in article")

Knowlton, B.J. ∙ Squire, L.R.

**The learning of categories: parallel brain systems for item memory and category knowledge**

*Science.* 1993; **262**:1747-1749

[Crossref](https://doi.org/10.1126/science.8259522)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8259522/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1126%2Fscience.8259522&pmid=8259522)

[107.](#body-ref-sbref0535 "View in article")

Shohamy, D. ∙ Turk-Browne, N.B.

**Mechanisms for widespread hippocampal involvement in cognition**

*J. Exp. Psychol. Gen.* 2013; **142**:1159-1170

[108.](#body-ref-sbref0825-1 "View in article")

Nosofsky, R.M.

**Choice, similarity, and the context theory of classification**

*J. Exp. Psychol. Learn. Mem. Cogn.* 1984; **10**:104-114

[109.](#body-ref-sbref0545-1 "View in article")

Tamminen, J....

**From specific examples to general knowledge in language learning**

*Cogn. Psychol.* 2015; **79**:1-39

[110.](#body-ref-sbref0550 "View in article")

Walker, M.P. ∙ Stickgold, R.

**Overnight alchemy: sleep-dependent memory evolution**

*Nat. Rev. Neurosci.* 2010; **11**:218

[111.](#body-ref-sbref0555 "View in article")

Wood, E.R....

**The global record of memory in hippocampal neuronal activity**

*Nature.* 1999; **397**:613-616

[Crossref](https://doi.org/10.1038/16564)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/10050854/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2F16564&pmid=10050854)

[112.](#body-ref-sbref0560 "View in article")

Eichenbaum, H.

**Time cells in the hippocampus: a new dimension for mapping memories**

*Nat. Rev. Neurosci.* 2014; **15**:732-744

[114.](#body-ref-sbref0570 "View in article")

Quiroga, R.Q....

**Invariant visual representation by single neurons in the human brain**

*Nature.* 2005; **435**:1102-1107

[115.](#body-ref-sbref0575-1 "View in article")

McClelland, J.L.

**Incorporating rapid neocortical learning of new schema-consistent information into complementary learning systems theory**

*J. Exp. Psychol. Gen.* 2013; **142**:1190-1210

[116.](#body-ref-sbref0705-1 "View in article")

McClelland, J.L. ∙ Goddard, N.H.

**Considerations arising from a complementary learning systems perspective on hippocampus and neocortex**

*Hippocampus.* 1996; **6**:654-665

[117.](#body-ref-sbref0585 "View in article")

Hinton, G.E....

**Distributed representations**

Rumelhart, D.E.... (Editors)

**Explorations in the Microstructure of Cognition. Vol. 1: Foundations**

MIT Press, 1986; 77-109

[Google Scholar](https://scholar.google.com/scholar?q=G.E.HintonDistributed+representationsD.E.RumelhartExplorations+in+the+Microstructure+of+Cognition.+Vol.+1%3A+Foundations1986MIT+Press77109)

[118.](#body-ref-sbref0590 "View in article")

Krizhevsky, A....

**Imagenet classification with deep convolutional neural networks**

*Adv. Neural Inf. Process. Syst.* 2012; **25**:1106-1114

[Google Scholar](https://scholar.google.com/scholar?q=A.KrizhevskyImagenet+classification+with+deep+convolutional+neural+networksAdv.+Neural+Inf.+Process.+Syst.25201211061114)

[119.](#body-ref-sbref0595-1 "View in article")

Mnih, V....

**Human-level control through deep reinforcement learning**

*Nature.* 2015; **518**:529-533

[120.](#body-ref-sbref0600 "View in article")

Alme, C.B....

**Place cells in the hippocampus: eleven maps for eleven rooms**

*Proc. Natl. Acad. Sci. U.S.A.* 2014; **111**:18428-18435

[121.](#body-ref-sbref0605-1 "View in article")

Samsonovich, A. ∙ McNaughton, B.L.

**Path integration and cognitive mapping in a continuous attractor neural network model**

*J. Neurosci.* 1997; **17**:5900-5920

[Crossref](https://doi.org/10.1523/JNEUROSCI.17-15-05900.1997)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/9221787/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1523%2FJNEUROSCI.17-15-05900.1997&pmid=9221787)

[123.](#body-ref-sbref0620-2 "View in article")

Renno-Costa, C....

**A signature of attractor dynamics in the CA3 region of the hippocampus**

*PLoS Comput. Biol.* 2014; **10**:e1003641

[124.](#body-ref-sbref0720 "View in article")

Wills, T.J....

**Attractor dynamics in the hippocampal representation of the local environment**

*Science.* 2005; **308**:873-876

[125.](#body-ref-sbref0625-1 "View in article")

Graves, A....

**Neural Turning machines**

2014

Published online October 20, 2014. http://arxiv.org/abs/1410.5401

[Google Scholar](https://scholar.google.com/scholar?q=A.GravesNeural+Turning+machines2014Published+online+October+20%2C+2014.+http%3A%2F%2Farxiv.org%2Fabs%2F1410.5401)

[126.](#body-ref-oref0635-1 "View in article")

Sukhbaatar, S....

**End-to-end memory networks**

*NIPS.* 2015; 2431-2439

[Google Scholar](https://scholar.google.com/scholar?q=S.SukhbaatarEnd-to-end+memory+networksNIPS201524312439)

[127.](#body-ref-oref0635-1 "View in article")

J. Weston, *et al*. *Memory Networks*. Published online October 15, 2014 http://arxiv.org/abs/1410.3916

[Google Scholar](https://scholar.google.com/scholar?q=J.+Weston%2C+et+al.+Memory+Networks.+Published+online+October+15%2C+2014+http%3A%2F%2Farxiv.org%2Fabs%2F1410.3916)

[128.](#body-ref-sbref0640 "View in article")

Scoville, W.B. ∙ Milner, B.

**Loss of recent memory after bilateral hippocampal lesions**

*J. Neurol. Neurosurg. Psychiatry.* 1957; **20**:11-12

[Crossref](https://doi.org/10.1136/jnnp.20.1.11)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/13406589/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1136%2Fjnnp.20.1.11&pmid=13406589)

[129.](#body-ref-sbref0645 "View in article")

Nadel, L. ∙ Moscovitch, M.

**Memory consolidation, retrograde amnesia and the hippocampal complex**

*Curr. Opin. Neurobiol.* 1997; **7**:217-227

[130.](#body-ref-sbref0650 "View in article")

Moscovitch, M....

**Functional neuroanatomy of remote episodic, semantic and spatial memory: a unified account based on multiple trace theory**

*J. Anat.* 2005; **207**:35-66

[131.](#body-ref-sbref0685-1 "View in article")

Yassa, M.A. ∙ Stark, C.E.

**Pattern separation in the hippocampus**

*Trends Neurosci.* 2011; **34**:515-525

[132.](#body-ref-sbref0685-1 "View in article")

Liu, X....

**Optogenetic stimulation of a hippocampal engram activates fear memory recall**

*Nature.* 2012; **484**:381-385

[133.](#body-ref-sbref0685-1 "View in article")

Leutgeb, J.K....

**Pattern separation in the dentate gyrus and CA3 of the hippocampus**

*Science.* 2007; **315**:961-966

[134.](#body-ref-sbref0685-1 "View in article")

Leutgeb, S....

**Distinct ensemble codes in hippocampal areas CA3 and CA1**

*Science.* 2004; **305**:1295-1298

[135.](#body-ref-sbref0685-1 "View in article")

Bonnici, H.M....

**Decoding representations of scenes in the medial temporal lobes**

*Hippocampus.* 2011; **22**:1143-1153

[136.](#body-ref-sbref0685-1 "View in article")

McHugh, T.J....

**Dentate gyrus NMDA receptors mediate rapid pattern separation in the hippocampal network**

*Science.* 2007; **317**:94-99

[137.](#body-ref-sbref0685-1 "View in article")

Neunuebel, J.P. ∙ Knierim, J.J.

**CA3 retrieves coherent representations from degraded input: direct evidence for CA3 pattern completion and dentate gyrus pattern separation**

*Neuron.* 2014; **81**:416-427

[138.](#body-ref-sbref0695 "View in article")

Nakazawa, K....

**Requirement for hippocampal CA3 NMDA receptors in associative memory recall**

*Science.* 2002; **297**:211-218

[139.](#body-ref-sbref0695 "View in article")

Jezek, K....

**Theta-paced flickering between place-cell maps in the hippocampus**

*Nature.* 2011; **478**:246-249

[140.](#body-ref-sbref0700 "View in article")

Richards, B.A....

**Patterns across multiple memories are identified over time**

*Nat. Neurosci.* 2014; **17**:981-986

[141.](#body-ref-sbref0705-1 "View in article")

Ketz, N....

**Theta coordinated error-driven learning in the hippocampus**

*PLoS Comput. Biol.* 2013; **9**:e1003067

[Crossref](https://doi.org/10.1371/journal.pcbi.1003067)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/23762019/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1371%2Fjournal.pcbi.1003067&pmid=23762019)

[142.](#body-ref-sbref0710 "View in article")

Kumaran, D. ∙ Maguire, E.A.

**Novelty signals: a window into hippocampal information processing**

*Trends Cogn. Sci.* 2009; **13**:47-54

[143.](#body-ref-sbref0715 "View in article")

Moser, E.I. ∙ Moser, M.B.

**One-shot memory in hippocampal CA3 networks**

*Neuron.* 2003; **38**:147-148

[144.](#body-ref-sbref0720 "View in article")

Chaudhuri, R. ∙ Fiete, I.

**Computational principles of memory**

*Nat. Neurosci.* 2016; **19**:394-403

[Crossref](https://doi.org/10.1038/nn.4237)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/26906506/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2Fnn.4237&pmid=26906506)

[145.](#body-ref-sbref0730 "View in article")

Lee, H....

**Neural population evidence of functional heterogeneity along the CA3 transverse axis: pattern completion versus pattern separation**

*Neuron.* 2015; **87**:1093-1105

[146.](#body-ref-sbref0730 "View in article")

Lu, L....

**Topography of place maps along the CA3-to-CA2 axis of the hippocampus**

*Neuron.* 2015; **87**:1078-1092

[147.](#body-ref-sbref0750 "View in article")

Collin, S.H....

**Memory hierarchies map onto the hippocampal long axis in humans**

*Nat. Neurosci.* 2015; **18**:1562-1564

[Crossref](https://doi.org/10.1038/nn.4138)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/26479587/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1038%2Fnn.4138&pmid=26479587)

[148.](#body-ref-sbref0750 "View in article")

Poppenk, J....

**Long-axis specialization of the human hippocampus**

*Trends Cogn. Sci.* 2013; **17**:230-240

[149.](#body-ref-sbref0750 "View in article")

Strange, B.A....

**Functional organization of the hippocampal longitudinal axis**

*Nat. Rev. Neurosci.* 2014; **15**:655-669

[150.](#body-ref-sbref0750 "View in article")

Ranganath, C. ∙ Ritchey, M.

**Two cortical systems for memory-guided behaviour**

*Nat. Rev. Neurosci.* 2012; **13**:713-726

[151.](#body-ref-sbref0755 "View in article")

Hasselmo, M.E. ∙ Schnell, E.

**Laminar selectivity of the cholinergic suppression of synaptic transmission in rat hippocampal region CA1: computational modeling and brain slice physiology**

*J. Neurosci.* 1994; **14**:3898-3914

[Crossref](https://doi.org/10.1523/JNEUROSCI.14-06-03898.1994)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8207494/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1523%2FJNEUROSCI.14-06-03898.1994&pmid=8207494)

[153.](#body-ref-sbref0770 "View in article")

Olshausen, B.A. ∙ Field, D.J.

**Sparse coding of sensory inputs**

*Curr. Opin. Neurobiol.* 2004; **14**:481-487

[154.](#body-ref-sbref0770 "View in article")

Quiroga, R.Q....

**Sparse but not ‘grandmother-cell’ coding in the medial temporal lobe**

*Trends Cogn. Sci.* 2008; **12**:87-91

[155.](#body-ref-sbref0775 "View in article")

Ahmed, O.J. ∙ Mehta, M.R.

**The hippocampal rate code: anatomy, physiology and theory**

*Trends Neurosci.* 2009; **32**:329-338

[157.](#body-ref-sbref0785 "View in article")

Vinje, W.E. ∙ Gallant, J.L.

**Sparse coding and decorrelation in primary visual cortex during natural vision**

*Science.* 2000; **287**:1273-1276

[158.](#body-ref-sbref0790 "View in article")

Quirk, G.J....

**The positional firing properties of medial entorhinal neurons: description and comparison with hippocampal place cells**

*J. Neurosci.* 1992; **12**:1945-1963

[Crossref](https://doi.org/10.1523/JNEUROSCI.12-05-01945.1992)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/1578279/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1523%2FJNEUROSCI.12-05-01945.1992&pmid=1578279)

[159.](#body-ref-sbref0795 "View in article")

Rust, N.C. ∙ DiCarlo, J.J.

**Balanced increases in selectivity and tolerance produce constant sparseness along the ventral visual stream**

*J. Neurosci.* 2012; **32**:10170-10182

[160.](#body-ref-sbref0805 "View in article")

Barlow, H.B.

**Single units and sensation: a neuron doctrine for perceptual psychology?**

*Perception.* 1972; **1**:371-394

[Crossref](https://doi.org/10.1068/p010371)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/4377168/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1068%2Fp010371&pmid=4377168)

[161.](#body-ref-sbref0805 "View in article")

Grossberg, S.

**Competitive learning: from interactive activation to adaptive resonance**

*Cogn. Sci.* 1987; **11**:23-63

[Crossref](https://doi.org/10.1111/j.1551-6708.1987.tb00862.x)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1111%2Fj.1551-6708.1987.tb00862.x)

[162.](#body-ref-sbref0810 "View in article")

LaRocque, K.F....

**Global similarity and pattern separation in the human medial temporal lobe predict subsequent memory**

*J. Neurosci.* 2013; **33**:5466-5474

[163.](#body-ref-sbref0815 "View in article")

McClelland, J.L. ∙ Rumelhart, D.E.

**An interactive activation model of context effects in letter perception. Part 1. An account of the basic findings**

*Psychol. Rev.* 1981; **88**:375-407

[164.](#body-ref-sbref0825-1 "View in article")

Medin, D.L. ∙ Schaffer, M.M.

**Context theory of classification**

*Psychol. Rev.* 1978; **85**:207-238

[165.](#body-ref-sbref0825-1 "View in article")

Hintzman, D.L.

**‘Schema abstraction’ in a multiple-trace memory model**

*Psychol. Rev.* 1986; **93**:411-428

[167.](#body-ref-sbref0895-1 "View in article")

Wood, E.R....

**Hippocampal neurons encode information about different types of memory episodes occurring in the same location**

*Neuron.* 2000; **27**:623-633

[168.](#body-ref-sbref0895-1 "View in article")

Ferbinteanu, J. ∙ Shapiro, M.L.

**Prospective and retrospective memory coding in the hippocampus**

*Neuron.* 2003; **40**:1227-1239

[169.](#body-ref-sbref0895-1 "View in article")

Bower, M.R....

**Sequential-context-dependent hippocampal activity is not necessary to learn sequences with repeated elements**

*J. Neurosci.* 2005; **25**:1313-1323

[170.](#body-ref-sbref0895-1 "View in article")

MacDonald, C.J....

**Distinct hippocampal time cell sequences represent odor memories in immobilized rats**

*J. Neurosci.* 2013; **33**:14607-14616

[171.](#body-ref-sbref0895-1 "View in article")

Markus, E.J....

**Interactions between location and task affect the spatial and directional firing of hippocampal neurons**

*J. Neurosci.* 1995; **15**:7079-7094

[Crossref](https://doi.org/10.1523/JNEUROSCI.15-11-07079.1995)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/7472463/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1523%2FJNEUROSCI.15-11-07079.1995&pmid=7472463)

[172.](#body-ref-sbref0895-1 "View in article")

Skaggs, W.E. ∙ McNaughton, B.L.

**Spatial firing properties of hippocampal CA1 populations in an environment containing two visually identical regions**

*J. Neurosci.* 1998; **18**:8455-8466

[Crossref](https://doi.org/10.1523/JNEUROSCI.18-20-08455.1998)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/9763488/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1523%2FJNEUROSCI.18-20-08455.1998&pmid=9763488)

[173.](#body-ref-sbref0895-1 "View in article")

Kriegeskorte, N....

**Representational similarity analysis – connecting the branches of systems neuroscience**

*Front. Syst. Neurosci.* 2008; **2**:4

[Crossref](https://doi.org/10.3389/neuro.01.016.2008)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/19104670/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.3389%2Fneuro.01.016.2008&pmid=19104670)

[174.](#body-ref-sbref0895-1 "View in article")

Komorowski, R.W....

**Robust conjunctive item-place coding by hippocampal neurons parallels learning what happens where**

*J. Neurosci.* 2009; **29**:9918-9929

[175.](#body-ref-sbref0895-1 "View in article")

Ellenbogen, J.M....

**Human relational memory requires time and sleep**

*Proc. Natl. Acad. Sci. U.S.A.* 2007; **104**:7723-7728

[176.](#body-ref-sbref0895-1 "View in article")

Dumay, N. ∙ Gaskell, M.G.

**Sleep-associated changes in the mental representation of spoken words**

*Psychol. Sci.* 2007; **18**:35-39

[177.](#body-ref-sbref0895-1 "View in article")

Coutanche, M.N. ∙ Thompson-Schill, S.L.

**Fast mapping rapidly integrates information into existing memory networks**

*J Exp Psychol Gen.* 2014; **143**:2296-2303

[178.](#body-ref-sbref0895-1 "View in article")

Sharon, T....

**Rapid neocortical acquisition of long-term arbitrary associations independent of the hippocampus**

*Proc. Natl. Acad. Sci. U.S.A.* 2011; **108**:1146-1151

[179.](#body-ref-sbref0895-1 "View in article")

Merhav, M....

**Neocortical catastrophic interference in healthy and amnesic adults: a paradoxical matter of time**

*Hippocampus.* 2014; **24**:1653-1662

[180.](#body-ref-sbref0910 "View in article")

Smith, C.N....

**Comparison of explicit and incidental learning strategies in memory-impaired patients**

*Proc. Natl. Acad. Sci. U.S.A.* 2014; **111**:475-479

[181.](#body-ref-sbref0910 "View in article")

Warren, D.E. ∙ Duff, M.C.

**Not so fast: hippocampal amnesia slows word learning despite successful fast mapping**

*Hippocampus.* 2014; **24**:920-933

[182.](#body-ref-sbref0910 "View in article")

Greve, A....

**No evidence that ‘fast-mapping’ benefits novel learning in healthy older adults**

*Neuropsychologia.* 2014; **60**:52-59

[183.](#body-ref-sbref0915 "View in article")

Schaul, T....

**Prioritized experience replay**

*International Conference on Learning Representations.* 2016;, 2016

[Google Scholar](https://scholar.google.com/scholar?q=T.SchaulPrioritized+experience+replayInternational+Conference+on+Learning+Representations2016)

[184.](#body-ref-sbref0920 "View in article")

Gallistel, C.R.

**The Organization of Learning**

MIT Press, 1990

[Google Scholar](https://scholar.google.com/scholar?q=C.R.GallistelThe+Organization+of+Learning1990MIT+Press)

[185.](#body-ref-sbref0925 "View in article")

Hochreiter, S. ∙ Schmidhuber, J.

**Long short-term memory**

*Neural Comput.* 1997; **9**:1735-1780

[Crossref](https://doi.org/10.1162/neco.1997.9.8.1735)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/9377276/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1162%2Fneco.1997.9.8.1735&pmid=9377276)

[186.](#body-ref-sbref0930 "View in article")

Santoro, A....

**Meta-Learning with memory augmented neural networks**

*International Conference in Machine Learning.* 2016;, 2016

[Google Scholar](https://scholar.google.com/scholar?q=A.SantoroMeta-Learning+with+memory+augmented+neural+networksInternational+Conference+in+Machine+Learning2016)

[187.](#body-ref-sbref0935 "View in article")

Treves, A. ∙ Rolls, E.T.

**Computational analysis of the role of the hippocampus in memory**

*Hippocampus.* 1994; **4**:374-391

## Glossary

Attractor network

networks with recurrent connectivity that have stable states which persist in the absence of external inputs, and afford noise tolerance. Discrete/point attractor networks can be used to store multiple memories as individual stable states. Continuous attractor networks have a continuous manifold of stable points which allow them to represent continuous variables (e.g., position in space).

Auto-associative storage

the storage within an attractor network of an input pattern constituting an experience, such that elements of the input pattern are linked together through plasticity within the recurrent connections of the network. The operation of recurrent connections supports functions such as pattern completion, whereby the entire input pattern (e.g., memory of a birthday party) can be retrieved from a partial cue (e.g., the face of a friend).

Exemplar models

exemplar models in cognitive science, related to instance-based models in machine learning, operate by computing the similarity of a new input pattern (i.e., presented as external sensory input) to stored experiences. This results in the output of the model, for example a predicted category label for the new input pattern, at which point the process terminates.

Non-parametric

we use this term to refer to algorithms where each experience or datapoint has its own set of coordinates, where capacity can be increased as required – and the number of parameters may grow with the amount of data. K-nearest neighbor constitutes one common example of such a non-parametric instance-based method.

Parametric

we use this term to refer to algorithms that do not store each datapoint, but instead directly learn a function that (for example) predicts the output value for a given input. The number of parameters is typically fixed.

Paired associative inference (PAI) task

a paradigm in which items are organized into (e.g., a hundred) sets of triplets (e.g., ABC) or larger sets (e.g., sextets: ABCDEF). Participants view item pairs (e.g., AB, BC) during the study phase and are tested on their ability to appreciate the indirect relationships between items that were never presented together (e.g., A and C).

Paired associative recall task

a paradigm where item pairs are experienced during study (e.g., word pairs such as ‘dog–table’ in a human experiment, or flavor–location pairs in a rodent experiment), and at test the individual must recall the other item (e.g., specific location) from a cue (the specific flavor, e.g., banana).

Recurrent similarity computation

recurrent similarity computation allows the procedure performed by exemplar models to iterate: that is, the retrieved products from the first step of similarity computation are combined with the external sensory input, and a subsequent round of similarity computation is performed. This process continues until a stable state (i.e., basin of attraction in a neural network) is reached. This allows the model to capture higher-order similarities present in a set of related experiences, where pairwise similarities alone are not informative.

Sharp-wave ripple (SWR)

spontaneous neural activity occurring within the hippocampus during periods of rest and slow wave sleep, evident as negative potentials (i.e., sharp waves). Transient high-frequency (∼150Hz) oscillations (i.e., ripples) occur within these sharp waves, which can reflect the replay (i.e., reactivation) of activity patterns that occurred during actual experience, sped up by an order of magnitude.

Sparsity

the proportion of neurons in a given brain region that are active in response to a given stimulus (‘population sparseness’). Sparse coding, where a small (e.g., 1%) proportion of neurons is active, is contrasted with densely distributed coding where a relatively large proportion of neurons are active (e.g., 20%).