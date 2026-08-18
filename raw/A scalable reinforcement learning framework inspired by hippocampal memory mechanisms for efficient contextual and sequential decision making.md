---
title: "A scalable reinforcement learning framework inspired by hippocampal memory mechanisms for efficient contextual and sequential decision making"
source: "https://www.nature.com/articles/s41598-025-10586-x"
author:
  - "[[Hamed Poursiami]]"
  - "[[Ayana Moshruba]]"
  - "[[Keiland W. Cooper]]"
  - "[[Derek Gobin]]"
  - "[[Md Abdullah-Al Kaiser]]"
  - "[[Ankur Singh]]"
  - "[[Rouhan Noor]]"
  - "[[Babak Shahbaba]]"
  - "[[Akhilesh Jaiswal]]"
  - "[[Norbert J. Fortin]]"
  - "[[Maryam Parsa]]"
published: 2025-07-12
created: 2026-06-23
description: "Efficient decision-making in context-dependent, sequential tasks remains a fundamental challenge in reinforcement learning (RL). Inspired by the function of the brain’s hippocampal system, we introduce Hippocampal-Augmented Memory Integration (HAMI), a biologically inspired memory-based RL framework that leverages symbolic indexing, hierarchical memory refinement, and structured episodic retrieval to enhance both learning efficiency and adaptability. We also propose Hierarchical Contextual Sequences (HiCoS), a structured RL environment grounded in neuroscience studies on episodic and sequence memory and context-driven decision-making, which serves as a controlled testbed for evaluating biologically inspired memory-based decision-making systems. Our experimental results demonstrate that HAMI achieves high decision accuracy and improved sample efficiency while maintaining low memory utilization. HAMI’s architecture exhibits significantly lower inference latency than baseline memory-based methods, and its structured retrieval is well-suited for further hardware acceleration with non-volatile memory (NVM)-based content-addressable memory (CAM). By integrating biologically inspired memory mechanisms with structured symbolic representations, HAMI provides a scalable and efficient memory-based RL framework for tackling context-dependent sequential tasks."
tags:
  - "clippings"
---
## Abstract

Efficient decision-making in context-dependent, sequential tasks remains a fundamental challenge in reinforcement learning (RL). Inspired by the function of the brain’s hippocampal system, we introduce Hippocampal-Augmented Memory Integration (HAMI), a biologically inspired memory-based RL framework that leverages symbolic indexing, hierarchical memory refinement, and structured episodic retrieval to enhance both learning efficiency and adaptability. We also propose Hierarchical Contextual Sequences (HiCoS), a structured RL environment grounded in neuroscience studies on episodic and sequence memory and context-driven decision-making, which serves as a controlled testbed for evaluating biologically inspired memory-based decision-making systems. Our experimental results demonstrate that HAMI achieves high decision accuracy and improved sample efficiency while maintaining low memory utilization. HAMI’s architecture exhibits significantly lower inference latency than baseline memory-based methods, and its structured retrieval is well-suited for further hardware acceleration with non-volatile memory (NVM)-based content-addressable memory (CAM). By integrating biologically inspired memory mechanisms with structured symbolic representations, HAMI provides a scalable and efficient memory-based RL framework for tackling context-dependent sequential tasks.

## Introduction

Reinforcement learning (RL) has made significant strides in solving complex decision-making tasks, enabling advancements in robotics [^1] [^2], autonomous navigation [^3] [^4], strategic gameplay [^5] [^6], and beyond [^7] [^8]. However, many RL algorithms rely on extensive interactions with the environment, making them sample-inefficient and computationally expensive. To improve learning efficiency, researchers have explored memory-augmented RL methods inspired by biological intelligence [^9] [^10]. One promising direction in memory-augmented methods is episodic memory-based RL, which enables agents to directly recall high-value past experiences, thus bypassing the slow, incremental updates of conventional methods [^11] [^12] [^13]. These approaches draw inspiration from the neuroscience of episodic memory, specifically the role of the hippocampus in encoding and retrieving experiences to guide future behavior [^14] [^15] [^16]. Note that, in RL terminology, an experience generally refers to a record that includes at least a state, an action, and an associated reward or return. Depending on the specific method, it may also include additional information, such as previous or subsequent states. In neuroscience, an experience is generally synonymous with an episodic memory (or episode), that is a specific sequence of events in a given context. For clarity, we will hereafter only use the term experiences for the RL-related content and will instead use episodic memories or episodes for the neuroscience-related content.

Foundational work in this area, such as Model-Free Episodic Control [^17] and Neural Episodic Control [^18], retrieve past experiences based on similarity metrics, but lack structured retrieval mechanisms that can efficiently access relevant past experiences. Additionally, these methods store high-dimensional feature representations, making retrieval computationally expensive, particularly as memory size grows [^19]. Other approaches incorporate state abstraction [^20], reservoir sampling [^21], and two-memory architectures [^22] to enhance the robustness and generalization of experience memory in RL. More recent methods, such as Sequential Episodic Control [^23], integrate temporal dependencies to capture the ordering of experiences, further improving sample efficiency. Similarly, temporally extended successor feature episodic control leverages successor representations to improve policy transferability and sample efficiency [^24]. While these methods have shown promising results, their lack of structured experience representations leads to inefficient memory retrieval and redundant storage. Additionally, they struggle to effectively capture context-dependent sequential decision-making, which is a fundamental aspect of biological intelligence.

Neuroscience research has long established the hippocampus as a key structure for encoding, storing, and retrieving past events in a organized manner [^15] [^25] [^26] [^27] [^28]. Unlike passive memory storage, where information is retained without deeper contextual associations, the hippocampus supports event-in-context encoding [^15] [^29] [^30], which facilitates the ability of humans and other animals to subsequently recall relevant past events and use them for context-appropriate decision-making [^31] [^32] [^33]. It achieves this through mechanisms such as pattern separation, which minimizes interference between similar experiences [^34] [^35] [^36], and hierarchical memory organization, which supports efficient retrieval and adaptive memory consolidation [^26] [^37] [^38]. These processes allow for the rapid recall of relevant past events without overwhelming computational resources, a principle that has inspired memory-augmented RL. By incorporating biologically motivated memory structures, RL agents can leverage past experiences more effectively, improving sample efficiency and enabling more adaptive decision-making in complex context-dependent and sequential tasks.

Inspired by these findings, we propose Hippocampal-Augmented Memory Integration (HAMI), a biologically motivated memory-based learning framework that encodes structured symbolic representations of context-dependent experiences. Unlike traditional episodic control methods, HAMI introduces structured memory representations using a symbolic indexing mechanism, allowing for more efficient retrieval and storage of past experiences. This indexing system prevents redundant memory expansion by organizing experiences into discrete symbolic representations, enabling rapid retrieval without high computational costs. Additionally, HAMI incorporates hierarchical memory refinement, ensuring that only the most contextually relevant experiences are retained over time. These innovations make HAMI well-suited for tasks that require long-term memory integration and efficient adaptation to sequential dependencies. Inspired by the biological principles of the hippocampus and associated structures, HAMI mimics key mechanisms involved in sensory information processing, integration of event and contextual information, sequence coding, temporal integration, and action selection.

To evaluate HAMI’s effectiveness in context-dependent sequential decision-making, we introduce HiCoS (Hierarchical Contextual Sequences), a structured RL environment inspired by neuroscience studies on the role of the hippocampus in episodic and sequence memory.

This environment is designed to capture the core cognitive demands observed in neuroscience experiments, particularly those investigating how the hippocampus encodes and recalls sequential relationships among nonspatial events. Inspired by behavioral tasks where rodents learn to distinguish expected and unexpected event sequences [^39] [^40], HiCoS requires an agent to recognize whether an observed experience follows the correct sequential structure based on its context.

This structure enables rigorous testing of memory-based RL models under non-Markovian context-dependent conditions where decision-making depends not only on the sequential order of past experiences but also on the contextual cues that influence the progression of those sequences. By bridging insights from neuroscience and RL, HiCoS serves as a testbed for evaluating structured episodic memory representations in artificial agents.

Experimental results show that HAMI achieves superior decision accuracy while maintaining lower computational costs compared to baseline augmented memory-based and Q-learning methods in the context-dependent, sequential decision-making setting of HiCoS. Moreover, HAMI’s symbolic memory representations and structured retrieval process naturally align with hardware-efficient architectures, particularly content-addressable memory (CAM)-based designs [^41] [^42]. The parallelism of CAM enables efficient retrieval of symbolic indices, significantly reducing search latency. Additionally, integrating non-volatile memory (NVM)-based CAM [^41] [^43] [^44] enhances energy efficiency and scalability, making HAMI well-suited for low-power, high-performance decision-making in edge AI and neuromorphic systems.

The key contributions of this paper include:

- **Biologically Inspired Episodic Memory Framework**: We introduce HAMI, a biologically inspired RL framework that mimics hippocampal memory mechanisms for structured episodic memory representation and retrieval in context-dependent sequential decision-making tasks. HAMI improves decision accuracy by approximately $13\%$ over baseline deep Q-learning while achieving over $24\times$ faster inference compared to augmented episodic control.
- **Benchmarking with a Neuroscience-Grounded Environment**: We introduce HiCoS, a structured RL environment inspired by the role of the hippocampus in episodic and sequence memory. HiCoS serves as a testbed for evaluating biologically inspired memory mechanisms in artificial agents.
- **Biological Mapping for Neuromorphic Memory Systems**: We establish a direct computational mapping between hippocampal memory mechanisms and our biologically inspired HAMI framework. This mapping not only advances neuroscience-inspired RL but also opens pathways for neuromorphic hardware design, guiding the development of memory architectures grounded in hippocampal functionality.

## Preliminary

***Model Free Episodic Control (MFEC).*** MFEC is an RL mechanism that bypasses incremental value updates by directly storing and recalling high-value past experiences [^45]. Unlike standard RL approaches that refine policies through gradient-based optimization, MFEC enables rapid adaptation by retrieving stored state-action values and making decisions based on prior successful experiences. This retrieval-based mechanism significantly improves sample efficiency, especially in sparse reward environments [^18] [^46].

MFEC relies on a non-parametric memory structure, where past experiences are stored as tuples $(s_i, a_i, G_i)$, consisting of the observed state $s_i$, the executed action $a_i$, and the corresponding cumulative return $G_i$. The key update rule in MFEC framework [^17] ensures that each state-action pair retains the highest return observed so far. Specifically, if a state-action pair $(s_t, a_t)$ is encountered for the first time, its return is stored in memory. If it already exists, the stored value is updated to reflect the maximum return observed across past occurrences. This mechanism prioritizes high-reward experiences and enables the agent to rapidly recall effective strategies in environments with deterministic or semi-deterministic transitions.

