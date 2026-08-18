# ACTIVATION RELAXATION: A LOCAL DYNAMICAL APPROXIMATION TO BACKPROPAGATION IN THE BRAIN 

## **Beren Millidge** 

School of Informatics University of Edinburgh `beren@millidge.name` 

## **Alexander Tschantz** 

Sackler Center for Consciousness Science School of Engineering and Informatics University of Sussex `tschantz.alec@gmail.com` 

## **Anil K Seth** 

Sackler Center for Consciousness Science Evolutionary and Adaptive Systems Research Group School of Engineering and Informatics University of Sussex 

## **Christopher L Buckley** 

Evolutionary and Adaptive Systems Research Group School of Engineering and Informatics University of Sussex 

```
C.L.Buckley@sussex.ac.uk
```

```
A.K.Seth@sussex.ac.uk
```

## October 13, 2020 

## **ABSTRACT** 

The backpropagation of error algorithm (backprop) has been instrumental in the recent success of deep learning. However, a key question remains as to whether backprop can be formulated in a manner suitable for implementation in neural circuitry. The primary challenge is to ensure that any candidate formulation uses only local information, rather than relying on global signals as in standard backprop. Recently several algorithms for approximating backprop using only local signals have been proposed. However, these algorithms typically impose other requirements which challenge biological plausibility: for example, requiring complex and precise connectivity schemes, or multiple sequential backwards phases with information being stored across phases. Here, we propose a novel algorithm, Activation Relaxation (AR), which is motivated by constructing the backpropagation gradient as the equilibrium point of a dynamical system. Our algorithm converges rapidly and robustly to the correct backpropagation gradients, requires only a single type of computational unit, utilises only a single parallel backwards relaxation phase, and can operate on arbitrary computation graphs. We illustrate these properties by training deep neural networks on visual classification tasks, and describe simplifications to the algorithm which remove further obstacles to neurobiological implementation (for example, the weight-transport problem, and the use of nonlinear derivatives), while preserving performance. 

In the last decade, deep artificial neural networks trained through the backpropagation of error algorithm (backprop) (Griewank et al., 1989; Linnainmaa, 1970; Werbos, 1982) have achieved substantial success on a wide range of difficult tasks such as computer vision and object recognition (He, Zhang, Ren, & Sun, 2016; Krizhevsky, Sutskever, & Hinton, 2012), language modelling (Brown et al., 2020; Radford et al., 2019; Vaswani et al., 2017), unsupervised representation 

A PREPRINT - OCTOBER 13, 2020 

learning (Oord, Li, & Vinyals, 2018; Radford, Metz, & Chintala, 2015), image and audio generation (Dhariwal et al., 2020; Goodfellow et al., 2014; Jing et al., 2019; Oord et al., 2016; Salimans, Karpathy, Chen, & Kingma, 2017) and reinforcement learning (Mnih et al., 2015; Schrittwieser et al., 2019; Schulman, Wolski, Dhariwal, Radford, & Klimov, 2017; Silver et al., 2017). The impressive performance of backprop is due to the fact that it optimally solves the credit assignment problem (Lillicrap, Santoro, Marris, Akerman, & Hinton, 2020), which is the task of determining the individual contribution of each parameter (potentially one of billions in a deep neural network) to the global outcome. Given the correct credit assignments, network parameters can be straightforwardly, and independently, updated in the direction which maximally reduces the global loss. The brain also faces a formidable credit assignment problem – it must adjust trillions of synaptic weights, which may be physically and temporally distant from their global output, in order to improve performance on downstream tasks[1] . Given that backprop provides an optimal solution to this problem (Baldi & Sadowski, 2016), a large body of work has investigated whether synaptic plasticity in the brain could be interpreted as implementing or approximating backprop (Lillicrap et al., 2020; Whittington & Bogacz, 2019). Recently, this idea has been buttressed by findings that the representations learnt by backprop align closely with representations extracted from cortical neuroimaging data (Cadieu et al., 2014; Kriegeskorte, 2015). 

Due to the nonlocality of its learning rules, a direct term-for-term implementation of backprop is likely biologically implausible (Crick, 1989). In recent years, there has been a substantial amount of work developing more biologically plausible approximations that rely solely on local information. (Bengio & Fischer, 2015; Bengio, Mesnard, Fischer, Zhang, & Wu, 2017; Guerguiev, Lillicrap, & Richards, 2017; Lee, Zhang, Fischer, & Bengio, 2015; Lillicrap, Cownden, Tweed, & Akerman, 2014; Millidge, Tschantz, & Buckley, 2020; Nøkland, 2016; A. Ororbia, Mali, Giles, & Kifer, 2020; A. G. Ororbia & Mali, 2019; Ororbia II, Haffner, Reitter, & Giles, 2017; Sacramento, Costa, Bengio, & Senn, 2018; Scellier, Goyal, Binas, Mesnard, & Bengio, 2018a, 2018b; Whittington & Bogacz, 2017). The local learning constraint requires that the plasticity at each synapse depend only on information which is (in-principle) locally available at that synapse, such as pre- and post- synaptic activity in addition to local point derivatives and potentially the weight of the synaptic connection itself. The recently proposed NGRAD hypothesis (Lillicrap et al., 2020) offers a unifying view on many of these algorithms by arguing that they all approximate backprop in a similar manner. Specifically, it suggests that all of these algorithms approximate backprop by implicitly representing the gradients in terms of neural activity differences, either spatially between functionally distinct populations of neurons or neuron compartments (Millidge, Tschantz, & Buckley, 2020; Whittington & Bogacz, 2017), or temporally between different phases of network operation (Scellier & Bengio, 2017; Scellier et al., 2018b). 

