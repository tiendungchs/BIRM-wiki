# **Assessing the Scalability of Biologically-Motivated Deep Learning Algorithms and Architectures** 

**Sergey Bartunov** DeepMind 

**Adam Santoro Blake A. Richards Luke Marris** DeepMind University of Toronto DeepMind 

**Geoffrey E. Hinton** Google Brain 

**Timothy P. Lillicrap** DeepMind, University College London 

## **Abstract** 

The backpropagation of error algorithm (BP) is impossible to implement in a real brain. The recent success of deep networks in machine learning and AI, however, has inspired proposals for understanding how the brain might learn across multiple layers, and hence how it might approximate BP. As of yet, none of these proposals have been rigorously evaluated on tasks where BP-guided deep learning has proved critical, or in architectures more structured than simple fully-connected networks. Here we present results on scaling up biologically motivated models of deep learning on datasets which need deep networks with appropriate architectures to achieve good performance. We present results on the MNIST, CIFAR-10, and ImageNet datasets and explore variants of target-propagation (TP) and feedback alignment (FA) algorithms, and explore performance in both fully- and locally-connected architectures. We also introduce weight-transport-free variants of difference target propagation (DTP) modified to remove backpropagation from the penultimate layer. Many of these algorithms perform well for MNIST, but for CIFAR and ImageNet we find that TP and FA variants perform significantly worse than BP, especially for networks composed of locally connected units, opening questions about whether new architectures and algorithms are required to scale these approaches. Our results and implementation details help establish baselines for biologically motivated deep learning schemes going forward. 

## **1 Introduction** 

The suitability of the backpropagation of error (BP) algorithm [32] for explaining learning in the brain was questioned soon after it was popularized [11, 8]. Weaker objections included undesirable characteristics of artificial networks in general, such as their violation of Dale’s Law, their lack of cell-type variability, and the need for the gradient signals to be both positive and negative. More serious objections were: (1) The need for the feedback connections carrying the gradient to have the same weights as the corresponding feedforward connections and (2) The need for a distinct form of information propagation (error feedback) that does not influence neural activity, and hence does not conform to known biological feedback mechanisms underlying neural communication. Researchers have long sought biologically plausible and empirically powerful learning algorithms that avoid these flaws [2, 30, 31, 1, 26, 39, 14, 16, 12, 5, 23]. Recent work has demonstrated that the first objection may not be as problematic as often supposed [22]: the feedback alignment (FA) algorithm uses random weights in backward pathways to successfully deliver error information to earlier layers. At the same time, FA still suffers from the second objection: it requires the delivery of signed error vectors via a distinct pathway. 

32nd Conference on Neural Information Processing Systems (NIPS 2018), Montr´eal, Canada. 

Another family of promising approaches to biologically motivated deep learning – such as Contrastive Hebbian Learning [24], and Generalized Recirculation [26] – use top-down feedback connections to influence _neural activity_ , and _differences_ in feedfoward-driven and feedback-driven activities (or products of activities) to locally approximate gradients [1, 31, 26, 39, 4, 36, 38]. Since these activity propagation methods don’t require explicit propagation of gradients through the network, they go a long way towards answering the second serious objection noted above. However, many of these methods require long “positive” and “negative” settling phases for computing the activities whose differences provide the learning signal. Proposals for shortening the phases [13, 6] are not entirely satisfactory as they still fundamentally depend on a settling process, and, in general, any settling process will likely be too slow for a brain that needs to quickly compute hidden activities in order to act in real time. 

Perhaps the most practical among this family of “activity propagation” algorithms is target propagation (TP) and its variants [19, 20, 13, 3, 21]. TP avoids the weight transport problem by training a distinct set of feedback connections that define the backward activity propagation. These connnections are trained to approximately invert the computation of the feedforward connections in order to be able to compute _target activities_ for each layer by successively inverting the desired output target. Another appealing property of TP is that the errors guiding weight updates are computed locally along with backward activities. 

While TP and its variants are promising as biologically-motivated algorithms, there are lingering questions about their applicability to the brain. First, the only variant explored empirically (i.e. DTP) still depends on explicit gradient computation via backpropagation for learning the penultimate layer’s outgoing synaptic weights (see Algorithm Box 1 in Lee et al. [21]). Second, they have not been rigorously tested on datasets more difficult than MNIST. And third, they have not been incorporated into architectures more complicated than simple multi-layer perceptrons (MLPs). 

On this second point, it might be argued that an algorithm’s inability to scale to difficult machine learning datasets is a red herring when assessing whether it could help us understand learning in the brain. Performance on isolated machine learning tasks using a model that lacks other adaptive neural phenomena – e.g., varieties of plasticity, evolutionary priors, etc. – makes a statement about the lack of these phenomena as much as it does about the suitability of an algorithm. Nonetheless, we argue that there is a need for _behavioural_ realism, in addition to _physiological_ realism, when gathering evidence to assess the overall _biological_ realism of a learning algorithm. Given that human beings are able to learn complex tasks that bear little relationship to their evolution, it would appear that the brain possesses a powerful, general-purpose learning algorithm for shaping behavior. As such, researchers can, and should, seek learning algorithms that are both more plausible physiologically, and scale up to the sorts of complex tasks that humans are capable of learning. Augmenting a model with adaptive capabilities is unlikely to unveil any truths about the brain if the model’s performance is crippled by an insufficiently powerful learning algorithm. On the other hand, demonstrating good performance with even a vanilla artificial neural network provides evidence that, at the very least, the learning algorithm _is not limiting_ . Ultimately, we need a confluence of evidence for: (1) the sufficiency of a learning algorithm, (2) the impact of biological constraints in a network, and (3) the necessity of other adaptive neural capabilities. This paper focuses on addressing the first two. 

In this work our contribution is threefold: (1) We examine the learning and performance of biologically-motivated algorithms on MNIST, CIFAR, and ImageNet. (2) We introduce variants of DTP which eliminate significant lingering biologically implausible features from the algorithm. (3) We investigate the role of weight-sharing convolutions, which are key to performance on difficult datasets in artificial neural networks, by testing the effectiveness of locally connected architectures trained with BP and variants of FA and TP. 

Overall, our results are largely negative. That is, we find that none of the tested algorithms are capable of effectively scaling up to training large networks on ImageNet. There are three possible interpretations from these results: (1) Existing algorithms need to be modified, added to, and/or optimized to account for learning in the real brain, (2) research should continue into new physiologically realistic learning algorithms that can scale-up, or (3) we need to appeal to other adaptive capacities to account for the fact that humans are able to perform well on this task. Ultimately, our negative results are important because they demonstrate the need for continued work to understand the power of learning in the human brain. More broadly, we suggest that behavioural realism, as judged by performance 

2 

**==> picture [299 x 197] intentionally omitted <==**

**----- Start of picture text -----**<br>
Backpropagation Difference Target Propagation Simplified Difference Target Propagation<br>"8" "8" "8"<br>Output Target"3" Output Target"3" Output Target"3"<br>gradient  gradient<br>| || hy =<br>hr ©...)_ alt)<br>Ap>  = hpi oot) OL(h hpx  =<br>ey [UL] aan<br>AO. Osha)<br>= fayA = hy = g(a); hy =hy—=h<br>+ (ha) fa = ha ~<br>Input Input Input<br>(a) (b) (c)<br>... ... ...<br>**----- End of picture text -----**<br>


Figure 1: In BP and DTP, the final layer target is used to compute a loss, and the gradients from this loss are shuttled backwards (through all layers, in BP, or just one layer, in DTP) in error propagation steps that do not influence actual neural activity. SDTP never transports gradients using error propagation steps, unlike DTP and BP. 

on difficult tasks, should increasingly become one of the metrics used in evaluating the biological realism of computational models and algorithms. 

## **2 Learning in Multilayer Networks** 

