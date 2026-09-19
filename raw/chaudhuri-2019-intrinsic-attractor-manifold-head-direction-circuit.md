---
title: "The intrinsic attractor manifold and population dynamics of a canonical cognitive circuit across waking and sleep"
source: "https://www.nature.com/articles/s41593-019-0460-x"
author:
  - "[[Rishidev Chaudhuri]]"
  - "[[Berk Gerçek]]"
  - "[[Biraj Pandey]]"
  - "[[Adrien Peyrache]]"
  - "[[Ila Fiete]]"
published: 2019-08-12
created: 2026-09-19
description: "Neural circuits construct distributed representations of key variables—external stimuli or internal constructs of quantities relevant for survival, such as an estimate of one’s location in the world—as vectors of population activity. Although population activity vectors may have thousands of entries (dimensions), we consider that they trace out a low-dimensional manifold whose dimension and topology match the represented variable. This manifold perspective enables blind discovery and decoding of the represented variable using only neural population activity (without knowledge of the input, output, behavior or topography). We characterize and directly visualize manifold structure in the mammalian head direction circuit, revealing that the states form a topologically nontrivial one-dimensional ring. The ring exhibits isometry and is invariant across waking and rapid eye movement sleep. This result directly demonstrates that there are continuous attractor dynamics and enables powerful inference about mechanism. Finally, external rather than internal noise limits memory fidelity, and the manifold approach reveals new dynamical trajectories during sleep. Neural populations often encode unknown variables. Chaudhuri et al. develop a method to decode unknown variables by finding shapes in neural data. They show that a mammalian brain circuit of thousands of neurons constructs a navigational compass with only a one-dimensional ring of stable activity states."
tags:
  - "clippings"
---
## Abstract

Neural circuits construct distributed representations of key variables—external stimuli or internal constructs of quantities relevant for survival, such as an estimate of one’s location in the world—as vectors of population activity. Although population activity vectors may have thousands of entries (dimensions), we consider that they trace out a low-dimensional manifold whose dimension and topology match the represented variable. This manifold perspective enables blind discovery and decoding of the represented variable using only neural population activity (without knowledge of the input, output, behavior or topography). We characterize and directly visualize manifold structure in the mammalian head direction circuit, revealing that the states form a topologically nontrivial one-dimensional ring. The ring exhibits isometry and is invariant across waking and rapid eye movement sleep. This result directly demonstrates that there are continuous attractor dynamics and enables powerful inference about mechanism. Finally, external rather than internal noise limits memory fidelity, and the manifold approach reveals new dynamical trajectories during sleep.

## Main

It has long been clear that the brain represents sensory, motor and internal variables in distributed codes across large populations of neurons. In turn, theoretical models of neural computation have emphasized that circuit dynamics must be understood in terms of the emergence of simple structures from the collective interactions of large numbers of neurons [^1] [^2] [^3] [^4] [^5], and that robust representation and memory involve the formation of low-dimensional stable states in population dynamics (called ‘attractors’) [^1] [^2] [^3] [^4] [^5].

Until recently, experimental techniques permitted access to only a few neurons at a time, but simultaneous recordings of multiple neurons are allowing the theoretically suggested approach of characterizing the structure and dynamics of neural responses at the population level. This approach has been illustrated in recent demonstrations of low-dimensional trajectories in sensory and motor circuits [^6] [^7] [^8].

Our work proceeds from four central premises. (1) In distributed codes, information representation, computation and dynamics unfold at the level of the neural population, and the collective states across neurons of a circuit are the natural way to understand them. (2) If the primary role of a circuit is to represent a low-dimensional variable of a given dimension and topology, then, by definition, the high-dimensional states of the circuit will be localized to a low-dimensional subspace or ‘manifold’ of matching dimension and topology. (3) Characterizing the structure of this manifold can enable the unsupervised discovery and decoding of the internally coded (latent) variable. (4) Examining the manifold structure and dynamics on and off the manifold across a range of behavioral states as circuit inputs change can reveal inherently stable states and thus aspects of the circuit mechanism.

We illustrate a method to characterize the manifold structure of data. We use this characterization to discover—in a blind or unsupervised way—low-dimensional internal states, provide blind time-resolved decoding of these states and support the predictions of a classical mechanistic circuit model using the mammalian head-direction (HD) system as our subject. The HD system in mammals and insects [^9] [^10] [^11] [^12] [^13] [^14] [^15] is a cognitive circuit that uses external and internal cues to estimate the direction that the animal is heading with respect to the external world. It is a proving ground for the manifold-based approach to the unsupervised discovery of encoded variables because it represents an internal cognitive state that need not directly reflect externally measured variables during waking. Moreover, this dissociation between internal and external states holds even truer during sleep (as we will see). Simultaneously, the HD system illustrates how a manifold approach can yield new insights into the structure, dynamics and mechanisms of a long-studied neural circuit, which were impossible to achieve from characterizing the responses of a few neurons at a time.

Two decades ago, theoretical models [^4] [^16] [^17] of the HD circuit postulated a stable, one-dimensional (1D) ring-shaped manifold in the high-dimensional population activity state space, which is a more abstract and fundamental feature than details about shapes of tuning curves, connectivity profiles or physical placements of neurons. Stability means that perturbations in the high-dimensional space away from the ring should quickly and preferentially flow back to the ring. If the HD circuit is an integrator, then the input to the circuit describes the momentary change in state rather than explicitly specifying the new state; the circuit adds these changes to the existing state to produce the new state. This integration requires that changes in state along the ring for equivalent changes in a represented variable should be equal. HD circuit models have been extended to explain the dynamics of other neurons [^5]. The same models can further explain how the brain could form representations in more abstract metric spaces and update them by integrating a signal that encodes changes in the representation [^18]. Thus, testing whether these models correctly describe the circuit mechanism is of broad importance.

So far, pairwise correlations between mammalian HD cells [^11] [^19] [^20] [^21] and the discovery of a topographically ordered physical HD-coding ring in flies [^13] [^14] are consistent with hypothesized models. Here, we show that the long-hypothesized low-dimensional state-space ring structure and attractive dynamics can be directly visualized in the population response manifold of the mammalian HD system, whether or not the circuit possesses physical topography that reflects its connectivity and function. The dynamics revealed in this circuit during sleep states provide new evidence about the intrinsic mechanisms that allow these states to be maintained and updated.

Portions of these results have been presented at conferences [^22].

## Results