Another way to understand local approximations to backprop comes from the notion of the learning channel (Baldi & Sadowski, 2016). In short, as the optimal parameters must depend on the global outcomes or targets, any successful learning rule must propagate information backwards from the targets to each individual parameter in the network that contributed to the outcome. We argue that there are two primary ways to achieve this[2] . First, a sequential backwards pass could be used, where higher layers propagate information about the targets backwards in a layer-wise fashion, such that the gradients of each layer are simply a function of the layer above. This is the approach employed by backprop, which propagates error derivatives explicitly. Other algorithms such as target-propagation (Lee et al., 2015) also perform a backwards pass using only local information, but do not asymptotically approximate the backprop updates. Secondly, instead of a sequential backwards pass, information could be propagated through a dynamical relaxation underwritten by recurrent dynamics, such that information about the targets slowly ‘leaks’ backwards through the network over the course of multiple dynamical iterations. Examples of such dynamical algorithms include predictive coding (Friston, 2003, 2005; Millidge, 2019; Whittington & Bogacz, 2017) and contrastive Hebbian methods such as equilibrium-prop 

> 1It is unlikely that the brain optimizes a single cost function, as assumed here. However, even if functionally segregated areas can be thought of as optimising some combination of cost functions, the core problem of credit assignment remains. 

> 2A third method is to propagate information about the targets through a global neuromodulatory signal which affects all neurons equally. However because this does not provide precise vector feedback, the implicit gradients computed have extremely high variance, typically leading to slow and unstable learning (Lillicrap et al., 2020). 

2 

A PREPRINT - OCTOBER 13, 2020 

(Scellier & Bengio, 2017; Xie & Seung, 2003),which both asymptotically approximate the error gradients of backprop using only local learning rules. 

To our knowledge, all of the algorithms in the literature, including those mentioned above, have utilised implicit or explicit activity differences to represent the necessary derivatives, in line with the NGRAD hypothesis. Here, we derive an algorithm which converges to the exact backprop gradients without utilising any layer-wise notion of activity differences. Our algorithm, which we call Activation Relaxation (AR), is derived by postulating a dynamical relaxation phase in which the neural activities trace out a dynamical system which is designed to converge to the backprop gradients. The resulting dynamics are extremely simple, and require only local information, meaning that they could, in principle be implemented in neural circuitry. Unlike algorithms such as predictive coding, AR only utilises a single type of neuron (instead of two separate populations – one encoding values and one encoding errors), and unlike contrastive Hebbian methods it does not require multiple distinct backwards phases (only a feedforward sweep and a relaxation phase). This simplification is beneficial from the standpoint of neural realism, as in the case of predictive coding, there is little evidence for the presence of specialised prediction-error neurons throughout cortex (Walsh, McGovern, Clark, & O’Connell, 2020)[3] . Unlike contrastive Hebbian methods, AR does not require the coordination and storage of information across multiple backwards phases, which would pose a substantial challenge for decentralised neural circuitry. 

We empirically demonstrate that the AR algorithm accurately approximates the backprop gradients and can be used to successfully train deep neural networks on the MNIST and FashionMNIST tasks, where we demonstrate performance directly equivalent to backprop. Finally, we show that several of the remaining biologically implausible aspects of the algorithm, such as ‘weight-transport’ (Crick, 1989), and the evaluation of nonlinear derivatives, can be removed, resulting in an updated form of AR that requires extremely simple connectivity patterns and plasticity rules. Importantly, we show that this simplified algorithm can still train deep neural networks to high levels of performance, despite no longer approximating exact backprop gradients. 

## **1 Methods** 

We consider the simple case of a fully-connected deep multi-layer perceptron (MLP) composed of _L_ layers of ratecoded neurons trained in a supervised setting[4] . The firing rates of these neurons are represented as a single scalar value _x[l] i_[,][referred][to][as][the][neurons][activation,][and][a][vector][of][all][activations][at][given][layer][is][denoted][as] _[x][l]_[.][The] activation’s of the hierarchically superordinate layer are a function of the hierarchically subordinate layer’s activations _x[l]_[+1] = _f_ ( _W[l] x[l]_ ), where _W[l] ∈_ Θ is the set of synaptic weights, and the product of activation and weights is transformed through a nonlinear activation function _f_ . The final output _x[L]_ of the network is compared with the desired targets _T_ , according to some loss function _L_ ( _x[L] , T_ ). In this work, we take this loss function to be the mean-squared-error (MSE) _L_ ( _x[L] , T_ ) =[1] 2 � _i_[(] _[x] i[L][−][T][i]_[)][2][, although the algorithm applies to any other loss function without loss of generality.][We] denote the gradient of the loss with respect to the output layer as _dxdL[L]_[.][In the case of the MSE loss, the gradient of] the output layer is just the prediction error _ϵ[L]_ = ( _x[L] − T_ ). Backprop proceeds by computing the gradient of the loss function with respect to the weights _W[l]_ using the chain rule, 

**==> picture [294 x 48] intentionally omitted <==**

3There is, of course, substantial evidence for dopaminergic reward-prediction error neurons in midbrain areas (Bayer & Glimcher, 2005; Glimcher, 2011; Schultz, 1998; Schultz & Dickinson, 2000) 

> 4Extensions to other architectures are relatively straightforward and will be investigated in future work. In appendix A we show that the approach can be extended to arbitrary directed acyclic graphs (DAGs), which encompasses all standard machine learning architectures such as CNNs, LSTMs, ResNets, transformers, etc. 

3 

A PREPRINT - OCTOBER 13, 2020 

where _f[′]_ denotes the derivative of the activation function. The difficulty lies in computing the _∂x∂L[l]_[+1][term using only] local information. This is achieved by repeatedly applying the chain rule _∂x[∂L][l]_[=] _∂x∂L[l]_[+1] _[∂x] ∂x[l]_[+1] _[l]_[, allowing the derivatives] to be computed recursively from the output loss. However, this procedure is not local since the update at each layer depends on the gradients of all superordinate layers in the hierarchy. Here, we propose a method for computing the activation derivatives, _∂x[∂L][l]_[, using a dynamical systems approach.][Specifically, we define a dynamical system where the] activations of each node at equilibrium correspond to the backpropagated gradients. Note that this is in contrast with more typical approaches where a dynamical system is designed to converges to the minimum of some global loss. The simplest system to achieve this is a leaky-integrator driven by top-down feedback, 

**==> picture [303 x 97] intentionally omitted <==**

which, at equilibrium, converges to 

Furthermore, by the chain rule we can write Equation 2 as, 

