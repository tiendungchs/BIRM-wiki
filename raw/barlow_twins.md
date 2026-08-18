**Barlow Twins: Self-Supervised Learning via Redundancy Reduction** 

**Jure Zbontar**[* 1] **Li Jing**[* 1] **Ishan Misra**[1] **Yann LeCun**[1 2] **St´ephane Deny**[1] 

## **Abstract** 

Self-supervised learning (SSL) is rapidly closing the gap with supervised methods on large computer vision benchmarks. A successful approach to SSL is to learn embeddings which are invariant to distortions of the input sample. However, a recurring issue with this approach is the existence of trivial constant solutions. Most current methods avoid such solutions by careful implementation details. We propose an objective function that naturally avoids collapse by measuring the cross-correlation matrix between the outputs of two identical networks fed with distorted versions of a sample, and making it as close to the identity matrix as possible. This causes the embedding vectors of distorted versions of a sample to be similar, while minimizing the redundancy between the components of these vectors. The method is called BARLOW TWINS, owing to neuroscientist H. Barlow’s _redundancy-reduction principle_ applied to a pair of identical networks. BARLOW TWINS does not require large batches nor asymmetry between the network twins such as a predictor network, gradient stopping, or a moving average on the weight updates. Intriguingly it benefits from very high-dimensional output vectors. BARLOW TWINS outperforms previous methods on ImageNet for semi-supervised classification in the low-data regime, and is on par with current state of the art for ImageNet classification with a linear classifier head, and for transfer tasks of classification and object detection.[1] 

_Figure 1._ BARLOW TWINS’s objective function measures the crosscorrelation matrix between the embeddings of two identical networks fed with distorted versions of a batch of samples, and tries to make this matrix close to the identity. This causes the embedding vectors of distorted versions of a sample to be similar, while minimizing the redundancy between the components of these vectors. BARLOW TWINS is competitive with state-of-the-art methods for self-supervised learning while being conceptually simpler, naturally avoiding trivial constant (i.e. collapsed) embeddings, and being robust to the training batch size. 

## **1. Introduction** 

Self-supervised learning aims to learn useful representations of the input data without relying on human annotations. Recent advances in self-supervised learning for visual data (Caron et al., 2020; Chen et al., 2020a; Grill et al., 2020; He et al., 2019; Misra & van der Maaten, 2019) show that it is possible to learn self-supervised representations that are competitive with supervised representations. A common underlying theme that unites these methods is that they all aim to learn representations that are invariant under different distortions (also referred to as ‘data augmentations’). This 

> *Equal contribution 1Facebook AI Research 2New York University, NY, USA. Correspondence to: Jure Zbontar _<_ jzb@fb.com _>_ , Li Jing _<_ ljng@fb.com _>_ , Ishan Misra _<_ imisra@fb.com _>_ , Yann LeCun _<_ yann@fb.com _>_ , Stephane´ Deny _<_ stephane.deny.pro@gmail.com _>_ . 

_Proceedings of the 38[th] International Conference on Machine Learning_ , PMLR 139, 2021. Copyright 2021 by the author(s). 

> 1Code and pre-trained models (in PyTorch) are available at https://github.com/facebookresearch/barlowtwins 

**Barlow Twins: Self-Supervised Learning via Redundancy Reduction** 

is typically achieved by maximizing similarity of representations obtained from different distorted versions of a sample using a variant of Siamese networks (Hadsell et al., 2006). As there are trivial solutions to this problem, like a constant representation, these methods rely on different mechanisms to learn useful representations. 

Contrastive methods like SIMCLR (Chen et al., 2020a) define ‘positive’ and ‘negative’ sample pairs which are treated differently in the loss function. Additionally, they can also use asymmetric learning updates wherein momentum encoders (He et al., 2019) are updated separately from the main network. Clustering methods use one distorted sample to compute ‘targets’ for the loss, and another distorted version of the sample to predict these targets, followed by an alternate optimization scheme like k-means in DEEPCLUSTER (Caron et al., 2018) or non-differentiable operators in SWAV (Caron et al., 2020) and SELA (Asano et al., 2020). In another recent line of work, BYOL (Grill et al., 2020) and SIMSIAM (Chen & He, 2020), both the network architecture and parameter updates are modified to introduce asymmetry. The network architecture is modified to be asymmetric using a special ‘predictor’ network and the parameter updates are asymmetric such that the model parameters are only updated using one distorted version of the input, while the representations from another distorted version are used as a fixed target. (Chen & He, 2020) conclude that the asymmetry of the learning update, ‘stop-gradient’, is critical to preventing trivial solutions. 

In this paper, we propose a new method, BARLOW TWINS, which applies _redundancy-reduction_ — a principle first proposed in neuroscience — to self-supervised learning. In his influential article _Possible Principles Underlying the Transformation of Sensory Messages_ (Barlow, 1961), neuroscientist H. Barlow hypothesized that the goal of sensory processing is to recode highly redundant sensory inputs into a factorial code (a code with statistically independent components). This principle has been fruitful in explaining the organization of the visual system, from the retina to cortical areas (see (Barlow, 2001) for a review and (Lindsey et al., 2020; Ocko et al., 2018; Schwartz & Simoncelli, 2001) for recent efforts), and has led to a number of algorithms for supervised and unsupervised learning (Balle´ et al., 2017; Deco & Parra, 1997; Foldi¨ ak´ , 1990; Linsker, 1988; Redlich, 1993a;b; Schmidhuber et al., 1996). Based on this principle, we propose an objective function which tries to make the cross-correlation matrix computed from twin embeddings as close to the identity matrix as possible. BARLOW TWINS is conceptually simple, easy to implement and learns useful representations as opposed to trivial solutions. Compared to other methods, it does not require large batches (Chen et al., 2020a), nor does it require any asymmetric mechanisms like prediction networks (Grill et al., 2020), momentum encoders (He et al., 2019), non-differentiable operators (Caron et al., 

2020) or stop-gradients (Chen & He, 2020). Intriguingly, BARLOW TWINS strongly benefits from the use of very high-dimensional embeddings. BARLOW TWINS outperforms previous methods on ImageNet for semi-supervised classification in the low-data regime (55% top-1 accuracy for 1% labels), and is on par with current state of the art for ImageNet classification with a linear classifier head, as well as for a number of transfer tasks of classification and object detection. 

## **2. Method** 

## **2.1. Description of BARLOW TWINS** 

Like other methods for SSL (Caron et al., 2020; Chen et al., 2020a; Grill et al., 2020; He et al., 2019; Misra & van der Maaten, 2019), BARLOW TWINS operates on a joint embedding of distorted images (Fig. 1). More specifically, it produces two distorted views for all images of a batch _X_ sampled from a dataset. The distorted views are obtained via a distribution of data augmentations _T_ . The two batches of distorted views _Y[A]_ and _Y[B]_ are then fed to a function _fθ_ , typically a deep network with trainable parameters _θ_ , producing batches of embeddings _Z[A]_ and _Z[B]_ respectively. To simplify notations, _Z[A]_ and _Z[B]_ are assumed to be meancentered along the batch dimension, such that each unit has mean output 0 over the batch. 

