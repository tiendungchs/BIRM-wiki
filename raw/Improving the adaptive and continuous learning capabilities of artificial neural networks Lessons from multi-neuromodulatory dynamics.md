---
title: "Improving the adaptive and continuous learning capabilities of artificial neural networks: Lessons from multi-neuromodulatory dynamics"
source: "https://arxiv.org/html/2501.06762v3"
author:
published:
created: 2026-06-19
description:
tags:
  - "clippings"
---
jie.mei@it-u.at srikanth.ramaswamy@newcastle.ac.uk \[1\]These authors contributed equally to this work \[3\]Senior authors

Jie Mei IT:U Interdisciplinary Transformation University Austria, Linz, Austria International Research Center for Neurointelligence, The University of Tokyo, Tokyo, Japan Department of Anatomy, University of Quebec in Trois-Rivieres, Trois-Rivieres, QC, Canada Alejandro Rodriguez-Garcia Neural Circuits Laboratory, Biosciences Institute, Faculty of Medical Sciences, Newcastle University, Newcastle upon Tyne, United Kingdom Daigo Takeuchi Graduate School of Medicine, The University of Tokyo, Tokyo, Japan Gabriel Wainstein Brain and Mind Centre, The University of Sydney, Sydney, NSW, Australia Helsinki Institute of Life Science (HILIFE), University of Helsinki, Helsinki, Finland Nina Hubig IT:U Interdisciplinary Transformation University Austria, Linz, Austria Department of Neuroscience, Medical University of South Carolina (MUSC), Charleston, SC, USA Yalda Mohsenzadeh Department of Computer Science, Western University, London, Ontario, Canada Vector Institute for Artificial Intelligence, Toronto, Ontario, Canada Srikanth Ramaswamy Neural Circuits Laboratory, Biosciences Institute, Faculty of Medical Sciences, Newcastle University, Newcastle upon Tyne, United Kingdom Theoretical Sciences Visiting Program (TSVP), Okinawa Institute of Science and Technology Graduate University, Okinawa, Japan

###### Abstract

Continuous, adaptive learning, the ability to adapt to the environment and keep improving performance, is a hallmark of natural intelligence. Biological organisms excel in acquiring, transferring, and retaining knowledge while adapting to volatile environments, making them a source of inspiration for artificial neural networks (ANNs). This study explores how neuromodulation, a building block of learning in biological systems, can help address catastrophic forgetting and enhance the robustness of ANNs in continual learning. Driven by neuromodulators including dopamine (DA), acetylcholine (ACh), serotonin (5-HT) and noradrenaline (NA), neuromodulatory processes in the brain operate at multiple scales, facilitating dynamic responses to environmental changes through mechanisms ranging from local synaptic plasticity to global network-wide adaptability. Importantly, the relationship between neuromodulators and their interplay in modulating sensory and cognitive processes is more complex than previously expected, demonstrating a “many-to-one” neuromodulator-to-task mapping. To inspire neuromodulation-aware learning rules, we highlight (i) how multi-neuromodulatory interactions enrich single-neuromodulator-driven learning, (ii) the impact of neuromodulators across multiple spatio-temporal scales, and correspondingly, (iii) strategies for approximating and integrating neuromodulated learning processes in ANNs. To illustrate these principles, we present a conceptual study to showcase how neuromodulation-inspired mechanisms, such as DA-driven reward processing and NA-based cognitive flexibility, can enhance ANN performance in a Go/No-Go task. Though multi-scale neuromodulation, we aim to bridge the gap between biological and artificial learning, paving the way for ANNs with greater flexibility, robustness, and adaptability.

## 1 Introduction

Learning is the dynamic process by which a system reconfigures itself to improve its performance on a task through experience [^124] [^140] [^278]. In real-world scenarios, the environment is often not stationary, which presents unique challenges in maintaining good performance over time [^97] [^190]. Through evolution, biological organisms have developed the ability to learn a spectrum of tasks over their lifetime with minimal interference. The ability to integrate new knowledge without forgetting acquired representations, and make use of representations shared across tasks, has enabled them to optimize survival [^42] [^74] [^103] [^218] [^278]. In recent years, such abilities have been increasingly investigated, and are often considered as a pillar of continual, lifelong learning [^42] [^97] [^140] [^278].

Despite their success, state-of-the-art artificial neural networks (ANNs) struggle with continual learning [^140]. In particular, they suffer from catastrophic forgetting when trained sequentially on multiple tasks [^172] [^88], rely heavily on large labeled datasets, and exhibit limited generalization to out-of-distribution inputs [^295]. In this article, we explore continual learning in its broader conceptualization, recognizing it as an essential component for intelligence in artificial systems [^42]. We then illustrate how neuromodulatory mechanisms can support continual learning and contribute to various relevant learning paradigms, and offer insights into how computations inspired by neuromodulators including dopamine (DA), serotonin (5-HT), acetylcholine (ACh) and noradrenaline (NA) can be integrated into ANN architectures across multiple spatio-temporal scales, leading to more adaptive and resilient artificial systems.

## 2 Continual learning in natural and artificial intelligence

### 2.1 Challenges in the development of lifelong learning systems

ANNs are typically trained under supervised or self-supervised paradigms on fixed datasets, and their performance is therefore determined by the training distribution [^203] [^295]. These models often generalize poorly to out-of-distribution (OOD) inputs and struggle when novel samples or task statistics are present [^54] [^278]. Achieving high performance often requires large numbers of training examples, implying substantial data storage and computational demands [^140] [^236]. Taken together, these trends reflect an evaluation regime in which AI systems are primarily assessed on their ability to perform inference on static benchmarks, while adaptation, knowledge integration, and learning under distributional shift remain largely outside of the metrics considered.

For this reason, current ANN learning mechanisms based on gradient-based optimization are highly effective in static settings but lead to catastrophic forgetting when tasks are learned sequentially, as parameter updates overwrite representations that were critical for previously learned tasks [^172] [^88]. Importantly, catastrophic forgetting does not arise from limited memory capacity, but from the absence of mechanisms that protect or selectively regulate synaptic plasticity [^88] [^140]. Furthermore, many proposed methods to address this limitation rely on replay-based strategies [^222], gradient regularization [^133] [^297] [^7], or architectural modularization [^196] [^225], often requiring an oracle signal to indicate task boundaries. This dependence limits their applicability in online, task-agnostic settings characteristic of realistic environments.

This contrast highlights emerging desiderata for artificial systems operating in open-ended settings, where continual knowledge acquisition, integration with prior experience, and adaptive behavior over time are core objectives [^97] [^140] [^278]. This has renewed interest in neuroscience, where brain-inspired mechanisms that dynamically regulate learning offer promising routes toward continual adaptation with reduced interference.

### 2.2 Continuous, adaptive learning in the biological brain

The brain adapts itself to changes in the environment, task demands and the state of the organism. To learn in a noisy and ever-changing environment, a series of actions are carried out, with varying cognitive demands [^190] including: (1) acquiring and tracking the knowledge acquired in a completed task, (2) recognizing a new task, (3) evaluating task statistics and similarities between tasks, (4) encoding, reusing and exploiting acquired knowledge, (5) updating and transmitting task-specific variables, and (6) updating internal states during and after learning [^97] [^140]. Through the ability to recognize and exploit shared task structures, the brain can achieve rapid and efficient learning in several trials, a phenomenon commonly depicted in the framework of few-shot learning [^140] [^278]. In other tasks, task shifts do not always occur in a sequence. Accordingly, an organism learns multiple tasks simultaneously, which requires not only storaging and retrieving past tasks, but also distinguishing concurrent tasks. In the brain, a continuous learning process is supported by a collective of computations:

Given the brain’s ability to learn continuously, catastrophic forgetting, also referred to as catastrophic interference, which takes the form of full erasure of learned representations upon acquisition of new information, is rarely reported in the study of human cognition [^79]. Rather, phenomena that are to some extent comparable to catastrophic forgetting, e.g., interference in declarative memory due to overlapping information, have been observed in individuals with amnesia [^176]. Such interference has also been observed in motor learning, where loss of previously acquired motor skills occurs when new skills are learned. When new locomotor tasks are present (e.g., learning a new sport similar to a learned sport but with different rules), there can be interference with existing motor memories, leading to negative transfer of learned motor skills [^238]. Reduced motor learning and transfer abilities have been shown in brain pathologies: For example, although cerebellar damage does not affect online motor adjustments, it compromises adaptive performance in motor learning processes [^186] [^247]. Furthermore, neurodegenerative disorders such as Parkinson’s or Huntington’s disease can cause decrease in performance in kinematic adaptation tasks [^143].

In general, it is difficult to pinpoint cognitive processes that are comparable in nature and functionally analogous to catastrophic forgetting. Nevertheless, studies have focused on identifying the neural correlates of learning and memory, providing a substantial body of evidence on how the nervous system supports learning in a sustained manner [^94].

## 3 The neuromodulatory systems

The brain’s neuromodulatory systems play a crucial role in the regulation of neural activity and behavior through the release of chemical substances known as neuromodulators [^174]. Unlike classical neurotransmitters, which act on synapses to enable point-to-point transmission of signals between closely adjacent neurons, neuromodulators also diffuse widely and exert more long-lasting, circuit-level effects, modulating the excitability and plasticity of a group of neurons and consequently contributing to the state and function of the brain [^164]. This is achieved through mechanisms including adjustment of synaptic strength, modulation of receptor activity, and even alterations in gene expression [^164] [^174]. As a result, neuromodulators do not simply mediate transient communications between neurons, but set the stage for more sustained changes. This capacity to fine-tune brain functions across spatio-temporal resolutions makes them essential for cognitive flexibility and resilience [^244].

### 3.1 Key properties

Neuromodulatory processes can affect neuronal excitability, synaptic plasticity, network dynamics, and ultimately, behavior [^164] [^263] [^189]. They occur across timescales and are responsible for processes ranging from changes in neuronal morphology to alterations in network properties. Thus, the neuromodulatory systems play a key role in brain activity, implicating various cognitive functions, behavior, and emotional states [^48] [^263] [^94].

Neurons that produce and release neuromodulators are often clustered in small and well-defined regions of the brain, such as the raphe nuclei (5-HT), the locus coeruleus (NA), the nucleus basalis of Meynert in the basal forebrain (ACh), the substantia nigra (DA) and the tuberomammillary bodies (HA) [^174]. Despite their rather compact origins, these neurons project throughout the brain, pervasively innervating the cortex, thalamus, hippocampus and a multitude of other areas involved in sensory processing, memory and executive functions. The release of neuromodulators helps tune the gain, timing and synchrony of neural circuits, enhancing or dampening the effects of synaptic transmission according to the organism’s physiological state, as well as environmental and behavioral contexts [^164] [^263] [^189].

The neuromodulatory systems regulate neuronal excitability and synaptic plasticity through complex molecular pathways. For example, the LC releases NA that interacts with various G protein-coupled receptors (GPCRs) such as subtypes $\alpha 1$, $\alpha 2$, and $\beta$ [^22] [^171], which then activate intracellular signaling cascades. $\alpha 1$ receptors coupled with Gq proteins activate phospholipase C, leading to calcium release and protein kinase C (PKC) activation, while $\alpha 2$ receptors linked to Gi proteins inhibit adenylyl cyclase, reducing cyclic AMP (cAMP) levels and protein kinase A (PKA) activity. $\beta$ receptors primarily coupled with Gs proteins, stimulate adenylyl cyclase, increasing cAMP and activating PKA. Neuromodulators dynamically adjust neuronal excitability and synaptic plasticity through these diverse pathways, enabling adaptive responses to environmental stimuli.

Understanding how these chemicals together shape neural activity and behavior remains a challenge, requiring data integration across modalities and scales [^218]. Advances in neurotechnology and computational modeling now allow researchers to dissect complex neuromodulatory interactions in unprecedented detail, paving the way for a deeper understanding of how they contribute to the learning capacities of the brain.