where _x_ ¯ _[l]_ is the value of _x[l]_ computed in the forward pass. We can express this in terms of the equilibrium activation of the superordinate layer, 

**==> picture [301 x 23] intentionally omitted <==**

To achieve these dynamics exactly in a multilayered network would require the sequential convergence of layers, as each layer must converge to equilibrium before the dynamics of the layer below can operate. However, to enable updates across multiple layers simultaneously, we approximate the equilibrium activation of the layer above with the layer’s current activation, yielding, 

**==> picture [305 x 67] intentionally omitted <==**

Despite this approximation, we argue that the system nevertheless converges to the same optimum as Equation 3. ¯ Specifically, because we evaluate _[∂x] ∂x[l]_[+1] _[l]_ at the feedforward pass value _x[l]_ , this term remains constant throughout the relaxation phase[5] . Keeping this term fixed effectively decouples the each layer from any bottom-up influence. If the top-down input is also constant, because it has already converged so that _x[l]_[+1] _≈ x[l]_[+1] _[∗]_ , then the dynamics become linear, and the system is globally stable due to possessing a Jacobian which is everywhere negative-definite. The top-layer is provided with the stipulatively correct gradient, so it must converge. Recursing backwards through each layer, we see that once the top-level has converged, so too must the penultimate layer, and so through to all layers. Although this argument is somewhat heuristic, in section 2 we provide empirical results showing that it rapidly and robustly converges to the exact numerical gradients in practice. 

Equation 4 forms the backbone of the activation-relaxation (AR) algorithm. The algorithm proceeds as follows. First, a standard forward pass computes the network output, which is compared with the target to calculate the top-layer error derivative _ϵL_ and thus update the activation of the penultimate layer.[6] . Then, the network enters into a relaxation phase where Equation 4 is iterated globally for all layers until convergence for each layer. Upon convergence, the activations of each layer are precisely equal the backpropagated derivatives, and are used to update the weights (via Equation 1). 

> 5The need to keep this term fixed throughout the relaxation phase does present a potential issue of biological plausibility. In theory it could be maintained by short-term synaptic traces, and for some activation functions such as rectified linear units it is trivial. Moreover, later we show that this term can be dropped from the equations without apparent ill-effect 

6This top-layer error is simply a prediction error for the MSE loss, but may be more complicated and less biologically-plausible for arbitrary loss functions 

4 

A PREPRINT - OCTOBER 13, 2020 

|**Algorithm 1:**Activation Relaxation|**Algorithm 1:**Activation Relaxation|
|---|---|
|**Data:** Dataset_D_ =_{_**X**_,_**T**_}_, parametersΘ =_{W_ 0 _. . . W L}_, inference learning rate_ηx_, weight learning rate_ηθ_.<br>`/* Iterate over dataset`<br>`*/`<br>**for**(_x_0_, t ∈D_)**do**||
||`/* Initial feedforward sweep`<br>`*/`<br>**for**(_xl, W l_)_for each layer_**do**<br>_xl_+1 =_f_(_W l, xl_)<br>`/* Begin backwards relaxation`<br>`*/`<br>**while**_not converged_**do**<br>`/* Compute final output error`<br>`*/`<br>_ϵL_ =_T −xL_<br>_dxL_ =_−xL_ +_ϵL ∂ϵL_<br>_∂xL_<br>**for**_xl, W l, xl_+1 _for each layer_**do**<br>`/* Activation update`<br>`*/`<br>_dxl_ =_−xl_ +_xl_+1 _∂xl_+1<br>_∂xl_<br>_xlt_+1 _←xlt_ +_ηxdxl_<br>`/* Update weights at equilibrium`<br>`*/`<br>**for**_W l ∈{W_ 0 _. . . W L}_**do**<br>_W lt_+1 _←W lt_ +_ηθxl ∂xl_<br>_∂W l_|



## **1.1 Related Work** 

There has been a substantial amount of work addressing the challenge of developing biologically plausible implementations of, or approximations to, backprop, with numerous schemes now available in the literature. Many attempts have been made to address or work around the weight transport problem – the requirement that backwards information be conveyed by the transpose of the forward weights – by either simply using random backwards weights (Lillicrap, Cownden, Tweed, & Akerman, 2016), directly transmitting gradients backwards to all layers from the output layer (Nøkland, 2016), or simply learning the backwards weights themselves (Akrout, Wilson, Humphreys, Lillicrap, & Tweed, 2019; Amit, 2019). In addition, recurrent algorithms have been developed that can converge to representations of the backprop gradients with only local rules in an iterative fashion. These algorithms include predictive coding (Friston, 2005; Millidge, 2019; Millidge, Tschantz, & Buckley, 2020; Whittington & Bogacz, 2017), where gradients are implicitly computed by minimizing layerwise prediction errors, equilibrium-prop (Scellier & Bengio, 2017; Scellier et al., 2018b), which uses a constrastive Hebbian learning approach where gradients are computed through the differences between a free and a fixed phase, and target-propagation (Lee et al., 2015), in which layers are optimized to minimize a layerwise target, and the local-representation-alignment (LRA) family of algorithms (A. G. Ororbia & Mali, 2019; A. G. Ororbia, Mali, Kifer, & Giles, 2018; Ororbia II et al., 2017) which is similar to target-prop except that the targets it computes induce the local layer-wise target minimization to encourage each layer to produce representations which will aid the layer above. The iterative form of LRA proposed in (A. G. Ororbia et al., 2018) is perhaps most similar to the AR algorithm, but significant differences still remain. AR is derived straightforwardly from a dynamical systems perspective on approximating the backprop gradient, while LRA is based on a variant of target-propagation. More importantly, AR directly optimizes the post-activations using the top-down information in the relaxation phase whereas iterative LRA optimizes the pre-activations before they are passed through the nonlinear activation function against the discrepancy between target and neural output. Due to this nonlinearity, the target-discrepancy does not exactly correspond to the backpropagated gradient in LRA, and hence the overall updates do not converge to backprop. 

5 

A PREPRINT - OCTOBER 13, 2020 

