---
title: "Theta-paced flickering between place-cell maps in the hippocampus: A model based on short-term synaptic plasticity"
source: "https://pmc.ncbi.nlm.nih.gov/articles/PMC5575492/"
author:
  - "[[Shirley Mark]]"
  - "[[Sandro Romani]]"
  - "[[Karel Jezek]]"
  - "[[Misha Tsodyks]]"
published: 2017-09-01
created: 2026-08-10
description: "Continuous attractor network of two overlapping place-cell populations (2 x 2500 units, sparse selectivity f = 0.25, competing through global inhibition, 10 Hz theta drive) with short-term synaptic plasticity. Theta-paced flickering after teleportation is produced by a synaptic rebound: after the cue switch the previously active map keeps facilitated recurrent synapses (x recovers faster than u relaxes), raising its gain, while theta troughs periodically reset the inhibitory competition. Mixed states appear at the START of a theta cycle and resolve by its end. Predictions confirmed on re-analysis of the Jezek et al. 2011 data: flicker count vs. theta power partial r = 0.44 (p = 2e-16); vs. average distance from the switch position partial r = -0.157 (p = 0.027), with distance and velocity confounded (c = 0.64). A no-STP noise-driven network flickers at constant probability with no dependence on teleportation, so the post-switch transient is the STP signature. No increase in flicker count across a day, i.e. no learning linking the two maps. Hippocampus 27:959-970, doi:10.1002/hipo.22743. Carries the Jezek et al. 2011 (Nature 478:246-249) dataset, which is itself closed-access."
tags:
  - "clippings"
  - "hippocampus"
  - "map-selection"
  - "attractor-networks"
  - "neural-oscillations"
  - "short-term-plasticity"
---

Title: Theta‐paced flickering between place‐cell maps in the hippocampus: A model based on short‐term synaptic plasticity

URL Source: 

Markdown Content:
## Abstract

Hippocampal place cells represent different environments with distinct neural activity patterns. Following an abrupt switch between two familiar configurations of visual cues defining two environments, the hippocampal neural activity pattern switches almost immediately to the corresponding representation. Surprisingly, during a transient period following the switch to the new environment, occasional fast transitions between the two activity patterns (flickering) were observed (Jezek, Henriksen, Treves, Moser, & Moser, 2011). Here we show that an attractor neural network model of place cells with connections endowed with short‐term synaptic plasticity can account for this phenomenon. A memory trace of the recent history of network activity is maintained in the state of the synapses, allowing the network to temporarily reactivate the representation of the previous environment in the absence of the corresponding sensory cues. The model predicts that the number of flickering events depends on the amplitude of the ongoing theta rhythm and the distance between the current position of the animal and its position at the time of cue switching. We test these predictions with new analysis of experimental data. These results suggest a potential role of short‐term synaptic plasticity in recruiting the activity of different cell assemblies and in shaping hippocampal activity of behaving animals.

**Keywords:**attractor neural network, CA3, hippocampus, memory, place cell, recurrent neural network, teleportation, theta

## INTRODUCTION

1
The hippocampus plays a critical role in spatial memory (Morris, Garrud, Rawlins, & O'Keefe, 1982; Nakazawa, McHugh, Wilson, & Tonegawa, 2004; Scoville and Milner, 1957). Neurons in the hippocampus fire at specific locations in the environment, the place fields (O'Keefe and Dostrovsky, 1971), and their activity is modulated by the ongoing theta rhythm (Buzsaki, 2002; Vanderwolf, 1969). The ensemble of active place cells in an environment defines a “map” of that environment (O'Keefe and Nadel, 1978). Partially overlapping populations of place cells are active in different environments (Muller and Kubie, 1987; Wills, Lever, Cacucci, Burgess, & O'Keefe, 2005). This phenomenon is referred to as global remapping (Fyhn, Hafting, Treves, Moser, & Moser, 2007; Leutgeb et al., 2005). The activation of a map is determined both by external sensory inputs (Muller and Kubie, 1987) and self‐motion cues from the medial entorhinal cortex (Fyhn et al., 2007; McNaughton et al., 1996; Wang, Romani, Lustig, Leonardo, & Pastalkova, 2015).

Jezek et al. (2011) examined the dynamics of global remapping in the CA3 region of the hippocampus following an abrupt switch of visual cues (“teleportation”). Two sets of visual cues elicited the activity of two different maps. During a few seconds following the abrupt switch in sensory cues, hippocampal activity transiently alternated between the two maps before settling into the new map (flickering). The transient nature of flickering suggests the presence of some form of short‐term memory. Following teleportation, the correlation between the instantaneous neural activity and the representation of the previously visited environment almost vanishes (Jezek et al., 2011), suggesting that short‐term memory cannot be maintained by reverberatory activity in CA3. These findings add to the evidence that place cell activity is not entirely driven by sensory cues but rather influenced by internally generated and history dependent activity (Cei, Girardeau, Drieu, Kanbi, & Zugaro, 2014; Diba and Buzsáki, 2007; Foster and Wilson, 2006, 2007; MacDonald, Lepage, Eden, & Eichenbaum, 2011; Pastalkova, Itskov, Amarasingham, & Buzsaki, 2008; Pfeiffer and Foster, 2013).

Internal representations of different environments and the spatial locations within the environment have been hypothesized to be stored in the form of attractor states in hippocampal circuits (McNaughton and Morris, 1987; Treves and Rolls, 1992; Tsodyks, 1999). According to the continuous attractor neural networks (CANN) modeling framework, each map is composed of labeled populations of neurons, where each neuron encodes a different position in the environment (Tsodyks and Sejnowski, 1995; Tsodyks, Skaggs, Sejnowski, & McNaughton, 1996). The synaptic strength between neurons decreases with the distance between the positions encoded by the neurons. This local excitation, together with long‐range inhibition, promotes the formation of a spatially localized activity profile on the map. CANN models can encode multiple spatial maps by superimposing synaptic structures related to place field locations in the corresponding environments. Global inhibitory feedback induces a competition between the maps (Battaglia and Treves, 1998; Monasson and Rosay, 2015; Samsonovich and McNaughton, 1997; Hedrick & Zhang, 2016).

In the CANN framework, the switch in sensory cues would cause the hippocampal model network to undergo a fast transition to the corresponding map, resulting in instantaneous remapping. The mechanism for reverse transitions (flickering) is less obvious. Flickering might be triggered by random fluctuations in population activity (Stella and Treves, 2011), but this would not account for the transient dynamics of flickering. To explain the transient nature of the flickering phenomenon, we considered CANN with short‐term synaptic plasticity (STP, e.g. Fung, Wong, Wang, & Wu, 2012).

There are several indications of STP presence in area CA3 of the hippocampus (Miles and Wong, 1986; Salin, Scanziani, Malenka, & Nicoll, 1996; Selig, Nicoll, & Malenka, 1999; Guzman et al., 2016). CANN with STP can account for several circuit dynamics observed in the hippocampus, such as phase precession, activity replays, and activity during the delay period of a spatial memory task (Romani and Tsodyks, 2015; Wang et al., 2015). In this contribution we show that CANN whose synapses are endowed with STP can account for the appearance of flickering events following the switch of environments. More specifically, the recurrent connections between neurons that were active in the previous environment remain temporarily facilitated following the switch in the cues. During a few theta cycles following the switch, the map of the new environment that receives stronger sensory inputs and the previously active map with facilitated recurrent connections compete via global inhibition. As a result, the previous map can be transiently reactivated due to theta modulations of population activity. We further test model predictions by analyzing data from Jezek et al. (2011).

## METHODS

2
### The model

