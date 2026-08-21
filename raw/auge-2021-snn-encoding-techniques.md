---
title: "A Survey of Encoding Techniques for Signal Processing in Spiking Neural Networks - Neural Processing Letters"
source: "https://link.springer.com/article/10.1007/s11063-021-10562-2"
author:
  - "[[Daniel Auge]]"
  - "[[Julian Hille]]"
  - "[[Etienne Mueller]]"
  - "[[Alois Knoll]]"
published: 2021-07-22
created: 2026-06-20
description: "Biologically inspired spiking neural networks are increasingly popular in the field of artificial intelligence due to their ability to solve complex proble"
tags:
  - "clippings"
---
## Abstract

Biologically inspired spiking neural networks are increasingly popular in the field of artificial intelligence due to their ability to solve complex problems while being power efficient. They do so by leveraging the timing of discrete spikes as main information carrier. Though, industrial applications are still lacking, partially because the question of how to encode incoming data into discrete spike events cannot be uniformly answered. In this paper, we summarise the signal encoding schemes presented in the literature and propose a uniform nomenclature to prevent the vague usage of ambiguous definitions. Therefore we survey both, the theoretical foundations as well as applications of the encoding schemes. This work provides a foundation in spiking signal encoding and gives an overview over different application-oriented implementations which utilise the schemes.

## 1 Introduction

Spiking Neural Networks (SNNs) use short “all-or-nothing” pulses to encode and transmit information. Such networks consist of neurons which describe the action potential generation as mathematical non-differential equation to approximate the observed behaviour of biological systems. This third generation of neural networks \[[^54]\] promises a better processing performance than classical networks based on activation functions \[[^53]\]. Additionally, since spikes are only exchanged when information is processed, the energy consumption of SNNs can be a fraction of comparable networks of the earlier generations on specalised hardware \[[^8]\]. To make use of these principles, still many questions regarding data encoding, network architectures, training, and hardware realisations have to be answered. In this study, we focus on the question of how to convert analog and digital data into spikes.

The human brain as the most complex and efficient spike processing computing device might give some insights into the biological answer to this question. It uses various encoding schemes to represent visual, acoustic, or somatic data from the different senses. Signals containing motor commands executed by muscles again make use of further encodings. This biological model suggests, that coding schemes exist which are better suited for particular data forms than others, and that there are multiple schemes to choose from.

The implementations of artificial SNNs have shown a variety of different encoding schemes. Comparable with the biological findings, two main coding approaches can be differentiated: rate coding and temporal coding \[[^29]\]. Rate codes embed the information in the instantaneous or averaged rate of spike generation of a single or group of neurons. This leads to a value which describes the activity of a neuron, which is comparable to the activation value of ordinary non-spiking artificial neurons. For temporal coding techniques, the precise timing of and between spikes is used to encode information. This includes the absolute timing in relation to a global reference, the relative timing of spikes emitted by different neurons or simply the order in which a population of neurons generate specific spikes.

As in the biological case, specific coding techniques are better suited than others depending on the type of data to be dealt with and the structure of the network. Networks analysing frame-based two-dimensional images will need a different approach than architectures dealing with audio streams. Systems, which rely on high processing speeds and fast responses on stimulus onset will not use codes which are based on temporal averaging. And neurons driving actuators will have to use different coding schemes than sensors retrieving a representation of the environment.

In addition to the wide variety of coding techniques available, often the nomenclature and categorisation used in the literature is not uniform amongst the publications. Some reports use the same designation for fundamentally different schemes. Others categorise existing techniques in many different ways. So far, there has been no publication which summarises and standardises the different approaches of the research community.

In this work, we will give an overview of existing coding techniques and establish a uniform nomenclature and categorisation. We focus on the abstract description of the different coding schemes to ensure generality. We thus do not closely consider distinct biological realisations consisting of specialised input neurons. However, we include biological examples to motivate the biological relations. Subsequently, we give an overview of exemplary implementations and applications of these schemes given in the literature. The network architectures used in those applications range from reservoirs over deep feedforward structures to convolutional implementations showing the large variety of available layer types and encoding scheme combinations. In the discussion we showcase differences and trade-offs between the encoding techniques.

## 2 Biological Background