Figure 1: Mean square error between AR and the exact backpropagated gradients on a 3 layer MLP. Left: convergence each layer. Right: the effect of the learning rate on the rate of convergence. 

## **2 Results** 

We first demonstrate that our algorithm can train a deep neural network with equal performance to backprop. For training, we utilised the MNIST and Fashion-MNIST (Xiao, Rasul, & Vollgraf, 2017) datasets. The MNIST dataset consists of 60000 training and 10000 test 28x28 images of handwritten digits, while the Fashion-MNIST dataset consists of 60000 training and 10000 test 28x28 images of clothing items. The Fashion-MNIST dataset is designed to be identical in shape and size to MNIST while being harder to solve. We used a 4-layer fully-connected multi-layer perceptron (MLP) with rectified-linear activation functions and a linear output layer. The layers consisted of 300, 300, 100, and 10 neurons respectively. In the dynamical relaxation phase, we integrate Equation 5 with a simple first-order Euler integration scheme. _x[lt]_[+1] = _x[lt] − ηx[dx] dt[l]_[where] _[ η][x]_[was a learning rate which was set to][ 0] _[.]_[1][.][The relaxation] phase lasted for 100 iterations, which we found sufficient to closely approximate the numerical backprop gradients. After the relaxation phase was complete, the weights were updated using the standard stochastic gradient descent optimizer. The AR algorithm was applied to each minibatch of 64 digits sequentially. The network was trained with the mean-squared-error loss. 

Figure 1 shows that during the relaxation phase the activations converge precisely to the gradients obtained by backpropagating backwards through the computational graph of the MLP. In Figure 2 we show that the training and test performance of the network trained with activation-relaxation is nearly identical to that of the network trained with backpropagation, thus demonstrating that our algorithm can correctly perform credit assignment in deep neural networks with only local learning rules. 

## **3 Removing Constraints** 

## **3.1 Weight Transport** 

Although the AR algorithm only utilises local learning rules to approximate backpropagation, there are still some remaining biological implausibilities in the algorithm. Following Millidge, Tschantz, Seth, and Buckley (2020), we show how simple modifications to the algorithm can remove these implausible constraints on the algorithm while retaining high performance. The most pressing difficulty is the weight-transport problem (Crick, 1989), which concerns the _θ[T]_ term in Equation 5. In effect, the update rule for the activations during the relaxation phase consists of the activity of the layer above propagated backwards through the transpose of the forwards weights. However, in a neural circuit this would require either being able to transmit information both forwards and backwards symmetrically across 

6 

A PREPRINT - OCTOBER 13, 2020 

**==> picture [180 x 9] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) MNIST training accuracy for AR vs Backprop<br>**----- End of picture text -----**<br>


**==> picture [165 x 9] intentionally omitted <==**

**----- Start of picture text -----**<br>
(b) MNIST test accuracy for AR vs Backprop<br>**----- End of picture text -----**<br>


**==> picture [180 x 9] intentionally omitted <==**

**----- Start of picture text -----**<br>
(c) Fashion training accuracy for AR vs Backprop<br>**----- End of picture text -----**<br>


**==> picture [166 x 9] intentionally omitted <==**

**----- Start of picture text -----**<br>
(d) Fashion test accuracy for AR vs Backprop<br>**----- End of picture text -----**<br>


Figure 2: Training accuracy (left) and test accuracy (right) of the activation relaxation algorithm compared to backprop on MNIST and Fashion-MNIST, averaged over 5 seeds. Both backprop and activation relaxation obtain extremely high test accuracies and largely indistinguishable learning curves, showing that AR can perform credit assignment in deep hierarchical neural networks. Due to the rapid convergence of the algorithm, the ’iterations’ are actually individual minibatches, corresponding to 10 full ’epochs’, or sweeps through the dataset. 

synapses, which has generally been held to be implausible, or else that the brain must maintain an identical copy of ‘backwards weights’ which are kept in sync with the forwards weights during learning. However, in recent years, there has been much work showing that the precise equality of forward and backwards weights that underlies the weight transport problem is simply not required. Surprisingly, Lillicrap et al. (2016) showed that fixed _random_ feedback weights suffice for learning in simple MLP networks, as the forward weights learn to align with the fixed backwards weights to convey useful feedback signals. Later work (Akrout et al., 2019; Amit, 2019; A. G. Ororbia & Mali, 2019) has shown that it is also possible and more effective to learn the backwards weights from a random initialisation, where learning can take place with a local and Hebbian learning rule. Feedback alignment replaces the _θ[T]_ in Equation 5 with fixed random backwards weights _ψ_ . The updated Equation 5 reads, 

**==> picture [117 x 23] intentionally omitted <==**

The (initially random) backwards weights can also be trained with the local and Hebbian learning rule which is a simple Hebbian update between the activations of the layer and the layer above. 

**==> picture [286 x 23] intentionally omitted <==**

In Figure 3.a) we show that strong performance is obtained with the learnt backwards weights. We found that using random feedback weights without learning (i.e. feedback alignment), typically converged to a lower accuracy and had 

7 

A PREPRINT - OCTOBER 13, 2020 

a tendency to diverge, which may be due to a simple Gaussian weight initialization used here. Nevertheless, when the backwards weights are learnt, we find that the algorithm is stable and can obtain performance comparable with using the exact weight transposes. This approach of using learnable backwards weights to solve the weight transport problem has been similarly investigated in (Akrout et al., 2019; Amit, 2019), however these papers simply implement backprop with the learnt backwards weights. Here we show that learnable backwards weights can be combined with a fundamentally local learning rule, while maintaining training performance. 

## **3.2 Nonlinearity Derivatives** 

The second potential biological implausibility in the algorithm is the requirement to multiply the weight and activation updates with the derivative of the activation function. While in theory this only requires a derivative to be calculated locally for each neuron, whether biological neurons could compute this derivative is an open question. We experiment with simply removing the nonlinear derivatives in question from the update so that the updated Equation 5 now simply reads, 

**==> picture [279 x 23] intentionally omitted <==**

