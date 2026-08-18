---
title: "A Neural Dirichlet Process Mixture Model for Task-Free Continual Learning"
source: "https://ar5iv.labs.arxiv.org/html/2001.00689"
author:
  - "[[Soochan Lee]]"
  - "[[Junsoo Ha]]"
  - "[[Dongsu Zhang]]"
  - "[[Gunhee Kim]]"
published: 2020-01-03
created: 2026-08-10
description: "CN-DPM: task-free continual learning as online variational inference (Sequential Variational Approximation) of a Dirichlet-process mixture of neural experts. Responsibility = per-expert generative likelihood x CRP prior; a data point whose new-cluster responsibility exceeds a threshold goes into a short-term memory buffer, and when the buffer fills a sleep phase trains a new expert to convergence. Lateral connections to earlier experts with blocked gradients give forward-only transfer; a similarity-threshold merge prunes redundant experts. Key numbers: per-expert classifiers show essentially no forgetting (Split-CIFAR10 88.20 init / 88.20 final; CIFAR100 55.42 / 55.24) but GATING accuracy is 48.18% (5 experts) and 31.14% (20 experts) - the authors name expert selection as 'the main bottleneck.' alpha is hand-set so that exactly the intended number of experts is created. ICLR 2020, arXiv:2001.00689."
tags:
  - "clippings"
  - "continual-learning"
  - "map-selection"
  - "bayesian-nonparametrics"
  - "mixture-of-experts"
---

Title: A Neural Dirichlet Process Mixture Model for Task-Free Continual Learning
URL Source: 
Markdown Content:
A Neural Dirichlet Process Mixture Model for Task-Free Continual Learning
Soochan Lee, Junsoo Ha, Dongsu Zhang & Gunhee Kim
Department of Computer Science, Seoul National University, Seoul, Republic of Korea {soochan.lee,junsoo.ha}@vision.snu.ac.kr,{96lives,gunhee}@snu.ac.kr
Abstract
Despite the growing interest in continual learning, most of its contemporary works have been studied in a rather restricted setting where tasks are clearly distinguishable, and task boundaries are known during training. However, if our goal is to develop an algorithm that learns as humans do, this setting is far from realistic, and it is essential to develop a methodology that works in a task-free manner. Meanwhile, among several branches of continual learning, expansion-based methods have the advantage of eliminating catastrophic forgetting by allocating new resources to learn new data. In this work, we propose an expansion-based approach for task-free continual learning. Our model, named Continual Neural Dirichlet Process Mixture (CN-DPM), consists of a set of neural network experts that are in charge of a subset of the data. CN-DPM expands the number of experts in a principled way under the Bayesian nonparametric framework. With extensive experiments, we show that our model successfully performs task-free continual learning for both discriminative and generative tasks such as image classification and image generation.
1Introduction
Humans consistently encounter new information throughout their lifetime. The way the information is provided, however, is vastly different from that of conventional deep learning where each mini-batch is iid-sampled from the whole dataset. Data points adjacent in time can be highly correlated, and the overall distribution of the data can shift drastically as the training progresses. Continual learning (CL) aims at imitating incredible human’s ability to learn from a non-iid stream of data without catastrophically forgetting the previously learned knowledge.
Most CL approaches (Aljundi et al., 2018; 2017; Lopez-Paz & Ranzato, 2017; Kirkpatrick et al., 2017; Rusu et al., 2016; Shin et al., 2017; Yoon et al., 2018) assume that the data stream is explicitly divided into a sequence of tasks that are known at training time. Since this assumption is far from realistic, task-free CL is more practical and demanding but has been largely understudied with only a few exceptions of (Aljundi et al., 2019a; b). In this general CL, not only is explicit task definition unavailable but also the data distribution gradually shifts without a clear task boundary.
Meanwhile, existing CL methods can be classified into three different categories (Parisi et al., 2019): regularization, replay, and expansion methods. Regularization and replay approaches address the catastrophic forgetting by regularizing the update of a specific set of weights or replaying the previously seen data, respectively. On the other hand, the expansion methods are different from the two approaches in that it can expand the model architecture to accommodate new data instead of fixing it beforehand. Therefore, the expansion methods can bypass catastrophic forgetting by preventing pre-existing components from being overwritten by the new information. The critical limitation of prior expansion methods, however, is that the decisions of when to expand and which resource to use heavily rely on explicitly given task definition and heuristics.
In this work, our goal is to propose a novel expansion-based approach for task-free CL. Inspired by the Mixture of Experts (MoE) (Jacobs et al., 1991), our model consists of a set of experts, each of which is in charge of a subset of the data in a stream. The model expansion (i.e., adding more experts) is governed by the Bayesian nonparametric framework, which determines the model complexity by the data, as opposed to the parametric methods that fix the model complexity before training. We formulate the task-free CL as an online variational inference of Dirichlet process mixture models consisting of a set of neural experts; thus, we name our approach as the Continual Neural Dirichlet Process Mixture (CN-DPM) model.
We highlight the key contributions of this work as follows.
•
We are one of the first to propose an expansion-based approach for task-free CL. Hence, our model not only prevents catastrophic forgetting but also applies to the setting where no task definition and boundaries are given at both training and test time. Our model named CN-DPM consists of a set of neural network experts, which are expanded in a principled way built upon the Bayesian nonparametrics that have not been adopted in general CL research.
•
Our model can deal with both generative and discriminative tasks of CL. With several benchmark experiments of CL literature on MNIST, SVHN, and CIFAR 10/100, we show that our model successfully performs multiple types of CL tasks, including image classification and generation.
2Background and Related Work
2.1Continual Learning
Parisi et al. (2019) classify CL approaches into three branches: regularization (Kirkpatrick et al., 2017; Aljundi et al., 2018), replay (Shin et al., 2017) and expansion (Aljundi et al., 2017; Rusu et al., 2016; Yoon et al., 2018) methods. Regularization and replay approaches fix the model architecture before training and prevent catastrophic forgetting by regularizing the change of a specific set of weights or replaying previously learned data. Hybrids of replay and regularization also exist, such as Gradient Episodic Memory (GEM) (Lopez-Paz & Ranzato, 2017; Chaudhry et al., 2019a). On the other hand, methods based on expansion add new network components to learn new data. Conceptually, such direction has the following advantages compared to the first two: (i) catastrophic forgetting can be eliminated since new information is not overwritten on pre-existing components and (ii) the model capacity is determined adaptively depending on the data.
Task-Free Continual Learning. All the works mentioned above heavily rely on explicit task definition. However, in real-world scenarios, task definition is rarely given at training time. Moreover, the data domain may gradually shift without any clear task boundary. Despite its importance, task-free CL has been largely understudied; to the best of our knowledge, there are only a few works (Aljundi et al., 2019a; b; Rao et al., 2019), each of which is respectively based on regularization, replay, and a hybrid of replay and expansion. Specifically, Aljundi et al. (2019a) extend MAS (Aljundi et al., 2018) by adding heuristics to determine when to update the importance weights with no task definition. In their following work (Aljundi et al., 2019b), they improve the memory management algorithm of GEM (Lopez-Paz & Ranzato, 2017) such that the memory elements are carefully selected to minimize catastrophic forgetting. While focused on unsupervised learning, Rao et al. (2019) is a parallel work that shares several similarities with our method, e.g., model expansion and short-term memory. However, due to their model architecture, expansion is not enough to stop catastrophic forgetting; consequently, generative replay plays a crucial role in Rao et al. (2019). As such, it can be categorized as a hybrid of replay and expansion. More detailed comparison between our method and Rao et al. (2019) is deferred to Appendix M.
2.2Dirichlet Process Mixture Models
We briefly review the Dirichlet process mixture (DPM) model (Antoniak, 1974; Ferguson, 1983), and a variational method to approximate the posterior of DPM models in an online setting: Sequential Variational Approximation (SVA) (Lin, 2013). For a more detailed review, refer to Appendix A.
Dirichlet Process Mixture (DPM). The DPM model is often applied to clustering problems where the number of clusters is not known in advance. The generative process of a DPM model is
	
𝑥 𝑛 ∼ 𝑝 ​ ( 𝑥 ; 𝜃 𝑛 ) , 𝜃 𝑛 ∼ 𝐺 , 𝐺 ∼ DP ​ ( 𝛼 , 𝐺 0 ) ,
		
(1)
where 
𝑥 𝑛
 is the 
𝑛
-th data, and 
𝜃 𝑛
 is the 
𝑛
-th latent variable sampled from 
𝐺
, which itself is a distribution sampled from a Dirichlet process (DP). The DP is parameterized by a concentration parameter 
𝛼
 and a base distribution 
𝐺 0
. The expected number of clusters is proportional to 
𝛼
, and 
𝐺 0
 is the marginal distribution of 
𝜃
 when 
𝐺
 is marginalized out. Since 
𝐺
 is discrete with probability 1 (Teh, 2010), same values can be sampled multiple times for 
𝜃
. If 
𝜃 𝑛 = 𝜃 𝑚
, the two data points 
𝑥 𝑛 and 𝑥 𝑚
 belong to the same cluster. An alternative formulation uses the variable 
𝑧 𝑛
 that indicates to which cluster the 
𝑛
-th data belongs such that 
𝜃 𝑛 = 𝜙 𝑧 𝑛
 where 
𝜙 𝑘
 is the parameter of the 
𝑘
-th cluster. In the context of this paper, 
𝜙 𝑘
 refers to the parameters of the 
𝑘
-th expert.
Approximation of the Posterior of DPM Models. Since the exact inference of the posterior of DPM models is infeasible, approximate inference methods are applied. Among many approximation methods, we adopt the Sequential Variational Approximation (SVA) (Lin, 2013). While the data is given one by one, SVA sequentially determines 
𝜌 𝑛 and 𝜈 𝑘
, which are the variational approximation for the distribution of 
𝑧 𝑛 and 𝜙 𝑘
 respectively. Since 
𝜌 𝑛
 satisfies 
∑ 𝑘 𝜌 𝑛 , 𝑘 = 1 and 𝜌 𝑛 , 𝑘 >= 0 , 𝜌 𝑛 , 𝑘
 can be interpreted as the probability of 
𝑛
-th data belonging to 
𝑘
-th cluster and is often called responsibility. 
𝜌 𝑛 + 1 and 𝜈 ( 𝑛 + 1 )
 at step 
𝑛 + 1
 are computed as:
	
𝜌 𝑛 + 1 , 𝑘
	
