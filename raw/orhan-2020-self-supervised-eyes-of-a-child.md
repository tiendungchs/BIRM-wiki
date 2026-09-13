---
title: "Self-supervised learning through the eyes of a child"
source: "https://ar5iv.labs.arxiv.org/html/2007.16189"
author:
published:
created: 2026-09-13
description: "Within months of birth, children develop meaningful expectations about the world around them. How much of this early knowledge can be explained through generic learning mechanisms applied to sensory data, and how much …"
tags:
  - "clippings"
---
A. Emin Orhan      Vaibhav V. Gupta      Brenden M. Lake Affiliation: Center for Data Science, Department of PsychologyNew York University{eo41, vvg239, brenden}@nyu.edu

###### Abstract

Within months of birth, children develop meaningful expectations about the world around them. How much of this early knowledge can be explained through generic learning mechanisms applied to sensory data, and how much of it requires more substantive innate inductive biases? Addressing this fundamental question in its full generality is currently infeasible, but we can hope to make real progress in more narrowly defined domains, such as the development of high-level visual categories, thanks to improvements in data collecting technology and recent progress in deep learning. In this paper, our goal is precisely to achieve such progress by utilizing modern self-supervised deep learning methods and a recent longitudinal, egocentric video dataset recorded from the perspective of three young children (Sullivan et al., 2020). Our results demonstrate the emergence of powerful, high-level visual representations from developmentally realistic natural videos using generic self-supervised learning objectives.

## 1 Introduction

Experimental evidence suggests that even very young children have wide-ranging and sophisticated knowledge about the world around them. For example, within the first few months of life, infants show meaningful expectations about objects and agents [^37]. Similarly, well before learning to speak, infants can discriminate between many common categories; at 3-4 months, infants can discriminate simple shapes [^5] and animal classes [^30], preferring to look at exemplars from a novel class (e.g., bird) after observing exemplars from a different class (dogs). Yet, the origin of this early knowledge is often unclear. How much of this early knowledge can be learned by relatively generic learning architectures receiving sensory data through the eyes of a developing child, and how much of it requires more substantive inductive biases?

This is, of course, a modern reformulation of the age-old nature vs. nurture question that is central in psychology. Answering this question requires both a precise characterization of the sensory data received by humans during development and determining what generic models can learn from this data without assuming strong priors. Although addressing this question in its full generality would require unprecedentedly large and rich datasets and hence still remains out of reach, we can hope to make real progress in more narrowly defined domains, such as the development of visual categories, thanks to new large-scale developmental datasets [^38] [^36] [^1] and the recent progress in deep learning methods.

In this paper, our goal is precisely to achieve such progress by utilizing modern self-supervised deep learning techniques [^16] [^8] and a recent longitudinal egocentric dataset of headcam videos (SAYCam) recorded from the perspective of three developing children [^38]. The scale and longitudinal nature of this dataset allows us to train a large-scale model “through the eyes” of individual developing children; in this case, based on $\sim$ 150-200 hours of video sampled regularly from 6 months to 32 months of age. Our choice of self-supervised learning avoids extra supervision that a child would not have access to; training only on data from individual children ensures a strict subset of actual developmental experience. We trained self-supervised models on raw unlabeled videos, with the goal of extracting useful high-level visual representations. The acquired visual representations were then evaluated based on their ability to distinguish common visual categories in the child’s environment, using only linear readouts. Our results demonstrate, for the first time, the emergence of powerful, high-level visual representations from natural videos collected from a child’s perspective, using generic self-supervised learning methods. More specifically, we show that these emergent visual representations are powerful enough to support (i) high accuracy in non-trivial visual categorization tasks that are behaviorally relevant for a child, (ii) invariance to natural transformations, and (iii) generalization to unseen category exemplars from a handful of training exemplars.

## 2 Related work

In developmental psychology, there is extensive experimental work on the acquisition of perceptual categories in children. As mentioned in the Introduction, 3-4 month old infants can discriminate between many common categories [^5] [^30], such as dogs vs. birds or triangles vs. squares. It can sometimes be unclear whether infants possess these contrasts before entering the lab—as opposed to acquiring them during the experiment—but other work probes knowledge that is more clearly acquired at home. For example, at 6-9 months, infants already seem to know the meanings of many common nouns referring to food or body-part categories, such as “apple” or “mouth” [^3]. Soon after children begin speaking, there is a vocabulary explosion; a six-year-old knows approximately 14000 words, implying they learn about 9 or 10 words a day in early development [^7] [^4] and suggesting a similarly rapid acquisition of a large amount of categorical knowledge. Although linguistic supervision (e.g. in the form of verbal labels) can guide and sharpen the acquisition of perceptual categories in young infants [^42], experimental evidence regarding early categorization points to a primarily unsupervised perceptually driven process [^2] [^29].