Although the gradients are no longer match backprop, we show in Figure 3.b) that learning performance against the standard model is relatively unaffected, showing that the influence of the nonlinear derivative is small. We hypothesise that by removing the nonlinear derivative, we are effectively projecting the backprop update onto the closest linear subspace,which is still sufficiently close in angle to the true gradient that it can support learning. Moreover, we can _combine_ these two changes of the algorithm such that there is both no nonlinear derivative and also learnable backwards weights. Perhaps surprisingly, when we do this we retain equivalent performance to the full AR algorithm (see Figure 

8 

A PREPRINT - OCTOBER 13, 2020 

3.c), and therefore a valid approximation to backprop in an extremely simple and biologically plausible form. The activation update equation for the fully simplified algorithm is: 

**==> picture [273 x 23] intentionally omitted <==**

which requires only locally available information and is mathematically very simple. In effect, each layer is only updated using its own activations and the activations of the layer above mapped backwards through the feedback connections, which are themselves learned through a local and Hebbian learning rule. This rule maintains high training performance and is, at least in theory, relatively straightforward to implement in neural or neuromorphic circuitry. 

## **4 Discussion** 

We have shown that by taking a relatively novel perspective on the problem of approximating backprop through recurrent dynamics – by explicitly designing a dynamical system to converge on the gradients we wish to approximate – one can straightforwardly derive from first principles an extremely simple algorithm which asymptotically approximates backprop using only local learning rules. Our algorithm requires only a feedforward pass and then a dynamical relaxation phase which we show empirically converges quickly and robustly to the exact numerical gradients computed by backprop. We demonstrate that our algorithm can be used to train deep MLPs to obtain identical performance to backprop. We then show that two key remaining biological implausibilities of the algorithm – the weight transport problem, and the need for nonlinear derivatives – can be removed without apparent harm to performance. The weight transport problem can seemingly be solved by postulating a second set of independent backwards weights which can be trained in parallel with the forward weights with a Hebbian update rule. While we have found that the nonlinear derivatives can be simply dropped from the learning rules, and does not appear to significantly harm learning performance. Future work should test whether performance is maintained on more challenging tasks. When these adjustments to the algorithm are combined, we obtain the simple and elegant update rule shown in Equation 7. 

The AR algorithm does away with much of the complexity of competing schemes. Unlike contrastive Hebbian approaches, it does not require the storage of information across distinct backwards dynamical phases such as the ’free phase’ and the ’clamped phase’. Unlike predictive coding approaches (Whittington & Bogacz, 2017), error-dendrite methods (Sacramento et al., 2018), or ‘ghost units’ (Mesnard, Vignoud, Sacramento, Senn, & Bengio, 2019), AR does not require multiple distinct neural populations with separate update rules and dynamics. Instead, the connectivity scheme in AR is identical to that of a standard MLP where only a single type of neuron is required. Since it can approximate backprop without any implicit or explicit representation of activity differences across time or space, the AR algorithm thus provides a counterexample to the NGRAD hypothesis, suggesting a more nuanced definition is required. Although the gradients themselves are not represented through an activity or temporal difference, the update rules (Equation 5 and 7) can be interpreted as a prediction error between the current activity and the activity of the layer above mapped through the backwards weights. This rule is strongly reminiscent of the target-prop updates, suggesting some points of commonality which would be interesting to investigate in future work. However, the NGRAD hypothesis as stated in (Lillicrap et al., 2020) requires that gradients be encoded directly in spatial or temporal differences. Our method shows that this is not necessary and that instead inter-layer errors can be used to drive dynamics which converge to the correct gradients. 

Although the AR algorithm (especially the simplified version) takes a strong step towards biological realism, it still possesses several weaknesses which may render a naive implementation in neural circuitry challenging. The primary difficulty is the necessity of two distinct phases – a feedforward phase which sets the activations directly by bottom-up connectivity, and a dynamical relaxation phase where the activations are then adjusted using local learning rules. In effect, AR uses the ‘activation’ units for two distinct purposes – to represent both the activations and their gradients – at different times. While this is not a problem in the current paradigm where i.i.d items are presented sequentially to the network, for a biological brain enmeshed in continuous-time sensory exchange, the requirement for a dynamical 

9 

A PREPRINT - OCTOBER 13, 2020 

relaxation adjusting the firing rates of all neurons, before the next sensory stimulus can be processed would be a serious challenge. By reusing the activations for two different tasks, the brain must either rigidly stick to two separate phases – an ‘inference’ phase and a ‘learning phase’, or else must be able to multiplex the different phases together to perform the correct updates. This difficult is compounded as the weight updates require the presence of both the gradient and the original activation simultaneously, thus necessitating the storage of the original activation during the relaxation phase. One potential solution to the multiplexing problem and the related problem of storing the original activations is through the use of multicompartment models of neurons with segregated dendrites. A number of algorithms have approximated backprop by using apical dendrites to keep separate representations of the activity and the error (Sacramento et al., 2018; Urbanczik & Senn, 2014). The apical dendrites of pyramidal neurons have many useful properties for this role – they receive a substantial amount of top-down feedback from other cortical and thalamic areas (Ohno et al., 2012), are electronically distant from the soma (Larkum, 2013), and they can operate as a ‘third factor’ in synaptic plasticity through NMDA spiking (Körding & König, 2001). Another potential solution to the multiplexing problem is that different phases could be coordinated by oscillatory rhythms of activity such as the alpha or gamma bands (Buzsaki, 2006). These oscillations could potentially multiplex the different phases together while handling continuously varying stimuli. 

## **4.1 Conclusion** 

We have derived a novel algorithm which converges rapidly and robustly to the exact error gradients computed by backprop using only local learning rules. This algorithm requires only a single backwards phase and one type of neuron, thus shedding much of the complexity implicit in related models in the literature. Moreover, we have shown that two key remaining biological implausibilities of the model – that of weight symmetry and nonlinear derivatives can be removed from the algorithm without apparent ill-effect, resulting in a final algorithm which is both extremely robust and competitive with backprop while also possessing a compelling simplicity and straightforward biological interpretation. 

## **Acknowledgements** 

