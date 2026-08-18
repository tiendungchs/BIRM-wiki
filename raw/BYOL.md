# **Bootstrap Your Own Latent A New Approach to Self-Supervised Learning** 

**Jean-Bastien Grill** _[∗][,]_[1] **Florian Strub** _[∗][,]_[1] **Florent Altché** _[∗][,]_[1] **Corentin Tallec** _[∗][,]_[1] **Pierre H. Richemond** _[∗][,]_[1] _[,]_[2] **Elena Buchatskaya**[1] **Carl Doersch**[1] **Bernardo Avila Pires**[1] **Zhaohan Daniel Guo**[1] **Mohammad Gheshlaghi Azar**[1] **Bilal Piot**[1] **Koray Kavukcuoglu**[1] **Rémi Munos**[1] **Michal Valko**[1] 

1DeepMind 2Imperial College 

```
[jbgrill,fstrub,altche,corentint,richemond]@google.com
```

## **Abstract** 

We introduce **B** ootstrap **Y** our **O** wn **L** atent ( `BYOL` ), a new approach to self-supervised image representation learning. `BYOL` relies on two neural networks, referred to as _online_ and _target_ networks, that interact and learn from each other. From an augmented view of an image, we train the online network to predict the target network representation of the same image under a different augmented view. At the same time, we update the target network with a slow-moving average of the online network. While state-of-the art methods rely on negative pairs, `BYOL` achieves a new state of the art _without them_ . `BYOL` reaches 74 _._ 3% top-1 classification accuracy on ImageNet using a linear evaluation with a ResNet-50 architecture and 79 _._ 6% with a larger ResNet. We show that `BYOL` performs on par or better than the current state of the art on both transfer and semi-supervised benchmarks. Our implementation and pretrained models are given on GitHub.[3] 

## **1 Introduction** 

Learning good image representations is a key challenge in computer vision [1, 2, 3] as it allows for efficient training on downstream tasks [4, 5, 6, 7]. Many different training approaches have been proposed to learn such representations, usually relying on visual pretext tasks. Among them, state-of-the-art contrastive methods [8, 9, 10, 11, 12] are trained by reducing the distance between representations of different augmented views of the same image (‘positive pairs’), and increasing the distance between representations of augmented views from different images (‘negative pairs’). These methods need careful treatment of negative pairs [13] by either relying on large batch sizes [8, 12], memory banks [9] or customized mining strategies [14, 15] to retrieve the negative pairs. In addition, their performance critically depends on the choice of image augmentations [8, 12]. 

In this paper, we introduce **B** ootstrap **Y** our **O** wn **L** atent ( `BYOL` ), a new algorithm for self-supervised learning of image representations. `BYOL` achieves higher performance than state-of-the-art contrastive methods 

**==> picture [217 x 193] intentionally omitted <==**

**----- Start of picture text -----**<br>
80 Sup. (200-2 × )<br>BYOL  (200-2 × ) Sup. (4 × )<br>Sup. (2 × )<br>78 BYOL (4 × )<br>Sup.<br>BYOL ( 2 × )<br>76 SimCLR (4 × )<br>74<br>BYOL SimCLR (2 × )<br>InfoMin<br>72<br>CMC CPCv2-L<br>MoCov2<br>70<br>MoCo<br>SimCLR AMDIM<br>68<br>25M 50M 100M 200M 400M<br>Number of parameters<br>ImageNet top-1 accuracy (%)<br>**----- End of picture text -----**<br>


Figure 1: Performance of `BYOL` on ImageNet (linear evaluation) using ResNet-50 and our best architecture ResNet200 (2 _×_ ), compared to other unsupervised and supervised ( `Sup.` ) baselines [8]. 

> _∗_ 

> 3 `https://github.com/deepmind/deepmind-research/tree/master/byol` 

without using negative pairs. It iteratively bootstraps[4] the outputs of a network to serve as targets for an enhanced representation. Moreover, `BYOL` is more robust to the choice of image augmentations than contrastive methods; we suspect that not relying on negative pairs is one of the leading reasons for its improved robustness. While previous methods based on bootstrapping have used pseudo-labels [16], cluster indices [17] or a handful of labels [18, 19, 20], we propose to _directly bootstrap the representations_ . In particular, `BYOL` uses two neural networks, referred to as online and target networks, that interact and learn from each other. Starting from an augmented view of an image, `BYOL` trains its online network to predict the target network’s representation of another augmented view of the same image. While this objective admits collapsed solutions, e.g., outputting the same vector for all images, we empirically show that `BYOL` does not converge to such solutions. We hypothesize (see Section 3.2) that the combination of (i) the addition of a predictor to the online network and (ii) the use of a slow-moving average of the online parameters as the target network encourages encoding more and more information within the online projection and avoids collapsed solutions. 

We evaluate the representation learned by `BYOL` on ImageNet [21] and other vision benchmarks using ResNet architectures [22]. Under the linear evaluation protocol on ImageNet, consisting in training a linear classifier on top of the frozen representation, `BYOL` reaches 74 _._ 3% top-1 accuracy with a standard ResNet-50 and 79 _._ 6% top-1 accuracy with a larger ResNet (Figure 1). In the semi-supervised and transfer settings on ImageNet, we obtain results on par or superior to the current state of the art. Our contributions are: ( _i_ ) We introduce `BYOL` , a self-supervised representation learning method (Section 3) which achieves state-of-the-art results under the linear evaluation protocol on ImageNet without using negative pairs. ( _ii_ ) We show that our learned representation outperforms the state of the art on semi-supervised and transfer benchmarks (Section 4). ( _iii_ ) We show that `BYOL` is more resilient to changes in the batch size and in the set of image augmentations compared to its contrastive counterparts (Section 5). In particular, `BYOL` suffers a much smaller performance drop than `SimCLR` , a strong contrastive baseline, when only using random crops as image augmentations. 

## **2 Related work** 

Most unsupervised methods for representation learning can be categorized as either generative or discriminative [23, 8]. Generative approaches to representation learning build a distribution over data and latent embedding and use the learned embeddings as image representations. Many of these approaches rely either on auto-encoding of images [24, 25, 26] or on adversarial learning [27], jointly modelling data and representation [28, 29, 30, 31]. Generative methods typically operate directly in pixel space. This however is computationally expensive, and the high level of detail required for image generation may not be necessary for representation learning. 

Among discriminative methods, contrastive methods [9, 10, 32, 33, 34, 11, 35, 36] currently achieve state-of-the-art performance in self-supervised learning [37, 8, 38, 12]. Contrastive approaches avoid a costly generation step in pixel space by bringing representation of different views of the same image closer (‘positive pairs’), and spreading representations of views from different images (‘negative pairs’) apart [39, 40]. Contrastive methods often require comparing each example with many other examples to work well [9, 8] prompting the question of whether using negative pairs is necessary. 

`DeepCluster` [17] partially answers this question. It uses bootstrapping on previous versions of its representation to produce targets for the next representation; it clusters data points using the prior representation, and uses the cluster index of each sample as a classification target for the new representation. While avoiding the use of negative pairs, this requires a costly clustering phase and specific precautions to avoid collapsing to trivial solutions. 

Some self-supervised methods are not contrastive but rely on using auxiliary handcrafted prediction tasks to learn their representation. In particular, relative patch prediction [23, 40], colorizing gray-scale images [41, 42], image inpainting [43], image jigsaw puzzle [44], image super-resolution [45], and geometric transformations [46, 47] have been shown to be useful. Yet, even with suitable architectures [48], these methods are being outperformed by contrastive methods [37, 8, 12]. 

Our approach has some similarities with _Predictions of Bootstrapped Latents_ ( `PBL` , [49]), a self-supervised representation learning technique for reinforcement learning (RL). `PBL` jointly trains the agent’s history representation and an encoding of future observations. The observation encoding is used as a target to train the agent’s representation, and the agent’s representation as a target to train the observation encoding. Unlike `PBL` , `BYOL` uses a slow-moving average of its representation to provide its targets, and does not require a second network. 

The idea of using a slow-moving average target network to produce stable targets for the online network was inspired by deep RL [50, 51, 52, 53]. Target networks stabilize the bootstrapping updates provided by the Bellman equation, 

> 4Throughout this paper, the term _bootstrap_ is used in its idiomatic sense rather than the statistical sense. 

2 

making them appealing to stabilize the bootstrap mechanism in `BYOL` . While most RL methods use fixed target networks, `BYOL` uses a weighted moving average of previous networks (as in [54]) in order to provide smoother changes in the target representation. 

In the semi-supervised setting [55, 56], an unsupervised loss is combined with a classification loss over a handful of labels to ground the training [19, 20, 57, 58, 59, 60, 61, 62]. Among these methods, _mean teacher_ ( `MT` ) [20] also uses a slow-moving average network, called _teacher_ , to produce targets for an online network, called _student_ . An _ℓ_ 2 consistency loss between the softmax predictions of the teacher and the student is added to the classification loss. While [20] demonstrates the effectiveness of `MT` in the semi-supervised learning case, in Section 5 we show that a similar approach collapses when removing the classification loss. In contrast, `BYOL` introduces an additional predictor on top of the online network, which prevents collapse. 

Finally, in self-supervised learning, `MoCo` [9] uses a slow-moving average network ( _momentum encoder_ ) to maintain consistent representations of negative pairs drawn from a memory bank. Instead, `BYOL` uses a moving average network to produce prediction targets as a means of stabilizing the bootstrap step. We show in Section 5 that this mere stabilizing effect can also improve existing contrastive methods. 

## **3 Method** 

We start by motivating our method before explaining its details in Section 3.1. Many successful self-supervised learning approaches build upon the cross-view prediction framework introduced in [63]. Typically, these approaches learn representations by predicting different views (e.g., different random crops) of the same image from one another. Many such approaches cast the prediction problem directly in representation space: the representation of an augmented view of an image should be predictive of the representation of another augmented view of the same image. However, predicting directly in representation space can lead to collapsed representations: for instance, a representation that is constant across views is always fully predictive of itself. Contrastive methods circumvent this problem by reformulating the prediction problem into one of discrimination: from the representation of an augmented view, they learn to discriminate between the representation of another augmented view of the same image, and the representations of augmented views of different images. In the vast majority of cases, this prevents the training from finding collapsed representations. Yet, this discriminative approach typically requires comparing each representation of an augmented view with many negative examples, to find ones sufficiently close to make the discrimination task challenging. In this work, we thus tasked ourselves to find out whether these negative examples are indispensable to prevent collapsing while preserving high performance. 

for our predictions. While avoiding collapse, it empirically does not result in very good representations. Nonetheless, it is interesting to note that the representation obtained using this procedure can already be much better than the initial fixed representation. In our ablation study (Section 5), we apply this procedure by predicting a fixed randomly initialized network and achieve 18 _._ 8% top-1 accuracy (Table 5a) on the linear evaluation protocol on ImageNet, whereas the randomly initialized network only achieves 1 _._ 4% by itself. This experimental finding is the core motivation for `BYOL` : from a given representation, referred to as _target_ , we can train a new, potentially enhanced representation, referred to as _online_ , by predicting the target representation. From there, we can expect to build a sequence of representations of increasing quality by iterating this procedure, using subsequent online networks as new target networks for further training. In practice, `BYOL` generalizes this bootstrapping procedure by iteratively refining its representation, but using a slowly moving exponential average of the online network as the target network instead of fixed checkpoints. 

## **3.1 Description of** **`BYOL`** 

`BYOL` ’s goal is to learn a representation _yθ_ which can then be used for downstream tasks. As described previously, `BYOL` uses two neural networks to learn: the _online_ and _target_ networks. The online network is defined by a set of weights _θ_ and is comprised of three stages: an _encoder fθ_ , a _projector gθ_ and a _predictor qθ_ , as shown in Figure 2 and Figure 8. The target network has the same architecture as the online network, but uses a different set of weights _ξ_ . The target network provides the regression targets to train the online network, and its parameters _ξ_ are an exponential moving average of the online parameters _θ_ [54]. More precisely, given a target decay rate _τ ∈_ [0 _,_ 1], after each training step we perform the following update, 

**==> picture [268 x 11] intentionally omitted <==**

Given a set of images _D_ , an image _x ∼D_ sampled uniformly from _D_ , and two distributions of image augmentations _T_ and _T[′]_ , `BYOL` produces two augmented views _v_ =∆ _t_ ( _x_ ) and _v′_ =∆ _t′_ ( _x_ ) from _x_ by applying respectively image 

3 

**==> picture [454 x 172] intentionally omitted <==**

**----- Start of picture text -----**<br>
view representation projection prediction<br>fθ gθ qθ<br>input<br>image t v yθ zθ qθ ( zθ ) online<br>x loss<br>t [′] v [′] yξ [′] zξ [′] sg( zξ [′] [)] target<br>fξ gξ sg<br>**----- End of picture text -----**<br>


Figure 2: `BYOL` ’s architecture. `BYOL` minimizes a similarity loss between _qθ_ ( _zθ_ ) and sg( _zξ[′]_[)][, where] _[ θ]_[ are the trained] weights, _ξ_ are an exponential moving average of _θ_ and sg means stop-gradient. At the end of training, everything but _fθ_ is discarded, and _yθ_ is used as the image representation. 

augmentations _t ∼T_ and _t[′] ∼T[′]_ . From the first augmented view _v_ , the online network outputs a _representation yθ_ =∆ _fθ_ ( _v_ ) and a projection _zθ_ =∆ _gθ_ ( _y_ ). The target network outputs _yξ′_[=] ∆ _fξ_ ( _v′_ ) and the _target projection zξ[′]_[=] ∆ _gξ_ ( _y′_ ) from the second augmented view _v′_ . We then output a _prediction qθ_ ( _zθ_ ) of _zξ′_[and] _[ ℓ]_[2][-normalize both] _qθ_ ( _zθ_ ) and _zξ[′]_[to] ~~_q_~~ _θ_ ~~(~~ _zθ_ ) =∆ _qθ_ ( _zθ_ ) _/∥qθ_ ( _zθ_ ) _∥_ 2 and ~~_z_~~ _[′] ξ_[=] ∆ _zξ′[/][∥][z] ξ[′][∥]_[2][.][Note that this predictor is only applied to the] online branch, making the architecture asymmetric between the online and target pipeline. Finally we define the following mean squared error between the normalized predictions and target projections,[5] 

**==> picture [335 x 28] intentionally omitted <==**

We symmetrize the loss _Lθ,ξ_ in Eq. 2 by separately feeding _v[′]_ to the online network and _v_ to the target network to compute _L_[�] _θ,ξ_ . At each training step, we perform a stochastic optimization step to minimize _L_ `[BYOL]` _θ,ξ_ = _Lθ,ξ_ + _L_[�] _θ,ξ_ with respect to _θ_ only, but _not ξ_ , as depicted by the stop-gradient in Figure 2. `BYOL` ’s dynamics are summarized as 

**==> picture [291 x 27] intentionally omitted <==**

where optimizer is an optimizer and _η_ is a learning rate. 

At the end of training, we only keep the encoder _fθ_ ; as in [9]. When comparing to other methods, we consider the number of inference-time weights only in the final representation _fθ_ . The full training procedure is summarized in Appendix A, and `python` pseudo-code based on the libraries `JAX` [64] and `Haiku` [65] is provided in in Appendix J. 

## **3.2 Intuitions on** **`BYOL` ’s behavior** 

As `BYOL` does not use an explicit term to prevent collapse (such as negative examples [10]) while minimizing _L_ `[BYOL]` _θ,ξ_ with respect to _θ_ , it may seem that `BYOL` should converge to a minimum of this loss with respect to ( _θ, ξ_ ) ( _e.g._ , a collapsed constant representation). However `BYOL` ’s target parameters _ξ_ updates are **not** in the direction of _∇ξL_ `[BYOL]` _θ,ξ_[.][More generally, we hypothesize that there is no loss] _[ L][θ,ξ]_[such that] `[ BYOL]`[’s dynamics is a gradient descent] on _L_ jointly over _θ, ξ_ . This is similar to GANs [66], where there is no loss that is jointly minimized w.r.t. both the discriminator and generator parameters. There is therefore no _a priori_ reason why `BYOL` ’s parameters would converge to a minimum of _L_ `[BYOL]` _θ,ξ_[.] 

