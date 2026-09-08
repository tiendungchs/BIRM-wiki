---
title: "A neurocomputational system for relational reasoning"
source: "https://www.sciencedirect.com/science/article/pii/S1364661312001283"
author:
  - "[[Barbara J. Knowlton]]"
  - "[[John E. Hummel]]"
  - "[[Keith J. Holyoak]]"
published:
created: 2026-09-08
description: "The representation and manipulation of structured relations is central to human reasoning. Recent work in computational modeling and neuroscience has …"
tags:
  - "clippings"
---
![Trends in Cognitive Sciences](https://ars.els-cdn.com/content/image/B13646613.svg)

Trends in Cognitive Sciences

## Opinion

[https://doi.org/10.1016/j.tics.2012.06.002](https://doi.org/10.1016/j.tics.2012.06.002 "Persistent link using digital object identifier")

Full text access

- [Next article in issue](https://www.sciencedirect.com/science/article/pii/S1364661312001301)

## How is thinking realized in the human brain?

One of the deepest puzzles for cognitive neuroscience is to explain how the most distinctively human types of thinking and reasoning are realized in the brain. Humans can grasp analogies between disparate situations, infer hidden causes of observed events, apply general rules to novel situations, and learn new abstractions from experience,,. Such intellectual abilities, which exceed those of any other extant primate species (perhaps in a qualitative manner ) are difficult to capture in any computational model, but pose particular challenges for those that aim for neural fidelity. How does the brain organize neurons, which are basically simple computing devices, so as to achieve the kinds of complexity manifested in human thinking and reasoning?

Research over the past decade and a half has begun to address this challenge. Cognitive neuropsychological and neuroimaging studies have implicated various subregions of the prefrontal cortex (PFC; ) as critical parts of a larger network supporting higher cognition (for reviews, see,,,, ). The most anterior lateral portion of the PFC, generally termed frontopolar or rostrolateral (RLPFC), is activated by tasks that require integration of multiple relations, processing relatively abstract concepts, or negotiating hierarchical goal structures,,,,,,,,,,,,. More dorsal and inferior areas of the PFC have also been implicated in the systematic control of representations necessary for these processes,,,,,.

![](https://ars.els-cdn.com/content/image/1-s2.0-S1364661312001283-gr1.jpg)

Download: Download full-size image

Over roughly the same time period, a number of computational models,,,, have attempted to explain aspects of human thinking and reasoning within neural systems, differing in their architectures and domains of application (). A substantial gap remains, however, between current theories of PFC function and computational models capable of actually performing tasks involving thinking and reasoning. Functional theories often highlight very general concepts such as ‘abstraction’ and ‘relational integration’, which though potentially helpful remain ill-defined in the absence of computational instantiations.

Table 1. Major neurocomputational models of human thinking

| Model | Architecture | Domain(s) of Application | Unique Characteristics |
| --- | --- | --- | --- |
| SMRITI | Localist connectionist network using binding by synchrony | Episodic memory encoding, storage, binding and retrieval | Corresponds to known architecture of hippocampus |
| LISA, | Distributed connectionist network using binding by synchrony | Relational reasoning | Integrates dynamic binding in WM with static binding in LTM, enabling symbolic processing to arise from a neural architecture |
| STAR-2 | Connectionist network using tensor products to code bindings | Relational reasoning | Tensor rank (number of basis vectors that together define the tensor) corresponds to relational complexity, predicting difficulty of reasoning tasks |
| ACT-R with neural modules | Production system integrated with modules for perception, motor responses, spatial representation, memory retrieval, and goal maintenance | Solving algebraic equations and related laboratory tasks | Provides a macro-level mapping between information-processing modules and brain areas, coupled with an analysis of the time course of activation for each module |
| SAL (Synthesis of ACT-R and Leabra) | Production system with declarative memory (ACT-R); subsymbolic processes realized by a connectionist network based on a point-neuron activation function (Leabra) | Spatial navigation and search | Integration of symbolic control processes with subsymbolic representations and learning mechanisms, using a neurally-constrained architecture |

Here we attempt to build an initial bridge across this gap. Focusing on computational mechanisms instantiated in a leading model of relational reasoning, ‘Learning and Inference with Schemas and Analogies’ (LISA;, ), we review the neural literature to construct more specific hypotheses about how these mechanisms may be realized in the human brain. Even though our focus is on the LISA model, we will also note connections with other neurocomputational models. Our opinion article reveals a remarkable convergence between constraints on models of human reasoning derived from computational analyses, behavioral experiments, and neurophysiological investigations. Although necessarily preliminary, we hope that this effort will help the development of more detailed neural models of high-level cognition.

## Role-based relational reasoning in LISA

The LISA model provides a computational account of role-based relational reasoning: inferences that depend on the roles that entities play, not just on perceptual similarity. For example, knowing that Sam is an enemy of Brian, and Dylan is a friend of Sam, a person might conjecture that Dylan may also be an enemy of Brian (). This ‘mutual support’ schema may have itself been acquired through analogical reasoning, by comparing specific cases that share a common relational structure.

![](https://ars.els-cdn.com/content/image/1-s2.0-S1364661312001283-gr2.jpg)

Download: Download full-size image

LISA codes an analog by binding distributed representations of roles to distributed representations of their fillers (coded on separate pools of semantic units; ). Semantic units are assumed to be coded by neurons in posterior regions. For each individual analog, a hierarchy of localist structure units represents objects (O), relational roles (R), individual role bindings (RB), and complete propositions (P). Structure units may be coded in long-term memory (LTM), but in order to be made available for active comparisons, they require a transient form (proxy units) in active memory. During mapping, the emerging correspondences are also coded by proxy units, called M *(*mapping*)* units, that connect structure units of a given type across the two analogs (e.g., P units to P units). These explicit learned correspondences allow LISA to assess the overall similarity between two analogs and to generate sensible structured inferences based on correspondences between elements of the two analogs.

LISA exploits dynamic binding coded by neural synchrony to impose a hierarchical temporal structure on knowledge representations within working memory (WM). A small number of role bindings in one analog (the driver) can enter the phase set – the set of mutually desynchronized role bindings. The phase set corresponds to the current focus of attention, and is the most significant bottleneck in the system. Each individual phase (the smallest unit of WM) corresponds to one role binding (i.e., an RB unit and its constituents). The size of the phase set is determined by the number of role-filler bindings (phases) that can be simultaneously active but mutually out of synchrony. The maximum number is proportional to the length of time between successive peaks in a phase (the period of the oscillation) divided by the duration of each phase (at the level of small populations of neurons) and/or temporal precision (at the level of individual spikes). Binding may be accomplished by synchrony in the >30 Hz (gamma) range, with a neuron or population of neurons generating one spike (or burst) approximately every 25 ms, implying WM capacity of approximately 4-6 role bindings (roughly 2-3 propositions). This value is consistent with estimates of WM capacity based on behavioral evidence (e.g., ) and may have roots in the mechanisms by which information is processed throughout the brain, including lower-level posterior cortex.

Because of the strong capacity limit on its phase set, LISA's processing is necessarily highly sequential, constituting a form of guided pattern recognition (). At any given moment, one analog (the driver) is the focus of attention. As one or more driver propositions enter the phase set, synchronized patterns of activation are generated on the semantic units (one pattern per RB). In turn, these patterns activate propositions in one or more recipient analogs in LTM (during retrieval), or a single recipient in active memory (during mapping, inference and schema induction).

![](https://ars.els-cdn.com/content/image/1-s2.0-S1364661312001283-gr3.jpg)

Download: Download full-size image

LISA provides a natural account of the loss of relational reasoning in populations with forms of brain damage, such as patients suffering from either frontal-lobe or temporal-lobe variants of Frontotemporal Lobar Degeneration. The model has also been used to simulate changes in relational reasoning during cognitive development,, and normal aging. In the remainder of this article we review several key neural findings that appear to correspond to computational constraints that arise in LISA.

## Role of oscillatory activity in reasoning

LISA fundamentally depends on the representation of information in a temporal structure. RB units must be activated in synchrony with O and P units (and their associated semantic units) to form dynamic representations, while these different representational complexes must be kept out of synchrony with each other to maintain distinct, non-overlapping role-filler bindings (a, b). Temporal structure in the form of oscillatory activity is in fact prominent in the brain, although no direct evidence yet connects such activity to the coding of propositions. Rhythmic neural activity, as reflected in the firing of groups of neurons, can be detected throughout the central nervous system, both in local interactions within a neural ensemble, and across brain regions through long-distance connections between populations of neurons.

![](https://ars.els-cdn.com/content/image/1-s2.0-S1364661312001283-gr4.jpg)

Download: Download full-size image

Oscillations can arise from the intrinsic circuit properties of the central nervous system, as neurons tend to be interconnected with numerous excitatory and inhibitory neurons, resulting in entrainment of firing of an ensemble of neurons at a specific frequency. These oscillations may reflect the firing rates of individual neurons, such as those that show bursts of firing in the gamma band. Slower oscillations, such as firing in the theta band (4–8 Hz), generally do not arise from a group of individual neurons firing at that frequency; rather, summed over a large group of neurons, peaks of firing will be apparent at this lower frequency due to slower feedback modulation.

In LISA, the smallest unit of WM is essentially defined as the synchronous firing of representational units. Importantly, LISA uses phase to maintain the separation of multiple role-filler bindings. Behavioral experiments using a priming paradigm suggest that synchrony underlies the representations of perceptual relations for humans. Likewise, a recent EEG study suggests that phase synchrony within the fronto-parietal network can bind object properties together in WM. Electrophysiological studies in nonhuman primates have revealed a link between WM and the synchronous firing of neural ensembles. For example, pairs of neurons have been shown to fire in synchrony in a task-dependent manner, consistent with the hypothesis that synchronous firing dynamically represents the representations needed in WM to perform the current task. The fact that neural assemblies can rapidly shift between different patterns of synchrony depending on the information being held in WM indicates that the method of representing propositions in LISA is neurally credible.

LISA also depends on long-distance communication between prefrontal regions and posterior regions of the cortex, where semantic information is stored. In order for prefrontal RB units to be activated by semantic information, there must be a means by which oscillatory activity in the temporal lobes engages circuits in PFC that represent this information. In the brain, synchrony in lower frequency bands, including theta, is detectable between sites separated by several millimeters, suggesting that entrainment of neural activity across brain regions occurs at lower frequency oscillations,,. In contrast, synchronous activity within local neural circuits tends to be higher frequency, in the gamma range. Within the PFC, local circuits will require inhibition to maintain the phase relationships of different role-filler bindings.

Studies of learning and memory have shown that brain oscillatory activity is relevant to behavior. For example, successful memory formation is associated with the tighter coupling of the firing of individual neurons to the theta frequency. In addition, stimulation during theta peaks is particularly effective in inducing long-term potentiation in the hippocampus, whereas blocking theta prevents the induction of long-term potentiation,. It thus appears that neural oscillations provide support for neural plasticity. Reasoning similarly requires the rapid formation of new representations. In LISA, M units are formed between structure units in the driver and recipient to capture correspondences between them. This type of rapid learning of connections has been observed in PFC, based on single-unit recordings with non-human primates,.

It appears that, in addition to plasticity being related to the phase of the theta cycle, high gamma frequency itself can directly enhance neural plasticity through a Hebbian learning mechanism. When neuronal circuits fire at this high rate, inputs to a neuron arrive shortly before the neuron fires, which thus becomes depolarized. In Hebbian plasticity, synaptic inputs that are active when the neuron is depolarized are strengthened. Thus, if the neuron is driven at a high rate, as occurs in the high gamma band, the inputs driving it will be strengthened. This phenomenon, termed ‘spike-timing-dependent plasticity’, implies that there is a neural mechanism by which the kind of synchronous activity postulated by LISA will also lead to synaptic strengthening. Such increases in synaptic strength may underlie the strengthening of M units during the mapping process. The facilitatory influences of theta- and gamma-band activity on neural plasticity appear to be related,. Through cross-frequency coupling (see ), the phase of the low frequency theta wave modulates the power of the gamma band, such that the amplitude of EEG measured in the gamma band is greatest at a specific point in the theta wave (c, d). The theta wave may serve to entrain bursts at gamma frequency by shifting the probability of spike timing. By this mechanism, long-distance communication across regions in the form of theta activity could modulate the timing of gamma bursts. It follows that information in regions of posterior cortex responsible for representing semantic information may influence local gamma activity in the PFC via theta frequency firing.

Additional evidence supports the hypothesis that the phase of neuronal oscillations in the PFC codes the representation of specific items in WM. Simultaneous recording of single units and the local-field potential in monkeys have demonstrated that spikes in response to a specific stimulus occur at a characteristic point in a 32-Hz cycle, corresponding to the gamma band. When the monkey's task was to keep more than one item in mind at a time, spikes corresponding to the second item occurred at a different point in the wave. Interestingly, spike synchronization was also observed at approximately 3 Hz, at the lower end of the theta band. The fact that both theta and gamma band oscillations are synchronized in the PFC is consistent with the possibility that cross-frequency coupling is a means to coordinate activity in distant regions with the rapid oscillations that support local processing. The finding that phase-specific spiking in the gamma phase is related to segregation of information in WM is consistent with LISA's mechanism for representing propositions via temporal asynchrony of role bindings.

## Proxy units in prefrontal cortex

In LISA, when propositions enter active memory, proxy units (the transient form of structure units) are rapidly formed in PFC. These proxy units that code individual analogs in turn connect to M units that represent correspondences between the elements of two analogs. The rapid learning required by these units could be supported by the spike-timing-dependent plasticity that can occur during high gamma-band activity synchronized to the theta rhythm. The rapid changing of weights on these units makes them suitable to dynamically represent different stimuli depending on the information being processed at the moment. Neurons with the properties ascribed to proxy units have been identified in the primate lateral PFC,,. About a third of neurons in the lateral PFC respond to categories of stimuli, which means that the neuron will increase firing rate when presented with members of a particular category (e.g., dogs). Importantly, these neurons fire based on the conceptual properties of the stimuli, and not simply on the basis of their visual features. Unlike neurons in inferotemporal cortex, neurons in lateral PFC respect the sharp boundaries between categories. These neurons respond similarly to typical and atypical members of a category, which suggests that they are sensitive to the rules defining the concept itself. This property is necessary for the proxy units in LISA, in that they must be able to represent high-level propositions that are abstract.

Furthermore, neurons in the PFC appear to also be able to code abstract relational rules. Cromer *et al*. had monkeys perform two different tasks: one in which they had to respond to matching stimuli and another in which they had to respond if the stimuli did not match. The most common type of neuron recorded in the prefrontal cortex (41% of all those recorded) responded selectively to the current rule, regardless of the stimuli that were present. These neurons thus appear to represent the relation between stimuli and a rule governing the current task – not the stimuli themselves – a major requirement for the proxy units posited by LISA. Although neurons responding to abstract rules could be found in all regions of the PFC, the majority were located in the lateral subregion.

The apparent flexibility of these neurons is another property that makes them suitable as instantiations of the proxy units postulated by LISA. Individual neurons do not simply respond to one type of stimulus; rather, in the context of different tasks, they respond to different categories. A neuron's response to the same stimulus can vary on a trial-by-trial basis depending on the task performed. This flexibility stands in stark contrast to the firing properties of inferotemporal neurons, in which firing to a complex visual stimulus is relatively static. Although caution is warranted in extrapolating from studies of monkeys to more complex human reasoning, such findings suggest that PFC neurons may act as representational elements for very different propositions depending on the task context.

Such dynamic repurposing of neurons is consistent with the flexible role played by proxy units in the LISA model. Proxy units are formed rapidly to represent propositions during reasoning. Spike-timing-dependent plasticity resulting from fast gamma-band activity in prefrontal neurons can support the kind of rapid changes in response properties that are necessary for proxy units. Importantly, synaptic strength can be rapidly decreased, as well as increased, based on the timing of presynaptic firing and post-synaptic depolarization. Long-term depression of synaptic strength allows neurons to be returned to a pool from which they can be recruited for the representation of new propositions. Moreover, the shift from long-term potentiation to long-term depression occurs as the result of a shift in spike timing on the order of milliseconds. These findings suggest that spike-timing-dependent plasticity can support the rapid binding and unbinding that is fundamental to the LISA model.

## Rostral-caudal abstraction gradient in PFC

Recently, an effort has been made to understand the subregions in PFC in terms of a hierarchy of action. Badre and D’Esposito have argued that more caudal regions of the PFC are involved in generating specific stimulus-response motor actions, whereas progressively more rostral regions become more involved when actions must be based on more abstract information (e.g., a plan based on the integration of multiple subgoals). For example, although caudal regions of the PFC are sufficient to subserve the act of picking up a cup from which to drink, more rostral regions would become engaged in the act of deciding what to drink in order to satisfy more abstract goals (e.g., trying to be healthy). Similarly, Christoff *et al.* have shown that a set to process more abstract concepts selectively activates RLPFC.

In LISA, the highest level of hierarchical organization is reflected in the M units, which form rapid associations between elements of propositions in the analogs being compared. These mapping units represent very abstract information, specifically, shared relational roles that can make otherwise dissimilar propositions analogous. Moreover, the very process of identifying relational commonalities can trigger the acquisition of more abstract schemas for classes of situations. The LISA architecture is thus based on representations at successive levels of abstraction, an overall structure that appears to be reflected in the organization of the PFC.

## The role of inhibition in reasoning

The nervous system is characterized by the interplay of excitation and inhibition. At the circuit level, the tight coupling of inhibitory interneurons and excitatory neurons results in oscillatory activity that allows for temporal coding of information in LISA's WM. As discussed above, circuit-level inhibition is required to maintain role-filler bindings mutually out of synchrony, and thus distinct in WM (a, b). In addition, inhibition plays a role in reducing interference from competing semantic concepts during analogical reasoning (e.g.,,,, ). Activation of propositions in the driver analog will trigger activation in related semantic units, which in turn will activate candidate recipient propositions. The most active recipient propositions will eventually enter WM and be available for analogical mapping.

However, if task-irrelevant propositions are activated in the driver, these may bias the system to find suboptimal correspondences. LISA postulates top-down inhibition of propositions tagged as low in goal-relevance, which helps prevent these propositions from entering the phase set. This selectivity increases the efficiency of the mapping process by enhancing the signal-to-noise ratio favoring goal-relevant matches. Regions in the PFC exhibit similar properties by selectively inhibiting semantic representations in posterior regions of cortex. The PFC has many reciprocal connections with posterior cortical regions, including in particular temporal and posterior parietal lobes (see ), and thus is able to influence processing in these regions. The primary evidence for the role of the PFC in inhibition is that a major consequence of prefrontal lesions is behavioral disinhibition. Patients with damage to the prefrontal cortex often fail to inhibit inappropriate behaviors and have difficulty maintaining cognitive control. By one view, the main role of the prefrontal cortex is the dynamic filtering of activations in posterior cortical regions to facilitate behavior directed towards a goal. Different subregions appear to support inhibition in different domains. In particular, damage to the right inferior prefrontal cortex impairs ability to inhibit a prepotent response in cognitive tasks whereas damage to orbitofrontal regions results in social and emotional disinhibition.

Behavioral studies have shown that the presence of irrelevant relations in analogs can impact relational reasoning, suggesting the inhibition is a necessary component of analogical reasoning,,,,,. Neuroimaging studies have produced even more direct evidence of the engagement of prefrontal inhibitory control during analogical reasoning. In a number of studies, activity was observed in the inferior frontal gyrus while subjects were solving analogy problems,. This same region has been shown to be active in a number of tasks of inhibitory control or semantic competition (see ). Cho et al. (2010) found direct evidence for the involvement of this region in inhibitory control during analogy, showing that activity in a region of right inferior frontal gyrus increased when the amount of interfering information increased. Similarly, using recordings of scalp EEG, Sweis et al. (2012) found that when participants needed to ignore a distracting relation while solving a visual analogy, right PFC was modulated at late stages of processing, and the degree of modulation interacted with the reasoner's WM capacity. The inferior frontal gyrus thus may be the anatomical source of the active inhibition of competing units postulated by the LISA model.

## Further directions

Many open questions remain (). Although we have focused on implications of neural evidence for the LISA model, these findings have implications for other neurocomputational models. Moreover, aspects of several of these models might be integrated to broaden coverage of high-level human cognition. LISA and SMRITI both use patterns of neural timing to encode binding information, and can be viewed as complementary (LISA focusing on prefrontal functions and reflective reasoning, SMRITI focusing on hippocampal functions). The macro-level neural modules postulated by ACT-R are compatible with LISA; ACT-R can be viewed as a model of the control structure within which human relational reasoning may operate.

Box 1

Questions for future research

Recent work in the cognitive neuroscience of thinking and in computational modeling has raised new hypotheses about how thinking is realized in the human brain. Some current questions are:
- •
	Can direct evidence be obtained to support the possible role of oscillatory neural activity in coding propositions in human PFC?
- •
	Can computational models employing oscillatory algorithms such as cross-cortical coupling be used to predict the brain's complex network dynamics during relational reasoning as measured via electrophysiology?
- •
	How are the various types of inhibition necessary for a model such as LISA implemented in the brain throughout the time course of relational reasoning?
- •
	What functions does the RLPFC support in relational reasoning at a computational level and how do these relate to its functions in other tasks?
- •
	What is the relationship between dynamic role binding in the PFC and the binding operations subserved by the hippocampus and medial temporal cortex?
- •
	What roles do neurotransmitters play in relational reasoning and can their effects be mapped onto components of a computational model?
- •
	What learning processes are involved in creating the pools of semantic units that code the meanings of objects and relations?
- •
	What role do subcortical structures play in relational reasoning? Are fronto-striatal circuits particularly important for mapping units, which must be maintained without continuous attention over short periods of time during reasoning?

There is reason to hope that advances in neuroimaging techniques, combined with refined methods for analyzing temporal patterns of neural activity, will make it possible to directly test some of the hypotheses we have laid out concerning the neural basis of relational reasoning. In addition, the general LISA architecture may be extended to incorporate additional factors related to PFC function. For example, in order to capture information processing in the PFC more fully, the LISA model would need to incorporate the influences of neuromodulators. Monoamine neurotransmitters, including dopamine, norepinephrine and serotonin, each have complex neuromodulatory roles. Depending on the conditions, these compounds have very large inhibitory or excitatory effects on neural transmission within the PFC; moreover, their effects often seem to interact with one another. A large number of psychiatric conditions that affect cognition involve monoamine dysregulation, and a suitably expanded LISA model could aid in understanding these disorders at the circuit level. It is likely that some individual differences in reasoning ability may be explained by polymorphisms in genes that code for monoamine receptors (e.g., ). In addition, the cognitive monitoring and evaluative functions of the anterior cingulate cortex may impact PFC processing via connections with neurons in the locus coerruleus that are the source of cortical noradrenergic modulation. Thus, elaborating the LISA model to incorporate neuromodulatory effects could lead to further advances in understanding the conditions that lead to optimal (and suboptimal) reasoning in the human brain.

## Acknowledgements

Preparation of this paper was supported by the Intelligence Advanced Research Projects Activity (IARPA) via Department of the Interior (DOI) contract number D10PC20022. The U.S. Government is authorized to reproduce and distribute reprints for governmental purposes notwithstanding any copyright annotation thereon. The views and conclusions contained hereon are those of the authors and should not be interpreted as necessarily representing the official policies or endorsements, either expressed or implied, of IARPA, DOI, or the U.S. Government. Additional support was provided by the American Federation of Aging Research and Arthur Gilbert Foundation, the Illinois Department of Public Health, the Loyola University Chicago Dean of Arts and Sciences and the Graduate School (to R.G.M.). We thank Krishna Bharani for help in preparing the manuscript, and Paul Kogut and the rest of the Lockheed Martin FRAMES team for many helpful discussions. Two anonymous reviewers provided valuable comments on an earlier draft.

## References

- ### Using transcranial direct current stimulation to enhance creative cognition: Interactions between task, polarity, and stimulation site
	2017, Frontiers in Human Neuroscience
	Show abstract
- ### Relational recurrent neural networks
	2018, Advances in Neural Information Processing Systems
- ### Reconfiguration of brain network architectures between resting-state and complexity-dependent cognitive reasoning
	2017, Journal of Neuroscience
- ### Thinking cap plus thinking zap: Tdcs of frontopolar cortex improves creative analogical reasoning and facilitates conscious augmentation of state creativity in verb generation
	2017, Cerebral Cortex
- ### Far-Out Thinking: Generating Solutions to Distant Analogies Promotes Relational Thinking
	2014, Psychological Science
- ### Relational Reasoning and Its Manifestations in the Educational Context: A Systematic Review of the Literature
	2013, Educational Psychology Review

## Glossary

Active memory

information in a state of current readiness for use in processing (including the active portion of LTM), typically over a time span of around 20 seconds.

Analogical mapping

the process of identifying systematic correspondences between elements of two situations (analogs) based on relational structure.

Cross-frequency coupling

interactions between different frequency bands, such as theta and gamma, which aid in integrating neural activity across different spatial and temporal scales.

Driver

in LISA, an analog that is currently in active memory and serves as a generator of spreading activation.

Phase set

in LISA, the set of mutually desynchronized role bindings represented by neuronal oscillations. The phase set corresponds to the current focus of attention and is the most significant bottleneck for reasoning with relations. The phase set is equivalent to working memory (WM) for relations.

Proposition

a predicate instantiated by binding its role(s) to particular arguments (objects or other propositions). A proposition is the smallest unit of representation that can have a truth value: intuitively, a ‘complete thought’. In LISA, a proposition is represented by a hierarchy of structure units.

Proxy unit

a transient representation of a structure unit, formed in prefrontal cortex in order to support structured reasoning, such as an analogical comparison.

Recipient

in LISA, an analog that is currently receiving activation from the driver. There may be multiple recipients in long-term memory (during retrieval) or a single recipient in active memory (during mapping, inference, and schema induction).

Role-based relational reasoning

reasoning that depends on the active representation and manipulation of concepts involving roles and role binding (see ‘proposition’).

Role binding

the binding of a single argument (object or proposition) to a single role associated with a predicate.

Schema

a relatively abstract relational structure representing a category or class of situations (e.g., a schema for a type of problem). In LISA, schemas can be formed as a consequence of comparing two or more relatively specific analogs.

Semantic unit

a unit that represents a simple element of meaning, associated with neurons in posterior cortex. In LISA, semantic units are the sole conduits for the transmission of activation between distinct analogs.

Spike-timing-dependent plasticity

a phenomenon based on evidence that if a neuron is being driven at a high rate, as occurs in the high gamma band, the inputs driving it will be strengthened. It provides a neural mechanism by which the kind of synchronous activity that in the LISA model supports dynamic representations will also lead to synaptic strengthening.

Structure unit

in LISA, a unit representing a component of a proposition within an analog: P (proposition), RB (role binding), O (object), and R (role); or a correspondence between elements of two analogs (M). Such units may be associated with neurons in posterior cortex (when stored in LTM), but must also be associated with dynamically recruited neurons in prefrontal cortex (see ‘proxy unit’).

[View Abstract](https://www.sciencedirect.com/science/article/abs/pii/S1364661312001283)

[^1]: ## How is thinking realized in the human brain?

One of the deepest puzzles for cognitive neuroscience is to explain how the most distinctively human types of thinking and reasoning are realized in the brain. Humans can grasp analogies between disparate situations, infer hidden causes of observed events, apply general rules to novel situations, and learn new abstractions from experience,,. Such intellectual abilities, which exceed those of any other extant primate species (perhaps in a qualitative manner ) are difficult to capture in any computational model, but pose particular challenges for those that aim for neural fidelity. How does the brain organize neurons, which are basically simple computing devices, so as to achieve the kinds of complexity manifested in human thinking and reasoning?

Research over the past decade and a half has begun to address this challenge. Cognitive neuropsychological and neuroimaging studies have implicated various subregions of the prefrontal cortex (PFC; ) as critical parts of a larger network supporting higher cognition (for reviews, see,,,, ). The most anterior lateral portion of the PFC, generally termed frontopolar or rostrolateral (RLPFC), is activated by tasks that require integration of multiple relations, processing relatively abstract concepts, or negotiating hierarchical goal structures,,,,,,,,,,,,. More dorsal and inferior areas of the PFC have also been implicated in the systematic control of representations necessary for these processes,,,,,.

![](https://ars.els-cdn.com/content/image/1-s2.0-S1364661312001283-gr1.jpg)

Download: Download full-size image

Over roughly the same time period, a number of computational models,,,, have attempted to explain aspects of human thinking and reasoning within neural systems, differing in their architectures and domains of application (). A substantial gap remains, however, between current theories of PFC function and computational models capable of actually performing tasks involving thinking and reasoning. Functional theories often highlight very general concepts such as ‘abstraction’ and ‘relational integration’, which though potentially helpful remain ill-defined in the absence of computational instantiations.

Table 1. Major neurocomputational models of human thinking

| Model | Architecture | Domain(s) of Application | Unique Characteristics |
| --- | --- | --- | --- |
| SMRITI | Localist connectionist network using binding by synchrony | Episodic memory encoding, storage, binding and retrieval | Corresponds to known architecture of hippocampus |
| LISA, | Distributed connectionist network using binding by synchrony | Relational reasoning | Integrates dynamic binding in WM with static binding in LTM, enabling symbolic processing to arise from a neural architecture |
| STAR-2 | Connectionist network using tensor products to code bindings | Relational reasoning | Tensor rank (number of basis vectors that together define the tensor) corresponds to relational complexity, predicting difficulty of reasoning tasks |
| ACT-R with neural modules | Production system integrated with modules for perception, motor responses, spatial representation, memory retrieval, and goal maintenance | Solving algebraic equations and related laboratory tasks | Provides a macro-level mapping between information-processing modules and brain areas, coupled with an analysis of the time course of activation for each module |
| SAL (Synthesis of ACT-R and Leabra) | Production system with declarative memory (ACT-R); subsymbolic processes realized by a connectionist network based on a point-neuron activation function (Leabra) | Spatial navigation and search | Integration of symbolic control processes with subsymbolic representations and learning mechanisms, using a neurally-constrained architecture |

Here we attempt to build an initial bridge across this gap. Focusing on computational mechanisms instantiated in a leading model of relational reasoning, ‘Learning and Inference with Schemas and Analogies’ (LISA;, ), we review the neural literature to construct more specific hypotheses about how these mechanisms may be realized in the human brain. Even though our focus is on the LISA model, we will also note connections with other neurocomputational models. Our opinion article reveals a remarkable convergence between constraints on models of human reasoning derived from computational analyses, behavioral experiments, and neurophysiological investigations. Although necessarily preliminary, we hope that this effort will help the development of more detailed neural models of high-level cognition.

## Role-based relational reasoning in LISA

The LISA model provides a computational account of role-based relational reasoning: inferences that depend on the roles that entities play, not just on perceptual similarity. For example, knowing that Sam is an enemy of Brian, and Dylan is a friend of Sam, a person might conjecture that Dylan may also be an enemy of Brian (). This ‘mutual support’ schema may have itself been acquired through analogical reasoning, by comparing specific cases that share a common relational structure.

![](https://ars.els-cdn.com/content/image/1-s2.0-S1364661312001283-gr2.jpg)

Download: Download full-size image

LISA codes an analog by binding distributed representations of roles to distributed representations of their fillers (coded on separate pools of semantic units; ). Semantic units are assumed to be coded by neurons in posterior regions. For each individual analog, a hierarchy of localist structure units represents objects (O), relational roles (R), individual role bindings (RB), and complete propositions (P). Structure units may be coded in long-term memory (LTM), but in order to be made available for active comparisons, they require a transient form (proxy units) in active memory. During mapping, the emerging correspondences are also coded by proxy units, called M *(*mapping*)* units, that connect structure units of a given type across the two analogs (e.g., P units to P units). These explicit learned correspondences allow LISA to assess the overall similarity between two analogs and to generate sensible structured inferences based on correspondences between elements of the two analogs.

LISA exploits dynamic binding coded by neural synchrony to impose a hierarchical temporal structure on knowledge representations within working memory (WM). A small number of role bindings in one analog (the driver) can enter the phase set – the set of mutually desynchronized role bindings. The phase set corresponds to the current focus of attention, and is the most significant bottleneck in the system. Each individual phase (the smallest unit of WM) corresponds to one role binding (i.e., an RB unit and its constituents). The size of the phase set is determined by the number of role-filler bindings (phases) that can be simultaneously active but mutually out of synchrony. The maximum number is proportional to the length of time between successive peaks in a phase (the period of the oscillation) divided by the duration of each phase (at the level of small populations of neurons) and/or temporal precision (at the level of individual spikes). Binding may be accomplished by synchrony in the >30 Hz (gamma) range, with a neuron or population of neurons generating one spike (or burst) approximately every 25 ms, implying WM capacity of approximately 4-6 role bindings (roughly 2-3 propositions). This value is consistent with estimates of WM capacity based on behavioral evidence (e.g., ) and may have roots in the mechanisms by which information is processed throughout the brain, including lower-level posterior cortex.

Because of the strong capacity limit on its phase set, LISA's processing is necessarily highly sequential, constituting a form of guided pattern recognition (). At any given moment, one analog (the driver) is the focus of attention. As one or more driver propositions enter the phase set, synchronized patterns of activation are generated on the semantic units (one pattern per RB). In turn, these patterns activate propositions in one or more recipient analogs in LTM (during retrieval), or a single recipient in active memory (during mapping, inference and schema induction).

![](https://ars.els-cdn.com/content/image/1-s2.0-S1364661312001283-gr3.jpg)

Download: Download full-size image

LISA provides a natural account of the loss of relational reasoning in populations with forms of brain damage, such as patients suffering from either frontal-lobe or temporal-lobe variants of Frontotemporal Lobar Degeneration. The model has also been used to simulate changes in relational reasoning during cognitive development,, and normal aging. In the remainder of this article we review several key neural findings that appear to correspond to computational constraints that arise in LISA.

## Role of oscillatory activity in reasoning

LISA fundamentally depends on the representation of information in a temporal structure. RB units must be activated in synchrony with O and P units (and their associated semantic units) to form dynamic representations, while these different representational complexes must be kept out of synchrony with each other to maintain distinct, non-overlapping role-filler bindings (a, b). Temporal structure in the form of oscillatory activity is in fact prominent in the brain, although no direct evidence yet connects such activity to the coding of propositions. Rhythmic neural activity, as reflected in the firing of groups of neurons, can be detected throughout the central nervous system, both in local interactions within a neural ensemble, and across brain regions through long-distance connections between populations of neurons.

![](https://ars.els-cdn.com/content/image/1-s2.0-S1364661312001283-gr4.jpg)

Download: Download full-size image

Oscillations can arise from the intrinsic circuit properties of the central nervous system, as neurons tend to be interconnected with numerous excitatory and inhibitory neurons, resulting in entrainment of firing of an ensemble of neurons at a specific frequency. These oscillations may reflect the firing rates of individual neurons, such as those that show bursts of firing in the gamma band. Slower oscillations, such as firing in the theta band (4–8 Hz), generally do not arise from a group of individual neurons firing at that frequency; rather, summed over a large group of neurons, peaks of firing will be apparent at this lower frequency due to slower feedback modulation.

In LISA, the smallest unit of WM is essentially defined as the synchronous firing of representational units. Importantly, LISA uses phase to maintain the separation of multiple role-filler bindings. Behavioral experiments using a priming paradigm suggest that synchrony underlies the representations of perceptual relations for humans. Likewise, a recent EEG study suggests that phase synchrony within the fronto-parietal network can bind object properties together in WM. Electrophysiological studies in nonhuman primates have revealed a link between WM and the synchronous firing of neural ensembles. For example, pairs of neurons have been shown to fire in synchrony in a task-dependent manner, consistent with the hypothesis that synchronous firing dynamically represents the representations needed in WM to perform the current task. The fact that neural assemblies can rapidly shift between different patterns of synchrony depending on the information being held in WM indicates that the method of representing propositions in LISA is neurally credible.

LISA also depends on long-distance communication between prefrontal regions and posterior regions of the cortex, where semantic information is stored. In order for prefrontal RB units to be activated by semantic information, there must be a means by which oscillatory activity in the temporal lobes engages circuits in PFC that represent this information. In the brain, synchrony in lower frequency bands, including theta, is detectable between sites separated by several millimeters, suggesting that entrainment of neural activity across brain regions occurs at lower frequency oscillations,,. In contrast, synchronous activity within local neural circuits tends to be higher frequency, in the gamma range. Within the PFC, local circuits will require inhibition to maintain the phase relationships of different role-filler bindings.

Studies of learning and memory have shown that brain oscillatory activity is relevant to behavior. For example, successful memory formation is associated with the tighter coupling of the firing of individual neurons to the theta frequency. In addition, stimulation during theta peaks is particularly effective in inducing long-term potentiation in the hippocampus, whereas blocking theta prevents the induction of long-term potentiation,. It thus appears that neural oscillations provide support for neural plasticity. Reasoning similarly requires the rapid formation of new representations. In LISA, M units are formed between structure units in the driver and recipient to capture correspondences between them. This type of rapid learning of connections has been observed in PFC, based on single-unit recordings with non-human primates,.

It appears that, in addition to plasticity being related to the phase of the theta cycle, high gamma frequency itself can directly enhance neural plasticity through a Hebbian learning mechanism. When neuronal circuits fire at this high rate, inputs to a neuron arrive shortly before the neuron fires, which thus becomes depolarized. In Hebbian plasticity, synaptic inputs that are active when the neuron is depolarized are strengthened. Thus, if the neuron is driven at a high rate, as occurs in the high gamma band, the inputs driving it will be strengthened. This phenomenon, termed ‘spike-timing-dependent plasticity’, implies that there is a neural mechanism by which the kind of synchronous activity postulated by LISA will also lead to synaptic strengthening. Such increases in synaptic strength may underlie the strengthening of M units during the mapping process. The facilitatory influences of theta- and gamma-band activity on neural plasticity appear to be related,. Through cross-frequency coupling (see ), the phase of the low frequency theta wave modulates the power of the gamma band, such that the amplitude of EEG measured in the gamma band is greatest at a specific point in the theta wave (c, d). The theta wave may serve to entrain bursts at gamma frequency by shifting the probability of spike timing. By this mechanism, long-distance communication across regions in the form of theta activity could modulate the timing of gamma bursts. It follows that information in regions of posterior cortex responsible for representing semantic information may influence local gamma activity in the PFC via theta frequency firing.

Additional evidence supports the hypothesis that the phase of neuronal oscillations in the PFC codes the representation of specific items in WM. Simultaneous recording of single units and the local-field potential in monkeys have demonstrated that spikes in response to a specific stimulus occur at a characteristic point in a 32-Hz cycle, corresponding to the gamma band. When the monkey's task was to keep more than one item in mind at a time, spikes corresponding to the second item occurred at a different point in the wave. Interestingly, spike synchronization was also observed at approximately 3 Hz, at the lower end of the theta band. The fact that both theta and gamma band oscillations are synchronized in the PFC is consistent with the possibility that cross-frequency coupling is a means to coordinate activity in distant regions with the rapid oscillations that support local processing. The finding that phase-specific spiking in the gamma phase is related to segregation of information in WM is consistent with LISA's mechanism for representing propositions via temporal asynchrony of role bindings.

## Proxy units in prefrontal cortex

In LISA, when propositions enter active memory, proxy units (the transient form of structure units) are rapidly formed in PFC. These proxy units that code individual analogs in turn connect to M units that represent correspondences between the elements of two analogs. The rapid learning required by these units could be supported by the spike-timing-dependent plasticity that can occur during high gamma-band activity synchronized to the theta rhythm. The rapid changing of weights on these units makes them suitable to dynamically represent different stimuli depending on the information being processed at the moment. Neurons with the properties ascribed to proxy units have been identified in the primate lateral PFC,,. About a third of neurons in the lateral PFC respond to categories of stimuli, which means that the neuron will increase firing rate when presented with members of a particular category (e.g., dogs). Importantly, these neurons fire based on the conceptual properties of the stimuli, and not simply on the basis of their visual features. Unlike neurons in inferotemporal cortex, neurons in lateral PFC respect the sharp boundaries between categories. These neurons respond similarly to typical and atypical members of a category, which suggests that they are sensitive to the rules defining the concept itself. This property is necessary for the proxy units in LISA, in that they must be able to represent high-level propositions that are abstract.

Furthermore, neurons in the PFC appear to also be able to code abstract relational rules. Cromer *et al*. had monkeys perform two different tasks: one in which they had to respond to matching stimuli and another in which they had to respond if the stimuli did not match. The most common type of neuron recorded in the prefrontal cortex (41% of all those recorded) responded selectively to the current rule, regardless of the stimuli that were present. These neurons thus appear to represent the relation between stimuli and a rule governing the current task – not the stimuli themselves – a major requirement for the proxy units posited by LISA. Although neurons responding to abstract rules could be found in all regions of the PFC, the majority were located in the lateral subregion.

The apparent flexibility of these neurons is another property that makes them suitable as instantiations of the proxy units postulated by LISA. Individual neurons do not simply respond to one type of stimulus; rather, in the context of different tasks, they respond to different categories. A neuron's response to the same stimulus can vary on a trial-by-trial basis depending on the task performed. This flexibility stands in stark contrast to the firing properties of inferotemporal neurons, in which firing to a complex visual stimulus is relatively static. Although caution is warranted in extrapolating from studies of monkeys to more complex human reasoning, such findings suggest that PFC neurons may act as representational elements for very different propositions depending on the task context.

Such dynamic repurposing of neurons is consistent with the flexible role played by proxy units in the LISA model. Proxy units are formed rapidly to represent propositions during reasoning. Spike-timing-dependent plasticity resulting from fast gamma-band activity in prefrontal neurons can support the kind of rapid changes in response properties that are necessary for proxy units. Importantly, synaptic strength can be rapidly decreased, as well as increased, based on the timing of presynaptic firing and post-synaptic depolarization. Long-term depression of synaptic strength allows neurons to be returned to a pool from which they can be recruited for the representation of new propositions. Moreover, the shift from long-term potentiation to long-term depression occurs as the result of a shift in spike timing on the order of milliseconds. These findings suggest that spike-timing-dependent plasticity can support the rapid binding and unbinding that is fundamental to the LISA model.

## Rostral-caudal abstraction gradient in PFC

Recently, an effort has been made to understand the subregions in PFC in terms of a hierarchy of action. Badre and D’Esposito have argued that more caudal regions of the PFC are involved in generating specific stimulus-response motor actions, whereas progressively more rostral regions become more involved when actions must be based on more abstract information (e.g., a plan based on the integration of multiple subgoals). For example, although caudal regions of the PFC are sufficient to subserve the act of picking up a cup from which to drink, more rostral regions would become engaged in the act of deciding what to drink in order to satisfy more abstract goals (e.g., trying to be healthy). Similarly, Christoff *et al.* have shown that a set to process more abstract concepts selectively activates RLPFC.

In LISA, the highest level of hierarchical organization is reflected in the M units, which form rapid associations between elements of propositions in the analogs being compared. These mapping units represent very abstract information, specifically, shared relational roles that can make otherwise dissimilar propositions analogous. Moreover, the very process of identifying relational commonalities can trigger the acquisition of more abstract schemas for classes of situations. The LISA architecture is thus based on representations at successive levels of abstraction, an overall structure that appears to be reflected in the organization of the PFC.

## The role of inhibition in reasoning

The nervous system is characterized by the interplay of excitation and inhibition. At the circuit level, the tight coupling of inhibitory interneurons and excitatory neurons results in oscillatory activity that allows for temporal coding of information in LISA's WM. As discussed above, circuit-level inhibition is required to maintain role-filler bindings mutually out of synchrony, and thus distinct in WM (a, b). In addition, inhibition plays a role in reducing interference from competing semantic concepts during analogical reasoning (e.g.,,,, ). Activation of propositions in the driver analog will trigger activation in related semantic units, which in turn will activate candidate recipient propositions. The most active recipient propositions will eventually enter WM and be available for analogical mapping.

However, if task-irrelevant propositions are activated in the driver, these may bias the system to find suboptimal correspondences. LISA postulates top-down inhibition of propositions tagged as low in goal-relevance, which helps prevent these propositions from entering the phase set. This selectivity increases the efficiency of the mapping process by enhancing the signal-to-noise ratio favoring goal-relevant matches. Regions in the PFC exhibit similar properties by selectively inhibiting semantic representations in posterior regions of cortex. The PFC has many reciprocal connections with posterior cortical regions, including in particular temporal and posterior parietal lobes (see ), and thus is able to influence processing in these regions. The primary evidence for the role of the PFC in inhibition is that a major consequence of prefrontal lesions is behavioral disinhibition. Patients with damage to the prefrontal cortex often fail to inhibit inappropriate behaviors and have difficulty maintaining cognitive control. By one view, the main role of the prefrontal cortex is the dynamic filtering of activations in posterior cortical regions to facilitate behavior directed towards a goal. Different subregions appear to support inhibition in different domains. In particular, damage to the right inferior prefrontal cortex impairs ability to inhibit a prepotent response in cognitive tasks whereas damage to orbitofrontal regions results in social and emotional disinhibition.

Behavioral studies have shown that the presence of irrelevant relations in analogs can impact relational reasoning, suggesting the inhibition is a necessary component of analogical reasoning,,,,,. Neuroimaging studies have produced even more direct evidence of the engagement of prefrontal inhibitory control during analogical reasoning. In a number of studies, activity was observed in the inferior frontal gyrus while subjects were solving analogy problems,. This same region has been shown to be active in a number of tasks of inhibitory control or semantic competition (see ). Cho et al. (2010) found direct evidence for the involvement of this region in inhibitory control during analogy, showing that activity in a region of right inferior frontal gyrus increased when the amount of interfering information increased. Similarly, using recordings of scalp EEG, Sweis et al. (2012) found that when participants needed to ignore a distracting relation while solving a visual analogy, right PFC was modulated at late stages of processing, and the degree of modulation interacted with the reasoner's WM capacity. The inferior frontal gyrus thus may be the anatomical source of the active inhibition of competing units postulated by the LISA model.

## Further directions

Many open questions remain (). Although we have focused on implications of neural evidence for the LISA model, these findings have implications for other neurocomputational models. Moreover, aspects of several of these models might be integrated to broaden coverage of high-level human cognition. LISA and SMRITI both use patterns of neural timing to encode binding information, and can be viewed as complementary (LISA focusing on prefrontal functions and reflective reasoning, SMRITI focusing on hippocampal functions). The macro-level neural modules postulated by ACT-R are compatible with LISA; ACT-R can be viewed as a model of the control structure within which human relational reasoning may operate.

Box 1

Questions for future research

Recent work in the cognitive neuroscience of thinking and in computational modeling has raised new hypotheses about how thinking is realized in the human brain. Some current questions are:
- •
	Can direct evidence be obtained to support the possible role of oscillatory neural activity in coding propositions in human PFC?
- •
	Can computational models employing oscillatory algorithms such as cross-cortical coupling be used to predict the brain's complex network dynamics during relational reasoning as measured via electrophysiology?
- •
	How are the various types of inhibition necessary for a model such as LISA implemented in the brain throughout the time course of relational reasoning?
- •
	What functions does the RLPFC support in relational reasoning at a computational level and how do these relate to its functions in other tasks?
- •
	What is the relationship between dynamic role binding in the PFC and the binding operations subserved by the hippocampus and medial temporal cortex?
- •
	What roles do neurotransmitters play in relational reasoning and can their effects be mapped onto components of a computational model?
- •
	What learning processes are involved in creating the pools of semantic units that code the meanings of objects and relations?
- •
	What role do subcortical structures play in relational reasoning? Are fronto-striatal circuits particularly important for mapping units, which must be maintained without continuous attention over short periods of time during reasoning?

There is reason to hope that advances in neuroimaging techniques, combined with refined methods for analyzing temporal patterns of neural activity, will make it possible to directly test some of the hypotheses we have laid out concerning the neural basis of relational reasoning. In addition, the general LISA architecture may be extended to incorporate additional factors related to PFC function. For example, in order to capture information processing in the PFC more fully, the LISA model would need to incorporate the influences of neuromodulators. Monoamine neurotransmitters, including dopamine, norepinephrine and serotonin, each have complex neuromodulatory roles. Depending on the conditions, these compounds have very large inhibitory or excitatory effects on neural transmission within the PFC; moreover, their effects often seem to interact with one another. A large number of psychiatric conditions that affect cognition involve monoamine dysregulation, and a suitably expanded LISA model could aid in understanding these disorders at the circuit level. It is likely that some individual differences in reasoning ability may be explained by polymorphisms in genes that code for monoamine receptors (e.g., ). In addition, the cognitive monitoring and evaluative functions of the anterior cingulate cortex may impact PFC processing via connections with neurons in the locus coerruleus that are the source of cortical noradrenergic modulation. Thus, elaborating the LISA model to incorporate neuromodulatory effects could lead to further advances in understanding the conditions that lead to optimal (and suboptimal) reasoning in the human brain.

[^2]: Over roughly the same time period, a number of computational models,,,, have attempted to explain aspects of human thinking and reasoning within neural systems, differing in their architectures and domains of application (). A substantial gap remains, however, between current theories of PFC function and computational models capable of actually performing tasks involving thinking and reasoning. Functional theories often highlight very general concepts such as ‘abstraction’ and ‘relational integration’, which though potentially helpful remain ill-defined in the absence of computational instantiations.

Table 1. Major neurocomputational models of human thinking 

| Model | Architecture | Domain(s) of Application | Unique Characteristics |
| --- | --- | --- | --- |
| SMRITI | Localist connectionist network using binding by synchrony | Episodic memory encoding, storage, binding and retrieval | Corresponds to known architecture of hippocampus |
| LISA, | Distributed connectionist network using binding by synchrony | Relational reasoning | Integrates dynamic binding in WM with static binding in LTM, enabling symbolic processing to arise from a neural architecture |
| STAR-2 | Connectionist network using tensor products to code bindings | Relational reasoning | Tensor rank (number of basis vectors that together define the tensor) corresponds to relational complexity, predicting difficulty of reasoning tasks |
| ACT-R with neural modules | Production system integrated with modules for perception, motor responses, spatial representation, memory retrieval, and goal maintenance | Solving algebraic equations and related laboratory tasks | Provides a macro-level mapping between information-processing modules and brain areas, coupled with an analysis of the time course of activation for each module |
| SAL (Synthesis of ACT-R and Leabra) | Production system with declarative memory (ACT-R); subsymbolic processes realized by a connectionist network based on a point-neuron activation function (Leabra) | Spatial navigation and search | Integration of symbolic control processes with subsymbolic representations and learning mechanisms, using a neurally-constrained architecture |

[^3]: | Model | Architecture | Domain(s) of Application | Unique Characteristics |
| --- | --- | --- | --- |
| SMRITI | Localist connectionist network using binding by synchrony | Episodic memory encoding, storage, binding and retrieval | Corresponds to known architecture of hippocampus |
| LISA, | Distributed connectionist network using binding by synchrony | Relational reasoning | Integrates dynamic binding in WM with static binding in LTM, enabling symbolic processing to arise from a neural architecture |
| STAR-2 | Connectionist network using tensor products to code bindings | Relational reasoning | Tensor rank (number of basis vectors that together define the tensor) corresponds to relational complexity, predicting difficulty of reasoning tasks |
| ACT-R with neural modules | Production system integrated with modules for perception, motor responses, spatial representation, memory retrieval, and goal maintenance | Solving algebraic equations and related laboratory tasks | Provides a macro-level mapping between information-processing modules and brain areas, coupled with an analysis of the time course of activation for each module |
| SAL (Synthesis of ACT-R and Leabra) | Production system with declarative memory (ACT-R); subsymbolic processes realized by a connectionist network based on a point-neuron activation function (Leabra) | Spatial navigation and search | Integration of symbolic control processes with subsymbolic representations and learning mechanisms, using a neurally-constrained architecture |