BM is supported by an EPSRC funded PhD Studentship. AT is funded by a PhD studentship from the Dr. Mortimer and Theresa Sackler Foundation and the School of Engineering and Informatics at the University of Sussex. CLB is supported by BBRSC grant number BB/P022197/1 and by Joint Research with the National Institutes of Natural Sciences (NINS), Japan, program No. 01112005. AT and AKSare grateful to the Dr. Mortimer and Theresa Sackler Foundation, which supports the Sackler Centrefor Consciousness Science. AKS is additionally grateful to the Canadian Institute for AdvancedResearch (Azrieli Programme on Brain, Mind, and Consciousness). 

## **References** 

- Akrout, M., Wilson, C., Humphreys, P., Lillicrap, T., & Tweed, D. B. (2019). Deep learning without weight transport. In _Advances in neural information processing systems_ (pp. 974–982). 

- Amit, Y. (2019). Deep learning with asymmetric connections and hebbian updates. _Frontiers in computational neuroscience_ , _13_ , 18. 

- Baldi, P., & Sadowski, P. (2016). A theory of local learning, the learning channel, and the optimality of backpropagation. _Neural Networks_ , _83_ , 51–74. 

- Bayer, H. M., & Glimcher, P. W. (2005). Midbrain dopamine neurons encode a quantitative reward prediction error signal. _Neuron_ , _47_ (1), 129–141. 

- Bengio, Y., & Fischer, A. (2015). Early inference in energy-based models approximates back-propagation. _arXiv preprint arXiv:1510.02777_ . 

> Bengio, Y., Mesnard, T., Fischer, A., Zhang, S., & Wu, Y. (2017). Stdp-compatible approximation of backpropagation in an energy-based model. _Neural computation_ , _29_ (3), 555–577. 

10 

A PREPRINT - OCTOBER 13, 2020 

- Brown, T. B., Mann, B., Ryder, N., Subbiah, M., Kaplan, J., Dhariwal, P., ... others (2020). Language models are few-shot learners. _arXiv preprint arXiv:2005.14165_ . 

- Buzsaki, G. (2006). _Rhythms of the brain_ . Oxford University Press. 

- Cadieu, C. F., Hong, H., Yamins, D. L., Pinto, N., Ardila, D., Solomon, E. A., ... DiCarlo, J. J. (2014). Deep neural networks rival the representation of primate it cortex for core visual object recognition. _PLoS Comput Biol_ , _10_ (12), e1003963. 

- Crick, F. (1989). The recent excitement about neural networks. _Nature_ , _337_ (6203), 129–132. 

- Dhariwal, P., Jun, H., Payne, C., Kim, J. W., Radford, A., & Sutskever, I. (2020). Jukebox: A generative model for music. _arXiv preprint arXiv:2005.00341_ . 

- Friston, K. (2003). Learning and inference in the brain. _Neural Networks_ , _16_ (9), 1325–1352. 

- Friston, K. (2005). A theory of cortical responses. _Philosophical transactions of the Royal Society B: Biological sciences_ , _360_ (1456), 815–836. 

- Glimcher, P. W. (2011). Understanding dopamine and reinforcement learning: the dopamine reward prediction error hypothesis. _Proceedings of the National Academy of Sciences_ , _108_ (Supplement 3), 15647–15654. 

- Goodfellow, I., Pouget-Abadie, J., Mirza, M., Xu, B., Warde-Farley, D., Ozair, S., ... Bengio, Y. (2014). Generative adversarial nets. In _Advances in neural information processing systems_ (pp. 2672–2680). 

- Griewank, A., et al. (1989). On automatic differentiation. _Mathematical Programming: recent developments and applications_ , _6_ (6), 83–107. 

- Guerguiev, J., Lillicrap, T. P., & Richards, B. A. (2017). Towards deep learning with segregated dendrites. _Elife_ , _6_ , e22901. 

- He, K., Zhang, X., Ren, S., & Sun, J. (2016). Deep residual learning for image recognition. In _Proceedings of the ieee conference on computer vision and pattern recognition_ (pp. 770–778). 

- Hochreiter, S., & Schmidhuber, J. (1997). Long short-term memory. _Neural computation_ , _9_ (8), 1735–1780. 

- Jing, Y., Yang, Y., Feng, Z., Ye, J., Yu, Y., & Song, M. (2019). Neural style transfer: A review. _IEEE transactions on visualization and computer graphics_ . 

- Körding, K. P., & König, P. (2001). Supervised and unsupervised learning with two sites of synaptic integration. _Journal of computational neuroscience_ , _11_ (3), 207–215. 

- Kriegeskorte, N. (2015). Deep neural networks: a new framework for modeling biological vision and brain information processing. _Annual review of vision science_ , _1_ , 417–446. 

- Krizhevsky, A., Sutskever, I., & Hinton, G. E. (2012). Imagenet classification with deep convolutional neural networks. In _Advances in neural information processing systems_ (pp. 1097–1105). 

- Larkum, M. (2013). A cellular mechanism for cortical associations: an organizing principle for the cerebral cortex. _Trends in neurosciences_ , _36_ (3), 141–151. 

- Lee, D.-H., Zhang, S., Fischer, A., & Bengio, Y. (2015). Difference target propagation. In _Joint european conference on machine learning and knowledge discovery in databases_ (pp. 498–515). 

- Lillicrap, T. P., Cownden, D., Tweed, D. B., & Akerman, C. J. (2014). Random feedback weights support learning in deep neural networks. _arXiv preprint arXiv:1411.0247_ . 

- Lillicrap, T. P., Cownden, D., Tweed, D. B., & Akerman, C. J. (2016). Random synaptic feedback weights support error backpropagation for deep learning. _Nature communications_ , _7_ (1), 1–10. 

- Lillicrap, T. P., Santoro, A., Marris, L., Akerman, C. J., & Hinton, G. (2020). Backpropagation and the brain. _Nature Reviews Neuroscience_ , 1–12. 

- Linnainmaa, S. (1970). The representation of the cumulative rounding error of an algorithm as a taylor expansion of the local rounding errors. _Master’s Thesis (in Finnish), Univ. Helsinki_ , 6–7. 

