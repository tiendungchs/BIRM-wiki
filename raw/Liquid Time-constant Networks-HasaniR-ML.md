The Thirty-Fifth AAAI Conference on Artificial Intelligence (AAAI-21) 

## **Liquid Time-Constant Networks** 

## **Ramin Hasani,**[1,3] _[∗]_ **Mathias Lechner,**[2] _[∗]_ **Alexander Amini,**[1] **Daniela Rus,**[1] **Radu Grosu**[3] 

> 1 Massachusetts Institute of Technology (MIT) 

> 2 Institute of Science and Technology Austria (IST Austria) 

> 3 Technische Universita¨t Wien (TU Wien) 

rhasani@mit.edu, mathias.lechner@ist.ac.at, amini@mit.edu, rus@csail.mit.edu, radu.grosu@tuwien.ac.at 

## **Abstract** 

We introduce a new class of time-continuous recurrent neural network models. Instead of declaring a learning system’s dynamics by implicit nonlinearities, we construct networks of linear first-order dynamical systems modulated via nonlinear interlinked gates. The resulting models represent dynamical systems with varying (i.e., _liquid_ ) time-constants coupled to their hidden state, with outputs being computed by numerical differential equation solvers. These neural networks exhibit stable and bounded behavior, yield superior expressivity within the family of neural ordinary differential equations, and give rise to improved performance on time-series prediction tasks. To demonstrate these properties, we first take a theoretical approach to find bounds over their dynamics, and compute their expressive power by the _trajectory length_ measure in a latent trajectory space. We then conduct a series of time-series prediction experiments to manifest the approximation capability of Liquid Time-Constant Networks (LTCs) compared to classical and modern RNNs. 

## **Introduction** 

Recurrent neural networks with continuous-time hidden states determined by ordinary differential equations (ODEs), are effective algorithms for modeling time series data that are ubiquitously used in medical, industrial and business settings. The state of a neural ODE, **x** ( _t_ ) _∈_ R _[D]_ , is defined by the solution of this equation (Chen et al. 2018): _d_ **x** ( _t_ ) _/dt_ = _f_ ( **x** ( _t_ ) _,_ **I** ( _t_ ) _, t, θ_ ), with a neural network _f_ parametrized by _θ_ . One can then compute the state using a numerical ODE solver, and train the network by performing reverse-mode automatic differentiation (Rumelhart, Hinton, and Williams 1986), either by gradient descent through the solver (Lechner et al. 2019), or by considering the solver as a black-box (Chen et al. 2018; Dupont, Doucet, and Teh 2019; Gholami, Keutzer, and Biros 2019) and apply the _adjoint method_ (Pontryagin 2018). The open questions are: how expressive are neural ODEs in their current formalism, and can we improve their structure to enable better representation learning? 

Rather than defining the derivatives of the hidden-state directly by a neural network _f_ , one can determine a more stable continuous-time recurrent neural network (CT-RNN) 

> _∗_ Authors with equal contributions Copyright _⃝_ c 2021, Association for the Advancement of Artificial Intelligence (www.aaai.org). All rights reserved. 

by the following equation (Funahashi and Nakamura 1993): _d_ **x** _dt_ ( _t_ ) = _−_ **[x]**[(] _τ[t]_[)] + _f_ ( **x** ( _t_ ) _,_ **I** ( _t_ ) _, t, θ_ ), in which the term _−_ **[x]**[(] _τ[t]_[)] assists the autonomous system to reach an equilibrium state with a time-constant _τ_ . **x** ( _t_ ) is the hidden state, **I** ( _t_ ) is the input, t represents time, and _f_ is parametrized by _θ_ . 

We propose an alternative formulation: let the hidden state flow of a network be declared by a system of linear ODEs of the form: _d_ **x** ( _t_ ) _/dt_ = _−_ **x** ( _t_ ) _/τ_ + **S** ( _t_ ), and let **S** ( _t_ ) _∈_ R _[M]_ represent the following nonlinearity determined by **S** ( _t_ ) = _f_ ( **x** ( _t_ ) _,_ **I** ( _t_ ) _, t, θ_ )( _A −_ **x** ( _t_ )), with parameters _θ_ and _A_ . Then, by plugging in **S** into the hidden states equation, we get: 

**==> picture [203 x 36] intentionally omitted <==**

Eq. 1 manifests a novel time-continuous RNN instance 

**Liquid Time-Constant.** A neural network _f_ not only determines the derivative of the hidden state **x** ( _t_ ), but also serves as an input-dependent varying time-constant ( _τsys_ = _τ_ 1+ _τf_ ( **x** ( _t_ ) _,_ **I** ( _t_ ) _,t,θ_ )[) for the learning system (Time constant is] a parameter characterizing the speed and the coupling sensitivity of an ODE).This property enables single elements of the hidden state to identify specialized dynamical systems for input features arriving at each time-point. We refer to these models as _liquid time-constant_ networks (LTCs). LTCs can be implemented by an arbitrary choice of ODE solvers. In Section 2, we introduce a practical fixed-step ODE solver that simultaneously enjoys the stability of the implicit Euler and the efficiency of the explicit Euler methods. 

**Reverse-Mode Automatic Differentiation of LTCs.** LTCs realize differentiable computational graphs. Similar to neural ODEs, they can be trained by variform of gradient-based optimization algorithms. We settle to trade memory for numerical precision during a backward-pass by using a vanilla backpropagation through-time algorithm to optimize LTCs instead of an adjoint-based optimization method (Pontryagin 2018). In Section 3, we motivate this choice thoroughly. **Bounded Dynamics - Stability.** In Section 4, we show that the state and the time-constant of LTCs are bounded to a finite range. This property assures the stability of the output dynamics and is desirable when inputs to the system relentlessly increase. 

7657 

**Superior Expressivity.** In Section 5, we theoretically and quantitatively analyze the approximation capability of LTCs. We take a functional analysis approach to show the universality of LTCs. We then delve deeper into measuring their expressivity compared to other time-continuous models. We perform this by measuring the _trajectory length_ of activations of networks in a latent trajectory representation. Trajectory length was introduced as a measure of expressivity of feed-forward deep neural networks (Raghu et al. 2017). We extend these criteria to the CT family. 

**Time-Series Modeling.** In Section 6, we conduct a series of eleven time-series prediction experiments and compare the performance of modern RNNs to the time-continuous models. We observe improved performance on a majority of cases achieved by LTCs. 

**Why This Specific Formulation?** There are two primary justifications for the choice of this particular representation: I) LTC model is loosely related to the computational models of neural dynamics in small species, put together with synaptic transmission mechanisms (Sarma et al. 2018; Gleeson et al. 2018; Hasani et al. 2020). The dynamics of nonspiking neurons’ potential, **v** ( _t_ ), can be written as a system of linear ODEs of the form (Lapicque 1907; Koch and Segev 1998): _d_ **v** _/dt_ = _−gl_ **v** ( _t_ ) + **S** ( _t_ ), where **S** is the sum of all synaptic inputs to the cell from presynaptic sources, and _gl_ is a leakage conductance. 

