# Efficiently Modeling Long Sequences with Structured State Spaces 

Albert Gu, Karan Goel, and Christopher R´e 

Department of Computer Science, Stanford University 

_{_ `albertgu,krng` _}_ `@stanford.edu` , `chrismre@cs.stanford.edu` 

## **Abstract** 

A central goal of sequence modeling is designing a single principled model that can address sequence data across a range of modalities and tasks, particularly on long-range dependencies. Although conventional models including RNNs, CNNs, and Transformers have specialized variants for capturing long dependencies, they still struggle to scale to very long sequences of 10000 or more steps. A promising recent approach proposed modeling sequences by simulating the fundamental state space model (SSM) _x[′]_ ( _t_ ) = _Ax_ ( _t_ ) + _Bu_ ( _t_ ) _, y_ ( _t_ ) = _Cx_ ( _t_ ) + _Du_ ( _t_ ), and showed that for appropriate choices of the state matrix _A_ , this system could handle long-range dependencies mathematically and empirically. However, this method has prohibitive computation and memory requirements, rendering it infeasible as a general sequence modeling solution. We propose the Structured State Space sequence model (S4) based on a new parameterization for the SSM, and show that it can be computed much more efficiently than prior approaches while preserving their theoretical strengths. Our technique involves conditioning _A_ with a low-rank correction, allowing it to be diagonalized stably and reducing the SSM to the well-studied computation of a Cauchy kernel. S4 achieves strong empirical results across a diverse range of established benchmarks, including (i) 91% accuracy on sequential CIFAR-10 with no data augmentation or auxiliary losses, on par with a larger 2-D ResNet, (ii) substantially closing the gap to Transformers on image and language modeling tasks, while performing generation 60 _×_ faster (iii) SoTA on every task from the Long Range Arena benchmark, including solving the challenging Path-X task of length 16k that all prior work fails on, while being as efficient as all competitors.[1] 

## **1 Introduction** 

A central problem in sequence modeling is efficiently handling data that contains long-range dependencies (LRDs). Real-world time-series data often requires reasoning over tens of thousands of time steps, while few sequence models address even thousands of time steps. For instance, results from the long-range arena (LRA) benchmark [40] highlight that sequence models today perform poorly on LRD tasks, including one (Path-X) where no model performs better than random guessing. 

Since LRDs are perhaps the foremost challenge for sequence models, all standard model families such as continuous-time models (CTMs), RNNs, CNNs, and Transformers include many specialized variants designed to address them. Modern examples include orthogonal and Lipschitz RNNs [1, 13] to combat vanishing gradients, dilated convolutions to increase context size [3, 28], and an increasingly vast family of efficient Transformers that reduce the quadratic dependence on sequence length [8, 22]. Despite being designed for LRDs, these solutions still perform poorly on challenging benchmarks such as LRA [40] or raw audio classification [18]. 

An alternative approach to LRDs was recently introduced based on the **state space model (SSM)** (Fig. 1). SSMs are a foundational scientific model used in fields such as control theory, computational neuroscience, and many more, but have not been applicable to deep learning for concrete theoretical reasons. In particular, Gu et al. [18] showed that deep SSMs actually struggle even on simple tasks, but can perform exceptionally 

> 1Code is publicly available at `https://github.com/HazyResearch/state-spaces` . 

1 

**==> picture [470 x 150] intentionally omitted <==**

**----- Start of picture text -----**<br>
𝑢 𝑥 𝑦<br>𝐴<br>1 0 0<br>𝐴 = 1 2 0<br>̇𝑥= 𝐴𝑥+ 𝐵𝑢 1 3 3 𝑥= ̅𝐴𝑥+ ,𝐵𝑢 𝑦= 𝐾 [-] ∗𝑢<br>𝑦= 𝐶𝑥+ 𝐷𝑢 𝑦= ̅𝐶𝑥+ -𝐷𝑢<br>Continuous  Long-Range<br>State Space Dependencies Fast Discrete Representations<br>**----- End of picture text -----**<br>


Figure 1: ( **Left** ) State Space Models (SSM) parameterized by matrices _**A** ,_ _**B** ,_ _**C** ,_ _**D**_ map an input signal _u_ ( _t_ ) to output _y_ ( _t_ ) through a latent state _x_ ( _t_ ). ( **Center** ) Recent theory on continuous-time memorization derives special _**A**_ matrices that allow SSMs to capture LRDs mathematically and empirically. ( **Right** ) SSMs can be computed either as a recurrence (left) or convolution (right). However, materializing these conceptual views requires utilizing different representations of its parameters (red, blue, green) which are very expensive to compute. S4 introduces a novel parameterization that efficiently swaps between these representations, allowing it to handle a wide range of tasks, be efficient at both training and inference, and excel at long sequences. 

well when equipped with special state matrices _**A**_ recently derived to solve a problem of continuous-time memorization [16, 45]. Their Linear State Space Layer (LSSL) conceptually unifies the strengths of CTM, RNN and CNN models, and provides a proof of concept that deep SSMs can address LRDs in principle. 

Unfortunately, the LSSL is infeasible to use in practice because of prohibitive computation and memory requirements induced by the state representation. For state dimension _N_ and sequence length _L_ , computing the latent state requires _O_ ( _N_[2] _L_ ) operations and _O_ ( _NL_ ) space – compared to a Ω( _L_ + _N_ ) lower bound for both. Thus for reasonably sized models (e.g. _N_ = 256 in Gu et al. [18]), the LSSL uses orders of magnitude more memory than comparably-sized RNNs or CNNs. Although theoretically efficient algorithms for the LSSL were proposed, we show that these are numerically unstable. In particular, the special _**A**_ matrix is highly non-normal in the linear algebraic sense, which prevents the application of conventional algorithmic techniques. Consequently, although the LSSL showed that SSMs have strong performance, they are currently computationally impractical as a general sequence modeling solution. 

