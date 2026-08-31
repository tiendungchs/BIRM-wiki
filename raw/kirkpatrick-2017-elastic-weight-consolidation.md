---
title: "Overcoming catastrophic forgetting in neural networks"
source: "https://pmc.ncbi.nlm.nih.gov/articles/PMC5380101/"
author:
  - "[[James Kirkpatrick]]"
  - "[[Razvan Pascanu]]"
  - "[[Neil Rabinowitz]]"
  - "[[Joel Veness]]"
  - "[[Guillaume Desjardins]]"
  - "[[Andrei A Rusu]]"
  - "[[Kieran Milan]]"
  - "[[John Quan]]"
  - "[[Tiago Ramalho]]"
  - "[[Agnieszka Grabska-Barwinska]]"
  - "[[Demis Hassabis]]"
  - "[[Claudia Clopath]]"
  - "[[Dharshan Kumaran]]"
  - "[[Raia Hadsell]]"
published:
created: 2026-08-31
description: "Deep neural networks are currently the most successful machine-learning technique for solving a variety of tasks, including language translation, image classification, and image generation. One weakness of such models is that, unlike humans, they ..."
tags:
  - "clippings"
---
. 2017 Mar 14;114(13):3521–3526. doi: [10.1073/pnas.1611835114](https://doi.org/10.1073/pnas.1611835114)

[James Kirkpatrick](https://pubmed.ncbi.nlm.nih.gov/?term=%22Kirkpatrick%20J%22[Author]) <sup>a,</sup><sup>1</sup>, [Razvan Pascanu](https://pubmed.ncbi.nlm.nih.gov/?term=%22Pascanu%20R%22[Author]) <sup>a</sup>, [Neil Rabinowitz](https://pubmed.ncbi.nlm.nih.gov/?term=%22Rabinowitz%20N%22[Author]) <sup>a</sup>, [Joel Veness](https://pubmed.ncbi.nlm.nih.gov/?term=%22Veness%20J%22[Author]) <sup>a</sup>, [Guillaume Desjardins](https://pubmed.ncbi.nlm.nih.gov/?term=%22Desjardins%20G%22[Author]) <sup>a</sup>, [Andrei A Rusu](https://pubmed.ncbi.nlm.nih.gov/?term=%22Rusu%20AA%22[Author]) <sup>a</sup>, [Kieran Milan](https://pubmed.ncbi.nlm.nih.gov/?term=%22Milan%20K%22[Author]) <sup>a</sup>, [John Quan](https://pubmed.ncbi.nlm.nih.gov/?term=%22Quan%20J%22[Author]) <sup>a</sup>, [Tiago Ramalho](https://pubmed.ncbi.nlm.nih.gov/?term=%22Ramalho%20T%22[Author]) <sup>a</sup>, [Agnieszka Grabska-Barwinska](https://pubmed.ncbi.nlm.nih.gov/?term=%22Grabska-Barwinska%20A%22[Author]) <sup>a</sup>, [Demis Hassabis](https://pubmed.ncbi.nlm.nih.gov/?term=%22Hassabis%20D%22[Author]) <sup>a</sup>, [Claudia Clopath](https://pubmed.ncbi.nlm.nih.gov/?term=%22Clopath%20C%22[Author]) <sup>b</sup>, [Dharshan Kumaran](https://pubmed.ncbi.nlm.nih.gov/?term=%22Kumaran%20D%22[Author]) <sup>a</sup>, [Raia Hadsell](https://pubmed.ncbi.nlm.nih.gov/?term=%22Hadsell%20R%22[Author]) <sup>a</sup>

PMCID: PMC5380101 PMID: [28292907](https://pubmed.ncbi.nlm.nih.gov/28292907/)

## Significance

Deep neural networks are currently the most successful machine-learning technique for solving a variety of tasks, including language translation, image classification, and image generation. One weakness of such models is that, unlike humans, they are unable to learn multiple tasks sequentially. In this work we propose a practical solution to train such models sequentially by protecting the weights important for previous tasks. This approach, inspired by synaptic consolidation in neuroscience, enables state of the art results on multiple reinforcement learning problems experienced sequentially.

**Keywords:** synaptic consolidation, artificial intelligence, stability plasticity, continual learning, deep learning

## Abstract

The ability to learn tasks in a sequential fashion is crucial to the development of artificial intelligence. Until now neural networks have not been capable of this and it has been widely thought that catastrophic forgetting is an inevitable feature of connectionist models. We show that it is possible to overcome this limitation and train networks that can maintain expertise on tasks that they have not experienced for a long time. Our approach remembers old tasks by selectively slowing down learning on the weights important for those tasks. We demonstrate our approach is scalable and effective by solving a set of classification tasks based on a hand-written digit dataset and by learning several Atari 2600 games sequentially.

---

Achieving artificial general intelligence requires that agents are able to learn and remember many different tasks ([^1]). This is particularly difficult in real-world settings: The sequence of tasks may not be explicitly labeled, tasks may switch unpredictably, and any individual task may not recur for long time intervals. Critically, therefore, intelligent agents must demonstrate a capacity for continual learning: that is, the ability to learn consecutive tasks without forgetting how to perform previously trained tasks.

Continual learning poses particular challenges for artificial neural networks due to the tendency for knowledge of the previously learned task(s) (e.g., task *A*) to be abruptly lost as information relevant to the current task (e.g., task *B*) is incorporated. This phenomenon, termed catastrophic forgetting ([^2] – [^5]), occurs specifically when the network is trained sequentially on multiple tasks because the weights in the network that are important for task *A* are changed to meet the objectives of task *B*. Whereas recent advances in machine learning and in particular deep neural networks have resulted in impressive gains in performance across a variety of domains (e.g., refs. [^6] and [^7]), little progress has been made in achieving continual learning. Current approaches have typically ensured that data from all tasks are simultaneously available during training. By interleaving data from multiple tasks during learning, forgetting does not occur because the weights of the network can be jointly optimized for performance on all tasks. In this regime—often referred to as the multitask learning paradigm—deep-learning techniques have been used to train single agents that can successfully play multiple Atari games ([^8], [^9]). If tasks are presented sequentially, multitask learning can be used only if the data are recorded by an episodic memory system and replayed to the network during training. This approach \[often called system-level consolidation ([^3], [^4])\] is impractical for learning large numbers of tasks, as in our setting it would require the amount of memories being stored and replayed to be proportional to the number of tasks. The lack of algorithms to support continual learning thus remains a key barrier to the development of artificial general intelligence.

In marked contrast to artificial neural networks, humans and other animals appear to be able to learn in a continual fashion ([^10]). Recent evidence suggests that the mammalian brain may avoid catastrophic forgetting by protecting previously acquired knowledge in neocortical circuits ([^10] – [^13]). When a mouse acquires a new skill, a proportion of excitatory synapses are strengthened; this manifests as an increase in the volume of individual dendritic spines of neurons ([^12]). Critically, these enlarged dendritic spines persist despite the subsequent learning of other tasks, accounting for retention of performance several months later ([^12]). When these spines are selectively “erased,” the corresponding skill is forgotten ([^10], [^11]). This provides causal evidence that neural mechanisms supporting the protection of these strengthened synapses are critical to retention of task performance. These experimental findings—together with neurobiological models such as the cascade model ([^14], [^15])—suggest that continual learning in the neocortex relies on task-specific synaptic consolidation, whereby knowledge is durably encoded by rendering a proportion of synapses less plastic and therefore stable over long timescales.

In this work, we demonstrate that task-specific synaptic consolidation offers a unique solution to the continual-learning problem for artificial intelligence. We develop an algorithm analogous to synaptic consolidation for artificial neural networks, which we refer to as elastic weight consolidation (EWC). This algorithm slows down learning on certain weights based on how important they are to previously seen tasks. We show how EWC can be used in supervised learning and reinforcement learning problems to train several tasks sequentially without forgetting older ones, in marked contrast to previous deep-learning techniques.

## Results

### EWC.

In brains, synaptic consolidation might enable continual learning by reducing the plasticity of synapses that are vital to previously learned tasks. We implement an algorithm that performs a similar operation in artificial neural networks by constraining important parameters to stay close to their old values. In this section, we explain why we expect to find a solution to a new task in the neighborhood of an older one, how we implement the constraint, and finally how we determine which parameters are important.

A deep neural network consists of multiple layers of linear projection followed by element-wise nonlinearities. Learning a task consists of adjusting the set of weights and biases $\theta$ of the linear projections, to optimize performance. Many configurations of $\theta$ will result in the same performance ([^16], [^17]); this overparameterization makes it likely that there is a solution for task *B*, $\theta_{B}^{*}$, that is close to the previously found solution for task *A*, $\theta_{A}^{*}$. While learning task *B*, EWC therefore protects the performance in task *A* by constraining the parameters to stay in a region of low error for task *A* centered around $\theta_{A}^{*}$, as shown schematically in [Fig. 1](#fig01). This constraint is implemented as a quadratic penalty and can therefore be imagined as a spring anchoring the parameters to the previous solution, hence having the name elastic. Importantly, the stiffness of this spring should not be the same for all parameters; rather, it should be greater for parameters that most affect performance in task *A*.

![Fig. 1.](https://cdn.ncbi.nlm.nih.gov/pmc/blobs/317d/5380101/1c4b4be4ce35/pnas.1611835114fig01.jpg)

EWC ensures task A is remembered while training on task B. Training trajectories are illustrated in a schematic parameter space, with parameter regions leading to good performance on task (gray) and on task (cream color). After learning the first task, the parameters are at θ ∗. If we take gradient steps according to task alone (blue arrow), we will minimize the loss of task but destroy what we have learned for task. On the other hand, if we constrain each weight with the same coefficient (green arrow), the restriction imposed is too severe and we can remember task only at the expense of not learning task. EWC, conversely, finds a solution for task without incurring a significant loss on task (red arrow) by explicitly computing how important weights are for task.

To justify this choice of constraint and to define which weights are most important for a task, it is useful to consider neural network training from a probabilistic perspective. From this point of view, optimizing the parameters is tantamount to finding their most probable values given some data $D$. We can compute this conditional probability $p \left(\theta \left|\right. D\right)$ from the prior probability of the parameters $p \left(\theta\right)$ and the probability of the data $p \left(D \left|\right. \theta\right)$ by using Bayes’ rule:

| $$ log p \left(\theta \left\|\right. D\right) = log p \left(D \left\|\right. \theta\right) + log p \left(\theta\right) - log p \left(D\right) . $$ | \[1\] |
| --- | --- |

Note that the log probability of the data given the parameters $log p \left(D \left|\right. \theta\right)$ is simply the negative of the loss function for the problem at hand $- L \left(\theta\right)$. Assume that the data are split into two independent parts, one defining task *A* ($D_{A}$) and the other defining task *B* ($D_{B}$). Then, we can rearrange [Eq. **1**](#eq1):

| $$ log p \left(\theta \left\|\right. D\right) = log p \left(D_{B} \left\|\right. \theta\right) + log p \left(\theta \left\|\right. D_{A}\right) - log p \left(D_{B}\right) . $$ | \[2\] |
| --- | --- |

Note that the left-hand side is still describing the posterior probability of the parameters given the entire dataset, whereas the right-hand side depends only on the loss function for task *B*, $log p \left(D_{B} \left|\right. \theta\right)$. All of the information about task *A* must therefore have been absorbed into the posterior distribution $p \left(\theta \left|\right. D_{A}\right)$. This posterior probability must contain information about which parameters were important to task $A$ and is therefore the key to implementing EWC. The true posterior probability is intractable, so, following the work on the Laplace approximation by Mackay ([^18]), we approximate the posterior as a Gaussian distribution with mean given by the parameters $\theta_{A}^{*}$ and a diagonal precision given by the diagonal of the Fisher information matrix $F$. $F$ has three key properties ([^19]): (*i*) It is equivalent to the second derivative of the loss near a minimum, (*ii*) it can be computed from first-order derivatives alone and is thus easy to calculate even for large models, and (*iii*) it is guaranteed to be positive semidefinite. Note that this approach is similar to expectation propagation where each subtask is seen as a factor of the posterior ([^20]). Given this approximation, the function $L$ that we minimize in EWC is

| $$ L \left(\theta\right) = L_{B} \left(\theta\right) + \underset{i}{\sum} \frac{\lambda}{2} F_{i} \left(\theta_{i} - \theta_{A , i}^{*}\right)^{2} , $$ | \[3\] |
| --- | --- |

where $L_{B} \left(\theta\right)$ is the loss for task *B* only, $\lambda$ sets how important the old task is compared with the new one, and $i$ labels each parameter.

When moving to a third task, task *C*, EWC will try to keep the network parameters close to the learned parameters of both tasks *A* and *B*. This can be enforced either with two separate penalties or as one by noting that the sum of two quadratic penalties is itself a quadratic penalty.

### EWC Extends Memory Lifetime for Random Patterns.

As an initial demonstration, we trained a linear network to associate random (i.e., uncorrelated) binary patterns to binary outcomes. Whereas this problem differs in important ways from more realistic settings that we examine later, this scenario admits analytical solutions and thus provides insights into key differences between EWC and plain gradient descent. In this case, the diagonal of the total Fisher information matrix is proportional to the number of patterns observed; thus in the case of EWC the learning rate lowers as more patterns are observed. Following ref. [^14], we define a memory as retained if its signal-to-noise ratio (SNR) exceeds a certain threshold. [Fig. 2](#fig02), *Top* shows the SNR obtained using gradient descent (blue lines) and EWC (red lines) for the first pattern observed. At first, the SNR in the two cases is very similar, following a power-law decay with a slope of $- 0.5$. As the number of patterns observed approaches the capacity of the network, the SNR for gradient descent starts decaying exponentially, whereas EWC maintains a power-law decay. The exponential decay observed with gradient descent is due to new patterns interfering with old ones; EWC protects from such interference and increases the fraction of memories retained (Fig. 2, *Bottom*). In the next sections we show that in more realistic cases, where input patterns have more complex statistics, interference occurs more easily with consequently more striking benefits for EWC over gradient descent.

![Fig. 2.](https://cdn.ncbi.nlm.nih.gov/pmc/blobs/317d/5380101/cfd9fe449ebc/pnas.1611835114fig02.jpg)

Log-log plot of the SNR for recalling the first pattern after observing t random patterns. If no penalty is applied (blue), the SNR decays as ( n / ) 0.5 only when is smaller than the number of synapses = 1, 000 and then decays exponentially. When EWC is applied (red), the decay takes a power-law form for all times. The dashed and solid lines show the analytic solutions derived in Eqs. S28 and S30. The fraction of memories retained ( Bottom ) is defined as the fraction of patterns whose SNR exceeds. EWC results in a higher fraction of memories being retained when the network is at capacity ( ≈ ). After network capacity is exceeded ( Right ), EWC performs worse than gradient descent ( Discussion ). More detailed plots can be found in the Supporting Information Figs. S1 S2.

### EWC Allows Continual Learning in a Supervised Learning Context.

We next addressed the problem of whether EWC could allow deep neural networks to learn a set of more complex tasks without catastrophic forgetting. In particular, we trained a fully connected multilayer neural network on several supervised learning tasks in sequence. Within each task, we trained the neural network in the traditional way, namely by shuffling the data and processing them in small batches. After a fixed amount of training on each task, however, we allowed no further training on that task’s dataset.

We constructed the set of tasks from the problem of classifying hand-written digits from the Mixed National Institute of Science and Technology (MNIST) ([^21]) dataset, according to a scheme previously used in the continual-learning literature ([^22], [^23]). For each task, we generated a fixed, random permutation by which the input pixels of all images would be shuffled. Each task was thus of equal difficulty to each other, but would require a different solution.

Training on this sequence of tasks with plain stochastic gradient descent (SGD) incurs catastrophic forgetting, as demonstrated in [Fig. 3 *A*](#fig03). The blue curves show performance on the testing sets of two different tasks. At the point at which the training regime switches from training on the first task (*A*) to training on the second one (*B*), the performance for task *B* falls rapidly, whereas for task *A* it climbs steeply. The forgetting of task *A* compounds further with more training time and the addition of subsequent tasks. This problem cannot be countered by regularizing the network with a fixed quadratic constraint for each weight (green curves, L2 regularization): here, the performance in task *A* degrades much less severely, but task *B* cannot be learned properly as the constraint protects all weights equally, leaving little spare capacity for learning on *B*. However, when we use EWC, and thus take into account how important each weight is to task *A*, the network can learn task *B* well without forgetting task *A* (red curves). This is exactly the behavior described diagrammatically in [Fig. 1](#fig01).

![Fig. 3.](https://cdn.ncbi.nlm.nih.gov/pmc/blobs/317d/5380101/be4f0a34f2a3/pnas.1611835114fig03.jpg)

Results on the permuted MNIST task. ( A ) Training curves for three random permutations A, B, and C, using EWC (red), L 2 regularization (green), and plain SGD (blue). Note that only EWC is capable of maintaining a high performance on old tasks, while retaining the ability to learn new tasks. ( B ) Average performance across all tasks, using EWC (red) or SGD with dropout regularization (blue). The dashed line shows the performance on a single task only. ( C ) Similarity between the Fisher information matrices as a function of network depth for two different amounts of permutation. Either a small square of 8 × 8 pixels in the middle of the image is permuted (gray) or a large square of 26 × 26 pixels is permuted (black). Note how the more different the tasks are, the smaller the overlap in Fisher information matrices in early layers.

Previous attempts to solve the continual-learning problem for deep neural networks have relied upon careful choice of network hyperparameters, together with other standard regularization methods, to mitigate catastrophic forgetting. However, on this task, they have achieved reasonable results only on up to two random permutations ([^22], [^23]). Using a similar cross-validated hyperparameter search to that in ref. [^23], we compared traditional dropout regularization to EWC. We find that stochastic gradient descent with dropout regularization alone is limited and that it does not scale to more tasks ([Fig. 3 *B*](#fig03)). In contrast, EWC allows a large number of tasks to be learned in sequence, with only modest growth in the error rates.

Given that EWC allows the network to effectively squeeze in more functionality into a network with fixed capacity, we might ask whether it allocates completely separate parts of the network for each task or whether capacity is used in a more efficient fashion by sharing representation. To assess this, we determined whether each task depends on the same sets of weights, by measuring the overlap between pairs of tasks’ respective Fisher information matrices ([*Fisher Overlap*](#si4)). A small overlap means that the two tasks depend on different sets of weights (i.e., EWC subdivides the network’s weights for different tasks); a large overlap indicates that weights are being used for both of the two tasks (i.e., EWC enables sharing of representations). [Fig. 3 *C*](#fig03) shows the overlap as a function of depth. As a simple control, when a network is trained on two tasks that are very similar to each other (two versions of MNIST where only a few pixels are permutated), the tasks depend on similar sets of weights throughout the whole network (gray dashed curve). When then the two tasks are more dissimilar from each other, the network begins to allocate separate weights for the two tasks (black dashed line). Nevertheless, even for the large permutations, the layers of the network closer to the output are indeed being reused for both tasks. This reflects the fact that the permutations make the input domain very different, but the output domain (i.e., the class labels) is shared.

### EWC Allows Continual Learning in a Reinforcement Learning Context.

We next tested whether EWC could support continual learning in the far more demanding reinforcement learning (RL) domain. In RL, agents dynamically interact with the environment to develop a policy that maximizes cumulative future reward. We asked whether Deep Q Networks (DQNs)—an architecture that has achieved impressive successes in such challenging RL settings ([^24])—could be harnessed with EWC to successfully support continual learning in the classic Atari 2600 task set ([^25]). Specifically, each experiment consisted of 10 games chosen randomly from those that are played at human level or above by DQN. At training time, the agent was exposed to experiences from each game for extended periods of time. The order of presentation of the games was randomized and allowed for returning to the same games several times. At regular intervals we would also test the agent’s score on each of the 10 games, without allowing the agent to train on them ([Fig. 4 *A*](#fig04)).

![Fig. 4.](https://cdn.ncbi.nlm.nih.gov/pmc/blobs/317d/5380101/6a43bbdbc33e/pnas.1611835114fig04.jpg)

Results on Atari task. ( A ) Schedule of games. Black bars indicate the sequential training periods (segments) for each game. After each training segment, performance on all games is measured. The EWC constraint is activated only to protect an agent’s performance on each game once the agent has experienced 20 million frames in that game. ( B ) Total human-averaged scores for each method across all games. The score is averaged across random seeds and over the choice of which 10 games are played ( Fig. S3 ). The human-normalized score for each game is clipped to 1. Red curve denotes the network that infers the task labels using the FMN algorithm; brown curve is the network provided with the task labels. The EWC and SGD curves start diverging when games start being played again that have been protected by EWC. ( C ) Sensitivity of a single-game DQN, trained on Breakout, to noise added to its weights. The performance on Breakout is shown as a function of the magnitude (standard deviation) of the weight perturbation. The weight perturbation is drawn from a zero mean Gaussian with covariance that is either uniform (black; i.e., targets all weights equally), the inverse Fisher ( ( F + λ I ) − 1; blue; i.e., mimicking weight changes allowed by EWC), or uniform within the nullspace of the Fisher (orange; i.e., targets weights that the Fisher estimates that the network output is entirely invariant to). To evaluate the score, we ran the agent for 10 full game episodes, drawing a new random weight perturbation for every time step.

Notably, previous reinforcement learning approaches to continual learning have relied either on adding capacity to the network ([^26], [^27]) or on learning each task in separate networks, which are then used to train a single network that can play all games ([^8], [^9]). In contrast, the EWC approach presented here makes use of a single network with fixed resources (i.e., network capacity) and has minimal computational overhead.

In addition to using EWC to protect previously acquired knowledge, we used the RL domain to address a broader set of requirements that are needed for successful continual-learning systems: In particular, higher-level mechanisms are needed to infer which task is currently being performed, detect and incorporate novel tasks as they are encountered, and allow for rapid and flexible switching between tasks ([^28]). In the primate brain, the prefrontal cortex is widely viewed as supporting these capabilities by sustaining neural representations of task context that exert top–down gating influences on sensory processing, working memory, and action selection ([^29] – [^30]).

Inspired by this evidence, we augmented the DQN agents with extra functionality to handle switching task contexts. Knowledge of which task is being performed is required for the EWC algorithm as it informs which quadratic constraints are currently active and also which quadratic constraint to update when the task context changes. To infer the task context, we implemented an online clustering algorithm that is trained without supervision and is based on the forget-me-not (FMN) process ([^31]) (see [*Materials and Methods*](#s7) for more details). We also allowed the DQN agents to maintain separate short-term memory buffers for each inferred task. These allow action values for each task to be learned off-policy, using an experience replay mechanism ([^24]). As such, the overall system has memory on two timescales: Over short timescales, the experience replay mechanism allows learning in the DQN to be based on the interleaved and uncorrelated experiences ([^24]). At longer timescales, know-how across tasks is consolidated by using EWC. Finally, we allowed a small number of network parameters to be game specific. In particular, we allowed each layer of the network to have biases and per-element multiplicative gains that were specific to each game.

We compare the performance of agents that use EWC (red) with ones that do not (blue) over sets of 10 games in [Fig. 4](#fig04). We measure the performance as the total human-normalized score across all 10 games; the score on each game is clipped to 1 such that the total maximum score is 10 (at least at human level on all games) and 0 means the agent is as good as a random agent. If we rely on plain gradient descent methods as in ref. [^24], the agent never learns to play more than one game and the harm inflicted by forgetting the old games means that the total human-normalized score remains below one. By using EWC, however, the agents do indeed learn to play multiple games. As a control, we also considered the benefit to the agent if we explicitly provided the agent with the true task label ([Fig. 4 *B*](#fig04), brown), rather than relying on the learned task recognition through the FMN algorithm (Fig. 4 *B*, red). The improvement here was only modest.

Whereas augmenting the DQN agent with EWC allows it to learn many games in sequence without suffering from catastrophic forgetting, it does not reach the score that would have been obtained by training 10 separate DQNs ([Fig. S3](#sfig03)). One possible reason for this is that we consolidated weights for each game based on a tractable approximation of parameter uncertainty, the Fisher information. We therefore sought to test the quality of our estimates empirically. To do so, we trained an agent on a single game and measured how perturbing the network parameters affected the agent’s score. Regardless of which game the agent was trained on, we observed the same patterns, shown in [Fig. 4 *C*](#fig04). First, the agent was always more robust to parameter perturbations shaped by the inverse of the diagonal of the Fisher information (blue), as opposed to uniform perturbations (black). This validates that the diagonal of the Fisher information is a good estimate of how important a parameter is. Within our approximation, perturbing in the null space should have no effect on performance. Empirically, however, we observe that perturbing in this space (orange) has the same effect as perturbing in the inverse Fisher space. This suggests that we are overconfident about certain parameters being unimportant: It is therefore likely that the chief limitation of the current implementation is that it underestimates parameter uncertainty.

![Fig. S3.](https://cdn.ncbi.nlm.nih.gov/pmc/blobs/317d/5380101/6a240c4cba05/pnas.1611835114sfig03.jpg)

Score in the individual games as a function of steps played in that game. The black baseline curves show learning on individual games alone.

## Fisher Overlap

To assess whether different tasks solved in the same network use similar sets of weights ([Fig. 3 *C*](#fig03) in the main text), we measured the degree of overlap between the two tasks’ Fisher matrices. Precisely, we computed the two tasks’ Fishers, $F_{1}$ and $F_{2}$; normalized these to each have unit trace, $\hat{F}_{1}$ and $\hat{F}_{2}$; and then computed their Fréchet distance, a metric on the space of positive-semidefinite matrices (44),

$$
d^{2} \left(\hat{F}_{1} , \hat{F}_{2}\right) = \frac{1}{2} tr \left(\hat{F}_{1} + \hat{F}_{2} - 2 \left(\hat{F}_{1} \hat{F}_{2}\right)^{1 / 2}\right) = \frac{1}{2} \left\|\hat{F}_{1}^{1 / 2} - \hat{F}_{2}^{1 / 2}\right\|_{F} ,
$$

which is bounded between zero and one. We then define the overlap as $1 - d^{2}$, with a value of zero indicating that the two tasks depend on nonoverlapping sets of weights and a value of one indicating that $F_{1} = \alpha F_{2}$ for some $\alpha > 0$.

## Discussion

We present an algorithm, EWC, that allows knowledge of previous tasks to be protected during new learning, thereby avoiding catastrophic forgetting. It does so by selectively decreasing the plasticity of weights and thus has certain parallels with neurobiological models of synaptic consolidation ([^14], [^15]). We implement EWC as a soft, quadratic constraint whereby each weight is pulled back toward its old values by an amount proportional to its importance for performance on previously learned tasks. In analytically tractable settings, we demonstrate that EWC can protect network weights from interference and thus increase the fraction of memories retained over plain gradient descent. To the extent that tasks share structure, networks trained with EWC reuse shared components of the network. We further show that EWC can be effectively combined with deep neural networks to support continual learning in challenging reinforcement learning scenarios, such as Atari 2600 games.

The EWC algorithm can be grounded in Bayesian approaches to learning. Formally, when there is a new task to be learned, the network parameters are tempered by a prior which is the posterior distribution on the parameters given data from the previous task(s). This enables fast learning rates on parameters that are poorly constrained by the previous tasks and slow learning rates for those that are crucial.

There has been previous work ([^32], [^33]) using a quadratic penalty to approximate old parts of the dataset, but these applications have been limited to small models. Specifically, ref. [^32] used random inputs to compute a quadratic approximation to the energy surface. Their approach is slow, as it requires recomputing the curvature at each sample. The ELLA algorithm described in ref. [^33] requires computing and inverting matrices with a dimensionality equal to the number of parameters being optimized; therefore it has been mainly applied to linear and logistic regressions. In contrast, EWC has a run time that is linear in both the number of parameters and the number of training examples. We could achieve this low computational complexity only by using a crude Laplace approximation to the true the posterior distribution of the parameters. Despite its low computational cost and empirical successes—even in the setting of challenging RL domains—our use of a point estimate of the posterior’s variance (as in a Laplace approximation) does constitute a significant weakness ([Fig. 4 *C*](#fig04)). Our initial explorations suggest that one might improve on this local estimate by using Bayesian neural networks ([^34]).

Whereas this paper has primarily focused on building an algorithm inspired by neurobiological observations and theories ([^14], [^15]), it is also instructive to consider whether the algorithm’s successes can feed back into our understanding of the brain. In particular, we see considerable parallels between EWC and two computational theories of synaptic plasticity.

Cascade models of synaptic plasticity ([^14], [^15]) construct dynamical models of synaptic states to understand the trade-off between plasticity and memory retention. Cascade models have important differences from our approach. In particular, they aim to extend memory lifetimes for systems at steady state (i.e., the limit of observing an infinite number of stimuli). As such, they allow for synapses to become more or less plastic and model the process of both retaining and forgetting memories. In contrast, we tackle the simpler problem of protecting the network from interference when starting from an empty network. In fact in EWC weights can only become more constrained (i.e., less plastic) with time and thus we can model only memory retention rather than forgetting. Therefore when the number of random patterns observed exceeds the capacity of the network and steady state is reached, EWC starts to perform even worse than plain gradient descent (Fig. 2, *Bottom*). Further, the EWC model—like standard Hopfield networks ([^35])—is prone to the phenomenon of blackout catastrophe when network capacity is saturated, resulting in the inability to retrieve any previous memories or store new experiences. Notably, we did not observe these limitations under the more realistic conditions for which EWC was designed—likely because the network was operating well under capacity in these regimes.

Despite these key differences, EWC and cascade share the basic algorithmic feature that memory lifetimes are extended by modulating the plasticity of synapses. Whereas prior work on cascade models ([^14], [^15]) has tied the metaplastic state to patterns of potentiation and depression events—i.e., synaptic-level measures—our approach focuses on the computational principles that determine the degree to which each synapses might be consolidated. It may be possible to distinguish these models experimentally, because the plasticity of a synapse depends on the rate of potentiation events in the cascade model, but on task relevance in EWC.

In this respect, the perspective we offer here aligns with a recent proposal that each synapse stores not only its current weight, but also an implicit representation of its uncertainty about that weight ([^36]). This idea is grounded in observations that postsynaptic potentials are highly variable in amplitude (suggestive of sampling from the weight posterior during computation) and those synapses that are more variable are more amenable to potentiation or depression (suggestive of updating the weight posterior). Although we do not explore the computational benefits of sampling from a posterior here, our work aligns with the notion that weight uncertainty should inform learning rates. We take this one step farther, to emphasize that consolidating the high precision weights enables continual learning over long timescales. With EWC, three values have to be stored for each synapse: the weight itself, its variance, and its mean. Interestingly, synapses in the brain also carry more than one piece of information. For example, the state of the short-term plasticity could carry information on the variance ([^36], [^37]). The weight for the early phase of plasticity ([^38]) could encode the current synaptic strength, whereas the weight associated with the late phase of plasticity or the consolidated phase could encode the mean weight.

The ability to learn tasks in succession without forgetting is a core component of biological and artificial intelligence. In this work we show that an algorithm that supports continual learning—which takes inspiration from neurobiological models of synaptic consolidation—can be combined with deep neural networks to achieve successful performance in a range of challenging domains. In doing so, we demonstrate that current neurobiological theories concerning synaptic consolidation do indeed scale to large-scale learning systems. This provides prima facie evidence that these principles may be fundamental aspects of learning and memory in the brain.

## Materials and Methods

Full methods for all simulations can be found in [*Random Patterns*](#si1), [*MNIST Experiments*](#si2), and [*Atari Experiments*](#si3). Hyperparameters for the MNIST experiment are described in [Table S1](#st01). For the Atari 2600 experiments, we used an agent very similar to that described in ref. [^39]. The only differences are that we used (*i*) a network with more parameters, (*ii*) a smaller transition table, (*iii*) task-specific bias and gains at each layer, (*iv*) the full action set in Atari, (*v*) a task-recognition model, and (*vi*) the EWC penalty. Full details of hyperparameters are described in [Table S2](#st02). Here we briefly describe the two most important modifications to the agent: the task-recognition module and the implementation of the EWC penalty.

### Table S1.

Hyperparameters for each of the MNIST figures

<table><thead><tr><td rowspan="1" colspan="1">Hyperparameter</td><td align="center" rowspan="1" colspan="1">Fig. 3 <em>A</em></td><td align="center" rowspan="1" colspan="1">Fig. 3 <em>B</em></td><td align="center" rowspan="1" colspan="1">Fig. 3 <em>C</em></td></tr></thead><tbody><tr><td rowspan="1" colspan="1">Learning rate</td><td align="center" rowspan="1" colspan="1"><math><msup><mn>10</mn> <mrow><mo>−</mo> <mn>3</mn></mrow></msup></math></td><td align="center" rowspan="1" colspan="1"><math><msup><mn>10</mn> <mrow><mo>−</mo> <mn>5</mn></mrow></msup></math> – <math><msup><mn>10</mn> <mrow><mo>−</mo> <mn>3</mn></mrow></msup></math></td><td align="center" rowspan="1" colspan="1"><math><msup><mn>10</mn> <mrow><mo>−</mo> <mn>3</mn></mrow></msup></math></td></tr><tr><td rowspan="1" colspan="1">Dropout</td><td align="center" rowspan="1" colspan="1">No</td><td align="center" rowspan="1" colspan="1">Yes</td><td align="center" rowspan="1" colspan="1">No</td></tr><tr><td rowspan="1" colspan="1">Early stopping</td><td align="center" rowspan="1" colspan="1">No</td><td align="center" rowspan="1" colspan="1">Yes</td><td align="center" rowspan="1" colspan="1">No</td></tr><tr><td rowspan="1" colspan="1">No. hidden layers</td><td align="center" rowspan="1" colspan="1">2</td><td align="center" rowspan="1" colspan="1">2</td><td align="center" rowspan="1" colspan="1">6</td></tr><tr><td rowspan="1" colspan="1">Width hidden layers</td><td align="center" rowspan="1" colspan="1">400</td><td align="center" rowspan="1" colspan="1">400–2,000</td><td align="center" rowspan="1" colspan="1">100</td></tr><tr><td rowspan="1" colspan="1">Epochs/dataset</td><td align="center" rowspan="1" colspan="1">20</td><td align="center" rowspan="1" colspan="1">100</td><td align="center" rowspan="1" colspan="1">100</td></tr></tbody></table>

[Open in a new tab](https://pmc.ncbi.nlm.nih.gov/articles/PMC5380101/table/st01/)

### Table S2.

Hyperparameters for the Atari experiment

<table><thead><tr><td rowspan="1" colspan="1">Hyperparameter</td><td align="center" rowspan="1" colspan="1">Value</td><td align="center" rowspan="1" colspan="1">Brief description</td></tr></thead><tbody><tr><td rowspan="1" colspan="1">Action repeat</td><td align="center" rowspan="1" colspan="1">4</td><td rowspan="1" colspan="1">Repeat the same action for four frames. Each agent step will occur every fourth frame.</td></tr><tr><td rowspan="1" colspan="1">Discount factor</td><td align="center" rowspan="1" colspan="1">0.99</td><td rowspan="1" colspan="1">Discount factor used in the Q-learning algorithm.</td></tr><tr><td rowspan="1" colspan="1">No-op max</td><td align="center" rowspan="1" colspan="1">30</td><td rowspan="1" colspan="1">Maximum number of do nothing operations carried out at the beginning of each training episode to</td></tr><tr><td rowspan="1" colspan="1"></td><td rowspan="1" colspan="1"></td><td rowspan="1" colspan="1">provide a varied training set.</td></tr><tr><td rowspan="1" colspan="1">Max. reward</td><td align="center" rowspan="1" colspan="1">1</td><td rowspan="1" colspan="1">Rewards are clipped to 1.</td></tr><tr><td rowspan="1" colspan="1">Scaled input</td><td align="center" rowspan="1" colspan="1">84 × 84</td><td rowspan="1" colspan="1">Input images are scaled to 84 × 84 with bilinear interpolation.</td></tr><tr><td rowspan="1" colspan="1">Optimization algorithm</td><td align="center" rowspan="1" colspan="1">RMSprop</td><td rowspan="1" colspan="1">Optimization algorithm used.</td></tr><tr><td rowspan="1" colspan="1">Learning rate</td><td align="center" rowspan="1" colspan="1">0.00025</td><td rowspan="1" colspan="1">The learning rate in RMSprop.</td></tr><tr><td rowspan="1" colspan="1">Max. learning rate</td><td align="center" rowspan="1" colspan="1">0.0025</td><td rowspan="1" colspan="1">The maximum learning rate that RMSprop will apply.</td></tr><tr><td rowspan="1" colspan="1">Momentum</td><td align="center" rowspan="1" colspan="1">0.0</td><td rowspan="1" colspan="1">The momentum used in RMSprop.</td></tr><tr><td rowspan="1" colspan="1">Decay</td><td align="center" rowspan="1" colspan="1">0.95</td><td rowspan="1" colspan="1">The decay used in RMSProp.</td></tr><tr><td rowspan="1" colspan="1">Clip</td><td align="center" rowspan="1" colspan="1">1.0</td><td rowspan="1" colspan="1">Each gradient from Q-learning is clipped to 1.</td></tr><tr><td rowspan="1" colspan="1">Max. norm</td><td align="center" rowspan="1" colspan="1">50.</td><td rowspan="1" colspan="1">After clipping, if the norm of the gradient is greater than 50., the gradient is renormalized to 50.</td></tr><tr><td rowspan="1" colspan="1">History length</td><td align="center" rowspan="1" colspan="1">4</td><td rowspan="1" colspan="1">The four most recently experienced frames are taken to form a state for Q-learning.</td></tr><tr><td rowspan="1" colspan="1">Minibatch size</td><td align="center" rowspan="1" colspan="1">32</td><td rowspan="1" colspan="1">The number of elements taken from the replay buffer to form a minibatch training example.</td></tr><tr><td rowspan="1" colspan="1">Replay period</td><td align="center" rowspan="1" colspan="1">4</td><td rowspan="1" colspan="1">A minibatch is loaded from the replay buffer every four steps (16 frames including action repeat).</td></tr><tr><td rowspan="1" colspan="1">Memory size</td><td align="center" rowspan="1" colspan="1">50,000</td><td rowspan="1" colspan="1">The replay memory stores the last 50,000 transitions experienced.</td></tr><tr><td rowspan="1" colspan="1">Target update period</td><td align="center" rowspan="1" colspan="1">7,500</td><td rowspan="1" colspan="1">The target network in Q-learning is updated to the policy network every 7,500 steps.</td></tr><tr><td rowspan="1" colspan="1">Min. history</td><td align="center" rowspan="1" colspan="1">50,000</td><td rowspan="1" colspan="1">The agent will start learning only after 50,000 transitions have been stored into memory.</td></tr><tr><td rowspan="1" colspan="1">Initial exploration</td><td align="center" rowspan="1" colspan="1">1.0</td><td rowspan="1" colspan="1">The value of the initial exploration rate.</td></tr><tr><td rowspan="1" colspan="1">Exploration decay start</td><td align="center" rowspan="1" colspan="1">50,000</td><td rowspan="1" colspan="1">The exploration rate will start decaying after 50,000 frames.</td></tr><tr><td rowspan="1" colspan="1">Exploration decay end</td><td align="center" rowspan="1" colspan="1">1,050,000</td><td rowspan="1" colspan="1">The exploration rate will decay over 1 million frames.</td></tr><tr><td rowspan="1" colspan="1">Final exploration</td><td align="center" rowspan="1" colspan="1">0.01</td><td rowspan="1" colspan="1">The value of the final exploration rate.</td></tr><tr><td rowspan="1" colspan="1">Model update period</td><td align="center" rowspan="1" colspan="1">4</td><td rowspan="1" colspan="1">The Dirichlet model is updated every fourth step.</td></tr><tr><td rowspan="1" colspan="1">Model downscaling</td><td align="center" rowspan="1" colspan="1">2</td><td rowspan="1" colspan="1">The Dirichlet model is downscaled by a factor of 2; that is, an image of size 42 × 42 is being modeled.</td></tr><tr><td rowspan="1" colspan="1">Size window</td><td align="center" rowspan="1" colspan="1">4</td><td rowspan="1" colspan="1">The size of the window for the task recognition model learning.</td></tr><tr><td rowspan="1" colspan="1">Num. samples Fisher</td><td align="center" rowspan="1" colspan="1">100</td><td rowspan="1" colspan="1">Whenever the diagonal of the Fisher is recomputed for a task, 100 minibatches are drawn from the</td></tr><tr><td rowspan="1" colspan="1"></td><td rowspan="1" colspan="1"></td><td rowspan="1" colspan="1">replay buffer.</td></tr><tr><td rowspan="1" colspan="1">Fisher multiplier</td><td align="center" rowspan="1" colspan="1">400</td><td rowspan="1" colspan="1">The Fisher is scaled by this number to form the EWC penalty.</td></tr><tr><td rowspan="1" colspan="1">Start EWC</td><td align="center" rowspan="1" colspan="1">20E6</td><td rowspan="1" colspan="1">The EWC penalty is applied only after 5 million steps (20 million frames).</td></tr></tbody></table>

[Open in a new tab](https://pmc.ncbi.nlm.nih.gov/articles/PMC5380101/table/st02/)

We treat the task context as the latent variable of a hidden Markov model. Each task is therefore associated to an underlying generative model of the observations. The main distinguishing feature of our approach is that we allow for the addition of new generative models if they explain recent data better than the existing pool of models by using a training procedure inspired by the FMN process in ref. [^30] (see [*Atari Experiments*](#si3) for full description). To apply EWC, we compute the Fisher information matrix at each task switch. For each task, a penalty is added with the anchor point given by the current value of the parameters and with weights given by the Fisher information matrix times a scaling factor that was optimized by hyperparameter search. We added an EWC penalty only to games that had experienced at least million frames.

## Random Patterns

In this section we show that using EWC it is possible to recover a power-law decay for the SNR of random patterns. The task consists of associating random -dimensional binary vectors to a random binary output by learning a weight vector . The continual-learning aspect of the problem arises from the fact that at time step , only the pattern is accessible to the learning algorithm. Before providing a detailed derivation of the learning behavior, we provide a sketch of the main ideas. Learning consists of minimizing an objective function at each time step. This objective function contains the square loss for the current pattern plus a penalty that minimizes the distance of the weight vector to its old value. This corresponds to EWC if the distance metric used is the diagonal of the total Fisher information matrix. Conversely, if a fixed metric is used, we recover gradient descent. In this particular case, the diagonal of the Fisher information matrix is proportional the number of patterns observed, so EWC simply consists of lowering the learning rate at each time step. We then obtain an exact solution for the average response (signal) of a pattern observed at time at a later time in both the gradient descent (constant learning rate) and the EWC cases. We find that EWC leads to a power-law decay in the signal whereas gradient descent leads to an exponential one. Our analysis of the variance in the response (noise) shows that in both the EWC and gradient descent cases, for small time, the noise increases as . Conversely, for large the noise tends to 1 in the gradient descent case, and it decays as in the EWC case.

We assume that , such that each element is . We regress to the targets with the dot product and optimize the parameters , using least-squares minimization. Therefore, the loss at step can be written as

|  | \[S1\] |
| --- | --- |

The first term on the right-hand side is simply a squared error, and the second term makes the problem well defined by constraining the parameters to be close to the old ones under a metric . We consider two possible choices for the metric: In the steepest descent case, we use a fixed, uniform metric, and in the EWC case we use the diagonal of the Fisher information matrix. Note that in this problem, the diagonal of the Fisher information matrix at time step is simply an identity matrix multiplied by . To cover both cases, we refer to the norm of the metric at time step as . This quantity is fixed in the case of steepest descent and is increasing with time as for the EWC case. Let us take the derivative of [Eq. **S1**](#eqs1) with respect to and set it to 0. We then find that

|  | \[S2\] |
| --- | --- |

Let us solve [Eq. **S2**](#eqs2) for to find

|  | \[S3\] |
| --- | --- |

We simplify the previous equation by using the Sherman–Morrison formula for matrix inverses and by defining :

|  | \[S4\] |
| --- | --- |

Note that this is exactly the same equation that one would obtain if performing gradient descent with a learning rate .

If we assume that the initial conditions are a null vector and define the matrix and the vector , then unfolding the recurrence relation from [**\[S4\]**](#eqs4) leads to

|  | \[S5\] |
| --- | --- |

To measure the average memory strength of a memory from time at a later time , we need to compute the signal that is the mean response to a stimulus from time step ,

|  | \[S6\] |
| --- | --- |

where the angle brackets denote averaging over all of the patterns seen, except .

To be retrieved, it is important for this average signal to exceed the noise by a certain margin. The noise is simply defined as the standard deviation of the quantity above; that is,

|  | \[S7\] |
| --- | --- |

In what follows, we first derive the expression for the signal and then that for the noise term in both the steepest-descent and EWC cases.

Because each term in each term of the sum of [Eq. **S5**](#eqs5) pertains to one time step only, averaging [Eq. **S6**](#eqs6) factors out, and it is sufficient to be able to compute the following average,

|  | \[S8\] |
| --- | --- |

where is the identity matrix. Of each term in the sum of [Eq. **S5**](#eqs5), all of the terms starting with an with will average to 0, and the only term remaining will therefore be

|  | \[S9\] |
| --- | --- |

which, using [Eq. **S8**](#eqs8), will result in

|  | \[S10\] |
| --- | --- |

We consider two cases: In the steepest-descent case and in the EWC case . Note that we chose the magnitude for the regularization for the steepest-descent case in such a way that they both agree for the first time step. In the steepest-descent case, after some manipulation we reach

|  | \[S11\] |
| --- | --- |

If we are interested in cases when , the previous expression can be rearranged into

|  | \[S12\] |
| --- | --- |

In the EWC case we have

|  | \[S13\] |
| --- | --- |

To compute the noise term, we assume that the weight vector is uncorrelated from the observed vector , and we can simplify [Eq. **S7**](#eqs7):

|  | \[S14\] |
| --- | --- |

Note that this assumption is tantamount to averaging the quantity over all , including .

Therefore, the key to computing the noise term is to be able to predict the average norm of the weight vector. To deduce what form this must take, let us rearrange [Eq. **S3**](#eqs3) slightly to yield

|  | \[S15\] |
| --- | --- |

Define the vector as

|  | \[S16\] |
| --- | --- |

Then the expected change in the norm of the weight vector can we written as

|  | \[S17\] |
| --- | --- |

These two terms are readily computed as

|  | \[S18\] |
| --- | --- |

|  | \[S19\] |
| --- | --- |

Therefore, the expected change in the norm can be written as

|  | \[S20\] |
| --- | --- |

To proceed, we take a continuous approximation of this difference equation to yield a linear, first-order, inhomogeneous ordinary differential equation for the norm of the weight vector,

|  | \[S21\] |
| --- | --- |

with boundary condition

|  | \[S22\] |
| --- | --- |

In the case of steepest descent, the function is simply a constant and the above equation simplifies to

|  | \[S23\] |
| --- | --- |

Let us assume that to simplify that expression to

|  | \[S24\] |
| --- | --- |

with solution

|  | \[S25\] |
| --- | --- |

If, instead, we are in the EWC case, the function is and [Eq. **S21**](#eqs21) becomes

|  | \[S26\] |
| --- | --- |

It is possible to obtain an analytic solution to this ordinary differential equation,

|  | \[S27\] |
| --- | --- |

where Ei is the exponential integral function.

For the gradient descent case the analytical form of the SNR is simple. Using [Eqs. **S12**](#eqs12) and [**S25**](#eqs25) we find

|  | \[S28\] |
| --- | --- |

This expression is a power law when and an exponential when is the same order of magnitude as or greater.

The expression for the noise in [Eq. **S27**](#eqs27), however, is harder to interpret. If , it is equivalent to the solution for the steepest descent, that is, [Eq. **S25**](#eqs25). If conversely , noting that for large *x*, we can get a simplified form for the norm of the weight as a function of time:

|  | \[S29\] |
| --- | --- |

Thus, we can obtain the expression for the behavior of the SNR in the EWC case in the small time and large time regimes. When , the signal expressed in **\[S13\]** is ∼ and the noise term from **\[27\]** can be approximated as . So the SNR can be written as

|  | \[S30\] |
| --- | --- |

If, however, the time is of the same magnitude as different outcomes are observed for steepest descent and for EWC, as the time step approaches in the EWC case, the signal from [Eq. **S13**](#eqs13) will fall as and the noise from [Eq. **S29**](#eqs29) will also as ; therefore the overall SNR will take the form

|  | \[S31\] |
| --- | --- |

The main distinction that we expect between using steepest descent and EWC is therefore that EWC should show a power law in the SNR with an exponent of −0.5 for both the small time and large time regimes. Gradient descent, conversely, will show a power law only for times shorter than the capacity of the network, and subsequently the memories are forgotten exponentially.

Our analytic computation of the noise term is approximate, because of the approximation that weights and input can be considered to be uncorrelated and also because we make a continuous approximation. To validate these assumptions, and to check our computations, we compare the analytic expression with numerical simulations. The numerical simulations were obtained by making several (400) simulations of the weights and patterns observed with a value of . We then simply computed the signal as the mean response at time from a pattern observed at time and the noise as the SD. In [Fig. S1](#sfig01) we show the value of the signal and noise obtained numerically and for the analytic expressions in [Eqs. **S11**](#eqs11), [**S13**](#eqs13), [**S25**](#eqs25), [**S27**](#eqs27), and [**S29**](#eqs29). Note that agreement between the observed signal and the numerical one is always very good. For the noise term agreement is good except when is small and our assumptions that weights and the patterns are uncorrelated does not hold. When our assumption on the noise breaks down, we observe that the magnitude of the noise is smaller than we predict and the SNR is higher than expected by our analysis.

![Fig. S1.](https://cdn.ncbi.nlm.nih.gov/pmc/blobs/317d/5380101/e3b059037290/pnas.1611835114sfig01.jpg)

Signal ( Bottom row ) and noise ( Top row ) terms for the EWC ( Left column ) and gradient descent ( Right column ) cases as a function of time. The blue curves are the results of numeric simulations, whereas the red curves show the analytic results. Each panel contains stimuli observed at different times. ( Top Left ) (noise in the EWC case) The solid red curve is the full form of Eq. S27, the dashed line is S25 (which is valid for small times), and the dashed-dotted line is the long time approximation of the noise in S29. The different solid blue curves correspond to the noise from patterns observed at times 1, 50, 100, and 500. ( Top Right ) (noise in the gradient descent case) The red curve shows Bottom Left ) (signal in the EWC case) The red curve is S13 Bottom Right ) (signal for the gradient descent case) The red curves are S11.

It should be noted that in this analysis we have chosen a particular value for the regularization term . This is equivalent to the value used for the first pattern observed in EWC. Because this regularization term effectively sets the learning rate, this means we have picked a learning rate for gradient descent equivalent to that used at the start of learning in EWC. To make a fair comparison we should also test gradient descent using the smaller learning rates used at later stages by EWC. First, we generalize the expressions for the signal and noise terms in the gradient descent case with arbitrary learning rate . Remembering that , the generalization of [Eqs. **S12**](#eqs12) and [**S25**](#eqs25) becomes

|  | \[S32\] |
| --- | --- |

|  | \[S33\] |
| --- | --- |

In [Fig. S2](#sfig02) we show a comparison of the SNR in the EWC case (red curves) and in the plain gradient descent case with different learning rates (green lines, ; blue lines, ). These learning rates are chosen to match the learning rate in EWC at the beginning of training () and at capacity, that is, when , at which point . The SNR plot (Fig. S2, *Top*) shows that irrespective of the learning rate used, the SNR in the gradient descent case eventually follows an exponential decay, albeit with a different rate. EWC, conversely, maintains a power-law decay. Fig. S2, *Middle* shows that the fraction of memories retained is higher using EWC than with either the learning rates, although a higher percentage is retained with the lower learning rate.

![Fig. S2.](https://cdn.ncbi.nlm.nih.gov/pmc/blobs/317d/5380101/c47e66c30771/pnas.1611835114sfig02.jpg)

Comparison of EWC (red lines) with gradient descent with different learning rates (green,; blue, ). Bottom shows these two learning rates correspond to the learning rate used in EWC at the first pattern and at network capacity ( ) Top shows log-log plot of the SNR for the first pattern observed. The black lines show the analytic expressions from Eqs. S13, S27, and S32. Note that EWC has a power-law decay for the SNR, whereas gradient descent eventually decays exponentially, albeit at a later time for the lower learning rate. Middle shows the fraction of memories retained (i.e., with ) in the three cases. Note that the lower rate has a moderately higher fraction of memories retained than the larger one, but that EWC still has a higher memory retention.

## MNIST Experiments

We carried out all MNIST experiments with fully connected networks with rectified linear units, using the Torch neural network framework. To replicate the results of ref. [^23], we compared with results obtained using dropout regularization. As suggested in ref. [^23], we applied dropout with a probability of 0.2 to the input and of 0.5 to the other hidden layers. To give SGD with dropout the best possible chance, we also used early stopping. Early stopping was implemented by computing the test error on the validation set for all pixel permutations seen to date. Here, if the validation error was observed to increase for more than five subsequent steps, we terminated this training segment and proceeded to the next dataset; at this point, we reset the network weights to the values that had the lowest average validation error on all previous datasets. [Table S1](#st01) shows a list of all hyperparameters used to produce the three graphs in [Fig. 3](#fig03) of the main text. Where a range is present, the parameter was randomly varied and the reported results were obtained using the best hyperparameter setting. When random hyperparameter search was used, 50 combinations of parameters were attempted for each number experiment.

## Atari Experiments

Atari experiments were carried out in the Torch framework. The agent architecture used is almost identical to that used in ref. [^39]. In this section we provide details on all of the parameters used.

Images are preprocessed in the same way as in ref. [^24], namely the 210 × 160 images from the Atari emulator are down-sampled to 84 × 84, using bilinear interpolation. We then convert the red green blue (RGB) images to YUV and use the grayscale channel alone. The state used by the agent consists of the four latest down-sampled, grayscale observations concatenated together.

The network structure used is similar to the one from ref. [^24], namely three convolutional layers followed by a fully connected layer. The first convolution had kernel size 8, stride 4, and 32 filters. The second convolution had kernel size 4, stride 2, and 64 filters. The final convolution had kernels size 3, stride 1, and 128 filters. The fully connected layer had 1,024 units. Note that this network has approximately four times as many parameters as the standard network, due to having twice as many fully connected units and twice as many filters in the final convolution. The other departure from the standard network is that each layer was allowed to have task-specific gains and biases. For each layer, the transformation computed by the network is therefore

|  | \[S34\] |
| --- | --- |

where the biases are and the gains are . The network weights and biases were initialized by setting them randomly with a uniform number between and , with set to the square root of the incoming hidden units (for a linear layer) or set to the area of the kernel times the number of incoming filters (for convolutional layers). Biases and gains were initialized to 0 and 1, respectively.

We used an -greedy exploration policy, where the probability of selecting random action, , decayed with training time. We kept a different timer for each of the tasks. We set for time steps and then decayed this linearly to a value of 0.01 for the next time steps.

We trained the networks with the Double Q-learning algorithm (42). A training step is carried out on a minibatch of 32 experiences every four steps. The target network is updated every time steps. We trained with RMSProp, with a momentum of , a decay of , a learning rate of , and a maximum learning rate of .

Other hyperparameters that we changed from the reference implementation were (*i*) using a smaller replay buffer ( past experiences) and (*ii*) a scaling factor for the EWC penalty of . Another subtle difference is that we used the full action set in the Atari emulator. In fact, although many games support only a small subset of the 18 possible actions, to have a unified network structure for all games we used 18 actions in each game.

We randomly chose the 10 games for each experiment from a pool of 19 Atari games for which the standalone DQN could reach human-level performance in frames. The scores for each of these games for the baseline algorithm, for EWC, and for plain SGD training, as a function of the number of steps played in that game, are shown in [Fig. S3](#sfig03). To get an averaged performance, we chose 10 sets of 10 games and ran four different random seeds for each set.

The most significant departure from the published models is the automatic determination of the task. We model each task by a generative model of the environment. In this work, for simplicity, we model only the current observation. The current task is modeled as a categorical context that is treated as the hidden variable in a hidden Markov model that explain observations. In such a model the probability of being in a particular context at time evolves according to

where is the Kronecker delta function and is the probability of switching context. The task context then conditions a generative model predicting the observation probability . Given such generative models, the probability of being in a task set at time can be inferred by the observations seen so far as

The maximal probability context is then taken to be the current task label.

In our implementation, the generative models consist of factored multinomial distributions explaining the probability of the state of each pixel in the observation space. The model is a parameterized Dirichlet distribution, which summarizes the data seen so far using Bayesian updates. To encourage each model to specialize, we train the models as follows. We partition time into windows of a particular width . During each window, all of the Dirichlet priors are updated with the evidence seen so far. At the end of the window, the model best corresponding to the current task set is selected. Because this model was the most useful to explain the current data, it keeps its prior, and all other priors are reverted to their state at the beginning of the time window. We ensure that one hold-out uniform (i.e., uninitialized) Dirichlet multinomial is always available. Whenever the hold-out model is selected, a new generative model is created and a new task context is therefore created. This model is Bayesian, in the sense that data are used to maintain beliefs over priors on the generative models, and is nonparametric, in the sense that the model can grow as a function of the observed data. It can be seen as an implementation of the flat FMN algorithm described in ref. [^31]. The parameter is not learned. Instead we use the result from ref. [^40] where it is shown that a time-decaying switch rate guarantees good worst-case asymptotic performance provided the number of tasks grows as .

[Table S2](#st02) summarizes all hyperparameters used for the Atari experiments. Except for the parameters pertaining to the EWC algorithm (Fisher multiplier, num. samples Fisher, EWC start) or pertaining to the task recognition models (model update period, model downscaling, and size window), all of the parameter values are the same as in ref. [^39] and have not been tuned for these experiments.
