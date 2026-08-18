---
title: "Hybrid neural networks for continual learning inspired by corticohippocampal circuits"
source: "https://www.nature.com/articles/s41467-025-56405-9"
author:
  - "[[Qianqian Shi]]"
  - "[[Faqiang Liu]]"
  - "[[Hongyi Li]]"
  - "[[Guangyu Li]]"
  - "[[Luping Shi]]"
  - "[[Rong Zhao]]"
published: 2025-02-02
created: 2026-06-26
description: "Current artificial systems suffer from catastrophic forgetting during continual learning, a limitation absent in biological systems. Biological mechanisms leverage the dual representation of specific and generalized memories within corticohippocampal circuits to facilitate lifelong learning. Inspired by this, we develop a corticohippocampal circuits-based hybrid neural network (CH-HNN) that emulates these dual representations, significantly mitigating catastrophic forgetting in both task-incremental and class-incremental learning scenarios. Our CH-HNNs incorporate artificial neural networks and spiking neural networks, leveraging prior knowledge to facilitate new concept learning through episode inference, and offering insights into the neural functions of both feedforward and feedback loops within corticohippocampal circuits. Crucially, CH-HNN operates as a task-agnostic system without increasing memory demands, demonstrating adaptability and robustness in real-world applications. Coupled with the low power consumption inherent to SNNs, our model represents the potential for energy-efficient, continual learning in dynamic environments. Energy-efficient, task-agnostic continual learning is a key challenge in Artificial Intelligence frameworks. Here, authors propose a hybrid neural network that emulates dual representations in corticohippocampal circuits, reducing the effect of catastrophic forgetting."
tags:
  - "clippings"
---
## Abstract

Current artificial systems suffer from catastrophic forgetting during continual learning, a limitation absent in biological systems. Biological mechanisms leverage the dual representation of specific and generalized memories within corticohippocampal circuits to facilitate lifelong learning. Inspired by this, we develop a corticohippocampal circuits-based hybrid neural network (CH-HNN) that emulates these dual representations, significantly mitigating catastrophic forgetting in both task-incremental and class-incremental learning scenarios. Our CH-HNNs incorporate artificial neural networks and spiking neural networks, leveraging prior knowledge to facilitate new concept learning through episode inference, and offering insights into the neural functions of both feedforward and feedback loops within corticohippocampal circuits. Crucially, CH-HNN operates as a task-agnostic system without increasing memory demands, demonstrating adaptability and robustness in real-world applications. Coupled with the low power consumption inherent to SNNs, our model represents the potential for energy-efficient, continual learning in dynamic environments.

## Introduction

In recent years, artificial intelligence (AI) has achieved remarkable advances, becoming integral to our daily lives, especially with the development of the generative pre-trained transformer [^1]. However, current AI systems still rely on training with entire datasets at once, lacking the ability to incrementally add new data without disrupting the existing model. This limitation presents challenges of catastrophic forgetting in environments that require incremental learning from temporally ordered data. To mitigate this issue, adaptive learning strategies known as continual learning or lifelong learning have garnered increasing attention in research. Despite significant advancements, current methods face persistent challenges, including the need for explicit task identification during inference and the increasing memory demands associated with storing samples or features from previous tasks or classes. These limitations significantly hinder the practical application of continual learning in dynamic, real-world environments. Consequently, the development of task-agnostic approaches to enhance the practical implementation of continual learning in real-world scenarios remains a critical area of research.

In contrast, biological systems demonstrate exceptional efficiency in incremental learning with low energy consumption, underscoring the potential for brain-inspired algorithms to enhance the continual learning capabilities of AI by emulating the neural mechanisms underlying lifelong learning.

Neuroscientific research has revealed that corticohippocampal circuits play a critical role in the efficacy of episodic learning and generalization, which are fundamental for lifelong learning. Specifically, the medial prefrontal cortex (mPFC) [^2] and the CA1 [^3] region of the hippocampus (HPC) are thought to represent regularities across related episodes, responding to correlated episodes encountered previously. While regions like the dentate gyrus (DG) and CA3 within the HPC are believed to encode specific memories, selectively responding to particular episodes. Together, these interconnected brain regions form a recurrent loop between the mPFC and HPC, hypothesized to drive the integration of episodic information, facilitating both generalization across episodes and the learning of new concepts.