Consider the case of a feed-forward neural network with _L_ layers _{hl}[L] l_ =1[, whose activations] _[ h][l]_[are] computed by elementwise-applying a non-linear function _σl_ to an affine transformation of previous layer activations _hl−_ 1: 

**==> picture [310 x 11] intentionally omitted <==**

with input to the network denoted as _h_ 0 = _x_ and the last layer _hL_ used as output. 

In classification problems the output layer _hL_ parametrizes a predicted distribution over possible labels _p_ ( _y|hL_ ), usually using the softmax function. The learning signal is then provided as a loss _L_ ( _hL_ ) incurred by making a prediction for an input _x_ , which in the classification case can be cross-entropy between the ground-truth label distribution _q_ ( _y|x_ ) and the predicted one: _L_ ( _hL_ ) = _− y[q]_[(] _[y][|][x]_[) log] _[ p]_[(] _[y][|][h][L]_[)] _[.]_[ The goal of training is then to adjust the parameters][ Θ =] _[ {][θ][l][}] l[L]_ =1[in order] to minimize a given loss over the training set of inputs. 

## **2.1 Backpropagation** 

Backpropagation [32] was popularized as a method for training neural networks by computing gradients with respect to layer parameters using the chain rule: 

**==> picture [395 x 27] intentionally omitted <==**

Thus, gradients are obtained by first propagating activations forward to the output layer via eq. 1, and then recursively applying these backward equations. These equations imply that gradients are propagated backwards through the network using weights symmetric to their feedforward counterparts. This is biologically problematic because it implies a mode of information propagation (error propagation) that does not influence neural activity, and that depends on an implausible network architecture (symmetric weight connectivity for feedforward and feedback directions, which is called the weight transport problem). 

3 

## **2.1.1 Feedback alignment** 

While we focus on TP variants in this manuscript, with the purpose of a more complete experimental study of biologically motivated algorithms, we explore FA as another baseline. FA replaces the transpose weight matrices in the backward pass for BP with fixed random connections. Thus, FA shares features with both target propagation and conventional backpropagation. On the one hand, it alleviates the weight transport problem by maintaining a separate set of connections that, under certain conditions, lead to synchronized learning of the network. On the other hand, similar to backpropagation, FA transports signed error information in the backward pass, which may be problematic to implement as a plausible neural computation. We consider both the classical variant of FA [23] with random feedback weights at each hidden layer, and the recently proposed Direct Feedback Alignment [25] (DFA) or Broadcast Feedback Alignment [35], which connect feedback from the output layer directly to all previous layers directly. 

## **2.1.2 Target propagation and its variants** 

Unlike backpropagation, where backwards communication passes on gradients without inducing or altering neural activity, the backward pass in target propagation [19, 20, 3, 21] takes place in the same space as the forward-pass neural activity. The backward induced activities are those that layers should strive to match so as to produce the target output. After feedforward propagation given some input, the final output layer _hL_ is trained directly to minimize the loss _L_ , while all other layers are trained so as to match their associated targets. 

In general, good targets are those that minimize the loss computed in the output layer if they had been realized in feedforward propagation. In networks with invertible layers one could generate such targets by first finding a loss-optimal output activation _h_[ˆ] _L_ (e.g. the correct label distribution) and then propagating it back using inverse transformations _h_[ˆ] _l_ = _f[−]_[1] ( _h_[ˆ] _l_ +1; _θl_ +1). Since it is hard to maintain invertibility in a network, approximate inverse transformations (or decoders) can be learned _g_ ( _hl_ +1; _λl_ +1) _≈ f[−]_[1] ( _hl_ +1; _θl_ +1). Note that this learning obviates the need for symmetric weight connectivity. 

The generic form of target propagation algorithms we consider in this paper can be summarized as a scheduled minimization of two kinds of losses for each layer. 

1. _Reconstruction_ or _inverse loss L[inv] l_ ( _λl_ ) = _∥hl−_ 1 _− g_ ( _f_ ( _hl−_ 1; _θl−_ 1); _λl_ ) _∥_ 2[2][is][used][to] train the approximate inverse that is parametrized similarly to the forward computation: _g_ ( _hl_ ; _λl_ ) = _σl_ ( _Vlhl_ + _cl_ ) _, λl_ = _{Vl, cl},_ where activations _hl−_ 1 are assumed to be propagated from the input. One can imagine other learning rules for the inverse, for example, the original DTP algorithm trained inverses on noise-corrupted versions of activations with the purpose of improved generalization. The loss is applied for every layer except the first, since the first layer does not need to propagate target inverses backwards. 

2. _Forward loss Ll_ ( _θl_ ) = _∥f_ ( _hl_ ; _θl_ ) _− h_[ˆ] _l_ +1 _∥_ 2[2][penalizes the layer parameters for producing] activations different from their targets. Parameters of the last layer are trained to minimize the task’s loss _L_ directly. 

Under this framework both losses are local and involve only a single layer’s parameters, and implicit dependencies on other layer’s parameters are ignored. Variants differ in the way targets _h_[ˆ] _l_ are computed. 

**Target propagation** “Vanilla” target propagation (TP) computes targets by propagating the higher layers’ targets backwards through layer-wise inverses; i.e. _h_[ˆ] _l_ = _g_ ( _h_[ˆ] _l_ +1; _λl_ +1). For traditional categorization tasks the same 1-hot vector in the output will always map back to precisely the same hidden unit activities in a given layer. Thus, this kind of naive TP may have difficulties when different instances of the same class have different appearances, since it will attempt to make their representations identical even in the early layers. As well, there are no guarantees about how TP will behave when the inverses are imperfect. 

**Difference target propagation** Both TP and DTP update the output weights and biases using the standard delta rule, but this is biologically unproblematic because it does not require weight 

4 

ˆ _hl_ = _g_ (ˆ _hl_ +1; _λl_ +1) + [ _hl − g_ ( _hl_ +1; _λl_ +1)] _._ (2) 

transport [26, 23]. For most other layers in the network, DTP [21] computes targets as 

The second term is the error in the reconstruction, which provides a stabilizing linear correction for imprecise inverse functions. However, in the original work by Lee et al. [21] the penultimate layer target, _h_[ˆ] _L−_ 1, was computed using gradients from the network’s loss, rather than by target propagation. That is, _h_[ˆ] _L−_ 1 = _hL−_ 1 _− α[∂] ∂h[L]_[(] _L[h] −[L]_ 1[)][, rather than][ ˆ] _[h][L][−]_[1][=] _[ h][L][−]_[1] _[ −][g]_[(] _[h][L]_[;] _[ λ][L]_[) +] _[ g]_[(ˆ] _[h][L]_[;] _[ λ][L]_[)][.][Though not] stated explicitly, this approach was presumably taken to ensure that the penultimate layer received reasonable and diverse targets despite the low-dimensional 1-hot targets at the output layer. When there are a small number of 1-hot targets (e.g. 10 classes), learning a good inverse mapping from these vectors back to the hidden activity of the penultimate hidden layer (e.g. 1000 units) might be problematic, since the inverse mapping cannot provide information that is both useful and unique to a particular input sample _x_ . Using BP in the penultimate layer sidesteps this concern, but deviates from the intent of using these algorithms to avoid gradient computation and delivery. 

**Simplified difference target propagation** We introduce SDTP as a simple modification to DTP. In SDTP we compute the target for the penultimate layer as _h_[ˆ] _L−_ 1 = _hL−_ 1 _− g_ ( _hL_ ; _λL_ ) + _g_ ( _h_[ˆ] _L_ ; _λL_ ), where _h_[ˆ] _L_ = argmin _hLL_ ( _hL_ ), i.e. the correct label distribution. This completely removes biologically infeasible gradient communication (and hence weight-transport) from the algorithm. However, it is not clear whether targets for the penultimate layer will be diverse enough (given low entropy classification targets) or precise enough (given the inevitable poor performance of the learned inverse for this layer). The latter is particularly important if the dimensionality of the penultimate layer is much larger than the output layer, which is the case for classification problems with a small number of classes. Hence, this modification is a non-trivial change that requires empirical investigation. In Section 3 we evaluate SDTP in the presence of low-entropy targets (classification problems) and also consider the problem of learning an autoencoder (for which targets are naturally high-dimensional and diverse) in the supplementary material. 