![Refer to caption](https://arxiv.org/html/2501.06762v3/figures/fig1.png)

Figure 1: The role of neuromodulators in species of increasing cognitive complexity. Although neuromodulatory systems are broadly conserved across species, they exhibit a progressive departure from stereotyped functions as neural and cognitive complexity increases. From nematodes to humans, neuromodulators support a finer functional specification going from basic sensorimotor and homeostatic processes to higher-order functions such as motivation, attention, memory, affect regulation, and adaptive decision making, which in complex brains give rise to social cognition, abstract reasoning, and creative abilities. This expansion illustrates how a shared neuromodulatory basis may enable more advanced and complex behavior across increasing nervous system complexity.

### 3.2 Neuromodulatory systems across species

Given the similar neuromodulatory nuclei and architectures across diverse taxa, neuromodulatory systems are considered to be highly conserved in species spanning from simple invertebrate like C. elegans to birds, reptiles and humans,underscoring their fundamental role in cognition (Figure 1). Studying neuromodulatory functions across species provides insights into their evolutionary origins and adaptive significance. Although the complexity of the nervous system vary, the fundamental roles of neuromodulators in perception, cognition and learning highlight their conservation and adaptive value across evolutionary timescales. This comparative approach not only deepens our understanding of fundamental organizational principles of the brain, but also informs research on neurological disorders and the development of targeted therapies.

Throughout evolution, the brain has developed complex and specialized brain regions such as the neocortex, which is responsible for high-order cognitive functions [^98] [^33] [^32]. Neuromodulatory nuclei in the brainstem, midbrain, and forebrain form the foundational architecture of the mammalian brain, coordinating broad behavioral and cognitive states through extensive projections [^192] [^243] [^244]. The persistence of neuromodulatory systems underscores their importance in regulating behavior and maintaining neurophysiological balance (Figure 1). They enable dynamic adjustments in neural excitability, synaptic plasticity, and network dynamics, which are essential for cognitive flexibility and behavioral adaptability [^218]. This adaptability allows organisms to thrive in volatile environments.

### 3.3 Neuromodulation in continual learning settings

Although the connections between experimental and theoretical accounts are still being established, neuromodulatory mechanisms, which impose distinct constraints on how information is acquired, retained, and reused over time, align naturally with the goals of continual learning. Table 1 conceptually links continual learning paradigms with relevant experimental frameworks in neuroscience and psychology (see also [^13] [^66] [^150] [^184]).

| Paradigm | Objectives | Relevant experimental designs |
| --- | --- | --- |
| Transfer learning | Efficient adaptation to new domains | Transfer of learning [^102] [^288]   Mapping of knowledge [^85]   Schema learning [^268]   Structure learning [^262] |
| Meta-learning | Efficient adaptation to new tasks and contexts | Learning-to-learn [^101]   Meta-cognitive learning [^109] |
| Multi-task learning | Promoting learning by using shared patterns across tasks and domains | Dual-task paradigm [^197]   Task switching [^224] [^258] |
| Incremental learning | Assimilating new information and efficiently updating models while avoiding catastrophic forgetting | Retroactive interference [^9]   Task switching [^224] [^258]   Set-shifting [^63] [^135] [^216] |
| Online learning | Efficiently updating models upon real-time data collection | Reversal learning [^287]   Delayed alternation [^180]   Extinction learning [^204]   Set-shifting [^63] [^135] [^216] |

Table 1: A summary of continual learning paradigms, their key objectives, and the corresponding experimental paradigms and designs in neuroscience and psychology.

The brain is confronted with unique optimization needs and computational demands in each setting. How it enables such an extraordinary feat by orchestrating multiple neuromodulators that act on distinct aspects of learning, and how each neuromodulator functions in each setting, have been addressed by numerous computational and experimental studies.

Dopaminergic (DA) signaling has widely been associated with the reward prediction error signaling [^234]. Nevertheless, accumulating evidence suggests a broader role in novelty, uncertainty, movement-related variables, as well as the processing of aversive stimuli and threat, revealing DA’s involvement in learning and behavioral adaptation [^3] [^13] [^69] [^86] [^132] [^152] [^170] [^175]. Therefore, DA may bias plasticity towards task-relevant representation, supporting memory encoding, and contributing to flexible adaptation in transfer, incremental, and online learning settings [^19] [^191] [^149] [^108].

Beyond vigilance, attention, learning, and memory [^10] [^228], noradrenaline (NA) is relevant to adaptive gain control, network reset, and decision-making under uncertainty [^11] [^27] [^293]. These functional roles of NA are linked to the objectives of continual learning paradigms, particularly in transfer, incremental, and online settings, where agents must prioritize task-relevant information and adapt to and encode environmental changes. NA also facilitates multi-task learning, set-shifting, and task-switching by modulating attention and exploratory behavior [^240] [^262]. Modeling work on the locus coeruleus (LC) suggests that phasic LC activity promotes focused attention, while tonic activity supports behavioral flexibility and exploration [^12]. Recent circuit-level studies using optogenetics and GRAB sensors have begun to examine how LC projections to the frontal cortex regulate attention and behavioral switching [^15] [^254]. It is probable that circuits in PFC, ACC, and the striatum differentially and cooperatively process NA signals in continual learning [^104], but the precise mechanisms remain an open question.

Serotonergic (5-HT) signaling has been linked to behavioral inhibition and cognitive flexibility [^44], with computational accounts further relating it to the regulation of temporal discounting and the balance between immediate and delayed rewards [^61] [^67] [^66]. In continual learning, this can be interpreted as modulating the effective weight assigned to prior knowledge during incremental updates. Moreover, given the role of 5-HT in mood regulation and stress responses [^49] [^61], serotonergic dynamics may contribute to managing conflicting task demands and stabilizing task-related parameters in multi-task scenarios.

The cholinergic (ACh) system plays a central role in memory encoding, working memory, and attention modulation, partly through its influence on inhibitory interneurons and oscillatory circuit dynamics [^107] [^106]. Such mechanisms support the cross-task integration and stabilization of new information, making ACh particularly relevant for incremental and online learning, where selective pathway modulation may help mitigate interference between competing representations. ACh also facilitates cognitive flexibility under uncertainty by regulating attention and working memory, enabling the prioritization of task-relevant inputs while suppressing distractions in multi-task settings [^195] [^230]. In combination with NA, ACh signaling has been proposed to modulate attention allocation during inference in uncertain environments [^293].

The functionality of neuromodulatory systems offers insight for the design of novel ANNs [^174] [^103] [^140], improving learning efficiency through task-appropriate prioritization and and context-aware adjustment of attention [^242]. Integrating neuromodulatory elements may also enhance resilience to disturbances and noise, ensuring stable and robust task performance [^244] [^218].

## 4 Going beyond single neuromodulators: The multi-neuromodulatory dynamics

The anatomical signatures of neuromodulator-releasing neurons – extensive arborization, high density of release sites, and long-range and widespread projections [^64] [^65] [^169] [^205] – have supported the view of neuromodulation as a spatially diffuse and globally coordinated process associated with brain states [^12] [^11] [^168]. In parallel, theoretical studies have largely focused on simplified formalizations, and often favor a framework where single neuromodulators are connected to specific cognitive processes (e.g., NA with arousal, DA with reward, 5-HT with cost assessment, and ACh with attention), overlooking the effects of their interactions.

### 4.1 Mechanisms underlying multi-neuromodulatory interactions

Increasing evidence suggests that neuromodulation is neither homogeneous nor isolated. In opto- and chemo-genetic studies, one neuromodulator affect the release and transmission of the other through intricate interconnections [^30]. Consequently, multiple neuromodulators can influence a single cognitive task – spanning from primitive to higher-order functions – as neuromodulatory receptors participate in processes ranging from sensory perception to complex social and emotional behaviors [^81] [^100]. Neuromodulatory signaling operates across timescales, continually coordinating the segregation and integration of transient sensorimotor events with longer-term task-level goals [^92] [^243].

![Refer to caption](https://arxiv.org/html/2501.06762v3/figures/fig4.png)

Figure 2: The complex relationship between neuromodulators. Modulatory ( ∙ ⁣ − \\bullet- ): One neuromodulator modulates the release, transmission and/or functional output of the other neuromodulator. Convergent (gradient color bar): Neuromodulators exhibit overlapping, yet sometimes distinctive effects on sensory and cognitive processes. Opponent ( → ← \\rightarrow\\leftarrow ): Neuromodulators exert opposing effects, or one suppresses the activity of the other. DA: dopamine; 5-HT: serotonin; ACh: acetylcholine; NA: noradrenaline.

The effects of neuromodulation are target-specific: ACh projections from the basal forebrain (BF) differentially shape emotional learning (BF to amygdala), spatial memory (BF to dorsal hippocampus), and cue encoding (BF to medial PFC) depending on their projection sites [^155] [^294]. Complementing this region-level specificity, within-region heterogeneity further refines neuromodulatory control in a local range. In the striatum, non-uniform distributions of DA and ACh delineate striosome and matrix compartments with distinct connectivity, neurochemical profiles, and learning-related computations [^31] [^91] [^227]. These projection-specific mechanisms and within-area heterogeneity collectively demonstrate how neuromodulators can support modular, parallelized processing across areas, while allowing spatially localized processes to exert finer, more transient adjustments.

Neuromodulatory systems have overlapping innervations and their receptors can co-express in the same groups of neurons [^94], enabling spatially structured interactions. Recent research highlights the pervasiveness of parallel operations by neuromodulatory systems across spatio-temporal scales [^246] [^290], revealing neuromodulatory interplay at the levels of transmitter dynamics, connectivity properties, and modes of transmission.

- Transmitter dynamics. Dale’s principle [^57], later formalized by Eccles as the ‘one neuron, one transmitter’ hypothesis which suggests neurons consistently excite or inhibit [^68]. Contrary to Dale’s principle, neurons can release two or more neurotransmitters [^267] [^273]. Regions that are traditionally considered the source of one particular neuromodulator can release other neuromodulators, e.g., DA release into the dorsal hippocampus by neurons in the LC [^129]. The co-release of neuromodulators and neurotransmitters increase the complexity of neuromodulatory functions: In the retina, the spatially non-uniform co-transmission of ACh and gamma-aminobutyric acid (GABA) in starburst amacrine cells allows encoding of direction selectivity in downstream retinal ganglion cells [^151]. Such non-uniform co-release is also observed in single neurons, contributing to their context-dependent activities and making them more expressive.
- Connectivity properties. Properties of neural connectivity, i.e., connectivity density, directionality and weighting, may enable cue-dependent switching between multiple perceptual or behavioral strategies. [^188] showed that NA and ACh projections contact the same layer V pyramidal neurons through diffuse (NA $\rightarrow$ layer V) and targeted (ACh $\rightarrow$ layer V) innervation patterns, supporting flexibility and reliability respectively. Such concurrent yet differential effects suggest dual-mode information processing within individual neurons and microcircuits. Some areas, such as the striatum, host multiple neuromodulatory systems, allowing the co-modulation of DA, ACh and histamine [^53]. Through spatial adjacency as such, neuromodulators not only affect the rate of release of one another to stabilize their concentrations in the extracellular space, but fulfill context-appropriate actions. One example is the co-existence of ACh and DA waves in the dorsal striatum, and that their phase relationship is modulated by the presence of rewards [^99] [^168]. These interactions give rise to task- and cue-specific modulation, enhancing the representation of behaviorally relevant information.
	Beyond region-level coordination, even a single ACh interneuron can locally regulate striatal DA release, complementing evidence of DA dynamics driven by synchronized ACh activity [^168]. Such interactions can drive fine-tuning and become functionally critical in tasks requiring continuous updates of action-outcome mappings. Disruption of the DA-ACh balance alters the integration of past actions and rewards, leading to inefficient decision switching [^40].
- Modes of transmission. The two primary modes of neuromodulatory transmission are wiring (synaptic) transmission and volumetric transmission [^2] [^47] [^193]. Wiring transmission relies on direct synaptic contacts, enabling spatially precise, energetically efficient, and transient one-to-one signaling. In contrast, volume transmission involves diffusion through the extracellular space, supporting broader one-to-many signaling that is more sustained and less spatially specific. The two modes serve distinct and complementary roles in cognition and learning. In the ACh system, synaptic transmission mediates precise local modulation, whereas volume transmission conveys sustained, diffuse signals that coordinate broader behavioral states [^47].

### 4.2 Multi-neuromodulator dynamics across spatio-temporal scales

#### 4.2.1 Subcellular dynamics

In the nervous system, rapid information transmission is facilitated mainly by ionotropic receptors, which are activated by neurotransmitters such as glutamate [^241] and GABA [^250], as well as neuromodulators including 5-HT [^16] [^264] and ACh [^5]. These processes drive immediate changes in ion flux through channel opening, influencing short-term synaptic plasticity [^111].

Metabotropic receptors, which are targeted by most neuromodulators including muscarinic ACh receptors [^107], the majority of 5-HT receptors [^16], and all receptors for DA [^181], HA [^95], and NA [^12], trigger a cascade of second messengers, initiating intracellular biochemical processes [^62] [^105]. These relatively slow-acting processes modulate spiking behaviors and enhance long-term synaptic plasticity [^105] [^137].

The coexistence of ionotropic and metabotropic synaptic transmission expands the dimension of the space of neural parameters [^105], enhancing the adaptability of neural networks. The presence of both receptor types in the neuronal membrane allows neural networks to operate across multiple timescales, facilitating continuous learning and ensuring flexibility and resilience in biological systems.

#### 4.2.2 Neuronal dynamics

Neurons present specialized input structures called dendrites, which are organized into complex structures known as dendritic trees [^29] [^41] [^252]. Affected by ionic mechanisms that depolarize their membranes, these branched structures propagate diverse non-linear input signals known as dendritic spikes (dSpikes), which attenuate as they travel along the dendrite [^1] [^194].

Biological neural networks exhibit dendritic-spike-dependent plasticity rules that are governed by the timing of synaptic inputs in relation to postsynaptic dendritic spikes rather than axonal action potentials [^122]. These synapses demonstrate scaling as a form of homeostatic plasticity, regulating excitation levels and maintaining the signal-to-noise ratio [^207] [^271]. Neuromodulators influence dendritic trees by altering their biophysical characteristics in several ways: (i) enhancing and altering ionotropic glutamate or GABA receptors, leading to changes in excitatory postsynaptic potentials (EPSPs) and inhibitory postsynaptic potentials (IPSPs), (ii) releasing Ca2+ to modify the resting potential, and (iii) modifying voltage-gated channels, influencing threshold and refractory period adjustments [^242].

#### 4.2.3 Circuit-level dynamics

##### Decision-making

Neuromodulators contribute to decision-making through neural circuits that span the cerebellum, basal ganglia, prefrontal and limbic cortices [^48] [^66] [^90] [^94] [^159] [^229] [^234]. DA helps reinforce behavior based on reward prediction errors (RPEs) [^234], and plays a role in recalibrating the value of actions over time, allowing the brain to adapt to new information [^35] [^83] [^235]. Midbrain DA neurons project to the striatum and prefrontal cortex and modulate synaptic plasticity in these areas, strengthening connections that predict rewarding outcomes and facilitating learning from experiences [^66] [^92] [^112] [^159] [^280]. Glutamate, the primary excitatory neurotransmitter in the brain, is instrumental in synaptic plasticity and in the formation of neural circuits underlying learning and decision-making. Studies have shown that glutamatergic signaling in the striatum interacts with DA and ACh, and together affect reward-based learning and decision-making [^40] [^138]. Overall, DA not only reinforces actions based on expected rewards, but contributes to the brain’s ability to "re-evaluate" past decisions, which is particularly useful in continual learning [^146].

Accumulating evidence shows that 5-HT also contributes to adaptive decision-making [^39] [^46] [^49] [^59]. In [^130], 5-HT and ACh play complementary roles in decision timing and this process involves neural circuits linking the dorsal raphe nucleus (a key source of 5-HT), the basal forebrain (the source of ACh) and the ACC.

##### Attention

Neuromodulators control attentional states by dynamically adjusting neuronal circuits to be more receptive to new information or to maintain existing knowledge, depending on task conditions and environmental demands [^11] [^27] [^107] [^293]. ACh adaptively allocates attention for optimized sensory processing [^18] [^106] [^231], and modulates the activity of cortical neurons, particularly in the prefrontal cortex and sensory areas, to enhance signal-to-noise ratios. It also increases the responsiveness of neurons to relevant sensory inputs while suppressing responses to irrelevant ones [^263], ensuring a focus on task-relevant information.

DA plays a critical role in adjusting attentional focus based on reward predictions and outcomes. It modulates the allocation of cognitive resources to tasks that are expected to yield high rewards through midbrain DA projections to the prefrontal cortex and basal ganglia. [^55] highlighted that DA enhances the encoding of reward-related cues, thus prioritizing actions that lead to positive outcomes. This modulation supports the maintenance of motivational states necessary for sustained attention and learning.

In contrast to ACh and DA, NA modulates arousal and stress responses by modulating LC activity [^11] [^27]. [^162] investigated how NA increases cortical excitability and enhances the detection of salient stimuli by regulating arousal, and suggested that NA helps maintain optimal attentional states that would allow animals to adapt to new information while preserving existing knowledge. The LC/NA system modulates neuronal activity in the PFC, but how attentional control and other cognitive computations such as inhibitory control of behaviors are processed in the LC/NA-PFC circuits remains to be studied [^15] [^217]. In summary, neuromodulators collectively facilitate adaptive control of attention and abate the risk of catastrophic forgetting by enhancing task-relevant cues-actions associations, forming robust representations that are resistant to interference.

##### Memory

Neuromodulators dynamically regulate synaptic plasticity (e.g., LTP and LTD) in circuits in the midbrain, basal ganglia, PFC, entorhinal cortex and the hippocampus, enhancing memory consolidation [^82] [^145] [^149] [^155] [^259], strengthening neural representations of previously learned skills. In the PFC, DA signaling enhances LTP and strengthens connections between contextual cues and task-relevant actions [^206] [^237]. In the amygdala, DA suppresses feedforward inhibition and modulates the time window required for long-term changes to enhance synaptic weights [^24]. In the dorsal striatum, DA governs long-term changes in both the strengthening and weakening of synaptic connections [^199]. Apart from DA, NA also promotes synaptic changes such as LTD, which can weaken synapses that are no longer relevant [^270].

Moreover, neuromodulators can selectively “tag” certain synapses for plasticity modulation (i.e., synaptic tagging [^80]), ensuring that task-relevant information is preserved while irrelevant connections are pruned [^45] [^183] [^221]. [^265] demonstrated a transient increase in hippocampal engram cell excitability following memory reactivation, which enhances the subsequent retrieval of specific memory contents in response to cues and is reflected in the animal’s precise and effective recognition of contexts. However, how neuromodulators contribute to the formation, maintenance and rapid control of engram cell excitability in neural circuits underlying continual learning and long-term memory that are resistant to catastrophic forgetting remains to be studied.

## 5 Introducing multi-neuromodulatory dynamics to ANNs

### 5.1 Relevant deep learning architectures

Advances in deep learning have significantly expanded the capacity of machine learning and AI, giving rise to diverse architectures that can capture complex data patterns [^87] [^148], e.g., convolutional and and recurrent networks [^52] [^130] [^139] [^210] [^291]. However, although several deep learning architectures draw inspiration from neural circuits, their learning processes are generally governed by globally applied update rules, which constrain task-specific flexibility and plasticity.

Emerging brain-inspired and neuromorphic approaches have sought closer alignment with biological principles. Spiking neural networks (SNNs), motivated by the sparse, energy-efficient and event-driven nature of neural processing [^70] [^236], transmit information through discrete spikes, and neuronal responses are only triggered once membrane activity reaches a threshold [^60]. Moreover, the precise temporal structure of spikes provides a basis for integrating time-dependent neuromodulatory processes, making SNNs suitable for real-time and online continual learning where plasticity must be dynamically regulated [^70] [^117] [^236].

Substantial progress has also emerged from architectural innovation and large-scale optimization rather than application of explicit biological constraints. Autoencoders, motivated by the principles of efficient coding, learn latent representations that compress inputs into structured features [^4] [^14] [^110] [^157] [^249]. They have been used to model feedforward and feedback interactions in the visual cortex, offering a functional account of recurrent processing as iterative feature reconstruction [^4]. Variational autoencoder frameworks inspired by hierarchical visual organization have also been proposed as mechanistic models of working memory formation and retrieval from latent representations [^110]. More recently, reconstruction error in autoencoders has been shown to correlate with image memorability under single-exposure conditions, suggesting that latent spaces capture perceptual distinctiveness in ways that parallel human memory performance [^14]. In parallel, transformer architectures achieve flexible generalization through attention mechanisms that capture long-range dependencies and hierarchical structure in sequential data [^136] [^187] [^284]. Foundation models built primarily on transformer architectures demonstrate that extensive pretraining on diverse datasets can yield strong transfer, multi-task, few-shot, and zero-shot capabilities [^25] [^36] [^209] [^208]. Through self-supervised learning and large-scale optimization, these systems generalize across domains with minimal task-specific fine-tuning [^114] [^274].

### 5.2 Simulating neuromodulatory effects

Neuromodulation-inspired elements have been implemented in ANNs to achieve flexible learning, robust performance on diverse tasks, and improved adaptation to changing environments. By mimicking the brain’s neuromodulatory systems, these models aim to achieve higher levels of computational efficiency and flexibility, similar to what is observed in biological organisms.

#### 5.2.1 Neuromodulation-aware DNNs

Neuromodulatory-inspired components have been integrated into ANNs through learning rules and hyperparameter adaptation. At the more global level, neuromodulatory signals influence the entire network on slower timescales. These mechanisms are often implemented through context-driven hyperparameter update. Examples include updating the learning rate and momentum to optimize performance in response to changing conditions [^173] [^286], modifying the slope and bias of the activation functions [^275], or modulating uncertainty to maintain stable learning and prevent catastrophic forgetting [^34].

Meanwhile, inspired by how neuromodulatory signals shape the synaptic plasticity window in biological neurons [^37] [^201] [^298], studies have incorporated neuromodulation at the connection level, e.g., modulating weight updates through signals such as contextual information [^51] [^58] [^113] [^115] [^177] [^178] [^179] [^233] [^260] [^269]. These top-down reconfigurations of connectivity can be interpreted as the third factor in the three-factor learning rule $\dot{w}=F(M,\text{pre},\text{post})$ [^78] [^141]. Here, $M$ represents the extrinsic, global neuromodulatory signal that guides weight changes in response to environmental changes or shifting task demands, complementing the pre- and post-synaptic activity. In several studies, eligibility traces are used to bridge the gap between fast synaptic events and slower, global neuromodulation, and weight updates may only occur when a modulatory signal is present [^17] [^161] [^178] [^233].

Notably, most modulatory signals considered are related to reward processing or DA signaling [^20] [^43] [^161] [^178] [^233]. However, recent approaches have expanded the third-factor rule to include surprise signals [^17], which are more closely associated with the effects of NA. Furthermore, some studies consider multi-neuromodulatory actions, tuning the plasticity window of neuronal connections through combinations like DA and ACh or DA and 5-HT [^282] [^296], therefore examining opposing and collaborative interactions between neuromodulatory signals. Though these top-down learning signals help address the credit assignment problem in ANNs, they remain insufficient, prompting new approaches to explore cell-type-specific neuromodulation [^160] [^161].

#### 5.2.2 Computational models of neuromodulation

To the best of our knowledge, neuromodulation has yet to be implemented at the subcellular and neuronal scale in ANNs. However, studies have attempted to study neuromodulatory processes through theoretical frameworks, investigating the functional roles of neuromodulators in single cell and network models (for a review, see [^72]). Fellous and Linster’s work probed the activity of neuromodulators through five computational models of progressively increasing biological fidelity: the Markovian kinetics model, the Hodgkin-Huxley model, the FitzHugh-Nagumo model, the leaky integrator model, and the connectionist model. While the biological realism represented in the majority of these models is incompatible with DNNs due to the associated computational costs [^218], models presented in this review exemplify how neuromodulator dynamics can be flexibly parameterized across abstraction levels. Importantly, the study underscores two significant challenges that still persist today: the absence of direct biological analogs for some neural network parameters and the inability to fully represent all neuromodulation-related processes through parameter changes alone.

Following this biophysical approach, neuromorphic spiking control systems use fewer neurons with complex dynamics, such as FitzHugh-Nagumo models, to perform motor control tasks in robotics [^232] [^239]. These tasks leverage network motifs and neuromodulatory signals to regulate movement through stable and unstable network states [^213]. However, scaling these systems to large ANNs is limited by computational costs, posing another challenge in single-cell neuromodulation modeling.

### 5.3 Neuromodulation-inspired components across scales

Emulating the intricate interplay of morphology, neuronal dynamics, and neuromodulatory processes promotes learning in complex environments, potentially advancing the capabilities of ANNs. Here, we leverage multiple network scales on which neuromodulatory signals regulate learning, based on their spatio-temporal complexity in the brain.

### 5.4 Subcellular and neuronal level

The structural complexity of neurons is instrumental in information processing. Dendritic heterogeneity, which refers to the variation in dendritic branching and spine density, allows neurons to integrate diverse inputs effectively. Mimicking this in DNNs involves designing models that can adaptively modify their connectivity patterns, enabling more nuanced feature extraction and representation learning.

Neuronal dynamics, including spiking behavior and receptor modeling, is essential for temporal information processing and synaptic plasticity. Incorporating spiking mechanisms into DNNs can enhance their ability to handle sequential and time-dependent data. Additionally, modeling neuronal heterogeneity, where neurons exhibit diverse response patterns, can lead to more versatile network behaviors.

At the subcellular and neuronal level, structural and functional complexity can be incorporated through dendritic compartments and learnable biases in ANNs. In SNNs, it can be realized through different spiking behaviors.

##### Structural diversity

Incorporating dendritic architectures enables resilient continual learning [^1] [^194] and offers a plausible explanation for backpropagation signals [^93] [^200] [^226]. [^118] proposed an architecture featuring context-driven dendritic layers and learns multiple tasks with minimal forgetting. Similarly, multi-task learning can be achieved through NMDA-driven dendritic modulation in a self-supervised biophysical model, where task-dependent modulations are applied to individual neurons [^289]. Incorporating temporal diversity also enables dendrites to function as temporal gates, leading to multi-timescale learning [^299].

Combined with multi-compartmental morphology, neuromodulation brings a new dimension for tuning neuronal responses. Neuromodulation-inspired mechanisms allow contextual cues to shape dendritic processing, while compartmental models help highlight the role of neuromodulators in promoting dendritic and spine structural plasticity. Dendritic properties can be modified through parameters including dendrite length, diameter, and branching.

##### Functional diversity

Heterogeneous neuronal dynamics is fundamental to biological systems [^71] [^119] [^123] [^166] [^214] and is frequently overlooked in DNNs. A study on ANNs leverages neuronal bias for multi-task learning through backward transfer, underscoring the importance of functional heterogeneity [^285]. In SNNs, neuronal timescale heterogeneity in leaky integrate-and-fire (LIF) neurons enhances robustness [^202], while a temporal hierarchy within the network leads to higher performance [^185]. [^96] employed evolutionary algorithms to investigate bursting parameter heterogeneity, allowing the network to solve spatio-temporal tasks. Theoretical work with heterogeneous SNNs of Izhikevich neurons demonstrated that adaptive network computations was achieved at the spike level [^84], offering a mechanism by which neuromodulatory effects on neuronal dynamics could be implemented.

Given the computational costs associated with simulating subcellular and neuronal-level neuromodulatory processes (e.g., ion channel parameters), higher-level abstraction is possible using a process similar to simplifying biophysical models and representing the overall properties, such as adaptive firing threshold, which shifts the gain function at the population level [^242]. Furthermore, axonal and dendritic propagation delays, a mechanism that is often overlooked in computational studies, can contribute to the emergence of connectivity patterns. Neuromodulators can alter the excitability of axons, and therefore, the temporal fidelity. Introducing neuronal level heterogeneity can help link these neuron-level mechanisms with network-level dynamics.

##### Receptor dynamics

ANNs primarily emulate rapid feedforward information flow, representing short-term plasticity mechanisms analogous to ionotropic receptor dynamics. However, the slower and more complex processes governed by metabotropic receptors, which play a critical role in higher-order cognitive representations, are often unexplored [^105]. Although [^78] incorporated aspects of metaplasticity through neuromodulated learning rules, the broader metabotropic influence – such as modulation of neuronal excitability, gain or gating – were still missing. Modeling these processes is challenging, as metabotropic signaling depends on intracellular cascades that are computationally expensive to simulate in artificial systems.

Recurrent architectures such as gated recurrent units (GRUs) and long short-term memory networks (LSTMs) capture longer temporal dependencies and offer partial abstractions of gating. Neuromodulatory signals have been functionally approximated by mechanisms analogous to the forget gate in LSTM cells [^51], similarly, training weights and biases independently raises the possibility of interpreting bias modulation as a proxy for neuromodulation-driven regulation [^285]. Nevertheless, achieving precise control over single-neuron dynamics requires models that explicitly represent spike-based computations. SNNs provide such a framework and offer a substrate for studying metabotropic-like modulation on excitability and plasticity [^218].

### 5.5 Circuitry level

The circuitry level takes into account both structural elements such as neuronal connectivity and population-level diversity of neurons (micro-circuitry), as well as the emergence of neuronal populations into functionally specific groups and the interconnections across these groups (meso-circuitry). Unlike ANNs, in the biological brain, connectivity between neurons features a sparse pattern and is determined by multiple factors. Such connectivity facilitates energy efficiency, evolves with development, and underlies plasticity and learning.

##### Connectivity

The microcircuit structure of biological neural networks varies across brain regions. Bio-inspired DNNs attempt to mimic this complexity by imposing constraints on synaptic weight plasticity, adjusting connectivity features such as sparsity and connection probability [^142] [^202] [^292]. Neuronal connectivity is shaped by factors such as the genetic type of neurons and the distance between neurons [^23] [^165] [^251]. Compared to DNNs with fully-connected layers, the connection probability between neurons in the brain is low, leading to sparse connectivity [^182], which can be introduced in DNNs by adding a non-trainable sparse matrix to define the network connectivity [^292]. Additionally, a recent approach explored stochastic wiring by incorporating connection probabilities, highlighting that randomness in connectivity might be an evolutionarily developed feature in biological organisms [^142] [^202].

Neuromodulation can regulate the global connection profile of neural networks. Meanwhile, network connectivity shapes network dynamics changes caused by the neuromodulatory tone [^215]. Given the multitude of pre- and post-synaptic processes neuromodulators affect, they not only participate in regulating the probability of connection but its strength. Neuromodulation plays an important role in modifying circuit level connectivity through both direct and indirect mechanisms: For example, they contribute to the formation and elimination of synapses (direct mechanism), and in the meantime, alter the excitability of neurons (indirect mechanism) [^189]. Moreover, one synapse may be under the influence of multiple neuromodulators, and the combined effects may not be additive and depend on the network state [^134] [^189].

##### Excitation and inhibition

Dale’s principle [^57] [^68] led to the introduction of excitatory and inhibitory neuronal populations into ANNs and has been challenged by the finding that neurons can release more than one neurotransmitter [^267] [^273]. In practice, this imposes a constraint on the sign of synaptic weight in the network, meaning that excitatory neurons are restricted to facilitating positive signal transmission and inhibitory neurons are limited to negative signal transmission [^292]. A few DNN and recurrent neural network (RNN) architectures have incorporated these features, often adopting the 80:20 excitation:inhibition ratio [^50] [^125] [^154] [^248]. A study on SNNs highlighted the significance of this specific ratio, showing that it leads networks to reliably train at low activity levels and in noisy environments, underscoring its practicality [^131]. However, while bio-inspired, this constraint may limit the learning and performance of DNNs as the available parameter space is reduced [^50] [^125] [^154]. The addition of neuromodulatory signals at this level could enable switching between excitatory and inhibitory weights, allowing networks to better adapt to specific tasks and support multi-task learning by preserving weight signs across sequential tasks.

### 5.6 Network level

Neuromodulatory systems play a crucial role in shaping large-scale brain network dynamics. These systems extend their influence beyond localized circuits, modulating brain-wide activity patterns and facilitating the coordination of diverse cognitive functions [^164] [^173]. At this broader systems level, understanding the impact of global neuromodulatory signals on large-scale networks offers valuable insights for the design of ANNs.

##### Network topology

Network neuroscience provides tools for unveiling the implications of brain structures and their emerging properties, as well as an analytical framework for studying the neuromodulatory systems. Network neuroscience research employs graph theory and treats the brain as an interconnected network of nodes (regions) and edges (connections). Key measures such as modularity, integration, and participation coefficient offer insights into the organization and efficiency of these networks. Neuromodulatory systems dynamically adjust connections and promote efficient communications across and within brain regions, and play a vital role in maintaining the balance between network segregation and integration, which is essential for robustness, efficiency and adaptability [^244].

Open source brain atlas and data sharing have allowed a closer examination of the brain’s network, offering a data-intensive view of its specialized structural and functional modules responsible for perceptual, cognitive and motivational tasks [^100]. Network topologies identified in biological neural networks have been used to construct ANNs with reduced number of parameters but no performance decline [^89] [^182]. Moreover, topologies derived from connectome data are shown to promote efficient reinforcement learning when incorporated into SNNs [^279].

Determining the modularity of brain networks and superimposing it with the spatial domains of neuromodulation, then probing its convergence and divergence across functions and brain states, may serve as a guide to create specialized network topologies for different tasks. In the meantime, identifying nodes and clusters shared between tasks may shed light on a unifying view of centralized processing across task domains.

##### Hyperparameters and activation functions

Neuromodulation-inspired mechanisms enable ANNs to adjust hyperparameters and activation functions, thus regulating network dynamics in response to changing environments, task demands and cognitive/behavioral states [^34] [^173] [^275] [^286]. Such adaptability is crucial for intelligent systems capable of operating autonomously in real-world environments where conditions and requirements frequently shift. The capacity for adaptive reconfiguration at the network scale is critical for improving the resilience of ANNs, enhancing their ability to withstand disruptions or noise while maintaining stable performance.

##### Global multi-neuromodulatory interactions

Inspired by [^66], deep reinforcement learning (DRL) offers a structured approach for interpreting neuromodulatory actions. In DRL, neuromodulatory functions can be easily mapped to model hyperparameters: DA for reward prediction through temporal difference (TD) learning, 5-HT controls the influence of short- and long-term rewards, NA modulates the randomness of action selection through a Softmax policy, and ACh affects the learning rate [^66] [^137] [^174]. These depictions have been widely used to support lifelong RL in artificial agents [^21] [^150] [^174]. However, this one-to-one mapping between neuromodulatory signals and their functional role through single hyperparameters may be an oversimplification.

Hence, understanding the synergistic and balancing interactions among neuromodulators is crucial for the design of more sophisticated models that replicate human-like decision-making and problem-solving abilities. In biological systems, neuromodulatory systems do not operate in isolation; they interact continuously in a state- and context-dependent manner. These interactions fine-tune various neurobiological processes essential for adaptive behavior [^13] [^37] and for acquiring new information with minimal interference [^28] [^168].

In ANNs, multi-neuromodulatory mechanisms can be introduced through (i) regulation and refinement of neuromodulatory drives through other neuromodulators, (ii) spatial and temporal correlations of neuromodulatory drives, and (iii) task-specific behavior of localized and global neuromodulation.

## 6 Multi-neuromodulatory dynamics in ANNs: a conceptual model

To illustrate the effects of multi-neuromodulatory dynamics, we present a conceptual study using a reward-driven, extra-dimensional/intra-dimensional set-shifting Go/No-Go task [^63] [^135] [^216]; Figure 3A. In this paradigm, the agent must respond to pairings of two sets of input patterns representing distinct sensory modalities (e.g., visual (A, B) and auditory (X, Y) stimuli; Figure 3C) and must learn, through trial and error, which stimulus predicts a reward. The agent’s objective is to acquire and maintain an appropriate response policy under a given contingency. Crucially, midway through the experiment, the stimulus–reward contingency is altered, such that the previously rewarded “Go” cue no longer applies, forcing the agent to rapidly adapt its behavior to a new contingency.

![Refer to caption](https://arxiv.org/html/2501.06762v3/figures/fig3_new.png)

Figure 3: Contingency adaptation in spiking neural networks during a Go–No-Go task. A) Experimental paradigm. B) Neuromodulatory actor–critic architecture, comprising a predictive network and a critic network, with DA and NA signals regulating learning and gain. C) Input structure before and after the set shift. Two visual stimuli and two auditory stimuli are encoded as sparse population activity. D) Task performance over time for DA-only learning (red), DA-only “lucky” trials that successfully adapt by chance (orange), and DA + NA co-modulated learning (green). The vertical line represents the set shift. E) The LC-tone transient at the set shift. F) Conditioned action entropy given the go cue, H ( A ∣ goCue ) H(A\\mid\\mathrm{goCue}), quantifying exploratory behavior. DA: dopamine; NA: noradrenaline; LC: locus coeruleus.

