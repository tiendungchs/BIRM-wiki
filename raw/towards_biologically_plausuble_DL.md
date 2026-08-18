**Towards Biologically Plausible Deep Learning** 

**Yoshua Bengio**[1] **, Dong-Hyun Lee, Jorg Bornschein, Thomas Mesnard and Zhouhan Lin** 

Montreal Institute for Learning Algorithms, University of Montreal, Montreal, QC, H3C 3J7 1CIFAR Senior Fellow 

## **Abstract** 

Neuroscientists have long criticised deep learning algorithms as incompatible with current knowledge of neurobiology. We explore more biologically plausible versions of deep representation learning, focusing here mostly on unsupervised learning but developing a learning mechanism that could account for supervised, unsupervised and reinforcement learning. The starting point is that the basic learning rule believed to govern synaptic weight updates (Spike-TimingDependent Plasticity) arises out of a simple update rule that makes a lot of sense from a machine learning point of view and can be interpreted as gradient descent on some objective function so long as the neuronal dynamics push firing rates towards better values of the objective function (be it supervised, unsupervised, or rewarddriven). The second main idea is that this corresponds to a form of the variational EM algorithm, i.e., with approximate rather than exact posteriors, implemented by neural dynamics. Another contribution of this paper is that the gradients required for updating the hidden states in the above variational interpretation can be estimated using an approximation that only requires propagating activations forward and backward, with pairs of layers learning to form a denoising auto-encoder. Finally, we extend the theory about the probabilistic interpretation of auto-encoders to justify improved sampling schemes based on the generative interpretation of denoising auto-encoders, and we validate all these ideas on generative learning tasks. 

## **1. Introduction** 

Deep learning and artificial neural networks have taken their inspiration from brains, but mostly for the form of the computation performed (with much of the biology, such as the presence of spikes remaining to be accounted for). However, what is lacking currently is a credible _machine learning interpretation of the learning rules_ that seem to 

exist in biological neurons that would explain _efficient_ joint training of a deep neural network, i.e., accounting for _credit assignment through a long chain of neural connections_ . Solving the credit assignment problem therefore means identifying neurons and weights that are responsible for a desired outcome and changing parameters accordingly. Whereas back-propagation offers a machine learning answer, it is not biologically plausible, as discussed in the next paragraph. Finding a biologically plausible machine learning approach for credit assignment in deep networks is the main long-term question to which this paper contributes. 

Let us first consider the claim that state-of-the-art deep learning algorithms rely on mechanisms that seem biologically implausible, such as gradient back-propagation, i.e., the mechanism for computing the gradient of an objective function with respect to neural activations and parameters. The following difficulties can be raised regarding the biological plausibility of back-propagation: (1) the back-propagation computation (coming down from the output layer to lower hidden layers) is purely linear, whereas biological neurons interleave linear and non-linear operations, (2) if the feedback paths known to exist in the brain (with their own synapses and maybe their own neurons) were used to propagate credit assignment by backprop, they would need precise knowledge of the derivatives of the non-linearities at the operating point used in the corresponding feedforward computation on the feedforward path[1] , (3) similarly, these feedback paths would have to use exact symmetric weights (with the same connectivity, transposed) of the feedforward connections,[2] (4) real neurons communicate by (possibly stochastic) binary values (spikes), not by clean continuous values, (5) the computation would have to be precisely clocked to alternate between feedforward and back-propagation phases (since the latter needs the former’s results), and (6) it is not clear where the output targets would come from. The approach 

> 1and with neurons not all being exactly the same, it could be difficult to match the right estimated derivatives 

> 2this is known as the _weight transport_ problem (Lillicrap _et al._ , 2014) 

**Towards Biologically Plausible Deep Learning** 

proposed in this paper has the ambition to address all these issues, although some question marks as to a possible biological implementations remain, and of course many more detailed elements of the biology that need to be accounted for are not covered here. 

Note that back-propagation is used not just for classical supervised learning but also for many unsupervised learning algorithms, including all kinds of auto-encoders: sparse auto-encoders (Ranzato _et al._ , 2007; Goodfellow _et al._ , 2009), denoising auto-encoders (Vincent _et al._ , 2008), contractive auto-encoders (Rifai _et al._ , 2011), and more recently, variational auto-encoders (Kingma and Welling, 2014). Other unsupervised learning algorithms exist which do not rely on back-propagation, such as the various Boltzmann machine learning algorithms (Hinton and Sejnowski, 1986; Smolensky, 1986; Hinton _et al._ , 2006; Salakhutdinov and Hinton, 2009). Boltzmann machines are probably the most biologically plausible learning algorithms for deep architectures that we currently know, but they also face several question marks in this regard, such as the weight transport problem ((3) above) to achieve symmetric weights, and the positive-phase vs negative-phase synchronization question (similar to (5) above). 

Our starting point (Sec. 2) proposes an interpretation of the main learning rule observed in biological synapses: SpikeTiming-Dependent Plasticity (STDP). Inspired by earlier ideas (Xie and Seung, 2000; Hinton, 2007), we first show via both an intuitive argument and a simulation that STDP could be seen as stochastic gradient descent if only the neuron was driven by a feedback signal that either increases or decreases the neuron’s firing rate in proportion to the gradient of an objective function with respect to the neuron’s voltage potential. 

In Sec. 3 we present the first machine learning interpretation of STDP that gives rise to efficient credit assignment through multiple layers. We first argue that the above interpretation of STDP suggests that neural dynamics (which creates the above changes in neuronal activations thanks to feedback and lateral connections) correspond to _inference_ towards neural configurations that are more consistent with each other and with the observations (inputs, targets, or rewards). This view is analogous to the interpretation of inference in Boltzmann machines while avoiding the need to obtain representative samples from the stationary distribution of an MCMC. Going beyond Hinton’s proposal, it naturally suggests that the training procedure corresponds to a form of variational EM (Neal and Hinton, 1999) (see Sec.3), possibly based on MAP (maximum a posteriori) or MCMC (Markov Chain Monte-Carlo) approximations. In Sec. 4 we show how this mathematical framework suggests a training procedure for a deep directed generative network with many layers of latent variables. However, the 

