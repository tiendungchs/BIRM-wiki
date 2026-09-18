---
title: "How the visual brain can learn to parse images using a multiscale, incremental grouping process"
source: "https://journals.plos.org/ploscompbiol/article?id=10.1371%2Fjournal.pcbi.1014193"
author:
  - "[[Sami Mollard]]"
  - "[[Sander M. Bohte]]"
  - "[[Pieter R. Roelfsema]]"
published:
created: 2026-09-19
description: "Author summary In our perception, image elements that belong to the same object are grouped by object-based attention. Object-based attention corresponds to an enhanced neuronal representation of the image elements that are grouped in perception, in multiple areas of the visual cortex. During perceptual grouping tasks, this enhanced neuronal activity spreads gradually over an object representation, with a speed that depends on the distance between the relevant object and other objects. Here we propose a neuronal mechanism that learns the scale-invariant spread of object-based attention and accounts for psychophysical observations in human observers and the pattern of neuronal activity in the visual cortex of monkeys. This work sheds light on the mechanisms for multiscale object-based attention in the visual cortex."
tags:
  - "clippings"
---
## Abstract

Natural scenes usually contain many objects that need to be segregated from each other and the background. Object-based attention is the process that groups image fragments belonging to the same objects. Curve-tracing tasks provide a special case, testing our ability to group image elements of an elongated curve. In the brain, curve-tracing is associated with the gradual spread of enhanced neuronal activity over the representation of the traced curve. Previous studies demonstrated that the tracing speed is higher if curves are far apart than if they are nearby. One hypothesis is that a larger distance between curves permits activity propagation in higher visual cortical areas. In these higher areas receptive fields are larger and connections exist between neurons representing image regions that are farther apart (Pooresmaeili et al., 2014). We propose a recurrent architecture for the scale-invariant tracing of curves and objects. The architecture is composed of a feedforward pathway that dynamically selects the appropriate scale for tracing, and a recurrent pathway for propagating enhanced neuronal activity through horizontal and feedback connections, enabled by a disinhibitory loop involving VIP and SOM interneurons. We trained the network using a biologically plausible reinforcement learning scheme and observed that training on short curves allowed the networks to generalize to longer curves and 2D-objects. The network chose the scale based on the distance between curves and the width of objects, just as in human psychophysics and the visual cortex of monkeys. The results provide a mechanistic account of the learning and execution of multiscale perceptual grouping in the brain.

## Author summary

In our perception, image elements that belong to the same object are grouped by object-based attention. Object-based attention corresponds to an enhanced neuronal representation of the image elements that are grouped in perception, in multiple areas of the visual cortex. During perceptual grouping tasks, this enhanced neuronal activity spreads gradually over an object representation, with a speed that depends on the distance between the relevant object and other objects. Here we propose a neuronal mechanism that learns the scale-invariant spread of object-based attention and accounts for psychophysical observations in human observers and the pattern of neuronal activity in the visual cortex of monkeys. This work sheds light on the mechanisms for multiscale object-based attention in the visual cortex.

## Figures

![Fig 1](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1014193.g001) ![Fig 2](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1014193.g002) ![Fig 3](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1014193.g003) ![Fig 4](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1014193.g004) ![Fig 1](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1014193.g001) ![Fig 2](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1014193.g002) ![Fig 3](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1014193.g003)

**Citation:** Mollard S, Bohte SM, Roelfsema PR (2026) How the visual brain can learn to parse images using a multiscale, incremental grouping process. PLoS Comput Biol 22(4): e1014193. https://doi.org/10.1371/journal.pcbi.1014193

**Editor:** Haojiang Ying, Soochow University, CHINA

**Received:** June 17, 2025; **Accepted:** April 1, 2026; **Published:** April 15, 2026