In this work, we introduce the **Structured State Space (S4)** sequence model based on the SSM that solves the critical computational bottleneck in previous work. Technically, S4 reparameterizes the structured state matrices _**A**_ appearing in Gu et al. [16], Voelker et al. [45] by decomposing them as the sum of a low-rank and normal term. Additionally, instead of expanding the standard SSM in coefficient space, we compute its truncated generating function in frequency space, which can be simplified into a multipole-like evaluation. Combining these two ideas, we show that the low-rank term can be corrected by the Woodbury identity while the normal term can be diagonalized stably, ultimately reducing to a well-studied and theoretically stable Cauchy kernel [29, 30]. This results in _O_[˜] ( _N_ + _L_ ) computation and _O_ ( _N_ + _L_ ) memory usage, which is essentially tight for sequence models. Compared to the LSSL, S4 is up to 30 _×_ faster with 400 _×_ less memory usage, while exceeding the LSSL’s performance empirically. 

Empirically, S4 significantly advances the state-of-the-art for LRD. On the LRA benchmark for efficient sequence models, S4 is as fast as all baselines while outperforming them by 20+ points on average. S4 is the first model to solve the difficult LRA Path-X task (length-16384), achieving **88% accuracy compared to 50% random guessing** for all prior work. On speech classification with length-16000 sequences, S4 halves the test error (1 _._ 7%) of specialized Speech CNNs – by contrast, all RNN and Transformer baselines fail to learn ( _≥_ 70% error). 

**Towards a general-purpose sequence model.** Beyond LRD, a broad goal of machine learning is to develop a single model that can be used across a wide range of problems. Models today are typically 

2 

specialized to solve problems from a particular domain (e.g. images, audio, text, time-series), and enable a narrow range of capabilities (e.g. efficient training, fast generation, handling irregularly sampled data). This specialization is typically expressed via domain-specific preprocessing, inductive biases, and architectures. Sequence models provide a general framework for solving many of these problems with reduced specialization – e.g. Vision Transformers for image classification with less 2D information [12]. However, most models such as Transformers generally still require substantial specialization per task to achieve high performance. 

Deep SSMs in particular have conceptual strengths that suggest they may be promising as a general sequence modeling solution. These strengths include a principled approach to handling LRDs, as well as the ability to move between continuous-time, convolutional, and recurrent model representations, each with distinct capabilities (Fig. 1). Our technical contributions enable SSMs to be applied successfully to a varied set of benchmarks with minimal 

- _Large-scale generative modeling._ On CIFAR-10 density estimation, S4 is competitive with the best autoregressive models (2 _._ 85 bits per dim). On WikiText-103 language modeling, S4 substantially closes the gap to Transformers (within 0 _._ 8 perplexity), setting SoTA for attention-free models. 

- _Fast autoregressive generation._ Like RNNs, S4 can use its latent state to perform 60 _×_ faster pixel/token generation than standard autoregressive models on CIFAR-10 and WikiText-103. 

- _Sampling resolution change._ Like specialized CTMs, S4 can adapt to changes in time-series sampling frequency without retraining, e.g. at 0 _._ 5 _×_ frequency on speech classification. 

- _Learning with weaker inductive biases._ With no architectural changes, S4 surpasses Speech CNNs on speech classification, outperforms the specialized Informer model on time-series forecasting problems, and matches a 2-D ResNet on sequential CIFAR with over 90% accuracy. 

## **2 Background: State Spaces** 

Sections 2.1 to 2.4 describe the four properties of SSMs in Fig. 1: the classic continuous-time representation, addressing LRDs with the HiPPO framework, the discrete-time recurrent representation, and the parallelizable convolution representation. In particular, Section 2.4 introduces the SSM convolution kernel _**K**_ , which is the focus of our theoretical contributions in Section 3. 

## **2.1 State Space Models: A Continuous-time Latent State Model** 

The state space model is defined by the simple equation (1). It maps a 1-D input signal _u_ ( _t_ ) to an _N_ -D latent state _x_ ( _t_ ) before projecting to a 1-D output signal _y_ ( _t_ ). 

**==> picture [284 x 26] intentionally omitted <==**

SSMs are broadly used in many scientific disciplines and related to latent state models such as Hidden Markov Models (HMM). Our goal is to simply use the SSM as a black-box representation in a deep sequence model, where _**A** ,_ _**B** ,_ _**C** ,_ _**D**_ are parameters learned by gradient descent. For the remainder of this paper, we will omit the parameter _**D**_ for exposition (or equivalently, assume _**D**_ = 0) because the term _**D** u_ can be viewed as a skip connection and is easy to compute. 

## **2.2 Addressing Long-Range Dependencies with HiPPO** 

Prior work found that the basic SSM (1) actually performs very poorly in practice. Intuitively, one explanation is that linear first-order ODEs solve to an exponential function, and thus may suffer from gradients scaling exponentially in the sequence length (i.e., the vanishing/exploding gradients problem [32]). To address this 

3 

problem, the LSSL leveraged the HiPPO theory of continuous-time memorization [16]. HiPPO specifies a class of certain matrices _**A** ∈_ R _[N][×][N]_ that when incorporated into (1), allows the state _x_ ( _t_ ) to memorize the history of the input _u_ ( _t_ ). The most important matrix in this class is defined by equation (2), which we will call the HiPPO matrix. For example, the LSSL found that simply modifying an SSM from a random matrix _**A**_ to equation (2) improved its performance on the sequential MNIST benchmark from 60% to 98%. 