above interpretation would still require to compute some gradients. Another contribution (Sec. 6) is to show that one can estimate these gradients via an approximation that only involves ordinary neural computation and no explicit derivatives, following previous (unpublished) work on target propagation (Bengio, 2014; Lee _et al._ , 2014). We introduce a novel justification for difference target propagation (Lee _et al._ , 2014), exploiting the fact that the proposed learning mechanism can be interpreted as training a denoising auto-encoder. As discussed in Sec. 5 these alternative interpretations of the model provide different ways to sample from it, and we found that better samples could be obtained. 

## **2. STDP as Stochastic Gradient Descent** 

Spike-Timing-Dependent Plasticity or STDP is believed to be the main form of synaptic change in neurons (Markram and Sakmann, 1995; Gerstner _et al._ , 1996) and it relates the expected change in synaptic weights to the timing difference between post-synaptic spikes and pre-synaptic spikes. Although it is the result of experimental observations in biological neurons, its interpretation as part of a learning procedure that could explain learning in deep networks remains unclear. Xie and Seung (2000) nicely showed how STDP can correspond to a differential anti-Hebbian plasticity, i.e., the synaptic change is proportional the product of pre-synaptic activity and the temporal derivative of the post-synaptic activity. The question is how this could make sense from a machine learning point of view. This paper aims at proposing such an interpretation, starting from the general idea introduced by Hinton (2007), anchoring it in a novel machine learning interpretation, and extending it to deep unsupervised generative modeling of the data. 

What has been observed in STDP is that the weights change if there is a pre-synaptic spike in the temporal vicinity of a post-synaptic spike: that change is positive if the postsynaptic spike happens just after the pre-synaptic spike, negative if it happens just before. Furthermore, the amount of change decays to zero as the temporal difference between the two spikes increases in magnitude. We are thus interested in this temporal window around a pre-synaptic spike during which we could have a post-synaptic spike, before or after the pre-synaptic spike. 

We propose a novel explanation for the STDP curve as a consequence of an actual update equation which makes a lot of sense from a machine learning perspective: 

**==> picture [148 x 13] intentionally omitted <==**

where _V_[˙] _j_ indicates the temporal derivative of _Vj_ , _Si_ indicates the pre-synaptic spike (from neuron _i_ ), and _Vj_ indicates the post-synaptic voltage potential (of neuron _j_ ). 

To see how the above update rule can give rise to STDP, consider the average effect of the rest of the inputs into 

**Towards Biologically Plausible Deep Learning** 

neuron _j_ , which induces an average temporal change _V_[˙] _j_ of the post-synaptic potential (which we assume approximately constant throughout the duration of the window around the pre-synaptic firing event), and assume that at time 0 when _Si_ spikes, _Vj_ is below the firing threshold. Let us call ∆ _T_ the temporal difference between the postsynaptic spike and the pre-synaptic spike. 

**==> picture [13 x 6] intentionally omitted <==**

**----- Start of picture text -----**<br>
∆W<br>**----- End of picture text -----**<br>


**==> picture [11 x 6] intentionally omitted <==**

**----- Start of picture text -----**<br>
∆T<br>**----- End of picture text -----**<br>


_Figure 1._ Result of simulation around pre-synaptic spike (time 0) showing indirectly the effect of a change in the rate of change in the post-synaptic voltage, _V_[˙] _j_ on both the average time difference between pre- and post-synaptic spikes (horizontal axis, ∆ _T_ ) and the average weight change (vertical axis, ∆ _Wij_ ), when the latter follows Eq. 1. This corresponds very well to the observed relationship between ∆ _T_ and ∆ _Wij_ in the biological literature. 

First, let us consider the case where _V_[˙] _j >_ 0, i.e., the voltage _V_ ˙ _j_ , it will take more or less time forpotential increases. Depending _V_ on _j_ to reach the firingthe magnitude of threshold, i.e. more time for smaller _V_[˙] _j_ . Hence _a longer_ ∆ _T corresponds to a smaller_ ∆ _Wij_ , and _a positive_ ∆ _T to a positive_ ∆ _Wij_ , as observed for STDP. 