All synaptic currents to the cell can be approximated in steady-state by the following nonlinearity (Koch and Segev 1998; Wicks, Roehrig, and Rankin 1996): **S** ( _t_ ) = _f_ ( **v** ( _t_ ) _,_ **I** ( _t_ )) _,_ ( _A −_ **v** ( _t_ )), where _f_ ( _._ ) is a sigmoidal nonlinearity depending on the state of all neurons, **v** ( _t_ ) which are presynaptic to the current cell, and external inputs to the cell, _I_ ( _t_ ). By plugging in these two equations, we obtain an equation similar to Eq. 1. LTCs are inspired by this foundation. II) Eq. 1 might resemble that of the famous Dynamic Causal Models (DCMs) (Friston, Harrison, and Penny 2003) with a Bilinear dynamical system approximation (Penny, Ghahramani, and Friston 2005). DCMs are formulated by taking a second-order approximation (Bilinear) of the dynamical system _d_ **x** _/dt_ = _F_ ( **x** ( _t_ ) _,_ **I** ( _t_ ) _, θ_ ), that would result in the following format (Friston, Harrison, and Penny 2003): _d_ **x** _/dt_ = ( _A_ + **I** ( _t_ ) _B_ ) **x** ( _t_ ) + _C_ **I** ( _t_ ) with _A_ = _dFd_ **x**[,] _[B]_[=] _dF_[2] _[C]_[=] _dF_[DCM][and][bilinear][dynamical][sys-] _d_ **x** ( _t_ ) _d_ **I** ( _t_ )[,] _d_ **I** ( _t_ )[.] tems have shown promise in learning to capture complex fMRI time-series signals. LTCs are introduced as variants of continuous-time (CT) models that show great expressivity, stability, and performance in modeling time series. 

## **LTCs Forward-Pass By A Fused ODE Solvers** 

Solving Eq. 1 analytically, is non-trivial due to the nonlinearity of the LTC semantics. The state of the system of ODEs, however, at any time point _T_ , can be computed by a numerical ODE solver that simulates the system starting from a trajectory _x_ (0), to _x_ ( _T_ ). An ODE solver breaks down the continuous simulation interval [0 _, T_ ] to a temporal discretization, [ _t_ 0 _, t_ 1 _, . . . tn_ ]. As a result, a solver’s step involves only the update of the neuronal states from _ti_ to _ti_ +1. 

LTCs’ ODE realizes a system of stiff equations (Press 

**Algorithm 1** LTC update by fused ODE Solver 

|**Parameters:** _θ_ = _{τ_ (_N×_1) = time-constant, _γ_(_M×N_) =|
|---|
|weights,_γ_(_N×N_)<br>_r_<br>= recurrent weights,_µ_(_N×_1) = biases_}_,|
|_A_(_N×_1) = bias vector, _L_ = Number of unfolding steps,|
|∆_t_=step size,_N_ =Number of neurons,|
|**Inputs:**_M_-dimensional Input**I**(_t_)of length_T_,**x**(0)|
|**Output:**Next LTC neural state**x**_t_+∆_t_|
|**Function:**FusedStep(**x**(_t_),**I**(_t_),∆_t_,_θ_)|
|**x**(_t_+ ∆_t_)(_N×T_) = **x**(_t_) + ∆_tf_(**x**(_t_)_,_**I**(_t_)_,t,θ_)_⊙A_<br>1+∆_t_<br>�<br>1_/τ_+_f_(**x**(_t_)_,_**I**(_t_)_,t,θ_)<br>�|
|_▷f_(_._), and all divisions are applied element-wise.|
|_▷⊙_is the Hadamard product.|
|**end Function**|
|**x**_t_+∆_t_ =**x**(_t_)|
|**for**_i_= 1_. . . L_**do**|
|**x**_t_+∆_t_ =FusedStep(**x**(_t_),**I**(_t_),∆_t_,_θ_)|
|**end for**|
|**return x**_t_+∆_t_|



et al. 2007). This type of ODE requires an exponential number of discretization steps when simulated with a RungeKutta (RK) based integrator. Consequently, ODE solvers based on RK, such as Dormand–Prince (default in torchdiffeq (Chen et al. 2018)), are not suitable for LTCs. Therefore, we design a new ODE solver that fuses the explicit and implicit Euler methods. Our discretization method results in greater stability, and numerically unrolls a given dynamical system of the form _dx/dt_ = _f_ ( _x_ ) by: 

**==> picture [201 x 11] intentionally omitted <==**

In particular, we replace only the _x_ ( _ti_ ) that occur linearly in _f_ by _x_ ( _ti_ +1). As a result, Eq 2 can be solved for _x_ ( _ti_ +1), symbolically. Applying the Fused solver to the LTC representation, and solving it for **x** ( _t_ + ∆ _t_ ), we get: 

**==> picture [217 x 26] intentionally omitted <==**

Eq. 3 computes one update state for an LTC network. Correspondingly, Algorithm 1 shows how to implement an LTC network, given a parameter space _θ_ . _f_ is assumed to have an arbitrary activation function (e.q. for a _tanh_ nonlinearity _f_ = tanh( _γr_ **x** + _γ_ **I** + _µ_ )). The computational complexity of the algorithm for an input sequence of length _T_ is _O_ ( _L × T_ ), where _L_ is the number of discretization steps. Intuitively, a dense version of an LTC network with _N_ neurons, and a dense version of a long short-term memory (LSTM) (Hochreiter and Schmidhuber 1997) network with _N_ cells, would be of the same complexity. 

## **Training LTC Networks By BPTT** 

Neural ODEs were suggested to be trained by a constant memory cost for each layer in a neural network _f_ by applying the adjoint sensitivity method to perform reverse-mode automatic differentiation (Chen et al. 2018). The adjoint method, however, comes with numerical errors when running in reverse mode. This phenomenon happens because 

7658 

**Algorithm 2** Training LTC by BPTT 

**Inputs:** Dataset of traces [ _I_ ( _t_ ) _, y_ ( _t_ )] of length _T_ , RNNcell = _f_ ( _I, x_ ) **Parameter:** Loss func _L_ ( _θ_ ), initial param _θ_ 0, learning rate _α_ , Output w = _Wout_ , and bias = _bout_ **for** _i_ = 1 _. . ._ number of training steps **do** ( _Ib_ , _yb_ ) = Sample training batch, _x_ := _xt_ 0 _∼ p_ ( _xt_ 0 ) **for** _j_ = 1 _. . . T_ **do** ˆ _x_ = _f_ ( _I_ ( _t_ ) _, x_ ), _y_ ( _t_ ) = _Wout.x_ + _bout_ , _Ltotal_ = � _Tj_ =1 _[L]_[(] _[y][j]_[(] _[t]_[)] _[,]_[ ˆ] _[y][j]_[(] _[t]_[))][,] _[∇][L]_[(] _[θ]_[) =] _[∂L] ∂θ[tot] θ_ = _θ − α∇L_ ( _θ_ ) **end for end for return** _θ_ 

the adjoint method forgets the forward-time computational trajectories, which was repeatedly denoted by the community (Gholami, Keutzer, and Biros 2019; Zhuang et al. 2020). 