**Algorithm 1** Simplified Difference Target Propagation 

|Propagate activity forward:||
|---|---|
|**for**_l_ = 1**to**_L_**do**||
|_hl ←fl_(_hl−_1;_θl_)||
|**end for**||
|Compute frst target: ˆ_hL ←_argmin_hLL_(_hL_)||
|Compute targets for lower layers:||
|**for**_l_ =_L −_1**to**1**do**||
|ˆ_hl ←hl −g_(_hl_+1;_λl_+1) +_g_(ˆ_hl_+1;_λl_+1)||
|**end for**||
|Train inverse function parameters:||
|**for**_l_ =_L_**to**2**do**||
|Generate corrupted activity ˜_hl−_1 =_hl−_1+_ϵ, ϵ ∼N_(0_, σ_2)||
|Update parameters_λl_ using SGD on loss_Linv_<br>_l_|(_λl_)|
|_Linv_<br>_l_<br>(_λl_) =_∥hl−_1_−g_(_f_(˜_hl−_1;_θl−_1);_λl_)_∥_2<br>2||
|**end for**||
|Train feedforward function parameters:||
|**for**_l_ = 1**to**_L_**do**||
|Update parameters_θl_ using SGD on loss_Ll_(_θl_)||
|_Ll_(_θl_) =_∥f_(_hl_;_θl_)_−_ˆ_hl_+1_∥_2<br>2 if_l < L_, else_LL_(_θL_) =_L_(task loss)||
|**end for**||



**Auxiliary output SDTP** As outlined above, in the context of 1-hot classification, SDTP produces only weak targets for the penultimate layer, i.e. one for each possible class label. To circumvent this problem, we extend SDTP by introducing a composite structure for the output layer _hL_ = [ _o, z_ ], where _o_ is the predicted class distribution on which the loss is computed and _z_ is an auxiliary output vector that is meant to provide additional information about activations of the penultimate layer _hL−_ 1. Thus, the inverse computation _g_ ( _hL_ ; _λL_ ) can be performed _conditional on richer information from the input_ , not just on the relatively weak information available in the predicted and actual label. 

5 

The auxiliary output _z_ is used to generate targets for penultimate layer as follows: 

(3) 

**==> picture [184 x 13] intentionally omitted <==**

where _o_ is the predicted class distribution, _o_ ˆ is the correct class distribution and _z_ produced from _hL−_ 1 is used in both inverse computations. Here _gL_ (ˆ _o, z_ ; _λL_ ) can be interpreted as a modification of _hL_ that preserves certain features of the original _hL_ that can also be classified as ˆ _o_ . Here parameters _λL_ can be still learned using the usual inverse loss. But parameters of the forward computation _θL−_ 1 used to produce _z_ are difficult to learn in a way that maximizes their effectiveness for reconstruction without backpropagation. Thus, we studied a variant that does not require backpropagation: we simply do not optimize the forward weights for _z_ , so _z_ is just a set of random features of _hL−_ 1. 

**Parallel and alternating training of inverses** In the original implementation of DTP[1] , the authors trained forward and inverse model parameters by alternating between their optimizations; in practice they trained one loss for one full epoch of the training set before switching to training the other loss. We considered a variant that simply optimizes both losses in parallel, which seems nominally more plausible in the brain since both forward and feedback connections are thought to undergo plasticity changes simultaneously — though it is possible that a kind of alternating learning schedule for forward and backward connections could be tied to wake/sleep cycles. 

## **2.2 Biologically-plausible network architectures** 

Convolution-based architectures have been critical for achieving state of the art in image recognition [18]. These architectures are biologically implausible, however, because of their extensive weight sharing. To implement convolutions in biology, many neurons would need to share the values of their weights precisely — a requirement with no empirical support. In the absence of weight sharing, the “locally connected” receptive field structure of convolutional neural networks is in fact very biologically realistic and may still offer a useful prior. Under this prior, neurons in the brain could sample from small areas of visual space, then pool together to create spatial maps of feature detectors. 

On a computer, sharing the weights of locally connected units greatly reduces the number of free parameters and this has several beneficial effects on simulations of large neural nets. It improves generalization and it drastically reduces both the amount of memory needed to store the parameters and the amount of communication required between replicas of the same model running on different subsets of the data on different processors. From a biological perspective we are interested in how TP and FA compare with BP without using weight sharing, so both our BP results and our TP and FA results are considerably worse than convolutional neural nets and take far longer to produce. We assess the degree to which BP-guided learning is enhanced by convolutions, and not BP _per se_ , by evaluating learning methods (including BP) on networks with locally connected layers. 

## **3 Experiments** 

In this section we experimentally evaluate variants of target propagation, backpropagation, and feedback alignment [23, 25]. We focused our attention on TP variants. We found all of the variants we explored to be quite sensitive to the choice of hyperparameters and network architecture, especially in the case of locally-connected networks. With the aim of understanding the limits of the considered algorithms, we manually searched for architectures well suited to DTP. Then we fixed these architectures for BP and FA variants and ran independent hyperparameter searches for each learning method. Finally, we report best errors achieved in 500 epochs. For additional details see Tables 3 and 4 in the Appendix. 

For optimization we use Adam [15], with different hyper-parameters for forward and inverse models in the case of target propagation. All layers are initialized using the method suggested by Glorot & Bengio [10]. In all networks we used the hyperbolic tangent as a nonlinearity between layers as it was previously found to work better with DTP than ReLUs [21]. 

> 1 `https://github.com/donghyunlee/dtp/blob/master/conti_dtp.py` 

6 

Table 1: Train and test errors (%) achieved by different learning methods for fully-connected (FC) and locally-connected (LC) networks on MNIST and CIFAR. We highlight **best** and **second best** results. 

|(a) MNIST<br>FC<br>LC<br>METHOD<br>TRAIN TEST<br>TRAIN TEST<br>DTP, PARALLEL<br>0.44<br>2.86<br>**0.00**<br>**1.52**<br>DTP, ALTERNATING<br>**0.00**<br>**1.83**<br>**0.00**<br>**1.46**<br>SDTP, PARALLEL<br>1.14<br>3.52<br>0.00<br>1.98<br>SDTP, ALTERNATING<br>0.00<br>2.28<br>0.00<br>1.90<br>AO-SDTP, PARALLEL<br>0.96<br>2.93<br>0.00<br>1.92<br>AO-SDTP, ALTERNATING<br>**0.00**<br>**1.86**<br>0.00<br>1.91<br>FA<br>**0.00**<br>**1.85**<br>**0.00**<br>**1.26**<br>DFA<br>0.85<br>2.75<br>0.23<br>2.05<br>BP<br>**0.00**<br>**1.48**<br>**0.00**<br>**1.17**<br>BP CONVNET<br>–<br>–<br>**0.00**<br>**1.01**|(b) CIFAR|(b) CIFAR|(b) CIFAR|(b) CIFAR|
|---|---|---|---|---|
||FC<br>TRAIN TEST||LC<br>TRAIN TEST||
||59.45 <br>**30.41 **<br>51.48 <br>48.65 <br>4.28<br>0.00<br>**25.62 **<br>33.35 <br>**28.97**<br>–|59.14<br>28.69 <br> **42.32**<br>28.54 <br> 55.32<br>43.00 <br> 54.27<br>40.40 <br>47.11<br>32.67 <br>45.40<br>34.11 <br> **41.97**<br>17.46 <br> 47.80<br>32.74 <br>**41.32**<br>**0.83**<br>–<br>**1.39**||39.47<br> 39.47<br> 46.63<br> 45.66<br> 40.05<br> 40.21<br> 37.44<br> 44.41<br>**32.41**<br>**31.87**|



