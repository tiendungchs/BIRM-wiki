---
title: "Predictive coding in the visual cortex: a functional interpretation of some extra-classical receptive-field effects"
source: "https://www.nature.com/articles/nn0199_79"
author:
  - "[[Rajesh P. N. Rao]]"
  - "[[Dana H. Ballard]]"
published: 1999-01-01
created: 2026-09-10
description: "We describe a model of visual processing in which feedback connections from a higher- to a lower-order visual cortical area carry predictions of lower-level neural activities, whereas the feedforward connections carry the residual errors between the predictions and the actual lower-level activities. When exposed to natural images, a hierarchical network of model neurons implementing such a model developed simple-cell-like receptive fields. A subset of neurons responsible for carrying the residual errors showed endstopping and other extra-classical receptive-field effects. These results suggest that rather than being exclusively feedforward phenomena, nonclassical surround effects in the visual cortex may also result from cortico-cortical feedback as a consequence of the visual system using an efficient hierarchical strategy for encoding natural images."
tags:
  - "clippings"
---
## Abstract

We describe a model of visual processing in which feedback connections from a higher- to a lower-order visual cortical area carry predictions of lower-level neural activities, whereas the feedforward connections carry the residual errors between the predictions and the actual lower-level activities. When exposed to natural images, a hierarchical network of model neurons implementing such a model developed simple-cell-like receptive fields. A subset of neurons responsible for carrying the residual errors showed endstopping and other extra-classical receptive-field effects. These results suggest that rather than being exclusively feedforward phenomena, nonclassical surround effects in the visual cortex may also result from cortico-cortical feedback as a consequence of the visual system using an efficient hierarchical strategy for encoding natural images.

## Main

Neurons that respond optimally to line segments of a particular length were first reported in early studies of the cat and monkey visual cortex [^1] [^2]. These neurons, which are especially abundant in cortical layers 2 and 3, have the curious property of endstopping (or end-inhibition): a vigorous response to an optimally oriented line segment is reduced or eliminated when the same stimulus extends beyond the neuron's classical receptive field (RF). Such 'extra-classical' RF effects occur in several visual cortical areas, including V1 (area 17; Refs [^2],[^3]), V2 (area 18; Refs [^1],[^4]), V4 (ref. [^5]) and MT [^6]. In most of these cases, neural responses are suppressed when stimulus properties at the center, such as orientation, velocity or direction of motion, match those in the surrounding extra-classical RF.

Why should a neuron that responds to a stimulus stop responding when the same stimulus extends beyond the classical RF? Some studies have postulated a role for 'hypercomplex' endstopped neurons in the detection of visual curvature [^1] [^7]. Others have suggested a role for these cells in detecting corners and line terminations [^8], occlusion [^9], perceptual grouping [^10] and illusory contours [^11]. However, a straightforward extension of these arguments to extra-classical RF effects in different cortical areas has been difficult. We have previously shown that a model [^12] based on the principle of Kalman filtering can account for certain visual cortical responses in a monkey freely viewing natural images [^13]. It was conjectured that a similar model might also account for endstopping and other extra-classical effects.

Here we show simulations suggesting that extra-classical RF effects may result directly from predictive coding of natural images. The approach postulates that neural networks learn the statistical regularities of the natural world, signaling deviations from such regularities to higher processing centers. This reduces redundancy by removing the predictable, and hence redundant, components of the input signal. Roots of this idea can be found in early information-theoretic approaches to sensory processing [^14] [^15] [^16]. More recently, it has been used to explain the spatiotemporal response properties of cells in the retina [^17] [^18] [^19] and lateral geniculate nucleus (LGN) [^20] [^21]. Because neighboring pixel intensities in natural images tend to be correlated, values near the image center can often be predicted from surrounding values. Thus, the raw image-intensity value at each pixel can be replaced by the difference between a center pixel value and its spatial prediction from a linear weighted sum of the surrounding values. This decorrelates (or whitens) the inputs [^17] [^19] and reduces output redundancy, providing a functional explanation for center–surround receptive fields in the retina and LGN. The values of a given pixel also tend to correlate over time. A retinal/LGN cell's phasic response can thus be interpreted as the difference between the actual input and its temporal prediction based on a linear weighted sum of past input values [^19] [^20] [^21]. Similarly, the responses of retinal photoreceptors sensitive to different wavelengths are often correlated because their spectral sensitivities overlap. Thus, the L-cone (long-wavelength or 'red' receptor) response may predict the M-cone (medium-wavelength or 'green' receptor) response, and the L- and M-cone responses together may predict the S-cone (short-wavelength or 'blue' receptor) response. Thus, the color-opponent (red – green) and blue – (red + green) channels in the retina might reflect predictive coding in the chromatic domain similar to that of the spatial and temporal domains [^18].

Using a hierarchical model of predictive coding, we show that visual cortical neurons with extra-classical RF properties can be interpreted as residual error detectors, signaling the difference between an input signal and its statistical prediction based on an efficient internal model of natural images.

## Results

### Hierarchical predictive coding model

