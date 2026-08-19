---
title: "Hebbian theory"
source: "https://en.wikipedia.org/wiki/Hebbian_theory"
author:
  - "[[Wikipedia]]"
published:
created: 2026-06-20
description:
tags:
  - "clippings"
---
**Hebbian theory** is a [neuropsychological](https://en.wikipedia.org/wiki/Neuropsychological "Neuropsychological") theory claiming that an increase in [synaptic](https://en.wikipedia.org/wiki/Synapse "Synapse") efficacy arises from a [presynaptic cell](https://en.wikipedia.org/wiki/Presynaptic_cell "Presynaptic cell") 's repeated and persistent stimulation of a postsynaptic cell. It is an attempt to explain [synaptic plasticity](https://en.wikipedia.org/wiki/Synaptic_plasticity "Synaptic plasticity"), the adaptation of [neurons](https://en.wikipedia.org/wiki/Neuron "Neuron") during the learning process. Hebbian theory was introduced by [Donald Hebb](https://en.wikipedia.org/wiki/Donald_Hebb "Donald Hebb") in his 1949 book *[The Organization of Behavior](https://en.wikipedia.org/wiki/The_Organization_of_Behavior "The Organization of Behavior").*[^1] The theory is also called **Hebb's rule**, **Hebb's law**, **Hebb's postulate**, and **cell assembly theory**. Hebb states it as follows:

> Let us assume that the persistence or repetition of a reverberatory activity (or "trace") tends to induce lasting cellular changes that add to its stability.... When an [axon](https://en.wikipedia.org/wiki/Axon "Axon") of cell *A* is near enough to excite a cell *B* and repeatedly or persistently takes part in firing it, some growth process or metabolic change takes place in one or both cells such that *A* 's efficiency, as one of the cells firing *B*, is increased.[^1]<sup><span title="Page / location: 62">: 62</span></sup>

The theory is often summarized as " **Neurons that fire together, wire together**." [^2] However, Hebb emphasized that cell *A* needs to "take part in firing" cell *B*, and such causality can occur only if cell *A* fires just before, not at the same time as, cell *B*. This aspect of causation in Hebb's work foreshadowed what is now known about [spike-timing-dependent plasticity](https://en.wikipedia.org/wiki/Spike-timing-dependent_plasticity "Spike-timing-dependent plasticity"), which requires temporal precedence.[^3]

Hebbian theory attempts to explain [associative](https://en.wikipedia.org/wiki/Associative_learning "Associative learning") or *Hebbian learning*, in which simultaneous activation of cells leads to pronounced increases in [synaptic strength](https://en.wikipedia.org/wiki/Synaptic_strength "Synaptic strength") between those cells. It also provides a biological basis for [errorless learning](https://en.wikipedia.org/wiki/Errorless_learning "Errorless learning") methods for education and memory rehabilitation. In the study of [neural networks](https://en.wikipedia.org/wiki/Artificial_neural_network "Artificial neural network") in cognitive function, it is often regarded as the neuronal basis of [unsupervised learning](https://en.wikipedia.org/wiki/Unsupervised_learning "Unsupervised learning").[^4]

## Engrams, cell assembly theory, and learning

Hebbian theory provides an explanation for how neurons might connect to become [engrams](https://en.wikipedia.org/wiki/Engram_\(neuropsychology\) "Engram (neuropsychology)"), which may be stored in overlapping cell assemblies, or groups of neurons that encode specific information.[^5] Initially created as a way to explain recurrent activity in specific groups of cortical neurons, Hebb's theories on the form and function of cell assemblies can be understood from the following:[^1]<sup><span title="Page / location: 70">: 70</span></sup>

> The general idea is an old one, that any two cells or systems of cells that are repeatedly active at the same time will tend to become 'associated' so that activity in one facilitates activity in the other.

Hebb also wrote:[^1]

> When one cell repeatedly assists in firing another, the axon of the first cell develops synaptic knobs (or enlarges them if they already exist) in contact with the soma of the second cell.

D. Alan Allport posits additional ideas regarding cell assembly theory and its role in forming engrams using the concept of auto-association, or the brain's ability to retrieve information based on a partial cue, described as follows:

> If the inputs to a system cause the same pattern of activity to occur repeatedly, the set of active elements constituting that pattern will become increasingly strongly inter-associated. That is, each element will tend to turn on every other element and (with negative weights) to turn off the elements that do not form part of the pattern. To put it another way, the pattern as a whole will become 'auto-associated'. We may call a learned (auto-associated) pattern an engram.[^6]

Research conducted in the laboratory of Nobel laureate [Eric Kandel](https://en.wikipedia.org/wiki/Eric_Kandel "Eric Kandel") has provided evidence supporting the role of Hebbian learning mechanisms at synapses in the marine [gastropod](https://en.wikipedia.org/wiki/Gastropoda "Gastropoda") *[Aplysia californica](https://en.wikipedia.org/wiki/Aplysia_californica "Aplysia californica")*.[^7] Because synapses in the [peripheral nervous system](https://en.wikipedia.org/wiki/Peripheral_nervous_system "Peripheral nervous system") of marine invertebrates are much easier to control in experiments, Kandel's research found that Hebbian [long-term potentiation](https://en.wikipedia.org/wiki/Long-term_potentiation "Long-term potentiation") along with activity-dependent presynaptic facilitation are both necessary for [synaptic plasticity](https://en.wikipedia.org/wiki/Synaptic_plasticity "Synaptic plasticity") and [classical conditioning](https://en.wikipedia.org/wiki/Classical_conditioning "Classical conditioning") in *Aplysia californica*.[^8]

While research on invertebrates has established fundamental mechanisms of learning and memory, much of the work on long-lasting synaptic changes between vertebrate neurons involves the use of non-physiological experimental stimulation of brain cells. However, some of the physiologically relevant synapse modification mechanisms that have been studied in vertebrate brains do seem to be examples of Hebbian processes. One such review indicates that long-lasting changes in synaptic strengths can be induced by physiologically relevant synaptic activity using both Hebbian and non-Hebbian mechanisms.[^9]

## Principles

In [artificial neurons](https://en.wikipedia.org/wiki/Artificial_neuron "Artificial neuron") and [artificial neural networks](https://en.wikipedia.org/wiki/Artificial_neural_network "Artificial neural network"), Hebb's principle can be described as a method of determining how to alter the weights between model neurons. The weight between two neurons increases if the two neurons activate simultaneously, and reduces if they activate separately. Nodes that tend to be either both positive or both negative at the same time have strong positive weights, while those that tend to be opposite have strong negative weights.

The following is a formulaic description of Hebbian learning (many other descriptions are possible):

${\displaystyle \,w_{ij}=x_{i}x_{j},}$

where ${\displaystyle w_{ij}}$ is the weight of the connection from neuron ${\displaystyle j}$ to neuron ${\displaystyle i}$, and ${\displaystyle x_{i}}$ is the input for neuron ${\displaystyle i}$. This is an example of pattern learning, where weights are updated after every training example. In a [Hopfield network](https://en.wikipedia.org/wiki/Hopfield_network "Hopfield network"), connections ${\displaystyle w_{ij}}$ are set to zero if ${\displaystyle i=j}$ (no reflexive connections allowed). With binary neurons (activations either 0 or 1), connections would be set to 1 if the connected neurons have the same activation for a pattern.

When several training patterns are used, the expression becomes an average of the individuals:

${\displaystyle w_{ij}={\frac {1}{p}}\sum _{k=1}^{p}x_{i}^{k}x_{j}^{k},}$

where ${\displaystyle w_{ij}}$ is the weight of the connection from neuron ${\displaystyle j}$ to neuron ${\displaystyle i}$, ${\displaystyle p}$ is the number of training patterns and ${\displaystyle x_{i}^{k}}$ the ${\displaystyle k}$ -th input for neuron ${\displaystyle i}$. This is learning by epoch, with weights updated after all the training examples are presented and is last term applicable to both discrete and continuous training sets. Again, in a Hopfield network, connections ${\displaystyle w_{ij}}$ are set to zero if ${\displaystyle i=j}$ (no reflexive connections).

A variation of Hebbian learning that takes into account phenomena such as blocking and other neural learning phenomena is the mathematical model of [Harry Klopf](https://en.wikipedia.org/wiki/Harry_Klopf "Harry Klopf"). Klopf's model assumes that parts of a system with simple adaptive mechanisms can underlie more complex systems with more advanced adaptive behavior, such as neural networks.[^10]

## Relationship to unsupervised learning, stability, and generalization

Because of the simple nature of Hebbian learning, based only on the coincidence of pre- and post-synaptic activity, it may not be intuitively clear why this form of plasticity leads to meaningful learning. However, it can be shown that Hebbian plasticity does pick up the statistical properties of the input in a way that can be categorized as unsupervised learning.

This can be mathematically shown in a simplified example. Let us work under the simplifying assumption of a single rate-based neuron of rate ${\displaystyle y(t)}$, whose inputs have rates ${\displaystyle x_{1}(t)...x_{N}(t)}$. The response of the neuron ${\displaystyle y(t)}$ is usually described as a linear combination of its input, ${\displaystyle \sum _{i}w_{i}x_{i}}$, followed by a [response function](https://en.wikipedia.org/wiki/Activation_function "Activation function") ${\displaystyle f}$:

${\displaystyle y=f\left(\sum _{i=1}^{N}w_{i}x_{i}\right).}$

As defined in the previous sections, Hebbian plasticity describes the evolution in time of the synaptic weight ${\displaystyle w}$:

${\displaystyle {\frac {dw_{i}}{dt}}=\eta x_{i}y.}$

Assuming, for simplicity, an identity response function ${\displaystyle f(a)=a}$, we can write

${\displaystyle {\frac {dw_{i}}{dt}}=\eta x_{i}\sum _{j=1}^{N}w_{j}x_{j}}$

or in [matrix](https://en.wikipedia.org/wiki/Matrix_\(mathematics\) "Matrix (mathematics)") form:

${\displaystyle {\frac {d\mathbf {w} }{dt}}=\eta \mathbf {x} \mathbf {x} ^{T}\mathbf {w} .}$

As in the previous chapter, if training by epoch is done an average ${\displaystyle \langle \dots \rangle }$ over discrete or continuous (time) training set of ${\displaystyle \mathbf {x} }$ can be done:
$$
{\displaystyle {\frac {d\mathbf {w} }{dt}}=\langle \eta \mathbf {x} \mathbf {x} ^{T}\mathbf {w} \rangle =\eta \langle \mathbf {x} \mathbf {x} ^{T}\rangle \mathbf {w} =\eta C\mathbf {w} .}
$$
 where ${\displaystyle C=\langle \,\mathbf {x} \mathbf {x} ^{T}\rangle }$ is the [correlation matrix](https://en.wikipedia.org/wiki/Correlation_matrix "Correlation matrix") of the input under the additional assumption that ${\displaystyle \langle \mathbf {x} \rangle =0}$ (i.e. the average of the inputs is zero). This is a system of ${\displaystyle N}$ coupled linear differential equations. Since ${\displaystyle C}$ is [symmetric](https://en.wikipedia.org/wiki/Symmetric_matrix "Symmetric matrix"), it is also [diagonalizable](https://en.wikipedia.org/wiki/Diagonalizable_matrix "Diagonalizable matrix"), and the solution can be found, by working in its eigenvectors basis, to be of the form

${\displaystyle \mathbf {w} (t)=k_{1}e^{\eta \alpha _{1}t}\mathbf {c} _{1}+k_{2}e^{\eta \alpha _{2}t}\mathbf {c} _{2}+...+k_{N}e^{\eta \alpha _{N}t}\mathbf {c} _{N}}$

where ${\displaystyle k_{i}}$ are arbitrary constants, ${\displaystyle \mathbf {c} _{i}}$ are the eigenvectors of ${\displaystyle C}$ and ${\displaystyle \alpha _{i}}$ their corresponding eigen values. Since a correlation matrix is always a [positive-definite matrix](https://en.wikipedia.org/wiki/Positive-definite_matrix "Positive-definite matrix"), the eigenvalues are all positive, and one can easily see how the above solution is always exponentially divergent in time. This is an intrinsic problem due to this version of Hebb's rule being unstable, as in any network with a dominant signal the synaptic weights will increase or decrease exponentially. Intuitively, this is because whenever the presynaptic neuron excites the postsynaptic neuron, the weight between them is reinforced, causing an even stronger excitation in the future, and so forth, in a self-reinforcing way. One may think a solution is to limit the firing rate of the postsynaptic neuron by adding a non-linear, saturating response function ${\displaystyle f}$, but in fact, it can be shown that for *any* neuron model, Hebb's rule is unstable.[^11] Therefore, network models of neurons usually employ other learning theories such as [BCM theory](https://en.wikipedia.org/wiki/BCM_theory "BCM theory"), [Oja's rule](https://en.wikipedia.org/wiki/Oja%27s_rule "Oja's rule"),[^12] or the [generalized Hebbian algorithm](https://en.wikipedia.org/wiki/Generalized_Hebbian_algorithm "Generalized Hebbian algorithm").

Regardless, even for the unstable solution above, one can see that, when sufficient time has passed, one of the terms dominates over the others, and

${\displaystyle \mathbf {w} (t)\approx e^{\eta \alpha ^{*}t}\mathbf {c} ^{*}}$

where ${\displaystyle \alpha ^{*}}$ is the *largest* eigenvalue of ${\displaystyle C}$. At this time, the postsynaptic neuron performs the following operation:

${\displaystyle y\approx e^{\eta \alpha ^{*}t}\mathbf {c} ^{*}\mathbf {x} }$

Because, again, ${\displaystyle \mathbf {c} ^{*}}$ is the eigenvector corresponding to the largest eigenvalue of the correlation matrix between the ${\displaystyle x_{i}}$ s, this corresponds exactly to computing the first [principal component](https://en.wikipedia.org/wiki/Principal_component "Principal component") of the input.

This mechanism can be extended to performing a full PCA ([principal component analysis](https://en.wikipedia.org/wiki/Principal_component_analysis "Principal component analysis")) of the input by adding further postsynaptic neurons, provided the postsynaptic neurons are prevented from all picking up the same principal component, for example by adding [lateral inhibition](https://en.wikipedia.org/wiki/Lateral_inhibition "Lateral inhibition") in the postsynaptic layer. We have thus connected Hebbian learning to PCA, which is an elementary form of unsupervised learning, in the sense that the network can pick up useful statistical aspects of the input, and "describe" them in a distilled way in its output.[^13]

## Hebbian learning and mirror neurons

Hebbian learning and spike-timing-dependent plasticity have been used in an influential theory of how [mirror neurons](https://en.wikipedia.org/wiki/Mirror_neuron "Mirror neuron") emerge.[^14] [^15] Mirror neurons are neurons that fire both when an individual performs an action and when the individual sees or hears another perform a similar action.[^16] [^17] The discovery of these neurons has been very influential in explaining how individuals make sense of the actions of others, since when a person perceives the actions of others, motor programs in the person's brain which they would use to perform similar actions are activated, which add information to the perception and help to predict what the person will do next based on the perceiver's own motor program. One limitation of this idea of mirror neuron functions is explaining how individuals develop neurons that respond both while performing an action and while hearing or seeing another perform similar actions.

Neuroscientist [Christian Keysers](https://en.wikipedia.org/wiki/Christian_Keysers "Christian Keysers") and psychologist [David Perrett](https://en.wikipedia.org/wiki/David_Perrett "David Perrett") suggested that observing or hearing an individual perform an action activates brain regions as if performing the action oneself.[^15] [^18] These re-afferent sensory signals trigger activity in neurons responding to the sight, sound, and feel of the action. Because the activity of these sensory neurons will consistently overlap in time with those of the motor neurons that caused the action, Hebbian learning predicts that the synapses connecting neurons responding to the sight, sound, and feel of an action and those of the neurons triggering the action should be potentiated. The same is true while people look at themselves in the mirror, hear themselves babble, or are imitated by others. After repeated occurrences of this re-afference, the synapses connecting the sensory and motor representations of an action are so strong that the motor neurons start firing to the sound or the vision of the action, and a mirror neuron is created.[^19]

Numerous experiments provide evidence for the idea that Hebbian learning is crucial to the formation of mirror neurons. Evidence reveals that motor programs can be triggered by novel auditory or visual stimuli after repeated pairing of the stimulus with the execution of the motor program.[^20] For instance, people who have never played the piano do not activate brain regions involved in playing the piano when listening to piano music. Five hours of piano lessons, in which the participant is exposed to the sound of the piano each time they press a key is proven sufficient to trigger activity in motor regions of the brain upon listening to piano music when heard at a later time.[^20] Consistent with the fact that spike-timing-dependent plasticity occurs only if the presynaptic neuron's firing predicts the post-synaptic neuron's firing,[^21] the link between sensory stimuli and motor programs also only seem to be potentiated if the stimulus is contingent on the motor program.

## Hebbian theory and cognitive neuroscience

Hebbian learning is linked to cognitive processes like decision-making and social learning. The field of cognitive neuroscience has started to explore the intersection of Hebbian theory with brain regions responsible for reward processing and social cognition, such as the striatum and prefrontal cortex.[^22] [^23] In particular, striatal projections exposed to Hebbian models exhibit long-term potentiation and long-term depression *in vivo*.[^24] Additionally, models of the prefrontal cortex to stimuli ("mixed selectivity") are not entirely explained by random connectivity, but when a Hebbian paradigm is incorporated, the levels of mixed selectivity in the model are reached.[^25] It is hypothesized (e.g., by Peter Putnam and [Robert W. Fuller](https://en.wikipedia.org/wiki/Robert_W._Fuller "Robert W. Fuller")) that Hebbian plasticity in these areas may underlie behaviors like habit formation, reinforcement learning, and even the development of social bonds.[^26] [^27]

## Limitations

Despite the common use of Hebbian models for long-term potentiation, Hebbian theory does not cover all forms of long-term synaptic plasticity. Hebb did not propose any rules for inhibitory synapses or predictions for anti-causal spike sequences (where the presynaptic neuron fires *after* the postsynaptic neuron). Synaptic modification may not simply occur only between activated neurons A and B, but at neighboring synapses as well.[^28] Therefore, all forms of [heterosynaptic plasticity](https://en.wikipedia.org/wiki/Heterosynaptic_plasticity "Heterosynaptic plasticity") and [homeostatic plasticity](https://en.wikipedia.org/wiki/Homeostatic_plasticity "Homeostatic plasticity") are considered non-Hebbian. One example is [retrograde signaling](https://en.wikipedia.org/wiki/Retrograde_signaling "Retrograde signaling") to presynaptic terminals.[^29] The compound most frequently recognized as a retrograde transmitter is [nitric oxide](https://en.wikipedia.org/wiki/Nitric_oxide "Nitric oxide"), which, due to its high solubility and diffusivity, often exerts effects on nearby neurons.[^30] This type of diffuse synaptic modification, known as volume learning, is not included in the traditional Hebbian model.[^31]

## Contemporary developments, artificial intelligence, and computational advancements

Modern research has expanded upon Hebb's original ideas. [Spike-timing-dependent plasticity](https://en.wikipedia.org/wiki/Spike-timing-dependent_plasticity "Spike-timing-dependent plasticity") (STDP), for example, refines Hebbian principles by incorporating the precise timing of neuronal spikes to Hebbian theory. Experimental advancements have also linked Hebbian learning to complex behaviors, such as decision-making and emotional regulation.[^13] Current studies in [artificial intelligence](https://en.wikipedia.org/wiki/Artificial_intelligence "Artificial intelligence") (AI) and quantum computing continue to leverage Hebbian concepts for developing adaptive algorithms and improving machine learning models.[^32]

In AI, Hebbian learning has seen applications beyond traditional neural networks. One significant advancement is in reinforcement learning algorithms, where Hebbian-like learning is used to update the weights based on the timing and strength of stimuli during training phases. Some researchers have adapted Hebbian principles to develop more biologically plausible models for learning in artificial systems, which may improve model efficiency and convergence in AI applications.[^33] [^34]

A growing area of interest is the application of Hebbian learning in quantum computing. While classical neural networks are the primary area of application for Hebbian theory, recent studies have begun exploring the potential for quantum-inspired algorithms. These algorithms leverage the principles of quantum superposition and entanglement to enhance learning processes in quantum systems.[^35] Current research is exploring how Hebbian principles could inform the development of more efficient quantum machine learning models.[^3]

New computational models have emerged that refine or extend Hebbian learning. For example, some models now account for the precise timing of neural spikes (as in spike-timing-dependent plasticity), while others have integrated aspects of neuromodulation to account for how neurotransmitters like dopamine affect the strength of synaptic connections. These advanced models provide a more nuanced understanding of how Hebbian learning operates in the brain and are contributing to the development of more realistic computational models.[^36] [^37]

Recent research on Hebbian learning has focused on the role of inhibitory neurons, which are often overlooked in traditional Hebbian models. While classic Hebbian theory primarily focuses on excitatory neurons, more comprehensive models of neural learning now consider the balanced interaction between excitatory and inhibitory synapses. Studies suggest that inhibitory neurons can provide critical regulation for maintaining stability in neural circuits and might prevent runaway positive feedback in Hebbian learning.[^38] [^39]

In 2017, Jeff Magee and colleagues identified *behavioral timescale synaptic plasticity* (BTSP), a form of learning in hippocampal CA1 neurons in which synaptic inputs active several seconds before or after a dendritic plateau potential are strengthened, even without coincident postsynaptic spiking.[^40] This mechanism operates on a much longer timescale than traditional Hebbian or spike-timing-dependent plasticity and provides a means for linking events separated in time during behavior.[^40] BTSP has been proposed as a modern framework for understanding how Hebbian-like associative processes can occur over behavioral timescales, suggesting that the timing window for synaptic modification may extend far beyond the millisecond range described in classical Hebbian learning.[^41]