We examine how DA-like signals support reward-driven plasticity under stable contingencies, while NA-like signals enable rapid reconfiguration and exploration following contingency shifts – capturing key aspects of biological learning flexibility that emerge only when both neuromodulators act in concert. Motivated by reinforcement learning strategies, we consider an actor–critic architecture [^43] [^60] [^257] augmented by a predictive coding sub-module for detecting unexpected changes in the environment [^17], thereby facilitating flexibility when reward contingencies change [^277] [^188] [^219] – see Figure 3B.

- The actor network is responsible for the agent’s decision-making. We use two groups of neurons (one for each action ’Go’ (blue) or ’No-Go’ (grey)), each containing excitatory and inhibitory units. The network selects the action depending on the group that has a higher net firing rate, i.e., the average firing rate of the excitatory neurons minus that of the inhibitory neurons.
- The critic network, composed of excitatory and inhibitory neurons, estimates the value of the expected reward in the current state by its net firing rate. The TD error is computed by comparing the estimated value with the actual reward received during the trial [^234]. The RPE represents the DA activity of the network and acts as a third factor that modifies synaptic plasticity, following the R-STDP learning rule [^43]. Specifically, DA activity adjusts the reward expectancy based on current contingency.
- The predictive network detects changes in task contingencies using principles inspired by predictive coding. It continuously compares incoming stimuli with predictions based on previous experiences to identify discrepancies or unexpected changes [^17]. When the network detects such a change in contingency – that is, when the expected relationship between stimuli and outcomes alters – it responds by releasing a neuromodulatory signal modeled after NA. By emulating the LC’s dynamics, the signal is appropriately timed to influence the network’s processing during set-shifting periods (Figure 3E). The NA-like signal targets excitatory neurons in both the actor and critic networks, promoting synaptic plasticity by inducing correlated bursting activities in these neurons. As in [^188] [^220], such bursting elevates the arousal state, flattening the energy landscape and enhancing network flexibility [^11]. Hence, this heightened arousal facilitates the reconfiguration of the network, allowing it to adapt more effectively to new contingencies by promoting the exploration of alternative actions [^27] [^66] [^272]. Intuitively, the NA-inspired component will dynamically flatten the loss landscape, enhancing a transient exploration between attractors [^277] [^219].

### 6.1 Evaluation and interpretation

Model performance can first be evaluated under stable contingencies, assessing how the DA-like signal modulates reward-driven plasticity through an R-STDP rule. In this setting, learning efficacy is quantified by the ability of the actor-critic network to acquire and exploit rewarded actions, with the TD error shaping synaptic updates in the critic network, consistent with established neuromodulated learning frameworks [^43] [^75] [^78]. Following a contingency shift, evaluation focuses on whether the NA-like signal promotes flexible network reconfiguration after changes are detected by the predictive module. This flexibility is quantified by the randomness or uncertainty of action selection, where increased exploration corresponds to higher uncertainty and increased exploitation to lower uncertainty, measured using the Shannon entropy of actions conditioned on correct responses:

$$
H(A|C)=-\sum_{i}P(a_{i}|C)\log_{2}P(a_{i}|C).
$$

where $P(a_{i}|C)$ represents the probability of selecting a correct action $a_{i}$. When a set-shift occurs (i.e., a change in contingency), the system no longer knows the correct responses for the new task. Therefore, the entropy increases again as the agent explores the new contingency (Figure 3F). However, since the network’s weights were optimized for the previous contingency, the timescale for adapting to the new one depends on how quickly the system can reconfigure its weights. This can result in prolonged optimization times converging toward suboptimal solutions or, in most cases, failure to optimize altogether (red and orange lines, Figures 3D and F). Introducing NA (Figure 3E) into the system facilitates weight reconfiguration: NA promotes exploration by increasing the entropy temporarily, enabling the system to rapidly sample and evaluate new actions. This accelerates the discovery of the new contingency, leading to faster adaptation compared to relying solely on RL mechanisms (green lines, Figures 3D and E).

This conceptual model illustrates how neuromodulation-aware spiking neural networks can integrate stable reward-based learning with rapid adaptation to changing contingencies. DA-like signals guide learning under stable conditions through third-factor plasticity [^43] [^120], while NA-like signals transiently increase network flexibility following detected changes, promoting exploration and facilitating dimensionality shifts [^219] [^277]. The resulting dynamics provide mechanistic intuition for how exploration and exploitation trade offs emerge from interactions between neuromodulatory systems, enabling continual adaptation in non stationary environments. They also point to key challenges for future work, including the experimental measurement of conditioned action entropy to evaluate these intuitions, the development of accurate SNN implementations, and the theoretical study of richer neuromodulatory interactions.

## 7 Discussions and outlook

Understanding how biological organisms learn, developing machines that emulate biological learning, and identifying additional bio-inspired features to introduce to artificial systems involve multifaceted research [^128] [^144]. In this article, we propose new avenues for realizing multi-neuromodulatory dynamics in ANNs and highlight its specificities across scales. Nevertheless, the integration of neuroscience-inspired elements into AI models requires a deeper exploration of neural mechanisms underpin cognition, learning and development. Additionally, abstracting complex neuromodulatory systems presents significant challenges, such as modeling nonlinear, context-dependent interactions between neuromodulators and their individual and collective impacts on network dynamics.

### 7.1 Exploring multi-neuromodulatory mechanisms

A useful framing is to view neuromodulatory control through the lens of dynamical systems and attractor landscapes [^8] [^77] [^153] [^163] [^223]. In this view, neuromodulators can stabilize task-relevant states, reshape their basins of attraction, or trigger transitions when contingencies change, thereby balancing plasticity and stability [^188] [^245] [^277] [^220]. This perspective naturally accommodates cooperation and antagonism between neuromodulators and suggests algorithmic motifs for continual learning, where different signals gate learning, exploration, and consolidation under task shifting.

Multi-neuromodulator dynamics flexibly promote multiple learning paradigms such as transfer-learning, meta-learning, and incremental learning, depending on the particular constraints imposed on the agent. However, there are a number of challenges in the study of neuromodulation and in neuromodulation-aware ANNs. A prominent example is neuromodulatory projections to specific subtypes of neurons and their region-dependent, projection-specific effects. Consequently, the use of modular architectures in neuromodulation-aware ANNs may help implement modulatory projections to specific subsets of units. Nevertheless, it remains to be studied how such modular architectures in ANNs could be designed in a principled manner [^218] [^292]. More importantly, the complexity of neuromodulatory systems and neural circuitry in the biological brain (e.g., neuronal heterogeneity, tonic and phasic firing, and multi-neuromodulatory interactions) serves as a foundation of the distinct neuromodulatory dynamics, and the complex interplay between neuromodulators and their receptors. Despite recent developments in experimental neuroscience techniques, several challenges persist (Box 7.1). The multi-scale effects of neuromodulators, the limited resolution of pharmacological and neurogenetic tools, and the prevalent co-release of neuromodulators and neurotransmitters complicate the study of neuromodulatory mechanisms, highlighting the need for the development of new technical tools.

Computational models provide an important bridge across spatial and temporal scales, linking synaptic and cellular mechanisms to population dynamics, behavior, and cognition. Biophysical models connect synaptic processes with spiking activity, while network models relate collective neural dynamics to learning and adaptive behavior. Incorporating multi-scale neuromodulatory dynamics into such models allows for systematic investigation of how neuromodulation shapes plasticity, network organization, and behavioral outcomes, facilitating the generation and testing of experimentally grounded hypotheses. Seminal examples include cerebellar learning frameworks [^6] [^116] [^167] and reinforcement learning models of DA signaling [^234] [^257]. Going beyond basic neuroscience research, computational models also provide powerful tools for studying brain disorders [^38] [^147] [^158] [^198] [^276], revealing how disruptions in neural circuits can cause physiological and cognitive dysfunctions, informing the development of therapeutic strategies for neurological and psychiatric diseases [^184] [^76].

Methodological challenges in experimental studies of the neuromodulatory systemPharmacological manipulations: Many studies on neuromodulator interactions rely on pharmacological manipulations of receptor subtypes at a systems level, limiting insights into local endogenous release and interactions of neuromodulators. For experiments conducted under awake conditions, key challenges include limited spatiotemporal resolution, possible off-target effects, varying dose-response relationships across subjects, compensatory mechanisms, and imperfect receptor specificity [^94]. Furthermore, pharmacological studies conducted in strictly controlled environments often fail to capture the context-, state- and task-dependent effects of neuromodulators.

Neurogenetic tools: G-protein-coupled receptor activation-based (GRAB) sensors for neuromodulators such as DA and NA have overcome the limitations of pharmacological manipulations [^73] [^256]. Although they have advanced real-time detection and measurement of neuromodulator actions [^65], their use is still limited due to insufficient spatial and temporal resolutions. Similarly, transgenic animal models (e.g., Cre-driver lines) offer powerful tools for targeting specific neuronal populations. However, off-target expression of marker genes in unintended cell types or brain regions can affect the reliability and interpretation of experimental results. In [^212], for some transgenic mouse lines, Cre protein expression, which is supposed to target only 5-HT-producing neurons, is not restricted to these neurons and leads to recombination in non-5-HT neurons, potentially confounding the identification and interpretation of 5-HT-related functions.

Precise targeting of neuromodulators: Given the diverse connections to and from neuromodulator-releasing cells [^281], it is crucial to examine the physiological and behavioral effects of neuromodulation in a projection- and neuron-type-specific manner. However, several issues must be addressed: (i) Quantifying neuromodulator levels and their receptor activities in some brain regions is challenging given their low concentrations and rapid release and uptake. (ii) Selectively manipulating neuromodulatory pathways is difficult due to the extensive and overlapping projection patterns of neuromodulatory systems. (iii) Capturing and delineating neuromodulatory dynamics and effects across timescales, ranging from rapid changes in neuronal excitability to long-term alterations in gene expression, requires sophisticated experimental designs and analytical methods.

Disentangling the co-release of neuromodulators: The complexity of neurotransmitter co-release makes it difficult to elucidate the effects of individual neuromodulators. For instance, cholinergic interneurons (CINs) in the striatum, which are central to ACh signaling, are known to co-release glutamate and gamma-aminobutyric acid (GABA). This complicates the interpretation of experimental results. [^168] investigated the local effects of CIN activity on DA in the striatum and suggested that depending on the context and experimental condition, CINs can enhance or suppress DA release. Another example is midbrain DA neurons, which can co-release glutamate from their axonal terminals, with VGLUT2 playing a crucial role in this process [^56] [^253] [^255].

### 7.2 Implementing and interpreting multi-neuromodulatory mechanisms in ANNs

#### 7.2.1 Challenges and avenues

The translation of neuromodulatory principles faces two bottlenecks. First, multi-scale neuromodulation expands the parameter space, while biological parameters rarely map cleanly onto deep learning hyperparameters, complicating convergence and reproducibility between frameworks [^173]. Second, interpreting the effects of neuromodulation-inspired rules is challenging as similar behaviors can arise from different modulatory configurations [^266].

To address interpretability issues and the black-box nature of DNNs, explainable AI (XAI) approaches can be extended to quantify how neuromodulatory signals shape network activations, learning dynamics, and decisions. Attention-based and graph-based methods, combined with perturbations of specific modulatory components, may help clarify whether and how neuromodulation shapes computation. Complementing these approaches with experimentally-grounded tasks, benchmarks and analyses can improve understanding of model performance and associated mechanisms. Together with neuromodulated deep learning architectures, these tools provide a foundation for building biologically-informed yet interpretable models that capture the spatio-temporal complexity of neuromodulation.

#### 7.2.2 Interdisciplinary collaborations and community-driven efforts

The computational cost and scalability of biologically-detailed models remain significant obstacles for deploying neuromodulation-aware systems in large-scale applications. Although the application of neuromodulatory principles to ANNs have been previously proposed, gaps in our knowledge and translational efforts still hinder its development. Progress toward neuro-inspired adaptive learning systems, which is dependent on the integration of experimental insights with principled computational abstractions, requires collaborations between neuroscience and AI experts [^140].

A way forward is the development of community-driven resources for neuromodulation-aware ANNs, including shared datasets, benchmarks, models, and tools. Such platforms could host experimental and simulated multi-scale data alongside biologically-grounded tasks that enable comparison across methods. Coordinated efforts to pool data across laboratories and species [^127], together with open theoretical and computational frameworks [^283] [^211], will accelerate the integration of biological principles into ANNs. Additionally, interdisciplinary venues focusing on neuromodulation in learning, e.g., Neuromodulation of Adaptive Learning: Theoretical Lessons Learned From Invertebrate and Vertebrate Brains, 2024 (TP24NM) organized at the Okinawa Institute of Science and Technology (OIST), facilitate the exchange of experimental and computational methods on neuromodulatory principles in biological neural networks and their artificial counterparts. Through cross-disciplinary dialogues, these initiatives can support the development of more robust, interpretable, and adaptive artificial systems inspired by neuromodulated learning in the biological brain.

