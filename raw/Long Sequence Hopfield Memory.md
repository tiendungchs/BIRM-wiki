# **Long Sequence Hopfield Memory** 

**Hamza Tahir Chaudhry**[1] _[,]_[2] **, Jacob A. Zavatone-Veth**[2] _[,]_[3] **, Dmitry Krotov**[5] , **Cengiz Pehlevan**[1] _[,]_[2] _[,]_[4] 

1John A. Paulson School of Engineering and Applied Sciences, 

2Center for Brain Science, 3Department of Physics, 

4Kempner Institute for the Study of Natural and Artificial Intelligence, Harvard University Cambridge, MA 02138 

5MIT-IBM Watson AI Lab, IBM Research, Cambridge, MA 02142 `hchaudhry@g.harvard.edu` , `jzavatoneveth@g.harvard.edu` , `krotov@ibm.com` , `cpehlevan@seas.harvard.edu` 

## **Abstract** 

Sequence memory is an essential attribute of natural and artificial intelligence that enables agents to encode, store, and retrieve complex sequences of stimuli and actions. Computational models of sequence memory have been proposed where recurrent Hopfield-like neural networks are trained with temporally asymmetric Hebbian rules. However, these networks suffer from limited sequence capacity (maximal length of the stored sequence) due to interference between the memories. Inspired by recent work on Dense Associative Memories, we expand the sequence capacity of these models by introducing a nonlinear interaction term, enhancing separation between the patterns. We derive novel scaling laws for sequence capacity with respect to network size, significantly outperforming existing scaling laws for models based on traditional Hopfield networks, and verify these theoretical results with numerical simulation. Moreover, we introduce a generalized pseudoinverse rule to recall sequences of highly correlated patterns. Finally, we extend this model to store sequences with variable timing between states’ transitions and describe a biologically-plausible implementation, with connections to motor neuroscience. 

## **1 Introduction** 

Memory is an essential ability of intelligent agents that allows them to encode, store, and retrieve information and behaviors they have learned throughout their lives. In particular, the ability to recall sequences of memories is necessary for a large number of cognitive tasks with temporal or causal structure, including navigation, reasoning, and motor control [1–9]. 

Computational models with varying degrees of biological plausibility have been proposed for how neural networks can encode sequence memory [1–3, 10–22]. Many of these are based on the concept of associative memory, also known as content-addressable memory, which refers to the ability of a system to recall a set of objects or ideas when prompted by a distortion or subset of them. Modeling associative memory has been an extremely active area of research in computational neuroscience and deep learning for many years, with the Hopfield network becoming the canonical model [23–25]. 

Unfortunately, a major limitation of the traditional Hopfield Network and related associative memory models is its capacity: the number of memories it can store and reliably retrieve scales linearly with the number of neurons in the network. This limitation is due to interference between different memories during recall, also known as crosstalk, which decreases the signal-to-noise ratio. Large amounts of crosstalk results in the recall of undesired attractor states of the network [26–29]. 

37th Conference on Neural Information Processing Systems (NeurIPS 2023). 

**==> picture [396 x 99] intentionally omitted <==**