On the contrary, direct backpropagation through time (BPTT) trades memory for accurate recovery of the forwardpass during the reverse mode integration (Zhuang et al. 2020). Thus, we set out to design a vanilla BPTT algorithm to maintain a highly accurate backward-pass integration through the solver. For this purpose, a given ODE solver’s output (a vector of neural states), can be recursively folded to build an RNN and then apply Algorithm 2 to train the system. Algorithm 2 uses a vanilla stochastic gradient descent (SGD). One can substitute this with a more performant variant of the SGD, such as Adam (Kingma and Ba 2014), which we use in our experiments. 

**Complexity.** Table 1 summarizes the complexity of our vanilla BPTT algorithm compared to an adjoint method. We achieve a high degree of accuracy on both forward and backward integration trajectories, with similar computational complexity, at large memory costs. 

## **Bounds on** _τ_ **and Neural State of LTCs** 

LTCs are represented by an ODE which varies its timeconstant based on inputs. It is therefore important to see if LTCs stay stable for unbounded arriving inputs (Hasani et al. 2019; Lechner et al. 2020b). In this section, we prove that the time-constant and the state of LTC neurons are bounded to a finite range, as described in Theorems 1 and 2, respectively. 

**Theorem 1.** _Let xi denote the state of a neuron i within an LTC network identified by Eq. 1, and let neuron i receive M incoming connections. Then, the time-constant of the neuron, τsysi , is bounded to the following range:_ 

**==> picture [178 x 12] intentionally omitted <==**

The proof is provided in Appendix. It is constructed based on bounded, monotonically increasing sigmoidal nonlinearity for neural network _f_ and its replacement in the LTC network dynamics. A stable varying time-constant significantly enhances the expressivity of this form of time-continuous RNNs, as we discover more formally in Section 5. 

||**Vanilla BPTT**<br>**Adjoint**|
|---|---|
|||
|Time<br>Memory<br>Depth<br>FWD acc<br>BWD acc|_O_(_L × T ×_2)<br>_O_((_Lf_ +_Lb_)_× T_)<br>_O_(_L × T_)<br>**O(1)**<br>_O_(_L_)<br>_O_(_Lb_)<br>High<br>High<br>**High**<br>Low|



Table 1: Complexity of the vanilla BPTT compared to the adjoint method, for a single layer neural network _f_ . Note: _L_ = number of discretization steps, _Lf_ = L during forwardpass. _Lb_ = L during backward-pass. _T_ = length of sequence, Depth = computational graph depth. 

**Theorem 2.** _Let xi denote the state of a neuron i within an LTC, identified by Eq. 1, and let neuron i receive M incoming connections. Then, the hidden state of any neuron i, on a finite interval Int ∈_ [0 _, T_ ] _, is bounded as follows:_ 

**==> picture [205 x 12] intentionally omitted <==**

The proof is given in Appendix. It is constructed based on the sign of the LTC’s equation’s compartments, and an approximation of the ODE model by an explicit Euler discretization. Theorem 2 illustrates a desired property of LTCs, namely _state stability_ which guarantees that the outputs of LTCs never explode even if their inputs grow to infinity. Next we discuss the expressive power of LTCs compared to the family of time-continuous models, such as CT-RNNs and neural ordinary differential equations (Chen et al. 2018; Rubanova, Chen, and Duvenaud 2019). 

## **On The Expressive Power of LTCs** 

Understanding the impact of a NN’s structural properties on their computable functions is known as the expressivity problem. The very early attempts on measuring expressivity of NNs include theoretical studies based on functional analysis. They show that NNs with three-layers can approximate any finite set of continuous mapping with any precision. This is known as the _universal approximation theorem_ (Hornik, Stinchcombe, and White 1989; Funahashi 1989; Cybenko 1989). Universality was extended to standard RNNs (Funahashi 1989) and even continuous-time RNNs (Funahashi and Nakamura 1993). By careful considerations, we can also show that LTCs are also universal approximators. 

˙ **Theorem 3.** _Let_ _**x** ∈_ R _[n] , S ⊂_ R _[n] and_ _**x**_ = _F_ ( _**x**_ ) _be an autonomous ODE with F_ : _S →_ R _[n] a C_[1] _-mapping_ 

|Activations|**Computational Depth**<br>Neural ODE<br>CT-RNN<br>**LTC**|
|---|---|
|||
|tanh<br>sigmoid<br>ReLU<br>Hard-tanh|0.56_±_0.016<br>4.13_±_2.19<br>9.19_±_2.92<br>0.56_±_0.00<br>5.33_±_3.76<br>7.00_±_5.36<br>1.29_±_0.10<br>4.31_±_2.05<br>56.9_±_9.03<br>0.61_±_0.02<br>4.05_±_2.17<br>81.01_±_10.05|



Table 2: Computational depth of models. Note: # of tries = 100, input samples’ ∆ _t_ = 0 _._ 01, _T_ = 100 sequence length. # of layers = 1, width = 100, _σw_[2][= 2][,] _[ σ] b_[2][= 1][.] 

7659 

**==> picture [354 x 117] intentionally omitted <==**

**----- Start of picture text -----**<br>
Input  6-layer, width 100, tanh activations<br>trajectory<br>PCA<br>a<br>VY<br>Projection to trajectory<br>𝑥 () 𝑡= sin () 𝑡 L1 L2 L3 L4 L5 L6<br>latent 2-D space<br>ee PCA PCA PCA es PCA PCA<br>𝑡= cos(𝑡)<br>𝑦<br>**----- End of picture text -----**<br>


Figure 1: Trajectory’s latent space becomes more complex as the input passes through hidden layers. 

_on S. Let D denote a compact subset of S and assume that the simulation of the system is bounded in the interval I_ = [0 _, T_ ] _. Then, for a positive ϵ, there exist an LTC network with N hidden units, n output units, and an output internal state_ _**u**_ ( _t_ ) _, described by Eq. 1, such that for any rollout {_ _**x**_ ( _t_ ) _|t ∈ I} of the system with initial value x_ (0) _∈ D, and a proper network initialization,_ 

**==> picture [170 x 11] intentionally omitted <==**

The proof defines an _n_ -dimensional dynamical system and place it into a higher dimensional system. The second system is an LTC. The fundamental difference of the proof of LTC’s universality to that of CT-RNNs (Funahashi and Nakamura 1993) lies in the distinction of the semantics of both systems where the LTC network contains a nonlinear input-dependent term in its time-constant module which makes parts of the proof non-trivial. 

The universal approximation theorem broadly explores the expressive power of a neural network. The theorem however, does not yield a concrete measure on where the separation is between different neural network architectures. Therefore, a more rigorous measure of expressivity is demanded to compare models, specifically those networks specialized in spatiotemporal data processing, such as LTCs. The advances made on defining measures for the expressivity of static deep learning models (Pascanu, Montufar, and Bengio 2013; Montufar et al. 2014; Eldan and Shamir 2016; Poole et al. 2016; Raghu et al. 2017) could help measure the expressivity of time-continuous models, both theoretically and quantitatively, which we explore in the next section. 

## **Measuring Expressivity By Trajectory Length** 

A measure of expressivity has to take into account what degrees of complexity a learning system can compute, given 

the network’s capacity (depth, width, type, and weights configuration). A unifying expressivity measure of static deep networks is the _trajectory length_ introduced in (Raghu et al. 2017). In this context, one evaluates how a deep model transforms a given input trajectory (e.g., a circular 2-dimensional input) into a more complex pattern, progressively. 

