---
title: "Automated construction of cognitive maps with visual predictive coding - Nature Machine Intelligence"
source: "https://www.nature.com/articles/s42256-024-00863-1"
author:
  - "[[James Gornet]]"
  - "[[Matt Thomson]]"
published: 2024-07-18
created: 2026-09-10
description: "Humans construct internal cognitive maps of their environment directly from sensory inputs without access to a system of explicit coordinates or distance measurements. Although machine learning algorithms like simultaneous localization and mapping utilize specialized inference procedures to identify visual features and construct spatial maps from visual and odometry data, the general nature of cognitive maps in the brain suggests a unified mapping algorithmic strategy that can generalize to auditory, tactile and linguistic inputs. Here we demonstrate that predictive coding provides a natural and versatile neural network algorithm for constructing spatial maps using sensory data. We introduce a framework in which an agent navigates a virtual environment while engaging in visual predictive coding using a self-attention-equipped convolutional neural network. While learning a next-image prediction task, the agent automatically constructs an internal representation of the environment that quantitatively reflects spatial distances. The internal map enables the agent to pinpoint its location relative to landmarks using only visual information.The predictive coding network generates a vectorized encoding of the environment that supports vector navigation, where individual latent space units delineate localized, overlapping neighbourhoods in the environment. Broadly, our work introduces predictive coding as a unified algorithmic framework for constructing cognitive maps that can naturally extend to the mapping of auditory, sensorimotor and linguistic inputs. Constructing spatial maps from sensory inputs is challenging in both neuroscience and artificial intelligence. Gornet and Thomson show that as an agent navigates an environment, a self-attention neural network using predictive coding can recover the environment’s map in its latent space."
tags:
  - "clippings"
---
## Abstract

Humans construct internal cognitive maps of their environment directly from sensory inputs without access to a system of explicit coordinates or distance measurements. Although machine learning algorithms like simultaneous localization and mapping utilize specialized inference procedures to identify visual features and construct spatial maps from visual and odometry data, the general nature of cognitive maps in the brain suggests a unified mapping algorithmic strategy that can generalize to auditory, tactile and linguistic inputs. Here we demonstrate that predictive coding provides a natural and versatile neural network algorithm for constructing spatial maps using sensory data. We introduce a framework in which an agent navigates a virtual environment while engaging in visual predictive coding using a self-attention-equipped convolutional neural network. While learning a next-image prediction task, the agent automatically constructs an internal representation of the environment that quantitatively reflects spatial distances. The internal map enables the agent to pinpoint its location relative to landmarks using only visual information.The predictive coding network generates a vectorized encoding of the environment that supports vector navigation, where individual latent space units delineate localized, overlapping neighbourhoods in the environment. Broadly, our work introduces predictive coding as a unified algorithmic framework for constructing cognitive maps that can naturally extend to the mapping of auditory, sensorimotor and linguistic inputs.

## Main

Space and time are fundamental physical structures in the natural world, and all organisms have evolved strategies for navigating space to forage, mate and escape predation [^1] [^2] [^3]. In humans and other mammals, the concept of a spatial or cognitive map has been postulated to underlie spatial reasoning tasks [^4] [^5] [^6]. A spatial map is an internal, neural representation of an animal’s environment that marks the location of landmarks, food, water and shelter, which can be queried for navigation and planning. The neural algorithms underlying spatial mapping are thought to generalize to other sensory modes to provide cognitive representations of auditory and somatosensory data [^7] as well as to construct internal maps of more abstract information including concepts [^8] [^9], tasks [^10], semantic information [^11] [^12] [^13] and memories [^14]. Empirical evidence suggests that the brain uses common cognitive mapping strategies for spatial and non-spatial sensory information so that common mapping algorithms might exist that can map and navigate over not only visual but also semantic information and logical rules inferred from experience [^7] [^8] [^15]. In such a paradigm, reasoning itself could be implemented as a form of navigation within a cognitive map of concepts, facts and ideas.

After the notion of a spatial or cognitive map emerged, the question of how environments are represented within the brain and how the maps can be learned from experience has been a central question in neuroscience [^16]. Place cells in the hippocampus are neurons that are active when an animal transits through a specific location in an environment [^16]. Grid cells in the entorhinal cortex fire in regular spatial intervals and likely track an organism’s displacement in the environment [^17] [^18]. Yet, even with the identification of a substrate for the representation of space, the question of how a spatial map can be learned from sensory data has remained, and the neural algorithms that enable the construction of spatial and other cognitive maps remain poorly understood.

Empirical work in machine learning has demonstrated that deep neural networks can solve spatial navigation tasks as well as perform path prediction and grid cell formation [^19] [^20]. Two studies [^19] [^20] demonstrate that neural networks can learn to perform path prediction and that networks generate firing patterns that resemble the firing patterns of grid cells in the entorhinal cortex. Other studies [^20] [^21] [^22] demonstrate navigation algorithms that require the environment’s map or that use firing patterns resembllng place cells in the hippocampus. These studies allow an agent to access environmental coordinates explicitly [^19] or initialize a model with place cells that represent specific locations in an arena [^20]. In machine learning and autonomous navigation, a variety of algorithms have been developed to perform mapping tasks, including simultaneous location and mapping (SLAM) and monocular SLAM algorithms [^23] [^24] [^25] [^26], as well as neural network implementations [^27] [^28] [^29]. Yet, SLAM algorithms contain many specific inference strategies, like visual feature and object detection, that are specifically engineered for map building, wayfinding and pose estimation based on visual information. Whereas extensive research in computer vision and machine learning use video frames, these studies do not extract representations of the environment’s map [^30] [^31]. A unified theoretical and mathematical framework for understanding the mapping of spaces based on sensory information remains incomplete.

Predictive coding has been proposed as a unifying theory of neural function where the fundamental goal of a neural system is to predict future observations given past data [^32] [^33] [^34]. When an agent explores a physical environment, temporal correlations in sensory observations reflect the structure of the physical environment. Landmarks nearby one another in space will also be observed in temporal sequence. In this way, predicting observations in a temporal series of sensory observations requires an agent to internalize some implicit information about a spatial domain. Historically, Poincaré motivated the possibility of spatial mapping through a predictive coding strategy, where an agent assembles a global representation of an environment by gluing together information gathered through local exploration [^35] [^36]. The exploratory paths together contain information that could, in principle, enable the assembly of a spatial map for both flat and curved manifolds. Indeed, extended Kalman filters [^25] [^37] for SLAM perform a form of predictive coding by directly mapping visual changes and movement to spatial changes. However, extended Kalman filters, as well as other SLAM approaches, require intricate strategies for landmark size calibration, image feature extraction and models of the camera’s distortion, whereas biological systems can solve flexible mapping and navigation issues that engineered systems cannot. Yet, while the concept of predictive coding for spatial mapping is intuitively attractive, a major challenge is the development of algorithms that can glue together local sensory information gathered by an agent into a global, internally consistent environmental map. Connections between mapping and predictive coding in the literature have primarily focused on situations where an agent has explicit access to its spatial location as a state variable [^38] [^39] [^40]. The problem of building spatial maps de novo from sensory data remains poorly understood.

Here we demonstrate that a neural network trained on a sensory predictive coding task can construct an implicit spatial map of an environment by assembling observations acquired along local exploratory paths into a global representation of a physical space within the network’s latent space. We analyse sensory predictive coding theoretically and demonstrate mathematically that solutions to the predictive sensory inference problem have a mathematical structure that can naturally be implemented by a neural network trained using backpropagation and comprising a ‘path encoder’, an internal spatial map and a ‘sensory decoder’. In such a paradigm, a network learns an internal map of its environment by inferring an internal geometric representation that supports predictive sensory inference. We implement sensory predictive coding within an agent that explores a virtual environment while performing visual predictive coding using a convolutional neural network with self-attention. Following network training during exploration, we find that the encoder network embeds images collected by an agent exploring an environment into an internal representation of space. Within the embedding, the distances between images reflect their relative spatial position, not object-level similarity between images. During exploratory training, the network implicitly assembles information from local paths into a global representation of space as it performs a next-image inference problem. Fundamentally, we connect predictive coding and mapping tasks, demonstrating a computational and mathematical strategy for integrating information from local measurements into a global self-consistent environmental model.

## Mathematical formulation of spatial mapping as sensory predictive coding

In this Article, we aim to understand how a spatial map can be assembled by an agent that is making sensory observations while exploring an environment. Papers in the literature that study connections between predictive coding and mapping have primarily focused on situations where an agent has access to its ‘state’ or location in the environment [^38] [^39] [^40]. Here we develop a theoretical model and neural network implementation of sensory predictive coding that illustrates why and how an internal spatial map can emerge naturally as a solution to sensory inference problems. The neural network is a feedforward deep neural network trained using backpropagation, or gradient descent, rather than Helmholtz machines [^41] [^42], which are commonly used in predictive coding. We first formulate a theoretical model of visual predictive coding and demonstrate that the predictive coding problem can be solved by an inference procedure that constructs an implicit representation of an agent’s environment to predict future sensory observations. The theoretical analysis also suggests that the underlying inference problem can be solved by an encoder–decoder neural network that infers spatial position based upon observed image sequences.

We consider an agent exploring an environment ${{\varOmega }}\subset {{\mathbb{R}}}^{2}$, while acquiring visual information in the form of pixel valued image vectors ${{I}}_{x}\in {{\mathbb{R}}}^{m\times n}$ given an *x*  ∈  *Ω*. The agent’s environment *Ω* is a bounded subset of ${{\mathbb{R}}}^{2}$ that could contain obstructions and holes. In general, at any given time *t*, the agent’s state can be characterized by a position *x* (*t*) and orientation *θ* (*t*) where *x* (*t*) and *θ* (*t*) are coordinates within a global coordinate system unknown to the agent.

The agent’s environment comes equipped with a visual scene, and the agent makes observations by acquiring image vectors ${{I}}_{{x}_{k}}\in {{\mathbb{R}}}^{m\times n}$ as it moves along a sequence of points *x* <sub><i>k</i></sub>. At every position *x* and orientation *θ*, the agent acquires an image by effectively sampling from an image the conditional probability distribution *P* (*I*  ∣  *x* <sub><i>k</i></sub>, *θ* <sub><i>k</i></sub>) which encodes the probability of observing a specific image vector *I* when the agent is positioned at position *x* <sub><i>k</i></sub> and orientation *θ* <sub><i>k</i></sub>. The distribution *P* (*I*  ∣  *x*, *θ*) has a deterministic and stochastic component where the deterministic component is set by landmarks in the environment while stochastic effects can emerge due to changes in lighting, background and scene dynamics. Mathematically, we can view *P* (*I*  ∣  *x*, *θ*) as a function on a vector bundle with base space *Ω* and total space *Ω*  ×  *I* (ref. [^43]). The function assigns an observation probability to every possible image vector for an agent positioned at a point (*x*, *θ*). Intuitively, the agent’s observations preserve the geometric structure of the environment: the spatial structure influences temporal correlations.