**==> picture [385 x 43] intentionally omitted <==**

## **2.3 Discrete-time SSM: The Recurrent Representation** 

To be applied on a discrete input sequence ( _u_ 0 _, u_ 1 _, . . ._ ) instead of continuous function _u_ ( _t_ ), (1) must be discretized by a **step size** ∆that represents the resolution of the input. Conceptually, the inputs _uk_ can be viewed as sampling an implicit underlying continuous signal _u_ ( _t_ ), where _uk_ = _u_ ( _k_ ∆). 

To discretize the continuous-time SSM, we follow prior work in using the bilinear method [43], which converts the state matrix _**A**_ into an approximation _**A**_ . The discrete SSM is 

**==> picture [386 x 29] intentionally omitted <==**

Equation (3) is now a _sequence-to-sequence_ map _uk �→ yk_ instead of function-to-function. Moreover the state equation is now a recurrence in _xk_ , allowing the discrete SSM to be computed like an RNN. Concretely, _xk ∈_ R _[N]_ can be viewed as a _hidden state_ with transition matrix _**A**_ . 

Notationally, throughout this paper we use _**A** ,_ _**B** , . . ._ to denote discretized SSM matrices defined by (3). Note that these matrices are a function of both _**A**_ as well as a step size ∆; we suppress this dependence for notational convenience when it is clear. 

## **2.4 Training SSMs: The Convolutional Representation** 

The recurrent SSM (3) is not practical for training on modern hardware due to its sequentiality. Instead, there is a well-known connection between linear time-invariant (LTI) SSMs such as (1) and continuous convolutions. Correspondingly, (3) can actually be written as a discrete convolution. 

For simplicity let the initial state be _x−_ 1 = 0. Then unrolling (3) explicitly yields 

**==> picture [408 x 33] intentionally omitted <==**

This can be vectorized into a convolution (4) with an explicit formula for the convolution kernel (5). 

**==> picture [362 x 31] intentionally omitted <==**

**==> picture [397 x 21] intentionally omitted <==**

In other words, equation (4) is a single (non-circular) convolution and can be computed very efficiently with FFTs, _provided_ that _**K**_ is known. However, computing _**K**_ in (5) is non-trivial and is the focus of our technical contributions in Section 3. We call _**K**_ the **SSM convolution kernel** or filter. 

4 

## **3 Method: Structured State Spaces (S4)** 

Our technical results focus on developing the S4 parameterization and showing how to efficiently compute all views of the SSM (Section 2): the continuous representation ( _**A** ,_ _**B** ,_ _**C**_ ) (1), the recurrent representation ( _**A** ,_ _**B** ,_ _**C**_ ) (3), and the convolutional representation _**K**_ (4). 

Section 3.1 motivates our approach, which is based on the linear algebraic concepts of conjugation and diagonalization, and discusses why the naive application of this approach does not work. Section 3.2 gives an overview of the key technical components of our approach and formally defines the S4 parameterization. Section 3.3 sketches the main results, showing that S4 is asymptotically efficient (up to log factors) for sequence models. Proofs are in Appendices B and C. 

## **3.1 Motivation: Diagonalization** 

The fundamental bottleneck in computing the discrete-time SSM (3) is that it involves repeated matrix multiplication by _**A**_ . For example, computing (5) naively as in the LSSL involves _L_ successive multiplications by _**A**_ , requiring _O_ ( _N_[2] _L_ ) operations and _O_ ( _NL_ ) space. 

To overcome this bottleneck, we use a structural result that allows us to simplify SSMs. 

**Lemma 3.1.** _Conjugation is an equivalence relation on SSMs_ ( _**A** ,_ _**B** ,_ _**C**_ ) _∼_ ( _**V**[−]_[1] _**AV** ,_ _**V**[−]_[1] _**B** ,_ _**CV**_ ) _._ 

_Proof._ Write out the two SSMs with state denoted by _x_ and _x_ ˜ respectively: 

**==> picture [274 x 26] intentionally omitted <==**

After multiplying the right side SSM by _**V**_ , the two SSMs become identical with _x_ = _**V** x_ ˜. Therefore these compute the exact same operator _u �→ y_ , but with a change of basis by _**V**_ in the state _x_ . 

Lemma 3.1 motivates putting _**A**_ into a canonical form by conjugation[2] , which is ideally more structured and allows faster computation. For example, if _**A**_ were diagonal, the resulting computations become much more tractable. In particular, the desired _**K**_ (equation (4)) would be a **Vandermonde product** which theoretically only needs _O_ (( _N_ + _L_ ) log[2] ( _N_ + _L_ )) arithmetic operations [29]. 

Unfortunately, the naive application of diagonalization does not work due to numerical issues. Werive the explicit diagonalization for the HiPPO matrix (2) and show it has entries exponentially large in the state size _N_ , rendering the diagonalization numerically infeasible (e.g. _**CV**_ in Lemma 3.1 would not be computable). We note that Gu et al. [18] proposed a different (unimplemented) algorithm to compute _**K**_ faster than the naive algorithm. In Appendix B, we prove that it is also numerically unstable for related reasons. 

**Lemma 3.2.** _The HiPPO matrix_ _**A** in equation_ (2) _is diagonalized by the matrix_ _**V** ij_ = � _ii−_ + _jj_ � _. In particular,_ 4 _i_ _**V**_ 3 _i,i_ = �2 _i_ � _≈_ 2[4] _[i] . Therefore_ _**V** has entries of magnitude up to_ 2[4] _[N/]_[3] _._ 

## **3.2 The S4 Parameterization: Normal Plus Low-Rank** 