**Copyright:** © 2026 Mollard et al. This is an open access article distributed under the terms of the [Creative Commons Attribution License](http://creativecommons.org/licenses/by/4.0/), which permits unrestricted use, distribution, and reproduction in any medium, provided the original author and source are credited.

**Data Availability:** All the code used to train the networks and to analyze the data is available on the following GitHub address: [https://github.com/samimol/multiscale\_tracing](https://github.com/samimol/multiscale_tracing).

**Funding:** This research has received funding from the European Union’s Horizon 2020 Framework Programme for Research and Innovation under the Specific Grant Agreement No. 945539 (Human Brain Project SGA3, Task 3.7, P.R.R, S.M.B.), Horizon Europe (ERC advanced grant 101052963 “NUMEROUS”, P.R.R.), NWO (Crossover grant 17619 “INTENSE”, P.R.R. and NWO- OCENW.KLEIN.178, S.M.B.), “DBI2”, a Gravitation program of the Dutch Ministry of Science (S.M.B.), and Agence Nationale de la Recherche (AN) within Programme d’investissement d’avenir, Institut Hospital Universitaire FORESIGHT (ANR-18-590 IAHU-0001, P.R.R.). We acknowledge the use of Fenix Infrastructure resources, which are partially funded from the European Union’s Horizon 2020 research and innovation programme through the ICEI project under the grant agreement No. 800858. The funders had no role in study design, data collection and analysis, decision to publish, or preparation of the manuscript.

**Competing interests:** The authors have declared that no competing interests exist.

## Introduction

Natural scenes usually contain several objects that need to be segregated from each other and from the background to guide behavior. Previous studies demonstrated that neurons in areas of the visual cortex that encode the elements of a relevant object incrementally enhance their firing rate during perceptual grouping tasks \[\]. This neuronal process corresponds to the gradual spread of “object-based attention” in perceptual psychology \[,\]. The rules determining what groups with what were already studied in the first half of the 20th century by the Gestalt psychologists \[,\]. One of their rules is connectedness, because image elements that are connected to each other tend to belong to the same object and group in our perception. Another rule is that of good continuation, describing that collinear contours usually belong to the same object.

Early theories of perception suggested that Gestalt rules are applied pre-attentively and in parallel across the visual field \[\], and indeed, some basic forms of grouping related to, for example, the perception of shape take place in parallel across the visual field \[,\]. However, grouping is flexible, because we can also group the features of objects that we never saw before. These groupings appear to form incrementally if image elements are grouped indirectly, via other image elements. On example of such seriality occurs in curve tracing tasks, in which participants report if two elements belong to the same curve ([Fig 1A](#pcbi-1014193-g001)). Jolicoeur et al. \[\] showed that the reaction time (RT) is proportional to the length of the curve that subjects have to trace. This serial process is also reflected by neurons in the visual cortex. Neurons in the visual cortex of monkeys \[\] and humans \[\] with a receptive field (RF) on the target curve increase their firing rate relative to neurons with RFs on a distractor curve ([Fig 1A](#pcbi-1014193-g001),[1B](#pcbi-1014193-g001)). This response enhancement does not occur during the initial feedforward visual response, triggered by the onset of a visual stimulus in the RF, but after a delay. The latency of the response enhancement depends on the distance between the start of the tracing process and the position of the RF. It occurs later for neurons with RFs farther along the curve \[\], in accordance with the gradual spread of enhanced activity over the representation of the target curve ([Fig 1A](#pcbi-1014193-g001)). This spread of an enhanced response corresponds to the gradual spread of object-based attention across the relevant curve \[,\].

[![thumbnail](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1014193.g001)](https://journals.plos.org/ploscompbiol/article/figure/image?size=medium&id=10.1371/journal.pcbi.1014193.g001 "Click for larger image")

Download:
- [
	PNG
	larger image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=large&id=10.1371/journal.pcbi.1014193.g001)
- [
	TIFF
	original image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=original&id=10.1371/journal.pcbi.1014193.g001)

Fig 1. Tasks used to probe the dynamics of object-based attention.

**A.** In this example curve tracing task, the subject must make an eye movement toward the blue dot connected to the red fixation point. Extra neuronal activity gradually spreads across the representation of the target curve in the visual cortex (yellow). **B.** Activity of neurons in the primary visual cortex of monkeys elicited by a target curve (orange) or on a distractor curve (blue). Inset, curve-tracing stimulus in which the V1 RF either fell on the target (orange) or distractor curve (blue). The panel below shows the time-course of attentional modulation, which is the difference in V1 activity between conditions. The target curve is labelled with enhanced activity (adapted from \[\]). **C.** Curve tracing and object grouping. In the curve tracing task, a growth-cone model of attention can account for the time-course of neuronal responses by proposing that enhanced activity spreads at multiple scales. If curves are far apart, the model uses large RFs (large circles) and smaller RFs when curves are nearby. The object grouping task is analogous to the curve-tracing task but takes place within two-dimensional objects. Subjects determine which dots are on the same image component.

[https://doi.org/10.1371/journal.pcbi.1014193.g001](https://doi.org/10.1371/journal.pcbi.1014193.g001)

The curve-tracing speed depends on the distance between the target curve and the distractor curves and on the curvature. Tracing slows down if distractors are nearby the target curve \[,\] or if it has a high curvature \[\]. Pooresmaeili et al. \[\] tested the influence of the distance between RFs on tracing speed in the visual cortex of monkeys. In their experiment there was a bottleneck where the target curve came close to the distractor ([Fig 1C](#pcbi-1014193-g001), top). Narrowing of the gap between the curves delayed the onset of the response enhancement, but only for parts of the target curve that were behind the bottleneck. A possible explanation of the influence of distance between curves is that the spread of enhanced neuronal activity across the target curve occurs in multiple cortical areas with different RF sizes \[\]. When the target curve is close to a distractor, the propagation of the enhanced activity would occur in low-level areas, such as the primary visual cortex, where RFs are sufficiently small to not fall on both curves. In these low-level areas, connections between neighboring neurons interconnect neurons with nearby RFs so that tracing speed is low. When the curves are farther apart, the spreading could occur in higher areas where the neurons have larger RFs and connections bridge across larger distances in the visual field. A “growth-cone” model for the spread of object-based attention proposed that fastest progress is made in the area where RFs falling on the target curve almost touch the distractor curve ([Fig 1C](#pcbi-1014193-g001)). An interesting implication of the growth cone model is that the RT in curve-tracing depends only little on the viewing distance from a display. When the subject approaches the stimulus, the length of the curves, measured in degrees of visual angle, increases. However, the distance between curves also increases and grouping can rely on neurons in higher visual areas with larger RFs. These two effects cancel each other and the RT remains the same \[\].

Jeurissen et al. \[\] extended the growth cone model to 2-D images. In their study, human participants reported whether two dots were on the same object or not. The pattern of RTs was best explained by a version of the growth-cone model in which image regions are incrementally labeled with enhanced activity. The enhanced activity started at one of the dots and propagated across the target surface through neurons with RFs with sizes that were small enough to stay within the object boundaries ([Fig 1C](#pcbi-1014193-g001), bottom).

In a previous study, Marić & Domijan \[\] proposed an instantiation of the growth-cone model for curve-tracing in a neural network with multiple scales. Their neural network architecture used hard-coded, multi-scale Gabor filters and the synaptic weights were determined manually to select the appropriate scale. Their network qualitatively reproduced the results observed in monkey visual cortex, but the model did not yet generalize to 2-D images.

Here, we focus on neural network architectures that can learn to incrementally group elongated curves and spatially extended image regions and we test how the networks generalize across tasks. Specifically, we examine how recurrent neural networks with units with several RF sizes learn to trace curves and to fill in objects in a scale-invariant manner. Building on prior work \[,\] we developed an architecture with segregated populations of units that either represent the stimulus veridically because of pure feedforward connectivity or can be modulated through horizontal and feedback connections. A key innovation is the inclusion of a trainable, biologically inspired disinhibitory loop that enables the propagation of attentional modulation across a curve or across an image region \[\].

Furthermore, we implement a biologically plausible learning rule that can train networks by trial-and-error. The only feedback that the model receives is a reward if it makes the correct choice, like how monkeys are trained on a curve-tracing and region-filling tasks. Specifically, we used RELEARNN \[,\] to determine how synapses modify their connection strength, using information both local in space and time.

Our approach addresses (1) how the networks learn to group image elements of the same objects, (2) the mechanisms allowing networks to learn to propagate enhanced activity at multiple spatial scales. We report that training on short curves allowed the model to generalize to long curves and to 2-D shapes. Furthermore, the networks predicted human RTs during image parsing tasks and the spread of neuronal activity in the visual cortex of monkeys.

## Model and task

We trained the networks on a curve-tracing task that has been used during electrophysiological recordings in the visual cortex of monkeys \[\] ([Fig 1A](#pcbi-1014193-g001),[1B](#pcbi-1014193-g001)). The monkeys first had to direct their gaze to the fixation point before the stimulus appeared, but in the version of the task for the network, the entire stimulus was presented at once. We also tested how well models that are proficient in curve-tracing generalize to the parsing of 2-D image regions \[,\]. The task of the model was to select a blue pixel on a curve or object that was cued with a red pixel ([Fig 1C](#pcbi-1014193-g001)) as target for an eye movement.

As in previous work \[\], we included a feedforward and recurrent processing group of units ([Fig 2A](#pcbi-1014193-g002)). Neurons in the feedforward group only receive feedforward input and propagate the information to higher layers. They represent the stimulus veridically and are responsible for the selection of the appropriate scale. Neurons in the recurrent group receive feedforward connections from lower layers, feedback from higher layers and horizontal connections from neighboring units in the same layer. They are responsible for the propagation of enhanced neuronal activity. The presence of some units that propagate the enhanced activity and others that do not is in accordance with neurophysiological results \[–\]. Neurons that engage in incremental grouping are enriched in layers 2, 3 and 5 of the visual cortex, whereas neurons that veridically represent the feedforward input are mostly situated in layers 4 and 6 \[–\]. In the model, units in the feedforward group gated the units of the recurrent group, so that they could not spread enhanced activity if the corresponding feedforward unit was not active ([Fig 2A](#pcbi-1014193-g002)). This feature prevented the spreading of enhanced activity into image regions not occupied by curves or objects.

[![thumbnail](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1014193.g002)](https://journals.plos.org/ploscompbiol/article/figure/image?size=medium&id=10.1371/journal.pcbi.1014193.g002 "Click for larger image")

Download:
- [
	PNG
	larger image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=large&id=10.1371/journal.pcbi.1014193.g002)
- [
	TIFF
	original image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=original&id=10.1371/journal.pcbi.1014193.g002)

Fig 2. Model.

**A.** The network incorporated four spatial scales. Units in the feedforward network are responsible for scale selection, whereas units in the recurrent network spread enhanced activity. This spread is gated by feedforward units with overlapping RFs. **B.** Scale selection in the feedforward network. In the curve tracing task, units in the feedforward group are only active (orange) if the image elements in the RF are connected and colinear. The cells are not active otherwise so that the enhanced activity cannot spill from the target to the distractor curve. In the object-parsing task, feedforward units are active if their RF falls on a homogeneous image region. **C.** Activity in the feedforward network in the curve tracing (top) and the object parsing task (bottom). The representation in higher layers is coarser, but RFs are larger and propagation can proceed faster. **D.** Architecture and training procedure of the feedforward group. The input image is first passed through the convolutions to produce a representation shared across all scales. Each scale is trained separately with its own ground truth and loss (only two scales are illustrated). **E.** Disinhibitory interactions between recurrent units. Pyramidal neurons receive feedforward from pyramidal units in the layer below. They also receive top-down input from units in the layer above and horizontal input from their neighbors through a disinhibitory loop composed of VIP and SOM interneurons.

[https://doi.org/10.1371/journal.pcbi.1014193.g002](https://doi.org/10.1371/journal.pcbi.1014193.g002)

### Feedforward network

The neural network had four spatial scales, and the feedforward units were responsible for scale selection. They were trained to only activate if the stimulus in their RF unambiguously belonged to a single object (see below) to prevent “spilling” of enhanced activity from the target to the distractor object in the recurrent network. In the curve-tracing task, feedforward units detected whether all pixels in their RF were connected to each other and colinear ([Fig 2B](#pcbi-1014193-g002)). Hence, the model needed to select a finer spatial scale for propagation if the target and distractor curves fell in the same RF, or if the target curve had a high curvature \[\]. In the object-parsing task, the stimulus inside a receptive field is unambiguous if it doesn’t contain a boundary ([Fig 2B](#pcbi-1014193-g002)). Upon presentation of the stimulus, feedforward units propagated activity to higher layers if the stimulus in their RF is unambiguous, resulting in a multiscale base-representation ([Fig 2C](#pcbi-1014193-g002)).

The activity of feedforward units was computed as follows: first, an input image with three feature channels (R, G, B) was projected onto a single feature map of the same spatial dimensions ([Fig 2D](#pcbi-1014193-g002)):

(1)

Where is the input image and is a 1x1 kernel with a stride of 1 and indicates convolution. This projection served as a shared representation and forms the input for all layers and scales. There was a direct feedforward projection from the feature map units to each scale, so that the activity in, e.g., layer 4 did not need to pass through layers 1, 2 and 3 ([Fig 2D](#pcbi-1014193-g002)).

The activity of feedforward units at all scales was computed as follows: was first passed through a convolutional layer with 20 feature maps, receptive field size *K*, and stride 1 to compute an intermediate feedforward activity in each layer:

(2)

Where with *K*  =  and is the intermediate representation.

The final feedforward output for layer, used to gate the dynamics of the recurrent network, was computed as:

(3)

where with K =, applied with a stride *K*, modulated the recurrent state and is a sigmoidal non-linearity. Hence, each scale was associated with an independent two-layer neural network with shared input ([Fig 2D](#pcbi-1014193-g002)). The resulting activity was used to gate the recurrent dynamics of the main network.

### Recurrent network

Units of the recurrent network learned to spread enhanced neuronal activity over the representation of the target object, to label it as one coherent perceptual group. They were connected by feedforward, horizontal and top-down connections. The propagation of enhanced neuronal activity relied on disinhibition, which was advantageous because we used the RELEARNN learning rule (see below) \[\] requiring the network to reach a stable state, which is not guaranteed with ReLU nonlinearities (Material and Methods). The disinhibitory connection scheme ([Fig 2E](#pcbi-1014193-g002)) was inspired by the interactions between inhibitory neurons in the mouse visual cortex during figure-ground segregation \[\] and has been used in previous models of attentional selection \[,\]. It ensured stable and expressive networks that learned to trace curves with an arbitrary length.

Specifically, the feedback and horizontal connections activated vasoactive intestinal peptide-expressing (VIP) interneurons. The VIP neurons inhibit somatostatin-expressing (SOM) interneurons, which inhibit pyramidal neurons \[,\]. Hence, VIP neurons disinhibited the pyramidal neurons. During curve-tracing, VIP neurons incrementally disinhibited pyramidal units that represent the target object, which is thereby labeled with enhanced activity. The advantage of the disinhibitory scheme is that the activity of pyramidal neurons cannot be higher than what it would be without SOM inhibition, preventing run-away excitation that can occur in recurrent networks with excitatory units that directly excite each other.

We will now describe the recurrent network with an input layer () and multiple hidden layers ( ≥1), each containing three interacting populations: pyramidal units, VIP interneurons, and SOM interneurons. The network activity evolves over discrete time steps t.

#### Input layer ().

The input layer receives the stationary sensory stimulus *X*. Its activity is modulated by feedback from the first hidden layer and by lateral inhibition. It acted as a “blackboard” \[\] between the raw sensory input and the higher layer representations, enriched by modulatory feedback signals and able to propagate this information forward again.

VIP neurons in the input layer are driven exclusively by feedback from the first hidden layer:

(4)

with feedback weights

with stride 1. Here is the number of channels in the input layer, is the number of channels in the first hidden layer, and is a clipped linear function defined by

![](https://journals.plos.org/ploscompbiol/article/file?type=thumbnail&id=10.1371/journal.pcbi.1014193.e030)

SOM activity is defined as:

(6)

where **1** denotes a tensor of ones with matching dimensions.

Pyramidal activity in the input layer is not directly driven by feedforward input (unlike in the hidden layers). The units receive top-down feedback from the first hidden layer, which is filtered through lateral inhibition. The feedback-modulated inhibitory signal is then gated by the sensory input image, allowing feedback to selectively weight the color channels, while preserving the spatial structure imposed by the sensory input. The activity of pyramidal units was defined by:

(7)

where lateral inhibitory kernel represented self-connections, with a single nonzero value at the center of every 3 × 3 kernel. The SOM inhibition was local and it did not mix information across spatial positions. The inhibitory weights from the SOM cells to the pyramidal cells satisfied

applied with stride 1. The is a gating function:

(8)

ensuring that propagation of the enhanced activity can only occur if the scale-selecting feedforward units are active. is the Hadamard (element-wise) product.

#### Hidden layers ().

Hidden layers operated at progressively coarser spatial resolutions, where and. This reduction in spatial resolution and the associated increase in RF size were inspired by the hierarchical organization of the visual cortex, but did not precisely map onto the resolution and RF sizes in specific visual cortical areas. Each hidden layer had feature channels ( for  = 1; 6 otherwise). VIP activity in the hidden layers integrated feedback and horizontal signals:

(9)

where with and a stride of 3. These feedback kernels used transposed convolution, such that a neuron in layer only received feedback from neurons in layer *l*  + 1 with overlapping RFs, restricting feedback modulation to spatially aligned units (red in [Fig 2E](#pcbi-1014193-g002)). Finally, horizontal kernels had a stride of 1 and were restricted to the von Neumann neighborhood that corresponds to the four nearest neighbors (up, down, left right). SOM activity was given by

(10)

Finally, pyramidal neuron activity evolved according to:

(11)

with feedforward weights where =3, for and =1 otherwise, with the stride equal to. We note that feedforward kernels were fully connected within a 3x3 receptive field, ensuring that each neuron in layer received feedforward input from all neurons with overlapping RFs in layer (cyan connections in [Fig 2E](#pcbi-1014193-g002)). Note that denotes the feedforward connections of the recurrent network, which differ from the feedforward connections of the scale selection feedforward network described above.

### Output layer

The output layer was retinotopically organized and units in the output layer learned to represent the Q-value \[\], which is the expected reward for the selection of an eye-movement to one of the pixels. Each output unit corresponded to a pixel and integrated information across all scales via skip connections from the input layer and all hidden layers. Without these skip connections, the higher layers, which have a lower resolution, dominated the decision process, preventing the network from selecting the correct pixel for an eye movement.

The Q-value map was read out when the network dynamics converged to a stable state at time T. Let denote the pyramidal activity at layer and time *T*. The activity in the output layer was given by:

![](https://journals.plos.org/ploscompbiol/article/file?type=thumbnail&id=10.1371/journal.pcbi.1014193.e065)

where denotes the skip-connection kernel from layer to the output layer.

The skip connections from the input layer () were implemented as 1 × 1 convolutions, preserving full spatial resolution, and skip connections from higher layers were transposed convolutions aligned with the output layer: a neuron in layer could only project to the output units representing pixels in its receptive field. We note that these skip connections did not suffice for solving the task for stimuli extending beyond two receptive fields at the largest scale.

During training, the model chose to make an eye-movement toward the position with the highest Q-value with probability. With probability other actions were explored, by sampling a random action from the Boltzmann distribution:

![](https://journals.plos.org/ploscompbiol/article/file?type=thumbnail&id=10.1371/journal.pcbi.1014193.e074)

We simulated the selection of an eye movement but not the eye-movement itself or the shift of the visual image caused by it.

### Training

We trained the networks in two phases. We first trained the feedforward network and we trained the recurrent network thereafter. The curve-tracing stimuli were random curves on a 36x36 grid, and stimuli for the object-parsing task were random objects on a 72x72 grid.

#### Training of feedforward networks.

We trained different feedforward networks for the curve-tracing and object-parsing tasks. Feedforward units for the curve-tracing task detected whether all image elements inside their RF were colinear and connected (using 50,000 stimuli for training) whereas units for the object-parsing task detected whether all inputs in their RF were active (10.000 stimuli) ([Fig 2B](#pcbi-1014193-g002), [2C](#pcbi-1014193-g002)).

We trained each spatial scale separately with backpropagation during 80 epochs using the Adam optimizer \[\] and a learning rate of 10 <sup>-3</sup>. Upon presentation of an input image, a cross-entropy loss was computed independently at each spatial scale ([Fig 2D](#pcbi-1014193-g002)) and the training objective was based on summed losses across scales. Because each scale has its own loss term, the scale-specific weights updates only depended on the error signals at that scale. The only exception concerns the weights which are shared across scales and therefore receive gradient contributions from all scale-specific losses ([Fig 2D](#pcbi-1014193-g002)).

We verified the accuracy with 100 stimuli for each task. Although we used error-backpropagation, we note that it could be replaced by a biologically plausible reinforcement learning rule \[\]. We assumed that the tuning of feedforward units had emerged during visual experience \[–\], prior to training on curve-tracing or object-parsing. We froze the weights of the feedforward network during the subsequent recurrent network training phase. We note that the feedforward architecture processes the various spatial scales in parallel, and its units only combine information within a limited spatial neighborhood so that they are unable to group pixels outside this range.

#### Training of the recurrent network.

Weights in the recurrent network were updated using RELEARNN, a local learning rule inspired by the Almeida-Pineda algorithm \[,,,\] that uses three phases. In the first phase, neural activity propagated through the network until convergence to a stable state. We considered that a stable state was reached if the activity of neurons between two consecutive timesteps was the same or after 30 timesteps. In the second phase, the network selected an eye movement, as described above, and an attention signal originating from the winning action propagated through an accessory network. This attentional feedback signal is proportional to the influence of each unit on the selected action. This accessory network can be conceived of as a linearized, transposed version of the activity propagation network and can therefore assign credit to synapses (for details see ref. \[\]). In the third phase, the network received a reward *r* of 1 unit in case the eye movement was correct and 0 otherwise. It then computed a reward prediction error *δ*:

(14)

where *Q* <sub><em>a</em></sub> is the activity of the selected output unit. The reward-prediction error *δ* could be broadcasted to the whole network by a neuromodulatory signal \[\]. The reward-prediction error *δ* and the attentional feedback signal are available at all synapses and determine the weight update, together with the pre- and post-synaptic activity. Hence, the required information is available locally at the synapse, making RELEARNN biologically plausible. We used a curriculum for training \[\], a strategy also used to train monkeys. The network was first presented with curves of 3 pixels. Once the network achieved 85% accuracy during a test phase with fixed weights and no exploration, we added one pixel to the curve and repeated this procedure until the curves were 7 pixels long.

To reduce the computation time, we used weight sharing, although this is biologically implausible. In previous work, we showed that networks with a similar structure learned to trace curves with or without weight-sharing, but that the number of trials needed to learn the task without weight-sharing was ~ 7 times larger \[\]. Hence, our results are likely to generalize to learning rules without weight sharing.

## Results

### Curve-tracing task

We trained 5 networks on a curve-tracing task, which was a variant of a task that has been used for electrophysiological recordings in the visual cortex of monkeys \[\] ([Fig 1A](#pcbi-1014193-g001),[1C](#pcbi-1014193-g001)). In the version of the task used here, the stimulus (illustrated in [Fig 1C](#pcbi-1014193-g001)) was presented at once ([Fig 3A](#pcbi-1014193-g003)), and the network was rewarded if it selected an eye movement to a blue pixel that was connected by a curve to a red pixel. We trained the networks with a curriculum in which the length of the curves was increased until they were 7 pixels long. We used a criterion of 85% accuracy to determine that a network had converged, but all networks reached an accuracy of 100% on the curve-tracing task, within an average of 23,200 trials. To examine whether the networks memorized specific curve configurations \[\] or learned a general grouping rule we generated fifteen curves with a length of 30 pixels. The accuracy of the networks was 100%, confirming that they learned a general solution. Units of the recurrent network had learned to iteratively spread enhanced activity across the representation of the target curve.

[![thumbnail](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1014193.g003)](https://journals.plos.org/ploscompbiol/article/figure/image?size=medium&id=10.1371/journal.pcbi.1014193.g003 "Click for larger image")

Download:
- [
	PNG
	larger image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=large&id=10.1371/journal.pcbi.1014193.g003)
- [
	TIFF
	original image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=original&id=10.1371/journal.pcbi.1014193.g003)

Fig 3. Networks propagate the response enhancement at multiple scales.

**A.** Spreading of activity by disinhibition. At *T*  = 1 the visual stimulus is presented, and the red pixel activates a pyramidal unit, which in turn activates VIP units in an adjacent column through horizontal connections (green), which cancels SOM inhibition and activates the next pyramidal cell at *T*  = 2. The disinhibition then propagates further along the target curve. **B.** Stimuli with gaps of two sizes between the target and distractor curve (not used in training). The size of the squares represents the scale that was used by the networks and color represents the time at which the attentional tag reached the RF. When the curves are far apart, tracing occurs faster and at a larger scale. **C.** We measured the activity of units with RFs before or after the gap. The activity elicited by the target curve was higher, and the response enhancement occurred later for units with RFs behind the gap (far) than for units with RFs before the gap (near). **D.** Latency of the response enhancement in the model (left) and in area V1 of monkeys (right). The response enhancement did not depend on gap size for near RFs before the gap. A narrow gap delayed the response enhancement of units with RFs beyond the gap.

[https://doi.org/10.1371/journal.pcbi.1014193.g003](https://doi.org/10.1371/journal.pcbi.1014193.g003)

The model learned to exploit the disinhibitory circuit to propagate enhanced activity through the recurrent network, starting from the red pixel ([Fig 3A](#pcbi-1014193-g003)). In the baseline state, SOM interneurons are spontaneously active and suppress pyramidal neurons with overlapping RFs. Feedforward input alone is insufficient to overcome this inhibition. Through trial-and-error learning, the network increased the weights from input units coding for red to the pyramidal neuron in the first hidden layer, which now overcame SOM-mediated inhibition (*T*  = 1 in [Fig 3A](#pcbi-1014193-g003)). This activation recruited adjacent VIP interneurons via horizontal and feedback connections. The VIP neurons, in turn, inhibited the SOM interneurons, thereby disinhibiting pyramidal cells representing the adjacent pixels of the target curve. Repetition of this disinhibitory interaction led to a stepwise propagation of enhanced activity along the target curve. We compared the present disinhibitory circuit to our previous excitatory recurrent model in ref. \[\] (Fig A in [S1 Text](#pcbi.1014193.s001)). The previous excitatory model exhibited progressive attenuation of the response enhancement along longer curves, resulting in impaired generalization to new and longer stimuli. In contrast, the present disinhibitory network maintained a stable activity difference between target and distractor representations, enabling reliable generalization to longer curves.

We next examined how the model’s tracing speed depends on the distance between the target and distractor curves. We presented stimuli with a bottleneck where the target curve came close to the distractor \[\] ([Fig 3B](#pcbi-1014193-g003)) and examined the activity of units with RFs before and after the bottleneck. The latency of the response enhancement, measured as the time-step where activity reached 90% of its maximum, was shorter for units with RFs before the bottleneck than for units with RFs behind ([Fig 3C](#pcbi-1014193-g003)). Narrowing the gap between the curves delayed the onset of the response enhancement, but only for RFs after the bottleneck ([Fig 3D](#pcbi-1014193-g003)), just as has been observed in the visual cortex of monkeys \[\] ([Fig 3D](#pcbi-1014193-g003)). The five models that we trained learned similar strategies and there was hardly any variability in their dynamics (absence of error bars in [Fig 3D](#pcbi-1014193-g003)).

We next examined the scales that were selected by the model ([Fig 3B](#pcbi-1014193-g003)) and noticed that the small gap enforced the spread of enhanced activity at lower network levels, where RFs were smaller. The propagation speed was also influenced by curvature because the network resorted to spreading activity at lower network levels if image elements in the larger RFs were not colinear. This results is in agreement with experimental evidence in humans that a higher curvature decreases tracing speed \[\].

### Object-parsing task

We next probed the ability of the networks to group image elements of 2-D objects, using a variant of an object-parsing task used in human participants \[,,\]. The participants reported whether a cue fell on the same object as the fixation point. The version for the network was like the curve tracing task of the previous section. The fixation point was a red pixel, and we placed a blue pixel on the same 2-D object and another one on a second object. The network had to plan an eye movement to the blue pixel on the same object as the fixation point ([Fig 4A](#pcbi-1014193-g004)).

[![thumbnail](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1014193.g004)](https://journals.plos.org/ploscompbiol/article/figure/image?size=medium&id=10.1371/journal.pcbi.1014193.g004 "Click for larger image")

Download:
- [
	PNG
	larger image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=large&id=10.1371/journal.pcbi.1014193.g004)
- [
	TIFF
	original image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=original&id=10.1371/journal.pcbi.1014193.g004)

Fig 4. Object-parsing task.

**A.** We examined how well the model could explain human RTs in image parsing tasks. We presented simplified images where objects were filled homogeneously and background locations were empty. Image: *Zebra mom and foal* by flowcomm, licensed under Creative Commons Attribution 4.0 International (CC BY 4.0) ([https://flic.kr/p/2rRCJVY](https://flic.kr/p/2rRCJVY)). **B.** Illustration of the spread of enhanced activity (orange) starting from the red dot. Large homogeneous image regions are filled faster (steps 5-15) than narrower regions (steps 25-35). **C.** Explained variance in human RTs collected by Jeurissen et al. (10) and Adeli et al. (19). We fitted the RTs with network models with either 2, 3 or 4 scales. Note that the quality of the fit improves for more scales. Error bars, standard errors. Red line, noise ceiling. \*, P < 0.05.

[https://doi.org/10.1371/journal.pcbi.1014193.g004](https://doi.org/10.1371/journal.pcbi.1014193.g004)

The models had the same architecture as those for the curve-tracing task ([Fig 2](#pcbi-1014193-g002)). We started with the recurrent units that been trained on the curve-tracing task and retrained their weights for the object-parsing task using the same RL process. However, we now used a feedforward network that was specifically trained for scale selection in the object-parsing task. All 5 networks reached an accuracy higher than 85% within 100 trials when tested in the object-parsing task. This additional training did not influence accuracy in the curve-tracing task, which remained 100%, implying that the recurrent architecture can account for both curve-tracing and object-parsing. The networks parsed the object that was cued by the red fixation point by spreading enhanced activity over its representation ([Fig 4B](#pcbi-1014193-g004)), just as has been observed in V1 of humans with fMRI \[\].

We next investigated the dynamics of the parsing process by comparing the processing time in the model to human RTs in two studies. The first experiment was by Jeurissen et al. \[\] who presented scrambled shapes, which could not be recognized by the participants ([Fig 4A](#pcbi-1014193-g004)). To model the RT, we estimated the timestep at which units in the output layer whose receptive field fell on the blue pixel enhanced their response by 90%. The model explained 55% of the variance of human RTs. The heuristic growth-cone model ([Fig 1](#pcbi-1014193-g001)) accounted for 63% of the variance, which is close to the noise ceiling of 67%. A key difference between the growth-cone model and its implementation as neural network is the number of scales. The neural network used four scales, whereas the number of scales used by the growth-cone model was not bounded. To further examine the dependence on the number of scales, we tested models with fewer scales. We observed that the models with 2 scales and 3 scales explained significantly less variance than the model with 4 scales (p < 10 <sup>-3</sup> and p = 0.03, respectively, see Methods) ([Fig 4C](#pcbi-1014193-g004)).

We replicated these findings modeling data from a second study that presented naturalistic images from the COCO dataset \[\]. We simplified the task by presenting object masks to the neural network and we measured the number of timesteps before the enhanced response reached the blue pixel on the same object as the fixation point ([Fig 4A](#pcbi-1014193-g004)). The neural network accounted for 15% of the variance in the human RTs, which is close to the 16% accounted for by the growth cone model and to the relatively low noise ceiling in this data set of 24%. These results imply that that the neural network accounted well for the patterns of human RTs in image parsing tasks.

## Discussion

In this study, we used neural networks to understand the propagation of object-based attention in curve-tracing and object-parsing tasks and how it can be learned \[\]. The processing time in curve tracing tasks increases linearly with the length of the curve that needs to be traced. In the visual cortex of monkeys \[,\] and humans \[,\], curve-tracing is associated with the gradual propagation of enhanced neuronal activity along the representation of the target curve \[\]. The speed of the tracing process depends on the curvature of the target curve and on its distance to distractor curves \[,\]. Recent studies started to examine the neuronal processes responsible for the parsing of 2-D surfaces and natural objects where the processing time also depends on the distance between the image locations that need to be grouped, and on the width of the image regions connecting them \[,\].

We trained a recurrent neural network to perform a curve-tracing task using trial-and-error learning, mimicking how monkeys are trained. With minimal additional training, the same networks could also parse spatially extended objects. Remarkably, the model accounted for many neurophysiological and psychophysical findings. We reproduced the pattern of RTs in humans in curve-tracing and image-parsing tasks, including the influence of the curvature and distance between curves and the width of image regions. Furthermore, the model developed a strategy to incrementally label the relevant curve or image region with enhanced neuronal activity, just as is observed in the visual cortex. The model thereby provides a neural network implementation of the conceptual “growth-cone” model ([Fig 1C](#pcbi-1014193-g001)) \[,,\], explaining why grouping speed depends on the distance between curves and the width of object regions. With only 4 scales, the network’s predictive power approached that of the growth-cone model, which had not yet been implemented as neural network and did not commit to a specific number of scales.

The model thereby goes beyond previous work on incremental grouping by neural networks. It learned to trace curves by trial-and-error at multiple scales, whereas previous networks for curve-tracing used a predetermined connectivity scheme and did not generalize to the parsing of 2D image regions \[,\]. The model also extends studies \[,\] that introduced a specialized hGRU unit for horizonal interactions to solve image parsing tasks. These models computed a measure of uncertainty, which had to be transformed into a measure of human RT and they accounted for less variance than the present model (21% vs. 55% for Jeurissen et al. \[\], and 7% vs. 15% for Adeli et al. \[\]).

The new model incorporated several key features inspired by the neurophysiology of the visual cortex. Firstly, we created a hierarchically organized network with larger RFs in higher layers, which enabled the faster grouping of straight curves and homogeneous image regions \[\]. Secondly, we used a feedforward and a recurrent network with separate roles. Units of the feedforward network provided a veridical representation of the stimulus, providing a stable scaffold for the spreading of enhanced activity in the recurrent network. There are neurons with similar properties in input layers 4 and 6 of the visual cortex of monkeys \[–\], which do not participate in incremental grouping. We trained the feedforward units to only respond to image regions that unambiguously belonged to a single object, enabling the network to select the appropriate scale. The feedforward network gated the recurrent units and thereby enabled a set of recurrent interactions that was appropriate for the scale of the stimulus in the RF \[\]. Neurons in the recurrent network learned to spread enhanced activity over the representation of the target object. In the cortex, such neurons that participate in incremental grouping are prominent in layers 2, 3 and 5 \[,\]. Thirdly, we implemented a disinhibitory scheme in which VIP interneurons inhibited SOM interneurons, thereby disinhibiting pyramidal units. Our implementation is consistent with experimental evidence in the visual cortex of mice showing that visual stimuli in the surround of the RF of pyramidal neurons elicit SOM mediated inhibition \[–\]. VIP neurons can release this inhibition by inhibiting SOM neurons, thereby disinhibiting the pyramidal cells \[,–\]. This interaction between VIP, SOM and pyramidal neurons contributes to figure–ground segregation \[,\], just as in the present model. This disinhibitory circuit has computational advantages, because the maximal activity of the excitatory units in the circuit is bounded by their feedforward input, preventing run-away excitation and guaranteeing that the network reaches a stable state. A variant of such a disinhibitory loop was used in previous work on how networks learn to track moving objects across successive frames of a movie \[\]. Here this disinhibitory circuit enabled the network to trace long curves, overcoming the attenuation of the response enhancement occurring in previous work \[\].

The present study may inspire future work on the neuronal mechanisms underlying image parsing. One limitation of the present approach is that we pretrained feedforward units to detect stimulus configurations permitting grouping at larger spatial scales, before training the recurrent network to trace curves using reinforcement learning. In the developing visual system, sensitivity to colinear and other grouping cues emerges gradually and learning continues into late childhood \[\], suggesting that feedforward representations and grouping dynamic likely co-develop rather than being strictly serial. In a previous study on curve-tracing with only a single scale \[\], we were able to train the feedforward and recurrent networks jointly, in an end-to-end manner. The strategy did, however, not consistently elicit grouping across all scales in the present multiscale architecture, although a form of disinhibitory propagation did emerge. This result indicates that learning grouping across multiple scales imposes additional constraints that are not automatically satisfied by our reinforcement learning scheme.

Future studies could investigate whether joint training of feedforward and recurrent pathways can be achieved by introducing appropriate regularization terms, curriculum strategies, or alternative architectural designs. More broadly, other perceptual grouping cues, like similarity of motion, color or luminance \[\], are also acquired during development. A compelling direction for future work would be to develop biologically realistic learning rules that allow the simultaneous emergence of such grouping heuristics at higher network levels, together with the propagation of enhanced neuronal activity that underlies incremental grouping.

It would also be of interest to generalize the present approach to segment natural images, which is a process that depends on object-recognition \[\]. Indeed, humans parse upright images more efficiently than images that are presented upside down \[,\], illustrating how object recognition aids image parsing. Although the segmentation of natural images is a largely solved problem for transformer-based deep neural networks, the mechanisms for image parsing in the human brain remain only partially understood. The present approach could be generalized to model the recognition of objects in cortical areas, which provide feedback to label individual object parts and low-level features, represented in lower visual cortical areas with enhanced neuronal activity.

In conclusion, the present results provide insight into how brain-like networks learn to integrate grouping cues represented at lower and higher network levels by the spread of enhanced neuronal activity. At a psychological level of description, this process maps onto the spread of object-based attention across all features that are integrated in coherent object representations \[,\]. We look forward to future work, leveraging the highly productive convergence between machine learning, neuroscience and perceptual psychology, to help us better understand how rich, multi-feature object representations emerge in our conscious perception.

## Materials and methods

### Visual stimuli

We probed the capacity of the network to select the blue pixel that was on the same curve or object as the red pixel. We generally used images with 108x108 pixels with three color channels; red, blue and green ([Fig 1C](#pcbi-1014193-g001)). To test scale selection, we also presented images with 144x144 pixels for the curve tracing task, and 594x594 pixels for the object parsing task. The larger images did not require fine-tuning because we used weight-sharing.

### Estimation of human RTs

To analyze the pattern of human RTs, we followed the procedures of the studies where they were gathered. To model the results of Jeurissen et al. \[\], we analyzed RTs on correct trials with the fixation point and cue on the same object. We removed outliers that deviated from the mean of the 1/RT distribution by more than 2.5 standard deviations. We averaged the RTs across participants, so that there was one RT for every combination of image (20 images) and cue (3 cue positions per image). For Adeli et al. \[\] we also analyzed RTs on correct trials with the fixation point and cue on the same object. We computed the average RTs across participants for every combination of image (255 images) and cue (2 cue positions per image). We performed a regression analysis to test how well RTs were predicted by the growth-cone model, and the artificial neural network.

We computed the standard error for the coefficients of determination (R [^2]) using Cohen et al. (2003) \[\] formula (p. 88):

![](https://journals.plos.org/ploscompbiol/article/file?type=thumbnail&id=10.1371/journal.pcbi.1014193.e080)

Where n is the number of observations and k is the number of independent variables.

To compare R <sup>2</sup> values between the model with 4 scales and models with 2 or 3 scales, we computed the standard error of the difference:

![](https://journals.plos.org/ploscompbiol/article/file?type=thumbnail&id=10.1371/journal.pcbi.1014193.e081)

Then, we calculated the Z-score:

![](https://journals.plos.org/ploscompbiol/article/file?type=thumbnail&id=10.1371/journal.pcbi.1014193.e082)

Finally, we determined the p-value using:

![](https://journals.plos.org/ploscompbiol/article/file?type=thumbnail&id=10.1371/journal.pcbi.1014193.e083)

## Supporting information

Alternatives for the disinhibitory connection scheme  
To examine the role of disinhibition in stable long-range grouping,we compared the present  
architecture to previous networks \[17\] in which excitatory units directly activated neighboring  
excitatory units, without an intervening inhibitory circuit. When implemented with ReLU nonlinearities,  
the excitatory recurrent networks were unstable because activity is unbounded. Replacing the ReLU  
with a squashing nonlinearity prevented runaway excitation but introduced a different limitation  
because the magnitude of the response enhancement decreased progressively along the target  
curve. These networks failed to reliably trace curves longer than 12 pixels, consistent with previous  
findings \[17\].  
In contrast, the disinhibitory circuit enabled stable propagation of enhanced activity without  
attenuation, allowing the network to generalize to curves substantially longer than those presented  
during training. The panel A of the supplemental figure compares the generalization performance of  
the model developed in ref.\[17\],which combined excitatory connectivity with a squashing  
nonlinearity, to the present disinhibitory model.When trained to trace curves up to length N, the  
performance of the excitatory model deteriorated for curves longer than N \+ 4. By contrast,the  
disinhibitory model maintains high performance as curve length increases.  
This difference becomes apparent when comparing activity between these network types  
(Supplemental Figure, panels B,C). In the disinhibitory model, pyramidal units are either suppressed  
by SOM units of fully disinhibited once the propagating signal reaches them. This bistable regime  
prevents attenuation of the activity difference between target and distractor curves so that the contrast  
between grouped and non-grouped elements remains stable over distance. In contrast, in models with  
excitatory units with a squashing nonlinearity, the activity difference decreases along the target curve  
and eventually vanishes, preventing reliable discrimination from the target curve.

### S1 Text. Alternatives for the disinhibitory connection scheme. Fig A. Comparison of the model with disinhibition to models composed of excitatory units and a squashing non-linearity.

[https://doi.org/10.1371/journal.pcbi.1014193.s001](https://doi.org/10.1371/journal.pcbi.1014193.s001)

(DOCX)

## References

[^1]: 1.
- [View Article](https://doi.org/10.1038/26475 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/9759726 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Object-based+attention+in+the+primary+visual+cortex+of+the+macaque+monkey+Roelfsema+1998 "Go to article in Google Scholar")

[^2]: 2.
- [View Article](https://doi.org/10.1146/annurev.neuro.29.051605.112939 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/16776584 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Cortical+algorithms+for+perceptual+grouping+Roelfsema+2006 "Go to article in Google Scholar")

[^3]: 3.
- [View Article](https://doi.org/10.3758/s13414-011-0200-0 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/21901573 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Incremental+grouping+of+image+elements+in+vision+Roelfsema+2011 "Go to article in Google Scholar")

[^4]: 4.
- [View Article](https://doi.org/10.4324/9781315009292/PRINCIPLES-GESTALT-PSYCHOLOGY-KOFFKA "Go to article")
- [Google Scholar](http://scholar.google.com/scholar?q=Principles+of+gestalt+psychology+Koffka+2013 "Go to article in Google Scholar")

[^5]: 5.
- [View Article](https://doi.org/10.1007/bf00410640 "Go to article")
- [Google Scholar](http://scholar.google.com/scholar?q=Untersuchungen+zur+Lehre+von+der+Gestalt.+II+Wertheimer+1923 "Go to article in Google Scholar")

[^6]: 6.
- [View Article](https://doi.org/10.1038/303696a0 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/6855915 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Parallel+versus+serial+processing+in+rapid+pattern+discrimination+Bergen+1983 "Go to article in Google Scholar")

[^7]: 7.
- [View Article](https://doi.org/10.3758/bf03198373 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/3724444 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Curve+tracing%3A+a+possible+basic+operation+in+the+perception+of+spatial+relations+Jolicoeur+1986 "Go to article in Google Scholar")

[^8]: 8.
- [View Article](https://doi.org/10.1371/journal.pbio.1002420 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/27015604 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=The+Effects+of+Context+and+Attention+on+Spiking+Activity+in+Human+Early+Visual+Cortex+Self+2016 "Go to article in Google Scholar")

[^9]: 9.
- [View Article](https://doi.org/10.1016/j.cub.2014.10.007 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/25456446 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=A+growth-cone+model+for+the+spread+of+object-based+attention+during+contour+grouping+Pooresmaeili+2014 "Go to article in Google Scholar")

[^10]: 10.
- [View Article](https://doi.org/10.1016/s0042-6989\(01\)00148-1 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/11520504 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=The+spatial+profile+of+visual+attention+in+mental+curve+tracing+Scholte+2001 "Go to article in Google Scholar")

[^11]: 11.
- [View Article](https://doi.org/10.3758/bf03194840 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/14674639 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=A+gradual+spread+of+attention+during+mental+curve+tracing+Houtkamp+2003 "Go to article in Google Scholar")

[^12]: 12.
- [View Article](https://doi.org/10.3758/bf03199570 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/1956308 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Predicting+the+shape+of+distance+functions+in+curve+tracing%3A+evidence+for+a+zoom+lens+operator+McCormick+1991 "Go to article in Google Scholar")

[^13]: 13.
- [View Article](https://doi.org/10.1037//0096-1523.17.4.997 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/1837310 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Visual+curve+tracing+properties+Jolicoeur+1991 "Go to article in Google Scholar")

[^14]: 14.
- [View Article](https://doi.org/10.3758/bf03198493 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/2017027 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Size+invariance+in+curve+tracing+Jolicoeur+1991 "Go to article in Google Scholar")

[^15]: 15.
- [View Article](https://doi.org/10.7554/ELIFE.14320 "Go to article")
- [Google Scholar](http://scholar.google.com/scholar?q=Serial+grouping+of+2D-image+regions+with+object-based+attention+in+humans+Jeurissen+2016 "Go to article in Google Scholar")

[^16]: 16.
- [View Article](https://doi.org/10.1016/j.visres.2022.108057 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/35487147 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=A+multi-scale+neurodynamic+implementation+of+incremental+grouping+Domijan+2022 "Go to article in Google Scholar")

[^17]: 17.
- [View Article](https://doi.org/10.1371/journal.pcbi.1012030 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/38683837 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Recurrent+neural+networks+that+learn+multi-step+visual+routines+with+reinforcement+learning+Mollard+2024 "Go to article in Google Scholar")

[^18]: 18.
- [View Article](https://doi.org/10.1126/sciadv.abe1833 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/34193411 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=The+essential+role+of+recurrent+processing+for+figure-ground+perception+in+mice+Kirchberger+2021 "Go to article in Google Scholar")

[^19]: 19.
- [View Article](https://doi.org/10.1371/journal.pcbi.1004489 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/26496502 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Reinforcement+Learning+of+Linking+and+Tracing+Contours+in+Recurrent+Neural+Networks+Brosch+2015 "Go to article in Google Scholar")

[^20]: 20.
- [View Article](https://doi.org/10.1073/pnas.0431051100 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/12695564 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Subtask+sequencing+in+the+primary+visual+cortex+Roelfsema+2003 "Go to article in Google Scholar")

[^21]: 21\. [https://arxiv.org/abs/2306.00294v1](https://arxiv.org/abs/2306.00294v1)

[^22]: 22.
- [View Article](https://doi.org/10.1038/ncomms13804 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/28054544 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Layer-specificity+in+the+effects+of+attention+and+working+memory+on+activity+in+primary+visual+cortex+van+Kerkoerle+2017 "Go to article in Google Scholar")

[^23]: 23.
- [View Article](https://doi.org/10.1523/JNEUROSCI.1388-10.2010 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/20861375 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Separable+codes+for+attention+and+luminance+contrast+in+the+primary+visual+cortex+Pooresmaeili+2010 "Go to article in Google Scholar")

[^24]: 24.
- [View Article](https://doi.org/10.1016/j.cub.2013.09.013 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/24139742 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Distinct+roles+of+the+cortical+layers+of+area+V1+in+figure-ground+segregation+Self+2013 "Go to article in Google Scholar")

[^25]: 25.
- [View Article](https://doi.org/10.1038/s41467-022-28552-w "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/35232956 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Feedforward+and+feedback+interactions+between+visual+cortical+areas+use+different+population+activity+patterns+Semedo+2022 "Go to article in Google Scholar")

[^26]: 26.
- [View Article](https://doi.org/10.1016/j.visres.2014.12.010 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/25542276 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Selective+disinhibition%3A+A+unified+neural+mechanism+for+predictive+and+post+hoc+attentional+selection+Sridharan+2015 "Go to article in Google Scholar")

[^27]: 27.
- [View Article](https://doi.org/10.1162/08989290152001907 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/11388921 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=From+knowing+what+to+knowing+where%3A+modeling+object-based+attention+with+feedback+disinhibition+of+activation+van+Der+Velde+2001 "Go to article in Google Scholar")

[^28]: 28.
- [View Article](https://doi.org/10.1038/nature12676 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/24097352 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Cortical+interneurons+that+specialize+in+disinhibitory+control+Pi+2013 "Go to article in Google Scholar")

[^29]: 29.
- [View Article](https://doi.org/10.1146/annurev-vision-111815-114443 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/28532363 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Early+Visual+Cortex+as+a+Multiscale+Cognitive+Blackboard+Roelfsema+2016 "Go to article in Google Scholar")

[^30]: 30.
- [View Article](https://doi.org/10.1016/S0140-6736\(51\)92942-X "Go to article")
- [Google Scholar](http://scholar.google.com/scholar?q=Reinforcement+Learning%3A+An+Introduction+Sutton+2018 "Go to article in Google Scholar")

[^31]: 31\. [https://arxiv.org/abs/1412.6980v9](https://arxiv.org/abs/1412.6980v9)
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=+Kingma+2014 "Go to article in Google Scholar")

[^32]: 32\. [https://papers.nips.cc/paper/2020/hash/1abb1e1ea5f481b589da52303b091cbb-Abstract.html](https://papers.nips.cc/paper/2020/hash/1abb1e1ea5f481b589da52303b091cbb-Abstract.html)
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=+Pozzi+2020 "Go to article in Google Scholar")

[^33]: 33.
- [View Article](https://doi.org/10.1017/s0952523803205101 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/14977335 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Development+of+contour+integration+in+macaque+monkeys+Kiorpes+2003 "Go to article in Google Scholar")

[^34]: 34.
- [View Article](https://doi.org/10.1016/s0166-4328\(05\)80202-5 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/1388795 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Visual+segmentation+of+oriented+textures+by+infants+Atkinson+1992 "Go to article in Google Scholar")

[^35]: 35.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=Contour+integration+in+human+infants+Norcia+2002 "Go to article in Google Scholar")

[^36]: 36.
- [View Article](https://doi.org/10.1016/s0163-6383\(98\)90054-6 "Go to article")
- [Google Scholar](http://scholar.google.com/scholar?q=Infants%E2%80%99+use+of+featural+information+in+the+segregation+of+stationary+objects+Needham+1998 "Go to article in Google Scholar")

[^37]: 37.
- [View Article](https://doi.org/10.1177/0956797615571442 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/25878172 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=8-month-old+infants+spontaneously+learn+and+generalize+hierarchical+rules+Werchan+2015 "Go to article in Google Scholar")

[^38]: 38\. [https://proceedings.neurips.cc/paper\_files/paper/2020/hash/766d856ef1a6b02f93d894415e6bfa0e-Abstract.html](https://proceedings.neurips.cc/paper_files/paper/2020/hash/766d856ef1a6b02f93d894415e6bfa0e-Abstract.html)
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=+Linsley+2020 "Go to article in Google Scholar")

[^39]: 39.
- [View Article](https://doi.org/10.1126/science.275.5306.1593 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/9054347 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=A+neural+substrate+of+prediction+and+reward+Schultz+1997 "Go to article in Google Scholar")

[^40]: 40.
- [View Article](https://doi.org/10.1142/9789812818041_0004 "Go to article")
- [Google Scholar](http://scholar.google.com/scholar?q=Algorithms+for+the+detection+of+connectedness+and+their+neural+implementation+Roelfsema+1999 "Go to article in Google Scholar")

[^41]: 41.
- [View Article](https://doi.org/10.1177/0956797612443832 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/23137967 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=The+time+course+of+perceptual+grouping+in+natural+scenes+Korjoukov+2012 "Go to article in Google Scholar")

[^42]: 42.
- [View Article](https://doi.org/10.1523/JNEUROSCI.0438-20.2020 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/33087475 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Object+Selection+by+Automatic+Spreading+of+Top-Down+Attentional+Signals+in+V1+Ekman+2020 "Go to article in Google Scholar")

[^43]: 43.

[^44]: 44.
- [View Article](https://doi.org/10.1038/s41593-019-0520-2 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/31659335 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=A+deep+learning+framework+for+neuroscience+Richards+2019 "Go to article in Google Scholar")

[^45]: 45.
- [View Article](https://doi.org/10.1371/journal.pcbi.1012835 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/40338986 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=A+model+of+thalamo-cortical+interaction+for+incremental+binding+in+mental+contour-tracing+Schmid+2025 "Go to article in Google Scholar")

[^46]: 46.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=Learning+long-range+spatial+dependencies+with+horizontal+gated+recurrent+units+Linsley+2018 "Go to article in Google Scholar")

[^47]: 47.
- [View Article](https://doi.org/10.52202/075280-0630 "Go to article")
- [Google Scholar](http://scholar.google.com/scholar?q=+Ahuja+2023 "Go to article in Google Scholar")

[^48]: 48.
- [View Article](https://doi.org/10.1523/JNEUROSCI.3967-15.2016 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/27053207 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Brain-Wide+Maps+of+Synaptic+Input+to+Cortical+Interneurons+Wall+2016 "Go to article in Google Scholar")

[^49]: 49.
- [View Article](https://doi.org/10.1038/nn.3446 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/23817549 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Inhibition+of+inhibition+in+visual+cortex%3A+the+logic+of+connections+between+molecularly+distinct+interneurons+Pfeffer+2013 "Go to article in Google Scholar")

[^50]: 50.
- [View Article](https://doi.org/10.1038/nature11526 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/23060193 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=A+neural+circuit+for+spatial+summation+in+visual+cortex+Adesnik+2012 "Go to article in Google Scholar")

[^51]: 51.
- [View Article](https://doi.org/10.1038/nn.3917 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/25622573 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=The+neocortical+circuit%3A+themes+and+variations+Harris+2015 "Go to article in Google Scholar")

[^52]: 52.
- [View Article](https://doi.org/10.1126/science.1254126 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/25104383 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Selective+attention.+Long-range+and+local+circuits+for+top-down+modulation+of+visual+cortex+processing+Zhang+2014 "Go to article in Google Scholar")

[^53]: 53.
- [View Article](https://doi.org/10.1523/JNEUROSCI.3646-15.2016 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/27013676 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Opening+Holes+in+the+Blanket+of+Inhibition%3A+Localized+Lateral+Disinhibition+by+VIP+Interneurons+Karnani+2016 "Go to article in Google Scholar")

[^54]: 54.
- [View Article](https://doi.org/10.1016/j.neuron.2020.11.013 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/33301712 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=A+Disinhibitory+Circuit+for+Contextual+Modulation+in+Primary+Visual+Cortex+Keller+2020 "Go to article in Google Scholar")

[^55]: 55.
- [View Article](https://doi.org/10.48550/arXiv.2105.13351 "Go to article")
- [Google Scholar](http://scholar.google.com/scholar?q=Tracking+Without+Re-recognition+in+Humans+and+Machines+Linsley+2021 "Go to article in Google Scholar")

[^56]: 56.
- [View Article](https://doi.org/10.1016/j.visres.2010.01.021 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/20149911 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=The+effects+of+spatial+proximity+and+collinearity+on+contour+integration+in+adults+and+children+Hadad+2010 "Go to article in Google Scholar")

[^57]: 57.
- [View Article](https://doi.org/10.1038/nn.2910 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/21926984 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Automatic+spread+of+attentional+response+modulation+along+Gestalt+criteria+in+primary+visual+cortex+Wannig+2011 "Go to article in Google Scholar")

[^58]: 58.
- [View Article](https://doi.org/10.1101/2024.09.09.612033 "Go to article")
- [Google Scholar](http://scholar.google.com/scholar?q=Modeling+attention+and+binding+in+the+brain+through+bidirectional+recurrent+gating+Salehi+2024 "Go to article in Google Scholar")

[^59]: 59.
- [View Article](https://doi.org/10.3758/bf03214214 "Go to article")
- [Google Scholar](http://scholar.google.com/scholar?q=Is+visual+image+segmentation+a+bottom-up+or+an+interactive+process%3F+Vecera+1997 "Go to article in Google Scholar")

[^60]: 60.