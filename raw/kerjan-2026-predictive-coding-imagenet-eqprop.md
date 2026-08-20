# kerjan-pcn-imagenet-eqprop-2026

> Converted from `kerjan-pcn-imagenet-eqprop-2026.pdf` on 2026-08-18 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

## **Training a Predictive Coding Network on ImageNet** **using Equilibrium Propagation**

**Tugdual Kerjan** <sup>_∗_</sup>

Rain AI
```
tkerjan@outlook.com

```

**Benjamin Scellier** <sup>_∗_</sup>

Rain AI
```
        benjamin@rain.ai

```

**Abstract**

**Rasmus Høier** <sup>_∗_</sup>

Rain AI
```
rasmus@rain.ai

```

Equilibrium Propagation (EP) is a physics-based training framework that has primarily been employed in energy-based models, including continuous Hopfield
networks, nonlinear resistive networks and coupled phase oscillators. However,
EP’s practical applications have so far remained limited to relatively small-scale
problems. Predictive coding networks (PCNs), another class of energy-based models rooted in computational neuroscience, are typically trained with a specialized
algorithm and have likewise not yet been demonstrated at large scale. In this
work, we develop an EP-based training method for PCNs which combines the
centered variant of EP with a novel equilibration scheme for PCNs. Using this
approach, we train a 10-layer convolutional PCN (VGG10) on full-size ImageNet,
achieving 13.23% test error rate on the top-5 classification task, close to the 12.2%
backpropagation baseline. To our knowledge, this is the first demonstration of
both PCNs and EP-based training at ImageNet scale. These results significantly
extend the scalability of both approaches and suggest that the primary challenges
in scaling EP in other physical systems may come more from the computational
properties of these systems than from inherent limitations of the EP framework.

**1** **Introduction**

The growing computational demands of machine learning (ML) motivate the exploration of neuromorphic computing platforms based on analog physics, which promise substantial energy savings

[Markovi´c et al., 2020]. A prominent research direction within these efforts is the development
of ‘physical learning algorithms’ that leverage the physics of the hardware for both inference and
learning [Momeni et al., 2025]. Equilibrium Propagation (EP) [Scellier and Bengio, 2017] is a
physics-based training framework that enables a class of systems to learn by adjusting parameters
through comparisons of equilibrium states under varying boundary conditions.

EP belongs to a broader class of contrastive learning algorithms [Hinton and Sejnowski, 1983, Movellan, 1991, Baldi and Pineda, 1991, Hinton, 2002] and employs the concept of weak perturbations used
in earlier works [Hinton and McClelland, 1987, O’Reilly, 1996]. EP distinguishes itself from these
methods in that it allows optimization of arbitrary cost functions, and in the weak-perturbation regime
it approximates gradient descent. EP has been studied in energy-based models such as continuous
Hopfield networks [Scellier and Bengio, 2017], nonlinear resistor networks [Kendall et al., 2020],
flow and elastic networks [Stern et al., 2021], and systems of Kuramoto oscillators [Zoppo et al., 2022,

_∗_ Equal contribution.

Preprint.

Wang et al., 2024, Rageau and Grollier, 2025]. Generally applicable to physical systems governed by
variational principles, EP has been extended to stochastic and thermal systems [Scellier and Bengio,
2017, Massar and Mognetti, 2025], Lagrangian dynamical systems [Kendall, 2021, Scellier, 2021,
Massar, 2025, Pourcel et al., 2025] and quantum systems [Massar and Mognetti, 2025, Wanjura and
Marquardt, 2025, Scellier, 2024b]. Further developments include a version of EP which performs
parameter updates in black-box systems using physical dynamics [Scellier et al., 2022] and a version
of EP for nonlinear wave systems [Sajnok and Matuszewski, 2025].

Despite these theoretical developments, applications of EP have so far remained limited to small
networks and datasets. Physical implementations of EP and variants have been demonstrated on
resistor networks [Dillavou et al., 2022, 2024], memristor networks [Yi et al., 2023], D-wave’s Ising
machine [Laydevant et al., 2024], and elastic networks [Altman et al., 2024], albeit only at very
small scales. On the simulation side, EP has been scaled to train convolutional Hopfield networks
on a 32x32 downsampled version of ImageNet [Laborieux and Zenke, 2022, Nest and Ernoult,
2024]. Setting aside the challenges of hardware implementation, several factors contribute to the
difficulty of scaling EP in numerical experiments. First, unlike backpropagation, EP computes only
an approximate gradient of the cost function, with its accuracy depending on factors like perturbation
strength, finite difference scheme and the proximity to equilibrium. Second, the expressivity and
computational properties of EP-compatible physical networks remain poorly understood, as these
systems lack a direct mapping to traditional neural networks <sup>2</sup> . Finally, simulations of such networks
can be computationally expensive, since they require numerical optimization of the system’s energy
function to reach equilibrium <sup>3</sup> . As one attempts to scale EP to larger networks and more complex
datasets, it has remained unclear whether the observed challenges should be attributed to the EP
framework itself or the expressivity of the underlying networks (or a combination of both).

In this work, we investigate this question by applying EP to predictive coding networks (PCNs),
a class of models studied in computational neuroscience that alleviates some of the challenges
associated with simulations of physical networks. In their most common form, PCNs can be viewed
as an energy-based counterpart to feedforward neural networks [Whittington and Bogacz, 2017,
Millidge et al., 2021]. Although it is unclear whether PCNs can offer advantages as a neuromorphic
platform [Zahid et al., 2023], in numerical experiments they allow to isolate EP-related challenges
from model-specific issues: at test time, PCNs behave like feedforward neural networks, enabling
direct comparison with backpropagation. PCNs also offer a computational advantage over simulations
of physical systems such as resistor or oscillatory networks, as their ‘free equilibrium’ state (i.e. the
inference equilibrium) can be obtained in a single forward pass.

To date, however, applications of PCNs have also been limited to relatively small datasets such
as Tiny ImageNet [Pinchetti et al., 2024], and although some works on PCNs have explored the
nudging-based perturbation mechanism of EP [Whittington and Bogacz, 2019, Millidge et al., 2023],
PCNs are more typically trained using a different perturbation strategy based on output clamping. To
identify the key ingredients for effectively training PCNs with EP, we conduct extensive experiments
on a 5-layer convolutional PCN (VGG5) across four vision datasets. We perform a comprehensive
sensitivity analysis of EP hyperparameters, including the perturbation method, finite difference
scheme, perturbation strength and the number of iterations in the nudge-phase equilibration. Our
main findings and contributions are as follows:

    - While clamping-based perturbations perform comparably to EP’s nudging-based approach
on CIFAR-100, we find that the nudging-based method significantly outperforms clamping
on more challenging datasets such as ImageNet 32x32 (Figure 1).

    - By combining the nudging-based approach with the centered scheme, we train a 10-layer
convolutional PCN (VGG10) on full-resolution ImageNet, achieving 13.23% top-5 test error
rate, close to the 12.2% backpropagation baseline (Table 2). To the best of our knowledge,
this is the first demonstration of both PCNs and EP-based training at ImageNet scale.

    - Our results challenge common assumptions about EP’s random and centered schemes,
showing that the random scheme remains competitive even on full-size ImageNet (Figure 1
and Table 2). This scheme is particularly appealing for PCNs, as the learning rule involves
only a single equilibrium state, rather than two as in the centered scheme.

2Scellier and Mishra [2025] recently established a universal approximation result for nonlinear resistive networks.
3Algorithmic advances have accelerated this equilibration step in some systems [Scellier et al., 2023, Scellier, 2024a].

2

**2** **Related Work on Predictive Coding Networks**

The standard learning algorithm for PCNs as outlined in Whittington and Bogacz [2017], involves
clamping the output units to desired outputs rather than nudging them as in EP. Millidge et al. [2023]
proposed using the nudging method of EP in the context of PCNs, but they used specifically the
forward scheme (which employs positive nudging) and found the standard learning algorithm for
PCNs to be preferable. Conversely, Pinchetti et al. [2024] combined the weak clamping-based
perturbation approach with the random scheme and achieved significantly better performance, using it
to train convolutional PCNs on Tiny ImageNet. The centered scheme for EP [Laborieux et al., 2021],
which involves comparing one positively-perturbed state with one negatively-perturbed state, has not
been utilized in PCNs so far, presumably because it requires comparing two network states, making
it harder to justify from a neuroscience perspective. Our paper is the first to explore EP’s nudging
approach combined with the backward, random and centered schemes in the context of PCNs.

Scaling PCNs to deeper architectures has been a key challenge [Pinchetti et al., 2024], with a
number of recent papers exploring this issue. Innocenti et al. [2026] improved activation stability
by introducing additional scaling factors in the network energy, enabling the training of densely
connected ResNets with up to 128 layers on MNIST and Fashion-MNIST. Other works have focused
on tackling the issue of signal attenuation due to limited machine precision. Goemaere et al. [2025]
tackle this issue by reparametrizing PC to treat the local errors as the variable of optimization rather
than the neural states, showing that the underlying optimization problems are equivalent, and the
simulations are much faster (more than 100 _×_ ). Qi et al. [2025] address the issue of signal attenuation
by, among other things, introducing a schedule for the inference step size and using a surrogate
objective when computing the weight updates.

**3** **Background:** **Equilibrium Propagation**

This section reviews EP and its variants depending on finite difference schemes (forward, backward,
centered and random) and perturbation methods (nudging vs clamping).

In its original formulation, EP applies to _energy-based systems_, meaning systems with a state vector
_h_ whose dynamics evolve towards a minimum (or more generally critical point) of some function _E_,
referred to as _energy function_ . In supervised learning, _E_ ( _θ, x, h_ ) depends on trainable weights _θ_ and
a boundary input _x_ . During inference, given _x_, the system settles into its equilibrium state _h_ ( _θ, x_ ),
characterized by the first-order condition

_<u>∂E</u>_

_∂h_ <sup>(</sup> <sup>_θ, x, h_</sup> <sup>(</sup> <sup>_θ, x_</sup> <sup>)) = 0</sup> <sup>_._</sup> (1)

The function _x �→_ _h_ ( _θ, x_ ) represents the system’s forward computation. Training consists in adjusting
_θ_ so as to minimize the discrepancy between the prediction _h_ ( _θ, x_ ) and the desired result _y_, which is
quantified using a cost function _C_ ( _h_ ( _θ, x_ ) _, y_ ). The training objective we seek to minimize is

_J_ ( _θ_ ) = E( _x,y_ ) [ _C_ ( _h_ ( _θ, x_ ) _, y_ )] _,_ (2)

where the expectation is taken over the data distribution of input-target pairs ( _x, y_ ). If, given an
input-output pair ( _x, y_ ) from the training data, one had direct access to _∇θC_ ( _h_ ( _θ, x_ ) _, y_ ), the usual
gradient-descent update would be

∆ _θ_ = _−η∇θC_ ( _h_ ( _θ, x_ ) _, y_ ) _._ (3)

The key challenge in a physical system is to estimate these gradients using the system’s dynamics
itself. EP accomplishes this by introducing a small _nudging_ parameter _β_ _∈_ R, and interpreting
_βC_ ( _h, y_ ) as an interaction energy between the state _h_ and target output _y_, scaled by _β_ . Incorporating
this into the energy function leads to the _total energy function_