While `BYOL` ’s dynamics still admit undesirable equilibria, we did not observe convergence to such equilibria in our experiments. In addition, when assuming `BYOL` ’s predictor to be optimal[6] i.e., _qθ_ = _q[⋆]_ with 

**==> picture [356 x 22] intentionally omitted <==**

> 5 While we could directly predict the representation _y_ and not a projection _z_ , previous work [8] have empirically shown that using this projection improves performance. 

> 6For simplicity we also consider `BYOL` without normalization (which performs reasonably close to `BYOL` , see Appendix F.6) nor symmetrization 

4 

we hypothesize that the undesirable equilibria are unstable. Indeed, in this optimal predictor case, `BYOL` ’s updates on _θ_ follow in expectation the gradient of the expected conditional variance (see Appendix H for details), 

**==> picture [387 x 31] intentionally omitted <==**

where _zξ,i[′]_[is the] _[ i]_[-th feature of] _[ z][′]_ 

**==> picture [8 x 7] intentionally omitted <==**

Note that for any random variables _X, Y,_ and _Z_ , Var( _X|Y, Z_ ) _≤_ Var( _X|Y_ ). Let _X_ be the target projection, _Y_ the current online projection, and _Z_ an additional variability on top of the online projection induced by stochasticities in the training dynamics: purely discarding information from the online projection cannot decrease the conditional variance. 

In particular, `BYOL` avoids constant features in _zθ_ as, for any constant _c_ and random variables _zθ_ and _zξ[′]_[,][ Var(] _[z] ξ[′][|][z][θ]_[)] _[ ≤]_ Var( _zξ[′][|][c]_[)][; hence our hypothesis on these collapsed constant equilibria being unstable.][Interestingly, if we were] to minimize E[[�] _i_[Var(] _[z] ξ,i[′][|][z][θ]_[)]][ with respect to] _[ ξ]_[, we would get a collapsed] _[ z] ξ[′]_[as the variance is minimized for a] constant _z[′]_[Instead,] `[ BYOL]`[ makes] _[ ξ]_[ closer to] _[ θ]_[, incorporating sources of variability captured by the online projection] _ξ_[.] into the target projection. 

Furthemore, notice that performing a hard-copy of the online parameters _θ_ into the target parameters _ξ_ would be enough to propagate new sources of variability. However, sudden changes in the target network might break the assumption of an optimal predictor, in which case `BYOL` ’s loss is not guaranteed to be close to the conditional variance. We hypothesize that the main role of `BYOL` ’s moving-averaged target network is to ensure the near-optimality of the predictor over training; Section 5 and Appendix I provide some empirical support of this interpretation. 

## **3.3 Implementation details** 

**Image augmentations** `BYOL` uses the same set of image augmentations as in `SimCLR` [8]. First, a random patch of the image is selected and resized to 224 _×_ 224 with a random horizontal flip, followed by a color distortion, consisting of a random sequence of brightness, contrast, saturation, hue adjustments, and an optional grayscale conversion. Finally Gaussian blur and solarization are applied to the patches. Additional details on the image augmentations are in Appendix B. 

**Architecture** We use a convolutional residual network [22] with 50 layers and post-activation (ResNet-50(1 _×_ ) v1) as our base parametric encoders _fθ_ and _fξ_ . We also use deeper (50, 101, 152 and 200 layers) and wider (from 1 _×_ to 4 _×_ ) ResNets, as in [67, 48, 8]. Specifically, the representation _y_ corresponds to the output of the final average pooling layer, which has a feature dimension of 2048 (for a width multiplier of 1 _×_ ). As in `SimCLR` [8], the representation _y_ is projected to a smaller space by a _multi-layer perceptron_ (MLP) _gθ_ , and similarly for the target projection _gξ_ . This MLP consists in a linear layer with output size 4096 followed by batch normalization [68], rectified linear units (ReLU) [69], and a final linear layer with output dimension 256. Contrary to `SimCLR` , the output of this MLP is not batch normalized. The predictor _qθ_ uses the same architecture as _gθ_ . 

**Optimization** We use the `LARS` optimizer [70] with a cosine decay learning rate schedule [71], without restarts, over 1000 epochs, with a warm-up period of 10 epochs. We set the base learning rate to 0 _._ 2 _,_ scaled linearly [72] with the batch size (LearningRate = 0 _._ 2 _×_ BatchSize _/_ 256). In addition, we use a global weight decay parameter of 1 _._ 5 _·_ 10 _[−]_[6] while excluding the biases and batch normalization parameters from both `LARS` adaptation and weight decay. For the target network, the exponential moving average parameter _τ_ starts from _τ_ base = 0 _._ 996 and is increased to one during training. Specifically, we set _τ_ ≜ 1 _−_ (1 _− τ_ base) _·_ (cos( _πk/K_ ) + 1) _/_ 2 with _k_ the current training step and _K_ the maximum number of training steps. We use a batch size of 4096 split over 512 Cloud TPU v3 cores. With this setup, training takes approximately 8 hours for a ResNet-50( _×_ 1). All hyperparameters are summarized in Appendix J; an additional set of hyperparameters for a smaller batch size of 512 is provided in Appendix G. 

## **4 Experimental evaluation** 

We assess the performance of `BYOL` ’s representation after self-supervised pretraining on the training set of the ImageNet ILSVRC-2012 dataset [21]. We first evaluate it on ImageNet (IN) in both linear evaluation and semisupervised setups. We then measure its transfer capabilities on other datasets and tasks, including classification, segmentation, object detection and depth estimation. For comparison, we also report scores for a representation trained using labels from the `train` ImageNet subset, referred to as Supervised-IN. In Appendix E, we assess the 

5 

generality of `BYOL` by pretraining a representation on the Places365-Standard dataset [73] before reproducing this evaluation protocol. 

**Linear evaluation on ImageNet** We first evaluate `BYOL` ’s representation by training a linear classifier on top of the frozen representation, following the procedure described in [48, 74, 41, 10, 8], and appendix C.1; we report top-1 and top-5 accuracies in % on the `test` set in Table 1. With a standard ResNet-50 ( _×_ 1) `BYOL` obtains 74 _._ 3% top-1 accuracy (91 _._ 6% top-5 accuracy), which is a 1 _._ 3% (resp. 0 _._ 5%) improvement over the previous self-supervised state of the art [12]. This tightens the gap with respect to the supervised baseline of [8], 76 _._ 5%, but is still significantly below the stronger supervised baseline of [75], 78 _._ 9%. With deeper and wider architectures, `BYOL` consistently outperforms the previous state of the art (Appendix C.2), and obtains a best performance of 79 _._ 6% top-1 accuracy, ranking higher than previous self-supervised approaches. On a ResNet-50 (4 _×_ ) `BYOL` achieves 78 _._ 6%, similar to the 78 _._ 9% of the best supervised baseline in [8] for the same architecture. 

|Method<br>Top-1<br>Top-5<br>Local Agg.<br>60_._2<br>-<br>`PIRL`[35]<br>63_._6<br>-<br>`CPC v2`[32]<br>63_._8<br>85_._3<br>`CMC`[11]<br>66_._2<br>87_._0<br>`SimCLR`[8]<br>69_._3<br>89_._0<br>`MoCo`v2 [37]<br>71_._1<br>-<br>InfoMin Aug. [12]<br>73_._0<br>91_._1<br>`BYOL`(ours)<br>**74**_._**3**<br>**91**_._**6**|Method<br>Architecture<br>Param.<br>Top-1<br>Top-5|
|---|---|
||`SimCLR`[8]<br>ResNet-50(2_×_)<br>94M<br>74_._2<br>92_._0<br>`CMC`[11]<br>ResNet-50(2_×_)<br>94M<br>70_._6<br>89_._7<br>`BYOL`(ours)<br>ResNet-50(2_×_)<br>94M<br>77_._4<br>93_._6<br>`CPC v2`[32]<br>ResNet-161<br>305M<br>71_._5<br>90_._1<br>`MoCo`[9]<br>ResNet-50(4_×_)<br>375M<br>68_._6<br>-<br>`SimCLR`[8]<br>ResNet-50(4_×_)<br>375M<br>76_._5<br>93_._2<br>`BYOL`(ours)<br>ResNet-50(4_×_)<br>375M<br>78_._6<br>94_._2<br>`BYOL`(ours)<br>ResNet-200(2_×_)<br>250M<br>**79**_._**6**<br>**94**_._**8**|



(a) ResNet-50 encoder. (b) Other ResNet encoder architectures. 

Table 1: Top-1 and top-5 accuracies (in %) under linear evaluation on ImageNet. 

**Semi-supervised training on ImageNet** Next, we evaluate the performance obtained when fine-tuning `BYOL` ’s representation on a classification task with a small subset of ImageNet’s `train` set, this time using label information. We follow the semi-supervised protocol of [74, 76, 8, 32] detailed in Appendix C.1, and use the same fixed splits of respectively 1% and 10% of ImageNet labeled training data as in [8]. We report both top-1 and top-5 accuracies on the `test` set in Table 2. `BYOL` consistently outperforms previous approaches across a wide range of architectures. Additionally, as detailed in Appendix C.1, `BYOL` reaches 77 _._ 7% top-1 accuracy with ResNet-50 when fine-tuning over 100% of ImageNet labels. 

|Method<br>Top-1<br>Top-5<br>1%<br>10%<br>1%<br>10%<br>Supervised [77]<br>25_._4<br>56_._4<br>48_._4<br>80_._4<br>InstDisc<br>-<br>-<br>39_._2<br>77_._4<br>PIRL [35]<br>-<br>-<br>57_._2<br>83_._8<br>`SimCLR`[8]<br>48_._3<br>65_._6<br>75_._5<br>87_._8<br>`BYOL`(ours)<br>**53**_._**2**<br>**68**_._**8**<br>**78**_._**4**<br>**89**_._**0**|Method<br>Architecture<br>Param.<br>Top-1<br>Top-5<br>1%<br>10%<br>1%<br>10%|
|---|---|
||`CPC v2`[32] ResNet-161<br>305M<br>-<br>-<br>77_._9<br>91_._2<br>`SimCLR`[8]<br>ResNet-50(2_×_)<br>94M<br>58_._5<br>71_._7<br>83_._0<br>91_._2<br>`BYOL`(ours)<br>ResNet-50(2_×_)<br>94M<br>62_._2<br>73_._5<br>84_._1<br>91_._7<br>`SimCLR`[8]<br>ResNet-50(4_×_)<br>375M<br>63_._0<br>74_._4<br>85_._8<br>92_._6<br>`BYOL`(ours)<br>ResNet-50(4_×_)<br>375M<br>69_._1<br>75_._7<br>87_._9<br>92_._5<br>`BYOL`(ours)<br>ResNet-200(2_×_)<br>250M<br>**71**_._**2**<br>**77**_._**7**<br>**89**_._**5**<br>**93**_._**7**|



(a) ResNet-50 encoder. 

(b) Other ResNet encoder architectures. 

Table 2: Semi-supervised training with a fraction of ImageNet labels. 

We evaluate our representation on other classification datasets to assess whether the features learned on ImageNet (IN) are generic and thus useful across image domains, or if they are ImageNet-specific. We perform linear evaluation and fine-tuning on the same set of classification tasks used in [8, 74], and carefully follow their evaluation protocol, as detailed in Appendix D. Performance is reported using standard metrics for each benchmark, and results are provided on a held-out `test` set after hyperparameter selection on a validation set. We report results in Table 3, both for linear evaluation and fine-tuning. `BYOL` outperforms `SimCLR` on all benchmarks and the Supervised-IN baseline on 7 of the 12 benchmarks, providing only slightly worse performance on the 5 remaining benchmarks. `BYOL` ’s representation can be transferred over to small images, e.g., CIFAR [78], landscapes, e.g., SUN397 [79] or VOC2007 [80], and textures, e.g., DTD [81]. 

6 

|Method|Food101|CIFAR10|CIFAR100|Birdsnap|SUN397|Cars|Aircraft|VOC2007|DTD|Pets|Caltech-101|Flowers|
|---|---|---|---|---|---|---|---|---|---|---|---|---|
|_Linear evaluation:_|||||||||||||
|`BYOL`(ours)|**75**_._**3**|91_._3|**78**_._**4**|**57**_._**2**|**62**_._**2**|**67**_._**8**|60_._6|82_._5|75_._5|90_._4|94_._2|**96**_._**1**|
|`SimCLR`(repro)|72_._8|90_._5|74_._4|42_._4|60_._6|49_._3|49_._8|81_._4|**75**_._**7**|84_._6|89_._3|92_._6|
|`SimCLR`[8]|68_._4|90_._6|71_._6|37_._4|58_._8|50_._3|50_._3|80_._5|74_._5|83_._6|90_._3|91_._2|
|Supervised-IN [8]|72_._3|**93**_._**6**|78_._3|53_._7|61_._9|66_._7|**61**_._**0**|**82**_._**8**|74_._9|**91**_._**5**|**94**_._**5**|94_._7|
|_Fine-tuned:_|||||||||||||
|`BYOL`(ours)|**88**_._**5**|**97**_._**8**|86_._1|**76**_._**3**|63_._7|91_._6|**88**_._**1**|**85**_._**4**|**76**_._**2**|91_._7|**93**_._**8**|97_._0|
|`SimCLR`(repro)|87_._5|97_._4|85_._3|75_._0|63_._9|91_._4|87_._6|84_._5|75_._4|89_._4|91_._7|96_._6|
|`SimCLR`[8]|88_._2|97_._7|85_._9|75_._9|63_._5|91_._3|88_._1|84_._1|73_._2|89_._2|92_._1|97_._0|
|Supervised-IN [8]|88_._3|97_._5|**86**_._**4**|75_._8|**64**_._**3**|**92**_._**1**|86_._0|85_._0|74_._6|**92**_._**1**|93_._3|**97**_._**6**|
|Random init [8]|86_._9|95_._9|80_._2|76_._1|53_._6|91_._4|85_._9|67_._3|64_._8|81_._5|72_._6|92_._0|



Table 3: Transfer learning results from ImageNet (IN) with the standard ResNet-50 architecture. 

**Transfer to other vision tasks** We evaluate our representation on different tasks relevant to computer vision practitioners, namely semantic segmentation, object detection and depth estimation. With this evaluation, we assess whether `BYOL` ’s representation generalizes beyond classification tasks. 

We evaluate `BYOL` on the VOC2012 semantic segmentation task as detailed in Appendix D.4, where the goal is to classify each pixel in the image [7]. We report the results in Table 4a. `BYOL` outperforms both the Supervised-IN baseline (+1 _._ 9 mIoU) and `SimCLR` (+1 _._ 1 mIoU). 

Similarly, we evaluate on object detection by reproducing the setup in [9] using a Faster R-CNN architecture [82], as detailed in Appendix D.5. We fine-tune on `trainval2007` and report results on `test2007` using the standard AP50 metric; `BYOL` is significantly better than the Supervised-IN baseline (+3 _._ 1 AP50) and `SimCLR` (+2 _._ 3 AP50). 