The previous discussion implies that we should only conjugate by well-conditioned matrices _**V**_ . The ideal scenario is when the matrix _**A**_ is diagonalizable by a perfectly conditioned (i.e., unitary) matrix. By the Spectral Theorem of linear algebra, this is exactly the class of **normal matrices** . However, this class of matrices is restrictive; in particular, it does not contain the HiPPO matrix (2). 

We make the observation that although the HiPPO matrix is not normal, it can be decomposed as the _sum of a normal and low-rank matrix_ . However, this is still not useful by itself: unlike a diagonal matrix, powering up this sum (in (5)) is still slow and not easily optimized. We overcome this bottleneck by simultaneously applying three new techniques. 

> 2Note that although we ultimately require _**A**_ , conjugation commutes with discretization so we refer to _**A**_ . 

5 

**Algorithm 1** S4 Convolution Kernel (Sketch) 

**Input:** S4 parameters **Λ** _,_ _**P** ,_ _**Q** ,_ _**B** ,_ _**C** ∈_ C _[N]_ and step size ∆ **Output:** SSM convolution kernel _**K**_ = _KL_ ( _**A** ,_ _**B** ,_ _**C**_ ) for _**A**_ = **Λ** _−_ _**P Q**[∗]_ (equation (5)) ~~_L_~~[�] _[∗]_ 1: _**C**_[�] _←_ _**I** −_ _**A C** ▷_ Truncate SSM generating function (SSMGF) to length _L_ � _k_ 00( _ω_ ) _k_ 01( _ω_ ) � _∗_ 2 1 _−ω −_ 1 2: � _k_ 10( _ω_ ) _k_ 11( _ω_ )� _←_ � _**C Q**_ � � ∆ 1+ _ω[−]_ **[Λ]** � [ _**B P**_ ] _▷_ Black-box Cauchy kernel 3: _**K**_ **[ˆ]** ( _ω_ ) _←_ 1+2 _ω_ � _k_ 00( _ω_ ) _− k_ 01( _ω_ )(1 + _k_ 11( _ω_ )) _[−]_[1] _k_ 10( _ω_ )� _▷_ Woodbury Identity 4: _**K**_ **[ˆ]** = _{_ _**K**_ **[ˆ]** ( _ω_ ) : _ω_ = exp(2 _πi L[k]_[)] _[}] ▷_ Evaluate SSMGF at all roots of unity _ω ∈_ Ω _L_ 5: _**K** ←_ iFFT( _**K**_ **[ˆ]** ) _▷_ Inverse Fourier Transform 

- Instead of computing _**K**_ directly, we compute its spectrum by evaluating its **truncated generating function**[�] _[L] j_ =0 _[−]_[1] _**K** jζ[j]_ at the roots of unity _ζ_ . _**K**_ can then be found by applying an inverse FFT. 

- This generating function is closely related to the matrix resolvent, and now involves a matrix _inverse_ instead of _power_ . The low-rank term can now be corrected by applying the **Woodbury identity** which reduces ( _**A**_ + _**P Q**[∗]_ ) _[−]_[1] in terms of _**A**[−]_[1] , truly reducing to the diagonal case. 

- Finally, we show that the diagonal matrix case is equivalent to the computation of a **Cauchy kernel** 1 

- _ωj −ζk_[,][a][well-studied][problem][with][stable][near-linear][algorithms][[30,][31].] 

Our techniques apply to any matrix that can be decomposed as _**Normal Plus Low-Rank (NPLR)**_ . 

**Theorem 1.** _All HiPPO matrices from [16] have a NPLR representation_ 

**==> picture [348 x 12] intentionally omitted <==**

_for unitary_ _**V** ∈_ C _[N][×][N] , diagonal_ **Λ** _, and low-rank factorization_ _**P** ,_ _**Q** ∈_ R _[N][×][r] . These matrices HiPPO- LegS, LegT, LagT all satisfy r_ = 1 _or r_ = 2 _. In particular, equation_ (2) _is NPLR with r_ = 1 _._ 

## **3.3 S4 Algorithms and Computational Complexity** 

By equation (6), note that NPLR matrices can be conjugated into _diagonal plus low-rank_ (DPLR) form (now over C instead of R ). Theorems 2 and 3 describe the complexities of SSMs where _**A**_ is in DPLR form. S4 is optimal or near-optimal for both recurrent and convolutional representations. 

**Theorem 2** (S4 Recurrence) **.** _Given any step size_ ∆ _, computing one step of the recurrence_ (3) _can be done in O_ ( _N_ ) _operations where N is the state size._ 

Theorem 2 follows from the fact that the inverse of a DPLR matrix is also DPLR (e.g. also by the Woodbury identity). This implies that the discretized matrix _**A**_ is the product of two DPLR matrices and thus has _O_ ( _N_ ) matrix-vector multiplication. Appendix C.2 computes _**A**_ in closed DPLR form. 

**Theorem 3** (S4 Convolution) **.** _Given any step size_ ∆ _, computing the SSM convolution filter_ _**K** can be reduced to 4 Cauchy multiplies, requiring only O_[�] ( _N_ + _L_ ) _operations and O_ ( _N_ + _L_ ) _space._ 

Appendix C, Definition 3 formally defines Cauchy matrices, which are related to rational interpolation problems. Computing with Cauchy matrices is an extremely well-studied problem in numerical analysis, with both fast arithmetic and numerical algorithms based on the famous Fast Multipole Method (FMM) [29, 30, 31]. The computational complexities of these algorithms under various settings are described in Appendix C, Proposition 5. 

