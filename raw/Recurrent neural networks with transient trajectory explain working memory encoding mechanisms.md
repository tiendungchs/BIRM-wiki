---
title: "Recurrent neural networks with transient trajectory explain working memory encoding mechanisms"
source: "https://www.nature.com/articles/s42003-024-07282-3"
author:
  - "[[Chenghao Liu]]"
  - "[[Shuncheng Jia]]"
  - "[[Hongxing Liu]]"
  - "[[Xuanle Zhao]]"
  - "[[Chengyu T. Li]]"
  - "[[Bo Xu]]"
  - "[[Tielin Zhang]]"
published: 2025-01-28
created: 2026-06-19
description: "Whether working memory (WM) is encoded by persistent activity using attractors or by dynamic activity using transient trajectories has been debated for decades in both experimental and modeling studies, and a consensus has not been reached. Even though many recurrent neural networks (RNNs) have been proposed to simulate WM, most networks are designed to match respective experimental observations and show either transient or persistent activities. Those few which consider networks with both activity patterns have not attempted to directly compare their memory capabilities. In this study, we build transient-trajectory-based RNNs (TRNNs) and compare them to vanilla RNNs with more persistent activities. The TRNN incorporates biologically plausible modifications, including self-inhibition, sparse connection and hierarchical topology. Besides activity patterns resembling animal recordings and retained versatility to variable encoding time, TRNNs show better performance in delayed choice and spatial memory reinforcement learning tasks. Therefore, this study provides evidence supporting the transient activity theory to explain the WM mechanism from the model designing point of view. Modifying recurrent neural networks to encode working memory with transient trajectory leads to higher performance in simulated tasks, supporting the transient activity theory as a working memory mechanism from the model design point of view."
tags:
  - "clippings"
---
## Abstract

Whether working memory (WM) is encoded by persistent activity using attractors or by dynamic activity using transient trajectories has been debated for decades in both experimental and modeling studies, and a consensus has not been reached. Even though many recurrent neural networks (RNNs) have been proposed to simulate WM, most networks are designed to match respective experimental observations and show either transient or persistent activities. Those few which consider networks with both activity patterns have not attempted to directly compare their memory capabilities. In this study, we build transient-trajectory-based RNNs (TRNNs) and compare them to vanilla RNNs with more persistent activities. The TRNN incorporates biologically plausible modifications, including self-inhibition, sparse connection and hierarchical topology. Besides activity patterns resembling animal recordings and retained versatility to variable encoding time, TRNNs show better performance in delayed choice and spatial memory reinforcement learning tasks. Therefore, this study provides evidence supporting the transient activity theory to explain the WM mechanism from the model designing point of view.

## Introduction

Working memory (WM) is an important cognitive ability that allows animals to hold limited key information to be used in the near future. It is essential for many other cognitive abilities, including learning, reasoning, and decision-making [^1]. One particularly interesting question about working memory is how the short-term memory content is maintained after the sensory stimulus ends. Early biological experiments showed persistent neuronal activities during delay periods [^2] [^3], which have inspired recurrent neural networks (RNNs) that support context-depend output [^4] to simulate attractor-type WM, attributing the memory maintenance to the attractor state of the network dynamics [^5] [^6].

However, further studies found transient-trajectory type dynamics in delay periods of biological neurons, and the number of these transient neurons is surprisingly larger than that of the attractor-type neurons [^7] [^8] [^9] [^10]. Therefore, various alternative theories of WM maintenance have been proposed. Some proposed that population coding through stable subspace states is important for static WM maintenance with varying neuronal activities [^11] [^12]. Some other studies proposed that chaotic network activities could keep the memories of different stimuli separable over time [^13] [^14]. Another prominent theory proposed that oscillation and phase coding encode short-term memories [^15] [^16] [^17]. Besides these activity-based memory encoding theories, activity-silent states through short-term synaptic plasticity were also hypothesized to be able to hold WM [^18] [^19] [^20] [^21]. Another line of research observed that transient activities of individual neurons could tile together to span the entire delay period [^22] [^23] [^24] [^25], supported by some related theoretical studies indicating that the transient trajectory is a special form of heteroclinic orbits between saddle fixed points to encode stimuli and last beyond the stimulation duration [^26] [^27] [^28].

At the same time, more RNNs were trained in working memory tasks and showed transient activities [^14] [^29] [^30] [^31] [^32] [^33]. Some studies observed transient activities in trained RNNs and thus they focused on studying how the memory is encoded. Some found it encoded with robust trajectories [^29] while others found it encoded with amplitude of the transient oscillation [^31]. Other studies focused on how to replicate the transient activity patterns from recordings. Barak et al. compared three types of models and showed both reservoir network and the partially trained RNN could match some features of the data [^14]. Rajan et al. found that the neural activity pattern could take the form of a line attractor or transient trajectory, depending on the connection parameters of the circuit mechanism [^32]. Orhan et al. showed that the change between these two patterns could be continuous in RNNs depending on the network parameters and tasks [^33]. However, whether keeping memory with transient trajectory or persistent activity provides better performance in working memory tasks is still an open question, because few studies have simulated WM task to discuss their capabilities such as memory capacity and energy efficiency.

Here we based our tests and model design on a previous mouse working memory study, where neural activities were recorded form mice performing the olfactory delayed paired association task (ODPA). Brain-wide activity waves were found to encode transient-type WM patterns, where sequentially coactivated chains and loops of neurons were identified, and coupled spikes were hierarchically organized [^34].

To build models to represent the transient trajectory encoding with adjustable configurations that control the activity patterns, we modified the vanilla RNN to enforce transient activities. The resulting transient RNN (TRNN) contains self-inhibiting transient neurons, sparse connection, and hierarchical topology matching the sensory-association-motor connectome. The self-inhibition modification is similar to the negative feedback design based on the spike-frequency adaptation (SFA) mechanism that was used to induce traveling waves in computational models [^35] [^36] [^37]. This mechanism implemented in the form of adaptive firing thresholds is also introduced to a spiking RNN to enhance its performance in sequence tasks by encoding the memory in the thresholds [^38] [^39] [^40].

Unlike previous RNN modeling studies, we kept the vanilla RNN and the TRNN in separated groups in our analyses and combined the results that match the modeling data to the experimental recordings and the results that show performance advantages of transient trajectory encoding models. We first analyzed the activities patterns of the vanilla RNN and TRNN and found the TRNN matched the transient activity from animal recordings better qualitatively, while the vanilla RNN had more persistent activity. This makes them good representative models to compare the two working memory mechanism theories. Then we showed that even with transient trajectory encoding, TRNN is still versatile in terms of memory time. The activity dynamics were also analyzed in the form of low-dimensional trajectories to help explain how memory is encoded. Further analysis of the activities showed higher information richness and lower average squared activity of TRNN compared to a vanilla RNN using persistently firing neurons, suggesting a higher memory capacity and lower energy cost. Then we compared the size-matched networks in a range of simple WM tasks that simulated animal experiments, including delayed choice experiments and spatial memory experiments [^41], using reinforcement learning [^42], and got better performances with TRNNs. The closer activity patterns to animal recordings and better performances of TRNNs support transient trajectory as a working memory encoding mechanism.

## Results

### Reproduce transient trajectory in neural activity pattern with TRNNs