The instantaneous (temporally binned) response of *N* neurons is a point in an *N* -dimensional state space where each axis represents the activity of one neuron (Fig. [1a](https://www.nature.com/articles/s41593-019-0460-x#Fig1)). The collection of snapshots of the population activity forms a cloud in state space. If the population encodes some variable of dimension $D_{\mathrm{m}} \ll N$ and a certain topology, the point cloud should trace out a manifold of the same dimension and topology, although the shape may be convoluted. In the following sections, we describe how characterizing the topology and structure of the manifold, then analyzing dynamics on the manifold, can permit us to extract latent encoded variables in an unsupervised way and deduce key aspects of the circuit mechanism.

![Fig. 1: Population activity as a manifold and a method for manifold characterization.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41593-019-0460-x/MediaObjects/41593_2019_460_Fig1_HTML.png?as=webp)

Fig. 1: Population activity as a manifold and a method for manifold characterization.

### Spline parameterization for unsupervised decoding (SPUD)

To decode the internal state encoded by the manifold, we performed the following steps (details in [Methods](https://www.nature.com/articles/s41593-019-0460-x#Sec11)). (1) Consider binned spiking data as points in a high-dimensional state space (Fig. [1a](https://www.nature.com/articles/s41593-019-0460-x#Fig1)). (2) Determine the topology of the point cloud using persistent homology [^23] (Fig. [1b,c](https://www.nature.com/articles/s41593-019-0460-x#Fig1)), with the introduction of a neighborhood-thresholded topological data analysis (nt-TDA) method (Supplementary Note [2.3](https://www.nature.com/articles/s41593-019-0460-x#MOESM1)) for increased robustness to noisy data. (3) Estimate the intrinsic manifold dimension using various methods, including correlation dimension [^24] (Supplementary Fig. [11](https://www.nature.com/articles/s41593-019-0460-x#Fig16)). (4) Fit the manifold with a spline of matching topology and dimension (Fig. [1d](https://www.nature.com/articles/s41593-019-0460-x#Fig1)). (5) Parameterize the spline by a smoothly changing variable of matching dimension and topology (Fig. [1e](https://www.nature.com/articles/s41593-019-0460-x#Fig1)). Steps 4 and 5 yield a local, on-manifold, minimal-dimensional parameterization of even topologically nontrivial manifolds; the resulting parameterization is interpreted as the values of the encoded latent variable or internal state. (6) Given a population state at any moment, we decode that state by projecting it to the nearest point on the spline; the parameterization value at that point is the unsupervised estimate of the value of the encoded latent variable (Fig. [1f](https://www.nature.com/articles/s41593-019-0460-x#Fig1)). None of these steps requires, in principle, a global low-dimensional embedding of the data.

To characterize the global topology of the manifold (step 2), we used persistent homology [^23]. The method starts by blurring the point cloud of data at different resolutions or scales. Then, at each resolution, we examined the emergence of connected groups of data points called simplicial complexes (Fig. [1b,c](https://www.nature.com/articles/s41593-019-0460-x#Fig1)). A simplicial complex can contain certain structures, such as a ring or a torus, and so on. Betti numbers form a list of binary structural designations that characterize the complexes (Fig. [1b](https://www.nature.com/articles/s41593-019-0460-x#Fig1)). In noisy data, if a Betti number for a structure persists over many scales (Fig. [1c](https://www.nature.com/articles/s41593-019-0460-x#Fig1)), this feature is robust and deemed significant. Topological data analysis uses these Betti numbers, across scales, to characterize the structure of a dataset [^23].

Our method fundamentally deals with determining the existence of a nontrivial topological structure in the data manifold, then defining local on-manifold coordinate systems to parameterize it. Conventional dimensionality reduction methods (including principal component analysis (PCA), Isomap, locally linear embedding and *t* -distributed stochastic neighbor embedding), by contrast, assume that the manifold is topologically trivial (equivalent to a stretched, folded or crumpled hole-free plane or solid ball of some dimension, or disjoint sets of these; Fig. [1b](https://www.nature.com/articles/s41593-019-0460-x#Fig1), first two panels), and find a low-dimensional global space or coordinate system to embed all the data. When the manifold is topologically nontrivial (Fig. [1b](https://www.nature.com/articles/s41593-019-0460-x#Fig1), third panel onwards), global dimensionality reduction methods will typically fail to correctly parameterize the latent variable represented on the manifold, thus giving a higher-dimensional embedding and parameterization than the manifold dimension. For instance, the minimum global embedding dimension for a 1D ring is two-dimensional (2D), thus global dimensionality reduction will yield, at best, a 2D parameterization of a 1D circular variable and fail to discover the real 1D latent variable (see the extended discussion and schematic in Supplementary Note [1](https://www.nature.com/articles/s41593-019-0460-x#MOESM1)). Constructing low-dimensional global embeddings is neither sufficient nor actually necessary for spline parameterization for unsupervised decoding (SPUD) (we used an optional initial dimensionality reduction step to reduce the complexity of subsequent operations and possibly for some smoothing of the manifold for undersampled datasets, but this step was not necessary, and applying SPUD directly in higher dimensions led to better fits when there was enough data; Supplementary Fig. [4](https://www.nature.com/articles/s41593-019-0460-x#Fig9)).

### Ring manifold and unsupervised decoding

We applied SPUD to activity recorded from the anterodorsal thalamic nucleus (ADn) of mice that were awake and foraging in an open 2D environment along variable paths, as well as intervening rapid eye movement (REM) and non-REM (nREM) periods [^21]. The behavior, even after reduction to abstract coordinates on a 2D plane, was at least five-dimensional (location, orientation, linear speed and angular speed); the actual behaviors and inputs across sensory modalities are much higher-dimensional.

We included all recorded thalamic cells, without subselection based on tuning or other criteria, using binned spike counts throughout (~100-ms resolution). With larger, simultaneously recorded populations, it will become possible to perform higher temporal resolution decoding; doing so with 5–10 ms of precision would allow us to probe fast dynamics and resolve information that may be encoded in shorter-timescale spike patterns [^25].

To determine whether the data exhibit a low-dimensional manifold structure in state space, we used both direct visualization of nonlinear low-dimensional embedding from the high-dimensional state space and topological data analysis, in particular the persistent homology of simplicial complexes [^23] (topological methods are more general because they permit the characterization of topologically nontrivial and higher-dimensional manifolds, even when direct visualization is not possible). Both methods revealed that network states during waking exploration lie on a strikingly low-dimensional, albeit highly nonlinear, manifold in the form of a convoluted ring (Fig. [2a,b](https://www.nature.com/articles/s41593-019-0460-x#Fig2); see Supplementary Fig. [1](https://www.nature.com/articles/s41593-019-0460-x#Fig6) for data for all seven animals and Supplementary Video [1](https://www.nature.com/articles/s41593-019-0460-x#MOESM3) for a 3D view). Moreover persistent homology revealed no evidence of a toroidal or more complex topological structure (Fig. [2b](https://www.nature.com/articles/s41593-019-0460-x#Fig2), H2 plot; contrast with Supplementary Fig. [3](https://www.nature.com/articles/s41593-019-0460-x#Fig8)). The 1D structure is of much lower dimensionality than the behavior or the sensory inputs.

![Fig. 2: Unsupervised discovery and time-resolved decoding of encoded variables through manifold characterization.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41593-019-0460-x/MediaObjects/41593_2019_460_Fig2_HTML.png?as=webp)

Fig. 2: Unsupervised discovery and time-resolved decoding of encoded variables through manifold characterization.

With the confirmation of a ring topology, we fitted a nonlinear spline with the same topology to the manifold (Fig. [2c](https://www.nature.com/articles/s41593-019-0460-x#Fig2)) and isometrically parameterized the spline along its length with a circular variable *α*, whose values are indicated by the color of the spline (Fig. [2d](https://www.nature.com/articles/s41593-019-0460-x#Fig2)). Now, *α* is the unsupervised or SPUD estimate of the latent variable encoded by the population manifold. Points on the manifold are colored according to the nearest value of the latent variable estimate (LVE), *α* (Fig. [2e](https://www.nature.com/articles/s41593-019-0460-x#Fig2)).

The LVE very closely matches (up to an arbitrary choice of origin and direction) the directly measured head angle (Fig. [2f,g](https://www.nature.com/articles/s41593-019-0460-x#Fig2); see Supplementary Figs. [4](https://www.nature.com/articles/s41593-019-0460-x#Fig9) – [6](https://www.nature.com/articles/s41593-019-0460-x#Fig11) for data for the other animals). Moreover, regressing the firing rates of individual cells onto the LVE recovered neural tuning curves in a fully blind way (Fig. [2h](https://www.nature.com/articles/s41593-019-0460-x#Fig2)). The match is a direct validation of the hypothesis that the topology of neural representations should match the topology of the represented variables.

Isometric parameterization along the neural manifold produces excellent decoding. This was not clear a priori, and implies that equal amounts of neural code length or population activity variation are devoted to equal changes in the head angle. This isometry property is exactly consistent with expectations for an accurate head velocity integrator, in which coding states must be equivalently changeable so that a unit velocity input produces a unit change in the represented angle, regardless of the starting state.

The unsupervised LVE better matches an internal state estimate constructed from a supervised (tuning-curve-based) decoder (Fig. [2g](https://www.nature.com/articles/s41593-019-0460-x#Fig2); Supplementary Fig. [5](https://www.nature.com/articles/s41593-019-0460-x#Fig10)) and explains more of the variance of neural spiking (cross-validated; Fig. [2i](https://www.nature.com/articles/s41593-019-0460-x#Fig2) and Supplementary Fig. [6](https://www.nature.com/articles/s41593-019-0460-x#Fig11)) than the measured HD. Thus, the LVE more accurately tracks the internal representation of an animal than the measured HD. The internal representation may differ from the measured HD for various reasons, including the possibility that the animal is representing an inaccurate HD estimate, or past or future HD states, or because of errors in the experimental HD measurement.

A natural question that arises is whether the neurons encode additional undiscovered variables. The manifold is clearly primarily 1D, but we can ask whether there is additional structure, for example, in the thickness of the ring. With a finite signal-to-noise ratio (SNR) in the dataset, it is impossible to exclude structures that are significantly smaller than the noise. We thus searched for additional coding structures down to the noise floor by asking whether the data exhibit either a spread or structure that is not explained by the 1D ring structure with independent spiking noise. First, we generated synthetic data based only on tuning curves for the 1D LVE, with spikes generated using an independent point process per cell with data-matched dispersion (Fano factor). The resulting point cloud closely matched the data (Fig. [2j](https://www.nature.com/articles/s41593-019-0460-x#Fig2)). Second, shared angular coding around the ring manifold accounted for 94% of the covariation between neurons. Third, the residual covariance after removing tuning to the LVE exhibited little discernible structure (Fig. [2k](https://www.nature.com/articles/s41593-019-0460-x#Fig2)). By contrast, there were additional coding dimensions in postsubicular HD cells (which code for head velocity and behavioral state; data not shown) and in the ADn during nREM sleep (shown later). Larger numbers of simultaneously recorded cells will improve the SNR, thus allowing the discovery of a finer additional structure or further downgrading the possibility that it exists.

In summary, down to the noise floor (SNR) of the present data, and if the recorded cells are representative samples, the population manifold reveals that the several thousand neuron-sized ADn population collectively encodes a single 1D variable, and no other, during waking.

### The manifold is autonomously generated and attractive

We next show how the manifold perspective directly reveals the collective intrinsic dynamics of the circuit. These analyses test the key predictions [^1] [^3] [^4] [^5] of continuous attractor models (properties 1, 3–5) and models of neural integrators for continuous variables (properties 1–6; Fig. [3a](https://www.nature.com/articles/s41593-019-0460-x#Fig3); see Supplementary Fig. [10](https://www.nature.com/articles/s41593-019-0460-x#Fig15) for a network model). (1) The high-dimensional network response occupies a low-dimensional continuum of states with a dimension and topology matching the encoded variable (or variables). (2) There is isometry of encoded state intervals so that equal velocity inputs produce equal changes in the encoded state, regardless of the starting state. (3) States are autonomously generated and stabilized, and capable of self-sustained activation when sensory inputs are removed. (4) The manifold is an attractor, whereby states initialized away from the manifold rapidly flow back. (5) Manifold states are energetically equal, with no net flow along the manifold. (6) A velocity input, encoding the time-derivative of the represented variable, drives the circuit in a special direction in the high-dimensional state space, specifically along the low-dimensional manifold. These predictions are fundamentally applied in terms of the population manifold and hence most naturally tested at that level.

![Fig. 3: REM sleep states, fluxes and dynamics suggest that the manifold is internally generated and attractive.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41593-019-0460-x/MediaObjects/41593_2019_460_Fig3_HTML.png?as=webp)

Fig. 3: REM sleep states, fluxes and dynamics suggest that the manifold is internally generated and attractive.

The results presented above directly support properties 1 and 2, which alone are not sufficient for establishing continuous attractor dynamics. To study autonomous dynamics, we examined the circuit during sleep, in the absence of spatial or directional input from the world.

During REM sleep, states again lie on a 1D ring (Fig. [3b](https://www.nature.com/articles/s41593-019-0460-x#Fig3); Supplementary Video [2](https://www.nature.com/articles/s41593-019-0460-x#MOESM4); see also Supplementary Note [2.3](https://www.nature.com/articles/s41593-019-0460-x#MOESM1) for a new method to enhance the SNR of persistent homology in very noisy data) that is essentially identical to the ring during awake exploration (Fig. [3c](https://www.nature.com/articles/s41593-019-0460-x#Fig3); see Supplementary Fig. [7](https://www.nature.com/articles/s41593-019-0460-x#Fig12) for data for other animals). Thus, the ring manifold is internally generated and autonomous (property 3) to the brain, which is consistent with a conclusion inferred from preserved pairwise correlations during sleep [^21]. However, we cannot determine whether the internal dynamics are confined to the anterior thalamus or dependent on longer-range interactions between areas.

### Manifold states are equivalent

To test the equivalence of manifold states, we examined the occupancy and dynamics during REM sleep, when state occupancy is not biased by behavior and the external world. First, we plotted instantaneous velocity vectors linking states at adjacent timepoints. If the manifold contained a number of discrete fixed points, there would be fast flow to and high occupancy around those fixed points. These flows would correspond visually to long bars converging near those points, unlike the roughly uniform bars observed (Fig. [3d](https://www.nature.com/articles/s41593-019-0460-x#Fig3)).

Relatedly, the angular change is independent of the angle value itself (Fig. [3e](https://www.nature.com/articles/s41593-019-0460-x#Fig3); see Supplementary Fig. [8](https://www.nature.com/articles/s41593-019-0460-x#Fig13) for data for other animals). To gain statistical power from pooling across sessions for each animal, we decoded the angular states on the ring with a supervised decoder and computed the density of the decoded angles (Fig. [3f](https://www.nature.com/articles/s41593-019-0460-x#Fig3)). The logarithm of the density of states along the ring—an estimate of the relative energy of states—was flat on the scale of variability across sessions. These results directly support property 5.

Finally, we studied circuit dynamics by examining fluxes of states on and off the manifold. A high-dimensional state space and manifold perspective is critical to this analysis, which cannot be done on the level of single-cell tuning. The flux through a small region is the average over all trajectories that flow into and out of that region (Fig. [3g](https://www.nature.com/articles/s41593-019-0460-x#Fig3)). For a continuous attractor that is not driven by directional input, we expect roughly zero net fluxes along the manifold because of the isotropic distribution of flow directions along the manifold (property 5) and the omnidirectional nature of random kicks off manifold. However, states not on the manifold should exhibit large net fluxes because of biased flows returning to the manifold (property 4; Fig. [3h](https://www.nature.com/articles/s41593-019-0460-x#Fig3)). Indeed, net fluxes were larger at off-manifold states (Fig. [3g–i](https://www.nature.com/articles/s41593-019-0460-x#Fig3)), with an increase in both radial (that is, toward the ring) and tangential (that is, along the ring) components (Fig. [3i](https://www.nature.com/articles/s41593-019-0460-x#Fig3)). These off-manifold fluxes were directed preferentially toward the ring, even during spontaneous activity, thus showing that population states are attracted toward the manifold, as predicted by attractor models.

### Diffusive dynamics along the manifold during REM

We next combined theoretical predictions about dynamical trajectories on continuous attractor manifolds [^26] with SPUD decoding (Fig. [4a,b](https://www.nature.com/articles/s41593-019-0460-x#Fig4)) to gain a quantitative estimate of the nature and influence of noise on the circuit. Noise is an important consideration for integrator, memory and representational circuits because it determines the timescale and fidelity of information stored in the circuit.

![Fig. 4: Diffusive dynamics during REM sleep.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41593-019-0460-x/MediaObjects/41593_2019_460_Fig4_HTML.png?as=webp)

Fig. 4: Diffusive dynamics during REM sleep.

First, we used waking data to confirm that SPUD captured the fine-time-scale statistics of trajectories (Fig.[4c](https://www.nature.com/articles/s41593-019-0460-x#Fig4), left inset). Since HD updates are correlated over short times during waking (Fig. [4d](https://www.nature.com/articles/s41593-019-0460-x#Fig4), blue trace; Supplementary Video [3](https://www.nature.com/articles/s41593-019-0460-x#MOESM5)), the squared deflection in estimated angle—if the SPUD estimate is sufficiently time-resolved—should grow quadratically at short times, which is what we found.

By contrast, during REM sleep, estimated angle updates were temporally uncorrelated but local (Fig. [4d](https://www.nature.com/articles/s41593-019-0460-x#Fig4), green trace; Supplementary Video [4](https://www.nature.com/articles/s41593-019-0460-x#MOESM6)). The squared angular deflection grew linearly with time (Fig. [4c](https://www.nature.com/articles/s41593-019-0460-x#Fig4), green curve). Temporally uncorrelated local updates and a linear growth in squared deflection are characteristic of an unbiased diffusive random walk [^26], which is consistent with property 5.

### Evidence of input aligned to the manifold

To resolve the nature of the noise driving diffusivity during REM, we made, to our knowledge, the first quantitative comparison between empirically observed diffusion in a neural circuit and theoretical predictions. The diffusion constant of REM dynamics shown in Fig. [4c](https://www.nature.com/articles/s41593-019-0460-x#Fig4) is 1.1 ± 0.04 rad <sup>2</sup>  s <sup>–1</sup> (0.52 ± 0.03 and 1.3 ± 0.06 for the other two animals; see Supplementary Fig. [9](https://www.nature.com/articles/s41593-019-0460-x#Fig14)). This diffusivity exceeded, by 20–50 times, the predicted value in a matched neural network model [^26] (Fig. [4c](https://www.nature.com/articles/s41593-019-0460-x#Fig4); Supplementary Note [4.2](https://www.nature.com/articles/s41593-019-0460-x#MOESM1); Supplementary Fig. [10](https://www.nature.com/articles/s41593-019-0460-x#Fig15)), if noise is independent across neurons.

Independent per-neuron noise could arise from Poisson-like spike count variations within the circuit or from high-dimensional input that projects in a spatially uncorrelated way to the neurons. In either case, high-dimensional noise is largely impotent in pushing the network state along the manifold because each unit variance of high-dimensional noise has a variance of only 1/ *N* along the manifold [^4] [^26] [^27] (Fig. [4e](https://www.nature.com/articles/s41593-019-0460-x#Fig4); *N* is the number of neurons in the circuit; over-dispersed noise does not resolve the problem, see Supplementary Note [4.2](https://www.nature.com/articles/s41593-019-0460-x#MOESM1)).

By contrast, a modest amount of low-dimensional noise aligned to the nonlinear manifold (standard deviation of 8.5 rad <sup>2</sup>  s <sup>–1</sup> with temporal correlations of 20 ms or less, which is comparable to the head-velocity drive during waking to update the HD estimate, Supplementary Fig. [5](https://www.nature.com/articles/s41593-019-0460-x#Fig10)) has a much stronger effect [^26] [^27], thus accounting for the measured diffusion (Fig. [4c](https://www.nature.com/articles/s41593-019-0460-x#Fig4)). In contrast to high-dimensional noise, such manifold-aligned noise tends not to distort the activity states, but keeps them close to the manifold as seen in the REM data. These results suggest that the network receives an input that is aligned to the manifold and is of the right amplitude for moving the state around the ring in response to waking head movements, thus supporting property 6.

Furthermore, the results demonstrate that even in cognitive circuits for memory and integration, as established for low-level sensory circuits and sensorimotor pathways [^28] [^29], information fidelity is primarily limited by input noise or sensory imprecision rather than by internal noise.

### Higher-dimensional manifold and coherent dynamics in nREM sleep

Hippocampal circuits replay waking activity patterns during nREM sleep [^30] [^31], and replays might be important for memory consolidation [^25] [^32]. However, the HD circuit seems to lack replays or even coherent temporal dynamics during nREM when probed using conventional decoding approaches [^21] [^33]. nREM sleep is also described as disrupting the ability of the brain to maintain integrated representations [^34], but it is unclear what this disruption means at a more mechanistic level, thus presenting an opportunity to understand it in the context of a specific integrated representation like HD.

We therefore examined manifold structure and dynamics in the ADn during nREM sleep. We found that the manifold is higher-dimensional (Fig. [5a,b](https://www.nature.com/articles/s41593-019-0460-x#Fig5); Supplementary Video [5](https://www.nature.com/articles/s41593-019-0460-x#MOESM7); Supplementary Fig. [11](https://www.nature.com/articles/s41593-019-0460-x#Fig16)), forming a conical surface (Fig. [5b](https://www.nature.com/articles/s41593-019-0460-x#Fig5) and Supplementary Fig. [11](https://www.nature.com/articles/s41593-019-0460-x#Fig16), where the cone is clearer). The manifold only partially overlapped the waking/REM manifold (Fig. [5b](https://www.nature.com/articles/s41593-019-0460-x#Fig5)), which caps the circular rim of the nREM cone.

![Fig. 5: Higher-dimensional states and coherent dynamics during nREM sleep.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41593-019-0460-x/MediaObjects/41593_2019_460_Fig5_HTML.png?as=webp)

Fig. 5: Higher-dimensional states and coherent dynamics during nREM sleep.

The nREM manifold encodes at least two latent variables, which we decoded along the tangential (circular) and radial (distance along spokes emanating from the manifold centroid) dimensions of the manifold using SPUD. The LVE along the tangential direction represents an angular variable, which closely matched (except at low-activity states where the SNR of the neural response is low) the estimates of two wake-trained supervised decoders of head angle that make different assumptions (Supplementary Figs. [12](https://www.nature.com/articles/s41593-019-0460-x#Fig17) and [13](https://www.nature.com/articles/s41593-019-0460-x#Fig18)). This result means that the angular structure of the manifold still represents the HD variable.

The radial LVE encodes population firing rate, capturing the slow, global fluctuations that characterize nREM sleep [^35] (Fig. [5c](https://www.nature.com/articles/s41593-019-0460-x#Fig5)). Unlike in waking and REM, where we inferred that some discrete attractor state in the total drive to the ADn (which will be interesting to identify in future experiments) keeps the manifold radius invariant across divergent behavioral states, this discrete attractor appeared to be lost during nREM, so that the network receives an overall drive of slowly varying amplitude. The highest drive during nREM matched wake and REM, but reduced drive caused the system to visit angle coding states or rings of varying amplitude, down to nearly the zero activity state close to the manifold centroid or cone tip. The nREM responses were well modeled by the same attractor circuit as for waking and REM dynamics, but with the global external input to all neurons undergoing large suppressive amplitude fluctuations of multiplicative amplitude ≤1 (Supplementary Fig. [14](https://www.nature.com/articles/s41593-019-0460-x#Fig19)).

Dynamics on the higher-dimensional nREM manifold are of two distinct types (Fig. [5d](https://www.nature.com/articles/s41593-019-0460-x#Fig5)): local diffusive evolution in a confined region of the manifold and larger coherent sweeps (see [Methods](https://www.nature.com/articles/s41593-019-0460-x#Sec11) and Supplementary Video [6](https://www.nature.com/articles/s41593-019-0460-x#MOESM8) for more detail on the properties of these two types of trajectories). This result is in contrast to the largely (rapidly) diffusive dynamics identified in nREM by wake-trained supervised decoders [^21] [^36] [^37] (Supplementary Fig. [12d–f](https://www.nature.com/articles/s41593-019-0460-x#Fig17)), which effectively project the higher-dimensional manifold states onto the 1D waking ring before estimating temporal dynamics.

The large sweeps are coherent in magnitude (Fig. [5e](https://www.nature.com/articles/s41593-019-0460-x#Fig5)) and in direction so that motion in a direction tends to continue in that direction (Fig. [5f](https://www.nature.com/articles/s41593-019-0460-x#Fig5), inset), thus producing a quadratic (rather than linear diffusive) growth in squared displacement over time (Fig. [5f](https://www.nature.com/articles/s41593-019-0460-x#Fig5), dark curve) as seen during waking (Fig. [4c](https://www.nature.com/articles/s41593-019-0460-x#Fig4), blue curve); however, the inferred speed of nREM coherent trajectories is eight times the speed of waking trajectories.

To reproduce sweeps in the attractor circuit model requires not only slowly modulating the strength of global inputs to generate matched population firing rate fluctuations but also adding temporally correlated fluctuations (correlation time of 200 ms) projected through the low-dimensional velocity input to the circuit (Supplementary Fig. [14](https://www.nature.com/articles/s41593-019-0460-x#Fig19)).

The sweeps occur during transient increases in local field potential (LFP) amplitude in the ADn (Fig. [5g](https://www.nature.com/articles/s41593-019-0460-x#Fig5)), specifically during upward fluctuations in LFP power in the ~ 12 Hz band, within the 7–15 Hz range for sleep spindles [^35] (Fig. [5h](https://www.nature.com/articles/s41593-019-0460-x#Fig5)), which in turn are correlated with the occurrence of hippocampal sharp waves [^38].

To summarize, while nREM dynamics projected to the waking manifold show misleadingly little temporal structure, the dynamics on the nREM manifold switch between a diffusive low-velocity regime and a coherent high-velocity regime. Coherent sweeps are temporally coincident with LFP power in the spindle band and thus with hippocampal sharp waves. Moreover, in continuous attractor models of the circuit, sweeps must be driven by temporally coherent velocity inputs to the circuit. These observations suggest that there are possible connections with replay and memory consolidation events elsewhere in the brain [^25] [^30] [^31] [^32].

## Discussion

We obtained a direct glimpse of a clear 1D ring in the activity states of the vertebrate HD circuit, in which neurons may or may not be physically laid out in order of their activity profiles. This visualization provides a compelling mammalian parallel to the beautiful recent results on a topographically ordered HD ring in the invertebrate nervous system [^13]. In addition, a purely 1D structure in the state-space manifold would directly imply that the circuit encodes no other information beyond HD, while a physical ring layout of a HD circuit does not rule out the possibility of additional coding dimensions.

A manifold approach reveals the full *N* -point correlations of the circuit, directly uncovering a structure that cannot easily be obtained from individual neural responses and pairwise correlations, including that there is little structure beyond a single 1D ring (down to some noise threshold) in waking and REM sleep. It shows that a presumed discrete attractor holds the circuit’s response amplitude fixed across waking and REM, and the constraint of this discrete attractor on response amplitude is lifted in nREM. Thus, our results augment an elegant body of work that inferred intrinsic low-dimensional structure from pairwise correlations in the vertebrate circuits for HD [^9] [^11] [^19] [^20] [^21], oculomotor control [^3], prefrontal evidence accumulation [^39] and 2D spatial navigation [^36] [^37] [^40].

By examining dynamics on and off the manifold across waking and sleep, we showed that the manifold is generated autonomously in the brain and that population dynamics are attractive. In particular, attractive flows onto the manifold from perturbed states are evident at the manifold level, but would be hard to observe from a few neurons at a time. Finally, a manifold approach allows for comparison with theoretical models, whose key predictions are at the level of structured population dynamics.

Unlike many applications of manifold methods [^7] [^8], the animal was not constrained to a specific low-dimensional task or trajectory whose dimensionality determined the manifold dimension. Rather, the manifold during waking behavior (which included variations in location, linear speed, angular speed and orientation, for a minimum of five dimensions of variation) was of much lower dimension than the behavior. Moreover the manifold retained the low-dimensional structure during sleep states, which are not constrained by low-dimensional inputs from the world, and when the circuit likely receives high-dimensional fluctuations. Thus, these analyses have uncovered the intrinsic dimension of the manifold.

With the demonstration of a purely 1D representation in a neural circuit (down to the noise floor), we are now free to wonder, without the usual caveat that these neurons might also be representing other things, why the brain uses thousands of cells for this purpose.

The manifold approach could be particularly useful for discovering unknown variables encoded in high-level brain areas and examining how structured states and dynamics emerge in neural circuits [^41], including through development [^42], plasticity or learning. Unlike supervised decoding methods [^25], we did not force an interpretation of a new ensemble of states (for example, during a different behavioral or brain state or task) by regression onto a previously characterized library of states. Manifold characterization with topological data analysis followed by parameterization in local coordinates as done here rather than by global low-dimensional embedding (as done by, for example, PCA and Isomap [^43]) will be important for unsupervised decoding of higher-dimensional manifolds that are topologically nontrivial, for example, toroidal structures produced by simulated grid cells (Supplementary Note [3](https://www.nature.com/articles/s41593-019-0460-x#MOESM1); we found that ~35 grid cells can be sufficient to reveal 2D toroidal structure, Supplementary Fig. [3](https://www.nature.com/articles/s41593-019-0460-x#Fig8)).

Persistent homology has been used to analyze neural data in various contexts [^44] [^45] [^46] [^47], including to recover the topology of the physical environment explored by an animal from place cell activity [^45], and to determine the topology of neural activity space [^46] or of unknown covariates [^47], but not, until now and in a contemporaneous work [^48], as part of a procedure for decoding latent variables.

Our innovation is to parameterize the manifold with splines of matching topology and to use this parameterization to decode the represented latent variable, characterize on- and off-manifold dynamics in waking and sleep, and to test theoretical models. By contrast, Rybakken et al.[^48] performed blind decoding using a variant of persistent homology called persistent cohomology, which provides a mapping between a Betti 1 feature and a circle, and applied an interesting iterative procedure to find additional coding dimensions (likely reflecting non-thalamic cells excluded from our present analysis and in which we also find additional structure (R.C., B.G., B.P., A.P. and I.F., unpublished observations)). Together, these studies illustrate the broader idea of unsupervised decoding from topologically nontrivial population manifolds.

Persistent homology has several limitations. One is the high sensitivity to outliers, for which we proposed a density-threshold method (Supplementary Note [2.3](https://www.nature.com/articles/s41593-019-0460-x#MOESM1)) that ameliorates this problem. Second, computing persistent features can be computationally slow. Finally, persistent homology cannot distinguish between topologically trivial manifolds with different geometries (for example, a hyperplane versus a filled ball). In general, persistent homology should be used as an initial step in a workflow to detect or rule out nontrivial topological features, followed by use of a manifold parameterization method to suit the topology (see Supplementary Note [1](https://www.nature.com/articles/s41593-019-0460-x#MOESM1)) and geometry.

In summary, manifold-level analyses can enable fully unsupervised discovery and decoding of brain states and dynamics, and quantification of collective dynamics on and off the manifold can give insight into circuit mechanisms. We believe that a manifold perspective and related techniques [^41] [^48] [^49] [^50] will be essential for extracting information from large datasets and during cognitively interesting tasks in which the brain constructs rich latent variables, thus representing the future of neural decoding.

## Methods

### Data

We analyzed data from a previous experiment [^21]. All experiments were approved by the Institutional Animal Care and Use Committee of New York University Medical Center. Briefly, the dataset contains recordings from the ADn of seven C57BL/6 mice (five male, two female), aged between 3 and 6 months, that were awake and foraging in an open environment along variable paths with variable velocities, as well as during intervening REM and nREM periods, along with measured head angles [^21]. For some of the mice, the data also contain recordings from the postsubiculum. Including data from the postsubiculum allows for slightly better manifold decoding of waking HD in some animals. However, this is a separate brain area with a different manifold structure, so we leave those data for a separate study.

We show manifolds (across waking, REM and nREM states) and wake decoding results from all seven mice. We show further analyses of waking dynamics and waking and REM decoding results from the three mice with waking root-mean-square decoding error of <0.5 rad and nREM decoding results from two out of these mice (the manifold for the third mouse was confined to very low activity states; Supplementary Fig. [11](https://www.nature.com/articles/s41593-019-0460-x#Fig16)). Sessions that allowed good decoding contained 9–50 neurons, and the number of neurons that showed good HD tuning ranged from 8 to 30.

### Preprocessing

We first converted spike times into time-varying rates. For analyses except persistent homology, we estimated firing rates by convolving the spike times with a Gaussian kernel of standard deviation 100 ms (50 ms for the plots in Fig. [5f](https://www.nature.com/articles/s41593-019-0460-x#Fig5)). For the persistent homology analyses, we computed total spike counts in 1-s bins. In all cases, we then replaced the rates by their square root to stabilize the variance.

Before fitting the manifold or applying topological methods, we used Isomap [^43] to reduce the large (*N* -dimensional) ambient dimension by re-embedding the data into a smaller, but still relatively high-dimensional, embedding space of dimension *D* <sub>e</sub> ($D_{\mathrm{m}} \ll D_{\mathrm{e}} \ll N$, where *D* <sub>m</sub> is the intrinsic manifold dimension). We set the number of neighbors to be 5 (higher values also work well) and embedded into 3–20 dimensions (3 for visualization and before decoding; 10 before applying the topological methods below; a range between 3 and 20 for Supplementary Fig. [4](https://www.nature.com/articles/s41593-019-0460-x#Fig9)). For the joint visualizations of data across states (Figs. [3c](https://www.nature.com/articles/s41593-019-0460-x#Fig3) and [5d](https://www.nature.com/articles/s41593-019-0460-x#Fig5)), we concatenated equal amounts of data from the two states and ran Isomap on these combined data.

This preliminary embedding ironed out some of the convolutions in the manifold while preserving its topology and, most importantly, sped up spline fitting. However, the results for decoding are not sensitive to the choice of embedding dimension. Indeed, for two of the three animals for which good decoding was possible, fitting directly in the high-dimensional space yielded a slightly more accurate fit, although the fitting procedure occasionally failed in high dimensions (Supplementary Fig. [4](https://www.nature.com/articles/s41593-019-0460-x#Fig9)).

### Persistent homology

To compute Betti barcodes for the data, we first applied Isomap to reduce it to ten dimensions (or used the full-dimensional state space if the number of neurons was fewer than ten). We then used the package Ripser [^51] to generate the Betti 0, 1 and 2 barcodes. For the nt-TDA analysis, we first excluded outliers by considering a neighborhood around each point with the radius defined by the first percentile of the pairwise distance distribution, and then removing all points whose numbers of neighbors lay in the bottom 20th percentile of the distribution of number of neighbors across points (Supplementary Note [2.3](https://www.nature.com/articles/s41593-019-0460-x#MOESM1)).

We plotted features above the 98th, 97th and 30th percentiles of Betti 0, 1 and 2 length distributions, respectively, for Fig. [2](https://www.nature.com/articles/s41593-019-0460-x#Fig2). For Fig. [3](https://www.nature.com/articles/s41593-019-0460-x#Fig3), the thresholds were 99th, 98th and 90th percentiles, respectively. For Fig. [5](https://www.nature.com/articles/s41593-019-0460-x#Fig5), the thresholds were 99.85th, 99.85th and 98th percentiles, respectively. For Supplementary Figs. [1c,d](https://www.nature.com/articles/s41593-019-0460-x#Fig6), [7b,c](https://www.nature.com/articles/s41593-019-0460-x#Fig12) and [11b,c](https://www.nature.com/articles/s41593-019-0460-x#Fig16), the thresholds were common across mice and reported in the figure captions. Note that there are a large number of very short-lived features, and no results were sensitive to the threshold for displaying the Betti features.

### Spline fit, parameterization and decoding

We fit the manifolds using piecewise linear curves. A curve *L* (*y*) is specified by *K* knots, with locations { *y* <sub>1</sub> ⋯ *y* <sub><i>K</i></sub> }. The knots are ordered, and the *i* th segment of the curve is a straight line between the *i* th and *i*  +  th knot. Given data points *x* <sub><i>i</i></sub> and a number of knots *K*, we first used *k* -means to identify *K* clusters in the data and set the centers of these clusters to be the initial knot locations. We then iteratively updated these knot locations to minimize $\left( {\mathop {\sum}\nolimits_i ||x_i - L(y)||} \right)|L(y)|$, where || *x* <sub><i>i</i></sub>  −  *L* (*y*)|| is the Euclidean distance between the *i* th data point and the nearest point on the curve *L* (*y*), and | *L* (*y*)| is the length of the curve. The multiplication by | *L* (*y*)| acts as a regularizer that penalizes excessively long or convoluted curves. The improvement from regularization is mild. An alternative cost function of the form $\left( {\mathop {\sum}\nolimits_i ||x_i - L(y)||} \right) + \lambda |L(y)|$ (where *λ* controls the degree of additive regularization) also worked well.

We parameterized points on the manifold by distance along the curve (in embedding space) from some arbitrary origin, with distances rescaled between 0 and 2π for comparison to the actual head angle. We primarily used *K*  = 12 and embedding dimension *D* <sub>e</sub>  = 3 (see Supplementary Fig. [4](https://www.nature.com/articles/s41593-019-0460-x#Fig9) for other values). Points were decoded by mapping them to the nearest point on the manifold, based on the Euclidean norm in the embedding space, and reading off the parameter value there.

In the waking state, we shifted the global origin and chose the orientation around the curve to match the measured head angle, but made no other modifications (for example, we did not rescale the coordinate differently in different parts of the ring). During sleep, when comparing to a tuning curve decoder, we performed a similar shift and choice of orientation dictated by the tuning-curve decoded angle.

### Supervised tuning-curve decoder

We computed the supervised tuning curve of the *i* th cell, *f* <sub><i>i</i></sub> (*θ*), as its mean response to the measured head angle for each of the 30 angular bins as follows:

 $f_{i} \left(\theta\right) = \frac{N u m b e r \textrm{ } o f \textrm{ } s p i k e s \textrm{ } f i r e d \textrm{ } b y \textrm{ } c e l l \textrm{ } i \textrm{ } a r o u n d a n g l e \textrm{ } \theta}{T i m e \textrm{ } s p e n t \textrm{ } b y \textrm{ } a n i m a l \textrm{ } a r o u n d \textrm{ } a n g l e \textrm{ } \theta} .$ 
$$
f_i(\theta ) = \frac{{{\mathrm{Number}}\ {\mathrm{of}}\ {\mathrm{spikes}}\ {\mathrm{fired}}\ {\mathrm{by}}\ {\mathrm{cell}}\ i\ {\mathrm{around}}\,{\mathrm{angle}}\ \theta }}{{{\mathrm{Time}}\ {\mathrm{spent}}\ {\mathrm{by}}\ {\mathrm{animal}}\ {\mathrm{around}}\ {\mathrm{angle}}\ \theta }}.
$$

We then decoded the head angle using maximum likelihood estimation under the model that at angle *θ*, neuron *i* responds independently with *C* <sub><i>i</i></sub> spikes drawn from a Poisson distribution with rate *f* <sub><i>i</i></sub> (*θ*) as follows:

 $\hat{\theta}_{t} = a r g \underset{\theta}{m a x} P \left(\right. \left\{C_{i t} \left.\right\}_{i = 1 , \hdots , N} \left|\right. \theta\right) = a r g \underset{\theta}{m a x} \prod_{i = 1}^{N} P o i s s \left(C_{i t} ; f_{i} \left(\theta\right) \Delta t\right)$ 
$$
\hat \theta _t = {\mathrm{arg}}\mathop {{\mathrm{max}}}\limits_\theta P(\{ C_{it}\} _{i = 1, \cdots ,N}|\theta ) = {\mathrm{arg}}\mathop {{\mathrm{max}}}\limits_\theta \mathop {\prod}\limits_{i = 1}^N {\mathrm{Poiss}} (C_{it};f_i(\theta ){\mathrm{\Delta }}t)
$$

### Variance explained and excluding other encoded variables

To compute the variance explained, we considered the spike counts extracted in 100-ms bins. If the spike counts of the *i* th neuron are *C* <sub><i>i</i></sub>, then the variance explained by *X* is as follows:

 $V a r_{e x p , X} = V a r \left[\mathbb{E} \left(C_{i} \left|\right. X\right)\right] + \mathbb{E} \left[\phi \mathbb{E} \left(C_{i} \left|\right. X\right)\right]$ 
$$
{\mathrm{Var}}_{{\mathrm{exp},X}} = {\mathrm{Var}}\left[ {\Bbb E}(C_i|X) \right] + {\Bbb{E}}\left[ {\phi {\Bbb{E}}(C_i|X)} \right]
$$

(1)

Here, *X* is the measured head angle or decoded head angles (binned in 30 bins between 0 and 2π). For the Poisson model, *ϕ*  = 1. For the overdispersed model, we estimated *ϕ* as ${\mathrm{min}}_X{\mathrm{Var}}(C_i|X)/{\Bbb{E}}(C_i|X)$. For a true overdispersed process, taking the minimum is likely to underestimate the overdispersion; thus this estimate is conservative.

Throughout (except for the measured head angle), we used a training set (80% of the data) to fit the manifold or to construct tuning curves, and a test set (remaining 20% of the data) to evaluate the model. As shown in Fig. [2i](https://www.nature.com/articles/s41593-019-0460-x#Fig2), we evaluated significance by computing the number of cells that were better explained by the unsupervised LVE than by the measured angle and comparing this to a null model in which both explained the data equally well (that is, two-sided binomial test).

For Fig. [2j](https://www.nature.com/articles/s41593-019-0460-x#Fig2), we generated synthetic data using the tuning curves to the unsupervised LVE. Given a decoded latent variable *α*, we generated a spike count for neuron *i* from a normal distribution with mean ${\Bbb{E}}(C_i|\alpha )$ and variance Var(*C* <sub><i>i</i></sub> | *α*). Generating counts this way assumes that neural firing is overdispersed, but that neurons are independent given *α*, thus explicitly removing additional structure in the population. To compare the covariance explained (Fig. [2k](https://www.nature.com/articles/s41593-019-0460-x#Fig2)), we compared the ratio of the Frobenius norm of the residual covariance matrix (that is, after conditioning on either the measured or the SPUD angle) to the norm of the raw covariance matrix.

### Diffusion curves

The diffusion curve at time shift *τ* is *D* (*τ*) = 〈 *α* (*t*  +  *τ*) −  *α* (*t*)〉 <sub><i>t</i></sub>, where the average value is taken over time (that is, all pairs of time points separated by *τ*). To compute diffusion constants, we fitted a straight line to the first 200 ms of the squared change in decoded angle against time. To obtain a bootstrapped estimate of error, we resampled 200-ms epochs from the data with replacement (number of samples chosen to match the length of data) and recomputed the diffusion constant. We repeated this resampling procedure 1,000 times.

### Fluxes

To estimate the flow fields (Fig. [3g](https://www.nature.com/articles/s41593-019-0460-x#Fig3)), we considered a 2D Isomap embedding of the manifold and averaged together velocity vectors of points in each of the 900 spatial bins (30 equal bins per dimension).

For the distributions shown in Fig. [3g](https://www.nature.com/articles/s41593-019-0460-x#Fig3), inset, and Fig. [3i](https://www.nature.com/articles/s41593-019-0460-x#Fig3), we carried out the same analysis in 3D (to limit distortions from the low-dimensional embedding) using 20 bins per dimension. We defined a radial vector from the center of each bin to the nearest point on the manifold and projected onto this vector to construct radial and tangential flux components. For Fig. [3i](https://www.nature.com/articles/s41593-019-0460-x#Fig3), upper panel, we rescaled the tangential components by $1/\sqrt 2$ to reflect that there are two tangential dimensions and only one radial dimension (the ratio plots in the lower panel of Fig. [3i](https://www.nature.com/articles/s41593-019-0460-x#Fig3) and the significance tests are unaffected by this rescaling).

To quantify the difference between on- and off-manifold points (Fig. [3i](https://www.nature.com/articles/s41593-019-0460-x#Fig3)), we divided the bins into on- and off-manifold bins based on the 50th percentile of the distance to the fitted spline, and show respective flux distributions. We then compared the ratio of the average norm of the velocity vector on and off the manifold along with the equivalents for the radial and tangential components. The distributions of these ratios were computed by resampling the data with replacement 1,000 times.

To test for significance, we shuffled the assignment of velocity vectors to points, repeated the spatial binning and averaging, and recomputed the ratios (1,000 times). We then computed a *P* value by calculating the probability of getting a value as or more extreme than the observed data under the null distribution (two-sided permutation test).

### nREM dynamics

For the SPUD-based firing rate decoding shown in Fig. [5c](https://www.nature.com/articles/s41593-019-0460-x#Fig5), we computed the distance of points on the nREM manifold to the manifold centroid, and plotted the best linear predictor of population firing rate as a function of this distance.

To classify trajectories on the full manifold as sweeps, we looked for 300-ms epochs (here, six 50-ms time bins; results were similar for three 100-ms time bins) when the speed is above the 60th percentile of the speed distribution. For confined trajectories, we did the same but extracted trajectories that remained below the 40th percentile of speed. To compute a null distribution for the fraction of times during which the circuit is in a sweep or confined trajectory, we repeatedly shuffled the velocities over time (1,000 times) and recomputed the fractions. We computed the significance from these null distributions using a two-sided permutation test.

We estimated LFP at a shank as the median of the LFP recorded on each channel, and then averaged these estimates across shanks (results were similar across shanks). For Fig. [5g](https://www.nature.com/articles/s41593-019-0460-x#Fig5), we considered changes in the nREM manifold position over 200 ms, and plotted the mean LFP for the 5 s before and after a large (>50th percentile) or small (<50th percentile) change, along with a 95% confidence interval computed as 1.96 times the standard deviation across time samples. For Fig. [5h](https://www.nature.com/articles/s41593-019-0460-x#Fig5), we converted the LFP to a spectrogram using a sliding Fourier transform, calculated the total power at each frequency in 1-s windows and correlated this with the summed absolute change in manifold position over ten 100-ms bins (that is, $\mathop {\sum}\nolimits_{i = 1}^{10} {\left\| {x(t_0 + 0.1 \times i) - x(t_0 + 0.1 \times (i - 1))} \right\|}$, where *t* <sub>0</sub> is the time at which the signals are being compared). We plotted these correlations along with a 95% bootstrapped confidence interval, where we repeatedly resampled the LFP–change in manifold position pairs and recomputed the correlation (1,000 times).

### Attractor model

We used a slightly modified version of the continuous attractor model from a previous study [^26] and reproduced the waking, REM and nREM data by only changing the inputs to the model. Further details on model construction are provided in Supplementary Note [4](https://www.nature.com/articles/s41593-019-0460-x#MOESM1) and in Supplementary Figs. [10](https://www.nature.com/articles/s41593-019-0460-x#Fig15) and [14](https://www.nature.com/articles/s41593-019-0460-x#Fig19).

### Statistics

No statistical methods were used to predetermine sample sizes. We analyzed data from all animals reported in a previous publication [^21], and the number of animals and recorded cells were similar to previous studies [^33] [^52]. There was no randomization or division into experimental groups. Data collection and analyses were not performed blinded to the conditions of the experiments. For significance, nonparametric permutation tests or binomial tests were used. All statistical tests used were two-sided, and data distributions were not assumed to be normal. Correlations are reported using Pearson’s correlation coefficient. Further details are available in the [Nature Research Reporting Summary](https://www.nature.com/articles/s41593-019-0460-x#MOESM2).

### Reporting Summary

Further information on research design is available in the [Nature Research Reporting Summary](https://www.nature.com/articles/s41593-019-0460-x#MOESM2) linked to this article.

## Data availability

Data have been previously reported [^21] and are available on the CRCNS website at [http://crcns.org/data-sets/thalamus/th-1](http://crcns.org/data-sets/thalamus/th-1).

## Code availability

The code is available at [https://fietelab.mit.edu/code/](https://fietelab.mit.edu/code/).

## References

## Acknowledgements

The authors thank D. Tank, S. Lewallen and R. Low for insightful discussions, and F. Caccuci, T. Wills, S. Deneve, Y. Burak, J. Murray, J. Pillow, L. Paninski and M. Sahani for comments on the work or manuscript. I.F. is grateful to G. Prasad for pointing her to the field of topological data analysis several years ago, and to W. Bialek for raising the possibility of unsupervised discovery of encoded variables from neural data, also several years ago. This work was supported in part by grants from the NIH (U01-NS094330-03), the Simons Foundation (SCGB and the International Brain Laboratory) and the Howard Hughes Medical Institute through the Faculty Scholars Program to I.F., and by the Canadian Research Chair in Systems Neuroscience (245716), a CIHR Project Grant (155957), a NSERC Discovery Grant (RGPIN-2018-04600) and the IRDC (108877-001) to A.P. Part of this work was performed by R.C. and I.F. in residence at the Simons Institute for the Theory of Computing at UC Berkeley, where R.C. was a Google Research Fellow.

## Ethics declarations

### Competing interests

The authors declare no competing interests.

## Additional information

**Peer review information**: *Nature Neuroscience* thanks Vivek Jayaraman, Kate Jeffery, Sung Soo Kim, and the other, anonymous, reviewer(s) for their contribution to the peer review of this work.

**Publisher’s note:** Springer Nature remains neutral with regard to jurisdictional claims in published maps and institutional affiliations.

## Integrated supplementary information

### Supplementary Figure 1

Low-dimensional structure in the head direction circuit.

### Supplementary Figure 2

Distortion of manifold by linear methods and by inhomogeneous sampling.

### Supplementary Figure 3

Toroidal manifold in simulated grid cell activity.

### Supplementary Figure 4

Decoding performance does not strongly depend on embedding dimension or number of spline knots and performance is good with ~20 neurons and several minutes of data.

### Supplementary Figure 5

Wake dynamics for other animals.

### Supplementary Figure 6

Spiking variance and tuning curves explained by decoding.

### Supplementary Figure 7

Ring manifold preserved during REM across animals.

### Supplementary Figure 8

REM occupancy and flows.

### Supplementary Figure 9

REM decoding across animals.

### Supplementary Figure 10

Waking and REM states and dynamics replicated in a continuous attractor model.

### Supplementary Figure 11

Loss of ring and higher-dimensional nREM manifold across animals.

### Supplementary Figure 12

nREM decoding and dynamics controls.

### Supplementary Figure 13

Decoding, dynamics, and trajectory statistics during nREM for Mouse 25 are similar to those observed for Mouse 28.

### Supplementary Figure 14

Qualitative reproduction of nREM trajectory, dynamics, and statistics in continuous attractor ring network model.

## Supplementary information

### Supplementary Information (download PDF )

Supplementary Figs. 1–14 and Supplementary Notes 1–4.

### Reporting Summary (download PDF )

### Supplementary Video 1 (download MP4 )

**Wake manifold**. Three-dimensional Isomap embedding of the waking manifold from Mouse 28, session 140313.

### Supplementary Video 2 (download MP4 )

**REM manifold**. Three-dimensional Isomap embedding of the REM manifold from mouse 28, session 140313.

### Supplementary Video 3 (download MP4 )

**Waking dynamics**. Dynamics during 200 s of waking (projection generated using Isomap). The moving trace shows 1 s (most recent point is darkest). The blue points in the background show the waking manifold.

### Supplementary Video 4 (download MP4 )

**REM dynamics**. Dynamics during 200 s of REM sleep (projection generated using Isomap). The moving trace shows 1 s (most recent point is darkest). The green scatter plot in the background shows the REM manifold. Note that REM sleep intervals are typically quite short, so the 200 s comprises multiple concatenated intervals.

### Supplementary Video 5 (download MP4 )

**nREM manifold**. Three-dimensional Isomap embedding of the nREM manifold from mouse 28, session 140313, shown in mustard yellow, along with the waking manifold for comparison, shown in blue.

### Supplementary Video 6 (download MP4 )

**nREM dynamics**. Dynamics during 200 s of nREM sleep (projection generated using Isomap). The moving trace shows 1 s (most recent point is darkest). The mustard yellow scatter plot in the background shows the nREM manifold, and the blue points show the waking manifold.

## Rights and permissions

[^1]: Amari, S.-I. Dynamics of pattern formation in lateral-inhibition type neural fields. *Biol. Cybern.* **27**, 77–87 (1977).

[Article](https://link.springer.com/doi/10.1007/BF00337259) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaE1c%2FitFWlsw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Dynamics%20of%20pattern%20formation%20in%20lateral-inhibition%20type%20neural%20fields&journal=Biol.%20Cybern.&doi=10.1007%2FBF00337259&volume=27&pages=77-87&publication_year=1977&author=Amari%2CS-I)

[^2]: Hopfield, J. J. Neural networks and physical systems with emergent collective computational abilities. *Proc. Natl Acad. Sci. USA* **79**, 2554–2558 (1982).

[Article](https://doi.org/10.1073%2Fpnas.79.8.2554) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL383it1WktQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20networks%20and%20physical%20systems%20with%20emergent%20collective%20computational%20abilities&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.79.8.2554&volume=79&pages=2554-2558&publication_year=1982&author=Hopfield%2CJJ)

[^3]: Seung, H. S. How the brain keeps the eyes still. *Proc. Natl Acad. Sci. USA* **93**, 13339–13344 (1996).

[Article](https://doi.org/10.1073%2Fpnas.93.23.13339) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK28XmvFSnsLg%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=How%20the%20brain%20keeps%20the%20eyes%20still&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.93.23.13339&volume=93&pages=13339-13344&publication_year=1996&author=Seung%2CHS)

[^4]: Zhang, K. Representation of spatial orientation by the intrinsic dynamics of the head-direction cell ensemble: a theory. *J. Neurosci.* **15**, 2112–2126 (1996).

[Article](https://doi.org/10.1523%2FJNEUROSCI.16-06-02112.1996) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Representation%20of%20spatial%20orientation%20by%20the%20intrinsic%20dynamics%20of%20the%20head-direction%20cell%20ensemble%3A%20a%20theory&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.16-06-02112.1996&volume=15&pages=2112-2126&publication_year=1996&author=Zhang%2CK)

[^5]: Burak, Y. & Fiete, I. R. Accurate path integration in continuous attractor network models of grid cells. *PLoS Comput. Biol.* **5**, e1000291 (2009).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1000291) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Accurate%20path%20integration%20in%20continuous%20attractor%20network%20models%20of%20grid%20cells&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1000291&volume=5&publication_year=2009&author=Burak%2CY&author=Fiete%2CIR)

[^6]: Mazor, O. & Laurent, G. Transient dynamics versus fixed points in odor representations by locust antennal lobe projection neurons. *Neuron* **48**, 661–673 (2005).

[Article](https://doi.org/10.1016%2Fj.neuron.2005.09.032) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2MXhtlSms7nL) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Transient%20dynamics%20versus%20fixed%20points%20in%20odor%20representations%20by%20locust%20antennal%20lobe%20projection%20neurons&journal=Neuron&doi=10.1016%2Fj.neuron.2005.09.032&volume=48&pages=661-673&publication_year=2005&author=Mazor%2CO&author=Laurent%2CG)

[^7]: Mante, V., Sussillo, D., Shenoy, K. V. & Newsome, W. T. Context-dependent computation by recurrent dynamics in prefrontal cortex. *Nature* **503**, 78–84 (2013).

[Article](https://doi.org/10.1038%2Fnature12742) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXhsleksLrM) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Context-dependent%20computation%20by%20recurrent%20dynamics%20in%20prefrontal%20cortex&journal=Nature&doi=10.1038%2Fnature12742&volume=503&pages=78-84&publication_year=2013&author=Mante%2CV&author=Sussillo%2CD&author=Shenoy%2CKV&author=Newsome%2CWT)

[^8]: Gallego, J. A., Perich, M. G., Miller, L. E. & Solla, S. A. Neural manifolds for the control of movement. *Neuron* **94**, 978–984 (2017).

[Article](https://doi.org/10.1016%2Fj.neuron.2017.05.025) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXpvVKgtb0%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20manifolds%20for%20the%20control%20of%20movement&journal=Neuron&doi=10.1016%2Fj.neuron.2017.05.025&volume=94&pages=978-984&publication_year=2017&author=Gallego%2CJA&author=Perich%2CMG&author=Miller%2CLE&author=Solla%2CSA)

[^9]: Ranck, J. B. in *Electrical Activity of Archicortex* (eds Buzsaki, G. & Vanderwolf, C.) 217–220 (Akademiai Kiado, 1985).

[^10]: Taube, J. S., Muller, R. U. & Ranck, J. B. Head-direction cells recorded from the postsubiculum in freely moving rats. I. Description and quantitative analysis. *J. Neurosci.* **10**, 420–435 (1990).

[Article](https://doi.org/10.1523%2FJNEUROSCI.10-02-00420.1990) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK3c7lsFCisA%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Head-direction%20cells%20recorded%20from%20the%20postsubiculum%20in%20freely%20moving%20rats.%20I.%20Description%20and%20quantitative%20analysis&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.10-02-00420.1990&volume=10&pages=420-435&publication_year=1990&author=Taube%2CJS&author=Muller%2CRU&author=Ranck%2CJB)

[^11]: Taube, J. S., Muller, R. U. & Ranck, J. B. Head-direction cells recorded from the postsubiculum in freely moving rats. II. Effects of environmental manipulations. *J. Neurosci.* **10**, 436–447 (1990).

[Article](https://doi.org/10.1523%2FJNEUROSCI.10-02-00436.1990) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK3c7lsFCisQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Head-direction%20cells%20recorded%20from%20the%20postsubiculum%20in%20freely%20moving%20rats.%20II.%20Effects%20of%20environmental%20manipulations&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.10-02-00436.1990&volume=10&pages=436-447&publication_year=1990&author=Taube%2CJS&author=Muller%2CRU&author=Ranck%2CJB)

[^12]: Finkelstein, A. et al. Three-dimensional head-direction coding in the bat brain. *Nature* **517**, 159–164 (2015).

[Article](https://doi.org/10.1038%2Fnature14031) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXitFanu7fF) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Three-dimensional%20head-direction%20coding%20in%20the%20bat%20brain&journal=Nature&doi=10.1038%2Fnature14031&volume=517&pages=159-164&publication_year=2015&author=Finkelstein%2CA)

[^13]: Seelig, J. D. & Jayaraman, V. Neural dynamics for landmark orientation and angular path integration. *Nature* **521**, 186–191 (2015).

[Article](https://doi.org/10.1038%2Fnature14446) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXhtFeitb3F) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20dynamics%20for%20landmark%20orientation%20and%20angular%20path%20integration&journal=Nature&doi=10.1038%2Fnature14446&volume=521&pages=186-191&publication_year=2015&author=Seelig%2CJD&author=Jayaraman%2CV)

[^14]: Green, J. et al. A neural circuit architecture for angular integration in *Drosophila*. *Nature* **546**, 101–106 (2017).

[Article](https://doi.org/10.1038%2Fnature22343) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXosVagtL8%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20neural%20circuit%20architecture%20for%20angular%20integration%20in%20Drosophila&journal=Nature&doi=10.1038%2Fnature22343&volume=546&pages=101-106&publication_year=2017&author=Green%2CJ)

[^15]: Kim, S. S., Rouault, H., Druckmann, S. & Jayaraman, V. Ring attractor dynamics in the *Drosophila* central brain. *Science* **356**, 849–853 (2017).

[Article](https://doi.org/10.1126%2Fscience.aal4835) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXotlSrsrk%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Ring%20attractor%20dynamics%20in%20the%20Drosophila%20central%20brain&journal=Science&doi=10.1126%2Fscience.aal4835&volume=356&pages=849-853&publication_year=2017&author=Kim%2CSS&author=Rouault%2CH&author=Druckmann%2CS&author=Jayaraman%2CV)

[^16]: Skaggs, W. E., Knierim, J. J., Kudrimoti, H. S. & McNaughton, B. L. A model of the neural basis of the rat’s sense of direction. *Adv. Neural Inf. Process. Syst.* **7**, 173–180 (1995).

[CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD3MnlslOgsw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11539168) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20model%20of%20the%20neural%20basis%20of%20the%20rat%E2%80%99s%20sense%20of%20direction&journal=Adv.%20Neural%20Inf.%20Process.%20Syst.&volume=7&pages=173-180&publication_year=1995&author=Skaggs%2CWE&author=Knierim%2CJJ&author=Kudrimoti%2CHS&author=McNaughton%2CBL)

[^17]: Sharp, P. E., Blair, H. T. & Brown, M. Neural network modeling of the hippocampal formation spatial signals and their possible role in navigation: a modular approach. *Hippocampus* **6**, 720–734 (1996).

[Article](https://doi.org/10.1002%2F%28SICI%291098-1063%281996%296%3A6%3C720%3A%3AAID-HIPO14%3E3.0.CO%3B2-2) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK2s7oslCjtw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20network%20modeling%20of%20the%20hippocampal%20formation%20spatial%20signals%20and%20their%20possible%20role%20in%20navigation%3A%20a%20modular%20approach&journal=Hippocampus&doi=10.1002%2F%28SICI%291098-1063%281996%296%3A6%3C720%3A%3AAID-HIPO14%3E3.0.CO%3B2-2&volume=6&pages=720-734&publication_year=1996&author=Sharp%2CPE&author=Blair%2CHT&author=Brown%2CM)

[^18]: Aronov, D., Nevers, R. & Tank, D. W. Mapping of a non-spatial dimension by the hippocampal–entorhinal circuit. *Nature* **543**, 719–722 (2017).

[Article](https://doi.org/10.1038%2Fnature21692) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXltl2iu7g%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mapping%20of%20a%20non-spatial%20dimension%20by%20the%20hippocampal%E2%80%93entorhinal%20circuit&journal=Nature&doi=10.1038%2Fnature21692&volume=543&pages=719-722&publication_year=2017&author=Aronov%2CD&author=Nevers%2CR&author=Tank%2CDW)

[^19]: Mizumori, S. & Williams, J. Directionally selective mnemonic properties of neurons in the lateral dorsal nucleus of the thalamus of rats. *J. Neurosci.* **13**, 4015–4028 (1993).

[Article](https://doi.org/10.1523%2FJNEUROSCI.13-09-04015.1993) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK3sznsFegsQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Directionally%20selective%20mnemonic%20properties%20of%20neurons%20in%20the%20lateral%20dorsal%20nucleus%20of%20the%20thalamus%20of%20rats&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.13-09-04015.1993&volume=13&pages=4015-4028&publication_year=1993&author=Mizumori%2CS&author=Williams%2CJ)

[^20]: Knierim, J. J., Kudrimoti, H. S. & McNaughton, B. L. Interactions between idiothetic cues and external landmarks in the control of place cells and head direction cells. *J. Neurophysiol.* **80**, 425–446 (1998).

[Article](https://doi.org/10.1152%2Fjn.1998.80.1.425) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK1czisFWgsQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Interactions%20between%20idiothetic%20cues%20and%20external%20landmarks%20in%20the%20control%20of%20place%20cells%20and%20head%20direction%20cells&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.1998.80.1.425&volume=80&pages=425-446&publication_year=1998&author=Knierim%2CJJ&author=Kudrimoti%2CHS&author=McNaughton%2CBL)

[^21]: Peyrache, A., Lacroix, M. M., Petersen, P. C. & Buzsáki, G. Internally organized mechanisms of the head direction sense. *Nat. Neurosci.* **18**, 569–575 (2015).

[Article](https://doi.org/10.1038%2Fnn.3968) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXjs1GqsLc%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Internally%20organized%20mechanisms%20of%20the%20head%20direction%20sense&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.3968&volume=18&pages=569-575&publication_year=2015&author=Peyrache%2CA&author=Lacroix%2CMM&author=Petersen%2CPC&author=Buzs%C3%A1ki%2CG)

[^22]: Chaudhuri, R., Gercek, B., Pandey, B. & Fiete, I. Unsupervised latent variable extraction from neural data to characterize processing across states. In *Computational and Systems Neuroscience (CoSyNe)* I-56 [http://cosyne.org/cosyne17/Cosyne2017\_program\_book.pdf](http://cosyne.org/cosyne17/Cosyne2017_program_book.pdf) (2017).

[^23]: Ghrist, R. Barcodes: the persistent topology of data. *Bull. Am. Math. Soc.* **45**, 61–75 (2008).

[Article](https://doi.org/10.1090%2FS0273-0979-07-01191-3) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Barcodes%3A%20the%20persistent%20topology%20of%20data&journal=Bull.%20Am.%20Math.%20Soc.&doi=10.1090%2FS0273-0979-07-01191-3&volume=45&pages=61-75&publication_year=2008&author=Ghrist%2CR)

[^24]: Grassberger, P. & Procaccia, I. Measuring the strangeness of strange attractors. *Phys. D.* **9**, 189–208 (1983).

[Article](https://doi.org/10.1016%2F0167-2789%2883%2990298-1) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Measuring%20the%20strangeness%20of%20strange%20attractors&journal=Phys.%20D.&doi=10.1016%2F0167-2789%2883%2990298-1&volume=9&pages=189-208&publication_year=1983&author=Grassberger%2CP&author=Procaccia%2CI)

[^25]: Chen, Z. & Wilson, M. A. Deciphering neural codes of memory during sleep. *Trends Neurosci.* **40**, 260–275 (2017).

[Article](https://doi.org/10.1016%2Fj.tins.2017.03.005) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Deciphering%20neural%20codes%20of%20memory%20during%20sleep&journal=Trends%20Neurosci.&doi=10.1016%2Fj.tins.2017.03.005&volume=40&pages=260-275&publication_year=2017&author=Chen%2CZ&author=Wilson%2CMA)

[^26]: Burak, Y. & Fiete, I. R. Fundamental limits on persistent activity in networks of noisy neurons. *Proc. Natl Acad. Sci. USA* **109**, 17645–17650 (2012).

[Article](https://doi.org/10.1073%2Fpnas.1117386109) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XhvVSltLbM) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Fundamental%20limits%20on%20persistent%20activity%20in%20networks%20of%20noisy%20neurons&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.1117386109&volume=109&pages=17645-17650&publication_year=2012&author=Burak%2CY&author=Fiete%2CIR)

[^27]: Moreno-Bote, R. et al. Information-limiting correlations. *Nat. Neurosci.* **17**, 1410–1417 (2014).

[Article](https://doi.org/10.1038%2Fnn.3807) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXhsFKms7jF) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Information-limiting%20correlations&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.3807&volume=17&pages=1410-1417&publication_year=2014&author=Moreno-Bote%2CR)

[^28]: Bialek, W. Physical limits to sensation and perception. *Annu. Rev. Biophys. Biophys. Chem.* **16**, 455–478 (1987).

[Article](https://doi.org/10.1146%2Fannurev.bb.16.060187.002323) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL2s3ktFyrtg%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Physical%20limits%20to%20sensation%20and%20perception&journal=Annu.%20Rev.%20Biophys.%20Biophys.%20Chem.&doi=10.1146%2Fannurev.bb.16.060187.002323&volume=16&pages=455-478&publication_year=1987&author=Bialek%2CW)

[^29]: Osborne, L. C., Lisberger, S. G. & Bialek, W. A sensory source for motor variation. *Nature* **437**, 412–416 (2005).

[Article](https://doi.org/10.1038%2Fnature03961) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2MXpvFOrt7g%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20sensory%20source%20for%20motor%20variation&journal=Nature&doi=10.1038%2Fnature03961&volume=437&pages=412-416&publication_year=2005&author=Osborne%2CLC&author=Lisberger%2CSG&author=Bialek%2CW)

[^30]: Pavlides, C. & Winson, J. Influences of hippocampal place cell firing in the awake state on the activity of these cells during subsequent sleep episodes. *J. Neurosci.* **9**, 2907–2918 (1989).

[Article](https://doi.org/10.1523%2FJNEUROSCI.09-08-02907.1989) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL1MzmtFKmug%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Influences%20of%20hippocampal%20place%20cell%20firing%20in%20the%20awake%20state%20on%20the%20activity%20of%20these%20cells%20during%20subsequent%20sleep%20episodes&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.09-08-02907.1989&volume=9&pages=2907-2918&publication_year=1989&author=Pavlides%2CC&author=Winson%2CJ)

[^31]: Lee, A. K. & Wilson, M. A. Memory of sequential experience in the hippocampus during slow wave sleep. *Neuron* **36**, 1183–1194 (2002).

[Article](https://doi.org/10.1016%2FS0896-6273%2802%2901096-6) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3sXhtVOnsw%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Memory%20of%20sequential%20experience%20in%20the%20hippocampus%20during%20slow%20wave%20sleep&journal=Neuron&doi=10.1016%2FS0896-6273%2802%2901096-6&volume=36&pages=1183-1194&publication_year=2002&author=Lee%2CAK&author=Wilson%2CMA)

[^32]: Diekelmann, S. & Born, J. The memory function of sleep. *Nat. Rev. Neurosci.* **11**, 114–126 (2010).

[Article](https://doi.org/10.1038%2Fnrn2762) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3cXktFKi) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20memory%20function%20of%20sleep&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn2762&volume=11&pages=114-126&publication_year=2010&author=Diekelmann%2CS&author=Born%2CJ)

[^33]: Brandon, M. P., Bogaard, A. R., Andrews, C. M. & Hasselmo, M. E. Head direction cells in the postsubiculum do not show replay of prior waking sequences during sleep. *Hippocampus* **22**, 604–618 (2012).

[Article](https://doi.org/10.1002%2Fhipo.20924) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Head%20direction%20cells%20in%20the%20postsubiculum%20do%20not%20show%20replay%20of%20prior%20waking%20sequences%20during%20sleep&journal=Hippocampus&doi=10.1002%2Fhipo.20924&volume=22&pages=604-618&publication_year=2012&author=Brandon%2CMP&author=Bogaard%2CAR&author=Andrews%2CCM&author=Hasselmo%2CME)

[^34]: Massimini, M. et al. Breakdown of cortical effective connectivity during sleep. *Science* **309**, 2228–2232 (2005).

[Article](https://doi.org/10.1126%2Fscience.1117256) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2MXhtVeksbbN) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Breakdown%20of%20cortical%20effective%20connectivity%20during%20sleep&journal=Science&doi=10.1126%2Fscience.1117256&volume=309&pages=2228-2232&publication_year=2005&author=Massimini%2CM)

[^35]: Steriade, M., McCormick, D. A. & Sejnowski, T. J. Thalamocortical oscillations in the sleeping and aroused brain. *Science* **262**, 679–685 (1993).

[Article](https://doi.org/10.1126%2Fscience.8235588) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK2c%2FltlOjsg%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Thalamocortical%20oscillations%20in%20the%20sleeping%20and%20aroused%20brain&journal=Science&doi=10.1126%2Fscience.8235588&volume=262&pages=679-685&publication_year=1993&author=Steriade%2CM&author=McCormick%2CDA&author=Sejnowski%2CTJ)

[^36]: Gardner, R. J., Lu, L., Wernle, T., Moser, M.-B. & Moser, E. I. Correlation structure of grid cells is preserved during sleep. *Nat. Neurosci.* **22**, 598–608 (2019).

[Article](https://doi.org/10.1038%2Fs41593-019-0360-0) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXotl2qtbc%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Correlation%20structure%20of%20grid%20cells%20is%20preserved%20during%20sleep&journal=Nat.%20Neurosci.&doi=10.1038%2Fs41593-019-0360-0&volume=22&pages=598-608&publication_year=2019&author=Gardner%2CRJ&author=Lu%2CL&author=Wernle%2CT&author=Moser%2CM-B&author=Moser%2CEI)

[^37]: Trettel, S. G., Trimper, J. B., Hwaun, E., Fiete, I. R. & Colgin, L. L. Grid cell co-activity patterns during sleep reflect spatial overlap of grid fields during active behaviors. *Nat. Neurosci.* **22**, 609–617 (2019).

[Article](https://doi.org/10.1038%2Fs41593-019-0359-6) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXotl2qtbk%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Grid%20cell%20co-activity%20patterns%20during%20sleep%20reflect%20spatial%20overlap%20of%20grid%20fields%20during%20active%20behaviors&journal=Nat.%20Neurosci.&doi=10.1038%2Fs41593-019-0359-6&volume=22&pages=609-617&publication_year=2019&author=Trettel%2CSG&author=Trimper%2CJB&author=Hwaun%2CE&author=Fiete%2CIR&author=Colgin%2CLL)

[^38]: Siapas, A. G. & Wilson, M. A. Coordinated interactions between hippocampal ripples and cortical spindles during slow-wave sleep. *Neuron* **21**, 1123–1128 (1998).

[Article](https://doi.org/10.1016%2FS0896-6273%2800%2980629-7) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK1cXotVSrtbs%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Coordinated%20interactions%20between%20hippocampal%20ripples%20and%20cortical%20spindles%20during%20slow-wave%20sleep&journal=Neuron&doi=10.1016%2FS0896-6273%2800%2980629-7&volume=21&pages=1123-1128&publication_year=1998&author=Siapas%2CAG&author=Wilson%2CMA)

[^39]: Wimmer, K., Nykamp, D. Q., Constantinidis, C. & Compte, A. Bump attractor dynamics in prefrontal cortex explains behavioral precision in spatial working memory. *Nat. Neurosci.* **17**, 431–439 (2014).

[Article](https://doi.org/10.1038%2Fnn.3645) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXhsF2qt70%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Bump%20attractor%20dynamics%20in%20prefrontal%20cortex%20explains%20behavioral%20precision%20in%20spatial%20working%20memory&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.3645&volume=17&pages=431-439&publication_year=2014&author=Wimmer%2CK&author=Nykamp%2CDQ&author=Constantinidis%2CC&author=Compte%2CA)

[^40]: Yoon, K. et al. Specific evidence of low-dimensional continuous attractor dynamics in grid cells. *Nat. Neurosci.* **16**, 1077–1084 (2013).

[Article](https://doi.org/10.1038%2Fnn.3450) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXhtFShsr%2FI) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Specific%20evidence%20of%20low-dimensional%20continuous%20attractor%20dynamics%20in%20grid%20cells&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.3450&volume=16&pages=1077-1084&publication_year=2013&author=Yoon%2CK)

[^41]: Low, R. J., Lewallen, S., Aronov, D., Nevers, R. & Tank, D. W. Probing variability in a cognitive map using manifold inference from neural dynamics. Preprint at *biorXiv* [https://www.biorxiv.org/content/10.1101/418939v2](https://www.biorxiv.org/content/10.1101/418939v2) (2018).

[^42]: Bassett, J. P., Wills, T. J. & Cacucci, F. Self-organised attractor dynamics in the developing head direction circuit. *Curr. Biol.* **28**, 609–615 (2018).

[Article](https://doi.org/10.1016%2Fj.cub.2018.01.010) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1cXisVaisbc%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Self-organised%20attractor%20dynamics%20in%20the%20developing%20head%20direction%20circuit&journal=Curr.%20Biol.&doi=10.1016%2Fj.cub.2018.01.010&volume=28&pages=609-615&publication_year=2018&author=Bassett%2CJP&author=Wills%2CTJ&author=Cacucci%2CF)

[^43]: Tenenbaum, J. B., De Silva, V. & Langford, J. C. A global geometric framework for nonlinear dimensionality reduction. *Science* **290**, 2319–2323 (2000).

[Article](https://doi.org/10.1126%2Fscience.290.5500.2319) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD3M%2Fnt1yitQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20global%20geometric%20framework%20for%20nonlinear%20dimensionality%20reduction&journal=Science&doi=10.1126%2Fscience.290.5500.2319&volume=290&pages=2319-2323&publication_year=2000&author=Tenenbaum%2CJB&author=Silva%2CV&author=Langford%2CJC)

[^44]: Curto, C. & Itskov, V. Cell groups reveal structure of stimulus space. *PLoS Comput. Biol.* **4**, e1000205 (2008).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1000205) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Cell%20groups%20reveal%20structure%20of%20stimulus%20space&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1000205&volume=4&publication_year=2008&author=Curto%2CC&author=Itskov%2CV)

[^45]: Dabaghian, Y., Mémoli, F., Frank, L. & Carlsson, G. A topological paradigm for hippocampal spatial map formation using persistent homology. *PLoS Comput. Biol.* **8**, e1002581 (2012).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1002581) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38Xht1Srs7fF) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20topological%20paradigm%20for%20hippocampal%20spatial%20map%20formation%20using%20persistent%20homology&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1002581&volume=8&publication_year=2012&author=Dabaghian%2CY&author=M%C3%A9moli%2CF&author=Frank%2CL&author=Carlsson%2CG)

[^46]: Singh, G. et al. Topological analysis of population activity in visual cortex. *J. Vis.* **8**, 1–18 (2008).

[Article](https://doi.org/10.1167%2F8.8.11) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Topological%20analysis%20of%20population%20activity%20in%20visual%20cortex&journal=J.%20Vis.&doi=10.1167%2F8.8.11&volume=8&pages=1-18&publication_year=2008&author=Singh%2CG)

[^47]: Spreemann, G., Dunn, B., Botnan, M. B. & Baas, N. A. Using persistent homology to reveal hidden information in neural data. Preprint at *arXiv* [https://arxiv.org/abs/1510.06629](https://arxiv.org/abs/1510.06629) (2015).

[^48]: Rybakken, E., Baas, N. & Dunn, B. Decoding of neural data using cohomological feature extraction. *Neural Comput.* **31**, 68–93 (2019).

[Article](https://doi.org/10.1162%2Fneco_a_01150) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Decoding%20of%20neural%20data%20using%20cohomological%20feature%20extraction&journal=Neural%20Comput.&doi=10.1162%2Fneco_a_01150&volume=31&pages=68-93&publication_year=2019&author=Rybakken%2CE&author=Baas%2CN&author=Dunn%2CB)

[^49]: Park, M. et al. Bayesian manifold learning: the locally linear latent variable model. *Adv. Neural Inf. Process. Syst.* **28**, 154–162 (2015).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Bayesian%20manifold%20learning%3A%20the%20locally%20linear%20latent%20variable%20model&journal=Adv.%20Neural%20Inf.%20Process.%20Syst.&volume=28&pages=154-162&publication_year=2015&author=Park%2CM)

[^50]: Rubin, A. et al. Revealing neural correlates of behavior without behavioral measurements. Preprint at *biorXiv* [https://www.biorxiv.org/content/10.1101/540195v1](https://www.biorxiv.org/content/10.1101/540195v1) (2019).

[^51]: Bauer, U., Tralie, C. & Saul, N. Ripser. *Github* [https://github.com/ctralie/ripser](https://github.com/ctralie/ripser) (2017).

[^52]: Knierim, J. J., Kudrimoti, H. S. & McNaughton, B. L. Place cells, head direction cells, and the learning of landmark stability. *J. Neurosci.* **15**, 1648–1659 (1995).

[Article](https://doi.org/10.1523%2FJNEUROSCI.15-03-01648.1995) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK2MXksVegurk%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Place%20cells%2C%20head%20direction%20cells%2C%20and%20the%20learning%20of%20landmark%20stability&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.15-03-01648.1995&volume=15&pages=1648-1659&publication_year=1995&author=Knierim%2CJJ&author=Kudrimoti%2CHS&author=McNaughton%2CBL)