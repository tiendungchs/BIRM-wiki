---
title: "The specious art of single-cell genomics"
source: "https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1011288"
author:
  - "[[Tara Chari]]"
  - "[[Lior Pachter]]"
published:
created: 2026-09-13
description: "Dimensionality reduction is standard practice for filtering noise and identifying relevant features in large-scale data analyses. In biology, single-cell genomics studies typically begin with reduction to 2 or 3 dimensions to produce “all-in-one” visuals of the data that are amenable to the human eye, and these are subsequently used for qualitative and quantitative exploratory analysis. However, there is little theoretical support for this practice, and we show that extreme dimension reduction, from hundreds or thousands of dimensions to 2, inevitably induces significant distortion of high-dimensional datasets. We therefore examine the practical implications of low-dimensional embedding of single-cell data and find that extensive distortions and inconsistent practices make such embeddings counter-productive for exploratory, biological analyses. In lieu of this, we discuss alternative approaches for conducting targeted embedding and feature exploration to enable hypothesis-driven biological discovery."
tags:
  - "clippings"
---
## Correction

4 Nov 2025: The PLOS Computational Biology Staff (2025) Correction: The specious art of single-cell genomics. PLOS Computational Biology 21(11): e1013655. [https://doi.org/10.1371/journal.pcbi.1013655](https://doi.org/10.1371/journal.pcbi.1013655) [View correction](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1013655)

## Abstract

Dimensionality reduction is standard practice for filtering noise and identifying relevant features in large-scale data analyses. In biology, single-cell genomics studies typically begin with reduction to 2 or 3 dimensions to produce “all-in-one” visuals of the data that are amenable to the human eye, and these are subsequently used for qualitative and quantitative exploratory analysis. However, there is little theoretical support for this practice, and we show that extreme dimension reduction, from hundreds or thousands of dimensions to 2, inevitably induces significant distortion of high-dimensional datasets. We therefore examine the practical implications of low-dimensional embedding of single-cell data and find that extensive distortions and inconsistent practices make such embeddings counter-productive for exploratory, biological analyses. In lieu of this, we discuss alternative approaches for conducting targeted embedding and feature exploration to enable hypothesis-driven biological discovery.

## Figures

![Fig 8](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g008) ![Fig 1](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g001) ![Fig 2](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g002) ![Fig 3](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g003) ![Fig 4](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g004) ![Fig 5](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g005) ![Fig 6](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g006) ![Fig 7](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g007) ![Fig 8](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g008) ![Fig 1](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g001) ![Fig 2](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g002) ![Fig 3](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g003)

**Citation:** Chari T, Pachter L (2023) The specious art of single-cell genomics. PLoS Comput Biol 19(8): e1011288. https://doi.org/10.1371/journal.pcbi.1011288

**Editor:** Jason A. Papin, University of Virginia, UNITED STATES

**Published:** August 17, 2023

**Copyright:** © 2023 Chari, Pachter. This is an open access article distributed under the terms of the [Creative Commons Attribution License](http://creativecommons.org/licenses/by/4.0/), which permits unrestricted use, distribution, and reproduction in any medium, provided the original author and source are credited.

**Data Availability:** Download links for the original data used to generate the figures and results in the paper are listed in Table A in [S1 Text](#pcbi.1011288.s001). Processed and normalized versions of the count matrices are available on CaltechData, with links provided in Table B in [S1 Text](#pcbi.1011288.s001). All analysis code used to generate the figures and results in the paper is available at [https://github.com/pachterlab/CP\_2023](https://github.com/pachterlab/CP_2023) and deposited at Zenodo (DOI [https://doi.org/10.5281/zenodo.8087950](https://doi.org/10.5281/zenodo.8087950)). Code is provided in Colab notebooks which can be run for free on the Google cloud.

**Funding:** L.P. received the National Institutes of Health ([nih.gov](http://nih.gov/)) award U19MH114830, administered by the National Institute of Mental Health ([nimh.nih.gov](http://nimh.nih.gov/)). T.C. and L.P. were partially funded by this award. The funders had no role in study design, data collection and analysis, decision to publish, or preparation of the manuscript.

**Competing interests:** The authors have declared that no competing interests exist.

**Abbreviations:** EDA, exploratory data analysis; HPF, hierarchical Poisson factorization; kNN, k-nearest neighbor; mESC, mouse embryonic stem cell; NSC, neural stem cell; PCA, principal component analysis; VMH, ventromedial hypothalamus

## Introduction

The high-dimensionality of “big data” genomics datasets has led to the ubiquitous application of dimensionality reduction to filter noise, enable tractable computation, and to facilitate exploratory data analysis (EDA). Ostensibly, the goal of this reduction is to preserve and extract local and/or global structures from the data for biological inference \[–\]. Trial and error application of common techniques has resulted in a currently popular workflow combining initial dimensionality reduction to a few dozen dimensions, often using principal component analysis (PCA), with further nonlinear reduction to 2 dimensions using t-SNE \[\] or UMAP \[,,,\]. For single-cell genomics in particular, these embeddings are used extensively in qualitative and quantitative EDA tasks that fall into 4 main categories of applications ([Fig 1](#pcbi-1011288-g001), “Application”):

- Modality-mixing, integration, and reference mapping:

Embeddings are used to visually assess the extent of integration, mixing, or similarities between cells from different batches \[–\] and to compare methods of integration/batch-correction \[\]. For query dataset(s) mapped onto reference datasets/embeddings, visuals likewise provide an assessment of merged data similarities or differences \[,\].

- Cluster validation and relationships:

Visual applications range from assessing the existence of and relationships between predefined clusters, to inferring properties of the clusters (e.g., spread or heterogeneity) \[,,\], and to generating the clusters themselves from the 2D space (e.g., to define cell types or to detect doublets) \[,,\].

- Density-based visuals and marker analysis:

Embeddings are used to justify or measure changes in cell populations between different conditions, by comparing contour locations and sizes in the density diagrams, as well as changes in intensity or spread of gene expression \[–\].

- Trajectory inference and continuous relationships:

Embedding applications range from implying or inferring local, continuous relationships between cells and assigning pseudotime coordinates \[–\], to using the 2D coordinates for explicit calculations of magnitude and direction of developmental progression \[,,\].

[![thumbnail](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g001)](https://journals.plos.org/ploscompbiol/article/figure/image?size=medium&id=10.1371/journal.pcbi.1011288.g001 "Click for larger image")

Download:
- [
	PNG
	larger image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=large&id=10.1371/journal.pcbi.1011288.g001)
- [
	TIFF
	original image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=original&id=10.1371/journal.pcbi.1011288.g001)

Fig 1. Necessary properties for embedding applications.

Application rows denote biological tasks, and columns denote which properties are necessary, i.e., key geometric properties whose preservation or representation is assumed in the task.

[https://doi.org/10.1371/journal.pcbi.1011288.g001](https://doi.org/10.1371/journal.pcbi.1011288.g001)

Inherent in these applications are assumptions of preservation of local and global cell properties, as well as distances, delineated in [Fig 1](#pcbi-1011288-g001). For each application, we demarcate which of these are the “necessary” or key geometric properties that each task inherently assumes to be represented (and preserved). Based on previous works \[,,,\] and the objective functions of UMAP and t-SNE \[,\], “local” is defined as nearest neighbor relationships, “global” as neighbor relationships and properties of groups of cells (e.g., cell types), and “distance” as Euclidean distance (*L* <sub>2</sub> norm) or Manhattan distance (*L* <sub>1</sub> norm) between points. Note that preservation of distance implies preservation of local and global properties. We utilize the *L* <sub>2</sub> norm as it is the default metric of UMAP/t-SNE. We also present results with the *L* <sub>1</sub> norm (see [S1 Text](#pcbi.1011288.s001)), as *L* <sub>1</sub> is more suitable for measuring distance in high dimensions, particularly in comparison to other *L* <sub><em>k</em></sub> norms \[,\], and is commonly applied to transcriptomic data \[–\], with comparable performance to the probabilistic Jensen–Shannon divergence in single-cell distance calculations \[\].

Yet, despite the goals of these methods \[,,\] to preserve local and/or global structure, there is little theory or empirical analysis to support these claims. For example, while the popular t-SNE and UMAP methods claim faithful representation of local and/or global structure in low dimensions \[,,\], there is evidence they fail in this regard \[,\], and theorems providing guarantees on the embeddings rely on numerous assumptions unlikely to hold in practice and ignore the preprocessing by PCA prior to nonlinear reduction \[\].

Here, we assess dimensionality reduction for single-cell gene expression, first investigating the preservation of the necessary properties comprising the columns of [Fig 1](#pcbi-1011288-g001), then assessing the impact of these embeddings across the applications comprising the rows of [Fig 1](#pcbi-1011288-g001).

## Preservation of local and global structure in 2D embeddings

We begin with the columns of [Fig 1](#pcbi-1011288-g001), and assess the preservation of these properties by 2D embedding, as compared to the ambient space or higher-dimensional PCA space to which the ambient space is initially reduced prior to reduction to 2D (see Methods in [S1 Text](#pcbi.1011288.s001)).

“Ambient” space refers to the gene count matrix after highly variable gene selection and log-normalization of the counts (see Methods in [S1 Text](#pcbi.1011288.s001)). We denote “PCA-preprocessing” as the higher dimensional reduction of the ambient space by PCA, followed by a (nonlinear) reduction to 2D (e.g., “PCA-50D→UMAP”) which mimics standard practice. Additionally, cell annotations or labels (such as cell type or condition) used in the following analyses were taken from the original studies.

### Local preservation

Given the focus on preserving local nearest neighbors in the objectives of the UMAP and t-SNE methods, we first measured the recapitulation of nearest neighbors in 2D embeddings, as compared to the neighbors defined in ambient space. We used Euclidean (*L* <sub>2</sub>) distance, the default for these nonlinear reduction methods, to define each cell’s 30 nearest neighbors and measured Jaccard distance (dissimilarity) between the neighbors in embedding and ambient space (where 1.0 denotes no overlap). Several in vivo datasets were reduced to 2D, with PCA-preprocessing, including 10× Genomics and SMART-Seq assayed mouse ventromedial hypothalamus (VMH) neuron datasets \[\], an ex utero cultured mouse embryo dataset (at the E8.5 stage) and an ex and in utero mouse embryo dataset (at the E10.5 stage) from \[\], and a mouse primary motor cortex (MOp) dataset \[\]. We additionally reduced cell culture-derived datasets, with and without external perturbations, including mouse embryonic stem cells (mESCs) treated in DMSO from \[\] and multiplexed mouse neural stem cells (NSCs) in 96 drug combination conditions (labeled “96-plex”) \[\] (see Table A in [S1 Text](#pcbi.1011288.s001)).

The 2D t-SNE/UMAP embeddings (e.g., “PCA-50D→UMAP” in [Fig 2A](#pcbi-1011288-g002)) displayed large Jaccard distances with respect to the neighbors in ambient dimension, with an average consistently above 0.7 (70%). Generally, dissimilarity increased with the size of the dataset ([Fig 2A](#pcbi-1011288-g002), Figs A and Ba in [S1 Text](#pcbi.1011288.s001)). When the number of neighbors (k), considered in the dissimiliarity calculation, was varied between 5 to 100, smaller dataset embeddings displayed slightly improved dissimilarity scores with larger k (Figs Bb and Bc in [S1 Text](#pcbi.1011288.s001)). Interestingly, the embeddings of the more homogeneous mESCs dataset displayed relatively higher dissimilarity despite the small number of cells (Figs Bb and Bc in [S1 Text](#pcbi.1011288.s001)). Poor neighborhood overlap was additionally retained, and often worsened, without PCA-preprocessing (i.e., direct reduction to 2D from ambient space). In some cases, the dissimilarity of neighbors was worse for 2D PCA (“PCA-2D”) as compared to t-SNE or UMAP reduction without PCA-preprocessing, consistent with other findings on the poor preservation of local neighborhoods by both PCA and the nonlinear reduction methods \[,\] (Figs A and Bc in [S1 Text](#pcbi.1011288.s001)). Similarly poor neighbor retention from the ambient space was observed in the higher dimensional PCA spaces as well (“PCA-50D” [Fig 2Ai](#pcbi-1011288-g002), Figs A and B in [S1 Text](#pcbi.1011288.s001)) \[\], particularly for larger datasets. Even between the PCA-preprocessed 2D embeddings and their corresponding PCA space, Jaccard distances were consistently above 0.8 on average, regardless of the dimension of the initial PCA reduction ([Fig 2Aii](#pcbi-1011288-g002), right panels Fig A in [S1 Text](#pcbi.1011288.s001)).

[![thumbnail](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g002)](https://journals.plos.org/ploscompbiol/article/figure/image?size=medium&id=10.1371/journal.pcbi.1011288.g002 "Click for larger image")

Download:
- [
	PNG
	larger image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=large&id=10.1371/journal.pcbi.1011288.g002)
- [
	TIFF
	original image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=original&id=10.1371/journal.pcbi.1011288.g002)

Fig 2. Distortion of necessary properties in embeddings.

(**a**) (i) Distribution of Jaccard distance of cell neighbors in PCA-preprocessed 2D embeddings and the relevant PCA space, as compared to ambient space. (ii) Distribution of Jaccard distance of cell neighbors in PCA-preprocessed 2D embeddings, as compared to the higher dimensional PCA space. (**b**) (i) Boxplot of correlations of cell type neighbor rankings to ambient space for the PCA-preprocessed 2D embeddings and the relevant PCA space. (ii) Boxplot of correlations of cell type neighbor rankings to the relevant higher dimensional PCA space for the PCA-preprocessed 2D embeddings. Embeddings generated *n* = 3 times. (**c**) Selection of equidistant groups with “near” or “far” distances in ambient space. UMAP embedding of the data in gray circles, with orange circles denoting all cells within the previously determined equidistant groups.

[https://doi.org/10.1371/journal.pcbi.1011288.g002](https://doi.org/10.1371/journal.pcbi.1011288.g002)

### Global preservation

Turning to global relationships, we measured the preservation of the rankings of neighbors of cell “types” rather than individual cells. Cell “types” denote either author-provided cell type ([Fig 2Bii](#pcbi-1011288-g002)) or cell condition annotations. Rankings were constructed from average pairwise distances between the cells of the different types, across replicate 2D embeddings (see Methods in [S1 Text](#pcbi.1011288.s001)). For the same datasets as above, and a multiplexed dataset of human monocytes treated with 40 drugs \[\], correlation of cell type neighbor rankings to that of the ambient space were low (≤ 0.4) in PCA-preprocessed 2D embeddings, and at least 33% lower than those of the higher dimensional PCA spaces, with warped or even reversed correlations in comparison to the ambient ([Fig 2Bi](#pcbi-1011288-g002)) or relevant PCA space ([Fig 2Bii](#pcbi-1011288-g002), Fig Ca in [S1 Text](#pcbi.1011288.s001)). These distortions were not specific to the distance measure used; we observed similar results when using the *L* <sub>1</sub> norm to determine cell type neighbors (Fig Cb in [S1 Text](#pcbi.1011288.s001)). This is consistent with observations made in other studies \[,\]. In general, correlation decreased over each step in the reduction process though there was not a clear trend related to other dataset properties (Figs Da and Ea in [S1 Text](#pcbi.1011288.s001)). For analyses of recapitulation of cluster properties such as inferred heterogeneity or spread, see “Clustering validation and relationships” and “Embedding properties are arbitrary” below.

### Distance preservation

To examine distance preservation, we extracted groups of cells with quantitatively distinct relationships in the ambient space of the Seurat-integrated \[\] ex and in utero mouse embryo dataset (at the E10.5 stage) \[\], specifically equidistant groups of cells, where the distances between cells were all either equally small (“near”) or large (“far”) ([Fig 2C](#pcbi-1011288-g002)) (see Methods in [S1 Text](#pcbi.1011288.s001)). This revealed upwards of 2.5 million such groups, with 3 to 8 cells in each (Figs Fa and Fe in [S1 Text](#pcbi.1011288.s001)). However, once embedded into 2 dimensions, these quantitatively distinct groups of cells (orange dots on UMAPs, [Fig 2C](#pcbi-1011288-g002)) displayed the same dispersion patterns, violating distance preservation, and rendering these distinct, transcriptomic relationships indistinguishable.

This is not surprising, given previous theoretical work on the limits of distance preservation in low dimensions, particularly for equidistant points \[–\]. The Johnson–Lindenstrauss lemma on the optimality of linear embedding \[–\] shows that preservation of pairwise distances with a margin of error of at most 20% for a modestly sized dataset of 10,000 cells would require at least 1,842 dimensions \[\]. Distortion is inevitable: given *n* points embedded in 2 dimensions, the distortion of the ratio of their maximum distance, *D*, to minimum distance, *d* (“max/min ratio”), grows as \[\] (see Note in [S1 Text](#pcbi.1011288.s001)).

In practice, measuring these “max/min ratios” in 2D embeddings, for the ex and in utero data (E10.5) as well as the 10× VMH neurons, revealed 4- to 200-fold increases in these ratios whether compared to the relevant PCA space or ambient space (with or without PCA-preprocessing). This was the case in groups of equidistant cells as well as groups of nearest neighbors (Figs F and G in [S1 Text](#pcbi.1011288.s001)) and can result in trends such as displayed in [Fig 2C](#pcbi-1011288-g002), with cells shot out across the embedding. For both datasets, we empirically verified the growth of this distortion with the number of cells considered in each equidistant group, i.e., as more cells are considered in 2D, the distortion grows (Fig H in [S1 Text](#pcbi.1011288.s001)). Higher dimensional PCA spaces largely maintained similar max/min ratios to the ambient space (Figs G and H in [S1 Text](#pcbi.1011288.s001)). However, we note that in low dimensions PCA embedding of equidistant points is tantamount to applying a random projection, similarly resulting in projected points displaying numerous mirages of structure or outliers (Fig I in [S1 Text](#pcbi.1011288.s001)).

## Distortion of trends in applications

Given the distortions of the necessary properties in [Fig 1](#pcbi-1011288-g001), we then investigated their impact on each row or application, i.e., how in practice such embeddings affect the inferences and implications made in each application.

### Modality-mixing, integration, and reference mapping

Malleability of “structure” under low-dimensional embedding is particularly apparent in the mixing properties of integrated, mapped, or batch-corrected datasets, where an integration procedure is accompanied by an embedding of the melded datasets ([Fig 3](#pcbi-1011288-g003), Fig J in [S1 Text](#pcbi.1011288.s001)) \[,\]. This relies on preserving both local relationships (which cells are mixed) and global patterns (overall trends of mixing or non-mixing between datasets) ([Fig 1](#pcbi-1011288-g001)). For the integrated ex and in utero dataset (E10.5), we calculated the fraction of each cell’s nearest neighbors with the same label as the cell, to compare whether embeddings accurately reflect the extent of mixing of ex and in utero cells by integration ([Fig 3A](#pcbi-1011288-g003)) (see Methods in [S1 Text](#pcbi.1011288.s001)).

[![thumbnail](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g003)](https://journals.plos.org/ploscompbiol/article/figure/image?size=medium&id=10.1371/journal.pcbi.1011288.g003 "Click for larger image")

Download:
- [
	PNG
	larger image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=large&id=10.1371/journal.pcbi.1011288.g003)
- [
	TIFF
	original image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=original&id=10.1371/journal.pcbi.1011288.g003)

Fig 3. Distortion of mixing patterns.

(**a**) Left plot shows “Log-normalized” ambient (blue) and 2D embedding (orange) distributions of mixing (fraction of cell neighbors in the same condition), where 1.0 is no mixing. Corresponding UMAP shown next to it. Right plot shows “Variance-Stabilized and Scaled” ambient (blue) and 2D embedding (orange) distributions of mixing (fraction of cell neighbors in the same condition). Corresponding UMAP shown next to it. (**b**) Left plot shows “MNN Integrated” ambient (blue) and 2D embedding (orange) distributions of mixing (fraction of cell neighbors in the same condition) for CEL-Seq cells. Corresponding UMAP shown next to it. Right plot shows “Scanorama Integrated” ambient (blue) and 2D embedding (orange) distributions of mixing (fraction of cell neighbors in the same condition) for CEL-Seq cells. Corresponding UMAP shown next to it.

[https://doi.org/10.1371/journal.pcbi.1011288.g003](https://doi.org/10.1371/journal.pcbi.1011288.g003)

The “Log-Normalized” integrated, ambient data displayed a largely unimodal, well-mixed distribution of cells between conditions, while the distribution generated from embedding into 2 dimensions was shifted towards unmixed (left side, [Fig 3A](#pcbi-1011288-g003)). The “Variance-Stabilized and Scaled” integrated, ambient data (a separate scaling procedure performed after integration) displayed the opposite trend. The ambient data presented a bimodal distribution with completely unmixed cell populations, while the final embedding displayed a unimodal distribution of well-mixed cells from both conditions (right side, [Fig 3A](#pcbi-1011288-g003)). These additions or losses of mixing properties by 2D embedding were replicated using the *L* <sub>1</sub> metric for neighbor determination (Fig J in [S1 Text](#pcbi.1011288.s001)).

Such mixing patterns are not only used to argue that different datasets are similar, but also to argue for the superiority of one integration method over another. To assess whether such inferences are legitimate, we merged the SMART-Seq2 and CEL-Seq pancreatic islet datasets utilized in \[\] with one of 2 methods, MNN \[\] or Scanorama \[\]. Looking at the fraction of mixing of CEL-Seq cells in the merged ambient space reveals similar mixing by both methods (CEL-Seq cells “mapped” to SMART-Seq2 cells) (ambient distributions, [Fig 3B](#pcbi-1011288-g003)). However the UMAP embeddings provide opposite pictures, with MNN appearing to result in a well-mixed distribution of CEL-Seq cells (left side, [Fig 3B](#pcbi-1011288-g003)) and Scanorama an unmixed distribution of cells (right side, [Fig 3B](#pcbi-1011288-g003)). In cases where batch correction largely fails (Fig Kb in [S1 Text](#pcbi.1011288.s001)), the “integrated” ambient spaces (by either method) are similar to the pre-integrated ambient space. However, reduction to 2D can enhance mixing for the “integrated” spaces, but decrease mixing in the pre-integrated space. We found similar distortions when the *L* <sub>1</sub> norm was used and with t-SNE as used in \[\] (Figs Jb, Jc, and Ka in [S1 Text](#pcbi.1011288.s001)). Notably, the initial PCA reduction can drive the reversal or distortion of mixing trends, though removal of PCA-preprocessing does not alleviate this issue (Figs Jc and Ka in [S1 Text](#pcbi.1011288.s001)). Thus, for a user, it is unclear what patterns of mixing are a result of the efficacy of the integration method, or arbitrary variation introduced by the dimensionality reduction procedure.

A consequence of these findings is that reference mapping procedures, which aim to demonstrate shared structures between batches or datasets, can also result in appearance of false structures (Fig L in [S1 Text](#pcbi.1011288.s001)). As an example, UMAP has been proposed as a method for transforming or mapping new data given coordinates fit on another dataset \[\]. Yet, transforming high dimensional, uniformly distributed points with UMAP coordinates from a single-cell dataset imposes a false structure akin to the structure of the single-cell data (Fig L in [S1 Text](#pcbi.1011288.s001)) (see Methods in [S1 Text](#pcbi.1011288.s001)).

### Cluster validation and relationships

Beyond the use of dimensionality reduction to “validate” dataset merging, it is common to use 2 or 3 dimensional visuals to assess appearances of clusters. This can be to justify or directly generate cluster or cell type assignments \[–,,\] and to infer properties of clusters (their heterogeneity, separation, or similarity) \[,\]. Such uses rely on retention of global relationships ([Fig 1](#pcbi-1011288-g001)), where local neighbors are less important compared to maintaining group assignment or patterns of separation between groups ([Fig 1](#pcbi-1011288-g001)). Distance preservation may also be necessary if conclusions are to be drawn on the extent of separation or locations of clusters ([Fig 1](#pcbi-1011288-g001)). However, across datasets of various sizes \[,\], the prediction of a cell’s label (cell type or condition) based on its neighbors is consistently worse in the 2D embedding space than in higher dimensional representations, even when labels are given as with supervised UMAP (UMAP Sup.) ([Fig 4A](#pcbi-1011288-g004)) (see Methods in [S1 Text](#pcbi.1011288.s001)).

[![thumbnail](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g004)](https://journals.plos.org/ploscompbiol/article/figure/image?size=medium&id=10.1371/journal.pcbi.1011288.g004 "Click for larger image")

Download:
- [
	PNG
	larger image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=large&id=10.1371/journal.pcbi.1011288.g004)
- [
	TIFF
	original image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=original&id=10.1371/journal.pcbi.1011288.g004)

Fig 4. Distortion in cluster validation and relationships.

(**a**) Prediction of cell label for 30% of the dataset(s) based on the labels of the 50 nearest neighbors. (**b**) Distributions of cell type inter- and intra-type distances for the ambient or reduced space (bottom). K-S distance shown as measure of separation, where higher values denote greater separation (see Methods in [S1 Text](#pcbi.1011288.s001)).

[https://doi.org/10.1371/journal.pcbi.1011288.g004](https://doi.org/10.1371/journal.pcbi.1011288.g004)

Each dataset where cell type was predicted (the VMH neurons, the ex and in utero E10.5 embryos, and the developing mouse brain) additionally represents different methods for cluster assignment: using different dimension reduction and iterative clustering methods with manual selection and curation of certain cell types (for the VMH and developing brain datasets) \[,\], differential expression/enrichment analysis of marker expression to assign selected cells (in all 3), and prediction of tissue assignment from gene module expression (E10.5 dataset) \[\]. Cell condition, for the 96-plex NSCs, was determined from sequencing of the multiplexing barcodes, orthogonal to analysis of the gene expression matrix. For the VMH and developing brain datasets, cell type prediction was also tested on PCA (or hierarchical Poisson factorization, HPF)-preprocessed embeddings more closely resembling embeddings used for the original assignment or visualization. These embeddings also displayed the same trends of poorer prediction once reduced to 2D (Fig M in [S1 Text](#pcbi.1011288.s001)). Such results call into question the added benefit of using such embeddings as validations or representations of cluster assignment.

Additionally, by comparing the distribution of pairwise distances between cells of different cell “types” (“inter-type”) to the distribution of distances between cells within the same types (“intra-type”), we can measure how separated those distributions are, i.e., how separated or distinct cell types are from each other ([Fig 4B](#pcbi-1011288-g004)) (see Methods in [S1 Text](#pcbi.1011288.s001)). “Type” refers to either cell type ([Fig 4B](#pcbi-1011288-g004)) or cell condition (Fig Db in [S1 Text](#pcbi.1011288.s001)) annotations. Though it may be desirable for the low-dimensional visualizations to increase separability or clarify cell types as compared to the ambient space, such reduction can have the opposite effect ([Fig 4B](#pcbi-1011288-g004)), reducing the gap between inter-, intra-type distributions for some datasets and increasing the gap for others, whether using the *L* <sub>2</sub> or *L* <sub>1</sub> norm (Figs Db, Eb, N, and O in [S1 Text](#pcbi.1011288.s001)).

We found that cluster structures were additionally highly sensitive to the number of neighbors (perplexity for t-SNE) used in constructing nonlinear embeddings, a commonly tuned parameter which can range from 1% to 10% or less of the data \[,\], in line with other results on the effects of tuning \[,\]. For the in utero E10.5 dataset, common choices for this parameter result in different placements and overlaps of cell types, pushing progenitor populations away from their downstream cell states/types or incorrectly merging distinct, early stage populations (Fig P in [S1 Text](#pcbi.1011288.s001)). Such inconsistencies have led to publication of incorrectly surmised differentiation trajectories from apparent relationships between cell types \[\]. Even in a non-biological, machine learning, benchmark dataset \[\], we found a muddling of cluster structures, with points belonging to different digits mixed within “digit-specific” clusters (possibly hidden by order of points plotted), though high accuracy classification is possible in higher dimensions \[\] (Fig Q in [S1 Text](#pcbi.1011288.s001)) (see Methods in [S1 Text](#pcbi.1011288.s001)). This reveals an assumption of distortion cancellation in interpreting such visuals, i.e., that relevant trends will pop out despite spurious distortion/noise, and a reliance on prior knowledge of ground truth labels (or expected trends) to determine how to interpret the 2D embedding and when tuning of the esthetic parameters is sufficient.

### Density-based visuals and marker analysis

Density assessments of points in 2D embeddings are frequently used to quantitatively assess cell–cell relationships by directly relying on distances between the cells in 2 dimensions ([Fig 1](#pcbi-1011288-g001)). Common applications compare densities of cells in different conditions or batches, within a shared embedding space, to make statements on changes in population density or expression between groups \[,,,\]. However, as demonstrated above, parameter tuning easily disrupts the placement of cells and clusters in such visuals, inherently affecting the generation of contours. Furthermore, using different numbers of neighbors for embedding generation can result in dramatic appearances of cell populations present in 1 condition but not the other (circled numbers 1, 4 in [Fig 5A and 5B](#pcbi-1011288-g005)), which can disappear when more or less neighbors are used, with those populations absorbed into overlapping contours (see Methods in [S1 Text](#pcbi.1011288.s001)). Likewise, densities of cell populations can appear of the same or different scale between conditions depending on the number of neighbors used in construction (circled numbers 2, 3, 5, 6 in [Fig 5A and 5B](#pcbi-1011288-g005)) (Figs R and S in [S1 Text](#pcbi.1011288.s001)), confounding the use of these visuals to make comparative statements.

[![thumbnail](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g005)](https://journals.plos.org/ploscompbiol/article/figure/image?size=medium&id=10.1371/journal.pcbi.1011288.g005 "Click for larger image")

Download:
- [
	PNG
	larger image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=large&id=10.1371/journal.pcbi.1011288.g005)
- [
	TIFF
	original image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=original&id=10.1371/journal.pcbi.1011288.g005)

Fig 5. Distortion in density-based visuals and analysis.

(**a**) Top row (left to right) displays UMAP embedding with n\_neighbors = 5, embedding contour plot colored by condition, same contour with just in utero cells, same contour with just ex utero cells. Bottom row shows same plots for UMAP embedding with n\_neighbors = 50. (**b**) Top row shows same plots for t-SNE embedding with perplexity of 5. Bottom row shows same plots for t-SNE embedding with perplexity of 50. Numbers denote comparisons between plots, dashed lines denote a difference, and solid lines denote the same appearance.

[https://doi.org/10.1371/journal.pcbi.1011288.g005](https://doi.org/10.1371/journal.pcbi.1011288.g005)

### Trajectory inference and continuous relationships

Trajectory inference and pseudotime tasks, such as in RNA velocity \[\] or Monocle \[,\] workflows, focus on local, continuous relationships for inference and calculating pseudotime coordinates. Such tasks may also use distances between embedded points to construct the directions and magnitudes of arrows denoting inferred, developmental trajectories \[,\] ([Fig 1](#pcbi-1011288-g001)). However, as shown with the standard velocyto workflow \[\], using the neighbors of cells after reduction to 2 dimensions to construct velocity arrows can result in erroneous trajectories, due to the arbitrary placement of cells under different parameter choices. Here, we again vary the number of neighbors used to construct the embedding (see Methods in [S1 Text](#pcbi.1011288.s001)). Distortions can include loss of continuous relationships, trajectories in incorrect directions, or the addition of new pathways for development ([Fig 6](#pcbi-1011288-g006)) (Fig T in [S1 Text](#pcbi.1011288.s001)). Distortions additionally occur due to upstream averaging over nearest neighbors in the inference procedure and from the choice of embedding procedure ([Fig 6](#pcbi-1011288-g006)) \[,\]. Thus, the resulting visual compounds distortions from embedding with these prior distortive effects.

[![thumbnail](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g006)](https://journals.plos.org/ploscompbiol/article/figure/image?size=medium&id=10.1371/journal.pcbi.1011288.g006 "Click for larger image")

Download:
- [
	PNG
	larger image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=large&id=10.1371/journal.pcbi.1011288.g006)
- [
	TIFF
	original image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=original&id=10.1371/journal.pcbi.1011288.g006)

Fig 6. Distortion in trajectory inference and continuous relationships.

(**a**) Velocyto RNA velocity embeddings for UMAPs made with 17 or 50 n\_neighbors. Cell types of interest highlighted in gray. (**b**) Velocyto RNA velocity embeddings for t-SNEs made with perplexity of 17 or 50.

[https://doi.org/10.1371/journal.pcbi.1011288.g006](https://doi.org/10.1371/journal.pcbi.1011288.g006)

To investigate distortions of an underlying, continuous manifold by 2D reduction, we used the Swiss-roll as a non-biological benchmark dataset, for which we know the structure in 3 dimensions, and moreover is a 2D manifold (see Methods in [S1 Text](#pcbi.1011288.s001)). We demonstrate how the 3D Swiss-roll (constructed by rolling up the 2D plane) loses its coherence when embedded in 2D with UMAP (Fig U in [S1 Text](#pcbi.1011288.s001)). No embedding recapitulates the original plane \[\] and depending on the number of neighbors used, distinct clusters or islands may appear, with a scrambling of local neighbors (made worse by increasing the tightness of the embedded roll) (Fig U in [S1 Text](#pcbi.1011288.s001)). Thus, knowledge of the true manifold is required to understand the disruption of continuity in these embeddings.

Additionally, alongside cluster-level global relationships, locally continuous properties of such visuals are used as independent “metrics” to validate cell type assignment and robustness of clustering results \[,,,\]. However, in common single-cell analysis packages (e.g., Scanpy \[\] and Seurat \[\]), the same k-nearest neighbor (kNN) graph constructed from the higher dimensional PCA space is passed to both the clustering algorithm and the embedding algorithm. As shown in Fig V in [S1 Text](#pcbi.1011288.s001), the embedding is then not an independent assessment of clustering results and is likely to form clusters that resemble the kNN graph even if that graph does not represent the “original” underlying manifold. Together, the use of such embeddings to imply or infer continuous relationships then becomes an arbitrary endeavor, with a user unable to trust seemingly dramatic connections or isolated populations, and likely to choose what seems most appealing or expected.

### Embedding properties are arbitrary

To illustrate the indeterminate nature of 2D UMAP and t-SNE embeddings, we developed an autoencoder framework to fit cells from any dataset to an arbitrary 2D shape, while preserving ambient cell-to-cell distances to an extent not much different than UMAP or t-SNE (see Methods in [S1 Text](#pcbi.1011288.s001)) \[,,\]. We found that it is possible to embed data in the shape of a “von Neumann elephant” \[,\] or a flower. Though it is unlikely scientists would present data in such forms, as shown below, they are quantitatively similar in terms of fidelity to the data in ambient dimension, compared to UMAP or t-SNE embeddings. We call this method to produce customized embeddings “Picasso,” in homage to the eponymous artist’s skill in imitating other artistic works.

We compared correlations of inter- and intra-type distances between Picasso embeddings with those of t-SNE, UMAP, and PCA, for the ex utero (E8.5), MERFISH MOp, and SMART-Seq VMH neuron datasets \[\]. These distances represent trends often inferred from such visuals, where inter-type distances represent inter-cell-type relationships (or global relationships between clusters), and intra-type distances represent the variance or spread within the cell types (see Methods in [S1 Text](#pcbi.1011288.s001)). Each Picasso embedding demonstrated comparable performance to t-SNE and UMAP ([Fig 7](#pcbi-1011288-g007)), even dens-SNE/densMAP \[\] projections (Fig W in [S1 Text](#pcbi.1011288.s001)), with cells of the same types distinctly grouped together in the arbitrary shapes. Picasso embeddings also improved upon t-SNE/UMAP intra-type correlations for all datasets ([Fig 7](#pcbi-1011288-g007)). Results were recapitulated for inter- and intra-distances calculated with the *L* <sub>1</sub> norm and for trends between cells of different sexes (inter- and intra-sex distances) for the VMH neuron dataset (Figs W and X in [S1 Text](#pcbi.1011288.s001)).

[![thumbnail](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g007)](https://journals.plos.org/ploscompbiol/article/figure/image?size=medium&id=10.1371/journal.pcbi.1011288.g007 "Click for larger image")

Download:
- [
	PNG
	larger image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=large&id=10.1371/journal.pcbi.1011288.g007)
- [
	TIFF
	original image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=original&id=10.1371/journal.pcbi.1011288.g007)

Fig 7. Embedding properties are arbitrary.

Elephant-shaped embeddings \[,\] shown on the left, with corresponding correlations of data embeddings to ambient space shown in right-hand plots, for inter- and intra-type distance metrics. Metrics calculated over *n* = 5 embeddings. Colors denote cell types, delineated in Fig W in [S1 Text](#pcbi.1011288.s001).

[https://doi.org/10.1371/journal.pcbi.1011288.g007](https://doi.org/10.1371/journal.pcbi.1011288.g007)

Thus, Picasso can quantitatively represent these visually inferred characteristics similarly to, or better than, the respective t-SNE/UMAP embeddings, while producing arbitrary shapes.

## Discussion

### Limitations for exploratory data analysis (EDA)

Although popular 2D embeddings can reflect the broader strokes of the data such as cell type inter-distances, or highlight correlations between features \[\], our findings highlight fundamental obstacles in reduction of high-dimensional data to 2D, the generation of multiple, possibly contradictory interpretations of the same data across applications, and the limited utility of these embeddings as EDA tools.

Though at the heart of EDA, as defined by statistician John W. Tukey \[–\], is the exploration of data through visualizations prior to confirmatory analysis, such visuals are intended to encompass robust or “resistant” analyses that extract (expected or unexpected) features of the data \[\]. Thus, the use of these 2D embeddings to reveal expected or unexpected properties is fraught by the fact that it is unclear which properties will be preserved or displayed, i.e., the purpose of the visual itself, where seemingly strong characteristics can be arbitrary distortions, from integration/mixing patterns ([Fig 3](#pcbi-1011288-g003)) to the existence of or connections between clusters (Figs [4](#pcbi-1011288-g004) – [6](#pcbi-1011288-g006), Fig P in [S1 Text](#pcbi.1011288.s001)). Methods to show error or significance of cell placement on these visuals do not tackle the inherent limitations of such low dimension embedding: the lack of definition regarding which features are displayed and what is distortion to ignore \[,\]. Prior analysis is required to determine “sufficient” tuning of esthetically oriented parameters and to define the purpose of the visual, undermining the use of such procedures as EDA tools. Together, this results in a user conducting 2 confounded exploratory analyses that of the method properties and that of the data properties.

Another of the “guiding principles” of EDA can be formulated as “analyses…before summaries” \[\], where analyses are conducted to present particular features of the data, then collated as a summary. However, the use of such all-in-one visuals begins from a place of summary rather than analysis, showing “all points and all relationships” at once and attempting to approximate many properties. In general, the open-ended nature of these visuals and ability of parameter tuning to manipulate and create biological patterns demonstrate the ease with which such tools become confirmatory bias aids and that such 2D spaces should be treated more as cartoon diagrams to be displayed post-analysis. However, in these cases conceptual graphics can be used instead which do not attempt to represent “all points and all relationships” (to avoid overinterpretation) and higher-level diagrams which do not operate at the cell- or point-wise level \[,\].

### Assumptions and incoherences in the dimensionality reduction process

The generation of the 2D embedding is additionally a multistep process, demonstrated here as a preprocessing of the ambient data with a higher dimensional (linear) reduction by PCA, then a nonlinear reduction to 2D by t-SNE/UMAP. Each step incurs some distortion of the data, where preservation of certain properties by 1 reduction can be lost by the next, as well as exaggeration of distorted patterns over the steps. However, this procedure is taken as a baseline \[,\], and there is little discussion of the logic behind this coupling.

For example, though Euclidean (*L* <sub>2</sub>) distance is the default metric for constructing neighborhood graphs in methods such as t-SNE and UMAP, this is not a requirement, and one might surmise that the nonlinear methods instead learn other manifold-specific “metrics” from cell neighborhoods by identifying “biological geometries” (though this is not justified by the original authors \[,\]). However, methods such as UMAP and t-SNE at their core rely on measuring distances locally, in concordance with common Euclidean analysis methods. This is the case for neighborhood graph construction as used for clustering \[\], pseudotime and trajectory inference \[,\], as well as nonlinear embedding (e.g., UMAP/t-SNE) \[,\]. Notably, the assumptions underlying the preprocessing of data by PCA may clash with the assumptions in extracting these other “biological geometries” by nonlinear dimensionality reduction, as PCA implicitly assumes Gaussian noise for data that lies in a Euclidean space. Embedding by PCA additionally reduces variance in the projected data, while methods such as UMAP add noise to embedded data (while removing biological signal) \[\].

Utilizing these 2D visuals to infer structure of the underlying manifold then requires knowledge of that manifold itself to interpret these outputs and distortions, a task confounded by noise present in biological data and the fact that common methods poorly recapitulate simple non-Euclidean manifolds (Fig U in [S1 Text](#pcbi.1011288.s001)) \[\]. And while PCA does impose assumptions of Euclidean geometry and Gaussian noise, the assumptions of heuristic, nonlinear methods are more opaque and their results not easily falsifiable.

### Alternative methods and analysis approaches for applications

We therefore discourage reliance on and blind application of such heuristic procedures, particularly across the range of applications in [Fig 1](#pcbi-1011288-g001). Instead, greater focus should be given to utilizing and developing an array of investigative and self-consistent analysis tools, which provide clearer interpretation of their goals and the biological features being assessed, present targeted low-dimensional embeddings and visuals displaying these features, and can easily be combined with statistical procedures to generate and falsify hypotheses.

With respect to the general task of preserving neighbor relationships (local or global) in an embedded space, it is possible to construct embedding spaces which more explicitly control and improve nearest-neighbor structure and retention (Figs Y and Z, “MCML” in Methods in [S1 Text](#pcbi.1011288.s001)) \[,\], as well as retention of desired metrics such as the intra-label metrics described above (Fig ZA, “bMCML” in Methods in [S1 Text](#pcbi.1011288.s001)). However, such optimizations require making an assumption regarding the appropriate distance/similarity metric, as is generally the case with the neighborhood-based analysis methods ubiquitous across the tasks in [Fig 1](#pcbi-1011288-g001).

Our analyses have focused on measuring distortions with respect to the *L* <sub>1</sub> metric, given its more desirable properties in higher dimensions than Euclidean (*L* <sub>2</sub>) distance (see above), but other choices of distance or similarity metrics are possible and, whether in ambient or reduced space, can provide different interpretations of a dataset’s properties \[\]. To assess the suitability of different metrics across datasets, we used the “relative contrast” ratio from \[\] to measure the ability of an *L* <sub><em>k</em></sub> norm to meaningfully delineate proximity between cells in high dimensions (see Methods in [S1 Text](#pcbi.1011288.s001)). We found that *L* <sub>1</sub> has higher contrast values than the *L* <sub>2</sub> norm across datasets ([Fig 8](#pcbi-1011288-g008)), suggesting preferential behavior in distinguishing cell relationships. How the various biological and technical features of each dataset drive or influence these contrast values is, however, unexplored. There are other avenues for determining the relevance of a proximity metric, by assessing data properties such as “hubness” (the presence of points with high proximity to many points in high dimensions) \[\] and sparsity, discreteness, or continuity of the data structure \[\], as well as the metric’s biological interpretability in light of a given task or question. Thus, if such a metric is desired to represent relationships between cells, selection of the metric(s) should be carefully considered prior to downstream transformations and dimension reductions.

[![thumbnail](https://journals.plos.org/ploscompbiol/article/figure/image?size=inline&id=10.1371/journal.pcbi.1011288.g008)](https://journals.plos.org/ploscompbiol/article/figure/image?size=medium&id=10.1371/journal.pcbi.1011288.g008 "Click for larger image")

Download:
- [
	PNG
	larger image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=large&id=10.1371/journal.pcbi.1011288.g008)
- [
	TIFF
	original image
	](https://journals.plos.org/ploscompbiol/article/figure/image?download&size=original&id=10.1371/journal.pcbi.1011288.g008)

Fig 8. Relative contrast of the *L* <sub>1</sub> and *L* <sub>2</sub> metrics.

Violin plots display kernel density estimates of the distribution of log2(Relative Contrast) ratio values for each dataset, computed for *n* = 5 random subsets of 1,000 HVGs selected for each dataset from its top 2,000 HVGs. Relative contrast was calculated as described in Methods in [S1 Text](#pcbi.1011288.s001) and \[\], in the ambient (gene) space. Distributions are shown across datasets of increasing sample size (cell number). Box plots are overlaid in black, with the median denoted by the white dot. Whiskers denote 1.5× the interquartile range. HVG, highly variable gene; NSC, neural stem cell; VMH, ventromedial hypothalamus.

[https://doi.org/10.1371/journal.pcbi.1011288.g008](https://doi.org/10.1371/journal.pcbi.1011288.g008)

Across the applications in [Fig 1](#pcbi-1011288-g001), there are existing methods and metrics, as well as opportunities for method development, which can provide more targeted alternatives in keeping with principles of EDA. For example, the assessment of multimodal data integration and mixing can be directly calculated between cells, as shown by the metrics in this study, as well as by other metrics on mixing proportions and separation \[\] or on the retention of true “batch” differences (biological variation) \[,\]. Such analyses can additionally be conducted in the ambient space, which minimizes the distortion/transformation of gene-related properties, useful for downstream experimentation.

For applications regarding clustering, clusters can be generated from higher dimensional embeddings if not from the ambient space itself \[\], and given the central importance of marker gene expression in validating cluster assignment, existing tools such as heatmaps can directly display cluster results with the features (genes) which determined these groupings. Dimensionality reduction on the gene space can additionally be used to filter for genes or sets of genes best suited to separating the clusters \[,\]. By targeting the objective of an embedding in such a manner, one can take advantage of prior knowledge/annotations and more directly determine the necessary dimensionality for a given question.

To assess heterogeneity within clusters or relationships between clusters, similarity metrics or distances can be calculated between the cells \[\] and displayed with qualitative or quantitative visuals that preserve these metrics as a part of their objectives, including hierarchical relationship diagrams such as dendrograms and trees \[,\], or graph-based network diagrams \[,\]. Higher-level diagrams that do not seek to display all point-wise information can also be used to represent the results of other inter-cluster analyses \[,\], better matching the resolution of the visual to the resolution of the analysis represented.

Such cluster-level visuals and metrics, as well as metrics on integration and higher dimensional distribution comparisons as presented here, can be used in lieu of analyses based on contour plots generated from 2D coordinates. Regarding trajectories and continuous relationships, higher dimensions should be used to perform inference of differentiation trajectories \[,\], and incorporation of probabilistic and biophysically informed inference methods \[,,\], offers falsifiable and interpretable approaches with targeted visualization alternatives. Such models additionally offer more interpretable handling of biological, as well as technical, noise \[\], avoiding a smoothing over or removal of noise, which could otherwise provide valuable biological signal.

Though it may seem appealing to produce visuals of “all data and all relationships,” common embedding practice distorts data in obscure ways, attempts to pack the capabilities of many different analyses into one space, and is easily manipulated. Given these limitations, and the distortions induced by earlier processing steps \[\], it is preferable to limit dimensionality reductions and ad hoc transformations, particularly when the space of interest can be treated directly, to utilize and develop targeted analyses for common questions that enable focused visuals, and collate these analyses to drive downstream, hypothesis-driven biological discovery.

## Supporting information

The Specious Art of Single-Cell Genomics  
Supplementary Text  
Tara Chari 1 and Lior Pachter 1,2\*  
1 Division of Biology and Biological Engineering,  
California Institute of Technology, Pasadena, California, United States of America  
2 Department of Computing and Mathematical Sciences,  
California Institute of Technology, Pasadena, California, United States of America  
\* lpachter@caltech.edu  
June 27, 2023  
Contents  
Methods 2  
Datasets and Pre-processing...................................2  
Local Jaccard Distances.....................................3  
Global Cell ‘Type’ Neighbor Rankings.............................3  
(Equi)Distance Analysis.....................................4  
Mixing Analysis.........................................5  
Metrics for Cluster Relationships................................5  
Density-Based Analysis.....................................6  
Trajectory Analysis........................................6  
Picasso Embedding & Metrics..................................6  
MCML Embedding & Metrics..................................7  
Relative Contrast Analysis of L 1 & L 2 Norms.........................9  
Figures 10  
Distortion of Necessary Properties...............................10  
Distortion in Applications....................................19  
Picasso & MCML Results....................................32  
Note 38  
Bounds on Distortion of Equidistant Points..........................38  
1

Methods  
Datasets and Pre-processing  
All datasets used in this study are listed in Table A, and were chosen to cover a range of  
sequencing platforms, experiment sizes, and experimental designs.For certain datasets, links to  
saved pre-processed matrices (also used in the github Colab notebooks) are provided in Table B.  
Dataset Technology Cells Label Metadata Download Link  
Ex and In Utero Mouse Embryo E10.5 10x Genomics v3 56,528 Cell Type, Growth Condition https://ftp.ncbi.nlm.nih.gov/geo/series/GSE149nnn/GSE149372/suppl/  
Ex and In Utero Mouse Embryo E8.5 10x Genomics v3 6,205 Cell Type, Growth Condition https://ftp.ncbi.nlm.nih.gov/geo/series/GSE149nnn/GSE149372/suppl/  
SMART-Seq Mouse VMH Neurons SMART-Seq v4 3,850 Cell Type, Sex https://data.mendeley.com/datasets/ypx3sw2f7c/3  
10x Mouse VMH Neurons 10x Genomics v2 41,580 Cell Type, Sex https://data.mendeley.com/datasets/ypx3sw2f7c/3  
10x Developing Mouse Brain 10x Genomics v1 292,495 Cell Type http://mousebrain.org/downloads.html  
Developing C. elegans Embryo (Neural Lineage) 10x Genomics v2 1,075 Cell Type, Pseudotime http://staff.washington.edu/hpliner/data/  
Mouse Primary Motor Cortex (MOp) MERFISH 6,963 Cell Type, Spatial Coordinates https://caltech.app.box.com/folder/134209256308  
Human Embryo Forebrain 10x Genomics v1 1,711 Cell Type https://github.com/tarachari3/GFCP\_2022/blob/main/notebooks/data/hgForebrainGlut.loom  
CEL-Seq Human Pancreatic Islet Cells CEL-Seq 1,276 Technology http://cb.csail.mit.edu/cb/scanorama/data.tar.gz  
SMART-Seq2 Human Pancreatic Islet Cells SMART-Seq2 2,989 Technology http://cb.csail.mit.edu/cb/scanorama/data.tar.gz  
inDrop Human Pancreatic Islet Cells inDrop 8,569 Technology http://cb.csail.mit.edu/cb/scanorama/data.tar.gz  
Human Monocytes Drug Combo 10x Genomics v2 29,360 Cell Condition (Drug Combo) https://figshare.com/articles/dataset/PopAlign\_Data/11837097  
Mouse Neural Stem Cells (NSCs) 96-plex 10x Genomics v2 21,232 Cell Condition (Drug Combo) https://data.caltech.edu/records/a73n8-3pa89  
Mouse Embryonic Stem Cells (ESCs) with DMSO 10x Genomics v2 904 None https://zenodo.org/record/7694182  
Table A. Dataset Metadata.Datasets used across all analyses.  
For the SMART-Seq and 10x mouse VMH datasets, cells were filtered according to the steps  
outlined in \[37\]. Unless already provided, the top 2000 highly-variable genes (HVGs) were identi-  
fied for all datasets using Scanpy’s highly variable genes \[59\]. Counts were log-normalized, unless  
previously transformed, with the log-count matrices representing the ‘ambient’ data for metric com-  
parisons (see below). Thus unless otherwise indicated, ‘ambient’ space refers to the log-normalized  
count matrices filtered for HVGs. All count matrices were mean-centered and scaled before appli-  
cation of Picasso or principal component analysis (PCA). All PCA analysis was performed using  
sklearn TruncatedSVD to 50 dimensions by default. 15 dimensions was used for the PCA of the  
integrated mouse embryo E10.5 dataset and 100 dimensions for the pancreatic islet datasets, to  
facilitate direct comparison to the original studies \[8,10\].  
The t-SNE and UMAP algorithms were applied to the higher dimensional PCA embeddings with  
default settings. This sequence of dimension reduction by PCA first, prior to reduction to 2D by  
UMAP/t-SNE, is denoted as ‘PCA-preprocessing’. The effect of a single parameter (n neighbors)  
change is shown for UMAP embeddings in Fig 5,6 and Fig P,R-V, but we did not adjust parameters  
beyond this.As per the discussion in \[35\], though slight changes in these aesthetic parameters  
can drastically impact low-dimensional embeddings, the choice of parameters for tuning is often  
informed by empirical observations/prior knowledge leaving open the question of which metric(s) to  
use for determining ‘optimal’ parameters. Notably this tuning is also contradictory to the common  
use or desire of such techniques to produce ‘unsupervised’ representations of the data.  
2

## Acknowledgments

Some of the computations presented here were conducted using machines in the Resnick High Performance Center, a facility supported by the Resnick Sustainability Institute at the California Institute of Technology. We thank Joeyta Banerjee for her work developing data processing scripts and Colab notebooks for a previous manuscript version \[\]. We also thank Gennady Gorin and Benjamin Rivière for helpful discussions regarding the MCML and Picasso analyses, Sina Booeshaghi for helpful discussions regarding NCA and dimensionality reduction, Ingileif Hallgrímsdottir for valuable feedback on the manuscript, and Páll Melsted for useful insights regarding Theorem 1.

## References

[^1]: 1.
- [View Article](https://doi.org/10.1038/s41467-019-13056-x "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/31780648 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=The+art+of+using+t-SNE+for+single-cell+transcriptomics+Kobak+2019 "Go to article in Google Scholar")

[^2]: 2.
- [View Article](https://doi.org/10.1038/s41592-021-01171-x "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/34155396 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=The+triumphs+and+limitations+of+computational+methods+for+scRNA-seq+Kharchenko+2021 "Go to article in Google Scholar")

[^3]: 3.
- [View Article](https://doi.org/10.1016/j.celrep.2021.109442 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/34320340 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Dimensionality+reduction+by+UMAP+reinforces+sample+heterogeneity+analysis+in+bulk+transcriptomic+data+Yang+2021 "Go to article in Google Scholar")

[^4]: 4.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=Visualizing+Data+using+t-SNE+van+der+Maaten+2008 "Go to article in Google Scholar")

[^5]: 5.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=UMAP%3A+Uniform+Manifold+Approximation+and+Projection+for+Dimension+Reduction+McInnes+2018 "Go to article in Google Scholar")

[^6]: 6.
- [View Article](https://doi.org/10.1016/j.celrep.2020.107576 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/32375029 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=A+Quantitative+Framework+for+Evaluating+Single-Cell+Data+Structure+Preservation+by+Dimensionality+Reduction+Techniques+Heiser+2020 "Go to article in Google Scholar")

[^7]: 7.
- [View Article](https://doi.org/10.1016/j.cell.2021.04.048 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/34062119 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Integrated+analysis+of+multimodal+single-cell+data+Hao+2021 "Go to article in Google Scholar")

[^8]: 8.
- [View Article](https://doi.org/10.1038/s41586-021-03416-3 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/33731940 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Ex+utero+mouse+embryogenesis+from+pre-gastrulation+to+late+organogenesis+Aguilera-Castrejon+2021 "Go to article in Google Scholar")

[^9]: 9.
- [View Article](https://doi.org/10.1186/s13059-022-02679-x "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/35534898 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Bi-order+multimodal+integration+of+single-cell+data+Dou+2022 "Go to article in Google Scholar")

[^10]: 10.
- [View Article](https://doi.org/10.1038/s41587-019-0113-3 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/31061482 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Efficient+integration+of+heterogeneous+single-cell+transcriptomes+using+Scanorama+Hie+2019 "Go to article in Google Scholar")

[^11]: 11.
- [View Article](https://doi.org/10.1038/nbt.4314 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/30531897 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Dimensionality+reduction+for+visualizing+single-cell+data+using+UMAP+Becht+2018 "Go to article in Google Scholar")

[^12]: 12.
- [View Article](https://doi.org/10.1038/s41467-021-25957-x "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/34620862 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Efficient+and+precise+single-cell+reference+atlas+mapping+with+Symphony+Kang+2021 "Go to article in Google Scholar")

[^13]: 13.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=Minimum-Distortion+Embedding+Agrawal+2021 "Go to article in Google Scholar")

[^14]: 14.
- [View Article](https://doi.org/10.1016/j.celrep.2019.09.082 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/31693907 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=DoubletDecon%3A+Deconvoluting+Doublets+from+Single-Cell+RNA-Sequencing+Data+DePasquale+2019 "Go to article in Google Scholar")

[^15]: 15.
- [View Article](https://doi.org/10.1038/s41598-020-66848-3 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/32703984 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Identification+of+cell+types+from+single+cell+data+using+stable+clustering+Peyvandipour+2020 "Go to article in Google Scholar")

[^16]: 16.
- [View Article](https://doi.org/10.1038/s41467-021-23324-4 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/34017005 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Interpretation+of+T+cell+states+from+single-cell+transcriptomics+data+using+reference+atlases+Andreatta+2021 "Go to article in Google Scholar")

[^17]: 17.
- [View Article](https://doi.org/10.1038/s41467-019-12464-3 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/31624246 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Single-cell+transcriptomics+of+human+T+cells+reveals+tissue+and+activation+signatures+in+health+and+disease+Szabo+2019 "Go to article in Google Scholar")

[^18]: 18.
- [View Article](https://doi.org/10.1186/s13045-021-01222-y "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/35012610 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Treatment+with+soluble+CD24+attenuates+COVID-19-associated+systemic+immunopathology+Song+2022 "Go to article in Google Scholar")

[^19]: 19.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=PerturbNet+predicts+single-cell+responses+to+unseen+chemical+and+genetic+perturbations+Yu+2022 "Go to article in Google Scholar")

[^20]: 20.
- [View Article](https://doi.org/10.1038/s41586-022-05688-9 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/36755098 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Dissecting+cell+identity+via+network+inference+and+in+silico+gene+perturbation+Kamimoto+2023 "Go to article in Google Scholar")

[^21]: 21.
- [View Article](https://doi.org/10.1038/s41587-019-0071-9 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/30936559 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=A+comparison+of+single-cell+trajectory+inference+methods+Saelens+2019 "Go to article in Google Scholar")

[^22]: 22.
- [View Article](https://doi.org/10.1038/s41586-019-0969-x "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/30787437 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=The+single-cell+transcriptional+landscape+of+mammalian+organogenesis+Cao+2019 "Go to article in Google Scholar")

[^23]: 23.
- [View Article](https://doi.org/10.1038/s41586-018-0414-6 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/30089906 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=RNA+velocity+of+single+cells+La+Manno+2018 "Go to article in Google Scholar")

[^24]: 24.
- [View Article](https://doi.org/10.1038/nbt.2859 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/24658644 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=The+dynamics+and+regulators+of+cell+fate+decisions+are+revealed+by+pseudotemporal+ordering+of+single+cells+Trapnell+2014 "Go to article in Google Scholar")

[^25]: 25.
- [View Article](https://doi.org/10.1016/j.cell.2020.09.056 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/33098772 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Chromatin+Potential+Identified+by+Shared+Single-Cell+Profiling+of+RNA+and+Chromatin+Ma+2020 "Go to article in Google Scholar")

[^26]: 26.
- [View Article](https://doi.org/10.1371/journal.pbio.3000365 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/31269016 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Dissecting+the+transcriptome+landscape+of+the+human+fetal+neural+retina+and+retinal+pigment+epithelium+by+single-cell+RNA-seq+analysis+Hu+2019 "Go to article in Google Scholar")

[^27]: 27.
- [View Article](https://doi.org/10.1101/gr.251447.119 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/32430339 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Exploring+dimension-reduced+embeddings+with+Sleepwalk+Ovchinnikova+2020 "Go to article in Google Scholar")

[^28]: 28.
- [View Article](https://doi.org/10.1038/s41587-020-00809-z "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/33526945 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Initialization+is+critical+for+preserving+global+data+structure+in+both+t-SNE+and+UMAP+Kobak+2021 "Go to article in Google Scholar")

[^29]: 29\. [ieeexplore.ieee.org](http://ieeexplore.ieee.org/)

[^30]: 30.

[^31]: 31.
- [View Article](https://doi.org/10.1038/s41592-019-0372-4 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/30962620 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Evaluating+measures+of+association+for+single-cell+transcriptomics+Skinnider+2019 "Go to article in Google Scholar")

[^32]: 32.
- [View Article](https://doi.org/10.1038/s41587-021-01160-7 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/35058622 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Massively+parallel+phenotyping+of+coding+variants+in+cancer+with+Perturb-seq+Ursu+2022 "Go to article in Google Scholar")

[^33]: 33.
- [View Article](https://doi.org/10.1093/bib/bbac387 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/36151725 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=How+does+the+structure+of+data+impact+cell%E2%80%93cell+similarity%3F+Evaluating+how+structural+properties+influence+the+performance+of+proximity+metrics+in+single+cell+RNA-seq+data+Watson+2022 "Go to article in Google Scholar")

[^34]: 34.
- [View Article](https://doi.org/10.1186/s13059-016-0970-8 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/27230763 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Fast+and+accurate+single-cell+RNA-seq+analysis+by+clustering+of+transcript-compatibility+counts+Ntranos+2016 "Go to article in Google Scholar")

[^35]: 35.
- [View Article](https://doi.org/10.1101/689851 "Go to article")
- [Google Scholar](http://scholar.google.com/scholar?q=A+novel+metric+reveals+previously+unrecognized+distortion+in+dimensionality+reduction+of+scRNA-seq+data+Cooley+2022 "Go to article in Google Scholar")

[^36]: 36.
- [View Article](https://doi.org/10.1137/18m1216134 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/33073204 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Clustering+with+t-SNE%2C+Provably+Linderman+2019 "Go to article in Google Scholar")

[^37]: 37.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=Multimodal+Analysis+of+Cell+Types+in+a+Hypothalamic+Node+Controlling+Social+Behavior+Analysis+of+Cell+Types+in+a+Hypothalamic+Node+Controlling+Social+Behavior+Kim+2019 "Go to article in Google Scholar")

[^38]: 38.
- [View Article](https://doi.org/10.1101/2020.06.04.105700 "Go to article")
- [Google Scholar](http://scholar.google.com/scholar?q=Molecular%2C+spatial+and+projection+diversity+of+neurons+in+primary+motor+cortex+revealed+by+in+situ+single-cell+transcriptomics+Zhang+2020 "Go to article in Google Scholar")

[^39]: 39.
- [View Article](https://doi.org/10.1126/science.abc6506 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/34301855 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=A+DNA+repair+pathway+can+regulate+transcriptional+noise+to+promote+cell+fate+transitions+Desai+2021 "Go to article in Google Scholar")

[^40]: 40.
- [View Article](https://doi.org/10.1038/s41587-019-0372-z "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/31873215 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Highly+multiplexed+single-cell+RNA-seq+by+DNA+oligonucleotide+tagging+of+cellular+proteins+Gehring+2020 "Go to article in Google Scholar")

[^41]: 41.
- [View Article](https://doi.org/10.1073/pnas.2005990117 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/33127759 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Dissecting+heterogeneous+cell+populations+across+drug+and+disease+conditions+with+PopAlign+Chen+2020 "Go to article in Google Scholar")

[^42]: 42.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=Almost-Equidistant+Sets+Balko+2020 "Go to article in Google Scholar")

[^43]: 43.

[^44]: 44.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=On+the+distortion+required+for+embedding+finite+metric+spaces+into+normed+spaces+Matou%C5%A1ek+1996 "Go to article in Google Scholar")

[^45]: 45.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=Extensions+of+Lipschitz+mappings+into+a+Hilbert+space+26+Johnson+1984 "Go to article in Google Scholar")

[^46]: 46.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=The+Johnson-Lindenstrauss+lemma+is+optimal+for+linear+dimensionality+reduction+Larsen+2014 "Go to article in Google Scholar")

[^47]: 47\. [ieeexplore.ieee.org](http://ieeexplore.ieee.org/)

[^48]: 48.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=.+An+elementary+proof+of+a+theorem+of+Johnson+and+Lindenstrauss+Dasgupta+2003 "Go to article in Google Scholar")

[^49]: 49.

[^50]: 50.
- [View Article](https://doi.org/10.1038/nbt.4091 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/29608177 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Batch+effects+in+single-cell+RNA-sequencing+data+are+corrected+by+matching+mutual+nearest+neighbors+Haghverdi+2018 "Go to article in Google Scholar")

[^51]: 51.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=Molecular+architecture+of+the+developing+mouse+brain+La+Manno+2020 "Go to article in Google Scholar")

[^52]: 52.
- [View Article](https://doi.org/10.1002/cti2.1308 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/34221402 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=No+evidence+that+plasmablasts+transdifferentiate+into+developing+neutrophils+in+severe+COVID-19+disease+Alquicira-Hernandez+2021 "Go to article in Google Scholar")

[^53]: 53.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=The+MNIST+Database+of+Handwritten+Digit+Images+for+Machine+Learning+Research+%5BBest+of+the+Web%5D+Deng+2012 "Go to article in Google Scholar")

[^54]: 54.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=No+routing+needed+between+capsules+Byerly+2021 "Go to article in Google Scholar")

[^55]: 55.
- [View Article](https://doi.org/10.1371/journal.pcbi.1010492 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/36094956 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=RNA+velocity+unraveled+Gorin+2022 "Go to article in Google Scholar")

[^56]: 56.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=Pumping+the+brakes+on+RNA+velocity%E2%80%93understanding+and+interpreting+RNA+velocity+estimates+Zheng+2022 "Go to article in Google Scholar")

[^57]: 57.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=Deep+Manifold+Computing+and+Visualization+Li+2020 "Go to article in Google Scholar")

[^58]: 58.
- [View Article](https://doi.org/10.1038/s41467-021-22851-4 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/33953202 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Deep+generative+model+embedding+of+single-cell+RNA-Seq+profiles+on+hyperspheres+and+hyperbolic+spaces+Ding+2021 "Go to article in Google Scholar")

[^59]: 59.
- [View Article](https://doi.org/10.1186/s13059-017-1382-0 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/29409532 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=SCANPY%3A+large-scale+single-cell+gene+expression+data+analysis+Wolf+2018 "Go to article in Google Scholar")

[^60]: 60.
- [View Article](https://doi.org/10.1093/bioinformatics/btaa169 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/32176273 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Interpretable+factor+models+of+single-cell+RNA-seq+via+variational+autoencoders+Svensson+2020 "Go to article in Google Scholar")

[^61]: 61.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=Adam%3A+A+Method+for+Stochastic+Optimization+Kingma+2014 "Go to article in Google Scholar")

[^62]: 62.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=Drawing+an+elephant+with+four+complex+parameters+Mayer+2010 "Go to article in Google Scholar")

[^63]: 63.
- [View Article](https://doi.org/10.1038/427297a "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/14737148 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=A+meeting+with+Enrico+Fermi+Dyson+2004 "Go to article in Google Scholar")

[^64]: 64.
- [View Article](https://doi.org/10.1038/s41587-020-00801-7 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/33462509 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Assessing+single-cell+transcriptomic+variability+through+density-preserving+data+visualization+Narayan+2021 "Go to article in Google Scholar")

[^65]: 65.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=Dimensionality+reduction+by+UMAP+to+visualize+physical+and+genetic+interactions+Dorrity+2020 "Go to article in Google Scholar")

[^66]: 66.

[^67]: 67.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=We+Need+Both+Exploratory+and+Confirmatory+Tukey+1980 "Go to article in Google Scholar")

[^68]: 68.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=Tukey+and+Data+Analysis+Hoaglin+2003 "Go to article in Google Scholar")

[^69]: 69.
- [View Article](https://doi.org/10.1016/j.patter.2022.100465 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/35510193 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Data-driven+assessment+of+dimension+reduction+quality+for+single-cell+omics+data+Dong+2022 "Go to article in Google Scholar")

[^70]: 70.
- [View Article](https://doi.org/10.1093/bioinformatics/btz296 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/31038684 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Continuous-state+HMMs+for+modeling+time-series+single-cell+RNA-Seq+data+Lin+2019 "Go to article in Google Scholar")

[^71]: 71.
- [View Article](https://doi.org/10.1186/s13059-019-1663-x "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/30890159 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=PAGA%3A+graph+abstraction+reconciles+clustering+with+trajectory+inference+through+a+topology+preserving+map+of+single+cells+Wolf+2019 "Go to article in Google Scholar")

[^72]: 72\. [ieeexplore.ieee.org](http://ieeexplore.ieee.org/)

[^73]: 73.
- [View Article](https://doi.org/10.1038/nmeth.3971 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/27571553 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Diffusion+pseudotime+robustly+reconstructs+lineage+branching+Haghverdi+2016 "Go to article in Google Scholar")

[^74]: 74.
- [View Article](https://doi.org/10.1101/2022.06.11.495771 "Go to article")
- [Google Scholar](http://scholar.google.com/scholar?q=Monod%3A+mechanistic+analysis+of+single-cell+RNA+sequencing+count+data+Gorin+2022 "Go to article in Google Scholar")

[^75]: 75.

[^76]: 76.
- [View Article](https://doi.org/10.15252/msb.20209620 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/33491336 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Probabilistic+harmonization+and+annotation+of+single-cell+transcriptomics+data+with+deep+generative+models+Xu+2021 "Go to article in Google Scholar")

[^77]: 77\. *l* <sup><em>p</em></sup>
- [View Article](https://doi.org/10.1016/j.neucom.2014.11.084 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/26640321 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Choosing+lp+norms+in+high-dimensional+spaces+based+on+hub+analysis+Flexer+2015 "Go to article in Google Scholar")

[^78]: 78.
- [View Article](https://doi.org/10.1101/2021.11.15.468733 "Go to article")
- [Google Scholar](http://scholar.google.com/scholar?q=PMD+Uncovers+Widespread+Cell-State+Erasure+by+scRNAseq+Batch+Correction+Methods+Tyler+2021 "Go to article in Google Scholar")

[^79]: 79.
- [View Article](https://doi.org/10.1038/s41467-021-21453-4 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/33608535 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Optimal+marker+gene+selection+for+cell+type+discrimination+in+single+cell+analyses+Dumitrascu+2021 "Go to article in Google Scholar")

[^80]: 80.
- [View Article](https://doi.org/10.1093/bioinformatics/btaa690 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/32730566 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Discovering+a+sparse+set+of+pairwise+discriminating+features+in+high-dimensional+data+Melton+2021 "Go to article in Google Scholar")

[^81]: 81.
- [View Article](https://doi.org/10.1093/nar/gkw359 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/27131357 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=PHYLOViZ+Online%3A+web-based+tool+for+visualization%2C+phylogenetic+inference%2C+analysis+and+sharing+of+minimum+spanning+trees+Ribeiro-Gon%C3%A7alves+2016 "Go to article in Google Scholar")

[^82]: 82.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=SplitsTree+4.0-Computation+of+phylogenetic+trees+and+networks+Huson+2008 "Go to article in Google Scholar")

[^83]: 83.

[^84]: 84.
- [View Article](# "Go to article in CrossRef")
- [Google Scholar](http://scholar.google.com/scholar?q=qgraph%3A+Network+visualizations+of+relationships+in+psychometric+data+Epskamp+2012 "Go to article in Google Scholar")

[^85]: 85.
- [View Article](https://doi.org/10.1126/sciadv.abc4773 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/33148647 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=A+single-cell+analysis+of+the+molecular+lineage+of+chordate+embryogenesis+Zhang+2020 "Go to article in Google Scholar")

[^86]: 86.
- [View Article](https://doi.org/10.1101/2020.12.26.424452 "Go to article")
- [Google Scholar](http://scholar.google.com/scholar?q=Model-based+Trajectory+Inference+for+Single-Cell+RNA+Sequencing+Using+Deep+Learning+with+a+Mixture+Prior+Du+2020 "Go to article in Google Scholar")

[^87]: 87.
- [View Article](https://doi.org/10.1038/s41467-022-34857-7 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/36494337 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Interpretable+and+tractable+models+of+transcriptional+noise+for+the+rational+design+of+single-molecule+quantification+experiments+Gorin+2022 "Go to article in Google Scholar")

[^88]: 88.
- [View Article](https://doi.org/10.1038/s41592-023-01814-1 "Go to article")
- [PubMed/NCBI](http://www.ncbi.nlm.nih.gov/pubmed/37037999 "Go to article in PubMed")
- [Google Scholar](http://scholar.google.com/scholar?q=Comparison+of+transformations+for+single-cell+RNA-seq+data+Ahlmann-Eltze+2023 "Go to article in Google Scholar")

[^89]: 89.
- [View Article](https://doi.org/10.1101/2021.08.25.457696 "Go to article")
- [Google Scholar](http://scholar.google.com/scholar?q=The+Specious+Art+of+Single-Cell+Genomics+Chari+2021 "Go to article in Google Scholar")