---
title: "KAN-ODEs: Kolmogorov-Arnold Network Ordinary Differential Equations for Learning Dynamical Systems and Hidden Physics"
source: "https://arxiv.org/html/2407.04192v1"
author:
published:
created: 2026-06-19
description:
tags:
  - "clippings"
---
<sup>†</sup> <sup>†</sup>

Benjamin C. Koenig Department of Mechanical Engineering, Massachusetts Institute of Technology, 77 Massachusetts Ave, Cambridge, MA 02139, United States.    Suyong Kim Department of Mechanical Engineering, Massachusetts Institute of Technology, 77 Massachusetts Ave, Cambridge, MA 02139, United States.    Sili Deng [Corresponding author, silideng@mit.edu](mailto:Corresponding%20author,%20silideng@mit.edu) Department of Mechanical Engineering, Massachusetts Institute of Technology, 77 Massachusetts Ave, Cambridge, MA 02139, United States.

###### Abstract

Kolmogorov-Arnold Networks (KANs) as an alternative to Multi-layer perceptrons (MLPs) are a recent development demonstrating strong potential for data-driven modeling. This work applies KANs as the backbone of a Neural Ordinary Differential Equation framework, generalizing their use to the time-dependent and grid-sensitive cases often seen in scientific machine learning applications. The proposed KAN-ODEs retain the flexible dynamical system modeling framework of Neural ODEs while leveraging the many benefits of KANs, including faster neural scaling, stronger interpretability, and lower parameter counts when compared against MLPs. We demonstrate these benefits in three test cases: the Lotka-Volterra predator-prey model, Burgers’ equation, and the Fisher-KPP PDE. We showcase the strong performance of parameter-lean KAN-ODE systems generally in reconstructing entire dynamical systems, and also in targeted applications to the inference of a source term in an otherwise known flow field. We additionally demonstrate the interpretability of KAN-ODEs via activation function visualization and symbolic regression of trained results. The successful training of KAN-ODEs and their improved performance when compared to traditional Neural ODEs implies significant potential in leveraging this novel network architecture in myriad scientific machine learning applications.

## I Introduction

Dynamical system modeling is a key part of many branches of engineering and science. The development of data-driven approaches to infer models and laws that govern these systems is a major task in many fields and has given rise to numerous machine learning and neural network-based techniques. These techniques often have a tradeoff between the amount of prior knowledge embedded in the model versus the interpretability of the model: purely data-driven approaches tend to lack interpretability, and conversely interpretable methods typically require substantial knowledge or enforcement of preexisting governing laws. Novel methods that bridge this gap have the potential to not only infer high-accuracy models from data, but also provide useful insight into the dynamics of what are often unknown physical processes.

Neural Ordinary Differential Equations (Neural ODEs) based on multilayer perceptrons (MLPs) [^1] [^2] [^3] couple black box neural networks used as gradient getters with standard ODE solvers in order to learn the relationship between the current state of a system and its gradient. Originally proposed as an augmentation to the effectively fixed step sizes in residual neural networks used for general-purpose deep learning, Neural ODEs have also seen substantial use in engineering and scientific modeling thanks to their natural inclination for pairing with dynamical system solvers. By mapping the current state onto its gradients, Neural ODEs are inherently grid and timescale flexible, allowing for substantial interpolation and generalization of learned models compared with fixed-grid regression. Neural ODEs do not require prior knowledge of a system in order to infer dynamical models from large datasets thanks to their use of black box MLPs, though on the flip side of this benefit they typically deliver models with thousands to millions of parameters, making any deeper interpretation or extraction of physical insights difficult.

Physics-Informed Neural Networks (PINNs) [^4] [^5] [^6] are another key technique often used for machine learning based modeling of dynamical systems. This approach directly leverages the governing laws of a given system in the loss function of a neural network, allowing for training that not only aims to fit the training data but also aims to fit the known governing equations without having to directly solve what are typically expensive PDEs. These networks are significantly interpretable thanks to the governing equations used as a soft constraint in the training cycle, giving physical meaning to trends and patterns that emerge from the training process. They additionally typically require less training data than alternative black-box approaches, thanks to the significant amount of knowledge imparted by the governing equations. A recently developed approach with a similar incorporation of known physics is the Chemical Reaction Neural Network (CRNN) [^7], which combines the efficient parameter optimization of Neural ODEs with a hard constraint on the system’s adherence to known physical laws. This allows the CRNN to move away from black-box style approaches and instead directly learn the system’s governing equation parameters from real [^8] [^9] and noisy [^10] [^11] experimental data. A downside of these physics informed and physics enforced techniques is their requirement of strong prior knowledge of the system’s governing laws. In cases where such knowledge is not available, other methods are required.