In the previous ODPA experiment (Fig. [1a](https://www.nature.com/articles/s42003-024-07282-3#Fig1)), extracellular Neuropixel recordings were done in over 30 mouse brain regions (Fig. [1b](https://www.nature.com/articles/s42003-024-07282-3#Fig1)). A total of 33,208 neurons were collected from 113 recording sessions [^34]. To study the transient trajectory observed in animal working memory experiments using computational models, we designed stimulated ODPA experiment as a task to train and test the models. Briefly, the ODPA task is composed of fixation period, a sample period, a delay period, a test period and a response period. The animal is rewarded for licking during the response period when the odor received during the sample period and the test period is a matching pair. Since the animal’s action would not change the stimuli, the experiment was simulated with fixed sequences of input-output pairs as a supervised learning task (see “Methods” for more details about the animal experiment and the simulated versions of the task).

![Fig. 1: Transient activities examined in animal experiments and computational model.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs42003-024-07282-3/MediaObjects/42003_2024_7282_Fig1_HTML.png?as=webp)

Fig. 1: Transient activities examined in animal experiments and computational model.

We started with vanilla RNNs that have been commonly used in working memory modeling studies. Examining the details of previous studies showed that different kinds of network architectures, such as reservoir network and vanilla RNN, had been used. The studies also used different network sizes, neuronal nonlinearity and optimizing methods (Supplementary Table [1](https://www.nature.com/articles/s42003-024-07282-3#MOESM2)) [^14] [^29] [^30] [^32] [^33] [^43] [^44]. We chose a vanilla RNN architecture with ReLU nonlinearity and the backpropagation for optimization. To make the network more biologically plausible, we also initialized its recurrent connection weights according to a 4:1 composition ratio of excitatory and inhibitory neurons [^45]. Besides, we added regularization to the average neuronal activity during training to keep the neuronal activities stable. In practice, these two features were also important for the training of the models. When the neuronal activities were plotted, variability between models with different initializations could be observed (Fig. [1e](https://www.nature.com/articles/s42003-024-07282-3#Fig1), Supplementary Fig. [1b](https://www.nature.com/articles/s42003-024-07282-3#MOESM2)), as shown in the previous study [^33].

To compare these to neuronal activities from animal experiments, we analyzed data shared with us by our collaborators collected in their recent work [^34]. The activities also have some variance between recording sessions (Fig. [1d](https://www.nature.com/articles/s42003-024-07282-3#Fig1), Supplementary Fig. [1a](https://www.nature.com/articles/s42003-024-07282-3#MOESM2)). The results from the animal experiments seem to have a clearer sequence of transient activities during the delay periods than those of the RNNs. To quantify this difference, we proposed the transient index (TI, Fig. [1c](https://www.nature.com/articles/s42003-024-07282-3#Fig1)), which extended the previous sequential index [^33] and contained three key components. The first component was the synchrony of the firing rate peaks of participating neurons measured as Shannon entropy (peak-firing-time entropy). The time of the firing rate peak was treated as a random variable and each neuron is a sample. The Shannon entropy measured how variable this peak time was and thus measured how synchronized the samples/neurons were. The second component, ridge-to-background ratio, described the persistency of the neuronal firing by measuring how sharp the firing rate peak was for each neuron [^24]. Neurons with sharper peaks were less persistent. The third component was the proportion of memory-related peak firing and measured the proportion of transient trajectory encoding neurons whose peak activities are in the delay period. This ensured that the firing rate peaks we examined were in the delay period and likely encoding working memories. Finally, three components were summed up to TI, which should be high for neuron activity peaks that tile and overlap the delay period. We found that RNNs indeed had much lower TIs than the animal neural networks (Fig. [1h](https://www.nature.com/articles/s42003-024-07282-3#Fig1)).

To increase the TI and better replicate the transient dynamics of in vivo working memory encoding, we introduced a transient encoding modification to the basic model to get the TRNN (Fig. [1g](https://www.nature.com/articles/s42003-024-07282-3#Fig1)). The transient encoding modification is composed of three parts. First, at the neuronal scale, it endowed the neuron with an additional self-inhibition input proportional to its past activity. Since connectivity constraint is another common way to modify RNNs, sparse connections were enforced at the network-connection scale [^45]. This was proposed because persistent firing in attractor models relied on strong recurrent connections [^5] [^6]. Third, the RNN was divided into three functional regions, sensory, association, and motor regions, congruent to the pathway found in natural neural networks [^34]. Inter-region connections were sparser than intra-region connections, based on the finding that there are more spike coupling events within brain regions than between [^34]. Compared to sparsity enforcement, self-inhibition targeted neurons with high activities more specifically and could be more effective at stopping persistent firing in neurons with slow dynamics. As expected, the activity dynamics of the TRNNs resemble that of the animal neural networks, and the TIs of the TRNNs are significantly higher than the RNNs (Fig. [1f, h](https://www.nature.com/articles/s42003-024-07282-3#Fig1)). Since TRNN and RNN have the same number of learnable parameters but are different in activity patterns during memory encoding, in the following experiments, we could compare TRNNs to RNNs to study the advantages of the transient encoding mechanism.

The TRNN’s resemblance to the experimental results was further analyzed. We firstly focused on odor-selective neurons that exhibited statistically-significant selection to specific odors (Fig. [2a](https://www.nature.com/articles/s42003-024-07282-3#Fig2), “Methods”) [^34]. The proportion of stimulus selective neurons in the transient RNN reached a proportion of 38.2% (Fig. [2b](https://www.nature.com/articles/s42003-024-07282-3#Fig2)), close to the statistical result of biological experiments (32.6%, Fig. [2c](https://www.nature.com/articles/s42003-024-07282-3#Fig2)). Similar to the observation in the brain recording experiments, we found neurons that were selective to one of the odors at different phases during the delay periods (Supplementary Fig. [2a](https://www.nature.com/articles/s42003-024-07282-3#MOESM2)). We ranked all the neurons based on the time of their peak response differences in the two odors, plotted the differences in their firing rate (Supplementary Fig. [2b](https://www.nature.com/articles/s42003-024-07282-3#MOESM2)), and found that the selectivity also has a transient trajectory pattern. It was found in the biological experiment that the proportion of selective neurons has a negative correlation with the sensory-motor index, the ratio between the output strength to the motor cortex M1 and the input strength from the olfactory bulb, of the corresponding brain region (Fig. [2d](https://www.nature.com/articles/s42003-024-07282-3#Fig2)). As a comparison, a similar trend was also identified in our simulated ODPA task using the TRNN model (Fig. [2e](https://www.nature.com/articles/s42003-024-07282-3#Fig2)). As an extension to the biology experiments, we varied the magnitudes of differences between the two odor stimuli and tested the accuracies of the models. The performance plotted against the differences could be fitted with a logistic psychometric function with a log-likelihood of −18.25 (Supplementary Fig. [2c](https://www.nature.com/articles/s42003-024-07282-3#MOESM2)).

![Fig. 2: Comparison of biological discovery and artificial modeling.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs42003-024-07282-3/MediaObjects/42003_2024_7282_Fig2_HTML.png?as=webp)

Fig. 2: Comparison of biological discovery and artificial modeling.

### TRNN maintains memory for a variable amount of time

With the memory encoded in stable attractor activities, the vanilla RNN should be able to keep memory for an arbitrary amount of time. On the other hand, since the memory-related neuronal representation changes dynamically, TRNN model might have trouble with variable delay periods. To test this hypothesis, we trained the TRNN models in ODPA tasks with a delay period between short (i.e., 3 s) and long (i.e., 6 s) time. The TRNNs were able to complete these tasks and got lower accuracy (mean + SEM over randomly initialized models, 92.19 ± 0.13% on average) in variable delay periods than in fixed ones (96.25 ± 0.26%). With variable delay periods, the transient firing peaks of the neurons could still be tiled to cover the entire delay period (Fig. [3a](https://www.nature.com/articles/s42003-024-07282-3#Fig3), Supplementary Fig. [3a](https://www.nature.com/articles/s42003-024-07282-3#MOESM2)). The only noticeable difference is that the temporal density of neurons with peaks in the second half of the delay period, which is also the variable part, is lower in networks trained with variable delay (Supplementary Fig. [3b](https://www.nature.com/articles/s42003-024-07282-3#MOESM2)). One question we would like to ask is whether the neurons have the same functions in trials of different lengths. To test this, we first divided the hidden layer neurons into different functional groups based on their peak activity time, including the baseline group (peaking before the presentation of the first odor), sample responding group (peaking during the presentation of the first odor), memory encoding group (peaking during the delay period), and test responding group (peaking during the presentation of the second odor). We noticed that the functional group of the neurons varied with the sample odor (Supplementary Fig. [3c](https://www.nature.com/articles/s42003-024-07282-3#MOESM2)). One specific question is whether more neurons would be recruited to encode the memory for longer delays? We divided the memory encoding neurons in long trials with delay of 6 s into early ones and late ones, which exhibited firing peak in the first and last 3 s in the delay period, respectively. For these two groups of memory encoding neurons, their groups in the short trials with delay of 3 s responding to the same sample odor were analyzed (Fig. [3b](https://www.nature.com/articles/s42003-024-07282-3#Fig3)). If the functions of the neurons are the same in the long and short trials, the two groups of memory encoding neurons should both belong to the memory encoding group in short trials. The early memory encoding neurons were indeed mostly from the memory encoding group. However, it was found that the late memory encoding neurons were not only from the memory encoding group in the short trials but also from the baseline and test responding groups. This suggests that more neurons are recruited for longer memory time, implying that the WM time is limited by neuron numbers and matching the short-term property of the WM.

![Fig. 3: Analysis of TRNNs trained in tasks with variable delay periods.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs42003-024-07282-3/MediaObjects/42003_2024_7282_Fig3_HTML.png?as=webp)

Fig. 3: Analysis of TRNNs trained in tasks with variable delay periods.

Then we analyzed how working memory was maintained in trials with delay periods of different lengths. Firstly, the trajectories of neuronal activities before the end of the delay period were plotted, after dimension reduction with demixed principal component analysis (dPCA) [^46] (Fig. [3c](https://www.nature.com/articles/s42003-024-07282-3#Fig3)). The first stimulus-dependent component and the first time-dependent component were chosen to summarize the activity. As expected, when the sample odor was presented, the two types of odors were encoded in separate trajectories. During the delay period, the trajectories remained separated and kept evolving, regardless of the length of the delay period. This suggests that the memory is encoded dynamically in transient trajectories. Then we looked at the activities of the output neurons to see how the memory was compared to the test odor, plotting the activities of the match and non-match output neurons (Fig. [3d](https://www.nature.com/articles/s42003-024-07282-3#Fig3)). With the same sample odors, different test odors drove the activities in two directions, leading to different decisions. On the other hand, with different sample odors in memory, the same test odors also led to activities in different directions. This result suggests that consistent information could be decoded from the dynamic activities of the neural networks. The trajectories of all three output neurons in the entire trials show that the match and non-match neurons’ activities remained close to each other and lower than the fix neuron’s activity until the presentation of the test odor (Supplementary Fig. [3d](https://www.nature.com/articles/s42003-024-07282-3#MOESM2)). Lastly, the weight matrix of the recurrent connections between the hidden neurons was studied in Fig. [3e](https://www.nature.com/articles/s42003-024-07282-3#Fig3), where the neurons were kept in the same order as those in Fig. [3a](https://www.nature.com/articles/s42003-024-07282-3#Fig3). The feedforward connection from neurons early in the chain of activity to later neurons is stronger than the feedback connection (Fig. [3f](https://www.nature.com/articles/s42003-024-07282-3#Fig3)). This kind of asymmetry underlies the consecutive transient activity [^32] and traveling wave formation in head direction cells [^47], which explains how the neural network maintains working memory in transient activities. Such asymmetry is also used in theoretical modeling of transient trajectories [^26] [^48]. These asymmetrical connections might also underlie the directional spike coupling observed in Huang et al.[^34].

### Information richness and energy cost vary with transient activity

After confirming that TRNNs could reproduce observations in animal experiments and maintain memory for a variable amount of time, we studied their capabilities as memory networks in the ODPA task, by considering their information richness and energy consumption (Fig. [4a](https://www.nature.com/articles/s42003-024-07282-3#Fig4)). The three parts of the transient encoding modification were adjusted separately with TI as an integrative measurement to quantify the transient degree. For transient neurons, we adjusted the inhibition strength of the neuronal feedback. The sparsity controlled the probability of synaptic connections, and the elimination of connection was random during initialization. Compared to full connection, the hierarchical topology reduced long-term projection connection numbers between neighboring brain regions. The effect of inhibition strength of neurons and sparsity of the network on TI was non-linear (Fig. [4b](https://www.nature.com/articles/s42003-024-07282-3#Fig4)). In the case without hierarchical topology the TIs were much lower than that with hierarchical topology (Fig. [4c](https://www.nature.com/articles/s42003-024-07282-3#Fig4)). To study how transient trajectory encoding affects the information richness and energy consumption of the network, we compared 100 networks of the same sizes with different TI values from Fig. [4b](https://www.nature.com/articles/s42003-024-07282-3#Fig4). For simplicity, we represented the information richness with the Shannon entropy of the activity as described in the TI. Similarly, since energy consumption was found to be positively correlated to neuronal firing rate [^49] [^50], it was represented with the average squared firing rate of all neurons. These properties were plotted against the TI. We found that the entropy increased approximately linearly with the incremental TI values (Fig. [4d](https://www.nature.com/articles/s42003-024-07282-3#Fig4)) while the average squared firing rate decreased in a stepwise manner with the TI of the networks (Fig. [4e](https://www.nature.com/articles/s42003-024-07282-3#Fig4)). These results suggest that compared to the vanilla RNNs with low TIs, the TRNNs with high TIs have higher information richness and lower energy consumption. Higher information richness implies that TRNN could encode more information in its activities and might have higher memory capacity. To test this, we compared their performances in reinforcement learning tasks with complex visual input and reward feedback, that are closer to animal experiments.

![Fig. 4: Three key components of the TRNN and their contributions.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs42003-024-07282-3/MediaObjects/42003_2024_7282_Fig4_HTML.png?as=webp)

Fig. 4: Three key components of the TRNN and their contributions.

### TRNN performs better in simulated WM tasks

Besides previously introduced standard classification task, we further tested the networks in reinforcement learning tasks, since they match the value-based learning paradigm used in animals experiments better, and they are also more versatile (e.g. they could be used to simulate spatial working memory experiments). Their performances in the reinforcement learning tasks were compared.

We first simulated a direction-following task, where the agent was shown an arrow, and after a short delay period, the agent was rewarded after moving one step towards the direction of the arrow (Fig. [5A](https://www.nature.com/articles/s42003-024-07282-3#Fig5)). Both the TRNN and vanilla RNN were trained in the task, and they got very close to maximal rewards, much higher than feedforward neural networks that do not have memory (Fig. [5B](https://www.nature.com/articles/s42003-024-07282-3#Fig5)). We found the neuronal activity of the vanilla RNN was not persistent at first glance (Supplementary Fig. [4c](https://www.nature.com/articles/s42003-024-07282-3#MOESM2)), confirming previous finding that the activity pattern of RNNs during WM tests could vary continuously between being persistent and sequential based on the task types [^33]. To quantify the transient pattern of the activities, we calculated their TI and found that TI of TRNNs were much higher (Supplementary Fig. [4d](https://www.nature.com/articles/s42003-024-07282-3#MOESM2)), suggesting that the assumption that the TRNN represents WM models encoding with more transient activities still held in reinforcement learning tasks.

![Fig. 5: Performances comparison of TRNNs and vanilla RNNs in reinforcement learning tasks.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs42003-024-07282-3/MediaObjects/42003_2024_7282_Fig5_HTML.png?as=webp)

Fig. 5: Performances comparison of TRNNs and vanilla RNNs in reinforcement learning tasks.

Working memory is generally considered to be able to be maintained even in the presence of distractions [^51]. Therefore, we designed a new direction-following task that contains a longer delay period when some additional symbols of distractions were presented. The reward of the TRNN was higher than that of the vanilla RNN with three distractions, which suggests that the TRNN is more robust to more distractions (Fig. [5C](https://www.nature.com/articles/s42003-024-07282-3#Fig5), Supplementary Fig. [4a](https://www.nature.com/articles/s42003-024-07282-3#MOESM2)).

It has been suggested that attractor models have difficulty in maintaining multiple items [^18], especially when the number of items is much bigger than the potential attractors [^52] [^53]. Our analysis above also suggests that transient-encoding networks have higher memory capacity than attractor-based networks. Since it has been shown that the memory capacity of RNNs varies with the network sizes and task paradigms [^54], we tested two networks of the same size in the same task. In this task, we added more directions to the direction-following task, where the agents were expected to move multiple steps in those directions in order. The learning curves show that the TRNN is better at keeping multiple items in memory (Supplementary Fig. [4b](https://www.nature.com/articles/s42003-024-07282-3#MOESM2)). TRNNs performed better by achieving higher reward with more items to remember (Fig. [5D](https://www.nature.com/articles/s42003-024-07282-3#Fig5)), indicating that the transient trajectory model has a much higher memory capacity. The rewards of the RNN were higher than from moving in one direction correctly and increased with the number of directions. This suggests that the RNN learned that the task was to move in the observed directions in order. Further analysis about their accuracy for each move in the sequence showed a slight primacy effect but not a recency effect, with better memory of the items that appeared earlier in the sequence than those appeared later, similar to findings in serial recall experiments [^55] (Supplementary Fig. [4e](https://www.nature.com/articles/s42003-024-07282-3#MOESM2)).

Besides sequential information, we simulated a WM version of the Morris water maze experiment [^56] [^57] in the grid world environment (Fig. [5E](https://www.nature.com/articles/s42003-024-07282-3#Fig5)), to test TRNN’s spatial WM for navigation [^41]. Specifically, the goal of the agent was to reach the target cell that was randomly assigned in each episode which had multiple trials. One trial composed of three main steps: the agent started from a random initial position; it found the target platform after a period of active searching; the agent reached the target and got reset to a random position. To facilitate training, the episodes had fixed time lengths, and the goal of the agent was to find the target as fast as possible. Learning curves showed that the total reward was increased during training in both models, whereby the TRNNs achieved remarkably higher rewards than vanilla RNNs (Fig. [5F](https://www.nature.com/articles/s42003-024-07282-3#Fig5)). The vanilla RNN got similar rewards as the feedforward neural network, suggesting that the vanilla RNN is not fit for keeping spatial WM. To confirm this, the time consumption for agents to find the platform was compared. Similar to biological experimental results [^56], the TRNN agents spent a longer time to locate the platform in the first trial but less time in the following two trials with the help of WM (Fig. [5G](https://www.nature.com/articles/s42003-024-07282-3#Fig5)). As a comparison, the vanilla RNN agent spent similar time in different trials, indicating that they didn’t use memory of the target location formed in the first few trials to find it faster in the following trials. This suggests that the TRNN has better spatial WM ability.

## Discussion

In this paper, we showed that the structural modifications to a vanilla RNN are enough to reproduce the transient trajectory activity. Though transient, these trajectory activities could also keep memory for variable time. Compared to the vanilla RNN, TRNN has better performance in various reinforcement learning tasks that require working memory. These results support the transient trajectory theory as a mechanistic explanation of animal working memory.

There have been some ways to restrict the neural network to produce transient trajectory patterns in the literature. Goldman proposed a functionally feedforward network, which restricts the recurrent connection weight matrix to be a linear transformation of a feedforward connection weight matrix [^48]. This results in transient dynamics of neurons whose summed output could last. Since the linear network usually performs poorly in machine learning tasks, we did not take this approach. Bick and Rabinovich proposed a working memory model based on winner-less competition [^58]. Since all the inter-neuronal connections were inhibitory in that model, it was not used in this study. Instead, we chose some restrictions that resulted in transient activity of the neurons but not necessarily consecutive wave-like activity across the network. We expected that the training for memory tasks would make the network rely on consecutive activity across neurons to keep memory. This was based on the general concept that the RNN stores memory in cell activity. Since the network design prohibited lasting activity in individual neurons, the activities would dynamically span the entire delay period to keep the memory.

The self-inhibition connection was a simplification of the inhibitory connections in the brain, it sufficed to build artificial neural networks with the transient trajectory pattern. In this simplified implementation, the rate-coded neurons in our model could be interpreted as groups of excitatory and inhibitory neurons with recurrent connections of both signs. It is also possible that the transient activity feature is implemented with other mechanisms such as SFA in the brain [^35] [^36] [^37] [^38] [^39] [^40].

In tasks with fixed length of memory time, the network only needs to establish a one-to-one association between its final state in the transient trajectory and the memory content. This is, however, not quite viable when the memory time varies. This challenges the transient trajectory theory as a mechanism of working memory in the nervous system. In our tests, however, TRNN models were found to generalize to variable memory time and the dynamic trajectories were analyzed. Unlike previous discovery [^29], we found that the velocity of the trajectory in the phase plane did not decrease towards the end of the delay period, which suggests that the memory is maintained in a trajectory instead of a fixed point (Fig. [3c](https://www.nature.com/articles/s42003-024-07282-3#Fig3)). With the decision being one of the major sources of variance in the activities, some principal components should also represent the decision. As shown in Supplementary Fig. [3e, f](https://www.nature.com/articles/s42003-024-07282-3#MOESM2), the decision-dependent component of the hidden neuronal activities has similar trajectories as the decision output neurons. This component is independent of the sample odor during the sample phase. However, when the test odor is presented, the component diverges based on the comparison between the two odors. This is shown clearer when both the decision-dependent component and the sample-dependent component are plotted in the same graph (Supplementary Fig. [3g, h](https://www.nature.com/articles/s42003-024-07282-3#MOESM2)).

It has been previously proposed that the asymmetric synaptic connection underlies traveling wave activities both in theoretical models [^47] and numerical neural network models [^32]. This type of asymmetric connection has been shown to be equivalent to the SFA or self-inhibition in a continuous attractor neural network (CANN) [^37]. Interestingly, in our models, both the self-inhibition and the asymmetric connection were present to support the working memory storage through the transient trajectory. The reason why the self-inhibition and the asymmetry were shown to have redundant function in the CANN could be that a distance-based recurrent connection has already been incorporated to form attractor states for memory keeping.

Since the firing rate model is used in our study, it was assumed that the memory is stored in the firing rates. However, the theories of WM only specify that the neuronal activity encodes the memory, but they do not exclude the possibility that the spike timing is involved [^59]. Therefore, whether spike timing coding is involved in WM should be considered before applying findings in this work. Ideally, spiking neural networks (SNN) could be used for simulation. Self-inhibition and connection modification should reduce persistency in SNN as well. However, they were not used in this study due to the lack of efficient training techniques for complex tasks.

Traditional computational models are usually specifically tailored to fit certain activity patterns, and it would be hard to compare the performance of the models on the same ground. Besides, traditional computational models are mostly limited to a specific task paradigm. In this study, we compared the memory capabilities of networks with different activity patterns using the transient encoding modifications. With basic properties of the networks, such as parameter number and structure, controlled, we were able to compare their capabilities as memory networks in various simulated working memory experiments. This was valuable because it would be very hard to manipulate the memory mechanism in live animals to evaluate the capabilities of different models. The simulation results could provide hypothetical answers to why one working memory model is adopted over the other.

We found the vanilla RNNs had low TIs and defined them as attractor models. The TRNNs had higher TIs on average and were defined as transient trajectory models. Although the boundary between them was not a clear cut. We analyzed their properties as a group by sampling more than one model in each group to avoid the bias issue. It was confirmed that, in the direction-following reinforcement learning task, the TRNNs have higher TIs. The water maze task does not have an apparent delay period and TI over the delay period does not exist. Thus, we assumed that the TRNNs represented the transient trajectory model and the vanilla RNNs represented the attractor model based on the earlier results.

In the multiple-direction-following task, we only observed primacy effect when multiple items are recalled. In free recall experiments, where items were freely recalled regardless of their order, both the primacy effect and recency effect were observed [^60] [^61] [^62] [^63]. Our setup is a type of serial recall experiment which showed no recency effect in a previous study [^55]. Specifically, the agents needed to recall the directions in the exact order as shown. Since they were not trained to fill the positions of forgotten directions with placeholder actions, if they skipped a direction, all following actions are likely wrong.

In the water maze experiment, the overall performance of the trained TRNN was much better than the vanilla RNN. The vanilla RNN and the feedforward neural network had similar performances. This suggests that vanilla RNNs have worse navigation ability possibly due to poorer memory of the entire map, failure to learn the task, or worse movement execution. This could make the comparison of their memory abilities with the TRNNs less valid.

In summary, we introduced transient encoding modifications to RNNs to compare transient encoding of working memory with attractor encoding. Through a series simulation experiments and analyses, we found evidence that support transient encoding as a working memory mechanism, which is a supplement to animal experiments where direct manipulation of encoding mechanism is hard. In the future, this approach could be extended to combining working memory research with long-term memory research [^64] [^65] [^66] to study the information transfer between working memory and long-term memory and how items from observation and long-term memory interact within working memory.

## Methods

### Simulated working memory tasks

#### The ODPA task

The ODPA task was designed to test the decision-making response of head-fixed mice after being given two different odor stimuli. It starts with a fixation period of 1 s and a sample period of 1 s, during which one out of two odors is presented. After a delay period of 3 or 6 s, a test stimulus, one odor from another set of two odors, was presented for 1 s. At the end of the second stimulus, the animal could respond in the response window of 1 s. The animals are rewarded if they lick in response when the two stimuli matched. Note that each sample odor was assigned to match a different test odor before training arbitrarily.

We designed a digital version of the OPDA task to test the ANN models. It is a supervised learning task with sequential inputs and outputs. There are two major differences from the animal version. The first is that the response period is removed, and the model responds during the test period. Secondly, the odor input is replaced with a vector with amplitude $A$ and direction ${{\theta }}$. 24 neurons are used to encode the odor input using von Mises distribution. Each of the encoding neurons $i$ has a preferred input direction ${{{\theta }}}_{{pref}}^{i}$, which are evenly distributed between 0 and $2{{{\rm{\pi }}}}$. The output of neuron $i$ at time step $t$ could be expressed as the following equation.

 $u_{t}^{i} = A e^{\kappa cos ⁡ \left(\right. \theta - \theta_{p r e f}^{i} \left.\right)} + \sqrt{2 / a} \sigma_{i n} N \left(\right. 0 , 1 \left.\right) ,$ 
$$
{u}_{t}^{i}=A{e}^{{{{\rm{\kappa }}}}\cos \left({{\theta }}-{{{\theta }}}_{{pref}}^{i}\right)}+\sqrt{2/a}{{{\sigma }}}_{{in}}N\left(0,1\right),
$$

(1)

where the amplitude $A$ is set as $4/\exp \left({{{\rm{\kappa }}}}\right)$ when the odor stimulation is on and 0 when the stimulation is off. ${{{\rm{\kappa }}}}$ is the concentration coefficient and is set to 2. $N(0,\,1)$ is the standard normal distribution used to represent input noise. The noise variance ${{{\sigma }}}_{{in}}=0.1$, and $a=0.1$. The inputs of ${{\theta }}=\,0$ and ${{\theta }}={{{\rm{\pi }}}}$ are used to represent odor 0 and odor 1. Odor 0 and odor 1 are used in both the sample and test period and the test criterion is whether the two odors are the same. The model is expected to output the response during the test period. The stimulation was on during the sample period and the test period. The stimulation was off during the delay period and the response period.

We designed three binary output neurons for the ODPA task, and the expected activity is known for every input sequence. The fixation neuron signals inactivity and should be on until the start of the test period. The match/non-match neurons are only on during the test period when the sample and the test inputs are the same/different respectively.

#### Memory tasks in the grid world environment

The direction-following task and its variants and the 2D water maze task were all implemented in the grid world environment. The agent has a discrete action space with three actions, turning left/right by 90 degrees and moving forward. In both tasks, the observation is the visual input of the entire map. The direction following task is adapted from the Mortar Mayhem task from the Memory Gym library [^67]. The 2D water maze task was implemented using the Minigrid library [^68].

In the direction-following task, the environment is a $5\times 5$ grid. In the sample phase, a symbol is randomly chosen from up, down, left, and right arrows and a circle is shown. The symbol is displayed at the center of the grid for three timesteps. After the delay period of 16 timesteps, the agent is required to act within six timesteps according to the symbol in memory for a reward of 0.1. If one of the arrows is shown, the agent should move to the next cell in the direction of the arrow. If the circle is shown, the agent should stay. In the version with distractions, 1 to 3 random distracting symbols are displayed during the delay period. In the multiple-direction version, 2, 4, or 6 random symbols are shown in the sample phase. In the test phase, the agent should take the accordant actions in the order as the symbols are shown. There are 6 timesteps for each action and 2 timestep gaps in between. To compare the TRNN and the vanilla RNN, 3 randomly initialized networks from each group were trained to solve the tasks.

The 2D water maze task is adapted from the design by Heess et al.[^57]. Instead of a circular arena, a $9\times 9$ square grid world arena is used. There are landmarks positioned at the four corners of the arena. There is a hidden platform at a random cell which is only visible when the agent reaches it and its position changes across episodes. The agent has a vision of the entire arena. The agent starts at a random position and is only rewarded when it is on the platform. After 5 timesteps on the platform, the agent is placed in a random position and needs to find the platform again. The entire episode has 484 timesteps.

### Design and training of the neural networks

#### Vanilla RNN

The vanilla RNN is a standard three-layer network. The hidden layer contains 600 artificial neurons with full recurrent connections. The ${W}_{{in}}$, ${W}_{r}$ and ${W}_{{out}}$ are connection weights between input-hidden, inner hidden, and hidden-output layers, respectively. The neurons are separated into excitatory and inhibitory groups (4:1 ratio). The output connections of the excitatory neurons are initialized by the Gamma distribution with a shape parameter of 0.1 and scale parameter of 1. The inhibitory output connections are initialized as the negative of a value from the Gamma distribution with a shape of 0.2 and scale of 1. The inhibitory neurons in the input and output layers are ignored. The network biases in hidden and output layers, ${b}_{r}$ and ${b}_{{out}}$, are initialized to 0 before network learning. The input layer does not have a bias term. The artificial neuron in hidden layers can be defined as the following equation.

 $\tau \frac{d r_{t}}{d t} = - r_{t} + f \left(\right. W_{i n} u_{t} + W_{r} r_{t} + b_{r} + \sigma_{r} \left.\right) ,$ 
$$
{{{\rm{\tau }}}}\frac{d{r}_{t}}{{dt}}=-{r}_{t}+f\left({W}_{{in}}{u}_{t}+{W}_{r}{r}_{t}+{b}_{r}+{{{\sigma }}}_{r}\right),
$$

(2)

where ${u}_{t}$ is the input from the input layer and ${r}_{t}$ is the recurrent input. ${{{\rm{\tau }}}}$ is the membrane time constant. Rectified linear unit (ReLU) is chosen as the activation function $f\left(\cdot \right)$. ${{{\sigma }}}_{r}$ represents an independent Gaussian white noise with a mean of 0 and a standard variance of 0.1. We use the forward Euler method to numerically solve the equation and get the following equation.

 $r_{t} = \left(\right. 1 - \alpha \left.\right) r_{t - 1} + \alpha f \left(\right. W_{r} r_{t - 1} + W_{i n} u_{t} + b_{r} + \sigma_{r} \left.\right) ,$ 
$$
{r}_{t}=\left(1-{{{\rm{\alpha }}}}\right){r}_{t-1}+{{{\rm{\alpha }}}}f\left({W}_{r}{r}_{t-1}+{W}_{{in}}{u}_{t}+{b}_{r}+{{{\sigma }}}_{r}\right),
$$

(3)

where ${{{\rm{\alpha }}}}=\,\Delta t/{{{\rm{\tau }}}}$ represents the time step size relative to the membrane time constant. In the ODPA task and reinforcement learning tasks, ${{{\rm{\alpha }}}}$ is set as 0.6 and 0.98, respectively. The time step size $\Delta t=100{ms}$. The network is trained by the Adam stochastic gradient descent with a batch size of 64. The learning rate is 0.001 and the loss function was defined as the cross-entropy error. The average squared neuronal activity is also added to the loss function with a factor of 0.01 to stabilize the network.

#### Transient RNN

The network architecture of the TRNN is the same as that of the vanilla RNN but additionally separates hidden layers into three sub-brain regions, i.e., the sensory, association, and motor brain regions. It is assumed that the inter-region connections are sparser than the intra-region connections. This hierarchical topology is implemented by applying an element-wise mask matrix ${W}_{m}$ to the recurrent connection matrix ${W}_{r}$. Random inter-region connection elements in the mask are zeros and others are ones.

Compared to artificial neurons in the vanilla RNN in Eq. ([1](https://www.nature.com/articles/s42003-024-07282-3#Equ1)), the transient neuron has an additional self-inhibition term V to inhibit neural activities instantaneously. Originally proposed as a slow negative feedback component in the traveling wave model [^35], the transient neuron is defined by the following equations.

 $\tau_{r} \frac{d r_{t}}{d t} = - r_{t} + f \left(\right. W_{i n} u_{t} + W_{r} r_{t} + b_{r} + \sigma_{r} \left.\right) - \gamma V_{t}$ 
$$
{{{{\rm{\tau }}}}}_{r}\frac{d{r}_{t}}{{dt}}=-{r}_{t}+f\left({W}_{{in}}{u}_{t}+{W}_{r}{r}_{t}+{b}_{r}+{{{\sigma }}}_{r}\right)-\gamma {V}_{t}
$$

(4)

 $\tau_{v} \frac{d V_{t}}{d t} = - V_{t} + m r_{t}$ 
$$
{{{{\rm{\tau }}}}}_{v}\frac{d{V}_{t}}{{dt}}=-{V}_{t}+m{r}_{t}
$$

(5)

where ${{{{\rm{\tau }}}}}_{r}$ is the time constant of the transient neuron. ReLU is used as the activation function ${{{\rm{f}}}}$. ${{{{\rm{\tau }}}}}_{v}$ is the time constant of the dynamic inhibition term. The hyperparameters $\gamma \,{{{\rm{and}}}}{m}$ represent the scale of the influence of self-inhibition. In the ODPA task $\gamma =2,\,m=2$, in the direction following task $\gamma =10,\,m=2$, and in the water maze task $\gamma =3,\,m=2$. Similarly, with Euler method approximation, we get

 $r_{t} = \left(\right. 1 - \alpha_{r} \left.\right) r_{t - 1} + \alpha_{r} \left(\right. f \left(\right. W_{r} r_{t - 1} + W_{i n} u_{t} + b_{r} + \sigma_{r} \left.\right) - \gamma V_{t - 1} \left.\right) ,$ 
$$
{r}_{t}=\left(1-{{{{\rm{\alpha }}}}}_{r}\right){r}_{t-1}+{{{{\rm{\alpha }}}}}_{r}\left(f\left({W}_{r}{r}_{t-1}+{W}_{{in}}{u}_{t}+{b}_{r}+{{{\sigma }}}_{r}\right)-\gamma {V}_{t-1}\right),
$$

(6)

 $V_{t} = \left(\right. 1 - \alpha_{v} \left.\right) V_{t - 1} + \alpha_{v} \left(\right. m r_{t - 1} \left.\right) ,$ 
$$
{V}_{t}=\left(1-{{{{\rm{\alpha }}}}}_{v}\right){V}_{t-1}+{{{{\rm{\alpha }}}}}_{v}\left(m{r}_{t-1}\right),
$$

(7)

In ODPA task and the reinforcement learning tasks, ${\alpha }_{r}$ is set as 0.6 and 0.98 respectively and ${\alpha }_{v}$ is set as 1/10. A sparse connection is imposed by randomly initializing a proportion of the connection ${W}_{r}$ as zero. They are still trainable after initialization. This proportion parameter was adjusted when studying the impact of sparsity on the TI. The connections between regions are initialized to be sparser than within the regions. The connection ratio is 0.9 within the sensory region and 1 within the other two regions. The connection ratio across regions is 0.8. A similar training method as with the RNN was used. Except for that an L2 regularization of the recurrent connection weights was added to the loss with a factor of 0.1 to maintain sparsity.

#### RNN models with convolution layers

For the tasks in the grid world environment, convolution layers were attached ahead of the RNN to extract features from the video input of 3 color channels ($84\times 84$ pixels for Memory Gym and $64\times 64$ pixels for Minigrid). We used three convolution layers with 3, 32, and 64 filters respectively. The filters’ sizes are $8\times 8$, $4\times 4$, and $3\times 3$ respectively, and the strides are 4, 2, and 2 respectively. The output of the convolution layers is squeezed into 1D by concatenation before being fed into the RNN.

#### Proximal policy optimization

To train our models in these reinforcement learning tasks, we used the proximal policy optimization (PPO) algorithm due to its robustness (not sensitive to hyperparameter tuning) [^69]. As an on-policy algorithm, it suffers from sample complexity problems, where it needs to produce a lot of samples during the training. To alleviate the problem and speed up training, an asynchronous PPO algorithm was proposed with the sample factory architecture [^70]. We used their architecture and implementation to train our models within a reasonable amount of time. The goal of the PPO is to maximize the expected return of a policy ${{{{\rm{\pi }}}}}_{{{\theta }}}$, represented with ${{{\mathcal{J}}}}\left({{\theta }}\right)$, which is equivalent to the Q-value under the policy, shown as the following equation.

 $\mathcal{J} \left(\right. \theta \left.\right) = \hat{E}_{t} \left[\right. \hat{Q}_{t} \left]\right. .$ 
$$
{{{\mathcal{J}}}}\left({{\theta }}\right)={\hat{E}}_{t}\left[{\hat{Q}}_{t}\right].
$$

(8)

Denoting the parameters of the policy before the update as ${{{\theta }}}_{{\mbox{old}}}$, it’s been shown that the expected return of a policy ${{{{\rm{\pi }}}}}_{{{\theta }}}$ could be linked to the policy before the update ${{{{\rm{\pi }}}}}_{\left({{{\theta }}}_{{{\rm{old}}}}\right)}$ with the following equation.

 $\mathcal{J} \left(\right. \theta \left.\right) = \mathcal{J} \left(\right. \theta_{\text{old}} \left.\right) + \hat{E}_{t} \left[\right. \frac{\pi_{\theta} \left(\right. a_{t} \left|\right. s_{t} \left.\right)}{\pi_{\theta_{\text{old}}} \left(\right. a_{t} \left|\right. s_{t} \left.\right)} \hat{A}_{t} \left]\right. .$ 
$$
{{{\mathcal{J}}}}\left({{\theta }}\right){{=}}{{{\mathcal{J}}}}\left({{{\theta }}}_{{\mbox{old}}}\right)+{\hat{E}}_{t}\left[\frac{{{{{\rm{\pi }}}}}_{{{\theta }}}\left({a}_{t}|{s}_{t}\right)}{{{{{\rm{\pi }}}}}_{{{{\theta }}}_{{\mbox{old}}}}\left({a}_{t}|{s}_{t}\right)}{\hat{A}}_{t}\right].
$$

(9)

${\hat{A}}_{t}$ is the estimation of the advantage $A\left({s}_{t},{a}_{t}\right)=Q\left({s}_{t},{a}_{t}\right)\mbox{-}V\left({s}_{t}\right)$ where V is the state value function. Let ${r}_{t}\left({{\theta }}\right)$ denote the probability ratio ${r}_{t}\left({{\theta }}\right)=\frac{{{{{\rm{\pi }}}}}_{{{\theta }}}\left({a}_{t}|{s}_{t}\right)}{{{{{\rm{\pi }}}}}_{{{{\theta }}}_{{{\rm{old}}}}}\left({a}_{t}|{s}_{t}\right)}$. The goal becomes maximizing a surrogate objective function.

 $\mathcal{L} \left(\right. \theta \left.\right) = \hat{E}_{t} \left[\right. r_{t} \left(\right. \theta \left.\right) \hat{A}_{t} \left]\right. .$ 
$$
{{{\mathcal{L}}}}\left({{\theta }}\right)={\hat{E}}_{t}\left[{r}_{t}\left({{\theta }}\right){\hat{A}}_{t}\right].
$$

(10)

To keep the updated policy from being too different from the current policy, PPO clipped ${r}_{t}\left({{\theta }}\right)$ to be around 1 with a hyperparameter ${{{\rm{\epsilon }}}}=0.2$, then the surrogate objective becomes the following format.

 $\mathcal{L}^{C L I P} \left(\right. \theta \left.\right) = \hat{E}_{t} \left[\right. m i n \left(\right. r_{t} \left(\right. \theta \left.\right) A_{t} , c l i p \left(\right. r_{t} \left(\right. \theta \left.\right) , \frac{1}{1 + \epsilon} , 1 + \epsilon \left.\right) \hat{A}_{t} \left]\right. .$ 
$$
{{{{\mathcal{L}}}}}^{{CLIP}}(\theta )\,=\,{\hat{E}}_{t}\left[min \left({r}_{t}\left(\theta \right){A}_{t},{clip}\left({r}_{t}\left(\theta \right),\frac{1}{1+\epsilon },\,1\,+\epsilon \right)\right.{\hat{A}}_{t}\right].
$$

(11)

The advantage ${\hat{A}}_{t}$ is estimated using generalized advantage estimation in a length-T trajectory based on state value functions, as shown in the following equations.

 $\hat{A}_{t} = \delta_{t} + \left(\right. \gamma \lambda \left.\right) \delta_{t + 1} + \ldots + \left(\right. \gamma \lambda \left.\right)^{T - t + 1} \delta_{T - 1} ,$ 
$$
{\hat{A}}_{t}={{{{\rm{\delta }}}}}_{t}+\left({{{\rm{\gamma }}}}{{{\rm{\lambda }}}}\right){{{{\rm{\delta }}}}}_{t+1}+\ldots +{\left({{{\rm{\gamma }}}}{{{\rm{\lambda }}}}\right)}^{T-t+1}{{{{\rm{\delta }}}}}_{T-1},
$$

(12)

 $\delta_{t} = r_{t} + \gamma V \left(\right. s_{t + 1} \left.\right) - V \left(\right. s_{t} \left.\right) ,$ 
$$
{{{{\rm{\delta }}}}}_{t}={r}_{t}+{{{\rm{\gamma }}}}V\left({s}_{t+1}\right)-V\left({s}_{t}\right),
$$

(13)

where neural network models are used to approximate both the policy ${{{\rm{\pi }}}}$ and the state value ${{{\rm{V}}}}$. Thus a loss function that combines the policy surrogate and the mean squared error of state values is used, shown as follows:

 $\mathcal{L}^{C L I P + V F} \left(\right. \theta \left.\right) = \mathcal{L}^{C L I P} \left(\right. \theta \left.\right) - c_{1} E_{t} \left[\right. \left(\right. V_{\theta} \left(\right. s_{t} \left.\right) - \hat{V}_{t} \left.\right)^{2} \left]\right. + c_{2} S \left[\right. \pi_{\theta} \left]\right. \left(\right. s_{t} \left.\right) ,$ 
$$
{{{{\mathcal{L}}}}}^{{{\rm{CLIP}}}+{{\rm{VF}}}}\left({{\theta }}\right)={{{{\mathcal{L}}}}}^{{{\rm{CLIP}}}}\left({{\theta }}\right)-{c}_{1}{E}_{t}\left[{\left({V}_{{{\theta }}}\left({s}_{t}\right)-{\hat{V}}_{t}\right)}^{2}\right]+{c}_{2}S\left[{{{{\rm{\pi }}}}}_{{{\theta }}}\right]\left({s}_{t}\right),
$$

(14)

where ${c}_{1}$ and ${c}_{2}$ are coefficients, $\hat{{V}_{t}}={\sum }_{n=t}^{T-1}{{{{\rm{\gamma }}}}}^{n}{r}_{n+1}$ is the sampled state value and S is an entropy of the policy. This combined target is maximized using stochastic gradient descent.

In the sample factory architecture, the training process is delegated to three parallel components, including the rollout workers, policy workers, and learners. The rollout workers are responsible only for environmental simulation. The rollout worker calculates observations ${x}_{t}$, rewards ${r}_{t}$, and feeds them to the policy workers. Policy workers sample actions based on the current policy and update hidden states ${h}_{t}$ of the agents. The length-T trajectories become available to the learners once completed. The learners continuously process batches of trajectories and update the neural network parameters asynchronously, meaning that the policy workers don’t wait for the policy updates. In our experiments, one learner, one policy worker, and 8–32 rollout workers were used, and each rollout worker hosted 12 environment instances.

### Analysis of the neural networks

#### Transient index

The transient index is used to measure how well the activity pattern of neuronal activities during the delay period matches the transient trajectory theory. Three aspects of the activity pattern are considered, including the uniformity, selectivity, and specificity of the neuronal activities. These are measured by Shannon entropy, ridge-to-background ratio [^33], and proportion of memory-related peak firing respectively.

### Shannon entropy

It is calculated to represent the information capacity of all neurons in networks using different encoding methods. For each time window $t$ in a delay period, the probability of neurons attending encoding peak firing of a trajectory is $p\left(t\right)={n}_{t}/N$. ${n}_{t}$ is the number of neurons with their peak activity in this time window and $N$ is the total number of neurons. Then, the Shannon entropy is calculated using the following equation,

 $H \left(\right. x \left.\right) = - \sum_{t = 1}^{L} p \left(\right. t \left.\right) log_{2} p \left(\right. t \left.\right) ,$ 
$$
H\left(x\right)=-{\sum}_{t=1}^{L}p\left(t\right){\log }_{2}p\left(t\right),
$$

(15)

where L represents the number of split time windows (each is 100 ms) for raw delay period. A pseudo-count of 0.1 was added to each bin before calculating the entropy. Shannon entropy also represents the uniformity of the peak firing time, where a higher entropy usually indicates that neurons fire more uniformly during the delay period. When combined with the other properties, the entropy is normalized using the following equation,

 $E \left(\right. x \left.\right) = \frac{H \left(\right. x \left.\right)}{log_{2} L} .$ 
$$
E\left(x\right)=\frac{H\left(x\right)}{{\log }_{2}L}.
$$

(16)

### Ridge-to-background ratio

It is used to describe the selectivity of the neural activity, i.e., how concentrated the firing activity of neurons is around the peak. The ridge was defined as the mean activity in the $\Delta t=1$ timestep surrounding the peak value, and the background was defined as the mean activity in all the timesteps. Thus the ratio is defined as the following equation:

 $R \left(\right. x \left.\right) = \frac{1}{N} \sum_{i} \frac{\sum_{t = t_{i p} - \Delta t}^{t_{i p} + \Delta t} r_{i t}}{\sum_{t = 0}^{T} r_{i t}} ,$ 
$$
R\left(x\right)=\frac{1}{N}{\sum}_{i}\frac{{\sum }_{t={t}_{{ip}}-\Delta t}^{{t}_{{ip}}+\Delta t}{r}_{{it}}}{{\sum }_{t=0}^{T}{r}_{{it}}},
$$

(17)

where ${r}_{{it}}$ is the firing rate of neuron $i$ at time step $t$. $T$ is the trial length and ${t}_{{ip}}$ is the peak firing time of neuron $i$.

### Proportion of memory-related peak firing

It measures how specific the peak firing of the neurons is to the delay period when the memory is maintained. It is calculated using the following equation.

 $P \left(\right. x \left.\right) = \frac{N_{a}}{N} ,$ 
$$
P\left(x\right)=\frac{{N}_{a}}{N},
$$

(18)

where ${N}_{a}$ is the number of neurons whose firing peak lies in the delay period. Neurons firing at the peak during the delay period could help to form the transient trajectory and transmit odor information. A higher proportion indicates more neurons are involved in the formation of the transient trajectory. Then the TI indicator is defined as the sum of these three sub-indicators after normalization to the value range of zero to one, shown as the following equation.

 $T I \left(\right. x \left.\right) = E \left(\right. x \left.\right) + R \left(\right. x \left.\right) + P \left(\right. x \left.\right) .$ 
$$
{TI}\left(x\right)=E\left(x\right)+R\left(x\right)+P\left(x\right).
$$

(19)

### Memory-selective neurons

To identify memory-selective neurons, the trials are each divided into one second time bins. Wilcoxon rank-sum test [^71] is done by comparing the mean firing rates of the trials from different stimuli in each time bin. If the mean firing rates are significantly different in any time bin between two stimuli, the neuron is considered selective to the stimuli with higher responses. One neuron might be selective to multiple stimuli depending on which stimulus is compared against. However, memory-selective neurons are defined as those that have statistically significant firing rates for one specific stimulus. In contrast, those without selectivity or multiple selective stimuli are defined as non-selective neurons. Based on this definition, memory-selective neurons in TRNNs after learning an ODPA task could also be identified accordingly.

### Psychometric function

We fitted the TRNN model’s performance data in the OPDA task to a logistic psychometric function, shown as follows:

 $P \left(\right. \theta \left.\right) = \frac{1}{1 + e^{\frac{\theta - m}{s}}} .$ 
$$
P\left({{\theta }}\right)=\frac{1}{1+{e}^{\frac{{{\theta }}-m}{s}}}.
$$

(20)

The maximum likelihood estimation is used to determine the parameters $m$ and $s$ in the psychometric function. Powell algorithm is used to calculate the maximum likelihood and the corresponding parameters $m$ and $s$. A total number of $n=64$ trials is tested for each ${{\theta }}$. With ${r}_{i}$ correct trials for ${{{\theta }}}_{i}$ found in the tests, the log-likelihood function is defined as the following equation.

 $l = \sum_{i} \left[\right. r_{i} l o g P \left(\right. \theta_{i} \left.\right) + \left(\right. n - r_{i} \left.\right) log ⁡ P \left(\right. \theta_{i} \left.\right) \left]\right. .$ 
$$
l={\sum}_{i}\left[{r}_{i}{{{\rm{log}}}}P\left({{{{\rm{\theta }}}}}_{i}\right)+\left(n-{r}_{i}\right)\log P\left({{{{\rm{\theta }}}}}_{i}\right)\right].
$$

(21)

### Demixed principal component analysis

We used dPCA to reduce the dimension of the population activities. This algorithm is described in detail by Kobak et al.[^46]. In brief, the activity matrix of the neurons, $X$, is decomposed into task variable dependent terms by taking averages over the task variables. In our case, we first decomposed the matrix into sample-odor-independent, sample-odor-dependent, and noise terms, shown as the following equation.

 $X = X_{t} + X_{s t} + X_{n o i s e} = \sum_{\phi} X_{\phi} + X_{n o i s e} .$ 
$$
X={X}_{t}+{X}_{{st}}+{X}_{{noise}}={\sum}_{{{{\rm{\phi }}}}}{X}_{{{{\rm{\phi }}}}}+{X}_{{noise}}.
$$

(22)

For additional discussion, we also decomposed the matrix into sample-odor-dependent, decision-dependent, time dependent, and noise terms, shown as the following equation.

 $X = X_{t} + X_{s t} + X_{d t} + X_{n o i s e} = \sum_{\phi} X_{\phi} + X_{n o i s e} .$ 
$$
X={X}_{t}+{X}_{{st}}+{X}_{{dt}}+{X}_{{noise}}={\sum}_{{{{\rm{\phi }}}}}{X}_{{{{\rm{\phi }}}}}+{X}_{{noise}}.
$$

(23)

Each term is then approximated using separate decoder and encoder matrices, ${D}_{{{{\rm{\phi }}}}}$ and ${F}_{{{{\rm{\phi }}}}}$, by minimizing the following loss function.

 $L_{d P C A} = \sum_{\phi} \left|\right. \left|\right. X_{\phi} - F_{\phi} D_{\phi} X \left|\right. \left|\right.^{2} .$ 
$$
{L}_{{dPCA}}={\sum}_{{{{\rm{\phi }}}}}{\left|\big|{X}_{{{{\rm{\phi }}}}}-{F}_{{{{\rm{\phi }}}}}{D}_{{{{\rm{\phi }}}}}X\big|\right|}^{2}.
$$

(24)

The decoder matrix ${D}_{{{{\rm{\phi }}}}}$ is composed of the demixed principal components similar to PCA. The difference is that the demixed principal components reconstruct the task variable-specific activities. These components are ordered by the amount of variance explained. In the sample response and delay period analysis, the principal components specific to the sample-odor-dependent term ${D}_{{st}}$ was used. For the discussion about the decision representation, the sample-odor-dependent term ${D}_{{st}}$ and the decision-dependent term ${D}_{{dt}}$ were used.

### Statistics and reproducibility

For the TI comparison in the ODPA task, Student *t* test was used to analyze the statistical significance. The animal data had averaged TIs in 14 recording sessions, and the modeling data had TIs of 10 models trained with different initializations. In the reinforcement learning tasks, all data was tested with Student *t* test. Three models trained with different randomly initialized parameters were included in each group.

### Reporting summary

Further information on research design is available in the [Nature Portfolio Reporting Summary](https://www.nature.com/articles/s42003-024-07282-3#MOESM5) linked to this article.

## Data availability

The source data used for the graphs in the figure is provided in the supplementary data file. The data could also be reproduced using the modeling code. All other data are available from the corresponding author on reasonable request.

## Code availability

The code used in this study is available at [https://github.com/jiashuncheng/Transient](https://github.com/jiashuncheng/Transient).

## References

## Acknowledgements

We’d like to thank Dr. Xiaoxing Zhang for the discussion about the interpretation of the animal experimental results. T.Z. and B.X. disclose support for research and publication of this work from the Strategic Priority Research Program of Chinese Academy of Sciences \[Grant No. XDB1010302\], the Beijing Nova Program \[Grant No. 20230484369\], the Youth Innovation Promotion Association CAS, and CAS Project for Young Scientists in Basic Research \[YSBR-116\]. C.T.L. discloses support for research of this work from the Shanghai Municipal Science and Technology Major Project \[Grant No. 2021SHZDZX\]. C.L. discloses support for research of this work from the Youth Innovation Promotion Association of the Chinese Academy of Sciences, and the National Postdoctoral Researcher Funding Program \[Grant No. GZC20232998\].

## Ethics declarations

### Competing interests

The authors declare no competing interests.

## Peer review

### Peer review information

*Communications Biology* thanks the anonymous reviewers for their contribution to the peer review of this work. Primary Handling Editor: Jasmine Pan. A peer review file is available.

## Additional information

**Publisher’s note** Springer Nature remains neutral with regard to jurisdictional claims in published maps and institutional affiliations.

## Rights and permissions

**Open Access** This article is licensed under a Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License, which permits any non-commercial use, sharing, distribution and reproduction in any medium or format, as long as you give appropriate credit to the original author(s) and the source, provide a link to the Creative Commons licence, and indicate if you modified the licensed material. You do not have permission under this licence to share adapted material derived from this article or parts of it. The images or other third party material in this article are included in the article’s Creative Commons licence, unless indicated otherwise in a credit line to the material. If material is not included in the article’s Creative Commons licence and your intended use is not permitted by statutory regulation or exceeds the permitted use, you will need to obtain permission directly from the copyright holder. To view a copy of this licence, visit [http://creativecommons.org/licenses/by-nc-nd/4.0/](http://creativecommons.org/licenses/by-nc-nd/4.0/).

[^1]: Baddeley, A. Working memory. *Science* **255**, 556–559 (1992).

[Article](https://doi.org/10.1126%2Fscience.1736359) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=1736359) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK387ktFyitw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Working%20memory&journal=Science&doi=10.1126%2Fscience.1736359&volume=255&pages=556-559&publication_year=1992&author=Baddeley%2CA)

[^2]: Fuster, J. M. & Alexander, G. E. Neuron activity related to short-term memory. *Science* **173**, 652–654 (1971).

[Article](https://doi.org/10.1126%2Fscience.173.3997.652) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=4998337) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaE3M3mslSjtA%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neuron%20activity%20related%20to%20short-term%20memory&journal=Science&doi=10.1126%2Fscience.173.3997.652&volume=173&pages=652-654&publication_year=1971&author=Fuster%2CJM&author=Alexander%2CGE)

[^3]: Funahashi, S., Bruce, C. J. & Goldman-Rakic, P. S. Mnemonic coding of visual space in the monkey’s dorsolateral prefrontal cortex. *J. Neurophysiol.* **61**, 331–349 (1989).

[Article](https://doi.org/10.1152%2Fjn.1989.61.2.331) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=2918358) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL1M7ktV2rtQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mnemonic%20coding%20of%20visual%20space%20in%20the%20monkey%E2%80%99s%20dorsolateral%20prefrontal%20cortex&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.1989.61.2.331&volume=61&pages=331-349&publication_year=1989&author=Funahashi%2CS&author=Bruce%2CCJ&author=Goldman-Rakic%2CPS)

[^4]: Xie, Y., Liu, Y. H., Constantinidis, C. & Zhou, X. Neural mechanisms of working memory accuracy revealed by recurrent neural networks. *Front. Syst. Neurosci.* **16**, 760864 (2022).

[Article](https://doi.org/10.3389%2Ffnsys.2022.760864) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=35237134) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8883483) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20mechanisms%20of%20working%20memory%20accuracy%20revealed%20by%20recurrent%20neural%20networks&journal=Front.%20Syst.%20Neurosci.&doi=10.3389%2Ffnsys.2022.760864&volume=16&publication_year=2022&author=Xie%2CY&author=Liu%2CYH&author=Constantinidis%2CC&author=Zhou%2CX)

[^5]: Compte, A. Synaptic mechanisms and network dynamics underlying spatial working memory in a cortical network model. *Cereb. Cortex* **10**, 910–923 (2000).

[Article](https://doi.org/10.1093%2Fcercor%2F10.9.910) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10982751) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD3cvotFSgtQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Synaptic%20mechanisms%20and%20network%20dynamics%20underlying%20spatial%20working%20memory%20in%20a%20cortical%20network%20model&journal=Cereb.%20Cortex&doi=10.1093%2Fcercor%2F10.9.910&volume=10&pages=910-923&publication_year=2000&author=Compte%2CA)

[^6]: Wimmer, K., Nykamp, D. Q., Constantinidis, C. & Compte, A. Bump attractor dynamics in prefrontal cortex explains behavioral precision in spatial working memory. *Nat. Neurosci.* **17**, 431–439 (2014).

[Article](https://doi.org/10.1038%2Fnn.3645) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24487232) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXhsF2qt70%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Bump%20attractor%20dynamics%20in%20prefrontal%20cortex%20explains%20behavioral%20precision%20in%20spatial%20working%20memory&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.3645&volume=17&pages=431-439&publication_year=2014&author=Wimmer%2CK&author=Nykamp%2CDQ&author=Constantinidis%2CC&author=Compte%2CA)

[^7]: Shafi, M. et al. Variability in neuronal activity in primate cortex during working memory tasks. *Neuroscience* **146**, 1082–1108 (2007).

[Article](https://doi.org/10.1016%2Fj.neuroscience.2006.12.072) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17418956) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2sXlt1Sjsbw%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Variability%20in%20neuronal%20activity%20in%20primate%20cortex%20during%20working%20memory%20tasks&journal=Neuroscience&doi=10.1016%2Fj.neuroscience.2006.12.072&volume=146&pages=1082-1108&publication_year=2007&author=Shafi%2CM)

[^8]: Stokes, M. G. et al. Dynamic coding for cognitive control in prefrontal cortex. *Neuron* **78**, 364–375 (2013).

[Article](https://doi.org/10.1016%2Fj.neuron.2013.01.039) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23562541) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3898895) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXlsVGqtrw%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Dynamic%20coding%20for%20cognitive%20control%20in%20prefrontal%20cortex&journal=Neuron&doi=10.1016%2Fj.neuron.2013.01.039&volume=78&pages=364-375&publication_year=2013&author=Stokes%2CMG)

[^9]: Meyers, E. M., Freedman, D. J., Kreiman, G., Miller, E. K. & Poggio, T. Dynamic population coding of category information in inferior temporal and prefrontal cortex. *J. Neurophysiol.* **100**, 1407–1419 (2008).

[Article](https://doi.org/10.1152%2Fjn.90248.2008) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18562555) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2544466) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Dynamic%20population%20coding%20of%20category%20information%20in%20inferior%20temporal%20and%20prefrontal%20cortex&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.90248.2008&volume=100&pages=1407-1419&publication_year=2008&author=Meyers%2CEM&author=Freedman%2CDJ&author=Kreiman%2CG&author=Miller%2CEK&author=Poggio%2CT)

[^10]: Brody, C. D. Timing and neural encoding of somatosensory parametric working memory in macaque prefrontal cortex. *Cereb. Cortex* **13**, 1196–1207 (2003).

[Article](https://doi.org/10.1093%2Fcercor%2Fbhg100) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=14576211) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Timing%20and%20neural%20encoding%20of%20somatosensory%20parametric%20working%20memory%20in%20macaque%20prefrontal%20cortex&journal=Cereb.%20Cortex&doi=10.1093%2Fcercor%2Fbhg100&volume=13&pages=1196-1207&publication_year=2003&author=Brody%2CCD)

[^11]: Murray, J. D. et al. Stable population coding for working memory coexists with heterogeneous neural dynamics in prefrontal cortex. *Proc. Natl. Acad. Sci.* **114**, 394–399 (2017).

[Article](https://doi.org/10.1073%2Fpnas.1619449114) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28028221) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28XitFGntr7E) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Stable%20population%20coding%20for%20working%20memory%20coexists%20with%20heterogeneous%20neural%20dynamics%20in%20prefrontal%20cortex&journal=Proc.%20Natl.%20Acad.%20Sci.&doi=10.1073%2Fpnas.1619449114&volume=114&pages=394-399&publication_year=2017&author=Murray%2CJD)

[^12]: Druckmann, S. & Chklovskii, D. B. Neuronal circuits underlying persistent representations despite time varying activity. *Curr. Biol.* **22**, 2095–2103 (2012).

[Article](https://doi.org/10.1016%2Fj.cub.2012.08.058) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23084992) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3543774) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XhsFCksrvN) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neuronal%20circuits%20underlying%20persistent%20representations%20despite%20time%20varying%20activity&journal=Curr.%20Biol.&doi=10.1016%2Fj.cub.2012.08.058&volume=22&pages=2095-2103&publication_year=2012&author=Druckmann%2CS&author=Chklovskii%2CDB)

[^13]: Maass, W., Natschläger, T. & Markram, H. Real-time computing without stable states: a new framework for neural computation based on perturbations. *Neural Comput* **14**, 2531–2560 (2002).

[Article](https://doi.org/10.1162%2F089976602760407955) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=12433288) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Real-time%20computing%20without%20stable%20states%3A%20a%20new%20framework%20for%20neural%20computation%20based%20on%20perturbations&journal=Neural%20Comput&doi=10.1162%2F089976602760407955&volume=14&pages=2531-2560&publication_year=2002&author=Maass%2CW&author=Natschl%C3%A4ger%2CT&author=Markram%2CH)

[^14]: Barak, O., Sussillo, D., Romo, R., Tsodyks, M. & Abbott, L. F. From fixed points to chaos: three models of delayed discrimination. *Prog. Neurobiol.* **103**, 214–222 (2013).

[Article](https://doi.org/10.1016%2Fj.pneurobio.2013.02.002) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23438479) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3622800) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=From%20fixed%20points%20to%20chaos%3A%20three%20models%20of%20delayed%20discrimination&journal=Prog.%20Neurobiol.&doi=10.1016%2Fj.pneurobio.2013.02.002&volume=103&pages=214-222&publication_year=2013&author=Barak%2CO&author=Sussillo%2CD&author=Romo%2CR&author=Tsodyks%2CM&author=Abbott%2CLF)

[^15]: Lisman, J. E. & Idiart, M. A. P. Storage of 7 ± 2 short-term memories in oscillatory subcycles. *Science* [https://doi.org/10.1126/science.7878473](https://doi.org/10.1126/science.7878473) (1995).

[^16]: Kopell, N., Whittington, M. A. & Kramer, M. A. Neuronal assembly dynamics in the beta1 frequency range permits short-term memory. *Proc. Natl. Acad. Sci.* **108**, 3779–3784 (2011).

[Article](https://doi.org/10.1073%2Fpnas.1019676108) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21321198) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3048142) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3MXivFOktbc%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neuronal%20assembly%20dynamics%20in%20the%20beta1%20frequency%20range%20permits%20short-term%20memory&journal=Proc.%20Natl.%20Acad.%20Sci.&doi=10.1073%2Fpnas.1019676108&volume=108&pages=3779-3784&publication_year=2011&author=Kopell%2CN&author=Whittington%2CMA&author=Kramer%2CMA)

[^17]: Champion, K. P., Gozel, O., Lankow, B. S., Ermentrout, G. B. & Goldman, M. S. An oscillatory mechanism for multi-level storage in short-term memory. *Commun. Biol.* **6**, 1–9 (2023).

[Article](https://doi.org/10.1038%2Fs42003-023-05200-7) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=An%20oscillatory%20mechanism%20for%20multi-level%20storage%20in%20short-term%20memory&journal=Commun.%20Biol.&doi=10.1038%2Fs42003-023-05200-7&volume=6&pages=1-9&publication_year=2023&author=Champion%2CKP&author=Gozel%2CO&author=Lankow%2CBS&author=Ermentrout%2CGB&author=Goldman%2CMS)

[^18]: Lundqvist, M., Herman, P. & Miller, E. K. Working memory: delay activity, yes! persistent activity? Maybe not. *J. Neurosci.* **38**, 7013–7019 (2018).

[Article](https://doi.org/10.1523%2FJNEUROSCI.2485-17.2018) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30089640) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6083456) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1cXit1KktLfK) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Working%20memory%3A%20delay%20activity%2C%20yes%21%20persistent%20activity%3F%20Maybe%20not&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.2485-17.2018&volume=38&pages=7013-7019&publication_year=2018&author=Lundqvist%2CM&author=Herman%2CP&author=Miller%2CEK)

[^19]: Mongillo, G., Barak, O. & Tsodyks, M. Synaptic theory of working memory. *Science* **319**, 1543–1546 (2008).

[Article](https://doi.org/10.1126%2Fscience.1150769) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18339943) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1cXjtVGqs78%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Synaptic%20theory%20of%20working%20memory&journal=Science&doi=10.1126%2Fscience.1150769&volume=319&pages=1543-1546&publication_year=2008&author=Mongillo%2CG&author=Barak%2CO&author=Tsodyks%2CM)

[^20]: Masse, N. Y., Yang, G. R., Song, H. F., Wang, X.-J. & Freedman, D. J. Circuit mechanisms for the maintenance and manipulation of information in working memory. *Nat. Neurosci.* **22**, 1159–1167 (2019).

[Article](https://doi.org/10.1038%2Fs41593-019-0414-3) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31182866) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7321806) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXhtFequr3N) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Circuit%20mechanisms%20for%20the%20maintenance%20and%20manipulation%20of%20information%20in%20working%20memory&journal=Nat.%20Neurosci.&doi=10.1038%2Fs41593-019-0414-3&volume=22&pages=1159-1167&publication_year=2019&author=Masse%2CNY&author=Yang%2CGR&author=Song%2CHF&author=Wang%2CX-J&author=Freedman%2CDJ)

[^21]: Kozachkov, L. et al. Robust and brain-like working memory through short-term synaptic plasticity. *PLoS Comput. Biol.* **18**, e1010776 (2022).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1010776) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=36574424) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC9829165) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3sXpvVelsA%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Robust%20and%20brain-like%20working%20memory%20through%20short-term%20synaptic%20plasticity&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1010776&volume=18&publication_year=2022&author=Kozachkov%2CL)

[^22]: Baeg, E. H. et al. Dynamics of population code for working memory in the prefrontal cortex. *Neuron* **40**, 177–188 (2003).

[Article](https://doi.org/10.1016%2FS0896-6273%2803%2900597-X) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=14527442) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3sXnvVygtro%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Dynamics%20of%20population%20code%20for%20working%20memory%20in%20the%20prefrontal%20cortex&journal=Neuron&doi=10.1016%2FS0896-6273%2803%2900597-X&volume=40&pages=177-188&publication_year=2003&author=Baeg%2CEH)

[^23]: Fujisawa, S., Amarasingham, A., Harrison, M. T. & Buzsáki, G. Behavior-dependent short-term assembly dynamics in the medial prefrontal cortex. *Nat. Neurosci.* **11**, 823–833 (2008).

[Article](https://doi.org/10.1038%2Fnn.2134) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18516033) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2562676) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1cXns1Onu78%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Behavior-dependent%20short-term%20assembly%20dynamics%20in%20the%20medial%20prefrontal%20cortex&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.2134&volume=11&pages=823-833&publication_year=2008&author=Fujisawa%2CS&author=Amarasingham%2CA&author=Harrison%2CMT&author=Buzs%C3%A1ki%2CG)

[^24]: Harvey, C. D., Coen, P. & Tank, D. W. Choice-specific sequences in parietal cortex during a virtual-navigation decision task. *Nature* **484**, 62–68 (2012).

[Article](https://doi.org/10.1038%2Fnature10918) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22419153) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3321074) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XjsleksL4%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Choice-specific%20sequences%20in%20parietal%20cortex%20during%20a%20virtual-navigation%20decision%20task&journal=Nature&doi=10.1038%2Fnature10918&volume=484&pages=62-68&publication_year=2012&author=Harvey%2CCD&author=Coen%2CP&author=Tank%2CDW)

[^25]: Zhu, J. et al. Transient delay-period activity of agranular insular cortex controls working memory maintenance in learning novel tasks. *Neuron* **105**, 934–946.e5 (2020).

[Article](https://doi.org/10.1016%2Fj.neuron.2019.12.008) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32135091) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXotFeltb0%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Transient%20delay-period%20activity%20of%20agranular%20insular%20cortex%20controls%20working%20memory%20maintenance%20in%20learning%20novel%20tasks&journal=Neuron&doi=10.1016%2Fj.neuron.2019.12.008&volume=105&pages=934-946.e5&publication_year=2020&author=Zhu%2CJ)

[^26]: Rabinovich, M. et al. Dynamical encoding by networks of competing neuron groups: winnerless competition. *Phys. Rev. Lett.* **87**, 068102 (2001).

[Article](https://doi.org/10.1103%2FPhysRevLett.87.068102) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11497865) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD3Mvlt1Khsg%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Dynamical%20encoding%20by%20networks%20of%20competing%20neuron%20groups%3A%20winnerless%20competition&journal=Phys.%20Rev.%20Lett.&doi=10.1103%2FPhysRevLett.87.068102&volume=87&publication_year=2001&author=Rabinovich%2CM)

[^27]: Afraimovich, V. S., Rabinovich, M. I. & Varona, P. Heteroclinic contours in neural ensembles and the winnerless competition principle. *Int. J. Bifurc. Chaos* **14**, 1195–1208 (2004).

[Article](https://doi.org/10.1142%2FS0218127404009806) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Heteroclinic%20contours%20in%20neural%20ensembles%20and%20the%20winnerless%20competition%20principle&journal=Int.%20J.%20Bifurc.%20Chaos&doi=10.1142%2FS0218127404009806&volume=14&pages=1195-1208&publication_year=2004&author=Afraimovich%2CVS&author=Rabinovich%2CMI&author=Varona%2CP)

[^28]: Afraimovich, V. S., Zhigulin, V. P. & Rabinovich, M. I. On the origin of reproducible sequential activity in neural circuits. *Chaos Interdiscip. J. Nonlinear Sci.* **14**, 1123–1129 (2004).

[Article](https://doi.org/10.1063%2F1.1819625) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD2crpsFOrug%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=On%20the%20origin%20of%20reproducible%20sequential%20activity%20in%20neural%20circuits&journal=Chaos%20Interdiscip.%20J.%20Nonlinear%20Sci.&doi=10.1063%2F1.1819625&volume=14&pages=1123-1129&publication_year=2004&author=Afraimovich%2CVS&author=Zhigulin%2CVP&author=Rabinovich%2CMI)

[^29]: Chaisangmongkon, W., Swaminathan, S. K., Freedman, D. J. & Wang, X.-J. Computing by robust transience: how the fronto-parietal network performs sequential, category-based decisions. *Neuron* **93**, 1504–1517.e4 (2017).

[Article](https://doi.org/10.1016%2Fj.neuron.2017.03.002) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28334612) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5586485) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXkvFWktbw%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Computing%20by%20robust%20transience%3A%20how%20the%20fronto-parietal%20network%20performs%20sequential%2C%20category-based%20decisions&journal=Neuron&doi=10.1016%2Fj.neuron.2017.03.002&volume=93&pages=1504-1517.e4&publication_year=2017&author=Chaisangmongkon%2CW&author=Swaminathan%2CSK&author=Freedman%2CDJ&author=Wang%2CX-J)

[^30]: Cueva, C. J. et al. Low-dimensional dynamics for working memory and time encoding. *Proc. Natl. Acad. Sci.* **117**, 23021–23032 (2020).

[Article](https://doi.org/10.1073%2Fpnas.1915984117) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32859756) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7502752) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXhvVCjurnP) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Low-dimensional%20dynamics%20for%20working%20memory%20and%20time%20encoding&journal=Proc.%20Natl.%20Acad.%20Sci.&doi=10.1073%2Fpnas.1915984117&volume=117&pages=23021-23032&publication_year=2020&author=Cueva%2CCJ)

[^31]: Ichikawa, K. & Kaneko, K. Short-term memory by transient oscillatory dynamics in recurrent neural networks. *Phys. Rev. Res.* **3**, 033193 (2021).

[Article](https://doi.org/10.1103%2FPhysRevResearch.3.033193) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3MXit1Oqs77O) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Short-term%20memory%20by%20transient%20oscillatory%20dynamics%20in%20recurrent%20neural%20networks&journal=Phys.%20Rev.%20Res.&doi=10.1103%2FPhysRevResearch.3.033193&volume=3&publication_year=2021&author=Ichikawa%2CK&author=Kaneko%2CK)

[^32]: Rajan, K., Harvey, C. D. & Tank, D. W. Recurrent network models of sequence generation and memory. *Neuron* **90**, 128–142 (2016).

[Article](https://doi.org/10.1016%2Fj.neuron.2016.02.009) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26971945) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4824643) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28XktVegt7g%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Recurrent%20network%20models%20of%20sequence%20generation%20and%20memory&journal=Neuron&doi=10.1016%2Fj.neuron.2016.02.009&volume=90&pages=128-142&publication_year=2016&author=Rajan%2CK&author=Harvey%2CCD&author=Tank%2CDW)

[^33]: Orhan, A. E. & Ma, W. J. A diverse range of factors affect the nature of neural representations underlying short-term memory. *Nat. Neurosci.* **22**, 275–283 (2019).

[Article](https://doi.org/10.1038%2Fs41593-018-0314-y) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30664767) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXmtF2jtbg%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20diverse%20range%20of%20factors%20affect%20the%20nature%20of%20neural%20representations%20underlying%20short-term%20memory&journal=Nat.%20Neurosci.&doi=10.1038%2Fs41593-018-0314-y&volume=22&pages=275-283&publication_year=2019&author=Orhan%2CAE&author=Ma%2CWJ)

[^34]: Huang, E. et al. *Hierarchical replay of multi-regional sequential spiking associated with working memory*. 2023.10.08.561458 Preprint at [https://doi.org/10.1101/2023.10.08.561458](https://doi.org/10.1101/2023.10.08.561458) (2023).

[^35]: Pinto, D. J. & Ermentrout, G. B. Spatially structured activity in synaptically coupled neuronal networks: I. Traveling fronts and pulses. *SIAM J. Appl. Math.* **62**, 206–225 (2001).

[Article](https://doi.org/10.1137%2FS0036139900346453) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Spatially%20structured%20activity%20in%20synaptically%20coupled%20neuronal%20networks%3A%20I.%20Traveling%20fronts%20and%20pulses&journal=SIAM%20J.%20Appl.%20Math.&doi=10.1137%2FS0036139900346453&volume=62&pages=206-225&publication_year=2001&author=Pinto%2CDJ&author=Ermentrout%2CGB)

[^36]: Bressloff, P. C. Spatiotemporal dynamics of continuum neural fields. *J. Phys. Math. Theor.* **45**, 033001 (2011).

[Article](https://doi.org/10.1088%2F1751-8113%2F45%2F3%2F033001) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Spatiotemporal%20dynamics%20of%20continuum%20neural%20fields&journal=J.%20Phys.%20Math.%20Theor.&doi=10.1088%2F1751-8113%2F45%2F3%2F033001&volume=45&publication_year=2011&author=Bressloff%2CPC)

[^37]: Mi, Y., Fung, C. C. A., Wong, K. Y. M. & Wu, S. Spike Frequency Adaptation Implements Anticipative Tracking in Continuous Attractor Neural Networks. *in Advances in Neural Information Processing Systems* (eds. Ghahramani, Z. et al.) 27 (Curran Associates, Inc., 2014).

[^38]: Bellec, G., Salaj, D., Subramoney, A., Legenstein, R. & Maass, W. Long short-term memory and learning-to-learn in networks of spiking neurons. *in Proceedings of the 32nd International Conference on Neural Information Processing Systems* 795–805 (Curran Associates Inc., Red Hook, NY, USA, 2018).

[^39]: Bellec, G. et al. A solution to the learning dilemma for recurrent networks of spiking neurons. *Nat. Commun.* **11**, 3625 (2020).

[Article](https://doi.org/10.1038%2Fs41467-020-17236-y) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32681001) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7367848) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20solution%20to%20the%20learning%20dilemma%20for%20recurrent%20networks%20of%20spiking%20neurons&journal=Nat.%20Commun.&doi=10.1038%2Fs41467-020-17236-y&volume=11&publication_year=2020&author=Bellec%2CG)

[^40]: Salaj, D. et al. Spike frequency adaptation supports network computations on temporally dispersed information. *eLife* **10**, e65459 (2021).

[Article](https://doi.org/10.7554%2FeLife.65459) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=34310281) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8313230) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB38XjtVGjt7g%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Spike%20frequency%20adaptation%20supports%20network%20computations%20on%20temporally%20dispersed%20information&journal=eLife&doi=10.7554%2FeLife.65459&volume=10&publication_year=2021&author=Salaj%2CD)

[^41]: Dudchenko, P. A. An overview of the tasks used to test working memory in rodents. *Neurosci. Biobehav. Rev.* **28**, 699–709 (2004).

[Article](https://doi.org/10.1016%2Fj.neubiorev.2004.09.002) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=15555679) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=An%20overview%20of%20the%20tasks%20used%20to%20test%20working%20memory%20in%20rodents&journal=Neurosci.%20Biobehav.%20Rev.&doi=10.1016%2Fj.neubiorev.2004.09.002&volume=28&pages=699-709&publication_year=2004&author=Dudchenko%2CPA)

[^42]: Niv, Y. Reinforcement learning in the brain. *J. Math. Psychol.* **53**, 139–154 (2009).

[Article](https://doi.org/10.1016%2Fj.jmp.2008.12.005) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Reinforcement%20learning%20in%20the%20brain&journal=J.%20Math.%20Psychol.&doi=10.1016%2Fj.jmp.2008.12.005&volume=53&pages=139-154&publication_year=2009&author=Niv%2CY)

[^43]: Nachstedt, T. & Tetzlaff, C. Working memory requires a combination of transient and attractor-dominated dynamics to process unreliably timed inputs. *Sci. Rep.* **7**, 2473 (2017).

[Article](https://doi.org/10.1038%2Fs41598-017-02471-z) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28559576) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5449410) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Working%20memory%20requires%20a%20combination%20of%20transient%20and%20attractor-dominated%20dynamics%20to%20process%20unreliably%20timed%20inputs&journal=Sci.%20Rep.&doi=10.1038%2Fs41598-017-02471-z&volume=7&publication_year=2017&author=Nachstedt%2CT&author=Tetzlaff%2CC)

[^44]: Turner, E., Dabholkar, K. & Barak, O. Charting and navigating the space of solutions for recurrent neural networks. *in Proceedings of the 35th International Conference on Neural Information Processing Systems* 25320–25333 (Curran Associates Inc., Red Hook, NY, USA, 2021).

[^45]: Song, H. F., Yang, G. R. & Wang, X.-J. Training excitatory-inhibitory recurrent neural networks for cognitive tasks: a simple and flexible framework. *PLOS Comput. Biol.* **12**, e1004792 (2016).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1004792) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26928718) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4771709) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Training%20excitatory-inhibitory%20recurrent%20neural%20networks%20for%20cognitive%20tasks%3A%20a%20simple%20and%20flexible%20framework&journal=PLOS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1004792&volume=12&publication_year=2016&author=Song%2CHF&author=Yang%2CGR&author=Wang%2CX-J)

[^46]: Kobak, D. et al. Demixed principal component analysis of neural population data. *eLife* **5**, e10989 (2016).

[Article](https://doi.org/10.7554%2FeLife.10989) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27067378) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4887222) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Demixed%20principal%20component%20analysis%20of%20neural%20population%20data&journal=eLife&doi=10.7554%2FeLife.10989&volume=5&publication_year=2016&author=Kobak%2CD)

[^47]: Zhang, K. Representation of spatial orientation by the intrinsic dynamics of the head-direction cell ensemble: a theory. *J. Neurosci.* **16**, 2112–2126 (1996).

[Article](https://doi.org/10.1523%2FJNEUROSCI.16-06-02112.1996) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=8604055) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6578512) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK28XhvVGns7w%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Representation%20of%20spatial%20orientation%20by%20the%20intrinsic%20dynamics%20of%20the%20head-direction%20cell%20ensemble%3A%20a%20theory&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.16-06-02112.1996&volume=16&pages=2112-2126&publication_year=1996&author=Zhang%2CK)

[^48]: Goldman, M. S. Memory without feedback in a neural network. *Neuron* **61**, 621–634 (2009).

[Article](https://doi.org/10.1016%2Fj.neuron.2008.12.012) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19249281) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2674525) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXlt1Klsbw%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Memory%20without%20feedback%20in%20a%20neural%20network&journal=Neuron&doi=10.1016%2Fj.neuron.2008.12.012&volume=61&pages=621-634&publication_year=2009&author=Goldman%2CMS)

[^49]: Yi, G. & Grill, W. M. Average firing rate rather than temporal pattern determines metabolic cost of activity in thalamocortical relay neurons. *Sci. Rep.* **9**, 6940 (2019).

[Article](https://doi.org/10.1038%2Fs41598-019-43460-8) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31061521) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6502890) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Average%20firing%20rate%20rather%20than%20temporal%20pattern%20determines%20metabolic%20cost%20of%20activity%20in%20thalamocortical%20relay%20neurons&journal=Sci.%20Rep.&doi=10.1038%2Fs41598-019-43460-8&volume=9&publication_year=2019&author=Yi%2CG&author=Grill%2CWM)

[^50]: Levy, W. B. & Calvert, V. G. Communication consumes 35 times more energy than computation in the human cortex, but both costs are needed to predict synapse number. *Proc. Natl. Acad. Sci.* **118**, e2008173118 (2021).

[Article](https://doi.org/10.1073%2Fpnas.2008173118) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=33906943) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8106317) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3MXhtVaqtrjN) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Communication%20consumes%2035%20times%20more%20energy%20than%20computation%20in%20the%20human%20cortex%2C%20but%20both%20costs%20are%20needed%20to%20predict%20synapse%20number&journal=Proc.%20Natl.%20Acad.%20Sci.&doi=10.1073%2Fpnas.2008173118&volume=118&publication_year=2021&author=Levy%2CWB&author=Calvert%2CVG)

[^51]: Baddeley, A. Working memory: theories, models, and controversies. *Annu. Rev. Psychol.* **63**, 1–29 (2012).

[Article](https://doi.org/10.1146%2Fannurev-psych-120710-100422) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21961947) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Working%20memory%3A%20theories%2C%20models%2C%20and%20controversies&journal=Annu.%20Rev.%20Psychol.&doi=10.1146%2Fannurev-psych-120710-100422&volume=63&pages=1-29&publication_year=2012&author=Baddeley%2CA)

[^52]: Edin, F. et al. Mechanism for top-down control of working memory capacity. *Proc. Natl. Acad. Sci.* **106**, 6802–6807 (2009).

[Article](https://doi.org/10.1073%2Fpnas.0901894106) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19339493) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2672558) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXlsV2ns7g%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mechanism%20for%20top-down%20control%20of%20working%20memory%20capacity&journal=Proc.%20Natl.%20Acad.%20Sci.&doi=10.1073%2Fpnas.0901894106&volume=106&pages=6802-6807&publication_year=2009&author=Edin%2CF)

[^53]: Almeida, R., Barbosa, J. & Compte, A. Neural circuit basis of visuo-spatial working memory precision: a computational and behavioral study. *J. Neurophysiol.* **114**, 1806–1818 (2015).

[Article](https://doi.org/10.1152%2Fjn.00362.2015) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26180122) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4571767) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20circuit%20basis%20of%20visuo-spatial%20working%20memory%20precision%3A%20a%20computational%20and%20behavioral%20study&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.00362.2015&volume=114&pages=1806-1818&publication_year=2015&author=Almeida%2CR&author=Barbosa%2CJ&author=Compte%2CA)

[^54]: Xie, Y. et al. *Natural constraints explain working memory capacity limitations in sensory-cognitive models*. 2023.03.30.534982 Preprint at [https://doi.org/10.1101/2023.03.30.534982](https://doi.org/10.1101/2023.03.30.534982) (2023).

[^55]: Drewnowski, A. & Murdock, B. B. The role of auditory features in memory span for words. *J. Exp. Psychol. Hum. Learn.* **6**, 319–332 (1980).

[Article](https://doi.org/10.1037%2F0278-7393.6.3.319) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=7373250) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL3c7otl2htQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20role%20of%20auditory%20features%20in%20memory%20span%20for%20words&journal=J.%20Exp.%20Psychol.%20Hum.%20Learn.&doi=10.1037%2F0278-7393.6.3.319&volume=6&pages=319-332&publication_year=1980&author=Drewnowski%2CA&author=Murdock%2CBB)

[^56]: Steele, R. J. & Morris, R. G. M. Delay-dependent impairment of a matching-to-place task with chronic and intrahippocampal infusion of the NMDA-antagonist D-AP5. *Hippocampus* **9**, 118–136 (1999).

[Article](https://doi.org/10.1002%2F%28SICI%291098-1063%281999%299%3A2%3C118%3A%3AAID-HIPO4%3E3.0.CO%3B2-8) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10226773) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK1MXjtVCqs7g%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Delay-dependent%20impairment%20of%20a%20matching-to-place%20task%20with%20chronic%20and%20intrahippocampal%20infusion%20of%20the%20NMDA-antagonist%20D-AP5&journal=Hippocampus&doi=10.1002%2F%28SICI%291098-1063%281999%299%3A2%3C118%3A%3AAID-HIPO4%3E3.0.CO%3B2-8&volume=9&pages=118-136&publication_year=1999&author=Steele%2CRJ&author=Morris%2CRGM)

[^57]: Heess, N., Hunt, J. J., Lillicrap, T. P. & Silver, D. *Memory-based control with recurrent neural networks*. Preprint at [https://doi.org/10.48550/arXiv.1512.04455](https://doi.org/10.48550/arXiv.1512.04455) (2015).

[^58]: Bick, C. & Rabinovich, M. I. Dynamical origin of the effective storage capacity in the brain’s working memory. *Phys. Rev. Lett.* **103**, 218101 (2009).

[Article](https://doi.org/10.1103%2FPhysRevLett.103.218101) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20366069) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Dynamical%20origin%20of%20the%20effective%20storage%20capacity%20in%20the%20brain%E2%80%99s%20working%20memory&journal=Phys.%20Rev.%20Lett.&doi=10.1103%2FPhysRevLett.103.218101&volume=103&publication_year=2009&author=Bick%2CC&author=Rabinovich%2CMI)

[^59]: Brette, R. Philosophy of the spike: rate-based vs. spike-based theories of the brain. *Front. Syst. Neurosci*. **9**, 151 (2015).

[^60]: Oberauer, K. et al. Benchmarks for models of short-term and working memory. *Psychol. Bull.* **144**, 885–958 (2018).

[Article](https://doi.org/10.1037%2Fbul0000153) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30148379) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Benchmarks%20for%20models%20of%20short-term%20and%20working%20memory&journal=Psychol.%20Bull.&doi=10.1037%2Fbul0000153&volume=144&pages=885-958&publication_year=2018&author=Oberauer%2CK)

[^61]: Howard, M. W. & Kahana, M. J. Contextual variability and serial position effects in free recall. *J. Exp. Psychol. Learn. Mem. Cogn.* **25**, 923–941 (1999).

[Article](https://doi.org/10.1037%2F0278-7393.25.4.923) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10439501) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK1MzmvVemtA%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Contextual%20variability%20and%20serial%20position%20effects%20in%20free%20recall&journal=J.%20Exp.%20Psychol.%20Learn.%20Mem.%20Cogn.&doi=10.1037%2F0278-7393.25.4.923&volume=25&pages=923-941&publication_year=1999&author=Howard%2CMW&author=Kahana%2CMJ)

[^62]: Bjork, R. A. & Whitten, W. B. Recency-sensitive retrieval processes in long-term free recall. *Cognit. Psychol.* **6**, 173–189 (1974).

[Article](https://doi.org/10.1016%2F0010-0285%2874%2990009-7) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Recency-sensitive%20retrieval%20processes%20in%20long-term%20free%20recall&journal=Cognit.%20Psychol.&doi=10.1016%2F0010-0285%2874%2990009-7&volume=6&pages=173-189&publication_year=1974&author=Bjork%2CRA&author=Whitten%2CWB)

[^63]: Murdock, B. B. Jr. The serial position effect of free recall. *J. Exp. Psychol.* **64**, 482–488 (1962).

[Article](https://doi.org/10.1037%2Fh0045106) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20serial%20position%20effect%20of%20free%20recall&journal=J.%20Exp.%20Psychol.&doi=10.1037%2Fh0045106&volume=64&pages=482-488&publication_year=1962&author=Murdock%2CBB)

[^64]: Tomé, D. F. et al. *Dynamic and selective engrams emerge with memory consolidation*. [https://doi.org/10.1101/2022.03.13.484167](https://doi.org/10.1101/2022.03.13.484167) (2022).

[^65]: Luboeinski, J. & Tetzlaff, C. Organization and priming of long-term memory representations with two-phase plasticity. *Cogn. Comput.* **15**, 1211–1230 (2023).

[Article](https://link.springer.com/doi/10.1007/s12559-022-10021-7) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Organization%20and%20priming%20of%20long-term%20memory%20representations%20with%20two-phase%20plasticity&journal=Cogn.%20Comput.&doi=10.1007%2Fs12559-022-10021-7&volume=15&pages=1211-1230&publication_year=2023&author=Luboeinski%2CJ&author=Tetzlaff%2CC)

[^66]: Zenke, F., Agnes, E. J. & Gerstner, W. Diverse synaptic plasticity mechanisms orchestrated to form and retrieve memories in spiking neural networks. *Nat. Commun.* **6**, 6922 (2015).

[Article](https://doi.org/10.1038%2Fncomms7922) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25897632) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXhtF2ltbfP) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Diverse%20synaptic%20plasticity%20mechanisms%20orchestrated%20to%20form%20and%20retrieve%20memories%20in%20spiking%20neural%20networks&journal=Nat.%20Commun.&doi=10.1038%2Fncomms7922&volume=6&publication_year=2015&author=Zenke%2CF&author=Agnes%2CEJ&author=Gerstner%2CW)

[^67]: Pleines, M., Pallasch, M., Zimmer, F. & Preuss, M. Memory gym: partially observable challenges to memory-based agents. in *The Eleventh International Conference on Learning Representations* (2023).

[^68]: Chevalier-Boisvert, M. et al. Minigrid & Miniworld: modular & customizable reinforcement learning environments for goal-oriented tasks. In *Advances in Neural Information Processing Systems 36* (NIPS, 2024).

[^69]: Schulman, J., Wolski, F., Dhariwal, P., Radford, A. & Klimov, O. *Proximal Policy Optimization Algorithms*. Preprint at [http://arxiv.org/abs/1707.06347](http://arxiv.org/abs/1707.06347) (2017).

[^70]: Petrenko, A., Huang, Z., Kumar, T., Sukhatme, G. & Koltun, V. Sample factory: egocentric 3D control from pixels at 100,000 FPS with asynchronous reinforcement learning. *in Proceedings of the 37th International Conference on Machine Learning* 119, 7652–7662 (JMLR.org, 2020).

[^71]: Mann, H. B. & Whitney, D. R. On a test of whether one of two random variables is stochastically larger than the other. *Ann. Math. Stat.* **18**, 50–60 (1947).

[Article](https://doi.org/10.1214%2Faoms%2F1177730491) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=On%20a%20test%20of%20whether%20one%20of%20two%20random%20variables%20is%20stochastically%20larger%20than%20the%20other&journal=Ann.%20Math.%20Stat.&doi=10.1214%2Faoms%2F1177730491&volume=18&pages=50-60&publication_year=1947&author=Mann%2CHB&author=Whitney%2CDR)