In the predictive coding problem, the agent moves along a series of points (*x* <sub>0</sub>, *θ* <sub>0</sub>), (*x* <sub>1</sub>, *θ* <sub>1</sub>), …, (*x* <sub><i>k</i></sub>, *θ* <sub><i>k</i></sub>) while acquiring images *I* <sub>0</sub>, *I* <sub>1</sub>, …*,*  *I* <sub><i>k</i></sub>. The motion of the agent in *Ω* is generated by a Markov process with transition probabilities *P* (*x* <sub><i>i</i> +1</sub>, *θ* <sub><i>i</i> +1</sub>  ∣  *x* <sub><i>i</i></sub>, *θ* <sub><i>i</i></sub>). Note that the agent has access to the image observations *I* <sub><i>i</i></sub> but not the spatial coordinates (*x* <sub><i>i</i></sub>, *θ* <sub><i>i</i></sub>). Given the set { *I* <sub>0</sub>, …*,*  *I* <sub><i>k</i></sub> } the agent aims to predict *I* <sub><i>k</i> +1</sub>. Mathematically, the image prediction problem can be solved theoretically through statistical inference by (1) inferring the posterior probability distribution *P* (*I* <sub><i>k</i> +1</sub>  ∣  *I* <sub>0</sub>, *I* <sub>1</sub>. …, *I* <sub><i>k</i></sub>) from observations. Then, (2) given a specific sequence of observed images { *I* <sub>0</sub>, …*,*  *I* <sub><i>k</i></sub> }, the agent can predict the next image *I* <sub><i>k</i> +1</sub> by finding the image *I* <sub><i>k</i> +1</sub> that maximizes the posterior probability distribution *P* (*I* <sub><i>k</i> +1</sub>  ∣  *I* <sub>0</sub>, *I* <sub>1</sub>, …, *I* <sub><i>k</i></sub>).

The posterior probability distribution *P* (*I* <sub><i>k</i> +1</sub>  ∣  *I* <sub>0</sub>, *I* <sub>1</sub>, …, *I* <sub><i>k</i></sub>) is by definition

 $P \left(I_{k + 1} \left|\right. I_{0} , I_{1} , \ldots , I_{k}\right) = \frac{P \left(I_{0} , I_{1} , \ldots , I_{k} , I_{k + 1}\right)}{P \left(I_{0} , I_{1} , \ldots , I_{k}\right)} .$ 
$$
P({I}_{k+1}\,|\, {I}_{0},{I}_{1},\,\ldots ,{I}_{k})=\frac{P({I}_{0},{I}_{1},\,\ldots ,{I}_{k},{I}_{k+1})}{P({I}_{0},{I}_{1},\,\ldots ,{I}_{k})}.
$$

If we consider *P* (*I* <sub>0</sub>, *I* <sub>1</sub>, …*,*  *I* <sub><i>k</i></sub>, *I* <sub><i>k</i> +1</sub>) to be a function of an implicit set of spatial coordinates (*x* <sub><i>i</i></sub>, *θ* <sub><i>i</i></sub>) where the (*x* <sub><i>i</i></sub>, *θ* <sub><i>i</i></sub>) provide an internal representation of the spatial environment, then we can express the posterior probability *P* (*I* <sub><i>k</i> +1</sub>  ∣  *I* <sub>0</sub>, *I* <sub>1</sub>, …, *I* <sub><i>k</i></sub>) in terms of the implicit spatial representation

 $\begin{matrix}P \left(I_{k + 1} \mid I_{0} , I_{1} , \ldots , I_{k}\right) \\ = \int_{\Omega} d x d \theta P \left(x_{0} , \theta_{0} , x_{1} , \theta_{1} , \ldots , x_{k} , \theta_{k}\right) \frac{P \left(I_{0} , I_{1} , \ldots , I_{k} \mid x_{0} , \theta_{0} , \ldots , x_{k} , \theta_{k}\right)}{P \left(I_{0} , I_{1} , \ldots , I_{k}\right)} \\ P \left(x_{k + 1} \mid x_{k} , \theta_{k}\right) P \left(I_{k + 1} \mid x_{k + 1} , \theta_{k + 1}\right) \\ = \int_{\Omega} d x d \theta \underset{e n c o d i n g \left(t e r m 1\right)}{\underbrace{P \left(x_{0} , \theta_{0} , x_{1} , \theta_{1} , \ldots , x_{k} , \theta_{k} \mid I_{0} , I_{1} , \ldots , I_{k}\right)}} \\ \underset{s p a t i a l t r a n s i t i o n p r o b a b i l i t y \left(t e r m 2\right)}{\underbrace{P \left(x_{k + 1} , \theta_{k + 1} \mid x_{k} , \theta_{k}\right)}} \underset{d e c o d i n g \left(t e r m 3\right)}{\underbrace{P \left(I_{k + 1} \mid x_{k + 1} , \theta_{k + 1}\right)}}\end{matrix}$ 
$$
\begin{array}{ll}P\left(I_{k+1} \mid I_0, I_1, \, \ldots, I_k\right) \\=\displaystyle\int_{\Omega} {\mathrm{d}}{x} \,{\mathrm{d}} \theta \,P\left(x_0, \theta_0, x_1, \theta_1, \, \ldots, x_k, \theta_k\right) \frac{P\left(I_0, I_1, \, \ldots, I_k \mid x_0, \theta_0, \, \ldots, x_k, \theta_k\right)}{P\left(I_0, I_1, \, \ldots, I_k\right)} \\ \\\qquad P\left(x_{k+1} \mid x_k, \theta_k\right) P\left(I_{k+1} \mid x_{k+1}, \theta_{k+1}\right) \\ =\displaystyle\int_{\Omega} {\mathrm{d}}{x} \, {\mathrm{d}} \theta \, \underbrace{P\left(x_0, \theta_0, x_1, \theta_1, \, \ldots, x_k, \theta_k \mid I_0, I_1, \, \ldots, I_k\right)}_{{\mathrm{encoding}}\; ({\mathrm{term }} \, 1) } \\\qquad\underbrace{P\left(x_{k+1}, \theta_{k+1} \mid x_k, \theta_k\right)}_{{\mathrm {spatial}}\; {\mathrm{transition}}\; {\mathrm{probability}}\; ({\mathrm{term}} \, 2) } \underbrace{P\left(I_{k+1} \mid x_{k+1}, \theta_{k+1}\right)}_{{\mathrm{decoding}}\; ({\mathrm{term}} \, 3) } \\\end{array}
$$

(1)

