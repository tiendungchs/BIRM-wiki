---
title: "Neural Systems Underlying the Implementation of Working Memory Removal Operations"
source: "https://pmc.ncbi.nlm.nih.gov/articles/PMC10866188/"
author:
  - "[[Jacob DeRosa]]"
  - "[[Hyojeong Kim]]"
  - "[[Jarrod A. Lewis-Peacock]]"
  - "[[Marie T. Banich]]"
published: 2024-01-10
created: 2026-08-09
description: "RSA + Leiden community detection over 360 Glasser parcels, 55 subjects, four cued working-memory operations (maintain / replace / suppress / clear). Four representational networks; only the frontoparietal control network separates all four operations. Re-analysis of Kim et al. (2020). J. Neuroscience 44(2):e0283232023."
tags:
  - "clippings"
  - "working-memory"
  - "cognitive-control"
  - "removal"
  - "fmri"
  - "rsa"
---

Neural Systems Underlying the Implementation of Working Memory Removal Operations - PMC

Skip to main content

Official websites use .gov

A
.gov website belongs to an official
government organization in the United States.

Secure .gov websites use HTTPS

A lock (

) or https:// means you've safely
connected to the .gov website. Share sensitive
information only on official, secure websites.

Search PMC Full-Text Archive

Search in PMC

Journal List

User Guide

### PERMALINK

Copy

As a library, NLM provides access to scientific literature. Inclusion in an NLM database does not imply endorsement of, or agreement with,
the contents by NLM or the National Institutes of Health.

Learn more:
PMC Disclaimer
|

PMC Copyright Notice

J Neurosci
. 2024 Jan 10;44(2):e0283232023. doi: 10.1523/JNEUROSCI.0283-23.2023

### Neural Systems Underlying the Implementation of Working Memory Removal Operations

Jacob DeRosa

### Jacob DeRosa

1Department of Psychology and Neuroscience, University of Colorado Boulder, Boulder, CO 80309

2Institute of Cognitive Science, University of Colorado Boulder, Boulder, CO 80309

Find articles by Jacob DeRosa

1,2,✉, Hyojeong Kim

### Hyojeong Kim

2Institute of Cognitive Science, University of Colorado Boulder, Boulder, CO 80309

Find articles by Hyojeong Kim

2, Jarrod Lewis-Peacock

### Jarrod Lewis-Peacock

3Department of Psychology, University of Texas at Austin, Austin, TX 78712

Find articles by Jarrod Lewis-Peacock

3, Marie T Banich

### Marie T Banich

1Department of Psychology and Neuroscience, University of Colorado Boulder, Boulder, CO 80309

2Institute of Cognitive Science, University of Colorado Boulder, Boulder, CO 80309

Find articles by Marie T Banich

1,2

Author information

Article notes

Copyright and License information

1Department of Psychology and Neuroscience, University of Colorado Boulder, Boulder, CO 80309

2Institute of Cognitive Science, University of Colorado Boulder, Boulder, CO 80309

3Department of Psychology, University of Texas at Austin, Austin, TX 78712

Author contributions: J.D., J.L-P., and M.T.B. designed the research; J.D. performed the research; J.D. contributed to unpublished reagents/analytic tools; J.D. and H.K. analyzed the data; J.D. wrote the first draft of the paper; J.D., H.K., J.L-P., and M.T.B. edited the paper; J.D. wrote the paper.

Acknowledgments: This research was supported by R56 MH125642 and R01 MH129042 to M. Banich and J. Lewis-Peacock, MPIs.

The authors declare no competing financial interests.

✉Correspondence should be addressed to Jacob DeRosa at jacob.derosa@colorado.edu.

✉Corresponding author.

Received 2023 Feb 15; Revised 2023 Sep 24; Accepted 2023 Oct 27.

Copyright © 2024 the authors

SfN exclusive license.

PMC Copyright notice

PMCID: PMC10866188 PMID: 37963765

### Abstract

Recently, multi-voxel pattern analysis has verified that information can be removed from working memory (WM) via three distinct operations replacement, suppression, or clearing compared to information being maintained (Kim et al., 2020). While univariate analyses and classifier importance maps in Kim et al. (2020) identified brain regions that contribute to these operations, they did not elucidate whether these regions represent the operations similarly or uniquely. Using Leiden-community-detection on a sample of 55 humans (17 male), we identified four brain networks, each of which has a unique configuration of multi-voxel activity patterns by which it represents these WM operations. The visual network (VN) shows similar multi-voxel patterns for maintain and replace, which are highly dissimilar from suppress and clear, suggesting this network differentiates whether an item is held in WM or not. The somatomotor network (SMN) shows a distinct multi-voxel pattern for clear relative to the other operations, indicating the uniqueness of this operation. The default mode network (DMN) has distinct patterns for suppress and clear, but these two operations are more similar to each other than to maintain and replace, a pattern intermediate to that of the VN and SMN. The frontoparietal control network (FPCN) displays distinct multi-voxel patterns for each of the four operations, suggesting that this network likely plays an important role in implementing these WM operations. These results indicate that the operations involved in removing information from WM can be performed in parallel by distinct brain networks, each of which has a particular configuration by which they represent these operations.

Keywords: cognitive neuroscience, machine learning, cognitive control, network neuroscience, representational similarity analysis, working memory

### Significance Statement

The ability to actively remove, manipulate, and maintain information in working memory (WM) is required for the control and removal of thoughts. Representational similarity analysis (RSA) was used to identify multi-voxel patterns of activity representing four distinct WM operations—maintenance of information, replacement of one item by another, suppression of a specific item, and clearing the mind of all thought. In a novel methodological approach (applicable to other cognitive neuroscience investigations), a community detection procedure on the RSA patterns identified four different brain networks, which each has a unique configuration for representing these four operations. Only one network, the frontoparietal control network, differentiates all four operations, suggesting it plays a critical role in the controlled removal of information from WM.

### Introduction

The capacity of working memory (WM) is finite, and old information must be removed for new information to be effectively encoded (Ahmed and De Fockert, 2011; Lewis-Peacock et al., 2018). Most prior research has examined how information is gated into WM or how attention is shifted amongst items in WM, but not the mechanisms by which information is actively removed from WM. This question has been challenging to investigate because a method is needed to verify that an item in WM has actually been removed. Recent work using neuroimaging has overcome this problem and has provided insights into the mechanisms by which information can be removed and the brain regions that play a role in doing so (Banich et al., 2015; Kim et al., 2020).

