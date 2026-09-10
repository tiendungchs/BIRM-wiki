---
title: "Clone-structured graph representations enable flexible learning and vicarious evaluation of cognitive maps"
source: "https://www.nature.com/articles/s41467-021-22559-5"
author:
  - "[[Dileep George]]"
  - "[[Rajeev V. Rikhye]]"
  - "[[Nishad Gothoskar]]"
  - "[[J. Swaroop Guntupalli]]"
  - "[[Antoine Dedieu]]"
  - "[[Miguel Lázaro-Gredilla]]"
published: 2021-04-22
created: 2026-09-10
description: "Cognitive maps are mental representations of spatial and conceptual relationships in an environment, and are critical for flexible behavior. To form these abstract maps, the hippocampus has to learn to separate or merge aliased observations appropriately in different contexts in a manner that enables generalization and efficient planning. Here we propose a specific higher-order graph structure, clone-structured cognitive graph (CSCG), which forms clones of an observation for different contexts as a representation that addresses these problems. CSCGs can be learned efficiently using a probabilistic sequence model that is inherently robust to uncertainty. We show that CSCGs can explain a variety of cognitive map phenomena such as discovering spatial relations from aliased sensations, transitive inference between disjoint episodes, and formation of transferable schemas. Learning different clones for different contexts explains the emergence of splitter cells observed in maze navigation and event-specific responses in lap-running experiments. Moreover, learning and inference dynamics of CSCGs offer a coherent explanation for disparate place cell remapping phenomena. By lifting aliased observations into a hidden space, CSCGs reveal latent modularity useful for hierarchical abstraction and planning. Altogether, CSCG provides a simple unifying framework for understanding hippocampal function, and could be a pathway for forming relational abstractions in artificial intelligence. Higher-order sequence learning using a structured graph representation - clone-structured cognitive graphs (CSCG) – can explain how the hippocampus learns cognitive maps. CSCG provides novel explanations for transferable schemas and transitive inference in the hippocampus, and for how place cells, splitter cells, lap-cells and a variety of phenomena emerge from the same set of fundamental principles."
tags:
  - "clippings"
---
## Abstract

Cognitive maps are mental representations of spatial and conceptual relationships in an environment, and are critical for flexible behavior. To form these abstract maps, the hippocampus has to learn to separate or merge aliased observations appropriately in different contexts in a manner that enables generalization and efficient planning. Here we propose a specific higher-order graph structure, clone-structured cognitive graph (CSCG), which forms clones of an observation for different contexts as a representation that addresses these problems. CSCGs can be learned efficiently using a probabilistic sequence model that is inherently robust to uncertainty. We show that CSCGs can explain a variety of cognitive map phenomena such as discovering spatial relations from aliased sensations, transitive inference between disjoint episodes, and formation of transferable schemas. Learning different clones for different contexts explains the emergence of splitter cells observed in maze navigation and event-specific responses in lap-running experiments. Moreover, learning and inference dynamics of CSCGs offer a coherent explanation for disparate place cell remapping phenomena. By lifting aliased observations into a hidden space, CSCGs reveal latent modularity useful for hierarchical abstraction and planning. Altogether, CSCG provides a simple unifying framework for understanding hippocampal function, and could be a pathway for forming relational abstractions in artificial intelligence.

## Introduction

Vicarious trial and error [^1], the ability to evaluate futures by mental time travel, is a hallmark of intelligence. To do this, agents need to learn mental models, or “cognitive maps” [^2] [^3], from a stream of sensory information as they experience the environment around them [^4]. Learning these mental abstractions is complicated by the fact that sensory observation is often aliased. Depending on context, identical events could have different interpretations and dissimilar events could mean the same thing [^5]. As such, a computational theory for cognitive maps should: (1) propose mechanisms for how context and location-specific representations emerge from aliased sensory or cognitive events, and (2) describe how the representational structure enables consolidation, knowledge transfer, and flexible and hierarchical planning. Most attempts at developing such a theory, which include modeling hippocampus as a memory index, a relational memory space, a rapid event memorizer, and systems-level models of pattern-separation and pattern completion, have not reconciled the diverse functional attributes [^6] [^7] [^8] of the hippocampus under a common framework. Recent models have attempted to reconcile the representational properties of place cells and grid cells using successor representation (SR) theory [^9] [^10] [^11] and by assuming that these cells are an efficient representation of a graph [^12]. However, both these models fall short in describing how flexible planning can take place after learning the environment and are unable to explain several key experimental observations such as place cell remapping in spatial and nonspatial environments [^13] [^14] and the fact that some place cells encode routes toward goals [^15] [^16], while others encode goal values [^17] [^18].

A behaving agent often encounters external situations that look instantaneously similar, but require different action policies based on the context. In these situations, sensory observations should be contextualized into different states. In other times, dissimilar looking sensory observations might need to be merged on to the same state because those contexts all lead to the same outcome. In general, to form a flexible model of the world from sequential observations the agent needs to have a representational structure and a learning algorithm that allows for elastic splitting and merging of contexts as appropriate [^5] [^19]. Moreover, the representational structure should be such that it allows for dynamic planning and handling of uncertainty.

Here we propose a specific higher-order graph—clone-structured cognitive graph (CSCG)—that maps observations onto different “clones” of that observation as a representational structure that addresses these requirements. Using just principles of higher-order sequence learning and probabilistic inference, CSCGs can explain a variety of cognitive map phenomena such as discovering spatial relations from an aliased sensory stream, transitive inference between disjoint episodes of experiences, transferable structural knowledge, and shortcut-finding in novel environments. CSCG’s ability to create different clones for different contexts explains the emergence of splitter cells [^16], and route-specific encoding [^20], which we demonstrate using a variety of experimental settings common in neurophysiology. In a repeated lap-running task [^21], CSCGs learn lap-specific neurons, and exhibit event-specific responses robust to maze perturbations, similar to neurophysiological observations. CSCGs can also learn to separate multiple environments that share observations, and then retrieve them based on contextual similarity. Notably, the dynamics of clone-structure learning and inference gives a coherent explanation for the different activity remapping phenomena observed when rats move from one environment to another. By lifting the aliased observations into a hidden space, CSCGs reveal latent modularity that is then used for hierarchical abstraction and planning.

### Clone-structured cognitive graphs as a model of cognitive maps