We reiterate that Theorem 3 is our core technical contribution, and its algorithm is the very motivation of the NPLR S4 parameterization. This algorithm is formally sketched in Algorithm 1. 

6 

Table 1: Complexity of various sequence models in terms of sequence length ( _**L**_ ), batch size ( _**B**_ ), and hidden dimension ( _**H**_ ); tildes denote log factors. Metrics are parameter count, training computation, training space requirement, training parallelizability, and inference computation (for 1 sample and time-step). For simplicity, the state size _N_ of S4 is tied to _H_ . Bold denotes model is theoretically best for that metric. Convolutions are efficient for training while recurrence is efficient for inference, while SSMs combine the strengths of both. 

||Convolution3|Recurrence|Attention|S4||
|---|---|---|---|---|---|
|Parameters|_LH_|**_H_2**|**_H_2**|**_H_2**||
|Training|**˜****_LH_(****_B_ +****_H_)**|_BLH_2|_B_(_L_2_H_ +_LH_2)|**_BH_( **|**˜**<br>**_H_ + ˜****_L_) +****_B_ ˜****_LH_**|
|Space|**_BLH_**|**_BLH_**|_B_(_L_2 +_HL_)|**_BLH_**||
|Parallel|**Yes**|No|**Yes**|**Yes**||
|Inference|_LH_2|**_H_2**|_L_2_H_ +_H_2_L_|**_H_2**||



## **3.4 Architecture Details of the Deep S4 Layer** 

Concretely, an S4 layer is parameterized as follows. First initialize a SSM with _**A**_ set to the HiPPO matrix (2). By Lemma 3.1 and Theorem 1, this SSM is unitarily equivalent to some ( **Λ** _−_ _**P Q**[∗] ,_ _**B** ,_ _**C**_ ) for some diagonal **Λ** and vectors _**P** ,_ _**Q** ,_ _**B** ,_ _**C** ∈_ C _[N][×]_[1] . These comprise S4’s 5 _N_ trainable parameters. 

The overall deep neural network (DNN) architecture of S4 is similar to prior work. As defined above, S4 defines a map from R _[L] →_ R _[L]_ , i.e. a 1-D sequence map. Typically, DNNs operate on feature maps of size _H_ instead of 1. S4 handles multiple features by simply defining _H_ independent copies of itself, and then mixing the _H_ features with a position-wise linear layer for a total of _O_ ( _H_[2] )+ _O_ ( _HN_ ) parameters per layer. Nonlinear activation functions are also inserted between these layers. Overall, S4 defines a sequence-to-sequence map of shape (batch size, sequence length, hidden dimension), exactly the same as related sequence models such as Transformers, RNNs, and CNNs. 

Note that the core S4 module is a linear transformation, but the addition of non-linear transformations through the depth of the network makes the overall deep SSM non-linear. This is analogous to a vanilla CNN, since convolutional layers are also linear. The broadcasting across _H_ hidden features described in this section is also analogous to depthwise-separable convolutions. Thus, the overall deep S4 model is closely related to a depthwise-separable CNN but with _global_ convolution kernels. 

Finally, we note that follow-up work found that this version of S4 can sometimes suffer from numerical instabilities when the _**A**_ matrix has eigenvalues on the right half-plane [14]. It introduced a slight change to the NPLR parameterization for S4 from **Λ** _−_ _**P Q**[∗]_ to **Λ** _−_ _**P P**[∗]_ that corrects this potential problem. 

Table 1 compares the complexities of the most common deep sequence modeling mechanisms. 

## **4 Experiments** 

Section 4.1 benchmarks S4 against the LSSL and efficient Transformer models. Section 4.2 validates S4 on LRDs: the LRA benchmark and raw speech classification. Section 4.3 investigates whether S4 can be used as a general sequence model to perform effectively and efficiently in a wide variety of settings including image classification, image and text generation, and time series forecasting. 

## **4.1 S4 Efficiency Benchmarks** 

We benchmark that S4 can be trained quickly and efficiently, both compared to the LSSL, as well as efficient Transformer variants designed for long-range sequence modeling. As outlined in Section 3, S4 is theoretically much more efficient than the LSSL, and Table 2 confirms that the S4 is orders of magnitude more speed- and memory-efficient for practical layer sizes. In fact, S4’s speed and memory use is competitive with the most 

> 3Refers to global (in the sequence length) and depthwise-separable convolutions, similar to the convolution version of S4. 

7 

Table 2: Deep SSMs: The S4 parameterization with Algorithm 1 Table 3: Benchmarks vs. efficient Transformers is asymptotically more efficient than the LSSL. 

|||||||||Length|1024|Length|4096|
|---|---|---|---|---|---|---|---|---|---|---|---|
||Training Step (ms)|||Memory Alloc. (MB)||||Speed|Mem.|Speed|Mem.|
|Dim.|128|256|512|128|256|512|Transformer|1_×_|1_×_|1_×_|1_×_|
|LSSL|9.32|20.6|140.7|222.1|1685|13140|Performer|1.23_×_|0.43<br>_×_|3.79_×_|0.086<br>_×_|
|**S4**|4.77|3.07|4.75|5.3|12.6|33.5|Linear Trans.|**1.58**_×_|**0.37**_×_|**5.35**_×_|**0.067**_×_|
|Ratio|1_._9_×_|6_._7_×_|**29****_._6**_×_|42_._0_×_|133_×_|**392****_×_**|**S4**|**1.58**_×_|0.43<br>_×_|5.19<br>_×_|0.091_×_|



Figure 2: Visualizations of a trained S4 model on LRA Path-X. SSM convolution kernels _**K** ∈_ R[16384] are reshaped into a 128 _×_ 128 image. ( _Left_ ) Example from the Path-X task, which involves deducing if the markers are connected by a path ( _Top_ ) Filters from the first layer ( _Bottom_ ) Filters from the last layer. 