Each level in the hierarchical model network (except the lowest level, which represents the image) attempts to predict the responses at the next lower level via feedback connections ([Fig. 1a](https://www.nature.com/articles/nn0199_79#Fig1)). The error between this prediction and the actual response is then sent back to the higher level via feedforward connections. This error signal is used to correct the estimate of the input signal at each level (see Methods and [Fig. 1b](https://www.nature.com/articles/nn0199_79#Fig1)), similar to some previous models [^22] [^23] [^24] (see also Refs [^15],[^26]). The prediction and error-correction cycles occur concurrently throughout the hierarchy, so top-down information influences lower-level estimates, and bottom-up information influences higher-level estimates of the input signal. Lower levels operate on smaller spatial (and possibly temporal) scales, whereas higher levels estimate signal properties at larger scales because a higher-level module predicts and estimates the responses of several lower-level modules (for example, three in [Fig. 1c](https://www.nature.com/articles/nn0199_79#Fig1)). Thus, the effective RF size of units increases progressively until the highest level, where the RF spans the entire input image. The underlying assumption here is that the external environment generates natural signals hierarchically via interacting hidden physical causes (object attributes such as shape, texture and luminance) at multiple spatial and temporal scales. The goal of a visual system then becomes optimally estimating these hidden causes at each scale for each input image and, on a longer time scale, learning the parameters governing the hierarchical generative model. Similar models have been studied by other researchers (for example, Refs [^27],[^28]).

![Figure 1: Hierarchical network for predictive coding.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2F4580/MediaObjects/41593_1999_Article_BFnn0199_79_Fig1_HTML.gif?as=webp)

Figure 1: Hierarchical network for predictive coding.

### Hierarchical predictive coding of natural images

Given that the visual cortex is hierarchically organized and that cortico-cortical connections are almost always reciprocal [^29], the model described above suggests the following hypothesis: feedback connections from a higher area to a lower area (say V2 to V1) carry predictions of expected neural activity in V1, whereas feedforward connections convey to V2 the residual activity in V1 that was not predicted by V2 (Refs [^12],[^22]). To test this hypothesis, a three-level hierarchical network of predictive estimators ([Fig. 1c](https://www.nature.com/articles/nn0199_79#Fig1)) was trained on image patches extracted from five natural images ( [Fig. 2a](https://www.nature.com/articles/nn0199_79#Fig2)), the motivation being that the response properties of visual neurons might be largely determined by the statistics of natural images [^17] [^20] [^21] [^30]. Such an approach has previously explained some important visual cortical RF properties [^26] [^31] [^32].

![Figure 2: Receptive fields of feedforward model neurons after training on natural images.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2F4580/MediaObjects/41593_1999_Article_BFnn0199_79_Fig2_HTML.jpg?as=webp)

Figure 2: Receptive fields of feedforward model neurons after training on natural images.

We allowed the network to learn a hierarchical internal model of its natural image inputs by maximizing the posterior probability of generating the observed data (Methods). The internal model is encoded in a distributed manner within the synapses of model neurons at each level. The synaptic weights (or 'efficacies') of a neuron encode a single basis vector that in conjunction with other basis vectors predicts lower-level inputs. For example, a given input image at the zeroth level can be predicted as an appropriate linear combination of the first-level basis vectors (Methods, Equation 2). In this linear combination, the weighting coefficient for the *k* th basis vector is given by the response of the *k* th neuron in the first level. The response is determined by a first-order differential equation implementing the prediction and error-correction cycle mentioned above. This equation, like the synaptic learning rule, is also derived by maximizing the posterior probability of generating the observed data (Methods). Thus, for any given input, the network converges to a set of neuronal responses optimal for predicting that input. These responses are then used to adapt the synaptic basis vectors. The same description applies to each level of the hierarchy, with each level predicting the inputs at its lower level using its set of learned basis vectors and, on a slower time scale, adapting these basis vectors to enable more accurate prediction of the inputs in the future.

After exposure to several thousand natural image patches, the basis vectors learned by the network at level 1 resembled oriented edges or bars ([Fig. 2b](https://www.nature.com/articles/nn0199_79#Fig2)), whereas the basis vectors at level 2 seemed to be composed of various combinations of the features represented at level 1 ([Fig. 2c](https://www.nature.com/articles/nn0199_79#Fig2)). The basis vectors can be regarded as approximate 'receptive fields' of the feedforward model neurons because they are the primary determinants of the neurons' feedforward responses [^26] [^32]. These RFs at level 1 are reminiscent of oriented Gabor or difference-of-Gaussian filters that have been used to model simple-cell RFs in primary visual cortex (for example, ref. [^7]). We used a Gaussian weighting profile to model the input dendritic arbor of the model neurons so that each set of the level 1 neurons only sees a localized portion of the entire input image. However, the model also learns localized receptive fields without a Gaussian spatial window if we impose the additional constraint of sparseness on the model neuron responses (Methods; [Fig. 2d](https://www.nature.com/articles/nn0199_79#Fig2)) [^26] [^32]. In this case, the wavelet-like basis vectors code for local oriented structures rather than being centered in the input window as in [Fig. 2b](https://www.nature.com/articles/nn0199_79#Fig2). These basis vectors and their level-2 counterparts were used for the simulations in [Fig. 6](https://www.nature.com/articles/nn0199_79#Fig6), whereas all other simulations used the basis vectors in [Fig. 2b and c](https://www.nature.com/articles/nn0199_79#Fig2).

![Figure 6: Nonclassical surround effects in the model.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2F4580/MediaObjects/41593_1999_Article_BFnn0199_79_Fig6_HTML.gif?as=webp)

Figure 6: Nonclassical surround effects in the model.

### Endstopped responses interpreted as error signals

Given an input image, the initial predictions at any given level are based on an arbitrary random combination of the basis vectors, giving large error signals. To minimize this error, the network converges to the responses that best predict the current input by subtracting the prediction from the input (via inhibition) and propagating the residual error signal to the neurons at the next level, which integrate this error and generate a better prediction (Methods).

The model neurons carrying the error signal (the 'error-detecting' neurons) send feedforward connections from the lower level to the higher level. In the visual cortex, feedforward connections to a higher area generally arise from the superficial layers (such as layer 2/3). A relatively large number of neurons in layer 2/3 of striate cortex (V1) show endstopping and related extra-classical effects [^2] [^3] [^33]. To ascertain whether these observed neuronal responses can be functionally interpreted as residual error signals, we recorded the responses of level-1 error-detecting neurons in the simulated network, when exposed to the image of a short dark bar lying within their RF ([Fig. 3a](https://www.nature.com/articles/nn0199_79#Fig3)). The solid box in the first panel ('Input') represents the RF size of the level-1 neurons (16 × 16 pixels), whereas the dotted box represents the level-2 RFs (16 × 26 pixels). The last two panels show the two components that determine the error signal. Many of the error-detecting neurons showed significant non-zero responses, demonstrating that feedback from level 2 could not completely predict the responses at level 1.

![Figure 3: Endstopping in the model network.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2F4580/MediaObjects/41593_1999_Article_BFnn0199_79_Fig3_HTML.gif?as=webp)

Figure 3: Endstopping in the model network.

On the other hand, when the bar stimulus extends beyond the classical receptive field into the flanking regions ([Fig. 3b](https://www.nature.com/articles/nn0199_79#Fig3)), the same error-detecting neurons showed little or no response because the predictions from level 2 were much more accurate, with prediction errors close to zero. Why are the level 2 predictions much more accurate for the longer bar than for the short bar? Recall that the network was trained on natural images. In natural images, short bars seldom occur in isolation; rather, a bar in a small region of an image is usually part of a longer bar that extends into neighboring regions. Because the network was optimized for natural image statistics, the most accurate predictions are generated when the input's properties match those of natural images. The continuation of the bar into the surrounding region provides the necessary context for the bar in the center to be predicted, much as in the case of retinal center-surround prediction mechanisms. Without this contextual information in the surrounding region, the higher level cannot accurately predict the bar in the center. The short bar thus elicits a relatively large response from the error-detecting neurons as compared to the longer bar.

This argument suggests that the autocorrelation along a dominant orientation in a local region in natural images extends over reasonably large distances. We tested this hypothesis on a set of natural images ([Fig. 4a](https://www.nature.com/articles/nn0199_79#Fig4)). Random locations were selected in these images, and the local oriented energy was computed by summing the squared outputs of quadrature pairs of filters. The orientation that maximized this energy measure was selected as the dominant orientation. Correlations in the dominant orientation direction and in the opposite direction in the natural image were then calculated along three different orientation directions (vertical, horizontal and diagonal) for several thousand random image locations ([Fig. 4b](https://www.nature.com/articles/nn0199_79#Fig4)). The average correlations along the dominant directions, especially the vertical and horizontal directions, remain relatively high for distances of up to plus or minus 50 pixels as compared to the correlations in the opposite direction. As a control, we repeated the experiment for three different natural image sizes (968 × 968, 484 × 484 and 242 × 242 pixels). In all three cases, higher correlations were observed in the dominant direction as compared to the opposite direction. (Results for a random white-noise image are shown in [Fig. 4c](https://www.nature.com/articles/nn0199_79#Fig4).)

![Figure 4: Autocorrelation along dominant orientation directions in natural images. ](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2F4580/MediaObjects/41593_1999_Article_BFnn0199_79_Fig4_HTML.jpg?as=webp)

Figure 4: Autocorrelation along dominant orientation directions in natural images.

To compare model neuron responses to neurophysiological data, we computed the tuning curves of model error-detecting neurons to bars of increasing length ([Fig. 3c](https://www.nature.com/articles/nn0199_79#Fig3)). The prediction from level 2 falls short of the actual level-1 responses for shorter bar lengths but gradually matches the actual response as the length of the bar is increased. This determines the model length-tuning curves, which closely resemble the tuning curves of layer 2/3 neurons in cat striate cortex ([Fig. 5a](https://www.nature.com/articles/nn0199_79#Fig5)). The model tuning curve is a parameter-free prediction of the data in the sense that it is determined by the statistics of the input natural images rather than by the physiological data. Thus, the close similarity between the model and physiological tuning curves is noteworthy. In the model, the average length of the bar eliciting maximal response was found to be approximately 4.5 pixels, the absolute RF sizes being approximately 5 × 10 pixels. For comparison, ref. [^3] reports RF sizes of 1° × 1.75° and 0.5° × 1.5° for two visual cortical neurons. These were maximally responsive to bars of length 1° and 0.5°, respectively.

![Figure 5: Predictive feedback and endstopping.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2F4580/MediaObjects/41593_1999_Article_BFnn0199_79_Fig5_HTML.gif?as=webp)

Figure 5: Predictive feedback and endstopping.

### Predictive feedback and extra-classical RF effects

The removal of feedback from level 2 to level 1 in the model caused previously endstopped neurons to continue to respond to bars of increasing lengths ([Fig. 5a](https://www.nature.com/articles/nn0199_79#Fig5)), supporting the hypothesis that predictive feedback is important in mediating endstopping in the level-1 model neurons. To quantify this result, we computed the distribution of endstopping ( [Fig. 5b](https://www.nature.com/articles/nn0199_79#Fig5)) in all 32 model layer 2/3 (error-detecting) neurons in the central level-1 module (see [Fig. 1c](https://www.nature.com/articles/nn0199_79#Fig1)) with and without feedback from level 2. The degree of endstopping was quantified as the percentage difference between peak response and average plateau response for lengths greater than 18 pixels: (peak – plateau)/peak × 100. Model neurons were classified into 10 categories according to their degree of endstopping, with 100% inhibition denoting a plateau response of zero to long bars. If we define endstopping as greater than 50% inhibition, 28 of the 32 model error-detecting neurons were endstopped with feedback intact. Disabling the feedback connections eliminated endstopping in all but 5 of these neurons, a reduction of 82%. The five neurons that continued to show some degree of endstopping after removal of feedback were those whose receptive field orientations were not completely aligned with that of the bar used for testing.

### Other extra-classical RF effects in the model

Several neurophysiological studies have reported nonclassical surround effects due to orientation contrast between the stimuli in the central classical RF region and the surrounding region [^33] [^35] [^36]. To investigate whether some of these effects could result from the extended positive correlations along dominant orientation directions in natural images ( [Fig. 4](https://www.nature.com/articles/nn0199_79#Fig4)), we trained a three-level hierarchical network, similar to the one used for the endstopping simulations, on ten different natural images. Rather than using a Gaussian window to localize receptive fields as in the endstopping experiments, we allowed the network to learn localized receptive fields by imposing a sparse prior distribution [^32] on the network responses (Methods). A total of nine level-1 modules arranged in three rows and three columns analyzed a local image patch (14 × 14 pixels). The outputs of these nine modules were input to the single level-2 module.

An oriented grating in the classical RF produced a robust response in a level-1 error-detecting model neuron in the simulated network ( [Fig. 6a](https://www.nature.com/articles/nn0199_79#Fig6)). This steady-state response was suppressed 85.3% when a grating at the same orientation was introduced in the surrounding extra-classical region, consistent with a reduction in the residual error signal due to better prediction from level 2 based on the surrounding context. Introducing an orientation contrast between the center and the surrounding region increased the model neuron response by 19.1% over the classical RF response, reflecting an increase in the residual error. Similar increases in neuronal responses due to cross-oriented grating stimuli have been reported in primary visual cortex [^36]. An optimally oriented grating restricted only to the surround elicited little response in the model neuron. We determined the response of a model neuron ([Fig. 6b](https://www.nature.com/articles/nn0199_79#Fig6)) to four different texture stimuli previously used in a macaque V1 study [^35]. The largest response was elicited by the 'pop-out' texture stimulus (compare with [Fig. 4](https://www.nature.com/articles/nn0199_79#Fig4) of ref. [^35] showing a similar response in a V1 neuron). For these stimuli, the spatial displacement of the central and surrounding bars in a particular direction sometimes modified a response from suppression to enhancement or vice versa, an effect attributable to the localized nature of the level-1 receptive fields ([Fig. 2d](https://www.nature.com/articles/nn0199_79#Fig2)). We also tested the response of an error-detecting model neuron ( [Fig. 6c](https://www.nature.com/articles/nn0199_79#Fig6)) to random texture stimuli used in a study of contextual modulation in alert macaque V1 (ref. [^33]). The tonic phase of the model neuron response reveals a large positive difference (93.5%) developing over time for the orientation-contrast texture as compared to the homogeneous texture. This modulation in response resembles the type of contextual modulation observed in V1 neurons (compare with [Fig. 2](https://www.nature.com/articles/nn0199_79#Fig2) of ref. [^33]).

## Discussion

Our simulation results suggest that certain extra-classical RF effects could be an emergent property of the cortex using an efficient hierarchical and predictive strategy for encoding natural images. In this model, cortical neurons showing extra-classical effects are interpreted as error-detecting neurons that signal the difference between an input and its prediction from a higher visual area. In particular, the layer 2/3 neurons that send axons to the higher visual area are posited to be likely candidates for this function. In the model, predictions are made based on progressively larger spatial contexts as one ascends the visual hierarchy. As a result, when the stimulus properties in a neuron's receptive field match the stimulus properties in the surrounding region, little response is evoked from the error-detecting neurons because the 'surround' can predict the 'center.' On the other hand, when the stimulus occurs in isolation, such a prediction fails, eliciting a relatively large response. This behavior can be viewed as a refinement of the types of predictive coding observed at the retina [^17] [^18] [^19] and the LGN [^20] [^21] involving spatiotemporal prediction based on weighted averages of spatially/temporally local pixels and subtraction of this prediction from current pixel values.

The model predicts that layer 2/3 neurons will respond most vigorously to stimuli whose statistics differ in certain drastic ways from natural image statistics (as in, for example, [Fig. 6](https://www.nature.com/articles/nn0199_79#Fig6)). This raises the interesting possibility of discovering novel extra-classical RF effects by explicitly constructing stimuli that deviate from natural image statistics. In addition, termination of cortical feedback should disinhibit the responses of layer 2/3 neurons that are suppressed by extra-classical stimuli under normal conditions. In anesthetized monkeys, inactivation of higher-order visual cortical areas disinhibits responses to surround stimuli in lower-area neurons [^37] (see also Hupé, J. M. *et al.*, *Soc. Neurosci. Abstr.* **23**, 1031, 1997 and James, A. C. *et al.*, *Soc. Neurosci. Abstr.* **21**, 904, 1995), consistent with the predictive coding model. In the cat, removal of feedback from visual cortical areas 17 and 18 to the LGN strongly reduces the degree of end-inhibition in LGN cells [^38]. Also, extra-classical RF effects in layer 2/3 neurons in alert monkey V1 often manifest themselves only 80–100 milliseconds after stimulus onset, suggesting that feedback from higher areas may be involved in mediating these effects [^33].

The simulation results show that extra-classical RF effects can occur in the predictive coding model under either Gaussian (Figs. [3](https://www.nature.com/articles/nn0199_79#Fig3) and [5](https://www.nature.com/articles/nn0199_79#Fig5)) or sparse kurtotic ( [Fig. 6](https://www.nature.com/articles/nn0199_79#Fig6)) prior distributions for the network activities. The issue of prior distributions has been much discussed [^12] [^31] [^32], with kurtotic distributions being favored because they can produce localized receptive fields and sparse codes. Our results suggest that the effects can be obtained under both sparse and non-sparse prior distributions, as long as one interprets the effects as being caused due to residual errors in prediction based on an internal model of natural image statistics.

The predictive coding model does not rule out the possibility that certain extra-classical contextual effects may result from recurrent lateral inhibition mediated by long-range horizontal connections within the same visual area [^39]. In fact, the equation for the dynamics of the network can be rewritten such that some of the effects of feedback are replaced by recurrent lateral interactions (Methods, Equation 8; Refs [^32],[^40]). In addition, the repetitive subtraction of neighboring neuronal activities (Equation 8) may produce a net effect similar to divisive normalization [^41], an operation that reproduces certain extra-classical effects in simulations (Simoncelli, E. P., results presented at the 1998 Center for Visual Science Symposium, Rochester, New York, 1998).

Some extra-classical RF effects involve facilitatory rather than inhibitory responses [^39]. In other words, the presence of a stimulus in the surround may facilitate rather than inhibit the neural response elicited by a stimulus in the center alone. Some examples of such facilitatory effects in the model are shown in [Fig. 6](https://www.nature.com/articles/nn0199_79#Fig6), but other facilitatory effects may reflect a bipolar strategy for encoding prediction errors. Because these errors can be either positive or negative, the cortex may use two distinct populations of neurons to signal errors, one for positive and another for negative errors, in analogy with the existence of on-center, off-surround and off-center, on-surround cells in the early visual pathway.

Although we have focused on interpreting responses in V1, the general idea of predictive coding may help explain certain responses in other brain regions as well. For example, some neurons in MT are suppressed when the direction of stimulus motion in the surrounding region matches that in the center of the classical RF [^6]. This suggests a hierarchical predictive coding strategy for motion analogous to the one suggested here for image features. Although the precise details of such a strategy are far from clear, a testable prediction of such a model would be a significant reduction in extra-classical effects in layer 2/3 neurons in MT upon inactivation of feedback from a higher area such as MST. Certain neurons in the anterior inferotemporal (IT) cortex of alert behaving monkeys fire vigorously whenever a presented test stimulus does not match the item held in memory, though showing little or no response in the case of a match [^42]. This suggests an interpretation of these responses in terms of residual error signals between a test stimulus and a predicted item from memory. Whether such a model can also account for the very specific face and view-sensitive cells in IT [^43] [^44] remains unclear (however, see ref. [^45]). A third example suggestive of predictive coding is the generation and subtraction of sensory expectations from actual inputs in cerebellum-like structures in several distinct classes of fishes [^46]. In this case, the sensory prediction is generated using not only recent sensory inputs but also corollary discharge or proprioceptive signals associated with motor commands. Finally, the responses of dopaminergic neurons projecting to the cortex and striatum from the midbrain can often be characterized as encoding reward prediction errors: large responses are elicited whenever actual rewards do not match the predicted rewards in a behavioral task [^47]. These examples suggest that the general idea of predictive coding may be applicable across different brain regions and modalities, providing a useful framework for understanding the general structure and function of the neocortex [^22] [^48].

## Methods

### Hierarchical generative model.

Consider an image **I** represented as a vector of *n* pixels. We assume that the cortex tries to represent the image in terms of hypothetical causes, as represented by a vector **r**. We characterize the relationship between the causes **r** and the image **I** using the function *f* and a matrix U:

where n is a stochastic noise process characterizing the differences between I and *f* (Ur).**Note that**

![](https://media.springernature.com/lw450/springer-static/image/art%3A10.1038%2F4580/MediaObjects/41593_1999_Article_BFnn0199_79_Equ2_HTML.gif)

where U <sub><i>j</i></sub> are columns of U, representing basis vectors for generating images.

Thus, each image **I** is assumed to be generated by a linear superposition of the basis vectors followed by a possible nonlinearity *f*. In terms of a neural network, the coefficients *r* <sub><i>j</i></sub> correspond to the activities or firing rates of neurons, whereas the basis vectors U <sub><i>j</i></sub> correspond to the synaptic weights of neurons. The function *f* (*x*) is the neuronal activation function, typically a sigmoidal function such as tanh(*x*). The coefficients *r* <sub><i>j</i></sub> can be regarded as the network's internal representation of the spatial characteristics of the image **I**, as interpreted using the internal model defined by the basis vectors U <sub><i>j</i></sub>.

To make this model hierarchical, we assume that the causes **r** themselves can be represented as a set of higher-level causes **r** <sup><i>h</i></sup> representing more abstract stimulus properties than the lower level. This yields the equation:

where r <sup><i>td</i></sup> = *f* (U <sup><i>h</i></sup> r <sup><i>h</i></sup>) is the 'top-down' prediction of r, and n <sup><i>td</i></sup> is a stochastic noise process.

Because the dendritic arbors of neurons can only span a finite spatial extent, we limit the size of **I** at the lowest level so that only a local portion of the actual image is being generated by a given set of causes **r**. The higher-level vector **r** <sup><i>h</i></sup>, however, generates several sets of these causes **r** associated with local neighboring image regions. Thus, a given image is generated by groups of local causes **r**, several groups being generated by a single higher-level vector **r** <sup><i>h</i></sup>, several of which are in turn generated by an even higher level of causes until the entire image is accounted for. This results in increasing receptive field size as one ascends the hierarchy, similar to that observed in the occipitotemporal visual pathway [^29]. To allow prediction in time for time-varying images, the model can be extended using a set of recurrent synaptic weights V that recursively transform the vector **r** ( *t*) at time *t* to the predicted vector **r** (*t+* 1) at time *t+* 1: **r** (*t+* 1) = *f* (V **r** (*t*)) + **m** where **m** is a noise process. Because static images sufficed for our simulation results, we did not use the temporal prediction component, but the interested reader is referred to refs 12 and 49 for more details.

### Optimization function.

The goal is to estimate, for each hierarchical level, the coefficients **r** for a given image and, on a longer time scale, learn appropriate basis vectors U <sub><i>j</i></sub> for each hierarchical level. Assuming that the noise terms **n** and **n** <sup><i>td</i></sup> are Gaussian with zero mean and variances σ <sup>2</sup> and σ <sub><i>td</i></sub> <sup>2</sup> respectively, one can write the following optimization function:

![](https://media.springernature.com/lw400/springer-static/image/art%3A10.1038%2F4580/MediaObjects/41593_1999_Article_BFnn0199_79_Equ4_HTML.gif)

where the superscript T denotes the transpose of a vector or matrix.

Note that *E* <sub>1</sub> is the negative logarithm of the probability of the data given the parameters. It is the sum of squared prediction errors for level 1 and level 2, each term being weighted by the respective inverse variances. Taking into account the prior distributions of **r** and U, one obtains the optimization function:

where *g* (r) and *h* (U) are the negative logarithms of the prior probabilities of r and U respectively.

For the endstopping simulations, we used Gaussian prior distributions for both these model parameters because this was sufficient to illustrate the properties of the model. This results in *g* (**r**) = α Σ <sub><i>i</i></sub> *r* <sub><i>i</i></sub> <sup>2</sup> and *h* (U) = λ Σ <sub><i>i,j</i></sub> U <sub><i>i,j</i></sub> <sup>2</sup> where α and Σ are positive constants related to the variance of the Gaussian prior distributions. Localized receptive fields can be obtained by using sparse kurtotic prior distributions for **r** (refs [^26],[^31]), e.g.,

![](https://media.springernature.com/lw450/springer-static/image/art%3A10.1038%2F4580/MediaObjects/41593_1999_Article_BFnn0199_79_Equ6_HTML.gif)

This choice was used for the extra-classical surround experiments in [Fig.6](https://www.nature.com/articles/nn0199_79#Fig6). Note that by Bayes Theorem, minimizing *E* is equivalent to maximizing the posterior probability of the model parameters given the input data. In the context of information theory, *E* can be interpreted as representing the cost of coding the errors and parameters in bits (in base *e*). Thus, minimizing *E* is equivalent to using the minimum description length principle [^50], which requires solutions to be not only accurate but also cheap in terms of coding length.

### Network dynamics and synaptic learning.

An optimal estimate of **r** can be obtained by performing gradient descent on *E* with respect to **r**:

![](https://media.springernature.com/lw400/springer-static/image/art%3A10.1038%2F4580/MediaObjects/41593_1999_Article_BFnn0199_79_Equ7_HTML.gif)

where *k* <sub>1</sub> is a positive constant governing the rate of descent towards a minimum for *E*, x = Ur, and *g* ´ is the derivative of *g* with respect to r. In the linear case (*f* (*x*) *\= x*),

![](https://media.springernature.com/lw43/springer-static/image/art%3A10.1038%2F4580/MediaObjects/41593_1999_Article_BFnn0199_79_Equa_HTML.gif)

is the identity matrix and in the case where *f* ( *x*) = tanh(*x*),

![](https://media.springernature.com/lw238/springer-static/image/art%3A10.1038%2F4580/MediaObjects/41593_1999_Article_BFnn0199_79_Equb_HTML.gif)

Similarly, for a Gaussian prior distribution, *g´* (r) = *2* α r and for the kurtotic prior distribution in Equation 6, *g* ´(*r* <sub><i>i</i></sub>) = *2* α r <sub>i</sub> /(1 *\+ r* <sub><i>i</i></sub> <sup>2</sup>) (ref. [^32]).

To modify **r** toward the optimal estimate (Equation 7), one needs the 'bottom-up' residual error (**I** – *f* (U **r**)) and the 'top-down' error (**r** <sup><i>td</i></sup> – **r**). The bottom-up error is multiplied by the transpose of the gradient and the basis matrix U <sup>T</sup>, and a decay term *g* ´(**r**) due to the prior probability of **r** is subtracted. Note that all the information required is available locally at each level. The weight accorded to the top-down and bottom-up errors is inversely proportional to their respective noise variances: the larger the noise variance, the smaller the weight (see ref. [^12]). In a neural implementation ( [Fig. 1b](https://www.nature.com/articles/nn0199_79#Fig1)), each row of the matrix U <sup>T</sup> corresponds to the synaptic weights of a single neuron.

In the linear case (*f* (*x*) *\= x*), the above dynamics can be rewritten to allow lateral interactions [^32] [^40]:

![](https://media.springernature.com/lw400/springer-static/image/art%3A10.1038%2F4580/MediaObjects/41593_1999_Article_BFnn0199_79_Equ8_HTML.gif)

where W = U <sup>T</sup> U.

In this implementation, the neural responses **r** undergo recurrent lateral inhibition due to the term

![](https://media.springernature.com/lw77/springer-static/image/art%3A10.1038%2F4580/MediaObjects/41593_1999_Article_BFnn0199_79_Equc_HTML.gif)

where the *i* th row of W represents the lateral weights for the *i* th neuron that maintains the estimate *r* <sub><i>i</i></sub>.

Such lateral connections between neurons maintaining **r** may thus also be involved in mediating some of the extra-classical RF effects observed in the visual cortex (see Discussion).

A synaptic learning rule for adapting the basis matrix U can be obtained by performing gradient descent on *E* with respect to U:

![](https://media.springernature.com/lw400/springer-static/image/art%3A10.1038%2F4580/MediaObjects/41593_1999_Article_BFnn0199_79_Equ9_HTML.gif)

where *k* <sub><i>2</i></sub> is a positive parameter determining the learning rate of the network and x = Ur.

Note that this learning rule is a form of Hebbian adaptation, the presynaptic activity being **r** and the postsynaptic activity being the residual error (**I** – *f* (U **r**))(see [Fig. 1b](https://www.nature.com/articles/nn0199_79#Fig1)).

Although the top-down feedback r <sup><i>td</i></sup> does not appear explicitly in the learning rule for U, it nevertheless influences the estimation of r (see Equation 7) and hence, also U.

### Simulations.

For the endstopping simulations, five natural images of different sizes ([Fig. 2a](https://www.nature.com/articles/nn0199_79#Fig2)) were first filtered using a center-surround difference-of-Gaussians operator to approximate processing at the levels of the retina and the LGN (see also ref. [^26]). During the training phase, three 16 × 16 overlapping Gaussian-windowed image patches (offset by 5 pixels horizontally) were input to the three level-1 modules ([Fig. 1c](https://www.nature.com/articles/nn0199_79#Fig1)). The responses from the level-1 modules at each time instant were input as a single vector to the level-2 module. The effective level-2 RF thus encompassed a 16 × 26 image region spanned by the three overlapping circles ([Fig. 2a](https://www.nature.com/articles/nn0199_79#Fig2)). For simplicity, a linear generative model ( *f* (*x*) *\= x*) was used in the endstopping simulations. Each level-1 module consisted of 32 feedforward neurons representing U <sup>T</sup> (size 32 × 256), 32 neurons that maintained **r** (according to equation 7), 32 error-detecting neurons that propagated to level 2 the top-down residual (**r** – **r** <sup><i>td</i></sup>), and a set of 256 feedback neurons whose synaptic efficacies encoded the rows of U and that conveyed the prediction U **r** to level 0. The level-2 module consisted of 128 feedforward neurons receiving inputs from the three level-1 modules, 128 neurons for maintaining **r** <sup><i>h</i></sup>, and 96 feedback neurons whose synapses encoded rows of U <sup><i>h</i></sup> and which conveyed the prediction U <sup><i>h</i></sup> **r** <sup><i>h</i></sup> to level 1. Parameter values: *k* <sub>1</sub> = 0.5, σ <sup>2</sup> = 1, σ <sub><i>td</i></sub> <sup>2</sup> = 10, α = 1 for level 1 and 0.05 for level 2, and λ = 0.02. The learning rate *k* <sub>2</sub> was initially set to 1 and decreased gradually by dividing with 1.015 after every 40 training inputs.

For the extra-classical RF simulations in [Fig. 6](https://www.nature.com/articles/nn0199_79#Fig6), a nonlinear hierarchical generative model (*f* (*x*) = tanh( *x*)) was used at levels 1 and 2 of the three-level hierarchical network, along with a kurtotic prior distribution for **r** (Equation 6). Nine level-1 modules, each with 32 feedforward model neurons and each analyzing a local 8 × 8 pixel image region, were arranged in a 3 × 3 overlapping configuration to analyze a 14 × 14 pixel image region. The level-2 module included 64 feedforward model neurons. The network was trained on ten prewhitened natural images and during training, the gain of each basis vector in U was adapted so as to maintain equal variance on each *r* <sub><i>i</i></sub> (see ref. [^26] for more details). The level-1 basis vectors were learned first, followed by the level-2 basis vectors.

## References

## Acknowledgements

We thank Christof Koch for comments on the manuscript and Mary Hayhoe, Terrence Sejnowski and members of the Computational Neurobiology Lab at the Salk Institute for discussions. This work was supported by research grants from the National Institute of Health (NIH), the National Science Foundation (NSF) and the Alfred P. Sloan Foundation.

## Rights and permissions

[^1]: Hubel, D. H. & Wiesel, T. N. Receptive fields and functional architecture in two non-striate visual areas (18 and 19) of the cat. *J. Neurophysiol.* **28**, 229–289 (1965).

[Article](https://doi.org/10.1152%2Fjn.1965.28.2.229) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaF2M%2FoslKgsg%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Receptive%20fields%20and%20functional%20architecture%20in%20two%20non-striate%20visual%20areas%20%2818%20and%2019%29%20of%20the%20cat.&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.1965.28.2.229&volume=28&pages=229-289&publication_year=1965&author=Hubel%2CDH&author=Wiesel%2CTN)

[^2]: Hubel, D. H. & Wiesel, T. N. Receptive fields and functional architecture of monkey striate cortex *. J. Physiol. (Lond.)* **195**, 215–243 (1968).

[Article](https://doi.org/10.1113%2Fjphysiol.1968.sp008455) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaF1c7lsF2jtg%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Receptive%20fields%20and%20functional%20architecture%20of%20monkey%20striate%20cortex&journal=.%20J.%20Physiol.%20%28Lond.%29&doi=10.1113%2Fjphysiol.1968.sp008455&volume=195&pages=215-243&publication_year=1968&author=Hubel%2CDH&author=Wiesel%2CTN)

[^3]: Bolz, J. & Gilbert, C. D. Generation of end-inhibition in the visual cortex via interlaminar connections. *Nature* **320**, 362–365 (1986).

[Article](https://doi.org/10.1038%2F320362a0) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL287nsFShuw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Generation%20of%20end-inhibition%20in%20the%20visual%20cortex%20via%20interlaminar%20connections.&journal=Nature&doi=10.1038%2F320362a0&volume=320&pages=362-365&publication_year=1986&author=Bolz%2CJ&author=Gilbert%2CCD)

[^4]: Hubel, D. H. & Livingstone, M. S. Segregation of form, color, and stereopsis in primate area 18. *J. Neurosci.* **7**, 3378–3415 (1987).

[Article](https://doi.org/10.1523%2FJNEUROSCI.07-11-03378.1987) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL1c%2FmtFGmsA%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Segregation%20of%20form%2C%20color%2C%20and%20stereopsis%20in%20primate%20area%2018.&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.07-11-03378.1987&volume=7&pages=3378-3415&publication_year=1987&author=Hubel%2CDH&author=Livingstone%2CMS)

[^5]: Desimone, R. & Schein, S. J. Visual properties of neurons in area V4 of the macaque: sensitivity to stimulus form. *J. Neurophysiol.* **57**, 835–868 ( 1987).

[Article](https://doi.org/10.1152%2Fjn.1987.57.3.835) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL2s7mvVKntQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Visual%20properties%20of%20neurons%20in%20area%20V4%20of%20the%20macaque%3A%20sensitivity%20to%20stimulus%20form.&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.1987.57.3.835&volume=57&pages=835-868&publication_year=1987&author=Desimone%2CR&author=Schein%2CSJ)

[^6]: Allman, J., Miezin, F. & McGuinness, E. Stimulus specific responses from beyond the classical receptive field: Neurophysiological mechanisms for local-global comparisons in visual neurons. *Annu. Rev. Neurosci.* **8**, 407–429 (1985).

[Article](https://doi.org/10.1146%2Fannurev.ne.08.030185.002203) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL2M7ntlSrtA%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Stimulus%20specific%20responses%20from%20beyond%20the%20classical%20receptive%20field%3A%20Neurophysiological%20mechanisms%20for%20local-global%20comparisons%20in%20visual%20neurons.&journal=Annu.%20Rev.%20Neurosci.&doi=10.1146%2Fannurev.ne.08.030185.002203&volume=8&pages=407-429&publication_year=1985&author=Allman%2CJ&author=Miezin%2CF&author=McGuinness%2CE)

[^7]: Dobbins, A., Zucker, S. W. & Cynader, M. S. Endstopped neurons in the visual cortex as a substrate for calculating curvature. *Nature* **329**, 438 –441 (1987).

[Article](https://doi.org/10.1038%2F329438a0) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL1c%2FhsVWksQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Endstopped%20neurons%20in%20the%20visual%20cortex%20as%20a%20substrate%20for%20calculating%20curvature.&journal=Nature&doi=10.1038%2F329438a0&volume=329&pages=438-441&publication_year=1987&author=Dobbins%2CA&author=Zucker%2CSW&author=Cynader%2CMS)

[^8]: Bolz, J., Gilbert, C. D. & Wiesel, T. N. Pharmacological analysis of cortical circuitry. *Trends Neurosci.* **12**, 292–296 (1989).

[Article](https://doi.org/10.1016%2F0166-2236%2889%2990009-X) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL1MzmvFOmtA%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Pharmacological%20analysis%20of%20cortical%20circuitry.&journal=Trends%20Neurosci.&doi=10.1016%2F0166-2236%2889%2990009-X&volume=12&pages=292-296&publication_year=1989&author=Bolz%2CJ&author=Gilbert%2CCD&author=Wiesel%2CTN)

[^9]: Peterhans, E. & von der Heydt, R. in *Representations of Vision. Trends and Tacit Assumptions* (eds Gorea, A., Frégnac, Y., Kapoulis, Z. & Findlay, J.) 111–124 (Cambridge Univ. Press, Cambridge, UK, 1991).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Representations%20of%20Vision.%20Trends%20and%20Tacit%20Assumptions&pages=111-124&publication_year=1991&author=Peterhans%2CE&author=von%20der%20Heydt%2CR)

[^10]: Grossberg, S., Mingolla, E. & Ross, W. D. Visual brain and visual perception: how does the cortex do perceptual grouping? *Trends Neurosci.* **20**, 106–111 (1997).

[Article](https://doi.org/10.1016%2FS0166-2236%2896%2901002-8) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK2sXhsFaguro%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Visual%20brain%20and%20visual%20perception%3A%20how%20does%20the%20cortex%20do%20perceptual%20grouping%3F&journal=Trends%20Neurosci.&doi=10.1016%2FS0166-2236%2896%2901002-8&volume=20&pages=106-111&publication_year=1997&author=Grossberg%2CS&author=Mingolla%2CE&author=Ross%2CWD)

[^11]: Peterhans, E. & von der Heydt, R. Subjective contours—bridging the gap between psychophysics and physiology. *Trends Neurosci.* **14**, 112–119 ( 1991).

[Article](https://doi.org/10.1016%2F0166-2236%2891%2990072-3) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK3M3jtlGmsA%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Subjective%20contours%E2%80%94bridging%20the%20gap%20between%20psychophysics%20and%20physiology.&journal=Trends%20Neurosci.&doi=10.1016%2F0166-2236%2891%2990072-3&volume=14&pages=112-119&publication_year=1991&author=Peterhans%2CE&author=von%20der%20Heydt%2CR)

[^12]: Rao, R. P. N. & Ballard, D. H. Dynamic model of visual recognition predicts neural response properties in the visual cortex. *Neural Comput.* **9**, 721–763 ( 1997).

[Article](https://doi.org/10.1162%2Fneco.1997.9.4.721) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK2szgsVKmug%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Dynamic%20model%20of%20visual%20recognition%20predicts%20neural%20response%20properties%20in%20the%20visual%20cortex.&journal=Neural%20Comput.&doi=10.1162%2Fneco.1997.9.4.721&volume=9&pages=721-763&publication_year=1997&author=Rao%2CRPN&author=Ballard%2CDH)

[^13]: Gallant, J. L., Connor, C. E. & Van Essen, D. C. Neural activity in areas V1, V2 and V4 during free viewing of natural scenes compared to controlled viewing. *Neuroreport* **9**, 2153–2158 ( 1998).

[Article](https://doi.org/10.1097%2F00001756-199806220-00045) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK1czjslelug%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20activity%20in%20areas%20V1%2C%20V2%20and%20V4%20during%20free%20viewing%20of%20natural%20scenes%20compared%20to%20controlled%20viewing.&journal=Neuroreport&doi=10.1097%2F00001756-199806220-00045&volume=9&pages=2153-2158&publication_year=1998&author=Gallant%2CJL&author=Connor%2CCE&author=Van%20Essen%2CDC)

[^14]: Attneave, F. Some informational aspects of visual perception. *Psychol. Rev.* **61**, 183–193 ( 1954).

[Article](https://doi.org/10.1037%2Fh0054663) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaG2c%2Foslalug%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Some%20informational%20aspects%20of%20visual%20perception.&journal=Psychol.%20Rev.&doi=10.1037%2Fh0054663&volume=61&pages=183-193&publication_year=1954&author=Attneave%2CF)

[^15]: MacKay, D. M. in *Automata Studies* (eds Shannon, C. E. & McCarthy, J.) 235– 251 (Princeton Univ. Press, Princeton, NJ, 1956).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Automata%20Studies&pages=235-251&publication_year=1956&author=MacKay%2CDM)

[^16]: Barlow, H. B. in *Sensory Communication* (ed. Rosenblith, W. A.) 217– 234 (MIT Press, Cambridge, MA, 1961).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Sensory%20Communication&pages=217-234&publication_year=1961&author=Barlow%2CHB)

[^17]: Atick, J. J. Could information theory provide an ecological theory of sensory processing? *Network Comput. Neural Sys.* **3**, 213– 251 (1992).

[Article](https://doi.org/10.1088%2F0954-898X_3_2_009) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Could%20information%20theory%20provide%20an%20ecological%20theory%20of%20sensory%20processing%3F&journal=Network%20Comput.%20Neural%20Sys.&doi=10.1088%2F0954-898X_3_2_009&volume=3&pages=213-251&publication_year=1992&author=Atick%2CJJ)

[^18]: Buchsbaum, G. & Gottschalk, A. Trichromacy, opponent colours coding and optimum colour information transmission in the retina. *Proc. R. Soc. Lond. B Biol. Sci.* **220**, 89– 113 (1983).

[Article](https://doi.org/10.1098%2Frspb.1983.0090) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL2c%2FpsFOisA%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Trichromacy%2C%20opponent%20colours%20coding%20and%20optimum%20colour%20information%20transmission%20in%20the%20retina.&journal=Proc.%20R.%20Soc.%20Lond.%20B%20Biol.%20Sci.&doi=10.1098%2Frspb.1983.0090&volume=220&pages=89-113&publication_year=1983&author=Buchsbaum%2CG&author=Gottschalk%2CA)

[^19]: Srinivasan, M. V., Laughlin, S. B. & Dubs A. Predictive coding: A fresh view of inhibition in the retina. *Proc. R. Soc. Lond. B Biol. Sci.* **216**, 427–459 (1982).

[Article](https://doi.org/10.1098%2Frspb.1982.0085) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL3s%2FptFWhsQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Predictive%20coding%3A%20A%20fresh%20view%20of%20inhibition%20in%20the%20retina.&journal=Proc.%20R.%20Soc.%20Lond.%20B%20Biol.%20Sci.&doi=10.1098%2Frspb.1982.0085&volume=216&pages=427-459&publication_year=1982&author=Srinivasan%2CMV&author=Laughlin%2CSB&author=Dubs%2CA)

[^20]: Dan, Y., Atick, J. J. & Reid, R. C. Efficient coding of natural scenes in the lateral geniculate nucleus: experimental test of a computational theory. *J. Neurosci.* **16**, 3351–3362 (1996).

[Article](https://doi.org/10.1523%2FJNEUROSCI.16-10-03351.1996) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK28XivVagur4%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Efficient%20coding%20of%20natural%20scenes%20in%20the%20lateral%20geniculate%20nucleus%3A%20experimental%20test%20of%20a%20computational%20theory.&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.16-10-03351.1996&volume=16&pages=3351-3362&publication_year=1996&author=Dan%2CY&author=Atick%2CJJ&author=Reid%2CRC)

[^21]: Dong, D. W. & Atick, J. J. Temporal decorrelation: a theory of lagged and nonlagged responses in the lateral geniculate nucleus. *Network Comput. Neural Sys.* **6**, 159– 178 (1995).

[Article](https://doi.org/10.1088%2F0954-898X_6_2_003) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Temporal%20decorrelation%3A%20a%20theory%20of%20lagged%20and%20nonlagged%20responses%20in%20the%20lateral%20geniculate%20nucleus.&journal=Network%20Comput.%20Neural%20Sys.&doi=10.1088%2F0954-898X_6_2_003&volume=6&pages=159-178&publication_year=1995&author=Dong%2CDW&author=Atick%2CJJ)

[^22]: Mumford, D. On the computational architecture of the neocortex. II. The role of cortico-cortical loops. *Biol. Cybern.* **66**, 241– 251 (1992).

[Article](https://link.springer.com/doi/10.1007/BF00198477) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK387ntlSjtw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=On%20the%20computational%20architecture%20of%20the%20neocortex.%20II.%20The%20role%20of%20cortico-cortical%20loops.&journal=Biol.%20Cybern.&doi=10.1007%2FBF00198477&volume=66&pages=241-251&publication_year=1992&author=Mumford%2CD)

[^23]: Pece, A. E. C. in *Artificial Neural Networks 2* (eds Aleksander, I. & Taylor, J.) 865–868 (Elsevier, Amsterdam, 1992).

[Book](https://doi.org/10.1016%2FB978-0-444-89488-5.50008-7) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Artificial%20Neural%20Networks%202&doi=10.1016%2FB978-0-444-89488-5.50008-7&pages=865-868&publication_year=1992&author=Pece%2CAEC)

[^24]: Softky, W. R. in *Advances in Neural Information Processing Systems 8* (eds Touretzky, D., Mozer, M. & Hasselmo, M.) 809–815 (MIT Press, Cambridge, MA, 1996).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Advances%20in%20Neural%20Information%20Processing%20Systems%208&pages=809-815&publication_year=1996&author=Softky%2CWR)

[^25]: Ullman, S. in *Large-Scale Neuronal Theories of the Brain* (eds Koch, C. & Davis, J. L.) 257–270 (MIT Press, Cambridge, MA, 1994).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Large-Scale%20Neuronal%20Theories%20of%20the%20Brain&pages=257-270&publication_year=1994&author=Ullman%2CS)

[^26]: Olshausen, B. A. & Field, D. J. Sparse coding with an overcomplete basis set: A strategy employed by V1? *Vision Res.* **37**, 3311–3325 ( 1997).

[Article](https://doi.org/10.1016%2FS0042-6989%2897%2900169-7) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK1c%2Fos1KrsQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Sparse%20coding%20with%20an%20overcomplete%20basis%20set%3A%20A%20strategy%20employed%20by%20V1%3F&journal=Vision%20Res.&doi=10.1016%2FS0042-6989%2897%2900169-7&volume=37&pages=3311-3325&publication_year=1997&author=Olshausen%2CBA&author=Field%2CDJ)

[^27]: Dayan, P., Hinton, G.E., Neal, R.M. & Zemel, R.S. The Helmholtz machine. *Neural Comput.* **7**, 889– 904, (1995).

[Article](https://doi.org/10.1162%2Fneco.1995.7.5.889) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK28%2FitVKrtA%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20Helmholtz%20machine.&journal=Neural%20Comput.&doi=10.1162%2Fneco.1995.7.5.889&volume=7&pages=889-904%2C&publication_year=1995&author=Dayan%2CP&author=Hinton%2CGE&author=Neal%2CRM&author=Zemel%2CRS)

[^28]: Luettgen, M. R. & Willsky, A. S. Likelihood calculation for a class of multiscale stochastic models, with application to texture discrimination. *IEEE Trans. Image Proc.* **4**, 194–207 (1995).

[Article](https://doi.org/10.1109%2F83.342185) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD1c7ivFyquw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Likelihood%20calculation%20for%20a%20class%20of%20multiscale%20stochastic%20models%2C%20with%20application%20to%20texture%20discrimination.&journal=IEEE%20Trans.%20Image%20Proc.&doi=10.1109%2F83.342185&volume=4&pages=194-207&publication_year=1995&author=Luettgen%2CMR&author=Willsky%2CAS)

[^29]: Felleman, D. J. & Van Essen, D. C. Distributed hierarchical processing in the primate cerebral cortex. *Cereb. Cortex* **1**, 1–47 ( 1991).

[Article](https://doi.org/10.1093%2Fcercor%2F1.1.1) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK38zltlGmsg%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Distributed%20hierarchical%20processing%20in%20the%20primate%20cerebral%20cortex.&journal=Cereb.%20Cortex&doi=10.1093%2Fcercor%2F1.1.1&volume=1&pages=1-47&publication_year=1991&author=Felleman%2CDJ&author=Van%20Essen%2CDC)

[^30]: Field, D. J. Relations between the statistics of natural images and the response properties of cortical cells. *J. Opt. Soc. Am. A* **4**, 2379–2394 (1987).

[Article](https://doi.org/10.1364%2FJOSAA.4.002379) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL1c7hsl2jsw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Relations%20between%20the%20statistics%20of%20natural%20images%20and%20the%20response%20properties%20of%20cortical%20cells.&journal=J.%20Opt.%20Soc.%20Am.%20A&doi=10.1364%2FJOSAA.4.002379&volume=4&pages=2379-2394&publication_year=1987&author=Field%2CDJ)

[^31]: Bell, A. J. & Sejnowski, T. J. The "independent components" of natural scenes are edge filters. *Vision Res.* **37**, 3327–3338 (1997).

[Article](https://doi.org/10.1016%2FS0042-6989%2897%2900121-1) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK1c%2Fos1Krtg%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20%22independent%20components%22%20of%20natural%20scenes%20are%20edge%20filters.&journal=Vision%20Res.&doi=10.1016%2FS0042-6989%2897%2900121-1&volume=37&pages=3327-3338&publication_year=1997&author=Bell%2CAJ&author=Sejnowski%2CTJ)

[^32]: Olshausen, B. A. & Field, D. J. Emergence of simple-cell receptive field properties by learning a sparse code for natural images. *Nature* **381**, 607– 609 (1996).

[Article](https://doi.org/10.1038%2F381607a0) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK28XjsFylur8%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Emergence%20of%20simple-cell%20receptive%20field%20properties%20by%20learning%20a%20sparse%20code%20for%20natural%20images.&journal=Nature&doi=10.1038%2F381607a0&volume=381&pages=607-609&publication_year=1996&author=Olshausen%2CBA&author=Field%2CDJ)

[^33]: Zipser, K., Lamme, V. A. F. & Schiller, P. H. Contextual modulation in primary visual cortex. *J. Neurosci.* **16**, 7376–7389 (1996).

[Article](https://doi.org/10.1523%2FJNEUROSCI.16-22-07376.1996) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK28Xntlegur0%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Contextual%20modulation%20in%20primary%20visual%20cortex.&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.16-22-07376.1996&volume=16&pages=7376-7389&publication_year=1996&author=Zipser%2CK&author=Lamme%2CVAF&author=Schiller%2CPH)

[^34]: Sandell, J. H. & Schiller, P. H. Effect of cooling area 18 on striate cortex cells in the squirrel monkey. *J. Neurophysiol.* **48**, 38–48 (1982).

[Article](https://doi.org/10.1152%2Fjn.1982.48.1.38) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL3s%2FgvFagsg%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Effect%20of%20cooling%20area%2018%20on%20striate%20cortex%20cells%20in%20the%20squirrel%20monkey.&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.1982.48.1.38&volume=48&pages=38-48&publication_year=1982&author=Sandell%2CJH&author=Schiller%2CPH)

[^35]: Knierim, J. & Van Essen, D. C. Neural responses to static texture patterns in area V1 of the alert macaque monkey. *J. Neurophysiol.* **67**, 961–980 ( 1992).

[Article](https://doi.org/10.1152%2Fjn.1992.67.4.961) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK383mvV2ktA%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20responses%20to%20static%20texture%20patterns%20in%20area%20V1%20of%20the%20alert%20macaque%20monkey.&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.1992.67.4.961&volume=67&pages=961-980&publication_year=1992&author=Knierim%2CJ&author=Van%20Essen%2CDC)

[^36]: Sillito, A. M., Grieve, K. L., Jones, H. E., Cudeiro, J. & Davis, J. Visual cortical mechanisms detecting focal orientation discontinuities. *Nature* **378**, 492–496 (1995).

[Article](https://doi.org/10.1038%2F378492a0) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK2MXps1ymu78%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Visual%20cortical%20mechanisms%20detecting%20focal%20orientation%20discontinuities.&journal=Nature&doi=10.1038%2F378492a0&volume=378&pages=492-496&publication_year=1995&author=Sillito%2CAM&author=Grieve%2CKL&author=Jones%2CHE&author=Cudeiro%2CJ&author=Davis%2CJ)

[^37]: Hupé, J. M. et al. Cortical feedback improves discrimination between figure and background by V1, V2 and V3 neurons. *Nature* **394** , 784–787 (1998).

[Article](https://doi.org/10.1038%2F29537) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Cortical%20feedback%20improves%20discrimination%20between%20figure%20and%20background%20by%20V1%2C%20V2%20and%20V3%20neurons.&journal=Nature&doi=10.1038%2F29537&volume=394&pages=784-787&publication_year=1998&author=Hup%C3%A9%2CJM)

[^38]: Murphy, P. C. & Sillito, A. M. Corticofugal feedback influences the generation of length tuning in the visual pathway. *Nature* **329**, 727–729 (1987).

[Article](https://doi.org/10.1038%2F329727a0) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL1c%2FjvFSntQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Corticofugal%20feedback%20influences%20the%20generation%20of%20length%20tuning%20in%20the%20visual%20pathway.&journal=Nature&doi=10.1038%2F329727a0&volume=329&pages=727-729&publication_year=1987&author=Murphy%2CPC&author=Sillito%2CAM)

[^39]: Gilbert, C. D. Adult cortical dynamics. *Physiol. Rev.* **78**, 467–485 (1998).

[Article](https://doi.org/10.1152%2Fphysrev.1998.78.2.467) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK1c3itVGjsQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Adult%20cortical%20dynamics.&journal=Physiol.%20Rev.&doi=10.1152%2Fphysrev.1998.78.2.467&volume=78&pages=467-485&publication_year=1998&author=Gilbert%2CCD)

[^40]: Lee, D. D. & Seung, H. S. in *Advances in Neural Information Processing Systems 9* (eds Mozer, M., Jordan, M. & Petsche, T.) 515–521 (MIT Press, Cambridge, MA, 1997).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Advances%20in%20Neural%20Information%20Processing%20Systems%209&pages=515-521&publication_year=1997&author=Lee%2CDD&author=Seung%2CHS)

[^41]: Heeger, D. J., Simoncelli, E. P. & Movshon, J. A. Computational models of cortical visual processing. *Proc. Natl. Acad. Sci. USA* **93**, 623– 627 (1996).

[Article](https://doi.org/10.1073%2Fpnas.93.2.623) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK28XnslOntQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Computational%20models%20of%20cortical%20visual%20processing.&journal=Proc.%20Natl.%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.93.2.623&volume=93&pages=623-627&publication_year=1996&author=Heeger%2CDJ&author=Simoncelli%2CEP&author=Movshon%2CJA)

[^42]: Miller, E. K., Li, L. & Desimone, R. A neural mechanism for working and recognition memory in inferior temporal cortex. *Science* **254**, 1377–1379 (1991).

[Article](https://doi.org/10.1126%2Fscience.1962197) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK38%2Fntl2jug%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20neural%20mechanism%20for%20working%20and%20recognition%20memory%20in%20inferior%20temporal%20cortex.&journal=Science&doi=10.1126%2Fscience.1962197&volume=254&pages=1377-1379&publication_year=1991&author=Miller%2CEK&author=Li%2CL&author=Desimone%2CR)

[^43]: Gross, C. G. & Sergent, J. Face recognition. *Curr. Opin. Neurobiol.* **2**, 156–161 (1992).

[Article](https://doi.org/10.1016%2F0959-4388%2892%2990004-5) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK38zksF2jtw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Face%20recognition.&journal=Curr.%20Opin.%20Neurobiol.&doi=10.1016%2F0959-4388%2892%2990004-5&volume=2&pages=156-161&publication_year=1992&author=Gross%2CCG&author=Sergent%2CJ)

[^44]: Logothetis, N. K. & Pauls, J. Psychophysical and physiological evidence for viewer-centered object representations in the primate. *Cereb. Cortex* **5**, 270–288 (1995).

[Article](https://doi.org/10.1093%2Fcercor%2F5.3.270) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK2MzjslKmtQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Psychophysical%20and%20physiological%20evidence%20for%20viewer-centered%20object%20representations%20in%20the%20primate.&journal=Cereb.%20Cortex&doi=10.1093%2Fcercor%2F5.3.270&volume=5&pages=270-288&publication_year=1995&author=Logothetis%2CNK&author=Pauls%2CJ)

[^45]: Poggio, T. & Edelman, S. A network that learns to recognize 3D objects. *Nature* **343**, 263– 266 (1990).

[Article](https://doi.org/10.1038%2F343263a0) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK3c7js1yqug%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20network%20that%20learns%20to%20recognize%203D%20objects.&journal=Nature&doi=10.1038%2F343263a0&volume=343&pages=263-266&publication_year=1990&author=Poggio%2CT&author=Edelman%2CS)

[^46]: Bell, C., Bodznick, D., Montgomery, J. & Bastian, J. The generation and subtraction of sensory expectations within cerebellum-like structures. *Brain Behav. Evol.* **50** Suppl. 1, 17–31 (1997).

[Article](https://doi.org/10.1159%2F000113352) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20generation%20and%20subtraction%20of%20sensory%20expectations%20within%20cerebellum-like%20structures.&journal=Brain%20Behav.%20Evol.&doi=10.1159%2F000113352&volume=50&pages=17-31&publication_year=1997&author=Bell%2CC&author=Bodznick%2CD&author=Montgomery%2CJ&author=Bastian%2CJ)

[^47]: Schultz, W. *et al.* in *Models of Information Processing in the Basal Ganglia* (eds Houk, J. C., Davis, J. L. & Beiser, D. G.) 233– 248 (MIT Press, Cambridge, MA, 1995).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Models%20of%20Information%20Processing%20in%20the%20Basal%20Ganglia&pages=233-248&publication_year=1995&author=Schultz%2CW)

[^48]: Creutzfeldt, O. D. Generality of the functional structure of the neocortex. *Naturwissenschaften* **64**, 507–517 ( 1977).

[Article](https://link.springer.com/doi/10.1007/BF00483547) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaE1c%2FltFWmtA%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Generality%20of%20the%20functional%20structure%20of%20the%20neocortex.&journal=Naturwissenschaften&doi=10.1007%2FBF00483547&volume=64&pages=507-517&publication_year=1977&author=Creutzfeldt%2COD)

[^49]: Rao, R. P. N. An optimal estimation approach to visual perception and learning. *Vision Res.* (in press).

[^50]: Rissanen, J. *Stochastic Complexity in Statistical Inquiry* (World Scientific, Singapore, 1989).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Stochastic%20Complexity%20in%20Statistical%20Inquiry&publication_year=1989&author=Rissanen%2CJ)