The SINDy approach (Sparse Identification of Nonlinear Dynamics) [^12] [^13] [^14] [^15] tackles dynamical system modeling via sparse regression. In terms of prior knowledge and interpretability it appears to operate between Neural ODEs and physics-driven methods. Given training data and a set of candidate functions (polynomials, trigononometric functions, constant functions, etc.), it carries out sparse regression to parsimoniously select only the candidate functions needed to describe trends present in the data. The use of a presumed set of candidate functions gives SINDy models significant interpretability over pure black box methods like MLPS or Neural ODEs, while requiring less of the detailed physical knowledge behind the system dynamics as in physics-informed methods such as PINN and CRNN. This presumed set of candidate functions additionally often allows SINDy to train using significantly less data than traditional neural network approaches.

Kolmogorov-Arnold Networks (KANs) [^16] are a recent development proposing an alternative to MLP-based networks. Instead of fixed activation functions with variable weights and biases, the activation functions themselves are made up of gridded basis functions, the scaling factors of which are trained in order to fit the data. Major selling points of KANs over MLPs are increased interpretability thanks to the direct learning of activation functions, faster convergence to low training loss with significantly fewer parameters thanks to their faster neural scaling laws, and the possibility of postprocessing via sparse regression to delivery SINDy-esque symbolic functions mapping the inputs to outputs. Unlike SINDy, however, these symbolic functions are not a presumed condition of training, and are instead an optional and modular postprocessing component, giving KANs greater flexibility and applicability to general use cases, which may benefit from black-box style models, symbolic function-based models, or even a combination of both. KANs have been extended to include time series predictions [^17] [^18] by directly mapping training data onto a future testing window. While these extensions allow for consideration of complex multivariate effects and concept drift, their rigid structure and direct treatment of fixed batches of data restricts their generalization outside of the explicit problem formulation under which they were trained.

Here, we introduce the possibility of learning interpretable and modular ODE and PDE models for dynamical systems without prior knowledge or functional form assumptions by leveraging KANs as gradient-getters within the concept of Neural ODEs. In doing so, we propose a combined framework that benefits from the high-accuracy, parameter-learn, and strongly interpretable KAN network structure coupled with the general-purpose, grid-independent, and solver-flexible Neural ODE framework, A qualitative depiction of the comparison between the currently-proposed KAN-ODE method and the other discussed data-driven approaches for dynamical system modeling is shown in Fig. 1. While the current state of the art is generally situated on the diagonal of this plot, where increased prior knowledge fed into a machine learning method delivers better interpretability, we place KAN-ODEs slightly below the diagonal, thanks to their potential to deliver interpretable activations and even symbolic relationships without requiring prior knowledge or presumed functional forms in the training cycle. The ODE-based formulation is also inherently flexible, allowing for variable timesteps depending on the gradient landscape as well as application of the KAN-ODE as a component of a larger-scale model, for example as the source term in a nonlinear transport PDE.