This research has identified three distinct ways of removing information from WM: by replacing one item with another, by suppressing thoughts of a specific item, and by clearing the mind of all thoughts. Univariate analyses (Banich et al., 2015) revealed that some of these operations may involve the same brain regions. For example, compared to maintaining information, all three of these removal operations activate superior parietal regions, consistent with the role of this region in shifting attention to information in WM (Tamber-Rosenau et al., 2011), while the prefrontal cortex is commonly activated for the suppress and clear operations, consistent with the idea that actively removing information is cognitively demanding.

Following up on these findings, Kim et al. (2020) used machine learning techniques to identify unique multivariate activation signatures for each of the four operations: maintain, replace, suppress, and clear. This approach reliably identifies regions that contribute to classifying the operations (i.e., classifier importance maps). Once again, it was observed that the same brain region contributes to multiple operations.

Given this overlap of activation across different operations in particular brain regions, it is not apparent whether these regions are representing the operations in a unified manner (e.g., no distinction between replace, suppress, and clear) or whether these regions differentiate between them (e.g., distinguishing between each of replace, suppress, and clear). Furthermore, it remains unclear whether brain regions commonly identified in the importance map for a given operation are representing that operation in the same or distinct manners. The current study examines these questions by identifying “representational brain networks,” which are a set of brain regions that show similar multi-voxel patterns of activation. This approach relies on representational similarity analysis (RSA), which identifies multi-voxel patterns of activity during a given mental operation (Kriegeskorte et al., 2008).

Here we investigate whether there are distinct representational networks for WM removal operations via a unique pipeline of methodological approaches that may have broader applicability to other cognitive neuroscience investigations. We re-analyzed the data from Kim et al. (2020) using RSA to evaluate the multi-voxel activation patterns within brain parcels (Glasser et al., 2016) for each of the four operations. Then Leiden community detection (LCD; Traag et al., 2019) was applied to the RSA pattern matrices across the parcels to determine whether there are distinct networks of brain regions that each has a unique configuration for representing those operations (e.g., differentiating clear and suppress, but not maintain and replace). The identification of distinct networks, as we demonstrate in the current study, suggests that these operations may be represented in different configurations in parallel across multiple brain networks. Ultimately, our study seeks to offer a novel framework and methodological approach that could further our understanding of the brain’s versatility in orchestrating these different removal operations and which may have broader applicability to other cognitive neuroscience investigations.

### Materials and Methods

Because this study involves a re-analysis of the data from Kim et al. (2020), full data collection procedures are described in that study and only essential details are highlighted below.

### Participants