- Margossian, C. C. (2019). A review of automatic differentiation and its efficient implementation. _Wiley Interdisciplinary Reviews: Data Mining and Knowledge Discovery_ , _9_ (4), e1305. 

- Mesnard, T., Vignoud, G., Sacramento, J., Senn, W., & Bengio, Y. (2019). Ghost units yield biologically plausible backprop in deep neural networks. _arXiv preprint arXiv:1911.08585_ . 

11 

A PREPRINT - OCTOBER 13, 2020 

- Millidge, B. (2019). Implementing predictive processing and active inference: Preliminary steps and results. 

- Millidge, B., Tschantz, A., & Buckley, C. L. (2020). Predictive coding approximates backprop along arbitrary computation graphs. _arXiv preprint arXiv:2006.04182_ . 

- Millidge, B., Tschantz, A., Seth, A., & Buckley, C. L. (2020). Relaxing the constraints on predictive coding models. _arXiv preprint arXiv:2010.01047_ . 

- Mnih, V., Kavukcuoglu, K., Silver, D., Rusu, A. A., Veness, J., Bellemare, M. G., ... others (2015). Human-level control through deep reinforcement learning. _Nature_ , _518_ (7540), 529–533. 

- Nøkland, A. (2016). Direct feedback alignment provides learning in deep neural networks. In _Advances in neural information processing systems_ (pp. 1037–1045). 

- Ohno, S., Kuramoto, E., Furuta, T., Hioki, H., Tanaka, Y. R., Fujiyama, F., ... Kaneko, T. (2012). A morphological analysis of thalamocortical axon fibers of rat posterior thalamic nuclei: a single neuron tracing study with viral vectors. _Cerebral cortex_ , _22_ (12), 2840–2857. 

- Oord, A. v. d., Dieleman, S., Zen, H., Simonyan, K., Vinyals, O., Graves, A., . . . Kavukcuoglu, K. (2016). Wavenet: A generative model for raw audio. _arXiv preprint arXiv:1609.03499_ . 

- Oord, A. v. d., Li, Y., & Vinyals, O. (2018). Representation learning with contrastive predictive coding. _arXiv preprint arXiv:1807.03748_ . 

- Ororbia, A., Mali, A., Giles, C. L., & Kifer, D. (2020). Continual learning of recurrent neural networks by locally aligning distributed representations. _IEEE Transactions on Neural Networks and Learning Systems_ . 

- Ororbia, A. G., & Mali, A. (2019). Biologically motivated algorithms for propagating local target representations. In _Proceedings of the aaai conference on artificial intelligence_ (Vol. 33, pp. 4651–4658). 

- Ororbia, A. G., Mali, A., Kifer, D., & Giles, C. L. (2018). Conducting credit assignment by aligning local representations. _arXiv preprint arXiv:1803.01834_ . 

- Ororbia II, A. G., Haffner, P., Reitter, D., & Giles, C. L. (2017). Learning to adapt by minimizing discrepancy. _arXiv preprint arXiv:1711.11542_ . 

- Radford, A., Metz, L., & Chintala, S. (2015). Unsupervised representation learning with deep convolutional generative adversarial networks. _arXiv preprint arXiv:1511.06434_ . 

- Radford, A., Wu, J., Child, R., Luan, D., Amodei, D., & Sutskever, I. (2019). Language models are unsupervised multitask learners. _OpenAI Blog_ , _1_ (8), 9. 

- Sacramento, J., Costa, R. P., Bengio, Y., & Senn, W. (2018). Dendritic cortical microcircuits approximate the backpropagation algorithm. In _Advances in neural information processing systems_ (pp. 8721–8732). 

- Salimans, T., Karpathy, A., Chen, X., & Kingma, D. P. (2017). Pixelcnn++: Improving the pixelcnn with discretized logistic mixture likelihood and other modifications. _arXiv preprint arXiv:1701.05517_ . 

- Scellier, B., & Bengio, Y. (2017). Equilibrium propagation: Bridging the gap between energy-based models and backpropagation. _Frontiers in computational neuroscience_ , _11_ , 24. 

- Scellier, B., Goyal, A., Binas, J., Mesnard, T., & Bengio, Y. (2018a). Extending the framework of equilibrium propagation to general dynamics. 

- Scellier, B., Goyal, A., Binas, J., Mesnard, T., & Bengio, Y. (2018b). Generalization of equilibrium propagation to vector field dynamics. _arXiv preprint arXiv:1808.04873_ . 

- Schrittwieser, J., Antonoglou, I., Hubert, T., Simonyan, K., Sifre, L., Schmitt, S., . . . others (2019). Mastering atari, go, chess and shogi by planning with a learned model. _arXiv preprint arXiv:1911.08265_ . 

- Schulman, J., Wolski, F., Dhariwal, P., Radford, A., & Klimov, O. (2017). Proximal policy optimization algorithms. _arXiv preprint arXiv:1707.06347_ . 

- Schultz, W. (1998). Predictive reward signal of dopamine neurons. _Journal of neurophysiology_ , _80_ (1), 1–27. 

- Schultz, W., & Dickinson, A. (2000). Neuronal coding of prediction errors. _Annual review of neuroscience_ , _23_ (1), 473–500. 

- Silver, D., Schrittwieser, J., Simonyan, K., Antonoglou, I., Huang, A., Guez, A., . . . others (2017). Mastering the game of go without human knowledge. _Nature_ , _550_ (7676), 354–359. 

12 

A PREPRINT - OCTOBER 13, 2020 

Urbanczik, R., & Senn, W. (2014). Learning by the dendritic prediction of somatic spiking. _Neuron_ , _81_ (3), 521–528. Van Merriënboer, B., Breuleux, O., Bergeron, A., & Lamblin, P. (2018). Automatic differentiation in ml: Where we are and where we should be going. In _Advances in neural information processing systems_ (pp. 8757–8767). 

Vaswani, A., Shazeer, N., Parmar, N., Uszkoreit, J., Jones, L., Gomez, A. N., . . . Polosukhin, I. (2017). Attention is all you need. In _Advances in neural information processing systems_ (pp. 5998–6008). 