Table 4: ( **Long Range Arena** ) ( _Top_ ) Original Transformer variants in LRA. Full results in Appendix D.2. ( _Bottom_ ) Other models reported in the literature. _Please read Appendix D.5 before citing this table._ 

|Model|ListOps|Text|Retrieval|Image|Pathfinder|Path-X|Avg|
|---|---|---|---|---|---|---|---|
|Transformer|36.37|64.27|57.46|42.44|71.40||53.66|
|Reformer|37.27|56.10|53.40|38.07|68.50||50.56|
|BigBird|36.05|64.02|59.29|40.83|74.87||54.17|
|Linear Trans.|16.13|65.90|53.09|42.34|75.30||50.46|
|Performer|18.01|65.40|53.82|42.77|77.05||51.18|
|FNet|35.33|65.11|59.61|38.67|77.80||54.42|
|Nystr¨omformer|37.15|65.52|79.56|41.58|70.94||57.46|
|Luna-256|37.25|64.57|79.29|47.38|77.72||59.37|
|**S4**|**59.60**|**86.82**|**90.90**|**88.65**|**94.20**|**96.35**|**86.09**|



efficient Transformer variants benchmarked by Tay et al. [40]—Linear Transformer [22] and Performer [8]—in a parameter-matched setting (Table 3, following the protocol of Tay et al. [40]). 

## **4.2 Learning Long Range Dependencies** 

As described in Sections 2.2 and 3.1, S4 uses a principled approach to address LRDs based on the HiPPO theory of continuous-time memorization. Our goal in this section is to validate that S4 achieves high performance on difficult tasks that require long-range reasoning. We focus here on two problems: (i) the Long-Range Arena, a well-known benchmark designed to test efficient sequence models on LRDs, and (ii) a speech classification problem as a real-world test of LRDs. 

**Long Range Arena (LRA).** LRA [40] contains 6 tasks with lengths 1K-16K steps, encompassing modalities 

8 

and objectives that require similarity, structural, and visuospatial reasoning. Table 4 compares S4 against the 11 Transformer variants from Tay et al. [40] as well as follow-up work. S4 substantially advances the SoTA, outperforming all baselines on all tasks and averaging 80 _._ 48% compared to less than 60% for every baseline. Notably, S4 solves the Path-X task, an extremely challenging task that involves reasoning about LRDs over sequences of length 128 _×_ 128 = 16384. All previous models have failed (i.e. random guessing) due to memory or computation bottlenecks, or simply being unable to learn such long dependencies. 

We analyze S4’s performance on Path-X by visualizing its learned representations, in particular 1-D convolution kernels _**K**_ which are the focus of our technical results in Section 3. Fig. 2 shows that S4 learns a variety of filters that display spatially consistent structure and demonstrate awareness of the 2-D nature of the data. In particular, the lower layers learn simple kernels that extract features from just a few rows of local context while ignoring the rest of the image. On the other hand, higher layers aggregate information globally across full columns of the image at varying spatial frequencies. Filters in these higher layers span the entire context (16384 pixels), confirming S4’s ability to learn LRDs. 

**Raw Speech Classification.** Speech is a typical real-world time series domain, involving signals sampled from an underlying physical process at high frequency. We perform speech classification using the SC10 subset of the _Speech Commands_ dataset [47] (see Appendix D.5). While most sequence models for speech rely on extensive preprocessing (e.g. to MFCC features), we classify raw speech (length-16000) following Romero et al. [35]. S4 achieves 98 _._ 3% accuracy, higher than all baselines that use the 100 _×_ shorter MFCC features, and validates that a powerful LRD model is able to extract more information from the raw data and outperform hand-crafted pre-processing. Additionally, we include a baseline CNN specifically designed for raw speech, the discriminator from the WaveGAN model [11], which performs worse than S4 while having 90 _×_ more parameters and incorporating many more architectural heuristics (Appendix D.2). 

## **4.3 S4 as a General Sequence Model** 

A key goal of sequence modeling research is to develop a single model that can be applied in many domains (e.g. images, audio, text, time-series) with a broad range of capabilities (e.g. efficient training, fast generation, handling irregularly sampled data). As a fundamental scientific model, SSMs are a promising candidate that come with a range of capabilities, and S4’s strong results on LRD benchmarks spanning images, text, and speech are evidence of S4’s potential as a general sequence model. In this section, we focus on understanding this question in more depth by highlighting key strengths of S4 in settings that usually require specialized 

Table 5: ( **SC10 classification** ) Transformer, CTM, RNN, CNN, and SSM models. ( _MFCC_ ) Standard preprocessed MFCC features (length 161). ( _Raw_ ) Unprocessed signals (length 16000). ( _0 .5 ×_ ) Frequency change at test time. denotes not applicable or computationally infeasible on single GPU. _Please read Appendix D.5 before citing this table._ 

||MFCC|Raw|0_._5_×_|
|---|---|---|---|
|Transformer<br>Performer|90.75<br>80.85|<br>30.77|<br>30.68|
|ODE-RNN<br>NRDE|65.9<br>89.8|<br>16.49|<br>15.12|
|ExpRNN<br>LipschitzRNN|82.13<br>88.38|11.6<br>|10.8<br>|
|CKConv<br>WaveGAN-D|**95.3**<br>|71.66<br>96.25|65.96<br>|
|LSSL<br>**S4**|93.58<br>93.96|<br>**98.32**|<br>**96.30**|



