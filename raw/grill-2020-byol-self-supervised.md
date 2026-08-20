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