During decision-making, the agent queries its memory to retrieve relevant experiences. If an exact match $(s, a)$ exists, the stored return is directly used for action selection. Otherwise, following the MFEC framework, the Q-value is estimated by averaging the returns of the $k$ nearest neighbors in memory:

 $\hat{Q}_{E C} \left(\right. s , a \left.\right) = \left{\right. \begin{matrix}\frac{1}{k} \sum_{i = 1}^{k} Q_{E C} \left(\right. s^{\left(\right. i \left.\right)} , a \left.\right) , & \text{if}\&\text{nbsp}; \left(\right. s , a \left.\right) \notin Q_{E C} \\ Q_{E C} \left(\right. s , a \left.\right) , & \text{otherwise}\end{matrix}$ 
$$
\begin{aligned} \hat{Q}_{EC}(s, a) = {\left\{ \begin{array}{ll} \frac{1}{k} \sum _{i=1}^{k} Q_{EC}(s^{(i)}, a), & \text {if } (s, a) \notin Q_{EC} \\ Q_{EC}(s, a), & \text {otherwise} \end{array}\right. } \end{aligned}
$$

(1)

where $s^{(i)}$ represents the $k$ nearest states to $s$. This nearest-neighbor averaging mechanism enables MFEC to generalize across similar states while retaining the ability to make decisions based on stored high-value experiences.

***Q-Learning.*** Q-learning is a value-based RL algorithm that enables agents to learn an optimal policy through trial-and-error interactions with the environment [^47]. It operates by estimating a Q-value function $Q(s, a)$, which represents the expected cumulative reward when taking action $a$ in state $s$ and following the optimal policy thereafter. The agent updates these Q-values iteratively based on received rewards and future value estimates.

At each timestep, the agent observes the current state $s_t$, selects an action $a_t$ using an exploration-exploitation strategy, receives a reward $r_t$, and transitions to the next state $s_{t+1}$. The Q-value update is performed using the temporal difference (TD) learning rule:

 $Q \left(\right. s_{t} , a_{t} \left.\right) \leftarrow Q \left(\right. s_{t} , a_{t} \left.\right) + \alpha \left[\right. r_{t} + \gamma \underset{a^{'}}{max} Q \left(\right. s_{t + 1} , a^{'} \left.\right) - Q \left(\right. s_{t} , a_{t} \left.\right) \left]\right.$ 
$$
\begin{aligned} Q(s_t, a_t) \leftarrow Q(s_t, a_t) + \alpha \left[ r_t + \gamma \max _{a'} Q(s_{t+1}, a') - Q(s_t, a_t) \right] \end{aligned}
$$

(2)

where $\alpha$ is the learning rate that controls the update magnitude, and $\gamma$ is the discount factor that determines the weight of future rewards.

To balance exploration and exploitation, Q-learning commonly uses an $\epsilon$ -greedy strategy, where the agent predominantly selects the action with the highest Q-value but occasionally takes a random action to explore alternatives. This stochastic exploration prevents premature convergence to suboptimal policies and ensures sufficient coverage of the state-action space for better long-term learning.

***Long Short-Term Memory (LSTM).*** Recurrent Neural Networks (RNNs) extend standard neural networks by maintaining a hidden state that retains information from previous time steps, enabling them to capture temporal dependencies in sequential data. However, standard RNNs struggle with long-term dependencies due to the vanishing gradient problem [^48], where information from distant past inputs gradually diminishes during training.

LSTM networks [^49] address this limitation by introducing two memory components: the cell state (long-term memory) and the hidden state (short-term memory). Their updates are controlled by a gating mechanism: the forget gate removes unnecessary past information from the cell state, the input gate updates it with new relevant data, and the output gate determines what information is used at the current step. In RL, LSTMs can be incorporated into Q-learning to enhance decision-making in non-Markovian environments, where the current state alone is insufficient for optimal action selection [^50].

***Pretext-Contrastive Learning.*** Pretext learning is a self-supervised approach where an auxiliary task is designed to help a model learn meaningful representations without explicit labels [^51]. Among various pretext learning techniques, contrastive learning has gained significant attention for its effectiveness in representation learning. Contrastive learning works by ensuring that similar samples are mapped closer in the embedding space, while dissimilar samples are pushed apart. This is achieved by defining an anchor sample and identifying positive examples (similar instances, often derived through data augmentation) and negative examples (dissimilar instances) [^52]. By optimizing the model to distinguish between these relationships, contrastive learning helps in extracting structured representations that capture the underlying patterns in data.

## HiCoS: Hippocampal context-dependent sequences environment

The HiCoS is a structured RL environment designed to simulate the role of the hippocampus in episodic memory and decision-making through context-dependent sequences. Implemented with compatibility to Gymnasium [^53], HiCoS provides a standardized interface, allowing seamless integration with existing RL frameworks. Inspired by neuroscience studies on hippocampal sequence learning [^40] [^54] [^55] [^56], HiCoS provides an RL setting that mirrors how biological agents process and recall event sequences based on context. By formalizing event-in-context relationships in a controlled environment, HiCoS serves as a bridge between neuroscience research and RL, facilitating the study of biologically inspired memory-based decision-making.

In HiCoS, the agent receives a sequence of observations derived from Colored-MNIST, a modified version of the MNIST dataset [^57] where each image of a handwritten digit is overlaid on a colored background representing the context. As illustrated in Figure [1](https://www.nature.com/articles/s41598-025-10586-x#Fig1) (a), each color context has a different rule for what should be considered a correct sequence: consecutive descending sequences (e.g., 7-6-5) in the red context, consecutive ascending sequences (e.g., 1-2-3) in the blue, even-numbered ascending sequences (e.g., 0-2-4) in the green, and odd-numbered ascending sequences (e.g., 1-3-5) in the yellow. The agent must determine, at each step, whether the observed digit adheres to the correct sequence based on its background color, without explicit knowledge of the underlying rule. This requires context-dependent reasoning, as the correct decision depends on both the digit and the sequence pattern associated with its background color.

**Fig. 1**

![Fig. 1](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41598-025-10586-x/MediaObjects/41598_2025_10586_Fig1_HTML.png?as=webp)

[Full size image](https://www.nature.com/articles/s41598-025-10586-x/figures/1)

Hippocampal Context-dependent Sequences (HiCoS) Environment inspired by neuroscience research on episodic memory function. In this environment, events are represented by digits and contexts by the background color. A sequence of event-in-context representations corresponds to an episodic memory (or episode). (**a**) Context-dependent sequence rules and examples. Ten digits are used (0-9) and the maximum sequence length is three digits. This leads to eight correct sequences in the red context (consecutive descending digits) and blue context (consecutive ascending digits), and three correct sequences for the green context (even ascending digits) and yellow context (odd ascending digits). (**b**) Agent-environment interaction example. An agent learns to distinguish “in sequence” (InSeq) and “out of sequence” (OutSeq) experiences through incremental rewards. The first correct prediction yields +0.5, the second +1, and the third +1.5, for a maximum of 3 points per episode. An incorrect prediction results in −1 and immediate episode termination. The correct action for the first step is set to InSeq, as there is no prior observation to establish a sequence.

During each episode (i.e., each sequence), the agent interacts with the environment by sequentially receiving observations and making ”in sequence” or ”out of sequence” decisions based on the given digit and its background color. An ”in sequence” decision indicates that the digit follows the expected sequential pattern defined by the context, while an ”out of sequence” decision signals a deviation from this pattern. Figure [1](https://www.nature.com/articles/s41598-025-10586-x#Fig1) (b) illustrates an example interaction. The agent receives incremental positive rewards for correctly identifying ”in sequence” digits, reinforcing sequence tracking over time. Conversely, an incorrect classification (either falsely accepting an ”out of sequence” digit or rejecting an ”in sequence” one) results in a negative reward and immediate episode termination.

Critically, HiCoS exhibits a non-Markovian property, as the agent’s current observation alone is insufficient to determine the optimal action, requiring memory retention and temporal reasoning. This characteristic makes HiCoS a valuable testbed for evaluating RL models that integrate memory mechanisms for structured decision-making. By aligning its structure with hippocampal experimental studies, HiCoS serves as a biologically motivated platform for investigating how agents can leverage memory for specific experiences for efficient learning in context-dependent environments. Furthermore, HiCoS maintains a balance between interpretability and complexity, offering structured high-dimensional visual inputs while maintaining computational efficiency. This balance allows for rigorous evaluation of hippocampal-inspired RL models without the constraints of excessive computational demands or overly simplistic tasks.

## Brain systems

After decades of research, the basic anatomical connectivity and functional principles of hippocampal and cortical brain systems have been sufficiently characterized [^27] [^34] [^58] [^59] [^60] [^61] [^62] [^63] such that this information can now be used to guide the development of brain-inspired hardware and software systems [^26] [^64]. Note that the goal of such efforts here is not to perfectly replicate the brain, but to capture key properties and functions of the brain to implement *in silico* that can lead to significant gains in performance. Here, we present a working model summarizing these functional principles (Figure [2](https://www.nature.com/articles/s41598-025-10586-x#Fig2)), which was derived from behavioral and neurophysiological research in humans, primates, and rodents, as well as computational modeling.

As we interact with our environment, the following flow of operations is expected across these brain systems [^14] [^26] [^65] [^66]. Information about the specific events and contexts we experience will first be coded by patterns of activity in sensory and association cortex. Within the cortex, individual sensory regions will process the features of an input signal, including the event and context information, and this processed information will be sent to the entorhinal cortex. Due to differences in their cortical inputs, the entorhinal cortex itself tends to divided into two functional subregions: a lateral portion that more strongly represents event information, and a medial portion that more strongly represents context information.

The entorhinal cortex will then send this information to all hippocampal subregions in parallel, where each subregion will perform distinct operations according to their unique anatomical structure and connectivity [^58] [^59]. For instance, the projection from entorhinal cortex to dentate gyrus (DG) shows rapid synaptic depression such that DG will primarily code for rapidly-changing information (i.e., the event) as opposed to slow-changing information (i.e., the context) [^61]. The large number of neurons in DG, and their extremely sparse activity, will also help reduce the overlap between similar inputs. This process, called pattern separation [^34] [^35], will orthogonalize the representations of the different events and this information will be sent to CA3. In CA3, this event information (from DG) will be integrated with the corresponding context information (from entorhinal cortex) to form conjunctive event-in-context representations. Importantly, CA3 also has a very distinct property in that the probability that its neurons will synapse onto themselves in the highest in the brain (5-10%) [^58] [^59] [^67]. This recurrent connectivity underlies CA3’s property of sequence coding [^30] [^61] [^68] [^69], where sequences of event-in-context representations can be encoded and subsequently replayed when cued.

The CA1 region is critical for the temporal integration of past, present, and future (predicted) event information [^40] [^68] [^70]. From entorhinal cortex, it will receive a representation of the present event as well as a decaying trace of past events (temporal context signal) [^71]. From CA3, it will receive a representation of the present event as well as of the next events in the sequence [^61]. CA1 can thus temporally integrate information from entorhinal cortex (i.e., past and present events) and from CA3 (i.e., present and future events) to represent past, present, and future event-in-context representations. This forms the basis of the event-based predictions provided by the hippocampal (episodic) memory system.

These event-based predictions from CA1, along with the corresponding knowledge-based predictions from association cortex, will be sent in parallel to the prefrontal cortex (PFC) [^72] [^73]. These representations will be used by the PFC to perform appropriate action selection and support flexible memory-guided decision-making. Finally, note that output information from the hippocampus will also serve to update semantic systems in the association cortex [^26] [^62] [^74] [^75]. Feedback projections from CA1 and entorhinal cortex project widely throughout the cortex and, over several repetitions, the event information can slowly be integrated into the semantic knowledge.

**Fig. 2**

![Fig. 2](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41598-025-10586-x/MediaObjects/41598_2025_10586_Fig2_HTML.png?as=webp)

[Full size image](https://www.nature.com/articles/s41598-025-10586-x/figures/2)

Overview of the Hippocampal-Augmented Memory Integration (HAMI) framework. HAMI’s design was inspired by computational principles underlying how information is processed throughout the primary brain systems involved in learning, memory, and decision-making. The agent interacts with its environment (e.g., HiCoS), receiving context-dependent sequential observations. These state observations are processed through pretext-learned event and context encoders to extract knowledge-based representations. Inspired by the CA3 region of the hippocampus, which associates item and context information, these representations are assigned compact symbolic indices via the symbolic indexing associative memory. Inspired by CA3 and CA1 mechanisms, the sequence buffer and temporal integrator combine the current symbolic observations with past experiences to construct an integrated state representation. This representation is used for memory retrieval, where the agent queries episodic memory to recall past experiences and determine an optimal action. Inspired by decision-making mechanisms in the prefrontal cortex (PFC), the action selection mechanism chooses between exploring new actions or retrieving past decisions. If the experience is novel, it undergoes memory formation, storing it in episodic memory along with its associated action and return. Otherwise, If an existing memory entry is found, a memory refinement mechanism determines whether to update, replace, or discard the stored experience.

## HAMI: Hippocampal-augmented memory integration

The Hippocampal-Augmented Memory Integration (HAMI) framework for sequential decision-making is inspired by the brain systems above and integrates multiple forms of brain-like computations to support learning in complex environments. This framework combines knowledge-based representation learning, symbolic indexing associative memory, sequence buffer and temporal integration, a dynamic lookup mechanism, and the retrieval, formation, and refinement of memories to create a cohesive model that allows an agent to efficiently make decisions in context-dependent, non-Markovian scenarios.

***Knowledge-Based Representation Learning.*** To enable the agent to effectively understand and differentiate elements of the environment, we introduce knowledge-based representation learning. This component involves pretext training to learn general representations for both events (digits) and contexts (colors). The goal of this pretext learning is to simplify subsequent learning tasks by providing informative embeddings that inherently capture the distinctions between different elements in the environment.

The motivation for using pretext learning stems from human cognitive processes. Humans often leverage generalized knowledge to simplify complex learning tasks. For example, understanding that colors are distinct and that digits belong to different categories allows a person to form relationships without learning each feature independently. Inspired by this, our approach employs contrastive learning to train two separate models—one for events and one for contexts—that cluster similar items together while separating dissimilar items. During contrastive training, pairs of images are used: positive pairs (e.g., two images of the same digit or color) are brought closer in the embedding space, while negative pairs (e.g., images of different colors or different digits) are pushed apart. The resulting knowledge-based representations form a foundation that accelerates the agent’s learning by providing general feature distinctions, making subsequent decision-making tasks more efficient and effective.

***Symbolic Indexing Associative Memory.*** The Symbolic Indexing Associative Memory is a mechanism designed to manage the representation of event-in-context pairings through a dynamic, expandable symbolic indexing mechanism. When a new state is observed, it passes through both the event network and the context network (trained separately during pretext learning), which output respective feature vectors for the event and context.

The symbolic indexing module uses cosine similarity to compare these new feature vectors against those already represented in the memory. If a new event or context is observed that is not sufficiently similar to any existing entry, the memory expands by adding a new symbolic index for the event or context. This mechanism effectively provides a hashing-like abstraction, reducing complex, high-dimensional event and context vectors into simplified symbolic indices, allowing the system to efficiently manage distinct experiences as the agent interacts with its environment.

By using this expandable symbolic approach, new states are dynamically incorporated without redundant storage, while maintaining compact representations. The generated symbolic indices are then used by both the sequence buffer and episodic memory components, allowing these memories to operate efficiently on these compact symbolic representations rather than full vector embeddings. The symbolic indexing associative memory thus plays a central role in providing an organized and scalable memory structure, enabling adaptive decision-making in complex environments.

***Sequence Buffer & Temporal Integrator.*** The Sequence Buffer serves as a short-term memory mechanism that maintains a sliding window of recent observations throughout an episode. This component is essential for handling the non-Markovian nature of the environment by providing access to past states when making decisions.

At each time-step, an incoming observation is processed through the Symbolic Indexing Associative Memory to generate its event-in-context symbolic representation. The Temporal Integrator then aggregates this newly symbolized observation with the sequence buffer’s stored representations, forming a structured experience representation that incorporates both the present and recent past. This structured experience is subsequently used for querying episodic memory, forming new memory entries, and updating the sequence buffer for the next time-step.

By integrating symbolic representations dynamically, the Sequence Buffer and Temporal Integrator allow the agent to reconstruct relevant historical information that is not directly observable in the current state, facilitating robust decision-making in non-Markovian environments.

***Memory Retrieval, Formation, and Refinement.*** HAMI’s episodic memory system retains structured sequences of event-in-context symbolic indices, along with their associated actions and cumulative returns. Unlike the sequence buffer, which resets after each episode, stored experiences persist across episodes, enabling the agent to refine its decision-making by leveraging past interactions.

During the **memory retrieval** stage, once an experience is structured in the Temporal Integrator, the agent queries the stored experiences to retrieve past decisions associated with each possible action. If an exact match is found, the action corresponding to the highest cumulative return is selected. When no exact match exists, the agent’s response depends on the phase of learning: during training, a random action is chosen to facilitate exploration, whereas during inference, the agent selects the closest stored experience and follows its associated action.

After an episode ends, the **memory formation** phase begins by computing the cumulative returns for all experiences encountered during the episode. Novel experiences that do not already exist in memory are added to the episodic memory buffer.If the buffer has reached its capacity, the oldest stored experience is removed to maintain memory constraints. For experiences that already exist in memory, the system initiates a **memory refinement** process by comparing the newly computed return with the previously stored value. If the new experience yields a higher return, it replaces the existing entry; otherwise, the stored memory remains unchanged, and the new experience is discarded.

Through this process of memory retrieval, formation, and refinement, HAMI ensures that only the most valuable and relevant experiences are retained, optimizing its decision-making efficiency in context-dependent, sequential environments.

***Shared computations between HAMI and Brain Systems*** HAMI’s operations share key computational principles with the corresponding operations in the brain. HAMI leverages knowledge-based representations to accumulate information about stimuli and contexts, updating its knowledge structure with new information across episodes. Based on the brain’s capacity to separate event information from contextual information, HAMI’s event encoder and context encoder disentangle information from the environment. Utilizing analogous computational mechanisms as CA3, HAMI’s Symbolic Indexing Associative Memory combines event and context information, and based on CA3’s recurrent connectivity and propensity to replay sequences of information, HAMI’s sequence buffer provides access to past content. Both HAMI and the hippocampus represent past, present, and future state information, providing mechanisms to integrate information across time. HAMI’s action selection mechanisms, which are guided by memory recall from stored memory content, are directly inspired by the brain’s prefrontal cortex. Lastly, HAMI’s memory formation and refinement mechanisms are directly inspired by neuroscience results of memory consolidation and updating.

## Experimental setup

The experimental evaluation investigates the proposed Hippocampal-Augmented Memory Integration (HAMI) framework’s ability to address context-dependent, sequential decision-making tasks. All experiments were conducted using Python, with implementations built in PyTorch and the Gymnasium framework, on a system equipped with an Apple M1 Pro processor and 16GB of RAM. The HiCoS environment serves as the primary testbed for evaluating HAMI against standard Q-learning and memory-based methods. This section outlines the architectural and implementation details for the evaluated models, along with a description of the evaluation metrics used to compare performance, computational efficiency, and memory requirements.

### Pretext learning module

The pretext learning module employs Siamese networks to generate generalized feature representations for events and contexts. Two separate models are trained (for colors and digits), each comprising two convolutional layers (with 32 and 64 filters, respectively), followed by max pooling layers and fully connected layers that map features to a 64-dimensional embedding space. Note that the convolutional layers’ architecture used for feature extraction is consistent across subsequent models to ensure comparability. The Siamese networks are trained using contrastive loss to minimize distances between similar pairs while maximizing them between dissimilar ones. We generate 10,000 synthetic pairs, equally balanced between positive and negative, and train over a brief span of 10 epochs.

The quality of the learned representations is evaluated using the normalized mutual information score (NMI), yielding 0.9997 for colors and 0.9682 for digits, demonstrating effective feature clustering.

### Q-learning approaches

***Augmented Deep Q-Network (Augmented-DQN).*** Typically, Deep Q-Networks (DQNs) are not well-suited for environments like HiCoS due to their non-Markovian nature. To address this, we incorporate a sequence buffer module that maintains a sliding window of recent observations, which are concatenated with the current state. This enriched input representation is then passed through convolutional layers, with an architecture similar to those used in the pretext learning module, followed by a fully connected layer of size 128, and an output layer producing Q-values for action selection.

***Deep Recurrent Q-Network (Deep-Recurrent-QN).*** This approach extends the DQN by integrating an LSTM layer to model sequential dependencies. Input states are processed through convolutional layers before being fed into an LSTM with 128 hidden units to model temporal information across states. The output from the LSTM is then passed through a fully connected layer to produce Q-values for decision-making.

*Knowledge-Based Model Enhancement:* In both the Augmented-DQN and Deep-Recurrent-QN models described above, pretext learning is applied to generate feature embeddings that are incorporated into the models. Feature vectors are generated using pretext-trained event and context networks for each state. These embeddings are then combined with the output from the convolutional layers of the model, and the resulting representation is processed by either fully connected layers or LSTM units, depending on the model. This integration enriches the feature space, improving the model’s ability to make more informed decisions.

### Memory-based approaches

***Augmented Episodic Control (Augmented-EC).*** The Augmented-EC method builds upon the traditional episodic control framework by addressing the non-Markovian nature of the HiCoS environment through the addition of sequence buffer. Sequence buffer maintains a sliding window of recent observations, which is used in conjunction with the current state to facilitate decision-making in environments that require awareness of recent history. Gaussian projection, as proposed in the original episodic control method, is applied to reduce the dimensionality of the input features to 64, optimizing storage and retrieval. Each memory entry contains a window of the recent states, the action taken, and cumulative return, with similarity for memory retrieval measured using Euclidean distance.

![Algorithm 1](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41598-025-10586-x/MediaObjects/41598_2025_10586_Figa_HTML.png)

Algorithm 1

***Knowledge-Enhanced Episodic Control (Knowledge-Enhanced-EC).*** This method extends Augmented-EC by utilizing pretext-trained embeddings for both events and contexts in place of Gaussian projection. Each memory entry contains a window of embeddings for events and contexts, actions taken, and cumulative future returns. Memory retrieval uses cosine similarity, with the average similarity across all event and context windows determining the final match.

***HAMI.*** The HAMI framework integrates symbolic indexing associative memory, sequence buffer, and episodic memory to facilitate decision-making in non-Markovian environments. The model utilizes high-dimensional embeddings (of size 64) for both events and contexts, which are used as keys to generate 6-bit symbolic representations. Events and contexts are indexed independently, allowing HAMI to effectively handle new combinations of previously encountered events and contexts. For instance, even if a particular event-in-context pairing has not been observed before, HAMI can still generate a representation if both the event and context components have been seen independently. This enhances the generalizability of the system by enabling it to adapt to novel situations based on prior knowledge.

Each memory entry in episodic memory contains a window of event-in-context symbols, the corresponding action taken, and the cumulative return. This organization enables efficient, symbol-based decision-making by leveraging high-value experiences stored in memory.

### Evaluation metrics

To comprehensively assess the performance of our models, we employed the following metrics, each chosen to evaluate specific aspects of learning efficiency, memory usage, and task performance.

***Action Accuracy.*** The proportion of correct actions taken by the agent during the testing phase. It is calculated as the ratio of correct actions to the total number of actions performed across all test episodes.

***Average Reward.*** The mean episode reward, averaged across all test episodes, reflecting the agent’s overall performance in maximizing rewards.

***Training Time.*** The total computational time required for each model to complete its training. This metric highlights computational efficiency and scalability.

***Inference Time.*** The average time, measured in milliseconds, required to make a single decision (i.e., execute an action) during the testing phase.

***Memory Utilization.*** Tracks the amount of memory required by each approach. This includes the memory needed to store model weights (for Q-networks and pretext networks) as well as memory entries (for episodic memory components and symbolic indexing associative memory representations). It is worth noting that replay buffers are employed in Q-learning methods to stabilize training by sampling past experiences, but the memory occupied by them is excluded from the reported utilization, as they are only used during training and are not part of the inference process.

## Results

The experimental results provide a detailed evaluation of HAMI, highlighting its performance, memory utilization, and computational efficiency in comparison to other models.

***Training Dynamics.*** The training trends, illustrated in Figure [3](https://www.nature.com/articles/s41598-025-10586-x#Fig3), demonstrate HAMI’s robustness and consistent convergence behavior, characterized by reduced fluctuations and rapid improvement. HAMI achieves an average episode reward of 2 within 2500 episodes, which is an indicator of its improved sample efficiency in learning an effective policy from fewer environmental interactions. The model continues to improve steadily and plateaus at a high-performance level around 5000 episodes, while Knowledge-Enhanced-EC’s performance stabilizes earlier at approximately 4000 episodes but at a lower reward plateau. This extended improvement is attributed to HAMI’s memory replacement module, which efficiently utilizes its episodic memory by retaining older experiences. Unlike Augmented-EC and Knowledge-Enhanced-EC, which exhaust their buffer capacity and overwrite older experiences to accommodate new ones, HAMI effectively manages its memory. In our experiments, HAMI utilized approximately 87% of its available buffer size after 20,000 training episodes, avoiding the need to discard past experiences.

**Fig. 3**

![Fig. 3](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41598-025-10586-x/MediaObjects/41598_2025_10586_Fig3_HTML.png?as=webp)

[Full size image](https://www.nature.com/articles/s41598-025-10586-x/figures/3)

HAMI demonstrates superior sample efficiency and performance during training. The plot shows the mean cumulative reward per episode in the HiCoS environment, smoothed with a 1000-episode moving average window. The possible reward per episode ranges from −0.5 to 3.0, with random actions yielding an expected reward of −0.1875. The results highlight HAMI’s effectiveness, as its learning curve rises more steeply and converges to a higher final reward plateau than all baseline models.

***Performance and Scalability.*** Table [1](https://www.nature.com/articles/s41598-025-10586-x#Tab1) supports these findings, showing that HAMI achieves the highest action accuracy and average reward during the testing phase, outperforming all other approaches. While Knowledge-Enhanced-EC demonstrates competitive performance, it incurs significantly higher training and inference times. In contrast, HAMI trains faster than all other approaches and achieves inference times comparable to Q-learning methods, maintaining a significant advantage over memory-based methods. Specifically, HAMI demonstrates a 24 $\times$ reduction in inference time compared to Knowledge-Enhanced-EC. However, its inference speed remains slightly behind deep Q-learning approaches due to the overhead introduced by episodic memory querying. This retrieval process remains a primary bottleneck for memory-based methods, as each query must search stored experiences to recall relevant past decisions. While HAMI significantly alleviates this issue by using symbolic indexing, which reduces the number of direct similarity computations, its structured retrieval mechanism is also well-suited for further acceleration with specialized hardware. Hardware-aligned solutions designed to enhance the efficiency of this retrieval phase are explored in the Discussion section.

**Table 1 Performance metrics comparison across all models. Bold values indicate the top-performing method for each metric.**

***Memory Utilization.*** HAMI’s memory usage further underscores its efficiency. While its memory utilization is dominated by the storage of pretext network weights, the symbolic indexing associative memory module and episodic memory together occupy only approximately 32 KB. This streamlined memory management highlights HAMI’s capacity to achieve superior performance without imposing significant memory overhead.

***Sensitivity to Similarity Thresholds.*** Figure [4](https://www.nature.com/articles/s41598-025-10586-x#Fig4) explores HAMI’s sensitivity to event and context similarity thresholds, which play a crucial role in determining the granularity of symbolic representations. Lower thresholds lead to fewer symbols by grouping more observations together, which can hinder the model’s ability to distinguish between distinct states. Conversely, higher thresholds increase the number of unique symbols, enhancing specificity. However, an excessive number of symbols disrupts the replacement strategy and exhausts the episodic buffer prematurely, leading to longer training times and reduced performance. Despite these trade-offs, the data show a broad range of threshold configurations supporting high performance. Across the entire tested hyperparameter space, 43.54% of combinations yield an accuracy of 90% or higher, with 27.21% achieving over 95%. Furthermore, the overall distribution of performance scores is negatively skewed (−0.495), reflecting a concentration of outcomes toward the higher end of the accuracy scale. A region of the threshold space yielding consistently high accuracy can be identified for context thresholds between 0.20 and 0.99 and event thresholds between 0.45 and 0.95, which yields a mean accuracy of 95.03% with a low standard deviation of 2.34%.

**Fig. 4**

![Fig. 4](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41598-025-10586-x/MediaObjects/41598_2025_10586_Fig4_HTML.png?as=webp)

[Full size image](https://www.nature.com/articles/s41598-025-10586-x/figures/4)

HAMI maintains high performance across a broad range of hyperparameter settings. The heatmap displays HAMI’s final action accuracy (in percent) as a function of varying event (x-axis) and context (y-axis) similarity thresholds. Lighter shades indicate higher accuracy. The numbers along the top and right axes show the number of unique symbols generated for events and contexts at each threshold, illustrating the trade-off between representational granularity and generalization. The wide operational window of high performance reduces the need for fragile hyperparameter tuning.

## Discussion

Our experimental findings demonstrate that the HAMI framework successfully addresses several key challenges in memory-based reinforcement learning for context-dependent, sequential tasks. By leveraging biologically-inspired principles such as structured symbolic indexing and hierarchical memory refinement, HAMI achieves high decision accuracy and improved sample efficiency. Notably, it accomplishes this while mitigating the inference latency and memory storage issues that often hinder memory-based methods. The following sections will explore the broader implications of this approach, from its alignment with hardware-efficient systems to directions for future research.

### Hardware feasibility for memory retrieval in HAMI

HAMI’s structured symbolic memory representation enhances the efficiency of episodic memory retrieval compared to conventional high-dimensional vector similarity searches. However, as episodic memory scales, retrieval latency remains the primary computational bottleneck during inference. Efficient retrieval of stored symbolic indices is critical for supporting real-time action selection, particularly in large-scale decision-making applications. Traditional random-access memory (RAM) is inherently constrained by its sequential search approach, making it unsuitable for applications requiring real-time pattern recognition, associative memory retrieval, and extensive data matching. Alternatively, content-addressable memory (CAM) offers an efficient solution by enabling massively parallel search operations, allowing for direct comparisons between an input query and all stored data within a single clock cycle. However, conventional volatile CAM designs suffer from high power consumption and scalability challenges, underscoring the necessity for non-volatile memory (NVM)-based CAM architectures [^41] [^42]. By integrating emerging NVM technologies like Resistive RAM (RRAM) [^43], Magnetic RAM (MRAM) [^76], Phase-Change Memory (PCM) [^44] [^77], and Ferroelectric Field-Effect Transistors (FeFETs) [^78], the efficiency of CAM systems can be significantly enhanced, leading to improvements in energy efficiency, density, and overall performance.

**Fig. 5**

![Fig. 5](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41598-025-10586-x/MediaObjects/41598_2025_10586_Fig5_HTML.png?as=webp)

[Full size image](https://www.nature.com/articles/s41598-025-10586-x/figures/5)

An NVM-based Content-Addressable Memory (CAM) cell using a 2-Transistor 2-Resistor (2T2R) structure, where access transistors connect to search lines (SL/SLB) and resistive NVM elements (R1, R2) to store data. A zoomed-in view shows NVM candidates (RRAM, MRAM, PCM, FeFET) programmed to logic ‘0’/‘1’ via high (RH) or low (RL) resistance. The truth table illustrates match conditions that keep the Match Line (ML) high, while mismatches discharge it for associative search.

Fig. [5](https://www.nature.com/articles/s41598-025-10586-x#Fig5) presents an NVM-based CAM circuit featuring a 2-transistors-2-resistors (2T2R) architecture [^41] [^44]. This configuration consists of two transistors (M1, M2) and two NVM elements (R1, R2) that encode information into their resistance states. In this architecture, a binary ‘0’ is indicated by R1 in a high resistance state (${\textrm{R}_{\text {H}}}$) and R2 in a low resistance state (${\textrm{R}_{\text {L}}}$), while a binary ‘1’ is represented by R1 in a low resistance state (${\textrm{R}_{\text {L}}}$) and R2 in a high resistance state (${\textrm{R}_{\text {H}}}$). The 2T2R design can accommodate various emerging memory technologies, facilitating efficient and dense data encoding. For example, RRAM uses voltage pulses to control conductive filaments, switching between low and high resistance states, while PCM utilizes heating-induced phase transitions to alternate between crystalline (low resistance) and amorphous (high resistance) states. Furthermore, MRAM achieves low and high resistance states by controlling the magnetization direction of the free layer relative to the pinned layer, while FeFET-based devices utilize ferroelectric polarization to adjust transistor threshold voltages, thereby influencing conductivity.

The search operation in the NVM-based CAM consists of two phases: precharge and evaluation. Initially, the match line (ML) is precharged to VDD using a prechrage circuit. During the evaluation phase, the input query is applied through the search lines (SL, SLB), while the bitline (BL) is grounded. When the search data matches the stored data, the ML encounters a high-resistance path to the BL (for data = 0 and input = 0, the ML sees ${\textrm{R}_{\text {H}}}$ resistance through M1; for data = 1 and input = 1, the ML sees ${\textrm{R}_{\text {H}}}$ through M2), keeping the ML close to VDD and indicating a match. Conversely, when the search data and stored data do not match (for data = 0 and input = 1, the ML sees ${\textrm{R}_{\text {L}}}$ resistance through M2; for data = 1 and input = 0, the ML sees ${\textrm{R}_{\text {L}}}$ through M1), the ML experiences a low-resistance path to the BL, resulting in a faster discharge of the ML and signifying a mismatch. By inputting the event-in-context symbolic indices through the search lines (SL and SLB), the entire NVM-based CAM-augmented episodic memory can be queried in a single clock cycle, enhancing energy efficiency compared to traditional search methods and can significantly improve the inference time of the HAMI framework.

### Future directions

HAMI’s symbolic memory architecture and sequence-based retrieval mechanisms are inherently well-suited to a broad class of reinforcement learning tasks, particularly those involving temporal dependencies, context shifts, and partial observability. While the current study focused on the structured HiCoS environment to provide controlled neuroscientific grounding, the framework is designed to naturally extend to more dynamic domains. Future work will explore HAMI’s applicability in environments with evolving context structures, varying reward distributions, and more complex temporal dynamics, further quantifying its adaptability and generalization capacity. Additionally, enhancing the retrieval process with graded similarity mechanisms [^79] represents a promising avenue to expand HAMI’s flexibility in settings with noisy representations. Finally, integrating the framework into neuromorphic hardware platforms will advance its potential for real-time, low-power, memory-driven decision-making across a wide range of practical applications.

## Conclusion

In this work, we introduced HAMI, a biologically inspired reinforcement learning framework designed to enhance context-dependent sequential learning. By integrating structured symbolic memory representations and retrieval-based decision-making, HAMI enables agents to efficiently retain, retrieve, and refine information from past experiences. To evaluate its effectiveness, we developed HiCoS, a neuroscience-grounded environment that reflects the challenges of sequence learning and contextual dependencies. Our experimental results demonstrate that HAMI outperforms conventional reinforcement learning baselines in terms of decision accuracy, sample efficiency, and computational cost. Beyond these algorithmic advancements, HAMI’s structured memory organization aligns well with neuromorphic computing paradigms, including CAM and NVM systems, offering a promising pathway toward efficient, hardware-compatible AI capable of real-time, memory-driven decision-making.

## Data availability

The data and code supporting the findings of this study are available from the corresponding author upon reasonable request.

## References

## Acknowledgements

The research was funded by National Science Foundation through awards CCF2319619, CCF2319618, and CCF2319617.

## Ethics declarations

### Competing interests

The authors declare no competing interests.

## Additional information

### Publisher’s note

Springer Nature remains neutral with regard to jurisdictional claims in published maps and institutional affiliations.

## Rights and permissions

**Open Access** This article is licensed under a Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License, which permits any non-commercial use, sharing, distribution and reproduction in any medium or format, as long as you give appropriate credit to the original author(s) and the source, provide a link to the Creative Commons licence, and indicate if you modified the licensed material. You do not have permission under this licence to share adapted material derived from this article or parts of it. The images or other third party material in this article are included in the article’s Creative Commons licence, unless indicated otherwise in a credit line to the material. If material is not included in the article’s Creative Commons licence and your intended use is not permitted by statutory regulation or exceeds the permitted use, you will need to obtain permission directly from the copyright holder. To view a copy of this licence, visit [http://creativecommons.org/licenses/by-nc-nd/4.0/](http://creativecommons.org/licenses/by-nc-nd/4.0/).

[^1]: Levine, S., Finn, C., Darrell, T. & Abbeel, P. End-to-end training of deep visuomotor policies. *J. Mach. Learn. Res.***17**, 1–40 (2016).

[MathSciNet](http://www.ams.org/mathscinet-getitem?mr=3491133) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=End-to-end%20training%20of%20deep%20visuomotor%20policies&journal=J.%20Mach.%20Learn.%20Res.&volume=17&pages=1-40&publication_year=2016&author=Levine%2CS&author=Finn%2CC&author=Darrell%2CT&author=Abbeel%2CP)

[^2]: Kalashnikov, D. *et al.* Scalable deep reinforcement learning for vision-based robotic manipulation. In *Conference on robot learning*, 651–673 (PMLR, 2018).

[^3]: Zoph, B., Vasudevan, V., Shlens, J. & Le, QV. Learning transferable architectures for scalable image recognition. In *Proceedings of the IEEE conference on computer vision and pattern recognition*, 8697–8710 (2018).

[^4]: Faust, A. *et al.* Prm-rl: Long-range robotic navigation tasks by combining reinforcement learning and sampling-based planning. In *2018 IEEE international conference on robotics and automation (ICRA)*, 5113–5120 (IEEE, 2018).

[^5]: Silver, D. et al. Mastering the game of go with deep neural networks and tree search. *Nature* **529**, 484–489 (2016).

[Article](https://doi.org/10.1038%2Fnature16961) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2016Natur.529..484S) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28Xhs12is7w%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26819042) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mastering%20the%20game%20of%20go%20with%20deep%20neural%20networks%20and%20tree%20search&journal=Nature&doi=10.1038%2Fnature16961&volume=529&pages=484-489&publication_year=2016&author=Silver%2CD)

[^6]: Vinyals, O. et al. Grandmaster level in Starcraft II using multi-agent reinforcement learning. *Nature* **575**, 350–354 (2019).

[Article](https://doi.org/10.1038%2Fs41586-019-1724-z) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2019Natur.575..350V) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXitV2hsbzF) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31666705) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Grandmaster%20level%20in%20Starcraft%20II%20using%20multi-agent%20reinforcement%20learning&journal=Nature&doi=10.1038%2Fs41586-019-1724-z&volume=575&pages=350-354&publication_year=2019&author=Vinyals%2CO)

[^7]: Fasihi, MR. & Mark, BL. Traffic priority-aware 5g nr-u/wi-fi coexistence with deep reinforcement learning. In *2024 IEEE 100th Vehicular Technology Conference (VTC2024-Fall)*, 1–6, [https://doi.org/10.1109/VTC2024-Fall63153.2024.10757867](https://doi.org/10.1109/VTC2024-Fall63153.2024.10757867) (2024).

[^8]: Soleiman, F., Boroujeny, MK. & Zeng, K. Reinforcement learning-based beam hopping for anti-jamming mmwave communication. In *2025 59th Annual Conference on Information Sciences and Systems (CISS)*, 1–6 (IEEE, 2025).

[^9]: Ramani, D. A short survey on memory based reinforcement learning. arXiv preprint [arXiv:1904.06736](http://arxiv.org/abs/1904.06736) (2019).

[^10]: Bakker, B. Reinforcement learning with long short-term memory. *Advances in neural information processing systems* **14** (2001).

[^11]: Hansen, S., Pritzel, A., Sprechmann, P., Barreto, A. & Blundell, C. Fast deep reinforcement learning using online adjustments from the past. *Advances in Neural Information Processing Systems* **31** (2018).

[^12]: Fortunato, M. *et al.* Generalization of reinforcement learners with working and episodic memory. *Advances in neural information processing systems* **32** (2019).

[^13]: Lengyel, M. & Dayan, P. Hippocampal contributions to control: the third way. *Advances in neural information processing systems* **20** (2007).

[^14]: Eichenbaum, H., Yonelinas, A. & Ranganath, C. The medial temporal lobe and recognition memory. *Annu. Rev. Neurosci.***30**, 123–152. [https://doi.org/10.1146/annurev.neuro.30.051606.094328](https://doi.org/10.1146/annurev.neuro.30.051606.094328) (2007).

[Article](https://doi.org/10.1146%2Fannurev.neuro.30.051606.094328) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2sXptFKntbk%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17417939) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2064941) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20medial%20temporal%20lobe%20and%20recognition%20memory&journal=Annu.%20Rev.%20Neurosci.&doi=10.1146%2Fannurev.neuro.30.051606.094328&volume=30&pages=123-152&publication_year=2007&author=Eichenbaum%2CH&author=Yonelinas%2CA&author=Ranganath%2CC)

[^15]: Allen, T. A. & Fortin, N. J. The evolution of episodic memory. *Proc. Natl. Acad. Sci. U. S. A.***110**, 10379–10386. [https://doi.org/10.1073/pnas.1301199110](https://doi.org/10.1073/pnas.1301199110) (2013).

[Article](https://doi.org/10.1073%2Fpnas.1301199110) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2013PNAS..11010379A) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23754432) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3690604) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20evolution%20of%20episodic%20memory&journal=Proc.%20Natl.%20Acad.%20Sci.%20U.%20S.%20A.&doi=10.1073%2Fpnas.1301199110&volume=110&pages=10379-10386&publication_year=2013&author=Allen%2CTA&author=Fortin%2CNJ)

[^16]: Redish, A. D. Vicarious trial and error. *Nat. Rev. Neurosci.***17**, 147–159. [https://doi.org/10.1038/nrn.2015.30](https://doi.org/10.1038/nrn.2015.30) (2016).

[Article](https://doi.org/10.1038%2Fnrn.2015.30) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28XivVCisLk%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26891625) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5029271) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Vicarious%20trial%20and%20error&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn.2015.30&volume=17&pages=147-159&publication_year=2016&author=Redish%2CAD)

[^17]: Blundell, C. *et al.* Model-free episodic control. arXiv preprint [arXiv:1606.04460](http://arxiv.org/abs/1606.04460) (2016).

[^18]: Pritzel, A. *et al.* Neural episodic control. In *International conference on machine learning*, 2827–2836 (PMLR, 2017).

[^19]: Capone, C. & Paolucci, P. S. Towards biologically plausible model-based reinforcement learning in recurrent spiking networks by dreaming new experiences. *Sci. Rep.***14**, 14656 (2024).

[Article](https://doi.org/10.1038%2Fs41598-024-65631-y) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB2cXhsVemsrjI) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=38918553) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC11199658) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Towards%20biologically%20plausible%20model-based%20reinforcement%20learning%20in%20recurrent%20spiking%20networks%20by%20dreaming%20new%20experiences&journal=Sci.%20Rep.&doi=10.1038%2Fs41598-024-65631-y&volume=14&publication_year=2024&author=Capone%2CC&author=Paolucci%2CPS)

[^20]: Abel, D., Arumugam, D., Lehnert, L. & Littman, M. State abstractions for lifelong reinforcement learning. In *International Conference on Machine Learning*, 10–19 (PMLR, 2018).

[^21]: Young, KJ., Sutton, RS. & Yang, S. Integrating episodic memory into a reinforcement learning agent using reservoir sampling. arXiv preprint [arXiv:1806.00540](http://arxiv.org/abs/1806.00540) (2018).

[^22]: Yang, Z., Moerland, TM., Preuss, M. & Plaat, A. Two-memory reinforcement learning. In *2023 IEEE Conference on Games (CoG)*, 1–9 (IEEE, 2023).

[^23]: Freire, I. T., Amil, A. F. & Verschure, P. F. Sequential memory improves sample and memory efficiency in episodic control. *Nat. Mach. Intell.* (1), [https://doi.org/10.1038/s42256-024-00950-3](https://doi.org/10.1038/s42256-024-00950-3) (2024).

[^24]: Zhu, X. Temporally extended successor feature neural episodic control. *Sci. Rep.***14**, 15103 (2024).

[Article](https://doi.org/10.1038%2Fs41598-024-65687-w) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB2cXhsFSmt7jP) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=38956201) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC11219751) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Temporally%20extended%20successor%20feature%20neural%20episodic%20control&journal=Sci.%20Rep.&doi=10.1038%2Fs41598-024-65687-w&volume=14&publication_year=2024&author=Zhu%2CX)

[^25]: Eichenbaum, H. Memory: Organization and control. *Annu. Rev. Psychol.***68**, 19–45. [https://doi.org/10.1146/annurev-psych-010416-044131](https://doi.org/10.1146/annurev-psych-010416-044131) (2017).

[Article](https://doi.org/10.1146%2Fannurev-psych-010416-044131) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27687117) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Memory%3A%20Organization%20and%20control&journal=Annu.%20Rev.%20Psychol.&doi=10.1146%2Fannurev-psych-010416-044131&volume=68&pages=19-45&publication_year=2017&author=Eichenbaum%2CH)

[^26]: Kumaran, D., Hassabis, D. & McClelland, J. L. What learning systems do intelligent agents need? Complementary learning systems theory updated. *Trends Cogn. Sci.***20**, 512–534. [https://doi.org/10.1016/j.tics.2016.05.004](https://doi.org/10.1016/j.tics.2016.05.004) (2016).

[Article](https://doi.org/10.1016%2Fj.tics.2016.05.004) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27315762) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=What%20learning%20systems%20do%20intelligent%20agents%20need%3F%20Complementary%20learning%20systems%20theory%20updated&journal=Trends%20Cogn.%20Sci.&doi=10.1016%2Fj.tics.2016.05.004&volume=20&pages=512-534&publication_year=2016&author=Kumaran%2CD&author=Hassabis%2CD&author=McClelland%2CJL)

[^27]: Rolls, E. T. & Treves, A. A theory of hippocampal function: New developments. *Prog. Neurobiol.***238**, 102636. [https://doi.org/10.1016/j.pneurobio.2024.102636](https://doi.org/10.1016/j.pneurobio.2024.102636) (2024).

[Article](https://doi.org/10.1016%2Fj.pneurobio.2024.102636) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=38834132) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20theory%20of%20hippocampal%20function%3A%20New%20developments&journal=Prog.%20Neurobiol.&doi=10.1016%2Fj.pneurobio.2024.102636&volume=238&publication_year=2024&author=Rolls%2CET&author=Treves%2CA)

[^28]: Clewett, D., DuBrow, S. & Davachi, L. Transcending time in the brain: How event memories are constructed from experience. *Hippocampus* **29**, 162–183. [https://doi.org/10.1002/hipo.23074](https://doi.org/10.1002/hipo.23074) (2019).

[Article](https://doi.org/10.1002%2Fhipo.23074) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30734391) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6629464) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Transcending%20time%20in%20the%20brain%3A%20How%20event%20memories%20are%20constructed%20from%20experience&journal=Hippocampus&doi=10.1002%2Fhipo.23074&volume=29&pages=162-183&publication_year=2019&author=Clewett%2CD&author=DuBrow%2CS&author=Davachi%2CL)

[^29]: Lisman, JE. Relating Hippocampal Circuitry to Function: Recall of Memory Sequences by Reciprocal Dentate–CA3 Interactions. *Neuron* **22**, 233–242, [https://doi.org/10.1016/S0896-6273(00)81085-5](https://doi.org/10.1016/S0896-6273\(00\)81085-5) (1999). 10069330.

[^30]: Levy, W. B. A sequence predicting CA3 is a flexible associator that learns and uses context to solve hippocampal-like tasks. *Hippocampus* **6**, 579–590 (1996).

[Article](https://doi.org/10.1002%2F%28SICI%291098-1063%281996%296%3A6%3C579%3A%3AAID-HIPO3%3E3.0.CO%3B2-C) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK2s7osleqtg%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=9034847) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20sequence%20predicting%20CA3%20is%20a%20flexible%20associator%20that%20learns%20and%20uses%20context%20to%20solve%20hippocampal-like%20tasks&journal=Hippocampus&doi=10.1002%2F%28SICI%291098-1063%281996%296%3A6%3C579%3A%3AAID-HIPO3%3E3.0.CO%3B2-C&volume=6&pages=579-590&publication_year=1996&author=Levy%2CWB)

[^31]: Howard, M. W., Fotedar, M. S., Datey, A. V. & Hasselmo, M. E. The temporal context model in spatial navigation and relational learning: Toward a common explanation of medial temporal lobe function across domains. *Psychol. Rev.***112**, 75–116. [https://doi.org/10.1037/0033-295X.112.1.75](https://doi.org/10.1037/0033-295X.112.1.75) (2005).

[Article](https://doi.org/10.1037%2F0033-295X.112.1.75) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=15631589) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC1421376) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20temporal%20context%20model%20in%20spatial%20navigation%20and%20relational%20learning%3A%20Toward%20a%20common%20explanation%20of%20medial%20temporal%20lobe%20function%20across%20domains&journal=Psychol.%20Rev.&doi=10.1037%2F0033-295X.112.1.75&volume=112&pages=75-116&publication_year=2005&author=Howard%2CMW&author=Fotedar%2CMS&author=Datey%2CAV&author=Hasselmo%2CME)

[^32]: Johnson, A. & Redish, A. D. Neural ensembles in CA3 transiently encode paths forward of the animal at a decision point. *J. Neurosci.***27**, 12176–12189. [https://doi.org/10.1523/JNEUROSCI.3761-07.2007](https://doi.org/10.1523/JNEUROSCI.3761-07.2007) (2007).

[Article](https://doi.org/10.1523%2FJNEUROSCI.3761-07.2007) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2sXhtlartLjJ) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17989284) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6673267) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20ensembles%20in%20CA3%20transiently%20encode%20paths%20forward%20of%20the%20animal%20at%20a%20decision%20point&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.3761-07.2007&volume=27&pages=12176-12189&publication_year=2007&author=Johnson%2CA&author=Redish%2CAD)

[^33]: Shin, JD., Tang, W. & Jadhav, SP. Dynamics of Awake Hippocampal-Prefrontal Replay for Spatial Learning and Memory-Guided Decision Making. *Neuron* **104**, 1110–1125.e7, [https://doi.org/10.1016/j.neuron.2019.09.012](https://doi.org/10.1016/j.neuron.2019.09.012) (2019). 31677957.

[^34]: Marr, D. & Brindley, GS. Simple memory: a theory for archicortex. *Philosophical Transactions of the Royal Society of London. B, Biological Sciences* **262**, 23–81, [https://doi.org/10.1098/rstb.1971.0078](https://doi.org/10.1098/rstb.1971.0078) (1997). Publisher: Royal Society.

[^35]: Yassa, M. A. & Stark, C. E. L. Pattern separation in the hippocampus. *Trends Neurosci.***34**, 515–525. [https://doi.org/10.1016/j.tins.2011.06.006](https://doi.org/10.1016/j.tins.2011.06.006) (2011).

[Article](https://doi.org/10.1016%2Fj.tins.2011.06.006) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3MXht1antb%2FF) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21788086) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3183227) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Pattern%20separation%20in%20the%20hippocampus&journal=Trends%20Neurosci.&doi=10.1016%2Fj.tins.2011.06.006&volume=34&pages=515-525&publication_year=2011&author=Yassa%2CMA&author=Stark%2CCEL)

[^36]: Borzello, M. et al. Assessments of dentate gyrus function: Discoveries and debates. *Nat. Rev. Neurosci.***24**, 502–517. [https://doi.org/10.1038/s41583-023-00710-z](https://doi.org/10.1038/s41583-023-00710-z) (2023).

[Article](https://doi.org/10.1038%2Fs41583-023-00710-z) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3sXht1ejsb%2FF) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=37316588) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC10529488) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Assessments%20of%20dentate%20gyrus%20function%3A%20Discoveries%20and%20debates&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fs41583-023-00710-z&volume=24&pages=502-517&publication_year=2023&author=Borzello%2CM)

[^37]: McKenzie, S. et al. Representation of memories in the cortical–hippocampal system: Results from the application of population similarity analyses. *Neurobiol. Learn. Mem.***134**, 178–191. [https://doi.org/10.1016/j.nlm.2015.12.008](https://doi.org/10.1016/j.nlm.2015.12.008) (2016).

[Article](https://doi.org/10.1016%2Fj.nlm.2015.12.008) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26748022) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Representation%20of%20memories%20in%20the%20cortical%E2%80%93hippocampal%20system%3A%20Results%20from%20the%20application%20of%20population%20similarity%20analyses&journal=Neurobiol.%20Learn.%20Mem.&doi=10.1016%2Fj.nlm.2015.12.008&volume=134&pages=178-191&publication_year=2016&author=McKenzie%2CS)

[^38]: Santoro, A., Frankland, P. W. & Richards, B. A. Memory transformation enhances reinforcement learning in dynamic environments. *J. Neurosci.***36**, 12228–12242. [https://doi.org/10.1523/JNEUROSCI.0763-16.2016](https://doi.org/10.1523/JNEUROSCI.0763-16.2016) (2016).

[Article](https://doi.org/10.1523%2FJNEUROSCI.0763-16.2016) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXhsVSktrjM) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27903731) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6601977) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Memory%20transformation%20enhances%20reinforcement%20learning%20in%20dynamic%20environments&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.0763-16.2016&volume=36&pages=12228-12242&publication_year=2016&author=Santoro%2CA&author=Frankland%2CPW&author=Richards%2CBA)

[^39]: Allen, T. A., Morris, A. M., Mattfeld, A. T., Stark, C. E. L. & Fortin, N. J. A sequence of events model of episodic memory shows parallels in rats and humans. *Hippocampus* **24**, 1178–1188. [https://doi.org/10.1002/hipo.22301](https://doi.org/10.1002/hipo.22301) (2014).

[Article](https://doi.org/10.1002%2Fhipo.22301) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24802767) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8555854) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20sequence%20of%20events%20model%20of%20episodic%20memory%20shows%20parallels%20in%20rats%20and%20humans&journal=Hippocampus&doi=10.1002%2Fhipo.22301&volume=24&pages=1178-1188&publication_year=2014&author=Allen%2CTA&author=Morris%2CAM&author=Mattfeld%2CAT&author=Stark%2CCEL&author=Fortin%2CNJ)

[^40]: Shahbaba, B. et al. Hippocampal ensembles represent sequential relationships among an extended sequence of nonspatial events. *Nat. Commun.***13**, 787 (2022).

[Article](https://doi.org/10.1038%2Fs41467-022-28057-6) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2022NatCo..13..787S) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB38XjtFSlurw%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=35136052) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8825855) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Hippocampal%20ensembles%20represent%20sequential%20relationships%20among%20an%20extended%20sequence%20of%20nonspatial%20events&journal=Nat.%20Commun.&doi=10.1038%2Fs41467-022-28057-6&volume=13&publication_year=2022&author=Shahbaba%2CB)

[^41]: Molom-Ochir, T., Taylor, B., Li, H. & Chen, Y. *Advancements in content-addressable memory (cam) circuits: State-of-the-art, applications, and future directions in the ai domain* (Regular Papers, 2025).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Advancements%20in%20content-addressable%20memory%20%28cam%29%20circuits%3A%20State-of-the-art%2C%20applications%2C%20and%20future%20directions%20in%20the%20ai%20domain&publication_year=2025&author=Molom-Ochir%2CT&author=Taylor%2CB&author=Li%2CH&author=Chen%2CY)

[^42]: Moon, SH., Dutta, P., Khorrami, P., Bhanja, S. & Reis, D. The impact of device technologies on the design of non-volatile content addressable memories. In *2024 IEEE 24th International Conference on Nanotechnology (NANO)*, 513–516 (IEEE, 2024).

[^43]: Pan, Y. et al. *An energy-efficient capacitive-rram content addressable memory*. *IEEE Trans. Circuits Syst. I Regul. Pap.*[https://doi.org/10.1109/TCSI.2024.3451707](https://doi.org/10.1109/TCSI.2024.3451707) (2024).

[Article](https://doi.org/10.1109%2FTCSI.2024.3451707) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=An%20energy-efficient%20capacitive-rram%20content%20addressable%20memory&journal=IEEE%20Trans.%20Circuits%20Syst.%20I%20Regul.%20Pap.&doi=10.1109%2FTCSI.2024.3451707&publication_year=2024&author=Pan%2CY)

[^44]: Li, J., Montoye, RK., Ishii, M. & Chang, L. 1 mb 0.41 $\mu$ m $^2$ 2t-2r cell nonvolatile tcam with two-bit encoding and clocked self-referenced sensing. *IEEE Journal of Solid-State Circuits* **49**, 896–907 (2013).

[^45]: Gershman, S. J. & Daw, N. D. Reinforcement learning and episodic memory in humans and animals: An integrative framework. *Annu. Rev. Psychol.***68**, 101–128 (2017).

[Article](https://doi.org/10.1146%2Fannurev-psych-122414-033625) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27618944) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Reinforcement%20learning%20and%20episodic%20memory%20in%20humans%20and%20animals%3A%20An%20integrative%20framework&journal=Annu.%20Rev.%20Psychol.&doi=10.1146%2Fannurev-psych-122414-033625&volume=68&pages=101-128&publication_year=2017&author=Gershman%2CSJ&author=Daw%2CND)

[^46]: Le, H., Karimpanal George, T., Abdolshah, M., Tran, T. & Venkatesh, S. Model-based episodic memory induces dynamic hybrid controls. *Advances in Neural Information Processing Systems* **34**, 30313–30325 (2021).

[^47]: Watkins, C. J. & Dayan, P. *Q-learning. Machine learning* **8**, 279–292 (1992).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Q-learning.%20Machine%20learning&volume=8&pages=279-292&publication_year=1992&author=Watkins%2CCJ&author=Dayan%2CP)

[^48]: Noh, S.-H. Analysis of gradient vanishing of RNNs and performance comparison. *Information* **12**, 442 (2021).

[Article](https://doi.org/10.3390%2Finfo12110442) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Analysis%20of%20gradient%20vanishing%20of%20RNNs%20and%20performance%20comparison&journal=Information&doi=10.3390%2Finfo12110442&volume=12&publication_year=2021&author=Noh%2CS-H)

[^49]: Hochreiter, S. & Schmidhuber, J. Long short-term memory. *Neural Comput.***9**, 1735–1780 (1997).

[Article](https://doi.org/10.1162%2Fneco.1997.9.8.1735) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK1c%2FhvVahsQ%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=9377276) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Long%20short-term%20memory&journal=Neural%20Comput.&doi=10.1162%2Fneco.1997.9.8.1735&volume=9&pages=1735-1780&publication_year=1997&author=Hochreiter%2CS&author=Schmidhuber%2CJ)

[^50]: Chandak, S., Shah, P., Borkar, V. S. & Dodhia, P. Reinforcement learning in non-markovian environments. *Syst. Control Lett.***185**, 105751 (2024).

[Article](https://doi.org/10.1016%2Fj.sysconle.2024.105751) [MathSciNet](http://www.ams.org/mathscinet-getitem?mr=4708867) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Reinforcement%20learning%20in%20non-markovian%20environments&journal=Syst.%20Control%20Lett.&doi=10.1016%2Fj.sysconle.2024.105751&volume=185&publication_year=2024&author=Chandak%2CS&author=Shah%2CP&author=Borkar%2CVS&author=Dodhia%2CP)

[^51]: Misra, I. & Maaten, L. vd. Self-supervised learning of pretext-invariant representations. In *Proceedings of the IEEE/CVF conference on computer vision and pattern recognition*, 6707–6717 (2020).

[^52]: van den Oord, A., Li, Y. & Vinyals, O. Representation learning with contrastive predictive coding. arXiv preprint [arXiv:1807.03748](http://arxiv.org/abs/1807.03748) (2018).

[^53]: Towers, M. *et al.* Gymnasium: A standard interface for reinforcement learning environments. arXiv preprint [arXiv:2407.17032](http://arxiv.org/abs/2407.17032) (2024).

[^54]: Agster, K. L., Fortin, N. J. & Eichenbaum, H. The hippocampus and disambiguation of overlapping sequences. *J. Neurosci.***22**, 5760–5768. [https://doi.org/10.1523/JNEUROSCI.22-13-05760.2002](https://doi.org/10.1523/JNEUROSCI.22-13-05760.2002) (2002).

[Article](https://doi.org/10.1523%2FJNEUROSCI.22-13-05760.2002) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD38XltF2mtLc%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=12097529) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4053169) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20hippocampus%20and%20disambiguation%20of%20overlapping%20sequences&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.22-13-05760.2002&volume=22&pages=5760-5768&publication_year=2002&author=Agster%2CKL&author=Fortin%2CNJ&author=Eichenbaum%2CH)

[^55]: Fortin, N. J., Agster, K. L. & Eichenbaum, H. B. Critical role of the hippocampus in memory for sequences of events. *Nat. Neurosci.***5**, 458–462. [https://doi.org/10.1038/nn834](https://doi.org/10.1038/nn834) (2002).

[Article](https://doi.org/10.1038%2Fnn834) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD38XjtFykur8%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11976705) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4053170) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Critical%20role%20of%20the%20hippocampus%20in%20memory%20for%20sequences%20of%20events&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn834&volume=5&pages=458-462&publication_year=2002&author=Fortin%2CNJ&author=Agster%2CKL&author=Eichenbaum%2CHB)

[^56]: Allen, T. A., Salz, D. M., McKenzie, S. & Fortin, N. J. Nonspatial sequence coding in CA1 neurons. *J. Neurosci.***36**, 1547–1563. [https://doi.org/10.1523/jneurosci.2874-15.2016](https://doi.org/10.1523/jneurosci.2874-15.2016) (2016).

[Article](https://doi.org/10.1523%2Fjneurosci.2874-15.2016) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28XptlWgtrg%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26843637) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4737769) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Nonspatial%20sequence%20coding%20in%20CA1%20neurons&journal=J.%20Neurosci.&doi=10.1523%2Fjneurosci.2874-15.2016&volume=36&pages=1547-1563&publication_year=2016&author=Allen%2CTA&author=Salz%2CDM&author=McKenzie%2CS&author=Fortin%2CNJ)

[^57]: LeCun, Y., Cortes, C. & Burges, C. Mnist handwritten digit database. *ATT Labs \[Online\]. Available:* [http://yann.lecun.com/exdb/mnist](http://yann.lecun.com/exdb/mnist) **2** (2010).

[^58]: Witter, MP. Organization of the entorhinal-hippocampal system: a review of current anatomical data. *Hippocampus* **3 Spec No**, 33–44 (1993).

[^59]: van Strien, N. M., Cappaert, N. L. M. & Witter, M. P. The anatomy of memory: An interactive overview of the parahippocampal–hippocampal network. *Nat. Rev. Neurosci.***10**, 272–282. [https://doi.org/10.1038/nrn2614](https://doi.org/10.1038/nrn2614) (2009).

[Article](https://doi.org/10.1038%2Fnrn2614) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXjtlyntrg%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19300446) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20anatomy%20of%20memory%3A%20An%20interactive%20overview%20of%20the%20parahippocampal%E2%80%93hippocampal%20network&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn2614&volume=10&pages=272-282&publication_year=2009&author=Strien%2CNM&author=Cappaert%2CNLM&author=Witter%2CMP)

[^60]: Oh, S. W. et al. A mesoscale connectome of the mouse brain. *Nature* **508**, 207–214. [https://doi.org/10.1038/nature13186](https://doi.org/10.1038/nature13186) (2014).

[Article](https://doi.org/10.1038%2Fnature13186) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2014Natur.508..207O) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXmtlWjs70%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24695228) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5102064) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20mesoscale%20connectome%20of%20the%20mouse%20brain&journal=Nature&doi=10.1038%2Fnature13186&volume=508&pages=207-214&publication_year=2014&author=Oh%2CSW)

[^61]: Lisman, J. E. Relating hippocampal circuitry to function: Recall of memory sequences by reciprocal dentate–CA3 interactions. *Neuron* **22**, 233–242. [https://doi.org/10.1016/S0896-6273(00)81085-5](https://doi.org/10.1016/S0896-6273\(00\)81085-5) (1999).

[Article](https://doi.org/10.1016%2FS0896-6273%2800%2981085-5) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK1MXhs12ksr4%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10069330) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Relating%20hippocampal%20circuitry%20to%20function%3A%20Recall%20of%20memory%20sequences%20by%20reciprocal%20dentate%E2%80%93CA3%20interactions&journal=Neuron&doi=10.1016%2FS0896-6273%2800%2981085-5&volume=22&pages=233-242&publication_year=1999&author=Lisman%2CJE)

[^62]: McClelland, JL., McNaughton, BL. & O’Reilly, RC. Why there are complementary learning systems in the hippocampus and neocortex: Insights from the successes and failures of connectionist models of learning and memory. *Psychological Review* **102**, 419–457, [https://doi.org/10.1037/0033-295X.102.3.419](https://doi.org/10.1037/0033-295X.102.3.419) (1995). Place: US Publisher: American Psychological Association.

[^63]: Kumaran, D. & McClelland, J. L. Generalization Through the Recurrent Interaction of Episodic Memories. *Psychological Review* **119**, 573–616. [https://doi.org/10.1037/a0028681](https://doi.org/10.1037/a0028681) (2012).

[Article](https://doi.org/10.1037%2Fa0028681) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22775499) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3444305) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Generalization%20Through%20the%20Recurrent%20Interaction%20of%20Episodic%20Memories&journal=Psychological%20Review&doi=10.1037%2Fa0028681&volume=119&pages=573-616&publication_year=2012&author=Kumaran%2CD&author=McClelland%2CJL)

[^64]: Mnih, V. et al. Human-level control through deep reinforcement learning. *Nature* **518**, 529–533. [https://doi.org/10.1038/nature14236](https://doi.org/10.1038/nature14236) (2015).

[Article](https://doi.org/10.1038%2Fnature14236) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2015Natur.518..529M) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXjsVagur0%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25719670) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Human-level%20control%20through%20deep%20reinforcement%20learning&journal=Nature&doi=10.1038%2Fnature14236&volume=518&pages=529-533&publication_year=2015&author=Mnih%2CV)

[^65]: Knierim, J. J., Neunuebel, J. P. & Deshmukh, S. S. Functional correlates of the lateral and medial entorhinal cortex: Objects, path integration and local–global reference frames. *Philos. Trans. R. Soc. Lond. B Biol. Sci.***369**, 20130369. [https://doi.org/10.1098/rstb.2013.0369](https://doi.org/10.1098/rstb.2013.0369) (2014).

[Article](https://doi.org/10.1098%2Frstb.2013.0369) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24366146) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3866456) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Functional%20correlates%20of%20the%20lateral%20and%20medial%20entorhinal%20cortex%3A%20Objects%2C%20path%20integration%20and%20local%E2%80%93global%20reference%20frames&journal=Philos.%20Trans.%20R.%20Soc.%20Lond.%20B%20Biol.%20Sci.&doi=10.1098%2Frstb.2013.0369&volume=369&publication_year=2014&author=Knierim%2CJJ&author=Neunuebel%2CJP&author=Deshmukh%2CSS)

[^66]: Igarashi, K. M., Ito, H. T., Moser, E. I. & Moser, M.-B. Functional diversity along the transverse axis of hippocampal area CA1. *FEBS Lett.***588**, 2470–2476. [https://doi.org/10.1016/j.febslet.2014.06.004](https://doi.org/10.1016/j.febslet.2014.06.004) (2014).

[Article](https://doi.org/10.1016%2Fj.febslet.2014.06.004) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXpvFWntLk%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24911200) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Functional%20diversity%20along%20the%20transverse%20axis%20of%20hippocampal%20area%20CA1&journal=FEBS%20Lett.&doi=10.1016%2Fj.febslet.2014.06.004&volume=588&pages=2470-2476&publication_year=2014&author=Igarashi%2CKM&author=Ito%2CHT&author=Moser%2CEI&author=Moser%2CM-B)

[^67]: Watson, J. F. et al. Human hippocampal CA3 uses specific functional connectivity rules for efficient associative memory. *Cell* **188**, 501-514.e18. [https://doi.org/10.1016/j.cell.2024.11.022](https://doi.org/10.1016/j.cell.2024.11.022) (2025).

[Article](https://doi.org/10.1016%2Fj.cell.2024.11.022) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB2cXislejsLrK) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=39667938) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Human%20hippocampal%20CA3%20uses%20specific%20functional%20connectivity%20rules%20for%20efficient%20associative%20memory&journal=Cell&doi=10.1016%2Fj.cell.2024.11.022&volume=188&pages=501-514.e18&publication_year=2025&author=Watson%2CJF)

[^68]: Buzsáki, G. & Tingley, D. Space and time: The hippocampus as a sequence generator. *Trends Cogn. Sci.***22**, 853–869. [https://doi.org/10.1016/j.tics.2018.07.006](https://doi.org/10.1016/j.tics.2018.07.006) (2018).

[Article](https://doi.org/10.1016%2Fj.tics.2018.07.006) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30266146) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6166479) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Space%20and%20time%3A%20The%20hippocampus%20as%20a%20sequence%20generator&journal=Trends%20Cogn.%20Sci.&doi=10.1016%2Fj.tics.2018.07.006&volume=22&pages=853-869&publication_year=2018&author=Buzs%C3%A1ki%2CG&author=Tingley%2CD)

[^69]: Guzman, S. J., Schlögl, A., Frotscher, M. & Jonas, P. Synaptic mechanisms of pattern completion in the hippocampal CA3 network. *Science* **353**, 1117–1123. [https://doi.org/10.1126/science.aaf1836](https://doi.org/10.1126/science.aaf1836) (2016).

[Article](https://doi.org/10.1126%2Fscience.aaf1836) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2016Sci...353.1117G) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28XhsVKjsLzP) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27609885) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Synaptic%20mechanisms%20of%20pattern%20completion%20in%20the%20hippocampal%20CA3%20network&journal=Science&doi=10.1126%2Fscience.aaf1836&volume=353&pages=1117-1123&publication_year=2016&author=Guzman%2CSJ&author=Schl%C3%B6gl%2CA&author=Frotscher%2CM&author=Jonas%2CP)

[^70]: Drieu, C. & Zugaro, M. Hippocampal sequences during exploration: Mechanisms and functions. *Front. Cell. Neurosci.***13**, 232. [https://doi.org/10.3389/fncel.2019.00232](https://doi.org/10.3389/fncel.2019.00232) (2019).

[Article](https://doi.org/10.3389%2Ffncel.2019.00232) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31263399) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6584963) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Hippocampal%20sequences%20during%20exploration%3A%20Mechanisms%20and%20functions&journal=Front.%20Cell.%20Neurosci.&doi=10.3389%2Ffncel.2019.00232&volume=13&publication_year=2019&author=Drieu%2CC&author=Zugaro%2CM)

[^71]: Bright, I. M. et al. A temporal record of the past with a spectrum of time constants in the monkey entorhinal cortex. *Proc. Natl. Acad. Sci. U. S. A.***117**, 20274–20283. [https://doi.org/10.1073/pnas.1917197117](https://doi.org/10.1073/pnas.1917197117) (2020).

[Article](https://doi.org/10.1073%2Fpnas.1917197117) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2020PNAS..11720274B) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXhs1ehtL3O) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32747574) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7443936) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20temporal%20record%20of%20the%20past%20with%20a%20spectrum%20of%20time%20constants%20in%20the%20monkey%20entorhinal%20cortex&journal=Proc.%20Natl.%20Acad.%20Sci.%20U.%20S.%20A.&doi=10.1073%2Fpnas.1917197117&volume=117&pages=20274-20283&publication_year=2020&author=Bright%2CIM)

[^72]: Eichenbaum, H. Prefrontal–hippocampal interactions in episodic memory. *Nat. Rev. Neurosci.***18**, 547–558. [https://doi.org/10.1038/nrn.2017.74](https://doi.org/10.1038/nrn.2017.74) (2017).

[Article](https://doi.org/10.1038%2Fnrn.2017.74) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXhtVyht7vP) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28655882) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Prefrontal%E2%80%93hippocampal%20interactions%20in%20episodic%20memory&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn.2017.74&volume=18&pages=547-558&publication_year=2017&author=Eichenbaum%2CH)

[^73]: Euston, D. R., Gruber, A. J. & McNaughton, B. L. The role of medial prefrontal cortex in memory and decision making. *Neuron* **76**, 1057–1070. [https://doi.org/10.1016/j.neuron.2012.12.002](https://doi.org/10.1016/j.neuron.2012.12.002) (2012).

[Article](https://doi.org/10.1016%2Fj.neuron.2012.12.002) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XhvVOjs73M) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23259943) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3562704) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20role%20of%20medial%20prefrontal%20cortex%20in%20memory%20and%20decision%20making&journal=Neuron&doi=10.1016%2Fj.neuron.2012.12.002&volume=76&pages=1057-1070&publication_year=2012&author=Euston%2CDR&author=Gruber%2CAJ&author=McNaughton%2CBL)

[^74]: Carr, M. F., Jadhav, S. P. & Frank, L. M. Hippocampal replay in the awake state: A potential substrate for memory consolidation and retrieval. *Nat. Neurosci.***14**, 147–153. [https://doi.org/10.1038/nn.2732](https://doi.org/10.1038/nn.2732) (2011).

[Article](https://doi.org/10.1038%2Fnn.2732) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3MXhtFShtL4%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21270783) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3215304) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Hippocampal%20replay%20in%20the%20awake%20state%3A%20A%20potential%20substrate%20for%20memory%20consolidation%20and%20retrieval&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.2732&volume=14&pages=147-153&publication_year=2011&author=Carr%2CMF&author=Jadhav%2CSP&author=Frank%2CLM)

[^75]: Ólafsdóttir, HF., Bush, D. & Barry, C. The Role of Hippocampal Replay in Memory and Planning. *Current Biology* **28**, R37–R50, [https://doi.org/10.1016/j.cub.2017.10.073](https://doi.org/10.1016/j.cub.2017.10.073) (2018). 29316421.

[^76]: Shaban, A., Hou, T.-H. & Suri, M. Sot-mram-based approximate content addressable memory for *DNA* classification. *IEEE Trans. Electron Devices* [https://doi.org/10.1109/TED.2024.3423812](https://doi.org/10.1109/TED.2024.3423812) (2024).

[Article](https://doi.org/10.1109%2FTED.2024.3423812) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Sot-mram-based%20approximate%20content%20addressable%20memory%20for%20DNA%20classification&journal=IEEE%20Trans.%20Electron%20Devices&doi=10.1109%2FTED.2024.3423812&publication_year=2024&author=Shaban%2CA&author=Hou%2CT-H&author=Suri%2CM)

[^77]: Junsangsri, P., Han, J. & Lombardi, F. Design and comparative evaluation of a PCM-based CAM (content addressable memory) cell. *IEEE Trans. Nanotechnol.***16**, 359–363 (2017).

[Article](https://doi.org/10.1109%2FTNANO.2017.2649547) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2017ITNan..16..359J) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXhvFOlsbrF) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Design%20and%20comparative%20evaluation%20of%20a%20PCM-based%20CAM%20%28content%20addressable%20memory%29%20cell&journal=IEEE%20Trans.%20Nanotechnol.&doi=10.1109%2FTNANO.2017.2649547&volume=16&pages=359-363&publication_year=2017&author=Junsangsri%2CP&author=Han%2CJ&author=Lombardi%2CF)

[^78]: Yin, X. et al. Deep random forest with ferroelectric analog content addressable memory. *Sci. Adv.***10**, eadk8471 (2024).

[Article](https://doi.org/10.1126%2Fsciadv.adk8471) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB2cXht12nsrfI) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=38838137) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC11152117) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Deep%20random%20forest%20with%20ferroelectric%20analog%20content%20addressable%20memory&journal=Sci.%20Adv.&doi=10.1126%2Fsciadv.adk8471&volume=10&publication_year=2024&author=Yin%2CX)

[^79]: Nosofsky, R. M. Attention, similarity, and the identification-categorization relationship. *J. Exp. Psychol. Gen.***115**, 39 (1986).

[Article](https://doi.org/10.1037%2F0096-3445.115.1.39) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL287ntVentQ%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=2937873) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Attention%2C%20similarity%2C%20and%20the%20identification-categorization%20relationship&journal=J.%20Exp.%20Psychol.%20Gen.&doi=10.1037%2F0096-3445.115.1.39&volume=115&publication_year=1986&author=Nosofsky%2CRM)