Table 6: ( **Pixel-level 1-D image classification** ) Comparison against reported test accuracies from prior works (Transformer, RNN, CNN, and SSM models). Extended results and citations in Appendix D. 

||sMNIST<br>pMNIST|sCIFAR|
|---|---|---|
|Transformer|98.9<br>97.9|62.2|
|LSTM<br>r-LSTM<br>UR-LSTM<br>UR-GRU<br>HiPPO-RNN<br>LMU-FFT<br>LipschitzRNN|98.9<br>95.11<br>98.4<br>95.2<br>99.28<br>96.96<br>99.27<br>96.51<br>98.9<br>98.3<br>-<br>98.49<br>99.4<br>96.3|63.01<br>72.2<br>71.00<br>74.4<br>61.1<br>-<br>64.2|
|TCN<br>TrellisNet<br>CKConv|99.0<br>97.2<br>99.20<br>98.13<br>99.32<br>98.54|-<br>73.42<br>63.74|
|LSSL<br>**S4**|99.53<br>**98.76**<br>**99.63**<br>98.70|84.65<br>**91.13**|



9 

Table 7: ( **CIFAR-10 density estimation** ) As a generic Table 8: ( **WikiText-103 language modeling** ) S4 apsequence model, S4 is competitive with previous autoregressive proaches the performance of Transformers with much models (in bits per dim.) while incorporating no 2D inductive faster generation. ( _Top_ ) Transformer baseline which our bias, and has fast generation through its recurrence mode. implementation is based on, with attention replaced by S4. ( _Bottom_ ) Attention-free models (RNNs and CNNs). 

|Model<br>bpd<br>2D bias|Images / sec<br>0.32 (1_×_)<br>17.85 (56_×_)<br>-<br>-<br>19.19<br>(59_._97_×_)<br>0.54 (1.7_×_)<br>0.13 (0.4_×_)<br>-<br>**20.84** (**65****_._1****_×_**)<br>3.36 (10_._5_×_)||
|---|---|---|
|Transformer<br>3.47<br>**None**<br>Linear Transf.<br>3.40<br>**None**<br>PixelCNN<br>3.14<br>2D conv.<br>Row PixelRNN<br>3.00<br>2D BiLSTM<br>PixelCNN++<br>2.92<br>2D conv.<br>Image Transf.<br>2.90<br>2D local attn.<br>PixelSNAIL<br>2.85<br>2D conv. + attn.<br>Sparse Transf.<br>**2.80**<br>2D sparse attn.||Model<br>Params<br>Test ppl.<br>Tokens / sec|
|||Transformer<br>247M<br>**20.51**<br>0.8K (1_×_)|
|||GLU CNN<br>229M<br>37.2<br>-<br>AWD-QRNN<br>151M<br>33.0<br>-<br>LSTM + Hebb.<br>-<br>29.2<br>-<br>TrellisNet<br>180M<br>29.19<br>-<br>Dynamic Conv.<br>255M<br>25.0<br>-<br>TaLK Conv.<br>240M<br>23.3<br>-<br>**S4**<br>249M<br>**20.95**<br>**48K** (**60****_×_**)|
|**S4** (base)<br>2.92<br>**None**<br>**S4** (large)<br>2.85<br>**None**|||



models. The tasks we focus on (generative modeling, image classification, time-series forecasting) are considered as LRD tasks in the literature, and serve as additional validation that S4 handles LRDs efficiently. 

**Large-scale generative modeling.** We investigate two well-studied image and text benchmarks to validate the scalability, flexibility, and efficiency of S4. These tasks require much larger models than our previous tasks – up to 250M parameters. 

First, CIFAR density estimation is a popular benchmark for autoregressive models, where images are flattened into a sequence of 3072 RGB subpixels that are predicted one by one. Table 7 shows that _with no 2D inductive bias_ , S4 is competitive with the best models designed for this task. 

Second, WikiText-103 is an established benchmark for language modeling, an important task for large-scale sequence models where tokens are predicted sequentially based on past context. Although RNNs were the model of choice for many years, Transformers are now the dominant model in such applications that contain data that is inherently discrete. We show that alternative models to Transformers can still be competitive in these settings. By simply taking a strong Transformer baseline [2] and replacing the self-attention layers, S4 substantially closes the gap to Transformers (within 0 _._ 8 ppl), setting SoTA for attention-free models by over 2 ppl. 

**Fast autoregressive inference.** A prominent limitation of autoregressive models is inference speed (e.g. generation), since they require a pass over the full context for every new sample. Several methods have been specifically crafted to overcome this limitation such as the Linear Transformer, a hybrid Transformer/RNN that switches to a stateful, recurrent view at inference time for speed. 

As a stateful model, SSMs automatically have this ability (Fig. 1). By switching to its recurrent representation (Section 2.3), S4 requires _constant memory and computation_ per time step – in contrast to standard autoregressive models which scale in the context length. On both CIFAR-10 and WikiText-103, we report the throughput of various models at generation time, with S4 around 60 _×_ faster than a vanilla Transformer on both tasks (details in Appendix D.3.3). 

**Sampling resolution change.** As a continuous-time model, S4 automatically adapts to data sampled at different rates, a challenging setting for time series with a dedicated line of work [10, 35, 37]. Without re-training, S4 achieves 96 _._ 3% accuracy at 0 _._ 5 _×_ the frequency on Speech Commands 10 (Table 5), simply by changing its internal step size ∆(Section 2.3). 

**Learning with weaker inductive bias.** Beyond our results on speech (Section 4.2), we further validate that S4 can be applied with minimal modifications on two domains that typically require specialized domainspecific preprocessing and architectures. First, we compare S4 to the Informer [50], a new Transformer architecture that uses a complex encoder-decoder designed for time-series forecasting problems. A simple application of S4 that treats forecasting as a masked sequence-to-sequence transformation (Fig. 5) outperforms the Informer and other baselines on 40 _/_ 50 settings across 5 forecasting tasks. Notably, S4 is better on the 