Finally, we evaluate on depth estimation on the NYU v2 dataset, where the depth map of a scene is estimated given a single RGB image. Depth prediction measures how well a network represents geometry, and how well that information can be localized to pixel accuracy [40]. The setup is based on [83] and detailed in Appendix D.6. We evaluate on the commonly used `test` subset of 654 images and report results using several common metrics in Table 4b: relative (rel) error, root mean squared (rms) error, and the percent of pixels (pct) where the error, max( _dgt/dp, dp/dgt_ ), is below 1 _._ 25 _[n]_ thresholds where _dp_ is the predicted depth and _dgt_ is the ground truth depth [40]. `BYOL` is better or on par with other methods for each metric. For instance, the challenging pct. _<_ 1 _._ 25 measure is respectively improved by +3 _._ 5 points and +1 _._ 3 points compared to supervised and `SimCLR` baselines. 

|Method<br>AP50<br>mIoU<br>Supervised-IN [9]<br>74_._4<br>74_._4<br>MoCo [9]<br>74_._9<br>72_._5<br>`SimCLR`(repro)<br>75_._2<br>75_._2<br>`BYOL`(ours)<br>**77**_._**5**<br>**76**_._**3**|Higher better<br>Lower better<br>Method<br>pct._<_1_._25<br>pct._<_1_._252<br>pct._<_1_._253<br>rms<br>rel|
|---|---|
||Supervised-IN [83]<br>81_._1<br>95_._3<br>98_._8<br>0_._573<br>**0**_._**127**|
||`SimCLR`(repro)<br>83_._3<br>96_._5<br>99_._1<br>0_._557<br>0_._134<br>`BYOL` (ours)<br>**84**_._**6**<br>**96**_._**7**<br>**99**_._**1**<br>**0**_._**541**<br>0_._129|



(a) Transfer results in semantic (b) Transfer results on NYU v2 depth estimation. segmentation and object detection. 

Table 4: Results on transferring `BYOL` ’s representation to other vision tasks. 

## **5 Building intuitions with ablations** 

We present ablations on `BYOL` to give an intuition of its behavior and performance. For reproducibility, we run each configuration of parameters over three seeds, and report the average performance. We also report the half difference between the best and worst runs when it is larger than 0 _._ 25. Although previous works perform ablations at 100 epochs [8, 12], we notice that relative improvements at 100 epochs do not always hold over longer training. For this reason, we run ablations over 300 epochs on 64 TPU v3 cores, which yields consistent results compared to our baseline training of 1000 epochs. For all the experiments in this section, we set the initial learning rate to 0 _._ 3 with batch size 4096, the weight decay to 10 _[−]_[6] as in `SimCLR` [8] and the base target decay rate _τ_ base to 0 _._ 99. In this section we report results in top-1 accuracy on ImageNet under the linear evaluation protocol as in Appendix C.1. 

**Batch size** Among contrastive methods, the ones that draw negative examples from the minibatch suffer performance drops when their batch size is reduced. `BYOL` does not use negative examples and we expect it to be more 

7 

robust to smaller batch sizes. To empirically verify this hypothesis, we train both `BYOL` and `SimCLR` using different batch sizes from 128 to 4096. To avoid re-tuning other hyperparameters, we average gradients over _N_ consecutive steps before updating the online network when reducing the batch size by a factor _N_ . The target network is updated once every _N_ steps, after the update of the online network; we accumulate the _N_ -steps in parallel in our runs. 

As shown in Figure 3a, the performance of `SimCLR` rapidly deteriorates with batch size, likely due to the decrease in the number of negative examples. In contrast, the performance of `BYOL` remains stable over a wide range of batch sizes from 256 to 4096, and only drops for smaller values due to batch normalization layers in the encoder.[7] 

**==> picture [426 x 187] intentionally omitted <==**

**----- Start of picture text -----**<br>
0 0 BYOL<br>SimCLR  (repro)<br>− 5<br>− 1<br>− 10<br>− 2<br>− 15<br>− 3 − 20<br>− 4 BYOL − 25<br>SimCLR  (repro)<br>Baseline Remove Remove Crop + Crop<br>4096 2048 1024 512 256 128 grayscale color blur only only<br>Batch size Transformations set<br>(a) Impact of batch size (b) Impact of progressively removing transformations<br>Decrease of accuracy from baseline Decrease of accuracy from baseline<br>**----- End of picture text -----**<br>


Figure 3: Decrease in top-1 accuracy (in % points) of `BYOL` and our own reproduction of `SimCLR` at 300 epochs, under linear evaluation on ImageNet. 

**Image augmentations** Contrastive methods are sensitive to the choice of image augmentations. For instance, `SimCLR` does not work well when removing color distortion from its image augmentations. As an explanation, `SimCLR` shows that crops of the same image mostly share their color histograms. At the same time, color histograms vary across images. Therefore, when a contrastive task only relies on random crops as image augmentations, it can be mostly solved by focusing on color histograms alone. As a result the representation is not incentivized to retain information beyond color histograms. To prevent that, `SimCLR` adds color distortion to its set of image augmentations. Instead, `BYOL` is incentivized to keep any information captured by the target representation into its online network, to improve its predictions. Therefore, even if augmented views of a same image share the same color histogram, `BYOL` is still incentivized to retain additional features in its representation. For that reason, we believe that `BYOL` is more robust to the choice of image augmentations than contrastive methods. 

Results presented in Figure 3b support this hypothesis: the performance of `BYOL` is much less affected than the performance of `SimCLR` when removing color distortions from the set of image augmentations ( _−_ 9 _._ 1 accuracy points for `BYOL` , _−_ 22 _._ 2 accuracy points for `SimCLR` ). When image augmentations are reduced to mere random crops, `BYOL` still displays good performance (59 _._ 4%, _i.e. −_ 13 _._ 1 points from 72 _._ 5% ), while `SimCLR` loses more than a third of its performance (40 _._ 3%, _i.e. −_ 27 _._ 6 points from 67 _._ 9%). We report additional ablations in Appendix F.3. 

**Bootstrapping** `BYOL` uses the projected representation of a target network, whose weights are an exponential moving average of the weights of the online network, as target for its predictions. This way, the weights of the target network represent a delayed and more stable version of the weights of the online network. When the target decay rate is 1, the target network is never updated, and remains at a constant value corresponding to its initialization. When the target decay rate is 0, the target network is instantaneously updated to the online network at each step. There is a trade-off between updating the targets too often and updating them too slowly, as illustrated in Table 5a. Instantaneously updating the target network ( _τ_ = 0) destabilizes training, yielding very poor performance while never updating the target ( _τ_ = 1) makes the training stable but prevents iterative improvement, ending with low-quality final representation. All values of the decay rate between 0 _._ 9 and 0 _._ 999 yield performance above 68 _._ 4% top-1 accuracy at 300 epochs. 

> 7The only dependency on batch size in our training pipeline sits within the batch normalization layers. 

8 

|Target<br>_τ_base<br>Top-1<br>Constant random network<br>1<br>18_._8_±_0_._7<br>Moving average of online<br>0_._999<br>69_._8<br>Moving average of online<br>0_._99<br>**72**_._**5**<br>Moving average of online<br>0_._9<br>68_._4<br>Stop gradient of online_†_<br>0<br>0_._3<br>esults for different target modes. _†_In the_stop gradient of_|Method<br>Predictor<br>Target network<br>_β_<br>Top-1|
|---|---|
||`BYOL`<br>✓<br>✓<br>0<br>**72**_._**5**<br>_−_<br>✓<br>✓<br>1<br>70_._9<br>_−_<br>✓<br>1<br>70_._7<br>`SimCLR`<br>1<br>69_._4<br>_−_<br>✓<br>1<br>69_._1<br>_−_<br>✓<br>0<br>0_._3<br>_−_<br>✓<br>0<br>0_._2<br>_−_<br>0<br>0_._1|



(a) Results for different target modes. _[†]_ In the _stop gradient of online_ , _τ_ = _τ_ base = 0 is kept constant throughout training. 

(b) Intermediate variants between `BYOL` and `SimCLR` . 

Table 5: Ablations with top-1 accuracy (in %) at 300 epochs under linear evaluation on ImageNet. 

**Ablation to contrastive methods** In this subsection, we recast `SimCLR` and `BYOL` using the same formalism to better understand where the improvement of `BYOL` over `SimCLR` comes from. Let us consider the following objective that extends the InfoNCE objective [10, 84] (see Appendix F.4), 

**==> picture [416 x 37] intentionally omitted <==**

where _α >_ 0 is a fixed temperature, _β ∈_ [0 _,_ 1] a weighting coefficient, _B_ the batch size, _v_ and _v[′]_ are batches of augmented views where for any batch index _i_ , _vi_ and _vi[′]_[are augmented views from the same image; the real-] valued function _Sθ_ quantifies pairwise similarity between augmented views. For any augmented view _u_ we denote _zθ_ ( _u_ ) ≜ _fθ_ ( _gθ_ ( _u_ )) and _zξ_ ( _u_ ) ≜ _fξ_ ( _gξ_ ( _u_ )). For given _φ_ and _ψ_ , we consider the normalized dot product 

**==> picture [301 x 24] intentionally omitted <==**

Up to minor details (cf. Appendix F.5), we recover the `SimCLR` loss with _φ_ ( _u_ 1) = _zθ_ ( _u_ 1) (no predictor), _ψ_ ( _u_ 2) = _zθ_ ( _u_ 2) (no target network) and _β_ = 1. We recover the `BYOL` loss when using a predictor and a target network, _i.e., φ_ ( _u_ 1) = _pθ_ ( _zθ_ ( _u_ 1)) and _ψ_ ( _u_ 2) = _zξ_ ( _u_ 2) with _β_ = 0. To evaluate the influence of the target network, the predictor and the coefficient _β_ , we perform an ablation over them. Results are presented in Table 5b and more details are given in Appendix F.4. 

The only variant that performs well without negative examples (i.e., with _β_ = 0) is `BYOL` , using _both_ a bootstrap target network _and_ a predictor. Adding the negative pairs to `BYOL` ’s loss without re-tuning the temperature parameter hurts its performance. In Appendix F.4, we show that we can add back negative pairs and still match the performance of `BYOL` with proper tuning of the temperature. 

Simply adding a target network to `SimCLR` already improves performance (+1 _._ 6 points). This sheds new light on the use of the target network in `MoCo` [9], where the target network is used to provide more negative examples. Here, we show that by mere stabilization effect, even when using the same number of negative examples, using a target network is beneficial. Finally, we observe that modifying the architecture of _Sθ_ to include a predictor only mildly affects the performance of `SimCLR` . 

**Network hyperparameters** In Appendix F, we explore how other network parameters may impact `BYOL` ’s performance. We iterate over multiple weight decays, learning rates, and projector/encoder architectures to observe that small hyperparameter changes do not drastically alter the final score. We note that removing the weight decay in either `BYOL` or `SimCLR` leads to network divergence, emphasizing the need for weight regularization in the self-supervised setting. Furthermore, we observe that changing the scaling factor in the network initialization [85] did not impact the performance (higher than 72% top-1 accuracy). 

**Relationship with** **`Mean Teacher`** Another semi-supervised approach, `Mean Teacher` (MT) [20], complements a supervised loss on few labels with an additional consistency loss. In [20], this consistency loss is the _ℓ_ 2 distance between the logits from a _student_ network, and those of a temporally averaged version of the student network, called _teacher_ . Removing the predictor in `BYOL` results in an unsupervised version of MT with no classification loss that 

9 

uses image augmentations instead of the original architectural noise (e.g., dropout). This variant of `BYOL` collapses (Row 7 of Table 5) which suggests that the additional predictor is critical to prevent collapse in an unsupervised scenario. 

**Importance of a near-optimal predictor** Table 5b already shows the importance of combining a predictor and a target network: the representation does collapse when either is removed. We further found that we can remove the target network without collapse by making the predictor near-optimal, either by (i) using an optimal _linear_ predictor (obtained by linear regression on the current batch) before back-propagating the error through the network (52 _._ 5% top-1 accuracy), or (ii) increasing the learning rate of the predictor (66 _._ 5% top-1). By contrast, increasing the learning rates of both projector _and_ predictor (without target network) yields poor results ( _≈_ 25% top-1). See Appendix I for more details. This seems to indicate that keeping the predictor near-optimal at all times is important to preventing collapse, which may be one of the roles of `BYOL` ’s target network. 

## **6 Conclusion** 

We introduced `BYOL` , a new algorithm for self-supervised learning of image representations. `BYOL` learns its representation by predicting previous versions of its outputs, without using negative pairs. We show that `BYOL` achieves state-of-the-art results on various benchmarks. In particular, under the linear evaluation protocol on ImageNet with a ResNet-50 (1 _×_ ), `BYOL` achieves a new state of the art and bridges most of the remaining gap between self-supervised methods and the supervised learning baseline of [8]. Using a ResNet-200 (2 _×_ ), `BYOL` reaches a top-1 accuracy of 79 _._ 6% which improves over the previous state of the art (76 _._ 8%) while using 30% fewer parameters. 

Nevertheless, `BYOL` To generalize `BYOL` to other modalities (e.g., audio, video, text, ...) it is necessary to obtain similarly suitable augmentations for each of them. Designing such augmentations may require significant effort and expertise. Therefore, automating the search for these augmentations would be an important next step to generalize `BYOL` to other modalities. 

10 

## **Broader impact** 

The presented research should be categorized as research in the field of unsupervised learning. This work may inspire new algorithms, theoretical, and experimental investigation. The algorithm presented here can be used for many different vision applications and a particular use may have both positive or negative impacts, which is known as the dual use problem. Besides, as vision datasets could be biased, the representation learned by `BYOL` could be susceptible to replicate these biases. 

## **Acknowledgements** 

The authors would like to thank the following people for their help throughout the process of writing this paper, in alphabetical order: Aaron van den Oord, Andrew Brock, Jason Ramapuram, Jeffrey De Fauw, Karen Simonyan, Katrina McKinney, Nathalie Beauguerlange, Olivier Henaff, Oriol Vinyals, Pauline Luc, Razvan Pascanu, Sander Dieleman, and the DeepMind team. We especially thank Jason Ramapuram and Jeffrey De Fauw, who provided the JAX SimCLR reproduction used throughout the paper. 

## **References** 

- [1] Kunihiko Fukushima. Neocognitron: A self-organizing neural network model for a mechanism of pattern recognition unaffected by shift in position. _Biological Cybernetics_ , 36(4):193–202, 1980. 

- [2] Laurenz Wiskott and Terrence J Sejnowski. Slow feature analysis: Unsupervised learning of invariances. _Neural Computation_ , 14(4), 2002. 

- [3] Geoffrey E Hinton, Simon Osindero, and Yee-Whye Teh. A fast learning algorithm for deep belief nets. _Neural Computation_ , 18(7):1527–1554, 2006. 

- [4] Maxime Oquab, Leon Bottou, Ivan Laptev, and Josef Sivic. Learning and transferring mid-level image representations using convolutional neural networks. In _Computer Vision and Pattern Recognition_ , 2014. 

- [5] Karen Simonyan and Andrew Zisserman. Very deep convolutional networks for large-scale image recognition. _arXiv preprint arXiv:1409.1556_ , 2014. 

- [6] Ross Girshick, Jeff Donahue, Trevor Darrell, and Jitendra Malik. Rich feature hierarchies for accurate object detection and semantic segmentation. In _Computer Vision and Pattern Recognition_ , 2014. 

- [7] Jonathan Long, Evan Shelhamer, and Trevor Darrell. Fully convolutional networks for semantic segmentation. In _Computer Vision and Pattern Recognition_ , 2015. 

- [8] Ting Chen, Simon Kornblith, Mohammad Norouzi, and Geoffrey E. Hinton. A simple framework for contrastive learning of visual representations. _arXiv preprint arXiv:2002.05709_ , 2020. 

- [9] Kaiming He, Haoqi Fan, Yuxin Wu, Saining Xie, and Ross B. Girshick. Momentum contrast for unsupervised visual representation learning. _arXiv preprint arXiv:1911.05722_ , 2019. 

- [10] Aäron van den Oord, Yazhe Li, and Oriol Vinyals. Representation learning with contrastive predictive coding. _arXiv preprint arXiv:1807.03748_ , 2018. 

