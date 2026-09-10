---
title: "A tale of two algorithms: Structured slots explain prefrontal sequence memory and are unified with hippocampal cognitive maps"
source: "https://www.sciencedirect.com/science/article/pii/S0896627324007657"
author:
  - "[[behavior]]"
  - "[[Timothy E.J. Behrens]]"
  - "[[Surya Ganguli]]"
published:
created: 2026-09-10
description: "Remembering events is crucial to intelligent behavior. Flexible memory retrieval requires a cognitive map and is supported by two key brain systems: h…"
tags:
  - "clippings"
---
[![Neuron](https://ars.els-cdn.com/content/image/B08966273.svg)](https://www.sciencedirect.com/journal/neuron "Go to Neuron on ScienceDirect")

[Volume 113, Issue 2](https://www.sciencedirect.com/journal/neuron/vol/113/issue/2 "Go to table of contents for this volume/issue"), 22 January 2025, Pages 321-333.e6

## ArticleA tale of two algorithms: Structured slots explain prefrontal sequence memory and are unified with hippocampal cognitive maps

[https://doi.org/10.1016/j.neuron.2024.10.017](https://doi.org/10.1016/j.neuron.2024.10.017 "Persistent link using digital object identifier")

Under a Creative Commons [license](http://creativecommons.org/licenses/by/4.0/)

Open access

[Prefrontal working memory activity slots support sequence memory similar to hippocampal long-term memory position recall](https://www.sciencedirect.com/science/article/pii/S0896627324009218 "Prefrontal working memory activity slots support sequence memory similar to hippocampal long-term memory position recall")

Yannik Hilla, Charline Peylo, Paul Sauseng

[View PDF](https://www.sciencedirect.com/science/article/pii/S0896627324009218/pdfft?md5=d49e605036ae2d28c531eff28d9bc7dc&pid=1-s2.0-S0896627324009218-main.pdf)

## Highlights

- •
	A duality between the prefrontal (working) and hippocampal (episodic) sequence memory algorithms
- •
	Mechanistic understanding of prefrontal working memory as controllable activity slots
- •
	Recurrent [neural networks](https://www.sciencedirect.com/topics/computer-science/neural-network) learn activity slots on a wide array of sequence memory tasks
- •
	Prefrontal working memory representations explained as controllable activity slots

- Next article in issue

## Keywords

prefrontal cortex

hippocampus

cognitive maps

sequence memory

working memory

episodic memory

recurrent neural networks

neural algorithms

neural representations

## Introduction

Predicting what will happen next in novel environments is a fundamental feature of intelligent cognition. However, due to the one-dimensional (1D) and irreversible nature of time itself, we can only learn about structured environments through sequential experience. Thus, brains<sup>,</sup><sup>,</sup> and machines<sup>,</sup><sup>,</sup> must convert sequential experience into internal models of the world to remember and exploit structured relationships. When such an internal model, or cognitive map, emerges, it can allow additional flexibility beyond next-step prediction, such as inferring new routes to goals or simulating counterfactual scenarios. An algorithmic understanding of how sequential experience is converted into a rich cognitive map capable of predicting future counterfactual consequences of diverse potential actions remains a major aim of cognitive [neuroscience](https://www.sciencedirect.com/topics/psychology/neuroscience).

Two key brain regions build cognitive maps from sequential experience: the [episodic memory](https://www.sciencedirect.com/topics/social-sciences/episodic-memory) (EM) system in the [medial temporal lobe](https://www.sciencedirect.com/topics/psychology/medial-temporal-lobe) and the working memory (WM) system in the [prefrontal cortex](https://www.sciencedirect.com/topics/psychology/prefrontal-cortex) (PFC).<sup>,</sup><sup>,</sup> However, it is not clear how these brain systems are related in representation or underlying algorithm.

For sequential EM in [hippocampus](https://www.sciencedirect.com/topics/neuroscience/hippocampus) (HPC), ideas are emerging on the underlying algorithms and representations.<sup>,</sup><sup>,</sup><sup>,</sup> In these models, memories are stored in HPC by updating [synaptic connections](https://www.sciencedirect.com/topics/engineering/synaptic-connection) (e.g., [Hopfield networks](https://www.sciencedirect.com/topics/computer-science/hopfield-network)), with cortical [recurrent neural networks](https://www.sciencedirect.com/topics/chemical-engineering/recurrent-neural-network) (RNNs) controlling which memory to store or retrieve by [tracking position](https://www.sciencedirect.com/topics/computer-science/tracking-position) (ordinal, spatial, or otherwise) within the sequence. These models explain many cellular recordings for both spatial and non-spatial tasks: hippocampal cells, such as place cells, landmark cells, and splitter cells, are explained as memory representations, whereas entorhinal cells, such as [grid cells](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/grid-cell), object-vector cells, border-vector cells, non-spatial grid cells,<sup>,</sup> and non-spatial [sound frequency](https://www.sciencedirect.com/topics/earth-and-planetary-sciences/acoustic-frequency) cells, are explained as RNN position representations. Importantly, the hippocampal literature shows us that sequence memory is not just remembering sequences exactly as they were presented but rather using structured knowledge (e.g., position) to recall the right memory at the right time. Successful sequence memory goes beyond rote memorization of experience but instead reflects a cognitive map-building process that learns systematic relationships between events induced by the underlying task structure.<sup>,</sup><sup>,</sup><sup>,</sup><sup>,</sup>

For sequence WM in PFC, our understanding is limited to remembering sequences exactly as they were presented. Here, findings from both artificial<sup>,</sup><sup>,</sup> and biological networks suggest memories of items are organized into, and moved between,<sup>,</sup> neural subspaces according to their ordinal position. Crucially, unlike HPC, storing these memories requires no [synaptic plasticity](https://www.sciencedirect.com/topics/psychology/synaptic-plasticity) because [recurrent](https://www.sciencedirect.com/topics/engineering/recurrent) connections maintain memories in neural activity. Although this is revealing, PFC is implicated in tasks beyond remembering sequences exactly as they were presented, i.e., tasks that required flexible control of memory retrieval.<sup>,</sup><sup>,</sup> Because we understand how HPC EM models allow such flexible control, if we could relate PFC WM and HPC EM, then we could understand how the PFC WM system flexibly controls memories to solve tasks requiring cognitive map-like knowledge of structured relationships.

In this work, we provide an understanding of sequence WM in PFC and how it relates, in representation and algorithm, to HPC EM. In particular, we (1) develop a unifying theory of storing sequence memories in [synapses](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/synapse) (EM) and neural activity (WM); (2) demonstrate that the two algorithms differ in their ability to scale to larger task sizes; (3) demonstrate how the different algorithms utilize different [neural representations](https://www.sciencedirect.com/topics/computer-science/neural-representation), with EM using abstract positions, whereas WM uses slots (distinct neural subspaces) in neural activity; (4) demonstrate that WM slot representation affords “scene algebra”; (5) demonstrate how internally computed [velocity signals](https://www.sciencedirect.com/topics/computer-science/velocity-signal) control the contents of PFC slots; and (6) show that our theory of controllable activity slots provides a common explanation for PFC data from several disparate studies. Overall, a main dividend of our derived duality between HPC EM and PFC WM is a new, unifying theoretical framework for how PFC WM networks could implement and control dynamic cognitive maps of the environment or task through recurrent updates of neural activity alone, without any [synaptic plasticity](https://www.sciencedirect.com/topics/neuroscience/synaptic-plasticity).

### Theory: Unifying memories stored in synapses and neural activity

#### Sequence memory is a structure learning problem

Sequence memory tasks depend on underlying task structures. For example, in immediate serial recall (ISR; a series of observations must be recalled in order) the underlying structure is an ordinal line. Other sequences have different underlying structures, e.g., a sequence drawn from navigating two-dimensional (2D) space has embedded 2D structure. Internal representations that include this structural knowledge dramatically facilitate recall and prediction as different structures have different transition functions. For example, in a 2D [navigation task](https://www.sciencedirect.com/topics/computer-science/navigation-task), correct predictions rely on knowing you have returned to a previous position, which itself requires knowledge of the structure of 2D space (i.e., how recent velocities integrate). Exploiting knowledge of task structure facilitates recall and prediction in problems with a common structural constraint, even when each problem consists of sequences with different observations (therefore, one problem’s sequence cannot be memorized and used for another problem). Here, the underlying task structure must be meta-learned across problems (learning to learn; A left for example ISR task).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr1.jpg)

Download: Download high-res image (1015KB)

#### Task and problem formalism

Formally, for each task, we consider a dataset . Each is one of *N* problem instances of the common task and is a sequence consisting of vectors of observations, , of dimension (termed ), targets, , and (allocentric) velocities, , i.e., for a sequence of length *K*. Although velocities reflect an agent’s actions (conceptual or physical), we provide them externally. Importantly, the underlying structure of the task is determined by how successive actions cumulatively change a latent task state, which is never directly observed by the agent.

Concretely, we assume an underlying latent variable, , corresponding to a latent agent/task state (e.g., position in spatial contexts). Furthermore, we assume each latent state, or position, , is associated with an observation, , which the agent sees if it has the corresponding latent state/position . For any ordered pair of neighboring source and target latent states, there is an action, or velocity, , that modifies the agent’s latent state from the source to the target (e.g., A left for a loop structure with one action). The task structure is encoded by how actions/velocities, change the latent state/position. For example, when navigating in a [2D grid](https://www.sciencedirect.com/topics/computer-science/two-dimensional-grid), there are four elementary actions/velocities—one step north, south, west, or east—with each step moving the latent 2D grid position by one step in the corresponding direction. When a sequence of velocities additively cancel (e.g., north + east + south + west = 0 for a 2D grid), the agent returns to the same latent position and encounters the same observation as before.

For a single task , each individual problem instance assumes a different and random pairing of observations , to latent states . However, all *N* problem instances share the *same* underlying task structure. The aim of the task is to predict a target, , at each timestep: either an upcoming observation (i.e., what you will see after going north), or a past observation (i.e., what you saw 5 steps ago). Importantly, neither latent states nor how actions affect latent states are directly observed. Instead, the agent experiences a sequence of observations and actions. Solving the task, across all problems, requires building a cognitive map capturing how actions affect latent states, and how latent states are bound to observations. Only then, can the agent predict what it will see next when first returning to a previous position. We note that the task formalism (and subsequent model formalism) is general to both discrete and continuous tasks, although we primarily consider discrete tasks here.

We now develop a theory for a simple network realization of an EM solution and from that derive a simple network realization of a WM solution. Crucially, we later show that many features of these simple solutions hold in more general scenarios, both in artificial and biological networks that successfully solve structured sequence memory tasks.

#### Solving sequence memory tasks with EM

The hippocampal literature has developed EM models that solve these tasks.<sup>,</sup> These models have two components (A top-middle): an RNN that learns to explicitly represent position, which generalizes across tasks, and a memory system that binds observation to position representations and stores this memory in [synaptic weights](https://www.sciencedirect.com/topics/engineering/synaptic-weight). These memory [weights change](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/body-weight-change) in every problem because different problems have different associations of observation to latent state/position. In its simplest form, the RNN has a [single neuron](https://www.sciencedirect.com/topics/engineering/single-neuron) active for each position (A middle; full theory in ). Memories are encoded in [synaptic weights](https://www.sciencedirect.com/topics/computer-science/synaptic-weight) between each RNN neuron (corresponding to a position) and an observation representation, with memories added via [Hebbian learning](https://www.sciencedirect.com/topics/psychology/hebbian-learning). The RNN tracks the underlying latent variable, , so that the correct position neuron is activated at the right time to retrieve the right memory (A middle). Tracking position means the RNN integrates velocity signals, , to update its representation from to (i.e., from position to position ). This can be done with velocity-dependent matrices, , that follow the transition rules of (e.g., ; going north then south returns you to the same position). Mathematically, the RNN update is (C). Generating target predictions is succinctly described in the following equation (assuming all observations, , have already been added as memories):(Equation 1)Here, an initial RNN representation, , is successively updated by velocity-dependent matrices, , to represent position at timestep : . To make predictions, selects (similar to an attention vector) one of the observations stored in memory slots in synaptic weights (B; synaptic memory slots are non-overlapping sets of synaptic connections that can be rapidly updated to store arbitrary memories, and each slot corresponds to a position and stores the observation at position ; ). For clarity, we presented a basis where the RNN has one [neuron active](https://www.sciencedirect.com/topics/engineering/active-neuron) at any time, and the matrices have columns containing a single 1 (C), although the above solutions work in any basis, i.e., , . Under simple constraints, the optimal solution is a grid cell basis.<sup>,</sup>

#### Solving sequence memory tasks with WM

The PFC is thought to store memories in the dynamics of neural activity as opposed to synaptic connections<sup>,</sup> (1A top-right; although see Stokes). Here, we show that reshaping and rearranging produces an alternative but equivalent solution where memories are stored in RNN activity rather than synaptic connections (A right):(Equation 2) performs the exact same computation as the, although its terms, despite being similar, are different (). What was a matrix of memories stored in synaptic weights, , becomes a vector of memories stored in RNN activity, . Thus, neural activity is decomposable into non-overlapping subspaces termed activity slots, with each slot able to store a memory of an arbitrary observation (A right). Readout weights are now fixed and attend to a single slot (D; here, slot 1 is the readout slot, but in general, it depends on task structure, e.g., ). To readout the right memory at the right time, the contents of each slot must be copied and shifted to other slots via recurrent weights . These WM velocity-dependent matrices are expanded (and transposed) versions of the EM velocity-dependent matrices, (example in E). Intuitively, is bigger than (by a factor of ) because the WM RNN tracks [relative position](https://www.sciencedirect.com/topics/computer-science/relative-position) to each observation, rather than just position. Adding a memory to a slot is simple. [Feedforward](https://www.sciencedirect.com/topics/engineering/feedforward) weights direct observations to the input slot (e.g., A right). The memory is then passed from slot to slot, controlled by velocity, eventually influencing [behavior](https://www.sciencedirect.com/topics/neuroscience/behavior-neuroscience) from readout slot. Thus, once learned, this solution requires no synaptic plasticity to solve novel problems. Lastly, similar to the EM solution, the WM solution works in any basis.

#### Memory slots unify episodic and WM and yield a rich neural basis for WM cognitive maps

The two solutions use memory slots in different ways. In the WM solution, memory slots are structured neural subspaces with the contents (memory) of each subspace copied and shifted to neighboring subspaces. In the EM solution, memory slots are in synaptic connections, with each memory remaining fixed in its slot (a subspace of the weights). The memory slots are also accessed differently. The EM solution uses flexible attention (via an RNN) to index fixed memory slots (the weights do not move), whereas the WM solution uses fixed attention (the readout weights) but flexible memory slots (slots contents get copied and shifted by the RNN).

Interestingly, these solutions have a striking representational difference. The EM RNN represents latent position (relative to an initial position), independent of observations. However, the WM RNN conjunctively encodes all counterfactual actions and observations simultaneously. In particular, each slot is identified by an action/velocity sequence the agent could take, with its contents answering the counterfactual: what would I see if the slot’s corresponding action were taken? In the case of A, third column, slot 1, aligned with the input/readout weights, contains the correct answer if no action was taken. And slots 2 and 3 contain the correct counterfactual predictions if the agent were to go back one or two positions, respectively. Equivalently, because action sequences correspond to relative positions, each slot represents the relative position to the observation it contains. Every time the agent takes an actual action, the correct counterfactual prediction associated with every slot changes; therefore, the WM RNN must update the contents of every slot by appropriately copying and shifting their contents through the recurrent weights. This ensures that all slots’ contents dynamically change to correctly encode the counterfactual observation associated with the slots’ fixed action label/relative position.

Moreover, because each neuron in each slot is selective for a single observation (in an idealized basis, e.g., A third column), the WM neural code consists of neurons that fire for particular observations at particular relative positions to those observations. Any single neuron’s relative position [selectivity](https://www.sciencedirect.com/topics/earth-and-planetary-sciences/selectivity) derives from its slot identity, whereas its object selectivity derives from its functional role within its slot. This implies that EM and WM single neurons behave very differently across problems. In particular, any two EM position neurons that fire next to each other in one problem will fire next to each other in another problem: they maintain their phase relationship (F; similar to grid cells). On the other hand, two WM activity slot neurons with a particular phase relationship in one problem (G, top) may not have the same phase relationship in another problem (G, bottom). This is because WM slots code for relative position to, or action sequence required to arrive at, a particular observation, and the pairing between positions and observations is shuffled between different problem realizations of a common task, meaning that the [relative phase](https://www.sciencedirect.com/topics/computer-science/relative-phase) between WM neurons will also appear shuffled.

### Model architectures and task specifics

To test our theory predictions that EM systems use position representations, whereas WM systems use activity slots, we use a variety of tasks and model architectures (details in ).

#### Model architectures

We build both EM and WM RNNs (A, 2B, A, and S2B). The key difference between them is that EM RNNs make predictions by retrieving memories from an external memory system, whereas WM RNNs make predictions with a learned readout matrix. For the EM external memory, we use a modern Hopfield network, which our above theoretical results are derived from (). To be general, we use two RNN variants (C and 2D): one inspired by our theory with velocity-dependent recurrent matrices (GroupRNN; related to selective state-space models), and the other is a conventional RNN with velocity signals as input (RegularRNN). All model parameters are initialized randomly and trained using [backpropagation](https://www.sciencedirect.com/topics/engineering/backpropagation).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr2.jpg)

Download: Download high-res image (857KB)

#### Tasks

We consider four main tasks (A, further [neuroscience](https://www.sciencedirect.com/topics/earth-and-planetary-sciences/neurology) tasks introduced later): ISR, N-back, 1D navigation, and 2D navigation. These tasks range in complexity from simple sequence repetition requiring no velocity integration to tasks where velocity must be integrated correctly using a cognitive map. Observations, , and velocity signals, are provided at each timestep and the models are trained to predict a target, , at timestep . An example problem sequence for the 1D navigation task (a [random walk](https://www.sciencedirect.com/topics/computer-science/random-walk) on a loop, e.g., a 3-loop with observations 1, 3, and 2 at the three positions) is: , , and . Here, “” denotes a target is not possible to predict because it has not been observed before. We do not train on these targets. The ISR task is similar to 1D navigation but with constant [forward velocity](https://www.sciencedirect.com/topics/engineering/forward-velocity), the 2D navigation task is a 2D version of the 1D navigation task, and the N-back task is a random observation sequence with the target being the observation N timesteps ago. For each task, we train on multiple problem realizations corresponding to multiple sequences where position-observation pairings are randomized, but the underlying task structure (e.g., 1D navigation) is fixed. See for details.

## Results

### Differences in EM and WM algorithm performance and representation

#### EM scales more favorably than WM

Our theory demonstrates that [EM](https://www.sciencedirect.com/topics/social-sciences/episodic-memory) and [WM systems](https://www.sciencedirect.com/topics/computer-science/working-memory-system) implement the same computation (solve the same tasks) but use different neural algorithms/mechanisms. These algorithms have trade-offs. Most notably, the WM solution requires more [RNN](https://www.sciencedirect.com/topics/chemical-engineering/recurrent-neural-network) neurons than the [EM](https://www.sciencedirect.com/topics/psychology/episodic-memory) solution. Thus we predict that, for a fixed [RNN](https://www.sciencedirect.com/topics/computer-science/recurrent-neural-network) neuron budget, the WM model performance will degrade faster than the [EM](https://www.sciencedirect.com/topics/neuroscience/episodic-memory) model performance as the number of memories needed to be stored, which we refer to as the task size, increases. (While we match [RNN](https://www.sciencedirect.com/topics/social-sciences/neural-network) neurons, we note that [EM](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/episodic-memory) models have additional neurons/parameters in their memory network, which we do account for.) This is observed for the 1D [navigation task](https://www.sciencedirect.com/topics/computer-science/navigation-task) (E), as well as all other tasks (A/S4A for GroupRNN/RegularRNN). Expectedly, performance improves with more [RNN](https://www.sciencedirect.com/topics/psychology/neural-network) neurons. Importantly, performance is measured on new problems (with novel state-observation associations), and all network weights are fixed and do not change (apart from the “fast weights” in the memory module of the EM). Thus, a performance of 100%, achieved for both EM and WM networks on smaller task sizes, means that they learned a cognitive map to generalize task structure.

Although the capacity of these small WM networks is larger than human [WM capacity](https://www.sciencedirect.com/topics/psychology/working-memory-capacity), our networks are noiseless and trained on a single task type (e.g., loop of length 10). This is unlike noisy brain neurons that have to solve multiple different task types. Although EM networks are superior in our prediction tasks, the WM model may have additional benefits. This is because it represents the whole problem in neural activity simultaneously (in slots), allowing operations over states to be done in parallel, e.g., planning and decision-making, unlike EM models, which need to sequentially sample states to plan.

#### EM uses position representations, whereas WM uses activity slots

Our theory predicts that trained EM models use position-like representations to index memories stored in [synaptic weight](https://www.sciencedirect.com/topics/engineering/synaptic-weight) slots (), whereas trained WM models store and manipulate memories in [RNN](https://www.sciencedirect.com/topics/engineering/recurrent-neural-network) activity slots (). To test these predictions, we train linear decoders to decode positions and observations from the neural activity of trained models’ RNNs. Crucially, we avoid task overfitting by training each decoder on many example tasks, demonstrating that the activity slots, or position representations, are generalizable across tasks.

First, our theory says abstract position should be decodable from EM models but not WM models because EM models use position to index memories (F). We confirm this prediction in all tasks and [RNN types](https://www.sciencedirect.com/topics/computer-science/network-type) (G, B, and B). This is consistent with existing EM models<sup>,</sup> that learn position codes to index hippocampal memories, as well as entorhinal neurons such as [grid cells](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/grid-cell). In our models, position is often not decodable for large or small task sizes. For large task sizes, the models did not learn the task and so learned no position representation (E, A, and A). For small task sizes, the EM [RNN](https://www.sciencedirect.com/topics/neuroscience/recurrent-neural-network) learned another memory indexing representation: the WM solution. We discuss this in a later paragraph.

Second, our theory predicts that previous observations should be decodable from the RNN in WM models but not the EM models because the RNN in WM models store memories of previous observations in neural activity slots, whereas the RNN in EM models only tracks position. More precisely, our theory prescribes exactly which past observation is stored in which neural activity slot at any given time (B and S1C). Thus, for each neural activity slot, our theory predicts that it encodes a particular sequence of observations, and, importantly, this sequence, for tasks with varying [velocity signals](https://www.sciencedirect.com/topics/computer-science/velocity-signal), is not simply a temporally shifted copy of the input observations (H). We call this the slot sequence for each predicted activity slot in a given problem. We find that slot sequences can be decoded from RNN activity in all tasks for WM models (average slot sequence decoding across task sizes in I left, C, and C; individual slot sequence decoding for a particular task in I right, D, and D), whereas temporally shifted copies of the input observations (past sequences) cannot be decoded (apart from the ISR and N-back task where past sequences and slot sequences are identical). Slot sequence [decoding performance](https://www.sciencedirect.com/topics/computer-science/decoding-performance) degrades for larger task sizes because the RNN fails to learn the task. These results demonstrate that WM networks learn activity slots and use velocity signals to control activity slots.

Interestingly, although EM networks have, as predicted, poor slot sequence decoding and high abstract position decoding in most situations, the converse can be true for small task sizes (G and S3I). This is because activity slots are also an effective memory indexing representation because they uniquely represent each position in each problem. We posit that the WM solution is easier to learn (when not limited by number of neurons) because slot representations are a direct function of input data, whereas position representations are abstract.

Although EM and WM networks, once trained, have the same generalization [behavior](https://www.sciencedirect.com/topics/neuroscience/behavior-neuroscience) (due to the formal equivalence of the EM and WM solutions), their learning dynamics and sample complexity differ (G) with EM networks learning faster (except on N-back task). This is because the inductive bias of EM networks (fast memory binding) is suited to our tasks with novel state-observation pairs. By contrast, WM networks have no explicit bias and therefore must learn how to appropriately store memories. Further, GroupRNN learns faster than RegularRNN due to its inductive bias that facilitates path integration.

### Visualizing slots and “slot algebra”

#### Visualizing slots

Our decoding analyses demonstrate that WM models learn activity slots, as predicted by our theory. We focused on decoding analyses because learned activity slots will in general correspond to neural activity subspaces, not necessarily aligned to [single neuron](https://www.sciencedirect.com/topics/engineering/single-neuron) axes similar to our WM schematics (single neurons could exhibit mixed [selectivity](https://www.sciencedirect.com/topics/earth-and-planetary-sciences/selectivity) for multiple slots). To visualize learned activity slots, we leverage a recent technique that encourages single neurons to demix and code for single independent factors (e.g., slots). WM RNNs trained with this technique learn a demixed solution where single neurons participate only in a single slot (A) and quantitatively demix on all four tasks and for both RNN types (A).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr3.jpg)

Download: Download high-res image (463KB)

#### Slot algebra predicts relations between neural representations of different problems from a common task

We test a further prediction of our theory: activity slot representations are compositional and obey a slot algebra with simple linear relationships between WM representations of different problem realizations of the same underlying task. Consider a task with three latent positions and four possible observations (B). Let denote the WM activity slot representation when our theory predicts observations are in slots respectively. Now consider the [neural representations](https://www.sciencedirect.com/topics/computer-science/neural-representation) for two problems, and . These problems differ only in their observation in slot 2, and our activity slot theory predicts the linear relation (B illustrates this relation), where *a* and *c* can be any observations.

We examine the WM RNN in situations that satisfy the equality relation above by extracting neural representations from the RNN in four different problems. We sum the three representations according to the right-hand side of the relation and compare the sum with the measured representation on the left-hand side using a squared difference measure (). We compare this with the squared difference of the first term on the left and the first term on the right () via the ratio . Low values indicate that the representation obeys slot algebra.

Perfect slot algebra requires pure activity slot representations. However, some velocity-integrating RNNs, both in biology and models, have velocity-modulated neurons. Indeed, it is possible to have activity slot representations that are velocity-modulated ( high ). Thus, slot algebra is additionally informative of how RNNs integrate velocity. We test slot algebra on the GroupRNN, which modulates [synapses](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/synapse) with velocity signals (similar to our theory), the RegularRNN, which uses additive velocity signals, and, additionally, the BioRNN, which integrates velocity signals in a separate [neural population](https://www.sciencedirect.com/topics/engineering/neural-population) to the RNN activities themselves. As predicted, the GroupRNN has low for all datasets (C; we do not use the N-back task as is not well defined there) because velocity does not directly modulate RNN activity. further improves with [regularization](https://www.sciencedirect.com/topics/computer-science/regularization) (KL) that encourages consistency across timesteps, i.e., limiting velocity modulation (see ). Conversely, as predicted, the RegularRNN only achieves low on the ISR dataset, which requires no velocity signal. Lastly, the BioRNN achieves low for all datasets. Intriguingly, the BioRNN architecture is related to the fly head direction circuit<sup>,</sup><sup>,</sup> (E and S2F; details in ).

### Velocity-controlled activity slots explain diverse PFC representations

Our theory of controllable WM activity slots explains artificial RNN representations trained on sequence memory tasks. Does this understanding transfer to biological RNNs? And, if so, how are the velocity signals, which are crucial for successful control, represented? Here, we show that activity slots unify PFC-dependent sequential and cued memory tasks, with the distinguishing feature being the velocity control signals.

#### PFC and RNNs compute and represent velocity signals

In previous tasks, we provided velocity signals to the model. Brains do not have this luxury—they must compute velocity signals from their inputs. In spatial tasks, self-movement vectors are computed from vestibular or other [sensory inputs](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/sensory-stimulation) and represented using head direction and speed cells. It is unknown what the corresponding velocity signals are for complex non-spatial tasks. Recent [PFC](https://www.sciencedirect.com/topics/psychology/prefrontal-cortex) data, however, although not demonstrating velocity signals, have found neurons that track progress to goals, invariant to the actual goal distance.<sup>,</sup> Here, a 50% “progress cell” fires midway between two goals, whether they are three steps apart or 20. To update progress, we contend that “progress velocity” signals must be computed and represented. To test this, we train WM models on analogous tasks.

In particular, Basu et al. and El-Gaby et al. trained rodents to repeatedly visit two and four (of nine) spatially located reward ports in sequence, respectively. The animals were trained on many problem realizations with random goal positions. We model these tasks (modulo the spatial component to be general) as 2-ISR and 4-ISR tasks but with delays between each observation (analogous to the delay traveling between spatial goals, A and 4E, left). Critically, although delays are random across different problem realizations, delays are the same on each loop of a problem. For example, possible 2-ISR delay sequences for different problem realizations are or where is the common delay observation (that also gets predicted), and possible 4-ISR delay sequences are or . We provide no explicit velocity signal—the model must compute progress velocity for each delay period from sparse inputs and remember it on returning to that same delay (after a loop of experience).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr4.jpg)

Download: Download high-res image (588KB)

After training WM models, we can decode progress and progress velocity (A and 4E, right) and visualize tuning at the single neuron level (B, 4F, and ). The network is computing progress velocity to overcome the different delays. The question remains: how does this relate to activity slots?

#### Controlling activity slots with progress velocity

We posit that activity slots are “task-progress” structured (C and D), with slots coding for, e.g., 25% or 150% since observation (up to 200/400% for the 2/4-ISR delay task) and progress velocity controlling when slot contents move to subsequent slots. (Task-progress slots are continuous rather than discrete, with bumps of activity on continuous attractor manifolds defining an observation within a “slot.” For consistency, we still refer to them as if they were discrete.) This allows variable-length delays across different problems to be mapped to a common slot structure for generalization. Indeed, we can decode task-progress activity slots (A and 4E, right) and observe task-progress slot neurons (D and 4G), which fire at a particular task-progress after a preferred observation (further examples in ). Notably, as our model predicts, both progress and task-progress slot neurons were recently recorded in rodent mPFC, with the pathway linking the same observation across slots in the task-progress slot analogous to their “structured [memory buffers](https://www.sciencedirect.com/topics/engineering/buffer-memory).”

#### Hierarchical slots

In the 4-ISR delay task, to correctly predict observations on the second (and subsequent) repeats within each problem, each of the four delays must have been computed and remembered on first presentation. This induces a hierarchy of activity slots with observations stored in task-progress slots and the four delays stored (after being computed) in separate higher-level slots (H, top). Now the right delay (inverse velocity) at the right moment can be retrieved to control the lower-level task-progress slots. Indeed, we can decode slot contents consistent with this hierarchical slots hypothesis (H, bottom). We predict that PFC uses hierarchical slots as a [neural mechanism](https://www.sciencedirect.com/topics/computer-science/neural-mechanism) for [cognitive control](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/executive-function).

#### PFC activity slots in a sequence memory task

Our activity slot theory also accounts for PFC representations in standard sequence memory tasks where only a [constant velocity](https://www.sciencedirect.com/topics/computer-science/constant-velocity) is required. In particular, Xie et al. recorded PFC neurons in a 3-ISR task. Here, monkeys were shown three (of six) positions on a screen in sequence and were trained to, after a delay, [saccade](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/saccadic-eye-movement) to the three positions in order (A). Similar to our ISR tasks, the monkeys were trained on many such sequences. Neural activity in the delay period decomposed into three [orthogonal subspaces](https://www.sciencedirect.com/topics/engineering/orthogonal-subspace), with the first/second/third saccade position simultaneously encoded in the first/second/third subspace (B and 5C). These three subspaces are activity slots (D). Indeed, WM networks learn the same subspace decomposition (E and 5F).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr5.jpg)

Download: Download high-res image (527KB)

#### PFC activity slots in a cued memory retrieval task

We have considered external and internally generated velocity signals; however, observations themselves can serve as velocity signals. Here, we show that sensory cues can be understood as velocity signals controlling PFC activity slots. In particular, Panichello and Buschman recorded PFC neurons in monkeys performing a cue-dependent memory task, where two colors are presented at the top and bottom of a screen. After a delay, a sensory cue dictates whether to report the top or bottom color after another delay (A). Importantly, each problem realization is a random combination of two colors and cue. Neural activity in the first delay period decomposed into two [orthogonal subspaces](https://www.sciencedirect.com/topics/computer-science/orthogonal-subspace), with the first/second subspace representing the top/bottom color (B, left). After the cue, the top (when correct) and bottom (when correct) colors are represented in parallel subspaces (B, right, and C). This is explained by activity slots (D): the initial two subspaces are activity slots for the top and bottom color, then the cue behave similar to a velocity signal to route the correct color to the readout slot (hence, why subspaces are parallel after the cue on correct trials; D, bottom). Indeed, WM networks learn the same subspace decomposition and dynamics (E–6G).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr6.jpg)

Download: Download high-res image (564KB)

## Discussion

We derived a formal relationship between the algorithms and representations of episodic and working sequence memory and, in simulation, validated predictions that EM networks learn abstract position-like representations, whereas WM networks learn activity slot representations, different neural implementations of cognitive maps that generalize to novel state-observation pairings. Further, we demonstrated that our theory of controllable activity slots provides a unified [neural mechanism](https://www.sciencedirect.com/topics/computer-science/neural-mechanism) to several PFC studies.<sup>,</sup><sup>,</sup><sup>,</sup> Although these PFC representations have simple (often loop) structures, we anticipate that PFC will represent more complex structures, such as 2D slots, when participants are trained on sequences drawn from 2D tasks.

Activity slots may also explain PFC data from non-explicit [WM tasks](https://www.sciencedirect.com/topics/computer-science/working-memory-task). For example, human mPFC (fMRI) activity obeys rules of scene algebra (analogous to slot algebra) during scene construction tasks. Notably their task requires compositional understanding (objects are in any scene configuration) similar to our sequential WM tasks. In general, we anticipate that activity slots will be relevant in tasks requiring compositional understanding beyond WM in brains and machines. For example, activity slots could represent sub-goals for planning, which would explain why the same brain region is involved in WM, value-based decision-making, and goal-directed planning.<sup>,</sup> Notably, in [machine learning](https://www.sciencedirect.com/topics/computer-science/machine-learning), slot models are used in diverse settings from natural language to planning and scene construction.<sup>,</sup>

Although we related the EM and WM algorithms to [HPC](https://www.sciencedirect.com/topics/neuroscience/hippocampus) and PFC, their key distinction is whether memories are stored in [synaptic connections](https://www.sciencedirect.com/topics/engineering/synaptic-connection) or neural activity. Because PFC connects to HPC (via entorhinal cortex), the prefrontal RNN can assist in hippocampal memory retrieval and thus also represent abstract position representations. Indeed, grid-like coding has been observed in mPFC.<sup>,</sup> However, in some WM tasks,<sup>,</sup> early evidence suggests that position representations are not decodable from rodent mPFC. Furthermore, our theory suggests that any brain region, not just PFC, storing memories in neural activity will utilize activity slots.

It is also plausible that PFC utilizes short-term [synaptic plasticity](https://www.sciencedirect.com/topics/neuroscience/synaptic-plasticity) to store memories, with recent modeling suggesting that this may better explain PFC responses. It is not clear, however, how this explains existing PFC data on sequence WM,<sup>,</sup><sup>,</sup> which are consistent with activity slots.

Activity slots for (non-sequence) WM have been considered before,<sup>,</sup><sup>,</sup><sup>,</sup> where behavioral evidence is against a naive slot implementation because human recall performance degrades gradually with task size rather than a sharp drop-off when all slots are full. Instead, the conceptual “continuous resource models” are preferred in which fixed resources (pool of neurons) flexibly code for differing numbers of memories but with increasing interference for increasing task size leading to gradual performance decline. In fact, activity slots are compatible with continuous resource models, either by chunking memories together when the task size exceeds the number of discrete slots or by using continuous activity slots (similar to ) and placing memories (bumps of activity) closer together on the slot attractor manifold as task size increases. Both of these methods would have a gradual decline in recall performance due to memory interference. Continuous activity slots may also permit generalization to task sizes beyond the training distribution: analogous to how the grid cell hierarchy allows position coding of environments larger than the largest grid scale, we anticipate that continuous activity slots may have a hierarchical representation facilitating length generalization.

We have not solved the algorithm of RNNs on all sequential WM tasks because naive activity slots are not learned in some tasks (e.g., A and S7B). Nevertheless, we suggest that activity slots are a general-purpose solution. Of note to [machine learners](https://www.sciencedirect.com/topics/computer-science/machine-learner), our formalism, as well as the GroupRNN, is a selective state-space model; thus, our work offers insights into the neural mechanism of learned state-space models, RNNs, and transformers (and their relationships).

The hippocampal and frontal systems are thought to be essential in mediating higher-order cognition, with patients exhibiting profound deficits in behavioral flexibility if these structures are damaged.<sup>,</sup> Although these systems have been the subject of intense study over the last several decades—both experimentally and theoretically—they have been largely treated independently, and their respective cellular representations are hard to reconcile. Our work brings together these systems by showing that the algorithms and representations of frontal WM and temporal EM are two sides of the same coin.

## Resource availability

### Lead contact

Requests for further information and resources should be directed to and will be fulfilled by the lead contact, James Whittington ([jcrwhittington@gmail.com](mailto:jcrwhittington@gmail.com)).

### Materials availability

No materials were generated in this study.

### Data and code availability

Python and PyTorch code is available on [https://github.com/djcrw/em-wm-slots](https://github.com/djcrw/em-wm-slots).

## Acknowledgments

We thank Kris Jensen and Jo Warren for helpful feedback on the manuscript. We thank the following funding sources: Sir Henry Wellcome Postdoctoral Fellowship () to J.C.R.W.; the Gatsby Charitable Foundation to W.D.; Wellcome Principal Research Fellowship (), Wellcome Collaborator award (), and Jean-François and Marie-Laure de Clermont-Tonnerre Foundation award () to T.E.J.B.; the Wellcome Centre for Integrative Neuroimaging is supported by core funding from the Wellcome Trust (); and the James S. McDonnell, Simons Foundations, NTT Research, and an NSF CAREER Award to S.G.

## Author contributions

J.C.R.W. conceptualized the study with input from W.D. and all other authors. J.C.R.W. derived theory and performed simulations. J.C.R.W. wrote the manuscript with input from all other authors.

## Declaration of interests

The authors declare no competing interests.

## STAR★Methods

### Key resources table

<table><thead><tr><th>REAGENT or RESOURCE</th><th>SOURCE</th><th>IDENTIFIER</th></tr></thead><tbody><tr><th colspan="3"><strong>Software and algorithms</strong></th></tr><tr><td>Python 3.11</td><td>Python Software Foundation</td><td><a href="https://www.python.org/">https://www.python.org/</a></td></tr><tr><td>PyTorch 2.4</td><td>Paszke et al.</td><td><a href="https://pytorch.org/">https://pytorch.org/</a></td></tr><tr><td>Code for this paper</td><td><a href="https://doi.org/10.5281/zenodo.13909034">https://doi.org/10.5281/zenodo.13909034</a></td><td><a href="https://github.com/djcrw/EM-WM-slots">https://github.com/djcrw/EM-WM-slots</a></td></tr></tbody></table>

### Method details

#### Full Theory

##### Task reminder

Formally, for each task, we consider a dataset , where each is a sequence consisting of vectors of observations, , of dimension (termed ), targets, , and (allocentric) velocities, , i.e., if the sequence is of length *K*. These velocities mimic real actions taken by agents, but in this case we provide them externally. Importantly, the underlying structure of the task prescribes how the velocities add up to cancel each other out (just like North + East + South + West = 0 defines 2D space), and when the velocities cancel each other out, the observation is identical to what it was previously (just like returning to the same position in 2D space). Concretely, there is an underlying latent variable, , corresponding to ‘position’, and each position, , is associated with an observation, , and any two neighbouring positions are related by a velocity, (example for a simple loop structure in A left). For each , while the observation-position pairing is random, the underlying structure is preserved (velocities add up and cancel in the same way). The aim of the task is to predict a target, , which is either an upcoming observation (i.e., what you will see after going North), or a past observation (i.e., what you saw 5 steps ago). Importantly, at time *t* the model predicts the target at time – one-step prediction. While the task formalism (and subsequent model formalism) is general to tasks with discrete and continuous positions, we primarily consider the discrete setting here (with total positions).

##### Solving these tasks with an EM model

Such tasks can be solved using EM systems that consist of RNNs equipped with an external memory. The external memory can be a [Hopfield network](https://www.sciencedirect.com/topics/computer-science/hopfield-network), a modern Hopfield network, a transformer [neural network](https://www.sciencedirect.com/topics/neuroscience/neural-network), or a differentiable neural dictionary. All these methods are relatable to each other, and crucially can all be viewed as storing memories in synaptic connections. Here, we present the differential neural dictionary / modern Hopfield network version (as they are general external memory devices). Additionally, we consider an RNN that only receives [recurrent](https://www.sciencedirect.com/topics/engineering/recurrent) input and the velocity signal. Predictions are made via(Equation 3)Where is the RNN state representation at time *t*, and and are stored memories, i.e., the memories bind together each and at each timestep. (Normally key, query, and value matrices, are used i.e., . We leave them out for simplicity, but the following argument would remain the same if we included them.) We note that the targets are in the form of observations (upcoming/ those that have previously been seen) and so stored memories of observations will facilitate accurate prediction.

The particular choice of RNN does not matter for our purposes here - it just needs to accurately track position, . Nevertheless, the RNN state, , will be a function of past velocities, , as it must integrate velocities to track position:(Equation 4)In the bottom line of the above equation, we present two common ways for integrating velocity in RNNs, the first uses velocity dependent matrices, , to update RNN state and is inspired from group theory (and can mathematically shown to produce grid cells in 2D space), and the second is a classic RNN where is a recurrent matrix and is an matrix that maps velocities to the RNN. Note is the velocity from , and so while the classic RNN takes as input at timestep *t*, it is really the velocity that was provided at that gets used to update position (via the recurrent weights) at time *t* (that’s why in the velocity-dependent matrix case we use to get to ). This is just how classic RNNs are usually framed.

Regardless of the particular RNN, if learns to have the same structure as (i.e., it represents position: ) then we can rewrite(Equation 5)

and(Equation 6)This says that the memories formed at each timestep (when at position ) are the *true* neural representation of position : and the observation at position : . Thus the attention vector will attend to the right memory at each timestep (i.e., memories that were paired to in the past) since will be more similar to itself, than to , where is a different position.

##### Simplifying an optimal EM model

We consider a optimal EM model, and consider its representations. We assume that if an underlying ‘position’, , is visited more than once, the additional memory is not added, thus after all ‘positions’, , have been visited and , where is the number of ‘positions’ for this task: we only store memories. Thus, since a single memory get retrieved at any one time, the optimal attention vector, will be one-hot and with a single element active for each position. (If the target were to predict a mixture of past observations, the attention vector would not be one-hot, but the same argument follows just the same.) To make our lives easier, since attention is order invariant, we can relabel, and reorder, individual memories, not by the time, but by their ‘position’: and . Since the one-hot attention vector, after a velocity , will change to another one-hot attention vector (coding for position then position ), the attention vector can be though of as representing a node on a graph. We call the attention vector at timestep *t* corresponding to position as . Thus, the update to the attention vector is *functionally equivalent* to an attention vector being multiplied by an (velocity/action dependent) graph [transition matrix](https://www.sciencedirect.com/topics/computer-science/transition-matrix), , i.e., . Thus (optimal) predictions can be rewritten as:(Equation 7)

*Expanding this equation out yields*:(Equation 8)This equation describes the functional computations of an optimal EM model. We see that it reduces to an attention vector that gets updates by velocity-dependent graph transition matrices. This attention vector then attends to memories stored in weights. Interestingly, this simplified formulation, can still be thought of as an RNN (the attention vector RNN) and an external memory (the memory slots). But we stress that this is a simplified formulation, as opposed to the actual model implementation (see ). Nevertheless it captures the computations of an optimal full EM model implementation.

##### Rearranging terms gives the WM solution

The above solution stores memories in synaptic connections. Here we show that reshaping and rearranging the above equation produces an alternative, but equivalent, solution where memories are stored in RNN activity rather than synaptic connections:(Equation 9)This equation performs the exact same computation as the previous equation, and its terms look very similar but there are some important differences ( for relationships between terms). For example, is like the previous velocity-dependent matrices, , but expanded (and transposed); where there was a 1 or a 0, there is now an [identity matrix](https://www.sciencedirect.com/topics/computer-science/identity-matrix) () or a matrix of zeros (). Intriguingly, what was a matrix of memories stored in weights, , is now a vector of memories stored in RNN activity, . Thus the neurons in the RNN can be though of as **activity slots** that store arbitrary memories in neural activity (A right). Importantly, since the readout weights are now fixed, the contents of each slot must be copied and shifted to other slots via , depending on the desired observation to readout. Adding a memory to a slot is simple and only requires feed-forward weights from observation to input slot (e.g., A right). Thus, once learned, this model requires no synaptic plasticity. Lastly, similar to the EM solution, this WM solution works in any basis (not just the one presented above).

##### Separate attractor networks for computing velocities, and controlling slots

We now show that an RNN can consist of two components: a component for computing velocities, and a component for using velocities to control activity slots. A generic RNN updates is as follows:(Equation 10)If we split into two parts, , where are the activity slots and are the neurons involved in computing velocity signals (we’re choosing a favourable basis where the two components are in separate neurons). Then we get the following:(Equation 11)Where is the block of that goes from neurons etc, and in the last line we have assumed that information from slot neurons are not useful to velocity neurons (). Thus this RNN consists of a velocity computing RNN, , that computes velocities based on inputs and sends these velocities to the slot RNN, , vis .

#### Model Details

We train models which are all variants on recurrent [neural networks](https://www.sciencedirect.com/topics/computer-science/neural-network) (RNNs), which differ in two key components (). The two varying components are: 1) we use different RNN variants (varying from least to most biologically plausible), and 2) we use different methods of predictions from RNN activities for EM models (via fast Hebbian weights that change every timestep) and WM models (via slow weights learned by backpropagation).

##### RNN transitions

We use a gated RNN similar to a GRU, where the external and recurrent inputs are gated: , where is the external input at timestep *t*, is the recurrent input, is an [activation function](https://www.sciencedirect.com/topics/computer-science/activation-function), and is an element-wise gate with the Sigmoid activation, *σ*. We compute the recurrent and external inputs in two different ways. First, like our theory, we use (learned) velocity-dependent matrices, : , and the external input, , is just . We call this *GroupRNN* (C). Second, we use a conventional gated RNN, with , and the external input, , is and concatenated. We call this *RegularRNN* (D). In we make use of another RNN inspired by the fly head direction circuit (E and S2F). In *BioRNN*, we have , where projects into a higher dimensional space. The external input, , is just .

It is unlikely that velocity dependent weights matrices (i.e., the GroupRNN), as per our theory, are exactly what the brain uses since it requires modulation of synapses depending on velocity. It is more likely that the brain uses additive velocity signals like a RegularRNN/BioRNN. Importantly, however, in our simulations of both GroupRNN (velocity dependent weights matrices) and RegularRNN/BioRNN (additive velocity input) slot representations are learned. This is perhaps not surprising since the standard formulations of continuous attractor neural networks have separate populations of neurons for each direction (e.g., left and right neurons for a ring attractor), which is closely related to velocity dependent matrices as the velocity input essentially gates the left/ right neurons which have left/right projections. Thus we anticipate our theory also applies to path-integrating networks learned with additive velocity input like RegularRNN and CANNs.

##### Fast or slow readout weights

We use two readout methods to correspond to the two model classes in our theory. First, for the **WM** class: predictions are made by , i.e., standard RNN prediction (B). Second for the **EM** class: predictions are made using an external memory system related to a transformer / Hopfield network. In particular, , where the key and value matrix are sequentially updated i.e., and (A; we use for ‘value’ as is already used for velocity). At the beginning of each sequence, and are reset to be empty.

##### Adding memories in EM models

Memories are simply added to a list, just like the differentiable neural dictionary or modern Hopfield network. These memories consist of two parts - a key and a value (A). The added key, as described above, at each timestep is , while the [added value](https://www.sciencedirect.com/topics/social-sciences/value-added) is , where is the retrieved memory at that timestep (). We do this, so that repeat copies of memories are not added.

Since the list of memories grows in time, we add an additional *β* scaling term in the softmax: . We do this as the normalisation term in the softmax sums over the number of memories, and so more memories down-weights attention probabilities. We want the attention vector to not be affected by the number of elements in the set. In particular, we weight the softmax by .

##### Adding memories in WM models

There is no explicit memory adding process in WM models. There are simply input weights from the input at each timestep, , and so the RNN must figure out how to hold these inputs in its recurrent memory.

##### Normalisation

We use normalisation in two places. 1) In EM models, after retrieving a memory i.e., before applying we perform a layer normalisation: . This is so all retrieved memories have the same scaling. 2) In some simulations (detailed in ) we also normalise the output of the RNN for both WM and EM models. We do this for consistency when comparing WM and EM models. For WM models this means . For EM models this means memories are retrieved as .

##### Optimisation

All weight matrices are learned by [backpropagation](https://www.sciencedirect.com/topics/engineering/backpropagation) in both models. We optimise a prediction loss on the target, , which is a cross-entropy loss when observations and targets are one-hot (all simulations other than and ), or a [squared error loss](https://www.sciencedirect.com/topics/computer-science/squared-error-loss) otherwise ( and ). For all simulations we add weights decay. For the ‘additional constraints’ in we add a L2 loss on the RNN activity. Also in, we use an additional KL loss (where specified) which is a squared error loss between inferred () and predicted () RNN activity. All loss hyperparameters specified in.

#### Additional Task Details

Here we provide further task details. In all tasks we train on many [instantiation](https://www.sciencedirect.com/topics/engineering/instantiation) of the task, i.e., observations randomised across each [instantiation](https://www.sciencedirect.com/topics/computer-science/instantiation). In all tasks observations are randomly sampled at positions with replacement, except for the delay task and the PFC tasks.

##### Immediate Serial Recall (ISR)

Observations repeat cyclically, and the task is to predict the upcoming observation (). There is no velocity signal. e.g., a 4-cycle: and . ‘’ means a target that we do not try to predict since it has not been observed before and therefore is not possible to predict. The length of the each sequence is 7 multiplied by the repeat length.

##### N-back

Observations are randomly drawn at each step, and the task is to recall the observation *n* timesteps ago. There is no velocity signal. e.g., for : and . The length of the each sequence is 7 multiplied by *N*.

##### 1D Navigation

Observations come from [random walks](https://www.sciencedirect.com/topics/computer-science/random-walk) on a loop. Velocity signals are provided. e.g., a 3-loop: , and . While velocities are randomly sampled at each step, to encourage exploration of the full loop, we increase the likelihood of repeating velocities (apart from the 0 velocity). The length of the each sequence is 7 multiplied by the loop size.

##### 2D Navigation

Observations come from random walks on a [2D torus](https://www.sciencedirect.com/topics/computer-science/dimensional-torus). Velocity signals are provided. e.g., a 2x2 torus: , , and . The length of the each sequence is 7 multiplied by the torus size.

To demonstrate the generality of slots, we show that they are learned even when training on all targets i.e., including those that are impossible to predict correctly (as those states have not been visited yet). All models learn slots (E–S4H), but understandably the models are less capable of learning larger task sizes because their training is less stable due to having [error gradient](https://www.sciencedirect.com/topics/computer-science/error-gradient) signals from the impossible targets to predict.

##### 2-ISR with delays

See also. Delay period lengths were randomly sampled from \[3,4,5,6,7\] for each task. Example observation sequences are or where is the common delay observation (that also must be predicted). Corresponding target sequences are or . Again we do not train on targets not possible to predict (i.e., observations/delays that have never been visited). We also so not train on the \\nth1 return to the [initial position](https://www.sciencedirect.com/topics/computer-science/initial-position). This is because it also cannot be predicted as it could have been a delay step. Observations are sampled without replacement. The length of the each sequence is 7 multiplied average full loop length (averaging over delays).

##### 4-ISR with delays

See also. Delay period lengths were randomly sampled from \[3,4,5\] for each task. Example observation sequences are or where is the common delay observation (that also must be predicted). Corresponding target sequences are or . Again we do not train on targets not possible to predict (i.e., observations/delays that have never been visited). We also so not train on the \\nth1 return to the initial position. This is because it also cannot be predicted as it could have been a delay step. Observations are sampled without replacement. The length of the each sequence is 7 multiplied average full loop length (averaging over delays).

##### Xie et al.

See also. Here observations are one of six 2D [positions lying](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/recumbency) on a ring. This is just like the original paper). Thus the [observation vector](https://www.sciencedirect.com/topics/engineering/observation-vector) consists of two [real numbers](https://www.sciencedirect.com/topics/engineering/real-number) rather than a one-hot vector as before. Likewise for the targets. Observations are sampled without replacement. Otherwise the set-up is the same as a 3-ISR task, but only with a single repeat (i.e., 6 observations in total), e.g., and where is a 2D position vector (corresponding to the six positions lying on a ring).

##### Panichello et al.

See also. Here observations are one of four 2D coordinates lying on a ring. The original paper uses randomly sampled colours (from a 2D colour ring), and for visualisation purposes they bin these colours into 4 bins. Thus we just use 4 example colours (we could have used randomly drawn colours - the activity slot predictions are the same). Thus the [observation vector](https://www.sciencedirect.com/topics/computer-science/observation-vector) consists of two [real numbers](https://www.sciencedirect.com/topics/computer-science/real-number) (corresponding to a colour the colour wheel) rather than a one-hot vector as before. Likewise for the targets. Observations are sampled without replacement. The length of the sequence is 4 (top colour, bottom colour, cue, target), e.g., and , where is a [2D vector](https://www.sciencedirect.com/topics/computer-science/dimensional-vector) (corresponding to a colour on the colour wheel).

### Quantification and statistical analysis

#### Decoding Analyses

For all decoding analyses, we take the neural representations at each timestep in the sequence, along with the value of the variable we wish to decode at each timestep in the sequence. We collect this data for many timesteps and for multiple (240) [random sequences](https://www.sciencedirect.com/topics/computer-science/random-sequence), and collate this data into a training dataset (number of data-points is where *s* is sequence length), with inputs being the neural representations, and outputs being the variable we wish to decode. In all decoding analyses, we only decode from timesteps after all positions have been visited at least once (so activity slots can be filled). We use (multi-class) [logistic regression](https://www.sciencedirect.com/topics/computer-science/logistic-regression) (using the sklearn python package) for all decoding analyses (apart from task-progress slot decoding - see later), as we discretise continuous [random variables](https://www.sciencedirect.com/topics/engineering/random-variable-xi) into discrete classes. We train the decoders and then test on a held out dataset of 60 [random sequences](https://www.sciencedirect.com/topics/engineering/random-sequence) (all presented results are test accuracy). We now describe how we obtain the particular variables we wish to decode.

##### Position decoding

We define the first element of each sequence to be at position 0, and then track position from then onwards (i.e., we track [relative position](https://www.sciencedirect.com/topics/computer-science/relative-position) to initial position). We give each position a unique identifier, so we can perform multi-class logistic regression.

##### Slot decoding

For every sequence, we calculate each slot’s stored observation according to our theory at all timesteps (H; we call this the slot ‘slot-sequence’ for each slot). We decode each slot-sequence individually using multi-class logistic regression. When taking the average [decoding performance](https://www.sciencedirect.com/topics/computer-science/decoding-performance) over slots, we do not include slot 1, i.e., the input slot, as it will always decode to 1 (since the slot-sequence for slot 1 is just in input sequence which gets provided to the model). While for each task the observations in the slots are permutations of one-another (e.g., H) and so it may be thought that if you can decode slot 1 (the input slot!) then you can decode any other slot, the permutation is not consistent over task instantiations. Thus, since we decode multiple sequences from multiple task instantiations at once, only RNNs that have actually learned a slot representation will have high slot-sequence decoding accuracy.

##### Past decoding

For every sequence, at each timestep we calculate which observation occurred *n* timesteps ago (H; we call this ’past-sequence’ for each time lag *n*). We do this for to where is the number of slots. We run a separate decoder for each value of *n*. When taking the average decoding performance over past-sequences, do not include as it will always decode to 1 (since the current observation is being provided to the model).

##### Progress decoding

To calculate progress, at each timestep, we calculate the number of delay steps taken since an observation and divide by the total number of delay steps (between neighbouring observations). We then discretise progress into 4 chunks, i.e., , , , .

##### Progress-velocity decoding

We calculate progress-velocity, for each timestep, we compute 1 divided by the total number of delay steps (between neighbouring observations). We then provide a unique identifier to its value. Thus decoding progress-velocity, is the same as decoding the number of delay steps between the current neighbouring observations.

##### Task-progress slot decoding

We first discrete the task into task-progress slots where *T* is positions in task (i.e., 2 for the 2-ISR delay task) and is the number of progress chunks after discretising progress. At each timestep we calculate which observation our theory says should be in each task-progress slot. Most slots will be empty as there are only *T* observations but task-progress slots. Thus rather than having a separate decoder for each task-progress slot, we train a single 2-layer linear [neural network](https://www.sciencedirect.com/topics/chemical-engineering/neural-network) (with sigmoid [activation function](https://www.sciencedirect.com/topics/engineering/activation-function) on the output; 2 linear layers as it trains faster even though it is no more expressive) where the inputs are neural representation at each timestep and the outputs are whether an observation is in a particular slot. There output dimension is then for the 2-ISR delay task, where is the number of observations. When observation *a* is task-progress slot *b*, then the corresponding output neuron is 1 and 0 otherwise. Thus most entries will be 0 for the 2-ISR delay task: there will only be two 1 entries out of , and so 0.975 is the baseline accuracy (which we normalise to in ).

#### Mutual Information Ratio

To calculate the mutual information ratio (MIR), we first compute the mutual information between all [active neurons](https://www.sciencedirect.com/topics/engineering/active-neuron) (defined as neurons with average activity greater than of the average neural activity) and the ‘slot-sequence’ for each slot (slot-sequences are the predicted stream of observations in each slot; H). This gives a matrix of dimensions number of active neurons by number of slots. For each neuron we take its mutual [information vector](https://www.sciencedirect.com/topics/computer-science/information-vector) (of dimension number of slots), and calculate the maximum value of the vector divided by the sum of the vector (mutual information is always non-negative). This determines how specialised each neuron is for each slot. The MIR is then the average value over all active neurons. We do not include slot 1, i.e., the input slot, in this analysis.

#### Slot Algebra

To compute the slot algebra score, we generate sequences from four environments of identical structure, where the environments differ in their arrangement of observations in a special way. In particular the first environment has a random arrangement of observations, the second environment has a random arrangement of observations apart from one position (position *p*) where it has the same observation as the first environment. The third environment has the same arrangement of observations as the second environment apart from position *p* where it has a different, random, observation. The fourth environment is the same as the first environment, but in position *p* it has the same observation as the third environment. We then generate different random sequences for each of these environments. We choose a random position *i*, and record the neural representation for a random visit to position *i* on each of the four sequences. This gives us , , , and , where means the neural representation of environment *j* when at position *i*. The slot algebra score , where () is and where means square and sum all vector elements. We repeat this process 200 times for each model and average the individual scores to give the overall slot algebra score for that model.

We occasionally use an extra [regularisation](https://www.sciencedirect.com/topics/computer-science/regularization) term (KL) which asks the ‘predicted’ internal representation, , to the same as the ‘inferred’ representation, . In particular, we add an extra term to the loss that is , where is the [regularisation](https://www.sciencedirect.com/topics/engineering/regularization) [strength](https://www.sciencedirect.com/topics/materials-science/mechanical-strength) (see for its value).

To ensure that the poor slot algebra scores of the regular RNN are not simply due to the fact that we provide the velocity of the *upcoming transition* to the network at time-step *t* (i.e., the recurrent input , and the external input, , is and concatenated; reminder that is the velocity from that transition from ‘true underlying’ state to ), we additionally train networks where the velocity signal of the upcoming transition is only provided to the path integration step, i.e., ( is a learnable matrix), and the external input, , is just . This new network, in theory, could have no contamination of its internal representation with velocity, i.e., could be independent of velocity, and therefore have low slot algebra scores. Nevertheless, we find that these networks do not have low slot algebra scores (B), suggesting that the is dependent on the velocities signals taken to reach state .

##### PFC Analyses

We followed the exact analyses described in Xie et al. for and the exact analyses described in Panichello et al. for.

## Supplemental information

[What’s this?](https://service.elsevier.com/app/answers/detail/a_id/19286/supporthub/sciencedirect/ "What’s this? (Opens in new window)")

[Download: Download Acrobat PDF file (7MB)](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-mmc1.pdf "Download Acrobat PDF file (7MB)")

Document S1. Figures S1–S7 and Tables S1 and S2.

[Download: Download Acrobat PDF file (12MB)](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-mmc2.pdf "Download Acrobat PDF file (12MB)")

Document S2. Article plus supplemental information.

## References

Lead contact

[^1]: ## Introduction

Predicting what will happen next in novel environments is a fundamental feature of intelligent cognition. However, due to the one-dimensional (1D) and irreversible nature of time itself, we can only learn about structured environments through sequential experience. Thus, brains<sup>,</sup><sup>,</sup> and machines<sup>,</sup><sup>,</sup> must convert sequential experience into internal models of the world to remember and exploit structured relationships. When such an internal model, or cognitive map, emerges, it can allow additional flexibility beyond next-step prediction, such as inferring new routes to goals or simulating counterfactual scenarios. An algorithmic understanding of how sequential experience is converted into a rich cognitive map capable of predicting future counterfactual consequences of diverse potential actions remains a major aim of cognitive [neuroscience](https://www.sciencedirect.com/topics/psychology/neuroscience).

Two key brain regions build cognitive maps from sequential experience: the [episodic memory](https://www.sciencedirect.com/topics/social-sciences/episodic-memory) (EM) system in the [medial temporal lobe](https://www.sciencedirect.com/topics/psychology/medial-temporal-lobe) and the working memory (WM) system in the [prefrontal cortex](https://www.sciencedirect.com/topics/psychology/prefrontal-cortex) (PFC).<sup>,</sup><sup>,</sup> However, it is not clear how these brain systems are related in representation or underlying algorithm.

For sequential EM in [hippocampus](https://www.sciencedirect.com/topics/neuroscience/hippocampus) (HPC), ideas are emerging on the underlying algorithms and representations.<sup>,</sup><sup>,</sup><sup>,</sup> In these models, memories are stored in HPC by updating [synaptic connections](https://www.sciencedirect.com/topics/engineering/synaptic-connection) (e.g., [Hopfield networks](https://www.sciencedirect.com/topics/computer-science/hopfield-network)), with cortical [recurrent neural networks](https://www.sciencedirect.com/topics/chemical-engineering/recurrent-neural-network) (RNNs) controlling which memory to store or retrieve by [tracking position](https://www.sciencedirect.com/topics/computer-science/tracking-position) (ordinal, spatial, or otherwise) within the sequence. These models explain many cellular recordings for both spatial and non-spatial tasks: hippocampal cells, such as place cells, landmark cells, and splitter cells, are explained as memory representations, whereas entorhinal cells, such as [grid cells](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/grid-cell), object-vector cells, border-vector cells, non-spatial grid cells,<sup>,</sup> and non-spatial [sound frequency](https://www.sciencedirect.com/topics/earth-and-planetary-sciences/acoustic-frequency) cells, are explained as RNN position representations. Importantly, the hippocampal literature shows us that sequence memory is not just remembering sequences exactly as they were presented but rather using structured knowledge (e.g., position) to recall the right memory at the right time. Successful sequence memory goes beyond rote memorization of experience but instead reflects a cognitive map-building process that learns systematic relationships between events induced by the underlying task structure.<sup>,</sup><sup>,</sup><sup>,</sup><sup>,</sup>

For sequence WM in PFC, our understanding is limited to remembering sequences exactly as they were presented. Here, findings from both artificial<sup>,</sup><sup>,</sup> and biological networks suggest memories of items are organized into, and moved between,<sup>,</sup> neural subspaces according to their ordinal position. Crucially, unlike HPC, storing these memories requires no [synaptic plasticity](https://www.sciencedirect.com/topics/psychology/synaptic-plasticity) because [recurrent](https://www.sciencedirect.com/topics/engineering/recurrent) connections maintain memories in neural activity. Although this is revealing, PFC is implicated in tasks beyond remembering sequences exactly as they were presented, i.e., tasks that required flexible control of memory retrieval.<sup>,</sup><sup>,</sup> Because we understand how HPC EM models allow such flexible control, if we could relate PFC WM and HPC EM, then we could understand how the PFC WM system flexibly controls memories to solve tasks requiring cognitive map-like knowledge of structured relationships.

In this work, we provide an understanding of sequence WM in PFC and how it relates, in representation and algorithm, to HPC EM. In particular, we (1) develop a unifying theory of storing sequence memories in [synapses](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/synapse) (EM) and neural activity (WM); (2) demonstrate that the two algorithms differ in their ability to scale to larger task sizes; (3) demonstrate how the different algorithms utilize different [neural representations](https://www.sciencedirect.com/topics/computer-science/neural-representation), with EM using abstract positions, whereas WM uses slots (distinct neural subspaces) in neural activity; (4) demonstrate that WM slot representation affords “scene algebra”; (5) demonstrate how internally computed [velocity signals](https://www.sciencedirect.com/topics/computer-science/velocity-signal) control the contents of PFC slots; and (6) show that our theory of controllable activity slots provides a common explanation for PFC data from several disparate studies. Overall, a main dividend of our derived duality between HPC EM and PFC WM is a new, unifying theoretical framework for how PFC WM networks could implement and control dynamic cognitive maps of the environment or task through recurrent updates of neural activity alone, without any [synaptic plasticity](https://www.sciencedirect.com/topics/neuroscience/synaptic-plasticity).

### Theory: Unifying memories stored in synapses and neural activity

#### Sequence memory is a structure learning problem

Sequence memory tasks depend on underlying task structures. For example, in immediate serial recall (ISR; a series of observations must be recalled in order) the underlying structure is an ordinal line. Other sequences have different underlying structures, e.g., a sequence drawn from navigating two-dimensional (2D) space has embedded 2D structure. Internal representations that include this structural knowledge dramatically facilitate recall and prediction as different structures have different transition functions. For example, in a 2D [navigation task](https://www.sciencedirect.com/topics/computer-science/navigation-task), correct predictions rely on knowing you have returned to a previous position, which itself requires knowledge of the structure of 2D space (i.e., how recent velocities integrate). Exploiting knowledge of task structure facilitates recall and prediction in problems with a common structural constraint, even when each problem consists of sequences with different observations (therefore, one problem’s sequence cannot be memorized and used for another problem). Here, the underlying task structure must be meta-learned across problems (learning to learn; A left for example ISR task).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr1.jpg)

Download: Download high-res image (1015KB)

#### Task and problem formalism

Formally, for each task, we consider a dataset . Each is one of *N* problem instances of the common task and is a sequence consisting of vectors of observations, , of dimension (termed ), targets, , and (allocentric) velocities, , i.e., for a sequence of length *K*. Although velocities reflect an agent’s actions (conceptual or physical), we provide them externally. Importantly, the underlying structure of the task is determined by how successive actions cumulatively change a latent task state, which is never directly observed by the agent.

Concretely, we assume an underlying latent variable, , corresponding to a latent agent/task state (e.g., position in spatial contexts). Furthermore, we assume each latent state, or position, , is associated with an observation, , which the agent sees if it has the corresponding latent state/position . For any ordered pair of neighboring source and target latent states, there is an action, or velocity, , that modifies the agent’s latent state from the source to the target (e.g., A left for a loop structure with one action). The task structure is encoded by how actions/velocities, change the latent state/position. For example, when navigating in a [2D grid](https://www.sciencedirect.com/topics/computer-science/two-dimensional-grid), there are four elementary actions/velocities—one step north, south, west, or east—with each step moving the latent 2D grid position by one step in the corresponding direction. When a sequence of velocities additively cancel (e.g., north + east + south + west = 0 for a 2D grid), the agent returns to the same latent position and encounters the same observation as before.

For a single task , each individual problem instance assumes a different and random pairing of observations , to latent states . However, all *N* problem instances share the *same* underlying task structure. The aim of the task is to predict a target, , at each timestep: either an upcoming observation (i.e., what you will see after going north), or a past observation (i.e., what you saw 5 steps ago). Importantly, neither latent states nor how actions affect latent states are directly observed. Instead, the agent experiences a sequence of observations and actions. Solving the task, across all problems, requires building a cognitive map capturing how actions affect latent states, and how latent states are bound to observations. Only then, can the agent predict what it will see next when first returning to a previous position. We note that the task formalism (and subsequent model formalism) is general to both discrete and continuous tasks, although we primarily consider discrete tasks here.

We now develop a theory for a simple network realization of an EM solution and from that derive a simple network realization of a WM solution. Crucially, we later show that many features of these simple solutions hold in more general scenarios, both in artificial and biological networks that successfully solve structured sequence memory tasks.

#### Solving sequence memory tasks with EM

The hippocampal literature has developed EM models that solve these tasks.<sup>,</sup> These models have two components (A top-middle): an RNN that learns to explicitly represent position, which generalizes across tasks, and a memory system that binds observation to position representations and stores this memory in [synaptic weights](https://www.sciencedirect.com/topics/engineering/synaptic-weight). These memory [weights change](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/body-weight-change) in every problem because different problems have different associations of observation to latent state/position. In its simplest form, the RNN has a [single neuron](https://www.sciencedirect.com/topics/engineering/single-neuron) active for each position (A middle; full theory in ). Memories are encoded in [synaptic weights](https://www.sciencedirect.com/topics/computer-science/synaptic-weight) between each RNN neuron (corresponding to a position) and an observation representation, with memories added via [Hebbian learning](https://www.sciencedirect.com/topics/psychology/hebbian-learning). The RNN tracks the underlying latent variable, , so that the correct position neuron is activated at the right time to retrieve the right memory (A middle). Tracking position means the RNN integrates velocity signals, , to update its representation from to (i.e., from position to position ). This can be done with velocity-dependent matrices, , that follow the transition rules of (e.g., ; going north then south returns you to the same position). Mathematically, the RNN update is (C). Generating target predictions is succinctly described in the following equation (assuming all observations, , have already been added as memories):(Equation 1)Here, an initial RNN representation, , is successively updated by velocity-dependent matrices, , to represent position at timestep : . To make predictions, selects (similar to an attention vector) one of the observations stored in memory slots in synaptic weights (B; synaptic memory slots are non-overlapping sets of synaptic connections that can be rapidly updated to store arbitrary memories, and each slot corresponds to a position and stores the observation at position ; ). For clarity, we presented a basis where the RNN has one [neuron active](https://www.sciencedirect.com/topics/engineering/active-neuron) at any time, and the matrices have columns containing a single 1 (C), although the above solutions work in any basis, i.e., , . Under simple constraints, the optimal solution is a grid cell basis.<sup>,</sup>

#### Solving sequence memory tasks with WM

The PFC is thought to store memories in the dynamics of neural activity as opposed to synaptic connections<sup>,</sup> (1A top-right; although see Stokes). Here, we show that reshaping and rearranging produces an alternative but equivalent solution where memories are stored in RNN activity rather than synaptic connections (A right):(Equation 2) performs the exact same computation as the, although its terms, despite being similar, are different (). What was a matrix of memories stored in synaptic weights, , becomes a vector of memories stored in RNN activity, . Thus, neural activity is decomposable into non-overlapping subspaces termed activity slots, with each slot able to store a memory of an arbitrary observation (A right). Readout weights are now fixed and attend to a single slot (D; here, slot 1 is the readout slot, but in general, it depends on task structure, e.g., ). To readout the right memory at the right time, the contents of each slot must be copied and shifted to other slots via recurrent weights . These WM velocity-dependent matrices are expanded (and transposed) versions of the EM velocity-dependent matrices, (example in E). Intuitively, is bigger than (by a factor of ) because the WM RNN tracks [relative position](https://www.sciencedirect.com/topics/computer-science/relative-position) to each observation, rather than just position. Adding a memory to a slot is simple. [Feedforward](https://www.sciencedirect.com/topics/engineering/feedforward) weights direct observations to the input slot (e.g., A right). The memory is then passed from slot to slot, controlled by velocity, eventually influencing [behavior](https://www.sciencedirect.com/topics/neuroscience/behavior-neuroscience) from readout slot. Thus, once learned, this solution requires no synaptic plasticity to solve novel problems. Lastly, similar to the EM solution, the WM solution works in any basis.

#### Memory slots unify episodic and WM and yield a rich neural basis for WM cognitive maps

The two solutions use memory slots in different ways. In the WM solution, memory slots are structured neural subspaces with the contents (memory) of each subspace copied and shifted to neighboring subspaces. In the EM solution, memory slots are in synaptic connections, with each memory remaining fixed in its slot (a subspace of the weights). The memory slots are also accessed differently. The EM solution uses flexible attention (via an RNN) to index fixed memory slots (the weights do not move), whereas the WM solution uses fixed attention (the readout weights) but flexible memory slots (slots contents get copied and shifted by the RNN).

Interestingly, these solutions have a striking representational difference. The EM RNN represents latent position (relative to an initial position), independent of observations. However, the WM RNN conjunctively encodes all counterfactual actions and observations simultaneously. In particular, each slot is identified by an action/velocity sequence the agent could take, with its contents answering the counterfactual: what would I see if the slot’s corresponding action were taken? In the case of A, third column, slot 1, aligned with the input/readout weights, contains the correct answer if no action was taken. And slots 2 and 3 contain the correct counterfactual predictions if the agent were to go back one or two positions, respectively. Equivalently, because action sequences correspond to relative positions, each slot represents the relative position to the observation it contains. Every time the agent takes an actual action, the correct counterfactual prediction associated with every slot changes; therefore, the WM RNN must update the contents of every slot by appropriately copying and shifting their contents through the recurrent weights. This ensures that all slots’ contents dynamically change to correctly encode the counterfactual observation associated with the slots’ fixed action label/relative position.

Moreover, because each neuron in each slot is selective for a single observation (in an idealized basis, e.g., A third column), the WM neural code consists of neurons that fire for particular observations at particular relative positions to those observations. Any single neuron’s relative position [selectivity](https://www.sciencedirect.com/topics/earth-and-planetary-sciences/selectivity) derives from its slot identity, whereas its object selectivity derives from its functional role within its slot. This implies that EM and WM single neurons behave very differently across problems. In particular, any two EM position neurons that fire next to each other in one problem will fire next to each other in another problem: they maintain their phase relationship (F; similar to grid cells). On the other hand, two WM activity slot neurons with a particular phase relationship in one problem (G, top) may not have the same phase relationship in another problem (G, bottom). This is because WM slots code for relative position to, or action sequence required to arrive at, a particular observation, and the pairing between positions and observations is shuffled between different problem realizations of a common task, meaning that the [relative phase](https://www.sciencedirect.com/topics/computer-science/relative-phase) between WM neurons will also appear shuffled.

### Model architectures and task specifics

To test our theory predictions that EM systems use position representations, whereas WM systems use activity slots, we use a variety of tasks and model architectures (details in ).

#### Model architectures

We build both EM and WM RNNs (A, 2B, A, and S2B). The key difference between them is that EM RNNs make predictions by retrieving memories from an external memory system, whereas WM RNNs make predictions with a learned readout matrix. For the EM external memory, we use a modern Hopfield network, which our above theoretical results are derived from (). To be general, we use two RNN variants (C and 2D): one inspired by our theory with velocity-dependent recurrent matrices (GroupRNN; related to selective state-space models), and the other is a conventional RNN with velocity signals as input (RegularRNN). All model parameters are initialized randomly and trained using [backpropagation](https://www.sciencedirect.com/topics/engineering/backpropagation).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr2.jpg)

Download: Download high-res image (857KB)

#### Tasks

We consider four main tasks (A, further [neuroscience](https://www.sciencedirect.com/topics/earth-and-planetary-sciences/neurology) tasks introduced later): ISR, N-back, 1D navigation, and 2D navigation. These tasks range in complexity from simple sequence repetition requiring no velocity integration to tasks where velocity must be integrated correctly using a cognitive map. Observations, , and velocity signals, are provided at each timestep and the models are trained to predict a target, , at timestep . An example problem sequence for the 1D navigation task (a [random walk](https://www.sciencedirect.com/topics/computer-science/random-walk) on a loop, e.g., a 3-loop with observations 1, 3, and 2 at the three positions) is: , , and . Here, “” denotes a target is not possible to predict because it has not been observed before. We do not train on these targets. The ISR task is similar to 1D navigation but with constant [forward velocity](https://www.sciencedirect.com/topics/engineering/forward-velocity), the 2D navigation task is a 2D version of the 1D navigation task, and the N-back task is a random observation sequence with the target being the observation N timesteps ago. For each task, we train on multiple problem realizations corresponding to multiple sequences where position-observation pairings are randomized, but the underlying task structure (e.g., 1D navigation) is fixed. See for details.

## Results

### Differences in EM and WM algorithm performance and representation

#### EM scales more favorably than WM

Our theory demonstrates that [EM](https://www.sciencedirect.com/topics/social-sciences/episodic-memory) and [WM systems](https://www.sciencedirect.com/topics/computer-science/working-memory-system) implement the same computation (solve the same tasks) but use different neural algorithms/mechanisms. These algorithms have trade-offs. Most notably, the WM solution requires more [RNN](https://www.sciencedirect.com/topics/chemical-engineering/recurrent-neural-network) neurons than the [EM](https://www.sciencedirect.com/topics/psychology/episodic-memory) solution. Thus we predict that, for a fixed [RNN](https://www.sciencedirect.com/topics/computer-science/recurrent-neural-network) neuron budget, the WM model performance will degrade faster than the [EM](https://www.sciencedirect.com/topics/neuroscience/episodic-memory) model performance as the number of memories needed to be stored, which we refer to as the task size, increases. (While we match [RNN](https://www.sciencedirect.com/topics/social-sciences/neural-network) neurons, we note that [EM](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/episodic-memory) models have additional neurons/parameters in their memory network, which we do account for.) This is observed for the 1D [navigation task](https://www.sciencedirect.com/topics/computer-science/navigation-task) (E), as well as all other tasks (A/S4A for GroupRNN/RegularRNN). Expectedly, performance improves with more [RNN](https://www.sciencedirect.com/topics/psychology/neural-network) neurons. Importantly, performance is measured on new problems (with novel state-observation associations), and all network weights are fixed and do not change (apart from the “fast weights” in the memory module of the EM). Thus, a performance of 100%, achieved for both EM and WM networks on smaller task sizes, means that they learned a cognitive map to generalize task structure.

Although the capacity of these small WM networks is larger than human [WM capacity](https://www.sciencedirect.com/topics/psychology/working-memory-capacity), our networks are noiseless and trained on a single task type (e.g., loop of length 10). This is unlike noisy brain neurons that have to solve multiple different task types. Although EM networks are superior in our prediction tasks, the WM model may have additional benefits. This is because it represents the whole problem in neural activity simultaneously (in slots), allowing operations over states to be done in parallel, e.g., planning and decision-making, unlike EM models, which need to sequentially sample states to plan.

#### EM uses position representations, whereas WM uses activity slots

Our theory predicts that trained EM models use position-like representations to index memories stored in [synaptic weight](https://www.sciencedirect.com/topics/engineering/synaptic-weight) slots (), whereas trained WM models store and manipulate memories in [RNN](https://www.sciencedirect.com/topics/engineering/recurrent-neural-network) activity slots (). To test these predictions, we train linear decoders to decode positions and observations from the neural activity of trained models’ RNNs. Crucially, we avoid task overfitting by training each decoder on many example tasks, demonstrating that the activity slots, or position representations, are generalizable across tasks.

First, our theory says abstract position should be decodable from EM models but not WM models because EM models use position to index memories (F). We confirm this prediction in all tasks and [RNN types](https://www.sciencedirect.com/topics/computer-science/network-type) (G, B, and B). This is consistent with existing EM models<sup>,</sup> that learn position codes to index hippocampal memories, as well as entorhinal neurons such as [grid cells](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/grid-cell). In our models, position is often not decodable for large or small task sizes. For large task sizes, the models did not learn the task and so learned no position representation (E, A, and A). For small task sizes, the EM [RNN](https://www.sciencedirect.com/topics/neuroscience/recurrent-neural-network) learned another memory indexing representation: the WM solution. We discuss this in a later paragraph.

Second, our theory predicts that previous observations should be decodable from the RNN in WM models but not the EM models because the RNN in WM models store memories of previous observations in neural activity slots, whereas the RNN in EM models only tracks position. More precisely, our theory prescribes exactly which past observation is stored in which neural activity slot at any given time (B and S1C). Thus, for each neural activity slot, our theory predicts that it encodes a particular sequence of observations, and, importantly, this sequence, for tasks with varying [velocity signals](https://www.sciencedirect.com/topics/computer-science/velocity-signal), is not simply a temporally shifted copy of the input observations (H). We call this the slot sequence for each predicted activity slot in a given problem. We find that slot sequences can be decoded from RNN activity in all tasks for WM models (average slot sequence decoding across task sizes in I left, C, and C; individual slot sequence decoding for a particular task in I right, D, and D), whereas temporally shifted copies of the input observations (past sequences) cannot be decoded (apart from the ISR and N-back task where past sequences and slot sequences are identical). Slot sequence [decoding performance](https://www.sciencedirect.com/topics/computer-science/decoding-performance) degrades for larger task sizes because the RNN fails to learn the task. These results demonstrate that WM networks learn activity slots and use velocity signals to control activity slots.

Interestingly, although EM networks have, as predicted, poor slot sequence decoding and high abstract position decoding in most situations, the converse can be true for small task sizes (G and S3I). This is because activity slots are also an effective memory indexing representation because they uniquely represent each position in each problem. We posit that the WM solution is easier to learn (when not limited by number of neurons) because slot representations are a direct function of input data, whereas position representations are abstract.

Although EM and WM networks, once trained, have the same generalization [behavior](https://www.sciencedirect.com/topics/neuroscience/behavior-neuroscience) (due to the formal equivalence of the EM and WM solutions), their learning dynamics and sample complexity differ (G) with EM networks learning faster (except on N-back task). This is because the inductive bias of EM networks (fast memory binding) is suited to our tasks with novel state-observation pairs. By contrast, WM networks have no explicit bias and therefore must learn how to appropriately store memories. Further, GroupRNN learns faster than RegularRNN due to its inductive bias that facilitates path integration.

### Visualizing slots and “slot algebra”

#### Visualizing slots

Our decoding analyses demonstrate that WM models learn activity slots, as predicted by our theory. We focused on decoding analyses because learned activity slots will in general correspond to neural activity subspaces, not necessarily aligned to [single neuron](https://www.sciencedirect.com/topics/engineering/single-neuron) axes similar to our WM schematics (single neurons could exhibit mixed [selectivity](https://www.sciencedirect.com/topics/earth-and-planetary-sciences/selectivity) for multiple slots). To visualize learned activity slots, we leverage a recent technique that encourages single neurons to demix and code for single independent factors (e.g., slots). WM RNNs trained with this technique learn a demixed solution where single neurons participate only in a single slot (A) and quantitatively demix on all four tasks and for both RNN types (A).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr3.jpg)

Download: Download high-res image (463KB)

#### Slot algebra predicts relations between neural representations of different problems from a common task

We test a further prediction of our theory: activity slot representations are compositional and obey a slot algebra with simple linear relationships between WM representations of different problem realizations of the same underlying task. Consider a task with three latent positions and four possible observations (B). Let denote the WM activity slot representation when our theory predicts observations are in slots respectively. Now consider the [neural representations](https://www.sciencedirect.com/topics/computer-science/neural-representation) for two problems, and . These problems differ only in their observation in slot 2, and our activity slot theory predicts the linear relation (B illustrates this relation), where *a* and *c* can be any observations.

We examine the WM RNN in situations that satisfy the equality relation above by extracting neural representations from the RNN in four different problems. We sum the three representations according to the right-hand side of the relation and compare the sum with the measured representation on the left-hand side using a squared difference measure (). We compare this with the squared difference of the first term on the left and the first term on the right () via the ratio . Low values indicate that the representation obeys slot algebra.

Perfect slot algebra requires pure activity slot representations. However, some velocity-integrating RNNs, both in biology and models, have velocity-modulated neurons. Indeed, it is possible to have activity slot representations that are velocity-modulated ( high ). Thus, slot algebra is additionally informative of how RNNs integrate velocity. We test slot algebra on the GroupRNN, which modulates [synapses](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/synapse) with velocity signals (similar to our theory), the RegularRNN, which uses additive velocity signals, and, additionally, the BioRNN, which integrates velocity signals in a separate [neural population](https://www.sciencedirect.com/topics/engineering/neural-population) to the RNN activities themselves. As predicted, the GroupRNN has low for all datasets (C; we do not use the N-back task as is not well defined there) because velocity does not directly modulate RNN activity. further improves with [regularization](https://www.sciencedirect.com/topics/computer-science/regularization) (KL) that encourages consistency across timesteps, i.e., limiting velocity modulation (see ). Conversely, as predicted, the RegularRNN only achieves low on the ISR dataset, which requires no velocity signal. Lastly, the BioRNN achieves low for all datasets. Intriguingly, the BioRNN architecture is related to the fly head direction circuit<sup>,</sup><sup>,</sup> (E and S2F; details in ).

### Velocity-controlled activity slots explain diverse PFC representations

Our theory of controllable WM activity slots explains artificial RNN representations trained on sequence memory tasks. Does this understanding transfer to biological RNNs? And, if so, how are the velocity signals, which are crucial for successful control, represented? Here, we show that activity slots unify PFC-dependent sequential and cued memory tasks, with the distinguishing feature being the velocity control signals.

#### PFC and RNNs compute and represent velocity signals

In previous tasks, we provided velocity signals to the model. Brains do not have this luxury—they must compute velocity signals from their inputs. In spatial tasks, self-movement vectors are computed from vestibular or other [sensory inputs](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/sensory-stimulation) and represented using head direction and speed cells. It is unknown what the corresponding velocity signals are for complex non-spatial tasks. Recent [PFC](https://www.sciencedirect.com/topics/psychology/prefrontal-cortex) data, however, although not demonstrating velocity signals, have found neurons that track progress to goals, invariant to the actual goal distance.<sup>,</sup> Here, a 50% “progress cell” fires midway between two goals, whether they are three steps apart or 20. To update progress, we contend that “progress velocity” signals must be computed and represented. To test this, we train WM models on analogous tasks.

In particular, Basu et al. and El-Gaby et al. trained rodents to repeatedly visit two and four (of nine) spatially located reward ports in sequence, respectively. The animals were trained on many problem realizations with random goal positions. We model these tasks (modulo the spatial component to be general) as 2-ISR and 4-ISR tasks but with delays between each observation (analogous to the delay traveling between spatial goals, A and 4E, left). Critically, although delays are random across different problem realizations, delays are the same on each loop of a problem. For example, possible 2-ISR delay sequences for different problem realizations are or where is the common delay observation (that also gets predicted), and possible 4-ISR delay sequences are or . We provide no explicit velocity signal—the model must compute progress velocity for each delay period from sparse inputs and remember it on returning to that same delay (after a loop of experience).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr4.jpg)

Download: Download high-res image (588KB)

After training WM models, we can decode progress and progress velocity (A and 4E, right) and visualize tuning at the single neuron level (B, 4F, and ). The network is computing progress velocity to overcome the different delays. The question remains: how does this relate to activity slots?

#### Controlling activity slots with progress velocity

We posit that activity slots are “task-progress” structured (C and D), with slots coding for, e.g., 25% or 150% since observation (up to 200/400% for the 2/4-ISR delay task) and progress velocity controlling when slot contents move to subsequent slots. (Task-progress slots are continuous rather than discrete, with bumps of activity on continuous attractor manifolds defining an observation within a “slot.” For consistency, we still refer to them as if they were discrete.) This allows variable-length delays across different problems to be mapped to a common slot structure for generalization. Indeed, we can decode task-progress activity slots (A and 4E, right) and observe task-progress slot neurons (D and 4G), which fire at a particular task-progress after a preferred observation (further examples in ). Notably, as our model predicts, both progress and task-progress slot neurons were recently recorded in rodent mPFC, with the pathway linking the same observation across slots in the task-progress slot analogous to their “structured [memory buffers](https://www.sciencedirect.com/topics/engineering/buffer-memory).”

#### Hierarchical slots

In the 4-ISR delay task, to correctly predict observations on the second (and subsequent) repeats within each problem, each of the four delays must have been computed and remembered on first presentation. This induces a hierarchy of activity slots with observations stored in task-progress slots and the four delays stored (after being computed) in separate higher-level slots (H, top). Now the right delay (inverse velocity) at the right moment can be retrieved to control the lower-level task-progress slots. Indeed, we can decode slot contents consistent with this hierarchical slots hypothesis (H, bottom). We predict that PFC uses hierarchical slots as a [neural mechanism](https://www.sciencedirect.com/topics/computer-science/neural-mechanism) for [cognitive control](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/executive-function).

#### PFC activity slots in a sequence memory task

Our activity slot theory also accounts for PFC representations in standard sequence memory tasks where only a [constant velocity](https://www.sciencedirect.com/topics/computer-science/constant-velocity) is required. In particular, Xie et al. recorded PFC neurons in a 3-ISR task. Here, monkeys were shown three (of six) positions on a screen in sequence and were trained to, after a delay, [saccade](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/saccadic-eye-movement) to the three positions in order (A). Similar to our ISR tasks, the monkeys were trained on many such sequences. Neural activity in the delay period decomposed into three [orthogonal subspaces](https://www.sciencedirect.com/topics/engineering/orthogonal-subspace), with the first/second/third saccade position simultaneously encoded in the first/second/third subspace (B and 5C). These three subspaces are activity slots (D). Indeed, WM networks learn the same subspace decomposition (E and 5F).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr5.jpg)

Download: Download high-res image (527KB)

#### PFC activity slots in a cued memory retrieval task

We have considered external and internally generated velocity signals; however, observations themselves can serve as velocity signals. Here, we show that sensory cues can be understood as velocity signals controlling PFC activity slots. In particular, Panichello and Buschman recorded PFC neurons in monkeys performing a cue-dependent memory task, where two colors are presented at the top and bottom of a screen. After a delay, a sensory cue dictates whether to report the top or bottom color after another delay (A). Importantly, each problem realization is a random combination of two colors and cue. Neural activity in the first delay period decomposed into two [orthogonal subspaces](https://www.sciencedirect.com/topics/computer-science/orthogonal-subspace), with the first/second subspace representing the top/bottom color (B, left). After the cue, the top (when correct) and bottom (when correct) colors are represented in parallel subspaces (B, right, and C). This is explained by activity slots (D): the initial two subspaces are activity slots for the top and bottom color, then the cue behave similar to a velocity signal to route the correct color to the readout slot (hence, why subspaces are parallel after the cue on correct trials; D, bottom). Indeed, WM networks learn the same subspace decomposition and dynamics (E–6G).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr6.jpg)

Download: Download high-res image (564KB)

## Discussion

We derived a formal relationship between the algorithms and representations of episodic and working sequence memory and, in simulation, validated predictions that EM networks learn abstract position-like representations, whereas WM networks learn activity slot representations, different neural implementations of cognitive maps that generalize to novel state-observation pairings. Further, we demonstrated that our theory of controllable activity slots provides a unified [neural mechanism](https://www.sciencedirect.com/topics/computer-science/neural-mechanism) to several PFC studies.<sup>,</sup><sup>,</sup><sup>,</sup> Although these PFC representations have simple (often loop) structures, we anticipate that PFC will represent more complex structures, such as 2D slots, when participants are trained on sequences drawn from 2D tasks.

Activity slots may also explain PFC data from non-explicit [WM tasks](https://www.sciencedirect.com/topics/computer-science/working-memory-task). For example, human mPFC (fMRI) activity obeys rules of scene algebra (analogous to slot algebra) during scene construction tasks. Notably their task requires compositional understanding (objects are in any scene configuration) similar to our sequential WM tasks. In general, we anticipate that activity slots will be relevant in tasks requiring compositional understanding beyond WM in brains and machines. For example, activity slots could represent sub-goals for planning, which would explain why the same brain region is involved in WM, value-based decision-making, and goal-directed planning.<sup>,</sup> Notably, in [machine learning](https://www.sciencedirect.com/topics/computer-science/machine-learning), slot models are used in diverse settings from natural language to planning and scene construction.<sup>,</sup>

Although we related the EM and WM algorithms to [HPC](https://www.sciencedirect.com/topics/neuroscience/hippocampus) and PFC, their key distinction is whether memories are stored in [synaptic connections](https://www.sciencedirect.com/topics/engineering/synaptic-connection) or neural activity. Because PFC connects to HPC (via entorhinal cortex), the prefrontal RNN can assist in hippocampal memory retrieval and thus also represent abstract position representations. Indeed, grid-like coding has been observed in mPFC.<sup>,</sup> However, in some WM tasks,<sup>,</sup> early evidence suggests that position representations are not decodable from rodent mPFC. Furthermore, our theory suggests that any brain region, not just PFC, storing memories in neural activity will utilize activity slots.

It is also plausible that PFC utilizes short-term [synaptic plasticity](https://www.sciencedirect.com/topics/neuroscience/synaptic-plasticity) to store memories, with recent modeling suggesting that this may better explain PFC responses. It is not clear, however, how this explains existing PFC data on sequence WM,<sup>,</sup><sup>,</sup> which are consistent with activity slots.

Activity slots for (non-sequence) WM have been considered before,<sup>,</sup><sup>,</sup><sup>,</sup> where behavioral evidence is against a naive slot implementation because human recall performance degrades gradually with task size rather than a sharp drop-off when all slots are full. Instead, the conceptual “continuous resource models” are preferred in which fixed resources (pool of neurons) flexibly code for differing numbers of memories but with increasing interference for increasing task size leading to gradual performance decline. In fact, activity slots are compatible with continuous resource models, either by chunking memories together when the task size exceeds the number of discrete slots or by using continuous activity slots (similar to ) and placing memories (bumps of activity) closer together on the slot attractor manifold as task size increases. Both of these methods would have a gradual decline in recall performance due to memory interference. Continuous activity slots may also permit generalization to task sizes beyond the training distribution: analogous to how the grid cell hierarchy allows position coding of environments larger than the largest grid scale, we anticipate that continuous activity slots may have a hierarchical representation facilitating length generalization.

We have not solved the algorithm of RNNs on all sequential WM tasks because naive activity slots are not learned in some tasks (e.g., A and S7B). Nevertheless, we suggest that activity slots are a general-purpose solution. Of note to [machine learners](https://www.sciencedirect.com/topics/computer-science/machine-learner), our formalism, as well as the GroupRNN, is a selective state-space model; thus, our work offers insights into the neural mechanism of learned state-space models, RNNs, and transformers (and their relationships).

The hippocampal and frontal systems are thought to be essential in mediating higher-order cognition, with patients exhibiting profound deficits in behavioral flexibility if these structures are damaged.<sup>,</sup> Although these systems have been the subject of intense study over the last several decades—both experimentally and theoretically—they have been largely treated independently, and their respective cellular representations are hard to reconcile. Our work brings together these systems by showing that the algorithms and representations of frontal WM and temporal EM are two sides of the same coin.

## Resource availability

### Lead contact

Requests for further information and resources should be directed to and will be fulfilled by the lead contact, James Whittington ([jcrwhittington@gmail.com](mailto:jcrwhittington@gmail.com)).

### Materials availability

No materials were generated in this study.

### Data and code availability

Python and PyTorch code is available on [https://github.com/djcrw/em-wm-slots](https://github.com/djcrw/em-wm-slots).

## Acknowledgments

We thank Kris Jensen and Jo Warren for helpful feedback on the manuscript. We thank the following funding sources: Sir Henry Wellcome Postdoctoral Fellowship () to J.C.R.W.; the Gatsby Charitable Foundation to W.D.; Wellcome Principal Research Fellowship (), Wellcome Collaborator award (), and Jean-François and Marie-Laure de Clermont-Tonnerre Foundation award () to T.E.J.B.; the Wellcome Centre for Integrative Neuroimaging is supported by core funding from the Wellcome Trust (); and the James S. McDonnell, Simons Foundations, NTT Research, and an NSF CAREER Award to S.G.

## Author contributions

J.C.R.W. conceptualized the study with input from W.D. and all other authors. J.C.R.W. derived theory and performed simulations. J.C.R.W. wrote the manuscript with input from all other authors.

## Declaration of interests

The authors declare no competing interests.

## STAR★Methods

### Key resources table

<table><thead><tr><th>REAGENT or RESOURCE</th><th>SOURCE</th><th>IDENTIFIER</th></tr></thead><tbody><tr><th colspan="3"><strong>Software and algorithms</strong></th></tr><tr><td>Python 3.11</td><td>Python Software Foundation</td><td><a href="https://www.python.org/">https://www.python.org/</a></td></tr><tr><td>PyTorch 2.4</td><td>Paszke et al.</td><td><a href="https://pytorch.org/">https://pytorch.org/</a></td></tr><tr><td>Code for this paper</td><td><a href="https://doi.org/10.5281/zenodo.13909034">https://doi.org/10.5281/zenodo.13909034</a></td><td><a href="https://github.com/djcrw/EM-WM-slots">https://github.com/djcrw/EM-WM-slots</a></td></tr></tbody></table>

### Method details

#### Full Theory

##### Task reminder

Formally, for each task, we consider a dataset , where each is a sequence consisting of vectors of observations, , of dimension (termed ), targets, , and (allocentric) velocities, , i.e., if the sequence is of length *K*. These velocities mimic real actions taken by agents, but in this case we provide them externally. Importantly, the underlying structure of the task prescribes how the velocities add up to cancel each other out (just like North + East + South + West = 0 defines 2D space), and when the velocities cancel each other out, the observation is identical to what it was previously (just like returning to the same position in 2D space). Concretely, there is an underlying latent variable, , corresponding to ‘position’, and each position, , is associated with an observation, , and any two neighbouring positions are related by a velocity, (example for a simple loop structure in A left). For each , while the observation-position pairing is random, the underlying structure is preserved (velocities add up and cancel in the same way). The aim of the task is to predict a target, , which is either an upcoming observation (i.e., what you will see after going North), or a past observation (i.e., what you saw 5 steps ago). Importantly, at time *t* the model predicts the target at time – one-step prediction. While the task formalism (and subsequent model formalism) is general to tasks with discrete and continuous positions, we primarily consider the discrete setting here (with total positions).

##### Solving these tasks with an EM model

Such tasks can be solved using EM systems that consist of RNNs equipped with an external memory. The external memory can be a [Hopfield network](https://www.sciencedirect.com/topics/computer-science/hopfield-network), a modern Hopfield network, a transformer [neural network](https://www.sciencedirect.com/topics/neuroscience/neural-network), or a differentiable neural dictionary. All these methods are relatable to each other, and crucially can all be viewed as storing memories in synaptic connections. Here, we present the differential neural dictionary / modern Hopfield network version (as they are general external memory devices). Additionally, we consider an RNN that only receives [recurrent](https://www.sciencedirect.com/topics/engineering/recurrent) input and the velocity signal. Predictions are made via(Equation 3)Where is the RNN state representation at time *t*, and and are stored memories, i.e., the memories bind together each and at each timestep. (Normally key, query, and value matrices, are used i.e., . We leave them out for simplicity, but the following argument would remain the same if we included them.) We note that the targets are in the form of observations (upcoming/ those that have previously been seen) and so stored memories of observations will facilitate accurate prediction.

The particular choice of RNN does not matter for our purposes here - it just needs to accurately track position, . Nevertheless, the RNN state, , will be a function of past velocities, , as it must integrate velocities to track position:(Equation 4)In the bottom line of the above equation, we present two common ways for integrating velocity in RNNs, the first uses velocity dependent matrices, , to update RNN state and is inspired from group theory (and can mathematically shown to produce grid cells in 2D space), and the second is a classic RNN where is a recurrent matrix and is an matrix that maps velocities to the RNN. Note is the velocity from , and so while the classic RNN takes as input at timestep *t*, it is really the velocity that was provided at that gets used to update position (via the recurrent weights) at time *t* (that’s why in the velocity-dependent matrix case we use to get to ). This is just how classic RNNs are usually framed.

Regardless of the particular RNN, if learns to have the same structure as (i.e., it represents position: ) then we can rewrite(Equation 5)

and(Equation 6)This says that the memories formed at each timestep (when at position ) are the *true* neural representation of position : and the observation at position : . Thus the attention vector will attend to the right memory at each timestep (i.e., memories that were paired to in the past) since will be more similar to itself, than to , where is a different position.

##### Simplifying an optimal EM model

We consider a optimal EM model, and consider its representations. We assume that if an underlying ‘position’, , is visited more than once, the additional memory is not added, thus after all ‘positions’, , have been visited and , where is the number of ‘positions’ for this task: we only store memories. Thus, since a single memory get retrieved at any one time, the optimal attention vector, will be one-hot and with a single element active for each position. (If the target were to predict a mixture of past observations, the attention vector would not be one-hot, but the same argument follows just the same.) To make our lives easier, since attention is order invariant, we can relabel, and reorder, individual memories, not by the time, but by their ‘position’: and . Since the one-hot attention vector, after a velocity , will change to another one-hot attention vector (coding for position then position ), the attention vector can be though of as representing a node on a graph. We call the attention vector at timestep *t* corresponding to position as . Thus, the update to the attention vector is *functionally equivalent* to an attention vector being multiplied by an (velocity/action dependent) graph [transition matrix](https://www.sciencedirect.com/topics/computer-science/transition-matrix), , i.e., . Thus (optimal) predictions can be rewritten as:(Equation 7)

*Expanding this equation out yields*:(Equation 8)This equation describes the functional computations of an optimal EM model. We see that it reduces to an attention vector that gets updates by velocity-dependent graph transition matrices. This attention vector then attends to memories stored in weights. Interestingly, this simplified formulation, can still be thought of as an RNN (the attention vector RNN) and an external memory (the memory slots). But we stress that this is a simplified formulation, as opposed to the actual model implementation (see ). Nevertheless it captures the computations of an optimal full EM model implementation.

##### Rearranging terms gives the WM solution

The above solution stores memories in synaptic connections. Here we show that reshaping and rearranging the above equation produces an alternative, but equivalent, solution where memories are stored in RNN activity rather than synaptic connections:(Equation 9)This equation performs the exact same computation as the previous equation, and its terms look very similar but there are some important differences ( for relationships between terms). For example, is like the previous velocity-dependent matrices, , but expanded (and transposed); where there was a 1 or a 0, there is now an [identity matrix](https://www.sciencedirect.com/topics/computer-science/identity-matrix) () or a matrix of zeros (). Intriguingly, what was a matrix of memories stored in weights, , is now a vector of memories stored in RNN activity, . Thus the neurons in the RNN can be though of as **activity slots** that store arbitrary memories in neural activity (A right). Importantly, since the readout weights are now fixed, the contents of each slot must be copied and shifted to other slots via , depending on the desired observation to readout. Adding a memory to a slot is simple and only requires feed-forward weights from observation to input slot (e.g., A right). Thus, once learned, this model requires no synaptic plasticity. Lastly, similar to the EM solution, this WM solution works in any basis (not just the one presented above).

##### Separate attractor networks for computing velocities, and controlling slots

We now show that an RNN can consist of two components: a component for computing velocities, and a component for using velocities to control activity slots. A generic RNN updates is as follows:(Equation 10)If we split into two parts, , where are the activity slots and are the neurons involved in computing velocity signals (we’re choosing a favourable basis where the two components are in separate neurons). Then we get the following:(Equation 11)Where is the block of that goes from neurons etc, and in the last line we have assumed that information from slot neurons are not useful to velocity neurons (). Thus this RNN consists of a velocity computing RNN, , that computes velocities based on inputs and sends these velocities to the slot RNN, , vis .

#### Model Details

We train models which are all variants on recurrent [neural networks](https://www.sciencedirect.com/topics/computer-science/neural-network) (RNNs), which differ in two key components (). The two varying components are: 1) we use different RNN variants (varying from least to most biologically plausible), and 2) we use different methods of predictions from RNN activities for EM models (via fast Hebbian weights that change every timestep) and WM models (via slow weights learned by backpropagation).

##### RNN transitions

We use a gated RNN similar to a GRU, where the external and recurrent inputs are gated: , where is the external input at timestep *t*, is the recurrent input, is an [activation function](https://www.sciencedirect.com/topics/computer-science/activation-function), and is an element-wise gate with the Sigmoid activation, *σ*. We compute the recurrent and external inputs in two different ways. First, like our theory, we use (learned) velocity-dependent matrices, : , and the external input, , is just . We call this *GroupRNN* (C). Second, we use a conventional gated RNN, with , and the external input, , is and concatenated. We call this *RegularRNN* (D). In we make use of another RNN inspired by the fly head direction circuit (E and S2F). In *BioRNN*, we have , where projects into a higher dimensional space. The external input, , is just .

It is unlikely that velocity dependent weights matrices (i.e., the GroupRNN), as per our theory, are exactly what the brain uses since it requires modulation of synapses depending on velocity. It is more likely that the brain uses additive velocity signals like a RegularRNN/BioRNN. Importantly, however, in our simulations of both GroupRNN (velocity dependent weights matrices) and RegularRNN/BioRNN (additive velocity input) slot representations are learned. This is perhaps not surprising since the standard formulations of continuous attractor neural networks have separate populations of neurons for each direction (e.g., left and right neurons for a ring attractor), which is closely related to velocity dependent matrices as the velocity input essentially gates the left/ right neurons which have left/right projections. Thus we anticipate our theory also applies to path-integrating networks learned with additive velocity input like RegularRNN and CANNs.

##### Fast or slow readout weights

We use two readout methods to correspond to the two model classes in our theory. First, for the **WM** class: predictions are made by , i.e., standard RNN prediction (B). Second for the **EM** class: predictions are made using an external memory system related to a transformer / Hopfield network. In particular, , where the key and value matrix are sequentially updated i.e., and (A; we use for ‘value’ as is already used for velocity). At the beginning of each sequence, and are reset to be empty.

##### Adding memories in EM models

Memories are simply added to a list, just like the differentiable neural dictionary or modern Hopfield network. These memories consist of two parts - a key and a value (A). The added key, as described above, at each timestep is , while the [added value](https://www.sciencedirect.com/topics/social-sciences/value-added) is , where is the retrieved memory at that timestep (). We do this, so that repeat copies of memories are not added.

Since the list of memories grows in time, we add an additional *β* scaling term in the softmax: . We do this as the normalisation term in the softmax sums over the number of memories, and so more memories down-weights attention probabilities. We want the attention vector to not be affected by the number of elements in the set. In particular, we weight the softmax by .

##### Adding memories in WM models

There is no explicit memory adding process in WM models. There are simply input weights from the input at each timestep, , and so the RNN must figure out how to hold these inputs in its recurrent memory.

##### Normalisation

We use normalisation in two places. 1) In EM models, after retrieving a memory i.e., before applying we perform a layer normalisation: . This is so all retrieved memories have the same scaling. 2) In some simulations (detailed in ) we also normalise the output of the RNN for both WM and EM models. We do this for consistency when comparing WM and EM models. For WM models this means . For EM models this means memories are retrieved as .

##### Optimisation

All weight matrices are learned by [backpropagation](https://www.sciencedirect.com/topics/engineering/backpropagation) in both models. We optimise a prediction loss on the target, , which is a cross-entropy loss when observations and targets are one-hot (all simulations other than and ), or a [squared error loss](https://www.sciencedirect.com/topics/computer-science/squared-error-loss) otherwise ( and ). For all simulations we add weights decay. For the ‘additional constraints’ in we add a L2 loss on the RNN activity. Also in, we use an additional KL loss (where specified) which is a squared error loss between inferred () and predicted () RNN activity. All loss hyperparameters specified in.

#### Additional Task Details

Here we provide further task details. In all tasks we train on many [instantiation](https://www.sciencedirect.com/topics/engineering/instantiation) of the task, i.e., observations randomised across each [instantiation](https://www.sciencedirect.com/topics/computer-science/instantiation). In all tasks observations are randomly sampled at positions with replacement, except for the delay task and the PFC tasks.

##### Immediate Serial Recall (ISR)

Observations repeat cyclically, and the task is to predict the upcoming observation (). There is no velocity signal. e.g., a 4-cycle: and . ‘’ means a target that we do not try to predict since it has not been observed before and therefore is not possible to predict. The length of the each sequence is 7 multiplied by the repeat length.

##### N-back

Observations are randomly drawn at each step, and the task is to recall the observation *n* timesteps ago. There is no velocity signal. e.g., for : and . The length of the each sequence is 7 multiplied by *N*.

##### 1D Navigation

Observations come from [random walks](https://www.sciencedirect.com/topics/computer-science/random-walk) on a loop. Velocity signals are provided. e.g., a 3-loop: , and . While velocities are randomly sampled at each step, to encourage exploration of the full loop, we increase the likelihood of repeating velocities (apart from the 0 velocity). The length of the each sequence is 7 multiplied by the loop size.

##### 2D Navigation

Observations come from random walks on a [2D torus](https://www.sciencedirect.com/topics/computer-science/dimensional-torus). Velocity signals are provided. e.g., a 2x2 torus: , , and . The length of the each sequence is 7 multiplied by the torus size.

To demonstrate the generality of slots, we show that they are learned even when training on all targets i.e., including those that are impossible to predict correctly (as those states have not been visited yet). All models learn slots (E–S4H), but understandably the models are less capable of learning larger task sizes because their training is less stable due to having [error gradient](https://www.sciencedirect.com/topics/computer-science/error-gradient) signals from the impossible targets to predict.

##### 2-ISR with delays

See also. Delay period lengths were randomly sampled from \[3,4,5,6,7\] for each task. Example observation sequences are or where is the common delay observation (that also must be predicted). Corresponding target sequences are or . Again we do not train on targets not possible to predict (i.e., observations/delays that have never been visited). We also so not train on the \\nth1 return to the [initial position](https://www.sciencedirect.com/topics/computer-science/initial-position). This is because it also cannot be predicted as it could have been a delay step. Observations are sampled without replacement. The length of the each sequence is 7 multiplied average full loop length (averaging over delays).

##### 4-ISR with delays

See also. Delay period lengths were randomly sampled from \[3,4,5\] for each task. Example observation sequences are or where is the common delay observation (that also must be predicted). Corresponding target sequences are or . Again we do not train on targets not possible to predict (i.e., observations/delays that have never been visited). We also so not train on the \\nth1 return to the initial position. This is because it also cannot be predicted as it could have been a delay step. Observations are sampled without replacement. The length of the each sequence is 7 multiplied average full loop length (averaging over delays).

##### 1D Navigation with structured velocity signals

See also. We used a 7-loop task (1D navigation), but where the underlying velocity cycles a fixed schedule of (velocity cycled on a 6-loop). Velocity signals were not provided. The length of the overall sequence is 7 multiplied by the loop size.

##### 2D Navigation with structured velocity signals

See also. Sequences we drawn from a 3-by-3 torus, but where the underlying velocity cycles a fixed schedule of (velocity cycled on a 8-loop). Velocity signals were not provided. The length of the overall sequence is 7 multiplied by the torus size.

##### 1D Navigation using macro-actions

See also. We used a 8-loop task (1D navigation). We used 9 possible macro actions:

Macro-actions were sampled randomly, with a slight bias to repeating the same macro-action (to encourage full exploration of the loop). The length of the overall sequence is 7 multiplied by the loop size.

##### 2D Navigation using macro-actions

See also. Sequences we drawn from a 3-by-3 torus. We used 8 possible macro actions: , where 0 means no velocity. Macro-actions were sampled randomly. The length of the overall sequence is 7 multiplied by the torus size.

##### Xie et al.

See also. Here observations are one of six 2D [positions lying](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/recumbency) on a ring. This is just like the original paper). Thus the [observation vector](https://www.sciencedirect.com/topics/engineering/observation-vector) consists of two [real numbers](https://www.sciencedirect.com/topics/engineering/real-number) rather than a one-hot vector as before. Likewise for the targets. Observations are sampled without replacement. Otherwise the set-up is the same as a 3-ISR task, but only with a single repeat (i.e., 6 observations in total), e.g., and where is a 2D position vector (corresponding to the six positions lying on a ring).

##### Panichello et al.

See also. Here observations are one of four 2D coordinates lying on a ring. The original paper uses randomly sampled colours (from a 2D colour ring), and for visualisation purposes they bin these colours into 4 bins. Thus we just use 4 example colours (we could have used randomly drawn colours - the activity slot predictions are the same). Thus the [observation vector](https://www.sciencedirect.com/topics/computer-science/observation-vector) consists of two [real numbers](https://www.sciencedirect.com/topics/computer-science/real-number) (corresponding to a colour the colour wheel) rather than a one-hot vector as before. Likewise for the targets. Observations are sampled without replacement. The length of the sequence is 4 (top colour, bottom colour, cue, target), e.g., and , where is a [2D vector](https://www.sciencedirect.com/topics/computer-science/dimensional-vector) (corresponding to a colour on the colour wheel).

### Quantification and statistical analysis

#### Decoding Analyses

For all decoding analyses, we take the neural representations at each timestep in the sequence, along with the value of the variable we wish to decode at each timestep in the sequence. We collect this data for many timesteps and for multiple (240) [random sequences](https://www.sciencedirect.com/topics/computer-science/random-sequence), and collate this data into a training dataset (number of data-points is where *s* is sequence length), with inputs being the neural representations, and outputs being the variable we wish to decode. In all decoding analyses, we only decode from timesteps after all positions have been visited at least once (so activity slots can be filled). We use (multi-class) [logistic regression](https://www.sciencedirect.com/topics/computer-science/logistic-regression) (using the sklearn python package) for all decoding analyses (apart from task-progress slot decoding - see later), as we discretise continuous [random variables](https://www.sciencedirect.com/topics/engineering/random-variable-xi) into discrete classes. We train the decoders and then test on a held out dataset of 60 [random sequences](https://www.sciencedirect.com/topics/engineering/random-sequence) (all presented results are test accuracy). We now describe how we obtain the particular variables we wish to decode.

##### Position decoding

We define the first element of each sequence to be at position 0, and then track position from then onwards (i.e., we track [relative position](https://www.sciencedirect.com/topics/computer-science/relative-position) to initial position). We give each position a unique identifier, so we can perform multi-class logistic regression.

##### Slot decoding

For every sequence, we calculate each slot’s stored observation according to our theory at all timesteps (H; we call this the slot ‘slot-sequence’ for each slot). We decode each slot-sequence individually using multi-class logistic regression. When taking the average [decoding performance](https://www.sciencedirect.com/topics/computer-science/decoding-performance) over slots, we do not include slot 1, i.e., the input slot, as it will always decode to 1 (since the slot-sequence for slot 1 is just in input sequence which gets provided to the model). While for each task the observations in the slots are permutations of one-another (e.g., H) and so it may be thought that if you can decode slot 1 (the input slot!) then you can decode any other slot, the permutation is not consistent over task instantiations. Thus, since we decode multiple sequences from multiple task instantiations at once, only RNNs that have actually learned a slot representation will have high slot-sequence decoding accuracy.

##### Past decoding

For every sequence, at each timestep we calculate which observation occurred *n* timesteps ago (H; we call this ’past-sequence’ for each time lag *n*). We do this for to where is the number of slots. We run a separate decoder for each value of *n*. When taking the average decoding performance over past-sequences, do not include as it will always decode to 1 (since the current observation is being provided to the model).

##### Progress decoding

To calculate progress, at each timestep, we calculate the number of delay steps taken since an observation and divide by the total number of delay steps (between neighbouring observations). We then discretise progress into 4 chunks, i.e., , , , .

##### Progress-velocity decoding

We calculate progress-velocity, for each timestep, we compute 1 divided by the total number of delay steps (between neighbouring observations). We then provide a unique identifier to its value. Thus decoding progress-velocity, is the same as decoding the number of delay steps between the current neighbouring observations.

##### Task-progress slot decoding

We first discrete the task into task-progress slots where *T* is positions in task (i.e., 2 for the 2-ISR delay task) and is the number of progress chunks after discretising progress. At each timestep we calculate which observation our theory says should be in each task-progress slot. Most slots will be empty as there are only *T* observations but task-progress slots. Thus rather than having a separate decoder for each task-progress slot, we train a single 2-layer linear [neural network](https://www.sciencedirect.com/topics/chemical-engineering/neural-network) (with sigmoid [activation function](https://www.sciencedirect.com/topics/engineering/activation-function) on the output; 2 linear layers as it trains faster even though it is no more expressive) where the inputs are neural representation at each timestep and the outputs are whether an observation is in a particular slot. There output dimension is then for the 2-ISR delay task, where is the number of observations. When observation *a* is task-progress slot *b*, then the corresponding output neuron is 1 and 0 otherwise. Thus most entries will be 0 for the 2-ISR delay task: there will only be two 1 entries out of , and so 0.975 is the baseline accuracy (which we normalise to in ).

#### Mutual Information Ratio

To calculate the mutual information ratio (MIR), we first compute the mutual information between all [active neurons](https://www.sciencedirect.com/topics/engineering/active-neuron) (defined as neurons with average activity greater than of the average neural activity) and the ‘slot-sequence’ for each slot (slot-sequences are the predicted stream of observations in each slot; H). This gives a matrix of dimensions number of active neurons by number of slots. For each neuron we take its mutual [information vector](https://www.sciencedirect.com/topics/computer-science/information-vector) (of dimension number of slots), and calculate the maximum value of the vector divided by the sum of the vector (mutual information is always non-negative). This determines how specialised each neuron is for each slot. The MIR is then the average value over all active neurons. We do not include slot 1, i.e., the input slot, in this analysis.

#### Slot Algebra

To compute the slot algebra score, we generate sequences from four environments of identical structure, where the environments differ in their arrangement of observations in a special way. In particular the first environment has a random arrangement of observations, the second environment has a random arrangement of observations apart from one position (position *p*) where it has the same observation as the first environment. The third environment has the same arrangement of observations as the second environment apart from position *p* where it has a different, random, observation. The fourth environment is the same as the first environment, but in position *p* it has the same observation as the third environment. We then generate different random sequences for each of these environments. We choose a random position *i*, and record the neural representation for a random visit to position *i* on each of the four sequences. This gives us , , , and , where means the neural representation of environment *j* when at position *i*. The slot algebra score , where () is and where means square and sum all vector elements. We repeat this process 200 times for each model and average the individual scores to give the overall slot algebra score for that model.

We occasionally use an extra [regularisation](https://www.sciencedirect.com/topics/computer-science/regularization) term (KL) which asks the ‘predicted’ internal representation, , to the same as the ‘inferred’ representation, . In particular, we add an extra term to the loss that is , where is the [regularisation](https://www.sciencedirect.com/topics/engineering/regularization) [strength](https://www.sciencedirect.com/topics/materials-science/mechanical-strength) (see for its value).

To ensure that the poor slot algebra scores of the regular RNN are not simply due to the fact that we provide the velocity of the *upcoming transition* to the network at time-step *t* (i.e., the recurrent input , and the external input, , is and concatenated; reminder that is the velocity from that transition from ‘true underlying’ state to ), we additionally train networks where the velocity signal of the upcoming transition is only provided to the path integration step, i.e., ( is a learnable matrix), and the external input, , is just . This new network, in theory, could have no contamination of its internal representation with velocity, i.e., could be independent of velocity, and therefore have low slot algebra scores. Nevertheless, we find that these networks do not have low slot algebra scores (B), suggesting that the is dependent on the velocities signals taken to reach state .

##### PFC Analyses

We followed the exact analyses described in Xie et al. for and the exact analyses described in Panichello et al. for.

## Supplemental information

[What’s this?](https://service.elsevier.com/app/answers/detail/a_id/19286/supporthub/sciencedirect/ "What’s this? (Opens in new window)")

[Download: Download Acrobat PDF file (7MB)](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-mmc1.pdf "Download Acrobat PDF file (7MB)")

Document S1. Figures S1–S7 and Tables S1 and S2.

[Download: Download Acrobat PDF file (12MB)](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-mmc2.pdf "Download Acrobat PDF file (12MB)")

Document S2. Article plus supplemental information.

[^2]: Sequence memory tasks depend on underlying task structures. For example, in immediate serial recall (ISR; a series of observations must be recalled in order) the underlying structure is an ordinal line. Other sequences have different underlying structures, e.g., a sequence drawn from navigating two-dimensional (2D) space has embedded 2D structure. Internal representations that include this structural knowledge dramatically facilitate recall and prediction as different structures have different transition functions. For example, in a 2D [navigation task](https://www.sciencedirect.com/topics/computer-science/navigation-task), correct predictions rely on knowing you have returned to a previous position, which itself requires knowledge of the structure of 2D space (i.e., how recent velocities integrate). Exploiting knowledge of task structure facilitates recall and prediction in problems with a common structural constraint, even when each problem consists of sequences with different observations (therefore, one problem’s sequence cannot be memorized and used for another problem). Here, the underlying task structure must be meta-learned across problems (learning to learn; A left for example ISR task).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr1.jpg)

Download: Download high-res image (1015KB)

[^3]: Our decoding analyses demonstrate that WM models learn activity slots, as predicted by our theory. We focused on decoding analyses because learned activity slots will in general correspond to neural activity subspaces, not necessarily aligned to [single neuron](https://www.sciencedirect.com/topics/engineering/single-neuron) axes similar to our WM schematics (single neurons could exhibit mixed [selectivity](https://www.sciencedirect.com/topics/earth-and-planetary-sciences/selectivity) for multiple slots). To visualize learned activity slots, we leverage a recent technique that encourages single neurons to demix and code for single independent factors (e.g., slots). WM RNNs trained with this technique learn a demixed solution where single neurons participate only in a single slot (A) and quantitatively demix on all four tasks and for both RNN types (A).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr3.jpg)

Download: Download high-res image (463KB)

[^4]: In particular, Basu et al. and El-Gaby et al. trained rodents to repeatedly visit two and four (of nine) spatially located reward ports in sequence, respectively. The animals were trained on many problem realizations with random goal positions. We model these tasks (modulo the spatial component to be general) as 2-ISR and 4-ISR tasks but with delays between each observation (analogous to the delay traveling between spatial goals, A and 4E, left). Critically, although delays are random across different problem realizations, delays are the same on each loop of a problem. For example, possible 2-ISR delay sequences for different problem realizations are or where is the common delay observation (that also gets predicted), and possible 4-ISR delay sequences are or . We provide no explicit velocity signal—the model must compute progress velocity for each delay period from sparse inputs and remember it on returning to that same delay (after a loop of experience).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr4.jpg)

Download: Download high-res image (588KB)

[^5]: Our activity slot theory also accounts for PFC representations in standard sequence memory tasks where only a [constant velocity](https://www.sciencedirect.com/topics/computer-science/constant-velocity) is required. In particular, Xie et al. recorded PFC neurons in a 3-ISR task. Here, monkeys were shown three (of six) positions on a screen in sequence and were trained to, after a delay, [saccade](https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/saccadic-eye-movement) to the three positions in order (A). Similar to our ISR tasks, the monkeys were trained on many such sequences. Neural activity in the delay period decomposed into three [orthogonal subspaces](https://www.sciencedirect.com/topics/engineering/orthogonal-subspace), with the first/second/third saccade position simultaneously encoded in the first/second/third subspace (B and 5C). These three subspaces are activity slots (D). Indeed, WM networks learn the same subspace decomposition (E and 5F).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr5.jpg)

Download: Download high-res image (527KB)

[^6]: We have considered external and internally generated velocity signals; however, observations themselves can serve as velocity signals. Here, we show that sensory cues can be understood as velocity signals controlling PFC activity slots. In particular, Panichello and Buschman recorded PFC neurons in monkeys performing a cue-dependent memory task, where two colors are presented at the top and bottom of a screen. After a delay, a sensory cue dictates whether to report the top or bottom color after another delay (A). Importantly, each problem realization is a random combination of two colors and cue. Neural activity in the first delay period decomposed into two [orthogonal subspaces](https://www.sciencedirect.com/topics/computer-science/orthogonal-subspace), with the first/second subspace representing the top/bottom color (B, left). After the cue, the top (when correct) and bottom (when correct) colors are represented in parallel subspaces (B, right, and C). This is explained by activity slots (D): the initial two subspaces are activity slots for the top and bottom color, then the cue behave similar to a velocity signal to route the correct color to the readout slot (hence, why subspaces are parallel after the cue on correct trials; D, bottom). Indeed, WM networks learn the same subspace decomposition and dynamics (E–6G).

![](https://ars.els-cdn.com/content/image/1-s2.0-S0896627324007657-gr6.jpg)

Download: Download high-res image (564KB)

[^7]: <table><thead><tr><th>REAGENT or RESOURCE</th><th>SOURCE</th><th>IDENTIFIER</th></tr></thead><tbody><tr><th colspan="3"><strong>Software and algorithms</strong></th></tr><tr><td>Python 3.11</td><td>Python Software Foundation</td><td><a href="https://www.python.org/">https://www.python.org/</a></td></tr><tr><td>PyTorch 2.4</td><td>Paszke et al.</td><td><a href="https://pytorch.org/">https://pytorch.org/</a></td></tr><tr><td>Code for this paper</td><td><a href="https://doi.org/10.5281/zenodo.13909034">https://doi.org/10.5281/zenodo.13909034</a></td><td><a href="https://github.com/djcrw/EM-WM-slots">https://github.com/djcrw/EM-WM-slots</a></td></tr></tbody></table>