10 

longest setting in each task, e.g. reducing MSE by 37% when forecasting 30 days of weather data (Table 9). 

Finally, we evaluate S4 on pixel-level sequential image classification tasks (Table 6), popular benchmarks which were originally LRD tests for RNNs [1]. Beyond LRDs, these benchmarks point to a recent effort of the ML community to solve vision problems with reduced domain knowledge, in the spirit of models such as Vision Transformers [12] and MLP-Mixer [41] which involve patch-based models that without 2-D inductive bias. Sequential CIFAR is a particularly challenging dataset where outside of SSMs, all sequence models have a gap of over 25% to a simple 2-D CNN. By contrast, S4 is competitive with a larger ResNet18 (7.9M vs. 11.0M parameters), both with ( **93.16%** vs. 95.62%) or without ( **91.12%** vs. 89.46%) data augmentation. Moreover, it is much more robust to other architectural choices (e.g. **90.46%** vs. 79.52% when swapping BatchNorm for LayerNorm). 

## **4.4 SSM Ablations: the Importance of HiPPO** 

A critical motivation of S4 was the use of the HiPPO matrices to initialize an SSM. We consider several simplifications of S4 to ablate the importance of each of these components, including: (i) how important is the HiPPO initialization? (ii) how important is training the SSM on top of HiPPO? (iii) are the benefits of S4 captured by the NPLR parameterization without HiPPO? 

As a simple testbed, all experiments in this section were performed on the sequential CIFAR-10 task, whicih we found transferred well to other settings. Models were constrained to at most 100K trainable parameters and trained with a simple plateau learning rate scheduler and no regularization. 

**Unconstrained SSMs.** We first investigate generic SSMs with various initializations. We consider a random Gaussian initialization (with variance scaled down until it did not NaN), and the HiPPO initialization. We also consider a random diagonal Gaussian matrix as a potential structured method; parameterizing _**A**_ as a diagonal matrix would allow substantial speedups without going through the complexity of S4’s NPLR parameterization. We consider both freezing the _**A**_ matrix and training it. 

Fig. 3 shows both training and validation curves, from which we can make several observations. First, training the SSM improved all methods, particularly the randomly initialized ones. For all methods, training the SSM led to improvements in both training and validation curves. Second, a large generalization gap exists between the initializations. In particular, note that when _**A**_ is trained, all initializations are able to reach perfect training accuracy. However, their validation accuracies are separated by over 15%. 

**NPLR SSMs.** The previous experiment validates the importance of HiPPO in SSMs. This was the main motivation of the NPLR algorithm in S4, which utilizes structure of the HiPPO matrix (2) to make SSMs computationally feasible. Fig. 4a shows that random NPLR matrices still do not perform well, which validates that S4’s effectiveness primarily comes from the HiPPO initialization, not the NPLR parameterization. 

Finally, Fig. 4b considers the main ablations considered in this section (with trainable SSMs) and adds minor regularization. With 0.1 Dropout, the same trends still hold, and the HiPPO initialization—in other words, the full S4 method—achieves 84 _._ 27% test accuracy with just 100K parameters. 

Table 9: Univariate long sequence time-series forecasting results. Full results in Appendix D.3.5. 

||**S4**||Informer|LogTrans|Reformer|LSTMa|DeepAR|ARIMA|Prophet|
|---|---|---|---|---|---|---|---|---|---|
||MSE|MAE|MSE MAE|MSE MAE|MSE MAE|MSE MAE|MSE MAE|MSE MAE|MSE MAE|
|ETTh1|**0.116 **|**0.271**|0.269 0.435|0.273 0.463|2.112 1.436|0.683 0.768|0.658 0.707|0.659 0.766|2.735 3.253|
|ETTh2|**0.187 **|**0.358**|0.277 0.431|0.303 0.493|2.030 1.721|0.640 0.681|0.429 0.580|2.878 1.044|3.355 4.664|
|ETTm1|**0.292 **|**0.466**|0.512 0.644|0.598 0.702|1.793 1.528|1.064 0.873|2.437 1.352|0.639 0.697|2.747 1.174|
|Weather|**0.245 **|**0.375**|0.359 0.466|0.388 0.499|2.087 1.534|0.866 0.809|0.499 0.596|1.062 0.943|3.859 1.144|
|ECL|**0.432 **|**0.497**|0.582 0.608|0.624 0.645|7.019 5.105|1.545 1.006|0.657 0.683|1.370 0.982|6.901 4.264|



11 

Figure 3: CIFAR-10 classification with unconstrained, real-valued SSMs with various initializations. ( _Left_ ) Train accuracy. ( _Right_ ) Validation accuracy. 

**==> picture [248 x 9] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) (b)<br>**----- End of picture text -----**<br>


Figure 4: CIFAR-10 validation accuracy of SSMs with different initializations and parameterizations. ( _Left_ ) NPLR parameterization with random versus HiPPO initialization. ( _Right_ ) All methods considered in this section, including minor Dropout regularization. S4 achieves SotA accuracy on sequential CIFAR-10 with just 100K parameters. 

## **5 Conclusion** 

We introduce S4, a sequence model that uses a new parameterization for the state space model’s continuoustime, recurrent, and convolutional views to efficiently model LRDs in a principled manner. Results across established benchmarks evaluating a diverse range of data modalities and model capabilities suggest that S4 has the potential to be an effective general sequence modeling solution. 