**==> picture [397 x 120] intentionally omitted <==**

**----- Start of picture text -----**<br>
80 Fully-connected network 60 Locally-connected network<br>70 50<br>60<br>40<br>50<br>30<br>40<br>20<br>30<br>20 10<br>10 0<br>0 100 200 300 400 500 0 100 200 300 400 500<br>Epoch Epoch<br>Error (%) Error (%)<br>**----- End of picture text -----**<br>


Figure 2: Train (dashed) and test (solid) classification errors on CIFAR. 

## **3.1 MNIST** 

To compare to previously reported results we began with the MNIST dataset, consisting of 28 _×_ 28 gray-scale images of hand-drawn digits. The final performance for all algorithms is reported in Table 1 and the learning dynamics are plotted in Figure 8 (see Appendix). Our implementation of DTP matches the performance of the original work [21]. However, all variants of TP performed slightly worse than BP, with a larger gap for SDTP, which does not rely on any gradient propagation. Interestingly, alternating optimization of forward and inverse losses consistently demonstrates more stable learning and better final performance. 

## **3.2 CIFAR-10** 

CIFAR-10 is a more challenging dataset introduced by Krizhevsky [17]. It consists of 32 _×_ 32 RGB images of 10 categories of objects in natural scenes. In contrast to MNIST, classes in CIFAR10 do not have a “canonical appearance” such as a “prototypical bird” or “prototypical truck” as opposed to “prototypical 7” or “prototypical 9”. This makes them harder to classify with simple template matching, making depth imperative for achieving good performance. The only prior study of biologically motivated learning methods applied to this data was carried out by Lee et al. [21]; this investigation was limited to DTP with alternating updates and fully connected architectures. Here we present a more comprehensive evaluation that includes locally-connected architectures and experiments with an augmented training set consisting of vertical flips and random crops applied to the original images. 

Final results can be found in Table 1. Overall, the results on CIFAR-10 are similar to those obtained on MNIST, though the gap between TP and backpropagation as well as between different variants of TP is more prominent. Moreover, while fully-connected DTP-alternating roughly matched the 

7 

performance of BP, locally-connected networks presented an additional challenge for TP, yielding only a minor improvement. 

The issue of compatibility with locally-connected layers is yet to be understood. One possible explanation is that the inverse computation might benefit from a form that is not symmetric to the forward computation. We experimented with more expressive inverses, such as having larger receptive fields or a fully-connected structure, but these did not lead to any significant improvements. We leave further investigation of this question to future work. 

As with MNIST, a BP trained convolutional network with shared weights performed better than its locally-connected variant. The gap, however, is not large, suggesting that weight sharing is not necessary for good performance as long as the learning algorithm is effective. 

We hypothesize that the significant gap in performance between DTP and the gradient-free SDTP on CIFAR-10 is due to the problems with inverting a low-entropy target in the output layer. To validate this hypothesis, we ran AO-SDTP with 512 auxiliary output units and compare its performance with other variants of TP. Even though the observed results do not match the performance of DTP, they still present a large improvement over SDTP. This confirms the importance of target diversity for learning in TP (see Appendix 5.5 for related experiments) and provides reasonable hope that future work in this area could further improve the performance of SDTP. 

Feedback alignment algorithm performed quite well on both MNIST and CIFAR, struggling only with the LC architecture on CIFAR. In contrast, DFA appeared to be quite sensitive to the choice of architecture and our architecture search was guided by the performance of TP methods. Thus, the numbers achieved by DFA in our experiments should be regarded only as a rough approximation of the attainable performance for the algorithm. In particular, DFA appears to struggle with the relatively narrow (256 unit) layers used in the fully-connected MNIST case — see Lillicrap et al. [23] Supplementary Information for a possible explanation. Under these conditions, DFA fails to match BP in performance, and also tends to fall behind DTP and AO-SDTP, especially on CIFAR. 

## **3.3 ImageNet** 

We assessed performance of the methods on the ImageNet dataset [33], a large-scale benchmark that has propelled recent progress in deep learning. To the best of our knowledge, this is the first empirical study of biologically-motivated methods and architectures conducted on a dataset of such scale and difficulty. ImageNet has 1000 object classes appearing in a variety of natural scenes and captured in high-resolution images (resized to 224 _×_ 224). 

Final results are reported in Table 2. Unlike MNIST and CIFAR, on ImageNet all biologically motivated algorithms performed very poorly relative to BP. A number of factors could contribute to this result. One factor may be that deeper networks might require more careful hyperparameter tuning; for example, different learning rates or amounts of noise injected for each layer. 

|0<br>40<br>50<br>60<br>70<br>80<br>90<br>100<br>Error (%)|100<br>200<br>300<br>400<br>500<br>Epoch|Table 2: Test errors on ImageNet.<br>METHOD<br>TOP-1|Table 2: Test errors on ImageNet.<br>METHOD<br>TOP-1|TOP-5|
|---|---|---|---|---|
|||DTP, PARALLEL<br>DTP, ALTERNATING<br>SDTP, PARALLEL<br>FA<br>BACKPROPAGATION<br>BACKPROPAGATION, CONVNET|98.34<br>99.36<br>99.28<br>93.08<br>**71.43**<br>**63.93**|94.56<br>97.28<br>97.15<br>82.54<br>**49.07**<br>**40.17**|
|Fiur|3:To-1(solid)andTo-5(dotted)||||



Figure 3: Top-1 (solid) and Top-5 (dotted) test errors on ImageNet. Color legend is the same as for figure 2. 

A second factor might be a general incompatibility between the mainstream design choices for convolutional networks with TP and FA algorithms. Years of research have led to a better understanding of efficient architectures, weight initialization, and optimizers for convolutional networks trained with backpropagation, and perhaps more effort is required to reach comparable results for biologically motivated algorithms and architectures. Addressing both of these factors could help 

8 

improve performance, so it would be premature to conclude that TP cannot perform adequately on ImageNet. We can conclude though, that out-of-the-box application of this class of algorithms does not provide a straightforward solution to real data on even moderately large networks. 

We note that FA demonstrated an improvement over TP, yet still performed much worse than BP. It was not practically feasible to run its sibling, DFA, on large networks such as one we used in our ImageNet experiments. This was due to practical necessity of maintaining a large fully-connected feedback layer of weights from the output layer to each intermediate layer. Modern convolutional architectures tend to have very large activation dimensions, and the requirement for linear projections back to all of the neurons in the network is practically intractable: on a GPU with 16GB of onboard memory, we encountered out-of-memory errors when trying to initialize and train these networks using a Tensorflow implementation. Thus, the DFA algorithm appears to require either modification or GPUs with more memory to run with large networks. 

## **4 Discussion** 

Historically, there has been significant disagreement about whether BP can tell us anything interesting about learning in the brain [8, 11]. Indeed, from the mid 1990s to 2010, work on applying insights from BP to help understand learning in the brain declined precipitously. Recent progress in machine learning has prompted a revival of this debate; where other approaches have failed, deep networks trained via BP have been key to achieving impressive performance on difficult datasets such as ImageNet. It is once again natural to wonder whether some approximation of BP might underlie learning in the brain [22, 5]. However, none of the algorithms proposed as approximations of BP have been tested on the datasets that were instrumental in convincing the machine learning and neuroscience communities to revisit these questions. 

Here we studied TP and FA, and introduced a straightforward variant of the DTP algorithm that completely removed gradient propagation and weight transport. We demonstrated that networks trained with SDTP without any weight sharing (i.e. weight transport in the backward pass or weight tying in convolutions) perform much worse than DTP, likely because of impoverished output targets. We also studied an approach to rescue performance with SDTP. Overall, while some variants of TP and FA came close to matching the performance of BP on MNIST and CIFAR, all of the biologically motivated algorithms performed much worse than BP in the context of ImageNet. Our experiments are far from exhaustive and we hope that researchers in the field may coordinate to study the performance of other recently introduced biologically motivated algorithms, including e.g. [28, 27]. 