Learning useful, high-level representations without explicit labels is also a major goal in machine learning. Unsupervised or self-supervised learning methods have been experiencing a robust revival recently, with state-of-the-art self-supervised methods now rivaling the representational power of supervised learning in downstream tasks [^16] [^9] [^8]. Currently, the most successful approaches to self-supervised learning are based on contrastive learning [^14], where the basic idea is to learn nearby embeddings for semantically similar objects (e.g. images or videos) by pushing their embeddings together and distant embeddings for semantically dissimilar objects by pulling their embeddings apart. In the absence of explicit labels to determine semantic similarity, one often uses data augmentation to create semantically similar objects, e.g. by applying color distortions to an image [^9]. Contrastive self-supervised learning has been applied to both images [^27] [^18] [^16] [^9] [^8] and videos [^32] [^44] [^22] with promising results. However, these works were primarily motivated by computer vision applications, and did not apply self-supervised learning methods to a developmentally realistic, longitudinal, first-person video dataset. Some relatively large first-person video datasets do exist in the computer vision literature, however they are either not longitudinal, e.g. Charades-Ego [^33], or they are not developmentally realistic (i.e. not recorded from the perspective of developing children), e.g. KrishnaCam [^34]. Moreover, we are not aware of any prior systematic efforts to apply modern self-supervised learning techniques to such datasets (however, see concurrent work by [^45] training models on the SAYCam data aggregated from multiple children to predict neural responses from the ventral visual system).

Conversely, there are some developmentally realistic, first-person datasets recorded from the perspective of children [^21] [^11] [^1], but these datasets are not longitudinal, instead they were collected from multiple children in relatively short segments. Hence, unlike the SAYCam dataset [^38] that we use in this paper, they are not ideally suited to addressing the fundamental nature vs. nurture question that we are interested in.

Our main contributions in this paper are as follows:

- We show for the first time that it is possible to learn useful, high-level visual representations from longitudinal, naturalistic video data representative of the visual experiences of developing children, using state-of-the-art self-supervised learning methods.
- We develop a novel self-supervised learning objective for learning high-level visual representations from video data based on the principle of temporal invariance [^12] [^40] and show that this objective yields better representations than state-of-the-art image-based and temporal contrastive self-supervised learning objectives on the SAYCam dataset.
- From SAYCam, we curate a large, developmentally realistic dataset of labeled images for evaluating self-supervised models and analyze the learned visual representations.

## 3 Dataset

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2007.16189/assets/data.png)

Figure 1: (a) Overall structure of the SAYCam dataset. (b) The classes and the number of frames in each class in the labeled dataset. (c) Random images from the labeled dataset with the category labels indicated on the left. Note that the labeled data are a curated subset of the data from child S.

We use the SAYCam dataset [^38] in this study, hosted on the Databrary repository for behavioral science: [https://nyu.databrary.org/](https://nyu.databrary.org/). Researchers can apply for access to the dataset, with approval from their institution’s IRB.

This dataset contains approximately 500 hours of longitudinal egocentric audiovisual data from three children: 221 hours from child S, 141 hours from child A, and 137 hours from child Y. The data were collected from head-mounted cameras worn by the children over an approximately two year period (ages 6-32 months) with a frequency of 1-2 hours of recording per week. Figure 1a illustrates the overall structure of the dataset. Although the dataset contains both video and audio data, we only make use of the video component in this paper, as our focus is on studying the development of high-level visual representations. In future work, it would be interesting to consider the potential benefits of the audio data in the development of high-level visual representations. The native spatial resolution of the videos is 640 $\times$ 480 pixels for all three children and the temporal resolution is 30 frames per second for children A and S, and 25 frames per second for child Y. Before we apply any self-supervised learning algorithms on the data, we first resize the frames (using bicubic interpolation) so that the minor edge is 256 pixels and then take the 224 $\times$ 224 center crop of the frame shifted by 16 pixels upward to exclude the time stamps at the bottom of the video frames that exist for a subset of the videos. A comparative dimensionality analysis of the SAYCam dataset is given in Appendix A1.

### Annotated data.

Although only raw videos are required for training, we need annotated data for model evaluation, preferably from the same dataset. Fortunately, data from one child (child S) comes with rich annotations for $\sim$ 25% of the videos, transcribed by human annotators. Using these annotations, we manually curated a large dataset of labeled frames, containing $\sim$ 58K frames from 26 classes. Further details on how this labeled dataset was created can be found in Appendix A2. Figure 1b shows the 26 classes in the labeled dataset and the number of frames in each class. Example images from the final labeled dataset are shown in Figure 1c.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2007.16189/assets/schematic.png)

Figure 2: A schematic illustration of the temporal classification objective. Each temporal class consists of a number of adjacent frames. The duration of each temporal class is determined by the segment length parameter.

## 4 Models

