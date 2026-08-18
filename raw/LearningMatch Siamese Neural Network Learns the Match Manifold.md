---
title: "LearningMatch: Siamese Neural Network Learns the Match Manifold"
source: "https://arxiv.org/html/2502.01361v1"
author:
published:
created: 2026-06-23
description:
tags:
  - "clippings"
---
Susanna Green Institute of Cosmology and Gravitation, University of Portsmouth, Portsmouth PO1 3FX, United Kingdom    Andrew Lundgren Catalan Institution for Research and Advanced Studies (ICREA), E-08010 Barcelona, Spain Institut de F´ısica d’Altes Energies (IFAE), The Barcelona Institute of Science and Technology, UAB Campus, E-08193 Barcelona, Spain Institute of Cosmology and Gravitation, University of Portsmouth, Portsmouth PO1 3FX, United Kingdom    Xan Morice-Atkinson Institute of Cosmology and Gravitation, University of Portsmouth, Portsmouth PO1 3FX, United Kingdom

###### Abstract

The match, which is defined as the the similarity between two waveform templates, is a fundamental calculation in computationally expensive gravitational-wave data-analysis pipelines, such as template bank generation. In this paper we introduce LearningMatch, a Siamese neural network that has learned the mapping between the parameters, specifically $\lambda_{0}$ (which is proportional to the chirp mass), $\eta$ (symmetric mass ratio), and equal aligned spin ($\chi_{1}$ = $\chi_{2}$), of two gravitational-wave templates and the match. The trained Siamese neural network, called LearningMatch, can predict the match to within $3.3\%$ of the actual match value. For match values greater than 0.95, a trained LearningMatch model can predict the match to within $1\%$ of the actual match value. LearningMatch can predict the match in 20 $\mu$ s (mean maximum value) with Graphical Processing Units (GPUs). LearningMatch is 3 orders of magnitudes faster at determining the match than current standard mathematical calculations that involve the template being generated.

## I Introduction

Since the first neural network architecture in the 1970’s, many neural network models have been designed to tackle various problems and data sets such as LeNet-5, AlexNet, and ChatGPT [^1] [^2] [^3] [^4] [^5]. Neural networks have a unique property in which they are able to approximate any continuous function in 2 layers which is called the universal approximation theorem [^6]. This property and the fact that neural networks can now be trained in a reasonable amount of time due to the back propagation algorithm and readily available Graphical Processing Units (GPU), has led to neural networks being utilised in a variety of fields including gravitational-wave data analysis [^7].

The use of machine learning algorithms in gravitational-wave astronomy was originally suggested in 2006 [^8]. In recent years, neural networks have been widely applied to a variety of problems in the gravitational-wave community: from fast parameter estimation [^9] [^10] [^11] [^12] [^13] [^14] [^15] to solving the Teukolsky equation [^16], from categorising noise [^17] [^18] [^19] [^20] [^21] to waveform modelling [^22] [^23] [^24], from searching for exotic gravitational wave signals [^25] [^26] [^27] [^28] [^29] [^30] [^31] [^32] to confirming evidence of precession in current events [^33]. In this research we introduce a type of neural network, called a Siamese neural network, to the gravitational-wave community [^34]. Siamese neural networks were originally used to verify signatures and since then have been applied to a variety of problems that require a similarity metric to be learned, for example face verification [^35] [^36]. This neural network architecture has been designed to learn the ‘similarity’ in data and for this reason we have used it to learn the similarity between two gravitational-wave templates, otherwise known as the match [^37]. Similar research has been conducted using neural networks to predict the mismatch for the optimisation of numerical relativity simulations placement [^38]. The aim of this research is to design a Siamese neural network that could be integrated into gravitational-wave data analysis pipelines, because many of these algorithms are computationally expensive with regards to time taken and computational hardware [^39].

Over 90 gravitational-wave events have been observed since the first binary black hole merger in 2015 by LIGO, Virgo, and KAGRA [^40] [^41] [^42] [^43]. These gravitational waves have been from a variety of astrophysical sources including an asymmetric binary black hole merger, an intermediate-mass black hole inspiral, and neutron star-black hole candidates [^44] [^45] [^46]. Many of these gravitational-wave events have been extracted from the interferometric strain data using template banks [^47] [^48] [^49] [^50] [^51]. Template banks are a catalogue of waveform models (i.e. templates) with different parameters that approximate the actual gravitational wave signal [^47] [^52]. Template banks are computationally expensive to generate because the match is constantly being calculated in many template bank generation algorithms. For future gravitational-wave detectors, template bank generation is going to be unfeasible because the templates are of the order of hours or days in length and therefore the match calculation is going to be a computationally intensive [^53].