2.1
We modeled the CA3 neural network as a network that stores the maps of two 2D environments (Figure 1a). To avoid complications due to boundary conditions, each environment was modeled as a torus of units with mutual inhibition between the tori. Each unit can be thought of as representing a pool of neurons with highly overlapping place fields. The similarity in the firing of place cells with nearby preferred locations allows for the definition of a firing rate (_m_), representing the average spiking activity of the pooled neurons. The connectivity between the units depends on the distance between the locations encoded by the units (Figure 1b) (Ben‐Yishai, Bar‐Or, & Sompolinsky, 1995; Conklin and Eliasmith, 2005; Pinto and Ermentrout, 2001; Romani and Tsodyks, 2010; Wilson and Cowan, 1973; Zhang 1996). Further, there are inhibitory connections between all units. Each unit receives a theta‐modulated input and a place specific input (see below). The network dynamics is described by the following equations (1)$\tau \frac{d m_{i}^{}}{d t} = - m_{i}^{} + g \left(\right. I_{_{i}}^{} \left(\right. t \left.\right) \left.\right) \\ I_{_{i}}^{} \left(\right. t \left.\right) = \sum_{j = 1}^{N} J_{\text{ij}} x_{j} \left(\right. t \left.\right) u_{j} \left(\right. t \left.\right) m_{j} \left(\right. t \left.\right) + I_{_{\text{ext}}}^{i} \left(\right. t \left.\right) + I_{0} \\ J_{\text{ij}} = \sum_{k = 1}^{2} \xi_{i}^{k} \xi_{j}^{k} J_{1} \left(\right. cos ⁡ \left(\right. \varphi_{_{j}}^{k , 1} - \varphi_{_{i}}^{k , 1} \left.\right) + cos ⁡ \left(\right. \varphi_{_{j}}^{k , 2} - \varphi_{_{i}}^{k , 2} \left.\right) \left.\right) - J_{0} \\ g \left(\right. z \left.\right) = \alpha l o g \left(\right. 1 + e^{\frac{z}{\alpha}} \left.\right)$where $m_{i}^{} \left(\right. t \left.\right)$ is the firing rate of unit _i_ with two‐dimensional place field center $\left(\right. \varphi_{_{i}}^{k , 1} , \varphi_{_{i}}^{k , 2} \left.\right)$ in map _k_. Each unit _i_ in the network (_i = 1…N_) is characterized by a binary vector of selectivity for the two environments, $\xi_{i}^{k}$, where _i = 1…N_ and _k =_ 1,2. The selectivity for each environment (_k_) is assigned randomly from large pool of units such that $\xi_{i}^{k} = 1$ with probability _f_, and zero otherwise (_f =_ 0.25). In the Supplement Information Figure S12 we plot the dependence of the number of flickering events on _f_. Following assignment we only simulated the units that had assignment to one of the maps such each map contains exactly 2,500 units. With this choice of network size the linear spatial resolution in a map is $\frac{2 \pi}{50}$ rad. $\tau$ is the integration time constant of the units (chosen to be of the same order of magnitude as the typical membrane time constant, tens of milliseconds), _J_ 1 is the synaptic efficacy of the distance dependent component in the network connectivity; _J_ 0 determines the strength of the uniform feedback inhibition (Figure 1b). We re‐analyzed the experimental data from Jezek et al. (2011) and checked whether the number of flickering events increases during each day. Increase in events number may imply learning and therefore not uniform and increased synaptic connectivity between the map. We did not find any increase in flickering events, therefore we conclude that there is no learning that connect the 2 maps (Supplamentary Information Figure S13). _I_ 0 is the background input. _g_(_z_) is the transfer function of the neurons; For large negative inputs, the firing rate increases exponentially with the input, while for large positive inputs _g_(_z_) is linear. α determines the width of the transition region between the exponential and the linear regimes. The shape of the transfer function may reflect heterogeneity in excitability of single neurons within a rate unit. The transfer function does not include a saturating non‐linearity at high input because the firing rate of the units are far from physiological saturation levels. The connections between the units are endowed with activity dependent short‐term synaptic plasticity (Figure 1c). Synaptic efficacy is modulated by the fraction of available synaptic resources (_x_) and the release probability (_u_). The release probability is increased (facilitated) every time a spike arrives; therefore it increases with presynaptic firing rate, while synaptic resources decrease following a spike and therefore decrease with presynaptic firing rate. In the absence of pre‐synaptic firing, _x_ and _u_ recover to their baseline values, _1_ and _U_, with time constants τ r and τ f, respectively (e.g. Tsodyks, Pawelzik, & Markram, 1998): (2)$\frac{d u_{i}}{d t} = \frac{U - u_{i} \left(\right. t \left.\right)}{\tau_{f}} + U \left(\right. 1 - u_{i} \left(\right. t \left.\right) \left.\right) m_{i} \left(\right. t \left.\right) \\ \frac{d x_{i}}{d t} = \frac{1 - x_{i} \left(\right. t \left.\right)}{\tau_{r}} - u_{i} \left(\right. t \left.\right) x \left(\left(\right. t \left.\right)\right)_{i} m_{i} \left(\right. t \left.\right)$