Our modeling effort evaluates the feasibility of learning useful high-level visual representations from a subset of an individual child’s visual experience. Our main aim is to measure what is learnable in principle, without necessarily constraining the learning algorithms to be strictly psychologically or biologically plausible. With this aim in mind, we trained deep convolutional networks from scratch, using self-supervised learning algorithms on the headcam videos. After training, we evaluated the self-supervised models on downstream classification tasks with developmentally-relevant categories, freezing the trunk of the model and only training linear readouts from the model’s penultimate, embedding layer. We used the MobileNetV2 architecture in all experiments below due to its favorable efficiency-accuracy trade-off [^31]. This architecture has an embedding layer of 1280 units. Pre-trained models and training/testing code are available at: [https://github.com/eminorhan/baby-vision](https://github.com/eminorhan/baby-vision).

### Temporal classification.

To train models on the headcam video data without using any labels, we developed a new self-supervised learning objective based on the principle of temporal invariance [^12] [^40]. This objective is based on the observation that higher level variables in a visual scene change on a slower time scale than lower level variables, hence a model that learns to be invariant to changes on fast time scales may learn useful high-level features. We implemented this idea with a standard classification set-up, by dividing the entire video dataset into a finite number of temporal classes (or episodes) of equal duration. The objective is then simply to predict which episode any given frame belongs to. A schematic illustration of this temporal classification objective is presented in Figure 2. We note that a similar temporal classification algorithm was proposed by [^19] in earlier work as an unsupervised feature learning method to perform non-linear independent component analysis (ICA).

The temporal classification objective relies on psychologically and biologically plausible mechanisms: e.g. it has been suggested that hippocampus provides high-dimensional, sparse, non-overlapping codes for different episodes in an animal’s daily life [^25]. Here, we suggest that such codes can be used as implicit supervision signals for learning useful high-level visual representations.

Importantly, we trained separate models on data from each child to ensure they capture individual rather than aggregate visual experience. Below, we present results demonstrating the effects of various experimental factors on properties of the learned representations (Figure 5): e.g. the frame rate at which the videos are sampled, the segment length parameter (i.e. the duration of each temporal class or episode), and data augmentation. For the remaining results, we always use our best self-supervised model, as measured by classification performance on the downstream classification tasks. Our best model is a temporal classification model that uses a sampling rate of 5 fps (frames per second), a segment length of 288 seconds, and data augmentation in the form of color and grayscale augmentations as in [^8].

### Static contrastive learning.

To build a strong purely image-based baseline model that does not make use of any temporal information, we trained models with the momentum contrast (MoCo) objective [^16] on the headcam data (now treated as a collection of images with no temporal information). We used the “improved” implementation (V2) of MoCo proposed in [^9]. This objective currently achieves near state-of-the-art results on ImageNet among self-supervised learning methods. The basic idea in contrastive learning is to learn similar embeddings for semantically similar (“positive”) pairs of frames and dissimilar embeddings for semantically dissimilar (“negative”) pairs. We used the PyTorch implementation provided by [^9] for this model, with the same hyper-parameter choices and data augmentation strategies as in [^9]. Further implementation details can be found in Appendix A3.

### Temporal contrastive learning.

We also trained a temporal contrastive learner that did take the temporal relationship between frames into account. This model is similar to the static contrastive learner above, with the difference that each frame’s two immediate neighbors are now treated as positive examples with respect to that frame (temporally non-adjacent frames are still considered as negative pairs as in the static model). Effectively, this model treats temporal jitter between neighboring frames as another type of data augmentation. A similar temporal contrastive learning model was proposed by [^22] before.

### Baseline models.

In addition to the self-supervised models above, we considered several baseline models as controls: (i) an untrained MobileNetV2 model with random weights, (ii) a MobileNetV2 model pre-trained on ImageNet, (iii) HOG features (histogram of oriented gradients) as a shallow baseline [^10]. For the HOG model, we used the implementation in skimage.feature. Further details can be found in Appendix A3.

Figure 3: Downstream linear classification tasks: top-1 accuracy of different models in (a) the labeled S dataset, and in (b) the Toybox dataset. Results are shown for both random iid splits of the datasets, as well as the more challenging splits discussed in the main text. Horizontal dashed lines indicate the performance of the majority class prediction. Model abbreviations: TC-S, TC-A, TC-Y (temporal classification models for S, A, and Y, respectively), MoCo-Temp-S (a temporal MoCo model trained on data from child S), MoCo-Img-S (a static image-based MoCo model trained on data from child S), ImageNet (an ImageNet-trained model), RandomNet (an untrained, randomly initialized MobileNetV2 model), HOG (histogram of gradients model).

## 5 Evaluation and analysis of the learned representations

### Downstream linear classification tasks.

As our main evaluation metric, we evaluated the classification accuracy of our self-supervised models, as well as the accuracy of the baseline models, on two downstream linear classification tasks: (i) the curated, labeled subset of the annotated data from child S described above (we call this dataset labeled S), and (ii) the Toybox dataset [^39].

The Toybox dataset is a video dataset consisting of 12 object categories (airplane, ball, car, cat, cup, duck, giraffe, helicopter, horse, mug, spoon, truck), with 30 different exemplars in each category, each undergoing 10 different transformations, such as translations and rotations, for approximately 20 seconds each (plus a brief canonical shot of the object). When the videos are sampled at 1 fps, the entire dataset contains $\sim$ 7K frames from each of the 12 categories for a total of $\sim$ 84K frames (example images from the dataset are shown in Appendix A4). We chose the Toybox dataset because it contains developmentally realistic objects (toys) belonging to 12 early-learned basic-level categories in child development [^39]. We reasoned that this dataset would thus pose less of a distribution shift problem for our models trained on baby headcam videos, compared to a more complex and diverse dataset such as ImageNet, which is developmentally less realistic (although we do provide results on ImageNet in Appendix A5). Another advantage of the Toybox dataset is that it allows us to evaluate the robustness of self-supervised models to a variety of natural transformations.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2007.16189/assets/binary.png)

Figure 4: (a) Accuracy of three models on four challenging binary classification tasks. Horizontal lines indicate the majority class prediction accuracy. (b) Example ambiguous images from each task and the spatial attention maps of the self-supervised model (TC-S) for the corresponding images. The model’s choice is indicated in red at the bottom right of each picture.

Because both the labeled S and the Toybox datasets are video datasets originally, they contain temporal correlations between nearby frames. This raises the potential concern that with random iid train-test splits, even models employing relatively low-level strategies might be able to perform well by exploiting these temporal correlations. To address this concern, in addition to evaluating the performance of simple baseline models like the shallow HOG model and the random MobileNetV2 model on these datasets, we also introduced more challenging train-test splits for both datasets. For the labeled S dataset, we reduced the temporal correlations between train and test data by subsampling the entire dataset by a factor of 10 (i.e. an effective frame rate of 0.1 fps). For the Toybox dataset, we introduced an exemplar split to examine generalization to novel category exemplars, using 90% of the exemplars for training and 10% for testing (i.e. 27 vs. 3 exemplars from each class). Example images from all evaluation conditions are shown in Appendix A6.