We note that although TP and FA algorithms go a long way towards biological plausibility, there are still many biological constraints that we did not address here. For example, we’ve set aside the question of spiking neurons entirely to focus on asking whether variants of TP can scale up to solve difficult problems _at all_ . The question of spiking networks is an important one [35, 12, 7, 34], but it should nevertheless be possible to gain algorithmic insight to the brain without tackling all of the elements of biological complexity simultaneously. Similarly, we also ignore Dale’s law in all of our experiments [29]. In general, we’ve aimed at the simplest models that allow us to address questions around (1) _weight sharing_ , and (2) _the form and function of feedback communication_ . However, it is worth noting that our work here ignores one other significant issue with respect to the plausibility of feedback communication: BP, FA, all of the TP variants, and indeed most known activation propagation algorithms (for an exception see Sacramento et al. [34]), still require distinct forward and backward (or “positive” and “negative”) _phases_ . The way in which forward and backward pathways in the brain interact is not well characterized, but we’re not aware of existing evidence that straightforwardly supports distinct phases. 

Nevertheless, algorithms that aim to illuminate learning in cortex should be able to perform well on difficult domains without relying on any form of weight sharing. Thus, our results offer a new benchmark for future work looking to evaluate the effectiveness of biologically plausible algorithms in more powerful architectures and on more difficult datasets. 

## **Acknowledgments** 

We would like to thank Shakir Mohamed, Wojtek Czarnecki, Yoshua Bengio, Rafal Bogacz, Walter Senn, Joao Sacramento, James Whittington, and Benjamin Scellier for useful discussions. 

9 

## **References** 

- [1] Ackley, David H, Hinton, Geoffrey E, and Sejnowski, Terrence J. A learning algorithm for boltzmann machines. _Cognitive science_ , 9(1):147–169, 1985. 

- [2] Almeida, Luis B. A learning rule for asynchronous perceptrons with feedback in a combinatorial environment. In _Artificial neural networks_ , pp. 102–111. IEEE Press, 1990. 

- [3] Bengio, Yoshua. How auto-encoders could provide credit assignment in deep networks via target propagation. _arXiv preprint arXiv:1407.7906_ , 2014. 

- [4] Bengio, Yoshua and Fischer, Asja. Early inference in energy-based models approximates back-propagation. _arXiv preprint arXiv:1510.02777_ , 2015. 

- [5] Bengio, Yoshua, Lee, Dong-Hyun, Bornschein, Jorg, Mesnard, Thomas, and Lin, Zhouhan. Towards biologically plausible deep learning. _arXiv preprint arXiv:1502.04156_ , 2015. 

- [6] Bengio, Yoshua, Scellier, Benjamin, Bilaniuk, Olexa, Sacramento, Joao, and Senn, Walter. Feedforward initialization for fast inference of deep generative networks is biologically plausible. _arXiv preprint arXiv:1606.01651_ , 2016. 

- [7] Bengio, Yoshua, Mesnard, Thomas, Fischer, Asja, Zhang, Saizheng, and Wu, Yuhuai. Stdpcompatible approximation of backpropagation in an energy-based model. _Neural computation_ , 2017. 

- [8] Crick, Francis. The recent excitement about neural networks. _Nature_ , 337(6203):129–132, 1989. 

- [9] Dumoulin, Vincent and Visin, Francesco. A guide to convolution arithmetic for deep learning. _arXiv preprint arXiv:1603.07285_ , 2016. 

- [10] Glorot, Xavier and Bengio, Yoshua. Understanding the difficulty of training deep feedforward neural networks. In _Proceedings of the Thirteenth International Conference on Artificial Intelligence and Statistics_ , pp. 249–256, 2010. 

- [11] Grossberg, Stephen. Competitive learning: From interactive activation to adaptive resonance. _Cognitive science_ , 11(1):23–63, 1987. 

- [12] Guerguiev, Jordan, Lillicrap, Timothy P, and Richards, Blake A. Towards deep learning with segregated dendrites. _ELife_ , 6:e22901, 2017. 

- [13] Hinton, G.E. How to do backpropagation in a brain. _NIPS 2007 Deep Learning Workshop_ , 2007. 

- [14] Hinton, Geoffrey E and McClelland, James L. Learning representations by recirculation. In _Neural information processing systems_ , pp. 358–366. New York: American Institute of Physics, 1988. 

- [15] Kingma, Diederik and Ba, Jimmy. Adam: A method for stochastic optimization. _arXiv preprint arXiv:1412.6980_ , 2014. 

- [16] Kording, Konrad P and K¨ onig, Peter.¨ Supervised and unsupervised learning with two sites of synaptic integration. _Journal of computational neuroscience_ , 11(3):207–215, 2001. 

- [17] Krizhevsky, Alex. Learning multiple layers of features from tiny images. 2009. 

- [18] Krizhevsky, Alex, Sutskever, Ilya, and Hinton, Geoffrey E. Imagenet classification with deep convolutional neural networks. In _Advances in neural information processing systems_ , pp. 1097–1105, 2012. 

- [19] LeCun, Yann. Learning process in an asymmetric threshold network. In _Disordered systems and biological organization_ , pp. 233–240. Springer, 1986. 