where in equation ([1](https://www.nature.com/articles/s42256-024-00863-1#Equ1)) the integration is over all possible paths {(*x* <sub>0</sub>, *θ* <sub>0</sub>), …, (*x* <sub><i>k</i></sub>, *θ* <sub><i>k</i></sub>)} in the domain *Ω*, for differentials d *x* = d *x* <sub>0</sub>, …, d *x* <sub><i>k</i></sub> and d *θ* = dθ <sub>0</sub>, …, d *θ* <sub><i>k</i></sub>. Equation ([1](https://www.nature.com/articles/s42256-024-00863-1#Equ1)) can be interpreted as a path integral over the domain *Ω*. The path integral assigns a probability to every possible path in the domain and then computes the probability that the agent will observe a next image *I* <sub><i>k</i></sub> given an inferred location (*x* <sub><i>k</i> +1</sub>, *θ* <sub><i>k</i> +1</sub>). In detail, term 1 assigns a probability to every discrete path {(*x* <sub>0</sub>, *θ* <sub>0</sub>), …, (*x* <sub><i>k</i></sub>, *θ* <sub><i>k</i></sub>)} ∈  *Ω* as the conditional likelihood of the path given the observed sequences of images { *I* <sub>0</sub>, …*,*  *I* <sub><i>k</i></sub> }. Term 2 computes the probability that an agent at a terminal position *x* <sub><i>k</i></sub> moves to the position (*x* <sub><i>k</i> +1</sub>, *θ* <sub><i>k</i> +1</sub>), given the Markov transition function *P* (*x* <sub><i>k</i> +1</sub>, *θ* <sub><i>k</i> +1</sub>  ∣  *x* <sub><i>k</i></sub>, *θ* <sub><i>k</i></sub>). Term 3 is the conditional probability that image *I* <sub><i>k</i> +1</sub> is observed, given that the agent is at position (*x* <sub><i>k</i> +1</sub>, *θ* <sub><i>k</i> +1</sub>).

Conceptually, the product of terms solves the next-image prediction problem in three steps. First, estimating the probability that an agent has traversed a particular sequence of points given the observed images; second, estimating the next position of the agent (*x* <sub><i>k</i> +1</sub>, *θ* <sub><i>k</i> +1</sub>) for each potential path; and third, computing the probability of observing a next image *I* <sub><i>k</i> +1</sub> given the inferred terminal location *x* <sub><i>k</i> +1</sub> of the agent. Critically, an algorithm that implements the inference procedure encoded in the equation would construct an internal but implicit representation of the environment as a coordinate system **x**, **θ** that is learned by the agent and used during the next-image inference procedure. The coordinate system provides an internal, inferred representation of the agent’s environment that is used to estimate future image observation probabilities. Thus, our theoretical framework demonstrates how an agent might construct an implicit representation of its spatial environment by solving the predictive coding problem.

The three-step inference procedure represented in the equation for *P* (*I* <sub><i>k</i> +1</sub>  ∣  *I* <sub>0</sub>, *I* <sub>1</sub>, …*,*  *I* <sub><i>k</i></sub>) can be directly implemented in a neural network architecture, as demonstrated in the [Supplementary Information](https://www.nature.com/articles/s42256-024-00863-1#MOESM1). The first term acts as an ‘encoder’ network that computes the probability that the agent has traversed a path {(*x* <sub>0</sub>, *θ* <sub>0</sub>), …, (*x* <sub><i>k</i></sub>, *θ* <sub><i>k</i></sub>)} given an observed image sequence *I* <sub>0</sub>, …, *I* <sub><i>k</i></sub> that has been observed by the network (Fig. [1b](https://www.nature.com/articles/s42256-024-00863-1#Fig1)). The network can then estimate the next position (*x* <sub><i>k</i> +1</sub>, *θ* <sub><i>k</i> +1</sub>) of the agent given an inferred location (*x* <sub><i>k</i></sub>, *θ* <sub><i>k</i></sub>) and apply a decoding network to compute *P* (*I* <sub><i>k</i> +1</sub>  ∣  *x* <sub><i>k</i> +1</sub>, *θ* <sub><i>k</i> +1</sub>), while outputting the prediction *I* <sub><i>k</i> +1</sub> using a decoder. A network trained through visual experience must learn an internal coordinate system and representation **x**, **θ** that not only offers an environmental representation but also establishes a connection between observed images *I* <sub><i>j</i></sub> and inferred locations (*x* <sub><i>j</i></sub>, *θ* <sub><i>j</i></sub>).

![Fig. 1: A predictive coding neural network explores a virtual environment.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs42256-024-00863-1/MediaObjects/42256_2024_863_Fig1_HTML.png?as=webp)

Fig. 1: A predictive coding neural network explores a virtual environment.

### A neural network performs predictive coding

Motivated by the implicit representation of space contained in the predictive coding inference problem, we developed a computational implementation of a predictive coding agent and studied the representation of space learned by that agent as it explored a virtual environment. We first create an environment with the Malmo environment in Minecraft [^44]. The physical environment measures 40 × 65 lattice units and encapsulates three aspects of visual scenes: a cave provides a global visual landmark, a forest provides degeneracy between visual scenes, and a river with a bridge constrains how an agent traverses the environment (Fig. [1a](https://www.nature.com/articles/s42256-024-00863-1#Fig1)). An agent follows paths (Supplementary Fig. [5b,c](https://www.nature.com/articles/s42256-024-00863-1#Sec11)), determined by *A* <sup>*</sup> search to find the shortest path between randomly sampled positions, and receives visual images along every path.

To perform predictive coding, we construct an encoder–decoder convolutional neural network with a ResNet-18 architecture [^45] for the encoder and a corresponding ResNet-18 architecture with transposed convolutions in the decoder (Fig. [1b](https://www.nature.com/articles/s42256-024-00863-1#Fig1)). The encoder–decoder architecture uses the U-Net architecture [^46] to pass the encoded latent units into the decoder. Multi-headed attention [^47] processes the sequence of encoded latent units to encode the history of past visual observations. The multi-headed attention has *h*  = 8 heads. For the encoded latent units with dimension *D*  =  *C*  ×  *H*  ×  *W*, the dimension *d* of a single head is *d*  =  *C*  ×  *H*  ×  *W* / *h* for height *H*, width *W* and channels *C*.

The predictive coder approximates predictive coding by minimizing the mean-squared error between the actual observation and its predicted observation. The predictive coder trains on 82,630 samples for 200 epochs with gradient descent optimization with Nesterov momentum [^48], a weight decay of 5 × 10 <sup>−6</sup> and a learning rate of 10 <sup>−1</sup> adjusted by OneCycle learning-rate scheduling [^49]. The optimized predictive coder has a mean-squared error between the predicted and actual images of 0.094 and a good visual fidelity (Fig. [1c](https://www.nature.com/articles/s42256-024-00863-1#Fig1)).

## Predictive coding network constructs an implicit spatial map

We show that the predictive coder creates an implicit spatial map by demonstrating it recovers the environment’s spatial position and distance. We encode the image sequences using the predictive coder’s encoder to analyse the encoded sequence as the predictive coder’s latent units. To measure the positional information in the predictive coder, we train a neural network to predict the agent’s position from the predictive coder’s latent units (Fig. [1a](https://www.nature.com/articles/s42256-024-00863-1#Fig1)). The neural network’s prediction error

 $E \left(x , \hat{x}\right) = \left\|\hat{x} - x\right\|_{ℓ_{2}}$ 
$$
E(x,\hat{x})={\left\Vert \hat{x}-x\right\Vert }_{{\ell }_{2}}
$$

indirectly measures the predictive coder’s positional information. To provide comparative baselines, we construct a position prediction model. To provide a lower bound for the prediction error, we construct a model that gives the agent’s actual position with small additive Gaussian noise:

 $\hat{x} = x + \epsilon , \epsilon \sim \mathcal{N} \left(0 , \sigma\right) .$ 
$$
\hat{x}=x+\epsilon ,\epsilon \sim {{{\mathcal{N}}}}(0,\sigma ).
$$

such that *ε* ∼ *𝒩* (0,*σ*) indicates noise *ε* that is distributed from a Gaussian distribution with zero mean and standard deviation *σ*. To compare the predictive coder to the baselines, we compare the prediction error histograms (Fig. [2b](https://www.nature.com/articles/s42256-024-00863-1#Fig2)).

![Fig. 2: Predictive coding neural network constructs an implicit spatial map.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs42256-024-00863-1/MediaObjects/42256_2024_863_Fig2_HTML.png?as=webp)

Fig. 2: Predictive coding neural network constructs an implicit spatial map.

The predictive coder encodes the environment’s spatial position to a low prediction error (Fig. [2d](https://www.nature.com/articles/s42256-024-00863-1#Fig2)). The predictive coder has a mean error of 5.04 lattice units and >80% of samples have an error <7.3 lattice units. The additive Gaussian model with *σ*  = 4 has a mean error of 4.98 lattice units and >80% of samples with an error <7.12 lattice units.

We show the predictive coder’s latent space recovers the local distances between the environment’s physical positions. For every path that the agent traverses, we calculate the local pairwise distances in physical space and in the predictive coder’s latent space with a neighbourhood of 100 time points. To determine whether latent space distances correspond to physical distances, we calculate the joint density between latent space distances and physical distances (Fig. [2c](https://www.nature.com/articles/s42256-024-00863-1#Fig2)). We model the latent distances by fitting the physical distances with additive Gaussian noise to a logarithmic function:

 $d \left(z , z^{′}\right) = \alpha log \left(\left\|x - x^{′} + \epsilon\right\|\right) + \beta , \epsilon \sim \mathcal{N} \left(0 , \sigma\right) .$ 
$$
d(z,z^{\prime} )=\alpha \log (\left\Vert x-x^{\prime} +\epsilon \right\Vert )+\beta ,\epsilon \sim {{{\mathcal{N}}}}(0,\sigma ).
$$

The modelled distribution is concentrated with the predictive coder’s distribution (Fig. [2d](https://www.nature.com/articles/s42256-024-00863-1#Fig2)) with a Pearson correlation coefficient of 0.827 and a Kullback–Leibler divergence $({{\mathbb{D}}}_{{{{\rm{KL}}}}}(\,{p}_{{{{\rm{PC}}}}}\parallel {p}_{{{{\rm{model}}}}}))$ of 0.429 bits.

## Predictive coding network learns spatial proximity not image similarity

In the previous section, we show that a neural network that performs predictive coding learns an internal representation of its physical environment within its latent space. Here we demonstrate that the prediction task itself is essential for spatial mapping. Prediction forces a network to learn spatial proximity and not merely image similarity. Many frameworks, including principal components analysis, IsoMap [^50] and auto-encoder neural networks can collocate images by visual similarity. While similar scenes might be proximate in space, similar scenes can also be spatially divergent. For example, the virtual environment we constructed has two different ‘forest’ regions that are separated by a lake. Thus, the two forest environments might generate similar images but are actually each closer to the lake region than to one another (Fig. [1a](https://www.nature.com/articles/s42256-024-00863-1#Fig1)).

To demonstrate the central role for prediction in mapping, we compared the latent representation of images generated by the predictive coding network to a representation learned by an auto-encoder. The auto-encoder network has a similar architecture to the predictive encoder but encodes a single image observation in a latent space and decodes the same observations. As the auto-encoder only operates on a single image, rather than a sequence, the auto-encoder learns an embedding based on image proximity not underlying spatial relationships. As with the predictive coder, the auto-encoder (Fig. [3a](https://www.nature.com/articles/s42256-024-00863-1#Fig3)) trains to minimize the mean-squared error between the actual image and the predicted image on 82,630 samples for 200 epochs with gradient descent optimization with Nesterov momentum, a weight decay of 5 × 10 <sup>−6</sup> and a learning rate of 10 <sup>−1</sup> adjusted by the OneCycle learning-rate scheduler. The auto-encoder has a mean-squared error of 0.039 and a high visual fidelity.

![Fig. 3: Predictive coding network learns spatial proximity, not image similarity.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs42256-024-00863-1/MediaObjects/42256_2024_863_Fig3_HTML.png?as=webp)

Fig. 3: Predictive coding network learns spatial proximity, not image similarity.

The predictive coder encodes a higher resolution and a more accurate spatial map in its latent space than the auto-encoder. As with the predictive coder, we train an auxiliary neural network to predict the agent’s position from the auto-encoder’s latent units (Fig. [3b](https://www.nature.com/articles/s42256-024-00863-1#Fig3)). The neural network’s prediction error indirectly measures the auto-encoder positional information. For greater than 80% of the auto-encoder’s points, its prediction error is less than 13.1 lattice units, as compared to the predictive coder that has >80% of its samples below a prediction error of 7.3 lattice units (Fig. [3c](https://www.nature.com/articles/s42256-024-00863-1#Fig3)).

We also show that the predictive coder recovers the environment’s spatial distances with finer resolution compared to the auto-encoder. As with the predictive coder, we calculate the local pairwise distances in physical space and in the auto-encoder’s latent space, and we generate the joint density between the physical and latent distances (Fig. [3d](https://www.nature.com/articles/s42256-024-00863-1#Fig3)). Compared to the predictive coder’s joint density, the auto-encoder’s latent distances increase with the agent’s physical distance. The auto-encoder’s joint density shows a larger dispersion compared to the predictive coder’s joint density, indicating that the auto-encoder encodes spatial distances with higher uncertainty.

We can quantitatively measure the dispersion in the auto-encoder’s joint density by calculating mutual information of the joint density (Fig. [3e](https://www.nature.com/articles/s42256-024-00863-1#Fig3))

 $I \left[X ; Z\right] = \mathbb{E}_{p \left(X , Z\right)} \left[log \frac{p \left(X , Z\right)}{p \left(X\right) p \left(Z\right)}\right] .$ 
$$
I[X;Z\;]={{\mathbb{E}}}_{p(X,Z\;)}\left[\log \frac{p(X,Z\;)}{p(X\;)p(Z\;)}\right].
$$

The auto-encoder has a mutual information of 0.227 bits, while the predictive coder has a mutual information of 0.627 bits. As a comparison, positions with additive Gaussian noise having a standard deviation *σ* of 2 lattice units have a mutual information of 0.911 bits. The predictive coder encodes 0.400 additional bits of distance information to the auto-encoder. The predictive coder’s additional distance information of 0.400 bits exceeds the auto-encoder’s distance information of 0.227 bits, which indicates the temporal dependencies encoded by the predictive coder capture more spatial information compared to visual similarity.

## Predictive coding network maps visual degenerate environments, whereas auto-encoding cannot

The sequential prediction task is beneficial for spatial mapping: the predictive coder captures more accurate spatial information compared to the auto-encoder, and the predictive coder’s latent distances have a stronger correspondence to the environment’s metric. However, it is unclear whether predictive coding is necessary (as opposed to beneficial) to recover an environment’s map; an auto-encoder may still recover the environment’s map. In this section, we demonstrate that predictive coding is necessary for recovering an environment’s map. First, we show empirically that there exist environments that auto-encoding cannot recover. Second, we provide insight into why the auto-encoder fails with a theorem showing that auto-encoding cannot recover many environments—specifically, environments with visually similar yet spatially different locations.

In the previous sections, the agent explores a natural environment with forest, river and cave landmarks. While this environment models exploration in outdoor environments, the lack of controlled visual scenes complicates the interpretation of the operation of the predictive coder and auto-encoder. We introduce a circular corridor (Fig. [4a](https://www.nature.com/articles/s42256-024-00863-1#Fig4)) to introduce visual scenes that are visually identical—rather than visually similar—yet spatially different. Specifically, the rooms appear clockwise as red, green, red, blue and yellow; there exist two distinct red rooms. The two distinct red rooms permit answering two questions: (1) Can the predictive coder and auto-encoder recover the map for environments with visual symmetry? (2) Does the predictive coder recover a global map or a relative map? In other words, does the predictive coder recover the circular corridor’s geometry, or does it learn a linear hallway?

![Fig. 4: Predictive coding network can learn a circular topology and distinguishes visually identical, spatially different locations.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs42256-024-00863-1/MediaObjects/42256_2024_863_Fig4_HTML.png?as=webp)

Fig. 4: Predictive coding network can learn a circular topology and distinguishes visually identical, spatially different locations.

Similar to previous sections, we train a neural network (or a predictive coder) to perform predictive coding while traversing the circular corridor. In addition, we train a neural network (or an auto-encoder) to perform auto-encoding. The auto-encoder fails to recover spatial information in areas with visual degeneracy: it maps the two distinct red rooms to the same location (Fig. [4e](https://www.nature.com/articles/s42256-024-00863-1#Fig4)). In Fig. [4e](https://www.nature.com/articles/s42256-024-00863-1#Fig4), the auto-encoder predicts the images in the left red room to locations in the right red room—whereas locations with distinct visual scenes (such as the yellow and blue rooms) show a low prediction error (mean error ${\left\Vert x-\hat{x}\right\Vert }_{{\ell }_{2}}=5.004$ lattice units). In addition, the auto-encoder’s latent distances do not separate the different red rooms in latent space—whereas the predictive coder separates the two red rooms (Fig. [4b](https://www.nature.com/articles/s42256-024-00863-1#Fig4)). Moreover, the predictive coder demonstrates a low prediction error throughout, including the two visually degenerate red rooms (mean error ${\left\Vert x-\hat{x}\right\Vert }_{{\ell }_{2}}=0.071$ lattice units) (Fig. [4c](https://www.nature.com/articles/s42256-024-00863-1#Fig4)).

Moreover, we measure the relationship between the predictive coder’s (and auto-encoder’s) metric and the environment’s metric by fitting a regression model (Fig. [4b](https://www.nature.com/articles/s42256-024-00863-1#Fig4)),

 $\left\|z - z^{′}\right\| = \alpha log \left\|x - x^{′}\right\| + \beta ,$ 
$$
\left\Vert z-z^{\prime} \right\Vert =\alpha \log \left\Vert x-x^{\prime} \right\Vert +\beta,
$$

between the predictive coder’s (and auto-encoder’s) latent distances ($\left\Vert z-z^{\prime} \right\Vert$) and the environment’s physical distances ($\left\Vert x-x^{\prime} \right\Vert$). Compared to the natural environment, the auto-encoder’s latent distances show more deviation from the environment’s spatial distances, whereas the predictive coder’s latent distances maintain a correspondence with spatial distances. For the predictive coder, the latent metric recovers spatial metric quantitatively: the correlation plot (Fig. [4d](https://www.nature.com/articles/s42256-024-00863-1#Fig4), left) shows a high correlation (*r*  = 0.827) between the latent and spatial distances, and the quantile–quantile plot (Fig. [4d](https://www.nature.com/articles/s42256-024-00863-1#Fig4), right) shows a high overlap between the regression model and the observed latent distances (${{\mathbb{D}}}_{{{{\rm{KL}}}}}({p}_{{{{\rm{PC}}}}}\parallel {p}_{{{{\rm{model}}}}})=0.250$). The auto-encoder’s latent metric, conversely, does not recover the spatial metric: the correlation plot (Fig. [4f](https://www.nature.com/articles/s42256-024-00863-1#Fig4), left) shows a low correlation (*r*  = 0.288) between the latent and spatial distances, and the quantile–quantile plot (Fig. [4f](https://www.nature.com/articles/s42256-024-00863-1#Fig4), right)) shows a low overlap between the regression model and the observed latent distances (${{\mathbb{D}}}_{{{{\rm{KL}}}}}({p}_{{{{\rm{PC}}}}}\parallel {p}_{{{{\rm{model}}}}})=3.806$).

As shown in Fig. [4](https://www.nature.com/articles/s42256-024-00863-1#Fig4), the auto-encoder cannot recover the spatial map of the circular corridor—whereas the predictive coder can recover the map. Here we show that auto-encoders cannot recover the environment’s map for any environment with visual degeneracy, not just the circular corridor. To show that the auto-encoder cannot learn the environment’s map, we show that any statistical estimator cannot learn the environment’s map from stationary observations. For clarity and brevity, we will provide a proof sketch on a lattice environment *X*, a closed subset of ${{\mathbb{Z}}}^{2}$.

### Theorem 1

Consider an environment *X*, a closed subset of the lattice ${{\mathbb{Z}}}^{2}$ with a function $x \,\stackrel{f}{\mapsto} \,I$ that gives an image ${I}_{x}=f(x)\subset {{\mathbb{R}}}^{D}$ for the image dimension *D* and for each position *x*  ∈  *X*. Let the environment’s observations be degenerate such that

 $f \left(x_{1}\right) = f \left(x_{2}\right) f o r s o m e x_{1} \neq x_{2} .$ 
$$
f({x}_{1})=f({x}_{2})\,\,{{{\rm{for}}}}\,{{{\rm{some}}}}\,\,{x}_{1}\ne {x}_{2}.
$$

There exists no decoder $I\,\stackrel{d}{\mapsto}\,x$ that satisfies

 $x = d \circ I_{x} = d \circ f \left(x\right) w h e r e d \circ f \left(x\right) \triangleq d \left(f \left(x\right)\right) .$ 
$$
x=d\circ {I}_{x}=d\circ f(x)\;{\rm{where}}\; d \circ f(x) \triangleq d(f(x)).
$$

### Proof

The proof proceeds as a consequence that a function has no left inverse if and only if it is not one-to-one. Suppose there exists a decoder $I\,\stackrel{d}{\mapsto}\,x$ that satisfies

 $x = d \circ I_{x} = d \circ f \left(x\right) .$ 
$$
x=d\circ {I}_{x}=d\circ f(x).
$$

Consider

 $f \left(x_{1}\right) = f \left(x_{2}\right) f o r s o m e x_{1} \neq x_{2} .$ 
$$
f({x}_{1})=f({x}_{2})\,\,{{{\rm{for}}}}\,{{{\rm{some}}}}\,\,{x}_{1}\ne {x}_{2}.
$$

Then,

 $x_{1} = d \circ f \left(x_{1}\right) = d \left(I\right) = d \circ f \left(x_{2}\right) = x_{2} ,$ 
$$
{x}_{1}=d\circ f({x}_{1})=d(I\,)=d\circ f({x}_{2})={x}_{2},
$$

which is a contradiction, as required.

Because Theorem 1 demonstrates there exists no decoder for a visually degenerate environment with stationary observations, an auto-encoder cannot recover a visually degenerate environment; the auto-encoder’s failure arises because two locations with the same observation cannot be discriminated.

### Corollary 1

Consider an auto-encoder ${g\,=\,{\mathrm{dec}}\,\circ}$  enc with an encoder $I \,\stackrel{\rm{enc}}{\mapsto}\, z$ and decoder $z \,\stackrel{{{dec}}}{\mapsto}\, I$ that compresses images into a latent space $z\in {{\mathbb{R}}}^{L}$ for the latent dimension *L*. There exists no decoder $z \,\stackrel{h}{\mapsto}\, x$ that satisfies

 $x = h \circ z_{x} = h \circ e n c \circ f \left(x\right) .$ 
$$
x=h\circ {z}_{x}=h\circ {{{\rm{enc}}}}\circ f(x).
$$

### Proof

Consider the decoder ${d\,=\,{h}\,\circ}\,{\mathrm{enc}}:\,{I}\rightarrow{x}$. By Theorem 1, this decoder cannot satisfy

 $x = d \circ f \left(x\right) = h \circ e n c \circ f \left(x\right) ,$ 
$$
x=d\circ f(x)=h\circ {{{\rm{enc}}}}\circ f(x),
$$

as required.

## Predictive coding generates units with localized receptive fields that support vector navigation

In the previous section, we demonstrate that the predictive coding neural network captures spatial relationships within an environment containing more internal spatial information than can be captured by an auto-encoder network that encodes image similarity. Here we analyse the structure of the spatial code learned by the predictive coding network. We demonstrate that each unit in the neural network’s latent space activates at distinct, localized regions—akin to place fields in the mammalian brain—in the environment’s physical space (Fig. [5a](https://www.nature.com/articles/s42256-024-00863-1#Fig5)). These place fields overlap, and their aggregate covers the entire physical space. Each physical location is represented by a unique combination of overlapping regions encoded by the latent units. This combination of overlapping regions recovers the agent’s current physical position. Furthermore, given two physical locations, there now exist two distinct combinations of overlapping regions in latent space. Vector navigation is the representation of the vector heading to a goal location from a current location [^51]. We show that overlapping regions (or place fields) can give a heading from a current location to a goal location. Specifically, a linear decoder recovers the vector to a goal location from a starting location by taking the difference in place fields, which supports vector navigation (Supplementary Fig. [1)](https://www.nature.com/articles/s42256-024-00863-1#MOESM1). Traditionally, other studies [^51] consider grid cell-supported vector navigation, whereas we only consider vector navigation using place cells.

![Fig. 5: The predictive coding network generates place fields that support vector-based distance calculations.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs42256-024-00863-1/MediaObjects/42256_2024_863_Fig5_HTML.png?as=webp)

Fig. 5: The predictive coding network generates place fields that support vector-based distance calculations.

To support this proposed mechanism, we first demonstrate the neural network generates place fields. In other words, units from the neural network’s latent space produce localized regions in physical space. To determine whether a latent unit is active, we threshold the continuous value with its 90th-percentile value. The agent has a head direction that varies to ensure the regions are stable across all head directions. To measure a latent unit’s localization in physical space, we fit each latent unit distribution, with respect to physical space, to a two-dimensional Gaussian distribution (Fig. [5c](https://www.nature.com/articles/s42256-024-00863-1#Fig5), top), defined by

 $P \left(x\right) = \frac{1}{2 \pi \sqrt{\left|\right. \Sigma \left|\right.}} exp \left[- \frac{1}{2} \left(x - \mu\right)^{T} \Sigma^{- 1} \left(x - \mu\right)\right]$ 
$$
P(x)=\frac{1}{2\uppi \sqrt{| {{\Sigma }}|} }\exp \left[-\frac{1}{2}{(x-\mu )}^{T}{{{\Sigma }}}^{-1}(x-\mu )\right]
$$

for the covariance matrix *Σ* and the mean vector *μ*. We measure the area of the ellipsoid given by the Gaussian approximation where *P*  ≥ 0.0005 (Fig. [5c](https://www.nature.com/articles/s42256-024-00863-1#Fig5), bottom). The area of the latent unit approximation measures how localized a unit is compared to the environment’s area, which measures 40 × 65 = 2,600 lattice units. The latent unit approximations have a mean area of 254.6 lattice units (9.79% of the environment) and 80% of the areas are <352.6 lattice units (13.6% of the environment).

The units in the neural network’s latent space provide a unique combinatorial code for each spatial position. The aggregate of latent units covers the environment’s entire physical space. At each lattice block in the environment, we calculate the number of active latent units (Fig. [5d](https://www.nature.com/articles/s42256-024-00863-1#Fig5), left). The number of active latent units is different in 87.6% of the lattice blocks. Every lattice block has at least one active latent unit, which indicates the aggregate of the latent units covers the environment’s physical space. Moreover, to ensure the regions remain stable across shifting landmarks, the environment’s trees were removed and randomly redistributed in the environment (Supplementary Fig. [5a,b](https://www.nature.com/articles/s42256-024-00863-1#Sec22)). The regions remain stable after changing the tree landmarks, with a Jaccard index (∣ *S* <sub>new</sub>  ∩  *S* <sub>old</sub> ∣/∣ *S* <sub>new</sub>  ∪  *S* <sub>old</sub> ∣) (or the intersection over union of new regions *S* <sub>new</sub> and old regions *S* <sub>old</sub>) of 0.828.

Lastly, we demonstrate that the neural network can measure physical distances and could perform vector navigation—representing the vector heading from a current location to a goal location—by comparing the combinations of overlapping regions in its latent space. We first determine the active latent units by thresholding each continuous value by its 90th-percentile value. At each position, we have a 128-dimensional binary vector that gives the overlap of 128 latent units. We take the bitwise difference *z* <sub>1</sub>  −  *z* <sub>2</sub> between the overlapping codes *z* <sub>1</sub> and *z* <sub>2</sub> at two varying positions *x* <sub>1</sub> and *x* <sub>2</sub> with the vector displacement *x* <sub>1</sub>  −  *x* <sub>2</sub> (Supplementary Fig. [1a](https://www.nature.com/articles/s42256-024-00863-1#Sec31)). We then fit a linear decoder from the code *z* <sub>1</sub>  −  *z* <sub>2</sub> to the vector displacement *x* <sub>1</sub>  −  *x* <sub>2</sub>,

 $x_{1} - x_{2} = W \left[z_{1} - z_{2}\right] + b .$ 
$$
{x}_{1}-{x}_{2}=W[{z}_{1}-{z}_{2}]+b.
$$

for weight *W* and bias *b*. The predicted distance error $\left\Vert r-\hat{r}\right\Vert$ and the predicted direction error $\Vert \theta -\hat{\theta }\Vert$ are decomposed from the predicted displacement ${\hat{x}}_{1}-{\hat{x}}_{2}$. The linear decoder has a low prediction error for distance (<80%, 12.49 lattice units; mean 7.89 lattice units) and direction (<80%, 48.04°; mean 30.6°) (Supplementary Fig. [1b,c](https://www.nature.com/articles/s42256-024-00863-1#Sec11)). The code *z* <sub>1</sub>  −  *z* <sub>2</sub> is highly correlated with direction *θ* and distance *r* with Pearson correlation coefficients 0.924 and 0.718, respectively (Supplementary Fig. [1d](https://www.nature.com/articles/s42256-024-00863-1#Sec31)).

We can measure the correspondence between the bitwise distance ∣ *z* <sub>1</sub>  −  *z* <sub>2</sub> ∣ and the physical distances ${\left\Vert {x}_{1}-{x}_{2}\right\Vert }_{{\ell }_{2}}$, which use the Euclidean distance $\vert\vert x {{\vert \vert_{\ell}}_{2}} = {\sqrt {\sum^{D}_{i=1} x^{2}_{i}}}$ for dimension *D*. For the bitwise distance, we threshold the latent units to its 90th-percentile then compute the *L* <sub>1</sub> -norm ($\vert\vert x {{\vert \vert_{\ell}}_{1}} = \sum^{D}_{i=1} \vert x_{i} \vert$ for dimension *D*) between the units. Similar to the previous sections, we compute the joint densities of the binary vectors’ bitwise distances and the physical positions’ Euclidean distances. We then calculate their mutual information to measure how much spatial information the bitwise distance captures. The proposed mechanism for the neural network’s distance measurement—the binary vector’s Hamming distance—gives a mutual information of 0.542 bits, compared to the predictive coder’s mutual information of 0.627 bits and the auto-encoder’s mutual information of 0.227 bits (Fig. [5e](https://www.nature.com/articles/s42256-024-00863-1#Fig5)). The code from the overlapping regions captures a majority amount of the predictive coder’s spatial information.

## Discussion

Mapping is a general mechanism for generating an internal representation of sensory information. While spatial maps facilitate navigation and planning within an environment, mapping is a ubiquitous neural function that extends to representations beyond visual–spatial mapping. The primary sensory cortex, for example, maps tactile events topographically. Physical touches that occur in proximity are mapped in proximity for both the neural representations and the anatomical brain regions [^52]. Similarly, the cortex maps natural speech by tiling regions with different words and their relationships, which shows that topographic maps in the brain extend to higher-order cognition. The similar representation of non-spatial and spatial maps in the brain suggests a common mechanism for charting cognitive maps [^53]. However, it is unclear how a single mechanism can generate both spatial and non-spatial maps.

Here we show that predictive coding provides a basic, general mechanism for charting spatial maps by predicting sensory data from past sensory experiences—including environments with degenerate observations. Our theoretical framework applies to any vector-valued sensory data and could be extended to auditory data, tactile data or tokenized representations of language. We demonstrate a neural network that performs predictive coding and can construct an implicit spatial map of an environment by assembling information from local paths into a global frame within the neural network’s latent space. The implicit spatial map depends specifically on the sequential task of predicting future visual images. Neural networks trained as auto-encoders do not reconstruct a faithful geometric representation in the presence of physically distant yet visually similar landmarks.

Moreover, we study the predictive coding neural network’s representation in latent space. Each unit in the network’s latent space activates at distinct, localized regions—called place fields—with respect to physical space. At each physical location, there exists a unique combination of overlapping place fields. At two locations, the differences in the combinations of overlapping place fields provide the distance between the two physical locations. The existence of place fields in both the neural network and the hippocampus [^16] suggests that predictive coding is a universal mechanism for mapping. In addition, vector navigation emerges naturally from predictive coding by computing distances from overlapping place field units. Predictive coding may provide a model for understanding how place cells emerge, change and function.

Predictive coding can be performed over any sensory modality that has some temporal sequence. As natural speech forms a cognitive map, predictive coding may underlie the geometry of human language. Intriguingly, large language models train on causal word prediction—a form of predictive coding—build internal maps that support generalized reasoning, answer questions and mimic other forms of higher-order reasoning [^54]. Similarities in spatial and non-spatial maps in the brain suggest that large language models organize language into a cognitive map and chart concepts geometrically. These results all suggest that predictive coding might provide a unified theory for building representations of information-connecting disparate theories including place cell formation in the hippocampus, somatosensory maps in the cortex and human language.

## Methods

### Environment simulation

#### Forest–cave–river environment

These experiments leverage the Malmo framework [^44] to construct a controlled environment within Minecraft. This environment is a rectangular space measuring 40 by 65 lattice units and incorporates three key visual features: a prominent cave serving as a global landmark, a forest area introducing some visual ambiguity between scenes and a river with a bridge that restricts agent movement options. Within this environment, an agent traverses paths between randomly chosen waypoints. These paths are determined using the *A* <sup>*</sup> search algorithm to ensure obstacles did not block the agent’s path. The agent varies its speed and direction to traverse the generated paths. During its exploration, the agent captures visual observations at regular intervals along each path.

#### Circular environment

To explore the model’s ability to differentiate between visually identical but spatially distinct scenes, these experiments used a circular corridor environment. This environment consists of an infinitely repeating sequence of rooms, specifically coloured red, green, red, blue and yellow in a clockwise direction. Notably, there are two distinct red rooms despite their identical appearance. Technically, the environment is an infinitely long hallway segmented into these coloured rooms. Similar to the previous experiment, an agent navigates between randomly chosen waypoints within this environment. The paths are determined using the *A* <sup>*</sup> search algorithm, and the agent captures visual observations at regular intervals along its journey.

### Predictive coder

#### Architecture

The proposed neural network follows an encoder–decoder architecture, employing a U-Net structure to process input image sequences and predict future images. The encoder and decoder components are both based on ResNet-18 convolutional neural networks.

The encoding module utilizes a ResNet-18 model to extract hierarchical features from the input image sequence. Each image in the sequence is processed independently through the ResNet-18 encoder, generating a sequence of latent vectors. The encoder consists of residual blocks, each containing convolutional layers, batch normalization and rectified linear unit (ReLU) activations. The downsampling is achieved via strided convolutions within the residual blocks.

The self-attention module utilizes multi-headed attention, which processes the sequence of encoded latent units to encode the history of past visual observations. The network consists of one layer of multi-headed attention. The multi-headed attention has *h*  = 8 heads. For the encoded latent units with dimension *D*  =  *C*  ×  *H*  ×  *W*, the dimension *d* of a single head is *d*  =  *C*  ×  *H*  ×  *W* / *h*.

The latent vectors output by the encoder are concatenated to form an ordered sequence. This sequence is then processed by a self-attention layer to capture temporal dependencies and relationships among the image sequence. The self-attention mechanism enables the model to weigh the importance of each latent vector in the context of the entire sequence, facilitating improved temporal feature representation.

The decoding module mirrors the encoder’s architecture, utilizing a ResNet-18 model adapted for upsampling. The decoder reconstructs the future images from the transformed latent vectors, employing transposed convolutions and residual blocks analogous to those in the encoder.

#### Training

The predictive coder is trained for 200 epochs using stochastic gradient descent as the optimization algorithm. The training parameters include a learning rate of 0.1, Nesterov momentum of 0.9 and a weight decay of 5 × 10 <sup>−6</sup>. To optimize the learning process, the learning rate is scheduled using the OneCycle learning-rate policy. This policy adjusts the learning rate cyclically between a lower and upper bound, facilitating efficient convergence and improved performance. The OneCycle learning-rate schedule is characterized by an initial increase in the learning rate, followed by a subsequent decrease.

#### Latent units

The predictive coder’s encoding and self-attention modules were used to analyse the encoded sequences as the predictive coder’s latent units. The image sequence first undergoes processing through the encoder, which extracts a compressed representation capturing the key features within each image. Subsequently, this encoded sequence is fed into the self-attention module. This module specifically focuses on the inherent temporal order of the images within the sequence. The self-attention module’s processed output forms the predictive coder’s latent units.

### Auto-encoder

#### Architecture

Unlike the predictive coder architecture, the auto-encoder architecture transforms the current images (rather than the past images for the predictive coder) into a low-dimensional latent vector. The proposed neural network follows an encoder–decoder architecture employing a U-Net structure to process input image sequences into a low-dimensional latent vector and to reconstruct the initial image. The encoder and decoder components are both based on ResNet-18 convolutional neural networks. However, the auto-encoder architecture does not utilize any self-attention layers to integrate past observations of images.

The encoding module utilizes a ResNet-18 model to extract hierarchical features from the input image sequence. Each image in the sequence is processed independently through the ResNet-18 encoder, generating a sequence of latent vectors. The encoder consists of residual blocks, each containing convolutional layers, batch normalization and ReLU activations. The downsampling is achieved via strided convolutions within the residual blocks.

Unlike the predictive coder, the latent vectors output by the encoder are directly processed by the decoder. Whereas the predictive coder predicts the future images within an image sequence, the auto-encoder predicts the current images, given the low-dimensional latent vector generated by the encoder.

The decoding module mirrors the encoder’s architecture, utilizing a ResNet-18 model adapted for upsampling. The decoder reconstructs the future images from the transformed latent vectors, employing transposed convolutions and residual blocks analogous to those in the encoder.

#### Training

The predictive coder is trained for 200 epochs using stochastic gradient descent as the optimization algorithm. The training parameters include a learning rate of 0.1, Nesterov momentum of 0.9 and a weight decay of 5 × 10 <sup>−6</sup>. To optimize the learning process, the learning rate is scheduled using the OneCycle learning-rate policy. This policy adjusts the learning rate cyclically between a lower and upper bound, facilitating efficient convergence and improved performance. The OneCycle learning-rate schedule is characterized by an initial increase in the learning rate, followed by a subsequent decrease.

#### Latent units

The auto-encoder’s encoding module was used to analyse the encoded images as the auto-encoder’s latent units. The image sequence first undergoes processing through the encoder, which extracts a compressed representation capturing the key features within each image. The encoder’s processed output forms the auto-encoder’s latent units.

### Positional decoder

To assess the effectiveness of the predictive coder in capturing positional information within the encoded sequences, this analysis employed an auxiliary neural network for position prediction. This network, referred to as the positional decoder, takes the latent units generated by the predictive coder—or auto-encoder—as input. The decoder architecture consists of several layers designed to extract this positional information: a convolutional layer transforms the input to a higher dimension (256), followed by a ReLU activation for non-linearity. A max pooling layer then reduces the spatial resolution while maintaining relevant features. Subsequently, two fully connected (affine) layers with ReLU activations project the data to a lower dimension (64) and finally to a 2-dimensional output, corresponding to the agent’s predicted position (*x* and *y* coordinates).

During training, the mean-squared error between the agent’s actual position and the predicted position served as the loss function

 $E \left(x , \hat{x}\right) = \left\|x - \hat{x}\right\|_{ℓ_{2}} .$ 
$$
E(x,\hat{x})={\left\Vert x-\hat{x}\right\Vert }_{{\ell }_{2}}.
$$

To optimize this loss, the AdamW optimizer was employed with a two-stage learning-rate schedule. The initial stage utilized a learning rate of 10 <sup>−4</sup> for 1,000 epochs, followed by a fine-tuning stage with a reduced learning rate of 10 <sup>−5</sup> for an additional 1,000 epochs.

### Modelling the correspondence between latent and physical distances

This analysis evaluated the ability of the predictive coder’s latent space to encode local positional information. For each path traversed by the agent, we computed the pairwise distances between positions in physical space and the corresponding latent space distances within a neighbourhood of 100 time steps. To assess the correspondence between these two distance measures, we analysed the joint distribution of physical and latent space distances. We modelled the relationship between latent distances and their corresponding physical distances using a logarithmic function with additive Gaussian noise

 $\hat{x} = x + \epsilon , \epsilon \sim \mathcal{N} \left(0 , \sigma\right) .$ 
$$
\hat{x}=x+\epsilon ,\epsilon \sim {{{\mathcal{N}}}}(0,\sigma ).
$$

The goodness-of-fit between the model and the actual data was evaluated using two metrics: the Pearson correlation coefficient, which measures the dependence between the physical and latent distances, and the Kullback–Leibler divergence

 $\left(\right. \mathbb{D}_{K L} \left(\right. p_{P C} \parallel p_{m o d e l} \left.\right) \left.\right) ,$ 
$$
({{\mathbb{D}}}_{{{{\rm{KL}}}}}(\;{p}_{{{{\rm{PC}}}}}\parallel {p}_{{{{\rm{model}}}}})),
$$

which quantifies the difference between the two modelled regression distribution and the observed empirical distribution.

### Mutual information of the predictive coder and auto-encoder

The spatial information encoded within the latent representations of both the predictive coder and the auto-encoder was evaluated. To achieve this, this analysis computed the joint densities between the latent distances in each model and the corresponding actual physical distances within the environment. By analysing these joint densities, we were able to quantify the physical information within each model’s latent space. Mutual information

 $I \left[X ; Z\right] = \mathbb{E}_{p \left(X , Z\right)} \left[log \frac{p \left(X , Z\right)}{p \left(X\right) p \left(Z\right)}\right]$ 
$$
I[X;Z\;]={{\mathbb{E}}}_{p(X,Z\;)}\left[\log \frac{p(X,Z\;)}{p(X\;)p(Z\;)}\right]
$$

was employed as a metric to assess this physical information. Higher mutual information indicates that the latent distances in a model encode a greater amount of spatial information, signifying a stronger correlation between the distances in the latent space and the actual physical separations between locations in the environment. This comparison allows us to gauge the relative effectiveness of each model in capturing and representing spatial relationships within their respective latent spaces.

### Place field analysis

#### Place field calculation

This analysis investigated the spatial localization of individual units within the neural network’s latent space. First, this analysis computed the histogram of the distribution of the 128-dimensional latent vectors. To identify active units, this analysis employed a thresholding technique based on the 90th-percentile value of the continuous latent unit values. This ensured a focus on units with notable activation levels. The agent’s head direction was varied during data collection to ensure the identified localized regions remained stable regardless of the agent’s orientation.

#### Place field statistical fitting

To quantify the degree of localization for each active unit, this analysis fitted a two-dimensional Gaussian distribution

 $P \left(x\right) = \frac{1}{2 \pi \left|\right. \Sigma \left|\right.} exp \left[- \frac{1}{2} \left(x - \mu\right)^{T} \Sigma^{- 1} \left(x - \mu\right)\right]$ 
$$
P(x)=\frac{1}{2\uppi | {{\Sigma }}| }\exp \left[-\frac{1}{2}{(x-\mu )}^{T}{{{\Sigma }}}^{-1}(x-\mu )\right]
$$

to its corresponding distribution in physical space. The area of the resulting ellipsoid, defined by the Gaussian approximation and exceeding a probability threshold of *P*  ≥ 0.0005, served as our localization metric. This area reflects the spatial extent of the unit’s activation within the environment, relative to the overall environment size of 40 × 65 lattice units (2,600 units). Units with smaller ellipsoid areas indicate a more concentrated activation pattern in physical space, suggesting a higher degree of localization.

#### Vector navigation analysis

This analysis investigated the ability of the neural network’s latent space to not only encode positional information but also represent the vector heading from a current location to a goal location—called vector navigation. To assess this, we compared the combinations of overlapping regions in the latent space representations of two distinct positions *x* <sub>1</sub> and *x* <sub>2</sub>. This analysis achieved this by computing the bitwise difference *z* <sub>1</sub>  −  *z* <sub>2</sub> between the corresponding latent codes *z* <sub>1</sub>, *z* <sub>2</sub> for these positions. Subsequently, we examined the relationship between this difference vector and the actual physical displacement vector *x* <sub>1</sub>  −  *x* <sub>2</sub> using a linear decoder

 $x_{1} - x_{2} = W \left[z_{1} - z_{2}\right] + b$ 
$$
{x}_{1}-{x}_{2}=W\;[{z}_{1}-{z}_{2}]+b
$$

This decoder was trained to predict the displacement vector based solely on the latent code difference. The predicted displacement was then decomposed into its distance and directional components, to calculate the specific errors associated with predicting both the distance and direction to the goal location. This analysis computed the Pearson correlation coefficient between the predicted distance, predicted direction and the predicted displacement vector.

#### Mutual information calculation

This analysis employed a complementary approach to evaluate the spatial information encoded within the binary vectors derived from the latent space. Here the joint densities were computed between the bitwise distances of these binary vectors and the Euclidean distances between corresponding physical positions. The mutual information

 $I \left[X ; Z\right] = \mathbb{E}_{p \left(X , Z\right)} \left[log \frac{p \left(X , Z\right)}{p \left(X\right) p \left(Z\right)}\right] .$ 
$$
I[X;Z\;]={{\mathbb{E}}}_{p(X,Z\;)}\left[\log \frac{p(X,Z\;)}{p(X\;)p(Z\;)}\right].
$$

was then computed to quantify the amount of spatial information captured by the bitwise distances. This metric essentially reflects how well the bitwise distance between latent codes reflects the actual physical separation between locations in the environment. Finally, to provide context for the obtained value, the mutual information of the binary vectors’ bitwise distance was compared with the mutual information derived from the latent distances of both the predictive coder and the auto-encoder. This comparison assesses the relative effectiveness of each model in capturing spatial information within their respective latent representations.

#### Place field stability with shifting landmarks

To assess the stability of the identified localized regions within the latent space, this analysis investigated their resilience to changes in the environment’s landmarks. The environment was manipulated: the trees, originally serving as landmarks, were removed and then randomly redistributed throughout the space. Subsequently, the Jaccard index

 $\left|\right. S_{n e w} \cap S_{o l d} \left|\right. / \left|\right. S_{n e w} \cup S_{o l d} \left|\right.$ 
$$
| {S}_{{{{\rm{new}}}}}\cap {S}_{{{{\rm{old}}}}}| /| {S}_{{{{\rm{new}}}}}\cup {S}_{{{{\rm{old}}}}}|
$$

was employed to quantify the overlap between the latent units identified in the original environment and those found in the environment with shifted landmarks. The Jaccard index ranges from 0 to 1, where a value of 1 indicates a perfect overlap between the sets of latent units, and 0 signifies no overlap. This analysis allowed us to evaluate how well the latent units maintain their spatial correspondence despite alterations to the environment’s visual features.

### Reporting summary

Further information on research design is available in the [Nature Portfolio Reporting Summary](https://www.nature.com/articles/s42256-024-00863-1#MOESM2) linked to this article.

## Data availability

All datasets supporting the findings of this study, including the latent variables for the auto-encoding and predictive coding neural networks, as well as the training and validation datasets, are available on GitHub at [https://github.com/jgornet/predictive-coding-recovers-maps](https://github.com/jgornet/predictive-coding-recovers-maps) and via Zenodo at [https://doi.org/10.5281/zenodo.11287439](https://doi.org/10.5281/zenodo.11287439) (ref. [^55]).

## Code availability

The code supporting the conclusions of this study is available on GitHub at [https://github.com/jgornet/predictive-coding-recovers-maps](https://github.com/jgornet/predictive-coding-recovers-maps) and via Zenodo at [https://doi.org/10.5281/zenodo.11287439](https://doi.org/10.5281/zenodo.11287439) (ref. [^55]). The repository contains the Project Malmo environment code, training scripts for both the predictive coding and auto-encoding neural networks, as well as code for the analysis of predictive coding and auto-encoding results.

## References

## Acknowledgements

We appreciate I. Strazhnik for her contributions to the scientific visualizations and figure illustrations. Her expertise in translating our research into clear visuals has significantly elevated the clarity and impact of our paper. We are grateful to T. Siapas, E. Lubenov, D. Mobbs and M. Rosenberg for their invaluable and insightful discussions. Their expertise and feedback have been instrumental in the development and realization of this research. Additionally, we appreciate the insights provided by L. Xu, M. Wang and J. Zheng, which played a crucial role in refining various aspects of our study. We are thankful for the support provided by The David and Lucile Packard Foundation under grant no. 2019-69662, as well as the Chen Institute at Caltech, the Heritage Medical Research Institute and the Chan Zuckerberg Initiative (M.T. and J.G.).

## Ethics declarations

### Competing interests

The authors declare no competing interests.

## Peer review

### Peer review information

*Nature Machine Intelligence* thanks the anonymous reviewers for their contribution to the peer review of this work.

## Additional information

**Publisher’s note** Springer Nature remains neutral with regard to jurisdictional claims in published maps and institutional affiliations.

## Supplementary information

### Supplementary Information (download PDF )

Supplementary text and Figs. 1–6.

### Reporting Summary (download PDF )

## Rights and permissions

**Open Access** This article is licensed under a Creative Commons Attribution 4.0 International License, which permits use, sharing, adaptation, distribution and reproduction in any medium or format, as long as you give appropriate credit to the original author(s) and the source, provide a link to the Creative Commons licence, and indicate if changes were made. The images or other third party material in this article are included in the article’s Creative Commons licence, unless indicated otherwise in a credit line to the material. If material is not included in the article’s Creative Commons licence and your intended use is not permitted by statutory regulation or exceeds the permitted use, you will need to obtain permission directly from the copyright holder. To view a copy of this licence, visit [http://creativecommons.org/licenses/by/4.0/](http://creativecommons.org/licenses/by/4.0/).

[^1]: Epstein, R. A., Patai, E. Z., Julian, J. B. & Spiers, H. J. The cognitive map in humans: spatial navigation and beyond. *Nat. Neurosci.* **20**, 1504–1513 (2017).

[Article](https://doi.org/10.1038%2Fnn.4656) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20cognitive%20map%20in%20humans%3A%20spatial%20navigation%20and%20beyond&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.4656&volume=20&pages=1504-1513&publication_year=2017&author=Epstein%2CRA&author=Patai%2CEZ&author=Julian%2CJB&author=Spiers%2CHJ)

[^2]: Wang, Z. J. & Thomson, M. Localization of signaling receptors maximizes cellular information acquisition in spatially structured natural environments. *Cell Syst.* **13**, 530–546 (2022).

[Article](https://doi.org/10.1016%2Fj.cels.2022.05.004) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Localization%20of%20signaling%20receptors%20maximizes%20cellular%20information%20acquisition%20in%20spatially%20structured%20natural%20environments&journal=Cell%20Syst.&doi=10.1016%2Fj.cels.2022.05.004&volume=13&pages=530-546&publication_year=2022&author=Wang%2CZJ&author=Thomson%2CM)

[^3]: Sivak, D. A. & Thomson, M. Environmental statistics and optimal regulation. *PLoS Comput. Biol.* **10**, e1003826 (2014).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1003826) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Environmental%20statistics%20and%20optimal%20regulation&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1003826&volume=10&publication_year=2014&author=Sivak%2CDA&author=Thomson%2CM)

[^4]: Anderson, J. *Cognitive Psychology and Its Implications* 9th edn (Worth Publishers, 2020).

[^5]: Rescorla, M. Cognitive maps and the language of thought. *Br. J. Philos. Sci.* **60**, 377–407 (2009).

[^6]: Whittington, J. C., McCaffary, D., Bakermans, J. J. & Behrens, T. E. How to build a cognitive map. *Nat. Neurosci.* **25**, 1257–1272 (2022).

[Article](https://doi.org/10.1038%2Fs41593-022-01153-y) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=How%20to%20build%20a%20cognitive%20map&journal=Nat.%20Neurosci.&doi=10.1038%2Fs41593-022-01153-y&volume=25&pages=1257-1272&publication_year=2022&author=Whittington%2CJC&author=McCaffary%2CD&author=Bakermans%2CJJ&author=Behrens%2CTE)

[^7]: Aronov, D., Nevers, R. & Tank, D. W. Mapping of a non-spatial dimension by the hippocampal–entorhinal circuit. *Nature* **543**, 719–722 (2017).

[Article](https://doi.org/10.1038%2Fnature21692) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mapping%20of%20a%20non-spatial%20dimension%20by%20the%20hippocampal%E2%80%93entorhinal%20circuit&journal=Nature&doi=10.1038%2Fnature21692&volume=543&pages=719-722&publication_year=2017&author=Aronov%2CD&author=Nevers%2CR&author=Tank%2CDW)

[^8]: Nieh, E. H. et al. Geometry of abstract learned knowledge in the hippocampus. *Nature* **595**, 80–84 (2021).

[Article](https://doi.org/10.1038%2Fs41586-021-03652-7) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Geometry%20of%20abstract%20learned%20knowledge%20in%20the%20hippocampus&journal=Nature&doi=10.1038%2Fs41586-021-03652-7&volume=595&pages=80-84&publication_year=2021&author=Nieh%2CEH)

[^9]: Whittington, J. C. et al. The Tolman-Eichenbaum machine: unifying space and relational memory through generalization in the hippocampal formation. *Cell* **183**, 1249–1263 (2020).

[Article](https://doi.org/10.1016%2Fj.cell.2020.10.024) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20Tolman-Eichenbaum%20machine%3A%20unifying%20space%20and%20relational%20memory%20through%20generalization%20in%20the%20hippocampal%20formation&journal=Cell&doi=10.1016%2Fj.cell.2020.10.024&volume=183&pages=1249-1263&publication_year=2020&author=Whittington%2CJC)

[^10]: Wilson, R. C., Takahashi, Y. K., Schoenbaum, G. & Niv, Y. Orbitofrontal cortex as a cognitive map of task space. *Neuron* **81**, 267–279 (2014).

[Article](https://doi.org/10.1016%2Fj.neuron.2013.11.005) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Orbitofrontal%20cortex%20as%20a%20cognitive%20map%20of%20task%20space&journal=Neuron&doi=10.1016%2Fj.neuron.2013.11.005&volume=81&pages=267-279&publication_year=2014&author=Wilson%2CRC&author=Takahashi%2CYK&author=Schoenbaum%2CG&author=Niv%2CY)

[^11]: Constantinescu, A. O., O’Reilly, J. X. & Behrens, T. E. J. Organizing conceptual knowledge in humans with a gridlike code. *Science* **352**, 1464–1468 (2016).

[Article](https://doi.org/10.1126%2Fscience.aaf0941) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Organizing%20conceptual%20knowledge%20in%20humans%20with%20a%20gridlike%20code&journal=Science&doi=10.1126%2Fscience.aaf0941&volume=352&pages=1464-1468&publication_year=2016&author=Constantinescu%2CAO&author=O%E2%80%99Reilly%2CJX&author=Behrens%2CTEJ)

[^12]: Garvert, M. M., Dolan, R. J. & Behrens, T. E. A map of abstract relational knowledge in the human hippocampal–entorhinal cortex. *eLife* **6**, e17086 (2017).

[Article](https://doi.org/10.7554%2FeLife.17086) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20map%20of%20abstract%20relational%20knowledge%20in%20the%20human%20hippocampal%E2%80%93entorhinal%20cortex&journal=eLife&doi=10.7554%2FeLife.17086&volume=6&publication_year=2017&author=Garvert%2CMM&author=Dolan%2CRJ&author=Behrens%2CTE)

[^13]: Huth, A. G., de Heer, W. A., Griffiths, T. L., Theunissen, F. E. & Gallant, J. L. Natural speech reveals the semantic maps that tile human cerebral cortex. *Nature* **532**, 453–458 (2016).

[Article](https://doi.org/10.1038%2Fnature17637) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Natural%20speech%20reveals%20the%20semantic%20maps%20that%20tile%20human%20cerebral%20cortex&journal=Nature&doi=10.1038%2Fnature17637&volume=532&pages=453-458&publication_year=2016&author=Huth%2CAG&author=Heer%2CWA&author=Griffiths%2CTL&author=Theunissen%2CFE&author=Gallant%2CJL)

[^14]: Corkin, S. Lasting consequences of bilateral medial temporal lobectomy: clinical course and experimental findings in H.M. *Semin. Neurol.* **4**, 249–259 (1984).

[Article](https://doi.org/10.1055%2Fs-2008-1041556) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Lasting%20consequences%20of%20bilateral%20medial%20temporal%20lobectomy%3A%20clinical%20course%20and%20experimental%20findings%20in%20H.M&journal=Semin.%20Neurol.&doi=10.1055%2Fs-2008-1041556&volume=4&pages=249-259&publication_year=1984&author=Corkin%2CS)

[^15]: Behrens, T. E. et al. What is a cognitive map? Organizing knowledge for flexible behavior. *Neuron* **100**, 490–509 (2018).

[Article](https://doi.org/10.1016%2Fj.neuron.2018.10.002) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=What%20is%20a%20cognitive%20map%3F%20Organizing%20knowledge%20for%20flexible%20behavior&journal=Neuron&doi=10.1016%2Fj.neuron.2018.10.002&volume=100&pages=490-509&publication_year=2018&author=Behrens%2CTE)

[^16]: O’Keefe, J. Place units in the hippocampus of the freely moving rat. *Exp. Neurol.* **51**, 78–109 (1976).

[Article](https://doi.org/10.1016%2F0014-4886%2876%2990055-8) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Place%20units%20in%20the%20hippocampus%20of%20the%20freely%20moving%20rat&journal=Exp.%20Neurol.&doi=10.1016%2F0014-4886%2876%2990055-8&volume=51&pages=78-109&publication_year=1976&author=O%E2%80%99Keefe%2CJ)

[^17]: Hafting, T., Fyhn, M., Molden, S., Moser, M.-B. & Moser, E. I. Microstructure of a spatial map in the entorhinal cortex. *Nature* **436**, 801–806 (2005).

[Article](https://doi.org/10.1038%2Fnature03721) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Microstructure%20of%20a%20spatial%20map%20in%20the%20entorhinal%20cortex&journal=Nature&doi=10.1038%2Fnature03721&volume=436&pages=801-806&publication_year=2005&author=Hafting%2CT&author=Fyhn%2CM&author=Molden%2CS&author=Moser%2CM-B&author=Moser%2CEI)

[^18]: Amaral, D. G., Ishizuka, N. & Claiborne, B. in *Understanding the Brain Through the Hippocampus: the Hippocampal Region as a Model for Studying Brain Structure and Function* (eds Storm-Mathisen, J. et al.) Ch 1 (1990).

[^19]: Cueva, C. J. & Wei, X.-X. Emergence of grid-like representations by training recurrent neural networks to perform spatial localization. In *Proc. 6th International Conference on Learning Representations (ICLR)* 1512–1530 (Curran Associates, Inc., 2018).

[^20]: Banino, A. et al. Vector-based navigation using grid-like representations in artificial agents. *Nature* **557**, 429–433 (2018).

[Article](https://doi.org/10.1038%2Fs41586-018-0102-6) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Vector-based%20navigation%20using%20grid-like%20representations%20in%20artificial%20agents&journal=Nature&doi=10.1038%2Fs41586-018-0102-6&volume=557&pages=429-433&publication_year=2018&author=Banino%2CA)

[^21]: Crane, K., Weischedel, C. & Wardetzky, M. The heat method for distance computation. *Commun. ACM* **60**, 90–99 (2017).

[Article](https://doi.org/10.1145%2F3131280) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20heat%20method%20for%20distance%20computation&journal=Commun.%20ACM&doi=10.1145%2F3131280&volume=60&pages=90-99&publication_year=2017&author=Crane%2CK&author=Weischedel%2CC&author=Wardetzky%2CM)

[^22]: Zhang, T., Rosenberg, M., Jing, Z., Perona, P. & Meister, M. Endotaxis: A neuromorphic algorithm for mapping, goal-learning, navigation, and patrolling. *eLife* **12**, RP84141 (2023).

[^23]: Thrun, S. & Montemerlo, M. The Graph SLAM algorithm with applications to large-scale mapping of urban structures. *Int. J. Robot. Res.* **25**, 403–429 (2006).

[Article](https://doi.org/10.1177%2F0278364906065387) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20Graph%20SLAM%20algorithm%20with%20applications%20to%20large-scale%20mapping%20of%20urban%20structures&journal=Int.%20J.%20Robot.%20Res.&doi=10.1177%2F0278364906065387&volume=25&pages=403-429&publication_year=2006&author=Thrun%2CS&author=Montemerlo%2CM)

[^24]: Mur-Artal, R. & Tardós, J. D. Visual-inertial monocular SLAM with map reuse. *IEEE Robot. Autom. Lett.* **2**, 796–803 (2017).

[^25]: Mourikis, A. I. & Roumeliotis, S. I. A multi-state constraint Kalman filter for vision-aided inertial navigation. In *Proc. 2007 IEEE International Conference on Robotics and Automation* 3565–3572 (IEEE, 2007).

[^26]: Lynen, S. et al. Get out of my lab: large-scale, real-tme visual-inertial localization. In *Proc. Robotics: Science and System XI* (eds Kavraki, L. E., Hsu, D. & Buchli, J.) (RSS, 2015); [https://doi.org/10.15607/RSS.2015.XI.037](https://doi.org/10.15607/RSS.2015.XI.037)

[^27]: Gupta, S. et al. Cognitive mapping and planning for visual navigation. In *Proc.* *2017 IEEE Conference on Computer Vision and Pattern Recognition (CVPR)* 7272–7281 (IEEE, 2017).

[^28]: Mirowski, P. et al. Learning to navigate in cities without a map. In *Proc. 32nd International Conference on Neural Information Processing Systems* (eds Bengio, S. & Wallach, H.M.) 2424–2435 (Curran Associates, Inc., 2018).

[^29]: Duan, Y. et al. RL <sup>2</sup>: fast reinforcement learning via slow reinforcement learning. Preprint at [https://doi.org/10.48550/arXiv.1611.02779](https://doi.org/10.48550/arXiv.1611.02779) (2016).

[^30]: Higgins, I. et al. DARLA: improving zero-shot transfer in reinforcement learning. In *Proc. 34th International Conference on Machine Learning* (eds Precup, D. & Teb, Y. W.) 1480–1490 (PMLR, 2017); [https://proceedings.mlr.press/v70/higgins17a.html](https://proceedings.mlr.press/v70/higgins17a.html)

[^31]: Seo, Y., Lee, K., James, S. L. & Abbeel, P. Reinforcement learning with action-free pre-training from videos. In *Proc. 39th International Conference on Machine Learning* (eds Chaudhuri, K. et al.) 19561–19579 (PMLR, 2022); [https://proceedings.mlr.press/v162/seo22a.html](https://proceedings.mlr.press/v162/seo22a.html)

[^32]: Lee, T. S. & Mumford, D. Hierarchical Bayesian inference in the visual cortex. *JOSA A* **20**, 1434–1448 (2003).

[Article](https://doi.org/10.1364%2FJOSAA.20.001434) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Hierarchical%20Bayesian%20inference%20in%20the%20visual%20cortex&journal=JOSA%20A&doi=10.1364%2FJOSAA.20.001434&volume=20&pages=1434-1448&publication_year=2003&author=Lee%2CTS&author=Mumford%2CD)

[^33]: Mumford, D. in *First European Congress of Mathematics. Progress in Mathematics* Vol. 3 (eds Joseph, A. et al.) 187–224 (Springer, 1994).

[^34]: Rao, R. P. N. & Ballard, D. H. Predictive coding in the visual cortex: a functional interpretation of some extra-classical receptive-field effects. *Nat. Neurosci.* **2**, 79–87 (1999).

[Article](https://doi.org/10.1038%2F4580) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Predictive%20coding%20in%20the%20visual%20cortex%3A%20a%20functional%20interpretation%20of%20some%20extra-classical%20receptive-field%20effects&journal=Nat.%20Neurosci.&doi=10.1038%2F4580&volume=2&pages=79-87&publication_year=1999&author=Rao%2CRPN&author=Ballard%2CDH)

[^35]: Poincaré, H. *The Foundations of Science: Science and Hypothesis, the Value of Science, Science and Method* (Cambridge Univ. Press, 2015).

[^36]: O’Keefe, J. & Nadel, L. *The Hippocampus as a Cognitive Map* (Clarendon Press, Oxford Univ. Press, 1978).

[^37]: Thrun, S., Burgard, W. & Fox, D. *Probabilistic Robotics* (MIT Press, 2005).

[^38]: Stachenfeld, K. L., Botvinick, M. M. & Gershman, S. J. The hippocampus as a predictive map. *Nat. Neurosci.* **20**, 1643–1653 (2017).

[Article](https://doi.org/10.1038%2Fnn.4650) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20hippocampus%20as%20a%20predictive%20map&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.4650&volume=20&pages=1643-1653&publication_year=2017&author=Stachenfeld%2CKL&author=Botvinick%2CMM&author=Gershman%2CSJ)

[^39]: Recanatesi, S. et al. Predictive learning as a network mechanism for extracting low-dimensional latent space representations. *Nat. Commun.* **12**, 1417 (2021).

[Article](https://doi.org/10.1038%2Fs41467-021-21696-1) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Predictive%20learning%20as%20a%20network%20mechanism%20for%20extracting%20low-dimensional%20latent%20space%20representations&journal=Nat.%20Commun.&doi=10.1038%2Fs41467-021-21696-1&volume=12&publication_year=2021&author=Recanatesi%2CS)

[^40]: Fang, C., Aronov, D., Abbott, L. & Mackevicius, E. L. Neural learning rules for generating flexible predictions and computing the successor representation. *eLife* **12**, e80680 (2023).

[Article](https://doi.org/10.7554%2FeLife.80680) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20learning%20rules%20for%20generating%20flexible%20predictions%20and%20computing%20the%20successor%20representation&journal=eLife&doi=10.7554%2FeLife.80680&volume=12&publication_year=2023&author=Fang%2CC&author=Aronov%2CD&author=Abbott%2CL&author=Mackevicius%2CEL)

[^41]: Dayan, P., Hinton, G. E., Neal, R. M. & Zemel, R. S. The Helmholtz machine. *Neural Comput.* **7**, 889–904 (1995).

[Article](https://doi.org/10.1162%2Fneco.1995.7.5.889) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20Helmholtz%20machine&journal=Neural%20Comput.&doi=10.1162%2Fneco.1995.7.5.889&volume=7&pages=889-904&publication_year=1995&author=Dayan%2CP&author=Hinton%2CGE&author=Neal%2CRM&author=Zemel%2CRS)

[^42]: Luttrell, S. P. A Bayesian analysis of self-organizing maps. *Neural Comput.* **6**, 767–794 (1994).

[Article](https://doi.org/10.1162%2Fneco.1994.6.5.767) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20Bayesian%20analysis%20of%20self-organizing%20maps&journal=Neural%20Comput.&doi=10.1162%2Fneco.1994.6.5.767&volume=6&pages=767-794&publication_year=1994&author=Luttrell%2CSP)

[^43]: Tu, L. W. *Differential Geometry: Connections, Curvature, and Characteristic Classes* 1st edn (Springer, 2017).

[^44]: Johnson, M., Hofmann, K., Hutton, T. & Bignell, D. The Malmo platform for artificial intelligence experimentation. In *Proc. Twenty-Fifth International Joint Conference on Artificial Intelligence* (ed. Brewka, G.) 4246–4247 (AAAI Press, 2016).

[^45]: He, K., Zhang, X., Ren, S. & Sun, J. Deep residual learning for image recognition. In *Proc.* *2016 IEEE Conference on Computer Vision and Pattern Recognition (CVPR)* 770–778 (IEEE, 2016).

[^46]: Ronneberger, O., Fischer, P. & Brox, T. U-Net: convolutional networks for biomedical image segmentation. In *Medical Image Computing and Computer-Assisted Intervention (MICCAI 2015)* (eds Navab, N. et al.) 234–241 (Springer International Publishing, 2015).

[^47]: Vaswani, A. et al. Attention is all you need. In *Proc. 31st International Conference on Neural Information Processing Systems* (eds Von Luxburg, U. et al.) 5999–6009 (Curran Associates, Inc., 2017).

[^48]: Sutskever, I., Martens, J., Dahl, G. & Hinton, G. On the importance of initialization and momentum in deep learning. In *Proc. 30th International Conference on Machine Learning* (eds Dasgupta, S. & McAllester, D.) 1139–1147 (PMLR, 2013); [https://proceedings.mlr.press/v28/sutskever13.html](https://proceedings.mlr.press/v28/sutskever13.html)

[^49]: Smith, L. N. & Topin, N. Super-convergence: very fast training of neural networks using large learning rates. Preprint at [https://doi.org/10.48550/arXiv.1708.07120](https://doi.org/10.48550/arXiv.1708.07120) (2018).

[^50]: Tenenbaum, J. B., de Silva, V. & Langford, J. C. A global geometric framework for nonlinear dimensionality reduction. *Science* **290**, 2319–2323 (2000).

[Article](https://doi.org/10.1126%2Fscience.290.5500.2319) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20global%20geometric%20framework%20for%20nonlinear%20dimensionality%20reduction&journal=Science&doi=10.1126%2Fscience.290.5500.2319&volume=290&pages=2319-2323&publication_year=2000&author=Tenenbaum%2CJB&author=Silva%2CV&author=Langford%2CJC)

[^51]: Bush, D., Barry, C., Manson, D. & Burgess, N. Using grid cells for navigation. *Neuron* **87**, 507–520 (2015).

[Article](https://doi.org/10.1016%2Fj.neuron.2015.07.006) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Using%20grid%20cells%20for%20navigation&journal=Neuron&doi=10.1016%2Fj.neuron.2015.07.006&volume=87&pages=507-520&publication_year=2015&author=Bush%2CD&author=Barry%2CC&author=Manson%2CD&author=Burgess%2CN)

[^52]: Rosenthal, I. A. et al. S1 represents multisensory contexts and somatotopic locations within and outside the bounds of the cortical homunculus. *Cell Rep.* **42**, 112312 (2023).

[Article](https://doi.org/10.1016%2Fj.celrep.2023.112312) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=S1%20represents%20multisensory%20contexts%20and%20somatotopic%20locations%20within%20and%20outside%20the%20bounds%20of%20the%20cortical%20homunculus&journal=Cell%20Rep.&doi=10.1016%2Fj.celrep.2023.112312&volume=42&publication_year=2023&author=Rosenthal%2CIA)

[^53]: Behrens, T. E. J. et al. What is a cognitive map? Organizing knowledge for flexible behavior. *Neuron* **100**, 490–509 (2018).

[Article](https://doi.org/10.1016%2Fj.neuron.2018.10.002) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=What%20is%20a%20cognitive%20map%3F%20Organizing%20knowledge%20for%20flexible%20behavior&journal=Neuron&doi=10.1016%2Fj.neuron.2018.10.002&volume=100&pages=490-509&publication_year=2018&author=Behrens%2CTEJ)

[^54]: Brown, T. et al. Language models are few-shot learners. In *Proc. 33rd International Conference on Neural Information Processing Systems* (eds Larochelle, H. et al.) 1877–1901 (Curran Associates, Inc., 2020).

[^55]: Gornet, J. jgornet/predictive-coding-recovers-maps: Nature Machine Intelligence pre-release. *Zenodo* [https://doi.org/10.5281/zenodo.11287439](https://doi.org/10.5281/zenodo.11287439) (2024).