Figure 3 shows the top-1 classification accuracy of all models on the linear classification tasks for both random iid splits (with 50% training-50% test data) and the more challenging splits discussed above. We observe that the self-supervised models with the temporal classification objective perform well in all cases, sometimes even outperforming the strong ImageNet-trained baseline model. Of particular note is the fact that temporal classification models trained on data from children A and Y are able to generalize well to labeled data from child S. The temporal classification model outperformed the contrastive self-supervised models in all conditions. This may be because the contrastive learning objectives we have considered are not ideally suited to longitudinal video data due to long-range temporal correlations. We leave further investigation of this result to future work. The random MobileNetV2 model and the shallow HOG model generally perform poorly compared to the other models, suggesting that learning and sufficiently deep models are necessary for these tasks. The self-supervised models continue to perform reasonably well on the more challenging splits, suggesting that their performance cannot be explained in terms of simple, low-level strategies.

To give a more intuitive sense of the representational power of the self-supervised models, we also set up four challenging but natural binary classification tasks from the labeled S dataset: car vs. road, door vs. window, foot vs. hand, chair vs. table. These tasks are challenging because the two classes in each task are semantically related and co-occur in many images, creating ambiguities. Figure 4a shows that the self-supervised TC-S model achieves relatively high accuracy in all tasks (comparable to the ImageNet-trained model) and more importantly the spatial attention maps verify that the model’s choices seem to be based on the correct regions in ambiguous images (Figure 4b), suggesting that the model does not just exploit spurious correlations to perform well in these tasks (see below for a description of how these spatial attention maps were computed): e.g. in Figure 4b, note how the model attends to the upper part of the image with the red socks in the third row for a foot choice, and the high-chair on the left in the fourth row for a chair choice.

Figure 5: The effects of (a) frame rate, (b) segment length, and (c) data augmentation on classification accuracy in the downstream linear classification task with the labeled S dataset.

### The effect of various experimental factors on downstream linear classification accuracy.

Figure 5 shows the effects of sampling rate, segment length, and data augmentation on classification accuracy in the downstream labeled S task (random iid split condition). Higher sampling rates, longer segments (i.e. fewer temporal classes), and using data augmentation all improve classification accuracy in the downstream task. Increasing the sampling rate can be seen as a form of data augmentation, and the effect of these two factors is intuitively clear: data with more variation enables the learning of stronger features (it is, however, interesting to note that the effect of data augmentation on accuracy is rather small; this may be because these egocentric natural videos already come with a lot of natural variability). The dependence of accuracy on segment length, on the other hand, is a function of the average time scale over which semantically meaningful changes take place in the videos. It is interesting to note that the optimal time scale appears to be fairly long ($\sim$ 5 minutes).

### Spatial attention maps.

To better understand what kind of features the self-supervised models rely on to make their decisions in the downstream classification tasks, we computed spatial attention maps from the final spatial layer of the model (features\[18\] or feats18 for short) using the class activation mapping (CAM) method [^43]. This layer is a 1280 $\times$ 7 $\times$ 7 layer in MobileNetV2 and there is a single global spatial averaging layer between this layer and the output layer. After fitting a linear classifier on top of our best self-supervised model, for each output class in the labeled S dataset, we created a composite attention map from the feats18 layer by taking a linear sum of all 1280 spatial maps in that layer, where the weights in the linear combination were determined by the output weights for the corresponding class (see Appendix A7 for further details and additional examples).

We then upsampled these composite attention maps and multiplied them with the input image, creating image masks that show where the composite map was most activated. Figure 6 shows examples of masked images for the cat class with both actual cat images (a) and non-cat images (b). These images suggest that the model, in general, attends to the correct regions in cat images, but the spatial extent of attention is usually larger than the cat itself, suggesting possible reliance on contextual cues as well. For the non-cat images, the composite map is usually silent, as would be expected from a successful classifier. But there are occasional regions of high activation even in these images, suggesting that the composite maps—and hence the outputs themselves—are not purely class selective.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2007.16189/assets/maps.png)

Figure 6: Masked images indicating the regions in the image the model bases its decisions on. The examples shown are for the output node in the model corresponding to the cat class.

### Analysis of single feature selectivity.

To measure how distributed vs. localized the representation of class information is, we quantified the class selectivity of individual features, $f$, in the model by the following class selectivity index [^26] [^23]:

$$
CSI(f)=\frac{\langle f\rangle_{C_{max}}-\langle f\rangle_{C_{-max}}}{\langle f\rangle_{C_{max}}+\langle f\rangle_{C_{-max}}}
$$

where $\langle f\rangle_{C_{max}}$ denotes the average response of the feature to its most activating class and $\langle f\rangle_{C_{-max}}$ denotes its average response to the remaining classes. In computing the average responses, we averaged across the spatial dimensions to obtain a single value per feature per image. The $CSI$ ranges from $0$ (for features completely agnostic between classes) to $1$ (for features perfectly selective for a single class).

Figure 7a shows the distribution of CSIs of individual features in different layers of our best self-supervised model. Single features were generally not very selective for individual classes, pointing to a more distributed representation of class information. The layers close to the output, in general, had higher CSIs, consistent with a similar observation made in [^23] for supervised models. Figure 7b shows 10 highly activating images from the labeled S dataset for 3 example features with high CSIs, selective for the carseat, computer, and floor classes, respectively. The example features shown in this figure are from the highest spatial layer of the network (feats18). More examples are presented in Appendix A8.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2007.16189/assets/selectivity.png)