- [11] Yonglong Tian, Dilip Krishnan, and Phillip Isola. Contrastive multiview coding. _arXiv preprint arXiv:1906.05849v4_ , 2019. 

- [12] Yonglong Tian, Chen Sun, Ben Poole, Dilip Krishnan, Cordelia Schmid, and Phillip Isola. What makes for good views for contrastive learning. _arXiv preprint arXiv:2005.10243_ , 2020. 

- [13] Nikunj Saunshi, Orestis Plevrakis, Sanjeev Arora, Mikhail Khodak, and Hrishikesh Khandeparkar. A theoretical analysis of contrastive unsupervised representation learning. In _International Conference on Machine Learning_ , 2019. 

- [14] R. Manmatha, Chao-Yuan Wu, Alexander J. Smola, and Philipp Krähenbühl. Sampling matters in deep embedding learning. In _International Conference on Computer Vision_ , 2017. 

- [15] Ben Harwood, Vijay B. G. Kumar, Gustavo Carneiro, Ian Reid, and Tom Drummond. Smart mining for deep metric learning. In _International Conference on Computer Vision_ , 2017. 

- [16] Dong-Hyun Lee. Pseudo-label: The simple and efficient semi-supervised learning method for deep neural networks. In _International Conference on Machine Learning_ , 2013. 

- [17] Mathilde Caron, Piotr Bojanowski, Armand Joulin, and Matthijs Douze. Deep clustering for unsupervised learning of visual features. In _European Conference on Computer Vision_ , 2018. 

- [18] Philip Bachman, Ouais Alsharif, and Doina Precup. Learning with pseudo-ensembles. In _Advances in neural information processing systems_ , pages 3365–3373, 2014. 

- [19] Samuli Laine and Timo Aila. Temporal ensembling for semi-supervised learning. _arXiv preprint arXiv:1610.02242_ , 2016. 

11 

- [20] Antti Tarvainen and Harri Valpola. Mean teachers are better role models: Weight-averaged consistency targets improve semi-supervised deep learning results. In _Advances in neural information processing systems_ , pages 1195–1204, 2017. 

- [21] Olga Russakovsky, Jia Deng, Hao Su, Jonathan Krause, Sanjeev Satheesh, Sean Ma, Zhiheng Huang, Andrej Karpathy, Aditya Khosla, Michael Bernstein, Alexander C. Berg, and Li Fei-Fei. ImageNet Large Scale Visual Recognition Challenge. _International Journal of Computer Vision_ , 115(3):211–252, 2015. 

- [22] Kaiming He, Xiangyu Zhang, Shaoqing Ren, and Jian Sun. Deep residual learning for image recognition. In _Computer Vision and Pattern Recognition_ , 2016. 

- [23] Carl Doersch, Abhinav Gupta, and Alexei A Efros. Unsupervised visual representation learning by context prediction. In _Computer Vision and Pattern Recognition_ , 2015. 

- [24] Pascal Vincent, Hugo Larochelle, Yoshua Bengio, and Pierre-Antoine Manzagol. Extracting and composing robust features with denoising autoencoders. In _International Conference on Machine Learning_ , 2008. 

- [25] Diederik P Kingma and Max Welling. Auto-encoding variational bayes. _arXiv preprint arXiv:1312.6114_ , 2013. 

- [26] Danilo Jimenez Rezende, Shakir Mohamed, and Daan Wierstra. Stochastic back-propagation and variational inference in deep latent gaussian models. _arXiv preprint arXiv:1401.4082_ , 2014. 

- [27] Ian Goodfellow, Jean Pouget-Abadie, Mehdi Mirza, Bing Xu, David Warde-Farley, Sherjil Ozair, Aaron Courville, and Yoshua Bengio. Generative adversarial nets. In _Neural Information Processing Systems_ , 2014. 

- [28] Jeff Donahue, Philipp Krähenbühl, and Trevor Darrell. Adversarial feature learning. _arXiv preprint arXiv:1605.09782_ , 2016. 

- [29] Vincent Dumoulin, Ishmael Belghazi, Ben Poole, Alex Lamb, Martín Arjovsky, Olivier Mastropietro, and Aaron C. Courville. Adversarially learned inference. _arXiv preprint arXiv:1606.00704_ , 2017. 

- [30] Jeff Donahue and Karen Simonyan. Large scale adversarial representation learning. In _Neural Information Processing Systems_ , 2019. 

- [31] Andrew Brock, Jeff Donahue, and Karen Simonyan. Large scale GAN training for high fidelity natural image synthesis. _arXiv preprint arXiv:1809.11096_ , 2018. 

- [32] Olivier J. Hénaff, Aravind Srinivas, Jeffrey De Fauw, Ali Razavi, Carl Doersch, S. M. Ali Eslami, and Aäron van den Oord. Data-efficient image recognition with contrastive predictive coding. In _International Conference on Machine Learning_ , 2019. 

- [33] R Devon Hjelm, Alex Fedorov, Samuel Lavoie-Marchildon, Karan Grewal, Adam Trischler, and Yoshua Bengio. Learning deep representations by mutual information estimation and maximization. _arXiv preprint arXiv:1808.06670_ , 2019. 

- [34] Philip Bachman, R Devon Hjelm, and William Buchwalter. Learning representations by maximizing mutual information across views. In _Neural Information Processing Systems_ , 2019. 

- [35] Ishan Misra and Laurens van der Maaten. Self-supervised learning of pretext-invariant representations. _arXiv preprint arXiv:1912.01991_ , 2019. 

- [36] Junnan Li, Pan Zhou, Caiming Xiong, Richard Socher, and Steven CH Hoi. Prototypical contrastive learning of unsupervised representations. _arXiv preprint arXiv:2005.04966_ , 2020. 

- [37] Rishabh Jain, Haoqi Fan, Ross B. Girshick, and Kaiming He. Improved baselines with momentum contrastive learning. _arXiv preprint arXiv:2003.04297_ , 2020. 

- [38] Ting Chen, Simon Kornblith, Kevin Swersky, Mohammad Norouzi, and Geoffrey Hinton. Big self-supervised models are strong semi-supervised learners. _arXiv preprint arXiv:2006.10029_ , 2020. 

- [39] Zhirong Wu, Yuanjun Xiong, Stella X Yu, and Dahua Lin. Unsupervised feature learning via non-parametric instance discrimination. In _Computer Vision and Pattern Recognition_ , 2018. 

- [40] Carl Doersch and Andrew Zisserman. Multi-task self-supervised visual learning. In _International Conference on Computer Vision_ , 2017. 

- [41] Richard Zhang, Phillip Isola, and Alexei A. Efros. Colorful image colorization. In _European Conference on Computer Vision_ , 2016. 

- [42] Gustav Larsson, Michael Maire, and Gregory Shakhnarovich. Learning representations for automatic colorization. In _European Conference on Computer Vision_ , 2016. 

- [43] Deepak Pathak, Philipp Krahenbuhl, Jeff Donahue, Trevor Darrell, and Alexei A. Efros. Context encoders: Feature learning by inpainting. In _Computer Vision and Pattern Recognition_ , 2016. 

- [44] Mehdi Noroozi and Paolo Favaro. Unsupervised learning of visual representations by solving jigsaw puzzles. In _European Conference on Computer Vision_ , 2016. 

- [45] Christian Ledig, Lucas Theis, Ferenc Huszár, Jose Caballero, Andrew Cunningham, Alejandro Acosta, Andrew Aitken, Alykhan Tejani, Johannes Totz, Zehan Wang, et al. Photo-realistic single image super-resolution using a generative adversarial network. In _Computer Vision and Pattern Recognition_ , 2017. 

12 

- [46] Alexey Dosovitskiy, Jost Tobias Springenberg, Martin Riedmiller, and Thomas Brox. Discriminative unsupervised feature learning with convolutional neural networks. In _Neural Information Processing Systems_ , 2014. 

- [47] Spyros Gidaris, Praveer Singh, and Nikos Komodakis. Unsupervised representation learning by predicting image rotations. _arXiv preprint arXiv:1803.07728_ , 2018. 

- [48] Alexander Kolesnikov, Xiaohua Zhai, and Lucas Beyer. Revisiting self-supervised visual representation learning. In _Computer Vision and Pattern Recognition_ , 2019. 

- [49] Daniel Guo, Bernardo Avila Pires, Bilal Piot, Jean-Bastien Grill, Florent Altché, Rémi Munos, and Mohammad Gheshlaghi Azar. Bootstrap latent-predictive representations for multitask reinforcement learning. In _International Conference on Machine Learning_ , 2020. 

- [50] Volodymyr Mnih, Koray Kavukcuoglu, David Silver, Andrei A. Rusu, Joel Veness, Marc G. Bellemare, Alex Graves, Martin A. Riedmiller, Andreas K. Fidjeland, Georg Ostrovski, Stig Petersen, Charles Beattie, Amir Sadik, Ioannis Antonoglou, Helen. King, Dharshan Kumaran, Daan Wierstra, Shane Legg, and Demis Hassabis. Human-level control through deep reinforcement learning. _Nature_ , 518:529–533, 2015. 

- [51] Volodymyr Mnih, Adria Puigdomenech Badia, Mehdi Mirza, Alex Graves, Timothy Lillicrap, Tim Harley, David Silver, and Koray Kavukcuoglu. Asynchronous methods for deep reinforcement learning. In _International Conference on Machine Learning_ , 2016. 

- [52] Matteo Hessel, Joseph Modayil, Hado Van Hasselt, Tom Schaul, Georg Ostrovski, Will Dabney, Dan Horgan, Bilal Piot, Mohammad Gheshlaghi Azar, and David Silver. Rainbow: Combining improvements in deep reinforcement learning. In _AAAI Conference on Artificial Intelligence_ , 2018. 

- [53] Hado Van Hasselt, Yotam Doron, Florian Strub, Matteo Hessel, Nicolas Sonnerat, and Joseph Modayil. Deep reinforcement learning and the deadly triad. _Deep Reinforcement Learning Workshop NeurIPS_ , 2018. 

- [54] Timothy P Lillicrap, Jonathan J Hunt, Alexander Pritzel, Nicolas Heess, Tom Erez, Yuval Tassa, David Silver, and Daan Wierstra. Continuous control with deep reinforcement learning. _arXiv preprint arXiv:1509.02971_ , 2015. 

- [55] Olivier Chapelle, Bernhard Scholkopf, and Alexander Zien. Semi-supervised learning. _IEEE Transactions on Neural Networks_ , 20(3):542–542, 2009. 

- [56] Xiaojin Zhu and Andrew B Goldberg. Introduction to semi-supervised learning. _Synthesis lectures on artificial intelligence and machine learning_ , 3(1):1–130, 2009. 

- [57] Durk P Kingma, Shakir Mohamed, Danilo Jimenez Rezende, and Max Welling. Semi-supervised learning with deep generative models. In _Advances in neural information processing systems_ , 2014. 

- [58] Antti Rasmus, Mathias Berglund, Mikko Honkala, Harri Valpola, and Tapani Raiko. Semi-supervised learning with ladder networks. In _Advances in neural information processing systems_ , 2015. 

- [59] David Berthelot, Nicholas Carlini, Ian Goodfellow, Nicolas Papernot, Avital Oliver, and Colin A Raffel. Mixmatch: A holistic approach to semi-supervised learning. In _Advances in Neural Information Processing Systems_ , 2019. 

- [60] Takeru Miyato, Shin-ichi Maeda, Masanori Koyama, and Shin Ishii. Virtual adversarial training: a regularization method for supervised and semi-supervised learning. _IEEE transactions on pattern analysis and machine intelligence_ , 41(8):1979–1993, 2018. 

- [61] David Berthelot, N. Carlini, E. D. Cubuk, Alex Kurakin, Kihyuk Sohn, Han Zhang, and Colin Raffel. Remixmatch: Semi-supervised learning with distribution matching and augmentation anchoring. In _ICLR_ , 2020. 

- [62] Kihyuk Sohn, David Berthelot, Chun-Liang Li, Zizhao Zhang, Nicholas Carlini, Ekin D Cubuk, Alex Kurakin, Han Zhang, and Colin Raffel. Fixmatch: Simplifying semi-supervised learning with consistency and confidence. _arXiv preprint arXiv:2001.07685_ , 2020. 

- [63] Suzanna Becker and Geoffrey E. Hinton. Self-organizing neural network that discovers surfaces in random-dot stereograms. _Nature_ , 355(6356):161–163, 1992. 

- [64] James Bradbury, Roy Frostig, Peter Hawkins, Matthew James Johnson, Chris Leary, Dougal Maclaurin, and Skye Wanderman-Milne. JAX: composable transformations of Python+NumPy programs, 2018. 

- [65] Tom Hennigan, Trevor Cai, Tamara Norman, and Igor Babuschkin. Haiku: Sonnet for JAX, 2020. 

- [66] Ian Goodfellow, Jean Pouget-Abadie, Mehdi Mirza, Bing Xu, David Warde-Farley, Sherjil Ozair, Aaron Courville, and Yoshua Bengio. Generative adversarial nets. In _Advances in neural information processing systems_ , pages 2672–2680, 2014. 

- [67] Sergey Zagoruyko and Nikos Komodakis. Wide residual networks. _arXiv preprint arXiv:1605.07146_ , 2016. 

- [68] Sergey Ioffe and Christian Szegedy. Batch normalization: Accelerating deep network training by reducing internal covariate shift. In _International Conference on Machine Learning_ , 2015. 

- [69] Vinod Nair and Geoffrey E. Hinton. Rectified linear units improve restricted boltzmann machines. In _International Conference on Machine Learning_ , 2010. 

- [70] Yang You, Igor Gitman, and Boris Ginsburg. Scaling SGD batch size to 32k for imagenet training. _arXiv preprint arXiv:1708.03888_ , 2017. 

13 

- [71] Ilya Loshchilov and Frank Hutter. SGDR: stochastic gradient descent with warm restarts. In _International Conference on Learning Representations_ , 2017. 

- [72] Priya Goyal, Piotr Dollár, Ross Girshick, Pieter Noordhuis, Lukasz Wesolowski, Aapo Kyrola, Andrew Tulloch, Yangqing Jia, and Kaiming He. Accurate, large minibatch sgd: Training imagenet in 1 hour. _arXiv preprint arXiv:1706.02677_ , 2017. 

- [73] Bolei Zhou, Agata Lapedriza, Aditya Khosla, Aude Oliva, and Antonio Torralba. Places: A 10 million image database for scene recognition. _Transactions on Pattern Analysis and Machine Intelligence_ , 2017. 

- [74] Simon Kornblith, Jonathon Shlens, and Quoc V Le. Do better ImageNet models transfer better? In _Computer Cision and Pattern Recognition_ , 2019. 

- [75] Chengyue Gong, Tongzheng Ren, Mao Ye, and Qiang Liu. Maxup: A simple way to improve generalization of neural network training. _arXiv preprint arXiv:2002.09024_ , 2020. 

- [76] Xiaohua Zhai, Joan Puigcerver, Alexander I Kolesnikov, Pierre Ruyssen, Carlos Riquelme, Mario Lucic, Josip Djolonga, André Susano Pinto, Maxim Neumann, Alexey Dosovitskiy, Lucas Beyer, Olivier Bachem, Michael Tschannen, Marcin Michalski, Olivier Bousquet, Sylvain Gelly, and Neil Houlsby. A large-scale study of representation learning with the visual task adaptation benchmark. _arXiv: Computer Vision and Pattern Recognition_ , 2019. 

- [77] Xiaohua Zhai, Avital Oliver, Alexander Kolesnikov, and Lucas Beyer. S4L: Self-supervised semi-supervised learning. In _International Conference on Computer Vision_ , 2019. 

- [78] Alex Krizhevsky. Learning multiple layers of features from tiny images. Technical report, University of Toronto, 2009. 