We can then perform principle component analysis (PCA) over the obtained network’s activations. Subsequently, we measure the length of the output trajectory in a 2- dimensional latent space, to uncover its relative complexity (see Fig. 1). The trajectory length is defined as the _arc length_ of a given trajectory _I_ ( _t_ ), (e.g. a circle in 2D space) (Raghu et al. 2017): _l_ ( _I_ ( _t_ )) = _t[∥][dI]_[(] _[t]_[)] _[/dt][∥][dt]_[.][By][establishing][a] lower-bound for the growth of the trajectory length, one can set a barrier between networks of shallow and deep architectures, regardless of any assumptions on the network’s weight configuration (Raghu et al. 2017), unlike many other measures of expressivity (Pascanu, Montufar, and Bengio 2013; Montufar et al. 2014; Serra, Tjandraatmadja, and Ramalingam 2017; Gabri´e et al. 2018; Hanin and Rolnick 2018, 2019; Lee, Alvarez-Melis, and Jaakkola 2019). We set out to extend the trajectory-space analysis of static networks to time-continuous (TC) models, and to lower-bound the trajectory length to compare models’ expressivity. To this end, we designed instances of Neural ODEs, CT-RNNs and LTCs with shared _f_ . The networks were initialized by weights _∼N_ (0 _, σw_[2] _[/k]_[)][,][and][biases] _[∼N]_[(0] _[, σ] b_[2][)][.][We][then][perform] forward-pass simulations by using different types of ODE solvers, for arbitrary weight profiles, while exposing the networks to a circular input trajectory _I_ ( _t_ ) = _{I_ 1( _t_ ) = sin( _t_ ) _, I_ 2( _t_ ) = cos( _t_ ) _}_ , for _t ∈_ [0 _,_ 2 _π_ ]. By looking at the first two principle components (with an average varianceexplained of over 80%) of hidden layers’ activations, we observed consistently more complex trajectories for LTCs. 

7660 

**==> picture [502 x 323] intentionally omitted <==**

**----- Start of picture text -----**<br>
A Layer1                             Layer2                             Layer3 B 𝜎𝑤 [2] = 1 𝜎𝑤 [2] = 2 𝜎𝑤 [2] = 4 RK45<br>l(N-ODE) = 108.245 l(N-ODE) = 5407.3963 l(N-ODE) = 255299.3159 \(N-ODE) = 76.8928 (N-ODE) = 105.3978 (N-ODE) = 227.3078 Hard tanh<br>l(CT-RNN) = 90.5486 l(CT-RNN) = 1210.7898 l(CT-RNN) = 15949.0123 \(CT-RNN) = 28.807 (CT-RNN) = 84.3868 (CT-RNN) = 208.133<br>l(LTC) = 12481.0242 l(LTC) = 15332.7607 l(LTC) = 17707.2484 LTC) = 3052.0265 LTC) = 16889.202 (LTC) = 276980.4953 Depth = 1<br>_ 5Qo la= 5a > 5ay gaMES <N Width = 100<br>AIKaZEN r)' oN5 OoeF co]2 WhRYYZ\ O°:; ge : 𝜎𝑏2= 1<br>awl — InputsN-ODE y | (A ~ we, —— N-ODE<br>LWN S | — CT-RNNLTC 3aN S S 3m wZZ% 2a Vas’. ——Tc—— CT-RNN<br>1$t Latent Dimension 4° Latent Dimension 1S Latent Dimension<br>1 [st]  Latent Dimension 1 [st]  Latent Dimension 1 [st]  Latent Dimension<br>C Width = 100                  Width = 200 D Width = 100                     Width = 200<br>l(N-ODE) = 81.0841 l(N-ODE) = 110.943 l(N-ODE) = 104.5981 l(N-ODE) = 138.4056<br>l(CT-RNN) = 39.9081 l(CT-RNN) = 54.5492 l(CT-RNN) = 87.9204 l(CT-RNN) = 120.58<br>l(LTC) = 266.2873 l(LTC) = 527.0816 l(LTC) = 18339.8985 l(LTC) = 53858.6441<br>° < }} Bas SQ<br>RK45 Widt h = 10  |   Ha 0  |   rd ta 𝜎 nh 𝑤 [2] = 2|   De | pth = 𝜎𝑏2  3 = 1 2 InputsNCTLT-ODEC-RNN <a ~> Boa<br>1 [st]  Latent Dimension 1 [st]  Latent Dimension 1 [st]  Latent Dimension 1 [st]  Latent Dimension<br>RK45 |  ReLU  | Depth = 1 | 𝜎𝑤 [2] = 2 | 𝜎𝑏2 = 1 RK45 |  Hard tanh  | Depth = 1 | 𝜎𝑤 [2] = 2 | 𝜎𝑏2 = 1<br>E Layer 1                   Layer 2                  Layer 3               Layer 4               Layer 5 RK45<br>l(N-ODE) = 37.1075 l(N-ODE) = 55.8477 l(N-ODE) = 56.8841 l(N-ODE) = 57.0224 l(N-ODE) = 57.6322 tanh<br>l(CT-RNN) = 29.4344 l(CT-RNN) = 24.4596 l(CT-RNN) = 25.1329 l(CT-RNN) = 21.2794 l(CT-RNN) = 21.7574 Depth = 5<br>l(LTC) = 438.7242 l(LTC) = 366.6077 l(LTC) = 406.2259 l(LTC) = 357.9859 l(LTC) = 329.3917<br>Width = 100<br>𝜎𝑤 [2] = 2<br>𝜎𝑏2= 1<br>In puts<br>N- ODE<br>C T-RNN<br>LT C<br>1 [st]  Latent Dimension 1 [st]  Latent Dimension 1 [st]  Latent Dimension 1 [st]  Latent Dimension 1 [st]  Latent Dimension<br> Latent Dimension  Latent Dimension  Latent Dimension<br>nd2 nd2 nd2<br>nd Latent Dimension2 nd Latent Dimension2 nd Latent Dimension2 nd Latent Dimension2<br> Latent Dimension  Latent Dimension  Latent Dimension  Latent Dimension  Latent Dimension<br>nd2 nd2 nd2 nd2 nd2<br>**----- End of picture text -----**<br>


Figure 2: Trajectory length deformation A) in network layers with Hard-tanh activations, B) as a function of the weight distribution scaling factor, C) as a function of network width (ReLU), D) as a function of width (Hard-tanh), and E)in network layers with logistic-sigmoid activations. 

Fig. 2 gives a glimpse of our empirical observations. All networks are implemented by the Dormand-Prince explicit Runge-Kutta(4,5) solver (Dormand and Prince 1980) with a variable step size. We had the following **observations** : 

**I)** Exponential growth of the trajectory length of Neural ODEs and CT-RNNs with Hard-tanh and ReLU activations (Fig. 2A) and unchanged shape of their latent space regardless of their weight profile. 

**II)** LTCs show a slower growth-rate of the trajectory length when designed by Hard-tanh and ReLU, with the compromise of realizing great levels of complexity (Fig. 2A, 2C and 2D). 