Figure 7: (a) Distribution of CSI s in different layers of the model. Horizontal lines indicate the mean of the distribution. (b) 10 highly activating images from the labeled S dataset for three features with high s. The most selective classes of these features are indicated in parenthesis. To ensure sufficient diversity in examples displayed here, we first randomly sampled 1024 images from the labeled S dataset, then showed the top 10 most activating images from among this sample.

## 6 Limitations

To our knowledge, our work is the first to systematically explore what can be learned from naturalistic visual experience children receive during their development. However, it has several limitations which are important to keep in mind and which would be worthwhile to address in future work.

First, although SAYCam offers an unprecedented look at the experience of individual children, the training videos are a very small fraction of a child’s total visual experience, equivalent to $\sim$ 1 week of visual experience (well-distributed over two years of development). Scaling this up to better approximate a 2.5 year old’s experience would require roughly two orders of magnitude more data. Recent results in machine learning suggest that increases in data size on this scale can lead to very large qualitative improvements in model behavior [^15] [^28] [^41] [^6].

Second, the dataset used in this study includes videos only, hence it ignores the embodied aspect of visual development in children. Humans (and other animals) control their bodies to select the visual experiences they receive. This creates a rich array of sensorimotor inputs that likely help the observer better factorize the sources of variation in their visual experiences. Visual development also has a significant haptic component in animals, especially in dexterous animals like primates, as they can haptically explore the objects around them, which gives them high-quality information about the shapes of objects, for example. Recent computational studies suggest that taking this embodied perspective into account can improve representation learning both in terms of learning speed and in terms of generalization capacity [^20] [^17].

Third, and related to the previous point, we also ignored the multimodal nature of cognitive development. Particularly relevant for the development of visual categories is word learning in children. Experimental studies in developmental psychology show that learning object names can change the visual features children use for word learning [^35] [^13]. We plan to address the role of language through the auditory component of SAYCam in future work.

Fourth, our best self-supervised models currently require unrealistic data augmentation strategies, such as color distortions and grayscaling. It remains to be seen whether equally powerful models can be learned without such unrealistic data augmentation strategies.

## 7 Discussion

In this work, we took a first step toward rigorously addressing a fundamental nature vs. nurture question regarding the acquisition of basic visual categories in developing children: can these visual categories be learned through generic learning mechanisms or do they require more substantive inductive biases? By applying modern self-supervised learning algorithms to a strict subset of the visual experiences of individual developing children, we demonstrated the emergence of powerful high-level visual representations, underscoring the power of generic learning mechanisms. Our analysis suggests that although these representations do not strictly correspond to abstract categories (Figure 6), they are abstract enough to support (i) high accuracy in non-trivial downstream categorization tasks (Figure 3), (ii) invariance to natural transformations (random $iid$ conditions in Figure 3) and (iii) generalization to unseen category exemplars (Figure 3b; exemplar split). It still remains open how far we can push generic learning mechanisms, through even larger and richer data sources, to learn mental representations ever closer to those acquired by children early in their development.

## Broader Impact

This research addresses a basic scientific question: what kind of visual representations can be learned from developmentally realistic, natural video data, using state of the art self-supervised learning methods? As such, it does not have any significant foreseeable societal consequences and, to the best of our knowledge, the results of this study do not advantage or disadvantage any particular individual or group of individuals. The use of the SAYCam dataset was approved by our Institutional Review Board (IRB) and we followed all applicable guidelines for the use of this dataset.

## Acknowledgements

We are very grateful to the volunteers who contributed recordings to the SAYCam dataset [^38]. We thank Jessica Sullivan for her generous assistance with the dataset. This work was partly funded by NSF Award 1922658 NRT-HDR: FUTURE Foundations, Translation, and Responsibility for Data Science.

## References

## Appendix

## Appendix A1 Comparative dimensionality analysis

Figure A1 shows the variance explained in same sized subsets of 4 different image and video datasets: ImageNet, the headcam videos from child S, and the matched first-person and third-person videos from the Charades-Ego dataset [^33]. The images or video frames in each dataset were first passed through the largest ResNeXt WSL model with an embedding layer of size 2048 [^24]. We then performed a PCA analysis on the embeddings from each dataset, looking at the variance explained as a function of the number of retained dimensions. The video datasets were sampled at 1 fps. Figure A1 shows that, as expected, the video datasets (first-person and third-person videos from the Charades-Ego dataset and the headcam videos from child S) have lower information content than ImageNet, due to temporal correlations in videos. The first-person video datasets (first-person Charades-Ego and the headcam data from child S) have slightly higher information content than the third-person Charades-Ego dataset, presumably because of the higher degree of variability due to natural distortions and perturbations in these first-person videos.

## Appendix A2 Curation process for the labeled S dataset

As mentioned in the main text, the headcam data from one of the babies (child S) comes with rich annotations for $\sim$ 25% of the videos, transcribed by human annotators. Using these annotations, we manually curated a large dataset of labeled frames, containing $\sim$ 58K frames from 26 classes.The annotations include information such as the objects being looked at by the child, the objects being touched by the child, and the objects being referred to, as well as the utterances made, together with approximate time stamps. We used the the objects being looked at by the child field to assemble a large collection of labeled frames for evaluation purposes. This field often includes multiple labels for each cell (a cell is the collection of frames between two consecutive time stamps). We only considered the first used label in each cell and performed basic string processing operations to reduce the redundancies in the labels due to annotation inconsistencies (e.g. capitalization, typos, synonymous labels etc.). This reduced the final number of unique labels to 414. We used these labels and the time stamps provided in the annotations to label individual frames in the videos, where we sampled the frames at 1 fps (frames per second).