- [79] Jianxiong Xiao, James Hays, Krista A. Ehinger, Aude Oliva, and Antonio Torralba. Sun database: Large-scale scene recognition from abbey to zoo. In _Computer Vision and Pattern Recognition_ , 2010. 

- [80] Mark Everingham, Luc Van Gool, Christopher KI Williams, John Winn, and Andrew Zisserman. The Pascal visual object classes (VOC) challenge. _International Journal of Computer Vision_ , 88(2):303–338, 2010. 

- [81] Mircea Cimpoi, Subhransu Maji, Iasonas Kokkinos, Sammy Mohamed, and Andrea Vedaldi. Describing textures in the wild. In _Computer Vision and Pattern Recognition_ , 2014. 

- [82] Shaoqing Ren, Kaiming He, Ross Girshick, and Jian Sun. Faster R-CNN: Towards real-time object detection with region proposal networks. In _Neural Information Processing Systems_ , 2015. 

- [83] I. Laina, C. Rupprecht, V. Belagiannis, F. Tombari, and N. Navab. Deeper depth prediction with fully convolutional residual networks. In _International Conference on 3D Vision_ , 2016. 

- [84] Ben Poole, Sherjil Ozair, Aaron van den Oord, Alexander A Alemi, and George Tucker. On variational bounds of mutual information. _arXiv preprint arXiv:1905.06922_ , 2019. 

- [85] Kaiming He, Xiangyu Zhang, Shaoqing Ren, and Jian Sun. Delving deep into rectifiers: Surpassing human-level performance on imagenet classification. In _Proceedings of the IEEE international conference on computer vision_ , 2015. 

- [86] Razvan Pascanu, Tomas Mikolov, and Yoshua Bengio. On the difficulty of training recurrent neural networks. In _International Conference on Machine Learning_ , 2013. 

- [87] Ekin D Cubuk, Barret Zoph, Jonathon Shlens, and Quoc V Le. Randaugment: Practical automated data augmentation with a reduced search space. _arXiv preprint arXiv:1909.13719_ , 2019. 

- [88] Christian Szegedy, Vincent Vanhoucke, Sergey Ioffe, Jon Shlens, and Zbigniew Wojna. Rethinking the inception architecture for computer vision. In _Computer Vision and Pattern Recognition_ , pages 2818–2826, 2016. 

- [89] Lukas Bossard, Matthieu Guillaumin, and Luc Van Gool. Food-101 – mining discriminative components with random forests. In _European Conference on Computer Vision_ , 2014. 

- [90] Thomas Berg, Jiongxin Liu, Seung Woo Lee, Michelle L. Alexander, David W. Jacobs, and Peter N. Belhumeur. Birdsnap: Large-scale fine-grained visual categorization of birds. In _Computer Vision and Pattern Recognition_ , 2014. 

- [91] Jonathan Krause, Michael Stark, Jia Deng, and Li Fei-Fei. In _Workshop on 3D Representation and Recognition_ , Sydney, Australia, 2013. 

- [92] Subhransu Maji, Esa Rahtu, Juho Kannala, Matthew B. Blaschko, and Andrea Vedaldi. of aircraft. _arXiv preprint arXiv:1306.5151_ , 2013. 

- [93] O. M. Parkhi, A. Vedaldi, A. Zisserman, and C. V. Jawahar. Cats and dogs. In _Computer Vision and Pattern Recognition_ , 2012. 

- [94] Li Fei-Fei, Rob Fergus, and Pietro Perona. Learning generative visual models from few training examples: An incremental bayesian approach tested on 101 object categories. _Computer Vision and Pattern Recognition Workshop_ , 2004. 

- [95] Maria-Elena Nilsback and Andrew Zisserman. Automated flower classification over a large number of classes. In _Indian Conference on Computer Vision, Graphics and Image Processing_ , 2008. 

- [96] Jeff Donahue, Yangqing Jia, Oriol Vinyals, Judy Hoffman, Ning Zhang, Eric Tzeng, and Trevor Darrell. Decaf: A deep convolutional activation feature for generic visual recognition. In _International Conference on Machine Learning_ , 2014. 

- [97] Art B Owen. A robust hybrid of lasso and ridge regression. _Contemporary Mathematics_ , 443(7):59–72, 2007. 

14 

- [98] Chengxu Zhuang, Alex Lin Zhai, and Daniel Yamins. Local aggregation for unsupervised learning of visual embeddings. In _International Conference on Computer Vision_ , 2019. 

- [99] Deepak Pathak, Ross Girshick, Piotr Dollár, Trevor Darrell, and Bharath Hariharan. Learning features by watching objects move. In _Conference on Computer Vision and Pattern Recognition_ , 2017. 

- [100] Yuxin Wu and Kaiming He. Group normalization. In _European Conference on Computer Vision_ , 2018. 

15 

## **A Algorithm** 

**Algorithm 1:** `BYOL` : **B** ootstrap **Y** our **O** wn **L** atent 

||**Inputs :**|||||
|---|---|---|---|---|---|
||_D_,_T ,_and_T ′_|set of images and distributions of transformations||||
||_θ_,_fθ_,_gθ,_and_qθ_|initial online parameters, encoder, projector, and predictor||||
||_ξ_,_fξ_,_gξ_|initial target parameters, target encoder, and target projector||||
||optimizer|optimizer, updates online parameters using the loss gradient||||
||_K_ and_N_|total number of optimization steps and batch size||||
||_{τk}K_<br>_k_=1 and_{ηk}K_<br>_k_=1|target network update schedule and learning rate schedule||||
|**1 **|**for**_k_ = 1**to**_K_ **do**|||||
|**2**|_B ←{xi ∼D}N_<br>_i_=1|||`// `|`sample a batch of` _N_ `images`|
|**3**|**for**_xi ∈B_**do**|||||
|**4**|_t ∼T_ and_t′ ∼T _|_′_||`// sample image transformations`||
|**5**|_z_1 _←gθ_(_fθ_(_t_(_xi_)))and_z_2||_←gθ_(_fθ_(_t′_(_xi_)))||`// compute projections`|
|**6**|_z′_<br>1 _←gξ_(_fξ_(_t′_(_xi_)))and_z′_<br>2||_←gξ_(_fξ_(_t_(_xi_)))|`// compute target projections`||
|**7**|_li ←−_2_·_<br>�<br>_⟨qθ_(_z_1)_,z′_<br>1_⟩_<br>_∥qθ_(_z_1)_∥_2_·∥z′_<br>1_∥_2||+<br>_⟨qθ_(_z_2)_,z′_<br>2_⟩_<br>_∥qθ_(_z_2)_∥_2_·∥z′_<br>2_∥_2|�|`// compute the loss for` _xi_|
|**8**|**end**|||||
||_N_|||||
|**9**|_δθ ←_1<br>_N_<br>�<br>_∂θli_|||`// compute the `|`total loss gradient w.r.t.`_θ_|
||_i_=1|||||
|**10**|_θ ←_optimizer(_θ, δθ,_|_ηk_)|||`// update online parameters`|
|**11**|_ξ ←τkξ_+ (1_−τk_)_θ_||||`// update target parameters`|
|**12 **|**end**|||||
||**Output :**encoder _fθ_|||||



## **B Image augmentations** 

During self-supervised training, `BYOL` uses the following image augmentations (which are a subset of the ones presented in [8]): 

- random cropping: a random patch of the image is selected, with an area uniformly sampled between 8% and 100% of that of the original image, and an aspect ratio logarithmically sampled between 3 _/_ 4 and 4 _/_ 3. This patch is then resized to the target size of 224 _×_ 224 using bicubic interpolation; 

- 

- color jittering: the brightness, contrast, saturation and hue of the image are shifted by a uniformly random offset applied on all the pixels of the same image. The order in which these shifts are performed is randomly selected for each patch; 

- color dropping: an optional conversion to grayscale. When applied, output intensity for a pixel ( _r, g, b_ ) corresponds to its luma component, computed as 0 _._ 2989 _r_ + 0 _._ 5870 _g_ + 0 _._ 1140 _b_ ; 

- Gaussian blurring: for a 224 _×_ 224 image, a square Gaussian kernel of size 23 _×_ 23 is used, with a standard deviation uniformly sampled over [0 _._ 1 _,_ 2 _._ 0]; 

- solarization: an optional color transformation _x �→ x ·_ **1** _{x<_ 0 _._ 5 _}_ + (1 _− x_ ) _·_ **1** _{x≥_ 0 _._ 5 _}_ for pixels with values in [0 _,_ 1]. 

Augmentations from the sets _T_ and _T[′]_ (introduced in Section 3) are compositions of the above image augmentations in the listed order, each applied with a predetermined probability. The image augmentations parameters are listed in Table 6. 

During evaluation, we use a center crop similar to [8]: images are resized to 256 pixels along the shorter side using bicubic resampling, after which a 224 _×_ 224 center crop is applied. In both training and evaluation, we normalize color channels by subtracting the average color and dividing by the standard deviation, computed on ImageNet, after applying the augmentations. 

16 

|Parameter|_T_|_T ′_|
|---|---|---|
|Random crop probability|1_._0|1_._0|
|Flip probability|0_._5|0_._5|
|Color jittering probability|0_._8|0_._8|
|Brightness adjustment max intensity|0_._4|0_._4|
|Contrast adjustment max intensity|0_._4|0_._4|
|Saturation adjustment max intensity|0_._2|0_._2|
|Hue adjustment max intensity|0_._1|0_._1|
|Color dropping probability|0_._2|0_._2|
|Gaussian blurring probability|1_._0|0_._1|
|Solarization probability|0_._0|0_._2|



Table 6: Parameters used to generate image augmentations. 

## **C Evaluation on ImageNet training** 

## **C.1 Self-supervised learning evaluation on ImageNet** 

> **Linear evaluation protocol on ImageNet** As in [48, 74, 8, 37], we use the standard linear evaluation protocol on ImageNet, which consists in training a linear classifier on top of the frozen representation, _i.e._ , without updating the network parameters nor the batch statistics. At training time, we apply spatial augmentations, i.e., random crops with resize to 224 _×_ 224 pixels, and random flips. At test time, images are resized to 256 pixels along the shorter side using bicubic resampling, after which a 224 _×_ 224 center crop is applied. In both cases, we normalize the color channels by subtracting the average color and dividing by the standard deviation (computed on ImageNet), after applying the augmentations. We optimize the cross-entropy loss using `SGD` with Nesterov momentum over 80 epochs, using a batch size of 1024 and a momentum of 0 _._ 9. We do not use any regularization methods such as weight decay, gradient clipping [86], tclip [34], or logits regularization. We finally sweep over 5 learning rates _{_ 0 _._ 4 _,_ 0 _._ 3 _,_ 0 _._ 2 _,_ 0 _._ 1 _,_ 0 _._ 05 _}_ on a local validation set (10009 images from ImageNet `train` set), and report the accuracy of the best validation hyperparameter on the `test` set (which is the public validation set of the original ILSVRC2012 ImageNet dataset). 

**Variant on linear evaluation on ImageNet** In this paragraph only, we deviate from the protocol of [8, 37] and propose another way of performing linear evaluation on top of a frozen representation. This method achieves better performance both in top-1 and top-5 accuracy. 