![Refer to caption](https://arxiv.org/html/2407.04192v1/x1.png)

Figure 1: Qualitative depiction of KAN-ODE’s general capability compared to similar machine learning techniques.

## II Methodology

The formulation proposed here leverages KANs and the neural network-ODE solver concept of Neural ODEs. Sec. II.1 introduces the concept of a KAN. Then, we describe how we couple KANs to differentiable ODE solvers to model dynamical systems in Sec. II.2.

### II.1 Kolmogorov Arnold Networks as Gradient Evaluators

In contrast to MLPs based on the universal approximation theorem [^19], KANs [^16] are based on the Kolmogorov-Arnold representation theorem (KAT) [^20], which states that any multivariate function $f(\textbf{x}):[0,1]^{n}\rightarrow\mathbb{R}$ that is continuous and smooth can be represented by a finite sum of continuous univariate functions,

$$
f(\textbf{x})=f(x_{1},...,x_{n})=\sum_{q=1}^{2n+1}\Phi_{q}\left(\sum_{p=1}^{n}%
\phi_{q,p}(x_{p})\right).
$$

Here, $\phi_{q,p}:~{}[0,1]\rightarrow\mathbb{R}$ are univariate functions, while $\Phi_{q}:\mathbb{R}\rightarrow\mathbb{R}$ composes these univariate functions to reconstruct $f(\textbf{x})$. The implementation in this work defines $\Phi_{q}$ as trainable weights to sum the univariate basis functions. Once these basis functions are chosen, Eq. 1 exactly describes a 2-layer KAN with hidden layer width of $2n+1$ (the upper bound of the outer summation in Eq. 1) and an output dimension of 1. The KAT is extended to a general KAN structure with $L$ layers of arbitrary width by exploiting the hierarchical structure of Eq. 1 [^16].

$$
\mathbf{y}={\text{KAN}}(\mathbf{x})=\left({\Phi}_{L-1}\circ{\Phi}_{L-2}\circ%
\cdots\circ{\Phi}_{1}\circ{\Phi}_{0}\right)\left(\mathbf{x}\right).
$$
 
$$
{\Phi}_{l}=\begin{pmatrix}\phi_{l,1,1}(\cdot)&\phi_{l,1,2}(\cdot)&\cdots&\phi_%
{l,1,n_{l}}(\cdot)\\
\phi_{l,2,1}(\cdot)&\phi_{l,2,2}(\cdot)&\cdots&\phi_{l,2,n_{l}}(\cdot)\\
\vdots&\vdots&&\vdots\\
\phi_{l,n_{l+1},1}(\cdot)&\phi_{l,n_{l+1},2}(\cdot)&\cdots&\phi_{l,n_{l+1},n_{%
l}}(\cdot)\\
\end{pmatrix}
$$

where $\phi$ is the activation function, $l$ is the index of a layer, $n_{l}$ and $n_{l+1}$ denote the numbers of nodes in the $l^{\text{th}}$ and $(l+1)^{\text{th}}$ layers, respectively. While Liu et al. [^16] proposed a B-spline for this basis function, this study adopts the more computationally efficient Gaussian radial basis functions $\psi$ as proposed by Li [^21], such that

$$
\displaystyle\phi_{l,\alpha,\beta}\left(\text{x}\right)
$$
 
$$
\displaystyle=\sum_{i=1}^{N}w^{r}_{l,\alpha,\beta,i}\cdot\psi\left(\lvert%
\lvert\text{x}-c_{i}\rvert\rvert\right)+w^{b}_{l,\alpha,\beta}\cdot b\left(%
\text{x}\right),
$$
$$
\displaystyle\psi(r)
$$
 
$$
\displaystyle=\exp(-\frac{r^{2}}{2h^{2}}),
$$

where $N$ is the number of gridpoints, $w^{r}_{l,\alpha,\beta,i}$ and $w^{b}_{l,\alpha,\beta}$ are the trainable weights for the RBF function $\psi(r)$ and the base activation function $b(\text{x})$ respectively (superscripts indicating which function the weights apply to), the subscripts $[\alpha,\beta]$ indicate the index of the matrix in Eq. 3 within a KAN layer $l$ that these weights apply to, $c_{i}$ is the center of the $i$ -th RBF function, $r$ is the distance of x from the center, and $h$ is a spreading parameter defined as the gridpoint spacing. The inputs to each layer are normalized to be on the \[-1, 1\] gridded RBF domain as in [^22], which avoids the costly alternative technique of [^21] that requires periodically re-gridding the RBF networks in each layer to match the input domain. In addition to fully gridded RBF basis functions, the inputs and outputs of each layer are also directly connected with Swish residual activation functions such that $b(\text{x})=\text{x}\cdot\text{sigmoid}(\text{x})$ [^23].

This discussion highlights the two input pathways for each layer: the RBF function on a grid of size N, and the direct (non-gridded) residual activations. The total number of parameters in the fully connected RBF pathway for a single layer is equal to the product of the input dimension, grid size, and output dimension (following from $w^{r}_{l,\alpha,\beta,i}$). The residual activation pathway has parameter count equal to just the product of the input and output dimensions (following from $w^{b}_{l,\alpha,\beta}$). For example, in a 2-layer KAN with a 2D input, 1D output, 10D hidden layer, and 5-point grid, the total number of parameters is \[(2 $\times$ 5 $\times$ 10+2 $\times$ 10)+(10 $\times$ 5 $\times$ 1+10 $\times$ 1)\]=180, when accounting for one $2\rightarrow 10$ layer and one $10\rightarrow 1$ layer in the two parenthetical terms, respectively. Expanded mathematical formulations for deep KANs and KANs with multivariate outputs become increasingly bulky and cumbersome, and are available in the extensive [^16]. For convenience, we use the notation \[$n_{l},n_{l+1},N$\] to represent an $l$ -th KAN layer for the remainder of this work, where $n_{l}$ is the input dimension, $n_{l+1}$ is the output dimension, and $N$ is the grid size. For example, a 2-input and 1-output KAN with a 10-node hidden layer and a 5-point grid is represented as a \[2, 10, 5\], \[10, 1, 5\].

### II.2 KAN-Ordinary Differential Equations

A dynamical system is generally expressed by an ODE system such that

$$
\frac{d\mathbf{u}}{dt}=\mathbf{g}\left(\mathbf{u},t\right).
$$

where $\mathbf{u}\in\mathbb{R}^{n}$ is a vector of the state variables and $\mathbf{g}$ is the system equation. Chen et al. [^1] previously proposed neural ordinary differential equations with the help of the universal approximation theorem (UAT) and the adjoint sensitivity method to construct a model NN such that $\text{NN}\approx\mathbf{g}$. We similarly adopt the recently developed KAN as an approximator for a dynamical system by leveraging the benefits of the Kolmogorov-Arnold representation theorem (KAT). The proposed KAN-ODEs can be expressed as

$$
\frac{d\mathbf{u}}{dt}=\text{KAN}\left(\mathbf{u}\left(t\right),\bm{\theta}%
\right),
$$

where $\bm{theta}$ is the collection of all trainable weights in the KAN. Here, the input and output dimensions of the KAN are fixed as the dimension of the state variables $\mathbf{u}$, and it is used as a gradient getter. Eq. 7 can be solved using a traditional ODE solver from an initial time $t_{0}$ to a desired time $t$ such that

$$
\mathbf{u}(t)=\mathbf{u}_{0}+\int_{t_{0}}^{t}{\text{KAN}\left(\mathbf{u}\left(%
\tau\right),\bm{\theta}\right)d\tau},
$$

where $\mathbf{u}_{0}$ is the initial condition at $t_{0}$.

To train the KAN model, we define the loss function as the mean squared error

$$
\displaystyle\mathcal{L}\left(\bm{\theta}\right)
$$
 
$$
\displaystyle=\text{MSE}\left(\mathbf{u}^{\text{KAN}}\left(t,\bm{\theta}\right%
),\mathbf{u}^{\text{obs}}\left(t\right)\right)
$$
 
$$
\displaystyle=\frac{1}{N}\sum_{i=1}^{N}{\lvert\lvert\mathbf{u}^{\text{KAN}}%
\left(t_{i},\bm{\theta}\right)-\mathbf{u}^{\text{obs}}\left(t_{i}\right)\rvert%
\rvert^{2}},
$$

where $\mathbf{u}^{\text{KAN}}$ is the prediction, $\mathbf{u}^{\text{obs}}$ is the observation, and $N$ is the total number of time steps. To optimize $\mathcal{L}$, we require gradients with respect to $\bm{\theta}$. Generally, two options are available with the forward sensitivity method and the adjoint sensitivity method. In this paper, the adjoint sensitivity method is adopted to efficiently handle a potentially large Kolmogorov-Arnold network [^24] [^2] [^1] thanks to its more advantageous scaling with model size. By introducing an adjoint state variable $\bm{\omega}$, the augmented system equation can be derived, which allows for gradient backpropagation through the ODE integrators.

$$
\frac{d}{dt}\left[\begin{array}[]{c}\mathbf{z}\\
\bm{\omega}\\
\frac{\partial\mathcal{L}}{\partial\bm{\theta}}\end{array}\right]=-\left[%
\begin{array}[]{ccc}1&\bm{\omega}^{T}&\bm{\omega}^{T}\end{array}\right]\left[%
\begin{array}[]{ccc}g&\frac{\partial g}{\partial\mathbf{z}}&\frac{\partial g}{%
\partial\bm{\theta}}\\
0&0&0\\
0&0&0\end{array}\right],
$$

where $\mathbf{z}(t)=\mathbf{u}(-t)$, $g=\text{KAN}$, and $T$ denotes the transpose. After Eq. 10 is computed, $\bm{\theta}$ is updated using a gradient descent method. A schematic depicting the overall training cycle is provided in Fig. 2.

This study implements KAN-ODEs in the Julia scientific machine learning ecosystem including packages such as DifferentialEquations.jl [^25], Lux.jl [^26], KomolgorovArnold.jl [^22], and Zygote.jl. Unless otherwise specified, we employed the ODE integrator of `Tsit5` (Tsitouras 5/4 Runge-Kutta method [^27]) and the optimizer of `ADAM` [^28]. In addition, we constructed KANs with RBF basis functions and Swish residual activation functions.

![Refer to caption](https://arxiv.org/html/2407.04192v1/extracted/5708852/schematic_general.png)

Figure 2: Schematic depicting the overall training cycle of a KAN-ODE. The inner loop in green leverages a KAN as a temporal gradient getter for the state vector to solve the ODE forward. Once a solution is generated, the outer blue loop computes the gradient of the loss function via the adjoint method to update the KAN activation functions.

## III Experiments

We present three applications in this work to demonstrate the capability of KAN-ODEs. We validate our methodology and compare its performance against the standard MLP-based Neural ODE in Sec. III.1, where the dynamics of the Lotka-Volterra predator-prey model are inferred. Then, we tackle a one-dimensional PDE in Sec. III.2, using a KAN-ODE to infer a symbolic source term in a wave propagation simulation. This example demonstrates the flexibility of KAN-ODEs to be used as submodels in higher complexity simulations, as well as their capability to extract symbolic models from data. Finally, we learn the dynamics of the one-dimensional Burgers’ equation via a KAN-ODE to demonstrate its larger-scale capability as a standalone solver.

### III.1 KAN-ODEs vs Neural ODEs: Lotka-Volterra

In this section, we target the Lotka-Volterra predator-prey model shown in Eq. 11. We replicate the simulation parameters used in the Neural ODE study of [^3]. Namely, we use $\alpha=1.5$, $\beta=1$, $\gamma=1$, and $\delta=3$ with an initial condition of $\mathbf{u}_{0}=[x_{0},y_{0}]=[1,1]$ and a time span of $t\in[0,14]$ s. The first 3.5 s are used to train the KAN-ODE, while the remainder of the time history is withheld to validate the KAN-ODE’s ability to extrapolate to unseen times. The temporal grid used for training and loss evaluation has a spacing of 0.1s. The inputs to each KAN layer in this example are normalized to be on the $[-1,1]$ range required by the RBF networks via the hyperbolic tangent function, as in [^22]. Training data is shown in Fig. 3(A).

$$
\displaystyle\frac{dx}{dt}
$$
 
$$
\displaystyle=\alpha x-\beta xy,
$$
$$
\displaystyle\frac{dy}{dt}
$$
 
$$
\displaystyle=\gamma xy-\delta y.
$$

Loss profiles from training a 240-parameter KAN-ODE of shape \[2, 10, 5\], \[10, 2, 5\] are shown in Fig. 3(B1). Strong convergence is observed as early as $2\times 10^{4}$ epochs into training, while convergence into the $10^{-7}$ range of MSE loss occurs toward $10^{5}$ epochs. On a single CPU core, training a KAN of this size takes roughly 20 minutes per $10^{4}$ epochs. The converged KAN-ODE prediction is shown in Fig. 3(A), where the agreement in the testing window (t=3.5:14) is nearly indistinguishable from the agreement in the training window (t=0:3.5), and both exhibit excellent adherence to the synthetic data. We remark again that the trained KAN-ODE is reconstructing both the seen training data and unseen testing data from only the initial condition ($\mathbf{u}_{0}=[1,1]$), and can deliver output values on any grid and at any time, thanks to its coupling to an ODE solver.

![Refer to caption](https://arxiv.org/html/2407.04192v1/extracted/5708852/LV.png)

Figure 3: Comparison between KAN-ODE and Neural ODE for L-V predator-prey model. (A) Synthetic data (training and testing) and KAN-ODE reconstruction. (B) Loss profile during training for (B1) KAN-ODE and (B2) MLP-based Neural ODE of comparable sizes (240 and 252, respectively). (C) Comparison of converged KAN-ODE and Neural ODE error using different model sizes, and two MLP depths (d=2 and d=3). Neural scaling rates of N − 2 superscript 𝑁 N^{-2} italic\_N start\_POSTSUPERSCRIPT - 2 end\_POSTSUPERSCRIPT and 4 N^{-4} italic\_N start\_POSTSUPERSCRIPT - 4 end\_POSTSUPERSCRIPT plotted for comparison, as per the theory in 21. (D) KAN of 4 hidden layers used to learn L-V dynamics (80 parameters)

Table 1: Lotka-Volterra Network Sizes and Performance

|  | Depth | Layer width | Grid size | Activation Function | No. Params | Train loss |
| --- | --- | --- | --- | --- | --- | --- |
| Neural ODE (MLP) | 2 | 10 | N/a | tanh | 52 | $4.7\times 10^{-4}$ |
|  | 2 | 50 | N/a | tanh | 252 | $\mathbf{4.1\times 10^{-5}}$ |
|  | 2 | 100 | N/a | tanh | 502 | $1.6\times 10^{-5}$ |
|  | 3 | 3 | N/a | tanh | 29 | $2.0\times 10^{-4}$ |
|  | 3 | 5 | N/a | tanh | 57 | $2.6\times 10^{-4}$ |
|  | 3 | 8 | N/a | tanh | 114 | $4.6\times 10^{-5}$ |
|  | 3 | 10 | N/a | tanh | 162 | $3.7\times 10^{-5}$ |
|  | 3 | 20 | N/a | tanh | 522 | $3.0\times 10^{-5}$ |
| KAN-ODE | 2 | 4 | 3 | learned | 64 | $1.4\times 10^{-4}$ |
|  | 2 | 4 | 4 | learned | 80 | $5.2\times 10^{-5}$ |
|  | 2 | 4 | 5 | learned | 96 | $1.2\times 10^{-4}$ |
|  | 2 | 6 | 4 | learned | 120 | $1.9\times 10^{-5}$ |
|  | 2 | 6 | 5 | learned | 144 | $1.6\times 10^{-5}$ |
|  | 2 | 10 | 5 | learned | 240 | $\mathbf{8.3\times 10^{-7}}$ |
|  | 2 | 20 | 5 | learned | 480 | $6.6\times 10^{-7}$ |
|  | 2 | 40 | 5 | learned | 960 | $6.1\times 10^{-7}$ |

To benchmark the KAN-ODE performance, testing was also carried out using a standard, MLP-based Neural ODE. In this case, the network size and training procedure were taken from the Neural ODE work of [^3], to avoid biasing the results in the KAN-ODE’s favor. Namely, an MLP with a hidden layer comprising 50 nodes and the hyperbolic tangent activation function replaced the KAN in Eq. 7. Other relevant training details such as the train/test time windows, temporal grid, Lotka-Volterra equation parameters, and ODE solver remain identical to the KAN-ODE example, which itself was modeled as directly as possible after the Neural ODE efforts of [^3]. The MLP defined here contains 252 trainable parameters (refer to the bold architecture in Table 1), which is comparable (and in fact slightly larger) than the 240 used in the reported KAN-ODE.

The Neural ODE iterates roughly three times faster than the similarly-sized KAN-ODE, taking closer to 7 minutes per $10^{4}$ epochs on the same single CPU core. However, it achieves a minimum of $3\times 10^{-5}$ training error over $10^{5}$ epochs, which is not as low as the $2.6\times 10^{-5}$ achieved by the KAN-ODE in just $10^{4}$ epochs, and nearly two orders of magnitude worse than the $8.3\times 10^{-7}$ training error achieved by the KAN-ODE in the same $10^{5}$ epochs. We remark that $3\times 10^{-5}$ is already a remarkably low amount of training error, and in fact do not add Neural ODE profiles to the plot in Fig. 3(A) as they would be nearly impossible to distinguish from the KAN-ODE profiles. We retain discussion of loss metrics, however, as the distinctions and comparisons made here are likely to be indicative of similar performance metrics in larger-scale, more complex problems that are not as straightforward to fit with such strong accuracy.

The Neural ODE model qualitatively appears to overfit less than the KAN-ODE, especially in the later epochs. Quantitatively, however, the KAN-ODE still beats the MLP-based Neural ODE in accuracy to the unseen testing data. Even in the last 10% of the training cycle, i.e. epochs $90,000-100,000$, where the KAN-ODE appears to overfit substantially, it still achieves an average testing loss of $6.8\times 10^{-3}$, with a minimum value in that range of $1.9\times 10^{-5}$. The Neural ODE in this same range averages a much larger $1.4\times 10^{-2}$, with a minimum value of $5.4\times 10^{-5}$. If training for the KAN-ODE is stopped early at $2\times 10^{4}$ epochs when the testing error just begins to creep upward, these statistics tend even more strongly in its favor.

In this 1-to-1 comparison, we demonstrated that in a data generation and training regime borrowed from a well-cited Neural ODE work, our proposed KAN-ODE beats the performance of the Neural ODE in all key metrics. The apparent benefit of the Neural ODE’s faster iteration is rendered ineffective due to the KAN’s convergence to lower training and testing loss values in a short enough number of epochs to outscale the speedup of the MLP-based Neural ODE. We further study scaling effects in Fig. 3(C), where we present the converged training losses achieved by KAN-ODE and Neural ODEs of variable sizes. The KAN-ODEs larger than that studied above simply had wider hidden layers, while those smaller had narrower hidden layers as well as sparser grids. MLP-based Neural ODEs at each depth simply had more or fewer nodes in each hidden layer. Some larger Neural ODEs and smaller KAN-ODEs had their learning rates increased from the baseline value of $10^{-3}$ to avoid getting stuck in local minima. When comparing these KAN-ODEs and Neural ODEs of varying sizes, the benefit of the KAN-ODE becomes even more clear. Even with the modified RBF basis function, we appear to capture the $N^{-4}$ convergence rate of the third-order B-spline KAN proposed in [^21], while the two MLP models appear to be converging at or even under an $N^{-2}$ rate. We see in fact that with even just the 240 KAN parameters studied in Figs. 3(A) and 3(B1) we are able to run the fourth-order convergence to saturation (larger KANs see no substantial performance gain), while traditional Neural ODEs would theoretically require upwards of thousands or even tens of thousands of parameters to reach similar performance, if they do not plateau earlier. The specific model sizes used in this convergence test are shown in Table 1, where the models used for Figs. 3(A) and 3(B1-B2) are in bold. Finally, we visualize the 80-parameter \[2, 4, 4\], \[4, 2, 4\] KAN-ODE’s activation functions in Fig. 3(D). We hypothesize based on certain similarities seen in these functions (i.e the three similar input activations coming from $x$), as well as the relatively sparse model of Eq. 11, that this KAN could be sparsified effectively for further interpretability. We further investigate sparse KANs and symbolic regression in Sec. III.2. In this example, we systematically explored the use of KAN-ODEs in a fairly simple ODE system and benchmarked their performance against comparable MLP-based Neural ODEs. We found that KAN-ODEs are an extremely efficient method to represent the predator-prey dynamics in this case, and beat Neural ODEs in all relevant metrics. In the next sections, we present larger-scale examples to showcase the flexibility and inference capabilities of KAN-ODEs.

### III.2 Modeling Hidden Physics: Fisher-KPP PDE

In this section, we introduce the capability of KAN-ODEs to learn the hidden physics in PDEs. Key features demonstrated here are the flexibility of KAN-ODEs to be paired with higher-complexity solvers on arbitrary temporal grids, and the capability of KAN-ODEs to extract hidden symbolic functional relationships from training data. We demonstrate this using the Fisher-KPP equation representing a convection-diffusion system,

$$
\frac{\partial u}{\partial t}=D\frac{\partial^{2}u}{\partial x^{2}}+ru(1-u),
$$

where $D$ is the diffusion coefficient and $r$ is the local growth rate. We assume that the reaction term of $ru(1-u)$ is unknown and to be modeled with a KAN.

Training data was synthesized by solving Eq. 12 in the domain of $x\in[0,1]$, $t\in[0,5]$, given the model parameters $D$ =0.2 and $r$ =1.0. The initial condition and boundary conditions were

$$
\displaystyle u(0,t)
$$
 
$$
\displaystyle=u(1,t),
$$
$$
\displaystyle u(x,0)
$$
 
$$
\displaystyle=\frac{1}{2}\left[\tanh\left(\frac{x-0.4}{0.02}\right)-\tanh\left%
(\frac{x-0.6}{0.02}\right)\right].
$$

Note that this problem setup was adopted from [^3].The spatial grid was was discretized with $\Delta x=0.04$, and the equation was solved with a time step of $\Delta t=0.5$. The obtained solution field $u(x,t)$ is shown in Fig. 4(A) and used as training data.

![Refer to caption](https://arxiv.org/html/2407.04192v1/x2.png)

Figure 4: Fisher-KPP equation: (A) Solution field u ⁢ ( x, t ) 𝑢 𝑥 𝑡 u(x,t) italic\_u ( italic\_x, italic\_t ) of ground truth. (B) Solution field of prediction with a learned KAN-ODE model. (C) Loss function. (D) Learned hidden physics of the reaction source term in the Fisher-KPP equation and its symbolic form.

To model the unknown reaction source term in Eq. 12, we formulate the KAN-ODE such that

$$
\frac{\partial u}{\partial t}=D\frac{\partial^{2}u}{\partial x^{2}}+\text{KAN}%
\left(u,\bm{\theta}\right).
$$

To utilize the backpropagation with the adjoint sensitivity method, Eq. 15 was discretized using a central difference scheme and converted to an ODE system using the Method of Lines. The KAN here was constructed with a single layer comprising a single node, \[1,1,5\].

The prediction with a learned model is illustrated in Fig. 4(B), showing accurate reconstruction of the solution field $u(x,t)$ after as few as 5,000 updates (Fig. 4(C)) and demonstrating that a single learned activation function comprised of five gridded basis functions (\[1,1,5\]) is sufficient to represent the reaction source term. This resultant activation function is shown in Fig. 4(D). We further propose expressing this single activation function symbolically, as was introduced in [^21] as a feature of KAN layers. Symbolic regression on this single KAN-ODE activation using SymbolicRegression.jl [^29] given the candidate symbolic expressions of $[+,-,*,/,\sin,\cos,\exp]$ returns the following expression,

$$
\text{KAN}\left(u\right)=0.995311u(1.002448-u).
$$

Given its single-layer, single-node construction, this symbolic expression is the KAN-ODE’s approximation of the true reaction source term in Eq. 12. Knowing $r$ =1.0, we see that the KAN-ODE’s derived expression is remarkably close to the original formulation. Thus the KAN-ODE was not only capable of learning the dynamics of physics hidden within a PDE submodel from measurable quantities, but also of returning an accurate and human-interpretable symbolic function that mimics the true governing law with excellent accuracy.

### III.3 Data-Driven Solutions: Burgers’ Equation

Our third example explores the use of a KAN-ODE to infer the unknown hidden states $u\left(x,t\right)$ of a PDE system, effectively representing all of its spatiotemporal dynamics. Let us consider the Burgers’ reaction-diffusion equation as an example.

$$
\frac{du}{dt}+u\frac{du}{dx}=\frac{0.01}{\pi}\frac{d^{2}u}{dx^{2}}.
$$

The computational domain is defined as $x\in[-1.0,1.0]$ and $t\in[0.0,1.0]$.

In order to prepare training data, Eq. 17 was discretized using a central difference scheme with $\Delta x=0.05$ such that $\mathbf{u}\left(t\right)=\left[u\left(x_{0},t\right),u\left(x_{1},t\right),...%
,u\left(x_{N},t\right)\right]$. Then, the discretized PDE was solved by an ODE integrator given the initial condition of $u(x,0)=-\sin(\pi x)$. The resultant solution field is illustrated in Fig. 5(A). The solution profiles at the selected times ($t\in\{0.1,0.3,0.5,0.7,0.9\}$) were collected as training data.

To learn the latent solution, we model the KAN-ODEs such that

$$
\frac{\partial\mathbf{u}\left(t\right)}{\partial t}=\text{KAN}(\mathbf{u}\left%
(t\right),\bm{\theta}).
$$

In this formulation, the KAN works as a non-linear operator for the partial differential equation (PDE) solution. The KAN-ODE was constructed with 2 layers: \[51, 10, 5\], \[10, 51, 5\]. Ten nodes in the intermediate layer were used to preserve the high-dimensional information. Note that the numbers of the input and output dimensions of the KAN are determined by the number of discretized state variables in $\mathbf{u}$. The KAN parameters were updated with a learning rate of 0.01 with the ADAM optimizer.

![Refer to caption](https://arxiv.org/html/2407.04192v1/x3.png)

Figure 5: Burgers’ equation: (A) Solution fields u ⁢ ( x, t ) 𝑢 𝑥 𝑡 u(x,t) italic\_u ( italic\_x, italic\_t ) for ground truth and prediction with an initial guess and the learned parameters. The black dashed lines in the solution field of ground truth indicates the training data. (B) Loss function. (C) Training data and prediction at times italic\_t = 0.1, 0.3, 0.5, 0.7, and 0.9 s. (D) Ground truth and inferred solution profiles at selected times = 0.2, 0.4, 0.6, 0.8, and 1.0 s.

After 20,000 training epochs (Fig. 5(B)), the KAN-ODE model can be seen in Fig. 5(A) to predict the temporal evolution of the PDE well despite only receiving five training snapshots. These snapshots and their accurate KAN-ODE dynamical representations are shown in Fig. 5(C), where strong agreement is seen at all spatial locations, even those near the shock wave where the training data sampling is very sparse. More importantly, the trained KAN-ODE model is able to extrapolate effectively to infer the solution fields at the unseen testing times in Fig. 5(D), once again with strong performance at the shock. As a whole, this case demonstrates the ability of the KAN-ODE to not only learn the dynamics of the Burgers’ convection-diffusion PDE from velocity data, but also to leverage its temporal grid agnosticism to accurately predict the system’s behavior at unseen times.

## IV Conclusions

This work proposed the use of Kolmogorov-Arnold networks as gradient-getters in the Neural ODE framework. This novel combination of data-driven techniques advances our capabilities in the field of scientific machine learning to efficiently infer interpretable and modular dynamical system models from various sources of data. The replacement of MLPs with KANs in this framework preserves the black-box style approach with zero prior knowledge of the dynamical system physics needed for training. However, it opens the door to significant interpretability of the learned model (”opening” the black box) via activation function visualization and symbolic regression. Quantitatively, the KAN-ODE framework is shown to outperform similar MLP-based Neural ODEs when given the same training task. The strong neural scaling offered by the Kolmogorov-Arnold representation holds when applied as a KAN-ODE, allowing for significantly better training and testing performance in a fraction of the computational time. We additionally demonstrated the capability of the KAN-ODE to extrapolate information from sparse or limited temporal data to the rest of a solution domain, and to learn symbolic expressions for PDE source terms with high accuracy via optional postprocessing. In addition to these improvements over MLP-based Neural ODEs, KAN-ODEs offers an alternative to SINDy, PINN, and similar interpretable machine learning techniques in its flexibility and generality - no prior knowledge or assumptions are needed about the governing laws or candidate function space to train the KAN-ODE system effectively, although such information can be added if desired as shown here in the source term regression of the Fisher-KPP PDE. KAN-ODEs are a compact, efficient, flexible, and interpretable approach for data-driven modeling of dynamical systems that show significant promise for use in the field of scientific machine learning.