Figure A1: Comparative intrinsic dimensionality analysis of four different datasets.

For evaluation purposes, we further modified this noisy labeled dataset as follows. To obtain a dataset with a sufficiently large number of frames from each class, we restricted ourselves to the top 30 classes containing the largest number of frames. To obtain a balanced dataset, we then removed the top two classes (mom and book), which contained significantly more frames than the remaining classes. For the remaining classes, to make sure that the labels are clean enough for evaluation, we manually went through each of them, removing frames or changing their labels as necessary. We note that despite our best efforts during this manual cleaning process, some amount of noise and ambiguity might still exist in the labels. We finally removed any classes that contained fewer than 100 frames. This yielded a labeled dataset containing a total of $\sim$ 58K frames from 26 classes. The final classes and the number of frames in each class are shown in Figure 1b in the main text.

## Appendix A3 Model implementation details

### Self-supervised models.

We trained the temporal classification models with the Adam optimizer with learning rate $0.0005$ and a batch size of $732$ (maximum batch size we could fit into 4 GPUs using data parallelism). Models trained with 1 fps data were trained for 20 epochs and models trained with 5 fps data were trained for 6 epochs. Final top-1 training accuracy in the temporal classification task was always in the 80-85% range. Before feeding the frames into the model, we always applied the standard ImageNet normalization step (see below). In addition, in the data augmentation conditions, we also applied the probabilistic color jittering and grayscaling transformations from [^8]:

transforms.Compose(\[  
transforms.RandomApply(\[transforms.ColorJitter(0.8, 0.8, 0.8, 0.2)\], p=0.8),  
transforms.RandomGrayscale(p=0.2),  
transforms.ToTensor(),  
transforms.Normalize(mean=\[0.485, 0.456, 0.406\], std=\[0.229, 0.224, 0.225\])\])

For the static and temporal contrastive learning models, we used the PyTorch implementation of MoCo-V2 provided by [^9] as is, with the same hyper-parameter choices and data augmentation strategies <sup>1</sup>. We trained the models for 6 epochs with headcam video frames sampled at 5 fps. The learning rate was reduced by a factor of 10 in the final epoch.

### HOG model.

For the histogram of oriented gradients (HOG) model, we used the implementation provided in scikits-image (skimage.feature) with the following arguments: orientations=9, pixels\_per\_cell=(16, 16), cells\_per\_block=(3, 3), block\_norm=‘L2’, visualize=False, transform\_sqrt=False, feature\_vector=True, multichannel=True. To fit linear classifiers on top of these features, we used the SGD classifier in scikit-learn (sklearn.linear\_model), SGDClassifier, with the following arguments: loss=‘‘hinge’’, penalty=‘‘l2’’, alpha=0.0001, max\_iter=250.

## Appendix A4 Example images from the Toybox dataset

As mentioned in the main text, we subsampled the videos from the Toybox dataset [^39] at 1 fps, which resulted in $\sim$ 7K images from each of the 12 classes in the dataset. Figure A2 shows example images from each of the 12 classes in the dataset.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2007.16189/assets/toybox.png)

Figure A2: Example images from the Toybox dataset 39. Each row shows 10 random images from a different class. From top to bottom row, the classes are: airplane, ball car cat cup duck giraffe helicopter horse mug spoon truck.

## Appendix A5 Linear classification results on ImageNet

Although the ImageNet dataset poses a significant distribution shift challenge for models trained on the baby headcam videos, we still evaluated the performance of linear classifiers trained on top of our self-supervised models and obtained the following top-1 accuracies on the ImageNet validation set: TC-S: 20.9%, TC-A: 18.1%, TC-Y: 17.6%, MoCo-V2-S: 16.4%. We also observed that it was possible to achieve close to $\sim$ 25% top-1 accuracy with a temporal classification model trained on data from all three children. For comparison, a linear classifier trained on top of a random, untrained MobileNetV2 model (RandomNet) yields a top-1 accuracy of 1.2%. For these ImageNet results, we trained the linear classifiers for 20 epochs with the Adam optimizer using a learning rate of 0.0005 and a batch size of 1024. The training and validation images from ImageNet were subjected to the standard ImageNet pre-processing pipeline.

## Appendix A6 Example images from all evaluation conditions

Figure A3 shows example images from the two splits of both datasets used for evaluation in this paper, i.e. labeled S and Toybox.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2007.16189/assets/eval_conds.png)

Figure A3: (a) Example images from the baseline 1-fps sampling of the labeled S dataset (top) and the 10 × \\times -subsampled (0.1-fps) version of it (bottom). The shown images are the first 36 frames from the cat class in both versions of the dataset. Note that the temporal correlations are substantially reduced in the 10 -subsampled version. (b) An illustration of the random iid and exemplar splits of the Toybox dataset. The random split (top row) measures generalization to unseen views (in this case a novel translation of a familiar airplane ), whereas the exemplar split (bottom row) measures generalization to unseen exemplars (in this case a novel ).

## Appendix A7 Spatial attention maps