- We replace the spatial augmentations (random crops with resize to 224 _×_ 224 pre-train augmentations of Appendix B. This method was already used in [32] with a different subset of pre-train augmentations. 

- We regularize the linear classifier as in [34][8] by clipping the logits using a hyperbolic tangent function 

tclip( _x_ ) ≜ _α ·_ tanh( _x/α_ ) _,_ 

where _α_ is a positive scalar, and by adding a logit-regularization penalty term in the loss 

Loss( _x, y_ ) ≜ cross_entropy(tclip( _x_ ) _, y_ ) + _β ·_ average(tclip( _x_ )[2] ) _,_ 

where _x_ are the logits, _y_ are the target labels, and _β_ is the regularization parameter. We set _α_ = 20 and _β_ = 1 _e−_ 2. 

We report in Table 7 the top-1 and top-5 accuracy on ImageNet using this modified protocol. These modifications in the evaluation protocol increase the `BYOL` ’s top-1 accuracy from 74 _._ 3% to 74 _._ 8% with a ResNet-50 (1 _×_ ). 

**Semi-supervised learning on ImageNet** We follow the semi-supervised learning protocol of [8, 77]. We first initialize the network with the parameters of the pretrained representation, and fine-tune it with a subset of ImageNet labels. At training time, we apply spatial augmentations, i.e., random crops with resize to 224 _×_ 224 pixels and random flips. At test time, images are resized to 256 pixels along the shorter side using bicubic resampling, after which a 224 _×_ 224 center crop is applied. In both cases, we normalize the color channels by subtracting the average color and dividing by the standard deviation (computed on ImageNet), after applying the augmentations. We optimize the cross-entropy loss using `SGD` with Nesterov momentum. We used a batch size of 1024, a momentum of 

> 8 `https://github.com/Philip-Bachman/amdim-public/blob/master/costs.py` 

17 

|Architecture|Pre-train augmentations|Logits regularization|Top-1|Top-5|
|---|---|---|---|---|
||||74_._3|91_._6|
|ResNet-50(1_×_)|✓|✓|74_._4<br>74_._7|91_._8<br>91_._8|
||✓|✓|**74**_._**8**|**91**_._**8**|
||||78_._6|94_._2|
|ResNet-50(4_×_)|✓|✓|78_._6<br>78_._9|94_._3<br>94_._3|
||✓|✓|**79**_._**0**|**94**_._**5**|
||||79_._6|94_._8|
|ResNet-200(2_×_)|✓|✓|79_._6<br>79_._8|94_._8<br>95_._0|
||✓|✓|**80**_._**0**|**95**_._**0**|



Table 7: Different linear evaluation protocols on ResNet architectures by either replacing the spatial augmentations with pre-train augmentations, or regularizing the linear classifier. No pre-train augmentations and no logits regularization correspond to the evaluation protocol of the main paper, which is the same as in [8, 37]. 

0 _._ 9. We do not use any regularization methods such as weight decay, gradient clipping [86], tclip [34], or logits rescaling. We sweep over the learning rate _{_ 0 _._ 01 _,_ 0 _._ 02 _,_ 0 _._ 05 _,_ 0 _._ 1 _,_ 0 _._ 005 _}_ and the number of epochs _{_ 30 _,_ 50 _}_ and select the hyperparameters achieving the best performance on our local validation set to report test performance. 

**==> picture [454 x 213] intentionally omitted <==**

**----- Start of picture text -----**<br>
80<br>90<br>70<br>80<br>60<br>70<br>50<br>60<br>40<br>Supervised Supervised<br>30 BYOL 50 BYOL<br>SimCLR  (repro) SimCLR  (repro)<br>20 1 2 5 10 20 50 100 40 1 2 5 10 20 50 100<br>Percentage of training data Percentage of training data<br>(a) Top-1 accuracy (b) Top-5 accuracy<br>ImageNet Top-1 Accuracy (%) ImageNet Top-5 Accuracy (%)<br>**----- End of picture text -----**<br>


Figure 4: Semi-supervised training with a fraction of ImageNet labels on a ResNet-50 ( _×_ 1). 

In Table 2 1% and 10% ImageNet splits from [8] with various ResNet architectures. 

In Figure 4 1%, 2%, 5%, 10%, 20%, 50%, and 100% of the ImageNet dataset as in [32] with a ResNet-50 (1 _×_ ) architecture, and compare them with a supervised baseline and a fine-tuned `SimCLR` representation. In this case and contrary to Table 2 we don’t reuse the splits from `SimCLR` but we create our own via a balanced selection. In this setting, we observed that tuning a `BYOL` representation always outperforms a supervised baseline trained from scratch. In Figure 5, we then fine-tune the representation over multiple ResNet architectures. We observe that the largest networks are prone to overfitting as they are outperformed by ResNets with identical depth but smaller scaling factor. This overfitting is further confirmed when looking at the training and evaluation loss: large networks have lower training losses, but higher validation losses than some of their slimmer counterparts. Regularization methods are thus recommended when tuning on large architectures. 

18 

|_Supervised:_|||_Semi-supervised_|_(_100%_):_||
|---|---|---|---|---|---|
|Method|Top-1|Top-5|Method|Top-1|Top-5|
|Supervised[8]|76_._5|_−_|`SimCLR`[8]|76_._0|93_._1|
|AutoAugment [87]|77_._6|93_._8|`SimCLR`(repro)|76_._5|93_._5|
|MaxUp [75]|**78**_._**9**|**94**_._**2**|`BYOL`|**77**_._**7**|**93**_._**9**|



Table 8: Semi-supervised training with the full ImageNet on a ResNet-50 ( _×_ 1). We also report other fully supervised methods for extensive comparisons. 

We report the results in Table 8 along with supervised baselines trained on ImageNet. We observe that fine-tuning the SimCLR checkpoint does not yield better results (in our reproduction, which matches the results reported in the original paper [8]) than using a random initialization (76 _._ 5 top-1). Instead, `BYOL` ’s initialization checkpoint leads to a high final score (77 _._ 7 top-1), higher than the vanilla supervised baseline of [8], matching the strong supervised baseline of AutoAugment[87] but still 1 _._ 2 points below the stronger supervised baseline [75], which uses advanced supervised learning techniques. 

**==> picture [454 x 303] intentionally omitted <==**

**----- Start of picture text -----**<br>
ResNet-50 ResNet-101<br>50x4 101x3<br>80.0 50x3 80.0 101x2<br>50x2 101x1<br>77.5 50x1 77.5<br>75.0 75.0<br>72.5 72.5<br>70.0 70.0<br>67.5 67.5<br>65.0 65.0<br>62.5 62.5<br>60.0 60.0<br>57.5 57.5<br>2 5 10 20 50 100 2 5 10 20 50 100<br>Fraction of data used for fine-tuning (%) Fraction of data used for fine-tuning (%)<br>ResNet-152 ResNet-200<br>152x3 200x2<br>80.0 152x2 80.0 200x1<br>152x1<br>77.5 77.5<br>75.0 75.0<br>72.5 72.5<br>70.0 70.0<br>67.5 67.5<br>65.0 65.0<br>62.5 62.5<br>60.0 60.0<br>57.5 57.5<br>2 5 10 20 50 100 2 5 10 20 50 100<br>Fraction of data used for fine-tuning (%) Fraction of data used for fine-tuning (%)<br>Top-1 accuracy (%) Top-1 accuracy (%)<br>Top-1 accuracy (%) Top-1 accuracy (%)<br>**----- End of picture text -----**<br>


Figure 5: Semi-supervised training with a fraction of ImageNet labels on multiple ResNets architecture pretrained with `BYOL` . Note that large networks are facing overfitting problems. 

## **C.2 Linear evaluation on larger architectures and supervised baselines** 

Here we investigate the performance of `BYOL` with deeper and wider ResNet architectures. We compare ourselves to the best supervised baselines from [8] when available (rightmost column in table 9), which are also presented in Figure 1. Importantly, we close in on those baselines using the ResNet-50 (2 _×_ ) and the ResNet-50 (4 _×_ ) architectures, where we are within 0 _._ 4 accuracy points of the supervised performance. To the best of our knowledge, this is the first time that the gap to supervised has been closed to such an extent using a self-supervised method under the linear evaluation protocol. Therefore, in order to ensure fair comparison, and suspecting that the supervised baselines’ performance in [8] could be even further improved with appropriate data augmentations, we also report on our own reproduction of strong supervised baselines. We use RandAugment [87] data augmentation for all large 

19 

||||`BYOL`|`BYOL`|Supervised|(ours)|Supervised [8]|
|---|---|---|---|---|---|---|---|
|Architecture|Multiplier|Weights|Top-1|Top-5|Top-1|Top-5|Top-1|
|ResNet-50|1_×_|24M|74_._3|91_._6|76_._4|92_._9|76_._5|
|ResNet-101|1_×_|43M|76_._4|93_._0|78_._0|94_._0|-|
|ResNet-152|1_×_|58M|77_._3|93_._7|79_._1|94_._5|-|
|ResNet-200|1_×_|63M|77_._8|93_._9|79_._3|94_._6|-|
|ResNet-50|2_×_|94M|77_._4|93_._6|79_._9|95_._0|77_._8|
|ResNet-101|2_×_|170M|78_._7|94_._3|80_._3|95_._0|-|
|ResNet-50|3_×_|211M|78_._2|93_._9|80_._2|95_._0|-|
|ResNet-152|2_×_|232M|79_._0|94_._6|80_._6|95_._3|-|
|ResNet-200|2_×_|250M|**79**_._**6**|**94**_._**9**|80_._1|95_._2|-|
|ResNet-50|4_×_|375M|78_._6|94_._2|80_._7|**95**_._**3**|78_._9|
|ResNet-101|3_×_|382M|78_._4|94_._2|80_._7|**95**_._**3**|-|
|ResNet-152|3_×_|522M|79_._5|94_._6|**80**_._**9**|95_._2|-|



Table 9: Linear evaluation of `BYOL` on ImageNet using larger encoders. Top-1 and top-5 accuracies are reported in %. 

ResNet architectures (which are all version 1, as per [22]). We train our supervised baselines for up to 200 epochs, using SGD with a Nesterov momentum value of 0 _._ 9, a cosine-annealed learning rate after a 5 epochs linear warmup period, weight decay with a value of 1 _e −_ 4, and a label smoothing [88] value of 0 _._ 1. Results are presented in Figure 6. 

20 

**==> picture [432 x 374] intentionally omitted <==**

**----- Start of picture text -----**<br>
80<br>152 - 3 ×<br>200-2 ×<br>152 - 2 ×<br>50 - 4 ×<br>101 - 2 × 101 - 3 ×<br>78 200-1 × 50 - 3 ×<br>152 - 1 × 50 - 2 ×<br>101 - 1 ×<br>76<br>Supervised (ours)<br>Supervised [8]<br>50 - 1 × BYOL<br>74<br>25M 50M 100M 200M 400M 800M<br>Number of parameters<br>ImageNet top-1 accuracy (%)<br>**----- End of picture text -----**<br>


Figure 6: Results for linear evaluation of `BYOL` compared to fully supervised baselines with various ResNet architectures. Our supervised baselines are ran with RandAugment [87] augmentations. 

21 

## **D Transfer to other datasets** 

## **D.1 Datasets** 

|Dataset|Classes|Original train examples|Train examples|Valid. examples|Test examples|Accuracy measure|Test provided|
|---|---|---|---|---|---|---|---|
|ImageNet [21]|1000|1281167|1271158|10009|50000|Top-1 accuracy|-|
|Food101 [89]|101|75750|68175|7575|25250|Top-1 accuracy|-|
|CIFAR-10 [78]|10|50000|45000|5000|10000|Top-1 accuracy|-|
|CIFAR-100 [78]|100|50000|44933|5067|10000|Top-1 accuracy|-|
|Birdsnap [90]|500|47386|42405|4981|2443|Top-1 accuracy|-|
|Sun397 (split 1) [79]|397|19850|15880|3970|19850|Top-1 accuracy|-|
|Cars [91]|196|8144|6494|1650|8041|Top-1 accuracy|-|
|Aircraft [92]|100|3334|3334|3333|3333|Mean per-class accuracy|Yes|
|PASCAL-VOC2007 [80]|20|5011|2501|2510|4952|11-point mAP / AP50|-|
|PASCAL-VOC2012 [80]|21|10582|_−_|2119|1449|Mean IoU|-|
|DTD (split 1) [81]|47|1880|1880|1880|1880|Top-1 accuracy|Yes|
|Pets [93]|37|3680|2940|740|3669|Mean per-class accuracy|-|
|Caltech-101 [94]|101|3060|2550|510|6084|Mean per-class accuracy|-|
|Places365 [73]|365|1803460|1803460|_−_|36500|Top-1 accuracy|-|
|Flowers [95]|102|1020|1020|1020|6149|Mean per-class accuracy|Yes|



Table 10: Characteristics of image datasets used in transfer learning. When an official test split with labels is not publicly available, we use the official validation split as test set, and create a held-out validation set from the training examples. 

8], namely Food-101 dataset [89], CIFAR-10 [78] and CIFAR-100 [78], Birdsnap [90], the SUN397 scene dataset [79], Stanford Cars [91], FGVC Aircraft [92], the PASCAL VOC 2007 classification task [80], the Describable Textures Dataset (DTD) [81], Oxford-IIIT Pets [93], Caltech-101 [94], and Oxford 102 Flowers [95]. As in [8], we used the validation sets specified by the dataset creators to select hyperparameters for FGVC Aircraft, PASCAL VOC 2007, DTD, and Oxford 102 Flowers. On other datasets, we use the validation examples as test set, and hold out a subset of the training examples that we use as validation set. We use standard metrics for each datasets: 

- _Top-_ 1: 

- _Mean per class_ : We compute the top-1 accuracy for each class separately and then compute the empirical mean over the classes. 

- _Point 11-mAP_ : We compute the empirical mean _average precision_ 80]. 

- _Mean IoU:_ 80]. 

- _AP50:_ 80]. 

- For Sun397 [79], the original dataset specifies 10 train/test splits, all of which contain 50 examples/images of 397 different classes. We use the first train/test split. The original dataset specifies no validation split and therefore, the training images have been further subdivided into 40 images per class for the train split and 10 images per class for the valid split. 

- For Birdsnap [90], we use a random selection of valid images with the same number of images per category as the test split. 