BARLOW TWINS distinguishes itself from other methods by its innovative loss function _LBT_ : 

**==> picture [210 x 39] intentionally omitted <==**

where _λ_ is a positive constant trading off the importance of the first and second terms of the loss, and where _C_ is the cross-correlation matrix computed between the outputs of the two identical networks along the batch dimension: 

**==> picture [185 x 35] intentionally omitted <==**

where _b_ indexes batch samples and _i, j_ index the vector dimension of the networks’ outputs. _C_ is a square matrix with size the dimensionality of the network’s output, and with values comprised between -1 (i.e. perfect anti-correlation) and 1 (i.e. perfect correlation). 

Intuitively, the _invariance term_ of the objective, by trying to equate the diagonal elements of the cross-correlation matrix to 1, makes the embedding invariant to the distortions applied. The _redundancy reduction term_ , by trying to equate the off-diagonal elements of the cross-correlation 

**Barlow Twins: Self-Supervised Learning via Redundancy Reduction** 

matrix to 0, decorrelates the different vector components of the embedding. This decorrelation reduces the redundancy between output units, so that the output units contain non-redundant information about the sample. 

More formally, BARLOW TWINS’s objective function can be understood through the lens of information theory, and specifically as an instanciation of the _Information Bottleneck (IB)_ objective (Tishby & Zaslavsky, 2015; Tishby et al., 2000). Applied to self-supervised learning, the IB objective consists in finding a representation that conserves as much information about the sample as possible while being the _least_ possible informative about the specific distortions applied to that sample. The mathematical connection between BARLOW TWINS’s objective function and the IB principle is explored in Appendix A. 

BARLOW TWINS’ objective function has similarities with existing objective functions for SSL. For example, the redundancy reduction term plays a role similar to the _contrastive term_ in the INFONCE objective (Oord et al., 2018), as discussed in detail in Section 5. However, important conceptual differences in these objective functions result in practical advantages of our method compared to INFONCE-based methods, namely that (1) our method does not require a large number of negative samples and can thus operate on small batches (2) our method benefits from very high-dimensional embeddings. Alternatively, the redundancy reduction term can be viewed as a _soft-whitening_ constraint on the embeddings, connecting our method to a recently proposed method performing a _hard-whitening_ operation on the embeddings (Ermolov et al., 2020), as discussed in Section 5. However, our method performs better than current hard-whitening methods. 

**Algorithm 1** PyTorch-style pseudocode for Barlow Twins. 

**# f: encoder network # lambda: weight on the off-diagonal terms # N: batch size # D: dimensionality of the embeddings # # mm: matrix-matrix multiplication # off_diagonal: off-diagonal elements of a matrix # eye: identity matrix for x in loader: # load a batch with N samples # two randomly augmented versions of x y_a, y_b = augment(x) # compute embeddings z_a = f(y_a) # NxD z_b = f(y_b) # NxD # normalize repr. along the batch dimension z_a_norm = (z_a - z_a.mean(0)) / z_a.std(0) # NxD z_b_norm = (z_b - z_b.mean(0)) / z_b.std(0) # NxD # cross-correlation matrix c = mm(z_a_norm.T, z_b_norm) / N # DxD # loss c_diff = (c - eye(D)).pow(2) # DxD # multiply off-diagonal elems of c_diff by lambda off_diagonal(c_diff).mul_(lambda) loss = c_diff.sum() # optimization step loss.backward() optimizer.step()** 

2048 output units) followed by a projector network. The projector network has three linear layers, each with 8192 output units. The first two layers of the projector are followed by a batch normalization layer and rectified linear units. We call the output of the encoder the ’representations’ and the output of the projector the ’embeddings’. The representations are used for downstream tasks and the embeddings are fed to the loss function of BARLOW TWINS. 

The pseudocode for BARLOW TWINS is shown as Algorithm 1. 

## **2.2. Implementation Details** 

**Image augmentations** Each input image is transformed twice to produce the two distorted views shown in Figure 1. The image augmentation pipeline consists of the following transformations: random cropping, resizing to 224 _×_ 224, horizontal flipping, color jittering, converting to grayscale, Gaussian blurring, and solarization. The first two transformations (cropping and resizing) are always applied, while the last five are applied randomly, with some probability. This probability is different for the two distorted views in the last two transformations (blurring and solarization). We use the same augmentation parameters as BYOL (Grill et al., 2020). 