**----- Start of picture text -----**<br>
A 1.0 SeqNet B 1.0 Polynomial DenseNet 100<br>90<br>0.8 0.8 80<br>70<br>0.6 0.6<br>60<br>0.4 0.4 50<br>40<br>0.2 0.2<br>30<br>0.0 0.0 20<br>10<br>−0.2 −0.2 1<br>0 10 20 30 40 50 60 70 80 90 100 0 10 20 30 40 50 60 70 80 90 100<br>Time Step (t) Time Step (t)<br> μ)  μ)  μ)<br>Pattern (ξ<br>Overlap (m Overlap (m<br>**----- End of picture text -----**<br>


Figure 1: `SeqNet` and Polynomial `DenseNet` ( _d_ = 2) are simulated with _N_ = 300 neurons and _P_ = 100 patterns. One hundred curves are plotted as a function of time, each representing the overlap _N_ of the network state at time _t_ with one of the patterns, _m[µ]_ = (1 _/N_ ) _i_ =1 _[ξ] i[µ][S][i]_[.][The curves are] ordered using the color code described on the right (patterns in the beginning and end of the sequence are shaded in yellow and red respectively). **A** . `SeqNet` quickly loses the correct sequence, indicated by the lack of alignment of the network state with the correct pattern in the sequence ( _m[µ] ≪_ 1). **B** . The Polynomial `DenseNet` faithfully recalls the entire sequence and maintains alignment with one of the patterns at any moment in time, _m[µ] ≈_ 1. 

Recent modifications of the Hopfield Network, known as Dense Associative Memories or Modern Hopfield Networks (MHNs), overcome this limitation by introducing a strong nonlinearity when computing the overlap between the state of the network and memory patterns stored in the network [30, 31]. This leads to greater separation between partially overlapping memories, thereby reducing crosstalk, increasing the signal-to-noise ratio, and increasing the probability of successful recall [32]. 

Most models based on the Hopfield Network are autoassocative, meaning they are designed for the robust storage and recall of individual memories. Thus, they are incapable of storing sequences of memories. In order to adapt these models to store sequences, one must utilize asymmetric weights in order to drive the network from one activity pattern to the next. Many such models use temporally asymmetric Hebbian learning rules to strengthen synaptic connections between neural activity at one time state and the next time state, thereby learning temporal association between patterns in a sequence [1, 3, 10, 11, 16, 17, 22]. 

In this paper, we extend Dense Associative Memories to the setting of asymmetric weights in order to store and recall long sequences of memories. We work directly with the update rule for the state of the network, allowing us to provide an analytical derivation for the sequence capacity of our proposed network. We find a close match between theoretical calculation and numerical simulation, and further establish the ability of this model to store and recall sequences of correlated patterns. Additionally, we examine the dynamics of a model containing both symmetric and asymmetric terms. Finally, we describe applications of our network as a model of biological motor control. 

## **2** `DenseNet` **s for Sequence Storage** 

Traditional Hopfield Networks and MHNs, as described in Appendix B, are capable of storing individual memories. What about storing sequences? Assume that we want to store a sequence of _P_ patterns, _**ξ**_[1] _→_ _**ξ**_[2] _→· · · →_ _**ξ**[P]_ , where _ξj[µ][∈{±]_[1] _[}]_[ is the] _[ j][th]_[neuron of the] _[ µ][th]_[pattern and the] network will transition from pattern _**ξ**[µ]_ to _**ξ**[µ]_[+1] . Let _N_ be the number of neurons in the network and **S** ( _t_ ) _∈{−_ 1 _,_ +1 _}[N]_ be the state of the network at time _t_ . We want to design a network with dynamics such that when the network is initialized in pattern _**ξ**_[1] , it will traverse the entire sequence.[1] We define a network, `SeqNet` , which follows a discrete-time synchronous update rule[2] : 

**==> picture [367 x 37] intentionally omitted <==**

> 1We impose periodic boundary conditions and define _**ξ** P_ +1 _≡_ _**ξ**_ 1. Boundary terms have a sub-leading contribution to the crosstalk, so a model with open boundary conditions will have the same scaling of capacity. 2One can also consider an asynchronous update rule in which one neuron is updated at a time [23, 26]. 

2 

_P_ where **S** ( _t_ + 1) = _TSN_ ( **S** ) and _Jij_ = _N_[1] � _µ_ =1 _[ξ] i[µ]_[+1] _ξj[µ]_[is an asymmetric matrix connecting pattern] _ξ[µ]_ to _ξ[µ]_[+1] . Note that we are excluding self-interaction terms _i_ = _j_ . We also rewrote the dynamics in terms of _m[µ] i_[, the overlap of the network state] **[ S]**[ with pattern] _**[ ξ]**[µ]_[.][When the network is aligned most] closely with pattern _ξ[µ]_ , the overlap _m[µ] i_[is the largest contribution in the sum and pushes the network] to pattern _ξ[µ]_[+1] . When multiple patterns have similar overlaps, meaning they are correlated, then there will be low signal-to-noise ratio. This correlation between patterns limits the capacity of the network, limiting the `SeqNet` ’s capacity to scale linearly relative to network size. 

To overcome the capacity limitations of the `SeqNet` , we use inspiration from Dense Associative Memories [30] to define the `DenseNet` update rule: 

**==> picture [273 x 31] intentionally omitted <==**

where _f_ is a nonlinear monotonically increasing interaction function. Similar to MHNs, _f_ reduces the crosstalk between patterns and, as we will analyze in detail, leads to improved capacity. Figure 1 demonstrates this improvement for _f_ ( _x_ ) = _x_[2] . 

## **2.1 Sequence capacity** 

To derive analytical results for the capacity, we must choose a distribution to generate the patterns. As is standard in studies of the classic HN and MHNs [26–31, 33–36], we choose this to be the Rademacher distribution, where _ξj[µ][∈{−]_[1] _[,]_[ +1] _[}]_[ with equal probability for all neurons] _[ j]_[ in all patterns] _µ_ , and calculate the capacity for different update rules. If one is allowed to specially engineer the patterns, even the `SeqNet` can store a sequence of length 2 _[N]_ [37], but this construction is not relevant to associative recall of realistic sequences. Rademacher patterns are a more appropriate model for generic patterns while remaining theoretically tractable. 

We consider both the robustness of a single transition, and the robustness of propagation through the full sequence. For a fixed network size _N ∈{_ 2 _,_ 3 _, . . .}_ and an error tolerance _c ∈_ [0 _,_ 1), we define the single-transition and sequence capacities by 

**==> picture [337 x 13] intentionally omitted <==**

and 

**==> picture [361 x 14] intentionally omitted <==**

respectively, where the probability is taken over the random patterns. Note that for the singletransition capacity we could focus on any pair of subsequent patterns due to translation invariance arising from periodic boundary conditions. Also note that the full sequence capacity is defined by demanding that all transitions are correct. For perfect recall, we want to take the threshold _c ↓_ 0. In the thermodynamic limit in which _N, P →∞_ , we expect for there to exist a sharp transition in the recall probabilities as a function of _P_ , with almost-surely perfect recall below the threshold value and vanishing probability of recall above [26–29, 31, 33–36]. Thus, we expect the capacity to become insensitive to the value of _c_ in the thermodynamic limit; this is known rigorously for the classic Hopfield network from the work of Bovier [34]. 

As we detail in Appendix C, all of our theoretical results are obtained under two approximations. We will validate the accuracy of the resulting capacity predictions through comparison with numerical experiments. First, following Petritis [33]’s analysis of the classic Hopfield network, we use union bounds to control the single-transition and full-sequence capacities in terms of the single-bitflip error probability P[ _TDN_ ( _**ξ**_[1] )1 = _ξ_ 1[2][]][.][Using the fact that the patterns are i.i.d., this gives][ P][[] **[T]** _[DN]_[(] _**[ξ]**[µ]_[) =] _**ξ**[µ]_[+1] ] _≥_ 1 _−N_ P[ _TDN_ ( _**ξ**_[1] )1 = _ξ_ 2[1][]][ and][ P][[] _[∩][P] µ_ =1 _[{]_ **[T]** _[DN]_[(] _**[ξ]**[µ]_[) =] _**[ ξ]**[µ]_[+1] _[}]_[]] _[ ≥]_[1] _[−][NP]_[P][[] _[T][DN]_[(] _**[ξ]**_[1][)][1][=] _[ ξ]_ 2[1][]][,] respectively, resulting in the lower bounds 

**==> picture [337 x 30] intentionally omitted <==**

From studies of the classic Hopfield network, we expect for these bounds to be tight in the thermodynamic limit ( _N →∞_ ), but we will not attempt to prove that this is so [33, 34]. Second, our theoretical 

3 

results are obtained under the approximation of P[ _THN_ ( _**ξ**_[1] )1 = _ξ_ 1[2][]][ in the regime] _[ N, P][≫]_[1][ by a] Gaussian tail probability. Concretely, we write the single-bitflip probability as 

P[ _TDN_ ( _**ξ**_[1] )1 = _ξ_ 1[2][] =][ P][[] _[C][<][ −][f]_[(1)]] (7) 

in terms of the crosstalk 

**==> picture [278 x 31] intentionally omitted <==**

which represents interference between patterns that can lead to a bitflip. Then, as the crosstalk is the sum of _P −_ 1 i.i.d. random variables, we approximate its distribution as Gaussian. We then extract the capacity by determining how _P_ should scale with _N_ such that the error probability tends to zero as _N →∞_ , corresponding to taking _c ↓_ 0 with increasing _N_ . Within the Gaussian approximation, we can also estimate the capacity at fixed _c_ by using the asymptotics of the inverse Gaussian tail distribution function to determine how _P_ should scale with _N_ such that the error probability is asymptotically bounded by _c_ as _N →∞_ . This predicts that the effect of non-negligible _c_ should vanish as _N →∞_ . 

For _P_ large but finite, this Gaussian approximation amounts to retaining only the leading term in the Edgeworth expansion of the tail distribution function [38–41]. We will not endeavour to rigorously control the error of this approximation in the regime of interest in which _N_ is also large. To convert our heuristic results into fully rigorous asymptotics, one would want to construct an Edgeworth-type series expansion for the tail probability P[ _C < −f_ (1)] that is valid in the joint limit with rigorouslycontrolled asymptotic error, accounting for the fact that the crosstalk is a sum of discrete random variables [38–41]. As a simple probe of Gaussianity, we will consider the excess kurtosis of the crosstalk distribution, which determines the leading correction to the Gaussian approximation in the Edgeworth expansion, and describes whether its tails are heavier or narrower than Gaussian [38–41]. 

## **2.2 Polynomial** `DenseNet` 

Consider the `DenseNet` with polynomial interaction function, _f_ ( _x_ ) = _x[d]_ , which we will call the Polynomial `DenseNet` . In Appendix C.1, we argue that the leading asymptotics of the transition and sequence capacities for perfect recall are given by 

**==> picture [328 x 26] intentionally omitted <==**

Note that this polynomial scaling of the single-transition capacity with network size coincides with the capacity scaling of the symmetric MHN [30]. Indeed, as we have excluded self-interaction terms in the update rule, the single-bitflip probabilities for these two models coincide exactly for unbiased Radamacher patterns (Appendix C.1). This allows us to adapt arguments from Demircigil et al. [31] to show that (9) is in fact a rigorous asymptotic lower bound on the capacity (Appendix D). We compare our results for the single-transition and sequence capacities to numerical simulation in Figure 2. The simulation matches theoretical prediction for large network size _N_ . For smaller _N_ , there are finite-size effects that result in deviation from theoretical prediction. The crosstalk has non-negligible kurtosis in finite size networks which leads to deviation from the Gaussian approximation. 

Furthermore, we point out that for fixed _N_ , the network capacity does not monotonically increase in the degree _d_ . Since the factorial function grows faster than the exponential function, every finite network of size _N_ has a polynomial degree _dmax_ after which the capacity will actually decrease. This is also true for the standard MHN. We demonstrate this numerically in Figure 2B, again noting mild deviations between theory and simulation due to finite-size effects. 

## **2.3 Exponential** `DenseNet` 

We have shown the `DenseNet` ’s capacity can scale polynomially with network size. Can it scale exponentially? Consider the `DenseNet` with exponential interaction function, _f_ ( _x_ ) = _e_[(] _[N][−]_[1)(] _[x][−]_[1)] , which we call the Exponential `DenseNet` . This function reduces crosstalk dramatically: _f_ ( _m[µ]_ ( **S** )) = 1 when _m[µ]_ ( **S** ) = 1 and is otherwise sent to zero exponentially fast. In Appendix C.2, we show that under the abovementioned approximations one has the leading asymptotics 

**==> picture [357 x 25] intentionally omitted <==**

4 

**==> picture [376 x 252] intentionally omitted <==**

**----- Start of picture text -----**<br>
A 7 7<br>Theory: Poly (d=1) Sim: Poly (d=1)<br>6 6 Theory: Poly (d=2) Sim: Poly (d=2)<br>Theory: Poly (d=3) Sim: Poly (d=3)<br>Theory: Poly (d=4) Sim: Poly (d=4)<br>5 5 Theory: Exp Sim: Exp<br>4 4<br>3 3<br>2 2<br>1 1<br>0 0<br>10 20 30 40 50 60 70 80 90 100 10 20 30 40 50 60 70 80 90 100<br>N N<br>B 4 Theory: N = 10 C 20<br>Theory: N = 15Theory: N = 20 101 103 19<br>3 Sim: N = 10Sim: N = 15Sim: N = 20 10 0 102 1817<br>16<br>2 10−1 101 15<br>14<br>10−2 10 0 13<br>1<br>10−3 10−1 1211<br>0 0 10 20 102 103 104 102 103 104 10<br>d P P<br>)T )S<br>(P (P<br>10 10<br>log log<br>)(PT<br>10 N<br>log Variance<br>Excess Kurtosis<br>**----- End of picture text -----**<br>


Figure 2: Testing the transition and sequence capacities of `DenseNet` s with polynomial and exponential nonlinearities. **A** . Scaling of transition capacity (log10( _PT_ ), _left_ ) and sequence capacity (log10( _PS_ ), _right_ ) with network size. As network size increases, the variance of the crosstalk decreases and the theoretical approximations become more accurate, resulting in a tight match between theory (solid lines) and simulation (points with error bars). The theory curves are given by Equations 9 and 10. Error bars are computed across realizations of the random patterns (see Appendix G). There is significant deviation between theory and simulation for the sequence capacity of the Exponential `DenseNet` . We show that this is due to finite-size effects in Section 2.3. **B** . Transition capacity of Polynomial `DenseNet` s as a function of degree. For any finite network size _N_ , there is a degree _d_ that maximizes the transition capacity. The same would be true for the sequence capacity. **C** . Crosstalk variance ( _left_ ) and excess kurtosis ( _right_ ) for the Exponential `DenseNet` as a function of _P_ and _N_ . Variance is proportional to _P_ and inversely proportional to _N_ , while the opposite is true for excess kurtosis. See Appendix G for details of our numerical methods. 

In Figure 2, numerical simulations confirm this model scales significantly better than the Polynomial `DenseNet` and enables one to store exponentially long sequences relative to network size. While the ratio between transition and sequence capacities remains bounded for the Polynomial `DenseNet` , where _PT /PS ∼ d_ + 1, the gap for the Exponential `DenseNet` diverges with network size. 

However, we can see in Figure 2A that the empirically measured capacity—particularly the sequence capacity—of the Exponential `DenseNet` deviates substantially from the predictions of our approximate Gaussian theory. Due to computational constraints, our numerical simulations are limited to small network sizes (Appendix G). Computing the excess kurtosis of the crosstalk distribution with a number of patterns comparable to the capacity predicted by the Gaussian theory reveals that, for the range of system sizes we can simulate, the distribution should deviate strongly from a Gaussian. In particular, if take _P ∼ β[N][−]_[1] _/_ ( _αN_ ) for some constant factor _α_ , then the excess kurtosis increases with network size up to around _N ≈_ 56 (Appendix C.2). Increasing the size of an Exponential `DenseNet` therefore has competing effects: for a fixed sequence length _P_ , increasing network size _N_ decreases the crosstalk variance, which should reduce the bitflip probability, but also increases the excess kurtosis, which reflects a fattening of the crosstalk distribution tails that should increase the bitflip probability. This is illustrated in Figure 2C. 

The competition between increasing _P_ and _N_ for the Exponential `DenseNet` is easy to understand intuitively. For a fixed _N_ , increasing _P_ means that the crosstalk is equal in distribution to the sum of an increasingly large number of i.i.d. random variables, and thus by the central limit theorem should become increasingly Gaussian. Conversely, for a fixed _P_ , increasing _N_ means that each of the 

5 

**==> picture [360 x 142] intentionally omitted <==**

**----- Start of picture text -----**<br>
A B<br>4<br>Poly: d=1 Poly w/ GPI: d=1<br>Poly: d=2 Poly w/ GPI: d=2<br>FUREERREEH fo. fs<br>3 Poly: d=3 Poly w/ GPI: d=3<br>OOOOO00050 a<br>DOOOGOOOEHGHEGEEEOOSo 2 fs \  yt,%<br>1<br>FREERSo<br>FREER :<br>0<br>PIPPI GEA 0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9<br>PPI AAS ε<br>)<br>T<br>(P<br>10<br>log<br>**----- End of picture text -----**<br>


Figure 3: **A** . Recall of a sequence of 200000 correlated images from the MovingMNIST dataset using `DenseNet` s of size _N_ = 784. We showcase a 10 image subsequence. The top row depicts the true sequence, the second row depicts `SeqNet` ’s performance, the next rows depict the Polynomial `DenseNet` s’ performance which increases with degree _d_ , and the final row depicts the Exponential `DenseNet` ’s performance which yields perfect recall. **B** . Transition capacity of Polynomial `DenseNet` s of size _N_ = 100 relative to pattern bias _ϵ_ . Increasing _ϵ_ monotonically decreases capacity. Networks with stronger nonlinearities maintain high capacity for large correlation strength. Implementing the generalized pseudoinverse rule decorrelates these patterns and maintains high sequence capacity for much larger correlation. See Appendix G for details of numerical methods. 

_P −_ 1 contributions to the crosstalk is equal in distribution to the _product_ of an increasing number of i.i.d. random variables—as _f_ ~~(—~~ _N_ 1 _−_ 1 y _Nj_ =2 _[ξ] j[µ][ξ] j_[1] )n = _Nj_ =2[exp(] _[ξ] j[µ][ξ] j_[1][)][—and thus by the multiplicative] central limit theorem each term should tend to a lognormal distribution. In this regime, then, the crosstalk is roughly a mixture of lognormals, which is decidedly non-Gaussian. In contrast, for a Polynomial `DenseNet` , memorization is easy in the limit where _N_ tends to infinity for fixed _P_ , as 1 _N_ the crosstalk should tend almost surely to zero as each term _f_ ~~(—~~ _N −_ 1 > _j_ =2 _[ξ] j[µ][ξ] j_[1] ) _→_ 0 almost surely. 

## **2.4 Recalling Sequences of Correlated Patterns** 

The full-sequence capacity scaling laws for these models were derived under the assumption of i.i.d Rademacher random patterns. While theoretically convenient, this is unrealistic for real-world data. We therefore test these networks in more realistic settings by storing correlated sequences of patterns, which will lead to greater crosstalk in each transition and thus smaller single-transition and full-sequence capacities relative to network size [26, 36]. However, the nonlinear interaction functions should still assist in separating correlated patterns to enable successful sequence recall. 

For demonstration, we store a sequence of 200000 highly-correlated images from the MovingMNIST dataset and attempt to recall this sequence using `DenseNet` s with different nonlinearities [42]. The entire sequence is composed of 10000 unique subsequences concatenated together, where each subsequence is composed of 20 images of two hand-written digits slowly moving through one another. This means there is significant correlation between patterns which will result in large amounts of crosstalk. The results of the `DenseNet` s are shown in Figure 3A, where increasing the nonlinearity of the Polynomial `DenseNet` s slowly improves recall but not entirely, while the exponential network achieves perfect recall. The `SeqNet` and `DenseNet` s, up until approximately _d_ = 50, are entirely unable to recall any part of any image, despite the `DenseNet` s being well within the capacity limits predicted by theoretical calculations on uncorrelated patterns. 

## **2.5 Generalized pseudoinverse rule** 

Can we overcome the `DenseNet` ’s limited ability to store correlated patterns? Drawing inspiration from the pseudoinverse learning rule introduced by Kanter and Sompolinsky [43] for the classic Hopfield network, we propose a generalized pseudoinverse (GPI) transition rule 

**==> picture [358 x 32] intentionally omitted <==**

6 

where the overlap matrix _O[µν]_ is positive-semidefinite, so we can define its pseudoinverse **O**[+] by inverting the non-zero eigenvalues. With _f_ ( _x_ ) = _x_ , this reduces to the pseudoinverse rule of [43]. 

If the patterns are linearly independent, such that **O** is full-rank, we can see that this rule can perfectly recall the full sequence (Appendix E). This matches the classic pseudoinverse rule’s ability to perfectly store any set of linearly independent patterns; this is why we choose to sum over _ν_ inside the separation function in (11). For i.i.d. Rademacher patterns, linear independence holds almost surely in the thermodynamic limit provided that _P < N_ . 

In Figure 3B, we demonstrate the effect of correlation on the Polynomial `DenseNet` through studying the recall of biased patterns _ξi[µ]_[with][P][(] _[ξ] i[µ]_[=] _[±]_[1)][=] 12[(1] _[ ±][ ϵ]_[)][for] _[ϵ][∈]_[[0] _[,]_[ 1)][.][3][We][see][that][the] Polynomial `DenseNet` has better recall at all levels of bias _ϵ_ as degree _d_ increases, although we still expect there to be a maximum degree as described before. However, at large correlation values, they all have low recall, suggesting the need for alternative methods to decorrelate these patterns. This failure is easy to understand theoretically, following van Hemmen and Kühn [44]’s analysis of the classic Hopfield model: for patterns with bias _ϵ_ , the Polynomial `DenseNet` update rule expands as 

**==> picture [312 x 13] intentionally omitted <==**

Therefore, even if _N_ is large, for _ϵ ̸_ = 0 there must be some value of _P_ for which the constant bias overwhelms the signal. If _N →∞_ for any fixed _P_ , then we must have _P < ϵ[−]_[(2] _[d]_[+1)] + 1 for the signal to dominate. In Figure 3B, we show the generalized pseudoinverse update rule is more robust to large correlations than the Polynomial `DenseNet` . While this rule can also be applied to the Exponential `DenseNet` , simulations fail due to numerical instability coming from small values in the pseudoinverse. 

## **3** `MixedNet` **s for variable timing** 

Thus far, we have considered sequence recall in purely asymmetric networks. These networks transition to the next pattern in the sequence at every timestep, preventing the network from storing sequences with longer timing between elements. In this section, we aim to construct a model where the network stays in a pattern for _τ_ steps. Our starting model will be an associative memory model for storing sequences known as the Temporal Association Network (TAN) [1, 10], defined as: 

**==> picture [350 x 32] intentionally omitted <==**

where _m_ ¯ _[µ] i_[represents the normalized overlap of each pattern] _**[ ξ]**[µ]_[with a weighted time-average of] the network over the past _τ_ timesteps, _S_[¯] _i_ ( _t_ ) =[�] _[τ] ρ_ =0 _[w]_[(] _[ρ]_[)] _[S][i]_[(] _[t][ −][ρ]_[)][.][The weight function,] _[ w]_[(] _[t]_[)][, is] generally taken to be a low-pass convolutional filter (e.g. Heaviside step function, exponential decay). 

This network combines a symmetric and asymmetric term for robust recall of multiple sequences. The symmetric term containingin pattern _**ξ**[µ]_ for a desired amount of time. _m[µ] i_[(] _[t]_[)][, also referred to as a “fast" synapse, stabilizes the network] The asymmetric term containing _m_ ¯ _[µ] i_[(] _[t]_[)][, also referred] to as a “slow" synapse, drives the network transition to pattern _**ξ**[µ]_[+1] . The _λ_ parameter controls the strength of the transition signal. If _λ_ is too small, no transitions will occur since the symmetric term will overpower it. If _λ_ is too large, transitions will occur too quickly for the network to stabilize in a desired pattern and the sequence will quickly destabilize. 

For TAN, Sompolinsky and Kanter [10] used numerical simulations to estimate the capacity as approximately _PT AN ∼_ 0 _._ 1 _N_ , defining capacity as the ability to recall the sequence in correct order with high overlap (meaning that a small propotion of incorrect bits are allowed in each transition). Note that this model can fail in two ways: (i) it can fail to recall the correct sequence of patterns, or (ii) it can fail to stay in each state for the desired amount of time. 

To address these issues, we consider the following dynamics: 

**==> picture [314 x 31] intentionally omitted <==**

> 3At _ϵ_ = 1, the patterns will be deterministic with _ξiµ_[= +1][.] 

7 

**==> picture [389 x 215] intentionally omitted <==**

**----- Start of picture text -----**<br>
A<br>1.0Temporal Association Network Polynomial MixedNet (dS=dA=2) Polynomial MixedNet (dS=dA=10) 40<br>0.5<br>0.0 BATA ALAA ALATA AT AAT ASAT BUetre  ecHlede cecgegietescre igte Bey eUetie Pe@2c-= es 8afes =: ce ge °e2,--52252 FEs<br>1<br>0 100 200 0 100 200 0 100 200<br>Timestep (t) Timestep (t) Timestep (t)<br>B 5 d S = 1 5 d S = 2 5 d S = 3<br>4 — Theory (dTheory (d AA = = 1)2) L Sim (dSim (d AA = = 1)2) 4 4<br>3 a Theory (d A = 3) Sim (d A = 3) 3 3<br>2 2 2<br>1 1 1<br>ae SSS rt TT <e=a -<br>0 0 0<br>10 20 30 40 50 60 70 80 90 100 10 20 30 40 50 60 70 80 90 100 10 20 30 40 50 60 70 80 90 100<br>N N N<br>C 5 d S = 1 5 d S = 2 5 d S = 3<br>4 — Theory (dTheory (d AA = = 1)2) L Sim (dSim (d AA = = 1)2) 4 4<br>3 = Theory (d A = 3) Sim (d A = 3) 3 3<br>2 2 2<br>1 1 1<br>SS rt —<br>0  S S 0 a 0 ==<br>10 20 30 40 50 60 70 80 90 100 10 20 30 40 50 60 70 80 90 100 10 20 30 40 50 60 70 80 90 100<br>N N N<br>Overlap (m)μ )Pattern (ξμ<br>)(PT )(PT )(PT<br>10 10 10<br>log log log<br>)S )S )S<br>(P (P (P<br>10 10 10<br>log log log<br>**----- End of picture text -----**<br>


Figure 4: Capacity of the Polynomial `MixedNet` . **A** . We simulate `MixedNet` s with _N_ = 100, _τ_ = 5, and attempt to store _P_ = 40 patterns. The Temporal Association Network ( _left_ ), corresponding to a linear `MixedNet` with _dS_ = 1 = _dA_ , fails to recover the sequence. Increasing the nonlinearities to _dS_ = 2 = _dA_ ( _center_ ) recovers the correct sequence order, but not the timing. Increasing the nonlinearities to _dS_ = 10 = _dA_ ( _right_ ) recovers the correct sequence order and timing. **B** . Transition capacity log10( _PT_ ) of the Polynomial `MixedNet` as a function of network size. Each panel has a fixed symmetric nonlinearity _fS_ ( _x_ ) = _x[d][S]_ indicated by the panel’s title. As network size increases, crosstalk variance decreases and theoretical approximations in Equation 3 become more accurate to tightly match the simulations. Note that as expected, the capacity scales according to the minimum of _dS_ and _dA_ . **C** . As in **B** , but for the sequence capacity log10( _PS_ ). 

We call this model the `MixedNet` , and seek to analyze the relationship between the symmetric and asymmetric terms in driving network dynamics and their impact on sequence capacity. As before, the asymmetric term will try to push the network to the next state at every timestep, while the symmetric term tries to maintain it in its current state for _τ_ timesteps. We will allow different nonlinearities for _fS_ and _fA_ , and analyze their effect on transition and sequence capacity. 

We demonstrate the effectiveness of the Polynomial `MixedNet` , where for simplicity we set _fS_ ( _x_ ) = _fA_ ( _x_ ) = _x[d]_ , in Figure 4A. While TAN fails completely, a polynomial nonlinearity of _d_ = 2 enables recall of pattern order but the network does not stay in each pattern for _τ_ = 5 timesteps. Further increasing the nonlinearity to _d_ = 10 recovers the desired sequence with correct order and timing. 

Theoretical analysis of the capacity of the `MixedNet` (14) for general memory length _τ_ is challenging due to the extended temporal interactions. We therefore consider single-step memory ( _τ_ = 1), and show that even in this relatively tractable special case new complications arise relative to our analysis of the `DenseNet` . Alternatively, we can interpret the `MixedNet` with _τ_ = 1 as an imperfectly-learned `DenseNet` . If one imagines the network learns its weights through a temporally asymmetric Hebbian rule with an extended plasticity kernel, and its state is not perfectly clamped to the desired transition, the coupling from _**ξ**[µ]_ to _**ξ**[µ]_[+1] could be corrupted by coupling _**ξ**[µ]_ to itself [22]. 

We first consider the setting where both interaction functions are polynomial, _fS_ ( _x_ ) = _x[d][S]_ and _fA_ ( _x_ ) = _x[d][A]_ , and refer to this network as the Polynomial `MixedNet` . This model is analyzed in detail in Appendix F.1. Interestingly, this model’s crosstalk variance forms a bimodal distribution, as shown in Figure F.1. This complicates the analysis, but once bimodality is accounted for one can approximate the capacity using a similar argument to that of the `DenseNet` . We find that 

**==> picture [364 x 26] intentionally omitted <==**

8 

where _γdS ,dA_ is a multiplicative factor defined as 

**==> picture [358 x 44] intentionally omitted <==**

In Figure 4B-C, we show that simulations match the theory curves well as _N_ increases. We demonstrate theoretical and simulations results for the Exponential `MixedNet` in Appendix F.2. 

## **4 Biologically-Plausible Implementation** 

Since biological neural networks must store sequence memories [2, 5–8], one naturally asks if these results can be generalized to biologically-plausible neural networks. A straightforward biological interpretation of the `DenseNet` is problematic, as a network with polynomial interaction function of degree _d_ is equivalent to having a neural network with many-body synapses between _d_ + 1 neurons. This can be seen by expanding the Polynomial `DenseNet` in terms of a weight tensor of _d_ +1 neurons: 

**==> picture [390 x 36] intentionally omitted <==**

This is biologically unrealistic as synaptic connections usually occur between two neurons [45]. In the case of the Exponential `DenseNet` , one can interpret its interaction function via a Taylor series expansion, implying synaptic connections between infinitely many neurons which is even more problematic. Similar difficulties arise in models with sum of terms with different powers [46]. 

To address this issue, we again take inspiration from earlier work in MHNs. Krotov and Hopfield [47] addressed this concern for symmethy(t) = f (= W040) ric MHNs by reformulating the network using OOOQOOOOO0O0O0O00O two-body synapses, where the network was partitioned into a bipartite graph with visible and hidden neurons (see [48] for an extension of this idea to deeper networks). The visible neurons correspond to the neurons in our network dynamWin = ~é C ‘we = git ics,the individual memories stored within the net- **S** _j_ , while the hidden neurons correspond to OOOOO0O00O work. They are connected through a weight matrix. Since we are working with an asymv(t +1) =sgn bS Muto metric network, we modify their approach and define two sets of synaptic weights: _Wjµ_ conFigure 5: Biologically-plausible implementation nects visible neuron _vj_ to hidden neuron _hµ_ , of `DenseNet` with two-body synapses. _Mµj_ connects hidden neuron _hµ_ to visible neuron _vj_ . This yields the same dynamics exhibited in Equation (2), absorbing the nonlinearity into the hidden neurons’ dynamics. 

Figure 5: Biologically-plausible implementation of `DenseNet` with two-body synapses. 

For the `DenseNet` , we define the weights as _Wjµ_ := _N_[1] _[ξ] j[µ]_[and] _[ M][µj]_[:=] _[ ξ] j[µ]_[+1] . For the `MixedNet` , we redefine the weight matrix _Mµj_ = _ξj[µ]_[+] _[ λξ] j[µ]_[+1] . The update rules for the neurons are as follows: 

**==> picture [337 x 25] intentionally omitted <==**

Note that these networks’ transition and sequence capacities, _PT_ and _PS_ , now scale linearly with respect to the total number of neurons in this model, _N_ visible neurons and _P_ hidden neurons. However, the network capacity still scales nonlinearly with respect to the number of visible neurons. 

Finally, we remark that this network is reminiscent of recent computational models for motor action selection and control via the cortico-basal ganglia-thalamo-cortical loop, in which the basal ganglia inhibits thalamic neurons that are bidirectionally connected to a recurrent cortical network [5, 49, 50]. This relates to our model as follows: the motor cortex (visible neurons) executes an action, each 

9 

thalamic unit (hidden neurons) encodes a motor motif, and the basal ganglia silences thalamic neurons (external network modulating context). In particular, the role of the basal ganglia in this network suggests a novel mechanism of context-dependent gating within Hopfield Networks [51]. Rather than modulating synapses or feature neurons in a network, one can directly inhibit (activate) memory neurons in order to decrease (increase) the likelihood of transitioning to the associated state. Similarly, thalamocortical loops have been found to be important to song generation in zebra finches [52]. Thus, the biological implementation of the `DenseNet` can provide insight into how biological agents reliably store and generate complex sequences. 

## **5 Discussion and Future Directions** 

We introduced the `DenseNet` for the reliable storage and recall of long sequences of patterns, derived the scaling of its single-transition and full-sequence capacity, and verified these results in numerical simulation. We found that depending on the choice of nonlinear interaction function, the `DenseNet` could scale polynomially or exponentially. We tested the ability of these models to recall sequences of correlated patterns, by comparing the recall of a sequence of MovingMNIST images with different nonlinearities. As expected, the network’s reconstruction capabilities increased with the nonlinearity power _d_ , with perfect recall achieved by the exponential nonlinearity. To further increase the capacity, we introduced the generalized pseudoinverse rule and demonstrated in simulation its ability to maintain high capacity for highly correlated patterns. We also introduced and analyzed the `MixedNet` to maintain patterns within sequences for longer periods of time. Finally, we described a biologically plausible implementation of the models with connections to motor control. 

There has recently been a renewed interest in storing sequences of memories. Steinberg and Sompolinsky [53] store sequences in Hopfield networks by using a vector-symbolic architecture to bind each pattern to its temporal order in the sequence, thus storing the entire sequence as a single attractor. However, this model suffers from the same capacity limitations as the Hopfield Network. Whittington et al. [54] suggest a mechanism to control sequence retrieval via an external controller, analogous to the role we ascribe to the basal ganglia for context-dependent gating. Herron et al. [55] investigate a mechanism for robust sequence recall within complex systems more broadly, reducing crosstalk by directly modulating interactions between neurons rather than the inputs into neurons. Tang et al. [56] propose a model for sequential recall akin to `SeqNet` with an implicit statistical whitening process. Karuvally et al. [57] introduce a model closely related to the biologically-plausible implementation of our `MixedNet` and analyze it in the setting of continuous-time dynamics, allowing for intralayer synapses within the hidden layer and different timescales between the hidden and feature layers. 

While we have focused on a generalization of the fixed-point capacity for sequence memory, this is not the only notion of capacity one could consider. In other studies of MHNs, instead of considering stability as the probability of staying at a fixed point, researchers quantify the probability that the network will reach a fixed point within a single transition [31, 58, 59]. This approach allows one to quantify noise-robustness and the size of each memory’s basin of attraction [35]. More broadly, one could consider other definitions of associative memory capacity not addressed here, including those that depend only on network architecture and not on the assumption of a particular learning rule [60, 61]. However, as compared to the relatively simple analysis that is possible for the fixed-point capacity of a Hopfield network using a Hebbian learning rule, analyzing these alternative notions of capacity in nonlinear networks can pose significant technical challenges [61–63]. 

In this work, we limited ourselves to theoretical analysis of discrete-time networks storing binary patterns. An important direction for future research would be to go beyond the Gaussian theory in order to develop accurate predictions of the Exponential `DenseNet` capacity. There are also many potential avenues for extending these models and methods to continuous-time networks, continuous-valued patterns, computing capacity for correlated patterns, testing different weight functions, and examining different network topologies. Finally, we hope to take inspiration from the recent resurgence of RNNs in long sequence modeling to use this model for real-world tasks [64, 65]. 

10 

## **Acknowledgments and Disclosure of Funding** 

We thank Matthew Farrell, Shanshan Qin, and Sabarish Sainathan for useful discussions and comments on earlier versions of our manuscript. HC was supported by the GFSD Fellowship, Harvard GSAS Prize Fellowship, and Harvard James Mills Peirce Fellowship. JAZ-V and CP were supported by NSF Award DMS-2134157 and NSF CAREER Award IIS-2239780. CP received additional support from a Sloan Research Fellowship. This work has been made possible in part by a gift from the Chan Zuckerberg Initiative Foundation to establish the Kempner Institute for the Study of Natural and Artificial Intelligence. The computations in this paper were run on the FASRC Cannon cluster supported by the FAS Division of Science Research Computing Group at Harvard University. 

## **References** 

- [1] D Kleinfeld and H Sompolinsky. Associative neural network model for the generation of temporal patterns. theory and application to central pattern generators. _Biophysical Journal_ , 54 (6):1039–1051, 1988. 

- [2] Michael A. Long, Dezhe Z. Jin, and Michale S. Fee. Support for a synaptic chain model of neuronal sequence generation. _Nature_ , 468(7322):394–399, Nov 2010. ISSN 1476-4687. doi:10.1038/nature09514. URL `https://doi.org/10.1038/nature09514` . 

- [3] Maxwell Gillett, Ulises Pereira, and Nicolas Brunel. Characteristics of sequential activity in networks with temporally asymmetric Hebbian learning. _Proceedings of the National Academy of Sciences_ , 117(47):29948–29958, November 2020. doi:10.1073/pnas.1918674117. 

- [4] Stefano Recanatesi, Ulises Pereira-Obilinovic, Masayoshi Murakami, Zachary Mainen, and Luca Mazzucato. Metastable attractors explain the variable timing of stable behavioral action sequences. _Neuron_ , 110(1):139–153, 2022. 

- [5] Luca Mazzucato. Neural mechanisms underlying the temporal organization of naturalistic animal behavior. _eLife_ , 11:e76577, 2022. 

- [6] Edmund T Rolls and Patrick Mills. The generation of time in the hippocampal memory system. _Cell Reports_ , 28(7):1649–1658, 2019. 

- [7] Alexander B. Wiltschko, Matthew J. Johnson, Giuliano Iurilli, Ralph E. Peterson, Jesse M. Katon, Stan L. Pashkovski, Victoria E. Abraira, Ryan P. Adams, and Sandeep Robert Datta. Mapping sub-second structure in mouse behavior. _Neuron_ , 88(6):1121–1135, 2015. ISSN 08966273. doi:https://doi.org/10.1016/j.neuron.2015.11.031. URL `https://www.sciencedirect. com/science/article/pii/S0896627315010375` . 

- [8] Jeffrey E. Markowitz, Winthrop F. Gillis, Maya Jay, Jeffrey Wood, Ryley W. Harris, Robert Cieszkowski, Rebecca Scott, David Brann, Dorothy Koveal, Tomasz Kula, Caleb Weinreb, Mohammed Abdal Monium Osman, Sandra Romero Pinto, Naoshige Uchida, Scott W. Linderman, Bernardo L. Sabatini, and Sandeep Robert Datta. Spontaneous behaviour is structured by reinforcement without explicit reward. _Nature_ , 614(7946):108–117, Feb 2023. ISSN 1476-4687. doi:10.1038/s41586-022-05611-2. URL `https://doi.org/10.1038/ s41586-022-05611-2` . 

- [9] Cengiz Pehlevan, Farhan Ali, and Bence P Ölveczky. Flexibility in motor timing constrains the topology and dynamics of pattern generator circuits. _Nature communications_ , 9(1):977, 2018. doi:https://doi.org/10.1038/s41467-018-03261-5. 

- [10] H. Sompolinsky and I. Kanter. Temporal Association in Asymmetric Neural Networks. _Physical Review Letters_ , 57(22):2861–2864, December 1986. doi:10.1103/PhysRevLett.57.2861. 

- [11] Zijian Jiang, Ziming Chen, Tianqi Hou, and Haiping Huang. Spectrum of nonHermitian deep-Hebbian neural networks. _Physical Review Research_ , 5:013090, Feb 2023. doi:10.1103/PhysRevResearch.5.013090. URL `https://link.aps.org/doi/10.1103/ PhysRevResearch.5.013090` . 

- [12] Ulises Pereira and Nicolas Brunel. Unsupervised learning of persistent and sequential activity. _Frontiers in Computational Neuroscience_ , 13:97, 2020. 

11 

- [13] Christian Leibold and Richard Kempter. Memory capacity for sequences in a recurrent network with biological constraints. _Neural Computation_ , 18(4):904–941, 2006. 

- [14] Jeff Hawkins, Dileep George, and Jamie Niemasik. Sequence memory for prediction, inference and behaviour. _Philosophical Transactions of the Royal Society B: Biological Sciences_ , 364 (1521):1203–1209, 2009. 

- [15] Jeff Hawkins and Subutai Ahmad. Why neurons have thousands of synapses, a theory of sequence memory in neocortex. _Frontiers in Neural Circuits_ , page 23, 2016. 

- [16] Daniel J Amit. Neural networks counting chimes. _Proceedings of the National Academy of Sciences_ , 85(7):2141–2145, 1988. 

- [17] H. Gutfreund and M. Mezard. Processing of temporal sequences in neural networks. _Phys. Rev. Lett._ , 61:235–238, Jul 1988. doi:10.1103/PhysRevLett.61.235. URL `https://link.aps. org/doi/10.1103/PhysRevLett.61.235` . 

- [18] Kanaka Rajan, Christopher D. Harvey, and David W. Tank. Recurrent network models of sequence generation and memory. _Neuron_ , 90(1):128–142, 2016. ISSN 0896-6273. doi:https://doi.org/10.1016/j.neuron.2016.02.009. URL `https://www.sciencedirect.com/ science/article/pii/S0896627316001021` . 

- [19] Markus Diesmann, Marc-Oliver Gewaltig, and Ad Aertsen. Stable propagation of synchronous spiking in cortical neural networks. _Nature_ , 402(6761):529–533, Dec 1999. ISSN 1476-4687. doi:10.1038/990101. URL `https://doi.org/10.1038/990101` . 

- [20] Nicholas F Hardy and Dean V Buonomano. Neurocomputational models of interval and pattern timing. _Current Opinion in Behavioral Sciences_ , 8:250–257, 2016. ISSN 2352-1546. doi:https://doi.org/10.1016/j.cobeha.2016.01.012. URL `https://www.sciencedirect.com/ science/article/pii/S2352154616300195` . Time in perception and action. 

- [21] Dina Obeid, Jacob A. Zavatone-Veth, and Cengiz Pehlevan. Statistical structure of the trial-to-trial timing variability in synfire chains. _Phys. Rev. E_ , 102:052406, Nov 2020. doi:10.1103/PhysRevE.102.052406. URL `https://link.aps.org/doi/10.1103/ PhysRevE.102.052406` . 

- [22] Matthew Farrell and Cengiz Pehlevan. Recall tempo of Hebbian sequences depends on the interplay of Hebbian kernel with tutor signal timing. _bioRxiv_ , 2023. doi:10.1101/2023.06.07.542926. URL `https://www.biorxiv.org/content/early/2023/06/07/2023.06.07.542926` . 

- [23] John J Hopfield. Neural networks and physical systems with emergent collective computational abilities. _Proceedings of the National Academy of Sciences_ , 79(8):2554–2558, 1982. 

- [24] John J Hopfield. Neurons with graded response have collective computational properties like those of two-state neurons. _Proceedings of the national academy of sciences_ , 81(10):3088–3092, 1984. 

- [25] S-I Amari. Learning patterns and pattern sequences by self-organizing nets of threshold elements. _IEEE Transactions on computers_ , 100(11):1197–1206, 1972. 

- [26] John Hertz, Anders Krogh, and Richard G Palmer. _Introduction to the theory of neural computation_ . CRC Press, 2018. 

- [27] Daniel J Amit, Hanoch Gutfreund, and Haim Sompolinsky. Spin-glass models of neural networks. _Physical Review A_ , 32(2):1007, 1985. 

- [28] Daniel J. Amit, Hanoch Gutfreund, and H. Sompolinsky. Storing infinite numbers of patterns in a spin-glass model of neural networks. _Phys. Rev. Lett._ , 55:1530–1533, Sep 1985. doi:10.1103/PhysRevLett.55.1530. URL `https://link.aps.org/doi/10.1103/ PhysRevLett.55.1530` . 

- [29] Daniel J Amit, Hanoch Gutfreund, and H Sompolinsky. Statistical mechanics of neural networks near saturation. _Annals of Physics_ , 173(1):30–67, 1987. ISSN 0003-4916. doi:https://doi.org/10.1016/0003-4916(87)90092-3. URL `https://www.sciencedirect. com/science/article/pii/0003491687900923` . 

12 

- [30] Dmitry Krotov and John J. Hopfield. Dense associative memory for pattern recognition. _Advances in Neural Information Processing Systems_ , 29, 2016. 

- [31] Mete Demircigil, Judith Heusel, Matthias Löwe, Sven Upgang, and Franck Vermet. On a model of associative memory with huge storage capacity. _Journal of Statistical Physics_ , 168(2): 288–299, July 2017. ISSN 0022-4715, 1572-9613. doi:10.1007/s10955-017-1806-y. 

- [32] Dmitry Krotov. A new frontier for hopfield networks. _Nature Reviews Physics_ , pages 1–2, 2023. 

- [33] Dimitri Petritis. Thermodynamic formalism of neural computing. In Eric Goles and Servet Martínez, editors, _Dynamics of Complex Interacting Systems_ , pages 81–146. Springer Netherlands, Dordrecht, 1996. doi:10.1007/978-94-017-1323-8_3. URL `https://doi.org/10. 1007/978-94-017-1323-8_3` . 

- [34] Anton Bovier. Sharp upper bounds on perfect retrieval in the Hopfield model. _Journal of Applied Probability_ , 36(3):941–950, 1999. doi:10.1239/jap/1032374647. 

- [35] R. McEliece, E. Posner, E. Rodemich, and S. Venkatesh. The capacity of the Hopfield associative memory. _IEEE Transactions on Information Theory_ , 33(4):461–482, July 1987. ISSN 00189448. doi:10.1109/TIT.1987.1057328. 

- [36] G. Weisbuch and F. Fogelman-Soulié. Scaling laws for the attractors of Hopfield networks. _J. Physique Lett._ , 46(14):623–630, 1985. doi:10.1051/jphyslet:019850046014062300. URL `https://doi.org/10.1051/jphyslet:019850046014062300` . 

- [37] Samuel P. Muscinelli, Wulfram Gerstner, and Johanni Brea. Exponentially Long Orbits in Hopfield Neural Networks. _Neural Computation_ , 29(2):458–484, 02 2017. ISSN 0899-7667. doi:10.1162/NECO_a_00919. 

- [38] V. V. Petrov. _Sums of Independent Random Variables_ . De Gruyter, Berlin, Boston, 1975. ISBN 9783112573006. doi:doi:10.1515/9783112573006. Trans. A. A. Brown. 

- [39] John E. Kolassa. _Series Approximation Methods in Statistics_ . Springer New York, 1997. doi:10.1007/978-1-4757-4277-0. URL `https://doi.org/10.1007/978-1-4757-4277-0` . 

- [40] John E. Kolassa and Peter McCullagh. Edgeworth Series for Lattice Distributions. _The Annals of Statistics_ , 18(2):981 – 985, 1990. doi:10.1214/aos/1176347637. URL `https: //doi.org/10.1214/aos/1176347637` . 

- [41] Dmitry Dolgopyat and Kasun Fernando. An Error Term in the Central Limit Theorem for Sums of Discrete Random Variables. _International Mathematics Research Notices_ , 05 2023. ISSN 1073-7928. doi:10.1093/imrn/rnad088. URL `https://doi.org/10.1093/imrn/rnad088` . rnad088. 

- [42] Nitish Srivastava, Elman Mansimov, and Ruslan Salakhudinov. Unsupervised learning of video representations using lstms. In _International conference on machine learning_ , pages 843–852. PMLR, 2015. 

- [43] I. Kanter and H. Sompolinsky. Associative recall of memory without errors. _Phys. Rev. A_ , 35: 380–392, Jan 1987. doi:10.1103/PhysRevA.35.380. URL `https://link.aps.org/doi/10. 1103/PhysRevA.35.380` . 

- [44] J. Leo van Hemmen and Reimer Kühn. Collective phenomena in neural networks. In Eytan Domany, J. Leo van Hemmen, and Klaus Schulten, editors, _Models of Neural Networks I_ , pages 1–113, Berlin, Heidelberg, 1995. Springer Berlin Heidelberg. ISBN 9783-642-79814-6. doi:10.1007/978-3-642-79814-6_1. URL `https://doi.org/10.1007/ 978-3-642-79814-6_1` . 

- [45] Eric R Kandel, James H Schwartz, Thomas M Jessell, Steven Siegelbaum, A James Hudspeth, Sarah Mack, et al. _Principles of neural science_ . McGraw-hill New York, 6 edition, 2021. 

- [46] Thomas F Burns and Tomoki Fukai. Simplicial Hopfield networks. In _The Eleventh International Conference on Learning Representations_ , 2023. 

13 

- [47] Dmitry Krotov and John J. Hopfield. Large associative memory problem in neurobiology and machine learning. In _International Conference on Learning Representations_ , 2021. URL `https://openreview.net/forum?id=X4y_10OX-hX` . 

- [48] Dmitry Krotov. Hierarchical associative memory. _arXiv preprint arXiv:2107.06446_ , 2021. 

- [49] Ta-Chu Kao, Mahdieh S Sadabadi, and Guillaume Hennequin. Optimal anticipatory control as a theory of motor preparation: A thalamo-cortical circuit model. _Neuron_ , 109(9):1567–1581, 2021. 

- [50] Laureline Logiaco, LF Abbott, and Sean Escola. Thalamic control of cortical dynamics in a model of flexible motor sequencing. _Cell Reports_ , 35(9):109090, 2021. 

- [51] Nicolas Y. Masse, Gregory D. Grant, and David J. Freedman. Alleviating catastrophic forgetting using context-dependent gating and synaptic stabilization. _Proceedings of the National Academy of Sciences_ , 115(44), October 2018. ISSN 0027-8424, 1091-6490. doi:10.1073/pnas.1803839115. 

- [52] Felix W. Moll, Devorah Kranz, Ariadna Corredera Asensio, Margot Elmaleh, Lyn A. AckertSmith, and Michael A. Long. Thalamus drives vocal onsets in the zebra finch courtship song. _Nature_ , 616(7955):132–136, Apr 2023. ISSN 1476-4687. doi:10.1038/s41586-023-05818-x. URL `https://doi.org/10.1038/s41586-023-05818-x` . 

- [53] Julia Steinberg and Haim Sompolinsky. Associative memory of structured knowledge. _Scientific Reports_ , 12(1):21808, Dec 2022. ISSN 2045-2322. doi:10.1038/s41598-022-25708-y. URL `https://doi.org/10.1038/s41598-022-25708-y` . 

- [54] James C. R. Whittington, Joseph Warren, and Timothy E. J. Behrens. Relating transformers to models and neural representations of the hippocampal formation, March 2022. 

- [55] Lukas Herron, Pablo Sartori, and BingKan Xue. Robust retrieval of dynamic sequences through interaction modulation. _arXiv preprint arXiv:2211.17152_ , 2022. 

- [56] Mufeng Tang, Helen Barron, and Rafal Bogacz. Sequential memory with temporal predictive coding. _arXiv preprint arXiv:2305.11982_ , 2023. 

- [57] Arjun Karuvally, Terry J Sejnowski, and Hava T Siegelmann. Energy-based general sequential episodic memory networks at the adiabatic limit. _arXiv preprint arXiv:2212.05563_ , 2022. 

- [58] Hubert Ramsauer, Bernhard Schäfl, Johannes Lehner, Philipp Seidl, Michael Widrich, Lukas Gruber, Markus Holzleitner, Thomas Adler, David Kreil, Michael K Kopp, Günter Klambauer, Johannes Brandstetter, and Sepp Hochreiter. Hopfield networks is all you need. In _International Conference on Learning Representations_ , 2021. URL `https://openreview.net/forum? id=tL89RnzIiCd` . 

- [59] Carlo Lucibello and Marc Mézard. The exponential capacity of dense associative memories. _arXiv preprint arXiv:2304.14964_ , 2023. 

- [60] Andreas Knoblauch, Günther Palm, and Friedrich T Sommer. Memory capacities for synaptic and structural plasticity. _Neural Computation_ , 22(2):289–341, 2010. 

- [61] Jacob A. Zavatone-Veth and Cengiz Pehlevan. On neural network kernels and the storage capacity problem. _Neural Computation_ , 34(5):1136–1142, 04 2022. ISSN 0899-7667. doi:10.1162/neco_a_01494. URL `https://doi.org/10.1162/neco_a_01494` . 

- [62] Jacob A. Zavatone-Veth and Cengiz Pehlevan. Activation function dependence of the storage capacity of treelike neural networks. _Phys. Rev. E_ , 103:L020301, Feb 2021. doi:10.1103/PhysRevE.103.L020301. URL `https://link.aps.org/doi/10.1103/ PhysRevE.103.L020301` . 

- [63] Rémi Monasson and Riccardo Zecchina. Weight space structure and internal representations: A direct approach to learning and generalization in multilayer neural networks. _Phys. Rev. Lett._ , 75:2432–2435, Sep 1995. doi:10.1103/PhysRevLett.75.2432. URL `https://link.aps.org/ doi/10.1103/PhysRevLett.75.2432` . 

14 

- [64] Albert Gu, Karan Goel, and Christopher Ré. Efficiently modeling long sequences with structured state spaces. _arXiv preprint arXiv:2111.00396_ , 2021. 

- [65] Antonio Orvieto, Samuel L Smith, Albert Gu, Anushan Fernando, Caglar Gulcehre, Razvan Pascanu, and Soham De. Resurrecting recurrent neural networks for long sequences. _arXiv preprint arXiv:2303.06349_ , 2023. 

- [66] Dmitry Krotov and John Hopfield. Dense associative memory is robust to adversarial inputs. _Neural computation_ , 30(12):3151–3167, 2018. 

- [67] HH Chen, YC Lee, GZ Sun, HY Lee, Tom Maxwell, and C Lee Giles. High order correlation model for associative memory. In _AIP Conference Proceedings_ , volume 151, pages 86–99. American Institute of Physics, 1986. 

- [68] Demetri Psaltis and Cheol Hoon Park. Nonlinear discriminant functions and associative memories. In _AIP conference Proceedings_ , volume 151, pages 370–375. American Institute of Physics, 1986. 

- [69] Pierre Baldi and Santosh S Venkatesh. Number of stable points for spin-glasses and neural networks of higher orders. _Physical Review Letters_ , 58(9):913, 1987. 

- [70] E Gardner. Multiconnected neural network models. _Journal of Physics A: Mathematical and General_ , 20(11):3453, 1987. 

- [71] Laurence F Abbott and Yair Arian. Storage capacity of generalized networks. _Physical review A_ , 36(10):5091, 1987. 

- [72] D Horn and M Usher. Capacities of multiconnected memory models. _Journal de Physique_ , 49 (3):389–395, 1988. 

- [73] Elena Agliari, Alberto Fachechi, and Chiara Marullo. Nonlinear PDEs approach to statistical mechanics of dense associative memories. _Journal of Mathematical Physics_ , 63(10):103304, 2022. doi:10.1063/5.0095411. URL `https://doi.org/10.1063/5.009541` . 

- [74] Elena Agliari, Linda Albanese, Francesco Alemanno, Andrea Alessandrelli, Adriano Barra, Fosca Giannotti, Daniele Lotito, and Dino Pedreschi. Dense Hebbian neural networks: a replica symmetric picture of unsupervised learning. _arXiv_ , 2022. doi:10.48550/ARXIV.2211.14067. URL `https://arxiv.org/abs/2211.14067` . 

- [75] Linda Albanese, Francesco Alemanno, Andrea Alessandrelli, and Adriano Barra. Replica symmetry breaking in dense Hebbian neural networks. _Journal of Statistical Physics_ , 189(2): 24, Sep 2022. ISSN 1572-9613. doi:10.1007/s10955-022-02966-8. URL `https://doi.org/ 10.1007/s10955-022-02966-8` . 

- [76] Stéphane Boucheron, Gábor Lugosi, and Pascal Massart. _Concentration Inequalities: A Nonasymptotic Theory of Independence_ . Oxford University Press, 02 2013. ISBN 9780199535255. doi:10.1093/acprof:oso/9780199535255.001.0001. URL `https://doi. org/10.1093/acprof:oso/9780199535255.001.0001` . 

- [77] DLMF. _NIST Digital Library of Mathematical Functions_ . http://dlmf.nist.gov/, Release 1.1.1 of 2021-03-15, 2021. URL `http://dlmf.nist.gov/` . F. W. J. Olver, A. B. Olde Daalhuis, D. W. Lozier, B. I. Schneider, R. F. Boisvert, C. W. Clark, B. R. Miller, B. V. Saunders, H. S. Cohl, and M. A. McClain, eds. 

- [78] Yann LeCun, Corinna Cortes, and CJ Burges. MNIST handwritten digit database. _ATT Labs [Online]_ , 2, 2010. URL `http://yann.lecun.com/exdb/mnist` . 

15 

## **A Review of Modern Hopfield Networks** 

Here we review the Hopfield network and its modern generalization as an auto-associative memory model. These ideas will be helpful for storing sequences in network dynamics. 

## **A.1 The Hopfield Network** 

We first introduce the classic Hopfield Network [23]. Let _N_ be the number of neurons in the network and **S** ( _t_ ) _∈{−_ 1 _,_ +1 _}[N]_ be the state of the network at time _t_ . The task is to store _P_ patterns, _{_ _**ξ**_[1] _, . . . ,_ _**ξ**[µ] }_ , where _ξj[µ][∈{±]_[1] _[}]_[ is the] _[ j][th]_[ neuron of the] _[ µ][th]_[ pattern.][The goal is to design a network] with dynamics such that when the network is initialized with a pattern, it will converge to one of the stored memories. 

The Hopfield Network [23] attempts this by following the discrete-time synchronous update rule[4] : 

**S** ( _t_ + 1) = **T** _HN_ ( **S** ( _t_ )) _,_ (A.1) 

where the transition operator _THN_ ( _·_ ) _i_ for neuron _i_ is defined in terms of symmetric Hebbian weights: 

**==> picture [307 x 37] intentionally omitted <==**

Note that we are excluding self-interaction terms ( _Jii_ ) in Equation A.2. To interpret this dynamics from another useful point of view, we define the overlap, or Mattis magnetization, _m[µ] i_[of the network] state **S** with pattern _**ξ**[µ]_ . We can then rewrite the update rule for the Hopfield Network as 

**==> picture [321 x 32] intentionally omitted <==**

We interpret this as at every time _t_ , the network tries to identify the pattern _**ξ**[µ]_ it is closest to and updates neuron _i_ to the value for that pattern. A natural question to ask about the associative memory networks is their capacity: how many patterns can be stored and recalled with minimal error? This question has been the subject of many studies [23, 27–29, 33–36]. Intuitively, in recalling a pattern _**ξ**[ν]_ , what limits the network’s capacity is the overlap between the pattern _**ξ**[ν]_ and other patterns, referred to as the crosstalk [26, 36]. 

A precise answer to the storage capacity question can be given under the assumption that the patterns _{_ _**ξ**[µ] }_ are sampled from some probability distribution. While different notions of capacity have been considered in the literature [23, 27–29, 33–36], we focus on the _fixed-point capacity_ , which characterizes the probability that, when initialized at a given pattern, the network dynamics do not move the state away from that point. To render the problem analytically tractable, it is usually assumed that the pattern components are i.i.d. Rademacher random variables, i.e., P( _ξj[µ]_[=] _[ ±]_[1) = 1] _[/]_[2][ for all] _j_ and _µ_ . Then, at finite network size one can define the capacity as 

**==> picture [370 x 14] intentionally omitted <==**

where _c ∈_ [0 _,_ 1) is a fixed error tolerance. As we review in detail in Appendix B, one finds an asymptotic capacity estimate _PHN ∼_ 4 log( _N N_ )[for] _[ c]_[ = 0][, which can be shown to be a sharp threshold] [33–35]. 

## **A.2 Modern Hopfield Networks** 

Recent work from Krotov and Hopfield [30, 66] reinvigorated a line of research into generalized Hopfield Networks with larger capacity [67–72], resulting in what are now called Dense Associative Memories or Modern Hopfield Networks: 

**==> picture [273 x 31] intentionally omitted <==**

4For the Hopfield network, one can also consider an asynchronous update rule in which only one neuron is updated at each timestep [23, 26]. 

S1 

where _f_ , referred to as the interaction function, is a nonlinear monotonically increasing function whose purpose is to separate the pattern overlaps for better signal to noise ratio. Since _m[µ] i_[(] _[t]_[)][ has a] maximum value of 1, this means contributions from patterns with partial overlaps will be reduced by the interaction function. This diminishes the crosstalk and thereby increases the probability of transitioning to the correct pattern. If the interaction function is chosen to be _f_ ( _x_ ) = _x[d]_ , then the MHN’s capacity has been shown to scale polynomially with network size as _P ∼ βd_ log( _N[d] N_ )[, where] _[ β][d]_ is a numerical constant depending on the degree _d_ [30, 73–75]. Using a different definition of capacity, Demircigil et al. [31] have also shown that an exponential nonlinearity can lead to exponential scaling of the capacity. See [32] for a recent review of these results. 

## **B Review of Hopfield network fixed-point capacity** 

In this Appendix, we review the computation of the classical Hopfield network fixed-point capacity. Our approach will follow—but not exactly match—that of Petritis [33]. Though these results are standard, we review them in detail both because this approach will inspire in part our approach to the `DenseNet` , and because several important steps of the analysis are significantly simpler than the corresponding steps for the `DenseNet` . 

We begin by recalling that the Hopfield network update can be written as 

**==> picture [300 x 37] intentionally omitted <==**

and that our goal is to determine 

**==> picture [358 x 14] intentionally omitted <==**

for some absolute constant 0 _≤ c <_ 1, at least in the regime where _N, P ≫_ 1 [33–36]. As is standard in theoretical studies of Hopfield model capacity [26–29, 33–36], we take in these probabilities the pattern components _ξk[µ]_[to be independent and identically distributed Rademacher random variables.] We can expand the memorization probability as a union of single-bitflip events: 

**==> picture [334 x 32] intentionally omitted <==**

This illustrates why analyzing the memorization probability is complicated: the single-pattern events **T** _HN_ ( _**ξ**[µ]_ ) = _**ξ**[µ]_ are not independent across patterns _µ_ , and each single-pattern event is itself the intersection of non-independent single-neuron events _THN_ ( _**ξ**[µ]_ ) _i_ = _ξi[µ]_[.][However, as the single-bitflip] probabilities P[ _THN_ ( _**ξ**[µ]_ ) _j_ = _ξj[µ]_[]][ are identical for all] _[ µ]_[ and] _[ j]_[, we can obtain a straightforward union] bound 

**==> picture [332 x 67] intentionally omitted <==**

**==> picture [220 x 12] intentionally omitted <==**

where we focus without loss of generality on the first element of the first pattern. Therefore, if we can control the single-bitflip probability P[ _THN_ ( _**ξ**_[1] )1 = _ξ_ 1[1][]][, we can obtain a lower bound on the true] capacity. In particular, 

**==> picture [340 x 13] intentionally omitted <==**

S2 

From the definition of the Hopfield network update rule, we have 

**==> picture [329 x 91] intentionally omitted <==**

where we have defined 

**==> picture [261 x 32] intentionally omitted <==**

and used the fact that the distribution of _C_ is symmetric. _C_ is referred to as the _crosstalk_ , because it represents the effect of interference between the first pattern and the other _P −_ 1 patterns on recall of the first pattern. We can simplify the crosstalk using the fact that, since we have assumed i.i.d. Rademacher patterns, we have the equality in distribution 

**==> picture [253 x 70] intentionally omitted <==**

**==> picture [193 x 10] intentionally omitted <==**

Similarly, we have 

**==> picture [221 x 15] intentionally omitted <==**

for all _µ_ = 2 _, . . . , P_ and _j_ = 2 _, . . . , N_ , which finally yields 

**==> picture [248 x 32] intentionally omitted <==**

Therefore, for the classic Hopfield network the crosstalk is equal in distribution to the sum of ( _P −_ 1)( _N −_ 1) i.i.d. Rademacher random variables. 

## **B.1 Approach 1: Hoeffding’s inequality** 

Now, we can immediately apply Hoeffding’s inequality [76], which implies that for any _t >_ 0 

We then have that 

**==> picture [306 x 85] intentionally omitted <==**

We then have the bound 

**==> picture [344 x 24] intentionally omitted <==**

We now want to consider the regime _N ≫_ 1, and demand that the error probability should tend to zero as we increase _N_ . If we substitute in the _Ansatz_ 

**==> picture [228 x 24] intentionally omitted <==**

S3 

the bound is easily seen to tend to zero for all _α ≥_ 4, yielding an estimated capacity of 

**==> picture [234 x 23] intentionally omitted <==**

As this estimates follows from a sequence of lower bounds on the memorization probability, it is a lower bound on the true capacity of the model [33]. However, via a more involved argument that accounts for the associations between the events **T** _HN_ ( _**ξ**[µ]_ ) = _**ξ**[µ]_ , it was shown by Bovier [34] to be tight. 

For the classical Hopfield network, the single bitflip probability P[ _C >_ 1] is easy to control using elementary concentration inequalities because the crosstalk can be expressed as a sum of ( _P −_ 1)( _N −_ 1) i.i.d. random variables. Therefore, we expect the crosstalk to concentrate whenever _N_ or _P_ or both together are large. However, for the `DenseNet` , we will find in Appendix C that the crosstalk is given as the sum of _P −_ 1 i.i.d. random variables, each of which is a nonlinear function applied to the sum of _N −_ 1 i.i.d. Rademacher random variables. Naïve application of Hoeffding’s inequality is then not particularly useful. We will therefore take a simpler, though less rigorously controlled approach, which can also be applied to the classical Hopfield network: we approximate the distribution of the crosstalk as Gaussian [26]. 

## **B.2 Approach 2: Gaussian approximation** 

For the classical Hopfield network, the fact that the crosstalk can be expressed as a sum of ( _P −_ 1)( _N −_ 1) i.i.d. Rademacher random variables means that the classical central limit theorem implies that it tends in distribution to a Gaussian whenever ( _P −_ 1)( _N −_ 1) tends to infinity. By symmetry, the mean of the crosstalk is zero, while its variance is easily seen to be 

**==> picture [236 x 21] intentionally omitted <==**

If we approximate the distribution of the crosstalk for _N_ and _P_ large but finite by a Gaussian, we therefore have 

**==> picture [258 x 31] intentionally omitted <==**

where _H_ ( _x_ ) = erfc( _x/√_ 2) _/_ 2 is the Gaussian tail distribution function. We want to have P[ _C >_ 1] _→_ 0, so we must have ( _P −_ 1) _/_ ( _N −_ 1) _→_ 0. Then, we can use the asymptotic expansion [26] 

**==> picture [318 x 25] intentionally omitted <==**

to obtain the heuristic Gaussian approximation 

**==> picture [296 x 30] intentionally omitted <==**

If we use this Gaussian approximation instead of the Hoeffding bound applied above, we can easily see that we will obtain identical estimates for the capacity with an error tolerance tending to zero. However, we have given up the rigor of the bound from Hoeffding’s inequality, since we have not controlled the rate of convergence to the Gaussian tail probability. In particular, the Berry-Esseen theorem would give in this case a uniform additive error bound of 1 _/_ �( _P −_ 1)( _N −_ 1), which in the regime _P ∼ N/_ [ _α_ log _N_ ] cannot compete with the factors of _N_ or _NP_ which we want P[ _C >_ 1] to overwhelm. We will not worry about this issue, as we are concerned more with whether we can get accurate capacity estimates that match numerical experiment than whether we can prove those estimates completely rigorously. 

We can also use the Gaussian approximation to estimate the capacity for a non-zero error threshold _c_ at finite _N_ . Concretely, if we demand that the union bound is saturated, i.e., 

**==> picture [257 x 13] intentionally omitted <==**

S4 

under the Gaussian approximation for the bitflip probability we have the self-consistent equation 

**==> picture [249 x 31] intentionally omitted <==**

for _P_ , which we can re-write as 

**==> picture [253 x 24] intentionally omitted <==**

This is a transcendental self-consistent equation, which is not easy to solve analytically. However, we can make some progress at small _c/_ ( _NP_ ). Using the asymptotic expansion of the inverse of the complementary error function [77], we have 

**==> picture [304 x 12] intentionally omitted <==**

**==> picture [258 x 52] intentionally omitted <==**

**==> picture [258 x 11] intentionally omitted <==**

as _x →_ 0. Then, assuming _c_ is such that _−_ log( _c_ ) is negligible relative to log( _NP_ ), we have 

**==> picture [235 x 23] intentionally omitted <==**

which we can solve for _P_ as 

**==> picture [238 x 24] intentionally omitted <==**

where _W_ 0 is the principal branch of the Lambert- _W_ function [77]. But, at large _N_ , we can use the asymptotic _W_ 0( _N_ ) _∼_ log( _N_ ) to obtain the approximate scaling 

**==> picture [231 x 24] intentionally omitted <==**

which agrees with our earlier result. Conceptually, this intuition is consistent with there being a sharp transition in the thermodynamic limit, as proved rigorously by Bovier [34]. 

## **C** `DenseNet` **Capacity** 

In this Appendix, we analyze the capacity of the `DenseNet` . As introduced in Section 2.1 of the main text, there are two notions of robustness to consider: the robustness of a single transition and the robustness of the full sequence. For a fixed _N ∈{_ 2 _,_ 3 _, . . .}_ and an error tolerance _c ∈_ [0 _,_ 1), we define these two notions of capacity as 

**==> picture [337 x 13] intentionally omitted <==**

and 

**==> picture [398 x 27] intentionally omitted <==**

Our goal is to approximately compute the capacity in the regime in which _N_ and _P_ are large. Following Petritis [33]’s approach to the HN, to make analytical progress, we can use a union bound to control the single-step error probability in terms of the probability of a single bitflip: 

**==> picture [92 x 13] intentionally omitted <==**

**==> picture [271 x 66] intentionally omitted <==**

**==> picture [271 x 13] intentionally omitted <==**

S5 

where we use the fact that all elements of all patterns are i.i.d. by assumption. We use a similar approach to control the sequence error probability in terms of the probability of a single bitflip: 

**==> picture [282 x 120] intentionally omitted <==**

Thus, as claimed in the main text, we have the lower bounds 

**==> picture [331 x 13] intentionally omitted <==**

and 

**==> picture [337 x 14] intentionally omitted <==**

As introduced in the main text, for perfect recall, we want to take the threshold _c_ to be zero, or at least to tend to zero as _N_ and _P_ tend to infinity. The capacities estimated through this argument are lower bounds on the true capacities, as they are obtained from lower bounds on the true recall probability. However, we expect for these bounds to in fact be tight in the thermodynamic limit [33, 34]. 

By the definition of the `DenseNet` update rule with interaction function _f_ given in Equation (2), we have 

**==> picture [306 x 37] intentionally omitted <==**

and therefore the single-bitflip probability is 

**==> picture [361 x 193] intentionally omitted <==**

For both the polynomial ( _f_ ( _x_ ) = _x[d]_ ) and exponential ( _f_ ( _x_ ) = _e_[(] _[N][−]_[1)(] _[x][−]_[1)] ) interaction functions, _f_ (1) = 1, and so 

We refer to the random variable 

**==> picture [279 x 37] intentionally omitted <==**

on the left-hand-side of this inequality as the _crosstalk_ , because it represents the effect of interference between the first pattern and all other patterns [26, 36]. 

S6 

We now observe that, as we have excluded self-interactions (i.e., the sum over neurons inside the interaction function does not include _j_ = 1), we can use the periodic boundary conditions to shift indices as _ξ_ 1 _[µ][←][ξ]_ 1 _[µ]_[+1] for all _µ_ , yielding 

**==> picture [273 x 37] intentionally omitted <==**

Thus, the single-bitflip probability for this `DenseNet` is identical to that for the corresponding MHN with symmetric interactions. Then, we can use the fact that _ξj[µ][ξ] j_[1] = _d ξjµ_[for all] _[ µ]_[ = 2] _[, . . . , P]_[to obtain] 

**==> picture [266 x 37] intentionally omitted <==**

Now, define the _P −_ 1 random variables 

**==> picture [258 x 37] intentionally omitted <==**

for _µ_ = 2 _, . . . , P_ , such that the crosstalk is their sum, 

**==> picture [226 x 31] intentionally omitted <==**

As the patterns _ξj[µ]_[are i.i.d.,] _[ χ][µ]_[ are i.i.d.][random variables of mean] 

**==> picture [290 x 36] intentionally omitted <==**

and variance 

**==> picture [279 x 43] intentionally omitted <==**

which is bounded from above for any sensible interaction function. We observe also that the distribution of each _χ[µ]_ is symmetric because of the symmetry of the distribution of _ξ_ 1 _[µ]_[.][We will] therefore simply write _χ_ for any given _χ[µ]_ . 

Then, the classical central limit theorem implies that the crosstalk tends in distribution to a Gaussian of mean zero and variance ( _P −_ 1) var( _χ_ ) as _P →∞_ , at lease for any fixed _N_ . However, we are interested in the joint limit in which _N, P →∞_ together. We will proceed by approximating the distribution of _C_ as Gaussian, and will not attempt to rigorously control its behavior in the joint limit. 

Approximating the distribution of the crosstalk for _N, P ≫_ 1 by a Gaussian, we then have 

**==> picture [295 x 31] intentionally omitted <==**

where _H_ ( _x_ ) = erfc( _x/√_ 2) _/_ 2 is the Gaussian tail distribution function. We want to have P[ _TDN_ ( _**ξ**_[1] )1 = _ξ_ 1[2][]] _[→]_[0][,][so][we][must][have][(] _[P][−]_[1) var(] _[χ]_[)] _[→]_[0][.][Then,][we][can][use][the][asymp-] totic expansion [26] 

**==> picture [318 x 24] intentionally omitted <==**

to obtain 

**==> picture [339 x 27] intentionally omitted <==**

S7 

For each model, we can evaluate var( _χ_ ) and then determine the resulting predicted capacity. 

As we did for the classic Hopfield network in Appendix B, we can estimate the capacity at finite _c_ within the Gaussian approximation by inverting the Gaussian tail distribution function. Concretely, under the union bound, we can estimate the transition capacity by solving 

**==> picture [268 x 31] intentionally omitted <==**

which yields 

**==> picture [265 x 24] intentionally omitted <==**

and the sequence capacity by solving the transcendental self-consistent equation 

**==> picture [274 x 31] intentionally omitted <==**

which we can re-write as 

**==> picture [271 x 24] intentionally omitted <==**

As in the classic Hopfield case, we can simplify these complicated equations somewhat by assuming that _c/N_ and _c/_ ( _NPS_ ) are small. Concretely, using the asymptotic 

**==> picture [248 x 12] intentionally omitted <==**

for _x →_ 0, the transition capacity simplifies to 

**==> picture [255 x 24] intentionally omitted <==**

under the assumption that _−_ log( _c_ ) is negligible relative to log( _N_ ). For the sequence capacity, we can follow an identical argument to that used for the classic Hopfield network to simplify the self-consistent equation to 

**==> picture [252 x 24] intentionally omitted <==**

under the assumption that _−_ log( _c_ ) is negligible relative to log( _NPS_ ), which we can solve to obtain 

**==> picture [265 x 24] intentionally omitted <==**

Assuming that _N/_ var( _χ_ ) _→∞_ as _N →∞_ , we can use the asymptotic _W_ 0( _N_ ) _∼_ log( _N_ ) to obtain the asymptotic 

**==> picture [263 x 24] intentionally omitted <==**

Our first check on the accuracy of the Gaussian approximation will be comparison of the resulting predictions for capacity with numerical experiment. As another diagnostic, we will consider the excess kurtosis κ = _κ_ 4( _C_ ) _/κ_ 2( _C_ ) for _κn_ ( _C_ ) the _n_ -th cumulant of _C_ . If the distribution is indeed Gaussian, the excess kurtosis vanishes, while large values of the excess kurtosis indicate deviations from Gaussianity. By the additivity of cumulants, we have 

**==> picture [250 x 11] intentionally omitted <==**

By symmetry, all odd cumulants of _χ_ —and therefore all odd cumulants of _C_ —are identically zero. As noted above, we have 

**==> picture [295 x 42] intentionally omitted <==**

S8 

If _C_ is indeed Gaussian, then all cumulants above the second should vanish. As the third cumulant vanishes by symmetry, the leading possible correction to Gaussianity is the fourth cumulant, which as _χ_ has zero mean is given by 

**==> picture [339 x 61] intentionally omitted <==**

Rather than considering the fourth cumulant directly, we will consider the excess kurtosis 

**==> picture [263 x 25] intentionally omitted <==**

which is a more useful metric because it is normalized. 

## **C.1 Polynomial** `DenseNet` **Capacity** 

We first consider the Polynomial `DenseNet` , with interaction function _f_ ( _x_ ) = _x[d]_ for _d ∈_ N _>_ 0. To compute the capacity, our goal is then to evaluate 

**==> picture [272 x 42] intentionally omitted <==**

at large _N_ . From the central limit theorem, we expect 

**==> picture [281 x 43] intentionally omitted <==**

We can make this quantitatively precise through the following straightforward argument. Let 

**==> picture [243 x 31] intentionally omitted <==**

We then have immediately that the moment generating function of Ξ is 

**==> picture [284 x 27] intentionally omitted <==**

hence the cumulant generating function is 

**==> picture [305 x 25] intentionally omitted <==**

The function _x �→_ log cosh( _x_ ) is an even function of _x_ , and is analytic near the origin, with the first few orders of its MacLaurin series being 

**==> picture [269 x 23] intentionally omitted <==**

Then, the odd cumulants of Ξ vanish—as we expect from symmetry—while the even cumulants obey 

**==> picture [239 x 25] intentionally omitted <==**

for combinatorial factors _C_ 2 _k_ that do not scale with _N_ . We have, in particular, _C_ 2 = 1 and _C_ 4 = _−_ 2. By the moments-cumulants formula, we have 

**==> picture [273 x 13] intentionally omitted <==**

S9 

for _B_ 2 _k_ the 2 _k_ -th complete exponential Bell polynomial. From this, it follows that 

**==> picture [266 x 13] intentionally omitted <==**

as all cumulants other than _κ_ 2 = 1 are _O_ ( _N[−]_[1] ). Therefore, neglecting subleading terms, we have 

**==> picture [335 x 43] intentionally omitted <==**

Following the general arguments above, we then approximate 

**==> picture [325 x 27] intentionally omitted <==**

To determine the single-transition capacity following the argument in Section 2.1, we must determine how large we can take _P_ = _P_ ( _N_ ) such that _N_ P[ _TDN_ ( _**ξ**_[1] )1 = _ξ_ 1[2][]] _[ →]_[0][.][Following the requirement] that _P_ var( _χ_ ) _→_ 0, we make the _Ansatz_ 

**==> picture [248 x 26] intentionally omitted <==**

for some _α_ . We then have 

**==> picture [294 x 25] intentionally omitted <==**

This tends to zero if _α ≥_ 2, meaning that the predicted capacity in this case is 

**==> picture [251 x 25] intentionally omitted <==**

We now want to determine the sequence capacity, which requires the stronger condition _NP_ P[ _TDN_ ( _**ξ**_[1] )1 = _ξ_ 1[2][]] _[ →]_[0][.][Again making the] _[ Ansatz]_ 

**==> picture [248 x 25] intentionally omitted <==**

for some _α_ , we then have 

**==> picture [334 x 25] intentionally omitted <==**

which tends to zero if _α ≥_ 2 _d_ + 2. Then, the predicted sequence capacity is 

**==> picture [266 x 26] intentionally omitted <==**

If we consider the alternative asymptotic formulas obtained above from the finite- _c_ argument, we have 

**==> picture [293 x 25] intentionally omitted <==**

and 

**==> picture [401 x 36] intentionally omitted <==**

which agree with these results. For evidence of the finite- _c_ argument for the polynomial `DenseNet` , observe Figure C.1. 

S10 

**==> picture [397 x 199] intentionally omitted <==**

**----- Start of picture text -----**<br>
Polynomial DenseNet (Finite C)<br>7<br>Theory (d=1) Sim: Poly (d=1, c = 0.3) Sim: Poly (d=2, c = 0.3) Sim: Poly (d=3, c = 0.3) Sim: Poly (d=4, c = 0.3)<br>Theory (d=2) Sim: Poly (d=1, c = 0.2) Sim: Poly (d=2, c = 0.2) Sim: Poly (d=3, c = 0.2) Sim: Poly (d=4, c = 0.2)<br>6 Theory (d=3)Theory (d=4) Sim: Poly (d=1, c = 0.1)Sim: Poly (d=1, c = 0.0) Sim: Poly (d=2, c = 0.1)Sim: Poly (d=2, c = 0.0) Sim: Poly (d=3, c = 0.1)Sim: Poly (d=3, c = 0.0) Sim: Poly (d=4, c = 0.1)Sim: Poly (d=4, c = 0.0)<br>5<br>4<br>3<br>2<br>1<br>0<br>10 20 30 40 50 60 70 80 90 100<br>N<br>)<br>T<br>P<br>(<br>10<br>log<br>**----- End of picture text -----**<br>


Figure C.1: The transition capacity of the polynomial `DenseNet` is demonstrated for different values of error tolerance _c_ . We see that even for _c ̸_ = 0, we get similar scaling curves although the capacities slightly increase consistently as we increase _c_ , indicated by a transition from dark to light. We plot from _c_ = 0 _._ 0 to _c_ = 0 _._ 5 for each degree _d_ , with the legend labeling curves up to _c_ = 0 _._ 3 to demonstrate the general trend. 

Using the Gaussian approximation for moments of _χ_ given above, we can easily work out that 

**==> picture [337 x 89] intentionally omitted <==**

Then, the excess kurtosis of the Polynomial `DenseNet` ’s crosstalk is 

**==> picture [299 x 25] intentionally omitted <==**

Thus, for the Polynomial `DenseNet` , we expect the excess kurtosis to be small for any fixed _d_ so long as _P_ and _N_ are both fairly large, without any particular requirement on their relationship. In particular, under the Gaussian approximation we predicted above that the transition and sequence capacities should both scale as 

**==> picture [231 x 25] intentionally omitted <==**

where _αd_ depends on _d_ but not on _N_ . This gives an excess kurtosis of 

**==> picture [303 x 24] intentionally omitted <==**

which for any fixed _d_ rapidly tends to zero with increasing _N_ . This suggests that the Gaussian approximation should be reasonably accurate even at modest _N_ , but of course does not constitute a proof of its accuracy because we have not considered higher cumulants. However, this matches the results of numerical simulations shown in Figure 2. 

S11 

## **C.2 Exponential** `DenseNet` **capacity** 

We now turn our attention to the Exponential `DenseNet` , with separation function _f_ ( _x_ ) = _e_[(] _[N][−]_[1)(] _[x][−]_[1)] . In this case, we have 

**==> picture [298 x 115] intentionally omitted <==**

where we have defined the constant 

**==> picture [251 x 24] intentionally omitted <==**

Then, we have the Gaussian approximation 

**==> picture [304 x 31] intentionally omitted <==**

As in the polynomial case, we first determine the single-transition capacity by demanding that _N_ P[ _TDN_ ( _**ξ**_[1] )1 = _ξ_ 1[2][]] _[ →]_[0][.][We plug in the] _[ Ansatz]_ 

**==> picture [227 x 25] intentionally omitted <==**

for some _α_ , which yields 

**==> picture [294 x 25] intentionally omitted <==**

This tends to zero if _α ≥_ 2, which gives a predicted capacity of 

**==> picture [230 x 25] intentionally omitted <==**

Considering the sequence capacity, which again requires that _NP_ P[ _TDN_ ( _**ξ**_[1] )1 = _ξ_ 1[2][]] _[ →]_[0][, we plug] in the _Ansatz_ 

**==> picture [225 x 23] intentionally omitted <==**

which yields 

**==> picture [328 x 25] intentionally omitted <==**

This tends to zero for _α ≥_ 2 log _β_ , meaning that the predicted capacity is in this case 

**==> picture [236 x 26] intentionally omitted <==**

Therefore, while the ratio of the predicted single-transition to sequence capacities is finite for the Polynomial `DenseNet` —it is simply _PS/PT ∼ d_ + 1—for the Exponential `DenseNet` it tends to zero as _PS/PT ∼_ log _N/_ [log( _β_ ) _N_ ]. 

Using the asymptotic formulas obtained above from the finite- _c_ argument, we have 

**==> picture [272 x 25] intentionally omitted <==**

S12 

**==> picture [397 x 199] intentionally omitted <==**

**----- Start of picture text -----**<br>
Exponential DenseNet (Finite C)<br>7<br>Theory<br>6 Sim: c=0.5Sim: c=0.4<br>Sim: c=0.3<br>5 Sim: c=0.2<br>Sim: c=0.1<br>4 Sim: c=0.0<br>3<br>2<br>1<br>0<br>1 2 3 4 5 6 7 8 9 10111213141516171819202122232425<br>N<br>)<br>T<br>P<br>(<br>10<br>log<br>**----- End of picture text -----**<br>


Figure C.2: The transition capacity of the exponential `DenseNet` is demonstrated for different values of error tolerance _c_ . We see that even for _c ̸_ = 0, we get similar scaling curves although the capacities slightly increase consistently as we increase _c_ . 

and 

**==> picture [329 x 25] intentionally omitted <==**

which agree with these results. For evidence of the finite- _c_ argument for the exponential `DenseNet` , observe Figure C.2. 

Now considering the fourth cumulant, we can easily compute 

**==> picture [299 x 27] intentionally omitted <==**

which yields an excess kurtosis of 

**==> picture [276 x 31] intentionally omitted <==**

For this to be small, _P_ must be exponentially large in _N_ , which contrasts with the situation for the Polynomial `DenseNet` , in which the excess kurtosis is small for any reasonably large _P_ . If we consider taking 

**==> picture [228 x 25] intentionally omitted <==**

for a constant _α_ , as the Gaussian theory predicts for the Exponential `DenseNet` transition capacity, we have 

**==> picture [277 x 31] intentionally omitted <==**

**==> picture [268 x 43] intentionally omitted <==**

This tends to zero as _N_ increases, but only very slowly. In particular, log( _N_ )(0 _._ 9823) _[N][−]_[1] increases with _N_ up to around _N ≃_ 19, where it attains a maximum value around 2, before decreasing towards zero. The situation is even worse for the sequence capacity, for which the Gaussian theory predicts 

**==> picture [225 x 23] intentionally omitted <==**

S13 

yielding 

**==> picture [273 x 76] intentionally omitted <==**

_N_ (0 _._ 9823) _[N][−]_[1] increases with _N_ up to around _N ≃_ 56, where it attains a value of approximately 21. 

Taken together, these results suggest that we might expect substantial finite-size corrections to the Gaussian theory’s prediction for the capacity. In particular, as the excess kurtosis of the crosstalk is positive, the tails of the crosstalk distribution should be heavier-than-Gaussian, suggesting that the Gaussian theory should overestimate the true capacity. This holds provided that the lower bound on the memorization probability resulting from the union bound is reasonably tight. 

## **D Bounding the polynomial** `DenseNet` **capacity** 

Here, we adapt Demircigil et al. [31]’s proof of a rigorous asymptotic lower bound on the polynomial MHN’s capacity to obtain a rigorous asymptotic lower bound on the DenseNet capacity. This proof is a step-by-step adaptation of the proof of Theorem 1.2 of Demircigil et al. [31], which we spell out in detail for clarity. 

Our objective is to obtain an upper bound on the single-bitflip probability 

**==> picture [398 x 39] intentionally omitted <==**

for 

**==> picture [266 x 39] intentionally omitted <==**

Our goal is to prove the following: First, letting _α >_ 2(2 _d −_ 1)!! and _P_ = _N[d] /_ ( _α_ log _N_ ), we have _N_ P[ _TDN_ ( _**ξ**_[1] )1 = _ξ_ 2[1][]] _[ →]_[0] (D.4) as _N →∞_ . Second, letting _α >_ 2( _d_ + 1)(2 _d −_ 1)!! and _P_ = _N[d] /_ ( _α_ log _N_ ), we have _NP_ P[ _TDN_ ( _**ξ**_[1] )1 = _ξ_ 2[1][]] _[ →]_[0] (D.5) 

as _N →∞_ . 

By Chernoff’s inequality (also known as the exponential Chebyschev inequality) [76], we then have 

**==> picture [329 x 89] intentionally omitted <==**

for any _t >_ 0. Using the fact that the pattern elements are i.i.d., we have 

**==> picture [342 x 93] intentionally omitted <==**

S14 

Now, let 

**==> picture [245 x 31] intentionally omitted <==**

and expand the expectation as a sum over the possible values _m ∈{_ 0 _, ±_ ( _N −_ 1) _[−]_[1] _[/]_[2] _, . . . , ±_ ( _N −_ 1)[1] _[/]_[2] _}_ of _M_ : 

**==> picture [333 x 43] intentionally omitted <==**

For _N ≫_ 1, the distribution of _M_ is nearly Gaussian. We thus split the sum over _m_ to allow us to treat tail events separately. We fix _β >_ 0, and split the sum at log( _N_ ) _[β]_ : 

**==> picture [394 x 70] intentionally omitted <==**

where we have used the fact that _M ≤ √N −_ 1. 

We first consider the tail sum over _|m| >_ log( _N_ ) _[β]_ . As cosh is even and non-decreasing in the modulus of its argument, we have 

**==> picture [302 x 101] intentionally omitted <==**

where in the second line we have applied Hoeffding’s inequality to bound P[ _M >_ log( _N_ ) _[β]_ ] from above, and in the third line we have used the bound cosh( _z_ ) _≤_ exp( _z_ ) for any _z >_ 0. 

We now consider the sum over _|m| ≤_ log( _N_ ) _[β]_ . Using the bound cosh( _z_ ) _≤_ exp( _z_[2] _/_ 2), we have 

**==> picture [398 x 41] intentionally omitted <==**

Using the series expansion of the exponential, we have 

**==> picture [370 x 136] intentionally omitted <==**

S15 

where on the third line we have used the linearity of summation. We will now bound each of the three contributions. The first term is trivially bounded from above by 1: 

**==> picture [248 x 13] intentionally omitted <==**

To handle the second, we first observe that 

**==> picture [277 x 25] intentionally omitted <==**

Then, we observe that as _m_ is the normalized sum of _N −_ 1 Rademacher random variables, its moments tend to those of a standard normal from below as _N →∞_ , and are for any _N_ strictly bounded from above by those of the standard normal. Therefore, we have 

**==> picture [243 x 13] intentionally omitted <==**

To handle the third term, we first use the fact that for any _|m| ≤_ log( _N_ ) _[β]_ we have _m_[2] _[d] ≤_ log( _N_ )[2] _[βd]_ , which gives 

**==> picture [326 x 137] intentionally omitted <==**

At this point, [31] uses the bound 

**==> picture [338 x 29] intentionally omitted <==**

which holds provided that we choose the arbitrary parameter _t_ such that 

**==> picture [256 x 12] intentionally omitted <==**

Assuming that condition is satisfied, we can then combine these results to obtain 

**==> picture [337 x 27] intentionally omitted <==**

**==> picture [336 x 21] intentionally omitted <==**

**==> picture [336 x 49] intentionally omitted <==**

where on the the second line we have used the fact that _e −_ 2 _≃_ 0 _._ 718 _. . . <_ 1 and on the third line we have used the bound 1 + _x ≤_ exp( _x_ ) for _x ≥_ 0. 

Combining this result with the bound on the tail sum obtained previously, we have that 

**==> picture [377 x 70] intentionally omitted <==**

S16 

for any _β >_ 1 _/_ 2 and 

**==> picture [266 x 31] intentionally omitted <==**

Therefore, we have 

**==> picture [393 x 67] intentionally omitted <==**

subject to these conditions on _β_ and _t_ . 

We now want to determine the single-transition and full-sequence capacities. To do so, we fix _α >_ 0, and let _P_ = _N[d] /_ ( _α_ log _N_ ). As _t_ is arbitrary, fix _γ >_ 0, and let _t_ = _γ/P_ . For our choice of _P_ , this gives 

**==> picture [314 x 23] intentionally omitted <==**

which is clearly less than 2 for _N_ sufficiently large. Therefore, we can apply the bound obtained above, which for this choice of _t_ simplifies to 

**==> picture [376 x 83] intentionally omitted <==**

We can see that the first term in the curly braces tends to 1 with increasing _N_ —as its exponent tends to zero—while the second term tends to zero as the term in the round brackets within the exponent is negative for sufficiently large _N_ provided that _β >_ 1 _/_ 2. We may therefore neglect the second term, which gives the simplification 

**==> picture [362 x 25] intentionally omitted <==**

To determine the single-transition capacity under the union bound, we want _N_ P[ _TDN_ ( _**ξ**_[1] )1 = _ξ_ 2[1][]][ to] tend to zero. We have 

**==> picture [379 x 67] intentionally omitted <==**

For this bound to tend to zero, we should have 

As _γ_ is arbitrary, we may let _γ_ = 1 _/_ (2 _d −_ 1)!!, hence the required condition is clearly satisfied if 

**==> picture [234 x 11] intentionally omitted <==**

as predicted by the Gaussian approximation. Next, to determine the sequence capacity, we want _NP_ P[ _TDN_ ( _**ξ**_[1] )1 = _ξ_ 2[1][]][ to tend to zero.][We have] 

**==> picture [397 x 36] intentionally omitted <==**

hence an identical line of reasoning to that used for the single-transition capacity shows that we must have 

**==> picture [249 x 11] intentionally omitted <==**

Again, this agrees with the Gaussian theory. 

S17 

## **E Generalized pseudoinverse rule capacity** 

Here, we show that the generalized pseudoinverse rule can perfectly recall any sequence of linearlyindependent patterns. We recall from (11) that the GPI update rule is 

for 

**==> picture [307 x 87] intentionally omitted <==**

the Gram matrix of the patterns. If the patterns are linearly independent, then **O** is full rank, and the pseudoinverse reduces to the ordinary inverse: **O**[+] = **O** _[−]_[1] . Under this assumption, we have 

**==> picture [299 x 71] intentionally omitted <==**

for all _µ_ and _i_ , hence for separation functions satisfying _f_ (1) _>_ 0 and _|f_ (0) _| < f_ (1) _/_ ( _P −_ 1) we are guaranteed to have _TGP I_ ( _**ξ**[µ]_ ) _i_ = _ξi[µ]_[+1] as desired. For _f_ ( _x_ ) = _x[d]_ , this condition is always satisfied as _f_ (0) = 0 and _f_ (1) = 1. For _f_ ( _x_ ) = _e_[(] _[N][−]_[1)(] _[x][−]_[1)] , we have _f_ (0) = _e[−]_[(] _[N][−]_[1)] and _f_ (1) = 1; the condition _P −_ 1 _< e[N][−]_[1] must therefore be satisfied. However, as _P ≤ N_ is required for linear independence, this condition is satisfied so long as _N >_ 3. 

## **F** `MixedNet` **Capacity** 

In this Appendix, we compute the capacity of the mixed network, which from the update rule defined in (14) has 

**==> picture [391 x 37] intentionally omitted <==**

Then, assuming that _fS_ (1) = _fA_ (1) = 1 as is true for the interaction functions considered here, we have 

P[ _TMN_ ( _**ξ**_[1] )1 = _ξ_ 1[2][]] 

**==> picture [384 x 65] intentionally omitted <==**

where we have defined the crosstalk 

**==> picture [383 x 37] intentionally omitted <==**

For _j_ = 2 _, . . . , N_ and _µ_ = 2 _, . . . , P_ , we have the equality in distribution _ξj[µ][ξ] j_[1] = _d ξjµ_[, hence] 

**==> picture [308 x 32] intentionally omitted <==**

S18 

where to lighten our notation we define 

**==> picture [242 x 31] intentionally omitted <==**

However, unlike in the `DenseNet` , we cannot similarly simplify the terms outside the separation functions. Recalling that we have assumed periodic boundary conditions, we have 

**==> picture [372 x 50] intentionally omitted <==**

where we have defined 

**==> picture [265 x 100] intentionally omitted <==**

Importantly, in this case the influence of _ξ_ 1[1][on][the][crosstalk][is] _[O]_[(1)][,][and][the][distribution][is][not] well-approximated by a single Gaussian. Instead, as shown in Figure F.1, it is bimodal. We will therefore approximate it by a mixture of two Gaussians, one for each value of _ξ_ 1[1][.][This approximation] can be justified by noting that the boundary terms in _C_ 1 and _C_ 2 should be negligible at large _N_ and _P_ , while _C_ 3 and _C_ 4 should give a Gaussian contribution at sufficiently large _P_ . We now observe that, for any _fS_ and _fA_ , the conditional means of each term are 

**==> picture [252 x 44] intentionally omitted <==**

**==> picture [252 x 12] intentionally omitted <==**

where we note that all Ξ _[µ]_ s are identically distributed, so we can simply write Ξ for any one of them. Then, the conditional mean of the crosstalk is 

**==> picture [290 x 47] intentionally omitted <==**

Considering the variance of _C_ , the variances of the different contributions are 

**==> picture [285 x 44] intentionally omitted <==**

**==> picture [285 x 12] intentionally omitted <==**

while the covariances are 

**==> picture [278 x 12] intentionally omitted <==**

**==> picture [278 x 12] intentionally omitted <==**

**==> picture [278 x 13] intentionally omitted <==**

S19 

**==> picture [360 x 253] intentionally omitted <==**

**----- Start of picture text -----**<br>
MixedNet Crosstalk<br>Theory - Sym Sim - Sym<br>1.50 Theory - Asym Sim - Asym<br>Theory - Mixed Sim - Mixed<br>1.25<br>1.00<br>0.75<br>0.50<br>0.25<br>0.00<br>2 1 0 1 2<br>Crosstalk<br>Density<br>**----- End of picture text -----**<br>


Figure F.1: Crosstalk of Polynomial `MixedNet` where _N_ = 100, _λ_ = 2 _._ 5, _dS_ = _dA_ = 3 and _P_ = 1000 patterns are stored. Histograms are generated for patterns drawn from 5000 randomly sequences and theoretical curves are plotted. Green represents the full crosstalk for the `MixedNet` . Blue and red represent the asymmetric and symmetric terms of the crosstalk, respectively. Observe that the bimodality in the full model comes from bimodality in the symmetric term. 

**==> picture [280 x 28] intentionally omitted <==**

and 

**==> picture [312 x 68] intentionally omitted <==**

**==> picture [246 x 11] intentionally omitted <==**

Therefore, the conditional variance of the crosstalk is 

**==> picture [397 x 74] intentionally omitted <==**

**==> picture [352 x 28] intentionally omitted <==**

For large _P_ and _N_ , the two terms on the second line of this result will be subleading, as they do not scale with _P_ and have identical or subleading scaling with _N_ to the terms that do scale with _P_ . That is, we have 

**==> picture [340 x 13] intentionally omitted <==**

S20 

Collecting these results, we have 

**==> picture [289 x 12] intentionally omitted <==**

and 

var[ _C | ξ_ 1[1][]] _[ ∼][P][{]_[E][[] _[f][S]_[(Ξ)][2][] + 2] _[λ]_[E][[] _[f][S]_[(Ξ)]][E][[] _[f][A]_[(Ξ)] +] _[ λ]_[2][E][[] _[f][A]_[(Ξ)][2][]] _[}][.]_ (F.37) By the law of total probability, we have 

**==> picture [378 x 12] intentionally omitted <==**

**==> picture [298 x 55] intentionally omitted <==**

under the bimodal Gaussian approximation to the crosstalk distribution. To have P[ _TMN_ ( _**ξ**_[1] )1 = _ξ_ 1[2][]][,] both of these conditional probabilities must tend to zero. By basic concentration arguments, we expect to have 

**==> picture [228 x 12] intentionally omitted <==**

up to corrections that are small in an absolute sense. Moreover, we have 

**==> picture [312 x 12] intentionally omitted <==**

which for the separation functions considered here is strictly positive. As we keep _λ_ constant with _N_ and _P_ , we must have 

**==> picture [244 x 12] intentionally omitted <==**

and var[ _C | ξ_ 1[1][=] _[−]_[1]] _[→]_[0][in][order][to][have][P][[] _[T][MN]_[(] _**[ξ]**_[1][)][1][=] _[ξ]_ 1[2][]] _[→]_[0][.][But,][given][the][formula] above, var[ _C | ξ_ 1[1][=] _[−]_[1]][=][var[] _[C][ |][ ξ]_ 1[1][=][+1]][, so this implies that the] _[ ξ]_ 1[1][=][+1][ contribution to the] probability will be exponentially suppressed. hen, we can apply an identical argument to that which we used for the `DenseNet` in Appendix C to obtain the asymptotic behavior of P[ _C < −λ | ξ_ 1[1][=] _[ −]_[1]][,] yielding 

**==> picture [384 x 61] intentionally omitted <==**

For this to work, we must clearly have _λ >_ 1. 

We could in principle compute the excess kurtosis of the crosstalk for the `MixedNet` as we did for the `DenseNet` , but we will not do so here as the computation would be tedious and would not yield substantial new insight beyond that for the `DenseNet` . 

## **F.1 Polynomial** `MixedNet` 

We first consider the polynomial mixed network, with _fS_ ( _x_ ) = _x[d][S]_ and _fA_ ( _x_ ) = _x[d][A]_ for two possibly differing degrees _dS, dA ∈_ N _>_ 0. We can apply the same reasoning as in Appendix C.1 to obtain the required moments at large _N_ , which yields the first moments 

**==> picture [326 x 39] intentionally omitted <==**

and 

**==> picture [329 x 39] intentionally omitted <==**

S21 

and the second moments 

and 

**==> picture [310 x 72] intentionally omitted <==**

Then, the conditional mean of the crosstalk is given by 

E[ _C | ξ_ 1[1][]] _[ ∼][ξ]_ 1[1] (F.50) 

up to corrections which vanish in an absolute, not a relative, sense, while the conditional variance is asymptotic to 

**==> picture [389 x 35] intentionally omitted <==**

We must now determine the storage capacity. We recall that, in all case, we want _P_ to tend to infinity slowly enough that var[ _C | ξ_ 1[1][]][ tends to zero.][Then, we can see that what matters is which of the terms] inside the curly brackets in the expression for the conditional variance above tends to zero with _N_ the slowest. This is of course determined by min _{dS, dA}_ , but the constant factor multiplying the leading term will depend on which is smaller, or if they are equal. First, consider the case in which _dS_ = _dA_ = _d_ . Then, we have 

**==> picture [376 x 21] intentionally omitted <==**

Now, consider the case in which _dS < dA_ . Then, ( _dS_ + _dA_ ) _/_ 2 _> dS_ , hence the _N[−][d][S]_ term dominates and we have 

**==> picture [262 x 21] intentionally omitted <==**

Similarly, if _dA > dS_ , the _N[−][d][A]_ term dominates, and we have 

**==> picture [268 x 22] intentionally omitted <==**

We can summarize these results as 

**==> picture [270 x 21] intentionally omitted <==**

where 

**==> picture [366 x 44] intentionally omitted <==**

Using the general arguments presented above, we then have 

**==> picture [389 x 31] intentionally omitted <==**

for any _λ >_ 1. We must first determine the single-transition capacity, which requires that _N_ P[ _TMN_ ( _**ξ**_[1] )1 = _ξ_ 1[2][]] _[→]_[0][.][Recalling][that][our][argument][requires][us][to][take] _[P][→∞]_[slowly] enough that var[ _C | ξ_ 1[1][]] _[ →]_[0][, we make the] _[ Ansatz]_[ that] 

**==> picture [256 x 26] intentionally omitted <==**

S22 

for some _α_ . This yields 

**==> picture [297 x 24] intentionally omitted <==**

which tends to zero if _α ≥_ 2, yielding a predicted capacity of 

**==> picture [260 x 26] intentionally omitted <==**

We now consider the sequence capacity, which requires that _NP_ P[ _TMN_ ( _**ξ**_[1] )1 = _ξ_ 1[2][]] _[→]_[0][.][Then,] making the same _Ansatz_ for _P_ as above, we have 

**==> picture [367 x 26] intentionally omitted <==**

which tends to zero provided that _α ≥_ 2(min _{dS, dA}_ + 1), yielding a predicted capacity of 

**==> picture [297 x 26] intentionally omitted <==**

## **F.2 Exponential** `MixedNet` 

We now consider the Exponential `MixedNet` , with _fS_ ( _x_ ) = _fA_ ( _x_ ) = _e_[(] _[N][−]_[1)(] _[x][−]_[1)] . With this, we have the first moments 

**==> picture [322 x 103] intentionally omitted <==**

and the second moments 

**==> picture [309 x 27] intentionally omitted <==**

where as in Appendix C.2 we let 

**==> picture [251 x 25] intentionally omitted <==**

Noting that 

**==> picture [240 x 25] intentionally omitted <==**

the conditional mean of the crosstalk is then 

**==> picture [322 x 47] intentionally omitted <==**

**==> picture [284 x 12] intentionally omitted <==**

where the corrections are exponentially small in an absolute sense. The leading part of the conditional variance of the crosstalk is 

**==> picture [339 x 73] intentionally omitted <==**

S23 

where we note that 

**==> picture [243 x 26] intentionally omitted <==**

hence the other contribution is exponentially suppressed in a relative sense. 

We thus have 

**==> picture [259 x 39] intentionally omitted <==**

hence from the general argument above we have 

**==> picture [368 x 31] intentionally omitted <==**

for _λ >_ 1. We now want to determine the capacity, starting with the single-transition capacity, for which we must have _N_ P[ _TMN_ ( _**ξ**_[1] )1 = _ξ_ 1[2][]] _[ →]_[0][.][Recalling that we want to have][ var[] _[C][ |][ ξ]_ 1[1][]] _[ →]_[0][, we] make the _Ansatz_ 

**==> picture [246 x 25] intentionally omitted <==**

for some _α_ , which yields 

**==> picture [297 x 23] intentionally omitted <==**

This tends to zero if _α ≥_ 2, hence we conclude that the Gaussian theory predicts 

**==> picture [249 x 25] intentionally omitted <==**

We now want to determine the sequence capacity, which requires that _NP_ P[ _TMN_ ( _**ξ**_[1] )1 = _ξ_ 1[2][]] _[ →]_[0][.] Following our analysis of the Exponential `DenseNet` in Appendix C.2, we make the _Ansatz_ that 

**==> picture [248 x 23] intentionally omitted <==**

which yields 

**==> picture [349 x 25] intentionally omitted <==**

This tends to zero if _α ≥_ 2 log _β_ , giving a predicted sequence capacity of 

**==> picture [260 x 25] intentionally omitted <==**

Thus, for both definitions of capacity, the Gaussian theory’s prediction of the capacity of the Exponential `MixedNet` is 

**==> picture [217 x 23] intentionally omitted <==**

times the capacity of the Exponential `DenseNet` analyzed in Appendix C.2. This factor tends to zero from above as _λ ↓_ 1, and gradually increases to 1 as _λ →∞_ . Note that even without explicitly computing the excess kurtosis, we expect the intuition from the Exponential `DenseNet` to carry over to this setting. Indeed, the numerical simulations in Figure F.2 show that the transition capacity is well captured by the Gaussian theory while the sequence capacity shows significant deviation for small `MixedNet` s. 

S24 

**==> picture [396 x 143] intentionally omitted <==**

**----- Start of picture text -----**<br>
7 7<br>Theory: EMHN Theory: EMHN<br>Simulation: EMHN Simulation: EMHN<br>6 6<br>5 5<br>4 4<br>3 3<br>2 2<br>1 1<br>0 0<br>5 10 15 20 25 5 10 15 20 25<br>Number of Neurons (N) Number of Neurons (N)<br>))(P10T ))(PS10<br>log log<br>Transition Capacity ( Sequence Capacity (<br>**----- End of picture text -----**<br>


Figure F.2: The capacities of Exponential `MixedNet` s with _λ_ = 2 _._ 5 are plotted as a function of network size. (A) Transition capacity for the Exponential `MixedNet` , which closely matches theoretical prediction. The predicted capacity is shown by the solid line with dots, while square error bars show the results of numerical experiment. (B) Sequence capacity for the Exponential `MixedNet` , which diverges from theoretical prediction. 

## **G Numerical implementation** 

Source code is available on GitHub at `https://github.com/Pehlevan-Group/ LongSequenceHopfieldMemory` . Experiments were run on the Harvard University FAS RC Cannon HPC cluster ( `https://www.rc.fas.harvard.edu/` ), using Nvidia A100 80GB GPUs. This limited the maximum number of patterns we could store in memory simultaneously to approximately 10[6] patterns, restricting our experimental evaluation of the Exponential `DenseNet` to approximately _N_ = 25 neurons. 

## **G.1 Transition capacity** 

Numerical simulations for transition capacity were conducted as follows: For a given model of size _N_ , start by initializing 100 sequences of Rademacher distributed patterns of length _P_ 0, where _P_ 0 = 2 _P[∗]_ is well above the model’s predicted capacity _P[∗]_ . This initialization for _P_ 0 was found through trial and error, where the method detects if you start below capacity. The model’s update rule is applied in parallel across all patterns and across all sequences. If errors are made for any pattern in any sequence, 100 new random sequences are generated with smaller length _P_ 1 = 0 _._ 99 _P_ 0. This is repeated, with the new sequence length being _Pt_ +1 = 0 _._ 99 _Pt_ , until 100 sequences are generated for which no error is made in any transition. This entire process is repeated 20 times starting from _P_ 0 in order to obtain error bars. 

## **G.2 Sequence capacity** 

Numerical simulations for sequence capacity were conducted in a similar fashion. For a given model of size _N_ , start by initializing 100 sequences of Rademacher distributed patterns of length _P_ 0, where _P_ 0 is well above the model’s capacity. Starting from the first pattern of each sequence, the model’s update rule is applied serially for each sequence. As soon as an error is obtained within any sequence, 100 new random sequences are generated with smaller length _P_ 1 = 0 _._ 99 _P_ 0. This is repeated, with the new sequence length being _Pt_ +1 = 0 _._ 99 _Pt_ , until 100 sequences are generated for which no error is made. This entire process is repeated 20 times starting from _P_ 0 in order to obtain error bars. 

## **G.3 MovingMNIST** 

For the MovingMNIST experiments in Section 2.4, the images were pre-processed to have binarized pixel values. There were 10000 subsequences, each containing 2 handwritten digits from the MNIST dataset moving through each other across 20 images, that were concatenated to construct the entire sequence of 200000 images [78]. Then, different models were run from initialization and their output for different time steps was displayed in Figure 3. 

S25 

## **G.4 Generalized pseudoinverse rule** 

For numerical simulations of the generalized pseudoinverse rule in 2.5, the transition capacity of the Polynomial `DenseNet` was simulated in a similar method as described above. However, the Exponential `DenseNet` suffered from numerical instability when calculating the pseudoinverse of the overlap matrix, resulting in floating point error. Therefore, we showed results only for the Polynomial `DenseNet` . 

S26 