**III)** Apart from multi-layer time-continuous models built by Hard-tanh and ReLU activations, in all cases, we observed a longer and a more complex latent space behavior for the LTC networks (Fig. 2B to 2D). 

**IV)** Unlike static deep networks (Fig. 1), we witnessed that the trajectory length does not grow by depth in multi-layer continuous-time networks realized by tanh and sigmoid (Fig. 2E). 

**V)** conclusively, we observed that the trajectory length in TC models varies by a model’s activations, weight and bias distributions variance, width and depth. We presented this 

## more systematically in Fig. 3. 

**VI)** Trajectory length grows linearly with a network’s width (Fig. 3B - Notice the logarithmic growth of the curves in the log-scale Y-axis). 

**VII)** The growth is considerably faster as the variance grows (Fig. 3C). 

**VIII)** Trajectory length is reluctant to the choice of ODE solver (Fig. 3A). 

**IX)** Activation functions diversify the complex patterns explored by the TC system, where ReLU and Hard-tanh networks demonstrate higher degrees of complexity for LTCs. A key reason is the presence of recurrent links between each layer’s cells. 

**Definition of Computational Depth (** _**L**_ **).** For one hidden layer of _f_ in a CT network, _L_ is the average number of integration steps by the solver for each incoming input sample. Note that for an _f_ with _n_ layers we define the total depth as _n × L_ . These observations allow us to formulate lower bounds on the trajectory length growth of CT networks. 

**Theorem 4.** Trajectory Length growth Bounds for Neural ODEs and CT-RNNs. _Let dx/dt_ = _fn,k_ ( _**x**_ ( _t_ ) _,_ _**I**_ ( _t_ ) _, θ_ ) _with θ_ = _{W, b}, represent a Neural ODE and[d]_ _**[x]** dt_[(] _[t]_[)] = 

7661 

**==> picture [505 x 209] intentionally omitted <==**

**----- Start of picture text -----**<br>
A B C<br>10 [4] LTC samples = 100, solver = RK45 LTC samples = 100, solver = RK45<br>600 samples = 100activations = relu LTCN-ODE N-ODECT-RNN activations = tanhdepth = 1,   2w [ = 2,  ] 2b [ = 1] 10 [4] N-ODECT-RNN activations = reludepth = 1,   2b [ = 1]<br>depth = 1,  width = 100 CT-RNN 10 [3]<br>400 2w [ = 2,  ] 2b [ = 1]<br>10 [3]<br>10 [2]<br>200<br>10 [2]<br>10 [1]<br>0<br>RK2(3) RK4(5) ABM1(13) TR-BDF2 10 [1]<br>ODE Solvers 1 2 4 8<br>10 [0] 10 25 50 100 150 200 2<br>Network Width (k) w<br>D<br>LTC samples = 100<br>10 [3] N-ODECT-RNN solver = RK45activations = sigmoiddept h = 6, 2w [ = 2,  ] 2b [ = 1] 100 N-ODE                       CT-RNN                       LTC100 100 100 N-ODE                    CT-RNN                      LTC100 100<br>80 80 80 8 0 80 80<br>10 [2]<br>60 60 6 0 60 60 6 0<br>40 40 40 40 4 0 40<br>10 [1]<br>20 20 20 20 20 20<br>L1 L2 L3 L4 L5 L6 0 1 2 3 4 0 1 2 3 4 0 1 2 3 4 0 1 2 3 4 0 1 2 3 4 0 1 2 3 4<br>Network Layers PC PC PC PC PC PC<br>Trajectory Length Trajectory Length Trajectory Length<br>Trajectory Length<br>Varience Explained (%) Varience Explained (%) Varience Explained (%) Varience Explained (%) Varience Explained (%) Varience Explained (%)<br>**----- End of picture text -----**<br>


Figure 3: Dependencies of the trajectory length measure. A) trajectory length vs different solvers (variable-step solvers). RK2(3): Bogacki-Shampine Runge-Kutta (2,3) (Bogacki and Shampine 1989). RK4(5): Dormand-Prince explicit RK (4,5) (Dormand and Prince 1980). ABM1(13): Adams-Bashforth-Moulton (Shampine 1975). TR-BDF2: implicit RK solver with 1st stage trapezoidal rule and a 2nd stage backward differentiation (Hosea and Shampine 1996). B) Top: trajectory length vs network width. Bottom: Variance-explained of principle components (purple bars) and their cumulative values (solid black line). C) Trajectory length vs weights distribution variance. D) trajectory length vs layers. (More results in the supplements) 

_−_ _**[x]**_[(] _τ[t]_[)] + _fn,k_ ( _**x**_ ( _t_ ) _,_ _**I**_ ( _t_ ) _, θ_ ) _with θ_ = _{W, b, τ } a CT-RNN. f is randomly weighted with_ Hard-tanh _activations. Let_ _**I**_ ( _t_ ) _be a 2D input trajectory, with its progressive points (i.e. I_ ( _t_ + _δt_ ) _) having a perpendicular component to_ _**I**_ ( _t_ ) _for all δt, with L_ = _number of solver-steps. Then, by defining the projection of the first two principle components’ scores of the hidden states over each other, as the 2D_ latent trajectory space _of a layer d, z_[(] _[d]_[)] ( _**I**_ ( _t_ )) = _z_[(] _[d]_[)] ( _t_ ) _, for Neural ODE and CT-RNNs respectively, we have:_ 

**==> picture [251 x 101] intentionally omitted <==**

The proof is provided in Appendix. It follows similar steps as (Raghu et al. 2017) on the trajectory length bounds established for deep networks with piecewise linear activations, with careful considerations due to the continuous-time setup. The proof is constructed such that we formulate a recurrence between the norm of the hidden state gradient in layer _d_ +1, �� _dz/dt_ ( _d_ +1)��, in principle components domain, and the expectation of the norm of the right-hand-side of the differential equations of neural ODEs and CT-RNNs. We then roll back the recurrence to reach the inputs. 

Note that to reduced the complexity of the problem, we only bounded the orthogonal components of the hidden state 

( _d_ +1) image _dz/dt⊥_ , and therefore we have the assump��� ��� tion on input _I_ ( _t_ ), in the Theorem’s statement (Raghu et al. 2017). Next, we find a lower-bound for the LTC networks. **Theorem 5.** Growth Rate of LTC’s Trajectory Length. _Let Eq. 1 determine an LTC with θ_ = _{W, b, τ, A}. With the same conditions on f and I_ ( _t_ ) _, as in Theorem 4, we have:_ 

**==> picture [236 x 80] intentionally omitted <==**

The proof is provided in Appendix. A rough outline: we construct the recurrence between the norm of the hidden state gradients and the components of the right-hand-side of LTC separately which progressively build up the bound. 

## **Discussion of The Theoretical Bounds** 

**I)** As expected, the bound for the Neural ODEs is very similar to that of an _n_ layer static deep network with the exception of the exponential dependencies to the number of solver-steps, _L_ . **II)** The bound for CT-RNNs suggests their shorter trajectory length compared to neural ODEs, according to the base of the exponent. This results consistently matches our experiments presented in Figs. 2 and 3. **III)** Fig. 2B and Fig. 3C show a faster-than-linear growth for LTC’s trajectory length as a function of weight distribution variance. This is confirmed by LTC’s lower bound shown in Eq. 