The spatial attention maps shown in Figure 4b and Figure 6 in the main text were generated from the final spatial layer of the network, using the class activation mapping (CAM) method introduced in [^43]. This layer is a 1280 $\times$ 7 $\times$ 7 layer in MobileNetV2. There is a single global spatial averaging layer between this layer and the output layer. After fitting a linear classifier on top of our best self-supervised model, for each output class in the dataset, we created a composite attention map by taking a linear sum of all 1280 7 $\times$ 7 spatial maps, where the weights in the linear combination were determined by the output weights from the corresponding feature to the output node. This results in a single 7 $\times$ 7 spatial map for each image. We then upsampled this 7 $\times$ 7 map to the image size (224 $\times$ 224) using bicubic interpolation, divided each pixel value by the standard deviation across all pixels, multiplied the entire map by 10 to amplify it and finally passed it through a pixelwise sigmoid non-linearity, i.e. m<-sigmoid(10.0\*m/std(m)). We then multiplied the attention map with the presented image pixel-by-pixel to obtain the masked images shown in Figure 4b and Figure 6 in the main text. Figure A4 below shows further examples of spatial-attention-multiplied images for the computer class.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2007.16189/assets/computermaps.png)

Figure A4: Example spatial attention maps for the computer class in response to (a) computer and (b) non-computer images (similar to Figure 6 in the main text). Note that the attended locations usually make sense for detecting computers.

## Appendix A8 Single feature selectivity analysis

Figure A5 below shows further examples of highly activating images for different features in our best self-supervised model (similar to Figure 7b in the main text).

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2007.16189/assets/selectivities.png)

Figure A5: Further examples of highly activating images for different features in our best self-supervised model (similar to Figure 7 b in the main text). Each row corresponds to a different feature. These features are all from the final spatial layer of the network ( features\[18\] ). The CSI value of the feature and the most activating class are indicated at the top of each panel. These images were generated in the same way as those shown in Figure b in the main text, i.e. to ensure sufficient diversity among displayed examples, we first randomly sampled 1024 images from the labeled S dataset, then displayed the top 10 most activating images from this sub-sample.

[^1]: Bambach, S., Crandall, D. J., Smith, L. B., and Yu, C. (2018). Toddler-Inspired Visual Object Learning. Advances in Neural Information Processing Systems.

[^2]: Behl-Chadha, G. (1996). Basic-level and superordinate-like categorical representations in early infancy. Cognition, 60(2):105–141.

[^3]: Bergelson, E. and Swingley, D. (2012). At 6-9 months, human infants know the meanings of many common nouns. Proceedings of the National Academy of Sciences, 109(9):3253–8.

[^4]: Bloom, P. (2002). How Children Learn the Meanings of Words. MIT Press.

[^5]: Bomba, P. C. and Siqueland, E. R. (1983). The nature and structure of infant form categories. Journal of Experimental Child Psychology, 35(2):294–328.

[^6]: Brown, T. B., Mann, B., Ryder, N., Subbiah, M., Kaplan, J., Dhariwal, P., Neelakantan, A., Shyam, P., Sastry, G., Askell, A., et al. (2020). Language models are few-shot learners. arXiv preprint arXiv:2005.14165.

[^7]: Carey, S. and Bartlett, E. (1978). Acquiring a single new word. In Proceedings of the Stanford Child Language Conference, pages 17–29.

[^8]: Chen, T., Kornblith, S., Norouzi, M., and Hinton, G. (2020a). A simple framework for contrastive learning of visual representations. arXiv preprint arXiv:2002.05709.

[^9]: Chen, X., Fan, H., Girshick, R., and He, K. (2020b). Improved baselines with momentum contrastive learning. arXiv preprint arXiv:2003.04297.

[^10]: Dalal, N. and Triggs, B. (2005). Histograms of oriented gradients for human detection. In 2005 IEEE Computer Society Conference on Computer Vision and Pattern Recognition (CVPR’05), volume 1, pages 886–893. IEEE.

[^11]: Fausey, C. M., Jayaraman, S., and Smith, L. B. (2016). From faces to hands: Changing visual input in the first two years. Cognition, 152:101–107.

[^12]: Földiák, P. (1991). Learning invariance from transformation sequences. Neural Computation, 3(2):194–200.

[^13]: Gershkoff-Stowe, L. and Smith, L. B. (2004). Shape and the first hundred nouns. Child Development, 75(4):1098–1114.

[^14]: Hadsell, R., Chopra, S., and LeCun, Y. (2006). Dimensionality reduction by learning an invariant mapping. In 2006 IEEE Computer Society Conference on Computer Vision and Pattern Recognition (CVPR’06), volume 2, pages 1735–1742. IEEE.

[^15]: Halevy, A., Norvig, P., and Pereira, F. (2009). The unreasonable effectiveness of data. IEEE Intelligent Systems, 24(2):8–12.

[^16]: He, K., Fan, H., Wu, Y., Xie, S., and Girshick, R. (2019). Momentum contrast for unsupervised visual representation learning. arXiv preprint arXiv:1911.05722.

[^17]: Hill, F., Lampinen, A., Schneider, R., Clark, S., Botvinick, M., McClelland, J. L., and Santoro, A. (2019). Emergent systematic generalization in a situated agent. arXiv preprint arXiv:1910.00571.

[^18]: Hjelm, R. D., Fedorov, A., Lavoie-Marchildon, S., Grewal, K., Bachman, P., Trischler, A., and Bengio, Y. (2018). Learning deep representations by mutual information estimation and maximization. arXiv preprint arXiv:1808.06670.

[^19]: Hyvärinen, A. and Morioka, H. (2016). Unsupervised feature extraction by time-contrastive learning and nonlinear ICA. Advances in Neural Information Processing Systems, 29:3765–3773.