- _`_ 

- [20] LeCun, Yann. _Modeles connexionnistes de lapprentissage_ . PhD thesis, PhD thesis, These de Doctorat, Universit´e Paris 6, 1987. 

10 

- [21] Lee, Dong-Hyun, Zhang, Saizheng, Fischer, Asja, and Bengio, Yoshua. Difference target propagation. In _Joint European Conference on Machine Learning and Knowledge Discovery in Databases_ , pp. 498–515. Springer, 2015. 

- [22] Lillicrap, Timothy P, Cownden, Daniel, Tweed, Douglas B, and Akerman, Colin J. Random feedback weights support learning in deep neural networks. _arXiv preprint arXiv:1411.0247_ , 2014. 

- [23] Lillicrap, Timothy P, Cownden, Daniel, Tweed, Douglas B, and Akerman, Colin J. Random synaptic feedback weights support error backpropagation for deep learning. _Nature Communications_ , 7, 2016. 

- [24] Movellan, Javier R. Contrastive hebbian learning in the continuous hopfield model. In _Connectionist models: Proceedings of the 1990 summer school_ , pp. 10–17, 1991. 

- [25] Nøkland, Arild. Direct feedback alignment provides learning in deep neural networks. In _Advances In Neural Information Processing Systems_ , pp. 1037–1045, 2016. 

- [26] O’Reilly, Randall C. Biologically plausible error-driven learning using local activation differences: The generalized recirculation algorithm. _Neural computation_ , 8(5):895–938, 1996. 

- [27] Ororbia, Alexander G and Mali, Ankur. Biologically motivated algorithms for propagating local target representations. _arXiv preprint arXiv:1805.11703_ , 2018. 

- [28] Ororbia, Alexander G, Mali, Ankur, Kifer, Daniel, and Giles, C Lee. Conducting credit assignment by aligning local representations. _arXiv preprint arXiv:1803.01834_ , 2018. 

- [29] Parisien, Christopher, Anderson, Charles H, and Eliasmith, Chris. Solving the problem of negative synaptic weights in cortical models. _Neural computation_ , 20(6):1473–1494, 2008. 

- [30] Pineda, Fernando J. Generalization of back-propagation to recurrent neural networks. _Physical review letters_ , 59(19):2229, 1987. 

- [31] Pineda, Fernando J. Dynamics and architecture for neural computation. _Journal of Complexity_ , 4(3):216–245, 1988. 

- [32] Rumelhart, DE, Hinton, GE, and Williams, RJ. Learning representations by back-propagation errors. _Nature_ , 323:533–536, 1986. 

- [33] Russakovsky, Olga, Deng, Jia, Su, Hao, Krause, Jonathan, Satheesh, Sanjeev, Ma, Sean, Huang, Zhiheng, Karpathy, Andrej, Khosla, Aditya, Bernstein, Michael, Berg, Alexander C., and Fei-Fei, Li. ImageNet Large Scale Visual Recognition Challenge. _International Journal of Computer Vision (IJCV)_ , 115(3):211–252, 2015. doi: 10.1007/s11263-015-0816-y. 

- [34] Sacramento, Joao, Costa, Rui Ponte, Bengio, Yoshua, and Senn, Walter. Dendritic error backpropagation in deep cortical microcircuits. _arXiv preprint arXiv:1801.00062_ , 2017. 

- [35] Samadi, Arash, Lillicrap, Timothy P, and Tweed, Douglas B. Deep learning with dynamic spiking neurons and fixed feedback weights. _Neural computation_ , 2017. 

- [36] Scellier, Benjamin and Bengio, Yoshua. Equilibrium propagation: Bridging the gap between energy-based models and backpropagation. _Frontiers in computational neuroscience_ , 11, 2017. 

- [37] Springenberg, Jost Tobias, Dosovitskiy, Alexey, Brox, Thomas, and Riedmiller, Martin. Striving for simplicity: The all convolutional net. _arXiv preprint arXiv:1412.6806_ , 2014. 

- [38] Whittington, James CR and Bogacz, Rafal. An approximation of the error backpropagation algorithm in a predictive coding network with local hebbian synaptic plasticity. _Neural computation_ , 2017. 

- [39] Xie, Xiaohui and Seung, H Sebastian. Equivalence of backpropagation and contrastive hebbian learning in a layered network. _Neural computation_ , 15(2):441–454, 2003. 

11 

## **5 Appendix** 

## **5.1 SDTP and AO-SDTP algorithm details** 

In this section, we provide detailed algorithm description for both SDTP and its extension AO-SDTP which can be found in Algorithm Box 1 and 2. 

In the original DTP algorithm, autoencoder training is done via a noise-preserving loss. This is a well principled choice for the algorithm on a computer [21], and our experiments with DTP use this noise-preserving loss. However, in the brain, autoencoder training would necessarily be de-noising, since uncontrolled noise is added downstream of a given layer (e.g. by subsequent spiking activity and stochastic vesicle release). Therefore, in our experiments with SDTP and AO-SDTP we use de-noising autoencoder training. 

**Algorithm 2** Augmented Output Simplified Difference Target Propagation 

Propagate activity forward: **for** _l_ = 1 **to** _L_ **do** _hl ← fl_ ( _hl−_ 1; _θl_ ) **end for** Compute first target:Split network output: _o_ ˆ[ _←o, z_ ]argmin _← hLoL_ ( _o_ ) Compute target for the penultimate layer: _h_[ˆ] _L−_ 1 _← hL−_ 1 _− gL_ ( _o, z_ ; _λL_ ) + _gL_ (ˆ _o, z_ ; _λL_ ) Compute targets for lower layers: **for** _h_ ˆ _ll_ = _← Lh −l −_ 2 **to** _g_ ( _h_ 1 _l_ +1 **do** ; _λl_ +1) + _g_ (ˆ _hl_ +1; _λl_ +1) **end for** Train inverse function parameters: **for** _l_ = _L_ **to** 2 **do** Generate corrupted activity _h_[˜] _l−_ 1 = _hl−_ 1 + _ϵ, ϵ ∼N_ (0 _, σ_[2] ) Update parameters _λl_ using SGD on loss _L[inv] l_ ( _λl_ ) _L[inv] l_ ( _λl_ ) = _∥hl−_ 1 _− g_ ( _f_ ( _h_[˜] _l−_ 1; _θl−_ 1); _λl_ ) _∥_ 2[2] **end for** Train feedforward function parameters: **for** _l_ = 1 **to** _L_ **do** Update parameters _θl_ using SGD on loss _Ll_ ( _θl_ ) _Ll_ ( _θl_ ) = _∥f_ ( _hl_ ; _θl_ ) _− h_[ˆ] _l_ +1 _∥_ 2[2][if] _[ l][< L]_[, else] _[ L] L_[(] _[θ] L_[) =] _[ L]_[ (task loss)] **end for** 

One might expect the performance of AO-SDTP to depend on the size and the structure of the auxiliary output. We investigated the effect of the auxiliary output size. The results are consistent with the intuition that larger sizes generally lead to better performance, with improvements leveling off once the output is large enough to encode information about the penultimate layer well (see Figure 4). 

## **5.2 Architecture details for all experiments** 

In this section we provide details on the architectures used across all experiments. The detailed specifications can be found in Table 3. 

All locally-connected architectures consist of a stack of locally-connected layers (each specified by: receptive field size, number of output channels, stride), followed by one or more fully-connected layers and an output softmax layer. All locally-connected layers use zero padding to ensure unchanged shape of the output with stride = 1. One of our general empirical findings was that pooling operations are not very compatible with TP and are better to be replaced with strided locally-connected layers. 

The locally-connected architecture used for the ImageNet experiment was inspired by the ImageNet architecture used in [37]. Unfortunately, the naive replacement of convolutional layers with locallyconnected layers would result in a computationally-prohibitive architecture, so we decreased number of output channels in the layers and also removed layers with 1 _×_ 1 filters. We also slightly decreased filters in the first layer, from 11 _×_ 11 to 9 _×_ 9. Finally, as in the CIFAR experiments, we replaced 

12 

Table 3: Architecture specification. The format for locally-connected layers is (kernel size, number of output channels, stride). 

|DATASET|FULLY-CONNECTED NETWORK|LOCALLY-CONNECTED NETWORK|
|---|---|---|
||||
|MNIST|FC 256<br>FC 256<br>FC 256<br>FC 256<br>FC 256<br>Softmax 10|(3_×_3, 32, 2)<br>(3_×_3, 64, 2)<br>FC 1024<br>Softmax 10|
||||
|CIFAR|FC 1024<br>FC 1024<br>FC 1024<br>Softmax 10|(5_×_5, 64, 2)<br>(5_×_5, 128, 2)<br>(3_×_3, 256)<br>FC 1024<br>Softmax 10|
|IMAGENET<br>–<br>(9_×_9, 48, 4)<br>(3_×_3, 48, 2)<br>(5_×_5, 96, 1)<br>(3_×_3, 96, 2)<br>(3_×_3, 192, 1)<br>(3_×_3, 192, 2)<br>(3_×_3, 384, 1)<br>Softmax 1000|||



all pooling operations with strided locally-connected layers and completely removed the spatial averaging in the last layer that we previously found problematic when learning with TP. 

## **5.3 Details of hyperparameter optimization** 

For DTP and SDTP we optimized over parameters of: (1) the forward model and inverse Adam optimizers, (2) the learning rate _α_ used to compute targets for _hL−_ 1 in DTP, and (3) the Gaussian noise magnitude _σ_ used to train inverses. For backprop we optimized only the forward model Adam optimizer parameters. For all experiments the best hyperparameters were found by random searches over 60 random configurations drawn from the ranges specified in table 4. We provide values for the best configurations in table 5. 

As we pointed out in section 3, the explored learning methods have different sensitivity to hyperparameters. We provide histograms of the best test accuracies reached by different hyperparameter configurations on MNIST and CIFAR for each of the experiments (see Figure 5). We were not able 

**==> picture [238 x 169] intentionally omitted <==**

**----- Start of picture text -----**<br>
60<br>55<br>50<br>LC<br>FC<br>45<br>40<br>0 200 400 600 800 1000<br>Auxiliary output size<br>Test error<br>**----- End of picture text -----**<br>


Figure 4: Auxiliary output size effect on CIFAR performance. 

13 

**==> picture [396 x 517] intentionally omitted <==**

**----- Start of picture text -----**<br>
DTP parallel DTP alternating DTP parallel DTP alternating<br>0.8 0.8<br>0.6 0.6<br>0.4 0.4<br>0.2 0.2<br>0.0 0.0<br>SDTP parallel SDTP alternating SDTP parallel SDTP alternating<br>0.8 0.8<br>0.6 0.6<br>0.4 0.4<br>0.2 0.2<br>0.0 0.0<br>Backpropagation BP BP convnet<br>0.8 0.8<br>0.6 0.6<br>0.4 0.4<br>0.2 0.2<br>0.0 0.0<br>FA DFA FA DFA<br>0.8 0.8<br>0.6 0.6<br>0.4 0.4<br>0.2 0.2<br>0.0 0.0<br>0.0 0.2 0.4 0.6 0.8 1.0 0.0 0.2 0.4 0.6 0.8 1.0 0.0 0.2 0.4 0.6 0.8 1.0 0.0 0.2 0.4 0.6 0.8 1.0<br>(a) MNIST, fully-connected networks. (b) MNIST, locally-connected networks.<br>DTP parallel DTP alternating DTP parallel DTP alternating<br>0.8 0.8<br>0.6 0.6<br>0.4 0.4<br>0.2 0.2<br>0.0 0.0<br>SDTP parallel SDTP alternating SDTP parallel SDTP alternating<br>0.8 0.8<br>0.6 0.6<br>0.4 0.4<br>0.2 0.2<br>0.0 0.0<br>Backpropagation BP BP ConvNet<br>0.8 0.8<br>0.6 0.6<br>0.4 0.4<br>0.2 0.2<br>0.0 0.0<br>FA DFA FA DFA<br>0.8 0.8<br>0.6 0.6<br>0.4 0.4<br>0.2 0.2<br>0.0 0.0<br>0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.0 0.1 0.2 0.3 0.4 0.5 0.6<br>(c) CIFAR, fully-connected networks. (d) CIFAR, locally-connected networks.<br>**----- End of picture text -----**<br>


Figure 5: Distribution of test accuracies achieved under different hyperparameters. 

14 

Table 4: Hyperparameter search space used for the experiments 

|HYPERPARAMETER|SEARCH DOMAIN|
|---|---|
|||
|Learning rate of model Adam optimizer<br>_β_1parameter of model Adam optimizer<br>_β_2parameter of model Adam optimizer<br>_ϵ_parameter of model Adam optimizer|[10_−_5; 3_×_10_−_4]<br>Fixed to 0.9<br>_{_0_._99_,_0_._999_}_<br>_{_10_−_4_,_10_−_6_,_10_−_8_}_|
|||
|Learning rate of inverse Adam optimizer<br>_β_1parameter of inverse Adam optimizer<br>_β_2parameter of inverse Adam optimizer<br>_ϵ_parameter of inverse Adam optimizer|[10_−_5; 3_×_10_−_4]<br>Fixed to 0.9<br>_{_0_._99_,_0_._999_}_<br>_{_10_−_4_,_10_−_6_,_10_−_8_}_|
|Learning rate_α_used to compute targets for_hL−_1in DTP<br>[0_._01; 0_._2]<br>Gaussian noise magnitude_σ_used to train inverses<br>[0_._01; 0_._3]||



to collect the results for each of the exploratory runs on the ImageNet due to prohibitive demand on computation. In this case, we also started 60 random configurations but after 10 epochs we allowed only the best performing job to continue thereafter. 

These experiments demonstrate clearly that BP is the most stable algorithm. TP methods proved to be the most sensitive to the choice of hyperparameters, likely due to complicated interactions between updating forward and inverse weights. Finally, we note that within the TP based method, the alternating update schedule not only reach the better accuracy, but overall led to more stable convergence. 

## **5.4 Implementation details for locally-connected architectures** 

Although locally-connected layers can be seen as a simple generalization of convolution layers, their implementation is not entirely straightforward. First, a locally-connected layer has many more trainable parameters than a convolutional layer with an equivalent specification (i.e. receptive field size, stride and number of output channels). This means that a simple replacement of every convolutional layer with a locally-connected layer can be computationally prohibitive for larger networks. Thus, for large networks, one has to decrease the number of parameters to run experiments using a reasonable amount of memory and compute. In our experiments we opted to decrease the number of output channels in each layer by a given factor. Obviously, this can have a negative effect on the resulting performance and more work needs to be done to scale locally-connected architectures. 

**Inverse operations** When training locally-connected layers with target propagation, one also needs to implement the inverse computation in order to train the feedback weights. As in fully-connected layers, the forward computation implemented by both locally-connected and convolutional layers can be seen as a linear transformation _y_ = _Wx_ + _b_ , where the matrix _W_ has a special, sparse structure (i.e., has a block of non-zero elements, and zero-elements elsewhere), and the dimensionality of _y_ is not more than _x_ . 

The inverse operation requires computation of the form _x_ = _V y_ + _c_ , where matrix _V_ has the same sparse structure as _W[T]_ . However, given the sparsity of _V_ , computing the inverse of _y_ using _V_ would be highly inefficient [9]. We instead use an implementation trick often applied in deconvolutional architectures. First, we instantiate a forward locally-connected computation _z_ = _Ax_ , where _z_ and _A_ are dummy activities and sparse weights. We then express the transposed weight matrix as the _gradient_ of this feedforward operation: 

**==> picture [250 x 27] intentionally omitted <==**

The gradient _dx[dz]_[(and][its][multiplication][with] _[y]_[)][can][be][very][quickly][computed][by][the][means][of] automatic differentiation in many popular deep learning frameworks. Hence one only needs to define the forward locally-connected computation and the corresponding transposed operation is implemented trivially. Note that this is strictly an implementation detail and does not introduce any additional use of gradients or weight sharing in learning. 

15 

Table 5: Best hyperparameters found by the random search. 

MNIST, FULLY-CONNECTED 

||MNIST,FULLY-CONNECTED|
|---|---|
||DTP<br>PARALLEL<br>DTP<br>ALTERNATING<br>SDTP<br>PARALLEL<br>SDTP<br>ALTERNATING<br>BP<br>BP<br>ConvNet<br>FA<br>DFA|
|||
|MODEL<br>LR<br>_β_1<br>_β_2<br>_ϵ_|0.000757<br>0.000308<br>0.000402<br>0.000301<br>0.000152<br>0.000168<br>0.001649<br>0.99<br>0.99<br>0.99<br>0.9<br>0.9<br>0.9<br>0.9<br>0.95<br>0.99<br>0.999<br>0.95<br>0.999<br>0.999<br>0.95<br>10_−_3<br>10_−_4<br>10_−_8<br>10_−_4<br>10_−_8<br>10_−_4<br>10_−_3|
|||
|INVERSE<br>LR<br>_β_1<br>_β_2<br>_ϵ_|0.000768<br>0.004593<br>0.001101<br>0.009572<br>0.99<br>0.99<br>0.99<br>0.9<br>0.999<br>0.999<br>0.95<br>0.95<br>10_−_4<br>10_−_4<br>10_−_6<br>10_−_3|
|||
|_α_<br>_σ_|0.15008<br>0.231758<br>0.36133<br>0.220444<br>0.213995<br>0.118267|
|MNIST,LOCALLY-CONNECTED||
|||
|MODEL<br>LR<br>_β_1<br>_β_2<br>_ϵ_|0.000905<br>0.001481<br>0.000145<br>0.000651<br>0.000133<br>0.000297<br>0.000219<br>0.002462<br>0.9<br>0.9<br>0.9<br>0.9<br>0.9<br>0.9<br>0.9<br>0.9<br>0.99<br>0.99<br>0.99<br>0.99<br>0.99<br>0.99<br>0.999<br>0.99<br>10_−_4<br>10_−_4<br>10_−_6<br>10_−_4<br>10_−_8<br>10_−_8<br>10_−_6<br>10_−_4|
|||
|INVERSE<br>LR<br>_β_1<br>_β_2<br>_ϵ_|0.001239<br>0.000137<br>0.001652<br>0.003741<br>0.9<br>0.9<br>0.9<br>0.9<br>0.999<br>0.999<br>0.999<br>0.99<br>10_−_4<br>10_−_6<br>10_−_4<br>10_−_4|
|||
|_α_<br>_σ_|0.116131<br>0.310892<br>0.099236<br>0.366964<br>0.061555<br>0.134739|
|CIFAR,FULLY-CONNECTED||
|||
|MODEL<br>LR<br>_β_1<br>_β_2<br>_ϵ_|0.000012<br>0.000013<br>0.000129<br>0.000041<br>0.000019<br>0.000025<br>0.000050<br>0.9<br>0.9<br>0.9<br>0.9<br>0.9<br>0.9<br>0.9<br>0.999<br>0.999<br>0.99<br>0.99<br>0.999<br>0.99<br>0.99<br>10_−_8<br>10_−_8<br>10_−_6<br>10_−_4<br>10_−_6<br>10_−_4<br>10_−_8|
|||
|INVERSE<br>LR<br>_β_1<br>_β_2<br>_ϵ_|0.000039<br>0.000114<br>0.000011<br>0.000014<br>0.9<br>0.9<br>0.9<br>0.9<br>0.99<br>0.99<br>0.99<br>0.99<br>10_−_6<br>10_−_4<br>10_−_6<br>10_−_8|
|||
|_α_<br>_σ_|0.125693<br>0.172085<br>0.169783<br>0.134811<br>0.273341<br>0.125678|
|CIFAR,LOCALLY-CONNECTED||
|||
|MODEL<br>LR<br>_β_1<br>_β_2<br>_ϵ_|0.000032<br>0.000036<br>0.000020<br>0.000109<br>0.000044<br>0.000133<br>0.000022<br>0.000040<br>0.9<br>0.9<br>0.9<br>0.9<br>0.9<br>0.9<br>0.9<br>0.9<br>0.99<br>0.99<br>0.99<br>0.99<br>0.999<br>0.99<br>0.999<br>0.999<br>10_−_6<br>10_−_8<br>10_−_4<br>10_−_4<br>10_−_6<br>10_−_4<br>10_−_8<br>10_−_8|
|||
|INVERSE<br>LR<br>_β_1<br>_β_2<br>_ϵ_|0.000852<br>0.000389<br>0.000261<br>1.1e-05<br>0.9<br>0.9<br>0.9<br>0.9<br>0.999<br>0.999<br>0.999<br>0.99<br>10_−_4<br>10_−_8<br>10_−_6<br>10_−_8|
|||
|_α_<br>_σ_|0.189828<br>0.208141<br>0.146728<br>0.094869<br>0.299769<br>0.023804|



## IMAGENET, LOCALLY-CONNECTED 

||IMAGENET,LOCALLY-CONNECTED|
|---|---|
||DTP<br>PARALLEL<br>DTP<br>ALTERNATING<br>SDTP<br>PARALLEL<br>BP<br>BP<br>ConvNet<br>FA|
|||
|MODEL<br>LR<br>_β_1<br>_β_2<br>_ϵ_|0.000217<br>0.000101<br>0.000011<br>0.000024<br>0.000049<br>0.000043<br>0.9<br>0.9<br>0.9<br>0.9<br>0.9<br>0.9<br>0.99<br>0.99<br>0.999<br>0.999<br>0.99<br>0.99<br>10_−_6<br>10_−_8<br>10_−_6<br>10_−_8<br>10_−_8<br>10_−_4|
|||
|INVERSE<br>LR<br>_β_1<br>_β_2<br>_ϵ_|0.000234<br>0.000064<br>0.000170<br>0.9<br>0.9<br>0.9<br>0.999<br>0.999<br>0.999<br>10_−_6<br>10_−_8<br>10_−_8|
|||
|_α_<br>_σ_|0.163359<br>0.03706<br>0.192835<br>0.097217<br>0.168522|



16 

**==> picture [288 x 201] intentionally omitted <==**

**----- Start of picture text -----**<br>
0.020<br>0.015<br>DTP parallel<br>SDTP parallel<br>BP<br>0.010<br>0.005<br>0 100 200 300 400 500<br>Epoch<br>Reconstruction error<br>**----- End of picture text -----**<br>


Figure 6: Train (solid) and test (dashed) reconstruction errors on MNIST. 

**==> picture [380 x 61] intentionally omitted <==**

**----- Start of picture text -----**<br>
SDTP parallel DTP parallel BP<br>Q@2 2422 2 A244 2 2<br>Z2A&EF2 #+2zeE2R2 +<br>Original Original Original<br>Reconstruction Reconstruction Reconstruction<br>**----- End of picture text -----**<br>


Figure 7: MNIST reconstructions obtained by different learning methods. Even though SDTP produces more artifacts, the visual quality is comparable due to the presence of diverse targets. 

## **5.5 Autoencoding and target diversity** 

Since one of the main limitations of SDTP is target diversity for the penultimate layer, it may be instructive to compare different learning methods on a task that involves rich output targets. A natural choice for such a task is learning an autoencoder with the reconstruction error as a loss. 

We set a simple fully-connected architecture for the autoencoder of the following structure 28 _×_ 28 _−_ 512 _−_ 64 _−_ 512 _−_ 28 _×_ 28 and trained it on MNIST using squared _L_ 2 reconstruction error. The training curves can be found in Figure 6. SDTP still demonstrated a tendency to underfit, and did not match performance of DTP and backpropagation. But, visual inspection of reconstructions on the test set of MNIST did not show a significant difference in the quality of reconstructions (see Figure 7), which supports the hypothesized importance of target diversity for SDTP performance. 

17 

**==> picture [397 x 122] intentionally omitted <==**

**----- Start of picture text -----**<br>
5 Fully-connected network 3.5 Locally-connected network<br>4 3.0<br>2.5<br>3<br>2.0<br>2 1.5<br>1.0<br>1<br>0.5<br>0 0.0<br>0 50 100 150 200 250 300 0 50 100 150 200 250 300<br>Epoch Epoch<br>Error (%) Error (%)<br>**----- End of picture text -----**<br>


Figure 8: Train (dashed) and test (solid) classification errors on MNIST. 

## **5.6 Backpropagation as a special case of target propagation** 

Even though difference target propagation is often contrasted with back-propagation, it is interesting to note that these procedures have a similar functional form. One can ask the following question: that should the targets be in order to make minimization of the learning loss equivalent to a backpropagation update? 

Formally, we want to solve the following equation for _h_[ˆ] _l_ : 

**==> picture [65 x 23] intentionally omitted <==**

Here we divided the learning loss by 2 to simplify the following calculations. Transforming both sides of the equation, we obtain 

**==> picture [105 x 23] intentionally omitted <==**

from which it follows that 

**==> picture [147 x 23] intentionally omitted <==**

We now expand the latter equation to express _h_[ˆ] _l_ through _h_[ˆ] _l_ +1: 

**==> picture [218 x 24] intentionally omitted <==**

Finally, if we define _g_ ( _h_[˜] _l_ +1) = _gbp_ ( _h_[˜] _l_ +1) = _[dh] dh[l]_[+] _l_[1] _[h]_[˜] _[l]_[+1][, then a step on the local learning loss in TP] will be equivalent to a gradient descent step on the global loss. 

The question remains whether this connection might be useful for helping us to think about new learning algorithms. For example, one could imagine an algorithm that uses hybrid targets, e.g. computed using a convex combination of the differential and the pseudo-inverse _g_ -functions: 

**==> picture [234 x 13] intentionally omitted <==**

Continuing the analogy between these two methods, is it possible that the inverse loss could be a useful regularizer when used with _gbp_ ? Practically that would mean that we want to regularize parameters of the forward computation _f_ indirectly through its derivatives. Interestingly, in the one-dimensional case (where _hl_ and _f_ ( _hl_ ) are scalars) the inverse loss is minimized by _f_ ( _hl_ ) = _±_ � _h_[2] _l_[+] _[ b]_[.] 

18 