Figure 1
(

Schematic diagram of the model. (a) Two overlapping populations of firing rate units encoding maps of two environments. Upon switch of the external cues, part of the sensory inputs switches to the other map, while other localized cues are resistant to the switch. Both networks receive a spatially uniform theta‐modulated input. (b) Connectivity within a single population. Connectivity within a torus is dependent on the distance between the locations encoded by the units. Connectivity between tori is unstructured and inhibitory. The color code represents the synaptic strength between the unit denoted by the asterisk and all the other units that belong to the map (Blue, weak connections. Red, strong connections). (c) An example of the dynamics of a synapse endowed with short‐term plasticity. The amount of synaptic resources (_x_) decreases with increasing pre‐synaptic firing rate; the release probability (_u_) increases with firing rate. The product ( $u \cdot x$) determines the overall modulation of the synaptic efficacy Color figure can be viewed at [wileyonlinelibrary.com]

All units receive an external input, $I_{_{\text{ext}}}^{i} \left(\right. t \left.\right)$, which is composed of a theta modulated input, $I_{\theta} \left(\right. t \left.\right) = A_{\theta} sin ⁡ \left(\right. 2 \pi f_{\theta} t \left.\right)$, with amplitude _A_ θ and frequency $f_{\theta}$=_10Hz_, and a moving localized input. (3)$I_{\text{ext}}^{i} \left(\right. t \left.\right) = I_{\theta} \left(\right. t \left.\right) + \left(\right. A_{\text{local}}^{i} \left.\right) \left(\right. \left[\right. cos ⁡ \left(\left(\right. \varphi_{_{i}}^{k , 1} - \phi^{1} \left(\right. t \left.\right) \left]\right.\right)_{+} + \left(\left[\right. cos ⁡ \left(\right. \varphi_{_{i}}^{k , 2} - \phi^{2} \left(\right. t \left.\right) \left.\right) \left]\right.\right)_{+} \left.\right) + \eta_{i}^{} \left(\right. t \left.\right)$The amplitude of the localized input $A_{\text{local}}^{i}$ is composed of two terms; one denotes the contribution from external cues that do not change upon switching (_A_ 1) while the other originates from the cues (_A_ 2) that change upon teleportation, (Figure 1). Therefore the external cues are segregated into two types, depending on whether they are changed or maintained upon teleportation

$\left(\right. \phi^{1} \left(\right. t \left.\right) , \phi^{2} \left(\right. t \left.\right) \left.\right)$ denotes the animal location, []+ is the linear threshold function. For units that belong to the map that encodes the current environment _A_ local _= A_ 1 _+A_ 2 while for the other units _A_ local _= A_ 2.

In most network simulations we chose $\left(\right. \phi^{1} \left(\right. t \left.\right) = \phi^{2} \left(\right. t \left.\right) \left.\right)$ as the virtual animal trajectory. For the results presented in Supporting Information Figure S3, we used real animal trajectory that were taken from Jezek et al. 2011.

In some of the simulations (see results) we added colored noise (a time correlated noise) input $\eta_{i} \left(\right. t \left.\right)$ to the units (with time constant $\tau_{N}$ chosen to be the same as the time constant of integration of the rate units), that behaves according to the following equation: (4)$\tau_{N} \frac{d \eta_{i}}{d t} = - \eta_{i} + A_{n} \xi_{i} \left(\right. t \left.\right)$$\xi_{i} \left(\right. t \left.\right)$ is a spatially uncorrelated Gaussian white noise.

To identify flickering events in the noisy simulations, we band‐pass filtered the average network activity in the theta range (8–12 Hz) and segmented theta cycles based on the minima of the filtered network activity.

To examine the activity and synaptic efficacy of the units that encode the current location in each map, we averaged the firing rate and synaptic efficacy of units that have their place field center in the region defined by $\left(\right. cos ⁡ \left(\right. \varphi_{_{i}}^{1} - \phi^{1} \left(\right. t \left.\right) \left.\right) > 0.5 \left.\right) a n d \left(\right. cos ⁡ \left(\right. \varphi_{_{i}}^{2} - \phi^{2} \left(\right. t \left.\right) \left.\right) > 0.5 \left.\right)$.

Results in Figures 4, 5, 6 are obtained by averaging several realizations of the model.

All deterministic simulations have been calculated using MATLAB ode45 solver, that is, adaptive Runge‐Kutta. The simulations with noise have been calculated using Euler method with dt = 0.1ms. The parameters used in the simulations are written in table 1 and 2 (deviations from these parameters are mentioned in the legend of the relevant figure).

### Analysis of the electrophysiological data from Jezek et al. (2011)

2.2
#### Rate maps and flickering events definition

2.2.1
Data analysis was performed similarly to Jezek et al. (2011). Briefly, all the data was speed‐filtered such that only theta cycles in which the rat ran faster than 5 cm s−1 were included and tracking artifact were excluded (>100 cm s−1). Epochs longer than 0.05 s that did not include tracking data were excluded from the analysis. Rate maps with 30 × 30 spatial bins of 2 cm × 2 cm were created for each environment by calculating the firing rate of each recorded neuron within every bin, during the reference sessions, in which the animal walked in each environment without switching, and smoothing the map with a Gaussian filter (see end of Methods). During teleportation trials (trials that include the sudden switch of sensory cues) a vector of cell firing rates was calculated for each theta cycle (see Jezek et al., 2011 for details). A flickering event was defined as a theta cycle in which the activity vector during the cycle had significant low correlation with the rate map of the current environment and significant high correlation with the map of the other environment. The significance levels were determined by calculating a vector of cell firing rates for each theta cycle during the reference sessions and creating distributions of correlation coefficient values between these activity vectors and the rate maps of each environment. For each rate map, there are two different distributions; the first distribution corresponds to correlations with activity vectors of the same environment and the second distribution corresponds to correlations with activity vectors of the other environment. The threshold for low correlation was defined as the 5 percentile of the distribution corresponding to the current environment and the high threshold as the 95 percentile of the distribution corresponding to the other environment (see also Jezek et al., 2011).

We filtered the LFP in the theta band in order to estimate the activity vectors within individual theta cycles (as in Jezek et al., 2011). Briefly, the filter was constructed using a hamming window. Frequencies of 5 and 6 Hz were chosen for the low passband and stopband cutoff frequencies and frequencies of 10 and 11 Hz for the high passband and stopband cutoff frequencies. Theta phase of minimum activity was found by assigning a phase from 0° to 360° to each spike. The phase assigned to each spike was interpolated linearly according to the times of successive peak and trough and the spike time (every interpolation was in the range [0,180] degrees). The phase with the minimal firing rate was chosen for segregating the signal into theta cycles.

#### Correlation coefficient between the number of flickering events and theta power or average distance

2.2.2
To assess theta power (5–10 Hz) during periods of increased flickering probability (see Results), average theta power was calculated for each period between 250 ms before the first network transition to the correct representation and 5 s after the transition (the results shown in Figure 5 are robust to changes in the definition of this period, see Supporting Information Figure S4). Theta power of the un‐filtered EEG signal was normalized by the wide band power (1–125 Hz, results were unaffected by the chosen normalization band). According to our model, the probability of observing a flickering event depends on the distance between animal position at network transition time (referred to as “switching position”) and its current position. Therefore, we examined the correlation between the number of flickering events and this average distance (see Results). Average distance from the switching position was calculated over the 5 s that follow network transition. As mentioned above we only considered epochs with rat speed higher than 5 cm s−1. During the recordings there are short epochs with tracking artifact and low animal velocity. Hence, during the epochs around the switch there are short time bins in which flickering cannot be estimated. To overcome the resulting bias for low number of flickering events (during trials with larger number of such bins) we normalized the number of flickers to the relevant time interval: $n_{\left[\right. \frac{\text{flicker}}{s} \left]\right.} = \frac{N_{\text{flickers}}}{\left(\right. 1 - p_{\text{lowV}} \left.\right) T}$_N_ flickers is the number of flickering events; _p_ lowV is the fraction of time bins with tracking artifact or of low velocity during the tested epoch (_T_). We ignore switch trials with high percentage (>50%) of theta cycles with low velocity or tracking artifact.

Theta power and the average distance from switch positions are correlated, therefore, in order to estimate the correlation between the number of flickering events and those variables we calculated the partial correlation coefficient (Howell, 2009). The flicker number, theta power and average distance are not normally distributed; hence, the _p_ values for the partial correlation coefficient were calculated by constructing shuffled distributions of correlation coefficients. For each shuffle, we permuted the vector of flickering events number, while keeping the pairs of distance and theta power, such that the correlation between these two variables remains. While calculating the partial correlations we included the average firing rate in the interval around the stimulus switch (defined above) as a control variable.

Gaussian filters’ weights: GF = [0.0025 0.0125 0.0200 0.0125 0.0025;…0.0125 0.0625 0.1000 0.0625 0.0125;…0.0200 0.1000 0.1600 0.1000 0.0200;…0.0125 0.0625 0.1000 0.0625 0.0125;…0.0025 0.0125 0.0200 0.0125 0.0025]

## RESULTS

3
Following previous studies (Battaglia and Treves, 1998; Romani and Tsodyks, 2015; Samsonovich and McNaughton, 1997; Tsodyks, 1999; Tsodyks et al., 1996), we modeled a hippocampal place map as a manifold of units, with each unit representing the average firing rate of neurons with highly overlapping place fields. The recurrent connections between the units decay with the distance between the locations encoded by the units (Figure 1b). The connections between the units are symmetric such that a continuous attractor is formed (Ben‐Yishai et al., 1995; Tsodyks, 1999; Tsodyks et al., 1996). Each position is encoded by a “bump” of activity on the manifold. Two maps of different environments are modeled as two overlapping populations of units that compete through global inhibition (Tsodyks, 1999). The synaptic connections are endowed with activity dependent short‐term plasticity (STP, Figure 1c). The units receive theta‐modulated input and spatially localized inputs. The localized input to the units is of two types: visual cues that are changed immediately as the environment is changed, and other external cues such as olfactory cues and motion integration (Figure 1a) that are stable upon switching.

### Flickering occurs after switching

3.1
In the model, similar to the experiment, switching the visual input results in an almost immediate transition of activity from one map to the other. During most theta cycles the activity of the population that encodes the new environment is larger than the activity of the other population. During a brief period following network transition to the current representation we observed several theta cycles in which the activity of the population that represents the previous environment becomes larger (flickering event, Figure 2, Figure 4a; for other distance dependent connectivity matrix see Supporting Information Figure S1, for a real animal trajectory see Supporting Information Figure S3, 4 and S5).

Figure 2
(

Flickering in networks with short‐term synaptic plasticity. Network activity dynamics. Each panel shows the activity of each unit in a map (single pixel), averaged across a theta cycle (colorcode: firing rate (Hz), first and third rows: map A, second and fourth rows: map B). Flickering events can be observed following the switch of external cues (red circle, _t_ = 17.5s, 17.6 s). The red dot denotes the location of the virtual animal (peak external input). Note that the simulations do not include a noisy input Color figure can be viewed at [wileyonlinelibrary.com]

### Flickering results from short‐term synaptic plasticity

3.2
During each cycle of the external oscillatory theta input there is a competition between the two populations due to global inhibition and the connectivity within each map. The input to the populations and the network's gain, which depends on the strength of the synaptic connections, determine which map wins the competition. Without short‐term synaptic plasticity both populations have the same gain, therefore the input strength alone determines which population would win and flickering is not expected (unless strong enough noise is present, see below). In the presence of STP, the recurrent connections between neurons encoding the previous environment remain temporarily facilitated following the switch in the cues (Figure 4a, Supporting Information Figure S2). As a result, the previous map can win the competition and be transiently reactivated.

To characterize the contribution of STP to flickering, we first examined the dynamics of a single synapse in response to a pulse in pre‐synaptic firing rate. A sharp increase in firing rate produces a transient increase of the synaptic efficacy (_ux_). Following stimulus termination, the synaptic resources (_x_) recover faster than the relaxation of the release probability (_u_). Hence, a synaptic rebound appears, the synaptic efficacy grows before decaying to the steady state value (Figure 3a, middle panel). The synaptic rebound arises from short‐term synaptic facilitation, as decreasing the ratio between facilitation and depression reduces rebound amplitude (Figure 3b). The dependency on the baseline release probability (_U_) is non‐monotonic; the difference between the maximal synaptic efficacy and the baseline reaches maximal values for intermediate baseline utilization values (Figure 3b). The synaptic rebound depends on the presynaptic firing rate: A higher firing rate results in larger synaptic modification that will be followed by a higher rebound (Figure 3b).

Figure 3
(

Synaptic rebound dynamics. (a) Synaptic efficacy (ux) changes following a transient input. Note the transient increase of synaptic efficacy following a sharp increase or decrease in presynaptic firing rate (synaptic rebound). The magnitude of the rebound increases with the ratio between facilitation and depression time constants (top vs. middle panels). (b) Rebound (maximal efficacy (ux) ‐U) response to a firing rate pulse (2 s). Each panel shows the rebound amplitude (color coded) for different facilitation/depression time constant ratios and baseline release probability U. Different panels: different firing rate pulse amplitudes (E). Higher ratio between facilitation and depression time constants results in larger rebound response. Note that the dependency on the baseline release probability U is nonmonotonic. An increase in the firing rate pulse produces a larger activation of the synapses resulting in a higher rebound Color figure can be viewed at [wileyonlinelibrary.com]

In a network, a stronger and longer‐lasting synaptic rebound following stimulus offset, compared to the initial response to stimulus onset, would increase the gain of the previously active population compared to the gain of the new one (Supporting Information Figure S2), therefore we expect a tendency of the network to produce a flickering event. To confirm this we examined the average activity and the synaptic efficacy of the units that encode the current location in each map (Figure 4a, see Methods); upon network transitioning to the map that represents the current environment, the difference between the rebound response of the synapses in the previously active map and the initial response of synapses in the currently active map increases until a flicker event is generated and subsequent events can take place until the network reaches a steady state (Figure 4a). Note that each flickering event could produce an additional synaptic rebound and thus allows the network to produce additional flickering events. This mechanism allows the network to transiently sustain flickering for time scales exceeding any time scale of the system. It should be noted that there is a parameter regime in which baseline flickering exists (Supporting Information Figure S7).

Figure 4
(

**Effect of short‐term synaptic plasticity on the occurrence of flickering events.** (a) Average firing rate of the units that encode the current location (upper panel, see methods) and corresponding average synaptic efficacies (lower panel), red—units in the previously active population, black—units in the population encoding the new environment. The occurrence of flickering events depends on the difference between the synaptic efficacies (lower panel) in the two populations. _A_ θ = 12 Hz other parameters as in Figure 2. (b) Influence of the ratio between facilitation and depression time constants on the number of flickering events. Black line, average number of flickering events over different $\tau_{r}$( $0.6 \leq \tau_{r} \leq 0.8$). Colored dots: single simulation results; each color corresponds to different $\tau_{r}$. A θ = 12Hz, other parameters as in Figure 2. (c) Effect of baseline release probability U on the number of flickering events for different amplitudes of theta modulation (see also Supporting Information Figure S11) Color figure can be viewed at [wileyonlinelibrary.com]

The occurrence of flickering events is a robust phenomenon of the model that does not require fine‐tuning of the parameters (Figure 4). The magnitude of the rebound response depends on synaptic parameters (Figure 3b), in particular, on the ratio between facilitation and depression time constants (_T_ f/_T_ r, Figure 3a), and the level of synaptic activation (i.e., firing rate, Figure 3b). Hence, the number of flickering events depends both on synaptic parameters (Figure 4b,c, Supporting Information Figure S11) and network activity.

A closer look at the dynamics during flickering reveals that at the beginning of each theta cycle (Figure 4a) the activities of both populations grow until the activity of one population dominates over the other. Hence, states in which both populations are simultaneously active (mixed states) can appear at the beginning of theta cycle but not at the end, as observed in the experimental data (Hasselmo, Clara, & Bradley, 2002; Jezek et al., 2011; Redish, 1999; Redish and Touretzky, 1998). Note that the competition between the attractors is governed by the difference in the localized external inputs to the maps. Decrease in this difference results in increase number of flickering events (Supporting Information Figure S8).

### Flickering probability is affected by theta power and animal position

3.3
According to our model, the increase in flickering probability for a few seconds following the switch in the environment results from STP. In the map corresponding to the old environment, synapses between the units encoding the recently active place fields are facilitated. Hence, we expect an increased flickering probability the closer the virtual animal is to the place field of the units that were recently active in the old environment, such that there is an overlap between the place cells that receive localized external input and the place cells with increased synaptic efficacies (model, Figure 5a). The animal should be close to its previously visited position during short time interval following the switch; otherwise the synaptic memory will decay.

Figure 5
(

Flickering depends on theta power and animal position after the switch in environment. (a) The number of flickering events ( $n_{\text{Flicker}}$) increases with theta amplitude and decreases with distance from switch position ‐ model. Each square shows the number of flickering events during 5s after the switch (color coded), from a simulation with different theta amplitude ( $\frac{A_{\theta}}{\left|\right. I_{0} \left|\right.}$) and virtual animal speed (constant during the simulation), which results in a different average distance from the switch position during 5 s following the switch. (b) Data: Each dot represents the number of flickering event per seconds in a time window of 5s after the switch of sensory cues (color coded,) from a single trial, characterized by (i) The average distance of the animal position in the time window (ii) Normalized theta power around the switch. Partial correlation coefficient between theta power and $n_{F l i c ker ⁡}$ was 0.44 with _p_ value < 0.001. Partial correlation coefficient between V and _n_ Flickers was −0.15 with _p_ value<0.05 (see methods) Color figure can be viewed at [wileyonlinelibrary.com]

In simulations with high amplitude oscillatory theta input, as in the results described above (Figure 2), the activity of all units decreases once every cycle. This decrease in activity reduces global inhibition and therefore resets the competition from one cycle to the next, allowing the reactivation of the old environment. With lower theta amplitude, network activity may not decrease enough to reset the competition. Further, as mentioned above, the higher the activity the higher the tendency to produce a flickering event. The peak activity in the network increases with theta power. Hence, stronger theta would result in higher tendency to produce flickering events following a switch of the environment.

In summary, our model predicts that the number of flickering events should (i) decrease with the distance that the animal travels after the switch in environments and (ii) increase with the theta power during the time window near the switch (Figure 5a). We analyzed the experimental data (Jezek et al., 2011) and estimated the number of flickering events as a function of the average distance from the switching position (a small distance would imply that the animal stayed close to the previously active place fields in the old environment). We also estimated the normalized theta power during epoch of several seconds around the switch (see Methods). We observed that the number of flickering events increases with theta power and decreases with the average distance (data, Figure 5b, Supporting Information Figures S6 and S9), in agreement with the prediction of the model (partial correlation coefficient between the theta power and the number of flickering events is 0.44, _p_< 0.001 ( $p = 2 \cdot 10^{- 16}$) and partial correlation coefficient between the average distance and the number of flickering events is _−_ 0.157, _p_< 0.05 ( $p = 0.027$). It is important to note that average velocity and distance are strongly correlated, _c_ = 0.64, $p = 10^{- 17}$, therefore it is not possible to disambiguate their contribution to flickering (Supporting Information Figure S9, Figure S10).

### The role of noise in flickering

3.4
As discussed above, a lower theta amplitude results in a reduction of the number of flickering events and even their disappearance (Figures 5 and 6a). The presence of noise in networks that would otherwise exhibit no flickering events may increase the range of parameters in which flickering can occur (Figure 6a). The noise may originate from several sources (Faisal, Selen, & Wolpert, 2008).

Figure 6
(

Noise increases flickering probability. (a) Average number of flickering events (over five different realizations) for different amplitudes of theta modulation and noise strength. Network with STP in the synaptic connections (parameters as in Figure 2, see Table 1). (b) As in (a), but the synapses in the network have no STP. (c) Time course of the number of flickering events (averaged over two different noise values, _A_ n = 0.01, 0.025, and 5 network realizations) for a network with STP in the synaptic connections. The probability of flickering exhibits a transient increase as a result of STP. _A_ θ = 12 Hz, all other parameters are the same as in Figure 2. (d) Time course of the number of flickering events in a network without STP in the synaptic connections. The probability of flickering events is approximately constant throughout the simulation. Parameters: _A_ n = 0.3, 0.4. (e) Network with STP: time course of the number of flickering events for different noise and theta amplitudes (averaged over five realizations). Higher theta and noise amplitude results in higher probability for flickering events and longer transient increase in flickering probability. (3) _A_ θ = 12 Hz, _A_ n = 0.01 (4) _A_ θ = 12 Hz, _A_ n = 0.025 (1) _A_ θ = 11 Hz, _A_ n = 0.01 (2) A θ = 11 Hz, _A_ n = 0.025. (f) As in (e) for a network without STP. Flickering probability is constant in time for all noise and theta amplitudes. _A_ θ = 62 Hz, _A_ n = 0.3, _A_ θ = 62 Hz, _A_ n = 0.4, _A_ θ = 60 Hz, _A_ n = 0.3, _A_ θ = 60 Hz, _A_ n = 0.4 Color figure can be viewed at [wileyonlinelibrary.com]

Noise may also induce flickering in a network without STP. In this network, as in a network with synaptic connections that are endowed with STP, the overall number of flickering events increases with the amplitude of the fluctuating input and theta amplitude (Figure 6b). Note, however that flickering probability is approximately constant and exhibits no dependence on teleportation (Figure 6d), in contradiction to experimental observations. The presence of STP results in a transient increase of the flickering probability following teleportation (Figure 6c). The transient period of increased flickering probability depends both on theta and the noise amplitude (Figure 6e), the noise enables the occurrence of flickering events when the gain of the previous map is not large enough to enable flickering by itself. Further, noise and theta increase the baseline flickering probability in both models (Figure 6e,f).

## DISCUSSION

4
We developed a model that suggests a mechanism for the flickering in CA3 activity patterns between two maps following a fast switch of sensory cues. We further test predictions of the model. Jezek et al. (2011) showed that during most theta cycles there is a period in which only one map is active; therefore, the existence of flickering events suggests the presence of short‐term memory not mediated by neuronal activity in CA3. In our model short‐term memory is being held by short‐term plastic synapses (see also Mongillo, Barak, & Tsodyks, 2008). We chose to model hidden short‐term memory using a synaptic mechanism, though we cannot exclude other forms of short‐term memory such as intrinsic adaptation/facilitation.

The model is a continuous attractor neural network composed of two overlapping populations that compete with each other as a result of global inhibition. A stimulus to one of the populations, the one representing the map of the current environment, results in the activation of that map. Following a switch in the external inputs to the other map, the activity can fluctuate back and forth between the maps (flickering) until it converges to the map that represents the current environment. The flickering occurs as a result of a temporarily increased gain of the previously active map due to short‐term synaptic plasticity, which induces the competition between the maps.

Each flickering event results in the activation of the previously active map and therefore affects the short‐term dynamics of synapses in that map. Following the subsequent reactivation of the map that represents the current environment, the effective synaptic efficacy of the other map increases again as a result of STP rebound. This alternating process enables the occurrence of several flickering events, during a time period which can be longer compared to the time constants of the neurons and synapses. We further examined the effect of theta power and animal distance from its position at the time of the switch both in the experimental data and in the model. We showed that a smaller average distance from the switch position and higher theta power results in an increased number of flickering events.

We examined the dependence of flickering on synaptic release probability and synaptic time constant. We predict that manipulating calcium dynamics in the synapses will affect flickering dynamics. Further, in our model, as a feature of competitive attractor neural network, the similarity of the external inputs between the two environments will affect the number of flickering. We therefore predict that influencing the similarity of the two environments for example, by choosing environments from a morphed sequence (Wills et al., 2005) will shape the number of flickering events.

A possible alternative explanation for the flickering phenomenon is that flickering events are inherited from external inputs as a result of sensory cues that are common to both environments together with noise (Figure 6b). However, fluctuation in sensory input would not account for the transient increase in flickering probability after teleportation (Figure 6c,d).

Flickering was also observed in a neural network with one population of neurons that encodes multiple environments (Monasson and Rosay, 2015). The purpose of that study was to examine the mechanism of spontaneous transitions (flickering) between the two representations, but the temporal dynamics of the flickering probability was not discussed.

Place cells integrate external sensory inputs with path integration cues from entorhinal cortex (McNaughton et al., 1996; Touretzky and Redish, 1996). During the switch between environments the animal remains at the same arena, hence, the path integration is not disrupted by the switch. An alternative model may involve the dynamics of the path‐integration inputs. A scenario in which the grid network does not remap following the switch but remaps after integration of hippocampal inputs, could result in a transient increase of flickering probability following the switch due to decreased difference between the external inputs to the two maps as long as there is no remapping in EC. This model would not explain the dependency of flickering on the animal location in the arena and it is unclear how it could account for the time‐scale of increased flickering (several seconds) following the switch (an analysis of this modeling scenario is outside the scope of this work).

Previous theoretical studies reinforce the role of short‐term synaptic plasticity in the hippocampus of behaving animals. Continuous attractor models with dynamical synapses can account for several observations of place cell dynamics such as phase precession, sharp waves and activity replays (Romani and Tsodyks, 2015), and the dynamics of episode (or time) cells in the hippocampus (Gill, Mizumori, & Smith, 2011; MacDonald, Carrow, Place, & Eichenbaum, 2013; Pastalkova et al., 2008; Wang et al., 2015). Short‐term synaptic plasticity may also assume a role in stabilizing circuit dynamics. Inhomogeneities in the synaptic connections or synaptic depression mechanisms may result in a fast drifting of the localized activity bump (Tsodyks et al., 1996; York and Van Rossum, 2009). It is natural to assume that the connectivity in the hippocampus is not perfectly tuned; therefore, a mechanism for slowing down the drift of the activity bump is important. Synaptic facilitation may be a good candidate mechanism for slowing down the drift (Itskov, Hansel, & Tsodyks, 2011). The agreement of our model with the experimental results and the previous modeling efforts point to short‐term synaptic plasticity mechanism as a strong determinant in the recruitment of different cell assemblies in hippocampal circuits.

The functional relevance of flickering to hippocampus encoding is an open question. Hippocampus is involved in the process of choosing the right context to reach a decision (Dupret, O'neill, & Csicsvari, 2013; Jackson and Reddish, 2007; Kelemen and Fenton, 2010;) and planning an action, which may be mediated by “mental time travel” (Botzung, Denkova, & Manning, 2008; Hopfield, 2010; Pfeiffer and Foster, 2013; Suddendorf and Corballis, 2007; Wikenheiser and Redish, 2015). It is now being established that the hippocampus represents different environments or context with orthogonal cells assemblies (Fyhn et al., 2007; Malvache, Reichinnek, Villette, Haimerl, & Cossart, 2016; Wills et al., 2005). When the external cues for the correct context are ambiguous, hippocampus may alternate between possible representations (cell assemblies) in order to facilitate the selection of the right context for the task (see also Savin, Dayan, & Lengyel, 2014). It is possible that the occurrence of flickering reflects a state that favors mental exploration. In this state, network parameters are adjusted such that the probability to switch between the different representations increases. The increased flickering probability enables “reexamination” of the alternative contexts by downstream areas (Botzung et al., 2008) and reflects higher flexibility of CA3 network during the process of context selection. The activity in those areas may shift hippocampal activity to the other, alternative context. Further, our model suggests that controlling network parameters such as the synaptic properties (by different neuromodulators), or modulating theta input may shift the tendency of the hippocampus to wander between different representations.

Table 1

τ (s)0.01
_U_ 0.25
τ r (s)0.6
τ f (s)1.9
_A_ 1 (Hz)4
_A_ 2 (Hz)0.5
_A_ θ (Hz)13
_V_ (rad s−1)2π/10
_J_ 1$\frac{14 \cdot 2 \pi}{N}$
_J_ 0$\frac{- 18 \cdot 2 \pi}{N_{}}$
_I_ 0 (Hz)−1
α 1

Table 2

τ (s)0.01
_A_ 1 (Hz)3.25
_A_ 2 (Hz)0.75
_A_ θ (Hz)60
_V_ (rad s−1)2π/10
_J_ 1$\frac{35 \cdot 2 \pi}{N}$
_J_ 0$\frac{- 42 \cdot 2 \pi}{N_{}}$
_I_ 0 (Hz)−1
α 1

## Supporting information

Supporting Appendix 1

Supporting Appendix 2

Supporting Figure 1

Supporting Figure 2

Supporting Figure 3

Supporting Figure 4

Supporting Figure 5

Supporting Figure 6

Supporting Figure 7

Supporting Figure 8

Supporting Figure 9

Supporting Figure 10

Supporting Figure 11

Supporting Figure 12

Supporting Figure 13

## 

Mark S ,  Romani S ,  Jezek K ,  Tsodyks M . T heta‐paced flickering between place‐cell maps in the hippocampus: A model based on short‐term synaptic plasticity. _Hippocampus_. 2017;27:959–970.  doi: 10.1002/hipo.22743

## 

## Funding Statement

## ACKNOWLEDGMENTS

The authors thank Dr. Bailu Si and Dr. Eva Pastalkova for comments on the manuscript.

## REFERENCES

*   . Battaglia, F. P. , & Treves, A.  (1998). Attractor neural networks storing multiple space representations: A model for hippocampal place fields. _Physical Review E_, 58(6), 7738–7753.  [Google Scholar]
*   . Ben‐Yishai, R. ,  Bar‐Or, R. L. , & Sompolinsky, H.  (1995). Theory of orientation tuning in visual cortex. _Proceedings of the National Academy of Sciences of United States of America_, 92(9), 3844–3848. doi: 10.1073/pnas.92.9.3844  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Botzung, A. ,  Denkova, E. , & Manning, L.  (2008). Experiencing past and future personal events: Functional neuroimaging evidence on the neural bases of mental time travel. _Brain and Cognition_, 66, 202–2012. doi: 10.1016/j.bandc.2007.07.011  [DOI] [PubMed] [Google Scholar]
*   . Brandon, M. P. ,  Koenig, J. ,  Leutgeb, J. K. , & Leutgeb, S.  (2014). New and distinct hippocampal place codes are generated in a new environment during septal inactivation. _Neuron_, 82(4), 789–796. doi: 10.1016/j.neuron.2014.04.013  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Buzsaki, G.  (2002). Theta oscillations in the hippocampus. _Neuron_, 31(3), 325–340. doi: 10.1016/s0896-6273(02)00586-x  [DOI] [PubMed] [Google Scholar]
*   . Cei, A. ,  Girardeau, G. ,  Drieu, C. ,  Kanbi, K. E. , & Zugaro, M.  (2014). Reversed theta sequences of hippocampal cell assemblies during backward travel. _Nature Neuroscience_, 17(5), 719–724. doi: 10.1038/nn.3698  [DOI] [PubMed] [Google Scholar]
*   . Conklin, J. , & Eliasmith, C.  (2005). A controlled attractor network model of path integration in the rat. _Journal of Computational Neuroscience_, 18:183–203. doi: 10.1007/s10827-005-6558-z  [DOI] [PubMed] [Google Scholar]
*   . Diba, K. , & Buzsáki, G.  (2007). Forward and reverse hippocampal place‐cell sequences during ripples. _Nature Neuroscience_, 10(10), 1241–1242. doi: 10.1038/nn1961  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Dupret, D. ,  O'neill, J. , & Csicsvari, J.  (2013). Dynamic reconfiguration of hippocampal interneuron circuits during spatial learning. _Neuron_, 78, 166–180. doi: 10.1016/j.neuron.2013.01.033  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Faisal, A. ,  Selen, L. P. J. , & Wolpert, D. M.  (2008). Noise in the nervous system. _Nature Reviews Neuroscience_, 9(4), 292–303. doi: 10.1038/nrn2258  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Fung, C. C. A. ,  Wong, K. Y. M. ,  Wang, H. , & Wu, S.  (2012). Dynamical synapses enhance neural information processing: Gracefulness, accuracy and mobility. _Neural Computation_, 24(5), 1147–1185. doi: 10.1162/NECO_a_00269  [DOI] [PubMed] [Google Scholar]
*   . Foster, D. J. , & Wilson, M. A.  (2006). Reverse replay of behavioural sequences in hippocampal place cells during the awake state. _Nature_, 440(7084), 680–683. doi: 10.1038/nature04587  [DOI] [PubMed] [Google Scholar]
*   . Foster, D. J. , & Wilson, M. A.  (2007). Hippocampal theta sequences. _Hippocampus_, 17(11), 1093–1099. doi: 10.1002/hipo.20345  [DOI] [PubMed] [Google Scholar]
*   . Fyhn, M. ,  Hafting, T. ,  Treves, A. ,  Moser, M. B. , & Moser, E. I.  (2007). Hippocampal remapping and grid realignment in entorhinal cortex. _Nature_, 446(7132), 190–194. doi: 10.1038/nature05601  [DOI] [PubMed] [Google Scholar]
*   . Gill, P. R. ,  Mizumori, S. J. Y. , & Smith, D. M.  (2011). Hippocampal episode fields develop with learning. _Hippocampus_, 21(11), 1240–1249. doi: 10.1002/hipo.20832  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Guzman, S. J. ,  Schlögl, A. ,  Frotscher, M. , & Jonas, P.  (2016). Synaptic mechanisms of pattern completion in the hippocampal CA3 network. _Science_, 353(6304), 1117–1123. doi: 10.1126/science.aaf1836  [DOI] [PubMed] [Google Scholar]
*   . Hasselmo, M. E. ,  Clara, B. , & Bradley, P. W.  (2002). A proposed function for hippocampal theta rhythm: Separate phases of encoding and retrieval enhance reversal of prior learning. _Neural Computation_, 14(4), 793–817. doi: 10.1162/089976602317318965  [DOI] [PubMed] [Google Scholar]
*   . Hedrick, K. R. , & Zhang, K.  (2016). Megamap: flexible representation of a large space embedded with nonspatial information by a hippocampal attractor network. _Journal of neurophysiology_, 116(2), 868–891. doi: 10.1152/jn.00856.2015  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Hopfield, J. J.  (2010). Neurodynamics of mental exploration. _Proceeding of the National Academy of Science of United States of America_, 107(4), 1648–1653. doi: 10.1073/pnas.0913991107  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Howell, D.  (2009). _Statistical methods for psychology_. (7th edition). Wadsorth, Cengage Learning.  [Google Scholar]
*   . Itskov, V. ,  Hansel, D. , & Tsodyks, M.  (2011). Short‐term facilitation may stabilize parametric working memory trace. _Frontiers in Computational Neuroscience_, 5, 40. doi: 10.3389/fncom.2011.00040  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Jackson, J. , & Reddish, D.  (2007). Network dynamics of hippocampal cell‐assemblies resemble multiple spatial maps within single tasks. _Hippocampus_, 17, 1209–1229. doi: 10.1002/hipo.20359  [DOI] [PubMed] [Google Scholar]
*   . Jezek, K. ,  Henriksen, E. J. ,  Treves, A. ,  Moser, E. I. , & Moser, M. B.  (2011). Theta‐paced flickering between place‐cell maps in the hippocampus. _Nature_, 478(7368), 246–249. doi: 10.1038/nature10439  [DOI] [PubMed] [Google Scholar]
*   . Kelemen, E. , & Fenton, A. A.  (2010). Dynamic grouping of hippocampal neural activity during cognitive control of two spatial frames. _PLoS Biology_, 8(6), e1000403. doi: 10.1371/journal.pbio.1000403  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Leutgeb, S. ,  Leutgeb, J. K. ,  Barnes, C. A. ,  Moser, E. I. ,  McNaughton, B. L. , & Moser, M. B.  (2005). Independent codes for spatial and episodic memory in hippocampal neuronal ensembles. _Science (New York, N.Y.)_, 309(5734), 619–623. doi: 10.1126/science.1114037  [DOI] [PubMed] [Google Scholar]
*   . MacDonald, C. J. ,  Carrow, S. ,  Place, R. , & Eichenbaum, H.  (2013). Distinct hippocampal time cell sequences represent odor memories in immobilized rats. _The Journal of Neuroscience: The Official Journal of the Society for Neuroscience_, 33(36), 14607–14616. doi: 10.1523/JNEUROSCI.1537-13.2013  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . MacDonald, C. J. ,  Lepage, K. Q. ,  Eden, U. T. , & Eichenbaum, H.  (2011). Hippocampal ‘time cells’ bridge the gap in memory for discontiguous events. _Neuron_, 71(4), 737–749. doi: 10.1016/j.neuron.2011.07.012  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Malvache, A. ,  Reichinnek, S. ,  Villette, V. ,  Haimerl, C. , & Cossart, R.  (2016). Awake hippocampal reactivations project onto orthogonal neuronal assemblies. _Science_, 353(6305), 1280–1283. doi: 10.1126/science.aaf3319  [DOI] [PubMed] [Google Scholar]
*   . McNaughton, B. L. ,  Barnes, C. A. ,  Gerrard, J. L. ,  Gothard, K. ,  Jung, M. W. ,  Knierim, J. J. , …  Udrimoti, H.  (1996). Deciphering the hippocampal polyglot: the hippocampus as a path integration system. _Journal of Experimental Biology_, 199(1), 173–185. doi: 10.1242/jeb.199.1.173  [DOI] [PubMed] [Google Scholar]
*   . McNaughton, B. L. , & Morris, R. G. M.  (1987). Hippocampal synaptic enhancement and information storage within a distributed memory system. _Trends in Neurosciences_, 10(10), 408–415.  [Google Scholar]
*   . Miles, R. , & Wong, R. K.  (1986). Excitatory synaptic interactions between CA3 neurones in the guinea‐pig hippocampus. _The Journal of Physiology_, 373(1), 397–418. doi: 10.1113/jphysiol.1986.sp016055  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Monasson, R. , & Rosay, S.  (2015). Transitions between spatial attractors in place‐cell models. _Physical Review Letters_, 115, 098101. doi: 10.1103/PhysRevLett.115.098101  [DOI] [PubMed] [Google Scholar]
*   . Mongillo, G. ,  Barak, O. , & Tsodyks, M.  (2008). Synaptic theory of working memory. _Science_, 319(5869), 1543–1546. doi: 10.1126/science.1150769  [DOI] [PubMed] [Google Scholar]
*   . Morris, R. G. M. ,  Garrud, P. ,  Rawlins, J. N. P. , & O'keefe, J.  (1982). Place navigation impaired in rats with hippocampal lesions. _Nature_, 297(5868), 681–683. doi: 10.1038/297681a0  [DOI] [PubMed] [Google Scholar]
*   . Muller, R. U. , & Kubie, J. L.  (1987). The effects of changes in the environment on the spatial firing of hippocampal complex‐spike cells. _The Journal of Neuroscience_, 7(7), 1951–1968. doi: 10.1523/JNEUROSCI.07-07-01951.1987  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Nakazawa, K. ,  McHugh, T. J. ,  Wilson, M. A. , & Tonegawa, S.  (2004). NMDA receptors, place cells and hippocampal spatial memory. _Nature Reviews Neuroscience_, 5(5), 361–372. doi: 10.1038/nrn1385  [DOI] [PubMed] [Google Scholar]
*   . O'Keefe, J. , & Dostrovsky, J.  (1971). The hippocampus as a spatial map. Preliminary evidence from unit activity in the freely‐moving rat. _Brain Research_, 34(1), 171–175. doi: 10.1016/0006-8993(71)90358-1  [DOI] [PubMed] [Google Scholar]
*   . O'Keefe, J. , & Nadel, L.  (1978). _The hippocampus as a cognitive map_. Oxford: Clarendon Press.  [Google Scholar]
*   . Pastalkova, E. ,  Itskov, V. ,  Amarasingham, A. , & Buzsaki, G.  (2008). Internally generated cell assembly sequences in the rat hippocampus. _Science_, 321(5894), 1322–1327. doi: 10.1126/science.1159775  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Pinto, D. , & Ermentrout, G.  (2001). Spatially structured activity in synaptically coupled neuronal networks: I. Traveling fronts and pulses. _SIAM Journal on Applied Mathematics_, 62(1), 206–225.  [Google Scholar]
*   . Pfeiffer, B. E. , & Foster, D. J.  (2013). Hippocampal place‐cell sequences depict future paths to remembered goals. _Nature_, 497(7447), 74–79. doi: 10.1038/nature12112  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Redish, A. D.  (1999). _Beyond the cognitive map: From place cells to episodic memory_. MIT Press.  [Google Scholar]
*   . Redish, A. D. , & Touretzky, D. S.  (1998). The role of the hippocampus in solving the morris water maze. _Neural Computation_, 10(1), 73–111. doi: 10.1162/089976698300017908  [DOI] [PubMed] [Google Scholar]
*   . Romani, S. , & Tsodyks, M.  (2010). Continuous attractors with morphed/correlated maps. _Plos Computational Biology_, 6(8), e1000869. doi: 10.1371/journal.pcbi.1000869  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Romani, S. , & Tsodyks, M.  (2015). Short‐term plasticity based network model of place cells dynamics. _Hippocampus_, 25, 94–105. doi: 10.1002/hipo.22355  [DOI] [PubMed] [Google Scholar]
*   . Salin, P. A. ,  Scanziani, M. ,  Malenka, R. C. , & Nicoll, R. A.  (1996). Distinct short‐term plasticity at two excitatory synapses in the hippocampus. _Proceedings of the National Academy of Sciences of United States of America_, 93(23), 13304–13309. doi: 10.1073/pnas.93.23.13304  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Samsonovich, A. , & McNaughton, B. L.  (1997). Path integration and cognitive mapping in a continuous attractor neural network model. _The Journal of Neuroscience_, 17(15), 5900–5920. doi: 10.1523/JNEUROSCI.17-15-05900.1997  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Savin, C. ,  Dayan, P. , & Lengyel, M.  (2014). Optimal recall from bounded metaplastic synapses: Predicting functional adaptations in hippocampal area CA3. _PLoS Computational Biology_, 10(2), e1003489. doi: 10.1371/journal.pcbi.1003489  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Scoville, W. B. , & Milner, B.  (1957). Loss of recent memory after bilateral hippocampal lesions. _Journal of Neurology, Neurosurgery & Psychiatry_, 20(1), 11–21. doi: 10.1136/jnnp.20.1.11  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Selig, D. K. ,  Nicoll, R. A. , & Malenka, C.  (1999). Hippocampal long‐term potentiation preserves the fidelity of postsynaptic responses to presynaptic bursts. _The Journal of Neuroscience: The Official Journal of the Society for Neuroscience_, 19(4), 1236–1246. doi: 10.1523/JNEUROSCI.19-04-01236.1999  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Stella, F. , & Treves, A.  (2011). Associative memory storage and retrieval: Involvement of theta oscillations in hippocampal information processing. _Neural Plasticity_, 683961. doi: 10.1155/2011/683961  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Suddendorf, T. , & Corballis, M. C.  (2007). The evolution of foresight: What is mental time travel, and is it unique to humans?. _Behavioral and Brain Sciences_, 30, 299–351. doi: 10.1017/S0140525X07001975  [DOI] [PubMed] [Google Scholar]
*   . Touretzky, D. S. , & Redish, R. D.  (1996). Theory of rodent navigation based on interacting representations of space. _Hippocampus_, 6(3), 247–270. doi: 10.1002/(SICI)1098-1063(1996)6:3<247::AID-HIPO4>3.0.CO;2-K  [DOI] [PubMed] [Google Scholar]
*   . Treves, A. , & Rolls, E. T.  (1992). Computational constraints suggest the need for two distinct input systems to the hippocampal CA3 network. _Hippocampus_, 2(2), 189–199. doi: 10.1002/hipo.450020209  [DOI] [PubMed] [Google Scholar]
*   . Tsodyks, M.  (1999). Attractor neural network models of spatial maps in hippocampus. _Hippocampus_, 9(4), 481–489. doi: 10.1002/(SICI)1098-1063(1999)9:4<481::AID-HIPO14>3.0.CO;2-S  [DOI] [PubMed] [Google Scholar]
*   . Tsodyks, M. ,  Pawelzik, K. , & Markram, H.  (1998). Neural networks with dynamic synapses. _Neural Computation_, 10(4), 821–835. doi: 10.1162/089976698300017502  [DOI] [PubMed] [Google Scholar]
*   . Tsodyks, M. , & Sejnowski, T.  (1995). Associative memory and hippocampal place cells. _International Journal of Neural Systems_, 6, 81–86.  [Google Scholar]
*   . Tsodyks, M. ,  Skaggs, W. E. ,  Sejnowski, T. , & McNaughton, B. L.  (1996). Population dynamics and theta rhythm phase precession of hippocampal place cell firing: A spiking neuron model. _Hippocampus_, 6(3), 271–280. doi: 10.1002/(SICI)1098-1063(1996)6:3<271::AID-HIPO5>3.0.CO;2-Q  [DOI] [PubMed] [Google Scholar]
*   . Vanderwolf, C. H.  (1969). Hippocampal electrical activity and voluntary movement in the rat. _Electroencephalography and Clinical Neurophysiology_, 26(4), 407–418. doi: 10.1016/0013-4694(69)90092-3  [DOI] [PubMed] [Google Scholar]
*   . Wang, Y. ,  Romani, S. ,  Lustig, B. ,  Leonardo, A. , & Pastalkova, E.  (2015). Theta sequences are essential for internally generated hippocampal firing fields. _Nature Neuroscience_, 18(2), 282–288. doi: 10.1038/nn.3904  [DOI] [PubMed] [Google Scholar]
*   . Wikenheiser, A. M. , & Redish, A. D.  (2015). Decoding the cognitive map: Ensemble hippocampal sequences and decision making. _Current Opinion in Neurobiology_, 32, 8–15. doi: 10.1016/j.conb.2014.10.002  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Wills, T. J. ,  Lever, C. ,  Cacucci, F. ,  Burgess, N. , & O'keefe, J.  (2005). Attractor dynamics in the hippocampal representation of the local environment. _Science_, 308, 873–876. doi: 10.1126/science.1108905  [DOI] [PMC free article] [PubMed] [Google Scholar]
*   . Wilson, H. R. , & Cowan, J. D.  (1973). A mathematical theory of the functional dynamics of cortical and thalamic nervous tissue. _Kybernetik_, 13(2), 55–80. doi: 10.1007/BF00288786  [DOI] [PubMed] [Google Scholar]
*   . York, L. C. , & Van Rossum, M. C. W.  (2009). Recurrent networks with short term synaptic depression. _Journal of Computational Neuroscience_, 27(3), 607–620. doi: 10.1007/s10827-009-0172-4  [DOI] [PubMed] [Google Scholar]
*   . Zhang, K.  (1996). Representation of spatial orientation by the intrinsic dynamics of the head‐direction cell ensemble: A theory. Journal of _Neuroscience_, 16(6), 2112–2126. doi: 10.1523/JNEUROSCI.16-06-02112.1996  [DOI] [PMC free article] [PubMed] [Google Scholar]

## Supplementary Materials

Supporting Appendix 1

Supporting Appendix 2

Supporting Figure 1

Supporting Figure 2

Supporting Figure 3

Supporting Figure 4

Supporting Figure 5

Supporting Figure 6

Supporting Figure 7

Supporting Figure 8

Supporting Figure 9

Supporting Figure 10

Supporting Figure 11

Supporting Figure 12

Supporting Figure 13