7662 

|Dataset<br>Metric|LSTM|CT-RNN|Neural ODE|CT-GRU|LTC(ours)|
|---|---|---|---|---|---|
|Gesture<br>(accuracy)<br>Occupancy<br>(accuracy)<br>Activity recognition<br>(accuracy)<br>Sequential MNIST<br>(accuracy)<br>Traffc<br>(squared error)<br>Power<br>(squared-error)<br>Ozone<br>(F1-score)|64.57%_±_0.59<br>93.18%_±_1.66<br>95.85%_±_0.29<br>**98.41**%_±_0.12<br>0.169_±_0.004<br>0.628_±_0.003<br>0.284_±_0.025|59.01%_±_1.22<br>94.54%_±_0.54<br>95.73%_±_0.47<br>96.73%_±_0.19<br>0.224_±_0.008<br>0.742_±_0.005<br>0.236_±_0.011|46.97%_±_3.03<br>90.15%_±_1.71<br>**97.26**%_±_0.10<br>97.61%_±_0.14<br>1.512_±_0.179<br>1.254_±_0.149<br>0.168_±_0.006|68.31%_±_1.78<br>91.44%_±_1.67<br>96.16%_±_0.39<br>98.27%_±_0.14<br>0.389_±_0.076<br>**0.586**_±_0.003<br>0.260_±_0.024|**69.55%**_±_**1.13**<br>**94.63%**_±_**0.17**<br>95.67%_±_0.575<br>97.57%_±_0.18<br>**0.099**_±_0.0095<br>0.642_±_0.021<br>**0.302**_±_0.0155|



Table 3: Time series prediction. Mean and standard deviation, n=5 

9. **IV)** LTC’s lower bound also depicts the linear growth of the trajectory length with the width, _k_ , which validates the results presented in 3B. **V)** Given the computational depth of the models _L_ in Table 2 for Hard-tanh activations, the computed lower bound for neural ODEs, CT-RNNs and LTCs justify a longer trajectory length of LTC networks in the experiments of Section 5. Next, we assess the expressive power of LTCs in a set of real-life time-series prediction tasks. 

|**Algorithm**|**Accuracy**|
|---|---|
|LSTM|83.59%_±_0.40|
|CT-RNN|81.54%_±_0.33|
|Latent ODE|76.48%_±_0.56|
|CT-GRU|85.27%_±_0.39|
|LTC (ours)|**85.48**%_±_**0.40**|



Table 4: Person activity, 1st setting - n=5 

## **Experimental Evaluation** 

In this section, we evaluate the performance of the LTCs compared to the state-of-the-art RNN models in a series of time-series benchmarks. 

## **Time Series Predictions** 

We evaluated the performance of LTCs realized by the proposed Fused ODE solver against the state-of-the-art discretized RNNs, LSTMs (Hochreiter and Schmidhuber 1997), CT-RNNs (ODE-RNNs) (Funahashi and Nakamura 1993; Rubanova, Chen, and Duvenaud 2019), continuoustime gated recurrent units (CT-GRUs) (Mozer, Kazakov, and Lindsey 2017), and Neural ODEs constructed by a 4 _[th]_ order Runge-Kutta solver as suggested in (Chen et al. 2018), in a series of diverse real-life supervised learning tasks. The results are summarized in Table 3. The experimental setup are provided in Appendix. We observed between 5% to 70% performance improvement achieved by the LTCs compared to other RNN models in four out of seven experiments and comparable performance in the other three (see Table 3). 

## **Person Activity Dataset** 

We use the ”Human Activity” dataset described in (Rubanova, Chen, and Duvenaud 2019) in two distinct frameworks. The dataset consists of 6554 sequences of activity of humans (e.g. lying, walking, sitting), with a period of 211 ms. we designed two experimental frameworks to evaluate models’ performance. In the _1st Setting_ , the baselines are the models described before, and the input representations are unchanged (details in Appendix). LTCs outperform all models and in particular CT-RNNs and neural ODEs with a large margin (Table 4. Note that the CTRNN architecture is equivalent to the ODE-RNN described in (Rubanova, Chen, and Duvenaud 2019), with the difference of having a state damping factor _τ_ . 

In the _2nd Setting_ , we carefully set up the experiment to match the modifications made by (Rubanova, Chen, and Duvenaud 2019) (See supplements), to obtain a fair compari- 

|**Algorithm**|**Accuracy**|
|---|---|
|RNN∆_t ∗_|0.797_±_0.003|
|RNN-Decay_∗_|0.800_±_0.010|
|RNN GRU-D_∗_|0.806_±_0.007|
|RNN-VAE_∗_|0.343_±_0.040|
|Latent ODE (D enc.)_∗_|0.835_±_0.010|
|ODE-RNN _∗_|0.829_±_0.016|
|Latent ODE(C enc.)_∗_|0.846_±_0.013|
|LTC (ours)|**0.882**_±_**0.005**|



Table 5: Person activity, 2nd setting, n=5 Note: Accuracy for algorithms indicated by _∗_ , are taken directly from (Rubanova, Chen, and Duvenaud 2019) with: RNN ∆ _t_ = classic RNN + input delays, D-enc. = RNN encoder C-enc = ODE encoder. RNN-Decay = RNN with exponential decay on hidden states (Mozer, Kazakov, and Lindsey 2017). GRU-D = gated recurrent unit + exponential decay + input imputation (Che et al. 2018). 

son between LTCs and a more diverse set of RNN variants discussed in (Rubanova, Chen, and Duvenaud 2019). LTCs show superior performance with a high margin compared to other models. The results are summarized in Table 5). 

## **Half-Cheetah Kinematic Modeling** 

We intended to evaluate how well continuous-time models can capture physical dynamics. To perform this, we collected 25 rollouts of a pre-trained controller for the HalfCheetah-v2 gym environment (Brockman et al. 2016), generated by the MuJoCo physics engine (Todorov, Erez, and Tassa 2012). The task is then to fit the observation space time-series in an autoregressive fashion (Fig. 4). To increase the difficulty, we overwrite 5% of the actions by random actions. The test results are presented in Table 6, and root for the superiority of the performance of LTCs compared to 

7663 

**==> picture [233 x 69] intentionally omitted <==**

**----- Start of picture text -----**<br>
6<br>3<br>2 5<br>1 4<br>𝜙<br>Time − +<br>17 input observations     |     6 control outputs      |    𝜙 = joint angle<br>**----- End of picture text -----**<br>


Figure 4: Half-cheetah physics simulation 

other models. 

## **Related Works** 

**Time-Continuous Models.** TC networks have become unprecedentedly popular. This is due to the manifestation of several benefits such as adaptive computations, better continuous time-series modeling, memory, and parameter efficiency (Chen et al. 2018). A large number of alternative approaches have tried to improve and stabilize the adjoint method (Gholami, Keutzer, and Biros 2019), use neural ODEs in specific contexts (Rubanova, Chen, and Duvenaud 2019; Lechner et al. 2019) and to characterize them better (Dupont, Doucet, and Teh 2019; Durkan et al. 2019; Jia and Benson 2019; Hanshu et al. 2020; Holl, Koltun, and Thuerey 2020; Quaglino et al. 2020). In this work, we investigated the expressive power of neural ODEs and proposed a new ODE model to improve their expressivity and performance. 