[^1]: Dendritic Computing: Branching Deeper into Machine Learning. Neuroscience 489, pp. 275–289 (en). External Links: ISSN 03064522, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0306452221005017), [Document](https://dx.doi.org/10.1016/j.neuroscience.2021.10.001) Cited by: 3rd item, §4.2.2, §5.4.

[^2]: Intercellular communication in the brain: Wiring versus volume transmission. Neuroscience 69 (3), pp. 711–726 (en). External Links: ISSN 03064522, [Link](https://linkinghub.elsevier.com/retrieve/pii/0306452295003086), [Document](https://dx.doi.org/10.1016/0306-4522%2895%2900308-6) Cited by: 3rd item.

[^3]: What is dopamine doing in model-based reinforcement learning?. Current Opinion in Behavioral Sciences 38, pp. 74–82 (en). External Links: ISSN 23521546, [Link](https://linkinghub.elsevier.com/retrieve/pii/S2352154620301558), [Document](https://dx.doi.org/10.1016/j.cobeha.2020.10.010) Cited by: 2nd item, §3.3.

[^4]: Reconstructing feedback representations in the ventral visual pathway with a generative adversarial autoencoder. PLOS Computational Biology 17 (3), pp. e1008775 (en). External Links: ISSN 1553-7358, [Link](https://dx.plos.org/10.1371/journal.pcbi.1008775), [Document](https://dx.doi.org/10.1371/journal.pcbi.1008775) Cited by: §5.1.

[^5]: Mammalian Nicotinic Acetylcholine Receptors: From Structure to Function. Physiological Reviews 89 (1), pp. 73–120 (en). External Links: ISSN 0031-9333, 1522-1210, [Link](https://www.physiology.org/doi/10.1152/physrev.00015.2008), [Document](https://dx.doi.org/10.1152/physrev.00015.2008) Cited by: §4.2.1.

[^6]: A theory of cerebellar function. Mathematical Biosciences 10 (1-2), pp. 25–61 (en). External Links: ISSN 00255564, [Link](https://linkinghub.elsevier.com/retrieve/pii/0025556471900514), [Document](https://dx.doi.org/10.1016/0025-5564%2871%2990051-4) Cited by: §7.1.

[^7]: Memory Aware Synapses: Learning what (not) to forget. arXiv. Note: Version Number: 4Other ECCV 2018 External Links: [Link](https://arxiv.org/abs/1711.09601), [Document](https://dx.doi.org/10.48550/ARXIV.1711.09601) Cited by: §2.1.

[^8]: Modeling Brain Function: The World of Attractor Neural Networks. 1 edition, Cambridge University Press. External Links: ISBN 978-0-521-36100-2 978-0-521-42124-9 978-0-511-62325-7, [Link](https://www.cambridge.org/core/product/identifier/9780511623257/type/book), [Document](https://dx.doi.org/10.1017/CBO9780511623257) Cited by: §7.1.

[^9]: Rethinking interference theory: Executive control and the mechanisms of forgetting. Journal of Memory and Language 49 (4), pp. 415–445 (en). External Links: ISSN 0749596X, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0749596X03001128), [Document](https://dx.doi.org/10.1016/j.jml.2003.08.006) Cited by: Table 1.

[^10]: Activity of norepinephrine-containing locus coeruleus neurons in behaving rats anticipates fluctuations in the sleep-waking cycle. The Journal of Neuroscience 1 (8), pp. 876–886 (en). External Links: ISSN 0270-6474, 1529-2401, [Link](https://www.jneurosci.org/lookup/doi/10.1523/JNEUROSCI.01-08-00876.1981), [Document](https://dx.doi.org/10.1523/JNEUROSCI.01-08-00876.1981) Cited by: §3.3.

[^11]: AN INTEGRATIVE THEORY OF LOCUS COERULEUS-NOREPINEPHRINE FUNCTION: Adaptive Gain and Optimal Performance. Annual Review of Neuroscience 28 (1), pp. 403–450 (en). External Links: ISSN 0147-006X, 1545-4126, [Link](https://www.annualreviews.org/doi/10.1146/annurev.neuro.28.061604.135709), [Document](https://dx.doi.org/10.1146/annurev.neuro.28.061604.135709) Cited by: §3.3, §4.2.3, §4.2.3, §4, 3rd item.

[^12]: Role of locus coeruleus in attention and behavioral flexibility. Biological Psychiatry 46 (9), pp. 1309–1320 (en). External Links: ISSN 00063223, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0006322399001407), [Document](https://dx.doi.org/10.1016/S0006-3223%2899%2900140-7) Cited by: §3.3, §4.2.1, §4.

[^13]: Neuromodulatory Systems and Their Interactions: A Review of Models, Theories, and Experiments. Frontiers in Neural Circuits 11, pp. 108. External Links: ISSN 1662-5110, [Link](http://journal.frontiersin.org/article/10.3389/fncir.2017.00108/full), [Document](https://dx.doi.org/10.3389/fncir.2017.00108) Cited by: §3.3, §3.3, §5.6.

[^14]: Modeling Visual Memorability Assessment with Autoencoders Reveals Characteristics of Memorable Images. arXiv. Note: Version Number: 2 External Links: [Link](https://arxiv.org/abs/2410.15235), [Document](https://dx.doi.org/10.48550/ARXIV.2410.15235) Cited by: §5.1.

[^15]: Differential attentional control mechanisms by two distinct noradrenergic coeruleo-frontal cortical pathways. Proceedings of the National Academy of Sciences 117 (46), pp. 29080–29089 (en). External Links: ISSN 0027-8424, 1091-6490, [Link](https://pnas.org/doi/full/10.1073/pnas.2015635117), [Document](https://dx.doi.org/10.1073/pnas.2015635117) Cited by: §3.3, §4.2.3.

[^16]: A review of central 5-HT receptors and their function. Neuropharmacology 38 (8), pp. 1083–1152 (en). External Links: ISSN 00283908, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0028390899000106), [Document](https://dx.doi.org/10.1016/S0028-3908%2899%2900010-6) Cited by: §4.2.1, §4.2.1.

[^17]: Fast adaptation to rule switching using neuronal surprise. PLOS Computational Biology 20 (2), pp. e1011839 (en). External Links: ISSN 1553-7358, [Link](https://dx.plos.org/10.1371/journal.pcbi.1011839), [Document](https://dx.doi.org/10.1371/journal.pcbi.1011839) Cited by: §5.2.1, §5.2.1, 3rd item, §6.

[^18]: Cognitive functions of the basal forebrain. Current Opinion in Neurobiology 9 (2), pp. 178–183 (en). External Links: ISSN 09594388, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0959438899800245), [Document](https://dx.doi.org/10.1016/S0959-4388%2899%2980024-5) Cited by: §4.2.3.

[^19]: Dopamine Modulates Reward-Related Vigor. Neuropsychopharmacology 38 (8), pp. 1495–1503 (en). External Links: ISSN 0893-133X, 1740-634X, [Link](https://www.nature.com/articles/npp201348), [Document](https://dx.doi.org/10.1038/npp.2013.48) Cited by: §3.3.

[^20]: A solution to the learning dilemma for recurrent networks of spiking neurons. Nature Communications 11 (1), pp. 3625 (en). External Links: ISSN 2041-1723, [Link](https://www.nature.com/articles/s41467-020-17236-y), [Document](https://dx.doi.org/10.1038/s41467-020-17236-y) Cited by: §5.2.1.

[^21]: Context meta-reinforcement learning via neuromodulation. Neural Networks 152, pp. 70–79 (en). External Links: ISSN 08936080, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0893608022001368), [Document](https://dx.doi.org/10.1016/j.neunet.2022.04.003) Cited by: §5.6.

[^22]: Locus coeruleus. Cell and Tissue Research 373 (1), pp. 221–232 (en). External Links: ISSN 0302-766X, 1432-0878, [Link](http://link.springer.com/10.1007/s00441-017-2649-1), [Document](https://dx.doi.org/10.1007/s00441-017-2649-1) Cited by: §3.1.

[^23]: Systematic Integration of Structural and Functional Data into Multi-scale Models of Mouse Primary Visual Cortex. Neuron 106 (3), pp. 388–403.e18 (en). External Links: ISSN 08966273, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0896627320300672), [Document](https://dx.doi.org/10.1016/j.neuron.2020.01.040) Cited by: §5.5.

[^24]: Dopamine gates LTP induction in lateral amygdala by suppressing feedforward inhibition. Nature Neuroscience 6 (6), pp. 587–592 (en). External Links: ISSN 1097-6256, 1546-1726, [Link](https://www.nature.com/articles/nn1058), [Document](https://dx.doi.org/10.1038/nn1058) Cited by: §4.2.3.

[^25]: On the Opportunities and Risks of Foundation Models. arXiv. Note: Version Number: 3Other Authored by the Center for Research on Foundation Models (CRFM) at the Stanford Institute for Human-Centered Artificial Intelligence (HAI). Report page with citation guidelines: https://crfm.stanford.edu/report.html External Links: [Link](https://arxiv.org/abs/2108.07258), [Document](https://dx.doi.org/10.48550/ARXIV.2108.07258) Cited by: §5.1.

[^26]: Modeling somatic and dendritic spike mediated plasticity at the single neuron and network level. Nature Communications 8 (1), pp. 706 (en). External Links: ISSN 2041-1723, [Link](https://www.nature.com/articles/s41467-017-00740-z), [Document](https://dx.doi.org/10.1038/s41467-017-00740-z) Cited by: 3rd item.

[^27]: Network reset: a simplified overarching theory of locus coeruleus noradrenaline function. Trends in Neurosciences 28 (11), pp. 574–582 (en). External Links: ISSN 01662236, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0166223605002432), [Document](https://dx.doi.org/10.1016/j.tins.2005.09.002) Cited by: §3.3, §4.2.3, §4.2.3, 3rd item.

[^28]: The Thalamostriatal Pathway and Cholinergic Control of Goal-Directed Action: Interlacing New with Existing Learning in the Striatum. Neuron 79 (1), pp. 153–166 (en). External Links: ISSN 08966273, [Link](https://linkinghub.elsevier.com/retrieve/pii/S089662731300370X), [Document](https://dx.doi.org/10.1016/j.neuron.2013.04.039) Cited by: §5.6.

[^29]: The single dendritic branch as a fundamental functional unit in the nervous system. Current Opinion in Neurobiology 20 (4), pp. 494–502 (en). External Links: ISSN 09594388, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0959438810001170), [Document](https://dx.doi.org/10.1016/j.conb.2010.07.009) Cited by: §4.2.2.

[^30]: Modulators in concert for cognition: modulator interactions in the prefrontal cortex. Progress in Neurobiology 83 (2), pp. 69–91 (eng). External Links: ISSN 0301-0082, [Document](https://dx.doi.org/10.1016/j.pneurobio.2007.06.007) Cited by: §4.1.

[^31]: The Striosome and Matrix Compartments of the Striatum: A Path through the Labyrinth from Neurochemistry toward Function. ACS Chemical Neuroscience 8 (2), pp. 235–242 (en). External Links: ISSN 1948-7193, 1948-7193, [Link](https://pubs.acs.org/doi/10.1021/acschemneuro.6b00333), [Document](https://dx.doi.org/10.1021/acschemneuro.6b00333) Cited by: §4.1.

[^32]: Homology, neocortex, and the evolution of developmental mechanisms. Science 362 (6411), pp. 190–193 (en). External Links: ISSN 0036-8075, 1095-9203, [Link](https://www.science.org/doi/10.1126/science.aau3711), [Document](https://dx.doi.org/10.1126/science.aau3711) Cited by: §3.2.

[^33]: Evolution of the Chordate Telencephalon. Current Biology 29 (13), pp. R647–R662 (en). External Links: ISSN 09609822, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0960982219305950), [Document](https://dx.doi.org/10.1016/j.cub.2019.05.026) Cited by: §3.2.

[^34]: Uncertainty-based Modulation for Lifelong Learning. Note: Publisher: arXiv Version Number: 1 External Links: [Link](https://arxiv.org/abs/2001.09822), [Document](https://dx.doi.org/10.48550/ARXIV.2001.09822) Cited by: §5.2.1, §5.6.

[^35]: Dopamine in Motivational Control: Rewarding, Aversive, and Alerting. Neuron 68 (5), pp. 815–834 (en). External Links: ISSN 08966273, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0896627310009384), [Document](https://dx.doi.org/10.1016/j.neuron.2010.11.022) Cited by: §4.2.3.

[^36]: Language Models are Few-Shot Learners. arXiv. Note: Version Number: 4Other 40+32 pages External Links: [Link](https://arxiv.org/abs/2005.14165), [Document](https://dx.doi.org/10.48550/ARXIV.2005.14165) Cited by: §5.1.

[^37]: Neuromodulation of Spike-Timing-Dependent Plasticity: Past, Present, and Future. Neuron 103 (4), pp. 563–581 (en). External Links: ISSN 08966273, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0896627319304945), [Document](https://dx.doi.org/10.1016/j.neuron.2019.05.041) Cited by: §5.2.1, §5.6.

[^38]: The impact of Parkinson’s disease on striatal network connectivity and corticostriatal drive: An in silico study. Network Neuroscience (Cambridge, Mass.) 8 (4), pp. 1149–1172 (eng). External Links: ISSN 2472-1751, [Document](https://dx.doi.org/10.1162/netn%5Fa%5F00394) Cited by: §7.1.

[^39]: Opponent control of reinforcement by striatal dopamine and serotonin. Nature 639 (8053), pp. 143–152 (en). External Links: ISSN 0028-0836, 1476-4687, [Link](https://www.nature.com/articles/s41586-024-08412-x), [Document](https://dx.doi.org/10.1038/s41586-024-08412-x) Cited by: §4.2.3.

[^40]: Dopamine and glutamate regulate striatal acetylcholine in decision-making. Nature 621 (7979), pp. 577–585 (en). External Links: ISSN 0028-0836, 1476-4687, [Link](https://www.nature.com/articles/s41586-023-06492-9), [Document](https://dx.doi.org/10.1038/s41586-023-06492-9) Cited by: 2nd item, §4.2.3.

[^41]: Drawing inspiration from biological dendrites to empower artificial neural networks. Current Opinion in Neurobiology 70, pp. 1–10 (en). External Links: ISSN 09594388, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0959438821000544), [Document](https://dx.doi.org/10.1016/j.conb.2021.04.007) Cited by: §4.2.2.

[^42]: Lifelong Machine Learning. Synthesis Lectures on Artificial Intelligence and Machine Learning, Springer International Publishing, Cham (en). External Links: ISBN 978-3-031-00453-7 978-3-031-01581-6, [Link](https://link.springer.com/10.1007/978-3-031-01581-6), [Document](https://dx.doi.org/10.1007/978-3-031-01581-6) Cited by: §1, §1.

[^43]: Reinforcement Learning with Feedback-modulated TD-STDP. arXiv. Note: Version Number: 1Other 17 pages, 4 figures External Links: [Link](https://arxiv.org/abs/2008.13044), [Document](https://dx.doi.org/10.48550/ARXIV.2008.13044) Cited by: §5.2.1, 2nd item, §6.1, §6.1, §6.

[^44]: Cognitive Inflexibility After Prefrontal Serotonin Depletion. Science 304 (5672), pp. 878–880 (en). External Links: ISSN 0036-8075, 1095-9203, [Link](https://www.science.org/doi/10.1126/science.1094987), [Document](https://dx.doi.org/10.1126/science.1094987) Cited by: §3.3.

[^45]: Voltage and spike timing interact in STDP - a unified model. Frontiers in Synaptic Neuroscience. External Links: ISSN 16633563, [Link](http://journal.frontiersin.org/article/10.3389/fnsyn.2010.00025/abstract), [Document](https://dx.doi.org/10.3389/fnsyn.2010.00025) Cited by: §4.2.3.

[^46]: Serotonergic neurons signal reward and punishment on multiple timescales. eLife 4, pp. e06346 (en). External Links: ISSN 2050-084X, [Link](https://elifesciences.org/articles/06346), [Document](https://dx.doi.org/10.7554/eLife.06346) Cited by: §4.2.3.

[^47]: Cellular, Synaptic and Network Effects of Acetylcholine in the Neocortex. Frontiers in Neural Circuits 13, pp. 24. External Links: ISSN 1662-5110, [Link](https://www.frontiersin.org/article/10.3389/fncir.2019.00024/full), [Document](https://dx.doi.org/10.3389/fncir.2019.00024) Cited by: 3rd item.

[^48]: Neuromodulation of prefrontal cortex cognitive function in primates: the powerful roles of monoamines and acetylcholine. Neuropsychopharmacology 47 (1), pp. 309–328 (en). External Links: ISSN 0893-133X, 1740-634X, [Link](https://www.nature.com/articles/s41386-021-01100-8), [Document](https://dx.doi.org/10.1038/s41386-021-01100-8) Cited by: §3.1, §4.2.3.

[^49]: Serotonin and Dopamine: Unifying Affective, Activational, and Decision Functions. Neuropsychopharmacology 36 (1), pp. 98–113 (en). External Links: ISSN 0893-133X, 1740-634X, [Link](https://www.nature.com/articles/npp2010121), [Document](https://dx.doi.org/10.1038/npp.2010.121) Cited by: §3.3, §4.2.3.

[^50]: Learning to live with Dale’s principle: ANNs with separate excitatory and inhibitory units. Neuroscience (en). External Links: [Link](http://biorxiv.org/lookup/doi/10.1101/2020.11.02.364968), [Document](https://dx.doi.org/10.1101/2020.11.02.364968) Cited by: §5.5.

[^51]: Structured flexibility in recurrent neural networks via neuromodulation. Neuroscience (en). External Links: [Link](http://biorxiv.org/lookup/doi/10.1101/2024.07.26.605315), [Document](https://dx.doi.org/10.1101/2024.07.26.605315) Cited by: §5.2.1, §5.4.

[^52]: Neural Networks and Neuroscience-Inspired Computer Vision. Current Biology 24 (18), pp. R921–R929 (en). External Links: ISSN 09609822, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0960982214010392), [Document](https://dx.doi.org/10.1016/j.cub.2014.08.026) Cited by: §5.1.

[^53]: Dynamical questions in volume transmission. Journal of Biological Dynamics 17 (1), pp. 2269986 (en). External Links: ISSN 1751-3758, 1751-3766, [Link](https://www.tandfonline.com/doi/full/10.1080/17513758.2023.2269986), [Document](https://dx.doi.org/10.1080/17513758.2023.2269986) Cited by: 2nd item.

[^54]: On out-of-distribution detection with Bayesian neural networks. arXiv. Note: Version Number: 2Other This work is an extension of our previous workshop contribution: arXiv:2107.12248 External Links: [Link](https://arxiv.org/abs/2110.06020), [Document](https://dx.doi.org/10.48550/ARXIV.2110.06020) Cited by: §2.1.

[^55]: Noradrenergic modulation of rhythmic neural activity shapes selective attention. Trends in Cognitive Sciences 26 (1), pp. 38–52 (en). External Links: ISSN 13646613, [Link](https://linkinghub.elsevier.com/retrieve/pii/S1364661321002643), [Document](https://dx.doi.org/10.1016/j.tics.2021.10.009) Cited by: §4.2.3.

[^56]: Dopamine neurons in culture express VGLUT2 explaining their capacity to release glutamate at synapses in addition to dopamine. Journal of Neurochemistry 88 (6), pp. 1398–1405 (en). External Links: ISSN 0022-3042, 1471-4159, [Link](https://onlinelibrary.wiley.com/doi/10.1046/j.1471-4159.2003.02277.x), [Document](https://dx.doi.org/10.1046/j.1471-4159.2003.02277.x) Cited by: §7.1.

[^57]: Pharmacology and Nerve-endings (Walter Ernest Dixon Memorial Lecture): (Section of Therapeutics and Pharmacology). Proceedings of the Royal Society of Medicine 28 (3), pp. 319–332 (eng). External Links: ISSN 0035-9157, [Document](https://dx.doi.org/10.1177/003591573502800330) Cited by: 1st item, §5.5.

[^58]: Exploring Neuromodulation for Dynamic Learning. Frontiers in Neuroscience 14, pp. 928. External Links: ISSN 1662-453X, [Link](https://www.frontiersin.org/article/10.3389/fnins.2020.00928/full), [Document](https://dx.doi.org/10.3389/fnins.2020.00928) Cited by: §5.2.1.

[^59]: Model-based influences on humans’ choices and striatal prediction errors. Neuron 69 (6), pp. 1204–1215 (eng). External Links: ISSN 1097-4199, [Document](https://dx.doi.org/10.1016/j.neuron.2011.02.027) Cited by: §4.2.3.

[^60]: Theoretical neuroscience: computational and mathematical modeling of neural systems. Computational neuroscience, MIT Press, Cambridge, Mass. (eng). External Links: ISBN 978-0-262-04199-7 978-0-262-54185-5 Cited by: §5.1, §6.

[^61]: Serotonin, Inhibition, and Negative Mood. PLoS Computational Biology 4 (2), pp. e4 (en). External Links: ISSN 1553-7358, [Link](https://dx.plos.org/10.1371/journal.pcbi.0040004), [Document](https://dx.doi.org/10.1371/journal.pcbi.0040004) Cited by: §3.3.

[^62]: Synthesis of models for excitable membranes, synaptic transmission and neuromodulation using a common kinetic formalism. Journal of Computational Neuroscience 1 (3), pp. 195–230 (en). External Links: ISSN 0929-5313, 1573-6873, [Link](http://link.springer.com/10.1007/BF00961734), [Document](https://dx.doi.org/10.1007/BF00961734) Cited by: §4.2.1.

[^63]: Dissociation in prefrontal cortex of affective and attentional shifts. Nature 380 (6569), pp. 69–72 (en). External Links: ISSN 0028-0836, 1476-4687, [Link](https://www.nature.com/articles/380069a0), [Document](https://dx.doi.org/10.1038/380069a0) Cited by: Table 1, Table 1, §6.

[^64]: Quantification of the dopamine innervation in adult rat neostriatum. Neuroscience 19 (2), pp. 427–445 (en). External Links: ISSN 03064522, [Link](https://linkinghub.elsevier.com/retrieve/pii/0306452286902721), [Document](https://dx.doi.org/10.1016/0306-4522%2886%2990272-1) Cited by: §4.

[^65]: Serotonergic modulation of cognitive computations. Current Opinion in Behavioral Sciences 38, pp. 116–123 (en). External Links: ISSN 23521546, [Link](https://linkinghub.elsevier.com/retrieve/pii/S2352154621000255), [Document](https://dx.doi.org/10.1016/j.cobeha.2021.02.003) Cited by: §4, §7.1.

[^66]: Metalearning and neuromodulation. Neural Networks 15 (4-6), pp. 495–506 (en). External Links: ISSN 08936080, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0893608002000448), [Document](https://dx.doi.org/10.1016/S0893-6080%2802%2900044-8) Cited by: §3.3, §3.3, §4.2.3, §5.6, 3rd item.

[^67]: Modulators of decision making. Nature Neuroscience 11 (4), pp. 410–416 (en). External Links: ISSN 1097-6256, 1546-1726, [Link](https://www.nature.com/articles/nn2077), [Document](https://dx.doi.org/10.1038/nn2077) Cited by: §3.3.

[^68]: Cholinergic and inhibitory synapses in a pathway from motor‐axon collaterals to motoneurones. The Journal of Physiology 126 (3), pp. 524–562 (en). External Links: ISSN 0022-3751, 1469-7793, [Link](https://physoc.onlinelibrary.wiley.com/doi/10.1113/jphysiol.1954.sp005226), [Document](https://dx.doi.org/10.1113/jphysiol.1954.sp005226) Cited by: 1st item, §5.5.

[^69]: Specialized coding of sensory, motor and cognitive variables in VTA dopamine neurons. Nature 570 (7762), pp. 509–513 (en). External Links: ISSN 0028-0836, 1476-4687, [Link](https://www.nature.com/articles/s41586-019-1261-9), [Document](https://dx.doi.org/10.1038/s41586-019-1261-9) Cited by: §3.3.

[^70]: Training Spiking Neural Networks Using Lessons From Deep Learning. arXiv. Note: Version Number: 6 External Links: [Link](https://arxiv.org/abs/2109.12894), [Document](https://dx.doi.org/10.48550/ARXIV.2109.12894) Cited by: §5.1.

[^71]: Towards NeuroAI: introducing neuronal diversity into artificial neural networks. Med-X 3 (1), pp. 2 (en). External Links: ISSN 2097-440X, 2731-8710, [Link](https://link.springer.com/10.1007/s44258-024-00042-2), [Document](https://dx.doi.org/10.1007/s44258-024-00042-2) Cited by: §5.4.

[^72]: Computational Models of Neuromodulation. Neural Computation 10 (4), pp. 771–805 (en). External Links: ISSN 0899-7667, 1530-888X, [Link](https://direct.mit.edu/neco/article/10/4/771-805/6151), [Document](https://dx.doi.org/10.1162/089976698300017476) Cited by: §5.2.2.

[^73]: A Genetically Encoded Fluorescent Sensor for Rapid and Specific In Vivo Detection of Norepinephrine. Neuron 102 (4), pp. 745–761.e8 (en). External Links: ISSN 08966273, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0896627319301722), [Document](https://dx.doi.org/10.1016/j.neuron.2019.02.037) Cited by: §7.1.

[^74]: Continual task learning in natural and artificial agents. Trends in Neurosciences 46 (3), pp. 199–210 (en). External Links: ISSN 01662236, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0166223622002600), [Document](https://dx.doi.org/10.1016/j.tins.2022.12.006) Cited by: §1.

[^75]: Reinforcement Learning Through Modulation of Spike-Timing-Dependent Synaptic Plasticity. Neural Computation 19 (6), pp. 1468–1502 (en). External Links: ISSN 0899-7667, 1530-888X, [Link](https://direct.mit.edu/neco/article/19/6/1468-1502/7190), [Document](https://dx.doi.org/10.1162/neco.2007.19.6.1468) Cited by: §6.1.

[^76]: By Carrot or by Stick: Cognitive Reinforcement Learning in Parkinsonism. Science 306 (5703), pp. 1940–1943 (en). External Links: ISSN 0036-8075, 1095-9203, [Link](https://www.science.org/doi/10.1126/science.1102941), [Document](https://dx.doi.org/10.1126/science.1102941) Cited by: §7.1.

[^77]: Experience-dependent representation of visual categories in parietal cortex. Nature 443 (7107), pp. 85–88 (en). External Links: ISSN 0028-0836, 1476-4687, [Link](https://www.nature.com/articles/nature05078), [Document](https://dx.doi.org/10.1038/nature05078) Cited by: §7.1.

[^78]: Neuromodulated Spike-Timing-Dependent Plasticity, and Theory of Three-Factor Learning Rules. Frontiers in Neural Circuits 9. External Links: ISSN 1662-5110, [Link](http://journal.frontiersin.org/Article/10.3389/fncir.2015.00085/abstract), [Document](https://dx.doi.org/10.3389/fncir.2015.00085) Cited by: §5.2.1, §5.4, §6.1.

[^79]: Catastrophic forgetting in connectionist networks. Trends in Cognitive Sciences 3 (4), pp. 128–135. External Links: ISSN 13646613, [Link](https://linkinghub.elsevier.com/retrieve/pii/S1364661399012942), [Document](https://dx.doi.org/10.1016/S1364-6613%2899%2901294-2) Cited by: §2.2.

[^80]: Synaptic tagging and long-term potentiation. Nature 385 (6616), pp. 533–536 (en). External Links: ISSN 0028-0836, 1476-4687, [Link](https://www.nature.com/articles/385533a0), [Document](https://dx.doi.org/10.1038/385533a0) Cited by: §4.2.3.

[^81]: Gradients of neurotransmitter receptor expression in the macaque cortex. Nature Neuroscience 26 (7), pp. 1281–1294 (en). External Links: ISSN 1097-6256, 1546-1726, [Link](https://www.nature.com/articles/s41593-023-01351-2), [Document](https://dx.doi.org/10.1038/s41593-023-01351-2) Cited by: §4.1.

[^82]: Modulation of hippocampal plasticity in learning and memory. Current Opinion in Neurobiology 75, pp. 102558 (en). External Links: ISSN 09594388, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0959438822000526), [Document](https://dx.doi.org/10.1016/j.conb.2022.102558) Cited by: §4.2.3.

[^83]: Rethinking dopamine as generalized prediction error. Proceedings of the Royal Society B: Biological Sciences 285 (1891), pp. 20181645 (en). External Links: ISSN 0962-8452, 1471-2954, [Link](https://royalsocietypublishing.org/doi/10.1098/rspb.2018.1645), [Document](https://dx.doi.org/10.1098/rspb.2018.1645) Cited by: §4.2.3.

[^84]: Neural heterogeneity controls computations in spiking neural networks. Proceedings of the National Academy of Sciences 121 (3), pp. e2311885121 (en). External Links: ISSN 0027-8424, 1091-6490, [Link](https://pnas.org/doi/10.1073/pnas.2311885121), [Document](https://dx.doi.org/10.1073/pnas.2311885121) Cited by: §5.4.

[^85]: Structure-mapping: A theoretical framework for analogy. Cognitive Science 7 (2), pp. 155–170 (en). External Links: ISSN 03640213, [Link](http://doi.wiley.com/10.1016/S0364-0213\(83\)80009-3), [Document](https://dx.doi.org/10.1016/S0364-0213%2883%2980009-3) Cited by: Table 1.

[^86]: Explaining dopamine through prediction errors and beyond. Nature Neuroscience 27 (9), pp. 1645–1655 (en). External Links: ISSN 1097-6256, 1546-1726, [Link](https://www.nature.com/articles/s41593-024-01705-4), [Document](https://dx.doi.org/10.1038/s41593-024-01705-4) Cited by: §3.3.

[^87]: Deep learning. Adaptive computation and machine learning, The MIT press, Cambridge, Mass (eng). External Links: ISBN 978-0-262-03561-3 Cited by: §5.1.

[^88]: An Empirical Investigation of Catastrophic Forgetting in Gradient-Based Neural Networks. arXiv. Note: Version Number: 3 External Links: [Link](https://arxiv.org/abs/1312.6211), [Document](https://dx.doi.org/10.48550/ARXIV.1312.6211) Cited by: §1, §2.1.

[^89]: Bio-instantiated recurrent neural networks: Integrating neurobiology-based network topology in artificial networks. Neural Networks 142, pp. 608–618 (en). External Links: ISSN 08936080, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0893608021002744), [Document](https://dx.doi.org/10.1016/j.neunet.2021.07.011) Cited by: §5.6.

[^90]: Dysregulation of the dopamine system in the pathophysiology of schizophrenia and depression. Nature Reviews Neuroscience 17 (8), pp. 524–532 (en). External Links: ISSN 1471-003X, 1471-0048, [Link](https://www.nature.com/articles/nrn.2016.57), [Document](https://dx.doi.org/10.1038/nrn.2016.57) Cited by: §4.2.3.

[^91]: Striosomes and Matrisomes: Scaffolds for Dynamic Coupling of Volition and Action. Annual Review of Neuroscience 46 (1), pp. 359–380 (en). External Links: ISSN 0147-006X, 1545-4126, [Link](https://www.annualreviews.org/doi/10.1146/annurev-neuro-121522-025740), [Document](https://dx.doi.org/10.1146/annurev-neuro-121522-025740) Cited by: §4.1.

[^92]: Habits, Rituals, and the Evaluative Brain. Annual Review of Neuroscience 31 (1), pp. 359–387 (en). External Links: ISSN 0147-006X, 1545-4126, [Link](https://www.annualreviews.org/doi/10.1146/annurev.neuro.29.051605.112851), [Document](https://dx.doi.org/10.1146/annurev.neuro.29.051605.112851) Cited by: §4.1, §4.2.3.

[^93]: Single-phase deep learning in cortico-cortical networks. arXiv. Note: Version Number: 2Other Accepted to 36th Conference on Neural Information Processing Systems (NeurIPS 2022). 22 pages, 9 figures, 5 tables External Links: [Link](https://arxiv.org/abs/2206.11769), [Document](https://dx.doi.org/10.48550/ARXIV.2206.11769) Cited by: §5.4.

[^94]: Neuromodulation and Neurophysiology on the Timescale of Learning and Decision-Making. Annual Review of Neuroscience 45 (1), pp. 317–337 (en). External Links: ISSN 0147-006X, 1545-4126, [Link](https://www.annualreviews.org/doi/10.1146/annurev-neuro-092021-125059), [Document](https://dx.doi.org/10.1146/annurev-neuro-092021-125059) Cited by: §2.2, §3.1, §4.1, §4.2.3, §7.1.

[^95]: Histamine in the Nervous System. Physiological Reviews 88 (3), pp. 1183–1241 (en). External Links: ISSN 0031-9333, 1522-1210, [Link](https://www.physiology.org/doi/10.1152/physrev.00043.2007), [Document](https://dx.doi.org/10.1152/physrev.00043.2007) Cited by: §4.2.1.

[^96]: Adapting to time: Why nature may have evolved a diverse set of neurons. PLOS Computational Biology 20 (12), pp. e1012673 (en). External Links: ISSN 1553-7358, [Link](https://dx.plos.org/10.1371/journal.pcbi.1012673), [Document](https://dx.doi.org/10.1371/journal.pcbi.1012673) Cited by: §5.4.

[^97]: Embracing Change: Continual Learning in Deep Neural Networks. Trends in Cognitive Sciences 24 (12), pp. 1028–1040 (en). External Links: ISSN 13646613, [Link](https://linkinghub.elsevier.com/retrieve/pii/S1364661320302199), [Document](https://dx.doi.org/10.1016/j.tics.2020.09.004) Cited by: §1, §2.1, §2.2.

[^98]: Milestones of progression in myotonic dystrophy type 1 and type 2. Muscle & Nerve 66 (4), pp. 508–512 (en). External Links: ISSN 0148-639X, 1097-4598, [Link](https://onlinelibrary.wiley.com/doi/10.1002/mus.27674), [Document](https://dx.doi.org/10.1002/mus.27674) Cited by: §3.2.

[^99]: Wave-like dopamine dynamics as a mechanism for spatiotemporal credit assignment. Cell 184 (10), pp. 2733–2749.e16 (en). External Links: ISSN 00928674, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0092867421003779), [Document](https://dx.doi.org/10.1016/j.cell.2021.03.046) Cited by: 2nd item.

[^100]: Mapping neurotransmitter systems to the structural and functional organization of the human neocortex. Nature Neuroscience 25 (11), pp. 1569–1581 (english). External Links: [Document](https://dx.doi.org/10.1038/s41593-022-01186-3), [Link](https://www.nature.com/articles/s41593-022-01186-3), ISSN 1097-6256, 1546-1726 Cited by: §4.1, §5.6.

[^101]: The formation of learning sets.. Psychological Review 56 (1), pp. 51–65 (en). External Links: ISSN 1939-1471, 0033-295X, [Link](https://doi.apa.org/doi/10.1037/h0062474), [Document](https://dx.doi.org/10.1037/h0062474) Cited by: Table 1.

[^102]: Transfer of learning: cognition, instruction, and reasoning. Transferred to digital print edition, Educational psychology series, Academic Press, San Diego, Calif. (eng). External Links: ISBN 978-0-12-330595-4 Cited by: Table 1.

[^103]: Neuroscience-Inspired Artificial Intelligence. Neuron 95 (2), pp. 245–258 (en). External Links: ISSN 08966273, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0896627317305093), [Document](https://dx.doi.org/10.1016/j.neuron.2017.06.011) Cited by: §1, §3.3.

[^104]: Noradrenergic alpha-2a receptor stimulation enhances prediction error signaling and updating of attention sets in anterior cingulate cortex and striatum. Nature Communications 15 (1), pp. 9905 (en). External Links: ISSN 2041-1723, [Link](https://www.nature.com/articles/s41467-024-54395-8), [Document](https://dx.doi.org/10.1038/s41467-024-54395-8) Cited by: §3.3.

[^105]: The Unexplored Territory of Neural Models: Potential Guides for Exploring the Function of Metabotropic Neuromodulation. Neuroscience 456, pp. 143–158 (en). External Links: ISSN 03064522, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0306452220302141), [Document](https://dx.doi.org/10.1016/j.neuroscience.2020.03.048) Cited by: §4.2.1, §4.2.1, §5.4.

[^106]: High acetylcholine levels set circuit dynamics for attention and encoding and low acetylcholine levels set dynamics for consolidation. In Progress in Brain Research, Vol. 145, pp. 207–231 (en). External Links: ISBN 978-0-444-51125-6, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0079612303450152), [Document](https://dx.doi.org/10.1016/S0079-6123%2803%2945015-2) Cited by: §3.3, §4.2.3.

[^107]: The role of acetylcholine in learning and memory. Current Opinion in Neurobiology 16 (6), pp. 710–715 (en). External Links: ISSN 09594388, [Link](https://linkinghub.elsevier.com/retrieve/pii/S095943880600122X), [Document](https://dx.doi.org/10.1016/j.conb.2006.09.002) Cited by: §3.3, §4.2.1, §4.2.3.

[^108]: Meta-reinforcement learning via orbitofrontal cortex. Nature Neuroscience 26 (12), pp. 2182–2191 (en). External Links: ISSN 1097-6256, 1546-1726, [Link](https://www.nature.com/articles/s41593-023-01485-3), [Document](https://dx.doi.org/10.1038/s41593-023-01485-3) Cited by: §3.3.

[^109]: What are the mechanisms underlying metacognitive learning?. arXiv. Note: Version Number: 1 External Links: [Link](https://arxiv.org/abs/2302.04840), [Document](https://dx.doi.org/10.48550/ARXIV.2302.04840) Cited by: Table 1.

[^110]: A model of working memory for latent representations. Nature Human Behaviour 6 (5), pp. 709–719 (en). External Links: ISSN 2397-3374, [Link](https://www.nature.com/articles/s41562-021-01264-9), [Document](https://dx.doi.org/10.1038/s41562-021-01264-9) Cited by: §5.1.

[^111]: Theoretical models of synaptic short term plasticity. Frontiers in Computational Neuroscience 7. External Links: ISSN 1662-5188, [Link](http://journal.frontiersin.org/article/10.3389/fncom.2013.00154/abstract), [Document](https://dx.doi.org/10.3389/fncom.2013.00154) Cited by: §4.2.1.

[^112]: The habenula: from stress evasion to value-based decision-making. Nature Reviews Neuroscience 11 (7), pp. 503–513 (en). External Links: ISSN 1471-003X, 1471-0048, [Link](https://www.nature.com/articles/nrn2866), [Document](https://dx.doi.org/10.1038/nrn2866) Cited by: §4.2.3.

[^113]: Learning to Modulate Random Weights: Neuromodulation-inspired Neural Networks For Efficient Continual Learning. arXiv. Note: Version Number: 2Other 13 pages, 13 figures, 5 tables External Links: [Link](https://arxiv.org/abs/2204.04297), [Document](https://dx.doi.org/10.48550/ARXIV.2204.04297) Cited by: §5.2.1.

[^114]: Universal Language Model Fine-tuning for Text Classification. arXiv. Note: Version Number: 5Other ACL 2018, fixed denominator in Equation 3, line 3 External Links: [Link](https://arxiv.org/abs/1801.06146), [Document](https://dx.doi.org/10.48550/ARXIV.1801.06146) Cited by: §5.1.

[^115]: A neural model of schemas and memory encoding. Biological Cybernetics 114 (2), pp. 169–186 (en). External Links: ISSN 0340-1200, 1432-0770, [Link](http://link.springer.com/10.1007/s00422-019-00808-7), [Document](https://dx.doi.org/10.1007/s00422-019-00808-7) Cited by: §5.2.1.

[^116]: Long-lasting depression of parallel fiber-Purkinje cell transmission induced by conjunctive stimulation of parallel fibers and climbing fibers in the cerebellar cortex. Neuroscience Letters 33 (3), pp. 253–258 (en). External Links: ISSN 03043940, [Link](https://linkinghub.elsevier.com/retrieve/pii/0304394082903809), [Document](https://dx.doi.org/10.1016/0304-3940%2882%2990380-9) Cited by: §7.1.

[^117]: Neuromorphic artificial intelligence systems. Frontiers in Neuroscience 16, pp. 959626. External Links: ISSN 1662-453X, [Link](https://www.frontiersin.org/articles/10.3389/fnins.2022.959626/full), [Document](https://dx.doi.org/10.3389/fnins.2022.959626) Cited by: §5.1.

[^118]: Avoiding Catastrophe: Active Dendrites Enable Multi-Task Learning in Dynamic Environments. Frontiers in Neurorobotics 16, pp. 846219. External Links: ISSN 1662-5218, [Link](https://www.frontiersin.org/articles/10.3389/fnbot.2022.846219/full), [Document](https://dx.doi.org/10.3389/fnbot.2022.846219) Cited by: §5.4.

[^119]: Which Model to Use for Cortical Spiking Neurons?. IEEE Transactions on Neural Networks 15 (5), pp. 1063–1070 (en). External Links: ISSN 1045-9227, [Link](http://ieeexplore.ieee.org/document/1333071/), [Document](https://dx.doi.org/10.1109/TNN.2004.832719) Cited by: §5.4.

[^120]: Solving the distal reward problem through linkage of STDP and dopamine signaling. BMC Neuroscience 8 (S2), pp. S15 (en). External Links: ISSN 1471-2202, [Link](https://bmcneurosci.biomedcentral.com/articles/10.1186/1471-2202-8-S2-S15), [Document](https://dx.doi.org/10.1186/1471-2202-8-S2-S15) Cited by: §6.1.

[^121]: Shaping action sequences in basal ganglia circuits. Current Opinion in Neurobiology 33, pp. 188–196 (en). External Links: ISSN 09594388, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0959438815001051), [Document](https://dx.doi.org/10.1016/j.conb.2015.06.011) Cited by: 1st item.

[^122]: Dendritic mechanisms controlling spike-timing-dependent synaptic plasticity. Trends in Neurosciences 30 (9), pp. 456–463 (en). External Links: ISSN 01662236, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0166223607001798), [Document](https://dx.doi.org/10.1016/j.tins.2007.06.010) Cited by: §4.2.2.

[^123]: Objective Morphological Classification of Neocortical Pyramidal Cells. Cerebral Cortex 29 (4), pp. 1719–1735 (en). External Links: ISSN 1047-3211, 1460-2199, [Link](https://academic.oup.com/cercor/article/29/4/1719/5304727), [Document](https://dx.doi.org/10.1093/cercor/bhy339) Cited by: §5.4.

[^124]: The Biological Basis of Learning and Individuality. Scientific American 267 (3), pp. 78–86. External Links: ISSN 0036-8733, [Link](https://www.scientificamerican.com/article/the-biological-basis-of-learning-an), [Document](https://dx.doi.org/10.1038/scientificamerican0992-78) Cited by: §1.

[^125]: Considerations in using recurrent neural networks to probe neural dynamics. Journal of Neurophysiology 122 (6), pp. 2504–2521 (en). External Links: ISSN 0022-3077, 1522-1598, [Link](https://www.physiology.org/doi/10.1152/jn.00467.2018), [Document](https://dx.doi.org/10.1152/jn.00467.2018) Cited by: §5.5.

[^126]: Linking Memories across Time via Neuronal and Dendritic Overlaps in Model Neurons with Active Dendrites. Cell Reports 17 (6), pp. 1491–1504 (en). External Links: ISSN 22111247, [Link](https://linkinghub.elsevier.com/retrieve/pii/S2211124716314012), [Document](https://dx.doi.org/10.1016/j.celrep.2016.10.015) Cited by: 3rd item.

[^127]: Diversity of ancestral brainstem noradrenergic neurons across species and multiple biological factors. Neuroscience (en). External Links: [Link](http://biorxiv.org/lookup/doi/10.1101/2024.10.14.618224), [Document](https://dx.doi.org/10.1101/2024.10.14.618224) Cited by: §7.2.2.

[^128]: Learning to Learn Causal Models. Cognitive Science 34 (7), pp. 1185–1243 (en). External Links: ISSN 0364-0213, 1551-6709, [Link](https://onlinelibrary.wiley.com/doi/10.1111/j.1551-6709.2010.01128.x), [Document](https://dx.doi.org/10.1111/j.1551-6709.2010.01128.x) Cited by: §7.

[^129]: Dopamine release from the locus coeruleus to the dorsal hippocampus promotes spatial learning and memory. Proceedings of the National Academy of Sciences 113 (51), pp. 14835–14840 (en). External Links: ISSN 0027-8424, 1091-6490, [Link](https://pnas.org/doi/full/10.1073/pnas.1616515114), [Document](https://dx.doi.org/10.1073/pnas.1616515114) Cited by: 1st item.

[^130]: Deep Supervised, but Not Unsupervised, Models May Explain IT Cortical Representation. PLoS Computational Biology 10 (11), pp. e1003915 (en). External Links: ISSN 1553-7358, [Link](https://dx.plos.org/10.1371/journal.pcbi.1003915), [Document](https://dx.doi.org/10.1371/journal.pcbi.1003915) Cited by: §4.2.3, §5.1.

[^131]: Biologically-Informed Excitatory and Inhibitory Balance for Robust Spiking Neural Network Training. arXiv. Note: Version Number: 1 External Links: [Link](https://arxiv.org/abs/2404.15627), [Document](https://dx.doi.org/10.48550/ARXIV.2404.15627) Cited by: §5.5.

[^132]: Dopamine Release Plateau and Outcome Signals in Dorsal Striatum Contrast with Classic Reinforcement Learning Formulations. Neuroscience (en). External Links: [Link](http://biorxiv.org/lookup/doi/10.1101/2023.08.15.553421), [Document](https://dx.doi.org/10.1101/2023.08.15.553421) Cited by: §3.3.

[^133]: Overcoming catastrophic forgetting in neural networks. Proceedings of the National Academy of Sciences 114 (13), pp. 3521–3526 (en). External Links: ISSN 0027-8424, 1091-6490, [Link](https://pnas.org/doi/full/10.1073/pnas.1611835114), [Document](https://dx.doi.org/10.1073/pnas.1611835114) Cited by: §2.1.

[^134]: Two Neuropeptides Colocalized in a Command-Like Neuron Use Distinct Mechanisms to Enhance Its Fast Synaptic Connection. Journal of Neurophysiology 90 (3), pp. 2074–2079 (en). External Links: ISSN 0022-3077, 1522-1598, [Link](https://www.physiology.org/doi/10.1152/jn.00358.2003), [Document](https://dx.doi.org/10.1152/jn.00358.2003) Cited by: §5.5.

[^135]: Transient activation of inferior prefrontal cortex during cognitive set shifting. Nature Neuroscience 1 (1), pp. 80–84 (en). External Links: ISSN 1097-6256, 1546-1726, [Link](https://www.nature.com/articles/nn0598_80), [Document](https://dx.doi.org/10.1038/283) Cited by: Table 1, Table 1, §6.

[^136]: Building transformers from neurons and astrocytes. Proceedings of the National Academy of Sciences 120 (34), pp. e2219150120 (en). External Links: ISSN 0027-8424, 1091-6490, [Link](https://pnas.org/doi/10.1073/pnas.2219150120), [Document](https://dx.doi.org/10.1073/pnas.2219150120) Cited by: §5.1.

[^137]: The Neuromodulatory System: A Framework for Survival and Adaptive Behavior in a Challenging World. Adaptive Behavior 16 (6), pp. 385–399 (en). External Links: ISSN 1059-7123, 1741-2633, [Link](https://journals.sagepub.com/doi/10.1177/1059712308095775), [Document](https://dx.doi.org/10.1177/1059712308095775) Cited by: §4.2.1, §5.6.

[^138]: Intrinsic dopamine and acetylcholine dynamics in the striatum of mice. Nature 621 (7979), pp. 543–549 (en). External Links: ISSN 0028-0836, 1476-4687, [Link](https://www.nature.com/articles/s41586-023-05995-9), [Document](https://dx.doi.org/10.1038/s41586-023-05995-9) Cited by: §4.2.3.

[^139]: Brain-Like Object Recognition with High-Performing Shallow Recurrent ANNs. arXiv. Note: Version Number: 2Other NeurIPS 2019 (Oral). Code available at https://github.com/dicarlolab/neurips2019 External Links: [Link](https://arxiv.org/abs/1909.06161), [Document](https://dx.doi.org/10.48550/ARXIV.1909.06161) Cited by: §5.1.

[^140]: Biological underpinnings for lifelong learning machines. Nature Machine Intelligence 4 (3), pp. 196–210 (en). External Links: ISSN 2522-5839, [Link](https://www.nature.com/articles/s42256-022-00452-0), [Document](https://dx.doi.org/10.1038/s42256-022-00452-0) Cited by: §1, §1, §2.1, §2.1, §2.1, §2.2, §3.3, §7.2.2.

[^141]: Learning with three factors: modulating Hebbian plasticity with errors. Current Opinion in Neurobiology 46, pp. 170–177 (en). External Links: ISSN 09594388, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0959438817300612), [Document](https://dx.doi.org/10.1016/j.conb.2017.08.020) Cited by: §5.2.1.

[^142]: Stochastic Wiring of Cell Types Enhances Fitness by Generating Phenotypic Variability. Neuroscience (en). External Links: [Link](http://biorxiv.org/lookup/doi/10.1101/2024.08.07.606541), [Document](https://dx.doi.org/10.1101/2024.08.07.606541) Cited by: §5.5.

[^143]: Differential role for the striatum and cerebellum in response to novel movements using a motor learning paradigm. Neuropsychologia 40 (5), pp. 512–517 (en). External Links: ISSN 00283932, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0028393201001282), [Document](https://dx.doi.org/10.1016/S0028-3932%2801%2900128-2) Cited by: §2.2.

[^144]: Building machines that learn and think like people. Behavioral and Brain Sciences 40, pp. e253 (en). External Links: ISSN 0140-525X, 1469-1825, [Link](https://www.cambridge.org/core/product/identifier/S0140525X16001837/type/journal_article), [Document](https://dx.doi.org/10.1017/S0140525X16001837) Cited by: §7.

[^145]: Reward and aversion in a heterogeneous midbrain dopamine system. Neuropharmacology 76, pp. 351–359 (en). External Links: ISSN 00283908, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0028390813001159), [Document](https://dx.doi.org/10.1016/j.neuropharm.2013.03.019) Cited by: §4.2.3.

[^146]: Model-based predictions for dopamine. Current Opinion in Neurobiology 49, pp. 1–7 (en). External Links: ISSN 09594388, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0959438817301563), [Document](https://dx.doi.org/10.1016/j.conb.2017.10.006) Cited by: §4.2.3.

[^147]: A review on neural network models of schizophrenia and autism spectrum disorder. Neural Networks 122, pp. 338–363 (en). External Links: ISSN 08936080, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0893608019303363), [Document](https://dx.doi.org/10.1016/j.neunet.2019.10.014) Cited by: §7.1.

[^148]: Deep learning. Nature 521 (7553), pp. 436–444 (en). External Links: ISSN 0028-0836, 1476-4687, [Link](https://www.nature.com/articles/nature14539), [Document](https://dx.doi.org/10.1038/nature14539) Cited by: §5.1.

[^149]: Dopamine facilitates associative memory encoding in the entorhinal cortex. Nature 598 (7880), pp. 321–326 (en). External Links: ISSN 0028-0836, 1476-4687, [Link](https://www.nature.com/articles/s41586-021-03948-8), [Document](https://dx.doi.org/10.1038/s41586-021-03948-8) Cited by: §3.3, §4.2.3.

[^150]: Lifelong Reinforcement Learning via Neuromodulation. arXiv. Note: Version Number: 2 External Links: [Link](https://arxiv.org/abs/2408.08446), [Document](https://dx.doi.org/10.48550/ARXIV.2408.08446) Cited by: §3.3, §5.6.

[^151]: Role of ACh-GABA Cotransmission in Detecting Image Motion and Motion Direction. Neuron 68 (6), pp. 1159–1172 (en). External Links: ISSN 08966273, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0896627310009736), [Document](https://dx.doi.org/10.1016/j.neuron.2010.11.031) Cited by: 1st item.

[^152]: Dopamine, Updated: Reward Prediction Error and Beyond. Current Opinion in Neurobiology 67, pp. 123–130 (en). External Links: ISSN 09594388, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0959438820301501), [Document](https://dx.doi.org/10.1016/j.conb.2020.10.012) Cited by: §3.3.

[^153]: Robust neuronal dynamics in premotor cortex during motor planning. Nature 532 (7600), pp. 459–464 (en). External Links: ISSN 0028-0836, 1476-4687, [Link](https://www.nature.com/articles/nature17643), [Document](https://dx.doi.org/10.1038/nature17643) Cited by: §7.1.

[^154]: Learning better with Dale’s Law: A Spectral Perspective. Neuroscience (en). External Links: [Link](http://biorxiv.org/lookup/doi/10.1101/2023.06.28.546924), [Document](https://dx.doi.org/10.1101/2023.06.28.546924) Cited by: §5.5.

[^155]: Neuromodulation in circuits of aversive emotional learning. Nature Neuroscience 22 (10), pp. 1586–1597 (en). External Links: ISSN 1097-6256, 1546-1726, [Link](https://www.nature.com/articles/s41593-019-0503-3), [Document](https://dx.doi.org/10.1038/s41593-019-0503-3) Cited by: §4.1, §4.2.3.

[^156]: Emergence of Stable Synaptic Clusters on Dendrites Through Synaptic Rewiring. Frontiers in Computational Neuroscience 14, pp. 57. External Links: ISSN 1662-5188, [Link](https://www.frontiersin.org/article/10.3389/fncom.2020.00057/full), [Document](https://dx.doi.org/10.3389/fncom.2020.00057) Cited by: 3rd item.

[^157]: Images with harder-to-reconstruct visual representations leave stronger memory traces. Nature Human Behaviour 8 (7), pp. 1309–1320 (en). External Links: ISSN 2397-3374, [Link](https://www.nature.com/articles/s41562-024-01870-3), [Document](https://dx.doi.org/10.1038/s41562-024-01870-3) Cited by: §5.1.

[^158]: Basal Ganglia Neuromodulation Over Multiple Temporal and Structural Scales—Simulations of Direct Pathway MSNs Investigate the Fast Onset of Dopaminergic Effects and Predict the Role of Kv4.2. Frontiers in Neural Circuits 12, pp. 3. External Links: ISSN 1662-5110, [Link](http://journal.frontiersin.org/article/10.3389/fncir.2018.00003/full), [Document](https://dx.doi.org/10.3389/fncir.2018.00003) Cited by: §7.1.

[^159]: The Hippocampal-VTA Loop: Controlling the Entry of Information into Long-Term Memory. Neuron 46 (5), pp. 703–713 (en). External Links: ISSN 08966273, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0896627305003971), [Document](https://dx.doi.org/10.1016/j.neuron.2005.05.002) Cited by: §4.2.3.

[^160]: An action potential initiation mechanism in distal axons for the control of dopamine release. Science 375 (6587), pp. 1378–1385 (en). External Links: ISSN 0036-8075, 1095-9203, [Link](https://www.science.org/doi/10.1126/science.abn0532), [Document](https://dx.doi.org/10.1126/science.abn0532) Cited by: §5.2.1.

[^161]: Cell-type–specific neuromodulation guides synaptic credit assignment in a spiking neural network. Proceedings of the National Academy of Sciences 118 (51), pp. e2111821118 (en). External Links: ISSN 0027-8424, 1091-6490, [Link](https://pnas.org/doi/full/10.1073/pnas.2111821118), [Document](https://dx.doi.org/10.1073/pnas.2111821118) Cited by: §5.2.1, §5.2.1.

[^162]: Neurochemistry of Visual Attention. Frontiers in Neuroscience 15, pp. 643597. External Links: ISSN 1662-453X, [Link](https://www.frontiersin.org/articles/10.3389/fnins.2021.643597/full), [Document](https://dx.doi.org/10.3389/fnins.2021.643597) Cited by: §4.2.3.

[^163]: Context-dependent computation by recurrent dynamics in prefrontal cortex. Nature 503 (7474), pp. 78–84 (en). External Links: ISSN 0028-0836, 1476-4687, [Link](https://www.nature.com/articles/nature12742), [Document](https://dx.doi.org/10.1038/nature12742) Cited by: §7.1.

[^164]: Neuromodulation of Neuronal Circuits: Back to the Future. Neuron 76 (1), pp. 1–11 (en). External Links: ISSN 08966273, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0896627312008173), [Document](https://dx.doi.org/10.1016/j.neuron.2012.09.010) Cited by: §3.1, §3.1, §3, §5.6.

[^165]: Reconstruction and Simulation of Neocortical Microcircuitry. Cell 163 (2), pp. 456–492 (en). External Links: ISSN 00928674, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0092867415011915), [Document](https://dx.doi.org/10.1016/j.cell.2015.09.029) Cited by: §5.5.

[^166]: Interneurons of the neocortical inhibitory system. Nature Reviews Neuroscience 5 (10), pp. 793–807 (en). External Links: ISSN 1471-003X, 1471-0048, [Link](https://www.nature.com/articles/nrn1519), [Document](https://dx.doi.org/10.1038/nrn1519) Cited by: §5.4.

[^167]: A theory of cerebellar cortex. The Journal of Physiology 202 (2), pp. 437–470 (en). External Links: ISSN 0022-3751, 1469-7793, [Link](https://physoc.onlinelibrary.wiley.com/doi/10.1113/jphysiol.1969.sp008820), [Document](https://dx.doi.org/10.1113/jphysiol.1969.sp008820) Cited by: §7.1.

[^168]: Acetylcholine waves and dopamine release in the striatum. Nature Communications 14 (1), pp. 6852 (en). External Links: ISSN 2041-1723, [Link](https://www.nature.com/articles/s41467-023-42311-5), [Document](https://dx.doi.org/10.1038/s41467-023-42311-5) Cited by: 2nd item, 2nd item, §4, §5.6, §7.1.

[^169]: Single Nigrostriatal Dopaminergic Neurons Form Widely Spread and Highly Dense Axonal Arborizations in the Neostriatum. The Journal of Neuroscience 29 (2), pp. 444–453 (en). External Links: ISSN 0270-6474, 1529-2401, [Link](https://www.jneurosci.org/lookup/doi/10.1523/JNEUROSCI.4029-08.2009), [Document](https://dx.doi.org/10.1523/JNEUROSCI.4029-08.2009) Cited by: §4.

[^170]: Two types of dopamine neuron distinctly convey positive and negative motivational signals. Nature 459 (7248), pp. 837–841 (en). External Links: ISSN 0028-0836, 1476-4687, [Link](https://www.nature.com/articles/nature08028), [Document](https://dx.doi.org/10.1038/nature08028) Cited by: §3.3.

[^171]: Locus coeruleus-norepinephrine modulation of sensory processing and perception: A focused review. Neuroscience & Biobehavioral Reviews 105, pp. 190–199 (en). External Links: ISSN 01497634, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0149763418309771), [Document](https://dx.doi.org/10.1016/j.neubiorev.2019.06.009) Cited by: §3.1.

[^172]: Catastrophic Interference in Connectionist Networks: The Sequential Learning Problem. In Psychology of Learning and Motivation, Vol. 24, pp. 109–165 (en). External Links: ISBN 978-0-12-543324-2, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0079742108605368), [Document](https://dx.doi.org/10.1016/S0079-7421%2808%2960536-8) Cited by: §1, §2.1.

[^173]: Effects of neuromodulation-inspired mechanisms on the performance of deep neural networks in a spatial learning task. iScience 26 (2), pp. 106026 (en). External Links: ISSN 25890042, [Link](https://linkinghub.elsevier.com/retrieve/pii/S2589004223001037), [Document](https://dx.doi.org/10.1016/j.isci.2023.106026) Cited by: §5.2.1, §5.6, §5.6, §7.2.1.

[^174]: Informing deep neural networks by multiscale principles of neuromodulatory systems. Trends in Neurosciences 45 (3), pp. 237–250 (en). External Links: ISSN 01662236, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0166223621002563), [Document](https://dx.doi.org/10.1016/j.tins.2021.12.008) Cited by: §3.1, §3.3, §3, §5.6.

[^175]: Dopamine neurons projecting to the posterior striatum reinforce avoidance of threatening stimuli. Nature Neuroscience 21 (10), pp. 1421–1430 (en). External Links: ISSN 1097-6256, 1546-1726, [Link](https://www.nature.com/articles/s41593-018-0222-1), [Document](https://dx.doi.org/10.1038/s41593-018-0222-1) Cited by: §3.3.

[^176]: Neocortical catastrophic interference in healthy and amnesic adults: A paradoxical matter of time. Hippocampus 24 (12), pp. 1653–1662 (en). External Links: ISSN 1050-9631, 1098-1063, [Link](https://onlinelibrary.wiley.com/doi/10.1002/hipo.22353), [Document](https://dx.doi.org/10.1002/hipo.22353) Cited by: §2.2.

[^177]: Look-Ahead Selective Plasticity for Continual Learning of Visual Tasks. arXiv. Note: Version Number: 1 External Links: [Link](https://arxiv.org/abs/2311.01617), [Document](https://dx.doi.org/10.48550/ARXIV.2311.01617) Cited by: §5.2.1.

[^178]: Backpropamine: training self-modifying neural networks with differentiable neuromodulated plasticity. Note: Publisher: arXiv Version Number: 1Other Presented at the 7th International Conference on Learning Representations (ICLR 2019) External Links: [Link](https://arxiv.org/abs/2002.10585), [Document](https://dx.doi.org/10.48550/ARXIV.2002.10585) Cited by: §5.2.1, §5.2.1.

[^179]: Learning to acquire novel cognitive tasks with evolution, plasticity and meta-meta-learning. Note: Publisher: arXiv Version Number: 10 External Links: [Link](https://arxiv.org/abs/2112.08588), [Document](https://dx.doi.org/10.48550/ARXIV.2112.08588) Cited by: §5.2.1.

[^180]: A re-examination of the effects of frontal lesions on object alternation. Neuropsychologia 7 (4), pp. 357–363 (en). External Links: ISSN 00283932, [Link](https://linkinghub.elsevier.com/retrieve/pii/0028393269900608), [Document](https://dx.doi.org/10.1016/0028-3932%2869%2990060-8) Cited by: Table 1.

[^181]: Dopamine Receptors: From Structure to Function. Physiological Reviews 78 (1), pp. 189–225 (en). External Links: ISSN 0031-9333, 1522-1210, [Link](https://www.physiology.org/doi/10.1152/physrev.1998.78.1.189), [Document](https://dx.doi.org/10.1152/physrev.1998.78.1.189) Cited by: §4.2.1.

[^182]: Scalable training of artificial neural networks with adaptive sparse connectivity inspired by network science. Nature Communications 9 (1), pp. 2383 (en). External Links: ISSN 2041-1723, [Link](https://www.nature.com/articles/s41467-018-04316-3), [Document](https://dx.doi.org/10.1038/s41467-018-04316-3) Cited by: §5.5, §5.6.

[^183]: Induction of Long-Term Memory by Exposure to Novelty Requires Protein Synthesis: Evidence for a Behavioral Tagging. The Journal of Neuroscience 27 (28), pp. 7476–7481 (en). External Links: ISSN 0270-6474, 1529-2401, [Link](https://www.jneurosci.org/lookup/doi/10.1523/JNEUROSCI.1083-07.2007), [Document](https://dx.doi.org/10.1523/JNEUROSCI.1083-07.2007) Cited by: §4.2.3.

[^184]: Computational psychiatry. Trends in Cognitive Sciences 16 (1), pp. 72–80 (en). External Links: ISSN 13646613, [Link](https://linkinghub.elsevier.com/retrieve/pii/S1364661311002518), [Document](https://dx.doi.org/10.1016/j.tics.2011.11.018) Cited by: §3.3, §7.1.

[^185]: The Role of Temporal Hierarchy in Spiking Neural Networks. arXiv. Note: Version Number: 1Other 16 pages, 9 figures, pre-print External Links: [Link](https://arxiv.org/abs/2407.18838), [Document](https://dx.doi.org/10.48550/ARXIV.2407.18838) Cited by: §5.4.

[^186]: Cerebellar Contributions to Locomotor Adaptations during Splitbelt Treadmill Walking. The Journal of Neuroscience 26 (36), pp. 9107–9116 (en). External Links: ISSN 0270-6474, 1529-2401, [Link](https://www.jneurosci.org/lookup/doi/10.1523/JNEUROSCI.2622-06.2006), [Document](https://dx.doi.org/10.1523/JNEUROSCI.2622-06.2006) Cited by: §2.2.

[^187]: Transformers and cortical waves: encoders for pulling in context across time. Trends in Neurosciences 47 (10), pp. 788–802 (en). External Links: ISSN 01662236, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0166223624001498), [Document](https://dx.doi.org/10.1016/j.tins.2024.08.006) Cited by: §5.1.

[^188]: Neuronal connected burst cascades bridge macroscale adaptive signatures across arousal states. Nature Communications 14 (1), pp. 6846 (en). External Links: ISSN 2041-1723, [Link](https://www.nature.com/articles/s41467-023-42465-2), [Document](https://dx.doi.org/10.1038/s41467-023-42465-2) Cited by: 2nd item, 3rd item, §6, §7.1.

[^189]: Neuromodulation of neurons and synapses. Current Opinion in Neurobiology 29, pp. 48–56 (en). External Links: ISSN 09594388, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0959438814001044), [Document](https://dx.doi.org/10.1016/j.conb.2014.05.003) Cited by: §3.1, §3.1, §5.5.

[^190]: Reinforcement learning in artificial and biological systems. Nature Machine Intelligence 1 (3), pp. 133–143 (en). External Links: ISSN 2522-5839, [Link](https://www.nature.com/articles/s42256-019-0025-4), [Document](https://dx.doi.org/10.1038/s42256-019-0025-4) Cited by: §1, §2.2.

[^191]: Tonic dopamine: opportunity costs and the control of response vigor. Psychopharmacology 191 (3), pp. 507–520 (en). External Links: ISSN 0033-3158, 1432-2072, [Link](http://link.springer.com/10.1007/s00213-006-0502-4), [Document](https://dx.doi.org/10.1007/s00213-006-0502-4) Cited by: §3.3.

[^192]: Locus coeruleus integrity and the effect of atomoxetine on response inhibition in Parkinson’s disease. Brain 144 (8), pp. 2513–2526 (en). External Links: ISSN 0006-8950, 1460-2156, [Link](https://academic.oup.com/brain/article/144/8/2513/6203808), [Document](https://dx.doi.org/10.1093/brain/awab142) Cited by: §3.2.

[^193]: Mechanisms of neuromodulatory volume transmission. Molecular Psychiatry 29 (11), pp. 3680–3693 (en). External Links: ISSN 1359-4184, 1476-5578, [Link](https://www.nature.com/articles/s41380-024-02608-3), [Document](https://dx.doi.org/10.1038/s41380-024-02608-3) Cited by: 3rd item.

[^194]: Leveraging dendritic properties to advance machine learning and neuro-inspired computing. Current Opinion in Neurobiology 85, pp. 102853 (en). External Links: ISSN 09594388, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0959438824000151), [Document](https://dx.doi.org/10.1016/j.conb.2024.102853) Cited by: 3rd item, §4.2.2, §5.4.

[^195]: Prefrontal Acetylcholine Release Controls Cue Detection on Multiple Timescales. Neuron 56 (1), pp. 141–154 (en). External Links: ISSN 08966273, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0896627307006745), [Document](https://dx.doi.org/10.1016/j.neuron.2007.08.025) Cited by: §3.3.

[^196]: Continual lifelong learning with neural networks: A review. Neural Networks 113, pp. 54–71 (en). External Links: ISSN 08936080, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0893608019300231), [Document](https://dx.doi.org/10.1016/j.neunet.2019.01.012) Cited by: §2.1.

[^197]: Dual-task interference in simple tasks: Data and theory.. Psychological Bulletin 116 (2), pp. 220–244 (en). External Links: ISSN 1939-1455, 0033-2909, [Link](https://doi.apa.org/doi/10.1037/0033-2909.116.2.220), [Document](https://dx.doi.org/10.1037/0033-2909.116.2.220) Cited by: Table 1.

[^198]: Computational Models Describing Possible Mechanisms for Generation of Excessive Beta Oscillations in Parkinson’s Disease. PLOS Computational Biology 11 (12), pp. e1004609 (en). External Links: ISSN 1553-7358, [Link](https://dx.plos.org/10.1371/journal.pcbi.1004609), [Document](https://dx.doi.org/10.1371/journal.pcbi.1004609) Cited by: §7.1.

[^199]: Dopamine Receptor Activation Is Required for Corticostriatal Spike-Timing-Dependent Plasticity. The Journal of Neuroscience 28 (10), pp. 2435–2446 (en). External Links: ISSN 0270-6474, 1529-2401, [Link](https://www.jneurosci.org/lookup/doi/10.1523/JNEUROSCI.4402-07.2008), [Document](https://dx.doi.org/10.1523/JNEUROSCI.4402-07.2008) Cited by: §4.2.3.

[^200]: Burst-dependent synaptic plasticity can coordinate learning in hierarchical circuits. Nature Neuroscience 24 (7), pp. 1010–1019 (en). External Links: ISSN 1097-6256, 1546-1726, [Link](https://www.nature.com/articles/s41593-021-00857-x), [Document](https://dx.doi.org/10.1038/s41593-021-00857-x) Cited by: §5.4.

[^201]: The Role of Neuromodulators in Cortical Plasticity. A Computational Perspective. Frontiers in Synaptic Neuroscience 8. External Links: ISSN 1663-3563, [Link](http://journal.frontiersin.org/article/10.3389/fnsyn.2016.00038/full), [Document](https://dx.doi.org/10.3389/fnsyn.2016.00038) Cited by: §5.2.1.

[^202]: Neural heterogeneity promotes robust learning. Nature Communications 12 (1), pp. 5791 (en). External Links: ISSN 2041-1723, [Link](https://www.nature.com/articles/s41467-021-26022-3), [Document](https://dx.doi.org/10.1038/s41467-021-26022-3) Cited by: §5.4, §5.5.

[^203]: Deep Learning With Spiking Neurons: Opportunities and Challenges. Frontiers in Neuroscience 12, pp. 774. External Links: ISSN 1662-453X, [Link](https://www.frontiersin.org/article/10.3389/fnins.2018.00774/full), [Document](https://dx.doi.org/10.3389/fnins.2018.00774) Cited by: §2.1.

[^204]: Extinction Learning in Humans. Neuron 43 (6), pp. 897–905 (en). External Links: ISSN 08966273, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0896627304005689), [Document](https://dx.doi.org/10.1016/j.neuron.2004.08.042) Cited by: Table 1.

[^205]: Locus coeruleus: a new look at the blue spot. Nature Reviews Neuroscience 21 (11), pp. 644–659 (en). External Links: ISSN 1471-003X, 1471-0048, [Link](https://www.nature.com/articles/s41583-020-0360-9), [Document](https://dx.doi.org/10.1038/s41583-020-0360-9) Cited by: §4.

[^206]: Neural Substrates of Dopamine D2 Receptor Modulated Executive Functions in the Monkey Prefrontal Cortex. Cerebral Cortex 25 (9), pp. 2980–2987 (en). External Links: ISSN 1047-3211, 1460-2199, [Link](https://academic.oup.com/cercor/article-lookup/doi/10.1093/cercor/bhu096), [Document](https://dx.doi.org/10.1093/cercor/bhu096) Cited by: §4.2.3.

[^207]: The Interplay Between Homeostatic Synaptic Plasticity and Functional Dendritic Compartments. Journal of Neurophysiology 96 (1), pp. 276–283 (en). External Links: ISSN 0022-3077, 1522-1598, [Link](https://www.physiology.org/doi/10.1152/jn.00074.2006), [Document](https://dx.doi.org/10.1152/jn.00074.2006) Cited by: §4.2.2.

[^208]: Learning Transferable Visual Models From Natural Language Supervision. arXiv. Note: Version Number: 1 External Links: [Link](https://arxiv.org/abs/2103.00020), [Document](https://dx.doi.org/10.48550/ARXIV.2103.00020) Cited by: §5.1.

[^209]: Exploring the Limits of Transfer Learning with a Unified Text-to-Text Transformer. arXiv. Note: Version Number: 4 External Links: [Link](https://arxiv.org/abs/1910.10683), [Document](https://dx.doi.org/10.48550/ARXIV.1910.10683) Cited by: §5.1.

[^210]: Beyond core object recognition: Recurrent processes account for object recognition under occlusion. PLOS Computational Biology 15 (5), pp. e1007001 (en). External Links: ISSN 1553-7358, [Link](https://dx.plos.org/10.1371/journal.pcbi.1007001), [Document](https://dx.doi.org/10.1371/journal.pcbi.1007001) Cited by: §5.1.

[^211]: The neocortical microcircuit collaboration portal: a resource for rat somatosensory cortex. Frontiers in Neural Circuits 9. External Links: ISSN 1662-5110, [Link](http://journal.frontiersin.org/Article/10.3389/fncir.2015.00044/abstract), [Document](https://dx.doi.org/10.3389/fncir.2015.00044) Cited by: §7.2.2.

[^212]: Anatomically Defined and Functionally Distinct Dorsal Raphe Serotonin Sub-systems. Cell 175 (2), pp. 472–487.e20 (en). External Links: ISSN 00928674, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0092867418309711), [Document](https://dx.doi.org/10.1016/j.cell.2018.07.043) Cited by: §7.1.

[^213]: Neuromorphic Control: Designing Multiscale Mixed-Feedback Systems. IEEE Control Systems 41 (6), pp. 34–63. External Links: ISSN 1066-033X, 1941-000X, [Link](https://ieeexplore.ieee.org/document/9612647/), [Document](https://dx.doi.org/10.1109/MCS.2021.3107560) Cited by: §5.2.2.

[^214]: Loss of neuronal heterogeneity in epileptogenic human tissue impairs network resilience to sudden changes in synchrony. Cell Reports 39 (8), pp. 110863 (en). External Links: ISSN 22111247, [Link](https://linkinghub.elsevier.com/retrieve/pii/S2211124722006362), [Document](https://dx.doi.org/10.1016/j.celrep.2022.110863) Cited by: §5.4.

[^215]: Effects of Neuromodulation on Excitatory–Inhibitory Neural Network Dynamics Depend on Network Connectivity Structure. Journal of Nonlinear Science 30 (5), pp. 2171–2194 (en). External Links: ISSN 0938-8974, 1432-1467, [Link](http://link.springer.com/10.1007/s00332-017-9438-6), [Document](https://dx.doi.org/10.1007/s00332-017-9438-6) Cited by: §5.5.

[^216]: Shifting and stopping: fronto-striatal substrates, neurochemical modulation and clinical implications. Philosophical Transactions of the Royal Society of London. Series B, Biological Sciences 362 (1481), pp. 917–932 (eng). External Links: ISSN 0962-8436, [Document](https://dx.doi.org/10.1098/rstb.2007.2097) Cited by: Table 1, Table 1, §6.

[^217]: The Neuropsychopharmacology of Fronto-Executive Function: Monoaminergic Modulation. Annual Review of Neuroscience 32 (1), pp. 267–287 (en). External Links: ISSN 0147-006X, 1545-4126, [Link](https://www.annualreviews.org/doi/10.1146/annurev.neuro.051508.135535), [Document](https://dx.doi.org/10.1146/annurev.neuro.051508.135535) Cited by: §4.2.3.

[^218]: Augmenting learning in neuro-embodied systems through neurobiological first principles. External Links: 2407.04525, [Link](https://arxiv.org/abs/2407.04525) Cited by: §1, §3.1, §3.2, §3.3, §5.2.2, §5.4, §7.1.

[^219]: Noradrenergic-inspired gain modulation attenuates the stability gap in joint training. External Links: 2507.14056, [Link](https://arxiv.org/abs/2507.14056) Cited by: 3rd item, §6.1, §6.

[^220]: The role of gain neuromodulation in layer-5 pyramidal neurons. External Links: 2507.03222, [Link](https://arxiv.org/abs/2507.03222) Cited by: 3rd item, §7.1.

[^221]: Synaptic tagging during memory allocation. Nature Reviews Neuroscience 15 (3), pp. 157–169 (en). External Links: ISSN 1471-003X, 1471-0048, [Link](https://www.nature.com/articles/nrn3667), [Document](https://dx.doi.org/10.1038/nrn3667) Cited by: §4.2.3.

[^222]: Experience replay for continual learning. External Links: 1811.11682, [Link](https://arxiv.org/abs/1811.11682) Cited by: §2.1.

[^223]: Neuronal correlates of parametric working memory in the prefrontal cortex. Nature 399 (6735), pp. 470–473 (en). External Links: ISSN 0028-0836, 1476-4687, [Link](https://www.nature.com/articles/20939), [Document](https://dx.doi.org/10.1038/20939) Cited by: §7.1.

[^224]: Action sets and decisions in the medial frontal cortex. Trends in Cognitive Sciences 8 (9), pp. 410–417 (en). External Links: ISSN 13646613, [Link](https://linkinghub.elsevier.com/retrieve/pii/S1364661304001913), [Document](https://dx.doi.org/10.1016/j.tics.2004.07.009) Cited by: Table 1, Table 1.

[^225]: Progressive Neural Networks. arXiv. Note: Version Number: 4 External Links: [Link](https://arxiv.org/abs/1606.04671), [Document](https://dx.doi.org/10.48550/ARXIV.1606.04671) Cited by: §2.1.

[^226]: Dendritic cortical microcircuits approximate the backpropagation algorithm. arXiv. Note: Version Number: 1Other To appear in Advances in Neural Information Processing Systems 31 (NIPS 2018). 12 pages, 3 figures, 9 pages of supplementary material (2 supplementary figures) External Links: [Link](https://arxiv.org/abs/1810.11393), [Document](https://dx.doi.org/10.48550/ARXIV.1810.11393) Cited by: §5.4.

[^227]: Dopamine dynamics and cocaine sensitivity differ between striosome and matrix compartments of the striatum. Neuropharmacology 108, pp. 275–283 (en). External Links: ISSN 00283908, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0028390816301216), [Document](https://dx.doi.org/10.1016/j.neuropharm.2016.03.049) Cited by: §4.1.

[^228]: Noradrenergic Modulation of Selective Attention: Its Role in Memory Retrieval. Annals of the New York Academy of Sciences 444 (1), pp. 178–193 (en). External Links: ISSN 0077-8923, 1749-6632, [Link](https://nyaspubs.onlinelibrary.wiley.com/doi/10.1111/j.1749-6632.1985.tb37588.x), [Document](https://dx.doi.org/10.1111/j.1749-6632.1985.tb37588.x) Cited by: §3.3.

[^229]: The locus coeruleus and noradrenergic modulation of cognition. Nature Reviews Neuroscience 10 (3), pp. 211–223 (en). External Links: ISSN 1471-003X, 1471-0048, [Link](https://www.nature.com/articles/nrn2573), [Document](https://dx.doi.org/10.1038/nrn2573) Cited by: §4.2.3.

[^230]: Cortical cholinergic inputs mediating arousal, attentional processing and dreaming: differential afferent regulation of the basal forebrain by telencephalic and brainstem afferents. Neuroscience 95 (4), pp. 933–952 (en). External Links: ISSN 03064522, [Link](https://linkinghub.elsevier.com/retrieve/pii/S030645229900487X), [Document](https://dx.doi.org/10.1016/S0306-4522%2899%2900487-X) Cited by: §3.3.

[^231]: Unraveling the attentional functions of cortical cholinergic inputs: interactions between signal-driven and cognitive modulation of signal detection. Brain Research Reviews 48 (1), pp. 98–111 (en). External Links: ISSN 01650173, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0165017304001249), [Document](https://dx.doi.org/10.1016/j.brainresrev.2004.08.006) Cited by: §4.2.3.

[^232]: Neuromorphic Control of a Pendulum. IEEE Control Systems Letters 8, pp. 1235–1240. External Links: ISSN 2475-1456, [Link](https://ieeexplore.ieee.org/document/10547227/), [Document](https://dx.doi.org/10.1109/LCSYS.2024.3409093) Cited by: §5.2.2.

[^233]: Meta-SpikePropamine: learning to learn with synaptic plasticity in spiking neural networks. Frontiers in Neuroscience 17, pp. 1183321. External Links: ISSN 1662-453X, [Link](https://www.frontiersin.org/articles/10.3389/fnins.2023.1183321/full), [Document](https://dx.doi.org/10.3389/fnins.2023.1183321) Cited by: §5.2.1, §5.2.1.

[^234]: A Neural Substrate of Prediction and Reward. Science 275 (5306), pp. 1593–1599 (en). External Links: ISSN 0036-8075, 1095-9203, [Link](https://www.science.org/doi/10.1126/science.275.5306.1593), [Document](https://dx.doi.org/10.1126/science.275.5306.1593) Cited by: §3.3, §4.2.3, 2nd item, §7.1.

[^235]: Updating dopamine reward signals. Current Opinion in Neurobiology 23 (2), pp. 229–238 (en). External Links: ISSN 09594388, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0959438812001869), [Document](https://dx.doi.org/10.1016/j.conb.2012.11.012) Cited by: §4.2.3.

[^236]: Opportunities for neuromorphic computing algorithms and applications. Nature Computational Science 2 (1), pp. 10–19 (en). External Links: ISSN 2662-8457, [Link](https://www.nature.com/articles/s43588-021-00184-y), [Document](https://dx.doi.org/10.1038/s43588-021-00184-y) Cited by: §2.1, §5.1.

[^237]: The principal features and mechanisms of dopamine modulation in the prefrontal cortex. Progress in Neurobiology 74 (1), pp. 1–58 (en). External Links: ISSN 03010082, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0301008204001017), [Document](https://dx.doi.org/10.1016/j.pneurobio.2004.05.006) Cited by: §4.2.3.

[^238]: Neural Correlates of Motor Learning, Transfer of Learning, and Learning to Learn. Exercise and Sport Sciences Reviews 38 (1), pp. 3–9 (en). External Links: ISSN 0091-6331, [Link](https://journals.lww.com/00003677-201001000-00003), [Document](https://dx.doi.org/10.1097/JES.0b013e3181c5cce7) Cited by: §2.2.

[^239]: Spiking Control Systems. arXiv. Note: Version Number: 2 External Links: [Link](https://arxiv.org/abs/2112.03565), [Document](https://dx.doi.org/10.48550/ARXIV.2112.03565) Cited by: §5.2.2.

[^240]: The expected value of control: an integrative theory of anterior cingulate cortex function. Neuron 79 (2), pp. 217–240 (eng). External Links: ISSN 1097-4199, [Document](https://dx.doi.org/10.1016/j.neuron.2013.07.007) Cited by: §3.3.

[^241]: Thalamus plays a central role in ongoing cortical functioning. Nature Neuroscience 19 (4), pp. 533–541 (en). External Links: ISSN 1097-6256, 1546-1726, [Link](https://www.nature.com/articles/nn.4269), [Document](https://dx.doi.org/10.1038/nn.4269) Cited by: §4.2.1.

[^242]: Computational models link cellular mechanisms of neuromodulation to large-scale neural dynamics. Nature Neuroscience 24 (6), pp. 765–776 (en). External Links: ISSN 1097-6256, 1546-1726, [Link](https://www.nature.com/articles/s41593-021-00824-6), [Document](https://dx.doi.org/10.1038/s41593-021-00824-6) Cited by: §3.3, §4.2.2, §5.4.

[^243]: Catecholaminergic manipulation alters dynamic network topology across cognitive states. Network Neuroscience (Cambridge, Mass.) 2 (3), pp. 381–396 (eng). External Links: ISSN 2472-1751, [Document](https://dx.doi.org/10.1162/netn%5Fa%5F00042) Cited by: §3.2, §4.1.

[^244]: Neuromodulatory Influences on Integration and Segregation in the Brain. Trends in Cognitive Sciences 23 (7), pp. 572–583 (en). External Links: ISSN 13646613, [Link](https://linkinghub.elsevier.com/retrieve/pii/S1364661319300944), [Document](https://dx.doi.org/10.1016/j.tics.2019.04.002) Cited by: §3.2, §3.3, §3, §5.6.

[^245]: Neuromodulatory control of complex adaptive dynamics in the brain. Interface Focus 13 (3), pp. 20220079 (eng). External Links: ISSN 2042-8898, [Document](https://dx.doi.org/10.1098/rsfs.2022.0079) Cited by: §7.1.

[^246]: Unraveling the dynamics of dopamine release and its actions on target cells. Trends in Neurosciences 46 (3), pp. 228–239 (en). External Links: ISSN 01662236, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0166223622002594), [Document](https://dx.doi.org/10.1016/j.tins.2022.12.005) Cited by: §4.1.

[^247]: Intact Ability to Learn Internal Models of Arm Dynamics in Huntington’s Disease But Not Cerebellar Degeneration. Journal of Neurophysiology 93 (5), pp. 2809–2821 (en). External Links: ISSN 0022-3077, 1522-1598, [Link](https://www.physiology.org/doi/10.1152/jn.00943.2004), [Document](https://dx.doi.org/10.1152/jn.00943.2004) Cited by: §2.2.

[^248]: Training Excitatory-Inhibitory Recurrent Neural Networks for Cognitive Tasks: A Simple and Flexible Framework. PLOS Computational Biology 12 (2), pp. e1004792 (en). External Links: ISSN 1553-7358, [Link](https://dx.plos.org/10.1371/journal.pcbi.1004792), [Document](https://dx.doi.org/10.1371/journal.pcbi.1004792) Cited by: §5.5.

[^249]: Disentangled deep generative models reveal coding principles of the human face processing network. PLOS Computational Biology 20 (2), pp. e1011887 (en). External Links: ISSN 1553-7358, [Link](https://dx.plos.org/10.1371/journal.pcbi.1011887), [Document](https://dx.doi.org/10.1371/journal.pcbi.1011887) Cited by: §5.1.

[^250]: Ionic Mechanisms of Neuronal Excitation by Inhibitory GABA ${}_{\textrm{{A}}}$ Receptors. Science 269 (5226), pp. 977–981 (en). External Links: ISSN 0036-8075, 1095-9203, [Link](https://www.science.org/doi/10.1126/science.7638623), [Document](https://dx.doi.org/10.1126/science.7638623) Cited by: §4.2.1.

[^251]: Structure induces computational function in networks with diverse types of spiking neurons. Neuroscience (en). External Links: [Link](http://biorxiv.org/lookup/doi/10.1101/2021.05.18.444689), [Document](https://dx.doi.org/10.1101/2021.05.18.444689) Cited by: §5.5.

[^252]: Dendrites. Oxford University Press. External Links: ISBN 978-0-19-874527-3, [Link](https://academic.oup.com/book/9617), [Document](https://dx.doi.org/10.1093/acprof%3Aoso/9780198745273.001.0001) Cited by: §4.2.2.

[^253]: Reward-Predictive Cues Enhance Excitatory Synaptic Strength onto Midbrain Dopamine Neurons. Science 321 (5896), pp. 1690–1692 (en). External Links: ISSN 0036-8075, 1095-9203, [Link](https://www.science.org/doi/10.1126/science.1160873), [Document](https://dx.doi.org/10.1126/science.1160873) Cited by: §7.1.

[^254]: Two types of locus coeruleus norepinephrine neurons drive reinforcement learning. Neuroscience (en). External Links: [Link](http://biorxiv.org/lookup/doi/10.1101/2022.12.08.519670), [Document](https://dx.doi.org/10.1101/2022.12.08.519670) Cited by: §3.3.

[^255]: Dopamine Neurons Make Glutamatergic Synapses In Vitro. The Journal of Neuroscience 18 (12), pp. 4588–4602 (en). External Links: ISSN 0270-6474, 1529-2401, [Link](https://www.jneurosci.org/lookup/doi/10.1523/JNEUROSCI.18-12-04588.1998), [Document](https://dx.doi.org/10.1523/JNEUROSCI.18-12-04588.1998) Cited by: §7.1.

[^256]: Next-generation GRAB sensors for monitoring dopaminergic activity in vivo. Nature Methods 17 (11), pp. 1156–1166 (en). External Links: ISSN 1548-7091, 1548-7105, [Link](https://www.nature.com/articles/s41592-020-00981-9), [Document](https://dx.doi.org/10.1038/s41592-020-00981-9) Cited by: §7.1.

[^257]: Reinforcement learning: an introduction. Second edition edition, Adaptive computation and machine learning, The MIT Press, Cambridge, Massachusetts London, England (eng). Note: Literaturverzeichnis: Seiten 481-518 Hier auch später erschienene, unveränderte Nachdrucke External Links: ISBN 978-0-262-03924-6 Cited by: §6, §7.1.

[^258]: Cingulate-motor circuits update rule representations for sequential choice decisions. Nature Communications 13 (1), pp. 4545 (en). External Links: ISSN 2041-1723, [Link](https://www.nature.com/articles/s41467-022-32142-1), [Document](https://dx.doi.org/10.1038/s41467-022-32142-1) Cited by: 1st item, Table 1, Table 1.

[^259]: Locus coeruleus and dopaminergic consolidation of everyday memory. Nature 537 (7620), pp. 357–362 (en). External Links: ISSN 0028-0836, 1476-4687, [Link](https://www.nature.com/articles/nature19325), [Document](https://dx.doi.org/10.1038/nature19325) Cited by: §4.2.3.

[^260]: Neuro-Modulated Hebbian Learning for Fully Test-Time Adaptation. arXiv. Note: Version Number: 2Other CVPR2023 accepted External Links: [Link](https://arxiv.org/abs/2303.00914), [Document](https://dx.doi.org/10.48550/ARXIV.2303.00914) Cited by: §5.2.1.

[^261]: Role for supplementary motor area cells in planning several movements ahead. Nature 371 (6496), pp. 413–416 (en). External Links: ISSN 0028-0836, 1476-4687, [Link](https://www.nature.com/articles/371413a0), [Document](https://dx.doi.org/10.1038/371413a0) Cited by: 1st item.

[^262]: Behavioral Variability through Stochastic Choice and Its Gating by Anterior Cingulate Cortex. Cell 159 (1), pp. 21–32 (en). External Links: ISSN 00928674, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0092867414011076), [Document](https://dx.doi.org/10.1016/j.cell.2014.08.037) Cited by: §3.3, Table 1.

[^263]: Neuromodulation of Attention. Neuron 97 (4), pp. 769–785 (en). External Links: ISSN 08966273, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0896627318300114), [Document](https://dx.doi.org/10.1016/j.neuron.2018.01.008) Cited by: §3.1, §3.1, §4.2.3.

[^264]: 5-HT3 Receptors. Current Pharmaceutical Design 12 (28), pp. 3615–3630 (en). External Links: ISSN 13816128, [Link](http://www.eurekaselect.com/openurl/content.php?genre=article&issn=1381-6128&volume=12&issue=28&spage=3615), [Document](https://dx.doi.org/10.2174/138161206778522029) Cited by: §4.2.1.

[^265]: Memory engram storage and retrieval. Current Opinion in Neurobiology 35, pp. 101–109 (en). External Links: ISSN 09594388, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0959438815001270), [Document](https://dx.doi.org/10.1016/j.conb.2015.07.009) Cited by: §4.2.3.

[^266]: Measures of degeneracy and redundancy in biological networks. Proceedings of the National Academy of Sciences 96 (6), pp. 3257–3262 (en). External Links: ISSN 0027-8424, 1091-6490, [Link](https://pnas.org/doi/full/10.1073/pnas.96.6.3257), [Document](https://dx.doi.org/10.1073/pnas.96.6.3257) Cited by: §7.2.1.

[^267]: Mechanisms and functions of GABA co-release. Nature Reviews Neuroscience 17 (3), pp. 139–145 (en). External Links: ISSN 1471-003X, 1471-0048, [Link](https://www.nature.com/articles/nrn.2015.21), [Document](https://dx.doi.org/10.1038/nrn.2015.21) Cited by: 1st item, §5.5.

[^268]: Schemas and Memory Consolidation. Science 316 (5821), pp. 76–82 (en). External Links: ISSN 0036-8075, 1095-9203, [Link](https://www.science.org/doi/10.1126/science.1135935), [Document](https://dx.doi.org/10.1126/science.1135935) Cited by: Table 1.

[^269]: Neuromodulators generate multiple context-relevant behaviors in a recurrent neural network by shifting activity flows in hyperchannels. Neuroscience (en). External Links: [Link](http://biorxiv.org/lookup/doi/10.1101/2021.05.31.446462), [Document](https://dx.doi.org/10.1101/2021.05.31.446462) Cited by: §5.2.1.

[^270]: Norepinephrine enables the induction of associative long-term potentiation at thalamo-amygdala synapses. Proceedings of the National Academy of Sciences of the United States of America 104 (35), pp. 14146–14150 (eng). External Links: ISSN 0027-8424, [Document](https://dx.doi.org/10.1073/pnas.0704621104) Cited by: §4.2.3.

[^271]: The Self-Tuning Neuron: Synaptic Scaling of Excitatory Synapses. Cell 135 (3), pp. 422–435 (en). External Links: ISSN 00928674, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0092867408012981), [Document](https://dx.doi.org/10.1016/j.cell.2008.10.008) Cited by: §4.2.2.

[^272]: The Role of Locus Coeruleus in the Regulation of Cognitive Performance. Science 283 (5401), pp. 549–554 (en). External Links: ISSN 0036-8075, 1095-9203, [Link](https://www.science.org/doi/10.1126/science.283.5401.549), [Document](https://dx.doi.org/10.1126/science.283.5401.549) Cited by: 3rd item.

[^273]: Dual-transmitter neurons: functional implications of co-release and co-transmission. Current Opinion in Neurobiology 29, pp. 25–32 (en). External Links: ISSN 09594388, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0959438814000890), [Document](https://dx.doi.org/10.1016/j.conb.2014.04.010) Cited by: 1st item, §5.5.

[^274]: Attention Is All You Need. arXiv. Note: Version Number: 7Other 15 pages, 5 figures External Links: [Link](https://arxiv.org/abs/1706.03762), [Document](https://dx.doi.org/10.48550/ARXIV.1706.03762) Cited by: §5.1.

[^275]: Introducing neuromodulation in deep neural networks to learn adaptive behaviours. PLOS ONE 15 (1), pp. e0227922 (en). External Links: ISSN 1932-6203, [Link](https://dx.plos.org/10.1371/journal.pone.0227922), [Document](https://dx.doi.org/10.1371/journal.pone.0227922) Cited by: §5.2.1, §5.6.

[^276]: Editorial overview: Computational neuroscience as a bridge between artificial intelligence, modeling and data. Current Opinion in Neurobiology 84, pp. 102835 (en). External Links: ISSN 09594388, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0959438823001605), [Document](https://dx.doi.org/10.1016/j.conb.2023.102835) Cited by: §7.1.

[^277]: Gain neuromodulation mediates task-relevant perceptual switches: evidence from pupillometry, fmri, and rnn modelling. eLife. External Links: [Link](http://dx.doi.org/10.7554/eLife.93191.3), [Document](https://dx.doi.org/10.7554/elife.93191.3) Cited by: 3rd item, §6.1, §6, §7.1.

[^278]: A Comprehensive Survey of Continual Learning: Theory, Method and Application. IEEE Transactions on Pattern Analysis and Machine Intelligence 46 (8), pp. 5362–5383. External Links: ISSN 0162-8828, 2160-9292, 1939-3539, [Link](https://ieeexplore.ieee.org/document/10444954/), [Document](https://dx.doi.org/10.1109/TPAMI.2024.3367329) Cited by: §1, §2.1, §2.1, §2.2.

[^279]: Brain topology improved spiking neural network for efficient reinforcement learning of continuous control. Frontiers in Neuroscience 18, pp. 1325062. External Links: ISSN 1662-453X, [Link](https://www.frontiersin.org/articles/10.3389/fnins.2024.1325062/full), [Document](https://dx.doi.org/10.3389/fnins.2024.1325062) Cited by: §5.6.

[^280]: Neural Circuitry of Reward Prediction Error. Annual Review of Neuroscience 40 (1), pp. 373–394 (en). External Links: ISSN 0147-006X, 1545-4126, [Link](https://www.annualreviews.org/doi/10.1146/annurev-neuro-072116-031109), [Document](https://dx.doi.org/10.1146/annurev-neuro-072116-031109) Cited by: §4.2.3.

[^281]: Whole-Brain Mapping of Direct Inputs to Midbrain Dopamine Neurons. Neuron 74 (5), pp. 858–873 (en). External Links: ISSN 08966273, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0896627312002814), [Document](https://dx.doi.org/10.1016/j.neuron.2012.03.017) Cited by: §7.1.

[^282]: Dopamine and serotonin interplay for valence-based spatial learning. Cell Reports 39 (2), pp. 110645 (en). External Links: ISSN 22111247, [Link](https://linkinghub.elsevier.com/retrieve/pii/S2211124722003977), [Document](https://dx.doi.org/10.1016/j.celrep.2022.110645) Cited by: §5.2.1.

[^283]: Hippocampome.org: a knowledge base of neuron types in the rodent hippocampus. eLife 4, pp. e09960 (en). External Links: ISSN 2050-084X, [Link](https://elifesciences.org/articles/09960), [Document](https://dx.doi.org/10.7554/eLife.09960) Cited by: §7.2.2.

[^284]: Relating transformers to models and neural representations of the hippocampal formation. arXiv. Note: Version Number: 2 External Links: [Link](https://arxiv.org/abs/2112.04035), [Document](https://dx.doi.org/10.48550/ARXIV.2112.04035) Cited by: §5.1.

[^285]: Expressivity of Neural Networks with Random Weights and Learned Biases. arXiv. Note: Version Number: 3Other upload of camera-ready manuscript accepted as poster at ICLR 2025; change of author order External Links: [Link](https://arxiv.org/abs/2407.00957), [Document](https://dx.doi.org/10.48550/ARXIV.2407.00957) Cited by: §5.4, §5.4.

[^286]: Neuromodulated Learning in Deep Neural Networks. arXiv. Note: Version Number: 1 External Links: [Link](https://arxiv.org/abs/1812.03365), [Document](https://dx.doi.org/10.48550/ARXIV.1812.03365) Cited by: §5.2.1, §5.6.

[^287]: Orbitofrontal Cortex as a Cognitive Map of Task Space. Neuron 81 (2), pp. 267–279 (en). External Links: ISSN 08966273, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0896627313010398), [Document](https://dx.doi.org/10.1016/j.neuron.2013.11.005) Cited by: Table 1.

[^288]: The influence of improvement in one mental function upon the efficiency of other functions. (I).. Psychological Review 8 (3), pp. 247–261 (en). External Links: ISSN 1939-1471, 0033-295X, [Link](https://doi.apa.org/doi/10.1037/h0074898), [Document](https://dx.doi.org/10.1037/h0074898) Cited by: Table 1.

[^289]: NMDA-driven dendritic modulation enables multitask representation learning in hierarchical sensory processing pathways. Proceedings of the National Academy of Sciences 120 (32), pp. e2300558120 (en). External Links: ISSN 0027-8424, 1091-6490, [Link](https://pnas.org/doi/10.1073/pnas.2300558120), [Document](https://dx.doi.org/10.1073/pnas.2300558120) Cited by: §5.4.

[^290]: A critical time window for dopamine actions on the structural plasticity of dendritic spines. Science 345 (6204), pp. 1616–1620 (en). External Links: ISSN 0036-8075, 1095-9203, [Link](https://www.science.org/doi/10.1126/science.1255514), [Document](https://dx.doi.org/10.1126/science.1255514) Cited by: §4.1.

[^291]: Using goal-driven deep learning models to understand sensory cortex. Nature Neuroscience 19 (3), pp. 356–365 (en). External Links: ISSN 1097-6256, 1546-1726, [Link](https://www.nature.com/articles/nn.4244), [Document](https://dx.doi.org/10.1038/nn.4244) Cited by: §5.1.

[^292]: Towards the next generation of recurrent network models for cognitive neuroscience. Current Opinion in Neurobiology 70, pp. 182–192 (en). External Links: ISSN 09594388, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0959438821001276), [Document](https://dx.doi.org/10.1016/j.conb.2021.10.015) Cited by: §5.5, §5.5, §7.1.

[^293]: Uncertainty, Neuromodulation, and Attention. Neuron 46 (4), pp. 681–692 (en). External Links: ISSN 08966273, [Link](https://linkinghub.elsevier.com/retrieve/pii/S0896627305003624), [Document](https://dx.doi.org/10.1016/j.neuron.2005.04.026) Cited by: §3.3, §3.3, §4.2.3.

[^294]: Specific Basal Forebrain–Cortical Cholinergic Circuits Coordinate Cognitive Operations. The Journal of Neuroscience 38 (44), pp. 9446–9458 (en). External Links: ISSN 0270-6474, 1529-2401, [Link](https://www.jneurosci.org/lookup/doi/10.1523/JNEUROSCI.1676-18.2018), [Document](https://dx.doi.org/10.1523/JNEUROSCI.1676-18.2018) Cited by: §4.1.

[^295]: A critique of pure learning and what artificial neural networks can learn from animal brains. Nature Communications 10 (1), pp. 3770 (en). External Links: ISSN 2041-1723, [Link](https://www.nature.com/articles/s41467-019-11786-6), [Document](https://dx.doi.org/10.1038/s41467-019-11786-6) Cited by: §1, §2.1.

[^296]: Acetylcholine-modulated plasticity in reward-driven navigation: a computational study. Scientific Reports 8 (1), pp. 9486 (en). External Links: ISSN 2045-2322, [Link](https://www.nature.com/articles/s41598-018-27393-2), [Document](https://dx.doi.org/10.1038/s41598-018-27393-2) Cited by: §5.2.1.

[^297]: Continual Learning Through Synaptic Intelligence. arXiv. Note: Version Number: 3Other ICML 2017 External Links: [Link](https://arxiv.org/abs/1703.04200), [Document](https://dx.doi.org/10.48550/ARXIV.1703.04200) Cited by: §2.1.

[^298]: Gain in sensitivity and loss in temporal contrast of STDP by dopaminergic modulation at hippocampal synapses. Proceedings of the National Academy of Sciences 106 (31), pp. 13028–13033 (en). External Links: ISSN 0027-8424, 1091-6490, [Link](https://pnas.org/doi/full/10.1073/pnas.0900546106), [Document](https://dx.doi.org/10.1073/pnas.0900546106) Cited by: §5.2.1.

[^299]: Temporal dendritic heterogeneity incorporated with spiking neural networks for learning multi-timescale dynamics. Nature Communications 15 (1), pp. 277 (en). External Links: ISSN 2041-1723, [Link](https://www.nature.com/articles/s41467-023-44614-z), [Document](https://dx.doi.org/10.1038/s41467-023-44614-z) Cited by: §5.4.