**Architecture** The encoder consists of a ResNet-50 network (He et al., 2016) (without the final classification layer, 

> **Optimization** We follow the optimization protocol described in BYOL (Grill et al., 2020). We use the LARS optimizer (You et al., 2017) and train for 1000 epochs with a batch size of 2048. We however emphasize that our model works well with batches as small as 256 (see Ablations). We use a learning rate of 0.2 for the weights and 0.0048 for the biases and batch normalization parameters. We multiply the learning rate by the batch size and divide it by 256. We use a learning rate warm-up period of 10 epochs, after which we reduce the learning rate by a factor of 1000 using a cosine decay schedule (Loshchilov & Hutter, 2016). We ran a search for the trade-off parameter _λ_ of the loss function and found the best results for _λ_ = 5 _·_ 10 _[−]_[3] . We use a weight decay parameter of 1 _._ 5 _·_ 10 _[−]_[6] . The biases and batch normalization parameters are excluded from LARS adaptation and weight decay. Training is distributed across 32 V100 GPUs and takes approximately 124 hours. For comparison, our reimplementation of BYOL trained with a batch size of 4096 takes 113 hours on the same hardware. 

**Barlow Twins: Self-Supervised Learning via Redundancy Reduction** 

## **3. Results** 

We follow standard practice (Goyal et al., 2019) and evaluate our representations by transfer learning to different datasets and tasks in computer vision. Our network is pretrained using self-supervised learning on the training set of the ImageNet ILSVRC-2012 dataset (Deng et al., 2009) (without labels). We evaluate our model on a variety of tasks such as image classification and object detection, and using fixed representations from the network or finetuning it. We provide the hyperparameters for all the transfer learning experiments in the Appendix. 

## **3.1. Linear and Semi-Supervised Evaluations on ImageNet** 

**Linear evaluation on ImageNet** We train a linear classifier on ImageNet on top of fixed representations of a ResNet50 pretrained with our method. The top-1 and top-5 accuracies obtained on the ImageNet validation set are reported in Table 1. Our method obtains a top-1 accuracy of 73 _._ 2% which is comparable to the state-of-the-art methods. 

_Table 1._ **Top-1 and top-5 accuracies (in %) under linear evaluation on ImageNet** . All models use a ResNet-50 encoder. Top-3 best self-supervised methods are underlined. 

|Method|Top-1|Top-5|
|---|---|---|
|Supervised|76.5||
|MOCO|60.6||
|PIRL|63.6|-|
|SIMCLR|69.3|89.0|
|MOCO V2|71.1|90.1|
|SIMSIAM|71.3|-|
|SWAV (w/o multi-crop)|71.8|-|
|BYOL|74.3|91.6|
|SWAV|75.3|-|
|BARLOWTWINS(ours)|73.2|91.0|



**Semi-supervised training on ImageNet** We fine-tune a ResNet-50 pretrained with our method on a subset of ImageNet. We use subsets of size 1% and 10% using the same split as SIMCLR. The semi-supervised results obtained on the ImageNet validation set are reported in Table 2. Our method is either on par (when using 10% of the data) or slightly better (when using 1% of the data) than competing methods. 

## **3.2. Transfer to other datasets and tasks** 

**Image classification with fixed features** We follow the setup from (Misra & van der Maaten, 2019) and train a linear classifier on fixed image representations, _i.e_ ., the 

_Table 2._ **Semi-supervised learning on ImageNet** using 1% and 10% training examples. Results for the supervised method are from (Zhai et al., 2019). Best results are in **bold** . 

|Method<br>Supervised<br>PIRL<br>SIMCLR<br>BYOL<br>SWAV<br>BARLOWTWINS(ours)|Top-1<br>1%<br>10%|Top-5<br>1%<br>10%|
|---|---|---|
||25.4<br>56.4|48.4<br>80.4|
||-<br>-<br>48.3<br>65.6<br>53.2<br>68.8<br>53.9<br>**70.2**<br>**55.0**<br>69.7|57.2<br>83.8<br>75.5<br>87.8<br>78.4<br>89.0<br>78.5<br>**89.9**<br>**79.2**<br>89.3|



_Table 3._ **Transfer learning: image classification.** We benchmark learned representations on the image classification task by training linear classifiers on fixed features. We report top-1 accuracy on Places-205 and iNat18 datasets, and classification mAP on VOC07. Top-3 best self-supervised methods are underlined. 

|Method<br>Places-205<br>VOC07<br>iNat18|Method<br>Places-205<br>VOC07<br>iNat18|
|---|---|
|Supervised<br>53.2|87.5<br>46.7|
|SimCLR<br>52.5<br>MoCo-v2<br>51.8<br>SwAV (w/o multi-crop)<br>52.8<br>SwAV<br>56.7<br>BYOL<br>54.0<br>BARLOWTWINS(ours)<br>54.1|85.5<br>37.2<br>86.4<br>38.6<br>86.4<br>39.5<br>88.9<br>48.6<br>86.6<br>47.6<br>86.2<br>46.5|



parameters of the ConvNet remain unchanged. We use a diverse set of datasets for this evaluation - Places-205 (Zhou et al., 2014) for scene classification, VOC07 (Everingham et al., 2010) for multi-label image classification, and iNaturalist2018 (Van Horn et al., 2018) for fine-grained image classification. We report our results in Table 3. BARLOW TWINS performs competitively against prior work, and outperforms SimCLR and MoCo-v2 on most datasets. 

**Object Detection and Instance Segmentation** We evaluate our representations for the localization based tasks of object detection and instance segmentation. We use the VOC07+12 (Everingham et al., 2010) and COCO (Lin et al., 2014) datasets following the setup in (He et al., 2019) which finetunes the ConvNet parameters. Our results in Table 4 indicate that BARLOW TWINS performs comparably or better than state-of-the-art representation learning methods for these localization tasks. 

**Barlow Twins: Self-Supervised Learning via Redundancy Reduction** 

_Table 4._ **Transfer learning: object detection and instance segmentation.** We benchmark learned representations on the object detection task on VOC07+12 using Faster R-CNN (Ren et al., 2015) and on the detection and instance segmentation task on COCO using Mask R-CNN (He et al., 2017). All methods use the C4 backbone variant (Wu et al., 2019) and models on COCO are finetuned using the 1 _×_ schedule. Best results are in **bold** . 

|Method|VOC07+12 det<br>APall<br>AP50<br>AP75|COCO det<br>APbb<br>APbb<br>50<br>APbb<br>75|COCO instance seg<br>APmk<br>APmk<br>50<br>APmk<br>75|
|---|---|---|---|
|Sup.|53.5<br>81.3<br>58.8|38.2<br>58.2<br>41.2|33.3<br>54.7<br>35.2|
|MoCo-v2<br>SwAV<br>SimSiam<br>BT (ours)|**57.4**<br>82.5<br>**64.0**<br>56.1<br>**82.6**<br>62.7<br>57<br>82.4<br>63.7<br>56.8<br>**82.6**<br>63.4|**39.3**<br>58.9<br>**42.5**<br>38.4<br>58.6<br>41.3<br>39.2<br>**59.3**<br>42.1<br>39.2<br>59.0<br>**42.5**|**34.4**<br>55.8<br>36.5<br>33.8<br>55.2<br>35.9<br>**34.4**<br>**56.0**<br>**36.7**<br>34.3<br>**56.0**<br>36.5|



## **4. Ablations** 

For all ablation studies, BARLOW TWINS was trained for 300 epochs instead of 1000 epochs in the previous section. A linear evaluation on ImageNet of this baseline model yielded a 71 _._ 4% top-1 accuracy and a 90 _._ 2% top-5 accuracy. For all the ablations presented we report the top-1 and top-5 accuracy of training linear classifiers on the 2048 dimensional res5 features using the ImageNet train set. 

**Loss Function Ablations** We alter our loss function (eqn. 1) in several ways to test the necessity of each term of the loss function, and to experiment with different practices popular in other loss functions for SSL, such as INFONCE. Table 5 recapitulates the different loss functions tested along with their results on a linear evaluation benchmark of Imagenet. First we find that removing the invariance term (on-diagonal term) or the redundancy reduction term (off-diagonal term) of our loss function leads to worse/collapsed solutions, as expected. We then study the effect of different normalization strategies. We first try to normalize the embeddings along the feature dimension so that they lie on the unit sphere, as it is common practice for losses measuring a cosine similarity (Chen et al., 2020a; Grill et al., 2020; Wang & Isola, 2020). Specifically, we first normalize the embeddings along the batch dimension (with mean subtraction), then normalize the embeddings along the feature dimension (without mean subtraction), and finally we measure the (unnormalized) covariance matrix instead of the (normalized) cross-correlation matrix in eqn. 2. The performance is slightly reduced. Second, we try to remove batch-normalization operations in the two hidden layers of the projector network MLP. The performance is barely affected. Third, in addition to removing the batch-normalization in the hidden layers, we replace the cross-correlation matrix in eqn. 2 by the crosscovariance matrix (which means the features are no longer normalized along the batch dimension). The performance 

is substantially reduced. We finally try a cross-entropy loss with temperature, for which the on-diagonal term and off-diagonal term is controlled by a temperature hyperparameter _τ_ and coefficient _λ_ : _L_ = _−_ log[�] _i_[exp(] _[C][ii][/τ]_[) +] _λ_ log[�] _i_ � _j_ = _i_[exp(max(] _[C][ij][,]_[ 0)] _[/τ]_[)][.][The][performance][is] reduced. 

_Table 5._ **Loss function explorations** . We ablate the invariance and redundancy terms in our proposed loss and observe that both terms are necessary for good performance. We also experiment with different normalization schemes and a cross-entropy loss and observe reduced performance. 

|Loss function|Top-1|Top-5|
|---|---|---|
|Baseline|71.4|90.2|
|Only invariance term (on-diag term)|57.3|80.5|
|Only red. red. term (off-diag term)|0.1|0.5|
|Normalization along feature dim.|69.8|88.8|
|No BN in MLP|71.2|89.7|
|No BN in MLP + no Normalization|53.4|76.7|
|Cross-entropy with temp.|63.3|85.7|



**Robustness to Batch Size** The INFONCE loss that draws negative examples from the minibatch suffer performance drops when the batch size is reduced (e.g. SIMCLR (Chen et al., 2020a)). We thus sought to test the robustness of BARLOW TWINS to small batch sizes. In order to adapt our model to different batch sizes, we performed a grid search on LARS learning rates for each batch size. We find that, unlike SIMCLR, our model is robust to small batch sizes (Fig. 2), with a performance almost unaffected for a batch as small as 256. In comparison the accuracy for SimCLR drops about 4 p.p. for batch size 256. This robustness to small batch size, also found in non-contrastive methods such as BYOL, further demonstrates that our method is not only conceptually (see Discussion) but also empirically different than the INFONCE objective. 

**Effect of Removing Augmentations** We find that our model is not robust to removing some types of data augmentations, like SIMCLR but unlike BYOL (Fig. 3). While this can be seen as a disadvantage of our method compared to BYOL, it can also be argued that the representations learned by our method are better controlled by the specific set of distortions used, as opposed to BYOL for which the invariances learned seem generic and intriguingly independent of the specific distortions used. 

**Projector Network Depth & Width** For other SSL methods, such as BYOL and SIMCLR, the projector network drastically reduces the dimensionality of the ResNet output. 

**Barlow Twins: Self-Supervised Learning via Redundancy Reduction** 

the projector network has more layers, with a saturation of the performance for 3 layers. 

**==> picture [479 x 196] intentionally omitted <==**

**----- Start of picture text -----**<br>
the performance for 3 layers.<br>0.0<br>−0.5<br>−1.0<br>−1.5 72<br>−2.0 70<br>−2.5 68<br>−3.0 66<br>BT (ours)<br>−3.5 BYOL 64<br>SimCLR<br>62<br>128 256 512 1024 2048 4096<br>Batch size 60 BT (ours)<br>58 BYOL<br>SimCLR<br>Figure 2.  Effect of batch size. To compare the effect of the batch 56<br>16 32 64 128 256 512 1024 2048 4096 8192 16384<br>across methods, for each method we report the difference<br>Projector Dimensionality<br>between the top-1 accuracy at a given batch size and the best ob-<br>Top-1 Accuracy Diff.<br>Top-1 Accuracy<br>**----- End of picture text -----**<br>


_Figure 2._ Effect of batch size. To compare the effect of the batch size across methods, for each method we report the difference between the top-1 accuracy at a given batch size and the best obtained accuracy among all batch size tested. BYOL: best accuracy is 72.5% for a batch size of 4096 (data from (Grill et al., 2020) fig. 3A). SIMCLR: best accuracy is 67.1% for a batch size of 4096 (data from (Chen et al., 2020a) fig. 9, model trained for 300 epochs). BARLOW TWINS: best accuracy is 71.7% for a batch size of 1024. 

_Figure 4._ Effect of the dimensionality of the last layer of the projector network on performance. The parameter _λ_ is kept fix for all dimensionalities tested. Data for SIMCLR is from (Chen et al., 2020a) fig 8; Data for BYOL is from (Grill et al., 2020) Table 14b. 

**==> picture [227 x 157] intentionally omitted <==**

**----- Start of picture text -----**<br>
0 BT (ours)<br>BYOL<br>−5 SimCLR<br>−10<br>−15<br>−20<br>−25<br>Baseline No Grayscale+ No Color JitterCrop + Blur onlyCrop only<br>Top-1 Accuracy Diff.<br>**----- End of picture text -----**<br>


_Figure 3._ Effect of progressively removing data augmentations. Data for BYOL and SIMCLR (repro) is from (Grill et al., 2020) fig 3b. 

In stark contrast, we find that BARLOW TWINS performs better when the dimensionality of the projector network output is very large. Other methods rapidly saturate when the dimensionality of the output increases, but our method keeps improving with all output dimensionality tested (Fig. 4). This result is quite surprising because the output of the ResNet is kept fixed to 2048, which acts as a dimensionality bottleneck in our model and sets the limit of the intrinsic dimensionality of the representation. In addition, similarly to other methods, we find that our model performs better when 

**Breaking Symmetry** Many SSL methods (e.g. BYOL, SIMSIAM, SWAV) rely on different symmetry-breaking mechanisms to avoid trivial solutions. Our loss function avoids these trivial solutions by construction, even in the case of symmetric networks. It is however interesting to ask whether breaking symmetry can further improve the performance of our network. Following SIMSIAM and BYOL, we experiment with adding a predictor network composed of 2 fully connected layers of size 8192 to one of the network (with batch normalization followed by a ReLU nonlinearity in the hidden layer) and/or a stop-gradient mechanism on the other network. We find that these asymmetries slightly decrease the performance of our network (see Table 6). 

_Table 6._ Effect of asymmetric settings 

|case|stop-gradient|predictor|Top-1|Top-5|
|---|---|---|---|---|
|Baseline|-|-|71.4|90.2|
|(a)|✓|-|70_._5|89_._0|
|(b)|-|✓|70_._2|89_._0|
|(c)|✓|✓|61_._3|83_._5|



**BYOL with a larger projector/predictor/embedding** For a fair comparison with BYOL, we also evaluated BYOL with a wider and/or deeper projector head (3-layer MLP), a wider and/or deeper predictor head, and a larger dimensionality of the embedding. BYOL did not improve under these conditions (see Table 7). 

**Barlow Twins: Self-Supervised Learning via Redundancy Reduction** 

_Table 7._ Wider and/or deeper projector and predictor heads and larger dimensionality of the embedding did not improve the performance of BYOL. 

|Projector|Predictor|Acc1|Description|
|---|---|---|---|
|4096-256<br>4096-4096-256<br>4096-4096-256<br>4096-4096-512<br>4096-4096-512<br>8192-8192-8192|4096-256<br>4096-256<br>4096-4096-256<br>4096-512<br>4096-4096-512<br>8192-8192|74.1%<br>74.0%<br>73.2%<br>73.7%<br>73.2%<br>72.3%|baseline<br>3 layer proj, 2 layer pred, 256-d repr.<br>3 layer proj, 3 layer pred, 256-d repr.<br>3 layer proj, 2 layer pred, 512-d repr.<br>3 layer proj, 3 layer pred, 512-d repr.<br>sameprojas BT,2 layerpred,8192-d repr.|



**Sensitivity to** _λ_ **.** We also explored the sensitivity of BARLOW TWINS to the hyperparameter _λ_ , which trades off the desiderata of invariance and informativeness of the embeddings. We find that BARLOW TWINS is not very sensitive to this hyperparameter (Fig. 5). 

be instantiated as: 

**==> picture [175 x 97] intentionally omitted <==**

where _z[A]_ and _z[B]_ are the twin network outputs, _b_ indexes the sample in a batch, _i_ indexes the vector component of the output, and _τ_ is a positive constant called temperature in analogy to statistical physics. 

For ready comparison, we rewrite BARLOW TWINS loss function with the same notations: 

**==> picture [227 x 154] intentionally omitted <==**

**----- Start of picture text -----**<br>
71.6<br>71.4<br>71.2<br>71.0<br>70.8<br>0.002 0.005 0.007 0.010 0.015 0.020<br>λ<br>Top-1 Accuracy<br>**----- End of picture text -----**<br>


_Figure 5._ Sensitivity of BARLOW TWINS to the hyperparameter _λ_ 

## **5. Discussion** 

BARLOW TWINS learns self-supervised representations through a joint embedding of distorted images, with an objective function that maximizes similarity between the embedding vectors while reducing redundancy between their components. Our method does not require large batches of samples, nor does it require any particular asymmetry in the twin network structure. We discuss next the similarities and differences between our method and prior art, both from a conceptual and an empirical standpoint. For ease of comparison, all objective functions are recast with a common set of notations. The discussion ends with future directions. 

## **5.1. Comparison with Prior Art** 

**infoNCE** The INFONCE loss, where NCE stands for Noise-Contrastive Estimation (Gutmann & Hyvarinen¨ , 2010), is a popular type of contrastive loss function used for self-supervised learning (e.g. (Chen et al., 2020a; He et al., 2019; Henaff et al.´ , 2019; Oord et al., 2018)). It can 

**==> picture [147 x 100] intentionally omitted <==**

Both BARLOW TWINS’ and INFONCE’s objective functions have two terms, the first aiming at making the embeddings invariant to the distortions fed to the twin networks, the second aiming at maximizing the variability of the embedding learned. Another common point between the two losses is that they both rely on batch statistics to measure this variability. However, the INFONCE objective maximizes the variability of the embeddings by maximizing the pairwise distance between all pairs of samples, whereas our method does so by decorrelating the components of the embeddings vectors. 

The contrastive term in INFONCE can be interpreted as a non-parametric estimation of the entropy of the distribution of embeddings (Wang & Isola, 2020). An issue that arises with non-parametric entropy estimators is that they are prone to the curse of dimensionality: they can only be estimated reliably in a low-dimensional setting, and they typically require a large number of samples. 

In contrast, our loss can be interpreted as a _proxy_ entropy estimator of the distribution of embeddings under _a Gaussian parametrization_ (see Appendix A). Thanks to this simplified parametrization, the variability of the embedding can be estimated from much fewer samples, and on very largedimensional embeddings. Indeed, in the ablation studies that we perform, we find that (1) our method is robust to small batches unlike the popular INFONCE-based method 

**Barlow Twins: Self-Supervised Learning via Redundancy Reduction** 

SIMCLR, and (2) our method benefits from using very large dimensional embeddings, unlike INFONCE-based methods which do not see a benefit in increasing the dimensionality of the output. 

Our loss presents several other interesting differences with infoNCE: 

- In INFONCE, the embeddings are typically normalized along the feature dimension to compute a cosine similarity between embedded samples. We normalize the embeddings along the batch dimension instead. 

- In our method, there is a parameter _λ_ that trades off how much emphasis is put on the invariance term vs. the redundancy reduction term. This parameter can be interpreted as the trade-off parameter in the _Information Bottleneck_ framework (see Appendix A). This parameter is not present in INFONCE. 

- INFONCE also has a hyperparameter, the temperature, which can be interpreted as the width of the kernel in a non-parametric kernel density estimation of entropy, and practically weighs the relative importance of the hardest negative samples present in the batch (Chen et al., 2020a). 

A number of alternative methods to ours have been proposed to alleviate the reliance on large batches of the INFONCE loss. For example, MoCo (Chen et al., 2020b; He et al., 2019) builds a dynamic dictionary of negative samples with a queue and a moving-averaged encoder. This enables building a large and consistent dictionary on-the-fly that facilitates contrastive unsupervised learning. MoCo typically needs to store _>_ 60 _,_ 000 sample embeddings. In contrast, our method does not require such a large dictionary, since it works well with a relatively small batch size (e.g. 256). 

**Asymmetric Twins** BOOTSTRAP-YOUR-OWN-LATENT (aka BYOL) (Grill et al., 2020) and SIMSIAM (Chen & He, 2020) are two recent methods which use a simple cosine similarity between twin embeddings as an objective function, without _any_ contrastive term: 

**==> picture [128 x 29] intentionally omitted <==**

Surprisingly, these methods successfully avoid trivial solutions by introducing some asymmetry in the architecture and learning procedure of the twin networks. For example, BYOL uses a predictor network which breaks the symmetry between the two networks, and also enforces an exponential moving average on the target network weights to slow down 

the progression of the weights on the target network. Combined together, these two mechanisms surprisingly avoid trivial solutions. The reasons behind this success are the subject of recent theoretical and empirical studies (Chen & He, 2020; Fetterman & Albrecht, 2020; Richemond et al., 2020; Tian et al., 2020). In particular, the ablation study (Chen & He, 2020) shows that the moving average is not necessary, but that stop-gradient on one of the branch and the presence of the predictor network are two crucial elements to avoid collapse. Other works show that batch normalization (Fetterman & Albrecht, 2020; Tian et al., 2020) or alternatively group normalization (Richemond et al., 2020) could play an important role in avoiding collapse. 

Like our method, these asymmetric methods do not require large batches, since in their case there is no interaction between batch samples in the objective function. 

It should be noted however that these asymmetric methods cannot be described as the optimization of an overall learning objective. Instead, there exists trivial solutions to the learning objective that these methods avoid via particular implementation choices and/or the result of non-trivial learning dynamics. In contrast, our method avoids trivial solutions by construction, making our method conceptually simpler and more principled than these alternatives (until their principle is discovered, see (Tian et al., 2021) for an early attempt). 

**Whitening** In a concurrent work, (Ermolov et al., 2020) propose W-MSE. Acting on the embeddings from identical twin networks, this method performs a differentiable whitening operation (via Cholesky decomposition) of each batch of embeddings before computing a simple cosine similarity between the whitened embeddings of the twin networks. In contrast, the redundancy reduction term in our loss encourages the whitening of the batch embeddings as a soft constraint. The current W-MSE model achieves 66.3% top-1 accuracy on the Imagenet linear evaluation benchmark. It is an interesting direction for future studies to determine whether improved versions of this hard-whitening strategy could also lead to state-of-the-art results on these large-scale computer vision benchmarks. 

**Clustering** These methods, such as DEEPCLUSTER (Caron et al., 2018), SWAV (Caron et al., 2020), SELA (Asano et al., 2020), perform contrastive-like comparisons without the requirement to compute all pairwise distances. Specifically, these methods simultaneously cluster the data while enforcing consistency between cluster assignments produced for different distortions of the same image, instead of comparing features directly as in contrastive learning. Clustering methods are also prone to collapse, _e.g_ ., empty clusters in k-means and avoiding them relies on careful implementation details. Online clustering methods like SWAV 

**Barlow Twins: Self-Supervised Learning via Redundancy Reduction** 

can be trained with large and small batches but require storing features when the number of clusters is much larger than the batch size. Clustering methods can also be combined with contrastive learning (Li et al., 2021) to prevent collapse. 

**Noise As Targets** This method (Bojanowski & Joulin, 2017) learns to map samples to fixed random targets on the unit sphere, which can be interpreted as a form of whitening. This objective uses a single network, and hence does not leverage the distortions induced by twin networks. Predefining random targets might limit the flexibility of the representation that can be learned. 

**IMAX** In the early days of SSL, (Becker & Hinton, 1992; Zemel & Hinton, 1990) proposed a loss function between twin networks given by: 

**==> picture [183 x 13] intentionally omitted <==**

where _| |_ denotes the determinant of a matrix, _C_ ( _ZA−ZB_ ) is the covariance matrix of the difference of the outputs of the twin networks and _C_ ( _ZA_ + _ZB_ ) the covariance of the sum of these outputs. It can be shown that this objective maximizes the information between the twin network representations under the assumptions that the two representations are noisy versions of the same underlying Gaussian signal, and that the noise is independant, additive and Gaussian. This objective is similar to ours in the sense that there is one term that encourages the two representations to be similar and another term that encourages the units to be decorrelated. However, unlike IMAX, our objective is not directly an information quantity, and we have an extra trade-off parameter _λ_ that trades off the two terms of our loss. The IMAX objective was used in early work so it is not clear whether it can scale to large computer vision tasks. Our attempts to make it work on ImageNet were not successful. 

## **5.2. Future Directions** 

We observe a steady improvement of the performance of our method as we increase the dimensionality of the embeddings (i.e. of the last layer of the projector network). This intriguing result is in stark contrast with other popular methods for SSL, such as SIMCLR (Chen et al., 2020a) and BYOL (Grill et al., 2020), for which increasing the dimensionality of the embeddings rapidly saturates performance. It is a promising avenue to continue this exploration for even higher dimensional embeddings ( _>_ 16 _,_ 000), but this would require the development of new methods or alternative hardware to accommodate the memory requirements of operating on such large embeddings. 

Our method is just one possible instanciation of the _Information Bottleneck_ principle applied to SSL. We believe that further refinements of the proposed loss function and algorithm 

could lead to more efficient solutions and even better performances. For example, the redundancy reduction term is currently computed from the off-diagonal terms of the crosscorrelation matrix between the twin network embeddings, but alternatively it could be computed from the off-diagonal terms of the auto-correlation matrix of a single network’s embedding. Our preliminary analyses seem to indicate that this alternative leads to similar performances (not shown). A modified loss could also be applied to the (unnormalized) cross-covariance matrix instead of the (normalized) crosscorrelation matrix (see Ablations for preliminary analyses). 

## **Acknowledgements** 

We thank Pascal Vincent, Yubei Chen and Samuel Ocko for helpful insights on the mathematical connection to the infoNCE loss, Robert Geirhos and Adrien Bardes for extra analyses not included in the manuscript and Xinlei Chen, Mathilde Caron, Armand Joulin, Reuben Feinman and Ulisse Ferrari for useful comments on the manuscript. 

## **References** 

- Asano, Y. M., Rupprecht, C., and Vedaldi, A. Self-labelling via simultaneous clustering and representation learning. _International Conference on Learning Representations (ICLR)_ , 2020. 

- Balle, J., Laparra, V., and Simoncelli, E. P.´ End-to-end Optimized Image Compression. In _International Conference on Learning Representations (ICLR)_ , 2017. 

- Barlow, H. Redundancy reduction revisited. _Network (Bristol, England)_ , 12(3):241–253, August 2001. ISSN 0954898X. 

- Barlow, H. B. _Possible Principles Underlying the Transformations of Sensory Messages_ . in Sensory Communication, The MIT Press, 1961. 

- Becker, S. and Hinton, G. E. Self-organizing neural network that discovers surfaces in random-dot stereograms. _Nature_ , 355(6356):161–163, January 1992. 

- Bojanowski, P. and Joulin, A. Unsupervised learning by predicting noise. In _Proceedings of the International Conference on Machine Learning (ICML)_ , 2017. 

- Cai, T. T., Liang, T., and Zhou, H. H. Law of Log Determinant of Sample Covariance Matrix and Optimal Estimation of Differential Entropy for High-Dimensional Gaussian Distributions. _Journal of Multivariate Analysis_ , 137, 2015. doi: 10.1016/j.jmva.2015.02.003. 

- Caron, M., Bojanowski, P., Joulin, A., and Douze, M. Deep clustering for unsupervised learning of visual features. In 

**Barlow Twins: Self-Supervised Learning via Redundancy Reduction** 

_Proceedings of the European Conference on Computer Vision (ECCV)_ , 2018. 

- Caron, M., Misra, I., Mairal, J., Goyal, P., Bojanowski, P., and Joulin, A. Unsupervised learning of visual features by contrasting cluster assignments. In _NeurIPS_ , 2020. 

- Chen, T., Kornblith, S., Norouzi, M., and Hinton, G. A simple framework for contrastive learning of visual representations. _arXiv preprint arXiv:2002.05709_ , 2020a. 

- Chen, X. and He, K. Exploring simple siamese representation learning. _arXiv preprint arXiv:2011.10566_ , 2020. 

- Chen, X., Fan, H., Girshick, R., and He, K. Improved baselines with momentum contrastive learning. _arXiv preprint arXiv:2003.04297_ , 2020b. 

- Deco, G. and Parra, L. Non-linear Feature Extraction by Redundancy Reduction in an Unsupervised Stochastic Neural Network. _Neural Networks_ , 10(4):683–691, June 1997. ISSN 0893-6080. doi: 10.1016/S0893-6080(96) 00110-4. 

- Deng, J., Dong, W., Socher, R., Li, L.-J., Li, K., and Fei-Fei, L. Imagenet: A large-scale hierarchical image database. In _Proceedings of the Conference on Computer Vision and Pattern Recognition (CVPR)_ , 2009. 

- Ermolov, A., Siarohin, A., Sangineto, E., and Sebe, N. Whitening for Self-Supervised Representation Learning. _arXiv preprint arXiv:2007.06346_ , 2020. 

- Everingham, M., Van Gool, L., Williams, C. K., Winn, J., and Zisserman, A. The pascal visual object classes (voc) challenge. _International journal of computer vision_ , 88 (2):303–338, 2010. 

- Fetterman, A. and Albrecht, J. Understanding selfsupervised and contrastive learning with “Bootstrap Your Own Latent” (BYOL). _Untitled AI_ , August 2020. 

- Foldi¨ ak,´ P. Forming sparse representations by local antiHebbian learning. _Biological Cybernetics_ , 64(2):165– 170, December 1990. ISSN 1432-0770. doi: 10.1007/ BF02331346. 

- Goyal, P., Dollar,´ P., Girshick, R., Noordhuis, P., Wesolowski, L., Kyrola, A., Tulloch, A., Jia, Y., and He, K. Accurate, large minibatch sgd: Training imagenet in 1 hour. _arXiv preprint arXiv:1706.02677_ , 2017. 

- Goyal, P., Mahajan, D., Gupta, A., and Misra, I. Scaling and benchmarking self-supervised visual representation learning. _Proceedings of the International Conference on Computer Vision (ICCV)_ , 2019. 

- Grill, J.-B., Strub, F., Altche,´ F., Tallec, C., Richemond, P. H., Buchatskaya, E., Doersch, C., Pires, B. A., Guo, Z. D., Azar, M. G., et al. Bootstrap your own latent: A new approach to self-supervised learning. In _NeurIPS_ , 2020. 

- Gutmann, M. and Hyvarinen, A.¨ Noise-contrastive estimation: A new estimation principle for unnormalized statistical models. In _Proceedings of the Thirteenth International Conference on Artificial Intelligence and Statistics_ . JMLR Workshop and Conference Proceedings, 2010. 

- Hadsell, R., Chopra, S., and LeCun, Y. Dimensionality reduction by learning an invariant mapping. In _Proceedings of the Conference on Computer Vision and Pattern Recognition (CVPR)_ , 2006. 

- He, K., Zhang, X., Ren, S., and Sun, J. Deep residual learning for image recognition. In _Proceedings of the Conference on Computer Vision and Pattern Recognition (CVPR)_ , 2016. 

- He, K., Gkioxari, G., Dollar,´ P., and Girshick, R. Mask r-cnn. In _Proceedings of the International Conference on Computer Vision (ICCV)_ , 2017. 

- He, K., Fan, H., Wu, Y., Xie, S., and Girshick, R. Momentum contrast for unsupervised visual representation learning. _arXiv preprint arXiv:1911.05722_ , 2019. 

- Henaff, O. J., Razavi, A., Doersch, C., Eslami, S., and Oord,´ A. v. d. Data-efficient image recognition with contrastive predictive coding. _arXiv preprint arXiv:1905.09272_ , 2019. 

- Li, Y., Hu, P., Liu, Z., Peng, D., Zhou, J. T., and Peng, X. Contrastive clustering. In _AAAI_ , 2021. 

- Lin, T.-Y., Maire, M., Belongie, S., Hays, J., Perona, P., Ramanan, D., Dollar,´ P., and Zitnick, C. L. Microsoft coco: Common objects in context. In _Proceedings of the European Conference on Computer Vision (ECCV)_ , 2014. 

- Lindsey, J., Ocko, S. A., Ganguli, S., and Deny, S. A unified theory of early visual representations from retina to cortex through anatomically constrained deep CNNs. In _ICLR_ , 2020. 

- Linsker, R. Self-organization in a perceptual network. _Computer_ , 21(3):105–117, March 1988. ISSN 1558-0814. doi: 10.1109/2.36. Conference Name: Computer. 

- Loshchilov, I. and Hutter, F. Sgdr: Stochastic gradient descent with warm restarts. _arXiv preprint arXiv:1608.03983_ , 2016. 

- Misra, I. and van der Maaten, L. Self-supervised learning of pretext-invariant representations. _arXiv preprint arXiv:1912.01991_ , 2019. 

**Barlow Twins: Self-Supervised Learning via Redundancy Reduction** 

- Ocko, S., Lindsey, J., Ganguli, S., and Deny, S. The emergence of multiple retinal cell types through efficient coding of natural movies. In _NeurIPS_ , 2018. 

- Oord, A. v. d., Li, Y., and Vinyals, O. Representation learning with contrastive predictive coding. _arXiv preprint arXiv:1807.03748_ , 2018. 

- Redlich, A. N. Redundancy Reduction as a Strategy for Unsupervised Learning. _Neural Computation_ , 5(2):289– 304, March 1993a. ISSN 0899-7667. doi: 10.1162/neco. 1993.5.2.289. Conference Name: Neural Computation. 

- Redlich, A. N. Supervised Factorial Learning. _Neural Computation_ , 5(5):750–766, September 1993b. ISSN 0899-7667, 1530-888X. doi: 10.1162/neco.1993.5.5.750. 

- Ren, S., He, K., Girshick, R., and Sun, J. Faster r-cnn: Towards real-time object detection with region proposal networks. In _Advances in Neural Information Processing Systems (NeurIPS)_ , 2015. 

- Richemond, P. H., Grill, J.-B., Altche, F., Tallec, C., Strub,´ F., Brock, A., Smith, S., De, S., Pascanu, R., Piot, B., and Valko, M. BYOL works even without batch statistics. _arXiv preprint arXiv:2010.10241_ , 2020. 

- Schmidhuber, J., Eldracher, M., and Foltin, B. Semilinear Predictability Minimization Produces Well-Known Feature Detectors. _Neural Computation_ , 8(4):773–786, May 1996. ISSN 0899-7667. doi: 10.1162/neco.1996.8.4.773. Conference Name: Neural Computation. 

_Proceedings of the Conference on Computer Vision and Pattern Recognition (CVPR)_ , 2018. 

   - Wang, T. and Isola, P. Understanding Contrastive Representation Learning through Alignment and Uniformity on the Hypersphere. _arXiv preprint arXiv:2005.10242_ , 2020. 

   - Wu, Y., Kirillov, A., Massa, F., Lo, W.-Y., and Girshick, R. Detectron2. https://github.com/ facebookresearch/detectron2, 2019. 

   - You, Y., Gitman, I., and Ginsburg, B. Large batch training of convolutional networks. _arXiv preprint arXiv:1708.03888_ , 2017. 

   - Zemel, R. and Hinton, G. E. Discovering viewpointinvariant relationships that characterize objects. In _NeurIPS_ , 1990. 

   - Zhai, X., Oliver, A., Kolesnikov, A., and Beyer, L. S4l: Selfsupervised semi-supervised learning. In _Proceedings of the IEEE/CVF International Conference on Computer Vision_ , pp. 1476–1485, 2019. 

   - Zhou, B., Lapedriza, A., Xiao, J., Torralba, A., and Oliva, A. Learning deep features for scene recognition using places database. In _Advances in Neural Information Processing Systems (NeurIPS)_ , 2014. 

- Schwartz, O. and Simoncelli, E. P. Natural signal statistics and sensory gain control. _Nature Neuroscience_ , 4(8):819– 825, August 2001. ISSN 1546-1726. doi: 10.1038/90526. Number: 8 Publisher: Nature Publishing Group. 

- Tian, Y., Yu, L., Chen, X., and Ganguli, S. Understanding Self-supervised Learning with Dual Deep Networks. _arXiv preprint arXiv:2010.00578_ , 2020. 

- Tian, Y., Chen, X., and Ganguli, S. Understanding self-supervised Learning Dynamics without Contrastive Pairs. _arXiv:2102.06810 [cs]_ , February 2021. arXiv: 2102.06810. 

- Tishby, N. and Zaslavsky, N. Deep Learning and the Information Bottleneck Principle. _arXiv preprint arXiv:1503.02406_ , 2015. 

- Tishby, N., Pereira, F. C., and Bialek, W. The information bottleneck method. _arXiv preprint arXiv:physics/0004057_ , 2000. 

- Van Horn, G., Mac Aodha, O., Song, Y., Cui, Y., Sun, C., Shepard, A., Adam, H., Perona, P., and Belongie, S. The inaturalist species classification and detection dataset. In 

**Barlow Twins: Self-Supervised Learning via Redundancy Reduction** 

## **A. Connection between BARLOW TWINS and the Information Bottleneck Principle** 

of that sample (here the data augmentations used) (Fig. 6). This trade-off is captured by the following loss function: 

**==> picture [180 x 12] intentionally omitted <==**

where _I_ ( _., ._ ) denotes mutual information and _β_ is a positive scalar trading off the desideratas of preserving information and being invariant to distortions. 

Using a classical identity for mutual information, we can rewrite equation 5 as: 

**==> picture [230 x 18] intentionally omitted <==**

_Figure 6._ The information bottleneck principle applied to selfsupervised learning (SSL) posits that the objective of SSL is to learn a representation _Zθ_ which is informative about the image sample, but invariant (i.e. uninformative) to the specific distortions that are applied to this sample. BARLOW TWINS can be viewed as a specific instanciation of the information bottleneck objective. 

We explore in this appendix the connection between BARLOW TWINS’ loss function and the _Information Bottleneck_ (IB) principle (Tishby & Zaslavsky, 2015; Tishby et al., 2000). 

As a reminder, BARLOW TWINS’ loss function is given by: 

**==> picture [210 x 38] intentionally omitted <==**

where _λ_ is a positive constant trading off the importance of the first and second terms of the loss, and where _C_ is the cross-correlation matrix computed between the outputs of the two identical networks along the batch dimension : 

**==> picture [185 x 34] intentionally omitted <==**

where _b_ indexes batch samples and _i, j_ index the vector dimension of the networks’ outputs. _C_ is a square matrix with size the dimensionality of the network’s output, and with values comprised between -1 (i.e. perfect anti-correlation) and 1 (i.e. perfect correlation). 

Applied to self-supervised learning, the IB principle posits that a desirable representation should be as informative as possible about the sample represented while being as invariant (i.e. non-informative) as possible to distortions 

where _H_ ( _._ ) denotes entropy. The conditional entropy _H_ ( _Zθ|Y_ ) —the entropy of the representation conditioned on a specific distorted sample— cancels to 0 because the function _fθ_ is deterministic, and so the representation _Zθ_ conditioned on the input sample _Y_ is perfectly known and has zero entropy. Since the overall scaling factor of the loss function is not important, we can rearrange equation 6 as: _IBθ_ = _H_ ( _Zθ|X_ ) +[1] _[ −][β] H_ ( _Zθ_ ) (7) _β_ 

Measuring the entropy of a high-dimensional signal generally requires vast amounts of data, much larger than the size of a single batch. In order to circumvent this difficulty, we make the simplifying assumption that the representation _Z_ is distributed as a Gaussian. The entropy of a Gaussian distribution is simply given by the logarithm of the determinant of its covariance function (up to a constant corresponding to the assumed discretization level that we ignore here) (Cai et al., 2015). The loss function becomes: 

**==> picture [203 x 24] intentionally omitted <==**

This equation is still not exactly the one we optimize for in practice (see eqn. 3 and 4). Indeed, our loss function is only connected to the IB loss given by eqn. 8 through the following simplifications and approximations: 

- In the case where _β <_ = 1, it is easy to see from eqn. 8 that the best solution to the IB trade-off is to set the representation to a constant that does not depend on the input. This trade-off thus does not lead to interesting representations and can be ignored. When _β >_ 1, we note that the second term of eqn. 8 is preceded by a negative constant. We can thus simply replace[1] _[−] β[β]_ by a new positive constant _λ_ , preceded by a negative sign. 

**Barlow Twins: Self-Supervised Learning via Redundancy Reduction** 

- In practice, we find that directly optimizing the determinant of the covariance matrices does not lead to SoTA solutions. Instead, we replace the second term of the loss in eqn. 8 (maximizing the information about samples), by the proxy which consist in simply minimizing the Frobenius norm of the cross-correlation matrix. If the representations are assumed to be rescaled to 1 along the batch dimension before entering the loss (an assumption we are free to make since the cross-correlation matrix is invariant to this re-scaling), this minimization only affects the off-diagonal terms of the covariance matrix (the diagonal terms being fixed to 1 by the re-scaling) and encourages them to be as close to 0 as possible. It is clear that this surrogate objective, which consists in decorrelating all output units, has the same global optimum than the original information maximization objective. 

- For consistency with eqn. 8, the second term in BARLOW TWINS’ loss should be computed from the autocorrelation matrix of one of the twin networks, instead of the cross-correlation matrix between twin networks. In practice, we do not see a strong difference in performance between these alternatives. 

- Similarly, it can easily be shown that the first term of eqn. 8 (minimizing the information the representation contains about the distortions) has the same global optimum than the first term of eqn. 3, which maximizes the alignment between representations of pairs of distorted samples. 

## **B. Evaluations on ImageNet** 

## **C. Transfer Learning** 

## **C.1. Linear evaluation** 

We follow the exact settings from PIRL (Misra & van der Maaten, 2019) for evaluating linear classifiers on the Places205, VOC07 and iNaturalist2018 datasets. For Places-205 and iNaturalist2018 we train a linear classifier with SGD (14 epochs on Places-205, 84 epochs on iNaturalist2018) with a learning rate of 0 _._ 01 reduced by a factor of 10 at two equally spaced intervals, a weight decay of 5 _×_ 10 _[−]_[4] and SGD momentum of 0 _._ 9. We train SVM classifiers on the VOC07 dataset where the _C_ values are computed using cross-validation. 

## **C.2. Object Detection and Instance Segmentation** 

We use the detectron2 library (Wu et al., 2019) for training the detection models and closely follow the evaluation settings from (He et al., 2019). The backbone ResNet50 network for Faster R-CNN (Ren et al., 2015) and Mask R-CNN (He et al., 2017) is initialized using our BARLOW TWINS pretrained model. 

**VOC07+12** We use the VOC07+12 trainval set of 16 _K_ images for training a Faster R-CNN (Ren et al., 2015) C-4 backbone for 24 _K_ iterations using a batch size of 16 across 8 GPUs using SyncBatchNorm. The initial learning rate for the model is 0 _._ 1 which is reduced by a factor of 10 after 18 _K_ and 22 _K_ iterations. We use linear warmup (Goyal et al., 2017) with a slope of 0 _._ 333 for 1000 iterations. 

**COCO** We train Mask R-CNN (He et al., 2017) C-4 backbone on the COCO 2017 train split and report results on the val split. We use a learning rate of 0 _._ 03 and keep the other parameters the same as in the 1 _×_ schedule in detectron2. 

## **B.1. Linear evaluation on ImageNet** 

The linear classifier is trained for 100 epochs with a learning rate of 0 _._ 3 and a cosine learning rate schedule. We minimize the cross-entropy loss with the SGD optimizer with momentum and weight decay of 10 _[−]_[6] . We use a batch size of 256. At training time we augment an input image by taking a random crop, resizing it to 224 _×_ 224, and optionally flipping the image horizontally. At test time we resize the image to 256 _×_ 256 and center-crop it to a size of 224 _×_ 224. 

## **B.2. Semi-supervised training on ImageNet** 

We train for 20 epochs with a learning rate of 0 _._ 002 for the ResNet-50 and 0 _._ 5 for the final classification layer. The learning rate is multiplied by a factor of 0 _._ 2 after the 12th and 16th epoch. We minimize the cross-entropy loss with the SGD optimizer with momentum and do not use weight decay. We use a batch size of 256. The image augmentations are the same as in the linear evaluation setting. 