[^20]: Jacobs, R. A. and Xu, C. (2019). Can multisensory training aid visual learning? A computational investigation. Journal of Vision, 19(11):1–1.

[^21]: Jayaraman, S., Fausey, C. M., and Smith, L. B. (2015). The faces in infant-perspective scenes change over the first year of life. PLoS ONE, 10(5).

[^22]: Knights, J., Vanderkop, A., Ward, D., Mackenzie-Ross, O., and Moghadam, P. (2020). Temporally coherent embeddings for self-supervised video representation learning. arXiv preprint arXiv:2004.02753.

[^23]: Leavitt, M. L. and Morcos, A. (2020). Selectivity considered harmful: Evaluating the causal impact of class selectivity in DNNs. arXiv preprint arXiv:2003.01262.

[^24]: Mahajan, D., Girshick, R., Ramanathan, V., He, K., Paluri, M., Li, Y., Bharambe, A., and van der Maaten, L. (2018). Exploring the limits of weakly supervised pretraining. In Proceedings of the European Conference on Computer Vision (ECCV), pages 181–196.

[^25]: Marr, D. (1971). Simple memory: a theory for archicortex. Philosophical Transactions of the Royal Society of London B, Biological Sciences, 262(841):23–81.

[^26]: Morcos, A. S., Barrett, D. G., Rabinowitz, N. C., and Botvinick, M. (2018). On the importance of single directions for generalization. In International Conference on Learning Representations.

[^27]: Oord, A. v. d., Li, Y., and Vinyals, O. (2018). Representation learning with contrastive predictive coding. arXiv preprint arXiv:1807.03748.

[^28]: Orhan, A. E. (2019). Robustness properties of Facebook’s ResNeXt WSL models. arXiv preprint arXiv:1907.07640.

[^29]: Quinn, P. C. (2002). Category representation in young infants. Current Directions in Psychological Science, 11(2):66–70.

[^30]: Quinn, P. C., Eimas, P. D., and Rosenkrantz, S. L. (1993). Evidence for representations of perceptually similar natural categories by 3-month-old and 4-month-old infants. Perception, 22(4):463–475.

[^31]: Sandler, M., Howard, A., Zhu, M., Zhmoginov, A., and Chen, L.-C. (2018). MobileNetV2: Inverted residuals and linear bottlenecks. In Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition (CVPR), pages 4510–4520.

[^32]: Sermanet, P., Lynch, C., Chebotar, Y., Hsu, J., Jang, E., Schaal, S., Levine, S., and Brain, G. (2018). Time-contrastive networks: Self-supervised learning from video. In 2018 IEEE International Conference on Robotics and Automation (ICRA), pages 1134–1141. IEEE.

[^33]: Sigurdsson, G. A., Gupta, A., Schmid, C., Farhadi, A., and Alahari, K. (2018). Actor and observer: Joint modeling of first and third-person videos. In Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition (CVPR), pages 7396–7404.

[^34]: Singh, K. K., Fatahalian, K., and Efros, A. A. (2016). KrishnaCam: Using a longitudinal, single-person, egocentric dataset for scene understanding tasks. In 2016 IEEE Winter Conference on Applications of Computer Vision (WACV), pages 1–9. IEEE.

[^35]: Smith, L. B., Jones, S. S., Landau, B., Gershkoff-Stowe, L., and Samuelson, L. (2002). Object name learning provides on-the-job training for attention. Psychological Science, 13(1):13–19.

[^36]: Smith, L. B. and Slone, L. K. (2017). A developmental approach to machine learning? Frontiers in Psychology, 8.

[^37]: Spelke, E. S. and Kinzler, K. D. (2007). Core knowledge. Developmental Science, 10(1):89–96.

[^38]: Sullivan, J., Mei, M., Perfors, A., Wojcik, E. H., and Frank, M. C. (2020). SAYCam: A large, longitudinal audiovisual dataset recorded from the infant’s perspective. PsyArXiv. https://doi.org/10.31234/osf.io/fy8zx.

[^39]: Wang, X., Ma, T., Ainooson, J., Cha, S., Wang, X., Molla, A., and Kunda, M. (2018). Seeing neural networks through a box of toys: The Toybox dataset of visual object transformations. arxiv preprint arXiv:1806.06034.

[^40]: Wiskott, L. and Sejnowski, T. J. (2002). Slow feature analysis: Unsupervised learning of invariances. Neural Computation, 14(4):715–770.

[^41]: Xie, Q., Hovy, E., Luong, M.-T., and Le, Q. V. (2019). Self-training with noisy student improves imagenet classification. arXiv preprint arXiv:1911.04252.

[^42]: Xu, F., Cote, M., and Baker, A. (2005). Labeling guides object individuation in 12-month-old infants. Psychological Science, 16(5):372–377.

[^43]: Zhou, B., Khosla, A., Lapedriza, A., Oliva, A., and Torralba, A. (2016). Learning deep features for discriminative localization. In Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition (CVPR), pages 2921–2929.

[^44]: Zhuang, C., She, T., Andonian, A., Mark, M. S., and Yamins, D. (2020a). Unsupervised learning from video with deep neural embeddings. In Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition (CVPR), pages 9563–9572.

[^45]: Zhuang, C., Yan, S., Nayebi, A., Schrimpf, M., Frank, M., DiCarlo, J., and Yamins, D. (2020b). Unsupervised neural network models of the ventral visual stream. bioRxiv.