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