Within this loop, the mPFC-CA1 circuits transmit high-order information derived from prior episodes to modulate novel learning in the DG-CA3 circuits, which subsequently relays newly formed associative memories back to the mPFC-CA1 circuits, thus enhancing the encoding of episode-related regularities [^4], as depicted in Fig. [1](https://www.nature.com/articles/s41467-025-56405-9#Fig1).

![Fig. 1: Widespread corticohippocampal circuits: facilitating and characterizing dual representation for episode learning and generalization.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-56405-9/MediaObjects/41467_2025_56405_Fig1_HTML.png?as=webp)

Fig. 1: Widespread corticohippocampal circuits: facilitating and characterizing dual representation for episode learning and generalization.

In this study, we emulate the dual representation of corticohippocampal recurrent loops and develop a hybrid neural network, termed CH-HNN, for artificial systems. CH-HNN provides a task-agnostic approach to reduce memory overhead and enhance the practical application of continual learning in real-world scenarios. By integrating artificial neural networks (ANNs) and spiking neural networks (SNNs), we replicate the complementary roles of specific and generalized memory representations within these circuits. ANNs, extensively developed in computer vision, excel at processing high spatial complexity and abstracting image regularities [^5] [^6], analogous to the role of mPFC-CA1 circuits that integrate regularities across episodes. In contrast, SNNs, with sparse firing rates and consequently low power consumption [^7], are used to incrementally encode new concepts, simulating the function of DG-CA1 circuits in specific episode memory formation, as illustrated in Fig. [2](https://www.nature.com/articles/s41467-025-56405-9#Fig2) a. The regularities abstracted by the ANNs are designed to guide the SNNs to incrementally learn novel concepts via episode inference. CH-HNN overcomes traditional challenge of integrating these distinct network types and reveals new insights into their synergistic potential.

![Fig. 2: Hybrid neural networks based on corticohippocampus circuits and metaplasticity mechanisms.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-56405-9/MediaObjects/41467_2025_56405_Fig2_HTML.png?as=webp)

Fig. 2: Hybrid neural networks based on corticohippocampus circuits and metaplasticity mechanisms.

Additionally, we incorporate metaplasticity mechanisms [^8] [^9] into the CH-HNN to simulate the dynamic changes in synaptic learning ability as knowledge accumulates. Specifically, episode-related regularities are believed to have side effects, which could increase the incidence of false alarms when recognizing highly similar episodes in the brain [^10]. To mitigate this, the interaction between the lateral parietal cortex (LPC) and DG-CA3 circuits, which encode specific memories, is thought to play a crucial role in reducing such errors [^11]. Inspired by this, our model hypothesizes that the LPC modulates the metaplasticity of DG-CA3 circuits by preserving synaptic weights across similar episodes.

To evaluate the effectiveness of CH-HNN in continual learning, we applied it to the split MNIST (sMNIST), permuted MNIST (pMNIST) [^12], and split CIFAR-100 [^13] (sCIFAR-100) in task-incremental scenarios, as well as the sMNIST, sCIFAR-100, split Tiny-ImageNet [^14] (sTiny-ImageNet), and split DVS Gesture datasets [^15] in class-incremental scenarios. Compared to alternative methods, CH-HNN demonstrates superior performance and achieves a more favorable balance between plasticity (the capacity to learn new information) and stability (the ability to retain previously acquired knowledge), a critical duality in the field of continual learning [^16]. Furthermore, CH-HNN demonstrates the ability to transfer related-episode information across various datasets, highlighting its capacity for effective knowledge transfer in diverse scenarios.

To investigate the role of the feedback loop from DG-CA3 to mPFC-CA1 in facilitating the encoding of episode-related information, we implemented an incremental learning framework for the ANN within CH-HNN instead of an offline learning approach. The results indicate that as the ANN incrementally accumulates knowledge over time, its proficiency in encoding related-episode regularities significantly improves. These findings suggest that this feedback loop plays a crucial role in promoting episodic generalization by relaying novel embedding.

Aligned with our goal of enhancing continual learning in real-world scenarios, CH-HNN demonstrates strong adaptability and robustness across diverse applications. When implemented on neuromorphic hardware, the integration of SNNs significantly reduces power consumption, highlighting the model’s potential for energy-efficient deployment in dynamic environments.

In summary, the CH-HNN, inspired by corticohippocampal recurrent loops in the brain, effectively mitigates catastrophic forgetting in both task-incremental and class-incremental scenarios. It demonstrates robustness in real-world applications and shows potential for future implementation into neuromorphic hardware. Furthermore, our study provides evidence that enhances the understanding of the neural mechanisms underlying corticohippocampal functions, contributing to a deeper understanding of lifelong learning from a computational neuroscience perspective.

## Results

### Corticohippocampal recurrent loops for episode learning and generalization

Recent research increasingly supports the view that the brain does not represent concepts solely through individual engrams during continuous episodic learning [^3] [^4] [^17]. Instead, the brain processes episodic information at multiple levels of specificity, enabling the formation of both generalized knowledge across related episodes and the retention of specific episodic details [^18]. The complementary learning systems theory offers an explanation for the distinct yet complementary roles of the cortex and hippocampus in memory processing [^19]. In this framework, the cortex, particularly the mPFC [^18] [^20] and the enhorital cortex (EC) [^21], is implicated in representing generalized regularities across related experiences—a process referred to as memory integration. This generalized information is subsequently conveyed through the medial temporal lobe (MTL) [^2] [^22] to the hippocampus. Within the hippocampus, the CA1 region is thought to mediate interactions between these cortical areas and hippocampal subregions responsible for specific memory representations, such as the DG and CA3. These neural pathways are believed to facilitate the transfer of generalized information, thereby enhancing the learning of new, related concepts [^23].

To streamline the process of memory integration and specific memory learning, we simplify the neural pathways representing generalized episodic information—likely involving the mPFC, MTL, EC, and CA1 regions—into a direct mPFC-CA1 pathway (depicted in pink in Fig. [1](https://www.nature.com/articles/s41467-025-56405-9#Fig1) b). Concurrently, the circuits associated with specific memory representations within the hippocampus are refined to focus on the DG-CA3 pathways (shown in green in Fig. [1](https://www.nature.com/articles/s41467-025-56405-9#Fig1) b). This refinement results in a recurrent loop, wherein the mPFC-CA1 pathway facilitates the efficient acquisition of novel, specific memories in the DG-CA3 pathways. In turn, the DG-CA3 circuits transfer these newly embedded memories back to the mPFC-CA1 circuits, thereby promoting the integration of related memories [^4]. We anticipate that these simplified neural mechanisms underlying continual memory learning could inspire novel computational strategies to enhance continual learning in artificial systems.

### Hybrid neural networks designed to emulate corticohippocampal recurrent loop

Based on the corticohippocampal recurrent loop, we designed a hybrid model to simulate the bidirectional facilitation between the mPFC-CA1 and DG-CA3 circuits.

To emulate the function of memory integration in the mPFC-CA1 circuits, we leveraged the ANN’s proficiency in processing high spatial complexity [^6] [^7] [^24] and developed an ANN that learns the similarities among different episodes or concepts, generating a modulation signal aimed at facilitating the learning of new episodes or concepts. Specifically, the modulation signals generated by the ANN are constrained to reflect the similarity between coarse-grained input features from different tasks or classes, with the goal of guiding new concept learning.

To simulate the function of novel learning in the DG-CA3 circuits, we utilize SNNs due to their sparse firing rates and consequently lower power consumption [^7] [^24], enabling them to learn new concepts associated with tasks or classes.

During the learning process, ANNs generate modulation signals in response to each visual input. These modulation signals serve as masks, selectively activating neurons in the hidden layers of the SNNs and thereby altering the neural synchrony state across different episodes, as illustrated in Fig. [2](https://www.nature.com/articles/s41467-025-56405-9#Fig2) a. Therefore, the modulation signals vary significantly with dissimilar inputs, enabling the automatic partitioning of SNNs into distinct sub-networks under the guidance of the ANNs. As a result, the ANNs take on the role of episode inference, assisting the SNNs in selecting episode-related neurons for each task or class. This design enhances resource utilization within the SNNs, reduces interference between different episodes, and thereby improves overall learning efficiency.

Notably, the ANNs within CH-HNN can be trained offline or over longer time scales than SNNs, aligning with the neural mechanisms underlying the slower formation of regularities in the mPFC-CA1 circuits during processes such as sleep or gradual learning [^25] [^26].

### Introduce metaplasticity mechanism to CH-HNN

In the corticohippocampal loops, research indicates that the modulation signals from the mPFC-CA1 circuit may lead to an increase in false alarms among episodes with high similarity [^10] [^27] [^28], potentially due to the highly similar neural synchrony in downstream circuits. To counteract this hypothesis and enhance the performance of our hybrid neural networks, we introduce a metaplasticity mechanism [^8], which allows synapses to exhibit variable learning capabilities. Typically, metaplasticity at each synapse is modulated by chemical neuromodulatory signals, such as dopamine and serotonin [^9], which can manifest as changes in the size of synaptic spines, as illustrated in Fig. [2](https://www.nature.com/articles/s41467-025-56405-9#Fig2) b. In this study, we propose that the LPC [^11], particularly the angular gyrus (ANG), and the lateral prefrontal cortex (lPFC) [^29], which are involved in representing recalled content-specific memories, may play a role in modulating synaptic metaplasticity in the DG-CA3 circuit (Fig. [1](https://www.nature.com/articles/s41467-025-56405-9#Fig1) a).

To implement the metaplasticity mechanism in SNNs, we adopt an exponential meta-function, as proposed in [^30], to simulate plasticity dynamics of biological synapses. As synaptic weights increase in magnitude, the meta-function output decreases from 1 to 0, as illustrated in Fig. [2](https://www.nature.com/articles/s41467-025-56405-9#Fig2) c. Integrating the meta-function into the optimization process during SNN training gradually diminishes each synapse’s learning capacity as knowledge accumulates (details in Methods). This approach has proven effective in alleviating catastrophic forgetting in binary neural networks [^31] and SNNs [^9] [^30].

Thus far, we have outlined the development of the CH-HNN framework. Moving forward, we will assess its performance and adaptability across both task-incremental and class-incremental learning scenarios using a range of datasets.

### CH-HNN demonstrates superior performance in task-incremental learning scenarios

In the task-incremental learning scenario, tasks with different classes are learned sequentially, requiring the model to identify each task after learning multiple tasks, as illustrated in Fig. [3](https://www.nature.com/articles/s41467-025-56405-9#Fig3) a. To evaluate our model’s performance, we conducted task-incremental learning experiments using various datasets, including sMNIST, pMNIST, and sCIFAR-100. We compared our approach against several established methods on both ANNs and SNNs, including elastic weight consolidation (EWC) [^32], synaptic intelligence (SI) [^33], and context-dependent gating (XdG) [^34]. Additionally, we utilized finely-tuned SNN and ANN models as baselines for comparison.

![Fig. 3: CH-HNN improves the performance of task-incremental learning across multiple datasets.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-56405-9/MediaObjects/41467_2025_56405_Fig3_HTML.png?as=webp)

Fig. 3: CH-HNN improves the performance of task-incremental learning across multiple datasets.

In the CH-HNN model, the ANN is optimized by ensuring consistency between the similarity of the generated modulation signals and the similarity of corresponding samples in the prior knowledge, rather than relying on direct supervised labels for the output modulation signals. This approach addresses the challenge of constructing labels in training datasets for ANN and enhances the model’s adaptability to different tasks.

For the pMNIST dataset, which consists of 784! (the factorial of 28 × 28) permutations, we randomly selected 40 permutations to serve as tasks that are learned incrementally. The remaining permutations were used as prior knowledge to train the ANN to generate task-related modulation signals. To establish similarities between tasks, we grouped the permutations into clusters, with each cluster comprising four similar permutations, enabling the ANN to learn the relationships among tasks through the training samples. For the sMNIST, and sCIFAR-100 datasets, which lack natural task relationships, we manually specified task similarities, assigning a value of 1 within the same task and 0 between different tasks. This setup allows the ANN to perform episode inference based on the input samples from the test dataset.

To assess the effectiveness of the ANN-generated modulation signals in capturing relationships between various tasks, we computed correlation matrices among these signals, which were generated from visual samples in a test dataset. Using the pMNIST dataset as an example—where 40 tasks are grouped into clusters, with each cluster comprising four similar permutations—the correlation matrix (Fig. [3](https://www.nature.com/articles/s41467-025-56405-9#Fig3) h) closely mirrors the patterns observed among visual samples of the permutations (Fig. [3](https://www.nature.com/articles/s41467-025-56405-9#Fig3) b). This alignment suggests that ANNs can effectively generate task-related regularities in response to novel stimuli, thereby enabling dynamic episode inference.

With the architecture remaining unchanged in the continual learning framework, all algorithms were finely tuned. The experimental results indicate that, as the number of tasks increases, the CH-HNN model exhibits a progressively greater performance advantage compared to other methods, as demonstrated in Fig. [3](https://www.nature.com/articles/s41467-025-56405-9#Fig3) c–e.

At the final incremental stage, the CH-HNN model demonstrates a significant performance advantage over EWC, SI, and the fine-tuned baseline. On both the pMNIST and sCIFAR-100 datasets, CH-HNN substantially outperforms the XdG method. Moreover, CH-HNN maintains consistent performance across tasks, achieving the lowest inter-episode disparity—defined as the difference between the highest and lowest accuracy at the final stage. For example, on the sCIFAR-100 dataset, CH-HNN achieves an inter-episode disparity of 17.32%, markedly lower than XdG’s 48.76%. These results highlight CH-HNN’s superior balance between stability and plasticity, a key metric in continual learning, as illustrated in Fig. [3](https://www.nature.com/articles/s41467-025-56405-9#Fig3) f, g (with further details in Supplementary Table [3](https://www.nature.com/articles/s41467-025-56405-9#MOESM1)).

Additionally, although the XdG method performs comparably to CH-HNN on the sMNIST dataset, it requires explicit task identification (ID) during both the training and inference phases, which constrains its applicability in real-world scenarios, the task-agnostic CH-HNN method not only achieves strong performance across diverse datasets in task-incremental settings but also eliminates the need for task ID, indicating its potential for real-world implementation.

### CH-HNN demonstrates superior performance in class-incremental learning scenarios

To explore more complex applications, we extended our investigation to class-incremental learning using the sMNIST, sCIFAR-100, and sTiny-ImageNet datasets. In these scenarios, the model incrementally learns multiple classes and must ultimately recognize all previously learned classes, as illustrated in Fig. [4](https://www.nature.com/articles/s41467-025-56405-9#Fig4) a.

![Fig. 4: CH-HNN enhances the performance of class-incremental learning on various datasets.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-56405-9/MediaObjects/41467_2025_56405_Fig4_HTML.png?as=webp)

Fig. 4: CH-HNN enhances the performance of class-incremental learning on various datasets.

To facilitate this process, we employed a masking method that selectively activates output neurons corresponding to the current classes while suppressing those of other classes, ensuring efficient learning and minimizing interference among classes. Unlike task-incremental scenarios, which require constructing relationships among tasks that encompass various classes, the challenge here lies in training the ANN to develop relationships among individual classes that have natural similarities. To address this, we used cosine similarity to compute the similarity between the statistics of feature maps from different categories during ANN training (see details in Methods). This approach enables the ANN to automatically generate modulation signals in response to each visual sample. Take the sTiny-ImageNet dataset as an example, we demonstrate the successful construction of an ANN capable of generating related-episode information across different classes by comparing the correlation matrix between modulation signals (Fig. [4](https://www.nature.com/articles/s41467-025-56405-9#Fig4) h) with the correlation matrix between visual samples within a class (Fig. [4](https://www.nature.com/articles/s41467-025-56405-9#Fig4) b).

In addition to the EWC, SI, XdG, and baseline methods employed in task-incremental learning, we further incorporate state-of-the-art methods such as iCaRL [^35] and FOSTER [^36] for class-incremental scenarios. These methods, widely regarded as benchmarks in recent years, are better suited for class-incremental learning compared to EWC and SI, enabling a more comprehensive evaluation of CH-HNN.

For the experiments with iCaRL and FOSTER, we follow the parameter settings and utilized ResNet32 as specified in their respective publications. The experiments with EWC and SI are conducted using ANNs, which align more closely with their methodologies. For CH-HNN and XdG, we evaluate various spiking neuron models, including exponential integrate-and-fire (EIF) [^37], leaky integrate-and-fire (LIF) [^38], and integrate-and-fire (IF) [^39] models, applied within SNNs to assess their performance.

With the architecture unchanged in the continual learning framework, all algorithms are optimally tuned. The experimental results show that both EWC and SI perform poorly in class-incremental learning, consistent with previous findings [^40]. Our CH-HNN model, regardless of the neuron model used, outperforms all other state-of-the-art task-agnostic methods, including iCaRL and FOSTER, as well as metaplasticity approaches (Fig. [4](https://www.nature.com/articles/s41467-025-56405-9#Fig4) c, d, e). Interestingly, as the complexity of the neuron models increases, CH-HNN demonstrates progressively better performance, likely attributed to the enhanced non-linearity of the spiking models.

Notably, while XdG with the LIF neuron model performs comparably in the sMNIST dataset and even exceeds the performance of CH-HNN in the sCIFAR-100 dataset, its performance declines in the sTiny-ImageNet dataset as the number of tasks increases. This decline may result from increased neuron overlap across tasks due to XdG’s random neuron allocation strategy. Additionally, at the final stage of incremental learning, the inter-episode disparity of CH-HNN is 44.34% in the sTiny-ImageNet dataset and 21.47% in the sCIFAR-100 dataset, both of which are lower than or comparable to those of other methods (see Supplementary Table [5](https://www.nature.com/articles/s41467-025-56405-9#MOESM1) for further details), as illustrated in Fig. [4](https://www.nature.com/articles/s41467-025-56405-9#Fig4) f, g.

Furthermore, CH-HNN dynamically generates episode-related regularities based on visual input during both training and testing phases, enabling task-agnostic learning. In contrast, XdG relies on explicit task identification during both training and inference, highlighting CH-HNN’s superior adaptability and suitability for real-world applications.

### Knowledge transfer from prior knowledge to new concept learning

With the hypothesis that the mPFC-CA1 circuits learn regularities that summarize related information from prior knowledge, it is crucial to explore whether the ANNs in our CH-HNN model can effectively transfer related-episode knowledge across different datasets, as illustrated in Fig. [5](https://www.nature.com/articles/s41467-025-56405-9#Fig5) a. Therefore, we conducted experiments where ANNs were pre-trained on prior knowledge derived from the ImageNet dataset and then assessed their performance on the sCIFAR-100 and sTiny-ImageNet datasets. To ensure the priors were distinct, we followed the methodology of ref. [^41] to exclude classes overlapping with CIFAR-100 and Tiny-ImageNet from ImageNet. These experiments utilized the EIF neuron model, which demonstrated the highest performance in class-incremental scenarios for both datasets within the CH-HNN framework.

![Fig. 5: CH-HNN demonstrates the efficacy of the feedback loop.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-56405-9/MediaObjects/41467_2025_56405_Fig5_HTML.png?as=webp)

Fig. 5: CH-HNN demonstrates the efficacy of the feedback loop.

By incorporating an ANN pre-trained on prior knowledge, the CH-HNN model continues to significantly outperform other state-of-the-art methods on both sCIFAR-100 and sTiny-ImageNet, demonstrating its ability to transfer knowledge across datasets. This success stems from the ANN component, which effectively learns to extract regularities from prior experiences. The strong alignment between the correlation matrix of modulation signals and sample representations (see Supplementary Fig. [6](https://www.nature.com/articles/s41467-025-56405-9#MOESM1) c, d) further supports this capability.

### The evaluation of the feedback loop within the corticohippocampal circuits

In evaluating the efficacy of episode-related information in task-incremental and class-incremental learning, we have validated the role of episode-related regularities in enhancing the learning of novel concepts, thus supporting the function of the feed-forward loop from mPFC-CA1 to DG-CA3 circuits. To further investigate the functional role of the feedback loop from DG-CA3 to mPFC-CA1 circuits, which is believed to transmit novel embeddings to promote generalization across related episodes [^4], we designed experiments where the ANN incrementally learns the classes in the sCIFAR-100 and sTiny-ImageNet datasets.

In the ANN’s incremental learning process, we employed metaplasticity mechanism to mitigate forgetting of previously learned regularities. This approach enables the ANN to continuously learn new embeddings, enhancing its ability to extract episode-related regularities. As the ANN incrementally learns classes, CH-HNN demonstrates improved efficiency, as illustrated in Fig. [5](https://www.nature.com/articles/s41467-025-56405-9#Fig5) e, f. The correlation matrix, which assesses the consistency of regularities with the sample representations, also demonstrated improvement after learning all classes, exemplified by the sTiny-ImageNet dataset in Supplementary Fig. [6](https://www.nature.com/articles/s41467-025-56405-9#MOESM1) e and [6](https://www.nature.com/articles/s41467-025-56405-9#MOESM1) f. These results indicate that as the ANN in CH-HNN accumulates prior knowledge, its ability to generalize across episodes improves.

Collectively, these findings validate the efficacy of the feedback loop (CA1-CA3 to mPFC-CA1) in transmitting novel embeddings to promote generalization across related episodes, contributing to a deeper understanding of the corticohippocampal neural mechanisms that support lifelong learning.

### Lesion experiments

To dissect the contributions of episode inference from ANN’s modulation signals and metaplasticity mechanisms within our CH-HNN framework, we conducted a series of ablation studies targeting these core mechanisms.

For the pMNIST dataset, both mechanisms play a substantial role in enhancing continual learning. Metaplasticity, in particular, enhances stability by balancing the retention of old knowledge with the integration of new information, resulting in a lower inter-episode disparity (12.53%) compared to episode inference alone (29.77%). Episode inference, meanwhile, enhances overall performance by improving average accuracy, reaching a mean of 70.41% (Fig. [5](https://www.nature.com/articles/s41467-025-56405-9#Fig5) g).

In class-incremental experiments on sTiny-ImageNet, metaplasticity has a limited effect, while episode inference plays a critical role in enhancing the CH-HNN model’s performance, achieving 70.70%, which is comparable to the full CH-HNN model’s performance of 70.72%. However, when ANN guidance is based on priors from less-relevant datasets—thus decreasing guidance accuracy—metaplasticity becomes particularly beneficial, increasing the average accuracy from 42.89% to 47.23% (see Fig. [5](https://www.nature.com/articles/s41467-025-56405-9#Fig5) h, i, and Supplementary Table [6](https://www.nature.com/articles/s41467-025-56405-9#MOESM1)).

In summary, both episode inference and metaplasticity are essential to our CH-HNN model: episode inference provides the primary boost to overall performance, while metaplasticity offers crucial support under conditions of inaccurate guidance by balancing the retention of old and new knowledge through the preservation of synaptic weights from prior episodes.

### Applicability and robustness of CH-HNN in real-world implementation

Most high-performing continual learning algorithms, including XdG methods and the recently proposed channel-wise lightweight reprogramming methods [^42], rely on a perfect task oracle during the inference phase to accurately identify the task for each test image. This dependence complicates their deployment in dynamic real-world environments. In contrast, our CH-HNN model is designed for task-agnostic learning, enabling straightforward implementation across diverse real-world scenarios.

The applicability of CH-HNN is well-aligned with the growing adoption of hybrid ANN-SNN architectures in neuromorphic hardware [^43] [^44], such as PAICORE [^45] and “Tianjic” chip [^46], which support configurable cores capable of operating as either ANN or SNN components. Considering the precision constraints of most neuromorphic hardware, we reduce the CH-HNN model’s precision from float32 to int8, observing minimal performance loss (Supplementary Fig. [4](https://www.nature.com/articles/s41467-025-56405-9#MOESM1) c). Furthermore, simulation results from a cycle-accurate simulator, validated by refs. [^47] [^48], show that SNNs offer a significant advantage in reducing power consumption by 60.82% compared to ANNs in new concept learning (Fig. [6](https://www.nature.com/articles/s41467-025-56405-9#Fig6) e). These findings underscore the suitability of CH-HNN for low-power neuromorphic hardware applications.

![Fig. 6: CH-HNN demonstrates adaptiveness and robustness in real-world applications.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-56405-9/MediaObjects/41467_2025_56405_Fig6_HTML.png?as=webp)

Fig. 6: CH-HNN demonstrates adaptiveness and robustness in real-world applications.

To validate the robustness of our CH-HNN model in real-world applications, we implemented it in two practical settings. First, we applied CH-HNN to a pMNIST recognition task using a quadruped robot equipped with a real-time camera. The robot uses OpenCV [^49] to crop MNIST images, which are processed by the ANNs within CH-HNN to generate modulation signals for episode inference, guiding the SNNs for accurate recognition. Recognized images trigger actions such as nodding or looking upwards (Fig. [6](https://www.nature.com/articles/s41467-025-56405-9#Fig6) a, Supplementary Movie [1](https://www.nature.com/articles/s41467-025-56405-9#MOESM3)).

Second, we applied CH-HNN, trained in a class-incremental manner on sCIFAR-100 data, to an object grasping task using YOLO detection [^50]. CH-HNN identified objects (e.g., distinguishing “Apple” and “Not Apple”) within the camera’s field of view, enabling precise robotic arm grasping (Fig. [6](https://www.nature.com/articles/s41467-025-56405-9#Fig6) b, Supplementary Movie [2](https://www.nature.com/articles/s41467-025-56405-9#MOESM4)). In a robustness evaluation involving sCIFAR-100 objects under varied positions and angles, CH-HNN achieved an average accuracy of 82% (±7.25%) over 30 trials, demonstrating its robustness under diverse conditions. The experiment included objects from both early and late learning stages, with CH-HNN outperforming methods like EWC in addressing the stability-plasticity dilemma (Fig. [6](https://www.nature.com/articles/s41467-025-56405-9#Fig6) c, and Supplementary Fig. [4](https://www.nature.com/articles/s41467-025-56405-9#MOESM1) a). Additionally, CH-HNN shows resilience under Gaussian noise, maintaining acceptable performance despite some degradation (Fig. [6](https://www.nature.com/articles/s41467-025-56405-9#Fig6) d).

Consequently, our CH-HNN method demonstrates both applicability and robustness in realistic scenarios. Furthermore, with integrated spiking unit structures, CH-HNN offers the added advantage of low power consumption.

## Discussion

The challenge of catastrophic forgetting in artificial systems during continual learning has garnered increasing attention. Incorporating brain-inspired learning mechanisms into artificial algorithms has shown promise in addressing this issue. For instance, generative replay [^40] emulates the complementary roles of the cortices and hippocampus in managing long-term and short-term memories by storing generative features of old tasks and reusing them during new task learning. Additionally, metaplasticity methods introduce a global modulation mechanism that adjusts synaptic plasticity, offering another brain-inspired strategy to mitigate catastrophic forgetting [^9] [^31].

Despite success in specific contexts, continual learning faces challenges, particularly in real-world applications. Methods such as generative replay encounter growing memory demands as tasks accumulate. Additionally, metaplasticity-based approaches, while effective on simpler datasets like MNIST, tend to perform relatively poorly on more complex, real-world data. Furthermore, methods like XdG, which are not task-agnostic, rely on a task oracle, limiting their applicability in real-world scenarios.

To address these limitations, we develop a novel method termed CH-HNN, which integrates ANNs and SNNs into a hybrid neural network inspired by recurrent corticohippocampal loops. CH-HNN eliminates the need for a task oracle, exhibiting strong performance and power efficiency in real-world applications. While CH-HNN supports diverse neuron models, selecting the appropriate model involves trade-offs. Complex neuron models like the EIF model enhance biological realism and accuracy but demand more computational resources compared to simpler models like LIF and IF. Although the exponential term in the EIF model can be efficiently managed using a look-up table and results in only a modest power overhead of 8.35% to 8.58% on the “Tianjic” chip, real-world applications must still consider trade-offs among performance, memory cost, biological plausibility, and hardware compatibility to meet specific demands.

From the perspective of neural mechanisms in corticohippocampal circuits, CH-HNN provides indirect evidence for potential neural mechanisms. First, modulation of the feedforward loop from mPFC-CA1 to DG-CA3 can be achieved by resetting the neural synchrony state, offering complementary insights to generative replay methods [^40], which propose direct transfer of old knowledge from the cortices to the hippocampus. Second, novel embedding transfers from feedback loops potentially enhance the generalization of related memories. Third, certain regions of the brain, such as the lateral posterior cortex and lateral prefrontal cortex, can modulate metaplasticity in the DG-CA3 circuits through chemical neuromodulatory signals.

Furthermore, there is ongoing debate regarding how the brain represents concepts—whether through distinct engrams or episode inference. The success of our CH-HNN method suggests that episodes are not encoded by discrete engrams but are instead processed through guidance based on episode-related information. Although our model simplifies the recurrent loop as mPFC-CA1 and DG-CA3, other research emphasizes the role of the EC in episode-related representations [^21]. Furthermore, evidence indicates different functions for the anterior and posterior hippocampus. The anterior hippocampus interacts primarily with regions of the brain associated with generalized knowledge, whereas the posterior hippocampus is involved in specific memory representations. These findings further elucidate an interpretable neural mechanism underlying lifelong learning.

While current continual learning algorithms, including our CH-HNN model, effectively leverage prior knowledge to achieve high performance [^41] [^51], comparing models with prior knowledge to those without dedicated prior-learning mechanisms may seem imbalanced. Nevertheless, it is important to highlight that our approach offers an indirect method of prioritizing prior knowledge to facilitate new concept learning, potentially reflecting a neural mechanism for lifelong learning in the brain. Given that humans can sequentially acquire new concepts from only a few examples, therefore, integrating few-shot learning [^52] with continual learning could be a promising avenue for future research. This integration may enhance the adaptability and efficiency of online continual learning in dynamic environments. Additionally, our model may encounter challenges in contexts where task correlations are limited, as it relies on the presence of natural or designed correlations among incremental episodes.

In conclusion, our study introduces a model that simplifies the simulation of corticohippocampal recurrent circuits, improving the performance and adaptability of continual learning in real-world applications, while emphasizing the potential of integrating neuroscientific insights into artificial intelligence systems.

## Methods

### Dataset process protocols

For the pMNIST dataset, each 28  × 28 image is randomly permuted to create a diverse set of image permutations. We have two subsets with these permutations, one containing 700 permutations and another with 40 permutations, the latter organized into ten groups. Each group contains four permutations with intra-group similarity to construct cross-task relationships.

For the sMNIST dataset, the 10 classes of MNIST are divided into 5 episodes, each containing 2 classes.

Similarly, the CIFAR-100 and Tiny-ImageNet datasets are divided into 20 and 40 episodes, respectively, with each episode comprising 5 classes. This results in the sCIFAR-100 and sTiny-ImageNet datasets. Prior to experiments, the 32 × 32 RGB image samples from these datasets are processed through the CLIP foundation model [^53] to generate feature maps with 768 channels.

For the DVS Gesture dataset, we divide the data into 4 episodes, containing 3, 3, 3, and 2 classes, respectively.

### Structures of CH-HNNs

The architecture of the CH-HNN comprises several key designs, including:

1. design of ANNs that generate episode-related modulation signals according to the similarity across various episodes;
2. design of SNNs equipped with various neuron models that incrementally learn various episodes under the guidance of the modulation signals;
3. design of metaplasticity mechanisms that modulate the weight updating process in the SNNs and continual ANNs.

### Design and training methods for ANNs within CH-HNN

In principle, structures such as convolutional networks and transformers can be used to construct the ANNs within CH-HNN model. In this paper, the ANN is built with a fully connected network consisting of three linear layers, each layer encompassing 64 or 256 neurons. At the end of the network, each linear decoder produces a binary modulated signal vector, which is then normalized using a Softmax operation. The processing of the ANN is described by the following equation:

$$
{{{\bf{R}}}}=\,{\mbox{A}}\,({{{\bf{x}}}};{\theta }_{{{{\rm{A}}}}})
$$

(1)

where **x** and **R** represent the input sample and the output modulated signal of the ANN, respectively. **R** is a binary matrix of size *n* × *c*, where the number of columns equals the number of hidden layer neurons *c* in the SNN to be modulated. Each row in the matrix represents a modulated signal, denoted as **R** <sub><i>i</i></sub>, with a total of *n* such signals.

The training of the ANN is accomplished by optimizing the following objective function:

$$
{\min}_{{\theta }_{{{{\rm{A}}}}}}{{\mbox{E}}}_{{{{\bf{x}}}},\widetilde{{{{\bf{x}}}}} \sim D} {\sum}_{i=1}^{n}\left[{\left| \frac{{{{{\bf{R}}}}}_{i}\widetilde{{{{{\bf{R}}}}}_{i}}}{| {{{{\bf{R}}}}}_{i}| | \widetilde{{{{{\bf{R}}}}}_{i}}| }-{{{\rm{sim}}}}({{{\bf{x}}}},\widetilde{{{{\bf{x}}}}})\right| }^{p}+\left.\beta \left\vert \parallel {{{{\bf{R}}}}}_{i}{\parallel }_{1}-\rho c\right\vert \right)\right]
$$

(2)

where D is the dataset. The objective function is divided into two parts: the first term constrains the similarity between the modulated signals **R** <sub><i>i</i></sub> and $\widetilde{{{{{\bf{R}}}}}_{i}}$ generated by the ANN to be consistent with the similarity of the **x** and $\widetilde{{{{\bf{x}}}}}$. The second term constrains the sparsity of the generated modulated signals. *β* is the coefficient that balances the two terms. *ρ* is the desired sparsity, which is generally set to $\frac{1}{n}$. During actual training, the mini-batch Adam optimization method is used for optimization.

The similarity of the corresponding samples ${{{\rm{sim}}}}({{{\bf{x}}}},\widetilde{{{{\bf{x}}}}})$ in CH-HNN model can be defined in two ways. First, for task-incremental scenarios of the pMNIST dataset and all class-incremental learning scenarios where inherent correlations exist across episodes, similarity is automatically computed using cosine similarity:

$$
{{{\rm{sim}}}}({{{\bf{x}}}},\widetilde{{{{\bf{x}}}}})=\frac{{{{{\bf{x}}}}}_{*}\widetilde{{{{{\bf{x}}}}}_{*}}}{| {{{{\bf{x}}}}}_{*}| | \widetilde{{{{{\bf{x}}}}}_{*}}| }
$$

(3)

where **x** <sub>*</sub> and $\widetilde{{{{{\bf{x}}}}}_{*}}$ represent statistics of the sampled instances from different episodes after dimension reduction via principal component analysis. For the sCIFAR-100 and sTiny-ImageNet datasets, **x** represents the feature maps extracted by the CLIP foundation model. For the sMNIST, pMNIST, and DVS Gesture datasets, **x** is the flattened vector of the original images. Second, for the task-incremental learning on sMNIST, sCIFAR-100, and sTiny-ImageNet datasets, without inherent or natural correlations across tasks, we manually specified the task similarities to clearly define their relationships. Specifically, we set the similarity within the same task to 1, and between different tasks to 0.

In the comparison experiments among models, all training dataset that will be continually learned in SNNs are involved in the ANN’s offline training, except for the task-incremental learning dataset on pMNIST dataset. The other 700 permutation are as prior knowledge added part (0, 10, 20) of 40 permutations for SNNs incremental learning are involved in the ANN’s offline training.

In the knowledge transfer evaluation experiments, we used three different configurations of the ImageNet dataset as priors. First, we selected classes with more than 500 samples in the training dataset, resulting in 950 classes, which we refer to as ‘ImageNet as priors’ in the legends. Second, following [^41], we removed classes from these 950 that overlapped with CIFAR-100 or Tiny-ImageNet, yielding 550 classes. This configuration is labeled as ‘ImageNet with overlapping classes removed as priors’. Lastly, to examine the role of overlapping classes, we randomly removed 400 classes from the original 950, resulting in 550 classes, referred to ‘ImageNet with randomly removed classes as priors’.

In the experiments of ANN’s continual learning, the metaplasticity is included in its optimization process, which will be demonstrated more details in next section. In the sCIFAR-100 and sTiny-ImageNet dataset, the ANN need to incrementally learn the first half classes, respectively, and then remaining classes.

The correlation matrices generated by ANN are derived from randomly selected samples from the test dataset.

### Design and training methods for SNNs within CH-HNN model

The SNN contains three layers in all experiments in our study, and the first two layers consist of batch normalization (BN) following the fully connected layer:

$$
{{{\rm{out}}}}={{{{\bf{W}}}}}_{3}\left({\prod}_{l=1}^{2}\underline{{{{{\bf{R}}}}}_{l}}\right.{\theta }^{l}({{{\rm{BN}}}}({{{{\bf{W}}}}}_{l}{{{\bf{x}}}}))
$$

(4)

where **x** is a visual input to the SNN, **W** <sub><i>l</i></sub> represents the weights of each fully connected layer, followed by BN Layer. *θ* <sup><i>l</i></sup> represents neuron models which we employ as the basic units in SNNs. The underlined **R** <sub><i>l</i></sub> = A <sub><i>l</i></sub> (**x**; *θ* <sub>A</sub>) is generated by a well-trained ANN using the same visual input, selectively activating neurons in each layer *l* using a mask method. In this study, we utilize the surrogate gradient methods for training efficiently, with the cross entropy (CE) loss function.

To compare the performance of different neuron models, we implement the EIF, LIF and IF neuron models.

For the EIF neuron model, the neuron dynamic is shown as below:

$$
\left\{\begin{array}{l}\tau \frac{dV(t)}{dt}=-\left(V(t)-{V}_{{{{\rm{reset}}}}}\right)+{\Delta }_{T}\cdot \exp \left(\frac{V(t)-{V}_{{{{\rm{th}}}}}}{{\Delta }_{T}}\right)+RI(t)\\ {{{\rm{if}}}}V(t) > {V}_{{{{\rm{th}}}}},V(t)\leftarrow {V}_{{{{\rm{reset}}}}},{{{\rm{spike}}}}(t)\leftarrow 1\end{array}\right.
$$

(5)

where the *V* <sub>th</sub> is the spike threshold, *Δ* <sub><i>T</i></sub> is the sharpness of the exponential term, *V* <sub>reset</sub> is the reset voltage, and *R* is the resistance of membrane.

For the LIF neuron, the equation describing its membrane potential dynamics is as follows:

$$
\tau \frac{dV(t)}{dt}=-\left(V(t)-{V}_{{{{\rm{reset}}}}}\right)+RI(t)
$$

(6)

The process of spike generation is the same as that of EIF.

For the IF neuron model, the computation of spike is also not changed, with:

$$
\tau \frac{dV(t)}{dt}=RI(t)
$$

(7)

For numerical simulation, these equations were discretized in time using the Euler method. For example, the following is the discrete iterative formula for the LIF neuron:

$$
\left\{\begin{array}{l}{V}_{i+1}={V}_{i}\lambda \left(1-{o}_{i}\right)+{{{\bf{w}}}}*{{{{\bf{s}}}}}_{i+1},\quad \\ {o}_{i}={{{\mathcal{H}}}}\left({V}_{i}-{V}_{{{{\rm{th}}}}}\right),\hfill\quad \\ \lambda={{{{\rm{e}}}}}^{-\frac{{T}_{{{{\rm{d}}}}}}{\tau }}.\hfill\quad \end{array}\right.
$$

(8)

where *V* <sub><i>i</i></sub>, *o* <sub><i>i</i></sub>, and **s** <sub><i>i</i></sub> represent the membrane potential, spike output, and spike input of the neuron at the *i* -th time step, respectively. ${{{\mathcal{H}}}}$ is the unit step function, and *λ* is the decay coefficient of the membrane potential. *T* <sub>d</sub> is the discretization time interval.

The firing rate of the spiking neurons are encoded by rate coding, and then be decoded by fully connected layers in the output layer.

### Metaplasticity Mechanisms introduced to both SNNs and ANNs

The metaplasticity mechanisms are used in the optimization process of SNN’s or ANN’s incrementally learning process, with the modulation of the local synaptic plasticity by modifying the optimization process:

$$
{{{{\bf{W}}}}}_{i+1}={{{{\bf{W}}}}}_{i}-\alpha f(m,{{{{\bf{W}}}}}_{i}),\quad i=1,\ldots,T
$$

(9)

$$
f(m,{{{{\bf{W}}}}}_{i})={e}^{-\left\vert m{{{{\bf{W}}}}}_{i}\right\vert }
$$

(10)

where **W** <sub><i>i</i></sub> represents hidden weights within SNNs or ANNs, and *α* represents the learning rate. *f* (*m*, **W** <sub><i>i</i></sub>) is set as exponential function, such that can decrease learning rate of local synapse with the neural weights accumulate, from 0 to 1 (see Supplementary Fig. [2](https://www.nature.com/articles/s41467-025-56405-9#MOESM1) a).

While the ANN within our CH-HNN model which is responsible for generate modulation signal is incrementally learned, the meta value *m* is set as 15 in sCIFAR-100 dataset, and set as 10 in sTiny-ImageNet dataset.

### Pseudo-code for CH-HNN model

### Algorithm 1

ANN within CH-HNN model

1: Input: *θ* <sub>A</sub>, D, ${{{\rm{sim}}}}$, *N*, *p*, *λ*, *B*, *ρ*, *c*, *η*

2: **for** *i* ← 1 **to** *N* **do**

3:   *Δ* *θ* <sub>A</sub> ← 0            ⊳ Initialize gradients

4:   **for** *j* ← 1 **to** *B* **do**

5:      ${{{\bf{x}}}},\tilde{{{{\bf{x}}}}} \sim {{{\rm{D}}}}$      ⊳ Sample two samples from dataset

6:     ${{{\bf{R}}}}\leftarrow {{{\rm{A}}}}({{{\bf{x}}}};{\theta }_{{{{\rm{A}}}}}),\tilde{{{{\bf{R}}}}}\leftarrow A(\tilde{{{{\bf{x}}}}};{\theta }_{{{{\rm{A}}}}})$  ⊳ Calculate modulation signals

7:     $\Delta {\theta }_{{{{\rm{A}}}}}\leftarrow \Delta {\theta }_{A}+{\nabla }_{{\theta }_{A}}{\sum }_{k=1}^{n}\left[{\left\vert \frac{{{{{\bf{R}}}}}_{k}{\tilde{{{{\bf{R}}}}}}_{k}}{\left\vert {{{{\bf{R}}}}}_{k}\right\vert \left\vert {\tilde{{{{\bf{R}}}}}}_{k}\right\vert }-{{{\rm{sim}}}}({{{\bf{x}}}},\tilde{{{{\bf{x}}}}})\right\vert }^{p}+\lambda \left\vert {\left\Vert {{{{\bf{R}}}}}_{k}\right\Vert }_{1}-\rho c\right\vert \right]$ ⊳ Update gradients

8:     **end for**

9:     *θ* <sub>A</sub> ← *θ* <sub>A</sub> − *η* *Δ* *θ* <sub>A</sub> / *B* ⊳ Update parameters

10: **end for**

### Algorithm 2

SNN within CH-HNN model

1: Input: **W** <sub><b>h</b></sub>, *θ* <sub>S</sub>, *θ* <sub>BN</sub>, A, *θ* <sub>A</sub>, (**x**, **y**), *δ*, *m*.

2: **R** ← A(**x**; *θ* <sub>A</sub>)   ⊳ Generate modulation signals through ANN

3: $\hat{{{{\bf{y}}}}}\leftarrow {{{\rm{Forward}}}}({{{\rm{S}}}}({{{\bf{x}}}};{\theta }_{{{{\rm{S}}}}})*{{{\bf{R}}}},{{{{\bf{W}}}}}_{{{{\bf{h}}}}},{\theta }_{{{{\rm{BN}}}}})$     ⊳ Perform inference

4: ${{{\rm{C}}}}\leftarrow {{{\rm{CE}}}}(\hat{{{{\bf{y}}}}},{{{\bf{y}}}})$       ⊳ Compute mean loss over the batch

5: **for** **W** <sub><i>l</i></sub> in **W** <sub><i>h</i></sub> **do**

6:     ${{{{\bf{W}}}}}_{l}\leftarrow {{{{\bf{W}}}}}_{l}-\delta \dot{f(m,{{{{\bf{W}}}}}_{l})}{{{{\bf{W}}}}}_{l}$     ⊳ Metaplasticity mechanisms

7: **end for**

8: *θ* <sub>BN</sub> ← *θ* <sub>BN</sub> − *δ* *θ* <sub>BN</sub>

9: return **W** <sub><i>h</i></sub>, *θ* <sub>BN</sub>

### Evaluation metrics

In incremental learning, we use several evaluation metrics to compare the performance of different methods.

(1) Average accuracy of the learned tasks or classes at the end of the incremental learning stage, which is given by:

$$
\frac{1}{N}\frac{1}{T}{\sum }_{i=1}^{T} \mathop{\sum}_{j=1}^{N}{A}_{ij}
$$

(11)

where *T* is the total number of tasks or classes, *N* is the number of random seeds, and *A* <sub><i>ij</i></sub> is the accuracy on task *i* using random seed *j*.

(2) Average accuracy across random seeds for each task or class when the final stage of learning is completed, defined as:

$$
\frac{1}{N} {\sum}_{j=1}^{N}{A}_{ij}
$$

(12)

where *N* is the number of random seeds, and *A* <sub><i>i</i> <i>j</i></sub> is the accuracy on task *i* using random seed *j*.

(3) Inter-episode disparity calculated as the absolute difference between the highest and lowest test accuracy across all tasks or classes after the learning process:

$$
\frac{1}{N} {\sum}_{j=1}^{N}\left\vert \max ({A}_{1},{A}_{2},\ldots,{A}_{T})-\min ({A}_{1},{A}_{2},\ldots,{A}_{T})\right\vert
$$

(13)

where *A* <sub><i>i</i></sub> is the test accuracy on task *i*.

### Implementation details

In all implementation experiments, the system performs inference tasks using models pre-trained in an incremental learning manner. For pMNIST recognition on robotic dogs, an Intel RealSense D435i RGB-D camera is mounted on a Unitree GO1 quadruped robot for real-time detection. The pMNIST images are displayed on a screen, and OpenCV [^49] is employed to detect edges and crop the images. These images are then processed by the ANNs within the CH-HNN, which generate modulation signals for episode inference, guiding the SNN to predict a label (0 to 9) from the dataset. UDP communication with the Unitree GO1 robot is established via the Unitree SDK, enabling the robot to perform predefined actions such as nodding or looking up based on the recognition results.

For robotic arm experiments involving objects from the sCIFAR-100 dataset, objects within the camera’s field of view are detected and cropped using the YOLO algorithm [^50]. The recognition model, trained on sCIFAR-100, predicts labels from 0 to 99. If the predicted label matches a predefined target, such as an apple, the robotic arm is instructed to perform a grasp operation; otherwise, it refrains from grasping. The YOLO algorithm provides X and Y coordinates, while an RGB-D camera supplies depth data to determine the X-Y-Z spatial coordinates of the target. This information is transmitted to the robot, enabling the Unitree Z1 robotic arm to execute precise grasping of the object.

To evaluate the robustness of different models in real-world applications, five objects were selected from dataset indices 0 to 99: apple (index 0), bottle (index 9), orange (index 53), rose (index 70), and wolf (index 97). A RealSense camera was used to capture images for testing, and thirty recognition tests were conducted for each object with the camera in a fixed position. The objects were placed in three locations relative to the camera frame—left, center, and right—each tested ten times. Additionally, angular rotations were applied to the objects to introduce various perspectives during the tests.

## Data availability

All data used in this paper are publicly available and can be accessed at [http://yann.lecun.com/exdb/mnist/](http://yann.lecun.com/exdb/mnist/) for MNIST dataset, [https://www.cs.toronto.edu/~kriz/cifar.html](https://www.cs.toronto.edu/~kriz/cifar.html) for CIFAR-100 dataset, [http://cs231n.stanford.edu/tiny-imagenet-200.zip](http://cs231n.stanford.edu/tiny-imagenet-200.zip) for Tiny-ImageNet dataset, and [https://tonic.readthedocs.io/en/latest/generated/tonic.datasets.DVSGesture.html](https://tonic.readthedocs.io/en/latest/generated/tonic.datasets.DVSGesture.html) for DVS Gesture dataset.

## Code availability

The codes are available on Zenodo [^54] ([https://doi.org/10.5281/zenodo.14406003](https://doi.org/10.5281/zenodo.14406003)) and can also be accessed on GitHub ([https://github.com/qqish/CH-HNN](https://github.com/qqish/CH-HNN)).