The central idea behind CSCGs is dynamic Markov coding [^22], which is a method for representing higher-order sequences by splitting, or cloning, observed states. For example, a first-order Markov chain representing the sequence of events *A*  →  *C*  →  *E* and *B*  →  *C*  →  *D* will assign high probability to the sequence *A*  →  *C*  →  *D* (Fig. [1](https://www.nature.com/articles/s41467-021-22559-5#Fig1) a). In contrast, dynamic Markov coding makes a higher-order model by splitting the state representing event *C* into multiple copies, one for each incoming connection, and further specializes their outgoing connections through learning. This state cloning mechanism permits a sparse representation of higher-order dependencies, and has been discovered in various domains [^22] [^23] [^24] [^25]. With cloning, the same bottom-up sensory input is represented by a multitude of states that are copies of each other in their selectivity for the sensory input, but specialized for specific temporal contexts, enabling the efficient storage of a large number of higher-order and stochastic sequences without destructive interference. However, learning dynamic Markov coding is challenging because cloning relies on a greedy heuristic that results in severe suboptimality—sequences that are interspersed with zeroth-order or first-order segments will result in an uncontrolled growth of the cloned states. Although [^25] incorporated the cloning idea in a biological learning rule, the lack of a probabilistic model and a coherent global loss function hampered its ability to discover higher-order sequences, and flexibly represent contexts. An effective learning approach should split clones to discover higher-order states, and flexibly merge them when that helps generalization.

![Fig. 1: Clone-structured cognitive graph.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-021-22559-5/MediaObjects/41467_2021_22559_Fig1_HTML.png?as=webp)

Fig. 1: Clone-structured cognitive graph.

Our previous work [^26] showed that many of the training shortcomings of dynamic Markov coding can be overcome through cloned hidden Markov models (HMM)—a sparse restriction of an overcomplete HMM [^27]. In cloned HMMs, the maximum number of clones per state is allocated up front, which enforces a capacity bottleneck. Learning using the expectation maximization (EM) algorithm figures out how to use this capacity appropriately to split or merge different contexts for efficient use of the clones to represent different contexts. In addition, cloned HMMs represent the cloning mechanism of dynamic Markov coding in a rigorous probabilistic framework that handles noise and uncertainty during learning and inference.

Both HMMs and cloned HMMs assume that the observed data are generated from a hidden process that obeys the Markovian property. That is, the conditional probability distribution of future states, given the present state and all past states, depends only upon the present state and not on any past states. For HMMs, the joint distribution over the observed and hidden states given by the following equation:

 $P \left(x_{1} , \ldots , x_{N} , z_{1} , \ldots , z_{N}\right) = P \left(z_{1}\right) \prod_{n = 1}^{N - 1} P \left(z_{n + 1} \left|\right. z_{n}\right) \prod_{n = 1}^{N} P \left(x_{n} \left|\right. z_{n}\right)$ 
$$
P({x}_{1},\ldots ,{x}_{N},{z}_{1},\ldots ,{z}_{N})=P({z}_{1})\mathop{\prod }\limits_{n=1}^{N-1}P({z}_{n+1}| {z}_{n})\mathop{\prod }\limits_{n=1}^{N}P({x}_{n}| {z}_{n})
$$

(1)

where *P* (*z* <sub>1</sub>) is the initial hidden state distribution, *P* (*z* <sub><i>n</i>  + 1</sub> ∣ *z* <sub><i>n</i></sub>) is the probability of transitioning from hidden state *z* <sub><i>n</i></sub> to *z* <sub><i>n</i>  + 1</sub>, and *P* (*x* <sub><i>n</i></sub> ∣ *z* <sub><i>n</i></sub>) is the probability that observation *x* <sub><i>n</i></sub> is generated from the hidden state *z* <sub><i>n</i></sub>. We assume there are *E* distinct observations and *H* distinct hidden states i.e., *x* <sub><i>n</i></sub> can take a value from 1, 2, …, *E* and *z* <sub><i>n</i></sub> can take a value from 1, 2, …, *H*.

In contrast to HMMs, in the cloned HMMs, many hidden states map deterministically to the same observation (Fig. [1](https://www.nature.com/articles/s41467-021-22559-5#Fig1) b). The set of hidden states that map to a given observation are referred to as the *clones* of that observation. We use *C* (*j*) to refer to the set of clones of observation *j*. The probability of a sequence in a cloned HMM is obtained by marginalizing over the hidden states as follows:

 $P \left(x_{1} , \ldots , x_{N}\right) = \underset{z_{1} , \ldots , z_{N}}{\sum} P \left(z_{1}\right) \prod_{n = 1}^{N - 1} P \left(z_{n + 1} \left|\right. z_{n}\right) \prod_{n = 1}^{N} P \left(x_{n} \left|\right. z_{n}\right) = \underset{z_{1} \in C \left(x_{1}\right)}{\sum} \ldots \underset{z_{N} \in C \left(x_{N}\right)}{\sum} P \left(z_{1}\right) \prod_{n = 1}^{N - 1} P \left(z_{n + 1} \left|\right. z_{n}\right) ,$ 
$$
\begin{aligned}
P({x}_{1},\ldots ,{x}_{N})=\mathop{\sum} \limits_{{z}_{1},\ldots ,{z}_{N}}P({z}_{1})\mathop{\prod }\limits_{n=1}^{N-1}P({z}_{n+1}| {z}_{n})\mathop{\prod }\limits_{n=1}^{N}P({x}_{n}| {z}_{n})\\ =\mathop{\sum} _{{z}_{1}\in C({x}_{1})}\ldots \mathop{\sum} _{{z}_{N}\in C({x}_{N})}P({z}_{1})\mathop{\prod }\limits_{n=1}^{N-1}P({z}_{n+1}| {z}_{n}),
\end{aligned}
$$

(2)

where the simplification is a result of *P* (*x* <sub><i>n</i></sub>  =  *j* ∣ *z* <sub><i>n</i></sub>  =  *i*) = 0 for all *i*  ∉  *C* (*j*) (and 1 otherwise). Moreover, since each hidden state is associated with a single observation, EM-based learning is significantly more efficient in cloned HMMs, allowing it to handle very large state spaces compared to standard HMMs [^26]. See “Methods” for more details.

A hallmark of our model is the ability to handle noise and uncertainty via message-passing inference [^28], and smoothing. Notably, just a forward and backward sweep of messages through the transition matrix *P* (*z* <sub><i>n</i>  + 1</sub> ∣ *z* <sub><i>n</i></sub>) is adequate for exact inference, and uncertainty about observations is handled through “soft-evidence” messages. Smoothing [^29] is a mechanism for incorporating robustness to noise and limited data in probabilistic models. In cloned HMMs, smoothing is accomplished by adding very small probability to some transitions that were unobserved in training. See “Methods” for more details.

### Neurobiological circuit

Like HMMs [^30], cloned HMM can be readily instantiated as a neuronal circuit whose mechanistic interpretation provides additional insights on the advantages of the cloned representation. Each clone corresponds to a neuron, and the “lateral” connections between these neurons form the cloned HMM transition matrix *P* (*z* <sub><i>n</i>  + 1</sub> ∣ *z* <sub><i>n</i></sub>). For example, the circuit in Fig. [1](https://www.nature.com/articles/s41467-021-22559-5#Fig1) d shows how neurons can be connected in the cloned HMM to represent the following stored sequences *A*  →  *B*  → (*C*, *D*) →  *E*  →  *A* (green), *B*  →  *A*  →  *B* (light brown), *B*  →  *C*  →  *D* (dark brown), and *A*  →  *C*  →  *E* (purple).

The transition matrix can also be treated as a directed graph, with the neurons forming the nodes of the graph and the axonal branches forming the directed edges. The set of neurons that are clones of each other receive the same “bottom-up” input (blue arrows) from the observation. The output of a clone-neuron is a weighted sum of its lateral inputs, multiplied by the bottom-up input, corresponding to the forward pass message in HMM inference [^30].

The evidence at any particular time instant can be uncertain (“soft evidence”), manifesting as graded activation over the population of observation neurons. For a particular observation, the direct bottom-up connections from the observation to all its clones activate the different sequences that observation is part of, and these activations are then modulated based on the specific contextual support each clone receives on its lateral connections. The population of clone neurons represent the probability of different contexts that are active at any time in proportion to their probability. Figure [1](https://www.nature.com/articles/s41467-021-22559-5#Fig1) e shows how these activities propagate for a noisy input sequence *A*  → (*B*, *E*) → (*A*, *D*) →  *E* from *t*  = 0 to *t*  = 3 corresponding to a true sequence *A*  →  *B*  →  *D*  →  *E*. The activations are represented in different shades of red, with lighter shades indicating weaker activations. At every time instant, the activated lateral inputs are highlighted, and these correspond to the clones active in the previous time step. By correctly integrating the context and noisy input, the clone activations of the cloned HMM filter out the noise to represent the true input sequence. Replay in the hippocampus is the sequential activation of cells that represent prior learning [^31]. Replay of previously experienced trajectories is conjectured to be involved in vicarious evaluations of goals [^1]. Figure [1](https://www.nature.com/articles/s41467-021-22559-5#Fig1) f shows how sequences can be replayed (sampled) from the circuit.

Queries like marginal or MAP inference can be implemented in neural circuits as forward and backward sweeps similar to the visualizations in Fig. [1](https://www.nature.com/articles/s41467-021-22559-5#Fig1), analogous to the neural implementation of message-passing inference explored in earlier works [^28] [^30] [^32]. The EM algorithm used for learning is well approximated by the neurobiological mechanism of spike-timing-dependent plasticity [^33].

### CSCG: action-augmented cloned HMM

CSCG extends cloned HMMs to include actions of an agent. An agent’s experience is a stream of sensation-action pairs (*x* <sub>1</sub>, *a* <sub>1</sub>), (*x* <sub>2</sub>, *a* <sub>2</sub>)…(*x* <sub><i>N</i>  − 1</sub>, *a* <sub><i>N</i>  − 1</sub>), (*x* <sub><i>N</i></sub>, −) where ${x}_{n}\in {{\mathbb{Z}}}^{* }$ are the agent’s sensory observations and ${a}_{n}\in {{\mathbb{Z}}}^{* }$ are the actions reported by the agent’s proprioception.

The observed actions are simply nonnegative integers with unknown semantics (i.e., the agent observes *a* <sub>1</sub>  = 0 happened, but does not know that the action means “move north in the room”). In CSCG, the action is a function of the current hidden state and the future hidden state is a function of both the current hidden state and the action taken. The graphical model for this CSCG is depicted in Fig. [1](https://www.nature.com/articles/s41467-021-22559-5#Fig1) c. Mathematically, the joint observation action density is:

 $P \left(x_{1} , \ldots , x_{N} , a_{1} , \ldots , a_{N - 1}\right) = \underset{z_{1} \in C \left(x_{1}\right)}{\sum} \ldots \underset{z_{n} \in C \left(x_{n}\right)}{\sum} P \left(z_{1}\right) \prod_{n = 1}^{N - 1} P \left(z_{n + 1} , a_{n} \left|\right. z_{n}\right) .$ 
$$
P({x}_{1},\ldots ,{x}_{N},{a}_{1},\ldots ,{a}_{N-1})=\mathop{\sum} _{{z}_{1}\in C({x}_{1})}\ldots \mathop{\sum} _{{z}_{n}\in C({x}_{n})}P({z}_{1})\mathop{\prod }\limits_{n=1}^{N-1}P({z}_{n+1},{a}_{n}| {z}_{n}).
$$

(3)

Our action-augmented model allows for the agent to learn which actions are feasible in a given state, compared to action-conditioned formulations [^34] that only predict future observations from actions.

### Planning within a CSCG

Planning is treated as inference [^35] and achieved using biologically plausible message-passing algorithms [^28]. The goal can be specified as either a desired observation or as a specific clone of that observation. Planning is then accomplished by clamping the current clone and the target, and inferring the intermediate sequence of observations and actions required to reach these observations. It is easy to determine how far into the future we have to set our goal by running a forward pass through the graphical model and determining the feasibility of the goal at each step. The backward pass will then return the required sequence of actions. Importantly, because the graphical model is inherently probabilistic, it can handle noisy observations and actions with uncertain outcomes.

## Results

We performed several experiments to test the ability of CSCGs to model cognitive maps. We specifically tested for known functional characteristics such as learning spatial maps from random walks under aliased and disjoint sensory experiences, transferable structural knowledge, finding shortcuts, and supporting hierarchical planning and physiological findings such as remapping of place cells, and route-specific encoding.

### Emergence of spatial maps from aliased sequential observations

From purely sequential random walk observations that do not uniquely identify locations in space, CSCGs can learn the underlying spatial map, a capability that is similar to people and animals. Figure [2](https://www.nature.com/articles/s41467-021-22559-5#Fig2) a shows a 2D room with the sensory observations associated with each location. The room has 48 unique locations, but only four unique sensory inputs (represented as colors), and an agent taking a random walk observes a sequence of these sensory inputs. A first-order sequence model would severely under-fit, and pure memorization of sequences will not learn the structure of the room because the same sequence hardly ever repeats. In contrast, a CSCG discovered the underlying 2D graph of the room perfectly (Fig. [2](https://www.nature.com/articles/s41467-021-22559-5#Fig2) b), from a sequence of observation action pairs from a random walk with 50,000 steps. As the number of unique randomly placed observations increases, learning becomes easier (see Supplementary Results).

![Fig. 2: Spatial representations emerge from aliased sequential random walk observations without Euclidean assumptions.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-021-22559-5/MediaObjects/41467_2021_22559_Fig2_HTML.png?as=webp)

Fig. 2: Spatial representations emerge from aliased sequential random walk observations without Euclidean assumptions.

Remarkably, CSCGs learn the spatial topology even when most of the observations are aliased like those from a large empty room where distinct observations are produced only near the walls as shown in Fig. [2](https://www.nature.com/articles/s41467-021-22559-5#Fig2) c. The combination of high correlation between observations, and severe aliasing makes this a challenging learning problem. Despite this, the CSCG is able to perfectly learn the topology of the 6 × 8 room (Fig. [2](https://www.nature.com/articles/s41467-021-22559-5#Fig2) d). This capability degrades as the room gets larger, but the degradation is graceful. For example, the periphery of a 9 × 11 room is well modeled, but the CSCG is unable to distinguish a few locations in the middle (see Supplementary Results). Moreover, even when the training sequence is purely observations without the paired actions, CSCGs are able to partially learn the layout of the room (see Supplementary Results).

### Transitive inference: disjoint experiences can be stitched together into a coherent whole

Transitive inference, the ability to infer the relationships between items or events that were not experienced at the same time, is attributed to cognitive maps [^7]. Examples include realizing *A*  >  *C* from knowing *A*  >  *B* and *B*  >  *C*, or inferring a new way to navigate a city from landmarks and their relative positions experienced on different trips [^36].

We tested CSCGs on a challenging problem designed to probe multiple aspects of transitive inference and found that it can stitch together disjoint episodes of sequential experience into a coherent whole. The experimental setting consisted of overlapping rooms (Fig. [2](https://www.nature.com/articles/s41467-021-22559-5#Fig2) e), each with aliased observations like in the previous experiment. Moreover, the first room had an additional portion which was identical to the overlapping section between the two rooms. This design allows testing whether an agent that experiences only first room or second room exclusively and sequentially can correctly figure out the relationship between the rooms and their overlaps. The combination of a large state-space, aliased observations, nested relationships, and two-dimensional transitivity makes the problem setting significantly harder than previous attempts [^37]. We collected two independent 10,000-step sequences of action-observation pairs on each room by performing two separate random walks, and trained a single CSCG on both sequences. The result of training is visualized in Fig. [2](https://www.nature.com/articles/s41467-021-22559-5#Fig2) f and in Supplementary Movie [2](https://www.nature.com/articles/s41467-021-22559-5#MOESM5). The learned transition matrix (shown as a graph) has stitched together the compatible region of both rooms, creating a single, larger spatial map that is consistent with both sequences while reusing clones when possible. The confounding additional patch in the first room remains correctly unmerged, and in the right relative position in the first room, despite looking identical to the overlapping region.

Discovering the correct latent global map enables CSCG to make transitive generalizations. Although the agent has never experienced a path taking it from regions that are exclusive to Room 1 to regions exclusive to Room 2, it can use the learned map to vicariously navigate between any two positions in the combined space. Just like in the earlier experiment, the learning is purely relational: no assumptions about Euclidean geometry or 2D or 3D maps are made in the model.

Interestingly, plotting the activation of clones over time reveals that when the agent first traverses the overlapping region (trajectory *X* in Fig. [2](https://www.nature.com/articles/s41467-021-22559-5#Fig2) g), clones corresponding to both the overlap region and the identical confounding region are active (Fig. [2](https://www.nature.com/articles/s41467-021-22559-5#Fig2) h), indicating that the agent is uncertain of its position in the maze. This also suggests that the agent’s belief in the cognitive map is split between the two possible realities (see Supplementary Movie [1](https://www.nature.com/articles/s41467-021-22559-5#MOESM4)) because the overlap region and the confounding region are exactly the same without additional context. Stepping out of the overlap region gives the agent adequate context to resolve ambiguity. Subsequently, as the agent explores the confounding region (trajectory *Y* in Fig. [2](https://www.nature.com/articles/s41467-021-22559-5#Fig2) g), clones corresponding to this region become more active, and the clones corresponding to the overlap region are no longer active. When the agent returns to the overlap region to follow the same sequence (trajectory *X*) it originally followed, the clone activities reflect that the agent is no longer confused between the overlap region and the confounding region.

### Learned graphs form a reusable structure to explore similar environments

The generic spatial structure learned in one room can be utilized as a schema [^38] [^39] for exploring, planning, and finding shortcuts in a novel room, much like the capabilities of hippocampus-based navigation [^40]. To test this, we first trained the CSCG on Room 1 based on aliased observations from a random walk with 10,000 steps. As before, CSCG learned the graph of the room perfectly. Next, we placed the agent in Room 2 which is unfamiliar (Fig. [3](https://www.nature.com/articles/s41467-021-22559-5#Fig3) a). We kept the transition matrix of the CSCG fixed, and re-initialized the emission matrix to random values. As the agent walks in the new room, the emission matrix is updated with the EM algorithm. Even without visiting all the locations in the new room, the CSCG is able to make shortcut travels between visited locations through locations that have never been visited (Fig. [3](https://www.nature.com/articles/s41467-021-22559-5#Fig3) b). After a short traversal along the periphery as shown in Fig. [3](https://www.nature.com/articles/s41467-021-22559-5#Fig3) a, we queried to find the shortest path from the end state to the start state. The CSCG returned the correct sequence of actions, even though it obviously cannot predict the observations along the path. Interestingly, Viterbi decoding [^41] reveals the same hidden states that you would get if you Viterbi decoded the same path in Room 1. Querying the CSCG on the shortest path from the bottom left corner of the room to the start position reveals the path indicated by the blue arrows in Fig. [3](https://www.nature.com/articles/s41467-021-22559-5#Fig3) b. This solution is the Djikstra’s shortest path through the graph obtained from Room 1. Furthermore, if we “block” the path we get another solution that is also optimal in terms of Djikstra’s algorithm (Fig. [3](https://www.nature.com/articles/s41467-021-22559-5#Fig3) c). Even with partial knowledge of a novel room, an agent can vicariously evaluate the number and types of actions to be taken to reach a destination by reusing CSCG’s transition graph from a familiar room.

![Fig. 3: Learned transition graphs form a reusable schema.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-021-22559-5/MediaObjects/41467_2021_22559_Fig3_HTML.png?as=webp)

Fig. 3: Learned transition graphs form a reusable schema.

When the transition matrix from the old room is reused, the new room is learned very quickly even when the agent explores using a random walk: the new room is learned fully when all the locations in the room are visited at least once (Fig. [3](https://www.nature.com/articles/s41467-021-22559-5#Fig3) d–f). The plots show the proportion of the room explored and the average accuracy of predicting the next symbol as a function of the number of random walk steps.

### Representation of paths and temporal order

CSCGs learn paths and represent temporal order when the observed statistics demand it, for example when the observations correspond to an animal repeatedly traveling prototypical routes. For example, consider the T-maze shown in Fig. [4](https://www.nature.com/articles/s41467-021-22559-5#Fig4) a, which is traversed in a figure-of-eight pattern either from the right (blue path) or the left (red path). As a result, the two paths share the same segment. Interestingly, CSCG learns separate clones for this shared segment (Fig. [4](https://www.nature.com/articles/s41467-021-22559-5#Fig4) b) and similar to the observations in [^16], the activity of clones in this overlapping segment will indicate whether the agent is going to turn left or right (Fig. [4](https://www.nature.com/articles/s41467-021-22559-5#Fig4) c). It is important to note that the ability of CSCGs to learn flexible higher-order sequences is independent of the modality [^4]. In particular, the inputs can correspond to spatial observations, odors, sequences of characters, or observations from any other phenomenon [^26]. CSCG will learn an approximation of the graph underlying the generative process, in close correspondence with the role for cognitive maps envisaged by [^2]. We illustrate in Fig. [4](https://www.nature.com/articles/s41467-021-22559-5#Fig4) e the CSCG learned for a maze with a shared path shown in Fig. [4](https://www.nature.com/articles/s41467-021-22559-5#Fig4) d.

![Fig. 4: Learning temporal order and paths.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-021-22559-5/MediaObjects/41467_2021_22559_Fig4_HTML.png?as=webp)

Fig. 4: Learning temporal order and paths.

Neurophysiological experiments have shown the emergence of “splitter cells” in the hippocampus [^16]. These cells represent paths to a goal rather than physical locations and emerge as rats repeatedly traverse the same sequential routes as opposed to taking random walks [^20]. Figure [4](https://www.nature.com/articles/s41467-021-22559-5#Fig4) f shows a maze in which the agent can traverse two different routes (indicated by the magenta and green lines) to reach the same destination. Both these routes have regions in which the exact path that the agent follows is stochastic, as denoted by the arrows that indicate the possible movements from each cell. Observations in the maze are marked by numbers and, as before, the same observation can be sensed in many parts of the maze. Additionally, the two routes intersect and share a common segment. CSCGs trained on these paths are able to represent both routes by using different clones for each of the routes, analogous to the route dependency exhibited by place cells in similar experiments. We observe that disjoint subsets of clones will activate when traversing each of the routes. Figure [4](https://www.nature.com/articles/s41467-021-22559-5#Fig4) g shows that when conditioning on the starting state, sampling in the learned CSCG will always produce paths that are consistent with the two routes. By visualizing the graph defined by the CSCG transition matrix, we see that the two routes are represented with two different chains (Fig. [4](https://www.nature.com/articles/s41467-021-22559-5#Fig4) g). With a first-order model, when the shared segment is reached, all context about the previous segments will be lost and the model will make incorrect predictions about the future path. CSCGs, on the other hand, are able to capture the history of the path and therefore properly model the routes and their distinct start states.

Learning higher-order sequences in a CSCG can also explain recently discovered phenomena like chunking cells and event-specific representations (ESR) [^21], place cell activations that signal a combination of the location and lap-number for different laps around the same maze. Figure [5](https://www.nature.com/articles/s41467-021-22559-5#Fig5) a shows a setting similar to the experiment in [^21] where a rat runs four laps in a looping rectangular track before receiving a reward. A CSCG exposed to the same sequence learned to distinguish the laps and to predict the reward at the end of the fourth lap, without the help of any lap-boundary markers in the training sequence. Planning for achieving the reward recovered the correct sequence of actions, which we then executed to record the activations of the clones in different laps. Visualizing the propagation of beliefs of each clone, either conditioned on the observation or the action, produces a sequence-like activation pattern where one clone is active for each sensory observation, and as such the different laps around the maze are encoded by different clones (Fig. [5](https://www.nature.com/articles/s41467-021-22559-5#Fig5) b). Similar to the neurons in the hippocampus, whose firing rates are shown in Fig. [5](https://www.nature.com/articles/s41467-021-22559-5#Fig5) c [^21], clones show graded activity across laps. A clone is maximally active for an observation when it occurs in its specific lap, but shows weak activations when that observation is encountered in other laps, a signature of ESR. This occurs naturally in the CSCG due to smoothing and the dynamics of inference, visualized in Fig. [5](https://www.nature.com/articles/s41467-021-22559-5#Fig5) e. The cognitive map for this maze is a chain of observations (see Fig. [5](https://www.nature.com/articles/s41467-021-22559-5#Fig5) e) which split each lap into distinct contextual events. In doing so, the agent is able to identify which lap it is in based on identical local observations. Sun et al. reported that despite extending the maze, neurons in the hippocampus still respond uniquely to each lap. We mimicked this experiment by elongating our maze in one dimension, by introducing repeated, or aliased, sensory observations (Fig. [5](https://www.nature.com/articles/s41467-021-22559-5#Fig5) d). Again, as with the smaller maze, we observed that clones were uniquely active on each lap and parsed each lap as a separate contextual event (Fig. [5](https://www.nature.com/articles/s41467-021-22559-5#Fig5) d). Even when the maze is extended by introducing novel observations, the ESR-like clone activity traces persist (see Supplementary Results). Robustness of ESR to maze elongations can also be explained by inference in a smoothed CSCG—a repeated observation is explained as noise in the previous time step, and re-planning from the current observation recovers the correct sequence of actions.

![Fig. 5: Lap-neurons and event-specific representations.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-021-22559-5/MediaObjects/41467_2021_22559_Fig5_HTML.png?as=webp)

Fig. 5: Lap-neurons and event-specific representations.

### Learning multiple maps and explaining remapping

Remapping is the phenomenon where hippocampal place cell activity reorganizes in response to a change in the physical environment. Remapping, which can either be global or partial [^19] [^42] [^43] [^44] [^45], depends on how the hippocampus can segregate, store, and retrieve maps for multiple environments that might be similar or dissimilar [^13] [^42].

Similar to the hippocampus [^19], a single CSCG can learn to separate maps for different environments that have similar instantaneous observations, represent those maps simultaneously in memory, and then use contextual similarity to retrieve the appropriate map to drive behavior. In Fig. [6](https://www.nature.com/articles/s41467-021-22559-5#Fig6) a, we show five different 5 × 5 rooms that all share the same 25 observations, but arranged differently in space. We learn a single CSCG from sequences of random walks in each of these rooms where the walks are switched between different rooms at irregular intervals, without providing any supervision about the room identity or time of switching. Although all observations are shared between the rooms, with sufficient training, the CSCG learns to form different clones for the different rooms. Figure [6](https://www.nature.com/articles/s41467-021-22559-5#Fig6) ai plots the agent’s belief about which map it is in as it goes through a 50-step random walk sequence in each room from the first to the last, showing that the maze identity is represented in the population response, despite the ambiguous instantaneous observations.

![Fig. 6: Remapping.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-021-22559-5/MediaObjects/41467_2021_22559_Fig6_HTML.png?as=webp)

Fig. 6: Remapping.

We conducted a series of experiments to evaluate how the similarity between environments, predictability within each environment, the amount of learning, and the amount of noise and uncertainty affect the degree of reorganization of clone activations. These experiments used two sets of environments—mazes and rooms. Rooms are the 5 × 5 rooms described earlier (Fig. [6](https://www.nature.com/articles/s41467-021-22559-5#Fig6) a), mazes consist of five different shapes (Fig. [6](https://www.nature.com/articles/s41467-021-22559-5#Fig6) b) composed of six distinct observations (four different corners, and vertical or horizontal arms). The mazes have better within-environment predictability compared to the rooms because of the lower-branching factor of the random walk, and mazes are more similar to each other compared to the similarity between different rooms. We trained two CSCGs, one for the set of rooms and the other for the set of mazes, and evaluated how remapping changed with the amount of training, and uncertainty (see Fig. [6](https://www.nature.com/articles/s41467-021-22559-5#Fig6) ai–iv, bi–iv).

Our observations suggest that global remapping, partial remapping, and rate remapping can be explained using CSCGs: they are manifestations of learning and inference dynamics using a cloned structure when multiple maps are represented in the same model. We were able to reproduce different remapping effects by varying the amount of training and uncertainty. The rows (ii) to (iv) in Fig. [6](https://www.nature.com/articles/s41467-021-22559-5#Fig6) a, b show the clone activations of the two CSCGs that learned to represent the corresponding rooms and mazes. All the clone activation plots in a column correspond to the same random walk where the agent takes 50 steps in each room/maze, from the first to the last. When the CSCG is fully trained until the EM algorithm converges, the clone activations from the different environments overlap the least, producing an effect similar to global remapping (Fig. [6](https://www.nature.com/articles/s41467-021-22559-5#Fig6) aiii, biii) [^42]. If the CSCGs are partially trained, the clones only partially separate—while many remain exclusive to particular mazes or rooms, a large number are also active in multiple mazes/rooms (Fig. [6](https://www.nature.com/articles/s41467-021-22559-5#Fig6) aii, bii), corresponding to the effect of partial remapping [^13] [^43]. In a fully trained model, more smoothing, or soft evidence that reflects uncertainty, creates clone activations similar to rate remapping [^13] [^45] (Fig. [6](https://www.nature.com/articles/s41467-021-22559-5#Fig6) aiv, biv): all the clones that fire in the fully trained setting still fire in this case, but with a lowered rate of firing. This occurs because uncertainty and smoothing causes more sharing of the evidence among clones that represent the same observation.

The similarity between the rooms (mazes), and the amount of predictability within each room (maze), also affects the dynamics of remapping. This can be observed by comparing the clone activity traces for the rooms with that of the mazes in Fig. [6](https://www.nature.com/articles/s41467-021-22559-5#Fig6) a, b. In Fig. [6](https://www.nature.com/articles/s41467-021-22559-5#Fig6) bi, the beliefs within each maze are more stable compared to those in the rooms due to the stricter temporal contexts in the mazes [^19]. Fluid temporal contexts in the rooms produce more progressive deformation of beliefs [^46]. On the other hand, the structural similarity between the different mazes produces more ambiguity at the time of switching, resulting in a longer transient period right after entering a new maze [^46]. This is also reflected in Fig. [6](https://www.nature.com/articles/s41467-021-22559-5#Fig6) bii–iv, where clones in multiple mazes are active right after the point of switching between the mazes.

Taken together, our experiments demonstrate the conditions and mechanisms that determine how the hippocampal network may abruptly switch between preestablished representations or progressively drift from one representation to the other, producing a variety of remapping effects.

### Community detection and hierarchical planning

Humans represent plans hierarchically [^47]. Vicarious evaluations involve simulating paths to a goal, and hierarchical computations make these simulations tractable by reducing the search space [^48]. To enable hierarchical planning, the learning mechanism should be able to recover the underlying hierarchy from sequentially observed data.

By learning a cloned transition graph, CSCG lifts observations into hidden space, enabling the discovery of graph modularity that might not be apparent in the observation. Community detection algorithms [^49] can then partition the graph to form hierarchical abstractions [^8] useful for planning and inference. Like planning, and inference in CSCGs, community detection can also be implemented using message-passing algorithms [^50]. Message-passing algorithms in similar settings are known to have biologically plausible neuronal implementations [^51].

We tested CSCGs for their ability to learn hierarchical graphs by simulating the movement of an agent in two mazes. The first maze is a modular graph with three communities where the observations are not unique to a node (Fig. [7](https://www.nature.com/articles/s41467-021-22559-5#Fig7) a). In earlier studies using this graph [^8] [^10] observations directly identified the nodes, and partitioning the learned CSCG or the SR matrix can reveal the underlying community structure in that fully observed setting (see Supplementary Results). In the current setting of partial observability, due to the degeneracy of observations, community detection or MDS on the SR matrix fails to reveal the hidden communities (Fig. [7](https://www.nature.com/articles/s41467-021-22559-5#Fig7) b). In contrast, community detection on a CSCG trained from random walks readily reveals the correct community structure. The second maze, shown in Fig. [7](https://www.nature.com/articles/s41467-021-22559-5#Fig7) d, has a total of 16 rooms arranged as a 4 × 4 grid. Each room has aliased observations, and are connected by corridors (black squares). The aliasing is global: instantaneous observations do not identify the room, corridor, or location within a room. Additionally, the maze is structured in such a way that there are four hyper-rooms making this maze a three-level hierarchy. As in the earlier examples, training a CSCG on random walk sequences learned a perfect model of the maze. We then used community detection to cluster the transition matrix of the CSCG (Fig. [7](https://www.nature.com/articles/s41467-021-22559-5#Fig7) e). This clustering revealed a hierarchical grouping of the clones (Fig. [7](https://www.nature.com/articles/s41467-021-22559-5#Fig7) f), and a connectivity graph between the discovered communities. The communities respected room boundaries: although some rooms were split into two or three communities, no community straddled rooms. Applying community detection once again on this graph revealed the four hyper-rooms (Fig. [7](https://www.nature.com/articles/s41467-021-22559-5#Fig7) f) which were the highest level of the hierarchy. To navigate to a particular final destination *F* from a starting location *S* using this map, the agent first has to identify in which of these four rooms the goal is located, then plan a route in the community graph between the source community and the destination community (Fig. [7](https://www.nature.com/articles/s41467-021-22559-5#Fig7) h). In doing so, the search space in the lower level graph is significantly reduced, making planning in the hierarchical CSCG learned graph more efficient than planning directly in the original graph. We implemented this form of hierarchical planning and found that we were always able to recover an efficient path between randomly selected start and end position (see Supplementary Methods for more implementation details and for computational efficiency estimates).

![Fig. 7: CSCGs enable hierarchical abstraction and planning.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-021-22559-5/MediaObjects/41467_2021_22559_Fig7_HTML.png?as=webp)

Fig. 7: CSCGs enable hierarchical abstraction and planning.

Learning higher-order graphs that encode temporal contexts appropriately is crucial for the extraction of the hierarchy using community detection algorithms. Approaches that learn first-order connectivity on the observations, for example, SR on observations [^9], will not be able to form the right representations because the observations are typically severely aliased (see Supplementary Fig. [3](https://www.nature.com/articles/s41467-021-22559-5#MOESM1)).

## Discussion

In this paper we pursued the strong hypothesis that the hippocampus performs a singular sequence learning algorithm that learns a relational, content-agnostic structure, and demonstrated evidence for its validity [^4] [^52]. Realizing this core idea required several interrelated advancements: (1) a learning mechanism to extract higher-order graphs from sequential observations, (2) a storage and representational structure that supports transitivity, (3) efficient context-sensitive and probabilistic retrieval, and (4) and learning of hierarchies that support efficient planning—techniques we developed in this paper. In contrast to approaches that model context by concatenating or chunking visible observations, clones in CSCG are latent states that model flexible contexts that can have arbitrarily long temporal dependencies.

As a model CSCG spans multiple levels of the Marr hierarchy—its computational specification is based on probabilistic models and optimal inference, its algorithmic realization utilized neuroscience insights [^23] and readily translates to a neurobiological implementation that offers mechanistic explanations for all the experimental phenomena we considered. In a true biological implementation of CSCG, a clone state might be represented by a small assembly of neurons, and that would not change the underlying representation. The core representation learning mechanisms of CSCG might be implemented in areas CA3 or CA1 of the hippocampus [^5], with CSCG-based decision making implemented in the orbitofrontal cortex [^53].

CSCGs share similar motivations with other hippocampal theories like Tolman Eichenbaum machine (TEM) [^34] [^54], and SR, but differ substantially in capabilities and tradeoffs. For instance, unlike TEM, CSCGs can plan to achieve arbitrary goals selected at test time (see Fig. [3](https://www.nature.com/articles/s41467-021-22559-5#Fig3) b, c) and natively handle uncertainty, and erroneous or ambiguous observations (see Retrieval and Remapping in the Supplementary material). CSCGs also allow for efficient exact inference, which enables sophisticated queries to be answered quickly and exactly. In contrast, the representational complexity of TEM only allows for approximate inference. SR [^9] [^10] [^55] represents the current state of an agent by aggregating distributions over its future locations for a given policy. While the policy dependence of SR has a computational advantage for a fixed reward distribution, dynamic planning requires recomputing the SR [^10] [^56]. In contrast, CSCG can maintain higher-order temporal dependency and allows for dynamic planning with message-passing. Although SR can be used to find communities, it requires the world to be fully observable. By lifting degenerate observations into a latent graph, CSCGs can reveal latent hierarchies, a capability that is yet to be demonstrated in TEM or SR. The observation of grid cell-like properties in the eigenvectors of the SR could be a property of all methods that employ a transition matrix (see Supplementary Results), and we suspect that this property in itself might not have any behavioral relevance.

In concordance with [^52], CSCGs represent sequences of content-free pointers: each pointer can be referring to a conjunction of sensory events from different modalities. These pointers themselves can be clustered according to a similarity metric [^57], and the cluster centers will then be the atoms that are sequenced by CSCG. Partial matches of a multi-dimensional conjunction could partially activate multiple clusters and be treated as soft evidence by the CSCG, providing a potential explanation for multi-modality of place cells in various situations [^14]. The output from grid cells is treated as just another sensory modality. By providing a periodic tiling of uniform space, grid cell outputs could help to learn maps when other sensory cues are degenerate.

Although beyond the scope of the current work, hippocampal replay [^31] could potentially be explained using CSCGs. Replay has two distinct roles in CSCG. First, post-learning replay is used for consolidating trajectories using Viterbi training (see “Methods”). Our related work [^58] has shown that an algorithm that rapidly memorizes and gradually generalizes is possible for learning a CSCG representation, and the gradual generalization step uses replay for consolidation. Second, behavior-time replay is used in CSCG for searching of trajectories to multiple goals and their vicarious evaluations.

CSCGs have intriguing connections to schema networks [^59], and to schema-like representations in the hippocampus [^38]. Creating different clones for different temporal contexts is similar to the idea of synthetic items used to address state aliasing [^60] [^61] in relational representations. In addition, since sequence learning takes place in many other brain areas, for example the parietal cortex [^62] and the orbitofrontal cortex [^63], a natural extension of this work would involve learning higher-order conceptual relationships and applying them to cognitive flexibility. Similarly, encoding snapshots from a graphical model for vision [^64] [^65] as the input to this sequencer might enable the learning of visuo-spatial concepts and visual routines [^66], and model the bi-directional influence hippocampus has on the visual cortex [^67]. We believe these ideas are promising paths for future exploration.

The present work can be further extended by combining it with the active inference framework [^68] which provides a guiding principle for combining exploration and exploitation. Intuitively, each E-step of the EM algorithm updates posterior beliefs about hidden states and corresponds to state estimation or inference. Conversely, the M-step updates point estimators of model parameters and can be construed as learning. As with the TEM, these expectation maximization-based schemes (e.g., the Baum–Welch algorithm) effectively ignore uncertainty about the parameters and replace posteriors over parameters with point estimates or Delta functions. This has the computational benefit of not having to worry about conditional dependencies between posterior densities over states and parameters. Conversely, in active inference approximate posteriors are updated over both states and parameters. This means that uncertainty about parameters nuances estimates of hidden states and vice versa. Technically, active inference schemes, in this setting, generally use some form of variational Bayes under a mean-field approximation (of which the EM algorithm can be seen as a special case). The mean-field approximation for the parameters of the transmission and emission matrices are generally parameterized in terms of Dirichlet distributions, which leads to simple update schemes that include both the uncertainty about model parameters and their expected values. Although not considered here, including uncertainty about parameters can be important in terms of optimizing exploration or searches—to minimize uncertainty about emission (i.e., likelihood) and transmission (i.e., prior) probabilities. Active inference and CSCGs adopt a probabilistic formulation that accommodates uncertainty using hierarchical priors over model parameters. This offers an avenue for further research into structure learning and planning as inference, in this setting. For example, see [^69] for an application of active inference to spatial planning, navigation, and path cells.

Elucidating how cognitive maps are represented in the hippocampus, how they are acquired from a stream of experiences, and how to utilize them for prediction and planning is not only crucial to understand the inner workings of the brain, but also offers key insights into developing agents with artificial general intelligence. The CSCG model, which we introduce in this paper, provides a plausible answer to each of these questions. We expect this model to be beneficial in both neuroscience and artificial intelligence as a way to produce explicit representations that are easy to interpret and manipulate from multimodal sequential data.

## Methods

### Expectation maximization learning of cloned HMMs

The standard algorithm to train HMMs is the EM algorithm [^70] which in this is context is known as the Baum–Welch algorithm. Cloned HMM equations require a few simple modifications with respect the HMM equations: the sparsity of the emission matrix can be exploited to only use small blocks of the transition matrix both in the E and M steps and the actions, if present, should be grouped with the next hidden state (see Fig. [1](https://www.nature.com/articles/s41467-021-22559-5#Fig1) c), to remove the loops and create a chain that is amenable to exact inference.

Learning a cloned HMM requires optimizing the vector of prior probabilities *π*: *π* <sub><i>u</i></sub>  =  *P* (*z* <sub>1</sub>  =  *u*) and the transition matrix *T*: *T* <sub><i>u</i> <i>v</i></sub>  =  *P* (*z* <sub><i>n</i>  + 1</sub>  =  *v* ∣ *z* <sub><i>n</i></sub>  =  *u*). To this end, we assume the hidden states are indexed such that all the clones of the first emission appear first, all the clones of the second emission appear next, etc. Let *E* be the total number of emitted symbols. The transition matrix *T* can then be broken down into smaller submatrices *T* (*i*, *j*), *i*, *j*  ∈ 1… *E*. The submatrix *T* (*i*, *j*) contains the transition probabilities *P* (*z* <sub><i>n</i>  + 1</sub> ∣ *z* <sub><i>n</i></sub>) for *z* <sub><i>n</i></sub>  ∈  *C* (*i*) and *z* <sub><i>n</i>  + 1</sub>  ∈  *C* (*j*) (where *C* (*i*) and *C* (*j*), respectively, correspond to the hidden states (clones) of emissions *i* and *j*).

The standard Baum–Welch equations can then be expressed in a simpler form in the case of cloned HMM. The E-step recursively computes the forward and backward probabilities and then updates the posterior probabilities. The M-step updates the transition matrix via row normalization.

**E-step**

 $\alpha \left(1\right) = \pi \left(x_{1}\right) \textrm{ } \alpha \left(n + 1\right)^{\top} = \alpha \left(n\right)^{\top} T \left(x_{n} , x_{n + 1}\right) \beta \left(N\right) = 1 \left(x_{N}\right) \textrm{ } \beta \left(n\right) = T \left(x_{n} , x_{n + 1}\right) \beta \left(n + 1\right)$ 
$$
\begin{aligned}
\alpha (1) =\pi ({x}_{1})\ \alpha {(n+1)}^{\top }=\alpha {(n)}^{\top }T({x}_{n},{x}_{n+1})\\ \beta (N) =1({x}_{N})\ \beta (n)=T({x}_{n},{x}_{n+1})\beta (n+1)
\end{aligned}
$$
 $\xi_{i j} \left(n\right) = \frac{\alpha \left(n\right) \circ T \left(i , j\right) \circ \beta \left(n + 1\right)^{\top}}{\alpha \left(n\right)^{\top} T \left(i , j\right) \beta \left(n + 1\right)} \gamma \left(n\right) = \frac{\alpha \left(n\right) \circ \beta \left(n\right)}{\alpha \left(n\right)^{\top} \beta \left(n\right)} .$ 
$$
\begin{aligned}
{\xi }_{ij}(n) =\frac{\alpha (n)\circ T(i,j)\circ \beta {(n+1)}^{\top }}{\alpha {(n)}^{\top }T(i,j)\beta (n+1)}\\ \gamma (n) =\frac{\alpha (n)\circ \beta (n)}{\alpha {(n)}^{\top }\beta (n)}.
\end{aligned}
$$

**M-step**

 $\pi \left(x_{1}\right) = \gamma \left(1\right) T \left(i , j\right) = \left(\sum_{n = 1}^{N} \xi_{i j} \left(n\right)\right) \oslash \left(\sum_{j = 1}^{E} \sum_{n = 1}^{N} \xi_{i j} \left(n\right)\right) .$ 
$$
\begin{aligned}
\pi ({x}_{1}) =\gamma (1)\\ T(i,j) =\left(\mathop{\sum }\limits_{n=1}^{N}{\xi }_{ij}(n)\right)\oslash \left(\mathop{\sum }\limits_{j=1}^{E}\mathop{\sum }\limits_{n=1}^{N}{\xi }_{ij}(n)\right).
\end{aligned}
$$

where ∘ and ⊘ denote the element-wise product and division, respectively (with broadcasting where needed). All vectors are *M*  × 1 column vectors, where *M* is the number of clones per emission. We use a constant number of clones per emission for simplicity here, but the number of clones can be selected independently per emission.

#### Computational savings

For a standard HMM with *H* hidden states, the computational cost for running one EM step on a sequence of length *N* is ${\mathcal{O}}({H}^{2}N)$ and the required memory is ${\mathcal{O}}({H}^{2}+HN)$ (for the transition matrix and forward-backward messages). In contrast, a cloned HMM exploits the sparse emission matrix: with *M* clones per emission, the computational cost is ${\mathcal{O}}({M}^{2}N)$ and the memory requirement is ${\mathcal{O}}({H}^{2}+MN)$, in the worst case. Also, there will be additional savings for every pair of symbols that never appear consecutively in the training sequence (since the corresponding submatrix of the transition matrix does not need to be stored). Memory requirements can be improved further by using the online version of EM described in the Supplementary materials.

Since *H*  =  *M* *E*, where *E* is the total number of symbols, an increase in alphabet size will increase the computation cost of HMMs, but will not affect the cost of cloned HMMs.

Intuitively, the computation advantage of cloned HMMs over HMMs comes from the sparse emission matrix structure. The sparsity pattern allows cloned HMMs to only consider a smaller submatrix of the transition matrix when performing training updates and inference, while HMMs must consider the entire transition matrix.

#### CSCG: action-augmented cloned HMM

CSCGs are an extension of cloned HMMs in which an action happens at every time step (conditional on the current hidden state) and the hidden state of the next time step depends not only on the current hidden state, but also on the current action. The probability density function is given by Eq. ([3](https://www.nature.com/articles/s41467-021-22559-5#Equ3)), and reproduced here for convenience

 $P \left(x_{1} , \ldots , x_{N} , a_{1} , \ldots , a_{N - 1}\right) = \underset{z_{1} \in C \left(x_{1}\right)}{\sum} \ldots \underset{z_{n} \in C \left(x_{n}\right)}{\sum} P \left(z_{1}\right) \prod_{n = 1}^{N - 1} P \left(z_{n + 1} , a_{n} \left|\right. z_{n}\right) ,$ 
$$
P({x}_{1},\ldots ,{x}_{N},{a}_{1},\ldots ,{a}_{N-1})=\mathop{\sum} _{{z}_{1}\in C({x}_{1})}\ldots \mathop{\sum} _{{z}_{n}\in C({x}_{n})}P({z}_{1})\mathop{\prod }\limits_{n=1}^{N-1}P({z}_{n+1},{a}_{n}| {z}_{n}),
$$

and the standard cloned HMM can be recovered by integrating out the actions. All the previous considerations about cloned HMMs apply to CSCGs and the EM equations for learning them are also very similar:

**E-step:**

 $\alpha \left(1\right) = \pi \left(x_{1}\right) \alpha \left(n + 1\right)^{\top} = \alpha \left(n\right)^{\top} T \left(x_{n} , a_{n} , x_{n + 1}\right) \beta \left(N\right) = 1 \left(x_{N}\right) \beta \left(n\right) = T \left(x_{n} , a_{n} , x_{n + 1}\right) \beta \left(n + 1\right)$ 
$$
\begin{aligned}
\alpha (1) 	=\pi ({x}_{1})\alpha {(n+1)}^{\top }=\alpha {(n)}^{\top }T({x}_{n},{a}_{n},{x}_{n+1})\\ \beta (N) 	=1({x}_{N})\beta (n)=T({x}_{n},{a}_{n},{x}_{n+1})\beta (n+1)
\end{aligned}
$$
 $\xi_{i k j} \left(n\right) = \frac{\alpha \left(n\right) \circ T \left(i , a_{n} , j\right) \circ \beta \left(n + 1\right)^{\top}}{\alpha \left(n\right)^{\top} T \left(i , a_{n} , j\right) \beta \left(n + 1\right)} \gamma \left(n\right) = \frac{\alpha \left(n\right) \circ \beta \left(n\right)}{\alpha \left(n\right)^{\top} \beta \left(n\right)} .$ 
$$
\begin{aligned}
{\xi }_{ikj}(n) 	=\frac{\alpha (n)\circ T(i,{a}_{n},j)\circ \beta {(n+1)}^{\top }}{\alpha {(n)}^{\top }T(i,{a}_{n},j)\beta (n+1)}\qquad\quad\qquad\\ \gamma (n) 	=\frac{\alpha (n)\circ \beta (n)}{\alpha {(n)}^{\top }\beta (n)}.
\end{aligned}
$$

**M-step:**

 $\pi \left(x_{1}\right) = \gamma \left(1\right) T \left(i , k , j\right) = \sum_{n = 1}^{N} \xi_{i k j} \left(n\right) \oslash \sum_{k = 1}^{N_{a}} \sum_{j = 1}^{E} \sum_{n = 1}^{N} \xi_{i k j} \left(n\right) .$ 
$$
\begin{aligned}
\pi ({x}_{1}) =\gamma (1)\\ T(i,k,j) =\mathop{\sum }\limits_{n=1}^{N}{\xi }_{ikj}(n)\oslash \mathop{\sum }\limits_{k=1}^{{N}_{a}}\mathop{\sum }\limits_{j=1}^{E}\mathop{\sum }\limits_{n=1}^{N}{\xi }_{ikj}(n).
\end{aligned}
$$

where *N* <sub><i>a</i></sub> is the number of actions and *T* (*i*, *k*, *j*) =  *P* (*z* <sub><i>n</i>  + 1</sub>, *a* <sub><i>n</i></sub>  =  *k* ∣ *z* <sub><i>n</i></sub>) for *z* <sub><i>n</i></sub>  ∈  *C* (*i*) and *z* <sub><i>n</i>  + 1</sub>  ∈  *C* (*j*), i.e., a portion of the action-augmented transition matrix.

#### Smoothing

We have observed that convergence can be improved by using a small pseudocount *κ*. A pseudocount is simply a small constant that is added to the accumulated counts statistic matrix $\mathop{\sum }\nolimits_{n = 1}^{N}{\xi }_{ikj}(n)$ and ensures that any transition under any action has non-zero probability. This ensures that at test time the model does not have zero probability for any observations stream. When the pseudocount is only used to improve convergence, one can run EM a second time with no pseudocount, warmstarting from the result of the EM with pseudocount. To use the pseudocount, we only need to change our transition matrix update to be $T(i,k,j)=(\kappa +\mathop{\sum }\nolimits_{n = 1}^{N}{\xi }_{ikj}(n))\oslash \mathop{\sum }\nolimits_{k = 1}^{{N}_{a}}\mathop{\sum }\nolimits_{j = 1}^{E}(\kappa +\mathop{\sum }\nolimits_{n = 1}^{N}{\xi }_{ikj}(n))$. The pseudocount can be interpreted as the hyperparameter of a Laplacian prior that is set on the transition matrix, and EM as solving MAP inference for such hyperparameter. As any prior, the pseudocount has a regularization effect that helps generalization when the amount of training data is small in comparison with the capacity of the model.

It might seem at first as if adding a pseudocount would destroy the block-sparse property of the transition and therefore some of the aforementioned computational advantages of the CSCG. However, it is easy to see that the resulting transition matrix can still be expressed as the sum of a block-sparse matrix (with the same sparsity pattern as before) and a rank-1 matrix (which is not stored explicitly, but as the two vectors whose outer product produce it). By doing this, the pseudocount can be used without increasing the computational complexity or the storage requirements of any of our algorithms (EM learning, inference, etc.).

#### Inference

Since the resulting model (with the action *a* <sub><i>n</i></sub> and hidden state *z* <sub><i>n</i>  + 1</sub> collapsed in a single variable) forms a chain, inference on it using belief propagation (BP) is exact. When no evidence is available for a given variable, BP will simply integrate it out, so we can for instance train a model with actions and then, at test time, use it even if no actions are available. We can still ask the model which observation is the most likely in the next time step, or even several time steps ahead, and BP will produce the exact answer by analytically integrating over all possible past and future actions, and even over the unseen future observations when necessary.

The same model can be used to generate sequences (e.g., to generate plausible observations and actions that would correspond to wandering in a previously learned room) simply by applying ancestral sampling [^71] to the conditionals that describe the model after learning (i.e., the transition and emission matrices).

A consequence of the above for spatial data is that an agent roaming the world can infer where in an environment it is located (*z* <sub><i>n</i></sub>) and then predict which actions are feasible at that location, which is useful for navigation. One can even condition on a future location to discover which set of actions can take you there, and which observations you are expected to see on the way there, see e.g., Fig. [3](https://www.nature.com/articles/s41467-021-22559-5#Fig3) b, c. This is essentially planning as inference [^35].

All of this flexible querying is performed by running a single algorithm (BP) on the same model (without retraining) and only changing the selection of which evidence is available and which probabilistic predictions are requested.

### Experimental details

#### Emergence of spatial maps from aliased sequential observations

For this experiment we collected a stream of 50,000 action-observations pairs. We learned a CSCG with 20 clones (a total of 360 states) with pseudocount 2 ⋅ 10 <sup>−3</sup> and ran EM for 1000 iterations. This gets a result that is very close to the global minimum: when Viterbi decoded, only 48 distinct states are in use, which is the theoretical optimum on a 6 × 8 grid. Viterbi training [^41] is used to refine the previous solution.

#### Transitive inference: disjoint experiences can be stitched together into a coherent whole

Figure [2](https://www.nature.com/articles/s41467-021-22559-5#Fig2) e showcases the CSCG’s ability to stitch together two disjoint room experiences when the rooms overlap. For this experiment, we randomly generate two square rooms of size 8 × 6 with 15 different observations each. We make both rooms share a 3 × 3 patch in their corners as shown in Fig. [2](https://www.nature.com/articles/s41467-021-22559-5#Fig2) e.

We sample a random walk of length 10,000 of action-observation pairs on each room, always avoiding to take actions that would make the random walk move outside of the room. We use 20 clones, which is enough to fully recover both rooms separately, and use a pseudocount of 10 <sup>−2</sup>. We run EM (on both sequences simultaneously, as two independent observations of the same CSCG) for a maximum of 100 iterations. After EM convergence, we additionally use Viterbi decoding (with no pseudocount) to remove unused clones. The learned CSCG is visualized in Fig. [2](https://www.nature.com/articles/s41467-021-22559-5#Fig2) f, showing that the two rooms that were experienced separately have been stitched together. Predictive performance on the stitching of the two rooms is perfect (indicating that learning succeeded) after a few observations required for the agent to locate itself. Notice that there is another patch in the first room that is identical to the merged patches, but was not merged. The model is using the sequential information to effectively identify patches that can be merged while respecting the observational data and context, and not simply looking for locally identical patches to merge.

#### Learned spatial maps form a reusable structure to explore similar environments

For this experiment, we train on a 6 × 8 room using 10,000 action-observation pairs. We call this Room 1, see Fig. [3](https://www.nature.com/articles/s41467-021-22559-5#Fig3) a. There are only 20 unique symbols in the room, some of which are repeated. The pseudocount is set to 10 <sup>−2</sup> and we use 20 clones (in this case, only seven clones are strictly required to memorize the room). The regularizing pressure of the pseudocount effectively removes redundant clones. Training is done using EM for a maximum of a 100 iterations. This results in an almost perfect discovery of the underlying graph. Then we set the pseudocount to 0 and continue the training using Viterbi training [^41]. This results in perfect discovery of the underlying graph with no duplicate clones. Predictions become perfect after a few initial observations required to know where in the room we are.

When we try to partially learn Room 2 with a few samples from its periphery (see Fig. [3](https://www.nature.com/articles/s41467-021-22559-5#Fig3) a), we create a new CSCG with the transition matrix that we learned from Room 1 and keep it fixed. The emission matrix is initialized uniformly and learned using EM. The whole data for learning the emission matrix are only the 20 action-observation pairs seen in Fig. [3](https://www.nature.com/articles/s41467-021-22559-5#Fig3) a. At that point, we fix the model and query it for a return path plan, both with and without blockers in the path. The results are displayed in Fig. [3](https://www.nature.com/articles/s41467-021-22559-5#Fig3) b, c.

In Fig. [3](https://www.nature.com/articles/s41467-021-22559-5#Fig3) e–g, we showcase the increase in data efficiency when we transfer the learned topology to a new room with different observations. First, we ignore the results from training on Room 1 and train on a new room, Room 2, from scratch following the same procedure outlined above. We train on the first *N* action-observation pairs and predict for the rest. We average (geometrically) the probability of getting the next observation right for the last 8000 samples of the 10,000 available. This results in the graph in Fig. [3](https://www.nature.com/articles/s41467-021-22559-5#Fig3) e, where *N* is shown in the horizontal axis. Then, we repeat the same procedure, but instead of training from scratch from a random transition matrix with fixed emissions, we fix the transition matrix that we got from training in Room 1 and we learn the emission matrix, which is initialized to uniform. EM for the emission matrix converges in a few iterations. Once all nodes have been observed (when the red curve achieves 1.0), this procedure converges to perfect predictions in one or two EM iterations. This results in the graph in Fig. [3](https://www.nature.com/articles/s41467-021-22559-5#Fig3) f, where again the horizontal axis shows *N*, the number of training action-observation pairs.

#### Representation of paths and temporal order

To learn the CSCG on the maze in Fig. [4](https://www.nature.com/articles/s41467-021-22559-5#Fig4) f, we sample 5000 paths along each of the stochastic routes that are shown. The number in each square indicates the observation received at that location, and the arrows indicate possible transitions. We consider both sequences as independently generated by the model, and run EM to optimize the probability of both simultaneously. We allocate 20 clones for each other observation. By inspecting the sum-product forward messages of BP at each step as the agent navigates the two routes, we can see the distributions over clones. We observe they are over disjoint subsets of the clones. To generate the paths from the CSCG shown in Fig. [4](https://www.nature.com/articles/s41467-021-22559-5#Fig4) g (producing only paths that are consistent with the route), we sample an observation from the normalized messages from hidden state to observation during forward message passing. Finally, to extract the communities and generate the visualization in Fig. [4](https://www.nature.com/articles/s41467-021-22559-5#Fig4) g, we run the InfoMap algorithm [^72] on the graph defined by CSCG transition matrix.

In Fig. [5](https://www.nature.com/articles/s41467-021-22559-5#Fig5), we replicate the experiments of Sun et al.[^21] as follows. First, we learned a CSCG with 20 clones per observation on a sequence of observations sampled from four laps around the maze shown in Fig. [5](https://www.nature.com/articles/s41467-021-22559-5#Fig5) d. The start and end positions were unique observations. Training was terminated when perfect learning of the underlying graph was achieved. Community detection (explained below) revealed that each sensory observation was encoded by a unique clone, akin to the chunking cells found by Sun et al.

#### Retrieval and remapping

We generate random walks (random actions out of up, right, down, left) of length 10,000 in each of five mazes. For Fig. [6](https://www.nature.com/articles/s41467-021-22559-5#Fig6) a, the mazes are 5 × 5 rooms where the observations are assigned to cells by a random permutation of the values 1–25, inclusive. For Fig. [6](https://www.nature.com/articles/s41467-021-22559-5#Fig6) b, the structure of the mazes is shown and the observations are indicated by the color of the cells. We constructed these mazes such that have many shared observations, but each has some distinct structure that differentiates it from the others.

For each of the experiments, we learn a CSCG on these random walk sequences. After learning, we sum the forward messages of sum-product BP in each maze to get a distribution over hidden states for each maze. Now on a test sequence, we can use the forward messages and these clone distributions per maze to infer the probability of being in each maze at each time step. In each of subfigure of Fig. [6](https://www.nature.com/articles/s41467-021-22559-5#Fig6), we shows these predictions as well as the distribution over clones over time.

Learning a CSCG in these maze environments can also enable error correction of noisy/corrupted observations. To correct errors in a corrupted observation sequence we modify the emission matrix to generate a random symbol with a small probability, thus modeling errors. Then we perform sum-product message passing on sequences with errors and find the most likely a posteriori value for each symbol. In our case, we only perform a forward pass, which provides an online estimation (based only on past data) of the MAP solution. We will use a corruption probability of 20% in our experiments, uniform over the incorrect symbols. For the 5 × 5 rooms, this procedure was able to correct 50 of the 55 corrupted symbols while not corrupting any of the uncorrupted symbols. For the mazes, this procedure was able to correct 46 of the 54 corrupted symbols while, again, not corrupting any of the uncorrupted symbols.

#### Community detection and hierarchical planning

In all figures, custom Python scripts were used to convert the transition matrix of the CSCG into a directed graph. This graph was then visualized using built-in functions in python-igraph ([https://igraph.org/python/](https://igraph.org/python/)). Similarly, community detection was performed using igraph’s built-in infomap function.

In the hierarchical planning experiments shown in Fig. [7](https://www.nature.com/articles/s41467-021-22559-5#Fig7), we first generated each room by drawing a random integer between 1 and 12 with repetitions to serve as observations. The rooms were then connected via bridges (observation 13, colored black) and were tiled to form a maze as shown in Fig. [7](https://www.nature.com/articles/s41467-021-22559-5#Fig7) d. Next, we trained a CSCG with 40 clones per observation using 1000 random restarts as described above. The learned CSCG achieved perfect prediction accuracy, suggesting perfect learning of the underlying graph. Community detection on the learned CSCG was performed using igraph. To form the top-level graph shown in Fig. [7](https://www.nature.com/articles/s41467-021-22559-5#Fig7) e, we collapsed each distinct community into a single node. These communities roughly corresponded to each of the rooms in the maze. In some cases, certain rooms were partitioned into multiple communities. Next, we ran community detection on this graph to retrieve the hyper-rooms.

To compute the shortest trajectory between two locations on the maze, we first computed the shortest path in the highest-level graph using Dijkstra’s algorithm, implemented in networkx ([https://networkx.github.io/](https://networkx.github.io/)). This returned the sequence of hyper-rooms and rooms to be visited in order to reach the goal from a start point. Next, we pruned the community graph to include only clones corresponding to these rooms and then found the shortest path in this reduced graph, which gave the exact sequence of observations from the start position to the goal (denoted by the black arrow in Fig. [7](https://www.nature.com/articles/s41467-021-22559-5#Fig7) d). This hierarchical approach was consistently better than searching for the shortest path on the full maze itself with an average 25% fewer steps (*n*  = 10 mazes). To determine to what extent the partitioning of the CSCG transition matrix into communities helped planning, we formed surrogate communities which no longer respected room boundaries. This resulted in a planned trajectory with an average 35% more steps than the hierarchical plan.

It is important to note that hierarchical planning is significantly more efficient. A representative example of the reduction in complexity can be given as follows. Assume that we have *V* communities, *E* inter-community edges, and *M* nodes inside each community. Further, assume that the nodes inside each community are fully connected, and between any two communities, there is at most one edge. Then with hierarchical planning the complexity of running Djikstra’s algorithm is ${\mathcal{O}}(E+V{\mathrm{log}}\,V+{N}_{t}(M(M-1)/2+M{\mathrm{log}}\,M))$, where *N* <sub><i>t</i></sub> is the number of top-level nodes to traverse in the second planning stage. In contrast, on the full graph, the complexity is ${\mathcal{O}}(E+MV{\mathrm{log}}\,MV+V(M(M-1)/2))$. From these equations, it is easy to see that hierarchical planning is more efficient because *N* <sub><i>t</i></sub>  ≤  *V* in all graphs.

### Adaptive and online EM variant of CSCGs

Although the sequences in the experiments of this work are not too large, we might want to be able deal with cases in which there is a very long incoming stream of observations, so long that we cannot even store it in its entirety. In order to handle this case, we can simply extend the previous EM algorithms to make them online.

The adaptive, online version of the EM algorithm in the “Methods” section is obtained by splitting the sequence in *B* batches *b*  = 1… *B* and performing EM steps on each batch successively. This allows the model to adapt to changes in the statistics if those happen over time. The statistics *ξ* <sub><i>i</i> <i>j</i></sub> (*n*) of batch *b* are now computed from the E-step over that batch, using the transition matrix *T* <sup>(<i>b</i> −1)</sup> from the previous batch. After processing batch *b*, we store our running statistic in *A* <sup>(<i>b</i>)</sup> as:

 $A_{i j}^{\left(b\right)} = \left(1 - \lambda\right) \sum_{k = 1}^{b} \lambda^{b - k} \underset{n \in \text{batch} \left(k\right)}{\sum} \xi_{i j} \left(n\right)$ 
$$
{A}_{ij}^{(b)}=(1-\lambda )\mathop{\sum }\limits_{k=1}^{b}{\lambda }^{b-k}\mathop{\sum} _{n\in \,\text{batch}\,(k)}{\xi }_{ij}(n)
$$

and then compute the transition matrix *T* <sup>(<i>b</i>)</sup> as:

 $T^{\left(b\right)} \left(i , j\right) = A_{i j}^{\left(b\right)} \oslash \sum_{j = 1}^{E} A_{i j}^{\left(b\right)}$ 
$$
{T}^{(b)}(i,j)={A}_{ij}^{(b)}\oslash \mathop{\sum }\limits_{j=1}^{E}{A}_{ij}^{(b)}
$$

where 0 <  *λ*  < 1 is a memory parameter and *n*  ∈ batch(*k*) refers to the time steps contained in batch *k*. For *λ*  → 1, *T* <sup>(<i>b</i>)</sup> (*i*, *j*) coincides with the transition matrix from the “Methods” section. For smaller values of *λ*, the expected counts are weighed using an exponential window (Normalization of the exponential window is unnecessary, since it will cancel when computing *T* <sup>(<i>b</i>)</sup> (*i*, *j*).), thus giving more weight to the more recent counts.

To learn from arbitrarily long sequences, we consider an online formulation and express ${A}_{ij}^{(b)}$ recursively:

 $A_{i j}^{\left(b\right)} = \lambda A_{i j}^{\left(b - 1\right)} + \left(1 - \lambda\right) \underset{n \in \text{batch} \left(b\right)}{\sum} \xi_{i j} \left(n\right) ,$ 
$$
{A}_{ij}^{(b)}=\lambda {A}_{ij}^{(b-1)}+(1-\lambda )\mathop{\sum} _{n\in \,\text{batch}\,(b)}{\xi }_{ij}(n),
$$

so that the expected counts of the last observed batch are incorporated into the running statistics.

### Reporting summary

Further information on research design is available in the [Nature Research Reporting Summary](https://www.nature.com/articles/s41467-021-22559-5#MOESM6) linked to this article.

## Data availability

All generated data are available at [https://github.com/vicariousinc/naturecomm\_cscg](https://github.com/vicariousinc/naturecomm_cscg).

## Code availability

All simulation code and plotting scripts [^73] are available at [https://github.com/vicariousinc/naturecomm\_cscg](https://github.com/vicariousinc/naturecomm_cscg).

## References

## Acknowledgements

We thank Chen Sun (MIT) for helpful discussions and the use of Fig. [5](https://www.nature.com/articles/s41467-021-22559-5#Fig5) c. We thank members of Vicarious AI for critically reading this manuscript and for insightful discussions. This work was partially supported by grant N00014-19-1-2368 from the Office of Naval Research.

## Ethics declarations

### Competing interests

The authors declare no competing interests.

## Additional information

**Peer review information** *Nature Communications* thanks Karl Friston and the other, anonymous, reviewer(s) for their contribution to the peer review of this work. Peer reviewer reports are available.

**Publisher’s note** Springer Nature remains neutral with regard to jurisdictional claims in published maps and institutional affiliations.

## Rights and permissions

**Open Access** This article is licensed under a Creative Commons Attribution 4.0 International License, which permits use, sharing, adaptation, distribution and reproduction in any medium or format, as long as you give appropriate credit to the original author(s) and the source, provide a link to the Creative Commons license, and indicate if changes were made. The images or other third party material in this article are included in the article’s Creative Commons license, unless indicated otherwise in a credit line to the material. If material is not included in the article’s Creative Commons license and your intended use is not permitted by statutory regulation or exceeds the permitted use, you will need to obtain permission directly from the copyright holder. To view a copy of this license, visit [http://creativecommons.org/licenses/by/4.0/](http://creativecommons.org/licenses/by/4.0/).

[^1]: Redish, A. D. Vicarious trial and error. *Nat. Rev. Neurosci.* **17**, 147–159 (2016).

[Article](https://doi.org/10.1038%2Fnrn.2015.30) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28XivVCisLk%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26891625) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5029271) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Vicarious%20trial%20and%20error&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn.2015.30&volume=17&pages=147-159&publication_year=2016&author=Redish%2CAD)

[^2]: Tolman, E. C. Cognitive maps in rats and men. *Psychol. Rev.* **55**, 189–208 (1948).

[Article](https://doi.org/10.1037%2Fh0061626) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaH1c%2FhsVKhsQ%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18870876) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Cognitive%20maps%20in%20rats%20and%20men&journal=Psychol.%20Rev.&doi=10.1037%2Fh0061626&volume=55&pages=189-208&publication_year=1948&author=Tolman%2CEC)

[^3]: Epstein, R. A., Patai, E. Z., Julian, J. B. & Spiers, H. J. The cognitive map in humans: spatial navigation and beyond. *Nat. Neurosci.* **20**, 1504–1513 (2017).

[Article](https://doi.org/10.1038%2Fnn.4656) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXhslansb%2FI) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29073650) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6028313) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20cognitive%20map%20in%20humans%3A%20spatial%20navigation%20and%20beyond&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.4656&volume=20&pages=1504-1513&publication_year=2017&author=Epstein%2CRA&author=Patai%2CEZ&author=Julian%2CJB&author=Spiers%2CHJ)

[^4]: Buzsáki, G. & Llinás, R. Space and time in the brain. *Science* **358**, 482–485 (2017).

[Article](https://doi.org/10.1126%2Fscience.aan8869) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2017Sci...358..482B) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29074768) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5998813) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXhslSgsb%2FI) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Space%20and%20time%20in%20the%20brain&journal=Science&doi=10.1126%2Fscience.aan8869&volume=358&pages=482-485&publication_year=2017&author=Buzs%C3%A1ki%2CG&author=Llin%C3%A1s%2CR)

[^5]: Niv, Y. Learning task-state representations. *Nat. Neurosci.* **22**, 1544–1553 (2019).

[Article](https://doi.org/10.1038%2Fs41593-019-0470-8) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXhvVCmt7vM) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31551597) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7241310) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Learning%20task-state%20representations&journal=Nat.%20Neurosci.&doi=10.1038%2Fs41593-019-0470-8&volume=22&pages=1544-1553&publication_year=2019&author=Niv%2CY)

[^6]: Moser, E. I., Kropff, E. & Moser, M.-B. Place cells, grid cells, and the brain’s spatial representation system. *Annu. Rev. Neurosci.* **31**, 69–89 (2008).

[Article](https://doi.org/10.1146%2Fannurev.neuro.31.061307.090723) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1cXpt12nsr8%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18284371) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Place%20cells%2C%20grid%20cells%2C%20and%20the%20brain%E2%80%99s%20spatial%20representation%20system&journal=Annu.%20Rev.%20Neurosci.&doi=10.1146%2Fannurev.neuro.31.061307.090723&volume=31&pages=69-89&publication_year=2008&author=Moser%2CEI&author=Kropff%2CE&author=Moser%2CM-B)

[^7]: Eichenbaum, H., Dudchenko, P., Wood, E., Shapiro, M. & Tanila, H. The hippocampus, memory, and place cells: is it spatial memory or a memory space? *Neuron* **23**, 209–226 (1999).

[Article](https://doi.org/10.1016%2FS0896-6273%2800%2980773-4) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK1MXks1Wku7k%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10399928) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20hippocampus%2C%20memory%2C%20and%20place%20cells%3A%20is%20it%20spatial%20memory%20or%20a%20memory%20space%3F&journal=Neuron&doi=10.1016%2FS0896-6273%2800%2980773-4&volume=23&pages=209-226&publication_year=1999&author=Eichenbaum%2CH&author=Dudchenko%2CP&author=Wood%2CE&author=Shapiro%2CM&author=Tanila%2CH)

[^8]: Schapiro, A. C., Turk-Browne, N. B., Norman, K. A. & Botvinick, M. M. Statistical learning of temporal community structure in the hippocampus. *Hippocampus* **26**, 3–8 (2016).

[Article](https://doi.org/10.1002%2Fhipo.22523) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26332666) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Statistical%20learning%20of%20temporal%20community%20structure%20in%20the%20hippocampus&journal=Hippocampus&doi=10.1002%2Fhipo.22523&volume=26&pages=3-8&publication_year=2016&author=Schapiro%2CAC&author=Turk-Browne%2CNB&author=Norman%2CKA&author=Botvinick%2CMM)

[^9]: Dayan, P. Improving generalization for temporal difference learning: the successor representation. *Neural Comput.* **5**, 613–624 (1993).

[Article](https://doi.org/10.1162%2Fneco.1993.5.4.613) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Improving%20generalization%20for%20temporal%20difference%20learning%3A%20the%20successor%20representation&journal=Neural%20Comput.&doi=10.1162%2Fneco.1993.5.4.613&volume=5&pages=613-624&publication_year=1993&author=Dayan%2CP)

[^10]: Stachenfeld, K. L., Botvinick, M. M. & Gershman, S. J. The hippocampus as a predictive map. *Nat. Neurosci.* **20**, 1643–1653 (2017).

[Article](https://doi.org/10.1038%2Fnn.4650) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXhsFylurrF) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28967910) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20hippocampus%20as%20a%20predictive%20map&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.4650&volume=20&pages=1643-1653&publication_year=2017&author=Stachenfeld%2CKL&author=Botvinick%2CMM&author=Gershman%2CSJ)

[^11]: Piray, P. & Daw, N. D. A common model explaining flexible decision making, grid fields and cognitive control. *bioRxiv* [https://doi.org/10.1101/856849](https://doi.org/10.1101/856849) (2019).

[^12]: Whittington, J., Muller, T., Mark, S., Barry, C. & Behrens, T. Generalisation of structural knowledge in the hippocampal-entorhinal system. In *Advances in Neural Information Processing Systems 31* (eds Bengio, S., Wallach, H., Larochelle, H., Grauman, K., Cesa-Bianchi, N. & Garnett, R.) 8484–8495 (Curran Associates, 2018a). [http://papers.nips.cc/paper/8068-generalisation-of-structural-knowledge-in-the-hippocampal-entorhinal-system.pdf](http://papers.nips.cc/paper/8068-generalisation-of-structural-knowledge-in-the-hippocampal-entorhinal-system.pdf)

[^13]: Colgin, L. L., Moser, E. I. & Moser, M.-B. Understanding memory through hippocampal remapping. *Trends Neurosci.* **31**, 469–477 (2008).

[Article](https://doi.org/10.1016%2Fj.tins.2008.06.008) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1cXhtVKnurzE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18687478) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Understanding%20memory%20through%20hippocampal%20remapping&journal=Trends%20Neurosci.&doi=10.1016%2Fj.tins.2008.06.008&volume=31&pages=469-477&publication_year=2008&author=Colgin%2CLL&author=Moser%2CEI&author=Moser%2CM-B)

[^14]: Aronov, D., Nevers, R. & Tank, D. W. Mapping of a non-spatial dimension by the hippocampal–entorhinal circuit. *Nature* **543**, 719–722 (2017).

[Article](https://doi.org/10.1038%2Fnature21692) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2017Natur.543..719A) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXltl2iu7g%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28358077) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5492514) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mapping%20of%20a%20non-spatial%20dimension%20by%20the%20hippocampal%E2%80%93entorhinal%20circuit&journal=Nature&doi=10.1038%2Fnature21692&volume=543&pages=719-722&publication_year=2017&author=Aronov%2CD&author=Nevers%2CR&author=Tank%2CDW)

[^15]: Frank, L. M., Brown, E. N. & Wilson, M. Trajectory encoding in the hippocampus and entorhinal cortex. *Neuron* **27**, 169–178 (2000).

[Article](https://doi.org/10.1016%2FS0896-6273%2800%2900018-0) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3cXls1Klsrs%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10939340) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Trajectory%20encoding%20in%20the%20hippocampus%20and%20entorhinal%20cortex&journal=Neuron&doi=10.1016%2FS0896-6273%2800%2900018-0&volume=27&pages=169-178&publication_year=2000&author=Frank%2CLM&author=Brown%2CEN&author=Wilson%2CM)

[^16]: Wood, E. R., Dudchenko, P. A., Robitsek, R. J. & Eichenbaum, H. Hippocampal neurons encode information about different types of memory episodes occurring in the same location. *Neuron* **27**, 623–633 (2000).

[Article](https://doi.org/10.1016%2FS0896-6273%2800%2900071-4) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3cXnt12ntLg%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11055443) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Hippocampal%20neurons%20encode%20information%20about%20different%20types%20of%20memory%20episodes%20occurring%20in%20the%20same%20location&journal=Neuron&doi=10.1016%2FS0896-6273%2800%2900071-4&volume=27&pages=623-633&publication_year=2000&author=Wood%2CER&author=Dudchenko%2CPA&author=Robitsek%2CRJ&author=Eichenbaum%2CH)

[^17]: Duvelle, É. et al. Insensitivity of place cells to the value of spatial goals in a two-choice flexible navigation task. *J. Neurosci.* **39**, 2522–2541 (2019).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXpslOitr4%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30696727) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6435828) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Insensitivity%20of%20place%20cells%20to%20the%20value%20of%20spatial%20goals%20in%20a%20two-choice%20flexible%20navigation%20task&journal=J.%20Neurosci.&volume=39&pages=2522-2541&publication_year=2019&author=Duvelle%2C%C3%89)

[^18]: Gauthier, J. L. & Tank, D. W. A dedicated population for reward coding in the hippocampus. *Neuron* **99**, 179–193 (2018).

[Article](https://doi.org/10.1016%2Fj.neuron.2018.06.008) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1cXht1Cju7%2FE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30008297) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7023678) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20dedicated%20population%20for%20reward%20coding%20in%20the%20hippocampus&journal=Neuron&doi=10.1016%2Fj.neuron.2018.06.008&volume=99&pages=179-193&publication_year=2018&author=Gauthier%2CJL&author=Tank%2CDW)

[^19]: Wills, T. J., Lever, C., Cacucci, F., Burgess, N. & O’Keefe, J. Attractor dynamics in the hippocampal representation of the local environment. *Science* **308**, 873–876 (2005).

[Article](https://doi.org/10.1126%2Fscience.1108905) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2005Sci...308..873W) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2MXjvVantL4%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=15879220) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2680068) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Attractor%20dynamics%20in%20the%20hippocampal%20representation%20of%20the%20local%20environment&journal=Science&doi=10.1126%2Fscience.1108905&volume=308&pages=873-876&publication_year=2005&author=Wills%2CTJ&author=Lever%2CC&author=Cacucci%2CF&author=Burgess%2CN&author=O%E2%80%99Keefe%2CJ)

[^20]: Grieves, R. M., Wood, E. R. & Dudchenko, P. A. Place cells on a maze encode routes rather than destinations. *Elife* **5**, e15986 (2016).

[Article](https://doi.org/10.7554%2FeLife.15986) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27282386) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4942257) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Place%20cells%20on%20a%20maze%20encode%20routes%20rather%20than%20destinations&journal=Elife&doi=10.7554%2FeLife.15986&volume=5&publication_year=2016&author=Grieves%2CRM&author=Wood%2CER&author=Dudchenko%2CPA)

[^21]: Sun, C., Yang, W., Martin, J. & Tonegawa, S. Ca1 pyramidal cells organize an episode by segmented and ordered events. [https://doi.org/10.1101/565689](https://doi.org/10.1101/565689) (2019).

[^22]: Cormack, G. V. & Horspool, R. N. S. Data compression using dynamic Markov modelling. *Comput. J.* **30**, 541–550 (1987).

[Article](https://doi.org/10.1093%2Fcomjnl%2F30.6.541) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Data%20compression%20using%20dynamic%20Markov%20modelling&journal=Comput.%20J.&doi=10.1093%2Fcomjnl%2F30.6.541&volume=30&pages=541-550&publication_year=1987&author=Cormack%2CGV&author=Horspool%2CRNS)

[^23]: Hawkins, J., George, D. & Niemasik, J. Sequence memory for prediction, inference and behaviour. *Philos. Trans. R. Soc. B Biol. Sci.* **364**, 1203–1209 (2009).

[Article](https://doi.org/10.1098%2Frstb.2008.0322) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Sequence%20memory%20for%20prediction%2C%20inference%20and%20behaviour&journal=Philos.%20Trans.%20R.%20Soc.%20B%20Biol.%20Sci.&doi=10.1098%2Frstb.2008.0322&volume=364&pages=1203-1209&publication_year=2009&author=Hawkins%2CJ&author=George%2CD&author=Niemasik%2CJ)

[^24]: Xu, J., Wickramarathne, T. L. & Chawla, N. V. Representing higher-order dependencies in networks. *Sci. Adv.* **2**, e1600028 (2016).

[Article](https://doi.org/10.1126%2Fsciadv.1600028) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2016SciA....2E0028X) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27386539) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4928957) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Representing%20higher-order%20dependencies%20in%20networks&journal=Sci.%20Adv.&doi=10.1126%2Fsciadv.1600028&volume=2&publication_year=2016&author=Xu%2CJ&author=Wickramarathne%2CTL&author=Chawla%2CNV)

[^25]: Cui, Y., Ahmad, S. & Hawkins, J. Continuous online sequence learning with an unsupervised neural network model. *Neural Comput.* **28**, 2474–2504 (2016).

[Article](https://doi.org/10.1162%2FNECO_a_00893) [MathSciNet](http://www.ams.org/mathscinet-getitem?mr=3866429) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27626963) [MATH](http://www.emis.de/MATH-item?07062794) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Continuous%20online%20sequence%20learning%20with%20an%20unsupervised%20neural%20network%20model&journal=Neural%20Comput.&doi=10.1162%2FNECO_a_00893&volume=28&pages=2474-2504&publication_year=2016&author=Cui%2CY&author=Ahmad%2CS&author=Hawkins%2CJ)

[^26]: Dedieu, A. et al. Learning higher-order sequential structure with cloned HMMs. [http://arxiv.org/abs/1905.00507](http://arxiv.org/abs/1905.00507) (2019).

[^27]: Sharan, V., Kakade, S. M., Liang, P. S. & Valiant, G. Learning overcomplete HMMs. In *Advances in Neural Information Processing Systems* (eds Guyon, I. et al.) 940–949 (Curran Associates, Inc., 2017).

[^28]: Palacios, E. R., Razi, A., Parr, T., Kirchhoff, M. & Friston, K. On markov blankets and hierarchical self-organisation. *J. Theor. Biol.* **486**, 110089 (2020).

[Article](https://doi.org/10.1016%2Fj.jtbi.2019.110089) [MathSciNet](http://www.ams.org/mathscinet-getitem?mr=4035008) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31756340) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7284313) [MATH](http://www.emis.de/MATH-item?1429.92037) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=On%20markov%20blankets%20and%20hierarchical%20self-organisation&journal=J.%20Theor.%20Biol.&doi=10.1016%2Fj.jtbi.2019.110089&volume=486&publication_year=2020&author=Palacios%2CER&author=Razi%2CA&author=Parr%2CT&author=Kirchhoff%2CM&author=Friston%2CK)

[^29]: Manning, C. D., Raghavan, P. & Schütze, H. *Introduction to Information Retrieval* (Cambridge University Press, 2008).

[^30]: Rao, R. P. N. Bayesian computation in recurrent neural circuits. *Neural Comput.* **16**, 1–38 (2004).

[Article](https://doi.org/10.1162%2F08997660460733976) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=15006021) [MATH](http://www.emis.de/MATH-item?1090.68090) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Bayesian%20computation%20in%20recurrent%20neural%20circuits&journal=Neural%20Comput.&doi=10.1162%2F08997660460733976&volume=16&pages=1-38&publication_year=2004&author=Rao%2CRPN)

[^31]: Skaggs, W. E. & McNaughton, B. L. Replay of neuronal firing sequences in rat hippocampus during sleep following spatial experience. *Science* **271**, 1870–1873 (1996).

[Article](https://doi.org/10.1126%2Fscience.271.5257.1870) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=1996Sci...271.1870S) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK28XhvFGms7Y%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=8596957) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Replay%20of%20neuronal%20firing%20sequences%20in%20rat%20hippocampus%20during%20sleep%20following%20spatial%20experience&journal=Science&doi=10.1126%2Fscience.271.5257.1870&volume=271&pages=1870-1873&publication_year=1996&author=Skaggs%2CWE&author=McNaughton%2CBL)

[^32]: George, D. & Hawkins, J. Towards a mathematical theory of cortical micro-circuits. *PLoS Comput. Biol.* **5**, 1–26 (2009).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1000532) [MathSciNet](http://www.ams.org/mathscinet-getitem?mr=2575029) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXhsVKltbfN) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Towards%20a%20mathematical%20theory%20of%20cortical%20micro-circuits&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1000532&volume=5&pages=1-26&publication_year=2009&author=George%2CD&author=Hawkins%2CJ)

[^33]: Nessler, B., Pfeiffer, M., Buesing, L. & Maass, W. Bayesian computation emerges in generic cortical microcircuits through spike-timing-dependent plasticity. *PLoS Comput. Biol.* **9**, 1–30 (2013).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1003037) [MathSciNet](http://www.ams.org/mathscinet-getitem?mr=3066585) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXnt1ejtrY%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Bayesian%20computation%20emerges%20in%20generic%20cortical%20microcircuits%20through%20spike-timing-dependent%20plasticity&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1003037&volume=9&pages=1-30&publication_year=2013&author=Nessler%2CB&author=Pfeiffer%2CM&author=Buesing%2CL&author=Maass%2CW)

[^34]: Whittington, J. C. R. et al. The Tolman-Eichenbaum machine: Unifying space and relational memory through generalization in the hippocampal formation. *Cell* **183**, 1249–1263 (2020).

[Article](https://doi.org/10.1016%2Fj.cell.2020.10.024) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXitlClsLnE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=33181068) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7707106) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20Tolman-Eichenbaum%20machine%3A%20Unifying%20space%20and%20relational%20memory%20through%20generalization%20in%20the%20hippocampal%20formation&journal=Cell&doi=10.1016%2Fj.cell.2020.10.024&volume=183&pages=1249-1263&publication_year=2020&author=Whittington%2CJCR)

[^35]: Attias, H. Planning by probabilistic inference. *AISTATS* (2003).

[^36]: Morton, N. W., Sherrill, K. R. & Preston, A. R. Memory integration constructs maps of space, time, and concepts. *Curr. Opin. Behav. Sci.* **17**, 161–168 (2017).

[Article](https://doi.org/10.1016%2Fj.cobeha.2017.08.007) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28924579) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5600494) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Memory%20integration%20constructs%20maps%20of%20space%2C%20time%2C%20and%20concepts&journal=Curr.%20Opin.%20Behav.%20Sci.&doi=10.1016%2Fj.cobeha.2017.08.007&volume=17&pages=161-168&publication_year=2017&author=Morton%2CNW&author=Sherrill%2CKR&author=Preston%2CAR)

[^37]: Behrens, T. E. J. et al. What is a cognitive map? organizing knowledge for flexible behavior. *Neuron* **100**, 490–509 (2018).

[Article](https://doi.org/10.1016%2Fj.neuron.2018.10.002) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1cXitVSisrnK) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30359611) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=What%20is%20a%20cognitive%20map%3F%20organizing%20knowledge%20for%20flexible%20behavior&journal=Neuron&doi=10.1016%2Fj.neuron.2018.10.002&volume=100&pages=490-509&publication_year=2018&author=Behrens%2CTEJ)

[^38]: Baraduc, P., Duhamel, J.-R. & Wirth, S. Schema cells in the macaque hippocampus. *Science* **363**, 635–639 (2019).

[Article](https://doi.org/10.1126%2Fscience.aav5404) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2019Sci...363..635B) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXisFyjsLc%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30733419) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Schema%20cells%20in%20the%20macaque%20hippocampus&journal=Science&doi=10.1126%2Fscience.aav5404&volume=363&pages=635-639&publication_year=2019&author=Baraduc%2CP&author=Duhamel%2CJ-R&author=Wirth%2CS)

[^39]: Barry, C. et al. The boundary vector cell model of place cell firing and spatial memory. *Rev. Neurosci.* **17**, 71–97 (2006).

[Article](https://doi.org/10.1515%2FREVNEURO.2006.17.1-2.71) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=16703944) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2677716) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20boundary%20vector%20cell%20model%20of%20place%20cell%20firing%20and%20spatial%20memory&journal=Rev.%20Neurosci.&doi=10.1515%2FREVNEURO.2006.17.1-2.71&volume=17&pages=71-97&publication_year=2006&author=Barry%2CC)

[^40]: Blum, K. I. & Abbott, L. F. A model of spatial map formation in the hippocampus of the rat. *Neural Comput.* **8**, 85–93 (1996).

[Article](https://doi.org/10.1162%2Fneco.1996.8.1.85) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK287jslWkug%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=8564805) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20model%20of%20spatial%20map%20formation%20in%20the%20hippocampus%20of%20the%20rat&journal=Neural%20Comput.&doi=10.1162%2Fneco.1996.8.1.85&volume=8&pages=85-93&publication_year=1996&author=Blum%2CKI&author=Abbott%2CLF)

[^41]: Jelinek, F. Continuous speech recognition by statistical methods. *Proc. IEEE* **64**, 532–556 (1976).

[Article](https://doi.org/10.1109%2FPROC.1976.10159) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Continuous%20speech%20recognition%20by%20statistical%20methods&journal=Proc.%20IEEE&doi=10.1109%2FPROC.1976.10159&volume=64&pages=532-556&publication_year=1976&author=Jelinek%2CF)

[^42]: Alme, C. B. et al. Place cells in the hippocampus: eleven maps for eleven rooms. *Proc. Natl Acad. Sci. USA* **111**, 18428–18435 (2014).

[Article](https://doi.org/10.1073%2Fpnas.1421056111) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2014PNAS..11118428A) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXitVClu7jK) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25489089) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4284589) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Place%20cells%20in%20the%20hippocampus%3A%20eleven%20maps%20for%20eleven%20rooms&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.1421056111&volume=111&pages=18428-18435&publication_year=2014&author=Alme%2CCB)

[^43]: Lever, C., Wills, T., Cacucci, F., Burgess, N. & O’Keefe, J. Long-term plasticity in hippocampal place-cell representation of environmental geometry. *Nature* **416**, 90–94 (2002).

[Article](https://doi.org/10.1038%2F416090a) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2002Natur.416...90L) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD38Xitlaisrw%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11882899) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Long-term%20plasticity%20in%20hippocampal%20place-cell%20representation%20of%20environmental%20geometry&journal=Nature&doi=10.1038%2F416090a&volume=416&pages=90-94&publication_year=2002&author=Lever%2CC&author=Wills%2CT&author=Cacucci%2CF&author=Burgess%2CN&author=O%E2%80%99Keefe%2CJ)

[^44]: Latuske, P., Kornienko, O., Kohler, L. & Allen, K. Hippocampal remapping and its entorhinal origin. *Front. Behav. Neurosci.* **11**, 253 (2018).

[Article](https://doi.org/10.3389%2Ffnbeh.2017.00253) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29354038) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5758554) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Hippocampal%20remapping%20and%20its%20entorhinal%20origin&journal=Front.%20Behav.%20Neurosci.&doi=10.3389%2Ffnbeh.2017.00253&volume=11&publication_year=2018&author=Latuske%2CP&author=Kornienko%2CO&author=Kohler%2CL&author=Allen%2CK)

[^45]: Sosa, M., Gillespie, A. K. & Frank, L. M. Neural activity patterns underlying spatial coding in the hippocampus. In *Behavioral Neuroscience of Learning and Memory* (eds Clark, R. E. & Martin, S.) 43–100 (Springer, 2016).

[^46]: Leutgeb, J. K. et al. Progressive transformation of hippocampal neuronal representations in “morphed” environments. *Neuron* **48**, 345–358 (2005).

[Article](https://doi.org/10.1016%2Fj.neuron.2005.09.007) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2MXhtF2iur7L) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=16242413) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Progressive%20transformation%20of%20hippocampal%20neuronal%20representations%20in%20%E2%80%9Cmorphed%E2%80%9D%20environments&journal=Neuron&doi=10.1016%2Fj.neuron.2005.09.007&volume=48&pages=345-358&publication_year=2005&author=Leutgeb%2CJK)

[^47]: Balaguer, J., Spiers, H., Hassabis, D. & Summerfield, C. Neural mechanisms of hierarchical planning in a virtual subway network. *Neuron* **90**, 893–903 (2016).

[Article](https://doi.org/10.1016%2Fj.neuron.2016.03.037) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28Xotlehsbw%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27196978) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4882377) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20mechanisms%20of%20hierarchical%20planning%20in%20a%20virtual%20subway%20network&journal=Neuron&doi=10.1016%2Fj.neuron.2016.03.037&volume=90&pages=893-903&publication_year=2016&author=Balaguer%2CJ&author=Spiers%2CH&author=Hassabis%2CD&author=Summerfield%2CC)

[^48]: Tomov, M. S., Yagati, S., Kumar, A., Yang, W. & Gershman, S. J. Discovery of hierarchical representations for efficient planning. *PLoS Comput. Biol.* **16**, e1007594 (2020).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1007594) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2020PLSCB..16E7594T) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXhtFajtr3P) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32251444) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7162548) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Discovery%20of%20hierarchical%20representations%20for%20efficient%20planning&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1007594&volume=16&publication_year=2020&author=Tomov%2CMS&author=Yagati%2CS&author=Kumar%2CA&author=Yang%2CW&author=Gershman%2CSJ)

[^49]: Bohlin, L., Edler, D., Lancichinetti, A. & Rosvall, M. Community detection and visualization of networks with the map equation framework. In *Measuring Scholarly Impact* (eds Ding, Y., Rousseau, R. & Wolfram, D.) 3–34 (Springer, 2014).

[^50]: Zhang, P. & Moore, C. Scalable detection of statistically significant communities and hierarchies, using message passing for modularity. *Proc. Natl Acad. Sci. USA* **111**, 18144–18149 (2014).

[Article](https://doi.org/10.1073%2Fpnas.1409770111) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2014PNAS..11118144Z) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXitVClu7nJ) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25489096) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4280643) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Scalable%20detection%20of%20statistically%20significant%20communities%20and%20hierarchies%2C%20using%20message%20passing%20for%20modularity&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.1409770111&volume=111&pages=18144-18149&publication_year=2014&author=Zhang%2CP&author=Moore%2CC)

[^51]: Parr, T., Markovic, D., Kiebel, S. J. & Friston, K. J. Neuronal message passing using mean-field, bethe, and marginal approximations. *Sci. Rep.* **9**, 1–18 (2019).

[Article](https://doi.org/10.1038%2Fs41598-018-38246-3) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXnslegurg%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neuronal%20message%20passing%20using%20mean-field%2C%20bethe%2C%20and%20marginal%20approximations&journal=Sci.%20Rep.&doi=10.1038%2Fs41598-018-38246-3&volume=9&pages=1-18&publication_year=2019&author=Parr%2CT&author=Markovic%2CD&author=Kiebel%2CSJ&author=Friston%2CKJ)

[^52]: Buzsáki, G. & Tingley, D. Space and time: the hippocampus as a sequence generator. *Trends Cogn. Sci.* **22**, 853–869 (2018).

[Article](https://doi.org/10.1016%2Fj.tics.2018.07.006) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30266146) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6166479) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Space%20and%20time%3A%20the%20hippocampus%20as%20a%20sequence%20generator&journal=Trends%20Cogn.%20Sci.&doi=10.1016%2Fj.tics.2018.07.006&volume=22&pages=853-869&publication_year=2018&author=Buzs%C3%A1ki%2CG&author=Tingley%2CD)

[^53]: Schuck, N. W. & Niv, Y. Sequential replay of nonspatial task states in the human hippocampus. *Science* **364**, eaaw5181 (2019).

[Article](https://doi.org/10.1126%2Fscience.aaw5181) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2019Sci...364.5181S) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXhtlWjt7nE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31249030) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7241311) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Sequential%20replay%20of%20nonspatial%20task%20states%20in%20the%20human%20hippocampus&journal=Science&doi=10.1126%2Fscience.aaw5181&volume=364&publication_year=2019&author=Schuck%2CNW&author=Niv%2CY)

[^54]: Whittington, J., Muller, T., Mark, S., Barry, C. & Behrens, T. Generalisation of structural knowledge in the hippocampal-entorhinal system. In *Advances in Neural Information Processing Systems* (eds Bengio, S. et al.) 8484–8495 (Curran Associates, Inc., 2018b).

[^55]: Momennejad, I. et al. The successor representation in human reinforcement learning. *Nat. Hum. Behav.* **1**, 680–692 (2017).

[Article](https://doi.org/10.1038%2Fs41562-017-0180-8) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BB3M%2Fptleitw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31024137) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6941356) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20successor%20representation%20in%20human%20reinforcement%20learning&journal=Nat.%20Hum.%20Behav.&doi=10.1038%2Fs41562-017-0180-8&volume=1&pages=680-692&publication_year=2017&author=Momennejad%2CI)

[^56]: Momennejad, I. & Howard, M. W. Predicting the future with multi-scale successor representations. *bioRxiv* [https://doi.org/10.1101/449470](https://doi.org/10.1101/449470) (2018).

[^57]: Mok, R. M. & Love, B. C. A non-spatial account of place and grid cells based on clustering models of concept learning. *Nat. Comm.* **10**, 1–9 (2019).

[Article](https://doi.org/10.1038%2Fs41467-019-13760-8) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXitlynur7O) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20non-spatial%20account%20of%20place%20and%20grid%20cells%20based%20on%20clustering%20models%20of%20concept%20learning&journal=Nat.%20Comm.&doi=10.1038%2Fs41467-019-13760-8&volume=10&pages=1-9&publication_year=2019&author=Mok%2CRM&author=Love%2CBC)

[^58]: Rikhye, R. V, Guntupalli, J. S., Gothoskar, N., Lázaro-Gredilla, M. & George, D. V. Memorize-generalize: an online algorithm for learning higher-order sequential structure with cloned hidden markov models. *bioRxiv* [https://doi.org/10.1101/764456](https://doi.org/10.1101/764456) (2019).

[^59]: Kansky, K. et al. Schema networks: zero-shot transfer with a generative causal model of intuitive physics. *Proceedings of the 34th International Conference on Machine Learning, Vol. 70*, 1809–1818 (2017).

[^60]: Holmes, M. P. et al. Schema learning: experience-based construction of predictive action models. In *Advances in Neural Information Processing Systems* (eds Saul, L., Weiss, Y. & Bottou, L.) 585–592 (MIT Press, 2005).

[^61]: Howard, M. W. & Eichenbaum, H. The hippocampus, time, and memory across scales. *J. Exp. Psychol. Gen.* **142**, 1211–1230 (2013).

[Article](https://doi.org/10.1037%2Fa0033621) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23915126) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3982793) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20hippocampus%2C%20time%2C%20and%20memory%20across%20scales&journal=J.%20Exp.%20Psychol.%20Gen.&doi=10.1037%2Fa0033621&volume=142&pages=1211-1230&publication_year=2013&author=Howard%2CMW&author=Eichenbaum%2CH)

[^62]: Summerfield, C., Luyckx, F. & Sheahan, H. Structure learning and the posterior parietal cortex. *Prog. Neurobiol.* **184**, 101717 (2019).

[^63]: Wilson, R. C., Takahashi, Y. K., Schoenbaum, G. & Niv, Y. Orbitofrontal cortex as a cognitive map of task space. *Neuron* **81**, 267–279 (2014).

[Article](https://doi.org/10.1016%2Fj.neuron.2013.11.005) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXht1Glsb4%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24462094) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4001869) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Orbitofrontal%20cortex%20as%20a%20cognitive%20map%20of%20task%20space&journal=Neuron&doi=10.1016%2Fj.neuron.2013.11.005&volume=81&pages=267-279&publication_year=2014&author=Wilson%2CRC&author=Takahashi%2CYK&author=Schoenbaum%2CG&author=Niv%2CY)

[^64]: George, D. et al. A generative vision model that trains with high data efficiency and breaks text-based CAPTCHAs. *Science* **358**, eaag2612 (2017).

[Article](https://doi.org/10.1126%2Fscience.aag2612) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29074582) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXhvFWht7jN) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20generative%20vision%20model%20that%20trains%20with%20high%20data%20efficiency%20and%20breaks%20text-based%20CAPTCHAs&journal=Science&doi=10.1126%2Fscience.aag2612&volume=358&publication_year=2017&author=George%2CD)

[^65]: Gershman, S. J. The successor representation: its computational logic and neural substrates. *J. Neurosci.* **38**, 7193–7200 (2018).

[Article](https://doi.org/10.1523%2FJNEUROSCI.0151-18.2018) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1cXit1GjtLvE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30006364) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6096039) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20successor%20representation%3A%20its%20computational%20logic%20and%20neural%20substrates&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.0151-18.2018&volume=38&pages=7193-7200&publication_year=2018&author=Gershman%2CSJ)

[^66]: Lázaro-Gredilla, M., Lin, D., Guntupalli, J. S. & George, D. Beyond imitation: Zero-shot task transfer on robots by learning concepts as cognitive programs. *Sci Robot* **4**, eaav3150 (2019).

[^67]: Saleem, A. B., Ayaz, A., Jeffery, K. J., Harris, K. D. & Carandini, M. Integration of visual motion and locomotion in mouse visual cortex. *Nat. Neurosci.* **16**, 1864–1869 (2013).

[Article](https://doi.org/10.1038%2Fnn.3567) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXhslWju7%2FP) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24185423) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3926520) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Integration%20of%20visual%20motion%20and%20locomotion%20in%20mouse%20visual%20cortex&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.3567&volume=16&pages=1864-1869&publication_year=2013&author=Saleem%2CAB&author=Ayaz%2CA&author=Jeffery%2CKJ&author=Harris%2CKD&author=Carandini%2CM)

[^68]: Pezzulo, G., Cartoni, E., Rigoli, F., Pio-Lopez, L. & Friston, K. Active inference, epistemic value, and vicarious trial and error. *Learn. Mem.* **23**, 322–338 (2016).

[Article](https://doi.org/10.1101%2Flm.041780.116) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27317193) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4918783) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Active%20inference%2C%20epistemic%20value%2C%20and%20vicarious%20trial%20and%20error&journal=Learn.%20Mem.&doi=10.1101%2Flm.041780.116&volume=23&pages=322-338&publication_year=2016&author=Pezzulo%2CG&author=Cartoni%2CE&author=Rigoli%2CF&author=Pio-Lopez%2CL&author=Friston%2CK)

[^69]: Kaplan, R. & Friston, K. J. Planning and navigation as active inference. *Biol. Cybernet.* **112**, 323–343 (2018).

[Article](https://link.springer.com/doi/10.1007/s00422-018-0753-2) [MathSciNet](http://www.ams.org/mathscinet-getitem?mr=3827213) [MATH](http://www.emis.de/MATH-item?1400.92607) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Planning%20and%20navigation%20as%20active%20inference&journal=Biol.%20Cybernet.&doi=10.1007%2Fs00422-018-0753-2&volume=112&pages=323-343&publication_year=2018&author=Kaplan%2CR&author=Friston%2CKJ)

[^70]: Wu, C. F. J. et al. On the convergence properties of the em algorithm. *Annals Stat.* **11**, 95–103 (1983).

[Article](https://doi.org/10.1214%2Faos%2F1176346060) [MathSciNet](http://www.ams.org/mathscinet-getitem?mr=684867) [MATH](http://www.emis.de/MATH-item?0517.62035) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=On%20the%20convergence%20properties%20of%20the%20em%20algorithm&journal=Annals%20Stat.&doi=10.1214%2Faos%2F1176346060&volume=11&pages=95-103&publication_year=1983&author=Wu%2CCFJ)

[^71]: Bishop, C. M. *Pattern Recognition and Machine Learning* (Springer, 2006).

[^72]: Rosvall, M. & Bergstrom, C. T. Maps of random walks on complex networks reveal community structure. *Proc. Natl Acad. Sci. USA* **105**, 1118–1123 (2008).

[Article](https://doi.org/10.1073%2Fpnas.0706851105) [ADS](http://adsabs.harvard.edu/cgi-bin/nph-data_query?link_type=ABSTRACT&bibcode=2008PNAS..105.1118R) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1cXhslSru7Y%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18216267) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2234100) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Maps%20of%20random%20walks%20on%20complex%20networks%20reveal%20community%20structure&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.0706851105&volume=105&pages=1118-1123&publication_year=2008&author=Rosvall%2CM&author=Bergstrom%2CCT)

[^73]: George, D. et al. Code for learning clone-structured cognitive maps. [https://doi.org/10.5281/zenodo.4609454](https://doi.org/10.5281/zenodo.4609454) (2021).

[^74]: Ginther, M. R., Walsh, D. F. & Ramus, S. J. Hippocampal neurons encode different episodes in an overlapping sequence of odors task. *J. Neurosci.* **31**, 2706–2711 (2011).

[Article](https://doi.org/10.1523%2FJNEUROSCI.3413-10.2011) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3MXisFKmu7w%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21325539) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3047458) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Hippocampal%20neurons%20encode%20different%20episodes%20in%20an%20overlapping%20sequence%20of%20odors%20task&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.3413-10.2011&volume=31&pages=2706-2711&publication_year=2011&author=Ginther%2CMR&author=Walsh%2CDF&author=Ramus%2CSJ)