∝ { ( ∑ 𝑖 = 1 𝑛 𝜌 𝑖 , 𝑘 ) ​ ∫ 𝜙 𝑝 ​ ( 𝑥 𝑛 + 1 | 𝜙 ) ​ 𝜈 𝑘 ( 𝑛 ) ​ ( 𝑑 ​ 𝜙 )
	
if ​ 1 ≤ 𝑘 ≤ 𝐾
𝛼 ​ ∫ 𝜙 𝑝 ​ ( 𝑥 𝑛 + 1 | 𝜙 ) ​ 𝐺 0 ​ ( 𝑑 ​ 𝜙 )
	
if ​ 𝑘 = 𝐾 + 1 ,
		
(2)
	
𝜈 𝑘 ( 𝑛 + 1 ) ​ ( 𝑑 ​ 𝜙 )
	
∝ { 𝐺 0 ​ ( 𝑑 ​ 𝜙 ) ​ ∏ 𝑖 = 1 𝑛 + 1 𝑝 ​ ( 𝑥 𝑖 | 𝜙 ) 𝜌 𝑖 , 𝑘
	
if ​ 1 ≤ 𝑘 ≤ 𝐾
𝐺 0 ​ ( 𝑑 ​ 𝜙 ) ​ 𝑝 ​ ( 𝑥 𝑛 + 1 | 𝜙 ) 𝜌 𝑛 + 1 , 𝑘
	
if ​ 𝑘 = 𝐾 + 1 .
		
(3)
In practice, SVA adds a new component only when 
𝜌 𝐾 + 1
 is greater than a certain threshold 
𝜖
. If 
𝐺 0 and 𝑝 ​ ( 𝑥 𝑖 | 𝜙 )
 are not a conjugate pair, stochastic gradient descent (SGD) is used to find the MAP estimation 
𝜙 ^
 with a learning rate of 
𝜆
 instead of calculating the whole distribution 
𝜈 𝑘 :
	
𝜙 ^ 𝑘 ( 𝑛 + 1 ) ← 𝜙 ^ 𝑘 ( 𝑛 ) + 𝜆 ​ ( ∇ 𝜙 ^ 𝑘 ( 𝑛 ) log ⁡ 𝐺 0 ​ ( 𝜙 ^ 𝑘 ( 𝑛 ) ) + ∇ 𝜙 ^ 𝑘 ( 𝑛 ) log ⁡ 𝑝 ​ ( 𝑥 | 𝜙 ^ 𝑘 ( 𝑛 ) ) ) .
		
(4)
DPM for Discriminative Tasks. DPM can be extended to discriminative tasks where each data point is an input-output pair 
( 𝑥 , 𝑦 )
, and the goal is to learn the conditional distribution 
𝑝 ​ ( 𝑦 | 𝑥 )
. To use DPM, which is a generative model, for discriminative tasks, we first learn the joint distribution 
𝑝 ​ ( 𝑥 , 𝑦 )
 and induce the conditional distribution from it: 
𝑝 ​ ( 𝑦 | 𝑥 ) = 𝑝 ​ ( 𝑥 , 𝑦 ) / ∫ 𝑦 𝑝 ​ ( 𝑥 , 𝑦 )
. The joint distribution modeled by each component can be decomposed as 
𝑝 ​ ( 𝑥 , 𝑦 | 𝑧 ) = 𝑝 ​ ( 𝑦 | 𝑥 , 𝑧 ) ​ 𝑝 ​ ( 𝑥 | 𝑧 )
 (Rasmussen & Ghahramani, 2002; Shahbaba & Neal, 2009).
DPM in Related Fields. Recent works of Nagabandi et al. (2019) and Jerfel et al. (2019) exploit the DPM framework to add new components without supervision in the meta-learning context. Nagabandi et al. (2019) apply DPM to the model-based reinforcement learning to predict the next state from a given state-action pair. When a new task appears, they add a component under the DPM framework to handle predictions in the new task. Jerfel et al. (2019) apply DPM to online meta-learning. Extending MAML (Finn et al., 2017), they assume that similar tasks can be grouped into a super-task in which the parameter initialization is shared among tasks. DPM is exploited to find the super-tasks and the parameter initialization for each super-task. Therefore, it can be regarded as a meta-level CL method. These works, however, lack generative components, which are often essential to infer the responsible component at test time, as will be described in the next section. As a consequence, it is not straightforward to extend their algorithms to other CL settings beyond model-based RL or meta-learning. In contrast, our method implements a DPM model that is applicable to general task-free CL.
3Approach
We aim at general task-free CL, where the number of tasks and task descriptions are not available at both training and test time. We even consider the case where the data stream cannot be split into separate tasks in Appendix F. All of the existing expansion methods are not task-free since they require task definition at training (Aljundi et al., 2017) or even at test time (Rusu et al., 2016; Xu & Zhu, 2018; Li et al., 2019). We propose a novel expansion method that automatically determines when to expand and which component to use. We first deal with generative tasks and generalize them into discriminative ones.
3.1Continual Learning as Modeling of the Mixture Distribution
We can formulate a CL scenario as a stream of data involving different tasks 
𝒟 1 , 𝒟 2 , …
 where each task 
𝒟 𝑘
 is a set of data sampled from a (possibly) distinct distribution 
𝑝 ​ ( 𝑥 | 𝑧 = 𝑘 )
. If 
𝐾
 tasks are given so far, the overall distribution is expressed as the mixture distribution:
	
𝑝 ​ ( 𝑥 ) = ∑ 𝑘 = 1 𝐾 𝑝 ​ ( 𝑥 | 𝑧 = 𝑘 ) ​ 𝑝 ​ ( 𝑧 = 𝑘 ) ,
		
(5)
where 
𝑝 ​ ( 𝑧 = 𝑘 )
 can be approximated by 
𝑁 𝑘 / 𝑁
 where 
𝑁 𝑘 = | 𝒟 𝑘 | and 𝑁 = ∑ 𝑘 𝑁 𝑘
. The goal of CL is to learn the mixture distribution in an online manner. Regularization and replay methods directly model the approximate distribution 
𝑝 ​ ( 𝑥 ; 𝜙 )
 parameterized by a single component 
𝜙
 and update it to fit the overall distribution 
𝑝 ​ ( 𝑥 )
. When updating 
𝜙
, however, they do not have full access to all the previous data, and thus the information of previous tasks is at risk of being lost as more tasks are learned. Another way to solve CL is to use a mixture model: approximating each 
𝑝 ​ ( 𝑥 | 𝑧 = 𝑘 )
 with 
𝑝 ​ ( 𝑥 ; 𝜙 𝑘 )
. If we learn a new task distribution 
𝑝 ​ ( 𝑥 | 𝑧 = 𝐾 + 1 )
 with new parameter 
𝜙 𝐾 + 1
 and leave the existing parameters intact, we can preserve the knowledge of the previous tasks. The expansion-based CL methods follow this idea.
Similarly, in the discriminative task, the goal of CL is to model the overall conditional distribution, which is a mixture of task-wise conditional distribution 
𝑝 ​ ( 𝑦 | 𝑥 , 𝑧 = 𝑘 ) :
	
𝑝 ​ ( 𝑦 | 𝑥 ) = ∑ 𝑘 = 1 𝐾 𝑝 ​ ( 𝑦 | 𝑥 , 𝑧 = 𝑘 ) ​ 𝑝 ​ ( 𝑧 = 𝑘 | 𝑥 ) .
		
(6)
Prior expansion methods use expert networks each of which models a task-wise conditional distribution 
𝑝 ​ ( 𝑦 | 𝑥 ; 𝜙 𝑘 )
1. However, a new problem arises in expansion methods: choosing the right expert given 
𝑥
, i.e., 
𝑝 ​ ( 𝑧 | 𝑥 )
 in Eq.(6). Existing methods assume that explicit task descriptor 
𝑧
 is given, which is generally not true in human-like learning scenarios. That is, we need a gating mechanism that can infer 
𝑝 ​ ( 𝑧 | 𝑥 )
 only from 
𝑥
 (i.e., which expert should process 
𝑥
). With the gating, the model prediction naturally reduces to the sum of expert outputs weighted by the gate values, which is the mixture of experts (MoE) (Jacobs et al., 1991) formulation: 
𝑝 ​ ( 𝑦 | 𝑥 ) ≈ ∑ 𝑘 𝑝 ​ ( 𝑦 | 𝑥 ; 𝜙 𝑘 ) ​ 𝑝 ​ ( 𝑧 = 𝑘 | 𝑥 ) .
However, it is not possible to use a single gate network as in Shazeer et al. (2017) to model 
𝑝 ​ ( 𝑧 | 𝑥 )
 in CL; since the gate network is a classifier that finds the correct expert for a given data, training it in an online setting causes catastrophic forgetting. Thus, one possible solution to replace a gating network is to couple each expert 
𝑘
 with a generative model that represents 
𝑝 ​ ( 𝑥 | 𝑧 = 𝑘 )
 as in Rasmussen & Ghahramani (2002) and Shahbaba & Neal (2009). As a result, we can build a gating mechanism without catastrophic forgetting as
	
𝑝 ​ ( 𝑦 | 𝑥 ) ≈ ∑ 𝑘 𝑝 ​ ( 𝑦 | 𝑥 ; 𝜙 𝑘 𝐷 ) ​ 𝑝 ​ ( 𝑧 = 𝑘 | 𝑥 ) ≈ ∑ 𝑘 𝑝 ​ ( 𝑦 | 𝑥 ; 𝜙 𝑘 𝐷 ) ​ 𝑝 ​ ( 𝑥 ; 𝜙 𝑘 𝐺 ) ​ 𝑝 ​ ( 𝑧 = 𝑘 ) ∑ 𝑘 ′ 𝑝 ​ ( 𝑥 ; 𝜙 𝑘 ′ 𝐺 ) ​ 𝑝 ​ ( 𝑧 = 𝑘 ′ ) ,
		
(7)
where 
𝑝 ​ ( 𝑧 = 𝑘 ) ≈ 𝑁 𝑘 / 𝑁
. We also differentiate the notation for the parameters of discriminative models for classification and generative models for gating by the superscript 
𝐷 and 𝐺 .
If we know the true assignment of 
𝑧
, which is the case of task-based CL, we can independently train a discriminative model (i.e., 
𝑝 ​ ( 𝑦 | 𝑥 ; 𝜙 𝑘 𝐷 )
) and a generative model (i.e., 
𝑝 ​ ( 𝑥 ; 𝜙 𝑘 𝐺 )
) for each task 
𝑘
. In task-free CL, however, 
𝑧
 is unknown, so the model needs to infer the posterior 
𝑝 ​ ( 𝑧 | 𝑥 , 𝑦 )
. Even worse, the total number of experts is unknown beforehand. Therefore, we propose to employ a Bayesian nonparametric framework, specifically the Dirichlet process mixture (DPM) model, which can fit a mixture distribution with no prefixed number of components. We use SVA described in section 2.2 to approximate the posterior in an online setting. Although SVA is originally designed for the generative tasks, it is easily applicable to discriminative tasks by making each component 
𝑘
 to model 
𝑝 ​ ( 𝑥 , 𝑦 | 𝑧 ) = 𝑝 ​ ( 𝑦 | 𝑥 , 𝑧 ) ​ 𝑝 ​ ( 𝑥 | 𝑧 ) .
Figure 1: Overview of our CN-DPM model. Each expert 
𝑘
 (blue boxes) contains a discriminative component for modeling 
𝑝 ​ ( 𝑦 | 𝑥 ; 𝜙 𝑘 𝐷 )
 and a generative component for modeling 
𝑝 ​ ( 𝑥 ; 𝜙 𝑘 𝐺 )
, jointly representing 
𝑝 ​ ( 𝑥 , 𝑦 ; 𝜙 𝑘 )
. We also keep the assigned data count 
𝑁 𝑘
 per expert. (a) During training, each sample 
( 𝑥 , 𝑦 )
 coming in a sequence is evaluated by every expert to calculate the responsibility 
𝜌 𝑘
 of each expert. If 
𝜌 𝐾 + 1
 is high enough, i.e., none of the existing experts is responsible, the data is stored into short-term memory (STM). Otherwise, it is learned by the corresponding expert. When STM is full, a new expert is created from the data in STM. (b) Since CN-DPM is a generative model, we first compute the joint distribution 
𝑝 ​ ( 𝑥 , 𝑦 )
 for a given 
𝑥
, from which it is trivial to infer 
𝑝 ​ ( 𝑦 | 𝑥 ) .
3.2The Continual Neural Dirichlet Process Mixture (CN-DPM) Model
The proposed approach for task-free CL, named Continual Neural Dirichlet Process Mixture (CN-DPM) model, consists of a set of experts, each of which is associated with a discriminative model (classifier) and a generative model (density estimator). More specifically, the classifier models 
𝑝 ​ ( 𝑦 | 𝑥 , 𝑧 = 𝑘 )
, for which we can adopt any classifier or regressor using deep neural networks, while the density estimator describes the marginal likelihood 
𝑝 ​ ( 𝑥 | 𝑧 = 𝑘 )
, for which we can use any explicit density model such as VAEs (Kingma & Welling, 2014) and PixelRNN (Oord et al., 2016). We respectively denote the classifier and the density estimator of expert 
𝑘 as 𝑝 ​ ( 𝑦 | 𝑥 ; 𝜙 𝑘 𝐷 ) and 𝑝 ​ ( 𝑥 ; 𝜙 𝑘 𝐺 )
, where 
𝜙 𝑘 𝐷 and 𝜙 𝑘 𝐺
 are the parameters of the models. Finally, the prediction 
𝑝 ​ ( 𝑦 | 𝑥 )
 can be obtained from Eq.(7) by plugging in the output of the classifier and the density estimator. Note that the number of experts is not prefixed but expanded via the DPM framework. Figure 1 illustrates the overall training and inference process of our model.
Training. We assume that samples sequentially arrive one at a time during training. For a new sample, we first decide whether the sample should be assigned to an existing expert or a new expert should be created for it. Suppose that samples up to 
( 𝑥 𝑛 , 𝑦 𝑛 )
 are sequentially processed and 
𝐾
 experts are already created when a new sample 
( 𝑥 𝑛 + 1 , 𝑦 𝑛 + 1 )
 arrives. We compute the responsibility 
𝜌 𝑛 + 1 , 𝑘
 as follows:
	
𝜌 𝑛 + 1 , 𝑘
	
∝ { ( ∑ 𝑖 = 1 𝑛 𝜌 𝑖 , 𝑘 ) ​ 𝑝 ​ ( 𝑦 𝑛 + 1 | 𝑥 𝑛 + 1 ; 𝜙 ^ 𝑘 𝐷 ) ​ 𝑝 ​ ( 𝑥 𝑛 + 1 ; 𝜙 ^ 𝑘 𝐺 )
	
if ​ 1 ≤ 𝑘 ≤ 𝐾
𝛼 ​ 𝑝 ​ ( 𝑦 𝑛 + 1 | 𝑥 𝑛 + 1 ; 𝜙 ^ 0 𝐷 ) ​ 𝑝 ​ ( 𝑥 𝑛 + 1 ; 𝜙 ^ 0 𝐺 ) ​
 where 
​ 𝜙 ^ 0 ∼ 𝐺 0 ​ ( 𝜙 )
	
if ​ 𝑘 = 𝐾 + 1
		
(8)
where 
𝐺 0
 is a distribution corresponding to the weight initialization. If 
arg ​ max 𝑘 ⁡ 𝜌 𝑛 + 1 , 𝑘 ≠ 𝐾 + 1
, the sample is assigned to the existing experts proportional to 
𝜌 𝑛 + 1 , 𝑘
, and the parameters of the experts are updated with the new sample by Eq.(4) such that 
𝜙 ^ 𝑘
 is the MAP approximation given the data assigned up to the current time step. Otherwise, we create a new expert.
Short-Term Memory. However, it is not a good idea to create a new expert immediately and initialize it to be the MAP estimation given 
𝑥 𝑛 + 1
. Since both the classifier and density estimator of an expert are neural networks, training the new expert with only a single example leads to severe overfitting. To mitigate this issue, we employ short-term memory (STM) to collect sufficient data before creating a new expert. When a data point is classified as new, we store it to the STM. Once the STM reaches its maximum capacity 
𝑀
, we stop the data inflow for a while and train a new expert with the data in the STM for multiple epochs until convergence. We call this procedure sleep phase. After sleep, the STM is emptied, and the newly trained expert is added to the expert pool. During the subsequent wake phase, the expert is learned from the data assigned to it. This STM trick assumes that the data in the STM belong to the same expert. We empirically find that this assumption is acceptable in many CL settings where adjacent data are highly correlated. The overall training procedure is described in Algorithm 1. Note that we use 
𝜌 𝑛 , 0
 instead of 
𝜌 𝑛 , 𝐾 + 1
 in the algorithm for brevity.
Inference. At test time, we infer 
𝑝 ​ ( 𝑦 | 𝑥 )
 from the collaboration of the learned experts as in Eq.(7).
Techniques for Practicality. Naively adding a new expert has two major problems: (i) the number of parameters grows unnecessarily large as the experts redundantly learn common features and (ii) there is no positive transfer of knowledge between experts. Therefore, we propose a simple method to share parameters between experts. When creating a new expert, we add lateral connections to the features of the previous experts similar to Rusu et al. (2016). To prevent catastrophic forgetting in the existing experts, we block the gradient from the new expert. In this way, we can greatly reduce the number of parameters while allowing positive knowledge transfer. More techniques such as sparse regularization in Yoon et al. (2018) can be employed to reduce redundant parameters further. As they are orthogonal to our approach, we do not use such techniques in our experiments. Another effective technique that we use in the classification experiments is adding a temperature parameter to the classifier. Since the range of 
log ⁡ 𝑝 ​ ( 𝑥 | 𝑧 )
 is far broader than 
log ⁡ 𝑝 ​ ( 𝑦 | 𝑥 , 𝑧 )
, the classifier has almost no effect without proper scaling. Thus, we can increase overall accuracy by adjusting the relative importance of images and labels. We also introduce an algorithm to prune redundant experts in Appendix D, and discuss further practical issues of CN-DPM in Appendix B.
Algorithm 1 Training of the Continual Neural Dirichlet Process Mixture (CD-NDP) Model
0:  Data 
( 𝑥 1 , 𝑦 1 ) , … , ( 𝑥 𝑁 , 𝑦 𝑁 )
, concentration 
𝛼
, base measure 
𝐺 0
, short-term memory capacity 
𝑀
, learning rate 
𝜆 1: ℳ ← ∅
 {Short-term memory}
2: 𝐾 ← 0
 {Number of experts}
3: 𝑁 0 ← 𝛼 ; 𝜙 ^ 0 ←
Sample
​ ( 𝐺 0 )
4:  for 
𝑛 = 1 to 𝑁 do
5:     for 
𝑘 = 0 to 𝐾 do 6: 𝑙 𝑘 ← 𝑝 ​ ( 𝑦 𝑛 | 𝑥 𝑛 ; 𝜙 ^ 𝑘 𝐷 ) ​ 𝑝 ​ ( 𝑥 𝑛 ; 𝜙 ^ 𝑘 𝐺 ) 7: 𝜌 𝑛 , 𝑘 ← 𝑁 𝑘 ​ 𝑙 𝑘
8:     end for
9: 𝜌 𝑛 , 0 : 𝐾 ← 𝜌 𝑛 , 0 : 𝐾 / ∑ 𝑘 = 0 𝐾 𝜌 𝑛 , 𝑘
10:     if 
arg ​ max 𝑘 ⁡ 𝜌 𝑛 , 𝑘 = 0
 then
11:        {Save 
𝑥 𝑛
 to short-term memory}
12: ℳ ← { 𝑥 𝑛 } ∪ ℳ
13:        if 
| ℳ | ≥ 𝑀
 then {Add new expert}
14: 𝜙 ^ 𝐾 + 1 ←
FindMAP
​ ( ℳ , 𝐺 0 ) 15: 𝑁 𝐾 + 1 ← | ℳ | ; ℳ ← ∅ 16: 𝐾 ← 𝐾 + 1
17:        end if
18:     else {Update existing experts}
19: 𝜌 𝑛 , 1 : 𝐾 ← 𝜌 𝑛 , 1 : 𝐾 / ∑ 𝑘 = 1 𝐾 𝜌 𝑛 , 𝑘
20:        for 
𝑘 = 1 to 𝐾 do 21: 𝑁 𝑘 ← 𝑁 𝑘 + 𝜌 𝑛 , 𝑘 22: 𝜙 ^ 𝑘 ← 𝜙 ^ 𝑘 + 𝜌 𝑛 , 𝑘 ​ 𝜆 ​ ∇ 𝜙 ^ 𝑘 log ⁡ 𝑙 𝑘
23:        end for
24:     end if
25:  end for
4Experiments
We evaluate the proposed CN-DPM model in task-free CL with four benchmark datasets. Appendices include more detailed model architecture, additional experiments, and analyses.
4.1Continual Learning Scenarios
A CL scenario defines a sequence of tasks where the data distribution for each task is assumed to be different from others. Below we describe the task-free CL scenarios used in the experiments. At both train and test time, the model cannot access the task information. Unless stated otherwise, each task is presented for a single epoch (i.e., a completely online setting) with a batch size of 10.
Split-MNIST (Zenke et al., 2017). The MNIST dataset (LeCun et al., 1998) is split into five tasks, each containing approximately 12K images of two classes, namely (0/1, 2/3, 4/5, 6/7, 8/9). We conduct both classification and generation experiments in this scenario.
MNIST-SVHN (Shin et al., 2017). It is a two-stage scenario where the first consists of MNIST, and the second contains SVHN (Netzer et al., 2011). This scenario is different from Split-MNIST; in Split-MNIST, new classes are introduced when transitioning into a new task, whereas the two stages in MNIST-SVHN share the same set of class labels and have different input domains.
Split-CIFAR10 and Split-CIFAR100. In Split-CIFAR10, we split CIFAR10 (Krizhevsky & Hinton, 2009) into five tasks in the same manner as Split-MNIST. For Split-CIFAR100, we build 20 tasks, each containing five classes according to the pre-defined superclasses in CIFAR100. The training sets of CIFAR10 and CIFAR100 consist of 50K examples each. Note that most of the previous works (Rebuffi et al., 2017; Zenke et al., 2017; Lopez-Paz & Ranzato, 2017; Aljundi et al., 2019c; Chaudhry et al., 2019a), except Maltoni & Lomonaco (2019), use task information at test time in Split-CIFAR100 experiments. They assign distinct output heads for each task and utilize the task identity to choose the responsible output head at both training and test time. Knowing the right output head, however, the task reduces to 5-way classification. Therefore, our setting is far more difficult than the prior works since the model has to perform 100-way classification only from the given input.
Table 1: Test scores and the numbers of parameters in task-free CL on Split-MNIST, MNIST-SVHN, and Split-CIFAR100 scenarios. Note that iid-
∗
 baselines are not CL methods.
Method	Split-MNIST	Split-MNIST (Gen.)	MNIST-SVHN	Split-CIFAR100
Acc. (%)	Param.	bits/dim	Param.	Acc. (%)	Param.	Acc. (%)	Param.
iid-offline	
98.63
	
478 K
0.1806
	
988 K
96.69
	
11.2
M
73.80
	
11.2
M
iid-online	
96.18
	
478 K
0.2156
	
988 K
95.24
	
11.2
M
20.46
	
11.2
M
Fine-tune	
19.43
	
478 K
0.2817
	
988 K
83.35
	
11.2
M
2.43
	
11.2
M
Reservoir	
85.69
	
478 K
0.2234
	
988 K
94.12
	
11.2
M
10.01
	
11.2
M
CN-DPM	93.23	
524
K	0.2110	
970
K	94.46	
7.80
M	20.10	
19.2
M
Table 2:Performance comparison on Split-CIFAR10 with various scenario length.
Method	Split-CIFAR10 Acc. (%)	Param.
0.2 Epoch	1 Epoch	10 Epochs
iid-offline	
93.17
	
93.17
	
93.17
	
11.2
M
iid-online	
36.65
	
62.79
	
83.19
	
11.2
M
Fine-tune	
12.68
	
18.08
	
19.31
	
11.2
M
Reservoir	
37.09
	
44.00
	
43.82
	
11.2
M GSS
33.56
	
−
	
−
	
11.2
M
CN-DPM	41.78	45.21	46.98	
4.60
M
Table 3:Dissecting the performance of CN-DPM.
Acc. Type	Split-CIFAR10	Split-CIFAR100
Classifier (init)	
88.20
	
55.42
Classifier (final)	
88.20
	
55.24
Gating (VAEs)	
48.18
	
31.14
Figure 2:Split-CIFAR10 (0.2 Epoch).
Figure 3:Split-CIFAR100.
4.2Compared Methods
All the following baselines use the same base network that will be discussed in section 4.3.
iid-offline and iid-online. iid-offline shows the maximum performance achieved by combining standard training techniques such as data augmentation, learning rate decay, multiple iterations (up to 100 epochs), and larger batch size. iid-online is the model trained with the same number of epoch and batch size with other CL baselines.
Fine-tune. As a popular baseline in the previous works, the base model is naively trained as data enters.
Reservoir. As Chaudhry et al. (2019b) show that simple experience replay (ER) can outperform most CL methods, we test the ER with reservoir sampling as a strong baseline. Reservoir sampling randomly chooses a fixed number of samples with a uniform probability from an indefinitely long stream of data, and thus, it is suitable for managing the replay memory in task-free CL. At each training step, the model is trained using a mini-batch from the data stream and another one of the same sizes from the memory.
Gradient-Based Sample Selection (GSS). Aljundi et al. (2019b) propose a sampling method called GSS that diversifies the gradients of the samples in the replay memory. Since it is designed to work in task-free settings, we report the scores in their paper for comparison.
4.3Model Architecture
Split-MNIST. Following Hsu et al. (2018), we use a simple two-hidden-layer MLP classifier with ReLU activation as the base model for classification. The dimension of each layer is 400. For generation experiments, we use VAE, whose encoder and decoder have the same hidden layer configuration with the classifier. Each expert in CN-DPM has a similar classifier and VAE with smaller hidden dimensions. The first expert starts with 64 hidden units per layer and adds 16 units when a new expert is added. For classification, we adjust hyperparameter 
𝛼
 such that five experts are created. For generation, we set 
𝛼
 to produce 12 experts since more experts produce a better score. We set the memory size in both Reservoir and CN-DPM to 500 for classification and 1000 for generation.
MNIST-SVHN and Split-CIFAR10/100. We use ResNet-18 (He et al., 2016) as the base model. In CN-DPM, we use a 10-layer ResNet for the classifier and a CNN-based VAE. The encoder and the decoder of VAE have two CONV layers and two FC layers. We set 
𝛼
 such that 2, 5, and 20 experts are created for each scenario. The memory sizes in Reservoir, GSS, and CN-DPM are set to 500 for MNIST-SVHN and 1000 for Split-CIFAR10/100. More details can be found in Appendix C.
4.4Results of Task-Free Continual Learning
All reported numbers in our experiments are the average of 10 runs. Table 1 and 3 show our main experimental results. In every setting, CN-DPM outperforms the baselines by significant margins with reasonable parameter usage. Table 3 and Figure 2 shows the results of Split-CIFAR10 experiments. Since Aljundi et al. (2019b) test GSS using only 10K examples of CIFAR10, which is 1/5 of the whole train set, we follow their setting (denoted by 0.2 Epoch) for a fair comparison. We also test a Split-CIFAR10 variant where each task is presented for 10 epochs. The accuracy and the training graph of GSS are excerpted from the original paper, where the accuracy is the average of three runs, and the graph is from one of the runs. In Figure 2, the bold line represents the average of 10 runs (except GSS, which is a single run), and the faint lines are the individual runs. Surprisingly, Reservoir even surpasses the accuracy of GSS and proves to be a simple but powerful CL method.
One interesting observation in Table 3 is that the performance of Reservoir degrades as each task is extended up to 10 epochs. This is due to the nature of replay methods; since the same samples are replayed repeatedly as representatives of the previous tasks, the model tends to be overfitted to the replay memory as training continues. This degradation is more severe when the memory size is small, as presented in Appendix I. Our CN-DPM, on the other hand, uses the memory to buffer recent examples temporarily, so there is no such overfitting problem. This is also confirmed by the CN-DPM’s accuracy consistently increasing as learning progresses.
In addition, CN-DPM is particularly strong compared to other baselines when the number of tasks increases. For example, Reservoir, which performs reasonably well in other tasks, scores poorly in Split-CIFAR100, which involves 20 tasks and 100 classes. Even with the large replay memory of size 1000, the Reservoir suffers from the shortage of memory (e.g., only 50 slots per task). In contrast, CN-DPM’s accuracy is more than double of Reservoir and comparable to that of iid-online.
Table 3 analyzes the accuracy of CN-DPM in Split-CIFAR10/100. We assess the performance and forgetting of individual components. At the end of each task, we measure the test accuracy of the responsible classifier and report the average of such task-wise classifier accuracies as Classifier (init). We report the average of the task-wise accuracies after learning all tasks as Classifier (final). With little difference between the two scores, we confirm that forgetting barely occurs in the classifiers. In addition, we report the gating accuracy measured after training as Gating (VAEs), which is the accuracy of the task identification performed jointly by the VAEs. The relatively low gating accuracy suggests that CN-DPM has much room for improvement through better density estimates.
Overall, CN-DPM does not suffer from catastrophic forgetting, which is a major problem in regularization and replay methods. As a trade-off, however, choosing the right expert arises as another problem in CN-DPM. Nonetheless, the results show that this new direction is especially promising when the number of tasks is very large.
5Conclusion
In this work, we formulated expansion-based task-free CL as learning of a Dirichlet process mixture model with neural experts. We demonstrated that the proposed CN-DPM model achieves great performance in multiple task-free settings, better than the existing methods. We believe there are several interesting research directions beyond this work: (i) improving the accuracy of expert selection, which is the main bottleneck of our method, and (ii) applying our method to different domains such as natural language processing and reinforcement learning.
Acknowledgments
We thank Chris Dongjoo Kim and Yookoon Park for helpful discussion and advice. This work was supported by Video Analytics Center of Excellence in AIX center of SK telecom, Institute of Information & communications Technology Planning & Evaluation (IITP) grant (No.2019-0-01082, SW StarLab) and Basic Science Research Program through National Research Foundation of Korea (NRF) funded by the Korea government (MSIT) (2017R1E1A1A01077431). Gunhee Kim is the corresponding author.
References
Aljundi et al. (2017)	Rahaf Aljundi, Punarjay Chakravarty, and Tinne Tuytelaars.Expert gate: Lifelong learning with a network of experts.In CVPR, 2017.
Aljundi et al. (2018)	Rahaf Aljundi, Francesca Babiloni, Mohamed Elhoseiny, Marcus Rohrbach, and Tinne Tuytelaars.Memory aware synapses: Learning what (not) to forget.In ECCV, 2018.
Aljundi et al. (2019a)	Rahaf Aljundi, Klaas Kelchtermans, and Tinne Tuytelaars.Task-Free continual learning.In CVPR, 2019a.
Aljundi et al. (2019b)	Rahaf Aljundi, Min Lin, Baptiste Goujaud, and Yoshua Bengio.Gradient based sample selection for online continual learning.In NeurIPS, 2019b.
Aljundi et al. (2019c)	Rahaf Aljundi, Marcus Rohrbach, and Tinne Tuytelaars.Selfless sequential learning.In ICLR, 2019c.
Antoniak (1974)	Charles E. Antoniak.Mixtures of dirichlet processes with applications to bayesian nonparametric problems.Ann. Stat., 2(6):1152–1174, 1974.
Blei & Jordan (2006)	David Blei and Michael Jordan.Variational inference for dirichlet process mixtures.Bayesian Anal., 1(1):121–143, 2006.
Burda et al. (2015)	Yuri Burda, Roger Grosse, and Ruslan Salakhutdinov.Importance weighted autoencoders.In ICLR, 2015.
Chaudhry et al. (2019a)	Arslan Chaudhry, Marc’Aurelio Ranzato, Marcus Rohrbach, and Mohamed Elhoseiny.Efficient lifelong learning with a-gem.In ICLR, 2019a.
Chaudhry et al. (2019b)	Arslan Chaudhry, Marcus Rohrbach, Mohamed Elhoseiny, Thalaiyasingam Ajanthan, Puneet K. Dokania, Philip H. S. Torr, and Marc’Aurelio Ranzato.On tiny episodic memories in continual learning.arXiv, (1902.10486v4), 2019b.
Escobar & West (1995)	Michael D. Escobar and Mike West.Bayesian density estimation and inference using mixtures.J. Am. Stat. Assoc., 90(430):577–588, 1995.
Ferguson (1983)	Thomas S. Ferguson.Bayesian density estimation by mixtures of normal distributions.In Recent advances in statistics, pp.  287–302. Academic Press, 1983.
Finn et al. (2017)	Chelsea Finn, Pieter Abbeel, and Sergey Levine.Model-agnostic meta-learning for fast adaptation of deep networks.In ICML, 2017.
He et al. (2016)	Kaiming He, Xiangyu Zhang, Shaoqing Ren, and Jian Sun.Deep residual learning for image recognition.In CVPR, 2016.
Hsu et al. (2018)	Yen-Chang Hsu, Yen-Cheng Liu, Anita Ramasamy, and Zsolt Kira.Re-evaluating continual learning scenarios: A categorization and case for strong baselines.In NeurIPS, Continual Learning Workshop, 2018.
Jacobs et al. (1991)	Robert A. Jacobs, Michael I. Jordan, Steven J. Nowlan, and Geoffrey E. Hinton.Adaptive mixtures of local experts.Neural Comput., 3:79–87, 1991.
Jerfel et al. (2019)	Ghassen Jerfel, Erin Grant, Thomas Griffiths, and Katherine Heller.Reconciling meta-learning and continual learning with online mixtures of tasks.In NeurIPS, 2019.
Kingma & Welling (2014)	Diederik P. Kingma and Max Welling.Auto-Encoding variational bayes.In ICLR, 2014.
Kirkpatrick et al. (2017)	James Kirkpatrick, Razvan Pascanu, Neil Rabinowitz, Joel Veness, Guillaume Desjardins, Andrei Rusu, Kieran Milan, John Quan, Tiago Ramalho, Agnieszka Grabska-Barwinska, Demis Hassabis, Claudia Clopath, Dharshan Kumaran, and Raia Hadsell.Overcoming catastrophic forgetting in neural networks.PNAS, 2017.
Krizhevsky & Hinton (2009)	A Krizhevsky and G Hinton.Learning multiple layers of features from tiny images.Technical report, University of Toronto, 2009.
LeCun et al. (1998)	Yann LeCun, Leon Bottou, Yoshua Bengio, and Patrick Haffner.Gradient-based learning applied to document recognition.Proceedings of the IEEE, 86(11):2278–2324, 1998.
Li et al. (2019)	Xilai Li, Yingbo Zhou, Tianfu Wu, Richard Socher, and Caiming Xiong.Learn to grow: A continual structure learning framework for overcoming catastrophic forgetting.In ICML, 2019.
Li & Hoiem (2017)	Zhizhong Li and Derek Hoiem.Learning without forgetting.IEEE TPAMI, 40(12):2935–2947, 2017.
Lin (2013)	Dahua Lin.Online learning of nonparametric mixture models via sequential variational approximation.In NeurIPS, 2013.
Lopez-Paz & Ranzato (2017)	David Lopez-Paz and Marc’Aurelio Ranzato.Gradient episodic memory for continual learning.In NeurIPS, 2017.
Maceachern (1994)	Steven Maceachern.Estimating normal means with a conjugate style dirichlet process prior.Commun. Stat. - Simul. Comput., 23(3):727–741, 1994.
Maltoni & Lomonaco (2019)	Davide Maltoni and Vincenzo Lomonaco.Continuous learning in single-incremental-task scenarios.Neural Networks, 116:56–73, 2019.
Nagabandi et al. (2019)	Anusha Nagabandi, Chelsea Finn, and Sergey Levine.Deep online learning via Meta-Learning: continual adaptation for Model-Based RL.In ICLR, 2019.
Neal (2000)	Radford M. Neal.Markov chain sampling methods for dirichlet process mixture models.J. Comput. Graph. Stat., 2000.
Netzer et al. (2011)	Yuval Netzer, Tao Wang, Adam Coates, Alessandro Bissacco, Bo Wu, and Andrew Y Ng.Reading digits in natural images with unsupervised feature learning.In NeurIPS, Workshop on Deep Learning and Unsupervised Feature Learning, 2011.
Oord et al. (2016)	Aaron Oord, Nal Kalchbrenner, and Koray Kavukcuoglu.Pixel recurrent neural networks.In ICML, 2016.
Parisi et al. (2019)	German I. Parisi, Ronald Kemker, Jose L. Part, and Christopher Kanan.Continual lifelong learning with neural networks: A review.Neural Networks, 113:54–71, 2019.
Rao et al. (2019)	Dushyant Rao, Francesco Visin, Andrei Rusu, Razvan Pascanu, Yee Whye Teh, and Raia Hadsell.Continual unsupervised representation learning.In NeurIPS, 2019.
Rasmussen & Ghahramani (2002)	Carl Edward Rasmussen and Zoubin Ghahramani.Infinite mixtures of gaussian process experts.In NeurIPS, 2002.
Rebuffi et al. (2017)	Sylvestre-Alvise Rebuffi, Alexander Kolesnikov, Georg Sperl, and Christoph Lampert.iCaRL: incremental classifier and representation learning.In CVPR, 2017.
Rusu et al. (2016)	Andrei A Rusu, Neil C Rabinowitz, Guillaume Desjardins, Hubert Soyer, James Kirkpatrick, Koray Kavukcuoglu, Razvan Pascanu, and Raia Hadsell.Progressive neural networks.In NeurIPS, 2016.
Schwarz et al. (2018)	Jonathan Schwarz, Jelena Luketina, Wojciech Czarnecki, Agnieszka Grabska-Barwinska, Yee Whye Teh, Razvan Pascanu, and Raia Hadsell.Progress & compress: A scalable framework for continual learning.In ICML, 2018.
Shahbaba & Neal (2009)	Babak Shahbaba and Radford Neal.Nonlinear models using dirichlet process mixtures.J. Mach. Learn. Res., 2009.
Shazeer et al. (2017)	Noam Shazeer, Azalia Mirhoseini, Krzysztof Maziarz, Andy Davis, Quoc Le, Geoffrey Hinton, and Jeff Dean.Outrageously large neural networks: The Sparsely-Gated Mixture-of-Experts layer.In ICLR, 2017.
Shin et al. (2017)	Hanul Shin, Jung Lee, Jaehong Kim, and Jiwon Kim.Continual learning with deep generative replay.In NeurIPS, 2017.
Teh (2010)	Yee Whye Teh.Dirichlet process.Springer, Encyclopedia of Machine Learning:280–287, 2010.
van de Ven & Tolias (2018)	Gido M. van de Ven and Andreas S. Tolias.Generative replay with feedback connections as a general strategy for continual learning.arXiv, (1809.10635v2), 2018.
Wang & Dunson (2011)	Lianming Wang and David Dunson.Fast bayesian inference in dirichlet process mixture models.J. Comput. Graph. Stat., 20(1):196–216, 2011.
Xu & Zhu (2018)	Ju Xu and Zhanxing Zhu.Reinforced continual learning.In NeurIPS, 2018.
Yoon et al. (2018)	Jaehong Yoon, Eunho Yang, Jeongtae Lee, and Sung Ju Hwang.Lifelong learning with dynamically expandable networks.In ICLR, 2018.
Zenke et al. (2017)	Friedemann Zenke, Ben Poole, and Surya Ganguli.Continual learning through synaptic intelligence.In ICML, 2017.
Appendix AReview of Dirichlet Process Mixture Model
We review the Dirichlet process mixture (DPM) model and a variational method to approximate the posterior of DPM models in an online setting: Sequential Variational Approximation (SVA) (Lin, 2013).
Dirichlet Process. Dirichlet process (DP) is a distribution over distributions that are defined over infinitely many dimensions. DP is parameterized by a concentration parameter 
𝛼 ∈ ℝ +
 and a base distribution 
𝐺 0
. For a distribution 
𝐺
 sampled from 
DP ​ ( 𝛼 , 𝐺 0 )
, the following holds for any finite measurable partition 
{ 𝐴 1 , 𝐴 2 , … , 𝐴 𝐾 }
 of probability space 
Θ
 (Teh, 2010):
	
( 𝐺 ​ ( 𝐴 1 ) , … , 𝐺 ​ ( 𝐴 𝐾 ) ) ∼ Dir ​ ( 𝛼 ​ 𝐺 0 ​ ( 𝐴 1 ) , … , 𝛼 ​ 𝐺 0 ​ ( 𝐴 𝐾 ) ) .
		
(9)
The stick-breaking process is often used as a more intuitive construction of DP:
	
𝐺 = ∑ 𝑘 = 1 ∞ ( 𝑣 𝑘 ​ ∏ 𝑙 = 1 𝑘 − 1 ( 1 − 𝑣 𝑙 ) ) ​ 𝛿 𝜙 𝑘 , 𝑣 𝑘 ∼
Beta
​ ( 1 , 𝛼 ) , 𝜙 𝑘 ∼ 𝐺 0 .
		
(10)
Initially, we start with a stick of length one, which represents the total probability. At each step 
𝑘
, we cut a proportion 
𝑣 𝑘
 off from the remaining stick (probability) and assign it to the atom 
𝜙 𝑘
 sampled from the base distribution 
𝐺 0
. This formulation shows DP is discrete with probability 1 (Teh, 2010). In our problem setting, 
𝐺
 is a distribution over expert’s parameter space and has positive probability only at the countably many 
𝜙 𝑘
, which are independently sampled from the base distribution.
Dirichlet Process Mixture (DPM) Model. The DPM model is often applied to clustering problems where the number of clusters is not known in advance. The generative process of DPM model is
	
𝑥 𝑛 ∼ 𝑝 ​ ( 𝜃 𝑛 ) , 𝜃 𝑛 ∼ 𝐺 , 𝐺 ∼ DP ​ ( 𝛼 , 𝐺 0 ) ,
		
(11)
where 
𝑥 𝑛
 is the 
𝑛
-th data, and 
𝜃 𝑛
 is the 
𝑛
-th latent variable sampled from 
𝐺
, which itself is a distribution sampled from a Dirichlet process (DP). Since 
𝐺
 is discrete with probability 1, the same values can be sampled multiple times for 
𝜃
. If 
𝜃 𝑛 = 𝜃 𝑚
, the two data points 
𝑥 𝑛 and 𝑥 𝑚
 belong to the same cluster. An alternative formulation uses the indicator variable 
𝑧 𝑛
 that indicates to which cluster the 
𝑛
-th data belongs such that 
𝜃 𝑛 = 𝜙 𝑧 𝑛
 where 
𝜙 𝑘
 is the parameter of 
𝑘
-th cluster. The data 
𝑥 𝑛
 is sampled from a distribution parameterized by 
𝜃 𝑛
. For a DP Gaussian mixture model as an example, each 
𝜃 = { 𝜇 , 𝜎 2 }
 parameterizes a Gaussian distribution.
The Posterior of DPM Models. The posterior of a DPM model for given 
𝜃 1 , … , 𝜃 𝑛
 is also a DP (Teh, 2010):
	
𝐺 | 𝜃 1 , … , 𝜃 𝑛 ∼ DP ​ ( 𝛼 + 𝑛 , 𝛼 𝛼 + 𝑛 ​ 𝐺 0 + 1 𝛼 + 𝑛 ​ ∑ 𝑖 = 1 𝑛 𝛿 ​ ( 𝜃 𝑖 ) ) .
		
(12)
The base distribution of the posterior, which is a weighted average of 
𝐺 0
 and the empirical distribution 
1 𝑛 ​ ∑ 𝑖 = 1 𝑛 𝛿 ​ ( 𝜃 𝑖 )
, is in fact the predictive distribution of 
𝜃 𝑛 + 1
 given 
𝜃 1 : 𝑛
 (Teh, 2010):
	
𝜃 𝑛 + 1 | 𝜃 1 , … , 𝜃 𝑛 ∼ 𝛼 𝛼 + 𝑛 ​ 𝐺 0 + 1 𝛼 + 𝑛 ​ ∑ 𝑖 = 1 𝑛 𝛿 ​ ( 𝜃 𝑖 ) .
		
(13)
If we additionally condition 
𝑥 𝑛
 and reflect the likelihood, we obtain (Neal, 2000):
	
𝜃 𝑛 + 1 | 𝜃 1 , … , 𝜃 𝑛 , 𝑥 𝑛 + 1 ∼ 1 𝑍 ​ ( 𝛼 𝛼 + 𝑛 ​ ∫ 𝑝 ​ ( 𝑥 𝑛 + 1 | 𝜃 ) ​ 𝑑 𝐺 0 ​ ( 𝜃 ) + 1 𝛼 + 𝑛 ​ ∑ 𝑖 = 1 𝑛 𝑝 ​ ( 𝑥 𝑛 + 1 | 𝜃 𝑖 ) ​ 𝛿 ​ ( 𝜃 𝑖 ) ) ,
		
(14)
where 
𝑍
 is the normalizing constant. Note that 
𝜃 𝑛 + 1
 is independent from 
𝑥 1 : 𝑛
 given 
𝜃 1 : 𝑛 .
Approximation of the Posterior of DPM Models. Since the exact inference of the posterior of DPM models is infeasible, approximate inference methods are adopted such as Markov chain Monte Carlo (MCMC) (Maceachern, 1994; Escobar & West, 1995; Neal, 2000) or variational inference (Blei & Jordan, 2006; Wang & Dunson, 2011; Lin, 2013). Among many variational methods, the Sequential Variational Approximation (SVA) (Lin, 2013) approximates the posterior as
	
𝑝 ​ ( 𝐺 | 𝑥 1 : 𝑛 ) = ∑ 𝑧 1 : 𝑛 𝑝 ​ ( 𝑧 1 : 𝑛 | 𝑥 1 : 𝑛 ) ​ 𝑝 ​ ( 𝐺 | 𝑥 1 : 𝑛 , 𝑧 1 : 𝑛 ) ≈ 𝑞 ​ ( 𝐺 | 𝜌 , 𝜈 ) = ∑ 𝑧 1 : 𝑛 ( ∏ 𝑖 = 1 𝑛 𝜌 𝑖 , 𝑧 𝑖 ) ​ 𝑞 𝜈 ( 𝑧 ) ​ ( 𝐺 | 𝑧 1 : 𝑛 ) ,
		
(15)
where 
𝑝 ​ ( 𝑧 1 : 𝑛 | 𝑥 1 : 𝑛 )
 is represented by the product of individual variational probabilities 
𝜌 𝑧 𝑖 for 𝑧 𝑖
, which greatly simplifies the distribution. Moreover, 
𝑝 ​ ( 𝐺 | 𝑥 1 : 𝑛 , 𝑧 1 : 𝑛 )
 is approximated by a stochastic process 
𝑞 𝜈 ( 𝑧 ) ​ ( 𝐺 | 𝑧 1 : 𝑛 )
. Sampling from 
𝑞 𝜈 ( 𝑧 ) ​ ( 𝐺 | 𝑧 1 : 𝑛 )
 is equivalent to constructing a distribution as
	
𝛽 0 ​ 𝐷 ′ + ∑ 𝑘 = 1 𝐾 𝛽 𝑘 ​ 𝛿 𝜙 𝑘 , 𝐷 ′ ∼ DP ​ ( 𝛼 ​ 𝐺 0 ) , ( 𝛽 0 , … , 𝛽 𝐾 ) ∼ Dir ​ ( 𝛼 , | 𝐶 1 ( 𝑧 ) | , … , | 𝐶 𝐾 ( 𝑧 ) | ) , 𝜙 𝑘 ∼ 𝜈 𝑘 ,
		
(16)
where 
{ 𝐶 1 ( 𝑧 ) , 𝐶 2 ( 𝑧 ) , … , 𝐶 𝐾 ( 𝑧 ) }
 is the partition of 
𝑥 1 : 𝑛
 characterized by 
𝑧 .
The approximation yields the following tractable predictive distribution:
	
𝑞 ​ ( 𝜃 ′ | 𝜌 , 𝜈 ) = 𝔼 𝑞 ​ ( 𝐺 | 𝜌 , 𝜈 ) ​ [ 𝑝 ​ ( 𝜃 ′ | 𝐺 ) ] = 𝛼 𝛼 + 𝑛 ​ 𝐺 0 ​ ( 𝜃 ′ ) + ∑ 𝑘 = 1 𝐾 ∑ 𝑖 = 1 𝑛 𝜌 𝑖 , 𝑘 𝛼 + 𝑛 ​ 𝜈 𝑘 ​ ( 𝜃 ′ ) .
		
(17)
SVA uses this predictive distribution for sequential approximation of the posterior of 
𝑧 and 𝜙 .
	
𝑝 ​ ( 𝑧 𝑛 + 1 , 𝜙 ( 𝑛 + 1 ) | 𝑥 1 : 𝑛 + 1 )
	
∝ 𝑝 ​ ( 𝑥 𝑛 + 1 | 𝑧 𝑛 + 1 , 𝜙 ( 𝑛 + 1 ) ) ​ 𝑝 ​ ( 𝑧 𝑛 + 1 , 𝜙 ( 𝑛 + 1 ) | 𝑥 1 : 𝑛 )
		
(18)
		
≈ 𝑝 ​ ( 𝑥 𝑛 + 1 | 𝑧 𝑛 + 1 , 𝜙 ( 𝑛 + 1 ) ) ​ 𝑞 ​ ( 𝑧 𝑛 + 1 , 𝜙 ( 𝑛 + 1 ) | 𝜌 1 : 𝑛 , 𝜈 ( 𝑛 ) ) .
		
(19)
While the data is given one by one, SVA sequentially updates the variational parameters; the following 
𝜌 𝑛 + 1 and 𝜈 ( 𝑛 + 1 )
 at step 
𝑛 + 1
 minimizes the KL divergence between 
𝑞 ​ ( 𝑧 𝑛 + 1 , 𝜙 ( 𝑛 + 1 ) | 𝜌 1 : 𝑛 + 1 , 𝜈 ( 𝑛 + 1 ) )
 and the posterior:
	
𝜌 𝑛 + 1 , 𝑘
	
∝ { ( ∑ 𝑖 = 1 𝑛 𝜌 𝑖 , 𝑘 ) ​ ∫ 𝜃 𝑝 ​ ( 𝑥 𝑛 + 1 | 𝜃 ) ​ 𝜈 𝑘 ( 𝑛 ) ​ ( 𝑑 ​ 𝜃 )
	
if ​ 1 ≤ 𝑘 ≤ 𝐾
𝛼 ​ ∫ 𝜃 𝑝 ​ ( 𝑥 𝑛 + 1 | 𝜃 ) ​ 𝐺 0 ​ ( 𝑑 ​ 𝜃 )
	
if ​ 𝑘 = 𝐾 + 1 ,
		
(20)
	
𝜈 𝑘 ( 𝑛 + 1 ) ​ ( 𝑑 ​ 𝜃 )
	
∝ { 𝐺 0 ​ ( 𝑑 ​ 𝜃 ) ​ ∏ 𝑖 = 1 𝑛 + 1 𝑝 ​ ( 𝑥 𝑖 | 𝜃 ) 𝜌 𝑖 , 𝑘
	
if ​ 1 ≤ 𝑘 ≤ 𝐾
𝐺 0 ​ ( 𝑑 ​ 𝜃 ) ​ 𝑝 ​ ( 𝑥 𝑛 + 1 | 𝜃 ) 𝜌 𝑛 + 1 , 𝑘
	
if ​ 𝑘 = 𝐾 + 1 .
		
(21)
In practice, SVA adds a new component only when 
𝜌 𝑛 + 1 , 𝐾 + 1
 is greater than a threshold 
𝜖
. It uses stochastic gradient descent to find and maintain the MAP estimation of parameters instead of calculating the whole distribution 
𝜈 𝑘 :
	
𝜙 ^ 𝑘 ( 𝑛 + 1 ) ← 𝜙 ^ 𝑘 ( 𝑛 ) + 𝜆 𝑛 ​ ( ∇ 𝜙 ^ 𝑘 ( 𝑛 ) log ⁡ 𝐺 0 ​ ( 𝜙 ^ 𝑘 ( 𝑛 ) ) + ∇ 𝜙 ^ 𝑘 ( 𝑛 ) log ⁡ 𝑝 ​ ( 𝑥 | 𝜙 ^ 𝑘 ( 𝑛 ) ) ) ,
		
(22)
where 
𝜆 𝑘 ( 𝑛 )
 is a learning rate of component 
𝑘
 at step 
𝑛
, which decreases as in the Robbins-Monro algorithm.
Appendix BPractical Issues of CN-DPM
CN-DPN is designed based on strong theoretical foundations, including the nonparametric Bayesian framework. In this section, we further discuss some practical issues of CN-DPM with intuitive explanations.
Bounded expansion of CN-DPM. The number of components in the DPM model is determined by the data distribution and the concentration parameter. If the true distribution consists of 
𝐾
 clusters, the number of effective components converges to 
𝐾
 under an appropriate concentration parameter 
𝛼
. Typically, the number of components is bounded by 
𝑂 ​ ( 𝛼 ​ log ⁡ 𝑁 )
 (Teh, 2010). Experiments in Appendix H empirically show that CN-DPM does not blindly increase the number of experts.
The continued increase in model capacity. Our model capacity keeps increasing as it learns new tasks. However, we believe this is one of the strengths of our method, since it may not make sense to use a fixed-capacity neural network to learn an indefinitely long sequence of tasks. The underlying assumption of using a fixed-capacity model is that the pre-set model capacity is adequate (at least not insufficient) to learn the incoming tasks. On the other hand, CN-DPM approaches the problem in a different direction: start small and add more as needed. This property is essential in task-free settings where the total number of tasks is not known. If there are too many tasks than expected, a fixed-capacity model would not be able to learn them successfully. Conversely, if there are fewer tasks than expected, resources would be wasted. We argue that expansion is a promising direction since it does not need to fix the model capacity beforehand. Moreover, we also introduce an algorithm to prune redundant experts in Appendix D,
Generality of the concentration parameter. The concentration parameter controls how sensitive the model is to new data. In other words, it determines the level of discrepancy between tasks, that makes the tasks modeled by distinct components. As an example, suppose that we are designing a hand-written alphabet classifier that continually learns in the real world. In the development, we only have the character images for half of the alphabets, i.e., from ‘a’ to ‘m’. If we can find a good concentration parameter 
𝛼
 for the data from ‘a’ to ‘m’, the same 
𝛼
 can work well with novel alphabets (i.e., from ‘n’ to ‘z’) because the alphabets would have a similar level of discrepancies between tasks. Therefore, we do not need to access the whole data to determine 
𝛼
 if the discrepancy between tasks is steady.
Appendix CModel Architectures and Experimental Details
C.1Base Models
C.1.1Split-MNIST
Following Hsu et al. (2018), we use two-hidden-layer MLP classifier with 400 hidden units per layer. For generation tasks, we use a simple VAE with the two-hidden-layer MLP encoder and decoder, where each layer contains 400 units. The dimension of the latent code is set to 32. We use ReLU for all intermediate activation functions.
C.1.2MNIST-SVHN and Split-CIFAR10/100
We use ResNet-18 (He et al., 2016). The input images are transformed to 32
×
32 RGB images.
C.2CN-DPM
C.2.1Split-MNIST
For the classifiers in experts, we use a smaller version of the base MLP classifier. In the first expert, we set the number of hidden units per layer to 64. In the second or later experts, we introduce 16 new units per layer which are connected to the lower layers of the existing experts. For the encoder and decoder of VAEs, we use a two-layer MLP. The encoder is expanded in the same manner as the classifier. However, we do not share the parameters beyond the encoders; with a latent code of dimension 16, we use the two-hidden-layer MLP decoder as done in the classifier. For generation tasks, we double the size; for example, we set the size of initial and additional hidden units to 128 and 32, respectively.
C.2.2Split-CIFAR10/100
The ResNet-18 base network has eight residual blocks. After passing through 2 residual blocks, the width and height of the feature are halved, and the number of channels is doubled. The initial number of channels is set to 64.
For the classifiers in CN-DPM, we use a smaller version of ResNet that has only four residual blocks and resizes the feature every block. The initial number of channels is set to 20 in the first expert, and four initial channels are added with a new expert. Thus, 4, 8, 16, and 32 channels are added for the four blocks. The first layer of each block is connected to the last layer of the previous block of prior experts.
For the VAEs, we use a simple CNN-based VAEs. The encoder has two 3
×
3 convolutions followed by two fully connected layers. Each convolution is followed by 2
×
2 max-pool and ReLU activation. The numbers of channels and hidden units are doubled after each layer. In the first expert, the first convolution outputs 32 channels, while four new channels are added with each new expert.
As done for the VAE in Split-MNIST, each expert’s VAE has an unshared decoder with a 64-dimensional latent code. The decoder is the mirrored encoder where 3
×
3 convolution is replaced by 4
×
4 transposed convolution with a stride of 2.
C.2.3MNIST-SVHN
For the classifier, we use ResNet-18 with 32 channels for the first expert and additional 32 channels for each new expert. We use the same VAE as in Split-CIFAR10.
C.3Experimental Details
We use the classifier temperature parameter of 0.01 for Split-MNIST, Split-CIFAR10/100, and no temperature parameter on MNIST-SVHN. Weight decay 0.00001 has been used for every model in the paper. Gradients are clipped by value with a threshold of 0.5. All the CN-DPM models are trained by Adam optimizer. During the sleep phase, we train the new expert for multiple epochs with a batch size of 50. In classification tasks, we improve the density estimation of VAEs by sampling 16 latent codes and averaging the ELBOs, following Burda et al. (2015).
C.3.1Split-MNIST
The learning rate of 0.0001 and 0.0004 has been used for the classifier and VAE of each expert in the classification task. We use learning rate 0.003 for the VAE of each expert in generation task. In the generation task, we decay the learning rate of the expert by 0.003 before it enters the wake phase. Following the existing works in VAE literature, we use binarized MNIST for the generation experiments. VAEs are trained to maximize Bernoulli log-likelihood in the generation task, while Gaussian log-likelihood is used for the classification task.
C.3.2Split-CIFAR10
The learning rate of 0.005 and 0.0002 has been used for the classifier and VAE of each expert in CIFAR10. We decay the learning rate of the expert by 0.1 before it enters the wake phase. VAEs are trained to maximize Gaussian log-likelihood.
C.3.3Split-CIFAR100
The learning rate of 0.0002 and 0.0001 has been used for the classifier and VAE of each expert in CIFAR10. We decay the learning rate of the expert by 0.2 before it enters the wake phase. VAEs are trained to maximize Gaussian log-likelihood.
C.3.4MNIST-SVHN
The learning rate of 0.0001 and 0.0003 has been used for the classifier and VAE of each expert in CIFAR10. We decay the learning rates of classifier and VAE of each expert by 0.5 and 0.1 before it enters the wake phase. VAEs are trained to maximize Gaussian log-likelihood.
Appendix DPruning Redundant Experts
Lin (2013) propose a simple algorithm to prune and merge redundant components in DPM models. Following the basic principle of the algorithm, we provide a pruning algorithm for CN-DPM. First, we need to measure the similarities between experts to choose which expert to prune. We compute the log-likelihood 
𝑙 𝑛 ​ 𝑘 = 𝑝 ​ ( 𝑥 𝑛 , 𝑦 𝑛 | 𝜙 ^ 𝑘 )
 of each expert 
𝑘
 for data 
( 𝑥 1 : 𝑁 , 𝑦 1 : 𝑁 )
. As a result, we can obtain 
𝐾
 vectors with 
𝑁
 dimensions. We define the similarity 
𝑠 ​ ( 𝑘 , 𝑘 ′ )
 between two experts 
𝑘 and 𝑘 ′
 as the cosine similarity between the two corresponding vectors 
𝑙 ⋅ 𝑘 and 𝑙 ⋅ 𝑘 ′
, i.e., 
𝑠 ​ ( 𝑘 , 𝑘 ′ ) = 𝑙 ⋅ 𝑘 ⋅ 𝑙 ⋅ 𝑘 ′ | 𝑙 ⋅ 𝑘 | ​ | 𝑙 ⋅ 𝑘 ′ |
. If the similarity is greater than a certain threshold 
𝜖
, we remove one of the experts with smaller 
𝑁 𝑘 = ∑ 𝑛 𝜌 𝑛 , 𝑘
. The 
𝑁 𝑘
 data of the removed expert are added to the remaining experts.
Figure 4 shows an example of an expert pruning. We test CN-DPM on Split-MNIST with an 
𝛼
 higher than the optimal value such that more than five experts are created. In this case, seven experts are created. If we build a similarity matrix as shown in Figure 4(b), we can see which pair of experts are similar. We then threshold the matrix at 0.9 in Figure 4(c) and choose expert pairs (2/3) and (5/6) for pruning. Comparing 
𝑁 𝑘
 within each pair, we can finally choose to prune expert 3 and 6. After pruning, the test accuracy marginally drops from 87.07% to 86.01%.
(a)Training curve
(b)Similarity matrix
(c)Thresholded similarity matrix
Figure 4:An example of the expert pruning in the Split-MNIST scenario.
Appendix EComparison with Task-Based Methods on Split-MNIST
Table 4 compares our method with task-based methods for Split-MNIST classification. All the numbers except for our CN-DPM are excerpted from Hsu et al. (2018), in which all methods are trained for four epochs per task with a batch size of 128. Our method is trained for four epochs per task with a batch size of 10. The model architecture used in compared methods is the same as our baselines: a two-hidden-layer MLP with 400 hidden units per layer. All compared methods use a single output head, and the task information is given at training time but not at test time. For CN-DPM, we test two training settings where the first one uses task information to select experts, while the second one infers the responsible expert by the DPM principle. Task information is not given at test time in both cases.
Notice that regularization methods often suffer from catastrophic forgetting while replay methods yield decent accuracies. Even though the task-free condition is a far more difficult setting, the performance of our method is significantly better than regularization and replay methods that exploit the task description. If task information is available at train time, we can utilize it to improve the performance even more.
Table 4: Comparison with task-based methods on Split-MNIST classification. We report the average of 10 runs with 
±
 standard error of the mean. The numbers except ours are from Hsu et al. (2018).
Type	Method	Task labels	Accuracy (%)
Regularization	EWC (Kirkpatrick et al., 2017)	✓	19.80 
±
 0.05
Online EWC (Schwarz et al., 2018) 	✓	19.77 
±
 0.04
SI (Zenke et al., 2017) 	✓	19.67 
±
 0.09
MAS (Aljundi et al., 2018) 	✓	19.52 
±
 0.04
LwF (Li & Hoiem, 2017) 	✓	24.17 
±
 0.33
Replay	GEM (Lopez-Paz & Ranzato, 2017)	✓	92.20 
±
 0.12
DGR (Shin et al., 2017) 	✓	91.24 
±
 0.33
RtF (van de Ven & Tolias, 2018) 	✓	92.56 
±
 0.21
Expansion	CN-DPM	✓	93.81 
±
 0.07
CN-DPM	✗	93.70 
±
 0.07
Upper bound (iid)		97.53 
±
 0.30
Appendix FFuzzy Split-MNIST
In addition, we experiment with the case where the task boundaries are not clearly defined, which we call Fuzzy-Split-MNIST. Instead of discrete task boundaries, we have transition stages between tasks where the data of existing and new tasks are mixed, but the proportion of the new task linearly increases. This condition adds another level of difficulty since it makes the methods unable to rely on clear task boundaries. The scenario is visualized in Figure 5. As shown in Table 5, CN-DPM can perform continual learning without task boundaries.
Table 5:Fuzzy Split-MNIST
Method	Acc. (%)	Param.
Fine-tune	
28.41
±
0.52
	
478 K
Reservoir	
88.64
±
0.48
	
478 K
CN-DPM	
93.22
±
0.07
	
524 K
Figure 5:Scenario configuration of Fuzzy Split-MNIST
Appendix GGeneration of Samples
Even in discriminative tasks where the goal is to model 
𝑝 ​ ( 𝑦 | 𝑥 )
, CN-DPM learns the joint distribution 
𝑝 ​ ( 𝑥 , 𝑦 )
. Since CN-DPM is a complete generative model, it can generate 
( 𝑥 , 𝑦 )
 pairs. To generate a sample, we first sample 
𝑧
 from 
𝑝 ​ ( 𝑧 )
 which is modeled by the categorical distribution 
Cat ​ ( 𝑁 1 𝑁 , 𝑁 2 𝑁 , … , 𝑁 𝐾 𝑁 )
, i.e., choose an expert. Given 
𝑧 = 𝑘
, we first sample 
𝑥
 from the generator 
𝑝 ​ ( 𝑥 ; 𝜙 𝑘 𝐺 )
, and then sample 
𝑦
 from the discriminator 
𝑝 ​ ( 𝑦 | 𝑥 ; 𝜙 𝑘 𝐷 )
. Figure 6 presents 50 sample examples generated from a CN-DPM trained on Split-MNIST for a single epoch. We observe that CN-DPM successfully generates examples of all tasks with no catastrophic forgetting.
Figure 6:Examples of generation samples by CN-DPM trained on Split-MNIST.
Appendix HExperiments with Longer Continual Learning Scenarios
We present experiments with much longer continual learning scenarios on Split-MNIST, Split-CIFAR10 and Split-CIFAR100 in Table 6, 7 and 8, respectively. We report the average of 10 runs with 
±
 standard error of the mean. To compare with the default 1-epoch scenario, we carry out experiments that repeat each task 10 times, which are denoted 10 Epochs. In addition, we also present the results of repeating the whole scenario 10 times, which are denoted 1 Epoch 
×
10. For example, in Split-MNIST, the 10 Epochs scenario consists of 10-epoch 0/1, 10-epoch 2/3, …, 10-epoch 8/9 tasks. On the other hand, the 1 Epoch 
×
10 scenario revisits each task multiple times, i.e., 1-epoch 0/1, 1-epoch 2/3, …, 1-epoch 8/9, 1-epoch 0/1, …, 1-epoch 8/9. We use the same hyperparameters tuned for the 1-epoch scenario.
We find that the accuracy of Reservoir drops as the length of each task increases. As mentioned in the main text, this phenomenon seems to be caused by overfitting on the samples in the replay memory. Since only a small number of examples in the memory represent each task, replaying them for a long period degrades the performance. On the other hand, the performance of our CN-DPM improves as the learning process is extended.
In the 1 Epoch 
×
10 setting, CN-DPM shows similar performance with 10 Epoch since the model sees each data point 10 times in both scenarios. On the other hand, Reservoir’s scores in the 1 Epoch 
×
10 largely increase compared to both 1 Epoch and 10 Epoch This difference can be explained by how the replay memory changes while training progresses. In the 10 Epoch setting, if a task is finished, it is not visited again. Therefore, the examples of the task in the replay memory monotonically decreases, and the remaining examples are replayed repeatedly. As the training progresses, the model is overfitted to the old examples in the memory and fails to generalize in the old tasks. In contrast, in 1 Epoch 
×
10 setting, each task is revisited multiple times, and each time a task is revisited, the replay memory is also updated with the new examples of the task. Therefore, the overfitting problem in the old tasks is greatly relieved.
Another important remark is that CN-DPM does not blindly increase the number of experts. If we add a new expert at every constant steps, we would have 10 times more experts in the longer scenarios. However, this is not the case. CN-DPM determines whether it needs a new expert on a data-by-data basis such that the number of experts is determined by the task distribution, not by the length of training.
Table 6:Experiments with longer training episodes on Split-MNIST
Method	1 Epoch	10 Epochs	1 Epoch 
× 10
Acc. (%)	Param.	Acc. (%)	Param.	Acc. (%)	Param.
iid-offline	
98.63
±
0.01
	
478 K
98.63
±
0.01
	
478 K
98.63
±
0.01
	
478 K
iid-online	
96.18
±
0.19
	
478 K
97.67
±
0.05
	
478 K
97.67
±
0.05
	
478 K
Fine-tune	
19.43
±
0.02
	
478 K
19.68
±
0.01
	
478 K
20.27
±
0.26
	
478 K
Reservoir	
85.69
±
0.48
	
478 K
78.82
±
0.71
	
478 K
92.06
±
0.11
	
478 K
CN-DPM	
93.23
±
0.09
	
524 K
94.39
±
0.04
	
524 K
94.15
±
0.04
	
616 K
Table 7:Experiments with longer training episodes on Split-CIFAR10
Method	1 Epoch	10 Epochs	1 Epoch 
× 10
Acc. (%)	Param.	Acc. (%)	Param.	Acc. (%)	Param.
iid-offline	
93.17
±
0.03
	
11.2
M
93.17
±
0.03
	
11.2
M
93.17
±
0.03
	
11.2
M
iid-online	
62.79
±
1.30
	
11.2
M
83.19
±
0.27
	
11.2
M
83.19
±
0.27
	
11.2
M
Fine-tune	
18.08
±
0.13
	
11.2
M
19.31
±
0.03
	
11.2
M
19.33
±
0.03
	
11.2
M
Reservoir	
44.00
±
0.92
	
11.2
M
43.82
±
0.53
	
11.2
M
51.44
±
0.42
	
11.2
M
CN-DPM	
45.21
±
0.18
	
4.60
M
46.98
±
0.18
	
4.60
M
47.10
±
0.16
	
4.60
M
Table 8:Experiments with longer training episodes on Split-CIFAR100
Method	1 Epoch	10 Epochs	1 Epoch 
× 10
Acc. (%)	Param.	Acc. (%)	Param.	Acc. (%)	Param.
iid-offline	
73.80
±
0.11
	
11.2
M
73.80
±
0.11
	
11.2
M
73.80
±
0.11
	
11.2
M
iid-online	
20.46
±
0.30
	
11.2
M
54.58
±
0.27
	
11.2
M
54.58
±
0.27
	
11.2
M
Fine-tune	
2.43
±
0.05
	
11.2
M
3.99
±
0.03
	
11.2
M
4.30
±
0.02
	
11.2
M
Reservoir	
10.01
±
0.35
	
11.2
M
6.61
±
0.20
	
11.2
M
14.53
±
0.35
	
11.2
M
CN-DPM	
20.10
±
0.12
	
19.2
M
20.95
±
0.09
	
19.2
M
20.67
±
0.13
	
19.2
M
Appendix IExperiments with Different Memory Sizes
In Split-CIFAR10/100 experiments in the main text, we set the memory size of Reservoir and CN-DPM to 1000, following Aljundi et al. (2019b). Table 9 compares the experimental results with different memory sizes of 500 and 1000 on Split-CIFAR10/100. Compared to Reservoir, whose performance drops significantly with smaller memory, CN-DPM’s accuracy drop is relatively marginal.
Table 9:Experiments with different memory sizes.
Method	Memory	Split-CIFAR10 Acc. (%)	Split-CIFAR100 Acc. (%)
1 Epoch	10 Epoch	1 Epoch	10 Epoch
Reservoir	
500
	
33.53
±
1.03
	
34.46
±
0.49
	
6.24
±
0.25
	
4.99
±
0.09
CN-DPM	
500
	
43.07
±
0.16
	
47.01
±
0.22
	
19.17
±
0.13
	
20.77
±
0.11
Reservoir	
1000
	
44.00
±
0.92
	
43.82
±
0.53
	
10.01
±
0.35
	
6.61
±
0.20
CN-DPM	
1000
	
45.21
±
0.18
	
46.98
±
0.18
	
20.10
±
0.12
	
20.95
±
0.09
Appendix JThe Effect of Concentration Parameter
Table 10 shows the results of CN-DPM on Split-MNIST classification according to the concentration parameter 
𝛼
, which defines the prior of how sensitive CN-DPM is to new data. With a higher 
𝛼
, an expert tends to be created more easily. In the experiment reported in the prior sections, we set 
log ⁡ 𝛼 = − 400
. At 
log ⁡ 𝛼 = − 600
, too few experts are created, and the accuracy is rather low. As 
𝛼
 increases, the number of experts grows along with the accuracy. Although the CN-DPM model is task-free and automatically decides the task assignments to experts, we still need to tune the concentration parameter to find the best balance point between performance and model capacity, as all Bayesian nonparametric models require.
Table 10:The effects of concentration parameter 
𝛼 . log ⁡ 𝛼
	Acc. (%)	Experts	Param.
− 600
54.04
±
2.22
	
3.20
±
0.13
	
362 K
− 400
93.23
±
0.09
	
5.00
±
0.00
	
524 K 80
93.54
±
0.21
	
14.4
±
1.35
	
1.44
M
Figure 7:The effects of concentration parameter 
𝛼 .
Appendix KThe Effect of Parameter Sharing
Table 11 compares when the parameters are shared between experts and when they are not shared. By sharing the parameters, we could reduce the number of parameters by approximately 38% without sacrificing accuracy.
Table 11:The effects of parameter sharing.
Model	Acc. (%)	Experts	Param.
CN-DPM	
93.23
±
0.09
	
5
	
524 K
CN-DPM w/o PS	
93.30
±
0.24
	
5
	
839 K
Appendix LTraining Graphs
Figure 8 shows the training graphs of our experiments. In addition to the performance metrics, we present the number of experts in CN-DPM and compare the total number of parameters with the baselines. The bold lines represent the average of the 10 runs while the faint lines represent individual runs.
Figure 9 and Figure 10 show how the accuracy of each task changes during training. We also present the average accuracy of learned tasks at the bottom right.
(a)Split-MNIST
(b)Split-MNIST (Gen.)
(c)MNIST-SVHN
(d)Split-CIFAR10
(e)Split-CIFAR100
Figure 8:Full training graphs.
Figure 9:Accuracy for each task in Split-CIFAR10.
Figure 10:Accuracy for each task in Split-CIFAR100.
Appendix MComparison with the CURL
Continual Unsupervised Representation Learning (CURL) (Rao et al., 2019) is a parallel work that shares some characteristics with our CN-DPM in terms of model expansion and short-term memory. However, there are several key differences that distinguish our method from CURL, which will be elaborated in this section. Following the notations of Rao et al. (2019), here 
𝑦
 denotes the cluster assignment, and 
𝑧
 denotes the latent variable.
1. The Generative Process. The primary goal of CURL is to continually learn a unified latent representation 
𝑧
, which is shared across all tasks. Therefore, the generative model of CURL explicitly consists of the latent variable 
𝑧
 as summarized as follows:
	
𝑝 ​ ( 𝑥 , 𝑦 , 𝑧 ) = 𝑝 ​ ( 𝑦 ) ​ 𝑝 ​ ( 𝑧 | 𝑦 ) ​ 𝑝 ​ ( 𝑥 | 𝑧 ) ​
 where 
​ 𝑦 ∼ Cat ​ ( 𝜋 ) , 𝑧 ∼ 𝒩 ​ ( 𝜇 𝑧 ​ ( 𝑦 ) , 𝜎 𝑧 2 ​ ( 𝑦 ) ) , 𝑥 ∼
Bernoulli
​ ( 𝜇 𝑥 ​ ( 𝑧 ) ) .
	
The overall distribution of 
𝑧
 is the mixture of Gaussians, and 
𝑧
 includes the information of 
𝑦
 such that 
𝑥 and 𝑦
 are conditionally independent given 
𝑧
. Then, 
𝑧
 is fed into a single decoder network 
𝜇 𝑥
 to generate the mean of 
𝑥
, which is modeled by a Bernoulli distribution. On the other hand, the generative version of CN-DPM, which does not include classifiers, has a simpler generative process:
	
𝑝 ​ ( 𝑥 , 𝑦 ) = 𝑝 ​ ( 𝑦 ) ​ 𝑝 ​ ( 𝑥 | 𝑦 ) ​
 where 
​ 𝑦 ∼ Cat ​ ( 𝜋 ) , 𝑥 ∼ 𝑝 ​ ( 𝑥 | 𝑦 ) .
	
The choice of 
𝑝 ​ ( 𝑥 | 𝑦 )
 here is not necessarily restricted to VAEs (Kingma & Welling, 2014); one may use other kinds of explicit density models such as PixelRNN (Oord et al., 2016). Even if we use VAEs to model 
𝑝 ​ ( 𝑥 | 𝑦 )
, the generative process is different from CURL:
	
𝑝 ​ ( 𝑥 , 𝑦 , 𝑧 ) = 𝑝 ​ ( 𝑦 ) ​ 𝑝 ​ ( 𝑧 ) ​ 𝑝 ​ ( 𝑥 | 𝑦 , 𝑧 ) ​
 where 
​ 𝑦 ∼ Cat ​ ( 𝜋 ) , 𝑧 ∼ 𝒩 ​ ( 0 , 𝐼 ) , 𝑥 ∼
Bernoulli
​ ( 𝜇 𝑥 𝑦 ​ ( 𝑧 ) ) .
	
Unlike CURL, CN-DPM generates 
𝑦 and 𝑧
 independently and maintains a separate decoder 
𝜇 𝑥 𝑦
 for each cluster 
𝑦 .
2. The Necessity for Generative Replay in CURL. CURL periodically saves a copy of its parameters and use it to generate samples of learned distribution. The generated samples are played together with new data such that the main model does not forget previously learned knowledge. This process is called generative replay. The generative replay is an essential element in CURL, unlike our CN-DPM. CURL assumes a factorized variational posterior 
𝑞 ​ ( 𝑦 , 𝑧 | 𝑥 ) = 𝑞 ​ ( 𝑦 | 𝑥 ) ​ 𝑞 ​ ( 𝑧 | 𝑥 , 𝑦 )
 where 
𝑞 ​ ( 𝑦 | 𝑥 ) and 𝑞 ​ ( 𝑧 | 𝑥 , 𝑦 )
 are modeled by separate output heads of the encoder neural network. However, the output head for 
𝑞 ​ ( 𝑦 | 𝑥 )
 is basically a gating network that could be vulnerable to catastrophic forgetting, as mentioned in Section 3.1. Moreover, CURL shares a single decoder 
𝜇 𝑥
 across all tasks. As a consequence, expansion alone is not enough to stop catastrophic forgetting, and CURL needs another CL method to prevent catastrophic forgetting in the shared components. This is the main reason why the generative replay is crucial in CURL. As shown in the ablation test of Rao et al. (2019), the performance of CURL drops without the generative replay. In contrast, the components of CN-DPM are separated for each task (although they may share low-level representations) such that no additional treatment is needed.
◄  Feeling
lucky? Conversion
report Report
an issue View original
on arXiv►
Copyright Privacy Policy Generated on Sat Mar 16 11:23:59 2024 by LaTeXML