A total of 55 participants (17 male; age, M = 23.52, SD = 4.93) were included in all analyses. All participants had normal or corrected-to-normal vision and provided informed consent. The study was approved by the University of Colorado Boulder Institutional Review Board (IRB protocol # 16-0249).

### Experimental design and statistical analyses

### Stimuli

Stimuli for the fMRI study consisted of colored images (920 × 920 pixels) from three categories with three subcategories each: faces (actor, musician, politician), fruit (apple, grape, pear), and scenes (beach, bridge, mountain). Faces were recognizable celebrities, and scenes were recognizable locales (e.g., a tropical beach) or famous landmarks. Images were obtained from various resources, including the Bank of Standardized Stimuli and Google Images. Six images from each subcategory were used, for a total of 18 images per category and 54 images in total. All images were used for both the localizer and study phases of the experiment.

### Data acquisition

MRI data were acquired on a Siemens PRISMA 3.0 Tesla scanner at the Intermountain Neuroimaging Consortium on the University of Colorado Boulder campus. Structural scans were acquired with a T1-weighted sequence, with the following parameters: repetition time (TR) = 2,400 ms, echo time (TE) = 2.07 ms, field of view (FOV) = 256 mm, with a 0.8× 0.8 × 0.8 mm3 voxel size, acquired across 224 coronal slices. Functional MRI (fMRI) scans for both the functional localizer and central study were obtained using a sequence with the following parameters: TR = 460 ms, TE = 27.2 ms, FOV = 248 mm, multiband acceleration factor = 8, with a 3 × 3 × 3 mm3 voxel size, acquired across 56 axial slices and aligned along the anterior commissure–posterior commissure line. For the functional localizer task, five runs were acquired in total, with each run consisting of 805 echo planar images (EPIs), for a total of 4,025 images across the five runs. For the central study, six runs were acquired in total, with each run consisting of 1,175 EPIs, for a total of 7,050 images across the six runs. For full details of task and data acquisition, refer to Kim et al. (2020).

### fMRI procedure

The experiment consisted of two phases completed in order: a functional localizer and a central study. Prior to completing both tasks in the MRI scanner, participants received training on the tasks outside of the scanner, including nine trials of the functional localizer task (three of each category of stimuli) and four self-paced trials of the central study (one trial per condition). Both tasks involved presenting participants with the same set of color images, though the tasks differed in what the participants were asked to do when presented with these images. All stimuli were presented on a black background with task-related words and fixation crosses shown in white font. Refer to Kim et al. (2020) for details on the five functional localizer runs. Note these runs were not included in the present analysis.

The central study was designed to allow us to track the representational status of a WM item while it was being manipulated using five distinct cognitive operations: maintaining an image in WM (maintain), replacing an image in WM with the memory of an image from a different subcategory of the same superordinate category (e.g., replacing an actor with a politician; replace subcategory), replacing an image in WM with the memory of an image from a different category (e.g., replacing an actor with an apple; replace category), suppressing an image in WM (suppress), and clearing the mind of all thought (clear). Note that classification results for replace subcategory and replace category trials from the previous study were nearly identical, and thus only replace category data are included in the main paper to control the number of trials across operation. On each trial, participants were presented with an image for six TRs (2,760 ms) followed by another six TRs of an operation screen instructing participants how to manipulate the item in WM, and then a jittered inter-trial fixation lasting between five and nine TRs (2,300–4,140 ms), consisting of a white fixation cross centered over a black background. The operation screen consisted of two words in the top and bottom halves of the screen, presented over a black background. For the maintain, suppress, and clear operations, the two words were the same: maintain, suppress, or clear, respectively. In the two replace conditions, the word in the top half was switch, whereas the word in the bottom half indicated the subcategory of image that the participant should switch to (e.g., apple). During practice and before the beginning of the task, participants were instructed to only switch to thinking about an image that had previously been shown during the functional localizer task. For example, if a participant was instructed to switch to thinking about an apple, that apple should be one of the apples that was presented to them during the localizer. Participants completed six runs of this task (9.01 min each, 54.05 min total), resulting in a total of 360 trials: 72 trials per operation, of which 24 trials were image category-specific trials per each operation condition. Each run had 40 TR long (18.4 s) fixation blocks at the beginning and end of the run. Within a single run, 12 trials were presented for each of the five operations, resulting in a total of 60 trials per run. Each image exemplar appeared at least once per operation condition across the entirety of the task. Trials were ordered pseudo-randomly within runs, with the order of trials optimized for BOLD deconvolution using optseq2 (Dale, 1999). We focused on four operations, and 288 trials were used in the main analysis.

### Analytic overview

We identified communities (i.e., networks) of brain regions based on the RSA activation pattern similarities across four operations at the trial level to investigate the representational similarities and differences across operations regarding their underlying brain networks. The representational similarity between brain parcels (see below) allows us to investigate the brain’s community structure (networks) concerning the between-operations similarity in multi-voxel activation patterns. We chose RSA patterns to derive the brain networks because we aimed to investigate the similarity between brain regions regarding how they represent task-related information across the WM operations.

To derive our representational networks, we applied a multi-step network analysis procedure (see Fig. 1). We chose this data-driven approach to derive our networks based on activity patterns across the four WM operations because pre-defined network templates may inaccurately reflect the organization of activity patterns in the brain across these operations. We applied LCD (Traag et al., 2019) on the weighted k-nearest neighbor graph (k-NNG) to partition the graph to obtain our final network solution to determine whether the parcels could be grouped into networks that similarly represent these operations. LCD has been used to identify well-connected structures in the brain (Hänisch et al. 2023) and proposed as a valid algorithm for deriving brain networks (Chen et al., 2022). Our LCD analysis used bagging (i.e., bootstrap aggregation) to maximize network reproducibility (Nikolaidis et al., 2020, 2021). We then performed additional analyses concerning the similarity and dissimilarity of activation patterns within each of the four representational networks identified by LCD. A more in-depth outline of the methodological details of these analyses is provided below for the interested reader.

### Figure 1.

Open in a new tab

Outline of the steps to obtain the four representational brain networks. 1, On each trial, participants viewed a picture (a face, fruit, or scene) for 2.76  s (s). A screen appeared for 2.76  s indicating which one of four different cognitive operations (maintain, replace, suppress, clear) should be applied to the just-viewed image. 2, The Glasser parcellation (Glasser et al., 2016) was used to extract 360 parcels covering a whole brain (180 parcels/hemisphere) for each subject. 3, Activation patterns across all trials (i.e., 72 trial vectors for each operation and 288 trial vectors in total) were computed for each parcel. Trial vectors are weighted activation patterns that consist of multiple voxels (V1 ∼ VN: N = number of voxels in the parcel). The weighted activity value for each voxel equals the raw MR signal intensity which was multiplied by the GLM β of the operation (operation > baseline) for the given voxel, which reduces noise. The term “raw MR signal” refers to the MR signal intensity extracted from time points at which the operation was performed (including 6TR at the onset of the operation, plus an additional 10TR shift). Parcel RSA similarity matrices were then averaged across all subjects. 4, Pairwise correlation between operation trial vectors for each parcel was computed to create 360 parcel RSA matrices (288 trials for a single parcel). 5, The lower half of each parcel RSA matrix was extracted and melted into a single 1 × 41,328 vector. 6, These 360 parcel RSA vectors are concatenated to create a 360 × 41,328 matrix. 7, Spearman’s rank-order correlation is then applied to the concatenated RSA matrices to create a 360 × 360 correlation matrix. 8, The 360 × 360 correlation matrix was converted into a weighted k-nearest neighbor graph (k-NNG) to generate the graph to derive our final representational networks. Weights for the k-NNG were obtained by calculating the Hadamard distances based on the overlap of neighbors (parcels) that represent the relationship between the pairwise similarity of the 360 parcel RSA patterns and their k-nearest neighbors. 9, Bagging-enhanced Leiden community detection was applied on the weighted k-NNG to partition the graph to obtain our final (4) network solution.

### Representational similarity analysis

The Glasser parcellation was converted from the MNI space to native space for each subject, and the multi-voxel activation patterns were extracted for each parcel in the native space. For each trial, the activation patterns were averaged across the operation period (i.e., 2.75  s, 6 TRs) from the onset that was shifted forward 4.6  s (10 TRs) to account for hemodynamic lag. To emphasize the important voxels, the averaged patterns were weighted with the β estimate contrast from the general linear model (GLM) analysis. In the GLM model, four operations, utilizing a canonical hemodynamic response function, and six motion regressors were modeled. Each operation weight was obtained from the t-contrast (e.g., maintain > others) without thresholding. The similarity of the weighted patterns across trials (i.e., 288 trial vectors total, 72 trials/operation) were then computed with Pearson’s correlation (i.e., RSA) to create the operation similarity matrix (288 × 288) for each parcel. Fisher’s z transformation was applied on the correlation coefficient to average the patterns across subjects into a group similarity matrix. We used an averaging method across individual RSA matrices to construct our group-level RSA matrices for each parcel. From these group-level matrices, the bottom of the off-diagonal operation similarity matrix for each parcel, which indicates the similarity and dissimilarity across four operations in the trial level for each parcel, was used for the LCD analysis.

### Bagging-enhanced Leiden community detection for deriving reliable representational networks

The LCD algorithm is a data-driven method that identifies optimal communities within a complex network, such as the network of brain regions we examined. At its core, the LCD algorithm optimizes a metric called modularity (Q), a measure of the strength of the division of a network into communities. It compares the density of connections within communities versus those between them. High modularity implies many connections within communities and only a few between them, which means the divisions are well-defined. The algorithm begins with every node (in our case, Glasser parcels) in its own community. Then, it iteratively evaluates the impact on modularity by moving each node to a different or merging community. The move or merge that maximizes the modularity is performed, and the process is repeated until no further improvements can be made, reaching a locally optimal community structure. This structure, wherein no single move or merge can enhance modularity, represents the optimal number of communities or “network parcels” for that run. However, how nodes are evaluated for potential moves or merges can influence the LCD algorithm’s solution.

To manage this variability and ensure robustness, we performed a bagging approach to identify and verify the most stable and reliable communities (Nikolaidis et al., 2020). Bagging begins by resampling the concatenated 360 × 41,328 parcel vectors matrix with replacement (i.e., bootstrapping) and aggregating across bootstrap samples. This technique reduces variability in the estimation process by averaging across multiple resampled datasets. More specifically, the features for ensemble clustering consist of cluster outputs’ aggregation. LCD is then applied, resulting in cluster solutions for every bootstrap iteration. First, each cluster solution is transformed into individual adjacency matrices that are summed together to create an adjacency matrix (similarity matrix) of the total number of times participants were in the same cluster. Next, mask adjacency matrices are simultaneously created and summed to equate the total number of times participants went into the same LCD iteration together (inclusion matrix). The similarity matrix is then divided by the inclusion matrix to create a mean adjacency matrix (stability matrix) that is then turned into a weighted network. Finally, LCD is applied again to obtain the final cluster solution.

Initially, two separate LCD analyses that used Spearman’s rank-order correlation (SRC) and Euclidean distance for the distance measure for k-NN were conducted. SRC was chosen as the more appropriate distance metric for the k-NN graph because the LCD outputs when SRC was used yielded higher modularity (Q), indicating higher community clustering (SRC BaggedQ = 0.653; Euclidean BaggedQ = 0.447) and stronger parcel allegiance/reproducibility (SRC meanARI = 0.88 ± 0.07; Euclidean meanARI = 0.67 ± 0.13) indicating stable community assignment. Q was also examined across each of the 1,000 bootstrapped iterations. On average, SRC had higher Q per iteration (meanQ = 0.53 ± 0.02) compared to Euclidean (meanQ = 0.21 ± 0.02). In addition, the bootstrapped LCD with SRC iterations revealed a strong preference for a four-network solution, which emerged in 82% of the iterations, while a five-network solution was identified in 18%. Although this variability is an expected outcome of bootstrapping, the overwhelming majority favoring a four-network solution indicates strong evidence for its validity.

### Dimensionality reduction for representational dissimilarity

To investigate the similarities of activation patterns across representational networks, we applied multidimensional scaling (MDS) on the operation dissimilarity matrix to compute the distance across parcels and the four operations in each community (Derndorfer and Baierl, 2013). This visualizes a complex set of relationships between activation patterns that can be visually interpreted to understand the pattern of proximities (i.e., similarities or distances) among the parcels and operations. MDS is a mathematical operation that converts an item-by-item matrix (e.g., 288 × 288 operation dissimilarity matrix) into an item-by-variable matrix (e.g., 288 × 3 matrix). The input to MDS is a square, symmetric one-mode RSA pairwise dissimilarity matrix that contains correlations across the connectivity patterns from continuous time points. The dissimilarity was transformed by subtracting the pairwise correlation coefficient value from one and then dividing the difference by two, resulting in a distance value that ranges from zero to one. Each observation is then assigned coordinates in each of the dimensions. Three dimensions were chosen to maximize the interpretation of the high-dimensional RSA connectivity patterns. Positive and negative values do not correspond to greater or decreased activation within the MDS space, respectively. The orientation of the axes, or dimensions within this space are arbitrary since MDS aims to discern the proximity among various points; closer points denote similar patterns.

To provide converging evidence for our dimensionality reduction technique, we performed PCA on the network RSA operation patterns. This analysis helped us discern the amount of variance each component (or dimension) would explain and further affirmed our decision to adopt three dimensions. The first three components of the PCA captured a significant proportion of the total variance, supporting the notion that the most prominent and distinguishing patterns between operations are embedded in these dimensions.

### Uniqueness of WM operation patterns

To evaluate the accuracy of classifying the MDS operation similarity matrix patterns for each representational network, we performed bootstrapped multiclass classification using a support vector classifier (SVC) from Scikit-learn in Python (Pedregosa et al., 2012). This analysis incorporated an across-operation classification paradigm and a pairwise-operation classification paradigm. Ten K-fold cross-validation across operation trials revealed that the SVC’s optimum performance was achieved when employing a radial basis function kernel, with the γ parameter set to “scale” and the regularization parameter (C) set to 1. Consequently, these parameter settings were employed in all subsequent classification models.

The across-operation classification paradigm evaluated our multiclass models by juxtaposing each operation against the other operations. In each iteration of the classifier, the bootstrapped MDS connectivity patterns were inputted into the classifier. Employing a 1 × 4 pattern design, each WM operation was designated as the “positive” class, while the remaining three were categorized as the “negative” class. This pattern design, known as one versus rest classification, effectively transforms a multiclass problem into a series of binary classification problems.

The pairwise-operation classification paradigm, conversely, contrasts all potential pairwise combinations of WM operations (i.e., Suppress vs Clear, Suppress vs Maintain). The initial step in this process involves the creation of a dataset composed solely of the two operations being scrutinized, incorporating 144 bootstrapped MDS connectivity patterns. Following this, observations with real class = “WM operation 1” are defined as our positive class, and those with real class = “WM operation 2” as our negative class. Importantly, the case of “WM operation 1 versus WM operation 2” is distinct from “WM operation 2 versus WM operation 1,” and both scenarios were duly considered. This process produced 12 unique pairwise-operation classification scores from all pairwise combinations of the four operations.

The relevance of this distinction is amplified when considering an imbalanced category distribution, a situation that can arise from bootstrapping. In supervised classification, the objective function of most classifiers is typically oriented toward minimizing the global prediction error across all classes. When one class, denoted as “WM operation 1,” possesses a substantial numerical advantage in terms of sample size compared to another class, “WM operation 2,” the classifier’s optimization process naturally tends toward minimizing errors for the numerically superior “WM operation 1.” The rationale is that errors in the dominant class have a more pronounced effect on the overall performance metric, such as accuracy, than errors in the minority class. In the context of this study, in “WM operation 1 versus WM operation 2,” if WM operation 1 has more samples, the classifier may lean toward WM operation 1. However, in the reverse scenario, “WM operation 2 versus WM operation 1,” the classifier may still lean toward WM operation 1, now the “negative” category, resulting in a higher false-positive rate for “WM operation 2” (He and Garcia, 2009).

In comparison 1 (“WM operation 1” vs “WM operation 2”), “WM operation 1” is designated as the “positive” class due to its majority status. Simultaneously, “WM operation 2” is labeled as the “negative” class. An inherent bias toward “WM operation 1” will be observed during the classification process, particularly for instances with feature vectors proximate to the decision boundary. These boundaries represent regions with potential overlap or heightened ambiguity between class characteristics. This observed bias stems from the classifier’s learning phase, where the algorithm is fine-tuned to be more circumspect regarding misclassifications of “WM operation 1.” An outcome of this bias is that specific instances, intrinsically belonging to “WM operation 2” yet lying adjacent to the decision boundary, could be inaccurately classified as “WM operation 1.” These errors are categorized as “false positives” for “WM operation 1.”

In comparison 2 (“WM operation 2” vs “WM operation 1”), the class labels are inversed, rendering “WM operation 2” as the “positive” class and “WM operation 1” as the “negative.” Despite this inversion, the inherent data structure and the classifier’s acquired biases during its training phase remain consistent. Thus, even under this alternate labeling paradigm, when instances near the decision boundary are presented, the classifier exhibits a discernible predilection for “WM operation 1.” This observed behavior is attributed to the intrinsic bias induced during the learning phase, which favors the numerically dominant class. A consequent effect of this bias is that true instances of “WM operation 2,” especially those close to the decision boundary, could be mislabeled as “WM operation 1.” Within the framework, these misclassifications would be reported as “false positives” for “WM operation 2.”

By considering both these comparisons as distinct classifiers, we ensure that each category gets a fair opportunity to act as the “positive” category. Consequently, the classifiers’ biases toward the majority category can be averaged out in the final pairwise classification score (Hsu and Lin, 2002). Nonetheless, given the inherent similarities across the comparisons and to streamline the presentation of results, we have decided to average the comparisons. This decision streamlines the interpretation without sacrificing the robustness of our models or the integrity of our results.

We selected the precision and recall (PR) curve and the area under the curve (AUC) for the metrics to evaluate our multiclass classification. Precision evaluated the frequency with which our model accurately classified each WM operation’s connectivity pattern to the total positive classifications generated by our model. Recall, meanwhile, evaluated the proportion of accurately classified positive operation connectivity patterns concerning the total of connectivity patterns that ought to have been classified as positive. A higher recall implies a greater detection rate of correctly positive operation connectivity patterns.

We set the AUC threshold at 0.9. Setting this threshold aims to ensure that the classifier’s performance remains robust despite the potential loss of information from the dimensionality reduction analyses. This is crucial for two reasons. First, it minimizes the risk of misclassification, which could yield misleading conclusions about the uniqueness of how these WM operations are represented in each network. Second, it enhances reliability and increases the potential for generalizability of our results, which is a key focus across our study.

As a final confirmation that the three dimensions were optimal, we tested 1–10 components across MDS and PCA. The trend in operation classification performance replicated across MDS and PCA, which showed that most operations were highly classifiable within the first three components, further supported this decision. Although the performance slightly increased as the number of components increased beyond four, the most robust and consistent patterns were still captured early on, reinforcing the selection of three dimensions as optimal. Consequently, the following will only report on the MDS three-dimension analysis.

### Code accessibility

Custom Python and bash code for all primary statistical analyses are available at https://github.com/jakederosa123/neural_systems_wm_operations

### Results

### Representational network identification

We derived the primary representational network communities underlying the implementation of the WM operations for maintain, replace, suppress, and clear. LCD uncovered four stable networks (Fig. 1E), similarly representative of previously established functional networks (Yeo et al., 2011; Greene et al., 2016; Hearne et al., 2016). The labels for our networks were derived based on their highest correlations with the labels of the Yeo 7 networks (Yeo et al., 2011). Correlations were established between dummy-coded voxels corresponding to each of our four and Yeo 7 networks. The highest correlations for one of our networks spanned the frontoparietal, ventral attention, and dorsal attention from the Yeo 7 and thus were dubbed the frontoparietal control network (FPCN). A list of the Glasser parcels comprising each of our derived networks can be found at https://rpubs.com/jakederosa123/leiden_networks.

Cluster 1—visual network (VN): consists of 76 parcels that are mostly located within the visual cortex (primary, dorsal stream, early, complex, and neighboring) and superior parietal lobe and, for purposes of the present analysis, was labeled as the visual network.

Cluster 2—somatomotor network (SMN): consists of 63 parcels primarily located in the somatosensory cortex, motor cortex, early auditory cortex, paracentral lobular cortex, and mid-cingulate cortex.

Cluster 3—default mode network (DMN): consists of 121 parcels primarily located in the posterior cingulate, anterior cingulate, medial prefrontal cortex, insular cortex, frontal opercular cortex, orbital cortex, polar frontal cortex, inferior cortex, and superior parietal cortex.

Cluster 4—frontoparietal control network (FPCN): consists of 100 parcels primarily located in the dorsolateral prefrontal cortex, inferior frontal cortex, superior parietal cortex, inferior parietal cortex, anterior cingulate cortex, and medial prefrontal cortex.

### Multidimensional representational network patterns

We compared the multi-voxel activation patterns across and within networks for each of the four WM operations to determine how each operation is represented. To begin, we first averaged the RSA operation similarity matrices for the parcels belonging to each network (Fig. 2A). This analysis resulted in four unique network RSA operation similarity matrices (Fig. 2B). These matrices were then concatenated together and reduced to three dimensions via MDS for visualization (Fig. 3A). Across-operation classification revealed that each network’s similarity patterns (across operations) were highly dissociable from each other’s (AUC range 0.94–1.0). We then repeated this MDS analysis on each network’s averaged RSA operation similarity matrix to evaluate the uniqueness of each WM operation’s activation pattern (Fig. 3B–E).

### Figure 2.

Open in a new tab

Representational network profiles. A, Representational network RSA operation similarity matrices correspond to the individual parcel RSA operation similarity matrices for each community (network) averaged together. Numbers and outline color correspond to each network. B, Glasser parcels are colored by network allegiance—(1) visual network, yellow; (2) somatomotor network, cyan; (3) default mode network, pink; (4) frontoparietal control network, purple.

### Figure 3.

Open in a new tab

Multidimensional scaling of the activity patterns for each of the four WM operations between and within network. A, Brains are colored by network (visual network, yellow; somatomotor network, cyan default mode network, pink; frontoparietal control network, purple) and represent the mean, and bars represent the 95% confidence interval across each parcel’s representational patterns for all the operations. B–E, Within network operation MDS profiles, B, visual network, C, somatomotor network, D, frontoparietal network, E, default mode network. Single points represent the mean, and bars represent the 95% confidence interval across the MDS representational patterns between trial vectors across the 288 trials (72 for each operation) for each parcel within a given network and colored by operation (maintain, green; replace, blue; suppress, red; clear, orange). F, Euclidean distances between the pairwise mean MDS pattern across each operation by network. Notes: For a full distribution of the MDS datapoints that comprise each operation by network, see: https://rpubs.com/jakederosa123/Network_Operation_MDS_Full_Distributions

Next, across-operation classification and pairwise-operation classification were computed for each network’s multi-voxel representational patterns for each WM operation (Table 1). Below we review each network’s representational patterns and the across-operation classification and pairwise-operation classification analysis results. Finally, the pairwise distance was calculated between the mean operation representational patterns across the three MDS coordinates (Fig. 3F). Higher distances indicate greater separation between the operations and thus indicate that the network elicits different activity patterns for performing each operation. Conversely, smaller distances indicate that the network does not elicit unique activity patterns to perform each operation, implying that the network does represent those operations in distinct manners.

### Table 1.

Network operation precision and recall area under the curve

| 
VN | 
SMN | 
DMN | 
FPCN | 

Across-operation classification | 
| 
| 
| 
| 

 maintain | 
0.689 | 
0.443 | 
0.710 | 
0.956 | 

 replace | 
0.694 | 
0.508 | 
0.805 | 
0.973 | 

 suppress | 
0.556 | 
0.565 | 
0.900 | 
0.978 | 

 clear | 
0.638 | 
0.808 | 
0.930 | 
0.980 | 

Pairwise-operation classification | 
| 
| 
| 
| 

 maintain vs replace | 
0.698 | 
0.532 | 
0.783 | 
0.968 | 

 maintain vs suppress | 
0.985 | 
0.822 | 
0.948 | 
0.995 | 

 replace vs suppress | 
0.977 | 
0.865 | 
0.985 | 
0.997 | 

 clear vs maintain | 
0.993 | 
0.953 | 
0.975 | 
0.996 | 

 clear vs replace | 
0.992 | 
0.965 | 
0.988 | 
0.999 | 

 clear vs suppress | 
0.610 | 
0.762 | 
0.932 | 
0.982 | 

Open in a new tab

### Visual network (VN)

The VN revealed two different activity patterns across the four operations. Maintain and replace showed similar patterns across trials but varied considerably from suppress and clear, which elicited similar patterns (Fig. 2B network community 1; Fig. 3B). Across-operation classification for each operation was moderate (0.556–0.694). However, pairing the operations (1) maintain and replace, and (2) suppress and clear, the pairwise-operation classification revealed greater similarity within pairs (0.985–0.993) than between them (0.610–0.698). The distance between the operation activity patterns and the pairwise-operation classification AUCs was highly correlated across the operation comparisons (r = 0.966, p = 0.002). See Table 1 for all across-operation and pairwise-operation classification PR curve AUC scores and Figure 3F for all mean MDS distances between the operations by network.

### Somatomotor network (SMN)

The SMN revealed non-distinct activity patterns across the operations, except for to some degree clear (Fig. 2B network community 2; Fig. 3C), and to a lesser degree, suppress. Replace, maintain, and suppress revealed the lowest across-operation classification AUCs (0.443–0.565) compared to clear (0.808). The pairwise-operation classification showed a notably lower AUC for maintain versus replace (0.532). Conversely, it displayed higher AUC values for suppress versus clear (0.762), and particularly strong performance in clear versus replace (0.965) and clear versus maintain (0.953) classifications. The mean pairwise distance between the operation activity patterns and the pairwise-operation classification AUCs was highly correlated across the operation comparisons (r = 0.984, p < 0.001).

### Default mode network (DMN)

The DMN revealed two unique activity patterns for each of the clear and suppress operations, as shown in Figure 2B (network community 3) and Figure 3D (across-operation classification AUCs: 0.9–0.93; and pairwise-operation classification AUCs: 0.932–0.988). The distance between the operation’s activity patterns and the pairwise-operation classification AUCs was also reasonably correlated across the operation comparisons (r = 0.893, p = 0.017).

### Frontoparietal control network (FPCN)

The FPCN revealed dissociable activity patterns for each of the four operations and showed the highest across-operation classification AUCs (0.956–0.98) and pairwise-operation classification AUCs (0.962–0.999) amongst the four networks of interest, as one might expect for a network known for exerting control (Fig. 2B network community 4; Fig. 3E). The correlation between the pairwise-operation distance and the pairwise-operation AUCs was moderate but non-significant (r = 0.761, p = 0.106). The operation AUCs for the FPCN were all >0.95. Despite the operation distances being predominantly larger on average than those of other networks, the low variability for each of the operations was the primary factor contributing to the performance of the classifier scores, rather than the distances, which varied to some extent across operations in the FPCN.

### Discussion

The present study revealed that four major brain networks contribute to removing information from WM: a VN, SMN, DMN, and FPCN. First, we discuss the implications of the representational patterns for each network with regard to control over the contents of WM, followed by the broader implications of our results.

### Visual network (VN)

The activity patterns within the VN differentiated the maintain and replace operations, which require information to be held in WM, from the suppress and clear operations, which require the currently held information to be removed entirely. These findings are highly consistent with the univariate results from Banich et al. (2015) that showed evidence of activity in the ventral visual processing stream for the maintain and replace operations but no significant activity above a fixation baseline for the suppress and clear operations. The current results expand upon those findings to demonstrate that these regions represent the maintain and replace operations differently from the suppress and clear operations.

### Somatomotor network (SMN)

The activity pattern within the SMN represents clearing the mind of thoughts in a distinct manner from the other operations. Banich et al. (2015) observed a unique univariate brain activation pattern for clear, which they speculated might occur because clearing the mind completely of all thoughts results in a brief attentional shift away from external sensory processing to a focus on one’s internal states. Our findings align with this idea because this network, focused on outward perception and action (Uddin et al., 2019), distinguishes clear from other operations.

### Default mode network (DMN)

Like the VN, the DMN distinguishes operations that involve holding information in WM, maintain and replace, from those which require information to be removed entirely, suppress and clear. This distinction is consistent with findings that activity of the DMN is observed more often when cognitive processes are more inwardly directed as compared to oriented toward external stimuli (Andrews-Hanna et al., 2014; Raichle, 2015; Kucyi et al., 2016). Unlike the VN, however, there is also a distinction between the suppress and clear operations [consistent with Banich et al. (2015) and Kim et al. (2020)]. This pattern, which is also distinct from that observed for the SMN, suggests that the DMN may have an integral role in distinguishing between different ways of removing information so that none remains in WM, and separating them from operations in which information remains in WM.

### Frontoparietal control network (FPCN)

The FPCN is the only network that showed four distinct representational patterns for each operation, suggesting this network may be important for all aspects of manipulating and removing information from WM. This notion is consistent with previous work demonstrating the FPCN’s involvement in WM tasks (Finc et al., 2020). Our findings are consistent with the role of the FPCN in various executive control operations (Scolari et al., 2015; Marek and Dosenbach, 2018), and with the idea that, as shown in the current study, that the FPCN uses representational codes to flexibly distinguish between each operation much as this network has been shown previously to distinguish between different types of information in WM (Nee and Brown, 2012).

### Broader implications

The present work importantly reveals that there is not one particular brain network involved in control over these WM removal operations, but rather that there are four distinct representational networks that each seem to, in parallel, represent these operations via a unique configuration that is distinguishable from all the other networks. Such an organization suggests that the brain can simultaneously distinguish these operations in multiple manners. The pattern of results for the VN corroborates some of our prior work using mass-univariate analyses of fMRI data (Banich et al., 2015), in which we showed that aspects of regional brain activation distinguish between WM operations in which information is retained in WM as compared to not. In addition, the current study provides a different perspective from the multivariate pattern analyses performed by Kim et al. (2020) which were more focused on the consequences of these operations rather than how they are represented. More specifically, multi-voxel pattern analysis (MVPA) in Kim et al. (2020) was used (1) to provide verification that specific information was removed from WM, (2) to identify the consequences of each operation on the representation of the information being removed, and (3) to assess the impact of the operation on the encoding of new information in WM. The current findings build off these prior studies by showing that brain regions do not work in isolation to remove information from WM. Instead, there are distinct networks that each represents these operations in specific configurations but in ways distinct from other networks.

One aspect of the current results to consider, given that representations of these operations seem to cohere within specific networks, is the degree to which such representational similarity is supported by connectivity and communication within the brain regions that constitute a given network. While resolving this issue is outside of the scope of the current study, such coherence likely occurs via connectivity as recent research has found significant overlap between brain regions that represent information in similar manners (i.e., representational networks) and brain regions that form networks based on their pattern of connectivity (Pillet et al., 2019).

### Limitations and future directions

While the current results identified four representational networks, revealing insights into how each distinguishes (or not) between the WM operations investigated, this study has its limitations. This study does not provide a more mechanistic understanding of how the representational patterns within each network implement the operations. For example, our results cannot determine the degree to which each of these representational patterns within a network is causally related to the execution of each operation. One possibility is that the operation is actually implemented based on the combined representational pattern across each of the four networks (e.g., maintain = representational pattern for maintain for the SMN + VN + DMN + FPCN). An alternative possibility is that the operations are implemented primarily by the FPCN, as it is the only network that distinguishes between the four operations, and the representational patterns observed in the other networks are a by-product of top-down control exerted by that network.

One way to address this issue is to determine the degree to which the representational pattern of a given network or combination of networks can predict the degree to which the representation of given item is effectively removed from WM, as potentially indexed by classifier fits or RSA of specific items, as identified in Kim et al. (2020). This is an issue we are currently pursuing.

An additional subsequent research direction is to examine these activation patterns from the perspective of them representing underlying gradients across the cortex (Margulies et al., 2016; Cross et al., 2021) rather than as networks with discrete boundaries as done in the present study. This more continuous approach has the advantage of allowing the relationships between the gradients to be determined, providing the possibility of identifying brain regions that may sit at the top of a hierarchy, in our case with regards to control operations for the removal of information from WM.

Another future direction is to consider whether the neural representations of these WM operations can be tied to individual differences in behavioral measures of removing information from WM and/or self-reports of thought control difficulties. It’s possible that individuals whose representation networks do not clearly distinguish between these operations (or who show less distinct separation of configurations across networks) may face challenges in removing information from WM. Considering the scope of our study design, which did not include collecting behavioral data during the scanning process (Kim et al., 2020), the question will be important to answer.

Finally, it is worth noting that our analytic approach is a novel one that allows researchers to identify, in a data-driven manner, the number of representational networks that each represents information in a unique manner. This approach is not only pivotal for enhancing our understanding of the unique neural configurations underlying these WM removal operations, but it could bring a new perspective to other central investigations in cognitive neuroscience, ranging from the cognitive operations that act on perceptual information to those that act on linguistic material.

### Conclusion

Our study represents a significant advancement in understanding control operations that act on information in WM, leveraging various computational approaches in a novel manner. This network-centric approach, grounded in RSA, identified four brain networks, each of which shows a unique representational configuration when someone maintains, replaces, suppresses, or entirely clears information from the mind. Notably, only the FPCN representations clearly distinguish between all four operations. Additionally, the DMN shows dissimilar patterns for suppress and clear, suggesting that these two methods of emptying WM are distinct. These results provide for the possibility that these operations are represented in a multi-faceted manner and in parallel across distinct brain networks. Moreover, the analytic approach used here to identify networks to provide insights into how these control operations act in WM may fruitfully be employed to better understand the neural instantiation of other control operations.

### References

Ahmed L, De Fockert J (2011) How is the selective attention of low and high working memory capacity individuals affected by working memory load? In PsycEXTRA Dataset. 10.1037/e676392012-238 [DOI]

Andrews-Hanna JR, Smallwood J, Spreng RN (2014) The default network and self-generated thought: component processes, dynamic control, and clinical relevance. Ann N Y Acad Sci
1316:29–52. 10.1111/nyas.12360
[DOI] [PMC free article] [PubMed] [Google Scholar]

Banich MT, Mackiewicz Seghete KL, Depue BE, Burgess GC (2015) Multiple modes of clearing one’s mind of current thoughts: overlapping and distinct neural systems. Neuropsychologia
69:105–117. 10.1016/j.neuropsychologia.2015.01.039
[DOI] [PMC free article] [PubMed] [Google Scholar]

Chen AA, et al. (2022) Harmonizing functional connectivity reduces scanner effects in community detection. NeuroImage
256:119198. 10.1016/j.neuroimage.2022.119198
[DOI] [PMC free article] [PubMed] [Google Scholar]

Cross N, Paquola C, Pomares FB, Perrault AA, Jegou A, Nguyen A, Aydin U, Bernhardt BC, Grova C, Dang-Vu TT (2021) Cortical gradients of functional connectivity are robust to state-dependent changes following sleep deprivation. NeuroImage
226:117547. 10.1016/j.neuroimage.2020.117547
[DOI] [PubMed] [Google Scholar]

Dale AM (1999) Optimal experimental design for event-related fMRI. Hum Brain Mapp
8:109–114. 10.1002/(SICI)1097-0193(1999)8:2/3<109::AID-HBM7>3.0.CO;2-W
[DOI] [PMC free article] [PubMed] [Google Scholar]

Derndorfer E, Baierl A (2013) Multidimensional scaling (MDS). Math Stat Methods Food Sci Technol
4:175–186. 10.1002/9781118434635 [DOI] [Google Scholar]

Finc K, Bonna K, He X, Lydon-Staley DM, Kühn S, Duch W, Bassett DS (2020) Author correction: dynamic reconfiguration of functional brain networks during working memory training. Nat Commun
11:3891. 10.1038/s41467-020-17747-8
[DOI] [PMC free article] [PubMed] [Google Scholar]

Glasser MF, et al. (2016) A multi-modal parcellation of human cerebral cortex. Nature
536:171–178. 10.1038/nature18933
[DOI] [PMC free article] [PubMed] [Google Scholar]

Greene DJ, Lessov-Schlaggar CN, Schlaggar BL (2016) Development of the brain's functional network architecture. In: Neurobiology of language, pp 399–406. Cambridge, Massachusetts: Academic Press. 10.1016/b978-0-12-407794-2.00033-x [DOI] [Google Scholar]

Hänisch B, Hansen JY, Bernhardt BC, Eickhoff SB, Dukart J, Mišić B, Valk SL (2023) Cerebral chemoarchitecture shares organizational traits with brain structure and function. ELife
12. 10.7554/elife.83843 [DOI] [PMC free article] [PubMed] [Google Scholar]

He H, Garcia EA (2009) Learning from imbalanced data. IEEE Trans Knowl Data Eng
21:1263–1284. 10.1109/TKDE.2008.239 [DOI] [Google Scholar]

Hearne LJ, Mattingley JB, Cocchi L (2016) Functional brain networks related to individual differences in human intelligence at rest. Sci Rep
6:1–8.
[DOI] [PMC free article] [PubMed] [Google Scholar]

Hsu C-W, Lin C-J (2002) A comparison of methods for multiclass support vector machines. IEEE Trans Neural Netw
13:415–425. 10.1109/72.991427
[DOI] [PubMed] [Google Scholar]

Kim H, Smolker HR, Smith LL, Banich MT, Lewis-Peacock JA (2020) Changes to information in working memory depend on distinct removal operations. Nat Commun
11:6239. 10.1038/s41467-020-20085-4
[DOI] [PMC free article] [PubMed] [Google Scholar]

Kriegeskorte N, Mur M, Bandettini P (2008) Representational similarity analysis—connecting the branches of systems neuroscience. Front Syst Neurosci
2:4. 10.3389/neuro.01.016.2008
[DOI] [PMC free article] [PubMed] [Google Scholar]

Kucyi A, Esterman M, Riley CS, Valera EM (2016) Spontaneous default network activity reflects behavioral variability independent of mind-wandering. Proc Natl Acad Sci U S A
113:13899–13904. 10.1073/pnas.1611743113
[DOI] [PMC free article] [PubMed] [Google Scholar]

Lewis-Peacock JA, Kessler Y, Oberauer K (2018) The removal of information from working memory. Ann N Y Acad Sci
1424:33–44. 10.1111/nyas.13714
[DOI] [PubMed] [Google Scholar]

Marek S, Dosenbach NUF (2018) The frontoparietal network: function, electrophysiology, and importance of individual precision mapping. Dialogues Clin Neurosci
20:133–140. 10.31887/DCNS.2018.20.2/smarek
[DOI] [PMC free article] [PubMed] [Google Scholar]

Margulies DS, et al. (2016) Situating the default-mode network along a principal gradient of macroscale cortical organization. Proc Natl Acad Sci U S A
113:12574–12579. 10.1073/pnas.1608282113
[DOI] [PMC free article] [PubMed] [Google Scholar]

Nee DE, Brown JW (2012) Rostral-caudal gradients of abstraction revealed by multi-variate pattern analysis of working memory. NeuroImage
63:1285–1294. 10.1016/j.neuroimage.2012.08.034
[DOI] [PMC free article] [PubMed] [Google Scholar]

Nikolaidis A, et al. (2021) The coronavirus health and impact survey (CRISIS) reveals reproducible correlates of pandemic-related mood states across the Atlantic. Sci Rep
11:8139. 10.1038/s41598-021-87270-3
[DOI] [PMC free article] [PubMed] [Google Scholar]

Nikolaidis A, Solon Heinsfeld A, Xu T, Bellec P, Vogelstein J, Milham M (2020) Bagging improves reproducibility of functional parcellation of the human brain. NeuroImage
214:116678. 10.1016/j.neuroimage.2020.116678
[DOI] [PMC free article] [PubMed] [Google Scholar]

Pedregosa F, et al. (2012) Scikit-learn: machine learning in Python. In arXiv [cs.LG]. arXiv. http://arxiv.org/abs/1201.0490

Pillet I, Op de Beeck H, Lee Masson H (2019) A comparison of functional networks derived from representational similarity, functional connectivity, and univariate analyses. Front Neurosci
13:1348. 10.3389/fnins.2019.01348
[DOI] [PMC free article] [PubMed] [Google Scholar]

Raichle ME (2015) The brain’s default mode network. 10.1146/annurev-neuro-071013-014030 [DOI]

Scolari M, Seidl-Rathkopf KN, Kastner S (2015) Functions of the human frontoparietal attention network: evidence from neuroimaging. Curr Opin Behav Sci
1:32–39. 10.1016/j.cobeha.2014.08.003
[DOI] [PMC free article] [PubMed] [Google Scholar]

Tamber-Rosenau BJ, Esterman M, Chiu Y-C, Yantis S (2011) Cortical mechanisms of cognitive control for shifting attention in vision and working memory. J Cogn Neurosci
23:2905–2919. 10.1162/jocn.2011.21608
[DOI] [PMC free article] [PubMed] [Google Scholar]

Traag VA, Waltman L, van Eck NJ (2019) From Louvain to Leiden: guaranteeing well-connected communities. Sci Rep
9:5233. 10.1038/s41598-019-41695-z
[DOI] [PMC free article] [PubMed] [Google Scholar]

Uddin LQ, Yeo BTT, Spreng RN (2019) Towards a universal taxonomy of macro-scale functional human brain networks. Brain Topogr
32:926–942. 10.1007/s10548-019-00744-6
[DOI] [PMC free article] [PubMed] [Google Scholar]

Yeo BTT, et al. (2011) The organization of the human cerebral cortex estimated by intrinsic functional connectivity. J Neurophysiol
106:1125–1165. 10.1152/jn.00338.2011
[DOI] [PMC free article] [PubMed] [Google Scholar]

### ACTIONS

View on publisher site

PDF (1.2 MB)

Cite

Collections

Permalink

### PERMALINK

Copy

### RESOURCES

### 

Similar articles

### 

Cited by other articles

### 

Links to NCBI Databases

### Cite

Copy

Download .nbib
.nbib

Format:

AMA

APA

MLA

NLM

### Add to Collections

Create a new collection

Add to an existing collection

Name your collection
*

Choose a collection

Unable to load your collection due to an error

Please try again

Add

Cancel

Back to Top