Second, let us consider the case where _V_[˙] _j <_ 0, i.e., the voltage potential _has been decreasing_ (remember that we are considering the average effect of the rest of the inputs into neuron _j_ , and assuming that the temporal slope of that effect is locally constant). Thus, it is likely that _earlier before the pre-synaptic spike_ the post-synaptic voltage _Vj_ had been high enough to be above the firing threshold. How far back in the past again depends monotonically on _V_[˙] _j_ . Hence _a negative_ ∆ _T corresponds to a negative_ ∆ _Wij_ and _a more negative_ ∆ _T corresponds to a_ ∆ _Wij that is smaller in magnitude_ . This corresponds perfectly to the kind of relationship that is observed by biologists with STDP (see Figure 7 of Bi and Poo (1998) or Figure 1 of Sj¨ostr¨om and Gerstner (2010), e.g. at http://www.scholarpedia.org/article/ Spike-timing_dependent_plasticity). In a simulation inspired by the above analysis, we observe essentially the same curve relating the average ∆ _T_ and the ∆ _Wij_ that is associated with it, as illustrated in Figure 1. 

Clearly, the consequence of Eq. 1 is that **if the change** ∆ _Vj_ **corresponds to improving some objective function** _J_ **, then STDP** 

**corresponds to approximate stochastic gradient descent in that objective function** . With this view, STDP would implement the delta rule (gradient descent on a one-layer network) if the postsynaptic activation changes in the direction of the gradient. 

## **3. Variational EM with Learned Approximate Inference** 

To take advantage of the above statement, the dynamics of the neural network must be such that _neural activities move towards better values of some objective function J_ . Hence we would like to define such an objective function in a way that is consistent with the actual neural computation being performed (for fixed weights _W_ ), in the sense that the expected temporal change of the voltage potentials approximately corresponds to increases in _J_ . In this paper, we are going to consider the voltage potentials as the central variables of interest which influence _J_ and consider them as latent variables _V_ (denoted _h_ below to keep machine learning interpretation general), while we will consider the actual spike trains _S_ as non-linear noisy corruptions of _V_ , a form of quantization (with the “noise level” controlled either by the integration time or the number of redundant neurons in an ensemble (Legenstein and Maass, 2014)). This view makes the application of the denoising auto-encoder theorems discussed in Sec. 5 more straightforward. 

The main contribution of this paper is to propose and give support to the hypothesis that _J_ comes out of a _variational bound_ on the likelihood of the data. Variational bounds have been proposed to justify various learning algorithms for generative models (Hinton _et al._ , 1995) (Sec. 7). To keep the mapping to biology open, consider such bounds and the associated criteria that may be derived from them, using an abstract notation with _observed variable x_ and _latent variable h_ . If we have a model _p_ ( _x, h_ ) of their joint distribution, as well as some approximate inference mechanism defining a conditional distribution _q[∗]_ ( _H|x_ ), the observed data log-likelihood log _p_ ( _x_ ) can be decomposed as 

**==> picture [210 x 75] intentionally omitted <==**

where **H** [] denotes entropy and **KL** ( _||_ ) the Kullback-Leibler (KL) divergence, and where we have used sums but integrals should be considered when the variables are continuous. Since both the entropy and the KL-divergence are non-negative, we can either bound the log-likelihood via 

**==> picture [209 x 11] intentionally omitted <==**

or if we care only about optimizing _p_ , 

**==> picture [181 x 10] intentionally omitted <==**

The idea of variational bounds as proxies for the log-likelihood is that _as far as optimizing p is concerned, i.e., dropping the entropy term which does not depend on p, the bound becomes tight when q[∗]_ ( _H|x_ ) = _p_ ( _H|x_ ). This suggests that _q[∗]_ ( _H|x_ ) should approximate _p_ ( _H|x_ ). Fixing _q[∗]_ ( _H|x_ ) = _p_ ( _H|x_ ) and optimizing _p_ with _q_ fixed is the EM algorithm. Here (and in general) this is not possible so we consider variational methods in which _q[∗]_ ( _H|x_ ) approximates but does not reach _p_ ( _H|x_ ). This variational bound has recently been used to justify another biologically plausible 

**Towards Biologically Plausible Deep Learning** 

update rule (Rezende and Gerstner, 2014), which however relied on the REINFORCE algorithm (Williams, 1992) rather than on inference to obtain credit assignment to internal neurons. 

We propose to decompose _q[∗]_ ( _H|x_ ) in two components: _parametric initialization q_ 0( _H|x_ ) = _q_ ( _H|x_ ) and _iterative inference_ , implicitly defining _q[∗]_ ( _H|x_ ) = _qT_ ( _H|x_ ) via a deterministic or stochastic update, or transition operator 

**==> picture [172 x 10] intentionally omitted <==**

The variational bound suggests that _A_ ( _x_ ) should gradually bring _qt_ ( _H|x_ ) closer to _p_ ( _H|x_ ). At the same time, to make sure that a few steps will be sufficient to approach _p_ ( _H|x_ ), one may add a term in the objective function to make _q_ 0( _H|x_ ) closer to _p_ ( _H|x_ ), as well as to encourage _p_ ( _x, h_ ) to favor solutions _p_ ( _H|x_ ) that can be easily approximated by _qt_ ( _H|x_ ) even for small _t_ . 

For this purpose, consider as training objective a regularized variational MAP-EM criterion (for a given _x_ ): 

**==> picture [177 x 10] intentionally omitted <==**

where _h_ is a _free variable_ (for each _x_ ) initialized from _q_ ( _H|x_ ) and then iteratively updated to approximately maximize _J_ . The total objective function is just the average of _J_ over all examples after having performed inference (the approximate maximization over _h_ for each _x_ ). A reasonable variant would not just encourage _q_ = _q_ 0 to generate _h_ (given _x_ ), but all the _qt_ ’s for _t >_ 0 as well. Alternatively, the iterative inference could be performed by _stochastically_ increasing _J_ , i.e., via a Markov chain which may correspond to probabilistic inference with spiking neurons (Pecevski _et al._ , 2011). The corresponding variational MAP or variational MCMC algorithm would be as in Algorithm 1. For the stochastic version one would inject noise when updating _h_ . Variational MCMC (de Freitas _et al._ , 2001) can be used to approximate the posterior, e.g., as in the model from Salimans _et al._ (2014). However, a rejection step does not look very biologically plausible (both for the need of returning to a previous state and for the need to evaluate the joint likelihood, a global quantity). On the other hand, a _biased_ MCMC with no rejection step, such as the stochastic gradient Langevin MCMC of Welling and Teh (2011) can work very well in practice. 

**Algorithm 1** Variational MAP (or MCMC) SGD algorithm for gradually improving the agreement between the values of the latent variables _h_ and the observed data _x_ . _q_ ( _h|x_ ) is a learned parametric initialization for _h_ , _p_ ( _h_ ) is a parametric prior on the latent variables, and _p_ ( _x|h_ ) specifies how to generate _x_ given _h_ . Objective function _J_ is defined in Eq. 6 Learning rates _δ_ and _ϵ_ respectively control the optimization of _h_ and of parameters _θ_ (of both _q_ and _p_ ). 

Initialize _h ∼ q_ ( _h|x_ ) **for** _t_ = 1 to _T_ **do** ß _h ← h_ + _δ[∂J] ∂h_ (optional: add noise for MCMC) **end for** _θ ← θ_ + _ϵ[∂J] ∂θ_ 

## ß 

## **4. Training a Deep Generative Model** 

There is strong biological evidence of a distinct pattern of connectivity between cortical areas that distinguishes between “feedforward” and “feedback” connections (Douglas _et al._ , 1989) at 

the level of the microcircuit of cortex (i.e., feedforward and feedback connections do not land in the same type of cells). Furthermore, the feedforward connections form a directed acyclic graph with nodes (areas) updated in a particular order, e.g., in the visual cortex (Felleman and Essen, 1991). So consider Algorithm 1 with _h_ decomposed into multiple layers, with the conditional independence structure of a directed graphical model structured as a chain, both for _p_ (going down) and for _q_ (going up): 

**==> picture [216 x 59] intentionally omitted <==**

This clearly decouples the updates associated with each layer, for both _h_ and _θ_ , making these updates “local” to the layer _k_ , based on “feedback” from layer _k −_ 1 and _k_ + 1. Nonetheless, thanks to the iterative nature of the updates of _h_ , all the layers are interacting via both feedforward ( _q_ ( _h_[(] _[k]_[)] _|h_[(] _[k][−]_[1)] )) and feedback ( _p_ ( _h_[(] _[k]_[)] _|h_[(] _[k]_[+1)] ) paths. Denoting _x_ = _h_[(0)] to simplify notation, the _h_ update would thus consist in moves of the form 

**==> picture [231 x 49] intentionally omitted <==**

where _α_ is as in Eq. 6. No back-propagation is needed for the above derivatives when _h_[(] _[k]_[)] is on the left hand side of the conditional probability bar. Sec. 6 deals with the right hand side case. For the left hand side case, e.g., _p_ ( _h_[(] _[k]_[)] _|h_[(] _[k]_[+1)] ) a conditional Gaussian with mean _µ_ and variance _σ_[2] , the gradient with respect to _h_[(] _[k]_[)] is simply _[µ][−] σ[h]_[2][(] _[k]_[)] . Note that there is an interesting interpretation of such a deep model: the layers above _h_[(] _[k]_[)] provide a complex implicitly defined prior for _p_ ( _h_[(] _[k]_[)] ). 

## **5. Alternative Interpretations as Denoising Auto-Encoder** 

By inspection of Algorithm 1, one can observe that this algorithm trains _p_ ( _x|h_ ) and _q_ ( _h|x_ ) to form complementary pairs of an _autoencoder_ (since the input of one is the target of the other and viceversa). Note that from that point of view any of the two can act as encoder and the other as decoder for it, depending on whether we start from _h_ or from _x_ . In the case of multiple latent layers, each pair of conditionals _q_ ( _h_[(] _[k]_[+1)] _|h_[(] _[k]_[)] ) and _p_ ( _h_[(] _[k]_[)] _|h_[(] _[k]_[+1)] ) forms a symmetric auto-encoder, i.e., either one can act as the encoder and the other as the corresponding decoder, since they are trained with the same ( _h_[(] _[k]_[)] _, h_[(] _[k]_[+1)] ) pairs (but with reversed roles of input and target). 

In addition, if noise is injected, e.g., in the form of the quantization induced by a spike train, then the trained auto-encoders are actually denoising auto-encoders, which means that both the encoders and decoders are _contractive_ : in the neighborhood of the observed ( _x, h_ ) pairs, they map neighboring “corrupted” values to the “clean” ( _x, h_ ) values. 

## **5.1. Joint Denoising Auto-Encoder with Latent Variables** 

This suggests considering a special kind of “joint” denoising autoencoder which has the pair ( _x, h_ ) as “visible” variable, an autoencoder that implicitly estimates an underlying _p_ ( _x, h_ ). The 

**Towards Biologically Plausible Deep Learning** 

transition operator[3] for that joint visible-latent denoising autoencoder is the following in the case of a single hidden layer: 

**==> picture [169 x 27] intentionally omitted <==**

where the corruption may correspond to the stochastic quantization induced by the neuron non-linearity and spiking process. In the case of a middle layer _h_[(] _[k]_[)] in a deeper model, the transition operator must account for the fact that _h_[(] _[k]_[)] can either be reconstructed from above or from below, yielding, with probability say 

1 2[,] 

**==> picture [161 x 13] intentionally omitted <==**

and with one minus that probability, 

**==> picture [161 x 12] intentionally omitted <==**

Since this interpretation provides a different model, it also provides a different way of _generating_ samples. Especially for shallow, we have found that better samples could be obtained in this way, i.e., running the Markov chain with the above transition operator for a few steps. 

There might be a geometric interpretation for the improved quality of the samples when they are obtained in this way, compared to the directed generative model that was defined earlier. Denote _q[∗]_ ( _x_ ) the empirical distribution of the data, which defines a joint _q[∗]_ ( _h, x_ ) = _q[∗]_ ( _x_ ) _q[∗]_ ( _h|x_ ). Consider the likely situation where _p_ ( _x, h_ ) is not well matched to _q[∗]_ ( _h, x_ ) because for example the parametrization of _p_ ( _h_ ) is not powerful enough to capture the complex structure in the empirical distribution _q[∗]_ ( _h_ ) obtained by mapping the training data through the encoder and inference _q[∗]_ ( _h|x_ ). Typically, _q[∗]_ ( _x_ ) would concentrate on a manifold and the encoder would not be able to completely unfold it, so that _q[∗]_ ( _h_ ) would contain complicated structure with pockets or manifolds of high probability. If _p_ ( _h_ ) is a simple factorized model, then it will generate values of _h_ that do not correspond well to those seen by the decoder _p_ ( _x|h_ ) when it was trained, and these out-of-manifold samples in _h_ -space are likely to be mapped to out-of-manifold samples in _x_ -space. One solution to this problem is to increase the capacity of _p_ ( _h_ ) (e.g., by adding more layers on top of _h_ ). Another is to make _q_ ( _h|x_ ) more powerful (which again can be achieved by increasing the depth of the model, but this time by inserting additional layers below _h_ ). Now, there is a cheap way of obtaining a very deep directed graphical model, by unfolding the Markov chain of an MCMC-based generative model for a fixed number of steps, i.e., considering each step of the Markov chain as an extra “layer” in a deep directed generative model, with shared parameters across these layers. As we have seen that there is such an interpretation via the joint denoising auto-encoder over both latent and visible, this idea can be immediately applied. We know that each step of the Markov chain operator moves its input distribution closer to the stationary distribution of the chain. So if we start from samples from a very broad (say factorized) prior _p_ ( _h_ ) and we iteratively encode/decode them (injecting noise appropriately as during training) by successively sampling from _p_ ( _x|h_ ) and then from _q_ ( _h|x_ ), the resulting _h_ samples should end up looking more like those seen during training (i.e., from _q[∗]_ ( _h_ )). 

> 3See Theorem 1 from Bengio _et al._ (2013) for the generative interpretation of denoising auto-encoders: it basically states that one can sample from the model implicitly estimated by a denoising auto-encoder by simply alternating noise injection (corruption), encoding and decoding, these forming each step of a generative Markov chain. 

## **5.2. Latent Variables as Corruption** 

There is another interpretation of the training procedure, also as a denoising auto-encoder, which has the advantage of producing a generative procedure that is the same as the inference procedure except for _x_ being unclamped. 

We return again to the generative interpretation of the denoising criterion for auto-encoders, but this time we consider the nonparametric process _q[∗]_ ( _h|x_ ) as a kind of corruption of _x_ that yields the _h_ used as input for reconstructing the observed _x_ via _p_ ( _x|h_ ). Under that interpretation, a valid generative procedure consists at each step in first performing inference, i.e., sampling _h_ from _q[∗]_ ( _h|x_ ), and second sampling from _p_ ( _x|h_ ). Iterating these steps generates _x_ ’s according to the Markov chain whose stationary distribution is an estimator of the data generating distribution that produced the training _x_ ’s (Bengio _et al._ , 2013). This view does not care about how _q[∗]_ ( _h|x_ ) is constructed, but it tells us that if _p_ ( _x|h_ ) is trained to maximize reconstruction probability, then we can sample in this way from the implicitly estimated model. 

We have also found good results using this procedure (Algorithm 2 below), and from the point of view of biological plausibility, it would make more sense that “generating” should involve the same operations as “inference”, except for the input being observed or not. 

## **6. Targetprop instead of Backprop** 

In Algorithm 1 and the related stochastic variants Eq. 8 suggests that back-propagation (through one layer) is still needed when _h_[(] _[k]_[)] is on the right hand side of the conditional probability bar, e.g., to compute _[∂][p]_[(] _[h]_[(] _∂h[k][−]_[(][1] _[k]_[)][)] _[|][h]_[(] _[k]_[)][)] . Such a gradient is also the basic building block in back-propagation for supervised learning: we need to back-prop through one layer, e.g. to make _h_[(] _[k]_[)] more “compatible” with _h_[(] _[k][−]_[1)] . This provides a kind _error signal_ , which in the case of unsupervised learning comes from the sensors, and in the case of supervised learning, comes from the layer holding the observed “target”. 

Based on recent theoretical results on denoising auto-encoders, we propose the following estimator (up to a scaling constant) of the required gradient, which is related to previous work on “target propagation” (Bengio, 2014; Lee _et al._ , 2014) or targetprop for short. To make notation simpler, we focus below on the case of two layers _h_ and _x_ with “encoder” _q_ ( _h|x_ ) and “decoder” _p_ ( _x|h_ ), and we want to estimate _[∂]_[lo][g] _∂h[p]_[(] _[x][|][h]_[)] . We start with the special case where _p_ ( _x|h_ ) is a Gaussian with mean _g_ ( _h_ ) and _q_ ( _h|x_ ) is Gaussian with mean _f_ ( _x_ ), i.e., _f_ and _g_ are the deterministic components of the encoder and decoder respectively. The proposed estimator is then 

**==> picture [163 x 22] intentionally omitted <==**

where _σh_[2][is the variance of the noise injected in] _[ q]_[(] _[h][|][x]_[)][.] 

Let us now justify this estimator. Theorem 2 by Alain and Bengio (2013) states that in a denoising auto-encoder with reconstruction function _r_ ( _x_ ) = decode(encode( _x_ )), a well-trained autoencoder estimates the log-score via the difference between its reconstruction and its input: 

**==> picture [92 x 20] intentionally omitted <==**

where _σ_[2] is the variance of injected noise, and _p_ ( _x_ ) is the implicitly estimated density. We are now going to consider two denoising auto-encoders and apply this theorem to them. First, we 

**Towards Biologically Plausible Deep Learning** 

**==> picture [235 x 44] intentionally omitted <==**

Hence it is enough to estimate _[∂]_[lo][g] _∂h[p]_[(] _[x][,][h]_[)] as well as _[∂]_[lo] _∂h_[g] _[p]_[(] _[h]_[)] . The second one can be estimated by considering the auto-encoder which estimates _p_ ( _h_ ) implicitly and for which _g_ is the encoder (with _g_ ( _h_ ) the “code” for _h_ ) and _f_ is the decoder (with _f_ ( _g_ ( _h_ )) the “reconstruction” of _h_ ). Hence we have that _[f]_[(] _[g]_[(] _σ[h] h_[2][))] _[−][h]_ is an 

estimator of _[∂]_[lo] _∂h_[g] _[p]_[(] _[h]_[)] . 

The other gradient can be estimated by considering the joint denoising auto-encoder over ( _x, h_ ) introduced in the previous section. The (noise-free) reconstruction function for that autoencoder is 

**==> picture [235 x 63] intentionally omitted <==**

which corresponds to Eq. 12. 

_Figure 2._ The optimal _h_ for maximizing _p_ ( _x|h_ ) is _h_[˜] s.t. _g_ ( _h_[˜] ) = _x_ . Since the encoder _f_ and decoder _g_ are approximate inverses of each other, their composition makes a small move ∆ _x_ . Eq. 12 ˜ is obtained by assuming that by considering an _x_ at _x −_ ∆ and applying _f ◦ g_ , one would approximately recover _x_ , which should be true if the changes are small and the functions smooth (see Lee and Bengio (2014) for a detailed derivation). 

Another way to obtain the same formula from a geometric perspective is illustrated in Figure 2. It was introduced in Lee and Bengio (2014) in the context of a backprop-free algorithm for training a denoising auto-encoder. 

## **7. Related Work** 

An important inspiration for the proposed framework is the biological implementation of back-propagation proposed by Hinton (2007). In that talk, Hinton suggests that STDP corresponds to a gradient update step with the gradient on the voltage potential corresponding to its temporal derivative. To obtain the supervised back-propagation update in the proposed scenario would require symmetric weights and synchronization of the computations in terms of feedforward and feedback phases. 

Our proposal introduces a novel machine learning interpretation that also matches the STDP behavior, based on a variational EM framework, allowing us to obtain a more biologically plausible mechanism for deep generative unsupervised learning, avoiding the need for symmetric weights, and introducing a novel method to obtain neural updates that approximately propagate gradients and move towards better overall configurations of neural activity 

(with difference target-prop). There is also an interesting connection with an earlier proposal for a more biologically plausible implementation of supervised back-propagation (Xie and Seung, 2003) which also relies on iterative inference (a deterministic relaxation in that case), but needs symmetric weights. 

Another important inspiration is Predictive Sparse Decomposition (PSD) (Kavukcuoglu _et al._ , 2008). PSD is a special case of Algorithm 1 when there is only one layer and the encoder _q_ ( _h|x_ ), decoder _p_ ( _x|h_ ), and prior _p_ ( _h_ ) have a specific form which makes _p_ ( _x, h_ ) a sparse coding model and _q_ ( _h|x_ ) a fast parametric approximation of the correct posterior. Our proposal extends PSD by providing a justification for the training criterion as a variational bound, by generalizing to multiple layers of latent variables, and by providing associated generative procedures. 

The combination of a parametric approximate inference machine (the encoder) and a generative decoder (each with possibly several layers of latent variables) is an old theme that was started with the Wake-Sleep algorithm (Hinton _et al._ , 1995) and which finds very interesting instantiations in the variational auto-encoder (Kingma and Welling, 2014; Kingma _et al._ , 2014) and the reweighted wakesleep algorithm (Bornschein and Bengio, 2014). Two important differences with the approach proposed here is that here we avoid back-propagation thanks to an inference step that approximates the posterior. In this spirit, see the recent work introducing MCMC inference for the variational auto-encoder Salimans _et al._ (2014). 

The proposal made here also owes a lot to the idea of target propagation introduced in Bengio (2014); Lee _et al._ (2014), to which it adds the idea that in order to find a target that is consistent with both the input and the final output target, it makes sense to perform iterative inference, reconciling the bottom-up and top-down pressures. Addressing the weight transport problem (the weight symmetry constraint) was also done for the supervised case using _feedback alignment_ (Lillicrap _et al._ , 2014): even if the feedback weights do not exactly match the feedforward weights, the latter learn to align to the former and “back-propagation” (with the wrong feedback weights) still works. 

The targetprop formula avoiding back-propagation through one layer is actually the same as proposed by Lee and Bengio (2014) for backprop-free auto-encoders. What has been added here is a justification of this specific formula based on the denoising autoencoder theorem from Alain and Bengio (2013), and the empirical validation of its ability to climb the joint likelihood for variational inference. 

Compared to previous work on auto-encoders, and in particular their generative interpretation (Bengio _et al._ , 2013; 2014), this paper for the first time introduces latent variables without requiring back-propagation for training. 

## **8. Experimental Validation** 

Figure 3 shows generated samples obtained after training on MNIST with Algorithm 2 (derived from the considerations of Sec.s 4, 5 and 6). The network has two hidden layers, _h_ 1 with 1000 softplus units and _h_ 2 with 100 sigmoid units (which can be considered biologically plausible (Glorot _et al._ , 2011)). We trained for 20 epochs, with minibatches of size 100 to speedup computation using GPUs. Results can be reproduced from code at http://goo.gl/hoQqR5. Using the Parzen density estimator previously used for that data, we obtain an estimated log-likelihood LL=236 (using a standard deviation of 0.2 

**==> picture [177 x 9] intentionally omitted <==**

**----- Start of picture text -----**<br>
Towards Biologically Plausible Deep Learning<br>**----- End of picture text -----**<br>


_Figure 5._ Examples of filling-in (in-painting) missing (initially corrupted) parts of an image. Left: original MNIST test examples. Middle: initial state of the inference, with half of the pixels randomly sampled (with a different corruption pattern in each row of the figure). Right: reconstructions using a variant of the INFERENCE procedure of Algorithm 2 for the case when some inputs are clamped. 

**==> picture [181 x 126] intentionally omitted <==**

**----- Start of picture text -----**<br>
30<br>35<br>- ren ner e e r  ne e t<br>40<br>ee ea<br>45<br>|e<br>50<br>55<br>-f<br>0 5 10 15 20<br>MAP iteration<br>average log p(x, h)<br>**----- End of picture text -----**<br>


_Figure 3._ MNIST samples generated by GENERATE from Algorithm 2 after training with TRAIN. 

_Figure 4._ Increase of log _p_ ( _x, h_ ) over 20 iterations of the INFERENCE algorithm 2, showing that the targetprop updates increase the joint likelihood. The solid red line shows the average and the standard error over the full testset containing 10,000 digits. Dashed lines show log _p_ ( _x, h_ ) for individual datapoints. 

for the Parzen density estimator, chosen with the validation set), which is about the same or better as was obtained for contractive auto-encoders (Rifai _et al._ , 2011) (LL=121), deeper generative stochastic networks (Bengio _et al._ , 2014) (LL=214) and generative adversarial networks (Goodfellow _et al._ , 2014) (LL=225). In accordance with Algorithm 2, the variances of the conditional densities are 1, and the top-level prior is ignored during most of training (as if it was a very broad, uniform prior) and only set to the Gaussian by the end of training, before generation (by setting the parameters of _p_ ( _h_ 2) to the empirical mean and variance of the projected training examples at the top level). Figure 4 shows that the targetprop updates (instead of the gradient updates) allow the inference process to indeed smoothly increase the joint likelihood. Note that if we sample using the directed graphical model _p_ ( _x|h_ ) _p_ ( _h_ ), the samples are not as good and LL=126, suggesting as discussed in Sec. 5 that additional inference and encode/decode iterations move _h_ towards values that are closer to _q[∗]_ ( _h_ ) (the empirical distribution of inferred states from training examples). The experiment illustrated in Figure 5 shows that the proposed inference mechanism can be used to fill-in missing values with a trained model. The model is the same that was trained using Algorithm 2 (with samples shown in Figure 3). 20 iterations steps of encode/decode as described below were performed, with a call 

to INFERENCE (to maximize _p_ ( _x, h_ ) over _h_ ) for each step, with a slight modification. Instead of using _f_ 1( _x_ ) _− f_ 1( _g_ 1( _h_ )) to account for the pressure of _x_ upon _h_ (towards maximizing _p_ ( _x|h_ )), we used _f_ 1( _x[v] , g[m]_ ( _h_ )) _− f_ ( _g_ ( _h_ )), where _x[v]_ is the part of _x_ that is visible (clamped) while _g[m]_ ( _h_ ) is the part of the output of _g_ ( _h_ ) that concerns the missing (corrupted) inputs. This formula was derived from the same consideration as for Eq. 12, but where the quantity of interest is _[∂]_[lo][g] _∂h[p]_[(] _[x][v][|][h]_[)] rather than _[∂]_[lo][g] _∂h[p]_[(] _[x][|][h]_[)] , and we consider that the reconstruction of _h_ , given _x[v]_ , fills-in the missing inputs ( _x[m]_ ) from _g[m]_ ( _h_ ). 

## **9. Future Work and Conclusion** 

We consider this paper as an exploratory step towards explaining a central aspect of the brain’s learning algorithm: _credit assignment through many layers_ . Of the non-plausible elements of back-propagation described in the introduction, the proposed approach addresses all except the 5th. As argued by Bengio (2014); Lee _et al._ (2014), departing from back-propagation could be useful not just for biological plausibility but from a machine learning point of view as well: by working on the “targets” for the intermediate layers, we may avoid the kind of reliance on smoothness and derivatives that characterizes back-propagation, as these tech- 

**Towards Biologically Plausible Deep Learning** 

niques can in principle work even with highly non-linear transformations for which gradients are often near 0, e.g., with stochastic binary units (Lee _et al._ , 2014). Besides the connection between STDP and variational EM, an important contribution of this paper is to show that the “targetprop” update which estimates the gradient through one layer can be used for inference, yielding systematic improvements in the joint likelihood and allowing to learn a good generative model. Another interesting contribution is that the variational EM updates, with noise added, can also be interpreted as training a denoising auto-encoder over both visible and latent variables, and that iterating from the associated Markov chain yields better samples than those obtained from the directed graphical model estimated by variational EM. 

Many directions need to be investigated to follow-up on the work reported here. An important element of neural circuitry is the strong presence of lateral connections between nearby neurons in the same area. In the proposed framework, an obvious place for such lateral connections is to implement the prior on the joint distribution between nearby neurons, something we have not explored in our experiments. For example, Garrigues and Olshausen (2008) have discussed neural implementations of the inference involved in sparse coding based on the lateral connections. 

Although we have found that “injecting noise” helped training a better model, more theoretical work needs to be done to explore this replacement of a MAP-based inference by an MCMC-like inference, which should help determine how and how much of this noise should be injected. 

Whereas this paper focused on unsupervised learning, these ideas could be applied to supervised learning and reinforcement learning as well. For reinforcement learning, an important role of the proposed algorithms is to learn to predict rewards, although a more challenging question is how the MCMC part could be used to simulate future events. For both supervised learning and reinforcement learning, we would probably want to add a mechanism that would give more weight to minimizing prediction (or reconstruction) error for some of the observed signals (e.g. _y_ is more important to predict than _x_ ). 

Finally, a lot needs to be done to connect in more detail the proposals made here with biology, including neural implementation using spikes with Poisson rates as the source of signal quantization and randomness, taking into account the constraints on the sign of the weights depending on whether the pre-synaptic neuron is inhibitory or excitatory, etc. In addition, although the operations proposed here are backprop-free, they may still require some kinds of synchronizations (or control mechanism) and specific connectivity to be implemented in brains. 

## **Acknowledgments** 

The authors would like to thank Jyri Kivinen, Tim Lillicrap and Saizheng Zhang for feedback and discussions, as well as NSERC, CIFAR, Samsung and Canada Research Chairs for funding, and Compute Canada for computing resources. 

## **References** 

- Alain, G. and Bengio, Y. (2013). What regularized auto-encoders learn from the data generating distribution. In _ICLR’2013_ . also arXiv report 1211.4246. 

- Bengio, Y. (2014). How auto-encoders could provide credit assignment in deep networks via target propagation. Technical report, arXiv:1407.7906. 

- Bengio, Y., Yao, L., Alain, G., and Vincent, P. (2013). Generalized denoising auto-encoders as generative models. In _NIPS’2013_ . 

- Bengio, Y., Thibodeau-Laufer, E., Alain, G., and Yosinski, J. (2014). Deep generative stochastic networks trainable by backprop. In _ICML’2014_ . 

- Bi, G. Q. and Poo, M. M. (1998). Synaptic modifications in cultured hippocampal neurons: dependence on spike timing, synaptic strength, and postsynaptic cell type. _J Neurosci_ , **18** , 10464–10472. 

- Bornschein, J. and Bengio, Y. (2014). Reweighted wake-sleep. Technical report, arXiv:1406.2751. 

- de Freitas, N., Højen-Sørensen, P., Jordan, M. I., and Russell, S. (2001). Variational MCMC. In _UAI’2001_ , pages 120–127. 

- Douglas, R. J., Martin, K. A., and Whitteridge, D. (1989). A canonical microcircuit for neocortex. _Neural Computation_ , **1** (480-–488). 

- Felleman, D. J. and Essen, D. C. V. (1991). Distributed hierarchical processing in the primate cerebral cortex. _Cerebral Cortex_ , **1** , 1–47. 

- Garrigues, P. and Olshausen, B. (2008). Learning horizontal connections in a sparse coding model of natural images. In J. Platt, D. Koller, Y. Singer, and S. Roweis, editors, _Advances in Neural Information Processing Systems 20 (NIPS’07)_ , pages 505– 512. MIT Press, Cambridge, MA. 

- Gerstner, W., Kempter, R., van Hemmen, J., and Wagner, H. (1996). A neuronal learning rule for sub-millisecond temporal coding. _Nature_ , **386** , 76–78. 

- Glorot, X., Bordes, A., and Bengio, Y. (2011). Deep sparse rectiIn _AISTATS’2011_ . 

- Goodfellow, I., Le, Q., Saxe, A., and Ng, A. (2009). Measuring invariances in deep networks. In _NIPS’2009_ , pages 646–654. 

- Goodfellow, I. J., Pouget-Abadie, J., Mirza, M., Xu, B., WardeFarley, D., Ozair, S., Courville, A., and Bengio, Y. (2014). Generative adversarial networks. In _NIPS’2014_ . 

- Hinton, G. E. (2007). How to do backpropagation in a brain. Invited talk at the NIPS’2007 Deep Learning Workshop. 

- Hinton, G. E. and Sejnowski, T. J. (1986). Learning and relearning in Boltzmann machines. In D. E. Rumelhart and J. L. McClelland, editors, _Parallel Distributed Processing: Explorations in the Microstructure of Cognition. Volume 1: Foundations_ , pages 282–317. MIT Press, Cambridge, MA. 

- Hinton, G. E., Dayan, P., Frey, B. J., and Neal, R. M. (1995). The wake-sleep algorithm for unsupervised neural networks. _Science_ , **268** , 1558–1161. 

- Hinton, G. E., Osindero, S., and Teh, Y. (2006). A fast learning algorithm for deep belief nets. _Neural Computation_ , **18** , 1527– 1554. 

**Towards Biologically Plausible Deep Learning** 

- Kavukcuoglu, K., Ranzato, M., and LeCun, Y. (2008). Fast inference in sparse coding algorithms with applications to object recognition. Technical report, Computational and Biological Learning Lab, Courant Institute, NYU. Tech Report CBLLTR-2008-12-01. 

- Kingma, D., Rezende, D., Mohamed, S., and Welling, M. (2014). Semi-supervised learning with deep generative models. In _NIPS’2014_ . 

- Kingma, D. P. and Welling, M. (2014). Auto-encoding variational bayes. In _Proceedings of the International Conference on Learning Representations (ICLR)_ . 

- Lee, D.-H. and Bengio, Y. (2014). Backprop-free auto-encoders. NIPS’2014 Deep Learning workshop. 

- Lee, D.-H., Zhang, S., Biard, A., and Bengio, Y. (2014). Target propagation. arXiv 1412.7525. 

- Legenstein, R. and Maass, W. (2014). Ensembles of spiking neurons with noise support optimal probabilistic inference in a dynamically changing environment. _PLOS Computational Biology_ , **10** (10). 

   - Vincent, P., Larochelle, H., Bengio, Y., and Manzagol, P.-A. (2008). Extracting and composing robust features with denoising autoencoders. In _ICML 2008_ . 

   - Welling, M. and Teh, Y.-W. (2011). Bayesian learning via stochastic gradient Langevin dynamics. In _ICML’2011_ , pages 681–688. 

   - Williams, R. J. (1992). Simple statistical gradient-following algorithms connectionist reinforcement learning. _Machine Learning_ , **8** , 229–256. 

   - Xie, X. and Seung, H. S. (2000). Spike-based learning rules and stabilization of persistent neural activity. In S. Solla, T. Leen, and K. M¨uller, editors, _Advances in Neural Information Processing Systems 12_ , pages 199–208. MIT Press. 

   - Xie, X. and Seung, H. S. (2003). Equivalence of backpropagation and contrastive Hebbian learning in a layered network. _Neural Computation_ . 

- Lillicrap, T. P., Cownden, D., Tweed, D. B., and Akerman, C. J. (2014). Random feedback weights support learning in deep neural networks. arXiv:1411.0247. 

- Markram, H. and Sakmann, B. (1995). Action potentials propagating back into dendrites triggers changes in efficacy. _Soc. Neurosci. Abs_ , **21** . 

- Neal, R. and Hinton, G. (1999). A view of the EM algorithm that justifies incremental, sparse, and other variants. In M. I. Jordan, editor, _Learning in Graphical Models_ . MIT Press, Cambridge, MA. 

- Pecevski, D., Buesing, L., and Maass, W. (2011). Probabilistic inference in general graphical models through sampling in stochastic networks of spiking neurons. _PLOS Computational Biology_ . 

- Ranzato, M., Poultney, C., Chopra, S., and LeCun, Y. (2007). Efficient learning of sparse representations with an energy-based model. In _NIPS’2006_ . 

- Rezende, D. J. and Gerstner, W. (2014). Stochastic variational learning in recurrent spiking networks. _Frontiers in Computational Neuroscience_ , **8** (38). 

- Rifai, S., Vincent, P., Muller, X., Glorot, X., and Bengio, Y. (2011). Contractive auto-encoders: Explicit invariance during feature extraction. In _ICML’2011_ . 

- Salakhutdinov, R. and Hinton, G. (2009). Deep Boltzmann machines. In _AISTATS’2009_ . 

- Salimans, T., Kingma, D. P., and Welling, M. (2014). Markov Chain Monte Carlo and Variational Inference: Bridging the Gap. arXiv:1410.6460. 

- Sj¨ostr¨om, J. and Gerstner, W. (2010). Spike timing dependent plasticity. _Scholarpedia_ , **5** (2). 

- Smolensky, P. (1986). Information processing in dynamical systems: Foundations of harmony theory. In D. E. Rumelhart and J. L. McClelland, editors, _Parallel Distributed Processing_ , volume 1, chapter 6, pages 194–281. MIT Press, Cambridge. 

**Towards Biologically Plausible Deep Learning** 

**Algorithm 2** Inference, training and generation procedures used in Experiment 1. The algorithm can naturally be extended to more layers. _fi_ () is the feedforward map from layer _i−_ 1 to layer _i_ and _gi_ () is the feedback map from layer _i_ to layer _i−_ 1, with _x_ = _h_ 0 being layer 0. 

ß Define INFERENCE( _x_ , _N_ =15, _δ_ =0.1, _α_ =0.001): Feedforward pass: _h_ 1 _← f_ 1( _x_ ), _h_ 2 _← f_ 2( _h_ 1) **for** _t_ = 1 to _N_ **do** _h_ 2 _← h_ 2 + _δ_ ( _f_ 2( _h_ 1) _− f_ 2( _g_ 2( _h_ 2))) _h_ 1 _← h_ 1 + _δ_ ( _f_ 1( _x_ ) _− f_ 1( _g_ 1( _h_ 1))) + _α_ ( _g_ 2( _h_ 2) _− h_ 1) **end for Return** _h_ 1, _h_ 2 

Define TRAIN() **for** _x_ in training set **do** _h_ 1 _, h_ 2 _←_ INFERENCE( _x_ ) (i.e. E-part of EM) update each layer using local targets (M-part of EM) Θ _←_ Θ + _ϵ ∂[∂]_ Θ[(] _[g][l]_[(˜] _[h][l]_[)] _[ −][h][l][−]_[1][)][2] Θ _←_ Θ + _ϵ ∂[∂]_ Θ[(] _[f][l]_[(˜] _[h][l][−]_[1][)] _[ −][h][l]_[)][2] where _h_[˜] _l_ is a Gaussian-corrupted version of _hl_ . For the top sigmoid layer _h_[˜] 2 we average 3 samples from a Bernoulli distribution with _p_ ( _h_[˜] 2 = 1) = _h_ 2 to obtain a _spike-like_ corruption. **end for** Compute the mean and variance of _h_ 2 using the training set. Multiply the variances by 4. Define _p_ ( _h_ 2) as sampling from this Gaussian. 

Define GENERATE(): Sample _h_ 2 from _p_ ( _h_ 2) Assign _h_ 1 _← g_ 2( _h_ 2) and _x ← g_ 1( _h_ 1) **for** _t_ = 1 to 3 **do** _h_ 1 _, h_ 2 _←_ INFERENCE( _x_ , _α_ = 0 _._ 3) _x ← g_ 1( _h_ 1) **end for Return** _x_ 

ß 