Early research of biological neural systems suggested that rate coding is the predominant technique to transmit information within nervous systems \[[^2]\]. Later publications, in contrast, showed that all sensory organs rather embed their perceptions into precise timings of action potentials. While Thorpe proposed the idea of exact spike timings as coding scheme \[[^97]\], it took several years to find experimental evidence for this theory. It has been shown that the human visual system needs 150 ms to process object recognition tasks, which supports this suggestion since rate codes would be too slow to explain these fast responses \[[^95]\]. Further research supports these findings for visual \[[^27], [^30], [^57], [^72]\], audio \[[^25]\], tactile \[[^39]\], and olfactory systems \[[^1], [^55]\]. Additionally, the experiments show the trade-off between fast responses after stimulus onset and accuracy of the result. Mice, for example, can discriminate between simple odors within 200 ms. If they are similar, the discrimination can take 100 ms longer, suggesting an integration over time \[[^39]\].

## 3 Encoding

To illustrate the applicability of different encoding schemes on the same problem, consider a video camera, which encodes visual information into spikes as depicted in Fig. [1](https://link.springer.com/article/10.1007/s11063-021-10562-2#Fig1). Digital cameras expose the image sensor in a fixed rate for a short period of time and encode the measured intensity of light at each pixel into an integer number. This frame-based approach can also be applied to generate a spike representation of the video stream. The light intensity can directly be translated into spike times, where a highly exposed pixel corresponds to a fast spike time or vice versa (time-to-first-spike (TTFS)). Alternatively, the intensity can be converted into the number of spikes generated within one frame (count). Here, a large number of emitted spikes can correspond to a high intensity at the associated pixel. As a third example, we could discard the approach of using frame-based measurements (temporal contrast (TC)). Instead, we observe the light intensity at a certain pixel and emit a spike as soon as the intensity change surpasses a distinct threshold.

**Fig. 1**

![Fig. 1](https://media.springernature.com/lw685/springer-static/image/art%3A10.1007%2Fs11063-021-10562-2/MediaObjects/11063_2021_10562_Fig1_HTML.png?as=webp)

[Full size image](https://link.springer.com/article/10.1007/s11063-021-10562-2/figures/1)

Exemplary coding schemes for a sequence of images over time. The intensity-time plot indicates the changes of the pixel value in the red square as a continuous function. The dashed lines indicate the time instances at which the images have reached the colour value. Digital, count, and TTFS spikes in correlation to the local minima and maxima in the intensity curve. The TC emits spikes if the continuous intensity change exceeds a certain threshold

In general, all encoding techniques can be divided into two main categories: rate and temporal coding. All specialised encoding schemes can be separated into these two by answering the question whether the exact timing and order of spikes is crucial for the information to be submitted. The resulting taxonomy is depicted in Fig. [2](https://link.springer.com/article/10.1007/s11063-021-10562-2#Fig2). Population codes, which are often referred to as third main category only add the information whether a single or multiple neurons are used in the particular coding scheme. Though, this can be the case in both temporal and rate codes and does not provide a unique differentiation.

**Fig. 2**

![Fig. 2](https://media.springernature.com/lw685/springer-static/image/art%3A10.1007%2Fs11063-021-10562-2/MediaObjects/11063_2021_10562_Fig2_HTML.png)

[Full size image](https://link.springer.com/article/10.1007/s11063-021-10562-2/figures/2)

Taxonomy of rate and temporal coding techniques

**Fig. 3**

![Fig. 3](https://media.springernature.com/lw685/springer-static/image/art%3A10.1007%2Fs11063-021-10562-2/MediaObjects/11063_2021_10562_Fig3_HTML.png)

[Full size image](https://link.springer.com/article/10.1007/s11063-021-10562-2/figures/3)

Visualisation of rate coding techniques with a wide pulse stimulus. The dashed line indicates the rising and falling edge of the stimulus

### 3.1 Rate Coding

Rate codes can be further divided into three subcategories: count, density and population rate codes. Figure [3](https://link.springer.com/article/10.1007/s11063-021-10562-2#Fig3) shows an example visualisation of rate coding of an arbitrary input stimulus. For information exceeding the next sections, we refer to \[[^28], [^29]\].

**Count rate** (*average over time*) is the most common rate coding scheme. It is defined by the mean firing rate

 $v = \frac{N_{s p i k e}}{T} ,$ 
$$
\begin{aligned} v = \frac{N_{\mathrm {spike}}}{T}, \end{aligned}
$$

(1)

with the spike count $N_{\mathrm {spike}}$ and the time window *T*. This scheme is also referred to as frequency coding. In vivo, Adrian and Zotterman observed that stretching a frog muscle with different weights affects the frequency of the firing rate \[[^2]\]. In artificial applications, firing rates can describe any slowly varying analog value, from pixel intensities to gas concentrations.

In a count rate code, the spike times can either be exact or random. The latter case is often modelled by a Poisson distribution. When encoding an analog number, the remaining reconstruction error due to the discretised number of spikes during a given time interval decreases by the number of spikes $\nicefrac {1}{N_{\mathrm {spikes}}}$. Due to the variations given in Poisson distributed spike trains, the error decreases only by $\nicefrac {1}{\sqrt{N_{\mathrm {spikes}}}}$ \[[^18]\].

**Density rate** (*average over several runs*) The neural activity is measured over different simulations and the results of the neural responses are presented in a peri-stimulus-time histogram to visualise the spike activity. The spike density is defined by

 $p \left(\right. t \left.\right) = \frac{1}{\Delta t} \frac{N_{s p i k e} \left(\right. t ; t + \Delta t \left.\right)}{K} .$ 
$$
\begin{aligned} p(t) = \frac{1}{\Delta t} \frac{N_{\mathrm {spike}}(t;t+\Delta t)}{K}. \end{aligned}
$$

(2)

The number of spikes $N_{\mathrm {spikes}}$ in a time interval $[t; t + \Delta t]$ averaged over all iterations divided by the total number of iterations *K* and the duration $\Delta t$, specifies the spike density *p* (*t*). This scheme is not a biologically plausible encoding method. One imagines a frog which tries to catch a fly by averaging over multiple computations over the exact same trajectory of the fly \[[^29]\]. In an artificial SNN however, it can be beneficial to average over multiple simulation runs with the exact same inputs.

**Population rate** (*average over several neurons*) is based on similar properties of neurons in a population. The firing rate is defined by

 $A \left(\right. t \left.\right) = \frac{1}{\Delta t} \frac{N_{s p i k e} \left(\right. t ; t + \Delta t \left.\right)}{N} .$ 
$$
\begin{aligned} A(t) = \frac{1}{\Delta t} \frac{N_{\mathrm {spike}}(t;t+\Delta t)}{N}. \end{aligned}
$$

(3)

The number of spikes $N_{\mathrm {spikes}}$ in the total population are summed together for the time interval $[t; t+\Delta t]$ and divided by the duration $\Delta t$ and the total number of neurons *N*.

A population of neurons does not necessarily have to be uniform in the spike response of neurons for a given input. If each neuron has a different (known) tuning curve describing the spike count rate at any input current, the superposition in a large population can encode single numbers, vectors or even function fields \[[^21]\].

### 3.2 Temporal Coding

As depicted in Fig. [2](https://link.springer.com/article/10.1007/s11063-021-10562-2#Fig2), temporal codes can be divided into multiple subcategories. While temporal contrast (TC) schemes focus on the signal’s derivative, globally referenced encodings process the input in packets in reference to a periodical signal or oscillation. Inter-spike-interval (ISI) codes interpret the relative timing between grouped blocks of spikes in contrast to correlation codes, which rely on the simultaneous activity of several neurons. Filter and optimiser based approaches base their spike patterns on the comparison of input and kernel functions. Figure [4](https://link.springer.com/article/10.1007/s11063-021-10562-2#Fig4) demonstrates the temporal encoding schemes in relation to a stimulus. Note that binary codes, Ben’s spiker algorithm (BSA), and TC use a different stimulus in the illustration.

**Fig. 4**

![Fig. 4](https://media.springernature.com/lw685/springer-static/image/art%3A10.1007%2Fs11063-021-10562-2/MediaObjects/11063_2021_10562_Fig4_HTML.png?as=webp)

[Full size image](https://link.springer.com/article/10.1007/s11063-021-10562-2/figures/4)

Visualisation of temporal coding techniques with dashed line indicating the rising and falling edge of the stimulus. $\Delta t$ describes the latency between the reference point and the spike. In (d) the order of spikes is numbered on the right

#### 3.2.1 Global Referenced

The most basic temporal coding scheme is **TTFS**, which encodes information by the time difference $\Delta t$ between stimulus onset and the first spike of a neuron. In the simplest case, the firing time can be the inverse of the stimulus amplitude $\Delta t = 1/a$ or a linear relation $\Delta t = 1-a$, with *a* being the normalised signal amplitude. In both cases, a large amplitude leads to an early firing time whereas low amplitudes lead to a large interval or no spike at all. As a biological example, Johansson and Birznieks discovered that the relative time of the first spike in regard to a discrete mechanical fingertip event contains direction and force information \[[^39]\]. Gollisch and Meister observed TTFS in the retinal pathway and found invariant relation to stimulus contrast and robustness to noise variations \[[^30]\]. Though, they called the coding scheme “latency coding”, which can be mistaken as ISI coding due to the unclear definition of latency between spikes and a global reference or between multiple spikes.

Instead of a single reference point, **phase** coding encodes information in the relative time difference between spikes and a reference oscillation \[[^36], [^42]\]. The phase pattern repeats periodically if no changes between the cycles appeared. Each single neuron fires in respect to the reference signal and encodes the data similar to TTFS. Such a behaviour was detected by Gray, König, Engel, and Singer \[[^31]\]. They analysed the firing probability of neurons in the cat visual cortex and identified a relation between the firing pattern and a reference oscillation.

**ROC** (rank-order coding) is based on the firing order of a population of neurons in relation to a global reference \[[^26], [^96]\]. In contrast to TTFS, ROC encodes the information without considering the precise timing of the spikes. It functions as a discrete normalisation filter with the loss of the absolute amplitude information. As a consequence, it is not possible to reconstruct the absolute signal amplitude or an exactly constant signal. The scheme is further limited by the distinction of the spikes and jitter due to a huge effect for small ISI. In the basic version of ROC the precise spike time is not relevant but there are modified versions which use the ISI to encode additional information.

A further subcategory of globally referenced schemes are **(sequential) binary** codes. Here, each spike corresponds to a ”1” or ”0” in a bit stream. In relation to a fixed reference clock, two schemes to encode the bits are possible: the presence or absence of a spike within a given interval \[[^110]\], or the timing of the spike within the interval \[[^33]\]. In the former case, a logical ”1” corresponds to a spike being present during one clock cycle. In the latter case, the clock cycle is divided into two sub-intervals. If a spike is present in the first half, a ”0” is encoded, if it is the case in the second half, a ”1” is present or vice versa. This ensures the constant presence of spikes independent of the bit pattern to be encoded.

Often, the first spike of all global referenced coding schemes represents the most significant element of the pattern, comparable to binary representations. This leads to an interesting behaviour in the network parameter selection because the threshold of the output neurons can be adjusted in regard to the speed-accuracy trade-off. This means the network can already predict the output pattern before the whole input pattern has been processed \[[^96]\].

#### 3.2.2 ISI Coding

In **ISI** or **latency** coding the information is embedded into the relative time difference (latency) between the spikes of a neuron group \[[^71]\]. The dependency of the ISI with the stimulus intensity was observed in pyramidal cells \[[^64]\]. Li and Tsien \[[^48]\] state that rare events such as longer silence periods contain more information than periods of higher spike activity.

A sub-category of ISI coding is **burst** coding which converts the input into various interspike latencies. A burst is a group of spikes with a very small ISI \[[^67]\]. If a spike is a part of the burst depends on the ISI threshold and the expected number of spikes \[[^99], [^108]\].

#### 3.2.3 Correlation and Synchrony

**Correlation and synchrony** coding uses the temporal reference to other spiking neurons. The input pattern is converted into a spatio-temporal spike representation. There, spike groups with a relative short ISI represent specific input patterns \[[^29]\]. Information is encoded by the distinction of which neurons fire at the same time. **Sparse distributed representations (SDRs)** \[[^4], [^62]\] also fall into this category. Here, a subset of neurons inside a population is active at any given point of time. This enables to represent a virtually infinite number of patterns without significant errors \[[^34]\]. In the extreme case, only one single neuron is active at any given time. Then, every neuron is allocated to a specific input value. A spike is generated as soon as this value is crossed. This scheme can be referred to as **amplitude** coding, since the signal strength is directly encoded in the activity of one neuron at a time.

In vivo, the general synchronous coding scheme has been observed in the somatosensory cortex of monkeys \[[^88]\] or the visual cortex of cats \[[^31], [^32]\]. There, the authors hypothesise that synchrony can give evidence about the significance of the incoming stimulus. A further biological example are grid and place cells \[[^58], [^61]\] which encode spatial representations into the synchronous firing of a specific subset of a population.

Next to the already introduced sequential binary codes, the synchronous firing of neurons can also be interpreted as the ones and zeros of a binary number. In these **(parallel) binary** codes, each neuron encodes a specific bit within a larger word in contrast to the sequential codes, where a single neuron encodes the information into the precise timing within a stream.

#### 3.2.4 Filter and Optimizer-based Approaches

In both neuroscience and control theory, an often utilised method to find a description of a system is to feed a known signal into it and to measure its output. In the neurological case, the input is an arbitrary analog signal, the system is a single neuron or population, and the output is a spike train. **BSA** \[[^81]\] and its predecessor **Hough spiker algorithm (HSA)** \[[^37]\] reverse this idea and use a known filter to compute a spike train for a corresponding input signal. A spike is generated as soon as the convolution of signal and filter exceeds a certain threshold. Since this method can only process inputs of a specific range, the incoming signal has to be normalised prior to conversion.

Sengupta, Scott, and Kasabov interpret the encoding process as a data compression problem with background knowledge \[[^83]\] and introduce the GaGamma scheme. Thereby, information has to be maximised while minimising the spike density. By leveraging prior knowledge of the signal to be encoded, specific optimal solutions can be found while solving the mixed-integer optimisation problem.

#### 3.2.5 Temporal Contrast

The last subcategory of temporal codes is TC coding. It converts an analog signal to a spike train by observing the changes in the signal intensity \[[^40]\]. It is separated into three different algorithms: **threshold-based representation (TBR)**, **step-forward (SF)**, and **moving-window (MW)**. TBR compares the absolute signal change of an input signal with a threshold and emits positive or negative spikes accordingly. The threshold depends on the summation of the mean derivative with the multiplication of a factor and the derivative standard deviation. In contrast to TBR, SF just uses the next available signal value and checks if the previous value and an additional threshold is exceeded. It sends out appropriate spikes depending on the polarity of the signal difference. MW uses a base which is defined by the mean of the previous signal in a time window. Again positive or negative spikes are emitted if the current signal value exceeds the base and threshold. For further information and implementations we refer to \[[^70]\].

## 4 Applications

As shown in the introductory example, one single type of input data for a given problem can be translated into spikes in several ways. The following implementations demonstrate this further and should give an overview of the variety of problems which can be solved with SNNs. Additionally, it further indicates that a universal answer to neural coding has not been found yet.

### 4.1 Rate Coding

Early work on SNNs is mainly based on rate coding. Until 2012 multiple authors presented fully connected feedforward networks which achieved up to 94% for digit recognition on the MNIST handwritten digits dataset \[[^11], [^22], [^47], [^91]\]. Unsupervised spike-timing-dependent plasticity (STDP)-based models improved the accuracy to 95% in 2015 \[[^19]\] and over 97% in 2019 \[[^92]\]. A similar approach could classify the iris dataset with an accuracy of $97\%$ and the Wisconsin breast cancer dataset with 94% \[[^79]\].

Interestingly, the best results were achieved by training non-spiking artificial neural networks (ANNs) and subsequently converting them into the spiking domain. Whereas using sigmoid as an activation function turned out to be suboptimal for translating it into spiking neurons \[[^73]\]. Today’s default activation function ReLU can almost directly be translated into the spiking rate, by only normalizing the weight for a near-lossless accuracy conversion \[[^20]\]. Through this approach the accuracy on MNIST could be leveraged to over 98% \[[^20], [^38], [^59]\] and achieving the best performance of 99.42% by Esser, Appuswamy, Merolla, Arthur, and Modha \[[^23]\].

Similarly for convolutional neural networks (CNNs), whereas earlier work relied on STDP achieving over 98% \[[^43], [^92], [^93]\], conversion-based approaches could easily attain more than 99% \[[^20], [^76]\]. A significantly larger discrepancy can be found by training on the more challenging CIFAR-10 dataset \[[^46]\], which could only achieve 75.42% \[[^65]\] without, but 90.85% with conversion methods \[[^76]\].

Some research also focuses on how to obtain those rate-coded signals. Besides the highly popular applications in image processing, Liu, Schaik, Mincti, and Delbruck proposed an event-based cochlea, which encodes the amplitude of specific frequencies within a signal into a rate code \[[^51]\]. These “pulse-frequency modulators” emit a higher event rate the larger the corresponding frequency component is.

Besides classification tasks, rate-coded information are often used in robotic applications \[[^7]\]. Most implementations make use of Poisson-distributed spike trains to closely emulate the properties of real neurons.

To overcome the limitation of rate-based networks of producing large amounts of spikes, Zambrano and Bohte \[[^107]\] presented a method for adapting the firing rate, resulting in a significant reduction of spike events. A different approach uses a global referenced binary coding to reduce the number of spikes. Together with neuron models with exponential input characteristics, the same activation of the neuron can be reached as with a count rate code but with far less spikes \[[^110]\].

### 4.2 Temporal Coding

#### 4.2.1 Global Referenced

The idea of converting ANNs was historically based on rate coding schemes, but there are also temporal based methods. Rueckauer and Liu used the coding scheme TTFS for the classification of the MNIST dataset with less operations and an error rate within 2%. The SNN implementation decreases the computational cost by factor 7 for the LeNet5 architecture on MNIST \[[^75]\]. Zhang, Zhou, Zhi, Du, and Chen \[[^109]\] also utilise TTFS encoding on a converted network; but in contrast, they apply the scheme reversed. Here, the first spike encodes the weakest feature whereas the last spike has the largest influence. A further approach uses phase coding to represent information inside a converted ANN \[[^44]\]. The authors show that this reduces the overall number of spikes and the inference latency while preserving the accuracy of the image recognition tasks.

The artificial microelectronic nose by Chen, Ng, Bermak, Law, and Martinez uses ROC and TTFS to detect gases like ethanol, carbon monoxide and hydrogen \[[^13]\]. The sensor output is sampled and converted to a spike train in a microcontroller. The data are then inserted to an SNN which identifies the gas type. Encoding the samples with rank order coding achieved an classification accuracy of 95.2% and with TTFS 100%. This difference arises from the fact that in ROC the spikes are really close together and a small spike jitter has a large effect on the classification accuracy.

In \[[^9]\], the authors implemented an unsupervised network which can compute and learn clusters from realistic high-dimensional data. They used a sparse temporal coding scheme which they called population coding. We would define this coding as sparse TTFS coding, because the relative time difference between the spikes and the stimuli contains the crucial information. The input neurons cover the whole data-range and use Gaussian receptive fields to map the continuous input values to specific delay times. Significant data will have small delays and non-relevant data will not emit an action potential in the defined time interval which introduces sparsity. A similar coding was implemented with a deep SNN for image classification with data-sets like Caltech 101, ETH-80, and MNIST \[[^43]\]. The first network layer detects the contrasts in the input image with a Gaussian filter and encodes the contrast into spike latencies. Higher contrast has shorter delay and too low contrast will be neglected. This convolutional SNN achieved an accuracy of 98.4% in the MNIST data-set. Similar encoding idea was implemented on the iris data-set with an accuracy of 92.55% in \[[^105], [^106]\]. It was extended by observing two different input connection schemes. First by connecting each receptive field row with a neuron and the second with sparse random connections between the receptive fields and the input neurons. During learning the random connection achieves faster and higher accuracy rates compared to the structured connections. \[[^79]\] also implemented the temporal coding based on the Gaussian receptive field and accomplished an accuracy of 99% for the iris data-set and 90% for the Wisconsin breast cancer data-set with a single layer (comparable to the state-of-the-art). During the learning process the network tries to memorise patterns for future feature predictions.

Delorme and Thorpe propose a network for image recognition which operates entirely in the spiking domain \[[^16], [^17]\]. The input layer of the network consists of pairs of ON and OFF center cells which indicate the intensity difference across the cells. Based on this activity, the spike code is generated. This process resembles the operation of biological eyes. The second and third layer of the network consist of neurons selective on edges of different orientations and the final class label, respectively. A comparable approach has later been described by Wysoski, Benuskova, and Kasabov \[[^104]\] where face recognition of stream data is performed by accumulating different opinions over several views.

A further interesting approach is presented by Liu and Yue. The authors combine the feature extraction capabilities of classical neural networks with the fast unsupervised learning of spiking neural networks \[[^50]\]. In their proposed network, features are extracted from image data using a simplified convolutional hierarchical max-pooling model \[[^85]\], and encoded into spikes using the ROC scheme. Subsequently, the spikes are fed into the second (spiking) half of the network which utilises the unsupervised STDP learning method to identify different classes.

The network implementations dealing with audio input for speaker identification or speech recognition utilise the frequency domain representation of the incoming audio signal \[[^52], [^102], [^103]\]. The transform between time and frequency domain is realised using general filter banks or mel-cepstral coefficients. The resulting feature vectors represent the frequencies present during a fixed measurement time encoded with ROC. In each frame, the amplitudes of each frequency are then encoded into spike latencies. In most cases, two succeeding measurement frames have an overlap of 50 %.

#### 4.2.2 ISI Coding

Implementations of pure ISI coding schemes are not widely used. Sharma and Srinivasan implemented a time series forecasting network by encoding the data into the latency between consecutive spikes \[[^87]\]. The network achieved higher accuracy than traditional networks with a smaller architecture size, leveraging ISI coding and an evolutionary learning algorithm.

The subcategory of burst coding indicates to be a fast and energy-efficient information coding technique. This was shown on the MNIST and CIFAR classification problems with a deep SNN architecture \[[^67]\]. Furthermore, Chen and Qiu implemented burst coding for real-time anomaly detection on the IBM TrueNorth processor \[[^14]\]. The input consists of a continuous stream from the intrusion detection DARPA dataset. They observed that burst coding increases the detection accuracy while decreasing the hardware complexity compared to rate coding.

#### 4.2.3 Correlation and Synchrony

Sparse representations as one subcategory of synchrony coding are implemented in the hierarchical temporal memory (HTM) model \[[^35]\]. The goal of this model is to understand and mimic the human neocortex and utilise it in several scientific and industrial applications. The implementation of HTM by Numenta is a clocked system consisting of a spatial pooler learning sparse representations of input neurons which fire together, and a temporal memory where temporal pattern sequences are determined. The system is well suited for applications dealing with anomaly detection or prediction of recurring sequences. The developers show this at examples from different domains like GPS surveillance or monitoring the CPU utilisation in computer centres \[[^3]\].

An application of amplitude coding is given in \[[^5]\]. There, the authors encode images by sequentially iterating over all pixels and converting each pixel’s grey-value to a spike event of the neuron associated with the same intensity threshold.

#### 4.2.4 Filter and Optimizer-based Approaches

Filter and optimizer-based approaches are primarily used to encode data streams. Examples are the utilisation of BSA for electroencephalography (EEG) classification \[[^60]\] or speech recognition \[[^80]\]. Additionally, BSA is implemented in the NeuCube simulator as one of the proposed encoding schemes \[[^40]\]. GAGamma encodes functional magnetic resonance imaging (fMRI) data using an optimizer-based approach by leveraging the prior knowledge of the signal properties \[[^82]\].

#### 4.2.5 Temporal Contrast Coding

A prominent example of temporal contrast coding in hardware applications are event-based cameras. Lichtsteiner, Posch, and Delbruck implemented the first asynchronous event based camera which can detect changes in light intensity with a high dynamic range \[[^15], [^49]\]. For each pixel of the camera sensor, a positive or negative spike event is emitted as soon as the relative change surpasses a threshold. Because the relative change is evaluated per pixel even scenes with uneven lighting conditions can be perceived with high detail. These biologically inspired cameras send out data packets containing the coordinates of the respective pixel and the time stamp of the event. Accordingly, in contrast to classical image-based cameras, only pixels which are subject to intensity changes transmit information. These type of optical sensors are often used in robotics \[[^6], [^56]\] or classification tasks. Datasets for classification applications containing event camera-based recordings of MNIST, Caltech101, poker cards, or human postures are readily available \[[^12], [^63], [^73], [^84]\].

A CNN-based evaluation of the different datasets is given in \[[^90]\]. Paulun, Wendt, and Kasabov present the processing of spike trains generated by event cameras using the NeuCube simulator \[[^68]\]. The simulator additionally implements the temporal contrast schemes for other types of input data. Kasabov, Scott, Tu, et al., for example, used TBR to encode real valued weather data to predict the population of a species in relation to weather and climate factors and achieved a state-of-the-art accuracy \[[^40]\]. Many further applications and methodical background information in close relation to the NeuCube simluator can be found in \[[^41]\].

## 5 Discussion

After presenting the concepts and applications, the remaining question is which encoding scheme to use for a specific application. Many publications discuss this question and compare different sub-sets of the presented coding schemes \[[^45], [^69], [^77], [^79], [^86], [^89], [^94], [^100]\]. Most of them report a comparison of rate and temporal codes. In general, the coding schemes differ in accuracy, dynamics, latency, noise vulnerability, energy consumption, hardware requirements, and many more.

**Table 1 Overview and comparison between different MNIST classification implementations with different coding schemes which are capable to handle frame based inputs**

One approach to quantify the differences of coding schemes is by applying information theory on the topic of neural coding. Here, it has been tried to compare coding schemes with respect to the number of bits which can be encoded by a specific number of neurons or spikes \[[^10], [^66], [^101]\]. Count rate codes for example encode $log_2(N_{\mathrm {spikes}}+1)$ bit of information into $N_{\mathrm {spikes}}$ spikes \[[^77]\]. ROC-coded signals encode $log_2(N_{\mathrm {spikes}}!)$ bit \[[^96]\] since the order of the respective spikes carries the information. Reducing the coding schemes to a single number of bits enables a quantitative comparison but lacks the consideration of many other aspects which influence the efficiency of a code. Foremost, the developed processing architecture must match the chosen coding scheme. Even though having a highly efficient coding scheme which can encode data with a low number of spikes accurately does not necessarily lead to an efficient system. Hence, we must rely on qualitative analyses of the coding schemes or comparisons of whole systems. Some publications provide these quantitative system comparisons \[[^13], [^79]\] by evaluating classification accuracy or energy consumption at specific tasks. Table [1](https://link.springer.com/article/10.1007/s11063-021-10562-2#Tab1) provides an overview of MNIST classification accuracies for different coding techniques. Though the differences are not only linked to the encoding scheme since the publications describe various learning methods and network architectures. Consequently, the accuracies provide information on the general system performance but not on the coding schemes themselves. In the next few paragraphs we try to summarise some of the important qualitative differences between the schemes.

While rate coding was seen as the only meaningful code in populations \[[^86]\], current research focuses more on those coding schemes which are based on precise spike times. Though, rate codes are also utilised in different applications. Count rate codes are often used in applications which convert ANNs into SNNs due to their equivalence to activation values. Researchers show a lossless conversion while reducing the power consumption of the network by decades, given optimised neuromorphic hardware is used \[[^76]\]. Another strength of rate codes is their robustness and their behaviour towards noise \[[^21]\].

Temporal codes, however, have been shown to offer a higher information capacity compared to rate codes \[[^78]\], faster reaction times, and higher transmission speeds. Furthermore, they favour the utilisation of local learning rules like STDP. Rullen and Thorpe state that ROC is biologically more realistic than TTFS due to the fact that the brain cannot know the exact start of a stimulus \[[^77]\]. The same argument is used by Rolls, Franco, Aggelopoulos, and Jerez against both ROC and TTFS \[[^74]\]. The authors analysed the information content of spikes in the inferior temporal visual cortex and propose that count rate is fast in short time windows and transports more information than TTFS or ROC from a biological perspective due to the effect of spontaneous neuronal firing. Li and Tsien argue that this spontaneous spike activity is related to the ISI which carries more information than expected and should not be ignored \[[^48]\]. This shows that there are still different opinions on the encoding techniques.

Rate and Temporal coding provide different benefits and combining these schemes could have a huge impact in the system performance. The fast temporal coding can be used for fast systems and the rate coding for methods with less strict time constraints \[[^39], [^78]\]. Fairhall, Lewen, Bialek, and de Ruyter van Steveninck suggest a multi-layer coding scheme where spike trains represent information in different channels of various encoding schemes depending on the timescale \[[^24]\]. Similar ideas are called hybrid coding where the neural encoding scheme varies between network layers \[[^67]\] or the neuron switches between coding techniques \[[^77]\]. The topic of hybrid neural code is not yet clearly defined and needs further investigations.

## 6 Conclusion

In biological systems there exist several techniques to encode sensory information into spike trains. Probably many more yet to explore. In this work, we summarised those schemes together with less biologically plausible encoding schemes for the utilisation in applications based on artificial SNNs. In summary, there are two main categories of encoding schemes. Rate-based schemes average the spike activity over time, populations, or several runs and do not rely on the precise timing of every single spike event. They convince through their robustness against fluctuations and noise as well as their simplicity due to the equivalence to the activation value of current ANNs. Temporal encoding schemes on the other hand rely on the precise timing of every single spike and can thus achieve higher information densities and efficiencies. However they involve more complex architectures and lacking training methods.

It is expected that more applications for SNNs will arise with the perspective of more advanced architectures, better learning algorithms and the development of energy-efficient neuromorphic hardware. To assist this growing field, further investigations on neural coding techniques in system contexts need to be made.