_F_ ( _θ, β, h_ ) = _E_ ( _θ, x, h_ ) + _βC_ ( _h, y_ ) _,_ (4)

where _β_ controls the strength of this interaction. With _β_ = 0, the system relaxes to the _free_
equilibrium, _h_ <sup>0</sup> _⋆_ <sup>=</sup> <sup>_h_</sup> <sup>(</sup> <sup>_θ, x_</sup> <sup>).</sup> <sup>For nonzero</sup> <sup>_β_</sup> <sup>, the system settles to the</sup> <sup>_nudged_</sup> <sup>equilibrium, characterized</sup>

by the first-order condition

_<u>∂F</u>_

_⋆_ <sup>_β_</sup> <sup>) = 0</sup> <sup>_._</sup> (5)

_∂h_ <sup>(</sup> <sup>_θ, β, h_</sup> _⋆_ <sup>_β_</sup>

3

The main insight of Scellier and Bengio [2017] is that the gradient of the cost function with respect
to the trainable weights can be approximated as

<sup>_<u>∂F</u>_</sup> _∂θ_ <sup>(</sup> <sup>_θ,_</sup> <sup>0</sup> <sup>_, h_</sup> _⋆_ <sup>0</sup>

_<u>d</u>_
_∇θC_ ( _h_ ( _θ, x_ ) _, y_ ) =
_dβ_

_<u>∂F</u>_

_∂θ_ <sup>(</sup> <sup>_θ, β, h_</sup> _⋆_ <sup>_β_</sup>

_⋆_ <sup>_β_</sup> <sup>)</sup>

_⋆_ <sup>0)</sup>

- _<u>∂F</u>_ _⋆_
_∂θ_ <sup>(</sup> <sup>_θ, β, hβ_</sup>

_⋆_ <sup>)</sup> <sup>_−_</sup> <sup>_<u>∂F</u>_</sup>

<sup>_β_</sup> _∂θ_

���� _β_ =0

_._ (6)

_≈_ <sup><u>1</u></sup>

_β_

Substituting Eq. (6) into Eq. (3) yields a contrastive learning rule.

**3.1** **Finite Difference Schemes:** **Forward, Backward, Centered and Random Schemes**

In contrast with standard ML methods based on automatic differentiation, EP does not provide the
exact cost gradient but rather an approximation of it, due to the finite difference scheme employed for
estimating the derivative with respect to _β_ . We refer to the right-hand side of Eq. (6) with _β_ _>_ 0 as
the forward scheme. Scellier and Bengio [2017] found that the random scheme, where the sign of _β_
is chosen at random for each training pair ( _x, y_ ), works better than the forward scheme. To further
reduce the approximation error, Laborieux et al. [2021] introduced the centered scheme whose error
term is of order _O_ ( _β_ <sup>2</sup> ),

_∇θC_ ( _h_ ( _θ, x_ ) _, y_ ) _≈_ <sup><u>1</u></sup>

2 _β_

- _<u>∂F</u>_

_∂θ_

- <sup>�</sup>
_,_ (7)

- _θ, β, h_ <sup>_β_</sup> _⋆_

_−_ <sup>_<u>∂F</u>_</sup>

_∂θ_

- _θ, −β, h_ <sup>_−_</sup> _⋆_ <sup>_β_</sup>

and found it to yield better empirical results than the random scheme. The purely backward scheme,
employing Eq. (6) with _β_ _<_ 0, was first studied by Scellier et al. [2022] and shown to optimize an
upper bound of the objective function (Eq. (2)).

**3.2** **Perturbation Approaches:** **Nudging vs Clamping**

An alternative to the nudging approach of Eq. (4) is to perturb the system by clamping its outputs
rather than modifying its energy function. Let _h_ = ( _h_ hid _, h_ out) denote the system state, partitioned
into hidden and output components. In the clamping-based approach, the output variables are set to

_h_ <sup>_β_</sup> out <sup>= (1</sup> <sup>_−_</sup> <sup>_β_</sup> <sup>)</sup> <sup>_h_</sup> <sup>0</sup> out <sup>+</sup> <sup>_βy,_</sup> (8)

where _h_ <sup>0</sup> out <sup>denotes the free-equilibrium output of the system.</sup> <sup>This strategy, which predates EP, was</sup>

proposed by O’Reilly [1996] in the context of Hopfield-like networks, and has more recently been
employed in physical energy-based networks [Stern et al., 2021] and in PCN experiments [Pinchetti
et al., 2024].

Unlike nudging, which provides flexibility in defining the learning objective of Eq. (2) by allowing
arbitrary choices of cost functions ( _C_ ), the clamping-based approach does not define a cost function
explicitly, and the resulting parameter updates do not generally correspond to gradient descent or to
the minimization of an objective function, even in the limit _β_ _→_ 0. We refer to Scellier et al. [2023]
for a detailed comparison of the two approaches.

In numerical experiments with convolutional Hopfield networks, Scellier et al. [2023] found the
nudging-based approach to outperform clamping. As we show in Section 5, the same conclusion
holds for PCNs.

**4** **Predictive Coding Networks Through the Lens of EP**

While EP’s main appeal lies in training physical systems such as those referenced in the introduction,
here we apply EP to feedforward neural networks by defining an appropriate energy function. This
leads to a collection of algorithms for Predictive Coding Networks (PCNs).

Consider a feedforward neural network with _L_ layers:

_h_ <sup>_⋆_</sup> 0 <sup>=</sup> <sup>_x,_</sup> and _h_ <sup>_⋆_</sup> _k_ <sup>=</sup> <sup>_fk_</sup> <sup>(</sup> <sup>_θk, h_</sup> _k_ <sup>_⋆_</sup> _−_ 1 <sup>)</sup> <sup>_,_</sup> 1 _≤_ _k_ _≤_ _L,_ (9)

where _h_ <sup>_⋆_</sup> _k_ <sup>is the activation of layer</sup> <sup>_k_</sup> <sup>,</sup> <sup>_fk_</sup> <sup>is the (learnable) transformation that maps</sup> <sup>_h⋆_</sup> _k−_ 1 <sup>to</sup> <sup>_h_</sup> _k_ <sup>_⋆_</sup> <sup>, and</sup> <sup>_θk_</sup>

are the corresponding trainable parameters (weights and biases). Later we will consider specifically
convolutional (VGG) networks, but for now our discussion does not make such assumptions on the
network architecture. One can view this network as an energy-based model whose energy function is

_h_ <sup>_β_</sup>

<sup>_β_</sup> out <sup>= (1</sup> <sup>_−_</sup> <sup>_β_</sup> <sup>)</sup> <sup>_h_</sup> <sup>0</sup>

_h_ <sup>_⋆_</sup> 0

<sup>_⋆_</sup> 0 <sup>=</sup> <sup>_x,_</sup> and _h_ <sup>_⋆_</sup> _k_

<sup>_⋆_</sup> _k_ <sup>=</sup> <sup>_fk_</sup> <sup>(</sup> <sup>_θk, h_</sup> _k_ <sup>_⋆_</sup>

<sup>_⋆_</sup> _k_ <sup>is the activation of layer</sup> <sup>_k_</sup> <sup>,</sup> <sup>_fk_</sup> <sup>is the (learnable) transformation that maps</sup> <sup>_h⋆_</sup> _k_

<sup>_⋆_</sup> _k−_ 1 <sup>to</sup> <sup>_h_</sup> _k_ <sup>_⋆_</sup>

_E_ PCN( _θ, x, h_ ) = <sup><u>1</u></sup>

2

_L_

_k_ =1

_∥hk −_ _fk_ ( _θk, hk−_ 1) _∥_ <sup>2</sup> _,_ (10)

4

where _x_ = _h_ 0 and _h_ = ( _h_ 1 _, . . ., hL_ ). Indeed, the state _h_ <sup>_⋆_</sup> = ( _h_ <sup>_⋆_</sup> 1 <sup>_, h⋆_</sup> 2 <sup>_, . . ., h⋆_</sup> _N_ <sup>)</sup> <sup>satisfying</sup> <sup>the</sup>

feedforward equations of Eq. (9) is a stationary point of _E_ PCN, specifically the unique global
minimum of _E_ PCN, for which we have _E_ PCN( _θ, x, h_ <sup>_⋆_</sup> ) = 0.

Assuming we use the nudging-based perturbation technique, EP then operates on the total energy
_F_ PCN( _θ, β, h_ ) = _E_ PCN( _θ, x, h_ ) + _βC_ ( _hL, y_ ), where _C_ ( _hL, y_ ) is the cost function. In the _free_
_phase_ ( _β_ = 0), finding the global minimum of _F_ PCN with respect to _h_ reduces to a single forward
pass, following the feedforward equations of Eq. (9). For _β̸_ = 0 (nudge phase), however, finding
a stationary point of _F_ PCN requires a specific algorithm. In this work, we use a modified form of
gradient descent on _F_ PCN with respect to _h_, which we describe next (Section 4.1). Besides, it is
easy to verify that the energy derivative at the free equilibrium state vanishes: <sup>_<u>∂F</u>_</sup> _∂θ_ <sup><u>PCN</u></sup> ( _θ,_ 0 _, h_ <sup>0</sup> _⋆_ <sup>) = 0.</sup>

Therefore, when employing the forward, backward or random scheme, the EP gradient of Eq. (6)
simplifies, requiring only one equilibrium state (the nudge state):

<sup>_β_</sup> _⋆_ <sup>)</sup> <sup>_._</sup> (11)

_∇θC_ ( _h_ ( _θ, x_ ) _, y_ ) _≈_ <sup><u>1</u></sup>

_β_

_<u>∂F</u>_ <u>PCN</u>

<u>PCN</u>

( _θ, β, h_ <sup>_β_</sup> _⋆_
_∂θ_

Prior works discussing the relationship between EP and PCNs combined the nudging approach with
the forward scheme [Millidge et al., 2023], or the forward, backward and random schemes with the
clamping approach [Pinchetti et al., 2024]. Here, we perform a more comprehensive comparison of
these perturbation techniques and finite difference schemes. We find that the best performing ones
combine the nudging approach with the centered, random and backward schemes, which were not
used in prior works on PCNs. Appendix C provides more details on the relationship between EP and
the traditional learning algorithm for PCNs.

**4.1** **Nudged-Phase Equilibration via Projected Gradient Descent**

To compute the nudge equilibria, we minimize the total energy function using projected gradient
descent (PGD). The PCN’s total energy function rewrites

_F_ PCN( _θ, β, h_ ) = <sup><u>1</u></sup>

2

_L_

_k_ =1

_∥ϵk∥_ <sup>2</sup> + _βC_ ( _hL, y_ ) _,_ _ϵk_ = _hk −_ _fk_ ( _θk, hk−_ 1) _,_ (12)

where _ϵk_, referred to as _error_, is the difference between the state _hk_ and the bottom-up prediction
_fk_ ( _θk, hk−_ 1). In the nudge-phase dynamics, units _hk_ adjusts so as to minimize the sum of squared
errors. In what follows, we consider PCNs with ReLU units in the hidden layers and linear output
units, more specifically:

_fk_ _∈{_ ReLU _◦_ maxpool _◦_ conv2d _,_ ReLU _◦_ conv2d _,_ ReLU _◦_ matmul _},_ 1 _≤_ _k_ _≤_ _L −_ 1 _,_ (13)
_fL_ = matmul _._ (14)

These are the operations we require for the VGG networks considered in our experiments.

PGD with step size _α >_ 0 on a ReLU layer reads

   
( _θ, β, h_ ) _,_ (15)

_hk_ _←_ Proj[0 _,_ + _∞_ ]

- _hk −_ _α_ <sup>_<u>∂F</u>_</sup> <sup><u>VGG</u></sup>

_∂hk_

where Proj[0 _,_ + _∞_ ] is the projection onto the range of the ReLU, that is [0 _,_ + _∞_ ], which is equivalent
to applying the ReLU itself. In our experiments, we use step size _α_ = 1 (see Appendix A for a
justification). For a hidden layer _hk_, the gradient of _F_ VGG with respect to _hk_ is

_<u>k</u>_ <u>+1</u>

= _hk −_ _fk_ ( _θk, hk−_ 1) + <sup>_∂ϵ_</sup> <sup>2</sup>

_∂hk_

_<u>k</u>_ <u>+1</u>

+ <sup>_∂ϵ_</sup> <sup>2</sup>

_∂hk_

_<u>∂F</u>_ <u>VGG</u>

_∂hk_

_<u>k</u>_

= <sup>_<u>∂ϵ</u>_</sup> <sup>2</sup>

_∂hk_

_._ (16)

Injecting Equation (16) into Equation (15) with _α_ = 1, the _hk_ terms cancel out and the PGD update
rewrites more concisely as

_hk_ _←_ ReLU

_<u>k</u>_ <u>+1</u>

_fk_ ( _θk, hk−_ 1) + <sup>_∂ϵ_</sup> <sup>2</sup>

_∂hk_

_._ (17)

For the output layer whose activation function is the identity, the update rule simplifies as:

_hL_ _←_ _aL −_ _β_ <sup>_<u>∂C</u>_</sup>

_∂hL_

5

( _hL, y_ ) _._ (18)

Thus, during the nudged dynamics ( _β̸_ = 0), output units are perturbed by bringing them to either
lower cost values ( _β_ _>_ 0) or higher cost values ( _β_ _<_ 0), that is, closer to the targets or further away
from the targets. These perturbations lead to non-zero error signal _ϵL_, which leads to perturbations in
the layer _L −_ 1, and so on.

In practice, we find that a modified version of PGD works better than PGD itself – see Appendix A.

We emphasize that it remains unclear whether _F_ PCN and the nudge-phase dynamics (PGD) could
be efficiently realized in hardware, to obtain the nudge equilibrium using physical dynamics. The
primary contribution of our work is to advance the state of EP-based and PCN numerical experiments
(on GPUs) to full-size ImageNet, without hardware implementation considerations.

**5** **Experimental Results**

We consider two convolutional (VGG) PCN models: a 5-layer network (VGG5) with 32x32 pixel
input images, and a 10-layer network (VGG10) with 224x224 pixel input images. The VGG5 network
is employed on MNIST, CIFAR10, CIFAR100 and ImageNet 32x32 (the 32x32 pixel downscaled
version of ImageNet). To permit using VGG5 on MNIST, images from MNIST are padded to 32x32
input size. The VGG10 network is trained on the (full-size) ImageNet dataset. Network architectures
and numerical simulation details are described in Appendix B.

The hyperparameter search space for EP-based training of these VGG networks includes:

    - perturbation method: nudging vs clamping,

    - finite difference scheme: forward, backward, centered or random,

    - nudging strength ( _β_ ),

    - number of nudge iterations ( _K_ ),

    - cost function (only applicable to the nudging-based perturbation approach): mean squared
error (MSE) or cross-entropy (CE).

Backpropagation (BP) is also employed as a baseline for comparison. We use a two-stage hyperparameter tuning strategy, where we first tune the hyperparameters shared by BP-based and EP-based
training (weight initialization schemes, learning rates, weight decay, batch-size, cost function, etc),
and subsequently tune the EP-specific hyperparameters. This strategy is justified by the fact that,
when employing the nudging-based perturbation method, in the limit when _β_ tends to 0, the EP
gradients are equal to the BP gradients (Equation (6)).

We find that the best performing version of EP involves the nudging-based perturbation approach and
the centered scheme. Unless stated otherwise, and ‘EP-trained network’ refers to this configuration.

**5.1** **Comparison of Perturbation Approaches and Finite Difference Schemes**

(a) CIFAR-100 (b) ImageNet 32x32

Figure 1: Comparison of perturbation approaches (CE-Nudge, MSE-Nudge and Clamp) and finite
difference schemes (forward, backward, centered and random) on the VGG5 network trained on (a)
CIFAR-100 and (b) ImageNet 32x32.

We compare the two perturbation approaches (nudging and clamping) and the four finite difference
schemes (forward, backward, centered and random). For nudging-based perturbation, we use both
the MSE and cross-entropy (CE) cost functions.

6

Figure 1 reports the results for the VGG5 trained on CIFAR100 and ImageNet 32x32. While all
algorithms perform comparably on CIFAR100, important differences arise on the more challenging
ImageNet 32x32 task. CE-Nudge performs significantly better than both MSE-Nudge and Clamp,
except when employed in combination with the forward scheme. The best performing method is
CE-Nudge with the centered scheme, in agreement with prior literature on EP [Laborieux et al., 2021,
Scellier et al., 2023], but interestingly, both the random and backward schemes perform comparably
with the centered scheme, which challenges the conclusions of these works, where more important
gaps were observed.

**5.2** **Sensitivity to Nudging Strength and Number of Nudge Iterations**

Figure 2 displays the performance of a trained VGG5 network for different values of _K_ (number of
nudged iterations) and _β_ (nudging strength). We observe that, as long as _K_ _≥_ 4 and 0 _._ 0002 _≤_ _β_ _≤_
0 _._ 1, the final error rate is mostly insensitive to the choice of _K_ and _β_ .

Intuitively, _K_ needs to be large enough that the network reaches equilibrium, but should be chosen
as small as possible to avoid unnecessary computation. Empirically, the optimal value for _K_ is the
number of layers in the network, allowing perturbations to fully propagate from outputs to inputs.
Similarly, _β_ needs to be small enough that EP gradients are accurate (Equation (6)), but it needs to
be large enough that perturbations can propagate throughout the network without vanishing (due to
limited machine precision).

Appendix A provides more insights into the nudge-phase equilibration dynamics, including sensitivity
to the step size ( _α_ ) and the traversal scheme, as well as equilibration curves ( _F_ as a function _K_ ).

Figure 2: VGG5 network trained on CIFAR100 for 20
epochs. Sensitivity to the nudging strength ( _β_ ) and number of nudge iterations ( _K_ ).

Figure 3: VGG5 trained on ImageNet
32x32 using the MSE cost function. Different weight initialization gains for the
output layer lead to significantly different
results ; however, EP consistently performs
comparably to BP. Solid lines and dashed
lines denote EP and BP, respectively.

**5.3** **Sensitivity to Batch Size, Cost Function and Weight Initialization**

We now compare the performance of EP-trained PCNs against BP, and study their sensitivity to
shared hyperparameters. Figure 4 compares EP and BP on CIFAR-100 for different batch sizes, while
Table 1 reports the results of a more comprehensive comparison on four datasets (MNIST, CIFAR-10,
CIFAR-100 and ImageNet 32x32) where we used two cost functions: the mean-squared error (MSE)
and the cross-entropy (CE).

In every situation, EP is competitive with BP. While the end performance depends prominently on
the cost function and the batch size, it depends little on the learning algorithm used (BP or EP).

For ImageNet 32x32 experiments with the MSE, we find (Figure 3) that significantly better results
are obtained using a different weight initialization scheme (scaling the output layer’s weights by 0.2
instead of the default 1.0). Here again, however, EP performs comparably with BP.

7

(a) Test error rate (b) Train error rate

Figure 4: VGG5 trained on CIFAR100 using the MSE. Shapes of training curves depend on the batch
size (BS), but not on the algorithm (EP vs BP). Solid lines denote EP and dashed lines denote BP.

Table 1: Sensitivity to the choice of the cost function: mean squared error (MSE) and cross-entropy
(CE). Top1 (resp. Top5) refers to the test error rate in % for the classification task. In all cases, EP
<u>performs competitively with BP. Results were averaged over 3 random seeds.</u>

CIFAR-100 ImageNet 32x32
Cost Algorithm MNIST CIFAR-10

Top1 Top5 Top1 Top5

EP 0 _._ 32 _±_ 0 _._ 01 7 _._ 8 _±_ 0 _._ 1 30 _._ 1 _±_ 0 _._ 0 12 _._ 8 _±_ 0 _._ 1 70 _._ 8 _±_ 0 _._ 2 55 _._ 9 _±_ 0 _._ 3
MSE
BP 0 _._ 33 _±_ 0 _._ 00 8 _._ 0 _±_ 0 _._ 0 30 _._ 1 _±_ 0 _._ 4 12 _._ 7 _±_ 0 _._ 5 70 _._ 7 _±_ 0 _._ 1 56 _._ 0 _±_ 0 _._ 2

EP 0 _._ 45 _±_ 0 _._ 01 9 _._ 7 _±_ 0 _._ 2 34 _._ 7 _±_ 0 _._ 1 12 _._ 1 _±_ 0 _._ 2 60 _._ 0 _±_ 0 _._ 1 36 _._ 6 _±_ 0 _._ 4
CE
BP 0 _._ 48 _±_ 0 _._ 02 9 _._ 5 _±_ 0 _._ 0 34 _._ 2 _±_ 0 _._ 4 12 _._ 3 _±_ 0 _._ 2 59 _._ 8 _±_ 0 _._ 0 36 _._ 5 _±_ 0 _._ 0

**5.4** **Full-Size Imagenet Experiments**

Table 2 reports the results (Top1 and Top5 error rates) obtained with the VGG10 network trained
on full-size ImageNet. We compare these results with existing literature on PCNs and EP. For
these experiments, we used the cross-entropy (CE) cost function. While the EP-trained network
is competitive in performance with the BP-trained network, we observe a small gap. The VGG10
networks were trained for 50 epochs.

Crucially, no prior work on PCNs or EP has been carried out on full-size ImageNet classification.
The best results available for PCNs were performed by Pinchetti et al. [2024], Qi et al. [2025] on Tiny
Imagenet, a dataset with 13x less images (100,000 instead of 1.28 million), with a resolution 12x
smaller (64x64 instead of 224x224) and with 5x fewer classes (200 instead of 1000) than ImageNet.
Likewise, the best available results for EP were reported on ImageNet 32x32 [Nest and Ernoult,
2024], whose images are 50x smaller than the full-resolution version (32x32 instead of 224x224).

Table 2: Performance of VGG10 on full-size ImageNet, compared to the results available in the
related literature on PCNs and EP on smaller ImageNet variants (Tiny ImageNet and ImageNet
32x32). For each dataset, we write for comparison the number of images, size of images and number
of classes in this order. Top1 (resp. Top5) refers to the test error rate in % for the top-1 (resp. top-5)
classification task. Our results provide the first benchmark on full-size ImageNet for both EP-based
training and PCNs.

Dataset Model Top1 Top5

Tiny ImageNet Pinchetti et al. [2024] 58.85 33.75
(100K, 64x64, 200) Qi et al. [2025] 44.69 20.70

Laborieux and Zenke [2022] 63.5 39.2
ImageNet 32x32

Høier et al. [2023] 58.52 35.10
(1.28M, 32x32, 1000)
Nest and Ernoult [2024] 54.0 30.0

VGG10 + EP + random scheme 34.73 14.02
ImageNet

VGG10 + EP + centered scheme 33.81 13.23
(1.28M, 224x224, 1000)
VGG10 + BP (baseline) 32.35 12.20

8

**5.5** **Integrating Skip Connections**

To demonstrate the broader applicability of the methods to ResNet-like models, we perform experiments on a variant of the VGG10 with skip connections. It has a similar architecture as the VGG10
network but includes strided 1x1 convolutional skip-layer connections from layer 2 to layer 5, as well
as from layer 5 to layer 8. We train this VGG10Skip model on full-size ImageNet and obtain similar
performance as the VGG10 model. Specifically, centered EP achieves 33.92% Top1 and 13.32%
Top5 test error rates, compared to 32.40% and 12.1% for the BP baseline.

We expect that better results could be obtained using deep ResNets with batch normalization, at the
expense of significantly longer nudge-phase times. This is left for future work to investigate.

**6** **Conclusion**

Numerical experiments of Equilibrium Propagation (EP) have so far primarily focused on Hopfield
networks, with evaluations restricted to the 32x32-pixel version of ImageNet. Likewise, Predictive
Coding Network (PCN) experiments have remained limited to datasets of the size of Tiny ImageNet.
Using EP’s nudging-based perturbation method and the centered scheme, we unlocked the training of
a 10-layer convolutional PCN (VGG10) on full size ImageNet, providing the first benchmark for both
EP-based training and PCNs on this dataset. Our EP results (13.23% top-5 test error rate) approach the
backpropagation baseline (12.20%) and beat the seminal AlexNet benchmark (15.3%) [Krizhevsky
et al., 2012].

At smaller scale (VGG5), our sensitivity analysis to hyperparameters revealed new insights about
both EP and PCNs. First we showed that, by allowing to choose the cost function to optimize, the
nudging-based perturbation method of EP presents significant advantages over the clamping-based
technique typically used in PCNs. Our results show that, while little to no difference is observed
between the methods on CIFAR100, the cross-entropy-nudging technique leads to a significant
improvement over both the MSE-nudging and the clamping techniques on the more challenging
ImageNet 32x32 dataset. Second, our results challenge common assumptions on EP, showing that on
ImageNet 32x32, the backward and random schemes both perform competitively with the centered
scheme typically employed by default in EP experiments. The random scheme remains competitive
with the centered scheme on full-size ImageNet. The backward and random schemes are especially
attractive in the context of PCNs where energy derivatives at the free equilibrium state are zero,
resulting in a single-phase algorithm, which also roughly halves the duration of experiments. Third,
our results show that EP works even in the regime where the nudging parameter _β_ is tiny (up to
_β_ _≈_ 0 _._ 0002 in our experiments), much smaller than typical values used in earlier EP experiments.

Our extensive study conducted on the VGG5 model also revealed that, while classification accuracy
varies depending on hyperparameters such as the cost function (mean squared error or cross-entropy),
weight initialization and the batch size, in every situation the performance obtained with EP is
comparable to BP. These results position EP as a viable alternative to BP for SGD-based optimization
(stochastic gradient descent), while also highlighting that SGD is only one component of an effective
learning system, with other factors - such as the choice of cost function, initialization scheme and the
batch size - playing a crucial role in determining final performance.

Beyond the PCNs studied in this work, EP has applications in a broad range of models, including
analog hardware systems where inference and gradient extraction are directly performed by the
system’s physics [Dillavou et al., 2022, Yi et al., 2023, Laydevant et al., 2024]. Although it is unclear
whether PCNs could be efficiently implemented onto such hardware - see Zahid et al. [2023] for a
critical review of this question - they may be useful for future developments of EP in at least two
ways. First, PCNs allow us to evaluate the performance of EP on standard feedforward neural network
models and compare with the BP baseline. Second, they can also be used as a baseline for physical
systems of the same size: for instance, the construction by Scellier and Mishra [2025] to convert
an MLP into an approximately equivalent nonlinear resistor network provides a direct benchmark.
Consequently, as we attempt to scale the training of physical systems with EP, PCNs constitute a
useful concept to decouple EP-related challenges from model-specific issues. In this regard, our
experimental results strengthen EP’s standing as an effective training method, and suggest that current
challenges encountered in scaling simulations of EP in physical networks might come more from
the expressivity and trainability of these systems than from EP itself (or perhaps from the interplay
between both).

9

**Acknowledgements**

This work has been funded by Rain AI and the Advanced Research + Invention Agency’s (ARIA)
Scaling Compute programme.

**References**

Lauren E Altman, Menachem Stern, Andrea J Liu, and Douglas J Durian. Experimental demonstration

of coupled learning in elastic networks. _Physical Review Applied_, 22(2):024053, 2024.

Jason Ansel, Edward Yang, Horace He, Natalia Gimelshein, Animesh Jain, Michael Voznesensky,

Bin Bao, Peter Bell, David Berard, Evgeni Burovski, Geeta Chauhan, Anjali Chourdia, Will
Constable, Alban Desmaison, Zachary DeVito, Elias Ellison, Will Feng, Jiong Gong, Michael
Gschwind, Brian Hirsh, Sherlock Huang, Kshiteej Kalambarkar, Laurent Kirsch, Michael Lazos,
Mario Lezcano, Yanbo Liang, Jason Liang, Yinghai Lu, CK Luk, Bert Maher, Yunjie Pan, Christian
Puhrsch, Matthias Reso, Mark Saroufim, Marcos Yukio Siraichi, Helen Suk, Michael Suo, Phil
Tillet, Eikan Wang, Xiaodong Wang, William Wen, Shunting Zhang, Xu Zhao, Keren Zhou,
Richard Zou, Ajit Mathews, Gregory Chanan, Peng Wu, and Soumith Chintala. PyTorch 2: Faster
Machine Learning Through Dynamic Python Bytecode Transformation and Graph Compilation.
In _29th ACM International Conference on Architectural Support for Programming Languages and_
_Operating Systems, Volume 2 (ASPLOS ’24)_ . ACM, April 2024. doi: 10.1145/3620665.3640366.
URL `[https://docs.pytorch.org/assets/pytorch2-2.pdf](https://docs.pytorch.org/assets/pytorch2-2.pdf)` .

Pierre Baldi and Fernando Pineda. Contrastive learning and neural oscillations. _Neural Computation_,

3(4):526–545, 1991.

Miguel Carreira-Perpinan and Weiran Wang. Distributed optimization of deeply nested systems. In

_Artificial Intelligence and Statistics_, pages 10–19. PMLR, 2014.

Jia Deng, Wei Dong, Richard Socher, Li-Jia Li, Kai Li, and Li Fei-Fei. Imagenet: A large-scale

hierarchical image database. In _2009 IEEE conference on computer vision and pattern recognition_,
pages 248–255. Ieee, 2009.

Sam Dillavou, Menachem Stern, Andrea J Liu, and Douglas J Durian. Demonstration of decentralized

physics-driven learning. _Physical Review Applied_, 18(1):014040, 2022.

Sam Dillavou, Benjamin D Beyer, Menachem Stern, Andrea J Liu, Marc Z Miskin, and Douglas J

Durian. Machine learning without a processor: Emergent learning in a nonlinear analog network.
_Proceedings of the National Academy of Sciences_, 121(28):e2319718121, 2024.

Cédric Goemaere, Johannes Deleu, and Thomas Demeester. Accelerating hopfield network dynamics:

Beyond synchronous updates and forward euler. In _Proceedings of the 1st ECAI Workshop on_
_"Machine Learning Meets Differential Equations:_ _From Theory to Applications"_, volume 255 of
_Proceedings of Machine Learning Research_, pages 1–21. PMLR, 2024.

Cédric Goemaere, Gaspard Oliviers, Rafal Bogacz, and Thomas Demeester. Error optimization: Overcoming exponential signal decay in deep predictive coding networks. _arXiv preprint_
_arXiv:2505.20137_, 2025.

Akhilesh Gotmare, Valentin Thomas, Johanni Michael Brea, and Martin Jaggi. Decoupling back
propagation using constrained optimization methods. In _ICML’s Workshop on Credit Assignment_
_in Deep Learning and Deep Reinforcement Learning_, 2018.

Geoffrey E Hinton. Training products of experts by minimizing contrastive divergence. _Neural_

_computation_, 14(8):1771–1800, 2002.

Geoffrey E Hinton and James McClelland. Learning representations by recirculation. In _Neural_

_information processing systems_, 1987.

Geoffrey E Hinton and Terrence J Sejnowski. Optimal perceptual inference. In _Proceedings_ _of_

_the IEEE conference on Computer Vision and Pattern Recognition_, volume 448, pages 448–453.
Washington, 1983.

10

Rasmus Høier, D Staudt, and Christopher Zach. Dual propagation: Accelerating contrastive hebbian

learning with dyadic neurons. In _International Conference on Machine Learning_, pages 13141–
13156. PMLR, 2023.

Rasmus Høier, Tugdual Kerjan, and Benjamin Scellier. Training a convergent energy transformer

with equilibrium propagation. In _New Frontiers in Associative Memories-Workshop at ICLR 2026_,
2026.

Francesco Innocenti, El Mehdi Achour, and Christopher L Buckley. mu-pc: Scaling predictive coding

to 100+ layer networks. _Advances in Neural Information Processing Systems_, 38:87414–87455,
2026.

Jack Kendall. A gradient estimator for time-varying electrical networks with non-linear dissipation.

_arXiv preprint arXiv:2103.05636_, 2021.

Jack Kendall, Ross Pantone, Kalpana Manickavasagam, Yoshua Bengio, and Benjamin Scellier.

Training end-to-end analog neural networks with equilibrium propagation. _arXiv_ _preprint_
_arXiv:2006.01981_, 2020.

Alex Krizhevsky, Geoffrey Hinton, et al. Learning multiple layers of features from tiny images, 2009.

URL `[https://www.cs.toronto.edu/~kriz/learning-features-2009-TR.pdf](https://www.cs.toronto.edu/~kriz/learning-features-2009-TR.pdf)` .

Alex Krizhevsky, Ilya Sutskever, and Geoffrey E Hinton. Imagenet classification with deep convolu
tional neural networks. _Advances in neural information processing systems_, 25, 2012.

Axel Laborieux and Friedemann Zenke. Holomorphic equilibrium propagation computes exact

gradients through finite size oscillations. _Advances in neural information processing systems_, 35:
12950–12963, 2022.

Axel Laborieux, Maxence Ernoult, Benjamin Scellier, Yoshua Bengio, Julie Grollier, and Damien

Querlioz. Scaling equilibrium propagation to deep convnets by drastically reducing its gradient
estimator bias. _Frontiers in neuroscience_, 15:129, 2021.

Jérémie Laydevant, Danijela Markovi´c, and Julie Grollier. Training an ising machine with equilibrium

propagation. _Nature Communications_, 15(1):3671, 2024.

Yann LeCun, Léon Bottou, Yoshua Bengio, and Patrick Haffner. Gradient-based learning applied to

document recognition. _Proceedings of the IEEE_, 86(11):2278–2324, 1998.

TorchVision maintainers and contributors. Torchvision: Pytorch’s computer vision library. `[https:](https://github.com/pytorch/vision)`

`[//github.com/pytorch/vision](https://github.com/pytorch/vision)`, 2016.

Danijela Markovi´c, Alice Mizrahi, Damien Querlioz, and Julie Grollier. Physics for neuromorphic

computing. _Nature Reviews Physics_, 2(9):499–510, 2020.

Serge Massar. Equilibrium propagation for learning in lagrangian dynamical systems. _Physical_

_Review E_, 112(3):035304, 2025.

Serge Massar and Bortolo Matteo Mognetti. Equilibrium propagation: the quantum and the thermal

cases. _Quantum Studies:_ _Mathematics and Foundations_, 12(1):6, 2025.

Beren Millidge, Anil Seth, and Christopher L Buckley. Predictive coding: a theoretical and experi
mental review. _arXiv preprint arXiv:2107.12979_, 2021.

Beren Millidge, Alexander Tschantz, and Christopher L Buckley. Predictive coding approximates

backprop along arbitrary computation graphs. _Neural Computation_, 34(6):1329–1368, 2022.

Beren Millidge, Yuhang Song, Tommaso Salvatori, Thomas Lukasiewicz, and Rafal Bogacz. Back
propagation at the infinitesimal inference limit of energy-based models: Unifying predictive
coding, equilibrium propagation, and contrastive hebbian learning. In _The Eleventh International_
_Conference on Learning Representations_, 2023.

Ali Momeni, Babak Rahmani, Benjamin Scellier, Logan G Wright, Peter L McMahon, Clara C

Wanjura, Yuhang Li, Anas Skalli, Natalia G Berloff, Tatsuhiro Onodera, et al. Training of physical
neural networks. _Nature_, 645(8079):53–61, 2025.

11

Javier R Movellan. Contrastive hebbian learning in the continuous hopfield model. In _Connectionist_

_Models_, pages 10–17. Elsevier, 1991.

Timothy Nest and Maxence Ernoult. Towards training digitally-tied analog blocks via hybrid gradient

computation. _Advances in Neural Information Processing Systems_, 37:83877–83914, 2024.

Randall C O’Reilly. Biologically plausible error-driven learning using local activation differences:

The generalized recirculation algorithm. _Neural computation_, 8(5):895–938, 1996.

Luca Pinchetti, Chang Qi, Oleh Lokshyn, Cornelius Emde, Amine M’Charrak, Mufeng Tang, Simon

Frieder, Bayar Menzat, Gaspard Oliviers, Rafal Bogacz, Thomas Lukasiewicz, and Tommaso Salvatori. Benchmarking predictive coding networks – made simple. In _The Thirteenth International_
_Conference on Learning Representations_, 2024.

Guillaume Pourcel, Debabrota Basu, Maxence Ernoult, and Aditya Gilra. Lagrangian-based equilib
rium propagation: generalisation to arbitrary boundary conditions & equivalence with hamiltonian
echo learning. _arXiv preprint arXiv:2506.06248_, 2025.

Chang Qi, Matteo Forasassi, Thomas Lukasiewicz, and Tommaso Salvatori. Towards the training of

deeper predictive coding neural networks. _arXiv preprint arXiv:2506.23800_, 2025.

Théophile Rageau and Julie Grollier. Training and synchronizing oscillator networks with equilibrium

propagation. _Neuromorphic Computing and Engineering_, 5(3):034008, 2025.

Karol Sajnok and Michał Matuszewski. Near-equilibrium propagation training in nonlinear wave

systems. _arXiv preprint arXiv:2510.16084_, 2025.

Ruslan Salakhutdinov and Geoffrey Hinton. Deep boltzmann machines. In _Artificial intelligence and_

_statistics_, pages 448–455. PMLR, 2009.

Benjamin Scellier. _A deep learning theory for neural networks grounded in physics_ . PhD thesis,

Université de Montréal, 2021.

Benjamin Scellier. A fast algorithm to simulate nonlinear resistive networks. In _International_

_Conference on Machine Learning_, pages 43477–43503. PMLR, 2024a.

Benjamin Scellier. Quantum equilibrium propagation: gradient-descent training of quantum systems.

In _NeurIPS 2024’s Workshop on Machine Learning with New Compute Paradigms_, 2024b.

Benjamin Scellier and Yoshua Bengio. Equilibrium propagation: Bridging the gap between energy
based models and backpropagation. _Frontiers in computational neuroscience_, 11:24, 2017.

Benjamin Scellier and Siddhartha Mishra. Universal approximation theorem for nonlinear resistive

networks. _Physical Review Applied_, 23(4):044009, 2025.

Benjamin Scellier, Siddhartha Mishra, Yoshua Bengio, and Yann Ollivier. Agnostic physics-driven

deep learning. _arXiv preprint arXiv:2205.15021_, 2022.

Benjamin Scellier, Maxence Ernoult, Jack Kendall, and Suhas Kumar. Energy-based learning

algorithms for analog computing: a comparative study. _Advances in neural information processing_
_systems_, 36:52705–52731, 2023.

Menachem Stern, Daniel Hexner, Jason W Rocks, and Andrea J Liu. Supervised learning in physical

networks: From machine learning to learning machines. _Physical Review X_, 11(2):021045, 2021.

Gavin Taylor, Ryan Burmeister, Zheng Xu, Bharat Singh, Ankit Patel, and Tom Goldstein. Training

neural networks without gradients: A scalable admm approach. In _International conference on_
_machine learning_, pages 2722–2731. PMLR, 2016.

Qingshan Wang, Clara C Wanjura, and Florian Marquardt. Training coupled phase oscillators as a

neuromorphic platform using equilibrium propagation. _Neuromorphic Computing and Engineering_,
4(3):034014, 2024.

Clara C Wanjura and Florian Marquardt. Quantum equilibrium propagation for efficient training of

quantum systems based on onsager reciprocity. _Nature Communications_, 16(1):6595, 2025.

12

James CR Whittington and Rafal Bogacz. An approximation of the error backpropagation algorithm

in a predictive coding network with local hebbian synaptic plasticity. _Neural computation_, 29(5):
1229–1262, 2017.

James CR Whittington and Rafal Bogacz. Theories of error back-propagation in the brain. _Trends in_

_cognitive sciences_, 23(3):235–250, 2019.

Su-in Yi, Jack D Kendall, R Stanley Williams, and Suhas Kumar. Activity-difference training of deep

neural networks using memristor crossbars. _Nature Electronics_, 6(1):45–51, 2023.

Christopher Zach. Bilevel programs meet deep learning: A unifying view on inference learning

methods. _arXiv preprint arXiv:2105.07231_, 2021.

Umais Zahid, Qinghai Guo, and Zafeirios Fountas. Predictive coding as a neuromorphic alternative

to backpropagation: a critical evaluation. _Neural Computation_, 35(12):1881–1909, 2023.

Gianluca Zoppo, Francesco Marrone, Michele Bonnin, and Fernando Corinto. Equilibrium propaga
tion and (memristor-based) oscillatory neural networks. In _2022 IEEE international symposium on_
_circuits and systems (ISCAS)_, pages 639–643. IEEE, 2022.

13

**A** **Nudge-Phase Dynamics:** **Traversal Scheme, Step Size, Modified PGD, and**
**Equilibration Curves**

In this appendix, we provide a complete description of the nudge-phase dynamics used in our
experiments. In particular, we justify experimentally the choice _α_ = 1 for the step size, and we
present a modified version of PGD combined with an asynchronous traversal scheme, which we found
to work better than PGD with synchronous updates. We also take a close look at the nudge-phase
equilibration curves, i.e. the total energy ( _F_ ) as a function of the number of nudge iterations ( _K_ ).

**A.1** **Traversal Scheme and Step Size**

Updating all the layers synchronously at each iteration of the PGD scheme does not work well in
practice. Instead, we find that an ‘asynchronous update’ scheme works much better: at every iteration,
we first update the layers of even indices (one half of the layers) and then we update the layers of
odd indices (the other half of the layers). Relaxing all the layers once (first the even layers, then the
odd layers) constitutes one _iteration_ . We repeat as many iterations as is necessary until convergence
to the nudged equilibrium. This asynchronous scheme is similar in spirit to the one used in Deep
Boltzmann Machines [Salakhutdinov and Hinton, 2009], Deep Hopfield Networks [Scellier et al.,
2023, Goemaere et al., 2024] and Deep Resistive Networks [Scellier, 2024a].

Figure 5 shows the performance (test error rates) of the VGG5 model trained on CIFAR-100 for
different step sizes ( _α_ ), different number of nudge-phase iterations ( _K_ ) and different traversal schemes
(synchronous vs asynchronous). The asynchronous update scheme with step size _α_ = 1 performs the
best, and shows equivalent performance for 5, 10 and 20 nudged-phase iterations.

Figure 5: Test error rates obtained with the VGG5 trained on CIFAR100 using different traversal
schedules (synchronous and asynchronous updates), number of nudged phase iterations _K_ (5, 10 and
20) and step sizes _α_ (0.1, 0.5, 1.0). NaN means that training failed and diverged, resulting in NaN
values.

**A.2** **Modified Projected Gradient Descent (mod-PGD)**

In our experiments, we used a modified version of PGD, which we found to work slightly better than
PGD itself. Recall that the PGD update rule with step size _α_ = 1 writes:

_hk_ _←_ ReLU

_<u>k</u>_ <u>+1</u>

ReLU( _ak_ ) + <sup>_∂ϵ_</sup> <sup>2</sup>

_∂hk_

_,_ (19)

where _ak_ is a short hand for the pre-activations, defined such that ReLU( _ak_ ) = _fk_ ( _θk, hk−_ 1). The
‘mod-PGD’ update rule reads

_hk_ _←_ ReLU

_<u>k</u>_ <u>+1</u>

_ak_ + <sup>_∂ϵ_</sup> <sup>2</sup>

_∂hk_

_._ (20)

For the output layer, which does not use a nonlinearity, mod-PGD results in the same update rule as
PGD.

Figure 6 summarizes the behavior of the PGD (19) and mod-PGD (20) dynamics, as a function
depending on the bottom-up signals to the the k-th layer ( _ak_ ) and the top-down signals to the k-th

14

layer (∆ _k_ := _∂hk_ <u>+1</u> _k_ <sup>).</sup> <sup>For a unit</sup> <sup>_i_</sup> <sup>in layer</sup> <sup>_k_</sup> <sup>, Equations (19) and</sup> <sup>(20) only differ in the case where</sup>

_aki_ _<_ 0 and ∆ _ki_ _>_ 0. This is reflected in Figure 6a and Figure 6b, which only differ in the top
left quadrant. Notably for positive ∆ _ki_, the PGD dynamics ignores inhibitory bottom-up signals
( _aki_ _<_ 0). The mod-PGD dynamics on the other hand allows negative bottom-up signals to act as
an inhibitory buffer, meaning bottom-up inhibited units remain inactive unless the top-down signal
is sufficiently strong. By tempering the top-down signals in this manner, the mod-PGD dynamics
remain closer to the free phase equilibrium than the PGD dynamics.

layer (∆ _k_ :=

_∂ϵ_ <sup>2</sup> _<u>k</u>_

(a) PGD (b) mod-PGD

Figure 6: Level curves of the update rules prescribed by PGD (RHS of Eq. (19)) and mod-PGD (RHS
of Eq.(20)). We consider a single unit _i_ in layer _k_ .

Table 3 compares PGD and mod-PGD experimentally. On CIFAR100 and ImageNet 32x32, modPGD leads to a very small, yet consistent improvement over PGD. On CIFAR10, however, PGD
performs significantly worse than mod-PGD, or requires more nudge iterations (larger _K_ ). Figure 7
shows the corresponding training curves on CIFAR-10. PGD with _K_ = 10 performs on par with
mod-PGD with _K_ = 5, but PGD with _K_ = 5 terminates early because training eventually diverged
resulting in NaN values.

Table 3: Comparison of PGD and mod-PGD, where the VGG5 model is trained on different datasets
using MSE-Nudge. The numbers in parenthesis indicate the number of iterations used in the nudge
phase ( _<u>K</u>_ <u>).</u> <u>Results were averaged over 3 random seeds.</u>

Algorithm CIFAR-10 CIFAR-100 ImageNet 32x32
(K iterations) Top1 Top1 Top5 Top1 Top5

0 20 40 60 80 100
Epoch

Figure 7: Comparison of PGD and mod-PGD on the VGG5 model trained on CIFAR10 using
Nudge-MSE. Solid lines indicate the mean over three runs and shaded areas indicate _±_ one standard
deviation. The PGD experiments with 5 iterations consistently diverged around epoch 50. These
results correspond to those reported in Table 3.

15

**A.3** **Nudge-Phase Equilibration Curves**

Finally, we take a closer look at the nudge-phase equilibration dynamics. Figure 8 shows the total
energy ( _F_ = _E_ + _βC_ ) as a function of the number of nudge iterations ( _K_ ) for the VGG10 model,
using both PGD and mod-PGD. We make a few comments.

First, the equilibration curves show a significant spike in the total energy, starting around _K_ = 5 and
stabilizing at _K_ = 10. These curves justify our choice of _K_ = 10 in the VGG10 experiments.

Second, using the asynchronous update scheme (where at each iteration one first updates the even
layers and then the odd layers), the teaching signals introduced at the output layer at the beginning
of the nudge phase propagate two layers per iteration. Hence, the beginning of the spike at _K_ = 5
coincides with the minimal number of iterations required for the teaching signals to propagate from
the output layer to the input layer.

The spike is generally larger for PGD than for mod-PGD, which is consistent with our observation
(Appendix A.2) that, in comparison with PGD, mod-PGD tempers top-down (error) signals.

Perhaps most importantly, the total energy does not decrease as a function of _K_ during the nudgephase equilibration. In fact, recalling that the initial state of the network is the free equilibrium, the
nudge equilibrium ( _K_ = 10) often has higher energy than the free equilibrium ( _K_ = 0), which
translates as ∆ _F_ _>_ 0 in Table 8. This shows that the nudge equilibrium is not, in general, the global
minimum of _F_ . EP, however, only requires the first-order stationary condition of Eq. (5). Thus, the
nudge equilibrium may as well be a local minimum or even a saddle point of _F_, and our PGD and
mod-PGD dynamics might be better understood as fixed point iteration methods that find critical
points of _F_, rather than as minimizing _F_ . Similar observations were recently made in the Convergent
Energy Transformer [Høier et al., 2026].

We note that our nudge-phase equilibration approach is different from that of Pinchetti et al. [2024],
who employed GD with momentum, using tiny learning rates.

(a) Mod-PGD with _β_ = 0 _._ 05 (b) PGD with _β_ = 0 _._ 05

(c) Mod-PGD with _β_ = _−_ 0 _._ 05 (d) PGD with _β_ = _−_ 0 _._ 05

Figure 8: Nudge-phase equilibration curves for the VGG10 model evaluated on 8 random images
from the ImageNet validation set. The plot represents the total energy _F_ as a function of the number
of nudge iterations ( _K_ ), for both mod-PGD and PGD as well as for both positive ( _β_ = 0 _._ 05) and
negative ( _β_ = _−_ 0 _._ 05) values of the nudging parameter. The dashed gray line corresponds to _K_ = 10,
the value of _K_ used in our training experiments. The energy gap between the free state and nudge
state is defined as ∆ _F_ = _F_ ( _K_ = 10) _−_ _F_ ( _K_ = 0).

16

**B** **Experimental Details**

In this appendix, we provide the implementation details for our experiments.

**B.1** **Datasets**

We use five datasets: MNIST, CIFAR-10, CIFAR-100, ImageNet32 and (full-size) ImageNet.

The MNIST dataset is composed of images of handwritten digits [LeCun et al., 1998]. Each image _x_
in the dataset is a 28 _×_ 28 gray-scaled image and comes with a label _y_ _∈{_ 0 _,_ 1 _, . . .,_ 9 _}_ indicating the
digit that the image represents. The dataset contains 60,000 training images and 10,000 test images.

The CIFAR-10 dataset [Krizhevsky et al., 2009] consists of 60,000 colour images of 32 _×_ 32 pixels.
These images are split in 10 classes (each corresponding to an object or animal), with 6,000 images
per class. The training set consists of 50,000 images and the test set of 10,000 images.

The CIFAR-100 dataset [Krizhevsky et al., 2009] also comprises 60,000 color images with a resolution
of 32 _×_ 32 pixels, featuring a diverse set of objects and animals. These images are categorized into
100 distinct classes, each containing 600 images. Like CIFAR-10, the dataset is divided into a training
set with 50,000 images and a test set containing the remaining 10,000 images.

The ImageNet dataset [Deng et al., 2009] contains over a million high-resolution images, spanning
thousands of object categories. Specifically, in the 2012 Large Scale Visual Recognition Challenge
(ILSVRC2012), a popular subset of ImageNet, there are 1,000 distinct classes, each populated with
a variable number of images. The ILSVRC2012 subset divides the dataset into a set for training,
validation, and testing, facilitating comparisons across different approaches.

In addition to ImageNet (which here refers to the dataset with full-resolution images), we also
consider the ImageNet32 variant, which consists of all images of the ImageNet dataset downsampled
to 32x32 pixel images.

**Data** **pre-processing** **and** **data** **augmentation.** The data is normalized using the parameters
provided in Table 4.

Table 4: Data normalization. We normalize the input images using the recommended mean ( _µ_ ) and
std ( _σ_ ) values for each dataset. The MNIST images are gray-scale, i.e. they have a unique channel.
The CIFAR-10, CIFAR-100 and ImageNet images are color images, i.e. <u>they have three channels.</u>

mean ( _µ_ ) std ( _σ_ )

MNIST 0.1307 0.3081
CIFAR-10 (0.4914, 0.4822, 0.4465) (0.2023, 0.1994, 0.2010)
CIFAR-100 (0.5071, 0.4867, 0.4408) (0.2675, 0.2565, 0.2761)
ImageNet (0.485, 0.456, 0.406) (0.229, 0.224, 0.225)

To make the VGG5 model compatible with MNIST, each image of the MNIST dataset (of size 28x28)
is augmented to a 32x32-pixel image by adding two pixels at the top, two pixels at the bottom, two
pixels to the left and two pixels to the right.

Finally, during training, we use random horizontal flipping and random cropping on CIFAR-10,
CIFAR-100 and ImageNet. These stochastic augmentations are not used at test time. These stochastic
augmentations are not used on MNIST either.

**B.2** **VGG architectures**

Table 5 and Table 6 contain the architectural details of the VGG5 and VGG10 models, respectively,
as well as the hyperparameters used to obtain the results reported in Figure 4, Table 1 and Table 2.
Both VGG models use a combination of stacked convolutions and pooling layers followed by dense
layers. All convolutional operations use stride 1, while max pooling operations use stride 2.

17

Table 5: VGG5 architecture. num_inputs is 1 for MNIST, and 3 for other datasets (CIFAR10,
CIFAR100 and ImageNet variants). num_outputs is 10 for MNIST and CIFAR10, 100 for CIFAR100,
and 1000 for ImageNet and ImageNet32.

**Operation** **Channels in** **Channels out** **Kernels**

Conv2d num_inputs 128 3 _×_ 3

Conv2d 128 256 3 _×_ 3

MaxPool         -         - 2 _×_ 2

Conv2d 256 512 3 _×_ 3

MaxPool         -         - 2 _×_ 2

Conv2d 512 512 3 _×_ 3

MaxPool         -         - 2 _×_ 2

Conv2d 512 512 3 _×_ 3

MaxPool         -         - 2 _×_ 2

Dense num_outputs

<u>Table 6:</u> <u>VGG10 architecture</u>

**Operation** **Channels in** **Channels out** **Kernels**

Conv2d 3 64 3 _×_ 3

MaxPool         -         - 2 _×_ 2

Conv2d 64 128 3 _×_ 3

MaxPool         -         - 2 _×_ 2

Conv2d 128 256 3 _×_ 3

Conv2d 256 256 3 _×_ 3

MaxPool         -         - 2 _×_ 2

Conv2d 256 512 3 _×_ 3

Conv2d 512 512 3 _×_ 3

MaxPool         -         - 2 _×_ 2

Conv2d 512 512 3 _×_ 3

Conv2d 512 512 3 _×_ 3

MaxPool         -         - 2 _×_ 2

Dense 2048

Dense 1000

18

**Weight initialization.** We initialize the weights of dense interactions and convolutional interactions
according to

_wij_ _∼U_ ( _−c,_ + _c_ ) _,_ _c_ = _γ_

- <u>1</u>
(21)
fan_mode

which is the ‘Kaiming uniform’ scheme rescaled by a factor _γ_, that we call the ‘gain’ here (i.e.
a scaling number). For both VGG5 and VGG10, dense weights of shape (sizepre, sizepost), have
fanin = sizepre ; for convolutional weights of shape (channelin, channelout, height, width), VGG5
uses fanin = channelin _×_ height _×_ width and VGG10 uses fanout = channelout _×_ height _×_ width

The gain _γ_ was consistently chosen to be 1, except in the setting of the VGG5 trained on ImageNet32
using the MSE where we found that using _γ_ = 0 _._ 2 for the final (output) weight matrix led to
significantly better results, as shown in Figure 3.

**B.3** **Hyperparameters related to training**

We train our VGG networks with both equilibrium propagation (EP) and backpropagation (BP).
Training using BP is done the usual way. As for EP, at each training step, we proceed as follows.
First we pick a mini-batch of samples in the training set, _x_, and their corresponding labels, _y_ . Then
we perform a forward pass to compute the free equilibrium, which we store. Assuming we use
the centered scheme, let _β_ _>_ 0 be the nudging value used for training. First, we set the nudging
parameter to _β_ and we perform _K_ asynchronous iterations of mod-PGD (Eq. (20)). Next, we reset
the state of the network to the free equilibrium, then we set the nudging parameter to _−β_, and we
perform a new equilibration phase of _K_ asynchronous iterations of mod-PGD. Finally, we update all
the parameters simultaneously in a single ‘parameter update’ phase. See Table 7 and Table 8 for the
hyperparameters used.

**Optimizer and scheduler.** We use mini-batch gradient descent (SGD) with momentum, weight
decay and the Nesterov method. We also use a cosine-annealing scheduler for the learning rates with
hyperparameters _T_ max and _η_ min.

**Hyperparameter Optimization.** We used a two-stage hyperparameter tuning strategy, where we
first tuned the hyperparameters shared by BP-based and EP-based training (weight initialization
schemes, cost function, learning rates, weight decay, batch size, ...), and subsequently tuned the
EP specific hyperparameters (perturbation approach, finite difference scheme, nudging sternght _β_,
number of nudge iterations _K_, and PGD variant). This two-stage strategy is justified by the fact that,
when employing the nudging-based perturbation approach, in the limit when _β_ tends to 0, the EP
gradients are equal to the BP gradients. Tuning was done manually with hyperparameter sweeps, but
without Optuna or other black-box tools.

**Computational resources.** The code for the simulations uses Pytorch 2.9 [Ansel et al., 2024] and
TorchVision 0.24 [maintainers and contributors, 2016]. The simulations were carried on Nvidia
A100 GPUs. The VGG10 experiments on ImageNet using EP took 18 days (resp. 10 days) for the
centered scheme (resp. backward scheme and random scheme) to complete on a single GPU. The BP
experiment took 36 hours to complete. Each VGG5 experiment on ImageNet32 using EP took 17
hours to complete.

Our implementation is based on PyTorch’s eager execution mode, and could likely be accelerated by
using _just in time_ compilation (as is done in [Pinchetti et al., 2024]).

**B.4** **Training Curves of the VGG10 Experiments on ImageNet**

Figure 9 shows the training curves (Top1 and Top5 error rates) obtained with the VGG10 network
trained on full-size ImageNet.

19

<u>Table 7:</u> <u>Hyperparameter values used in the VGG5 experiments to obtain the results of Table 1.</u>

MNIST CIFAR-10 CIFAR-100 ImageNet32

mini-batch size with MSE 16 16 16 256
mini-batch size cross-entropy (CE) 64 64 64 256
nudging ( _β_ ) 0.02
num. iterations of mod-PGD ( _K_ ) 5
learning rate ( _η_ ) with MSE 0.04
learning rate ( _η_ ) with CE 0.01
momentum 0.9
weight decay 3 e-4
number of epochs 100
_T_ max (scheduler hyperparameter) 100
_η_ min (scheduler hyperparameter) 1e-6

Table 8: Hyperparameters used for the VGG10 training experiments on ImageNet.

ImageNet

nudging strength ( _β_ ) 0.05
number of nudge-phase iterations ( _K_ ) 10
learning rates (for the trainable parameters) 0.02
momentum 0.9
weight decay 2 e-4
mini-batch size 256
number of epochs 50
cosine annealing scheduler parameter _T_ max 50
cosine annealing scheduler parameter _η_ min 2.0 e-6

65

60

55

50

45

40

35

30

0 10 20 30 40 50
Epoch

(a) Top1 test error rate

0 10 20 30 40 50
Epoch

(b) Top5 test error rate

40

35

30

25

20

15

10

Figure 9: Training curves of the VGG10 experiments on full-size Imagenet. We observe a small gap
between centered EP and BP.

20

**C** **Traditional PCN Training, EP’s Contrastive Function and the Penalty**
**Method**

In this appendix, we revisit several connections between PCNs, EP and the penalty method. In
particular, we:

    - derive the PCN energy function from its probabilistic interpretation,

    - review the traditional learning algorithm for PCNs,

    - relate the EP contrastive function to the standard PCN objective,

    - discuss the connection between EP-trained PCNs and the penalty method.

**C.1** **Probabilistic Interpretation of PCNs**

The PCN energy function is commonly motivated from a probabilistic perspective. For each layer _k_,
the state _hk_ is assumed to be conditionally Gaussian given the previous layer:

_hk_ _∼N_

- _fk_ ( _θk, hk−_ 1) _, σk_ <sup>2</sup> <sup>_I_</sup>

- _,_ (22)

where _fk_ is the feedforward transformation parameterized by _θk_, and _σk_ is the standard deviation.
Equivalently, the conditional density of _hk_ given _hk−_ 1 is

<u>1</u>
_Pθk_ ( _hk_ _| hk−_ 1) =
(2 _πσk_ <sup>2</sup>

- _−_ <sup><u>1</u></sup>

2 _σk_ <sup>2</sup>

_,_ (23)

_k_ <sup>2)</sup> <sup>_dk/_</sup> <sup>2</sup> <sup>exp</sup>

_∥hk −_ _fk_ ( _θk, hk−_ 1) _∥_ <sup>2</sup>

where _dk_ denotes the dimensionality of layer _k_ . The full network therefore defines the conditional
distribution

_Pθk_ ( _hk_ _| hk−_ 1) _,_ (24)

_Pθ_ ( _h_ 1 _, . . ., hL_ _| h_ 0 = _x_ ) =

_L_

_k_ =1

where _h_ 0 = _x_ is the network input. Given an input _x_, inference in a PCN consists of finding the most
likely latent configuration:

arg max log _Pθ_ ( _h | x_ ) _,_ (25)

_h_

where _h_ = ( _h_ 1 _, . . ., hL_ ) denotes the network state. Taking the negative log-likelihood yields

_._ (26)

_−_ log _Pθ_ ( _h | x_ ) =

_L_

_k_ =1

- _<u>dk</u>_ <u>1</u>
2 <sup>log(2</sup> <sup>_πσ_</sup> _k_ <sup>2) +</sup> 2 _σk_ <sup>2</sup>

_∥hk −_ _fk_ ( _θk, hk−_ 1) _∥_ <sup>2</sup>

Choosing _σk_ = 1 for all _k_, the negative log-likelihood reduces, up to an additive constant, to the PCN
energy function of Eq. (10):

_−_ log _Pθ_ ( _h | x_ ) = _E_ PCN( _θ, x, h_ ) + const _._ (27)

Thus, maximizing the conditional likelihood is equivalent to minimizing the PCN energy function.

**C.2** **Traditional Learning Algorithm for PCNs**

Under the probabilistic interpretation above, learning aims to maximize the conditional likelihood

arg max log _Pθ_ ( _y_ _| x_ ) _,_ (28)

_θ_

where _y_ is the desired target, associated with input _x_ . However, evaluating this likelihood exactly
requires marginalizing over all latent states:

       
log _Pθ_ ( _y_ _| x_ ) = log exp( _−E_ PCN( _θ, x, h_ 1 _, . . ., hL−_ 1 _, y_ )) _dh_ 1 _· · · dhL−_ 1 _,_ (29)

up to an additive constant. This integral is generally intractable. Traditional PCN learning therefore
relies on a maximum a posteriori (MAP) approximation. Given a training pair ( _x, y_ ), the output layer
is clamped to the target value _hL_ = _y_, and the latent states are inferred by minimizing the energy:

_h_ <sup>clamped</sup> 1: _L−_ 1 = arg min (30)

_h_ 1 _,...,hL−_ 1 <sup>_E_</sup> <sup>PCN(</sup> <sup>_θ, x, h_</sup> <sup>1</sup> <sup>_, . . ., hL−_</sup> <sup>1</sup> <sup>_, hL_</sup> <sup>=</sup> <sup>_y_</sup> <sup>)</sup> <sup>_._</sup>

21

The MAP approximation assumes that the integral is dominated by the lowest-energy configuration:

             _e_ <sup>_−E_</sup> <sup>(</sup> <sup>_h_</sup> <sup>)</sup> _dh ≈_ _e_ <sup>_−E_</sup> <sup>(</sup> <sup>_h_</sup> <sup>clamped)</sup> _._ (31)

Under this approximation,

_−_ log _Pθ_ ( _y_ _| x_ ) _≈_ _E_ PCN( _θ, x, h_ <sup>clamped</sup> 1: _L−_ 1 <sup>_, y_</sup> <sup>) + const</sup> <sup>_._</sup> (32)

This leads to the objective

_J_ ( _θ, x, y_ ) = _E_ PCN( _θ, x, h_ <sup>clamped</sup> 1: _L−_ 1 <sup>_, y_</sup> <sup>)</sup> <sup>_,_</sup> (33)

which approximates the negative conditional log-likelihood up to an additive constant. The traditional
PCN learning rule is obtained by differentiating this objective with respect to the parameters:

_∇θJ_ ( _θ, x, y_ ) = <sup>_<u>∂E</u>_</sup> <sup><u>PCN</u></sup>

<sup>clamped</sup> 1: _L−_ 1 <sup>_, y_</sup> <sup>) +</sup> <sup>_<u>∂E</u>_</sup> <sup><u>PCN</u></sup> ( _θ, x, h_ <sup>clamped</sup> 1: _L−_ 1

_∂h_

<sup><u>PCN</u></sup> ( _θ, x, h_ <sup>clamped</sup> 1: _L−_ 1

_∂θ_

<sup><u>PCN</u></sup> ( _θ, x, h_ <sup>clamped</sup> 1: _L−_ 1

_∂θ_

<sup>clamped</sup> 1: _L−_ 1 <sup>_, y_</sup> <sup>)</sup> <sup>_·_</sup> <sup>_∂h_</sup> <u>1:</u> <sup>clamped</sup> _<u>L−</u>_ <u>1</u> (34)

_∂θ_

= <sup>_<u>∂E</u>_</sup> <sup><u>PCN</u></sup>

<sup>clamped</sup> 1: _L−_ 1 <sup>_, y_</sup> <sup>)</sup> <sup>_,_</sup> (35)

_∂h_ <sup><u>PCN</u></sup> ( _θ, x, h_ <sup>clamped</sup> 1: _L−_ 1

where we use the first order equilibrium condition <sup>_<u>∂E</u>_</sup> _∂h_ <sup><u>PCN</u></sup>

where we use the first order equilibrium condition <sup>_<u>∂E</u>_</sup> _∂h_ <sup><u>PCN</u></sup> ( _θ, x, h_ <sup>clamped</sup> 1: _L−_ 1 <sup>_, y_</sup> <sup>) = 0.</sup> <sup>This recovers the</sup>

standard predictive coding update rule: neural activities are first relaxed toward a minimum of the
energy function, after which synaptic parameters are updated locally using prediction errors and
presynaptic activities.

**C.3** **EP’s Contrastive Function in PCNs**

Unlike traditional PCN learning, EP does not require approximating an intractable posterior distribution and naturally accommodates arbitrary differentiable cost functions. EP introduces an explicit
cost function _C_ and defines the objective

_L_ ( _θ, x, y_ ) = _C_ ( _h_ <sup>0</sup> _⋆_ <sup>_, y_</sup> <sup>)</sup> <sup>_,_</sup> (36)

where the free equilibrium state _h_ <sup>0</sup> _⋆_ <sup>satisfies</sup>

_<u>∂E</u>_

_∂h_

The original EP formula (Eq. (6)) states that

 - _θ, x, h_ <sup>0</sup> _⋆_

 - _θ, x, h_ <sup>0</sup> _⋆_

- = 0 _._ (37)

<sup>_<u>∂F</u>_</sup> _∂θ_ <sup>(</sup> <sup>_θ,_</sup> <sup>0</sup> <sup>_, h_</sup> _⋆_ <sup>0</sup>

_⋆_ <sup>0)</sup>

_∇θL_ ( _θ, x, y_ ) = <sup><u>1</u></sup>

_β_

 - _<u>∂F</u>_ _⋆_
_∂θ_ <sup>(</sup> <sup>_θ, β, hβ_</sup>

_⋆_ <sup>)</sup> <sup>_−_</sup> <sup>_<u>∂F</u>_</sup>

<sup>_β_</sup> _∂θ_

+ _O_ ( _β_ ) _,_ (38)

where the total energy and nudged equilibrium are defined as:

_<u>∂F</u>_
_F_ ( _θ, β, h_ ) = _E_ ( _θ, x, h_ ) + _βC_ ( _h, y_ ) _,_

_∂h_

- _θ, β, h_ <sup>_β_</sup> _⋆_

- _θ, β, h_ <sup>_β_</sup> _⋆_

- = 0 _._ (39)

A more precise statement [Scellier et al., 2023] shows that EP performs exact gradient descent on a
contrastive objective,

_Lβ_ ( _θ, x, y_ ) = <sup><u>1</u></sup>

_β_

 - _F_ ( _θ, β, h_ <sup>_β_</sup> _⋆_

<sup>_β_</sup> _⋆_ <sup>)</sup> <sup>_−_</sup> <sup>_F_</sup> <sup>(</sup> <sup>_θ,_</sup> <sup>0</sup> <sup>_, h_</sup> <sup>0</sup> _⋆_

<sup>0</sup> _⋆_ <sup>)</sup>

- _,_ (40)

satisfying

_Lβ_ ( _θ, x, y_ ) = _L_ ( _θ, x, y_ ) + _O_ ( _β_ ) _,_ and (41)

<sup>_<u>∂F</u>_</sup> _∂θ_ <sup>(</sup> <sup>_θ,_</sup> <sup>0</sup> <sup>_, h_</sup> _⋆_ <sup>0</sup>

_∇θLβ_ ( _θ, x, y_ ) = <sup><u>1</u></sup>

_β_

- _<u>∂F</u>_ _⋆_ <sup>)</sup>
_∂θ_ <sup>(</sup> <sup>_θ, β, hβ_</sup>

_⋆_ <sup>)</sup> <sup>_−_</sup> <sup>_<u>∂F</u>_</sup>

<sup>_β_</sup> _∂θ_

_⋆_ <sup>0)</sup>

_._ (42)

For PCNs, the free equilibrium satisfies _E_ PCN( _θ, h_ <sup>0</sup> _⋆_

<sup>0</sup> _⋆_ <sup>)</sup> <sup>=</sup> <sup>0,</sup> <sup>so</sup> <sup>that</sup> <sup>_F_</sup> <sup>(</sup> <sup>_θ,_</sup> <sup>0</sup> <sup>_, h_</sup> <sup>0</sup> _⋆_

For PCNs, the free equilibrium satisfies _E_ PCN( _θ, h_ <sup>0</sup> _⋆_ <sup>)</sup> <sup>=</sup> <sup>0,</sup> <sup>so</sup> <sup>that</sup> <sup>_F_</sup> <sup>(</sup> <sup>_θ,_</sup> <sup>0</sup> <sup>_, h_</sup> <sup>0</sup> _⋆_ <sup>)</sup> <sup>=</sup> <sup>0.</sup> <sup>The</sup> <sup>EP</sup>

contrastive objective therefore simplifies to

_L_

_k_ =1

           
_∥hk −_ _fk_ ( _θk, hk−_ 1) _∥_ <sup>2</sup> + _C_ ( _hL_ )

_Lβ_ ( _θ, x, y_ ) = <sup><u>1</u></sup>

_β_

_⋆_ <sup>_β_</sup> <sup>) = min</sup>

_h_

_β_ <sup><u>1</u></sup> <sup>_F_</sup> <sup>(</sup> <sup>_θ, β, h_</sup> _⋆_ <sup>_β_</sup>

<u>1</u>

_β_

_._ (43)

22

This objective is illustrated in Figure 10. The EP gradient also simplifies:

_∇θLβ_ ( _θ, x, y_ ) = <sup><u>1</u></sup>

_β_

_<u>∂F</u>_

_∂θ_ <sup>(</sup> <sup>_θ, β, h_</sup> _⋆_ <sup>_β_</sup>

_⋆_ <sup>_β_</sup> <sup>)</sup> <sup>_._</sup> (44)

To see this, we note that <sup>_<u>∂F</u>_</sup> _∂h_

_⋆_ <sup>0)</sup> <sup>=</sup> <sup>0 by definition, since</sup> <sup>_h_</sup> <sup>0</sup> _⋆_

<sup>_<u>∂F</u>_</sup> _∂h_ <sup>(</sup> <sup>_θ,_</sup> <sup>0</sup> <sup>_, h_</sup> _⋆_ <sup>0</sup>

<sup>_<u>∂F</u>_</sup> _∂θ_ <sup>(</sup> <sup>_θ,_</sup> <sup>0</sup> <sup>_, h_</sup> _⋆_ <sup>0</sup>

To see this, we note that <sup>_<u>∂F</u>_</sup> _∂h_ <sup>(</sup> <sup>_θ,_</sup> <sup>0</sup> <sup>_, h_</sup> _⋆_ <sup>0)</sup> <sup>=</sup> <sup>0 by definition, since</sup> <sup>_h_</sup> <sup>0</sup> _⋆_ <sup>is a stationary point.</sup> <sup>Moreover,</sup>

_dθd_ <sup>_F_</sup> <sup>(</sup> <sup>_θ,_</sup> <sup>0</sup> <sup>_, h_</sup> _⋆_ <sup>0) = 0 since</sup> <sup>_F_</sup> <sup>(</sup> <sup>_θ,_</sup> <sup>0</sup> <sup>_, h_</sup> <sup>0</sup> _⋆_ <sup>) is identically zero as a function of</sup> <sup>_θ_</sup> <sup>.</sup> <sup>Therefore</sup> <sup>_<u>∂F</u>_</sup> _∂θ_ <sup>(</sup> <sup>_θ,_</sup> <sup>0</sup> <sup>_, h_</sup> _⋆_ <sup>0) =</sup>

<sup>0</sup> _⋆_ <sup>) is identically zero as a function of</sup> <sup>_θ_</sup> <sup>.</sup> <sup>Therefore</sup> <sup>_<u>∂F</u>_</sup> _∂θ_

_⋆_ <sup>0) =</sup>

_⋆_ <sup>0) = 0 since</sup> <sup>_F_</sup> <sup>(</sup> <sup>_θ,_</sup> <sup>0</sup> <sup>_, h_</sup> <sup>0</sup> _⋆_

_dθd_ <sup>_F_</sup> <sup>(</sup> <sup>_θ,_</sup> <sup>0</sup> <sup>_, h_</sup> _⋆_ <sup>0</sup>

_⋆_ <sup>0)</sup> <sup>_−_</sup> <sup>_<u>∂F</u>_</sup> _∂h_

<sup>_<u>∂F</u>_</sup> _∂h_ <sup>(</sup> <sup>_θ,_</sup> <sup>0</sup> <sup>_, h_</sup> _⋆_ <sup>0</sup>

_<u>⋆</u>_

_⋆_ <sup>0)</sup> <sup>_·_</sup> <sup>_<u>∂h</u>_</sup> _∂θ_ <sup>0</sup>

_<u>⋆</u>_

<sup>_<u>∂h</u>_</sup> _∂θ_ <sup>0</sup> <sup>= 0.</sup>

As in Eq. (34), EP-based learning in PCNs proceeds in two stages: first, the network state is relaxed
toward a stationary state of the total energy, and second, the parameters are updated using local
derivatives evaluated at equilibrium.

Figure 10: Illustration of the nudging-based perturbation approach of EP in a PCN. In contrast to
the clamping-based approach typically employed in PCNs, it allows to choose the cost function
_C_ to optimize. Layers of units are represented by _hk_, while layer-wise errors are denoted as
_ϵk_ = _hk −_ _fk_ ( _hk−_ 1 _, θk_ ). The total energy is the sum of squared errors and cost function, _F_ PCN =

<u>1</u> - _L_
2 _k_ =1 <sup>_∥ϵk∥_</sup> <sup>2 +</sup> <sup>_C_</sup> <sup>(</sup> <sup>_hL, y_</sup> <sup>).</sup> <sup>During inference (free phase), the nudging parameter</sup> <sup>_β_</sup> <sup>is set to zero, so</sup>
that no teaching signal enters the network. During training (nudge phase), _β_ is set to a non-zero value,
so that _−β_ _∂h_ <sup>_<u>∂C</u>_</sup> _L_ <sup>nudges the output units</sup> <sup>_hL_</sup> <sup>as in Eq. (18).</sup> <sup>The centered scheme, which performs</sup>

best in our experiments, requires two nudged equilibria: one with _β_ _>_ 0 and one with _β_ _<_ 0. The
diagram is adapted from Millidge et al. [2022].

**C.4** **Relation to the Penalty Method**

The function

_β_ <u>1</u> <sup>_F_</sup> <sup>(</sup> <sup>_θ, β, h_</sup> <sup>) =</sup> <sup>_C_</sup> <sup>(</sup> <sup>_hL, y_</sup> <sup>) +</sup> _β_ <sup><u>1</u></sup>

_L_

_k_ =1

_∥hk −_ _fk_ ( _θk, hk−_ 1) _∥_ <sup>2</sup> (45)

appearing in the definition of _Lβ_ ( _θ_ ) can be viewed as a penalty function associated with the following
constrained minimization problem:

minimize _C_ ( _hL_ ) _,_ subject to _hk_ = _fk_ ( _θk, hk−_ 1) _,_ 1 _≤_ _k_ _≤_ _L._ (46)

This essentially recovers the penalty method. As the coefficient _λ_ = 1 _/β_ tends to + _∞_, the unconstrained problem is equivalent to the constrained problem.

Similar ideas to train feedforward networks using alternatives to backpropagation have been explored
in multiple works [Carreira-Perpinan and Wang, 2014, Taylor et al., 2016, Gotmare et al., 2018, Zach,
2021].

23