**Measures of Expressivity.** Many works have tried to address why deeper networks and particular architectures perform well, and where is the boundary between the approximation capability of shallow and deep networks? In this context, (Montufar et al. 2014) and (Pascanu, Montufar, and Bengio 2013) proposed counting the linear regions of NNs as a measure of expressivity, (Eldan and Shamir 2016) showed that there exists a class of radial functions that smaller networks fail to produce, and (Poole et al. 2016) studied the exponential expressivity of NNs by transient chaos. 

These methods are compelling; however, they are bound to particular weight configurations of a given network in order to lower-bound expressivity (Serra, Tjandraatmadja, and Ramalingam 2017; Gabri´e et al. 2018; Hanin and Rolnick 2018, 2019; Lee, Alvarez-Melis, and Jaakkola 2019). (Raghu et al. 2017) introduced an interrelated concept which quantifies expressivity by trajectory length. We extended their analysis to CT networks and provided lower-bound for the growth of the trajectory length, proclaiming the superior approximation capabilities of LTCs. 

## **Conclusions, Scope and Limitations** 

We introduced liquid time-constant networks. We showed that they could be implemented by arbitrary variable and fixed step ODE solvers, and be trained by backpropagation through time. We demonstrated their bounded and stable dynamics, superior expressivity, and superseding performance in supervised learning time-series prediction tasks, compared to standard and modern deep learning models. 

|**Algorithm**|**MSE**|
|---|---|
|LSTM|2.500_±_0.140|
|CT-RNN|2.838_±_0.112|
|Neural ODE|3.805_±_0.313|
|CT-GRU|3.014_±_0.134|
|LTC (ours)|**2.308**_±_**0.015**|



Table 6: Sequence modeling. Half-Cheetah dynamics n=5 

## **Long-term Dependencies** 

Similar to many variants of time-continuous models, LTCs express the vanishing gradient phenomenon (Pascanu, Mikolov, and Bengio 2013; Lechner and Hasani 2020), when trained by gradient descent. Although the model shows promise on a variety of time-series prediction tasks, they would not be the obvious choice for learning long-term dependencies in their current format. 

## **Choice of ODE Solver** 

Performance of time-continuous models is heavily tided to their numerical implementation approach (Hasani 2020). While LTCs perform well with advanced variable-step solvers and the Fused fixed-step solver introduced here, their performance is majorly influenced when off-the-shelf explicit Euler methods are used. 

## **Time and Memory** 

Neural ODEs are remarkably fast compared to more sophisticated models such as LTCs. Nonetheless, they lack expressivity. Our proposed model, in their current format, significantly enhances the expressive power of TC models at the expense of elevated time and memory complexity which must be investigated in the future. 

## **Causality** 

Models described by ODE semantics inherently possess causal structures (Sch¨olkopf 2019), especially models that are equipped with recurrent mechanisms to map past experiences to next-step predictions. Studying causality of performant recurrent models such as LTCs would be an exciting future research direction as their semantics resemble _DCMs_ (Friston, Harrison, and Penny 2003) with a _bilinear dynamical system_ approximation (Penny, Ghahramani, and Friston 2005). Accordingly, a natural application domain would be the control of robots in continuous-time observation and action spaces where causal structures such as LTCs can help improve reasoning (Lechner et al. 2020a). 

## **Acknowledgments** 

R.H. and D.R. are partially supported by Boeing. R.H. and R.G. were partially supported by the Horizon-2020 ECSEL Project grant No. 783163 (iDev40). M.L. was supported in part by the Austrian Science Fund (FWF) under grant Z211N23 (Wittgenstein Award). A.A. is supported by the National Science Foundation (NSF) Graduate Research Fellowship Program. This research work is partially drawn from the PhD dissertation of R.H. 

7664 

## **References** 

Bogacki, P.; and Shampine, L. F. 1989. A 3 (2) pair of Runge-Kutta formulas. _Applied Mathematics Letters_ 2(4): 321–325. 

Brockman, G.; Cheung, V.; Pettersson, L.; Schneider, J.; Schulman, J.; Tang, J.; and Zaremba, W. 2016. Openai gym. _arXiv preprint arXiv:1606.01540_ . 

Che, Z.; Purushotham, S.; Cho, K.; Sontag, D.; and Liu, Y. 2018. Recurrent neural networks for multivariate time series with missing values. _Scientific reports_ 8(1): 1–12. 

Chen, T. Q.; Rubanova, Y.; Bettencourt, J.; and Duvenaud, D. K. 2018. Neural ordinary differential equations. In _Advances in Neural Information Processing Systems_ , 6571– 6583. 

Cybenko, G. 1989. Approximation by superpositions of a sigmoidal function. _Mathematics of control, signals and systems_ 2(4): 303–314. 

Dormand, J. R.; and Prince, P. J. 1980. A family of embedded Runge-Kutta formulae. _Journal of computational and applied mathematics_ 6(1): 19–26. 

Dupont, E.; Doucet, A.; and Teh, Y. W. 2019. Augmented neural odes. In _Advances in Neural Information Processing Systems_ , 3134–3144. 

Durkan, C.; Bekasov, A.; Murray, I.; and Papamakarios, G. 2019. Neural spline flows. In _Advances in Neural Information Processing Systems_ , 7509–7520. 

Eldan, R.; and Shamir, O. 2016. The power of depth for feedforward neural networks. In _Conference on learning theory_ , 907–940. 

Friston, K. J.; Harrison, L.; and Penny, W. 2003. Dynamic causal modelling. _Neuroimage_ 19(4): 1273–1302. 

Funahashi, K.-I. 1989. On the approximate realization of continuous mappings by neural networks. _Neural networks_ 2(3): 183–192. 

Funahashi, K.-i.; and Nakamura, Y. 1993. Approximation of dynamical systems by continuous time recurrent neural networks. _Neural networks_ 6(6): 801–806. 

Gabri´e, M.; Manoel, A.; Luneau, C.; Macris, N.; Krzakala, F.; Zdeborov´a, L.; et al. 2018. Entropy and mutual information in models of deep neural networks. In _Advances in Neural Information Processing Systems_ , 1821–1831. 

Gholami, A.; Keutzer, K.; and Biros, G. 2019. Anode: Unconditionally accurate memory-efficient gradients for neural odes. _arXiv preprint arXiv:1902.10298_ . 

Gleeson, P.; Lung, D.; Grosu, R.; Hasani, R.; and Larson, S. D. 2018. c302: a multiscale framework for modelling the nervous system of Caenorhabditis elegans. _Phil. Trans. R. Soc. B_ 373(1758): 20170379. 

Hanin, B.; and Rolnick, D. 2018. How to start training: The effect of initialization and architecture. In _Advances in Neural Information Processing Systems_ , 571–581. 

Hanin, B.; and Rolnick, D. 2019. Complexity of linear regions in deep networks. _arXiv preprint arXiv:1901.09021_ . 

Hanshu, Y.; Jiawei, D.; Vincent, T.; and Jiashi, F. 2020. On Robustness of Neural Ordinary Differential Equations. In _International Conference on Learning Representations_ . 