Walsh, K. S., McGovern, D. P., Clark, A., & O’Connell, R. G. (2020). Evaluating the neurophysiological evidence for predictive processing as a model of perception. _Annals of the New York Academy of Sciences_ , _1464_ (1), 242. 

Werbos, P. J. (1982). Applications of advances in nonlinear sensitivity analysis. In _System modeling and optimization_ (pp. 762–770). Springer. 

Whittington, J. C., & Bogacz, R. (2017). An approximation of the error backpropagation algorithm in a predictive coding network with local hebbian synaptic plasticity. _Neural computation_ , _29_ (5), 1229–1262. 

Whittington, J. C., & Bogacz, R. (2019). Theories of error back-propagation in the brain. _Trends in cognitive sciences_ . 

Xiao, H., Rasul, K., & Vollgraf, R. (2017). Fashion-mnist: a novel image dataset for benchmarking machine learning algorithms. 

- Xie, X., & Seung, H. S. (2003). Equivalence of backpropagation and contrastive hebbian learning in a layered network. _Neural computation_ , _15_ (2), 441–454. 

## **Appendix A: Energy function, extension to arbitrary DAGs.** 

In this appendix, we elaborate on the mathematical background of the AR algorithm. We present a.) A candidate energy function that the dynamics appear to optimize, and discuss its limitations and b.) An extension of the AR algorithm to arbitrary computation graphs, which allow, in theory, for the AR algorithm to be used to perform automatic differentiation and optimisation along arbitrary programs, including modern machine learning methods. 

## **The Energy Function** 

We first define the implicit energy function _E_ that the dynamics can be thought of as optimizing. Given a hierarchical MLP structure with activations _x[l]_ , and activation function _f_ and parameters _θi_ at each layer. This energy function is: 

**==> picture [296 x 30] intentionally omitted <==**

Given this energy, function we can derive the dynamics as a gradient descent on _E_ 

**==> picture [324 x 24] intentionally omitted <==**

**==> picture [268 x 24] intentionally omitted <==**

where the second step uses the fact that in the forward pass _x[l]_[+1] = _f_ ( _W[l] , x[l]_ ). While this energy function can derive the required dynamics, it possesses several limitations. At the initial forward pass, the energy is 0 for all layers except potentially the output layer, and moreover it does not define a standard loss function (such as the mean-squared error) at the output. Thus the AR algorithm requires a special case to deal with the final output layer, as the ‘natural’ final layer loss is simply _T_[2] _− f_ ( _W[L] , x[L]_ )[2] which is not a standard loss. Secondly, the value of the loss is not bounded above or below. For instance, it cannot easily be interpreted as a (squared) prediction error, which has a minimum at 0. Minimizing the energy function thus effectively requires trying to push _f_ ( _W[l] , x[l]_ ) to be greater than _x[l]_ as much as possible, rather than trying to equilibrate the two. Finally, the replacement of _f_ ( _W[l] , x[l]_ ) with _x[l]_[+1] is a subtle issue due to the way the AR algorithm treats the activations in two separate ways. During the forward pass, this substitution is valid, however during the backward relaxation, the activations are changed away from their initial forward-pass values, and thus this substitution is not valid here. 

13 

A PREPRINT - OCTOBER 13, 2020 

## **Extension to DAGs** 

Here we consider the extension of the AR scheme described in the paper to more complex architectures. Specifically, we are interested in any function which can be expressed as a _computation graph_ of elementary differentiable functions. This class includes essentially all modern machine learning architectures. A computation graph represents a complex function (such as the forward pass of a complex NN architecture like a transformer (Vaswani et al., 2017), or an LSTM (Hochreiter & Schmidhuber, 1997) as a graph of simpler functions. Each function corresponds to a vertex of the graph while there is a directed edge between two vertices if the parent vertex is an argument to the function represented by the child vertex. Because we only study finite feedforward architectures (and since it is assumed finite we can ‘unroll’ any recurrent network into a long feedforward graph), we can represent any machine learning architecture as a directed acyclic graph (DAG). Automatic Differentiation (AD) techniques, which are at the heart of modern machine learning (Griewank et al., 1989; Margossian, 2019; Van Merriënboer, Breuleux, Bergeron, & Lamblin, 2018), can then be used to compute gradients with respect to the parameters of any almost arbitrarily complex architecture automatically. This allows machine-learning practitioners to derive models which encode complex inductive biases about the structure of the problem domain, without having to be manually derive the expressions for the derivatives required to train the models. Here, we show that the AR algorithm can also be used to compute these derivatives along arbitrary DAGs, using only local information in the dynamics,and requiring only the knowledge of the inter-layer derivatives. 

Core to AD is the multivariate chain-rule of calculus. Given a node _x[l]_ on a DAG, the derivative with respect to some final output of the graph can be computed recursively with the relation 

**==> picture [289 x 30] intentionally omitted <==**

Where _Chi_ ( _x[i]_ ) represents all the nodes which are children of _x[i]_ . In effect, this recursive rule states that the derivative with respect to the loss of a point is equal to the sum of the derivatives coming from all paths from that node to the output. We now derive the AR energy function and dynamical update rule on a DAG. Specifically, we have in the forward pass that _x[i]_ = _f_ ( _W[j] , x[j]_ ) _∈ Par_ ( _x[i]_ )) (where _Par_ ( _x_ ) denotes the parents of x) so that each activation is some function of its parent nodes. We can thus write out the energy function and dynamics, and compute the equilibrium to obtain: 

**==> picture [396 x 132] intentionally omitted <==**

Crucially, this recursion satisfies the same relationship as the multivariable chain-rule (Equation 11), and thus if the output nodes are equal to the gradient at the top-level such that _x[L]_ = _∂x∂L[L]_[, at equilibrium the correct gradients will] be computed at every node in the graph. Thus AR can be converted into a general-purpose AD algorithm which utilises only local information. Neurally, this only requires the dynamics in the relaxation phase to respond to the sum of top-down input, which is very plausible, and thus perhaps suggests that it is possible the brain could be utilizing substantially more complex architectures than feedforward MLPs. 

14 