- For DTD [81 

- For Caltech-101 [94 We have followed the approach used in [96]: This file defines datasets for 5 random splits of 25 training images per category, with 5 validation images per category and the remaining images used for testing. 

- For ImageNet, we took the last 10009 

- For Oxford-IIIT Pets, the valid set consists of 20 randomly selected images per class. 

Information about the dataset are summarized in Table 10. 

## **D.2** 

We follow the linear evaluation protocol of [48, 74, 8] that we detail next for completeness. We train a regularized multinomial logistic regression classifier on top of the frozen representation, i.e., with frozen pretrained parameters 

22 

and without re-computing batch-normalization statistics. In training and testing, we do not perform any image augmentations; images are resized to 224 pixels along the shorter side using bicubic resampling and then normalized with ImageNet statistics. Finally, we minimize the cross-entropy objective using `LBFGS` with _ℓ_ 2-regularization, where we select the regularization parameters from a range of 45 logarithmically-spaced values between 10 _[−]_[6] and 10[5] . After choosing the best-performing hyperparameters on the validation set, the model is retrained on combined training and validation images together, using the chosen parameters. The final accuracy is reported on the test set. 

## **D.3** 

We follow the same fine-tuning protocol as in [32, 48, 76, 8] that we also detail for completeness. Specifically, we initialize the network with the parameters of the pretrained representation. At training time, we apply spatial transformation, i.e., random crops with resize to 224 _×_ 224 pixels and random flips. At test time, images are resized to 256 pixels along the shorter side using bicubic resampling, after which a 224 _×_ 224 center crop is extracted. In both cases, we normalize the color channels by subtracting the average color and dividing by the standard deviation (computed on ImageNet), after applying the augmentations. We optimize the loss using `SGD` with Nesterov momentum for 20000 steps with a batch size of 256 and with a momentum of 0 _._ 9. We set the momentum parameter for the batch normalization statistics to max(1 _−_ 10 _/s,_ 0 _._ 9) where _s_ is the number of steps per epoch. The learning rate and weight decay are selected respectively with a grid of seven logarithmically spaced learning rates between 0 _._ 0001 and 0 _._ 1, and 7 logarithmically-spaced values of weight decay between 10 _[−]_[6] and 10 _[−]_[3] , as well as no weight decay. These values of weight decay are divided by the learning rate. After choosing the best-performing hyperparameters on the validation set, the model is retrained on combined training and validation images together, using the chosen parameters. The final accuracy is reported on the test set. 

## **D.4 Implementation details for semantic segmentation** 

We use the same fully-convolutional network (FCN)-based [7] architecture as [9]. The backbone consists of the convolutional layers in ResNet-50. The 3 _×_ 3 convolutions in the conv5 blocks use dilation 2 and stride 1. This is followed by two extra 3 _×_ 3 convolutions with 256 channels, each followed by batch normalization and ReLU activations, and a 1 _×_ 1 convolution for per-pixel classification. The dilation is set to 6 in the two extra 3 _×_ 3 convolutions. The total stride is 16 (FCN-16s [7]). 

We train on the `train_aug2012` set and report results on `val2012` . Hyperparameters are selected on a 2119 images held-out validation set. We use a standard per-pixel softmax cross-entropy loss to train the FCN. Training is done with random scaling (by a ratio in [0 _._ 5 _,_ 2 _._ 0]), cropping, and horizontal flipping. The crop size is 513. Inference is performed on the [513 _,_ 513] central crop. For training we use a batch size of 16 and weight decay of 0 _._ 0001. We select the base learning rate by sweeping across 5 logarithmically spaced values between 10 _[−]_[3] and 10 _[−]_[1] . The learning rate is multiplied by 0 _._ 1 at the 70-th and 90-th percentile of training. We train for 30000 iterations, and average the results on 5 seeds. 

## **D.5 Implementation details for object detection** 

For object detection, we follow prior work on Pascal detection transfer [40, 23] wherever possible. We use a Faster R-CNN [82] detector with a R50-C4 backbone with a frozen representation. The R50-C4 backbone ends with the conv4 stage of a ResNet-50, and the box prediction head consists of the conv5 stage (including global pooling). We preprocess the images by applying multi-scale augmentation (rescaling the image so its longest edge is between 480 and 1024 pixels) but no other augmentation. We use an asynchronous `SGD` optimizer with 9 workers and train for 1 _._ 5M steps. We used an initial learning rate of 10 _[−]_[3] , which is reduced to 10 _[−]_[4] at 1M steps and to 10 _[−]_[5] at 1 _._ 2M steps. 

## **D.6 Implementation details for depth estimation** 

For depth estimation, we follow the same protocol as in [83], and report its core components for completeness. We use a standard ResNet-50 backbone and feed the conv5 features into 4 fast up-projection blocks with respective filter sizes 512, 256, 128, and 64. We use a reverse Huber loss function for training [83, 97]. 

The original NYU Depth v2 frames of size [640 _,_ 480] are down-sampled by a factor 0 _._ 5 and center-cropped to [304 _,_ 228] pixels. Input images are randomly horizontally flipped and the following color transformations are applied: 

- _Grayscale_ with an application probability of 0 _._ 3. 

23 

- _Brightness_ with a maximum brightness difference of 0 _._ 1255. 

- _Saturation_ with a saturation factor randomly picked in the interval [0 _._ 5 _,_ 1 _._ 5]. 

- _Hue_ with a hue adjustment factor randomly picked in the interval [ _−_ 0 _._ 2 _,_ 0 _._ 2]. 

We train for 7500 steps with batch size 256, weight decay 0 _._ 0005 _,_ and learning rate 0 _._ 16 (scaled linearly from the setup of [83] to account for the bigger batch size). 

## **D.7 Further comparisons on PASCAL and NYU v2 Depth** 

For completeness, Table 11 and 12 extends Table 4 with other published baselines which use comparable networks. We see that in almost all settings, `BYOL` outperforms these baselines, even when those baselines use more data or deeper models. One notable exception is RMS error for NYU Depth prediction, which is a metric that’s sensitive to outliers. The reason for this is unclear, but one possibility is that the network is producing higher-variance predictions due to being more confident about a test-set scene’s similarities with those in the training set. 

|Method|AP50|mIoU|
|---|---|---|
|Supervised-IN [9]|74_._4|74_._4|
|RelPos [23], by [40]_∗_|66_._8|-|
|Multi-task [40]_∗_|70_._5|-|
|LocalAgg [98]|69_._1|-|
|MoCo [9]|74_._9|72_._5|
|MoCo + IG-1B [9]|75_._6|73_._6|
|CPC[32]_∗∗_|76_._6|-|
|`SimCLR`(repro)|75_._2|75_._2|
|`BYOL`(ours)|**77**_._**5**|**76**_._**3**|



Table 11: Transfer results in semantic segmentation and object detection. _∗_ uses a larger model (ResNet-101). _∗∗_ uses an even larger model (ResNet-161). 

|||Higher better||Lower better|Lower better|
|---|---|---|---|---|---|
|Method|pct._<_1_._25|pct._<_1_._252|pct._<_1_._253|rms|rel|
|Supervised-IN [83]|81_._1|95_._3|98_._8|0_._573|**0**_._**127**|
|RelPos [23], by [40]_∗_|80_._6|94_._7|98_._3|**0**_._**399**|0_._146|
|Color [41], by [40]_∗_|76_._8|93_._5|97_._7|0_._444|0_._164|
|Exemplar [46,40]_∗_|71_._3|90_._6|96_._5|0_._513|0_._191|
|Mot. Seg. [99], by [40]_∗_|74_._2|92_._4|97_._4|0_._473|0_._177|
|Multi-task [40]_∗_|79_._3|94_._2|98_._1|0_._422|0_._152|
|`SimCLR`(repro)|83_._3|96_._5|99_._1|0_._557|0_._134|
|`BYOL`(ours)|**84**_._**6**|**96**_._**7**|**99**_._**1**|0_._541|0_._129|



Table 12: Transfer results on NYU v2 depth estimation. 

## **E Pretraining on Places 365** 

To ascertain that `BYOL` learns good representations on other datasets, we applied our representation learning protocol on the scene recognition dataset Places365-Standard [73] before performing linear evaluation. This dataset contains 1 _._ 80 million training images and 36500 validation images with labels, making it roughly similar to ImageNet in scale. We reuse the _exact_ same parameters as in Section 4 and train the representation for 1000 epochs, using `BYOL` and our `SimCLR` reproduction. Results for the linear evaluation setup (using the protocol of Appendix C.1 for ImageNet and Places365, and that of Appendix D on other datasets) are reported in Table 13. 

Interestingly, the representation trained by using `BYOL` on Places365 ( `BYOL` -PL) consistently outperforms that of `SimCLR` on the same dataset, but underperforms the `BYOL` representation trained on ImageNet ( `BYOL` -IN) on all tasks except Places365 and SUN397 [79], another scene understanding dataset. Interestingly, all three unsupervised representation learning methods achieve a relatively high performance on the Places365 task; for comparison, 

24 

reference [73] (in its linked repository) reports a top-1 accuracy of 55 _._ 2% for a ResNet-50v2 trained from scratch using labels on this dataset. 

|Method|Places365|ImageNet|Food101|CIFAR10|CIFAR100|Birdsnap|SUN397|Cars|Aircraft|DTD|Pets|Caltech-101|Flowers|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|`BYOL`-IN|51_._0|74_._3|75_._3|91_._3|78_._4|57_._3|62_._6|67_._2|60_._6|76_._5|90_._4|94_._3|96_._1|
|`BYOL`-PL|**53**_._**2**|**58**_._**5**|**64**_._**7**|**84**_._**5**|**66**_._**1**|**28**_._**8**|**64**_._**2**|**55**_._**6**|**55**_._**9**|**68**_._**5**|**66**_._**1**|**84**_._**3**|**90**_._**0**|
|`SimCLR`-PL|53_._0|56_._5|61_._7|80_._8|61_._1|21_._2|62_._5|40_._1|44_._3|64_._3|59_._4|77_._1|85_._9|



Table 13: Transfer learning results (linear evaluation, ResNet-50) from Places365 (PL). For comparison purposes, we also report the results from `BYOL` trained on ImageNet ( `BYOL` -IN). 

## **F Additional ablation results** 

To extend on the above results, we provide additional ablations obtained using the same experimental setup as in Section 5, _i.e.,_ 300 epochs, averaged over 3 seeds with the initial learning rate set to 0 _._ 3, the batch size to 4096, the weight decay to 10 _[−]_[6] and the base target decay rate _τ_ base to 0 _._ 99 unless specified otherwise. Confidence intervals correspond to the half-difference between the maximum and minimum score of these seeds; we omit them for half-differences lower than 0 _._ 25 accuracy points. 

## **F.1 Architecture settings** 

Table 14 `BYOL` . We examine the effect of different depths for both the projector and predictor, as well as the effect of the projection size. We do not apply a ReLU activation nor a batch normalization on the final linear layer of our MLPs such that a depth of 1 corresponds to a linear layer. Using the default projector and predictor of depth 2 yields the best performance. 

|Proj._gθ_<br>depth<br>Pred._qθ_<br>depth<br>Top-1<br>Top-5<br>1<br>1<br>61_._9<br>86_._0<br>2<br>65_._0<br>86_._8<br>3<br>65_._7<br>86_._8<br>2<br>1<br>71_._5<br>90_._7<br>2<br>**72**_._**5**<br>**90**_._**8**<br>3<br>71_._4<br>90_._4<br>3<br>1<br>71_._4<br>90_._4<br>2<br>72_._1<br>90_._5<br>3<br>72_._1<br>90_._5||
|---|---|
||Projector_gθ_<br>output dim<br>Top-1<br>Top-5|
||16<br>69_._9_±_0_._3<br>89_._9<br>32<br>71_._3<br>90_._6<br>64<br>72_._2<br>90_._9<br>128<br>72_._5<br>91_._0<br>256<br>72_._5<br>90_._8<br>512<br>**72**_._**6**<br>**91**_._**0**|
||(b) Projection dimension.|



(a) Projector and predictor depth (i.e. the number of Linear layers). 

Table 14: Effect of architectural settings where top-1 and top-5 accuracies are reported in %. 

Table 15a shows the influence of the initial learning rate on `BYOL` . Note that the optimal value depends on the number of training epochs. Table 15b displays the influence of the weight decay on `BYOL` . 

## **F.2 Batch size** 

We run a sweep over the batch size for both `BYOL` and our reproduction of `SimCLR` . As explained in Section 5, when reducing the batch size by a factor _N_ , we average gradients over _N_ consecutive steps and update the target network once every _N_ steps. We report in Table 16, the performance of both our reproduction of `SimCLR` and `BYOL` for batch sizes between 4096 ( `BYOL` and `SimCLR` default) down to 64. We observe that the performance of `SimCLR` deteriorates faster than the one of `BYOL` which stays mostly constant for batch sizes larger than 256. We believe that the performance at batch size 256 could match the performance of the large 4096 batch size with proper parameter tuning when accumulating the gradient. We think that the drop in performance at batch size 64 in table 16 is mainly related to the ill behaviour of batch normalization at low batch sizes [100]. 

25 

|Learning<br>rate<br>Top-1<br>Top-5<br>0_._01<br>34_._8_±_3_._0<br>60_._8_±_3_._2<br>0_._1<br>65_._0<br>87_._0<br>0_._2<br>71_._7<br>90_._6<br>0_._3<br>**72**_._**5**<br>**90**_._**8**<br>0_._4<br>72_._3<br>90_._6<br>0_._5<br>71_._5<br>90_._1<br>1<br>69_._4<br>89_._2||
|---|---|
||Weight decay<br>coeffcient<br>Top-1<br>Top-5|
||1_·_10_−_7<br>72_._1<br>90_._4<br>5_·_10_−_7<br>**72**_._**6**<br>**91**_._**0**<br>1_·_10_−_6<br>72_._5<br>90_._8<br>5_·_10_−_6<br>71_._0_±_0_._3<br>90_._0<br>1_·_10_−_5<br>69_._6_±_0_._4<br>89_._3|
|||



(b) Weight decay. 

(a) Base learning rate. 

Table 15: Effect of learning rate and weight decay. We note that `BYOL` ’s performance is quite robust within a range of hyperparameters. We also observe that setting the weight decay to zero may lead to unstable results (as in `SimCLR` ). 

|Batch||Top-1||Top-5|
|---|---|---|---|---|
|size|`BYOL`(ours)|`SimCLR`(repro)|`BYOL`(ours)|`SimCLR`(repro)|
|4096|**72**_._**5**|67_._9|**90**_._**8**|88_._5|
|2048|72_._4|67_._8|90_._7|88_._5|
|1024|72_._2|67_._4|90_._7|88_._1|
|512|72_._2|66_._5|90_._8|87_._6|
|256|71_._8|64_._3_±_2_._1|90_._7|86_._3_±_1_._0|
|128|69_._6_±_0_._5|63_._6|89_._6|85_._9|
|64|59_._7_±_1_._5|59_._2_±_2_._9|83_._2_±_1_._2|83_._0_±_1_._9|



Table 16: 

## **F.3 Image augmentations** 

Table 17 compares the impact of individual image transformations on `BYOL` and `SimCLR` . `BYOL` is more resilient to changes of image augmentations across the board. For completeness, we also include an ablation with symmetric parameters across both views; for this ablation, we use a Gaussian blurring w.p. of 0 _._ 5 and a solarization w.p. of 0 _._ 2 for both _T_ and _T[′]_ , and recover very similar results compared to our baseline choice of parameters. 

|||Top-1||Top-5|
|---|---|---|---|---|
|Image augmentation|`BYOL`(ours)|`SimCLR`(repro)|`BYOL`(ours)|`SimCLR`(repro)|
|Baseline|**72**_._**5**|67_._9|**90**_._**8**|88_._5|
|Remove fip|71_._9|67_._3|90_._6|88_._2|
|Remove blur|71_._2|65_._2|90_._3|86_._6|
|Remove color (jittering and grayscale)|63_._4_±_0_._7|45_._7|85_._3_±_0_._5|70_._6|
|Remove color jittering|71_._8|63_._7|90_._7|85_._9|
|Remove grayscale|70_._3|61_._9|89_._8|84_._1|
|Remove blur in_T ′_|72_._4|67_._5|90_._8|88_._4|
|Remove solarize in_T ′_|72_._3|67_._7|90_._8|88_._2|
|Remove blur and solarize in_T ′_|72_._2|67_._4|90_._8|88_._1|
|Symmetric blurring/solarization|72_._5|68_._1|90_._8|88_._4|
|Crop only<br>Crop and fip only|59_._4_±_0_._3<br>60_._1_±_0_._3|40_._3_±_0_._3<br>40_._2|82_._4<br>83_._0_±_0_._3|64_._8_±_0_._4<br>64_._8|
|Crop and color only|70_._7|64_._2|90_._0|86_._2|
|Crop and blur only|61_._1_±_0_._3|41_._7|83_._9|66_._4|



Table 17: Ablation on image transformations. 

26 

|Loss weight_β_|Temperature_α_|Top-1|Top-5|
|---|---|---|---|
|0|0_._1|72_._5|90_._8|
||0_._01|72_._2|90_._7|
||0_._1|72_._4|90_._9|
||0_._3|**72**_._**7**|91_._0|
|0_._1|1|72_._6|90_._9|
||3|72_._5|90_._9|
||10|72_._5|90_._9|
||0_._01|70_._9|90_._2|
||0_._1|72_._0|90_._8|
||0_._3|**72**_._**7**|**91**_._**2**|
|0_._5|1|72_._7|91_._1|
||3|72_._6|91_._1|
||10|72_._5|91_._0|
||0_._01|53_._9_±_0_._5|77_._5_±_0_._5|
||0_._1|70_._9|90_._3|
|1|0_._3<br>1|**72**_._**7**<br>**72**_._**7**|91_._1<br>91_._1|
||3|72_._6|91_._0|
||10|72_._6|91_._1|



Table 18: Top-1 accuracy in % under linear evaluation protocol at 300 epochs of sweep over the temperature _α_ and the dispersion term weight _β_ when using a predictor and a target network. 

## **F.4 Details on the relation to contrastive methods** 

As mentioned in Section 5, the `BYOL` loss Eq. 2 can be derived from the InfoNCE loss 

with 

**==> picture [415 x 76] intentionally omitted <==**

The InfoNCE loss, introduced in [10], can be found in factored form in [84] as 

**==> picture [314 x 36] intentionally omitted <==**

As in `SimCLR` [8] we also use negative examples given by ( _vi, vj_ ) _j_ = _i_ to get 

**==> picture [398 x 77] intentionally omitted <==**

To obtain Eq. 8 from Eq. 12, we subtract ln _B_ (which is independent of _θ_ ), multiply by 2 _α_ , take _f_ ( _x, y_ ) = _Sθ_ ( _x, y_ ) _/α_ and finally multiply the second (negative examples) term by _β_ . Using _β_ = 1 and dividing by 2 _α_ gets us back to the usual InfoNCE loss as used by `SimCLR` . 

In our ablation in Table 5b, we set the temperature _α_ to its best value in the `SimCLR` setting (i.e., _α_ = 0 _._ 1). With this value, setting _β_ to 1 (which adds negative examples), in the `BYOL` setting (i.e., with both a predictor and a target network) hurts the performances. In Table 18, we report results of a sweep over both the temperature _α_ and the 

27 

|Method|Predictor|Target parameters|_β_|Top-1|
|---|---|---|---|---|
|`BYOL`|✓|_ξ_|0|**72**_._**5**|
||✓|_ξ_|1|70_._9|
|||_ξ_|1|70_._7|
||✓|sg(_θ_)|1|70_._2|
|`SimCLR`||_θ_|1|69_._4|
||✓|sg(_θ_)|1|70_._1|
|||sg(_θ_)|1|69_._2|
||✓|_θ_|1|69_._0|
||✓|sg(_θ_)|0|5_._5|
||✓|_θ_|0|0_._3|
|||_ξ_|0|0_._2|
|||sg(_θ_)|0|0_._1|
|||_θ_|0|0_._1|



Table 19: Top-1 accuracy in %, under linear evaluation protocol at 300 epochs, of intermediate variants between `BYOL` and `SimCLR` (with caveats discussed in Appendix F.5). sg means stop gradient. 

weight parameter _β_ with a predictor and a target network where `BYOL` corresponds to _β_ = 0. No run significantly outperforms `BYOL` and some values of _α_ and _β_ hurt the performance. While the best temperature for `SimCLR` (without the target network and a predictor) is 0 _._ 1, after adding a predictor and a target network the best temperature _α_ is higher than 0 _._ 3. 

Using a target network in the loss has two effects: stopping the gradient through the prediction targets and stabilizing the targets with averaging. Stopping the gradient through the target change the objective while averaging makes the target stable and stale. In Table 5b we only shows results of the ablation when either using the online network as the prediction target (and flowing the gradient through it) or with a target network (both stopping the gradient into the prediction targets and computing the prediction targets with a moving average of the online network). We shown in Table 5b that using a target network is beneficial but it has two distinct effects we would like to understand from which effect the improvement comes from. We report in Table 19 the results already in Table 5b but also when the prediction target is computed with a stop gradient of the online network (the gradient does not flow into the prediction targets). This shows that making the prediction targets stable and stale is the main cause of the improvement rather than the change in the objective due to the stop gradient. 

## **F.5** **`SimCLR` baseline of Section 5** 

The `SimCLR` baseline in Section 5 ( _β_ = 1, without predictor nor target network) is slightly different from the original one in [8]. First we multiply the original loss by 2 _α_ . For comparaison here is the original `SimCLR` loss, 

**==> picture [404 x 37] intentionally omitted <==**

Note that this multiplication by 2 _α_ matters as the `LARS` optimizer is not completely invariant with respect to the scale of the loss. Indeed, `LARS` applies a preconditioning to gradient updates on all weights, except for biases and batch normalization parameters. Updates on preconditioned weights are invariant by multiplicative scaling of the loss. However, the bias and batch normalization parameter updates remain sensitive to multiplicative scaling of the loss. 

We also increase the original `SimCLR` hidden and output size of the projector to respectively 4096 and 256. In our reproduction of `SimCLR` , these three combined changes improves the top-1 accuracy at 300 epochs from 67 _._ 9% (without the changes) to 69 _._ 2% (with the changes). 

## **F.6 Ablation on the normalization in the loss function** 

`BYOL` minimizes a squared error between the _ℓ_ 2-normalized prediction and target. We report results of `BYOL` at 300 epochs using different normalization function and no normalization at all. More precisely, given batch of prediction and targets in R _[d]_ , ( _pi, ti_ ) _i≤B_ with _B_ the batch size, `BYOL` uses the loss function _B_[1] � _Bi_ =1 _[∥][n][ℓ]_ 2[(] _[p][i]_[)] _[ −][n][ℓ]_ 2[(] _[z][i]_[)] _[∥]_ 2[2] with _nℓ_ 2 : _x → x/∥x∥_ 2. We run `BYOL` with other normalization functions: non-trainable batch-normalization 

28 

**==> picture [355 x 416] intentionally omitted <==**

**----- Start of picture text -----**<br>
10 [3]<br>10 [2] BatchNorm<br>LayerNorm<br>None<br>10 [1]<br>0 100 200 300<br>Training epochs<br>(a) Representation  ℓ 2-norm<br>10 [7]<br>10 [6]<br>10 [5]<br>BatchNorm<br>10 [4]<br>LayerNorm<br>None<br>10 [3]<br>10 [2]<br>10 [1]<br>0 100 200 300<br>Training epochs<br>(b) Projection  ℓ 2-norm<br> norm<br>2<br>Representation<br> norm<br>2<br>Projection<br>**----- End of picture text -----**<br>


Figure 7: Effect of normalization on the _ℓ_ 2 norm of network outputs. 

|Normalization|Top-1|Top-5|
|---|---|---|
|_ℓ_2-norm|**72**_._**5**|**90**_._**8**|
|LAYERNORM|72_._5_±_0_._4|90_._1|
|No normalization|67_._4|87_._1|
|BATCHNORM|65_._3|85_._3|



Table 20: Top-1 accuracy in % under linear evaluation protocol at 300 epochs for different normalizations in the loss. 

and layer-normalization and no normalization. We divide the batch normalization and layer normalization by _√d_ to have a consistent scale with the _ℓ_ 2-normalization. We report results in Table 20 where _ℓ_ 2, LAYERNORM, no normalization and BATCHNORM respectively denote using _nℓ_ 2, _n_ BN, _n_ LN and _n_ ID with 

29 

**==> picture [294 x 104] intentionally omitted <==**

When using no normalization at all, the projection _ℓ_ 2 norm rapidly increases during the first 100 epochs and stabilizes at around 3 _·_ 10[6] as shown in Figure 7. Despite this behaviour, using no normalization still performs reasonably well (67 _._ 4%). The _ℓ_ 2 normalization performs the best. 

## **G Training with smaller batch sizes** 

The results described in Section 4 were obtained using a batch size of 4096 split over 512 TPU cores. Due to its increased robustness, `BYOL` can also be trained using smaller batch sizes without significantly decreasing performance. Using the same linear evaluation setup, `BYOL` achieves 73 _._ 7% top-1 accuracy when trained over 1000 epochs with a batch size of 512 split over 64 TPU cores (approximately 4 days of training). For this setup, we reuse the same setting as in Section 3, but use a base learning rate of 0 _._ 4 (appropriately scaled by the batch size) and _τ_ base = 0 _._ 9995 with the same weight decay coefficient of 1 _._ 5 _·_ 10 _[−]_[6] . 

## **H Details on Equation 5 in Section 3.2** 

In this section we clarify why `BYOL` ’s update is related to Eq. 5 from Section 3.2, 

**==> picture [387 x 31] intentionally omitted <==**

Recall that _q[⋆]_ 

**==> picture [356 x 22] intentionally omitted <==**

and implicitly depends on _θ_ and _ξ_ ; therefore, it should be denoted as _q[⋆]_ ( _θ, ξ_ ) instead of just _q[⋆]_ . For simplicity we write _q[⋆]_ ( _θ, ξ_ )( _zθ_ ) as _q[⋆]_ ( _θ, ξ, zθ_ ) the output of the optimal predictor for any parameters _θ_ and _ξ_ and input _zθ_ . 

`BYOL` updates its online parameters following the gradient of Eq. 5, but considering only the gradients of _q_ with respect to its third argument _z_ when applying the chain rule. If we rewrite 

**==> picture [352 x 61] intentionally omitted <==**

the gradient of this quantity w.r.t. _θ_ is 

where _[∂] ∂θ[q][⋆]_[and] _[∂] ∂z[q][⋆]_[are the gradients of] _[ q][⋆]_[with respect to its first and last argument.][Using the envelope theorem,] and thanks to the optimality condition of the predictor, the term E� _∂L∂q[·][∂] ∂θ[q][⋆]_ � = 0. Therefore, the remaining term E� _∂L∂q[·][∂] ∂z[q][⋆][·][∂z] ∂θ[θ]_ � where gradients are only back-propagated through the predictor’s input is exactly the direction followed by `BYOL` . 

## **I Importance of a near-optimal predictor** 

In this part we build upon the intuitions of Section 3.2 on the importance of keeping the predictor near-optimal. Specifically, we show that it is possible to remove the exponential moving average in `BYOL` ’s target network ( _i.e._ , simply copy weights of the online network into the target) without causing the representation to collapse, provided the predictor remains sufficiently good. 

30 

## **I.1 Predictor learning rate** 

In this setup, we remove the exponential moving average ( _i.e._ , set _τ_ = 0 over the full training in Eq. 1), and multiply the learning rate of the predictor by a constant _λ_ compared to the learning rate used for the rest of the network; all other hyperparameters are unchanged. As shown in Table 21, using sufficiently large values of _λ_ provides a reasonably good level of performance and the performance sharply decreases with _λ_ to 0 _._ 01% top-1 accuracy (no better than random) for _λ_ = 0. 

To show that this effect is directly related to a change of behavior in the predictor, and not only to a change of learning rate in any subpart of the network, we perform a similar experiment by using a multiplier _λ_ on the _predictor_ ’s learning rate, and a different multiplier _µ_ for the _projector_ . In Table 22, we show that the representation typically collapses or performs poorly when the predictor learning rate is lower or equal to that of the projector. As mentioned in Section 3.2, we further hypothesize that one of the contributions of the target network is to maintain a near optimal predictor at all times. 

## **I.2 Optimal linear predictor in closed form** 

Similarly, we can get rid of the slowly moving target network if we use a closed form optimal predictor on the batch, instead of a learned, non-optimal one. In this case we restrict ourselves to a linear predictor, 

**==> picture [191 x 22] intentionally omitted <==**

with _∥·∥_ 2 being the Frobenius norm, _Zθ_ and _Zξ[′]_[of][shape][(] _[B, F]_[)][respectively][the][online][and][target][projections,] where _B_ is the batch size and _F_ the number of features; and _q[⋆]_ of shape ( _F, F_ ), the optimal linear predictor for the batch. 

At 300 epochs, when using the closed form optimal predictor, and directly hard copying the weights of the online network into the target, we obtain a top-1 accuracy of _fill_ . 

|_λ_|Top-1|
|---|---|
|0|0_._01|
|1|5_._5|
|2|62_._8_±_1_._5|
|10|66_._6|
|20|66_._3_±_0_._3|
|Baseline|72_._5|



Table 21: Top-1 accuracy at 300 epochs when removing the slowly moving target network, directly hard copying the weights of the online network into the target network, and applying a multiplier to the predictor learning rate. 

||||_λpred_|
|---|---|---|---|
||||1<br>1_._5<br>2<br>5<br>10|
||_µproj_|1<br>1_._5<br>2<br>5<br>10|3_._2_±_2_._9<br>25_._7_±_6_._6<br>60_._8_±_2_._9<br>66_._7_±_0_._4<br>66_._9<br>1_._4_±_2_._0<br>9_._2_±_7_._0<br>55_._2_±_5_._8<br>61_._5_±_0_._6<br>66_._0_±_0_._3<br>2_._0_±_2_._8<br>5_._3_±_1_._9<br>15_._8_±_13_._4<br>60_._9_±_0_._8<br>66_._3<br>1_._5_±_0_._9<br>2_._5_±_1_._5<br>2_._5_±_1_._4<br>20_._5_±_2_._0<br>60_._5_±_0_._6<br>0_._1<br>2_._1_±_0_._3<br>1_._9_±_0_._8<br>2_._8_±_0_._4<br>8_._3_±_6_._8|



Table 22: Top-1 accuracy at 300 epochs when removing the slowly moving target network, directly hard copying the weights of the online network in the target network, and applying a multiplier _µ_ to the projector and _λ_ to the predictor learning rate. The predictor learning rate needs to be higher than the projector learning rate in order to successfully remove the target network. This further suggests that the learning dynamic of predictor is central to `BYOL` ’s stability. 

31 

**==> picture [188 x 198] intentionally omitted <==**

**----- Start of picture text -----**<br>
Online network<br>a qo<br>Exponential Moving<br>Average<br>v<br>|<br>B o<br>Target network<br>MLP MLP<br>ResNet Projection Prediction<br>Img embedding<br>MLP<br>ResNet Projection<br>Img embedding<br>**----- End of picture text -----**<br>


Figure 8: BYOL sketch summarizing the method by emphasizing the neural architecture. 

32 

## **J** **`BYOL` pseudo-code in JAX** 

## **J.1 Hyper-parameters** 

```
HPS=dict(
```

```
max_steps=int(1000.*1281167/4096),#1000epochs
batch_size=4096,
mlp_hidden_size=4096,
projection_size=256,
base_target_ema=4e-3,
optimizer_config=dict(
optimizer_name='lars',
beta=0.9,
trust_coef=1e-3,
weight_decay=1.5e-6,
#AsinSimCLRandofficialimplementationofLARS,weexcludebias
#andbatchnormweightfromtheLarsadaptationandweightdecay.
exclude_bias_from_adaption=True),
learning_rate_schedule=dict(
#Thelearningrateislinearlyincreaseupto
#itsbasevalue*batchisze/256afterwarmup_steps
#globalstepsandthenannealwithacosineschedule.
base_learning_rate=0.2,
warmup_steps=int(10.*1281167/4096),
anneal_schedule='cosine'),
batchnorm_kwargs=dict(
decay_rate=0.9,
eps=1e-5),
seed=1337,
)
```

## **J.2** 

```
defnetwork(inputs):
"""Buildtheencoder,projectorandpredictor."""
embedding=ResNet(name='encoder',configuration='ResNetV1_50x1')(inputs)
proj_out=MLP(name='projector')(embedding)
pred_out=MLP(name='predictor')(proj_out)
returndict(projection=proj_out,prediction=pred_out)
```

```
classMLP(hk.Module):
"""MultiLayerPerceptron,withnormalization."""
def__init(self,name):
super().__init__(name=name)
def__call__(self,inputs):
out=hk.Linear(output_size=HPS['mlp_hidden_size'])(inputs)
out=hk.BatchNorm(**HPS['batchnorm_kwargs'])(out)
out=jax.nn.relu(out)
out=hk.Linear(output_size=HPS['projection_size'])(out)
returnout
#Forsimplicity,weomitBatchNormrelatedstates.
#Intheactualcode,weusehk.transform_with_state.Thecorresponding
#net_initfunctionoutputsbothaparamsandastatevariable,
#withstatecontainingthemovingaveragescomputedbyBatchNorm
net_init,net_apply=hk.transform(network)
```

33 

## **J.3 Loss function** 

```
defloss_fn(online_params,target_params,image_1,image_2):
"""ComputeBYOL'slossfunction.
Args:
online_params:parametersoftheonlinenetwork(thelossislater
differentiatedwithrespecttotheonlineparameters).
target_params:parametersofthetargetnetwork.
image_1:firsttransformationoftheinputimage.
image_2:secondtransformationoftheinputimage.
Returns:
BYOL'slossfunction.
"""
online_network_out_1=net_apply(params=online_params,inputs=image_1)
online_network_out_2=net_apply(params=online_params,inputs=image_2)
target_network_out_1=net_apply(params=target_params,inputs=image_1)
target_network_out_2=net_apply(params=target_params,inputs=image_2)
defregression_loss(x,y):
norm_x,norm_y=jnp.linalg.norm(x,axis=-1),jnp.linalg.norm(y,axis=-1)
return-2.*jnp.mean(jnp.sum(x*y,axis=-1)/(norm_x*norm_y))
#Thestop_gradientisnotnecessaryasweexplicitlytakethegradientwith
#respecttoonlineparametersonly.Weleaveittoindicatethatgradients
#arenotbackpropagatedthroughthetargetnetwork.
loss=regression_loss(online_network_out_1['prediction'],
jax.lax.stop_gradient(target_network_out_2['projection']))
loss+=regression_loss(online_network_out_2['prediction'],
jax.lax.stop_gradient(target_network_out_1['projection']))
returnloss
```

## **J.4 Training loop** 

```
defmain(dataset):
"""Maintrainingloop."""
rng=jax.random.PRNGKey(HPS['seed'])
rng,rng_init=jax.random.split(rng,num=2)
dataset=dataset.batch(HPS['batch_size'])
dummy_input=dataset.next()
byol_state=init(rng_init,dummy_input)
forglobal_stepinrange(HPS['max_steps']):
inputs=dataset.next()
rng,rng1,rng2=jax.random.split(rng,num=3)
image_1=simclr_augmentations(inputs,rng1,image_number=1)
image_2=simclr_augmentations(inputs,rng2,image_number=2)
byol_state=update_fn(
**byol_state,
global_step=global_step,
image_1=image_1,
image_2=image_2)
```

```
returnbyol_state['online_params']
```

34 

## **J.5 Update function** 

```
optimizer=Optimizer(**HPS['optimizer_config'])
```

```
defupdate_fn(online_params,target_params,opt_state,global_step,image_1,
image_2):
"""Updateonlineandtargetparameters.
Args:
online_params:parametersoftheonlinenetwork(thelossisdifferentiated
withrespecttotheonlineparametersonly).
target_params:parametersofthetargetnetwork.
opt_state:stateoftheoptimizer.
global_step:currenttrainingstep.
image_1:firsttransformationoftheinputimage.
image_2:secondtransformationoftheinputimage.
```

```
Returns:
Dictcontainingupdatedonlineparameters,targetparametersand
optimizationstate.
"""
#updateonlinenetwork
grad_fn=jax.grad(loss_fn,argnums=0)
grads=grad_fn(online_params,target_params,image_1,image_2)
lr=learning_rate(global_step,**HPS['learning_rate_schedule'])
updates,opt_state=optimizer(lr).apply(grads,opt_state,online_params)
online_params=optix.apply_updates(online_params,updates)
```

```
#updatetargetnetwork
tau=target_ema(global_step,base_ema=HPS['base_target_ema'])
target_params=jax.tree_multimap(lambdax,y:x+(1-tau)*(y-x),
target_params,online_params)
returndict(
online_params=online_params,
target_params=target_params,
opt_state=opt_state)
```

```
definit(rng,dummy_input):
"""BYOL'sstateinitialization.
```

```
Args:
rng:randomnumbergeneratorusedtoinitializeparameters.
dummy_input:adummyimage,usedtocomputeintermediateoutputsshapes.
```

```
Returns:
```

```
Dictcontaininginitialonlineparameters,targetparametersand
optimizationstate.
"""
online_params=net_init(rng,dummy_input)
target_params=net_init(rng,dummy_input)
opt_state=optimizer(0).init(online_params)
returndict(
online_params=online_params,
target_params=target_params,
opt_state=opt_state)
```

35 