Hasani, R. 2020. _Interpretable Recurrent Neural Networks in Continuous-time Control Environments_ . PhD dissertation, Technische Universit¨at Wien. 

Hasani, R.; Amini, A.; Lechner, M.; Naser, F.; Grosu, R.; and Rus, D. 2019. Response characterization for auditing cell dynamics in long short-term memory networks. In _2019 International Joint Conference on Neural Networks (IJCNN)_ , 1–8. IEEE. 

Hasani, R.; Lechner, M.; Amini, A.; Rus, D.; and Grosu, R. 2020. The natural lottery ticket winner: Reinforcement learning with ordinary neural circuits. In _Proceedings of the 2020 International Conference on Machine Learning. JMLR. org_ . 

Hochreiter, S.; and Schmidhuber, J. 1997. Long short-term memory. _Neural computation_ 9(8): 1735–1780. 

Holl, P.; Koltun, V.; and Thuerey, N. 2020. Learning to Control PDEs with Differentiable Physics. _arXiv preprint arXiv:2001.07457_ . 

Hornik, K.; Stinchcombe, M.; and White, H. 1989. Multilayer feedforward networks are universal approximators. _Neural networks_ 2(5): 359–366. 

Hosea, M.; and Shampine, L. 1996. Analysis and implementation of TR-BDF2. _Applied Numerical Mathematics_ 20(1-2): 21–37. 

Jia, J.; and Benson, A. R. 2019. Neural jump stochastic differential equations. In _Advances in Neural Information Processing Systems_ , 9843–9854. 

Kingma, D. P.; and Ba, J. 2014. Adam: A method for stochastic optimization. _arXiv preprint arXiv:1412.6980_ . 

Koch, C.; and Segev, K. 1998. _Methods in Neuronal Modeling - From Ions to Networks_ . MIT press, second edition. 

Lapicque, L. 1907. Recherches quantitatives sur l’excitation electrique des nerfs traitee comme une polarization. _Journal de Physiologie et de Pathologie Generalej_ 9: 620–635. 

Lechner, M.; and Hasani, R. 2020. Learning Long-Term Dependencies in Irregularly-Sampled Time Series. _arXiv preprint arXiv:2006.04418_ . 

Lechner, M.; Hasani, R.; Amini, A.; Henzinger, T. A.; Rus, D.; and Grosu, R. 2020a. Neural circuit policies enabling auditable autonomy. _Nature Machine Intelligence_ 2(10): 642– 652. 

Lechner, M.; Hasani, R.; Rus, D.; and Grosu, R. 2020b. Gershgorin Loss Stabilizes the Recurrent Neural Network Compartment of an End-to-end Robot Learning Scheme. In _2020 International Conference on Robotics and Automation (ICRA)_ . IEEE. 

Lechner, M.; Hasani, R.; Zimmer, M.; Henzinger, T. A.; and Grosu, R. 2019. Designing worm-inspired neural networks for interpretable robotic control. In _2019 International Conference on Robotics and Automation (ICRA)_ , 87–94. IEEE. 

7665 

Lee, G.-H.; Alvarez-Melis, D.; and Jaakkola, T. S. 2019. Towards robust, locally linear deep networks. _arXiv preprint arXiv:1907.03207_ . 

Montufar, G. F.; Pascanu, R.; Cho, K.; and Bengio, Y. 2014. On the number of linear regions of deep neural networks. In _Advances in neural information processing systems_ , 2924– 2932. 

Mozer, M. C.; Kazakov, D.; and Lindsey, R. V. 2017. Discrete Event, Continuous Time RNNs. _arXiv preprint arXiv:1710.04110_ . 

Pascanu, R.; Mikolov, T.; and Bengio, Y. 2013. On the difficulty of training recurrent neural networks. In _International conference on machine learning_ , 1310–1318. 

Pascanu, R.; Montufar, G.; and Bengio, Y. 2013. On the number of response regions of deep feed forward networks with piece-wise linear activations. _arXiv preprint arXiv:1312.6098_ . 

Penny, W.; Ghahramani, Z.; and Friston, K. 2005. Bilinear dynamical systems. _Philosophical Transactions of the Royal Society B: Biological Sciences_ 360(1457): 983–993. 

Serra, T.; Tjandraatmadja, C.; and Ramalingam, S. 2017. Bounding and counting linear regions of deep neural networks. _arXiv preprint arXiv:1711.02114_ . 

Shampine, L. F. 1975. Computer solution of ordinary differential equations. _The Initial Value Problem_ . 

Todorov, E.; Erez, T.; and Tassa, Y. 2012. Mujoco: A physics engine for model-based control. In _2012 IEEE/RSJ International Conference on Intelligent Robots and Systems_ , 5026– 5033. IEEE. 

Wicks, S. R.; Roehrig, C. J.; and Rankin, C. H. 1996. A dynamic network simulation of the nematode tap withdrawal circuit: predictions concerning synaptic function using behavioral criteria. _Journal of Neuroscience_ 16(12): 4017– 4031. 

Zhuang, J.; Dvornek, N.; Li, X.; Tatikonda, S.; Papademetris, X.; and Duncan, J. 2020. Adaptive Checkpoint Adjoint Method for Gradient Estimation in Neural ODE. In _Proceedings of the 37th International Conference on Machine Learning_ . PMLR 119. 

Pontryagin, L. S. 2018. _Mathematical theory of optimal processes_ . Routledge. 

Poole, B.; Lahiri, S.; Raghu, M.; Sohl-Dickstein, J.; and Ganguli, S. 2016. Exponential expressivity in deep neural networks through transient chaos. In _Advances in neural information processing systems_ , 3360–3368. 

Press, W. H.; Teukolsky, S. A.; Vetterling, W. T.; and Flannery, B. P. 2007. _Numerical Recipes 3rd Edition: The Art of Scientific Computing_ . New York, NY, USA: Cambridge University Press, 3 edition. 

Quaglino, A.; Gallieri, M.; Masci, J.; and Koutn´ık, J. 2020. SNODE: Spectral Discretization of Neural ODEs for System Identification. In _International Conference on Learning Representations_ . 

Raghu, M.; Poole, B.; Kleinberg, J.; Ganguli, S.; and Dickstein, J. S. 2017. On the expressive power of deep neural networks. In _Proceedings of the 34th International Conference on Machine Learning-Volume 70_ , 2847–2854. JMLR. org. 

Rubanova, Y.; Chen, R. T.; and Duvenaud, D. 2019. Latent odes for irregularly-sampled time series. _arXiv preprint arXiv:1907.03907_ . 

Rumelhart, D. E.; Hinton, G. E.; and Williams, R. J. 1986. Learning representations by back-propagating errors. _nature_ 323(6088): 533–536. 

Sarma, G. P.; Lee, C. W.; Portegys, T.; Ghayoomie, V.; Jacobs, T.; Alicea, B.; Cantarelli, M.; Currie, M.; Gerkin, R. C.; Gingell, S.; et al. 2018. OpenWorm: overview and recent advances in integrative biological simulation of Caenorhabditis elegans. _Phil. Trans. R. Soc. B_ 373(1758): 20170382. 

Sch¨olkopf, B. 2019. Causality for Machine Learning. _arXiv preprint arXiv:1911.10500_ . 

7666 