In this paper, we introduce a Siamese neural network called LearningMatch, that has learned the match between two templates and therefore has the potential to be integrated into template bank generation algorithms. This paper is organised as follows. In Section II the match is explained while in Section 10 we describe a Siamese neural network that is required to predict the match. The accuracy of LearningMatch is showcased in Section 10 with potential applications of LearningMatch highlighted in Section V. This research will then be summarised in section VI. All the code will be open source and accessed at [https://github.com/SusannaGreen/LearningMatch](https://github.com/SusannaGreen/LearningMatch). The datasets for this research can be accessed on Zenodo [^54].

## II The Match

![Refer to caption](https://arxiv.org/html/2502.01361v1/extracted/6174772/MatchManifold.png)

Figure 1: A schematic diagram of the match manifold between two gravitational wave templates. The black dots represent an equal change in a parameter, for example mass, of a binary black hole merger. The distance between these black dots represents the match. The arrows highlight the fact that when a parameter is changed equally, the distance varies depending where it is on the match manifold. In binary black hole mergers when the mass is changed by the same amount, the match changes drastically in the low mass regions compared to the high mass regions.

The match is defined as the weighted inner product between two gravitational-wave templates [^37]. Gravitational wave signals emitted by mergers of compact objects, such as binary black holes, are modelled by templates. Templates are generated by dividing the gravitational-wave signal into three phases (specifically inspiral, merger, and the ringdown) because the physics used to explain a coalescing compact binary is different at each stage. In the inspiral phase, a stationary phase approximation is used and the gravitational signal, h(f), is described by

$$
h(f)=A(f)e^{i\Psi(f)},
$$

where $\Psi(f)$ is the phase of the coalescing compact binary and A(f) is defined as,

$$
A(f)=\sqrt{\frac{5}{24}}\frac{\mathcal{M}_{c}^{-5/3}}{\pi^{2/3}D}f^{-7/6},
$$

to leading order (D is the distance, $\mathcal{M}$ is the chirp mass (see equation 9) and f is the frequency) [^55]. In Equation 1, the phase, $\Psi(f)$, is defined as as

$$
\displaystyle\Psi(f)=2\pi t_{c}f-\phi_{c}-\pi/4+\sum_{j=0}^{7}\psi_{\frac{j}{2%
}PN}f^{(-5+j)/3}
$$
 
$$
\displaystyle+\sum_{j=5}^{6}\psi^{l}_{\frac{j}{2}PN}ln(f)f^{(-5+j)/3},
$$

to 3.5 Post-Netwonian order. The Post-Newtonian (PN) approximation is used to model the coalescing compact binaries because it is assumed they are in a circular orbit, point masses and orbiting slowly so a velocity expansion can be used [^56] [^57]. The two terms, $\psi_{\frac{j}{2}PN}$ and $\psi^{l}_{\frac{j}{2}PN}$ are defined as,

$$
\psi_{0}=\frac{3}{128}\pi^{5/3}\mathcal{M}_{c}^{5/3},
$$

to first-order expansion (see reference for more detail) [^55]. So far, the inspiral phase of a compact binary merger has been discussed. The second phase, the merger, is modelled using numerical integration or interpolating between the inspiral and ringdown. The ringdown is modelled as a rotating black hole, see references for more information [^58] [^59]. All three phases are then combined to form the gravitational-wave templates, such as IMRPhenomXAS, used by the gravitational-wave community [^60].

Templates that model compact binary coalescence are modelled by 15 parameters (where eccentricity is negligible) which can be decomposed in two categories: extrinsic and intrinsic parameters [^61]. The intrinsic parameters, $\theta$ (which includes the mass and spin of the two bodies), impact the actual shape of the waveform. The extrinsic parameters, $\phi_{c}$ and $t_{c}$ (phase and time of coalescence respectively), affect the amplitude and phase of the waveform. The ambiguity function measures how distinguishable two waveforms are, $h(\lambda)$ and $s(\Lambda)$, in the absence of any noise and is expressed as the inner product

$$
A(\lambda,\Lambda)=(h(\lambda)|s(\Lambda)),
$$

where $\lambda$ and $\Lambda$ are the parameter vectors of the template and signal respectively [^62].

$\lambda=(\phi_{c},t_{c},\theta)$ can be further divided into intrinsic parameters, $\theta$, and extrinsic parameters, $\phi_{c},t_{c}$. In the context of searching for gravitational wave signals, the ambiguity function needs to be modified so that it is independent of the extrinsic parameters. So the match is defined as the inner product maximised over the time of coalescence and phase of the waveform and can be expressed as

$$
\mathcal{M}(h_{1},h_{2})=\max_{\phi_{c},t_{c}}(h_{1}|h_{2}),
$$

where the inner product is defined as

$$
(h_{1}|h_{2})=4\Re\int_{0}^{\infty}\frac{\tilde{h}_{1}^{*}(f)\tilde{h}_{2}(f)}%
{S_{h}(\textit{f})}df,
$$

$S_{h}(\textit{f}$) is the one-sided noise power spectral density (PSD) while $h_{1}$ and $h_{2}$ are the two gravitational wave templates with unit norm [^63]. The noise observed in a gravitational wave detector is modelled as stationary which means that the frequencies are independent and therefore the one-sided noise power spectral density, $S_{n}(f)$, can be defined as

$$
\langle\tilde{n}^{*}(f)\tilde{n}(f^{\prime})\rangle=\delta(f-f^{\prime})\frac{%
1}{2}{S_{n}(\textit{f})},
$$

where $\tilde{n}(f)$ is defined as the Fourier transformed detector noise in the frequency domain and $\tilde{n}*(f)$ is the complex conjugate. Equation 5 can intuitively be described as how similar two gravitational-wave templates are. If the two templates have similar parameters (i.e. almost equivalent mass and spins) then it is a strong match, $\sim 1$ because the templates are almost identical. Whereas, if the two templates have very different parameters then it is a weak match, $\sim 0$. The mapping between the intrinsic parameters of a compact binary merger and the match value can be described a manifold, which in this research has been called the match manifold [^37]. The match manifold is a continuous manifold but it’s sensitivity to different intrinsic parameters varies. In the low mass regions of binary black hole mergers, small changes in the mass result in significant changes in the calculated match value. In contrast, in the high mass regions of binary black hole mergers, small changes in the mass result in insignificant changes in the calculated match value. This behaviour of the match manifold can be depicted in Figure 1 and is the reason why template banks contain lots of templates in the low mass region compared to the high mass regions

## III LearningMatch

![Refer to caption](https://arxiv.org/html/2502.01361v1/extracted/6174772/match_error_histogram_equal.png)

Figure 2: A histogram of matches in the training dataset. The diffused dataset resulted in higher match values compared to the normal dataset.

![Refer to caption](https://arxiv.org/html/2502.01361v1/extracted/6174772/LossCurveDatasets.png)

Figure 3: The training loss curves of the same LearningMatch model with three different sized training datasets.

![Refer to caption](https://arxiv.org/html/2502.01361v1/extracted/6174772/LearningMatchArchitecture.png)

Figure 4: A schematic diagram of LearningMatch’s architecture. The embedding layers are used to embed the parameters of a gravitational-wave template into a space that is easier to learn. The output of the embedding layers is then subtracted from each other and squared. This is then combined with the average of the original parameters of the gravitational-wave template (4 additional dimensions) to become the input for the crunch layers. The output of the crunch layer is the match. A Rectified Linear Unit activation function was used between each layer and has been omitted for clarity 64.

![Refer to caption](https://arxiv.org/html/2502.01361v1/extracted/6174772/LossCurveModel1.png)

Figure 5: The training loss of the same LearningMatch model with different depths of the embedding layer.

![Refer to caption](https://arxiv.org/html/2502.01361v1/extracted/6174772/LossCurveModel2.png)

Figure 6: The training loss curves of the same LearningMatch model with varying depths of the crunch layer.

![Refer to caption](https://arxiv.org/html/2502.01361v1/extracted/6174772/MassEqualSpinLossCurve.png)

Figure 7: The training and validation loss curves for the LearningModel, described in this paper, that was trained on the equal aligned spin dataset.

### III.1 The Dataset

LearningMatch is a Siamese neural network that has learned the mapping between the parameters of two binary black hole templates and the match, therefore replacing Equation 5 (see Section II for more information). The dataset was created using PyCBC, which generates the two templates with different parameters and then calculates the match between them using the standard mathematical procedure outlined in Section II [^65]. A simulated PSD representative of the third observing run was used and accessed using PyCBC (called aLIGO140MpcT1800545 in the software package) [^66]. A sample frequency of 2048 Hz, signal duration of 32 s, and a low frequency cut-off of 15 Hz was used to generate the PSD. This PSD was reasonably representative of the detector when this paper was written. The template family used in this research was ‘IMRPhenomXAS’ [^60] and the match was generated with a low frequency cut-off of 18 Hz. The template parameters used to train LearningMatch were $\lambda_{0}$ (which is proportional to the chirp mass), $\eta$ (symmetric mass ratio), and equal aligned spin ($\chi_{1}$ = $\chi_{2}$). $\lambda_{0}$ is defined as

$$
\lambda_{0}=\left(\frac{\mathcal{M}_{c}}{\mathcal{M}_{c_{ref}}}\right)^{-5/3},
$$

where $\mathcal{M}$ is the chirp mass and $\mathcal{M}_{ref}$ is reference chirp mass. $\mathcal{M}_{c}$ is called the chirp mass and can be expressed as

$$
\mathcal{M}_{c}=\frac{(m_{1}m_{2})^{3/5}}{(m_{1}+m_{2})^{1/5}},
$$

where $m_{1}$ and $m_{2}$ are the mass of the two black holes. $\mathcal{M}_{ref}$ was predefined to be 5 $M_{\odot}$ so that $\lambda_{0}$ ranged between 0-1. This range is preferred when training neural networks because it results in the gradients being constrained in backpropagation, an algorithm used to train neural networks [^67] [^68]. $\mathcal{M}_{c}$ varied between $5M_{\odot}$ and $20M_{\odot}$ which corresponds to $\lambda_{0}$ varying between 0.006 and 1.4. $\eta$ is called the symmetric mass ratio which can be expressed as $\eta=\frac{m_{1}m_{2}}{(m_{1}+m_{2})^{2}}$ and varied between 0.1 and 0.24999. In this mass range, the Siamese neural networks learned $\lambda_{0}$ and $\eta$ the best compared to other mass parameters because $\lambda_{0}$ smooths out the low chirp mass regions. As described in Section II, the match manifold changes significantly in the low mass regions and therefore the Siamese neural network is required to learn these details well. However, research has shown that neural networks in general struggle in learning details in data and therefore $\lambda_{0}$ was used to enable the Siamese neural network to learn the low chirp mass region well [^69] [^70]. Equal aligned spin that varied between -0.99 and 0.99 was used in this research because the accuracy desired could not be achieved using random aligned spin ($\chi_{1}\neq\chi_{2}$). This will be discussed further in Section V.

Two methods were used to generate the datasets required to train LearningMatch. The first method chose $\lambda_{0}$, $\eta$ and equal aligned spin parameters from a uniform distribution for both templates and then the match was calculated between these templates. The second method generated a template with $\lambda_{0}$, $\eta$ and equal aligned spin chosen from a uniform distribution. Then the other template was generated using $\lambda_{0}$, $\eta$ and equal aligned spin at different standard deviations. The standard deviations used for the second template were $\lambda_{0}=0.0001$, $\eta=0.01$, and $\chi_{1}=\chi_{2}=0.01$ and $\lambda_{0}=0.001$, $\eta=0.01$, and $\chi_{1}=\chi_{2}=0.01$ and $\lambda_{0}=0.001$, $\eta=0.02$, and $\chi_{1}=\chi_{2}=0.01$. These standard deviations were determined using empirical tuning to identify which combination produced the largest number of match values close to 1. This dataset was called the diffused dataset because for each template that had parameters chosen from a uniform distribution, three templates were chosen nearby with different standard deviation combinations. The diffused dataset resulted in a dataset that focused on the match values near one, see Figure 2. Both methods were used to generate the training, validation and test dataset. The first method was used to create datasets of the order of 1 million (training dataset), 100,000 (validation dataset), 100,000 (test dataset) in size. The second method was used to create datasets of the order of 1.5 million (training dataset), 150,000 (validation dataset), 150,000 (test dataset) in size. These two methods were then combined to create the training, validation and test datasets that consist of 2.5 million, 250,000, and 250,000 data points, respectively. It was concluded that 2.5 million data points were required to train the LearningMatch to the desired accuracy, see Figure 3. The datasets for this research can be accessed on Zenodo [^54].

### III.2 The Architecture

Siamese neural networks consist of two subnetworks that that get combined in a final output neural network. In LearningMatch the subnetworks were called the Embedding Layers because they were used to transform the template parameters, see Figure 4 for more detail. Whilst the final output of the neural network was called the Crunch Layers because this would be used to determine the match. $\lambda_{0}$, $\eta$ and equal aligned spin (i.e. $\chi_{1}$ = $\chi_{2}$) of both templates are used as the input to the Embedding Layers. The output of the Embedding Layers is then combined with the difference between template parameters squared and the average of all the template parameters. The output of the Embedding Layers, the difference squared, and the average is used as the input for the Crunch Layers. The reason for using the difference squared is to emphasise the fact that when the template parameters are similar, the match is close to 1. The average is used to enable the neural network to learn the relative position of the templates on the match manifold. The Embedding Layers consist of 4 layers of 1024 neurons, and the Crunch Layers consist of 5 layers of 1024 neurons. Rectified Linear Unit (ReLU) activation functions are used between each layer of the Embedding Layers and Crunch Layers [^71] [^64]. ReLU was used because it performed the best compared to other activation functions (activation functions help neural networks to learn by adding non-linearity into the training process). A Linear layer is used for the final layer in both Embedding Layers and Crunch Layers. The architecture of LearningMatch was determined by trial and error. We found that the depth of the Embedding Layers did not have a significant impact on the accuracy of LearningMatch, see Figure 5. We also found that 5 layers in the Crunch Layers was the best depth because LearningMatch’s performance did not improve significantly with 6 layers, see Figure 6. Additional layers in the LearningMatch model results in an increased time to predict the match. Various experiments were conducted using different neural network architectures and the one presented in this paper was determined to be the fastest and the most accurate.

### III.3 The Training

LearningMatch required 5000 epochs to train which took approximately 31 hours on a A100 GPU using PyTorch [^72]. The mean squared error was chosen as most appropriate loss function because predicting the match can be viewed as a simple regression problem, where the actual match calculated using Equation 5, $\mathcal{M}_{actual}$, is compared with the match predicted by the Siamese neural network, $\mathcal{M}_{predicted}$. The mean squared error was used to determine the accuracy of this prediction and is defined as

$$
MSE=\frac{1}{n}\sum^{n}_{i=1}(\mathcal{M}_{actual}-\mathcal{M}_{predicted})^{2},
$$

where n is the number of data points. An Adam optimiser with an initial learning rate of $10^{-6}$ was then used to minimise the loss function and update the parameters in the Siamese neural network [^73]. A batch size of 1024 was used on the training and validation datasets due to the size of the datasets. During the training process, it was noted that LearningMatch never overtrained given the large number of epochs. 5000 epochs were sufficient to train LearningMatch without the model becoming overtrained. Overtraining would result in the Siamese neural network memorising the data and therefore would not be able to predict the match well on unseen data, otherwise known as generalisation. As shown in Figure 7, the training and the validation loss curves do not significantly separate which is a typical characteristic of an overtrained model.

## IV Results

![Refer to caption](https://arxiv.org/html/2502.01361v1/extracted/6174772/MassEqualActualPredicted.png)

Figure 8: The comparison between the actual match, which was calculated using the mathematical procedure outlined in section II, and the predicted match, which is the match determined by LearningMatch, using an unseen test dataset. The error is defined as the difference between the actual match and the predicted match.

![Refer to caption](https://arxiv.org/html/2502.01361v1/extracted/6174772/MassEqualSpinError.png)

Figure 9: The error distribution for LearningMatch on a unseen test dataset. The error is defined as the actual match (calculated using mathematical methods) subtracted from the match predicted by the Siamese neural network. Due to the potential application of LearningMatch, the actual match values greater than 0.95 were highlighted in this plot to showcase the accuracy in this region.

![Refer to caption](https://arxiv.org/html/2502.01361v1/extracted/6174772/Batch_curve.png)

Figure 10: The time taken for LearningMatch to predict the match depending on the batch size. The larger the batch size, the more times the match is predicted. However, the time taken to predict a single match is reduced.

A trained LearningMatch can predict the match to within $3.3\%$ of the actual match value, determined by standard mathematical calculations defined in Section II. As shown in Figure 8, LearningMatch has learned this accuracy for the entire match manifold. For actual match values greater than 0.95, a trained LearningMatch model can predict the match to within $1\%$ of the actual match value, as summarised in Figure 9. The accuracy in this region (match values greater than 0.95) is important because of the potential applications of LearningMatch which are discussed in Section V. Using PyCBC, an open source gravitational-wave software, the match can be calculated in 40 ms on a single CPU core. PyCBC uses the standard mathematical procedures described in Section II to calculate the match, which involve templates being generated and then the match being calculated. LearningMatch can predict the match in 20 $\mu s$ (mean maximum value) on a single A100 GPU, see Figure 10. Therefore, LearningMatch is at least 3 orders of magnitude faster at predicting the match than standard mathematical procedures.

## V Discussion

LearningMatch is a Siamese neural network that can predict the match to within $3.3\%$ of the actual match value, as seen in Figure 8. For match values greater than 0.95, LearningMatch can predict the match to within $1\%$ of the actual match value which is shown in Figure 9. The match can be predicted by LearningMatch in 20 $\mu$ (mean maximum value) on a single A100 GPU. Whereas, PyCBC can calculate the match using standard mathematical procedures (which involve generating two gravitational-wave templates and then calculating the match between them) in 40 ms on a single CPU core. Therefore, LearningMatch is at least 3 orders of magnitude faster at determining the match than current calculations however, this number does exclude the 2 days required to train LearningMatch on a single A100 GPU. LearningMatch is not a computationally feasible option when only one or two calculations of the match are needed. However, LearningMatch is computationally feasible when lots of match calculations are required because the time taken for a single match calculation is reduced with larger number of match calculations, as shown in Figure 10. Speed and accuracy were the main objectives of this research so that LearningMatch could be integrated into gravitational-wave data-analysis pipelines that require a lot of match calculations, such as template bank generation.

The match is can be computationally expensive when the gravitational-wave templates are computationally expensive to generate. In this research, a Siamese neural network is used to surpass template generation and predict the match. Template banks are used to detect the gravitational-wave signal from the interferometric strain data using matched-filtering techniques [^47] [^48] [^49] [^50] [^51] [^74]. There are various ways of generating template bank, with geometric and stochastic algorithms being most favoured by the literature [^75] [^76] [^77] [^78] [^79] [^80]. In the stochastic algorithm, a template with new parameters is proposed and the match is computed with all the templates already in the template bank; if the match is greater than 0.97 the template is accepted into the bank. LearningMatch could be integrated into this algorithm to speed up the match computation and therefore the time required to generate a template bank could be significantly reduced. LearningMatch learned a specific black hole mass range and equal aligned spin therefore this LearningMatch model could only generate template banks that could identify binary black hole mergers [^81]. This work could be extended to explore how well LearningMatch learns other mass ranges, such as the binary neutron star mass range.

During our research, the mass range had to be constrained because LearningMatch failed to learn the higher mass regions. This is because $\lambda_{0}$ is a parameter that results in the templates being more uniformly spaced in mass and when the training datasets are generated using a uniform distribution in $\lambda_{0}$, the high-mass regions contained too few data points. We tried generating the training datasets using a $m_{1}$ and $m_{2}$ mass parameterisation but, the lower mass regions then contained too few data points. This is a limitation of LearningMatch because different parameters will be required to learn different areas in the mass regions. Otherwise, more research will be required to identify the correct parametrisation of the template parameters. Hypothetically, LearningMatch could also be used to learn more complicated match manifolds, such as precessing and eccentric compact binary mergers but this will require thorough scrutiny to make sure the entire manifold has been learned [^82] [^83] [^84] [^85] [^86] [^87] [^88].

This work could be extended so that LearningMatch learns the mapping between $\lambda_{0}$, $\eta$, and random aligned spin ($\chi_{1}$ $\neq$ $\chi_{2}$) and the match. Initially in this research we tried to get LearningMatch to learn this match manifold but the Siamese neural network did not learn the entire match manifold. Some areas of the match manifold were learned to a lesser degree of accuracy than desired (or not at all). If future work modified the Siamese neural network presented in this paper so that the accuracy could be achieved, this LearningMatch model could be integrated into the Markov Chain Monte Carlo methods and therefore speed up gravitational-wave parameter estimation pipelines [^89] [^90] [^91] [^92]. Markov Chain Monte Carlo methods are used to recover the parameters of the gravitational wave once the gravitational-wave signal has been identified [^89] [^90] [^91] [^92]. LearningMatch could be used to predict the match of two gravitational-wave templates in the Markov Chain Monte Carlo method which would make proposed steps more efficient. LearningMatch integrated into Markov Chain Monte Carlo methods could be particularly useful for third generation detectors where template generation is computationally expensive for certain gravitational-wave sources [^53].

## VI Conclusions

LearningMatch is a Siamese neural network that has learned the match manifold. The match is defined as how similar two gravitational-wave templates are with different parameters and can be calculated using the standard definition outlined in Section II. LearningMatch learned the mapping between $\lambda_{0}$, $\eta$ and equal aligned spin ($\chi_{1}$ = $\chi_{2}$) of two gravitational-wave templates and the match. We showed that LearningMatch can predict the match to within $3.3\%$ of the actual match value (i.e. the match value calculated using standard definitions). For match values greater than 0.95, LearningMatch can predict the match to within $1\%$ of the actual match value. We also showed that LearningMatch is 3 orders of magnitude faster at predicting the match between two gravitational-wave templates compared current calculations used in the gravitational-wave community. LearningMatch was designed to be integrated into gravitational-wave data-analysis pipelines that require lots of match calculations, such as template bank generation, so speed and accuracy were the main objectives in this research.

Template banks are used to identify potential gravitational-wave signals in the interferometric strain data by matched-filtering. Template banks for binary black hole mergers are generated using equal aligned spin to reduce the computational cost of matched-filtering. An equal aligned spin LearningMatch model could be integrated into a stochastic template bank generation algorithm and therefore a template bank could be generated quickly. This research could be extended to learn the mapping between the $\lambda_{0}$, $\eta$ and random aligned spin ($\chi_{1}\neq\chi_{2}$). We initially tried to get a Siamese neural network to learn this match manifold but the desired accuracy of approx. $1\%$ could not be achieved. A LearningMatch model trained on random aligned spins could be integrated into a Markov Chain Monte Carlo method as a fast algorithm to reject suggested proposals (or conversely suggest new proposals). This would result in more efficient sampling of gravitational-wave data and therefore reduce the time taken to recover the gravitational-wave parameters. In theory, LearningMatch has the potential to learn the match manifold of other gravitational-wave sources, such as binary neutron star mergers, and more complicated match manifolds, such as precessing compact binary mergers. This would mean that our understanding of gravitational-wave sources could be extended. LearningMatch could also be integrated into the data-analysis pipelines for future gravitational-wave detectors. In this paper we explored the feasibility of replacing a mathematical equation with a neural network and this idea could also be applied to other areas gravitational-wave data-analysis pipelines.

###### Acknowledgements.

Thank you to Laura Nuttall and Ian Harry for their useful comments. Susanna Green was supported by a STFC studentship and the University of Portsmouth. Andrew Lundgren acknowledges the support of UKRI through grants ST/V005715/1 and ST/Y004280/1. Xan Morice-Atkinson acknowledges the support of UKRI through grants ST/V005715/1 and ST/Y004280/1. Numerical computations were done on the Sciama High Performance Compute (HPC) cluster which is supported by the ICG, SEPNet and the University of Portsmouth. This paper has been assigned document number LIGO-P2500007.

[^1]: K. Fukushima, Neocognitron: A self-organizing neural network model for a mechanism of pattern recognition unaffected by shift in position, Biological Cybernetics 36, [10.1007/BF00344251](https://doi.org/10.1007/BF00344251) (1980).

[^2]: K. Fukushima and N. Wake, Handwritten alphanumeric character recognition by the neocognitron, IEEE Transactions on Neural Networks 2, [10.1109/72.97912](https://doi.org/10.1109/72.97912) (1991).

[^3]: Y. LeCun, L. Bottou, Y. Bengio, and P. Haffner, Gradient-based learning applied to document recognition, Proceedings of the IEEE 86, [10.1109/5.726791](https://doi.org/10.1109/5.726791) (1998).

[^4]: A. Krizhevsky, I. Sutskever, and G. E. Hinton, Imagenet classification with deep convolutional neural networks, Communications of the ACM 60, [10.1145/3065386](https://doi.org/10.1145/3065386) (2017).

[^5]: OpenAI, Gpt-4 technical report (2023).

[^6]: G. Cybenko, Approximation by superpositions of a sigmoidal function, Mathematics of Control, Signals, and Systems 2, [10.1007/BF02551274](https://doi.org/10.1007/BF02551274) (1989).

[^7]: D. E. Rumelhart, G. E. Hinton, and R. J. Williams, Learning representations by back-propagating errors, Nature 323, [10.1038/323533a0](https://doi.org/10.1038/323533a0) (1986).

[^8]: M. Lightman, J. Thurakal, J. Dwyer, R. Grossman, P. Kalmus, L. Matone, J. Rollins, S. Zairis, and S. Márka, Prospects of gravitational wave data mining and exploration via evolutionary computing, in [*Journal of Physics: Conference Series*](https://doi.org/10.1088/1742-6596/32/1/010), Vol. 32 (2006).

[^9]: M. Andrés-Carcasona, M. Martínez, and L. M. Mir, Fast bayesian gravitational wave parameter estimation using convolutional neural networks, Monthly Notices of the Royal Astronomical Society 527, [10.1093/mnras/stad3448](https://doi.org/10.1093/mnras/stad3448) (2024).

[^10]: M. Dax, S. R. Green, J. Gair, J. H. Macke, A. Buonanno, and B. Schölkopf, Real-time gravitational wave science with neural posterior estimation, Physical Review Letters 127, [10.1103/PhysRevLett.127.241103](https://doi.org/10.1103/PhysRevLett.127.241103) (2021).

[^11]: A. McLeod, D. Jacobs, C. Chatterjee, L. Wen, and F. Panther, Rapid mass parameter estimation of binary black hole coalescences using deep learning, arXiv e-prints (2022).

[^12]: H. Gabbard, C. Messenger, I. S. Heng, F. Tonolini, and R. Murray-Smith, Bayesian parameter estimation using conditional variational autoencoders for gravitational-wave astronomy, Nature Physics 18, [10.1038/s41567-021-01425-7](https://doi.org/10.1038/s41567-021-01425-7) (2022).

[^13]: S. R. Green and J. Gair, Complete parameter inference for gw150914 using deep learning, Machine Learning: Science and Technology 2, [10.1088/2632-2153/abfaed](https://doi.org/10.1088/2632-2153/abfaed) (2021).

[^14]: A. J. Chua and M. Vallisneri, Learning bayesian posteriors with neural networks for gravitational-wave inference, Physical Review Letters 124, [10.1103/PhysRevLett.124.041102](https://doi.org/10.1103/PhysRevLett.124.041102) (2020).

[^15]: D. George and E. A. Huerta, Deep learning for real-time gravitational wave detection and parameter estimation: Results with advanced ligo data, Physics Letters, Section B: Nuclear, Elementary Particle and High-Energy Physics 778, [10.1016/j.physletb.2017.12.053](https://doi.org/10.1016/j.physletb.2017.12.053) (2018).

[^16]: R. Luna, J. Calderón Bustillo, J. J. Seoane Martínez, A. Torres-Forné, and J. A. Font, Solving the teukolsky equation with physics-informed neural networks, Physical Review D 107, [10.1103/PhysRevD.107.064025](https://doi.org/10.1103/PhysRevD.107.064025) (2023).

[^17]: S. Álvarez-López, A. Liyanage, J. Ding, R. Ng, and J. McIver, Gspynettree: a signal-vs-glitch classifier for gravitational-wave event candidates, Classical and Quantum Gravity 41, [10.1088/1361-6382/ad2194](https://doi.org/10.1088/1361-6382/ad2194) (2024).

[^18]: T. Fernandes, S. Vieira, A. Onofre, J. Calderón Bustillo, A. Torres-Forné, and J. A. Font, Convolutional neural networks for the classification of glitches in gravitational-wave data streams, Classical and Quantum Gravity 40, [10.1088/1361-6382/acf26c](https://doi.org/10.1088/1361-6382/acf26c) (2023).

[^19]: M. Razzano and E. Cuoco, Image-based deep learning for classification of noise transients in gravitational wave detectors, Classical and Quantum Gravity 35, [10.1088/1361-6382/aab793](https://doi.org/10.1088/1361-6382/aab793) (2018).

[^20]: S. Bahaadini, N. Rohani, S. Coughlin, M. Zevin, V. Kalogera, and A. K. Katsaggelos, Deep multi-view models for glitch classification, in [*ICASSP, IEEE International Conference on Acoustics, Speech and Signal Processing - Proceedings*](https://doi.org/10.1109/ICASSP.2017.7952693) (2017).

[^21]: M. Zevin, S. Coughlin, S. Bahaadini, E. Besler, N. Rohani, S. Allen, M. Cabero, K. Crowston, A. K. Katsaggelos, S. L. Larson, T. K. Lee, C. Lintott, T. B. Littenberg, A. Lundgren, C. Osterlund, J. R. Smith, L. Trouille, and V. Kalogera, Gravity spy: Integrating advanced ligo detector characterization, machine learning, and citizen science, Classical and Quantum Gravity 34, [10.1088/1361-6382/aa5cea](https://doi.org/10.1088/1361-6382/aa5cea) (2017).

[^22]: R. Luna, M. Llorens-Monteagudo, A. Lorenzo-Medina, J. C. Bustillo, N. Sanchis-Gual, A. Torres-Forné, J. A. Font, C. A. R. Herdeiro, and E. Radu, Numerical relativity surrogate models for exotic compact objects: the case of head-on mergers of equal-mass proca stars (2024).

[^23]: L. M. Thomas, G. Pratten, and P. Schmidt, Accelerating multimodal gravitational waveforms from precessing compact binaries with artificial neural networks, Physical Review D 106, [10.1103/PhysRevD.106.104029](https://doi.org/10.1103/PhysRevD.106.104029) (2022).

[^24]: F. F. Freitas, C. A. R. Herdeiro, A. P. Morais, A. Onofre, R. Pasechnik, E. Radu, N. Sanchis-Gual, and R. Santos, Generating gravitational waveform libraries of exotic compact binaries with deep learning (2022).

[^25]: C. Verma, A. Reza, G. Gaur, D. Krishnaswamy, and S. Caudill, Detection of gravitational wave signals from precessing binary black hole systems using convolutional neural network (2022).

[^26]: F. Attadio, L. Ricca, M. Serra, C. Palomba, P. Astone, S. Dall’Osso, S. D. Pra, S. D’Antonio, M. Di Giovanni, and et al., A neural networks method to search for long transient gravitational waves (2024).

[^27]: A. Ravichandran, A. Vijaykumar, S. J. Kapadia, and P. Kumar, Rapid identification and classification of eccentric gravitational wave inspirals with machine learning (2023).

[^28]: R. Qiu, P. G. Krastev, K. Gill, and E. Berger, Deep learning detection and classification of gravitational waves from neutron star-black hole mergers, Physics Letters, Section B: Nuclear, Elementary Particle and High-Energy Physics 840, [10.1016/j.physletb.2023.137850](https://doi.org/10.1016/j.physletb.2023.137850) (2023).

[^29]: A. Iess, E. Cuoco, F. Morawski, C. Nicolaou, and O. Lahav, Lstm and cnn application for core-collapse supernova search in gravitational wave real data, Astronomy and Astrophysics 669, [10.1051/0004-6361/202142525](https://doi.org/10.1051/0004-6361/202142525) (2023).

[^30]: G. Morrás, J. García-Bellido, and S. Nesseris, Search for black hole hyperbolic encounters with gravitational wave detectors, Physics of the Dark Universe 35, [10.1016/j.dark.2021.100932](https://doi.org/10.1016/j.dark.2021.100932) (2022).

[^31]: A. Iess, E. Cuoco, F. Morawski, and J. Powell, Core-collapse supernova gravitational-wave search and deep learning classification, Machine Learning: Science and Technology 1, [10.1088/2632-2153/ab7d31](https://doi.org/10.1088/2632-2153/ab7d31) (2020).

[^32]: C. Dreissigacker and R. Prix, Deep-learning continuous gravitational waves: Multiple detectors and realistic noise, Physical Review D 102, [10.1103/PhysRevD.102.022005](https://doi.org/10.1103/PhysRevD.102.022005) (2020).

[^33]: R. Macas, A. Lundgren, and G. Ashton, Revisiting the evidence for precession in gw200129 with machine learning noise mitigation, Phys. Rev. D 109 (2024).

[^34]: S. B. J, A friendly introduction to siamese networks, Medium (2020).

[^35]: J. Bromley, I. Guyon, Y. LeCun, E. Säckinger, and R. Shah, Signature verification using a ’siamese’ time dleay neural network, Advances in Neural Information Processing Systems 6 (1994).

[^36]: S. Chopra, R. Hadsell, and Y. LeCun, Learning a similarity metric discriminatively, with application to face verification, in [*Proceedings - 2005 IEEE Computer Society Conference on Computer Vision and Pattern Recognition, CVPR 2005*](https://doi.org/10.1109/CVPR.2005.202), Vol. I (2005).

[^37]: B. J. Owen, Search templates for gravitational waves from inspiraling binaries: Choice of template spacing, [Phys. Rev. D 53, 6749 (1996)](https://doi.org/10.1103/PhysRevD.53.6749).

[^38]: D. Ferguson, Optimizing the placement of numerical relativity simulations using a mismatch predicting neural network, Physical Review D 107, [10.1103/physrevd.107.024034](https://doi.org/10.1103/physrevd.107.024034) (2023).

[^39]: N. Stergioulas, Machine learning applications in gravitational wave astronomy (2024).

[^40]: B. P. Abbott, R. Abbott, and et al., Gw150914: The advanced ligo detectors in the era of first discoveries, Phys.\\ Rev. Lett. 116 (2016).

[^41]: B. P. Abbott, R. Abbott, and et al., Gwtc-1: A gravitational-wave transient catalog of compact binary mergers observed by ligo and virgo during the first and second observing runs, Phys.\\ Rev. X 9 (2019).

[^42]: R. Abbott, T. D. Abbott, and et al., Gwtc-2: Compact binary coalescences observed by ligo and virgo during the first half of the third observing run, Phys.\\ Rev. X 11 (2021).

[^43]: B. P. Abbott, R. Abbott, and et al., Gwtc-3: Compact binary coalescences observed by ligo and virgo during the second part of the third observing run, Phys. Rev. X 13 (2023).

[^44]: B. P. Abbott, R. Abbott, and et al., Gw190412: Observation of a binary-black-hole coalescence with asymmetric masses, Phys.\\ Rev. D 102 (2020a).

[^45]: R. Abbott, T. D. Abbott, and et al., Gw190521: A binary black hole merger with a total mass of 150 $m\_{\\odot}$, Phys.\\ Rev. Lett. 125 (2020b).

[^46]: R. Abbott, T. D. Abbott, and et al., Gw190814: Gravitational waves from the coalescence of a 23 solar mass black hole with a 2.6 solar mass compact object, The Astrophysical Journal Letters 896 (2020c).

[^47]: B. Allen, Optimal template banks, Physical Review D 104, [10.1103/PhysRevD.104.042005](https://doi.org/10.1103/PhysRevD.104.042005) (2021).

[^48]: T. Adams, D. Buskulic, V. Germain, G. M. Guidi, F. Marion, M. Montani, B. Mours, F. Piergiovanni, and G. Wang, Low-latency analysis pipeline for compact binary coalescences in the advanced gravitational wave detector era, Classical and Quantum Gravity 33, [10.1088/0264-9381/33/17/175012](https://doi.org/10.1088/0264-9381/33/17/175012) (2016).

[^49]: S. A. Usman, A. H. Nitz, I. W. Harry, C. M. Biwer, D. A. Brown, M. Cabero, C. D. Capano, T. D. Canton, T. Dent, and et al., The pycbc search for gravitational waves from compact binary coalescence, Classical and Quantum Gravity 33, [10.1088/0264-9381/33/21/215004](https://doi.org/10.1088/0264-9381/33/21/215004) (2016).

[^50]: M. Kovalam, M. A. Kaium Patwary, A. K. Sreekumar, L. Wen, F. H. Panther, and Q. Chu, Early warnings of binary neutron star coalescence using the spiir search, The Astrophysical Journal Letters 927, [10.3847/2041-8213/ac5687](https://doi.org/10.3847/2041-8213/ac5687) (2022).

[^51]: S. Sakon, L. Tsukada, H. Fong, J. Kennington, W. Niu, C. Hanna, S. Adhicary, P. Baral, A. Baylor, and et al., Template bank for compact binary mergers in the fourth observing run of advanced ligo, advanced virgo, and kagra, Physical Review D 109, [10.1103/PhysRevD.109.044066](https://doi.org/10.1103/PhysRevD.109.044066) (2024).

[^52]: P. Ajith, S. Babak, Y. Chen, M. Hewitson, B. Krishnan, J. T. Whelan, B. Brügmann, P. Diener, J. Gonzalez, and et al., A phenomenological template family for black-hole coalescence waveforms, Classical and Quantum Gravity 24, [10.1088/0264-9381/24/19/S31](https://doi.org/10.1088/0264-9381/24/19/S31) (2007).

[^53]: A. K. Lenon, D. A. Brown, and A. H. Nitz, Eccentric binary neutron star search prospects for cosmic explorer, Physical Review D 104, [10.1103/PhysRevD.104.063011](https://doi.org/10.1103/PhysRevD.104.063011) (2021).

[^54]: S. Green, [Dataset for learningmatch: Siamese neural network learns the match manifold](https://doi.org/10.5281/zenodo.14773846) (2025).

[^55]: A. Buonanno, B. R. Iyer, E. Ochsner, Y. Pan, and B. S. Sathyaprakash, Comparison of post-newtonian templates for compact binary inspiral signals in gravitational-wave detectors, Physical Review D - Particles, Fields, Gravitation and Cosmology 80, [10.1103/PhysRevD.80.084043](https://doi.org/10.1103/PhysRevD.80.084043) (2009).

[^56]: S. Bernard, *A First Course in General Relativity* (Cambridge University Press, 2009) p. 291.

[^57]: E. Poisson and C. M. Will, Gravitational waves from inspiraling compact binaries: Parameter estimation using second-post-newtonian waveforms, Physical Review D 52, [10.1103/PhysRevD.52.848](https://doi.org/10.1103/PhysRevD.52.848) (1995).

[^58]: S. A. Teukolsky, Perturbations of a rotating black hole. i. fundamental equations for gravitational, electromagnetic, and neutrino-field perturbations, The Astrophysical Journal 185, [10.1086/152444](https://doi.org/10.1086/152444) (1973).

[^59]: S. A. Teukolsky and W. H. Press, Perturbations of a rotating black hole. iii - interaction of the hole with gravitational and electromagnetic radiation, The Astrophysical Journal 193, [10.1086/153180](https://doi.org/10.1086/153180) (1974).

[^60]: G. Pratten, S. Husa, C. García-Quirós, M. Colleoni, A. Ramos-Buades, H. Estellés, and R. Jaume, Setting the cornerstone for a family of models for gravitational waves from compact binaries: The dominant harmonic for nonprecessing quasicircular black holes, [Phys. Rev. D 102, 064001 (2020)](https://doi.org/10.1103/PhysRevD.102.064001).

[^61]: C. Cutler and I. E. Flanagan, Gravitational waves from merging compact binaries: How accurately can one extract the binary’s parameters from the inspiral waveform?, Physical Review D 49, [10.1103/PhysRevD.49.2658](https://doi.org/10.1103/PhysRevD.49.2658) (1994).

[^62]: B. S. Sathyaprakash, Matched filtering of gravitational waves from inspiraling compact binaries: Computational cost and template placement, Physical Review D - Particles, Fields, Gravitation and Cosmology 60, [10.1103/PhysRevD.60.022002](https://doi.org/10.1103/PhysRevD.60.022002) (1999).

[^63]: D. A. Brown, I. Harry, A. Lundgren, and A. H. Nitz, Detecting binary neutron star systems with spin in advanced gravitational-wave detectors, Physical Review D - Particles, Fields, Gravitation and Cosmology 86, [10.1103/PhysRevD.86.084017](https://doi.org/10.1103/PhysRevD.86.084017) (2012a).

[^64]: A. F. Agarap, Deep learning using rectified linear units (relu), arXiv preprint arXiv:1803.08375 (2018).

[^65]: A. Nitz, I. Harry, D. Brown, C. M. Biwer, J. Willis, T. Dal Canton, C. Capano, T. Dent, L. Pekowsky, and et al., (2024a).

[^66]: A. Nitz, I. Harry, C. M. Biwer, D. A. Brown, J. Willis, and T. D. Canton, [pycbc.psd package](https://pycbc.org/pycbc/latest/html/pycbc.psd.html) (2024b).

[^67]: J. Brownlee, [How to use data scaling improve deep learning model stability and performance](https://machinelearningmastery.com/how-to-improve-neural-network-stability-and-modeling-performance-with-data-scaling/) (2020).

[^68]: C. M. Bishop, *Neural Networks for Pattern Recognition* (Oxford University Press, 1996).

[^69]: N. Rahaman, A. Baratin, D. Arpit, F. Draxler, M. Lin, F. Hamprecht, Y. Bengio, and A. Courville, On the spectral bias of neural networks, in [*Proceedings of the 36th International Conference on Machine Learning*](https://proceedings.mlr.press/v97/rahaman19a.html), Proceedings of Machine Learning Research, Vol. 97, edited by K. Chaudhuri and R. Salakhutdinov (PMLR, 2019) pp. 5301–5310.

[^70]: N. Nagarajan and C. Messenger, [Identifying and mitigating machine learning biases for the gravitational-wave detection problem](https://arxiv.org/pdf/2501.13846) (2025).

[^71]: A. Householder, A theory of steady-state activity in nerve-fiber networks: I. definitions and preliminary lemmas., [Bulletin of Mathematical Biophysics, 63 (1941)](https://doi.org/10.1007/BF02478220).

[^72]: A. Paszke, S. Gross, F. Massa, A. Lerer, J. Bradbury, G. Chanan, T. Killeen, Z. Lin, N. Gimelshein, and et al., Pytorch: An imperative style, high-performance deep learning library, in [*Advances in Neural Information Processing Systems 32*](http://papers.neurips.cc/paper/9015-pytorch-an-imperative-style-high-performance-deep-learning-library.pdf) (Curran Associates, Inc., 2019) pp. 8024–8035.

[^73]: D. P. Kingma and J. Ba, Adam: A method for stochastic optimization, [CoRR abs/1412.6980 (2014)](https://api.semanticscholar.org/CorpusID:6628106).

[^74]: D. Mukherjee, S. Caudill, R. Magee, C. Messick, S. Privitera, S. Sachdev, K. Blackburn, P. Brady, and et al., Template bank for spinning compact binary mergers in the second observation run of advanced ligo and the first observation run of advanced virgo, [Phys. Rev. D 103, 084047 (2021)](https://doi.org/10.1103/PhysRevD.103.084047).

[^75]: J. Roulet, L. Dai, T. Venumadhav, B. Zackay, and M. Zaldarriaga, Template bank for compact binary coalescence searches in gravitational wave data: A general geometric placement algorithm, Physical Review D 99, [10.1103/PhysRevD.99.123022](https://doi.org/10.1103/PhysRevD.99.123022) (2019).

[^76]: T. Cokelaer, Gravitational waves from inspiralling compact binaries: Hexagonal template placement and its efficiency in detecting physical signals, Physical Review D - Particles, Fields, Gravitation and Cosmology 76, [10.1103/PhysRevD.76.102004](https://doi.org/10.1103/PhysRevD.76.102004) (2007).

[^77]: R. Prix, Template-based searches for gravitational waves: Efficient lattice covering of flat parameter spaces, in [*Classical and Quantum Gravity*](https://doi.org/10.1088/0264-9381/24/19/S11), Vol. 24 (2007).

[^78]: I. W. Harry, B. Allen, and B. S. Sathyaprakash, Stochastic template placement algorithm for gravitational wave data analysis, Physical Review D - Particles, Fields, Gravitation and Cosmology 80, [10.1103/PhysRevD.80.104014](https://doi.org/10.1103/PhysRevD.80.104014) (2009).

[^79]: B. Allen, Performance of random template banks, Physical Review D 105, [10.1103/PhysRevD.105.102003](https://doi.org/10.1103/PhysRevD.105.102003) (2022).

[^80]: S. Babak, R. Balasubramanian, D. Churches, T. Cokelaer, and B. S. Sathyaprakash, A template bank to search for gravitational waves from inspiralling compact binaries: I. physical models, Classical and Quantum Gravity 23, [10.1088/0264-9381/23/18/002](https://doi.org/10.1088/0264-9381/23/18/002) (2006).

[^81]: S. Roy, A. S. Sengupta, and P. Ajith, Effectual template banks for upcoming compact binary searches in advanced-ligo and virgo data, [Phys. Rev. D 99, 024048 (2019)](https://doi.org/10.1103/PhysRevD.99.024048), [arXiv:1711.08743 \[gr-qc\]](https://arxiv.org/abs/1711.08743).

[^82]: D. A. Brown, A. Lundgren, and R. O’Shaughnessy, Nonspinning searches for spinning black hole-neutron star binaries in ground-based detector data: Amplitude and mismatch predictions in the constant precession cone approximation, Physical Review D - Particles, Fields, Gravitation and Cosmology 86, [10.1103/PhysRevD.86.064020](https://doi.org/10.1103/PhysRevD.86.064020) (2012b).

[^83]: I. W. Harry, A. H. Nitz, D. A. Brown, A. P. Lundgren, E. Ochsner, and D. Keppel, Investigating the effect of precession on searches for neutron-star-black- hole binaries with advanced ligo, Physical Review D - Particles, Fields, Gravitation and Cosmology 89, [10.1103/PhysRevD.89.024010](https://doi.org/10.1103/PhysRevD.89.024010) (2014).

[^84]: P. Ajith, N. Fotopoulos, S. Privitera, A. Neunzert, N. Mazumder, and A. J. Weinstein, Effectual template bank for the detection of gravitational waves from inspiralling compact binaries with generic spins, Physical Review D - Particles, Fields, Gravitation and Cosmology 89, [10.1103/PhysRevD.89.084041](https://doi.org/10.1103/PhysRevD.89.084041) (2014).

[^85]: D. A. Brown and P. J. Zimmerman, Effect of eccentricity on searches for gravitational waves from coalescing compact binaries in ground-based detectors, Physical Review D - Particles, Fields, Gravitation and Cosmology 81, [10.1103/PhysRevD.81.024007](https://doi.org/10.1103/PhysRevD.81.024007) (2010).

[^86]: P. Csizmadia, G. Debreczeni, I. Rácz, and M. Vasúth, Gravitational waves from spinning eccentric binaries, Classical and Quantum Gravity 29, [10.1088/0264-9381/29/24/245002](https://doi.org/10.1088/0264-9381/29/24/245002) (2012).

[^87]: M. Coughlin, P. Meyers, E. Thrane, J. Luo, and N. Christensen, Detectability of eccentric compact binary coalescences with advanced gravitational-wave detectors, Physical Review D - Particles, Fields, Gravitation and Cosmology 91, [10.1103/PhysRevD.91.063004](https://doi.org/10.1103/PhysRevD.91.063004) (2015).

[^88]: K. S. Phukon, P. Schmidt, and G. Pratten, [A geometric template bank for the detection of spinning low-mass compact binaries with moderate orbital eccentricity](https://doi.org/10.48550/arXiv.2412.06433) (2025).

[^89]: R. Meyer, Using markov chain monte carlo methods for estimating parameters with gravitational radiation data, Physical Review D - Particles, Fields, Gravitation and Cosmology 64, [10.1103/PhysRevD.64.022001](https://doi.org/10.1103/PhysRevD.64.022001) (2001).

[^90]: M. V. van der Sluys, C. Röver, A. Stroeer, V. Raymond, I. Mandel, N. Christensen, V. Kalogera, R. Meyer, and A. Vecchio, Gravitational-wave astronomy with inspiral signals of spinning compact-object binaries, The Astrophysical Journal 688, [10.1086/595279](https://doi.org/10.1086/595279) (2008).

[^91]: M. Van Der Sluys, V. Raymond, I. Mandel, C. Röver, N. Christensen, V. Kalogera, R. Meyer, and A. Vecchio, Parameter estimation of spinning binary inspirals using markov chain monte carlo, Classical and Quantum Gravity 25, [10.1088/0264-9381/25/18/184011](https://doi.org/10.1088/0264-9381/25/18/184011) (2008).

[^92]: V. Raymond, M. V. Van Der Sluys, I. Mandel, V. Kalogera, C. Röver, and N. Christensen, The effects of ligo detector noise on a 15-dimensional markov-chain monte carlo analysis of gravitational-wave signals, Classical and Quantum Gravity 27, [10.1088/0264-9381/27/11/114009](https://doi.org/10.1088/0264-9381/27/11/114009) (2010).